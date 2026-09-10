#!/usr/bin/env python3
"""Render the carved graphics streams to PNG contact sheets for
identification. Reads the manifest for stream locations, decompresses each,
and draws 2bpp tile views (plus BGR555 swatches for the manifest's `palettes`
regions and optional tilemap-over-tilesheet composites for pairing maps with graphics).

Output contains ROM-derived imagery, so it belongs under gitignored data/
(the default) or another uncommitted location. Requires Pillow.

usage: gfxdump.py rom [outdir] [--composites]
"""
import argparse
import sys
from pathlib import Path

from PIL import Image, ImageDraw

sys.path.insert(0, str(Path(__file__).parent))
import lz

BANK_SIZE = 0x4000
GRAYS = [255, 170, 85, 0]


def tiles_image(data, scale=2, tiles_per_row=16):
    ntiles = (len(data) + 15) // 16
    cols = min(tiles_per_row, ntiles)
    rows = (ntiles + cols - 1) // cols
    img = Image.new("L", (cols * 8, rows * 8), 255)
    px = img.load()
    for t in range(ntiles):
        tx, ty = (t % cols) * 8, (t // cols) * 8
        for r in range(8):
            i = t * 16 + r * 2
            lo = data[i] if i < len(data) else 0
            hi = data[i + 1] if i + 1 < len(data) else 0
            for x in range(8):
                c = (lo >> (7 - x) & 1) | ((hi >> (7 - x) & 1) << 1)
                px[tx + x, ty + r] = GRAYS[c]
    return img.resize((img.width * scale, img.height * scale), Image.NEAREST)


def pal_image(data):
    npal = max(1, len(data) // 8)
    img = Image.new("RGB", (4 * 12, npal * 12))
    d = ImageDraw.Draw(img)
    for p in range(npal):
        for c in range(4):
            w = data[(p * 4 + c) * 2] | (data[(p * 4 + c) * 2 + 1] << 8)
            d.rectangle([c * 12, p * 12, c * 12 + 11, p * 12 + 11],
                        fill=((w & 31) << 3, (w >> 5 & 31) << 3,
                              (w >> 10 & 31) << 3))
    return img


def contact_sheet(cells, cols, path):
    pad, label_h = 8, 12
    placed, x, y, row_h = [], 0, 0, 0
    max_w = max(i.width for _n, i in cells) + pad
    for name, img in cells:
        if x + img.width + pad > cols * max_w:
            y += row_h + label_h + pad
            x = row_h = 0
        placed.append((x, y + label_h, name, img))
        x += img.width + pad
        row_h = max(row_h, img.height)
    sheet = Image.new("RGB", (cols * max_w, y + row_h + label_h + pad),
                      (40, 40, 60))
    d = ImageDraw.Draw(sheet)
    for x, y, name, img in placed:
        d.text((x, y - label_h + 1), name, fill=(255, 255, 120))
        sheet.paste(img.convert("RGB"), (x, y))
    sheet.save(path)
    print(f"wrote {path} ({len(cells)} cells)")


def composite(sheet_data, tmap, signed):
    img = Image.new("L", (256, 256), 255)
    tiles = tiles_image(sheet_data, scale=1, tiles_per_row=1)
    px = img.load()
    for my in range(32):
        for mx in range(32):
            t = tmap[my * 32 + mx] ^ (0x80 if signed else 0)
            for r in range(8):
                for x in range(8):
                    sy = t * 8 + r
                    v = tiles.getpixel((x, sy)) if sy < tiles.height else 255
                    px[mx * 8 + x, my * 8 + r] = v
    return img


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("rom")
    ap.add_argument("outdir", nargs="?", default="data/gfx")
    ap.add_argument("--manifest", default="data.manifest")
    ap.add_argument("--composites", action="store_true",
                    help="also render tilemap-over-tilesheet composites")
    args = ap.parse_args()

    rom = Path(args.rom).read_bytes()
    out = Path(args.outdir)
    out.mkdir(parents=True, exist_ok=True)

    streams = []
    pals = []
    for ln in Path(args.manifest).read_text().splitlines():
        fields = ln.split()
        if len(fields) < 3 or fields[0].startswith("#"):
            continue
        off = int(fields[1], 16)
        name = f"{off // BANK_SIZE:02x}:{0x4000 + off % BANK_SIZE:04x}"
        # Palette sets are the manifest's `palettes` regions (raw BGR555
        # words), not any 64-byte stream: a 4-tile icon decompresses to 64
        # bytes too, and a size-only test used to fill the palette sheet with
        # them.
        if len(fields) > 3 and fields[3] == "palettes":
            n = int(fields[2], 16)
            pals.append((f"{name} {n // 8}p", pal_image(rom[off:off + n])))
            continue
        if "/lz_" not in fields[0]:
            continue
        data, _n = lz.decompress(rom, off)
        streams.append((name, off, data))
    streams.sort(key=lambda s: (-len(s[2]), s[0]))

    contact_sheet([(f"{n} {len(d)}B", tiles_image(d)) for n, _o, d in streams],
                  6, out / "streams_tiles.png")
    if pals:
        contact_sheet(pals, 10, out / "streams_palettes.png")

    if args.composites:
        cells = []
        by_bank = {}
        for n, off, d in streams:
            by_bank.setdefault(off // BANK_SIZE, []).append((n, d))
        for bank, items in sorted(by_bank.items()):
            sheets = [(n, d) for n, d in items if len(d) >= 1536]
            maps = [(n, d) for n, d in items if len(d) == 1024]
            for mn, md in maps:
                for sn, sd in sheets:
                    for signed in (False, True):
                        tag = f"m{mn[3:]}+s{sn[3:]} b{bank:02x}{'s' if signed else 'u'}"
                        cells.append((tag, composite(sd, md, signed)))
        if cells:
            contact_sheet(cells, 6, out / "composites.png")


if __name__ == "__main__":
    main()
