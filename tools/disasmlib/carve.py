"""Carving the game's bulk data structures out of unclassified regions.

Each pass here recognises one concrete layout -- object/sprite records, the
character-sprite, sound and walk-sprite bank shapes, graphics pointer pools,
QueueSpriteTemplate lists -- and splits it into labelled blobs so the source
references them by name. Two code-shape passes live here too (text-bank entry
stubs and story match-launcher stubs): both recover functions that no control
flow reaches, by matching a rigid byte shape rather than by descent.
"""
import bisect

import lz

from .rom import BANK_SIZE, offset_to_cpu


def _writes_hl(text):
    """True if an instruction modifies hl (so a preceding `ld hl, imm` no longer
    holds that immediate). Covers reloads, arithmetic, inc/dec, hl+/- accesses,
    pop hl, and 8-bit writes to h or l."""
    return (text.startswith(("ld hl", "add hl", "inc hl", "dec hl",
                             "ld l,", "ld h,", "inc l", "inc h",
                             "dec l", "dec h", "pop hl"))
            or "[hl+]" in text or "[hl-]" in text)


class StructureCarvingMixin:
    """Data-structure carving, mixed into Disassembly.

    Each pass recognises one concrete layout and records it: bulk data as
    self.data_blobs extents, structural words as self.ptr_words/ptr_labels,
    object records in self.object_headers. The two stub-shape passes instead
    mark code, seeding self.instrs where no control flow reaches.
    """

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
            self.oam_arrays[astart] = h  # named after the header in build_labels
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

    def carve_tennis_dictionary_assets(self):
        """Bank $3f's Tennis Dictionary screen ($42fe setup) stores its assets
        inline after the $444f ClearBytes descriptor table: a run of
        LZ-compressed tile blocks and palette blocks, each reached through an
        `ld hl, imm; call DecompressData/LoadPalettesMasterOnly` (no pointer
        table, so the auto-carver leaves the lot as one records:2 blob). The
        block starts are the immediates those call sites load; register the
        nine lz blocks as lz blobs (each running to the next start) so they
        render as named INCBINs. The three palette blocks ($47ae/$47f6/$4e39)
        and the $444f/$4487 descriptor tables are declared in data_tables.json."""
        bank = 0x3f
        base = bank * BANK_SIZE

        def flat(cpu):
            return base + cpu - BANK_SIZE

        # (start, end) of each lz block, end = next referenced block start.
        lz_blocks = [
            (0x44bf, 0x4541), (0x4541, 0x459c), (0x459c, 0x47ae),
            (0x483e, 0x495d), (0x495d, 0x4a9f), (0x4a9f, 0x4bd5),
            (0x4bd5, 0x4c89), (0x4c89, 0x4d8b), (0x4d8b, 0x4e39),
        ]
        for start, end in lz_blocks:
            self.data_blobs.setdefault(flat(start), (end - start, "lz"))
        print(f"tennis dictionary: {len(lz_blocks)} lz blocks carved")

    def carve_char_mugshots(self):
        """Bank $1b's menu mugshot pool ($44b1-$4cec): 14 LZ streams, each one
        3x3-tile portrait, selected by the record table at $4cec
        (DecompressCharMugshot, $4e5c) with the character id as index. Nothing
        points at the pool but that table, so the auto-carver leaves it as one
        blob; register each stream so the table's rows resolve to named
        INCBINs. The streams tile the pool exactly, in table order."""
        bank = 0x1b
        base = bank * BANK_SIZE
        tbl = base + 0x4cec - BANK_SIZE
        pool = []
        for o in range(tbl, base + BANK_SIZE, 4):
            cpu = self.rom[o] | (self.rom[o + 1] << 8)
            if cpu >= 0x4cec:  # past the last record: the table's own trailer
                break
            if cpu not in pool:
                pool.append(cpu)
        for cpu in pool:
            src = base + cpu - BANK_SIZE
            _, clen = lz.decompress(self.rom, src, base + BANK_SIZE)
            self.data_blobs[src] = (clen, "lz")
        print(f"char mugshots: {len(pool)} lz streams carved")

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
                    if length:
                        self.sprite_template_sites.setdefault(src, set()).add(hl_end - 3)
        if added:
            print(f"sprite templates: {added} carved")

    def carve_lz_sources(self, decomp_flat):
        """Size every `call DecompressData` operand by decoding it.

        The same backtrack as carve_sprite_templates, but the length comes from
        the codec: a stream ends where its own terminator says, so decoding is
        the only thing that knows where the compressed bytes stop. Without this
        a stream that shares a blob with whatever follows it is carved to the
        *next reference*, which silently glues the two together -- and because
        the blob is then not named `lz_`, `make check` never decodes it and the
        mismatch stays invisible. Registering the true length splits the tail
        into its own blob, where it can be named for what it is."""
        dcpu = offset_to_cpu(decomp_flat)
        added = 0
        last_hl = None
        for off in sorted(self.instrs):
            op = self.rom[off]
            if op == 0x21:
                cpu = self.rom[off + 1] | (self.rom[off + 2] << 8)
                last_hl = (off // BANK_SIZE, off + 3, cpu)
                continue
            if last_hl is not None and _writes_hl(self.instrs[off].text):
                last_hl = None
            if not (op == 0xCD and last_hl is not None
                    and (self.rom[off + 1] | (self.rom[off + 2] << 8)) == dcpu):
                continue
            bank, hl_end, cpu = last_hl
            if not (bank == off // BANK_SIZE and 0x4000 <= cpu < 0x8000
                    and 0 <= off - hl_end <= 24):
                continue
            src = bank * BANK_SIZE + cpu - BANK_SIZE
            if src in self.instrs:
                continue
            try:
                _, clen = lz.decompress(self.rom, src, (bank + 1) * BANK_SIZE)
            except ValueError:
                # The pointer did not survive to the call after all (a table
                # index, a bank switch, an hl the tracker could not follow), so
                # believe the existing carve rather than a failed decode.
                continue
            existing = self.data_blobs.get(src)
            if existing is not None and existing[1] == "lz":
                continue
            # The decode ran to the end of the bank, so a stream that overlaps
            # anything already carved is evidence the pointer tracking picked
            # the wrong source, not that the other carve is wrong. Emission
            # would clip the region at that boundary and the `lz` name would
            # then assert a stream that does not fit inside it.
            if any(src < o < src + clen
                   for o in (*self.data_blobs, *self.instrs)):
                continue
            if existing is None or existing[0] is None or clen < existing[0]:
                self.data_blobs[src] = (clen, "lz")
                added += 1
        if added:
            print(f"lz sources: {added} streams sized from their decompress call")

    def promote_exact_lz_blobs(self, label_offsets=()):
        """Declare a plain blob an `lz` stream when it decodes to exactly itself.

        The call-site pass only sees streams whose pointer is an `ld hl, imm`;
        the rest are reached through a table, so their kind stays `copy` and
        `make check` never decodes them. A blob whose bytes decode as a stream
        that ends on its last byte *and* expands is not a coincidence at this
        size -- the codec would have to run out of input exactly at the extent
        the carve derived from a completely separate reference. Requiring the
        exact end is what makes this safe: a blob that merely starts with a
        decodable prefix is left alone, because that is the glued-tail case the
        call-site pass exists to fix, and guessing its split has no evidence."""
        bounds = sorted({*self.data_blobs, *self.instrs, *label_offsets})
        promoted = 0
        for src, (length, kind) in sorted(self.data_blobs.items()):
            if kind not in ("copy", ""):
                continue
            # A blob whose length the carve never fixed ends at the next thing
            # that claims an address, which is the extent the emitter will give
            # it -- the same span the decode has to land on exactly.
            i = bisect.bisect_right(bounds, src)
            end = bounds[i] if i < len(bounds) else (src // BANK_SIZE + 1) * BANK_SIZE
            if length is not None:
                end = min(end, src + length)
            length = end - src
            if length < 32:
                continue
            try:
                data, used = lz.decompress(self.rom, src, end)
            except ValueError:
                continue
            if used == length and len(data) > length * 6 // 5:
                self.data_blobs[src] = (length, "lz")
                promoted += 1
        if promoted:
            print(f"lz sources: {promoted} blobs promoted (decode to their exact extent)")

    def validate_lz_blobs(self, label_offsets=()):
        """Demote any `lz` blob whose stream does not fit the space it gets.

        A blob's emitted extent ends at the next thing that claims an address --
        another blob, an instruction, or a curated label -- and passes that run
        after this one can introduce such a boundary inside a stream that was
        whole when it was registered. Naming the region `lz_` then asserts a
        stream that provably does not decode inside it, which is what
        `make check`'s lz check reports. Believe the boundary and drop the
        claim: the bytes are unchanged either way."""
        bounds = sorted({*self.data_blobs, *self.instrs, *label_offsets})
        demoted = 0
        for src, (length, kind) in sorted(self.data_blobs.items()):
            if kind != "lz" or length is None:
                continue
            i = bisect.bisect_right(bounds, src)
            end = min(bounds[i], src + length) if i < len(bounds) else src + length
            try:
                _, used = lz.decompress(self.rom, src, end)
            except ValueError:
                used = None
            if used != end - src:
                self.data_blobs[src] = (length, "copy")
                demoted += 1
        if demoted:
            print(f"lz sources: {demoted} demoted -- a later carve split them")

    def _sprite_template_len(self, src):
        """Length of a QueueSpriteTemplate list at src: 4-byte records up to a
        $80 dy byte (inclusive), else None if none appears within 40 records."""
        for n in range(40):
            if src + n * 4 >= len(self.rom):
                return None
            if self.rom[src + n * 4] == 0x80:
                return n * 4 + 1
        return None

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
                self.ptr_words[base + 4 * i] = (None, "snd_channel")
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
