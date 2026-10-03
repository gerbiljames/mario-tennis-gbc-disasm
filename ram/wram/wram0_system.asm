; WRAM0 $c000-$c3ff: OAM and VRAM queues, timers, palettes, frame tasks, story location and camera state.

SECTION "WRAM0 $c000", WRAM0[$c000]

; [160 bytes] Shadow OAM: 40 x 4-byte entries [y, x, tile, attr], copied to $fe00 every frame by hOAMDMARoutine. Cleared on its own by the boot path; only written through pointers
wShadowOAM:: ds 160
	export_size wShadowOAM

; [80 bytes] VBlank VRAM copy queue: 10 x 8-byte entries [rom bank (0 = slot free), wram bank, src hi, src lo, vbk, dest hi, dest lo, length in 16-byte blocks - 1]. ProcessVRAMCopyQueues banks in the source, writes +$02..+$06 to $ff51-$ff54 and rVBK, starts the transfer by writing +$07 to $ff55, and clears +$00
wVRAMCopyQueue:: ds 80
	export_size wVRAMCopyQueue

; [4 bytes] Play timer: frames (0-59), seconds, minutes, hours (caps at 99)
wGameTimer:: ds 4

; [8-bit] Enables wSecondaryTimer: UpdateGameTimer ticks it only while this is exactly 1. The unused countdown at $00:$240a writes $ff here when its clock runs out ($ff = expired)
wSecondaryTimerMode:: db

; [3 bytes] Second clock, ticked by Unused_00_TickSecondaryTimer: frames (0-59), seconds, minutes. Saturates at 9:59. The unused countdown at $00:$240a runs it downwards, sound $af each second and sound $b0 at zero
wSecondaryTimer:: ds 3

; [8-bit] Width in pixels of the glyph Unused_00_RenderGlyphToTiles is drawing (glyph byte 0); the per-column loop count. The caller re-reads the byte afterwards to advance the pen
wGlyphBlitWidth:: db

; [8-bit] Rows left to draw in Unused_00_RenderGlyphToTiles, from glyph byte 1
wGlyphBlitRowsLeft:: db

; [8-bit] Destination bit mask for Unused_00_RenderGlyphToTiles, PixelMaskTable[penX & 7], rotated right per pixel; the $01 -> $80 wrap advances to the next tile column
wGlyphBlitDestMask:: db

; [5 bytes] Last frame's peak LY as four hex digits; written by AdvanceFrame, copied to $9d08 by UpdateDebugOverlay
wDebugPeakLYText:: ds 5

; [64 bytes] Live BG palettes, uploaded in VBlank when hPaletteDirtyFlags bit 0 is set
wBGPalettes:: ds 64

; [64 bytes] Live OBJ palettes, uploaded in VBlank when hPaletteDirtyFlags bit 1 is set
wOBJPalettes:: ds 64

; [64 bytes] VBlank single-tile write queue: 16 x 4-byte entries [addr hi, addr lo, tile (VBK0), attr (VBK1)]
wTileWriteQueue:: ds 64

; [64 bytes] Frame task list: 4-byte records [id, ptr lo, ptr hi, rom bank] of banked callbacks run each frame (RegisterFrameTask / ClearFrameTasks)
wFrameTasks:: ds 64
	export_size wFrameTasks

; [128 bytes] Master palette copy (BG+OBJ); fades scale this into wBGPalettes/wOBJPalettes
wMasterPalettes:: ds 128
	export_size wMasterPalettes

; [8-bit] Story Mode - Current Location
;
; 0x00 - Not in Story Mode
; 0x05 - Academy Main Building
; 0x06 - Academy Wing
; 0x07 - Courtyard
; 0x08 - Restaurant Plaza
; 0x09 - Dorm Entrance
; 0x0a - Dormitory
; 0x0b, 0x0c - Junior Class Court
; 0x0d - Restaurant
; 0x0e - Cafeteria
; 0x0f - Training Court
; 0x10 - Senior Class Court
; 0x11 - Training Center
; 0x12 - Tennis Machine Room
; 0x13 - Wall Practice Room
; 0x14 - Academy Entrance
; 0x15 - Tournament Courtyard
; 0x16 - Court #1
; 0x17 - Court #2
; 0x18 - Center Court
; 0x19 - Tournament
; 0x1a - Awards Ceremony
; 0x1b - Plane Cutscene
; 0x1c - Special Court
; 0x1d - Peach's Castle
; 0x1e-0x29 - Final Credits Sequence
;
; 0x01-0x04 are debug maps (STORYLOC_* in include/constants/ has every id; one StoryLocationTable_0a record each). The location popup's text id is $0179 + id (LoadStoryLocationHeader)
wStoryModeCurrentLocation:: db

; [8-bit] Scene id of the loaded story location (story_location byte 1); passed to LoadStorySceneGraphics, which indexes SceneGfxSlotTable with it
wStoryLocationScene:: db

; [2 bytes] The location's map_scripts reference from its story_location record, in dslot encoding: slot offset into the bank's $4000 directory, then ROM bank. LoadStoryLocationHeader copies the bank to wStoryLocationBank and the resolved 7-word map_tree to wMapEntryPointsPtr
wStoryLocationMapScriptsSlot:: dw

; [8-bit] BGM id from the location's story_location record; $ff keeps the current music, anything else goes to PlaySoundManaged on load
wStoryLocationBGM:: db
	ds 1

; [16-bit] map_tree slot 0: the map_entry spawn table. LoadStoryEntryPointRecord searches it for wStoryModeEntryPoint, falling back to the first record
wMapEntryPointsPtr:: dw

; [16-bit] map_tree slot 1: the map_script table RunLocationExit searches
wMapExitTriggersPtr:: dw

; [16-bit] map_tree slot 2: the map_actor spawn list, passed to InitLocationActors
wMapActorsPtr:: dw

; [16-bit] map_tree slot 3: the map_script table RunNpcInteraction searches
wMapNpcScriptsPtr:: dw

; [16-bit] map_tree slot 4: the map_script table RunFacingTileScript searches
wMapFacingScriptsPtr:: dw

; [16-bit] map_tree slot 5: the step-on trigger table searched by RunTileTriggerScript and RunQueuedTriggerScript
wMapTileTriggersPtr:: dw

; [16-bit] map_tree slot 6: the location's init code, run by RunLocationInitScript
wMapInitScriptPtr:: dw

; [8-bit] Write-only mirror of wStoryModeExitTriggerRequest: every store writes both, nothing reads this one
wUnusedExitTriggerIdMirror:: db

; [8-bit] Entry point / spawn-door id for the location being loaded; $ff = none (keep the saved position). LoadStoryEntryPointRecord searches the entry table with it
wStoryModeEntryPoint:: db

; [5 bytes] Player spawn/return buffer: X (16-bit), Y (16-bit), facing. Filled from the matched entry-point record, or backed up from wStoryModePlayersXPosition before a submode
wStoryModeSpawnPosition:: ds 5
	export_size wStoryModeSpawnPosition

; [8-bit] ROM bank of the current location's header and script data (high byte of the far pointer at $c282), set by LoadStoryLocationHeader. LoadStoryEntryPointRecord, FindStoryScriptEntry, GetTileTriggerAtPlayer, RunNpcInteraction, RunLocationExit etc. pass it to FarReadByte or a farcall
wStoryLocationBank:: db

; [16-bit] The entry point's arrival_script (map_entry bytes 6-7), called in wStoryLocationBank once the LCD is back on; 0 = none
wStoryArrivalScript:: dw
	ds 2

; [8-bit] Queued tile trigger-script id (high nibble of a behavior-map cell whose low nibble is 1); nonzero makes the overworld loop run RunQueuedTriggerScript
wStoryModeTriggerScript:: db

; [8-bit] Nonzero requests leaving the location loop (RunLocationExit + reload); cleared with $c2a0-$c2a5 by ClearStoryEventRequests. The value is an exit-trigger id, not a location: RunLocationExit matches it against the id column of map_tree slot 1, and that row's arg0 is the destination STORYLOC_* id, so one id leads to different places per location
wStoryModeExitTriggerRequest:: db

; [8-bit] Set to 1 by the overworld player-move code ($04:$52a6) when the point ahead of the player has a nonzero behaviour value. The location event loop consumes it; together with wPlayerMoving reaching $1e frames at an unchanged angle it turns walking into a door or sign into an interaction
wStoryAutoInteractArmed:: db

; [8-bit] $ff once the auto-interact has raised wStoryModeInteractRequest this frame, else 0. Read only by the debug-menu check later in the frame, which then stands down
wStoryAutoInteractFired:: db

; [8-bit] Set to 1 on an A press in the overworld; the event loop then tries NPC interaction (FindActorFacingPlayer), facing-tile script, and tile trigger
wStoryModeInteractRequest:: db

; [8-bit] Set to 1 on a Start press in the overworld; opens RunStoryModeMenu
wStoryModeMenuRequest:: db
	ds 10

; [8-bit] Scene stage of the loaded location, derived from save flags by the map's init script (SetupCenterCourtSceneVariant, InitCourt1SceneVariant, ComputeIslandOpenRound, ComputeRankingProgressIndex_27, ...). NPC scripts index per-stage text-id tables with it. Values are per location. First byte of the $c2b0-$c2bf per-location scratch block
wMapSceneStage:: db

; [8-bit] Second per-location scene stage, set by map init scripts (CafeteriaInitScript_10, RestaurantInitScript_10, TrainingCourtReentryDispatch, the challenger result scenes) and read by that location's NPC scripts to pick a text id
wMapSceneStage2:: db

; Per-location scratch, rest of $c2b0-$c2bf. Bank $14's island cutscenes
; keep two sprite slots here as parallel byte arrays, and bank $15's
; water-sprite swing contest keeps 16-bit counters over the same bytes;
; elsewhere it is generic scratch (the default variant).
UNION
; island cutscene sprite slots (bank $14, $5300-$7900)
; [2 bytes] World X of cutscene sprite slots 0 and 1; drawers subtract hScrollX for OAM X. The plane sequence uses slot 0's byte as its frame counter (AdvancePlaneFrameCounter_14)
wCutsceneObjX:: dw
; [2 bytes] World Y of the two cutscene sprite slots
wCutsceneObjY:: dw
; [2 bytes] Animation phase per slot (splash rise/fall step, firework burst step); indexes the frame tables
wCutsceneObjPhase:: dw
; [2 bytes] Per-slot frame timer: the splash's hit counter (0-8), the firework's countdown to the next burst frame
wCutsceneObjTimer:: dw
; [2 bytes] Per-slot phase limit, rerolled from the RNG when a splash respawns
wCutsceneObjLimit:: dw
; [2 bytes] Frames left in the rise, counted down by AdvanceWaterSplash0Rise_14 / AdvanceWaterSplash1Rise_14, which also lift wCutsceneObjY by 2 per frame
wCutsceneObjRiseTimer:: dw
; [2 bytes] Per-slot active flag; 0 = still rising, hit test skipped
wCutsceneObjActive:: dw
NEXTU
; water-sprite swing contest (bank $15)
	ds 2
; [16-bit] Frames left in the swing contest; WaterSpriteSwingCountTask counts it down and ends the contest at 0
wSwingContestTimer:: dw
; [16-bit] Swings counted, incremented per A/B press and printed by PrintHexWord
wSwingContestSwings:: dw
; [8-bit] Previous frame's A/B state, so one press counts once
wSwingContestPrevInput:: db
; [8-bit] 2 when a swing registers, 1 the frame after; triggers the swing animation once
wSwingContestSwingState:: db
; [8-bit] Which HUD panels QueueWaterSpriteMinigameHudPanels draws
wSwingContestHudMode:: db
; [8-bit] HUD page shown; seeded by InitWaterSpriteMinigameHud, panels queued by QueueWaterSpriteMinigameHudPanels
wSwingContestHudPage:: db
NEXTU
; Training Court challenger dialogue ids (bank $15, $5d00-$6400)
; [16-bit] Each challenger result scene writes its court's lose-dialogue text id here ($201d serve, $204a net, $2078 stroke) on a lost point, one slot below the ids the handlers read. Nothing reads it; the live copy is wChallengerLoseTextId
wUnusedChallengerLoseTextId:: dw
; [16-bit] Lose-dialogue text id seeded per court by the challenger setup scenes; the result handler's .lose arm passes it to InitDialogueTextCursor
wChallengerLoseTextId:: dw
; [16-bit] Win-dialogue text id, read by the result handler's finish arm
wChallengerWinTextId:: dw
; [16-bit] Draw-dialogue text id, read by the result handler's draw arm
wChallengerDrawTextId:: dw
; [16-bit] Follow-up dialogue text id spoken after the verdict line; overlaps the swing contest's two HUD bytes
wChallengerFollowupTextId:: dw
NEXTU
; generic location scratch
; [14 bytes] Rest of the location's scratch block after wMapSceneStage / wMapSceneStage2. Story scripts in banks $0e-$13 use it for whatever the location needs (a saved actor position, a name for a text argument, menu working bytes); the fixed-layout overlays are the variants above
wMapScratch:: ds 14
ENDU

; [8 bytes] Staging copy of one map-table record, far-copied from wStoryLocationBank after FindStoryScriptEntry finds it. A map_entry gives facing at +1, X and Y at +2 and +4, arrival_script at +6; a map_script gives the flag condition at +2, the handler at +4 and two argument bytes at +6/+7 (RunLocationExit reads them as destination location and entry point)
wStoryMapRecord:: ds 8
	export_size wStoryMapRecord
	ds 8

; [16-bit] Story Mode - Player's X Position
wStoryModePlayersXPosition:: dw

; [16-bit] Story Mode - Player's Y Position
wStoryModePlayersYPosition:: dw

; [8-bit] Player's overworld facing (FACE_*), copied by UpdateActors from the player actor's $d032 alongside X/Y
wStoryModePlayerFacing:: db

; [8-bit] Nonzero shows the location-name popup after fade-in (set when wStoryModeEntryPoint != $ff)
wStoryModeShowLocationName:: db

; [16-bit] Text id of the location's name, passed in hl to ShowLocationNamePopup when wStoryModeShowLocationName is set
wStoryModeLocationNameTextId:: dw

; [8-bit] The talked-to actor's +$19 byte, saved by RunNpcInteraction while it forces it to 1 for the script, restored afterwards
wStoryScriptSavedActorBusy:: db

; [8-bit] The talked-to actor's +$2e animation, saved by RunNpcInteraction when the handler's arg0 has bit 3 set and restored with SetActorAnimationChecked afterwards
wStoryScriptSavedActorAnim:: db

; [8-bit] Set to 1 by RunStoryScriptOrDialogue when it dispatches a location script; the overworld loop clears it before checking interactions and stops looking for triggers this frame once set
wStoryScriptRan:: db

; [8-bit] Write-only: RunNpcInteraction, RunFacingTileScript, RunQueuedTriggerScript and RunLocationExit store the id they look up; nothing reads it
wUnusedStoryScriptId:: db
	ds 4

; [8-bit] Frames left before a drill point gives up: UpdateDrillAbortCountdown decrements it while wDrillAbortCountdownActive is set and wPointOutcome is 0, setting wMatchAbortFlag at 0. Point start loads $0a
wDrillAbortCountdown:: db

; [8-bit] Nonzero enables wDrillAbortCountdown; cleared at point start, set once the drill waits for the point-ending shot
wDrillAbortCountdownActive:: db

; [8-bit] Cleared by ServiceMatch2Hook_PointStart and read by nothing
wUnusedDrillPointStartByte:: db

; [8-bit] Why the coach's drill ended, written by each ServicePractice*/NetGamePractice* EvaluateResult (0 = passed, 1 = no points won, 2 = double fault, 3 = target missed, 4+ = partial, offset by wStoryModeMainCharacterLeftHanded). The bank $15 training-court coaches pick their follow-up dialogue on it
wDrillLessonResult:: db

; [8-bit] One bit per point of the drill, set by RecordDrillTargetZoneHit when the ball bounced inside the target zone; CountDrillResultBitsSet and CheckDrillTargetZoneMissed read it back
wDrillTargetZoneHitBits:: db

; [8-bit] One bit per point of the drill, set by RecordGateCrossOnServe when the serve passed through the gate; counted by CountDrillResultBitsSetAlt
wDrillGateCrossBits:: db

; [8-bit] Queued drill message: index into DrillMessageTextIds_0b, $ff = none. Set by the Queue*/Set*Message helpers from the point outcome and server; ShowQueuedDrillMessage defaults it to $6c and shows it
wDrillMessageId:: db

; [9 bytes] Per-drill counters. Each drill's hooks clear the ones they need at MinigameStart/PointStart and increment them by address ($c2ex); successful-shot counts go to wPlayer1PointsWon/wPlayer2PointsWon at point end, and EvaluateResult compares them against 4 (shots per drill)
wDrillCounters:: ds 9
	ds 8

; [2 bytes] Indexed by wCurrentServingPlayer: 0 until the serve has been judged, then +1/-1 from CheckDrillTargetZoneMissed
wDrillServeTargetResult:: dw
	ds 2

; [2 bytes] Two bits per shot of the point, one byte per side. RecordDrillPointResultBits rotates wPointWinLoseFlag into the byte DrillPointResultBitsTable selects; CountDrillShotSuccesses counts pairs equal to 1; bank $06's DrawScoreboardPackedPips draws them as pip rows
wDrillShotResultBits:: dw
	ds 1

; [8-bit] Judgement of the current drill point, 0 until judged. JudgeShot0-3 store their JudgePoint result; JudgePoint returns early while it is nonzero, so the first judgement wins
wDrillPointJudgement:: db

; [32 bytes] One tilemap row of CGB attributes, sent to VRAM bank 1 at wBGRowBlitDest by ProcessBGBlitQueue (VRAM DMA) when hBGRowBlitPending is set
wBGRowBlitAttrs:: ds 32

; [16-bit] BG scroll-buffer camera X
wCameraX:: dw

; [16-bit] BG scroll-buffer camera Y
wCameraY:: dw

; [8-bit] wCameraX's high byte at the previous UpdateSceneScroll; a change means the camera crossed a tile boundary and a new BG column (left or right) is blitted in from the 64-wide map
wCameraTileXPrev:: db

; [8-bit] wCameraY's high byte at the previous UpdateSceneScroll; row counterpart of wCameraTileXPrev
wCameraTileYPrev:: db

; [16-bit] Tilemap address for the queued BG row blit
wBGRowBlitDest:: dw

; [8-bit] Tilemap column for the queued BG column blit
wBGColumnBlitX:: db

; [8-bit] Lowest camera X (in tiles) the overworld scroll clamp allows; set to 0 by InitSceneScroll
wMapScrollMinX:: db

; [8-bit] Lowest camera Y (in tiles) the overworld scroll clamp allows
wMapScrollMinY:: db

; [8-bit] Map width in tiles; the camera X clamp is this minus $14 (screen width)
wMapWidthTiles:: db

; [8-bit] Map height in tiles; the camera clamp stops at this minus $12 (18 rows)
wMapHeightTiles:: db

; [8-bit] Entry count of the list a side-scrolling menu shows; RunMenuSelection and the scene viewer derive a page count from it (four entries a page). InitSceneScroll sets $25
wScrollListLength:: db

; [8-bit] Current story-cutscene scene index; indexes SceneGfxSlotTable (index*16), used by Unused_0a_LoadAndDisplayScene / InitSceneTileAnimations
wCurrentScene:: db
	ds 1

; [8 bytes] Four scene tile-animation slots, 2 bytes each: current offset into the animation script at $05:$da88, then frame countdown. The scroll task calls AdvanceSceneTileAnimation on a slot whose countdown reaches zero
wSceneTileAnimState:: ds 8

; [4 bytes] Script start offset of each tile-animation slot; AdvanceSceneTileAnimation rewinds here at the $ff terminator. $ff marks an unbuilt slot
wSceneTileAnimStart:: ds 4

; [8-bit] AdvanceSceneTileAnimation's working cursor: loaded from the slot's wSceneTileAnimState entry, advanced four bytes per command, written back
wSceneTileAnimCursor:: db

; [8-bit] Write-only: bank $0a's paged-text-menu paths store wCurrentScene here and the scene loader writes $ff; nothing reads it
wUnusedPrevSceneIndex:: db

; [8-bit] Current BGM
;
; 0x00 - Silence
; 0x01 - Intro Cutscene
; 0x02 - Title Screen
; 0x03 - Main Menu
; 0x04 - Status Screen
; 0x05 - Dictionary
; 0x06 - Exhibition Match
; 0x07 - Unused
; 0x08 - Mario Minigame Screen
; 0x09 - You Win
; 0x0a - You Lose
; 0x0b - Earning EXP
; 0x0c - Distributing EXP
; 0x0d - Distributing Stats
; 0x0e - Tiebreaker
; 0x0f - Set/Match Point
; 0x10 - Game Point
; 0x11 - Star Court
; 0x12 - Castle Court/Peach's Castle
; 0x13 - Tropic Court/Fruit Fantasy
; 0x14 - Warehouse Court/Treasure Box
; 0x15 - Two-on-One
; 0x16 - Jungle Court/Banana Bunch
; 0x17 - Unused
; 0x18 - Unused
; 0x19 - Shooting Star/Target Shot/Medallion Match
; 0x1a - Academy Main Building
; 0x1b - Story Mode Outdoors
; 0x1c - Dormitory
; 0x1d - Story Mode Indoors
; 0x1e - Tennis Machine
; 0x1f - Wall Practice
; 0x20 - Practice Match
; 0x21 - Junior Ranking Match
; 0x22 - Senior Ranking Match
; 0x23 - Varsity Ranking Match
; 0x24 - Training Court Match
; 0x25 - Training Court Practice
; 0x26 - Island Open Beginning Rounds
; 0x27 - Island Open Semifinals
; 0x28 - Island Open Finals
; 0x29 - Dream Match
; 0x2a - Unused
; 0x2b - Island Open Congratulations
; 0x2c - Credits
; 0x2d - The End
; 0x2e - Done For The Day
; 0x2f - Level Up
; 0x30 - High Score
; 0x31 - Exhibition Match Start
; 0x32 - Story Match Start
wCurrentBGM:: db

; [8-bit] Nonzero during a cable-link match. Set by bank $38's link character select before RunMatch, cleared by EndLinkSession; match and menu code branch on it for link behaviour
wLinkSessionActive:: db

; [32 bytes] The tile plane of the same row blit, sent to VRAM bank 0
wBGRowBlitTiles:: ds 32

; [8-bit] Nonzero makes RenderInlineNumber right-align its number in a five-character field. Set and cleared around the Text_30_310 line only
wTextNumberRightAlign:: db

; [8-bit] Argument of text control code $0e: a character id, which TextCmdPrintShortText and MeasureIndexedShortTextWidth print as text id $1b + id
wTextCharNameArg:: db

; [8-bit] Glyph-row indent, stored negated. The dialogue setup writes -c; StartGlyphStreamRow's caller negates and doubles it and adds it to wGlyphVramDest. Zeroed when a text window closes
wTextRowIndent:: db

; [8-bit] Screen shake strength: $ff = off, else 1-3 (SetScreenShake clamps to 3 and registers/unregisters the UpdateScreenShake frame task). UpdateScreenShake masks a random word to that many bits for the two offsets
wScreenShakeMagnitude:: db
	ds 4

; [8-bit] Signed screen-shake X offset, regenerated each frame by UpdateScreenShake. UpdateSceneScroll adds it before writing hScrollX; bank $04's ComputeSpriteScrollOffset applies it to objects
wScreenShakeOffsetX:: db

; [8-bit] Signed screen-shake Y offset; biases hScrollY like wScreenShakeOffsetX
wScreenShakeOffsetY:: db
	ds 2

; [8-bit] Active story save-slot index (0-2); selects which SRAM story slot CheckStorySlot / SaveStorySlotWithTimer operate on
wCurrentStorySlot:: db
	ds 2

; [8-bit] Nonzero when the EXP screen has a bonus to add after the gauge fills; the level-up path folds wExpBonusAmount into wExpAwardTotal and clears it
wExpBonusPending:: db

; [16-bit] The bonus EXP added to wExpAwardTotal after the first fill
wExpBonusAmount:: dw
	ds 4

; [8-bit] Minigame level - 1 (0x00-0x03)
wMinigameLevel:: db
	ds 9

; [32 bytes] One tilemap column of CGB attributes, blitted to VRAM bank 1 at wBGColumnBlitX by ProcessBGBlitQueue when hBGColumnBlitPending is set; tile plane in wBGColumnBlitTiles
wBGColumnBlitAttrs:: ds 32

; [16-bit] Tile-plane source address for Unused_00_QueueDeferredTilemapCopy's pending copy to $9800
wDeferredTilemapSrc:: dw

; [16-bit] Attribute-plane source address for the same copy (to $9800 in VRAM bank 1)
wDeferredTilemapAttrSrc:: dw

; [8-bit] WRAM bank of the two source pointers, selected by Unused_00_VBlankDeferredTilemapCopyTask while queueing
wDeferredTilemapWramBank:: db

; [8-bit] Deferred tilemap copy length in 16-byte blocks, passed to QueueVRAMCopy for both planes
wDeferredTilemapLength:: db

; [8-bit] Halves of the deferred tilemap copy still owed: low nibble tile plane, high nibble attribute plane. Unused_00_QueueDeferredTilemapCopy clears it; the frame task copies whichever nibbles are set and clears it
wDeferredTilemapPending:: db

; [8-bit] High byte of the current OAM shadow buffer ($c0/$c5); toggled each frame, OAM DMA source
wSpriteBufferPage:: db
	ds 8

; [8-bit] Character id assigned to court slot 0 (player's main character) during match setup; also used for portraits/sprites
wMatchPlayerChar:: db

; [8-bit] Character id assigned to court slot 2 (opponent's main character) during match setup ($ff = none); set by Unused_0a_SetStoryMatchOpponent
wMatchOpponentChar:: db

; [8-bit] BG attribute written for window-frame cells ($80 = BG priority)
wWindowFrameAttr:: db

; [8-bit] WRAM bank of the shadow (off-screen) tilemap buffer; paired with wShadowTilemapPtr
wShadowTilemapBank:: db

; [16-bit] Base pointer of the shadow tilemap buffer (in bank wShadowTilemapBank); tiles at base, attributes at base+$0400
wShadowTilemapPtr:: dw

; [8-bit] CGB BG attribute byte applied to window/glyph tiles when drawing (default $80 = BG priority)
wWindowTileAttr:: db

; [16-bit] Glyph-stream horizontal pen position (sub-pixel fixed point); advanced per glyph by DrawStreamGlyph
wGlyphPenX:: dw

; [8-bit] Width in cells of the glyph-stream row being composed. FlushGlyphRow adds it to wTextRowColumn for the next row; InitGlyphStreamForWindow derives it from the window width (less the two frame cells, plus wGlyphRowStartCol when a window owns the stream)
wTextRowWidth:: db

; [8-bit] Column the current text row starts at (window x plus indent). InitGlyphStreamAt also stores it in wGlyphRowStartCol; the row flush uses it as destination column
wTextRowColumn:: db

; [8-bit] Tilemap column the current glyph row starts at. InitGlyphStreamForWindow seeds wGlyphPenX from it (column * $80); StartGlyphStreamRow reloads both from the pen at each row break
wGlyphRowStartCol:: db

; [8-bit] Tilemap column already flushed from the glyph buffer; StampGlyphTileAtPen subtracts it from the pen's column to advance the write pointer
wGlyphFlushedCol:: db

; [8-bit] Glyph tiles Unused_05_UploadGlyphTileRange sends, capped at $20 (one QueueVRAMCopy)
wGlyphUploadCount:: db

; [8-bit] First glyph tile to upload: source wGlyphTileBuffer + n * TILE_SIZE, destination $8800 + n * TILE_SIZE
wGlyphUploadFirstTile:: db

; [8-bit] Nonzero sends the range to VRAM bank 1 (destination + $2000)
wGlyphUploadVramBank:: db

; [32 bytes] The tile plane of the same column blit, sent to VRAM bank 0
wBGColumnBlitTiles:: ds 32
	ds 32
