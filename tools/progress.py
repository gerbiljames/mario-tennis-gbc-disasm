#!/usr/bin/env python3
"""Report disassembly progress per bank.

Proven-code bytes come from data.manifest (everything not extracted as a
data blob is disassembled code); label naming progress comes from the
linker symbol file, in three buckets: names that still state only an address
and so need work (`auto`), names the generator derives from something already
named and that nobody should edit (`derived`), and human-assigned ones
(`named`).
"""
import argparse
import json
import re
import sys
from pathlib import Path

BANK_SIZE = 0x4000
# Still says nothing but where it is, so it is work to be done. A slot label
# counts here only while it exposes an address -- a numeric slot, or one whose
# target is itself auto-named -- which is how a future unnamed target puts its
# slot back on the worklist by itself.
AUTO_RE = re.compile(
    r"^(?:Func|Label|Data|Lz|Text)_[0-9a-f]{2}_[0-9a-f]{4}$"
    r"|^(?:FarPtr|DataPtr)_[0-9a-f]{2}_[0-9a-f]{2,4}$"
    r"|^(?:FarPtr|DataPtr)_(?:Func|Label|Data|Lz|Text|Fill)_[0-9a-f]{2}_[0-9a-f]{4}")
# Generated, but carries its meaning: a $4000 slot spelled after its curated
# target (`FarPtr_RunDebugTestMenu`), or a structure named for what it is and
# which bank it is in (`SoundTable_78`). Renaming these is wrong -- a slot name
# is re-derived on every regeneration, so the target is what you name.
DERIVED_RE = re.compile(
    r"^(?:FarPtr|DataPtr)_"
    r"|^Sprite(?:Desc|Frames|Anims)_[0-9a-f]{2}$"
    r"|^(?:SoundTable|WalkSprites)_[0-9a-f]{2}$")


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--manifest", default="data.manifest")
    ap.add_argument("--sym", default="build/mariotennis.sym")
    ap.add_argument("--labels", default="labels.json")
    ap.add_argument("--all", action="store_true",
                    help="include banks with no proven code")
    ap.add_argument("--unnamed", metavar="BANK",
                    help="list the given bank's symbols that still need a name "
                         "(hex bank; excludes generator-derived names, which "
                         "are fixed by naming their target instead)")
    ap.add_argument("--derived", metavar="BANK",
                    help="list the given bank's generator-derived names (hex)")
    args = ap.parse_args()

    data_bytes = {}
    for line in Path(args.manifest).read_text().splitlines():
        if not line or line.startswith("#"):
            continue
        _blob, off_s, len_s = line.split()[:3]
        bank = int(off_s, 16) // BANK_SIZE
        data_bytes[bank] = data_bytes.get(bank, 0) + int(len_s, 16)

    fill_re = re.compile(r"^\tds (\d+), \$", re.M)
    # Trailing fill is linker-padded, not assembled: only a comment records it.
    pad_re = re.compile(r"^\t; \$[0-9a-f]{4}, (\d+) bytes fill to bank end",
                        re.M)
    fill_bytes = {}
    for p in Path("src").glob("bank_*.asm"):
        bank = int(p.stem.split("_")[1], 16)
        text = p.read_text()
        fill_bytes[bank] = sum(int(n) for n in fill_re.findall(text)) \
            + sum(int(n) for n in pad_re.findall(text))

    nbanks = len(list(Path("src").glob("bank_*.asm"))) or (max(data_bytes) + 1)

    # Curated `.local` labels (leading-dot names in labels.json). The sym file
    # spells them Parent.local, indistinguishable by shape from the ones the
    # macro/text emitters generate, so match them by offset instead.
    curated_locals = set()
    labp = Path(args.labels)
    if labp.exists():
        for k, v in json.loads(labp.read_text()).items():
            if isinstance(v, dict):
                v = v.get("name", "")
            if v.startswith("."):
                curated_locals.add(int(k, 0))

    syms = {b: [] for b in range(nbanks)}
    symp = Path(args.sym)
    if symp.exists():
        for line in symp.read_text().splitlines():
            line = line.strip()
            if not line or line.startswith(";"):
                continue
            loc, name = line.split()[:2]
            bank_s, addr_s = loc.split(":")
            bank, addr = int(bank_s, 16), int(addr_s, 16)
            if addr >= 0x8000 or bank >= nbanks:
                continue
            if "." in name:
                flat = addr if addr < 0x4000 else bank * BANK_SIZE + addr - 0x4000
                if flat not in curated_locals:
                    continue  # generated local labels (text string anchors)
                name = name[name.index("."):]
            syms[bank].append((addr, name))
    else:
        print(f"note: {args.sym} not found (run make); "
              "label columns omitted", file=sys.stderr)

    for opt, want in ((args.unnamed, AUTO_RE), (args.derived, DERIVED_RE)):
        if opt is None:
            continue
        bank = int(opt, 16)
        for addr, name in sorted(syms.get(bank, [])):
            if want is AUTO_RE and AUTO_RE.match(name):
                print(f"{bank:02x}:{addr:04x} {name}")
            elif want is DERIVED_RE and not AUTO_RE.match(name) \
                    and DERIVED_RE.match(name):
                print(f"{bank:02x}:{addr:04x} {name}")
        return

    print(f"{'bank':>4}  {'code bytes':>13}  {'code%':>6}  {'fill':>5}  "
          f"{'labels':>6}  {'named':>5}  {'derived':>7}  {'auto':>4}")
    tot_code = tot_fill = tot_labels = tot_named = tot_derived = tot_auto = 0
    for bank in range(nbanks):
        fill = fill_bytes.get(bank, 0)
        code = BANK_SIZE - data_bytes.get(bank, 0) - fill
        labels = syms[bank]
        auto = [n for _a, n in labels if AUTO_RE.match(n)]
        derived = [n for _a, n in labels
                   if not AUTO_RE.match(n) and DERIVED_RE.match(n)]
        named = len(labels) - len(auto) - len(derived)
        tot_code += code
        tot_fill += fill
        tot_labels += len(labels)
        tot_named += named
        tot_derived += len(derived)
        tot_auto += len(auto)
        if code == 0 and not args.all:
            continue
        print(f"{bank:>4x}  {code:>5}/{BANK_SIZE}  {code/BANK_SIZE:>6.1%}  "
              f"{fill:>5}  {len(labels):>6}  {named:>5}  {len(derived):>7}  "
              f"{len(auto):>4}")
    total = nbanks * BANK_SIZE
    print(f"{'all':>4}  {tot_code:>5}/{total}  {tot_code/total:>6.1%}  "
          f"{tot_fill:>5}  {tot_labels:>6}  {tot_named:>5}  {tot_derived:>7}  "
          f"{tot_auto:>4}")


if __name__ == "__main__":
    main()
