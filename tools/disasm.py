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
        self.data_boundaries = set()  # declared data-table offsets (data_tables.json)
        self.data_slots = {}  # entry_flat -> (bank, slot, src_flat, kind)
        self.data_blobs = {}  # src_flat -> (length or None, kind)
        self.object_headers = set()  # src_flat of 16-byte object headers
        self.data_site_notes = {}  # `ld hl` setup offset -> (bank, slot)
        self.ptr_words = {}   # word offset -> (target_flat or None, note)
        self.ptr_labels = {}  # flat offset -> generated structure label
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
    BAD_SEEDS = {0x19617F, 0x67682}

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

        extents = {}
        for bank, floor in floors.items():
            base = bank * BANK_SIZE
            tmin = min((src - base for (b, _s, src, _k) in
                        self.data_slots.values() if b == bank), default=None)
            if tmin is not None and floor <= tmin <= 0x100:
                extents[bank] = tmin
            else:
                extents[bank] = floor

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

        accepted_lz = accepted_raw = 0
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
                    data, length = lz.decompress(self.rom, src, base + BANK_SIZE)
                except ValueError:
                    continue
                if not 8 <= len(data) <= 0x1000:
                    continue
                if overlaps(src, src + length) or any(
                        b in self.code_bytes for b in range(src, src + length)):
                    continue
                self.data_slots[entry] = (bank, slot, src, "lz")
                self.data_blobs.setdefault(src, (length, "lz"))
                bisect.insort(claimed, (src, src + length))
                accepted_lz += 1

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

        # Raw-pointer pass: safe only where no table slot is a code entry,
        # so an in-range pointer cannot be an unproven function.
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
        exp = region_prefix(addr)
        if exp and not (name.startswith(exp) and name[1:2].isupper()):
            print(f"warning: {path}: {addr_s} name {name!r} should be "
                  f"{exp}PascalCase", file=sys.stderr)
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
        for k, name in overrides.items():
            if not (name[:1].isupper() and name.isidentifier()):
                print(f"warning: labels.json: {k} name {name!r} should be "
                      f"PascalCase", file=sys.stderr)
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
    return labels


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


def render_operand(ins, off, labels, hwregs, ramnames, data_labels=None):
    text = ins.text
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
"""


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
         curated=None):
    data_tables = data_tables or {}
    curated = curated or set()
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
        stem = "Lz" if kind == "lz" else "Data"
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

    # Semantic slot names: a $4000-table slot whose target carries a curated
    # name is named after it, so call sites read `farcall FarPtr_DrawBox`
    # instead of `farcall FarPtr_18_xx`. Duplicate slots for the same target
    # keep their numeric name (labels must stay unique).
    far_slot_names = {}   # (bank, slot) -> label
    data_slot_names = {}  # (bank, slot) -> label
    used_slot_names = set()
    for entry in sorted(table_entries):
        bank, slot, target = table_entries[entry]
        name = labels.get(target)
        if name in curated and f"FarPtr_{name}" not in used_slot_names:
            used_slot_names.add(f"FarPtr_{name}")
            far_slot_names[(bank, slot)] = f"FarPtr_{name}"
    for entry in sorted(data_entries):
        bank, slot, src, _kind = data_entries[entry]
        name = data_labels.get(src)
        if name in curated and f"DataPtr_{name}" not in used_slot_names:
            used_slot_names.add(f"DataPtr_{name}")
            data_slot_names[(bank, slot)] = f"DataPtr_{name}"

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
                if off in dis.farcalls and ins.text == "farcall {far}":
                    fbank, slot, entry, _target = dis.farcalls[off]
                    if off in dirty_sites:
                        lines.append(f"\trst Rst18 ; ${cpu:04x}")
                        lines.append(f"\tdb ${slot:02x}, ${fbank:02x} ; farcall operands (slot bytes overlap code)")
                    else:
                        sl = far_slot_names.get((fbank, slot),
                                                f"FarPtr_{fbank:02x}_{slot:02x}")
                        lines.append(f"\tfarcall {sl} ; ${cpu:04x}")
                else:
                    note = dis.data_site_notes.get(off)
                    suffix = ""
                    if note:
                        sl = data_slot_names.get(
                            note, f"DataPtr_{note[0]:02x}_{note[1]:02x}")
                        suffix = f" -> {sl}"
                    lines.append(f"\t{render_operand(ins, off, labels, hwregs, ramnames, operand_labels)} ; ${cpu:04x}{suffix}")
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
                if mark and mark[0]:
                    blob = f"bank_{bank:03x}/{prefix}_{cpu:04x}.bin"
                    manifest.append((blob, run_start, length, None))
                    lines.append(f'\tINCBIN "data/{blob}" ; ${cpu:04x}, {length} bytes')
                    continue
                # Unclassified run: split out long constant-byte fills as ds
                # directives ($ff is the mastering fill; $00 needs a longer
                # run since zero arrays can be real data; any $ff run that
                # reaches the bank end is trailing fill regardless of length).
                seg = run_start
                while seg < off:
                    b = rom[seg]
                    j = seg
                    while j < off and rom[j] == b:
                        j += 1
                    if not ((b == 0xFF and (j - seg >= 64 or j == end))
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
                        # A declared data table renders as structured source
                        # (palettes/records/bytes) inline, using the same
                        # renderer extract.py applies to blobs.
                        if seg in data_tables:
                            spec = data_tables[seg]
                            if seg in labels:
                                lines.append(f"{labels[seg]}:")
                            lines.append(f"\t; ${scpu:04x}, {j - seg} bytes ({spec})")
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
                        else:
                            if seg in labels:
                                lines.append(f"{labels[seg]}:")
                            blob = f"bank_{bank:03x}/d_{scpu:04x}.bin"
                            lines.append(f'\tINCBIN "data/{blob}" ; ${scpu:04x}, {n} bytes')
                        manifest.append((blob, seg, n, None))
                    else:
                        lines.append(f"\tds {j - seg}, ${b:02x} "
                                     f"; ${offset_to_cpu(seg):04x}, fill")
                    seg = j
        lines.append("")
        Path(srcdir, f"bank_{bank:03x}.asm").write_text("\n".join(lines))
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
    ap.add_argument("--hardware-inc", default="include/hardware.inc")
    ap.add_argument("--ram-map", default="ram_map.json")
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
    if not args.no_descent:
        dis.descend()
        dis.infer_tables()
        dis.seed_text_entries()
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
    dis.find_sprite_banks()
    dis.find_sound_banks()
    dis.find_walk_sprite_banks()
    dis.add_object_header_slots()
    dis.split_object_bodies()
    dis.follow_oam_arrays()
    dis.follow_frame_arrays()
    if helpers or args.hooks:
        dis.scan_data_slots()
    labels = build_labels(dis, overrides)
    hwregs = load_hwregs(args.hardware_inc)
    ramnames = load_ram_map(args.ram_map, "include/ram_constants.asm")
    Path(args.srcdir).mkdir(parents=True, exist_ok=True)
    curated = set(overrides.values()) if overrides else set()
    emit(dis, labels, hwregs, ramnames, args.srcdir, args.manifest, data_tables,
         curated)


if __name__ == "__main__":
    main()
