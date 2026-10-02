"""Regression pins on the source tree: the counts the disassembly is known
to have. They read `src/` as text and need no ROM. A pin here is a ratchet
on structure that the byte compare cannot see -- an idiom written out by
hand instead of through its macro, a raw sound id, a VRAM address as a bare
number -- and an edit that adds or removes code moves it on purpose."""
import re
import subprocess
import sys
import unittest

from tests.helpers import ROOT, needs_rom
from banksrc import bank_text, holders

# each bank as one text, its fragment files expanded in place
SRC = [(h.name, bank_text(h)) for h in holders()]


def count(pattern):
    rx = re.compile(pattern, re.M)
    return sum(len(rx.findall(text)) for _, text in SRC)


class Source(unittest.TestCase):
    """What the committed src/ holds."""

    def test_idiom_macro_sites(self):
        self.assertEqual(count(r"^\tpush_wram_bank "), 351)
        self.assertEqual(count(r"^\tpop_wram_bank"), 452)
        self.assertEqual(count(r"^\tld_hl_indexed "), 424)
        self.assertEqual(count(r"^\twait_frames "), 79)
        self.assertEqual(count(r"^\tlb (de|bc|hl), "), 335)
        self.assertEqual(count(r"^\tld_xy de, "), 163)
        self.assertEqual(count(r"^\tld_cell de, "), 44)
        self.assertEqual(count(r"^\tlb de, .*; \$[0-9a-f]{4} (x, y|y, x|column, row)$"), 0,
                         "a position written with lb instead of ld_xy/ld_cell")
        self.assertEqual(count(r"^\tadd LOW\((?!ActorFieldTypeTable_04\))"), 0, "no split-base index left raw")
        self.assertEqual(count(r"inline arg$"), 0)
        self.assertEqual(count(r"^\tld_slot hl, "), 37)
        self.assertEqual(count(r"^\tobject_id "), 117)
        self.assertEqual(count(r"\(BANK\([\w.]+\) << 8\) \| LOW\("), 0, "a slot pair not written with ld_slot")

    def test_named_ids(self):
        self.assertEqual(count(r"ld hl, Text_[0-9a-f]+_\d+ ;"), 257)
        self.assertEqual(count(r"^\tdw Text_[0-9a-f]+_\d+"), 628)
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
        for name, text in SRC:
            used = set(re.findall(r"\bld c, (\w+)_SIZE / 16", text))
            have = set(re.findall(r'INCLUDE "data/bank_[0-9a-f]{3}/lz_(\w+)\.inc"', text))
            self.assertEqual(used - have, set(), name)
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


class Manifest(unittest.TestCase):
    def test_counts(self):
        lines = [l.split() for l in (ROOT / "data.manifest").read_text().splitlines()
                 if l.strip() and not l.startswith("#")]
        self.assertEqual(len(lines), 4243)
        self.assertEqual(sum(1 for f in lines if "/lz_" in f[0]), 839)
        specs = [f[3] for f in lines if len(f) > 3]
        self.assertEqual(sum(s.startswith("gfx") for s in specs), 2728)
        self.assertEqual(sum(s == "gfx:2x2" for s in specs), 570)
        self.assertEqual(sum(s == "gfx:3x4+3" for s in specs), 1650)
        self.assertEqual(sum(s == "gfx:4x4+4" for s in specs), 60)
        self.assertEqual(sum(1 for f in lines if len(f) > 3 and f[3].startswith("tilemap:") and f[0].endswith(".bin")), 213)


@needs_rom
class Tools(unittest.TestCase):
    """check.py needs the ROM (its LZ streams) and a built symbol file."""

    def test_check_passes(self):
        if not (ROOT / "build" / "mariotennis.sym").exists():
            self.skipTest("build/mariotennis.sym not present: run make first")
        r = subprocess.run([sys.executable, str(ROOT / "tools" / "check.py")],
                           capture_output=True, text=True, cwd=ROOT)
        self.assertEqual(r.returncode, 0, r.stdout + r.stderr)


if __name__ == "__main__":
    unittest.main()
