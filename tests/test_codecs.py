"""The byte-level codecs: the LZ format, the tile images, the SM83 decoder,
and the macro expansions -- each must reproduce its input exactly."""
import os
import subprocess
import sys
import random
import tempfile
import unittest
from pathlib import Path

from tests.helpers import BASEROM, ROOT, TOOLS, assemble, needs_rgbasm, needs_rom

import lz


class LzRoundTrip(unittest.TestCase):
    def check(self, data):
        stream = lz.compress(data)
        back, used = lz.decompress(stream, 0)
        self.assertEqual(back, data)
        self.assertEqual(used, len(stream), "decoder must consume the whole stream")

    def test_runs_and_literals(self):
        self.check(b"")
        self.check(b"\x00" * 4096)
        self.check(bytes(range(256)) * 4)
        self.check(b"abcabcabcabc" * 100 + b"tail")

    def test_random(self):
        rng = random.Random(1)
        for n in (1, 17, 300, 2048, 5000):
            self.check(bytes(rng.getrandbits(8) for _ in range(n)))
        # mostly repetitive data, the shape graphics have
        pool = bytes(rng.getrandbits(8) for _ in range(64))
        self.check(b"".join(pool[i:i + 8] for i in
                            (rng.randrange(56) for _ in range(800))))

    def test_truncated_stream_raises(self):
        stream = lz.compress(bytes(range(200)) * 3)
        with self.assertRaises(ValueError):
            lz.decompress(stream[:-3], 0, len(stream) - 3)

    @needs_rom
    def test_reencodes_rom_streams_exactly(self):
        """compress() is the original encoder: a real stream's decoded data
        encodes back to the stream itself, pad byte included."""
        rom = BASEROM.read_bytes()
        streams = []
        for line in (ROOT / "data.manifest").read_text().splitlines():
            f = line.split()
            if f and "/lz_" in f[0]:
                streams.append((f[0], int(f[1], 16), int(f[2], 16)))
        longest = max(streams, key=lambda t: t[2])
        for path, off, n in streams[:4] + [longest]:
            stream = rom[off:off + n]
            try:
                data, used = lz.decompress(stream, 0, n)
            except ValueError:
                used = None
            if used != n:
                self.skipTest("baserom.gbc is not the USA ROM data.manifest describes")
            with self.subTest(path):
                self.assertEqual(lz.compress(data), stream)


class TileImages(unittest.TestCase):
    def setUp(self):
        try:
            import PIL  # noqa: F401
        except ImportError:
            self.skipTest("Pillow not installed")
        import gfx
        self.gfx = gfx

    def test_round_trip_and_partial_row(self):
        rng = random.Random(2)
        for ntiles in (1, 15, 16, 17, 40, 253):
            data = bytes(rng.getrandbits(8) for _ in range(ntiles * 16))
            img, n = self.gfx.tiles_to_image(data)
            self.assertEqual(n, ntiles)
            self.assertEqual(self.gfx.image_to_tiles(img, ntiles), data)

    def test_layouts_are_permutations(self):
        rng = random.Random(4)
        for ntiles, layout in ((15, "3x4+3"), (20, "4x4+4"), (16, "2x2"),
                               (4, "2x2"), (105, "3x4+3"), (17, "2x2")):
            data = bytes(rng.getrandbits(8) for _ in range(ntiles * 16))
            pos, size = self.gfx.tile_positions(ntiles, layout)
            self.assertEqual(len(set(pos)), ntiles, layout)
            img, n = self.gfx.tiles_to_image(data, layout=layout)
            self.assertEqual(img.size, size)
            self.assertEqual(self.gfx.image_to_tiles(img, ntiles, layout), data)
        # a walk-sprite facing: tiles 0,1 are the left 8x16 object, 2,3 the right
        self.assertEqual(self.gfx.tile_positions(4, "2x2")[0],
                         [(0, 0), (0, 8), (8, 0), (8, 8)])
        # a character frame: three 4-tile columns, shadows under each column
        pos, size = self.gfx.tile_positions(15, "3x4+3")
        self.assertEqual(size, (24, 40))
        self.assertEqual(pos[12:], [(0, 32), (8, 32), (16, 32)])
        with self.assertRaises(ValueError):
            self.gfx.parse_layout("3x")

    def test_logo_round_trip(self):
        rng = random.Random(5)
        data = bytes(rng.getrandbits(8) for _ in range(self.gfx.LOGO_SIZE))
        img = self.gfx.logo_to_image(data)
        self.assertEqual(img.size, (48, 8))
        self.assertEqual(self.gfx.image_to_logo(img), data)
        # byte 0 is the top two rows of the first 4x4 cell, byte 24 the
        # first cell of the bottom half
        img = self.gfx.logo_to_image(b"\xf0" + bytes(23) + b"\x0f" + bytes(23))
        px = img.load()
        self.assertEqual([px[x, 0] for x in range(5)], [3, 3, 3, 3, 0])
        self.assertEqual([px[0, y] for y in (1, 4, 5)], [0, 0, 3])

    def test_tilemap_grid_round_trip(self):
        import tilemap
        rng = random.Random(7)
        for size, width in ((1024, 32), (4096, 64), (576, 32), (40, 20), (14, 14), (37, 32)):
            data = bytes(rng.getrandbits(8) for _ in range(size))
            text = tilemap.grid_text(data, width, "T")
            self.assertEqual(tilemap.grid_bytes(text), data, (size, width))
            self.assertEqual(text.count("\n\ttilemap_row "), size // width)
        with self.assertRaises(ValueError):
            tilemap.grid_bytes("\ttilemap_begin 4, 1\n\ttilemap_row $00, $01\n\ttilemap_end\n")
        with tempfile.TemporaryDirectory() as d:
            data = bytes(rng.getrandbits(8) & 3 for _ in range(1024))
            p = os.path.join(d, "lz_Map.bin")
            with open(p, "wb") as f:
                f.write(lz.compress(data))
            self.assertEqual(tilemap.decode(p, p[:-4] + ".tilemap", 32), 32)
            tilemap.encode(p[:-4] + ".tilemap", p)
            self.assertEqual(lz.decompress(Path(p).read_bytes(), 0)[0], data)

    def test_scene_preview_composes(self):
        import tilemap
        with tempfile.TemporaryDirectory() as d:
            tiles = bytes([0xFF, 0x00] * 8) + bytes([0x00, 0xFF] * 8)   # tile 0 colour 1, tile 1 colour 2
            tm = bytes([0, 1, 0x90, 0] * 8)                                # 4 wide x 8 rows
            am = bytes([0x0A, 0x2B, 0x08, 0x00] * 8)                       # bank 1 pal 2 / flipped pal 3 / glyph id / bank 0
            pal = "".join(f"\tpalette  0, 0, 0,  31, 0, 0,   0,31, 0,   0, 0,31 ; pal {i}\n"
                          for i in range(8))
            paths = [os.path.join(d, n) for n in ("Map.bin", "Attr.bin", "Tiles.bin", "Pal.asm")]
            for pth, data in zip(paths, (tm, am, tiles, pal)):
                with open(pth, "wb" if isinstance(data, bytes) else "w") as f:
                    f.write(data)
            out = os.path.join(d, "Map.preview.png")
            self.assertEqual(tilemap.preview(*paths, out, 4), (4, 8))
            from PIL import Image
            img = Image.open(out)
            self.assertEqual(img.size, (32, 64))
            self.assertEqual(img.getpixel((0, 0)), (255, 0, 0))       # tile 0, pal 2 colour 1 = red
            self.assertEqual(img.getpixel((8, 0)), (0, 255, 0))       # tile 1, pal 3 colour 2 = green
            self.assertEqual(img.getpixel((16, 0)), (224, 224, 224))  # a glyph-buffer id: grey
            self.assertEqual(img.getpixel((24, 0)), (224, 224, 224))  # VRAM bank 0: grey
            self.assertTrue(any(len(set(c)) > 1 for _n, c in img.convert("RGB").getcolors()))

    def test_plain_image_grows_when_drawn_past_its_end(self):
        rng = random.Random(5)
        data = bytes(rng.getrandbits(8) | 1 for _ in range(17 * 16))
        with tempfile.TemporaryDirectory() as d:
            raw = os.path.join(d, "d_4000.bin")
            png = os.path.join(d, "d_4000.png")
            with open(raw, "wb") as f:
                f.write(data)
            self.assertEqual(self.gfx.decode(raw, png), 17)
            # untouched: the 15 blank tiles of the partial row are padding
            self.assertEqual(self.gfx.image_file_to_tiles(png), data)
            from PIL import Image
            from PIL.PngImagePlugin import PngInfo
            img = Image.open(png)
            img.putpixel((8 * 3, 8), 3)          # a dot in tile 19
            info = PngInfo()
            for k, v in img.text.items():
                info.add_text(k, v)
            img.save(png, pnginfo=info)
            grown = self.gfx.image_file_to_tiles(png)
            self.assertEqual(len(grown), 20 * 16)
            self.assertEqual(grown[:17 * 16], data)

    def test_extract_keep_leaves_edits(self):
        rng = random.Random(6)
        rom = bytes(rng.getrandbits(8) for _ in range(0x200))
        with tempfile.TemporaryDirectory() as d:
            romp, man, out = os.path.join(d, "r.gbc"), os.path.join(d, "m"), os.path.join(d, "out")
            with open(romp, "wb") as f:
                f.write(rom)
            with open(man, "w") as f:
                f.write("bank_000/Tiles.bin 000000 40 gfx\nbank_000/Blob.bin 000040 10\n"
                        "bank_000/Map.bin 000050 40 tilemap:32\n")
            run = lambda *a: subprocess.run(  # noqa: E731
                [sys.executable, str(TOOLS / "extract.py"), *a, romp, man, out],
                capture_output=True, text=True, check=True).stdout
            run()
            blob = os.path.join(out, "bank_000", "Blob.bin")
            png = os.path.join(out, "bank_000", "Tiles.png")
            with open(blob, "wb") as f:
                f.write(b"edited")
            from PIL import Image
            from PIL.PngImagePlugin import PngInfo
            img = Image.open(png)
            img.putpixel((0, 0), (img.getpixel((0, 0)) + 1) % 4)
            info = PngInfo()
            for k, v in img.text.items():
                info.add_text(k, v)
            img.save(png, pnginfo=info)
            grid = os.path.join(out, "bank_000", "Map.tilemap")
            with open(grid) as f:
                gtext = f.read()
            with open(grid, "w") as f:
                f.write(gtext.replace("tilemap_row $", "tilemap_row $ff, $", 1))
            stale = os.path.join(out, "bank_000", "old.bin")
            with open(stale, "wb") as f:
                f.write(b"x")
            outp = run("--keep")
            self.assertIn("kept 3 edited", outp)
            self.assertEqual(Path(blob).read_bytes(), b"edited")
            self.assertNotEqual(self.gfx.image_file_to_tiles(png), rom[:0x40])
            self.assertTrue(os.path.exists(stale))
            run()
            self.assertEqual(Path(blob).read_bytes(), rom[0x40:0x50])
            self.assertEqual(self.gfx.image_file_to_tiles(png), rom[:0x40])
            self.assertFalse(os.path.exists(stale))

    def test_size_inc(self):
        with tempfile.TemporaryDirectory() as d:
            p = os.path.join(d, "lz_Thing.bin")
            with open(p, "wb") as f:
                f.write(lz.compress(bytes(64)))
            r = subprocess.run([sys.executable, str(TOOLS / "lz.py"), "--size-inc", p],
                               capture_output=True, text=True)
            self.assertEqual(r.stdout.strip(), "DEF Thing_SIZE EQU 64")

    def test_file_round_trip_raw_and_lz(self):
        rng = random.Random(3)
        data = bytes(rng.getrandbits(8) & 0x0F for _ in range(48 * 16))
        with tempfile.TemporaryDirectory() as d:
            raw = os.path.join(d, "d_4000.bin")
            with open(raw, "wb") as f:
                f.write(data)
            self.assertEqual(self.gfx.decode(raw, raw[:-4] + ".png"), 48)
            self.gfx.encode(raw[:-4] + ".png", raw)
            self.assertEqual(Path(raw).read_bytes(), data)
            lzp = os.path.join(d, "lz_4000.bin")
            with open(lzp, "wb") as f:
                f.write(lz.compress(data))
            self.assertEqual(self.gfx.decode(lzp, lzp[:-4] + ".png"), 48)
            self.gfx.encode(lzp[:-4] + ".png", lzp)
            self.assertEqual(lz.decompress(Path(lzp).read_bytes(), 0)[0], data)

    def test_png_without_text_chunks_uses_the_manifest(self):
        from PIL import Image
        rng = random.Random(7)
        frame = bytes(rng.getrandbits(8) for _ in range(15 * 16))
        font = bytes(rng.getrandbits(8) | 1 for _ in range(102 * 16))
        with tempfile.TemporaryDirectory() as d:
            man = Path(d) / "data.manifest"
            man.write_text("sprites/Frame.bin 000000 f0 gfx:3x4+3\n"
                           "text/lz_Font.bin 0000f0 10 gfx\n")
            for rel, data in (("sprites/Frame.bin", frame), ("text/lz_Font.bin", font)):
                binp = Path(d) / "data" / rel
                binp.parent.mkdir(parents=True)
                before = lz.compress(data) if self.gfx.is_lz(binp) else data
                binp.write_bytes(before)
                png = binp.with_suffix(".png")
                self.gfx.decode(binp, png, "3x4+3" if "Frame" in rel else None)
                img = Image.open(png)
                img.load()
                img.save(png)
                self.assertNotIn("tiles", Image.open(png).text)
                self.gfx.encode(png, binp, man)
                self.assertEqual(binp.read_bytes(), before)

    def test_rejects_partial_tiles(self):
        with tempfile.TemporaryDirectory() as d:
            p = os.path.join(d, "d_4000.bin")
            with open(p, "wb") as f:
                f.write(b"\x00" * 30)
            self.assertIsNone(self.gfx.decode(p, p[:-4] + ".png"))


class SoundScript(unittest.TestCase):
    """The channel-script codec: the four-byte header, two-byte commands,
    the four-byte snd_call with a byte-offset target, and the rendering
    round trip."""

    HEADER = bytes([0x06, 0x00, 0x09, 0x00])

    def test_round_trip(self):
        import snd
        track = self.HEADER + bytes([
            0xa0, 0x1e, 0x41, 0x08, 0xfd, 0xf0, 0x2f, 0x04, 0xb2, 0xf0,
            0xa3, 0x25, 0xa4, 0xfa, 0xa3, 0xfe, 0xaa, 0x23,
            0xac, 0x03, 0x1c, 0x00, 0xff, 0xff, 0x53, 0x02, 0xad, 0x00])
        text = snd.render(track, "T", "pulse")
        self.assertIn("snd_header 6, $00, 9, $00", text)
        self.assertIn("snd_note C#, 4, 8", text)
        self.assertIn("snd_vibrato 2, 10", text)
        self.assertIn("snd_gate -6", text)
        self.assertIn("snd_vibrato_off", text)
        self.assertIn("snd_echo 2, 3", text)
        self.assertIn("snd_call 3, .call0", text)
        self.assertIn(".call0:", text)
        self.assertEqual(snd.encode(text), track)
        self.assertIn("snd_noise $41, 8", snd.render(track, "T", "noise"))

    def test_rejects_bad_scripts(self):
        import snd
        with self.assertRaises(ValueError):
            snd.decode(bytes([0x06, 0x00, 0x09]))          # no whole header
        with self.assertRaises(ValueError):
            snd.decode(self.HEADER + bytes([0xa0, 0x1e, 0xff]))          # odd length
        with self.assertRaises(ValueError):
            snd.decode(self.HEADER + bytes([0xac, 0x01, 0x07, 0x00, 0xff, 0xff]))   # target mid-command
        with self.assertRaises(ValueError):
            snd.decode(self.HEADER + bytes([0xac, 0x01, 0x00, 0x00, 0xff, 0xff]))   # target in the header


@needs_rgbasm
class MacroBytes(unittest.TestCase):
    """Every idiom macro must assemble to the bytes of the instructions it
    stands for -- the byte-perfect build depends on it."""

    def bytes_of(self, source):
        with tempfile.TemporaryDirectory() as d:
            return assemble(source, d)

    def test_wram_bank_forms(self):
        self.assertEqual(self.bytes_of("push_wram_bank $06\npop_wram_bank")[:14],
                         bytes.fromhex("f096f53e06e096e070" "f1e096e070"))

    def test_ld_hl_indexed(self):
        out = self.bytes_of("ld_hl_indexed Table\nTable: db 1")
        # add LOW(Table) / ld l,a / adc HIGH(Table) / sub l / ld h,a, Table=$0007
        self.assertEqual(out[:7], bytes.fromhex("c607" "6f" "ce00" "95" "67"))

    def test_add_pair_a(self):
        out = self.bytes_of("add_hl_a\nadd_de_a\nadd_bc_a")
        self.assertEqual(out[:15], bytes.fromhex("85" "6f" "3001" "24" "83" "5f" "3001" "14" "81" "4f" "3001" "04"))

    def test_neg_abs_sub_pair(self):
        out = self.bytes_of("neg_hl\nneg_de\nneg_bc\nabs_hl\nabs_de\nsub_hl_de\nsub_hl_bc")
        neg_hl, neg_de = bytes.fromhex("af956f9f9467"), bytes.fromhex("af935f9f9257")
        self.assertEqual(out[:18], neg_hl + neg_de + bytes.fromhex("af914f9f9047"))
        self.assertEqual(out[18:38], bytes.fromhex("cb7c2806") + neg_hl + bytes.fromhex("cb7a2806") + neg_de)
        self.assertEqual(out[38:50], bytes.fromhex("7d936f7c9a67" "7d916f7c9867"))

    def test_ld_story_char_field(self):
        out = self.bytes_of("DEF wStoryMain EQU $c900\nDEF wStoryPartner EQU $c940\n"
                            "DEF wStoryCharacterSlot EQU $cb00\nld_story_char_field CHARREC_LEVEL")
        self.assertEqual(out[:19], bytes.fromhex("2100c9" "fa00cb" "b7" "2802" "2e40" "7d" "c618" "6f" "7c" "ce00" "67"))

    def test_rom_sram_bank_forms(self):
        out = self.bytes_of("DEF hRomBank EQU $ff95\nDEF hSramBank EQU $ff97\n"
                            "push_rom_bank b\npop_rom_bank\nrom_bank\nsram_bank $01")
        self.assertEqual(out[:27], bytes.fromhex("f095f578e095ea0020" "f1e095ea0020" "e095ea0020"
                                                 "3e01e097ea0040"))

    def test_jumptable_and_frame_task(self):
        out = self.bytes_of("DEF Rst00 EQU $0000\nDEF RegisterFrameTask EQU $1b6a\n"
                            "jumptable a\njumptable [$c123]\njumptable\nframe_task Task\nframe_task Task, $0a\n"
                            "Task: ret")
        self.assertEqual(out[:7], bytes.fromhex("7fc7" "fa23c1c7" "c7"))
        self.assertEqual(out[7:23], bytes.fromhex("3e01" "211700" "cd6a1b" "3e0a" "211700" "cd6a1b"))

    def test_wait_frames_and_lb(self):
        out = self.bytes_of("wait_frames $1e\nlb de, $02, $06\nlb bc, $ff, $00")
        self.assertEqual(out[:4], bytes.fromhex("cd2527" "1e"))   # WaitFramesCmd = $2725
        self.assertEqual(out[4:10], bytes.fromhex("110602" "0100ff"))

    def test_text_codes_round_trip(self):
        sys.path.insert(0, str(TOOLS))
        import extract
        raw = bytes.fromhex("07") + b" won" + bytes.fromhex("010e05") + b"!" + bytes.fromhex("0603")
        lines = extract.render_string(raw)
        self.assertEqual(lines, ['\ttext TX_PLAYER_NAME, " won"',
                                 '\tline TX_CHAR_NAME, CHAR_JOY, "!", TX_DELAY_15',
                                 '\tdone'])
        self.assertEqual(self.bytes_of("\n".join(lines))[:len(raw)], raw)

    def test_palette_and_vram_names(self):
        out = self.bytes_of("palette  0,31,31,  31,31,26,  24,18, 7,   0, 0, 0\n"
                            "ld de, vBGMap0 + 15 * TILEMAP_WIDTH + 4\n"
                            "ld de, vTiles0 tile $10 + VRAM_BANK1")
        self.assertEqual(out[:8], bytes.fromhex("e07f" "ff6b" "581e" "0000"))
        self.assertEqual(out[8:14], bytes.fromhex("11e499" "1100a1"))

    def test_flag_forms_agree(self):
        # flag 47 = byte 5, bit 7 -> (5 << 8) | (7 << 5) = $05e0
        out = self.bytes_of("ld_flag_id de, FLAG_DOUBLES\nflag_id FLAG_DOUBLES\n"
                            "set_flag FLAG_DOUBLES")
        self.assertEqual(out[:3], bytes.fromhex("11e005"))
        self.assertEqual(out[3:5], bytes.fromhex("e005"))
        self.assertEqual(out[5:8], bytes.fromhex("e7" "e005"))  # rst $20; db bit<<5, byte

    def test_sound_macros_match_the_codec(self):
        sys.path.insert(0, str(TOOLS))
        import snd
        rows = ("\tsnd_track T\nT:\n\tsnd_header $a0, $02, 15, $03\n\tsnd_vibrato 13, 30\n"
                "\tsnd_vibrato_off\n\tsnd_gate -9\n\tsnd_gate 5\n\tsnd_wait 12\n"
                "\tsnd_switch $f2\n\tsnd_echo 3, 8\n\tsnd_quarter_tone 1\n\tsnd_tempo 7\n"
                "\tsnd_envelope 14, $20\n\tsnd_end")
        want = snd.encode(rows.replace("T:\n", ""))
        self.assertEqual(want[:6], bytes.fromhex("a002" "0f03" "a3df"))
        self.assertEqual(self.bytes_of(rows)[:len(want)], want)


if __name__ == "__main__":
    unittest.main()
