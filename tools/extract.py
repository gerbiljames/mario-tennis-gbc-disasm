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


def solve_table(data: bytes):
    """Detect the text-bank header: dw fetch-routine address, then N
    ascending string offsets relative to the table's own end. N is solved by
    requiring every offset to land just past a string terminator; accepted
    only when exactly one N satisfies all entries (true of every text bank)."""
    if len(data) < 24:
        return None
    entries, i, prev = [], 2, -1
    while i + 1 < len(data):
        w = data[i] | (data[i + 1] << 8)
        if w < prev:
            break
        entries.append(w)
        prev = w
        i += 2
    good = []
    for n in range(8, len(entries) + 1):
        t = 2 + 2 * n
        if all(t + e < len(data)
               and (e == 0 or data[t + e - 1] in (0x00, 0x03))
               for e in entries[:n]):
            good.append(n)
    if len(good) != 1:
        return None
    return entries[:good[0]]


def render_text(data: bytes) -> str:
    """Render a text region so it reassembles identically: the offset table
    (when present) as commented `dw` lines, strings as literals with their
    table index, control bytes numeric."""
    entries = solve_table(data)
    if entries is None:
        return render_db(data)
    t = 2 + 2 * len(entries)
    w0 = data[0] | (data[1] << 8)
    out = [f"\tdw ${w0:04x} ; bank-local string-fetch routine",
           f"; {len(entries)} string offsets, relative to the end of this table"]
    idx = {}
    for k, e in enumerate(entries):
        idx.setdefault(e, k)
        out.append(f"\tdw ${e:04x} ; {k}")
    pos = t
    while pos < len(data):
        start = pos
        while pos < len(data) and data[pos] not in (0x00, 0x03):
            pos += 1
        if pos < len(data):
            pos += 1
        body = render_db(data[start:pos]).rstrip("\n").split("\n")
        k = idx.get(start - t)
        if k is not None:
            body[0] += f" ; [{k}]"
        out.extend(body)
    return "\n".join(out) + "\n"


def render_db(data: bytes) -> str:
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
            if b in (0x00, 0x03):
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
