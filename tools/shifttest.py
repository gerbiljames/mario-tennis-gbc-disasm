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

Banks with fewer than PAD + 15 free bytes are left unpadded (a shifted bank's
first `ALIGN 4` absorbs up to 15 more) (the pure data banks
that fill their 16 KiB exactly); references into them do not move. So is a
bank that opens with a table pinned by an ASSERT (the trig, view-scale and
sound tables, whose readers build the address from a computed high byte).
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


def pinned(tree, lines):
    """A bank whose first fragment opens with an ASSERT is pinned in place."""
    first = next((m.group(1) for m in map(re.compile(r'^INCLUDE "([^"]+)"').match, lines) if m), None)
    if not first:
        return False
    head = (tree / first).read_text().splitlines()[:3]
    return any(line.strip().startswith("ASSERT") for line in head)


def pad_tree(tree, pad, free, only=None):
    padded = set()
    main = tree / "main.asm"
    lines = main.read_text().split("\n")
    sections = [(i, int(m.group(1), 16)) for i, m in
                ((i, re.match(r'^SECTION "ROM Bank \$([0-9a-f]{2})"', l)) for i, l in enumerate(lines)) if m]
    ends = [i for i, _ in sections[1:]] + [len(lines)]
    inserts = []
    for (i, bank), end in zip(sections, ends):
        if bank and pinned(tree, lines[i:end]):
            continue
        # a shifted bank's first ALIGN 4 can take up to 15 more bytes
        if free.get(bank, 0) < pad + 15 or (only is not None and bank not in only):
            continue
        if bank == 0:
            f = tree / ROM0_PAD_FILE
            f.write_text(f.read_text().replace(
                ROM0_PAD_BEFORE, f"\tds {pad}, $00\n{ROM0_PAD_BEFORE}", 1))
        else:
            inserts.append(i + 1)
        padded.add(bank)
    for i in reversed(inserts):
        lines.insert(i, f"\tds {pad}, $00")
    main.write_text("\n".join(lines))
    return padded


def symbols(path):
    out = {}
    for line in path.read_text().splitlines():
        m = re.match(r"([0-9a-f]{2}):([0-9a-f]{4}) (\S+)", line)
        if m and int(m.group(2), 16) < 0x8000:
            out[m.group(3)] = (int(m.group(1), 16), int(m.group(2), 16))
    return out


def displacements(sym_a, sym_b, padded):
    """Per bank, the sorted (address, shift) steps: a byte moved by the shift
    of the nearest label at or before it. The shift is PAD before a bank's
    first `ds ALIGN[4]` and more after it."""
    steps = {}
    for name, (bank, addr) in sym_a.items():
        if bank in padded and name in sym_b:
            steps.setdefault(bank, {})[addr] = sym_b[name][1] - addr
    return {bank: sorted(d.items()) for bank, d in steps.items()}


def compare(a, b, padded, steps, rom0_start):
    moved = carried = 0
    odd = []
    shifts = {d for s in steps.values() for _, d in s if d}
    for bank in sorted(padded):
        lo = rom0_start if bank == 0 else bank * BANK
        base = 0 if bank == 0 else 0x4000 - bank * BANK
        table = steps.get(bank, [])
        k, d = 0, 0
        for i in range(lo, bank * BANK + BANK):
            cpu = i + base
            while k < len(table) and table[k][0] <= cpu:
                d = table[k][1]
                k += 1
            j = i + d
            if j >= bank * BANK + BANK:
                break
            # fill before a label that moved less (a pinned section) is
            # what the padding used up
            if k < len(table) and j + base >= table[k][0] + table[k][1]:
                continue
            if a[i] == b[j]:
                continue
            if (b[j] - a[i]) & 0xff in shifts:
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
    ap.add_argument("--out", help="also copy the padded ROM here, and its .sym beside it")
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
    steps = displacements(symbols(ROOT / "build" / "mariotennis.sym"),
                          symbols(tree / "build" / "mariotennis.sym"), padded)
    moved, carried, odd = compare(a, b, padded, steps, rom0_start - args.pad)

    # A high byte one up with no low byte beside it is the adc half of a
    # split-base ld_hl_indexed, whose add half is two instructions earlier.
    real = []
    for bank, i, x, y in odd:
        if (y - x) & 0xff == 1 and any(a[k] != b[k + dd] for k in range(i - 4, i)
                                        for dd in {s for st in steps.values() for _, s in st}):
            carried += 1
        else:
            real.append((bank, i, x, y))

    skipped = sorted(set(range(128)) - padded)
    print(f"padded {len(padded)} banks by {args.pad} "
          f"(full or pinned, left in place: {', '.join(f'${x:02x}' for x in skipped)})")
    print(f"{moved} low bytes moved with their targets, {carried} high bytes carried")
    for bank, i, x, y in real[:20]:
        cpu = i if bank == 0 else 0x4000 + i % BANK
        print(f"    unexplained: ${bank:02x}:${cpu:04x} {x:02x} -> {y:02x}")
    shutil.copy(tree / "mariotennis.gbc", tmp / "mariotennis.gbc")
    if args.out:
        shutil.copy(tree / "mariotennis.gbc", args.out)
        shutil.copy(tree / "build" / "mariotennis.sym", Path(args.out).with_suffix(".sym"))
    if not args.keep:
        shutil.rmtree(tree)
    print(f"padded ROM: {tmp / 'mariotennis.gbc'}")
    return 1 if real else 0


if __name__ == "__main__":
    sys.exit(main())
