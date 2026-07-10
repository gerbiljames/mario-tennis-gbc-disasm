#!/usr/bin/env python3
"""Extract data blobs from the base ROM into data/ per the manifest.

Manifest format: one entry per line, `<relative path> <hex offset> <hex length>`.
Lines starting with # are comments. Entries ending in .asm are rendered as
readable `db` source (game text) instead of raw bytes; like every other file
under data/, they are generated from the user's ROM and never committed.
"""
import sys
from pathlib import Path

# Printable ASCII safe inside an rgbasm string literal: excludes the quote,
# backslash, and the {} symbol-interpolation characters.
SAFE = set(range(0x20, 0x7F)) - {0x22, 0x5C, 0x7B, 0x7D}


def render_text(data: bytes) -> str:
    """Render bytes as `db` lines that reassemble identically: printable
    runs as string literals, everything else as numeric bytes, one line per
    NUL-terminated string."""
    lines, items, buf = [], [], ""

    def flush_buf():
        nonlocal buf
        if buf:
            items.append(f'"{buf}"')
            buf = ""

    def flush_line():
        nonlocal items
        if items:
            lines.append("\tdb " + ", ".join(items))
            items = []

    for b in data:
        if b in SAFE:
            buf += chr(b)
            if len(buf) >= 60:
                flush_buf()
                flush_line()
        else:
            flush_buf()
            items.append(f"${b:02x}")
            if b == 0:
                flush_line()
        if len(items) >= 8:
            flush_line()
    flush_buf()
    flush_line()
    return "\n".join(lines) + "\n"


def main() -> int:
    if len(sys.argv) != 4:
        print(f"usage: {sys.argv[0]} <baserom> <manifest> <outdir>", file=sys.stderr)
        return 2
    rom = Path(sys.argv[1]).read_bytes()
    manifest = Path(sys.argv[2])
    outdir = Path(sys.argv[3])

    count = 0
    for line in manifest.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        path, off_s, len_s = line.split()
        off, length = int(off_s, 16), int(len_s, 16)
        if off + length > len(rom):
            print(f"error: {path} range {off:#x}+{length:#x} exceeds ROM size", file=sys.stderr)
            return 1
        dest = outdir / path
        dest.parent.mkdir(parents=True, exist_ok=True)
        if path.endswith(".asm"):
            dest.write_text(render_text(rom[off:off + length]))
        else:
            dest.write_bytes(rom[off:off + length])
        count += 1
    print(f"extracted {count} files to {outdir}/")
    return 0


if __name__ == "__main__":
    sys.exit(main())
