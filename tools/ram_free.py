#!/usr/bin/env python3
"""Which RAM bytes nothing names or addresses.

Walks the generated `ram/wram.asm` and `ram/hram.asm` the way the assembler
does -- sections, unions, every `db`/`dw`/`ds` -- and reports the bytes no
symbol covers (an anonymous `ds` gap, or the tail of a bank after its last
declaration), minus any address a raw literal in `src/` still refers to.
Mirrored symbols (`ram_unions.json`, `mirrored: true`) count as named in the
banks they list.

Static only: a byte here is unreferenced by name, not proven unused -- a
buffer declared shorter than the loop that fills it reaches past its symbol,
and a record's undeclared fields are read like any other. docs/ram_map.md
("Free RAM") records which of these ranges an emulator poison run left
untouched, which is the list a modder should take.

usage: ram_free.py [--json FILE]      prints the free ranges per bank
"""
import argparse
import glob
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "tools"))
# The stack grows down from STACK_TOP ($d000, include/constants.inc) and has
# no symbol; the deepest reach observed (a doubles match, the overworld) is
# $cf34, so the top 512 bytes of WRAM0 are reserved for it, not free.
STACK_ZONE = 0xCE00
_SECTION_RE = re.compile(r'^SECTION "[^"]*", (WRAM0|WRAMX|HRAM)\[\$([0-9a-f]+)\](?:, BANK\[(\d+)\])?')
_DECL_RE = re.compile(r"^(?:([A-Za-z_]\w*)::?\s*)?(db|dw|ds)(?:\s+(\S+))?\s*(?:;.*)?$")


def _num(s):
    s = s.strip()
    return int(s[1:], 16) if s.startswith("$") else int(s)


def named_bytes():
    """{(space, bank): set(addresses a symbol covers)}; space 'w' or 'h'."""
    named = {}
    for fn in ("wram.asm", "hram.asm"):
        space = bank = base = None
        addr = 0
        union = []          # stack of (start, max_end)
        for line in (ROOT / "ram" / fn).read_text().splitlines():
            line = line.rstrip()
            m = _SECTION_RE.match(line)
            if m:
                space = "h" if m.group(1) == "HRAM" else "w"
                bank = int(m.group(3) or 0)
                addr = base = int(m.group(2), 16)
                union = []
                continue
            if space is None or not line or line.startswith(";"):
                continue
            s = line.strip()
            if s == "UNION":
                union.append([addr, addr])
                continue
            if s == "NEXTU":
                union[-1][1] = max(union[-1][1], addr)
                addr = union[-1][0]
                continue
            if s == "ENDU":
                start, end = union.pop()
                addr = max(end, addr)
                continue
            d = _DECL_RE.match(s)
            if not d:
                continue
            name, kind, arg = d.groups()
            n = {"db": 1, "dw": 2}.get(kind) or _num(arg)
            if name:
                named.setdefault((space, bank), set()).update(range(addr, addr + n))
            addr += n
    # mirrored names allocate nothing -- the banks they list already declare
    # the bytes -- but a range only they name must still count as named
    from disasmlib.ram import ram_field_size
    for u in json.loads((ROOT / "ram_unions.json").read_text())["unions"]:
        for v in u["variants"]:
            if not v.get("mirrored"):
                continue
            for a, sym in v["symbols"].items():
                a, n = int(a, 0), ram_field_size(sym)
                for b in v.get("banks", []):
                    named.setdefault(("w", int(b, 0)), set()).update(range(a, a + n))
    return named


def literal_refs():
    """RAM addresses raw literals in the source still name (dead code,
    unresolved operands): {(space, bank or None): set}."""
    refs = set()
    rx = re.compile(r"\$([cd][0-9a-f]{3}|ff[89a-f][0-9a-f])\b")
    for f in glob.glob(str(ROOT / "src" / "bank_*.asm")):
        for line in open(f):
            if not line.startswith("\t") or line.startswith(("\tdb", "\tdw", "\t;")):
                continue
            for m in rx.finditer(line.split(" ; ")[0]):
                refs.add(int(m.group(1), 16))
    return refs


def free_ranges():
    """[(space, bank, start, end_exclusive)] of bytes no symbol covers, the
    stack zone excluded."""
    named = named_bytes()
    refs = literal_refs()
    out = []
    spaces = [("w", 0, 0xC000, 0xD000)] + [("w", b, 0xD000, 0xE000) for b in range(1, 8)] \
        + [("h", 0, 0xFF80, 0xFFFF)]
    for space, bank, lo, hi in spaces:
        used = named.get((space, bank), set()) | refs
        run = None
        for a in range(lo, hi + 1):
            if a < hi and a not in used and not (bank == 0 and space == "w" and a >= STACK_ZONE):
                if run is None:
                    run = a
            elif run is not None:
                out.append((space, bank, run, a))
                run = None
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--json")
    args = ap.parse_args()
    ranges = free_ranges()
    if args.json:
        Path(args.json).write_text(json.dumps(ranges))
    total = 0
    for space, bank, a, b in ranges:
        where = "HRAM" if space == "h" else ("WRAM0" if bank == 0 else f"WRAM{bank}")
        print(f"{where:6} ${a:04x}-${b - 1:04x}  {b - a:5d}")
        total += b - a
    print(f"{total} bytes in {len(ranges)} ranges")


if __name__ == "__main__":
    main()
