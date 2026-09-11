#!/usr/bin/env python3
"""Extract data blobs from the base ROM into data/ per the manifest.

Manifest format: one entry per line, `<relative path> <hex offset> <hex length>`.
Lines starting with # are comments. Entries ending in .asm are rendered as
readable `db` source (game text) instead of raw bytes; like every other file
under data/, they are generated from the user's ROM and never committed.
"""
import math
import sys
from pathlib import Path

# Printable ASCII safe inside an rgbasm string literal: excludes the quote,
# backslash, and the {} symbol-interpolation characters.
SAFE = set(range(0x20, 0x7F)) - {0x22, 0x5C, 0x7B, 0x7D}


def solve_table(data: bytes):
    """Detect a string index table: N ascending offsets relative to the
    table's own end. N is solved by requiring every offset to land just
    past a string terminator; accepted only when exactly one N satisfies
    all entries (true of every text bank)."""
    if len(data) < 24:
        return None
    entries, i, prev = [], 0, -1
    while i + 1 < len(data):
        w = data[i] | (data[i + 1] << 8)
        if w < prev:
            break
        entries.append(w)
        prev = w
        i += 2
    good = []
    for n in range(8, len(entries) + 1):
        t = 2 * n
        if all(t + e < len(data)
               and (e == 0 or data[t + e - 1] in (0x00, 0x03))
               for e in entries[:n]):
            good.append(n)
    if len(good) != 1:
        return None
    return entries[:good[0]]


def render_string(chunk: bytes) -> list:
    """Render one string as text/line/page macro lines (see macros.inc).
    Segments are split on the $01/$02 control bytes; unexpected bytes stay
    numeric args, so any input reassembles identically."""
    out = []
    mac = "text"
    items, buf = [], ""

    def flush_buf():
        nonlocal buf
        if buf:
            items.append(f'"{buf}"')
            buf = ""

    def flush(next_mac="text"):
        nonlocal items, mac
        if items:
            out.append(f"\t{mac} " + ", ".join(items))
        elif mac == "line":
            out.append("\tdb $01")
        elif mac == "page":
            out.append("\tdb $02")
        items, mac = [], next_mac

    for b in chunk:
        if b in SAFE:
            buf += chr(b)
            if len(buf) >= 58:
                flush_buf()
                flush()
        elif b == 0x01:
            flush_buf()
            flush("line")
        elif b == 0x02:
            flush_buf()
            flush("page")
        elif b == 0x03:
            flush_buf()
            flush()
            out.append("\tdone")
        else:
            flush_buf()
            items.append(f"${b:02x}")
    flush_buf()
    flush()
    return out


def render_text(data: bytes) -> str:
    """Render a text region so it reassembles identically: the offset table
    (when present) as label arithmetic, strings via the text macros with
    their table index. Editing a string keeps the table consistent."""
    entries = solve_table(data)
    if entries is None:
        return render_db(data)
    t = 2 * len(entries)
    idx = {}
    for k, e in enumerate(entries):
        idx.setdefault(e, k)
    out = [f"; {len(entries)} string offsets, relative to .strings"]
    for k, e in enumerate(entries):
        out.append(f"\tdw .s{idx[e]} - .strings ; {k}")
    out.append(".strings")
    pos = t
    while pos < len(data):
        start = pos
        while pos < len(data) and data[pos] not in (0x00, 0x03):
            pos += 1
        if pos < len(data):
            pos += 1
        k = idx.get(start - t)
        if k is not None:
            out.append(f".s{k}")
        if data[pos - 1] == 0x00:
            chunk, tail = data[start:pos - 1], ["\tdb $00"]
        else:
            chunk, tail = data[start:pos], []
        out.extend(render_string(chunk) if chunk else [])
        out.extend(tail)
    return "\n".join(out) + "\n"


def string_starts(data: bytes):
    """Offsets of each string in a pool, in order. Strings run to a $00 or $03
    terminator, the same split render_text uses."""
    out, pos = [], 0
    while pos < len(data):
        out.append(pos)
        while pos < len(data) and data[pos] not in (0x00, 0x03):
            pos += 1
        if pos < len(data):
            pos += 1
    return out


def render_text_pool(data: bytes) -> str:
    """A string pool with an `.sN` anchor on every string, so a *separate*
    offset table can name them (`dw Pool.s3 - Pool`) instead of storing the
    offsets as ROM values. Same rendering as render_text's string half; only
    the anchors are new."""
    out = []
    starts = string_starts(data)
    for n, start in enumerate(starts):
        end = starts[n + 1] if n + 1 < len(starts) else len(data)
        out.append(f".s{n}")
        if end and data[end - 1] == 0x00:
            chunk, tail = data[start:end - 1], ["\tdb $00"]
        else:
            chunk, tail = data[start:end], []
        out.extend(render_string(chunk) if chunk else [])
        out.extend(tail)
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


def render_palettes(data: bytes) -> str:
    """Render GBC palette data as `dw` colors, four per palette, with the
    decoded RGB in a comment. Reassembles identically (raw little-endian
    words)."""
    out = ["; GBC palettes (BGR555), 4 colors each"]
    for pi in range(len(data) // 8):
        words = [data[pi * 8 + c * 2] | (data[pi * 8 + c * 2 + 1] << 8)
                 for c in range(4)]
        rgb = []
        for w in words:
            r, g, b = w & 0x1F, (w >> 5) & 0x1F, (w >> 10) & 0x1F
            rgb.append(f"#{r * 255 // 31:02x}{g * 255 // 31:02x}{b * 255 // 31:02x}")
        cols = ", ".join(f"${w:04x}" for w in words)
        out.append(f"\tdw {cols} ; pal {pi}: " + " ".join(rgb))
    tail = len(data) % 8
    if tail:
        out.append("\tdb " + ", ".join(f"${b:02x}" for b in data[-tail:]))
    return "\n".join(out) + "\n"


def render_records(data: bytes, stride: int) -> str:
    """Render a fixed-stride record table, one record per line. Even strides
    render as `dw` (the loader walks word fields), odd as `db`."""
    out = [f"; {len(data) // stride} records x {stride} bytes"]
    for i in range(0, len(data) - stride + 1, stride):
        rec = data[i:i + stride]
        if stride % 2 == 0:
            vals = ", ".join(f"${rec[k] | (rec[k + 1] << 8):04x}"
                             for k in range(0, stride, 2))
            out.append(f"\tdw {vals} ; record {i // stride}")
        else:
            vals = ", ".join(f"${b:02x}" for b in rec)
            out.append(f"\tdb {vals} ; record {i // stride}")
    rem = len(data) % stride
    if rem:
        out.append("\tdb " + ", ".join(f"${b:02x}" for b in data[-rem:]))
    return "\n".join(out) + "\n"


def render_byte_table(data: bytes, cols: int) -> str:
    """Render a byte table as `db` rows of `cols`, index-commented."""
    out = []
    for i in range(0, len(data), cols):
        row = ", ".join(f"${b:02x}" for b in data[i:i + cols])
        out.append(f"\tdb {row} ; {i:#04x}")
    return "\n".join(out) + "\n"


def render_pattern(data: bytes) -> str:
    """Render a block that is one short byte pattern repeated as a single `ds`
    -- rgbasm repeats the value list to fill the count. Used for uniform tile
    runs (e.g. a solid-color tile stamped across a VRAM block)."""
    for n in range(1, 17):
        if len(data) % n == 0 and data == data[:n] * (len(data) // n):
            vals = ", ".join(f"${b:02x}" for b in data[:n])
            return f"\tds {len(data)}, {vals}\n"
    return render_byte_table(data, 16)


def render_ascii(data: bytes) -> str:
    """Render a raw ASCII run as one `db`, quoting printable stretches."""
    parts, run = [], []
    for b in data:
        if b in SAFE:
            run.append(chr(b))
            continue
        if run:
            parts.append('"' + "".join(run) + '"')
            run = []
        parts.append(f"${b:02x}")
    if run:
        parts.append('"' + "".join(run) + '"')
    return "\tdb " + ", ".join(parts) + "\n"


CART_TYPES = {
    0x00: "ROM only", 0x01: "MBC1", 0x02: "MBC1+RAM",
    0x03: "MBC1+RAM+BATTERY", 0x05: "MBC2", 0x06: "MBC2+BATTERY",
    0x0F: "MBC3+TIMER+BATTERY", 0x10: "MBC3+TIMER+RAM+BATTERY",
    0x11: "MBC3", 0x12: "MBC3+RAM", 0x13: "MBC3+RAM+BATTERY",
    0x19: "MBC5", 0x1A: "MBC5+RAM", 0x1B: "MBC5+RAM+BATTERY",
    0x1C: "MBC5+RUMBLE", 0x1D: "MBC5+RUMBLE+RAM",
    0x1E: "MBC5+RUMBLE+RAM+BATTERY",
}
CART_RAM = {0x00: "none", 0x01: "2 KiB", 0x02: "8 KiB",
            0x03: "32 KiB, 4 banks", 0x04: "128 KiB, 16 banks",
            0x05: "64 KiB, 8 banks"}
CGB_FLAGS = {0x80: "CGB enhanced", 0xC0: "CGB only"}


def render_cart_header(data: bytes) -> str:
    """Render the 28 header bytes that follow the Nintendo logo ($0134-$014f):
    title, codes, and the size/checksum fields the mastering tools filled in."""
    if len(data) != 28:
        return render_byte_table(data, 8)
    title = data[:11].rstrip(b"\0")
    pad = 11 - len(title)
    fields = [
        (f'"{title.decode("ascii")}"' + ", $00" * pad, "$0134 title"),
        (f'"{data[11:15].decode("ascii")}"', "$013f manufacturer code"),
        (f"${data[15]:02x}", f"$0143 CGB flag: "
         f"{CGB_FLAGS.get(data[15], 'DMG')}"),
        (f'"{data[16:18].decode("ascii")}"', "$0144 new licensee"),
        (f"${data[18]:02x}", "$0146 SGB flag"),
        (f"${data[19]:02x}", f"$0147 cart type: "
         f"{CART_TYPES.get(data[19], 'unknown')}"),
        (f"${data[20]:02x}", f"$0148 ROM size: {32 << data[20]} KiB, "
         f"{2 << data[20]} banks"),
        (f"${data[21]:02x}", f"$0149 RAM size: "
         f"{CART_RAM.get(data[21], 'unknown')}"),
        (f"${data[22]:02x}", "$014a destination: "
         + ("Japanese" if data[22] == 0 else "non-Japanese")),
        (f"${data[23]:02x}", "$014b old licensee"),
        (f"${data[24]:02x}", "$014c mask ROM version"),
        (f"${data[25]:02x}", "$014d header checksum"),
        (f"${data[26]:02x}, ${data[27]:02x}", "$014e global checksum"),
    ]
    width = max(len(v) for v, _ in fields)
    return "".join(f"\tdb {v:<{width}} ; {c}\n" for v, c in fields)


def render_font_glyph(data: bytes) -> str:
    """Render a `db width, height` + 2bpp bitmap glyph record. The bitmap is
    packed continuously (width*2 bits per row, no byte alignment), so rows are
    grouped into the smallest byte-aligned run and drawn alongside as pixel
    art: `.` transparent, `o`/`+` the mid colors, `#` color 3."""
    if len(data) < 2:
        return render_byte_table(data, 8)
    w, h, body = data[0], data[1], data[2:]
    if not w or not h or w * h * 2 != len(body) * 8:
        return render_byte_table(data, 8)
    bits = "".join(f"{b:08b}" for b in body)
    rows = ["".join(".o+#"[int(bits[(r * w + x) * 2])
                    | (int(bits[(r * w + x) * 2 + 1]) << 1)]
                    for x in range(w)) for r in range(h)]
    per = 4 // math.gcd(w, 4)  # rows per byte-aligned group
    step = per * w * 2 // 8
    out = [f"\tdb ${w:02x}, ${h:02x} ; {w} x {h}, 2bpp"]
    for g in range(0, h, per):
        chunk = body[(g // per) * step:(g // per) * step + step]
        art = " ".join(rows[g:g + per])
        out.append("\tdb " + ", ".join(f"${b:02x}" for b in chunk) + f" ; {art}")
    return "\n".join(out) + "\n"


def render_tilemap(data: bytes, width: int) -> str:
    """Render a rectangular tilemap/attrmap block as one `tilemap_row` per row,
    bracketed by `tilemap_begin width, height` / `tilemap_end` so rgbasm checks
    the geometry. A trailing partial row (width not a divisor) stays literal."""
    height = len(data) // width
    out = [f"\ttilemap_begin {width}, {height}"]
    for r in range(height):
        row = data[r * width:(r + 1) * width]
        out.append("\ttilemap_row " + ", ".join(f"${b:02x}" for b in row)
                   + f" ; row {r}")
    out.append("\ttilemap_end")
    for b in data[height * width:]:
        out.append(f"\tdb ${b:02x}")
    return "\n".join(out) + "\n"


def render_rect_ptrs(data: bytes) -> str:
    """Render {tiles, attrs} pointer records for a fixed-geometry rectangle."""
    out = []
    for i in range(0, len(data) - 3, 4):
        r = data[i:i + 4]
        out.append(f"\trect_ptrs ${r[0] | (r[1] << 8):04x}, "
                   f"${r[2] | (r[3] << 8):04x}")
    for b in data[len(data) // 4 * 4:]:
        out.append(f"\tdb ${b:02x}")
    return "\n".join(out) + "\n"


def render_rect_pair(data: bytes) -> str:
    """Render CopyTextRectPair descriptors: {height, width, tiles, attrs}."""
    out = []
    for i in range(0, len(data) - 5, 6):
        r = data[i:i + 6]
        out.append(f"\trect_pair {r[0]}, {r[1]}, "
                   f"${r[2] | (r[3] << 8):04x}, ${r[4] | (r[5] << 8):04x}")
    for b in data[len(data) // 6 * 6:]:
        out.append(f"\tdb ${b:02x}")
    return "\n".join(out) + "\n"


def render_squares(data: bytes) -> str:
    """Render an n-squared lookup table (i^2 as 16-bit LE) as a compile-time
    FOR loop instead of 256 literal dw rows. The longest i^2 prefix becomes
    the loop; any trailing words (e.g. a sentinel) stay literal. Falls back
    to literal dw if the bytes aren't a squares table (keeps byte-perfect)."""
    words = [data[i] | (data[i + 1] << 8) for i in range(0, len(data) - 1, 2)]
    k = 0
    while k < len(words) and words[k] == (k * k) & 0xFFFF:
        k += 1
    if k < 8:
        return render_records(data, 2)
    out = [f"FOR i, {k}", "\tdw (i * i) & $ffff", "ENDR"]
    out += [f"\tdw ${w:04x}" for w in words[k:]]
    if len(data) % 2:
        out.append(f"\tdb ${data[-1]:02x}")
    return "\n".join(out) + "\n"


def render_sound_index(data: bytes) -> str:
    """Render a PlaySound index table as `sound_entry bank, voices, record`
    macro calls (see include/macros.inc). First byte packs voice count (high
    nibble) and bank low nibble (bank = $70 | nibble); second byte is the
    first channel-record index into that bank's SoundTable_*."""
    out = []
    for i in range(0, len(data) - 1, 2):
        b0, b1 = data[i], data[i + 1]
        out.append(f"\tsound_entry ${0x70 | (b0 & 0x0f):02x}, "
                   f"{b0 >> 4}, {b1} ; sound {i // 2}")
    if len(data) % 2:
        out.append(f"\tdb ${data[-1]:02x}")
    return "\n".join(out) + "\n"


def render_fill(data: bytes) -> str:
    """Render padding as `ds` runs, one per constant-byte stretch."""
    out = []
    i = 0
    while i < len(data):
        j = i
        while j < len(data) and data[j] == data[i]:
            j += 1
        out.append(f"\tds {j - i}, ${data[i]:02x}")
        i = j
    return "\n".join(out) + "\n"


def render_sprite_template(data: bytes) -> str:
    """Render a QueueSpriteTemplate ($1e9d) sprite list: 4-byte {dy, dx, tile,
    attr} records the loader adds to a base position, ended by a $80 dy byte it
    stops on (oam_sprite_end). Reassembles identically."""
    out = []
    i = 0
    while i + 4 <= len(data) and data[i] != 0x80:
        rec = data[i:i + 4]
        out.append("\toam_sprite " + ", ".join(f"${b:02x}" for b in rec))
        i += 4
    if i < len(data) and data[i] == 0x80:
        out.append("\toam_sprite_end")
        i += 1
    while i < len(data):
        out.append(f"\tdb ${data[i]:02x}")
        i += 1
    return "\n".join(out) + "\n"


def render_spec(data: bytes, spec: str) -> str:
    kind, _, param = spec.partition(":")
    if kind == "palettes":
        return render_palettes(data)
    if kind == "sprite_template":
        return render_sprite_template(data)
    if kind == "records":
        return render_records(data, int(param or 16))
    if kind == "bytes":
        return render_byte_table(data, int(param or 8))
    if kind == "ascii":
        return render_ascii(data)
    if kind == "pattern":
        return render_pattern(data)
    if kind == "cart_header":
        return render_cart_header(data)
    if kind == "font_glyph":
        return render_font_glyph(data)
    if kind == "tilemap":
        return render_tilemap(data, int(param or 20))
    if kind == "rect_pair":
        return render_rect_pair(data)
    if kind == "rect_ptrs":
        return render_rect_ptrs(data)
    if kind == "sound_index":
        return render_sound_index(data)
    if kind == "text_pool":
        return render_text_pool(data)
    if kind == "sound_data":
        # Engine/instrument tables of the sound driver. Rendered like bytes:16;
        # the separate spec name is what routes them out of the repository.
        return render_byte_table(data, 16)
    if kind == "words":
        # a maths table: numeric words, never resolved against labels
        return render_records(data, 2 * int(param or 1))
    if kind == "squares":
        return render_squares(data)
    if kind == "fill":
        return render_fill(data)
    return render_text(data)


def _edited(dest, data):
    """True when `dest` exists and no longer holds `data` -- someone changed
    it, so --keep leaves it alone."""
    return dest.exists() and dest.read_bytes() != data


def _gfx_edited(dest, png, data, gfx):
    """A graphics pair counts as edited if the .bin differs from the ROM or
    the PNG no longer encodes to it (an edit not yet built, which rewriting
    the .bin last would silently bury)."""
    if _edited(dest, data):
        return True
    if not png.exists():
        return False
    try:
        return gfx.image_file_to_tiles(png) != (
            gfx.lz.decompress(data, 0)[0] if gfx.is_lz(dest) else data)
    except Exception:
        return True


def main() -> int:
    args = [a for a in sys.argv[1:] if a != "--keep"]
    keep = len(args) != len(sys.argv) - 1
    if len(args) != 3:
        print(f"usage: {sys.argv[0]} [--keep] <baserom> <manifest> <outdir>\n"
              "  --keep: leave a file that has been edited since extraction "
              "as it is, and delete nothing", file=sys.stderr)
        return 2
    rom = Path(args[0]).read_bytes()
    manifest = Path(args[1])
    outdir = Path(args[2])

    count = 0
    written = set()
    kept = []
    pngs = gfx_skipped = 0
    try:
        import gfx
        from PIL import Image  # noqa: F401
        gfx_ok = True
    except ImportError:
        gfx_ok = False
        print("note: Pillow not installed; graphics PNGs not generated",
              file=sys.stderr)
    for line in manifest.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        parts = line.split()
        path, off_s, len_s = parts[0], parts[1], parts[2]
        spec = parts[3] if len(parts) > 3 else None
        off, length = int(off_s, 16), int(len_s, 16)
        if off + length > len(rom):
            print(f"error: {path} range {off:#x}+{length:#x} exceeds ROM size", file=sys.stderr)
            return 1
        dest = outdir / path
        dest.parent.mkdir(parents=True, exist_ok=True)
        data = rom[off:off + length]
        is_gfx = spec == "gfx" or (spec or "").startswith("gfx:")
        if keep:
            png = dest.with_suffix(".png")
            if (_gfx_edited(dest, png, data, gfx) if is_gfx and gfx_ok
                    else _edited(dest, (data if not spec and not path.endswith(".asm")
                                        else (render_spec(data, spec) if spec
                                              else render_text(data)).encode()))):
                kept.append(path)
                written.add(path)
                if is_gfx and png.exists():
                    written.add(str(png.relative_to(outdir)))
                count += 1
                continue
        if is_gfx:
            # the .bin as always, plus the PNG a modder edits; the .bin is
            # written last so it is the newer file and make leaves it alone
            # until the PNG changes
            png = dest.with_suffix(".png")
            dest.write_bytes(data)
            if gfx_ok:
                if gfx.decode(dest, png, spec.partition(":")[2] or None) is None:
                    png.unlink(missing_ok=True)
                    gfx_skipped += 1
                else:
                    written.add(str(png.relative_to(outdir)))
                    pngs += 1
                    dest.write_bytes(rom[off:off + length])
        elif spec:
            dest.write_text(render_spec(rom[off:off + length], spec))
        elif path.endswith(".asm"):
            dest.write_text(render_text(rom[off:off + length]))
        else:
            dest.write_bytes(rom[off:off + length])
        written.add(path)
        count += 1

    # data/bank_*/ is generated in full from the manifest, so a file there the
    # manifest no longer lists is a leftover from an older carve. Leaving them
    # is actively misleading: a stale text_*.asm reads as if a region were
    # decoded as game text when the current source renders it as a table.
    # data/gfx/ is gfxdump.py's contact sheets, not ours to remove.
    # (a .inc is make's, derived from the .bin beside it: stale only with it)
    stale = [f for d in sorted(outdir.glob("bank_*")) if d.is_dir()
             for f in sorted(d.rglob("*"))
             if f.is_file() and str(f.relative_to(outdir)) not in written
             and not (f.suffix == ".inc"
                      and str(f.with_suffix(".bin").relative_to(outdir)) in written)]
    if not keep:
        for f in stale:
            f.unlink()
    note = (f", {'left' if keep else 'removed'} {len(stale)} stale"
            if stale else "")
    if kept:
        note += f", kept {len(kept)} edited"
        for path in kept:
            print(f"  kept {path}")
    if pngs:
        note += f", {pngs} graphics PNGs"
    if gfx_skipped:
        note += f" ({gfx_skipped} gfx blobs not a whole number of tiles)"
    print(f"extracted {count} files to {outdir}/{note}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
