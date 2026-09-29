# Unused code, and the patterns in it

797 labels carry an `Unused` prefix: 697 routines and 100 data blobs. "Unused" is a proof, not a guess:
nothing reachable from the game's entry points -- the reset vector, the
interrupt vectors and the `rst` vectors -- reaches the label, by call, jump,
branch, pointer table, macro body, fall-through or farcall. A `farptr` row
in a bank's slot table defines a slot and does not count: a routine only its
slot names, with no `farcall` of that slot anywhere, is unreachable.
`tools/reach.py` computes this, and `make check` (`reach`) fails if a
routine's name and its reachability disagree in either direction. The
naming passes that found them are in `docs/history.md`;
this file is what they have in common. Measured 2026-09-10 by fingerprinting
each unused routine's opcode sequence against every live routine
(the 97 raw `$dxxx` operands left in the source are all inside them). Where
an unused routine has a live twin, the exact difference is in the comment
above it in `src/`, so the relationship is visible where the routine is
read, not only here.

The proof is static. `tools/runtime_audit.py` adds a runtime check: in 3.5
million frames of play from a save (every story location, the Test map's
match launchers, menus, matches) none of the `Unused*` routines executed.

The coverage pass of 2026-09-28 turned the check around.
`tools/eventtest.py --coverage` ran every story location under 36 story
states plus 360 long sessions from the main menu's nine items, and
`tools/coverage.py` listed the routines no run entered. Of those, 158 also
had no reference anywhere in the source and could not be reached by falling
through from the code above them. 90 were renamed `Unused_<bank>_…`: ROM0
spares (`FarCallIndexed1`-`3`, `FarCopyIndexed`, `AngleFromVector`, …), the
save-repair block helpers, per-bank map-script helpers no bank calls,
menu-cursor variants, and 19 `ret`-only stubs. The other 68 are copies in
`src/twins` groups: the trajectory helpers in banks `$20`-`$2c`, and the
menu-cursor and decimal-number copies. Their 19 templates now take their
label from the bank (`twin_in <file>, <Label>, <bank>`), so each dead copy
is `Unused_<bank>_…` like any other, with "Nothing calls this copy." above
its line. No `Unused*` routine
ran in those 19 million events.

## Reachability (2026-09-29)

The earlier passes counted a routine as referenced if any line named it --
including its own slot-table row, and including callers that were
themselves unused. Following references from the entry points instead
named 330 more routines `Unused`. They hang from 86 dead roots: routines
only a slot row names (the minigame pause menu, the link match-type menu,
the dialogue-at-position and auto-size paged-menu helpers, the scene viewer,
the EXP editor hotkey), routines only `Unused` code calls (the helpers of
the debug save-data, minigame-flags and character-select screens, the
high-score confirm screen), and everything below them. The largest subtrees
are the debug save-data flow (22 routines), the minigame-flags debug screen
(20), the high-score confirm screen (20) and the minigame pause menu (11).
58 unreachable labels sit inside shared `src/twins` templates, which take
their name from the template, and keep it; the check exempts them.

One routine ran that the analysis cannot reach: `CallVectorEntryE`
(`$00:$0213`), a slot dispatcher whose only caller is
`Unused_00_FarCallVectorInline`. Nothing in the ROM calls or jumps to either
address, and no routine that only a slot names ran in the coverage sweep,
so it is recorded as unexplained rather than as a path.

The same sweep (15.7 million events: every story location under 36 story
states, 180 main-menu and 480 targeted sessions) left 428 reachable routines
never entered. Two groups were conditions a target can set up, and now does:
the save repair runs from power-on with a damaged save (`save-*` targets:
the header signature, with and without its bank-1 mirror, a story slot with
and without its backup, block `$36`, N64 records present), and the practice
drills and minigame rooms the drill list does not offer run through the same
launcher with the id the story would pass (`drillid*` targets, `$09`-`$23`).
With those, 366 remain, each below a routine that did run:

| never entered | below | why |
| --- | --- | --- |
| 113 | the main menu's flows | link play and the N64 Transfer Pak screens (ring shots, tournament data, trophies), and the link handshake and frame sync: a second Game Boy or an N64 |
| 64 | `GetStoryLocationRecordPtr` | story NPC, facing and tile handlers random walking did not trigger |
| 21 | the Special Court's init | its scene sequences |
| 15 | `CheckDebugStatsEditorHotkey` | the in-match stats editor, behind a debug hotkey |
| 13 | `DispatchRankingBoardAnim` | ranking-board animation states |
| 12 | `DispatchControlCode` | text control codes no string uses (`$10`-`$13` among them) |
| 11 | `FetchShortText` | per-bank copies of the short-text fetch |
| 8 | `ProcessMatchRewards` | reward paths for results the sessions did not reach |
| 6 | the interrupt vectors | `ApplyWhiteFade` (see bugs.md) and handlers the hooks do not see |

and a tail of small groups: tiebreaks, EXP-screen stat arrows, trajectory
table 4 of each shot type, ranking-board rows 9-10, drill briefings.

## The patterns

**1. Helper families with unused members.** The code reads as if each game
flag and each grid got a matching set of `Test` / `Set` / `Clear` helpers,
and the game only ever called some of them. `TestServeChallengerGameFlag`
is live; `Unused_15_SetServeChallengerGameFlag`, `_SetNet…` and
`_SetStroke…` are opcode-identical to it with the `set` in place of the
`bit`. `TestMachineLevelClearedFlag` is live, `Unused_14_SetMachineLevelClearedFlag`
is not. `TestAndSetGridEntryTaken` is live, `Unused_38_TestAndClearGridEntryTaken`
(95% the same opcodes) is not. The unused member is never the `Test`.

**2. The same helper compiled into several banks.** Seven unused routines
are opcode-identical to a live routine in another bank, and their names say
so: `Unused_0e_ComputeStoryRankTier`, `_0f_`, `_10_`, `_11_`, `_12_` and
`_14_` are all the 24-instruction `ComputeStoryRankTier_13`, one copy per
story bank; `UnusedEvalFlagCondition_0a` is
`EvalFlagCondition` from bank `$04`; `Unused_05_FetchSRAMShortText` is
`FetchSRAMDialogueText`. This is what a shared include assembled into every
story bank looks like: each bank got the whole set, and only the copy the
bank's own scripts call survived as live code. `DrawAsciiDigitChar_1b` is the
same idea where every copy *is* called.

**3. A ROM0 library with spare parts.** Bank `$00` carries 25 unused routines,
all small, all siblings of live ones: `Unused_00_ForceFadeOut` is
`ForceFadeIn` with the other direction constant, `Unused_00_EnableSerialInterrupt`
/ `_EnableVBlankInterrupt` / two `SetInterrupts…` variants are the interrupt
helpers the game never selects, `Unused_00_SwitchCPUSpeedSingle`,
`_FarDecompressData` (94% of `FarCopyBytes`), `_ReadFarVectorEntry`,
`_MulHLByDEBothSigned`, `_PrintDecimalByteSigned`, `_BeginWhiteFadeOut`.
The engine was written as a library and the game used the subset it needed.

**4. Debug tooling whose entry point is gone.** The largest unused routines
are complete developer screens: the save-slot editor
(`Unused_03_SaveSlotDebugEditor`, 209 instructions, with its cursor mover and
sixteen `Restore/Clear/InvalidateBlock…` helpers), the save-data debug flow
(`Unused_1b_RunDebugSaveDataFlow`, 180 instructions, with its menu, the
minigame-flags screen and the nav-grid loader), the character-select loop,
the window demo, the scene viewer, and `Unused_01_MenuRedraw`, which calls
`Unused_07_RunDebugTestMatch`. They are self-consistent and call live helpers; only
the menu that would launch them is unreachable (the retail build never sets
`hDebugStepMode`, see `docs/screens_and_ui.md`). The developer "Test" map
(`docs/story_mode.md`) is the part of this tooling that *is* reachable.

**5. Text-engine features nobody typed.** Bank `$05` has 23 unused routines,
the text engine's unused API: `Unused_05_RenderInlineHexByte` / `HexWord` /
`DecimalByte` (printf-style inline renderers, near twins of the live
`Print*`), `Unused_05_SetTextVar`, the streamed tilemap writers
(`WriteStringToTilemapStreamed`, `WriteDialogueToTilemapStreamed`) and the
whole-plane queue helpers. Same shape as pattern 3, one bank up.

**6. Templates and stubs.** `Unused_10_Test2Npc04`-`0A` are seven identical
NPC handlers on the "Test 2" debug map (its live NPCs `0B`-`0D` are the same
template); three lone `ret`s in bank `$11` sit after list terminators
(`Unused_11_NullScriptA`-`C`); `StubRet` pairs in `$17` and `$1b`; the
`PushPopNop` and `WramBank3Nop` routines that do nothing but preserve
registers — script slots that were filled and never wired.

**7. Cut or never-finished features.** `UnusedShowExpAwardForN64` is
opcode-identical to `ShowExpAwardForMinigame`: the EXP award screen has a
Transfer Pak branch the game never takes. `UnusedRunMessagesMusicMenu` and
`UnusedRunSaveQuitMenu` are pause-menu options with no row.
`Unused_10_RunWaterSpriteMinigame` (94% of the live target-zone test mode)
and `Unused_07_ApplyCharStatPreset` (168 instructions of stat presets
nothing loads) are the largest bodies with no live twin at all.
`UnusedDrawStandingShadowSlot16`, the ball-ETA wrapper and the timer
trampoline in bank `$08` are match-engine hooks left in place.

**8. Data that came along.** The 100 unused blobs are mostly two things:
bank `$0c`, an entire sound bank of 36 channel scripts that the sound-id
tables never index (`docs/sound_engine.md`), and the Japanese font and
window tiles in bank `$01` (`UnusedJpFontTiles_01`, 3,136 bytes, and
`UnusedJpWindowTiles_01`), left over from the original release.

## Where it sits

| bank | unused routines | bytes | what |
|---|---|---|---|
| `$05` | 23 | 1,375 | text engine spares |
| `$1b` | 20 | 1,220 | the debug save-data flow and its screens |
| `$10` | 15 | 1,235 | Test 2 NPC templates, story helpers |
| `$03` | 13 | 976 | the save editor and its block helpers |
| `$00` | 25 | 470 | ROM0 library spares |
| `$0b` | 13 | 312 | minigame hook spares |

Sizes: 26 routines are eight bytes or fewer, 79 are 9-32, 78 are 33-128, and
16 are larger. The long tail is stubs and one-off helpers; the bulk of the
bytes is the debug tooling.

## What this is good for

Nothing here needs proving further — a raw `$dxxx` operand inside an
`Unused_` routine is left raw on purpose, because no trace can reach it. The
patterns matter for reading: an unused routine next to a live one is
usually its sibling from the same family (pattern 1), its copy from another
bank (pattern 2), or its unused library neighbour (patterns 3 and 5), and
the twin's name is the best description of what the unused one does.

## Bodies with no label at all

Eight of the routines had no label to classify, which is how they escaped
the passes above: each sits straight after a table (a `dw` jump table, a
farcall slot list, a record array), where nothing falls through, and no
pointer anywhere in the ROM holds its address. They were found on
2026-09-27 by looking for instructions that follow data with no label in
between: `Unused_00_RenderNumberToTiles`, `Unused_08_DrawShotAimMarker`,
`Unused_0b_GetBallXAndDepth`, `Unused_10_Test2Npc03` (the first of the Test 2
map's drill-launcher NPC handlers), `Unused_38_GetGridEntryAtCursor`, and the
corner-bracket drawers of banks `$16` and `$17`
(`Unused_16_DrawWobblingCornerBrackets`, whose old label sat sixteen bytes
into the routine, `Unused_17_DrawWobblingCornerBrackets`,
`Unused_17_DrawCornerBrackets`). What else that search finds is a lone dead
`ret` after a jump table, or a dead case inside a live routine's own scope.

