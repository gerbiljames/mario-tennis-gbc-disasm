# Bugs and dead code in the shipped game

Defects in Mario Tennis (GBC) itself, as distinct from mistakes in this
disassembly. Everything here is in the released cartridge and reproduces from
`baserom.gbc`.

Three things look like defects, but only the first is one:

* **Bugs** — the code does something other than what it plainly intends.
* **Dead stores** — a value is written and never read. Harmless, but usually the
  fossil of an edit, and occasionally the visible half of a bug.
* **Routines that return before their body** — a `ret` at the top of a called
  routine. The effect is observable; whether it was written as configuration or
  left behind by an edit generally is not, so they are recorded rather than
  judged.

A bug with a **Fix** paragraph is fixed in `make FIXES=1`, which builds
`mariotennis-fixes.gbc` from the `IF DEF(FIXES)` blocks in the source. Played
against the original by the event test over every story state, every targeted
session, story handler and nine main-menu sessions, it differs only where a fix
applies (the damaged-save target, the slot-8 match, the awards ceremony) and
crashes only where the original does (Test2). The rest are left as they are:
the fix would change behaviour nobody has checked (`GetActorStateAddr`'s
guards), the intended values are not known (the Courtyard walk-in table, the
map-edge clamp, the glyph pen's range), or the defect does nothing (the
over-reads and dead stores).

## Bugs

### Grayscale conversion drops the blue channel

`ConvertColorToGrayscale` (bank `$1d`, `$7210`) splits a CGB colour into its
three components, then averages them:

```
        ld a, d / and $7c / rrca / rrca   ; blue
        ld [rRAMG + 2], a            ; <- should be [$d002]
        ld a, [wDecompBuffer]
        ld hl, wDecompBuffer + 1
        add [hl]
        inc hl                       ; -> $d002
        add [hl]
        srl a
```

Blue is stored to `$0002` instead of `$d002` — a dropped `d`. `$d002` is never
written, so the average is red plus green plus whatever the byte held, and
every grayscale palette is wrong. The stray write sets the MBC5 cartridge-RAM
gate (`$0000-$1fff`) to the blue value's low nibble, usually disabling SRAM;
nothing breaks because the bank `$03` save engine always re-enables SRAM first.

Green's top two bits come from `d & 3` shifted left only twice, landing on bits
2-3 over the low bits instead of bits 3-4, so green never exceeds 15. The
"average" is `srl a` — the sum halved, not divided by three — masked to five
bits, so restoring the blue store alone would turn white (31, 31, 31) into
(31 + 15 + 31) / 2 = 38, masked to 6. The shipped routine gives white 23, pure
red 15, pure green 7 and pure blue 0.

**Fix** (`make FIXES=1`): blue is stored to `wDecompBuffer + 2`, green's
high bits get the third `rlca`, and the average is `(r + 2g + b) / 4` -- green
added twice, the sum shifted right twice -- so white stays 31 and every grey
stays itself.

### The save mirror re-check compares the wrong signature

The header region `$a000-$a7ff` is mirrored into SRAM bank 1 after every write.
On boot `ValidateSaveRam` (bank `$03`) checks the signature and master checksum;
on failure it restores bank 1's mirror and re-checks — but the re-check compares
the signature at `$a000` instead of `$a020`, so it always fails, and a corrupt
header always falls through to a full wipe. See `docs/save_format.md`.

The mirror is also spoiled before the check runs. `InitAndRunGame` does
`ClearSaveFlag SAVEFLAG_DEBUG_TEST_MENU` (`$01:$401f`) right after
`call InitSerialLink`, ahead of `ValidateSaveRam`, and every save-flag write
ends in `UpdateSaveHeaderChecksum` (`$03:$4866`), which recomputes the master
checksum over the bank-0 header and copies its first 64 bytes (`$a000-$a03f`:
signature, checksum and version, stopping short of the flags) over bank 1's.
So a damaged signature is copied into the mirror, and damage elsewhere in the
checksummed region gets a fresh checksum and passes.

In PyBoy, from `maxed-unlocked.sav` with one primary signature byte flipped,
`WipeAllSaveRam` erases the story slot, the exhibition block and the star grid;
fixing either defect alone still wipes, and fixing both restores the save byte
for byte.

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

`hLinkErrorFlags` (`$ffc3`) is written only by `InitSerialLink` and
`ResetSerialState`, both with `xor a`. Nothing sets its bits, so the `jp nz` is
unreachable and the link never resets through this path.

### Match-select slot 8 launches the wrong match

On the singles match-select menu, slot 8 ("Varsity-S Rank 4") dispatches to a
duplicate of the Junior #3 launcher (`$0002`) rather than its own (`$000b`),
hence the handler's name `LoadMatchSinglesJunior3Alias`. See
`docs/screens_and_ui.md`.

**Fix** (`make FIXES=1`): `LoadMatchSinglesJunior3Alias` loads
`STORYMATCH_VARSITY_4`.

### The screen shake only ever pushes one way

`UpdateScreenShake` (bank `$0a`, `$4908`), the overworld's shake frame task,
masks a random word by the magnitude:

```
        call AdvanceRandomSeed
        ld a, h
        and c                    ; c = $01, $03 or $07
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

`and` always clears carry, so both negations are unreachable, though both
consumers read the offsets as signed: `ComputeSpriteScrollOffset`
(`$04:$4a2d`, `$4a61`) sign-extends with `bit 7, l` / `ld h, $ff`, and
`UpdateSceneScroll` (`$0a:$59c0`, `$59d5`) adds them to `hScrollY`/`hScrollX`.
The shake therefore displaces the view one way only, by 0-1, 0-3 or 0-7 pixels
for magnitude 1-3, instead of jittering around the camera, and the `ld h, $ff`
arms at `$04:$4a37` and `$04:$4a6b` are dead. No reordering makes the `jr nc`
conditional; whatever produced the sign was never written.

**Fix** (`make FIXES=1`): the sign comes from bit 7 of each random byte
(`bit 7, h` / `jr z`), which the mask never uses, so each offset is negated
half the time and the shake centres on the camera.

### A collision-map read is discarded, so one terrain type never slows the player

`UpdatePlayerControl` (bank `$04`, `$516b`) picks the walk speed. The running
branch sets `$0040`; the walking branch checks the terrain first:

```
        farcall ReadCollisionMapCell
        ld a, $00                ; <- $5218, discards the returned cell
        and $0f
        cp $0b
        jr nz, .slideX           ; always taken
        ld a, $02                ; probe range 2, speed $0010
        ld [wActorProbeRange], a
        ld de, $0010
```

`ReadCollisionMapCell` (`$0a:$5efb`) returns the cell in `a`, as its other
consumer `IsTerrainBlockedAtPoint` (`$04:$534b`) uses it. The `ld a, $00`
overwrites it, so the slow-terrain branch is never taken; type `$0b` is tested
nowhere else. The player always walks at `$0020` with probe range 0, and the
half-speed terrain the map format can express has no effect in story mode (an
open question in `docs/story_mode.md`).

**Fix** (`make FIXES=1`): the `ld a, $00` goes, so the walk speed tests the
cell `ReadCollisionMapCell` returns. No shipped collision map has a `$0b`
cell, so the fix only shows on an edited map.

### The white fade can never be selected

`UpdateFadeOut` and `UpdateFadeIn` share a tail that picks a palette-scaling
method on bit 7 of `hFadeState`:

```
        ldh a, [hFadeState]
        add a
        jr nc, .noCarry2         ; -> AdjustColorsBrightness
        ld a, c / and $04
        call z, Unused_00_ApplyWhiteFade
```

Of `hFadeState`'s five writers (`$1d28` stores `$01`, `$1d36` `$02`, `$1d97`
and `$261e` `$00`), only `$1d1b` sets bit 7 — with `or $80`, inside
`Unused_00_BeginWhiteFadeOut` (`$00:$1d0f`), which nothing references. So
`Unused_00_ApplyWhiteFade` (`$00:$1dcc`) never runs despite a live `call z`:
a flag with no writer, like the link-error check.

The live fade, `AdjustColorsBrightness`, adds a clamped delta to each
component, fading through white (`docs/screens_and_ui.md` §6.3). The bank `$03`
engine's live entry fades to grayscale, and its fade-to-black setup,
`Unused_03_InitBlackPaletteFade`, is unreachable too
(`docs/graphics_formats.md` §5.4).

### `LoadMenuTilesBStaged` uploads palettes and code to VRAM as tiles

Bank `$01` has two loaders for the same menu tile set. The plain one:

```
LoadMenuTilesB:
        ld hl, MenuFontTiles_01     / ld de, vTiles2 + $20 * TILE_SIZE / ld c, $60 / call QueueVRAMCopy
        ld hl, MenuFontFillTiles_01 / ld de, vTiles1 / ld c, $60 / call QueueVRAMCopy
```

The staged one (`$01:$5095`, reached from `LoadMenuFontGfxStaged`, which bank
`$06` farcalls at `$6ea0` when the story overworld resumes) splits the first
transfer into three `$200`-byte chunks with an `AdvanceFrame` between them,
then does this as its fourth:

```
        ld hl, MenuFontPalettes_01   ; <- $5010, a 64-byte palette block
        ld de, vTiles1 + $60 * TILE_SIZE   ; $8e00
        ld c, $20                    ; 512 bytes
        call QueueVRAMCopy
```

`MenuFontPalettes_01` is a palette (`LoadMenuFontPalette` hands it to
`LoadPaletteShadow`). The copy puts its 64 bytes plus 448 bytes of what follows
at `$5050`-`$520f` (the bank's loaders, `DebugMenuPalettes_01` at `$50f6`, the
start of `UnusedJpWindowTiles_01` at `$51b0`, and `LoadMenuTilesBStaged`
itself) into VRAM `$8e00`-`$8fff`, tiles `$e0`-`$ff` of the `$8800` block.

`MenuFontFillTiles_01` is never uploaded, so `$8800`-`$8dff` keeps whatever the
previous screen left. The chunks go to `$9200`, `$9400`, `$9600`, then `$8e00`
— the last of four slices that would have covered `$8800`-`$8fff`, with the
first three missing and the survivor's source label wrong.

### Fifteen drill messages point past their text bank

`DrillMessageTextIds_0b` (`$0b:$45c4`) maps a drill message id to a text id.
Ids 72-86 are the computer's side of messages 57-71 ("Your lob didn't reach my
court, so you fail." becomes "My lob didn't reach your court, so I fail."), and
their strings exist: text bank `$26`, strings 0-14. But the entries carry bank
`$25`'s selector (`$290b`-`$2919`, strings 267-281), and bank `$25` has only
267 strings. `FetchText_25` reads past its offset table into string data and
fetches from wherever that points: id 74 shows "ear.", 77 "this!", 80 "Empire
team!", and the other twelve point into cartridge RAM at `$a788`-`$b692`. Bank
`$26`'s strings 0-14 are never shown.

The drills reach them. `QueueDrillResultMessage` (when
`wCurrentServingPlayer` is nonzero) and `SetDrillMessageByServer` (when it is
zero) add an offset in `b` to the id, and Stroke Match 2 passes `b = 13` with
ids 61-70 (`StrokeMatch2Cases2`, `$0b:$6892`, passes 64). Seen in PyBoy: id 74
twice in six Stroke Match 2 sessions.

**Fix** (`make FIXES=1`): entries 72-86 are `Text_26_0`-`Text_26_14`.

### The DMG lockout screen copies a whole map from an 18-row one

`ShowDmgLockoutScreen` (`$01:$6030`) decompresses `DmgLockoutTilemapLZ_01`,
576 bytes (18 rows of 32), then copies `TILEMAP_AREA` (1024 bytes) to
`vBGMap0`. Rows 18-31 get the next 448 bytes of `wDecompBuffer`, bytes
`$240`-`$3ff` of the lockout's decompressed tiles. Nothing shows them: the
routine ends in an endless `AdvanceFrame` loop without touching the scroll.

### Some tile-block loads copy two tiles past their stream

`LoadCompressedTileBlock` decompresses a stream and copies `c` tiles of the
buffer to VRAM. The court-select screen (`$3e:$5d6e`-`$5dc8`) asks for 18 tiles
of 16-tile streams (20 of Gfx4's 18), the minigame menu (`$3b:$63b9`) 18 of
`SharedMenuGfx111`'s 16, and the intro (`$6b:$60b3`) 4 of `IntroGfx6`'s 2, so
each copy brings two stale tiles from the buffer. In the court-select chain
the next load overwrites them; the last loads leave them at tiles `$72`-`$73`
(VRAM bank 1) and `$50`-`$51`, the minigame menu at `$60`-`$61`, the intro at
`$4a`-`$4b`. Each copy's source note gives the counts.

### The SRAM text fetch copies more than its buffers hold

The ROM text fetchers stop at their buffer's size: dialogue at
`wTextBuffer_SIZE` (160 bytes), short text at `wShortTextBuffer_SIZE` (16).
`FetchSRAMText` (`$05:$6d3b`), which fetches player-entered strings for text
ids with bit 15 set, copies a fixed `$180` bytes into `wTextBuffer` and `$20`
into `wShortTextBuffer` with `CopyMemoryBC`.

The dialogue copy runs in play (`FetchDialogueTextFromSram`) and overwrites
`$c6a0`-`$c77f` every call: `wTilemapRowStage`, `wInlineTextBuffer` and the
debug-menu variables at `$c700`. It does no harm: the two staging buffers are
filled and consumed within one routine each, and the debug variables belong to
screens nothing reaches. The short-text copy is reached only from
`Unused_05_FetchSRAMShortText`.

### Boot loads five object palettes from VRAM

`LoadMenuObjPalettes3To7` (`$01:$5188`), called once at boot (`$01:$4088`),
hands `LoadPaletteShadow` the source `vTiles0 + $7c * TILE_SIZE + 8` (`$87c8`)
for object palettes 3-7. That is VRAM; bank `$01` has no palette data at the
matching ROM address (`$47c8` is inside `MenuTilesBStagedTiles0`). Its
unreachable twin `Unused_01_LoadMenuBgPalettes3To7` does the same for
background palettes 3-7.

It does no harm: the call comes on frame 71 with the LCD off, the 40 bytes it
reads are zero, and the five palettes in `wOBJPalettes` and `wMasterPalettes`
are already zero. Story screens load the real ones with `LoadStoryObjPalettes`
(`$0a:$5337`, from `StoryObjPalettes`).

### The debug console's SELECT test has no branch

`UpdateDebugOverlay` (`$00:$1893`) decides each frame whether the debug console
is shown:

```
        cp $01
        jr z, .eq01
        ...
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

The `jr nz, .storeShowDebugConsole2` after the `bit` is missing, so in step
mode 1 the console is always hidden and SELECT does nothing. Debug-only: the
VBlank handler calls `UpdateDebugOverlay` only when `hDebugStepMode` is nonzero
(`$00:$27a1`), and only the bank `$01` debug menus make it so.

### `ReadBehaviorMapCell` prints its result on every call

`ReadBehaviorMapCell` (`$0a:$5f4f`) reads one behaviour-map cell and then, with
no guard:

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

`PrintHexByte` writes the byte as hex into `wDebugTextBuffer` at row 14,
column 14 and sets `hDebugTextDirty`. Four call sites reach it, including
`$04:$5145` on the overworld movement path, so every behaviour-map lookup pays
a hex format and a string print. Nothing is corrupted or visible: the buffer is
uploaded to `$9d00` (the `$9c00` tilemap, never selected in normal play) only
by `UpdateDebugOverlay`, which the VBlank handler skips unless `hDebugStepMode`
is nonzero.

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
```

`wGlyphBufferHoldCount` (`$d822`, WRAM bank `$05`) has one writer:
`Unused_05_CloseMenuWindow` (`$05:$45ba`) decrements it at `$45d3`-`$45d7`, and
nothing references that routine. Nothing increments the count, so it stays at
the 0 `ResetTextWindowState` left and `.keepBuffer` is dead. (This answers
`docs/screens_and_ui.md`'s question of what raises the hold count.)
`wShadowTilemapReadOffset` (`$dc76`) is the reverse:
`Unused_05_RefreshShadowTilemapFromMapBuffer` (`$05:$44a3`) adds it to the
shadow-tilemap pointer and nothing writes it, so it is always 0.

### `RegisterFrameTask` inserts six records past the end of its table

`wFrameTasks` (`$c1c0`) is sixteen 4-byte records of `[id, ptr lo, ptr hi,
rom bank]`. `ClearFrameTasks` (`$00:$1b38`) clears 64 bytes; `RunFrameTasks`
(`$00:$1bff`) and `UnregisterFrameTask` (`$00:$1bcb`) loop `ld c, $10`;
`SortFrameTasks` (`$00:$1c3f`) makes fifteen passes over sixteen records.
`RegisterFrameTask` (`$00:$1b6a`) uses sixteen for its duplicate check
(`ld bc, $0010` at `$1b80`) and twenty-two for the insert:

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

With all sixteen slots full the loop runs into `$c200`, `wMasterPalettes` (the
master BG+OBJ palettes every fade scales from). A registration lands in the
first of six palette "records" (BG palettes 0-2) whose bytes 1-3 are zero — a
black colour — and overwrites it; if there is none, the task is dropped. The
task never runs, since the runner stops at sixteen, and cannot be unregistered.

The trailing `ld a, b` / `or a` / `jr nz, .done` copies the duplicate-check
idiom at `$1b96`, but `b` is 0 on every path and the target is the next
instruction: four dead bytes where a table-full handler was.

It is latent. The heaviest user found, bank `$17`'s drill briefings
(`DrillBriefing_SpinServe`, `$17:$5817`), registers five to seven tasks per page
and calls `ClearFrameTasks` between pages, and the duplicate check stops double
registration, so no known path nears sixteen live tasks.

**Fix** (`make FIXES=1`): the insert loop runs sixteen records, `ld c, $10`.
A full table still drops the new task silently, as it always did in effect.

### `GetActorStateAddr` destroys the answer it was asked for

`GetActorStateAddr` (`$0a:$4312`) maps an actor id to its `$40`-byte state
struct and should report whether the actor is active:

```
        ld a, [hl]               ; the actor's activity byte, struct + $20
        cp $00
        pop hl
        inc h                    ; <- clobbers Z
        dec h
        ret
```

`inc h` / `dec h` overwrites the `cp $00` result with a test of the struct
pointer's high byte (`$d0`-`$d5`, or `$d0` for the out-of-range case, which
uses `hl = wActors`), so the routine always returns NZ. The idiom is a guard on
a caller-supplied `hl` elsewhere in the bank — `CheckActorScriptEnd`
(`$0a:$438a`), `IsActorBusy` (`$0a:$476c`, after an `xor a`) and
`UnusedSetActorMoveTarget` (`$0a:$4750`) open with it, and
`CheckActorScriptEnd` returns its own `cp $00` intact. Here it sits after the
answer.

Eleven call sites — `ScriptSetActorMoveSpeed` (`$433b`),
`ScriptSetActorMoveTarget` (`$4408`), `SetActorActive` (`$472e`) and eight more
— do `ret z` or `jr z, .done` right after the call. All those guards are dead,
so the script engine writes into inactive actors' state. Nothing visible
follows: the draw loop (`$04:$4aae`) calls `DrawAndAnimateActor` only when the
activity byte is `$02`, so an inactive actor given a move target walks
invisibly and is re-initialised when it next spawns. An id of `$18` or more
would alias the player via `wActors`, but the highest actor id any `script_*`
command names is `$17` (`$15:$4f5e`).

### The ball-contact window's animation-state test decides nothing

`CheckBallContactWindow` (`$08:$6fa7`), called by `UpdateCharBallGeometry` every
frame the ball is in swing range (`$08:$6ebb`), loads the X half-width from
`wCharReachX` and picks a modifier:

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

All four arms target `$6fed`, the fall-through. `CharRallyEndState`
(`$08:$6a90`) tests the same membership (`$05`, `$06`, `$07`, `$09`, `$0a`,
`$0b`, `$12`) with a real body; the ids are swing animations (`$05`/`$06` are
the forehand and backhand `$08:$6e58`/`$6e5e` select into `wCharSwingAnim`).
So the contact window is `wCharReachX` (1.25x when `wCharFlags` bit 1 is set)
in every state. What the swing states were meant to change is not in the ROM.
Same shape as `Unused_6b_RewriteCutsceneCameraY` below, but live on the rally
path.

### The Training Court's stage normalisation can never run

`TrainingCourtInitScript_15` (`$15:$532e`) opens:

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

`ComputeStoryRankTier_15` (`$15:$7fa0`) counts at most four flags (junior
title, senior title, then the singles or doubles Island Open pair), so its
maximum is `$04` on both ladders and the subtraction is unreachable. It implies
a second id space (`$06 + n`) in the same byte, but nothing sets it that way,
and the compute call overwrites the byte first anyway. What the six meant is
not recoverable.

### The doubles clear-status path clears the singles wins

`SetDoublesRankingClearFlags` (`$0a:$4e75`), the doubles half of the developer
clear-status tool (`RunClearStatusSetupMenu`, `docs/story_mode.md`), copies the
singles clear loop — `ld c, $09` / `ld de, $0a00`, nine flags from byte `$0a`
bit 0 — so it clears `FLAG_WON_JUNIOR_SINGLES_RANK_4` through
`FLAG_WON_VARSITY_SINGLES_RANK_4`, then sets the doubles wins from
`DoublesRankingClearFlagList_0a`. The doubles block at bytes `$08`/`$09` is
never cleared: a doubles "Set" keeps higher doubles wins already saved and
wipes the singles ladder. Reachable only through the developer menu.

**Fix** (`make FIXES=1`): the clear starts at
`FLAG_WON_JUNIOR_DOUBLES_RANK_3`, nine flags over the doubles block.

### `GetSpeakerVoice` returns through the wrong stack slot

`GetSpeakerVoice` (`$05:$608a`) pushes `bc`, `de` and `hl`, then
`push_wram_bank WRAM_ACTORS`, and reads the speaker's type byte (actor `+$21`).
A type below `$1e` takes `bit 7, a / jr nz, .done`, past the `pop_wram_bank`,
so `.done`'s `pop hl / pop de / pop bc` each take the wrong word and `ret`
jumps to the entry value of `bc`. `ShowSpeakerDialogue` loads `b` with `$08`
just before the call, so control lands in ROM0 `$08xx`, inside
`Unused_00_CopyMapToScrollBuffers`. When the partner speaks in the awards
ceremony (location `$1a`, entry 11), `bc` is `$0880`: the operand of a
`ld c, $20`, which runs as `jr nz` into `Unused_00_CopyMapRows32To64`'s fill.
Each `ret` from there pops one of `ShowSpeakerDialogue`'s saved registers as an
address (`$0520`, `$0297`, `$0280`, `$0220`, `$2897`): fragments of
`QueueBGTileWrite`, `LoadOBJPaletteData`, `LoadBGPaletteData`,
`CopyDataFromBank` and `SerialHandler`. On the way it writes the MBC's
RAM-enable and ROM-bank registers and one byte of BG palette RAM, then the
`SerialHandler` tail unwinds the stack past `ShowSpeakerDialogue`.

The game reaches that entry only in doubles: the firework scene (`$14:$664a`)
sends doubles to entry `$0b` and singles to `$0a`. In doubles the original
takes the wild return each time the partner speaks and still comes back into
the dialogue, showing the same lines as the fixed build with its text a
character or two behind (the returned voice differs). A build whose ROM0 has
moved even three bytes crashes at the first wild return.

Forced into entry `$0b` from singles, the partner's "Way to go, Alex!
Congratulations" is skipped, the second wild return changes BG palette 0's
colour 3 so later dialogue boxes are red, and in 19 of 20 singles states a
return through the unbalanced stack lands in ROM bank `$d1` about 650 frames
later and crashes (`rst $38`, stack out of RAM) — the event test's 19
awards-ceremony crashes.

**Fix** (`make FIXES=1`): the early exit jumps to a `.restoreBank` label
before `pop_wram_bank`, so the stack is balanced on every path. The event test played the
fixed build against the original over every story state and location: the
original took the wild return at the awards ceremony (location `$1a`, entry
11) in all 36 states, and the fixed build ran every one of them through,
singles states included, and showed the lines.

### Map reads off the edge have no bounds check

`GetCollisionMapCellAddr` (`$0a:$5edd`) and `GetBehaviorMapCellAddr`
(`$0a:$5f31`) turn a tile position (`d` = x, `e` = y, the high bytes of an
actor's coordinates) into an address in the 32 × 32 `wCollisionMap` /
`wBehaviorMap` without clamping. An actor off the map — the Test map lets the
player walk off its top edge — indexes up to `$10df` past the `$400`-byte
maps: `wBehaviorMap` reads reach echo RAM up to `$e4df`, mirroring
`$c000`-`$c4df` (including `wFrameTasks`' ROM pointers), and `wCollisionMap`
reads land mostly in the top of WRAM bank `$06`. Collision and triggers there
are whatever those bytes say, so one layout lets the player wander on and
another fires an exit.

### Courtyard entry `$0a` would read its walk-in direction from code

`CourtyardEntryWalkIn_13` (`$13:$62ff`) walks the player in using
`CourtyardEntryWalkInFacings_13[entry - 1]` (the partner `[entry + 2]`), a
six-byte table of two three-entry halves for entries 1-3.
`CourtyardEntryPoints_13` also lists `$0a`, `$0d`, `$0e` and `$0f`, but
`CourtyardInitScript_13` sends the last three to their own scenes, so only
`$0a` gets here. It reads byte 9 (byte 12 for the partner), instruction bytes
of `VarsityCourtTourCutscene`: the low byte of `ld hl, VarsityCourtTourActors_13`
becomes its angle, so the direction depends on where that label sits. Nothing
in retail enters the Courtyard at `$0a` (its row is `; debug warp only`).

## Dead stores

Values written and never read, and one table written past its end (the menu
stack, the only entry here that can change behaviour, and only when menus nest
deeper than play ever does). The rest change nothing; they are listed so they
need not be re-derived. The grayscale bug above is a dead store with a missing
counterpart.

### The menu stack has six frames and no depth check

`wMenuStack` (WRAM bank `$05`) holds six two-byte frames indexed by
`wMenuDepth * 2`, and `CreateMenuWindowFromText` pushes without a depth check.
A seventh nested menu writes its frame over `wMenuDepth` and the byte after it:
a runtime audit opening menus at random ended with `wMenuDepth` = `$20` (the
frame's first byte) and `$d83f` = the window id. Normal play never nests that
deep. Growing the stack only moves the limit (two free bytes follow
`wMenuDepth`, one more frame); the fix is a bound on the push -- after `inc a`,
`cp (wMenuDepth - wMenuStack) / 2` / `jr nc` past the frame write, keeping the
window id and cursor reset -- so a seventh menu leaves the stack as it was and
at worst unwinds one level early.

### Story character record `+$2f`

Three writes put a constant into byte `+$2f` of the `$40`-byte character
record: `InitCa00RecordFromCharId` writes `$03` on its main-character path
(`$02:$40b2`) and `$02` on its roster path when bit 6 of the id is set
(`$4117`), and the unreachable `Unused_02_LoadMainCharacterFromRoster` writes
`$00` (`$4465`). No code reads `+$2f` (nor `+$3d`-`+$3f`), and poisoning it
changed nothing; it is a record-type tag nothing consults
(`CHARREC_BUILD_KIND`). `+$2b` is live: `InitCa00RecordFromCharId` copies it
from the roster row and `LoadCharacterAttributes` adds it to Speed to pick the
shot-placement row (`CHARREC_SPEED_BONUS`).

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

`Unused_00_CopyMapToScrollBuffers` (ROM0, `$086c`) stages four 512-byte blocks
of a decompressed map through `wTextBuffer` and expands each into a 64-wide
plane with `Unused_00_CopyMapRows32To64` (16 rows of 32 bytes plus 32 zeros,
1024 bytes per plane). Two are then erased:

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

Each clear covers 2048 bytes from the base just filled, so planes 1 and 3 are
zeroed before anything reads them: 3072 bytes of copying discarded per call.
None of it runs: the only callers are `Unused_1a_ShowExpGainScreen`
(`$1a:$45d4`, `$1a:$475a`), unreachable too. The clears are what that caller
needs — in WRAM banks `$02`/`$03`, `$d800`-`$dfff` holds the EXP screen's
caption rows (`Unused_1a_ExpScreenDrawTask` uploads
`wCharDataPageSlot1 + 1 * TILEMAP_WIDTH` (`$d800`) to `$99e0`, and
`Unused_1a_DrawExpScreenCaption` renders into `$d82b`).

The two surviving expansions land at `$d000` in WRAM banks `$02` and `$03` at a
64-byte stride, while every other consumer of that address uses
`TILEMAP_WIDTH` = 32. Bank `$1a` never references `$d000` in either bank, so
nothing reads them either: the four 64-wide scroll planes the name describes
have no consumer.

### `ProjectBallSprite` reads the hit-streak table and throws the value away

`ProjectBallSprite` (`$0d:$5848`) indexes `MinigameHitStreakValueTable_0d` by
`wMinigameHitStreak` (deliberately, via the split-base `ld_hl_indexed`), loads
the entry into `b`, and overwrites it:

```
        ld b, [hl]                     ; $5862
        ld b, $0e                      ; $5863
        ret
```

The table holds `$0f, $0e ×6, $0d`, apparently a per-streak sprite tile (or
size) flattened to the middle value. The eight bytes and the lookup have no
effect.

### `ObjectArrayBUpdateCallback_18` stores the wrong register

The two per-object movement callbacks in bank `$18` advance an animation nibble
in object field `+$07` every 8 frames. Callback A does it correctly:

```
        ld a, [hl] / and $f0 / or d / ld [hl], a   ; $7e65
```

Callback B ends the identical sequence with `ld [hl], d` (`$7ec4`), storing the
new low nibble alone, so the field's high nibble is zeroed every time.

### The text interpreter's column-32 wrap is popped away

After drawing a printable glyph, the text interpreter (`$05:$4eba`) steps the
cell pointer in `de` and, when the column wraps to 0, computes `de - $20` —
then `pop de` (`$4ecb`) restores the stepped pointer over it. The wrap happens
anyway: before the next glyph, `WrapTextCellPointer` (`$05:$5413`) sees the
pointer's row differs from `wTextCursorRow` and subtracts `$20` itself, and
`TextCmdNewline` recomputes `de` from the row and column.

## A routine whose body is a no-op

`Unused_6b_RewriteCutsceneCameraY` (bank `$6b`, `$615e`) guards on
`wCutsceneStepTimer >= $14` and `[$c323]` nonzero, then:

```
        ld a, [$c323] / ld h, a       ; h = high byte
        ld a, [$c322] / ld l, a       ; l = low byte  ($c322 = wCameraY)
        ld a, h / ld [$c323], a       ; write h back
        ld a, l / ld [$c322], a       ; write l back
        ret
```

It writes back exactly what it read: a read-modify-write with the modify
deleted. Nothing reaches it (`tools/reach.py`), so it is an abandoned edit, not
a live no-op.

## Routines that return before their body

Routines that begin with `ret`, so their bodies never run. Twenty are one
family, listed here rather than under Bugs because what they do is coherent but
the intent cannot be settled from the code.

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
judge a point wins. Of the fifteen drills' 60 judges, 20 begin with `ret`:

* 9 drills disable `JudgeOnRallyTick` only (`StrokeMatch1`-`3`,
  `StrokePractice1`-`3`, `NetGamePractice1`-`3`);
* 5 disable `JudgeOnBounce` and `JudgeOnRallyTick` (`ServiceMatch1`/`3`,
  `NetGameMatch1`/`2`/`3`);
* 1 disables `JudgeOnBounce` while leaving `JudgeOnRallyTick` live
  (`ServiceMatch2`).

No drill disables `JudgeOnPointEnd` or `JudgeOnBallHit`. The effect is a
per-drill choice of which events can score a point. The per-drill variation is
consistent with deliberate configuration but does not prove it; nothing in the
ROM distinguishes that from an edit left behind.

### Leading `ret`s in front of real bodies

Four routines open with a `ret` in front of a real body, and two more have a
body with no effect. Two of the four are drill judges, counted above; all six
are named for the body, with the leading `ret` recorded in the note:

| routine | body |
| --- | --- |
| `NetGamePractice1JudgeOnRallyTick` | the drill's fourth judge |
| `StrokePractice1JudgeOnRallyTick` | the drill's fourth judge |
| `Unused_18_LoadFontTiles` | copies `FontTiles` to `$9000` |
| `Unused_1b_LoadUnlockDebugNavGridGfx` | decompresses and uploads debug-screen artwork |
| `Unused_02_CheckExpAwardAllowed` | the EXP-award gate — see below |
| `Unused_05_PagedMenuFrameTask` | a frame task whose body has no effect |

The 58 routines named `StubNop` (most of them `Unused_<bank>_StubNop*`) have a
bare `ret` for a body, which the name describes.

`Unused_02_AddExpToCa00RecordChecked` calls `Unused_02_CheckExpAwardAllowed`
and returns on z, but it cannot return z: `xor a` / `dec a` sets the flags from
`$ff` and the following `ld a, c` restores the caller's `a` without touching
them. The gate always passes, but its caller is itself unreachable. The
condition it was meant to test is not in the ROM.

`Unused_05_RunPagedTextMenuAutoSize`, itself unreachable, registers
`Unused_05_PagedMenuFrameTask` as a frame task and unregisters it when the menu
closes. Its body reads `wMenuCursorRow` into `a` and then `pop af` discards it.

### The scene viewer indexes the slot table with the wrong stride

`SceneGfxSlotTable` (`$0a:$59d9`) is 592 bytes = **37 records of eight slot
words**, and `GetSceneSlotPtr` (`$0a:$5d0b`) walks it correctly:

```
        ld l, a
        add hl, hl / add hl, hl / add hl, hl / add hl, hl   ; 16 * scene
        ld de, SceneGfxSlotTable
        add hl, de
        ld e, b / sla e / ld d, $00 / add hl, de            ; + 2 * slot
```

`Unused_0a_LoadSceneGraphicsDirect` (`$0a:$5d2a`) uses a different multiplier:

```
        ld l, a
        add hl, hl          ; 2a
        ld d, h / ld e, l   ; de = 2a
        add hl, hl          ; 4a
        add hl, hl          ; 8a
        add hl, hl          ; 16a
        add hl, de          ; <- 16a + 2a = 18a
```

592 is not a multiple of 18, and `LoadStorySceneGraphics` confirms the 16-byte
stride: it pushes slots 0-6 and pops them into `wCollisionMap`, `wBehaviorMap`,
`wScreenAttrmap`, `wShadowTilemap`, a palette load and a scene-config copy,
consistently across 21 records. The read slides `2 * scene` bytes: scene 0 is
correct, scene 1 reads slot 2 for slot 1, and scene 8 lands exactly on record 9,
another scene's graphics.

**Only debug code calls it.** Its one caller is
`Unused_0a_LoadAndDisplayScene` (`$0a:$5de2`), whose four callers —
`Unused_0a_SceneViewerSelectScene`, `UnusedSceneViewerSelectSceneMenu`,
`Unused_0a_InitSceneViewer` and `Unused_0a_InitSceneViewerDefault` — are the
scene viewer. Its entries are `UnusedSceneViewerMainLoop` (which calls
`Unused_0a_InitSceneViewerDefault` and `Unused_0a_SceneViewerSelectScene`),
`UnusedSceneViewerSelectSceneMenu` and `Unused_0a_InitSceneViewer`; the first
two are referenced nowhere, the third only by its directory slot (`$0a:$4072`),
which no `farcall` uses. (`Unused_0a_RunSceneSelectDebugMenu` is a separate
picker that calls `LoadStorySceneGraphics` directly.) No `farcall` to
`Unused_0a_LoadAndDisplayScene` exists outside bank `$0a`, despite its directory
slot at `$4078`.

### A superseded save-repair family in bank `$03`, unreachable

`$03:$553b`-`$5669`, between `RestoreStoryBlockFromBackup`'s `ret` and
`RepairAllSaveSlots`, holds **eight complete routines** with no way in: an
earlier, hardcoded version of the live repair.
`Unused_03_RestoreBlock06FromBackup` through `..._RestoreBlock0aFromBackup` are
five copies of one routine with the block id baked in, flanked by
`Unused_03_RestoreBlockOrClear`, `Unused_03_InvalidateBlockIfUnwritten` and
`Unused_03_ClearBlockIfSet`. Their replacement, `RepairAllSaveSlots`
(`$03:$5669`), calls `RestoreStoryBlockFromBackup` three times with `b` = 0, 2,
4, and the callee derives the backup block with `ld a, $1b / add b`.

Nothing references any of it. Scanning bank `$03` for every address in the
span, as a same-bank `dw` or a `call`/`jp` operand, yields five coincidences:
`41 56` is the "AV" of "SAVED", `2a 56` is an `ld a, [hl+]` / `ld d, [hl]` pair
at three sites, and `21 56` is the low operand byte of an `ld hl`.

**18 of the bare banked-WRAM operands left raw in the source are in here**, and
no amount of play can prove them. (They had been attributed to
`RestoreStoryBlockFromBackup`, whose own body resolves cleanly to
`wDecompBuffer`.)

### A confirm-screen suite in bank `$1b` that nothing can reach

`$1b:$69d9`-`$6aa0` holds seven complete routines with no way in. They follow
three bare `ret`s, `Unused_1b_StubNop_1b_09`, `Unused_1b_StubRet1` and
`Unused_1b_StubRet2`; the first is registered as a no-op frame task
(`$1b:$69b9`/`$69c5`) by `Unused_1b_RunStoryDataConfirmMenu` around
`Unused_18_RunTwoOptionSelectB`, both unreachable as well.

They are a working screen: `Unused_1b_ShowHighScoreConfirmScreen` sets
`wMinigameHighScoreMode`, fades out, calls `Unused_18_InitConfirmScreen`,
flushes and fades back in; five siblings draw one prompt each with its Yes/No
labels — "Erase?" (with the player's name pushed as a text argument through
`Unused_1b_CopyMainCharNameWithDiacritics`), "Erase it? Really?", "Continue?",
"Is this correct?" and "Char. and item data." twice; and
`Unused_1b_DrawGameTimerRow` renders `wGameTimer` as `hh:mm:ss` with the `$3a`
colon glyph, then queues the row to VRAM.

Nothing references any of it. A ROM-wide scan for each of the 200 candidate
entry addresses, as a same-bank `dw` or a `farptr`-shaped word followed by bank
`$1b`, returns seven coincidences: `11 6a d0` is the `ld de, $d06a` in a
neighbouring routine, `cd ae 6a` is a call within the span itself, and the rest
land in graphics data in banks `$2f`, `$36` and `$70`.

11 of the bare banked-WRAM operands left raw in the source are in this span,
and no amount of play can prove them.

### The whole developer debug harness is unreachable, and its unlock flag is never read

`InitAndRunGame` (`$01:$4018`) is the retail boot routine: `SoftReset` farcalls
it unconditionally (`$00:$262c`, followed by `stop`), and it clears WRAM banks
1-6, validates and repairs SRAM, applies the unlock flags, initialises story
state and match settings, enables the LCD, and at `.loop` (`$40a5`) sets
`wStoryModeCurrentLocation` to `STORYLOC_MAIN_MENU` and calls
`RunStoryModeOverworld` — the entire game.

Past that call, `.loopB` (`$40b2`-`$40eb`) prints the build stamp, sets
`hDebugStepMode` to 3, sets the save flag on A and reruns the overworld on
START, ending in `jp .loopB`. After it sits a **complete debug dispatcher**
(`$01:$40ec` onward) that polls `hInputPressed`:

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

A further block (`$419e`), which the dispatcher never enters (the UP branch
loops forever before it, and the bit-6-clear branch jumps past it to `$41c2`),
runs `ShowEquipmentStatusScreen`, `RunMatchStatsScreen`, `ShowLinkErrorScreen`,
`ShowLinkMessageScreen`, `RunShoesSelectScreen`, `RunRacketSelectScreen` and
the character viewer.

**Nothing reaches any of it.** No instruction jumps to `$40ec`, and nothing
falls into it: the code above ends `jp .loopB` (`$40e9`). `.loopB` itself runs
only if the `farcall RunStoryModeOverworld` at `$40af` returns, which it never
does in normal play. Hence the `Unused_01_*` names.

`SAVEFLAG_DEBUG_TEST_MENU` (#63) has exactly two references, both here: it is
**cleared** unconditionally at boot (`$401c`) and **set** if A is held at
`$40c6`, inside `.loopB`. No instruction tests it, so the "hold A to enable the
test menu next boot" gesture would store a bit in SRAM that nothing reads.

The *in-game* debug menu is reached differently: `RunStoryLocation`'s frame
loop calls `RunDebugMenu` (`$05:$66a0`) whenever `hDebugStepMode` is nonzero
and no script or tile trigger is active (`$0a:$50b4`). That one is live, with a
warp menu, a text subcommand, a palette editor and a game-flag editor. But only
`InitAndRunGame`'s `.loopB` (`$01:$40bd`) and the `Unused` debug screens set
`hDebugStepMode`, so it is unreachable in practice too — by one byte, not by a
missing jump.

### The in-match stats editor has no live entry

`CheckDebugStatsEditorHotkey` (bank `$08`, `$44ef`) is called by
`StepMatchFrame` (`$08:$4489`) on every unfrozen match frame, right after
`HandlePauseMenu`, and begins with `ret`:

```
CheckDebugStatsEditorHotkey:
        ret                          ; <- $44ef
        call ReadMatchInputPressed
        and $04                      ; SELECT
        ret z
        ldh a, [hDebugStepMode]
        and a
        ret z
        ...                          ; $ff to wMatchSimFrozen, wMatchDrawFrozen
        farcall Unused_06_RunDebugStatsEditor
        ...                          ; $00 to both
        ret
```

That `farcall` is the only reference to `Unused_06_RunDebugStatsEditor`
(`$06:$6b84`) besides its slot in bank `$06`'s `$4000` directory, which no
indexed dispatch reaches. So the `ret` orphans a working in-match editor:
`Unused_06_RunDebugStatsEditor` plus `Unused_06_DrawDebugStatsLabels`,
`Unused_06_DrawDebugStatsValues` and `Unused_06_HandleDebugStatsInput`,
referenced from nowhere else. The body is guarded by `hDebugStepMode` anyway,
so the `ret` may have been deliberate; the ROM does not distinguish that from
an editing accident.

## Glyph stream underrun below the glyph tile buffer

`PlotGlyphRow` (`$05:$737a`) turns the glyph pen position into a byte offset
with a signed shift (`sra d / rr e` three times) and adds it to
`wGlyphTileBuffer` (bank `$07`, `$d300`) with no bounds check, so a negative pen
writes below the buffer. At a line break `DrawInlineGlyph`'s `.eq01` path (code
`$01`) seeds the pen from the row's starting glyph-tile column,
`wTextRowColumn`:

        ld e, $00
        ld d, c          ; c = wTextRowColumn
        sra d            ; pen = column * $80, sign-extended from bit 7
        rr e

A row starting at column `$80` or above gets a pen `(column - $100) * $10`
bytes below `$d300`: `$88` lands at `$cb80` in WRAM0, `$c0` at `$cf00`, the
stack.

* The lesson menu's second page starts just past `$80`, and five glyph tiles
  land at `$d2b0-$d2ff` (seen by RAM poisoning). Nothing lives there, so it is
  harmless in the retail layout, but anything allocated there would be
  overwritten by text.
* The Test2 debug location's "clear status" screens start their glyph rows at
  column `$78`, `$10` columns per row, carrying on from one prompt or menu to
  the next. The row at `$88` writes at `$cb80`; by `$c8` the writes reach
  `$cf80`, on the stack, and the game jumps into the stack (seen as
  `PC=$cf7b`). Reachable only from the debug warp menu.

There is no **Fix**. Column `c` of the buffer is BG tile `$80 + c` (it is
uploaded to `vTiles1`, 16 bytes per column), so the buffer has room for 128
columns, and a row starting at `$80` has no tile to draw into either way: `sra`
writes below the buffer, `srl` would write past its end. Both screens run out
of glyph tiles, and what they should do instead -- start a new window's columns
from 0, or reuse the first page's -- is not in the ROM. Masking the offset would
stop the crash but move the lesson menu's five stray tiles into columns
`$7b`-`$7f`, uploaded over BG tiles `$fb`-`$ff` on a screen the retail game
shows, so it is not applied.
