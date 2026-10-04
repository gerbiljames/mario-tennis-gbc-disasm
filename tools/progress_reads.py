#!/usr/bin/env python3
"""The roles of the story's progress-flag references, on the Archipelago branch.

    python3 tools/progress_reads.py              list the references and their roles
    python3 tools/progress_reads.py --seed DIR   rebuild the table from audit JSON in DIR

Class passes, drill items and the like open what the story's progress flags
(FLAG_WON_*, FLAG_REACHED_*, FLAG_STORY_COMPLETE_*, FLAG_CLEARED_*) used to:
each reference that decided access or presentation was rewritten to read
the items (ap_pass, ap_has). What still names one of those flags has a role
in tools/progress_reads.json:

  record        what was actually won (rewards, which rank a ranker offers
                next, round progression): stays a flag read
  setter        writes the flag
  cosmetic      a presentation read deliberately left on the flag (a label
                or a line of dialogue)
  dead          in an Unused routine

`make check` (`progress`) fails on a reference the table does not list, or
an entry no reference matches, so a new read -- a rebase onto main, a new
routine -- must be classified. A key is file|routine|form flag|n, n counting
that form and flag within the routine."""
import argparse
import json
import re
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TABLE = ROOT / "tools" / "progress_reads.json"
ROLES = {"record", "setter", "cosmetic", "dead"}
FLAG = r"FLAG_(?:WON|REACHED|STORY_COMPLETE|CLEARED)_\w+"
SITE = re.compile(rf"^\t(test_flag|set_flag|clear_flag|flag_id|ld_flag_id)\b[^;\n]*?\b({FLAG})\b")
GLOBAL = re.compile(r"^([A-Za-z_{][\w{}]*):")


def scan():
    """[(key, file, line number)] for every reference in src/."""
    out = []
    for path in sorted((ROOT / "src").rglob("*.asm")):
        rel = path.relative_to(ROOT).as_posix()
        owner, seen = None, Counter()
        for n, line in enumerate(path.read_text().splitlines(), 1):
            m = GLOBAL.match(line)
            if m:
                owner, seen = m.group(1), Counter()
                continue
            m = SITE.match(line)
            if m:
                form, flag = m.groups()
                seen[(form, flag)] += 1
                out.append((f"{rel}|{owner}|{form} {flag}|{seen[(form, flag)]}", rel, n))
    return out


def load():
    return json.loads(TABLE.read_text()) if TABLE.exists() else {}


def check(fail):
    table, sites = load(), scan()
    keys = {k for k, _, _ in sites}
    for key, rel, n in sites:
        if key not in table:
            fail("progress", f"{rel}:{n}: {key.split('|')[2]} has no role in tools/progress_reads.json")
        elif table[key] not in ROLES:
            fail("progress", f"{rel}:{n}: unknown role {table[key]!r}")
    for key in sorted(set(table) - keys):
        fail("progress", f"tools/progress_reads.json: {key} matches no reference")
    return len(sites)


def seed(audit_dir):
    """A table from the audit records: a site keeps its audited role, a
    presentation read left in place is cosmetic, one in Unused code dead."""
    records = [r for f in sorted(Path(audit_dir).glob("*.json")) for r in json.loads(f.read_text())]
    table, unmatched = {}, []
    for key, rel, n in scan():
        owner, (form, flag) = key.split("|")[1], key.split("|")[2].split()
        role = None
        for r in records:
            if r["file"] != rel or flag not in r["flag"]:
                continue
            lo, _, hi = str(r["line"]).partition("-")
            if int(lo) <= n <= int(hi or lo):
                role = r["role"]
                break
        if owner and owner.startswith("Unused"):
            role = "dead"
        elif form in ("set_flag", "clear_flag"):
            role = "setter"
        elif role in ("presentation", "access"):
            role = "cosmetic"
        if role not in ROLES:
            unmatched.append((rel, n, key, role))
            role = "record"
        table[key] = role
    TABLE.write_text(json.dumps(dict(sorted(table.items())), indent=1) + "\n")
    return unmatched


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--seed", help="a directory of audit JSON files")
    args = ap.parse_args()
    if args.seed:
        for rel, n, key, role in seed(args.seed):
            print(f"{rel}:{n}: {key.split('|')[2]}: audited {role!r}, set to record")
        return
    table = load()
    for key, rel, n in scan():
        print(f"{table.get(key, '?'):9s} {rel}:{n} {key.split('|')[2]}")


if __name__ == "__main__":
    main()
