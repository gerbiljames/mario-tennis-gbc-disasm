#!/usr/bin/env python3
"""Dump the game's text from the base ROM for local inspection.

Strings are plain NUL-terminated ASCII with $01 as a line break, packed
back-to-back in the text banks. This reads the user's ROM directly (the
repository ships no text), so run it after setup.sh.

With --index, strings are listed by their game-facing coordinates instead:
bank and string-table index (matching the `.sN` labels in the generated
text source), derived by solving each text bank's offset table.

usage: strings.py rom [--bank XX] [--min N] [--grep PATTERN] [--index]
"""
import argparse
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from extract import solve_table

BANK_SIZE = 0x4000


def dump_indexed(rom, want_bank, min_len, pat):
    """List strings by bank:index. The index comes from the bank's offset
    table, which data_tables.json declares as a `text_offsets` region sitting
    immediately before its `text_pool`; older banks keep the table inside the
    text region, where solve_table finds it."""
    import json
    dt = {int(k, 16): v for k, v in json.load(
        open(Path(__file__).resolve().parent.parent / "data_tables.json")).items()}
    pairs = {}   # pool offset -> (table offset, entry count)
    for off in sorted(dt):
        if dt[off] != "text_offsets":
            continue
        pool = min((o for o in dt if o > off and dt[o] == "text_pool"),
                   default=None)
        if pool:
            pairs[pool] = (off, (pool - off) // 2)

    for ln in Path("data.manifest").read_text().splitlines():
        parts = ln.split()
        if "/text_" not in ln or not parts[0].endswith(".asm"):
            continue
        off, length = int(parts[1], 16), int(parts[2], 16)
        bank = off // BANK_SIZE
        if want_bank is not None and bank != want_bank:
            continue
        data = rom[off:off + length]
        if off in pairs:
            toff, n = pairs[off]
            entries = [rom[toff + 2 * i] | (rom[toff + 2 * i + 1] << 8)
                       for i in range(n)]
            t = 0
        else:
            entries = solve_table(data)
            if entries is None:
                continue
            t = 2 * len(entries)
        for k, e in enumerate(entries):
            end = data.find(b"\x03", t + e)
            end2 = data.find(b"\x00", t + e)
            if end < 0 or (0 <= end2 < end):
                end = end2
            s = data[t + e:end if end >= 0 else None]
            txt = s.decode("ascii", "replace") \
                   .replace("\x01", "\\n").replace("\x02", "\\p")
            if len(txt) >= min_len and (pat is None or pat.search(txt)):
                print(f"{bank:02x}:{k} {txt}")


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("rom")
    ap.add_argument("--bank", help="restrict to one bank (hex)")
    ap.add_argument("--min", type=int, default=4,
                    help="minimum string length (default 4)")
    ap.add_argument("--grep", help="only strings matching this regex")
    ap.add_argument("--index", action="store_true",
                    help="list by bank:string-index via the text tables")
    args = ap.parse_args()

    rom = Path(args.rom).read_bytes()
    if args.index:
        dump_indexed(rom, int(args.bank, 16) if args.bank else None,
                     args.min, re.compile(args.grep) if args.grep else None)
        return
    lo, hi = 0, len(rom)
    if args.bank is not None:
        b = int(args.bank, 16)
        lo, hi = b * BANK_SIZE, (b + 1) * BANK_SIZE
    pat = re.compile(args.grep) if args.grep else None

    i = lo
    while i < hi:
        if not (0x20 <= rom[i] < 0x7F):
            i += 1
            continue
        j = i
        while j < hi and (0x20 <= rom[j] < 0x7F or rom[j] == 1):
            j += 1
        s = rom[i:j].decode("ascii", "replace").replace("\x01", "\\n")
        # a real string ends at a NUL; reject runs cut off by binary data
        if j < hi and rom[j] == 0 and len(s) >= args.min \
                and (pat is None or pat.search(s)):
            bank, cpu = i // BANK_SIZE, 0x4000 + i % BANK_SIZE if i >= BANK_SIZE else i
            print(f"{bank:02x}:{cpu:04x} {s}")
        i = j + 1


if __name__ == "__main__":
    main()
