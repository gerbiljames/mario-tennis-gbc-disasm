#!/usr/bin/env python3
"""Run the Archipelago branch's game-side tests in PyBoy.

    python3 tools/aptest.py [--save maxed-unlocked.sav] [-k name]

Boots the built ROM (with per-seed bytes poked in as the patch's tokens
would write them) from a battery save to the story overworld, and calls game
routines from the overworld's idle loop (RunStoryLocation.eventWaitLoop):
each call pushes the loop as its return address and enters the routine
through CallHLInBankA, so it runs in the game as a real caller's would. Each
test then reads the ledger (SRAM bank 3) back through the build's symbols."""
import argparse
import shutil
import sys
import tempfile
import traceback
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "tools"))
from ap_export import read_ids, read_syms, rom_offset  # noqa: E402

BUTTONS = {"a": "a", "b": "b", "start": "start", "select": "select",
           "up": "up", "down": "down", "left": "left", "right": "right"}


def constants():
    """LOC_* / ITEM_* / MINIGAME_* values from the includes."""
    import re
    out = {}
    locations, items = read_ids()
    out.update({c: i - 1 for i, c, _ in locations})
    out.update({c: i for i, c, _ in items})
    for line in (ROOT / "include" / "constants" / "modes.inc").read_text().splitlines():
        m = re.match(r"def (MINIGAME_\w+)\s+equ \$([0-9a-f]+)", line)
        if m:
            out[m.group(1)] = int(m.group(2), 16)
    return out


class Game:
    def __init__(self, rom, sym, save, tokens=None):
        from pyboy import PyBoy
        self.sym = read_syms(sym)
        self.tmp = Path(tempfile.mkdtemp(prefix="aptest-"))
        data = bytearray(Path(rom).read_bytes())
        for label, value in (tokens or {}).items():
            off = rom_offset(*self.sym[label[0]]) + label[1] if isinstance(label, tuple) else rom_offset(*self.sym[label])
            data[off:off + len(value)] = value
        copy = self.tmp / "rom.gbc"
        copy.write_bytes(data)
        if save:
            shutil.copy(save, str(copy) + ".ram")
        self.pb = PyBoy(str(copy), window="null", sound_emulated=False, log_level="ERROR")
        self.pb.set_emulation_speed(0)
        self.rf, self.mem = self.pb.register_file, self.pb.memory
        self.pending, self.idle = [], 0
        b, a = self.sym["RunStoryLocation.eventWaitLoop"]
        self.pb.hook_register(b, a, self.on_idle, None)

    def close(self):
        self.pb.stop(save=False)
        shutil.rmtree(self.tmp, ignore_errors=True)

    def on_idle(self, _):
        self.idle += 1
        if not self.pending:
            return
        label, regs = self.pending.pop(0)
        bank, addr = self.sym[label]
        r, m = self.rf, self.mem
        sp = (r.SP - 2) & 0xffff
        m[sp], m[sp + 1] = r.PC & 0xff, r.PC >> 8
        r.SP = sp
        for k, v in regs.items():
            setattr(r, k, v)
        r.A, r.HL = bank, addr
        r.PC = self.sym["CallHLInBankA"][1]

    def tick(self, n=1):
        for _ in range(n):
            self.pb.tick(1, False)

    def press(self, button, hold=6, wait=0):
        self.pb.button_press(BUTTONS[button])
        self.tick(hold)
        self.pb.button_release(BUTTONS[button])
        self.tick(wait)

    def to_overworld(self):
        """Title screen -> Mario Tour -> continue the first story slot."""
        self.tick(950)
        self.press("start", wait=90)
        self.press("a", wait=90)
        self.press("down", wait=150)
        for _ in range(6):
            self.press("a", wait=150)
        start = self.idle
        for _ in range(3000):
            self.tick()
            if self.idle > start + 30:
                return
        raise AssertionError("never reached the overworld idle loop")

    def call(self, label, **regs):
        """Run `label` (any bank) from the idle loop, with these registers."""
        self.pending.append((label, regs))
        for i in range(1200):
            self.tick()
            if not self.pending:
                self.tick(2)
                return
            if i % 60 == 59:
                self.press("a")
        raise AssertionError(f"{label} was never called")

    def addr(self, label):
        return self.sym[label][1]

    def wram(self, label, *values):
        a = self.addr(label)
        for i, v in enumerate(values):
            self.mem[a + i] = v

    def sram(self, label, n=1, offset=0):
        bank, a = self.sym[label]
        return bytes(self.mem[bank, a + offset + i] for i in range(n))

    def sram_write(self, label, data, offset=0):
        bank, a = self.sym[label]
        for i, v in enumerate(data):
            self.mem[bank, a + offset + i] = v

    def seal(self, start, end):
        """Write the checksum word of the ledger region start..end, as its writer does."""
        n = self.sym[end][1] - self.sym[start][1]
        total = (0xa55a + sum(self.sram(start, n))) & 0xffff
        self.sram_write(start, total.to_bytes(2, "little"), offset=n)

    def receive(self, items):
        """Act as the client: append (item id, sender) pairs to the client region."""
        count = int.from_bytes(self.sram("sApReceivedCount", 2), "little")
        for item, sender in items:
            counts = bytearray(self.sram("sApClientItems", 32))
            counts[item] += 1
            self.sram_write("sApClientItems", counts)
            entry = bytes([item]) + sender.encode() + bytes(25 - len(sender))
            self.sram_write("sApRecentItems", entry, offset=(count % 8) * 26)
            count += 1
        self.sram_write("sApReceivedCount", count.to_bytes(2, "little"))
        self.seal("sApClientRegion", "sApClientChecksum")

    def message(self):
        """The text of the message on show (wTextBuffer), once one opens."""
        self.mem[self.addr("wTextBuffer")] = 0
        start = self.idle
        for _ in range(300):
            self.tick()
            text = bytes(self.mem[self.addr("wTextBuffer") + i] for i in range(96))
            if self.idle == start and text.startswith((b"You got", b"You sent")):
                return text.split(b"\0")[0].replace(b"\x01", b"/").replace(b"\x03", b"").decode()
            start = self.idle
        return None

    def dismiss(self):
        """Press A until the message closes and the idle loop runs again."""
        for _ in range(10):
            start = self.idle
            self.press("a", wait=2)
            if self.idle > start:
                return
            self.tick(20)
            if self.idle > start:
                return
        raise AssertionError("the message never closed")

    def screenshot(self, path):
        self.tick(240)
        self.pb.tick(1, True)
        self.pb.screen.image.save(path)

    def done(self, loc):
        return bool(self.sram("sApDoneBits", offset=loc // 8)[0] & (1 << (loc % 8)))

    def game_items(self, item):
        return self.sram("sApGameItems", offset=item)[0]


TESTS = {}


def test(fn):
    TESTS[fn.__name__] = fn
    return fn


def placements(c, pairs):
    """ApPlacements tokens: {LOC_*: ITEM_*}."""
    return {("ApPlacements", c[loc]): bytes([c[item]]) for loc, item in pairs.items()}


@test
def check_reward_lists(g, c):
    g.wram("wCurrentMinigameStoryMatch", 0, 1)
    g.call("SetRewardGameFlag")
    assert g.done(c["LOC_JUNIOR_SINGLES_RANK_4"]), "rank win not marked done"
    assert g.game_items(c["ITEM_IRON_RACKET"]) == 1, "own item not granted"
    g.call("SetRewardGameFlag")
    assert g.game_items(c["ITEM_IRON_RACKET"]) == 1, "a repeat check granted again"
    g.wram("wCurrentMinigameStoryMatch", 1, 13)
    g.call("SetRewardGameFlag")
    assert g.done(c["LOC_VARSITY_DOUBLES_RANK_2"])
    assert g.game_items(c["ITEM_DOUBLES_PASS"]) == 1
    g.wram("wCurrentMinigameStoryMatch", 0, 23)
    g.call("SetRewardGameFlag")
    assert g.done(c["LOC_DREAM_MATCH_SINGLES"])
    g.wram("wCurrentMinigameStoryMatch", 2, c["MINIGAME_STROKE_MATCH_2"])
    g.call("SetRewardGameFlag")
    assert g.done(c["LOC_STROKE_MATCH_2"])
    assert g.game_items(c["ITEM_EXP_BUNDLE"]) == 1
    g.wram("wCurrentMinigameStoryMatch", 2, c["MINIGAME_WALL_PRACTICE_HIGH_SCORE"])
    g.call("SetRewardGameFlag")
    assert not g.done(c["LOC_WALL_PRACTICE_MASTER"]), "the save has Master cleared: this was Expert"


check_reward_lists.tokens = lambda c: placements(c, {
    "LOC_JUNIOR_SINGLES_RANK_4": "ITEM_IRON_RACKET",
    "LOC_VARSITY_DOUBLES_RANK_2": "ITEM_DOUBLES_PASS",
    "LOC_STROKE_MATCH_2": "ITEM_EXP_BUNDLE",
})


@test
def check_minigames(g, c):
    g.wram("wCurrentMinigameStoryMatch", 0, c["MINIGAME_TARGET_SHOT"])
    g.wram("wMinigameLevel", 2)
    g.call("SetMinigameClearFlag")
    assert g.done(c["LOC_TARGET_SHOT_3"])
    assert g.game_items(c["ITEM_TARGET_SHOT"]) == 1
    g.wram("wCurrentMinigameStoryMatch", 0, c["MINIGAME_BOO_BLAST"])
    g.wram("wMinigameLevel", 0)
    g.call("SetMinigameClearFlag")
    assert g.done(c["LOC_BOO_BLAST_1"])
    # a record over the default (60) checks the court location, win or lose
    g.wram("wCurrentMinigameStoryMatch", 0, c["MINIGAME_BANANA_BUNCH"])
    g.wram("wMinigameLevel", 2)
    g.wram("wMinigamesCurrentScore", 60, 0)
    g.call("UpdateMinigameBestScore")
    assert not g.done(c["LOC_BANANA_BUNCH_RECORD"]), "the default itself is not beaten"
    g.wram("wMinigamesCurrentScore", 61, 0)
    g.call("UpdateMinigameBestScore")
    assert g.done(c["LOC_BANANA_BUNCH_RECORD"])
    g.wram("wCurrentMinigameStoryMatch", 0, c["MINIGAME_BOO_BLAST"])
    g.wram("wMinigamesCurrentScore", 0, 1)
    g.call("UpdateMinigameBestScore")
    assert not any(g.done(c[f"LOC_{n}_RECORD"]) for n in ("SHOOTING_STAR", "TARGET_SHOT"))


check_minigames.tokens = lambda c: placements(c, {"LOC_TARGET_SHOT_3": "ITEM_TARGET_SHOT"})


@test
def check_swing_contest(g, c):
    g.wram("wSwingContestSwings", 99, 0)
    g.call("ApCheckSwingContest")
    assert not g.done(c["LOC_SWING_CONTEST_LOW"])
    g.wram("wSwingContestSwings", 100, 0)
    g.call("ApCheckSwingContest")
    assert g.done(c["LOC_SWING_CONTEST_LOW"]) and not g.done(c["LOC_SWING_CONTEST_HIGH"])
    g.wram("wSwingContestSwings", 150, 0)
    g.call("ApCheckSwingContest")
    assert g.done(c["LOC_SWING_CONTEST_HIGH"])


@test
def check_swing_contest_nerfed(g, c):
    g.wram("wSwingContestSwings", 90, 0)
    g.call("ApCheckSwingContest")
    assert g.done(c["LOC_SWING_CONTEST_LOW"]) and g.done(c["LOC_SWING_CONTEST_HIGH"])


check_swing_contest_nerfed.tokens = lambda c: {"ApOptSwingLow": bytes([60]), "ApOptSwingHigh": bytes([90])}


@test
def messages(g, c):
    g.wram("wCurrentMinigameStoryMatch", 0, 1)
    g.call("SetRewardGameFlag")
    msg = g.message()
    assert msg == "You got/Iron Racket!", msg
    if SHOTS:
        g.screenshot(SHOTS / "own.png")
    g.dismiss()
    assert g.mem[g.addr("wApApplied") + c["ITEM_IRON_RACKET"]] == 1, "Iron Racket not applied to the slot"
    g.wram("wCurrentMinigameStoryMatch", 0, 2)
    g.call("SetRewardGameFlag")
    msg = g.message()
    assert msg == "You sent/Big Key/to Somebody Else!", msg
    if SHOTS:
        g.screenshot(SHOTS / "sent.png")
    g.dismiss()
    g.wram("wCurrentMinigameStoryMatch", 0, 3)
    g.call("SetRewardGameFlag")
    assert g.message() is None, "a blank player's location showed a message"
    g.receive([(c["ITEM_SMALL_RACKET"], "Alice"), (c["ITEM_EXP_BUNDLE"], "")])
    msg = g.message()
    assert msg == "You got/Small Racket/from Alice!", msg
    if SHOTS:
        g.screenshot(SHOTS / "received.png")
    g.dismiss()
    assert g.message() == "You got/EXP Bundle!"
    g.dismiss()
    applied = g.mem[g.addr("wApApplied") + c["ITEM_EXP_BUNDLE"]]
    assert applied == 1, applied
    assert g.message() is None


def names(c, loc, item, player):
    off = c[loc] * 50
    return {("ApLocationNames", off): item.encode() + b"\0", ("ApLocationNames", off + 25): player.encode() + b"\0"}


messages.tokens = lambda c: {**placements(c, {"LOC_JUNIOR_SINGLES_RANK_4": "ITEM_IRON_RACKET"}),
                             **names(c, "LOC_JUNIOR_SINGLES_RANK_3", "Big Key", "Somebody Else")}
SHOTS = None


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--rom", default=ROOT / "mariotennis.gbc")
    ap.add_argument("--sym", default=ROOT / "build" / "mariotennis.sym")
    ap.add_argument("--save", default=ROOT / "maxed-unlocked.sav")
    ap.add_argument("-k", help="run only the tests whose name contains this")
    ap.add_argument("--shots", type=Path, help="save screenshots of the messages here")
    args = ap.parse_args()
    global SHOTS
    SHOTS = args.shots
    c = constants()
    failed = 0
    for name, fn in TESTS.items():
        if args.k and args.k not in name:
            continue
        tokens = getattr(fn, "tokens", lambda c: {})(c)
        g = Game(args.rom, args.sym, args.save, tokens)
        try:
            g.to_overworld()
            fn(g, c)
            print(f"ok    {name}")
        except AssertionError:
            failed += 1
            print(f"FAIL  {name}")
            traceback.print_exc()
        finally:
            g.close()
    sys.exit(1 if failed else 0)


if __name__ == "__main__":
    main()
