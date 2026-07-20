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
LDIMM_RE = re.compile(r"^ld (hl|de|bc), \$([0-9a-f]{1,4})$")

sys.path.insert(0, str(Path(__file__).parent))
import lz
import sm83
from extract import render_spec

BANK_SIZE = 0x4000

# Unclassified data runs this short (alignment padding, stray constants
# between code) render as inline `db` instead of a standalone blob file.
INLINE_DB_MAX = 2

# Backtracking classification for the register-setup scan at data-helper
# call sites: `ld r16, imm` opcodes we can harvest, opcodes that clobber a
# pair (making an earlier constant unreliable), and opcodes that touch none
# of bc/de/hl and may be stepped over. Anything else ends the scan.
PAIR_IMM = {0x01: "bc", 0x11: "de", 0x21: "hl"}
PAIR_WRITES = {
    "bc": {0xC1, 0x03, 0x0B, 0x04, 0x05, 0x0C, 0x0D, 0x06, 0x0E}
          | set(range(0x40, 0x50)),
    "de": {0xD1, 0x13, 0x1B, 0x14, 0x15, 0x1C, 0x1D, 0x16, 0x1E}
          | set(range(0x50, 0x60)),
    "hl": {0xE1, 0x23, 0x2B, 0x24, 0x25, 0x2C, 0x2D, 0x26, 0x2E,
           0x09, 0x19, 0x29, 0x39, 0xF8, 0x2A, 0x3A, 0x22, 0x32}
          | set(range(0x60, 0x70)),
}
SAFE_OPS = (
    {0x00, 0x02, 0x12, 0x0A, 0x1A, 0x3E, 0x3C, 0x3D, 0x34, 0x35,
     0xE0, 0xF0, 0xE2, 0xF2, 0xEA, 0xFA, 0xC5, 0xD5, 0xE5, 0xF5, 0xF1,
     0x31, 0x08, 0xF9, 0x07, 0x0F, 0x17, 0x1F, 0x27, 0x2F, 0x37, 0x3F,
     0xC6, 0xCE, 0xD6, 0xDE, 0xE6, 0xEE, 0xF6, 0xFE}
    | set(range(0x70, 0x76)) | {0x77} | set(range(0x78, 0x80))
    | set(range(0x80, 0xC0))
)


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


def _writes_hl(text):
    """True if an instruction modifies hl (so a preceding `ld hl, imm` no longer
    holds that immediate). Covers reloads, arithmetic, inc/dec, hl+/- accesses,
    pop hl, and 8-bit writes to h or l."""
    return (text.startswith(("ld hl", "add hl", "inc hl", "dec hl",
                             "ld l,", "ld h,", "inc l", "inc h",
                             "dec l", "dec h", "pop hl"))
            or "[hl+]" in text or "[hl-]" in text)


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
        self.inline_arg_calls = {}  # call site offset -> inline arg byte
        self.inferred_entries = {}  # entry_flat -> (bank, slot, target_flat)
        self.jt_entries = {}  # rst $00 inline jump-table entry offset -> target_flat
        self.data_boundaries = set()  # declared data-table offsets (data_tables.json)
        self.data_slots = {}  # entry_flat -> (bank, slot, src_flat, kind)
        self.data_blobs = {}  # src_flat -> (length or None, kind)
        self.object_headers = set()  # src_flat of 16-byte object headers
        self.sprite_templates = set()  # src_flat of QueueSpriteTemplate lists
        self.data_site_notes = {}  # `ld hl` setup offset -> (bank, slot)
        self.ptr_words = {}   # word offset -> (target_flat or None, note)
        self.ptr_labels = {}  # flat offset -> generated structure label
        self.slot_record_tables = {}  # base flat -> words per record
        self.sprite_banks = set()

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
        if self.rom[target] == 0xFF:  # rst $38: padding, never a real entry
            return None
        if self.rom[target] == 0 and self.rom[target + 1] == 0:
            return None  # nop; nop: zero-filled data, not a function
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
        elif op == 0xCD and off + 4 <= len(self.rom) \
                and off // BANK_SIZE == (off + 3) // BANK_SIZE \
                and (self.rom[off+1] | (self.rom[off+2] << 8)) in self.INLINE_ARG_CALLS:
            # call to a ROM0 helper that reads one inline byte after the
            # call and bumps its return address past it (Func_00_2725), so
            # the operand byte is data, not the next instruction.
            self.inline_arg_calls[off] = self.rom[off+3]
            return sm83.Instr(4, "call {target}",
                              self.rom[off+1] | (self.rom[off+2] << 8),
                              True, False, False, False)
        elif op in (0xE7, 0xEF, 0xF7) and off + 3 <= len(self.rom) \
                and off // BANK_SIZE == (off + 2) // BANK_SIZE \
                and self.rom[off + 1] & 0x1F == 0:
            # rst $20/$28/$30: event-flag set/clear/test on the wGameFlags
            # array. Inline operands: bit selector in the top 3 bits of the
            # first byte (mask = $80 >> bit), flag byte index in the second.
            bit, byte = self.rom[off + 1] >> 5, self.rom[off + 2]
            name = {0xE7: "set_flag", 0xEF: "clear_flag", 0xF7: "test_flag"}[op]
            return sm83.Instr(3, f"{name} ${byte:02x}, {bit}",
                              None, True, False, False, False)
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

    # Seeds proven misattributed: a corrupted native-trace line whose byte
    # check degenerated to a single opcode byte landed one "executed"
    # address in bank $65, an otherwise pure data bank (it grew the phantom
    # farcall that fabricated bank $43's zero-array function). $67682 is the
    # sole seed in bank $19 (cutscene graphics) -- mid-blob, decoding as
    # nonsense (ld hl,sp-17 / add sp,100) inside the $6a10 data region.
    # $24f99 and $252b5 are lone seeds inside bank $09's VRAM tileset
    # ($488a table -> $4900-$60ff tiles, copied by Func_09_4873): trace
    # data-reads during the copy, not execution -- they split the one blob
    # into three and decode graphics bytes as rst/inc.
    BAD_SEEDS = {0x19617F, 0x67682, 0x24F99, 0x252B5}

    # ROM0 helpers that consume one inline byte after the `call` (they read
    # the byte at the return address and step the return past it). The byte
    # is data; without this the decoder would treat it as the next opcode.
    INLINE_ARG_CALLS = {0x2725}

    def seed(self, seeds):
        bad = 0
        seeds = set(seeds) - self.BAD_SEEDS
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

    def _looks_like_data_pointer(self, cpu, flat):
        """A table slot whose target (already known not to decode as code)
        is a valid LZ stream is a data-pointer entry, not junk. Lets
        infer_tables tolerate a data-pointer block inside an otherwise
        code-pointer table without abandoning the whole bank."""
        if not (BANK_SIZE <= cpu < 0x8000):
            return False
        try:
            lz.decompress(self.rom, flat, (flat // BANK_SIZE + 1) * BANK_SIZE)
        except (ValueError, IndexError):
            return False
        return True

    def infer_tables(self):
        """Infer unused farcall-table entries from table shape.

        Live call sites prove a table spans $4000..(max used slot)+2 in each
        bank that receives farcalls. Tables are contiguous, are limited to
        $4000-$40ff (the slot operand is one byte), and end where their
        lowest pointer target begins — so shrink a candidate extent to a
        fixed point where every entry before the end points at-or-after the
        end and decodes as valid code. Banks whose proven region contains
        junk are left alone. A mixed table (a block of data pointers among
        the code pointers, e.g. graphics streams) ends the code run at the
        first data-pointer slot: the code prefix is still recovered even
        when a later used slot pushes the floor past the data block.
        Returns {entry_flat: (bank, slot, target_flat)} for the unused slots
        of consistent tables.
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
            data_block = False
            changed = True
            while changed and not dirty:
                changed = False
                for s in range(0, extent, 2):
                    if base + s in self.data_slots:
                        continue  # proven data slot (slot-record tables)
                    cpu = entry_cpu(s)
                    flat = base + cpu - BANK_SIZE
                    ok = (BANK_SIZE + floor <= cpu < 0x8000
                          and self.rom[flat] != 0xFF
                          and not (self.rom[flat] == 0 and self.rom[flat + 1] == 0)
                          and sm83.decode(self.rom, flat, cpu).valid)
                    if ok and cpu - BANK_SIZE < extent:
                        extent = cpu - BANK_SIZE
                        changed = True
                        break
                    if not ok:
                        # First slot pointing at a decodable LZ stream: the
                        # code-pointer run ends here, at a data-pointer block
                        # (e.g. graphics pointers following the code table).
                        # Recover the code prefix even though a later used
                        # slot pushes `floor` past this data block.
                        if self._looks_like_data_pointer(cpu, flat):
                            extent = s
                            data_block = True
                            changed = True
                        elif s < floor:
                            dirty = True  # junk inside the proven region
                        else:
                            extent = s    # table truncated by first bad entry
                            changed = True
                        break
            if dirty or (extent < floor and not data_block):
                continue
            for s in range(0, extent, 2):
                if s in slots or base + s in self.data_slots:
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
                if pos in self.data_boundaries:
                    break  # a declared data table delimits the jump table
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
        # Computed jp hl dispatchers: ld hl,TABLE / add a,l / ld l,a /
        # jr nc,+ / inc h / ld a,[hl+] / ld h,[hl] / ld l,a / jp hl. The table
        # base is the ld hl operand and its length is unencoded, so delimit it
        # exactly like the rst $00 tables (self-lowest-forward-target).
        JPHL = b"\x85\x6f\x30\x01\x24\x2a\x66\x6f\xe9"
        for off in [o for o in self.instrs if self.rom[o] == 0x21
                    and self.rom[o + 3:o + 3 + len(JPHL)] == JPHL]:
            cpu0 = self.rom[off + 1] | (self.rom[off + 2] << 8)
            if not (BANK_SIZE <= cpu0 < 0x8000):
                continue
            tbl = (off // BANK_SIZE) * BANK_SIZE + cpu0 - BANK_SIZE
            if tbl in self.jt_entries:
                continue
            pos = tbl
            min_fwd = None
            entries = []
            while pos + 1 < len(self.rom) and len(entries) < 128:
                if pos in self.code_bytes or pos in self.jt_entries:
                    break
                if pos in self.data_boundaries:
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
                if t > tbl and (min_fwd is None or t < min_fwd):
                    min_fwd = t
                pos += 2
            if min_fwd is not None:
                entries = [(p, t) for p, t in entries if p + 1 < min_fwd]
            table_end = tbl + 2 * len(entries)
            if any(tbl < t < table_end for _p, t in entries):
                continue
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

    def _backtrack_consts(self, site):
        """Walk linearly backward from `site` collecting bc/de/hl constants.

        Stops at block boundaries (control flow, branch targets, anything
        not provably register-transparent); a non-immediate write to a pair
        marks it dynamic so an earlier constant is not misattributed.
        Returns ({pair: value}, {pair: ld_offset}).
        """
        regs, ld_offs, done = {}, {}, set()
        off = site
        while len(done) < 3:
            off = self._preds.get(off)
            if off is None:
                break
            op = self.rom[off]
            pair = PAIR_IMM.get(op)
            if pair is not None:
                if pair not in done:
                    done.add(pair)
                    regs[pair] = self.rom[off + 1] | (self.rom[off + 2] << 8)
                    ld_offs[pair] = off
            else:
                clobbered = [p for p, ops in PAIR_WRITES.items() if op in ops]
                if clobbered:
                    done.update(clobbered)
                elif op not in SAFE_OPS:
                    break
            if off in self._branch_targets:
                break
        return regs, ld_offs

    def find_data_slots(self, helpers):
        """Prove pointer-table slots to be data via the loader helpers.

        CopyDataFromBank/DecompressDataFromBank take h = bank and l = slot of
        a $4000-table entry whose pointer they read as a data source (bc =
        byte count for the copier). Backtracking constant register setups at
        their call sites yields (bank, slot) pairs statically, marking those
        table entries as data pointers and their targets as blobs -- with an
        exact extent when the stream length (LZ) or bc (copy) is known.
        """
        self._preds = {off + ins.size: off for off, ins in self.instrs.items()}
        self._branch_targets = set()
        for off, ins in self.instrs.items():
            if ins.target is not None and (ins.is_jump or ins.is_call):
                t = target_to_offset(ins.target, off)
                if t is not None:
                    self._branch_targets.add(t)
        nbanks = len(self.rom) // BANK_SIZE
        sites = resolved = 0
        for off, ins in sorted(self.instrs.items()):
            if ins.target is None or not (ins.is_call or ins.is_jump):
                continue
            kind = helpers.get(target_to_offset(ins.target, off))
            if kind is None:
                continue
            sites += 1
            regs, ld_offs = self._backtrack_consts(off)
            hl = regs.get("hl")
            if hl is None:
                continue
            if self._add_data_slot(hl >> 8, hl & 0xFF, kind,
                                   regs.get("bc")) is None:
                continue
            resolved += 1
            if "hl" in ld_offs:
                self.data_site_notes[ld_offs["hl"]] = (hl >> 8, hl & 0xFF)
        print(f"data-helper call sites: {sites}, statically resolved: "
              f"{resolved} ({len(self.data_slots)} slots, "
              f"{len(self.data_blobs)} blobs)")

    # Bank $04's $4f75 sprite/object dispatch table: (slot, bank) words that a
    # runtime-indexed loader copies as 16-byte object headers to $dad0. The
    # dynamic index defeats static backtracking, so without a hook a slot's
    # 16-byte copy length is unknown and its region stays one blob instead of
    # header + body. Read the table so every object bank ($6f-$77) splits its
    # headers uniformly, not just the slots the capture sessions happened to
    # load. Excludes the character banks $40-$5d, which the same table lists
    # but find_sprite_banks carves with a richer per-frame structure.
    OBJECT_DISPATCH = 0x10F75  # bank $04, $4f75
    OBJECT_BANKS = range(0x70, 0x77)  # $70-$76; $6a/$6f/$77 via find_walk_sprite_banks

    def add_object_header_slots(self):
        off = self.OBJECT_DISPATCH
        added = 0
        while off + 1 < len(self.rom):
            w = self.rom[off] | (self.rom[off + 1] << 8)
            if w == 0:
                break
            slot, bank = w & 0xFF, w >> 8
            off += 2
            if bank in self.OBJECT_BANKS:
                src = self._add_data_slot(bank, slot, "copy", 16)
                if src is not None:
                    self.object_headers.add(src)
                    added += 1
        if added:
            print(f"object headers: {added} $70-$76 slots via $4f75 dispatch table")

    # Record tables of (bank<<8|slot) words whose loaders read each word
    # through RAM (e.g. LoadScreenAssetRecord, $39:$407e: lz tiles, lz
    # tilemap, lz attrmap, then a 64-byte palette set for LoadPaletteShadow,
    # one record per screen id), so no helper call site ever holds a constant
    # hl and static backtracking never proves the slots. Keyed by curated
    # label so the address lives in labels.json; the extent is walked until
    # proven code (the next routine delimits the table). Records whose
    # targets don't all validate (placeholder records point at code/junk)
    # are skipped whole; runs of them occur mid-table, so only the code
    # boundary ends the walk (validation needs multiple clean lz decodes,
    # so junk past an unproven end can't slip through as records).
    SLOT_RECORD_TABLES = {
        "ScreenAssetRecordTable": ("lz", "lz", "lz", ("copy", 64)),
    }
    # Same rendering, but no slot proving: tables whose columns aren't one
    # fixed kind (SceneGfxSlotTable's +$8/+$a slots are copied raw by the
    # match loader but lz-decompressed by the story loader, and +$c is never
    # read). Their slots are proven elsewhere (hooks, bank bootstrap).
    SLOT_RECORD_RENDERS = {
        "SceneGfxSlotTable": 8,  # words per record
        # LoadCompressedTileBlock ($39:$468b) indexes this by b*2, then reads
        # the (bank, slot) word as h:l into DecompressDataFromBank -- one
        # $4000-table data slot per record.
        "TileBlockPtrs_39": 1,
    }

    def add_slot_record_tables(self, overrides):
        bases = {v: int(k, 0) for k, v in (overrides or {}).items()}
        for name, nwords in self.SLOT_RECORD_RENDERS.items():
            if name in bases:
                self.slot_record_tables[bases[name]] = nwords
        for name, kinds in self.SLOT_RECORD_TABLES.items():
            base = bases.get(name)
            if base is None:
                continue
            self.slot_record_tables[base] = len(kinds)
            stride = 2 * len(kinds)
            bank_end = (base // BANK_SIZE + 1) * BANK_SIZE
            added = skipped = 0
            for off in range(base, bank_end - stride + 1, stride):
                if any(b in self.code_bytes for b in range(off, off + stride)):
                    break
                words = [self.rom[off + i] | (self.rom[off + i + 1] << 8)
                         for i in range(0, stride, 2)]
                if not self._valid_slot_record(words, kinds):
                    skipped += 1
                    continue
                for w, kind in zip(words, kinds):
                    kind, length = kind if isinstance(kind, tuple) \
                        else (kind, None)
                    if self._add_data_slot(w >> 8, w & 0xFF, kind, length):
                        added += 1
            print(f"slot records: {added} slots via {name} "
                  f"({skipped} placeholder records skipped)")

    def _valid_slot_record(self, words, kinds):
        for w, kind in zip(words, kinds):
            bank, slot = w >> 8, w & 0xFF
            if not 0 < bank < len(self.rom) // BANK_SIZE or slot & 1:
                return False
            entry = bank * BANK_SIZE + slot
            ptr = self.rom[entry] | (self.rom[entry + 1] << 8)
            if not (BANK_SIZE <= ptr < 0x8000):
                return False
            src = bank * BANK_SIZE + ptr - BANK_SIZE
            if src in self.code_bytes:
                return False
            if kind == "lz":
                try:
                    lz.decompress(self.rom, src, (bank + 1) * BANK_SIZE)
                except ValueError:
                    return False
        return True

    def split_object_bodies(self):
        """Split each object body at the addresses its 16-byte header points
        to, so the header's dw entries resolve to labels. One level only: the
        header's own six pointers, not the arrays those in turn reach."""
        starts = sorted(self.object_headers)
        added = 0
        for i, h in enumerate(starts):
            bank = h // BANK_SIZE
            nxt = starts[i + 1] if i + 1 < len(starts) else len(self.rom)
            rend = nxt if nxt // BANK_SIZE == bank else (bank + 1) * BANK_SIZE
            for j in range(6):
                w = self.rom[h + 4 + 2 * j] | (self.rom[h + 5 + 2 * j] << 8)
                tgt = bank * BANK_SIZE + w - BANK_SIZE
                if h + 16 <= tgt < rend and tgt not in self.data_blobs:
                    self.data_blobs[tgt] = (None, "copy")
                    added += 1
        if added:
            print(f"object bodies: {added} splits at header pointers")

    def follow_oam_arrays(self):
        """Follow each header's OAM pointer array (word 1): a self-delimiting
        dw table (it ends where its lowest target begins) of pointers to the
        record's per-frame OAM sublists. Render the table as dw labels and
        split the OAM data it points at into blobs."""
        starts = sorted(self.object_headers)
        arrays = splits = 0
        for i, h in enumerate(starts):
            bank = h // BANK_SIZE
            base = bank * BANK_SIZE
            nxt = starts[i + 1] if i + 1 < len(starts) else len(self.rom)
            rend = nxt if nxt // BANK_SIZE == bank else (bank + 1) * BANK_SIZE
            astart = base + (self.rom[h + 6] | (self.rom[h + 7] << 8)) - BANK_SIZE
            if astart not in self.data_blobs or astart < h + 16:
                continue
            span = (base + (self.rom[astart] | (self.rom[astart + 1] << 8))
                    - BANK_SIZE) - astart  # table end = first (lowest) target
            if not 4 <= span <= 0x40 or span % 2:
                continue
            n = span // 2
            tgts = [base + (self.rom[astart + 2 * k] | (self.rom[astart + 2 * k + 1] << 8))
                    - BANK_SIZE for k in range(n)]
            if not all(astart + span <= t < rend for t in tgts):
                continue
            del self.data_blobs[astart]
            self.ptr_labels[astart] = f"OamPtrs_{bank:02x}_{offset_to_cpu(astart):04x}"
            for k in range(n):
                self.ptr_words[astart + 2 * k] = (tgts[k], "")
            arrays += 1
            for t in sorted(set(tgts)):
                if t not in self.data_blobs:
                    self.data_blobs[t] = (None, "copy")
                    splits += 1
        if arrays:
            print(f"oam arrays: {arrays} followed, {splits} OAM-data splits")

    def follow_frame_arrays(self):
        """Follow each header's inline frame-pointer array (words 0/2 point at
        offset $0a): dw entries -- the first three are header words 3-5, the
        rest spill into the body -- pointing at the record's 16x16 frame
        graphics. The array runs until the first non-pointer word (the frame
        data / $00 padding that follows) or until it reaches the graphics it
        points at. Render the body continuation as dw labels, split the
        frames."""
        starts = sorted(self.object_headers)
        splits = 0
        for i, h in enumerate(starts):
            bank = h // BANK_SIZE
            base = bank * BANK_SIZE
            nxt = starts[i + 1] if i + 1 < len(starts) else len(self.rom)
            rend = nxt if nxt // BANK_SIZE == bank else (bank + 1) * BANK_SIZE
            if base + (self.rom[h + 4] | (self.rom[h + 5] << 8)) - BANK_SIZE != h + 0x0A:
                continue
            tgts, p = [], h + 0x0A
            while True:
                w = self.rom[p] | (self.rom[p + 1] << 8)
                t = base + w - BANK_SIZE
                if not 0x4000 <= w < 0x8000 or not h + 0x10 <= t < rend:
                    break  # non-pointer: frame data or padding begins here
                if tgts and p >= min(tgts):
                    break  # reached the frames the table points at
                tgts.append(t)
                p += 2
            if len(tgts) < 3:
                continue
            for q in range(h + 0x10, p, 2):  # body continuation -> dw labels
                self.ptr_words[q] = (base + (self.rom[q] | (self.rom[q + 1] << 8))
                                     - BANK_SIZE, "")
            for t in sorted(set(tgts)):
                if t not in self.data_blobs:
                    self.data_blobs[t] = (None, "copy")
                    splits += 1
        if splits:
            print(f"frame arrays: {splits} frame splits")

    def _add_data_slot(self, bank, slot, kind, length=None):
        """Validate and record one data-pointer table slot; returns the
        blob's flat offset, or None if anything about it is implausible."""
        if not 0 < bank < len(self.rom) // BANK_SIZE or slot & 1:
            return None
        entry = bank * BANK_SIZE + slot
        if entry in self.code_bytes or entry + 1 in self.code_bytes:
            return None
        ptr = self.rom[entry] | (self.rom[entry + 1] << 8)
        if not (BANK_SIZE <= ptr < 0x8000):
            return None
        src = bank * BANK_SIZE + ptr - BANK_SIZE
        if src in self.code_bytes:
            return None
        if kind == "lz":
            try:
                _, length = lz.decompress(self.rom, src, (bank + 1) * BANK_SIZE)
            except ValueError:
                return None  # claimed stream doesn't decode: reject the slot
        if length and any(b in self.code_bytes
                          for b in range(src, src + length)):
            length = None  # keep the pointer, don't carve into code
        self.data_slots[entry] = (bank, slot, src, kind)
        prev = self.data_blobs.get(src)
        if prev is None or (prev[0] is None and length is not None):
            self.data_blobs[src] = (length, kind)
        return src

    def add_static_data_slots(self):
        """Data-pointer $4000-table slots the traces never exercise, so no
        hook proves them and they fall through to raw blobs. Bank $10's
        header is the story match-select sub-table directory: hooks resolve
        slots $02-$06, but slots $00 and $08-$0e (-> $4010/$57f6/$5a80/$61b1/
        $74a9, each a pointer sub-table) are only reached through RAM-driven
        dispatch. Register them as data slots so they render as DataPtr words
        over labeled sub-tables. Slot $00 -> $4010 is a 7-entry pointer table
        + records; the $40b0 setup routine that physically follows it is
        seeded directly in coverage/bank010_static_code.json (a coarse seed
        at $4010 previously swept the table in as mis-decoded code).
        Bank $0f's header is the 3-slot map-script directory (same shape as
        bank $0e's), reached only through the bank $0a story-location
        records (word +2 = bank:slot into CopyDataFromBank), so no static
        call site or hook resolves it."""
        slots = {0x10: (0x00, 0x08, 0x0a, 0x0c, 0x0e),
                 0x0f: (0x00, 0x02, 0x04),
                 0x14: (0x00, 0x02, 0x04, 0x06),
                 0x27: tuple(range(0x00, 0x18, 2))}
        # Bank $1b slots $2e-$3e are LZ-compressed 2bpp graphics streams
        # (each decompresses to a whole number of tiles). Banks $18/$3f slots
        # below are LZ tile blocks reached only through TileBlockPtrs_39
        # (LoadCompressedTileBlock, $39:$468b), so no hook resolves them.
        lz_slots = {0x1b: tuple(range(0x2e, 0x40, 2)),
                    0x18: (0x92, 0x94),
                    0x3f: (0x78,)}
        added = 0
        for bank, sl in slots.items():
            for slot in sl:
                if self._add_data_slot(bank, slot, "copy") is not None:
                    added += 1
        for bank, sl in lz_slots.items():
            for slot in sl:
                if self._add_data_slot(bank, slot, "lz") is not None:
                    added += 1
        if added:
            print(f"static data slots: {added} carved")

    def carve_gfx_pointer_sets(self):
        """Bank $16's match-result graphics tables select LZ tile streams the
        auto-carver leaves as records:2 blobs. Two shapes:
          $4e9d (LoadMatchResultGfxSet, $4e54): a self-delimiting dw pointer
            table indexes 6-byte descriptor records, each three dw pointers into
            a contiguous stream pool decompressed to VRAM $8900/$8a40/$9140.
          $60f1 (DecompressWinLosePortraitVariant, $60d5) and $6968
            (DecompressCharacterPortrait, $6955): self-delimiting dw pointer
            tables straight into a stream pool (portrait variants / character
            portraits).
        Carve each pool into labeled lz blobs (so the records/pointers reference
        them by name) and shrink each table region to a data table."""
        bank = 0x16
        base = bank * BANK_SIZE

        def flat(cpu):
            return base + cpu - BANK_SIZE

        def word(cpu):
            o = flat(cpu)
            return self.rom[o] | (self.rom[o + 1] << 8)

        def tile_pool(pool):
            # Decompress each stream to find its compressed length and register
            # it as an lz blob, stopping where the streams give way to code.
            o, n = flat(pool), 0
            while o < base + BANK_SIZE and o not in self.instrs:
                try:
                    _, clen = lz.decompress(self.rom, o, base + BANK_SIZE)
                except ValueError:
                    break
                self.data_blobs.setdefault(o, (clen, "lz"))
                o += clen
                n += 1
            return n

        total = 0
        # $4e9d: pointer table -> 6-byte records -> pool. Records run until the
        # lowest stream they point at; that is where the pool begins.
        rec_start = min(word(0x4e9d), word(0x4e9f))
        p, pool = rec_start, 0xFFFF
        while p < pool:
            pool = min(pool, word(p), word(p + 2), word(p + 4))
            p += 6
        total += tile_pool(pool)
        self.data_blobs[flat(0x4e9d)] = (flat(pool) - flat(0x4e9d), "copy")
        # Direct tables: lowest entry is the pool start.
        for tbl in (0x60f1, 0x6968):
            pool = min(word(tbl), word(tbl + 2))
            total += tile_pool(pool)
            self.data_blobs[flat(tbl)] = (flat(pool) - flat(tbl), "copy")
        print(f"gfx pointer sets: {total} lz streams carved")

    def carve_tilemap_dispatch(self):
        """Merge the L1/L2 pointer tables ($39:$4e60) and their record-list pool
        ($39:$50dc) into one tilemap_dispatch blob so the whole two-level
        structure renders with shared local labels (see render_tilemap_dispatch).
        The auto-carver splits it into a records:2 table and a bytes:6 pool."""
        bank = 0x39
        base = bank * BANK_SIZE
        tbl = base + 0x4e60 - BANK_SIZE
        pool = base + 0x50dc - BANK_SIZE
        if pool in self.data_blobs and tbl in self.data_blobs:
            plen = self.data_blobs[pool][0]
            del self.data_blobs[pool]
            self.data_blobs[tbl] = ((pool - tbl) + plen, "copy")

    def carve_sprite_templates(self, queue_flat):
        """Carve the operand of every `call QueueSpriteTemplate` ($00:$1e9d) as
        a sprite_template blob. The helper reads a list of 4-byte
        {dy, dx, tile, attr} OAM records from hl, stopping at a $80 dy byte;
        many lists sit packed back-to-back in an otherwise anonymous blob.
        Backtrack from each call to the nearest same-bank `ld hl, imm` (opcode
        $21) that sets the pointer, size the list by its $80 terminator, and
        register it (blobs already carved by an earlier pass are left alone)."""
        qcpu = offset_to_cpu(queue_flat)
        added = 0
        last_hl = None  # (bank, hl_end, cpu) of the most recent `ld hl, imm`
        for off in sorted(self.instrs):
            op = self.rom[off]
            if op == 0x21:  # ld hl, imm16 -- a direct pointer load
                cpu = self.rom[off + 1] | (self.rom[off + 2] << 8)
                last_hl = (off // BANK_SIZE, off + 3, cpu)
                continue
            # Any other write to hl (indexing a table, dereferencing, reload)
            # means the loaded imm is not the template pointer itself.
            if last_hl is not None and _writes_hl(self.instrs[off].text):
                last_hl = None
            if (op == 0xCD and last_hl is not None
                  and (self.rom[off + 1] | (self.rom[off + 2] << 8)) == qcpu):
                bank, hl_end, cpu = last_hl
                # only accept a pointer set in the same bank, close to the call
                if (bank == off // BANK_SIZE and 0x4000 <= cpu < 0x8000
                        and 0 <= off - hl_end <= 24):
                    src = bank * BANK_SIZE + cpu - BANK_SIZE
                    length = self._sprite_template_len(src)
                    # Override plain data blobs (packed templates share one
                    # anonymous blob) but never lz/object/slot-record data.
                    existing = self.data_blobs.get(src)
                    overridable = existing is None or existing[1] == "copy"
                    if length and overridable and src not in self.instrs \
                            and src not in self.object_headers \
                            and src not in self.slot_record_tables:
                        self.data_blobs[src] = (length, "sprite")
                        self.sprite_templates.add(src)
                        added += 1
        if added:
            print(f"sprite templates: {added} carved")

    def _sprite_template_len(self, src):
        """Length of a QueueSpriteTemplate list at src: 4-byte records up to a
        $80 dy byte (inclusive), else None if none appears within 40 records."""
        for n in range(40):
            if src + n * 4 >= len(self.rom):
                return None
            if self.rom[src + n * 4] == 0x80:
                return n * 4 + 1
        return None

    def load_hook_dumps(self, paths):
        """Ingest tools/hook_client.py captures: runtime-observed register
        snapshots at the data-helper entry points, one (h = bank, l = slot)
        argument pair per distinct call. Catches the dynamically-computed
        call sites that static backtracking cannot resolve."""
        entries = added = 0
        for p in paths:
            for e in json.loads(Path(p).read_text()):
                kind = e.get("kind")
                if kind not in ("copy", "lz"):
                    continue
                entries += 1
                bank, slot = e.get("h", -1), e.get("l", -1)
                length = ((e.get("b", 0) << 8) | e.get("c", 0)) \
                    if kind == "copy" else None
                key = bank * BANK_SIZE + slot
                if key not in self.data_slots and \
                        self._add_data_slot(bank, slot, kind, length):
                    added += 1
        print(f"hook dumps: {entries} captured calls, {added} new data slots")

    def find_sprite_banks(self):
        """Carve the character-sprite banks ($40-$5d). Layout, identical in
        every bank: $4000 points at a six-word descriptor {id, 3, frame
        table, anim scripts, 0, per-slot OAM data}; the frame table is a
        run of pointers to 24x40 (a few 32x40) tile records, self-delimited
        by its lowest target, with consecutive repeats for held frames; a
        30-byte-per-frame table sits directly below the per-slot OAM words;
        the animation-script pointer table addresses (frame, duration)
        streams that run to the trailing $ff mastering fill. Every field
        must line up exactly or the bank is left alone."""
        nbanks = len(self.rom) // BANK_SIZE
        for bank in range(1, nbanks):
            base = bank * BANK_SIZE
            w = lambda o: self.rom[base + o] | (self.rom[base + o + 1] << 8)
            if w(0) != 0x4002:
                continue
            ftab, scr, zero, smeta = w(6), w(8), w(10), w(12)
            if w(4) != 3 or zero != 0 or ftab != 0x400e \
                    or not 0x4000 < smeta < scr < 0x8000:
                continue
            if any(b in self.code_bytes for b in range(base, base + BANK_SIZE)):
                continue

            ptrs, o, first = [], 0xe, None
            while first is None or o < first:
                p = w(o)
                if not 0x4000 <= p < smeta:
                    break
                ptrs.append(p)
                t = p - 0x4000
                first = t if first is None else min(first, t)
                o += 2
            uniq = sorted(set(ptrs))
            if len(ptrs) < 8 or o != first or scr - smeta != 4 * len(ptrs):
                continue
            meta = smeta - 30 * len(uniq)
            lens = [b - a for a, b in zip(uniq, uniq[1:])] + [meta - uniq[-1]]
            if any(l <= 0 or l % 16 or l > 0x400 for l in lens):
                continue

            sptrs, o, first = [], scr - 0x4000, None
            while first is None or o < first:
                p = w(o)
                if not scr < p < 0x8000 or (sptrs and p < sptrs[-1]):
                    break
                sptrs.append(p)
                first = first or p - 0x4000
                o += 2
            end = BANK_SIZE
            while end > 0 and self.rom[base + end - 1] == 0xff:
                end -= 1
            if not sptrs or o != first or sptrs[-1] - 0x4000 >= end:
                continue

            self.sprite_banks.add(bank)
            for e in [e for e, v in self.data_slots.items() if v[0] == bank]:
                del self.data_slots[e]
            for s in [s for s in self.data_blobs
                      if base <= s < base + BANK_SIZE]:
                del self.data_blobs[s]

            flat = lambda cpu: base + cpu - 0x4000
            self.ptr_labels[flat(0x4002)] = f"SpriteDesc_{bank:02x}"
            self.ptr_labels[flat(ftab)] = f"SpriteFrames_{bank:02x}"
            self.ptr_labels[flat(scr)] = f"SpriteAnims_{bank:02x}"
            self.ptr_words[flat(0x4000)] = (flat(0x4002), "")
            for off_, tgt, note in (
                    (0x4002, None, ""), (0x4004, None, ""),
                    (0x4006, ftab, "frame table"),
                    (0x4008, scr, "animation scripts"),
                    (0x400a, None, ""), (0x400c, smeta, "per-slot OAM data")):
                self.ptr_words[flat(off_)] = (
                    flat(tgt) if tgt is not None else None, note)
            for i, p in enumerate(ptrs):
                self.ptr_words[flat(ftab) + 2 * i] = (flat(p), "")
            for a, l in zip(uniq, lens):
                self.data_blobs[flat(a)] = (l, "copy")
            self.data_blobs[flat(meta)] = (30 * len(uniq), "copy")
            self.data_blobs[flat(smeta)] = (4 * len(ptrs), "copy")
            for i, p in enumerate(sptrs):
                self.ptr_words[flat(scr) + 2 * i] = (flat(p), "")
            for a, b in zip(sptrs, sptrs[1:] + [0x4000 + end]):
                self.data_blobs[flat(a)] = (b - a, "copy")
        if self.sprite_banks:
            lo, hi = min(self.sprite_banks), max(self.sprite_banks)
            print(f"sprite banks: {len(self.sprite_banks)} carved "
                  f"(${lo:02x}-${hi:02x})")

    def find_sound_banks(self):
        """Carve the sound banks ($0c, $78-$7f). Each starts with a flat
        (channel word, stream pointer) pair table — the words are sound-
        engine channel-struct offsets, always $20-aligned, grouped four to
        a song in the music banks and singly in the SFX bank — followed by
        the note/command streams, then $ff fill. The table is delimited by
        its lowest stream target; a couple of bank $7e channel pointers
        rewind slightly into a shared prelude, so ascent is not required
        and blobs are carved at sorted unique targets."""
        found = []
        for bank in range(1, len(self.rom) // BANK_SIZE):
            base = bank * BANK_SIZE
            if bank in self.sprite_banks \
                    or any(v[0] == bank for v in self.data_slots.values()) \
                    or any(base <= s < base + BANK_SIZE for s in self.data_blobs):
                continue
            w = lambda o: self.rom[base + o] | (self.rom[base + o + 1] << 8)
            pairs, o, first = [], 0, None
            while first is None or o < first - 0x4000:
                v, p = w(o), w(o + 2)
                if v >= 0x4000 or v % 0x20 or not 0x4000 <= p < 0x8000:
                    break
                pairs.append((v, p))
                first = p if first is None else min(first, p)
                o += 4
            if len(pairs) < 8 or first is None or o != first - 0x4000:
                continue
            end = BANK_SIZE
            while end > 0 and self.rom[base + end - 1] == 0xff:
                end -= 1
            targets = sorted({p for _v, p in pairs})
            if targets[-1] - 0x4000 >= end:
                continue
            if any(b in self.code_bytes for b in range(base, base + BANK_SIZE)):
                continue
            flat = lambda cpu: base + cpu - 0x4000
            self.ptr_labels[base] = f"SoundTable_{bank:02x}"
            for i, (v, p) in enumerate(pairs):
                self.ptr_words[base + 4 * i] = (None, "")
                self.ptr_words[base + 4 * i + 2] = (flat(p), "")
            for a, b in zip(targets, targets[1:] + [0x4000 + end]):
                self.data_blobs[flat(a)] = (b - a, "copy")
            found.append(bank)
        if found:
            print(f"sound banks: {len(found)} carved "
                  f"({', '.join(f'${b:02x}' for b in found)})")

    def find_walk_sprite_banks(self):
        """Carve the overworld walk-sprite banks ($6a, $6f, $77): a bare
        pointer table at $4000 whose first entry points immediately past
        the table, each target a character's sprite-set block (a 16-byte
        object header, an OAM word list, then ~25 16x16 walk frames),
        trailing $ff fill after the last block. Same object-record layout as
        the $70-$76 banks, so split the header off (body follows
        unclassified) for a uniform header + body shape."""
        found = []
        for bank in range(1, len(self.rom) // BANK_SIZE):
            base = bank * BANK_SIZE
            if bank in self.sprite_banks \
                    or any(v[0] == bank for v in self.data_slots.values()) \
                    or any(base <= s < base + BANK_SIZE for s in self.data_blobs):
                continue
            w = lambda o: self.rom[base + o] | (self.rom[base + o + 1] << 8)
            first = w(0)
            if not 0x4004 <= first < 0x5000 or first % 2:
                continue
            n = (first - 0x4000) // 2
            ptrs = [w(i * 2) for i in range(n)]
            end = BANK_SIZE
            while end > 0 and self.rom[base + end - 1] == 0xff:
                end -= 1
            if n < 2 or ptrs != sorted(ptrs) or len(set(ptrs)) != n \
                    or ptrs[-1] - 0x4000 >= end \
                    or any(not 0x4000 <= p < 0x8000 for p in ptrs):
                continue
            sizes = [b - a for a, b in zip(ptrs, ptrs[1:] + [0x4000 + end])]
            if any(s < 0x100 or s > 0x1000 for s in sizes):
                continue
            if any(b in self.code_bytes for b in range(base, base + BANK_SIZE)):
                continue
            flat = lambda cpu: base + cpu - 0x4000
            self.ptr_labels[base] = f"WalkSprites_{bank:02x}"
            for i, p in enumerate(ptrs):
                self.ptr_words[base + 2 * i] = (flat(p), "")
            for a, s in zip(ptrs, sizes):
                self.data_blobs[flat(a)] = (16, "copy")
                self.object_headers.add(flat(a))
            found.append(bank)
        if found:
            print(f"walk-sprite banks: {len(found)} carved "
                  f"({', '.join(f'${b:02x}' for b in found)})")

    def scan_data_slots(self):
        """Classify remaining table slots whose pointers hold data.

        Slots are considered inside a per-bank table extent: at least the
        proven slot usage (farcall, inferred entry, or data slot), extended
        to the lowest data-blob target when that target delimits the table
        (the same self-delimiting rule infer_tables uses). A slot whose
        pointer decodes as a clean LZ stream (plausible size, overlapping no
        code, table region, or accepted blob) is accepted anywhere; in banks
        whose table carries no code entries at all, remaining in-extent
        pointers are accepted as raw data, carved up to the next known blob
        start (bank 3d's palette sets sit exactly between its LZ streams).
        """
        import bisect
        from collections import defaultdict
        floors = defaultdict(int)
        code_table_banks = set()
        for off, (bank, slot, _e, _t) in self.farcalls.items():
            if off in self.instrs:
                floors[bank] = max(floors[bank], slot + 2)
                code_table_banks.add(bank)
        for _e, (bank, slot, _t) in self.inferred_entries.items():
            floors[bank] = max(floors[bank], slot + 2)
            code_table_banks.add(bank)
        for bank, slot, _src, _k in self.data_slots.values():
            floors[bank] = max(floors[bank], slot + 2)
        live_entries = {e for off, (_b, _s, e, _t) in self.farcalls.items()
                        if off in self.instrs}

        # Bootstrap banks with no proven table usage at all: accept a bank
        # whose opening bytes form a full in-range pointer array delimited by
        # its own lowest target, of which at least three targets decode as
        # valid LZ streams. Bank $5f's scene table has no statically visible
        # consumer anywhere, yet its shape passes all three tests.
        for bank in range(1, len(self.rom) // BANK_SIZE):
            if bank in floors or bank in code_table_banks \
                    or bank in self.sprite_banks:
                continue
            base = bank * BANK_SIZE
            ptr = [self.rom[base + s] | (self.rom[base + s + 1] << 8)
                   for s in range(0, 0x100, 2)]
            inb = [p for p in ptr if BANK_SIZE < p < 0x8000]
            if not inb:
                continue
            ext = min(inb) - BANK_SIZE
            if not 2 <= ext <= 0x100 or ext & 1:
                continue
            slots = range(0, ext, 2)
            if not all(BANK_SIZE + ext <= ptr[s // 2] < 0x8000 for s in slots):
                continue
            lz_ok = 0
            for s in slots:
                src = base + ptr[s // 2] - BANK_SIZE
                if src in self.code_bytes:
                    lz_ok = 0
                    break
                try:
                    data, _ln = lz.decompress(self.rom, src, base + BANK_SIZE)
                    if 8 <= len(data) <= 0x1000:
                        lz_ok += 1
                except ValueError:
                    pass
            if lz_ok < 3:
                continue
            floors[bank] = ext
            print(f"  bank ${bank:02x}: bootstrapped {ext // 2}-slot data "
                  f"table ({lz_ok} lz targets)")

        claimed = sorted((src, src + length)
                         for src, (length, _k) in self.data_blobs.items()
                         if length)

        def overlaps(a, b):
            i = bisect.bisect_left(claimed, (b, b))
            return i > 0 and claimed[i - 1][1] > a

        # Acceptance can widen a bank's extent: a newly proven slot's target
        # may be the lowest one and thus delimit the table (bank $63's slot
        # $02 points at $4040, proving the full 32-slot table only after the
        # first pass accepts it). Extents are recomputed and the passes
        # rerun until a pass accepts nothing.
        def compute_extents():
            fl = dict(floors)
            for bank, slot, _src, _k in self.data_slots.values():
                fl[bank] = max(fl.get(bank, 0), slot + 2)
            ext = {}
            for bank, floor in fl.items():
                base = bank * BANK_SIZE
                tmin = min((src - base for (b, _s, src, _k) in
                            self.data_slots.values() if b == bank),
                           default=None)
                if tmin is not None and floor <= tmin <= 0x100:
                    ext[bank] = tmin
                else:
                    ext[bank] = floor
            return ext

        extents = compute_extents()

        def scannable(bank, slot):
            entry = bank * BANK_SIZE + slot
            if (entry in self.data_slots or entry in live_entries
                    or entry in self.code_bytes
                    or entry + 1 in self.code_bytes):
                return None
            ptr = self.rom[entry] | (self.rom[entry + 1] << 8)
            if not (BANK_SIZE <= ptr < 0x8000):
                return None
            src = bank * BANK_SIZE + ptr - BANK_SIZE
            if src < bank * BANK_SIZE + extents[bank] or src in self.code_bytes:
                return None  # points into the table region or at code
            return entry, src

        def split_blob_at(src):
            """Split the copy blob covering src so src starts its own blob.
            A raw blob is just a carve extent, so splitting is free; an lz
            stream can't be split (its bytes are one compressed unit), so a
            pointer into one keeps a numeric dw. Returns True on success."""
            j = bisect.bisect_left(claimed, (src + 1, src + 1)) - 1
            c_start, c_end = claimed[j]
            if self.data_blobs.get(c_start, (None, None))[1] != "copy":
                return False
            self.data_blobs[c_start] = (src - c_start, "copy")
            self.data_blobs[src] = (c_end - src, "copy")
            claimed[j] = (c_start, src)
            bisect.insort(claimed, (src, c_end))
            return True

        accepted_lz = accepted_raw = 0
        while True:
            before = len(self.data_slots)
            for bank, ext in sorted(extents.items()):
                base = bank * BANK_SIZE
                for slot in range(0, ext, 2):
                    cand = scannable(bank, slot)
                    if cand is None:
                        continue
                    entry, src = cand
                    if src in self.data_blobs:
                        self.data_slots[entry] = (bank, slot, src,
                                                  self.data_blobs[src][1])
                        accepted_lz += 1
                        continue  # alias of an already-accepted blob
                    try:
                        data, length = lz.decompress(self.rom, src,
                                                     base + BANK_SIZE)
                    except ValueError:
                        continue
                    if not 8 <= len(data) <= 0x1000:
                        continue
                    if overlaps(src, src + length) or any(
                            b in self.code_bytes
                            for b in range(src, src + length)):
                        continue
                    self.data_slots[entry] = (bank, slot, src, "lz")
                    self.data_blobs.setdefault(src, (length, "lz"))
                    bisect.insort(claimed, (src, src + length))
                    accepted_lz += 1

            # Raw-pointer pass: safe only where no table slot is a code
            # entry, so an in-range pointer cannot be an unproven function.
            for bank, ext in sorted(extents.items()):
                if bank in code_table_banks:
                    continue
                base = bank * BANK_SIZE
                starts = sorted(s for s in self.data_blobs
                                if base <= s < base + BANK_SIZE)
                for slot in range(0, ext, 2):
                    cand = scannable(bank, slot)
                    if cand is None:
                        continue
                    entry, src = cand
                    if src in self.data_blobs:
                        self.data_slots[entry] = (bank, slot, src,
                                                  self.data_blobs[src][1])
                        accepted_raw += 1
                        continue
                    if overlaps(src, src + 1):
                        if split_blob_at(src):
                            bisect.insort(starts, src)
                            self.data_slots[entry] = (bank, slot, src, "copy")
                            accepted_raw += 1
                        continue
                    i = bisect.bisect_right(starts, src)
                    nxt = starts[i] if i < len(starts) else base + BANK_SIZE
                    length = nxt - src
                    if not 0 < length <= 0x2000:
                        length = None
                    if length and any(b in self.code_bytes
                                      for b in range(src, src + length)):
                        length = None
                    self.data_slots[entry] = (bank, slot, src, "copy")
                    self.data_blobs.setdefault(src, (length, "copy"))
                    if length:
                        bisect.insort(claimed, (src, src + length))
                        bisect.insort(starts, src)
                    accepted_raw += 1

            if len(self.data_slots) == before:
                break
            extents = compute_extents()

        # Hook-observed copies can overlap: the engine reads both a whole
        # structure and windows inside it (bank $63 copies 136 bytes from
        # $5d75 and 64 bytes from $5d9f). Clip each copy blob at the next
        # blob start so every observed start anchors its own label instead
        # of being dropped at emit time as a mark inside another extent.
        starts_all = sorted(s for s, (ln, _k) in self.data_blobs.items() if ln)
        for idx, s in enumerate(starts_all[:-1]):
            length, kind = self.data_blobs[s]
            nxt = starts_all[idx + 1]
            if kind == "copy" and s + length > nxt:
                self.data_blobs[s] = (nxt - s, "copy")
        print(f"slot scan: {accepted_lz} lz + {accepted_raw} raw data slots "
              f"accepted ({len(self.data_slots)} total)")

    def seed_text_entries(self):
        """Text banks lay out slots 0/2 of their pointer table as the two
        string-fetch entry stubs (a = 0 dialogue / a = 1 short), with the
        stubs and fetch routine sitting after the string pool. Nothing
        jumps to the slot-2 stub directly, so descent cannot find it; seed
        it and register both slots as table entries when the pointed-at
        bytes are exactly the stub shape -- push af; ld a, N; call <next
        byte after the ret>; pop af; ret. Runtime-validated in $30/$36."""
        seeded = 0
        for bank in range(1, len(self.rom) // BANK_SIZE):
            base = bank * BANK_SIZE
            w0 = self.rom[base + 2] | (self.rom[base + 3] << 8)
            if not (BANK_SIZE <= w0 < 0x8000 - 8):
                continue
            flat = base + w0 - BANK_SIZE
            b = self.rom[flat:flat + 8]
            target = b[4] | (b[5] << 8)
            if not (b[0] == 0xF5 and b[1] == 0x3E and b[3] == 0xCD
                    and b[6] == 0xF1 and b[7] == 0xC9 and target == w0 + 8):
                continue
            slot0 = self.rom[base] | (self.rom[base + 1] << 8)
            if slot0 != w0 - 8:  # slot 0 must be the sibling dialogue stub
                continue
            if flat not in self.instrs:
                ins = self.decode_at(flat)
                if ins.valid and not self.conflicts(flat, ins):
                    self.mark(flat, ins)
                    seeded += 1
            self.inferred_entries.setdefault(base, (bank, 0, flat - 8))
            self.inferred_entries.setdefault(base + 2, (bank, 2, flat))
        if seeded:
            print(f"text-bank entry stubs: {seeded} seeded")

    # Story match-launcher stubs: uniform 14-byte functions that store a
    # 16-bit match id into wCurrentMinigameStoryMatch ($c8f6/$c8f7, big
    # endian) and farcall the match starter (FarPtr_0a_5a). The story flow
    # reaches them through dw tables read via RAM, so descent never sees
    # them, and the trace-to-coverage bank matcher keeps only their
    # distinctive farcall/ret bytes (bare `ld` lines are bank-ambiguous),
    # stranding stub tails mid-data. The rigid shape self-validates; a run
    # of three or more is required so byte coincidences cannot seed code.
    STUB_LEN = 14

    def _launcher_stub_at(self, off):
        r = self.rom
        return (r[off] == 0x3E and r[off + 2:off + 5] == b"\xea\xf6\xc8"
                and r[off + 5] == 0x3E and r[off + 7:off + 10] == b"\xea\xf7\xc8"
                and r[off + 10] == 0xDF and not r[off + 11] & 1
                and 0 < r[off + 12] < len(self.rom) // BANK_SIZE
                and r[off + 13] == 0xC9)

    def seed_launcher_stubs(self):
        runs = []
        off = BANK_SIZE
        end = len(self.rom) - self.STUB_LEN
        while off < end:
            if not self._launcher_stub_at(off):
                off += 1
                continue
            run = [off]
            while self._launcher_stub_at(run[-1] + self.STUB_LEN):
                run.append(run[-1] + self.STUB_LEN)
            off = run[-1] + self.STUB_LEN
            if len(run) >= 3:
                runs.append(run)
        starts = set()
        seeded = 0
        for run in runs:
            for s in run:
                o, todo = s, []
                while o < s + self.STUB_LEN:
                    ins = self.instrs.get(o)
                    if ins is None:
                        ins = self.decode_at(o)
                        if not ins.valid or self.conflicts(o, ins):
                            todo = None
                            break
                        todo.append((o, ins))
                    o += ins.size
                if todo is None:
                    continue
                for o, ins in todo:
                    self.mark(o, ins)
                    seeded += 1
                starts.add(s)
        # Launcher dw tables: same-bank runs of two or more words pointing
        # at stub starts, outside code. Registered as ptr_words so they
        # render as labeled dw entries and delimit the surrounding blobs.
        words = 0
        for bank in sorted({s // BANK_SIZE for s in starts}):
            base = bank * BANK_SIZE
            cand = set()
            for i in range(base, base + BANK_SIZE - 1):
                if i in self.code_bytes or i + 1 in self.code_bytes:
                    continue
                t = base + (self.rom[i] | (self.rom[i + 1] << 8)) - BANK_SIZE
                if t in starts:
                    cand.add(i)
            for i in sorted(cand):
                if i - 2 in cand or i + 2 in cand:
                    t = base + (self.rom[i] | (self.rom[i + 1] << 8)) - BANK_SIZE
                    if i not in self.ptr_words:
                        self.ptr_words[i] = (t, "")
                        words += 1
        if starts:
            print(f"launcher stubs: {len(starts)} seeded in "
                  f"{len(runs)} runs, {words} launcher-table dw words")

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


def load_const_defs(path):
    """Map constant name -> value from constants.inc (`def NAME equ $xx`).
    Used to render `enum:<PREFIX>:<cols>` data tables symbolically."""
    import re
    defs = {}
    if not Path(path).exists():
        return defs
    for m in re.finditer(r"^def\s+(\w+)\s+equ\s+\$([0-9a-f]+)\b",
                         Path(path).read_text(), re.MULTILINE | re.IGNORECASE):
        defs[m.group(1)] = int(m.group(2), 16)
    return defs


def render_enum_table(data, val2name, cols):
    """Render a byte table as rows of `cols` named constants (falling back to a
    bare $xx for any value with no constant), with the row's byte offset."""
    out = []
    for i in range(0, len(data), cols):
        row = data[i:i + cols]
        items = ", ".join(val2name.get(b, f"${b:02x}") for b in row)
        out.append(f"\tdb {items} ; {i:#04x}")
    return out


def region_prefix(addr):
    """Expected name prefix for a RAM address, by memory region."""
    if 0x8000 <= addr < 0xa000:
        return "v"
    if 0xa000 <= addr < 0xc000:
        return "s"
    if 0xc000 <= addr < 0xe000:
        return "w"
    if addr >= 0xff80:
        return "h"
    return None


# RAM regions in memory order: (start, end, rgbds memory type, layout file).
# One fixed-address SECTION per region holds its named symbols and ds gaps, so
# every symbol is defined once and exported (::) for the linker to resolve
# across bank objects.
RAM_REGIONS = [
    (0xa000, 0xc000, "SRAM", "ram/sram.asm"),
    (0xc000, 0xd000, "WRAM0", "ram/wram.asm"),
    (0xd000, 0xe000, "WRAMX", "ram/wram.asm"),
    (0xff80, 0xffff, "HRAM", "ram/hram.asm"),
]

_GENERATED_HDR = (
    "; RAM layout from ram_map.json (RetroAchievements Code Notes).\n"
    "; Regenerated by tools/disasm.py; do not edit by hand.\n"
)


def ram_field_size(e):
    """Byte width of a RAM symbol, from its Code Note tag or size field."""
    note = e.get("note", "") or ""
    m = re.match(r"\s*\[(\d+)\s*byte", note, re.IGNORECASE)
    if m:
        return int(m.group(1))
    if re.match(r"\s*\[16-bit", note, re.IGNORECASE):
        return 2
    if re.match(r"\s*\[32-bit", note, re.IGNORECASE):
        return 4
    return e.get("size", 1) or 1


def _ds_directive(size):
    return {1: "db", 2: "dw"}.get(size, f"ds {size}")


def _scope_to_flat(s):
    """Convert a union-variant scope ({bank[, start, end] in CPU addresses})
    to a flat-offset half-open range."""
    bank = int(s["bank"], 0)
    if "start" in s:
        st, en = int(s["start"], 0), int(s["end"], 0)
        if bank == 0:
            return (st, en)
        return (bank * BANK_SIZE + st - 0x4000, bank * BANK_SIZE + en - 0x4000)
    return (bank * BANK_SIZE, (bank + 1) * BANK_SIZE)


class ScopedRamNames:
    """RAM symbols whose name depends on the referencing code's location
    (union variants). resolve() picks the variant whose scope contains the
    site; a default variant applies only outside every scoped variant's
    ranges, so unknown consumers inside a scoped engine stay numeric."""

    def __init__(self):
        self.by_addr = {}

    def add(self, addr, name, ranges, default_mask=None):
        e = self.by_addr.setdefault(addr, {"scoped": [], "default": None,
                                           "mask": []})
        if default_mask is not None:
            e["default"] = name
            e["mask"] = default_mask
        else:
            e["scoped"].append((ranges, name))

    def resolve(self, addr, off):
        e = self.by_addr.get(addr)
        if not e:
            return None
        for ranges, name in e["scoped"]:
            if any(lo <= off < hi for lo, hi in ranges):
                return name
        if e["default"] and not any(lo <= off < hi for lo, hi in e["mask"]):
            return e["default"]
        return None


def load_ram_unions(path):
    """Load ram_unions.json: address ranges reused by several subsystems
    (RGBDS UNION/NEXTU overlays). Returns (unions_by_region, ScopedRamNames)."""
    unions_by_region, scoped = {}, ScopedRamNames()
    if not Path(path).exists():
        return unions_by_region, scoped
    data = json.loads(Path(path).read_text())
    for u in data.get("unions", []):
        start, end = int(u["start"], 0), int(u["end"], 0)
        mask = [_scope_to_flat(s) for v in u["variants"]
                for s in v.get("scopes", [])]
        variants = []
        for v in u["variants"]:
            ranges = [_scope_to_flat(s) for s in v.get("scopes", [])]
            syms = []
            for addr_s, e in sorted(v["symbols"].items(),
                                    key=lambda kv: int(kv[0], 0)):
                addr, name = int(addr_s, 0), e["name"]
                exp = region_prefix(addr)
                if exp and not (name.startswith(exp) and name[1:2].isupper()):
                    print(f"warning: {path}: {addr_s} name {name!r} should be "
                          f"{exp}PascalCase", file=sys.stderr)
                if not start <= addr < end:
                    print(f"warning: {path}: {addr_s} outside union "
                          f"${start:04x}-${end:04x}", file=sys.stderr)
                syms.append((addr, name, ram_field_size(e), e.get("note", "")))
                if v.get("default"):
                    scoped.add(addr, name, None, default_mask=mask)
                else:
                    scoped.add(addr, name, ranges)
            variants.append((v.get("context", ""), syms))
        for ri, (rs, re_, _mem, _path) in enumerate(RAM_REGIONS):
            if rs <= start < re_:
                unions_by_region.setdefault(ri, []).append(
                    (start, end, u.get("comment", ""), variants))
                break
        else:
            print(f"warning: {path}: union {u['start']} outside known RAM "
                  f"regions", file=sys.stderr)
    return unions_by_region, scoped


def _emit_union_block(out, start, end, comment, variants):
    for ln in comment.split("\n"):
        out.append(f"; {ln}".rstrip() if ln.strip() else ";")
    out.append("UNION")
    for vi, (context, syms) in enumerate(variants):
        if vi:
            out.append("NEXTU")
        if context:
            out.append(f"; {context}")
        cursor = start
        for addr, name, size, note in syms:
            if addr > cursor:
                out.append(f"\tds {addr - cursor}")
            for ln in (note or "").split("\n"):
                out.append(f"; {ln}".rstrip() if ln.strip() else ";")
            out.append(f"{name}:: {_ds_directive(size)}")
            cursor = addr + size
        if vi == 0 and cursor < end:
            out.append(f"\tds {end - cursor}")
    out.append("ENDU")
    out.append("")


def write_ram_layout(regions, unions_by_region=None):
    """Emit ram.asm + ram/*.asm from {region_index: [(addr, name, size, note)]}.
    Each region becomes one fixed-address SECTION; ds fills the gaps between
    named symbols so every symbol lands at its exact hardware address."""
    files = {}  # layout file -> list of section text blocks
    unions_by_region = unions_by_region or {}
    for ri, (start, end, mem, path) in enumerate(RAM_REGIONS):
        items = [("sym", addr, name, size, note)
                 for addr, name, size, note in regions.get(ri, [])]
        for ustart, uend, comment, variants in unions_by_region.get(ri, []):
            for addr, *_rest in regions.get(ri, []):
                if ustart <= addr < uend:
                    raise SystemExit(
                        f"ram_map/ram_unions conflict: ${addr:04x} inside "
                        f"union ${ustart:04x}-${uend:04x}")
            items.append(("union", ustart, uend, comment, variants))
        if not items:
            continue
        items.sort(key=lambda t: t[1])
        base = items[0][1]
        out = [f'SECTION "{mem} ${base:04x}", {mem}[${base:04x}]', ""]
        for i, item in enumerate(items):
            nxt = items[i + 1][1] if i + 1 < len(items) else end
            if item[0] == "union":
                _tag, ustart, uend, comment, variants = item
                _emit_union_block(out, ustart, uend, comment, variants)
                gap = nxt - uend
                if gap > 0 and i + 1 < len(items):
                    out.append(f"\tds {gap}")
                    out.append("")
                continue
            _tag, addr, name, size, note = item
            span = nxt - addr
            emitted = max(1, min(size, span))
            for ln in (note or "").split("\n"):
                out.append(f"; {ln}".rstrip() if ln.strip() else ";")
            out.append(f"{name}:: {_ds_directive(emitted)}")
            gap = span - emitted
            if gap > 0 and i + 1 < len(items):
                out.append(f"\tds {gap}")
            out.append("")
        files.setdefault(path, []).append("\n".join(out).rstrip() + "\n")

    for path, blocks in files.items():
        Path(path).parent.mkdir(parents=True, exist_ok=True)
        Path(path).write_text(_GENERATED_HDR + "\n" + "\n\n".join(blocks))

    includes = []
    for _ri, (_s, _e, _m, path) in enumerate(RAM_REGIONS):
        if path in files and f'INCLUDE "{path}"' not in includes:
            includes.append(f'INCLUDE "{path}"')
    Path("ram.asm").write_text(_GENERATED_HDR + "\n" + "\n".join(includes) + "\n")


def load_ram_map(path, unions_by_region=None):
    """Map RAM addresses to names from ram_map.json (for operand rendering) and
    emit the RAM layout files (ram.asm + ram/*.asm)."""
    if not Path(path).exists():
        return {}
    entries = json.loads(Path(path).read_text())
    names = {}
    regions = {}
    for addr_s, e in sorted(entries.items(), key=lambda kv: int(kv[0], 0)):
        name = e.get("name")
        if not name:
            continue
        addr = int(addr_s, 0)
        exp = region_prefix(addr)
        if exp and not (name.startswith(exp) and name[1:2].isupper()):
            print(f"warning: {path}: {addr_s} name {name!r} should be "
                  f"{exp}PascalCase", file=sys.stderr)
        names[addr] = name
        for ri, (start, end, _mem, _path) in enumerate(RAM_REGIONS):
            if start <= addr < end:
                regions.setdefault(ri, []).append(
                    (addr, name, ram_field_size(e), e.get("note", "")))
                break
        else:
            print(f"warning: {path}: {addr_s} outside known RAM regions",
                  file=sys.stderr)
    write_ram_layout(regions, unions_by_region)
    return names


def build_labels(dis, overrides=None, data_tables=None):
    labels = {}
    for off, name in VECTOR_LABELS.items():
        if off in dis.instrs:
            labels[off] = name
    if overrides:
        for k, name in overrides.items():
            ok = (name[:1].isupper() and name.isidentifier()) or \
                 (name.startswith(".") and name[1:].isidentifier())
            if not ok:
                print(f"warning: labels.json: {k} name {name!r} should be "
                      f"PascalCase or a .local label", file=sys.stderr)
            labels[int(k, 0)] = name
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
    for target, _note in dis.ptr_words.values():
        if target is not None and target in dis.instrs and target not in labels:
            labels[target] = f"Func_{target // BANK_SIZE:02x}_{offset_to_cpu(target):04x}"
    for target in map_script_code_targets(dis.rom, data_tables or {}):
        if target in dis.instrs and target not in labels:
            labels[target] = f"Func_{target // BANK_SIZE:02x}_{offset_to_cpu(target):04x}"
    rft = next((int(k, 0) for k, n in (overrides or {}).items()
                if n == "RegisterFrameTask"), None)
    for target in frame_task_targets(dis, rft):
        if target not in labels:
            labels[target] = f"Func_{target // BANK_SIZE:02x}_{offset_to_cpu(target):04x}"
    # Name each carved sprite-template so the `ld hl` load sites resolve to it.
    for src in dis.sprite_templates:
        if src not in labels:
            labels[src] = \
                f"SpriteTemplate_{src // BANK_SIZE:02x}_{offset_to_cpu(src):04x}"
    return labels


def frame_task_targets(dis, register_frame_task):
    """Code targets of `ld hl, n16` immediately before `call RegisterFrameTask`
    -- per-frame task functions installed into the task list and only ever
    reached through the task dispatcher, so recursive descent never labels them.
    Seeding them lets the 400-odd registration sites reference the task by name."""
    if register_frame_task is None:
        return
    rom = dis.rom
    for o, ins in dis.instrs.items():
        if rom[o] != 0x21 or o + 3 not in dis.instrs or rom[o + 3] != 0xCD:
            continue  # ld hl, n16 ; call nn
        if target_to_offset(rom[o + 4] | (rom[o + 5] << 8), o + 3) != register_frame_task:
            continue
        imm = rom[o + 1] | (rom[o + 2] << 8)
        b = (o // BANK_SIZE) * BANK_SIZE
        flat = imm if imm < 0x4000 else (b + imm - 0x4000 if b else None)
        if flat is not None and flat in dis.instrs:
            yield flat


def map_script_code_targets(rom, data_tables):
    """Yield the in-bank code pointers embedded in map_scripts/map_entries
    tables (script-record handlers and entry arrival scripts). These handlers
    are only ever reached through an indirect dispatch (CallHLInBankA), so
    recursive descent never gives them a label; seeding them lets the record
    macros reference the handler by name instead of a bare address."""
    for start, spec in data_tables.items():
        if spec not in ("map_scripts", "map_entries"):
            continue
        bank = start // BANK_SIZE
        base = bank * BANK_SIZE
        pfield = 4 if spec == "map_scripts" else 6  # handler / arrival script
        p = start
        # tables are $ff-terminated; cap the walk at the bank end for safety
        while p + 8 <= base + BANK_SIZE and rom[p] != 0xFF:
            w = rom[p + pfield] | (rom[p + pfield + 1] << 8)
            if 0x4000 <= w < 0x8000:
                yield base + w - 0x4000
            p += 8


def wram_bank_seq(dis, rom, off, labels):
    """Collapse the WRAM bank-switch idiom into the wram_bank macro:
    ldh [$ff96],a + ldh [rWBK],a, optionally preceded by ld a,imm. Only
    fires when the follow-on instructions are plain proven code with no
    label or data-site note landing inside the sequence (a mid-sequence
    jump target keeps its raw instructions). Returns (text, size)."""
    def plain(o):
        return (o in dis.instrs and o not in labels
                and o not in dis.data_site_notes)
    if off in dis.data_site_notes:
        return None
    if (rom[off] == 0x3E and rom[off + 2:off + 6] == b"\xe0\x96\xe0\x70"
            and plain(off + 2) and plain(off + 4)):
        return f"wram_bank ${rom[off + 1]:02x}", 6
    if rom[off:off + 4] == b"\xe0\x96\xe0\x70" and plain(off + 2):
        return "wram_bank", 4
    return None


def match_launcher_seq(dis, rom, off, labels):
    """Collapse the story match-launcher idiom into load_match_settings: the
    two immediates are the high/low bytes of the 16-bit wCurrentMinigameStoryMatch
    id ($c8f6/$c8f7), then farcall FarPtr_LoadMatchSettingsFromTable (slot $5a
    bank $0a). 41 standalone launcher stubs (each then ret) plus inline callers
    share it. Only fires when no label/data note lands mid-sequence."""
    def plain(o):
        return (o in dis.instrs and o not in labels
                and o not in dis.data_site_notes)
    if off in dis.data_site_notes:
        return None
    if (rom[off] == 0x3E and rom[off + 2] == 0xEA and rom[off + 3] == 0xF6
            and rom[off + 4] == 0xC8 and rom[off + 5] == 0x3E
            and rom[off + 7] == 0xEA and rom[off + 8] == 0xF7
            and rom[off + 9] == 0xC8 and rom[off + 10] == 0xDF
            and rom[off + 11] == 0x5A and rom[off + 12] == 0x0A
            and plain(off + 2) and plain(off + 5) and plain(off + 7)
            and plain(off + 10)):
        return (f"load_match_settings "
                f"${(rom[off + 1] << 8) | rom[off + 6]:04x}"), 13
    return None


# Cutscene script commands. Each is (macro, steps) where the source is a fixed
# instruction sequence — register setups plus one or more farcalls into the
# story script engine. A step is either a plain instruction (opcode, size, kind)
# or a farcall ('F', FarPtr slot label). kinds: 'b' = 1-byte immediate arg,
# 'w' = 2-byte immediate arg, 'x' = no-operand op (no arg), 'z' = 1-byte
# immediate fixed at $00 (no arg; only matches that value). Immediate args are
# emitted to the macro in source order.
SCRIPT_COMMANDS = (
    ("script_move_target",
        ((0x3E, 2, 'b'), (0x01, 3, 'w'), (0x11, 3, 'w'),
         ('F', "FarPtr_ScriptSetActorMoveTarget"))),
    ("script_set_position",
        ((0x3E, 2, 'b'), (0x01, 3, 'w'), (0x11, 3, 'w'),
         ('F', "FarPtr_ScriptSetActorPosition"))),
    ("script_move_angle",
        ((0x3E, 2, 'b'), (0x06, 2, 'b'), (0x11, 3, 'w'),
         ('F', "FarPtr_MoveActorByAngle"))),
    ("script_set_speed",
        ((0x3E, 2, 'b'), (0x01, 3, 'w'), ('F', "FarPtr_ScriptSetActorMoveSpeed"))),
    ("script_jump_velocity",
        ((0x3E, 2, 'b'), (0x11, 3, 'w'), ('F', "FarPtr_ScriptSetActorJumpVelocity"))),
    ("script_set_anim",
        ((0x3E, 2, 'b'), (0x16, 2, 'b'), ('F', "FarPtr_ScriptSetActorAnimation"))),
    ("script_face",
        ((0x3E, 2, 'b'), (0x06, 2, 'b'), ('F', "FarPtr_SetActorFacing"))),
    ("script_face_pair",
        ((0x3E, 2, 'b'), (0x47, 1, 'x'), (0x3E, 2, 'b'),
         ('F', "FarPtr_FaceActorsTowardEachOther"))),
    ("script_face_toward",
        ((0x3E, 2, 'b'), (0x47, 1, 'x'), (0x3E, 2, 'b'),
         ('F', "FarPtr_FaceActorTowardActor"))),
    ("script_facing_lock",
        ((0x3E, 2, 'b'), (0x06, 2, 'b'), ('F', "FarPtr_ScriptSetActorFacingLock"))),
    ("script_set_active",
        ((0x3E, 2, 'b'), (0x06, 2, 'b'), ('F', "FarPtr_SetActorActive"))),
    # Set an actor's object definition: fetch its state pointer into bc, then
    # LoadActorObjectDefIfValid(bc, d = objdef). Args: objdef (d), then actor (a).
    ("script_set_objdef",
        ((0x16, 2, 'b'), (0x3E, 2, 'b'), ('F', "FarPtr_GetActorStateAddr"),
         (0x4D, 1, 'x'), (0x44, 1, 'x'),
         ('F', "FarPtr_LoadActorObjectDefIfValid"))),
    ("script_get_actor_state",
        ((0x3E, 2, 'b'), ('F', "FarPtr_GetActorStateAddr"))),
    ("script_move_player_to_actor",
        ((0x3E, 2, 'b'), (0x06, 2, 'z'), ('F', "FarPtr_MovePlayerToActor"))),
    ("script_move_player",
        ((0xAF, 1, 'x'), (0x01, 3, 'w'), (0x11, 3, 'w'),
         ('F', "FarPtr_MovePlayerToPosition"))),
    ("script_player_speed",
        ((0x01, 3, 'w'), ('F', "FarPtr_SetPlayerMoveSpeed"))),
    ("script_set_text",
        ((0x21, 3, 'w'), ('F', "FarPtr_InitDialogueTextCursor"))),
    ("script_speak",
        ((0x3E, 2, 'b'), ('F', "FarPtr_ScriptShowSpeakerDialogue"))),
    ("script_wait_idle",
        ((0x3E, 2, 'b'), ('F', "FarPtr_ScriptWaitActorIdle"))),
    ("script_wait_move",
        ((0x3E, 2, 'b'), ('F', "FarPtr_ScriptWaitActorMoveDone"))),
    ("script_wait_actor_script",
        ((0x3E, 2, 'b'), ('F', "FarPtr_WaitActorScriptDone"))),
    ("script_null_script",
        ((0x3E, 2, 'b'), ('F', "FarPtr_SetActorNullScript"))),
    # Always bracketed by push af / pop af (it clobbers a with the frame count
    # while the caller holds an actor id there); the pair are ordinary steps.
    ("script_wait_frames",
        ((0xF5, 1, 'x'), (0x3E, 2, 'b'), ('F', "FarPtr_WaitScriptFrames"),
         (0xF1, 1, 'x'))),
    # Copy a width x height tile rectangle between two scene-tilemap cells:
    # source (b=col, c=row) -> dest (d=col, e=row), h=width, l=height.
    ("script_copy_scene_rect",
        ((0x06, 2, 'b'), (0x0E, 2, 'b'), (0x16, 2, 'b'), (0x1E, 2, 'b'),
         (0x26, 2, 'b'), (0x2E, 2, 'b'), ('F', "FarPtr_CopySceneTilemapRect"))),
    # Wait `frames` frames via the af-preserving WaitScriptFramesSaveA wrapper
    # (bank $27's cutscenes call it instead of inlining script_wait_frames).
    ("script_delay",
        ((0x3E, 2, 'b'), ('C', "WaitScriptFramesSaveA"))),
    # Start a fade-in at speed c (BeginFadeIn, $00:$1d2e).
    ("script_fade_in",
        ((0x0E, 2, 'b'), ('C', "BeginFadeIn"))),
    # Set actor `actor`'s script to `script` (a pointer in the current bank,
    # captured via hRomBank -> b). ScriptSetActorScript ($0a:$434f).
    ("script_set_actor_script",
        ((0xF0, 2, 'x'), (0x47, 1, 'x'), (0x3E, 2, 'b'), (0x11, 3, 'p'),
         ('F', "FarPtr_ScriptSetActorScript"))),
)


# A 16-bit dialogue text id (passed in hl to FetchDialogueText, $05:$5c18) is not
# an address but a (fetcher, index) code: fetcher = (hi >> 2) & $0f selects a text
# bank via DialogueTextFetchers_05 ($05:$5c3b), and the string index within that
# bank = (hi & 3) * 256 + lo. So the raw id decodes to a bank:index coordinate.
# Rendering the id as the name `Text_<bank>_<index>` (an EQU whose value is the id,
# emitted to include/text_ids.inc) keeps the assembled bytes identical while making
# the operand point at the string; look it up with tools/strings.py --index --bank.
TEXT_FETCHER_BANKS = {0: 0x30, 1: 0x31, 2: 0x32, 3: 0x33, 4: 0x34, 5: 0x35,
                      6: 0x36, 7: 0x37, 8: 0x6e, 9: 0x1f, 10: 0x25, 11: 0x26,
                      12: 0x5e}
TEXT_IDS_USED = {}  # id value -> Text_ name (collected during emit)


def text_id_name(idv):
    """Name a dialogue text id `Text_<bank>_<index>`, or None if it isn't a
    plain text id (bit15 = SRAM string, or an out-of-range fetcher)."""
    if idv == 0 or idv & 0x8000:  # $0000 = "no script/text" sentinel, not a string
        return None
    bank = TEXT_FETCHER_BANKS.get((idv >> 10) & 0x0f)
    if bank is None:
        return None
    index = ((idv >> 8) & 3) * 256 + (idv & 0xff)
    name = f"Text_{bank:02x}_{index}"
    TEXT_IDS_USED[idv] = name
    return name


# Cutscene script macros whose arg 1 is a FACE_* cardinal (facing or angle).
FACING_ARG_MACROS = {"script_face", "script_facing_lock", "script_move_angle"}

# The three reserved system actor slots (see constants.inc). Slots 3+ are
# scene-local and stay literal.
RESERVED_ACTOR_SLOTS = {"$00": "ACTOR_PLAYER", "$01": "ACTOR_PLAYER_SHADOW",
                        "$02": "ACTOR_PARTNER"}

# Cutscene script macros -> the emitted-arg indices that are actor slots (a
# reserved slot renders as its ACTOR_* name). Only the target-actor immediates;
# slot ids elsewhere in the arg list stay literal.
ACTOR_SLOT_ARGS = {
    "script_move_target": (0,), "script_set_position": (0,),
    "script_move_angle": (0,), "script_set_speed": (0,),
    "script_jump_velocity": (0,), "script_set_anim": (0,),
    "script_face": (0,), "script_face_pair": (0, 1),
    "script_face_toward": (0, 1), "script_facing_lock": (0,),
    "script_set_active": (0,), "script_set_objdef": (1,),
    "script_get_actor_state": (0,), "script_move_player_to_actor": (0,),
    "script_speak": (0,), "script_wait_idle": (0,), "script_wait_move": (0,),
    "script_wait_actor_script": (0,), "script_null_script": (0,),
    "script_set_actor_script": (0,),
}


def script_cmd_seq(dis, rom, off, labels, far_slot_names):
    """Collapse a cutscene script command (a fixed run of register setups and
    farcalls into the FarPtr_Script* engine) into a script_* macro. Steps are
    matched in order; farcall steps must resolve to the named FarPtr slot. Only
    fires when no label or data note lands inside the sequence past its first
    instruction (so nothing is hidden)."""
    def plain(o):
        return (o in dis.instrs and o not in labels
                and o not in dis.data_site_notes)
    if off in dis.data_site_notes:
        return None
    for macro, steps in SCRIPT_COMMANDS:
        p, args, ok = off, [], True
        for step in steps:
            if p != off and not plain(p):
                ok = False
                break
            if step[0] == 'F':
                if p not in dis.farcalls:
                    ok = False
                    break
                fbank, slot, _entry, _tgt = dis.farcalls[p]
                if far_slot_names.get((fbank, slot)) != step[1]:
                    ok = False
                    break
                p += 3  # rst18 + slot + bank
            elif step[0] == 'C':  # `call` to a named ROM0 / same-bank helper
                if p + 3 > len(rom) or rom[p] != 0xCD:
                    ok = False
                    break
                cpu = rom[p + 1] | (rom[p + 2] << 8)
                tgt = cpu if cpu < BANK_SIZE else \
                    (p // BANK_SIZE) * BANK_SIZE + cpu - BANK_SIZE
                if labels.get(tgt) != step[1]:
                    ok = False
                    break
                p += 3
            else:
                opc, size, kind = step
                if p + size > len(rom) or rom[p] != opc:
                    ok = False
                    break
                if kind == 'z' and rom[p + 1] != 0x00:
                    ok = False
                    break
                if kind == 'b':
                    args.append(f"${rom[p + 1]:02x}")
                elif kind == 'w':
                    args.append(f"${rom[p + 1] | (rom[p + 2] << 8):04x}")
                elif kind == 'p':  # 16-bit pointer -> label if one is known
                    v = rom[p + 1] | (rom[p + 2] << 8)
                    tgt = ((p // BANK_SIZE) * BANK_SIZE + v - BANK_SIZE
                           if BANK_SIZE <= v < 0x8000 else v)
                    args.append(labels.get(tgt, f"${v:04x}"))
                p += size
        if ok:
            if macro == "script_set_text" and len(args) == 1:
                name = text_id_name(int(args[0][1:], 16))
                if name:
                    args[0] = name
            # The facing byte (arg 1) of the facing/angle setters is the FACE_*
            # cardinal encoding shared with the map tables (the byte doubles as
            # the movement angle for script_move_angle).
            if macro in FACING_ARG_MACROS and len(args) >= 2 \
                    and args[1].startswith("$"):
                args[1] = ACTOR_FACING_NAMES.get(int(args[1][1:], 16), args[1])
            for ai in ACTOR_SLOT_ARGS.get(macro, ()):
                if ai < len(args) and args[ai] in RESERVED_ACTOR_SLOTS:
                    args[ai] = RESERVED_ACTOR_SLOTS[args[ai]]
            return (f"{macro} " + ", ".join(args)).rstrip(), p - off
    return None


IMM8_RE = re.compile(r"\$[0-9a-f]{1,2}$")


def render_operand(ins, off, labels, hwregs, ramnames, data_labels=None,
                   ramscoped=None, constants=None):
    text = ins.text
    # A curated 8-bit immediate (constants.json maps the instruction offset to a
    # named constant, e.g. a wCurrentShotType code). Keyed by exact offset, so
    # only the tagged `ld r, n8` / `cp a, n8` sites are affected; a wrong tag
    # changes the assembled byte and fails the byte-perfect compare.
    if constants and off in constants and ins.target is None:
        name = constants[off]
        # bit/set/res N, r: the index is baked into the opcode, so replacing it
        # with a (numerically equal) named bit constant is a pure text change.
        mb = re.match(r"(bit|res|set) \d+, (.*)$", text)
        if mb:
            return f"{mb.group(1)} {name}, {mb.group(2)}"
        m = IMM8_RE.search(text)
        if m:
            return text[:m.start()] + name
    # A 16-bit immediate load whose value points at a named data region is a
    # pointer setup; inline the label. Bounded to data_labels (curated data
    # offsets) so numeric constants that alias code addresses are untouched.
    if data_labels and ins.target is None:
        m = LDIMM_RE.match(text)
        if m:
            imm = int(m.group(2), 16)
            base = (off // BANK_SIZE) * BANK_SIZE
            flat = None
            if imm < 0x4000:
                flat = imm
            elif base and imm < 0x8000:
                flat = base + (imm - 0x4000)
            if flat in data_labels:
                return f"ld {m.group(1)}, {data_labels[flat]}"
            # Same for curated RAM symbols: a word immediate equal to a
            # named RAM address is a pointer setup, not a constant.
            if ramnames and imm in ramnames:
                return f"ld {m.group(1)}, {ramnames[imm]}"
            if ramscoped:
                sn = ramscoped.resolve(imm, off)
                if sn:
                    return f"ld {m.group(1)}, {sn}"
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
            elif ramscoped:
                sn = ramscoped.resolve(addr, off)
                if sn:
                    text = text.replace(f"[${m.group(1)}]", f"[{sn}]")
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

; One (slot, bank) word per argument, referencing a $4000-table slot by its
; FarPtr_*/DataPtr_* label -- the same encoding as farcall's operand bytes.
; Used by slot-record tables (e.g. ScreenAssetRecordTable) whose loaders
; read the words through RAM.
MACRO dslot
	REPT _NARG
	db LOW(\\1), BANK(\\1)
	SHIFT
	ENDR
ENDM

; Game text (see the generated data/bank_XXX/text_*.asm): a string is db
; segments joined by control bytes -- $01 starts a new on-screen line, $02 a
; new page, $03 terminates. `text` opens a string (or continues an
; overlong segment), `line`/`page` emit the control byte plus the segment.
MACRO text
	db \\#
ENDM

MACRO line
	db $01, \\#
ENDM

MACRO page
	db $02, \\#
ENDM

MACRO done
	db $03
ENDM

; rst $20/$28/$30 ($255e/$256b/$2551): set/clear/test a bit in the
; wGameFlags array ($c9c0+). Two inline operand bytes: the bit selector in
; the top 3 bits of the first (the handlers apply mask $80 >> bit to
; wGameFlags[byte]), the flag byte index in the second.
; Usage: set_flag byte_index, bit
MACRO set_flag
	rst Rst20
	db (\\2) << 5, \\1
ENDM

MACRO clear_flag
	rst Rst28
	db (\\2) << 5, \\1
ENDM

MACRO test_flag
	rst Rst30
	db (\\2) << 5, \\1
ENDM

; Sound/music index entry (PlaySound, $3297): selects one sound. The first
; byte packs the voice count (high nibble) and the data-bank low nibble
; (bank = $70 | nibble, i.e. $78-$7f); the second is the first channel
; record's index into that bank's SoundTable_* ((length, pointer) records,
; one per voice, `voices` consecutive records per sound).
; Usage: sound_entry bank, voices, record
MACRO sound_entry
	db ((\\2) << 4) | ((\\1) & $0f), \\3
ENDM

; WRAM bank switch: writes rWBK (rSVBK) plus its HRAM shadow hWramBank.
; With an argument the bank id is loaded into a first; the bare form
; switches to the bank already in a. The match engine keeps per-character
; structs in banks 4-7 (see docs/ram_map.md).
MACRO wram_bank
	IF _NARG == 1
	ld a, \\1
	ENDC
	ldh [hWramBank], a
	ldh [rWBK], a
ENDM

; --- Story-mode map-script tables (banks $0e-$15) ---
; Each story location owns a 7-word directory (a map_tree) copied to $c286.
; The words point at the location's sub-tables, one per slot, consumed by the
; bank $0a overworld engine:
;   0 EntryPoints (map_entry)    - spawn record per entry point / warp id
;   1 ExitTriggers (map_script)  - RunLocationExit
;   2 Actors (map_actor)         - the location's NPC/prop actor list
;   3 NpcScripts (map_script)    - RunNpcInteraction (talk)
;   4 FacingScripts (map_script) - RunFacingTileScript (action button vs tile)
;   5 TileTriggers (map_script)  - RunTileTriggerScript (step-on)
;   6 InitScript                 - RunLocationInitScript (code)
; Slots with no table point at a shared $ff (an empty list) or at slot 6's
; init code.

; Actor spawn template (14 bytes, list terminated by a $ff sentinel byte).
; SpawnActorFromTemplate ($04:$4c60) spawns `objdef` unless `cond` is met,
; then seeds the actor's position, facing, object id, animation, and (if
; nonzero) a palette override. `facing` is a FACE_* constant (constants.inc).
; Usage: map_actor cond, objdef, x, y, facing, obj_id, anim, palette
MACRO map_actor
	dw \\1, \\2, \\3, \\4
	db \\5, $00, \\6, \\7, \\8, $00
ENDM

; Terminates a map_actor list: nine $00 bytes then the $ff sentinel that
; SpawnActorsFromList ($04:$4cf7) stops on (it reads template byte 9).
MACRO map_actor_end
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff
ENDM

; --- Actor-script bytecode (the `objdef` blobs a map_actor points at) ---
; SpawnActor ($04:$4055) installs the blob as the actor's script pointer
; (state +$00/+$01 = address, +$02 = bank). StepActorScript ($04:$4229) runs it
; each frame: it reads a 1-byte opcode and dispatches through the 22-entry
; handler table at $04:$447d. Each opcode advances the script pointer past its
; operands; a handler returns 0 to yield for this frame or nonzero to run the
; next opcode immediately. A script is a pool of fragments, each ending in an
; as_jump back-edge (an infinite loop); different actors/states enter at
; different offsets. Coordinates are 16-bit fixed-point map units. See
; docs/actor_script.md for the full opcode reference.
MACRO as_halt        ; $00 inert: yield forever (no pointer advance)
	db $00
ENDM
MACRO as_wait        ; $01 wait `n` frames (state +$03 = n-1), then yield
	db $01, \\1
ENDM
MACRO as_wait_move   ; $02 yield until the current move finishes (+$05 bit7)
	db $02
ENDM
MACRO as_set_target  ; $03 set move target position -> state +$0c/+$0e
	db $03
	dw \\1, \\2
ENDM
MACRO as_set_pos     ; $04 set current position -> state +$08/+$0a
	db $04
	dw \\1, \\2
ENDM
MACRO as_halt5       ; $05 inert (handler alias of $00)
	db $05
ENDM
MACRO as_target_rel  ; $06 offset the move target by (dx, dy)
	db $06
	dw \\1, \\2
ENDM
MACRO as_move        ; $07 move by angle (byte) + distance (word), absolute
	db $07, \\1
	dw \\2
ENDM
MACRO as_move_rel    ; $08 move by angle + distance, angle relative to facing
	db $08, \\1
	dw \\2
ENDM
MACRO as_rand_box    ; $09 pick a random reachable point in a box (gated on +$30 bit7)
	db $09, \\1, \\2
ENDM
MACRO as_step        ; $0a step one tick toward the target waypoint (+$16), then yield
	db $0a
ENDM
MACRO as_follow_wp   ; $0b advance along the waypoint list at +$16, then yield
	db $0b
ENDM
MACRO as_jump        ; $0c jump to `target` (signed rel16, relative to the operand)
	db $0c
	dw \\1 - @
ENDM
MACRO as_set_field   ; $0d write a state field (selector byte, value word; type table $04:$47fd). Selector $14 = facing (FACE_* value)
	db $0d, \\1
	dw \\2
ENDM
MACRO as_add_field   ; $0e add to / set a state field (selector byte, value word)
	db $0e, \\1
	dw \\2
ENDM
MACRO as_halt15      ; $0f inert (handler alias of $00)
	db $0f
ENDM
MACRO as_anim        ; $10 set animation id
	db $10, \\1
ENDM
MACRO as_sound       ; $11 play sound id
	db $11, \\1
ENDM
MACRO as_call        ; $12 call a same-bank function (actor state in bc); yield+retry if busy
	db $12
	dw \\1
ENDM
MACRO as_begin_path  ; $13 seed the path target (+$16) from the current position
	db $13
ENDM
MACRO as_wait_move2  ; $14 wait for the move to finish / countdown
	db $14
ENDM
MACRO as_flag        ; $15 set or clear a state flag bit (field, mode, bit index)
	db $15, \\1, \\2, \\3
ENDM

; Entry-point spawn record (8 bytes, table terminated by $ff). Selected by
; wStoryModeEntryPoint; places the main character (facing a FACE_* direction,
; constants.inc) and runs `arrival_script`.
; Usage: map_entry id, facing, x, y, arrival_script
MACRO map_entry
	db \\1, \\2
	dw \\3, \\4, \\5
ENDM

; Story-script record (8 bytes, table terminated by $ff). FindStoryScriptEntry
; ($0a:$53e4) matches `id` (and `facing_mask`, a FACEMASK_* constant in
; constants.inc, against the actor's facing), checks `flag_cond`, then runs
; `handler` with the two arg bytes.
; Usage: map_script id, facing_mask, flag_cond, handler, arg0, arg1
MACRO map_script
	db \\1, \\2
	dw \\3, \\4
	db \\5, \\6
ENDM

; Story match launcher: store the 16-bit big-endian match id into
; wCurrentMinigameStoryMatch ($c8f6/$c8f7), then load that match's settings via
; FarPtr_LoadMatchSettingsFromTable. The high byte is the category
; (0 singles, 1 doubles, 2 minigame/practice) and the low byte the match; see
; the wCurrentMinigameStoryMatch id table in docs/ram_map.md. The standalone
; launcher stubs follow it with a ret; some callers continue with more setup.
; Usage: load_match_settings match_id
MACRO load_match_settings
	ld a, HIGH(\\1)
	ld [wCurrentMinigameStoryMatch], a
	ld a, LOW(\\1)
	ld [wCurrentMinigameStoryMatch + 1], a
	farcall FarPtr_LoadMatchSettingsFromTable
ENDM

; Story location record (6 bytes) in bank $0a's StoryLocationTable, indexed by
; wStoryModeCurrentLocation (GetStoryLocationRecordPtr). `map_scripts` is a
; slot in the target bank's $4000 directory (a DataPtr_*MapScripts label); the
; engine copies its 7-word map_tree to $c286 (LoadStoryLocationHeader), loads
; `scene` graphics (LoadStorySceneGraphics), and plays `bgm` ($ff = none).
; Usage: story_location id, scene, map_scripts, bgm
MACRO story_location
	db \\1, \\2
	dslot \\3
	db \\4, $00
ENDM

; Cutscene script commands. Story cutscenes are hand-written native code: fixed
; register setups feeding farcalls into the script engine (FarPtr_Script*, bank
; $0a). Each macro collapses one setup+farcall; the disassembler emits them via
; script_cmd_seq. `actor` is the target actor slot (ACTOR_PLAYER = the player).
; Usage: script_move_target actor, x, y
MACRO script_move_target
	ld a, \\1
	ld bc, \\2
	ld de, \\3
	farcall FarPtr_ScriptSetActorMoveTarget
ENDM
; Instantly places an actor (no walking).
; Usage: script_set_position actor, x, y
MACRO script_set_position
	ld a, \\1
	ld bc, \\2
	ld de, \\3
	farcall FarPtr_ScriptSetActorPosition
ENDM
; Usage: script_move_angle actor, angle, distance  (angle is a FACE_* cardinal)
MACRO script_move_angle
	ld a, \\1
	ld b, \\2
	ld de, \\3
	farcall FarPtr_MoveActorByAngle
ENDM
; Usage: script_set_speed actor, speed
MACRO script_set_speed
	ld a, \\1
	ld bc, \\2
	farcall FarPtr_ScriptSetActorMoveSpeed
ENDM
; Sets an actor's jump velocity (de, signed 16-bit).
; Usage: script_jump_velocity actor, velocity
MACRO script_jump_velocity
	ld a, \\1
	ld de, \\2
	farcall FarPtr_ScriptSetActorJumpVelocity
ENDM
; Usage: script_move_player x, y (moves actor $00, the player)
MACRO script_move_player
	xor a, a
	ld bc, \\1
	ld de, \\2
	farcall FarPtr_MovePlayerToPosition
ENDM
; Usage: script_player_speed speed
MACRO script_player_speed
	ld bc, \\1
	farcall FarPtr_SetPlayerMoveSpeed
ENDM
; Usage: script_set_text text_id (sets the next dialogue's text)
MACRO script_set_text
	ld hl, \\1
	farcall FarPtr_InitDialogueTextCursor
ENDM
; Usage: script_set_anim actor, anim
MACRO script_set_anim
	ld a, \\1
	ld d, \\2
	farcall FarPtr_ScriptSetActorAnimation
ENDM
; Installs object definition `objdef` into `actor`: fetch the actor's state
; pointer into bc, then LoadActorObjectDefIfValid(bc, d = objdef).
; Usage: script_set_objdef objdef, actor
MACRO script_set_objdef
	ld d, \\1
	ld a, \\2
	farcall FarPtr_GetActorStateAddr
	ld c, l
	ld b, h
	farcall FarPtr_LoadActorObjectDefIfValid
ENDM
; Fetch `actor`'s state-struct address ($d000 + actor*$40) into hl. Callers
; then copy it into bc/de to read or write state fields. GetActorStateAddr
; ($0a:$4311).
; Usage: script_get_actor_state actor
MACRO script_get_actor_state
	ld a, \\1
	farcall FarPtr_GetActorStateAddr
ENDM
; Usage: script_face actor, facing  (facing is a FACE_* constant)
MACRO script_face
	ld a, \\1
	ld b, \\2
	farcall FarPtr_SetActorFacing
ENDM
; Turns two actors to face each other (actor1 in b, actor2 in a).
; Usage: script_face_pair actor1, actor2
MACRO script_face_pair
	ld a, \\1
	ld b, a
	ld a, \\2
	farcall FarPtr_FaceActorsTowardEachOther
ENDM
; Turns `actor` (in b) to face `target` (in a); only `actor` turns.
; Usage: script_face_toward actor, target
MACRO script_face_toward
	ld a, \\1
	ld b, a
	ld a, \\2
	farcall FarPtr_FaceActorTowardActor
ENDM
; Sets an actor's facing and locks it (won't auto-turn while walking).
; Usage: script_facing_lock actor, facing
MACRO script_facing_lock
	ld a, \\1
	ld b, \\2
	farcall FarPtr_ScriptSetActorFacingLock
ENDM
; Writes `state` to the actor's activity byte (state struct +$20).
; Usage: script_set_active actor, state
MACRO script_set_active
	ld a, \\1
	ld b, \\2
	farcall FarPtr_SetActorActive
ENDM
; Walks the player to `actor` (b is a position offset, always $00 here).
; Usage: script_move_player_to_actor actor
MACRO script_move_player_to_actor
	ld a, \\1
	ld b, $00
	farcall FarPtr_MovePlayerToActor
ENDM
; Usage: script_speak actor
MACRO script_speak
	ld a, \\1
	farcall FarPtr_ScriptShowSpeakerDialogue
ENDM
; Usage: script_wait_idle actor
MACRO script_wait_idle
	ld a, \\1
	farcall FarPtr_ScriptWaitActorIdle
ENDM
; Usage: script_wait_move actor
MACRO script_wait_move
	ld a, \\1
	farcall FarPtr_ScriptWaitActorMoveDone
ENDM
; Blocks the cutscene until `actor`'s script finishes (CheckActorScriptEnd),
; advancing a frame each poll, with a ~600-frame timeout. WaitActorScriptDone
; ($0a:$4372).
; Usage: script_wait_actor_script actor
MACRO script_wait_actor_script
	ld a, \\1
	farcall FarPtr_WaitActorScriptDone
ENDM
; Detaches `actor`'s script: installs the shared null/idle script ($0a:$4766)
; via SetActorScript so the actor stops running its own bytecode and the
; cutscene can drive it directly. SetActorNullScript ($0a:$4364).
; Usage: script_null_script actor
MACRO script_null_script
	ld a, \\1
	farcall FarPtr_SetActorNullScript
ENDM
; Waits `frames` frames, preserving a (callers hold an actor id there while the
; wait clobbers it with the frame count).
; Usage: script_wait_frames frames
MACRO script_wait_frames
	push af
	ld a, \\1
	farcall FarPtr_WaitScriptFrames
	pop af
ENDM

; Copy a width x height tile rectangle between two scene-tilemap cells
; (CopySceneTilemapRect, $0a:$619e -- CopyMemoryBC of `width` tiles per row for
; `height` rows). Source cell is (src_col, src_row), dest cell (dst_col,
; dst_row); addresses via GetSceneTilemapAddr ($d000 + col + row*$40).
; Usage: script_copy_scene_rect src_col, src_row, dst_col, dst_row, width, height
MACRO script_copy_scene_rect
	ld b, \\1
	ld c, \\2
	ld d, \\3
	ld e, \\4
	ld h, \\5
	ld l, \\6
	farcall FarPtr_CopySceneTilemapRect
ENDM

; Wait `frames` frames through WaitScriptFramesSaveA ($27:$7856), the
; af-preserving subroutine wrapper around FarPtr_WaitScriptFrames.
; Usage: script_delay frames
MACRO script_delay
	ld a, \\1
	call WaitScriptFramesSaveA
ENDM

; Start a screen fade-in at speed `speed` (BeginFadeIn, $00:$1d2e; speed 0 is
; treated as 1). Usage: script_fade_in speed
MACRO script_fade_in
	ld c, \\1
	call BeginFadeIn
ENDM

; Set actor `actor`'s script to `script`, a code pointer in the current bank
; (captured through hRomBank into b). ScriptSetActorScript ($0a:$434f).
; Usage: script_set_actor_script actor, script
MACRO script_set_actor_script
	ldh a, [hRomBank]
	ld b, a
	ld a, \\1
	ld de, \\2
	farcall FarPtr_ScriptSetActorScript
ENDM

; Match-result tilemap-copy record (routine at $16:$4a71, via CopyTilemapRect):
; copy a `rows`-tall, 2-tile-wide rectangle from `src` to `dest` in the BG
; tilemap shadow. Lists live in MatchResultTilemapScripts_16, one per result
; layout, and end with a tilemap_copy_end sentinel.
; Usage: tilemap_copy dest, src, rows
MACRO tilemap_copy
	dw \\1, \\2
	db \\3
ENDM

; Terminates a tilemap_copy list: an all-zero record (the routine stops when a
; record's dest word is $0000; the remaining record bytes are unread).
MACRO tilemap_copy_end
	ds 5, $00
ENDM

; Tilemap-assembly record (dispatch at $39:$4e11, via CopyTilemapRect): copy a
; `height`x`width` rectangle from `src` to `dest` in the tilemap shadow (and
; again at a +$0400 buffer offset). Lists end with tilemap_rect_end (a record
; whose height byte is 0, which the loop stops on).
; Usage: tilemap_rect src, dest, height, width
MACRO tilemap_rect
	dw \\1, \\2
	db \\3, \\4
ENDM

MACRO tilemap_rect_end
	ds 6, $00
ENDM

; QueueSpriteTemplate ($1e9d) sprite record: one hardware sprite as {dy, dx,
; tile, attr} deltas added to the base position/tile/attr passed in the call.
; A list ends with oam_sprite_end (a $80 dy byte, which the loader stops on).
; Usage: oam_sprite dy, dx, tile, attr
MACRO oam_sprite
	db \\1, \\2, \\3, \\4
ENDM

MACRO oam_sprite_end
	db $80
ENDM

; Match-result graphics set (loader $16:$4e54): three LZ tile streams
; decompressed to VRAM $8900, $8a40, $9140 (20 tiles each). Records live in
; GfxSetPointerTable_16 and are selected by the remapped match gfx index.
; Usage: gfx_set tiles_lo, tiles_mid, tiles_hi
MACRO gfx_set
	dw \\1, \\2, \\3
ENDM
"""


MAP_TREE_SLOTS = ("EntryPoints", "ExitTriggers", "Actors", "NpcScripts",
                  "FacingScripts", "TileTriggers", "InitScript")

# Overworld actor facing byte (map_actor `facing`, map_entry `sprite`): the top
# 2 bits are a direction index (CheckTriggerFacingMask $0a:$53bd). Rendered as
# the FACE_* constants from constants.inc.
ACTOR_FACING_NAMES = {0x00: "FACE_RIGHT", 0x40: "FACE_DOWN",
                      0x80: "FACE_LEFT", 0xc0: "FACE_UP"}
# map_script `facing_mask`: a PADF-layout mask the actor's facing must match
# ($ff = any). Rendered as the FACEMASK_* constants from constants.inc.
FACING_MASK_NAMES = {0xff: "FACEMASK_ANY", 0x10: "FACEMASK_RIGHT",
                     0x20: "FACEMASK_LEFT", 0x40: "FACEMASK_UP",
                     0x80: "FACEMASK_DOWN"}

# Story-location names, indexed by location id, from the in-game name popup
# (text id $0179 + loc = string bank $30 index 377 + loc). Annotates the
# StoryLocationTable so each record documents which location it selects.
STORY_LOCATION_NAMES = (
    "Main Menu", "Development", "Small Char. Test", "Test", "Test 2",
    "Academy Main Bldg.", "Academy Wing", "Courtyard", "Restaurant Plaza",
    "Dorm Entrance", "Dorm Room", "Junior Class Court", "Junior Class Court",
    "Restaurant", "Cafeteria", "Training Court", "Senior Class Court",
    "Training Center", "Tennis Machine Room", "Wall Practice Room",
    "Academy Entrance", "Tournament Courtyard", "Court #1", "Court #2",
    "Center Court", "Tournament", "Awards Ceremony", "Island Sky",
    "Special Court", "Peach's Castle", "End1 Main Bldg", "End Restaurant Ent.",
    "End3 Dorm Ent.", "End4 Jr. Court", "End5 Service Ace", "End7 Training Ctr.",
    "End8 Sr. Court", "End10 Varsity Court", "End11 Training Court",
    "End12 Principal's Office", "End16 Before Finals", "End17 Award Ceremony")


# Actor-script opcode -> (macro, operand kinds). 'b' = byte, 'w' = little-endian
# word, 'rel' = signed rel16 jump (relative to the operand address). Instruction
# size is 1 + sum(operand widths). Handlers live in bank $04 at the addresses in
# the comments; see MACROS_INC / docs/actor_script.md.
ACTOR_SCRIPT_OPS = {
    0x00: ("as_halt", []),          0x01: ("as_wait", ["b"]),
    0x02: ("as_wait_move", []),     0x03: ("as_set_target", ["w", "w"]),
    0x04: ("as_set_pos", ["w", "w"]), 0x05: ("as_halt5", []),
    0x06: ("as_target_rel", ["w", "w"]), 0x07: ("as_move", ["b", "w"]),
    0x08: ("as_move_rel", ["b", "w"]), 0x09: ("as_rand_box", ["b", "b"]),
    0x0a: ("as_step", []),          0x0b: ("as_follow_wp", []),
    0x0c: ("as_jump", ["rel"]),     0x0d: ("as_set_field", ["b", "w"]),
    0x0e: ("as_add_field", ["b", "w"]), 0x0f: ("as_halt15", []),
    0x10: ("as_anim", ["b"]),       0x11: ("as_sound", ["b"]),
    0x12: ("as_call", ["w"]),       0x13: ("as_begin_path", []),
    0x14: ("as_wait_move2", []),    0x15: ("as_flag", ["b", "b", "b"]),
}
ACTOR_SCRIPT_SIZE = {
    op: 1 + sum(2 if k in ("w", "rel") else 1 for k in spec)
    for op, (_m, spec) in ACTOR_SCRIPT_OPS.items()
}


def decode_actor_script(rom, start, end, labels=None):
    """Linearly decode the actor-script prefix of a blob into (instrs, targets,
    consumed). instrs is [(off, opcode, operand_bytes)]; targets is the set of
    in-prefix offsets that as_jump lands on (for local labels); consumed is the
    byte length of the decoded prefix. Decoding stops at the first byte that is
    not a valid opcode (or would overrun), so a script followed by an
    unclassified tail decodes up to the tail. Returns None if nothing decodes,
    or if an as_jump escapes to somewhere that is neither an in-prefix
    instruction boundary nor a known (curated) script label -- then the whole
    region is left unclassified. `labels` lets a jump cross into another
    labelled entry point of an overlapping script (rendered as a global ref)."""
    labels = labels or {}
    off, instrs, targets = start, [], set()
    while off < end:
        op = rom[off]
        if op not in ACTOR_SCRIPT_SIZE:
            break
        size = ACTOR_SCRIPT_SIZE[op]
        if off + size > end:
            break
        operand = rom[off + 1:off + size]
        instrs.append((off - start, op, operand))
        if op == 0x0c:
            rel = int.from_bytes(operand, "little", signed=True)
            targets.add((off + 1 - start) + rel)
        off += size
    consumed = off - start
    if not instrs:
        return None
    boundaries = {o for o, _, _ in instrs}
    for t in targets:
        internal = 0 <= t < consumed and t in boundaries
        if not (internal or (start + t) in labels):
            return None
    return instrs, targets, consumed


def render_actor_script(rom, start, end, bank, labels):
    """Render an actor-script bytecode blob as as_* macro calls, returning
    (rows, consumed). `consumed` is the decoded prefix length; when it is less
    than end-start the caller emits the remaining bytes as an unclassified tail.
    An as_jump into this segment becomes a local label (.L<off>); one that
    crosses into another labelled entry point emits that global label (execution
    falls through / jumps between the overlapping fragments of a shared script).
    as_call pointers resolve to a same-bank label when one exists. The parent
    label is emitted by the caller."""
    base = bank * BANK_SIZE
    decoded = decode_actor_script(rom, start, end, labels)
    if decoded is None:
        return None
    instrs, targets, consumed = decoded
    local = {t for t in targets if 0 <= t < consumed and (start + t) not in labels}
    out = []
    for off, op, operand in instrs:
        if off in local:
            out.append(f".L{off:x}:")
        macro, kinds = ACTOR_SCRIPT_OPS[op]
        args, i = [], 0
        for k in kinds:
            if k == "b":
                args.append(f"${operand[i]:02x}")
                i += 1
            elif k == "w":
                word = operand[i] | (operand[i + 1] << 8)
                ref = None
                if op == 0x12 and 0x4000 <= word < 0x8000:
                    ref = labels.get(base + word - 0x4000)
                elif op == 0x0d and args and args[0] == "$14":
                    # as_set_field $14 (the actor facing field) -> FACE_* value
                    ref = ACTOR_FACING_NAMES.get(word)
                args.append(ref or f"${word:04x}")
                i += 2
            elif k == "rel":
                rel = int.from_bytes(operand, "little", signed=True)
                tgt = off + 1 + rel
                args.append(labels.get(start + tgt) or f".L{tgt:x}")
                i += 2
        out.append(f"\t{macro} {', '.join(args)}" if args else f"\t{macro}")
    return out, consumed


def render_map_table(spec, rom, seg, end, bank, labels):
    """Render a story-mode map-script sub-table (map_actor/map_entry/
    map_script) as macro calls. Pointer fields (actor object defs, entry
    arrival scripts, script handlers/conditions) resolve to same-bank labels;
    positions and ids stay literal. Records run until the table's terminator
    ($ff), which plus any padding is emitted as raw db."""
    base = bank * BANK_SIZE

    def word(o):
        return rom[o] | (rom[o + 1] << 8)

    def sym(o):
        v = word(o)
        if 0x4000 <= v < 0x8000 and base + v - 0x4000 in labels:
            return labels[base + v - 0x4000]
        return f"${v:04x}"

    def facing(v):
        return ACTOR_FACING_NAMES.get(v, f"${v:02x}")

    def facemask(v):
        return FACING_MASK_NAMES.get(v, f"${v:02x}")

    out, p = [], seg
    if spec == "map_tree":
        for r, role in enumerate(MAP_TREE_SLOTS):
            v = word(seg + r * 2)
            tgt = base + v - 0x4000 if 0x4000 <= v < 0x8000 else None
            ref = labels.get(tgt) if tgt else None
            out.append(f"\tdw {ref or f'${v:04x}'} ; slot {r} {role}")
        return out
    if spec == "map_actors":
        # A slot may hold several back-to-back actor lists (runtime-selected
        # variants), each ended by the 9x$00 + $ff sentinel the engine stops on
        # (SpawnActorsFromList $04:$4d10 halts when a record's byte +9 is $ff).
        # Emit every list until a run that isn't a clean sentinel is reached.
        def emit_actors():
            nonlocal p
            while p + 14 <= end and rom[p + 9] != 0xFF:
                out.append(f"\tmap_actor {sym(p)}, {sym(p + 2)}, ${word(p + 4):04x}, "
                           f"${word(p + 6):04x}, {facing(rom[p + 8])}, ${rom[p + 10]:02x}, "
                           f"${rom[p + 11]:02x}, ${rom[p + 12]:02x}")
                p += 14
        emit_actors()
        while p + 10 <= end and rom[p:p + 10] == b"\x00" * 9 + b"\xff":
            out.append("\tmap_actor_end")
            p += 10
            emit_actors()
    elif spec == "map_entries":
        while p + 8 <= end and rom[p] != 0xFF:
            out.append(f"\tmap_entry ${rom[p]:02x}, {facing(rom[p + 1])}, "
                       f"${word(p + 2):04x}, ${word(p + 4):04x}, {sym(p + 6)}")
            p += 8
    elif spec == "map_scripts":
        while p + 8 <= end and rom[p] != 0xFF:
            # handler < $4000 is a dialogue text id (RunStoryScriptOrDialogue
            # $0a:$541d routes it to ShowSpeakerDialogue), not a code pointer.
            handler = sym(p + 4)
            if handler.startswith("$"):
                handler = text_id_name(word(p + 4)) or handler
            out.append(f"\tmap_script ${rom[p]:02x}, {facemask(rom[p + 1])}, "
                       f"{sym(p + 2)}, {handler}, ${rom[p + 6]:02x}, "
                       f"${rom[p + 7]:02x}")
            p += 8
    while p < end:
        n = min(end - p, 8)
        out.append("\tdb " + ", ".join(f"${rom[p + k]:02x}" for k in range(n)))
        p += n
    return out


def render_tilemap_scripts(rom, start, end):
    """Render the match-result tilemap-copy scripts (routine at $16:$4a71). A
    self-delimiting dw pointer table (one entry per result layout, selected by
    wCurrentMinigameStoryMatch's low byte at $c8f7) precedes a run of
    variable-length copy lists. Each list is a run of 5-byte `tilemap_copy
    dest, src, rows` records ended by an all-zero record (`tilemap_copy_end`):
    the routine stops when a record's dest word is $0000, and walks farcalling
    CopyTilemapRect (width fixed at 2 tiles) per record. Pointers become
    `.scriptN` local labels so they track their list bodies."""
    base = offset_to_cpu(start)
    first = rom[start] | (rom[start + 1] << 8)
    nptr = (first - base) // 2
    labels_at = {}
    out = []
    for i in range(nptr):
        v = rom[start + i * 2] | (rom[start + i * 2 + 1] << 8)
        labels_at.setdefault(v, []).append(i)
        out.append(f"\tdw .script{i} ; {i}")

    o = start + nptr * 2
    while o < end:
        for i in labels_at.get(offset_to_cpu(o), []):
            out.append(f".script{i}:")
        dest = rom[o] | (rom[o + 1] << 8)
        if dest == 0:
            out.append("\ttilemap_copy_end")
        else:
            src = rom[o + 2] | (rom[o + 3] << 8)
            out.append(f"\ttilemap_copy ${dest:04x}, ${src:04x}, {rom[o + 4]}")
        o += 5
    return out


def render_tilemap_dispatch(rom, start, end):
    """Render the two-level tilemap-assembly dispatch ($39:$4e60, indexer at
    $39:$4e11). A self-delimiting L1 pointer table (indexed by b) points at L2
    pointer tables (indexed by c) that point at lists of 6-byte
    {src, dest, height, width} records ended by a height-0 record. L1/L2 tables
    become `.l2_N`/`.rl_N` locals; records render as `tilemap_rect` macros."""
    base = offset_to_cpu(start)
    end_cpu = base + (end - start)

    def flat(cpu):
        return start + (cpu - base)

    def w(cpu):
        f = flat(cpu)
        return rom[f] | (rom[f + 1] << 8)

    # L1 and the packed L2 region each self-delimit at their lowest target.
    p, lo, l1 = base, 0xFFFF, []
    while p < lo:
        v = w(p); l1.append(v); lo = min(lo, v); p += 2
    l1_end = p
    q, lo2 = l1_end, 0xFFFF
    while q < lo2:
        lo2 = min(lo2, w(q)); q += 2
    rec_start = lo2
    l2_idx = {a: i for i, a in enumerate(sorted(set(l1)))}
    rl_targets = {w(c) for c in range(l1_end, rec_start, 2)}
    rl_idx = {a: i for i, a in enumerate(
        sorted(a for a in rl_targets if rec_start <= a < end_cpu))}

    out = [f"\tdw .l2_{l2_idx[v]} ; {i}" for i, v in enumerate(l1)]
    cpu = l1_end
    while cpu < rec_start:
        if cpu in l2_idx:
            out.append(f".l2_{l2_idx[cpu]}:")
        t = w(cpu)
        out.append(f"\tdw {'.rl_%d' % rl_idx[t] if t in rl_idx else f'${t:04x}'}")
        cpu += 2
    while cpu < end_cpu:
        if cpu in rl_idx:
            out.append(f".rl_{rl_idx[cpu]}:")
        f = flat(cpu)
        if rom[f + 4] == 0:
            if any(rom[f:f + 6]):
                out.append("\tdb " + ", ".join(f"${b:02x}" for b in rom[f:f + 6]))
            else:
                out.append("\ttilemap_rect_end")
        else:
            out.append(f"\ttilemap_rect ${rom[f] | (rom[f+1]<<8):04x}, "
                       f"${rom[f+2] | (rom[f+3]<<8):04x}, "
                       f"${rom[f+4]:02x}, ${rom[f+5]:02x}")
        cpu += 6
    return out


def render_gfx_ptr_table(rom, start, end, bank, data_labels):
    """Render the match-result graphics selector ($16:$4e9d, loader $16:$4e54).
    A self-delimiting dw pointer table indexes 6-byte descriptor records, each
    three dw pointers to LZ tile streams (decompressed to VRAM $8900/$8a40/
    $9140). Pointers become `.recN` locals; each record is a `gfx_set` of the
    three streams, resolved to their Lz_* blob labels."""
    fbase = bank * BANK_SIZE
    base = offset_to_cpu(start)

    def word(o):
        return rom[o] | (rom[o + 1] << 8)

    def sym(v):
        return data_labels.get(fbase + v - BANK_SIZE, f"${v:04x}")

    rec_start = min(word(start), word(start + 2))
    nptr = (rec_start - base) // 2
    out = []
    for i in range(nptr):
        v = word(start + i * 2)
        out.append(f"\tdw .rec{(v - rec_start) // 6} ; {i}")
    o = start + nptr * 2
    while o < end:
        out.append(f".rec{(offset_to_cpu(o) - rec_start) // 6}:")
        out.append(f"\tgfx_set {sym(word(o))}, {sym(word(o + 2))}, "
                   f"{sym(word(o + 4))}")
        o += 6
    return out


def render_lz_ptr_table(rom, start, end, bank, data_labels):
    """Render a direct LZ pointer table (e.g. $16:$60f1, $16:$6968): a dw table
    of pointers straight to LZ tile streams, indexed by the portrait variant /
    character id. Each entry resolves to its Lz_* blob label."""
    fbase = bank * BANK_SIZE
    out = []
    for i, o in enumerate(range(start, end, 2)):
        v = rom[o] | (rom[o + 1] << 8)
        out.append(f"\tdw {data_labels.get(fbase + v - BANK_SIZE, f'${v:04x}')}"
                   f" ; {i}")
    return out


def render_object_header(rom, off, data_labels, ptr_labels):
    """Render a 16-byte sprite/object header as committed db/dw source: a
    count byte, three flag bytes, then six pointers into the record's body.
    Bank $04's loader copies these to $dad0 and expands them into an actor
    struct (word 0 -> +$24, word 1 -> +$28, word 2 dereferenced for an
    8-byte subrecord, word 3 -> +$38). Being structural (a count and
    pointers, like the DataPtr table above it) they live in the source, not
    the gitignored data blobs. Body pointers resolve to the labels of the
    sub-blobs split_object_bodies() carved; the rest stay literal (they aim
    inside the header itself, or at another record)."""
    b = rom[off:off + 16]
    base = (off // BANK_SIZE) * BANK_SIZE

    def lbl(w):
        tgt = base + w - BANK_SIZE
        if tgt == off + 0x0A:  # the inline frame-pointer array (words 3-5+)
            return ".frames"
        return data_labels.get(tgt) or ptr_labels.get(tgt) or f"${w:04x}"

    w = [b[4 + 2 * i] | (b[5 + 2 * i] << 8) for i in range(6)]
    return [f"\tdb ${b[0]:02x}, ${b[1]:02x}, ${b[2]:02x}, ${b[3]:02x} ; count, flags",
            f"\tdw {lbl(w[0])}, {lbl(w[1])}, {lbl(w[2])} ; frame array, OAM array, frame array",
            ".frames:",
            f"\tdw {lbl(w[3])}, {lbl(w[4])}, {lbl(w[5])} ; frame pointers (continue in body)"]


def emit(dis, labels, hwregs, ramnames, srcdir, manifest_path, data_tables=None,
         curated=None, ramscoped=None, constants=None, const_defs=None):
    data_tables = data_tables or {}
    curated = curated or set()
    constants = constants or {}
    const_defs = const_defs or {}
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
    data_entries = {e: v for e, v in dis.data_slots.items()
                    if e not in table_entries
                    and e not in dis.code_bytes and e + 1 not in dis.code_bytes}
    for entry, (bank, slot, target) in dis.inferred_entries.items():
        if entry in data_entries:
            continue
        if entry not in dis.code_bytes and entry + 1 not in dis.code_bytes:
            table_entries.setdefault(entry, (bank, slot, target))
    jt_entries = {p: t for p, t in dis.jt_entries.items()
                  if p not in dis.code_bytes and p + 1 not in dis.code_bytes
                  and p not in table_entries and p not in data_entries}

    # Blob labels/extents for data-slot targets. A mark can only anchor a
    # label if it starts outside every other emitted structure; marks inside
    # an earlier mark's exact extent are dropped (their dw falls back to a
    # numeric operand).
    data_marks = {}   # src_flat -> (length or None, label, kind)
    data_labels = {}  # src_flat -> label
    prev_end = -1
    for src in sorted(dis.data_blobs):
        length, kind = dis.data_blobs[src]
        if (src < prev_end or src in dis.code_bytes or src in table_entries
                or src in data_entries or src in jt_entries
                or src in dis.ptr_words):
            continue
        stem = {"lz": "Lz", "sprite": "SpriteTemplate"}.get(kind, "Data")
        label = labels.get(src) or \
            f"{stem}_{src // BANK_SIZE:02x}_{offset_to_cpu(src):04x}"
        data_marks[src] = (length, label, kind)
        data_labels[src] = label
        if length:
            prev_end = max(prev_end, src + length)
    Path(srcdir).parent.joinpath("include", "macros.inc").write_text(MACROS_INC)

    # Curated data labels (named non-code offsets) whose address an immediate
    # pointer load may reference by name.
    operand_labels = {o: n for o, n in labels.items() if o not in dis.instrs}

    # Semantic slot names: a $4000-table slot whose target carries a label is
    # named after it, so call sites read `farcall FarPtr_DrawBox` instead of
    # `farcall FarPtr_18_xx`. When several slots point at the same target
    # (dual-purpose scene slots, defaulted fan-in ranges), the first is
    # <Prefix>_<Target> and the rest are <Prefix>_<Target>Alias1, Alias2, ...
    # so every duplicate reads back to its target instead of an opaque numeric
    # slot. A singleton whose target isn't curated keeps its numeric name.
    far_slot_names = {}   # (bank, slot) -> label
    data_slot_names = {}  # (bank, slot) -> label
    used_slot_names = set()

    def assign_slot_names(entries, label_of, prefix, out):
        groups = {}
        for entry in sorted(entries):
            groups.setdefault(entries[entry][2], []).append(entry)
        for target, ents in groups.items():
            label = label_of(target)
            if not label or (len(ents) == 1 and label not in curated):
                continue
            base = f"{prefix}_{label}"
            for i, entry in enumerate(ents):
                name = base if i == 0 else f"{base}Alias{i}"
                while name in used_slot_names:
                    name += "_"
                used_slot_names.add(name)
                bank, slot = entries[entry][:2]
                out[(bank, slot)] = name

    assign_slot_names(table_entries, labels.get, "FarPtr", far_slot_names)
    assign_slot_names(data_entries, data_labels.get, "DataPtr", data_slot_names)

    def slot_ref(w):
        """The emitted label of the $4000-table slot a (bank<<8|slot) word
        references, or None if that entry isn't a labeled dw."""
        entry = (w >> 8) * BANK_SIZE + (w & 0xFF)
        if entry in data_entries:
            b, s = data_entries[entry][:2]
            return data_slot_names.get((b, s), f"DataPtr_{b:02x}_{s:02x}")
        if entry in table_entries:
            b, s, _t = table_entries[entry]
            return far_slot_names.get((b, s), f"FarPtr_{b:02x}_{s:02x}")
        return None

    # `ld hl, n16` immediately before `call RegisterFrameTask` loads a code
    # pointer (the task function), so resolve it to that function's label - the
    # 400-odd registration sites then read `ld hl, UpdateActors` instead of raw
    # hex. Gated on the following call so numeric constants aren't touched.
    register_frame_task = next(
        (o for o, n in labels.items() if n == "RegisterFrameTask"), None)
    frametask_ptr_sites = {}
    if register_frame_task is not None:
        for o, ins in dis.instrs.items():
            if rom[o] != 0x21 or o + 3 not in dis.instrs or rom[o + 3] != 0xCD:
                continue  # ld hl, n16 followed by `call nn`
            call_tgt = rom[o + 4] | (rom[o + 5] << 8)
            if target_to_offset(call_tgt, o + 3) != register_frame_task:
                continue
            imm = rom[o + 1] | (rom[o + 2] << 8)
            b = (o // BANK_SIZE) * BANK_SIZE
            flat = imm if imm < 0x4000 else (b + imm - 0x4000 if b else None)
            if flat in labels:
                frametask_ptr_sites[o] = labels[flat]

    for bank in range(nbanks):
        base = bank * BANK_SIZE
        lines = []
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
                sl = far_slot_names.get((tbank, slot),
                                        f"FarPtr_{tbank:02x}_{slot:02x}")
                lines.append(f"{sl}:")
                lines.append(f"\tdw {tl} ; ${offset_to_cpu(off):04x}")
                off += 2
            elif off in dis.ptr_words:
                target, note = dis.ptr_words[off]
                lbl = labels.get(off) or dis.ptr_labels.get(off)
                if lbl:
                    lines.append(f"{lbl}:")
                if target is None:
                    tl = f"${rom[off] | (rom[off + 1] << 8):04x}"
                else:
                    tl = (labels.get(target) or dis.ptr_labels.get(target)
                          or data_labels.get(target)
                          or f"${offset_to_cpu(target):04x}")
                suffix = f" {note}" if note else ""
                lines.append(f"\tdw {tl} ; ${offset_to_cpu(off):04x}{suffix}")
                off += 2
            elif off in data_entries:
                dbank, slot, src, _kind = data_entries[off]
                tl = data_labels.get(src, f"${offset_to_cpu(src):04x}")
                sl = data_slot_names.get((dbank, slot),
                                         f"DataPtr_{dbank:02x}_{slot:02x}")
                lines.append(f"{sl}:")
                lines.append(f"\tdw {tl} ; ${offset_to_cpu(off):04x}")
                off += 2
            elif off in jt_entries:
                if off in labels and lines[-1] != f"{labels[off]}:":
                    lines.append(f"{labels[off]}:")
                target = jt_entries[off]
                tl = labels.get(target, f"${offset_to_cpu(target):04x}")
                lines.append(f"\tdw {tl} ; ${offset_to_cpu(off):04x} jumptable")
                off += 2
            elif off in dis.instrs:
                if off in labels:
                    lines.append(f"{labels[off]}:")
                ins = dis.instrs[off]
                cpu = offset_to_cpu(off)
                wb = wram_bank_seq(dis, rom, off, labels) \
                    if 0xFF96 in ramnames else None
                if wb:
                    text, size = wb
                    lines.append(f"\t{text} ; ${cpu:04x}")
                    off += size
                    continue
                ml = match_launcher_seq(dis, rom, off, labels)
                if ml:
                    text, size = ml
                    lines.append(f"\t{text} ; ${cpu:04x}")
                    off += size
                    continue
                sc = script_cmd_seq(dis, rom, off, labels, far_slot_names)
                if sc:
                    text, size = sc
                    lines.append(f"\t{text} ; ${cpu:04x}")
                    off += size
                    continue
                if off in frametask_ptr_sites:
                    lines.append(f"\tld hl, {frametask_ptr_sites[off]} ; ${cpu:04x}")
                    off += ins.size
                    continue
                if off in dis.farcalls and ins.text == "farcall {far}":
                    fbank, slot, entry, _target = dis.farcalls[off]
                    if off in dirty_sites:
                        lines.append(f"\trst Rst18 ; ${cpu:04x}")
                        lines.append(f"\tdb ${slot:02x}, ${fbank:02x} ; farcall operands (slot bytes overlap code)")
                    else:
                        sl = far_slot_names.get((fbank, slot),
                                                f"FarPtr_{fbank:02x}_{slot:02x}")
                        lines.append(f"\tfarcall {sl} ; ${cpu:04x}")
                elif off in dis.inline_arg_calls and ins.size == 4:
                    lines.append(f"\t{render_operand(ins, off, labels, hwregs, ramnames, operand_labels, ramscoped, constants)} ; ${cpu:04x}")
                    lines.append(f"\tdb ${rom[off+3]:02x} ; ${offset_to_cpu(off+3):04x} inline arg")
                else:
                    note = dis.data_site_notes.get(off)
                    suffix = ""
                    if note:
                        sl = data_slot_names.get(
                            note, f"DataPtr_{note[0]:02x}_{note[1]:02x}")
                        suffix = f" -> {sl}"
                    lines.append(f"\t{render_operand(ins, off, labels, hwregs, ramnames, operand_labels, ramscoped, constants)} ; ${cpu:04x}{suffix}")
                off += ins.size
            else:
                run_start = off
                off += 1
                # A curated label inside a data run splits the run so the
                # symbol anchors its own blob/segment.
                while off < end and off not in dis.instrs \
                        and off not in table_entries and off not in data_entries \
                        and off not in jt_entries and off not in data_marks \
                        and off not in dis.ptr_words \
                        and not (off in labels and labels[off] in curated):
                    off += 1
                length = off - run_start
                cpu = offset_to_cpu(run_start)
                mark = data_marks.get(run_start)
                prefix = "d"
                if mark:
                    mlen, mlabel, kind = mark
                    lines.append(f"{mlabel}:")
                    if mlen and mlen <= length:
                        off = run_start + mlen
                        length = mlen
                    if kind == "lz":
                        prefix = "lz"
                if run_start in dis.object_headers:
                    lines.extend(render_object_header(rom, run_start, data_labels,
                                                      dis.ptr_labels))
                    continue
                if run_start in dis.sprite_templates and mark and mark[0]:
                    lines.append(f"\t; ${cpu:04x}, {length} bytes (sprite_template)")
                    body = render_spec(rom[run_start:run_start + length],
                                       "sprite_template").rstrip("\n")
                    lines.extend(body.split("\n"))
                    continue
                if mark and mark[0]:
                    if run_start in data_tables:
                        spec = data_tables[run_start]
                        lines.append(f"\t; ${cpu:04x}, {length} bytes ({spec})")
                        if spec.startswith("map_"):
                            lines.extend(render_map_table(
                                spec, rom, run_start, run_start + length,
                                bank, labels))
                            continue
                        if spec == "actor_script":
                            result = render_actor_script(
                                rom, run_start, run_start + length,
                                bank, labels)
                            if result is not None:
                                rows, used = result
                                lines.extend(rows)
                                if used < length:
                                    # script prefix, then an unclassified tail
                                    tcpu = cpu + used
                                    tlen = length - used
                                    if all(b == 0xFF for b in
                                           rom[run_start + used:run_start + length]):
                                        lines.append(
                                            f"\tds {tlen}, $ff ; ${tcpu:04x}, fill")
                                    else:
                                        tblob = f"bank_{bank:03x}/d_{tcpu:04x}.bin"
                                        manifest.append(
                                            (tblob, run_start + used, tlen, None))
                                        lines.append(
                                            f'\tINCBIN "data/{tblob}" ; ${tcpu:04x}, '
                                            f'{tlen} bytes (unclassified tail)')
                                continue
                        if spec == "tilemap_scripts":
                            lines.extend(render_tilemap_scripts(
                                rom, run_start, run_start + length))
                            continue
                        if spec == "tilemap_dispatch":
                            lines.extend(render_tilemap_dispatch(
                                rom, run_start, run_start + length))
                            continue
                        if spec == "gfx_ptr_table":
                            lines.extend(render_gfx_ptr_table(
                                rom, run_start, run_start + length,
                                bank, data_labels))
                            continue
                        if spec == "lz_ptr_table":
                            lines.extend(render_lz_ptr_table(
                                rom, run_start, run_start + length,
                                bank, data_labels))
                            continue
                        if spec.startswith("enum:"):
                            _, prefix, cols = spec.split(":")
                            val2name = {v: n for n, v in const_defs.items()
                                        if n.startswith(prefix + "_")}
                            lines.extend(render_enum_table(
                                rom[run_start:run_start + length],
                                val2name, int(cols)))
                            continue
                        body = render_spec(rom[run_start:run_start + length],
                                           spec).rstrip("\n")
                        lines.extend(body.split("\n"))
                        continue
                    if all(b == 0xFF for b in rom[run_start:run_start + length]):
                        # Pointer-targeted but pure mastering fill (unused
                        # trailing $4000-table slots in the scene banks).
                        lines.append(f"\tds {length}, $ff ; ${cpu:04x}, fill")
                        continue
                    blob = f"bank_{bank:03x}/{prefix}_{cpu:04x}.bin"
                    manifest.append((blob, run_start, length, None))
                    lines.append(f'\tINCBIN "data/{blob}" ; ${cpu:04x}, {length} bytes')
                    continue
                # Unclassified run: split out long constant-byte fills as ds
                # directives ($ff is the mastering fill; $00 needs a longer
                # run since zero arrays can be real data; any $ff run that
                # reaches the bank end is trailing fill regardless of length;
                # a run that is entirely $ff is padding whatever its length,
                # e.g. the 5-byte gaps between the rst/interrupt vectors).
                seg = run_start
                while seg < off:
                    b = rom[seg]
                    j = seg
                    while j < off and rom[j] == b:
                        j += 1
                    # A curated label inside a constant-byte run starts its own
                    # segment: never let fill collapse (or the run scan) swallow
                    # it, or the label is dropped and any dw referencing it goes
                    # undefined (e.g. empty $ff map-script lists in $0e/$0f).
                    clab = min((t for t in labels if seg < t < j), default=0)
                    if clab:
                        j = clab
                    if not ((b == 0xFF and (j - seg >= 64 or j == end
                                            or (seg == run_start and j == off)))
                            or (b == 0x00 and j - seg >= 256)):
                        j = seg + 1
                        while j < off:
                            b = rom[j]
                            k = j
                            while k < off and rom[k] == b:
                                k += 1
                            if (b == 0xFF and (k - j >= 64 or k == end)) \
                                    or (b == 0x00 and k - j >= 256):
                                break
                            j = k
                        scpu = offset_to_cpu(seg)
                        # A declared data table or a curated label starting
                        # mid-run ends the current segment, so a region can
                        # hold several back-to-back tables (e.g. a dw pointer
                        # table followed by its payload) and named streams
                        # reached only through non-slot pointers still carve
                        # out of anonymous blobs.
                        stop = min((t for t in data_tables
                                    if seg < t < j), default=0)
                        lstop = min((t for t in labels
                                     if seg < t < j), default=0)
                        if lstop and (not stop or lstop < stop):
                            stop = lstop
                        if stop:
                            j = stop
                        # A slot-record table renders each record as a
                        # `dslot` line of $4000-table slot labels, so the
                        # words track their targets' curated names; a record
                        # whose entries aren't all labeled dw slots falls
                        # back to numeric words.
                        if seg in dis.slot_record_tables:
                            nw = dis.slot_record_tables[seg]
                            stride = 2 * nw
                            if seg in labels and lines[-1] != f"{labels[seg]}:":
                                lines.append(f"{labels[seg]}:")
                            lines.append(f"\t; ${scpu:04x}, {j - seg} bytes "
                                         f"({(j - seg) // stride} records x "
                                         f"{nw} slot words)")
                            for r in range((j - seg) // stride):
                                ro = seg + r * stride
                                ws = [rom[ro + k * 2] | (rom[ro + k * 2 + 1] << 8)
                                      for k in range(nw)]
                                refs = [slot_ref(w) for w in ws]
                                if all(refs):
                                    lines.append("\tdslot " + ", ".join(refs)
                                                 + f" ; record {r}")
                                else:
                                    lines.append("\tdw " + ", ".join(
                                        f"${w:04x}" for w in ws)
                                        + f" ; record {r}")
                            tail = (j - seg) % stride
                            if tail:
                                lines.append("\tdb " + ", ".join(
                                    f"${b:02x}" for b in rom[j - tail:j]))
                            seg = j
                            continue
                        # A declared data table renders as structured source
                        # (palettes/records/bytes) inline, using the same
                        # renderer extract.py applies to blobs.
                        if seg in data_tables:
                            spec = data_tables[seg]
                            if seg in labels and lines[-1] != f"{labels[seg]}:":
                                lines.append(f"{labels[seg]}:")
                            lines.append(f"\t; ${scpu:04x}, {j - seg} bytes ({spec})")
                            # records:2 tables are usually pointer tables;
                            # words that hit a labeled offset in the same
                            # bank render symbolically (same bytes at link).
                            if spec == "records:2" and bank > 0:
                                for r in range((j - seg) // 2):
                                    ro = seg + r * 2
                                    w = rom[ro] | (rom[ro + 1] << 8)
                                    tgt = (bank * 0x4000 + w - 0x4000
                                           if 0x4000 <= w < 0x8000 else None)
                                    ref = labels.get(tgt) if tgt else None
                                    lines.append(f"\tdw {ref or f'${w:04x}'}"
                                                 f" ; record {r}")
                                tail = (j - seg) % 2
                                if tail:
                                    lines.append(f"\tdb ${rom[j - 1]:02x}")
                            elif spec == "map_tree":
                                # A location's 7-word slot directory (copied to
                                # $c286 by bank $0a). Each word points at the
                                # slot's sub-table; render symbolically with the
                                # slot role named.
                                for r, role in enumerate(MAP_TREE_SLOTS):
                                    ro = seg + r * 2
                                    w = rom[ro] | (rom[ro + 1] << 8)
                                    tgt = (bank * 0x4000 + w - 0x4000
                                           if 0x4000 <= w < 0x8000 else None)
                                    ref = labels.get(tgt) if tgt else None
                                    lines.append(f"\tdw {ref or f'${w:04x}'}"
                                                 f" ; slot {r} {role}")
                            elif spec == "story_locations":
                                # 6-byte records: {id, scene, slot, bank, bgm,
                                # $00}. The (slot, bank) pair references the
                                # target bank's $4000 map-script directory, so
                                # render it as a dslot (DataPtr_* label) when
                                # that slot is a known data-pointer entry.
                                for r in range((j - seg) // 6):
                                    ro = seg + r * 6
                                    b = rom[ro:ro + 6]
                                    nm = (f" {STORY_LOCATION_NAMES[r]}"
                                          if r < len(STORY_LOCATION_NAMES) else "")
                                    sr = slot_ref(b[2] | (b[3] << 8))
                                    if sr and b[5] == 0:
                                        lines.append(
                                            f"\tstory_location ${b[0]:02x}, "
                                            f"${b[1]:02x}, {sr}, ${b[4]:02x}"
                                            f" ; loc {r}{nm}")
                                    else:
                                        lines.append(
                                            "\tdb " + ", ".join(f"${x:02x}" for x in b)
                                            + f" ; loc {r} ${b[3]:02x}:$"
                                            f"{0x4000 + b[2]:04x}{nm}")
                                tail = (j - seg) % 6
                                if tail:
                                    lines.append("\tdb " + ", ".join(
                                        f"${rom[j - tail + k]:02x}" for k in range(tail)))
                            elif spec.startswith("map_"):
                                lines.extend(render_map_table(
                                    spec, rom, seg, j, bank, labels))
                            elif spec == "actor_script":
                                result = render_actor_script(
                                    rom, seg, j, bank, labels)
                                if result is None:
                                    lines.append("\tdb " + ", ".join(
                                        f"${x:02x}" for x in rom[seg:j]))
                                else:
                                    rows, used = result
                                    lines.extend(rows)
                                    if used < j - seg:
                                        tcpu = offset_to_cpu(seg + used)
                                        tlen = (j - seg) - used
                                        if all(b == 0xFF for b in rom[seg + used:j]):
                                            lines.append(
                                                f"\tds {tlen}, $ff ; ${tcpu:04x}, fill")
                                        else:
                                            tblob = f"bank_{bank:03x}/d_{tcpu:04x}.bin"
                                            manifest.append(
                                                (tblob, seg + used, tlen, None))
                                            lines.append(
                                                f'\tINCBIN "data/{tblob}" ; ${tcpu:04x}'
                                                f', {tlen} bytes (unclassified tail)')
                            elif spec == "tilemap_scripts":
                                lines.extend(render_tilemap_scripts(
                                    rom, seg, j))
                            elif spec == "tilemap_dispatch":
                                lines.extend(render_tilemap_dispatch(
                                    rom, seg, j))
                            elif spec == "gfx_ptr_table":
                                lines.extend(render_gfx_ptr_table(
                                    rom, seg, j, bank, data_labels))
                            elif spec == "lz_ptr_table":
                                lines.extend(render_lz_ptr_table(
                                    rom, seg, j, bank, data_labels))
                            elif spec.startswith("enum:"):
                                _, prefix, cols = spec.split(":")
                                val2name = {v: n for n, v in const_defs.items()
                                            if n.startswith(prefix + "_")}
                                lines.extend(render_enum_table(
                                    rom[seg:j], val2name, int(cols)))
                            else:
                                body = render_spec(rom[seg:j], spec).rstrip("\n")
                                lines.extend(body.split("\n"))
                            seg = j
                            continue
                        # ASCII dominance (plus the $00-$03 text control
                        # codes) marks a text region; a leading string
                        # offset table (header word + ascending dw run) is
                        # binary, so skip it before measuring. A word-space
                        # floor rejects glyph/tile tables that fall in the
                        # printable range but hold no prose (real game text
                        # runs 12-33% spaces; such tables hold ~0).
                        n = j - seg
                        p, prev = seg + 2, -1
                        while p + 1 < j:
                            w = rom[p] | (rom[p + 1] << 8)
                            if w < prev:
                                break
                            prev, p = w, p + 2
                        body = seg if p - seg < 18 else p
                        m = j - body
                        txt = sum(1 for b in rom[body:j]
                                  if 0x20 <= b < 0x7F or b <= 3)
                        letters = sum(1 for b in rom[body:j]
                                      if 0x61 <= (b | 0x20) <= 0x7A)
                        spaces = rom[body:j].count(0x20)
                        if n >= 32 and m >= 32 and txt >= m * 0.95 \
                                and letters >= m // 3 and spaces >= m // 20:
                            # text renders as generated db source (still
                            # under gitignored data/, so no ROM content
                            # lands in the repository)
                            blob = f"bank_{bank:03x}/text_{scpu:04x}.asm"
                            lines.append(f"Text_{bank:02x}_{scpu:04x}:")
                            lines.append(f'\tINCLUDE "data/{blob}" ; ${scpu:04x}, {n} bytes')
                            manifest.append((blob, seg, n, None))
                        elif n <= INLINE_DB_MAX:
                            # A tiny inter-code run (alignment padding, a stray
                            # constant, or a stranded ret) renders inline rather
                            # than as a standalone one/two-byte blob file. A
                            # lone $c9 wedged between code is a `ret` descent
                            # never reached (its function is entered through a
                            # computed jump/call), so emit it as the ret it is.
                            if seg in labels:
                                lines.append(f"{labels[seg]}:")
                            for k in range(n):
                                b = rom[seg + k]
                                mn = "ret" if b == 0xC9 else f"db ${b:02x}"
                                lines.append(f"\t{mn} ; ${offset_to_cpu(seg + k):04x}")
                        else:
                            if seg in labels:
                                lines.append(f"{labels[seg]}:")
                            blob = f"bank_{bank:03x}/d_{scpu:04x}.bin"
                            lines.append(f'\tINCBIN "data/{blob}" ; ${scpu:04x}, {n} bytes')
                            manifest.append((blob, seg, n, None))
                    else:
                        if seg in labels and lines[-1] != f"{labels[seg]}:":
                            lines.append(f"{labels[seg]}:")
                        lines.append(f"\tds {j - seg}, ${b:02x} "
                                     f"; ${offset_to_cpu(seg):04x}, fill")
                    seg = j
        lines.append("")
        Path(srcdir, f"bank_{bank:03x}.asm").write_text("\n".join(lines))
    # Dialogue text-id constants collected while rendering (script_set_text
    # operands and map_script text-id handlers). Name = the string's
    # bank:index coordinate; value = the raw id, so the assembled bytes are
    # unchanged. Look a string up with `tools/strings.py --index --bank <bank>`.
    text_inc = [
        "; Auto-generated by tools/disasm.py — do not edit.",
        "; Text_<bank>_<index> = a dialogue text id, named by the (text bank :",
        "; string index) coordinate it decodes to. Read the string with",
        "; `tools/strings.py baserom.gbc --index --bank <bank>`.",
        "",
    ]
    for idv, name in sorted(TEXT_IDS_USED.items()):
        text_inc.append(f"def {name} equ ${idv:04x}")
    text_inc.append("")
    Path(srcdir).parent.joinpath("include", "text_ids.inc").write_text(
        "\n".join(text_inc))
    with open(manifest_path, "w") as f:
        f.write("# path  rom_offset(hex)  length(hex)  [render-spec] — consumed by tools/extract.py\n")
        for blob, o, l, spec in manifest:
            f.write(f"{blob} {o:06x} {l:x}" + (f" {spec}\n" if spec else "\n"))
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
    ap.add_argument("--data-tables", default="data_tables.json")
    ap.add_argument("--constants", default="constants.json")
    ap.add_argument("--hardware-inc", default="include/hardware.inc")
    ap.add_argument("--ram-map", default="ram_map.json")
    ap.add_argument("--ram-unions", default="ram_unions.json")
    ap.add_argument("--hooks", nargs="*", default=[],
                    help="hook_client.py dump(s) of data-helper call captures")
    ap.add_argument("--no-descent", action="store_true")
    args = ap.parse_args()

    rom = Path(args.rom).read_bytes()
    dis = Disassembly(rom)
    data_tables = {}
    if Path(args.data_tables).exists():
        data_tables = {int(k, 0): v
                       for k, v in json.loads(Path(args.data_tables).read_text()).items()}
    dis.data_boundaries = set(data_tables)
    seeds = load_coverage(args.coverage, len(rom) // BANK_SIZE)
    print(f"{len(seeds)} coverage seeds")
    dis.seed(seeds)
    overrides = None
    if Path(args.labels).exists():
        overrides = json.loads(Path(args.labels).read_text())
    if not args.no_descent:
        dis.descend()
        # Slot-record tables are ground truth that their referenced slots
        # hold data pointers; prove them before table inference so a data
        # target whose bytes happen to decode as instructions (bank $6b's
        # title-screen tilemap) isn't claimed as an unused code entry and
        # seeded as false code.
        dis.add_slot_record_tables(overrides)
        dis.infer_tables()
        dis.seed_text_entries()
        dis.seed_launcher_stubs()
        # Map-script/entry handlers and arrival scripts are reached only through
        # indirect dispatch (CallHLInBankA), so descent never finds them and
        # their code otherwise falls into the map table's own data blob. Seed
        # the pointers the tables embed so the code is decoded and the records
        # reference each handler by name.
        dis.seed(list(map_script_code_targets(rom, data_tables)))
        dis.descend()
        if dis.infer_twin_tables():
            dis.descend()
        # jump tables and descent feed each other; iterate to a fixed point
        for _ in range(8):
            if not dis.parse_jumptables():
                break
            dis.descend()
    helpers = {}
    if overrides:
        for name, kind in (("CopyDataFromBank", "copy"),
                           ("DecompressDataFromBank", "lz")):
            for k, v in overrides.items():
                if v == name:
                    helpers[int(k, 0)] = kind
    if helpers:
        dis.find_data_slots(helpers)
    if args.hooks:
        dis.load_hook_dumps(args.hooks)
    dis.add_static_data_slots()
    dis.carve_gfx_pointer_sets()
    dis.carve_tilemap_dispatch()
    for k, v in (overrides or {}).items():
        if v == "QueueSpriteTemplate":
            dis.carve_sprite_templates(int(k, 0))
            break
    dis.find_sprite_banks()
    dis.find_sound_banks()
    dis.find_walk_sprite_banks()
    dis.add_object_header_slots()
    dis.split_object_bodies()
    dis.follow_oam_arrays()
    dis.follow_frame_arrays()
    if helpers or args.hooks:
        dis.scan_data_slots()
    labels = build_labels(dis, overrides, data_tables)
    hwregs = load_hwregs(args.hardware_inc)
    unions_by_region, ramscoped = load_ram_unions(args.ram_unions)
    ramnames = load_ram_map(args.ram_map, unions_by_region)
    Path(args.srcdir).mkdir(parents=True, exist_ok=True)
    curated = set(overrides.values()) if overrides else set()
    constants = {}
    if Path(args.constants).exists():
        constants = {int(k, 0): v
                     for k, v in json.loads(Path(args.constants).read_text()).items()}
    const_defs = load_const_defs("include/constants.inc")
    emit(dis, labels, hwregs, ramnames, args.srcdir, args.manifest, data_tables,
         curated, ramscoped, constants, const_defs)


if __name__ == "__main__":
    main()
