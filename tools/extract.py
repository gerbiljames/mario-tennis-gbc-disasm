#!/usr/bin/env python3
"""Extract data blobs from the base ROM into data/ per the manifest.

Manifest format: one entry per line, `<relative path> <hex offset> <hex length>`.
Lines starting with # are comments.
"""
import sys
from pathlib import Path


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
        path, off_s, len_s = line.split()
        off, length = int(off_s, 16), int(len_s, 16)
        if off + length > len(rom):
            print(f"error: {path} range {off:#x}+{length:#x} exceeds ROM size", file=sys.stderr)
            return 1
        dest = outdir / path
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(rom[off:off + length])
        count += 1
    print(f"extracted {count} files to {outdir}/")
    return 0


if __name__ == "__main__":
    sys.exit(main())
