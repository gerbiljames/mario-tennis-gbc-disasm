# The match engine

How a tennis match works in Mario Tennis (GBC): the frame loop, the ball, the
players, the AI, scoring, doubles, and the link-cable two-player path.

Every non-obvious claim below carries its evidence as a `bank:$addr`, a symbol
name, or a `src/…asm:LINE` reference. Where something could not be established
from the source it says so; hedged truth is deliberate.

Companion documents: `ram_map.md` (address-by-address RAM notes, including the
per-character struct), `save_format.md`, `bugs.md`.

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
| `$08` | **The match engine.** Match/set/game/point loops, the per-frame simulation, ball physics, the per-character state machine, movement, scoring, the camera, the sprite-slot renderer, and the whole CPU AI. 99.5% code. |
| `$07` | The **shot solver** (`ExecuteShot` and everything it calls) and the **serial-link engine**. Also `LoadCharacterAttributes`, which turns a character id into the stat fields the engine reads. |
| `$09` | Match **HUD and on-court objects**: the scoreboard digits, serve indicator, court banners, and the shared "object slot" system the match uses for them. |
| `$06` | Scoreboard/rules/pause-menu drawing (`DrawScoreboard`, `ShowMatchScoreboardScreen`, `RunMatchPauseMenu`). |
| `$20`-`$24`, `$29`-`$2c` | **Ball-path banks** — the precomputed trajectory tables, one bank per shot-type family (see [The shot](#the-shot-from-swing-to-trajectory)). |
| `$2d` | `SineTable` (`$2d:$4000`, 4 KiB) and `CosecantTable` (`$2d:$5000`, 4 KiB), the trig tables all the geometry goes through. |
| `$28` | Match graphics loaders (`LoadMatchGraphics`, effect tiles). |
| `$0d`, `$0b`, `$0a` | Minigame/drill drivers that reuse the match engine through its mode hooks. |
| `$04` | *Not* match AI, despite the overworld/actor code living there. Its one contribution to a match is `SetupCharSpriteFromObjectDef` (`src/engine/story/actor3_04.asm`), which fills a character's sprite/animation pointer fields. |

Entry points are published through bank `$08`'s farptr header at `$08:$4000`
(`src/engine/match/slots_08.asm`) — 56 slots, which is the engine's public API. The
outer callers are the exhibition and story menus (`$10`, `$0a`, `$0b`, `$38`,
`$01`) plus `Unused_07_RunDebugTestMatch` (`$07:$5df9`), a debug test match nothing reaches.

## How a match runs

The match is **not** a state machine driven from an outer loop. It is
straight-line code that *blocks on frames*: every wait, animation and banner
delay is a call that spins the whole frame pipeline the required number of
times. The call graph is the match structure.

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

`wMatchAbortFlag` (`$c4c3`) is how any of those loops is broken out of: bit 7
set breaks the point/game/set/match loops (tested at `$08:$472c`, `$4748`,
`$476e`), bit 0 aborts the current rally (`$08:$4d2c`). Every quit-menu action
sets it to `$ff`; `ResetPointState` clears it (`$08:$4cd8`).

### Stepping frames

| Routine | Addr | Behaviour |
|---|---|---|
| `StepMatchFrame` | `$08:$4465` | One frame. Saves the WRAM bank, then either `AdvanceFrame` + `UpdateMatchFrame` + `inc hMatchFrameCounter` locally, **or** `RunLinkMatchFrame` if `hLinkExchangeActive` is set. Then `HandlePauseMenu` and the (returned-out) debug-editor hook, unless the sim is frozen. |
| `StepMatchFrames` | `$08:$4428` | `a` frames, aborting early on `wMatchFramesAbort` (`$c492`). |
| `StepMatchFramesSkippable` | `$08:$4436` | Same, but A or B ends the wait early (`and $03` at `$4443`). This is what makes banners dismissable. |
| `RunMatchFramesUntilInput` | `$08:$4452` | Spins until any button but SELECT/START (`and $f3`). |

Because the pause menu is polled inside `StepMatchFrame`, pausing works at
every one of those wait points without the callers knowing about it.

### One simulation frame

`UpdateMatchFrame` (`$08:$41f7`, `src/engine/match/match_08.asm`) runs, in this fixed
order, with WRAM bank `$04` mapped:

1. `ClearSpriteSlots` — reset every sprite-slot record for the frame
2. `UpdateMatchCamera`
3. `UpdateAllChars` — `UpdateChar` once per WRAM bank `$04`-`$07`
4. `HandleBallHitEvent` — consume `wBallHitEvent`
5. `HandleBallTouchCharEvent` — consume `wBallTouchCharFlag`
6. `UpdateBallVisuals` — which is also where `StepBallPhysics` is reached
7. `TickRallyTimers`
8. `HandleBallBounceEvent` — consume `wBallBounceEvent`
9. mode hook 0, then a farcall through `$0902`
10. `DrawActorsByDepth` (skipped if `wMatchDrawFrozen`)
11. `UpdateMinigameTargets`
12. `DrawMarkersAndShadows` (skipped if `wMatchDrawFrozen`)

Two freeze flags gate it: `wMatchSimFrozen` (`$c4c0`) skips steps 1-9 and 11,
`wMatchDrawFrozen` (`$c4c1`) skips the draw steps. Both are set to `$ff` during
setup and while the pause menu is open.

Note the ordering consequence: characters move and may strike the ball *before*
the ball is integrated, and the four one-shot event flags raised inside step 3
(`wBallHitEvent`) and step 6 (`wBallBounceEvent`, `wBallCrossedNetFlag`) are
consumed in the same frame they are raised.

### Mode hooks

Minigames and drills reuse the engine wholesale and plug in through a table of
eight banked callbacks. `SetModeHookTable` (`$08:$671a`) stores the pointer and
bank in `wModeHookTable`/`wModeHookBank`; `CallModeHook` (`$08:$66f1`) takes the
hook id in `d`, reads the word at `table + id*2` out of that bank and calls it
there. `wModeHookBank == 0` disables the whole mechanism, which is the normal
match case.

| id | Fired from | When |
|---|---|---|
| 0 | `UpdateMatchFrame` `$08:$421d` | every simulation frame |
| 1 | `RunMinigamePointLoop` `$08:$65e9` | point start |
| 2 | `RunMinigamePointLoop` `$08:$660b` | point end |
| 3 | `RunMinigamePointLoop` `$08:$65d7` | once, before the first point |
| 4 | `HandleBallHitEvent` `$08:$42c1` | the ball was struck |
| 5 | `HandleBallBounceEvent` `$08:$4375` | the ball bounced |
| 6 | `TickRallyTimers` `$08:$4270` | ball crossed the net |
| 7 | `DrawActorsByDepth` `$08:$6425` | extra draw pass |

`ModeHookTable_07` (`$07:$5efc`) is a compact example, installed only by the
unreachable `Unused_07_RunTargetZoneTestMode`: it implements 1, 2, 4 and 5 and
stubs the rest.

### The minigame loop

Drills and minigames replace `RunMatchPlayLoop` with `RunMinigamePointLoop`
(`$08:$65be`, `src/engine/match/minigame_08.asm`), driven by a **point table**: an 8-byte
record per point (four court-position codes, four serve-role codes) that
`LoadMinigamePointLayout` (`$08:$6662`) reads out of the hook bank and installs
directly into each character's `wCharCourtPos`/`wCharServeRole`. The loop ends
when the next record's first byte is `$ff`. `PlayMinigamePoint` (`$08:$6631`) is
`PlayPoint` without any scoring — it settles the ball, calls `HandleServeFault`
and `FlagServiceReturnAce`, and returns.

## The world model: units, geometry, angles

### Fixed-point formats

| Quantity | Layout | Example |
|---|---|---|
| Ball position | 32-bit, 16 fraction bits (`16.16`) | `$c400` = X (frac lo, frac hi, int lo, int hi) |
| Ball velocity | 24-bit sharing the low 24 bits of a position | `$c420` = X velocity |
| Character position | 24-bit: one fraction byte + signed 16-bit integer | `$df00` = X |
| Character velocity | plain signed 16-bit | `$df40` = X |

The ball's velocity/position alignment is worth stating precisely because the
names are easy to misread. `AddVel24ToPos32` (`$08:$5a87`,
`src/engine/match/project_08.asm`) adds velocity byte 0 into position byte 0, byte 1 into
byte 1 and byte 2 into byte 2 — that is, **the velocity's 24 bits line up with
the position's two fraction bytes and its low integer byte**. So a raw velocity
word `v` advances the position by `v / 65536` world units per frame, and the
16-bit word the code reads at `$c421`/`$c424`/`$c427` (named `wBallVelocityX`
etc.) is the velocity in units of `1/256` of a world unit per frame, not in
whole units. `ram_map.md` calls those words the "integer part", which is true of
the 24-bit velocity but not of the position units.

### World scale

The geometry is a **real-dimension model at 105 world units per metre**. That
is a derivation, not a comment in the source, but five independent constants
agree on it:

| Constant | Address | Value | Real tennis dimension | units/m |
|---|---|---|---|---|
| Singles lateral limit | `$08:$40e5` | `$1b0` = 432 | 4.115 m half-width | 105.0 |
| Doubles lateral limit | `$08:$4305` | `$240` = 576 | 5.485 m half-width | 105.0 |
| Baseline depth | `$08:$40ee` | `$4e0` = 1248 | 11.885 m | 105.0 |
| Service line depth | `$08:$4cff` | `$2a0` = 672 | 6.40 m | 105.0 |
| Net height | `$08:$40f7` | `$60` = 96 | 0.914 m (centre) | 105.0 |

Gravity closes the loop. `StepBallPhysics` adds `$4a00` to the 24-bit height
velocity every airborne frame (`$08:$57bc-$57c2`), i.e. `$4a00 / 65536` =
0.2891 world units per frame². At 105 units/m and 60 frames/s that is
**9.91 m/s²**. Treat the 105 figure as a very well-supported inference rather
than a documented fact.

### Sign conventions

- **X** is lateral, signed, 0 at the centre of the court.
- **Depth** is signed with **0 at the net**; the two sides of the court have
  opposite signs. Each character's own depth carries the sign of its side, so
  most engine code compares absolute values and the AI mirrors through
  `MirrorDepthForFarSide` (`$08:$7c33`).
- **Height is negative-up.** `GetBallHeightSign` (`$08:$4677`) returns `$ff`
  when the 32-bit height is negative, and that is the airborne case; gravity is
  a *positive* addend. `HandleBallNetCrossing` relies on this when it adds
  `wNetHeight` to `wBallHeight` and treats a non-negative sum as "the ball is
  at or below the top of the net" (`$08:$5836-$583f`).
- **Court limits are stored negated.** `wCourtLimitX` holds `-$1b0` (singles) or
  `-$240` (doubles); `wCourtLimitDepth` holds `-$4e0`. `CheckBallOutOfBounds`
  (`$08:$463a`) takes `|wBallX|`, adds the stored negative and reads a carry as "out", so a single `add hl,bc` does the whole test. Results go to
  `wBallOutOfBoundsBits` (`$c4b1`): bit 0 = outside laterally, bit 1 = outside
  in depth.

### Angles and trig

An angle is a 16-bit value: **high byte = the angle with 256 to the full turn,
low byte = a fraction**. `wShotAimAngle`, `wBallHeadingAngle` and
`wBallPitchAngle` all use it, as does the overworld facing byte
(`FACE_RIGHT`/`DOWN`/`LEFT`/`UP` = `$00`/`$40`/`$80`/`$c0`).

The primitives are in ROM0 and go through bank `$2d`:

| Routine | Addr | Does |
|---|---|---|
| `MulSin` / `MulSinUnsigned` | `$00:$1351` / `$00:$1361` | `hl * sin(bc)`; folds the top half-turn onto the bottom by sign, then indexes `SineTable` at `$2d:$4000 + ((bc >> 3) & ~1)` — 2048 word entries over a half turn, `$8000` = 1.0 |
| `MulSinCos` / `MulSinCosSigned` | `$00:$1340` / `$00:$1332` | one call, both components: returns `hl*cos` in `hl` and `hl*sin` in `de` |
| `DivBySin` / `DivByCos` | `$00:$13ce` / `$00:$13ca` | `hl / sin(bc)` via `CosecantTable` at `$2d:$5000`, same indexing, result scaled `<<2` |
| `VectorLengthFromAngle` | `$00:$138f` | vector length given its angle and both legs — picks the numerically better axis (`sin` or `cos`) and divides |
| `AngleFromVector16` | `$00:$1416` | `atan2`, quadrant by quadrant |
| `VectorFromLengthAndAngleRaw` | `$00:$0af8` | coarse polar→cartesian off `QuarterSineTable` in ROM0 (`$00:$0b5c`), used for character-scale motion |

`ProjectWorldToScreen_08`/`ApplyCameraProjection` (`$08:$59b8`/`$59bb`) turn a
world `(X, depth, height)` into screen space; the camera offsets
`wCameraOffsetX`/`Y` are added before a `<<3`.

## The ball

### State

The ball lives in a contiguous block at `$c400`, in WRAM bank `$04` for the
parts that are banked (`ResetMatchState` clears `$c400`+`$0e` words at
`$08:$40ab`).

| Address | Symbol | Meaning |
|---|---|---|
| `$c400`/`$c404`/`$c408` | `wBallXFrac`/`wBallDepthFrac`/`wBallHeightFrac` | position, 32-bit `16.16`; integer parts at `$c402`/`$c406`/`$c40a` |
| `$c40c`/`$c40e` | `wBallPitchAngle`/`wBallHeadingAngle` | velocity direction, recomputed every frame |
| `$c410`-`$c41b` | `wBallPrev*` | the whole 12-byte position block as of the start of the frame |
| `$c41c`/`$c41e` | `wBallTopspin`/`wBallSideSpin` | spin coefficients |
| `$c420`/`$c423`/`$c426` | `wBallVelocity{X,Depth,Height}Frac` | velocity, 24-bit |
| `$c42a`/`$c42c` | `wBallSpeedHorizontal`/`wBallSpeed3D` | derived magnitudes |

### The physics step

`StepBallPhysics` (`$08:$5767`, `src/engine/match/ball3_08.asm`) is the whole
integrator, in order:

1. clear `wBallBounceEvent`
2. copy the 12-byte position block to `wBallPrev*` (`$08:$5774`)
3. add each velocity to its position (`AddVel24ToPos32` ×3)
4. `BounceBallOffCourtFences` (`$08:$5949`)
5. `HandleBallNetCrossing` (`$08:$5814`)
6. rebuild `wBallCourtQuadrant` from the two position sign bits — bit 1 = which
   side of the net, bit 0 = which lateral half (`$08:$5798-$57a9`)
7. `UpdateBallAnglesAndSpeed` (`$08:$45e5`): heading = `atan2(velX, velDepth)`,
   horizontal speed, pitch = `atan2(horizSpeed, velHeight)`, 3-D speed
8. `ApplyBallAirDrag` (`$08:$55b4`)
9. `ApplyBallSpin` (`$08:$5613`)
10. ground test — gravity, or bounce

**Drag** is speed-proportional. `ApplyBallAirDrag` builds
`b = (|wBallSpeed3D >> 8| >> 4) + 1`, then for each of the three axes subtracts
`(v/2) * b/256` from the velocity — so the coefficient rises in 16 steps with
the ball's own speed rather than being constant.

**Spin** is a rotation of the velocity vector, not a positional fudge
(`$08:$5613-$5765`):

- `wBallSideSpin` adds `+k·velDepth` to `velX` and `-k·velX` to `velDepth`, i.e.
  it rotates the horizontal velocity — the curve of a sliced ball.
- `wBallTopspin` multiplies `wBallVelocityHeight` by the coefficient and adds
  the negated product back along `wBallHeadingAngle` into the X/depth
  velocities, and multiplies `wBallSpeedHorizontal` by it into the height
  velocity — a Magnus rotation of the (horizontal, vertical) pair.
- Both coefficients decay by `3/256` per frame.

**Gravity and the bounce.** After the spin step, `GetBallHeightSign` decides:

- Airborne (height negative): add `$4a00` to the height velocity and return.
- At or through the ground: `ApplyCourtBounceDamping`, then *negate the whole
  32-bit height* — reflecting the penetration back above the court — then, if
  the height is now nonzero, raise `wBallBounceEvent = 1`, complement the height
  velocity (bounce up), and check `wBallVelocityHeight + $0250`: if the upward
  speed is below that threshold, zero both the height and the height velocity
  and the ball comes to rest (`$08:$57c6-$5812`).

`ApplyCourtBounceDamping` (`$08:$46b0`) multiplies both horizontal velocity
triples by `wCourtSurfaceFriction` and the height triple by
`wCourtSurfaceBounce` — 8-bit fractions loaded per court by
`LoadCourtSceneData` (`$08:$5e28`) from a 4-byte-per-court record at
`$08:$5dc4`: `[friction, restitution, scene-graphics id, unused]`. The fourth
byte of each record is not read by `LoadCourtSceneData`, and I found no other
reader of that table anywhere in `src/`.

**The net.** `HandleBallNetCrossing` (`$08:$5814`) detects the crossing by
XORing the high bytes of `wBallDepth` and `wBallPrevDepth` and testing bit 7 —
a sign flip means the ball passed depth 0 this frame. It raises
`wBallCrossedNetFlag` for exactly that frame. Then, unless the wall-practice
flag is set, it adds `wNetHeight` to `wBallHeight`; a non-negative sum means the
ball was **at or below the top of the net**, so it plays sound `$5a`, starts the
bounce effect, sets `wBallHasBouncedFlag`, quarters the X velocity, and reflects
the depth position — and from there three bands decide what happens next
(`$08:$5874-$5882`), measured against the net's `$60`:

| Contact height | Result |
|---|---|
| above `$5a` (within 6 units of the net top) | the spin is cleared and the ball carries on — the net-cord dribbler |
| `$58`-`$5a` | a narrow band that skips to the "crossed" path |
| below `$58` | the depth velocity is negated and cut to ⅛ — the ball drops back on the hitter's side |

`wBallHasBouncedFlag` (`$c4bf`) is set at exactly one site, `$08:$5848`, inside
that net branch. **Despite its name it means "the ball has touched the net since
the last strike", not "the ball has bounced."** That is what makes the let rule
in `EvaluateBounceOutcome` read correctly: a serve that touched the net *and*
landed in the correct box is a let. Two of its other readers
(`TickRallyTimers` `$08:$4262` and `AiTrackBallPhase` `$08:$7d73`) also mean net
contact, whatever the name suggests.

**Fences.** `BounceBallOffCourtFences` (`$08:$5949`) is the outer-wall bounce;
it raises `wBallBounceEvent = 2` (distinct from a ground bounce) after applying
the same court damping.

### Per-frame ball events

Four one-shot flags carry everything the rest of the engine reacts to. All are
raised in one routine and consumed in another, in the same frame.

| Flag | Raised by | Consumed by | Meaning |
|---|---|---|---|
| `wBallHitEvent` `$c4b7` | `ExecuteShot` `$07:$53b8` | `HandleBallHitEvent` `$08:$427a` | a character struck the ball |
| `wBallBounceEvent` `$c4b3` | `StepBallPhysics` `$08:$57e8` (=1), `BounceBallOffCourtFences` (=2) | `HandleBallBounceEvent` `$08:$4352` | ground / fence bounce |
| `wBallCrossedNetFlag` `$c4b4` | `HandleBallNetCrossing` `$08:$5827` | `TickRallyTimers` `$08:$4242` | the ball passed the net plane |
| `wBallTouchCharFlag` `$c4ae` | `CheckCharBallContact` `$08:$6f30` | `HandleBallTouchCharEvent` `$08:$43d3` | the ball hit a body |

`ExecuteShot` also refuses to run twice while `wBallHitEvent` is still set
(`$07:$53b0-$53b5`), which is what stops two characters hitting the same ball
on one frame.

`HandleBallHitEvent` (`src/engine/match/match_08.asm`) does the bookkeeping for a strike:
increment `wRallyLength` (saturating at `$64`), clear the bounce/marker flags,
start the landing marker and hit effect, poke every character's state through
`SetCharStateOnBallHit`, run `DetectServeAceOutcome`, fire mode hook 4, and
**zero `wBallBounceCount`**. Then two rally-length special cases:

- `wRallyLength == 1` (the serve was just struck): if `wSpecialShotFlag` is set,
  show court banner `$0e`.
- `wRallyLength == 2` (the serve has just been returned): restore the full court
  limits — depth back to `-$4e0` and X to `-$1b0`/`-$240` by format
  (`$08:$42f3-$430d`).

That last case is the whole **serve box** mechanism. `ResetPointState` tightens
`wCourtLimitDepth` to `-$2a0` (the service line) and `wCourtLimitX` to `-$1b0`
(the singles width, *even in doubles*) at `$08:$4cf6-$4d07`; the same
`CheckBallOutOfBounds` that judges rally shots therefore judges a serve against
the service box, and the limits are restored the instant the serve is returned.
The diagonal half of the rule is separate — see
[Scoring](#scoring-and-point-resolution).

### Visuals

The ball is drawn from a position-history ring rather than its live position.
`UpdateBallVisuals` (`$08:$5153`) shifts `wBallHistory` (`$dd00`, six 6-byte
records of `[projX, projY, tile, attr]`) down one record per frame;
`BuildBallSlot` writes the newest, and `BuildBallTrailSlots` draws 2 or 5
afterimages from the older records depending on `wBallTrailColor`. Fixed
sprite-slot records live at `$de00`-`$de1f`. `ram_map.md` §"Match renderer
sprite slots" has the full list; `DrawActorsByDepth` (`$08:$6429`) paints the
two team pairs and the ball group back-to-front using each character's
`wCharDepthKey` (`$df96`).

## The shot: from swing to trajectory

This is the most intricate part of the engine and the part worth understanding
first, because it is not what you would expect. **The game does not integrate a
launch velocity of its own choosing. It looks the answer up.** Each shot-type
family owns a bank of precomputed ballistic solutions indexed by how far the
ball has to travel, and the shot's "power" only decides which row of that table
is used.

### The chain

Everything hangs off `ExecuteShot` (`$07:$53b0`, `src/engine/match/shot2_07.asm`), which
the character state machine farcalls at the contact frame (`$08:$6bd1` for a
serve, `$08:$6c91` for a rally shot).

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
│     ├─ ApplyBallTrajectory       -> row search
│     ├─ SetBallVelocityFromEntry  -> farcall SetBallVelocityPolar  $08:$45a9
│     └─ SetBallTargetFromAim_20      -> wBallTargetX/Depth
└─ ShotRecoilFrameTask / ApplyShotRecoil   $07:$5463 / $546b
```

`ExecuteShot`'s snapshot (`$07:$53b0-$5422`) is what makes the rest of the frame
independent of which character swung: `wLastShotCharIndex`, `wLastShotServeRole`,
`wLastShotAimOffset`, `wCurrentShotType`, `wLastShotButtons`,
`wBallQuadrantAtHit`, `wShotChargeLevel` (= `min(wCharSwingFrames, $3f)`),
`wShotWasQuickSwing`, and the pre-hit ball velocity into `wShotRecoilVelocity*`.

`wShotAimMirror` (`$c4a7`) is set here too, as the **low bit of a count of four
conditions** (`$07:$53ef-$5410`): backhand swing animation (`$06`), animation
`$0a`, left-handed (`wCharMirrorAttrMask` nonzero), and serve
(`wRallyLength == 0`). When it comes out odd, every lateral aim offset later in
the pipeline is negated. That is how one set of tables serves both court sides
and both handednesses.

### Per-shot-type presets

`ApplyShotTypePresets` (`$07:$557e`) reads a **5-byte record** from
`ShotTypePresets_07` (`$07:$559e`), indexed by shot type: `[sound id, recoil
variant, trail colour, target depth lo, target depth hi]`, one `shot_preset`
row per `SHOTTYPE_*` with the sound as `SFX_HIT_*`. The target depth is
the shot's nominal landing depth past the net, and it is the shot type's whole
personality: ground strokes aim `$0280` (6.1 m), the power variants `$03c0`
(9.1 m), a smash `$0440` (10.4 m), lobs and drops `$0200` (4.9 m), serves
`$02a0` (6.4 m — the service line exactly).

Charge then bends that depth before the solver sees it:
`WeakenShotByCharge` subtracts `charge*4`, `BoostShotByCharge` (lobs) adds
`charge*12`, `NudgeShotByPlayerMomentum` adds `±wCharVelDepth/16`.

### Where the ball is aimed

`ComputeShotTrajectory` (`$07:$571e`, `src/engine/match/execute_07.asm`) turns that depth
plus the player's left/right nudge into a world aim point and a legal distance
window.

1. **Sign the depth by court side** (`wCharCourtPos & $02`) and store
   `wShotAimTargetDepth`; `wShotAimDeltaDepth = target - wBallDepth`
   (`$07:$5725-$573d`).
2. **Lateral target** from `ComputeShotTargetX` (`$07:$5646`):
   - On a serve (`wRallyLength == 0`) it tail-jumps to
     `GetShotAimOffsetForSide` (`$07:$55e9`), which picks a fixed offset from a
     4-record table chosen by `wCharCourtPos & 1` — the diagonal service box.
   - In a rally it is a five-way `rst Rst00` on `(wCharAimOffset + 2) & 7`, i.e.
     the player's held direction mapped to full-left / half-left / centre /
     half-right / full-right. The magnitude comes from `ComputeAimBaseOffset`
     (`$07:$56b7`): `(wAimSpreadBase + |charDepth|/8) * wCharAimOffsetScale/256`,
     where `wAimSpreadBase` is `$0220` singles / `$0320` doubles. So aiming from
     deep in the court swings the ball further sideways than aiming from the net.
   - `ClampShotTargetX` (`$07:$56e3`) then clamps to `-(wCourtLimitX + $20)` and
     subtracts a jitter, and every path adds or subtracts one
     `GetRandomAimJitter` (`$07:$570d`) — `rng * wCharAimJitterScale`, of which
     only the high byte is used, so effectively `rng*scale/16`. **The human
     player is jittered too**; accuracy is a stat, not a privilege.
3. **Aim angle** = `AngleFromVector16(depth leg, X leg)` → `wShotAimAngle`.
4. **The distance window.** This is where `$0140` and `$0480` live
   (`$07:$5783` and `$07:$57b8`):

   ```
   wShotDistMin = | (|wBallDepth| + $0140) / sin(wShotAimAngle) |
   wShotDistMax = | (|wBallDepth| + $0480) / sin(wShotAimAngle) |
   wShotTrajRowMin = wShotDistMin >> 6     ; high byte of (dist << 2)
   wShotTrajRowMax = wShotDistMax >> 6
   ```

   `|wBallDepth| + K` is the depth the ball must cover to land at depth `K` on
   the *other* side of the net; dividing by the sine of the aim angle converts
   that depth leg into a length along the aim line. So the two constants are the
   **shallowest and deepest landing depths the solver will consider**: `$0140`
   = 320 units ≈ **3.05 m past the net**, `$0480` = 1152 units ≈ **10.97 m**,
   which is the baseline (`$04e0`, 11.885 m) less a `$60` margin. The row window
   `[rowMin, rowMax]` is therefore exactly "the set of shot distances that land
   in".

   (`ram_map.md` describes `$0140` as "past the net" and `$0480` as "just inside
   the baseline"; the metric figures above follow from the world scale derived
   earlier. Note `$0140` is *not* the service line, which is `$02a0`.)

5. **Sideline shortening** (`$07:$57d7-$5850`). If the aim line would leave the
   court sideways before reaching `wShotDistMax`, the maximum is scaled down to
   the distance at which it crosses `wCourtLimitX + $0020`, and `rowMax` is
   recomputed. This is what stops a wide angled shot from being solved for a
   depth it can never legally reach.
6. `wShotSolverNegHeight = -wBallHeight`, and the aim point is copied into
   `wBallTargetX`/`wBallTargetDepth`.

### The speed budget

Inside the ball-path bank, `ComputeShotPlacement` (`$07:$5161`) dispatches to one
of 15 `ShotPlacement<Type>` handlers, each of which:

1. calls `LoadShotPlacementEntry` (`$07:$52a0`) on an **8-byte-stride** table:
   words at `+0`/`+2` (selected by a per-character *placement* index) become
   `wBallTopspin` and `wBallSideSpin` — the sidespin negated when
   `wShotAimMirror` is set — and the word at `+4` (selected by a per-character
   *speed* index) becomes the requested shot speed in `bc`;
2. adds an incoming-pace term, a charge term and finally `FinalizeShotSpeed`
   (`$07:$52d7`), which adds player momentum (`±wCharVelDepth/2`), applies a
   `-$0c00` penalty while `wCharFlags` bit 1 (diving) is set, and clamps the
   result up to a floor of `$0100` before storing `wShotSpeedFinal`.

The pace term is worth noting: `AddBallSpeedQuarter`/`3Sixteenths`/`Eighth`
(`$07:$52f1`/`$5301`/`$531d`) take a fraction of `wBallVelocityDepth` and force
it **negative** (`$07:$532f`: keep if already negative, otherwise negate). So
absorbing a fast incoming ball *reduces* the requested speed. The arithmetic is
unambiguous; whether it was intended is not established.

Lobs, drops and all three serves add nothing — they use the table word raw.

### The trajectory tables

Nine banks hold the tables, one per shot-type family. The `$4000-$427c`
prologue — the entry-pointer, row-search, velocity and target-projection
helpers — is **byte-identical in all nine**; only the header, the labelled
entry points and the trailing data differ.

| Bank | Family | Data |
|---|---|---|
| `$20` | slice | 15360 B, 6-byte rows |
| `$21` | power slice | 15360 B, 6-byte rows |
| `$22` | topspin | 15360 B, 6-byte rows |
| `$23` | power topspin | 15360 B, 6-byte rows |
| `$24` | lob, drop, neutral, smash, reach, **and the shared fallback** | several blocks, 4- and 6-byte rows |
| `$29`/`$2a`/`$2b` | serve topspin / slice / flat | 7200 B each |
| `$2c` | the three reach (stretch) placements | 3072 B + 2 × 4608 B |

`ram_map.md` calls these "court banks". They are not per-court — bank `$22` is
topspin on every court, and the per-court data is the two damping bytes in
`CourtSceneDataTable` (`court_scene` rows, one per court id).

**The files.** Each table is extracted to `data/bank_02x/<Table>.asm` as one
`traj_row speed, elevation, delta` (or `traj_row4 speed, elevation`) per row,
with a `; block N` separator every 64 rows where the height and placement
offset tables index in 64-row blocks (the four stroke banks, neutral and
reach) and a `; row N` marker every sixteen elsewhere; the bank `INCLUDE`s
the file, and `make check` (`traj`) proves the rendering parses back to the
bytes. Editing a row and running `make` is how a shot's reach or arc is
tuned; `tools/mods.py collect <baserom>` keeps the edit under `mods/`.

**A row.** Rows are 6 bytes (or 4 in the tables that do not carry a lateral
delta):

| Offset | Field |
|---|---|
| `+0` | launch **speed magnitude** — increases monotonically with row; doubles as the row-search key |
| `+2` | launch **elevation angle** — steep for the near rows, flattening as the distance grows |
| `+4` | lateral **aim delta** added to `wShotAimAngle`, negated when `wShotAimMirror` is set (6-byte rows only) |

**Which block.** Before searching, the bank narrows the table down twice
(`ShotBallPathSlice`, `src/data/shots/slice.asm` is the clearest example):

- `LookupBallPosByHeight_20` (`$20:$424c`) takes `-wBallHeight`, scales by 16 and
  masks to 5 bits — a **32-band contact-height stratification** in 16-unit
  steps — and adds the corresponding block offset.
- `LookupBallPosByShotIndex_20` (`$20:$426e`) adds a second offset chosen by the
  character's placement index for that shot family.

So the table is really `[placement variant][contact height band][distance row]`.
The drop-shot table adds a third axis keyed on the ball's distance from the court
origin (`LookupBallPosByAim_24`, `$24:$422d`), and the smash has no table at all
— `ShotBallPathSmash` (`$24:$6696`) computes its elevation directly and takes
the magnitude from a 10-entry table indexed by `wSmashServeSpeedIndex`.

**The row search.** `BallTrajEntryPtr6_20` (`$20:$4002`) computes
`block + (distance >> 6) * 6`, confirming that **row index = distance ÷ 64**
(≈ 0.61 m per row) and that this is the same quantity as `wShotTrajRowMin`.
`SeekBallTrajEntry6_20` (`$20:$401f`) then walks upward from `rowMin`:

```
d = wShotTrajRowMin ; e = wShotTrajRowMax
loop: if row.speed + (-requestedSpeed) carries   -> stop  (row.speed >= requested)
      if d >= e                                  -> stop  (hit the legal maximum)
      d++ ; pointer += 6
```

In words: **find the farthest distance bucket the shot's speed budget can pay
for, capped at the deepest legal landing spot.** The selected row's own speed and
elevation are then what is launched (`SetBallVelocityFromEntry6_20` →
`SetBallVelocityPolar`, `$08:$45a9`, which resolves
`(magnitude, elevation, heading)` into the three velocity triples), and the row
index is converted back to a distance (`row << 6`) for
`SetBallTargetFromAim_20` to place `wBallTargetX`/`wBallTargetDepth` — the landing
prediction the AI and the landing marker both use.

**The fallback.** If even the shortest legal row already costs more speed than
the shot has, the bank jumps to `ApplyFallbackBallTrajectory_24` (`$24:$57fd`):
it raises `wFallbackTrajectoryFlag`, clears both spin words and the trail colour,
substitutes one of three canned short target depths, re-runs
`ComputeShotTrajectory` and applies a separate fallback table. That is what a
shot too weak to clear 3 m past the net becomes — and both
`StartLandingMarker` (`$08:$52e1`) and the AI's `AiIsIncomingLobShot`
(`$08:$79e7`) treat the flag like a lob.

### The 15 shot types

`wCurrentShotType` (`$c4a0`) is the `rst Rst00` index at `$07:$5444`. The button
combinations come from `SelectRallyShotType`/`SelectServeShotType` — see
[On-court characters](#on-court-characters).

| Type | Constant | Buttons | Height prep | Charge | Path |
|---|---|---|---|---|---|
| `$00` | `SHOTTYPE_TOPSPIN` | A | Normalize | weaken | `$22` |
| `$01` | `SHOTTYPE_POWER_TOPSPIN` | A → A | Normalize | — | `$23`; falls back to `$00` while diving |
| `$02` | `SHOTTYPE_SLICE` | B | Normalize | weaken | `$20` |
| `$03` | `SHOTTYPE_POWER_SLICE` | B → B | Normalize | — | `$21`; falls back to `$02` while diving |
| `$04` | `SHOTTYPE_NEUTRAL` | A+B, or no valid combo | smash-range gate | — | `$24`; upgrades to smash if in range and the swing animation is 7/8 |
| `$05` | `SHOTTYPE_REACH` | (stretch fallback) | Normalize | weaken | `$24` |
| `$06`-`$08` | `SHOTTYPE_REACH_*` | as `$01`/`$03`/base, near the net | gate → `$05` | weaken | `$2c` |
| `$09` | `SHOTTYPE_SMASH` | reached only via `$04`'s upgrade | Normalize | — | `$24` |
| `$0a` | `SHOTTYPE_LOB` | A → B | Raise | boost + momentum | `$24` |
| `$0b` | `SHOTTYPE_DROP` | B → A | Raise | weaken | `$24` |
| `$0c`-`$0e` | `SHOTTYPE_SERVE_*` | A / B / A+B | — | — | `$29`/`$2a`/`$2b`, then `SetSpecialShotFlagFromBallHeight` |

Supporting gates:

- `CheckBallInSmashRange` (`$07:$5525`) returns "not smashable" (Z) if the ball
  is below `-$0070`; otherwise it sums two `AngleFromVector16` results over the
  ball's depth and height and tests the sign — a cone test rather than a simple
  height threshold.
- `NormalizeBallHeightForShot` (`$07:$5876`) pulls a very high contact point
  halfway back down toward `-$60`; `RaiseBallHeightForLob` (`$07:$5899`) forces
  the contact height up to at least `$ffa0`.
- `SetSpecialShotFlagFromBallHeight` (`$07:$5a01`) indexes a 32-byte table by
  contact-height band: bands `$15`-`$1f` set `wSpecialShotFlag`, so a serve
  struck above roughly `$150` (≈ 3.2 m) counts as a power serve. That is the
  visible reward for timing the toss.

`ShotRecoilFrameTask` (`$07:$5463`), pushed as `ExecuteShot`'s return address,
is the post-hit kick: it calls `ApplyShotRecoil` (`$07:$546b`), which damps the
hitter's velocity from a variant table selected by one of the character's
speed-stat bytes, then clears `wCharSwingFrames`.

## On-court characters

### One struct per WRAM bank

Every character on court is one copy of the same struct at `$df00`, in **its own
WRAM bank**: bank 4 = character 0, bank 5 = 1, bank 6 = 2, bank 7 = 3. Code
selects a character by mapping its bank; `wCharIndex` (`$df0b`) always equals
bank − 4, and **bit 0 of the index is which end of the court the character is
on**. `ForEachCharBank` (`$08:$6a3a`) runs a callback in banks 7, 6, 5, 4 and
leaves 4 mapped. `include/ram_mirrored.inc` is the authoritative field list; the
match-relevant fields are:

| Address | Symbol | Notes |
|---|---|---|
| `$df00`/`$df03`/`$df06` | `wCharPosX` / `wCharPosDepth` / `wCharPosHeight` | 24-bit (frac byte + signed 16-bit int) |
| `$df09` | `wCharServeRole` | 0 = server, 1 = receiver, 2/3 = partners, `$09` = slot unused |
| `$df0a` | `wCharCourtPos` | bit 1 = which end, bit 0 = which lateral half |
| `$df0b` | `wCharIndex` | 0-3; bit 0 = far side |
| `$df0c`-`$df0e` | `wCharBaseFacing` / `wCharFacingDesired` / `wCharFacingShown` | angle bytes |
| `$df0f` | `wCharFlags` | see below |
| `$df10` | `wCharFreezeTimer` | nonzero suspends the state machine entirely |
| `$df11` | `wCharShotComboTimer` | 5-frame simultaneity filter for the two-button read |
| `$df12`/`$df13` | `wAiActionTimer` / `wAiSecondButtonDelay` | AI timers |
| `$df14`-`$df17` | `wCharShotType`, `wCharSwingAnim`, `wCharShotButton1`, `wCharShotButton2` | the swing being built |
| `$df18`/`$df19`/`$df1a` | `wCharState` / `wCharStatePhase` / `wAiPhase` | the two state machines |
| `$df1e`/`$df1f` | `wCharInputSource` / `wCharInputBits` | who drives this character, and this frame's input |
| `$df40`-`$df45` | `wCharVel{X,Depth,Height}` | plain signed 16-bit |
| `$df46`/`$df48` | `wCharWalkTargetX` / `wCharWalkTargetDepth` | integer parts only |
| `$df4a`/`$df4b`/`$df4c` | `wCharAimOffset` / `wCharSwingFrames` / `wCharQuickSwing` | aim nudge, charge counter, quick-swing latch |
| `$df50` | `wCharBallReachFlags` | rebuilt every frame; see below |
| `$df57` | `wCharPointResult` | signed point result from this character's view |
| `$df58`-`$df5a` | `wAiShotButtons` / `wAiTrackingCountdown` / `wCharRallyReady` | |
| `$df60`-`$df7f` | the stat block | see [Character stats](#character-stats-into-the-engine) |
| `$df96` | `wCharDepthKey` | `(depth*8)>>8 + $80`, the painter's-order key |

`wCharFlags` (`$df0f`) bits, established from their use sites:

| Bit | Meaning | Read by |
|---|---|---|
| 0 | movement input suspended (`CHARB_RECOIL`) | `$08:$73d7` — kills steering. Its dominant writer is `ApplyShotRecoil` (`$07:$546e`), which runs after *every* stroke through `ShotRecoilFrameTask`, `ExecuteShot`'s pushed return address — not just on a body hit — and `CharRallyEndState` clearing it is what restores steering when the swing animation ends |
| 1 | diving | widens the contact box (`$08:$6fc7`), flat brake (`$74b3`), freezes facing ease (`$75c3`), `-$0c00` shot speed (`$07:$53a2`), disables power strokes |
| 2 | airborne | jump physics, shadow selection |
| 4 | moving | run animation |
| 5 | charging a swing | **velocity ÷ 8** in `StepCharMovement` (`$08:$72ed`) |
| 6 | the last move was refused | *nothing* — see below |

`wCharBallReachFlags` (`$df50`) is rewritten from scratch every frame by
`UpdateCharBallGeometry` (`$08:$6e64`): bit 0 = ball in swing range, bit 1 = ball
inside the contact window, bit 2 = body contact, bit 4 = **this character's own
depth is inside `$2a0` of the net** (`$08:$6ea6-$6ead`), bits 6/7 = lateral /
depth steering requested this frame. Bit 4 is the "I am at the net" bit; it
selects the volley/reach shot table and the AI's near/far reaction delay.
(`include/ram_mirrored.inc` describes bit 4 as "within normal reach", which the
code does not support.)

### The frame order for one character

`UpdateChar` (`$08:$6958`) is fixed and worth memorising, because most of the
engine's coupling is in this order:

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

`UpdateChar` returns immediately if `wCharObjectBank` (`$df22`) is 0, which is
how unused slots are skipped.

### The state machine

`UpdateCharStateMachine` (`$08:$6a62`) decrements `wCharFreezeTimer` and returns
if it was nonzero, ticks `wCharShotComboTimer`, then dispatches on `wCharState`
through the 8-entry table at `$08:$6a7b`. `wCharStatePhase` is a sub-index each
state dispatches on again; `AdvanceCharStatePhase` (`$08:$6a8b`) is a bare
`inc`, and its `.done` label is the shared `ret` that every "phase exhausted"
slot points at. `SetCharState` (`$08:$6a1c`) zeroes `wCharStatePhase`,
`wAiPhase`, `wCharFreezeTimer` and `wAiActionTimer` together.

| `wCharState` | Handler | Phases |
|---|---|---|
| 0 | (bare `ret`) | inert — set by `InitChar` and by a body hit |
| 1 | `CharRallyState` `$08:$6bea` | `CharRallyEndState`, `CharRallyReadyPhase`, `CharSwingWindupPhase`, `CharSwingContactPhase` |
| 2 | `CharServeStrikePhase.dispatch` `$08:$6bd9` | post-hit recovery: finish the swing, then movement only |
| 3 | `CharServeState` `$08:$6ae2` | init, wait-anim, `CharServeTossPhase`, `CharServeSwingWindowPhase`, `CharServeStrikePhase` |
| 4 | `CharAwaitServeState` `$08:$6cc8` | end-state, start-serve, check-input |
| 5 | `CharStandbyState` `$08:$6cbe` | end-state, then shares state 4's check-input |
| 6 | `CharWalkState` `$08:$6d0e` | `CharWalkToTargetPhase` — scripted walks (changeover, walk-off) |
| 7 | `CharPointEndState` `$08:$6d16` | end-state, walk-to-target, `CharPointReactionPhase` |

Two tables drive transitions:

- `ServeRoleCharStateTable_08` (`$08:$4fa0`) maps serve role → state at the
  start of each point: role 0 → 3 (serve), role 1 → 5, role 2 → 4, role 3 → 5.
- `SetCharStateOnBallHitTable` (`$08:$431e`), applied to **all four** characters
  on every ball hit, is `00 02 01 02 02 01 06 07`: it swaps 1 and 2, and also
  maps 3 → 2 (the server drops into recovery), 4 → 2 and 5 → 1, leaving only
  0/6/7 alone. So the fundamental rhythm is: whoever hit goes to recovery,
  everyone else goes to rally-ready, and both phase counters restart.
  Note that states 2 (`CHARSTATE_RECOVER`) and 4 (`CHARSTATE_AWAIT_SERVE`) are
  reached *only* through this table and `ServeRoleCharStateTable_08` — no
  instruction anywhere writes either value.

`CharRallyEndState` (`$08:$6a90`) is phase 0 of states 1, 2, 4, 5 and 7 rather
than a state of its own. It waits for the swing/dive animation to finish, clears
the buffered buttons and the charge counter, and only then advances the phase —
the gate that stops a new swing starting inside the old one.

### Input

`ReadCharInput` (`$08:$780c`) zeroes `wCharInputBits` and jumps through
`CharInputPtrs` (`$08:$781f`) on `wCharInputSource`:

| Value | Handler | Source |
|---|---|---|
| 0 | `ReadCharPadInput` | the local human |
| 1 | `CharInputHandler1_08` | the CPU AI |
| 2, 3 | `ReadCharPadInput` | never assigned by any code found |
| 4 | `CharInputHandler4_08` | raw `hLinkInput` |
| 5 | `CharInputHandler5_08` | link, local seat |
| 6 | `CharInputHandler6_08` | link, remote seat |

`InitChar` (`$08:$684a`) makes **every** character an AI (`$08:$687b`);
`InitAllChars` then overrides character 0 to the pad (`$08:$6925`). A link match
sets characters 0 and 1 to handlers 5 and 6 (`$07:$48ba-$48cb`). A debug hook in
the pause menu (`$06:$43d5`) does `xor $01` on character 0's source, i.e. hands
player 1 to the CPU.

`wCharInputBits` (`$df1f`) is two halves, built by `ReadCharPadInput`
(`$08:$7855`) as `(hPlayerInputFlags & $f0) | (hInputRisingEdge & $0f)` —
**high nibble = d-pad held, low nibble = buttons newly pressed this frame**.
There is therefore no button-release information in it at all, which is why the
"charge" mechanic is measured in windup frames rather than hold time.

### Building a swing

`BufferShotButtonPress` (`$08:$7112`) captures the two-button sequence:

- A and B pressed on the same frame → button 1 = `$03`.
- A press with `wCharShotComboTimer` expired (or the same button repeated) →
  latch it as button 1 if empty, else button 2 (and clear the timer);
  `wCharShotComboTimer` is reloaded to 5.
- A *different* button while that 5-frame timer is still running → collapses to
  `$03` as well.

So the 5-frame window is a **simultaneity filter**, not the combo window: a
genuine A→B sequence needs the second press *after* it expires.

`SelectRallyShotType` (`$08:$707e`) then indexes `button1 + 4*button2`, choosing
`RallyShotTypeTable0` when `wCharBallReachFlags` bit 4 is set (at the net) and
`RallyShotTypeTable1` otherwise:

| button 1 ↓ / button 2 → | none | A | B |
|---|---|---|---|
| **none** | topspin (reach-basic at net) | topspin / reach | topspin / reach |
| **A** | topspin / reach | **power topspin** / reach power topspin | **lob** |
| **B** | slice / reach | **drop** | **power slice** / reach power slice |
| **A+B** | neutral | neutral | neutral |

`SelectServeShotType` (`$08:$706b`) uses button 1 alone: A → serve topspin,
B → serve slice, A+B → serve flat.

`wCharSwingFrames` (`$df4b`) is the charge counter: zeroed when the rally-ready
phase arms, incremented once per frame by both the windup and contact phases, and
read by `StartCharSwing` — **fewer than 5 windup frames marks the swing "quick"**
(`$08:$6e30`), which bumps the animation and sets `wCharQuickSwing`, and
`ExecuteShot` clamps the count to `$3f` as `wShotChargeLevel`.

`StartCharSwing` (`$08:$6d5a`) picks *which* swing by geometry:

- if the ball's predicted lateral offset is beyond `wCharReachX` and the player
  is holding that direction → **dive** (animation `$12`, `wCharFlags` bit 1,
  lunge velocity from `wCharDiveSpeed`, sound `$5c`);
- else if the ball is high enough relative to `wCharReachHeight` → **jump
  smash** (airborne, `wCharVelHeight = -wCharSmashJumpSpeed`, animation `$08`);
- else a slightly lower band gives the overhead animation `$07`;
- else the forehand/backhand `SelectForehandBackhand` picked (`$05`/`$06`).

### Contact geometry

Three nested boxes, all rebuilt or tested each frame:

| Test | Addr | Depth | Lateral | Height | Result |
|---|---|---|---|---|---|
| `CheckBallInSwingRange` | `$08:$702a` | `< $a0` | `< 1.5 × wCharReachX` | — | bit 0 — "you may start a swing" |
| `CheckBallContactWindow` | `$08:$6fa7` | `< $60` | `< wCharReachX` (`1.25 ×` while diving) | `< 2 × wCharReachHeight` | bit 1 — "the racket connects" |

| `CheckCharBallContact` | `$08:$6ec5` | `< $10` | `2 × |relX| < wCharReachX` | `< wCharReachHeight` | bit 2 — the ball hit your body |

Note that `CheckBallContactWindow`'s four-way animation-id test (`$08:$6fda`-`$6feb`) has **no effect**: all four `jr z` targets are `.checkX`, which is also the fall-through, so the contact box does not vary by animation state. See `docs/bugs.md`.

`CharSwingWindupPhase` waits on bit 0 before `StartCharSwing`;
`CharSwingContactPhase` waits on bit 1 before `SelectRallyShotType` and
`ExecuteShot`. Only `wCharReachX` (`$df72`) and `wCharReachHeight` (`$df70`)
are per-character; the depth windows and the multipliers are hardcoded.

The body hit (`CheckCharBallContact`, only tested when no swing is buffered and
the character is in state 1) sets `wBallTouchCharFlag`, forces the character to
state 0, and reverses and heavily damps the ball — depth velocity `>> 4`, X and
height `>> 1` (`$08:$6f45-$6fa6`). `ApplyBallTouchOutcome` (`$08:$43e5`) then
sets `wPointOutcome = $09` and the point is lost by the character who was hit.

### Movement, and why characters slide along walls

`StepCharMovement` (`$08:$72de`) is the interesting one. It **refuses**
out-of-box moves rather than clamping them:

1. If `wCharFlags` bit 5 (charging) is set, both velocities are shifted right 3
   — **speed ÷ 8 while winding up** (`$08:$72ea-$7307`).
2. `res 6, [wCharFlags]`.
3. The candidate position is computed with `AddDEToMem24IntoBC` (`$08:$5ac7`),
   which returns the prospective integer part **without writing memory**. Only
   if the bounds pass does `AddDEToMem24` commit it. There is no clamping
   anywhere: a rejected axis simply does not move this frame, and
   `set 6, [wCharFlags]` records that it happened.
4. **The axes are judged independently.** `.blockX` (`$08:$7349`) falls through
   to the depth test, so a character pressed diagonally into a wall keeps the
   legal component — which is exactly the slide.

The bounds are hardcoded immediates in this routine and are *not*
`wCourtLimitX`/`wCourtLimitDepth` (those are the ball's):

| Axis | Commit requires |
|---|---|
| X | `-$3a0 ≤ X < $3a0` (`$08:$731f`, `$7327`) |
| Depth, near side | `$90 ≤ depth < $6e0` (`$08:$7361`, `$7367`) |
| Depth, far side | `-$700 ≤ depth < -$100` (`$08:$736f`, `$7375`) |
| Corner rule | `X ≥ $240` is only allowed when depth `≥ 0` or `< -$2a0` (`$08:$732f-$7347`, mirrored at `$737b-$738f`) |

The corner rule carves an asymmetric keep-out box out of one side of the far
court: `X >= $240`, between the net and depth `-$2a0`, for a human-controlled
player only. That is the **umpire's chair**. Every court tilemap that has one
(Clay, Grass, Hard, Training, Center, Composition, Tropics, Castle) stands it
at the right-hand net post on the far side, and positive X is screen-right (a
character placed at `X = +$300` beside the net is drawn at the right post).
With the view flipped so the human stays at the bottom of the screen, the
whole scene is drawn turned round and the chair appears at the *left* post on
the near side. A CPU player takes the
unclamped path and can walk through it.

**Bit 6 of `wCharFlags` is never read anywhere in the ROM.** The sliding is a
consequence of the refusal itself, not of anything consuming the flag; treat the
bit as diagnostic.

AI characters take a different path entirely. `wCharInputSource == 1` jumps to
`.unclamped` (`$08:$739f`), where X is committed unconditionally and only the
net-side depth bound is enforced. **CPU players are not held inside the
sidelines**; they stay on court because their target selection keeps them there.

The rest of the movement chain:

- `ApplyCharMovementInput` (`$08:$719a`) maps the held d-pad nibble through
  `DpadToFacingTable_08` (`$08:$7286`) to a facing angle — opposing pairs and
  no-direction map to a sentinel that aborts — and then **refuses to set the
  acceleration intent bits at all while the displayed facing is more than `$30`
  away from the desired one** (`$08:$71bf`). You must finish turning before you
  accelerate.
- `UpdateCharVelocityFromInput` (`$08:$73ca`) accelerates or decelerates each
  axis from `wCharBallReachFlags` bits 6/7, then clamps only the axes that
  accelerated. `AccelerateCharX/Depth` scale one stat, `wCharAcceleration`, by
  the cosine/sine of the desired facing; `ClampCharXSpeed/DepthSpeed` do the
  same with `wCharMaxSpeedX`/`wCharMaxSpeedDepth`, so **the speed cap follows
  the run direction** rather than being a scalar.
- `MoveCharTowardTarget` (`$08:$7541`) is the scripted-walk path: a fixed
  `$1000`-magnitude step toward `wCharWalkTarget*`, snapping and zeroing the
  velocity once `CheckCharNearTarget` (`$08:$78be`) sees both deltas below `$18`.
  It sets `wCharScriptedMove` (`$df56`), which `UpdateCharVelocityFromInput` honours,
  so scripted walking and input-driven acceleration cannot fight over the same
  frame.
- `StepCharJumpPhysics` (`$08:$72a6`) runs only while airborne and uses its own
  gravity constant `$0090` per frame — a different, coarser figure from the
  ball's `$4a00`, because character height is 24-bit rather than 32-bit.
- `HandleServePositioning` (`$08:$71dd`) is the server's lateral shuffle:
  left/right only, a fixed `$000a` step, and it tests the candidate `|X|` against
  `$20 ≤ |X| < $180` before committing.

## The AI

The AI is a **fake controller**. It never moves a character; it writes
`wCharInputBits` and lets the same state machine the human drives consume it
(`CharInputHandler1_08`, `$08:$7863`). Everything below therefore composes with
the swing, movement and contact rules already described.

### Structure

Three levels of dispatch:

1. `CharInputHandler1_08` first ticks `wAiActionTimer` and **returns while it is
   nonzero, leaving the input byte at zero** — that is the reaction delay, and
   during it the character is completely inert. Then it ticks
   `wAiSecondButtonDelay` and picks one of three jumptables on `wCharState`:
   singles, doubles net player, or doubles baseliner (chosen by
   `wCharServeRole & $02`, `$08:$787a`).
2. Those tables have 8 slots each but only three live entries — state 1 (rally),
   state 2 (recovery) and state 3 (serve). States 0 and 4-7 all point at
   `AiPhaseNoop`.
3. Each of those handlers is itself a jumptable on `wAiPhase` (`$df1a`).
   `AiAdvancePhase` (`$08:$7968`) is `inc [wAiPhase]` followed immediately by
   the `ret` labelled `AiPhaseNoop` (`$08:$796c`) — one shared byte that **26
   jumptable slots** point at.

Because `SetCharState` zeroes `wAiPhase`, and because every ball hit remaps every
character's state through `SetCharStateOnBallHitTable`, the whole AI restarts at
phase 0 on every stroke of the rally. That is the AI's clock.

The singles rally sequence is the canonical one
(`AiRallyStateSingles`, `$08:$7cfa`):

| Phase | Handler | Does |
|---|---|---|
| 0 | `AiSetReactionDelay` `$08:$7d0a` | `wAiActionTimer = (bit 4 of reach flags ? wAiReactionDelayNear : …Far) + rng(0-3)` |
| 1 | `AiChoosePositionByStrategy` `$08:$7d23` | pick a walk target |
| 2 | `AiTrackBallPhase` `$08:$7d73` | steer toward it; advance on arrival or on the ball entering swing range |
| 3 | `AiWaitThenPickShot` `$08:$7dad` | choose and press the first button |
| 4 | `AiSwingControlSingles` `$08:$7dcb` | add the second button, home on the ball, aim at contact |
| 5 | `AiPhaseNoop` | |

Recovery is two phases: `AiChooseHomePosition` then
`AiReturnToPositionPhase`.

### Steering

All AI movement funnels through two primitives. `AiSteerTowardTarget`
(`$08:$7908`) takes the target delta, gets a coarse angle, and uses its high
nibble to index `AngleToDpadTable_08` (`$08:$7296`) — a **16-sector
quantisation into d-pad bits** which then replaces the held nibble of
`wCharInputBits`. `AiSteerTowardBall` (`$08:$7944`) is the same on the
ball-relative words. Targets are computed by helpers that all end in
`jp AiAdvancePhase`:

| Helper | Addr | Target |
|---|---|---|
| `AiRushToBallLanding` | `$08:$796d` | `$0160` short of `wBallTarget*`, depth floored at `$0100` |
| `AiMoveBehindBallLanding` | `$08:$7992` | `$00c0` beyond the landing point |
| `AiInterceptAtMidCourt` | `$08:$799e` | depth `$0200` |
| `AiInterceptNearNet` | `$08:$79b0` | depth `$0100` |
| `AiMoveLaterallyToBallLine` | `$08:$79c2` | current depth, X = predicted ball X there |

`PredictBallXAtDepth` (`$08:$7c86`) is `(targetDepth - wBallDepth) *
tan(wShotAimAngle) + wBallX` — note it extrapolates along the **shot's aim
angle**, not the ball's live heading, so the AI is effectively reading the
solver's intent rather than watching the ball.

### Positional strategy

`AiChoosePositionByStrategy` (`$08:$7d23`) is an 8-way `rst Rst00` on
`wAiPositionStrategy` (`$df7f`), which comes from the character's attribute
record byte `+$0f` and is **not** touched by difficulty.

| Strategy | Behaviour |
|---|---|
| 0, 7 | behind the landing spot |
| 1 | **adaptive** — see below |
| 2 | rush to the landing spot if a drop or lob is incoming, else slide laterally |
| 3 | rush if drop/lob, else intercept at mid-court (depth `$0200`) |
| 4, 5 | slide laterally to the ball's line, holding depth |
| 6 | intercept near the net (depth `$0100`) |

The **adaptive** strategy (`$08:$7d58`) branches on `wCharBallReachFlags` bit 4,
i.e. on whether the character is currently inside `$2a0` of the net: up at the
net it commits to a mid-court intercept and chases drops as well as lobs;
back in the court it plays conservatively behind the landing spot and only
chases lobs. So "adaptive" adapts to the character's own court position, not to
the opponent.

`AiChooseHomePosition` (`$08:$7cae`) is a second, separate table on the same
strategy byte, used between shots: baseline (depth `$0460`), the net (hold the
current depth) or mid-court (`$0180`), with X set to `wBallTargetX >> 2` in every
case.

### Difficulty

**The 0-3 difficulty value is never read by the AI.** Difficulty is baked into
four parameter bytes before the match starts.
`ApplyCpuDifficultyToCharRecords` (`$38:$5f4c`) copies a 4-byte row per CPU slot
from `CpuDifficultyParamPtrs_38` (`$38:$5feb`; the rows are `cpu_difficulty`
records) into each character record's bytes `+$1b`..`+$1e`; `LoadCharacterAttributes` (`$07:$5ab3`) then loads them
into the struct. Slot 0 — the human — is never touched.

| Field | Struct | Easy → Intense | Effect |
|---|---|---|---|
| reaction delay, near | `$df79` | 28 → 2 frames | frames of total inertness after each stroke (`AiSetReactionDelay`) |
| reaction delay, far | `$df7a` | 24 → 2 frames | same, for a character away from the net |
| tracking parameter | `$df7b` | 12 → 0 frames | seeds `wAiTrackingCountdown`; `AiWaitThenPickShot` will not choose a shot until it expires *unless* the ball is already in swing range, so a low value lets the AI start its swing early |
| aim-away chance | `$df7c` | 60/256 ≈ 23% → 230/256 ≈ 90% | RNG threshold in `AiRollAimAwayFromChar` (`$08:$7b17`); below it the AI presses no direction at all and the shot goes down the middle |

Aim *jitter* is not a difficulty parameter — `wCharAimJitterScale` comes from the
character's own stats and applies to the human as well.

### When and what the AI swings

`AiWaitThenPickShot` (`$08:$7dad`) is the trigger: press immediately if
`wCharBallReachFlags` bit 0 (ball in swing range) is set, otherwise wait out
`wAiTrackingCountdown`. It then calls `AiPickShotButtons`, presses the first
button, and sets `wAiSecondButtonDelay = 5` — which is precisely the gap
`BufferShotButtonPress` needs to read A-then-B as a combo rather than A+B.

`AiSwingControlSingles` (`$08:$7dcb`) finishes the job: release the second
button once the delay expires, keep `AiSteerTowardBall` running while the ball is
outside the contact window, and **apply the directional aim on the contact frame
only** (`AiRollAimAwayFromChar`). Applying aim that late is why the CPU's
placement is hard to read.

`AiPickShotButtons` (`$08:$7b7b`) chooses in priority order:

1. If a lob is incoming (`wLandingMarkerActive`) and this character's habit row
   permits it → A+B → `SHOTTYPE_NEUTRAL`, which `ExecuteShotNeutral` upgrades to
   a smash when the ball is in smash range. The smash attempt.
2. Otherwise, half the time, and only for a close ball (`|relDepth| < $0140`),
   with a habit-row check, and — in singles — only if the opponent is inside
   depth `$01e0` → A→B → `SHOTTYPE_LOB`. **The CPU lobs when you come to the
   net.**
3. Otherwise a per-character 16-entry distribution of button pairs read from
   `CharGroupTable_02` (`$02:$5e23`, 9 rows × 16, written with the `AISHOT_*`
   button-pair codes) by `AdvanceMatchRng & $0f`, indexed by `wAiServeStyle`.
   This is the character's shot personality.

`AiAimAwayFromChar` (`$08:$7b1f`) reads the target character's X position **and
X velocity** out of that character's WRAM bank and rolls: 2 chances in 4 to aim
away from where the opponent is *moving* (wrong-footing him), 1 in 4 to aim away
from where he is, and 1 in 4 to aim deliberately **at** him.

### The AI serve

`AiServeState` (`$08:$79f2`) is five phases: walk to a random spot along the
baseline (one of eight X offsets), steer there, press A to toss, wait, strike,
apply aim.

The interesting part is the wait. `AiServePressToss` (`$08:$7a5f`) picks the gap
between toss and strike from a per-style row of `ServePressTossPtrs`
(`$08:$7a9d`): the row's eight bytes are a probability of a **short 35-frame gap
versus a long 50-frame gap**, from never (style 0) to always (style 3). Since
`SetSpecialShotFlagFromBallHeight` rewards a high contact point, those tables are
how a character's serve power is expressed. Nothing here is difficulty-scaled.

Buttons are `AdvanceMatchRng & $07` into an 8-byte table (`$08:$7b73`) giving
serve topspin 3/8, slice 2/8, flat 3/8; the aim is a straight 50/50 left/right
(`AiApplyServeAimTable`, `$08:$7b0b`) unless `wAiServeAimOverride` is set by a
minigame script.

## Scoring and point resolution

### Detecting the end of a point

The rally loop only watches `wPointOutcome` (`$c4d8`). Three routines write it,
each paired with `wPointOutcomeSide` (`$c4d9`), and **the first writer wins** —
they all bail if the outcome is already nonzero.

`EvaluateBounceOutcome` (`$08:$4379`), from `HandleBallBounceEvent`, is the main
judge. It is a fall-through ladder, evaluated in this order:

| Condition | Outcome | Side |
|---|---|---|
| `wRallyLength == 0` — nobody has hit yet | — | — |
| `wBallBounceCount != 1` — this is the second bounce | 6 `WINNER` | `$01` |
| the ball bounced on the same side of the net it was struck from (`(quadrant ^ quadrantAtHit) & 2 == 0`) | 4 `NET` | `$ff` |
| `CheckBallOutOfBounds` reports anything | 5 `OUT` | `$ff` |
| not the serve (`wRallyLength != 1`) | — (rally continues) | — |
| the serve did not change lateral half (`… & 1 == 0`) — wrong service box | 5 `OUT` | `$ff` |
| the serve touched the net (`wBallHasBouncedFlag`) but landed in the right box | 3 `LET` | `$00` |

`ApplyBallTouchOutcome` (`$08:$43e5`) sets outcome **9** when the ball hits a
body. `DetectServeAceOutcome` (`$08:$4326`), called from inside
`HandleBallHitEvent` at the moment of the *second* hit of the point (and
crucially *before* `wBallBounceCount` is cleared), produces the two codes that
are `POINTOUTCOME_SERVE_VOLLEYED` and `POINTOUTCOME_WRONG_RECEIVER`:

- **7** — the receiver struck the serve with `wBallBounceCount == 0`. The popup
  is text `30:372`, *"Return the serve after it bounces."*
- **8** — the second hit was made by anyone whose serve role is not 1, i.e. not
  the designated receiver. Text `30:373`, *"Only the receiving player may return
  the ball."*

Both use side `$ff`, so the offending side loses the point, and neither has a
court banner.

### Which side won

`wPointOutcomeSide` is **relative to the last hitter**: `$01` means the
striker's side wins, `$ff` means it loses, `$00` means nobody.
`ResolvePointWinner` (`$08:$5d9a`) converts it to an absolute signed winner:

```
outcome 1 (FAULT) or 3 (LET)  -> 0
outcome 9                     -> derived from wBallTouchCharIndex's parity (that side loses)
otherwise: wLastShotCharIndex bit 0 clear -> +wPointOutcomeSide
                               bit 0 set  -> -wPointOutcomeSide
```

The result goes to `wPointWinLoseFlag` (`$c8eb`): `$01` = the even-index
("player 1") side, `$ff` = the odd-index side. Every `Award*` routine turns that
sign into a counter pointer with the same `add a` / carry trick, and returns on
zero — which is how a fault or a let scores nothing at all and the point is
simply replayed.

### The score

`ScorePoint` (`$08:$5ad7`) is the whole scoring pass, in order:
`HandleServeFault`, `FlagServiceReturnAce`, `ResolvePointWinner`,
`UpdatePointStats`, then straight into `ApplyPointToScore`. It runs **before any
banner is shown** — `PlayPoint` calls it, then redraws the digits, then plays the
banners.

`HandleServeFault` (`$08:$5b7f`) fires only when `wRallyLength == 1` and the side
is `$ff`, so on a serve that went net or out but never on a let. First time it
raises `wServeFaultFlag` and rewrites the outcome to `POINTOUTCOME_FAULT` (1);
second time it clears the flag and writes `POINTOUTCOME_DOUBLE_FAULT` (2). Since
outcome 1 resolves to no winner, that is the whole two-serve rule.

`ApplyPointToScore` (`$08:$5ae6`) has two mirrored paths on
`wTiebreakerIndicator`, and both use one comparator, `EvalWinByTwo`
(`$08:$5d71`), with a "level" value `b` and a minimum `c`:

```
counts equal      -> $80 if the count == b (we are at the deuce/tiebreak threshold), else 0
d - e >= 2 and d >= c -> $01
e - d >= 2 and e >= c -> $ff
otherwise             -> 0
```

| Check | Addr | `b` | `c` | Meaning |
|---|---|---|---|---|
| `CheckGameWon` | `$08:$5d37` | 3 | 4 | 4 points with a 2-point lead; `$80` at 3-3 sets `wDeuceIndicator` |
| `CheckTiebreakGameWon` | `$08:$5d54` | 6 | 7 | 7 points with a 2-point lead; `$80` at 6-6 sets `wDeuceIndicator` |
| `CheckSetWon`, normal | `$08:$5ce9` | 6 | 6 | 6 games with a 2-game lead |
| `CheckSetWon`, short set (`wMatchTypeNumberOfGames == 2`) | `$08:$5d14` | 2 | 2 | 2 games with a 2-game lead |
| `CheckMatchWon` | `$08:$5cc3` | — | `(wMatchTypeNumberOfSets + 1) >> 1` | 1, 2 or 3 sets |

`ResetAdvantageToDeuce` (`$08:$5bc6`) is what keeps the point counters bounded:
if both equal `b + 1` they are both set back to `b` — 4-4 becomes 3-3 (advantage
lost, back to 40-40), 7-7 becomes 6-6 in a tiebreak.

**Tiebreak entry** is the `$80` return from `CheckSetWon`: at 6-6 (or 2-2 in a
short set) it sets `wTiebreakerIndicator` and awards *no* set, so the set
continues as a tiebreak game. A small `inc d`/`inc e` fudge inside the same
routine makes the eventual 7-6 read as a 2-game lead so the set does close.

`wMatchTypeNumberOfGames` is used **only** as a two-way switch (`cp $02`), never
as an arithmetic target: 2 means the short-set rules, anything else means the
6-game rules.

Awards: `AwardPoint` increments the winner's point count, clears
`wServeFaultFlag` and bumps `wTotalPointsScoredInCurrentGame`. `AwardGame`
increments the game count, zeroes both point counts, the in-game point counter
and `wDeuceIndicator`, and bumps `wTotalGamesWonInMatch`. `AwardSet` increments
the set count and zeroes both game counts and `wTiebreakerIndicator`.

### Situation flags — game, set and match point

`EvaluatePointSituation` (`$08:$5b2e`) works by **dry-running the scoring code**.
It copies the 16 bytes at `$c8e0` to the stack, fakes `wPointWinLoseFlag` from
the sign of the point difference, calls the real `ApplyPointToScore`, copies the
resulting `wGameWinLoseFlag`/`wSetWinLoseFlag`/`wMatchWinLoseFlag` into
`wGamePointFlag`/`wSetPointFlag`/`wMatchPointFlag`, and restores the 16 bytes.
If the point counts are level it just zeroes all three — **so deuce is never a
"situation"** and has no banner.

`AnnouncePointSituation` (`$08:$4d8c`) then picks BGM (match/set point → `$0f`,
game point → `$10`, tiebreak → `$0e`, else `wMatchBGM`) and a banner
(match point → `$0a`, set point → `$09`, game point → `$07` or `$08` depending
on whether the serving side or the receiving side holds it, computed by XORing
`wCurrentServingPlayer` against the flag's sign). Deuce surfaces only as sound
`$69` during the point-end sequence and as `LoadDeuceAdvantageGfx` on the score
panel; advantage is drawn by turning the digit 4 into a 5 (`$09:$403f`).

### Resolving and displaying

`ResolvePointOutcome` (`$08:$4df4`) re-centres the camera and dispatches on
`wPointOutcome` through a 10-entry table:

| Outcome | Presentation |
|---|---|
| 1-5 | `ShowCourtBanner(wPointOutcome)` — the banner id *is* the outcome code (the `add $00` at `$08:$4e90` is deliberate) |
| 6 | `ShowCourtBanner(wPointWinnerShotType + $17)` — banner ids 24-28, the SERVICE/RETURN/SMASH ACE, LOB and DROP SHOT banners |
| 7, 8 | a `ShowMessageWindow` rule-violation popup |
| 0, 9 | nothing |

Then `ResolvePointResultSequence` (`$08:$4e22`) branches on the flags scoring
just set, most significant first: match won → banner `$0d`, set won → `$0c`,
game won → `$0b`, else the ordinary score-reveal animation. Each ends in
`DelayAfterPointResolution` — 70 skippable frames plus 10.

Court banner ids seen from bank `$08`: `$00` change ends, `$01`-`$05` the point
outcomes, `$07`/`$08` game point, `$09` set point, `$0a` match point, `$0b`/`$0c`/`$0d`
game/set/match won, `$0e` power shot on the serve, `$0f` tiebreak, `$18`-`$1c`
the winning-shot banners.

### Per-character statistics

`UpdatePointStats` (`$08:$5c2b`) always records faults, then returns unless the
outcome was 6. For a winner it calls the five recorders in the order drop shot,
lob, smash ace, return ace, service ace — and since each overwrites
`wPointWinnerShotType`, **the last applicable one wins**, giving the priority
service ace > return ace > smash > lob > drop shot. All share a tail
(`$08:$5cb2`) that indexes `$c8c0 + charIndex*8` and saturates at 99.

Stat records are 8 bytes per character at `$c8c0`, `$c8c8`, `$c8d0`, `$c8d8`:
service aces, return aces, smash aces, lob winners, drop-shot winners, faults,
double faults, and one spare byte. Two of those spare bytes are reused as
scalars: `$c8cf` (`wPrevCourtPos`) and `$c8df` (`wMatchRngState`).

### Changing ends

`CheckServerEndChanged` (`$08:$4c19`) runs once per `AssignCourtPositions`,
i.e. before every point. It compares character 0's freshly-assigned
`wCharCourtPos` against the previous value latched in `wPrevCourtPos` (`$c8cf`)
and raises `wChangeEndsPending` if bit 1 — the end bit — differs.
`RunChangeoverSequence` (`$08:$5f8c`) then shows banner `$00` (unless
`wChangeoverSkipBanner` suppresses it) and walks everyone to their new ends.

The counter that actually drives it is inside the position tables:

- Normal games: `GetGamePositionHandler` (`$08:$4808`) indexes an 8-byte record
  by `wTotalGamesWonInMatch & $03`. Across those four records character 0's end
  bit goes 0, 1, 1, 0 — so **ends change after every odd-numbered game**, and the
  serve role alternates every game.
- Within a game, `wTotalPointsScoredInCurrentGame` bit 0 flips only the *service
  box* (`FlipCharPositionCode` XORs bit 0), never the end.
- In a tiebreak, `AssignCourtPositions` uses `TiebreakPositionTables` indexed by
  `wTotalPointsScoredInCurrentGame` (0-23), where the end bit flips **every six
  points**. `InitTiebreakPointCounter` (`$08:$47cd`) seeds that counter from
  `wTotalGamesWonInMatch & 3` through a table of multiples of six so the phase is
  right whichever game parity the tiebreak starts on.

A position record is 8 bytes: four `wCharCourtPos` codes then four
`wCharServeRole` codes, one per character, written straight into the four WRAM
banks by `LoadPositionRecord` (`$08:$48ed`). Role `$09` marks a slot that is not
on court.

`wPrevCourtPos` also feeds `UpdateViewFlipState` (`$08:$4c33`), which mirrors the
whole court view — via `FlipAllCharPositions` and a mirrored scoreboard layout —
so that the human player's end stays nearest the camera when the saved camera
option asks for it.

## Doubles and the partner

Doubles is the same engine with `wOnCourtCharCount = 4` (3 for Two-On-One) and
`wMatchIsDoubles` set. What changes:

- **Court geometry.** `wCourtLimitX` becomes `-$240` instead of `-$1b0`, and
  `wAimSpreadBase` `$0320` instead of `$0220` (`$08:$4104-$4111`). The serve is
  still judged against the singles width, because `ResetPointState` always
  installs `-$1b0` and only the return restores the doubles figure.
- **Teams are {0,2} and {1,3}** — characters two apart share an end. Serve roles
  come from the same 8-byte records, and within each team one member always
  holds a role with bit 1 set and the other clear. `ToggleCharCourtRow`
  (`$08:$4971`) XORs the role with `$02` to swap who stands where.
- **`wCharServeRole & $02` is the "forward member of my pair" bit**, and it is
  what selects the AI variant (`$08:$787a`): set → net player, working at depth
  `$0180`; clear → baseliner, working at depth `$0460`.
- **The baseliner shadows its partner.** `AiBaselinerShadowPartner`
  (`$08:$7e22`) banks to the teammate, reads only the **sign** of its walk
  target's X, and parks at ∓192 in the opposite half at baseline depth. The
  teammate's actual position is never used.
- **The net player poaches.** `AiDoublesTrackBallPhase` (`$08:$7ed2`) watches for
  the teammate having buffered a shot button and jumps to
  `AiNetPlayerPoachCheck` (`$08:$7f11`): if the ball is already in *my* swing
  range, take the shot off my partner; otherwise, if the ball is deeper than the
  teammate by more than 32 units, slide across to cover.
- **Doubles AI always places its shots.** `AiSwingControlDoubles` (`$08:$7f8a`)
  picks whichever opponent is the forward one and calls `AiAimAwayFromChar`
  directly, bypassing the `wAiAimAwayChance` roll that gates the singles version.
- **Spacing at point end.** `StartPointEndReactions` (`$08:$4fb8`) makes every
  character face the result, then `SpreadTeammateTargets` (`$08:$4ff5`) walks
  each team pair apart: teammates whose depths are within `$200` get targets
  exactly `$200` apart around their midpoint, never closer than `$100` to the
  net. Singles skips it — the jumptable's low-count slots point at a bank-0
  `ret`.
- Two-On-One (`wOnCourtCharCount == 3`) uses WRAM banks 4, 5 and 7.

## Two players over the link cable

A link match is **input lockstep**. Both consoles run the whole simulation, and
the only thing that crosses the cable during play is one joypad byte per frame in
each direction. No ball state, no score, no position is ever transmitted while a
point is live.

### The fork

`StepMatchFrame` (`$08:$4465`) is the single fork point:

```
hLinkExchangeActive == 0  ->  AdvanceFrame ; UpdateMatchFrame ; inc hMatchFrameCounter
hLinkExchangeActive != 0  ->  farcall RunLinkMatchFrame            $07:$4762
```

`RunLinkMatchFrame` bumps `hMatchFrameCounter` itself and dispatches on
`hLinkState` (`$ffc2`; `LINKSTATE_MASTER` / `LINKSTATE_SLAVE`) to `RunLinkMatchFrameMaster`
(`$07:$4081`) or `…Slave` (`$07:$409a`). The two are identical apart from the
byte exchange:

```
PrepareLinkStatePayload              $07:$49f7   flip the tag bits, snapshot the local pad
ExchangeLinkFrameByteMaster/Slave    $07:$467f / $46ef   <- AdvanceFrame happens in here
SerialDecodeInput                    $00:$2994   received byte -> hLinkRemoteInput / hLinkInput
SoftResetIfABStartSelect
farcall UpdateMatchFrame                         the full simulation, same routine as local play
SerialEncodeInput                    $00:$2924   queue the next outgoing byte
```

The frame *tick* therefore comes from the exchange rather than from the caller:
the master spins until `rLY == $8c`, queues the byte, starts the transfer and
calls `AdvanceFrame`; the slave blocks in `AwaitSerialByte` and then calls
`AdvanceFrame`. One byte per video frame, and the two consoles cannot drift.

### The wire format during play

`SerialEncodeInput` packs a **6-bit payload plus a 2-bit alternating tag** into
each byte, and drains the local input a piece at a time:

| Local input | Payload | Residue kept for the next frame |
|---|---|---|
| low nibble is all four buttons | `$3f` | `$0f` |
| START held | `$30` | `$08` |
| SELECT held | `$0c` | `$04` |
| otherwise | d-pad bits packed into payload bits 2-5, A/B into bits 0-1 | input with SELECT/START masked off |

`$0c`, `$30` and `$3f` work as escapes because they are exactly the
**physically impossible** d-pad combinations (Left+Right, Up+Down, all four).
`$00` means "nothing this frame", and `$ff` is treated as a line fault. The tag
bits (`hLinkTxSeqBits`, inverted every frame) let the receiver tell a fresh byte
from a retransmission; `ExchangeLinkFrameByteMaster` compares each byte against
`hLinkLastRxByte` and re-initialises the link on the second identical byte.

`ComposeLinkStateByte` (`$07:$4cfe`) decides *which* pad snapshot to send, from
`hLinkPayloadKind` (`$ffdd`): kind 0 (live play — held d-pad plus edge-triggered
buttons, set by `ResetMatchState` and `ResetPointState`) or kind 2 (menus —
edge-triggered d-pad too, set by `RunMatchPauseMenu`). Kinds 1 and 3 exist in the
table and are never selected.

### Who drives which character

`UpdateLinkSession` (`$07:$4846`) sets `wCharInputSource` to `$05` in WRAM bank
`$04` and `$06` in bank `$05` (`$07:$48ba-$48cb`). Those two handlers read
`hLinkRemoteInput` and `hLinkRemoteInputBuf` **with opposite polarity keyed on
`hLinkState`** (`$08:$7833`/`$783f`), so the master always drives character 0 and
the slave character 1, whichever console you are sitting at.

`hLinkRemoteInputBuf` is not remote at all in a match:
`PrepareLinkStatePayload` seeds it with the previous frame's *local* residue, so
each console reads its own slightly-delayed input for its own character and the
decoded peer byte for the other. In doubles the two partners keep the AI handler
`$01` from `InitChar` — which only works because the AI is bit-reproducible.

That reproducibility is deliberate: `ResetMatchState` normally seeds
`wMatchRngState` from `hVBlankCounter`, but `cp $09` at `$08:$4133` substitutes
zero when `wGameMode` is `$09` — the linked-play mode. From then on
`AdvanceMatchRng` (`$08:$43f6`) is a pure function of its own state and the
ball's fractional coordinates, so both consoles stay in step.

### Blocks, checksums and failure

Bulk data — character selections, the court-unlock mask, EXP records — goes
through a separate path that sends **one nibble per byte** with the tag in bits
6-7 (`UnpackBytesToNibbles` `$07:$4656`, `PackNibblesToBytes` `$07:$49b0`,
`ExchangeNibbleBlockMaster/Slave` `$07:$40b3`/`$41ef`). Nibbling frees `$c0`-`$cf`
for in-band control tokens that payload can never collide with, the
`LINKMSG_*` constants: `$c1`/`$c2` handshake probe and reply, `$c3`/`$c4`
block sync, `$c5`/`$c6` end of block and its echo, `$cc` compare checksums,
`$cb` checksum mismatch → retransmit the whole block, `$cd` block accepted,
`$c0` nothing to say. The serial-control writes are spelled with
`hardware.inc`'s `SC_START | SC_FAST | SC_INTERNAL` / `SC_EXTERNAL`. Blocks are
protected by a 16-bit byte sum (`ComputeNibbleBufferChecksum` `$07:$440c`)
compared four nibbles at a time. This path clears `hLinkExchangeActive` and
disables the LCD, so it can never run inside a match frame.

Per-frame exchanges have no checksum. Instead the master retries a malformed
reply up to ten times and re-initialises on a duplicate; anything unrecoverable
reaches `LinkErrorReset` (`$00:$284b`), which is **not** a recovery path — it
shows the link-error screen and soft-resets. `ResyncLinkSession` (`$07:$4a51`) exists but is only called from the link menus, never from inside
`RunMatchPlayLoop`: a cable fault during a point ends the session.

Role election is first-come: `TryEstablishLink` (`$07:$4048`) reads
`hLinkRxByte`, and if the peer's `$c1` probe is already sitting there this side
becomes the slave, otherwise it becomes the master and sends `$c1` itself.

### Connecting, as it actually happens

Played out between two emulated consoles (`tools/linktest.py`), the
handshake needs the players in a particular order. At boot `InitSerialLink`
loads `SB` with `$c0` and arms an external-clock transfer, so a console
sitting on the main menu answers any probe with `$c0` and latches the probe
in its serial interrupt. The first player to choose Link Play becomes the
master: its first `$c1` probe gets `$c0` back, which is neither silence
(`$ff`) nor a rival master (`$c1`), so it draws the waiting message and then
probes once a frame for up to 1,000 frames. The second player's console has
been latching those probes; when that player chooses Link Play,
`TryMainMenuLinkHandshake` finds `$c1` already in `hLinkRxByte` and takes
the slave path, whose `$c2` reply reaches the master a probe later. Both
players choosing Link Play at once fails -- each probes, and each hears the
other's `$c1` -- and so does the second player choosing it while the
master's message is still being drawn: the slave's `AwaitSerialByte` counts
loop passes, not frames, once a VBlank has gone unanswered, and gives up in
a few frames. After the handshake the pair walks the rules screen (per-frame
input exchange), trades the unlock-flag block by nibbles, and goes on
through character select into the match loop described above.


## Character stats into the engine

A character reaches the court as a **`$40`-byte record**, and
`LoadCharacterAttributes` (`$07:$5ab3`) is the single routine that turns one into
the `$df60`-`$df95` stat fields.

### The four slot records

`CharAttrStructPtrs_07` (`$07:$5c42`) is four RAM pointers indexed by
`wCharIndex`:

| `wCharIndex` | WRAM bank | Record |
|---|---|---|
| 0 | `$04` | `$ca00` — player 1 main |
| 1 | `$05` | `$ca80` — player 2 main |
| 2 | `$06` | `$ca40` — player 1 partner |
| 3 | `$07` | `$cac0` — player 2 partner |

(The addresses are on a `$40` stride but the pointer table is not monotonic — it
is Main, Main, Partner, Partner.)

`InitCa00RecordFromCharId` (`$02:$4066`) fills a slot from a character id:

- **Roster character** (id bit 7 clear): copies 29 bytes from a 100-record ROM
  table (`StoryCharacterRecords_02`, `$02:$52cf`, 29-byte stride, one
  `char_record` row per id with the character's name beside it) into record
  offset `+$0f` — which is exactly the span `LoadCharacterAttributes` reads. The
  eleven stat bars for Mario, Bowser and company are hard-coded there.
- **Created story character** (id bit 7 set): copies 64 bytes from `$c900` or
  `$c940`, the saved story records, so a created character brings its earned
  stats into the match verbatim.

`ApplyCpuDifficultyToCharRecords` (`$38:$5f4c`) then overwrites bytes `+$1b`-`+$1e`
of the CPU slots with a difficulty row, as described in [The AI](#the-ai).

### Where the story bars come from

`RecomputeCharacterStats` (`$02:$44e9`) runs at level-up and on equipment change,
never at match time. For each of eleven stats it computes
`5 * L_i - (level - 1)` — where `L_i` is one of the four allocation levels (Spin,
Power, Control, Speed) and `level - 1` is their sum — clamps it signed
(`ScaleStatForBarLevel`, `$02:$44b7`), and looks it up in a **9-entry ascending
signed threshold table** to produce a 0-9 bar (`LookupStatBarLevel`, `$02:$4494`).
So a bar measures how *unevenly* the character's level-ups were spent, not the
raw total. Equipment is applied afterwards as signed per-stat deltas clamped back
to 0-9 (`ApplyStatModifiers`, `$02:$468e`) — the Large Racket trades spin for
angle and placement, Light Shoes trade stopping for speed.

The results live in the saved story record (`$c920`-`$c92a` for the eleven bars,
`$c938`-`$c93b` for the four levels), which is why they persist across a match.

### What each stat actually governs

| Record byte | Story stat | Struct field | Effect in the engine |
|---|---|---|---|
| `+$20` | Top | `wTopspinPlacementIndex` `$df6e` | placement row for topspin and serve-topspin — chooses the spin pair *and* the trajectory block, i.e. the shot's lateral angle deltas |
| `+$21` | Slice | `wSlicePlacementIndex` `$df6f` | same for slice, power slice and serve-slice |
| `+$22` | Serve | `wSmashServeSpeedIndex` `$df6c` | speed row for the smash and all three serves; also the smash's velocity table |
| `+$23` | Stroke | `wGroundStrokeSpeedIndex` `$df6b` | speed row for topspin, slice, their power variants and neutral |
| `+$24` | Volley | `wReachSpeedIndex` `$df6d` | speed row for the reach (stretch) shots |
| `+$25` | Angle | `wCharAimOffsetScale` `$df69` | fraction of the aim spread actually applied — how far a directed shot can be pushed off centre |
| `+$26` | Placement | `wCharAimJitterScale` `$df6a` | random aim error, through a **descending** table, so a higher stat means *less* jitter |
| `+$27` | Speed | `wCharMaxSpeedX` `$df60` | lateral speed cap |
| `+$27` + `+$2b` | Speed (+ a per-character bonus byte) | `wCharMaxSpeedDepth` `$df62` | depth speed cap |
| `+$28` | Dash | `wCharAcceleration` `$df64` | acceleration on both axes |
| `+$29` | Reaction | `wCharFacingEaseRate` `$df68` | maximum turn per frame — how quickly you can change direction |
| `+$2a` | Stop | `wCharDeceleration` `$df66` | braking force |
| `+$10` | — | `wCharReachHeight` `$df70` (`-$10`) | vertical reach; bounds all three contact boxes |
| `+$12` | — | `wCharReachX` `$df72` | lateral reach; also the dive threshold |
| `+$14` | — | `wCharSmashJumpSpeed` `$df74` (`+$200`) | jump-smash launch speed |
| `+$16` | — | `wCharDiveSpeed` `$df76` | dive lunge speed |
| `+$19` | — | `wCharSwingAttrWord` `$df90` | bits 0/1 of the high byte pick the lob and drop placement rows |
| `+$0e` | handedness | `wCharMirrorAttrMask` `$df94` | counts into `wShotAimMirror`, so left-handers mirror every lateral offset |
| `+$0f`, `+$1b`-`+$1f` | — | the `wAi*` block | AI behaviour; see [The AI](#the-ai) |

`OverrideCharStatsForDebug` (`$07:$5cf4`), reached only when `wDebugMatchFlags`
bit 1 is set by `Unused_07_RunDebugTestMatch`, forces a perfect-AI profile: minimum
reaction delays, zero tracking latency, always place the shot, zero aim jitter,
net-play strategy.

## WRAM state you will need

`docs/ram_map.md` has the full per-address notes. This is the working set.

### Match format and identity

| Address | Symbol | Notes |
|---|---|---|
| `$c8a6` | `wGameMode` | which mode is playing; `$08` = Mario minigames, `$09` = linked play |
| `$c8f0`/`$c8f1` | `wMatchTypeNumberOfSets` / `…Games` | 1/3/5 sets; 2 or 6 games (used only as a two-way switch) |
| `$c8f2`/`$c8f3` | `wMatchIsDoubles` / `wOnCourtCharCount` | 2, 3 or 4 characters |
| `$c4cf` | `wOnCourtCharCountMinus1` | the jumptable index for every per-count dispatch |
| `$c8f4`/`$c8f5` | `wCurrentlyUsedCourt` / `wMatchContext` | court id; context 2 = minigame |
| `$c8f8` | `wMatchBGM` | overridden by the tiebreak/point-situation BGM |
| `$ca00`/`$ca40`/`$ca80`/`$cac0` | slot records | the four `$40`-byte character records |

### Ball and shot

| Address | Symbol | Notes |
|---|---|---|
| `$c400`-`$c42f` | `wBall*` | position, velocity, spin, angles, speeds |
| `$c430`-`$c43f` | `wShotAim*` | the aim point, its two legs, the aim angle, the spread base |
| `$c450`/`$c452` | `wBallTargetX` / `wBallTargetDepth` | the predicted landing point; the AI's main input |
| `$c484`/`$c486`/`$c488` | `wCourtLimitX` / `wCourtLimitDepth` / `wNetHeight` | **limits stored negated** |
| `$c48a`-`$c48f` | `wShotDistMin`/`Max`, `wShotTrajRowMin`/`Max` | the legal distance window and its row indices |
| `$c4a0`-`$c4a7` | `wCurrentShotType`, `wShotChargeLevel`, `wSpecialShotFlag`, `wShotAimMirror` | the shot in flight |
| `$c4ac`/`$c4ad` | `wCourtSurfaceFriction` / `wCourtSurfaceBounce` | per-court damping fractions |
| `$c4b0`-`$c4b4` | `wBallCourtQuadrant`, `wBallOutOfBoundsBits`, `wBallBounceCount`, `wBallBounceEvent`, `wBallCrossedNetFlag` | the per-frame ball verdicts |
| `$c4be`/`$c4bf` | `wBallQuadrantAtHit` / `wBallHasBouncedFlag` | the two flags the in/out and let rules compare |

### Point, game and match state

| Address | Symbol | Notes |
|---|---|---|
| `$c4b6`/`$c4b7`/`$c4b8`/`$c4b9` | `wRallyLength`, `wBallHitEvent`, `wLastShotCharIndex`, `wLastShotServeRole` | who hit what, and how many hits into the point |
| `$c4c0`-`$c4c3` | `wMatchSimFrozen`, `wMatchDrawFrozen`, `wPauseDisabled`, `wMatchAbortFlag` | the frame-loop controls |
| `$c4d0`/`$c4d1` | `wServiceAceFlag` / `wReturnAceFlag` | set from the rally length on a winner |
| `$c4d2`-`$c4d4` | `wServingCharWramBank`, `wCurrentServingPlayer`, `wServingCharCourtPos` | the server, three ways |
| `$c4d5`-`$c4d7` | `wMatchPointFlag`, `wSetPointFlag`, `wGamePointFlag` | `$01`/`$ff`/`0`, from the dry run |
| `$c4d8`/`$c4d9` | `wPointOutcome` / `wPointOutcomeSide` | 0 while the rally runs; side is *relative to the last hitter* |
| `$c8c0`-`$c8df` | per-character stat records | 8 bytes each; `$c8cf` and `$c8df` are reused as `wPrevCourtPos` and `wMatchRngState` |
| `$c8e0`-`$c8ed` | the 14-byte telemetry block | sets, games, points, deuce, tiebreak, then the four win/lose flags and two totals |
| `$c8ee` | `wServeFaultFlag` | 1 after a first-serve fault |

The telemetry block in full:

| Address | Symbol | Values |
|---|---|---|
| `$c8e0`/`$c8e1` | `wPlayer1SetsWon` / `wPlayer2SetsWon` | 0-3 |
| `$c8e2`/`$c8e3` | `wPlayer1GamesWon` / `wPlayer2GamesWon` | 0-7 |
| `$c8e4`/`$c8e5` | `wPlayer1PointsWon` / `wPlayer2PointsWon` | 0-3 = 0/15/30/40, 4 = advantage, 5-7 tiebreak only |
| `$c8e6`/`$c8e7` | `wDeuceIndicator` / `wTiebreakerIndicator` | 1 or 0 |
| `$c8e8`-`$c8eb` | `wMatchWinLoseFlag`, `wSetWinLoseFlag`, `wGameWinLoseFlag`, `wPointWinLoseFlag` | `$01` = the even-index side won, `$ff` = the odd-index side, 0 = undecided |
| `$c8ec`/`$c8ed` | `wTotalGamesWonInMatch` / `wTotalPointsScoredInCurrentGame` | drive the court-position tables and therefore ends and service boxes |

### Per-character

`$df00`-`$df96`, one copy per WRAM bank 4-7 — see
[On-court characters](#on-court-characters) and `include/ram_mirrored.inc`.

### HRAM

| Address | Symbol | Notes |
|---|---|---|
| `$ffc2` | `hLinkState` | 0 idle, 1 master, 2 slave |
| `$ffd3`-`$ffd6` | `hLinkInput`, `hLinkRemoteInput`, `hLinkRemoteInputBuf`, `hLinkTxInput` | the per-frame input plumbing |
| `$ffd8` | `hLinkExchangeActive` | the `StepMatchFrame` fork |
| `$ffdd` | `hLinkPayloadKind` | which pad snapshot the link sends |
| `$ffe9` | `hMatchFrameCounter` | frames simulated; stepped identically on the local and link paths |
| `$ff96` | `hWramBank` | the current character, effectively |

## Known gaps

Things this document deliberately does not claim:

- **The world scale of 105 units/metre is an inference**, from five geometry
  constants and gravity agreeing to three figures. No comment in the ROM states
  it. The fixed-point *layouts* are proven from the arithmetic; the metric
  interpretation is not.

- **Bit 6 of `wCharFlags`** is set and cleared by `StepCharMovement` and read
  nowhere in the ROM.
- **Placement-record bytes `+6`/`+7`** are zero in all fifteen tables and no
  reader was found.
- **The fourth byte of each court record** in `CourtSceneDataTable` is not
  read by `LoadCourtSceneData`, and no other reader of that table exists.
- **The incoming-pace term's sign.** `AddBallSpeedQuarter` and its siblings force
  the term negative, so absorbing a fast ball *reduces* the requested shot speed.
  The arithmetic is certain; whether that was the intent is not established.
- **Trajectory-row overflow.** `wShotTrajRowMin`/`Max` are bytes and the blocks
  hold 64 rows; it was not proven that a very shallow aim angle cannot drive
  `wShotDistMax >> 6` past 63.
- **`wCharInputSource` values 2 and 3** are in `CharInputPtrs` and never written
  by any code found — there appears to be no two-humans-one-console path for
  on-court play.
- **Link input ages.** The slave's decode path stages the local residue one frame
  deeper than the master's. The net input latency is probably equal on both
  sides, but proving the frame alignment needs a frame trace under
  `tools/linktest.py`, which has not been taken.
- Several routines are unreachable: `Unused_08_ComputeBallEtaToChar` and its
  only caller `UnusedComputeBallEtaToCharWrapper` (`$08:$70f1`), the lob check
  after `AiChoosePositionByStrategy`'s jump table (`$08:$7d37`, which no slot
  points at), the prologue of `AiNetPlayerPoachCheck`,
  `Unused_07_SetSpecialShotFlagThreshold` (`$07:$59ec`), and
  `Unused_07_ApplyCharStatPreset` (`$07:$5d1e`) after
  `OverrideCharStatsForDebug`.
- Apart from the umpire's-chair placement and the link handshake, both seen
  under emulation (`tools/linktest.py` for the link), everything here is
  static reading.
