import unittest

from ..client import checksum, client_region, done_locations, valid
from ..rom_addresses import constants
from ..text import fit, width


class TestLedgerFormat(unittest.TestCase):
    def test_zero_region_is_invalid(self) -> None:
        self.assertFalse(valid(bytes(10)))

    def test_client_region(self) -> None:
        region = client_region([(5, "Alice"), (7, "")])
        self.assertTrue(valid(region))
        self.assertEqual(int.from_bytes(region[:2], "little"), 2)
        self.assertEqual(region[2 + 5], 1)
        recent = 2 + constants["AP_ITEM_SLOTS"]
        self.assertEqual(region[recent:recent + 6], b"\x05Alice")

    def test_done_locations(self) -> None:
        region = bytes([0b101]) + bytes(40)
        self.assertEqual(done_locations(region), {1, 3})

    def test_checksum_seed(self) -> None:
        self.assertEqual(checksum(b""), constants["AP_CHECKSUM_SEED"].to_bytes(2, "little"))


class TestNames(unittest.TestCase):
    def test_short_name_kept(self) -> None:
        self.assertEqual(fit("Alice", "to !"), b"Alice")

    def test_long_name_fits(self) -> None:
        name = fit("W" * 40, "from !").decode()
        self.assertTrue(name.endswith("..."))
        self.assertLessEqual(width(name + "from !"), 144)
        self.assertLessEqual(len(name), constants["AP_NAME_LENGTH"])

    def test_unprintable(self) -> None:
        self.assertEqual(fit("a~b{c}é"), b"a-b(c)?")
