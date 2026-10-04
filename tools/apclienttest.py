#!/usr/bin/env python3
"""Run the apworld's BizHawk client against the game in PyBoy.

    <ap>/.venv/bin/python tools/apclienttest.py --ap <Archipelago 0.6.8 checkout>

The client (apworld/mario_tennis_gbc/client.py) talks to BizHawk through
worlds._bizhawk's read, guarded_write and get_cores. Here those read and
write PyBoy's memory instead (the ROM file, cart RAM by bank), and a stand-in
context plays the server: it records what the client sends and hands it
received items. The game runs from tools/aptest.py's harness, so each test
drives the game and the client's game_watcher in turn. Needs PyBoy in the
Archipelago virtualenv; the apworld is copied into <ap>/worlds first."""
import argparse
import asyncio
import base64
import shutil
import sys
import traceback
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "tools"))
import aptest  # noqa: E402
from ap_export import read_syms, rom_offset  # noqa: E402

AUTH = bytes(range(0xa0, 0xb0))
ALICE, ME = 2, 1


class Item:
    def __init__(self, item, player):
        self.item, self.player = item, player


class Context:
    """What the client reads of CommonContext, and what it sends."""

    def __init__(self):
        self.bizhawk_ctx = None
        self.server, self.slot = object(), ME
        self.auth = None
        self.checked_locations = set()
        self.items_received = []
        self.player_names = {ME: "Me", ALICE: "Alice"}
        self.sent = []
        self.game = self.items_handling = self.want_slot_data = None

    async def send_msgs(self, msgs):
        for m in msgs:
            self.sent.append(m)
            if m["cmd"] == "LocationChecks":
                self.checked_locations |= set(m["locations"])

    def checks(self):
        return {loc for m in self.sent if m["cmd"] == "LocationChecks" for loc in m["locations"]}


def connect(client_module, game, rom_bytes, core="Gambatte"):
    """Point the client module's BizHawk calls at this game."""
    def cart(off):
        return off // 0x2000, 0xa000 + off % 0x2000

    async def read(_, reads):
        out = []
        for addr, size, domain in reads:
            if domain == "ROM":
                out.append(bytes(rom_bytes[addr:addr + size]))
            elif domain == "CartRAM":
                out.append(bytes(game.mem[cart(addr + i)] for i in range(size)))
            else:
                raise ValueError(domain)
        return out

    async def guarded_write(_, writes, guards):
        for addr, data, domain in guards:
            assert domain == "CartRAM"
            if bytes(game.mem[cart(addr + i)] for i in range(len(data))) != bytes(data):
                return False
        for addr, data, domain in writes:
            assert domain == "CartRAM"
            for i, v in enumerate(data):
                game.mem[cart(addr + i)] = v
        return True

    async def get_cores(_):
        return {"GBC": core}

    client_module.read, client_module.guarded_write, client_module.get_cores = read, guarded_write, get_cores


def poll(client, ctx):
    asyncio.run(client.game_watcher(ctx))


TESTS = {}


def test(fn):
    TESTS[fn.__name__] = fn
    return fn


@test
def validate_and_auth(t):
    assert asyncio.run(t.client.validate_rom(t.ctx)), "the patched ROM was refused"
    assert t.ctx.items_handling == 0b001
    asyncio.run(t.client.set_auth(t.ctx))
    assert t.ctx.auth == base64.b64encode(AUTH).decode()


@test
def refuses_other_cores_and_builds(t):
    t.mod_connect(core="SameBoy")
    assert not asyncio.run(t.client.validate_rom(t.ctx)), "a non-Gambatte core was accepted"
    t.mod_connect(rom=t.rom_bytes[:0x3ffc] + b"\x00\x00\x00\x00" + t.rom_bytes[0x4000:])
    assert not asyncio.run(t.client.validate_rom(t.ctx)), "another build's id was accepted"
    t.mod_connect(rom=t.rom_bytes[:0x134] + b"CGBTENNIS \x00" + t.rom_bytes[0x13f:])
    assert not asyncio.run(t.client.validate_rom(t.ctx)), "an unpatched ROM was accepted"


@test
def sends_checks_and_goal(t):
    poll(t.client, t.ctx)
    assert not t.ctx.checks()
    g, c = t.game, t.c
    g.wram("wCurrentMinigameStoryMatch", 0, 1)
    g.call("SetRewardGameFlag")
    poll(t.client, t.ctx)
    assert t.ctx.checks() == {c["LOC_JUNIOR_SINGLES_RANK_4"] + 1}, t.ctx.checks()
    for arc in (0, 1):
        g.wram("wCurrentMinigameStoryMatch", arc, 19)
        g.call("SetRewardGameFlag")
    poll(t.client, t.ctx)
    assert any(m["cmd"] == "StatusUpdate" for m in t.ctx.sent), "the goal was not reported"
    n = len(t.ctx.sent)
    poll(t.client, t.ctx)
    assert len(t.ctx.sent) == n, "a poll with nothing new sent something"


@test
def receives_items(t):
    g, c = t.game, t.c
    t.ctx.items_received = [Item(c["ITEM_SMALL_RACKET"], ALICE), Item(c["ITEM_EXP_BUNDLE"], ME)]
    poll(t.client, t.ctx)
    assert g.message() == "You got/Small Racket/from Alice!"
    g.dismiss()
    assert g.message() == "You got/EXP Bundle!", "an own item showed a sender"
    g.dismiss()
    assert g.mem[g.addr("wApApplied") + c["ITEM_SMALL_RACKET"]] == 1
    t.ctx.items_received.append(Item(c["ITEM_DOUBLES_PASS"], ALICE))
    poll(t.client, t.ctx)
    assert g.message() == "You got/Doubles Pass/from Alice!"
    g.dismiss()
    assert g.message() is None
    counts = g.sram("sApClientItems", 32)
    assert counts[c["ITEM_DOUBLES_PASS"]] == 1 and counts[c["ITEM_SMALL_RACKET"]] == 1


@test
def rebuilds_a_cleared_client_region(t):
    g, c = t.game, t.c
    t.ctx.items_received = [Item(c["ITEM_IRON_RACKET"], ALICE)]
    poll(t.client, t.ctx)
    g.message()
    g.dismiss()
    # the game clears a corrupt client region at boot: all zero, received 0
    g.sram_write("sApClientRegion", bytes(g.sym["sApClientRegionEnd"][1] - g.sym["sApClientRegion"][1]))
    poll(t.client, t.ctx)
    assert int.from_bytes(g.sram("sApReceivedCount", 2), "little") == 1
    assert g.sram("sApClientItems", 32)[c["ITEM_IRON_RACKET"]] == 1
    assert g.message() is None, "a rebuilt item was announced twice"


@test
def ignores_another_seeds_ledger(t):
    g = t.game
    t.ctx.auth = base64.b64encode(bytes(16)).decode()
    t.ctx.items_received = [Item(t.c["ITEM_IRON_RACKET"], ALICE)]
    g.wram("wCurrentMinigameStoryMatch", 0, 1)
    g.call("SetRewardGameFlag")
    poll(t.client, t.ctx)
    assert not t.ctx.sent, "the client talked to a cart from another seed"
    assert int.from_bytes(g.sram("sApReceivedCount", 2), "little") == 0


@test
def remote_items_mode(t):
    assert asyncio.run(t.client.validate_rom(t.ctx))
    assert t.ctx.items_handling == 0b111


remote_items_mode.tokens = {"ApOptRemoteItems": b"\x01"}


class Run:
    def __init__(self, ap, rom, sym, save, tokens):
        sys.path.insert(0, str(ap))
        from worlds.mario_tennis_gbc import client as client_module
        self.module = client_module
        self.c = aptest.constants()
        base = {"ApSlotAuth": AUTH, ("ApPlacements", self.c["LOC_JUNIOR_SINGLES_RANK_4"]): bytes([0])}
        base.update(tokens)
        self.game = aptest.Game(rom, sym, save, base)
        syms = read_syms(sym)
        data = bytearray(Path(rom).read_bytes())
        for label, value in base.items():
            off = rom_offset(*syms[label[0]]) + label[1] if isinstance(label, tuple) else rom_offset(*syms[label])
            data[off:off + len(value)] = value
        self.rom_bytes = bytes(data)
        self.client = client_module.MarioTennisGBCClient()
        self.ctx = Context()
        self.ctx.auth = base64.b64encode(AUTH).decode()
        self.mod_connect()

    def mod_connect(self, core="Gambatte", rom=None):
        connect(self.module, self.game, rom if rom is not None else self.rom_bytes, core)


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--ap", required=True, type=Path, help="an Archipelago 0.6.8 checkout")
    ap.add_argument("--rom", default=ROOT / "build" / "mariotennis-ap.gbc", help="the stamped ROM (make ap-export)")
    ap.add_argument("--sym", default=ROOT / "build" / "mariotennis.sym")
    ap.add_argument("--save", default=ROOT / "maxed-unlocked.sav")
    ap.add_argument("-k", help="run only the tests whose name contains this")
    args = ap.parse_args()
    dest = args.ap / "worlds" / "mario_tennis_gbc"
    shutil.rmtree(dest, ignore_errors=True)
    shutil.copytree(ROOT / "apworld" / "mario_tennis_gbc", dest)
    failed = 0
    for name, fn in TESTS.items():
        if args.k and args.k not in name:
            continue
        t = Run(args.ap, args.rom, args.sym, args.save, getattr(fn, "tokens", {}))
        try:
            t.game.to_overworld()
            fn(t)
            print(f"ok    {name}")
        except AssertionError:
            failed += 1
            print(f"FAIL  {name}")
            traceback.print_exc()
        finally:
            t.game.close()
    sys.exit(1 if failed else 0)


if __name__ == "__main__":
    main()
