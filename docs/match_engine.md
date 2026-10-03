# The match engine

How a tennis match works in Mario Tennis (GBC): the frame loop, the ball, the
players, the AI, scoring, doubles, and the link-cable two-player path. Claims
carry a `bank:$addr`, a symbol or a source path as evidence.

Companion documents: `ram/*.asm` (per-address RAM notes), `save_format.md`,
`bugs.md`.

## Contents

- [Where the code lives](#where-the-code-lives)
- [How a match runs](#how-a-match-runs)
- [The world model: units, geometry, angles](#the-world-model-units-geometry-angles)
- [The ball](#the-ball)
- [The shot: from swing to trajectory](#the-shot-from-swing-to-trajectory)
- [On-court characters](#on-court-characters)
- [The AI](#the-ai)
- [Scoring and point resolution](#scoring-and-point-resolution)
- [Doubles and the partner](#doubles-and-the-partner)
- [Two players over the link cable](#two-players-over-the-link-cable)
- [Character stats into the engine](#character-stats-into-the-engine)
- [WRAM state you will need](#wram-state-you-will-need)
- [Known gaps](#known-gaps)

## Where the code lives

| Bank | Role |
|---|---|
| `$08` | **The match engine**: match/set/game/point loops, per-frame simulation, ball physics, character state machine, movement, scoring, camera, sprite-slot renderer, the whole CPU AI. 99.5% code. |
| `$07` | The **shot solver** (`ExecuteShot` and callees), the **serial-link engine**, and `LoadCharacterAttributes` (character id → engine stat fields). |
| `$09` | Match **HUD and on-court objects**: scoreboard digits, serve indicator, court banners, the shared object-slot system. |
| `$06` | `DrawScoreboard`, `ShowMatchScoreboardScreen`, `RunMatchPauseMenu`. |
| `$20`-`$24`, `$29`-`$2c` | **Ball-path banks**: precomputed trajectory tables, one bank per shot-type family. |
| `$2d` | `SineTable` (`$2d:$4000`) and `CosecantTable` (`$2d:$5000`), 4 KiB each. |
| `$28` | Match graphics loaders (`LoadMatchGraphics`, effect tiles). |
| `$0d`, `$0b`, `$0a` | Minigame/drill drivers that reuse the engine through its mode hooks. |
| `$04` | Not match AI. Its only match contribution is `SetupCharSpriteFromObjectDef` (`src/engine/story/actor_objdefs_04.asm`), which fills a character's sprite/animation pointers. |

The engine's public API is bank `$08`'s 56-slot farptr header at `$08:$4000`
(`src/engine/match/slots_08.asm`). Callers are the exhibition and story menus
(`$10`, `$0a`, `$0b`, `$38`, `$01`) plus the unreachable
`Unused_07_RunDebugTestMatch` (`$07:$5df9`).

## How a match runs

The match is straight-line code that **blocks on frames**: every wait,
animation and banner delay spins the whole frame pipeline. The call graph is
the match structure.

```
RunMatch                     $08:$4190   src/engine/match/match_08.asm
├─ InitMatchScene            $08:$4145   court data, chars, scoreboard, graphics
├─ PlayCourtIntro            $08:$6117   camera pan + walk-on
├─ RunMatchPlayLoop          $08:$4714   loop: PlaySet until wMatchWinLoseFlag
│  └─ PlaySet                $08:$4737   loop: play a game until wSetWinLoseFlag
│     ├─ CheckSetComplete.playGame  $08:$4758   normal game
│     │  └─ loop: AssignCourtPositions; PlayPoint  until wGameWinLoseFlag
│     └─ CheckSetComplete.tiebreak  $08:$4782   tiebreak game
│        └─ loop: changeover; PlayPoint  until wGameWinLoseFlag
│           └─ PlayPoint     $08:$4d0f   src/engine/match/point_08.asm
│              ├─ ResetPointState
│              ├─ AnnouncePointSituation   game/set/match-point banner
│              ├─ .rallyLoop: StepMatchFrame until wPointOutcome != 0
│              ├─ ScorePoint
│              ├─ StartPointEndReactions
│              └─ ResolvePointOutcome       banners, score reveal, delays
└─ RunMatchWinLoseScreen, ProcessMatchRewards
```

`wMatchAbortFlag` (`$c4c3`) breaks out: bit 7 breaks the point/game/set/match
loops (`$08:$472c`, `$4748`, `$476e`, `$47b2`), bit 0 aborts the rally
(`$08:$4d2c`). Every quit-menu action sets it to `$ff`; `ResetPointState` clears
it (`$08:$4cd8`).

### Stepping frames

| Routine | Addr | Behaviour |
|---|---|---|
| `StepMatchFrame` | `$08:$4465` | One frame. Saves the WRAM bank, then `AdvanceFrame` + `UpdateMatchFrame` + `inc hMatchFrameCounter`, **or** `RunLinkMatchFrame` if `hLinkExchangeActive` is set. Then `HandlePauseMenu` and the (returned-out) debug-editor hook, unless the sim is frozen. |
| `StepMatchFrames` | `$08:$4428` | `a` frames, aborting early on `wMatchFramesAbort` (`$c492`). |
| `StepMatchFramesSkippable` | `$08:$4436` | Same, but A or B ends the wait (`and $03` at `$4443`); makes banners dismissable. |
| `RunMatchFramesUntilInput` | `$08:$4452` | Spins until any button but SELECT/START (`and $f3`). |

Because the pause menu is polled inside `StepMatchFrame`, pausing works at every
wait point.

### One simulation frame

`UpdateMatchFrame` (`$08:$41f7`) runs, in order, with WRAM bank `$04` mapped:

1. `ClearSpriteSlots`
2. `UpdateMatchCamera`
3. `UpdateAllChars` — `UpdateChar` once per WRAM bank `$04`-`$07`
4. `HandleBallHitEvent`
5. `HandleBallTouchCharEvent`
6. `UpdateBallVisuals` — which also reaches `StepBallPhysics`
7. `TickRallyTimers`
8. `HandleBallBounceEvent`
9. mode hook 0, then `UpdateAllObjSprites` (bank `$09`) via `FarPtr_UpdateAllObjSprites`
10. `DrawActorsByDepth` (skipped if `wMatchDrawFrozen`)
11. `UpdateMinigameTargets`
12. `DrawMarkersAndShadows` (skipped if `wMatchDrawFrozen`)

`wMatchSimFrozen` (`$c4c0`) skips steps 1-9 and 11; `wMatchDrawFrozen`
(`$c4c1`) skips the draw steps. Both are `$ff` during setup and while paused.

Characters move and may strike the ball *before* the ball is integrated, and the
one-shot ball events (see [Per-frame ball events](#per-frame-ball-events)) are
consumed in the frame they are raised.

### Mode hooks

Minigames and drills plug in through eight banked callbacks. `SetModeHookTable`
(`$08:$671a`) stores pointer and bank in `wModeHookTable`/`wModeHookBank`;
`CallModeHook` (`$08:$66f1`) takes the id in `d` and calls the word at
`table + id*2` in that bank. `wModeHookBank == 0` (a normal match) disables it.

| id | Fired from | When |
|---|---|---|
| 0 | `UpdateMatchFrame` `$08:$421d` | every simulation frame |
| 1 | `RunMinigamePointLoop` `$08:$65e9` | point start |
| 2 | `RunMinigamePointLoop` `$08:$660b` | point end |
| 3 | `RunMinigamePointLoop` `$08:$65d7` | once, before the first point |
| 4 | `HandleBallHitEvent` `$08:$42c1` | ball struck |
| 5 | `HandleBallBounceEvent` `$08:$4375` | ball bounced |
| 6 | `TickRallyTimers` `$08:$4270` | ball crossed the net |
| 7 | `DrawBallAndEffects` `$08:$6425` (from `DrawActorsByDepth`) | extra draw pass |

`ModeHookTable_07` (`$07:$5efc`), installed only by the unreachable
`Unused_07_RunTargetZoneTestMode`, implements 1, 2, 4 and 5 and stubs the rest.

### The minigame loop

Drills and minigames replace `RunMatchPlayLoop` with `RunMinigamePointLoop`
(`$08:$65be`, `src/engine/match/minigame_08.asm`), driven by a **point table** of
8-byte records (four court-position codes, four serve-role codes).
`LoadMinigamePointLayout` (`$08:$6662`) reads each from the hook bank into the
characters' `wCharCourtPos`/`wCharServeRole`; a first byte of `$ff` ends the
loop. `PlayMinigamePoint` (`$08:$6631`) is `PlayPoint` without scoring: it
settles the ball, calls `HandleServeFault` and `FlagServiceReturnAce`, and
returns.

## The world model: units, geometry, angles

### Fixed-point formats

| Quantity | Layout | Example |
|---|---|---|
| Ball position | 32-bit `16.16` | `$c400` = X (frac lo, frac hi, int lo, int hi) |
| Ball velocity | 24-bit, aligned with the low 24 bits of a position | `$c420` = X velocity |
| Character position | 24-bit: fraction byte + signed 16-bit integer | `$df00` = X |
| Character velocity | signed 16-bit | `$df40` = X |

`AddVel24ToPos32` (`$08:$5a87`, `src/engine/match/project_08.asm`) adds velocity
bytes 0-2 into position bytes 0-2: the velocity lines up with the position's two
fraction bytes and low integer byte. A raw velocity `v` moves `v / 65536` units
per frame, so the 16-bit words read at `$c421`/`$c424`/`$c427`
(`wBallVelocityX` etc.) are in `1/256` unit per frame, not whole units.

### World scale

The geometry is a real-dimension model at **105 world units per metre** — an
inference (no source comment states it) from five constants:

| Constant | Address | Value | Real dimension |
|---|---|---|---|
| Singles lateral limit | `$08:$40e5` | `$1b0` = 432 | 4.115 m half-width |
| Doubles lateral limit | `$08:$4305` | `$240` = 576 | 5.485 m half-width |
| Baseline depth | `$08:$40ee` | `$4e0` = 1248 | 11.885 m |
| Service line depth | `$08:$4cff` | `$2a0` = 672 | 6.40 m |
| Net height | `$08:$40f7` | `$60` = 96 | 0.914 m (centre) |

Gravity agrees: `StepBallPhysics` adds `$4a00` to the 24-bit height velocity per
airborne frame (`$08:$57bc-$57c2`), 0.2891 units/frame², which at 105 units/m
and 60 fps is 9.91 m/s².

### Sign conventions

- **X** is lateral, signed, 0 at court centre; positive X is screen-right.
- **Depth** is signed, **0 at the net**, opposite signs per side. Each
  character's depth carries its side's sign, so most code compares absolute
  values and the AI mirrors through `MirrorDepthForFarSide` (`$08:$7c33`).
- **Height is negative-up.** `GetBallHeightSign` (`$08:$4677`) returns `$ff`
  for a negative (airborne) height; gravity is a positive addend.
- **Court limits are stored negated.** `wCourtLimitX` holds `-$1b0` (singles) or
  `-$240` (doubles); `wCourtLimitDepth` holds `-$4e0`. `CheckBallOutOfBounds`
  (`$08:$463a`) adds the stored limit to `|wBallX|` and reads carry as "out" —
  one `add hl,bc`. Results go to `wBallOutOfBoundsBits` (`$c4b1`): bit 0 =
  outside laterally, bit 1 = outside in depth.

### Angles and trig

An angle is 16-bit: **high byte = angle with 256 to the full turn, low byte = a
fraction**. `wShotAimAngle`, `wBallHeadingAngle`, `wBallPitchAngle` and the
overworld facing byte (`FACE_RIGHT`/`DOWN`/`LEFT`/`UP` = `$00`/`$40`/`$80`/`$c0`)
use it. The primitives are in ROM0:

| Routine | Addr | Does |
|---|---|---|
| `MulSin` / `MulSinUnsigned` | `$00:$1351` / `$00:$1361` | `hl * sin(bc)`; folds the top half-turn onto the bottom by sign, indexes `SineTable` at `$2d:$4000 + ((bc >> 3) & ~1)` — 2048 words over a half turn, `$8000` = 1.0 |
| `MulSinCos` / `MulSinCosSigned` | `$00:$1340` / `$00:$1332` | `hl*cos` in `hl`, `hl*sin` in `de` |
| `DivBySin` / `DivByCos` | `$00:$13ce` / `$00:$13ca` | `hl / sin(bc)` via `CosecantTable` (`$2d:$5000`), same indexing, result `<<2` |
| `VectorLengthFromAngle` | `$00:$138f` | length from angle and both legs, dividing on the numerically better axis |
| `AngleFromVector16` | `$00:$1416` | `atan2`, quadrant by quadrant |
| `VectorFromLengthAndAngleRaw` | `$00:$0af8` | coarse polar→cartesian off `QuarterSineTable` (`$00:$0b5c`), for character-scale motion |

`ProjectWorldToScreen_08`/`ApplyCameraProjection` (`$08:$59b8`/`$59bb`) map
world `(X, depth, height)` to screen space, adding `wCameraOffsetX`/`Y` before a
`<<3`.

## The ball

### State

A contiguous WRAM0 block at `$c400`; `ResetMatchState` clears `$e0` bytes from
there (`$08:$40ab`).

| Address | Symbol | Meaning |
|---|---|---|
| `$c400`/`$c404`/`$c408` | `wBallXFrac`/`wBallDepthFrac`/`wBallHeightFrac` | position, `16.16`; integer parts at `$c402`/`$c406`/`$c40a` |
| `$c40c`/`$c40e` | `wBallPitchAngle`/`wBallHeadingAngle` | velocity direction, recomputed every frame |
| `$c410`-`$c41b` | `wBallPrev*` | the 12-byte position block at frame start |
| `$c41c`/`$c41e` | `wBallTopspin`/`wBallSideSpin` | spin coefficients |
| `$c420`/`$c423`/`$c426` | `wBallVelocity{X,Depth,Height}Frac` | velocity, 24-bit |
| `$c42a`/`$c42c` | `wBallSpeedHorizontal`/`wBallSpeed3D` | derived magnitudes |

### The physics step

`StepBallPhysics` (`$08:$5767`, `src/engine/match/ball_effects_08.asm`), in order:

1. clear `wBallBounceEvent`
2. copy the position block to `wBallPrev*` (`$08:$5774`)
3. `AddVel24ToPos32` ×3
4. `BounceBallOffCourtFences` (`$08:$5949`)
5. `HandleBallNetCrossing` (`$08:$5814`)
6. rebuild `wBallCourtQuadrant` from the position signs — bit 1 = side of the
   net, bit 0 = lateral half (`$08:$5798-$57a9`)
7. `UpdateBallAnglesAndSpeed` (`$08:$45e5`): heading = `atan2(velX, velDepth)`,
   horizontal speed, pitch = `atan2(horizSpeed, velHeight)`, 3-D speed
8. `ApplyBallAirDrag` (`$08:$55b4`)
9. `ApplyBallSpin` (`$08:$5613`)
10. ground test — gravity, or bounce

**Drag** is speed-proportional: `b = (|wBallSpeed3D >> 8| >> 4) + 1`, then each
axis loses `(v/2) * b/256`.

**Spin** rotates the velocity vector (`$08:$5613-$5765`):

- `wBallSideSpin` adds `-k·velDepth` to `velX` and `+k·velX` to `velDepth` — the
  curve of a sliced ball.
- `wBallTopspin` multiplies `wBallVelocityHeight` by the coefficient and adds
  the negated product along `wBallHeadingAngle` into the X/depth velocities, and
  multiplies `wBallSpeedHorizontal` by it into the height velocity — a Magnus
  rotation of the (horizontal, vertical) pair.
- Both coefficients decay by `3/256` per frame.

**Gravity and the bounce** (`$08:$57c6-$5812`), decided by `GetBallHeightSign`:

- Airborne: add `$4a00` to the height velocity.
- At or through the ground: `ApplyCourtBounceDamping`, negate the 32-bit height
  (reflecting the penetration), then if it is nonzero raise
  `wBallBounceEvent = 1`, complement the height velocity, and if
  `wBallVelocityHeight + $0250` shows the upward speed below that threshold,
  zero height and height velocity — the ball comes to rest.

`ApplyCourtBounceDamping` (`$08:$46b0`) multiplies both horizontal velocity
triples by `wCourtSurfaceFriction` and the height triple by
`wCourtSurfaceBounce`, 8-bit fractions loaded by `LoadCourtSceneData`
(`$08:$5e28`) from the 4-byte-per-court `CourtSceneDataTable` (`$08:$5dc4`,
`court_scene` rows): `[friction, restitution, scene-graphics id, unused]`.

**The net.** `HandleBallNetCrossing` (`$08:$5814`) XORs the high bytes of
`wBallDepth` and `wBallPrevDepth`; bit 7 set means depth 0 was crossed this
frame, and `wBallCrossedNetFlag` is raised for that frame. Unless the
wall-practice flag is set it then adds `wNetHeight` to `wBallHeight`; a
non-negative sum means the ball is **at or below the net top**
(`$08:$5836-$583f`), so it plays sound `$5a`, starts the bounce effect, sets
`wBallHasBouncedFlag`, quarters X velocity and reflects the depth position. Three
bands then apply (`$08:$5874-$5882`):

| Contact height | Result |
|---|---|
| above `$5a` (within 6 units of the top) | set to the net top (height `-$60`), kicked up by `|depth velocity|/8` plus random 0-`$3fc`, carries on forward at ¼ depth speed — the net-cord dribbler |
| `$58`-`$5a` | same kick from the current height, but depth velocity negated and cut to ⅛ — pops back |
| below `$58` | depth velocity negated and cut to ⅛ — drops on the hitter's side |

`wBallHasBouncedFlag` (`$c4bf`) is set only at `$08:$5848`, in that branch:
**despite its name it means "touched the net since the last strike"**. That is
how `EvaluateBounceOutcome`'s let rule reads, and also what `TickRallyTimers`
(`$08:$4262`) and `AiTrackBallPhase` (`$08:$7d73`) use it for.

**Fences.** `BounceBallOffCourtFences` (`$08:$5949`) applies the court damping
twice and raises `wBallBounceEvent = 2`.

### Per-frame ball events

| Flag | Raised by | Consumed by | Meaning |
|---|---|---|---|
| `wBallHitEvent` `$c4b7` | `ExecuteShot` `$07:$53b8` | `HandleBallHitEvent` `$08:$427a` | a character struck the ball |
| `wBallBounceEvent` `$c4b3` | `StepBallPhysics` `$08:$57e8` (=1), `BounceBallOffCourtFences` (=2) | `HandleBallBounceEvent` `$08:$4352` | ground / fence bounce |
| `wBallCrossedNetFlag` `$c4b4` | `HandleBallNetCrossing` `$08:$5827` | `TickRallyTimers` `$08:$4242` | passed the net plane |
| `wBallTouchCharFlag` `$c4ae` | `CheckCharBallContact` `$08:$6f30` | `HandleBallTouchCharEvent` `$08:$43d3` | the ball hit a body |

`ExecuteShot` returns if `wBallHitEvent` is still set (`$07:$53b0-$53b5`), so
two characters cannot hit the same ball on one frame.

`HandleBallHitEvent` (`src/engine/match/match_08.asm`): increment `wRallyLength`
(saturating at `$64`), clear the bounce/marker flags, start the landing marker
and hit effect, run `SetCharStateOnBallHit` on every character,
`DetectServeAceOutcome`, mode hook 4, and **zero `wBallBounceCount`**. Then:

- `wRallyLength == 1` (serve struck): if `wSpecialShotFlag`, court banner `$0e`.
- `wRallyLength == 2` (serve returned): restore the full limits — depth `-$4e0`,
  X `-$1b0`/`-$240` by format (`$08:$42f3-$430d`).

That is the **serve box** mechanism: `ResetPointState` sets `wCourtLimitDepth`
to `-$2a0` (service line) and `wCourtLimitX` to `-$1b0` (singles width, *even in
doubles*) at `$08:$4cf6-$4d07`, so `CheckBallOutOfBounds` judges the serve
against the box until it is returned. The diagonal half of the rule is in
[Scoring](#scoring-and-point-resolution).

### Visuals

The ball is drawn from a history ring. `UpdateBallVisuals` (`$08:$5153`) shifts
`wBallHistory` (`$dd00`, six 6-byte `[projX, projY, tile, attr]` records) down
one per frame; `BuildBallSlot` writes the newest and `BuildBallTrailSlots` draws
2 or 5 afterimages by `wBallTrailColor`. Fixed sprite slots are `$de00`-`$de1f`
(listed in `ram_map.md` §"Match renderer sprite slots"). `DrawActorsByDepth`
(`$08:$6429`) paints the two team pairs and the ball group back-to-front by
`wCharDepthKey` (`$df96`).

## The shot: from swing to trajectory

**The game does not integrate a launch velocity of its choosing; it looks the
answer up.** Each shot-type family owns a bank of precomputed ballistic
solutions indexed by distance, and the shot's power only decides which row is
used.

### The chain

`ExecuteShot` (`$07:$53b0`, `src/engine/match/shot_power_07.asm`) is farcalled by the
character state machine at the contact frame (`$08:$6bd1` serve, `$08:$6c91`
rally shot).

```
ExecuteShot                              $07:$53b0
├─ guard: return if wBallHitEvent already set; else set it
├─ snapshot the hitter into the wLastShot*/wShot* globals
├─ rst Rst00 on wCurrentShotType -> one of 15 ExecuteShot<Type> handlers
│  ├─ NormalizeBallHeightForShot  /  RaiseBallHeightForLob
│  ├─ ApplyShotTypePresets        $07:$557e   -> sound, trail, bc = target depth
│  ├─ WeakenShotByCharge / BoostShotByCharge / NudgeShotByPlayerMomentum
│  ├─ ComputeShotTrajectory(bc)   $07:$571e   -> aim point, angle, row window
│  └─ farcall ShotBallPath<Type>  into a ball-path bank
│     ├─ farcall ComputeShotPlacement  $07:$5161  -> spin, bc = requested speed
│     ├─ pick a 64-row trajectory block by contact height / placement index
│     ├─ ApplyBallTrajectory6Capped_20  -> row search
│     ├─ SetBallVelocityFromEntry6_20   -> farcall SetBallVelocityPolar  $08:$45a9
│     └─ SetBallTargetFromAim_20      -> wBallTargetX/Depth
└─ ShotRecoilFrameTask / ApplyShotRecoil   $07:$5463 / $546b
```

The snapshot (`$07:$53b0-$543c`) makes the rest of the frame independent of who
swung: `wLastShotCharIndex`, `wLastShotServeRole`, `wLastShotAimOffset`,
`wCurrentShotType`, `wLastShotButtons`, `wBallQuadrantAtHit`, `wShotChargeLevel`
(= `min(wCharSwingFrames, $3f)`), `wShotWasQuickSwing`, and the pre-hit ball
velocity into `wShotRecoilVelocity*`.

`wShotAimMirror` (`$c4a7`) is the **low bit of a count of four conditions**
(`$07:$53ef-$5410`): backhand animation (`$06`), quick backhand (`$0a`),
left-handed (`wCharMirrorAttrMask` nonzero), serve (`wRallyLength == 0`). When
odd, every later lateral aim offset is negated — one set of tables serves both
sides and both handednesses.

### Per-shot-type presets

`ApplyShotTypePresets` (`$07:$557e`) reads a 5-byte `shot_preset` row from
`ShotTypePresets_07` (`$07:$559e`) per `SHOTTYPE_*`: `[sound id (SFX_HIT_*),
recoil variant, trail colour, target depth lo, hi]`. The target depth — nominal
landing depth past the net — is the shot type's personality: ground strokes
`$0280` (6.1 m), power variants and neutral `$03c0` (9.1 m), reach shots
`$0380`-`$0480`, smash `$0440` (10.4 m), lobs and drops `$0200` (4.9 m), serves
`$02a0` (6.4 m, the service line).

Charge then bends it: `WeakenShotByCharge` subtracts `charge*4`,
`BoostShotByCharge` (lobs) adds `charge*12`, `NudgeShotByPlayerMomentum` adds
`±wCharVelDepth/16`.

### Where the ball is aimed

`ComputeShotTrajectory` (`$07:$571e`, `src/engine/match/execute_07.asm`):

1. **Sign the depth by court side** (`wCharCourtPos & $02`) into
   `wShotAimTargetDepth`; `wShotAimDeltaDepth = target - wBallDepth`
   (`$07:$5725-$573d`).
2. **Lateral target**, `ComputeShotTargetX` (`$07:$5646`):
   - Serve (`wRallyLength == 0`): tail-jumps to `GetShotAimOffsetForSide`
     (`$07:$55e9`), which picks from one of two 4-record tables by
     `wCharCourtPos & 1` (the diagonal box), indexed by `wCharAimOffset + 1`,
     and adds `-charX/16`.
   - Rally: five-way `rst Rst00` on `(wCharAimOffset + 2) & 7` — full-left /
     half-left / centre / half-right / full-right. Magnitude from
     `ComputeAimBaseOffset` (`$07:$56b7`):
     `(wAimSpreadBase + |charDepth|/8) * wCharAimOffsetScale/256`, with
     `wAimSpreadBase` `$0220` singles / `$0320` doubles — deeper hitters swing
     the ball further sideways.
   - `ClampShotTargetX` (`$07:$56e3`) clamps to `-(wCourtLimitX + $20)`, and
     every path adds or subtracts one `GetRandomAimJitter` (`$07:$570d`) —
     `rng * wCharAimJitterScale`, high byte only, effectively `rng*scale/16`.
     **The human is jittered too.**
3. **Aim angle** = `AngleFromVector16(depth leg, X leg)` → `wShotAimAngle`.
4. **The distance window** (`$07:$5783`, `$07:$57b8`):

   ```
   wShotDistMin = | (|wBallDepth| + $0140) / sin(wShotAimAngle) |
   wShotDistMax = | (|wBallDepth| + $0480) / sin(wShotAimAngle) |
   wShotTrajRowMin = wShotDistMin >> 6     ; high byte of (dist << 2)
   wShotTrajRowMax = wShotDistMax >> 6
   ```

   `|wBallDepth| + K` is the depth to cover to land `K` past the net; dividing by
   the sine converts it to a length along the aim line. So the constants are the
   **shallowest and deepest landing depths considered**: `$0140` ≈ 3.05 m past
   the net (not the service line, `$02a0`), `$0480` ≈ 10.97 m, the baseline less
   `$60`. `[rowMin, rowMax]` is exactly the set of distances that land in.
5. **Sideline shortening** (`$07:$57d7-$5850`): if the aim line crosses
   `wCourtLimitX + $0020` before `wShotDistMax`, the max is scaled down to that
   crossing and `rowMax` recomputed.
6. `wShotSolverNegHeight = -wBallHeight`; the aim point is copied into
   `wBallTargetX`/`wBallTargetDepth`.

### The speed budget

`ComputeShotPlacement` (`$07:$5161`) dispatches to one of 15
`ShotPlacement<Type>` handlers, each of which:

1. calls `LoadShotPlacementEntry` (`$07:$52a0`) on an **8-byte-stride** table:
   words `+0`/`+2` (row chosen by a per-character *placement* index) become
   `wBallTopspin`/`wBallSideSpin` (sidespin negated under `wShotAimMirror`); the
   word at `+4` (row chosen by a per-character *speed* index) is the requested
   speed in `bc`;
2. adds an incoming-pace term, a charge term, then `FinalizeShotSpeed`
   (`$07:$52d7`): `±wCharVelDepth/2`, `-$0c00` while diving (`wCharFlags` bit
   1), floor `$0100`, stored in `wShotSpeedFinal`.

The pace term (`AddBallSpeedQuarter`/`3Sixteenths`/`Eighth`,
`$07:$52f1`/`$5301`/`$531d`) takes a fraction of `wBallVelocityDepth` and forces
it **negative** (`$07:$532f`), so a fast incoming ball *reduces* the requested
speed. Whether that was intended is not established.

The four reach shots skip the charge term. Lobs, drops and the three serves add
nothing and skip `FinalizeShotSpeed`.

### The trajectory tables

Nine banks, one per family. The `$4000-$427c` prologue (entry pointers, row
search, velocity and target helpers) is the same code in all nine
(`src/twins/`): byte-identical in `$20`-`$23` and `$29`-`$2b`; `$24` and `$2c`
have longer farptr headers, so their copies sit later with internal targets
relocated.

| Bank | Family | Data |
|---|---|---|
| `$20` | slice | 15360 B, 6-byte rows |
| `$21` | power slice | 15360 B, 6-byte rows |
| `$22` | topspin | 15360 B, 6-byte rows |
| `$23` | power topspin | 15360 B, 6-byte rows |
| `$24` | lob, drop, neutral, smash, reach, **and the shared fallback** | several blocks, 4- and 6-byte rows |
| `$29`/`$2a`/`$2b` | serve topspin / slice / flat | 7200 B each |
| `$2c` | the three reach (stretch) placements | 3072 B + 2 × 4608 B |

These are not per-court: the per-court data is only the two damping bytes in
`CourtSceneDataTable`.

**The files.** Each table is `data/bank_02x/<Table>.asm`, one
`traj_row speed, elevation, delta` (or `traj_row4 speed, elevation`) per row,
with `; block N` every 64 rows where tables are indexed in 64-row blocks (the
four stroke banks, neutral, reach) and `; row N` every sixteen elsewhere.
`make check` (`traj`) proves the round trip. Edit a row and `make` to tune a
shot; `tools/mods.py collect <baserom>` keeps the edit under `mods/`.

**A row** (6 bytes, or 4 without the delta):

| Offset | Field |
|---|---|
| `+0` | launch **speed magnitude** — monotonic with row; the search key |
| `+2` | launch **elevation angle** — steep near, flattening with distance |
| `+4` | lateral **aim delta** added to `wShotAimAngle`, negated under `wShotAimMirror` |

**Which block** (clearest in `ShotBallPathSlice`, `src/data/shots/slice.asm`):

- `LookupBallPosByHeight_20` (`$20:$424c`): `-wBallHeight` scaled by 16 and
  masked to 5 bits — **32 contact-height bands** of 16 units — selects a block
  offset.
- `LookupBallPosByShotIndex_20` (`$20:$426e`) adds an offset by the character's
  placement index for the family.

So a table is `[placement variant][height band][distance row]`. The drop table
adds an axis keyed on the ball's distance from the court origin
(`LookupBallPosByAim_24`, `$24:$422d`). The smash has no table:
`ShotBallPathSmash` (`$24:$6696`) takes the magnitude from
`ComputeShotPlacement` and computes elevation as the angle to the landing point
plus `SmashElevationBySpeed_24` (10 entries) indexed by
`wSmashServeSpeedIndex`.

**The row search.** `BallTrajEntryPtr6_20` (`$20:$4002`) computes
`block + (distance >> 6) * 6`: **row = distance ÷ 64** (≈ 0.61 m), the same
quantity as `wShotTrajRowMin`. `SeekBallTrajEntry6_20` (`$20:$401f`):

```
d = wShotTrajRowMin ; e = wShotTrajRowMax
loop: if row.speed + (-requestedSpeed) carries   -> stop  (row.speed >= requested)
      if d >= e                                  -> stop  (hit the legal maximum)
      d++ ; pointer += 6
```

That is: **the farthest bucket the speed budget pays for, capped at the deepest
legal landing.** The row's speed and elevation are launched
(`SetBallVelocityFromEntry6_20` → `SetBallVelocityPolar`, `$08:$45a9`, which
resolves `(magnitude, elevation, heading)` into the three velocity triples), and
`row << 6` gives the distance for `SetBallTargetFromAim_20` to set
`wBallTargetX`/`wBallTargetDepth` — the landing prediction used by the AI and the
landing marker.

**The fallback.** If the shortest legal row already costs more than the budget,
the bank jumps to `ApplyFallbackBallTrajectory_24` (`$24:$57fd`): raise
`wFallbackTrajectoryFlag`, clear both spins and the trail colour, substitute one
of three short target depths, re-run `ComputeShotTrajectory`, and apply a
separate fallback table. `StartLandingMarker` (`$08:$52e1`) and
`AiIsIncomingLobShot` (`$08:$79e7`) treat the flag like a lob.

### The 15 shot types

`wCurrentShotType` (`$c4a0`) is the `rst Rst00` index at `$07:$5444`; buttons
come from `SelectRallyShotType`/`SelectServeShotType` (see
[Building a swing](#building-a-swing)).

| Type | Constant | Buttons | Height prep | Charge | Path |
|---|---|---|---|---|---|
| `$00` | `SHOTTYPE_TOPSPIN` | A | Normalize | weaken | `$22` |
| `$01` | `SHOTTYPE_POWER_TOPSPIN` | A → A | Normalize | — | `$23`; falls back to `$00` while diving |
| `$02` | `SHOTTYPE_SLICE` | B | Normalize | weaken | `$20` |
| `$03` | `SHOTTYPE_POWER_SLICE` | B → B | Normalize | — | `$21`; falls back to `$02` while diving |
| `$04` | `SHOTTYPE_NEUTRAL` | A+B, or no valid combo | smash-range gate | — | `$24`; upgrades to smash if in range and the swing animation is 7/8 |
| `$05` | `SHOTTYPE_REACH` | (stretch fallback) | Normalize | weaken | `$24` |
| `$06`-`$08` | `SHOTTYPE_REACH_*` | as `$01`/`$03`/base, near the net | gate → `$05` | weaken | `$2c` |
| `$09` | `SHOTTYPE_SMASH` | only via `$04`'s upgrade | Normalize | — | `$24` |
| `$0a` | `SHOTTYPE_LOB` | A → B | Raise | boost + momentum | `$24` |
| `$0b` | `SHOTTYPE_DROP` | B → A | Raise | weaken | `$24` |
| `$0c`-`$0e` | `SHOTTYPE_SERVE_*` | A / B / A+B | — | — | `$29`/`$2a`/`$2b`, then `SetSpecialShotFlagFromBallHeight` |

- `CheckBallInSmashRange` (`$07:$5525`) returns Z ("not smashable") below
  `-$0070`; otherwise it sums two `AngleFromVector16` results over the ball's
  depth and height and tests the sign — a cone test.
- `NormalizeBallHeightForShot` (`$07:$5876`) raises a contact point lower than
  `$60` halfway toward `-$60`; `RaiseBallHeightForLob` (`$07:$5899`) sets it to
  `$ffa0` (`-$60`), or lowers a ball already above `$80` by `$20`.
- `SetSpecialShotFlagFromBallHeight` (`$07:$5a01`) indexes a 32-byte table by
  height band: bands `$15`-`$1f` set `wSpecialShotFlag`, so a serve struck above
  about `$150` (≈ 3.2 m) is a power serve.

`ShotRecoilFrameTask` (`$07:$5463`), pushed as `ExecuteShot`'s return address,
calls `ApplyShotRecoil` (`$07:$546b`): set `CHARB_RECOIL`, quarter the hitter's
depth velocity (and X unless diving), add a push of the pre-hit ball depth
velocity scaled by `ShotRecoilTable_07` (indexed by the speed-index byte the
preset's recoil variant selects), clear `wCharSwingFrames`.

## On-court characters

### One struct per WRAM bank

Each character is one copy of the struct at `$df00` in its own WRAM bank: bank
4-7 = character 0-3. `wCharIndex` (`$df0b`) = bank − 4, and **its bit 0 is the
court end**. `ForEachCharBank` (`$08:$6a3a`) runs a callback in banks 7, 6, 5, 4
and leaves 4 mapped. `include/ram_mirrored.inc` is the full field list; the
match-relevant fields:

| Address | Symbol | Notes |
|---|---|---|
| `$df00`/`$df03`/`$df06` | `wCharPosX` / `wCharPosDepth` / `wCharPosHeight` | 24-bit |
| `$df09` | `wCharServeRole` | 0 server, 1 receiver, 2/3 partners, `$09` slot unused |
| `$df0a` | `wCharCourtPos` | bit 1 = end, bit 0 = lateral half |
| `$df0b` | `wCharIndex` | 0-3 |
| `$df0c`-`$df0e` | `wCharBaseFacing` / `wCharFacingDesired` / `wCharFacingShown` | angle bytes |
| `$df0f` | `wCharFlags` | below |
| `$df10` | `wCharFreezeTimer` | nonzero suspends the state machine |
| `$df11` | `wCharShotComboTimer` | 5-frame simultaneity filter |
| `$df12`/`$df13` | `wAiActionTimer` / `wAiSecondButtonDelay` | AI timers |
| `$df14`-`$df17` | `wCharShotType`, `wCharSwingAnim`, `wCharShotButton1`, `wCharShotButton2` | the swing being built |
| `$df18`/`$df19`/`$df1a` | `wCharState` / `wCharStatePhase` / `wAiPhase` | the two state machines |
| `$df1e`/`$df1f` | `wCharInputSource` / `wCharInputBits` | who drives, and this frame's input |
| `$df22` | `wCharObjectBank` | 0 = slot unused; `UpdateChar` returns at once |
| `$df40`-`$df45` | `wCharVel{X,Depth,Height}` | signed 16-bit |
| `$df46`/`$df48` | `wCharWalkTargetX` / `wCharWalkTargetDepth` | integer parts |
| `$df4a`/`$df4b`/`$df4c` | `wCharAimOffset` / `wCharSwingFrames` / `wCharQuickSwing` | aim nudge, charge counter, quick-swing latch |
| `$df50` | `wCharBallReachFlags` | below |
| `$df56` | `wCharScriptedMove` | scripted walk in progress |
| `$df57` | `wCharPointResult` | signed result from this character's view |
| `$df58`-`$df5a` | `wAiShotButtons` / `wAiTrackingCountdown` / `wCharRallyReady` | |
| `$df60`-`$df7f` | the stat block | see [Character stats](#character-stats-into-the-engine) |
| `$df96` | `wCharDepthKey` | `(depth*8)>>8 + $80`, painter's-order key |

`wCharFlags` (`$df0f`):

| Bit | Meaning | Read by |
|---|---|---|
| 0 | movement input suspended (`CHARB_RECOIL`) | `$08:$73d7` — kills steering. Set mainly by `ApplyShotRecoil` (`$07:$546e`) after *every* stroke, not just a body hit; `CharRallyEndState` clears it when the swing animation ends |
| 1 | diving | widens the contact box (`$08:$6fc7`), flat brake (`$74b3`), freezes facing ease (`$75c3`), `-$0c00` shot speed (`$07:$53a2`), disables power strokes |
| 2 | airborne | jump physics, shadow selection |
| 4 | moving | run animation |
| 5 | charging a swing | **velocity ÷ 8** in `StepCharMovement` (`$08:$72ed`) |
| 6 | last move refused | nothing reads it |

`wCharBallReachFlags` (`$df50`) is rebuilt every frame by
`UpdateCharBallGeometry` (`$08:$6e64`): bit 0 = ball in swing range, bit 1 =
inside the contact window, bit 2 = body contact, bit 4 = **own depth within
`$2a0` of the net** (`$08:$6ea6-$6ead`), bits 6/7 = lateral / depth steering
requested. Bit 4 ("at the net") selects the volley/reach shot table and the AI's
near/far reaction delay. (`include/ram_mirrored.inc` describes bit 4 as "within
normal reach", which the code does not support.)

### The frame order for one character

`UpdateChar` (`$08:$6958`):

```
UpdateCharBallGeometry   rebuild the relative-position words and the reach flags
ReadCharInput            synthesise wCharInputBits (pad, AI or link)
UpdateCharStateMachine   run the current state's current phase
CheckCharBallContact     body-hit test
UpdateCharVelocityFromInput
StepCharMovement
StepCharJumpPhysics
EaseCharFacing / StepCharAnimation / UpdateCharFacingOctant / ReloadCharFacingTiles
BuildCharSpriteSlots / UpdateChargeFlash / BuildAirborneShadowSlot
```

### The state machine

`UpdateCharStateMachine` (`$08:$6a62`) decrements `wCharFreezeTimer` and returns
if it was nonzero, ticks `wCharShotComboTimer`, then dispatches on `wCharState`
through the 8-entry table at `$08:$6a7b`; each state dispatches again on
`wCharStatePhase`. `AdvanceCharStatePhase` (`$08:$6a8b`) is a bare `inc`, its
`.done` the shared `ret` for exhausted phases. `SetCharState` (`$08:$6a1c`)
zeroes `wCharStatePhase`, `wAiPhase`, `wCharFreezeTimer` and `wAiActionTimer`.

| `wCharState` | Handler | Phases |
|---|---|---|
| 0 | (bare `ret`) | inert — set by `InitChar`, `ResetCharForPoint` and a body hit |
| 1 | `CharRallyState` `$08:$6bea` | `CharRallyEndState`, `CharRallyReadyPhase`, `CharSwingWindupPhase`, `CharSwingContactPhase` |
| 2 | `CharRecoverState` `$08:$6bd9` | finish the swing, then movement only |
| 3 | `CharServeState` `$08:$6ae2` | init, wait-anim, `CharServeTossPhase`, `CharServeSwingWindowPhase`, `CharServeStrikePhase` |
| 4 | `CharAwaitServeState` `$08:$6cc8` | end-state, start-serve, check-input |
| 5 | `CharStandbyState` `$08:$6cbe` | end-state, then state 4's check-input |
| 6 | `CharWalkState` `$08:$6d0e` | `CharWalkToTargetPhase` — scripted walks (changeover, walk-off) |
| 7 | `CharPointEndState` `$08:$6d16` | end-state, walk-to-target, `CharPointReactionPhase` |

Transitions:

- `ServeRoleCharStateTable_08` (`$08:$4fa0`), at each point start: role 0 → 3,
  1 → 5, 2 → 4, 3 → 5.
- `SetCharStateOnBallHitTable` (`$08:$431e`), applied to **all four**
  characters on every hit: `00 02 01 02 02 01 06 07` — swaps 1 and 2, maps
  3 → 2, 4 → 2, 5 → 1, leaves 0/6/7. Whoever hit goes to recovery, everyone else
  to rally-ready, phases restart. States 2 (`CHARSTATE_RECOVER`) and 4
  (`CHARSTATE_AWAIT_SERVE`) are reached *only* through these two tables.

`CharRallyEndState` (`$08:$6a90`) is phase 0 of states 1, 2, 4, 5 and 7: it waits
for the swing/dive animation to finish, clears the buffered buttons and charge
counter, then advances — so a new swing cannot start inside the old one.

### Input

`ReadCharInput` (`$08:$780c`) zeroes `wCharInputBits` and jumps through
`CharInputPtrs` (`$08:$781f`) on `wCharInputSource`:

| Value | Handler | Source |
|---|---|---|
| 0 | `ReadCharPadInput` | the local human |
| 1 | `CharInputHandler1_08` | the CPU AI |
| 2, 3 | `ReadCharPadInput` | never assigned |
| 4 | `CharInputHandler4_08` | raw `hLinkInput` |
| 5 | `CharInputHandler5_08` | link, local seat |
| 6 | `CharInputHandler6_08` | link, remote seat |

`InitChar` (`$08:$684a`) makes every character an AI (`$08:$687b`);
`InitAllChars` sets character 0 to the pad (`$08:$6925`). A link match sets
characters 0 and 1 to 5 and 6 (`$07:$48ba-$48cb`). A pause-menu debug hook
(`$06:$43d5`) does `xor $01` on character 0's source, handing player 1 to the
CPU.

`ReadCharPadInput` (`$08:$7855`) builds `wCharInputBits` as
`(hPlayerInputFlags & $f0) | (hInputRisingEdge & $0f)`: **high nibble = d-pad
held, low nibble = buttons newly pressed**. There is no release information,
which is why charge is measured in windup frames, not hold time.

### Building a swing

`BufferShotButtonPress` (`$08:$7112`):

- A and B on the same frame → button 1 = `$03`.
- A press with `wCharShotComboTimer` expired (or the same button repeated) →
  latched as button 1 if empty, else button 2 (and the timer cleared); the timer
  is reloaded to 5.
- A *different* button while the timer runs → also `$03`.

So the 5-frame window is a **simultaneity filter**: a genuine A→B needs the
second press after it expires.

`SelectRallyShotType` (`$08:$707e`) indexes `button1 + 4*button2` into
`RallyShotTypeTable0` (reach flags bit 4 set, at the net) or
`RallyShotTypeTable1`:

| button 1 ↓ / button 2 → | none | A | B |
|---|---|---|---|
| **none** | topspin (reach-basic at net) | topspin / reach-basic | topspin / reach-basic |
| **A** | topspin / reach-basic | **power topspin** / reach power topspin | **lob** |
| **B** | slice / reach-basic | **drop** | **power slice** / reach power slice |
| **A+B** | neutral | neutral | neutral |

`SelectServeShotType` (`$08:$706b`): A → serve topspin, B → slice, A+B → flat.

`wCharSwingFrames` (`$df4b`) is zeroed when rally-ready arms and incremented per
frame by the windup and contact phases. In `StartCharSwing`, **fewer than 5
windup frames marks the swing quick** (`$08:$6e30`), bumping the animation and
setting `wCharQuickSwing`.

`StartCharSwing` (`$08:$6d5a`) picks the swing by geometry:

- predicted lateral offset beyond `wCharReachX` and that direction held →
  **dive** (animation `$12`, `wCharFlags` bit 1, lunge from `wCharDiveSpeed`,
  sound `$5c`);
- else ball high enough relative to `wCharReachHeight` → **jump smash**
  (airborne, `wCharVelHeight = -wCharSmashJumpSpeed`, animation `$08`);
- else a slightly lower band → overhead animation `$07`;
- else forehand/backhand from `SelectForehandBackhand` (`$05`/`$06`).

### Contact geometry

| Test | Addr | Depth | Lateral | Height | Result |
|---|---|---|---|---|---|
| `CheckBallInSwingRange` | `$08:$702a` | `< $a0` | `< 1.5 × wCharReachX` | — | bit 0 — may start a swing |
| `CheckBallContactWindow` | `$08:$6fa7` | `< $60` | `< wCharReachX` (`1.25 ×` diving) | `< 2 × wCharReachHeight` | bit 1 — the racket connects |
| `CheckCharBallContact` | `$08:$6ec5` | `< $10` | `2 × |relX| < wCharReachX` | `< wCharReachHeight` | bit 2 — body hit |

`CheckBallContactWindow`'s animation-id test (`$08:$6fda`-`$6feb`) has no effect
(see `docs/bugs.md`). `CharSwingWindupPhase` waits on bit 0 before
`StartCharSwing`; `CharSwingContactPhase` waits on bit 1 before
`SelectRallyShotType` and `ExecuteShot`. Only `wCharReachX` (`$df72`) and
`wCharReachHeight` (`$df70`) are per-character.

The body hit (tested only with no swing buffered, in state 1) sets
`wBallTouchCharFlag`, forces state 0, and reverses and damps the ball — depth
velocity `>> 4`, X and height `>> 1` (`$08:$6f45-$6fa6`).
`ApplyBallTouchOutcome` (`$08:$43e5`) then sets `wPointOutcome = $09`; the hit
character loses the point.

### Movement, and why characters slide along walls

`StepCharMovement` (`$08:$72de`) **refuses** out-of-box moves rather than
clamping:

1. While charging (`wCharFlags` bit 5) both velocities `>> 3`
   (`$08:$72ea-$7307`).
2. `res 6, [wCharFlags]`.
3. `AddDEToMem24IntoBC` (`$08:$5ac7`) returns the candidate integer part without
   writing; `AddDEToMem24` commits only if bounds pass. A rejected axis does not
   move this frame and `set 6, [wCharFlags]` records it.
4. **Axes are judged independently** — `.blockX` (`$08:$7349`) falls through to
   the depth test — so a diagonal push into a wall keeps the legal component:
   the slide. Bit 6 plays no part (nothing reads it).

The bounds are hardcoded, not `wCourtLimitX`/`Depth`:

| Axis | Commit requires |
|---|---|
| X | `-$3a0 ≤ X < $3a0` (`$08:$731f`, `$7327`) |
| Depth, near side | `$90 ≤ depth < $6e0` (`$08:$7361`, `$7367`) |
| Depth, far side | `-$700 ≤ depth < -$100` (`$08:$736f`, `$7375`) |
| Corner rule | `X ≥ $240` only when depth `≥ 0` or `< -$2a0` (`$08:$732f-$7347`, mirrored `$737b-$738f`) |

The corner rule is a keep-out box for the **umpire's chair**: far side, between
the net and `-$2a0`, `X ≥ $240`, which is the right-hand far net post where every
court with a chair stands it (Clay, Grass, Hard, Training, Center, Composition,
Tropics, Castle, Star, Warehouse, Jungle; not Minigame, Target Shot, Machine,
Bowser). With the view flipped to keep the human at the bottom, the chair shows
at the left post on the near side.

`wCharInputSource == 1` (AI) jumps to `.unclamped` (`$08:$739f`): X commits
unconditionally and only the net-side depth bound is enforced. **CPU players are
not held inside the sidelines** or out of the chair box; their target selection
keeps them on court.

The rest of the movement chain:

- `ApplyCharMovementInput` (`$08:$719a`) maps the d-pad nibble through
  `DpadToFacingTable_08` (`$08:$7286`) to a facing (opposing pairs and none map
  to an aborting sentinel), and **sets no acceleration intent while the shown
  facing is more than `$30` from the desired one** (`$08:$71bf`): finish turning
  before accelerating.
- `UpdateCharVelocityFromInput` (`$08:$73ca`) accelerates or decelerates each
  axis from reach-flags bits 6/7, then clamps only the accelerated axes.
  `AccelerateCharX/Depth` scale `wCharAcceleration` by cos/sin of the desired
  facing; `ClampCharXSpeed/DepthSpeed` do the same with
  `wCharMaxSpeedX`/`wCharMaxSpeedDepth`, so **the cap follows the run
  direction**.
- `MoveCharTowardTarget` (`$08:$7541`): scripted walk, fixed `$1000` step toward
  `wCharWalkTarget*`, snapping and zeroing velocity once `CheckCharNearTarget`
  (`$08:$78be`) sees both deltas below `$18`. It sets `wCharScriptedMove`, which
  `UpdateCharVelocityFromInput` honours, so scripted and input movement never
  fight.
- `StepCharJumpPhysics` (`$08:$72a6`), airborne only, uses gravity `$0090` per
  frame (character height is 24-bit, not 32).
- `HandleServePositioning` (`$08:$71dd`): the server's left/right shuffle, fixed
  `$000a` step, committed only if `$20 ≤ |X| < $180`.

## The AI

The AI is a **fake controller**: `CharInputHandler1_08` (`$08:$7863`) writes
`wCharInputBits` and the human's state machine consumes it, so all swing,
movement and contact rules apply.

### Structure

1. `CharInputHandler1_08` ticks `wAiActionTimer` and **returns while it is
   nonzero, input zero** — the reaction delay, fully inert. Then it ticks
   `wAiSecondButtonDelay` and picks a jumptable on `wCharState`: singles,
   doubles net player or doubles baseliner (by `wCharServeRole & $02`,
   `$08:$787a`).
2. Each table has 8 slots, live only for state 1 (rally), 2 (recovery) and 3
   (serve); the rest point at `AiPhaseNoop`.
3. Each handler is a jumptable on `wAiPhase` (`$df1a`). `AiAdvancePhase`
   (`$08:$7968`) is `inc [wAiPhase]` falling into the `ret` labelled
   `AiPhaseNoop` (`$08:$796c`), which 26 slots point at.

Since `SetCharState` zeroes `wAiPhase` and every hit remaps every state, the AI
restarts at phase 0 on every stroke.

Singles rally (`AiRallyStateSingles`, `$08:$7cfa`):

| Phase | Handler | Does |
|---|---|---|
| 0 | `AiSetReactionDelay` `$08:$7d0a` | `wAiActionTimer = (reach bit 4 ? wAiReactionDelayNear : …Far) + rng(0-3)` |
| 1 | `AiChoosePositionByStrategy` `$08:$7d23` | pick a walk target |
| 2 | `AiTrackBallPhase` `$08:$7d73` | steer there; advance on arrival or ball in swing range |
| 3 | `AiWaitThenPickShot` `$08:$7dad` | choose and press the first button |
| 4 | `AiSwingControlSingles` `$08:$7dcb` | second button, home on the ball, aim at contact |
| 5 | `AiPhaseNoop` | |

Recovery: `AiChooseHomePosition`, then `AiReturnToPositionPhase`.

### Steering

`AiSteerTowardTarget` (`$08:$7908`) takes the target delta's coarse angle and
indexes `AngleToDpadTable_08` (`$08:$7296`) by its high nibble — **16 sectors
quantised to d-pad bits** — replacing the held nibble. `AiSteerTowardBall`
(`$08:$7944`) does the same on the ball-relative words. Target helpers all end in
`jp AiAdvancePhase`:

| Helper | Addr | Target |
|---|---|---|
| `AiRushToBallLanding` | `$08:$796d` | `$0160` short of `wBallTarget*`, depth floored at `$0100` |
| `AiMoveBehindBallLanding` | `$08:$7992` | `$00c0` beyond the landing point |
| `AiInterceptAtMidCourt` | `$08:$799e` | depth `$0200` |
| `AiInterceptNearNet` | `$08:$79b0` | depth `$0100` |
| `AiMoveLaterallyToBallLine` | `$08:$79c2` | current depth, X = predicted ball X there |

`PredictBallXAtDepth` (`$08:$7c86`) = `(targetDepth - wBallDepth) *
tan(wShotAimAngle) + wBallX` — along the **shot's aim angle**, not the live
heading: the AI reads the solver's intent.

### Positional strategy

`AiChoosePositionByStrategy` is an 8-way `rst Rst00` on `wAiPositionStrategy`
(`$df7f`), from attribute byte `+$0f`, untouched by difficulty.

| Strategy | Behaviour |
|---|---|
| 0, 7 | behind the landing spot |
| 1 | **adaptive** — see below |
| 2 | rush to the landing spot if a drop or lob is incoming, else slide laterally |
| 3 | rush if drop/lob, else intercept at mid-court (`$0200`) |
| 4, 5 | slide laterally to the ball's line, holding depth |
| 6 | intercept near the net (`$0100`) |

Adaptive (`$08:$7d58`) branches on reach bit 4: at the net it intercepts at
mid-court and chases drops and lobs; further back it stays behind the landing
spot and chases only lobs. It adapts to its own position, not the opponent.

`AiChooseHomePosition` (`$08:$7cae`), a separate table on the same byte, is used
between shots: baseline (depth `$0460`), net (hold depth) or mid-court
(`$0180`), X = `wBallTargetX >> 2` in every case.

### Difficulty

**The AI never reads the 0-3 difficulty value.**
`ApplyCpuDifficultyToCharRecords` (`$38:$5f4c`) copies four AI bytes per CPU
slot from a 6-byte `cpu_difficulty` row (`CpuDifficultyParamPtrs_38`,
`$38:$5feb`) into record bytes `+$1b`..`+$1e`, which `LoadCharacterAttributes`
(`$07:$5ab3`) loads into the struct. Slot 0 (the human) is never touched.

| Field | Struct | Easy → Intense | Effect |
|---|---|---|---|
| reaction delay, near | `$df79` | 28 → 2 frames | inert frames after each stroke |
| reaction delay, far | `$df7a` | 24 → 2 frames | same, away from the net |
| tracking parameter | `$df7b` | 12 → 0 frames | seeds `wAiTrackingCountdown`; no shot chosen until it expires unless the ball is already in swing range |
| aim-away chance | `$df7c` | 60/256 ≈ 23% → 230/256 ≈ 90% | threshold in `AiRollAimAwayFromChar` (`$08:$7b17`): below it aims, otherwise no direction — down the middle |

Aim jitter (`wCharAimJitterScale`) is a character stat, not difficulty.

### When and what the AI swings

`AiWaitThenPickShot` presses at once if reach bit 0 is set, else waits out
`wAiTrackingCountdown`; then `AiPickShotButtons`, the first button, and
`wAiSecondButtonDelay = 5` — exactly the gap `BufferShotButtonPress` needs to
read A-then-B rather than A+B.

`AiSwingControlSingles` presses the second button when the delay expires, keeps
`AiSteerTowardBall` running while the ball is outside the contact window, and
**applies aim on the contact frame only** (`AiRollAimAwayFromChar`).

`AiPickShotButtons` (`$08:$7b7b`), in priority:

1. Lob incoming (`wLandingMarkerActive`) and the habit row permits → A+B →
   `SHOTTYPE_NEUTRAL`, which `ExecuteShotNeutral` upgrades to a smash in range.
2. Else, half the time, for `|relDepth| ≥ $0140`, with a habit-row check, and —
   in singles — only if the opponent is inside depth `$01e0` (doubles: a further
   1-in-4 roll) → A→B → `SHOTTYPE_LOB`. **The CPU lobs when you come to the
   net.**
3. Else a 16-entry button-pair distribution from `CharGroupTable_02`
   (`$02:$5e23`, 9 rows × 16, `AISHOT_*` codes) indexed by `wAiServeStyle` and
   `AdvanceMatchRng & $0f` — the character's shot personality.

`AiAimAwayFromChar` (`$08:$7b1f`) reads the target's X position **and X
velocity** from its WRAM bank: 2 in 4 aim away from where the opponent is
*moving*, 1 in 4 away from where he is, 1 in 4 **at** him.

### The AI serve

`AiServeState` (`$08:$79f2`), five phases: walk to one of eight baseline X
offsets, steer there, press A to toss and set the wait, strike, apply aim.

`AiServePressToss` (`$08:$7a5f`) picks the toss-to-strike gap from a per-style
row of `ServePressTossPtrs` (`$08:$7a9d`): eight bytes giving the probability of
a **short 35-frame versus long 50-frame gap**, from never (style 0) to always
(style 3). Since a high contact point earns `wSpecialShotFlag`, this is how serve
power is expressed. Not difficulty-scaled.

Buttons: `AdvanceMatchRng & $07` into `$08:$7b73` — topspin 3/8, slice 2/8, flat
3/8. Aim is 50/50 left/right (`AiApplyServeAimTable`, `$08:$7b0b`) unless a
minigame script sets `wAiServeAimOverride`.

## Scoring and point resolution

### Detecting the end of a point

The rally loop watches `wPointOutcome` (`$c4d8`). Three routines write it with
`wPointOutcomeSide` (`$c4d9`); **the first writer wins**.

`EvaluateBounceOutcome` (`$08:$4379`), from `HandleBallBounceEvent`, is a
fall-through ladder:

| Condition | Outcome | Side |
|---|---|---|
| `wRallyLength == 0` — nobody has hit yet | — | — |
| `wBallBounceCount != 1` — second bounce | 6 `WINNER` | `$01` |
| bounced on the striker's side (`(quadrant ^ quadrantAtHit) & 2 == 0`) | 4 `NET` | `$ff` |
| `CheckBallOutOfBounds` reports anything | 5 `OUT` | `$ff` |
| not the serve (`wRallyLength != 1`) | — (rally continues) | — |
| serve did not change lateral half (`… & 1 == 0`) — wrong box | 5 `OUT` | `$ff` |
| serve touched the net (`wBallHasBouncedFlag`), right box | 3 `LET` | `$00` |

`ApplyBallTouchOutcome` (`$08:$43e5`) sets **9** on a body hit.
`DetectServeAceOutcome` (`$08:$4326`), inside `HandleBallHitEvent` on the second
hit of the point and *before* `wBallBounceCount` is cleared, sets:

- **7** `POINTOUTCOME_SERVE_VOLLEYED` — receiver struck the serve with
  `wBallBounceCount == 0`; popup text `30:372`, *"Return the serve after it
  bounces."*
- **8** `POINTOUTCOME_WRONG_RECEIVER` — second hit by anyone whose role is not 1;
  text `30:373`, *"Only the receiving player may return the ball."*

Both use side `$ff` and have no court banner.

### Which side won

`wPointOutcomeSide` is **relative to the last hitter** (`$01` striker wins,
`$ff` loses, `$00` nobody). `ResolvePointWinner` (`$08:$5d9a`) makes it
absolute:

```
outcome 1 (FAULT) or 3 (LET)  -> 0
outcome 9                     -> derived from wBallTouchCharIndex's parity (that side loses)
otherwise: wLastShotCharIndex bit 0 clear -> +wPointOutcomeSide
                               bit 0 set  -> -wPointOutcomeSide
```

into `wPointWinLoseFlag` (`$c8eb`): `$01` = even-index ("player 1") side, `$ff`
= odd. Every `Award*` routine turns the sign into a counter pointer with an
`add a` / carry trick and returns on zero, so a fault or let scores nothing and
the point is replayed.

### The score

`ScorePoint` (`$08:$5ad7`): `HandleServeFault`, `FlagServiceReturnAce`,
`ResolvePointWinner`, `UpdatePointStats`, `ApplyPointToScore` — all **before any
banner**; `PlayPoint` then redraws the digits and plays the banners.

`HandleServeFault` (`$08:$5b7f`) fires only when `wRallyLength == 1` and side is
`$ff` (net or out, never a let). First time: raise `wServeFaultFlag`, rewrite to
`POINTOUTCOME_FAULT` (1). Second: clear the flag, write
`POINTOUTCOME_DOUBLE_FAULT` (2). Outcome 1 has no winner, so that is the whole
two-serve rule.

`ApplyPointToScore` (`$08:$5ae6`) has two mirrored paths on
`wTiebreakerIndicator`, both using `EvalWinByTwo` (`$08:$5d71`) with level `b`
and minimum `c`:

```
counts equal      -> $80 if the count == b (we are at the deuce/tiebreak threshold), else 0
d - e >= 2 and d >= c -> $01
e - d >= 2 and e >= c -> $ff
otherwise             -> 0
```

| Check | Addr | `b` | `c` | Meaning |
|---|---|---|---|---|
| `CheckGameWon` | `$08:$5d37` | 3 | 4 | 4 points, 2 clear; `$80` at 3-3 sets `wDeuceIndicator` |
| `CheckTiebreakGameWon` | `$08:$5d54` | 6 | 7 | 7 points, 2 clear; `$80` at 6-6 sets `wDeuceIndicator` |
| `CheckSetWon`, normal | `$08:$5ce9` | 6 | 6 | 6 games, 2 clear |
| `CheckSetWon`, short (`wMatchTypeNumberOfGames == 2`) | `$08:$5d14` | 2 | 2 | 2 games, 2 clear |
| `CheckMatchWon` | `$08:$5cc3` | — | `(wMatchTypeNumberOfSets + 1) >> 1` | 1, 2 or 3 sets |

`ResetAdvantageToDeuce` (`$08:$5bc6`) bounds the counters: if both equal `b + 1`
they return to `b` (4-4 → 3-3; 7-7 → 6-6 in a tiebreak).

**Tiebreak entry** is `CheckSetWon`'s `$80`: at 6-6 (2-2 short set) it sets
`wTiebreakerIndicator` and awards no set. An `inc d`/`inc e` fudge in the same
routine makes the eventual 7-6 count as a 2-game lead so the set closes.

`wMatchTypeNumberOfGames` is only a two-way switch (`cp $02`): 2 = short-set
rules, anything else = 6-game rules.

Awards: `AwardPoint` increments the winner's points, clears `wServeFaultFlag`,
bumps `wTotalPointsScoredInCurrentGame`. `AwardGame` increments games, zeroes
both point counts, the in-game point counter and `wDeuceIndicator`, bumps
`wTotalGamesWonInMatch`. `AwardSet` increments sets, zeroes both game counts and
`wTiebreakerIndicator`.

### Situation flags — game, set and match point

`EvaluatePointSituation` (`$08:$5b2e`) **dry-runs the scoring code**: saves the
16 bytes at `$c8e0` on the stack, fakes `wPointWinLoseFlag` from the sign of the
point difference, calls `ApplyPointToScore`, copies the game/set/match
win-lose flags into `wGamePointFlag`/`wSetPointFlag`/`wMatchPointFlag`, and
restores. Level point counts zero all three, **so deuce is never a situation**.

`AnnouncePointSituation` (`$08:$4d8c`) picks BGM (match/set point → `$0f`, game
point → `$10`, tiebreak → `$0e`, else `wMatchBGM`) and banner (match point
`$0a`, set point `$09`, game point `$07` or `$08` by whether server or receiver
holds it — `wCurrentServingPlayer` XOR the flag's sign). Deuce surfaces only as
sound `$69` in the point-end sequence and `LoadDeuceAdvantageGfx` on the score
panel; at advantage the leader's digit stays 4 and the other side's is drawn as
digit 5 (`$09:$403f`).

### Resolving and displaying

`ResolvePointOutcome` (`$08:$4df4`) re-centres the camera and dispatches on
`wPointOutcome` (10 entries):

| Outcome | Presentation |
|---|---|
| 1-5 | `ShowCourtBanner(wPointOutcome)` — banner id = outcome (`add $00` at `$08:$4e90` is deliberate) |
| 6 | `ShowCourtBanner(wPointWinnerShotType + $17)` — ids 24-28, SERVICE/RETURN/SMASH ACE, LOB, DROP SHOT |
| 7, 8 | `ShowMessageWindow` rule-violation popup |
| 0, 9 | nothing |

`ResolvePointResultSequence` (`$08:$4e22`) then: match won → banner `$0d`, set
won → `$0c`, game won → `$0b`, else the score-reveal animation; each ends in
`DelayAfterPointResolution` (70 skippable frames plus 10).

Court banner ids used by bank `$08`: `$00` change ends, `$01`-`$05` point
outcomes, `$07`/`$08` game point, `$09` set point, `$0a` match point,
`$0b`/`$0c`/`$0d` game/set/match won, `$0e` power serve, `$0f` tiebreak,
`$18`-`$1c` winning-shot banners.

### Per-character statistics

`UpdatePointStats` (`$08:$5c2b`) always records faults, then returns unless the
outcome is 6. It then calls the recorders in the order drop shot, lob, smash
ace, return ace, service ace; each overwrites `wPointWinnerShotType`, so the
**last applicable wins**: service ace > return ace > smash > lob > drop. Their
shared tail (`$08:$5cb2`) indexes `$c8c0 + charIndex*8` and saturates at 99.

Records are 8 bytes per character at `$c8c0`/`$c8c8`/`$c8d0`/`$c8d8`: service
aces, return aces, smash aces, lob winners, drop-shot winners, faults, double
faults, spare. Two spares are reused: `$c8cf` (`wPrevCourtPos`), `$c8df`
(`wMatchRngState`).

### Changing ends

`CheckServerEndChanged` (`$08:$4c19`), once per `AssignCourtPositions`, compares
character 0's new `wCharCourtPos` with `wPrevCourtPos` and raises
`wChangeEndsPending` if bit 1 differs. `RunChangeoverSequence` (`$08:$5f8c`)
shows banner `$00` (unless `wChangeoverSkipBanner`) and walks everyone to their
new ends.

The position tables drive it:

- Normal games: `GetGamePositionHandler` (`$08:$4808`) indexes an 8-byte record
  by `wTotalGamesWonInMatch & $03`; character 0's end bit goes 0, 1, 1, 0 —
  **ends change after every odd game**, serve role alternates every game.
- Within a game, `wTotalPointsScoredInCurrentGame` bit 0 flips only the service
  box (`FlipCharPositionCode` XORs bit 0).
- Tiebreak: `TiebreakPositionTables` indexed by
  `wTotalPointsScoredInCurrentGame` (0-23), end bit flipping **every six
  points**. `InitTiebreakPointCounter` (`$08:$47cd`) seeds the counter from
  `wTotalGamesWonInMatch & 3` via a table of multiples of six so the phase is
  right for either game parity.

A position record is four `wCharCourtPos` codes then four `wCharServeRole`
codes, written into the four WRAM banks by `LoadPositionRecord` (`$08:$48ed`).

`wPrevCourtPos` also feeds `UpdateViewFlipState` (`$08:$4c33`), which mirrors the
court view (`FlipAllCharPositions`, mirrored scoreboard layout) to keep the
human's end nearest the camera when the saved camera option asks.

## Doubles and the partner

Doubles is the same engine with `wOnCourtCharCount = 4` (3 for Two-On-One, using
WRAM banks 4, 5 and 7) and `wMatchIsDoubles` set.

- **Geometry.** `wCourtLimitX` `-$240`, `wAimSpreadBase` `$0320`
  (`$08:$4104-$4111`); the serve still uses the singles width (see the
  [serve box](#per-frame-ball-events)).
- **Teams are {0,2} and {1,3}.** Within a team one member's role has bit 1 set,
  the other's clear; `ToggleCharCourtRow` (`$08:$4971`) XORs the role with `$02`
  to swap places.
- **`wCharServeRole & $02` = forward member** and selects the AI variant
  (`$08:$787a`): set → net player at depth `$0180`; clear → baseliner at
  `$0460`.
- **The baseliner shadows.** `AiBaselinerShadowPartner` (`$08:$7e22`) reads only
  the **sign** of the teammate's walk-target X and parks at ∓192 in the opposite
  half at baseline depth.
- **The net player poaches.** `AiDoublesTrackBallPhase` (`$08:$7ed2`), on the
  teammate buffering a shot button, jumps to `AiNetPlayerPoachCheck`
  (`$08:$7f11`): ball in *my* swing range → take it; otherwise, ball deeper than
  the teammate by over 32 units → slide across.
- **Doubles AI always places.** `AiSwingControlDoubles` (`$08:$7f8a`) picks the
  forward opponent and calls `AiAimAwayFromChar` directly, skipping the
  `wAiAimAwayChance` roll.
- **Point-end spacing.** `StartPointEndReactions` (`$08:$4fb8`) turns everyone to
  the result, then `SpreadTeammateTargets` (`$08:$4ff5`) puts teammates within
  `$200` depth exactly `$200` apart around their midpoint, never closer than
  `$100` to the net. Singles skips it (low-count slots point at a bank-0 `ret`).

## Two players over the link cable

A link match is **input lockstep**: both consoles simulate everything, and only
one joypad byte per frame crosses each way. No ball, score or position state is
sent during a point.

### The fork

`StepMatchFrame` (`$08:$4465`):

```
hLinkExchangeActive == 0  ->  AdvanceFrame ; UpdateMatchFrame ; inc hMatchFrameCounter
hLinkExchangeActive != 0  ->  farcall RunLinkMatchFrame            $07:$4762
```

`RunLinkMatchFrame` bumps `hMatchFrameCounter` and dispatches on `hLinkState`
(`$ffc2`; `LINKSTATE_MASTER` / `LINKSTATE_SLAVE`) to `RunLinkMatchFrameMaster`
(`$07:$4081`) or `…Slave` (`$07:$409a`), identical apart from the exchange:

```
PrepareLinkStatePayload              $07:$49f7   flip the tag bits, snapshot the local pad
ExchangeLinkFrameByteMaster/Slave    $07:$467f / $46ef   <- AdvanceFrame happens in here
SerialDecodeInput                    $00:$2994   received byte -> hLinkRemoteInput / hLinkInput
SoftResetIfABStartSelect
farcall UpdateMatchFrame                         the full simulation, same routine as local play
SerialEncodeInput                    $00:$2924   queue the next outgoing byte
```

The tick comes from the exchange: the master spins until `rLY == $8c`, queues
the byte, starts the transfer and calls `AdvanceFrame`; the slave blocks in
`AwaitSerialByte`, then calls `AdvanceFrame`. One byte per frame; the consoles
cannot drift.

### The wire format during play

`SerialEncodeInput` packs a **6-bit payload plus a 2-bit alternating tag**,
draining the local input a piece at a time:

| Local input | Payload | Residue kept for the next frame |
|---|---|---|
| low nibble is all four buttons | `$3f` | `$0f` |
| START held | `$30` | `$08` |
| SELECT held | `$0c` | `$04` |
| otherwise | d-pad in payload bits 2-5, A/B in bits 0-1 | input with SELECT/START masked off |

`$0c`, `$30` and `$3f` are the physically impossible d-pad combinations
(Left+Right, Up+Down, all four), hence safe escapes. `$00` = nothing this frame;
`$ff` = line fault. The tag (`hLinkTxSeqBits`, inverted every frame) separates
fresh bytes from retransmissions: `ExchangeLinkFrameByteMaster` compares against
`hLinkLastRxByte`, retries once on a repeat and on a second identical byte calls
`InitSerialLink` then `LinkErrorReset`; the slave resets on the first repeat.

`ComposeLinkStateByte` (`$07:$4cfe`) picks the pad snapshot by
`hLinkPayloadKind` (`$ffdd`): kind 0 (live play — held d-pad plus edge-triggered
buttons; set by `ResetMatchState`, `ResetPointState`) or kind 2 (menus —
edge-triggered d-pad too; set by `RunMatchPauseMenu` and the story pause menu).
Kinds 1 and 3 are in the table but never selected.

### Who drives which character

`UpdateLinkSession` (`$07:$4846`) sets `wCharInputSource` to `$05` in bank `$04`
and `$06` in bank `$05`. Those handlers read `hLinkRemoteInput` and
`hLinkRemoteInputBuf` **with polarity keyed on `hLinkState`**
(`$08:$7833`/`$783f`), so the master always drives character 0 and the slave
character 1, on either console.

`hLinkRemoteInputBuf` is not remote in a match: `PrepareLinkStatePayload` seeds
it with the previous frame's *local* residue, so each console reads its own
slightly delayed input for its character and the decoded peer byte for the
other. Doubles partners keep AI handler `$01`, which works because the AI is
bit-reproducible: `ResetMatchState` normally seeds `wMatchRngState` from
`hVBlankCounter`, but `cp GAMEMODE_LINK_MATCH` at `$08:$4133` substitutes zero
when `wGameMode` is `$09`, and `AdvanceMatchRng` (`$08:$43f6`) is a pure
function of its state and the ball's fractional coordinates.

### Blocks, checksums and failure

Bulk data (character selections, court-unlock mask, EXP records) sends **one
nibble per byte** with the tag in bits 6-7 (`UnpackBytesToNibbles` `$07:$4656`,
`PackNibblesToBytes` `$07:$49b0`, `ExchangeNibbleBlockMaster/Slave`
`$07:$40b3`/`$41ef`), freeing `$c0`-`$cf` for `LINKMSG_*` control tokens:
`$c1`/`$c2` handshake probe/reply, `$c3`/`$c4` block sync, `$c5`/`$c6` end of
block and echo, `$cc` compare checksums, `$cb` mismatch → retransmit the block,
`$cd` accepted, `$c0` nothing to say. Blocks carry a 16-bit byte sum
(`ComputeNibbleBufferChecksum` `$07:$440c`) compared four nibbles at a time.
This path clears `hLinkExchangeActive` and disables the LCD, so it never runs
inside a match frame.

Per-frame exchanges have no checksum. A malformed reply (`$00`, `$ff`, or tag
bits not exactly `$40`/`$80`) goes straight to `LinkErrorReset` (`$00:$284b`) —
the ten-try loop after that call in `ExchangeLinkFrameByteMaster` is
unreachable. `LinkErrorReset` shows the link-error screen and soft-resets.
`ResyncLinkSession` (`$07:$4a51`) is only called from the link menus, so a cable
fault during a point ends the session.

### Connecting

Role election is first-come: `TryEstablishLink` (`$07:$4048`) becomes slave if
the peer's `$c1` is already in `hLinkRxByte`, else master and sends `$c1`.

At boot `InitSerialLink` loads `SB` with `$c0` and arms an external-clock
transfer, so a console on the main menu answers any probe with `$c0` and latches
the probe. The first player to choose Link Play becomes master: `$c0` back is
neither silence (`$ff`) nor a rival master (`$c1`), so it draws the waiting
message and probes once a frame for up to 1,000 frames. When the second player
chooses Link Play, `TryMainMenuLinkHandshake` finds the latched `$c1` and takes
the slave path; its `$c2` reaches the master a probe later. It fails if both
choose at once (each hears the other's `$c1`) or if the second chooses while the
master's message is still drawing (the slave's `AwaitSerialByte` counts loop
passes, not frames, once a VBlank goes unanswered, and gives up within a few
frames). Then come the rules screen (per-frame exchange), the unlock-flag nibble
block, character select, and the match loop.

## Character stats into the engine

A character arrives as a **`$40`-byte record**; `LoadCharacterAttributes`
(`$07:$5ab3`) turns it into the `$df60`-`$df95` fields.

### The four slot records

`CharAttrStructPtrs_07` (`$07:$5c42`), indexed by `wCharIndex` (Main, Main,
Partner, Partner — not monotonic):

| `wCharIndex` | WRAM bank | Record |
|---|---|---|
| 0 | `$04` | `$ca00` — player 1 main |
| 1 | `$05` | `$ca80` — player 2 main |
| 2 | `$06` | `$ca40` — player 1 partner |
| 3 | `$07` | `$cac0` — player 2 partner |

`InitCa00RecordFromCharId` (`$02:$4066`) fills a slot:

- **Roster character** (id bit 7 clear): 29 bytes from
  `StoryCharacterRecords_02` (`$02:$52cf`, 100 `char_record` rows) into offset
  `+$0f` — exactly the span `LoadCharacterAttributes` reads.
- **Created story character** (bit 7 set): 64 bytes from the saved record at
  `$c900` or `$c940`, earned stats verbatim.

`ApplyCpuDifficultyToCharRecords` then overwrites `+$1b`-`+$1e` of CPU slots
([Difficulty](#difficulty)).

### Where the story bars come from

`RecomputeCharacterStats` (`$02:$44e9`) runs at level-up and equipment change,
never at match time. Per stat (eleven) it computes `5 * L_i - (level - 1)`, where
`L_i` is one of the four allocation levels (Spin, Power, Control, Speed) and
`level - 1` their sum (each level-up, `LevelUpPlayerRecord`, raises one of the
four); clamps it signed (`ScaleStatForBarLevel`, `$02:$44b7`); and looks it up in
a **9-entry ascending signed threshold table** for a 0-9 bar
(`LookupStatBarLevel`, `$02:$4494`). A bar measures how *unevenly* level-ups
were spent. Equipment then adds signed per-stat deltas clamped to 0-9
(`ApplyStatModifiers`, `$02:$468e`) — e.g. the Large Racket trades spin for angle
and placement, Light Shoes stopping for speed. Results live in the saved record
(`$c920`-`$c92a` bars, `$c938`-`$c93b` levels).

### What each stat actually governs

| Record byte | Story stat | Struct field | Effect in the engine |
|---|---|---|---|
| `+$20` | Top | `wTopspinPlacementIndex` `$df6e` | placement row for topspin, power topspin, serve-topspin — spin pair *and* trajectory block, i.e. lateral angle deltas |
| `+$21` | Slice | `wSlicePlacementIndex` `$df6f` | same for slice, power slice, serve-slice |
| `+$22` | Serve | `wSmashServeSpeedIndex` `$df6c` | speed row for the smash and all three serves; also indexes `SmashElevationBySpeed_24` |
| `+$23` | Stroke | `wGroundStrokeSpeedIndex` `$df6b` | speed row for topspin, slice, their power variants, neutral |
| `+$24` | Volley | `wReachSpeedIndex` `$df6d` | speed row for the reach shots |
| `+$25` | Angle | `wCharAimOffsetScale` `$df69` | fraction of the aim spread applied |
| `+$26` | Placement | `wCharAimJitterScale` `$df6a` | aim error via a **descending** table — higher stat, less jitter |
| `+$27` | Speed | `wCharMaxSpeedX` `$df60` | lateral speed cap |
| `+$27` + `+$2b` | Speed (+ per-character bonus byte) | `wCharMaxSpeedDepth` `$df62` | depth speed cap |
| `+$28` | Dash | `wCharAcceleration` `$df64` | acceleration, both axes |
| `+$29` | Reaction | `wCharFacingEaseRate` `$df68` | maximum turn per frame |
| `+$2a` | Stop | `wCharDeceleration` `$df66` | braking |
| `+$10` | — | `wCharReachHeight` `$df70` (`-$10`) | vertical reach; bounds all three contact boxes |
| `+$12` | — | `wCharReachX` `$df72` | lateral reach; dive threshold |
| `+$14` | — | `wCharSmashJumpSpeed` `$df74` (`+$200`) | jump-smash launch speed |
| `+$16` | — | `wCharDiveSpeed` `$df76` | dive lunge speed |
| `+$19` | — | `wCharSwingAttrWord` `$df90` | high byte bits 0/1 pick the lob and drop placement rows |
| `+$0e` | handedness | `wCharMirrorAttrMask` `$df94` | counts into `wShotAimMirror` |
| `+$0f`, `+$1b`-`+$1f` | — | the `wAi*` block | AI behaviour ([The AI](#the-ai)) |

`OverrideCharStatsForDebug` (`$07:$5cf4`), reached only when
`Unused_07_RunDebugTestMatch` sets `wDebugMatchFlags` bit 1, forces a
near-perfect AI: 4-frame reaction delays, zero tracking latency, aim-away chance
`$ff`, serve style 2, zero aim jitter, adaptive strategy (1).

## WRAM state you will need

Per-address detail is in `ram/wram.asm`; the per-character struct is
[above](#one-struct-per-wram-bank) and in `include/ram_mirrored.inc`. Working
set, less addresses already given in the text:

| Address | Symbol(s) | Notes |
|---|---|---|
| `$c8a6` | `wGameMode` | `$08` Mario minigames, `$09` linked play |
| `$c8f0`/`$c8f1` | `wMatchTypeNumberOfSets` / `…Games` | 1/3/5 sets; 2 or 6 games |
| `$c8f2`/`$c8f3` | `wMatchIsDoubles` / `wOnCourtCharCount` | 2, 3 or 4 characters |
| `$c4cf` | `wOnCourtCharCountMinus1` | index for every per-count dispatch |
| `$c8f4`/`$c8f5` | `wCurrentlyUsedCourt` / `wMatchContext` | context 2 = minigame |
| `$c8f8` | `wMatchBGM` | overridden by tiebreak/situation BGM |
| `$c430`-`$c43f` | `wShotAim*` | aim point, legs, angle, spread base |
| `$c450`/`$c452` | `wBallTargetX` / `wBallTargetDepth` | predicted landing; the AI's main input |
| `$c484`/`$c486`/`$c488` | `wCourtLimitX` / `wCourtLimitDepth` / `wNetHeight` | limits negated |
| `$c48a`-`$c48f` | `wShotDistMin`/`Max`, `wShotTrajRowMin`/`Max` | distance window |
| `$c4a0`-`$c4a7` | `wCurrentShotType`, `wShotChargeLevel`, `wSpecialShotFlag`, `wShotAimMirror` | the shot in flight |
| `$c4ac`/`$c4ad` | `wCourtSurfaceFriction` / `wCourtSurfaceBounce` | per-court damping |
| `$c4b0`-`$c4b4` | `wBallCourtQuadrant`, `wBallOutOfBoundsBits`, `wBallBounceCount`, `wBallBounceEvent`, `wBallCrossedNetFlag` | per-frame ball verdicts |
| `$c4b6`-`$c4b9` | `wRallyLength`, `wBallHitEvent`, `wLastShotCharIndex`, `wLastShotServeRole` | |
| `$c4be` | `wBallQuadrantAtHit` | compared by the in/out rules |
| `$c4c2` | `wPauseDisabled` | |
| `$c4d0`/`$c4d1` | `wServiceAceFlag` / `wReturnAceFlag` | from the rally length on a winner |
| `$c4d2`-`$c4d4` | `wServingCharWramBank`, `wCurrentServingPlayer`, `wServingCharCourtPos` | the server, three ways |
| `$c4d5`-`$c4d7` | `wMatchPointFlag`, `wSetPointFlag`, `wGamePointFlag` | `$01`/`$ff`/0 |
| `$c8e0`-`$c8e5` | `wPlayer{1,2}{Sets,Games,Points}Won` | points 0-3 = 0/15/30/40, 4 = advantage, 5-7 tiebreak only |
| `$c8e6`/`$c8e7` | `wDeuceIndicator` / `wTiebreakerIndicator` | |
| `$c8e8`-`$c8eb` | `wMatch`/`wSet`/`wGame`/`wPointWinLoseFlag` | `$01` even-index side, `$ff` odd, 0 undecided |
| `$c8ec`/`$c8ed` | `wTotalGamesWonInMatch` / `wTotalPointsScoredInCurrentGame` | drive ends and service boxes |
| `$c8ee` | `wServeFaultFlag` | 1 after a first-serve fault |
| `$ffc2` | `hLinkState` | 0 idle, 1 master, 2 slave |
| `$ffd3`-`$ffd6` | `hLinkInput`, `hLinkRemoteInput`, `hLinkRemoteInputBuf`, `hLinkTxInput` | per-frame input plumbing |
| `$ffd8` | `hLinkExchangeActive` | the `StepMatchFrame` fork |
| `$ffe9` | `hMatchFrameCounter` | stepped identically on local and link paths |
| `$ff96` | `hWramBank` | effectively the current character |

## Known gaps

- **World scale** (105 units/m) is inferred; the fixed-point layouts are proven,
  the metric reading is not.
- **`wCharFlags` bit 6** is written by `StepCharMovement` and read nowhere.
- **Placement-record bytes `+6`/`+7`** are zero in all fifteen tables, with no
  reader.
- **Court record byte 4** in `CourtSceneDataTable` has no reader.
- **The incoming-pace term's sign** — intent not established
  ([The speed budget](#the-speed-budget)).
- **Trajectory-row overflow**: `wShotTrajRowMin`/`Max` are bytes and blocks hold
  64 rows; not proven that a very shallow aim angle cannot push
  `wShotDistMax >> 6` past 63.
- **`wCharInputSource` 2 and 3** are never written; there appears to be no
  two-humans-one-console on-court path.
- **Link input ages**: the slave stages the local residue one frame deeper than
  the master. Net latency is probably equal on both sides; the frame alignment
  is not established.
- **Unreachable code**: `Unused_08_ComputeBallEtaToChar` and its only caller
  `UnusedComputeBallEtaToCharWrapper` (`$08:$70f1`); the lob check after
  `AiChoosePositionByStrategy`'s jump table (`$08:$7d37`, no slot points at it);
  `Unused_07_SetSpecialShotFlagThreshold` (`$07:$59ec`);
  `Unused_07_ApplyCharStatPreset` (`$07:$5d1e`). The prologue of
  `AiNetPlayerPoachCheck` (`$08:$7f11-$7f21`) runs but the `a` it leaves is
  unused.
