#!/usr/bin/env python3
"""Generate per-bank RGBDS source from the base ROM plus execution coverage.

Coverage files are raw dumps from the BizHawk tracer (get_coverage
summarize=false): exact addresses of executed instruction starts. Those are
used as verified seeds; an optional conservative recursive descent extends
them through direct jump/call targets within the same bank (or bank 0).

Everything not proven to be code is emitted as an INCBIN of a blob listed in
data.manifest, which setup.sh extracts from the user's ROM at setup time, so
no ROM bytes land in the repository.
"""
import argparse
import json
import re
import sys
from pathlib import Path

HWADDR_RE = re.compile(r"\$ff[0-9a-f]{2}\b")
MEMADDR_RE = re.compile(r"\[\$([0-9a-f]{4})\]")

sys.path.insert(0, str(Path(__file__).parent))
import sm83

BANK_SIZE = 0x4000


def load_coverage(paths, nbanks):
    """Return a set of ROM offsets that are verified instruction starts.

    Accepts three dump shapes, auto-detected per file:

    - Old connector/MCP dump (`fixed`/`banked`, kept for coverage_raw*.json
      already checked into this repo): addresses are flat ROM offsets
      (validated by decode-chain scoring). `banked` pairs/groups reassemble
      as tag*0x10000 + value, and `fixed` values are flat offsets too,
      except >= $ff00 which is genuine HRAM execution (the OAM DMA stub) and
      not part of the ROM image.
    - Interim mixed dump (`addrs`): one flat list of raw exec-callback
      values, best-effort classified here (0xff00-0xffff is the top-of-bus
      I/O/HRAM/IE window, never ROM; everything else under rom_size counts
      as a flat ROM offset).
    - Current dump (`rom`/`other`): both trace_client.py and
      get_coverage(summarize=False) emit this. `rom` is a clean list of flat
      ROM offsets; the connector pairs the raw and domain-translated
      exec-callback invocations, so RAM/HRAM execution lands in `other`
      instead of leaking into `rom`.

    NOTE: dumps captured before the connector-side pairing fix -- all
    `fixed`/`banked` and `addrs` files, and any `rom`/`other` file written
    while the pre-fix Lua was still loaded (e.g. coverage_match1.json) --
    came from a tracer subject to BizHawk's exec-callback double-fire: every
    instruction reported BOTH its raw CPU bus address AND its
    domain-translated offset, so they contain phantom seeds (e.g. HRAM stub
    execution also appearing as ROM offsets 0x00-0x7e, and banked execution
    also appearing as bank-1-range offsets 0x4000-0x7fff). They still parse,
    and seed()'s invalid/conflict filtering plus the INCBIN fallback keep
    the build byte-perfect, but expect a higher invalid/conflicting seed
    count from them.
    """
    seeds = set()
    dropped = 0
    rom_size = nbanks * BANK_SIZE
    for p in paths:
        d = json.loads(Path(p).read_text())
        flat = []
        if "addrs" in d:
            flat = [v for v in d["addrs"] if not (0xff00 <= v <= 0xffff)]
        elif "rom" in d or "other" in d:
            flat = list(d.get("rom", []))
        else:
            banked = d.get("banked", {})
            if isinstance(banked, dict):  # MCP dump: {"tag": [values...]}
                for tag, vals in banked.items():
                    flat += [int(tag) * 0x10000 + v for v in vals]
            else:  # raw connector: [[tag, value], ...]
                flat += [tag * 0x10000 + v for tag, v in banked]
            flat += [v for v in d.get("fixed", []) if v < 0xff00]
        for v in flat:
            if v < rom_size:
                seeds.add(v)
            else:
                dropped += 1
    if dropped:
        print(f"note: dropped {dropped} out-of-range coverage entries")
    return seeds


def offset_to_cpu(off):
    return off if off < BANK_SIZE else BANK_SIZE + off % BANK_SIZE


def target_to_offset(target, cur_off):
    """Map a CPU-address branch target to a ROM offset, or None if unknowable."""
    if target < BANK_SIZE:
        return target
    if target < 0x8000:
        if cur_off >= BANK_SIZE:  # same switchable bank as the referrer
            return (cur_off // BANK_SIZE) * BANK_SIZE + target - BANK_SIZE
        return None  # bank 0 code jumping into an unknown mapped bank
    return None  # RAM


class Disassembly:
    def __init__(self, rom):
        self.rom = rom
        self.instrs = {}      # rom offset -> Instr
        self.code_bytes = set()
        self.farcalls = {}    # site offset -> (bank, slot, entry_flat, target_flat)
        self.inferred_entries = {}  # entry_flat -> (bank, slot, target_flat)
        self.jt_entries = {}  # rst $00 inline jump-table entry offset -> target_flat

    def _try_farcall(self, off):
        """Decode `rst $18` + inline `db slot, bank` as a 3-byte pseudo-call.

        The FarCall trampoline at $01b6 (vectored from rst $10/$18) reads two
        inline operand bytes after the rst, switches to `bank`, and jumps
        through the pointer table at $4000+slot in that bank; the stacked
        return address is patched past the operands. Only rst $18 is used by
        the game. Returns (bank, slot, entry_flat, target_flat) or None if
        the operands don't look like a real farcall site.
        """
        if off + 3 > len(self.rom):
            return None
        if (off // BANK_SIZE) != ((off + 2) // BANK_SIZE):
            return None
        slot, bank = self.rom[off + 1], self.rom[off + 2]
        if bank == 0 or bank >= len(self.rom) // BANK_SIZE or slot & 1:
            return None
        entry = bank * BANK_SIZE + slot
        target_cpu = self.rom[entry] | (self.rom[entry + 1] << 8)
        if not (BANK_SIZE <= target_cpu < 0x8000):
            return None
        target = bank * BANK_SIZE + target_cpu - BANK_SIZE
        if not sm83.decode(self.rom, target, target_cpu).valid:
            return None
        return (bank, slot, entry, target)

    def decode_at(self, off):
        op = self.rom[off]
        if op == 0xDF:  # rst $18: the FarCall convention
            fc = self._try_farcall(off)
            if fc is not None:
                self.farcalls[off] = fc
                return sm83.Instr(3, "farcall {far}", None, True, False, False, False)
        elif op == 0xC7:
            # rst $00: JumpTableDispatch pops the return address as the base
            # of an inline dw jump table -- flow never resumes after the rst
            return sm83.Instr(1, "rst {target}", 0x00, True, False, False, True)
        elif op == 0xCF and off + 2 <= len(self.rom) \
                and off // BANK_SIZE == (off + 1) // BANK_SIZE:
            # rst $08: sound/music command, one inline id byte
            return sm83.Instr(2, f"sound ${self.rom[off+1]:02x}",
                              None, True, False, False, False)
        elif op in (0xE7, 0xEF, 0xF7) and off + 3 <= len(self.rom) \
                and off // BANK_SIZE == (off + 2) // BANK_SIZE:
            # rst $20/$28/$30: shared convention, one inline dw pointer
            # operand fetched into de by Func_00_253d
            ptr = self.rom[off + 1] | (self.rom[off + 2] << 8)
            name = {0xE7: "rst20", 0xEF: "rst28", 0xF7: "rst30"}[op]
            return sm83.Instr(3, f"{name} ${ptr:04x}", None, True, False, False, False)
        return sm83.decode(self.rom, off, offset_to_cpu(off))

    def mark(self, off, ins):
        self.instrs[off] = ins
        for i in range(off, off + ins.size):
            self.code_bytes.add(i)

    def conflicts(self, off, ins):
        """True if this instruction's span would misalign with existing code."""
        for i in range(off + 1, off + ins.size):
            if i in self.instrs:
                return True
        return off in self.code_bytes and off not in self.instrs

    def seed(self, seeds):
        bad = 0
        for off in sorted(seeds):
            if off in self.instrs:
                continue
            ins = self.decode_at(off)
            if not ins.valid or self.conflicts(off, ins):
                bad += 1
                continue
            self.mark(off, ins)
        if bad:
            print(f"note: {bad} coverage seeds decoded invalid/conflicting; skipped")

    def infer_tables(self):
        """Infer unused farcall-table entries from table shape.

        Live call sites prove a table spans $4000..(max used slot)+2 in each
        bank that receives farcalls. Tables are contiguous, are limited to
        $4000-$40ff (the slot operand is one byte), and end where their
        lowest pointer target begins — so shrink a candidate extent to a
        fixed point where every entry before the end points at-or-after the
        end and decodes as valid code. Banks whose proven region contains
        junk are left alone. Returns {entry_flat: (bank, slot, target_flat)}
        for the unused slots of consistent tables.
        """
        from collections import defaultdict
        used = defaultdict(set)
        for off, (bank, slot, _entry, _target) in self.farcalls.items():
            if off in self.instrs:
                used[bank].add(slot)
        self.inferred_entries = {}
        for bank, slots in sorted(used.items()):
            base = bank * BANK_SIZE
            floor = max(slots) + 2

            def entry_cpu(s):
                return self.rom[base + s] | (self.rom[base + s + 1] << 8)

            min_used = min(entry_cpu(s) for s in slots)
            if min_used - BANK_SIZE < floor:
                continue  # a used target lands inside the proven table region
            if min_used - BANK_SIZE > 0x100:
                # lowest used target doesn't delimit the table (it lies beyond
                # the one-byte slot window): no evidence past the used slots,
                # so only infer the gaps between them
                extent = floor
            else:
                extent = min_used - BANK_SIZE
            dirty = False
            changed = True
            while changed and not dirty:
                changed = False
                for s in range(0, extent, 2):
                    cpu = entry_cpu(s)
                    flat = base + cpu - BANK_SIZE
                    ok = (BANK_SIZE + floor <= cpu < 0x8000
                          and sm83.decode(self.rom, flat, cpu).valid)
                    if ok and cpu - BANK_SIZE < extent:
                        extent = cpu - BANK_SIZE
                        changed = True
                        break
                    if not ok:
                        if s < floor:
                            dirty = True  # junk inside the proven region
                        else:
                            extent = s    # table truncated by first bad entry
                            changed = True
                        break
            if dirty or extent < floor:
                continue
            for s in range(0, extent, 2):
                if s in slots:
                    continue
                cpu = entry_cpu(s)
                self.inferred_entries[base + s] = (bank, s, base + cpu - BANK_SIZE)
        seeded = 0
        for _entry, (_bank, _slot, target) in sorted(self.inferred_entries.items()):
            if target in self.instrs:
                continue
            ins = self.decode_at(target)
            if ins.valid and not self.conflicts(target, ins):
                self.mark(target, ins)
                seeded += 1
        print(f"inferred {len(self.inferred_entries)} unused farcall-table entries "
              f"({seeded} new code seeds)")

    def _shape(self, off, n=12):
        """Opcode-shape fingerprint: n instruction opcodes with operands
        wildcarded, or None if anything decodes invalid."""
        shape = []
        for _ in range(n):
            if off + 1 >= len(self.rom):
                return None
            ins = sm83.decode(self.rom, off, offset_to_cpu(off))
            if not ins.valid:
                return None
            shape.append(self.rom[off])
            if self.rom[off] == 0xCB:
                shape.append(self.rom[off + 1])
            if ins.ends_flow and not ins.is_cond:
                break
            off += ins.size
        return tuple(shape)

    def infer_twin_tables(self):
        """Find untraced banks that are structural twins of traced ones.

        Several groups of data banks each carry a relocated copy of the same
        bank-local helper, dispatched via farcall slot 0 (e.g. the $a0-byte
        OAM-frame loader in banks $25/$26/$30-$37/$6e). For banks with no
        traced farcall usage, accept the dw at $4000 as a slot-0 table entry
        if its target's opcode shape exactly matches a traced bank's slot-0
        target. Seeds the twins' helpers as code.
        """
        used_banks = {bank for off, (bank, _s, _e, _t) in self.farcalls.items()
                      if off in self.instrs}
        fingerprints = {}
        for off, (bank, slot, _entry, target) in self.farcalls.items():
            if off in self.instrs and slot == 0:
                sh = self._shape(target)
                if sh:
                    fingerprints.setdefault(sh, bank)
        found = 0
        for bank in range(1, len(self.rom) // BANK_SIZE):
            if bank in used_banks:
                continue
            base = bank * BANK_SIZE
            cpu = self.rom[base] | (self.rom[base + 1] << 8)
            if not (BANK_SIZE + 2 <= cpu < 0x8000):
                continue
            target = base + cpu - BANK_SIZE
            sh = self._shape(target)
            if sh is None or sh not in fingerprints:
                continue
            self.inferred_entries[base] = (bank, 0, target)
            ins = self.decode_at(target)
            if ins.valid and not self.conflicts(target, ins):
                self.mark(target, ins)
            found += 1
            print(f"  bank ${bank:02x}: slot-0 twin of bank "
                  f"${fingerprints[sh]:02x} (target ${cpu:04x})")
        print(f"twin-bank scan: {found} untraced twin banks seeded")
        return found

    def parse_jumptables(self):
        """Parse the inline dw jump tables that follow rst $00 sites.

        JumpTableDispatch indexes the table at the return address by `a`, so
        the table starts at site+1 and its length is not encoded. Delimit it
        the same way as the farcall tables: entries must map to valid code in
        the site's address space, the table cannot extend past its own lowest
        forward target (handlers usually follow the table), and it stops at
        any already-known code. Tables whose accepted region would contain
        one of their own targets are dropped entirely. Returns the number of
        new code seeds marked.
        """
        new_entries = {}
        for off in [o for o, i in self.instrs.items()
                    if self.rom[o] == 0xC7 and i.size == 1]:
            if off + 1 in self.jt_entries:
                continue  # already parsed
            pos = off + 1
            min_fwd = None
            entries = []
            while pos + 1 < len(self.rom) and len(entries) < 128:
                if pos in self.code_bytes or pos in self.jt_entries:
                    break
                if min_fwd is not None and pos >= min_fwd:
                    break
                cpu = self.rom[pos] | (self.rom[pos + 1] << 8)
                t = target_to_offset(cpu, off)
                if t is None or t + 1 >= len(self.rom):
                    break
                if not sm83.decode(self.rom, t, offset_to_cpu(t)).valid:
                    break
                entries.append((pos, t))
                if t > off and (min_fwd is None or t < min_fwd):
                    min_fwd = t
                pos += 2
            if min_fwd is not None:
                entries = [(p, t) for p, t in entries if p + 1 < min_fwd]
            table_end = off + 1 + 2 * len(entries)
            if any(off < t < table_end for _p, t in entries):
                continue  # a target inside the accepted table: inconsistent
            for p, t in entries:
                new_entries[p] = t
        self.jt_entries.update(new_entries)
        seeded = 0
        for t in sorted({t for t in new_entries.values()}):
            if t in self.instrs:
                continue
            ins = self.decode_at(t)
            if ins.valid and not self.conflicts(t, ins):
                self.mark(t, ins)
                seeded += 1
        print(f"parsed {len(new_entries)} inline jump-table entries "
              f"({seeded} new code seeds)")
        return seeded + len(new_entries)

    def descend(self):
        work = list(self.instrs.keys())
        added = 0
        while work:
            off = work.pop()
            ins = self.instrs[off]
            succs = []
            if not ins.ends_flow:
                succs.append(off + ins.size)
            if ins.target is not None and (ins.is_jump or ins.is_call):
                t = target_to_offset(ins.target, off)
                if t is not None:
                    succs.append(t)
            if off in self.farcalls:  # proven cross-bank pointer-table target
                succs.append(self.farcalls[off][3])
            for s in succs:
                if s in self.instrs or s >= len(self.rom):
                    continue
                nins = self.decode_at(s)
                if not nins.valid or self.conflicts(s, nins):
                    continue
                # never let descent cross a bank boundary mid-run
                if (s // BANK_SIZE) != ((s + nins.size - 1) // BANK_SIZE):
                    continue
                self.mark(s, nins)
                work.append(s)
                added += 1
        print(f"descent added {added} instructions")


VECTOR_LABELS = {
    0x00: "Rst00", 0x08: "Rst08", 0x10: "Rst10", 0x18: "Rst18",
    0x20: "Rst20", 0x28: "Rst28", 0x30: "Rst30", 0x38: "Rst38",
    0x40: "VBlankInterrupt", 0x48: "LCDStatInterrupt", 0x50: "TimerInterrupt",
    0x58: "SerialInterrupt", 0x60: "JoypadInterrupt", 0x100: "EntryPoint",
}


def load_hwregs(path):
    """Map $ff00-$ffff addresses to hardware.inc register names."""
    import re
    regs = {}
    if not Path(path).exists():
        return regs
    for m in re.finditer(r"^DEF\s+(r\w+)\s+EQU\s+\$(ff[0-9a-f]{2})\b",
                         Path(path).read_text(), re.MULTILINE | re.IGNORECASE):
        regs.setdefault(int(m.group(2), 16), m.group(1))
    return regs


def load_ram_map(path, consts_out):
    """Map RAM addresses to names from ram_map.json; emit the DEF constants file."""
    if not Path(path).exists():
        return {}
    entries = json.loads(Path(path).read_text())
    names = {}
    lines = [
        "; RAM symbol constants generated from ram_map.json (RetroAchievements",
        "; Code Notes). Regenerated by tools/disasm.py; do not edit by hand.",
        "",
    ]
    for addr_s, e in sorted(entries.items(), key=lambda kv: int(kv[0], 0)):
        name = e.get("name")
        if not name:
            continue
        addr = int(addr_s, 0)
        names[addr] = name
        lines.append(f"DEF {name} EQU ${addr:04x}")
    Path(consts_out).write_text("\n".join(lines) + "\n")
    return names


def build_labels(dis, overrides=None):
    labels = {}
    for off, name in VECTOR_LABELS.items():
        if off in dis.instrs:
            labels[off] = name
    if overrides:
        labels.update({int(k, 0): v for k, v in overrides.items()})
    for off, ins in dis.instrs.items():
        if ins.target is None or not (ins.is_jump or ins.is_call):
            continue
        t = target_to_offset(ins.target, off)
        if t is None or t not in dis.instrs:
            continue
        cpu = offset_to_cpu(t)
        bank = t // BANK_SIZE
        name = f"Func_{bank:02x}_{cpu:04x}" if ins.is_call else f"Label_{bank:02x}_{cpu:04x}"
        prev = labels.get(t)
        if prev is None:
            labels[t] = name
        elif prev.startswith("Label_") and name.startswith("Func_"):
            labels[t] = name
    far_targets = [(bank, target) for off, (bank, _s, _e, target) in dis.farcalls.items()
                   if off in dis.instrs]
    far_targets += [(bank, target) for bank, _s, target in dis.inferred_entries.values()]
    for bank, target in far_targets:
        if target not in dis.instrs:
            continue
        name = f"Func_{bank:02x}_{offset_to_cpu(target):04x}"
        prev = labels.get(target)
        if prev is None or prev.startswith("Label_"):
            labels[target] = name
    for target in dis.jt_entries.values():
        if target in dis.instrs and target not in labels:
            labels[target] = f"Label_{target // BANK_SIZE:02x}_{offset_to_cpu(target):04x}"
    return labels


def render_operand(ins, off, labels, hwregs, ramnames):
    text = ins.text
    if "$ff" in text and hwregs:
        m = HWADDR_RE.search(text)
        if m:
            addr = int(m.group(0)[1:], 16)
            if addr in hwregs:
                text = text.replace(m.group(0), hwregs[addr])
    if ramnames and "[$" in text:
        m = MEMADDR_RE.search(text)
        if m:
            addr = int(m.group(1), 16)
            if addr in ramnames:
                text = text.replace(f"[${m.group(1)}]", f"[{ramnames[addr]}]")
    if ins.target is None:
        return text
    t = target_to_offset(ins.target, off)
    if t is not None and t in labels:
        return text.replace("{target}", labels[t])
    width = 2 if text.startswith("rst") else 4
    return text.replace("{target}", f"${ins.target:0{width}x}")


MACROS_INC = """\
; Generated by tools/disasm.py; do not edit by hand.

; Bank-switched call through the FarCall trampoline ($01b6, vectored from
; rst $18): two inline operand bytes select a dw entry in the target bank's
; pointer table at $4000 (FarPtr_* labels). The trampoline switches banks,
; dispatches through the table, and patches the return address past the
; operands.
MACRO farcall
	rst Rst18
	db LOW(\\1), BANK(\\1)
ENDM

; Sound/music command (handler $2fb3): one inline id byte.
MACRO sound
	rst Rst08
	db \\1
ENDM

; rst $20/$28/$30 ($255e/$256b/$2551): three related commands sharing an
; operand fetcher ($253d) that reads one inline dw pointer into de.
MACRO rst20
	rst Rst20
	dw \\1
ENDM

MACRO rst28
	rst Rst28
	dw \\1
ENDM

MACRO rst30
	rst Rst30
	dw \\1
ENDM
"""


def emit(dis, labels, hwregs, ramnames, srcdir, manifest_path):
    rom = dis.rom
    nbanks = len(rom) // BANK_SIZE
    manifest = []

    # Farcall pointer-table slots referenced by live call sites. A slot is
    # emitted as a labeled dw only if nothing else already claimed its bytes
    # as code; sites whose slot can't be emitted fall back to raw bytes.
    table_entries = {}  # entry_flat -> (bank, slot, target_flat)
    dirty_sites = set()
    for off, (bank, slot, entry, target) in dis.farcalls.items():
        if off not in dis.instrs:
            continue
        if entry in dis.code_bytes or entry + 1 in dis.code_bytes:
            dirty_sites.add(off)
        else:
            table_entries[entry] = (bank, slot, target)
    for entry, (bank, slot, target) in dis.inferred_entries.items():
        if entry not in dis.code_bytes and entry + 1 not in dis.code_bytes:
            table_entries.setdefault(entry, (bank, slot, target))
    jt_entries = {p: t for p, t in dis.jt_entries.items()
                  if p not in dis.code_bytes and p + 1 not in dis.code_bytes
                  and p not in table_entries}
    Path(srcdir).parent.joinpath("include", "macros.inc").write_text(MACROS_INC)

    for bank in range(nbanks):
        base = bank * BANK_SIZE
        lines = ['INCLUDE "hardware.inc"', 'INCLUDE "macros.inc"']
        if ramnames:
            lines.append('INCLUDE "ram_constants.asm"')
        lines.append("")
        if bank == 0:
            lines.append('SECTION "ROM Bank $00", ROM0[$0000]')
        else:
            lines.append(f'SECTION "ROM Bank ${bank:02x}", ROMX[$4000], BANK[${bank:02x}]')
        lines.append("")
        off = base
        end = base + BANK_SIZE
        while off < end:
            if off in table_entries:
                tbank, slot, target = table_entries[off]
                tl = labels.get(target, f"${offset_to_cpu(target):04x}")
                lines.append(f"FarPtr_{tbank:02x}_{slot:02x}:")
                lines.append(f"\tdw {tl} ; ${offset_to_cpu(off):04x}")
                off += 2
            elif off in jt_entries:
                target = jt_entries[off]
                tl = labels.get(target, f"${offset_to_cpu(target):04x}")
                lines.append(f"\tdw {tl} ; ${offset_to_cpu(off):04x} jumptable")
                off += 2
            elif off in dis.instrs:
                if off in labels:
                    lines.append(f"{labels[off]}:")
                ins = dis.instrs[off]
                cpu = offset_to_cpu(off)
                if off in dis.farcalls and ins.text == "farcall {far}":
                    fbank, slot, entry, _target = dis.farcalls[off]
                    if off in dirty_sites:
                        lines.append(f"\trst Rst18 ; ${cpu:04x}")
                        lines.append(f"\tdb ${slot:02x}, ${fbank:02x} ; farcall operands (slot bytes overlap code)")
                    else:
                        lines.append(f"\tfarcall FarPtr_{fbank:02x}_{slot:02x} ; ${cpu:04x}")
                else:
                    lines.append(f"\t{render_operand(ins, off, labels, hwregs, ramnames)} ; ${cpu:04x}")
                off += ins.size
            else:
                run_start = off
                while off < end and off not in dis.instrs \
                        and off not in table_entries and off not in jt_entries:
                    off += 1
                length = off - run_start
                cpu = offset_to_cpu(run_start)
                blob = f"bank_{bank:03x}/d_{cpu:04x}.bin"
                manifest.append((blob, run_start, length))
                lines.append(f'\tINCBIN "data/{blob}" ; ${cpu:04x}, {length} bytes')
        lines.append("")
        Path(srcdir, f"bank_{bank:03x}.asm").write_text("\n".join(lines))
    with open(manifest_path, "w") as f:
        f.write("# path  rom_offset(hex)  length(hex) — consumed by tools/extract.py\n")
        for blob, o, l in manifest:
            f.write(f"{blob} {o:06x} {l:x}\n")
    ncode = sum(i.size for i in dis.instrs.values())
    print(f"emitted {nbanks} banks: {len(dis.instrs)} instructions "
          f"({ncode} bytes code, {len(rom)-ncode} bytes data, {len(manifest)} blobs)")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("rom")
    ap.add_argument("coverage", nargs="+")
    ap.add_argument("--srcdir", default="src")
    ap.add_argument("--manifest", default="data.manifest")
    ap.add_argument("--labels", default="labels.json")
    ap.add_argument("--hardware-inc", default="include/hardware.inc")
    ap.add_argument("--ram-map", default="ram_map.json")
    ap.add_argument("--no-descent", action="store_true")
    args = ap.parse_args()

    rom = Path(args.rom).read_bytes()
    dis = Disassembly(rom)
    seeds = load_coverage(args.coverage, len(rom) // BANK_SIZE)
    print(f"{len(seeds)} coverage seeds")
    dis.seed(seeds)
    if not args.no_descent:
        dis.descend()
        dis.infer_tables()
        dis.descend()
        if dis.infer_twin_tables():
            dis.descend()
        # jump tables and descent feed each other; iterate to a fixed point
        for _ in range(8):
            if not dis.parse_jumptables():
                break
            dis.descend()
    overrides = None
    if Path(args.labels).exists():
        overrides = json.loads(Path(args.labels).read_text())
    labels = build_labels(dis, overrides)
    hwregs = load_hwregs(args.hardware_inc)
    ramnames = load_ram_map(args.ram_map, "include/ram_constants.asm")
    Path(args.srcdir).mkdir(parents=True, exist_ok=True)
    emit(dis, labels, hwregs, ramnames, args.srcdir, args.manifest)


if __name__ == "__main__":
    main()
