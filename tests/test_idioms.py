"""The text-level passes of the emitter and the naming helpers, on
synthetic input: they must collapse exactly the sequences they claim and
leave everything else alone."""
import unittest

from tests.helpers import ROOT  # noqa: F401  (sets sys.path)

from disasmlib.idioms import collapse_line_idioms, render_packed_args
from disasmlib.emit import is_gfx_name
from disasmlib.textids import text_id_name


def L(*texts):
    """Instruction lines with fake ascending addresses."""
    return [f"\t{t} ; ${0x4000 + i:04x}" for i, t in enumerate(texts)]


class CollapseIdioms(unittest.TestCase):
    def test_bank_prologue_and_epilogue(self):
        lines = L("ldh a, [hWramBank]", "push af", "wram_bank $06", "xor a",
                  "pop af", "wram_bank", "ret")
        collapse_line_idioms(lines)
        self.assertEqual([l.split(" ;")[0] for l in lines],
                         ["\tpush_wram_bank $06", "\txor a", "\tpop_wram_bank", "\tret"])
        self.assertTrue(lines[0].endswith("; $4000"), "macro keeps the first address")

    def test_label_inside_sequence_keeps_it_raw(self):
        lines = L("ldh a, [hWramBank]", "push af") + [".entry:"] + L("wram_bank $06")
        before = list(lines)
        collapse_line_idioms(lines)
        self.assertEqual(lines, before)

    def test_split_base_index(self):
        lines = L("add LOW(SomeTable + 3)", "ld l, a", "adc HIGH(SomeTable + 3)",
                  "sub l", "ld h, a", "ld a, [hl]")
        collapse_line_idioms(lines)
        self.assertEqual(lines[0].split(" ;")[0], "\tld_hl_indexed SomeTable + 3")
        self.assertEqual(len(lines), 2)

    def test_split_base_mismatch_stays(self):
        lines = L("add LOW(A)", "ld l, a", "adc HIGH(B)", "sub l", "ld h, a")
        before = list(lines)
        collapse_line_idioms(lines)
        self.assertEqual(lines, before)


class PackedArgs(unittest.TestCase):
    FLAGS = {47: "FLAG_DOUBLES", 184: "FLAG_ENDING_SEEN_DOUBLES"}

    def test_palette_pair(self):
        lines = L("ld de, $0206", "call LoadPaletteShadow")
        render_packed_args(lines, self.FLAGS)
        self.assertEqual(lines[0], "\tlb de, $02, $06 ; $4000 palette index, count")

    def test_only_the_callee_that_reads_bytes(self):
        lines = L("ld de, $0206", "call QueueVRAMCopy")
        before = list(lines)
        render_packed_args(lines, self.FLAGS)
        self.assertEqual(lines, before)

    def test_intervening_reload_blocks(self):
        lines = L("ld de, $0206", "ld d, $00", "call LoadPaletteShadow")
        before = list(lines)
        render_packed_args(lines, self.FLAGS)
        self.assertEqual(lines, before)

    def test_flag_forms(self):
        lines = L("ld de, $1700", "call SetGameFlag", "ld de, $002f",
                  "call TestGameFlagByNumber", "ld de, $1720", "call SetGameFlag")
        render_packed_args(lines, self.FLAGS)
        self.assertEqual(lines[0].split(" ;")[0], "\tld_flag_id de, FLAG_ENDING_SEEN_DOUBLES")
        self.assertEqual(lines[2].split(" ;")[0], "\tld de, FLAG_DOUBLES")
        self.assertTrue(lines[4].startswith("\tld de, $1720"), "unnamed flag stays raw")

    def test_named_operand_untouched(self):
        lines = L("ld de, wSomething", "call LoadPaletteShadow")
        before = list(lines)
        render_packed_args(lines, self.FLAGS)
        self.assertEqual(lines, before)


class Naming(unittest.TestCase):
    def test_text_id_decoding(self):
        self.assertEqual(text_id_name(0x10d7), "Text_34_215")
        self.assertEqual(text_id_name(0x0c0c), "Text_33_12")
        self.assertIsNone(text_id_name(0))
        self.assertIsNone(text_id_name(0x8001), "bit 15 is the SRAM-string flag")

    def test_gfx_classifier(self):
        for yes in ("AlexSpriteFrame07", "CourtDiagramTiles", "CharRosterIcon00",
                    "MenuFontTiles_01", "WalkSprite_70_00_Gfx03", "FontGlyphs"):
            self.assertTrue(is_gfx_name(yes), yes)
        for no in ("CourtDiagramTilemap", "GrassCourtAttrmap", "StarPatternBgCollisionMap",
                   "ServeGfxPtrTable_09", "Sfx01_Trk0", "AlexSpriteOam",
                   "ClubhouseSceneConfig", "WalkSprite_70_00_Anim03", ""):
            self.assertFalse(is_gfx_name(no), no)


if __name__ == "__main__":
    unittest.main()
