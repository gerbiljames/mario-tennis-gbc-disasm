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
        self.saved = (mods.MODS, mods.DATA, mods.PRISTINE)
        mods.MODS, mods.DATA = root / "mods", root / "data"
        mods.PRISTINE = mods.DATA / ".mods-pristine"
        self.rel = Path("bank_030") / "TextStrings_30.asm"
        (mods.DATA / self.rel).parent.mkdir(parents=True)
        (mods.DATA / self.rel).write_text("extracted\n")

    def tearDown(self):
        mods.MODS, mods.DATA, mods.PRISTINE = self.saved
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

    def test_apply_is_idempotent(self):
        self.mod("edited\n")
        mods.apply()
        self.assertEqual(mods.apply(), 0)
        self.assertEqual(mods.restore(), 0)


if __name__ == "__main__":
    unittest.main()
