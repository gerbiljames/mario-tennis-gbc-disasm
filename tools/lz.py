#!/usr/bin/env python3
"""Codec for the LZ scheme used by DecompressData ($1797).

A stream is a sequence of groups: one control byte holding 8 flags consumed
LSB-first, each flag introducing either a literal byte (flag = 1) or a
two-byte back-reference lo, hi (flag = 0). A back-reference copies
(hi & $1f) + 3 bytes from 0x800 - (((hi >> 5) << 8) | lo) bytes behind the
write position; the pair lo = hi = 0 terminates the stream. The window is
2 KiB and copies may overlap their destination (run-length style).
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
                    return bytes(out), pos - off
                start = len(out) - (0x800 - ((hi >> 5 << 8) | lo))
                if start < 0:
                    raise ValueError("back-reference before stream start")
                for i in range(start, start + (hi & 0x1f) + 3):
                    out.append(out[i])


def main():
    if len(sys.argv) not in (3, 4):
        sys.exit(f"usage: {sys.argv[0]} rom flat_offset [outfile]")
    rom = Path(sys.argv[1]).read_bytes()
    off = int(sys.argv[2], 0)
    data, length = decompress(rom, off)
    print(f"stream at {off:#08x}: {length} bytes compressed, "
          f"{len(data)} decompressed")
    if len(sys.argv) == 4:
        Path(sys.argv[3]).write_bytes(data)


if __name__ == "__main__":
    main()
