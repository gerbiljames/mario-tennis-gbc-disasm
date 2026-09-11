#!/usr/bin/env python3
"""PNG <-> 2bpp tile graphics, for editing the game's tiles as images.

`tools/extract.py` decodes every graphics blob the manifest tags `gfx` to a
PNG beside its `.bin` under gitignored `data/`; the Makefile encodes a PNG
back into its `.bin` when the PNG is the newer of the two, compressing it
again if the blob is an LZ stream (an `lz_*` stem). Untouched PNGs never
rebuild anything, so `make compare` still holds until an image is edited.

The image is the tiles in blob order, 16 per row (fewer if the blob is
shorter), as a 4-entry indexed PNG: index 0 is colour 0 (white in the
palette the file carries) and index 3 colour 3 (black). The tile count is
stored in the file (`tiles=N`) so a blob whose last row is partial encodes
back to exactly its original length. An editor that saves the image as
grayscale or RGB is fine: pixels are mapped back by brightness, nearest of
the four levels.

A blob that is a run of sprite frames can carry a layout (`gfx:2x2`,
`gfx:3x4+3` in the manifest, `layout=` in the PNG) so each frame is drawn
assembled. `WxH` is one frame as W columns of H tiles, column-major -- the
order the game's 8x16-object queues consume tiles in -- and `+S` is S
extra tiles per frame drawn as a row beneath it (the character frames'
standing-shadow tiles, which replace the bottom row in VRAM). Frames go
left to right, 128 pixels per row; tiles left over after the last whole
frame follow as a plain row. The layout is a fixed permutation of the
tiles, so encoding is exact and needs no knowledge of the game.

usage: gfx.py decode <bin> <png> [layout]   (lz_* stems are decompressed first)
       gfx.py encode <png> <bin>            (lz_* stems are compressed again)
"""
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import lz  # noqa: E402

TILES_PER_ROW = 16
LEVELS = (255, 170, 85, 0)      # colour index -> gray, index 3 darkest
PALETTE = [v for g in LEVELS for v in (g, g, g)]


def is_lz(path):
    return Path(path).name.startswith("lz_")


def parse_layout(layout):
    """'WxH' or 'WxH+S' -> (W, H, S); None -> None."""
    if not layout:
        return None
    m = re.fullmatch(r"(\d+)x(\d+)(?:\+(\d+))?", layout)
    if not m:
        raise ValueError(f"bad gfx layout {layout!r}")
    w, h, s = int(m.group(1)), int(m.group(2)), int(m.group(3) or 0)
    if not (w and h):
        raise ValueError(f"bad gfx layout {layout!r}")
    return w, h, s


def tile_positions(ntiles, layout=None, tiles_per_row=TILES_PER_ROW):
    """Pixel origin of every tile, in blob order, plus the image size.
    Plain: tiles_per_row per row. With a layout: whole frames first (the
    frame's W*H body tiles column-major, then its S extra tiles as a row
    under the body), then the leftover tiles as plain rows."""
    pos = []
    lay = parse_layout(layout)
    if lay is None:
        cols = max(1, min(tiles_per_row, ntiles))
        for t in range(ntiles):
            pos.append(((t % cols) * 8, (t // cols) * 8))
        rows = max(1, (ntiles + cols - 1) // cols)
        return pos, (cols * 8, rows * 8)
    w, h, s = lay
    per = w * h + s
    nframes = ntiles // per
    fpr = max(1, tiles_per_row // w)                 # frames per row
    extra_rows = (s + w - 1) // w                    # rows the +S tiles take
    fh = (h + extra_rows) * 8
    width = 8
    for f in range(nframes):
        fx, fy = (f % fpr) * w * 8, (f // fpr) * fh
        for t in range(w * h):
            pos.append((fx + (t // h) * 8, fy + (t % h) * 8))
        for t in range(s):
            pos.append((fx + (t % w) * 8, fy + h * 8 + (t // w) * 8))
        width = max(width, fx + w * 8)
    y = ((nframes + fpr - 1) // fpr) * fh
    rest = ntiles - nframes * per
    if rest:
        cols = max(1, min(tiles_per_row, rest)) if not nframes else max(1, width // 8)
        for t in range(rest):
            pos.append(((t % cols) * 8, y + (t // cols) * 8))
        width = max(width, cols * 8)
        y += ((rest + cols - 1) // cols) * 8
    return pos, (width, max(8, y))


def tiles_to_image(data, tiles_per_row=TILES_PER_ROW, layout=None):
    """2bpp tile bytes -> (Pillow image, tile count)."""
    from PIL import Image
    ntiles = len(data) // 16
    pos, size = tile_positions(ntiles, layout, tiles_per_row)
    img = Image.new("P", size, 0)
    img.putpalette(PALETTE + [0] * (768 - len(PALETTE)))
    px = img.load()
    for t, (tx, ty) in enumerate(pos):
        for r in range(8):
            lo, hi = data[t * 16 + r * 2], data[t * 16 + r * 2 + 1]
            for x in range(8):
                px[tx + x, ty + r] = ((lo >> (7 - x)) & 1) | (((hi >> (7 - x)) & 1) << 1)
    return img, ntiles


def image_to_tiles(img, ntiles=None, layout=None, tiles_per_row=TILES_PER_ROW):
    """Pillow image -> 2bpp tile bytes, `ntiles` of them (all if None, plain
    layout only)."""
    if img.mode == "P":
        pal = img.getpalette()[:12]
        # map each palette entry to a colour index by brightness so an editor
        # that reordered the palette still encodes correctly
        idx_of = {i: _level(sum(pal[i * 3:i * 3 + 3]) // 3) for i in range(4)}
        px = img.load()
        get = lambda x, y: idx_of.get(px[x, y], _level(0))  # noqa: E731
    else:
        gray = img.convert("L").load()
        get = lambda x, y: _level(gray[x, y])  # noqa: E731
    if ntiles is None:
        if layout:
            raise ValueError("a laid-out image needs its tile count")
        ntiles = (img.width // 8) * (img.height // 8)
    pos, size = tile_positions(ntiles, layout, tiles_per_row)
    if size[0] > img.width or size[1] > img.height:
        raise ValueError(f"image {img.width}x{img.height} too small for "
                         f"{ntiles} tiles (needs {size[0]}x{size[1]})")
    out = bytearray()
    for tx, ty in pos:
        for r in range(8):
            lo = hi = 0
            for x in range(8):
                c = get(tx + x, ty + r)
                lo |= (c & 1) << (7 - x)
                hi |= ((c >> 1) & 1) << (7 - x)
            out += bytes((lo, hi))
    return bytes(out)


def _level(gray):
    """Nearest of the four gray levels, as a colour index."""
    return min(range(4), key=lambda i: abs(LEVELS[i] - gray))


def decode(bin_path, png_path, layout=None):
    """Write the PNG for a blob file. Returns the tile count, or None when the
    (decompressed) blob is not a whole number of tiles."""
    from PIL.PngImagePlugin import PngInfo
    raw = Path(bin_path).read_bytes()
    data = lz.decompress(raw, 0)[0] if is_lz(bin_path) else raw
    if not data or len(data) % 16:
        return None
    img, ntiles = tiles_to_image(data, layout=layout)
    info = PngInfo()
    info.add_text("tiles", str(ntiles))
    if layout:
        info.add_text("layout", layout)
    info.add_text("source", Path(bin_path).name)
    img.save(png_path, pnginfo=info)
    return ntiles


def image_file_to_tiles(png_path):
    """The tile bytes an extracted PNG encodes to, using the tile count and
    layout stored in the file."""
    from PIL import Image
    img = Image.open(png_path)
    ntiles = int(img.text.get("tiles", 0)) or None
    return image_to_tiles(img, ntiles, img.text.get("layout") or None)


def encode(png_path, bin_path):
    """Write the blob file for a PNG, compressing it if the stem is lz_*."""
    data = image_file_to_tiles(png_path)
    if is_lz(bin_path):
        data = lz.compress(data)
    Path(bin_path).write_bytes(data)
    return len(data)


def main(argv):
    if (len(argv) not in (4, 5) or argv[1] not in ("decode", "encode")
            or (len(argv) == 5 and argv[1] != "decode")):
        print(__doc__, file=sys.stderr)
        return 2
    if argv[1] == "decode":
        n = decode(argv[2], argv[3], argv[4] if len(argv) == 5 else None)
        if n is None:
            print(f"{argv[2]}: not a whole number of tiles", file=sys.stderr)
            return 1
        print(f"{argv[3]}: {n} tiles")
    else:
        n = encode(argv[2], argv[3])
        print(f"{argv[3]}: {n} bytes")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
