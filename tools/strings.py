#!/usr/bin/env python3
"""Dump the game's text from the base ROM for local inspection.

Strings are plain NUL-terminated ASCII with $01 as a line break, packed
back-to-back in the text banks. This reads the user's ROM directly (the
repository ships no text), so run it after setup.sh.

usage: strings.py rom [--bank XX] [--min N] [--grep PATTERN]
"""
import argparse
import re
from pathlib import Path

BANK_SIZE = 0x4000


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("rom")
    ap.add_argument("--bank", help="restrict to one bank (hex)")
    ap.add_argument("--min", type=int, default=4,
                    help="minimum string length (default 4)")
    ap.add_argument("--grep", help="only strings matching this regex")
    args = ap.parse_args()

    rom = Path(args.rom).read_bytes()
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
