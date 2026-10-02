# Data formats

1.78 MB of this cartridge is data. `docs/match_engine.md`, `docs/story_mode.md`
and `docs/screens_and_ui.md` describe what the game *does* with it; this file
describes how it is **encoded** — the byte layouts a modder has to respect to
change a tile, a map, a sprite or a palette and still have the ROM boot.

Everything here is stated in the present tense of the format. Where a claim
comes from running a tool, the command and its numbers are given. Where
something is unresolved it says so, and §3.5 and §8 are nothing but
unresolved things — hedged truth is worth more here than a tidy answer.

Cross-references: `docs/bank0_notes.md` (the ROM0 helpers), `docs/ram_map.md`
(the destination buffers), `docs/screens_and_ui.md` §7 (text at the UI level),
`docs/sound_engine.md` (the one data family this file does not cover),
`docs/actor_script.md` (actor bytecode), `docs/bugs.md` (defects referenced
below).

---

## 0. Editing graphics

Every file under `data/` is named after its label in the source
(`data/bank_040/AlexSpriteFrame00.bin`; an `lz_` prefix marks a compressed
stream, `lz_DmgLockoutTilesLZ_01.bin`; a blob nothing names keeps an
address name, `d_000b.bin`). Every blob that is a whole number of 8x8 tiles — the
manifest tags them `gfx` — is extracted to a PNG beside its `.bin`: the
tiles in blob order, sixteen per row, as a four-colour indexed image with
the tile count in the file. `make` re-encodes any blob whose PNG is newer
(`tools/gfx.py encode`, then `tools/lz.py` for an `lz_*` stream), and
`make check` verifies that every PNG still encodes back to its blob. A
plain image grows its blob when the canvas is enlarged and something is
drawn past the last tile; blank padding in a partial last row is not
growth. `tools/extract.py --keep` re-extracts around edited files instead
of over them.

The copies that put a blob into VRAM follow its size where the source can
say so: a whole copy of a raw blob is `ld c, (Next - Blob) / 16`, and a
whole copy of a decompressed stream is `ld c, Blob_SIZE / 16`, with
`Blob_SIZE` the decoded length in a `data/<bank>/lz_Blob.inc` that `make`
derives from the `.bin` (`tools/lz.py --size-inc`) and the source
INCLUDEs after the INCBIN, or in the holder (`src/bank_XXX.asm`) of the
bank that does the copy when that is another bank. A partial copy keeps its literal count with a
comment naming the blob and the tiles it takes. The copies that remain
plain literals decode through a helper the emitter cannot follow.

A blob that is a run of sprite frames carries a **layout** (`gfx:2x2`,
`gfx:3x4+3`, `gfx:4x4+4` in the manifest; `layout=` in the PNG) so each
frame is drawn as it appears on screen. `WxH` is one frame as W columns of
H tiles, column-major, which is the order the 8x16-object queues consume
tiles in (§4.2); `+S` is S extra tiles per frame drawn as a row under it.
Frames go left to right, tiles left over after the last whole frame follow
as a plain row. The layout is a fixed permutation of the blob's tiles, so
encoding back is exact.

| layout | blobs | what a frame is |
|---|---|---|
| `2x2` | the 570 walk-sprite `_GfxNN` blobs (banks `$6a`, `$6f`, `$70`-`$77`) | one 16x16 facing, two 8x16 objects (`QueueSprite16`); a 256-byte blob is the four facings side by side |
| `3x4+3` | the 240-byte character frames of banks `$40`-`$5d`, and each bank's `SpriteFramesUnused` run | the 24x32 body as three 4-tile columns (`QueueSprite24x32`, `$00:$2c2b`), then the three standing-shadow tiles that replace each column's bottom tile in VRAM when `wStandingShadowsEnabled` is set (`$00:$2ee8`) |
| `4x4+4` | the 60 320-byte character frames (the `01 10` per-slot OAM records, §4.3) | the same at 32x32 with four columns and four shadow tiles |

Every other graphics blob is plain: tiles in blob order, sixteen per row.
The sprite templates of §4.1 place tiles from arbitrary bases, so a blob
drawn only through `QueueSpriteTemplate` stays plain and the template says
how the game arranges it.

## 1. The LZ format

### 1.1 Stream shape

`DecompressData` (`$00:$1797`, `src/home/decompress_00.asm`) is the only
decompressor in the ROM. It takes `hl` = source, `de` = destination, and
returns `hl` = the number of bytes written.

A stream is a sequence of **groups**. Each group is one **control byte**
followed by the items its flags introduce. The control byte's flags are
consumed **LSB first**, one per item:

| flag | item | bytes read |
|---|---|---|
| `1` | literal — copy one byte to the output | 1 |
| `0` | match — copy a run from earlier in the output | 2 |

The routine's structure spells this out. `.nextControlByte` (`$179b`) does
`ld a, [hl+]` / `scf` / `rra` / `ld c, a`: it loads the control byte and shifts
it right one place, pushing a **set sentinel bit into bit 7** and dropping
flag 0 straight into the carry, which the `jr nc, .match` at `$179f` tests
immediately. `c` then holds the remaining seven flags below the sentinel.

The other seven positions are **unrolled**: `.nextFlag` (`$17a4`) and its six
copies each do `srl c` / `jr z, .nextControlByte` / `jr nc, .match`, then the
literal path. `srl c` moves the next flag into the carry; when the sentinel
itself has been shifted out `c` reaches zero and `jr z` fetches a new control
byte. That is how a group ends without a counter — and it is load-bearing
rather than decorative, because `.matchTail` re-enters the ladder at
`.nextFlag` (§1.2) rather than at the position it left, so `c` is the only
record of how many flags remain. A group of eight straight literals never
reaches the zero test; it falls out of the last position into the
unconditional `jr .nextControlByte` at `$17e3`.

### 1.2 The match token

`.match` (`$17f3`) reads two bytes, `lo` then `hi`:

```
lo, hi:
  distance  = 0x800 - (((hi >> 5) << 8) | lo)      ; 3 high bits of hi + all of lo
  length    = (hi & 0x1f) + 3
  lo == 0 && hi == 0  ->  end of stream
```

The source computes the back-pointer as `hl = de + ($f800 | (hi rotated left 3,
low 3 bits) << 8 | lo)` — `rlca` three times then `or $f8` (`$17fc`-`$1801`),
i.e. a sign-extended negative offset added to the write pointer. The window is
therefore **2 KiB** and a copy may overlap the write position, which is how the
encoder writes runs.

The length is not a counter loop. `and $1f` (`$1804`) extracts the low 5 bits
and then the routine **consumes that value one bit at a time**, falling through
a ladder of fixed-size copy blocks:

| label | addr | copies if the bit is set |
|---|---|---|
| (`.match` body) | `$1809` | 1 byte |
| `.match2` | `$1812` | 2 bytes |
| `.match4` | `$181e` | 4 bytes |
| `.match8` | `$1830` | 8 bytes |
| `.match16` | `$184e` | 16 bytes |
| `.matchTail` | `$187e` | 3 bytes, unconditionally |

`srl b` at each rung tests the next bit and `jr nc` skips that rung's block;
`jr z, .matchTail` short-circuits once no bits remain. The unconditional 3-byte
tail is the `+ 3` in the length formula — the minimum match is 3 and the field
encodes `length - 3` in 5 bits, so lengths run **3 to 34**.

`.matchTail` ends with `pop hl` / `jp .nextFlag`: the source pointer was pushed
at `$17f6` before `hl` was repurposed as the back-pointer, so a match always
returns to the *middle* of the unrolled flag ladder rather than to its start.

### 1.3 Terminator and the pad byte

The `lo = hi = 0` pair is the terminator (`or b` / `jr z, .done`, `$17f8`). The
original encoder always writes **three** zero bytes at the end. When the
terminator starts a fresh group the decoder consumes all three (the `$00`
control byte plus the `$0000` reference); mid-group it consumes only the
`$0000` and the third byte is never read.

`tools/lz.py`'s `decompress()` counts that authored-but-unread byte so extents
match the encoder's output. Over the whole corpus, **697 mid-group streams
all pad with `$00`, 142 fresh-group streams have no pad.**

Because `d = 0x800 - distance`, a distance of exactly 2048 with the minimum
length encodes as `$0000` — indistinguishable from the terminator. `lz.py`'s
`MAX_DIST = 0x7FF` caps the encoder at 2047 so that can never happen.

### 1.4 Entry points

| routine | addr | inputs |
|---|---|---|
| `DecompressData` | `$00:$1797` | `hl` source, `de` dest → `hl` = bytes written |
| `DecompressDataFromBank` | `$00:$0234` | `h` = ROM bank, `l` = **byte offset into that bank's `$4000` pointer table**, `de` dest |

`DecompressDataFromBank` (`src/home/vectors_00.asm`) banks in `h`, then does
`ld h, $40` / `ld a, [hl+]` / `ld h, [hl]` / `ld l, a` — it dereferences one
entry of the bank's word table at `$4000` and calls `DecompressData` on the
result. So a **slot word** `bbss` means "bank `$bb`, entry `ss/2` of that
bank's `$4000` directory". This is the same encoding `dslot` emits
(`include/macros.inc:33`) and the same one `CopyDataFromBank` (`$00:$021a`)
uses for uncompressed payloads.

282 `call` sites reach `DecompressData` or `DecompressDataFromBank`
(counted over `src/`).

### 1.5 The corpus, measured

`data.manifest` declares **839** LZ streams (`grep -c /lz_ data.manifest`).
Running `python3 tools/check.py` at HEAD:

```
lz           839 checked, 0 failed
lz-labels    839 checked, 0 failed
```

`check_lz` (`tools/check.py:64`) requires each stream to decode using *exactly*
its declared extent and to survive a re-encode round trip, so the format above
is verified in both directions over the whole ROM, not inferred from a sample.

Decompressing all 839 (via `tools/lz.py`'s `decompress`):

* **315,831 compressed bytes → 804,924 decompressed** — 39.2%.
* **803 of the 839 decompress to a multiple of 16 bytes**: the streams are
  sized in whole tiles or whole map planes. The 36 that are not are small
  tilemap/attrmap rect streams in banks `$1a`-`$1e` (the
  `CharDataScreen*` / `CharDataConfirmScreen*` streams and the
  `Results*Tilemap_1e` / `ResultsPlayerPanelAttrmap_1e` streams), 9 to 90
  bytes each.
* Sizes: min 9, max 4096. The mode table is
  1024 (×202), 256 (×109), 64 (×105), 4096 (×84), 320 (×71), 144 (×44),
  32 (×40), 240 (×40), 576 (×13), 96 (×7).

Two individual streams, decoded with `python3 tools/lz.py baserom.gbc <off>`:

```
stream at 0x17c060: 2037 bytes compressed, 3024 decompressed   ; MinigameCourtTiles  ($5f:$4060)
stream at 0x17c855:  625 bytes compressed, 1024 decompressed   ; MinigameCourtTilemap ($5f:$4855)
```

### 1.6 Editing a stream

`lz.py -c infile outfile` encodes. The encoder is greedy longest-match LZ77
over the 2 KiB window and verifies its own output decodes back before writing.
A re-encoded stream **does not have to match the original byte for byte** —
only to decode to the same data — so an edit that compresses differently is
fine provided the bank still has room. Streams live at
`data/<bank_XXX>/lz_<Label>.bin`, which is gitignored and extracted by
`setup.sh` from the manifest.

`check.py`'s `lz-labels` check exists because a curated label placed *inside* a
stream silently truncates it — that mistake once cut two streams by 29 and 160
bytes. Never name an offset inside an `lz_*` extent.

---

## 2. Tiles, tilemaps, and reaching VRAM

### 2.1 The tile

A tile is the standard Game Boy **2bpp, 16 bytes**: eight rows of two bytes,
low bitplane first, bit 7 = leftmost pixel. `tools/gfxdump.py:38` (in `tiles_image`, line 25) renders it
directly:

```python
c = (lo >> (7 - x) & 1) | ((hi >> (7 - x) & 1) << 1)
```

`TILE_SIZE equ 16` comes from RGBDS `include/hardware.inc:981`; the
disassembly uses it in address arithmetic (e.g. `wDecompBuffer + 1 * TILE_SIZE`
at `$0a:$58f9`) rather than writing bare offsets.

### 2.2 `QueueVRAMCopy` counts tiles, not bytes

`QueueVRAMCopy` (`$00:$0480`, `src/home/memory_00.asm`) is **the only way
anything reaches VRAM**: 610 `call` sites, and not one direct
`ld [$8xxx], a` anywhere in the ROM (both counts re-derived by grep over
`src/`).

```
hl = source
de = destination (see §2.3)
c  = length in 16-byte blocks
```

`c` is a **tile count**. `StartVRAMDMAFromHL` (`$00:$18eb`) does `ld a, c` /
`dec a` and hands `a` to the GDMA length register, which is the hardware's
`(n/16) - 1` encoding — so `c = $80` moves 128 tiles = 2048 bytes. Getting this
wrong by a factor of 16 is the single easiest mistake to make when adding a
copy.

With the LCD off the transfer runs immediately as a GDMA. With it on, the
request goes into `wVRAMCopyQueue` for `ProcessVRAMCopyQueues` to drain in
VBlank. There are **ten slots**, probed in order at `wVRAMCopyQueue + $a0`,
`+$a8`, … `+$e8` (`$049c`-`$04d2`). On overflow it sets `hVRAMQueueDirty` and,
in debug step mode only, plays a sound — an overrun is audible but not
otherwise reported. Each slot records the ROM bank, WRAM bank, source, VRAM
bank and destination, so a queued copy is bank-safe.

### 2.3 The VRAM bank rides in bit 13 of the destination

```asm
def VRAM_BANK1 equ $2000        ; include/constants.inc:9
```

`QueueVRAMCopy` does `bit 5, d` to select `rVBK` and `res 5, d` to recover the
real address (`$0486`-`$048d`). So a destination of `$b800` means `$9800` in
VRAM bank 1, and the disassembly writes it as `vBGMap0 + VRAM_BANK1` rather than
hiding the bank inside a literal (`include/constants.inc`). Every VRAM
address one of the VRAM consumers (`QueueVRAMCopy`,
`LoadCompressedTileBlock`, `DecompressData`, the tile loaders) takes is
written that way: `vTiles0`, `vTiles1`, `vTiles2` for the three 128-tile
blocks plus `$NN * TILE_SIZE`, `vBGMap0` / `vBGMap1` for the maps plus
`row * TILEMAP_WIDTH + col` -- 758 sites. Names go only where such a consumer
takes the word, because `$8000` is also a sign bit and `$932f` a coordinate
pair. The 91 words in `$8000`-`$9fff` that stay literal mix those with VRAM
addresses handed to routines outside that list: 37 carry `+ VRAM_BANK1`
(`InitNumberSpriteGfx`'s destinations, for one), and others are map bases
added to an offset (`ld de, $9800` / `add hl, de` at `$00:$223a`).

### 2.4 The two map planes

A CGB background cell needs two bytes in two different VRAM banks at the same
address: the **tile index** in bank 0 and the **attribute byte** (palette,
tile-VRAM-bank, flips, priority) in bank 1. The game keeps them as two separate
WRAM planes and blits them separately.

`CopyScrolledSceneTilemapToVram` (`$0a:$5c29`, `src/engine/story/scene2_0a.asm`) is the
clearest example. Its attribute half (`$5c6b`-`$5cb6`) sets `rVBK = 1`, walks
`wMapBuffer64` (4096 bytes, WRAM bank `$02`) and writes `$15` rows × `$17`
columns — 21 × 23 cells — into `$9800`. Both source and destination wrap
independently:

* source stride `$40` per row and `and $3f` on the low byte → a **64-wide**
  map;
* destination stride `$20` per row and `and $1f` → the **32-wide** hardware
  tilemap (`TILEMAP_WIDTH equ 32`, `include/hardware.inc:975`).

The tile half that follows does the same with `rVBK = 0`. So: *64×64 scrolling
map in WRAM, 32×32 window into it in VRAM, two planes, one blit each.*

Court and menu screens use the flat 32×32 form instead — `wShadowTilemap`
(1024 bytes, WRAM bank `$03`) and `wScreenAttrmap` (1024 bytes, WRAM bank
`$02`), each exactly `TILEMAP_WIDTH * 32`.

### 2.5 The `tilemap` spec

Screen layouts are written as rows of cells in two places. The 213
extracted blobs `data.manifest` tags `tilemap:W` (all `lz_*`
streams, decompressed first) get a `.tilemap` text grid beside their `.bin`
(`tools/tilemap.py`); the Makefile encodes an edited grid back into the blob
and `make check` (`tilemap`) round-trips every one. The 70 small layouts
written in the source itself carry a `(tilemap:W)` comment on their first
line. Both use the same lines:

```asm
	tilemap_begin <width>, <height>
	tilemap_row $.., ... ; row 0
	...
	tilemap_end
```

The macros assert the geometry at assembly time — `tilemap_row` checks the
byte count against the declared width and `tilemap_end` checks both the row
count and `@ - _TM_START == _TM_W * _TM_H` (`include/macros.inc:1012-1028`).
A mis-declared width therefore fails the build rather than silently
reflowing. A trailing partial row stays literal `db`.

---

## 3. The scene slot table

### 3.1 Geometry

`SceneGfxSlotTable` (`$0a:$59d9`, `src/engine/story/scene_0a.asm`) is **592 bytes =
37 records × 8 slot words**. Each word is a `dslot` bank/offset pair (§1.4).

The table is a dense enumeration, which is independent confirmation of the
16-byte stride. Reading the raw words out of `baserom.gbc`, record 0 is
bank `$5f` entries `$00`-`$0e`, record 1 is `$5f` entries `$10`-`$1e`, record 2
is `$60` entries `$00`-`$0e`, and so on without a gap through record 36 =
bank `$69` entries `$20`-`$2e`. The nine banks `$5f`-`$69` supply 8, 4×8, 4×8,
4×8, 3×8, 4×8, 3×8, 3×8 and 3×8 entries respectively. The bytes immediately
after record 36 are `CopyScrolledSceneTilemapToVram`'s prologue, so 592 is the
whole table.

### 3.2 Slot roles under the story loader

`LoadStorySceneGraphics` (`$0a:$585d`, `src/engine/story/scene_0a.asm`) takes the scene
id in `a`, computes `hl = SceneGfxSlotTable + 16*a` with four `add hl, hl`, and
**pushes slots 0-6 in order** (`$586f`-`$5891`), reads slot 7 inline, then pops
in reverse. The pop order names the slots — this is derivation, not assumption,
because four of the pops land on payloads already named `*Palettes`,
`*Tilemap`, `*Attrmap` and `*SceneConfig` from other evidence:

| slot | destination | how | addr |
|---|---|---|---|
| 0 | `wStorySceneRecord` | raw copy, `bc = $0088` (136 bytes) | `$590f` |
| 1 | `wDecompBuffer` → `LoadPaletteShadow` | raw copy, `bc = $0040` | `$58f6` |
| 2 | `wShadowTilemap` (WRAM `$03`) | LZ | `$58e6` |
| 3 | `wScreenAttrmap` (WRAM `$02`) | LZ | `$58d9` |
| 4 | `wCollisionMap` (WRAM `$06`) | LZ | `$58cc` |
| 5 | `wBehaviorMap` (WRAM `$06`) | LZ | `$58c5` |
| 6 | — | **popped and discarded** | `$58bd` |
| 7 | `wDecompBuffer` → VRAM | LZ, then `QueueVRAMCopy` | `$589e` |

Slot 6 is a fossil: `$58bd` pops it into `hl` and `$58be` sets
`de = wStorySceneUnusedBuffer`, but the next two instructions overwrite both
before any call. Nothing is ever loaded from it.

Slot 7's tiles go to `$9000 + VRAM_BANK1`, `c = $80` (128 tiles), and
`wTextTileBuffer` is pushed to `$8800 + VRAM_BANK1`, also 128 tiles
(`$58a4`-`$58b4`) — together the 256-tile block `$8800`-`$97ff` of VRAM bank 1.

Slot 1's 64 bytes become **BG palettes 2-7**: `hl = wDecompBuffer + 1*TILE_SIZE`
(byte 16) with `de = $0206`, i.e. index 2, count 6 (`$58ff`). The first two
palettes of the block are skipped, which is what reserves BG 0/1 for the text
window.

Slot 0's first four useful fields are read straight back out at `$5912`-`$5922`:
`wStorySceneRecord + 2` → `wMapScrollMinX`, `+3` → `wMapScrollMinY`,
`+4` → `wMapWidthTiles`, `+5` → `wMapHeightTiles`.

### 3.3 The two record shapes, measured

Decompressing every slot of every record (script over `baserom.gbc` using
`tools/lz.py`) splits the 37 records cleanly in two:

| records | slot 2 / slot 3 | slot 4 / slot 5 | shape |
|---|---|---|---|
| **0-15** (16) | 1024 / 1024 | *not LZ streams* | court / backdrop |
| **16-36** (21) | 4096 / 4096 | 1024 / 1024 | walkable story location |

The 21 story records have 64×64 tile and attribute planes (4096 = 64×64) and
**collision and behaviour maps of exactly 1024 bytes each** — the size of
`wCollisionMap` (`$d000`) and `wBehaviorMap` (`$d400`), which
`GetCollisionMapCellAddr` (`$0a:$5edd`) and `GetBehaviorMapCellAddr`
(`$0a:$5f31`) index. Nothing else in a record is 1024 bytes, so the pairing is
unambiguous.

`GetCollisionMapCellAddr` indexes a **32 × 32 grid of 2 × 2-tile cells**: it
rounds `d` and `e` down to even values (`sra`/`sla` pairs), builds
`hl = e * 16` via four `add hl, hl` on the *rounded* `e`, adds `d >> 1`, and
adds `wCollisionMap`. Because `e` is even, `e * 16` is `(e >> 1) * 32` — a
32-byte row, not the 16-byte row a first reading of the shifts suggests.
Checked against a live map on 2026-09-11: the 1024 bytes of `wCollisionMap`
in the Tournament Courtyard (a 34 × 50-tile scene), read from WRAM bank 6
and drawn 32 wide, are the courtyard — the walled plaza, the fountain, the
gate corridor to the north, the exits — with the player's cell
(`X / 2`, `Y / 2`) in open space where the sprite stands; drawn 16 wide they
are noise.

### 3.4 The same slots mean something else to the court loader

`LoadCourtSceneGraphics` (`$0a:$62f8`, `src/engine/story/scene4_0a.asm`) is the loader
for the court backdrops. It uses the **same 16-byte stride** but skips slot 0
(`inc hl` twice at `$630a`), pushes slots 1-5, skips slot 6 (`inc hl` twice at
`$6325`) and reads slot 7 inline. Its pop order gives slots 4 and 5 completely
different roles:

| slot | destination | how | addr |
|---|---|---|---|
| 1 | `wScreenAttrmap` (as scratch) → palettes | raw copy, `bc = $0040` | `$6381` |
| 2 | `wCourtTilemapSaved` | LZ | `$6377` |
| 3 | `wCourtAttrmapSaved` | LZ | `$6370` |
| 4 | `wScoreboardColumnTiles` | raw copy, `bc = $0028` (40 bytes) | `$6363` |
| 5 | `wScoreboardColumnAttrs` | raw copy, `bc = $0028` | `$6359` |
| 6 | — | skipped | `$6325` |
| 7 | `wDecompBuffer` → VRAM | LZ | `$6333` |

**So "slot 4 = collision map" is a property of the loader, not of the table.**
For the 16 court-shaped records slot 4 is 40 bytes of scoreboard column tiles,
and the reason it aliases slot 0 is that those 40 bytes are the *start* of the
same 136-byte config record slot 0 points at. Measured over the 16 records:
slot 4's target equals slot 0's target in **all 16**, and slot 5's target is
slot 0 + 40 in **all 16**. Slot 6, where it is not the neighbouring record's
slot 0 or slot 1, is slot 0 + 80.

(`docs/history.md:9338-9346` describes the Clubhouse and Courtyard records
specifically, because those two were the ones *renamed* in that pass; the other
14 already carried `*SceneConfig` names. All 16 share the shape.)

The court palette load has a quirk worth knowing before editing a court's
64-byte palette block. `$638a` loads 6 palettes at index 2 from byte 16
(BG 2-7, as in §3.2), then `$6393` loads **1 palette at index `$0b`** —
OBJ palette 3 — from `wScreenAttrmap + 1*TILEMAP_WIDTH + 8`, i.e. byte 40.
Byte 40 is inside the range just consumed as BG palette 5. The same eight bytes
are therefore both BG palette 5 and OBJ palette 3; changing one changes the
other.

### 3.5 The stride-18 readers (a debug-path bug)

`Unused_0a_LoadSceneGraphicsDirect` (`$0a:$5d2a`, `src/engine/story/scene2_0a.asm`) indexes the
same table with a stride of **18**. The arithmetic is not ambiguous: `hl = a`,
`add hl, hl` → `2a` saved in `de`, three more `add hl, hl` → `16a`,
`add hl, de` → **`18a`** (`$5d31`-`$5d37`). It then does `inc hl` twice and
reads nine words per record.

This cannot be right for a 592-byte table: 592 is `37 * 16` and is not a
multiple of 18, and the record contents (§3.1) are a dense 8-per-scene
enumeration. Its sibling `GetSceneSlotPtr` twenty bytes earlier
(`$0a:$5d0c`) does the same job correctly with four `add hl, hl` and `+ 2*slot`.

Two more consumers agree with the 18: `Unused_0a_InitSceneViewer` (`$0a:$601c`) and
`Unused_0a_InitSceneViewerDefault` (`$0a:$6076`) both count words to the first zero word
and divide by **9** (`ld de, $0009` at `$603e` and `$608e`). Scanning
`baserom.gbc` from the table base, the first all-zero word is at word index
**932** — 1272 bytes past the end of the table, inside the code that follows —
so that count is meaningless either way, and `Unused_0a_InitSceneViewerDefault` uses
`inc c` rather than `inc bc`, leaving `b = $ff` in the dividend. The correct
scene count, 37, is hardcoded elsewhere as `ld a, $25` (`$0a:$5934`).

**This is already written up as a bug** — [bugs.md, "The scene viewer
indexes the slot table with the wrong stride"](bugs.md#the-scene-viewer-indexes-the-slot-table-with-the-wrong-stride)
and `docs/history.md:9776-9796` — with the finding that the only caller of
`Unused_0a_LoadSceneGraphicsDirect` is `Unused_0a_LoadAndDisplayScene`, whose four callers are all
the scene viewer hanging off the debug menu, which nothing in the retail build
opens. Flagging it here rather than restating it: **if you write a new consumer
of `SceneGfxSlotTable`, use stride 16, and do not take the debug path's shape
as a second interpretation of the table.**

One more difference between the two paths, which supports "bug" over "second
interpretation": `Unused_0a_LoadSceneGraphicsDirect` loads palettes as *7 palettes at
index 1 starting at byte 8* (`ld de, $0107`, `$5dd7`) where both working
loaders use *6 at index 2 starting at byte 16*. Two loaders that disagree about
the same 64-byte block cannot both be reading it correctly.

---

## 4. Sprites

### 4.1 Sprite templates

A **sprite template** is a list of 4-byte OAM rows terminated by a single
`$80` byte:

```asm
	oam_sprite dy, dx, tile, attr      ; include/macros.inc:1078
	...
	oam_sprite_end                     ; $80
```

`QueueSpriteTemplate` (`$00:$1e9d`, `src/home/fade_00.asm`) takes
`hl` = template and a base in `e` (Y), `d` (X), `c` (tile), `b` (attr), and for
each row emits `byte0 + e`, `byte1 + d`, `byte2 + c`, `byte3 + b` into the
sprite buffer — hardware OAM order, all four adds mod 256. The terminator is
tested on the **dy** byte only (`cp $80` at `$1eba`), so `$80` is the one dy
value a template can never use. The copy stops at 160 bytes / 40 entries
(`cp $a0`, `$1eb5`).

Offsets are unsigned bytes added mod 256, not sign-extended, so `$fc` is "4 to
the left" purely by wraparound. `QueueSpriteTemplate` applies **no** bias of
its own; `QueueSprite` (`$00:$1f51`) adds `+$0c` to Y and `+$04` to X itself.

When `bit 5` of the base attr is set (OAM X-flip), a second loop runs
(`$1ee0`-`$1f05`): X becomes `base_x + (8 - dx)` (`cpl` / `add $09`), and the
attribute byte is combined with **`or`** rather than `add` (`$1f01`).

170 regions are sprite templates, written in the source as `oam_sprite`
rows ending in `oam_sprite_end`. `StandingShadowOamTemplate` (`$08:$6301`)
is the one reached by `jp QueueSpriteTemplate` (`DrawStandingShadowSlot`,
`$08:$6534`); every other template is reached by `call`.

### 4.2 The sprite queue

Two 160-byte shadow-OAM pages; `wSpriteBufferPage` holds the high byte of the
page being built and `hSpriteQueueIndex` the write offset, capped at `$a0`.
Every routine re-checks the cap and silently drops the sprite on overflow.

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

Overworld and on-court characters are described by a **16-byte object header**.
`ObjectIdList_04` (`$04:$4f75`) maps 117 object ids to slot words in the §1.4
encoding, which `CopyDataFromBank` resolves; a `$0000` row ends it, and
`GetObjectDefCount` counts up to it. Each row is `object_id NAME, DataPtr_*`,
which defines `OBJ_NAME` as the row's index:

| ids | objects | names |
|---|---|---|
| `$00`-`$1d` | the character banks `$40`-`$5d`, one match sprite each | `OBJ_MATCH_ALEX` ... `OBJ_MATCH_BALL_MACHINE` |
| `$1e`-`$74` | the walk-sprite banks `$6f`-`$77` | `OBJ_WALK_<bank>_<slot>`, or the character's name where the game says who it is |

The game names 31 of the walk sprites itself: `CharObjectIdTable`
(`$04:$4c29`, read by `Unused_04_GetCharObjectId`) gives each `CHAR_*` id its
overworld object, so `OBJ_ALEX`, `OBJ_MARIO`, `OBJ_YOSHI` and the rest are
those rows (the two unused roster slots share `OBJ_BALLOON_ELLIPSIS`). Ids
`$56`-`$59` are `OBJ_ALEX_B`, `OBJ_NINA_B`, `OBJ_HARRY_B`, `OBJ_KATE_B`: the
same four drawings with fewer frames, which
`LoadCourtPlayerPartnerObjDefs_14` and the ending scenes load as `base + gender`, so each male/female pair sits
side by side. Twenty-two more are named from their graphics (2026-09-27): the eight
speech balloons (`OBJ_BALLOON_EXCLAIM`, `_QUESTION`, `_ANGRY`, `_ELLIPSIS`,
`_SCRIBBLE`, `_MUSIC`, `_SHOCK`, `_SWEAT` -- the unused roster slots' entry in
`CharObjectIdTable` is the ellipsis), `OBJ_RACKET`, `OBJ_TROPHY` (the one the
awards ceremony hands over by swapping object definitions), `OBJ_TOAD`,
`OBJ_BOB_OMB`, `OBJ_BOO` (Peach's Castle), `OBJ_CAT` (the dorm room),
`OBJ_RACKET_STUDENT`, the Training Gym's six exercisers
(`OBJ_WEIGHTLIFTER_A/B`, `OBJ_SITUPS_A/B`, `OBJ_JUMPING_JACKS_A/B`) and
`OBJ_INVISIBLE`, whose graphics are all zero (the Tournament Courtyard's
talk targets). A single-facing object (header byte 1 = 1) uses only the
first 16x16 of each frame blob. The remaining 31 (`OBJ_WALK_<bank>_<slot>`)
are the anonymous students and staff of `docs/story_mode.md`. Bank `$6a`
holds five more walk sprites no object id reaches.

`LoadActorObjectDef` (`$04:$4ac6`) copies the header to `wActorObjDef` and
expands it into the actor struct; `SetupCharSpriteFromObjectDef` (`$04:$4b68`)
does the on-court equivalent and its destination field names identify the
words:

| off | actor field | char symbol | meaning |
|---|---|---|---|
| +0 | +$37 | `wCharSpriteAttr` / `wCharGfxBank` | OAM attribute / CGB OBJ palette. `$63` is a sentinel (`cp $63` at `$04:$4b2b`): `LoadActorObjectDef` then stores attr `$02` and loads the 8-byte palette at +8 into OBJ palette 2 via `LoadPalettesMasterOnly` (`$00:$05e1`); no object in the table uses it |
| +1 | +$35 | — | **facing count**. `UpdateActorFacingFromHeading` (`$04:$5673`, `$5687`) forces facing 0 when this is 1 |
| +2,+3 | — | — | not read by either loader |
| +4,+5 | +$24 | `wCharFrameTablePtr` | frame-pointer array |
| +6,+7 | +$28 | `wCharAnimTablePtr` | **animation-script pointer table** |
| +8,+9 | — | — | palette pointer, only when byte 0 == `$63` |
| +10,+11 | +$38 | `wCharShadowTablePtr` | per-frame 4-byte placement/upload records |

Frames are 64 bytes per facing; a 4-facing object's frame blob is 256 bytes.
`QueueActorFrameTileCopy` (`$04:$56c3`) indexes the frame table by `frame * 2`,
then adds the `FACE_*` value (`$00`/`$40`/`$80`/`$c0`,
`include/constants.inc`) as a **byte offset inside the frame**, and uploads
`c = $04` tiles → a 16×16 metasprite drawn as two 8×16 objects.

The +6 word is what `SetActorAnimation` (`$04:$4bbe`, body at `$4bde`) and
`SetCharAnimation` (`$08:$69ea`, body at `$69fc`) index by `animation id * 2`
to reach the animation **script** pointer, and the walk-sprite banks name it
that way: `WalkSprite_<bank>_<slot>_AnimPtrs` (e.g.
`WalkSprite_6f_00_AnimPtrs`) and the scripts it points at `..._AnimNN`,
rendered as §4.4 `anim_*` macros. The header's first row is commented
`OAM attr, facing count, unread, unread`.

### 4.4 Animation scripts

Two-byte entries. **Low byte** is a frame index or a command; **high byte** is
its operand.

| entry | macro | meaning |
|---|---|---|
| `nn dd` (`nn < $f0`) | `anim_frame nn, dd` | show frame `nn` for `dd` ticks |
| `ff dd` | `anim_loop dd` | restart at script base + `dd` |
| `fe aa` | `anim_set aa` | switch to animation `aa` |
| `fb mm` | `anim_flip mm` | `attr = (attr & $0f) ^ mm` — **bank `$08` only** |
| `fd` (and any other `$f0`-`$fd`) | `anim_hold $fd` | hold the current frame forever; **one byte** |

The macros are `include/macros.inc:644-666`, whose own comment already records
the last row: "bank `$04` treats any unrecognised `$f0`-`$fd` command as 'hold
this frame'." The interpreters write `$ff` to the delay field and never advance
the script pointer (`$04:$55f3`, `$08:$77b6`).

`anim_flip`'s comment says "XOR the sprite's flip bits with `mm`", which is
loose: the code is `and $0f` *then* `xor d`, so it clears bits 4-7 first and
`$fb mm` **replaces** the high nibble. With the operands that actually occur
(`$20`, `$00`) the difference is invisible.

Every script is written with these macros (570 character-bank scripts;
635 walk-sprite scripts in banks `$6a`, `$6f`, `$70`-`$77`), and 34 of them
end on a byte the macros cannot spell, which is written as a commented `db`:

- **An unread hold operand.** `SeanSpriteAnim04` (`$47:$7f67`) and six
  walk-sprite scripts were authored as byte pairs and end `$fd, $00`. The
  hold is one byte to both interpreters, so the `$00` is never read; it
  renders as `db $00 ; never read: the hold above ends the script`.
- **A loop whose operand is the next script.** The five-byte
  `03 14 04 1e ff` script that 27 walk-sprite objects repeat ends on a bare
  loop command; the interpreter reads its operand from the first byte of the
  script that follows, always `$00` (a frame-0 entry), so the loop restarts
  at +0. The byte belongs to the next script's label, so the command
  renders as `db $ff ; anim_loop whose operand is the next script's first
  byte ($00)`.

### 4.5 The two interpreters

| | `AdvanceActorAnimation` | `StepCharAnimation` |
|---|---|---|
| addr | **`$04:$55c1`** (`src/engine/story/actor4_04.asm`) | **`$08:$7791`** (`src/engine/match/char6_08.asm`) |
| scope | overworld actors — struct in `bc`, WRAM bank `$04` | on-court characters — fixed `$df00` struct |
| far read | `FarReadWord`, bank from actor `+$22` | `FarReadWordDI`, bank from `wCharObjectBank` |
| `$fb` | **not implemented** (falls into "hold") | implemented (`$08:$77b2`) |
| delay tick | `[+$2f] -= [+$18]` (or `[+$19]` when `bit 7,[+$05]`), clamped — a per-actor animation *speed* | plain `dec wCharAnimDelay`, 1 per frame |
| frame change | stores to `+$33`, sets bit 6 of `+$30` | stores to `wCharAnimFrame`, sets bit 6 of `wCharSpriteDirty` |

The frame is the **low** byte: `ld a, e` / `cp $f0`, then `ld a, d` /
`ld [wCharAnimDelay], a`.

The character banks `$40`-`$5d` carry a third array, `*SpriteOam` (e.g.
`AlexSpriteOam`, 580 bytes = 145 records × 4). It is read at
`$00:$2e7e`-`$2e8a` as `{x offset, y offset, size flag, tile count}` per frame;
`DrawCharSprite` (`$08:$650a`) dispatches on the size flag to
`QueueSprite24x32` (flag 0) or `QueueSprite32x32`. Despite the `*SpriteOam`
name, these are per-frame placement records, not OAM rows.

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

Three independent confirmations: `tools/extract.py:250` (`w & 0x1F`,
`(w >> 5) & 0x1F`, `(w >> 10) & 0x1F`), `tools/gfxdump.py:43` `pal_image()`,
and the game's own `SplitColorComponents` / `CombineColorComponents`
(`$00:$1c6a` / `$00:$1c83`), which are exact inverses.

A palette is 4 colours = 8 bytes. A full set is 8 palettes = **64 bytes**.

### 5.2 The `palettes` spec

157 regions are declared `palettes`. The values are **not committed**: the
source holds an `INCLUDE "data/bank_XXX/<Label>.asm"` line and
`render_palettes` (`tools/extract.py`) generates the file at setup, one
`palette` macro per palette: four colours as 5-bit `r,g,b` components,
which the macro (`include/macros.inc`) packs into the BGR555 words, with
the decoded `#rrggbb` in a comment. So editing a colour is editing the
component that means it. The nine palettes in the ROM whose words set bit
15 (five files in banks `$17`, `$1c`, `$28` and `$39`) cannot be spelled by
the macro and stay `dw`.

The row stride is fixed at 8 (`render_palettes`), so an over-running region
cannot render as 5-byte palettes.

Sizes across the 157 regions (7,864 bytes): 86 are the full 64-byte set, 28 are
a single palette, 4 are 32-byte half-sets, 6 are 128 bytes (a full BG+OBJ pair,
matching `wMasterPalettes`), and a scatter in between -- every one a whole
number of 8-byte palettes, so the raw-`db` tail branch of `render_palettes`
never fires.

### 5.3 The live/master pair

All three buffers live in fixed WRAM (bank-independent `$c000`-`$cfff`):

| symbol | addr | size | role |
|---|---|---|---|
| `wBGPalettes` | `$c100` | 64 | live BG, uploaded in VBlank |
| `wOBJPalettes` | `$c140` | 64 | live OBJ |
| `wMasterPalettes` | `$c200` | 128 | master copy of both; fades scale this into the live pair |
| `hPaletteDirtyFlags` | `$ff9d` | 1 | bit 0 = BG dirty, bit 1 = OBJ dirty |
| `hFadedOut` | `$ffbc` | 1 | |

`LoadPalettesImmediate` (`$00:$05b5`, `src/home/memory_00.asm`) takes
`d` = palette index 0-15, `e` = palette count, `hl` = source, and writes each
colour word to **both** planes in one pass — `ld [de], a` / `inc d` /
`ld [de], a` / `dec d`, with `d` starting at `$c1` (`$05bf`-`$05c9`). The index
space is flat: 0-7 = BG (`$c100`), 8-15 = OBJ (`$c140`), and the master mirrors
it at `$c2xx` with the same low byte. Dirty flags are then set from `bit 3, d`
(index ≥ 8 skips the BG flag) and `e + d >= 9` (sets the OBJ flag).

`LoadPaletteShadow` (`$00:$05b0`) is the same entry guarded by `hFadedOut`: if
the screen is faded out it diverts to `LoadPalettesMasterOnly` (`$00:$05e1`,
`d = $c2` only), so palettes loaded during a fade appear when the fade-in runs.
`RestorePalettesFromMaster` (`$00:$05f4`) copies back and sets both dirty bits.

`ApplyPendingPaletteUpdates` (`$00:$060d`) is the VBlank consumer:
`LoadBGPaletteData` (`$00:$027f`) writes `$80` to `rBGPI` (auto-increment) and
streams 64 bytes to `rBGPD`; `LoadOBJPaletteData` (`$00:$0287`) does the same
via `rOBPI`/`rOBPD`. (These are the RGBDS names for the registers other
documents call BCPS/BCPD and OCPS/OCPD.)

### 5.4 How a fade applies

The bank-`$00` fade is a per-frame state machine — `hFadeState` (`$ffa2`),
`hFadeSpeed` (`$ffa3`), `hFadeCounter` (`$ffa4`, starts `$7c`) — ticked from
VBlank by `UpdateFadeOut` (`$00:$1d5e`) and `UpdateFadeIn` (`$00:$1d48`)
(`src/home/vblank_00.asm`). Entry points: `BeginFadeOut` (`$00:$1d20`),
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

`AdjustColorsBrightness` (`$00:$1cd9`) sets `d = c` and calls
`AddClampColorComponent` (`$00:$1ca0`) on each of r/g/b:

```asm
	add d           ; $1ca0
	bit 7, a        ; $1ca1
	jr z, .clampHigh
	xor a           ; clamp to 0
	ret
.clampHigh:
	cp $1f
	ret c
	ld a, $1f       ; clamp to 31
```

So the fade is an **additive per-component offset with saturation**, not a
multiply, and the delta is always in 0-31 because `srl c` twice
(`$00:$1d8c`, `$1d8e`) is a *logical* shift.

The delta is non-negative, `AddClampColorComponent` **adds** it and
saturates at `$1f`, and during a fade-out it rises 0 → 31, so every component
ends at maximum: the bank `$00` fade goes to **white**, and a fade-in comes
back down from white. The `bit 7` clamp-to-zero branch is unreachable from
this caller, since a 0-31 component plus a 0-31 delta never sets bit 7. Seen
live: four frames into the erase-menu fade-out (`hFadeState` = 1,
`hFadeCounter` `$2c`) `wBGPalettes` holds the master colours plus 20 per
component, and palette 0's `$015f` has become `$53df`.

The `hFadeState` bit-7 path (`Unused_00_ApplyWhiteFade`, `$00:$1dcc`) cannot
be selected: its only setter is `Unused_00_BeginWhiteFadeOut` (`$00:$1d0f`),
which nothing references (`docs/bugs.md`). It is additive toward `$1f` as
well, differing by being cheaper (one 16-bit add per colour) and coarser
(saturating at `$1e`, because it pre-clears each field's low bit to make the
carry detectable).

A **second, independent** fade engine lives in bank `$03` with buffers in WRAM
bank `$06` (`wPaletteFadeTarget` `$d0a0`, `wPaletteFadeLive` `$d140`,
`wPaletteFadeMask` `$d1e0`, 16 bytes). It steps each component **±1 per
pass** toward a target buffer rather than scaling:
`CopyMasterPalettesToFadeBuffers` (`$03:$75e9`) seeds both buffers from
`wMasterPalettes`, the caller rewrites the target with
`Unused_03_ClearFadeTargetPalettes` (`$03:$7606`, → black) or
`DesaturateFadeTargetPalettes` (`$03:$7616`, → grayscale), then
`AnimatePaletteFadeToTarget` (`$03:$7719`) waits `wPaletteFadeFrameDelay`
frames, steps every masked palette of the *live* buffer with
`StepPaletteColorsTowardTarget` (`$03:$7764`), uploads the live buffer, and
repeats `wPaletteFadeAmount` times before `SnapPalettesToTarget`
(`$03:$77e2`) copies the target over it. Public entry points are the farptr
slots `$03:$4040` (`InitGrayscalePaletteFade`), `$03:$4042`
(`SetupPaletteFadeMask`) and `$03:$4044`. The live callers, `RunEndingCreditsSequence`
(`$0a:$6ece`) and `PlayScreenSequence0` (`$18:$76dd`), all fade to
grayscale; the fade-to-black setup, `Unused_03_InitBlackPaletteFade`
(`$03:$75ca`), is unreachable, so nothing in the shipped game fades to black.

---

## 6. Text

`docs/screens_and_ui.md` §7.1-§7.3 already covers the id decode, the fetchers,
the control-code engine at `$05:$4e5d`, and glyph rasterisation. This section
covers only the *physical layout* it does not.

### 6.1 Id → (bank, index)

A text id is a 16-bit coordinate, not an address:

| bits | meaning |
|---|---|
| 15 | string is in SRAM (player-entered names) |
| 13-10 | fetcher selector 0-15 → text bank |
| 9-0 | string index within that bank |

`FetchDialogueText` (`$05:$5c18`) tests `bit 7, h`, then builds
`de = (h & $03) << 8 | l` and `a = (h >> 2) & $0f`, and jumps through
`DialogueTextFetchers_05` (`$05:$5c3b`, `src/engine/text/dialogue_05.asm`), a 16-word
table. Selectors 0-7 → banks `$30`-`$37`; 8 → `$6e`, 9 → `$1f`, 10 → `$25`,
11 → `$26`, 12 → `$5e`; **13, 14 and 15 all alias bank `$30`**.
`include/text_ids.inc` names ids by the bank the selector resolves to.

### 6.2 Pool layout

All 13 text banks have an identical prologue:

```asm
	farptr FetchDialogueText_XX      ; $4000
	farptr FetchShortText_XX         ; $4002
FetchTextTable_XX:                       ; $4004  — spec `text_offsets`
	dw TextStrings_XX.sN - TextStrings_XX ; <index>
	...
TextStrings_XX:                          ; — spec `text_pool`
```

(`src/data/text/text_30.asm`.) The offset table runs from `$4004` immediately to
the pool, so its entry count is `(pool - $4004) / 2`. Across the 13 banks that
totals **4,109 indexed strings**, the largest being bank `$36` with 711 and
bank `$30` with 560.

An independent check on that geometry: `AddTextIdOffsetWordLookupTable`
(`$05:$5d99`) holds 13 words in fetcher-selector order that match the computed
per-bank counts entry for entry. `AddTextIdOffset` (`$05:$5d2b`) uses it to
carry an id offset across a bank boundary, so ids form one flat sequence.

Strings are **`$00`-terminated**. `FetchText_30` (`$30:$7d92`) computes
`hl = FetchTextTable_30 + index*2`, adds the word to `TextStrings_30`, and
copies until `$00` — into `wTextBuffer` (`$c600`, 160 bytes) or, with `a != 0`,
`wShortTextBuffer` (`$d880`, 16 bytes). `$01` is a newline and `$02` a page
break inside a string.

### 6.3 The `.sN` anchors are not string indices

`string_starts` (`tools/extract.py:171`) splits the pool on `$00` **or `$03`**.
`$03` is really the `WaitTextAdvanceInput` control code, not an engine
terminator, so the `.sN` anchors `render_text_pool` emits are numbered over
`$00`/`$03`-delimited *fragments*. `src/data/text/text_30.asm` shows the
consequence directly: table index 2 → `.s3`, index 3 → `.s5`, index 4 → `.s7`.
The comment after each `dw` carries the true game index; the label does not.

Nothing checks the pairing automatically: each `text_offsets` table must be
followed by its `text_pool`, entry 0 is `$0000` (it addresses the pool's first
string in all 13 banks), and every word must land on a string start within the
pool.

`include/text_ids.inc` is hand-maintained: 1,284 `def Text_<bank>_<index> equ
<raw id>` lines, an EQU whose value is the raw id so assembled bytes are
unchanged. A site is named by **consumer**, not by value — only where the id
reaches a known text sink — because the id encoding is far too permissive to
judge by value.

---

## 7. The declaration layer

### 7.1 What declares what

Every structured data region in the source was rendered from a **spec
string** (`kind` or `kind:param`), and each region's first line still says
which: `; $46ef, 112 bytes (bytes:16)`. The generator that applied them was
retired on 2026-09-11 (git tag `generator-final` holds it and its
`data_tables.json`, **2,751 declarations**; the counts below are those
declarations at the tag, not today's source, which has e.g. 170
`sprite_template` and 262 `actor_script` regions), so a region is now edited as
the macro rows it rendered to. `data.manifest` holds the extracted regions
(`tools/check.py` → `regions N checked`).

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

Rendering is split: `tools/extract.py`'s `render_spec` (line 528) handles the
kinds whose rows are literal ROM values and runs at setup; the kinds whose
rows are label arithmetic or macro calls are written directly in the source.

### 7.2 No ROM values in the repository

`palettes`, `sound_index`, `sound_data` and `text_pool` render ROM *values*
rather than derived structure, so they are generated into the gitignored
`data/` tree at setup and `INCLUDE`d. Anything whose rows are label
arithmetic or pointer symbols stays inline, because rgbasm recomputes those
from the layout and they reproduce nothing.

### 7.3 Splittable kinds

The kinds whose rendering is a run of independent rows can be cut at any
offset and rendered as two pieces without changing a byte: `bytes`, `records`, `words`,
`tilemap`, `palettes`, `sound_data`, `text_ids`, `flag_ids`, `map_actors`. A
pointer into the middle of one of these anchors a label there; every other kind
— bytecode, a table whose rows reference their own base, a decoded header — has
to stay whole, and a pointer into it stays numeric.

`fill` and `pattern` are deliberately excluded: they *assert* that one exact run
is padding, so a label inside one means the padding stopped there. Carrying such
a spec past a cut once turned 1,472 bytes of bank `$28` tile graphics into `ds`
runs — wrong, and it would have inlined ROM content into the repo.

### 7.4 A `records:`/`bytes:` declaration over an LZ payload is a lie

This is the rule that matters most when extending the carve.

A truncated pointer target is only missing a spec if it is really structure. If
the bytes are a graphics payload, a named `INCBIN` is **already the correct
rendering**, and a `records:`/`bytes:` declaration over it produces `dw`/`db`
rows that describe nothing. That mistake cost **2,359 bytes** of fake
"structured source" in bank `$06` on 2026-07-22, where two LZ payloads sat
inside `records:2`/`bytes:14` tables and the progress metric counted them as
proven structure (`docs/history.md:22-26`, `:8382-8388`).

The rule separates the two, taking both proofs **from the consumer** rather than from the bytes looking plausible:

1. the stream **LZ-decodes using exactly its own extent** — so it is what
   `DecompressData` is given; or
2. the bank sizes it with **`(next - name) / 16`** — the 16-byte tile count
   `QueueVRAMCopy` takes (§2.2), so it is a raw tile stream.

Payloads passing either test are not reported as truncated at all. Note that
both tests are consumer-shaped by design: "these bytes look like tiles" is not
a proof and is not accepted.

### 7.5 The structural checks

`python3 tools/check.py` is the invariant suite over things `make compare`
cannot see — a byte-perfect build proves the bytes come back, not that the
structure the source claims is true. At HEAD, all thirteen pass:

| check | count | what it asserts |
|---|---|---|
| `lz` | 839 | every stream decodes inside its extent and re-encodes to a stream that decodes back |
| `lz-labels` | 839 | no symbol lands inside a compressed stream |
| `regions` | 4243 | manifest regions stay inside their bank and do not overlap |
| `sound` | 315 | every sound track decodes over exactly its extent and renders to rows that encode back |
| `traj` | 15 | every trajectory table is whole rows and renders to rows that parse back |
| `scopes` | 0 | no global label covers both actor-script bytecode and CPU code |
| `branches` | 14 | no *new* conditional branch targets the instruction after it |
| `literals` | 35808 | no ROM address is written as a number where the source moves |
| `dma` | 51 | every label handed straight to a VRAM DMA routine is 16-byte aligned |
| `gfx` | 2728 | every PNG encodes back to the blob it was decoded from |
| `tilemap` | 213 | every tilemap grid encodes back to its blob |
| `slots` | 4967 | every `ACTOR_*` slot name holds its actor wherever a script uses it |
| `reach` | 4754 | a routine is named `Unused` exactly when nothing reachable reaches it |

---

## 8. Not established

Collected so future sessions do not have to re-derive them. What remains
open:

* The `$63` sentinel branch in `LoadActorObjectDef` (`$04:$4b2b`) is dead for
  all 117 dispatch entries, so the +8 palette pointer's use cannot be
  confirmed from data. What it *would* do is clear — load the object's own
  palette from that pointer — so the sentinel is a per-object-palette
  feature no shipped object uses.
* What the intended difference between `AdjustColorsBrightness` and
  `Unused_00_ApplyWhiteFade` was, given both add toward `$1f`. Only the developers could
  say; the cheaper 16-bit form is the one left unreachable.

**Settled on 2026-09-11**

* The three odd-sized `palettes` regions were all over-declared: `0x63ab5`
  (bank `$18`) is 128 bytes of palettes plus a lone `ret` nothing references
  (`Unused_18_StubRet3`); `0x52ea1` (bank `$14`) is four palettes plus a
  47-byte unreferenced routine that resets the firework objects on a button
  press (`Unused_14_ResetFireworkObjOnButton`); `0x618ad` (bank `$18`) is six
  palettes plus three `$00` bytes padding the next blob to `$58e0`
  (`ConfirmScreenSpritePalette1Pad`).
* Object-header bytes +2/+3 are a constant, `$02 $00` in all 92 walk-sprite
  headers and `$03 $00` in the character banks — a fixed per-family field. No
  loader reads them, so whatever they meant to the tool that emitted the
  headers, the game does not use it.
* The 136-byte scene-config record: only `+2`…`+5` are ever read. The story
  loader copies all 136 bytes to `wStorySceneRecord`, reads the four scroll
  and size bytes back out, and no code anywhere reads the copy past `+5`
  (the only other consumer of slot 0 is the debug loader, which treats its
  first 64 bytes as palettes). The bytes are real data — every one of them
  varies across the 21 story records, and `+16`…`+47` is four 8-byte
  entries keyed `0/2/4/6` — but they are a leftover of a richer record the
  shipped loaders no longer consume. For the 16 court records the first 80
  bytes are the two scoreboard column blocks (§3.4).
