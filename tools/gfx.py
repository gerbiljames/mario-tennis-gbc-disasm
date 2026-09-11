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

usage: gfx.py decode <bin> <png>      (lz_* stems are decompressed first)
       gfx.py encode <png> <bin>      (lz_* stems are compressed again)
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import lz  # noqa: E402

TILES_PER_ROW = 16
LEVELS = (255, 170, 85, 0)      # colour index -> gray, index 3 darkest
PALETTE = [v for g in LEVELS for v in (g, g, g)]


def is_lz(path):
    return Path(path).name.startswith("lz_")


def tiles_to_image(data, tiles_per_row=TILES_PER_ROW):
    """2bpp tile bytes -> (Pillow image, tile count)."""
    from PIL import Image
    ntiles = len(data) // 16
    cols = max(1, min(tiles_per_row, ntiles))
    rows = max(1, (ntiles + cols - 1) // cols)
    img = Image.new("P", (cols * 8, rows * 8), 0)
    img.putpalette(PALETTE + [0] * (768 - len(PALETTE)))
    px = img.load()
    for t in range(ntiles):
        tx, ty = (t % cols) * 8, (t // cols) * 8
        for r in range(8):
            lo, hi = data[t * 16 + r * 2], data[t * 16 + r * 2 + 1]
            for x in range(8):
                px[tx + x, ty + r] = ((lo >> (7 - x)) & 1) | (((hi >> (7 - x)) & 1) << 1)
    return img, ntiles


def image_to_tiles(img, ntiles=None):
    """Pillow image -> 2bpp tile bytes, `ntiles` of them (all if None)."""
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
    cols, rows = img.width // 8, img.height // 8
    total = cols * rows
    if ntiles is None or ntiles > total:
        ntiles = total
    out = bytearray()
    for t in range(ntiles):
        tx, ty = (t % cols) * 8, (t // cols) * 8
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


def decode(bin_path, png_path):
    """Write the PNG for a blob file. Returns the tile count, or None when the
    (decompressed) blob is not a whole number of tiles."""
    from PIL.PngImagePlugin import PngInfo
    raw = Path(bin_path).read_bytes()
    data = lz.decompress(raw, 0)[0] if is_lz(bin_path) else raw
    if not data or len(data) % 16:
        return None
    img, ntiles = tiles_to_image(data)
    info = PngInfo()
    info.add_text("tiles", str(ntiles))
    info.add_text("source", Path(bin_path).name)
    img.save(png_path, pnginfo=info)
    return ntiles


def encode(png_path, bin_path):
    """Write the blob file for a PNG, compressing it if the stem is lz_*."""
    from PIL import Image
    img = Image.open(png_path)
    ntiles = int(img.text.get("tiles", 0)) or None
    data = image_to_tiles(img, ntiles)
    if is_lz(bin_path):
        data = lz.compress(data)
    Path(bin_path).write_bytes(data)
    return len(data)


def main(argv):
    if len(argv) != 4 or argv[1] not in ("decode", "encode"):
        print(__doc__, file=sys.stderr)
        return 2
    if argv[1] == "decode":
        n = decode(argv[2], argv[3])
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
