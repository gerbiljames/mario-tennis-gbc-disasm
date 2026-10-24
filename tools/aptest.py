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
import consts  # noqa: E402

BUTTONS = {"a": "a", "b": "b", "start": "start", "select": "select",
           "up": "up", "down": "down", "left": "left", "right": "right"}


def constants():
    """LOC_* / ITEM_* / MINIGAME_* values from the includes."""
    out = {}
    locations, items = read_ids()
    out.update({c: i - 1 for i, c, _ in locations})
    out.update({c: i for i, c, _ in items})
    out.update({k: v for k, v in consts.constants().items() if k.startswith("MINIGAME_")})
    return out


def include_value(name):
    """A `def NAME equ value` constant from include/ (also the mirrored WRAM
    symbols, which are not in the .sym file)."""
    return consts.constants()[name]


def with_ledger(save, sym, auth=bytes(16)):
    """The battery save with an empty, valid ledger for this auth in SRAM
    bank 3, so the patched game takes the cart as this seed's and keeps its
    story files (a cart without one is erased at boot)."""
    syms = read_syms(sym)
    data = bytearray(save)
    data += bytes(max(0, 0x8000 - len(data)))

    def off(label):
        b, a = syms[label]
        return b * 0x2000 + a - 0xa000

    def seal(start, end):
        lo, hi = off(start), off(end)
        data[hi:hi + 2] = ((0xa55a + sum(data[lo:hi])) & 0xffff).to_bytes(2, "little")

    lo = off("sApHeader")
    data[lo:off("sApClientRegionEnd")] = bytes(off("sApClientRegionEnd") - lo)
    data[off("sApMagic"):off("sApMagic") + 4] = b"MTAP"
    data[off("sApAuth"):off("sApAuth") + 16] = auth
    seal("sApHeader", "sApHeaderChecksum")
    seal("sApGameRegion", "sApGameChecksum")
    n = off("sApGameRegionEnd") - off("sApGameRegion")
    data[off("sApGameBackup"):off("sApGameBackup") + n] = data[off("sApGameRegion"):off("sApGameRegionEnd")]
    seal("sApClientRegion", "sApClientChecksum")
    return bytes(data)


class Game:
    def __init__(self, rom, sym, save, tokens=None, ledger=True):
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
            auth = data[rom_offset(*self.sym["ApSlotAuth"]):][:16]
            raw = Path(save).read_bytes()
            Path(str(copy) + ".ram").write_bytes(with_ledger(raw, sym, bytes(auth)) if ledger else raw)
        self.pb = PyBoy(str(copy), window="null", sound_emulated=False, log_level="ERROR")
        self.pb.set_emulation_speed(0)
        self.rf, self.mem = self.pb.register_file, self.pb.memory
        self.pending, self.idle = [], 0
        self.awaiting, self.result = False, None
        b, a = self.sym["RunStoryLocation.eventWaitLoop"]
        self.pb.hook_register(b, a, self.on_idle, None)

    def close(self):
        self.pb.stop(save=False)
        shutil.rmtree(self.tmp, ignore_errors=True)

    def on_idle(self, _):
        self.idle += 1
        if self.awaiting:
            r = self.rf
            self.result = {"A": r.A, "F": r.F, "B": r.B, "C": r.C, "D": r.D, "E": r.E, "HL": r.HL}
            self.awaiting = False
        if not self.pending:
            return
        label, regs = self.pending.pop(0)
        bank, addr = self.sym[label] if isinstance(label, str) else label
        r, m = self.rf, self.mem
        sp = (r.SP - 2) & 0xffff
        m[sp], m[sp + 1] = r.PC & 0xff, r.PC >> 8
        r.SP = sp
        for k, v in regs.items():
            setattr(r, k, v)
        r.A, r.HL = bank, addr
        r.PC = self.sym["CallHLInBankA"][1]
        self.awaiting = True

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
        """Run `label` (any bank) from the idle loop, with these registers;
        self.result then holds the registers it returned (once the loop is
        back)."""
        self.pending.append((label, regs))
        for i in range(1200):
            self.tick()
            if not self.pending:
                self.tick(2)
                return
            if i % 60 == 59:
                self.press("a")
        raise AssertionError(f"{label} was never called")

    def warp(self, location, entry, frames=1500):
        """Send the player to a location's entry point, as a scripted warp
        does, from the idle loop; -> the location the idle loop runs in
        next (after a cutscene, if it plays out)."""
        self.wram("wStoryModeCurrentLocation", location)
        self.wram("wStoryModeEntryPoint", entry)
        self.wram("wStoryModeExitTriggerRequest", 0xff)
        start = self.idle
        for i in range(frames):
            self.tick()
            if self.idle > start + 30:
                return self.mem[self.addr("wStoryModeCurrentLocation")]
            if i % 90 == 89:
                self.press("a")
        return None

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
            counts = bytearray(self.sram("sApClientItems", self.addr("sApRecentItems") - self.addr("sApClientItems")))
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
    # a first Master clear: the reward sets the Master flag, which must not
    # turn the same run into Expert
    master = g.addr("wGameFlags") + 219 // 8
    g.mem[master] &= ~(0x80 >> 219 % 8) & 0xff
    g.wram("wCurrentMinigameStoryMatch", 2, c["MINIGAME_WALL_PRACTICE_HIGH_SCORE"])
    g.call("SetRewardGameFlag")
    assert g.done(c["LOC_WALL_PRACTICE_MASTER"]), "a first Master clear missed its location"


PRACTICES = [("SINGLES", 0, 0, "JUNIOR"), ("SINGLES", 0, 5, "SENIOR"), ("SINGLES", 0, 10, "VARSITY"),
             ("DOUBLES", 1, 0, "JUNIOR"), ("DOUBLES", 1, 5, "SENIOR"), ("DOUBLES", 1, 10, "VARSITY")]


@test
def practice_matches_are_locations(g, c):
    for arc, matchlist, index, tier in PRACTICES:
        loc = c[f"LOC_{tier}_{arc}_PRACTICE"]
        assert inline_test(g, include_value("AP_TEST_OPEN"), loc), f"{tier} {arc} practice not open before its win"
        g.wram("wCurrentMinigameStoryMatch", matchlist, index)
        g.call("SetRewardGameFlag")
        assert g.done(loc), f"{tier} {arc} practice win not marked done"
        assert not inline_test(g, include_value("AP_TEST_OPEN"), loc), f"{tier} {arc} practice still open once done"


@test
def ap_open_absent(g, c):
    assert not inline_test(g, include_value("AP_TEST_OPEN"), c["LOC_JUNIOR_SINGLES_PRACTICE"]), "an absent location read as open"


ap_open_absent.tokens = lambda c: {("ApPlacements", c["LOC_JUNIOR_SINGLES_PRACTICE"]): b"\xff"}

STORYLOC_COURTYARD_ = 0x07
STORYLOC_JUNIOR_SINGLES, STORYLOC_JUNIOR_DOUBLES, STORYLOC_SENIOR = 0x0b, 0x0c, 0x10
FLAG_DOUBLES = 47
# the practice NPC's script on each court once every win is in and every pass held
LATE_PRACTICE_NPCS = [
    (False, STORYLOC_JUNIOR_SINGLES, "ApJuniorSinglesBrianD_11", (0, 0), "LOC_JUNIOR_SINGLES_PRACTICE"),
    (False, STORYLOC_SENIOR, "SeniorCourtNpc08Beth_12", (0, 5), "LOC_SENIOR_SINGLES_PRACTICE"),
    (False, STORYLOC_COURTYARD_, "VarsityCourtSinglesCompleteNpc05Fay_13", (0, 10), "LOC_VARSITY_SINGLES_PRACTICE"),
    (True, STORYLOC_JUNIOR_DOUBLES, "JuniorClassCourtDoublesStoryCompleteNpc0AAllie_11", (1, 0), "LOC_JUNIOR_DOUBLES_PRACTICE"),
    (True, STORYLOC_SENIOR, "SeniorCourtNpc0ABob_12", (1, 5), "LOC_SENIOR_DOUBLES_PRACTICE"),
    (True, STORYLOC_COURTYARD_, "VarsityCourtDoublesCompleteNpc05Fay_13", (1, 10), "LOC_VARSITY_DOUBLES_PRACTICE"),
]


WIN_FLAGS = list(range(64, 73)) + list(range(80, 89))


def practice_offered(g, location, handler):
    """Warp to `location`, run an NPC `handler` answering yes -> the
    (match list, match) a story match was set up for, or None."""
    assert g.warp(location, 0x01) == location, f"warp to {location:#x} failed"
    seen = []
    b, a = g.sym["LoadMatchSettingsFromTable"]
    g.pb.hook_register(b, a, lambda _: seen.append(tuple(g.mem[g.addr("wCurrentMinigameStoryMatch") + i]
                                                         for i in range(2))), None)
    g.pending.append((handler, {}))
    for i in range(900):
        g.tick()
        if seen:
            break
        if i % 40 == 39:
            g.press("a")
    g.pb.hook_deregister(b, a)
    return seen[0] if seen else None


def set_done(g, loc, on):
    byte = bytearray(g.sram("sApDoneBits", offset=loc // 8))
    byte[0] = byte[0] | (1 << loc % 8) if on else byte[0] & ~(1 << loc % 8) & 0xff
    g.sram_write("sApDoneBits", bytes(byte), offset=loc // 8)
    g.seal("sApGameRegion", "sApGameChecksum")


def practice_late_test(doubles, location, handler, match, loc):
    """Every ranking match won and every pass held, so each court is past
    its vanilla practice window: the NPC offers the practice only while
    its location is open."""
    def fn(g, c):
        for flag in WIN_FLAGS:
            set_flag(g, flag, True)
        set_flag(g, FLAG_DOUBLES, doubles)
        set_done(g, c[loc], True)
        assert practice_offered(g, location, handler) is None, f"{handler} offered a done practice"
        set_done(g, c[loc], False)
        assert practice_offered(g, location, handler) == match, f"{handler} did not offer the practice"
    fn.tokens = lambda c: {("ApStartInventory", c["ITEM_SINGLES_PASS"]): b"\x04",
                           ("ApStartInventory", c["ITEM_DOUBLES_PASS"]): b"\x04"}
    return fn


for _case in LATE_PRACTICE_NPCS:
    TESTS[f"practice_late_{_case[2]}"] = practice_late_test(*_case)


@test
def senior_practice_needs_a_pass(g, c):
    for flag in WIN_FLAGS:
        set_flag(g, flag, True)
    set_flag(g, FLAG_DOUBLES, False)
    assert practice_offered(g, STORYLOC_SENIOR, "SeniorCourtNpc08Beth_12") is None, "Senior practice without a pass"


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


check_minigames.tokens = lambda c: placements(c, {"LOC_TARGET_SHOT_3": "ITEM_TARGET_SHOT"})


def two_on_one_length(g):
    """(games, sets) Two-on-One level 3 starts RunMatch with."""
    seen = []
    b, a = g.sym["RunMatch"]
    g.pb.hook_register(b, a, lambda _: seen.append((g.mem[g.addr("wMatchTypeNumberOfGames")],
                                                    g.mem[g.addr("wMatchTypeNumberOfSets")])), None)
    g.wram("wMinigameLevel", 2)
    g.pending.append(("RunTwoOnOneMatch", {}))
    for _ in range(600):
        g.tick()
        if seen:
            return seen[0]
    raise AssertionError("RunMatch never started")


@test
def two_on_one_vanilla(g, c):
    assert two_on_one_length(g) == (6, 5)


@test
def two_on_one_nerfed(g, c):
    assert two_on_one_length(g) == (2, 5)


two_on_one_nerfed.tokens = lambda c: {"ApOptTwoOnOneGames": b"\x02"}


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


@test
def messages_hidden(g, c):
    g.wram("wCurrentMinigameStoryMatch", 0, 1)
    g.call("SetRewardGameFlag")
    assert g.message() is None, "a found item's message showed with item_messages off"
    assert g.mem[g.addr("wApApplied") + c["ITEM_IRON_RACKET"]] == 1, "Iron Racket not applied to the slot"
    g.receive([(c["ITEM_SMALL_RACKET"], "Alice")])
    assert g.message() is None, "a received item's message showed with item_messages off"
    assert g.mem[g.addr("wApApplied") + c["ITEM_SMALL_RACKET"]] == 1, "Small Racket not applied to the slot"


messages_hidden.tokens = lambda c: {"ApOptHideMessages": b"\x01",
                                    **placements(c, {"LOC_JUNIOR_SINGLES_RANK_4": "ITEM_IRON_RACKET"})}


def goal(g):
    return g.sram("sApGoal")[0]


@test
def goal_island_open_both_arcs(g, c):
    g.wram("wCurrentMinigameStoryMatch", 0, 19)
    g.call("SetRewardGameFlag")
    assert not goal(g), "one arc's final is not the goal under both"
    g.wram("wCurrentMinigameStoryMatch", 1, 19)
    g.call("SetRewardGameFlag")
    assert goal(g)


@test
def goal_dream_match_singles(g, c):
    g.wram("wCurrentMinigameStoryMatch", 0, 19)
    g.call("SetRewardGameFlag")
    assert not goal(g)
    g.wram("wCurrentMinigameStoryMatch", 0, 24)
    g.call("SetRewardGameFlag")
    assert goal(g)


goal_dream_match_singles.tokens = lambda c: {"ApOptGoal": b"\x01", "ApOptStoryArcs": b"\x01"}


@test
def goal_completionist_and_absent(g, c):
    g.wram("wCurrentMinigameStoryMatch", 0, 1)
    g.call("SetRewardGameFlag")
    assert not g.done(c["LOC_JUNIOR_SINGLES_RANK_4"]), "an absent location was marked done"
    for index in (2, 3):
        g.wram("wCurrentMinigameStoryMatch", 0, index)
        g.call("SetRewardGameFlag")
        assert not goal(g)
    g.wram("wCurrentMinigameStoryMatch", 0, 4)
    g.call("SetRewardGameFlag")
    assert goal(g)


goal_completionist_and_absent.tokens = lambda c: {
    "ApOptGoal": b"\x02", "ApOptLocationCount": b"\x03",
    ("ApPlacements", c["LOC_JUNIOR_SINGLES_RANK_4"]): b"\xff"}


@test
def minigame_gates(g, c):
    char = {}
    for game in range(9):
        g.call("GetUnlockedMarioCastCharAtGridSlot", C=game)
        g.tick(30)
        char[game] = g.result["A"]
    assert char[3] == 0x19, char
    assert all(char[k] == 0x15 for k in char if k != 3), char
    g.call("CheckMinigameGridExpanded")
    g.tick(30)
    assert g.result["A"] == 1
    for game, cleared, want in ((3, 0, 1), (3, 2, 1), (0, 2, 0)):
        g.call("ApMinigameLevels", E=game, D=cleared)
        g.tick(30)
        assert g.result["A"] == want, (game, cleared, g.result["A"])


minigame_gates.tokens = lambda c: {"ApOptMinigames": b"\x01",
                                   ("ApStartInventory", c["ITEM_TARGET_SHOT"]): b"\x02"}


def match_length(g):
    return g.mem[g.addr("wMatchTypeNumberOfSets")], g.mem[g.addr("wMatchTypeNumberOfGames")]


@test
def match_length_vanilla(g, c):
    g.wram("wCurrentMinigameStoryMatch", 0, 19)
    g.call("LoadMatchSettingsFromTable")
    assert match_length(g) != (1, 2), match_length(g)


@test
def match_length_override(g, c):
    g.wram("wCurrentMinigameStoryMatch", 0, 19)
    g.call("LoadMatchSettingsFromTable")
    assert match_length(g) == (1, 2), match_length(g)


match_length_override.tokens = lambda c: {"ApOptMatchSets": b"\x01", "ApOptMatchGames": b"\x02"}


STORYLOC_ACADEMY_ENTRANCE, STORYLOC_DORM_ROOM = 0x14, 0x0a


@test
def skip_intro(g, c):
    assert g.warp(STORYLOC_ACADEMY_ENTRANCE, 0x0f, frames=900) == STORYLOC_DORM_ROOM, "never idle in the Dorm Room"
    assert g.mem[g.addr("wStoryModeEntryPoint")] == 0x01
    if SHOTS:
        g.screenshot(SHOTS / "skip_intro.png")
    assert g.mem[g.addr("wGameFlags") + 47 // 8] & (0x80 >> 47 % 8), "story_arcs: doubles did not set FLAG_DOUBLES"


skip_intro.tokens = lambda c: {"ApOptSkipIntro": b"\x01", "ApOptStoryArcs": b"\x02"}


@test
def no_skip_intro(g, c):
    assert g.warp(STORYLOC_ACADEMY_ENTRANCE, 0x0f, frames=600) != STORYLOC_DORM_ROOM


CHARREC_EXP = 0x2c


def word(g, label):
    a = g.addr(label)
    return g.mem[a] | g.mem[a + 1] << 8


def total_exp(g):
    """The main character's and the partner's EXP together."""
    rec = g.addr("wStoryMainName")
    return sum(g.mem[rec + slot * 0x40 + CHARREC_EXP + i] << 8 * i for slot in (0, 1) for i in range(3))


@test
def exp_bundles_at_char_data(g, c):
    g.tick(30)
    assert word(g, "wN64TransferMainExp") == 300, word(g, "wN64TransferMainExp")
    before = total_exp(g)
    # the pause menu: Status, then Char Data
    g.press("start", wait=60)
    g.press("a", wait=60)
    g.press("a", wait=150)
    for _ in range(4):
        g.press("a", wait=60)
    # hold A to hand out every point, then OK? Yes, then leave the stats
    g.pb.button_press("a")
    g.tick(1500)
    g.pb.button_release("a")
    start = g.idle
    for i in range(12):
        g.press("up" if i == 0 else "a", wait=90)
        if g.idle > start + 30:
            break
    else:
        raise AssertionError("never came back from Char/Partner Data")
    assert word(g, "wN64TransferMainExp") == 0, "the pending EXP was not awarded"
    assert total_exp(g) > before, (before, total_exp(g))


exp_bundles_at_char_data.tokens = lambda c: {("ApStartInventory", c["ITEM_EXP_BUNDLE"]): b"\x03"}


def boot_message_speed(rom, sym, save, tokens):
    """-> wMessageSpeed once the boot has set up story mode (a new game's default)."""
    g = Game(rom, sym, save, tokens)
    try:
        g.tick(400)
        return g.mem[g.addr("wMessageSpeed")]
    finally:
        g.close()


def boot_without_ledger(rom, sym, save):
    """A cart whose save has no ledger: -> (header magic, save flags) after boot."""
    g = Game(rom, sym, save, ledger=False)
    try:
        g.tick(400)
        return g.sram("sApMagic", 4), g.sram("sSaveFlags", 8)
    finally:
        g.close()


@test
def default_camera_mode(g, c):
    g.call("EraseStorySlotSaveData")
    g.call("TestStorySlotCourtView")
    g.tick(30)
    assert g.result["A"] == 1, "a new file did not start with the PLAYER camera"


default_camera_mode.tokens = lambda c: {"ApOptCameraMode": b"\x01"}


@test
def default_camera_mode_vanilla(g, c):
    g.call("EraseStorySlotSaveData")
    g.call("TestStorySlotCourtView")
    g.tick(30)
    assert g.result["A"] == 0


def set_flag(g, n, on):
    a, bit = g.addr("wGameFlags") + n // 8, 0x80 >> (n % 8)
    g.mem[a] = (g.mem[a] | bit) if on else (g.mem[a] & ~bit & 0xff)


def varsity_table(g):
    """The NpcScripts table SetupVarsityCourtSceneVariant leaves for singles before the Varsity win."""
    set_flag(g, 47, False)
    set_flag(g, 88, False)
    p = g.addr("wMapNpcScriptsPtr")
    g.mem[p] = g.mem[p + 1] = 0
    g.call("SetupVarsityCourtSceneVariant")
    return g.mem[p] | g.mem[p + 1] << 8


@test
def varsity_needs_two_passes(g, c):
    assert varsity_table(g) != g.addr("VarsityCourtSinglesNpcScripts_13"), "Kevin's match without the passes"


@test
def varsity_opens_at_two_passes(g, c):
    assert varsity_table(g) == g.addr("VarsityCourtSinglesNpcScripts_13"), "no Kevin's match with two passes"


varsity_opens_at_two_passes.tokens = lambda c: {("ApStartInventory", c["ITEM_SINGLES_PASS"]): b"\x02"}


STORYLOC_COURTYARD = 0x07
FLAG_DOUBLES, FLAG_WON_VARSITY_DOUBLES, FLAG_WON_VARSITY_SINGLES = 47, 72, 88


def varsity_won_table(g, doubles):
    """The NpcScripts table once the arc's Varsity match is won."""
    set_flag(g, FLAG_DOUBLES, doubles)
    set_flag(g, FLAG_WON_VARSITY_DOUBLES, True)
    set_flag(g, FLAG_WON_VARSITY_SINGLES, True)
    p = g.addr("wMapNpcScriptsPtr")
    g.mem[p] = g.mem[p + 1] = 0
    g.call("SetupVarsityCourtSceneVariant")
    return g.mem[p] | g.mem[p + 1] << 8


@test
def varsity_won_no_rematch(g, c):
    assert varsity_won_table(g, False) == g.addr("ApVarsityWonNpcScriptsA_13"), "Kevin offers his match again"
    assert varsity_won_table(g, True) == g.addr("ApVarsityWonNpcScriptsB_13"), "Kevin offers the doubles match again"


varsity_won_no_rematch.tokens = lambda c: {("ApStartInventory", c["ITEM_SINGLES_PASS"]): b"\x02",
                                           ("ApStartInventory", c["ITEM_DOUBLES_PASS"]): b"\x02"}


@test
def varsity_victory_returns_to_courtyard(g, c):
    set_flag(g, FLAG_DOUBLES, False)
    set_flag(g, FLAG_WON_VARSITY_SINGLES, True)
    assert g.warp(STORYLOC_COURTYARD, 0x0e, frames=6000) == STORYLOC_COURTYARD, \
        "the victory cutscene did not end in the Courtyard"


varsity_victory_returns_to_courtyard.tokens = varsity_opens_at_two_passes.tokens


STORYLOC_TOURNAMENT_COURTYARD, STORYLOC_TOURNAMENT, STORYLOC_ISLAND_SKY = 0x15, 0x19, 0x1b
FLAG_REACHED_ISLAND_OPEN_SINGLES, FLAG_ISLAND_OPEN_ROUNDS = 174, (60, 61, 62, 63)


@test
def island_open_by_the_front_gate(g, c):
    set_flag(g, 47, False)
    for n in (FLAG_REACHED_ISLAND_OPEN_SINGLES, 176, *FLAG_ISLAND_OPEN_ROUNDS):
        set_flag(g, n, False)
    assert g.warp(STORYLOC_ISLAND_SKY, 0x01, frames=2400) == STORYLOC_TOURNAMENT_COURTYARD, \
        "Island Sky did not lead straight to the Tournament Courtyard"
    flags = g.addr("wGameFlags")
    assert g.mem[flags + 174 // 8] & (0x80 >> 174 % 8), "the first visit did not mark the Island Open reached"
    assert g.warp(STORYLOC_TOURNAMENT, 0x05, frames=2400) == STORYLOC_TOURNAMENT, "the Tournament did not load"


island_open_by_the_front_gate.tokens = lambda c: {("ApStartInventory", c["ITEM_SINGLES_PASS"]): b"\x03"}


STORYLOC_ACADEMY_ENTRANCE, STORYLOC_PEACHS_CASTLE = 0x14, 0x1d


def out_the_front_gate(g, answer):
    """Walk south from inside the Academy Entrance until the map changes,
    picking `answer` ("island" or "mario") from the gate's menu -> (asked,
    where the player ends up)."""
    assert g.warp(STORYLOC_ACADEMY_ENTRANCE, 0x01) == STORYLOC_ACADEMY_ENTRANCE
    g.wram("wApMessage", 0)
    asked = False
    for i in range(60):
        start = g.idle
        g.press("down", hold=20)
        if g.mem[g.addr("wApMessage")] == ord("I"):
            asked = True
            g.tick(30)
            # the Down held to walk in can have moved the cursor already
            if g.mem[g.sym["wMenuCursorRow"]] != (answer == "mario"):
                g.press("down", wait=10)
            g.press("a")
            break
        if g.mem[g.addr("wStoryModeCurrentLocation")] != STORYLOC_ACADEMY_ENTRANCE:
            break
        if g.idle == start:
            # someone wandered into the path to chat: answer, then step round them
            g.press("a", wait=20)
            g.press("left" if i % 2 else "right", hold=12)
    start = g.idle
    for _ in range(2400):
        g.tick()
        if g.mem[g.addr("wStoryModeCurrentLocation")] != STORYLOC_ACADEMY_ENTRANCE and g.idle > start + 30:
            break
        if g.idle == start:
            continue
        start = g.idle
    return asked, g.mem[g.addr("wStoryModeCurrentLocation")]


@test
def front_gate_asks_with_both_open(g, c):
    set_flag(g, 47, False)
    assert out_the_front_gate(g, "island") == (True, STORYLOC_TOURNAMENT_COURTYARD)
    r = out_the_front_gate(g, "mario")
    assert r == (True, STORYLOC_PEACHS_CASTLE), r


front_gate_asks_with_both_open.tokens = lambda c: {("ApStartInventory", c["ITEM_SINGLES_PASS"]): b"\x04"}


@test
def front_gate_backs_out(g, c):
    set_flag(g, 47, False)
    assert g.warp(STORYLOC_ACADEMY_ENTRANCE, 0x01) == STORYLOC_ACADEMY_ENTRANCE
    g.wram("wApMessage", 0)
    for _ in range(60):
        g.press("down", hold=20)
        if g.mem[g.addr("wApMessage")] == ord("I"):
            break
    else:
        raise AssertionError("never asked")
    g.tick(150)
    bank, actors = g.sym["wActors"]
    y = lambda: g.mem[bank, actors + include_value("ACTORF_Y") + 1]
    before = y()
    g.press("b", wait=120)
    g.wram("wApMessage", 0)
    g.tick(120)
    assert g.mem[g.addr("wStoryModeCurrentLocation")] == STORYLOC_ACADEMY_ENTRANCE, "B left the Academy"
    assert y() == before - 2, f"the player is at row {y()}, from {before}"
    assert g.mem[g.addr("wApMessage")] == 0, "the menu came back on its own"
    assert out_the_front_gate(g, "island") == (True, STORYLOC_TOURNAMENT_COURTYARD)


front_gate_backs_out.tokens = front_gate_asks_with_both_open.tokens


@test
def front_gate_island_open_only(g, c):
    set_flag(g, 47, False)
    assert out_the_front_gate(g, "island") == (False, STORYLOC_TOURNAMENT_COURTYARD)


front_gate_island_open_only.tokens = island_open_by_the_front_gate.tokens


STORYLOC_MAIN_MENU, STORYLOC_ACADEMY_WING = 0x00, 0x06
# per arc: Senior rank 1, Island Open reached, the final, story complete, castle reached
ARC_FLAGS = {False: (87, 174, 60, 176, 178), True: (70, 175, 53, 177, 179)}


def after_the_principal(g, doubles):
    """Play the principal's congratulations after an Island Open win, pressing
    A through its dialogue -> the locations the game passes through, until it
    settles in a story location or breaks to the main menu."""
    senior, reached, final, complete, castle = ARC_FLAGS[doubles]
    set_flag(g, FLAG_DOUBLES, doubles)
    for n in (senior, reached, final):
        set_flag(g, n, True)
    for n in (complete, castle):
        set_flag(g, n, False)
    g.wram("wStoryModeCurrentLocation", STORYLOC_ACADEMY_WING)
    g.wram("wStoryModeEntryPoint", 0x0f)
    g.wram("wStoryModeExitTriggerRequest", 0xff)
    seen, start = [STORYLOC_ACADEMY_WING], g.idle
    for i in range(6000):
        g.tick()
        where = g.mem[g.addr("wStoryModeCurrentLocation")]
        if where != seen[-1]:
            seen.append(where)
        if where == STORYLOC_MAIN_MENU:
            return seen
        if g.idle > start + 30:
            return seen
        if i % 90 == 89:
            g.press("a")
    raise AssertionError(f"the ending never settled: {seen}")


def arc_complete(g, doubles):
    n = ARC_FLAGS[doubles][3]
    return bool(g.mem[g.addr("wGameFlags") + n // 8] & (0x80 >> n % 8))


@test
def no_castle_flight_while_locked(g, c):
    for doubles in (False, True):
        seen = after_the_principal(g, doubles)
        assert seen == [STORYLOC_ACADEMY_WING], f"the ceremony went on to {seen}"
        assert arc_complete(g, doubles), "the arc was not marked complete"
        g.call("GetStoryContinueDestination")
        assert g.result["A"] == 0x02, f"Continue goes to {g.result['A']:#x}, not the dorm"


no_castle_flight_while_locked.tokens = lambda c: {("ApStartInventory", c["ITEM_SINGLES_PASS"]): b"\x03",
                                                  ("ApStartInventory", c["ITEM_DOUBLES_PASS"]): b"\x03"}


@test
def castle_flight_once_open(g, c):
    seen = after_the_principal(g, False)
    assert seen == [STORYLOC_ACADEMY_WING, STORYLOC_ACADEMY_ENTRANCE, STORYLOC_ISLAND_SKY, STORYLOC_MAIN_MENU], \
        f"the ending went {seen}, not out the gate and on the plane"
    assert arc_complete(g, False), "the arc was not marked complete"


castle_flight_once_open.tokens = front_gate_asks_with_both_open.tokens


@test
def gate_guard_tiers(g, c):
    set_flag(g, 47, False)
    for passes, tier in ((2, 4), (3, 6), (4, 8)):
        g.sram_write("sApClientItems", bytes([passes]), offset=c["ITEM_SINGLES_PASS"])
        g.seal("sApClientRegion", "sApClientChecksum")
        g.call("ApRankingProgressIndex")
        g.tick(10)
        assert g.result["A"] == tier, (passes, g.result["A"])


def inline_test(g, first, count):
    """Run `call ApTestInline / db first, count / ret` from WRAM (wApMessage's
    bytes) and -> whether it returned nz, with every register but af kept."""
    code = bytes([0xcd]) + g.addr("ApTestInline").to_bytes(2, "little") + bytes([first, count, 0xc9])
    g.wram("wApMessage", *code)
    g.call((0, g.addr("wApMessage")), B=0x12, C=0x34, D=0x56, E=0x78)
    g.tick(30)
    r = g.result
    assert (r["B"], r["C"], r["D"], r["E"]) == (0x12, 0x34, 0x56, 0x78), "ap_has clobbered a register"
    return not r["F"] & 0x80


@test
def ap_has_inline(g, c):
    lesson = c["ITEM_SERVICE_LESSON"]
    assert inline_test(g, lesson, 1), "2 Service Lessons held, ap_has 1 said no"
    assert inline_test(g, lesson, 2)
    assert not inline_test(g, lesson, 3), "ap_has 3 said yes with 2 held"
    assert not inline_test(g, c["ITEM_WALL_PRACTICE"], 1)
    assert inline_test(g, 0x80 | 0, 0), "ap_pass 0 said no"
    assert not inline_test(g, 0x80 | 0, 1), "ap_pass 1 said yes with no passes"


ap_has_inline.tokens = lambda c: {("ApStartInventory", c["ITEM_SERVICE_LESSON"]): b"\x02"}


def rally(g, b, c):
    g.call("ApFilterRallyButtonsFor", B=b, C=c)
    return g.result["B"], g.result["C"]


def serve(g, b):
    g.call("ApFilterServeButtonFor", B=b)
    return g.result["B"]


def smash_allowed(g, buttons):
    g.call("ApSmashAllowedFor", B=buttons)
    return not g.result["F"] & 0x80


SHOTTYPE_SERVE_SLICE = include_value("SHOTTYPE_SERVE_SLICE")


def serve_height(g, height):
    g.call("ApClampServeHeightFor", C=SHOTTYPE_SERVE_SLICE, D=(height >> 8) & 0xff, E=height & 0xff)
    return g.result["D"] << 8 | g.result["E"]


@test
def shot_filters(g, c):
    def get(*names):
        g.receive([(c[n], "") for n in names])

    assert rally(g, 1, 2) == (1, 0), "nothing owned: a lob falls back to topspin"
    assert serve(g, 2) == 1
    assert not smash_allowed(g, 0x30)
    get("ITEM_FLAT_SHOT")
    assert rally(g, 1, 0) == (3, 3), "flat only: topspin falls back to the flat fallback"
    assert rally(g, 3, 0) == (3, 0)
    assert not smash_allowed(g, 0x30), "smash with one Flat Shot"
    get("ITEM_SLICE")
    assert rally(g, 1, 2) == (2, 0), "slice comes before flat in the fallback"
    assert rally(g, 2, 2) == (2, 0), "power slice with one Slice"
    get("ITEM_TOPSPIN")
    assert rally(g, 1, 1) == (1, 0)
    get("ITEM_TOPSPIN", "ITEM_LOB", "ITEM_DROP_SHOT", "ITEM_FLAT_SHOT")
    assert rally(g, 1, 1) == (1, 1)
    assert rally(g, 1, 2) == (1, 2)
    assert rally(g, 2, 1) == (2, 1)
    assert smash_allowed(g, 0x30)
    assert not smash_allowed(g, 0x33), "a fallback swing smashed"
    get("ITEM_SLICE_SERVE")
    assert [serve(g, b) for b in (0, 1, 2, 3)] == [2, 2, 2, 2]
    get("ITEM_FLAT_SERVE")
    assert [serve(g, b) for b in (1, 2, 3)] == [2, 2, 3]
    assert serve_height(g, -0x180) == -0x14f & 0xffff, "nice slice serve with one copy"
    assert serve_height(g, -0x120) == -0x120 & 0xffff
    assert serve_height(g, -0x250) == -0x250 & 0xffff
    get("ITEM_SLICE_SERVE")
    assert serve_height(g, -0x180) == -0x180 & 0xffff, "clamped a nice slice serve with two copies"
    get("ITEM_TOPSPIN_SERVE")
    assert serve(g, 0) == 0, "an owned topspin serve's button 0 was rewritten"


shot_filters.tokens = lambda c: {"ApOptShotItems": b"\x01"}


def scale_exp(g, amount):
    g.call("ApScaleExp", D=amount >> 8, E=amount & 0xff)
    return g.result["D"] << 8 | g.result["E"]


@test
def exp_modifier_off(g, c):
    assert [scale_exp(g, n) for n in (0, 1, 1234, 0xffff)] == [0, 1, 1234, 0xffff]


@test
def exp_modifier_half(g, c):
    assert [scale_exp(g, n) for n in (0, 1, 3, 101, 0xffff)] == [0, 1, 1, 50, 0x7fff]


exp_modifier_half.tokens = lambda c: {"ApOptExpModifier": b"\x01"}


@test
def exp_modifier_quintuple(g, c):
    assert [scale_exp(g, n) for n in (0, 300, 13107, 13108)] == [0, 1500, 65535, 65535]


exp_modifier_quintuple.tokens = lambda c: {"ApOptExpModifier": b"\x0a"}


@test
def exp_bundle_scaled(g, c):
    assert int.from_bytes(g.mem[g.addr("wN64TransferMainExp"):g.addr("wN64TransferMainExp") + 2], "little") == 300, \
        "a tripled EXP Bundle"


exp_bundle_scaled.tokens = lambda c: {"ApOptExpModifier": b"\x06", ("ApStartInventory", c["ITEM_EXP_BUNDLE"]): b"\x01"}


GAME_ARGS = (ROOT / "mariotennis.gbc", ROOT / "build" / "mariotennis.sym", ROOT / "maxed-unlocked.sav")


def reward_outcome(g, frames=3000):
    """Run ProcessMatchRewards from the idle loop, answering its screens -> the
    award: the award screen's line 3 (wPendingExpAwardAmounts) when
    RunExpDistributionFlow starts, or for exhibition and link play the amount
    AwardExhibitionMatchExp / AwardLinkedPlayMatchExp are handed to store."""
    seen = []
    bank, base = g.sym["wPendingExpAwardAmounts"]
    hooks = [(g.sym["RunExpDistributionFlow"], lambda _: seen.append(g.mem[bank, base + 6] |
                                                                       g.mem[bank, base + 7] << 8)),
             (g.sym["AwardExhibitionMatchExp"], lambda _: seen.append(g.rf.HL)),
             (g.sym["AwardLinkedPlayMatchExp"], lambda _: seen.append(g.rf.HL))]
    for (b, a), fn in hooks:
        g.pb.hook_register(b, a, fn, None)
    g.pending.append(("ProcessMatchRewards", {}))
    for i in range(frames):
        g.tick()
        if seen:
            break
        if i % 30 == 29:
            g.press("a")
    for (b, a), _ in hooks:
        g.pb.hook_deregister(b, a)
    return seen[0] if seen else None


def match_reward_state(g, c, mode, matchlist, match, first_clear_flag):
    """A won match of `mode`, with its first clear still to come and a few games
    won by character 0, so every term of the award is in play."""
    set_flag(g, first_clear_flag, False)
    g.wram("wGameMode", include_value(mode))
    g.wram("wMatchWinLoseFlag", include_value("WINLOSE_WIN"))
    g.wram("wPointWinLoseFlag", include_value("WINLOSE_WIN"))
    g.wram("wMatchExitRequest", 0)
    g.wram("wMatchSuspendedFlag", 0)
    g.wram("wMinigameHighScoreMode", 0)
    g.wram("wMinigamesCurrentScore", 200, 0)
    g.wram("wTotalGamesPlayedInMatch", 6)
    g.wram("wLinkMatchRole", include_value("LINKSTATE_MASTER"))
    g.wram("wCurrentMinigameStoryMatch", matchlist, match)
    g.mem[include_value("WRAM_ACTORS"), include_value("wCharId")] = 0


EXP_SCENARIOS = {
    "drill": ("GAMEMODE_TRAINING_DRILL", 2, "MINIGAME_SERVICE_MATCH_1", "FLAG_CLEARED_SERVICE_MATCH_1"),
    "story": ("GAMEMODE_RANKING_MATCH", 0, "STORYMATCH_JUNIOR_4", "FLAG_WON_JUNIOR_SINGLES_RANK_4"),
    "wall": ("GAMEMODE_WALL_PRACTICE", 2, "MINIGAME_WALL_PRACTICE_1", "FLAG_CLEARED_WALL_LEVEL_1"),
    "exhibition": ("GAMEMODE_EXHIBITION", 0, "STORYMATCH_JUNIOR_4", "FLAG_WON_JUNIOR_SINGLES_RANK_4"),
    "link": ("GAMEMODE_LINK_MATCH", 0, "STORYMATCH_JUNIOR_4", "FLAG_WON_JUNIOR_SINGLES_RANK_4"),
}


def scenario_award(g, c, name):
    mode, matchlist, match, flag = EXP_SCENARIOS[name]
    match_id = c[match] if match.startswith("MINIGAME") else include_value(match)
    match_reward_state(g, c, mode, matchlist, match_id, include_value(flag))
    return reward_outcome(g)


def exp_scenario_test(name):
    """The award a `name` win makes at x1 (option byte 2) and at x2 (byte 4):
    nonzero, and exactly doubled."""
    def fn(g, c):
        single = scenario_award(g, c, name)
        other = Game(*GAME_ARGS, {"ApOptExpModifier": b"\x04"})
        try:
            other.to_overworld()
            double = scenario_award(other, c, name)
        finally:
            other.close()
        assert single, f"no {name} award at x1"
        assert double == 2 * single, f"{name}: {single} at x1 but {double} at x2"
    fn.tokens = lambda c: {"ApOptExpModifier": b"\x02"}
    return fn


for _name in EXP_SCENARIOS:
    TESTS[f"exp_modifier_{_name}_award"] = exp_scenario_test(_name)


def exp24(g, label):
    a = g.addr(label)
    return g.mem[a] | g.mem[a + 1] << 8 | g.mem[a + 2] << 16


def at_distribution_screen(g, frames=3000):
    """Start a Wall Level 1 award and run until its EXP distribution screen
    takes input -> the pool's (bank, address) and the award it opened with."""
    c = constants()
    match_reward_state(g, c, "GAMEMODE_WALL_PRACTICE", 2, c["MINIGAME_WALL_PRACTICE_1"],
                       include_value("FLAG_CLEARED_WALL_LEVEL_1"))
    seen = []
    pool = g.sym["wExpPoolRemaining"]
    b, a = g.sym["RunExpDistributionLoop"]
    g.pb.hook_register(b, a, lambda _: seen.append(pool_left(g, pool)), None)
    g.pending.append(("ProcessMatchRewards", {}))
    for i in range(frames):
        g.tick()
        if seen:
            break
        if i % 30 == 29:
            g.press("a")
    g.pb.hook_deregister(b, a)
    assert seen, "the distribution screen never opened"
    g.tick(60)
    return pool, seen[0]


def pool_left(g, where):
    bank, a = where
    return g.mem[bank, a] | g.mem[bank, a + 1] << 8


@test
def exp_select_assigns_all(g, c):
    saved = exp24(g, "wStoryMainExp")
    pool, award = at_distribution_screen(g)
    bank, stats = g.sym["wExpScreenCharStats"]
    gained = lambda: g.mem[bank, stats + 6] | g.mem[bank, stats + 7] << 8
    left, before = pool_left(g, pool), gained()
    assert award > 1000, f"a pool of {award}"
    g.press("select", wait=30)
    assert pool_left(g, pool) == 0, "Select left EXP in the pool"
    assert gained() == before + left, f"{gained() - before} of {left} reached the character"
    g.press("up", wait=10)
    for _ in range(60):
        if not g.awaiting:
            break
        g.press("a", wait=30)
    assert not g.awaiting, "the rewards never finished after Select"
    assert exp24(g, "wStoryMainExp") == saved + award, "the award was not saved to the character"


exp_select_assigns_all.tokens = lambda c: {"ApOptExpModifier": b"\x0a"}


@test
def exp_held_increase_accelerates(g, c):
    pool, award = at_distribution_screen(g)
    assert award > 1000, f"a pool of {award}"
    g.pb.button_press("right")
    for _ in range(700):
        g.tick()
        if pool_left(g, pool) == 0:
            break
    g.pb.button_release("right")
    assert pool_left(g, pool) == 0, f"{pool_left(g, pool)} of {award} left after 700 frames held"


exp_held_increase_accelerates.tokens = exp_select_assigns_all.tokens


def island_open_won(g, doubles=False, frames=12000):
    """Win the singles (or doubles) final and run CheckIslandOpenVictoryTransition ->
    (the (b, c) RunStorySceneByMode was given, or None; the (location, entry)
    the transition warped to)."""
    set_flag(g, include_value("FLAG_DOUBLES"), doubles)
    set_flag(g, include_value(f"FLAG_WON_ISLAND_OPEN_{'DOUBLES' if doubles else 'SINGLES'}_FINAL"), True)
    scene = []
    b, a = g.sym["RunStorySceneByMode"]
    g.pb.hook_register(b, a, lambda _: scene.append((g.rf.B, g.rf.C)), None)
    loc, entry = g.addr("wStoryModeCurrentLocation"), g.addr("wStoryModeEntryPoint")
    start = g.mem[loc]
    g.pending.append(("CheckIslandOpenVictoryTransition", {}))
    warp = None
    for i in range(frames):
        g.tick()
        if g.mem[loc] != start:
            warp = g.mem[loc], g.mem[entry]
            break
        if i % 30 == 29:
            g.press("a")
    g.pb.hook_deregister(b, a)
    return (scene[0] if scene else None), warp


@test
def ceremony_skipped(g, c):
    scene, warp = island_open_won(g)
    gender = g.mem[g.addr("wStoryMainGender")]
    assert scene == (1, gender + 4), f"the congratulations scene ran as {scene}"
    assert warp == (include_value("STORYLOC_ACADEMY_WING"), 0x0f), f"warped to {warp}"
    n = include_value("FLAG_AWARDS_CEREMONY_SEEN_SINGLES")
    assert g.mem[g.addr("wGameFlags") + n // 8] & 0x80 >> (n % 8), "the ceremony was not marked seen"


ceremony_skipped.tokens = lambda c: {"ApOptSkipCeremony": b"\x01"}


@test
def ceremony_skipped_doubles(g, c):
    scene, warp = island_open_won(g, doubles=True)
    main = g.mem[g.addr("wStoryMainGender")]
    partner = g.mem[g.addr("wStoryPartnerGender")]
    assert scene == (1, main << 1 | (main ^ partner)), f"the congratulations scene ran as {scene}"
    assert warp == (include_value("STORYLOC_ACADEMY_WING"), 0x0f), f"warped to {warp}"


ceremony_skipped_doubles.tokens = ceremony_skipped.tokens


@test
def ceremony_kept(g, c):
    scene, warp = island_open_won(g)
    assert scene is None, "the congratulations scene ran without skip_ceremony"
    assert warp == (include_value("STORYLOC_ISLAND_SKY"), 0x08), f"warped to {warp}"


def first_dream_match(g, doubles=False, frames=4000):
    """Accept Peach's first Dream Match offer -> the (list, match) it loads."""
    arc = "DOUBLES" if doubles else "SINGLES"
    set_flag(g, include_value("FLAG_DOUBLES"), doubles)
    for f in (f"FLAG_WON_ISLAND_OPEN_{arc}_FINAL", f"FLAG_STORY_COMPLETE_{arc}", f"FLAG_REACHED_MARIO_WORLD_{arc}"):
        set_flag(g, include_value(f), True)
    set_flag(g, include_value(f"FLAG_WON_DREAM_MATCH_{arc}"), False)
    assert g.warp(STORYLOC_PEACHS_CASTLE, 0x0e, frames=3000) == STORYLOC_PEACHS_CASTLE
    seen = []
    b, a = g.sym["RunStoryMatch"]
    m = g.addr("wCurrentMinigameStoryMatch")
    g.pb.hook_register(b, a, lambda _: seen.append((g.mem[m], g.mem[m + 1])), None)
    g.pending.append(("PromptExhibitionMatch", {}))
    for i in range(frames):
        g.tick()
        if seen:
            break
        if i % 30 == 29:
            g.press("a")
    g.pb.hook_deregister(b, a)
    return seen[0] if seen else None


def dream_match_test(choice, match, doubles=False):
    def fn(g, c):
        got = first_dream_match(g, doubles)
        want = (include_value("MATCHLIST_DOUBLES" if doubles else "MATCHLIST_SINGLES"), include_value(match))
        assert got == want, f"Peach's first offer loaded {got}, not {match}"
    fn.tokens = lambda c: {"ApOptDreamDifficulty": bytes([choice])}
    return fn


for _choice, _match in ((0, "STORYMATCH_DREAM_INTENSE"), (1, "STORYMATCH_DREAM_HARD"),
                        (2, "STORYMATCH_DREAM_INTENSE"), (3, "STORYMATCH_DREAM_MAX")):
    TESTS[f"dream_match_difficulty_{_choice}"] = dream_match_test(_choice, _match)
TESTS["dream_match_difficulty_doubles"] = dream_match_test(3, "STORYMATCH_DREAM_MAX", doubles=True)


@test
def exp_modifier_normal(g, c):
    assert [scale_exp(g, n) for n in (0, 1, 1234, 0xffff)] == [0, 1, 1234, 0xffff]


exp_modifier_normal.tokens = lambda c: {"ApOptExpModifier": b"\x02"}


@test
def shots_ungated_by_default(g, c):
    g.call("ApShotsGated")
    assert g.result["F"] & 0x80, "shots gated with ApOptShotItems 0"


WRAM_CHAR0, CHAR_INPUT_SOURCE, CHAR_SHOT_BUTTON1, CHAR_SHOT_BUTTON2 = (
    include_value(n) for n in ("WRAM_CHAR0", "wCharInputSource", "wCharShotButton1", "wCharShotButton2"))
SHOTTYPE_TOPSPIN, SHOTTYPE_NEUTRAL, SHOTTYPE_REACH, SHOTTYPE_SERVE_TOPSPIN = (
    include_value(f"SHOTTYPE_{n}") for n in ("TOPSPIN", "NEUTRAL", "REACH", "SERVE_TOPSPIN"))
POINTOUTCOME_FAULT, POINTOUTCOME_DOUBLE_FAULT = (include_value(f"POINTOUTCOME_{n}") for n in ("FAULT", "DOUBLE_FAULT"))


def play_match(g, frames, peak_toss=False):
    """Play a short Junior Rank 4 match with the CPU driving character 0, which
    the shot gates still take for the player (input source 0 while they ask);
    character 0 presses every button pair and serve in turn. -> the shots
    (character, wCurrentShotType, wLastShotButtons, wPowerServeFlag) and the
    faults seen. peak_toss serves every ball from the top of the toss."""
    m = g.mem
    shots, faults = [], []
    pairs, n = [(1, 1), (2, 2), (1, 2), (2, 1), (3, 0), (1, 0), (2, 0)], [0, 0]

    def char0():
        return m[0xff70] & 7 == WRAM_CHAR0

    def read_input(_):
        if char0():
            m[CHAR_INPUT_SOURCE] = 1

    def gated(_):
        if char0():
            m[CHAR_INPUT_SOURCE] = 0

    def rally(_):
        if char0():
            m[CHAR_SHOT_BUTTON1], m[CHAR_SHOT_BUTTON2] = pairs[n[0] % len(pairs)]
            n[0] += 1

    def serve(_):
        if char0():
            m[CHAR_SHOT_BUTTON1] = 1 + n[1] % 3
            n[1] += 1

    def serve_path(_):
        if peak_toss:
            g.wram("wBallHeight", 0x80, 0xfe)  # -$180

    def hit(_):
        shots.append((m[g.addr("wLastShotCharIndex")], m[g.addr("wCurrentShotType")],
                      m[g.addr("wLastShotButtons")], m[g.addr("wPowerServeFlag")]))

    for label, fn, off in (("ReadCharInput", read_input, 0), ("ApShotsGated", gated, 0),
                           ("SelectRallyShotType", rally, 0), ("SelectServeShotType", serve, 0),
                           ("ApServeBallPath", serve_path, 0), ("HandleBallHitEvent", hit, 5)):
        b, a = g.sym[label]
        g.pb.hook_register(b, a + off, fn, None)
    g.call("InitStoryMatchSettings")
    g.wram("wCurrentMinigameStoryMatch", 0, 1)
    g.call("LoadMatchSettingsFromTable")
    g.pending.append(("RunStoryMatch", {}))
    last = 0
    for _ in range(frames):
        g.tick()
        outcome = m[g.addr("wPointOutcome")]
        if outcome != last and outcome in (POINTOUTCOME_FAULT, POINTOUTCOME_DOUBLE_FAULT):
            faults.append(outcome)
        last = outcome
    return shots, faults


def match_tokens(c, **items):
    t = {"ApOptShotItems": b"\x01", "ApOptMatchSets": b"\x01", "ApOptMatchGames": b"\x06"}
    t.update({("ApStartInventory", c["ITEM_" + k]): bytes([v]) for k, v in items.items()})
    return t


@test
def shots_topspin_only_in_a_match(g, c):
    shots, _ = play_match(g, 60000)
    mine = {(t, b) for ci, t, b, _ in shots if ci == 0}
    assert len(mine) > 0 and len([s for s in shots if s[0] == 0]) > 50, "the player hardly hit the ball"
    assert {t for t, _ in mine} <= {SHOTTYPE_TOPSPIN, SHOTTYPE_REACH, SHOTTYPE_SERVE_TOPSPIN}, mine
    assert {b for _, b in mine} == {0x10}, mine
    assert {t for ci, t, *_ in shots if ci} - {SHOTTYPE_TOPSPIN, SHOTTYPE_SERVE_TOPSPIN}, "the CPU was gated"


shots_topspin_only_in_a_match.tokens = lambda c: match_tokens(c, TOPSPIN=1, TOPSPIN_SERVE=1)


@test
def shots_flat_only_in_a_match(g, c):
    shots, _ = play_match(g, 60000)
    mine = {(t, b) for ci, t, b, _ in shots if ci == 0}
    assert mine <= {(SHOTTYPE_NEUTRAL, 0x33), (SHOTTYPE_NEUTRAL, 0x30), (SHOTTYPE_SERVE_SLICE, 0x20)}, mine
    assert (SHOTTYPE_NEUTRAL, 0x33) in mine, "no fallback swing"


shots_flat_only_in_a_match.tokens = lambda c: match_tokens(c, FLAT_SHOT=1, SLICE_SERVE=1)


@test
def nice_serve_needs_its_second_copy(g, c):
    shots, faults = play_match(g, 30000, peak_toss=True)
    serves = [nice for ci, t, _, nice in shots if ci == 0 and t >= SHOTTYPE_SERVE_TOPSPIN]
    assert serves and not any(serves), "a nice serve with one copy"
    assert not faults, "a lowered peak-toss serve faulted"


nice_serve_needs_its_second_copy.tokens = lambda c: match_tokens(c, TOPSPIN=1, TOPSPIN_SERVE=1, SLICE_SERVE=1,
                                                                FLAT_SERVE=1)


@test
def everything_owned_plays_as_vanilla(g, c):
    shots, _ = play_match(g, 30000, peak_toss=True)
    mine = [s for s in shots if s[0] == 0]
    assert {t for _, t, *_ in mine} > {SHOTTYPE_TOPSPIN, SHOTTYPE_NEUTRAL, SHOTTYPE_SERVE_TOPSPIN}, mine
    assert all(nice for _, t, _, nice in mine if t >= SHOTTYPE_SERVE_TOPSPIN), "a peak-toss serve was not nice"


everything_owned_plays_as_vanilla.tokens = lambda c: match_tokens(
    c, TOPSPIN=2, SLICE=2, FLAT_SHOT=2, LOB=1, DROP_SHOT=1, TOPSPIN_SERVE=2, SLICE_SERVE=2, FLAT_SERVE=2)


WINLOSE_LOSE = include_value("WINLOSE_LOSE") & 0xff
AP_DEATHLINK_POINT, AP_DEATHLINK_GAME, AP_DEATHLINK_MATCH = (
    include_value(f"AP_DEATHLINK_{n}") for n in ("POINT", "GAME", "MATCH"))


def cpu_serves_for_player(g):
    """Have the CPU serve for character 0 (input source 1 while ReadCharInput
    asks, before the serve is hit); otherwise it stands idle, so it loses
    rallies (two CPUs can rally for ever)."""
    def read_input(_):
        if g.mem[0xff70] & 7 == WRAM_CHAR0:
            g.mem[CHAR_INPUT_SOURCE] = 0 if g.mem[g.addr("wRallyLength")] else 1
    b, a = g.sym["ReadCharInput"]
    g.pb.hook_register(b, a, read_input, None)


def start_story_match(g, cpu_serves=False):
    """Start a Junior Rank 4 story match from the idle loop."""
    if cpu_serves:
        cpu_serves_for_player(g)
    g.call("InitStoryMatchSettings")
    g.wram("wCurrentMinigameStoryMatch", 0, 1)
    g.call("LoadMatchSettingsFromTable")
    g.pending.append(("RunStoryMatch", {}))


def start_minigame(g, mode, minigame, level=0):
    """Start drill or minigame `minigame` from the idle loop, through
    RunTrainingDrillByID as the menus do."""
    g.wram("wGameMode", include_value(mode))
    g.wram("wMinigameLevel", level)
    b, a = g.sym["RunTrainingDrillByID"]
    first = []

    def set_id(_):
        if not first:
            first.append(1)
            g.rf.A = minigame
    g.pb.hook_register(b, a, set_id, None)
    g.pending.append(("RunTrainingDrillByID", {}))


def deathlink_at_first_rally(g, label, level, source=b"Tester"):
    """Write a received death (as the client does) the first time `label`
    (a rally-frame poll) runs."""
    fired = []

    def inject(_):
        if not fired and g.mem[g.addr("wApDeathInMatch")]:
            fired.append(g.pb.frame_count)
            g.wram("wApDeathSource", *source, 0)
            g.wram("wApDeathIn", level)
    b, a = g.sym[label]
    g.pb.hook_register(b, a, inject, None)
    return fired


def until(g, cond, frames, press_every=0):
    for i in range(frames):
        g.tick()
        if cond():
            return True
        if press_every and i % press_every == press_every - 1:
            g.press("a")
    return False


def score(g):
    return {n: g.mem[g.addr(n)] for n in ("wPlayer1SetsWon", "wPlayer2SetsWon", "wPlayer1GamesWon",
                                          "wPlayer2GamesWon", "wPlayer1PointsWon", "wPlayer2PointsWon")}


def deathlink_message(g, frames=600):
    """The DeathLink message, once it shows (None if it never does)."""
    for _ in range(frames):
        g.tick()
        buf = bytes(g.mem[g.addr("wTextBuffer") + i] for i in range(48))
        if buf.startswith(b"DeathLink"):
            return buf.split(b"\0")[0].replace(b"\x01", b"/").replace(b"\x03", b"").decode()
    return None


def receive_in_match(g, level, before=None, start=start_story_match):
    """A received death of `level` at the first rally of a match -> (the
    score and the flags once it is scored, wApDeathOut then, the message)."""
    start(g)
    seen = []
    b, a = g.sym["ResolvePointOutcome"]

    def scored(_):
        if not seen:
            flags = {n: g.mem[g.addr(n)] for n in ("wPointWinLoseFlag", "wGameWinLoseFlag", "wSetWinLoseFlag",
                                                   "wMatchWinLoseFlag", "wPointOutcome")}
            seen.append((score(g), flags, g.mem[g.addr("wApDeathOut")]))
    g.pb.hook_register(b, a, scored, None)
    if before:
        b2, a2 = g.sym["PlayPoint"]
        g.pb.hook_register(b2, a2, lambda _: before(g), None)
    fired = deathlink_at_first_rally(g, "ApDeathLinkPoll", level)
    assert until(g, lambda: seen, 6000), "the death never ended the point"
    assert fired
    return (*seen[0], deathlink_message(g))


@test
def deathlink_off_outside_a_match(g, c):
    assert g.mem[g.addr("wApDeathInMatch")] == 0


@test
def deathlink_receive_point(g, c):
    s, flags, out, text = receive_in_match(g, AP_DEATHLINK_POINT)
    assert flags["wPointOutcome"] == include_value("POINTOUTCOME_DEATHLINK"), flags
    assert flags["wPointWinLoseFlag"] == WINLOSE_LOSE and not flags["wGameWinLoseFlag"], flags
    assert (s["wPlayer1PointsWon"], s["wPlayer2PointsWon"]) == (0, 1), s
    assert out == 0, f"the received death was reported back ({out})"
    assert text == "DeathLink/from Tester!", text


@test
def deathlink_receive_game(g, c):
    s, flags, out, _ = receive_in_match(g, AP_DEATHLINK_GAME)
    assert flags["wGameWinLoseFlag"] == WINLOSE_LOSE and not flags["wSetWinLoseFlag"], flags
    assert (s["wPlayer1GamesWon"], s["wPlayer2GamesWon"]) == (0, 1), s
    assert out == 0, f"the received death was reported back ({out})"


deathlink_receive_game.tokens = lambda c: {"ApOptMatchSets": b"\x01", "ApOptMatchGames": b"\x06"}


@test
def deathlink_receive_match(g, c):
    s, flags, out, _ = receive_in_match(g, AP_DEATHLINK_MATCH)
    assert flags["wMatchWinLoseFlag"] == WINLOSE_LOSE, flags
    assert s["wPlayer2SetsWon"] == 2, s
    assert out == 0, f"the received death was reported back ({out})"
    assert until(g, lambda: not g.mem[g.addr("wApDeathInMatch")], 6000, press_every=30), "still live after the match"


deathlink_receive_match.tokens = lambda c: {"ApOptMatchSets": b"\x03", "ApOptMatchGames": b"\x06"}


def tiebreak(g):
    g.wram("wPlayer1GamesWon", 6, 6)
    g.wram("wTiebreakerIndicator", 1)


@test
def deathlink_receive_game_in_a_tiebreak(g, c):
    s, flags, out, _ = receive_in_match(g, AP_DEATHLINK_GAME, before=tiebreak)
    assert flags["wSetWinLoseFlag"] == WINLOSE_LOSE and flags["wMatchWinLoseFlag"] == WINLOSE_LOSE, flags
    assert out == 0, f"the received death was reported back ({out})"


deathlink_receive_game_in_a_tiebreak.tokens = lambda c: {"ApOptMatchSets": b"\x01", "ApOptMatchGames": b"\x06"}


@test
def deathlink_receive_match_in_short_sets(g, c):
    s, flags, out, _ = receive_in_match(g, AP_DEATHLINK_MATCH)
    assert flags["wMatchWinLoseFlag"] == WINLOSE_LOSE, flags
    assert out == 0, f"the received death was reported back ({out})"


deathlink_receive_match_in_short_sets.tokens = lambda c: {"ApOptMatchSets": b"\x05", "ApOptMatchGames": b"\x02"}


def start_two_on_one(g):
    g.wram("wMinigameLevel", 0)
    g.pending.append(("RunTwoOnOneMatch", {}))


@test
def deathlink_two_on_one_is_a_match(g, c):
    s, flags, out, text = receive_in_match(g, AP_DEATHLINK_POINT, start=start_two_on_one)
    assert flags["wPointOutcome"] == include_value("POINTOUTCOME_DEATHLINK"), flags
    assert flags["wPointWinLoseFlag"] == WINLOSE_LOSE and not flags["wGameWinLoseFlag"], flags
    assert out == 0 and text == "DeathLink/from Tester!", (out, text)


@test
def deathlink_waits_out_a_quit(g, c):
    """A death pending as a pause menu quits the match is not applied: the
    score is not rewritten for a match that may be saved and resumed."""
    start_story_match(g)
    b, a = g.sym["ApDeathLinkPoll"]
    fired = []

    def quit_with_death(_):
        if not fired and g.mem[g.addr("wApDeathInMatch")]:
            fired.append(1)
            g.wram("wApDeathIn", AP_DEATHLINK_MATCH)
            g.wram("wMatchAbortFlag", include_value("MATCHABORT_ALL") & 0xff)
    g.pb.hook_register(b, a, quit_with_death, None)
    ended = []
    b, a = g.sym["ApDeathLinkMatchEnd"]
    g.pb.hook_register(b, a, lambda _: ended.append(score(g)), None)
    assert until(g, lambda: ended, 3000), "the match did not end"
    assert fired and ended[0]["wPlayer2GamesWon"] == 0 and ended[0]["wPlayer2SetsWon"] == 0, ended
    assert g.mem[g.addr("wPointOutcome")] != include_value("POINTOUTCOME_DEATHLINK")
    assert g.mem[g.addr("wApDeathIn")] == 0, "the death outlived the match"


deathlink_waits_out_a_quit.tokens = lambda c: {"ApOptMatchSets": b"\x03", "ApOptMatchGames": b"\x06"}


@test
def deathlink_send_from_a_match(g, c):
    start_story_match(g, cpu_serves=True)
    points = []
    b, a = g.sym["ResolvePointOutcome"]

    def scored(_):
        m = g.mem
        flags = [m[g.addr(n)] for n in ("wMatchWinLoseFlag", "wGameWinLoseFlag", "wPointWinLoseFlag")]
        want = next((AP_DEATHLINK_MATCH - i for i, f in enumerate(flags) if f == WINLOSE_LOSE), 0)
        points.append((want, m[g.addr("wApDeathOut")]))
        m[g.addr("wApDeathOut")] = 0
    g.pb.hook_register(b, a, scored, None)
    assert until(g, lambda: g.mem[g.addr("wMatchWinLoseFlag")], 80000), "the match never ended"
    g.tick(120)
    assert {AP_DEATHLINK_POINT, AP_DEATHLINK_GAME} <= {w for w, _ in points}, points
    assert all(w == got for w, got in points), points
    if g.mem[g.addr("wMatchWinLoseFlag")] == WINLOSE_LOSE:
        assert points[-1] == (AP_DEATHLINK_MATCH, AP_DEATHLINK_MATCH), points


deathlink_send_from_a_match.tokens = lambda c: {"ApOptMatchSets": b"\x01", "ApOptMatchGames": b"\x02"}


def minigame_result(g):
    """Ticks until ShowMatchResultScreens -> wApDeathOut and wPointWinLoseFlag
    then, or None."""
    seen = []
    b, a = g.sym["ShowMatchResultScreens"]
    g.pb.hook_register(b, a, lambda _: seen.append((g.mem[g.addr("wApDeathOut")],
                                                    g.mem[g.addr("wPointWinLoseFlag")])), None)
    until(g, lambda: seen, 30000, press_every=30)
    return seen[0] if seen else None


def receive_in_minigame(g, mode, minigame, at_death=None):
    """A received death at the first rally -> (the message, (wApDeathOut,
    wPointWinLoseFlag) at the results, the points finished after it)."""
    start_minigame(g, mode, minigame)
    fired = deathlink_at_first_rally(g, "ApDeathLinkMinigamePoll", AP_DEATHLINK_POINT)
    if at_death:
        b, a = g.sym["ApComposeDeathLinkMessage"]
        g.pb.hook_register(b, a, lambda _: at_death(g), None)
    points = []
    b, a = g.sym["RunMinigamePointLoop.pointLoop"]
    g.pb.hook_register(b, a, lambda _: fired and points.append(1), None)
    text = None
    seen = []
    lesson = []
    b, a = g.sym["ShowMatchResultScreens"]

    def results(_):
        seen.append((g.mem[g.addr("wApDeathOut")], g.mem[g.addr("wPointWinLoseFlag")]))
        lesson.append(g.mem[g.addr("wDrillLessonResult")])
    g.pb.hook_register(b, a, results, None)
    for i in range(30000):
        g.tick()
        buf = bytes(g.mem[g.addr("wTextBuffer") + j] for j in range(48))
        if text is None and buf.startswith(b"DeathLink"):
            text = buf.split(b"\0")[0].replace(b"\x01", b"/").replace(b"\x03", b"").decode()
        if seen:
            break
        if i % 30 == 29:
            g.press("a")
    assert fired, "no rally"
    g.lesson_result = lesson[0] if lesson else None
    return text, (seen[0] if seen else None), len(points)


@test
def deathlink_receive_minigame(g, c):
    text, result, points = receive_in_minigame(g, "GAMEMODE_MARIO_MINIGAME", c["MINIGAME_BOO_BLAST"])
    assert text == "DeathLink/from Tester!", text
    assert result == (0, WINLOSE_LOSE) and points == 0, (result, points)


@test
def deathlink_receive_keeps_a_high_score(g, c):
    """A death in a high-score run past its record ends it as a new high score."""
    def past_record(g):
        best = g.mem[g.addr("wMinigameHighScore")] | g.mem[g.addr("wMinigameHighScore") + 1] << 8
        g.wram("wMinigamesCurrentScore", (best + 1) & 0xff, (best + 1) >> 8)
    _, result, _ = receive_in_minigame(g, "GAMEMODE_TENNIS_MACHINE", c["MINIGAME_TENNIS_MACHINE_HIGH_SCORE"],
                                       at_death=past_record)
    assert result == (0, include_value("WINLOSE_WIN")), result


@test
def deathlink_send_from_a_minigame(g, c):
    start_minigame(g, "GAMEMODE_TENNIS_MACHINE", c["MINIGAME_TENNIS_MACHINE_1"])
    assert minigame_result(g) == (AP_DEATHLINK_MATCH, WINLOSE_LOSE)


def drill_reports(g, at_end=None):
    """Act as the client through a drill: every value wApDeathOut takes,
    cleared as it is read, up to ShowMatchResultScreens -> (the reports,
    each point's own result as its handler records it, the drill's result).
    at_end runs as the drill's points end."""
    reports, flags, done = [], [], []
    b, a = g.sym["RecordDrillPointResultBits"]
    g.pb.hook_register(b, a, lambda _: flags.append(g.mem[g.addr("wPointWinLoseFlag")]), None)
    if at_end:
        b, a = g.sym["ApDeathLinkMinigameEnd"]
        g.pb.hook_register(b, a, lambda _: at_end(g), None)
    b, a = g.sym["ShowMatchResultScreens"]
    g.pb.hook_register(b, a, lambda _: done.append(g.mem[g.addr("wPointWinLoseFlag")]), None)
    for i in range(80000):
        g.tick()
        if i % 30 == 29:
            g.press("a")
        out = g.mem[g.addr("wApDeathOut")]
        if out:
            reports.append(out)
            g.mem[g.addr("wApDeathOut")] = 0
        if done:
            return reports, flags, done[0]
    raise AssertionError("the drill never ended")


def expected_drill_reports(flags, result):
    """A point per lost point, the last one merged into a match if the drill
    failed (lost or tied)."""
    lost = [AP_DEATHLINK_POINT for f in flags[:-1] if f == WINLOSE_LOSE]
    if result != include_value("WINLOSE_WIN"):
        lost.append(AP_DEATHLINK_MATCH)
    elif flags[-1] == WINLOSE_LOSE:
        lost.append(AP_DEATHLINK_POINT)
    return lost


def drill_send_test(minigame):
    """Every lost point of the drill sends a point, from the player's side
    (match drills negate wDrillPointJudgement on odd points), and a failed
    drill a match in place of its last point."""
    def fn(g, c):
        cpu_serves_for_player(g)
        start_minigame(g, "GAMEMODE_TRAINING_DRILL", c[minigame])
        reports, flags, result = drill_reports(g)
        assert flags, "no points"
        assert reports == expected_drill_reports(flags, result), (reports, [hex(f) for f in flags], hex(result))
    return fn


for _drill in ("SERVICE_MATCH_1", "SERVICE_PRACTICE_2", "SERVICE_PRACTICE_3", "NET_GAME_MATCH_1",
               "NET_GAME_PRACTICE_1", "STROKE_MATCH_1", "STROKE_PRACTICE_1"):
    TESTS[f"deathlink_send_from_{_drill.lower()}"] = drill_send_test(f"MINIGAME_{_drill}")


@test
def deathlink_send_from_a_failed_lesson(g, c):
    start_minigame(g, "GAMEMODE_TRAINING_DRILL", c["MINIGAME_STROKE_PRACTICE_1"])
    reports, flags, result = drill_reports(g)
    assert result == WINLOSE_LOSE, "an idle player passed the lesson"
    assert reports == [AP_DEATHLINK_POINT] * (len(flags) - 1) + [AP_DEATHLINK_MATCH], reports
    assert len(flags) == include_value("DRILL_LESSON_POINTS"), flags


@test
def deathlink_send_from_a_tied_drill(g, c):
    """A drill match that ends tied (WINLOSE_NONE) has failed."""
    cpu_serves_for_player(g)
    start_minigame(g, "GAMEMODE_TRAINING_DRILL", c["MINIGAME_STROKE_MATCH_1"])
    reports, flags, result = drill_reports(g, at_end=lambda g: g.wram("wPointWinLoseFlag", 0))
    assert result == 0 and reports and reports[-1] == AP_DEATHLINK_MATCH, (reports, hex(result))


def drill_receive_test(minigame):
    """A received death ends the drill at once, failed, and sends nothing."""
    def fn(g, c):
        cpu_serves_for_player(g)
        text, result, points = receive_in_minigame(g, "GAMEMODE_TRAINING_DRILL", c[minigame])
        assert text == "DeathLink/from Tester!", text
        assert result == (0, WINLOSE_LOSE) and points == 0, (result, points)
        assert g.lesson_result == 1, f"the coach would say the lesson passed ({g.lesson_result})"
    return fn


TESTS["deathlink_receive_service_match"] = drill_receive_test("MINIGAME_SERVICE_MATCH_1")
TESTS["deathlink_receive_stroke_practice"] = drill_receive_test("MINIGAME_STROKE_PRACTICE_1")


def names(c, loc, item, player):
    off = c[loc] * 50
    return {("ApLocationNames", off): item.encode() + b"\0", ("ApLocationNames", off + 25): player.encode() + b"\0"}


messages.tokens = lambda c: {**placements(c, {"LOC_JUNIOR_SINGLES_RANK_4": "ITEM_IRON_RACKET"}),
                             **names(c, "LOC_JUNIOR_SINGLES_RANK_3", "Big Key", "Somebody Else")}
SHOTS = None


def write_rom(rom, sym, out, inventory):
    """A copy of the ROM with this start inventory ({ITEM_*: count}), for
    runs outside these tests (make ap-event-test)."""
    c, syms = constants(), read_syms(sym)
    data = bytearray(Path(rom).read_bytes())
    base = rom_offset(*syms["ApStartInventory"])
    for name, count in inventory.items():
        data[base + c[name]] = count
    Path(out).write_bytes(data)
    if Path(str(sym)).exists():
        shutil.copy(sym, Path(out).with_suffix(".sym"))


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--rom", default=ROOT / "mariotennis.gbc")
    ap.add_argument("--sym", default=ROOT / "build" / "mariotennis.sym")
    ap.add_argument("--save", default=ROOT / "maxed-unlocked.sav")
    ap.add_argument("-k", help="run only the tests whose name contains this")
    ap.add_argument("--shots", type=Path, help="save screenshots of the messages here")
    ap.add_argument("--write-rom", type=Path, metavar="OUT",
                    help="only write a copy of the ROM holding every class pass and drill item")
    args = ap.parse_args()
    if args.write_rom:
        full = {"ITEM_SINGLES_PASS": 4, "ITEM_DOUBLES_PASS": 4, "ITEM_WALL_PRACTICE": 4, "ITEM_TENNIS_MACHINE": 4}
        full.update({f"ITEM_{d}_{k}": 2 for d in ("SERVICE", "NET_GAME", "STROKE") for k in ("MATCH", "LESSON")})
        write_rom(args.rom, args.sym, args.write_rom, full)
        Path(args.write_rom).with_suffix(".sav").write_bytes(with_ledger(Path(args.save).read_bytes(), args.sym))
        return
    global SHOTS, GAME_ARGS
    SHOTS = args.shots
    GAME_ARGS = (args.rom, args.sym, args.save)
    c = constants()
    failed = 0
    if not args.k or args.k in "erases_a_save_without_ledger":
        magic, flags = boot_without_ledger(args.rom, args.sym, args.save)
        ok = magic == b"MTAP" and not any(flags)
        print(f"{'ok  ' if ok else 'FAIL'}  erases_a_save_without_ledger")
        failed += not ok
    if not args.k or args.k in "default_text_speed":
        speeds = [boot_message_speed(args.rom, args.sym, args.save, {"ApOptTextSpeed": bytes([b])}) for b in (0, 1, 3)]
        ok = speeds == [1, 0, 2]
        print(f"{'ok  ' if ok else 'FAIL'}  default_text_speed {speeds}")
        failed += not ok
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
