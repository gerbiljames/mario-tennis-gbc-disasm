#!/usr/bin/env python3
"""List the live routines that are instruction-identical copies of each other.

Reads `src/bank_*.asm`, takes every global label's run of
instructions up to the next global label, and normalises each line by
dropping the address comment and the two-hex-digit bank suffix on names
(`FetchText_25` -> `FetchText`), so copies of one routine assembled into
several banks fingerprint alike whatever their bank-local helpers are
called. Routines shorter than --min instructions and `Unused*` routines
(catalogued in docs/unused_code.md) are left out.

The groups are what a fix has to be applied to in full: the note above each
member in `src/` names its twins, and docs/duplicated_code.md is this
tool's table.

usage: twins.py [--min N] [--json FILE]
"""
import argparse
import collections
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "tools"))
from banksrc import bank_lines, bank_of, holders  # noqa: E402
_LABEL_RE = re.compile(r"^([A-Za-z_]\w*):")
_SUFFIX_RE = re.compile(r"\b([A-Za-z]\w*?)_[0-9a-f]{2}\b")


def routines(min_instrs):
    """name -> (bank, normalised line tuple, instruction count)."""
    out = {}
    for f in holders():
        bank = bank_of(f)
        cur, seq, n = None, [], 0

        def flush():
            if cur and n >= min_instrs and "Unused" not in cur:
                out[cur] = (bank, tuple(seq), n)

        for line in bank_lines(f)[0]:
            m = _LABEL_RE.match(line)
            if m:
                flush()
                cur, seq, n = m.group(1), [], 0
                continue
            if not line.startswith("\t") or line.startswith("\t;"):
                continue
            body = line.split(" ; ")[0]
            seq.append(_SUFFIX_RE.sub(r"\1", body))
            if " ; $" in line and not body.startswith(("\tdb", "\tdw", "\tds",
                                                         "\tINCBIN", "\tINCLUDE")):
                n += 1
        flush()
    return out


def groups(min_instrs=10):
    """Lists of (bank, name, instruction count), largest group first."""
    by_seq = collections.defaultdict(list)
    for name, (bank, seq, n) in routines(min_instrs).items():
        by_seq[seq].append((bank, name, n))
    out = [sorted(g) for g in by_seq.values() if len(g) >= 2]
    out.sort(key=lambda g: (-len(g), g[0][1]))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--min", type=int, default=10, help="minimum instructions")
    ap.add_argument("--json", help="also write the groups to this file")
    args = ap.parse_args()
    gs = groups(args.min)
    if args.json:
        Path(args.json).write_text(json.dumps(gs, indent=0))
    print(f"{len(gs)} groups, {sum(len(g) for g in gs)} routines")
    for g in gs:
        print(f"{g[0][2]:4d}  " + "  ".join(f"{n} (${b:02x})" for b, n, _ in g))


if __name__ == "__main__":
    main()
