"""Regression pins against the real ROM (skipped without baserom.gbc): the
numbers the generated source is known to have. A recognizer that quietly
stops matching, a union that stops resolving, a renderer that falls back to
db -- each moves one of these counts."""
import contextlib
import glob
import io
import json
import re
import subprocess
import sys
import unittest

from tests.helpers import BASEROM, ROOT, needs_rom

SRC = sorted((ROOT / "src").glob("bank_*.asm"))


def count(pattern):
    rx = re.compile(pattern, re.M)
    return sum(len(rx.findall(f.read_text())) for f in SRC)


@needs_rom
class GeneratedSource(unittest.TestCase):
    """What the committed src/ holds. These read the source as text, so they
    are cheap; regenerate before running if the inputs changed."""

    def test_idiom_macro_sites(self):
        self.assertEqual(count(r"^\tpush_wram_bank "), 351)
        self.assertEqual(count(r"^\tpop_wram_bank"), 452)
        self.assertEqual(count(r"^\tld_hl_indexed "), 414)
        self.assertEqual(count(r"^\twait_frames "), 79)
        self.assertEqual(count(r"^\tlb (de|bc|hl), "), 440)
        self.assertEqual(count(r"^\tadd LOW\("), 0, "no split-base index left raw")
        self.assertEqual(count(r"inline arg$"), 0)

    def test_named_ids(self):
        self.assertEqual(count(r"ld hl, Text_[0-9a-f]+_\d+ ;"), 205)
        self.assertEqual(count(r"^\tdw Text_[0-9a-f]+_\d+"), 606)
        self.assertEqual(count(r"^\tld de, \$[0-9a-f]{4} ; \$[0-9a-f]{4}\n\.clearLoop:\n\tpush de ; \$[0-9a-f]{4}\n\tcall ClearGameFlag "),
                         3, "only the three loop bases pass a raw game-flag id")
        self.assertEqual(count(r"^\tld de, \$[0-9a-f]{4} ; \$[0-9a-f]{4}\n\t(?:far)?call (Set|Clear|Test)GameFlag "),
                         0, "a raw game-flag id passed straight to a flag helper")

    def test_sound_ids_are_named(self):
        self.assertEqual(count(r"^\tsound \$"), 0)
        self.assertGreaterEqual(count(r"^\tsound (?:SFX|BGM)_"), 600)

    def test_vram_addresses_are_named(self):
        self.assertGreaterEqual(count(r"^\tld (?:de|hl|bc), v(?:Tiles[012]|BGMap[01])\b"), 700)
        self.assertLessEqual(count(r"^\tld (?:de|hl|bc), \$[89][0-9a-f]{3} ;"), 60)

    def test_copy_lengths_follow_their_blobs(self):
        self.assertEqual(count(r"^\tld c, \(\w+ - \w+\) / 16 ;"), 34)
        n = count(r"^\tld c, (\w+)_SIZE / 16 ;")
        self.assertGreaterEqual(n, 90)
        # every _SIZE constant used is INCLUDEd from the .inc beside its blob
        for f in SRC:
            text = f.read_text()
            used = set(re.findall(r"\bld c, (\w+)_SIZE / 16", text))
            have = set(re.findall(r'INCLUDE "data/bank_[0-9a-f]{3}/lz_(\w+)\.inc"', text))
            self.assertEqual(used - have, set(), f.name)
        self.assertGreaterEqual(count(r"^\tld c, \$[0-9a-f]{2} ; \$[0-9a-f]{4} -- \d+ of \w+'s \d+ tiles"), 25)

    def test_data_files_are_named_after_labels(self):
        lines = [l.split() for l in (ROOT / "data.manifest").read_text().splitlines()
                 if l.strip() and not l.startswith("#")]
        by_addr = sum(1 for f in lines if re.fullmatch(r"bank_[0-9a-f]{3}/(d|lz|text|\w+)_[0-9a-f]{4}\.\w+", f[0]))
        self.assertLess(by_addr, 700, "most data files carry their label's name")
        self.assertTrue(any(f[0] == "bank_040/AlexSpriteFrame00.bin" for f in lines))
        self.assertTrue(any(f[0].endswith("/lz_CutsceneAnimFrameLZ_00.bin") for f in lines))

    def test_structured_regions_render(self):
        # a spec whose renderer gives up falls back to `db` on its first line
        for spec in ("sprite_anim", "map_actors", "actor_script", "flag_ids"):
            self.assertEqual(count(rf"\({spec}\)\n\tdb "), 0, spec)

    def test_no_auto_names(self):
        for stem in ("Func_", "Label_", "Data_", "Lz_", "Fill_"):
            self.assertEqual(count(rf"^{stem}[0-9a-f_]+:"), 0, stem)

    def test_unused_routine_notes(self):
        # every Unused routine with a live twin carries the note that says so
        self.assertGreaterEqual(count(r"^; .*Nothing calls (it|this one|or jumps to it|this copy)\b"), 35)


@needs_rom
class Manifest(unittest.TestCase):
    def test_counts(self):
        lines = [l.split() for l in (ROOT / "data.manifest").read_text().splitlines()
                 if l.strip() and not l.startswith("#")]
        self.assertEqual(len(lines), 4218)
        self.assertEqual(sum(1 for f in lines if "/lz_" in f[0]), 839)
        specs = [f[3] for f in lines if len(f) > 3]
        self.assertEqual(sum(s.startswith("gfx") for s in specs), 2725)
        self.assertEqual(sum(s == "gfx:2x2" for s in specs), 570)
        self.assertEqual(sum(s == "gfx:3x4+3" for s in specs), 1650)
        self.assertEqual(sum(s == "gfx:4x4+4" for s in specs), 60)
        self.assertEqual(sum(1 for f in lines if len(f) > 3 and f[3].startswith("tilemap:") and f[0].endswith(".bin")), 213)


@needs_rom
class Analysis(unittest.TestCase):
    """The expensive pins: one analysis run for the class."""

    @classmethod
    def setUpClass(cls):
        from disasmlib import pipeline
        from disasmlib.config import load_label_overrides, load_offset_map
        from disasmlib.textids import text_id_load_sites
        rom = BASEROM.read_bytes()
        cls.overrides = load_label_overrides(str(ROOT / "labels.json"))
        with contextlib.redirect_stdout(io.StringIO()):
            cls.dis = pipeline.analyse(
                rom, sorted(glob.glob(str(ROOT / "coverage" / "*.json"))),
                cls.overrides, load_offset_map(str(ROOT / "data_tables.json")),
                sorted(glob.glob(str(ROOT / "hooks" / "*.json"))), descent=True)
        cls.text_sites = text_id_load_sites(cls.dis, cls.overrides)

    def test_instruction_count(self):
        self.assertEqual(len(self.dis.instrs), 160940)

    def test_text_id_sites(self):
        self.assertEqual(len(self.text_sites), 619)

    def test_every_curated_label_is_code_or_data_start(self):
        # a curated code label must sit on an instruction start, not inside one
        inside = [k for k in self.overrides
                  if int(k, 0) not in self.dis.instrs
                  and any(int(k, 0) - d in self.dis.instrs
                          and self.dis.instrs[int(k, 0) - d].size > d
                          for d in (1, 2))]
        self.assertEqual(inside, [], "labels inside instructions")


@needs_rom
class Tools(unittest.TestCase):
    def test_check_passes(self):
        r = subprocess.run([sys.executable, str(ROOT / "tools" / "check.py")],
                           capture_output=True, text=True, cwd=ROOT)
        self.assertEqual(r.returncode, 0, r.stdout + r.stderr)

    def test_ram_gaps_has_no_live_unproven(self):
        r = subprocess.run([sys.executable, str(ROOT / "tools" / "ram_gaps.py")],
                           capture_output=True, text=True, cwd=ROOT)
        self.assertIn("dead", r.stdout)
        self.assertNotIn("unproven", r.stdout, r.stdout)
        self.assertNotIn("unclaimed -- bank proved, needs a name (1", r.stdout)
        m = re.search(r"^(\d+) bare banked-WRAM operands", r.stdout, re.M)
        self.assertEqual(int(m.group(1)), 97)


if __name__ == "__main__":
    unittest.main()
