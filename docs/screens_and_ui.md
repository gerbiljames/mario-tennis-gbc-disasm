# Screens and the UI framework

About twenty banks are "a screen", all built on the same plumbing: one frame
barrier, one VRAM queue, one shadow tilemap, one OAM builder, one palette/fade
engine, one text-and-window engine and one shared library of screen helpers.
This document covers that framework, not individual screens.

Related: [bank0_notes.md](bank0_notes.md) (ROM0 routine inventory),
[ram_map.md](ram_map.md) (RAM overview; per-address notes in `ram/*.asm`), [sound_engine.md](sound_engine.md),
[save_format.md](save_format.md), [actor_script.md](actor_script.md),
[bugs.md](bugs.md) (shipped defects, including `ConvertColorToGrayscale`'s
dropped blue channel and the dead link-error check in `AdvanceFrame`).

---

## 1. The frame loop

### 1.1 `AdvanceFrame` — the barrier

`AdvanceFrame` (`$00:$2631`, `src/home/flags_00.asm`) is the game's only frame
barrier (417 call sites). Per call it:

1. Saves `af/bc/de/hl` and `rVBK`, clears `hVBlankOccurred` (`$2645`).
2. Calls `RunFrameTasks` with `a = 0` (`$2647`, §1.3).
3. Flips the OAM build page: `wSpriteBufferPage = (page & $cf) ^ $05`
   (`$264b`), alternating `$c0`/`$c5` (§5.1).
4. Switches to WRAM bank `$07` and calls `ResumeBGMAfterJingle` (`$265e`).
5. Tracks the frame's peak `rLY` in `hPeakLY`/`hPeakLYFrames` and formats it as
   hex into `wDebugPeakLYText` (`$2666`-`$2681`) — a permanent CPU load meter.
6. Runs the debug single-stepper if `hDebugStepMode` is set (§1.5).
7. Waits: `halt` until `hVBlankOccurred` (`$2700`), or, when
   `hLinkExchangeActive`, spins until both `hVBlankOccurred` and
   `hLinkTransferDone` are set (`$270b`).
8. Restores `rVBK` and calls `ClearUnusedSprites` (`$271d`), blanking the new
   build page's unused tail after the wait.

`WaitFrames` (`$00:$2740`, `c` = count) loops around it; `WaitFramesCmd`
(`$00:$2725`) takes the count inline after the call (`wait_frames N`).

### 1.2 What VBlank does, in order

`VBlankHandler` (`$00:$2749`, `src/home/vblank_00.asm`):

| # | step | addr | note |
|---|---|---|---|
| 0 | bail if `hVBlankSuppressed` | `$274a` | whole handler skipped |
| 1 | `ApplyPendingPaletteUpdates` | `$2756` | palettes first |
| 2 | scroll / BG map select | `$2763` | only on the first VBlank of a wait (`hVBlankOccurred == 0`); a later VBlank skips steps 2-7 (`$275c`) |
| 3 | OAM DMA | `$2795` | `call hOAMDMARoutine` with the source page patched in |
| 4 | `ProcessBGBlitQueue` | `$2798` | one BG row + one BG column (§2.4) |
| 5 | `ProcessVRAMCopyQueues` | `$279e` | **skipped** when step 4 returns nonzero |
| 6 | `UpdateDebugOverlay` | `$27a6` | only when `hDebugStepMode` is set |
| 7 | `hVBlankOccurred = 1`, `hVBlankCounter++` | `$27a9` | releases `AdvanceFrame` |
| 8 | `ReadJoypad`, soft-reset check, `AdvanceRandomSeed` | `$27b6` | skipped while `hLinkExchangeActive` |
| 9 | `UpdateGameTimer` | `$27c3` | |
| 10 | `UpdateFadeOut`, `UpdateFadeIn` | `$27c6` | palettes for the *next* frame (§6.3) |
| 11 | `UpdateSoundEngine` | `$27cc` | |

Step 2 normally copies `hScrollX`/`hScrollY` to `rSCX`/`rSCY` and clears `rLCDC`
bit 3 (BG map `$9800`); when `hShowDebugConsole == 1` it forces `SCX = 0`,
`SCY = $40` and sets bit 3, showing the debug console from `$9c00`
(`$2773`-`$2784`; `wDebugTextBuffer` at `$cc00` goes to the `$9d00` rows).

Step 5's suppression is the only VBlank budget mechanism: the column blit uses
CPU stores, so when it runs it sets `hBGColumnBlitDone` (`$21d1`) and the VRAM
copy queue waits a frame.

`LCDStatHandler` (`$00:$27f5`) is a raster split-scroll: between scanlines
`wRasterScrollStartLY` and `wRasterScrollEndLY` it writes `wRasterScrollX` to
`rSCX`, then zeroes it — the offset band on the results and cutscene screens.
`TimerHandler` (`$00:$27d7`) only services sound, and only while the LCD is off
(when VBlank is not arriving); on the link slave it also stands aside while a
serial interrupt is pending.

### 1.3 Frame tasks

`wFrameTasks` (`$c1c0`, 64 bytes) is 16 records of `[id, ptr lo, ptr hi, rom bank]`.

- `RegisterFrameTask` (`$00:$1b6a`, id in `a`, handler in `hl`) captures
  `hRomBank`, refuses duplicates (compares the pointer triple across all 16
  slots via `Compare3Bytes`), inserts into the first slot whose triple is zero
  (the loop runs 22 records, not 16 —
  [bugs.md](bugs.md#registerframetask-inserts-six-records-past-the-end-of-its-table))
  and calls `SortFrameTasks`.
- `SortFrameTasks` (`$00:$1c3f`) sorts ascending by id, so **the id is a priority**.
- `RunFrameTasks` (`$00:$1bff`) masks the caller's `a` with `$80` and runs slots
  whose id has the same bit 7 and a nonzero remainder (empty slots have id 0),
  banking in each task's ROM bank, `jp hl`, then restoring ROM and WRAM banks.
- `hFrameTasksReady` is cleared while the list is mutated so a concurrent
  `RunFrameTasks` skips it.

`AdvanceFrame` is the only caller and passes `a = 0` (`$00:$2647`), so ids
`$01`-`$7f` run and the bit-7 class never does. Tasks run in the main loop just
before the frame wait, not in VBlank, whatever their names say.

Live registrations are in banks `$03`-`$06`, `$0a`, `$0b`, `$0e`, `$0f`, `$10`,
`$13`-`$18`, `$1b`-`$1e`, `$38`, `$3b`, `$3e`, `$3f` and `$6b`; those in banks
`$00`, `$1a` and `$6d` are all in `Unused_*` routines. Typical uses: blinking
cursors and continue arrows, scroll arrows, gauge fills, deferred tilemap copies.

### 1.4 Input latching

`ReadJoypad` (`$00:$02eb`) runs once per frame from VBlank and writes three HRAM
bytes in the `PADF_*` layout (buttons low nibble, d-pad high):

| byte | addr | meaning |
|---|---|---|
| `hPlayerInputFlags` | `$ff90` | held |
| `hInputRisingEdge` | `$ff94` | newly pressed (`old xor new and new`, `$0310`) |
| `hInputPressed` | `$ff91` | auto-repeat output |

Repeat (`$031b`-`$0343`): a held set not overlapping the previously repeating set
fires immediately, is recorded in `hInputRepeatButtons` and arms
`hInputRepeatTimer = $12` (18 frames); after that `hInputPressed` is nonzero only
when the timer expires, reloading from `hInputRepeatDelay`. Menus read
`hInputPressed`, so held directions scroll.

`hPlayerInputFlags == $0f` (all four face buttons) jumps to `SoftReset`
(`$00:$2582`; the `jp z` is at `$27bd`).

Menus mostly read `wMenuInputPressed` (`$cb0d`), a per-loop copy of
`hInputPressed` (e.g. `$16:$450c`, `$3e:$452a`), so a screen can substitute link
input without touching HRAM.

### 1.5 The debug single-stepper

In `AdvanceFrame`, when `hDebugStepMode` is nonzero and no link exchange is
active, holding SELECT+START sets `hDebugStepPaused` and enters a second wait
loop (`$268f`-`$26f1`): SELECT cycles `hDebugStepMode` through 1-3, START
releases. While paused, `UpdateDebugOverlay` runs each VBlank. Step mode also
makes two overflows audible: a full VRAM copy queue plays sound `$6f`
(`$00:$04e1`), a truncated text fetch `$2c` (`$30:$7dc7`).

The only reachable nonzero write is `InitAndRunGame` setting it to 3 at `.loopB`
(`$01:$40bd`), which runs only if `RunStoryModeOverworld` returns; apart from
`SoftReset`'s clear and the stepper's own cycling, every other writer is in an
`Unused` debug screen
([bugs.md](bugs.md#the-whole-developer-debug-harness-is-unreachable-and-its-unlock-flag-is-never-read)).

---

## 2. Getting bytes into VRAM

### 2.1 `QueueVRAMCopy` is the only door

`QueueVRAMCopy` (`$00:$0480`, `src/home/memory_00.asm`, 610 call sites); there
is no direct `ld [$8xxx], a` in the ROM.

```
hl = source (ROM or WRAM, in the current hRomBank / hWramBank)
de = destination, with the VRAM bank in bit 13
c  = length in 16-byte blocks
```

Bit 13 is `VRAM_BANK1 equ $2000` (`include/constants/`), tested with
`bit 5, d` and stripped with `res 5, d`; the source writes `$9800 + VRAM_BANK1`
for `$9800` in VRAM bank 1.

- **LCD off** (`rLCDC` bit 7 clear): set `rVBK` and fall into
  `StartVRAMDMAFromHL` (`$00:$18eb`, jumps to `StartVRAMDMATransfer` at
  `$18d7`) — a GDMA that stalls the CPU until done.
- **LCD on**: fill a `wVRAMCopyQueue` slot and set `hVRAMQueueDirty`.

### 2.2 The queue

`wVRAMCopyQueue` (`$c0a0`, 80 bytes) is 10 slots of 8 bytes, probed by low byte
`$a0, $a8, … $e8` (`$0499`-`$04d6`):

| off | content |
|---|---|
| `+$00` | ROM bank of the source (0 = slot free) |
| `+$01` | WRAM bank of the source |
| `+$02`/`+$03` | source high/low → `$ff51`/`$ff52` |
| `+$04` | VRAM bank → `rVBK` |
| `+$05`/`+$06` | destination high (bit 13 stripped) / low → `$ff53`/`$ff54` |
| `+$07` | length − 1 → `$ff55` (starts the transfer) |

`ProcessVRAMCopyQueues` (`$00:$052e`) drains all ten in VBlank, banking in each
slot's ROM and WRAM bank and clearing `+$00`. On overflow `QueueVRAMCopy` sets
`hVRAMQueueDirty` and returns `a = 0` having done nothing. There is no length
accounting, so a screen that queues more than VBlank can transfer tears; the
flush helpers in §3.4 split their work across frames for that reason.

### 2.3 Single-cell writes

`QueueBGTileWrite` (`$00:$0507`): `de` = VRAM cell, `l` = tile, `h` = attribute.
`wTileWriteQueue` (`$c180`, 64 bytes) holds 16 `[addr hi, addr lo, tile, attr]`
records, drained in the same VBlank pass (`$0572`-`$0594`): tile under
`rVBK = 0`, attribute under `rVBK = 1`.

### 2.4 The row / column blit channel

`ProcessBGBlitQueue` (`$00:$218d`), separate from and ahead of the queue, sends
at most one BG row and one BG column per frame.

- **Row** (`hBGRowBlitPending`): programs the CGB VDMA registers by hand twice —
  `wBGRowBlitAttrs` (`$c300`) to `wBGRowBlitDest` under `rVBK = 1`, then
  `wBGRowBlitTiles` (`$c340`) under `rVBK = 0`, `$ff55 = $01` (32 bytes, one row).
- **Column** (`hBGColumnBlitPending`): 32 CPU stores at stride `$20` from
  `$9800 + wBGColumnBlitX`, attributes then tiles (`wBGColumnBlitAttrs` `$c380`,
  `wBGColumnBlitTiles` `$c3c0`). Sets `hBGColumnBlitDone`, which is the return
  value and suppresses `ProcessVRAMCopyQueues` for the frame.

---

## 3. The tilemap pipeline

Screens assemble a 32×32 tile plane and a parallel 32×32 CGB attribute plane in
WRAM, then blit.

### 3.1 Geometry

`TILEMAP_WIDTH equ 32` and `TILE_SIZE equ 16` are in
`include/hardware.inc:975,981`. A cell is `base + row * TILEMAP_WIDTH + col`;
the visible window is the top-left 20×18. The source writes cell addresses that
way (`wShadowTilemap + 11 * TILEMAP_WIDTH`, `$39:$4d03`).

### 3.2 Two plane-pairing conventions

**Convention A — one WRAM bank, planes `$400` apart** (tiles `$d000`, attributes
`$d400`). The default; used by the shared library and the text engine.

| pair | WRAM bank | used by |
|---|---|---|
| `wShadowTilemap` / `wShadowAttrmap` | `$03` | most full-screen UIs; `LoadScreenAssetRecord` decompresses into them (`$39:$40c3`, `$40d0`) |
| `wWindowShadowTilemap` / `wWindowShadowAttrmap` | `$05` | the text-window engine's own map (`ResetTextWindowState`, `$05:$6e09`) |
| `wCourtTilemap` / `wCourtAttrmap` | `$02` | the match court (the match uses bank `$03` for other things) |

The pair is retargetable: `wShadowTilemapPtr` (`$c3b4`) and
`wShadowTilemapBank` (`$c3b3`) name the live base, and the window engine
addresses every cell through them (`GetTilemapCellAddress`, `$05:$4122`). So a
bank-`$05` text window lands in bank `$03`'s screen tilemap once
`ResetScreenAndTextWindows` sets `wShadowTilemapBank = $03` (`$39:$4c1b`).

**Convention B — one address, two WRAM banks.** Tile byte under one bank,
attribute byte under another.

| pair | banks | used by |
|---|---|---|
| `wShadowTilemap` / `wScreenAttrmap`, both `$d000` | tiles `$03`, attrs `$02` | character-data and EXP screens, overworld scroll buffers |
| `wCharDataScreenCell` `$d000`, `wCharDataPagePlane` `$d400`, `wCharDataPageSlot1/2/3` | mirrored across `$02`/`$03` | `include/ram_mirrored.inc` |

Sharing an address lets one loop patch both planes: `ApplyTilemapPatchList`
(`$1d:$4bb6`) copies `[hl]` → `[de]` under `wram_bank $03` (tile), then again
under `wram_bank $02` (attribute) from the same address. Its callers pass `bc` = a source inside the mirrored region
(`wScreenAttrmap + 28 * TILEMAP_WIDTH + 16` at `$1d:$414c`,
`wCharDataPagePlane + 7 * TILEMAP_WIDTH` at `$1d:$4ae4`). Patch-list record,
4 bytes, `$ff`-terminated:

| off | field |
|---|---|
| `+$00`/`+$01` | destination offset word (high byte first), added to `wCharDataScreenCell` |
| `+$02` | source offset byte, added to `bc` |
| `+$03` | length in cells |

`SaveWorkTilemapToPage` (`$1d:$4a14`, selector in `a`) snapshots 576 bytes of
the live screen into `wCharDataPageSlot1/2/3` or
`wCharDataPagePlane + 13 * TILEMAP_WIDTH`, once per bank;
`LoadBasePageIntoWorkTilemap` (`$1d:$4aa9`) copies a base page back. This page
mechanism belongs to the character-data screens only.

### 3.3 Drawing primitives

| routine | addr | contract |
|---|---|---|
| `CopyTextRect` | `$00:$2b46` | `hl` = packed row-major block, `de` = destination cell, `b` = width, `c` = height. Destination stride `$20`; source not padded. |
| `CopyTilemapRect` | `$39:$4530` | same, but source stride is also `$20` (a rectangle out of another 32-wide map). |
| `FillTilemapRect` | `$39:$4558` | fills with tile `h`; `de`/`b`/`c` as above. |
| `DrawWindowFrame` | `$00:$2b68` | `de` = tile destination, `bc` = attribute destination, `h` = width, `l` = height. Clears the interior to tile `$20` and `wWindowFrameAttr`, then draws the border. `DrawWindowFramePriority`/`DrawWindowFrameNoPriority` (`$2b5c`/`$2b63`) preset that attribute to `$80` (BG-over-OBJ) or `$00`. |
| `ApplyTilemapPatchList` | `$1d:$4bb6` | §3.2. |

The data shapes these consume are macros in `include/macros/`:
`tilemap_begin`/`tilemap_row`/`tilemap_end`, `rect_pair` (for
`CopyTextRectPair`, `$06:$5045`), `rect_ptrs`, and `tilemap_copy`/`tilemap_rect`
(the two `CopyTilemapRect` record formats, driven at `$16:$4a71` and `$39:$4e11`).

Both window-frame implementations (`$00:$2bbb`-`$2bea`, `$05:$6fca`-`$703f`) use
the same font tiles:

| tile | `$02` | `$03` | `$04` | `$05` | `$06` | `$07` | `$08` | `$09` | `$20` |
|---|---|---|---|---|---|---|---|---|---|
| cell | ┌ | ─ | ┐ | │ left | │ right | └ | ─ | ┘ | blank |

### 3.4 Flushing to VRAM

| routine | addr | what it sends |
|---|---|---|
| `QueueWram3MapToVRAM` | `$39:$4325` | `wShadowTilemap` → `$9800`, `wShadowAttrmap` → `$9800 + VRAM_BANK1`, `c = $40` (1024 bytes) each; two queue slots, ~1 ms of VBlank. |
| `FlushWram3MapRows` | `$39:$4cab` | selected row bands, four layouts in `b`, split across two frames by an `AdvanceFrame` (`$4ce8`, `$4d4a`, `$4d95`, `$4dc6`). |
| `Unused_05_QueueFullTilemapCopy` / `Unused_05_QueueFullAttrmapCopy` | `$05:$41c6` / `$41df` | `b` = WRAM bank; `$d000` → `$9800`, `$d400` → `$9800 + VRAM_BANK1`, `c = $40`. |
| `Unused_05_CopyVisibleTilemapToVRAM` | `$05:$4146` | scroll-aware: 19 rows from `(wCameraY+1) & $1f`, split in two when the band wraps past row 32. Both planes. |
| `CopyScrolledSceneTilemapToVram` | `$0a:$5c29` | the overworld's LCD-off blit, below. |
| `Unused_00_QueueDeferredTilemapCopy` | `$00:$2a2e` | stores `a` = WRAM bank, `c` = length, `hl` = tile source, `de` = attribute source, and registers `Unused_00_VBlankDeferredTilemapCopyTask` as frame task `$05`. `wDeferredTilemapPending`'s low nibble owes the tile plane, high nibble the attributes; destination fixed at `$9800`. |
| `FlushDirtyRowsPerFrame` | `$05:$711a` | the text engine's incremental flush, §7.6. |

`CopyScrolledSceneTilemapToVram` is convention B in action: destination
`$9800 + (camY_hi & $1f) * 32 + (camX_hi & $1f)`, source
`$d000 + camY_hi * 64 + camX_hi`, and the same 23×21 cell loop run twice — with
`wram_bank $02` / `rVBK = 1` for attributes (`$5c6b`-`$5cb6`), then
`wram_bank $03` / `rVBK = 0` for tiles (`$5cba`-`$5d04`). It wraps the source at
64 cells (`and $3f` → `+$ffc0`) and the destination at 32 columns
(`and $1f` → `+$ffe0`), with `res 2, a` keeping the destination in the `$9800`
page. At 483 CPU stores per plane it only runs with the LCD off.

### 3.5 The scrolling map buffers

The overworld keeps a larger buffer at `$d000` in WRAM banks `$02` (attributes)
and `$03` (tiles) and pushes one row and one column per frame through §2.4. The
4096 bytes have two geometries; the blitter a screen calls fixes which.

| addressing helper | addr | geometry |
|---|---|---|
| `GetMapBufferAddr64` | `$00:$220e` | 64 × 64: `$d000 + ((camY+c) & $3f) * 64 + ((camX+b) & $3f)` |
| `Unused_00_GetScrollBufferAddr` | `$00:$22f6` | 32 × 128: `$d000 + ((camY+c) & $7f) * 32 + ((camX+b) & $1f)` |

| blitter | addr | source geometry |
|---|---|---|
| `BlitBGRowFrom64` | `$00:$222c` | 64-wide, one 32-cell row |
| `BlitBGColumnFrom64` | `$00:$2299` | 64-wide, one 32-cell column |
| `Unused_00_BlitBGStrip` | `$00:$2313` | 32-wide row |
| `Unused_00_BlitBGStrip2` | `$00:$2380` | 32-wide column |

Each gathers into the §2.4 staging buffers indexed by destination column, so the
strip lands rotated correctly on the VRAM torus (`inc e / res 5, e` wraps at 32),
and sets the matching pending flag.

`Unused_00_CopyMapToScrollBuffers` (`$00:$086c`) fills the 64-wide buffers from a
decompressed 32-wide map: four 512-byte chunks from `wDecompBuffer` (WRAM bank
`$01`) through `wTextBuffer`, expanded by `Unused_00_CopyMapRows32To64`
(`$00:$07dd`, 32 source bytes then 32 zeros per row, 16 rows per call). The
second and fourth expansions are immediately cleared — `ClearMemory16`,
`c = $80`, over `wMapScrollPlane1` (`$08b3`) and `wScreenScratch` (`$08fb`) — so
two of the four are wasted (noted on `wMapScrollPlane1` in `ram/wram/`).

### 3.6 Undoing a draw

`RestoreShadowTilemapRow` (`$05:$43d2`, `a` = map row) re-fetches 32 cells from
the 64-wide map buffer at `$d000`, from the camera column wrapping at 64, into
`wTilemapRowStage`, then writes them into `wWindowShadowTilemap` (WRAM bank
`$05`) at row `a & $1f`. `RestoreAllShadowTilemapRows` (`$05:$4383`) does 4
batches of 5 rows with an `AdvanceFrame` between batches when the LCD is on;
`RestoreTilemapUnderWindow` (`$05:$43a8`) restores the rows a window covers
(row and height from its struct). This is the "close the text box, put the
scenery back" path.

---

## 4. Screen assets and the `$4000` slot convention

### 4.1 `farptr` tables

Every bank that exposes anything opens with a `farptr` table at `$4000`. The
`farcall` macro (`include/macros/:9`) emits `rst Rst18` plus
`LOW(FarPtr_x), BANK(FarPtr_x)`; `FarCall` (`$00:$01b6`) switches banks, indexes
the table, dispatches, and returns past the operands. A bank's `$4000` table is
its public interface — read it first.

Asset banks use the same table for data: a `dw SomeBlob` slot is resolved by
`CopyDataFromBank` (`$00:$021a`) or `DecompressDataFromBank` (`$00:$0234`).
`FarPtr_*`/`DataPtr_*` labels are named after their targets; `dslot`
(`include/macros/:33`) writes a `(slot, bank)` word pair for tables whose
loaders read the slot reference through RAM.

### 4.2 Bank `$39` is the shared screen library

Its `$4000` table (`src/engine/menus/common/slots_39.asm`, to `$407c`) indexes the
framework: asset loading, tilemap rects, palettes, sprite helpers, the menu
background scroll, animated tiles and screen reset.

Three dispatchers cover nearly every screen asset:

| dispatcher | addr | argument | table |
|---|---|---|---|
| `LoadScreenAssetRecord` | `$39:$407e` | `c` = `SCREENASSET_<Name>` | `ScreenAssetRecordTable` (`$39:$40f5`), 70 `screen_asset` records × 4 slots |
| `LoadCompressedTileBlock` | `$39:$468b` | `b` = `TILEBLOCK_<Blob>`; `de` = VRAM destination; `c` = tile count (`<Blob>_SIZE / 16` for the whole block) | `TileBlockPtrs_39` (`$39:$46b7`), 122 `tileblock` records × 1 slot |
| `SceneGfxSlotTable` | bank `$0a` | scene index | 8 slots per story scene |

`LoadScreenAssetRecord` consumes a `(Tiles, Tilemap, Attrmap, Palettes)` record
in order: Tiles LZ into `wDecompBuffer` (WRAM `$01`), then `QueueVRAMCopy` `$80`
blocks to `$9000 + VRAM_BANK1` plus `wTextTileBuffer` → `$8800 + VRAM_BANK1`
(`$40a0`-`$40b3`); Tilemap LZ into `wShadowTilemap` (WRAM `$03`, `$40c3`);
Attrmap LZ into `wShadowAttrmap` (`$40d0`); Palettes as raw 64 bytes via
`CopyDataFromBank`, then `LoadPaletteShadow` with `de = $0008`, the 8 BG
palettes (`$40e5`-`$40f1`).

`LoadCompressedTileBlock` decompresses to `wDecompBuffer` and forwards the
caller's `de`/`c` to `QueueVRAMCopy`, restoring the WRAM bank around it.

The `tileblock`/`screen_asset` macros define `TILEBLOCK_Name`/`SCREENASSET_Name`
by row position (`include/macros/`); call sites and the bank `$18` per-scene
id lists use the names, so inserting a row renumbers consistently. To add a
block: a `DataPtr_` slot in some bank's `$4000` table, a `tileblock` row, and
the name at the call site.

Since these are the only ways in, a decompressed blob's size often names it:
64 bytes an icon or palette set, 1024 a tilemap or attribute plane, 4096 a
tileset.

### 4.3 Other bank-`$39` furniture

- `UpdateAnimatedTiles` (`$39:$4342`): `wAnimatedTileTimer` counts to
  `wAnimatedTilePeriod` (usually 3); on wrap it advances `wAnimatedTileFrame`,
  looks up `wAnimatedTileSet` in `UpdateAnimatedTilesTable` and decompresses the
  frame's tiles.
- `InitMenuBgScroll` / `TickMenuBgScroll` (`$39:$4b13` / `$4b6d`): the two-lane
  scrolling sprite band behind menus, alternating lanes each frame, a 10-sprite
  row through `QueueSpriteTemplate`.
- `LoadIndexedPalette` (`$39:$457f`, `c` = palette data index, `b` = destination
  slot) and `Unused_39_LoadFixedPaletteSet` (`$39:$4661`): palette loaders.

---

## 5. Sprites and OAM

### 5.1 Double-buffered shadow OAM

Two 160-byte shadow OAM pages: `$c000` (`wShadowOAM`) and `$c500` (unnamed).
`wSpriteBufferPage` (`$c3a7`) is the high byte of the page being built;
`AdvanceFrame` flips it (`$00:$264b`) and VBlank DMAs the other page
(`ld a,[wSpriteBufferPage] / xor $05 / ldh [hOAMDMARoutine + 1], a`,
`$00:$278e`). `hOAMDMARoutine` is the 10-byte stub copied to HRAM `$ff80` by
`CopyOAMDMARoutineToHRAM` (`$00:$06ac`); `+1` is the source page.

`hSpriteQueueIndex` (`$ff9b`) is the write offset into the build page, capped at
`$a0` (40 × 4 bytes); queue routines drop sprites when full.
`hSpriteQueueBase` (`$ff9c`) is a floor: `ClearUnusedSprites` (`$00:$1e22`)
resets the index to it and zeroes from there to `$a0`, so entries below it would
persist. It is dead: only `ClearSpriteQueue` (`$00:$1e20`, `xor a`) and the
uncalled `Unused_00_SetSpriteQueueBase` (`$00:$1e50`) write it.

### 5.2 The builders

| routine | addr | emits |
|---|---|---|
| `QueueSprite` | `$00:$1f51` | one entry; `e` + `$0c` → Y, `d` + `$04` → X, `c` = tile, `b` = attribute |
| `QueueSprite16` | `$00:$1e55` | a 16×16 pair: the second at X+8 with tile `c+2`; with attribute bit 5 (X-flip) the halves swap order |
| `Unused_00_QueueSpriteGrid` | `$00:$1f0d` | an `h` × `l` grid; applies the `+$10`/`+$08` OAM bias up front, X +8 and tile +2 per column, Y +`$10` per row |
| `QueueSpriteTemplate` | `$00:$1e9d` | an `oam_sprite` list, adding each `{dy, dx, tile, attr}` to the base in `e`/`d`/`c`/`b`; ends at `dy == $80`. Mirrored (attribute bit 5): `dx` becomes `8 - dx` and the attribute is ORed, not added |
| `QueueSprite24x32`, `QueueSprite32x32`, `QueueSpriteBlockPart` | `$00:$2c2b`, `$2ced`, `$2d79` | fixed larger blocks for the court renderer |

`oam_sprite` lists (tagged `sprite_template` in their block comments) appear in
21 banks. Walk-sprite banks (`$6a`, `$6f`, `$70`-`$77`) hold object headers whose
`dw .frames, <name>_AnimPtrs, .frames` triple points at frame and
animation-script pointer arrays (e.g. `WalkSprite_72_00`,
`src/data/sprites/walk_72.asm:19`-`23`); see
[graphics_formats.md](graphics_formats.md) §4.4.

`Unused_00_PositionSpriteWorld` (`$00:$1f6b`) and `Unused_00_PositionSpriteWorld2`
(`$00:$1fb1`) are world-space wrappers: subtract `wCameraX`/`wCameraY`, cull on
the difference's high byte (`cp $16` for X, `cp $14`/`$13` for Y), multiply by 8
and take the high byte (one high-byte unit = 8 pixels, a world unit = 1/32
pixel), then call `QueueSprite16` / `QueueSprite`. `ProjectWorldToScreen`
(`$00:$2d8c`) and `GetPerspectiveScale` (`$00:$2e61`) are the court's
perspective projection, out of scope here.

---

## 6. Palettes and fades

### 6.1 Shadow, master, dirty flags

Sixteen 8-byte palettes: `wBGPalettes` (`$c100`, 0-7) and `wOBJPalettes`
(`$c140`, 8-15). `wMasterPalettes` (`$c200`, 128 bytes) holds the unfaded colours.

`hPaletteDirtyFlags` (`$ff9d`): bit 0 BG, bit 1 OBJ. `ApplyPendingPaletteUpdates`
(`$00:$060d`), first in VBlank, uploads the flagged halves via
`LoadBGPaletteData` / `LoadOBJPaletteData` (`$027f` / `$0287`) and clears the flags.

### 6.2 Loading

`LoadPaletteShadow` (`$00:$05b0`): `hl` = source, `d` = first palette (0-15),
`e` = count. `LoadPalettesImmediate` (`$05b5`) writes both `$c1xx` and `$c2xx`,
then sets dirty bit 0 when `d < 8` and bit 1 when `d + e >= 9`. With `hFadedOut`
set it diverts to `LoadPalettesMasterOnly` (`$05e1`), so a palette loaded during
a blackout waits for the running fade. `RestorePalettesFromMaster`
(`$00:$05f4`) copies all 128 bytes back and sets both dirty bits.

### 6.3 Fades

State: `hFadeState` (`$ffa2`; bit 0 fading out, bit 1 fading in, bit 7 the
alternate curve), `hFadeSpeed` (`$ffa3`), `hFadeCounter` (`$ffa4`) and the latch
`hFadedOut` (`$ffbc`).

`BeginFadeOut` (`$00:$1d20`) and `BeginFadeIn` (`$00:$1d2e`) share `.setSpeed`
(`$1d3b`): speed in `c` (0 treated as 1), `hFadeCounter = $7c`, set/clear
`hFadedOut`. Each is a no-op if already in the target state; `ForceFadeIn`
(`$00:$1d0c`) skips that guard.

`UpdateFadeOut` (`$00:$1d5e`) and `UpdateFadeIn` (`$00:$1d48`) run every VBlank
and share `.step2` (`$1d76`): subtract the speed from the counter, clamp at 0,
derive a ramp in `c`, then

```
hl = wMasterPalettes ; de = wBGPalettes ; b = $40 (64 colours) ; d = c >> 2
call AdjustColorsBrightness
hPaletteDirtyFlags = $03
```

`AdjustColorsBrightness` (`$00:$1cd9`) adds `d` to each 5-bit component via
`AddClampColorComponent` (`$1ca0`, clamps at `$1f`, a bit-7 result counts as 0).
Fade-out uses `c = $7c - counter` (0 → 31), fade-in `c = counter` (31 → 0); the
delta is positive both ways, so **this game fades through white, not black**.
The fade ends when the counter reaches 0 and `hFadeState` is cleared (`$1d97`),
after `$7c / speed` frames. Since this runs after `ApplyPendingPaletteUpdates`,
each step reaches the hardware a frame later.

`WaitFadeEnd` (`$00:$1da4`) spins on `hFadeState`, advancing a frame locally or,
when `hLinkExchangeActive`, through `SyncLinkFrame`.
`Unused_00_WaitFadeEndLinked` (`$00:$1dbd`) is the same loop hard-wired to
`SyncLinkFrame`.

`Unused_00_ApplyWhiteFade` (`$00:$1dcc`) is a cheaper second curve: adds a
per-channel increment to the packed BGR555 word with `add`/`adc` and repairs
carries across channel boundaries. It is reached only from the bit-7 branch at
`$1d7a`, and the only write setting bit 7 is at `$00:$1d19`, inside the uncalled
`Unused_00_BeginWhiteFadeOut` (`$1d0f`) — so it never runs.
`Unused_00_ForceFadeOut` (`$1d09`) is also unreferenced.

`ConvertColorToGrayscale` (`$1d:$7210`):
[bugs.md](bugs.md#grayscale-conversion-drops-the-blue-channel).

---

## 7. Text and windows

Bank `$05` is the text and window engine. Its `$4000` table
(`src/engine/text/slots_05.asm`, `$4000`-`$4095`, 75 slots) is the public API,
reached by `farcall`.

### 7.1 A text id is a coordinate, not an address

`FetchDialogueText` (`$05:$5c18`) decodes the id in `hl`:

```
bit 15      -> the string is in SRAM (player-entered names)
bits 13-10  -> which text bank
bits  9-0   -> string index within that bank
```

`DialogueTextFetchers_05` (`$05:$5c3b`, 16 records): 0-7 → `$30`-`$37`,
8 → `$6e`, 9 → `$1f`, 10 → `$25`, 11 → `$26`, 12 → `$5e`, 13-15 alias `$30`.
So `$013f` is bank `$30`, index 319.

Each text bank exports `FetchDialogueText_XX` / `FetchShortText_XX` over one
body. `FetchText_30` (`$30:$7d92`) indexes the word-offset table
`FetchTextTable_30` by `index * 2`, adds `TextStrings_30`, and copies through
the `$00`:

- `a = 0` → `wTextBuffer` (`$c600`, 160 bytes)
- `a != 0` → `wShortTextBuffer` (`$d880`, 16 bytes)

On truncation it NUL-terminates (and plays `$2c` in debug step mode).

`AddTextIdOffset` (`$05:$5d2b`) adds an offset to an id and **carries across
text banks** using per-bank string counts (`AddTextIdOffsetWordLookupTable`,
`$05:$5d99`, 13 words), so ids form one flat sequence.

`include/text_ids.inc` defines `Text_<bank>_<index> equ <raw id>` for operands;
`tools/strings.py --index --bank XX` dumps `bank:index → text` from
`data/bank_XXX/TextStrings_XX.asm`.

### 7.2 The interpreter

`TextInterpreterLoop` (`$05:$4e5d`) is the loop body of `RenderTextString`
(`$05:$4e23`), which falls into it. `hl` = stream (normally `wTextBuffer`),
`de` = shadow-tilemap cell from `GetTilemapCellAddress` on
`wTextCursorColumn`/`wTextCursorRow`.

Per byte (`$4e75`-`$4ecd`):

- `$00` → flush the glyph row (unless `FLAG_TEXT_RENDER_ACTIVE`) and return.
- `$de` / `$df` → remapped to codes `$1e` / `$1f`.
- `$0e` → latch **one inline operand byte** into `wTextCharNameArg`, then
  dispatch as `$0e`. The only code with an operand.
- `< $20` → dispatch as a control code, then `RedrawActiveTextWindow`.
- `>= $20` → `WrapTextCellPointer`, `DrawStreamGlyph`, `UploadLastGlyphTiles`,
  `DelayTextCharacter`, advance the cell. At column 32 it computes a `-$20` wrap
  then pops the old `de` over it (`$4ec1`-`$4ecc`), so the cell runs on into the
  next row.

It returns early when `wTextPageBreakRequest` is set, saving `hl` in
`wTextResumePtr`; that is how a page break suspends and resumes mid-string.

`DispatchControlCode` (`$05:$546c`) pushes `ControlCodeDispatchReturn` as a fake
return address, indexes `ControlCodeHandlers_05` (`$05:$548f`, 32 records, codes
`$00`-`$1f`) by `a * 2`, and `jp hl`.

| code | handler | effect |
|---|---|---|
| `$00` | *(intercepted)* | **terminator** |
| `$01` | `TextCmdNewline` | `wTextCursorRow += 2` — line pitch is two tilemap rows |
| `$02` | `TextCmdWaitButtonPage` | blink the continue arrow (a frame task), wait, set `wTextPageBreakRequest` |
| `$03` | `WaitTextAdvanceInput` | flush the glyph row, wait for a button in mask `$f3`; skipped under `FLAG_CUTSCENE_FAST_FORWARD` |
| `$04` | `TextCmdPrintArgString` | pop the string queue → `wInlineTextBuffer` → `RenderInlineString` |
| `$05` | `TextCmdDelay30` | 30 frames, not skippable |
| `$06` | `TextCmdDelay15Skippable` | 15 frames, aborts on input |
| `$07` | `TextCmdPrintPlayerName` | `wStoryModeNameOfMainCharacter` |
| `$08` | `TextCmdNop2` | `ret`, but the measuring pass treats `$08` as a short-text argument (§7.4) |
| `$09` | `TextCmdPrintArgNumber` | pop the number queue → `RenderInlineNumber` |
| `$0a` | `TextCmdNop` | `ret` |
| `$0b` | `TextCmdPrintPartnerName` | `wStoryModeNameOfPartnerCharacter` |
| `$0c` | `TextCmdDelay150Skippable` | 150 frames, skippable |
| `$0d` | `TextCmdNextGlyphStreamRow` | glyph write pointer += `$40` (two tilemap rows) |
| `$0e` | `TextCmdPrintShortText` | **+1 operand**: short-text id `$001b + operand` (the 27-entry roster bias) → `wInlineTextBuffer` |
| `$0f`, `$14`-`$1d` | `TextCmdNewline` | eleven aliases |
| `$10`-`$13` | `ControlCodeHandler16`-`19` | four separate bare `ret`s |
| `$1e` (`$de`) | `TextCmdApplyDakuten` | adds a voiced-sound mark to the *previous* cell |
| `$1f` (`$df`) | `TextCmdApplyHandakuten` | same, semi-voiced mark |

The string pools (`data/bank_*/TextStrings_*.asm`) spell these with the `TX_*`
names of `include/text_codes.inc` (`$01`/`$02`/`$03` as `line`/`page`/`done`),
with `TX_SHORT_TEXT`'s operand as a `CHAR_*` constant
(`TX_SHORT_TEXT, CHAR_EMILY` in "Oh, Coach Emily!"). Codes used: `$07` (246
times), `$0e` (95), `$06` (67), `$0b` (41), `$09` (34), `$04` (11), plus
`$01`-`$03`; never `$05`, `$08` or the dakuten pair.

Two more 16-entry tables, each with its own inline `jp hl` dispatch:
`ProportionalTextCodeHandlers_05` (`$05:$5e39`, driven by
`RenderProportionalTextAt` — a text id at an arbitrary cell, no window, no
delays) and `TextControlCodeHandlers_05` (`$05:$5f94`, driven by
`RenderTextToBuffer64`, which stores characters into a 64-column buffer
instead of rasterising).

### 7.3 Glyphs are rasterised at run time

No charmap: `DrawGlyph` (`$05:$7322`) does `sub $20` and indexes `FontGlyphs`
(`$05:$7920`, 102 × 16-byte 8×8 2bpp tiles). `GlyphWidths_05` (`$05:$7f80`, 96
bytes) gives widths of 3-8 pixels.

Glyphs are composed into `wGlyphTileBuffer` (2048 bytes = 128 tiles, WRAM bank
`$07`) and uploaded to VRAM `$8800`+ as text reveals. `PlotGlyphRow`
(`$05:$737a`) shifts each font byte right by `pen & 7` and ORs the halves into
adjacent tiles; `wGlyphPenX` (`$c3b7`) is the fixed-point pen, `$80` per cell.
`StampGlyphTileAtPen` (`$05:$5f0d`) writes tile `(pen >> 7) + $80` into the
shadow tilemap, skipping cells holding `$06` (the right border).

A window's interior text cells therefore hold consecutive tile ids from
`$80 + wGlyphRowStartCol`, continuing across text rows (`DrawTextWindowFrame`,
`$05:$6fc1`), and the engine rewrites the VRAM tiles under them. Upload paths:
`UploadLastGlyphTiles` (`$05:$7607`, the 2 tiles at the pen),
`Unused_05_UploadGlyphTileRange` (`$05:$78ad`), `UploadGlyphBufferFull`
(`$05:$742c`, five 16-tile pages with `AdvanceFrame` between),
`FlushGlyphRow` (`$05:$77a3`, queued or DMA depending on the LCD). The live
per-window glyph path is `InitGlyphStreamForWindow` → `DrawStreamGlyph` →
`StampGlyphTileAtPen` → `FlushGlyphRow`.

Message speed:

1. `StoryPauseMenu_MessageSpeed` (`$06:$6ff7`, items
   `STORYMENUITEM_MSG_SLOW`/`NORMAL`/`FAST`) stores `2 - selection` in
   `wMessageSpeed` (`$c8a4`; 0 fast, 1 normal, 2 slow, bit 7 a transient
   "instant" override).
2. `ApplyMessageSpeed` (`$05:$57e7`) sets `wTextRedrawGuard`: bit 7 or 0 → 0,
   1 → 2, else 4.
3. `DelayTextCharacter` (`$05:$579b`, per-character delay and blip) waits that
   many frames, aborting on input.
4. `UploadLastGlyphTiles` and `FlushGlyphRow` also skip the 2-tile upload on
   fast/instant (`$05:$7621`, `$77af`), making FAST truly instant.

`wTextRedrawGuard` doubles as a re-entrancy guard for the wait and delay
commands ("if 0, set to 1, redraw, clear"), so on FAST those commands do an
extra redraw that NORMAL and SLOW skip.

### 7.4 The three text-argument queues

WRAM bank `$05`, 16 entries each, all reset at every dialogue entry
(`ShowSpeakerDialogue`, `$05:$582c`-`$583e`).

| queue | addr | element | pushed by | consumed by |
|---|---|---|---|---|
| `wTextArgStringQueue` | `$d8b0` | 2-byte pointer, high nibble = WRAM bank tag | `PushTextArgString` (`$05:$50f7`) | code `$04` |
| `wTextArgNumberQueue` | `$d8d0` | 2-byte value | `PushTextArgNumber` (`$05:$5147`) | code `$09` |
| `wTextArgShortTextQueue` | `$d8f0` | 1-byte short-text id | `Unused_05_PushTextArgShortTextId` (`$05:$517a`, no callers) | only the measuring pass; code `$08` is a `ret` |

Each has a write index, a count and a separate *measure* index:
`FitWindowToText` / `MeasureTextDimensions` walk the message to size the window
before drawing, then the render pass walks it again.

If a string pointer's high nibble is `$d` (banked WRAM), `PushTextArgString`
packs `hWramBank` into the top nibble; code `$04` unpacks it before copying 32
bytes into `wInlineTextBuffer` (`$c6c0`).

Character names bypass the queues: `$07`/`$0b` read the name buffers, `$0e`
resolves `$001b + operand` against the roster.

### 7.5 Windows

`wWindowSlotMask` (`$dc70`), one bit per slot. `AllocWindowId` (`$05:$6e96`)
scans **bits 0-6 only**, claims the first clear bit and returns its index or
`$ff` — struct 7 is unreachable through it. `FreeWindow` (`$05:$6eba`) zeroes the
record and clears the bit. `Unused_05_AllocWindowSlotBit` (`$05:$4627`) is an
uncalled byte-identical duplicate of `AllocWindowId`.

`wWindowStructs` (`$dc00`): eight 8-byte records, via `GetWindowStructPtr`
(`$05:$6eea`, `id & $07`, `<< 3`):

| off | field | evidence |
|---|---|---|
| `+$00` | column (`and $1f`) | `SetWindowRect`, `$05:$4538` |
| `+$01` | row (`and $1f`) | same |
| `+$02` | **width** in cells | 20×3 bottom box built with `b = $14, c = $03` (`$39:$4c27`); `DrawTextWindowFrame` runs it horizontally (`$05:$6f80`-`$6fae`); `InitGlyphStreamForWindow` stores it − 2 in `wTextRowWidth` (`$05:$7559`-`$756e`) |
| `+$03` | **height** in cells | `DrawTextWindowFrame`'s row counter |
| `+$04` | state | `SetWindowState` / `GetWindowState` (`$05:$4767` / `$4773`); `$02` plain menu, `$03` paged menu, `$ff` do not draw. Bit 1 also indents text one column (`$05:$620a`). |
| `+$05` | unused | no live code addresses it; `FreeWindow` and the `wSavedWindowStruct` save/restore copy it with the record. Only the dead `Unused_05_WriteStringToTilemapStreamed` names `$dc05`, keeping a tilemap pointer at `$dc05`/`$dc06` and a flag at `$dc09` — scratch from before the window structs lived here |
| `+$06`/`+$07` | text id lo/hi | `SetWindowTextId` (`$05:$55d5`); high byte `$03` = "no text" |

Creation entry points, all into `AllocWindowStruct` (`$05:$6e6d`):

| routine | addr | adds |
|---|---|---|
| `CreateWindowFromScreenRect` | `$05:$6e45` | `PrepareGlyphBuffer`, then `GetScreenTopLeftCell` (`$05:$464b`) turns `hScrollX`/`hScrollY` into a cell origin so `de` is screen-relative |
| `CreateWindow` | `$05:$4684` | thin alias |
| `CreateWindowWithAttr` | `$05:$4664` | parks a CGB attribute in `wWindowTileAttr` for the duration |
| `CreateDialogueWindow` | `$05:$4688` | also caches `wDialogueWindow{Id,Col,Row}` and the two size bytes |
| `CreateMenuWindowFromText` | `$05:$46b0` | fetches and measures the text, derives the size, pushes a menu-stack frame |
| `CreateMenuWindowPaged` | `$05:$4747` | the same plus state `$03` |

`DrawTextWindowFrame` (`$05:$6f70`) draws into the shadow tilemap at
`wShadowTilemapPtr + row * 32 + col` with the §3.3 tiles, alternating interior
rows between blanks and glyph rows (`bit 0, d`, `$6ff3`), then repeats the
rectangle at `+$0400` with `wWindowTileAttr`. Every cell step goes through
`WrapCellPtrToRowStart` / `ClampCellPtrToShadowMap`, so windows may wrap the
32×32 plane. No VRAM access.

`ResetTextWindowState` (`$05:$6e09`), the cold init, clears `$d000`-`$dfff` in
WRAM bank `$05` (struct array, dirty flags, slot mask), points
`wShadowTilemapPtr`/`Bank` at `$d000`/`$05`, and sets `wWindowTileAttr = $80`,
`wDialogueWindowId = $ff`, `wMenuWindowId = $fe`.

`Unused_05_DrawWindowGlyphRun` (`$05:$74de`) has no callers and is not in the
`$4000` table; its use of `b`/`c` reads as a fragment of an earlier design.

### 7.6 Window → VRAM: dirty row runs

`MarkWindowRowsDirty` (`$05:$7096`) and `SetRowDirtyFlags` (`$05:$70aa`) clear
`wTilemapRowDirty` (`$dc40`, one flag per row) and mark the `e` rows from `d`,
wrapping at 32 — a replace, not an accumulate. `BuildDirtyRowRuns`
(`$05:$71c4`) folds that into `wTilemapRowRuns` (`$dc60`, 16 bytes) as
`(first row, length)` pairs ending `$ff`, **capping runs at 7 rows**
(`cp $07`, `$71f0`) so one copy fits a VBlank. `FlushDirtyRowsPerFrame`
(`$05:$711a`) copies each run through `CopyDirtyRowSpanToVRAM` (tiles from
`wShadowTilemapPtr` to `$9800`, attributes from `+$0400` to
`$9800 + VRAM_BANK1`), calling `AdvanceFrame` between runs while the LCD is on;
`FlushDirtyRowsNow` (`$05:$7148`) skips the waits. `FLAG_VRAM_UPDATE_BUSY` is
held throughout.

### 7.7 Menus over windows

`RunMenuSelection` (`$05:$477f`) and `Unused_05_RunMenuSelectionShared`
(`$05:$4aa8`) run the cursor loop over a text-derived menu window:

| return | meaning |
|---|---|
| `< $7f` | the row picked |
| `$fe` | page left |
| `$ff` | cancel (B or START) |
| other | page right |

A paged text menu lists consecutive text ids, four per page.
`RunPagedTextMenu` (`$05:$4944`): `hl` = base text id, `de` = window
column/row, `a` = page count; returns `wMenuPage * 4 + row` or `$ff` (e.g.
`RunSinglesMatchListMenu`, `$10:$4195`: `ld hl,Text_31_132 / ld de,$0101 /
ld a,$05`). `Unused_05_RunPagedTextMenuAutoSize` (`$05:$49f6`, no callers)
re-derives the column per page and registers `Unused_05_PagedMenuFrameTask`,
whose body is empty ([bugs.md](bugs.md)).

`wMenuStack` (`$d832`, six 2-byte frames `[rowCount << 4 | cursorRow, windowId]`)
and `wMenuDepth` (`$d83e`) let nested menus restore their cursor:
`CreateMenuWindowFromText` saves the outgoing `wMenuCursorRow` into the current
frame before pushing (`$05:$4707`-`$4738`).

Bank `$1a` holds an unreached pause-menu layer (all `Unused_1a_*`);
`Unused_1a_RunPauseMenuWindow` (`$1a:$402c`) shows the idiom: in WRAM bank
`$05`, `CreateMenuWindowFromText` (→ `wPauseMenuWindowId`), then
`RestoreShadowTilemap` / `RenderMenuWindowText` under `FLAG_VRAM_UPDATE_BUSY`,
then a loop of `Unused_1a_DrawPauseMenuSettingValues`,
`Unused_05_RunMenuSelectionShared` and `CloseWindow` unless the chosen row's bit
is set in `wMenuKeepOpenRowMask` (`$cb29`; bit 7 = present, rotated by the row
index) — the rows that keep the window open after a change. Menu
contents are `menu_def` records (`include/macros/`). Item ids are the
`MATCHMENUITEM_*` / `STORYMENUITEM_*` constants, which index the item's word
art, its 3×2 label rect and its caption text id alike.

### 7.8 The other, unrelated font

ROM0 has an independent renderer for numbers and debug output.
`NumberFontGlyphPtrs` (`$00:$2091`) is 16 pointers to `font_glyph` records
(`db width, height`, then 2bpp rows). `Unused_00_RenderGlyphToTiles`
(`$00:$211b`) is a per-pixel 2bpp blitter: pixel X in `b`, row offset in `c`,
tile-strip base in `de`, destination mask from `PixelMaskTable` (`$00:$2113`),
two source bits per iteration. `Unused_00_RenderTextToTiles` (`$00:$20e5`)
walks a NUL-terminated ASCII string, treats bytes below `$30` as a 6-pixel space
and advances by each glyph's width. `PrintString` (`$00:$1906`),
`FormatHexWord` (`$00:$1935`), `FormatDecimalNumber` (`$00:$1972`) and
`Unused_00_CopyTextString` (`$00:$2aa6`) complete the debug path, drawing into
`wDebugTextBuffer` (`$cc00`, 576 bytes) for the `$9c00` console.

`RenderProportionalMenuText` (`$00:$2a9e`) is not part of this: it forwards to
bank `$05`'s `RenderProportionalTextAt` with `c = $11`.

---

## 8. Anatomy of a screen

### 8.1 Entering and leaving

The transition idiom (example at `$10:$4f58`-`$4f79`): `BeginFadeOut` (`c = $7f`),
`WaitFadeEnd`, `DisableLCDSafely`, `LoadMenuFontGfx`,
`ResetScreenAndTextWindows` (`a` must be 0), `EnableLCD`, `script_fade_in $10`,
`WaitFadeEnd`; then a `.menuLoop` that resets the screen's cursors and camera,
`ResumeBGM`, `InitSerialLink`, calls the menu (`RunMainMenu`, `$ff` = back to
`.titleScreen`) and dispatches the selection through a `dw` handler table with
`jp hl`.

The fades hide the rebuild; heavy work (tile uploads, decompression, full-map
blits) happens with the LCD off, where `QueueVRAMCopy` transfers immediately.

`ResetScreenAndTextWindows` (`$39:$4bf3`), the shared reset:

1. zero `hScrollX`/`hScrollY` and `wCameraX`/`wCameraY` (from `a`, which the
   caller must have cleared);
2. `LoadStadiumBgGraphics`;
3. `ResetTextWindowState` (bank `$05`, §7.5);
4. `LoadCompressedTileBlock(b = TILEBLOCK_SharedMenuGfx17Alias17,
   c = SharedMenuGfx17_SIZE / 16 = 16 tiles, de = vTiles2)` — the menu font;
5. `wram_bank $05`, then `wShadowTilemapBank = $03` and `wWindowTileAttr = $00`
   — **pointing the window engine at the screen's own tilemap**;
6. `CreateWindowFromScreenRect(d = 0, e = $0f, b = $14, c = $03)` — the 20×3
   bottom text box at row 15;
7. `DrawTextWindowFrame`, `RedrawWindowRows`, `QueueWram3MapToVRAM`.

### 8.2 The menu tree pattern

Banks `$0e`-`$15` are story-mode screen banks sharing one structure, documented
in the story-mode map-script comment in `include/macros/`. A location or
screen owns a **7-slot `dw` tree**; a bank-level `$4000` directory may point at
several (`$0f` has three, `$14` four). Story-map slot roles: 0 entry points,
1 exit triggers, 2 actors, 3 NPC scripts, 4 facing scripts, 5 tile triggers,
6 init-code entry. Empty slots point at a shared `$ff`.

Menu screens use the same tree: `map_script` records (8 bytes, `$ff`-terminated)
are their handler table, and `map_actor` rows (14 bytes, word at `+$02` = the
actor's `ActorScript_*`) their actor lists. Per-stage choices are indexed
inline, with the `dw` table right after the function's `ret`:

```
ld a, [wMapSceneStage] / ... / add a / ld_hl_indexed Table
ld a, [hl+] / ld h, [hl] / ld l, a
```

Bank `$10` (story match select): its `$4000` table is an 8-slot directory of map
trees; slot 0 is `MatchSelectMapScripts_10` (`$4010`), whose actor list is
`MatchSelectActors_10` and whose slot 3 is `MatchSelectHandlerTable_10`
(`$10:$4145`): nine `map_script` records `{db actor, db FACEMASK_ANY,
dw flag_cond, dw handler, db arg0, db arg1}`. In the singles list
(`RunSinglesMatchListMenuTable`), `LoadMatchSinglesJunior3Alias` is named for
what it does because slot 8 launches the wrong match —
[bugs.md](bugs.md#match-select-slot-8-launches-the-wrong-match).

### 8.3 Cursor movement

The wrap-and-clamp idiom:

```
    inc a           ; or dec a
    add a           ; carry iff the value was >= $80, i.e. it went negative
    jr nc, .check
    ld a, c / dec a / jr .done ; wrapped below 0 -> last item
.check:
    rra             ; undo the doubling
    cp c
    jr c, .done
    xor a           ; wrapped past the end -> first item
```

ROM0 has it as `MoveCursorHorizontal` (`$00:$2c0d`) and
`Unused_00_MoveCursorVertical` (`$00:$2c04`, tests UP/DOWN and jumps into the
horizontal routine's tail): `a` = index, `b` = pad bits, `c` = item count,
result in `a`. Only bank `$06` calls them: `MoveCursorHorizontal` from six
sites, the vertical one from one, in the unreachable
`Unused_06_HandleDebugStatsInput` (`$06:$6bfe`).

Other screen banks inline a 2-D walker: five copies, four variants each. All
walk `wMenuCursorX`/`wMenuCursorY` with `b` = columns and `c` = rows, handle at
most one direction per call (right > left > up > down) and return `a = 1` if the
cursor moved; they differ only in input source and cursor pair:

| bank | local pad (`wMenuInputPressed`) | link frame (`hLinkInput`) | remote, cursor 1 | remote, cursor 2 |
|---|---|---|---|---|
| `$16` | `Unused_16_MoveMenuCursorGrid` `$40f8` | `Unused_16_MoveMenuCursorGridFromLinkInput` `$4176` | `Unused_16_MoveMenuCursorGridRemote` `$41f3` | `Unused_16_MoveMenuCursor2GridRemote` `$42be` |
| `$1b` | `MoveMenuCursorGrid_1b` `$4132` | `Unused_1b_MoveMenuCursorGridFromLinkInput` `$41b0` | `Unused_1b_MoveMenuCursorGridRemote` `$422d` | `Unused_1b_MoveMenuCursor2GridRemote` `$42f8` |
| `$38` | `MoveMenuCursorGrid_38` `$410a` | `Unused_38_MoveMenuCursorGridFromLinkInput` `$4188` | `Unused_38_MoveMenuCursorGridRemote` `$4205` | `Unused_38_MoveMenuCursor2GridRemote` `$42d0` |
| `$3b` | `MoveMenuCursorGrid_3b` `$412a` | `Unused_3b_MoveMenuCursorRepeat` `$41a8` | `Unused_3b_MoveMenuCursorLinkLocal` `$4225` | `Unused_3b_MoveMenuCursorLinkRemote` `$42f0` |
| `$3e` | `MoveMenuCursorGrid_3e` `$413a` | `Unused_3e_MoveMenuCursorGridFromLinkInput` `$41b8` | `Unused_3e_MoveMenuCursorGridRemote` `$4235` | `Unused_3e_MoveMenuCursor2GridRemote` `$4300` |

"Remote" variants pick `hLinkRemoteInputBuf` or `hLinkRemoteInput` at run time
on `hLinkState == $02` (e.g. `$38:$420d`, `$3b:$422d`); cursor-2 variants use
`wMenuCursor2X`/`Y`.

Bank `$39` also has `MoveMinigameGridCursor` (`$39:$6df9`), a 3×2 walker whose
second row is a two-position toggle, and `FillMenuGridCellTile` (`$39:$6dc2`),
which fills that grid's 3×3 attribute cell from `FillMenuGridCellTileTable`.

`wMenuCursorLockFlags` (`$cb08`) bits 0/1 freeze the primary/secondary cursor
while a confirmed selection runs.

### 8.4 Confirm dialogs

The reusable path: `CreateMenuWindowFromText` with the prompt's text id,
`RunMenuSelection`, `CloseWindow` (§7.7; e.g. `$0a:$4c0d`-`$4c1f`). Bank `$18`
has an unreached hand-built alternative: `Unused_18_InitConfirmScreen` builds
the box, font, cursor and score panel, and `Unused_18_DrawYesNoLabels` writes
two 3×2 tile words plus attribute rows into fixed cells. Bank `$1b`'s equally
dead `Unused_1b_Draw*Prompt` routines pair it with text ids
`$046a`/`$046b`/`$046d`/`$0471` (bank `$31`, indices 106/107/109/113 — "Erase?",
"Erase it? Really?", "Continue?", "Is this correct?").

---

## 9. Shared state

Framework-wide addresses not given above; `ram/*.asm` is authoritative.

| addr | symbol | role |
|---|---|---|
| `$ff8a`/`$ff8b` | `hScrollY` / `hScrollX` | applied to `rSCY`/`rSCX` in VBlank |
| `$ff8c`/`$ff8d` | `hVBlankCounter` / `hVBlankOccurred` | frame counter; barrier flag |
| `$ff8f` | `hFrameTasksReady` | §1.3 |
| `$ff92`/`$ff93`/`$ffa6` | `hInputRepeatButtons` / `hInputRepeatTimer` / `hInputRepeatDelay` | §1.4 |
| `$ff95`/`$ff96`/`$ff97` | `hRomBank` / `hWramBank` / `hSramBank` | bank shadows; helpers save and restore them |
| `$ff98` | `hShowDebugConsole` | §1.2 |
| `$ff99` | `hVRAMQueueDirty` | copies pending; also set on overflow |
| `$ff9e`/`$ff9a` | `hDebugStepMode` / `hDebugStepPaused` | §1.5 |
| `$ffa0`/`$ffa1` | `hPeakLY` / `hPeakLYFrames` | CPU load meter |
| `$ffb8`-`$ffba` | `hBGRowBlitPending`, `hBGColumnBlitPending`, `hBGColumnBlitDone` | §2.4 |
| `$c320`/`$c322` | `wCameraX` / `wCameraY` | scroll-buffer camera |
| `$c326`/`$c328` | `wBGRowBlitDest` / `wBGColumnBlitX` | blit targets |
| `$c363`-`$c369` | `wScreenShakeMagnitude`, `wScreenShakeOffsetX/Y` | screen shake |
| `$c3a0`-`$c3a6` | `wDeferredTilemap*` | deferred copy record (§3.4) |
| `$c3b2` | `wWindowFrameAttr` | attribute for ROM0 window frames |
| `$c3b6` | `wWindowTileAttr` | glyph/window attribute |
| `$cb01`-`$cb03` | `wRasterScrollX`, `wRasterScrollStartLY`, `wRasterScrollEndLY` | LCD-STAT split scroll |
| `$cb04`-`$cb08` | `wMenuCursorX/Y`, `wMenuCursor2X/Y`, `wMenuCursorLockFlags` | menu cursors |

Banked WRAM (union variants in `ram/wram/`; detail in
its notes and `include/ram_mirrored.inc`):

| bank | `$d000` | `$d400` | `$d800`+ |
|---|---|---|---|
| `$01` | `wDecompBuffer` (2048 bytes — everything decompresses here) | | |
| `$02` | `wScreenAttrmap` / `wCourtTilemap` / `wMapScrollPlane0` | `wCourtAttrmap` | `wMapScrollPlane1`, `wCourtTilemapSaved` |
| `$03` | `wShadowTilemap` | `wShadowAttrmap` | `wScreenScratch` |
| `$05` | `wWindowShadowTilemap` | `wWindowShadowAttrmap` | text/window state, `wWindowStructs` `$dc00`, `wTilemapRowDirty` `$dc40`, `wTilemapRowRuns` `$dc60`, `wWindowSlotMask` `$dc70` |
| `$07` | `wGlyphTileBuffer` at `$d300` (to `$daff`) | | |

Framework flags (bits of `wGameFlags`, `$c9c0`; `include/flag_constants.inc`):
`FLAG_CUTSCENE_FAST_FORWARD` (22), `FLAG_VRAM_UPDATE_BUSY` (24),
`FLAG_TEXT_WAITING_FOR_BUTTON` (25), `FLAG_TEXT_RENDER_ACTIVE` (35),
`FLAG_PROPORTIONAL_TEXT_MODE` (36), `FLAG_PAUSE_OPTIONS_MENU_OPEN` (48),
`FLAG_MINIGAME_PAUSE_MENU_OPEN` (49); debug: `FLAG_DEBUG_FREEZE_TILE_ANIM` (26),
`FLAG_DEBUG_STATIC_TEXT_WINDOW` (27), `FLAG_DEBUG_SHORT_GLYPH_UPLOAD` (34).

---

## 10. Boot, and loose ends

### The boot path

`EntryPoint` → `Start` (`$00:$2578`, records `hIsCGB`) → `SoftReset`
(`$00:$2582`), which re-initialises the stack, LCD, HRAM, VRAM, the OAM DMA stub,
the sound engine and the serial link, sets `wSpriteBufferPage = $c0`, and ends
with `farcall InitAndRunGame` (`$00:$262c`); the following `stop` is unreachable
because that call never returns.

`InitAndRunGame` (`$01:$4018`) clears every WRAM bank, loads the shared menu
font and OBJ palettes, validates and repairs SRAM, initialises story and match
state, enables the LCD, fades in, and does `farcall RunStoryModeOverworld` with
`wStoryModeCurrentLocation = 0` and `wStoryModeEntryPoint = $0a`
(`$01:$40a5`-`$40af`). Only if that returns does the build-stamp screen at
`.loopB` (`$01:$40b2`) appear, waiting for A or START and re-entering the
overworld. So it is the boot manager, and its debug-harness half is unreachable.

### Open items

- `wShadowTilemapReadOffset` (`$dc76`) is read only by the dead
  `Unused_05_RefreshShadowTilemapFromMapBuffer` (`$05:$44ba`) and written
  nowhere, so it stays 0.
- `ControlCodeHandler16`-`19` (codes `$10`-`$13`): four *separate* one-byte
  `ret`s suggest deleted handlers, unproven.
- Whether `wMessageSpeed` bit 7 can stay set after a cutscene. The `or $80`
  writes at `$1a:$427c`/`$4295` are in the dead
  `Unused_1a_AdjustMessageSpeedSetting`, as are
  `Unused_1a_ForceInstantMessageSpeed`/`Unused_1a_RestoreMessageSpeed`. Live
  bit-7 writers: `ToggleCutsceneFastForward` (`$0a:$40a4`; sets it when START
  turns fast-forward off, clears it when turning it on), the tennis dictionary's
  save/`$80`/restore around a redraw (`$3f:$566e`-`$5683`), and
  `StoryPauseMenu_MessageSpeed`'s plain store. No ordering is known that
  guarantees it is cleared.
- `wGlyphBufferHoldCount` (`$d822`) is read and decremented but raised nowhere:
  [bugs.md](bugs.md#the-glyph-buffers-keep-branch-is-unreachable).
- `LoadScreenAssetRecord` sends both tile copies to VRAM bank 1 (`$9000` and
  `$8800`, `$39:$40a3`/`$40ae`); why the shared font/tile area is in bank 1
  rather than bank 0 is not known.

### Dead framework code

Not defects. Described in place: `Unused_00_ApplyWhiteFade` and
`Unused_00_ForceFadeOut` (§6.3), `Unused_00_SetSpriteQueueBase` (§5.1),
`Unused_05_AllocWindowSlotBit` and `Unused_05_DrawWindowGlyphRun` (§7.5),
`Unused_05_RunPagedTextMenuAutoSize` / `Unused_05_PagedMenuFrameTask` (§7.7),
`Unused_05_PushTextArgShortTextId` (§7.4), `Unused_00_CopyMapToScrollBuffers`
(§3.5). The white fade, `Unused_00_CopyMapToScrollBuffers` and
`Unused_05_PagedMenuFrameTask` also have [bugs.md](bugs.md) entries.

The queue-compaction tail at `$00:$0595`-`$05ae`, after the `ret` at `$0594`,
is unreachable.
