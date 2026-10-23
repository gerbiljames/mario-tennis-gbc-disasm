SECTION "WRAMX bank 6", WRAMX[$d000], BANK[6]

; WRAMX bank 6 at a glance:
;
;   $d000-$d029  9 overlays: scrolling story cutscene slide flag / scene animation frame counter / star warp transition / +6 more
;   $d000-$d3ff  wCollisionMap
;   $d02a-$d219  10 overlays: results continue prompt rows / star warp transition / trophy EXP awards / +7 more
;   $d230-$d259  scrolling text screen / EXP award screen
;   $d400-$d5ff  story slot signatures / unlock flags block
;   $d400-$d7ff  wBehaviorMap
;   $d800-$dbff  story scene load
;   $dc08-$dc8f  story scene load
;   $df00-$df96  match character struct  [one copy per bank 4-7]

; Character-data (level-up) screen working set, shared by the bank
; $1a/$1c/$1d screen code. The first bytes are also scratch for other
; screens: the debug character viewer, the results continue prompt, the
; story cutscenes and the star warp.
UNION
; scrolling story cutscene slide flag (bank $03)
; [8-bit] Set to 1 by AnimateWindowSlideUpTask when the text window finishes sliding; ShowEndingCreditsStaffPage clears it, registers the task and waits for it
wCutsceneSlideDone:: db
	ds 41
NEXTU
; scene animation frame counter (bank $03)
; [8-bit] Frame of the epilogue's animated "END..." text: zeroed by SetupEpilogueEndAnimation, stepped by UpdateEpilogueEndAnimation every fourth tick of wCutsceneSlideTimer up to $36, read by the six AnimateEpilogueEnd* loaders
wEpilogueEndAnimFrame:: db
NEXTU
; star warp transition (bank $0e)
; [8-bit] Animation frame of the warp star, 0-5, stepped every other VBlank by UpdateStarWarpSprite
wStarWarpFrame:: db
; [8-bit] Distance the star has travelled along its path, +2 per frame; OffsetStarWarpPathPoint indexes StarWarpPathX/StarWarpPathY with it for wStarWarpPathX/Y
wStarWarpPathIndex:: db
; [8-bit] Frames left in the transition, seeded to $5a; the fade out starts at $1e and the wait loop returns at zero
wStarWarpCountdown:: db
; [16 bytes] One life counter per trail sparkle. UpdateStarWarpTrailSparkles sets the first zero one to $10 and seeds that slot's wStarWarpSparklePos from wStarWarpPathX/Y
wStarWarpSparkleLife:: ds 16
	ds 1
; [32 bytes] Y, X of each trail sparkle, indexed by slot*2 in UpdateStarWarpTrailSparkles; runs on past this union to $d033
wStarWarpSparklePos:: ds 22
NEXTU
; debug character viewer (bank $1a, $6800-$7000)
; [8-bit] Debug character viewer row under the cursor, toggled with `xor $01`: 0 = character grid, 1 = palette row
wCharViewerRow:: db
; [8-bit] Cursor index within the current row; up/down step it by $0b, the grid width
wCharViewerCursor:: db
; [8-bit] Character the viewer shows, chosen by Unused_1a_RunCharViewerSelectGrid; GetCharPaletteIndex turns it into wCharViewerPalette
wCharViewerCharId:: db
; [8-bit] Grid cursor saved while the palette row has focus
wCharViewerSavedCursor:: db
; [8-bit] Palette index the debug character viewer is showing, from GetCharPaletteIndex
wCharViewerPalette:: db
; [8-bit] Animation/pose index the debug character viewer is showing, stepped by Unused_1a_RunCharViewerInputLoop
wCharViewerPose:: db
NEXTU
; results continue prompt (bank $1e)
; [8-bit] Nonzero shows the partner on the results screen even without FLAG_TEMP_RESULTS_DOUBLES_LAYOUT; stored from c by InitContinueGameScreenState, set by the award screen
wResultsAlwaysShowPartner:: db
; [8-bit] Cursor row, toggled 0/1 by up and down; picks which of the two cursor sprites DrawContinuePromptCursor queues
wContinuePromptRow:: db
; [8-bit] Which page of the prompt text is showing (RefreshContinuePromptText)
wContinuePromptPage:: db
; [8-bit] What the prompt returned: 1 confirm, $ff cancel, or wContinuePromptPage - 1
wContinuePromptResult:: db
NEXTU
; character-data screen (banks $1a/$1c/$1d)
; [8-bit] Free-running counter CharDataScreenAnimTask steps each idle frame; low nibble indexes the animation table
wCharDataAnimCounter:: db
; [8-bit] Cleared with wCharDataAnimCounter when the screen opens; nothing reads it
wCharDataAnimSubStep:: db
; [8-bit] Which third of the screen still needs pushing to VRAM; FlushCharDataTilemapChunk sends one chunk per call (0, 1, 2). The animation task waits while it is nonzero
wCharDataFlushChunk:: db
; [8-bit] Level-up points the visit started with: CharDataScreen_InitState counts the pending level-ups into it, RevertCharDataToStart copies it to wCharDataPointsLeft. Heads the six bytes BackupCharData saves and RestoreCharData restores (this, wCharDataStartLevel, the four wCharDataStartLevels): everything a cancelled visit forgets
wCharDataPointsTotal:: db
; [8-bit] The record's level before the pending level-ups, snapshotted by CharDataScreen_InitState; RevertCharDataToStart writes it back to record +$18
wCharDataStartLevel:: db
; [4 bytes] Spin/Power/Control/Speed levels before the pending level-ups, snapshotted by CharDataScreen_InitState; RevertCharDataToStart writes them back into record +$38-$3b
wCharDataStartLevels:: ds 4
; [8-bit] Unspent level-up points, copied in from $d003 and decremented by CharDataScreen_InputLoop after each LevelUpPlayer
wCharDataPointsLeft:: db
; [4 bytes] Spin/Power/Control/Speed levels as loaded from record +$38-$3b (LoadCharStats / LoadCharStatsWithLevelUpDeltas)
wCharDataLevels:: ds 4
; [11 bytes] The eleven displayed stats, record +$20-$2a plus 1 each (order as wStoryMainStats)
wCharDataStats:: ds 11
; [11 bytes] Per-stat change the pending level-up would apply, from ComputeLevelUpStatDeltas (cleared when wCharDataPage is $04); DrawStatArrowIndicators draws an up/down arrow per stat
wCharDataStatDeltas:: ds 11
; [8-bit] Level-up choice under the cursor (0-3), or $04 for the confirm cell; CharDataScreen_DrawPageColumns and DrawStatValueSprites key off it
wCharDataPage:: db
; [8-bit] Confirm-prompt cursor: 0 = confirm, 1 = cancel (Up/Down toggle it, B forces 1); returned as the prompt's result and drawn by DrawConfirmSelectionCursor_*
wCharDataConfirmCursor:: db
; [8-bit] Stat-digit fly-in step: GetStatDigitSpritePos indexes the StatDigitFlyInOffsetPtrs ramps with it. CharDataScreen_InitState seeds $0a and AnimateCharDataStatsReveal stores $09, $07, $05, $03, $02, $01, $00 as the reveal advances; nothing decrements it
wCharDataDigitFlyInStep:: db
; [8-bit] AnimateCharDataStatsReveal step; CharDataScreen_InitState seeds it with $03
wCharDataRevealStep:: db
; [8-bit] Nonzero hides the level preview; 0 while the allocation page is live: DrawStatValueSprites then draws the level one higher, in palette $0f, as a preview. CharDataScreen_InitState sets $03 on re-entry, CharDataScreen_Show clears it
wCharDataHideLevelPreview:: db
; [8-bit] Entries written to wCharDataChoiceLog so far (also the write index)
wCharDataChoiceCount:: db
NEXTU
; EXP award screen (bank $1e)
	ds 4
; [8-bit] First byte of the EXP award screen's working set: InitExpAwardScreenState clears $d004-$d027 from here (covering wExpAwardRunningTotal, wExpAwardAmount, wExpAwardIndex, wUnusedExpAwardByte) and seeds $d009-$d00c / $d019-$d01c to $20 and $d00d/$d01d to $30. The byte itself is never read
wExpAwardScreenState:: db
; [16-bit] EXP total counting up on screen: CountUpExpTotal adds one point (and a sound) per pass while decrementing the amount left; DrawExpTotalDigits redraws it
wExpAwardRunningTotal:: dw
; [16-bit] The award being counted in, set as each message is shown
wExpAwardAmount:: dw
	ds 27
; [8-bit] Award message being shown; BeginNextExpAward steps it, DrawNextExpAwardMessage returns zero past the end
wExpAwardIndex:: db
	ds 1
; [8-bit] Cleared as each award begins; nothing reads it
wUnusedExpAwardByte:: db
NEXTU
; cutscene text window (bank $03)
	ds 1
; [8-bit] First byte of the current CreditsStaffPageDescriptors_03 entry: rows the page scrolls by. ScrollCreditsStaffWindow masks it to two bits and treats zero as one
wCreditsStaffScrollRows:: db
NEXTU
; trophy EXP awards (bank $1e)
	ds 40
; [16-bit] EXP for trophy group 0, head of the six-word run ComputeTrophyExpAwards fills; groups 1-5 are wTrophyExpByGroup in the next union
wTrophyExpGroup0:: dw
ENDU

; WRAM bank $06 from $d02a up, shared by subsystems that never run at once.
; The working palette buffer and the character-data screen's stat arrays
; start at the same address. The same offsets in WRAM bank $07 are the
; sound driver's channel state.
UNION
; star warp transition (bank $0e)
	ds 22
; [8-bit] Y of the point the star has reached, copied into each sparkle as it spawns
wStarWarpPathY:: db
; [8-bit] X of the same point
wStarWarpPathX:: db
NEXTU
; trophy EXP awards (bank $1e)
; [10 bytes] EXP for trophy groups 1-5, five words, filled by ComputeTrophyExpAwards one group at a time with a running sum in hl. Group 0's word (wTrophyExpGroup0) sits two bytes lower
wTrophyExpByGroup:: ds 10
; [16-bit] ComputeTrophyExpForGroup's accumulator while it walks one group's trophies, testing and setting each award flag
wTrophyExpGroupAccum:: dw
; [16-bit] The sum of all six groups, which ApplyPendingExpAwards adds to the match award
wTrophyExpTotal:: dw
; [8-bit] Trophy group being totalled (0-2: the low 2-bit trophy field of each wN64TrophyCounts nibble at grade 1/2/3, 3-5: the high field); indexes TrophyExpGroupThresholds, TrophyExpGroupMasks and TrophyExpTierFlags, and selects GetTrophyExpValue's row
wTrophyExpGroup:: db
NEXTU
; character-data screen (bank $1a)
; [100 bytes] One byte per level-up taken this visit: the confirmed wCharDataPage. Cleared by RevertCharDataToStart, which the screen also runs as it opens
wCharDataChoiceLog:: ds 100
; [6 bytes] Number formatting scratch for the character-data and EXP screens: FormatExp24BitDecimal puts the top byte at +$00 and the low word's five digits from +$01
wCharDataNumberBuffer:: ds 6
	export_size wCharDataNumberBuffer
	ds 11
; [8-bit] Cleared by CharDataScreen_InitState with the rest of the screen state; nothing reads it
wCharDataRevealDone:: db
; [11 bytes] The eleven stats recomputed with racket and shoes unequipped, to show what the equipment is worth. Filled by ComputeCharDataEquipmentDeltas from wStoryMainStats after RecomputeStatsWithoutEquipment; untouched when nothing is equipped
wCharDataStatsNoEquipment:: ds 11
; [11 bytes] Per-stat difference the equipped racket and shoes make, zeroed first so an unequipped character shows no arrows; read by DrawStatChangeArrows with wCharDataStatsNoEquipment
wCharDataEquipmentDeltas:: ds 11
; [8-bit] Nonzero opens the character-data screen read-only: CharDataScreen_Show skips the allocation flow, LoadCharStatsWithLevelUpDeltas computes no deltas, the input loop spends no points. Set by RunExpDistributionFlow and RestoreCharData
wCharDataViewOnly:: db
; [6 bytes] Copy of wCharDataPointsTotal onward taken as the screen opens; RestoreCharData copies it back and sets wCharDataViewOnly when a level-up is cancelled
wCharDataEditBackup:: ds 6
	export_size wCharDataEditBackup
; [101 bytes] Matching backup of wCharDataChoiceCount and the choice log, so a cancelled visit forgets every provisional level-up
wCharDataChoiceBackup:: ds 101
	export_size wCharDataChoiceBackup
NEXTU
; character-data and EXP screens (banks $1a/$1c/$1d)
	ds 283
; [16-bit] X offset of the stat digits while a page slides; stepped by the Slide*StatPage routines, applied by DrawCharStatDigitsTask through ApplySlideOffsetToSpriteX
wCharDataStatsSlideX:: dw
; [16-bit] The same offset for the value column, applied by DrawCharDataSummarySpritesTask (the two columns slide at different times)
wCharDataValuesSlideX:: dw
	ds 24
; [2 x EXPSTAT_SIZE] Per-character record the EXP award screen works on, selected by wStoryCharacterSlot
wExpScreenCharStats:: ds 30
NEXTU
; palette fade engine (bank $03)
	ds 118
; [128 bytes] The fade's endpoint: 16 palettes of four 16-bit colours. CopyMasterPalettesToFadeBuffers seeds it from wMasterPalettes and the caller rewrites it (Unused_03_ClearFadeTargetPalettes: black; SepiaToneFadeTargetPalettes: sepia via SplitColorComponents). Read by StepPaletteColorsTowardTarget, copied over wPaletteFadeLive by SnapPalettesToTarget; AdvanceToPaletteEntry walks it 8 bytes at a time
wPaletteFadeTarget:: ds 128
	ds 32
; [128 bytes] The palettes the fade shows: seeded from wMasterPalettes, stepped +/-1 per component toward wPaletteFadeTarget on each AnimatePaletteFadeToTarget pass for masked palettes, uploaded by LoadPalettesImmediate
wPaletteFadeLive:: ds 128
	ds 32
; [16 bytes] One byte per palette; only flagged palettes are stepped. InitSepiaPaletteFade clears all 16, SetupPaletteFadeMask sets the first eight from the bits of b (bit 7 = palette 0)
wPaletteFadeMask:: ds 16
; [8-bit] Passes remaining (from d); AnimatePaletteFadeToTarget decrements it per pass and snaps at zero
wPaletteFadeAmount:: db
; [8-bit] Palette being stepped, kept across the AdvanceToPaletteEntry calls for both buffers
wPaletteFadeIndex:: db
; [6 bytes] The two colours being interpolated, split into R, G, B by SplitColorComponents: working colour at +$00, target at +$03
wPaletteColorSplit:: ds 6
	ds 1
; [8-bit] wPaletteFadeAmount / $1f: frames AnimatePaletteFadeToTarget waits before each pass (the step is always +/-1 per component, StepColorComponentTowardTarget)
wPaletteFadeFrameDelay:: db
	ds 4
; [8-bit] Ending-credits staff page shown (the a passed to ShowEndingCreditsStaffPage, wStoryCharacterSlot); AnimateWindowSlideUpTask indexes WindowSlideStepTable_03 with it
wCreditsStaffPageIndex:: db
NEXTU
; character-data page arrows (banks $1a/$1c/$1d)
	ds 280
; [8-bit] Stat page shown: 0 overview, 1 main character, 2 partner; picks the page arrows DrawCharDataPageArrowsTask draws, and DrawStatChangeArrows runs only on 1
wCharDataStatPageView:: db
; [8-bit] How far the page arrows have slid out: SlideCharDataArrowsOutTask adds 4 a frame up to $40, SlideCharDataArrowsInTask takes 8 back to 0, and BobArrowSpriteLeft/Right add it to the arrows' X (negated on the left). The bob phase only advances while it is zero
wCharDataArrowSlideX:: db
; [8-bit] Free-running counter the arrow bob reads for its offset
wCharDataArrowPhase:: db
NEXTU
; EXP distribution screen (bank $1d)
	ds 248
; [13 bytes] The main character's stat page as drawn: +$00 the four Spin/Power/Control/Speed levels from wCharDataLevels, +$04 six values copied to wCharStatPageShown, +$0a the three exp-to-next digits DrawCharDataSummarySpritesTask draws
wCharStatPageMain:: ds 13
; [13 bytes] The partner's page, same layout
wCharStatPagePartner:: ds 13
; [6 bytes] The page on screen, copied from +$04 of the main or partner page as the screen slides between them; DrawCharStatDigitsTask draws from here
wCharStatPageShown:: ds 6
	export_size wCharStatPageShown
	ds 7
; [8-bit] Which clock the summary's play time shows: zero = wSavedGameTimer + 2, nonzero = wGameTimer + 2 (minutes, hours)
wCharDataPlayTimeLive:: db
	ds 2
; [2 bytes] Minutes and hours DrawCharDataSummarySpritesTask copied from that clock and draws as the play-time digits
wCharDataPlayTime:: dw
; [16-bit] EXP points left to hand out: AssignExpPointToChar decrements it per point, DrawExpPoolReadout prints it, DrawExpPoolGauge draws it as a fraction of wExpPoolTotal
wExpPoolRemaining:: dw
; [16-bit] Starting pool, the gauge's denominator. Both are seeded from hl by InitLevelUpScreenState
wExpPoolTotal:: dw
	ds 45
; [8-bit] EXPBUSYB_* bits; the cursor's character is wStoryCharacterSlot
wExpScreenBusyFlags:: db
; [8-bit] Slide progress for the cursor moving between characters, stepped by SlideExpCursorToMainCharTask
wExpCursorSlide:: db
; [8-bit] X of the marker sweeping along the EXP bar: home $a8; SweepExpBarMarkerLeft subtracts the per-frame step and snaps back to $a8 past $18
wExpBarMarkerX:: db
; [8-bit] Row the confirm prompt cursor sits on
wExpPromptCursorRow:: db
; [8-bit] Frames before a held direction starts repeating, seeded to $08 when the screen opens
wExpRepeatDelay:: db
; [8-bit] Set when the screen needs its tilemap rows pushed again
wExpRedrawPending:: db
; [8-bit] Set once a held direction is repeating, so the delay applies only to the first step
wExpInputRepeating:: db
; [8-bit] Level-up fanfare countdown (0 = idle). $ff requests it: TickLevelUpJingle plays BGM_LEVEL_UP and reloads $a0, then restarts BGM_EXP_DISTRIBUTION when it ticks down to 0
wExpLevelUpFanfare:: db
NEXTU
; pending EXP award list (banks $1d/$1e)
	ds 296
; [10 bytes] Five 16-bit EXP amounts, one per line of the results award list (EXPAWARD_*). SetPendingExpAward takes the line in b and dispatches through PendingExpAwardSetters_1d, each storing de at base + 2 * line; ClearPendingExpAwards zeroes all 15 bytes of the pair. DrawNextExpAwardMessage reads it split-base (`add $52 / adc $d1`) and skips zero lines; HasPendingExpAwards ORs the five words to decide whether to show the screen
wPendingExpAwardAmounts:: ds 10
; [5 bytes] One byte per award line, the c argument of SetPendingExpAward, added by DrawNextExpAwardMessage to the line's base text id from ExpAwardSourceTextBases to pick a wording. ShowExpAwardForMatch passes 0, 2, 3 or 4 for a normal, Island Open, practice or Dream match; the trophy pass numbers the six trophy groups
wPendingExpAwardVariants:: ds 5
NEXTU
; EXP award screen (bank $1a)
	ds 295
; [8-bit] EXP award screen flags: Unused_1a_ExpScreenNumberTask sets bit 7 once EXP-to-next reaches zero, Unused_1a_ExpScreenDrawTask branches on it each frame, Unused_1a_SignExtendModifierByte rewrites it. Bank $1d has wExpPoolTotal's high byte here
wExpScreenFlags:: db
ENDU

	ds 49

; Scrolling text screen (the staff-roll crawl), owned by bank $03's
; RunStaffCreditsRoll. The bank $1a EXP award screen keeps its gauge
; state in the same bytes, and banks $1c/$1d put the character-data screen's
; $40-byte stat blocks at $d240/$d280/$d2d0.
UNION
; scrolling text screen (bank $03)
; [8-bit] Frames until the crawl scrolls one line; reloaded with 2 each time it hits 0
wScrollTextDelay:: db
; [8-bit] Write-only: seeded with 2 beside wScrollTextDelay, but RunStaffCreditsRoll's reload uses the literal $02
wUnusedScrollTextDelayReload:: db
; [16-bit] Text id the crawl is rendering, seeded with Text_StaffCreditsLines
wScrollTextId:: dw
; [8-bit] Set once the last line has scrolled off; stops the scroll without leaving the loop
wScrollTextDone:: db
	ds 37
NEXTU
; EXP award screen (bank $1a)
; [16-bit] EXP being awarded, the target the gauge counts up to
wExpAwardTotal:: dw
; [16-bit] EXP counted so far; Unused_1a_AdvanceExpGaugeFill increments it per tick and sets wExpCountDone at wExpAwardTotal
wExpAwardCounted:: dw
; [4 bytes] How the counted number is drawn: +$00 X, +$01 Y, +$02 first digit tile ("0"; a digit adds its value * 2), +$03 OAM attribute
wExpCountedSprite:: ds 4
; [8-bit] Set once wExpAwardCounted has reached the total; the fill loop leaves and the level-up path runs
wExpCountDone:: db
; [8-bit] Set when the player presses A or B during the count, which switches the gauge to the fast path
wExpCountFastForward:: db
; [8-bit] Added to the X of every digit Unused_1a_QueueNumberSpritesShifted draws, sliding the counted number while the gauge fills
wExpNumberSpriteShiftX:: db
; [8-bit] Latched when EXP-to-next reaches zero, so the level-up is requested once
wExpLevelUpQueued:: db
; [16-bit] EXP still needed for the next level, seeded from GetExpRemainingToNextLevel and counted down alongside the gauge
wExpToNextLevel:: dw
; [4 bytes] The same X/Y/tile/attribute record for the EXP-to-next-level number
wExpToNextSprite:: ds 4
; [16-bit] The EXP-to-next value shown; zero sets wExpLevelUpQueued
wExpToNextDisplayed:: dw
; [5 bytes] Decimal digits of wExpToNextDisplayed, formatted unsigned to five places
wExpToNextDigits:: ds 5
	ds 5
; [5 bytes] Decimal digits of wExpAwardCounted, formatted the same way
wExpCountedDigits:: ds 5
	ds 1
; [8-bit] Character record the award belongs to, passed to AddPlayerExp when the count finishes
wExpAwardSlot:: db
ENDU

	ds 422

; Two save-block readers share $d400 (bank $1e uses these addresses as
; shadow-tilemap cells in WRAM bank $03).
UNION
; story slot signatures (bank $02)
; [12 bytes] One wStorySaveSignature per story slot, four bytes apart, cached by CacheStorySlotSummaries so CheckStorySignatureCollision can check a new signature without reading SRAM again
wStorySlotSignatures:: ds 12
	ds 500
NEXTU
; unlock flags block (bank $1b)
; [512 bytes] Image of save block $0b read by Unused_1b_ReadUnlockFlagsSaveBlock for the minigame-flags debug screen (as wN64RecordsBlock in WRAM bank $03 and wSaveBlockBuffer in bank $07)
wUnlockFlagsBlock:: ds 512
ENDU

	ds 512

; Story-scene decompression scratch.
; story scene load (bank $0a)
; [1024 bytes] Third decompression destination of LoadStorySceneGraphics, never used there (only the unreachable Unused_0a_LoadSceneGraphicsDirect fills it): its `ld de, $d800` is overwritten by the next `ld de, $d400` before any call. The live siblings decompress into $d400 and $d000 of this bank; the later planes go to wScreenAttrmap and the bank $03 tilemap
wStorySceneUnusedBuffer:: ds 1024

	ds 8

; Story-scene record: the $88-byte slot LoadStorySceneGraphics copies out of
; the scene table before handing the scene to the overworld engine.
; story scene load (bank $0a)
; [136 bytes] The current story scene's record, copied from its slot with CopyDataFromBank. The four bytes at +2 are the map's scroll bounds and size, copied to wMapScrollMinX, wMapScrollMinY, wMapWidthTiles and wMapHeightTiles
wStorySceneRecord:: ds 136
	export_size wStorySceneRecord

SECTION "WRAMX bank 6 $df00", WRAMX[$df00], BANK[6]

	match_char_struct w6
