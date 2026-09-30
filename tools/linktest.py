#!/usr/bin/env python3
"""Two copies of the game joined by a link cable, for link play.

    python3 tools/linktest.py --seeds 4 --frames 12000 [--coverage build/link.json]

needs PyBoy (`make venv`). PyBoy emulates an unplugged serial port -- writes to
SB are dropped, an internal-clock transfer always reads $ff, an external one
never ends -- so the cable is made of hooks on each game's own serial code:

  * every `ldh [rSB], a` records the byte that side has put on the wire;
  * an `ldh [rSC], a` that starts an internal-clock transfer (the side
    driving the clock) swaps the two sides' bytes there and then, and ends the
    other side's transfer: its serial interrupt flag is raised and SC bit 7
    cleared;
  * the one `ldh a, [rSB]`, in SerialHandler, is handed the byte that side
    received.

Two things keep the pair honest. The side receiving a byte must have taken
it, and run its own code for a while after, before the next one goes: on
hardware its interrupt runs microseconds after the byte and the sender's
ShortDelays give it thousands of cycles, but here each game only runs when it
is ticked, so the driving side's hook ticks the other one a frame when it
has not. And PyBoy leaves SC bit 7 set when an internal-clock transfer ends
(`SC &= 0x80`, where hardware clears it); the game polls that bit before
the next byte, so it is cleared once the transfer has finished.

A session starts both games on the main menu, moves both cursors to Link
Play, and has one player press A first and the other a few seconds later --
the order the game needs: the first console probes as master, and the
second, which has been latching those probes, answers as slave. After the
rules screen both players press buttons at random (mostly A, or `--keys`),
which walks them through character select into a link match.
`--unplug-after N` pulls the cable out N frames in: the side driving the
clock then reads $ff, as on hardware, and the other hears nothing.
`--steer ROUTINE` adds tools/steer.py's hooks on both games, forcing each
branch on the way down to ROUTINE from one the --coverage file says ran.
"""
import argparse
import collections
import io
import json
import random
import shutil
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import eventtest as E  # noqa: E402
from banksrc import bank_lines, bank_of, build_addresses, holders  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
LINK_PLAY_ITEM = 2          # the main menu's Link Play (column 2, row 0)
KEYS = ["up", "down", "left", "right", "a", "a", "a", "a"]


def serial_sites(sym):
    """(bank, address) of every rSB write, every rSC write, and the
    instruction after SerialHandler's rSB read."""
    writes_sb, writes_sc, reads_sb = [], [], []
    for h in holders():
        b = bank_of(h)
        lines = bank_lines(h)[0]
        placed = build_addresses(b, lines, sym)
        for i, line in enumerate(lines):
            code = line.split(";")[0].strip()
            if i not in placed:
                continue
            if code == "ldh [rSB], a":
                writes_sb.append((b, placed[i]))
            elif code == "ldh [rSC], a":
                writes_sc.append((b, placed[i]))
            elif code == "ldh a, [rSB]":
                j = next(k for k in range(i + 1, len(lines)) if lines[k].split(";")[0].strip())
                reads_sb.append((b, placed[j]))
    return writes_sb, writes_sc, reads_sb


class Side:
    def __init__(self, name, pb):
        self.name, self.pb = name, pb
        self.sb, self.rx = 0xff, None
        self.pending = self.need_tick = self.driving = False
        self.exchanges = self.stalls = 0
        self.entered, self.spent = set(), []


def boot_to_menu(rom, save, out):
    from pyboy import PyBoy
    tmp = Path(tempfile.mkdtemp(dir=ROOT / "build"))
    shutil.copy(rom, tmp / "r.gbc")
    shutil.copy(save, tmp / "r.gbc.ram")
    pb = PyBoy(str(tmp / "r.gbc"), window="null", sound_emulated=False, log_level="ERROR")
    for wait, button in ((950, "start"), (90, "a")):
        pb.tick(wait, False)
        pb.button(button, 6)
    pb.tick(300, False)
    buf = io.BytesIO()
    pb.save_state(buf)
    Path(out).write_bytes(buf.getvalue())
    pb.stop(save=False)
    shutil.rmtree(tmp)


def connect(a, b, sym, sites, cable):
    writes_sb, writes_sc, reads_sb = sites
    for me, other in ((a, b), (b, a)):
        me.sb = me.pb.memory[sym["hLinkTxByte"][1]]   # loaded at boot, before the saved state

        def put(_, me=me):
            me.sb = me.pb.register_file.A

        def start(_, me=me, other=other):
            if me.pb.register_file.A & 0x81 != 0x81:
                return
            if not cable["plugged"]:
                # pulled: the driving side clocks in $ff, the other hears nothing
                me.rx, me.driving = None, True
                return
            for _ in range(4):
                if not (other.pending or other.need_tick):
                    break
                other.need_tick = False
                other.pb.tick(1, False)
                other.stalls += 1
            me.rx, other.rx = other.sb, me.sb
            me.exchanges += 1
            me.driving, other.pending = True, True
            om = other.pb.memory
            om[0xff0f] = om[0xff0f] | 0x08
            om[0xff02] = om[0xff02] & 0x7f

        def take(_, me=me):
            me.pending, me.need_tick = False, True
            if me.rx is not None:
                me.pb.register_file.A = me.rx

        def finished(_, me=me):
            if me.driving:
                me.pb.memory[0xff02] = me.pb.memory[0xff02] & 0x7f
                me.driving = False
        for p in writes_sb:
            me.pb.hook_register(p[0], p[1], put, None)
        for p in writes_sc:
            me.pb.hook_register(p[0], p[1], start, None)
        for p in reads_sb:
            me.pb.hook_register(p[0], p[1], take, None)
        me.pb.hook_register(*sym["SerialHandler"], finished, None)
    return set(writes_sb) | set(writes_sc) | set(reads_sb) | {sym["SerialHandler"]}


def watch(side, sym, taken, labels):
    for name in labels:
        pt = sym.get(name)
        if not pt or pt in taken:
            continue

        def enter(n, side=side, pt=pt):
            if n not in side.entered:     # a hook fires until it is lifted between frames
                side.entered.add(n)
                side.spent.append(pt)
        side.pb.hook_register(pt[0], pt[1], enter, name)


def steer_hooks(side, sym_path, chain, taken):
    """tools/steer.py's steering along `chain` on one side; returns the list
    that fills when the chain's last routine runs."""
    import steer

    class Game:
        rf = side.pb.register_file
    code = steer.Code(E.symbols(sym_path))
    plugin, steps, done = steer.plugin_for(sym_path, chain, code.is_code)
    for pt, fn in plugin(Game).items():
        if pt not in taken:
            side.pb.hook_register(pt[0], pt[1], lambda _, fn=fn: fn(), None)
            taken.add(pt)
    return done


def session(rom, sym_path, save, seed, frames, lag, settle, menu_state, keys=KEYS, unplug=None,
            chain=None):
    from pyboy import PyBoy
    sym = E.symbols(sym_path)
    tmp = Path(tempfile.mkdtemp(dir=ROOT / "build"))
    sides = []
    for name in "ab":
        d = tmp / name
        d.mkdir()
        shutil.copy(rom, d / "r.gbc")
        shutil.copy(save, d / "r.gbc.ram")
        pb = PyBoy(str(d / "r.gbc"), window="null", sound_emulated=False, log_level="ERROR")
        pb.set_emulation_speed(0)
        pb.load_state(io.BytesIO(Path(menu_state).read_bytes()))
        sides.append(Side(name, pb))
    a, b = sides
    cable = {"plugged": True}
    taken = connect(a, b, sym, serial_sites(sym), cable)
    labels = E.code_labels()
    for s in sides:
        mine = set(taken)
        s.steered = steer_hooks(s, sym_path, chain, mine) if chain else []
        watch(s, sym, mine, labels)
    moves = ["right"] * (LINK_PLAY_ITEM % 3) + ["down"] * (LINK_PLAY_ITEM // 3)
    press = {s.name: [(30 + 30 * k, mv) for k, mv in enumerate(moves)] for s in sides}
    press["a"].append((30 + 30 * len(moves), "a"))
    press["b"].append((30 + 30 * len(moves) + lag, "a"))
    rng = random.Random(seed)
    random_from = 30 + 30 * len(moves) + lag + settle
    link = sym["hLinkState"][1]
    states = collections.Counter()
    for t in range(frames):
        if t == unplug:
            cable["plugged"] = False
        for k, s in enumerate(sides):
            for when, button in press[s.name]:
                if when == t:
                    s.pb.button(button, 6)
            if t >= random_from and t % 12 == 6 * k:
                for button in rng.choice(keys).split("+"):
                    s.pb.button(button, 6)
            s.pb.tick(1, False)
            s.need_tick = False
            if s.driving and s.pb.memory[0xff0f] & 0x08:
                s.pb.memory[0xff02] = s.pb.memory[0xff02] & 0x7f
                s.driving = False
            for pt in s.spent:
                s.pb.hook_deregister(*pt)
            s.spent = []
        states[(a.pb.memory[link], b.pb.memory[link])] += 1
    for s in sides:
        s.pb.stop(save=False)
    shutil.rmtree(tmp)
    return a, b, states


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--rom", default=str(ROOT / "mariotennis.gbc"))
    ap.add_argument("--sym", default=str(ROOT / "build" / "mariotennis.sym"))
    ap.add_argument("--save", default=str(ROOT / "maxed-unlocked.sav"))
    ap.add_argument("--seeds", type=int, default=4)
    ap.add_argument("--first-seed", type=int, default=0)
    ap.add_argument("--frames", type=int, default=12000)
    ap.add_argument("--lag", type=int, default=200, help="frames between the two players pressing A")
    ap.add_argument("--settle", type=int, default=300, help="frames before the random presses start")
    ap.add_argument("--keys", default=",".join(KEYS),
                    help="the buttons the random presses pick from, repeats weighting them; "
                         "a+b presses both")
    ap.add_argument("--unplug-after", type=int, help="pull the cable out after this many frames")
    ap.add_argument("--steer", help="force the branches on the way to this routine (tools/steer.py), "
                                    "down from one a --coverage file says ran")
    ap.add_argument("--coverage", help="merge the routines entered into this eventtest coverage file")
    a = ap.parse_args()
    tmp = Path(tempfile.mkdtemp(dir=ROOT / "build"))
    menu = tmp / "menu.state"
    boot_to_menu(a.rom, a.save, menu)
    entered, chain = set(), None
    if a.steer:
        import reach
        import steer
        ran = set(json.loads(Path(a.coverage).read_text())["entered"])
        chain = steer.chains([a.steer], ran, reach.Graph()).get(a.steer)
        print("steering:", " -> ".join(chain or ["no chain"]))
    try:
        for seed in range(a.first_seed, a.first_seed + a.seeds):
            x, y, states = session(a.rom, a.sym, a.save, seed, a.frames, a.lag, a.settle, menu,
                                   a.keys.split(","), a.unplug_after, chain)
            if chain and (x.steered or y.steered):
                entered.add(chain[-1])
                print(f"seed {seed}: steered into {chain[-1]}")
            linked = states[(1, 2)] + states[(2, 1)]
            entered |= x.entered | y.entered
            print(f"seed {seed}: {x.exchanges + y.exchanges} bytes over the cable, linked for "
                  f"{linked} of {a.frames} frames, {len(x.entered | y.entered)} routines entered")
    finally:
        shutil.rmtree(tmp)
    print(f"{len(entered)} routines entered in all")
    if a.coverage:
        path = Path(a.coverage)
        old = json.loads(path.read_text()) if path.exists() else {"entered": [], "hooked": []}
        hooked = set(old["hooked"]) | set(E.code_labels())
        path.write_text(json.dumps({"entered": sorted(set(old["entered"]) | entered),
                                    "hooked": sorted(hooked)}, indent=0))
    return 0


if __name__ == "__main__":
    sys.exit(main())
