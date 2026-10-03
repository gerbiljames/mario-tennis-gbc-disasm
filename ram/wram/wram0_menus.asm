; WRAM0 $cb00-$cfff: menu, cutscene, dictionary and link-screen state; the stack below $d000.

; [8-bit] Which story character record the character-select / name-entry / char-data screens act on: 0 = main, 1 = partner. A $40-stride index into the wStoryModeMainCharacter* / wStoryModePartnerCharacter* records (e.g. GetActiveStoryNameBuffer)
wStoryCharacterSlot:: db

; [8-bit] rSCX the LCD STAT handler applies inside a scanline band, giving the results and cutscene screens a horizontally offset strip. The credits and window-slide code reuse the next two bytes as a 16-bit camera offset while the STAT handler is off
wRasterScrollX:: db

; [8-bit] Scanline at which LCDStatHandler starts applying wRasterScrollX to rSCX -- the top of the split
wRasterScrollStartLY:: db

; [8-bit] Scanline at which rSCX goes back to 0. The win/lose screen, ending credits and intro cutscene each set their own band
wRasterScrollEndLY:: db

; [8-bit] Menu cursor column; MoveMenuCursorGrid_3b wraps it at the column count in b
wMenuCursorX:: db

; [8-bit] Menu cursor row; MoveMenuCursorGrid_3b wraps it at the row count in c
wMenuCursorY:: db

; [8-bit] Secondary menu cursor column (second selection region of the shared menu-input handler)
wMenuCursor2X:: db

; [8-bit] Secondary menu cursor row (parallel to wMenuCursorY)
wMenuCursor2Y:: db

; [8-bit] Menu cursor lock flags: bit 0 / bit 1 freeze the primary / secondary cursor (set on confirm) in the shared menu-input handler
wMenuCursorLockFlags:: db

; [8-bit] Animation step of the current tile set, advanced when wAnimatedTileTimer wraps; low nibble picks the frame
wAnimatedTileFrame:: db

; [8-bit] UpdateAnimatedTiles' frame counter: counts 0..wAnimatedTilePeriod-1, tiles step when it wraps to 0
wAnimatedTileTimer:: db

; [8-bit] Animated-tile set the UpdateAnimatedTiles frame task cycles ($00-$03, index into the pointer tables at $39:$4403/$440b). Set by the screens that install the task: 0 for the main menu, court diagram, bank $3b screens and link screens; 1 for the star-chart results and a few others; 2/3 on the match result screen for win/lose
wAnimatedTileSet:: db

; [8-bit] Frame period of the animated-tile task; usually $03 ($05 on a link screen, $06 on the match result screen)
wAnimatedTilePeriod:: db

; [8-bit] Menu loop's copy of hInputPressed (same bit layout as hPlayerInputFlags)
wMenuInputPressed:: db

; [8-bit] Match-format menu: singles (0) / doubles (1) selection; copied to wMatchIsDoubles
wMatchFormatDoubles:: db

; [8-bit] Match-format menu: games-per-set selection index; table-mapped to wMatchTypeNumberOfGames
wMatchFormatGames:: db

; [8-bit] Match-format menu: number-of-sets selection index (0-2); table-mapped to wMatchTypeNumberOfSets
wMatchFormatSets:: db

; [8-bit] Menu transition direction (1 = forward into a submenu, 0 = back), passed to the *SlideIn/*SlideOut transitions
wMenuSlideDirection:: db

; [2 bytes] Y of each scrolling menu-background lane; TickMenuBgScroll decrements both and wraps $b0 back to $a0
wMenuBgScrollY:: dw

; [8-bit] X shared by both lanes (passed in e to QueueSpriteTemplate)
wMenuBgScrollX:: db

; [2 bytes] Per-lane tile argument (c) for TickMenuBgScroll_SpriteTemplate
wMenuBgScrollTile:: dw

; [2 bytes] Per-lane attribute argument (b) for TickMenuBgScroll_SpriteTemplate
wMenuBgScrollAttr:: dw

; [8-bit] Which lane TickMenuBgScroll queues this tick; it alternates 0/1
wMenuBgScrollLane:: db

; [8-bit] Cheat-code button presses entered so far; indexes the 32-byte buffer at WRAM bank $01 $d000 (masked to $1f) that UpdateCheatCodeEntry compares with CheatCodeEntryTable. ResetCheatCodeBuffer zeroes both
wCheatCodeLength:: db

; [8-bit] Cell the main-menu cursor was last on, so the menu reopens there; RunMainMenu restores it with SetMenuCursorFromIndex_3b and saves it on exit. Cleared with the other saved cursors on a new game
wMainMenuCursor:: db

; [8-bit] Saved cursor cell for the saved-data source menu (RunSavedDataSourceSelect)
wSavedDataMenuCursor:: db

; [8-bit] Saved cursor cell for the N64 transfer item menu (RunN64TransferItemSelect)
wN64TransferMenuCursor:: db

; [8-bit] Saved cursor cell shared by the N64 record-type menu and the two court-select menus in bank $3e
wSubMenuCursor:: db

; [8-bit] Selected entry on the minigame-flags debug screen, passed to Unused_1b_UpdateUnlockDebugSelection by address
wUnlockDebugSelection:: db

; [8-bit] Minigame chosen on the minigame-select screen; RunMinigameModeFlow turns it into the config-table row (index * 3 + wMinigameLevel), RunMinigameRulesPages picks the rules pages from it
wSelectedMinigame:: db
	ds 1

; [8-bit] Zeroed with the other menu cursors when the main menu loop restarts; nothing reads it
wUnusedMenuCursor:: db
	ds 1

; [8-bit] Tab the racket/shoes choice menu was left on, so reopening it puts the cursor back
wRacketShoesTabIndex:: db

; [8-bit] The same for the saved-data type select
wSavedDataTypeTabIndex:: db

; [8-bit] Window handle of bank $1a's menu code, from CreateMenuWindowFromText or CreateWindow; passed to Unused_05_RunMenuSelectionShared, CloseWindow, WriteStringToWindow and GetWindowStructPtr
wPauseMenuWindowId:: db

; [8-bit] Preset cursor row for the next Unused_05_RunMenuSelectionShared: copied into the live row ($d830, WRAM bank $05) at menu open, then cleared so the default is row 0. Bank $1a stores the last selected row here before rebuilding the pause menu, and clears it when the menu closes for good
wMenuInitialRow:: db

; [8-bit] Menu rows on which LEFT/RIGHT adjust a value: bit 7 = mask present, bits 0-6 = one bit per row. Gates the menu driver's LEFT/RIGHT branch (Unused_05_IsCursorOnAdjustRow) and makes Unused_05_AnimateMenuScrollArrowsTask draw the arrows on that row. Bank $1a sets $83 (rows 0-1) for the pause menu and $8c (rows 2-3) for the minigame pause menu
wMenuAdjustRowMask:: db

; [8-bit] Menu rows that do not close the window when chosen (encoding as wMenuAdjustRowMask): bank $1a skips CloseWindow after Unused_05_RunMenuSelectionShared when the chosen row's bit is set. Same values as wMenuAdjustRowMask
wMenuKeepOpenRowMask:: db

; [8-bit] Pause-menu options state: low nibble = toggle bits the music/sound rows flip, bit 5 gates Unused_1a_DrawPauseMenuSettingValues, bits 6-7 set once a row has been visited. Cleared by Unused_1a_ResetPauseMenuState
wPauseMenuOptionBits:: db

; [8-bit] Set as the pause menu opens and read by Unused_1a_RunMinigameModePauseMenu, so the shared window knows which pause menu it runs
wPauseMenuIsMinigame:: db

; [8-bit] Nonzero builds the minigame pause menu without setting FLAG_MINIGAME_PAUSE_MENU_OPEN, which keeps the scroll-arrow task off
wSuppressMinigamePauseFlag:: db

; [8-bit] Tennis Dictionary (bank $3f): first entry shown in the 6-row term list. Selected entry = (this + wTennisDictCursorRow) mod wTennisDictEntryCount (GetTennisDictionarySelectedIndex). Wrapped when the cursor runs off the top/bottom, recomputed by ScrollTennisDictionaryToPrevLetter/NextLetter, the render start for DrawTennisDictionaryList; cleared on entry
wTennisDictScrollTop:: db

; [8-bit] Tennis Dictionary: cursor row within the visible page, 0-5 on the term list (scrolling wTennisDictScrollTop past the ends) and 0-8 on the category index page. Drives the highlight row (DrawTennisDictionaryIndexCursor, 4 tilemap rows per step) and the hand-cursor sprite Y ($10 px per step); reset by the page-jump helpers
wTennisDictCursorRow:: db

; [8-bit] Tennis Dictionary: entries passing the category filter, counted by CountTennisDictionaryEntries over SelectionMaskGrid_3f (AND wTennisDictCategoryMask, up to the $40 terminator); the wrap modulus for the scroll
wTennisDictEntryCount:: db

; [16-bit] Address of the $40 terminator FindTennisDictionaryListEnd found in the selection grid, stored high byte first (+$00 = h, +$01 = l). WrapTennisDictionaryScanToEnd reads it to wrap a scan to the last entry
wTennisDictListEnd:: dw

; [8-bit] Tennis Dictionary: category filter mask, from the screen mode: $01/$02/$04/$08/$10 for modes 0-4, $1f (all) otherwise. Every list walk ANDs it with the entry's category byte in SelectionMaskGrid_3f
wTennisDictCategoryMask:: db

; [8-bit] Set to 1 in the two Tennis Dictionary modes ($05, $06) that show one fixed entry instead of the list; the description path then skips GetTennisDictionarySelectedIndex
wTennisDictSingleEntry:: db

; [8-bit] Tennis Dictionary: the mode passed in a to TennisDictionaryScreen. Modes 0-5 set the category mask and open the term list; mode 6 (the only one the game uses) opens the 9-cell category index page, and B returns $10 instead of $01
wTennisDictMode:: db
	ds 2

; [8-bit] Tennis Dictionary display flags, cleared on entry. Bit 0 = a description window is open (freezes the hand-cursor animation). Bit 1 = the term list is on screen (gates the cursor sprites, shifts the index-page sprites $10 px). Bits 2/3 = flash the left/right page arrow this frame, set on LEFT/RIGHT, drawn by UpdateTennisDictionarySprites_SpriteTemplate0 and cleared every input tick
wTennisDictFlags:: db

; [8-bit] Tennis Dictionary mascot animation state: 3 and 4 alternate when wTennisDictAnimTimer expires; StartTennisDictionaryAnim restarts it from the VBlank counter's low bits so the pose varies
wTennisDictAnimState:: db

; [8-bit] Eight-frame divider for the Tennis Dictionary demo sprite: UpdateTennisDictionarySprites counts it down, reloads $08 and steps wTennisDictSpritePhase at zero
wTennisDictSpriteTimer:: db

; [8-bit] Phase 0-15 of the Study Vocabulary demo sprite animation, wrapped at $10
wTennisDictSpritePhase:: db
	ds 2

; [8-bit] Frames left in the current wTennisDictAnimState: $b4 on a restart, $ff for the long idle
wTennisDictAnimTimer:: db

; [8-bit] Second Tennis Dictionary animation counter, stepped only while wTennisDictFlags bit 1 is set and bit 0 clear; seeded by TennisDictionaryScreen
wTennisDictScrollTimer:: db

; [8-bit] Bank $6b cutscene driver (intro/title/award ceremony): current step index, dispatched through the per-scene jumptable
wCutsceneStep:: db

; [8-bit] Bank $6b cutscene driver: frame counter for the current step, compared with per-step thresholds to advance wCutsceneStep
wCutsceneStepTimer:: db

; [8-bit] Intro Cutscene Check (0x00 when in intro cutscene, 0x01 otherwise)
wIntroCutsceneCheck:: db

; [8-bit] Bank $6b cutscene driver: accumulated horizontal pan position, copied to hScrollX each frame
wCutsceneScrollX:: db

; [8-bit] Sub-state within the intro cutscene state; seeded by the State*Init routines, stepped by State*Update
wIntroCutsceneSubState:: db

; [8-bit] X of the intro cutscene's first sprite group; moved by the state Update routines, added to each template offset by QueueCutsceneSpriteGroupA
wCutsceneSpriteAX:: db

; [8-bit] Y of the intro cutscene's first sprite group
wCutsceneSpriteAY:: db

; [8-bit] X of the intro cutscene's second sprite group (QueueCutsceneSpriteGroupB)
wCutsceneSpriteBX:: db

; [8-bit] Y of the intro cutscene's second sprite group
wCutsceneSpriteBY:: db

; [16-bit] Intro cutscene scroll position: UpdateCutsceneScrollY subtracts the frame's CutsceneScrollYTable entry from it; QueueScrollingSprite places sprites against it
wCutsceneScrollAccum:: dw

; [16-bit] Intro cutscene (bank $6b) world-space vertical camera position. Set to $0120 at the start of scenes 00/12/19 and decremented each frame from the delta table at $6b:$4cc1 indexed by wCutsceneStepTimer. ApplyCutsceneScrollToSpriteX subtracts it from QueueSpriteTemplate's Y coordinate (the sp+0 slot, despite the routine's name); SetCameraYFromScrollPos shifts it left 5 into wCameraY; ($cb48 - $cb4a) is the on-screen Y of QueueIntroSpriteBlock's object
wIntroCutsceneScrollY:: dw

; [8-bit] Frame the intro cutscene's scrolling sprites draw with: bits 4-5 of wCutsceneSpriteAnimTick, so it steps every 16 ticks
wCutsceneSpriteAnimFrame:: db

; [8-bit] Free-running counter incremented by AdvanceSpriteAnimTimer; cleared with wCutsceneSpriteAnimFrame by the intro state inits
wCutsceneSpriteAnimTick:: db
	ds 1

; [8-bit] Idle-animation state of the character-select portrait, cleared with wCharSelectIdleTimer and wCharSelectHandedness and stepped by TickCharSelectIdleAnim when the timer expires
wCharSelectIdleAnimState:: db

; [8-bit] Story character select (bank $38): handedness, 0 = default, 1 = mirrored (left-handed). Cleared on entry, flipped by START (prompt text 30:118 "START: Change Hands"). When set, DrawCharacterSelectChars sets OAM X-flip in wCharSpriteSlot+1 for the four shown characters and DrawCharacterSelectCursor uses tile base $00 instead of $02. Stored into the story character record at +$0e
wCharSelectHandedness:: db

; [8-bit] Frames until the character-select portrait idles: TickCharSelectIdleAnim counts to $0f, switches the character from animation 5 to 7 and restarts
wCharSelectIdleTimer:: db

; [8-bit] Story character select (bank $38): 0 = picking the main character, 1 = the partner; the b argument of RunCharacterSelectScreen. Picks the prompt (30:117 "Pick a Character" / 30:119 "Choose Partner"), mugshots 2/3 and the sprite positions, and the character id = 2 * this + cursor
wCharSelectIsPartner:: db

; [8-bit] Court select: the link partner's bonus-court unlock mask, from the received link block ($ca8a or $ca0a by hLinkState) after the block-$26 exchange that sends wUnlockedCourtMask; cleared for local play. ORed with wUnlockedCourtMask before StoreCourtUnlockBits and the 9-court vs 4-court menu choice
wLinkPartnerCourtMask:: db

; [8-bit] Bitmask of the five bonus courts (ids 4-8; 0-3 are always open, IsCourtUnlocked), built from save flags by ComputeUnlockedCourtFlags from the 5-entry table at $3e:$69ca. StoreCourtUnlockBits expands it into five per-court bytes at $d000 in WRAM bank $02; it also picks the 9-court or 4-court select menu and is the payload of link block $26
wUnlockedCourtMask:: db

; [4 bytes] The other Game Boy's packed unlock flags, received by the ExchangeLinkDataBlock that sends wLinkUnlockFlagsSend. MergeLinkUnlockFlags gives both sides the union
wLinkUnlockFlagsRecv:: ds 4
	export_size wLinkUnlockFlagsRecv

; [4 bytes] This side's unlock flags, packed one bit per character by PackUnlockFlagsForLink before the exchange
wLinkUnlockFlagsSend:: ds 4
	export_size wLinkUnlockFlagsSend

; [8-bit] One bit per Mario-cast grid slot, built by BuildMarioCastUnlockMask; GetUnlockedMarioCastCharAtGridSlot skips locked slots with it
wMarioCastUnlockMask:: db

; [8-bit] Actor slot SpawnCompanionActor fills: 3 in doubles, $ff in singles (skip attaching the step-mover)
wCompanionActorSlot:: db

; [8-bit] Written as RunStoryModeOverworld starts; nothing reads it
wOverworldEnterFlag:: db

; [8-bit] Frame counter of bank $03's scrolling story cutscene. AnimateWindowSlideUpTask increments it and sets rWY to $90 minus its low 6 bits; UpdateSceneAnimation steps the animation frame on its low 2 bits
wCutsceneSlideTimer:: db

; [8-bit] Dirty flags for the bank $18 BG map shadow buffers: low nibble queues the $d800 -> $9800 tilemap copy, high nibble the $dc00 -> VRAM1 $9800 attribute copy; cleared by Unused_18_FlushBgMapShadowToVram
wBgMapShadowDirty:: db

; [8-bit] Debug character viewer (Unused_1a_RunDebugCharViewer): page of the 2x16 character grid, 0 or 1, stepped when the cursor wraps off the bottom/top row. Selected character id = (page << 4) + wDebugCharViewerIndex, stored to $d002 and passed to LoadOnCourtCharTilesA
wDebugCharViewerPage:: db

; [8-bit] Debug character viewer: cursor 0-15 within the page; LEFT/RIGHT step 1 and wrap in the row of 8, UP/DOWN step 8 and roll into wDebugCharViewerPage. Also indexes the cursor-sprite position table at $1a:$6b0f
wDebugCharViewerIndex:: db

; [7 bytes] Per-digit working bytes for the number-sprite drawer, cleared by InitNumberSpriteGfx alongside wDigitSpriteTileBase and wDigitSpriteAttr
wDigitSpriteSlots:: ds 7
	export_size wDigitSpriteSlots

; [8-bit] First tile of the loaded digit sprite set; DrawDigitSprite_39 uses digit * 2 + this, so the narrow and wide digit sets share one drawer
wDigitSpriteTileBase:: db

; [8-bit] OAM attribute DrawDigitSprite_39 queues digits with
wDigitSpriteAttr:: db

; [8-bit] Scene selector RunStorySceneByMode stores from c; each LookupScreen<N>AssetId indexes its Screen<N>AssetIdTable with it
wStorySceneAssetIndex:: db

; [16-bit] Rules/briefing screens: base text id of the minigame's rules pages, from MinigameRulesTextIdBases_17. Each page offset from the minigame's MinigameRulesPageLists_17 row is added to it and rendered with PrepareGlyphBuffer / RenderProportionalTextAt
wRulesPageTextIdBase:: dw

; [8-bit] Written twice by RunMinigameSelect; nothing reads it
wMinigameSelectUnused:: db

; [8-bit] Set to 1 once the cheat code matched and TriggerCheatUnlock ran; UpdateCheatCodeEntry then ignores input. Cleared when the title and main-menu loops re-enter
wCheatUnlockTriggered:: db

; [8-bit] Frames the link character-select screen waits before it accepts input; WaitLinkSelectStartupFrames counts it down
wLinkSelectStartupFrames:: db

; [8-bit] Stage of RunMatchWinLoseScreen, set as the screen opens and branched on twice
wMatchWinLoseState:: db

; [8-bit] Sub-state of the first match-select handler, set on two paths and read back once
wMatchSelectSubState:: db

; [8-bit] Next window tile id the text engine stamps into the shadow tilemap. A row starts at wGlyphRowStartCol + $80 and the cell loop increments it per cell, so a wrapped row continues where the previous one stopped
wTextRowNextTile:: db

; [16-bit] VRAM tile-data write pointer for the proportional-glyph renderer (bank $05 text engine)
wGlyphTileWritePtr:: dw

; [8-bit] Nonzero when the text belongs to a window other than wMenuWindowId; StampGlyphTileAtPen writes glyph tiles through wGlyphTileWritePtr only then. Menu text goes through the tilemap alone
wGlyphStampEnabled:: db
	ds 119

; [8-bit] Court-scene graphics still to queue; the loader decrements it each pass and stops once it hits zero
wCourtSceneGfxStepsLeft:: db

; [8-bit] Byte offset into CameraFromPlayerSpriteList, advanced 4 (one record) at a time and wrapped to 0 at a $ff record
wCourtSceneGfxCursor:: db
	ds 14

; [576 bytes] Debug text console tilemap buffer, DMAed to $9d00 rows when active
wDebugTextBuffer:: ds 576
	export_size wDebugTextBuffer

; The top of WRAM0, shared by the serial link's nibble staging and the
; character-select roster, which never run together.
UNION
; serial link nibble staging (bank $07)
; [96 bytes] The block being exchanged, one nibble per byte (at most $5f nibbles). UnpackBytesToNibbles fills it from wLinkByteBuffer and PackNibblesToBytes folds it back
wLinkNibbleBuffer:: ds 96
; [48 bytes] The packed form of the same block, two nibbles per byte, which the caller reads and writes
wLinkByteBuffer:: ds 48
	ds 48
NEXTU
; character select roster (bank $1b)
; [128 bytes] Copy of CharSelectRosterTable, the grid of character ids the select screen and the unlock-debug screen page through; searched by Unused_1b_FindCharSelectRosterEntry, walked by Unused_1b_DrawCharSelectMugshots
wCharSelectRoster:: ds 128
	export_size wCharSelectRoster
ENDU
