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
; [8-bit] Set to 1 by AnimateWindowSlideUpTask when the text window finishes sliding; PlayScrollingStoryCutscene clears it, registers the task and waits for it
wCutsceneSlideDone:: db
	ds 41
NEXTU
; scene animation frame counter (bank $03)
; [8-bit] Frame of the ending's animated scene: zeroed by SetupSceneAnimationPalettes, stepped by UpdateSceneAnimation every fourth tick of wCutsceneSlideTimer up to $36, read by the six LoadCutsceneAnimFrameGfx_* loaders
wSceneAnimFrame:: db
NEXTU
; star warp transition (bank $0e)
; [8-bit] Animation frame of the warp star, 0-5, stepped every other VBlank by UpdateStarWarpSprite
wStarWarpFrame:: db
; [8-bit] Distance the star has travelled along its path, +2 per frame; OffsetStarWarpPathPoint indexes StarWarpPathX/StarWarpPathY with it for wStarWarpPathX/Y
wStarWarpPathIndex:: db
; [8-bit] Frames left in the transition, seeded to $5a; the fade out starts at $1e and the wait loop returns at zero
wStarWarpCountdown:: db
; [16 bytes] One life counter per trail sparkle. UpdateStarWarpTrailSparkles sets the first zero one to $10 and seeds that slot's position (two bytes per slot from $d014) from wStarWarpPathX/Y
wStarWarpSparkleLife:: ds 16
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
; [8-bit] Which continue prompt is up, stored from c by InitResultsPromptState
wContinuePromptKind:: db
; [8-bit] Cursor row, toggled 0/1 by up and down; picks which of the two cursor sprites DrawContinuePromptCursor queues
wContinuePromptRow:: db
; [8-bit] Which page of the prompt text is showing (RefreshContinuePromptText)
wContinuePromptPage:: db
; [8-bit] What the prompt returned: 1 confirm, $ff cancel, or wContinuePromptPage - 1
wContinuePromptResult:: db
	ds 28
; [10 bytes] Row 1 of the four-row tilemap strip the continue prompt queues to $9800 from wContinuePromptKind (row 0 holds the prompt's variables). Runs on to $d03f; DrawSaveWarningTextLine1 writes it from column 1
wContinuePromptTilemapRow1:: ds 10
NEXTU
; character-data screen (banks $1a/$1c/$1d)
; [8-bit] Free-running counter CharDataScreenAnimTask steps each idle frame; low nibble indexes the animation table
wCharDataAnimCounter:: db
; [8-bit] Cleared with wCharDataAnimCounter when the screen opens; nothing reads it
wCharDataAnimSubStep:: db
; [8-bit] Which third of the screen still needs pushing to VRAM; FlushCharDataTilemapChunk sends one chunk per call (0, 1, 2). The animation task waits while it is nonzero
wCharDataFlushChunk:: db
; [8-bit] Points still unspent while editing. Heads the six bytes BackupCharData saves and RestoreCharData restores (this, wCharDataLevel, the four wCharDataNewLevels): everything a cancelled visit forgets
wCharDataPointsWorking:: db
; [8-bit] Level the character-data screen commits; WriteCharStatsToDisplayBuffer stores it to record +$18
wCharDataLevel:: db
; [4 bytes] Spin/Power/Control/Speed levels the screen is committing; WriteCharStatsToDisplayBuffer stores them back into record +$38-$3b
wCharDataNewLevels:: ds 4
; [8-bit] Unspent level-up points, copied in from $d003 and decremented by CharDataScreen_InputLoop after each LevelUpPlayer
wCharDataPointsLeft:: db
; [4 bytes] Spin/Power/Control/Speed levels as loaded from record +$38-$3b (LoadCharStats / LoadCharStatsWithLevelUpDeltas)
wCharDataLevels:: ds 4
; [11 bytes] The eleven displayed stats, record +$20-$2a plus 1 each (order as wStoryMainCharStats)
wCharDataStats:: ds 11
; [11 bytes] Per-stat change the pending level-up would apply, from ComputeLevelUpStatDeltas (cleared when wCharDataPage is $04); DrawStatArrowIndicators draws an up/down arrow per stat
wCharDataStatDeltas:: ds 11
; [8-bit] Level-up choice under the cursor (0-3), or $04 for the confirm cell; CharDataScreen_DrawPageColumns and DrawStatValueSprites key off it
wCharDataPage:: db
; [8-bit] Step of the confirm prompt (RunCharDataConfirmScreen); DrawConfirmSelectionCursor_1a draws the cursor from it
wCharDataConfirmState:: db
; [8-bit] AnimateCharDataStatsReveal countdown between stat rows; CharDataScreen_InitState seeds it with $0a
wCharDataRevealTimer:: db
; [8-bit] AnimateCharDataStatsReveal step; CharDataScreen_InitState seeds it with $03
wCharDataRevealStep:: db
; [8-bit] 0 while the allocation page is live: DrawStatValueSprites then draws the level one higher, in palette $0f, as a preview. CharDataScreen_InitState sets $03 on re-entry, CharDataScreen_Show clears it
wCharDataLevelPreview:: db
; [8-bit] Entries written to wCharDataChoiceLog so far (also the write index)
wCharDataChoiceCount:: db
NEXTU
; EXP award screen (bank $1e)
	ds 4
; [8-bit] First byte of the EXP award screen's working set: InitExpAwardScreenState clears $d004-$d027 from here (covering wExpAwardRunningTotal, wExpAwardAmount, wExpAwardIndex, wExpAwardMessageTimer) and seeds $d009-$d00c / $d019-$d01c to $20 and $d00d/$d01d to $30. The byte itself is never read
wExpAwardScreenState:: db
; [16-bit] EXP total counting up on screen: CountUpExpTotal adds one point (and a sound) per pass while decrementing the amount left; DrawExpTotalDigits redraws it
wExpAwardRunningTotal:: dw
; [16-bit] The award being counted in, set as each message is shown
wExpAwardAmount:: dw
	ds 27
; [8-bit] Award message being shown; BeginNextExpAward steps it, DrawNextExpAwardMessage returns zero past the end
wExpAwardIndex:: db
	ds 1
; [8-bit] Cleared as each award begins, so the message holds for its full time
wExpAwardMessageTimer:: db
NEXTU
; cutscene text window (bank $03)
	ds 1
; [8-bit] First byte of the current TextPageDescriptors_03 entry: rows the page scrolls by. ScrollCutsceneTextWindow masks it to two bits and treats zero as one
wCutsceneTextScrollRows:: db
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
; results continue prompt rows (bank $1e)
	ds 22
; [32 bytes] Row 2 of the continue prompt's tilemap strip; DrawContinuePromptText writes from column 1
wContinuePromptTilemapRow2:: ds 32
; [32 bytes] Row 3 of the strip; DrawSaveWarningTextLine2 writes the second warning line from column 1
wContinuePromptTilemapRow3:: ds 32
	ds 410
NEXTU
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
; [8-bit] Character group being totalled; indexes TrophyExpForGroupTable0-4 and selects GetTrophyExpValue's row
wTrophyExpGroup:: db
NEXTU
; character-data screen (bank $1a)
; [100 bytes] One byte per level-up taken this visit: the confirmed wCharDataPage. Cleared by WriteCharStatsToDisplayBuffer before the screen opens
wCharDataChoiceLog:: ds 100
; [6 bytes] Number formatting scratch for the character-data and EXP screens: FormatExp24BitDecimal puts the top byte at +$00 and the low word's five digits from +$01
wCharDataNumberBuffer:: ds 6
	export_size wCharDataNumberBuffer
	ds 11
; [8-bit] Cleared by CharDataScreen_InitState with the rest of the screen state; nothing reads it
wCharDataRevealDone:: db
; [11 bytes] The eleven stats recomputed without the racket, to show what the equipment is worth. Filled by CharDataScreen_BuildStats from wStoryMainCharStats after RecomputeStatsWithoutRacket; untouched when nothing is equipped
wCharDataStatsNoRacket:: ds 11
; [11 bytes] Per-stat difference the equipped racket makes, zeroed first so an unequipped character shows no arrows; read by DrawStatChangeArrows with wCharDataStatsNoRacket
wCharDataRacketDeltas:: ds 11
; [8-bit] Nonzero opens the character-data screen read-only: CharDataScreen_Show skips the allocation flow, LoadCharStatsWithLevelUpDeltas computes no deltas, the input loop spends no points. Set by RunExpDistributionFlow and RestoreCharData
wCharDataViewOnly:: db
; [6 bytes] Copy of wCharDataPointsWorking onward taken as the screen opens; RestoreCharData copies it back and sets wCharDataViewOnly when a level-up is cancelled
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
; [16-bit] The same offset for the value column, applied by CharDataValuesSyncTask (the two columns slide at different times)
wCharDataValuesSlideX:: dw
	ds 24
; [2 x 15 bytes] Per-character record the EXP award screen works on, selected by wStoryCharacterSlot (slot 1 at +15). InitExpScreenCharStats fills $d161-$d16f; +8 is the 16-bit total CheckExpLevelUp/Down compare; DrawExpScreenLevelNumber, DrawExpScreenLevelBar and the SweepExpBarMarker routines read +0 and +3
wExpScreenCharStats:: ds 30
NEXTU
; palette fade engine (bank $03)
	ds 118
; [128 bytes] The fade's endpoint: 16 palettes of four 16-bit colours. CopyMasterPalettesToFadeBuffers seeds it from wMasterPalettes and the caller rewrites it (Unused_03_ClearFadeTargetPalettes: black; DesaturateFadeTargetPalettes: grey via SplitColorComponents). Read by StepPaletteColorsTowardTarget, copied over wPaletteFadeLive by SnapPalettesToTarget; AdvanceToPaletteEntry walks it 8 bytes at a time
wPaletteFadeTarget:: ds 128
	ds 32
; [128 bytes] The palettes the fade shows: seeded from wMasterPalettes, stepped +/-1 per component toward wPaletteFadeTarget on each AnimatePaletteFadeToTarget pass for masked palettes, uploaded by LoadPalettesImmediate
wPaletteFadeLive:: ds 128
	ds 32
; [16 bytes] One byte per palette; only flagged palettes are stepped. InitGrayscalePaletteFade clears all 16, SetupPaletteFadeMask sets the first eight from the bits of b (bit 7 = palette 0)
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
; [8-bit] Set while a cutscene text window is sliding, by AnimateWindowSlideUpTask and the scrolling-story player
wCutsceneWindowSliding:: db
NEXTU
; character-data page arrows (banks $1a/$1c/$1d)
	ds 280
; [8-bit] Page arrows to bob: 1 left, 2 right, 0 neither; read every frame by DrawCharDataPageArrowsTask
wCharDataPageArrowMode:: db
; [8-bit] Nonzero freezes the arrow bob; while it is clear the task steps wCharDataArrowPhase
wCharDataArrowHold:: db
; [8-bit] Free-running counter the arrow bob reads for its offset
wCharDataArrowPhase:: db
NEXTU
; EXP distribution screen (bank $1d)
	ds 248
; [13 bytes] The main character's stat page as drawn: +$00 the four Spin/Power/Control/Speed levels from wCharDataLevels, +$04 six values copied to wCharStatPageShown, +$0a three more read by the value sync task
wCharStatPageMain:: ds 13
; [13 bytes] The partner's page, same layout
wCharStatPagePartner:: ds 13
; [6 bytes] The page on screen, copied from +$04 of the main or partner page as the screen slides between them; DrawCharStatDigitsTask draws from here
wCharStatPageShown:: ds 6
	export_size wCharStatPageShown
	ds 7
; [8-bit] Source of the pair CharDataValuesSyncTask pushes into the screen: zero = wCharDataSyncValues, nonzero = wGameTimer + 2
wCharDataSyncSource:: db
	ds 2
; [2 bytes] The two bytes it copied, drawn as the screen's live readout
wCharDataSyncPair:: dw
; [16-bit] EXP points left to hand out: AssignExpPointToChar decrements it per point, DrawExpPoolReadout prints it, DrawExpPoolGauge draws it as a fraction of wExpPoolTotal
wExpPoolRemaining:: dw
; [16-bit] Starting pool, the gauge's denominator. Both are seeded from hl by InitLevelUpScreenState
wExpPoolTotal:: dw
	ds 45
; [8-bit] Which character the distribution cursor is on; cleared when the screen opens
wExpCursorChar:: db
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
; [8-bit] $ff when a level-up has just happened; TickLevelUpJingle plays the jingle off it and clears it
wExpLevelUpFanfare:: db
NEXTU
; pending EXP award list (banks $1d/$1e)
	ds 296
; [10 bytes] Five 16-bit EXP amounts, one per line of the results award list: 0 story, 1 exhibition, 2 linked, 3 match/minigame, 4 trophy. RecordDrillResult takes the line in b and dispatches through DrillSubHandlers_1d, each storing de at base + 2 * line; ClearDrillResultBuffer zeroes all 15 bytes of the pair. DrawNextExpAwardMessage reads it split-base (`add $52 / adc $d1`) and skips zero lines; HasPendingExpAwards ORs the five words to decide whether to show the screen
wPendingExpAwardAmounts:: ds 10
; [5 bytes] One byte per award line, the c argument of RecordDrillResult, added by DrawNextExpAwardMessage to the line's base text id from DrawNextExpAwardMessageTable to pick a wording. ShowExpAwardForMatch passes 0, 2, 3 or 4 for a normal, Island Open, practice or Dream match; the trophy pass numbers the six trophy groups
wPendingExpAwardVariants:: ds 5
NEXTU
; EXP award screen (bank $1a)
	ds 295
; [8-bit] EXP award screen flags: Unused_1a_ExpScreenNumberTask sets bit 7 once EXP-to-next reaches zero, Unused_1a_ExpScreenDrawTask branches on it each frame, Unused_1a_SignExtendModifierByte rewrites it. Bank $1d has wExpPoolTotal's high byte here
wExpScreenFlags:: db
ENDU

	ds 22

; Scrolling text screen (the staff-roll crawl), owned by bank $03's
; RunScrollingTextScreen. The bank $1a EXP award screen keeps its gauge
; state in the same bytes, and banks $1c/$1d put the character-data screen's
; $40-byte stat blocks at $d240/$d280/$d2d0.
UNION
; scrolling text screen (bank $03)
; [8-bit] Frames until the crawl scrolls one line; reloaded with 2 each time it hits 0
wScrollTextDelay:: db
; [8-bit] The value it reloads with, seeded alongside it
wScrollTextDelayReload:: db
; [16-bit] Text id the crawl is rendering, seeded with $1863
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
; [1024 bytes] Third decompression destination of LoadStorySceneGraphics, never used: its `ld de, $d800` is overwritten by the next `ld de, $d400` before any call. The live siblings decompress into $d400 and $d000 of this bank; the later planes go to wScreenAttrmap and the bank $03 tilemap
wStorySceneUnusedBuffer:: ds 1024

	ds 8

; Story-scene record: the $88-byte slot LoadStorySceneGraphics copies out of
; the scene table before handing the scene to the overworld engine.
; story scene load (bank $0a)
; [136 bytes] The current story scene's record, copied from its slot with CopyDataFromBank. The four bytes at +2 are the map's scroll bounds and size, copied to wMapScrollMinX, wMapScrollMinY, wMapWidthTiles and wMapHeightTiles
wStorySceneRecord:: ds 136
	export_size wStorySceneRecord

SECTION "WRAMX bank 6 $df00", WRAMX[$df00], BANK[6]

; One copy per character of a structure that lives in WRAM banks 4-7 at
; once. Each bank declares its own copy under a bank-tagged name so the
; symbol file resolves the right one in a debugger; this is bank 6's. Code
; uses the untagged names (EQUs in include/ram_mirrored.inc), because the
; bank is chosen at run time. A change here belongs in every copy.

; Match-engine per-character struct, bank = character: 4 near-P1, 5 far-P1,
; 6 near-partner, 7 far-partner. Only named field offsets render; other
; $dfxx bytes stay numeric. Bank $38's UpdateCharSelectCharSprite and
; TickCharSelectIdleAnim drive the same struct once per preview character,
; selecting WRAM banks $04-$07 in turn (bank $38's own $df00 is
; wCharSelectHandedness in WRAM bank $03).
UNION
; clear-status developer menu (bank $0a, WRAM bank $05)
; [8-bit] RunClearStatusSetupMenu's first choice (Text_34_215): 0 Set, 1 Continue, $ff cancelled; Continue and cancel go straight to the result code. The menu keeps its state in WRAM bank $05 over the idle far-P1 character struct, cleared 32 bytes at a time on entry
w6ClearStatusMode:: db
; [8-bit] 0 singles, 1 doubles, copied from FLAG_DOUBLES when Set is chosen; picks the singles or doubles rank list and result-code row
w6ClearStatusDoubles:: db
; [8-bit] Second menu (Text_34_217): 0 Mini-Game, 1 Ranking Match; $ff steps back
w6ClearStatusFormat:: db
; [8-bit] Third menu (Text_34_218): 0 Junior, 1 Senior, 2 Varsity; $ff steps back. SetTrainingCourtClearFlags reads it as the drill level to mark cleared, the ranking routines as how many classes of wins to set
w6ClearStatusClass:: db
; [8-bit] Fourth menu: the drill (Text_34_219) for a Mini-Game clear, or the rank within the class (Text_34_220 and the per-class lists after it) for a Ranking Match clear; $ff steps back
w6ClearStatusRank:: db
; [8-bit] Window struct index of the caption frame CreateWindowFromScreenRect opened; redrawn before every menu
w6ClearStatusWindowId:: db
; [8-bit] What RunClearStatusSetupMenu returns in b: 8 cancelled, 1 Continue, else the ClearStatusResultCodeIndexTable entry for the choice
w6ClearStatusResultCode:: db
	ds 144
NEXTU
; text-arg fetch buffer (menu banks reuse the idle char struct)
; [NUL-terminated string] Bank 5 buffer PushTextArgFetchedString fills with a short-text string (FetchShortTextToBuffer) and pushes as a text argument; overlaps the idle far-P1 character struct
w6TextArgFetchBuffer:: db
NEXTU
; match character struct (WRAM banks 4-7, and the match/shot/results banks that address it with the bank already selected)
; [3 bytes] Lateral X position, 24-bit fixed point (fraction byte + signed 16-bit integer)
w6CharPosX:: ds 3
; [3 bytes] Depth position (toward/away from the net), same format; the two court sides have opposite signs
w6CharPosDepth:: ds 3
; [3 bytes] Height above the court, same format (zeroed by SetCharPosAndTarget)
w6CharPosHeight:: ds 3
; [8-bit] Serve/side role code (court-position record bytes 4-7); XORed with 2 on the per-point side swap, mapped through the $4fa0 table at point start
w6CharServeRole:: db
; [8-bit] Court position code (court-position record bytes 0-3); XORed with 3 on the tiebreak side swap
w6CharCourtPos:: db
; [8-bit] Character index 0-3 (= WRAM bank - 4); bit 0 set = far side (CharPointEndReaction, the edge-arrow sprite)
w6CharIndex:: db
; [8-bit] Facing the character returns to for its court position, from CourtPosFacingTable_08; PlaceCharAtBasePosition and UpdateCharFacingOctant measure the displayed facing against it
w6CharBaseFacing:: db
; [8-bit] Desired facing; wCharFacingShown eases toward it
w6CharFacingDesired:: db
; [8-bit] Displayed facing, eased toward wCharFacingDesired by at most wCharFacingEaseRate per frame
w6CharFacingShown:: db
; [8-bit] State flags; bit 2 = airborne (set on a jump, cleared on landing; selects the shadow slot drawn)
w6CharFlags:: db
; [8-bit] Frames the character is frozen: UpdateCharStateMachine decrements it and skips the state. SetCharState clears it; FreezeMinigameOpponentOnReturn sets it to hold the minigame opponent still
w6CharFreezeTimer:: db
; [8-bit] Frames left to press a second shot button; BufferShotButtonPress seeds 5 on the first press, the state-machine dispatch counts it down
w6CharShotComboTimer:: db
; [8-bit] AI countdown: the reaction delay AiSetReactionDelay randomises, and the hold time AiServePressToss uses for the toss button
w6AiActionTimer:: db
; [8-bit] Frames the AI holds its first shot button before adding the second: AiWaitThenPickShot sets 5 after AiPressFirstShotButton, and AiSwingControlSingles/Doubles skip AiPressSecondShotButton while nonzero. Counted down only after wAiActionTimer reaches 0
w6AiSecondButtonDelay:: db
; [8-bit] SHOTTYPE_* of the swing about to happen, from the two buffered buttons via SelectServeShotType / SelectRallyShotType
w6CharShotType:: db
; [8-bit] Swing animation id SelectForehandBackhand picked; the windup plays it + $08, the contact phase plays it as is
w6CharSwingAnim:: db
; [8-bit] First shot button of the swing (1 = A, 2 = B), 0 = none. With wCharShotButton2 it indexes RallyShotTypeTable0/1, turning A+B combinations into lobs, drops and power shots
w6CharShotButton1:: db
; [8-bit] Second shot button, captured while wCharShotComboTimer runs
w6CharShotButton2:: db
; [8-bit] State-machine index (RST00 jumptable at $6a77; set via SetCharState)
w6CharState:: db
; [8-bit] Sub-step within wCharState; AdvanceCharStatePhase increments it, each state's phase routine dispatches on it
w6CharStatePhase:: db
; [8-bit] Sub-step of the AI state machine, advanced by AiAdvancePhase
w6AiPhase:: db
; [3 bytes] Current sprite frame pointer (hi/lo) + h-flip flag, used by DrawCharSprite
w6CharSpriteFrame:: ds 3
; [8-bit] Which input drives this character; ReadCharInput indexes CharInputPtrs with it (pad, CPU and link handlers)
w6CharInputSource:: db
; [8-bit] Input ReadCharInput produces: held buttons in the high nibble, newly pressed in the low (ReadCharPadInput builds it from hPlayerInputFlags and hInputRisingEdge); test with PADB_*
w6CharInputBits:: db
	ds 1
; [8-bit] Object-definition id passed to SetupCharSpriteFromObjectDef; write-only
w6CharObjectDefId:: db
; [8-bit] ROM bank of the character's object definition, animation scripts and frame tables, banked in by GetPerspectiveScale and passed to FarReadWordDI by SetCharAnimation / StepCharAnimation. 0 = no object loaded (UpdateChar exits)
w6CharObjectBank:: db
	ds 1
; [16-bit] Pointer (in wCharObjectBank) to the frame graphics table GetPerspectiveScale walks for a frame's tile data
w6CharFrameTablePtr:: dw
; [16-bit] VRAM destination of the character's frame tiles
w6CharFrameVramDest:: dw
; [16-bit] Pointer (in wCharObjectBank) to the animation-pointer table; SetCharAnimation indexes it by animation id
w6CharAnimTablePtr:: dw
; [16-bit] Start of the current animation script, where the $ff (jump) command rewinds to
w6CharAnimScriptBase:: dw
; [16-bit] Cursor into the current animation script. Word-sized commands: < $f0 is [frame, delay], $ff jumps, $fe switches animation, $fb toggles the flip bits of wCharSpriteAttr
w6CharAnimScriptPtr:: dw
; [8-bit] Animation playing; SetCharAnimation returns early when asked for the same one
w6CharAnimId:: db
; [8-bit] Frames left on the current animation frame; $ff = hold indefinitely
w6CharAnimDelay:: db
; [8-bit] Sprite bookkeeping flags. Bit 6 = frame or facing octant changed, so ReloadCharFacingTiles uploads new tiles (and clears the bit)
w6CharSpriteDirty:: db
	ds 1
; [8-bit] Facing octant 0-7 from wCharFacingShown; picks the tile row and, for octants 2 and 6, the mirrored sprite
w6CharFacingOctant:: db
; [8-bit] Frame id the animation script last selected
w6CharAnimFrame:: db
	ds 2
; [8-bit] First VRAM tile of the character's sprite, from a per-character-index table
w6CharTileBase:: db
; [8-bit] OAM attribute byte. The low three bits are the CGB OBJ palette (wCharIndex + 4) and also the tile block ReloadCharFrameGfx uploads into (& $07, + $08); the high bits are the flip bits the animation's $fb command toggles, cleared by SetCharAnimation (`and $0f`)
w6CharSpriteAttr:: db
; [16-bit] Pointer (in wCharObjectBank) to the per-frame shadow/scale table GetPerspectiveScale reads
w6CharShadowTablePtr:: dw
; [8-bit] ROM bank of the character's frame graphics; ReloadCharFrameGfx and LoadCharChargeFlashGfx pass it to the far-call vector at $0110
w6CharGfxBank:: db
	ds 5
; [16-bit] X velocity (zeroed on placement and at point end)
w6CharVelX:: dw
; [16-bit] Depth velocity
w6CharVelDepth:: dw
; [16-bit] Height velocity
w6CharVelHeight:: dw
; [16-bit] Walk-target X (integer part)
w6CharWalkTargetX:: dw
; [16-bit] Walk-target depth; MoveCharTowardTarget walks toward the target, snapping when both deltas are < $18 (CheckCharNearTarget)
w6CharWalkTargetDepth:: dw
; [8-bit] Left/right aim held at the moment of the shot, captured by CaptureServeAim / CaptureShotAim; GetShotAimOffsetForSide and ComputeShotTargetX turn it into the target's lateral offset
w6CharAimOffset:: db
; [8-bit] Frames in the current swing phase, reset at windup start, incremented by the windup and contact phases
w6CharSwingFrames:: db
; [8-bit] Set when the swing was quick (uncharged): written by StartCharSwing, copied to wShotWasQuickSwing by ExecuteShot so the shot gets no charge bonus
w6CharQuickSwing:: db
; [8-bit] Shot button latched while the swing is held, from b in CheckSwingRelease; cleared there when SELECT is down and by CharRallyReadyPhase. Write-only
w6CharSwingHoldButton:: db
; [8-bit] Frames the swing has been held: CheckSwingRelease increments it per frame and zeroes it on release or with SELECT down. Write-only
w6CharSwingHoldFrames:: db
; [8-bit] Shot button already recorded, so BufferShotButtonPress ignores it while held
w6CharLastShotButton:: db
; [8-bit] This frame's ball-geometry tests, rebuilt by UpdateCharBallGeometry: bit 0 = ball within swing range, bit 1 = inside the contact window, bit 4 = within normal reach (clear selects the stretching shot table)
w6CharBallReachFlags:: db
; [8-bit] Set while the charge flash plays; cleared when the swing starts or aborts
w6CharChargeFlashOn:: db
; [8-bit] 1 while the flashed tiles are in VRAM. UpdateChargeFlash toggles the flash on wCharSwingFrames bit 2; this latch makes each half load its graphics once (set + LoadCharChargeFlashGfx, or clear + ReloadCharFrameGfx)
w6CharChargeFlashGfxLoaded:: db
; [8-bit] Last projected screen X (BuildCharSpriteSlots)
w6CharScreenX:: db
; [8-bit] Last projected screen Y
w6CharScreenY:: db
; [8-bit] Zeroed right after each write of wCharWalkTargetX / wCharWalkTargetDepth; nothing reads it
w6CharWalkTargetFlag:: db
; [8-bit] Set to 1 by MoveCharTowardTarget when it steps the character toward the walk target; UpdateCharStateMachine clears it each frame and UpdateCharVelocityFromInput returns while it is set, so a scripted walk overrides the stick
w6CharScriptedMove:: db
; [8-bit] Point result from this character's side (signed wPointWinLoseFlag)
w6CharPointResult:: db
; [8-bit] Shot buttons the AI chose for this swing (AiPickServeButtons / AiPickShotButtons); AiPressFirstShotButton and AiPressSecondShotButton feed them into wCharInputBits one at a time
w6AiShotButtons:: db
; [8-bit] Countdown seeded from wAiTrackingParam whenever the AI advances a phase after fixing a target. AiWaitThenPickShot decrements it per frame and picks no shot until 0 (or until wCharBallReachFlags bit 0 says the ball is in reach), so a larger parameter commits later
w6AiTrackingCountdown:: db
; [8-bit] Set to 1 by CharRallyReadyPhase, cleared with wCharShotButton1/2 when a shot is abandoned. AiTrackBallPhase does not steer while it is 0
w6CharRallyReady:: db
	ds 5
; [16-bit] Speed limit on X: ClampCharXSpeed multiplies it by the cosine of wCharFacingDesired. From CharStatTable_07_0 indexed by attribute byte $0027
w6CharMaxSpeedX:: dw
; [16-bit] Speed limit on depth: ClampCharDepthSpeed multiplies it by the sine of wCharFacingDesired. LoadCharacterAttributes indexes CharStatTable_07_0 with attribute bytes ($0027 + $002b) * 2, clamped to ten entries, so this axis gets the $002b bonus that wCharMaxSpeedX does not
w6CharMaxSpeedDepth:: dw
; [16-bit] Acceleration, from CharStatTable_07_1 via attribute offset $0028. AccelerateCharDepth / AccelerateCharX multiply it by the sine/cosine of wCharFacingDesired into wCharVelDepth / wCharVelX
w6CharAcceleration:: dw
; [16-bit] Deceleration when not accelerating, from CharStatTable_07_2 via attribute offset $002a. The brake routines negate it against the velocity's sign; one uses a flat $0040 when wCharFlags bit 1 is clear
w6CharDeceleration:: dw
; [8-bit] Max facing change per frame (wCharFacingShown toward wCharFacingDesired)
w6CharFacingEaseRate:: db
; [8-bit] Fraction ComputeAimBaseOffset applies (MulHLByAFrac) to the base aim offset. From CharStatTable_07_4 via attribute offset $0025
w6CharAimOffsetScale:: db
; [8-bit] Random aim component: GetRandomAimJitter multiplies an AdvanceMatchRng byte by it; higher is less accurate. From CharStatTable_07_5 via attribute offset $0026
w6CharAimJitterScale:: db
; [8-bit] Speed-row index (e) into the ShotPlacementData tables for ground strokes (topspin/slice/power variants/neutral); selects bytes 4-5 (shot speed) in LoadShotPlacementEntry
w6GroundStrokeSpeedIndex:: db
; [8-bit] Speed-row index (e) into ShotPlacementData for the smash and all three serves
w6SmashServeSpeedIndex:: db
; [8-bit] Speed-row index (e) into ShotPlacementData for the reach (smash-range) shot variants
w6ReachSpeedIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementData for topspin and serve-topspin; selects bytes 0-3 (target offsets) in LoadShotPlacementEntry
w6TopspinPlacementIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementData for slice and serve-slice
w6SlicePlacementIndex:: db
; [16-bit] How far above or below the character the ball can be hit; CheckCharBallContact compares |wBallRelCharHeight| with it. Attribute record +$10, minus $10
w6CharReachHeight:: dw
; [16-bit] Lateral reach; CheckCharBallContact compares |wBallRelCharX| * 2 with it. Attribute record +$12
w6CharReachX:: dw
; [16-bit] Upward speed of a jump smash, negated into wCharVelHeight by StartCharSwing. Attribute record +$14, plus $0200
w6CharSmashJumpSpeed:: dw
; [16-bit] Lunge speed of a dive, turned into wCharVelX/wCharVelDepth along the facing by VectorFromLengthAndAngleRaw. Attribute record +$16
w6CharDiveSpeed:: dw
; [8-bit] Character id passed to InitChar, before RemapExtendedCharId
w6CharId:: db
; [8-bit] Base frames the AI waits before reacting to a ball within normal reach; AiSetReactionDelay adds 0-3 at random into wAiActionTimer. Attribute record +$1b
w6AiReactionDelayNear:: db
; [8-bit] The same for a ball outside normal reach (wCharBallReachFlags bit 4 clear). Attribute record +$1c
w6AiReactionDelayFar:: db
; [8-bit] How the AI chases the ball; read by AiTrackBallPhase and the baseliner rally state. Attribute record +$1d
w6AiTrackingParam:: db
; [8-bit] RNG threshold in AiMaybeAimAwayFromChar: the AI aims away from the opponent when the roll is under it. Attribute record +$1e
w6AiAimAwayChance:: db
; [8-bit] AI serve/shot habit: low nibble indexes ServePressTossPtrs for toss timing; AiPickShotButtons reads it too. Attribute record +$1f
w6AiServeStyle:: db
; [8-bit] Character id after RemapExtendedCharId; LookupCharSpriteSet and bank $09's LoadOnCourtCharacterGfx find the sprite bank with it
w6CharSpriteSetId:: db
; [8-bit] Where the AI stands between shots (0/5 baseline, 1 net, others mid-court); RST00 index in AiChooseHomePosition and AiChoosePositionByStrategy. Attribute record +$0f
w6AiPositionStrategy:: db
; [4 bytes] Sprite-slot record [tile, attr, screenY, screenX] for the character sprite
w6CharSpriteSlot:: ds 4
; [4 bytes] Frame descriptor the single-character screens (Unused_1a_DrawCharViewerCharSprite, the results/EXP screen drawers) write after the sprite slot: wCharSpriteFrame + 2 (the 32x32 flag), + 1 and + 0 (Y and X offsets for QueueSprite24x32), and a depth key (slot * 8 + $80). The match engine's drawer does not use it
w6CharSpriteSlotFrame:: ds 4
; [4 bytes] Sprite-slot record for the airborne shadow (tiles $50/$52/$54/$56 shrinking with height; drawn only while wCharFlags bit 2 is set)
w6CharAirShadowSlot:: ds 4
; [4 bytes] Sprite-slot record for the standing shadow (tile $58, flickered while grounded)
w6CharGroundShadowSlot:: ds 4
; [16-bit] Attribute word from character record +$19; StartCharSwing tests bit 7 of the low byte; bits 0 and 1 of the high byte select the lob and drop placement rows
w6CharSwingAttrWord:: dw
; [8-bit] Placement-row index (d) into ShotPlacementDataLob (from wCharSwingAttrWord + 1 bit 0)
w6LobPlacementIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementDataDrop (from wCharSwingAttrWord + 1 bit 1)
w6DropPlacementIndex:: db
; [8-bit] Attribute bits XORed into wCharSpriteAttr for facing octants 2 and 6 (sprite drawn mirrored)
w6CharMirrorAttrMask:: db
; [8-bit] Character class/tier from attribute record +$18; LookupExpTierForChar reads it on the EXP screen
w6CharExpTier:: db
; [8-bit] Draw-order depth key ((depth * 8) >> 8 + $80); DrawActorsByDepth draws back to front
w6CharDepthKey:: db
ENDU
