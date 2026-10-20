"""The mods/ overlay: a mod is copied over data/, and removing it puts back
the file extraction gave (a reverted edit, or a branch without the mod)."""
import tempfile
import unittest
from pathlib import Path

import tests.helpers  # noqa: F401  (puts tools/ on the path)
import mods


class Overlay(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        root = Path(self.tmp.name)
        self.saved = (mods.MODS, mods.DATA, mods.PRISTINE, mods.MANIFEST)
        mods.MODS, mods.DATA = root / "mods", root / "data"
        mods.PRISTINE = mods.DATA / ".mods-pristine"
        self.rel = Path("bank_030") / "TextStrings_30.asm"
        (mods.DATA / self.rel).parent.mkdir(parents=True)
        (mods.DATA / self.rel).write_text("extracted\n")

    def tearDown(self):
        mods.MODS, mods.DATA, mods.PRISTINE, mods.MANIFEST = self.saved
        self.tmp.cleanup()

    def mod(self, text):
        (mods.MODS / self.rel).parent.mkdir(parents=True, exist_ok=True)
        (mods.MODS / self.rel).write_text(text)

    def test_apply_then_remove_restores(self):
        self.mod("edited\n")
        self.assertEqual(mods.restore(), 0)
        self.assertEqual(mods.apply(), 1)
        self.assertEqual((mods.DATA / self.rel).read_text(), "edited\n")
        (mods.MODS / self.rel).unlink()
        self.assertEqual(mods.restore(), 1)
        self.assertEqual((mods.DATA / self.rel).read_text(), "extracted\n")
        self.assertFalse((mods.PRISTINE / self.rel).exists())

    def test_changed_mod_keeps_the_first_original(self):
        self.mod("edit one\n")
        mods.apply()
        self.mod("edit two\n")
        mods.apply()
        self.assertEqual((mods.DATA / self.rel).read_text(), "edit two\n")
        self.assertEqual((mods.PRISTINE / self.rel).read_text(), "extracted\n")

    def test_collect_keeps_the_original_for_restore(self):
        (mods.DATA / self.rel).write_text("edited in data\n")

        def fake_extract(args, **kw):
            out = Path(args[4]) / self.rel
            out.parent.mkdir(parents=True, exist_ok=True)
            out.write_text("extracted\n")
        real = mods.subprocess.run
        mods.subprocess.run = fake_extract
        try:
            self.assertEqual(mods.collect("baserom.gbc"), 1)
        finally:
            mods.subprocess.run = real
        self.assertEqual((mods.MODS / self.rel).read_text(), "edited in data\n")
        (mods.MODS / self.rel).unlink()
        self.assertEqual(mods.restore(), 1)
        self.assertEqual((mods.DATA / self.rel).read_text(), "extracted\n")

    def collect_against(self, extracted, manifest):
        """collect with extraction faked to write `extracted` {rel: bytes}."""
        mods.MANIFEST = Path(self.tmp.name) / "data.manifest"
        mods.MANIFEST.write_text(manifest)
        for rel, data in extracted.items():
            if not (mods.DATA / rel).exists():
                (mods.DATA / rel).parent.mkdir(parents=True, exist_ok=True)
                (mods.DATA / rel).write_bytes(data)

        def fake_extract(args, **kw):
            for rel, data in extracted.items():
                out = Path(args[4]) / rel
                out.parent.mkdir(parents=True, exist_ok=True)
                out.write_bytes(data)
        real = mods.subprocess.run
        mods.subprocess.run = fake_extract
        try:
            return mods.collect("baserom.gbc")
        finally:
            mods.subprocess.run = real

    def test_collect_gfx_png_edit(self):
        png, tiles = Path("gfx") / "Tiles.png", Path("gfx") / "Tiles.bin"
        for rel, data in ((png, b"edited png"), (tiles, b"re-encoded")):
            (mods.DATA / rel).parent.mkdir(parents=True, exist_ok=True)
            (mods.DATA / rel).write_bytes(data)
        n = self.collect_against({self.rel: b"extracted\n", png: b"png", tiles: b"tiles"},
                                 "gfx/Tiles.bin 000000 40 gfx\n")
        self.assertEqual(n, 1)
        self.assertEqual((mods.MODS / png).read_bytes(), b"edited png")
        self.assertFalse((mods.MODS / tiles).exists())

    def test_collect_specless_bin_edit(self):
        blob = Path("audio") / "Blob.bin"
        (mods.DATA / blob).parent.mkdir(parents=True)
        (mods.DATA / blob).write_bytes(b"edited")
        n = self.collect_against({self.rel: b"extracted\n", blob: b"rom bytes"},
                                 "audio/Blob.bin 000000 9\n")
        self.assertEqual(n, 1)
        self.assertEqual((mods.MODS / blob).read_bytes(), b"edited")
        self.assertEqual((mods.PRISTINE / blob).read_bytes(), b"rom bytes")

    def test_apply_is_idempotent(self):
        self.mod("edited\n")
        mods.apply()
        self.assertEqual(mods.apply(), 0)
        self.assertEqual(mods.restore(), 0)


if __name__ == "__main__":
    unittest.main()
