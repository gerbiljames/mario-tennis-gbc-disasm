# Screens and the UI framework

Roughly twenty of this ROM's banks are "a screen", and they are all built out of
the same plumbing: one frame barrier, one VRAM queue, one shadow tilemap, one
OAM builder, one palette/fade engine, one text-and-window engine, and one shared
library of screen helpers. This document describes that machinery.

Scope: the *framework*, not individual screens. It does not repeat what the
source already lists. Related documents:

- [bank0_notes.md](bank0_notes.md) — ROM0's routine inventory (reset vectors,
  far-call trampolines, memory helpers, sound). Read it alongside this.
- [ram_map.md](ram_map.md) — the authoritative address list. This document
  quotes addresses to identify state, not to replace that table.
- [sound_engine.md](sound_engine.md), [save_format.md](save_format.md),
  [actor_script.md](actor_script.md) — adjacent subsystems.
- [bugs.md](bugs.md) — shipped defects, including
  `ConvertColorToGrayscale`'s dropped blue channel and the dead link-error
  check inside `AdvanceFrame`. Those are not re-diagnosed here.

Every non-obvious claim below carries evidence: a `bank:addr`, a symbol, or a
`src/bank_XXX.asm:LINE`. Where something could not be established, it says so.

---

## 1. The frame loop

### 1.1 `AdvanceFrame` — the barrier

`AdvanceFrame` (`$00:$2631`, `src/bank_000.asm:6718`) is the only frame barrier
in the game and has 419 call sites. Every screen loop, every fade wait, every
"wait n frames" helper goes through it. It is not a bare `halt`; per call it:

1. Saves `af/bc/de/hl` and `rVBK`, clears `hVBlankOccurred` (`$2645`).
2. Calls `RunFrameTasks` with `a = 0` (`$2647`) — see §1.3.
3. Flips the OAM build page: `wSpriteBufferPage = (page & $cf) ^ $05`
   (`$264b`), alternating `$c0`/`$c5`. See §5.1.
4. Switches to WRAM bank `$07` and calls `ResumeBGMAfterJingle` (`$2658`).
5. Tracks the frame's peak `rLY` in `hPeakLY`/`hPeakLYFrames` and formats it as
   hex into `wDebugPeakLYText` (`$2666`-`$2681`) — a permanently-installed CPU
   load meter.
6. Runs the debug single-stepper if `hDebugStepMode` is set (§1.4).
7. Waits: `halt` until `hVBlankOccurred` is set (`$2700`), or, when
   `hLinkExchangeActive`, spins until both `hVBlankOccurred` and
   `hLinkTransferDone` are set (`$270b`).
8. Restores `rVBK` and calls `ClearUnusedSprites` (`$271d`) — the new build
   page's unused tail is blanked *after* the wait, so the queue starts empty.

`WaitFrames` (`$00:$2740`, `c` = count) is the trivial loop around it, and
`WaitFramesCmd` (`$00:$2725`) is the inline-argument variant that reads its
count from the byte after the call site (see the `INLINE_ARG_CALLS` note in
`tools/disasm.py`).

### 1.2 What VBlank does, in order

`VBlankHandler` (`$00:$2749`, `src/bank_000.asm:6908`). The order matters,
because several of these steps compete for the same ~1.09 ms.

| # | step | addr | note |
|---|---|---|---|
| 0 | bail if `hVBlankSuppressed` | `$274a` | whole handler skipped |
| 1 | `ApplyPendingPaletteUpdates` | `$2756` | uploads palettes *before* anything else |
| 2 | scroll / BG map select | `$2763` | only on the first VBlank of a wait (`hVBlankOccurred == 0`) |
| 3 | OAM DMA | `$2795` | `call hOAMDMARoutine` with the source page patched in |
| 4 | `ProcessBGBlitQueue` | `$2798` | one BG row + one BG column (§2.4) |
| 5 | `ProcessVRAMCopyQueues` | `$279e` | **skipped** when step 4 returns nonzero |
| 6 | `UpdateDebugOverlay` | `$27a6` | only when `hDebugStepMode` is set |
| 7 | `hVBlankOccurred = 1`, `hVBlankCounter++` | `$27a9` | releases `AdvanceFrame` |
| 8 | `ReadJoypad`, soft-reset check, `AdvanceRandomSeed` | `$27b6` | skipped while `hLinkExchangeActive` |
| 9 | `UpdateGameTimer` | `$27c3` | |
| 10 | `UpdateFadeOut`, `UpdateFadeIn` | `$27c6` | recompute palettes for *next* frame (§6.3) |
| 11 | `UpdateSoundEngine` | `$27cc` | |

Step 2 also selects which VRAM tilemap the BG uses: normally `rSCX`/`rSCY` come
from `hScrollX`/`hScrollY` and `rLCDC` bit 3 is cleared (BG map `$9800`), but
when `hShowDebugConsole == 1` it forces `SCX = 0`, `SCY = $40` and sets bit 3, so
the debug text console renders from the second tilemap at `$9c00` (`$2773`-`$2784`;
`wDebugTextBuffer` at `$cc00` is uploaded to the `$9d00` rows).

Step 5's suppression is the framework's only VBlank budget mechanism: the
column blit (step 4) is written with CPU stores rather than DMA, so when it runs
it sets `hBGColumnBlitDone` (`$21d1`) and the VRAM copy queue is left for the
next frame.

`LCDStatHandler` (`$00:$27f5`) is a raster split-scroll: between scanlines
`wRasterScrollStartLY` and `wRasterScrollEndLY` it writes `wRasterScrollX` to
`rSCX`, then zeroes it. That is how the results and cutscene screens get a
horizontally offset band. `TimerHandler` (`$00:$27d7`) only services sound, and
only while the LCD is off or a serial transfer is pending — the two situations
in which VBlank is not arriving.

### 1.3 Frame tasks

`wFrameTasks` (`$c1c0`, 64 bytes) is 16 records of
`[id, ptr lo, ptr hi, rom bank]`.

- `RegisterFrameTask` (`$00:$1b6a`) takes the id in `a` and the handler in
  `hl`, captures `hRomBank` itself, refuses to add a duplicate (it compares the
  three pointer bytes across all 16 slots via `Compare3Bytes`), then inserts
  into the first slot whose pointer triple is zero and calls `SortFrameTasks`.
- `SortFrameTasks` (`$00:$1c3f`) sorts the 16 records ascending by the id byte,
  so **the id is a priority**.
- `RunFrameTasks` (`$00:$1bff`) masks the caller's `a` with `$80` and runs only
  those slots whose id has the same bit 7 and a nonzero remainder — an empty
  slot has id 0 and is skipped. It banks in each task's ROM bank, `jp hl`s, and
  restores the ROM and WRAM banks afterwards.
- `hFrameTasksReady` is cleared while the list is mutated so a concurrent
  `RunFrameTasks` skips it entirely.

`AdvanceFrame` is the **only** caller of `RunFrameTasks`, and it passes `a = 0`
(`$00:$2647`), so ids `$01`-`$7f` run and the bit-7 class never does. Tasks
therefore run in the *main* loop, immediately before the frame wait — not inside
VBlank, despite some task names.

Registered from banks `$06`, `$0a`, `$0e`, `$13`, `$1a`, `$1d`, `$39`, `$6b`.
Typical uses: blinking cursors and continue arrows, scroll-arrow animation,
gauge fills, deferred tilemap copies.

### 1.4 Input latching

`ReadJoypad` (`$00:$02eb`) runs once per frame from VBlank and produces three
HRAM bytes in the `PADF_*` layout (`include/constants.inc`: buttons in the low
nibble, d-pad in the high nibble):

| byte | addr | meaning |
|---|---|---|
| `hPlayerInputFlags` | `$ff90` | buttons currently held |
| `hInputRisingEdge` | `$ff94` | newly pressed this frame (`old xor new and new`, `$0310`) |
| `hInputPressed` | `$ff91` | auto-repeat output |

The repeat logic (`$031b`-`$0343`): a held set that does not overlap the
previously-repeating set fires immediately, records itself in
`hInputRepeatButtons` and arms `hInputRepeatTimer = $12` (18 frames); thereafter
`hInputPressed` is nonzero only on the frames the timer expires, reloading from
`hInputRepeatDelay`. Menus read `hInputPressed`, so held directions scroll.

If `hPlayerInputFlags == $0f` (all four face buttons) VBlank jumps straight to
`SoftReset` (`$00:$27bd`).

Menu code generally works from `wMenuInputPressed` (`$cb0d`), a per-loop copy of
`hInputPressed` taken by each screen (e.g. `$16:$450c`, `$3e:$452a`), which lets
a screen substitute link input for local input without touching HRAM.

### 1.5 The debug single-stepper

Inside `AdvanceFrame`, when `hDebugStepMode` is nonzero and no link exchange is
active, holding SELECT+START sets `hDebugStepPaused` and the routine enters a
second wait loop (`$268f`-`$26f1`): SELECT cycles `hDebugStepMode` through 1-3,
START releases. While paused, `UpdateDebugOverlay` runs each VBlank. Debug step
mode also makes two overflow conditions *audible* — a full VRAM copy queue plays
sound `$6f` (`$00:$04e1`) and a truncated text fetch plays `$2c`
(`$30:$7dc7`).

---

## 2. Getting bytes into VRAM

### 2.1 `QueueVRAMCopy` is the only door

`QueueVRAMCopy` (`$00:$0480`, `src/bank_000.asm:672`) has 613 call sites and
there is not one direct `ld [$8xxx], a` in the ROM.

```
hl = source (ROM or WRAM, in the current hRomBank / hWramBank)
de = destination, with the VRAM bank in bit 13
c  = length in 16-byte blocks
```

`VRAM_BANK1 equ $2000` (`include/constants.inc:9`) is that bit 13. The routine
tests it with `bit 5, d` and recovers the real address with `res 5, d`, so a
destination of `$9800 + VRAM_BANK1` means `$9800` in VRAM bank 1. Writing it
that way in the disassembly is a deliberate convention: the bank is visible
rather than hidden inside a literal.

Two paths:

- **LCD off** (`rLCDC` bit 7 clear): set `rVBK` and fall into
  `StartVRAMDMAFromHL` (`$00:$18d7`/`$18f2`) immediately — a general-purpose
  GDMA that stalls the CPU until done.
- **LCD on**: fill a slot in `wVRAMCopyQueue` and set `hVRAMQueueDirty`.

### 2.2 The queue

`wVRAMCopyQueue` (`$c0a0`, 80 bytes) is 10 slots of 8 bytes. `QueueVRAMCopy`
probes them by low byte `$a0, $a8, … $e8` (`$0499`-`$04d6`); slot `+$00` doubles
as the in-use flag.

| off | content |
|---|---|
| `+$00` | ROM bank of the source (0 = slot free) |
| `+$01` | WRAM bank of the source |
| `+$02`/`+$03` | source high/low → `$ff51`/`$ff52` |
| `+$04` | VRAM bank → `rVBK` |
| `+$05`/`+$06` | destination high (bit 13 stripped) / low → `$ff53`/`$ff54` |
| `+$07` | length − 1 → `$ff55` (writing this starts the transfer) |

`ProcessVRAMCopyQueues` (`$00:$052e`) drains all ten in VBlank, banking in each
slot's ROM and WRAM bank as it goes, and clearing `+$00` as the slot is
consumed. On overflow `QueueVRAMCopy` sets `hVRAMQueueDirty` and returns
`a = 0` having done nothing — there is **no** length accounting anywhere, so a
screen that queues more than the VBlank period can transfer will tear. That is
why the flush helpers in §3.4 deliberately split their work across frames.

A tail of queue-compaction code sits at `$00:$0595`-`$05ae`, after the `ret` at
`$0594`. Nothing reaches it.

### 2.3 Single-cell writes

`QueueBGTileWrite` (`$00:$0507`) queues one BG map cell: `de` = the VRAM cell
address, `l` = tile id, `h` = attribute byte. `wTileWriteQueue` (`$c180`, 64
bytes) holds 16 records of `[addr hi, addr lo, tile, attr]`, drained in the
same VBlank pass (`$0572`-`$0594`), which writes the tile under `rVBK = 0` and
the attribute under `rVBK = 1`. This is how a screen changes a handful of cells
without re-blitting a row.

### 2.4 The row / column blit channel

Separate from the queue, and higher priority, `ProcessBGBlitQueue`
(`$00:$218d`) handles at most one BG row and one BG column per frame.

- **Row**: gated on `hBGRowBlitPending`. It programs the CGB VDMA registers by
  hand, twice — `wBGRowBlitAttrs` (`$c300`) to `wBGRowBlitDest` under
  `rVBK = 1`, then `wBGRowBlitTiles` (`$c340`) to the same address under
  `rVBK = 0`, with `$ff55 = $01` (2 blocks = 32 bytes = one full tilemap row).
- **Column**: gated on `hBGColumnBlitPending`. A column is not contiguous, so
  it is 32 CPU stores at stride `$20` starting at `$9800 + wBGColumnBlitX`,
  again attributes then tiles (`wBGColumnBlitAttrs` `$c380`,
  `wBGColumnBlitTiles` `$c3c0`). This sets `hBGColumnBlitDone`, which becomes
  the routine's return value and suppresses `ProcessVRAMCopyQueues` for the
  frame.

---

## 3. The tilemap pipeline

Nothing draws into VRAM directly. A screen assembles a 32×32 cell tile plane
and a parallel 32×32 CGB attribute plane in WRAM, then blits.

### 3.1 Geometry

`TILEMAP_WIDTH equ 32` and `TILE_SIZE equ 16` come from
`include/hardware.inc:975,981` (not `constants.inc`). A cell is
`base + row * TILEMAP_WIDTH + col`; the visible window is the top-left 20×18.
The generated source writes cell addresses in exactly that form
(`wShadowTilemap + 11 * TILEMAP_WIDTH`, `$39:$4d03`) so the row and column are
readable.

### 3.2 Two plane-pairing conventions

Both are in use. Knowing which one a bank uses is the difference between
reading its cell addresses and misreading them.

**Convention A — one WRAM bank, planes `$400` apart.** Tiles at `$d000`,
attributes at `$d400`. This is the default and the one the shared library and
the text engine use.

| pair | WRAM bank | used by |
|---|---|---|
| `wShadowTilemap` / `wShadowAttrmap` | `$03` | most full-screen UIs; `LoadScreenAssetRecord` decompresses straight into them (`$39:$40c3`, `$40d0`) |
| `wWindowShadowTilemap` / `wWindowShadowAttrmap` | `$05` | the text-window engine's own map (`ResetTextWindowState`, `$05:$6e09`) |
| `wCourtTilemap` / `wCourtAttrmap` | `$02` | the match court — bank `$02` because the match owns bank `$03` for other things |

The pair is *retargetable*: `wShadowTilemapPtr` (`$c3b4`) and
`wShadowTilemapBank` (`$c3b3`) name the live base, and the window engine
addresses every cell through them (`GetTilemapCellAddress`, `$05:$4122`). That
is how a text window drawn by bank `$05` lands in bank `$03`'s screen tilemap:
`ResetScreenAndTextWindows` sets `wShadowTilemapBank = $03` at `$39:$4c1b`.

**Convention B — one address, two WRAM banks.** The same address holds the tile
byte under one bank and the attribute byte under another.

| pair | banks | used by |
|---|---|---|
| `wShadowTilemap` (`$03`) / `wScreenAttrmap` (`$02`), both `$d000` | tiles `$03`, attrs `$02` | the character-data and EXP screens, and the overworld scroll buffers |
| `wCharDataScreenCell` `$d000`, `wCharDataPagePlane` `$d400`, `wCharDataPageSlot1/2/3` | mirrored across `$02`/`$03` | see `include/ram_mirrored.inc` |

`include/ram_mirrored.inc` is generated for exactly this case, and it explains
the payoff: because the two planes share an address, one loop can patch both.
`ApplyTilemapPatchList` (`$1d:$4bb6`) does

```
.copyLoop:
    wram_bank $03 / ld a, [hl]   / ld [de], a   ; tile byte
    wram_bank $02 / ld a, [hl+]  / ld [de], a   ; attribute byte, same address
```

reading `[hl]` twice at the same address under two banks to get two different
values. Its callers pass `bc` = a source inside the mirrored region
(`wScreenAttrmap + 28 * TILEMAP_WIDTH + 16` at `$1d:$414c`,
`wCharDataPagePlane + 7 * TILEMAP_WIDTH` at `$1d:$4ae4`), which is what makes
that work.

The patch-list record is 4 bytes, `$ff`-terminated:

| off | field |
|---|---|
| `+$00`/`+$01` | destination offset word, added to `wCharDataScreenCell` |
| `+$02` | source offset byte, added to `bc` |
| `+$03` | length in cells |

`SaveWorkTilemapToPage` (`$1d:$4a14`, selector in `a`) snapshots 576 bytes of
the live screen into `wCharDataPageSlot1/2/3` or
`wCharDataPagePlane + 13 * TILEMAP_WIDTH`, once per bank, and
`LoadBasePageIntoWorkTilemap` (`$1d:$4aa9`) copies a base page back. That is
the whole "page" mechanism: it belongs to the character-data screens, not to
the framework at large.

### 3.3 Drawing primitives

| routine | addr | contract |
|---|---|---|
| `CopyTextRect` | `$00:$2b46` | `hl` = packed row-major block, `de` = destination cell, `b` = width, `c` = height. Destination row stride `$20`; the source is *not* padded. |
| `CopyTilemapRect` | `$39:$4530` | same arguments, but the **source** stride is also `$20` — it copies a rectangle out of another 32-wide map. |
| `FillTilemapRect` | `$39:$4558` | fills with the tile id in `h`; `de`/`b`/`c` as above. |
| `DrawWindowFrame` | `$00:$2b68` | `de` = tile destination, `bc` = attribute destination, `h` = width, `l` = height. Clears the interior to tile `$20` and `wWindowFrameAttr`, then draws the border. `DrawWindowFramePriority`/`NoPriority` (`$2b5c`/`$2b63`) preset that attribute to `$80` (BG-over-OBJ) or `$00`. |
| `ApplyTilemapPatchList` | `$1d:$4bb6` | see above. |

`include/macros.inc` declares the data shapes these consume:
`tilemap_begin`/`tilemap_row`/`tilemap_end` for a fixed-geometry block (rgbasm
asserts the row count and total size, so a mis-carved width fails the build);
`rect_pair` for a `CopyTextRectPair` descriptor (`$06:$47ce`); `rect_ptrs` for
a tile/attribute block pair whose geometry lives in the code; `tilemap_copy`
and `tilemap_rect` for the two record formats driven through `CopyTilemapRect`
(`$16:$4a71` and `$39:$4e11`).

The window frame's tile ids are the same in both implementations, so the shared
font tileset reserves tiles `$02`-`$09` for the box:

| tile | `$02` | `$03` | `$04` | `$05` | `$06` | `$07` | `$08` | `$09` | `$20` |
|---|---|---|---|---|---|---|---|---|---|
| cell | ┌ | ─ | ┐ | │ left | │ right | └ | ─ | ┘ | blank |

(`$00:$2bbb`-`$2bea` and `$05:$6fca`-`$703f`.)

### 3.4 Flushing to VRAM

| routine | addr | what it sends |
|---|---|---|
| `QueueWram3MapToVRAM` | `$39:$4325` | the whole thing: `wShadowTilemap` → `$9800`, `wShadowAttrmap` → `$9800 + VRAM_BANK1`, `c = $40` (1024 bytes) each. Two queue slots, ~1 ms of VBlank. |
| `FlushWram3MapRows` | `$39:$4cab` | selected row bands only, four layout variants in `b`, split across two frames with a `call AdvanceFrame` in the middle (`$4ce8`, `$4d4a`, `$4d95`, `$4dc6`). |
| `QueueFullTilemapCopy` / `QueueFullAttrmapCopy` | `$05:$41c6` / `$41df` | `b` = WRAM bank; `$d000` → `$9800` and `$d400` → `$9800 + VRAM_BANK1`, `c = $40`. |
| `CopyVisibleTilemapToVRAM` | `$05:$4146` | scroll-aware: 19 rows starting at `(wCameraY+1) & $1f`, split into two copies when the band wraps past row 32. Both planes. |
| `CopyScrolledSceneTilemapToVram` | `$0a:$5c29` | the overworld's LCD-off blit — see below. |
| `QueueDeferredTilemapCopy` | `$00:$2a2e` | stores `a` = WRAM bank, `c` = length, `hl` = tile source, `de` = attribute source, then registers `VBlankDeferredTilemapCopyTask` as a frame task with id `$05`. `wDeferredTilemapPending`'s low nibble owes the tile plane and the high nibble the attributes; the destination is hard-coded `$9800`. |
| `FlushDirtyRowsPerFrame` | `$05:$711a` | the text engine's incremental flush — §7.6. |

`CopyScrolledSceneTilemapToVram` is worth reading once, because it is the
clearest statement of convention B. It computes a destination of
`$9800 + (camY_hi & $1f) * 32 + (camX_hi & $1f)` and a source of
`$d000 + camY_hi * 64 + camX_hi`, then runs **the same 23×21 cell loop twice**:
once with `wram_bank $02` / `rVBK = 1` for attributes (`$5c6b`-`$5cb6`) and once
with `wram_bank $03` / `rVBK = 0` for tiles (`$5cba`-`$5d04`). The two bodies are
otherwise instruction-for-instruction identical, wrapping the source at 64 cells
(`and $3f` → `+$ffc0`) and the destination at 32 columns (`and $1f` → `+$ffe0`),
with `res 2, a` on the destination high byte keeping it inside the `$9800` page.
483 CPU stores per plane means this only runs with the LCD off.

### 3.5 The scrolling map buffers

The overworld does not use a 32×32 shadow map. It keeps a larger buffer at
`$d000` in WRAM banks `$02` (attributes) and `$03` (tiles), in one of two
geometries, and pushes one row and one column per frame through §2.4.

| addressing helper | addr | geometry |
|---|---|---|
| `GetMapBufferAddr64` | `$00:$220e` | 64 × 64 cells: `$d000 + ((camY+c) & $3f) * 64 + ((camX+b) & $3f)` |
| `GetScrollBufferAddr` | `$00:$22f6` | 32 × 128 cells: `$d000 + ((camY+c) & $7f) * 32 + ((camX+b) & $1f)` |

Both are 4096 bytes, i.e. the same region carved differently; which one a
screen uses is fixed by which blitter it calls.

| blitter | addr | source geometry |
|---|---|---|
| `BlitBGRowFrom64` | `$00:$222c` | 64-wide, gathers one 32-cell row |
| `BlitBGColumnFrom64` | `$00:$2299` | 64-wide, gathers one 32-cell column |
| `BlitBGStrip` | `$00:$2313` | 32-wide row |
| `BlitBGStrip2` | `$00:$2380` | 32-wide column |

Each gathers into the staging buffers of §2.4 *indexed by the destination
column*, so the row lands correctly rotated on the VRAM torus (`inc e / res 5, e`
wraps the stage at 32), and sets the matching pending flag.

`CopyMapToScrollBuffers` (`$00:$086c`) fills the 64-wide buffers from a
decompressed 32-wide map: four 512-byte chunks are copied out of `wDecompBuffer`
(WRAM bank `$01`) through `wTextBuffer` and expanded by `CopyMapRows32To64`
(`$00:$07dd`), which writes 32 source bytes then 32 zero bytes per row, 16 rows
per call. Note that the second and fourth chunks are expanded and then
immediately cleared — `ClearMemory16` with `c = $80` over `wMapScrollPlane1`
(`$08b3`) and over `wScreenScratch` (`$08fb`) — so two of the four expansions
are thrown away. `ram_unions.json` records this on `wMapScrollPlane1`.

### 3.6 Undoing a draw

`RestoreShadowTilemapRow` (`$05:$43d2`, `a` = map row) re-fetches one row of 32
cells from the 64-wide map buffer at `$d000`, starting at the camera column and
wrapping at 64, into `wTilemapRowStage`, then writes it into `wShadowTilemap` at
row `a & $1f`. `RestoreAllShadowTilemapRows` (`$05:$4383`) does 4 batches of 5
rows with an `AdvanceFrame` between batches when the LCD is on;
`RestoreTilemapUnderWindow` (`$05:$43a8`) restores just the rows a given window
covers, reading the row and height from its struct. This is the standard
"close the text box and put the scenery back" path.

---

## 4. Screen assets and the `$4000` slot convention

### 4.1 `farptr` tables

Every bank that exposes anything opens with a table of `farptr` entries at
`$4000`. The `farcall` macro (`include/macros.inc:8`) emits `rst Rst18` plus two
bytes — `LOW(FarPtr_x), BANK(FarPtr_x)` — and `FarCall` (`$00:$01b6`) switches
banks, indexes the table, dispatches, and patches the return address past the
operands. So a bank's `$4000` table *is* its public interface, and reading it
first is the fastest way to understand a screen bank.

Asset banks use the same table for data: a slot holding `dw SomeBlob` is
resolved by `CopyDataFromBank` (`$00:$021a`) or `DecompressDataFromBank`
(`$00:$0234`). `FarPtr_*` and `DataPtr_*` labels are *derived* from their
targets' names by the emitter, and `dslot` (`include/macros.inc:31`) writes a
`(slot, bank)` word pair for tables whose loaders read the slot reference
through RAM.

### 4.2 Bank `$39` is the shared screen library

Its `$4000` table (`src/bank_039.asm:3`-`$407c`) is the single best index of the
framework: asset loading, tilemap rects, palette loading, sprite helpers, the
menu background scroll, animated tiles, and screen reset all live behind it.

Three dispatchers cover nearly every screen asset in the ROM:

| dispatcher | addr | argument | table |
|---|---|---|---|
| `LoadScreenAssetRecord` | `$39:$407e` | `c` = record id | `ScreenAssetRecordTable` (`$39:$40f5`), 70 records × 4 slots |
| `LoadCompressedTileBlock` | `$39:$468b` | `b` = block id, `de` = VRAM destination, `c` = length | `TileBlockPtrs_39` (`$39:$46b7`), 122 records × 1 slot |
| `SceneGfxSlotTable` | bank `$0a` | scene index | 8 slots per story scene |

A `ScreenAssetRecordTable` record is `(Tiles, Tilemap, Attrmap, Palettes)` and
`LoadScreenAssetRecord` consumes it in that order:

1. slot 0 → LZ into `wDecompBuffer` (WRAM `$01`), then `QueueVRAMCopy` `$80`
   blocks to `$9000 + VRAM_BANK1`, plus `wTextTileBuffer` → `$8800 + VRAM_BANK1`
   (`$40a0`-`$40b3`);
2. slot 1 → LZ into `wShadowTilemap` (WRAM `$03`, `$40c3`);
3. slot 2 → LZ into `wShadowAttrmap` (`$40d0`);
4. slot 3 → raw 64 bytes via `CopyDataFromBank`, then `LoadPaletteShadow` with
   `de = $0008` — the 8 BG palettes (`$40e5`-`$40f1`).

`LoadCompressedTileBlock` is the general "decompress a tile block to an
arbitrary VRAM address" path: it decompresses to `wDecompBuffer` and forwards
the caller's `de`/`c` to `QueueVRAMCopy`, restoring the WRAM bank around it.

Because these are the only ways in, the *size* of a decompressed blob is often
enough to name it — 64 bytes is an icon or a palette set, 1024 a tilemap or
attribute plane, 4096 a tileset.

### 4.3 Other bank-`$39` furniture

`UpdateAnimatedTiles` (`$39:$4342`) is a frame-task-shaped tile animator:
`wAnimatedTileTimer` counts to `wAnimatedTilePeriod` (usually 3) and on wrap
advances `wAnimatedTileFrame`, looks up `wAnimatedTileSet` in
`UpdateAnimatedTilesTable`, and decompresses the frame's tiles.
`InitMenuBgScroll` / `TickMenuBgScroll` (`$39:$4b13` / `$4b6d`) drive the
two-lane scrolling sprite band behind menus, alternating lanes each frame and
emitting a 10-sprite row through `QueueSpriteTemplate`.
`LoadIndexedPalette` (`$39:$457f`, `c` = palette data index, `b` = destination
slot) and `LoadFixedPaletteSet` (`$39:$4661`) are the shared palette loaders.

---

## 5. Sprites and OAM

### 5.1 Double-buffered shadow OAM

Two 160-byte shadow OAM buffers exist, at `$c000` (`wShadowOAM`) and `$c500`.
`wSpriteBufferPage` (`$c3a7`) holds the high byte of the page currently being
*built*; `AdvanceFrame` flips it each frame (`$00:$264b`) and VBlank patches the
DMA stub with the *other* page (`ld a,[wSpriteBufferPage] / xor $05 /
ldh [hOAMDMARoutine + 1], a`, `$00:$278e`). So one page is DMAed while the next
is filled. `hOAMDMARoutine` is the 10-byte stub copied into HRAM `$ff80` by
`CopyOAMDMARoutineToHRAM` (`$00:$06ac`).

`hSpriteQueueIndex` (`$ff9b`) is the write offset into the build page, capped at
`$a0` (40 entries × 4 bytes); every queue routine checks it and drops the sprite
when full. `hSpriteQueueBase` (`$ff9c`) is a floor: `ClearUnusedSprites`
(`$00:$1e22`) resets the index to the base and zeroes from there to `$a0`, so
entries below the base would persist across frames. In practice they never do —
`hSpriteQueueBase` is written in exactly two places, `ClearSpriteQueue`
(`$00:$1e20`, `xor a`) and an unlabelled three-instruction routine at
`$00:$1e50` that nothing calls. The feature is dead.

### 5.2 The builders

| routine | addr | emits |
|---|---|---|
| `QueueSprite` | `$00:$1f51` | one entry; `e` + `$0c` → Y, `d` + `$04` → X, `c` = tile, `b` = attribute |
| `QueueSprite16` | `$00:$1e55` | two entries forming a 16×16 metasprite: the second at X+8 with tile `c+2`. When attribute bit 5 (X-flip) is set the halves are emitted in the opposite order so the mirror is correct. |
| `QueueSpriteGrid` | `$00:$1f0d` | an `h` × `l` grid; applies the `+$10`/`+$08` OAM bias up front, steps X by 8 and tile by 2 per column, Y by `$10` per row |
| `QueueSpriteTemplate` | `$00:$1e9d` | walks an `oam_sprite` list, adding each record's `{dy, dx, tile, attr}` to the base in `e`/`d`/`c`/`b`; terminator is `dy == $80`. Mirrored variant (attribute bit 5) negates `dx` as `8 - dx` and ORs the attribute instead of adding it. |
| `QueueSprite24x32`, `QueueSprite32x32`, `QueueSpriteBlockPart` | `$00:$2c2b`, `$2eba`, `$2f2d` | fixed larger blocks, used by the court renderer |

`include/macros.inc:626` documents the `oam_sprite` record and the
`sprite_template` data spec that renders it; the spec appears in 21 banks.
Walk-sprite banks (`$6a`, `$6f`, `$70`-`$77`) hold object headers whose
`dw .frames, <name>_OamPtrs, .frames` triple points at a frame-pointer array and
an OAM-pointer array (e.g. `src/bank_072.asm:21`-`23`).

`PositionSpriteWorld` (`$00:$1f6b`) and `PositionSpriteWorld2` (`$00:$1fb1`) are
the world-space wrappers: subtract `wCameraX`/`wCameraY`, cull if the high byte
of the difference is out of range (`cp $16` for X, `cp $14`/`$13` for Y),
multiply by 8 and take the high byte — so one high-byte unit is 8 screen pixels
and a world unit is 1/32 pixel — then call `QueueSprite16` / `QueueSprite`.
`ProjectWorldToScreen` (`$00:$2f4a`) and `GetPerspectiveScale` (`$00:$3033`) are
the match court's perspective projection, outside this document's scope.

---

## 6. Palettes and fades

### 6.1 Shadow, master, dirty flags

Sixteen palettes of 8 bytes live in one contiguous array: `wBGPalettes`
(`$c100`, palettes 0-7) and `wOBJPalettes` (`$c140`, palettes 8-15). A second
copy, `wMasterPalettes` (`$c200`, 128 bytes), holds the *unfaded* colours.

`hPaletteDirtyFlags` (`$ff9d`): bit 0 = BG dirty, bit 1 = OBJ dirty.
`ApplyPendingPaletteUpdates` (`$00:$060d`) runs first thing in VBlank, uploads
whichever half is flagged via `LoadBGPaletteData` / `LoadOBJPaletteData`
(`$027f` / `$0287`), and clears the flags.

### 6.2 Loading

`LoadPaletteShadow` (`$00:$05b0`) is the entry every asset loader uses:

```
hl = source, d = first palette index (0-15), e = count in palettes
```

`LoadPalettesImmediate` (`$05b5`) writes each byte to *both* `$c1xx` and `$c2xx`
— live shadow and master together — then sets bit 0 of the dirty flags when
`d < 8` and bit 1 when `d + e >= 9`. If `hFadedOut` is set, `LoadPaletteShadow`
diverts to `LoadPalettesMasterOnly` (`$05e1`), which writes the master only, so
a palette loaded during a blackout does not pop on screen; the running fade will
pick it up. `RestorePalettesFromMaster` (`$00:$05f4`) copies all 128 bytes back
and forces both dirty bits.

### 6.3 Fades

State is three HRAM bytes: `hFadeState` (`$ffa2`, bit 0 = fading out, bit 1 =
fading in, bit 7 = the alternate curve), `hFadeSpeed` (`$ffa3`) and
`hFadeCounter` (`$ffa4`), plus the latch `hFadedOut` (`$ffbc`).

`BeginFadeOut` (`$00:$1d20`) and `BeginFadeIn` (`$00:$1d2e`) share a tail
(`.setSpeed`, `$1d3b`): both take the speed in `c` (0 is treated as 1), set
`hFadeCounter = $7c` and set/clear `hFadedOut`. Each is a no-op if the screen is
already in the target state. `ForceFadeIn` (`$00:$1d0c`) skips that guard.

`UpdateFadeOut` (`$00:$1d5e`) and `UpdateFadeIn` (`$00:$1d48`) run every VBlank
and converge on one body (`.step2`, `$1d76`): subtract the speed from the
counter, clamp at 0, derive a ramp value in `c`, then

```
hl = wMasterPalettes ; de = wBGPalettes ; b = $40 (64 colours) ; d = c >> 2
call AdjustColorsBrightness
hPaletteDirtyFlags = $03
```

`AdjustColorsBrightness` (`$00:$1cd9`) adds `d` to each of the three 5-bit
components with `AddClampColorComponent` (`$1ca0`), which clamps high at `$1f`
and treats a bit-7 result as 0. Fade-out uses `c = $7c - counter` (0 → 31) and
fade-in `c = counter` (31 → 0), and the delta is positive in both cases — so
**this game fades through white, not black**, and the fade ends when the counter
reaches 0, at which point `hFadeState` is cleared (`$1d97`). Total duration is
`$7c / speed` frames. Because the recomputation happens in VBlank *after*
`ApplyPendingPaletteUpdates`, each fade step reaches the hardware one frame
later.

Waiting: `WaitFadeEnd` (`$00:$1da4`) spins on `hFadeState`, advancing a frame
locally or, when `hLinkExchangeActive`, through `SyncLinkFrame`.
`WaitFadeEndLinked` (`$00:$1dbd`) is the same loop hard-wired to `SyncLinkFrame`
for the link case.

`ApplyWhiteFade` (`$00:$1dcc`) is a second, cheaper curve: it adds a per-channel
increment to the packed BGR555 word with `add`/`adc` and then repairs the
carries that leak across channel boundaries. It is reached only from the bit-7
branch at `$1d7a`, and bit 7 of `hFadeState` is set in exactly one place —
`$00:$1d19`, inside an **unlabelled and unreachable** routine at `$1d0f`. So
`ApplyWhiteFade` never runs in the shipped ROM.

`ConvertColorToGrayscale` (`$1d:$7210`) has a shipped bug — see
[bugs.md](bugs.md#grayscale-conversion-drops-the-blue-channel).

---

## 7. Text and windows

Bank `$05` is the text and window engine. Its `$4000` table
(`src/bank_005.asm:3`-`$4095`, 76 slots) is the whole public API; every other
bank reaches it by `farcall`.

### 7.1 A text id is a coordinate, not an address

`FetchDialogueText` (`$05:$5c18`) decodes the 16-bit id in `hl` as

```
bit 15      -> the string is in SRAM (player-entered names)
bits 13-10  -> which text bank
bits  9-0   -> string index within that bank
```

`DialogueTextFetchers_05` (`$05:$5c3b`, 16 records) maps the selector to a bank:
0-7 → `$30`-`$37`, 8 → `$6e`, 9 → `$1f`, 10 → `$25`, 11 → `$26`, 12 → `$5e`,
13-15 alias `$30`. So `$013f` is bank `$30`, index 319 — which is exactly how
`include/constants.inc` documents the pause-menu captions ("text id `$013f` + id
(bank `$30`, 319+id)").

Each text bank exports `FetchDialogueText_XX` / `FetchShortText_XX` over one
shared body. `FetchText_30` (`$30:$7d92`) indexes `FetchTextTable_30` (a word
offset table) by `index * 2`, adds `TextStrings_30`, and copies bytes until it
copies a `$00`:

- `a = 0` → `wTextBuffer` (`$c600`, 160 bytes)
- `a != 0` → `wShortTextBuffer` (`$d880`, 16 bytes)

On truncation it NUL-terminates and, in debug step mode, plays sound `$2c`.

`AddTextIdOffset` (`$05:$5d2b`) adds an offset to an id and **carries across
text banks**, using a 13-word table of per-bank string counts
(`AddTextIdOffsetWordLookupTable`, `$05:$5d99`), so ids form one flat sequence.

Tooling: `include/text_ids.inc` defines `Text_<bank>_<index> equ <raw id>` so
the assembled bytes are unchanged while the operand names its string;
`tools/disasmlib/textids.py` implements the same decode and finds sites by
walking *consumers* of `hl` (`TEXT_ID_SINKS` = `FetchDialogueText`,
`AddTextIdOffset`, `CreateWindowWithTextId`, grown through wrappers that forward
`hl` untouched); `tools/strings.py --index --bank XX` dumps `bank:index → text`
from the reader's own ROM.

### 7.2 The interpreter

`TextInterpreterLoop` (`$05:$4e5d`) is not a subroutine — it is the loop body of
`RenderTextString` (`$05:$4e23`), which falls into it. On entry `hl` is the
stream pointer (normally `wTextBuffer`) and `de` is a shadow-tilemap cell
pointer produced by `GetTilemapCellAddress` from `wTextCursorColumn` /
`wTextCursorRow`.

Per byte (`$4e75`-`$4ecd`):

- `$00` → end: flush the glyph row (unless `FLAG_TEXT_RENDER_ACTIVE`) and return.
- `$de` / `$df` → remapped to control codes `$1e` / `$1f`.
- `$0e` → latch **one inline operand byte** into `wTextCharNameArg`, then
  dispatch as code `$0e`. This is the only code with an operand.
- `< $20` → dispatch as a control code, then `RedrawActiveTextWindow`.
- `>= $20` → printable: `WrapTextCellPointer`, `DrawStreamGlyph`,
  `UploadLastGlyphTiles`, `DelayTextCharacter`, advance the cell with a `-$20`
  wrap at column 32.

It also returns early when `wTextPageBreakRequest` is set, saving `hl` into
`wTextResumePtr` — that is how a page break suspends and resumes mid-string.

Dispatch is a hand-rolled table, not `rst $00`: `DispatchControlCode`
(`$05:$546c`) pushes `ControlCodeDispatchReturn` as a fake return address,
indexes `ControlCodeHandlers_05` (`$05:$548f`, 32 records = codes `$00`-`$1f`)
by `a * 2`, and `jp hl`.

| code | handler | effect |
|---|---|---|
| `$00` | *(intercepted)* | **terminator** |
| `$01` | `TextCmdNewline` | `wTextCursorRow += 2` — the line pitch is two tilemap rows |
| `$02` | `TextCmdWaitButtonPage` | draw and blink the continue arrow (registered as a frame task), wait, then set `wTextPageBreakRequest` |
| `$03` | `WaitTextAdvanceInput` | flush the glyph row, wait for a button in mask `$f3`; skipped entirely under `FLAG_CUTSCENE_FAST_FORWARD` |
| `$04` | `TextCmdPrintArgString` | pop the string-argument queue → `wInlineTextBuffer` → `RenderInlineString` |
| `$05` | `TextCmdDelay30` | 30 frames, not skippable |
| `$06` | `TextCmdDelay15Skippable` | 15 frames, aborts on input |
| `$07` | `TextCmdPrintPlayerName` | `wStoryModeNameOfMainCharacter` |
| `$08` | `TextCmdNop2` | `ret` — but the *measuring* pass treats `$08` as a short-text argument (§7.4) |
| `$09` | `TextCmdPrintArgNumber` | pop the number queue → `RenderInlineNumber` |
| `$0a` | `TextCmdNop` | `ret` |
| `$0b` | `TextCmdPrintPartnerName` | `wStoryModeNameOfPartnerCharacter` |
| `$0c` | `TextCmdDelay150Skippable` | 150 frames, skippable |
| `$0d` | `TextCmdNextGlyphStreamRow` | advance the glyph write pointer by `$40` (two tilemap rows) |
| `$0e` | `TextCmdPrintShortText` | **+1 operand byte**: short-text id `$001b + operand` (the 27-entry character-roster bias) → `wInlineTextBuffer` |
| `$0f`, `$14`-`$1d` | `TextCmdNewline` | eleven aliases |
| `$10`-`$13` | `ControlCodeHandler16`-`19` | four separate bare `ret`s |
| `$1e` (`$de`) | `TextCmdApplyDakuten` | rewrites the *previous* cell to add a voiced-sound mark |
| `$1f` (`$df`) | `TextCmdApplyHandakuten` | ditto for the semi-voiced mark |

Two further 32-entry tables in the same bank reuse `DispatchControlCode` for
different targets: `ProportionalTextCodeHandlers_05` (`$05:$5e39`, driven by
`RenderProportionalTextAt` — a text id rendered at an arbitrary cell with no
window and no delays) and `TextControlCodeHandlers_05` (`$05:$5f94`, driven by
`RenderTextToBuffer64`, which stores characters into a 64-column buffer instead
of rasterising).

### 7.3 Glyphs are rasterised at run time

There is no charmap: `DrawGlyph` (`$05:$7322`) does `sub $20` and indexes
`FontGlyphs` (`$05:$7920`, 1632 bytes = 102 records of 16 bytes, one 8×8 2bpp
tile each). `GlyphWidths_05` (`$05:$7f80`, 96 bytes) gives a proportional pixel
width of 3-8 per character.

Glyphs are composed into `wGlyphTileBuffer` (2048 bytes = 128 tiles, WRAM bank
`$07`) and uploaded to VRAM `$8800`+ as the text reveals. `PlotGlyphRow`
(`$05:$737a`) shifts each font byte right by `pen & 7` and ORs the two halves
into adjacent tiles, which is what makes proportional spacing straddle cell
boundaries; `wGlyphPenX` (`$c3b7`) is the fixed-point pen, `$80` per whole cell.
`StampGlyphTileAtPen` (`$05:$5f0d`) writes tile id `(pen >> 7) + $80` into the
shadow tilemap, skipping cells that already hold `$06` (the right border).

So a window's interior text cells hold tile ids `$80 + column`
(`DrawTextWindowFrame`, `$05:$6fc1`), and the engine keeps rewriting the VRAM
tiles under them. Upload paths: `UploadLastGlyphTiles` (`$05:$7607`, the
typewriter — just the 2 tiles at the pen), `UploadGlyphTileRange` (`$05:$78ad`),
`UploadGlyphBufferFull` (`$05:$742c`, five 16-tile pages with `AdvanceFrame`
between them), `FlushGlyphRow` (`$05:$77a3`, queued or DMA depending on the LCD).

`DelayTextCharacter` (`$05:$579b`) is the per-character delay and blip. Message
speed reaches it like this:

1. The pause-menu items `STORYMENUITEM_MSG_SLOW`/`NORMAL`/`FAST`
   (`include/constants.inc:169`) are handled by `StoryPauseMenu_MessageSpeed`
   (`$06:$6ff7`), which stores `2 - selection` into `wMessageSpeed` (`$c8a4`;
   0 = fast, 1 = normal, 2 = slow, bit 7 = a transient "instant" override).
2. `ApplyMessageSpeed` (`$05:$57e7`) converts it to a frame count in
   `wTextRedrawGuard`: bit 7 or 0 → 0, 1 → 2, else 4.
3. `DelayTextCharacter` waits that many frames, aborting on input.
4. `UploadLastGlyphTiles` and `FlushGlyphRow` additionally *skip* the
   incremental 2-tile upload on fast/instant (`$05:$7621`, `$77af`), which is
   what makes FAST genuinely instant rather than merely zero-delay.

`wTextRedrawGuard` is dual-purpose: the wait and delay commands also use it as a
re-entrancy guard ("if 0, set to 1, redraw, clear"), so on FAST those commands
perform an extra redraw that NORMAL and SLOW skip.

### 7.4 The three text-argument queues

All in WRAM bank `$05`, all 16 entries, all reset together at every dialogue
entry point (`ShowSpeakerDialogue`, `$05:$582c`-`$583e`).

| queue | addr | element | pushed by | consumed by |
|---|---|---|---|---|
| `wTextArgStringQueue` | `$d8b0` | 2-byte pointer, high nibble = WRAM bank tag | `PushTextArgString` (`$05:$50f7`) | code `$04` |
| `wTextArgNumberQueue` | `$d8d0` | 2-byte value | `PushTextArgNumber` (`$05:$5147`) | code `$09` |
| `wTextArgShortTextQueue` | `$d8f0` | 1-byte short-text id | `PushTextArgShortTextId` (`$05:$517a`) | **nobody** — code `$08` is a `ret` |

Each has three cursors: a write index, a count, and a separate *measure* index.
That is because `FitWindowToText` / `MeasureTextDimensions` walk the whole
message to size the window before a glyph is drawn, then the render pass walks it
again — two independent readers over a write-once array.

The string queue's pointer encoding is worth knowing: if the pointer's high
nibble is `$d` (banked WRAM), `PushTextArgString` packs the current
`hWramBank` into the top nibble, and code `$04` unpacks it before copying 32
bytes into `wInlineTextBuffer` (`$c6c0`).

Character names do not come through the queues — codes `$07`/`$0b` read the name
buffers directly, and code `$0e` resolves `$001b + operand` against the roster.

### 7.5 Windows

`wWindowSlotMask` (`$dc70`) is one bit per slot. `AllocWindowId` (`$05:$6e96`)
scans **bits 0-6 only**, claims the first clear bit, and returns the index or
`$ff` when full — so ids `0`-`6` are allocatable and struct 7 is unreachable
through the allocator. `FreeWindow` (`$05:$6eba`) zeroes the record and clears
the bit.

`wWindowStructs` (`$dc00`) is 64 bytes = eight 8-byte records, addressed by
`GetWindowStructPtr` (`$05:$6eea`, `id & $07`, `<< 3`):

| off | field | evidence |
|---|---|---|
| `+$00` | column (`and $1f`) | `SetWindowRect`, `$05:$4538` |
| `+$01` | row (`and $1f`) | same |
| `+$02` | **width** in cells | see the note below |
| `+$03` | **height** in cells | see the note below |
| `+$04` | state | `SetWindowState` / `GetWindowState` (`$05:$4767` / `$4773`); `$02` = plain menu, `$03` = paged menu, `$ff` = do not draw. Bit 1 also indents the text one extra column (`$05:$620a`). |
| `+$05` | *not established* — no reader or writer found |
| `+$06`/`+$07` | text id lo/hi | `SetWindowTextId` (`$05:$55d5`); `$03` in the high byte is the "no text" sentinel |

> The width/height assignment above contradicts the note currently on
> `wWindowStructs` in `ram_unions.json` and the names
> `wDialogueWindowHeight`/`wDialogueWindowWidth`. Three independent proofs that
> `+$02` is the width: `ResetScreenAndTextWindows` builds the bottom text box
> with `b = $14, c = $03` (`$39:$4c27`) — 20 cannot be a row count on an
> 18-row screen; `DrawTextWindowFrame` copies `+$02` into `e` and uses it as the
> horizontal run length while `+$03` becomes the row counter
> (`$05:$6f80`-`$6fae`); and `InitGlyphStreamForWindow` reads `+$02`, subtracts
> 2, and stores it into `wTextRowWidth` (`$05:$7559`-`$756e`). See the report in
> §10.

Creation entry points, all funnelling into `AllocWindowStruct` (`$05:$6e6d`):

| routine | addr | adds |
|---|---|---|
| `CreateWindowFromScreenRect` | `$05:$6e45` | `PrepareGlyphBuffer`, then `GetScreenTopLeftCell` (`$05:$464b`) turns `hScrollX`/`hScrollY` into a cell origin so `de` is *screen*-relative |
| `CreateWindow` | `$05:$4684` | thin alias |
| `CreateWindowWithAttr` | `$05:$4664` | parks a CGB attribute byte in `wWindowTileAttr` for the duration |
| `CreateDialogueWindow` | `$05:$4688` | also caches `wDialogueWindow{Id,Col,Row}` and the two size bytes |
| `CreateMenuWindowFromText` | `$05:$46b0` | fetches the text, measures it, derives the size, and pushes a menu-stack frame |
| `CreateMenuWindowPaged` | `$05:$4747` | the same plus state `$03` |

`DrawTextWindowFrame` (`$05:$6f70`) draws the box into the shadow tilemap at
`wShadowTilemapPtr + row * 32 + col`, using the tile ids in §3.3, alternating
interior rows between blanks and glyph-tile rows (`bit 0, d` at `$6ff3` — the
two-row line pitch again), and then repeats the whole rectangle at `+$0400`
writing `wWindowTileAttr` into every attribute cell. Every cell step passes
through `WrapCellPtrToRowStart` / `ClampCellPtrToShadowMap`, so a window may wrap
around the 32×32 plane. Nothing here touches VRAM.

`ResetTextWindowState` (`$05:$6e09`) is the cold init: it clears `$d000`-`$dfff`
in WRAM bank `$05` (which wipes the struct array, the dirty flags and the slot
mask), points `wShadowTilemapPtr`/`Bank` at `$d000`/`$05`, and sets
`wWindowTileAttr = $80`, `wDialogueWindowId = $ff`, `wMenuWindowId = $fe`.

### 7.6 Window → VRAM: dirty row runs

The text engine does not re-blit the screen. `MarkWindowRowsDirty` (`$05:$7096`)
and `SetRowDirtyFlags` (`$05:$70aa`) clear `wTilemapRowDirty` (`$dc40`, 32
bytes, one flag per row) and then mark the `e` rows starting at `d`, wrapping at
32 — a *replace*, not an accumulate. `BuildDirtyRowRuns` (`$05:$71c4`) folds
that into `wTilemapRowRuns` (`$dc60`, 16 bytes) as `(first row, length)` pairs
terminated by `$ff`, **capping each run at 7 rows** (`cp $07`, `$71f0`) so one
copy fits a VBlank. `FlushDirtyRowsPerFrame` (`$05:$711a`) walks the runs,
copying each through `CopyDirtyRowSpanToVRAM` — tiles from `wShadowTilemapPtr`
to `$9800`, attributes from `+$0400` to `$9800 + VRAM_BANK1` — and calling
`AdvanceFrame` between runs while the LCD is on. `FlushDirtyRowsNow`
(`$05:$7148`) is the same without the waits. `FLAG_VRAM_UPDATE_BUSY`
(`include/flag_constants.inc:13`) is held for the duration.

### 7.7 Menus over windows

`RunMenuSelection` (`$05:$477f`) and `RunMenuSelectionShared` (`$05:$4b17`) run
the cursor loop over a text-derived menu window and return:

| return | meaning |
|---|---|
| `< $7f` | the row picked |
| `$fe` | page left |
| `$ff` | cancel (B or START) |
| other | page right |

A "paged text menu" is a menu whose items are consecutive text ids, four per
page. `RunPagedTextMenu` (`$05:$4944`) takes `hl` = base text id, `de` = window
column/row, `a` = page count, and returns `wMenuPage * 4 + row` or `$ff`
(caller example: `$10:$4088`, `ld hl,$0484 / ld de,$0101 / ld a,$05`).
`RunPagedTextMenuAutoSize` (`$05:$49f6`) re-derives the column per page and
registers `PagedMenuFrameTask` — and has no callers.

`wMenuStack` (`$d832`, six 2-byte frames of
`[rowCount << 4 | cursorRow, windowId]`) plus `wMenuDepth` (`$d83e`) let nested
menus restore their cursor: `CreateMenuWindowFromText` writes the outgoing
menu's `wMenuCursorRow` into the current frame before pushing a new one
(`$05:$4707`-`$4738`).

Bank `$1a` is the shared layer above this — the pause menus. `RunPauseMenuWindow`
(`$1a:$402c`) shows the whole idiom:

```
wram_bank $05
farcall CreateMenuWindowFromText      ; -> wPauseMenuWindowId
set_flag FLAG_VRAM_UPDATE_BUSY
farcall RestoreShadowTilemap / RenderMenuWindowText
clear_flag FLAG_VRAM_UPDATE_BUSY
.menuLoop:
  DrawPauseMenuSettingValues
  farcall RunMenuSelectionShared
  ... test wMenuKeepOpenRowMask bit for the chosen row ...
  farcall CloseWindow                 ; unless the row is marked keep-open
```

`wMenuKeepOpenRowMask` (`$cb29`) is a per-row bitmask (bit 7 = present, rotated
by the row index) of rows that must not close the window — the mechanism behind
setting rows that stay put after a change. The menu contents themselves are
`menu_def` records (`include/macros.inc:599`): four item ids plus a count the
macro derives from its own argument list, so a menu cannot disagree with its
own length. Item ids are the `MATCHMENUITEM_*` / `STORYMENUITEM_*` constants,
which simultaneously index the item's word art, its 3×2 label rect, and its
caption text id.

### 7.8 The other, unrelated font

ROM0 carries a second, independent text renderer used for numbers and debug
output. `NumberFontGlyphPtrs` (`$00:$2091`) is 16 pointers to `font_glyph`
records — `db width, height` then 2bpp rows. `RenderGlyphToTiles`
(`$00:$211b`) is a true per-pixel 2bpp blitter: it takes a pixel X in `b`, a
row offset in `c` and a tile-strip base in `de`, builds a destination bit mask
from `PixelMaskTable` (`$00:$2113`), and consumes two source bits per iteration
to write both bitplanes. `RenderTextToTiles` (`$00:$20e5`) walks a NUL-terminated
ASCII string, treats any byte below `$30` as a 6-pixel space, and advances by
each glyph's own width — a proportional number font. `PrintString` (`$00:$1bd8`),
`FormatHexWord` (`$00:$1935`), `FormatDecimalNumber` (`$00:$1961`) and
`CopyTextString` (`$00:$2aa6`) round out the debug text path, which draws into
`wDebugTextBuffer` (`$cc00`) for the `$9c00`-page console.

`RenderProportionalMenuText` (`$00:$2a9e`) is *not* part of this — it is a
one-line thunk that forwards to bank `$05`'s `RenderProportionalTextAt` with
`c = $11`.

---

## 8. Anatomy of a screen

### 8.1 Entering and leaving

The transition idiom, with a worked example at `$10:$4f58`-`$4f79`:

```
    ld c, $7f
    call BeginFadeOut
    call WaitFadeEnd
    call DisableLCDSafely
    farcall LoadMenuFontGfx
    farcall ResetScreenAndTextWindows     ; a must be 0 on entry
    call EnableLCD
    script_fade_in $10                    ; ld c,$10 / call BeginFadeIn
    call WaitFadeEnd
.menuLoop:
    ... reset the screen's cursors and camera, ResumeBGM, InitSerialLink ...
    farcall RunMainMenu                   ; returns a selection, $ff = back
    cp $ff
    jp z, .titleScreen
    ... index a dw handler table by a, jp hl ...
```

Fading out before turning the LCD off, and in after turning it back on, is what
hides the rebuild. Everything heavy — tile uploads, tilemap decompression,
full-map blits — happens in the LCD-off window, where `QueueVRAMCopy` transfers
immediately instead of queueing.

`ResetScreenAndTextWindows` (`$39:$4bf3`) is the shared reset, and reading it
end to end is the fastest way to see how the pieces bind:

1. zero `hScrollX`/`hScrollY` and `wCameraX`/`wCameraY` (from `a`, which the
   caller must have cleared);
2. `LoadStadiumBgGraphics`;
3. `ResetTextWindowState` (bank `$05`, §7.5);
4. `LoadCompressedTileBlock(b = $11, c = $10, de = $9000)` — the menu font;
5. `wram_bank $05`, then `wShadowTilemapBank = $03` and `wWindowTileAttr = $00`
   — **this is the line that points the window engine at the screen's own
   tilemap** rather than bank `$05`'s;
6. `CreateWindowFromScreenRect(d = 0, e = $0f, b = $14, c = $03)` — a 20×3
   window at row 15, i.e. the bottom text box;
7. `DrawTextWindowFrame`, `RedrawWindowRows`, `QueueWram3MapToVRAM`.

### 8.2 The menu tree pattern

Banks `$0e`-`$15` are story-mode screen banks sharing one structure, described
in full in `include/macros.inc:132`-`155` for the story-map case. A location or
screen owns a **7-slot `dw` tree**; a bank-level directory at `$4000` may point
at several trees (`$0f` has three, `$14` four). Slot roles for the story-map
trees are: 0 entry points, 1 exit triggers, 2 actors, 3 NPC scripts, 4 facing
scripts, 5 tile triggers, 6 an init-code entry. Slots with no table point at a
shared `$ff`.

The menu-screen variant uses the same 7-slot shape with 8-byte handler records
`{id, $ff, $00, $00, dw handler, db, db}` terminated by `$ff`, and 14-byte entry
records whose word at `+$02` points into the bank's resource-descriptor blob.
Dispatch is computed inline:

```
ld a, [$c2b0] / add a, a / add a, LOW(table) / ld l, a
adc a, HIGH(table) / sub l / ld h, a / ld a, [hl+] ...
```

with the `dw` table sitting immediately after the function's `ret`.

Bank `$10` (story match select) is the worked example. Its `$4000` table is an
8-slot directory of sub-tables; slot 0 (`$4010`) is a 7-entry `dw` table plus
`MatchSelectRecords_10`, and entry 3 leads to `MatchSelectHandlerTable_10`
(`$10:$4145`), a 9-record table of `{db id, $ff, dw $0000, dw handler,
dw $0000}` whose handlers are all carved. One of them,
`LoadMatchSinglesJunior3Alias`, is named for what it does rather than its
caption because slot 8 launches the wrong match — see
[bugs.md](bugs.md#match-select-slot-8-launches-the-wrong-match).

### 8.3 Cursor movement

The wrap-and-clamp step is one idiom, repeated everywhere:

```
    inc a           ; or dec a
    add a           ; carry iff the value was >= $80, i.e. it went negative
    jr nc, .check
    ld a, c / dec a ; wrapped below 0 -> last item
.check:
    rra             ; undo the doubling
    cp c
    jr c, .done
    xor a           ; wrapped past the end -> first item
```

ROM0 provides it as `MoveCursorHorizontal` (`$00:$2c0d`) and
`MoveCursorVertical` (`$00:$2c04`) — `a` = current index, `b` = pad bits,
`c` = item count, result in `a`. `MoveCursorVertical` tests UP/DOWN and jumps
into the horizontal routine's tail, so the two share the arithmetic. Only bank
`$06` calls them (7 sites).

Every other screen bank inlines a 2-D version instead, and there are **five
copies in the ROM, four variants each** (bank `$1b` has two of the four). The
bodies are the same 2-D walker over `wMenuCursorX`/`wMenuCursorY` with `b` =
column count and `c` = row count, processing at most one direction per call
(right > left > up > down) and returning `a = 1` if the cursor moved. What
differs is only the input source and which cursor pair is written:

| bank | local pad (`wMenuInputPressed`) | link frame (`hLinkInput`) | remote, cursor 1 | remote, cursor 2 |
|---|---|---|---|---|
| `$16` | `MoveMenuCursorGrid_16` `$40cd` | `MoveMenuCursorGridFromLinkInput_16` `$414b` | `MoveMenuCursorGridRemote_16` `$41d5` | `MoveMenuCursor2GridRemote_16` `$42a0` |
| `$1b` | `MoveMenuCursorGrid` `$4107` | — | — | `MoveMenuCursor2GridRemote_1b` `$42da` |
| `$38` | `MoveMenuCursorBox` `$410a` | `MoveMenuCursorBoxLink` `$4188` | `MoveMenuCursorBoxRemote_38` `$4212` | `MoveMenuCursor2GridRemote_38` `$42dd` |
| `$3b` | `MoveMenuCursor` `$412a` | `MoveMenuCursorRepeat` `$41a8` | `MoveMenuCursorLinkLocal` `$4225` | `MoveMenuCursorLinkRemote` `$42f0` |
| `$3e` | `MoveMenuCursorGrid_3e` `$413a` | `MoveMenuCursorGridFromLinkInput_3e` `$41b8` | `MoveMenuCursorGridRemote_3e` `$4242` | `MoveMenuCursor2GridRemote_3e` `$430d` |

The "remote" variants choose between `hLinkRemoteInputBuf` and
`hLinkRemoteInput` at run time on `hLinkState == $02` (e.g. `$38:$421a`,
`$3b:$422d`), and the cursor-2 variants operate on `wMenuCursor2X`/`Y`. The
naming is not consistent across the five banks; see §10.

Bank `$39` also carries a bespoke 3×2 walker, `MoveMinigameGridCursor`
(`$39:$6df9`), whose second row is a two-position toggle rather than a 3-wide
wrap, and `FillMenuGridCellTile` (`$39:$6dc2`) which fills that grid's 3×3
attribute cell from `FillMenuGridCellTileTable`.

`wMenuCursorLockFlags` (`$cb08`) bits 0 and 1 freeze the primary and secondary
cursors, which is how a confirmed selection stops responding while the
confirmation runs.

### 8.4 Confirm dialogs

The reusable path is a menu window over a text id: `CreateMenuWindowFromText`
with the prompt's text id, then `RunMenuSelectionShared`, then `CloseWindow`
(§7.7). Bank `$18` has a hand-built alternative: `InitConfirmScreen` builds the
box, font, cursor and score panel, and `DrawYesNoLabels` writes two 3×2 tile
words plus their attribute rows into fixed cells, with prompts at text ids
`$046a`/`$046b`/`$046d`/`$0471` (bank `$31`, indices 106/107/109/113 — "Erase?",
"Erase it? Really?", "Continue?", "Is this correct?").

---

## 9. Shared state

Only the framework-wide state is listed; [ram_map.md](ram_map.md) is
authoritative and covers the rest.

### HRAM

| addr | symbol | role |
|---|---|---|
| `$ff80` | `hOAMDMARoutine` | 10-byte OAM DMA stub; `+1` is the source page |
| `$ff8a`/`$ff8b` | `hScrollY` / `hScrollX` | applied to `rSCY`/`rSCX` in VBlank |
| `$ff8c`/`$ff8d` | `hVBlankCounter` / `hVBlankOccurred` | frame counter; the barrier flag |
| `$ff8f` | `hFrameTasksReady` | 0 while `wFrameTasks` is being mutated |
| `$ff90`/`$ff91`/`$ff94` | `hPlayerInputFlags` / `hInputPressed` / `hInputRisingEdge` | held / auto-repeat / newly pressed |
| `$ff92`/`$ff93`/`$ffa6` | `hInputRepeatButtons` / `hInputRepeatTimer` / `hInputRepeatDelay` | repeat state |
| `$ff95`/`$ff96`/`$ff97` | `hRomBank` / `hWramBank` / `hSramBank` | bank shadows; every helper saves and restores these |
| `$ff98` | `hShowDebugConsole` | 1 → render the `$9c00` page at `SCY = $40` |
| `$ff99` | `hVRAMQueueDirty` | copies pending; also set on overflow |
| `$ff9b`/`$ff9c` | `hSpriteQueueIndex` / `hSpriteQueueBase` | OAM write offset; unused floor |
| `$ff9d` | `hPaletteDirtyFlags` | bit 0 BG, bit 1 OBJ |
| `$ff9e`/`$ff9a` | `hDebugStepMode` / `hDebugStepPaused` | single-stepper |
| `$ffa0`/`$ffa1` | `hPeakLY` / `hPeakLYFrames` | CPU load meter |
| `$ffa2`-`$ffa4`, `$ffbc` | `hFadeState`, `hFadeSpeed`, `hFadeCounter`, `hFadedOut` | fade engine |
| `$ffb8`-`$ffba` | `hBGRowBlitPending`, `hBGColumnBlitPending`, `hBGColumnBlitDone` | §2.4 |

### WRAM bank 0

| addr | symbol | role |
|---|---|---|
| `$c000` | `wShadowOAM` | OAM shadow page A (160 bytes) |
| `$c500` | *(unnamed)* | OAM shadow page B |
| `$c0a0` | `wVRAMCopyQueue` | 10 × 8 bytes |
| `$c100`/`$c140` | `wBGPalettes` / `wOBJPalettes` | live palette shadow |
| `$c180` | `wTileWriteQueue` | 16 × 4 bytes |
| `$c1c0` | `wFrameTasks` | 16 × 4 bytes |
| `$c200` | `wMasterPalettes` | unfaded copy (128 bytes) |
| `$c300`/`$c340` | `wBGRowBlitAttrs` / `wBGRowBlitTiles` | row stage |
| `$c380`/`$c3c0` | `wBGColumnBlitAttrs` / `wBGColumnBlitTiles` | column stage |
| `$c320`/`$c322` | `wCameraX` / `wCameraY` | scroll-buffer camera |
| `$c326`/`$c328` | `wBGRowBlitDest` / `wBGColumnBlitX` | blit targets |
| `$c3a0`-`$c3a6` | `wDeferredTilemap*` | deferred copy record |
| `$c3a7` | `wSpriteBufferPage` | OAM build page high byte |
| `$c3b2` | `wWindowFrameAttr` | attribute for ROM0 window frames |
| `$c3b3`/`$c3b4` | `wShadowTilemapBank` / `wShadowTilemapPtr` | the live tilemap base |
| `$c3b6`/`$c3b7` | `wWindowTileAttr` / `wGlyphPenX` | glyph attribute; pen |
| `$c363`-`$c369` | `wScreenShakeMagnitude`, `wScreenShakeOffsetX/Y` | screen shake |
| `$c600`/`$c6c0` | `wTextBuffer` / `wInlineTextBuffer` | 160-byte and 32-byte string buffers |
| `$cb01`-`$cb03` | `wRasterScrollX`, `wRasterScrollStartLY`, `wRasterScrollEndLY` | LCD-STAT split scroll |
| `$cb04`-`$cb08` | `wMenuCursorX/Y`, `wMenuCursor2X/Y`, `wMenuCursorLockFlags` | menu cursors |
| `$cb0d` | `wMenuInputPressed` | per-loop input snapshot |
| `$cc00` | `wDebugTextBuffer` | debug console tilemap (576 bytes) |

### Banked WRAM

`ram_unions.json` scopes these; `docs/ram_map.md` and
`include/ram_mirrored.inc` carry the detail.

| bank | `$d000` | `$d400` | `$d800`+ |
|---|---|---|---|
| `$01` | `wDecompBuffer` (2048 bytes — everything decompresses here) | | |
| `$02` | `wScreenAttrmap` / `wCourtTilemap` / `wMapScrollPlane0` | `wCourtAttrmap` | `wMapScrollPlane1`, `wCourtTilemapSaved` |
| `$03` | `wShadowTilemap` | `wShadowAttrmap` | `wScreenScratch` |
| `$05` | `wWindowShadowTilemap` | `wWindowShadowAttrmap` | text/window engine state, `wWindowStructs` `$dc00`, `wTilemapRowDirty` `$dc40`, `wTilemapRowRuns` `$dc60`, `wWindowSlotMask` `$dc70` |
| `$07` | | | `wGlyphTileBuffer` (2048 bytes) |

### Framework flags

From `include/flag_constants.inc` (bits of `wGameFlags`, `$c9c0`):
`FLAG_VRAM_UPDATE_BUSY` (24), `FLAG_TEXT_WAITING_FOR_BUTTON` (25),
`FLAG_TEXT_RENDER_ACTIVE` (35), `FLAG_PROPORTIONAL_TEXT_MODE` (36),
`FLAG_CUTSCENE_FAST_FORWARD` (22), `FLAG_PAUSE_OPTIONS_MENU_OPEN` (48),
`FLAG_MINIGAME_PAUSE_MENU_OPEN` (49), and the debug flags
`FLAG_DEBUG_STATIC_TEXT_WINDOW` (27), `FLAG_DEBUG_FREEZE_TILE_ANIM` (26),
`FLAG_DEBUG_SHORT_GLYPH_UPLOAD` (34).

---

## 10. Boot, and loose ends in this area

### The boot path

`EntryPoint` → `Start` (`$00:$2578`, which records `hIsCGB`) → `SoftReset`
(`$00:$2582`). `SoftReset` re-initialises the stack, LCD, HRAM, VRAM, the OAM
DMA stub, the sound engine and the serial link, sets `wSpriteBufferPage = $c0`,
and ends with `farcall RunDebugTestMenu` (`$00:$262c`); the `stop` that follows
is unreachable because that call never returns.

`RunDebugTestMenu` (`$01:$4018`) clears every WRAM bank in turn, loads the
shared menu font and OBJ palettes, validates and repairs SRAM, initialises story
and match state, enables the LCD, fades in, and calls
`farcall RunStoryModeOverworld` with `wStoryModeCurrentLocation = 0` and
`wStoryModeEntryPoint = $0a` (`$01:$40a5`-`$40af`). Only if that returns does the
build-stamp screen at `.loopB` (`$01:$40b2`) appear, which waits for A or START
and re-enters the overworld. So the routine is the game's boot manager first and
a debug harness second.

### Things this document could not establish

- Window struct field `+$05`: no reader or writer found in bank `$05`.
- `wShadowTilemapReadOffset` (`$dc76`) is read by
  `RefreshShadowTilemapFromMapBuffer` and never written, so it stays 0.
- Whether `ControlCodeHandler16`-`19` (codes `$10`-`$13`) were ever meaningful.
  They are four *separate* one-byte `ret`s, which is suggestive of deleted
  handlers, but nothing proves it.
- How the `or $80` on `wMessageSpeed` at `$1a:$427c`/`$4295` interacts with
  `ApplyMessageSpeed`'s "bit 7 = instant" reading. `RestoreMessageSpeed`
  exists, but no call ordering was traced that guarantees the bit is cleared.
- What raises `wGlyphBufferHoldCount`: `PrepareGlyphBuffer` and
  `DrawTileAttrRect` read and decrement it, but no site in bank `$05`
  increments it.
- `LoadScreenAssetRecord` sends both its tile copies to VRAM bank 1 (`$9000`
  and `$8800`, `$39:$40a3`/`$40ae`). That is what the code says; why the shared
  font/tile area lives in bank 1 rather than bank 0 was not established.

### Dead framework code, for the record

Not defects, and not in [bugs.md](bugs.md); recorded here so a future reader
does not re-derive them.

- `ApplyWhiteFade` (`$00:$1dcc`) is unreachable: the only write that sets
  `hFadeState` bit 7 is at `$00:$1d19`, inside an unlabelled routine at
  `$1d0f` that nothing calls. The unlabelled `ForceFadeOut`-shaped entry at
  `$1d09` is likewise unreferenced.
- The persistent-sprite floor `hSpriteQueueBase` is only ever set to 0; the
  routine that would raise it (`$00:$1e50`) has no callers.
- `AllocWindowSlotBit` (`$05:$4627`) is a byte-identical duplicate of the live
  `AllocWindowId` (`$05:$6e96`) with no callers.
- `DrawWindowGlyphRun` (`$05:$74de`) has no callers and is not in the `$4000`
  table; its use of `b`/`c` reads as a fragment of an earlier design. The live
  per-window glyph path is `InitGlyphStreamForWindow` → `DrawStreamGlyph` →
  `StampGlyphTileAtPen` → `FlushGlyphRow`.
- `RunPagedTextMenuAutoSize` (`$05:$49f6`) has no callers, which is why nobody
  noticed that the frame task it registers, `PagedMenuFrameTask`, has an empty
  body (see [bugs.md](bugs.md)).
- `PushTextArgShortTextId` (`$05:$517a`) has no callers and control code `$08`
  is a `ret`, so the short-text argument queue is write-never/read-never; only
  the measuring pass would consume it.
- Control codes `$05` and `$08` never appear in any string in `data/*/text_pool_*.asm`.
- `CopyMapToScrollBuffers` (`$00:$086c`) expands two of its four map planes and
  then immediately clears the region it wrote (`$08b3`, `$08fb`).
- The queue-compaction tail at `$00:$0595`-`$05ae` sits after a `ret` and is
  unreachable.
