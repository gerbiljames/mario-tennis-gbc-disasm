# Bugs and dead code in the shipped game

Defects in Mario Tennis (GBC) itself, as distinct from mistakes in this
disassembly. Everything here is in the released cartridge and reproduces from
`baserom.gbc`.

A disassembly finds these for free — a routine that reads a byte nothing writes,
or writes one nothing reads, is obvious once every reference to an address can be
listed. It is worth separating three things that all *look* like defects, because
only the first is one:

* **Bugs** — the code does something other than what it plainly intends.
* **Dead stores** — a value is written and never read. Harmless, but usually the
  fossil of an edit, and occasionally the visible half of a bug.
* **Routines that return before their body** — a `ret` at the top of a called
  routine. The effect is observable; whether it was written as configuration or
  left behind by an edit generally is not, so they are recorded rather than
  judged.

A bug with a **Fix** paragraph is fixed in `make FIXES=1`, which builds
`mariotennis-fixes.gbc` from the `IF DEF(FIXES)` blocks in the source. Played
against the original by the event test over every story state and, on
2026-10-03, every targeted session, story handler and nine main-menu sessions,
it differs only where a fix applies (the damaged-save target, the slot-8 match,
the awards ceremony) and crashes only where the original does (Test2). The rest
are left as they are: the fix would change behaviour nobody has checked
(`GetActorStateAddr`'s guards), the intended values are not known (the
Courtyard walk-in table, the map-edge clamp, the glyph pen's range), or the
defect does nothing (the over-reads and dead stores).

## Bugs

### Grayscale conversion drops the blue channel

`ConvertColorToGrayscale` (bank `$1d`, `$7210`) splits a CGB colour into its
three components, then averages them:

```
        ld a, e / and $1f            ; red
        ld [wDecompBuffer], a
        ...                          ; green
        ld [wDecompBuffer + 1], a
        ld a, d / and $7c / rrca / rrca   ; blue
        ld [rRAMG + 2], a            ; <- should be [$d002]
        ld a, [wDecompBuffer]
        ld hl, wDecompBuffer + 1
        add [hl]
        inc hl                       ; -> $d002
        add [hl]
        srl a
```

The blue component is stored to `$0002` instead of `$d002` — a `d` dropped in the
original source. `$d002` is never written, so the average is red plus green plus
whatever the byte happened to hold, and every grayscale palette the routine
produces is wrong.

The stray write is not inert, though it is harmless in practice: `$0000-$1fff`
is the MBC5 cartridge-RAM gate, so the write sets the gate to the blue value's
low nibble (usually disabling SRAM, since only `$xa` enables it). Nothing breaks
because the save engine in bank `$03` always re-enables SRAM before touching it.

Recorded earlier in the 2026-07-17 naming pass (round 4),
which called the write a no-op; it is a RAM-gate write whose *effect* is benign. It renders as
`ld [rRAMG + 2], a` since the MBC registers were named, which makes it visibly
wrong rather than looking like an ordinary store to a low address.

It is not the routine's only fault. Green's top two bits come from `d & 3`
shifted left *twice*, landing on bits 2-3 where they overlap the three low
bits instead of bits 3-4, so green never exceeds 15. And the "average" is
`srl a` -- the sum halved, not divided by three -- masked to five bits, so
restoring the blue store alone would make white (31, 31, 31) come out as
(31 + 15 + 31) / 2 = 38, masked to 6: dark grey. Run in the emulator on the shipped
routine, white gives 23, pure red 15, pure green 7 and pure blue 0. A fix
that holds needs all three changes: the store to `$d002`, a third `rlca` for
green, and a weighting that cannot overflow -- `(r + 2g + b) / 4`, green
added twice and the sum shifted right twice, which keeps white at 31 and
every grey at itself.

**Fix** (`make FIXES=1`): blue is stored to `wDecompBuffer + 2`, green's
high bits get the third `rlca`, and the average is `(r + 2g + b) / 4` -- green
added twice, the sum shifted right twice -- so white stays 31 and every grey
stays itself.

### The save mirror re-check compares the wrong signature

The header region `$a000-$a7ff` is mirrored into SRAM bank 1 after every write.
On boot `ValidateSaveRam` (bank `$03`) checks the signature and master checksum;
on failure it restores bank 1's mirror and re-checks — but the re-check compares
the signature at `$a000` instead of `$a020`, so it always fails.

The recovery path is therefore dead: a corrupt header always falls through to a
full wipe and re-init, and the mirror it just restored is discarded. See
`docs/save_format.md`.

The mirror is spoiled before the check even runs. The first thing
`InitAndRunGame` does after `call InitSerialLink` is `ClearSaveFlag SAVEFLAG_DEBUG_TEST_MENU` (`$01:$401f`),
ahead of `ValidateSaveRam`, and every save-flag write ends in
`UpdateSaveHeaderChecksum` (`$03:$4866`): it recomputes the master checksum
over whatever the bank-0 header holds and copies the header's first 64 bytes
(`$a000-$a03f`: signature, checksum and version, stopping just short of the
flags) over bank 1's. So at
boot a damaged signature is copied into the mirror, and damage elsewhere in the
checksummed region is blessed with a fresh checksum and passes.

Played in PyBoy from `maxed-unlocked.sav` with one byte of the primary
signature flipped: `WipeAllSaveRam` runs and the story slot, the exhibition
block and the star grid are erased. With the boot `ClearSaveFlag` patched out
the mirror survives, and the save is still wiped by the `$a000` compare; with
that operand also patched to `$a020` the header is restored from the mirror and
the save comes through byte for byte. Both defects have to be fixed for the
mirror to do anything.

**Fix** (`make FIXES=1`): `InitAndRunGame` clears `SAVEFLAG_DEBUG_TEST_MENU`
after `ValidateSaveRam` instead of before it, and the re-check reads
`sSaveSignature`. Played in PyBoy from a save with one signature byte flipped,
the fixed build restores the header from the mirror and keeps every block.

### The link-error check can never fire

`AdvanceFrame` (ROM0, `$2631`) guards every frame with:

```
        ldh a, [hLinkCounter]
        or a
        jr z, .linkOk
        ldh a, [hLinkErrorFlags]
        and $e0                  ; top three bits
        jp nz, LinkErrorReset
```

`hLinkErrorFlags` (`$ffc3`) is written in exactly two places, `InitSerialLink`
and `ResetSerialState`, and both clear it with `xor a`. No instruction in the
ROM ever sets any of its bits, so the `jp nz` is unreachable and the link never
resets through this path. Either the code that raised the flags was removed, or
it was never written.

### Match-select slot 8 launches the wrong match

On the singles match-select menu, slot 8 ("Varsity-S Rank 4") dispatches to a
duplicate of the Junior #3 launcher (`$0002`) rather than its own (`$000b`). The
handler is named `LoadMatchSinglesJunior3Alias` in this disassembly rather than
after its caption, because the caption is not what it does. See
`docs/screens_and_ui.md`.

**Fix** (`make FIXES=1`): `LoadMatchSinglesJunior3Alias` loads
`STORYMATCH_VARSITY_4`.

### The screen shake only ever pushes one way

`UpdateScreenShake` (bank `$0a`, `$4908`) is the frame task the overworld
registers while the screen is shaking. It builds a mask from the magnitude,
draws a random word, and masks one offset out of each half of it:

```
        ld a, [wScreenShakeMagnitude]
        ld c, $00
.buildPattern:
        scf / rl c / dec a / jr nz, .buildPattern   ; c = $01, $03 or $07
        call AdvanceRandomSeed
        ld a, h
        and c
        jr nc, .negate           ; <- always taken
        cpl                      ; two's-complement negate
        inc a
.negate:
        ld [wScreenShakeOffsetX], a
        ld a, l
        and c
        jr nc, .store            ; <- always taken
        cpl
        inc a
.store:
        ld [wScreenShakeOffsetY], a
```

`and` clears the carry flag unconditionally, so both `jr nc` are unconditional
jumps and both `cpl` / `inc a` pairs are unreachable. The pairs are a
two's-complement negation, and the surrounding code is unambiguous about what
they were for: both consumers read the offsets as *signed* bytes.
`ComputeSpriteScrollOffset` (`$04:$4a2d`, `$4a61`) sign-extends each one with
`bit 7, l` / `ld h, $ff`, and `UpdateSceneScroll` (`$0a:$59c0`, `$59d5`) adds them to `hScrollY`/`hScrollX`.

So the offsets are always `0..mask` and never negative: the shake displaces the
view in one direction only, by 0-1, 0-3 or 0-7 pixels for magnitude 1, 2 or 3,
with a mean displacement of half the mask instead of a jitter centred on the
camera. The `ld h, $ff` arms at `$04:$4a37` and `$04:$4a6b` are dead as a
consequence.

The sign decision cannot be repaired in place — `and` fixes carry at 0, so no
ordering of these instructions makes the `jr nc` conditional. Whatever produced
the sign (a bit of the random word, most likely) was never written.

**Fix** (`make FIXES=1`): the sign comes from bit 7 of each random byte
(`bit 7, h` / `jr z`), which the mask never uses, so each offset is negated
half the time and the shake centres on the camera.

### A collision-map read is discarded, so one terrain type never slows the player

`UpdatePlayerControl` (bank `$04`, `$516b`) picks the player's walk speed. The
running branch sets `$0040`; the walking branch is meant to check the terrain
under the player first:

```
.checkBlocked:
        ld hl, ACTORF_X + 1 / add hl, bc / ld d, [hl]
        ld hl, ACTORF_Y + 1 / add hl, bc / ld e, [hl]
        farcall ReadCollisionMapCell
        ld a, $00                ; <- discards the returned cell
        and $0f
        cp $0b
        jr nz, .slideX           ; always taken
        ld a, $02                ; probe range 2, speed $0010
        ld [wActorProbeRange], a
        ld de, $0010
```

`ReadCollisionMapCell` (`$0a:$5efb`) returns the cell in `a` — its sibling
consumer `IsTerrainBlockedAtPoint` (`$04:$534b`) does `farcall
ReadCollisionMapCell` / `and $0f` with nothing in between. At `$5218` the `ld a,
$00` overwrites that return value, so `and $0f` / `cp $0b` compares 0 against
`$0b` and the slow-terrain branch can never be taken. Terrain type `$0b` is
tested nowhere else in the ROM.

The player therefore always walks at `$0020` with probe range 0, and the
half-speed terrain the map format can express has no effect anywhere in story
mode. Recorded as an open question in `docs/story_mode.md`; the discarding of
the return value is what makes it a bug rather than a mystery.

**Fix** (`make FIXES=1`): the `ld a, $00` goes, so the walk speed tests the
cell `ReadCollisionMapCell` returns. No shipped collision map has a `$0b`
cell, so the fix only shows on an edited map.

### The white fade can never be selected

The fade engine has two ways to scale a palette. `UpdateFadeOut` and
`UpdateFadeIn` share a tail that picks between them on bit 7 of `hFadeState`:

```
.step2:
        ldh a, [hFadeState]
        add a
        jr nc, .noCarry2         ; -> AdjustColorsBrightness
        ld a, c / and $04
        call z, Unused_00_ApplyWhiteFade
```

`hFadeState` is written in five places: `$1d28` stores `$01`, `$1d36` stores
`$02`, `$1d97` and `$261e` store `$00`, and only `$1d1b` sets bit 7 — with
`or $80`, inside `Unused_00_BeginWhiteFadeOut` (`$00:$1d0f`), which nothing in
the ROM references. Bit 7 is therefore never set, `add a` never carries, and
`Unused_00_ApplyWhiteFade` (`$00:$1dcc`) never runs even though it is reached by a live
`call z`.

The live fade, `AdjustColorsBrightness`, adds a clamped delta to each colour
component, so the screen fades through white (`docs/screens_and_ui.md` §6.3);
the bank `$03` engine's live entry fades to grayscale, and its fade-to-black
setup, `Unused_03_InitBlackPaletteFade`, is unreachable too
(`docs/graphics_formats.md` §5.4). The alternate curve and the routine that
would have armed it both shipped dead; `docs/screens_and_ui.md` records
`Unused_00_ApplyWhiteFade` as unreachable, and the reason is a flag with no
writer — the
same shape as the link-error check above.

### `LoadMenuTilesBStaged` uploads palettes and code to VRAM as tiles

Bank `$01` has two loaders for the same menu tile set. The plain one splits it
into two transfers:

```
LoadMenuTilesB:
        ld hl, MenuFontTiles_01     / ld de, vTiles2 + $20 * TILE_SIZE / ld c, $60 / call QueueVRAMCopy
        ld hl, MenuFontFillTiles_01 / ld de, vTiles1 / ld c, $60 / call QueueVRAMCopy
```

The staged one (`$01:$5095`, reached from `LoadMenuFontGfxStaged`, which bank
`$06` farcalls at `$6ea0` when the story overworld resumes) splits the first
transfer into three `$200`-byte chunks with an `AdvanceFrame` between them, and
then does this as its fourth chunk:

```
        ld hl, MenuFontPalettes_01   ; <- $5010, a 64-byte palette block
        ld de, vTiles1 + $60 * TILE_SIZE   ; $8e00
        ld c, $20                    ; 512 bytes
        call QueueVRAMCopy
```

`MenuFontPalettes_01` is a palette — `LoadMenuFontPalette` hands the same label
to `LoadPaletteShadow`. Copying `$20` tiles from it puts 64 bytes of palette
data followed by 448 bytes of what follows at `$5050`-`$520f` (the bank's loaders, `DebugMenuPalettes_01` at `$50f6`, the start of `UnusedJpWindowTiles_01` at `$51b0`, and including
`LoadMenuTilesBStaged` itself) into VRAM at `$8e00`-`$8fff`, i.e. tiles `$e0`-`$ff`
of the `$8800` block.

The staged path also never uploads `MenuFontFillTiles_01` at all, so
`$8800`-`$8dff` keeps whatever the previous screen left there. The address
progression makes the edit legible: `$9200`, `$9400`, `$9600`, then a fourth
chunk that lands at `$8e00` — the last of the four `$200`-byte slices that would
have covered `$8800`-`$8fff`, with the first three missing and the source label
of the survivor wrong.

### Fifteen drill messages point past their text bank

`DrillMessageTextIds_0b` (`$0b:$45c4`) maps a drill message id to a text id.
Ids 72-86 are the computer's side of messages 57-71 -- "Your lob didn't
reach my court, so you fail." becomes "My lob didn't reach your court, so I
fail." -- and the strings for them exist: text bank `$26`, strings 0-14,
right before the ones ids 87-108 use. But the fifteen table entries carry
bank `$25`'s selector (`$290b`-`$2919`, strings 267-281), and bank `$25` has
only 267 strings. `FetchText_25` reads the word past the end of its offset
table, which is string data, and fetches from wherever that points: id 74
shows "ear.", 77 "this!", 80 "Empire team!", and the other twelve point
outside the bank, into cartridge RAM at `$a788`-`$b692`. Bank `$26`'s strings
0-14 are never shown.

The drills reach them. `QueueDrillResultMessage` and `SetDrillMessageByServer`
add an offset in `b` to the id depending on who served (`QueueDrillResultMessage` when `wCurrentServingPlayer` is nonzero, `SetDrillMessageByServer` when it is zero), and Stroke Match 2
passes `b = 13` with ids 61-70 (`StrokeMatch2Cases2`, `$0b:$6892`, passes
64, for one). Played in PyBoy, random rallies in Stroke Match 2 showed
id 74 twice in six sessions.

**Fix** (`make FIXES=1`): entries 72-86 are `Text_26_0`-`Text_26_14`.

### The DMG lockout screen copies a whole map from an 18-row one

`ShowDmgLockoutScreen` (`$01:$6030`) decompresses `DmgLockoutTilemapLZ_01`,
576 bytes (18 rows of 32), then copies `TILEMAP_AREA` (1024 bytes) from the
buffer to `vBGMap0`. Rows 18-31 of the map get the 448 bytes that follow in
`wDecompBuffer`, which still hold bytes `$240`-`$3ff` of the lockout's decompressed
tiles. Nothing shows them: the routine ends in an endless `AdvanceFrame`
loop without touching the scroll, so only rows 0-17 are ever on screen.

### The SRAM text fetch copies more than its buffers hold

The ROM text fetchers stop at the size of the buffer they fill: dialogue at
`wTextBuffer_SIZE` (160 bytes), short text at `wShortTextBuffer_SIZE` (16).
`FetchSRAMText` (`$05:$6d3b`), which fetches the player-entered strings for
text ids with bit 15 set, copies a fixed length with `CopyMemoryBC` instead:
`$180` bytes into `wTextBuffer` and `$20` into `wShortTextBuffer`, 2.4 and
two times what they hold.

The dialogue copy runs in play (`FetchDialogueTextFromSram`) and overwrites
`$c6a0`-`$c77f` on every call: `wTilemapRowStage`, `wInlineTextBuffer` and the
debug-menu variables at `$c700`. It does no harm. The two staging buffers are
filled and consumed within one routine each, and the debug variables belong
to screens nothing reaches. The short-text copy is reached only from
`Unused_05_FetchSRAMShortText`.

### Boot loads five object palettes from VRAM

`LoadMenuObjPalettes3To7` (`$01:$5188`), called once from the boot sequence
at `$01:$4088`, hands `LoadPaletteShadow` the source
`hl = vTiles0 + $7c * TILE_SIZE + 8` (`$87c8`) for object palettes 3-7. That
is VRAM, not a palette table; bank `$01` has no palette data at the matching
ROM address (`$47c8` is inside `MenuTilesBStagedTiles0`). Its unreachable twin
`Unused_01_LoadMenuBgPalettes3To7` does the same for background palettes 3-7.

It does no harm. Run in PyBoy, the call comes on frame 71 with the LCD off,
the 40 bytes it reads are all zero, and the same five palettes in
`wOBJPalettes` and `wMasterPalettes` are already zero, so the copy changes
nothing. Story screens load the real palettes with `LoadStoryObjPalettes`
(`$0a:$5337`, the same five slots from `StoryObjPalettes`).

### The debug console's SELECT test has no branch

`UpdateDebugOverlay` (`$00:$1893`) decides each frame whether the debug console
is shown:

```
        ldh a, [hDebugStepMode]
        cp $03
        jr z, .storeShowDebugConsole2   ; always on
        cp $01
        jr z, .eq01
        ldh a, [hVBlankCounter] / and $01
        jr z, .storeShowDebugConsole2
        jr .storeShowDebugConsole
.eq01:
        ldh a, [hPlayerInputFlags]
        bit PADB_SELECT, a              ; <- result is never tested
.storeShowDebugConsole:
        xor a
        jr .store
.storeShowDebugConsole2:
        ld a, $01
.store:
        ldh [hShowDebugConsole], a
```

The `bit` sets Z and the next instruction is `xor a`, which overwrites it. The
`jr nz, .storeShowDebugConsole2` that the shape calls for is not there, so in
step mode 1 the console is unconditionally hidden and holding SELECT does
nothing. Debug-only: `UpdateDebugOverlay` is called from the VBlank handler
only when `hDebugStepMode` is nonzero (`$00:$27a1`), and nothing outside the
bank `$01` debug menus ever makes it nonzero.

### `ReadBehaviorMapCell` prints its result on every call

`ReadBehaviorMapCell` (`$0a:$5f4f`) reads one behaviour-map cell and then, with
no guard of any kind:

```
        ld a, b
        push de
        push af
        ld a, a                  ; no-op
        ld_cell de, $0e, $0e
        call PrintHexByte
        pop af
        pop de
```

`PrintHexByte` formats the byte and `PrintString` writes it into
`wDebugTextBuffer` at row 14, column 14, then sets `hDebugTextDirty`. Debug
instrumentation that shipped in the cartridge: four call sites reach it,
including `$04:$5145` on the overworld movement path, so every behaviour-map
lookup pays a hex format plus a string print.

Nothing is corrupted and nothing is visible. The buffer is uploaded to
`$9d00` — a cell of the `$9c00` tilemap, which the BG map select never points
at during normal play — and that upload happens inside `UpdateDebugOverlay`,
which the VBlank handler skips unless `hDebugStepMode` is nonzero. So in a
retail run the two hex digits are written to RAM forever and read by nobody.

### The glyph buffer's "keep" branch is unreachable

`PrepareGlyphBuffer` (`$05:$72dc`) chooses between starting a fresh glyph run
and continuing the current one:

```
        ld a, [wGlyphBufferHoldCount]
        or a
        jr nz, .keepBuffer
        wram_bank WRAM_SOUND
        call ClearGlyphBuffer
        call ResetGlyphStream
        jr .done
.keepBuffer:
        ld a, [wGlyphRowStartCol]
        ld [wGlyphFlushedCol], a
```

`wGlyphBufferHoldCount` (`$d822`, WRAM bank `$05`) has exactly one writer:
`Unused_05_CloseMenuWindow` (`$05:$45ba`) decrements it at `$45d3`-`$45d7`.
Nothing in the ROM refers to `Unused_05_CloseMenuWindow` -- no call, no
`farptr` directory slot, no pointer. Nothing increments the count at all.

So the count is whatever `ResetTextWindowState`'s block clear left, i.e. 0,
forever; `PrepareGlyphBuffer` always clears and resets, and `.keepBuffer` is
dead. This is the answer `docs/screens_and_ui.md` links to for what
raises the hold count: nothing does, and the routine that would have consumed it
is not called either. `wShadowTilemapReadOffset` (`$dc76`) is the same shape with
the halves reversed — `Unused_05_RefreshShadowTilemapFromMapBuffer` (`$05:$44a3`) adds it
to the shadow-tilemap pointer and no instruction in the ROM writes it, so it is
always 0.

### `RegisterFrameTask` inserts six records past the end of its table

`wFrameTasks` (`$c1c0`) is 64 bytes — sixteen 4-byte records of `[id, ptr lo,
ptr hi, rom bank]`. Every routine that walks it agrees on sixteen except the one
that writes it. `ClearFrameTasks` (`$00:$1b38`) clears `$04 * 16` = 64 bytes;
`RunFrameTasks` (`$00:$1bff`) and `UnregisterFrameTask` (`$00:$1bcb`) both loop
`ld c, $10`; `SortFrameTasks` (`$00:$1c3f`) makes fifteen passes over sixteen
records. `RegisterFrameTask` (`$00:$1b6a`) also uses sixteen for its
duplicate check (`ld bc, $0010` at `$1b80`), and then twenty-two for the insert:

```
        ld c, $16                ; <- $1b9a, 22 records
        ld hl, wFrameTasks
.insertLoop:
        inc hl
        call Check3BytesZero
        jr nz, .insertNext
        ...                      ; write the 4-byte record here
        jr .done
.insertNext:
        inc hl / inc hl / inc hl ; stride 4
        dec c
        jr nz, .insertLoop
        ld a, b
        or a
        jr nz, .done             ; <- $1bbf, decides nothing
.done:
```

With all sixteen slots occupied the loop keeps going into `$c200`, which is
`wMasterPalettes` — the master BG+OBJ palette copy that every fade scales into
`wBGPalettes`/`wOBJPalettes`. The free-slot test is `Check3BytesZero` on bytes 1-3 of each record, so past
the end a registration lands in the first of six palette "records" (24 bytes,
BG palettes 0-2) whose bytes 1-3 happen to be zero -- a black colour -- and
overwrites it; where there is none, the task is dropped. The task itself never runs, since
the runner stops at sixteen, and `UnregisterFrameTask` cannot remove it either.

The trailing `ld a, b` / `or a` / `jr nz, .done` is the fossil that leads here:
it is a copy of the duplicate-check idiom at `$1b96`, but `b` is 0 on every path
that reaches it, and the target is the next instruction, so it is four dead bytes
where the table-full handler was. Both halves of the overflow story are missing —
the bound is wrong and there is nothing to run when the bound is hit.

It is latent in practice. The heaviest user found is bank `$17`'s drill
briefings (`DrillBriefing_SpinServe`, `$17:$5817`), which register five to seven
tasks per page and call `ClearFrameTasks` between pages, and the duplicate check
stops a routine being registered twice, so no path found here gets near sixteen
live tasks.

**Fix** (`make FIXES=1`): the insert loop runs sixteen records, `ld c, $10`.
A full table still drops the new task silently, as it always did in effect.

### `GetActorStateAddr` destroys the answer it was asked for

`GetActorStateAddr` (`$0a:$4312`) maps an actor id to its `$40`-byte state
struct and is supposed to report whether that actor is active:

```
        ld a, [hl]               ; the actor's activity byte, struct + $20
        cp $00
        pop hl
        inc h                    ; <- clobbers Z
        dec h
        ret
```

`pop hl` leaves the flags alone, so the `cp $00` result survives it — and then
`inc h` / `dec h` overwrites Z with a test of `h`, which is the high byte of the
struct pointer (`$d0`-`$d5`, or `$d0` for the out-of-range case that jumps
straight to `.haveAddr` with `hl = wActors`). It is never zero, so the routine
always returns NZ.

`inc h` / `dec h` / `ret z` is a house idiom in this bank, but everywhere else it
guards an `hl` the caller handed in:
`CheckActorScriptEnd` (`$0a:$438a`), `IsActorBusy` (`$0a:$476c`, after an `xor a`) and
`UnusedSetActorMoveTarget` (`$0a:$4750`) all open with it. `CheckActorScriptEnd` is the
control: it opens with the guard, and its answer is a `cp $00` at the end that
only a `pop de` stands between and the `ret`, so it reaches its caller intact.
`GetActorStateAddr` has the two halves in the opposite order — it computes `hl`
itself and needs no guard, and the guard it has anyway lands on top of the
answer.

Eleven of its call sites branch on that flag — `ScriptSetActorMoveSpeed`
(`$433b`), `ScriptSetActorMoveTarget` (`$4408`), `SetActorActive` (`$472e`) and
eight more all do `ret z` or `jr z, .done` immediately after the call. Every one
of those guards is dead, so the script engine writes into the state struct of an
actor that is not active.

Nothing visible follows, which is why it survived. An inactive actor is one whose
activity byte is 0, and the draw loop (`$04:$4aae`) calls `DrawAndAnimateActor`
only when that byte is `$02`, so a deactivated actor that is handed a move target
walks invisibly and is re-initialised the next time it spawns. The case the guard
would really have caught — an id of `$18` or more, which resolves to `wActors`
and so aliases the player — does not arise: the highest actor id any `script_*`
command in the ROM names is `$17` (`$15:$4f5e`), one below the limit.

### The ball-contact window's animation-state test decides nothing

`CheckBallContactWindow` (`$08:$6fa7`) decides whether the ball is inside the
character's hitting box; `UpdateCharBallGeometry` calls it every frame the ball
is in swing range (`$08:$6ebb`). It loads the X half-width from `wCharReachX`
and then picks a modifier:

```
        ld a, [wCharFlags]
        bit CHARB_DIVING, a
        jr z, .checkState
        ...                      ; de = reach * 1.25
        jr .checkX
.checkState:
        ld a, [wCharAnimId]
        cp $05 / jr z, .checkX
        cp $06 / jr z, .checkX
        cp $09 / jr z, .checkX
        cp $0a / jr z, .checkX
.checkX:
```

All four arms target `$6fed`, the instruction after the last one, so the whole
block loads an animation id, compares it four times and falls through either way.
The `wCharFlags` arm above it shows what the shape is for — it scales `de` before
`.checkX` — and `CharRallyEndState` (`$08:$6a90`) shows the idiom intact, testing
the same membership (`$05`, `$06`, `$07`, `$09`, `$0a`, `$0b`, `$12`) with a real
body. The ids are the swing animations: `$05` and `$06` are the forehand and
backhand that `$08:$6e58`/`$6e5e` select into `wCharSwingAnim`.

So the contact window is `wCharReachX` (or 1.25x of it when `wCharFlags` bit 1 is
set) in every animation state, and the four swing states that were meant to
differ do not. What they were meant to differ *by* is not in the ROM, so nothing
looks wrong in play: the window is at least the same one the rest of the match
engine assumes. This is the same shape as `Unused_6b_RewriteCutsceneCameraY` below — a
read-modify-write with the modify deleted — except that this one is live code on
the rally path.

### The Training Court's stage normalisation can never run

`TrainingCourtInitScript_15` (`$15:$532e`) opens by computing the location's
progress index, then normalising it:

```
        call ComputeStoryRankTier_15
        ld a, [wMapSceneStage]
        cp $05
        jr c, .fromLesson        ; always taken
        ld a, [wMapSceneStage]   ; unreachable
        sub $06
        ld [wMapSceneStage], a
.fromLesson:
```

`ComputeStoryRankTier_15` (`$15:$7fa0`) starts at `$00` and steps with
`inc a` through at most four flags — junior title, senior title, then either the
singles or the doubles pair of Island Open flags. Its maximum output is `$04`,
on both ladders. The `cp $05` therefore always sets carry, the branch is always
taken, and the three instructions that subtract 6 are unreachable.

The subtraction is the shape of a *second* id space living in the same byte: a
caller that had set `wMapSceneStage` to `$06 + n` and wanted `n` back. Nothing
sets it that way any more — the compute call one instruction earlier overwrites
whatever was there, so even a caller that did would lose it. What the six
would have meant is not recoverable from the ROM.

### The doubles clear-status path clears the singles wins

`SetDoublesRankingClearFlags` (`$0a:$4e75`) is the doubles half of the
developer clear-status tool (`RunClearStatusSetupMenu`, `docs/story_mode.md`).
Its clear loop is a copy of the singles routine's — `ld c, $09` / `ld de,
$0a00`, nine flags from byte `$0a` bit 0 — so it clears
`FLAG_WON_JUNIOR_SINGLES_RANK_4` through `FLAG_WON_VARSITY_SINGLES_RANK_4`,
then sets the *doubles* wins from `DoublesRankingClearFlagList_0a`. The doubles
block at bytes `$08`/`$09` is never cleared, so a doubles "Set" leaves any
higher doubles wins already in the save in place and wipes the singles ladder.
Reachable only through the developer menu.

**Fix** (`make FIXES=1`): the clear starts at
`FLAG_WON_JUNIOR_DOUBLES_RANK_3`, nine flags over the doubles block.

### `GetSpeakerVoice` returns through the wrong stack slot

`GetSpeakerVoice` (`$05:$608a`) pushes `bc`, `de` and `hl`, then
`push_wram_bank WRAM_ACTORS`, and reads the speaker's type byte (actor `+$21`).
A type below `$1e` takes `bit 7, a / jr nz, .done`, which jumps past the
`pop_wram_bank`. With the saved WRAM bank still on the stack, `.done`'s `pop hl /
pop de / pop bc` each take the wrong word, and `ret` jumps to the value `bc` held
on entry. `ShowSpeakerDialogue` loads `b` with `$08` just before the call, so
control lands somewhere in ROM0 `$08xx`, inside `Unused_00_CopyMapToScrollBuffers`, and runs
on from there. Seen when the partner speaks in the awards ceremony (location
`$1a`, entry 11), where `bc` is `$0880`: the operand of a `ld c, $20`, which
runs as `jr nz` into `Unused_00_CopyMapRows32To64`'s fill. From there each
`ret` pops one of `ShowSpeakerDialogue`'s saved registers as an address
(`$0520`, `$0297`, `$0280`, `$0220`, `$2897`): fragments of
`QueueBGTileWrite`, `LoadOBJPaletteData`, `LoadBGPaletteData`,
`CopyDataFromBank` and `SerialHandler`. On the way the code writes the MBC's
RAM-enable and ROM-bank registers and one byte of BG palette RAM, then the
`SerialHandler` tail unwinds the stack past `ShowSpeakerDialogue`.

The game reaches that entry only in doubles: the firework scene before the
ceremony (`$14:$664a`) sends a doubles player to entry `$0b` and a singles
player to `$0a`. Played without breakpoints next to the fixed build in the
event test's doubles story states, the original takes the wild return each
time the partner speaks and still comes back into the dialogue: both builds
show the same lines, the original's text a character or two behind, since
the voice value it returns differs. A build whose ROM0 has moved even three
bytes crashes at the first wild return instead.

Forced into entry `$0b` from a singles state, which the game never does, the
same path goes worse: the partner's "Way to go, Alex! Congratulations" is
skipped, the second wild return leaves BG palette 0's colour 3 changed so
later dialogue boxes are red, and in 19 of the 20 singles states a return
through the unbalanced stack lands in ROM bank `$d1` about 650 frames later
and the game crashes (`rst $38`, stack out of RAM). These are the event
test's 19 awards-ceremony crashes.

**Fix** (`make FIXES=1`): the early exit jumps to a `.restoreBank` label
before `pop_wram_bank`, so the stack is balanced on every path. The event test played the
fixed build against the original over every story state and location: the
original took the wild return at the awards ceremony (location `$1a`, entry
11) in all 36 states, and the fixed build ran every one of them through,
singles states included, and showed the lines.

### Map reads off the edge have no bounds check

`GetCollisionMapCellAddr` (`$0a:$5edd`) and `GetBehaviorMapCellAddr`
(`$0a:$5f31`) turn a tile position (`d` = x, `e` = y, the high bytes of an
actor's coordinates) into an address in the 32 × 32-cell `wCollisionMap` /
`wBehaviorMap` without clamping it. An actor off the map, which the Test map's
open star field allows by simply walking off its top edge, indexes far past the
`$400`-byte maps: an offset of up to `$10df` puts `wBehaviorMap` reads in echo
RAM up to `$e4df`, a mirror of bank-0 WRAM `$c000`-`$c4df` (`wFrameTasks`'
stored ROM pointers among it), and `wCollisionMap` reads mostly in the top of
WRAM bank `$06`. Collision and tile triggers there are whatever those bytes
say, so one layout lets the player wander on and another fires an exit.

### Courtyard entry `$0a` would read its walk-in direction from code

`CourtyardEntryWalkIn_13` (`$13:$62ff`) walks the player (and the partner in
doubles) in from the entry point using `CourtyardEntryWalkInFacings_13[entry -
1]` (the partner's walk uses `[entry + 2]`), a six-byte table of two
three-entry halves for entries 1-3. `CourtyardEntryPoints_13` also lists `$0a`,
`$0d`, `$0e` and `$0f`, but `CourtyardInitScript_13` sends `$0d`, `$0e` and
`$0f` to their own scenes first, so only `$0a` gets here. It indexes byte 9
(byte 12 for the partner): instruction bytes of `VarsityCourtTourCutscene`
after the table. Entry `$0a` takes the low byte of
`ld hl, VarsityCourtTourActors_13` as its angle, so the walk-in direction on that
entry would depend on where that label happens to sit. Nothing in retail
enters the Courtyard at `$0a` (its row is `; debug warp only`).

## Dead stores

Values written and never read, and one table written past its end (the menu
stack, the only entry here that can change behaviour, and only when menus
nest deeper than play ever does). The rest change nothing; they are listed
because each one is a loose end that a future reader will otherwise re-derive,
and because the class is worth watching — the grayscale bug above is a dead
store with a missing counterpart.

### The menu stack has six frames and no depth check

`wMenuStack` (WRAM bank `$05`) holds six two-byte frames indexed by
`wMenuDepth * 2`, and `CreateMenuWindowFromText` pushes without comparing the
depth against it. A seventh nested menu writes its frame over `wMenuDepth`
itself and the byte after it: a runtime audit run that opened menus at random
ended with `wMenuDepth` = `$20` (the frame's first byte) and `$d83f` = the
window id. Normal play never nests that deep. Growing the stack only moves
the limit (two free bytes follow `wMenuDepth`, one more frame); the fix is a
bound on the push -- after `inc a`, `cp (wMenuDepth - wMenuStack) / 2` /
`jr nc` past the frame write, keeping the window id and cursor reset -- so a
seventh menu leaves the stack as it was and at worst unwinds one level early.

### Story character record `+$2f`

Three writes put a constant into byte `+$2f` of the `$40`-byte character
record: `InitCa00RecordFromCharId` writes `$03` on its main-character path
(`$02:$40b2`) and `$02` on its roster path when bit 6 of the id is set
(`$4117`), and the unreachable `Unused_02_LoadMainCharacterFromRoster` writes
`$00` (`$4465`). No code reads `+$2f` (nor
`+$3d`-`+$3f`) in any bank, and poisoning it in a runtime audit changed
nothing; the field is a record-type tag that nothing consults (`CHARREC_BUILD_KIND`).
`+$2b`, once listed here too, is live: `InitCa00RecordFromCharId` copies it
from the roster row and `LoadCharacterAttributes` adds it to the Speed stat
to pick the shot-placement row (`CHARREC_SPEED_BONUS`).

| symbol | where | note |
| --- | --- | --- |
| `wShotAimRow` | every shot bank | the aim row is computed, stored, and used from `a`; the store is a leftover |
| `wUnusedDrillPointStartByte` | bank `$0b` | cleared by `ServiceMatch2Hook_PointStart` |
| `wUnusedExitTriggerIdMirror` | story engine | write-only mirror of `wStoryModeExitTriggerRequest` |
| `wCharObjectDefId` | bank `$04` | the object-def id `SetupCharSpriteFromObjectDef` was handed |
| `hUnusedLinkByte`, `hUnusedLinkSlot` | serial init | cleared by both link init routines, read by nothing |
| `hLinkLastRxMirror` | serial init, bank `$07` | written beside `hLinkLastRxByte`, never compared |
| `hUnusedLinkSelectByte` | bank `$38` | written twice by `RunLinkCharSelectScreen` |
| `wCharSwingHoldFrames` | bank `$08` | `CheckSwingRelease` increments it once per windup frame (`ld hl, wCharSwingHoldFrames` / `inc [hl]`) and zeroes it on release; no site reads the count, so the charge mechanic it fed is gone |
| `wCharSwingHoldButton` | bank `$08` | written on three paths beside the frame count, consumed on none |
| `wCharWalkTargetFlag` | bank `$08` | zeroed immediately after each write of `wCharWalkTargetX`/`Depth`, at `$69bc` and `$7c82` |

### `Unused_00_CopyMapToScrollBuffers` throws away half the work it does

`Unused_00_CopyMapToScrollBuffers` (ROM0, `$086c`) stages four 512-byte blocks of a
just-decompressed map through `wTextBuffer` and expands each into a 64-wide
plane with `Unused_00_CopyMapRows32To64` (16 rows of 32 source bytes followed by 32
zeros, so 1024 bytes written per plane). Two of the four are then immediately
erased:

```
        ld hl, wTextBuffer / ld de, wMapScrollPlane1 / call Unused_00_CopyMapRows32To64
        ld hl, wMapScrollPlane1        ; $08b3
        ld c, $80                      ; 2048 bytes
        call ClearMemory16
        ...
        ld hl, wTextBuffer / ld de, wScreenScratch / call Unused_00_CopyMapRows32To64
        ld hl, wScreenScratch          ; $08fb
        ld c, $80
        call ClearMemory16
```

Both clears start at the base the expansion just filled and cover 2048 bytes —
twice what was written — so every byte of planes 1 and 3 is overwritten with
zeros before anything can read it. Per call that is 3072 bytes of copying
discarded: two 512-byte staging copies plus two 1024-byte expansions.

The clears themselves are load-bearing, which is why this is a dead store and
not a broken screen. Both it and its callers are unreachable, so none of this
runs in the shipped game. The only two callers are `Unused_1a_ShowExpGainScreen`
(`$1a:$45d4`, `$1a:$475a`), and in WRAM banks `$02`/`$03` the cleared region
`$d800`-`$dfff` is where the EXP screen keeps its caption rows —
`Unused_1a_ExpScreenDrawTask` uploads `wCharDataPageSlot1 + 1 * TILEMAP_WIDTH` (`$d800`)
to `$99e0`, and `Unused_1a_DrawExpScreenCaption` renders into `$d82b`. The clear is the
initialisation the caller depends on; the expansion feeding it is not.

The two surviving expansions land at `$d000` in WRAM banks `$02` and `$03` and
write their 32-byte rows at a 64-byte stride, while every other consumer of that
address addresses it at `TILEMAP_WIDTH` = 32. Bank `$1a` never references
`$d000` in either bank, so nothing reads those two either. What the routine's
name describes — four 64-wide scroll planes — has no consumer in the shipped
ROM.

### `ProjectBallSprite` reads the hit-streak table and throws the value away

`ProjectBallSprite` (`$0d:$5848`) indexes `MinigameHitStreakValueTable_0d` by
`wMinigameHitStreak` — the split-base `ld_hl_indexed`, so this is deliberate
addressing, not an accident — loads the entry into `b`, and then immediately
overwrites it:

```
        ld b, [hl]                     ; $5862
        ld b, $0e                      ; $5863
        ret
```

The table holds `$0f, $0e ×6, $0d`, which reads as a per-streak sprite tile
(or size) that was flattened to the constant middle value. Eight bytes of data
and the whole lookup survive with no effect; only the seed-classification pass
noticed, because the table had been mis-seeded as code and the lookup decoded
against a garbage label.

### `ObjectArrayBUpdateCallback_18` stores the wrong register

The two per-object movement callbacks in bank `$18` advance an animation
nibble in object field `+$07` every 8 frames. Callback A does it correctly:

```
        ld a, [hl] / and $f0 / or d / ld [hl], a   ; $7e65
```

Callback B ends the identical sequence with `ld [hl], d` (`$7ec4`): the
combined value sits in `a`, but the store writes `d` — the new low nibble
alone — so the field's high nibble is zeroed every time the path runs. The A
copy proves the intent.

### The text interpreter's column-32 wrap is popped away

After drawing a printable glyph, the text interpreter (`$05:$4eba`) steps the
cell pointer in `de` and, when its column wraps to 0, computes `de - $20` to
bring it back to the start of the row -- then `pop de` (`$4ecb`) restores the
stepped pointer over it. The wrap happens anyway: before the next glyph,
`WrapTextCellPointer` (`$05:$5413`) finds the pointer's row differs from
`wTextCursorRow` and subtracts `$20` itself, and `TextCmdNewline` recomputes
`de` from the row and column.

## A routine whose body is a no-op

`Unused_6b_RewriteCutsceneCameraY` (bank `$6b`, `$615e`) guards on
`wCutsceneStepTimer >= $14` and on `[$c323]` being nonzero, then does this:

```
        ld a, [$c323] / ld h, a       ; h = high byte
        ld a, [$c322] / ld l, a       ; l = low byte  ($c322 = wCameraY)
        ld a, h / ld [$c323], a       ; write h back
        ld a, l / ld [$c322], a       ; write l back
        ret
```

It reads the two camera bytes into `hl` and writes exactly those values back, so
past the guards the routine has no effect whatsoever. Whatever the write-back
was meant to transform -- a shift, an add, a clamp -- is not there.

Nothing reaches it (`tools/reach.py`), so it is an abandoned edit, not a live
no-op. It is recorded here
because the shape is a bug's fingerprint: the read/write-back pair is what a
read-modify-write looks like with the modify deleted. Found by seeding it as
code, which is why it read as 30 bytes of data until 2026-07-29.

## Routines that return before their body

Routines in the ROM that begin with `ret`, so their bodies
never run. Twenty of them are one family, and they are listed here rather than
under Bugs because what they do is coherent — but the intent behind them is not
something the code can settle, so this section claims only what is observable.

Each drill in bank `$0b` has four judging routines, one per hook, which pass an
event code to that drill's `JudgePoint`:

| routine | hook | event code |
| --- | --- | --- |
| `<Drill>JudgeOnPointEnd` | `<Drill>Hook_PointEnd` | 0 |
| `<Drill>JudgeOnBallHit` | `<Drill>Hook_BallHit` | 1 |
| `<Drill>JudgeOnBounce` | `<Drill>Hook_Bounce` | 2 |
| `<Drill>JudgeOnRallyTick` | `<Drill>Hook_RallyTick` | 3 |

`JudgePoint` dispatches on `wRallyLength` and then on the event code, and
returns early if `wDrillPointJudgement` is already set, so the first event to
judge a point wins.

Fifteen drills, four judges each, 20 of the 60 beginning with `ret` — and
**which** ones varies:

* 9 drills disable `JudgeOnRallyTick` only (`StrokeMatch1`-`3`,
  `StrokePractice1`-`3`, `NetGamePractice1`-`3`);
* 5 disable `JudgeOnBounce` and `JudgeOnRallyTick` (`ServiceMatch1`/`3`,
  `NetGameMatch1`/`2`/`3`);
* 1 disables `JudgeOnBounce` while leaving `JudgeOnRallyTick` live
  (`ServiceMatch2`).

No drill disables `JudgeOnPointEnd` or `JudgeOnBallHit`.

So the effect is a per-drill choice of which events are allowed to score a
point, which is a sensible thing to vary between a serve drill and a stroke
drill. That the pattern differs per drill rather than being one blanket edit is
consistent with it being deliberate; it is not proof of it, and a leading `ret`
looks the same whether it was written as configuration or left behind by an
edit. Nothing else in the ROM distinguishes the two.

### Leading `ret`s in front of real bodies

Four more routines open with a `ret` in front of a real body, and two more
have a body with no effect. Two of the four are drill judges, counted above;
all six are named for the body, with the leading `ret`
recorded in the note:

| routine | body |
| --- | --- |
| `NetGamePractice1JudgeOnRallyTick` | the drill's fourth judge |
| `StrokePractice1JudgeOnRallyTick` | the drill's fourth judge |
| `Unused_18_LoadFontTiles` | copies `FontTiles` to `$9000` |
| `Unused_1b_LoadUnlockDebugNavGridGfx` | decompresses and uploads debug-screen artwork |
| `Unused_02_CheckExpAwardAllowed` | the EXP-award gate — see below |
| `Unused_05_PagedMenuFrameTask` | a frame task whose body has no effect |

The 58 routines named `StubNop` (most of them
`Unused_<bank>_StubNop*`) have a bare `ret` for a body and keep the name,
which for them is accurate.

`Unused_02_CheckExpAwardAllowed` is worth its own line. `Unused_02_AddExpToCa00RecordChecked` calls
it and returns on z, but it cannot return z: `xor a` / `dec a` sets the flags
from `$ff` and the following `ld a, c` restores the caller's `a` without
touching them. The gate always passes, so the award would always happen, but
`Unused_02_AddExpToCa00RecordChecked` is itself unreachable and never runs. Whatever
condition it was meant to test is not in the ROM.

`Unused_05_PagedMenuFrameTask` is the other interesting one:
`Unused_05_RunPagedTextMenuAutoSize` registers it as a frame task and
unregisters it when the menu closes, but that routine is unreachable too, so
the task never runs. Its body reads `wMenuCursorRow` into `a` and then
`pop af` discards it.

### The scene viewer indexes the slot table with the wrong stride

`SceneGfxSlotTable` (`$0a:$59d9`) is 592 bytes = **37 records of eight slot
words**, and `GetSceneSlotPtr` (`$0a:$5d0b`) walks it correctly — four
`add hl, hl` for `16 * scene`, then `+ 2 * slot`:

```
        ld l, a
        add hl, hl / add hl, hl / add hl, hl / add hl, hl   ; 16 * scene
        ld de, SceneGfxSlotTable
        add hl, de
        ld e, b / sla e / ld d, $00 / add hl, de            ; + 2 * slot
```

`Unused_0a_LoadSceneGraphicsDirect` (`$0a:$5d2a`) computes a different multiplier from the
same input:

```
        ld l, a
        add hl, hl          ; 2a
        ld d, h / ld e, l   ; de = 2a
        add hl, hl          ; 4a
        add hl, hl          ; 8a
        add hl, hl          ; 16a
        add hl, de          ; <- 16a + 2a = 18a
```

Eighteen bytes per record, for a table whose records are sixteen. 592 is not a
multiple of 18, and the slot roles are confirmed by `LoadStorySceneGraphics`,
which pushes slots 0-6 and pops them into `wCollisionMap`, `wBehaviorMap`,
`wScreenAttrmap`, `wShadowTilemap`, a palette load and a scene-config copy — six
independent confirmations of the 16-byte stride across 21 records.

The error is `2 * scene` bytes, i.e. the read slides one slot further into the
table for every scene id: scene 0 is correct, scene 1 reads slot 2 where it
wants slot 1, and scene 8 lands exactly on record 9 and loads a different
scene's graphics entirely.

**It has never been noticed because only debug code calls it.** Its one caller
is `Unused_0a_LoadAndDisplayScene` (`$0a:$5de2`), and that routine's four callers are
`Unused_0a_SceneViewerSelectScene`, `UnusedSceneViewerSelectSceneMenu`,
`Unused_0a_InitSceneViewer` and `Unused_0a_InitSceneViewerDefault` — the scene
viewer. Its entries are `UnusedSceneViewerMainLoop` (which calls
`Unused_0a_InitSceneViewerDefault` and `Unused_0a_SceneViewerSelectScene`),
`UnusedSceneViewerSelectSceneMenu` and `Unused_0a_InitSceneViewer`. The first
two are referenced nowhere, and the third only by its directory slot
(`$0a:$4072`), which no `farcall` uses, so nothing reaches it.
(`Unused_0a_RunSceneSelectDebugMenu` is a separate scene picker that calls
`LoadStorySceneGraphics` directly.) No `farcall` to `Unused_0a_LoadAndDisplayScene` exists outside
bank `$0a`, despite its directory slot at `$4078`.


### A superseded save-repair family in bank `$03`, unreachable

`$03:$553b`-`$5669` holds **eight complete routines** with no way in, sitting
between `RestoreStoryBlockFromBackup`'s `ret` and `RepairAllSaveSlots`. They are
an earlier, hardcoded version of the repair the live pair does generically:
`Unused_03_RestoreBlock06FromBackup` through `..._RestoreBlock0aFromBackup` are
five copies of one routine with the block id baked in, flanked by
`Unused_03_RestoreBlockOrClear`, `Unused_03_InvalidateBlockIfUnwritten` and
`Unused_03_ClearBlockIfSet`.

What replaced them is visible one label further down: `RepairAllSaveSlots`
(`$03:$5669`) calls `RestoreStoryBlockFromBackup` three times with `b` = 0, 2, 4,
and the callee derives the backup block with `ld a, $1b / add b` instead of
naming it. One parameterised routine for five hardcoded ones.

Nothing references any of it. Scanning bank `$03` for every address in the span,
as a same-bank `dw` or as the operand of a `call`/`jp`, yields five hits and all
five are coincidences: `41 56` is the "AV" of the ASCII string "SAVED", `2a 56`
is an `ld a, [hl+]` / `ld d, [hl]` instruction pair at three sites, and `21 56`
is the low operand byte of an `ld hl`. The descent finds nothing either, which is
why the routines had no labels of their own.

The disassembly consequence is the same as bank `$1b`'s confirm screen: **18 of
the bare banked-WRAM operands left raw in the source are in here**, and no
amount of play can prove them. They had been attributed to
`RestoreStoryBlockFromBackup`, whose own body resolves cleanly to
`wDecompBuffer`, which made the routine look half-analysed when it was complete.


### A confirm-screen suite in bank `$1b` that nothing can reach

`$1b:$69d9`-`$6aa0` holds seven complete routines with no way in. They sit
immediately after three bare `ret`s, `Unused_1b_StubNop_1b_09`,
`Unused_1b_StubRet1` and `Unused_1b_StubRet2`, the first of which
`Unused_1b_RunStoryDataConfirmMenu` registers as a no-op frame task (`$1b:$69b9`/`$69c5`) around
`Unused_18_RunTwoOptionSelectB`, both unreachable as well — so the disassembler once attributed the whole run to that
label, which is why they read as part of a stub.

They are a working screen: `Unused_1b_ShowHighScoreConfirmScreen` sets
`wMinigameHighScoreMode`, fades out, calls `Unused_18_InitConfirmScreen`, flushes and
fades back in; five siblings draw one prompt each with its Yes/No labels —
"Erase?" (with the player's name pushed as a text argument through
`Unused_1b_CopyMainCharNameWithDiacritics`), "Erase it? Really?", "Continue?", "Is this
correct?" and "Char. and item data." twice; and `Unused_1b_DrawGameTimerRow`
renders `wGameTimer` as `hh:mm:ss`, writing the `$3a` colon glyph between the
fields, then queues the row to VRAM.

Nothing references any of it. A ROM-wide scan for each of the 200 candidate
entry addresses, as a same-bank `dw` or as a `farptr`-shaped word followed by
bank `$1b`, returns seven hits and every one is a coincidence: `11 6a d0` is the
`ld de, $d06a` in a neighbouring routine, `cd ae 6a` is a call *within* the span
itself, and the rest land inside graphics data in banks `$2f`, `$36` and `$70`.
The descent finds no reference either, which is why the fragments had no labels
of their own until they were named.

The consequence is only for the disassembly's accounting, not for the game: 11
of the bare banked-WRAM operands left raw in the source are in this span, and no amount of play can ever prove them, because the code
does not run.

### The whole developer debug harness is unreachable, and its unlock flag is never read

`InitAndRunGame` (`$01:$4018`) is the retail boot routine: `SoftReset` farcalls it
unconditionally (`$00:$262c`, followed by `stop`), and it clears WRAM banks 1-6,
validates and repairs SRAM, applies the unlock flags, initialises story state and
match settings, enables the LCD, and then at `.loop` (`$40a5`) sets
`wStoryModeCurrentLocation` to `STORYLOC_MAIN_MENU` and calls
`RunStoryModeOverworld` — which is the entire game.

Past that call is `.loopB` (`$40b2`-`$40eb`), a small loop that prints the build
stamp, sets `hDebugStepMode` to 3, sets the save flag on A and reruns the
overworld on START, ending in `jp .loopB`. After it sits a **complete debug
dispatcher** (`$01:$40ec` onward) that polls `hInputPressed` and launches a different subsystem per button:

| bit | button | what it runs |
| --- | --- | --- |
| 3 | START | the overworld at the main menu |
| 2 | SELECT | `Unused_01_RunSoundTest` |
| 0 | A | `Unused_07_RunDebugTestMatch`, looping |
| 1 | B | `RunMatch`, looping |
| 6 | UP | two `ShowTournamentBracket` calls, then `RunMatchWinLoseScreen` looping over result ids |
| 7 | DOWN | `RunIntroCutscene` then `RunTitleScreen`, looping |
| 4 | RIGHT | the overworld at `STORYLOC_TEST` |
| 5 | LEFT | `Unused_1a_RunDebugCharViewer` |

with a further block (`$419e`), which the dispatcher itself never enters (the
UP branch loops forever before it, and the bit-6-clear branch jumps past it to
`$41c2`), for `ShowEquipmentStatusScreen`,
`RunMatchStatsScreen`, `ShowLinkErrorScreen`, `ShowLinkMessageScreen`,
`RunShoesSelectScreen`, `RunRacketSelectScreen` and the character viewer.

**Nothing reaches any of it.** No instruction jumps to `$40ec`, and nothing falls into it: the code above
ends `jp .loopB` (`$40e9`). Even `.loopB` runs only if the `farcall
RunStoryModeOverworld` at `$40af` returns, and that call never returns in normal
play — the overworld loop is the game. The blocks are
named `Unused_01_*` for that reason.

The accompanying save flag is the visible half. `SAVEFLAG_DEBUG_TEST_MENU`
(#63) has exactly two references in the ROM, both inside this routine: it is
**cleared** unconditionally at boot (`$401c`) and **set** if A is held at
`$40c6` — and no instruction anywhere tests it. So the "hold A to enable the test
menu next boot" gesture would store its bit in battery-backed SRAM, but it
lives in `.loopB`, which runs only if `RunStoryModeOverworld` returns, and the
bit is read by nothing.

What survives is the *in-game* debug menu, which is reached by a different route
entirely: `RunStoryLocation`'s frame loop calls `RunDebugMenu` (`$05:$66a0`)
whenever `hDebugStepMode` is nonzero and no script or tile trigger is active
(`$0a:$50b4`). That one is live, and its four handlers are a warp menu, a text
subcommand, a palette editor and a game-flag editor. Since nothing in the retail
build sets `hDebugStepMode` except `InitAndRunGame`, which sets it to 3 at
`.loopB` (`$01:$40bd`) only if `RunStoryModeOverworld` returns, and the
`Unused` debug screens, it is
unreachable in practice too — but only by one byte, not by a missing jump.


### The in-match stats editor has no live entry

`CheckDebugStatsEditorHotkey` (bank `$08`, `$44ef`) is called by
`StepMatchFrame` (`$08:$4489`) on every match frame that is not frozen, right
after `HandlePauseMenu`, and begins with `ret`. Its body is:

```
CheckDebugStatsEditorHotkey:
        ret                          ; <- $44ef
        call ReadMatchInputPressed
        and $04                      ; SELECT
        ret z
        ldh a, [hDebugStepMode]
        and a
        ret z
        ld a, $ff
        ld [wMatchSimFrozen], a
        ld [wMatchDrawFrozen], a
        farcall Unused_06_RunDebugStatsEditor
        ld a, $00
        ld [wMatchSimFrozen], a
        ld [wMatchDrawFrozen], a
        ret
```

That `farcall` is the only reference to `Unused_06_RunDebugStatsEditor` (`$06:$6b84`) in
the ROM other than its slot in bank `$06`'s `$4000` directory, and no indexed
dispatch reaches that slot. So the leading `ret` orphans a working in-match
editor: `Unused_06_RunDebugStatsEditor` plus `Unused_06_DrawDebugStatsLabels`,
`Unused_06_DrawDebugStatsValues` and `Unused_06_HandleDebugStatsInput`, none of which is referenced
from anywhere else.

Unlike the drill judges this one is a single routine rather than a family, and
its body is guarded by `hDebugStepMode` anyway, so the `ret` may well have been
deliberate belt-and-braces before release. As with the judges, the ROM does not
distinguish that from an editing accident.

## Glyph stream underrun below the glyph tile buffer

`PlotGlyphRow` (`$05:$737a`) turns the glyph pen position into a byte offset
with a signed shift (`sra d / rr e` three times) and adds it to
`wGlyphTileBuffer` (bank `$07`, `$d300`), with no bounds check. A negative
pen therefore writes glyph pixels *below* the buffer. The pen goes negative
at a line break. `DrawInlineGlyph`'s `.eq01` path (code `$01`) seeds it
from the glyph-tile column the new row starts at, `wTextRowColumn`:

        ld e, $00
        ld d, c          ; c = wTextRowColumn
        sra d            ; pen = column * $80, sign-extended from bit 7
        rr e

A row that starts at column `$80` or above therefore gets a negative pen,
`(column - $100) * $10` bytes below `$d300`: `$88` lands at `$cb80` in WRAM0,
`$c0` at `$cf00`, the stack.

* The lesson menu's second page starts just past `$80`, and five glyph tiles
  land at `$d2b0-$d2ff`, found by a RAM poison run (2026-09-11). Nothing
  lives there, so it is harmless in the retail layout, but anything
  allocated in that range would be overwritten by text.
* The Test2 debug location's "clear status" screens start their glyph rows
  at column `$78` and give each row `$10` columns, carrying on from one
  prompt or menu to the next. The row at `$88` already writes at `$cb80`.
  By the row at `$c8` the writes land at `$cf80`, on the stack: return
  addresses turn into glyph pixels and the game jumps into the stack (seen
  as `PC=$cf7b`). Found through the event test, whose runs at that location
  kept hanging (2026-09-30). It is only reachable from the debug warp menu.

There is no **Fix**. The pen is a column of the glyph tile buffer, 16 bytes
per column, and the buffer is uploaded to `vTiles1`, so column `c` is BG tile
`$80 + c` and the buffer has room for 128 columns. A row that starts at
column `$80` has no tile to draw into whichever way the shift goes: `sra`
writes below the buffer, `srl` would write past its end. Both screens simply
run out of glyph tiles, and what they should do instead -- start a new
window's columns from 0, or reuse the first page's -- is not in the ROM.
