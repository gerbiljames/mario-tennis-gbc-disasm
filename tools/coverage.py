#!/usr/bin/env python3
"""Which routines did the event sweeps run, and which never?

    python3 tools/coverage.py coverage.json [--list never.txt]

reads the coverage file `tools/eventtest.py --coverage` writes (the routines
each run entered, accumulated across runs) and reports:

  * `Unused*` routines that ran: each is a wrong name;
  * routines the sweeps could see but never entered, per source file;
  * routines they cannot see at all: those that open with a jump (not
    hooked, see eventtest.py) and those only interrupt handlers reach.

A routine that never ran is not proof of dead code: random play misses
whole modes (link play needs a partner) and every path behind a state the
sweeps do not set up. It is the list to read, not a verdict.
"""
import argparse
import collections
import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from banksrc import bank_lines, holders
from runtime_audit import MNEMONICS

ROOT = Path(__file__).resolve().parent.parent


def routines():
    """Every global label whose first instruction is code: name -> (file, first op)."""
    out = {}
    for h in holders():
        lines, origins = bank_lines(h)
        for i, line in enumerate(lines):
            m = re.match(r"^([A-Za-z_]\w*):", line)
            if not m:
                continue
            nxt = next((x for x in lines[i + 1:i + 6] if x.strip() and not x.strip().startswith(";")), "")
            op = re.match(r"^\t(\w+)", nxt)
            if op and (op.group(1) in MNEMONICS or op.group(1) in ("farcall", "lb", "ld_slot")
                       or op.group(1).startswith("ld_") and op.group(1).endswith("_indexed")):
                out[m.group(1)] = (origins[i][0].relative_to(ROOT), op.group(1))
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("coverage")
    ap.add_argument("--list", help="write the never-entered routines here, one per line with its file")
    args = ap.parse_args()
    cov = json.loads(Path(args.coverage).read_text())
    entered, hooked = set(cov["entered"]), set(cov["hooked"])
    code = routines()

    wrong = sorted(n for n in entered if n.startswith("Unused"))
    never = sorted(n for n in hooked if n not in entered and n in code)
    unseen = sorted(n for n in code if n not in hooked)
    print(f"{len(code)} routines: {len(entered & set(code))} entered, {len(never)} never entered, "
          f"{len(unseen)} not observable (open with a jump, or interrupt-only)")
    print(f"Unused routines that ran: {len(wrong)}")
    for n in wrong:
        print(f"    {n}")
    named_unused = sum(n.startswith("Unused") for n in never)
    print(f"never entered: {named_unused} already named Unused, {len(never) - named_unused} others; by file:")
    by_file = collections.Counter(str(code[n][0]) for n in never if not n.startswith("Unused"))
    for f, k in by_file.most_common(25):
        print(f"    {k:4d}  {f}")
    if args.list:
        Path(args.list).write_text("".join(f"{n}\t{code[n][0]}\n" for n in never))
    return 1 if wrong else 0


if __name__ == "__main__":
    sys.exit(main())
