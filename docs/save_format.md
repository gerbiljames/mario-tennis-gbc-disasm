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
the referenced byte is `$a040 + d` (`sSaveFlags`). A flag's *number* is
`byte * 8 + bit`; the `SAVEFLAG_*` constants in `include/constants.inc` hold
the `de` id for each one, and every immediate call site renders by name.

**Only bytes `$00`-`$07` are ever used** — 64 of the 256 bits. The rest
(`sSaveFlagsUnused`, `$a048-$a05f`) is zeroed by `Unused_03_ClearSaveFlagsArea` and
never read: every immediate id in the ROM is `$01xx`-`$07xx`, and the three
computed callers are bounded (character ids stop at `$1f`,
`MinigameClearFlagTable_1e` at #54, `UnlockConditionFlagRows_03` at #54).

| byte | flags | contents |
|---|---|---|
| `$00`-`$03` | 0-31 | **character unlocks**, one bit per character id — `CheckCharacterUnlocked` (18:452a) tests flag number = char id (ids 0-3 always unlocked) |
| `$01` | 9-15 | within that: #9 opening seen, #10-13 Fay/Curt/Mark/Sean (granted by N64 transfer records), #14/#15 Sammi/Elden (singles/doubles Dream Match) |
| `$02`-`$03` | 20-31 | also the first 12 **minigame-clear** flags (Boo Blast → Target Shot, 3 levels each) — the same bit, which is why clearing a minigame level unlocks a character |
| `$04` | 32-38 | per-story-slot: `SetStorySlotFlagA` #32-34, `SetStorySlotFlagB` #36-38; `EraseStorySlotSaveData` clears the erased slot's pair |
| `$05`-`$06` | 40-54 | the remaining minigame clears (Fruit Fantasy → Two-On-One) |
| `$07` | 57-63 | court unlocks (#57 Star, #58 Castle, #59 Tropics, #60 Jungle, #61 Warehouse), #62 "N64 records present", #63 the bank `$01` debug-menu toggle |

`MinigameClearFlagTable_1e` is the authority for the minigame run:
`SetMinigameClearFlag` indexes it by `(minigame id - $1c) * 3 + level`, and its
27 entries run from flag 20 upward, skipping byte `$04`. The RetroAchievements
Code Notes for `$a042`/`$a043`/`$a045`/`$a046`/`$a047` describe the same bits
with the opposite bit numbering (their "Bit N" is mask `1 << N`, i.e. this
engine's bit `7 - N`) and agree entry for entry.

These are *global* flags (not per-story-slot), so setting the whole array to
`0xFF` unlocks every playable character and every mini-game.
`ApplyUnlockEverythingCheat` (`$3b:$4b33`) is the engine's own batch unlock: it
sets levels 1 and 2 of every minigame and skips level 3, so the level-3
characters (Baby Mario, Yoshi, Peach) stay locked. Verified in-emulator: with
the array forced to `0xFF` and the master checksum + bank-1 mirror fixed, the
ROM boots clean and the Mario cast and all mini-games are selectable.
`tools/savetool.py unlock` does exactly this. Per-story-slot progress is
separate (the `wGameFlags` block at slot +0x1c0) and is left untouched.

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
| 7-10 | 0:`$1730+` | `$20/$10` | small records; accessors (`Unused_03_WriteBlock7WithBackup` ... `Unused_03_ReadBlock10`, 03:587b+) exist but no caller found — never valid in a real save |
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
`$c36c`, 0-2); `Unused_03_InvalidateStorySlot` clears blocks `2N` and `2N+1`.
Verified against `maxed-unlocked.sav`: only blocks 0/1, 11, 27/28,
54/55, and 56-62 have ever been valid.

## Minigame record blocks (`$38-$3d`)

11 records of 16-bit values, accessed by `ReadMinigameRecord` /
`UpdateMinigameRecord` (03:5015/5072) with the record id in `a` and the
value passed through WRAM7 `$de00`. Records 0-1 are per-story-slot
(block `$38 + wCurrentStorySlot`); records 2-10 always live in block
`$38`. Per-record defaults come from `FarPtr_GetDefaultMinigameRecordValue`
(the debug helper `Unused_03_DebugTestMinigameRecords` seeds records 0/1 with
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
| +2..+7 | per-character unlock/toggle flags for characters `$1a-$1f`, flipped on the character-select screen by `Unused_1b_ToggleSelectedUnlockFlag` (1b:68a4); set by `UpdateUnlockablesSaveBlock` when the matching minigame record beats its default + save flag (mapping id→off: 2→+2, 9→+3, 6→+4, $0a→+5, 8→+6, 4→+7) |

When present, `ApplyN64RecordsUnlockFlags` (03:56a8) sets global save
flags `$07c0/$0140/$0160/$0180/$01a0` at boot.
`SetAllUnlockablesInSaveBlock` (03:5787) force-sets all six flags
(called from the bank $3b trophy/completion flow).

## Star victory grid block (`$3e`)

96 bytes at 2:`$06c0`; the used portion is a 9×9 byte matrix indexed
`[player star char][opponent star char]` (stride 9) holding the best
victory score per pairing. Read/written via `ReadMarioCastVictoryGrid` /
`WriteMarioCastVictoryGrid` (03:5229/5240, staged at WRAM3 `$d900`) from
`RecordExhibitionVictory` / `LoadMarioCastExhibGrid` (bank $3b), which
drive the star-rank unlock logic after exhibition wins.

## WRAM staging buffers

The save engine never reads/writes SRAM in place; every block moves
through banked-WRAM scratch, all of it multiplexed with other uses. The
three bank-`$07` buffers are named now — they overlay `wGlyphTileBuffer`,
the text engine's glyph tiles, and a union variant in `ram/wram.asm`, whose
names were applied only where *both* the referencing ROM bank and a provable
WRAM bank `$07` agreed, keeps the two apart. The rest stay numeric.

| buffer | used for |
|---|---|
| WRAM1 `$d000` | generic block scratch: `RestoreStoryBlockFromBackup`/`RepairAllSaveSlots`, block-6 preserve, `$d400` = tag readback |
| WRAM7 `$d480` `wMinigameRecordBlock` | minigame-record block image (blocks `$38-$3d`) |
| WRAM7 `$d500` `wSaveBlockBuffer` | `$200`-byte record staging: N64 block, slot secondary blocks, debug save editor (block from `Unused_03_GetCurrentSlotBlockId` table 03:52af = `00 02 04 0b`) |
| WRAM7 `$de00` `wMinigameRecordValue` | 16-bit minigame-record value in/out parameter |
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
