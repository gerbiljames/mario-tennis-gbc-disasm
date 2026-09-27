#!/usr/bin/env python3
"""Play two builds through the story under the same inputs and report where
the game's own events stop agreeing.

The dynamic half of `make shift-test`: build a padded ROM with
`tools/shifttest.py --out padded.gbc` (which writes padded.sym beside it),
then

    python3 tools/eventtest.py padded.gbc --save maxed-unlocked.sav

boots it and mariotennis.gbc headless in PyBoy (`pip install pyboy`) to the
story overworld, then for each of 36 story states (wGameFlags rewritten to
each step of the singles and doubles ladders) enters every location at each
of its entry points and plays seeded random input. Each build is hooked by
label through its own .sym, and records in order: every code label entered
(its first --cap entries), the actor list InitLocationActors installs, each
NpcScripts talk and each character record loaded.

A shifted build is not cycle-identical (a lookup table moved across a page
takes a different branch, a heavy frame can lag), so inputs are fed by
*logic* frame -- one per AdvanceFrame/WaitVBlank -- by writing the joypad
bytes inside ReadJoypad, and a VBlank that arrives before the logic frame
has finished (hVBlankOccurred still set) is made to leave WRAM and HRAM as it
found them, so the game timer, fades, sound and random seed it would step
cannot move a lagging build a frame ahead. Events the interrupt handlers
run are not recorded. Both builds then see the same game, and any
difference in the event sequence is a real fault of the shifted build.
Timing-only differences are counted, not failed.
"""
import argparse
import bisect
import concurrent.futures
import io
import json
import random
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from banksrc import bank_lines, holders
from runtime_audit import MNEMONICS, targets

ROOT = Path(__file__).resolve().parent.parent
SINGLES = [80, 81, 82, 83, 84, 85, 86, 87, 88, 174, 63, 62, 61, 60, 185, 176, 183, 178, 59]
DOUBLES = [64, 65, 66, 68, 69, 70, 72, 175, 55, 54, 53, 177, 184, 179, 52]
ALWAYS_CLEAR = [189, 190, 191, 186, 187, 188, 131, 132, 118, 119, 120, 121, 130, 116,
                123, 128, 126, 127, 109, 110]
FLAG_DOUBLES = 47
# copied to HRAM before it runs, so a breakpoint in it would be copied too
NOT_HOOKED = {"OAMDMARoutine"}
# a breakpoint on an interrupt vector hangs PyBoy; the handlers are hooked
NOT_HOOKED |= {"VBlankInterrupt", "LCDStatInterrupt", "TimerInterrupt", "SerialInterrupt",
               "JoypadInterrupt"}
CODE_MACROS = {"farcall", "lb", "ld_slot", "ld_hl_indexed", "ld_de_indexed", "ld_bc_indexed"}
BUTTONS = {"a": 0x01, "b": 0x02, "start": 0x08, "right": 0x10, "left": 0x20, "up": 0x40, "down": 0x80}
# (label, offset) of the points the input sync hooks, taken from the base
# build: after ReadJoypad stores the pad, and where AdvanceFrame, WaitVBlank
# and EnableLCD clear hVBlankOccurred.
# Original-game paths whose outcome depends on where code sits (docs/bugs.md):
# a run that takes one logs a taint and is compared only up to it.
TAINTS = [("GetSpeakerVoice", 0x60b1, lambda g: g.rf.A & 0x80, "GetSpeakerVoice stack slip"),
          ("CourtyardEntryWalkIn_13", 0x62ff,
           lambda g: g.mem[g.sym["wStoryModeEntryPoint"][1]] > 6, "Courtyard walk-in over-read")]
SYNC = {"pad": ("ReadJoypad", 0x0317), "frame": [("AdvanceFrame", 0x2644), ("WaitVBlank", 0x2815),
                                               ("EnableLCD", 0x0380)]}


def symbols(path):
    out = {}
    for line in Path(path).read_text().splitlines():
        m = re.match(r"([0-9a-f]{2}):([0-9a-f]{4}) (\S+)", line)
        if m:
            out.setdefault(m.group(3), (int(m.group(1), 16), int(m.group(2), 16)))
    return out


def code_labels():
    # The sound engine runs from the timer interrupt, which the comparison
    # skips anyway, and PyBoy hangs with its routines hooked for long.
    audio = {m.group(1) for f in (ROOT / "src" / "audio").glob("*.asm")
             for m in re.finditer(r"^([A-Za-z_]\w*):", f.read_text(), re.M)}
    out = []
    for h in holders():
        lines = bank_lines(h)[0]
        for i, line in enumerate(lines):
            m = re.match(r"^([A-Za-z_]\w*):", line)
            if not m:
                continue
            nxt = next((x for x in lines[i + 1:i + 6] if x.strip() and not x.strip().startswith(";")), "")
            op = re.match(r"^\t(\w+)", nxt)
            # PyBoy can wedge when the single step past one breakpoint lands
            # on another, so a routine that opens by jumping is not hooked.
            if op and op.group(1) in ("call", "jp", "jr", "rst", "farcall"):
                continue
            if op and (op.group(1) in MNEMONICS or op.group(1) in CODE_MACROS) \
                    and m.group(1) not in NOT_HOOKED and m.group(1) not in audio:
                out.append(m.group(1))
    return out


def states():
    out = []
    for dbl, chain in ((0, SINGLES), (1, DOUBLES)):
        for k in range(len(chain) + 1):
            out.append((dbl, chain[:k]))
    return out


def plan(seed, frames):
    r = random.Random(seed)
    held, f = [], 0
    while f < frames:
        x = r.random()
        if x < 0.45:
            b, h = r.choice(["up", "down", "left", "right"]), r.choice([8, 16, 32, 48])
        else:
            b, h = ("a" if x < 0.85 else "b" if x < 0.95 else "start"), 6
        held += [BUTTONS[b]] * h + [0] * r.choice([4, 10, 20])
        f = len(held)
    return held


class Game:
    def __init__(self, rom, sym, save, cap, skip=()):
        from pyboy import PyBoy
        self.sym = symbols(sym)
        base = symbols(ROOT / "build" / "mariotennis.sym")
        self.tmp = Path(tempfile.mkdtemp(prefix="eventtest-"))
        copy = self.tmp / "rom.gbc"
        shutil.copy(rom, copy)
        shutil.copy(save, str(copy) + ".ram")
        self.pb = pb = PyBoy(str(copy), window="null", sound_emulated=False, log_level="ERROR")
        pb.set_emulation_speed(0)
        self.rf, self.mem = pb.register_file, pb.memory
        self.events, self.lf, self.inputs = [], 0, []
        self.pad_lf, self.prev, self.edge, self.lag = -1, 0, 0, None
        self.irq, self.armed, self.last = 0, True, None

        def at(label, base_addr):
            b, a = self.sym[label]
            return b, a + base_addr - base[label][1]

        hooks = {}

        def add(point, fn):
            hooks.setdefault(point, []).append(fn)

        add(self.sym["VBlankHandler"], self.on_vblank)
        for label in ("VBlankHandler", "LCDStatHandler", "TimerHandler", "SerialHandler"):
            add(self.sym[label], self.on_irq)
        home = sorted((a, n) for n, (b, a) in base.items() if b == 0 and a < 0x4000 and "." not in n)
        for f in (ROOT / "src" / "home").glob("*.asm"):
            for m in re.finditer(r"^\treti ; \$([0-9a-f]{4})", f.read_text(), re.M):
                addr = int(m.group(1), 16)
                label = home[bisect.bisect_right(home, (addr, "\uffff")) - 1][1]
                if label == "VBlankHandler":
                    add(at(label, addr), self.on_vblank_reti)
                add(at(label, addr), self.on_reti)
        for label, addr in SYNC["frame"]:
            add(at(label, addr), self.on_frame)
        add(at(*SYNC["pad"]), self.on_pad)
        for label, addr, cond, reason in TAINTS:
            add(at(label, addr), lambda c=cond, r=reason: c(self) and self.log("taint", r))

        self.locs = targets(self.sym)[5]
        by_bank = {}
        for n, (b, a) in self.sym.items():
            if a < 0x8000 and "." not in n:
                by_bank.setdefault(b, []).append((a, n))
        for v in by_bank.values():
            v.sort()

        def label_at(bank, addr):
            labels = by_bank.get(bank if addr >= 0x4000 else 0, [])
            i = bisect.bisect_right(labels, (addr, "\uffff")) - 1
            return f"{labels[i][1]}+{addr - labels[i][0]}" if i >= 0 else f"{addr:04x}"
        w = {n: self.sym[n][1] for n in ("wStoryModeCurrentLocation", "wMapNpcScriptsPtr", "wStoryLocationBank",
                                        "hPlayerInputFlags", "hInputRisingEdge", "hVBlankOccurred")}
        self.w = w
        mem, rf = self.mem, self.rf
        add(self.sym["InitLocationActors"],
            lambda: self.log("list", label_at(rf.A, rf.HL)))
        add(self.sym["RunNpcInteraction"],
            lambda: self.log("talk", f"{label_at(mem[w['wStoryLocationBank']], mem[w['wMapNpcScriptsPtr']] | mem[w['wMapNpcScriptsPtr'] + 1] << 8)}"
                                     f"/{rf.A:02x}"))
        add(self.sym["InitCa00RecordFromCharId"], lambda: self.log("char", f"{rf.B:02x}"))
        self.sync_points = set(hooks)
        self.names = {}
        for name in code_labels():
            if name in self.sym and self.sym[name] not in hooks and name not in skip:
                add(self.sym[name], lambda n=name: self.log("run", n))
                self.names[self.sym[name]] = name
        self.hits, self.cap, self.spent, self.removed = {}, cap, [], []
        self.irq_hits = {}
        self.hooks = hooks
        for point, fns in hooks.items():
            pb.hook_register(point[0], point[1], self.dispatch, (point, fns))

    def reset_caps(self):
        for point in self.removed:
            self.pb.hook_register(point[0], point[1], self.dispatch, (point, self.hooks[point]))
        self.hits, self.irq_hits, self.removed, self.spent = {}, {}, [], []

    def dispatch(self, ctx):
        point, fns = ctx
        if point in self.sync_points:
            for fn in fns:
                fn()
            return
        # Interrupt handlers (sound, timers) run whenever the cycle count says,
        # which a shifted build does not keep, so only the main thread counts.
        if not self.armed:
            return
        if self.irq:
            # A routine the handlers call runs constantly; after the boot has
            # named it, both builds leave it unhooked, and a straggler is
            # dropped here once it is plainly interrupt code.
            n = self.irq_hits[point] = self.irq_hits.get(point, 0) + 1
            if n == 1000 and not self.hits.get(point):
                self.spent.append(point)
            return
        # An interrupt taken on a breakpoint runs before its instruction, and
        # the hook fires again on return: same place, same registers.
        r = self.rf
        state = (point, r.SP, r.A, r.B, r.C, r.D, r.E, r.HL, r.F)
        if state == self.last:
            return
        self.last = state
        # PyBoy lifts a breakpoint while its callback runs, so a hook cannot
        # remove itself; it is removed between frames and ignored until then.
        n = self.hits[point] = self.hits.get(point, 0) + 1
        if n <= self.cap:
            for fn in fns:
                fn()
            if n == self.cap:
                self.spent.append(point)

    def log(self, kind, value):
        self.events.append((self.lf, kind, value))

    def on_irq(self):
        self.irq += 1

    def on_reti(self):
        self.irq = max(0, self.irq - 1)

    def on_frame(self):
        # A savestate is taken at a frame edge, maybe inside the VBlank
        # handler; main-thread code running means any such handler is done.
        self.armed, self.irq, self.lag, self.last = True, 0, None, None
        self.lf += 1

    def on_pad(self):
        want = self.inputs[self.lf] if self.lf < len(self.inputs) else 0
        if self.lf != self.pad_lf:
            self.edge, self.prev, self.pad_lf = want & ~self.prev, want, self.lf
        self.mem[self.w["hPlayerInputFlags"]] = want
        self.mem[self.w["hInputRisingEdge"]] = self.edge

    def on_vblank(self):
        # By bank number: an interrupt between a wram_bank's two writes makes
        # the handler return with a different bank mapped than it found.
        m = self.mem
        if m[self.w["hVBlankOccurred"]]:
            self.lag = (m[0xc000:0xd000], [m[b, 0xd000:0xdfff] + [m[b, 0xdfff]] for b in range(1, 8)],
                        m[0xff80:0xffff])

    def on_vblank_reti(self):
        if self.lag:
            m = self.mem
            low, banks, high = self.lag
            m[0xc000:0xd000], m[0xff80:0xffff] = low, high
            for b, data in enumerate(banks, 1):
                m[b, 0xd000:0xdfff] = data[:-1]
                m[b, 0xdfff] = data[-1]
            self.lag = None

    def run(self, inputs, frames, limit):
        self.inputs, self.lf, self.pad_lf, self.prev = inputs, 0, -1, 0
        self.armed = False
        ticks = 0
        while self.lf < frames and ticks < limit:
            self.pb.tick(1, False)
            ticks += 1
            for point in self.spent:
                self.pb.hook_deregister(*point)
            self.removed += self.spent
            self.spent = []
        return ticks

    def close(self):
        self.pb.stop(save=False)
        shutil.rmtree(self.tmp)


def boot(rom, sym, save, out):
    g = Game(rom, sym, save, 10 ** 9)
    presses = [(950, "start"), (90, "a"), (90, "down")] + [(150, "a")] * 6
    inputs = []
    for wait, b in presses:
        inputs += [0] * wait + [BUTTONS[b]] * 6
    inputs += [0] * 300
    g.run(inputs, len(inputs), 20 * len(inputs))
    loc = g.mem[g.w["wStoryModeCurrentLocation"]]
    buf = io.BytesIO()
    g.pb.save_state(buf)
    Path(out).write_bytes(buf.getvalue())
    Path(out + ".irq").write_text(json.dumps(sorted(g.names[p] for p in g.irq_hits)))
    g.close()
    return loc


def chunk(rom, sym, save, state_file, si, li, frames, cap, skip):
    g = Game(rom, sym, save, cap, set(json.loads(Path(skip).read_text())))
    story = Path(state_file).read_bytes()
    dbl, on = states()[si]
    loc, entries = g.locs[li]
    flags = g.sym["wGameFlags"][1]
    result = []
    for entry in entries:
        g.pb.load_state(io.BytesIO(story))
        g.reset_caps()
        g.events = []
        for n in SINGLES + DOUBLES + ALWAYS_CLEAR + [FLAG_DOUBLES]:
            on_ = n in on or (n == FLAG_DOUBLES and dbl)
            a, bit = flags + n // 8, 0x80 >> (n % 8)
            g.mem[a] = (g.mem[a] | bit) if on_ else (g.mem[a] & ~bit & 0xff)
        g.mem[g.sym["wStoryModeCurrentLocation"][1]] = loc
        g.mem[g.sym["wStoryModeEntryPoint"][1]] = entry
        g.mem[g.sym["wStoryModeExitTriggerRequest"][1]] = 0xff
        ticks = g.run(plan(si * 10000 + li * 100 + entry, frames), frames, 4 * frames)
        result.append({"entry": entry, "events": g.events, "logic": g.lf, "ticks": ticks})
    g.close()
    return result


def compare(a, b, skip=3, run=12):
    """Walk the two (kind, value) sequences together and return the index in
    `a` where they part for good (or None), how many events matched at a
    different logic frame, and how many dropouts were stepped over. PyBoy
    now and then misses a breakpoint that an interrupt lands on, so a gap of
    up to `skip` events in either sequence, after which `run` events agree,
    is a dropout and not a divergence. Both are cut at their first taint."""
    for seq in (a, b):
        cut = next((i for i, e in enumerate(seq) if e[1] == "taint"), None)
        if cut is not None:
            del seq[cut + 1:]
    key = lambda e: tuple(e[1:])
    i = j = shifted = dropouts = 0
    while i < len(a) and j < len(b):
        if key(a[i]) == key(b[j]):
            shifted += a[i][0] != b[j][0]
            i, j = i + 1, j + 1
            continue
        for di, dj in sorted(((x, y) for x in range(skip + 1) for y in range(skip + 1) if x or y),
                             key=sum):
            ahead = min(run, len(a) - i - di, len(b) - j - dj)
            if ahead > 0 and all(key(a[i + di + k]) == key(b[j + dj + k]) for k in range(ahead)):
                i, j, dropouts = i + di, j + dj, dropouts + 1
                break
        else:
            return i, shifted, dropouts
    return (None if i == len(a) and j == len(b) else i), shifted, dropouts


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("rom", nargs="?")
    ap.add_argument("--base", default=str(ROOT / "mariotennis.gbc"))
    ap.add_argument("--save", required=True)
    ap.add_argument("--frames", type=int, default=2000, help="logic frames per entry point")
    ap.add_argument("--cap", type=int, default=20, help="entries recorded per code label")
    ap.add_argument("--jobs", type=int, default=8)
    ap.add_argument("--timeout", type=int, default=120)
    ap.add_argument("--states", help="only these state indices, e.g. 0,5,20")
    ap.add_argument("--worker", nargs="+", help=argparse.SUPPRESS)
    args = ap.parse_args()

    if args.worker:
        kind, rom, sym, *rest = args.worker
        if kind == "boot":
            print(boot(rom, sym, args.save, rest[0]))
        else:
            state_file, si, li, skip, out = rest
            res = chunk(rom, sym, args.save, state_file, int(si), int(li), args.frames, args.cap, skip)
            Path(out).write_text(json.dumps(res))
        return 0
    try:
        import pyboy  # noqa: F401
    except ImportError:
        sys.exit("needs PyBoy: pip install pyboy")

    builds = {"base": (args.base, ROOT / "build" / "mariotennis.sym"),
              "rom": (args.rom, Path(args.rom).with_suffix(".sym"))}
    tmp = Path(tempfile.mkdtemp(prefix="eventtest-"))
    me = [sys.executable, __file__, "--save", args.save, "--frames", str(args.frames),
          "--cap", str(args.cap), "--worker"]
    for key, (rom, sym) in builds.items():
        r = subprocess.run(me + ["boot", str(rom), str(sym), str(tmp / f"{key}.state")],
                           capture_output=True, text=True, timeout=args.timeout)
        if r.returncode:
            sys.exit(f"{key} failed to boot:\n{r.stderr[-2000:]}")
        print(f"{key} booted to story location {r.stdout.strip()}")
    skip = tmp / "irq.json"
    skip.write_text(json.dumps(sorted({n for key in builds
                                       for n in json.loads((tmp / f"{key}.state.irq").read_text())})))

    locs = targets(symbols(builds["base"][1]))[5]
    picked = [int(x) for x in args.states.split(",")] if args.states else range(len(states()))
    jobs = [(key, si, li) for si in picked for li in range(len(locs)) for key in builds]

    def work(job):
        key, si, li = job
        rom, sym = builds[key]
        out = tmp / f"{key}_{si}_{li}.json"
        try:
            subprocess.run(me + ["chunk", str(rom), str(sym), str(tmp / f"{key}.state"),
                                 str(si), str(li), str(skip), str(out)],
                           capture_output=True, timeout=args.timeout)
        except subprocess.TimeoutExpired:
            return job, "timeout"
        return job, json.loads(out.read_text()) if out.exists() else "failed"

    results = {}
    with concurrent.futures.ThreadPoolExecutor(args.jobs) as ex:
        for job, res in ex.map(work, jobs):
            results[job] = res
    shutil.rmtree(tmp)

    bad, unsure, events, shifted, tainted, dropouts = [], [], 0, 0, 0, 0
    for si in picked:
        for li in range(len(locs)):
            a, b = results[("base", si, li)], results[("rom", si, li)]
            if isinstance(a, str) or isinstance(b, str):
                unsure.append((si, li, None, f"base {a if isinstance(a, str) else 'ran'}, "
                                             f"rom {b if isinstance(b, str) else 'ran'}"))
                continue
            for x, y in zip(a, b):
                i, s, d = compare(x["events"], y["events"])
                events += len(x["events"])
                shifted += s
                dropouts += d
                tainted += any(e[1] == "taint" for e in x["events"])
                if i is not None:
                    ev = lambda e: f"{e[i][1]} {e[i][2]} at logic frame {e[i][0]}" if i < len(e) else "nothing"
                    bad.append((si, li, x["entry"], f"event {i}: base {ev(x['events'])}, rom {ev(y['events'])}"))
    print(f"{len(picked)} states x {len(locs)} locations: {events} events compared, "
          f"{shifted} at a different logic frame, {dropouts} hook dropouts stepped over, "
          f"{tainted} entries cut at a known "
          f"layout-dependent path, {len(unsure)} chunks inconclusive (PyBoy timed out)")
    for label, rows in (("differs", bad), ("inconclusive", unsure)):
        for si, li, entry, what in rows:
            dbl, on = states()[si]
            print(f"    {label}: state {si} ({'doubles' if dbl else 'singles'} step {len(on)}), "
                  f"location {locs[li][0]:#04x} entry {entry}: {what}")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
