#!/usr/bin/env python3
"""Build a copy of the tree with padding at the top of every bank, check
that every byte that changed is a reference that moved, and leave the padded
ROM for a boot test.

This inserts `ds PAD` at the start of every ROMX bank with room (and just
after the header in ROM0), builds the copy in a temporary directory, and
compares it with mariotennis.gbc at the shifted positions. Every byte that
differs must be a label reference that moved with its target -- a low byte up
by PAD, or a high byte carrying from one -- so anything else is reported.

What it cannot see is an address written as a number: its bytes do not
change, exactly like the data around it. `make check`'s `literals` class is
the detector for those; booting the padded ROM this leaves at
<tmp>/mariotennis.gbc is the proof that none is left. The build itself also
proves the slot-table ASSERTs and every bank's size survive the shift.

Banks with fewer than PAD free bytes are left unpadded (the pure data banks
that fill their 16 KiB exactly); references into them do not move.
"""
import argparse
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BANK = 0x4000
ROM0_PAD_BEFORE = "CallHLInBankA:\n"     # first label after the fixed header
ROM0_PAD_FILE = "src/home/vectors_00.asm"


def free_bytes(map_path):
    free, bank = {}, None
    for line in map_path.read_text().splitlines():
        m = re.match(r"ROM[0X] bank #(\d+)", line)
        if m:
            bank = int(m.group(1))
            free.setdefault(bank, 0)
        m = re.search(r"TOTAL EMPTY: \$([0-9a-f]+)", line)
        if m and bank is not None:
            free[bank] = int(m.group(1), 16)
    return free


def pad_tree(tree, pad, free, only=None):
    padded = set()
    for holder in sorted((tree / "src").glob("bank_*.asm")):
        bank = int(holder.stem.split("_")[1], 16)
        if free.get(bank, 0) < pad or (only is not None and bank not in only):
            continue
        if bank == 0:
            f = tree / ROM0_PAD_FILE
            f.write_text(f.read_text().replace(
                ROM0_PAD_BEFORE, f"\tds {pad}, $00\n{ROM0_PAD_BEFORE}", 1))
        else:
            head, rest = holder.read_text().split("\n", 1)
            holder.write_text(f"{head}\n\tds {pad}, $00\n{rest}")
        padded.add(bank)
    return padded


def compare(a, b, pad, padded, rom0_start):
    moved = carried = 0
    odd = []
    for bank in sorted(padded):
        lo = rom0_start if bank == 0 else bank * BANK
        hi = bank * BANK + BANK - pad
        for i in range(lo, hi):
            j = i + pad
            if a[i] == b[j]:
                continue
            if (b[j] - a[i]) & 0xff == pad:
                moved += 1
            elif (b[j] - a[i]) & 0xff == 1 and a[i - 1] != b[j - 1]:
                carried += 1
            else:
                odd.append((bank, i, a[i], b[j]))
    return moved, carried, odd


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--pad", type=int, default=3)
    ap.add_argument("--keep", action="store_true", help="keep the padded tree")
    ap.add_argument("--out", help="also copy the padded ROM here")
    ap.add_argument("--banks", help="pad only these banks: hex numbers and ranges, e.g. 0,1-3f")
    args = ap.parse_args()

    rom = ROOT / "mariotennis.gbc"
    if not rom.exists():
        sys.exit("mariotennis.gbc is missing: run `make` first")
    free = free_bytes(ROOT / "build" / "mariotennis.map")
    tmp = Path(tempfile.mkdtemp(prefix="shifttest-"))
    tree = tmp / "tree"
    shutil.copytree(ROOT, tree, ignore=shutil.ignore_patterns(
        ".git", "build", "*.gbc", "__pycache__"))
    only = None
    if args.banks:
        only = set()
        for part in args.banks.split(","):
            lo, _, hi = part.partition("-")
            only.update(range(int(lo, 16), int(hi or lo, 16) + 1))
    padded = pad_tree(tree, args.pad, free, only)
    r = subprocess.run(["make", "-j", "mariotennis.gbc"], cwd=tree,
                       capture_output=True, text=True)
    if r.returncode:
        print(r.stdout[-2000:], r.stderr[-2000:])
        sys.exit("the padded tree does not build")

    sym = (tree / "build" / "mariotennis.sym").read_text()
    rom0_start = int(re.search(r"00:([0-9a-f]{4}) CallHLInBankA", sym).group(1), 16)
    a, b = rom.read_bytes(), (tree / "mariotennis.gbc").read_bytes()
    moved, carried, odd = compare(a, b, args.pad, padded, rom0_start - args.pad)

    # A high byte one up with no low byte beside it is the adc half of a
    # split-base ld_hl_indexed, whose add half is two instructions earlier.
    real = []
    for bank, i, x, y in odd:
        if (y - x) & 0xff == 1 and any(a[k] != b[k + args.pad] for k in range(i - 4, i)):
            carried += 1
        else:
            real.append((bank, i, x, y))

    skipped = sorted(set(range(128)) - padded)
    print(f"padded {len(padded)} banks by {args.pad} "
          f"(full, left in place: {', '.join(f'${x:02x}' for x in skipped)})")
    print(f"{moved} low bytes moved with their targets, {carried} high bytes carried")
    for bank, i, x, y in real[:20]:
        cpu = i if bank == 0 else 0x4000 + i % BANK
        print(f"    unexplained: ${bank:02x}:${cpu:04x} {x:02x} -> {y:02x}")
    shutil.copy(tree / "mariotennis.gbc", tmp / "mariotennis.gbc")
    if args.out:
        shutil.copy(tree / "mariotennis.gbc", args.out)
    if not args.keep:
        shutil.rmtree(tree)
    print(f"padded ROM: {tmp / 'mariotennis.gbc'}")
    return 1 if real else 0


if __name__ == "__main__":
    sys.exit(main())
