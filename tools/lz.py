#!/usr/bin/env python3
"""Codec for the LZ scheme used by DecompressData ($1797).

Both directions: decompress() reads the game's streams, compress() writes
new ones the game reads back, which is what makes the compressed graphics
editable. Verified by round-tripping all 619 streams in the ROM.

A stream is a sequence of groups: one control byte holding 8 flags consumed
LSB-first, each flag introducing either a literal byte (flag = 1) or a
two-byte back-reference lo, hi (flag = 0). A back-reference copies
(hi & $1f) + 3 bytes from 0x800 - (((hi >> 5) << 8) | lo) bytes behind the
write position; the pair lo = hi = 0 terminates the stream. The window is
2 KiB and copies may overlap their destination (run-length style).

The original encoder always ends a stream with three zero bytes. When the
terminating reference starts a fresh flag group, the decoder consumes all
three ($00 control byte + $0000 reference); mid-group it consumes only the
$0000 reference and the third byte goes unread. decompress() counts that
authored-but-unread pad byte in the returned stream length so extents match
the encoder's output (verified over every stream in the ROM: 142 mid-group
streams all pad with $00, 22 fresh-group streams have no pad).
"""
import sys
from pathlib import Path


def decompress(rom, off, end=None):
    """Decode the stream at flat offset `off` (reading no byte at or past
    `end`); return (data, stream_length). Raises ValueError on malformed
    streams."""
    if end is None:
        end = len(rom)
    out = bytearray()
    pos = off

    def rd():
        nonlocal pos
        if pos >= end:
            raise ValueError("stream runs past end of region")
        b = rom[pos]
        pos += 1
        return b

    while True:
        ctrl = rd()
        for bit in range(8):
            if ctrl >> bit & 1:
                out.append(rd())
            else:
                lo = rd()
                hi = rd()
                if lo == 0 and hi == 0:
                    if bit > 0:
                        if pos >= end or rom[pos] != 0:
                            raise ValueError("missing terminator pad byte")
                        pos += 1
                    return bytes(out), pos - off
                start = len(out) - (0x800 - ((hi >> 5 << 8) | lo))
                if start < 0:
                    raise ValueError("back-reference before stream start")
                for i in range(start, start + (hi & 0x1f) + 3):
                    out.append(out[i])


# A reference encodes `d = 0x800 - distance`, so d = 0 (distance 2048) with the
# minimum length is exactly the $0000 terminator. Capping the distance at 2047
# keeps every emitted reference distinguishable from it.
MIN_MATCH, MAX_MATCH, MAX_DIST = 3, 34, 0x7FF


def compress(data):
    """Encode `data` into a stream decompress() reads back exactly. Greedy
    longest-match LZ77 over the format's 2 KiB window; matches may overlap the
    write position, which is how the original encoder writes runs."""
    out = bytearray()
    tokens = []          # (flag bit, bytes) -- flag 1 = literal
    index = {}           # 3-byte key -> positions, most recent last
    i = 0

    def flush(final=False):
        """Emit one group: the control byte, then its items."""
        ctrl = 0
        for bit, (flag, _b) in enumerate(tokens):
            ctrl |= flag << bit
        out.append(ctrl)
        for _flag, b in tokens:
            out.extend(b)
        if final and len(tokens) > 1:
            # the terminator landed mid-group, so the decoder reads a pad byte
            out.append(0)
        tokens.clear()

    while i < len(data):
        best_len, best_dist = 0, 0
        key = bytes(data[i:i + MIN_MATCH])
        if len(key) == MIN_MATCH:
            for start in reversed(index.get(key, ())):
                dist = i - start
                if dist > MAX_DIST:
                    break
                n = 0
                while (n < MAX_MATCH and i + n < len(data)
                       and data[start + n] == data[i + n]):
                    n += 1
                if n > best_len:
                    best_len, best_dist = n, dist
                    if n == MAX_MATCH:
                        break
        if best_len >= MIN_MATCH:
            d = 0x800 - best_dist
            tokens.append((0, bytes((d & 0xFF,
                                     (d >> 8) << 5 | (best_len - MIN_MATCH)))))
            step = best_len
        else:
            tokens.append((1, bytes((data[i],))))
            step = 1
        for k in range(i, i + step):
            if k + MIN_MATCH <= len(data):
                index.setdefault(bytes(data[k:k + MIN_MATCH]), []).append(k)
        i += step
        if len(tokens) == 8:
            flush()

    tokens.append((0, b"\x00\x00"))
    flush(final=True)
    return bytes(out)


USAGE = """usage:
  lz.py rom flat_offset [outfile]   decode the stream at an offset
  lz.py -c infile outfile           encode a file into a stream

Encoding is what makes compressed graphics editable: decode a stream, edit the
bytes, encode them back over data/<bank>/lz_<addr>.bin and rebuild. The result
does not have to match the original stream byte for byte -- only to decode back
to the same data -- so an edit that compresses differently is fine as long as
the bank still has room for it."""


def main():
    if len(sys.argv) >= 2 and sys.argv[1] in ("-c", "--compress"):
        if len(sys.argv) != 4:
            sys.exit(USAGE)
        data = Path(sys.argv[2]).read_bytes()
        enc = compress(data)
        back, _ = decompress(enc, 0)
        if back != data:
            sys.exit("error: the encoded stream does not decode back")
        Path(sys.argv[3]).write_bytes(enc)
        print(f"{len(data)} bytes -> {len(enc)} bytes compressed "
              f"({len(enc) / len(data):.1%})" if data else "0 bytes")
        return
    if len(sys.argv) not in (3, 4):
        sys.exit(USAGE)
    rom = Path(sys.argv[1]).read_bytes()
    off = int(sys.argv[2], 0)
    data, length = decompress(rom, off)
    print(f"stream at {off:#08x}: {length} bytes compressed, "
          f"{len(data)} decompressed")
    if len(sys.argv) == 4:
        Path(sys.argv[3]).write_bytes(data)


if __name__ == "__main__":
    main()
