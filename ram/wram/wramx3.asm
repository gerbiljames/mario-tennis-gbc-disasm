SECTION "WRAMX bank 3", WRAMX[$d000], BANK[3]

; WRAMX bank 3 at a glance:
;
;   $d000-$d41f  wCharDataScreenCell  [mirrored with bank 2]
;   $d000-$d7ff  screen tilemap
;   $d000-$dfff  wMapBuffer64  [mirrored with bank 2]
;   $d400-$d7df  wCharDataPagePlane  [mirrored with bank 2]
;   $d430-$d66f  wCharDataScreenBackup  [mirrored with bank 2]
;   $d600-$d68f  wMugshotBuffer  [mirrored with bank 2, 4]
;   $d7e0-$da1f  wCharDataPageSlot1  [mirrored with bank 2]
;   $d800-$d80f  10 overlays: link error flash palette / equipment select / name entry / +7 more
;   $d810-$d83e  8 overlays: N64 tournament data screen / erase-confirm flash palette / drill briefings / +5 more
;   $d840-$d867  character unlock flags / ranking board
;   $d900-$daff  created characters and the character grid / N64 transfer records / screen sequences
;   $da20-$dc5f  wCharDataPageSlot2  [mirrored with bank 2]
;   $db00-$dbff  chart rows
;   $dc00-$dc13  rules screen / N64 exhibition and Mario-cast charts / rules screen
;   $dc20-$dc5f  exhibition victory grid bits / ring-shot results
;   $dc60-$de9f  wCharDataPageSlot3  [mirrored with bank 2]
;   $de00-$de00  character select
;   $df00-$df00  character select

; Screen tilemap buffers. The full-screen UIs assemble their BG map at
; $d000 and its CGB attributes at $d400 (32 x 32 cells, rows TILEMAP_WIDTH
; apart, top-left 20 x 18 on screen), then QueueVRAMCopy them to $9800 in
; VRAM banks 0 and 1. The bank $03 cutscenes instead keep the attribute
; plane at $d000 in WRAM bank $02.
; wShadowTilemapBank / wShadowTilemapPtr point the text engine at whichever
; bank the screen uses ($03 for screens, $05 for text windows, $02 for the
; match). Cell addresses are written `base + row * TILEMAP_WIDTH + column`.
; The ranking board's row and marker drawers are one shape repeated behind a
; jump table; rows 9-11 and markers 5/6 are not selected by any
; ShowRankingBoard argument.
; screen tilemap
; [1024 bytes] BG tile map the screen is assembled into, 32 x 32 cells
; with rows TILEMAP_WIDTH apart; CopyTilemapRect steps rows by $0020
wShadowTilemap:: ds 1024
; [1024 bytes] CGB attribute plane for wShadowTilemap, same geometry $400
; higher (the attribute of cell $d08b is $d48b)
wShadowAttrmap:: ds 1024

; Screen-local scratch, low half. Each full-screen UI reuses these bytes,
; so variants belong to the owning ROM bank (or screen code range). The
; minigame data screen and the trophies screen lay arrays across $d810;
; their first symbol here covers only this block, the rest continues in the
; $d810 union under a variant of the same name.
UNION
; link error flash palette (bank $3e)
; [8 bytes] One 4-colour palette AnimateLinkErrorPalette rebuilds each frame for the link-error screen: colour 1 (+2) from a flash table indexed by the frame counter, uploaded through LoadPaletteShadow as palette 3
wLinkErrorPalette:: ds 8
	export_size wLinkErrorPalette
	ds 8
NEXTU
; equipment select (bank $3e, $5400-$5c00)
; [8 bytes] Item ids the player owns, compacted by BuildOwnedItemList from wEquipOwnedMap; the cursor indexes this list
wEquipItemList:: ds 8
	export_size wEquipItemList
; [8 bytes] One byte per item slot: 0 not owned, 1 owned, 2 owned and equipped; filled from the save data by MarkOwnedRackets / MarkOwnedShoes
wEquipOwnedMap:: ds 8
	export_size wEquipOwnedMap
NEXTU
; name entry (bank $38, $6e00-$7500)
; [11 bytes] Name being typed, $00-terminated; edited by AppendCharToName / DeleteLastNameChar, copied into the character record by RunNameEntryScreen on accept ($de is the blank-cell filler). Eleven bytes, not the eight visible cells: every copy uses `ld bc, $000b`, and TrimTrailingSpacesFromName scans back from the last
wNameEntryBuffer:: ds 11
	export_size wNameEntryBuffer
NEXTU
; match results (bank $16)
; [8-bit] 1 if the player won the match just played, else 0; written with wResultScreenMode by RunMatchWinLoseScreen, used by LoadWinLoseScreenAssets / LoadResultScreenTileGraphics to pick the graphics set
wResultScreenWon:: db
; [8-bit] Stored from a by RunMatchWinLoseScreen and RunMatchStatsScreen; SetWinLosePortraitPaletteAttrs and LoadResultPortraitSlot branch on it
wResultScreenMode:: db
NEXTU
; ranking board (bank $1b)
; [8-bit] Nonzero shows the doubles ranking; from b of ShowRankingBoard. Picks the screen asset record and the singles or doubles Draw/Highlight*RankingRows pair
wRankingBoardDoubles:: db
; [8-bit] The player's ranking row, from c; the highlight and the marker animation use it
wRankingBoardPlayerRow:: db
; [8-bit] Board presentation, from d: 0 plain, 1 plays fanfare $2b, 2 plays the second fanfare and registers RankingCursorBobTask. 3 becomes 0 with w3_d85a set
wRankingBoardMode:: db
; [8-bit] Base of the ranking marker slots: twelve 4-byte records [tile, X, Y, -], $d803-$d832, running into the $d810 block. GetRankingMarkerSlot returns base + index * 4; DrawRankingMarkersTask queues each as a sprite, skipping those whose +0 is $ff. ClearRankingMarkerSlots clears the $30 bytes, LoadRankingMarkerCoords copies $30 bytes of coordinates over them; BuildRankingBoardScreen's $53-byte clear wipes the whole screen state from here up to wRankingBannerAnimFrame
wRankingMarkerSlots:: db
NEXTU
; trophy / N64-tournament / bracket screens (bank $3b)
	ds 1
; [8-bit] Page the bank $3b data screens show; DrawN64TnmtPageLabels and the bracket builders key off it, N64TnmtScrollArrowsTask picks the scroll arrows from it
wDataScreenPage:: db
; [8-bit] Cursor row within the page, stepped by ScrollN64TnmtDataCursor
wDataScreenCursorRow:: db
NEXTU
; minigame data screen (bank $1b, $73dd-$78bd)
	ds 9
; [7 of 9 bytes] One byte per list row, nonzero when that row's minigame has its level-1 clear flag. LoadMinigameClearFlags clears nine bytes and fills them from MinigameClearFlagsTable (the SAVEFLAG_CLEARED_*_1 of Boo Blast through Two-On-One) through TestSaveFlag; DrawMinigameClearMarks indexes it by wMenuCursorY for the five visible rows. The array runs to $d811, into the $d810 block
wMinigameDataClearFlags:: ds 7
NEXTU
; trophies screen (bank $3b, $49e5-$4cfa)
; [6 bytes] One trophy row: six cells, each 0 or 1, one icon per set cell drawn by DrawTrophyRowPair (three, a gap, three). DecodeTrophyCounts fills the first three from wN64TrophyCounts bits 0-1 and the next three from bits 4-5, one 1 per unit of the 0-3 count. The main character's first set, drawn beside wStoryModeMainCharacterOverworldSprite
wTrophyCellsMainSet1:: ds 6
; [6 bytes] The partner's first-set row, from wN64TrophyCounts + 1 bits 0-1 and 4-5; drawn beside wStoryModePartnerCharacterOverworldSprite
wTrophyCellsPartnerSet1:: ds 6
; [4 of 6 bytes] The main character's second-set row, from wN64TrophyCounts bits 2-3 and 6-7; drawn only when wTrophySecondSetPresent (four rows instead of two). The row runs to $d811, into the $d810 block
wTrophyCellsMainSet2:: ds 4
NEXTU
; title screen (bank $6b)
	ds 1
; [8-bit] Frame of the title screen's animated sprite; read by QueueTitleSprite, advanced by StepTitleSpriteAnimation
wTitleSpriteFrame:: db
; [8-bit] Frames left on the current title sprite frame
wTitleSpriteTimer:: db
NEXTU
; screen scratch (any other screen)
; [8-bit] Base of the screen-local scratch block. Screens with no named
; variant use it as a working buffer: an object array (bank $18), a
; decompression staging area (banks $1b/$39), a cursor or mode byte
; (banks $3b/$6b).
wScreenScratch:: db
ENDU

; Screen-local state: each full-screen UI reuses these bytes for its own
; purpose, so variants belong to the owning ROM bank. Most sites select
; WRAM bank $03 in a callee.
UNION
; N64 tournament data screen (bank $3b)
; [16 bytes] Copy of N64TnmtData made by LoadN64TnmtDataRecords. +$0e and +$0f are the singles and doubles column masks, forced to $10 when bit 0 / bit 1 of the records block's byte +344 is clear (that half has no data)
wN64TnmtLayout:: ds 16
	export_size wN64TnmtLayout
	ds 16
; [12 bytes] First of 16 rows of 12 cells, one per character in N64CharTrophyRowPtrTable order, filled by BuildN64TnmtTrophyGrid from DecodeN64CharTrophyCounts; rows run to $d8ef. CheckN64TnmtSecondPage scans +2 and +5 of the first fourteen rows to decide on a second page
wN64TnmtTrophyCells:: ds 12
	ds 3
NEXTU
; erase-confirm flash palette (bank $3e)
; [8 bytes] One 4-colour palette AnimateEraseConfirmPalette rebuilds every frame from EraseConfirmPalette_3e and uploads as palette 4 via LoadPaletteShadow; colour 2 (+4) comes from EraseConfirmFlashColors_3e indexed by hVBlankCounter (the flashing warning text)
wEraseConfirmPalette:: ds 8
	export_size wEraseConfirmPalette
NEXTU
; drill briefings (bank $17)
; [8-bit] Drill-briefing diagram: player sprite X, queued by DrawBriefingPlayerSprite
wBriefingPlayerX:: db
; [8-bit] Drill-briefing diagram: player sprite Y
wBriefingPlayerY:: db
; [8-bit] Drill-briefing diagram: opponent sprite X, queued by DrawBriefingOpponentSprite
wBriefingOpponentX:: db
; [8-bit] Drill-briefing diagram: opponent sprite Y
wBriefingOpponentY:: db
; [8-bit] Drill-briefing diagram: swing-animation sprite X, queued by DrawBriefingSwingAnim
wBriefingSwingX:: db
; [8-bit] Drill-briefing diagram: swing-animation sprite Y
wBriefingSwingY:: db
; [8-bit] Drill-briefing diagram: spin-serve marker X, queued by DrawSpinServeBriefingMarker
wBriefingSpinMarkerX:: db
; [8-bit] Drill-briefing diagram: spin-serve marker Y
wBriefingSpinMarkerY:: db
; [8-bit] Drill-briefing diagram: rotatable marker X, queued by DrawBriefingMarkerRotated
wBriefingRotMarkerX:: db
; [8-bit] Drill-briefing diagram: rotatable marker Y
wBriefingRotMarkerY:: db
; [8-bit] Drill-briefing diagram: first pole sprite X, queued by DrawBriefingPoleSprites
wBriefingPole1X:: db
; [8-bit] Drill-briefing diagram: first pole sprite Y
wBriefingPole1Y:: db
; [8-bit] Drill-briefing diagram: horizontal marker X, queued by DrawBriefingMarkerHFlip (jiggles by 1px on hVBlankCounter bit 4)
wBriefingHMarkerX:: db
; [8-bit] Drill-briefing diagram: horizontal marker Y
wBriefingHMarkerY:: db
; [8-bit] Drill-briefing diagram: ball sprite X, queued by DrawBriefingBallSprite
wBriefingBallX:: db
; [8-bit] Drill-briefing diagram: ball sprite Y
wBriefingBallY:: db
; [8-bit] Drill-briefing diagram: second pole sprite X (same drawer as wBriefingPole1X)
wBriefingPole2X:: db
; [8-bit] Drill-briefing diagram: second pole sprite Y
wBriefingPole2Y:: db
; [8-bit] Drill-briefing diagram: swing-animation frame (0-9); indexes BriefingSwingAnimTable0 for the base tile, and < 6 selects the 5-sprite racket template
wBriefingSwingFrame:: db
; [8-bit] Drill-briefing diagram: vertical marker X, queued by DrawBriefingMarkerVFlip
wBriefingVMarkerX:: db
; [8-bit] Drill-briefing diagram: vertical marker Y
wBriefingVMarkerY:: db
; [8-bit] Drill-briefing diagram: 1 draws the vertical marker upright (OAM attr $09), anything else Y-flipped ($49)
wBriefingVMarkerUpright:: db
; [8-bit] Drill-briefing diagram: 1 draws the spin-serve marker unflipped (OAM attr $09), anything else X-flipped ($29)
wBriefingSpinMarkerUnflipped:: db
; [8-bit] Drill-briefing diagram: rotatable marker orientation (0-3); indexes BriefingMarkerRotatedTable, the four flip combinations of OAM attr $x9
wBriefingRotMarkerDir:: db
; [8-bit] Drill-briefing diagram: target-bracket top-left X; DrawBriefingTargetBrackets draws the four corners at X, X+width+3
wBriefingBracketX:: db
; [8-bit] Drill-briefing diagram: target-bracket top-left Y; corners sit at Y and Y+height-5
wBriefingBracketY:: db
; [8-bit] Drill-briefing diagram: target-bracket width in pixels (corner offset is width+3)
wBriefingBracketWidth:: db
; [8-bit] Drill-briefing diagram: target-bracket height in pixels (corner offset is height-5)
wBriefingBracketHeight:: db
; [8-bit] Drill-briefing animation frame timer; each briefing's *_TickAnim increments it and calls *_AdvanceAnim at $78 (120 frames)
wBriefingAnimTimer:: db
; [8-bit] Drill-briefing diagram: 1 draws the horizontal marker unflipped (OAM attr $09), anything else X-flipped ($29)
wBriefingHMarkerUnflipped:: db
; [8-bit] Drill-briefing animation step; each briefing's *_AdvanceAnim wraps it (& $03) and indexes its 4-byte-per-step position table with it
wBriefingAnimStep:: db
	ds 1
; [8 bytes] Drill-briefing target palette: CycleDiagramTargetPaletteData copied here, colour 2 ($d834) replaced with the cycling colour, uploaded by LoadPaletteShadow
wBriefingTargetPalette:: ds 8
	export_size wBriefingTargetPalette
NEXTU
; character-select grid (banks $38/$10)
	ds 1
; [8-bit] Character-select grid: top row shown (wMenuCursorX/Y address the cell within it); MoveCharGridCursor* wrap it and rebuild the page sprite list
wCharGridPage:: db
; [8-bit] Character-select grid: number of pages, looked up from wCharGridEntryCount through CharGridPageCountTable
wCharGridPageCount:: db
; [8-bit] Character-select mode id stored on entry by RunExhibitionCharSelectScreen / RunLinkCharSelectScreen; picks the slot-box table and starting slot (3 and 5 start at slot 2)
wCharSelectMode:: db
; [8-bit] Character-select: player slot being chosen (0-3); $04 means every slot is filled and the screen shows the wait banner
wCharSelectSlot:: db
; [8-bit] Character-select result polled by the frame loop: 0 keep running, 1 finished, 2 cancelled out
wCharSelectExitCode:: db
; [4 bytes] Character id chosen per player slot ($ff = empty); read by ResolveSelectedCharIds and InitMatchCharsFromSelection. Bank $10's CopyExhibitionCharSlotIds copies it to wMatchSlotCharRefs when the screen is done
wCharSelectSlotChars:: ds 4
; [8-bit] Character-select grid: roster entries present from $da24 on (CountCharGridEntries)
wCharGridEntryCount:: db
; [8-bit] Character-select grid: page saved when a left/right wrap jumps to the roster pages
wCharGridPrevPage:: db
; [8-bit] Set to 1 by BuildCharGridFromUnlockFlags once the grid has been populated
wCharGridBuilt:: db
; [8-bit] Link character-select: slot the remote player is choosing; Advance/RetreatRemotePlayerSlot step it
wCharSelectRemoteSlot:: db
	ds 1
; [2 bytes] Link character-select: character ids the remote player has locked in (slots 2 and 3)
wCharSelectRemoteChars:: dw
; [8-bit] Link character-select: character id carried by the last received select command
wLinkSelectCmdChar:: db
; [8-bit] Link character-select slot bookkeeping, reset when a selection is retreated
wLinkSelectSlotState:: db
; [8-bit] Character-select grid: entries present in the nine created-character rows at $da00
wCharGridCreatedCount:: db
; [8-bit] Set when the slot just filled needs the CPU-difficulty submenu; the frame loop then runs RunCpuDifficultySubmenu instead of normal input
wCpuDifficultyPrompt:: db
; [8-bit] Set once OpenCpuDifficultyPanel has drawn the panel, so it is drawn only on the first pass
wCpuDifficultyPanelOpen:: db
; [8-bit] Cursor value in the CPU-difficulty submenu; stored into wCharSelectSlotDifficulty on confirm
wCpuDifficultyCursor:: db
	ds 9
; [4 bytes] CPU difficulty chosen per player slot; ApplyCpuDifficultyToCharRecords copies it into the match character records
wCharSelectSlotDifficulty:: ds 4
; [4 bytes] Left-handed flag per player slot, toggled with START on the grid (Mario-cast characters only). ApplyHandednessToCharRecords copies it to the match records' +$0e, which LoadCharacterAttributes turns into wCharMirrorAttrMask: OAM X-flip plus the forehand/backhand swap in SelectForehandBackhand
wCharSelectSlotLeftHanded:: ds 4
; [8-bit] Link character-select: result byte ProcessLinkSelectCommand leaves for commands $24-$27
wLinkSelectCmdResult:: db
; [8-bit] Link character-select: CPU difficulty for the link match, stepped by Unused_38_HandleLinkCpuDifficultyInput
wLinkCpuDifficulty:: db
NEXTU
; equipment select (bank $3e, $5400-$5c00)
; [8-bit] Number of entries BuildOwnedItemList put in wEquipItemList
wEquipItemCount:: db
; [8-bit] Index in wEquipItemList of the equipped item (the slot marked 2)
wEquipEquippedIndex:: db
; [8-bit] 0 while the screen is running; once a choice is made it counts up each frame and the screen fades out at $14
wEquipSelectExitTimer:: db
; [8-bit] 0 = rackets, 1 = shoes; selects the icon set, the info panel and which stat-modifier table GetItemStatModListPtr reads
wEquipItemKind:: db
; [8-bit] Which row-address table GetStatModRowAddr uses for the stat-modifier panel; both loaders set it to 0
wEquipStatRowSet:: db
NEXTU
; match results (bank $16)
; [8 bytes] Digit scratch PrintSinglesMatchStats / PrintDoublesMatchStats pass to PrintNumberRightAligned as bc
wStatsPrintBuffer:: ds 8
NEXTU
; minigame data screen (bank $1b, $73dd-$78bd)
	ds 2
; [9 bytes] One byte per list row, nonzero when that row's minigame has its level-2 clear flag; LoadMinigameStarFlags fills it from MinigameStarFlagsTable (the SAVEFLAG_CLEARED_*_2 run) as wMinigameDataClearFlags is filled. DrawMinigameStarMarks draws mark 1 per set row, DrawStarLegendMark draws the legend if any is set, and DrawMinigameHighScoreNumber shows no number for a row without a star
wMinigameDataStarFlags:: ds 9
	export_size wMinigameDataStarFlags
; [8 x 16-bit] The number shown on each of the first eight rows: LoadMinigameHighScores reads record row + 2 of the block $38 minigame records with ReadMinigameRecord (value in wMinigameRecordValue, WRAM bank $07) and stores it at row * 2. Row 8 has no record; its slot is wMinigameDataTwoOnOneCleared
wMinigameDataHighScores:: ds 16
; [2 bytes] Row 8's slot, used as a flag pair: LoadMinigameHighScores writes $01 to both bytes when SAVEFLAG_CLEARED_TWO_ON_ONE_3 is set (after clearing all 18 bytes from $d81b). DrawMinigameSpecialMark draws mark 2 for it when the list is scrolled to the bottom (wMenuCursorY = 4)
wMinigameDataTwoOnOneCleared:: dw
NEXTU
; trophies screen (bank $3b, $49e5-$4cfa)
	ds 2
; [6 bytes] The partner's second-set trophy row, from wN64TrophyCounts + 1 bits 2-3 and 6-7; drawn only when wTrophySecondSetPresent
wTrophyCellsPartnerSet2:: ds 6
	ds 1
; [8-bit] Set by DecodeTrophyCounts when any second-set count is nonzero. Picks screen asset record $0d over $0e and switches DrawTrophiesWonRows and the character sprites from two rows (main at tilemap row 8, partner at 10) to four (rows 6/8 and 13/15)
wTrophySecondSetPresent:: db
ENDU

	ds 1

; Bank $38's character-unlock array and bank $1b's ranking-banner
; animation share these 40 bytes.
UNION
; character unlock flags (bank $38)
; [40 bytes] One byte per character, nonzero when unlocked. BuildCharUnlockFlags clears it and walks CharUnlockFlagsTable0, marking a character whose entry is $ffff (always available) or whose save flag TestSaveFlag finds set. PackUnlockFlagsForLink packs it eight to a byte for the link exchange
wCharUnlockFlags:: ds 40
	export_size wCharUnlockFlags
NEXTU
; ranking board (bank $1b)
; [4 x 16-bit] Per animation channel, the ranking marker slot it moves, from hl in StartRankingMarkerAnim<N> (via GetRankingMarkerSlot). UpdateScriptedOffsetChannel<N> adds the script's delta each frame to the slot's +1 (X) on channels 0-1 and +2 (Y) on channels 2-3
wRankingAnimSlotPtrs:: ds 8
; [4 x 16-bit] Per channel, the delta script it plays, from de in StartRankingMarkerAnim<N>. One byte of movement per frame ($01 or $ff), ending at $40, where UpdateScriptedOffsetChannel<N> unregisters its frame task
wRankingAnimScriptPtrs:: ds 8
; [4 bytes] Each channel's offset into its script: zeroed by StartRankingMarkerAnim<N>, incremented by UpdateScriptedOffsetChannel<N> after each non-terminator byte (so also the frame counter)
wRankingAnimStepIndex:: ds 4
	ds 1
; [8-bit] Frame counter of the sliding banner sprite: RankingBoardAnimTask_1b indexes RankingBoardAnimTaskTable with it for the frame's X delta and unregisters at $87
wRankingBannerAnimFrame:: db
; [8-bit] X the banner sprite is drawn at, seeded to $a0 on frame 0 and advanced by the table delta every frame after
wRankingBannerX:: db
	ds 1
; [8-bit] Set to 1 at the end of each ranking-board animation state; the state machine advances on it
wRankingAnimStateDone:: db
	ds 1
; [8-bit] Set when ShowRankingBoard gets mode $03 (rewritten to $00): no entrance animation (DispatchRankingBoardAnim returns at once) and no closing jingle, for when the board is part of a longer sequence
wRankingBoardSilent:: db
	ds 5
; [7 bytes] Split buffer for a ranking name too long for one row. RenderPlayerNameFitted calls RenderNameTwoRows at six characters or more: RenderNameTopRow copies the first four characters here plus $2d ('-') and a terminator, RenderNameBottomRow copies seven bytes from the fifth character; each row is drawn from here by DrawNameWithDiacritics_1b
wRankingNameRowBuffer:: ds 7
	export_size wRankingNameRowBuffer
ENDU

	ds 152

; Screen-sized buffers three unrelated screens keep at the same addresses.
; Bank $3b's copy covers the whole span; the other two sit inside it.
UNION
; created characters and the character grid (bank $38)
; [$c0 bytes] Six $20-byte records for the player-created characters, built from the save by BuildCreatedCharRecords and walked by DrawCreatedCharStats. A first byte of $ff ends the list
wCreatedCharRecords:: ds 192
	export_size wCreatedCharRecords
	ds 64
; [$80 bytes] The character-select grid as 32 four-byte entries, cleared on screen open and filled by BuildCharUnlockFlags; AddCreatedCharsToCharGrid appends the created characters from $da24
wCharGridEntries:: ds 128
	export_size wCharGridEntries
	ds 128
NEXTU
; N64 transfer records (bank $3b)
; [512 bytes] Image of save block $0b (the N64 Transfer Pak records), read by ReadN64RecordsSaveBlock for the trophies screen and the ring-shot and star-victory grids. The screen's own copy of the block the bank $03 engine stages at wSaveBlockBuffer (WRAM bank $07)
wN64RecordsBlock:: ds 512
	export_size wN64RecordsBlock
NEXTU
; screen sequences (bank $18)
	ds 256
; [8-bit] Cleared as the ending sequence enters its third scene and stepped through the scenes that follow
wEndingSceneStep:: db
; [8-bit] Frame counter each PlayScreenSequence* routine runs from 0 to $fa while its screen scrolls, then fades out
wScreenSequenceTimer:: db
ENDU

; Chart rows for the bank $3b N64 exhibition and Mario-cast screens: sixteen
; rows of 17 bytes (a flag byte and sixteen cells), $110 in all, so the last
; row runs to $dc0f; wChartColumnList therefore begins at $dc01.
; chart rows (bank $3b)
; [256 bytes, of $110 used] The decoded chart. InitChartRowFlags writes 1 to the head of each row; BuildN64ExhibResultsGrid and DecodeN64ExhibResultsRow fill the cells from the N64 records block
wChartRows:: ds 256

; Screen state at $dc00: bank $17's rules screen and bank $3b's N64
; exhibition-data screen. (Bank $0d's minigame actor records sit at the same
; addresses in WRAM bank $04.)
UNION
; rules screen (bank $17)
	ds 1
; [8-bit] Rules page-list the screen shows, from a in ShowRulesScreen; MinigameRulesPageLoop indexes MinigameRulesPageLists_17 with it
wRulesPageListId:: db
; [8-bit] Value ShowRulesScreen returns once the page loop finishes
wRulesExitCode:: db
; [8-bit] Nonzero lets AdvanceRulesScreenAnimFrame run; cleared while a page transition is in progress
wRulesAnimEnabled:: db
; [8-bit] Frame counter AdvanceRulesScreenAnimFrame increments, wrapping at $ff
wRulesAnimCounter:: db
; [8-bit] 0 for the minigame rules (PrepareRulesPageTilemap then reads wRulesMinigameLevel), nonzero for match and training rules
wRulesIsMinigame:: db
; [8-bit] Copy of wMinigameLevel taken on entry, so the rules page matches the level being played
wRulesMinigameLevel:: db
	ds 13
NEXTU
; N64 exhibition and Mario-cast charts (bank $3b)
	ds 1
; [16 bytes] Column each chart row shows. BuildMarioCastChartColumnList fills it from MarioCastChartColumnTable, using $10 (blank column) for entries whose save flag is clear, so a locked character leaves a gap
wChartColumnList:: ds 16
	export_size wChartColumnList
	ds 1
; [8-bit] Page of the N64 exhibition-data screen; N64ExhibScrollArrowsTask picks the arrows from it
wN64ExhibPage:: db
; [8-bit] Cursor row within the page, stepped by ScrollN64ExhibDataCursor
wN64ExhibCursorRow:: db
NEXTU
; rules screen (bank $17)
; [8-bit] Frame AdvanceRulesScreenAnimFrame steps; DrawRulesScreenCharacters indexes RulesScreenCharactersTable0-2 with it
wRulesScreenAnimFrame:: db
ENDU

	ds 12

; Bank $3b's results-screen scratch: the exhibition victory grid's expanded cell bits, or the N64 records screen's ring-shot entry list.
UNION
; exhibition victory grid bits (bank $3b)
; [64 bytes] The victory grid's row bytes expanded one bit per byte by ExpandRowBytesToBits (clearing 4 x 16 bytes first); CombineExhibCellBits indexes it by the low nibble of b to fold cells back into bits
wExhibCellBits:: ds 64
	export_size wExhibCellBits
NEXTU
; ring-shot results (bank $3b)
	ds 32
; [16 bytes] Ring-shot rows to show, copied from the N64RingShot table; an entry becomes $10 (blank row) when its bit in the N64 records block is clear, leaving out courses never transferred
wRingShotEntryList:: ds 16
	export_size wRingShotEntryList
ENDU

	ds 416

; Character-grid scroll counter, bank $38.
; character select (bank $38)
; [8-bit] Incremented each time the grid scrolls down a row; the select screen prints it as a decimal byte at row 3, column 1 every frame (a leftover on-screen counter, no other reader)
wCharGridScrollCount:: db

	ds 255

; Character-select handedness, bank $38. The same address is the
; per-character match struct in WRAM banks $04-$07.
; character select (bank $38)
; [8-bit] Handedness the exhibition and link character grids offer for the highlighted character: 0 right, 1 left, 2 not yet chosen. START toggles it (`xor $01`, 2 becomes 1) only when IsMarioCastCharacter passes. DrawCharSelectSlotLabel picks label 30:150/151/152 ("START: Right-Handed" / "START: Left-Handed" / "START: Change Hands") from it. The story screen uses wCharSelectHandedness instead
wCharGridHandedness:: db
