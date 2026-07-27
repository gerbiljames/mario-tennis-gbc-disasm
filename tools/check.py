#!/usr/bin/env python3
"""Structural checks over the carve, for things `make compare` cannot see.

A byte-perfect build only proves the bytes come back; it says nothing about
whether the *structure* the source claims is true. These are the invariants
that matter when the disassembly is used as a modding base, each one written
after a real defect broke it:

  lz        every declared LZ stream decodes exactly within its extent, and
            re-encodes to a stream that decodes back to the same bytes
  lz-labels no symbol lands inside a compressed stream (a curated name once
            truncated two streams by 29 and 160 bytes)
  text      every text_offsets word lands on a string start in its pool, so
            the `dw Pool.sN - Pool` rows name real strings
  regions   manifest regions stay inside their bank and do not overlap

Exit status is non-zero if any check fails.
"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from extract import string_starts
from lz import compress, decompress

ROOT = BANK = None
BANK_SIZE = 0x4000


def load_manifest():
    out = []
    for line in (ROOT / "data.manifest").read_text().splitlines():
        if not line.strip() or line.startswith("#"):
            continue
        f = line.split()
        out.append((f[0], int(f[1], 16), int(f[2], 16),
                    f[3] if len(f) > 3 else None))
    return out


def check_lz(rom, manifest, fail):
    streams = [(p, o, n) for p, o, n, _s in manifest if "/lz_" in p]
    for path, off, length in streams:
        try:
            data, used = decompress(rom, off, off + length)
        except ValueError as e:
            fail("lz", f"{path}: does not decode inside its {length}-byte "
                       f"extent ({e})")
            continue
        if used != length:
            fail("lz", f"{path}: decodes {used} bytes, extent says {length}")
        back, _ = decompress(compress(data), 0)
        if back != data:
            fail("lz", f"{path}: re-encoded stream does not decode back")
    return len(streams)


def check_lz_labels(labels, manifest, fail):
    spans = [(o, o + n, p) for p, o, n, _s in manifest if "/lz_" in p]
    spans.sort()
    for off in sorted(labels):
        for lo, hi, path in spans:
            if lo < off < hi:
                fail("lz-labels", f"{labels[off]} (0x{off:x}) is {off - lo} "
                                  f"bytes inside {path}, which truncates it")
            if lo > off:
                break
    return len(spans)


def check_text(rom, data_tables, manifest, fail):
    pairs = []
    for off in sorted(data_tables):
        if data_tables[off] != "text_offsets":
            continue
        pool = min((o for o in data_tables
                    if o > off and data_tables[o] == "text_pool"), default=None)
        if pool is None:
            fail("text", f"table at 0x{off:x} has no text_pool after it")
            continue
        pairs.append((off, pool))
    # the pool's real length bounds the check; deriving it from the entries
    # would let a bogus entry widen the window until it looked valid
    pool_len = {o: n for p, o, n, spec in manifest if spec == "text_pool"}
    for toff, pool in pairs:
        n = pool_len.get(pool)
        if n is None:
            fail("text", f"pool 0x{pool:x} is not an extracted region")
            continue
        starts = set(string_starts(rom[pool:pool + n]))
        # entry 0 addresses the pool's first string in all 13 banks, so a table
        # whose base has slipped a word still passes the per-entry test but
        # fails this one
        if (rom[toff] | (rom[toff + 1] << 8)) != 0:
            fail("text", f"offset table 0x{toff:x} does not start at its "
                         f"pool's first string")
        for o in range(toff, pool - 1, 2):
            w = rom[o] | (rom[o + 1] << 8)
            if w not in starts:
                fail("text", f"offset table 0x{toff:x} entry "
                             f"{(o - toff) // 2} (${w:04x}) is not a string "
                             f"start in its {n}-byte pool")
    return len(pairs)


def check_regions(manifest, fail):
    spans = sorted((o, o + n, p) for p, o, n, _s in manifest)
    prev = None
    for lo, hi, path in spans:
        if lo // BANK_SIZE != (hi - 1) // BANK_SIZE:
            fail("regions", f"{path} crosses a bank boundary")
        if prev and lo < prev[1]:
            fail("regions", f"{path} overlaps {prev[2]}")
        prev = (lo, hi, path)
    return len(spans)


def main():
    global ROOT
    ROOT = Path(__file__).resolve().parent.parent
    rom = (ROOT / "baserom.gbc").read_bytes()
    manifest = load_manifest()
    labels = {int(k, 0): v for k, v in
              json.loads((ROOT / "labels.json").read_text()).items()}
    data_tables = {int(k, 0): v for k, v in
                   json.loads((ROOT / "data_tables.json").read_text()).items()}

    failures = []

    def fail(check, msg):
        failures.append((check, msg))

    counts = {
        "lz": check_lz(rom, manifest, fail),
        "lz-labels": check_lz_labels(labels, manifest, fail),
        "text": check_text(rom, data_tables, manifest, fail),
        "regions": check_regions(manifest, fail),
    }
    by_check = {}
    for check, msg in failures:
        by_check.setdefault(check, []).append(msg)
    for name, n in counts.items():
        bad = by_check.get(name, [])
        print(f"{name:10s} {n:5d} checked, {len(bad)} failed")
        for msg in bad[:10]:
            print(f"    {msg}")
        if len(bad) > 10:
            print(f"    ... and {len(bad) - 10} more")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
