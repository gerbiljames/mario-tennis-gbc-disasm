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
GLOBAL = re.compile(r"^([A-Za-z_]\w*):")
LOCAL = re.compile(r"^(\.\w+):")
TERMINAL = re.compile(r"^(reti?|jp|jr)\b")
CONDITIONAL = re.compile(r"^(ret (nz|z|nc|c)$|(jp|jr) (nz|z|nc|c),)")


def macros():
    """name -> (names its body mentions, whether its body is code)."""
    refs, is_code = collections.defaultdict(set), {}
    for inc in (ROOT / "include").glob("*.inc"):
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
        for inc in (ROOT / "include").glob("*.inc"):
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
        self.first_is_code = {}
        for lines, _ in self.banks:
            glob = seg = None
            last, dead = "", False
            for i, line in enumerate(lines):
                g, lo = GLOBAL.match(line), LOCAL.match(line)
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

    def is_code(self, stmt):
        head = stmt.split(" ")[0]
        return head in MNEMONICS or self.mcode.get(head, False)

    def reach(self):
        live = {(r, "") for r in ROOTS}
        stack = list(live)
        while stack:
            x = stack.pop()
            for t in self.out.get(x, ()):
                if t not in live:
                    live.add(t)
                    stack.append(t)
        return {g for (g, loc) in live if loc == ""}

    def routines(self):
        return {n for n, c in self.first_is_code.items() if c}


def check(fail):
    g = Graph()
    live = g.reach()
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
