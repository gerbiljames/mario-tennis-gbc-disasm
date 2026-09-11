"""The byte-level codecs: the LZ format, the tile images, the SM83 decoder,
and the macro expansions -- each must reproduce its input exactly."""
import os
import random
import tempfile
import unittest

from tests.helpers import ROOT, assemble, needs_rgbasm

import lz
import sm83


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

    def test_file_round_trip_raw_and_lz(self):
        rng = random.Random(3)
        data = bytes(rng.getrandbits(8) & 0x0F for _ in range(48 * 16))
        with tempfile.TemporaryDirectory() as d:
            raw = os.path.join(d, "d_4000.bin")
            with open(raw, "wb") as f:
                f.write(data)
            self.assertEqual(self.gfx.decode(raw, raw[:-4] + ".png"), 48)
            self.gfx.encode(raw[:-4] + ".png", raw)
            self.assertEqual(open(raw, "rb").read(), data)
            lzp = os.path.join(d, "lz_4000.bin")
            with open(lzp, "wb") as f:
                f.write(lz.compress(data))
            self.assertEqual(self.gfx.decode(lzp, lzp[:-4] + ".png"), 48)
            self.gfx.encode(lzp[:-4] + ".png", lzp)
            self.assertEqual(lz.decompress(open(lzp, "rb").read(), 0)[0], data)

    def test_rejects_partial_tiles(self):
        with tempfile.TemporaryDirectory() as d:
            p = os.path.join(d, "d_4000.bin")
            with open(p, "wb") as f:
                f.write(b"\x00" * 30)
            self.assertIsNone(self.gfx.decode(p, p[:-4] + ".png"))


class Sm83(unittest.TestCase):
    def test_selftest(self):
        sm83.selftest()


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

    def test_wait_frames_and_lb(self):
        out = self.bytes_of("wait_frames $1e\nlb de, $02, $06\nlb bc, $ff, $00")
        self.assertEqual(out[:4], bytes.fromhex("cd2527" "1e"))   # WaitFramesCmd = $2725
        self.assertEqual(out[4:10], bytes.fromhex("110602" "0100ff"))

    def test_flag_forms_agree(self):
        # flag 47 = byte 5, bit 7 -> (5 << 8) | (7 << 5) = $05e0
        out = self.bytes_of("ld_flag_id de, FLAG_DOUBLES\nflag_id FLAG_DOUBLES\n"
                            "set_flag FLAG_DOUBLES")
        self.assertEqual(out[:3], bytes.fromhex("11e005"))
        self.assertEqual(out[3:5], bytes.fromhex("e005"))
        self.assertEqual(out[5:8], bytes.fromhex("e7" "e005"))  # rst $20; db bit<<5, byte


if __name__ == "__main__":
    unittest.main()
