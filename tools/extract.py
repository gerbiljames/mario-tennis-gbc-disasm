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


def render_spec(data: bytes, spec: str) -> str:
    kind, _, param = spec.partition(":")
    if kind == "palettes":
        return render_palettes(data)
    if kind == "records":
        return render_records(data, int(param or 16))
    if kind == "bytes":
        return render_byte_table(data, int(param or 8))
    if kind == "sound_index":
        return render_sound_index(data)
    if kind == "squares":
        return render_squares(data)
    if kind == "fill":
        return render_fill(data)
    return render_text(data)


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
        parts = line.split()
        path, off_s, len_s = parts[0], parts[1], parts[2]
        spec = parts[3] if len(parts) > 3 else None
        off, length = int(off_s, 16), int(len_s, 16)
        if off + length > len(rom):
            print(f"error: {path} range {off:#x}+{length:#x} exceeds ROM size", file=sys.stderr)
            return 1
        dest = outdir / path
        dest.parent.mkdir(parents=True, exist_ok=True)
        if spec:
            dest.write_text(render_spec(rom[off:off + length], spec))
        elif path.endswith(".asm"):
            dest.write_text(render_text(rom[off:off + length]))
        else:
            dest.write_bytes(rom[off:off + length])
        count += 1
    print(f"extracted {count} files to {outdir}/")
    return 0


if __name__ == "__main__":
    sys.exit(main())
