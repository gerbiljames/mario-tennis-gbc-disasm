#!/usr/bin/env python3
"""Report what still keeps a banked-WRAM reference from rendering as a symbol.

Run after a regen, against the emitted source:

    python3 tools/ram_gaps.py

Every bare `$dxxx` operand falls into one of a few buckets, and each bucket has
a different fix, so the split is what makes the remaining work mechanical:

  mirrored      the address is referenced under two or more WRAM banks that
                hold parallel copies of one structure (a tile plane and its
                attribute plane). No per-bank name is right; declare the
                variant `mirrored` in ram_unions.json.
  rom-scoped    some variant covers the address in the bank the site provably
                selects, but its scope lists other ROM banks. Read before
                acting: it may be the same structure reached from a bank that
                was never enumerated (widen the scope, or drop its ROM half if
                the WRAM bank alone identifies it), or a different subsystem's
                overlay of the same bytes, which needs a variant of its own.
  unclaimed     the bank is provable and nothing names the address yet:
                ordinary naming work, with the bank already settled.
  unproven      no trace covers the site and the dataflow cannot pin the bank,
                so there is nothing to name it from.
"""
import collections
import glob
import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from disasmlib.ram import load_traced_wram_banks, ram_field_size

OFF = re.compile(r";\s*\$([0-9a-f]{4})\s*$")
ADDR = re.compile(r"\$([cd][0-9a-f]{3})\b")
BANK = re.compile(r"bank_([0-9a-f]{3})\.asm")
ROUTINE = re.compile(r"^([A-Za-z_][\w.]*):")


def flat(rom_bank, addr):
    return addr if rom_bank == 0 else rom_bank * 0x4000 + (addr - 0x4000)


def load_symbols(path="ram_unions.json"):
    """{wram bank: [(rom bank or None, [(addr, size)])]} from the union file."""
    by_bank = collections.defaultdict(list)
    for u in json.loads(Path(path).read_text())["unions"]:
        for v in u.get("variants", []):
            syms = [(int(k, 0), max(1, ram_field_size(e)))
                    for k, e in v["symbols"].items()]
            for s in v.get("scopes", []):
                if "wram_bank" in s:
                    by_bank[int(s["wram_bank"], 0)].append((s.get("bank"), syms))
    return by_bank


def scan_sites():
    """Every bare $cxxx/$dxxx operand: (addr, flat offset, rom bank, routine)."""
    sites = []
    for f in sorted(glob.glob("src/bank_*.asm")):
        rom_bank = int(BANK.search(f).group(1), 16)
        routine = "?"
        for line in open(f):
            m = ROUTINE.match(line)
            if m and not m.group(1).startswith("."):
                routine = m.group(1)
            if not OFF.search(line.rstrip()):
                continue
            at = flat(rom_bank, int(OFF.search(line.rstrip()).group(1), 16))
            for a in ADDR.finditer(line.split(";")[0]):
                sites.append((int(a.group(1), 16), at, rom_bank, routine))
    return sites


def main():
    traced = load_traced_wram_banks(sorted(glob.glob("coverage/*.json")))
    by_bank = load_symbols()
    sites = scan_sites()

    buckets = collections.Counter()
    romscoped = collections.Counter()
    unclaimed = collections.Counter()
    # an address seen under several banks from one routine is a plane pair
    seen = collections.defaultdict(set)
    for addr, at, rom_bank, routine in sites:
        banks = traced.get(at)
        if banks:
            seen[(addr, rom_bank, routine)] |= banks
        if not banks:
            buckets["unproven"] += 1
            continue
        if len(banks) > 1:
            buckets["mirrored"] += 1
            continue
        b = next(iter(banks))
        covers = [rb for rb, syms in by_bank.get(b, [])
                  if any(s <= addr < s + sz for s, sz in syms)]
        if not covers:
            buckets["unclaimed"] += 1
            unclaimed[(b, addr)] += 1
        elif any(rb is None or int(str(rb), 0) == rom_bank for rb in covers):
            buckets["resolvable now"] += 1
        else:
            buckets["rom-scoped"] += 1
            romscoped[(addr, b, rom_bank)] += 1

    total = sum(buckets.values())
    print(f"{total} bare banked-WRAM operands\n")
    for k, n in buckets.most_common():
        print(f"  {k:<16} {n:5d}   {100 * n / total:4.1f}%")

    cands = {k: v for k, v in seen.items() if len(v) > 1}
    print(f"\nmirrored candidates -- one address, several banks, one routine "
          f"({len(cands)}):")
    for (addr, rom_bank, routine), banks in sorted(cands.items())[:15]:
        print(f"  ${addr:04x}  banks {','.join(str(b) for b in sorted(banks))}"
              f"  from ${rom_bank:02x}:{routine}")

    print(f"\nrom-scoped -- widen or drop the scope's ROM half ({len(romscoped)}):")
    for (addr, b, rom_bank), n in romscoped.most_common(15):
        print(f"  ${addr:04x}  wram bank {b}, referenced from ROM bank "
              f"${rom_bank:02x}  x{n}")

    print(f"\nunclaimed -- bank proved, needs a name ({len(unclaimed)}):")
    for (b, addr), n in unclaimed.most_common(15):
        print(f"  wram bank {b}  ${addr:04x}  x{n}")


if __name__ == "__main__":
    main()
