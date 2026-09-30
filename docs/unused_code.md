# Unused code, and the patterns in it

873 labels carry an `Unused` prefix: 773 routines and 100 data blobs. "Unused" is a proof, not a guess:
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
58 more were copies inside shared `src/twins` templates, which used to take
their name from the template: each bank now declares the name of its copy,
so a dead one is `Unused_<bank>_…` too, and the check exempts nothing.

Code after an unconditional `ret` or `jp` with no label on it runs for no
one. `CheckDebugStatsEditorHotkey` begins with `ret`, and everything after
it -- the in-match debug stats editor, 16 routines down to the ROM0 helpers
only the editor calls (`Unused_00_CopyTextString`, `_DrawHexWord`,
`_MoveCursorVertical`) -- is `Unused` for it. The coverage sweep did record
`Unused_00_CopyTextString` as run, once per story state: entering the Wall
Practice room by its back-from-a-match entry with no match played leaves a
stale win flag at level 1, where `WallPracticeLevelResultScript` indexes its
four-entry jump table with the stage minus one, reads a pointer from past
its end, and lands inside `Unused_00_DrawHexWord`. In play a win always sets
the level's flag first, so the stage there is 1 to 4.

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
With those, 366 remained. More targets then reached most of the biggest
groups: `tools/linktest.py` joins two games over an emulated link cable and
plays link matches (97 routines entered); `eventtest --handlers` calls every
story NPC, facing and tile-trigger handler in its own location, including
the NpcScripts tables scripts install at run time, and enters a location
whose init script stays only for one entry point (Test2's `$0f`) by that
one; and the menu targets forge N64 Transfer Pak records into save block
`$0b` to open the three record screens, and enter the two button codes that
unlock everything (`docs/save_format.md`). That left 173.

More play then reached 15 of those. Link play with every button equally
likely hit the rules rows and the cursor and cancel commands. A save with
the courts locked (`build/locked.sav` is the maxed save with its global flag
array cleared) opens the four-court select menu, which only appears when
neither player has a court unlocked. And `linktest --unplug-after N` pulls
the cable during a session, which reaches the link error screen as a player
would. That left 158 routines no play reached.

`tools/steer.py` ran all but three of them by steering rather than playing.
For each routine, the call graph gives a chain down from a routine some
session entered. The chain is taken at segment level, so a jump-table entry
that lands on an interior label (the lesson-result dispatch jumps into the
middle of a dozen scene routines) is a step of its own. The session is then
replayed (`eventtest.py --units` records which session entered what) with
hooks that force each conditional branch, `rst Rst00` index and table jump
on the chain, and nothing else:

* a branch goes whichever way reaches the next routine sooner, so a loop
  exits instead of going round again;
* a story script's chain starts at the location's own script, replayed as
  that location's story chunk or a handler target that warps there;
* a mode hook is steered at `CallModeHook`, which reads the hook table from
  RAM, while each minigame (`minigame0`-`8` targets) or drill runs;
* link routines are steered in `tools/linktest.py --steer`, since only a
  session with a partner gets near them.

So each routine ran with the game's own registers and RAM, with one decision
at a time overridden. That shows it can run, not that play gets there. None
of the steered runs entered an `Unused` routine.

`SeniorCourtReloadIntoVictoryScene` needed neither: the Senior Court's init
script jumps there for entry point `$0e`, which no `map_entry` row lists
(the game sets it returning from a match), and entering the court by `$0e`
runs it in any story state. Its replays had looked stuck because of a PyBoy
bug in the harness, since fixed (STATUS, 2026-09-30).

Two more were unreachable by data rather than by code, which a call graph
alone cannot see. Both wait on flags nothing sets:

* `Unused_00_ApplyWhiteFade` needs bit 7 of `hFadeState`, which only an
  unreferenced routine sets (bugs.md).
* `Unused_00_TickSecondaryTimer` runs from `UpdateGameTimer` when
  `wSecondaryTimerMode` is 1. The only store to that variable is
  `Unused_00_TickSecondaryTimerCountdown` writing `$ff`.

`tools/reach.py` now finds these itself. For each call or jump whose way
there is decided by one variable -- loaded with `ld a, [V]` and tested by
`cp`, `and`, `or`, `add a` or `bit` on the path, including a branch that
would skip it -- it collects the values code outside `Unused` routines
stores into V (`ld a, K`, `xor a`, a zero proved by a `jr nz` past the
store, and zero for the boot clear). If none passes the test, the variable
is a candidate. A static scan cannot see a record copied in through a
computed pointer, so every candidate is reviewed in `DATA_FLAGS`:
* **dead:** the edge is dropped, and what only it reached must be named
  `Unused`, like any other unreachable routine;
* **live**, with how it is written.

`make check` fails on a candidate nobody has reviewed. The four dead ones:
* the two flags above;
* `hLinkErrorFlags`, whose stores are all clears (`AdvanceFrame`'s
  link-error reset);
* `wGlyphBufferHoldCount` (`PrepareGlyphBuffer`'s keep branch; both in
  bugs.md).

The four live ones are story-record fields, a location header field and the
match id word, all written through pointers.

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

