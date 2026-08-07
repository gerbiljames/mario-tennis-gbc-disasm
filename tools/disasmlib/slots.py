"""Proving $4000 pointer-table slots to be data.

Every bank opens with a table of dw entries reached either by `farcall`
(code) or by the CopyDataFromBank/DecompressDataFromBank helpers (data). This
mixin decides which slots hold data pointers -- from static register
backtracking at helper call sites, from runtime hook captures, from curated
record tables, and finally from a shape scan over the remaining slots -- and
records each proven target as a blob with an exact extent where one is known.
"""
import bisect
import json
from collections import defaultdict
from pathlib import Path

import lz

from .rom import BANK_SIZE, target_to_offset


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


class SlotProvingMixin:
    """Pointer-table slot proving, mixed into Disassembly.

    Reads what is already proven code (self.instrs, self.code_bytes) and fills
    self.data_slots (entry -> the blob it points at) and self.data_blobs (start
    -> extent, kind), which the emitter turns into DataPtr_/Lz_/Data_ labels.
    """

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
        # UpdateAnimatedTiles ($39:$4373) picks a frame table by
        # wAnimatedTileSet, indexes it by frame, and reads the word as h:l
        # straight into DecompressDataFromBank -- so every row is a
        # (bank << 8) | slot selector, not an in-bank pointer, even though
        # table 1's $6dxx rows alias TilemapAssemblyDispatch_39 interiors.
        "AnimatedTilesTable1": 1,
        "AnimatedTilesTable2": 1,
        "AnimatedTilesTable3": 1,
        "AnimatedTilesTable4": 1,
        # LoadMatchRulesMenuGraphics ($3e:$4607) and the court-select loader
        # ($3e:$5d21) walk these the same way: word as h:l into
        # DecompressDataFromBank, one label-tile stream per menu row.
        "MatchRulesMenuGraphicsTable": 1,
        "CourtSelectGraphicsTable": 1,
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

    # $4000-directory slots holding a code pointer that no `farcall` operand
    # references: they are entered through CallVectorEntryA ($00:$01e6) with a
    # computed slot index, so nothing static proves them and the entry bytes
    # would render as two loose `db`s between their neighbours. Both routines
    # are already carved (seeded in coverage/) and unreferenced otherwise.
    STATIC_CODE_SLOTS = {0x18: (0x90,),   # -> $7659 DebugScreenAssetViewer
                         0x6d: (0x26,)}   # -> $6a7f ShowIntroCharacterScreen

    def add_static_code_slots(self):
        for bank, slots in self.STATIC_CODE_SLOTS.items():
            base = bank * BANK_SIZE
            for slot in slots:
                entry = base + slot
                cpu = self.rom[entry] | (self.rom[entry + 1] << 8)
                if not 0x4000 <= cpu < 0x8000:
                    continue
                if entry in self.code_bytes or entry + 1 in self.code_bytes:
                    continue
                target = base + cpu - BANK_SIZE
                # Kept out of inferred_entries: that set also tells
                # scan_data_slots which banks hold code tables, and marking
                # bank $6d as one would cost its unproven data slots their
                # acceptance. The emitter merges these in on its own.
                self.static_code_entries[entry] = (bank, slot, target)
                self.seed([target])

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
