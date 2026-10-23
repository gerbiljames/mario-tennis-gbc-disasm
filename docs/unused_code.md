# Unused code, and the patterns in it

An `Unused` prefix marks a routine or data blob nothing live reaches.
"Unused" is a proof, not a guess: nothing reachable from the game's entry
points -- the reset, interrupt and `rst` vectors -- reaches the label, by
call, jump, branch, pointer table, macro body, fall-through or farcall. A
`farptr` row in a bank's slot table defines a slot and does not count: a
routine only its slot names, with no `farcall` of that slot anywhere, is
unreachable. `tools/reach.py` computes this, and `make check` (`reach`)
fails if a routine's name and its reachability disagree in either
direction, or if a local label under an `Unused` routine is reachable (a
live tail gets a global name of its own). Where an unused routine has a live twin, the comment above it in
`src/` gives the exact difference.

A dead copy inside a shared `src/twins` file is named per bank
(`twin_in <file>, <Label>, <bank>`), so it is `Unused_<bank>_…` like any
other; the check exempts nothing.

Data is held to its name alone: a data label that no other label names --
by name, `Label + n`, a split-base `LOW`/`HIGH` pair or a slot row, from
live or dead code -- is `Unused_<bank>_<Name>`, and `make check`
(`unnamed`) fails on one that is not. Before naming one, search the ROM for
its address as a raw word too. The exceptions are listed with how each is
found (`UNNAMED_OK` in `tools/reach.py`): `DataPtr_` slot rows, read by
slot number; `Padding_` fill; the `SoundTable_` at `$4000` of each sound
bank; the header's `NintendoLogo`. Routines are left to `reach`, which
already exempts the vectors and a twin template's fall-through entries. A
data label only dead code names (`FontTiles`, read by a routine after a
`ret`) keeps its name.

## Dead roots

Many `Unused` routines have no reference at all: ROM0 spares
(`Unused_00_FarQueueVRAMCopyIndexed`, `_FarVRAMDMAIndexed`, `_FarCopyMemoryFastIndexed`, `Unused_00_FarCopyIndexed`,
`Unused_00_SqrtHL`, …), the save-repair block helpers, per-bank
map-script helpers no bank calls, menu-cursor variants, `ret`-only stubs,
and dead copies in `src/twins` groups (the trajectory helpers in banks
`$20`-`$2c`, the menu-cursor and decimal-number copies).

The rest are referenced, but only from dead code. They hang from dead
roots: routines only a slot row
names (the minigame pause menu, the link match-type menu, the
dialogue-at-position and auto-size paged-menu helpers, the scene viewer, the
EXP editor hotkey), routines only `Unused` code calls (the helpers of the
debug save-data, minigame-flags and character-select screens, the
high-score confirm screen), and everything below them. The largest subtrees
are the debug save-data flow, the minigame-flags debug screen, the
high-score confirm screen and the minigame pause menu.

Code after an unconditional `ret` or `jp` with no label on it runs for no
one. `CheckDebugStatsEditorHotkey` begins with `ret`, so everything after it
-- the in-match debug stats editor, down to the ROM0 helpers only
the editor calls (`Unused_00_CopyTextString`, `_DrawHexWord`,
`_MoveCursorVertical`) -- is `Unused`.

**Dead by data.** `tools/reach.py` also drops an edge when the variable that
decides it can never pass its test. For each call or jump whose way there is
decided by one variable -- loaded with `ld a, [V]` and tested by `cp`, `and`,
`or`, `add a` or `bit` on the path, including a branch that would skip it --
it collects the values code outside `Unused` routines stores into V
(`ld a, K`, `xor a`, a zero proved by a `jr nz` past the store, and zero for
the boot clear). If none passes the test, V is a candidate. A static scan
cannot see a record copied in through a computed pointer, so every candidate
is reviewed in `DATA_FLAGS` as **dead** (the edge is dropped, and what only
it reached must be named `Unused`) or **live**, with how it is written;
`make check` fails on an unreviewed one. The four dead ones:

* `hFadeState` bit 7, which only an unreferenced routine sets, so
  `Unused_00_ApplyPackedFade` never runs (`docs/bugs.md`);
* `wSecondaryTimerMode`: `UpdateGameTimer` runs
  `Unused_00_TickSecondaryTimer` when it is 1, and the only store to it is
  `Unused_00_TickSecondaryTimerCountdown` writing `$ff`;
* `hLinkErrorFlags`, whose stores are all clears (`AdvanceFrame`'s
  link-error reset);
* `wGlyphBufferHoldCount` (`PrepareGlyphBuffer`'s keep branch; `docs/bugs.md`).

The four live ones are story-record fields, a location header field and the
match id word, all written through pointers.

## Checked at run time

No `Unused` routine runs in play (one sweep artifact below) in the
`tools/eventtest.py --coverage` sweeps (every story location under every story
state, main-menu and targeted sessions, link play, damaged-save, drill-id and handler targets). The
reverse holds too: every reachable routine has been entered, by play or, for
those nothing played into, by `tools/steer.py` forcing the branches on a
call chain down from a routine some session entered (`docs/STATUS.md` lists
the runtime tools). Of those, `SeniorCourtReloadIntoVictoryScene` runs
by entering the Senior Court by entry point `$0e`, which no `map_entry` row
lists (the game sets it returning from a match), and two are the dead-by-data
routines above.

Two runtime observations the static view does not explain away:

* The sweep records `Unused_00_CopyTextString` as run, once per story state.
  Entering the Wall Practice room by its back-from-a-match entry with no
  match played leaves a stale win flag at level 1, where
  `WallPracticeLevelResultScript` indexes its four-entry jump table with the
  stage minus one, reads a pointer from past its end and lands inside
  `Unused_00_DrawHexWord`. In play a win always sets the level's flag first,
  so the stage there is 1 to 4.
* `CallVectorEntryE` (`$00:$0213`) ran, though its only caller is
  `Unused_00_FarCallVectorInline`: nothing in the ROM calls or jumps to
  either address, and no routine only a slot names ran in the sweep. It is
  recorded as unexplained.

## The patterns

**1. Helper families with unused members.** The code reads as if each game
flag and each grid got a matching set of `Test` / `Set` / `Clear` helpers,
and the game only ever called some of them. `TestServeChallengerGameFlag`
is live; `Unused_15_SetServeChallengerGameFlag`, `_SetNet…` and
`_SetStroke…` are opcode-identical to it with the `set` in place of the
`bit`. `TestMachineLevelClearedFlag` is live, `Unused_14_SetMachineLevelClearedFlag`
is not. `TestAndSetGridEntryTaken` is live, `Unused_38_TestAndClearGridEntryTaken`
(95% the same opcodes) is not. The unused member is never the `Test`.

**2. The same helper compiled into several banks.** Eight unused routines
are opcode-identical to a live routine in another bank, and their names say
so: `Unused_0e_ComputeStoryRankTier`, `_0f_`, `_10_`, `_11_`, `_12_` and
`_14_` are all the 24-instruction `ComputeStoryRankTier_13`, one copy per
story bank; `Unused_0a_EvalFlagCondition` is
`EvalFlagCondition` from bank `$04`; `Unused_05_FetchSRAMShortText` is
`FetchSRAMDialogueText`. This is what a shared include assembled into every
story bank looks like: each bank got the whole set, and only the copy the
bank's own scripts call survived as live code. `Unused_16_DrawAsciiDigitChar`
and its copies in banks `$17`, `$1b`, `$3b` and `$3e` are the same include
with no live copy at all.

**3. A ROM0 library with spare parts.** Bank `$00` carries 60 unused routines,
mostly small, all siblings of live ones: `Unused_00_ForceFadeOut` is
`ForceFadeIn` with the other direction constant, `Unused_00_EnableSerialInterrupt`
/ `_EnableVBlankInterrupt` / two `SetInterrupts…` variants are the interrupt
helpers the game never selects, `Unused_00_SwitchCPUSpeedSingle`,
`_FarDecompressData` (94% of `FarCopyBytes`), `_ReadFarVectorEntry`,
`_MulHLByDEBothSigned`, `_PrintDecimalByteSigned`, `_BeginPackedFadeOut`.
The engine was written as a library and the game used the subset it needed.

**4. Debug tooling whose entry point is gone.** The largest unused routines
are complete developer screens: the save-slot editor
(`Unused_03_SaveSlotDebugEditor`, 209 instructions, with its cursor mover and
sixteen `Restore/Clear/InvalidateBlock…` helpers), the save-data debug flow
(`Unused_1b_RunDebugSaveDataFlow`, 180 instructions, with its menu, the
minigame-flags screen and the nav-grid loader), the character-select loop,
the window demo, the scene viewer, and `Unused_01_DebugBootMenu`, which calls
`Unused_07_RunDebugTestMatch`. They are self-consistent and call live helpers; only
the menu that would launch them is unreachable (the retail build never sets
`hDebugStepMode`, see `docs/screens_and_ui.md`). The developer "Test" map
(`docs/story_mode.md`) is the part of this tooling that *is* reachable.

**5. Text-engine features nobody typed.** Bank `$05` has many unused routines,
the text engine's unused API: `Unused_05_RenderInlineHexByte` / `HexWord` /
`DecimalByte` (printf-style inline renderers, near twins of the live
`Print*`), `Unused_05_SetTextVar`, the streamed tilemap writers
(`Unused_05_WriteStringToTilemapStreamed`,
`Unused_05_WriteDialogueToTilemapStreamed`) and the
whole-plane queue helpers. Same shape as pattern 3, one bank up.

**6. Templates and stubs.** `Unused_10_Test2Npc04ServiceMatch3`-`Npc0ANetGameMatch3` are seven
drill-launcher handlers for the "Test 2" debug map, the template of its live
NPCs `0B`-`12` with their own test number and minigame id; three lone `ret`s in bank `$11` sit after list terminators
(`Unused_11_NullScriptA`-`C`) and three more after the last row of a table
(`Unused_16_StubRet`, `Unused_1b_StubRet3`, `Unused_38_StubRet`); `Unused_17_StubRet`, `Unused_18_StubRet3`
and the `Unused_1b_StubRet1`/`2` pair; `Unused_39_PushPopNop_1`/`_2` and
`Unused_38_WramBank3Nop`, routines that do nothing but preserve registers — script slots that were filled and never wired.

**7. Cut or never-finished features.** `Unused_1e_ShowExpAwardForN64` is
opcode-identical to `ShowExpAwardForMinigame`: the EXP award screen has a
Transfer Pak branch the game never takes. `Unused_06_RunMessagesMusicMenu` and
`Unused_06_RunSaveQuitMenu` are pause-menu options with no row.
`Unused_10_RunWaterSpriteMinigame` (94% of the live target-zone test mode)
and `Unused_07_ApplyCharStatPreset` (168 instructions of stat presets
nothing loads) are the largest bodies with no live twin at all.
`Unused_10_SwingContestPrototype` is an early cut of bank `$15`'s swing
contest (count task, then the GO sound), its counters two bytes lower.
`Unused_08_DrawSlotSprite16`, the ball-ETA wrapper and the timer
trampoline in bank `$08` are match-engine hooks left in place.

**8. Data that came along.** By bytes the unused blobs are mostly
bank `$0c`, an entire sound bank of 36 channel scripts that the sound-id
tables never index (`docs/sound_engine.md`), the Japanese font and
window tiles in bank `$01` (`Unused_01_JpFontTiles`, 3,136 bytes, and
`Unused_01_JpWindowTiles`), left over from the original release, and the
seven spare frames at the end of each of the 30 character sprite banks
(`Unused_50_MarioSpriteFramesCopy`, copies of frames 00-06). The racket
students' practice scripts, live in banks `$11`, `$12` and `$27`, sit dead
in the other story banks that carry them
(`Unused_0f_ActorScriptStudentSwings` and its copies in `$0e`, `$10`,
`$13`-`$15`).

## Where it sits

Most of it sits in a few banks:

| bank | what |
|---|---|
| `$1b` | the debug save-data flow and its screens |
| `$1a` | minigame pause menu, EXP screen and editor, character viewer |
| `$00` | ROM0 library spares |
| `$05` | text engine spares |
| `$18` | confirm and two-option screens, box and number drawers |
| `$10` | Test 2 NPC templates, story helpers |
| `$03` and `$38` | the save editor and its block helpers; link and character-select spares |

The long tail is stubs and one-off helpers; the bulk of the bytes is the
debug tooling.

## What this is good for

A raw `$dxxx` operand inside an `Unused_` routine is left raw on purpose,
because no trace can reach it. The patterns matter for reading: an unused routine next to a live one is
usually its sibling from the same family (pattern 1), its copy from another
bank (pattern 2), or its unused library neighbour (patterns 3 and 5), and
the twin's name is the best description of what the unused one does.

## Bodies with no label at all

Eight routines had no label to classify: each sits straight after a table
(a `dw` jump table, a farcall slot list, a record array), where nothing
falls through, and no pointer anywhere in the ROM holds its address:
`Unused_00_RenderNumberToTiles`, `Unused_08_DrawShotAimMarker`,
`Unused_0b_GetBallXAndDepth`, `Unused_10_Test2Npc03ServiceMatch2` (the first of the Test 2
map's drill-launcher NPC handlers), `Unused_38_GetGridEntryAtCursor`, and the
corner-bracket drawers of banks `$16` and `$17`
(`Unused_16_DrawWobblingCornerBrackets`, whose old label sat sixteen bytes
into the routine, `Unused_17_DrawWobblingCornerBrackets`,
`Unused_17_DrawCornerBrackets`). Otherwise, instructions after data with no
label between are a lone dead `ret` after a jump table, or a dead case inside
a live routine's own scope.

Two more sat inside palette blobs in bank `$3e`, straight after the last
palette of each court-select screen: `Unused_3e_DrawCourtSelect4StatsText`
and `Unused_3e_DrawCourtSelect9StatsText`, an older way of putting the
cursor's court name into the title row, sharing three helpers and four small
tables after the first one. `Unused_08_AdvanceCharStatePhase`, a copy of
`AdvanceCharStatePhase` after `CharPointEndState`'s jump table, had been read
as two more table entries.
Three were carved as raw `db`: `Unused_02_GetCharArchetypeField`,
`Unused_0a_FarcallUpdateEpilogueEndAnimation`, and
`Unused_12_PushPartnerGenderShortTextArg`, a `ld a, [wStoryPartnerGender]`
falling into `PushShortTextArg_12`.
