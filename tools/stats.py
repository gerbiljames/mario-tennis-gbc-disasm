#!/usr/bin/env python3
"""Headline counts for the README and STATUS, from the built tree.

    python3 tools/stats.py

labels        symbols in build/mariotennis.sym, split into ROM and RAM and into
              routines/tables (global) and locals (`Parent.local`)
instructions  CPU instruction lines in the assembled source, shared twin
              bodies counted once per bank that assembles them; a line using a
              macro whose body has an instruction (`farcall`, `script_speak`,
              `wram_bank`, ...) counts as one
ROM bytes     the linker's used space (2 MiB less the map's TOTAL EMPTY),
              split into INCBIN'd data, `ds` fill and the rest -- the bytes
              the source spells out as instructions, records and tables
"""
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from banksrc import bank_text, holders  # noqa: E402
from reach import MNEMONICS  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
ROM_SIZE = 0x200000


def labels():
    rom = {"global": 0, "local": 0}
    ram = {"global": 0, "local": 0}
    for line in (ROOT / "build" / "mariotennis.sym").read_text().splitlines():
        m = re.match(r"([0-9a-f]{2}):([0-9a-f]{4}) (\S+)", line)
        if not m:
            continue
        addr, name = int(m.group(2), 16), m.group(3)
        kind = "local" if "." in name else "global"
        (rom if addr < 0x8000 else ram)[kind] += 1
    return rom, ram


def code_macros():
    """Macros (include/macros.inc) whose body has a CPU instruction or uses another code macro."""
    bodies = {m.group(1).lower(): m.group(2) for m in re.finditer(
        r"^MACRO (\w+)[^\n]*\n(.*?)^ENDM", (ROOT / "include" / "macros.inc").read_text(), re.M | re.S)}
    ops = {n: {w.lower() for w in re.findall(r"^\s+(\w+)", b, re.M)}
           for n, b in bodies.items()}
    code = {n for n, o in ops.items() if o & MNEMONICS}
    while True:
        more = {n for n, o in ops.items() if n not in code and o & code}
        if not more:
            return code
        code |= more


def source():
    instrs = incbin = fill = 0
    macros = code_macros()
    for h in holders():
        for line in bank_text(h).splitlines():
            code = line.split(";", 1)[0]
            m = re.match(r"\s+(\w+)\b(.*)", code)
            if not m:
                continue
            op, rest = m.group(1).lower(), m.group(2)
            if op == "incbin":
                args = [a.strip() for a in rest.split(",")]
                size = (ROOT / args[0].strip('"')).stat().st_size
                if len(args) == 3:
                    size = int(args[2].replace("$", "0x"), 0)
                elif len(args) == 2:
                    size -= int(args[1].replace("$", "0x"), 0)
                incbin += size
            elif op == "ds" and "ALIGN" not in rest:
                n = re.match(r"\s*(\$?[0-9a-fA-F]+)\b", rest)
                if n:
                    fill += int(n.group(1).replace("$", "0x"), 0)
            elif op in MNEMONICS or op in macros:
                instrs += 1
    return instrs, incbin, fill


def main():
    rom, ram = labels()
    instrs, incbin, fill = source()
    # the RAM sections report a TOTAL EMPTY too: count only the ROM banks'
    text = (ROOT / "build" / "mariotennis.map").read_text()
    free = sum(int(m.group(2), 16) for m in re.finditer(
        r"^(ROM0|ROMX) bank #\d+:\n(?:.*\n)*?\tTOTAL EMPTY: \$([0-9a-f]+) bytes", text, re.M))
    used = ROM_SIZE - free
    spelled = used - incbin - fill
    print(f"labels        {sum(rom.values()) + sum(ram.values()):,}: ROM {rom['global']:,} global "
          f"+ {rom['local']:,} local, RAM {ram['global']:,} global + {ram['local']:,} local")
    print(f"instructions  {instrs:,}")
    print(f"ROM bytes     {used:,} used of {ROM_SIZE:,}: {spelled:,} spelled out "
          f"({100 * spelled / ROM_SIZE:.1f}%), {incbin:,} INCBIN, {fill:,} fill")


if __name__ == "__main__":
    main()
