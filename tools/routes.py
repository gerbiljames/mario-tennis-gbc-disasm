#!/usr/bin/env python3
"""Which story entry points the game can send the player to.

    python3 tools/routes.py          lists each map_entry row with no way in

A way in is an `ExitTriggers` record's arg1, a code warp (`ld a, STORYLOC_* /
ld [wStoryModeCurrentLocation], a / ld a, $nn / ld [wStoryModeEntryPoint], a`,
or the current location when the routine sets none), a `db STORYLOC_*, $nn`
table row, or `SaveStoryReturnPoint`'s `b`/`c`. A value loaded from RAM counts
as any entry of its location. The debug warp menu, which retail never opens,
is not a way in. `make check` (`entries`) holds every row without one to a
`; debug warp only` comment, and every such comment to a row without one.
"""
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from banksrc import bank_lines, holders  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
MARK = "debug warp only"
DEBUG = {"RunDebugWarpMenu"}


def scan():
    """(rows, ways): rows = [(loc, entry, file, line, marked)], ways = {(loc, entry or None)}."""
    locs = {m.group(1): int(m.group(2), 16) for m in re.finditer(
        r"^def (STORYLOC_\w+)\s+equ \$([0-9a-f]+)", (ROOT / "include" / "constants.inc").read_text(), re.M)}
    lines, origin = [], []
    for h in holders():
        L, O = bank_lines(h)
        lines += L
        origin += O
    owner, g = [], None
    for line in lines:
        m = re.match(r"^([A-Za-z_]\w*):", line)
        if m:
            g = m.group(1)
        owner.append(g)
    starts = {}
    for i, name in enumerate(owner):
        starts.setdefault(name, i)

    def body(name):
        i = starts.get(name)
        if i is None:
            return []
        out = []
        for line in lines[i + 1:]:
            if re.match(r"^[A-Za-z_]\w*:", line):
                break
            out.append(line)
        return out

    def slot(tree, k):
        ws = [m.group(1) for line in body(tree) for m in [re.match(r"\tdw (\w+)", line)] if m]
        return ws[k] if len(ws) > k else None

    trees = {int(m.group(1), 16): re.sub(r"^DataPtr_", "", m.group(2)) for line in lines
             for m in [re.match(r"\tstory_location \$([0-9a-f]+), \w+, (\w+),", line)] if m}
    prefix = {re.sub(r"MapScripts(_\w\w)?$", "", t): loc for loc, t in trees.items()}

    def loc_of(name):
        hits = [(len(p), loc) for p, loc in prefix.items() if name and name.startswith(p)]
        return max(hits)[1] if hits else None

    rows = []
    for loc, tree in trees.items():
        table = slot(tree, 0)
        i = starts.get(table)
        if i is None:
            continue
        for j in range(i + 1, len(lines)):
            m = re.match(r"\tmap_entry \$([0-9a-f]+),", lines[j])
            if not m:
                if re.match(r"^[A-Za-z_]\w*:", lines[j]):
                    break
                continue
            rows.append((loc, int(m.group(1), 16), origin[j][0], origin[j][1], MARK in lines[j]))

    ways = set()
    for loc, tree in trees.items():
        for line in body(slot(tree, 1)):
            m = re.match(r"\tmap_script [^,]+, [^,]+, [^,]+, [^,]+, (STORYLOC_\w+), \$([0-9a-f]+)", line)
            if m:
                ways.add((locs[m.group(1)], int(m.group(2), 16)))
    for i, line in enumerate(lines):
        m = re.match(r"\tdb (STORYLOC_\w+), \$([0-9a-f]+)", line)
        if m:
            ways.add((locs[m.group(1)], int(m.group(2), 16)))
        if re.match(r"\tcall SaveStoryReturnPoint\b|\tfarcall SaveStoryReturnPoint\b", line):
            b = c = None
            for prev in lines[max(0, i - 6):i]:
                mb = re.match(r"\tld b, (STORYLOC_\w+)", prev)
                mc = re.match(r"\tld c, \$([0-9a-f]+)", prev)
                b = locs[mb.group(1)] if mb else b
                c = int(mc.group(1), 16) if mc else c
            if b is not None and c is not None:
                ways.add((b, c))
        if not re.match(r"\tld \[wStoryModeEntryPoint\], a", line) or owner[i] in DEBUG:
            continue
        value, loc = None, None
        for prev in reversed(lines[max(0, i - 10):i]):
            if re.match(r"^[A-Za-z_.]", prev):
                break
            if value is None:
                m = re.match(r"\tld a, (\$[0-9a-f]+|\[\w+)", prev)
                if m:
                    value = int(m.group(1)[1:], 16) if m.group(1).startswith("$") else "ram"
                elif re.match(r"\txor a\b", prev):
                    value = 0
        for prev in reversed(lines[max(0, i - 14):i]):
            if re.match(r"^[A-Za-z_]", prev):
                break
            m = re.match(r"\tld a, (STORYLOC_\w+)", prev)
            if m:
                loc = locs[m.group(1)]
                break
        loc = loc if loc is not None else loc_of(owner[i])
        if loc is not None and value is not None:
            ways.add((loc, None if value == "ram" else value))
    return rows, ways


def unreached():
    rows, ways = scan()
    return [r for r in rows if (r[0], r[1]) not in ways and (r[0], None) not in ways], rows


def check(fail):
    dead, rows = unreached()
    dead = {(r[0], r[1]) for r in dead}
    for loc, entry, f, ln, marked in rows:
        where = f"{Path(f).relative_to(ROOT)}:{ln}"
        if (loc, entry) in dead and not marked:
            fail("entries", f"{where}: entry ${entry:02x} has no way in; mark it `; {MARK}`")
        if (loc, entry) not in dead and marked:
            fail("entries", f"{where}: entry ${entry:02x} is marked `; {MARK}` but has a way in")
    return len(rows)


def main():
    dead, rows = unreached()
    for loc, entry, f, ln, _ in dead:
        print(f"{Path(f).relative_to(ROOT)}:{ln}: location ${loc:02x} entry ${entry:02x}")
    print(f"{len(dead)} of {len(rows)} map_entry rows have no way in")


if __name__ == "__main__":
    main()
