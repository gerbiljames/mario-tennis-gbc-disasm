"""The apworld folder ships on its own, so it carries a copy of the license."""
import unittest

from tests.helpers import ROOT


class Apworld(unittest.TestCase):
    def test_license_matches(self):
        self.assertEqual((ROOT / "apworld" / "mario_tennis_gbc" / "LICENSE").read_bytes(),
                         (ROOT / "LICENSE").read_bytes())
