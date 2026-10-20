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
        self.assertEqual(count(r"^\tpush_wram_bank "), 353)
        self.assertEqual(count(r"^\tpop_wram_bank"), 455)
        self.assertEqual(count(r"^\tld_hl_indexed "), 442)
        self.assertEqual(count(r"^\twait_frames "), 80)
        self.assertEqual(count(r"^\tld_story_char_field "), 114)
        self.assertEqual(count(r"^\tneg_(?:hl|de|bc)\b"), 146)
        self.assertEqual(count(r"^\tabs_(?:hl|de|bc)\b"), 85)
        self.assertEqual(count(r"^\tsub_hl_(?:de|bc)\b"), 116)
        self.assertEqual(count(r"^\tpush_rom_bank "), 13)
        self.assertEqual(count(r"^\tpop_rom_bank\b"), 20)
        self.assertEqual(count(r"^\tsram_bank\b"), 49)
        self.assertEqual(count(r"^\tjumptable\b"), 134)
        self.assertEqual(count(r"^\tframe_task "), 436)
        self.assertEqual(count(r"^\t(?:rst Rst00|call RegisterFrameTask|ldh \[h(?:Rom|Sram)Bank\], a)\b"), 0,
                         "a jump table, frame task or bank switch written out by hand")
        self.assertEqual(count(r"^\tlb (de|bc|hl), "), 0, "a register pair written with lb instead of a named pair macro")
        self.assertEqual(count(r"^\tld_xy de, "), 169)
        self.assertEqual(count(r"^\tld_cell de, "), 161)
        self.assertEqual(count(r"^\tld_bg_pals de, "), 86)
        self.assertEqual(count(r"^\tld_obj_pals de, "), 74)
        self.assertEqual(count(r"^\tld_oam bc, "), 104)
        self.assertEqual(count(r"^\tld_size bc, "), 28)
        self.assertEqual(count(r"^\tld_tile_run bc, "), 63)
        self.assertEqual(count(r"^\tld_bg_cell bc, "), 2)
        self.assertEqual(count(r"^\tld_text_attr bc, "), 30)
        self.assertEqual(count(r"^\tld bc, \$[0-9a-f]{4}\b[^\n]*\n(?:\t(?!ld bc|ld_|(?:far)?call |jp |jr |ret)[^\n]*\n)*"
                               r"\t(?:far)?call (?:WriteTextToTilemap|FetchAndDrawDialogueText)\b"), 0,
                         "WriteTextToTilemap's attribute and stride loaded as one raw word -- ld_text_attr")
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
        self.assertEqual(count(r"^\tas_move_by \$"), 0)
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
        self.assertEqual(count(r"^\tadd LOW\((?!ActorFieldTypeTable_04\)|rAUD)"), 0, "no split-base index left raw")
        self.assertEqual(count(r"inline arg$"), 0)
        self.assertEqual(count(r"^\tld_slot hl, "), 38)
        self.assertEqual(count(r"^\tobject_id "), 117)
        self.assertEqual(count(r"\(BANK\([\w.]+\) << 8\) \| LOW\("), 0, "a slot pair not written with ld_slot")

    def test_named_ids(self):
        self.assertEqual(count(r"ld hl, Text_\w+ ;"), 273)
        self.assertEqual(count(r"^\tdw Text_\w+"), 820)
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
        # VRAM bank 1 is written as v* + VRAM_BANK1, SRAM as an s* symbol
        self.assertEqual(count(r"^\t(?:ld (?:de|hl|bc),|dw) \$[ab][0-9a-f]{3}\b"), 0)

    def test_copy_lengths_follow_their_blobs(self):
        self.assertEqual(count(r"^\tld c, \((?!WRAMX_END|[whs][A-Z])\w+ - \w+\) / 16 ;"), 37)
        n = count(r"^\tld b?c, (\w+)_SIZE / 16 ;")
        self.assertGreaterEqual(n, 299)
        # every _SIZE constant used is INCLUDEd from the .inc beside its blob
        whole = (ROOT / "include" / "lz_sizes.inc").read_text() + "\n".join(text for _, text in SRC)
        used = set(re.findall(r"\bld b?c, (?![whs][A-Z]|(?:WRAMX|VRAM|CHAR_RECORD)_SIZE)(\w+)_SIZE / 16", whole))
        have = set(re.findall(r'INCLUDE "data/(?:\w+/)+lz_(\w+)\.inc"', whole))
        self.assertEqual(used - have, set())
        self.assertGreaterEqual(count(r"^\tld c, \d+ ; \$[0-9a-f]{4} -- \d+ of \w+'s \d+ tiles"), 38)
        # a VRAM copy's count is a size, a row count or a decimal tile count;
        # a decimal count reading past its ROM source is a label span or
        # carries a note naming the source's own tile count
        size = {lab: int(n) for _, text in SRC for lab, n in re.findall(
            r"^(\w+):\n(?:\t;[^\n]*\n)?\t[^\n]*; \$[0-9a-f]{4}, (\d+) bytes", text, re.M)}
        for name, text in SRC:
            lines = text.split("\n")
            for i, line in enumerate(lines):
                if not re.match(r"\tcall QueueVRAMCopy\b", line):
                    continue
                n = None
                for prev in reversed(lines[max(0, i - 12):i]):
                    if re.match(r"[A-Za-z.]|\t(call|jp|jr|ret|farcall)\b", prev):
                        break
                    if n is None and re.match(r"\tld b?c, ", prev):
                        self.assertNotRegex(prev, r"\tld b?c, \$", name)
                        n = prev
                    src = re.match(r"\tld hl, (\w+) ;", prev)
                    if n and src:
                        c = re.match(r"\tld c, (\d+) ;", n)
                        tiles = size.get(src[1], 1 << 20) // 16
                        if c and int(c[1]) > tiles:
                            self.assertIn(f"-- {src[1]}'s {tiles} tiles", n, name)
                        break

    # destinations a decompression may run past, the bytes it may fill, why
    DECOMP_OVERRUNS = {
        "wDecompBuffer": (4096, "the staging half before wDecompBufferHigh: a 4096-byte "
                                "tile set fills both and is queued to VRAM as two halves"),
    }

    @needs_rom
    def test_decompressions_fit_their_ram(self):
        # a named LZ stream decompressed to a RAM label fits the label's
        # declared size, unless the `ld de` line carries a `-- note`
        import lz
        rom = (ROOT / "baserom.gbc").read_bytes()
        decoded = {}
        for line in (ROOT / "data.manifest").read_text().splitlines():
            f = line.split()
            if len(f) >= 3 and "/lz_" in f[0]:
                off = int(f[1], 16)
                decoded[f[0].rsplit("/lz_", 1)[1][:-4]] = len(lz.decompress(rom, off, off + int(f[2], 16))[0])
        size = {lab: int(n) for p in (ROOT / "ram").rglob("*.asm")
                for lab, n in re.findall(r"^(\w+):: ds (\d+)\b", p.read_text(), re.M)}
        size.update((lab, int(n)) for n, lab in re.findall(
            r"^; \[(\d+) bytes\].*\n(?:;.*\n)*def (\w+) equ", (ROOT / "include" / "ram_mirrored.inc").read_text(), re.M))
        ptr = dict(m for _, text in SRC for m in re.findall(r"^(DataPtr_\w+):\n\tdw (\w+)", text, re.M))
        checked, over = 0, set()
        for name, text in SRC:
            lines = text.split("\n")
            for i, line in enumerate(lines):
                if not re.match(r"\t(call|farcall|jp) DecompressData", line):
                    continue
                stream = de = None
                for prev in reversed(lines[max(0, i - 8):i]):
                    if re.match(r"[A-Za-z.]|\t(call|jp|jr|ret|farcall)\b", prev):
                        break
                    if de is None and (m := re.match(r"\tld de, (w\w+)([^;]*?) ;", prev)):
                        de = m[1], m[2], prev
                    if stream is None and (m := re.match(r"\tld(?:_slot)? hl, (\w+) ;", prev)):
                        stream = ptr.get(m[1], m[1])
                if stream not in decoded or de is None:
                    continue
                label, offset, ld = de
                self.assertIn(label, size, ld)
                checked += 1
                end = decoded[stream] + eval(offset.replace("tile", "+ 16 *").replace("TILEMAP_AREA", "1024")
                                             .replace("TILEMAP_WIDTH", "32")
                                             .replace("RESULTS_PANEL_ATTRS", "200").replace("$", "0x") or "0")
                if end <= size[label] or " -- " in ld:
                    continue
                self.assertIn(label, self.DECOMP_OVERRUNS, f"{name}: {stream} ({decoded[stream]} bytes) "
                              f"overruns {label} ({size[label]}): {ld.strip()}")
                self.assertLessEqual(end, self.DECOMP_OVERRUNS[label][0], ld)
                over.add(label)
        self.assertGreaterEqual(checked, 220)
        self.assertEqual(over, set(self.DECOMP_OVERRUNS))

    def test_palette_loads_fit_their_block(self):
        # `ld hl, Palettes` up to three lines before `ld_bg_pals` /
        # `ld_obj_pals de, first, n` reads n * 8 bytes: they fit the palettes region, or the load line
        # carries a `-- note`
        size = {}
        for line in (ROOT / "data.manifest").read_text().splitlines():
            f = line.split()
            if len(f) >= 4 and f[3] == "palettes":
                size[f[0].rsplit("/", 1)[1].rsplit(".", 1)[0]] = int(f[2], 16)
        checked, noted = 0, []
        for name, text in SRC:
            lines = text.split("\n")
            for i, line in enumerate(lines):
                m = re.match(r"\tld_(?:bg|obj)_pals de, [^,]+, ([^;]+?) ;", line)
                if not m:
                    continue
                prev = None
                for back in reversed(lines[i - 3:i]):
                    if re.match(r"[A-Za-z.]|\t(call|farcall|jp|jr|ret)\b|\tld_?\w* hl\b", back):
                        prev = re.match(r"\tld hl, (\w+) ;", back)
                        break
                if not prev or prev[1] not in size:
                    continue
                checked += 1
                if " -- " in line:
                    noted.append(prev[1])
                    continue
                self.assertLessEqual(8 * int(m[1]), size[prev[1]], f"{name}: {prev[1]}: {line.strip()}")
        self.assertGreaterEqual(checked, 112)
        self.assertEqual(sorted(noted), ["TennisDictionaryPalettes", "WaterSpriteHudPalette_15"])

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
        self.assertTrue(any(f[0].endswith("/lz_EpilogueEndLetterE_0.bin") for f in lines))

    def test_structured_regions_render(self):
        # a spec whose renderer gives up falls back to `db` on its first line
        for spec in ("sprite_anim", "map_actors", "actor_script", "flag_ids"):
            self.assertEqual(count(rf"\({spec}\)\n\tdb "), 0, spec)

    def test_no_auto_names(self):
        for stem in ("Func_", "Label_", "Data_", "Lz_", "Fill_"):
            self.assertEqual(count(rf"^{stem}[0-9a-f_]+:"), 0, stem)
        self.assertEqual(count(r"^Unclassified_\w*:"), 0)
        self.assertEqual(count(r"^Unused_[0-9a-f]{2}_\d+:"), 0, "an Unused label named by number")

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
        self.assertEqual(len(lines), 4275)
        streams = sum(1 for f in lines if "/lz_" in f[0])
        self.assertEqual(streams, 863)
        specs = [f[3] for f in lines if len(f) > 3]
        self.assertEqual(sum(s.startswith("gfx") for s in specs), 2897)
        self.assertEqual(sum(s == "gfx:2x2" for s in specs), 570)
        self.assertEqual(sum(s == "gfx:3x4+3" for s in specs), 1620)
        self.assertEqual(sum(s == "gfx:4x4+4" for s in specs), 60)
        self.assertEqual(sum(s == "gfx:4x4" for s in specs), 4)
        self.assertEqual(sum(1 for f in lines if len(f) > 3 and f[3].startswith("tilemap:") and f[0].endswith(".bin")), 297)
        for spec, n in (("target_script", 57), ("move_curve", 16), ("frame_place", 30),
                        ("scoreboard_columns", 32), ("scene_config", 21), ("blit_runs", 84)):
            self.assertEqual(specs.count(spec), n, spec)
        self.assertEqual(sum(1 for f in lines if f[0].endswith(".asm")), 1027)


@needs_rom
class Tools(unittest.TestCase):
    """check.py needs the ROM (its LZ streams) and a built symbol file."""

    def test_check_passes(self):
        if not (ROOT / "build" / "mariotennis.sym").exists():
            self.skipTest("build/mariotennis.sym not present: run make first")
        r = subprocess.run([sys.executable, str(ROOT / "tools" / "check.py")],
                           capture_output=True, text=True, cwd=ROOT)
        self.assertEqual(r.returncode, 0, r.stdout + r.stderr)
        # a check that stops parsing part of the source passes vacuously: every
        # one must check something, the source-parsing ones near today's count
        checked = {k: int(n) for k, n in re.findall(r"^(\S+)\s+(\d+) checked", r.stdout, re.M)}
        skipped = set(re.findall(r"^(\S+)\s+skipped:", r.stdout, re.M))
        floors = {"scopes": 260, "labels": 13500, "branches": 12, "literals": 33000, "dma": 50,
                  "reach": 4800, "unnamed": 8700, "raw-ids": 4500, "macros": 210, "slots": 5460,
                  "fields": 440}
        self.assertLessEqual(set(floors) - skipped, set(checked), r.stdout)
        for name, n in checked.items():
            self.assertGreaterEqual(n, floors.get(name, 1), f"{name} checks fewer sites")


if __name__ == "__main__":
    unittest.main()
