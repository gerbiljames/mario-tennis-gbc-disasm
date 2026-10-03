#!/usr/bin/env python3
"""Which routines the game can reach at all, from its hardware entry points.

    python3 tools/reach.py                  list what the names get wrong
    python3 tools/reach.py --coverage build/coverage.json
                                            also sort the routines no run
                                            entered: unreachable, or reachable
                                            and under which routine that ran

Starts at the reset vector, the interrupt vectors and the rst vectors and
follows every reference by name: a call, jump or branch, a pointer in a
table, a farcall (through the slot table, including the aliases a
two-argument `farptr` row makes), a name inside a macro body (credited to
each line that uses the macro), and falling off the end of code into the
label that follows it. A `farptr` row in a bank's $4000 slot table defines a
slot; it is not a call, so a routine only its slot names is unreachable.
Code is followed from label to label: a jump to `X.local` reaches the code
from that local label on, not `X`'s entry.

A call or jump that only runs when a variable holds a value no code stores
into it is dead by data (`data_dead()`): the variable is loaded and tested
on the way there, and every value code outside `Unused` routines visibly
stores fails the test. A scan cannot see a record copied in through a
computed pointer, so each such variable is reviewed in DATA_FLAGS -- dead
(the edge is dropped) or live -- and one nobody has reviewed fails the
check.

`Unused` in a name claims the routine's entry is unreachable, and `make
check` holds every routine to it (`check()`): an `Unused` routine that is
reachable, or an unreachable one that is not named so, fails. Labels inside
a shared twin template cannot be renamed per bank and are exempt.
"""
import argparse
import collections
import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from banksrc import bank_lines, holders  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
ROOTS = ["EntryPoint", "VBlankInterrupt", "LCDStatInterrupt", "TimerInterrupt", "SerialInterrupt",
         "JoypadInterrupt", "Rst00", "Rst08", "Rst18", "Rst20", "Rst28", "Rst30"]
MNEMONICS = frozenset(
    "adc add and bit call ccf cp cpl daa dec di ei halt inc jp jr ld ldd ldh ldi nop or pop push "
    "res ret reti rl rla rlc rlca rr rra rrc rrca rst sbc scf set sla sra srl stop sub swap xor".split())
# Ran in the coverage sweep although no path to it is known: its only caller
# is Unused_00_FarCallVectorInline, and nothing in the ROM calls or jumps to
# either (docs/unused_code.md).
KNOWN_UNEXPLAINED = {"CallVectorEntryE"}
# Variables that decide a call or jump and that no code outside `Unused`
# routines visibly stores a value for that passes the test (data_dead()),
# each reviewed: dead (the edge is dropped, and what only it reached must be
# named Unused) or live (written some way the scan does not see).
DATA_FLAGS = {
    "hFadeState": ("dead", "bit 7 selects Unused_00_ApplyWhiteFade; the stores are $00, $01 and $02, "
                           "and only Unused_00_BeginWhiteFadeOut sets bit 7 (docs/bugs.md)"),
    "wSecondaryTimerMode": ("dead", "UpdateGameTimer ticks the second timer at mode 1; the only store "
                                    "is Unused_00_TickSecondaryTimerCountdown's $ff"),
    "hLinkErrorFlags": ("dead", "AdvanceFrame's link-error reset needs bits 5-7; both stores are "
                                "xor a clears (docs/bugs.md)"),
    "wGlyphBufferHoldCount": ("dead", "PrepareGlyphBuffer's keep branch; nothing ever raises the "
                                      "count (docs/bugs.md)"),
    "wStoryModeGenderOfMainCharacter": ("live", "a story record field, copied in with the record"),
    "wStoryModeGenderOfPartnerCharacter": ("live", "a story record field, copied in with the record"),
    "wStoryLocationBGM": ("live", "copied from the location header by LoadStoryLocationHeader"),
    "wCurrentMinigameStoryMatch": ("live", "the match launchers store the (list, index) word through "
                                           "a pointer; the doubles lists are odd"),
}
GLOBAL = re.compile(r"^([A-Za-z_]\w*):")
LOCAL = re.compile(r"^(\.\w+):")
# a local label defined away from its routine, after data that sits inside it
# (`Routine.tail:` past a table): the code from there on is Routine's again
QUALIFIED = re.compile(r"^([A-Za-z_]\w*)(\.\w+):")
TERMINAL = re.compile(r"^(reti?|jp|jr)\b")
CONDITIONAL = re.compile(r"^(ret (nz|z|nc|c)$|(jp|jr) (nz|z|nc|c),)")


def macros():
    """name -> (names its body mentions, whether its body is code)."""
    refs, is_code = collections.defaultdict(set), {}
    for inc in (ROOT / "include").rglob("*.inc"):
        mac = None
        for line in inc.read_text().split("\n"):
            m = re.match(r"\s*MACRO (\w+)", line)
            if m:
                mac = m.group(1)
                is_code.setdefault(mac, False)
                continue
            if re.match(r"\s*ENDM", line):
                mac = None
                continue
            if mac:
                code = line.split(";")[0].strip()
                if code.split(" ")[0] in MNEMONICS:
                    is_code[mac] = True
                for t in re.findall(r"\b([A-Za-z_]\w*)", code):
                    refs[mac].add(t)
    # a macro made of code macros is code
    for _ in range(4):
        for inc in (ROOT / "include").rglob("*.inc"):
            mac = None
            for line in inc.read_text().split("\n"):
                m = re.match(r"\s*MACRO (\w+)", line)
                if m:
                    mac = m.group(1)
                    continue
                if re.match(r"\s*ENDM", line):
                    mac = None
                    continue
                if mac and is_code.get(line.split(";")[0].strip().split(" ")[0]):
                    is_code[mac] = True
    return refs, is_code


class Graph:
    def __init__(self):
        mrefs, self.mcode = macros()
        self.banks = [bank_lines(h) for h in holders()]
        self.labels, self.origin, self.twin_internal = set(), {}, set()
        for lines, origin in self.banks:
            for i, line in enumerate(lines):
                m = GLOBAL.match(line)
                if m:
                    self.labels.add(m.group(1))
                    self.origin[m.group(1)] = origin[i]
        # a label written nowhere in the source comes out of a twin template
        written = set()
        for f in (ROOT / "src").rglob("*.asm"):
            text = f.read_text()
            written |= set(re.findall(r"^([A-Za-z_]\w*):", text, re.M))
            written |= set(re.findall(r"^\ttwin\w* \w+, (\w+)", text, re.M))
        self.twin_internal = self.labels - written
        alias = {}
        for lines, _ in self.banks:
            for line in lines:
                m = re.match(r"\s*farptr (\w+), (\w+)", line.split(";")[0])
                if m:
                    alias[m.group(1)] = m.group(2)
        # segments: (global, local or "") -> set of segment keys it reaches
        self.out = collections.defaultdict(set)
        self.sites = collections.defaultdict(list)     # (segment, target) -> [(bank index, line)]
        self.first_is_code = {}
        for bi, (lines, _) in enumerate(self.banks):
            glob = seg = None
            last, dead = "", False
            for i, line in enumerate(lines):
                g, lo, q = GLOBAL.match(line), LOCAL.match(line), QUALIFIED.match(line)
                if q:
                    if seg and self.is_code(last) and not (TERMINAL.match(last) and not CONDITIONAL.match(last)):
                        self.out[seg].add((q.group(1), q.group(2)))
                    glob = q.group(1)
                    seg, last, dead = (q.group(1), q.group(2)), "", False
                    continue
                if g or lo:
                    new = (g.group(1), "") if g else (glob, lo.group(1))
                    if seg and self.is_code(last) and not (TERMINAL.match(last) and not CONDITIONAL.match(last)):
                        self.out[seg].add(new)
                    if g:
                        glob = g.group(1)
                    seg, last, dead = new, "", False
                    continue
                if seg is None:
                    continue           # the $4000 slot table: a farptr row is not a call
                code = line.split(";")[0].strip()
                if not code or re.match(r"(ASSERT|DEF|PURGE)\b", code):
                    continue           # assembler directives name nothing at run time
                if glob not in self.first_is_code:
                    self.first_is_code[glob] = self.is_code(code)
                if dead and self.is_code(code):
                    continue           # after an unconditional ret/jp/jr: nothing gets here
                last = code
                if self.is_code(code) and TERMINAL.match(code) and not CONDITIONAL.match(code):
                    dead = True
                if code.startswith("farptr"):
                    continue
                head = code.split(" ")[0]
                names = re.findall(r"\b([A-Za-z_]\w*)(\.\w+)?", code)
                names += [(glob, loc) for loc in re.findall(r"(?<![\w.])(\.[A-Za-z_]\w*)", code)]
                names += [(t, "") for t in mrefs.get(head, ())]
                for t, loc in names:
                    if t.startswith("FarPtr_"):
                        t = t[7:]
                    t = alias.get(t, t)
                    if t in self.labels and (t, loc or "") != seg:
                        self.out[seg].add((t, loc or ""))
                        self.sites[(seg, (t, loc or ""))].append((bi, i))

    def data_dead(self):
        """Edges no value the game can store makes it take: (edges, notes).

        A call or jump whose way there is decided by one variable -- loaded
        with `ld a, [V]` / `ldh a, [V]` and tested by the instructions up to
        it (`cp`, `and`, `or`, `add a`, `bit`), including an earlier branch
        that would skip it -- is dead if none of the values code outside
        `Unused` routines stores into V (and zero, the boot clear) meets the
        test. It says nothing if any store's value is unknown, or if code
        outside `Unused` routines takes V's address (a store through a
        pointer could reach it)."""
        if hasattr(self, "_dead"):
            return self._dead
        consts = constants()
        values = {}                          # V -> set of stored values, or None
        taken = set()
        owner_of = {}
        for bi, (lines, _) in enumerate(self.banks):
            glob = None
            for i, line in enumerate(lines):
                m = GLOBAL.match(line)
                if m:
                    glob = m.group(1)
                owner_of[(bi, i)] = glob
                if glob is None or glob.startswith("Unused"):
                    continue
                code = line.split(";")[0].strip()
                m = re.match(r"^ld (?:hl|de|bc), (\w+)", code) or re.match(r"^ld c, LOW\((\w+)", code)
                if m:
                    taken.add(m.group(1))
                m = re.match(r"^ldh? \[(\w+)\], a$", code)
                if m:
                    v = stored_value(lines, i, consts)
                    have = values.setdefault(m.group(1), {0})     # 0: the boot clear
                    if have is not None:
                        values[m.group(1)] = None if v is None else have | {v}
        edges, notes = set(), []
        self.unreviewed = set()
        for (seg, t), where in self.sites.items():
            verdicts = []
            for bi, i in where:
                lines, origin = self.banks[bi]
                test = guard(lines, i, consts)
                if not test:
                    verdicts.append(False)
                    continue
                var, pred = test
                vals = values.get(var, {0})
                if vals is None or var in taken or var.startswith("r") or any(pred(v) for v in vals):
                    verdicts.append(False)
                    continue
                if not seg[0].startswith("Unused"):
                    notes.append((origin[i], seg[0], t[0], var, sorted(vals)))
                    if var not in DATA_FLAGS:
                        self.unreviewed.add(var)
                verdicts.append(DATA_FLAGS.get(var, ("",))[0] == "dead")
            if verdicts and all(verdicts):
                edges.add((seg, t))
        self._dead = (edges, notes)
        return self._dead

    def is_code(self, stmt):
        head = stmt.split(" ")[0]
        return head in MNEMONICS or self.mcode.get(head, False)

    def reach(self, drop=None):
        """Routines reachable from the vectors; `drop` defaults to the edges
        data_dead() finds."""
        drop = self.data_dead()[0] if drop is None else drop
        live = {(r, "") for r in ROOTS}
        stack = list(live)
        while stack:
            x = stack.pop()
            for t in self.out.get(x, ()):
                if (x, t) in drop:
                    continue
                if t not in live:
                    live.add(t)
                    stack.append(t)
        return {g for (g, loc) in live if loc == ""}

    def routines(self):
        return {n for n, c in self.first_is_code.items() if c}


def constants():
    out = {}
    for inc in (ROOT / "include").rglob("*.inc"):
        for m in re.finditer(r"^def (\w+)\s+equ \$([0-9a-f]+)", inc.read_text(), re.M | re.I):
            out[m.group(1)] = int(m.group(2), 16)
    return out


def number(tok, consts):
    tok = tok.strip()
    if re.match(r"^\$[0-9a-f]+$", tok, re.I):
        return int(tok[1:], 16)
    if re.match(r"^\d+$", tok):
        return int(tok)
    return consts.get(tok)


def stored_value(lines, i, consts):
    """The value `ld [V], a` at line i stores, when the lines just before it
    fix it: `ld a, K`, `xor a`, or `and a`/`or a` then a `jr nz` past it."""
    zero_if_falls = False
    for k in range(i - 1, max(i - 8, -1), -1):
        code = lines[k].split(";")[0].strip()
        if not code:
            continue
        if GLOBAL.match(lines[k]) or LOCAL.match(lines[k]):
            return None
        m = re.match(r"^ld a, (\S+)$", code)
        if m:
            return number(m.group(1), consts)
        if code == "xor a":
            return 0
        if re.match(r"^jr nz, ", code):
            zero_if_falls = True
            continue
        if code in ("and a", "or a") and zero_if_falls:
            return 0
        if re.match(r"^ldh? \[\w+\], a$", code) or code.startswith(("ld b", "ld c", "ld d", "ld e", "ld h", "ld l")):
            continue
        return None
    return None


def guard(lines, i, consts):
    """(V, test) when the transfer at line i happens only for values of V that
    pass test: the path back to `ld a, [V]` has no label, and every branch
    on it tests flags that V decides."""
    code = lines[i].split(";")[0].strip()
    m = re.match(r"^(call|jp|jr) (?:(nz|z|nc|c), )?\S+$", code)
    if not m:
        return None
    start = None
    for k in range(i - 1, max(i - 12, -1), -1):
        c = lines[k].split(";")[0].strip()
        if GLOBAL.match(lines[k]) or LOCAL.match(lines[k]):
            break
        mm = re.match(r"^ldh? a, \[(\w+)\]$", c)
        if mm:
            start = (k, mm.group(1))
            break
    if not start:
        return None
    k0, var = start
    a = lambda v: v                      # A as a function of V, or None
    z = cflag = None                     # flags as tests of V, or None
    tests = []
    for k in range(k0 + 1, i + 1):
        c = lines[k].split(";")[0].strip()
        if not c:
            continue
        cc = re.match(r"^(?:jr|jp|call|ret) (nz|z|nc|c)\b", c)
        if cc:
            flag = {"z": z, "nz": z, "c": cflag, "nc": cflag}[cc.group(1)]
            if flag is None:
                continue                      # decided by something else: either way
            want = cc.group(1) in ("z", "c")
            if k == i:
                tests.append(lambda v, f=flag, w=want: f(v) == w)   # taken: the transfer
            else:
                tests.append(lambda v, f=flag, w=want: f(v) != w)   # not taken: onto the path
            continue
        mm = re.match(r"^(cp|and|or|xor) (\S+)$", c)
        if mm and mm.group(2) != "a":
            n = number(mm.group(2), consts)
            if n is None or a is None:
                a = z = cflag = None
                continue
            op = mm.group(1)
            if op == "cp":
                z, cflag = (lambda v, f=a, n=n: f(v) == n), (lambda v, f=a, n=n: f(v) < n)
            else:
                f0 = a
                a = {"and": lambda v, f=f0, n=n: f(v) & n, "or": lambda v, f=f0, n=n: f(v) | n,
                     "xor": lambda v, f=f0, n=n: f(v) ^ n}[op]
                z, cflag = (lambda v, f=a: f(v) == 0), (lambda v: False)
            continue
        if c in ("and a", "or a"):
            if a is None:
                z = cflag = None
            else:
                z, cflag = (lambda v, f=a: f(v) == 0), (lambda v: False)
            continue
        if c == "add a":
            if a is None:
                z = cflag = None
            else:
                f0 = a
                cflag = lambda v, f=f0: f(v) >= 0x80
                a = lambda v, f=f0: (f(v) * 2) & 0xff
                z = lambda v, f=a: f(v) == 0
            continue
        mm = re.match(r"^bit (\d), a$", c)
        if mm:
            z = None if a is None else (lambda v, f=a, b=int(mm.group(1)): not (f(v) >> b) & 1)
            continue
        if re.match(r"^ld a, ", c) or c == "pop af":
            a = None
            if c == "pop af":
                z = cflag = None
            continue
        if re.match(r"^(ld [bcdehl]|ld \[|ldh \[|push|ld [bdh][cel], )", c) or c.startswith(("call ", "farcall ")):
            if c.startswith(("call ", "farcall ")) and k != i:
                a = z = cflag = None          # a callee may change anything
            continue
        a = z = cflag = None                  # anything else: flags unknown
    if not tests:
        return None
    return var, (lambda v: all(t(v) for t in tests))


def check(fail):
    g = Graph()
    live = g.reach()
    for var in sorted(g.unreviewed):
        where = [f"{Path(f).relative_to(ROOT)}:{ln}" for (f, ln), *_ , v, _vals in g.data_dead()[1] if v == var]
        fail("reach", f"{where[0]}: {var} decides a call no visible store can take; review it in "
                      f"DATA_FLAGS (tools/reach.py)")
    n = 0
    for name in sorted(g.routines()):
        n += 1
        if name in g.twin_internal or name in KNOWN_UNEXPLAINED:
            continue
        where = f"{Path(g.origin[name][0]).relative_to(ROOT)}:{g.origin[name][1]}"
        if name.startswith("Unused") and name in live:
            fail("reach", f"{where}: {name} is reachable from the vectors")
        elif not name.startswith("Unused") and name not in live:
            fail("reach", f"{where}: {name} cannot be reached; name it Unused_<bank>_...")
    return n


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--coverage", help="a coverage file from tools/eventtest.py --coverage")
    a = ap.parse_args()
    g = Graph()
    live = g.reach()
    rout = g.routines()
    for (f, ln), seg, t, var, vals in g.data_dead()[1]:
        state = DATA_FLAGS.get(var, ("unreviewed",))[0]
        if state == "live":
            continue
        print(f"{Path(f).relative_to(ROOT)}:{ln}: {seg} -> {t} needs {var} to hold a value it never "
              f"is given ({', '.join(f'${v:02x}' for v in vals)}): {state}")
    wrong = [n for n in sorted(rout) if n not in g.twin_internal and n not in KNOWN_UNEXPLAINED
             and (n.startswith("Unused")) == (n in live)]
    print(f"{len(rout)} routines, {len(rout & live)} reachable; {len(wrong)} names disagree")
    for n in wrong:
        print(f"    {n}: {'reachable' if n in live else 'unreachable'}")
    if a.coverage:
        cov = json.loads(Path(a.coverage).read_text())
        entered, hooked = set(cov["entered"]), set(cov["hooked"])
        gap = sorted(n for n in entered if n in rout and n not in live and n not in KNOWN_UNEXPLAINED)
        never = [n for n in hooked if n in rout and n not in entered]
        print(f"ran but unreachable (a gap in this model): {gap}")
        print(f"{len(never)} never entered: {sum(n not in live for n in never)} unreachable, "
              f"{sum(n in live for n in never)} reachable but not reached")
    return 1 if wrong else 0


if __name__ == "__main__":
    sys.exit(main())
