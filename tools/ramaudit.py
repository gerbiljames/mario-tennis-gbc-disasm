#!/usr/bin/env python3
"""RAM questions answered by playing the game (PyBoy, `make venv`).

    python3 tools/ramaudit.py free FLOW... [--frames N] [--jobs J]
    python3 tools/ramaudit.py writer FLOW BANK:ADDR... [--frames N]

A FLOW is `target:NAME` (an eventtest target: a Test-map NPC, a drill, a
damaged save, a menu target, `handler<k>`, ...), `story:STATE:LOCATION` (a
story chunk, every entry point) or `link:SEED` (a linktest session, both
games).

`free` checks the free-RAM inventory (`tools/ram_free.py`): every byte it
lists is set to $5a as each run starts, and the flow is played twice under
the same inputs, poisoned and clean. A free byte left holding anything but
$5a or zero holds data; a difference between the two runs anywhere else
(named RAM, OAM, the events the run logged) means the game read a poisoned
byte. Block clears write zero, so zero is not counted. Runs where the game
crashed (see eventtest) are reported as such, not audited.

`writer` poisons the same bytes, logs every hooked routine, and names the
first one to see each given byte hold a new non-zero value (`--zero`: any
new value, block clears included), with the value, the logic frame and the
return addresses on the stack. BANK is the WRAM bank (0 for WRAM0
and HRAM).
"""
import argparse
import concurrent.futures
import json
import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import eventtest as E  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
ROM, SYM, SAVE = str(ROOT / "mariotennis.gbc"), str(ROOT / "build" / "mariotennis.sym"), str(ROOT / "maxed-unlocked.sav")
POISON = 0x5a


def free_bytes():
    """(WRAM bank or None, address) of every byte ram_free.py lists."""
    with tempfile.NamedTemporaryFile(suffix=".json", dir=ROOT / "build") as f:
        subprocess.run([sys.executable, str(ROOT / "tools" / "ram_free.py"), "--json", f.name],
                       capture_output=True, check=True)
        ranges = json.loads(Path(f.name).read_text())
    return [(bank if kind == "w" and a >= 0xd000 else None, a)
            for kind, bank, s, e in ranges for a in range(s, e)]


def poison(mem, cells):
    for bank, a in cells:
        if bank is None:
            mem[a] = POISON
        else:
            mem[bank, a] = POISON


def read(mem, bank, a):
    return mem[a] if bank is None else mem[bank, a]


def snapshot(mem, cells):
    """(free byte values, everything else) of WRAM0, WRAMX 1-7, HRAM and OAM."""
    free, other = {}, []
    for a in range(0xc000, 0xd000):
        (free.__setitem__((None, a), mem[a]) if (None, a) in cells else other.append(mem[a]))
    for b in range(1, 8):
        for a in range(0xd000, 0xe000):
            v = mem[b, a]
            (free.__setitem__((b, a), v) if (b, a) in cells else other.append(v))
    for a in range(0xff80, 0xffff):
        (free.__setitem__((None, a), mem[a]) if (None, a) in cells else other.append(mem[a]))
    other += list(mem[0xfe00:0xfea0])
    return free, other


def play(flow, frames, tmp, on_start, on_end):
    """Run a flow; on_start(mem) as each run starts, on_end(mem, events, crash)
    as it ends."""
    kind, *args = flow.split(":")
    if kind == "link":
        import linktest as L
        orig = L.Side.__init__

        def init(self, name, pb):
            orig(self, name, pb)
            on_start(pb.memory)
        L.Side.__init__ = init
        try:
            L.session(ROM, SYM, SAVE, int(args[0]), frames, 200, 300, str(tmp / "linkmenu"), L.KEYS,
                      finish=lambda sides: [on_end(s.pb.memory, [], None) for s in sides])
        finally:
            L.Side.__init__ = orig
        return
    orig_run = E.Game.run

    def run(self, *a, **k):
        on_start(self.mem)
        r = orig_run(self, *a, **k)
        on_end(self.mem, [e for e in self.events if e[1] == "run"], self.crash)
        return r
    E.Game.run = run
    try:
        skip = tmp / "skip.json"
        skip.write_text("[]")
        if kind == "story":
            E.chunk(ROM, SYM, SAVE, str(tmp / "story"), int(args[0]), int(args[1]), frames, 20, str(skip))
        else:
            menu = args[0] in E.MENU_TARGETS
            E.target(ROM, SYM, SAVE, str(tmp / ("menu" if menu else "story")), args[0], 0, frames, 20, str(skip))
    finally:
        E.Game.run = orig_run


def boot(flow, tmp):
    if flow.startswith("link:"):
        import linktest as L
        L.boot_to_menu(ROM, SAVE, tmp / "linkmenu")
    else:
        E.boot(ROM, SYM, SAVE, str(tmp / "story"))
        E.boot(ROM, SYM, SAVE, str(tmp / "menu"), menu=True)


def audit_free(flow, frames):
    cells = free_bytes()
    cellset = set(cells)
    tmp = Path(tempfile.mkdtemp(dir=ROOT / "build"))
    os.environ["EVENTTEST_TMP"] = str(tmp)
    try:
        boot(flow, tmp)
        runs = {}
        for poisoned in (True, False):
            snaps = runs[poisoned] = []
            play(flow, frames, tmp, (lambda mem: poison(mem, cells)) if poisoned else (lambda mem: None),
                 lambda mem, events, crash, snaps=snaps: snaps.append(snapshot(mem, cellset) + (events, crash)))
    finally:
        shutil.rmtree(tmp, True)
    p, c = runs[True], runs[False]
    data = {}
    for free, other, events, crash in p:
        if crash:
            continue
        for (bank, a), v in free.items():
            if v not in (POISON, 0):
                data[(bank or 0, a)] = v
    ranges = []
    for bank, a in sorted(data):
        if ranges and ranges[-1][0] == bank and ranges[-1][2] == a:
            ranges[-1][2] = a + 1
        else:
            ranges.append([bank, a, a + 1])
    return {"flow": flow, "runs": len(p),
            "crashed": [x[3] for x in p if x[3]],
            "data": [f"{b:x}:{s:04x}-{e - 1:04x}" for b, s, e in ranges],
            "read": [k for k, (x, y) in enumerate(zip(p, c)) if not x[3] and (x[1] != y[1] or x[2] != y[2])]}


def find_writer(flow, frames, targets, zero=False):
    cells = free_bytes()
    tmp = Path(tempfile.mkdtemp(dir=ROOT / "build"))
    os.environ["EVENTTEST_TMP"] = str(tmp)
    found, prev = {}, [None]
    orig_log = E.Game.log

    def log(self, kind, what):
        m = self.mem
        for bank, a in targets:
            v = read(m, bank, a)
            if (bank, a) not in found and v != POISON and (v or zero):
                sp = self.rf.SP
                found[(bank, a)] = (self.lf, read(m, bank, a), prev[0], what,
                                    [f"${m[sp + 2 * i] | m[sp + 2 * i + 1] << 8:04x}" for i in range(6)])
        prev[0] = what
        return orig_log(self, kind, what)
    E.Game.log = log
    try:
        boot(flow, tmp)

        def start(mem):
            poison(mem, cells)
            for bank, a in targets:
                if bank is None:
                    mem[a] = POISON
                else:
                    mem[bank, a] = POISON
            E.PROGRESS["game"].cap = 10 ** 9
        play(flow, frames, tmp, start, lambda *a: None)
    finally:
        E.Game.log = orig_log
        shutil.rmtree(tmp, True)
    return found


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    sub = ap.add_subparsers(dest="cmd", required=True)
    f = sub.add_parser("free", help="which free-RAM bytes a flow uses")
    f.add_argument("flows", nargs="+")
    f.add_argument("--frames", type=int, default=6000)
    f.add_argument("--jobs", type=int, default=8)
    f.add_argument("--timeout", type=int, default=1500)
    w = sub.add_parser("writer", help="which routine first writes some bytes")
    w.add_argument("flow")
    w.add_argument("cells", nargs="+", help="BANK:ADDR in hex, BANK 0 for WRAM0/HRAM")
    w.add_argument("--frames", type=int, default=6000)
    w.add_argument("--zero", action="store_true", help="count a write of zero (block clears) too")
    ap.add_argument("--one", help=argparse.SUPPRESS)
    a = ap.parse_args()
    if a.cmd == "writer":
        targets = [(int(b, 16) or None, int(x, 16)) for b, x in (c.split(":") for c in a.cells)]
        found = find_writer(a.flow, a.frames, targets, a.zero)
        for (bank, addr), (lf, v, before, at, stack) in sorted(found.items(), key=lambda t: t[1][0]):
            print(f"{bank or 0:x}:{addr:04x} = ${v:02x} at logic frame {lf}, "
                  f"between {before} and {at}; stack {' '.join(stack)}")
        for bank, addr in targets:
            if (bank, addr) not in found:
                print(f"{bank or 0:x}:{addr:04x} never written")
        return 0
    if a.one:
        print(json.dumps(audit_free(a.one, a.frames)))
        return 0

    def one(flow):
        try:
            r = subprocess.run([sys.executable, __file__, "--one", flow, "free", flow, "--frames", str(a.frames)],
                               capture_output=True, text=True, timeout=a.timeout)
            return json.loads(r.stdout.strip().splitlines()[-1])
        except (subprocess.TimeoutExpired, IndexError, ValueError):
            return {"flow": flow, "failed": True}
    with concurrent.futures.ThreadPoolExecutor(a.jobs) as ex:
        for res in ex.map(one, a.flows):
            if res.get("failed"):
                print(f"{res['flow']}: failed")
                continue
            crashed = f", {len(res['crashed'])} of {res['runs']} runs crashed" if res["crashed"] else ""
            print(f"{res['flow']}: {len(res['data'])} ranges hold data{crashed}"
                  f"{', READ: runs ' + str(res['read']) if res['read'] else ''}")
            for r in res["data"]:
                print(f"    {r}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
