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

Entry ids may be written as ENTRY_<location>_<name> (a `map_entry` row's
name, or an `entry_id` line in the location's EntryPoints table); the check
also fails a name that starts with another location, or that stands for
another location's entry (in a way in, or a `cp` on wStoryModeEntryPoint in a
routine named for its location).
"""
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from banksrc import bank_lines, holders  # noqa: E402
import consts  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
MARK = "debug warp only"
DEBUG = {"RunDebugWarpMenu"}


_ID = r"(\$[0-9a-f]+|ENTRY_\w+)"


def entry_ids():
    """{ENTRY_ name: id} over the `map_entry` row names and `entry_id` lines."""
    out = {}
    for f in sorted((ROOT / "src").rglob("*.asm")):
        for line in f.read_text().split("\n"):
            args = [a.strip() for a in line.split(";")[0].split(",")]
            if line.startswith("\tmap_entry ") and len(args) > 5:
                out["ENTRY_" + args[5]] = int(args[0].split("$")[1], 16)
            m = re.match(r"\tentry_id (\w+), \$([0-9a-f]+)", line)
            if m:
                out["ENTRY_" + m.group(1)] = int(m.group(2), 16)
    return out


def scan():
    """(rows, ways, bad): rows = [(loc, entry, file, line, marked)],
    ways = {(loc, entry or None)}, bad = [(file, line, message)]."""
    locs = {k: v for k, v in consts.constants().items() if k.startswith("STORYLOC_")}
    locname = {v: k[len("STORYLOC_"):] for k, v in locs.items()}
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

    locs = consts.constants()
    trees = {locs[m.group(1)]: re.sub(r"^DataPtr_", "", m.group(2)) for line in lines
             for m in [re.match(r"\tstory_location (\w+), \w+, (\w+),", line)] if m}
    prefix = {re.sub(r"MapScripts(_\w\w)?$", "", t): loc for loc, t in trees.items()}

    def loc_of(name):
        hits = [(len(p), loc) for p, loc in prefix.items() if name and name.startswith(p)]
        return max(hits)[1] if hits else None

    rows, names, bad = [], {}, []
    for loc, tree in trees.items():
        table = slot(tree, 0)
        i = starts.get(table)
        if i is None:
            continue
        for j in range(i + 1, len(lines)):
            if re.match(r"^[A-Za-z_]\w*:", lines[j]):
                break
            m = re.match(r"\tmap_entry \$([0-9a-f]+),", lines[j])
            e = re.match(r"\tentry_id (\w+), \$([0-9a-f]+)", lines[j])
            if m:
                rows.append((loc, int(m.group(1), 16), origin[j][0], origin[j][1], MARK in lines[j]))
                args = lines[j].split(";")[0].split(",")
                name, value = (args[5].strip() if len(args) > 5 else None), int(m.group(1), 16)
            elif e:
                name, value = e.group(1), int(e.group(2), 16)
            else:
                continue
            if name:
                names["ENTRY_" + name] = (loc, value)
                if not name.startswith(locname[loc] + "_"):
                    bad.append((*origin[j], f"ENTRY_{name} is not named for STORYLOC_{locname[loc]}"))

    def entry(tok, loc, j):
        """The id `tok` ($nn or an ENTRY_ name) stands for, used as location `loc`'s."""
        if tok.startswith("$"):
            return int(tok[1:], 16)
        owner, value = names.get(tok, (None, None))
        if owner is None:
            bad.append((*origin[j], f"{tok} is not an entry name"))
        elif loc is not None and owner != loc:
            bad.append((*origin[j], f"{tok} is STORYLOC_{locname[owner]}'s, used for STORYLOC_{locname[loc]}"))
        return value

    ways = set()
    for loc, tree in trees.items():
        i = starts.get(slot(tree, 1))
        for j in range(i + 1, len(lines)) if i is not None else ():
            if re.match(r"^[A-Za-z_]\w*:", lines[j]):
                break
            m = re.match(r"\tmap_script [^,]+, [^,]+, [^,]+, [^,]+, (STORYLOC_\w+), " + _ID, lines[j])
            if m:
                ways.add((locs[m.group(1)], entry(m.group(2), locs[m.group(1)], j)))
    for i, line in enumerate(lines):
        m = re.match(r"\tdb (STORYLOC_\w+), " + _ID, line)
        if m:
            ways.add((locs[m.group(1)], entry(m.group(2), locs[m.group(1)], i)))
        if re.match(r"\tcall SaveStoryReturnPoint\b|\tfarcall SaveStoryReturnPoint\b", line):
            b = c = None
            for k in range(max(0, i - 6), i):
                mb = re.match(r"\tld b, (STORYLOC_\w+)", lines[k])
                mc = re.match(r"\tld c, " + _ID, lines[k])
                b = locs[mb.group(1)] if mb else b
                c = (mc.group(1), k) if mc else c
            if b is not None and c is not None:
                ways.add((b, entry(c[0], b, c[1])))
        if re.match(r"\tld a, \[wStoryModeEntryPoint\]", line) and loc_of(owner[i]) is not None:
            for k in range(i + 1, len(lines)):
                m = re.match(r"\tcp (ENTRY_\w+)", lines[k])
                if m:
                    entry(m.group(1), loc_of(owner[i]), k)
                elif not re.match(r"\t(cp|jp|jr|call|ret)\b|\.\w+:", lines[k]):
                    break
        if not re.match(r"\tld \[wStoryModeEntryPoint\], a", line) or owner[i] in DEBUG:
            continue
        value, loc = None, None
        for k in range(i - 1, max(0, i - 10) - 1, -1):
            prev = lines[k]
            if re.match(r"^[A-Za-z_.]", prev):
                break
            if value is None:
                m = re.match(r"\tld a, (\$[0-9a-f]+|ENTRY_\w+|\[\w+)", prev)
                if m:
                    value = "ram" if m.group(1).startswith("[") else (m.group(1), k)
                elif re.match(r"\txor a\b", prev):
                    value = ("$00", k)
        for prev in reversed(lines[max(0, i - 14):i]):
            if re.match(r"^[A-Za-z_]", prev):
                break
            m = re.match(r"\tld a, (STORYLOC_\w+)", prev)
            if m:
                loc = locs[m.group(1)]
                break
        loc = loc if loc is not None else loc_of(owner[i])
        if loc is not None and value is not None:
            ways.add((loc, None if value == "ram" else entry(*value[:1], loc, value[1])))
    return rows, ways, bad


def unreached():
    rows, ways, bad = scan()
    return [r for r in rows if (r[0], r[1]) not in ways and (r[0], None) not in ways], rows, bad


def check(fail):
    dead, rows, bad = unreached()
    for f, ln, msg in bad:
        fail("entries", f"{Path(f).relative_to(ROOT)}:{ln}: {msg}")
    dead = {(r[0], r[1]) for r in dead}
    for loc, entry, f, ln, marked in rows:
        where = f"{Path(f).relative_to(ROOT)}:{ln}"
        if (loc, entry) in dead and not marked:
            fail("entries", f"{where}: entry ${entry:02x} has no way in; mark it `; {MARK}`")
        if (loc, entry) not in dead and marked:
            fail("entries", f"{where}: entry ${entry:02x} is marked `; {MARK}` but has a way in")
    return len(rows)


def main():
    dead, rows, bad = unreached()
    for f, ln, msg in bad:
        print(f"{Path(f).relative_to(ROOT)}:{ln}: {msg}")
    for loc, entry, f, ln, _ in dead:
        print(f"{Path(f).relative_to(ROOT)}:{ln}: location ${loc:02x} entry ${entry:02x}")
    print(f"{len(dead)} of {len(rows)} map_entry rows have no way in")


if __name__ == "__main__":
    main()
