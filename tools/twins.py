#!/usr/bin/env python3
"""List the live routines that are instruction-identical copies of each other.

Reads every bank of `main.asm`, takes every global label's run of
instructions up to the next global label, and normalises each line by
dropping the address comment and the two-hex-digit bank suffix on names
(`FetchText_25` -> `FetchText`), so copies of one routine assembled into
several banks fingerprint alike whatever their bank-local helpers are
called. Routines shorter than --min instructions and `Unused*` routines
(catalogued in docs/unused_code.md) are left out.

The groups are what a fix has to be applied to in full; docs/duplicated_code.md
is this tool's table.

usage: twins.py [--min N] [--json FILE]
"""
import argparse
import collections
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "tools"))
from banksrc import MAIN, bank_lines, bank_of, holders  # noqa: E402
_LABEL_RE = re.compile(r"^([A-Za-z_]\w*):")
# what counts as an instruction: CPU mnemonics, the code idiom macros, and the
# story script_* macros (prefix-matched below) -- not table rows, and not the
# as_* actor bytecode, which is data
_CODE_WORDS = frozenset(
    "adc add and bit call ccf cp cpl daa dec di ei halt inc jp jr ld ldd ldh ldi nop or pop "
    "push res ret reti rl rla rlc rlca rr rra rrc rrca rst sbc scf set sla sra srl stop sub "
    "swap xor farcall push_wram_bank pop_wram_bank wram_bank ld_hl_indexed wait_frames lb "
    "set_flag clear_flag test_flag ld_flag_id sound ld_slot ld_de_indexed ld_bc_indexed ld_xy ld_oam "
    "ld_size ld_tile_run ld_bg_cell ld_text_attr rect_size rect_cell map_cell sprite_xy sprite_attr_tile sprite_tile_attr "
    "ld_bg_pals ld_obj_pals ld_cell rect_ptrs rect_pair add_hl_a add_de_a add_bc_a "
    "neg_hl neg_de neg_bc abs_hl abs_de abs_bc sub_hl_de sub_hl_bc ld_story_char_field rom_bank "
    "push_rom_bank pop_rom_bank sram_bank jumptable frame_task".split())
# a macro counted at the instructions it stands for, where that is several
_WEIGHT = {"add_hl_a": 4, "add_de_a": 4, "add_bc_a": 4, "neg_hl": 6, "neg_de": 6, "neg_bc": 6,
           "abs_hl": 8, "abs_de": 8, "abs_bc": 8, "sub_hl_de": 6, "sub_hl_bc": 6,
           "ld_story_char_field": 11, "rom_bank": 2, "push_rom_bank": 4, "pop_rom_bank": 3,
           "sram_bank": 2, "jumptable": 1, "frame_task": 3}
# these load their argument, if given, into a first
_ARG_LOADS = {"rom_bank", "push_rom_bank", "sram_bank", "jumptable"}
_SUFFIX_RE = re.compile(r"\b([A-Za-z]\w*?)_[0-9a-f]{2}\b")
# a bank's `<Template>_<bank>_NAME EQUS "<name>"` copy, fingerprinted as its template
_NAME_EQUS_RE = re.compile(r'^DEF (\w+)_[0-9a-f]{2}_NAME EQUS "(\w+)"', re.M)
_WORD_RE = re.compile(r"\b[A-Za-z_]\w*\b")


def routines(min_instrs):
    """name -> (bank, normalised line tuple, instruction count)."""
    out = {}
    alias = {name: tmpl for tmpl, name in _NAME_EQUS_RE.findall(MAIN.read_text())}
    for f in holders():
        bank = bank_of(f)
        cur, seq, n = None, [], 0

        def flush():
            if cur and n >= min_instrs and "Unused" not in cur:
                out[cur] = (bank, tuple(seq), n)

        for line in bank_lines(f)[0]:
            m = _LABEL_RE.match(line)
            if m:
                flush()
                cur, seq, n = m.group(1), [], 0
                continue
            if not line.startswith("\t") or line.startswith("\t;"):
                continue
            body = _WORD_RE.sub(lambda m: alias.get(m.group(0), m.group(0)), line.split(" ; ")[0])
            # a text id (Text_25_61) is not a bank-suffixed name
            seq.append(_SUFFIX_RE.sub(lambda m: m.group(0) if m.group(1).startswith("Text_")
                                      else m.group(1), body))
            word = body.split()[0] if body.strip() else ""
            if word in _CODE_WORDS or word.startswith("script_"):
                n += _WEIGHT.get(word, 1) + (word in _ARG_LOADS and len(body.split()) > 1)
        flush()
    return out


def groups(min_instrs=10):
    """Lists of (bank, name, instruction count), largest group first."""
    by_seq = collections.defaultdict(list)
    for name, (bank, seq, n) in routines(min_instrs).items():
        by_seq[seq].append((bank, name, n))
    out = [sorted(g) for g in by_seq.values() if len(g) >= 2]
    out.sort(key=lambda g: (-len(g), g[0][1]))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--min", type=int, default=10, help="minimum instructions")
    ap.add_argument("--json", help="also write the groups to this file")
    args = ap.parse_args()
    gs = groups(args.min)
    if args.json:
        Path(args.json).write_text(json.dumps(gs, indent=0))
    print(f"{len(gs)} groups, {sum(len(g) for g in gs)} routines")
    for g in gs:
        print(f"{g[0][2]:4d}  " + "  ".join(f"{n} (${b:02x})" for b, n, _ in g))


if __name__ == "__main__":
    main()
