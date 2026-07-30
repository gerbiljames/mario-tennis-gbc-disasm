#!/usr/bin/env python3
"""Convert a BizHawk native Trace Logger dump into a coverage JSON file.

The native tracer logs raw CPU addresses with no bank information, but it
also logs the opcode bytes. Banked addresses ($4000-$7fff) are resolved by
matching those bytes against every ROM bank at the same in-bank offset,
intersected across runs of consecutive banked instructions (one run cannot
span a bank switch). Ambiguous runs (code mirrored in several banks) fall
back to the lowest matching bank.

A run also survives an excursion into ROM0/RAM when execution comes back to
the instruction *after* the one that left: the caller can only resume at its
own next address if its bank is still mapped, so the excursion cannot have
changed the bank the run is in. That matters because the game reaches ROM0
constantly (`call`, and the rst conventions), and without the rule a banked
function is chopped into runs of one or two instructions -- and a run of a
single one-byte `rst` has no bank evidence at all, so `min()` used to hand it
to whichever bank happened to hold that byte at that in-bank offset. Runs
that are still ambiguous with only one instruction's worth of evidence are
dropped rather than guessed.

Resuming past a `rst` needs the game's inline-operand conventions, since the
tracer logs only the opcode byte: see RESUME_EXTRA.

It also derives the WRAM bank per instruction, which the native tracer does
not log either. The game switches banks with a fixed idiom whose immediate is
in the logged opcode bytes:

    ld a, N            ; 3e NN
    ldh [hWramBank], a ; e0 96
    ldh [rWBK], a      ; e0 70

so a write to rWBK preceded (two instructions back) by `ld a, imm` names the
new bank outright. Any *other* way of reaching that write -- A from a pop, a
memory read, the shadow byte -- sets the bank to unknown rather than guessing,
and instructions executed while it is unknown get a zero mask, which
load_traced_wram_banks skips. A missing mask costs nothing; a wrong one
silently corrupts every name derived from it, so this only ever emits what the
log proves.

Output shape matches the fixed connector:
{"rom": [...], "rom_wram_bank": [...], "other": [...]}, the two arrays
parallel and equal in length.

usage: tracelog2cov.py <baserom> <trace.log> <out.json>
"""
import json
import re
import sys
from pathlib import Path

BANK_SIZE = 0x4000
LINE_RE = re.compile(r"^([0-9A-F]{4}):\s+([0-9A-F]{2}(?: [0-9A-F]{2}){0,2})\s")

# Inline operand bytes the callee steps the return address past, keyed by the
# opcode the tracer logs (it logs the opcode alone for a rst). $c7 (rst $00,
# JumpTableDispatch) is absent on purpose: flow never resumes after it.
RESUME_EXTRA = {0xDF: 2, 0xCF: 1, 0xE7: 2, 0xEF: 2, 0xF7: 2}

# Writes to rWBK ($ff70): `ldh [$70], a` and the long form `ld [$ff70], a`.
WBK_WRITES = (b"\xe0\x70", b"\xea\x70\xff")
LD_A_IMM = 0x3E
INLINE_ARG_CALLS = {0x2725}  # `call Func_00_2725` reads one byte after itself


def resume_addr(addr, data):
    """Where flow comes back to after `data` at `addr` leaves the bank."""
    op = data[0]
    if op == 0xC7:
        return None
    if len(data) == 1 and op in RESUME_EXTRA:
        return addr + 1 + RESUME_EXTRA[op]
    if op == 0xCD and len(data) == 3 and (data[1] | (data[2] << 8)) in INLINE_ARG_CALLS:
        return addr + 4
    return addr + len(data)


def candidates(rom, nbanks, addr, data, cache):
    key = (addr, data)
    got = cache.get(key)
    if got is None:
        off = addr - BANK_SIZE
        got = frozenset(
            b for b in range(1, nbanks)
            if rom[b * BANK_SIZE + off: b * BANK_SIZE + off + len(data)] == data
        )
        cache[key] = got
    return got


def main():
    if len(sys.argv) != 4:
        print(f"usage: {sys.argv[0]} <baserom> <trace.log> <out.json>", file=sys.stderr)
        return 2
    rom = Path(sys.argv[1]).read_bytes()
    nbanks = len(rom) // BANK_SIZE

    rom_offs = set()
    other = set()
    cache = {}
    run = []          # [(addr, bytes)] of the current banked run
    run_banks = None  # candidate-bank intersection for the run
    resume = None     # where the run's last banked instruction resumes
    left_bank = False # an excursion out of $4000-$7fff is open
    wbank = None      # WRAM bank proved by the log, or None while unknown
    prev2 = None      # bytes of the instruction two back (the `ld a, imm`)
    prev1 = None      # bytes of the instruction one back
    masks = {}        # flat ROM offset -> OR of (1 << wram bank) seen there
    stats = {"lines": 0, "unparsed": 0, "bank0_mismatch": 0,
             "runs": 0, "ambiguous_runs": 0, "dead_runs": 0, "unresolved_runs": 0}

    def close_run():
        nonlocal run, run_banks, resume
        if run:
            stats["runs"] += 1
            if run_banks and (len(run_banks) == 1 or len(run) > 1):
                if len(run_banks) > 1:
                    stats["ambiguous_runs"] += 1
                bank = min(run_banks)
                for a, _, wb in run:
                    off = bank * BANK_SIZE + a - BANK_SIZE
                    rom_offs.add(off)
                    if wb:
                        masks[off] = masks.get(off, 0) | (1 << wb)
            elif run_banks:
                stats["unresolved_runs"] += 1
            else:
                stats["dead_runs"] += 1
        run, run_banks, resume = [], None, None

    with open(sys.argv[2], errors="replace") as f:
        for line in f:
            m = LINE_RE.match(line)
            if not m:
                stats["unparsed"] += 1
                continue
            stats["lines"] += 1
            addr = int(m.group(1), 16)
            data = bytes.fromhex(m.group(2))
            # A write to rWBK takes its value from A. The bank is only known
            # when the `ld a, imm` two instructions back supplied it -- that is
            # the wram_bank idiom, and the immediate is in the logged bytes.
            if any(data.startswith(w) for w in WBK_WRITES):
                wbank = (prev2[1] & 0x07 if prev2 and len(prev2) >= 2
                         and prev2[0] == LD_A_IMM else None)
                if wbank == 0:
                    wbank = 1      # rWBK 0 and 1 both select WRAM bank 1
            prev2, prev1 = prev1, data
            if addr < BANK_SIZE:
                left_bank = True
                if rom[addr:addr + len(data)] == data:
                    rom_offs.add(addr)
                    if wbank:
                        masks[addr] = masks.get(addr, 0) | (1 << wbank)
                else:
                    stats["bank0_mismatch"] += 1
            elif addr < 0x8000:
                if left_bank and addr != resume:
                    close_run()
                left_bank = False
                cand = candidates(rom, nbanks, addr, data, cache)
                merged = run_banks & cand if run_banks is not None else cand
                if not merged:
                    close_run()
                    merged = cand
                if merged:
                    run.append((addr, data, wbank))
                    run_banks = merged
                    resume = resume_addr(addr, data)
                else:
                    stats["dead_runs"] += 1
                    resume = None
            else:
                left_bank = True
                other.add(addr)
    close_run()

    offs = sorted(rom_offs)
    json.dump({"rom": offs,
               "rom_wram_bank": [masks.get(o, 0) for o in offs],
               "other": sorted(other)}, open(sys.argv[3], "w"))
    print(f"parsed {stats['lines']} instructions "
          f"({stats['unparsed']} non-instruction lines skipped)")
    print(f"runs: {stats['runs']} ({stats['ambiguous_runs']} ambiguous -> lowest bank, "
          f"{stats['unresolved_runs']} ambiguous single-instruction dropped, "
          f"{stats['dead_runs']} unmatched dropped), bank0 byte mismatches: {stats['bank0_mismatch']}")
    known = sum(1 for o in offs if masks.get(o))
    print(f"wrote {sys.argv[3]}: rom={len(rom_offs)} other={len(other)}, "
          f"wram bank known at {known} of {len(offs)} offsets "
          f"({100 * known // max(1, len(offs))}%)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
