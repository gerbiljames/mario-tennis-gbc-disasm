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

Cross-references point at `docs/STATUS.md` where a find is written up in more
detail.

## Bugs

### Grayscale conversion drops the blue channel

`ConvertColorToGrayscale` (bank `$1d`, `$7210`) splits a CGB colour into its
three components, then averages them:

```
        ld a, e / and $1f            ; red
        ld [$d000], a
        ...                          ; green
        ld [$d001], a
        ld a, d / and $7c / rrca / rrca   ; blue
        ld [rRAMG + 2], a            ; <- should be [$d002]
        ld a, [$d000]
        ld hl, $d001
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

Recorded earlier in STATUS's 2026-07-17 naming pass, which called the write a
no-op; it is a RAM-gate write whose *effect* is benign. It renders as
`ld [rRAMG + 2], a` since the MBC registers were named, which makes it visibly
wrong rather than looking like an ordinary store to a low address.

### The save mirror re-check compares the wrong signature

The header region `$a000-$a7ff` is mirrored into SRAM bank 1 after every write.
On boot `ValidateSaveRam` (bank `$03`) checks the signature and master checksum;
on failure it restores bank 1's mirror and re-checks — but the re-check compares
the signature at `$a000` instead of `$a020`, so it always fails.

The recovery path is therefore dead: a corrupt header always falls through to a
full wipe and re-init, and the mirror it just restored is discarded. See
`docs/save_format.md`.

### The link-error check can never fire

`AdvanceFrame` (ROM0, `$2635`) guards every frame with:

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
after its caption, because the caption is not what it does. See STATUS.

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
`bit 7, l` / `ld h, $ff`, and `$0a:$59b2` adds them to `hScrollX`/`hScrollY`.

So the offsets are always `0..mask` and never negative: the shake displaces the
view in one direction only, by 0-1, 0-3 or 0-7 pixels for magnitude 1, 2 or 3,
with a mean displacement of half the mask instead of a jitter centred on the
camera. The `ld h, $ff` arms at `$04:$4a37` and `$04:$4a6b` are dead as a
consequence.

The sign decision cannot be repaired in place — `and` fixes carry at 0, so no
ordering of these instructions makes the `jr nc` conditional. Whatever produced
the sign (a bit of the random word, most likely) was never written.

### A collision-map read is discarded, so one terrain type never slows the player

`UpdatePlayerControl` (bank `$04`, `$5170`) picks the player's walk speed. The
running branch sets `$0040`; the walking branch is meant to check the terrain
under the player first:

```
.checkBlocked:
        ld hl, $000d / add hl, bc / ld d, [hl]
        ld hl, $000f / add hl, bc / ld e, [hl]
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

### The white fade can never be selected

The fade engine has two ways to scale a palette. `UpdateFadeOut` and
`UpdateFadeIn` share a tail that picks between them on bit 7 of `hFadeState`:

```
.step2:
        ldh a, [hFadeState]
        add a
        jr nc, .noCarry2         ; -> AdjustColorsBrightness (fade to black)
        ld a, c / and $04
        call z, ApplyWhiteFade
```

`hFadeState` is written in five places: `$1d28` stores `$01`, `$1d36` stores
`$02`, `$1d97` and `$261e` store `$00`, and only `$1d1b` sets bit 7 — with
`or $80`, inside the unlabelled routine at `$00:$1d0f` that nothing in the ROM
references. Bit 7 is therefore never set, `add a` never carries, and
`ApplyWhiteFade` (`$00:$1dcc`) never runs even though it is reached by a live
`call z`.

Every fade in the game is a fade to black. The white-fade code and the routine
that would have armed it both shipped dead; `docs/screens_and_ui.md` records
`ApplyWhiteFade` as unreachable, and the reason is a flag with no writer — the
same shape as the link-error check above.

### `LoadMenuTilesBStaged` uploads palettes and code to VRAM as tiles

Bank `$01` has two loaders for the same menu tile set. The plain one splits it
into two transfers:

```
LoadMenuTilesB:
        ld hl, MenuFontTiles_01     / ld de, $9200 / ld c, $60 / call QueueVRAMCopy
        ld hl, MenuFontFillTiles_01 / ld de, $8800 / ld c, $60 / call QueueVRAMCopy
```

The staged one (`$01:$5095`, reached from `LoadMenuFontGfxStaged`, which bank
`$06` farcalls at `$6ea0` when the story overworld resumes) splits the first
transfer into three `$200`-byte chunks with an `AdvanceFrame` between them, and
then does this as its fourth chunk:

```
        ld hl, MenuFontPalettes_01   ; <- $5010, a 64-byte palette block
        ld de, $8e00
        ld c, $20                    ; 512 bytes
        call QueueVRAMCopy
```

`MenuFontPalettes_01` is a palette — `LoadMenuFontPalette` hands the same label
to `LoadPaletteShadow`. Copying `$20` tiles from it puts 64 bytes of palette
data followed by 448 bytes of the routines at `$5050`-`$520f` (including
`LoadMenuTilesBStaged` itself) into VRAM at `$8e00`-`$8fff`, i.e. tiles `$f0`-`$ff`
of the `$8800` block.

The staged path also never uploads `MenuFontFillTiles_01` at all, so
`$8800`-`$8dff` keeps whatever the previous screen left there. The address
progression makes the edit legible: `$9200`, `$9400`, `$9600`, then a fourth
chunk that lands at `$8e00` — the last of the four `$200`-byte slices that would
have covered `$8800`-`$8fff`, with the first three missing and the source label
of the survivor wrong.

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

`ReadBehaviorMapCell` (`$0a:$5f4e`) reads one behaviour-map cell and then, with
no guard of any kind:

```
        ld a, b
        push de
        push af
        ld a, a                  ; no-op
        ld de, $0e0e
        call PrintHexByte
        pop af
        pop de
```

`PrintHexByte` formats the byte and `PrintString` writes it into
`wDebugTextBuffer` at row 14, column 14, then sets `hDebugTextDirty`. Debug
instrumentation that shipped in the cartridge: five call sites reach it,
including `$04:$5145` on the overworld movement path, so every behaviour-map
lookup pays a hex format plus a string print.

Nothing is corrupted and nothing is visible. The buffer is uploaded to
`$9d00` — a cell of the `$9c00` tilemap, which the BG map select never points
at during normal play — and that upload happens inside `UpdateDebugOverlay`,
which the VBlank handler skips unless `hDebugStepMode` is nonzero. So in a
retail run the two hex digits are written to RAM forever and read by nobody.

### The glyph buffer's "keep" branch is unreachable

`PrepareGlyphBuffer` (`$05:$72dd`) chooses between starting a fresh glyph run
and continuing the current one:

```
        ld a, [wGlyphBufferHoldCount]
        or a
        jr nz, .keepBuffer
        wram_bank $07
        call ClearGlyphBuffer
        call ResetGlyphStream
        jr .done
.keepBuffer:
        ld a, [wGlyphRowStartCol]
        ld [wGlyphFlushedCol], a
```

`wGlyphBufferHoldCount` (`$d822`, WRAM bank `$05`) has exactly one producer:
`DrawTileAttrRect` (`$05:$4552`) decrements it at `$45d3`. `DrawTileAttrRect`
has no callers — it appears in the bank `$05` `$4000` directory only, as the
`farptr DrawTileAttrRect` slot at `$05:$4020`, and there is no
`farcall DrawTileAttrRect` anywhere in the ROM, and the only indexed slot references (`dslot`) are data pointers in
banks `$0a` and `$039`. Nothing increments the count at all.

So the count is whatever `ResetTextWindowState`'s block clear left, i.e. 0,
forever; `PrepareGlyphBuffer` always clears and resets, and `.keepBuffer` is
dead. This answers the open question in `docs/screens_and_ui.md` about what
raises the hold count: nothing does, and the routine that would have consumed it
is not called either. `wShadowTilemapReadOffset` (`$dc76`) is the same shape with
the halves reversed — `RefreshShadowTilemapFromMapBuffer` (`$05:$44ba`) adds it
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
`wBGPalettes`/`wOBJPalettes`. The seventeenth registration writes its record over
the first two colours of BG palette 0, the eighteenth over the next two, and so
on for six records (24 bytes, BG palettes 0-2). The task itself never runs, since
the runner stops at sixteen, and `UnregisterFrameTask` cannot remove it either.

The trailing `ld a, b` / `or a` / `jr nz, .done` is the fossil that leads here:
it is a copy of the duplicate-check idiom at `$1b96`, but `b` is 0 on every path
that reaches it, and the target is the next instruction, so it is two dead bytes
where the table-full handler was. Both halves of the overflow story are missing —
the bound is wrong and there is nothing to run when the bound is hit.

It is latent in practice. The heaviest user found is bank `$017`'s drill
briefings (`DrillBriefing_SpinServe`, `$17:$5817`), which register five or six
tasks per page and call `ClearFrameTasks` between pages, and the duplicate check
stops a routine being registered twice, so no path found here gets near sixteen
live tasks.

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
is the *first* thing a routine does, guarding an `hl` handed in by the caller:
`CheckActorScriptEnd` (`$0a:$438a`), `IsActorBusy` (`$0a:$476c`) and the
unlabelled routine at `$0a:$4750` all open with it. `CheckActorScriptEnd` is the
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
        bit 1, a
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
engine assumes. This is the same shape as `RewriteCutsceneCameraY_6b` below — a
read-modify-write with the modify deleted — except that this one is live code on
the rally path.

### The Training Court's stage normalisation can never run

`TrainingCourtInitScript_15` (`$15:$532e`) opens by computing the location's
progress index, then normalising it:

```
        call ComputeTrainingCourtProgressIndex
        ld a, [wMapSceneStage]
        cp $05
        jr c, .fromLesson        ; always taken
        ld a, [wMapSceneStage]   ; unreachable
        sub $06
        ld [wMapSceneStage], a
.fromLesson:
```

`ComputeTrainingCourtProgressIndex` (`$15:$7fa0`) starts at `$00` and steps with
`inc a` through at most four flags — junior title, senior title, then either the
singles or the doubles pair of Island Open flags. Its maximum output is `$04`,
on both ladders. The `cp $05` therefore always sets carry, the branch is always
taken, and the three instructions that subtract 6 are unreachable.

The subtraction is the shape of a *second* id space living in the same byte: a
caller that had set `wMapSceneStage` to `$06 + n` and wanted `n` back. Nothing
sets it that way any more — the compute call one instruction earlier overwrites
whatever was there, so even a caller that did would lose it. What the six
would have meant is not recoverable from the ROM.

## Dead stores

Values written and never read. None of these change behaviour; they are listed
because each one is a loose end that a future reader will otherwise re-derive,
and because the class is worth watching — the grayscale bug above is a dead
store with a missing counterpart.

| symbol | where | note |
| --- | --- | --- |
| `wShotAimRow` | every shot bank | the aim row is computed, stored, and used from `a`; the store is a leftover |
| `wUnusedDrillPointStartByte` | bank `$0b` | cleared by `ServiceMatch2Hook_PointStart` |
| `wUnusedExitTriggerIdMirror` | story engine | write-only mirror of `wStoryModeExitTriggerRequest` |
| `wCharObjectDefId` | bank `$04` | the object-def id `SetupCharSpriteFromObjectDef` was handed |
| `hUnusedLinkByte`, `hUnusedLinkSlot` | serial init | cleared by both link init routines, read by nothing |
| `hLinkLastRxMirror` | bank `$07` | written beside `hLinkLastRxByte`, never compared |
| `hUnusedLinkSelectByte` | bank `$38` | written twice by `RunLinkCharSelectScreen` |
| `wCharSwingHoldFrames` | bank `$08` | `CheckSwingRelease` increments it once per windup frame (`ld hl, $df4e` / `inc [hl]`) and zeroes it on release; no site reads the count, so the charge mechanic it fed is gone |
| `wCharSwingHoldButton` | bank `$08` | written on three paths beside the frame count, consumed on none |
| `wCharWalkTargetFlag` | bank `$08` | zeroed immediately after each write of `wCharWalkTargetX`/`Depth`, at `$69bc` and `$7c82` |

### `CopyMapToScrollBuffers` throws away half the work it does

`CopyMapToScrollBuffers` (ROM0, `$086c`) stages four 512-byte blocks of a
just-decompressed map through `wTextBuffer` and expands each into a 64-wide
plane with `CopyMapRows32To64` (16 rows of 32 source bytes followed by 32
zeros, so 1024 bytes written per plane). Two of the four are then immediately
erased:

```
        ld hl, wTextBuffer / ld de, wMapScrollPlane1 / call CopyMapRows32To64
        ld hl, wMapScrollPlane1        ; $08b3
        ld c, $80                      ; 2048 bytes
        call ClearMemory16
        ...
        ld hl, wTextBuffer / ld de, wScreenScratch / call CopyMapRows32To64
        ld hl, wScreenScratch          ; $08fb
        ld c, $80
        call ClearMemory16
```

Both clears start at the base the expansion just filled and cover 2048 bytes —
twice what was written — so every byte of planes 1 and 3 is overwritten with
zeros before anything can read it. Per call that is 3072 bytes of copying
discarded: two 512-byte staging copies plus two 1024-byte expansions.

The clears themselves are load-bearing, which is why this is a dead store and
not a broken screen. The only two callers are `ShowExpGainScreen`
(`$1a:$45d4`, `$1a:$475a`), and in WRAM banks `$02`/`$03` the cleared region
`$d800`-`$dfff` is where the EXP screen keeps its caption rows —
`ExpScreenDrawTask` uploads `wCharDataPageSlot1 + 1 * TILEMAP_WIDTH` (`$d800`)
to `$99e0`, and `DrawExpScreenCaption` renders into `$d82b`. The clear is the
initialisation the caller depends on; the expansion feeding it is not.

The two surviving expansions land at `$d000` in WRAM banks `$02` and `$03` and
write their 32-byte rows at a 64-byte stride, while every other consumer of that
address addresses it at `TILEMAP_WIDTH` = 32. Bank `$1a` never references
`$d000` in either bank, so nothing reads those two either. What the routine's
name describes — four 64-wide scroll planes — has no consumer in the shipped
ROM.

## A routine whose body is a no-op

`RewriteCutsceneCameraY_6b` (bank `$6b`, `$615e`) guards on
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

Nothing calls it in any traced run, and no proven code takes its address, so it
may simply be an abandoned edit rather than a live no-op. It is recorded here
because the shape is a bug's fingerprint: the read/write-back pair is what a
read-modify-write looks like with the modify deleted. Found by seeding it as
code, which is why it read as 30 bytes of data until 2026-07-29.

## Routines that return before their body

Routines in the ROM that are *called* but begin with `ret`, so their bodies
never run. Twenty of them are one family, and they are listed here rather than
under Bugs because what they do is coherent — but the intent behind them is not
something the code can settle, so this section claims only what is observable.

Each drill in bank `$0b` has four judging routines, one per hook, which pass an
event code to that drill's `JudgePoint`:

| routine | hook | event code |
| --- | --- | --- |
| `<Drill>JudgeOnPointEnd` | `Hook_PointEnd` | 0 |
| `<Drill>JudgeOnBallHit` | `Hook_BallHit` | 1 |
| `<Drill>JudgeOnBounce` | `Hook_Bounce` | 2 |
| `<Drill>JudgeOnRallyTick` | `Hook_RallyTick` | 3 |

`JudgePoint` dispatches on `wRallyLength` and then on the event code, and
returns early if `wDrillPointJudgement` is already set, so the first event to
judge a point wins.

Fifteen drills, four judges each, 20 of the 60 beginning with `ret` — and
**which** ones varies:

* 9 drills disable `JudgeOnRallyTick` only (the stroke and net-game practice
  drills);
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

### The names were hiding some of them

Six routines of this shape were named after the `ret` rather than the body, and
two of those were drill judges — which is why the counts above were first
written as thirteen drills and 52 judges instead of fifteen and 60. They are
named for what they do now, with the leading `ret` recorded in the note:

| was | is | body |
| --- | --- | --- |
| `StubNop_0b_5d63` | `NetGamePractice1JudgeOnRallyTick` | the drill's fourth judge |
| `StubNop_0b_6ceb` | `StrokePractice1JudgeOnRallyTick` | the drill's fourth judge |
| `StubLoadFontTiles` | `LoadFontTiles` | copies `FontTiles` to `$9000` |
| `StubNop_1b_664a` | `LoadUnlockDebugNavGridGfx` | decompresses and uploads debug-screen artwork |
| `StubAlwaysNotZero` | `CheckExpAwardAllowed` | the EXP-award gate — see below |
| `StubNop_05_49dc` | `PagedMenuFrameTask` | a live frame task whose body has no effect |

The other 32 `StubNop_*` labels have a bare `ret` for a body and keep the
name, which for them is accurate.

`CheckExpAwardAllowed` is worth its own line. `AddExpToCa00RecordChecked` calls
it and returns on z, but it cannot return z: `xor a` / `dec a` sets the flags
from `$ff` and the following `ld a, c` restores the caller's `a` without
touching them. The gate always passes and the award always happens. Whatever
condition it was meant to test is not in the ROM.

`PagedMenuFrameTask` is the other interesting one: it is genuinely registered
per frame by `RunPagedTextMenuAutoSize` and unregistered when the menu closes,
so the plumbing around it is real — but the body reads `wMenuCursorRow` into `a`
and then `pop af` discards it. The task runs and does nothing.

### The scene viewer indexes the slot table with the wrong stride

`SceneGfxSlotTable` (`$0a:$59d9`) is 592 bytes = **37 records of eight slot
words**, and `GetSceneSlotPtr` (`$0a:$5d0f`) walks it correctly — four
`add hl, hl` for `16 * scene`, then `+ 2 * slot`:

```
        ld l, a
        add hl, hl / add hl, hl / add hl, hl / add hl, hl   ; 16 * scene
        ld de, SceneGfxSlotTable
        add hl, de
        ld e, b / sla e / ld d, $00 / add hl, de            ; + 2 * slot
```

`LoadSceneGraphicsDirect` (`$0a:$5d2a`) computes a different multiplier from the
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
is `LoadAndDisplayScene` (`$0a:$5de2`), and that routine's four callers are
`SceneViewerSelectScene`, `InitSceneViewer` and `InitSceneViewerDefault` — the
scene viewer, which hangs off `RunSceneSelectDebugMenu` and is reachable only
through the in-game debug menu (itself gated on `hDebugStepMode`, which nothing
in the retail build sets). No `farcall` to `LoadAndDisplayScene` exists outside
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
the bare banked-WRAM operands `tools/ram_gaps.py` lists as `unproven` are in
here**, and no amount of play can prove them. They had been attributed to
`RestoreStoryBlockFromBackup`, whose own body resolves cleanly to
`wDecompBuffer`, which made the routine look half-analysed when it was complete.


### A confirm-screen suite in bank `$1b` that nothing can reach

`$1b:$69d9`-`$6aa0` holds seven complete routines with no way in. They sit
immediately after `StubNop_1b_09` — three bare `ret`s that *are* legitimately
used, registered as a no-op frame task around `RunTwoOptionSelectB`
(`$1b:$69b9`/`$69c5`) — so the disassembler attributes the whole run to that
label, which is why they read as part of a stub.

They are a working screen: `Unused_1b_ShowHighScoreConfirmScreen` sets
`wMinigameHighScoreMode`, fades out, calls `InitConfirmScreen`, flushes and
fades back in; five siblings draw one prompt each with its Yes/No labels —
"Erase?" (with the player's name pushed as a text argument through
`CopyMainCharNameWithDiacritics`), "Erase it? Really?", "Continue?", "Is this
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
of the bare banked-WRAM operands `tools/ram_gaps.py` still lists as `unproven`
are in this span, and no amount of play can ever prove them, because the code
does not run.

### The whole developer debug harness is unreachable, and its unlock flag is never read

`InitAndRunGame` (`$01:$4018`) is the retail boot routine: `SoftReset` farcalls it
unconditionally (`$00:$262c`, followed by `stop`), and it clears every WRAM bank,
validates and repairs SRAM, applies the unlock flags, initialises story state and
match settings, enables the LCD, and then at `.loop` (`$40a5`) sets
`wStoryModeCurrentLocation` to `STORYLOC_MAIN_MENU` and calls
`RunStoryModeOverworld` — which is the entire game.

Immediately after that call sits a **complete debug dispatcher** (`$01:$40ec`
onward) that polls `hInputPressed` and launches a different subsystem per button:

| bit | button | what it runs |
| --- | --- | --- |
| 3 | START | the overworld at the main menu |
| 2 | SELECT | `RunSoundTest` |
| 0 | A | `RunDebugTestMatch`, looping |
| 1 | B | `RunMatch`, looping |
| 6 | UP | two `ShowTournamentBracket` calls, then `RunMatchWinLoseScreen` looping over result ids |
| 7 | DOWN | `RunIntroCutscene` then `RunTitleScreen`, looping |
| 4 | RIGHT | the overworld at `STORYLOC_TEST` |
| 5 | LEFT | `RunDebugCharViewer` |

with a further block (`$419e`) for `ShowEquipmentStatusScreen`,
`RunMatchStatsScreen`, `ShowLinkErrorScreen`, `ShowLinkMessageScreen`,
`RunShoesSelectScreen`, `RunRacketSelectScreen` and the character viewer.

**Nothing reaches any of it.** No instruction jumps to `$40ec`; it can only be
entered by falling out of the `farcall RunStoryModeOverworld` above it, and that
call never returns in normal play — the overworld loop is the game. The blocks are
named `Unused_01_*` for that reason.

The accompanying save flag is the visible half. `SAVEFLAG_DEBUG_TEST_MENU`
(#63) has exactly two references in the ROM, both inside this routine: it is
**cleared** unconditionally at boot (`$401c`) and **set** if A is held at
`$40c6` — and no instruction anywhere tests it. So the "hold A to enable the test
menu next boot" gesture works, stores its bit in battery-backed SRAM, and is
read by nothing.

What survives is the *in-game* debug menu, which is reached by a different route
entirely: `RunStoryLocation`'s frame loop calls `RunDebugMenu` (`$05:$66a0`)
whenever `hDebugStepMode` is nonzero and no script or tile trigger is active
(`$0a:$50b4`). That one is live, and its four handlers are a warp menu, a text
subcommand, a palette editor and a game-flag editor. Since nothing in the retail
build sets `hDebugStepMode` except the unreachable dispatcher above, it is
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
        farcall RunDebugStatsEditor
        ld a, $00
        ld [wMatchSimFrozen], a
        ld [wMatchDrawFrozen], a
        ret
```

That `farcall` is the only reference to `RunDebugStatsEditor` (`$06:$6b84`) in
the ROM other than its slot in bank `$06`'s `$4000` directory, and no indexed
dispatch reaches that slot. So the leading `ret` orphans a working in-match
editor: `RunDebugStatsEditor` plus `DrawDebugStatsLabels`,
`DrawDebugStatsValues` and `HandleDebugStatsInput`, none of which is referenced
from anywhere else.

Unlike the drill judges this one is a single routine rather than a family, and
its body is guarded by `hDebugStepMode` anyway, so the `ret` may well have been
deliberate belt-and-braces before release. As with the judges, the ROM does not
distinguish that from an editing accident.
