"""Regression pins on the source tree: the counts the disassembly is known
to have. They read `src/` as text and need no ROM. A pin here is a ratchet
on structure that the byte compare cannot see -- an idiom written out by
hand instead of through its macro, a raw sound id, a VRAM address as a bare
number -- and an edit that adds or removes code moves it on purpose."""
import hashlib
import re
import subprocess
import sys
import unittest

from tests.helpers import ROOT, needs_rom
from banksrc import bank_text, holders

USA_SHA1 = "414ba58340a27fc27b127bc01455b32764151ff0"

# each bank as one text, its fragment files expanded in place
SRC = [(h.name, bank_text(h)) for h in holders()]


def count(pattern):
    rx = re.compile(pattern, re.M)
    return sum(len(rx.findall(text)) for _, text in SRC)


class Source(unittest.TestCase):
    """What the committed src/ holds."""

    def test_idiom_macro_sites(self):
        self.assertEqual(count(r"^\tpush_wram_bank "), 353)
        self.assertEqual(count(r"^\tpop_wram_bank"), 455)
        self.assertEqual(count(r"^\tld_hl_indexed "), 441)
        self.assertEqual(count(r"^\twait_frames "), 79)
        self.assertEqual(count(r"^\tld_story_char_field "), 114)
        self.assertEqual(count(r"^\tneg_(?:hl|de|bc)\b"), 146)
        self.assertEqual(count(r"^\tabs_(?:hl|de|bc)\b"), 85)
        self.assertEqual(count(r"^\tsub_hl_(?:de|bc)\b"), 116)
        self.assertEqual(count(r"^\tpush_rom_bank "), 13)
        self.assertEqual(count(r"^\tpop_rom_bank\b"), 20)
        self.assertEqual(count(r"^\tsram_bank\b"), 49)
        self.assertEqual(count(r"^\tjumptable\b"), 134)
        self.assertEqual(count(r"^\tframe_task "), 435)
        self.assertEqual(count(r"^\t(?:rst Rst00|call RegisterFrameTask|ldh \[h(?:Rom|Sram)Bank\], a)\b"), 0,
                         "a jump table, frame task or bank switch written out by hand")
        self.assertEqual(count(r"^\tlb (de|bc|hl), "), 0, "a register pair written with lb instead of a named pair macro")
        self.assertEqual(count(r"^\tld_xy de, "), 169)
        self.assertEqual(count(r"^\tld_cell de, "), 160)
        self.assertEqual(count(r"^\tld_bg_pals de, "), 86)
        self.assertEqual(count(r"^\tld_obj_pals de, "), 71)
        self.assertEqual(count(r"^\tld_oam bc, "), 104)
        self.assertEqual(count(r"^\tld_size bc, "), 24)
        self.assertEqual(count(r"^\tld_tile_run bc, "), 63)
        # map positions are tiles with a point (map_pos), never raw 1/256-tile words
        self.assertEqual(count(r"^\t(?:map_entry|map_actor|script_move_target|script_set_position|script_move_player|as_set_target|as_set_pos) [^;\n]*\b\d+\.\d+"), 3078)
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
        self.assertEqual(count(r"^\tscript_fade_out \$"), 0)
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
        self.assertEqual(count(r"ld hl, Text_\w+ ;"), 261)
        self.assertEqual(count(r"^\tdw Text_\w+"), 752)
        self.assertGreaterEqual(count(r"\bDRILLMSG_\w+"), 65)
        self.assertGreaterEqual(count(r"\bBEHAVIOR_\w+"), 43)
        self.assertEqual(count(r"^\tld de, \$[0-9a-f]{4} ; \$[0-9a-f]{4}\n(?:ENDC\n)?\.clearLoop:\n\tpush de ; \$[0-9a-f]{4}\n\tcall ClearGameFlag "),
                         3, "only the three loop bases pass a raw game-flag id")
        self.assertEqual(count(r"^\tld de, \$[0-9a-f]{4} ; \$[0-9a-f]{4}\n\t(?:far)?call (Set|Clear|Test)GameFlag "),
                         0, "a raw game-flag id passed straight to a flag helper")

    def test_entry_and_exit_ids_are_named(self):
        self.assertEqual(count(r"^\tld a, \$[0-9a-f]+ ;[^\n]*\n\tld \[wStoryModeEntryPoint\], a"), 0)
        self.assertEqual(count(r"^\tld a, \$[0-9a-f]+ ;[^\n]*\n\tld \[wUnusedExitTriggerIdMirror\], a"), 2,
                         "only the two exit ids with no ExitTriggers row stay raw")
        self.assertEqual(count(r"\bENTRY_\w+"), 306)
        self.assertEqual(count(r"\bEXIT_\w+"), 85)

    def test_sound_ids_are_named(self):
        self.assertEqual(count(r"^\tsound \$"), 0)
        self.assertGreaterEqual(count(r"^\tsound (?:SFX|BGM)_"), 600)

    def test_vram_addresses_are_named(self):
        self.assertGreaterEqual(count(r"^\tld (?:de|hl|bc), v(?:Tiles[012]|BGMap[01])\b"), 700)
        self.assertLessEqual(count(r"^\tld (?:de|hl|bc), \$[89][0-9a-f]{3} ;"), 60)

    def test_copy_lengths_follow_their_blobs(self):
        self.assertEqual(count(r"^\tld c, \((?!WRAMX_END|[whs][A-Z])\w+ - \w+\) / 16 ;"), 35)
        n = count(r"^\tld b?c, (\w+)_SIZE / 16 ;")
        self.assertGreaterEqual(n, 299)
        # every _SIZE constant used is INCLUDEd from the .inc beside its blob
        whole = (ROOT / "include" / "lz_sizes.inc").read_text() + "\n".join(text for _, text in SRC)
        used = set(re.findall(r"\bld b?c, (?![whs][A-Z]|(?:WRAMX|VRAM|CHAR_RECORD)_SIZE)(\w+)_SIZE / 16", whole))
        have = set(re.findall(r'INCLUDE "data/(?:\w+/)+lz_(\w+)\.inc"', whole))
        self.assertEqual(used - have, set())
        self.assertGreaterEqual(count(r"^\tld c, \d+ ; \$[0-9a-f]{4} -- \d+ of \w+'s \d+ tiles"), 38)
        # a VRAM copy's count is a size, a row count or a decimal tile count
        for name, text in SRC:
            lines = text.split("\n")
            for i, line in enumerate(lines):
                if not re.match(r"\tcall QueueVRAMCopy\b", line):
                    continue
                for prev in reversed(lines[max(0, i - 12):i]):
                    if re.match(r"[A-Za-z.]|\t(call|jp|jr|ret|farcall)\b", prev):
                        break
                    if re.match(r"\tld b?c, ", prev):
                        self.assertNotRegex(prev, r"\tld b?c, \$", name)
                        break

    def test_copy_lengths_follow_their_ram(self):
        # a copy or clear of one whole RAM object is written as its exported
        # size (ram.asm export_size); the screen, bank and record geometry
        # constants cover the copies of part of a larger buffer
        self.assertGreaterEqual(count(r"^\tld (?:bc|c), [whs][A-Z]\w*_SIZE\b"), 120)
        self.assertGreaterEqual(count(r"^\tld (?:bc|c), \(?(?:SCREEN_HEIGHT \* TILEMAP_WIDTH|\d \* TILEMAP_AREA|TILEMAP_AREA|WRAMX_SIZE|VRAM_SIZE|\d \* CHAR_RECORD_SIZE|CHAR_RECORD_SIZE|WRAMX_END - \w+|\d \* TILEMAP_WIDTH)\)?"), 45)

    def test_data_files_are_named_after_labels(self):
        lines = [l.split() for l in (ROOT / "data.manifest").read_text().splitlines()
                 if l.strip() and not l.startswith("#")]
        by_addr = sum(1 for f in lines if re.fullmatch(r"(?:\w+/)*(d|lz|text|\w+)_[0-9a-f]{4}\.\w+", f[0]))
        self.assertLess(by_addr, 700, "most data files carry their label's name")
        self.assertTrue(any(f[0] == "sprites/AlexSpriteFrame00.bin" for f in lines))
        self.assertTrue(any(f[0].endswith("/lz_CutsceneAnimFrameLZ_00.bin") for f in lines))

    def test_structured_regions_render(self):
        # a spec whose renderer gives up falls back to `db` on its first line
        for spec in ("sprite_anim", "map_actors", "actor_script", "flag_ids"):
            self.assertEqual(count(rf"\({spec}\)\n\tdb "), 0, spec)

    def test_no_auto_names(self):
        for stem in ("Func_", "Label_", "Data_", "Lz_", "Fill_"):
            self.assertEqual(count(rf"^{stem}[0-9a-f_]+:"), 0, stem)
        self.assertEqual(count(r"^Unclassified_\w*:"), 0)
        self.assertEqual(count(r"^Unused_[0-9a-f]{2}_\d+:"), 0, "an Unused label named by number")

    def test_doc_figures(self):
        """The Unused and twin counts the docs quote, computed from src/."""
        import reach
        g = reach.graph()
        unused = {n for n in g.labels if n.startswith("Unused")}
        routines = len(unused & g.routines())
        blobs = len(unused) - routines
        files = len(list((ROOT / "src" / "twins").glob("*.asm")))
        copies = sum(len(re.findall(r"^\ttwin\w* ", f.read_text(), re.M))
                     for f in (ROOT / "src").rglob("*.asm") if "twins" not in f.parts)
        for doc, quote in (
                ("README.md", f"| `Unused_` routines | {routines} routines and {blobs} blobs "),
                ("README.md", f"one of {files} shared files under `src/twins/` ({copies} copies"),
                ("docs/STATUS.md", f"the {routines} routines and {blobs} blobs "),
                ("docs/unused_code.md", f"{len(unused)} labels carry an `Unused` prefix: {routines} routines "
                                        f"and {blobs} data blobs."),
                ("docs/unused_code.md", f"the {blobs} unused blobs")):
            self.assertIn(quote, (ROOT / doc).read_text(), doc)

    def test_doc_drifting_figures(self):
        """Counts docs quote that edits elsewhere keep moving."""
        def text(doc):
            return re.sub(r"\s+", " ", (ROOT / doc).read_text())
        sys.path.insert(0, str(ROOT / "tools"))
        import ram_free
        ranges = ram_free.free_ranges()
        hram = [r for r in ranges if r[0] == "h"]
        self.assertIn(f"**Totals: {sum(e - s for _, _, s, e in ranges):,} free bytes in "
                      f"{len(ranges)} ranges, {sum(e - s for _, _, s, e in hram)} of them HRAM "
                      f"bytes in {len(hram)} ranges", text("docs/ram_map.md"))
        regions = {k: count(rf"^\t; \$[0-9a-f]+, \d+ bytes \({k}\)$")
                   + count(rf"^\t\w+ \".*\" ; \$[0-9a-f]+, \d+ bytes \({k}\)$")
                   for k in ("sprite_template", "actor_script")}
        self.assertIn(f"e.g. {regions['sprite_template']} `sprite_template` and "
                      f"{regions['actor_script']} `actor_script` regions",
                      text("docs/graphics_formats.md"))
        twins = {}
        for src in (ROOT / "src").rglob("*.asm"):
            for f, name in re.findall(r"^\ttwin\w* (\w+), (\w+)", src.read_text(), re.M):
                twins.setdefault(f, []).append(name)
        dead = sorted(f for f, names in twins.items() if all(n.startswith("Unused") for n in names))
        m = re.search(r"included too\. (.*?) have no live copy at all", text("docs/duplicated_code.md"))
        self.assertEqual(sorted(re.findall(r"`(\w+)`", m.group(1))), dead)
        flags = len(re.findall(r"^def FLAG_\w+\s+equ", (ROOT / "include" / "flag_constants.inc").read_text(), re.M))
        saveflags = sum(len(re.findall(r"^def SAVEFLAG_\w+\s+equ", f.read_text(), re.M))
                        for f in (ROOT / "include" / "constants").glob("*.inc"))
        self.assertIn(f"| names | {flags} `FLAG_*` in `include/flag_constants.inc` | {saveflags} `SAVEFLAG_*` ",
                      (ROOT / "docs" / "story_mode.md").read_text())

    def test_mirrored_char_struct(self):
        """ram_mirrored.inc's untagged $df00 names sit where match_char_struct
        puts each bank's tagged copy, and name the same fields."""
        sym = ROOT / "build" / "mariotennis.sym"
        if not sym.exists():
            self.skipTest("build/mariotennis.sym not present: run make first")
        tagged = {}
        for line in sym.read_text().splitlines():
            m = re.match(r"0([4-7]):([0-9a-f]{4}) w\1(\w+)$", line)
            if m:
                tagged.setdefault(m.group(3), set()).add((m.group(1), int(m.group(2), 16)))
        for name, sites in tagged.items():
            self.assertEqual({b for b, _ in sites}, set("4567"), name)
            self.assertEqual(len({a for _, a in sites}), 1, name)
        inc = (ROOT / "include" / "ram_mirrored.inc").read_text()
        block = inc[inc.index("; $df00-$df96"):inc.index("; The game progress screen")]
        untagged = {n: int(a, 16) for n, a in re.findall(r"^def w(\w+) equ \$([0-9a-f]+)$", block, re.M)}
        self.assertEqual(untagged, {n: min(sites)[1] for n, sites in tagged.items()})

    def test_unused_routine_notes(self):
        # every Unused routine with a live twin carries the note that says so
        self.assertGreaterEqual(count(r"^; .*Nothing calls (it|this one|or jumps to it|this copy)\b"), 35)


class Manifest(unittest.TestCase):
    def test_counts(self):
        lines = [l.split() for l in (ROOT / "data.manifest").read_text().splitlines()
                 if l.strip() and not l.startswith("#")]
        self.assertEqual(len(lines), 4276)
        streams = sum(1 for f in lines if "/lz_" in f[0])
        self.assertEqual(streams, 863)
        self.assertIn(f"round-tripping all {streams} streams", (ROOT / "tools" / "lz.py").read_text())
        specs = [f[3] for f in lines if len(f) > 3]
        self.assertEqual(sum(s.startswith("gfx") for s in specs), 2905)
        self.assertEqual(sum(s == "gfx:2x2" for s in specs), 570)
        self.assertEqual(sum(s == "gfx:3x4+3" for s in specs), 1620)
        self.assertEqual(sum(s == "gfx:4x4+4" for s in specs), 60)
        self.assertEqual(sum(s == "gfx:4x4" for s in specs), 4)
        self.assertEqual(sum(1 for f in lines if len(f) > 3 and f[3].startswith("tilemap:") and f[0].endswith(".bin")), 241)
        for spec, n in (("target_script", 57), ("move_curve", 16), ("frame_place", 30),
                        ("scoreboard_columns", 32), ("scene_config", 21), ("blit_runs", 84)):
            self.assertEqual(specs.count(spec), n, spec)
        self.assertEqual(sum(1 for f in lines if f[0].endswith(".asm")), 1028)


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
        self.assertGreaterEqual(int(m.group(1)), 5124, "the slot resolver reaches fewer script sites")

    def test_doc_counts(self):
        """README and STATUS quote tools/stats.py; rerun it and update them."""
        rom = ROOT / "mariotennis.gbc"
        if not rom.exists() or hashlib.sha1(rom.read_bytes()).hexdigest() != USA_SHA1:
            self.skipTest("the figures are the byte-perfect USA build's: run make on an unedited tree")
        import stats
        rom, ram = stats.labels()
        instrs, incbin, fill = stats.source()
        _, spelled = stats.rom_bytes(incbin, fill)
        total = sum(rom.values()) + sum(ram.values())
        readme = (ROOT / "README.md").read_text()
        status = (ROOT / "docs" / "STATUS.md").read_text()
        for doc, text, quotes in (
                ("README.md", readme, [
                    f"| instructions | {instrs:,} ",
                    f"| source-spelled bytes | {spelled:,} bytes, {100 * spelled / stats.ROM_SIZE:.1f}% ",
                    f"| labels | {total:,}: {rom['global']:,} routines and tables and {rom['local']:,} locals in ROM, "
                    f"{ram['global']:,} RAM names |"]),
                ("docs/STATUS.md", status, [
                    f"| instruction and code-macro lines | {instrs:,} |",
                    f"| source-spelled bytes (`tools/stats.py`) | {spelled:,}, {100 * spelled / stats.ROM_SIZE:.1f}% ",
                    f"| labels | {total:,}: ROM {rom['global']:,} global + {rom['local']:,} local, RAM {ram['global']:,};"])):
            for quote in quotes:
                self.assertTrue(quote in text, f"{doc} does not say {quote!r}")


if __name__ == "__main__":
    unittest.main()
