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
        self.assertEqual(count(r"^\tlb (de|bc|hl), "), 0, "a register pair written with lb instead of a named pair macro")
        self.assertEqual(count(r"^\tld_xy de, "), 169)
        self.assertEqual(count(r"^\tld_cell de, "), 160)
        self.assertEqual(count(r"^\tld_bg_pals de, "), 86)
        self.assertEqual(count(r"^\tld_obj_pals de, "), 71)
        self.assertEqual(count(r"^\tld_oam bc, "), 104)
        self.assertEqual(count(r"^\tld_size bc, "), 24)
        self.assertEqual(count(r"^\tld_tile_run bc, "), 63)
        # map positions are tiles with a point (map_pos), never raw 1/256-tile words
        self.assertEqual(count(r"^\t(?:map_entry|map_actor|script_move_target|script_set_position|script_move_player|as_set_target|as_set_pos) [^;\n]*\b\d+\.\d+"), 3055)
        self.assertEqual(count(r"^\t(?:map_entry \S+, \S+,|map_actor \S+, \S+,|script_move_target \S+,|script_set_position \S+,|script_move_player|as_set_target|as_set_pos) \$[0-9a-f]{4}\b"), 0)
        # register pairs loaded with two instructions, named by the split-pair macros
        for mac, n in (("rect_size", 198), ("rect_cell", 24), ("map_cell", 38), ("sprite_xy", 60),
                       ("sprite_attr_tile", 27), ("sprite_tile_attr", 82)):
            self.assertEqual(count(rf"^\t{mac} "), n, mac)
        # animation delays, scene-rect copies and relative moves read as numbers
        self.assertEqual(count(r"^\tanim_frame [^,\n]+, \$"), 0)
        self.assertEqual(count(r"^\tscript_copy_scene_rect \$"), 0)
        self.assertEqual(count(r"^\tas_target_rel \$"), 0)
        self.assertEqual(count(r"^\tscript_(?:set|player)_speed [^;\n]*\$[0-9a-f]{4}"), 0)
        self.assertEqual(count(r"^\tscript_move_angle [^;\n]*\$[0-9a-f]{4}"), 0)
        self.assertEqual(count(r"^\tscript_fade_in \$"), 0)
        # frame counts are decimal
        self.assertEqual(count(r"^\t(?:wait_frames|script_wait_frames|script_delay|as_wait) \$"), 0)
        # VRAM copies of whole tilemap rows count rows
        self.assertGreaterEqual(count(r"^\tld c, (?:\d+ \* |SCREEN_HEIGHT \* )?TILEMAP_(?:WIDTH|AREA) / 16"), 220)
        # an OAM attribute loaded alone for QueueSprite*: palette plus OAM_* flags
        self.assertGreaterEqual(count(r"^\tld b, (?:OAM_\w+ \| )*(?:OAM_\w+|[0-7])(?: ;|$)"), 42)
        self.assertEqual(count(r"^\tadd LOW\((?!ActorFieldTypeTable_04\))"), 0, "no split-base index left raw")
        self.assertEqual(count(r"inline arg$"), 0)
        self.assertEqual(count(r"^\tld_slot hl, "), 37)
        self.assertEqual(count(r"^\tobject_id "), 117)
        self.assertEqual(count(r"\(BANK\([\w.]+\) << 8\) \| LOW\("), 0, "a slot pair not written with ld_slot")

    def test_named_ids(self):
        self.assertEqual(count(r"ld hl, Text_[0-9a-f]+_\d+ ;"), 257)
        self.assertEqual(count(r"^\tdw Text_[0-9a-f]+_\d+"), 737)
        self.assertGreaterEqual(count(r"\bDRILLMSG_\w+"), 65)
        self.assertGreaterEqual(count(r"\bBEHAVIOR_\w+"), 43)
        self.assertEqual(count(r"^\tld de, \$[0-9a-f]{4} ; \$[0-9a-f]{4}\n(?:ENDC\n)?\.clearLoop:\n\tpush de ; \$[0-9a-f]{4}\n\tcall ClearGameFlag "),
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
        self.assertEqual(count(r"^\tld c, \((?!WRAMX_END|[whs][A-Z])\w+ - \w+\) / 16 ;"), 34)
        n = count(r"^\tld c, (\w+)_SIZE / 16 ;")
        self.assertGreaterEqual(n, 90)
        # every _SIZE constant used is INCLUDEd from the .inc beside its blob
        for name, text in SRC:
            used = set(re.findall(r"\bld c, (?![whs][A-Z]|(?:WRAMX|VRAM|CHAR_RECORD)_SIZE)(\w+)_SIZE / 16", text))
            have = set(re.findall(r'INCLUDE "data/bank_[0-9a-f]{3}/lz_(\w+)\.inc"', text))
            self.assertEqual(used - have, set(), name)
        self.assertGreaterEqual(count(r"^\tld c, \$[0-9a-f]{2} ; \$[0-9a-f]{4} -- \d+ of \w+'s \d+ tiles"), 25)

    def test_copy_lengths_follow_their_ram(self):
        # a copy or clear of one whole RAM object is written as its exported
        # size (ram.asm export_size); the screen, bank and record geometry
        # constants cover the copies of part of a larger buffer
        self.assertGreaterEqual(count(r"^\tld (?:bc|c), [whs][A-Z]\w*_SIZE\b"), 120)
        self.assertGreaterEqual(count(r"^\tld (?:bc|c), \(?(?:SCREEN_HEIGHT \* TILEMAP_WIDTH|\d \* TILEMAP_AREA|TILEMAP_AREA|WRAMX_SIZE|VRAM_SIZE|\d \* CHAR_RECORD_SIZE|CHAR_RECORD_SIZE|WRAMX_END - \w+|\d \* TILEMAP_WIDTH)\)?"), 45)

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
        self.assertEqual(sum(1 for f in lines if len(f) > 3 and f[3].startswith("tilemap:") and f[0].endswith(".bin")), 231)


@needs_rom
class Tools(unittest.TestCase):
    """check.py needs the ROM (its LZ streams) and a built symbol file."""

    def test_check_passes(self):
        if not (ROOT / "build" / "mariotennis.sym").exists():
            self.skipTest("build/mariotennis.sym not present: run make first")
        r = subprocess.run([sys.executable, str(ROOT / "tools" / "check.py")],
                           capture_output=True, text=True, cwd=ROOT)
        self.assertEqual(r.returncode, 0, r.stdout + r.stderr)
        # a tool that stops parsing part of the source passes vacuously: hold
        # the actor-slot resolver to the script sites it reaches today
        m = re.search(r"^slots\s+(\d+) checked", r.stdout, re.M)
        self.assertGreaterEqual(int(m.group(1)), 5122, "the slot resolver reaches fewer script sites")


if __name__ == "__main__":
    unittest.main()
