#!/usr/bin/env python3
"""Report disassembly progress per bank.

Proven-code bytes come from data.manifest (everything not extracted as a
data blob is disassembled code); label naming progress comes from the
linker symbol file, splitting auto-generated names (Func_xx_xxxx,
Label_xx_xxxx, FarPtr_xx_xx) from human-assigned ones.
"""
import argparse
import re
import sys
from pathlib import Path

BANK_SIZE = 0x4000
AUTO_RE = re.compile(
    r"^(?:Func|Label|Data|Lz|Text)_[0-9a-f]{2}_[0-9a-f]{4}$"
    r"|^(?:FarPtr|DataPtr)_"  # incl. slot names derived from curated targets
    r"|^Sprite(?:Desc|Frames|Anims)_[0-9a-f]{2}$"
    r"|^(?:SoundTable|WalkSprites)_[0-9a-f]{2}$")


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--manifest", default="data.manifest")
    ap.add_argument("--sym", default="build/mariotennis.sym")
    ap.add_argument("--all", action="store_true",
                    help="include banks with no proven code")
    ap.add_argument("--unnamed", metavar="BANK",
                    help="list auto-named symbols in the given bank (hex)")
    args = ap.parse_args()

    data_bytes = {}
    for line in Path(args.manifest).read_text().splitlines():
        if not line or line.startswith("#"):
            continue
        _blob, off_s, len_s = line.split()[:3]
        bank = int(off_s, 16) // BANK_SIZE
        data_bytes[bank] = data_bytes.get(bank, 0) + int(len_s, 16)

    fill_re = re.compile(r"^\tds (\d+), \$", re.M)
    fill_bytes = {}
    for p in Path("src").glob("bank_*.asm"):
        bank = int(p.stem.split("_")[1], 16)
        fill_bytes[bank] = sum(int(n) for n in fill_re.findall(p.read_text()))

    nbanks = len(list(Path("src").glob("bank_*.asm"))) or (max(data_bytes) + 1)

    syms = {b: [] for b in range(nbanks)}
    symp = Path(args.sym)
    if symp.exists():
        for line in symp.read_text().splitlines():
            line = line.strip()
            if not line or line.startswith(";"):
                continue
            loc, name = line.split()[:2]
            if "." in name:
                continue  # generated local labels (text string anchors)
            bank_s, addr_s = loc.split(":")
            bank, addr = int(bank_s, 16), int(addr_s, 16)
            if addr >= 0x8000 or bank >= nbanks:
                continue
            syms[bank].append((addr, name))
    else:
        print(f"note: {args.sym} not found (run make); "
              "label columns omitted", file=sys.stderr)

    if args.unnamed is not None:
        bank = int(args.unnamed, 16)
        for addr, name in sorted(syms.get(bank, [])):
            if AUTO_RE.match(name):
                print(f"{bank:02x}:{addr:04x} {name}")
        return

    print(f"{'bank':>4}  {'code bytes':>13}  {'code%':>6}  {'fill':>5}  "
          f"{'labels':>6}  {'named':>5}")
    tot_code = tot_fill = tot_labels = tot_named = 0
    for bank in range(nbanks):
        fill = fill_bytes.get(bank, 0)
        code = BANK_SIZE - data_bytes.get(bank, 0) - fill
        labels = syms[bank]
        named = [n for _a, n in labels if not AUTO_RE.match(n)]
        tot_code += code
        tot_fill += fill
        tot_labels += len(labels)
        tot_named += len(named)
        if code == 0 and not args.all:
            continue
        print(f"{bank:>4x}  {code:>5}/{BANK_SIZE}  {code/BANK_SIZE:>6.1%}  "
              f"{fill:>5}  {len(labels):>6}  {len(named):>5}")
    total = nbanks * BANK_SIZE
    print(f"{'all':>4}  {tot_code:>5}/{total}  {tot_code/total:>6.1%}  "
          f"{tot_fill:>5}  {tot_labels:>6}  {tot_named:>5}")


if __name__ == "__main__":
    main()
