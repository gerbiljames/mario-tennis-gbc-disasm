#!/usr/bin/env python3
"""Steer the game into routines no run has entered.

    python3 tools/steer.py --units build/units.json --coverage build/coverage.json
                           [--only NAME ...] [--jobs 14] [--out build/steer.json]

For a reachable routine R that no session entered, the static call graph
(tools/reach.py) gives a chain E -> X1 -> ... -> R from a routine E some
session did enter, in segments: a jump-table entry that lands on a label
inside a routine is a step of its own. The session is replayed (the same
eventtest unit, from `eventtest.py --units`) with hooks that steer each
routine on the chain toward the next: at a conditional branch the flag it
tests is set so it goes the way that leads on soonest (out of a loop rather
than round it); at an `rst Rst00` jump table the index is set to the entry
that leads on; at an indirect jump through a table of routines (`jp hl`,
`JumpToHL`, `CallHLInBankA`) HL is set to the next routine. A story
script's chain starts at the location's own script, replayed in that
location; a mode hook's at `CallModeHook`, while each minigame and drill
runs. Everything else -- registers, RAM, the rest of the game -- is what
the game had, so R runs in a real context with one decision overridden at
a time; what it then does is recorded like any other run. Steering stops
once R has been entered.

This proves R can run, not that play reaches it: the conditions the game
tests on the way are forced, never met.
"""
import argparse
import collections
import concurrent.futures
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import reach  # noqa: E402
from banksrc import bank_lines, bank_of, build_addresses, holders  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
GLOBAL = re.compile(r"^([A-Za-z_]\w*):")
LOCAL = re.compile(r"^(?:[A-Za-z_]\w*)?\.(\w+):")  # `.x:`, or `Routine.x:` after a table
COND = re.compile(r"^(jr|jp) (nz|z|nc|c), (\S+)$")
RETCC = re.compile(r"^ret (nz|z|nc|c)$")
JUMP = re.compile(r"^(jr|jp) (\S+)$")
INDIRECT = re.compile(r"^(jp hl|call JumpToHL|jp JumpToHL|call CallHLInBankA|jp CallHLInBankA)$")
FLAG = {"z": (0x80, True), "nz": (0x80, False), "c": (0x10, True), "nc": (0x10, False)}
DATA = re.compile(r"(db|dw|dn|ds|map_(?!cell\b)\w+|as_\w+|dslot|INCBIN|INCLUDE|anim_\w+|char_record|"
                  r"story_location|obj_template)\b")


class Code:
    """Every global label's lines, and the build address of each line."""

    def __init__(self, sym):
        self.body, self.alias = {}, {}
        for h in holders():
            b = bank_of(h)
            lines = bank_lines(h)[0]
            placed = build_addresses(b, lines, sym)
            starts = [(i, GLOBAL.match(x).group(1)) for i, x in enumerate(lines) if GLOBAL.match(x)]
            for k, (i, name) in enumerate(starts):
                end = starts[k + 1][0] if k + 1 < len(starts) else len(lines)
                self.body[name] = (b, lines, placed, i, end)
            for x in lines:
                m = re.match(r"\s*farptr (\w+), (\w+)", x.split(";")[0])
                if m:
                    self.alias[m.group(1)] = m.group(2)

    def next_global(self, name):
        b, lines, placed, i, end = self.body[name]
        return GLOBAL.match(lines[end]).group(1) if end < len(lines) else None

    def refers(self, code, target):
        """Whether a line names `target` itself (`target.local` is inside it,
        and jumping there does not enter it)."""
        for t, loc in re.findall(r"(?<![\w.])([A-Za-z_]\w*)(\.\w+)?", code):
            t = t[7:] if t.startswith("FarPtr_") else t
            if self.alias.get(t, t) + loc == target:
                return True
        return False

    def is_mode_hooks(self, name):
        """Whether a label is a mode-hook table (a minigame's or drill's)."""
        if name not in self.body:
            return False
        b, lines, placed, i0, end = self.body[name]
        return any("(mode_hooks)" in x for x in lines[i0 + 1:i0 + 3])

    def is_code(self, name):
        """Whether a routine or interior label starts with an instruction."""
        g, _, loc = name.partition(".")
        if g not in self.body:
            return False
        b, lines, placed, i0, end = self.body[g]
        start = i0
        if loc:
            start = next((i for i in range(i0, end) if lines[i].startswith(f".{loc}:")), None)
            if start is None:
                return False
        for x in lines[start + 1:end]:
            c = x.split(";")[0].strip()
            if c and not LOCAL.match(x) and not re.match(r"(ASSERT|DEF|PURGE)\b", c):
                return not DATA.match(c)
        return False


def cfg(code, name):
    """Nodes of routine `name`: line index -> (kind, successors, info)."""
    b, lines, placed, i0, end = code.body[name]
    local = {}
    for i in range(i0 + 1, end):
        m = LOCAL.match(lines[i])
        if m:
            local["." + m.group(1)] = i
            local[name + "." + m.group(1)] = i

    def nxt(i):
        for j in range(i + 1, end):
            c = lines[j].split(";")[0].strip()
            if c and not LOCAL.match(lines[j]) and not re.match(r"(ASSERT|DEF|PURGE)\b", c):
                return j
        return "fall"

    def dest(t):
        return nxt(local[t]) if t in local else ("exit", t)
    nodes = {}
    i = i0 + 1
    while i < end:
        c = lines[i].split(";")[0].strip()
        if not c or LOCAL.match(lines[i]) or re.match(r"(ASSERT|DEF|PURGE)\b", c):
            i += 1
            continue
        if DATA.match(c):
            i += 1
            continue
        m = COND.match(c)
        if m:
            nodes[i] = ("cond", [nxt(i), dest(m.group(3))], m.group(2))
        elif RETCC.match(c):
            nodes[i] = ("cond", [nxt(i), ("exit", "ret")], RETCC.match(c).group(1))
        elif c in ("ret", "reti") or INDIRECT.match(c) and c.startswith("jp"):
            nodes[i] = ("end", [], c)
        elif JUMP.match(c) and not c.startswith("jp hl"):
            nodes[i] = ("jump", [dest(JUMP.match(c).group(2))], None)
        elif c == "rst Rst00":
            tg, j = [], i + 1
            while j < end and re.match(r"\tdw (\S+)", lines[j].split(";")[0]):
                tg.append(dest(re.match(r"\tdw (\S+)", lines[j].split(";")[0]).group(1)))
                j += 1
            nodes[i] = ("table", tg, None)
        else:
            nodes[i] = ("step", [nxt(i)], None)
        i += 1
    return nodes


def steer_plan(code, a, b_name, bsym, via=()):
    """(point, action) pairs that steer routine `a` toward routine `b_name`:
    a line calling or jumping to it, a jump-table entry naming it, or (if
    `a` reaches it only through a data table, `via` or one holding it) the
    indirect jump after the table is loaded, or falling through into it."""
    bank, lines, placed, i0, end = code.body[a]
    nodes = cfg(code, a)
    goals, special = set(), {}
    for i, (kind, succ, info) in nodes.items():
        c = lines[i].split(";")[0].strip()
        if code.refers(c, b_name) and kind != "table":
            goals.add(i)
        if kind == "table":
            for k, s in enumerate(succ):
                if s == ("exit", b_name):
                    goals.add(i)
                    special[i] = ("index", k)
        if kind == "step" and "fall" in succ and code.next_global(a) == b_name:
            goals.add(i)
    if not goals:
        tables = set(via) | {t for t, (tb, tl, tp, ti, te) in code.body.items()
                             if any(re.match(rf"\tdw {re.escape(b_name)}\b", x.split(";")[0])
                                    for x in tl[ti + 1:te])}
        for i, (kind, succ, info) in nodes.items():
            c = lines[i].split(";")[0].strip()
            if INDIRECT.match(c):
                # "*": the table is found through RAM (a mode-hook table)
                if "*" in via or any(code.refers(lines[j].split(";")[0], t) for j in range(i0, i) for t in tables):
                    goals.add(i)
                    special[i] = ("hl", bsym)
    if not goals:
        return None
    # how far each node is from a goal (steps along the way)
    dist = {i: 0 for i in goals}
    changed = True
    while changed:
        changed = False
        for i, (kind, succ, info) in nodes.items():
            d = min((dist[s] + 1 for s in succ if s in dist), default=None)
            if d is not None and d < dist.get(i, d + 1):
                dist[i] = d
                changed = True
    reach_goal = set(dist)
    plan = []
    for i, (kind, succ, info) in nodes.items():
        if i not in placed:
            continue
        point = (bank, placed[i])
        c = lines[i].split(";")[0].strip()
        m = re.match(r"(?:jr|jp|call) (nz|z|nc|c), (\S+)$", c)
        if i in special:
            plan.append((point, special[i]))
        elif i in goals and m and code.refers(m.group(2), b_name):
            # the goal is a conditional jump or call to it: take it
            bit, when = FLAG[m.group(1)]
            plan.append((point, ("flag", bit, when)))
        elif kind == "cond" and i in reach_goal and i not in goals:
            # the way that gets there sooner: out of a loop, not round it again
            d = [dist.get(s, float("inf")) for s in succ]
            if d[0] != d[1]:
                bit, when = FLAG[info]
                plan.append((point, ("flag", bit, when if d[1] < d[0] else not when)))
        elif kind == "table" and i in reach_goal and i not in goals:
            k = min(range(len(succ)), key=lambda k: dist.get(succ[k], float("inf")))
            plan.append((point, ("index", k)))
    return plan


def chains(targets, entered, graph):
    """For each target, the shortest chain of code segments (a routine, or a
    label inside one that something jumps to directly) down from the entry
    of a routine some session entered."""
    callers = collections.defaultdict(set)
    for s, ts in graph.out.items():
        for t in ts:
            if s != t:
                callers[t].add(s)

    def name(seg):
        return seg[0] + ("." + seg[1].lstrip(".") if seg[1] else "")
    out = {}
    for r in targets:
        start = (r, "")
        prev, frontier, found = {start: None}, [start], None
        while frontier and not found:
            nxt = []
            for x in sorted(frontier):
                for c in sorted(callers[x]):
                    if c in prev:
                        continue
                    prev[c] = x
                    if c[1] == "" and c[0] in entered:
                        found = c
                        break
                    nxt.append(c)
                if found:
                    break
            frontier = nxt
        if found:
            chain = [found]
            while chain[-1] != start:
                chain.append(prev[chain[-1]])
            out[r] = [name(x) for x in chain]
    return out


def hops(chain, is_code):
    """(routine, next segment, the data tables between) along a chain: a
    segment in the same routine as the one before is reached inside it."""
    out, a, via = [], chain[0].split(".")[0], []
    for x in chain[1:]:
        if not is_code(x):
            via.append(x)
        elif x.split(".")[0] != a:
            out.append((a, x, via))
            a, via = x.split(".")[0], []
    return out


def plugin_for(sym_path, chain, is_code):
    """An eventtest plugin steering along `chain`, until its last routine runs."""
    import eventtest as E
    sym = E.symbols(sym_path)
    code = Code(sym)
    steps = []
    for a, b, via in hops(chain, is_code):
        p = steer_plan(code, a, b, sym.get(b), via)
        if p is not None:
            steps += p
    done = []

    def plugin(g):
        acts = {}
        for point, action in steps:
            def fn(action=action):
                if done:
                    return
                r = g.rf
                if action[0] == "flag":
                    _, bit, on = action
                    r.F = (r.F | bit) if on else (r.F & ~bit & 0xf0)
                elif action[0] == "index":
                    r.A = action[1]
                elif action[0] == "hl" and action[1]:
                    r.HL = action[1][1]
            acts.setdefault(point, []).append(fn)
        out = {pt: (lambda fns=fns: [f() for f in fns]) for pt, fns in acts.items()}
        if chain[-1] in sym:
            last = sym[chain[-1]]
            prev = out.get(last)
            out[last] = lambda prev=prev: (done.append(1), prev and prev())
        return out
    return plugin, steps, done


def run_one(args):
    """Worker: replay one unit with steering along one chain."""
    rom, sym_path, save, state, unit, chain, frames = args
    import eventtest as E
    code = Code(E.symbols(sym_path))
    plugin, steps, done = plugin_for(sym_path, chain, code.is_code)
    E.PLUGINS.append(plugin)
    tmp = Path(tempfile.mkdtemp(dir=os.environ.get("EVENTTEST_TMP")))
    skip = tmp / "skip.json"
    skip.write_text("[]")
    kind, a, b = unit
    if kind == "story":
        res = E.chunk(rom, sym_path, save, state["story"], a, b, frames, 20, str(skip))
    elif kind == "free":
        res = E.session(rom, sym_path, save, state["menu"], a, frames * 3, 20, str(skip))
    else:
        menu = a in E.MENU_TARGETS
        res = E.target(rom, sym_path, save, state["menu" if menu else "story"], a, b, frames * 3, 20, str(skip))
    # the steering hook at its entry replaces the label's own, so the last
    # routine is counted by that hook having run
    ran = {e[2] for x in res for e in x["events"] if e[1] == "run"} | ({chain[-1]} if done else set())
    return sorted(ran), len(steps)


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--units", default=str(ROOT / "build" / "units.json"))
    ap.add_argument("--coverage", default=str(ROOT / "build" / "coverage.json"))
    ap.add_argument("--rom", default=str(ROOT / "mariotennis.gbc"))
    ap.add_argument("--sym", default=str(ROOT / "build" / "mariotennis.sym"))
    ap.add_argument("--save", default=str(ROOT / "maxed-unlocked.sav"))
    ap.add_argument("--only", nargs="*")
    ap.add_argument("--jobs", type=int, default=8)
    ap.add_argument("--frames", type=int, default=2000)
    ap.add_argument("--timeout", type=int, default=600)
    ap.add_argument("--out", default=str(ROOT / "build" / "steer.json"))
    ap.add_argument("--worker", nargs=2, help=argparse.SUPPRESS)
    a = ap.parse_args()
    if a.worker:
        job = json.loads(Path(a.worker[0]).read_text())
        ran, n = run_one([a.rom, a.sym, a.save, job["state"], tuple(job["unit"]), job["chain"], a.frames])
        Path(a.worker[1]).write_text(json.dumps({"ran": ran, "steps": n}))
        return 0
    import eventtest as E
    g = reach.Graph()
    live, rout = g.reach(), g.routines()
    cov = json.loads(Path(a.coverage).read_text())
    entered, hooked = set(cov["entered"]), set(cov["hooked"])
    units = [(tuple(u), set(r)) for u, r in json.loads(Path(a.units).read_text())]
    todo = sorted(a.only or [n for n in hooked if n in rout and n in live and n not in entered])
    ch = chains(todo, entered, g)
    # a chain must start in a routine some replayable session entered
    replayable = set().union(*(ran for _, ran in units))
    redo = [r for r, c in ch.items() if c[0] not in replayable]
    ch.update(chains(redo, replayable, g))
    tmp = Path(tempfile.mkdtemp(dir=ROOT / "build"))
    os.environ["EVENTTEST_TMP"] = str(tmp)
    state = {"story": str(tmp / "story"), "menu": str(tmp / "menu")}
    E.boot(a.rom, a.sym, a.save, state["story"])
    E.boot(a.rom, a.sym, a.save, state["menu"], menu=True)
    cost = {"target": 0, "story": 1, "free": 2}
    scene = (ROOT / "src" / "engine" / "story" / "scene_0a.asm").read_text()
    trees = re.findall(r"story_location [^,]+, \w+, DataPtr_(\w+)", scene)
    locs = E.targets(E.symbols(a.sym))[5]
    handler_k = {row[7]: k for k, row in enumerate(E.handlers())}
    code = Code(E.symbols(a.sym))
    jobs = []
    for r in todo:
        if r not in ch:
            print(f"{r}: no chain from an entered routine")
            continue
        chain = ch[r]
        tree = next((x for x in chain if x in trees), None)
        hooks = next((x for x in chain if code.is_mode_hooks(x)), None)
        if hooks:
            # a mode hook runs from CallModeHook, which reads the table from
            # RAM: steer there while that minigame or drill is running
            chain = ["CallModeHook", "*"] + chain[chain.index(hooks) + 1:]
            us = [("target", t, 0) for t in E.MENU_TARGETS + E.TARGETS
                  if t.startswith(("minigame", "drill")) and not t.startswith("drillid")]
        elif tree:
            # a story script: steer from the location's own script, in
            # that location or as its handler target
            chain = chain[chain.index(tree) + 1:]
            while chain and not code.is_code(chain[0]):
                chain = chain[1:]
            li = [k for k, (loc, _) in enumerate(locs) if loc == trees.index(tree)]
            # the script's own handler target, any other of the location's
            # (a short warp there), then its story chunks
            here = [k for k, row in enumerate(E.handlers()) if row[0] == trees.index(tree)]
            us = ([("target", f"handler{handler_k[chain[0]]}", 0)] if chain[0] in handler_k else []) + \
                [("target", f"handler{k}", 0) for k in here[:1]] + \
                [("story", si, li[0]) for si in (0, 20, 35) if li]
        else:
            us = sorted({u for u, ran in units if chain[0] in ran}, key=lambda u: (cost[u[0]], str(u)))
            # a short target first, then a story chunk and a long session if there are any
            us = [next((u for u in us if u[0] == kind), None) for kind in ("target", "story", "free")]
            us = [u for u in us if u]
        if not us:
            print(f"{r}: no session entered {chain[0]}")
            continue
        ch[r] = chain
        jobs.append((r, us))

    def work(job):
        r, us = job
        res = None
        for unit in us:
            f = tmp / f"job_{r}.json"
            o = tmp / f"out_{r}.json"
            o.unlink(missing_ok=True)
            f.write_text(json.dumps({"state": state, "unit": list(unit), "chain": ch[r]}))
            try:
                subprocess.run([sys.executable, __file__, "--rom", a.rom, "--sym", a.sym, "--save", a.save,
                                "--frames", str(a.frames), "--worker", str(f), str(o)],
                               capture_output=True, timeout=a.timeout)
            except subprocess.TimeoutExpired:
                continue
            res = json.loads(o.read_text()) if o.exists() else None
            if res and r in res["ran"]:
                return r, unit, res
        return r, us[-1], res
    results = {}
    with concurrent.futures.ThreadPoolExecutor(a.jobs) as ex:
        for r, unit, res in ex.map(work, jobs):
            ok = res is not None and r in res["ran"]
            results[r] = {"unit": list(unit), "chain": ch[r], "entered": ok,
                          "steps": res and res["steps"], "ran": res["ran"] if res else None}
            print(f"{r}: {'entered' if ok else 'failed' if res else 'timeout'} "
                  f"({' -> '.join(ch[r])}; {unit})", flush=True)
    Path(a.out).write_text(json.dumps(results, indent=0))
    got = sum(v["entered"] for v in results.values())
    print(f"{got} of {len(todo)} entered")
    shutil.rmtree(tmp, True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
