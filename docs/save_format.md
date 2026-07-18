# Battery save format (32 KiB SRAM, MBC5)

Engine: bank 3, `$47e9-$4dxx` (`InitSaveHeader`, `WriteSaveBlock`,
`SaveStorySlot`, ... — see labels). SRAM is 4 banks of 8 KiB; a `.sav`
file is the four banks concatenated. Verified against a live save with
`tools/savetool.py verify` (all checksums match).

## Header (SRAM bank 0)

| range | contents |
|---|---|
| `$a000-$a01f` | zeros |
| `$a020-$a02f` | signature `"CAMELOTGBTENNIS\0"` (`sSaveSignature`; ROM copy at `SaveSignature`, 03:47e9) |
| `$a030-$a031` | master checksum (`sSaveMasterChecksum`): 16-bit little-endian byte-sum of `$a038-$a76f` |
| `$a038`       | save layout version byte, always `$71` (`sSaveFormatVersion`) |
| `$a040-$a05f` | 32-byte global progress-flag array (256 bits) |
| `$a060-$a76f` | block directory (`sSaveBlockDirectory`): 113 16-byte entries |

### Global flag array (`$a040-$a05f`)

Accessed by `TestSaveFlag` / set / clear (bank 3, `FarPtr_03_1c/1e/20`).
A flag is addressed by two registers: `d` = byte index (0-0x1f into the
array), `e` = bit selector = `bit << 5` (so `$0720` means byte 7, bit 1).
The mask is `0x80 >> bit` (table 03:4d7e = `80 40 20 10 08 04 02 01`), and
the referenced byte is `$a040 + d`. These are *global* flags (not
per-story-slot): character-roster and mini-game unlocks live here, so
setting the whole array to `0xFF` unlocks every playable character and
every mini-game. `Func_3b_4b33` is the engine's own batch-unlock routine
(it sets a fixed subset of these plus per-slot game flags). Verified
in-emulator: with the array forced to `0xFF` and the master checksum +
bank-1 mirror fixed, the ROM boots clean and the Mario cast and all
mini-games are selectable. `tools/savetool.py unlock` does exactly this.
Per-story-slot progress is separate (the `wGameFlags` block at slot
+0x1c0) and is left untouched.

The whole header region `$a000-$a7ff` is mirrored verbatim into SRAM
bank 1 by `MirrorSaveHeaderToBank1` after every write. On boot
`ValidateSaveRam` checks signature + master checksum; on failure it
restores bank 1's mirror and re-checks — but the re-check compares the
signature at `$a000` instead of `$a020` (bug), so a corrupt header
always falls through to a full wipe + re-init.

## Block directory entry (16 bytes, at `$a060 + 16*i`)

| off | field |
|---|---|
| +0 | valid flag (1 = in use) |
| +1 | SRAM bank of the block data |
| +2 | data offset from `$a000`, little-endian word |
| +4 | length, little-endian word |
| +6 | block checksum: 16-bit byte-sum of the data, little-endian |
| +8 | tag word (stored high-then-low; `$0000` primary, `$c600` backup) |

`WriteSaveBlock(b, hl=src, de=tag)` copies src → block `b`'s data,
sums it, and fills in the entry. `ReadSaveBlock`/`VerifySaveBlock`
check the flag and checksum on the way in. The "tag" word at entry +8
is just the caller's `de` echoed into the directory: primary writes
pass `$0000`, and the story/exhibition backup writes pass
`ld de, wTextBuffer` — i.e. the observed backup tag `$c600` is
literally the address of `wTextBuffer`, not a magic constant.

## Block directory (113 entries, from `InitSaveHeader`)

The directory defined by `InitSaveHeader` (03:404a) covers far more
than the game ever writes. Full layout (`b`=SRAM bank, `off` from
`$a000`):

| blocks | bank:off | len | contents |
|---|---|---|---|
| 0/2/4 | 0:`$0800/$0d00/$1200` | `$300` | story slot N primary: image of WRAM `$c800-$caff` |
| 1/3/5 | 0:`$0b00/$1000/$1500` | `$200` | story slot N secondary block (written during play) |
| 6 | 0:`$1700` | `$30` | small record; the only block preserved across a full save wipe (`ReinitSaveRamPreservingBlock6`) |
| 7-10 | 0:`$1730+` | `$20/$10` | small records; accessors (`WriteBlock7WithBackup` ... `ReadBlock10`, 03:587b+) exist but no caller found — never valid in a real save |
| 11 (`$0b`) | 0:`$1800` | `$200` | N64 (Transfer Pak) records block, see below |
| 12-26 | 0:`$1a00+` | `$20/$80` | defined, never written by GBC code |
| 27-37 (`$1b-$25`) | 1: same off as 0-10 | same | bank-1 backups of blocks 0-10 (backup id = primary + `$1b`) |
| 38-53 (`$26-$35`) | 1:`$1800+` | `$80` | 16 slots; NOT a mirror of blocks 11-26 (different layout), never written |
| 54/55 (`$36/$37`) | 2:`$0000/$0300` | `$300` | exhibition-session block (slot `$c36c`=3) + backup, read/written by `ReadExhibitionSaveBlock`/`WriteExhibitionSaveBlock` around the save-and-quit resume flow (source/dest `wStorySlotData`) |
| 56-58 (`$38-$3a`) | 2:`$0600+` | `$20` | minigame records, story slot 0-2 (11 16-bit records each) |
| 59-61 (`$3b-$3d`) | 2:`$0660+` | `$20` | backups of 56-58 |
| 62 (`$3e`) | 2:`$06c0` | `$60` | star-character exhibition victory grid (9×9 best win scores), see below |
| 63/64 (`$3f/$40`) | 2:`$0720/$14c0` | `$da0/$6c0` | defined, never written |
| 65-73 | 2:`$1b80+` | `$80` | defined, never written |
| 74-87 | 3:`$0000+` | `$100-$500` | defined, never written |
| 88-97 | 4:`$0000+` | `$100-$500` | defined, never written |
| 98-103 | 5:`$0000+` | `$1500/$200` | defined, never written |
| 104-112 | 6-14:`$0000` | `$1e00` | one whole-bank block per SRAM bank 6-14; the cart only has 4×8 KiB, so these (and banks 4-5 above) address SRAM that doesn't exist — presumably reserved headroom; MBC5 masks the bank number so they'd alias banks 0-3 if ever touched |

`SaveStorySlot` writes block `2N` and its backup `2N+$1b` (slot from
`$c36c`, 0-2); `InvalidateStorySlot` clears blocks `2N` and `2N+1`.
Verified against `maxed-unlocked.sav`: only blocks 0/1, 11, 27/28,
54/55, and 56-62 have ever been valid.

## Minigame record blocks (`$38-$3d`)

11 records of 16-bit values, accessed by `ReadMinigameRecord` /
`UpdateMinigameRecord` (03:5015/5072) with the record id in `a` and the
value passed through WRAM7 `$de00`. Records 0-1 are per-story-slot
(block `$38 + wCurrentStorySlot`); records 2-10 always live in block
`$38`. Per-record defaults come from `FarPtr_GetDefaultMinigameRecordValue`
(the debug helper `DebugTestMinigameRecords` seeds records 0/1 with
9999/999). `UpdateMinigameRecord` writes
the primary and its `+3` backup, both verified.
`InitAllMinigameRecordBlocks` (03:519a) resets all six blocks to
defaults on save init; `InitCurrentSlotMinigameRecords` (03:5141)
resets just records 0-1 of the current slot (called from
`EraseStorySlotSaveData`). Staging buffer is WRAM7 `$d480`.
`CheckUnlockCondition` (03:57e2) compares a record against its default
(plus a save flag) to award the six unlockables in the N64 block.

## N64 (Transfer Pak) records block (`$0b`)

512 bytes at 0:`$1800` (`$b800`), staged through WRAM7 `$d500`
(bank 3), WRAM6 `$d400` (bank $1b), WRAM3 `$d900` / WRAM2 `$d000`
(bank $3b). Layout:

| off | contents |
|---|---|
| +0/+1 | data-present indicator (checked as `[+0]+[+1] != 0` by `CheckN64DataPresent` / `ApplyN64RecordsUnlockFlags`) |
| +2..+7 | per-character unlock/toggle flags for characters `$1a-$1f`, flipped on the character-select screen by `ToggleSelectedUnlockFlag` (1b:68a4); set by `UpdateUnlockablesSaveBlock` when the matching minigame record beats its default + save flag (mapping id→off: 2→+2, 9→+3, 6→+4, $0a→+5, 8→+6, 4→+7) |

When present, `ApplyN64RecordsUnlockFlags` (03:56a8) sets global save
flags `$07c0/$0140/$0160/$0180/$01a0` at boot.
`SetAllUnlockablesInSaveBlock` (03:5787) force-sets all six flags
(called from the bank $3b trophy/completion flow).

## Star victory grid block (`$3e`)

96 bytes at 2:`$06c0`; the used portion is a 9×9 byte matrix indexed
`[player star char][opponent star char]` (stride 9) holding the best
victory score per pairing. Read/written via `ReadStarVictoryGrid` /
`WriteStarVictoryGrid` (03:5229/5240, staged at WRAM3 `$d900`) from
`RecordExhibitionVictory` / `LoadStarCharExhibGrid` (bank $3b), which
drive the star-rank unlock logic after exhibition wins.

## WRAM staging buffers

The save engine never reads/writes SRAM in place; every block moves
through banked-WRAM scratch (all multiplexed with other uses, hence
not named in `ram_map.json`):

| buffer | used for |
|---|---|
| WRAM1 `$d000` | generic block scratch: `RestoreStoryBlockFromBackup`/`RepairAllSaveSlots`, block-6 preserve, `$d400` = tag readback |
| WRAM7 `$d480` | minigame-record block image (blocks `$38-$3d`) |
| WRAM7 `$d500` | `$200`-byte record staging: N64 block, slot secondary blocks, debug save editor (block from `GetCurrentSlotBlockId` table 03:52af = `00 02 04 0b`) |
| WRAM7 `$de00` | 16-bit minigame-record value in/out parameter |
| WRAM6 `$d400` | N64 block staging in bank $1b char select |
| WRAM3 `$d900` | N64 block (trophies screen) and star victory grid staging in bank $3b |
| WRAM2 `$d000` | N64 block presence check (`CheckN64DataPresent`) |

## Story slot block layout (image of WRAM `$c800-$caff`)

| off | contents |
|---|---|
| +$000 | main character record (0x40 bytes, see below) |
| +$040 | partner character record (0x40 bytes) |
| +$1c0 | `wGameFlags` array (`$c9c0`, the `set_flag`/`test_flag` bits — story progress) |

Character record (matches the `wStoryModeMainCharacter*` WRAM map):

| off | field |
|---|---|
| +$00 | name, NUL-padded ASCII (12 bytes) |
| +$18 | level (1-99) |
| +$20 | eleven stats 0-9: Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop |
| +$2c | EXP, 16-bit little-endian |
| +$38 | Spin / Power / Control / Speed levels (the four shown on character select) |

## Editing

`tools/savetool.py` verifies, dumps, and edits saves, recomputing block
checksums, the master checksum, and the bank-1 mirror. Alternatively,
edit the live WRAM struct (`$c818` level etc.) in an emulator and save
in-game — the game recomputes everything itself.
