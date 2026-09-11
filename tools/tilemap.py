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
       tilemap.py previews data.previews data/ (compose <tilemap>.preview.png per scene)

The preview is view only: `data.previews` (written beside the manifest from
SceneGfxSlotTable) names each scene's tile plane, attribute plane, tile set
and palette block, and the composer draws the plane as the CGB would, so a
grid edit can be checked by eye with `make previews`.
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


def _palettes(path):
    """The BGR555 words of a generated palettes .asm (or a raw 64-byte block)
    as [(r, g, b)] per colour, 4 per palette."""
    p = Path(path)
    if p.suffix == ".asm":
        words = [int(w, 16) for w in re.findall(r"\$([0-9a-f]{4})", p.read_text())]
    else:
        raw = p.read_bytes()
        words = [raw[i] | (raw[i + 1] << 8) for i in range(0, len(raw) - 1, 2)]
    return [tuple(((w >> sh) & 0x1F) * 255 // 31 for sh in (0, 5, 10)) for w in words]


def preview(tilemap_path, attr_path, tiles_path, pal_path, out_png, width):
    """Compose a scene as the CGB shows it: each cell's tile from the scene's
    tile set (VRAM bank 1, ids below $80; the $80+ range is the text engine's
    glyph buffer and cells that select VRAM bank 0 are the shared UI tiles,
    both drawn as a light grey), coloured by the attribute byte's palette
    (BG 2-7 come from bytes 16-63 of the scene's 64-byte block; 0 and 1 are
    the text window's and drawn as a grey ramp), flipped per bits 5 and 6.
    View only: a pixel does not map back to a tile id."""
    from PIL import Image

    def plane(path):
        raw = Path(path).read_bytes()
        return lz.decompress(raw, 0)[0] if is_lz(path) else raw

    tm, am, tiles = plane(tilemap_path), plane(attr_path), plane(tiles_path)
    pal = _palettes(pal_path)
    grey = [(224, 224, 224), (160, 160, 160), (96, 96, 96), (32, 32, 32)]
    height = len(tm) // width
    img = Image.new("RGB", (width * 8, height * 8), grey[0])
    px = img.load()
    ntiles = len(tiles) // 16
    for cell in range(height * width):
        tile, attr = tm[cell], am[cell] if cell < len(am) else 0
        cx, cy = (cell % width) * 8, (cell // width) * 8
        p = attr & 7
        colours = pal[16 // 2 + (p - 2) * 4:16 // 2 + (p - 2) * 4 + 4] if 2 <= p <= 7 and len(pal) >= 32 else grey
        if not (attr & 0x08) or tile >= 0x80 or tile >= ntiles:
            for y in range(8):
                for x in range(8):
                    px[cx + x, cy + y] = grey[0] if (x // 4 + y // 4) % 2 == 0 else grey[1]
            continue
        t = tiles[tile * 16:tile * 16 + 16]
        for y in range(8):
            lo, hi = t[y * 2], t[y * 2 + 1]
            for x in range(8):
                c = ((lo >> (7 - x)) & 1) | (((hi >> (7 - x)) & 1) << 1)
                dx = 7 - x if attr & 0x20 else x
                dy = 7 - y if attr & 0x40 else y
                px[cx + dx, cy + dy] = colours[c]
    img.save(out_png)
    return width, height


def previews(list_path, data_dir):
    """Compose every scene listed in data.previews into <tilemap>.preview.png."""
    n = 0
    for line in Path(list_path).read_text().splitlines():
        if not line.strip() or line.startswith("#"):
            continue
        tmp, atp, tip, plp = (Path(data_dir) / p for p in line.split())
        if not all(p.exists() for p in (tmp, atp, tip, plp)):
            continue
        width = 64 if (len(lz.decompress(tmp.read_bytes(), 0)[0]) if is_lz(tmp) else tmp.stat().st_size) >= 4096 else 32
        preview(tmp, atp, tip, plp, tmp.with_suffix(".preview.png"), width)
        n += 1
    return n


def main(argv):
    if len(argv) == 4 and argv[1] == "previews":
        print(f"{previews(argv[2], argv[3])} scene previews")
        return 0
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
