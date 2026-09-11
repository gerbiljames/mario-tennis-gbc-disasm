"""The generator's analysis on a synthetic ROM: descent from a seed, the
WRAM-bank dataflow, and the text-id walkers -- small programs whose right
answer is known, so a change to a walker shows up as a wrong name."""
import contextlib
import io
import unittest

from tests.helpers import ROOT  # noqa: F401

from disasmlib.disassembly import Disassembly
from disasmlib.ram import compute_wram_bank
from disasmlib.textids import text_id_consumers, text_id_load_sites

BANK = 0x4000


def rom_with(code):
    """A 4-bank ROM with `code` ({offset: bytes}) laid into bank 0."""
    rom = bytearray(b"\xff" * (4 * BANK))
    for off, b in code.items():
        rom[off:off + len(b)] = b
    return bytes(rom)


def analysed(code, seeds):
    dis = Disassembly(rom_with(code))
    dis.seed(set(seeds))
    with contextlib.redirect_stdout(io.StringIO()):
        dis.descend()
    return dis


class Descent(unittest.TestCase):
    def test_follows_calls_and_branches_and_stops_at_ret(self):
        code = {
            0x150: bytes.fromhex("cd0002"      # call $0200
                                 "2803"        # jr z, +3
                                 "3e01"        # ld a, 1
                                 "c9"          # ret
                                 "c9"),        # ret reached by the jr
            0x200: bytes.fromhex("af" "c9"),   # xor a / ret
        }
        dis = analysed(code, [0x150])
        self.assertEqual(sorted(dis.instrs), [0x150, 0x153, 0x155, 0x157, 0x158,
                                              0x200, 0x201])
        self.assertNotIn(0x159, dis.instrs, "descent must not run past a ret into fill")


class WramBankDataflow(unittest.TestCase):
    """The routine under test is reached by a call: only a callee starts on
    a known (empty) stack, so a push/pop pair resolves inside it."""
    CALLER = {0x150: bytes.fromhex("cd6001" "c9")}       # call $0160 / ret

    def test_wram_bank_and_stack_restore(self):
        code = {**self.CALLER, 0x160: bytes.fromhex(
            "f096"        # ldh a, [hWramBank]   (shadow read: bank still unknown)
            "f5"          # push af
            "3e05"        # ld a, 5
            "e096" "e070" # wram_bank 5
            "2100d0"      # ld hl, $d000         <- bank 5 here ($0169)
            "f1"          # pop af
            "e096" "e070" # wram_bank (restore)
            "2100d0"      # ld hl, $d000         <- bank unknown again ($0171)
            "c9")}
        dis = analysed(code, [0x150])
        banks = compute_wram_bank(dis)
        self.assertEqual(banks.get(0x169), 5)
        self.assertNotEqual(banks.get(0x171), 5, "restore must bring back the entry bank")

    def test_known_entry_bank_survives_the_restore(self):
        code = {**self.CALLER, 0x160: bytes.fromhex(
            "3e03" "e096" "e070"   # wram_bank 3
            "f096" "f5"            # ldh a,[hWramBank] / push af
            "3e06" "e096" "e070"   # wram_bank 6
            "f1" "e096" "e070"     # pop af / wram_bank
            "2100d0"               # ld hl, $d000  <- bank 3 ($0174)
            "c9")}
        dis = analysed(code, [0x150])
        self.assertEqual(compute_wram_bank(dis).get(0x174), 3)


class TextIdWalkers(unittest.TestCase):
    SINK = {"0x0200": "FetchDialogueText"}

    def test_direct_and_parked_loads(self):
        code = {
            0x150: bytes.fromhex("210c0c" "cd0002" "c9"),           # ld hl,$0c0c / call sink / ret
            0x160: bytes.fromhex("210c0c" "e5" "213412" "e1" "cd0002" "c9"),  # parked in push/pop
            0x170: bytes.fromhex("210c0c" "213412" "cd0002" "c9"),  # clobbered before the call
            0x200: bytes.fromhex("c9"),
        }
        dis = analysed(code, [0x150, 0x160, 0x170])
        sites = text_id_load_sites(dis, self.SINK)
        self.assertEqual(sites.get(0x150), "Text_33_12")
        self.assertEqual(sites.get(0x160), "Text_33_12")
        self.assertNotIn(0x170, sites)
        self.assertNotIn(0x164, sites, "the parking load is not an id")

    def test_wrapper_becomes_a_consumer(self):
        code = {
            0x150: bytes.fromhex("210c0c" "cd8001" "c9"),      # ld hl,id / call Wrapper
            0x180: bytes.fromhex("e5" "2100c0" "e1" "cd0002" "c9"),  # Wrapper: parks hl, then sink
            0x200: bytes.fromhex("c9"),
        }
        dis = analysed(code, [0x150, 0x180])
        self.assertIn(0x180, text_id_consumers(dis, self.SINK))
        self.assertEqual(text_id_load_sites(dis, self.SINK).get(0x150), "Text_33_12")

    def test_conditional_branch_into_a_consumer(self):
        code = {
            0x150: bytes.fromhex("217d04" "b2" "2001" "23" "cd0002" "c9"),
            # ld hl,$047d / or d / jr nz,+1 / inc hl / call sink / ret
            0x200: bytes.fromhex("c9"),
        }
        dis = analysed(code, [0x150])
        self.assertEqual(text_id_load_sites(dis, self.SINK).get(0x150), "Text_31_125")


if __name__ == "__main__":
    unittest.main()
