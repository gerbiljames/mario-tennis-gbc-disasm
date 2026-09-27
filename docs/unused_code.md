# Unused code, and the patterns in it

309 labels carry an `Unused` prefix: 209 routines and 100 data blobs. "Unused" is a proof, not a guess —
nothing in the ROM references the label by call, jump, pointer table or
farcall slot, and where a slot table does reference it, no `farcall` ever
names that slot. The naming passes that found them are in `docs/history.md`;
this file is what they have in common. Measured 2026-09-10 by fingerprinting
each unused routine's opcode sequence against every live routine
(the 97 raw `$dxxx` operands left in the source are all inside them). Where
an unused routine has a live twin, the exact difference is in the comment
above it in `src/`, so the relationship is visible where the routine is
read, not only here.

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
`RunDebugTestMatch`. They are self-consistent and call live helpers; only
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

