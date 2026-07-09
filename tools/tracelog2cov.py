#!/usr/bin/env python3
"""Convert a BizHawk native Trace Logger dump into a coverage JSON file.

The native tracer logs raw CPU addresses with no bank information, but it
also logs the opcode bytes. Banked addresses ($4000-$7fff) are resolved by
matching those bytes against every ROM bank at the same in-bank offset,
intersected across runs of consecutive banked instructions (one run cannot
span a bank switch). Ambiguous runs (code mirrored in several banks) fall
back to the lowest matching bank.

Output shape matches the fixed connector: {"rom": [...], "other": [...]}.

usage: tracelog2cov.py <baserom> <trace.log> <out.json>
"""
import json
import re
import sys
from pathlib import Path

BANK_SIZE = 0x4000
LINE_RE = re.compile(r"^([0-9A-F]{4}):\s+([0-9A-F]{2}(?: [0-9A-F]{2}){0,2})\s")


def candidates(rom, nbanks, addr, data, cache):
    key = (addr, data)
    got = cache.get(key)
    if got is None:
        off = addr - BANK_SIZE
        got = frozenset(
            b for b in range(1, nbanks)
            if rom[b * BANK_SIZE + off: b * BANK_SIZE + off + len(data)] == data
        )
        cache[key] = got
    return got


def main():
    if len(sys.argv) != 4:
        print(f"usage: {sys.argv[0]} <baserom> <trace.log> <out.json>", file=sys.stderr)
        return 2
    rom = Path(sys.argv[1]).read_bytes()
    nbanks = len(rom) // BANK_SIZE

    rom_offs = set()
    other = set()
    cache = {}
    run = []          # [(addr, bytes)] of the current banked run
    run_banks = None  # candidate-bank intersection for the run
    stats = {"lines": 0, "unparsed": 0, "bank0_mismatch": 0,
             "runs": 0, "ambiguous_runs": 0, "dead_runs": 0}

    def close_run():
        nonlocal run, run_banks
        if run:
            stats["runs"] += 1
            if run_banks:
                if len(run_banks) > 1:
                    stats["ambiguous_runs"] += 1
                bank = min(run_banks)
                for a, _ in run:
                    rom_offs.add(bank * BANK_SIZE + a - BANK_SIZE)
            else:
                stats["dead_runs"] += 1
        run, run_banks = [], None

    with open(sys.argv[2], errors="replace") as f:
        for line in f:
            m = LINE_RE.match(line)
            if not m:
                stats["unparsed"] += 1
                continue
            stats["lines"] += 1
            addr = int(m.group(1), 16)
            data = bytes.fromhex(m.group(2))
            if addr < BANK_SIZE:
                close_run()
                if rom[addr:addr + len(data)] == data:
                    rom_offs.add(addr)
                else:
                    stats["bank0_mismatch"] += 1
            elif addr < 0x8000:
                cand = candidates(rom, nbanks, addr, data, cache)
                merged = run_banks & cand if run_banks is not None else cand
                if not merged:
                    close_run()
                    merged = cand
                if merged:
                    run.append((addr, data))
                    run_banks = merged
                else:
                    stats["dead_runs"] += 1
            else:
                close_run()
                other.add(addr)
    close_run()

    json.dump({"rom": sorted(rom_offs), "other": sorted(other)}, open(sys.argv[3], "w"))
    print(f"parsed {stats['lines']} instructions "
          f"({stats['unparsed']} non-instruction lines skipped)")
    print(f"runs: {stats['runs']} ({stats['ambiguous_runs']} ambiguous -> lowest bank, "
          f"{stats['dead_runs']} unmatched dropped), bank0 byte mismatches: {stats['bank0_mismatch']}")
    print(f"wrote {sys.argv[3]}: rom={len(rom_offs)} other={len(other)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
