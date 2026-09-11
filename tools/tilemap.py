#!/usr/bin/env python3
"""Text grid <-> tilemap / attribute-map blob, for editing screen layouts.

`tools/extract.py` writes every blob the manifest tags `tilemap:W` a second
time as a `.tilemap` text file beside its `.bin`: one `tilemap_row` line per
row of W cells, hex per cell, bracketed by `tilemap_begin W, H` and
`tilemap_end` -- the same lines the `tilemap` spec renders inline for raw
regions, so the file assembles with include/macros.inc too. The Makefile
encodes an edited `.tilemap` back into its `.bin` (compressing again if the
blob is an `lz_*` stream) and `make check` round-trips every grid.

A tile plane holds tile ids; an attribute plane the CGB attribute bytes
(palette bits 0-2, VRAM bank bit 3, X flip bit 5, Y flip bit 6, priority
bit 7) for the same cells. Editing either is byte-exact: the grid is the
blob in rows.

usage: tilemap.py decode <bin> <txt> <width>   (lz_* stems are decompressed first)
       tilemap.py encode <txt> <bin>           (lz_* stems are compressed again)
"""
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import lz  # noqa: E402

_ROW_RE = re.compile(r"^\s*tilemap_row\s+(.*?)\s*(?:;.*)?$")
_BEGIN_RE = re.compile(r"^\s*tilemap_begin\s+(\d+)\s*,\s*(\d+)")


def is_lz(path):
    return Path(path).name.startswith("lz_")


def grid_text(data, width, name=""):
    """The text form of a blob: tilemap_begin / rows / tilemap_end, then any
    trailing partial row as `db`."""
    height = len(data) // width
    out = [f"; {name + ': ' if name else ''}{width} x {height} cells, one tilemap_row per row;"
           " edit and run make (tools/tilemap.py)",
           f"\ttilemap_begin {width}, {height}"]
    for r in range(height):
        row = data[r * width:(r + 1) * width]
        out.append("\ttilemap_row " + ", ".join(f"${b:02x}" for b in row) + f" ; row {r}")
    out.append("\ttilemap_end")
    for b in data[height * width:]:
        out.append(f"\tdb ${b:02x}")
    return "\n".join(out) + "\n"


def _byte(tok):
    tok = tok.strip()
    if tok.startswith("$"):
        return int(tok[1:], 16)
    if tok.startswith("0x"):
        return int(tok, 16)
    if tok.startswith("%"):
        return int(tok[1:], 2)
    return int(tok)


def grid_bytes(text):
    """The blob a grid text encodes: every tilemap_row's cells in order, then
    the trailing `db` bytes. Row widths are checked against tilemap_begin."""
    width = height = None
    rows = []
    tail = bytearray()
    for line in text.splitlines():
        m = _BEGIN_RE.match(line)
        if m:
            width, height = int(m.group(1)), int(m.group(2))
            continue
        m = _ROW_RE.match(line)
        if m:
            cells = [_byte(t) for t in m.group(1).split(",") if t.strip()]
            if width is not None and len(cells) != width:
                raise ValueError(f"row {len(rows)} has {len(cells)} cells, width is {width}")
            rows.append(bytes(cells))
            continue
        m = re.match(r"^\s*db\s+(.*?)\s*(?:;.*)?$", line)
        if m:
            tail += bytes(_byte(t) for t in m.group(1).split(",") if t.strip())
    if height is not None and len(rows) != height:
        raise ValueError(f"{len(rows)} rows, height is {height}")
    if not rows and not tail:
        raise ValueError("no tilemap_row lines")
    return b"".join(rows) + bytes(tail)


def decode(bin_path, txt_path, width):
    raw = Path(bin_path).read_bytes()
    data = lz.decompress(raw, 0)[0] if is_lz(bin_path) else raw
    Path(txt_path).write_text(grid_text(data, width, Path(bin_path).stem))
    return len(data) // width


def encode(txt_path, bin_path):
    data = grid_bytes(Path(txt_path).read_text())
    if is_lz(bin_path):
        data = lz.compress(data)
    Path(bin_path).write_bytes(data)
    return len(data)


def main(argv):
    if len(argv) == 5 and argv[1] == "decode":
        print(f"{argv[3]}: {decode(argv[2], argv[3], int(argv[4]))} rows")
    elif len(argv) == 4 and argv[1] == "encode":
        print(f"{argv[3]}: {encode(argv[2], argv[3])} bytes")
    else:
        print(__doc__, file=sys.stderr)
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
