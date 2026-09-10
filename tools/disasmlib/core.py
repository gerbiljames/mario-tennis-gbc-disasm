"""Instruction decoding, seeding, and recursive descent.

DisassemblyBase holds the whole analysis state (see __init__) and the passes
that prove *code*: decode a seed, extend it through direct flow, and recover
the two indirect dispatch shapes the game uses -- the $4000 farcall pointer
table and the inline `rst $00` jump table. Data-side passes live in the
SlotProvingMixin (slots.py) and StructureCarvingMixin (carve.py) that
disassembly.py composes on top of this.
"""
from collections import defaultdict

import lz
import sm83

from .rom import BANK_SIZE, offset_to_cpu, target_to_offset


class DisassemblyBase:
    """Analysis state plus the code-proving passes over it."""

    def __init__(self, rom):
        self.rom = rom
        self.instrs = {}      # rom offset -> Instr
        self.code_bytes = set()
        self.farcalls = {}    # site offset -> (bank, slot, entry_flat, target_flat)
        self.inline_arg_calls = {}  # call site offset -> inline arg byte
        self.inferred_entries = {}  # entry_flat -> (bank, slot, target_flat)
        self.static_code_entries = {}  # curated: entry -> (bank, slot, target)
        self.jt_entries = {}  # rst $00 inline jump-table entry offset -> target_flat
        self.data_boundaries = set()  # declared data-table offsets (data_tables.json)
        self.seed_origins = {}  # coverage seed offset -> [dump file name, ...]
        self.data_slots = {}  # entry_flat -> (bank, slot, src_flat, kind)
        self.data_blobs = {}  # src_flat -> (length or None, kind)
        self.object_headers = set()  # src_flat of 16-byte object headers
        self.sprite_templates = set()  # src_flat of QueueSpriteTemplate lists
        self.sprite_template_sites = {}  # template src_flat -> {`ld hl` offsets}
        self.anim_arrays = {}  # anim-script pointer-array flat -> owning object header
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
    # $72182 and $72f11 are lone seeds inside bank $1c's character-data
    # screen graphics. $72182 sits 1974 bytes into the LZ stream at $59cc,
    # which tools/lz.py proves runs 2618 bytes to $6406 (where the next
    # referenced stream starts), so it cannot be code; $72f11 is inside the
    # raw tile block before CharDataScreenGfx13 and its descent runs back to
    # $6eea via a `jr nz`, fabricating a 64-byte function out of tile bytes.
    # $90cab is a lone seed 1803 bytes into BallPosDataDrop_24, the 6-byte
    # ball-position table that ShotBallPathDrop passes to LookupBallPosByAim;
    # it decodes as nonsense (`call z, $a0f1` on repeat) and split the table.
    #
    # The last eight are one family, all from tracelog2cov conversions and all
    # sitting on a $df byte that is really the high operand byte of a
    # `[$dfxx]` absolute -- i.e. mid-instruction, which is why they conflict.
    # They are the same bank misattribution as $19617f: the native tracer logs
    # `rst $18` as its opcode byte alone, so a farcall that is the only
    # instruction in its run (its callee leaves the bank, and the instruction
    # before it did too) gives the converter one byte of bank evidence, and
    # `min()` awarded it to the lowest bank holding $df at that in-bank
    # offset. Each one's true site is an existing `farcall` in another bank,
    # and the dump that claimed the phantom also contains that site's
    # neighbours, which pins the bank:
    #   $1d1a0 $07:$51a0 -> $24:$51a0 farcall ComputeShotPlacement
    #   $1d469 $07:$5469 -> $1e:$5469 farcall InitActorEngine
    #   $22afb $08:$6afb -> $12:$6afb farcall RunDialogueYesNoPrompt
    #   $22afe $08:$6afe -> $12:$6afe farcall ScriptCloseDialogueWindow
    #   $22c9b $08:$6c9b -> $0b:$6c9b farcall AwardPoint
    #   $22fc6 $08:$6fc6 -> $38:$6fc6 farcall DrawTextWindowFrame
    #   $235cf $08:$75cf -> $1d:$75cf farcall RestoreCharDataScreenRow
    #   $789df $1e:$49df -> $38:$49df farcall DrawTextWindowFrame
    # All eight true sites are already disassembled, so nothing is lost by
    # dropping them. tracelog2cov.py no longer produces this shape.
    BAD_SEEDS = {0x19617F, 0x67682, 0x24F99, 0x252B5, 0xE619, 0x72182, 0x72F11,
                 0x90CAB,
                 0x1D1A0, 0x1D469, 0x22AFB, 0x22AFE, 0x22C9B, 0x22FC6,
                 0x235CF, 0x789DF}

    # ROM0 helpers that consume one inline byte after the `call` (they read
    # the byte at the return address and step the return past it). The byte
    # is data; without this the decoder would treat it as the next opcode.
    INLINE_ARG_CALLS = {0x2725}

    def _target_in_fill(self, t, run=16):
        """True if a candidate jump-table target lands in a run of $ff filler.
        Real handlers never do; an over-running table walk that reads the
        following code's bytes as a pointer usually does, and because $ff
        decodes as a valid one-byte `rst $38` that does not end flow, descent
        from there runs to the end of the bank."""
        if t + run > len(self.rom):
            return False
        return all(b == 0xFF for b in self.rom[t:t + run])

    def seed(self, seeds):
        bad = []
        seeds = set(seeds) - self.BAD_SEEDS
        for off in sorted(seeds):
            if off in self.instrs:
                continue
            ins = self.decode_at(off)
            if not ins.valid or self.conflicts(off, ins):
                bad.append((off, "invalid" if not ins.valid else "conflicts"))
                continue
            self.mark(off, ins)
        if bad:
            print(f"note: {len(bad)} coverage seeds decoded "
                  "invalid/conflicting; skipped:")
            for off, why in bad:
                src = ", ".join(self.seed_origins.get(off, ())) or "descent"
                print(f"  0x{off:x} ${off // BANK_SIZE:02x}:"
                      f"${offset_to_cpu(off):04x} {why} ({src})")

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
                if self._target_in_fill(t):
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
                if self._target_in_fill(t):
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
