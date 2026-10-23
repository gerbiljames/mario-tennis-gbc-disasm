#!/usr/bin/env python3
"""Codec for the LZ scheme used by DecompressData ($1797).

Both directions: decompress() reads the game's streams, compress() is the
original encoder, which is what makes the compressed graphics editable.
Verified by round-tripping every stream in the ROM: each re-encodes from
its decoded data to the same bytes.

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
the encoder's output (verified over every stream in the ROM: every mid-group
stream pads with $00, no fresh-group stream has a pad).
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


# The original encoder is Haruhiko Okumura's lzss.c (1989): a binary search
# tree over a 2 KiB ring, the lookahead starting at N - F. Its ring positions
# before the data are never inserted, so no reference reaches before the
# stream start, and a distance is at most N - 1, never the 2048 that would
# spell the $0000 terminator.
N, F, THRESHOLD = 0x800, 34, 2
NIL = N


def compress(data):
    """Encode `data` exactly as the original encoder did: every stream in the
    ROM re-encodes from its decoded data to the same bytes."""
    text = bytearray(N + F - 1)
    lson = [NIL] * (N + 1)
    rson = [NIL] * (N + 257)    # rson[N + 1 + c]: the tree root for first byte c
    dad = [NIL] * (N + 1)
    match_pos = match_len = 0

    def insert(r):
        """Add the string at r to the tree, leaving the longest match it
        shares with an earlier string in match_pos/match_len; a full-length
        match replaces the older node."""
        nonlocal match_pos, match_len
        cmp, p = 1, N + 1 + text[r]
        lson[r] = rson[r] = NIL
        match_len = 0
        while True:
            child = rson if cmp >= 0 else lson
            if child[p] == NIL:
                child[p], dad[r] = r, p
                return
            p = child[p]
            for i in range(1, F):
                cmp = text[r + i] - text[p + i]
                if cmp:
                    break
            else:
                i = F
            if i > match_len:
                match_pos, match_len = p, i
                if i >= F:
                    break
        dad[r], lson[r], rson[r] = dad[p], lson[p], rson[p]
        dad[lson[p]] = dad[rson[p]] = r
        if rson[dad[p]] == p:
            rson[dad[p]] = r
        else:
            lson[dad[p]] = r
        dad[p] = NIL

    def delete(p):
        if dad[p] == NIL:
            return
        if rson[p] == NIL:
            q = lson[p]
        elif lson[p] == NIL:
            q = rson[p]
        else:
            q = lson[p]
            if rson[q] != NIL:
                while rson[q] != NIL:
                    q = rson[q]
                rson[dad[q]] = lson[q]
                dad[lson[q]] = dad[q]
                lson[q] = lson[p]
                dad[lson[p]] = q
            rson[q] = rson[p]
            dad[rson[p]] = q
        dad[q] = dad[p]
        if rson[dad[p]] == p:
            rson[dad[p]] = q
        else:
            lson[dad[p]] = q
        dad[p] = NIL

    out = bytearray()
    tokens = []          # (flag bit, bytes) -- flag 1 = literal

    def emit(flag, b):
        tokens.append((flag, b))
        if len(tokens) == 8:
            flush()

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

    s, r = 0, N - F
    pos = length = min(F, len(data))
    text[r:r + length] = data[:length]
    if length:
        insert(r)
    while length > 0:
        n = min(match_len, length)
        if n <= THRESHOLD:
            n = 1
            emit(1, bytes((text[r],)))
        else:
            d = 0x800 - ((r - match_pos) & (N - 1))
            emit(0, bytes((d & 0xFF, (d >> 8) << 5 | (n - 3))))
        for _ in range(n):
            delete(s)
            if pos < len(data):
                c = data[pos]
                pos += 1
                text[s] = c
                if s < F - 1:
                    text[s + N] = c
            else:
                length -= 1
            s, r = (s + 1) & (N - 1), (r + 1) & (N - 1)
            if length:
                insert(r)
    emit(0, b"\x00\x00")
    flush(final=True)
    return bytes(out)


USAGE = """usage:
  lz.py rom flat_offset [outfile]   decode the stream at an offset
  lz.py -c infile outfile           encode a file into a stream
  lz.py --size-inc lz_<Label>.bin   print `DEF <Label>_SIZE EQU <decoded bytes>`

Encoding is what makes compressed graphics editable: decode a stream, edit the
bytes, encode them back over its lz_<Label>.bin in data/ and rebuild. Unchanged
data encodes to the original stream byte for byte; an edit only needs the bank
to still have room for the stream it encodes to."""


def main():
    if len(sys.argv) == 3 and sys.argv[1] == "--size-inc":
        # lz_<Label>.bin -> `DEF <Label>_SIZE EQU <decoded bytes>`,
        # the constant the bank source divides by 16 for a whole-stream copy
        path = Path(sys.argv[2])
        if not path.name.startswith("lz_"):
            sys.exit(f"error: {path} is not an lz_ blob")
        data, _ = decompress(path.read_bytes(), 0)
        print(f"DEF {path.stem[3:]}_SIZE EQU {len(data)}")
        return
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
