#!/usr/bin/env python3
"""Dump the game's text from the base ROM for local inspection.

Strings are plain NUL-terminated ASCII with $01 as a line break, packed
back-to-back in the text banks. This reads the user's ROM directly (the
repository ships no text), so run it after setup.sh.

With --index, strings are listed by their game-facing coordinates instead:
bank and string-table index, read from the extracted text source
(`data/bank_XXX/TextStrings_XX.asm`, one `.sN` label per string), so an
edited string shows as edited. A text id in the code, `Text_<bank>_<index>`,
is the same pair.

usage: strings.py rom [--bank XX] [--min N] [--grep PATTERN] [--index]
"""
import argparse
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BANK_SIZE = 0x4000

_SEG_RE = re.compile(r'"((?:[^"\\]|\\.)*)"|([A-Za-z_]\w*)')


def _segment(args):
    """The text of one `text`/`line`/`page` argument list: quoted pieces
    verbatim, a named control code or roster name as `<NAME>`."""
    out = []
    for m in _SEG_RE.finditer(args):
        out.append(m.group(1) if m.group(1) is not None else f"<{m.group(2)}>")
    return "".join(out)


def dump_indexed(want_bank, min_len, pat):
    for path in sorted((ROOT / "data").glob("bank_*/TextStrings_*.asm")):
        bank = int(path.parent.name.split("_")[1], 16)
        if want_bank is not None and bank != want_bank:
            continue
        index, txt = None, ""

        def emit():
            if index is not None and len(txt) >= min_len \
                    and (pat is None or pat.search(txt)):
                print(f"{bank:02x}:{index} {txt}")

        for line in path.read_text().splitlines():
            m = re.match(r"\.s(\d+)$", line)
            if m:
                emit()
                index, txt = int(m.group(1)), ""
                continue
            m = re.match(r"\t(text|line|page) (.*)$", line)
            if m:
                sep = {"text": "", "line": "\\n", "page": "\\p"}[m.group(1)]
                txt += sep + _segment(m.group(2))
        emit()


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

    if args.index:
        dump_indexed(int(args.bank, 16) if args.bank else None,
                     args.min, re.compile(args.grep) if args.grep else None)
        return
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
