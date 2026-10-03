# Data formats

How the cartridge's data is **encoded**: the byte layouts a modder has to
respect to change a tile, a map, a sprite or a palette and still have the ROM
boot. What the game *does* with it is in `docs/match_engine.md`,
`docs/story_mode.md` and `docs/screens_and_ui.md`. §3.5 and §8 list what is
unresolved.

Cross-references: `docs/bank0_notes.md` (ROM0 helpers), `docs/ram_map.md`
(destination buffers), `docs/screens_and_ui.md` §7 (text at the UI level),
`docs/sound_engine.md` (sound data, not covered here), `docs/actor_script.md`
(actor bytecode), `docs/bugs.md`.

---

## 0. Editing graphics

Every file under `data/` is named after its label in the source
(`data/bank_040/AlexSpriteFrame00.bin`; an `lz_` prefix marks a compressed
stream, `lz_DmgLockoutTilesLZ_01.bin`; a blob nothing names keeps an
address name, `d_000b.bin`). Every blob the manifest tags `gfx` (a whole
number of 8x8 tiles) is extracted to a PNG beside its `.bin`: tiles in blob
order, sixteen per row, four-colour indexed, with the tile count in the file.
`make` re-encodes any blob whose PNG is newer (`tools/gfx.py encode`, then
`tools/lz.py` for an `lz_*` stream); `make check` verifies every PNG encodes
back to its blob. Enlarging the canvas and drawing past the last tile grows
the blob; blank padding in a partial last row does not. `tools/extract.py
--keep` re-extracts around edited files instead of over them.

Copy sizes follow the blob where the source can say so:

* whole raw blob: `ld c, (Next - Blob) / 16`;
* whole decompressed stream: `ld c, Blob_SIZE / 16`, with `Blob_SIZE` in
  `data/<bank>/lz_Blob.inc` (derived by `tools/lz.py --size-inc`), INCLUDEd
  after the INCBIN, or in the copying bank's holder (`src/bank_XXX.asm`) when
  that is another bank;
* partial copy: a decimal tile count with a comment naming the blob and the
  tiles it takes;
* BG map copy: rows (`SCREEN_HEIGHT * TILEMAP_WIDTH / 16`,
  `4 * TILEMAP_WIDTH / 16`, `TILEMAP_AREA / 16`);
* anything else: a decimal tile count. `make test` fails on a hex count before
  a `QueueVRAMCopy`.

A blob that is a run of sprite frames carries a **layout** (`gfx:2x2`,
`gfx:3x4+3`, `gfx:4x4+4` in the manifest; `layout=` in the PNG). `WxH` is one
frame as W columns of H tiles, column-major (the order the 8x16-object queues
consume, §4.2); `+S` is S extra tiles per frame drawn as a row under it.
Frames go left to right; leftover tiles follow as a plain row. The layout is a
fixed permutation, so encoding back is exact.

| layout | blobs | what a frame is |
|---|---|---|
| `2x2` | the 570 walk-sprite `_GfxNN` blobs (banks `$6a`, `$6f`, `$70`-`$77`) | one 16x16 facing, two 8x16 objects (`QueueSprite16`); a 256-byte blob is the four facings side by side |
| `3x4+3` | the 240-byte character frames of banks `$40`-`$5d`, and each bank's `SpriteFramesUnused` run | the 24x32 body as three 4-tile columns (`QueueSprite24x32`, `$00:$2c2b`), then the three standing-shadow tiles that replace each column's bottom tile in VRAM when `wStandingShadowsEnabled` is set (`QueueCharFrameTiles`, `$00:$2ead`) |
| `4x4+4` | the 60 320-byte character frames (the `01 10` per-slot OAM records, §4.3) | the same at 32x32 with four columns and four shadow tiles |

Every other graphics blob is plain. A blob drawn only through
`QueueSpriteTemplate` stays plain; its template (§4.1) says how it is arranged.

## 1. The LZ format

### 1.1 Stream shape

`DecompressData` (`$00:$1797`, `src/home/decompress_00.asm`) is the only
decompressor. `hl` = source, `de` = destination; returns `hl` = bytes written.

A stream is a sequence of **groups**: one **control byte**, then the items its
flags introduce, flags consumed **LSB first**:

| flag | item | bytes read |
|---|---|---|
| `1` | literal — copy one byte to the output | 1 |
| `0` | match — copy a run from earlier in the output | 2 |

`.nextControlByte` (`$179b`) does `ld a, [hl+]` / `scf` / `rra` / `ld c, a`: a
set sentinel goes into bit 7 and flag 0 into carry (tested by `jr nc, .match`,
`$179f`). The other seven positions are unrolled copies of `.nextFlag`
(`$17a4`): `srl c` / `jr z, .nextControlByte` / `jr nc, .match`. When the
sentinel is shifted out, `c` is zero and a new control byte is fetched; that is
the only group counter, which matters because `.matchTail` re-enters at
`.nextFlag` (§1.2), not at the position it left. Eight straight literals fall
into the `jr .nextControlByte` at `$17e3`.

### 1.2 The match token

`.match` (`$17f3`) reads `lo` then `hi`:

```
  distance  = 0x800 - (((hi >> 5) << 8) | lo)      ; 3 high bits of hi + all of lo
  length    = (hi & 0x1f) + 3
  lo == 0 && hi == 0  ->  end of stream
```

The back-pointer is `hl = de + ($f800 | (hi rotated left 3, low 3 bits) << 8 |
lo)` (`rlca` ×3, `or $f8`, `$17fc`-`$1801`): a negative offset from the write
pointer. The window is **2 KiB** and a copy may overlap the write position.

`and $1f` (`$1804`) extracts the length field, consumed bit by bit through a
ladder of fixed-size copies (`srl b` / `jr nc` per rung, `jr z, .matchTail`
once no bits remain): `.match` body `$1809` 1 byte, `.match2` `$1812` 2,
`.match4` `$181e` 4, `.match8` `$1830` 8, `.match16` `$184e` 16, then
`.matchTail` `$187e` 3 bytes unconditionally. That tail is the `+ 3`: lengths
run **3 to 34**. `.matchTail` ends `pop hl` (source pointer pushed at `$17f6`)
/ `jp .nextFlag`.

### 1.3 Terminator and the pad byte

`lo = hi = 0` terminates (`or b` / `jr z, .done`, `$17f8`). The original
encoder always writes **three** zero bytes. If the terminator starts a fresh
group the decoder reads all three (`$00` control byte plus `$0000`); mid-group
it reads only the `$0000` and the third byte is never read. `tools/lz.py`'s
`decompress()` counts that byte so extents match: all 697 mid-group streams pad
with `$00`; the 142 fresh-group streams have no pad.

A distance of 2048 at minimum length would encode as `$0000`, the terminator;
`lz.py`'s `MAX_DIST = 0x7FF` prevents it.

### 1.4 Entry points

| routine | addr | inputs |
|---|---|---|
| `DecompressData` | `$00:$1797` | `hl` source, `de` dest → `hl` = bytes written |
| `DecompressDataFromBank` | `$00:$0234` | `h` = ROM bank, `l` = **byte offset into that bank's `$4000` pointer table**, `de` dest |

`DecompressDataFromBank` (`src/home/vectors_00.asm`) banks in `h`, reads the
word at `$40:l` and calls `DecompressData` on it. A **slot word** `bbss` thus
means "bank `$bb`, entry `ss/2` of its `$4000` directory": the encoding `dslot`
emits (`include/macros.inc`) and `CopyDataFromBank` (`$00:$021a`) uses for
uncompressed payloads. 282 `call` sites in `src/` reach one of the two.

### 1.5 The corpus

`data.manifest` declares **839** LZ streams; `check.py`'s `lz` check (§7.5)
requires each to decode using exactly its declared extent and to round-trip.

* **315,831 compressed bytes → 804,924 decompressed** (39.2%).
* **803 decompress to a multiple of 16 bytes** (whole tiles or map planes). The
  36 that do not are small tilemap/attrmap rect streams in banks `$1a`-`$1e`
  (`CharDataScreen*`, `CharDataConfirmScreen*`, `Results*Tilemap_1e`,
  `ResultsPlayerPanelAttrmap_1e`), 9 to 130 bytes.
* Sizes: min 9, max 4096; commonest 1024 (×202), 256 (×109), 64 (×105),
  4096 (×84), 320 (×71), 144 (×44), 32 (×40), 240 (×40), 576 (×13), 96 (×7).
* Example: `MinigameCourtTiles` (`$5f:$4060`) is 2037 → 3024 bytes,
  `MinigameCourtTilemap` (`$5f:$4855`) 625 → 1024
  (`python3 tools/lz.py baserom.gbc <off>` decodes one).

### 1.6 Editing a stream

`lz.py -c infile outfile` encodes: greedy longest-match LZ77 over the 2 KiB
window, verified to decode back before writing. A re-encoded stream need not
match the original bytes, only decode to the same data, provided the bank has
room. Streams live at `data/<bank_XXX>/lz_<Label>.bin` (gitignored, extracted
by `setup.sh`).

**Never name an offset inside an `lz_*` extent**: a label there silently
truncates the stream. `check.py`'s `lz-labels` catches it.

---

## 2. Tiles, tilemaps, and reaching VRAM

### 2.1 The tile

Standard Game Boy **2bpp, 16 bytes**: eight rows of two bytes, low bitplane
first, bit 7 = leftmost pixel (`tiles_image` in `tools/gfxdump.py`):

```python
c = (lo >> (7 - x) & 1) | ((hi >> (7 - x) & 1) << 1)
```

`TILE_SIZE equ 16` (`include/hardware.inc`) is used in address arithmetic,
e.g. `wDecompBuffer + 1 * TILE_SIZE` at `$0a:$58f9`.

### 2.2 `QueueVRAMCopy` counts tiles, not bytes

`QueueVRAMCopy` (`$00:$0480`, `src/home/memory_00.asm`) is **the only way
anything reaches VRAM**: 610 `call` sites, no direct `ld [$8xxx], a` anywhere.

```
hl = source
de = destination (see §2.3)
c  = length in 16-byte blocks
```

`c` is a **tile count**: `StartVRAMDMAFromHL` (`$00:$18eb`) hands `c - 1` to
the GDMA length register, so `c = $80` moves 2048 bytes. Being off by a factor
of 16 is the easiest mistake when adding a copy.

With the LCD off the transfer runs immediately as a GDMA. Otherwise it goes
into `wVRAMCopyQueue`, drained in VBlank by `ProcessVRAMCopyQueues`: **ten
slots**, probed at `wVRAMCopyQueue + $a0`, `+$a8`, … `+$e8` (`$049c`-`$04d2`).
On overflow it sets `hVRAMQueueDirty` and, in debug step mode only, plays a
sound; nothing else reports it. Each slot records ROM bank, WRAM bank, source,
VRAM bank and destination, so a queued copy is bank-safe.

### 2.3 The VRAM bank rides in bit 13 of the destination

```asm
def VRAM_BANK1 equ $2000        ; include/constants.inc
```

`QueueVRAMCopy` does `bit 5, d` to select `rVBK` and `res 5, d` to recover the
address (`$0486`-`$048d`): `$b800` is `$9800` in VRAM bank 1, written
`vBGMap0 + VRAM_BANK1`. Every VRAM address in the code (828 sites) is written
as `vTiles0`/`vTiles1`/`vTiles2` plus `$NN * TILE_SIZE`, or `vBGMap0`/`vBGMap1`
plus `row * TILEMAP_WIDTH + col`: copy and loader arguments, destinations
other routines take (`InitNumberSpriteGfx`, `CopyMugshotBufferToVram`,
`ResultPortraitSlotTable`), and bases added to an offset (`ld de, vBGMap0` /
`add hl, de` at `$00:$223a`).

A word in `$8000`-`$9fff` is named by what consumes it, not its range. Sprite
positions are `ld_xy de, x, y` (x in `d`, y in `e`, as `QueueSprite` takes
them); BG cells handed to text and window routines are `ld_cell de, column,
row` (`include/macros.inc`). Left as numbers: a packed attribute/tile pair
(`ld bc, $800d` for `WriteWindowCellTileAttr`), a clamped return value
(`ld hl, $8001` in `GetTangent`, `$00:$1793`), two `ld bc, $8000` arguments
to `InitCa00RecordFromCharId` in `LoadStorySlot`, and three `map_script` flag
conditions.

### 2.4 The two map planes

A CGB BG cell is a **tile index** in VRAM bank 0 and an **attribute byte**
(palette, tile VRAM bank, flips, priority) in bank 1 at the same address. The
game keeps them as two WRAM planes and blits each separately.

`CopyScrolledSceneTilemapToVram` (`$0a:$5c29`, `src/engine/story/scene2_0a.asm`):
the attribute half (`$5c6b`-`$5cb6`, `rVBK = 1`) walks `wMapBuffer64` (4096
bytes, WRAM bank `$02`) and writes 21 rows × 23 columns into `$9800`, source
and destination wrapping independently:

* source stride `$40`, `and $3f` → a **64-wide** map;
* destination stride `$20`, `and $1f` → the **32-wide** hardware tilemap
  (`TILEMAP_WIDTH equ 32`).

The tile half repeats this with `rVBK = 0`: a 64×64 map in WRAM, a 32×32
window into it in VRAM.

Court and menu screens use flat 32×32 planes: `wShadowTilemap` (1024 bytes,
WRAM bank `$03`) and `wScreenAttrmap` (1024 bytes, WRAM bank `$02`).

### 2.5 The `tilemap` spec

Screen layouts are written as rows of cells. The 231 blobs `data.manifest`
tags `tilemap:W` (all `lz_*`, decompressed first) get a `.tilemap` text grid
beside their `.bin` (`tools/tilemap.py`); the Makefile encodes an edited grid
back and `make check` (`tilemap`) round-trips every one. Character-data screen
patches (runs of a 32-wide plane copied in at a row and column, e.g.
`wDecompBuffer + 18 * TILEMAP_WIDTH`) are tagged when they start at column 0;
those starting mid-row keep only their `.bin`. The 70 small layouts in the
source carry a `(tilemap:W)` comment on their first line. Both use:

```asm
	tilemap_begin <width>, <height>
	tilemap_row $.., ... ; row 0
	...
	tilemap_end
```

`tilemap_row` asserts the byte count against the width and `tilemap_end` the
row count and total size (`include/macros.inc`), so a mis-declared width fails
the build. A trailing partial row stays literal `db`.

---

## 3. The scene slot table

### 3.1 Geometry

`SceneGfxSlotTable` (`$0a:$59d9`, `src/engine/story/scene_0a.asm`) is **592
bytes = 37 records × 8 slot words** (`dslot`, §1.4). It enumerates densely:
record 0 is bank `$5f` entries `$00`-`$0e`, record 1 `$5f` `$10`-`$1e`,
record 2 `$60` `$00`-`$0e`, … record 36 bank `$69` `$20`-`$2e`. Banks
`$5f`-`$69` supply 2, 4, 4, 4, 4, 3, 3, 4, 3, 3 and 3 records. It is followed
directly by `CopyScrolledSceneTilemapToVram`.

### 3.2 Slot roles under the story loader

`LoadStorySceneGraphics` (`$0a:$585d`, `src/engine/story/scene_0a.asm`) takes
the scene id in `a`, computes `SceneGfxSlotTable + 16*a`, pushes slots 0-6
(`$586f`-`$5891`), reads slot 7 inline, then pops in reverse:

| slot | destination | how | addr |
|---|---|---|---|
| 0 | `wStorySceneRecord` | raw copy, `bc = wStorySceneRecord_SIZE` (136 bytes) | `$590f` |
| 1 | `wDecompBuffer` → `LoadPaletteShadow` | raw copy, `bc = $0040` | `$58f6` |
| 2 | `wShadowTilemap` (WRAM `$03`) | LZ | `$58e6` |
| 3 | `wScreenAttrmap` (WRAM `$02`) | LZ | `$58d9` |
| 4 | `wCollisionMap` (WRAM `$06`) | LZ | `$58cc` |
| 5 | `wBehaviorMap` (WRAM `$06`) | LZ | `$58c5` |
| 6 | — | **popped and discarded** | `$58bd` |
| 7 | `wDecompBuffer` → VRAM | LZ, then `QueueVRAMCopy` | `$589e` |

Slot 6 is a fossil: `$58bd` pops it and `$58be` sets
`de = wStorySceneUnusedBuffer`, but both are overwritten before any call.

Slot 7's tiles go to `vTiles2 + VRAM_BANK1`, `c = 128`, and `wTextTileBuffer`
to `vTiles1 + VRAM_BANK1`, `c = wTextTileBuffer_SIZE / 16` (128)
(`$58a4`-`$58b4`): together `$8800`-`$97ff` of VRAM bank 1.

Slot 1's 64 bytes become **BG palettes 2-7**: from byte 16
(`wDecompBuffer + 1*TILE_SIZE`), `ld_bg_pals de, 2, 6` (`$58ff`). The block's
first two palettes are skipped, reserving BG 0/1 for the text window.

Slot 0 is read back at `$5912`-`$5922`: `wStorySceneRecord + 2` →
`wMapScrollMinX`, `+3` → `wMapScrollMinY`, `+4` → `wMapWidthTiles`, `+5` →
`wMapHeightTiles`.

### 3.3 The two record shapes

| records | slot 2 / slot 3 | slot 4 / slot 5 | shape |
|---|---|---|---|
| **0-15** (16) | 1024 / 1024 | *not LZ streams* | court / backdrop |
| **16-36** (21) | 4096 / 4096 | 1024 / 1024 | walkable story location |

Story records have 64×64 tile and attribute planes and 1024-byte collision and
behaviour maps, the size of `wCollisionMap` (`$d000`) and `wBehaviorMap`
(`$d400`), indexed by `GetCollisionMapCellAddr` (`$0a:$5edd`) and
`GetBehaviorMapCellAddr` (`$0a:$5f31`).

`GetCollisionMapCellAddr` indexes a **32 × 32 grid of 2 × 2-tile cells**: it
rounds `d` and `e` down to even, computes `e * 16` on the rounded `e` (=
`(e >> 1) * 32`, a 32-byte row), adds `d >> 1` and `wCollisionMap`. The player's
cell is (`X / 2`, `Y / 2`).

### 3.4 The same slots mean something else to the court loader

`LoadCourtSceneGraphics` (`$0a:$62f8`, `src/engine/story/scene4_0a.asm`) loads
the court backdrops with the **same 16-byte stride**, skipping slot 0 (`$630a`)
and slot 6 (`$6325`), pushing 1-5 and reading 7 inline:

| slot | destination | how | addr |
|---|---|---|---|
| 1 | `wScreenAttrmap` (as scratch) → palettes | raw copy, `bc = $0040` | `$6381` |
| 2 | `wCourtTilemapSaved` | LZ | `$6377` |
| 3 | `wCourtAttrmapSaved` | LZ | `$6370` |
| 4 | `wScoreboardColumnTiles` | raw copy, `bc = wScoreboardColumnTiles_SIZE` (40 bytes) | `$6363` |
| 5 | `wScoreboardColumnAttrs` | raw copy, `bc = wScoreboardColumnAttrs_SIZE` | `$6359` |
| 6 | — | skipped | `$6325` |
| 7 | `wDecompBuffer` → VRAM | LZ | `$6333` |

**Slot 4 = collision map is a property of the loader, not the table.** In all
16 court records slot 4 equals slot 0 (the scoreboard column tiles are the
first 40 bytes of the 136-byte config record) and slot 5 is slot 0 + 40.
Slot 6, where it is not the neighbouring record's slot 0 or 1, is slot 0 + 80.

Palette quirk: `$638a` loads 6 palettes at index 2 from byte 16 (BG 2-7, as
§3.2), then `$6393` loads **1 palette at index `$0b`** (OBJ 3) from
`wScreenAttrmap + 1*TILEMAP_WIDTH + 8`, byte 40, which is BG palette 5. Those
eight bytes are both; changing one changes the other.

### 3.5 The stride-18 readers (a debug-path bug)

`Unused_0a_LoadSceneGraphicsDirect` (`$0a:$5d2a`, `src/engine/story/scene2_0a.asm`)
indexes the table with stride **18** (`$5d31`-`$5d37`), skips 2 bytes and reads
nine words per record; `GetSceneSlotPtr` (`$0a:$5d0b`) does it correctly with
stride 16. `Unused_0a_InitSceneViewer` (`$0a:$601c`) and
`Unused_0a_InitSceneViewerDefault` (`$0a:$6076`) agree with 18: they count words
to the first zero word and divide by **9** (`ld de, $0009`, `$603e`, `$608e`).
The first zero word is at word index 932, 1272 bytes past the table, so that
count is meaningless, and `Unused_0a_InitSceneViewerDefault` uses `inc c` for
`inc bc`, leaving `b = $ff`. The real count, 37, is hardcoded as `ld a, $25`
(`$0a:$5934`). The direct loader also loads 7 palettes at index 1 from byte 8
(`ld_bg_pals de, 1, 7`, `$5dd7`), where both working loaders use 6 at index 2
from byte 16.

Only the unreachable scene viewer uses this path; see [bugs.md, "The scene
viewer indexes the slot table with the wrong
stride"](bugs.md#the-scene-viewer-indexes-the-slot-table-with-the-wrong-stride).
**A new consumer of `SceneGfxSlotTable` should use stride 16**; the debug
path is not a second interpretation of the table.

---

## 4. Sprites

### 4.1 Sprite templates

A **sprite template** is a list of 4-byte OAM rows ended by a single `$80`:

```asm
	oam_sprite dy, dx, tile, attr      ; include/macros.inc
	...
	oam_sprite_end                     ; $80
```

`QueueSpriteTemplate` (`$00:$1e9d`, `src/home/fade_00.asm`) takes `hl` =
template and a base in `e` (Y), `d` (X), `c` (tile), `b` (attr), and emits
`byte0 + e`, `byte1 + d`, `byte2 + c`, `byte3 + b` per row (hardware OAM
order, all adds mod 256, so `$fc` is 4 left by wraparound). The terminator is
tested on **dy** only (`cp $80`, `$1ebb`), so dy can never be `$80`. It stops at
160 bytes / 40 entries (`cp $a0`, `$1eb6`). It applies no bias;
`QueueSprite` (`$00:$1f51`) adds `+$0c` to Y and `+$04` to X.

With base attr bit 5 (X-flip) set, a second loop (`$1ee0`-`$1f05`) uses
X = `base_x + (8 - dx)` (`cpl` / `add $09`) and combines attr with **`or`**
(`$1f01`).

There are 170 templates. `StandingShadowOamTemplate` (`$08:$6301`) is reached
by `jp QueueSpriteTemplate` (`DrawStandingShadowSlot`, `$08:$6534`); all others
by `call`.

### 4.2 The sprite queue

Two 160-byte shadow-OAM pages; `wSpriteBufferPage` holds the high byte of the
page being built, `hSpriteQueueIndex` the write offset, capped at `$a0`. Every
routine re-checks the cap and silently drops the sprite on overflow.

| routine | addr | inputs |
|---|---|---|
| `QueueSprite` | `$00:$1f51` | `e`+$0c → Y, `d`+$04 → X, `c` tile, `b` attr; 1 entry |
| `QueueSprite16` | `$00:$1e55` | 2 entries at X and X+8, tiles `c` and `c+2`; `bit 5, b` swaps emission order |
| `QueueSpriteTemplate` | `$00:$1e9d` | `hl` template + base (§4.1) |
| `Unused_00_QueueSpriteGrid` | `$00:$1f0d` | `h` columns, `l` rows; +8 X and +2 tile per column, +$10 Y per row |
| `QueueSprite24x32` | `$00:$2c2b` | 6 8×16 objects |
| `QueueSprite32x32` | `$00:$2ced` | 8 8×16 objects via `QueueSpriteBlockPart` |
| `QueueSpriteBlockPart` | `$00:$2d79` | one part; advances `c` by 2 |
| `Unused_00_PositionSpriteWorld` | `$00:$1f6b` | world coords, subtracts `wCameraX/Y`, culls, ×8 → `QueueSprite16` |

### 4.3 Object headers

Overworld and on-court characters are described by a **16-byte object
header**. `ObjectIdList_04` (`$04:$4f75`) maps 117 object ids to slot words
(§1.4) resolved by `CopyDataFromBank`; a `$0000` row ends it (counted by
`GetObjectDefCount`). Each row is `object_id NAME, DataPtr_*`, defining
`OBJ_NAME` as the row's index:

| ids | objects | names |
|---|---|---|
| `$00`-`$1d` | the character banks `$40`-`$5d`, one match sprite each | `OBJ_MATCH_ALEX` ... `OBJ_MATCH_BABY_MARIO` |
| `$1e`-`$74` | the walk-sprite banks `$6f`-`$77` | `OBJ_WALK_<bank>_<slot>`, or a name where known |

Named walk sprites:

* **31 from the game**: `CharObjectIdTable` (`$04:$4c29`, read by
  `Unused_04_GetCharObjectId`) gives each `CHAR_*` id its overworld object
  (`OBJ_ALEX`, `OBJ_MARIO`, `OBJ_YOSHI`, …; the two unused roster slots share
  `OBJ_BALLOON_ELLIPSIS`). Ids `$56`-`$59` are `OBJ_ALEX_B`, `OBJ_NINA_B`,
  `OBJ_HARRY_B`, `OBJ_KATE_B`: the same drawings with fewer frames, loaded as
  `base + gender` by `LoadCourtPlayerPartnerObjDefs_14` and the ending scenes.
* **22 from their graphics**: eight speech balloons (`OBJ_BALLOON_EXCLAIM`,
  `_QUESTION`, `_ANGRY`, `_ELLIPSIS`, `_SCRIBBLE`, `_MUSIC`, `_SHOCK`,
  `_SWEAT`), `OBJ_RACKET`, `OBJ_TROPHY` (handed over at the awards ceremony by
  swapping object definitions), `OBJ_TOAD`, `OBJ_BOB_OMB`, `OBJ_BOO` (Peach's
  Castle), `OBJ_CAT` (dorm room), `OBJ_RACKET_STUDENT`, the Training Gym's six
  exercisers (`OBJ_WEIGHTLIFTER_A/B`, `OBJ_SITUPS_A/B`,
  `OBJ_JUMPING_JACKS_A/B`) and `OBJ_INVISIBLE` (all-zero graphics; the
  Tournament Courtyard's talk targets).
* The remaining 31 `OBJ_WALK_<bank>_<slot>` are the anonymous students and
  staff of `docs/story_mode.md`. Bank `$6a` holds five more walk sprites no
  object id reaches.

`LoadActorObjectDef` (`$04:$4ac6`) copies the header to `wActorObjDef` and
expands it into the actor struct; `SetupCharSpriteFromObjectDef` (`$04:$4b68`)
is the on-court equivalent:

| off | actor field | char symbol | meaning |
|---|---|---|---|
| +0 | +$37 | `wCharSpriteAttr` / `wCharGfxBank` | OAM attribute / CGB OBJ palette. `$63` is a sentinel (`cp $63` at `$04:$4b2b`): `LoadActorObjectDef` then stores attr `$02` and loads the 8-byte palette at +8 into OBJ palette 2 via `LoadPalettesMasterOnly` (`$00:$05e1`); no object uses it |
| +1 | +$35 | — | **facing count**. `UpdateActorFacingFromHeading` (`$04:$5673`, `$5687`) forces facing 0 when this is 1; a single-facing object uses only the first 16x16 of each frame blob |
| +2,+3 | — | — | not read; `$02 $00` in all 92 walk-sprite headers, `$03 $00` in the character banks |
| +4,+5 | +$24 | `wCharFrameTablePtr` | frame-pointer array |
| +6,+7 | +$28 | `wCharAnimTablePtr` | **animation-script pointer table** |
| +8,+9 | — | — | palette pointer, only when byte 0 == `$63` |
| +10,+11 | +$38 | `wCharShadowTablePtr` | per-frame 4-byte placement/upload records |

Frames are 64 bytes per facing (256 for 4 facings).
`QueueActorFrameTileCopy` (`$04:$56c3`) indexes the frame table by
`frame * 2`, adds the `FACE_*` value (`$00`/`$40`/`$80`/`$c0`) as a byte offset
inside the frame, and uploads `c = $04` tiles: a 16×16 metasprite of two 8×16
objects.

`SetActorAnimation` (`$04:$4bbe`, body `$4bde`) and `SetCharAnimation`
(`$08:$69ea`, body `$69fc`) index the +6 table by `animation id * 2`. In the
walk-sprite banks it is `WalkSprite_<bank>_<slot>_AnimPtrs` and its scripts
`..._AnimNN` (§4.4). The header's first row is commented
`OAM attr, facing count, unread, unread`.

### 4.4 Animation scripts

Two-byte entries: **low byte** a frame index or command, **high byte** its
operand.

| entry | macro | meaning |
|---|---|---|
| `nn dd` (`nn < $f0`) | `anim_frame nn, dd` | show frame `nn` for `dd` ticks |
| `ff dd` | `anim_loop dd` | restart at script base + `dd` |
| `fe aa` | `anim_set aa` | switch to animation `aa` |
| `fb mm` | `anim_flip mm` | `attr = (attr & $0f) ^ mm` — **bank `$08` only** |
| `fd` (and any other `$f0`-`$fd`) | `anim_hold $fd` | hold the current frame forever; **one byte** |

A hold writes `$ff` to the delay and never advances the script pointer
(`$04:$55f3`, `$08:$77b6`). `anim_flip` (`and $0f` then `xor d`, `$08:$77d6`)
**replaces** the attribute's high nibble rather than toggling; with the
operands used (`$20`, `$00`) the difference is invisible.

All scripts use these macros (570 character-bank, 635 walk-sprite in banks
`$6a`, `$6f`, `$70`-`$77`). 34 end on a byte the macros cannot spell, written as
a commented `db`:

- **Unread hold operand**: `SeanSpriteAnim04` (`$47:$7f67`) and six walk-sprite
  scripts end `$fd, $00`; the `$00` is `db $00 ; never read: the hold above
  ends the script`.
- **Loop operand in the next script**: the five-byte `03 14 04 1e ff` script
  of 27 walk-sprite objects ends on a bare loop whose operand is the next
  script's first byte, always `$00`, so it restarts at +0. Written `db $ff ;
  anim_loop whose operand is the next script's first byte ($00)`.

### 4.5 The two interpreters

| | `AdvanceActorAnimation` | `StepCharAnimation` |
|---|---|---|
| addr | **`$04:$55c1`** (`src/engine/story/actor4_04.asm`) | **`$08:$7791`** (`src/engine/match/char6_08.asm`) |
| scope | overworld actors — struct in `bc`, WRAM bank `$04` | on-court characters — fixed `$df00` struct |
| far read | `FarReadWord`, bank from actor `+$22` | `FarReadWordDI`, bank from `wCharObjectBank` |
| `$fb` | **not implemented** (falls into "hold") | implemented (`$08:$77b2`) |
| delay tick | `[+$2f] -= [+$18]` (or `[+$19]` when `bit 7,[+$05]`), clamped — a per-actor animation *speed* | plain `dec wCharAnimDelay`, 1 per frame |
| frame change | stores to `+$33`, sets bit 6 of `+$30` | stores to `wCharAnimFrame`, sets bit 6 of `wCharSpriteDirty` |

The character banks `$40`-`$5d` also carry `*SpriteOam` (e.g. `AlexSpriteOam`,
580 bytes = 145 × 4): per-frame placement records
`{x offset, y offset, size flag, tile count}`, not OAM rows, read at
`$00:$2e7e`-`$2e8a`. `DrawCharSprite` (`$08:$650a`) dispatches on the size flag
to `QueueSprite24x32` (0) or `QueueSprite32x32`.

---

## 5. Palettes

### 5.1 Encoding

A colour is one **little-endian BGR555 word**:

| bits | field |
|---|---|
| 0-4 | red |
| 5-9 | green |
| 10-14 | blue |
| 15 | unused |

The game's `SplitColorComponents` / `CombineColorComponents` (`$00:$1c6a` /
`$00:$1c83`) convert between the word and components. A palette is 4 colours
= 8 bytes; a full set of 8 is **64 bytes**.

### 5.2 The `palettes` spec

157 regions are `palettes`. Their values are **not committed**: the source
`INCLUDE`s `data/bank_XXX/<Label>.asm`, generated at setup by
`render_palettes` (`tools/extract.py`) with one `palette` macro per palette
(four colours as 5-bit `r,g,b`, packed by the macro, `#rrggbb` in a comment).
The nine palettes whose words set bit 15 (five files in banks `$17`, `$1c`,
`$28`, `$39`) stay `dw`. Rows are fixed at 8 bytes.

Sizes (7,864 bytes over 157 regions): 86 full 64-byte sets, 28 single
palettes, 4 32-byte half-sets, 6 of 128 bytes (BG+OBJ, like
`wMasterPalettes`), the rest in between; all whole palettes, so `render_palettes`' raw-`db` tail
branch never fires.

### 5.3 The live/master pair

All in fixed WRAM / HRAM:

| symbol | addr | size | role |
|---|---|---|---|
| `wBGPalettes` | `$c100` | 64 | live BG, uploaded in VBlank |
| `wOBJPalettes` | `$c140` | 64 | live OBJ |
| `wMasterPalettes` | `$c200` | 128 | master copy of both; fades scale this into the live pair |
| `hPaletteDirtyFlags` | `$ff9d` | 1 | bit 0 = BG dirty, bit 1 = OBJ dirty |
| `hFadedOut` | `$ffbc` | 1 | |

`LoadPalettesImmediate` (`$00:$05b5`, `src/home/memory_00.asm`) takes `d` =
palette index 0-15, `e` = count, `hl` = source, and writes each word to
**both** live and master (`d` starts at `$c1`, toggled by `inc d`/`dec d`,
`$05bf`-`$05c9`). Indices 0-7 = BG (`$c100`), 8-15 = OBJ (`$c140`), master at
`$c2xx` with the same low byte. Index ≥ 8 (`bit 3, d`) skips the BG dirty
flag; `e + d >= 9` sets the OBJ flag.

`LoadPaletteShadow` (`$00:$05b0`) is the same entry, but when `hFadedOut` is
set it diverts to `LoadPalettesMasterOnly` (`$00:$05e1`, master only), so the
palettes appear when the fade-in runs. `RestorePalettesFromMaster`
(`$00:$05f4`) copies master to live and sets both dirty bits.

`ApplyPendingPaletteUpdates` (`$00:$060d`) uploads in VBlank:
`LoadBGPaletteData` (`$00:$027f`) writes `$80` to `rBGPI` (auto-increment) and
streams 64 bytes to `rBGPD`; `LoadOBJPaletteData` (`$00:$0287`) the same via
`rOBPI`/`rOBPD` (BCPS/BCPD and OCPS/OCPD elsewhere).

### 5.4 How a fade applies

The bank `$00` fade is a per-frame state machine (`hFadeState` `$ffa2`,
`hFadeSpeed` `$ffa3`, `hFadeCounter` `$ffa4`, starts `$7c`) ticked from VBlank
by `UpdateFadeOut` (`$00:$1d5e`) and `UpdateFadeIn` (`$00:$1d48`)
(`src/home/colorfade_00.asm`). Entry points: `BeginFadeOut` (`$00:$1d20`),
`BeginFadeIn` (`$00:$1d2e`), `ForceFadeIn` (`$00:$1d0c`); `c` = speed.

Each tick:

```
b = hFadeCounter - hFadeSpeed        ; clamped at 0
fade-out: c = $7c - b                ; ascends 0 -> $7c
fade-in:  c = b                      ; descends $7c -> 0
hl = wMasterPalettes / de = wBGPalettes / b = $40 / c >>= 2
call AdjustColorsBrightness          ; 64 colours = BG + OBJ in one pass
hPaletteDirtyFlags = $03
```

`AdjustColorsBrightness` (`$00:$1cd9`) calls `AddClampColorComponent`
(`$00:$1ca0`) with `d = c` on each of r/g/b: `add d`, then clamp to 0 if bit 7
is set (`$1ca1`), else to `$1f`.

The fade is an **additive per-component offset saturating at 31**, not a
multiply. The delta is 0-31 (`srl c` twice, `$00:$1d8c`/`$1d8e`, is logical),
rising during a fade-out, so the bank `$00` fade goes to **white** and a
fade-in comes back from white. The clamp-to-zero branch is unreachable from
this caller.

The `hFadeState` bit-7 path, `Unused_00_ApplyWhiteFade` (`$00:$1dcc`), is
unreachable (`docs/bugs.md`). It also adds toward `$1f`, with one 16-bit add
per colour, saturating at `$1e` because it pre-clears each field's low bit.

A **second, independent** fade engine is in bank `$03`, with buffers in WRAM
bank `$06` (`wPaletteFadeTarget` `$d0a0`, `wPaletteFadeLive` `$d140`,
`wPaletteFadeMask` `$d1e0`, 16 bytes). It steps each component **±1 per pass**
toward a target:

1. `CopyMasterPalettesToFadeBuffers` (`$03:$75e9`) seeds both buffers from
   `wMasterPalettes`;
2. the target is rewritten by `Unused_03_ClearFadeTargetPalettes`
   (`$03:$7606`, → black) or `DesaturateFadeTargetPalettes` (`$03:$7616`,
   → grayscale);
3. `AnimatePaletteFadeToTarget` (`$03:$7719`) waits `wPaletteFadeFrameDelay`
   frames, steps every masked live palette with
   `StepPaletteColorsTowardTarget` (`$03:$7764`), uploads, and repeats
   `wPaletteFadeAmount` times; `SnapPalettesToTarget` (`$03:$77e2`) then copies
   the target over.

Farptr entry slots: `$03:$4040` (`InitGrayscalePaletteFade`), `$03:$4042`
(`SetupPaletteFadeMask`), `$03:$4044` (`AnimatePaletteFadeToTarget`). The live
callers, `RunEndingCreditsSequence` (`$0a:$6ece`) and `PlayScreenSequence0`
(`$18:$76dd`), fade to grayscale; `Unused_03_InitBlackPaletteFade`
(`$03:$75ca`) is unreachable, so nothing fades to black.

---

## 6. Text

The id decode, fetchers, control-code engine (`$05:$4e5d`) and glyph
rasterisation are in `docs/screens_and_ui.md` §7.1-§7.3. This section covers
the physical layout.

### 6.1 Id → (bank, index)

| bits | meaning |
|---|---|
| 15 | string is in SRAM (player-entered names) |
| 13-10 | fetcher selector 0-15 → text bank |
| 9-0 | string index within that bank |

`FetchDialogueText` (`$05:$5c18`) tests `bit 7, h`, builds
`de = (h & $03) << 8 | l` and `a = (h >> 2) & $0f`, and jumps through
`DialogueTextFetchers_05` (`$05:$5c3b`, `src/engine/text/dialogue_05.asm`), a
16-word table.
Selectors 0-7 → banks `$30`-`$37`; 8 → `$6e`, 9 → `$1f`, 10 → `$25`,
11 → `$26`, 12 → `$5e`; **13-15 alias `$30`**.
`include/text_ids.inc` names ids by the bank the selector resolves to.

### 6.2 Pool layout

All 13 text banks share this prologue (`src/data/text/text_30.asm`):

```asm
	farptr FetchDialogueText_XX      ; $4000
	farptr FetchShortText_XX         ; $4002
FetchTextTable_XX:                       ; $4004  — spec `text_offsets`
	dw TextStrings_XX.sN - TextStrings_XX ; <index>
	...
TextStrings_XX:                          ; — spec `text_pool`
```

The offset table runs to the pool, so it has `(pool - $4004) / 2` entries:
**4,109 strings** in all, the most in bank `$36` (711) and `$30` (560).
`AddTextIdOffsetWordLookupTable` (`$05:$5d99`) holds the 13 per-bank counts in
selector order; `AddTextIdOffset` (`$05:$5d2b`) uses it to carry an id offset
across banks, so ids form one flat sequence.

Strings are **`$00`-terminated**; `$01` is a newline, `$02` a page break.
`FetchText_30` (`$30:$7d92`) adds the table word at `index*2` to
`TextStrings_30` and copies to `wTextBuffer` (`$c600`, 160 bytes) or, with
`a != 0`, `wShortTextBuffer` (`$d880`, 16 bytes).

### 6.3 The `.sN` anchors are not string indices

`string_starts` (`tools/extract.py`) splits the pool on `$00` **or `$03`**
(`WaitTextAdvanceInput`), so the `.sN` labels number fragments: in
`text_30.asm` index 2 → `.s3`, 3 → `.s5`, 4 → `.s7`. The comment after each
`dw` carries the game index.

Unchecked invariants: each `text_offsets` table is followed by its
`text_pool`, entry 0 is `$0000`, and every word lands on a string start inside
the pool.

`include/text_ids.inc` is hand-maintained: 1,392 `def Text_<bank>_<index> equ
<raw id>` lines. Sites are named only where the id reaches a known text sink,
never by value.

---

## 7. The declaration layer

### 7.1 What declares what

Each structured data region's first line names the spec it was rendered from
(`kind` or `kind:param`): `; $46ef, 112 bytes (bytes:16)`. The source is now
edited directly as those macro rows; the retired generator and its
`data_tables.json` are at git tag `generator-final`. Counts below are the
2,751 declarations at that tag (today's source differs, e.g. 170
`sprite_template` and 262 `actor_script` regions). `data.manifest` holds the
extracted regions.

| spec | count | renders as |
|---|---|---|
| `bytes[:cols]` | 689 | `db` rows, index-commented (default 8 per row) |
| `sprite_anim` | 570 | `anim_frame` / `anim_loop` / `anim_set` / `anim_flip` (§4.4) |
| `records[:stride]` | 265 | one row per record; even stride → `dw`, odd → `db` (default 16) |
| `actor_script` | 261 | `as_*` macros (see `docs/actor_script.md`) |
| `palettes` | 160 | generated `dw` colour rows (§5.2) |
| `map_scripts` | 137 | map script rows |
| `fill` | 107 | `ds` — asserts one exact run is padding |
| `map_actors` | 86 | `map_actor` rows with `FACE_*` names |
| `text_ids` | 82 | `dw` text ids, `Text_*` where named |
| `tilemap[:width]` | 70 | `tilemap_begin`/`tilemap_row`/`tilemap_end` (§2.5) |
| `map_tree` / `map_entries` | 42 / 42 | scene structure (see `docs/story_mode.md`) |
| `mode_hooks` | 38 | minigame hook tables |
| `ram_ptrs` | 35 | `dw` resolved against RAM symbol names |
| `sprite_template` | 21 | `oam_sprite` rows (§4.1) |
| `drill_definition` | 18 | minigame drill records |
| `text_offsets` / `text_pool` | 13 / 13 | §6.2 |
| `ascii` | 12 | `db "…"` |
| `save_flag_ids` / `flag_ids` | 12 / 7 | `flag_id` rows |
| `font_glyph` | 11 | 1bpp glyph rows |
| `actor_list` | 10 | actor id lists |
| `rect_pair` / `rect_ptrs` | 9 / 1 | `{height, width, tiles, attrs}` / `{tiles, attrs}` |
| `sound_data` / `sound_index` | 8 / 2 | generated (routed out of the repo) |
| `enum` | 8 | named constants |
| `rules_pages` | 4 | page-offset lists |
| `pattern` | 3 | a repeated short pattern as one `ds` |
| `words[:n]` | 2 | numeric words, never label-resolved |
| `menu_def` | 2 | menu definitions |
| one each | | `cart_header`, `squares`, `story_locations`, `location_entries`, `minigame_configs`, `tilemap_scripts`, `gfx_ptr_table`, `lz_ptr_table`, `char_lz_ptr_table`, `mugshot_ptr_table`, `tilemap_dispatch` |

### 7.2 No ROM values in the repository

Kinds whose rows are literal ROM values (`palettes`, `sound_index`,
`sound_data`, `text_pool`) are generated into the gitignored `data/` tree at
setup by `tools/extract.py`'s `render_spec` and `INCLUDE`d. Kinds whose rows
are label arithmetic, pointer symbols or macro calls are written inline, since
rgbasm recomputes them from the layout.

### 7.3 Splittable kinds

Kinds that are runs of independent rows can be cut at any offset without
changing a byte: `bytes`, `records`, `words`, `tilemap`, `palettes`,
`sound_data`, `text_ids`, `flag_ids`, `map_actors`. A pointer into one of
these gets a label; into any other kind (bytecode, self-relative tables,
decoded headers) it stays numeric.

`fill` and `pattern` are excluded: they assert one exact run is padding, so a
label inside one means the padding stopped there. Carrying such a spec past a
cut would turn real data into `ds` runs and inline ROM content.

### 7.4 A `records:`/`bytes:` declaration over an LZ payload is a lie

If a truncated pointer target is a graphics payload, a named `INCBIN` is
already the correct rendering; `records:`/`bytes:` rows over it describe
nothing. A payload is identified **from its consumer**, not from bytes that
look like tiles:

1. it **LZ-decodes using exactly its own extent** (it is what `DecompressData`
   is given); or
2. the bank sizes it as **`(next - name) / 16`**, the tile count
   `QueueVRAMCopy` takes (§2.2), so it is a raw tile stream.

### 7.5 The structural checks

`python3 tools/check.py` checks what `make compare` cannot: that the structure
the source claims is true, not just that the bytes come back. All fourteen
pass:

| check | count | what it asserts |
|---|---|---|
| `lz` | 839 | every stream decodes inside its extent and re-encodes to a stream that decodes back |
| `lz-labels` | 839 | no symbol lands inside a compressed stream |
| `regions` | 4243 | manifest regions stay inside their bank and do not overlap |
| `sound` | 315 | every sound track decodes over exactly its extent and renders to rows that encode back |
| `traj` | 15 | every trajectory table is whole rows and renders to rows that parse back |
| `scopes` | 0 | no global label covers both actor-script bytecode and CPU code |
| `labels` | 13743 | code lives under its routine's name: no data label's scope runs into code, no table dispatches to another routine's local, no stray label splits a routine |
| `branches` | 14 | no *new* conditional branch targets the instruction after it |
| `literals` | 35616 | no ROM address is written as a number where the source moves |
| `dma` | 51 | every label handed straight to a VRAM DMA routine is 16-byte aligned |
| `gfx` | 2728 | every PNG encodes back to the blob it was decoded from |
| `tilemap` | 231 | every tilemap grid encodes back to its blob |
| `slots` | 5124 | every `ACTOR_*` slot name holds its actor wherever a script uses it |
| `reach` | 4873 | a routine is named `Unused` exactly when nothing reachable reaches it |

---

## 8. Not established

Open:

* The `$63` sentinel branch in `LoadActorObjectDef` (`$04:$4b2b`) is dead for
  all 117 entries, so the +8 palette pointer's use cannot be confirmed from
  data. It would load the object's own palette from that pointer: a
  per-object-palette feature no shipped object uses.
* The intended difference between `AdjustColorsBrightness` and
  `Unused_00_ApplyWhiteFade`, given both add toward `$1f`. The cheaper 16-bit
  form is the one left unreachable.

Settled:

* The three odd-sized `palettes` regions were over-declared: `0x63ab5` (bank
  `$18`) is 128 bytes of palettes plus an unreferenced `ret`
  (`Unused_18_StubRet3`); `0x52ea1` (bank `$14`) is four palettes plus a
  47-byte unreferenced routine that resets the firework objects on a button
  press (`Unused_14_ResetFireworkObjOnButton`); `0x618ad` (bank `$18`) is six
  palettes plus three `$00` bytes padding the next blob to `$58e0`
  (`ConfirmScreenSpritePalette1Pad`).
* Object-header bytes +2/+3 are a fixed per-family constant (§4.3) that no
  loader reads.
* The 136-byte scene-config record: only `+2`…`+5` are read. The story loader
  copies all 136 bytes and reads back the four scroll and size bytes; nothing
  reads past `+5` (the debug loader treats the first 64 bytes as palettes).
  The rest is real data (every byte varies across the 21 story records;
  `+16`…`+47` is four 8-byte entries keyed `0/2/4/6`), a leftover the shipped
  loaders no longer consume. In the 16 court records the first 80 bytes are the
  two scoreboard column blocks (§3.4).
