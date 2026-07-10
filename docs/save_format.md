# Battery save format (32 KiB SRAM, MBC5)

Engine: bank 3, `$47e9-$4dxx` (`InitSaveHeader`, `WriteSaveBlock`,
`SaveStorySlot`, ... — see labels). SRAM is 4 banks of 8 KiB; a `.sav`
file is the four banks concatenated. Verified against a live save with
`tools/savetool.py verify` (all checksums match).

## Header (SRAM bank 0)

| range | contents |
|---|---|
| `$a000-$a01f` | zeros |
| `$a020-$a02f` | signature `"CAMELOTGBTENNIS\0"` (ROM copy at `SaveSignature`, 03:47e9) |
| `$a030-$a031` | master checksum: 16-bit little-endian byte-sum of `$a038-$a76f` |
| `$a040-$a05f` | flag bytes read via `TestSaveFlag` (bit masks from table 03:4d7e) |
| `$a060-...`   | block directory, 16-byte entries |

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
check the flag and checksum on the way in.

## Block assignments

Blocks 0-26 describe data in SRAM bank 0; block `i+27` is the same
logical block backed up in SRAM bank 1 (written with tag `$c600`).

| block | addr (bank 0) | len | contents |
|---|---|---|---|
| 2N (N=0..2) | `$a800/$ad00/$b200` | `$300` | story slot N: image of WRAM `$c800-$caff` |
| 2N+1 | `$ab00/$b000/$b500` | `$200` | story slot N secondary block (written during play) |
| 6-10 | `$b700+` | `$30/$20/$10` | small records (options/high-score style) |
| 11 | `$b800` | `$200` | 512-byte record |
| 12-26 | `$ba00+` | `$20/$80` | per-minigame records |

`SaveStorySlot` writes block `2N` and its backup `2N+27` (slot from
`$c36c`, 0-2); `InvalidateStorySlot` clears blocks `2N` and `2N+1`.

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
