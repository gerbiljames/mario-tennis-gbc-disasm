; WRAM layout. Each symbol's note gives its size and what reads and writes
; it; banked and overlaid ranges are UNION blocks, one variant per owner
; (docs/ram_map.md).

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
; 0x01-0x04 are debug maps (STORYLOC_* in include/constants.inc has every id; one StoryLocationTable_0a record each). The location popup's text id is $0179 + id (LoadStoryLocationHeader)
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

; [16-bit] Fraction of the ball X position (16.16 fixed point). The three axes form one 12-byte block from here: SetBallPosition writes each as zero fraction plus integer, and StepBallPhysics copies the block to wBallPrevXFrac before adding velocity
wBallXFrac:: dw

; [16-bit] Ball X position, integer part (lateral, signed)
wBallX:: dw

; [16-bit] Fractional half of wBallDepth
wBallDepthFrac:: dw

; [16-bit] Ball depth position, integer part (signed, net at 0)
wBallDepth:: dw

; [16-bit] Fractional half of wBallHeight
wBallHeightFrac:: dw

; [16-bit] Ball height above the court, integer part
wBallHeight:: dw

; [16-bit] Vertical angle of the ball's velocity: AngleFromVector16(wBallVelocityHeight, wBallSpeedHorizontal), written by UpdateBallAnglesAndSpeed ($100 per turn)
wBallPitchAngle:: dw

; [16-bit] Horizontal heading of the ball's velocity ($100 per turn, as wShotAimAngle): AngleFromVector16(wBallVelocityX, wBallVelocityDepth), written by UpdateBallAnglesAndSpeed. Read by ApplyBallSpin (to put the topspin term back on X/depth) and PredictBallLateralOffset
wBallHeadingAngle:: dw

; [16-bit] Start-of-frame copy of the 12-byte position block, made by StepBallPhysics before integrating; this and the five words after it mirror wBallXFrac onward
wBallPrevXFrac:: dw

; [16-bit] Ball X at the start of the frame (integer part)
wBallPrevX:: dw

; [16-bit] Fractional half of wBallPrevDepth
wBallPrevDepthFrac:: dw

; [16-bit] Ball depth at the start of the frame (integer part); the only part of the copy that is read. HandleBallNetCrossing compares its sign with wBallDepth to detect the net crossing; DidBallCrossGate reads the word
wBallPrevDepth:: dw

; [16-bit] Fractional half of wBallPrevHeight
wBallPrevHeightFrac:: dw

; [16-bit] Ball height at the start of the frame (integer part)
wBallPrevHeight:: dw

; [16-bit] Top/backspin coefficient (rotation about the lateral axis), set from bc by Unused_08_SetBallSpinComponents. While nonzero, ApplyBallSpin rotates the (horizontal speed, vertical velocity) pair by it: wBallVelocityHeight * k goes (negated) into the X/depth velocities along wBallHeadingAngle, wBallSpeedHorizontal * k into the height velocity. Decays by 3/256 per frame
wBallTopspin:: dw

; [16-bit] Sidespin/curve coefficient (rotation about the vertical axis), set from de by Unused_08_SetBallSpinComponents. While nonzero, ApplyBallSpin adds +k*wBallVelocityDepth to the X velocity and -k*wBallVelocityX to the depth velocity, curving the ball; decays by 3/256 per frame
wBallSideSpin:: dw

; [8-bit] Fraction byte of wBallVelocityX. The velocity components are 8.16 fixed point, each written as zero fraction plus 16-bit integer by SetBallVelocityPolar
wBallVelocityXFrac:: db

; [16-bit] Ball X velocity, integer part; decayed by ApplyBallAirDrag
wBallVelocityX:: dw

; [8-bit] Fraction byte of wBallVelocityDepth
wBallVelocityDepthFrac:: db

; [16-bit] Ball depth velocity, integer part; curved by ApplyBallSpin
wBallVelocityDepth:: dw

; [8-bit] Fraction byte of wBallVelocityHeight
wBallVelocityHeightFrac:: db

; [16-bit] Ball vertical velocity, integer part
wBallVelocityHeight:: dw

; [8-bit] Fraction byte of wBallSpeedHorizontal
wBallSpeedHorizontalFrac:: db

; [16-bit] Magnitude of the ball's horizontal (X, depth) velocity, integer part: VectorLengthFromAngle(wBallHeadingAngle, wBallVelocityDepth, wBallVelocityX), written by UpdateBallAnglesAndSpeed. ApplyBallSpin uses it in the topspin lift term
wBallSpeedHorizontal:: dw

; [16-bit] Ball's 3D speed: VectorLengthFromAngle of wBallVelocityHeight against wBallSpeedHorizontal, recomputed with the velocity. ApplyBallAirDrag uses the top nibble of |high byte| as the drag-table index
wBallSpeed3D:: dw
	ds 2

; [16-bit] World X the shot is aimed at (wBallX units), from ComputeShotTargetX in ComputeShotTrajectory; copied to wBallTargetX and drawn as the aim marker sprite in bank $08. Cleared by ResetBallState
wShotAimTargetX:: dw

; [16-bit] World depth the shot is aimed at (net at 0, sign corrected for the hitter's side), written by ComputeShotTrajectory; copied to wBallTargetDepth and used for the aim marker
wShotAimTargetDepth:: dw

; [16-bit] wShotAimTargetX - wBallX, the lateral leg of the ball->target vector, written by ComputeShotTrajectory. Read by every court bank's SetBallTargetByPrediction and the trajectory-length path ($20:$416a, VectorLengthFromAngle with wShotAimDeltaDepth)
wShotAimDeltaX:: dw

; [16-bit] wShotAimTargetDepth - wBallDepth, the depth leg, written by ComputeShotTrajectory and fed to AngleFromVector16 with wShotAimDeltaX to make wShotAimAngle; also read by the court banks' trajectory-length code
wShotAimDeltaDepth:: dw
	ds 2

; [16-bit] Aim angle of the shot being launched (high byte = angle, $100 per turn; low byte = fraction, top nibble used by MulSinCos); projected from ball position into wBallTargetX/Depth
wShotAimAngle:: dw
	ds 2

; [16-bit] Base lateral aim spread for a rally shot's target, set at match init: $0220 singles, $0320 doubles. ComputeAimBaseOffset returns (this + |wCharPosDepth|/8) scaled by the character's aim stat $df69, which ComputeShotTargetX adds to or subtracts from wBallX before clamping
wAimSpreadBase:: dw

; [16-bit] Match camera current X (projected space). SnapCameraTo sets it with the target; UpdateMatchCamera eases it toward wMatchCameraTargetX and derives wCameraOffsetX from it
wMatchCameraX:: dw

; [16-bit] Match camera current Y (projected space); eased toward wMatchCameraTargetY, shifted into wCameraOffsetY
wMatchCameraY:: dw

; [16-bit] Match camera target X, written by SetCameraTarget and SnapCameraTo (and bank $0d's SnapCameraTo_0d), and every frame from wBallGroundProjX while wCameraFollowBall is set. UpdateMatchCamera steps wMatchCameraX toward it by $0040, snapping on overshoot
wMatchCameraTargetX:: dw

; [16-bit] Match camera target Y; same writers and stepping as wMatchCameraTargetX
wMatchCameraTargetY:: dw

; [16-bit] wBallX minus the current character's X, signed; written by UpdateCharBallGeometry for the mapped character bank. Read by AiSteerTowardBall and the swing/contact range checks in bank $08
wBallRelCharX:: dw

; [16-bit] Ball depth minus the current character's depth, signed. Read by CheckBallContactWindow, CheckBallInSwingRange, Unused_08_ComputeBallEtaToChar (divided by wBallVelocityDepth for frames to arrival), PredictBallLateralOffset and the AI
wBallRelCharDepth:: dw

; [16-bit] Ball height minus the current character's height, signed; the reach/height gates compare |value| with the character's reach field $df70
wBallRelCharHeight:: dw
	ds 2

; [16-bit] Projected ball target/landing X (same world units as wBallX)
wBallTargetX:: dw

; [16-bit] Projected ball target/landing depth (companion to wBallTargetX; net at 0)
wBallTargetDepth:: dw

; [16-bit] The ball's X velocity as the shot was struck, saved by ExecuteShot
wShotRecoilVelocityX:: dw

; [16-bit] The same for depth velocity. ApplyShotRecoil scales the pair by the ShotRecoilTable_07 factor for the shot type and pushes the striker back along it
wShotRecoilVelocityDepth:: dw

; [16-bit] Shot speed as FinalizeShotSpeed leaves it, after momentum and the character-flag penalty and clamped up to $0100. Write-only, like the three term traces above it
wShotSpeedFinal:: dw

; [16-bit] The incoming ball's contribution to the shot speed, as AddBallSpeedEighth computed it (signed, then made positive). Write-only
wShotSpeedBallTerm:: dw

; [16-bit] The striker's own depth velocity contribution, halved and signed by which end of the court the character is on (AddPlayerMomentumToShot). Write-only
wShotSpeedMomentumTerm:: dw

; [16-bit] The charge bonus AddChargeSpeedBonusHalf added, scaled $40 or $20 by sign. Write-only; with the three above it, the shot-speed sum broken into terms, none read back
wShotSpeedChargeTerm:: dw

; [16-bit] Projected X of the ball-bounce dust effect (cached at bounce time)
wBounceEffectX:: dw

; [16-bit] Projected Y of the ball-bounce dust effect
wBounceEffectY:: dw

; [16-bit] Projected X of the swing-hit effect (cached at hit time)
wHitEffectX:: dw

; [16-bit] Projected Y of the swing-hit effect
wHitEffectY:: dw
	ds 4

; [16-bit] Screen-space X of the ball's ground (shadow) position, ProjectWorldToScreen(wBallX, wBallDepth) in BuildBallShadowSlot. UpdateMatchCamera copies X/Y into the camera target while wCameraFollowBall is set
wBallGroundProjX:: dw

; [16-bit] Screen-space Y of the ball's ground position
wBallGroundProjY:: dw

; [16-bit] Negated wBallHeight, the drop the trajectory solver must cover; written by ComputeShotTrajectory
wShotSolverNegHeight:: dw

; [8-bit] Aim row (0-$1f) each shot bank's SetBallTargetFromAim derives from the ball's angle to index its per-aim target tables. Write-only; the value is used from a
wShotAimRow:: db
	ds 1

; [16-bit] The magnitude passed to SetBallVelocityPolar, saved before it is split into X/depth. Write-only
wBallVelocityPolarLength:: dw

; [16-bit] First word of the shot-table entry SetBallTargetByPrediction_* is using, stored before the aim delta is applied. Write-only
wShotPredictionEntry:: dw

; [16-bit] Camera X offset added before the <<3 screen projection (ApplyCameraProjection)
wCameraOffsetX:: dw

; [16-bit] Camera Y offset added before the <<3 screen projection
wCameraOffsetY:: dw

; [16-bit] Minigames - Current Score
wMinigamesCurrentScore:: dw

; [16-bit] Minigames - Target Score
wMinigamesTargetScore:: dw

; [16-bit] Projected X of the lob landing marker
wLandingMarkerX:: dw

; [16-bit] Projected Y of the lob landing marker
wLandingMarkerY:: dw

; [16-bit] In-bounds lateral limit, stored negated: $fe50 (-$1b0) singles, $fdc0 (-$240) doubles. CheckBallOutOfBounds adds it to |wBallX| and treats carry as out; ClampShotTargetX clamps the aim target to (-value - $20); ComputeShotTrajectory uses it to shorten wShotDistMax when the aim line would leave the court sideways
wCourtLimitX:: dw

; [16-bit] In-bounds depth limit, stored negated: $fb20 (-$4e0, the baseline) normally, $fd60 (-$2a0, the service line) while a serve is in flight. CheckBallOutOfBounds adds it to |wBallDepth| and sets bit 1 of the out mask on carry
wCourtLimitDepth:: dw

; [16-bit] Net height in ball-height units: $0060 in a match, $0000 in the netless solo minigames. When the ball crosses depth 0, HandleBallNetCrossing adds it to wBallHeight (negative is up); a non-negative sum means the ball clipped the net: sound $5a, bounce effect, wBallHasBouncedFlag set, depth position and velocity negated
wNetHeight:: dw

; [16-bit] Shot solver: distance along the aim line from the ball to depth $0140 past the net, (|wBallDepth| + $0140) / sin(wShotAimAngle), from ComputeShotTrajectory. Every court bank's ApplyBallTrajectory passes it to BallTrajEntryPtr6/4 as the starting trajectory-table row
wShotDistMin:: dw

; [16-bit] Shot solver: distance along the aim line to depth $0480 (just inside the baseline), shortened to where the line would cross the sideline (wCourtLimitX + $0020) if that comes first. The court banks clamp the ball->target length to it before picking a trajectory row
wShotDistMax:: dw

; [8-bit] wShotDistMin >> 6: first trajectory-table row to consider; the loop start for each court bank's SeekBallTrajEntry6/4
wShotTrajRowMin:: db

; [8-bit] wShotDistMax >> 6: last trajectory row SeekBallTrajEntry6/4 may reach; rewritten when the sideline clamp shortens wShotDistMax
wShotTrajRowMax:: db

; [8-bit] Shot buttons of the swing at contact: wCharShotButton1 in the high nibble, wCharShotButton2 in the low. The bank $0d minigame shot tables match required combinations against it
wLastShotButtons:: db

; [8-bit] Winning-shot type for the point just won: 0 = none, 1 = service ace, 2 = return ace, 3 = smash ace, 4 = lob winner, 5 = drop-shot winner. Reset in the per-point state clear; set by the Record*Stat functions, which also credit the wCharacterN stat. The winner banner is ShowCourtBanner(value + $17), banner ids 24-28
wPointWinnerShotType:: db

; [8-bit] Companion to wMatchAbortFlag ($ff from every quit-menu action): StepMatchFrames returns immediately and result jingles are suppressed
wMatchFramesAbort:: db

; [8-bit] hLinkState when RunMatchPlayLoop returned, taken before EndLinkSession. Write-only
wMatchEndLinkState:: db

; [8-bit] Scoreboard layout/caption style, 0-7, chosen by SelectScoreboardLayout from wOnCourtCharCount (singles/doubles) or, for minigames ($c8f5 == 2), from $c7ba/$c7bb as 3/4/7. Jumptable index for DrawScoreboardCaption and DrawScoreboard, table index elsewhere in bank $06; bank $09's serve-indicator spawner checks it against 3
wScoreboardLayout:: db
	ds 11

; [8-bit] Shot-type code of the shot in flight (rst00 jumptable in ExecuteShot; $09 smash, $0a lob, $0b drop - checked by RecordSmashAceStat/RecordLobWinnerStat/RecordDropShotWinnerStat)
wCurrentShotType:: db

; [8-bit] Recoil kind for the shot in flight, from the ShotTypePresets_07 record (ApplyShotTypePresets); ApplyShotRecoil indexes ShotRecoilVarPtrs_07 with it
wShotRecoilVariant:: db

; [8-bit] Charge level of the shot being executed, 0-$3f, from the hitter's $df4b clamped by ExecuteShot. Scales shot speed in AddChargeSpeedBonus / AddChargeSpeedBonusHalf (offset by $ffe0 first) and WeakenShotByCharge / BoostShotByCharge; $3f (fully charged) picks the special hit flash over the normal spark
wShotChargeLevel:: db

; [8-bit] The striker's wCharQuickSwing copied by ExecuteShot, so the shot keeps the value the swing started with
wShotWasQuickSwing:: db

; [8-bit] The striker's wCharAimOffset at contact, stored by ExecuteShot. Write-only
wLastShotAimOffset:: db

; [8-bit] Nonzero when the shot just struck is a special/power hit. Cleared at the top of ExecuteShot; set to 1 when the ball is struck above height $0140, and from the 32-entry toss-height table on serves. Forces the special-shot flash (wSpecialHitTimer) over the normal spark, and on the rally's first shot shows court banner $0e
wSpecialShotFlag:: db

; [8-bit] Set to 1 by each ExecuteShotPower* variant, cleared by ExecuteShot at every swing: marks the power version of topspin/slice/flat. Write-only
wLastShotWasPowerShot:: db

; [8-bit] When 1, the shot's lateral aim offsets are negated. ExecuteShot sets it to the parity of four conditions (hitter state $df15 == 6, == $0a, $df94 nonzero, wRallyLength == 0). LoadShotPlacementEntry negates the placement angle offset with it, and every court bank's SetBallVelocityFromEntry6 negates the entry's angle delta before adding it to wShotAimAngle
wShotAimMirror:: db

; [8-bit] Frames left of the ball-bounce dust effect (starts at $14)
wBounceEffectTimer:: db

; [8-bit] Frames left of the normal swing-hit spark (starts at $10)
wHitSparkTimer:: db

; [8-bit] Frames left of the special-shot hit flash (starts at $10; drives the bank $28 screen effect)
wSpecialHitTimer:: db

; [8-bit] Frames left of the ball-hit-a-character effect; started at $28 by StartBallTouchCharEffect, ticked and used as animation index by DrawBallTouchCharEffect
wBallTouchCharTimer:: db

; [8-bit] Court horizontal bounce damping (8-bit fraction, e.g. $cd = 0.80 on court 0), loaded per court from a 4-byte-per-court table at $08:$5dc4. ApplyCourtBounceDamping multiplies the X and depth velocities by it
wCourtSurfaceFriction:: db

; [8-bit] Court vertical restitution (8-bit fraction) from the same per-court record; ApplyCourtBounceDamping multiplies the height velocity by it
wCourtSurfaceBounce:: db

; [8-bit] Set to 1 when the ball reaches a character's body (which also sets bit 2 of $df50 and forces the character to state 0). HandleBallTouchCharEvent consumes it: sound $77, the effect, ApplyBallTouchOutcome. Cleared by ResetPointState
wBallTouchCharFlag:: db

; [8-bit] Character index (0-3) the ball touched, from wCharIndex. DrawBallTouchCharEffect maps it through CharIndexToWramBank for the screen position; its low bit gives the point outcome's +1/-1 side sign
wBallTouchCharIndex:: db

; [8-bit] Court quadrant under the ball: bit 1 = sign of wBallDepth (net side), bit 0 = sign of wBallX (lateral half). Rebuilt every frame by StepBallPhysics; forced to $02 by the bank $0d wall-practice setup
wBallCourtQuadrant:: db

; [8-bit] CheckBallOutOfBounds' verdict bits for the frame (which bound the ball passed). Write-only; the caller uses the returned a
wBallOutOfBoundsBits:: db

; [8-bit] Bounces since the ball was last struck, saturating at $0a. Zeroed by HandleBallHitEvent and ResetPointState, incremented by HandleBallBounceEvent. Tested for == 1 (first bounce) by EvaluateBounceOutcome, the fault check, the bank $0b drill graders and bank $0d
wBallBounceCount:: db

; [8-bit] Per-frame bounce event, cleared at the top of StepBallPhysics: 1 = ball reached the ground, 2 = ball bounced off a court fence/wall (BounceBallOffCourtFences). HandleBallBounceEvent returns at once on 0
wBallBounceEvent:: db

; [8-bit] 1 for the single frame the ball crosses the net plane; set and cleared by HandleBallNetCrossing. Read by TickRallyTimers, AiTrackBallPhase and CheckBallHitsMinigameTarget / CheckBallHitsMinigameTargetAlt
wBallCrossedNetFlag:: db

; [8-bit] Frames the ball has spent past the net this point: TickRallyTimers increments it while wBallCrossedNetFlag is set, capped at $64; ResetPointState clears it. Read only by its own cap test
wRallyNetFrames:: db

; [8-bit] Rally Length; number of times the ball was hit in the span of a point
wRallyLength:: db

; [8-bit] Set to 1 by ExecuteShot, which refuses to run again while it is set. HandleBallHitEvent consumes it: increments wRallyLength, clears wBallHasBouncedFlag and wLandingMarkerActive, starts the landing marker and hit effect, updates every character's state. Cleared by ResetPointState
wBallHitEvent:: db

; [8-bit] Character index (0-3) of the hitter, from wCharIndex in ExecuteShot. Selects the wCharacterN stat block (index * 8) when crediting an ace/winner, its low bit gives the point outcome's side sign, and the bank $0d minigames test it for player vs machine
wLastShotCharIndex:: db

; [8-bit] The hitter's wCharServeRole, from ExecuteShot. Read only by DetectServeAceOutcome: on a point's second hit with the ball unbounced, role 1 (receiver) gives POINTOUTCOME_SERVE_VOLLEYED and any other role POINTOUTCOME_WRONG_RECEIVER
wLastShotServeRole:: db

; [8-bit] Nonzero draws the ball sprite slot
wBallSpriteEnabled:: db

; [8-bit] Nonzero draws the ball ground-shadow slot
wBallShadowEnabled:: db

; [8-bit] Nonzero draws the ball trail afterimages from the position history ring
wBallTrailEnabled:: db

; [8-bit] Trail palette index into BallTrailPalettes; nonzero also extends the trail from 2 to 5 ghosts
wBallTrailColor:: db

; [8-bit] wBallCourtQuadrant when the shot was struck. EvaluateBounceOutcome XORs it with the live quadrant: bit 1 = reached the other side of the net, bit 0 = changed lateral half (the serve's diagonal-box rule). The bank $0d wall-practice bounce flips bit 1 by hand
wBallQuadrantAtHit:: db

; [8-bit] Set to 1 when the ball bounces on the court (the same path fires StartBounceEffect); cleared by HandleBallHitEvent and ResetPointState. Read by EvaluateBounceOutcome, TickRallyTimers and AiTrackBallPhase
wBallHasBouncedFlag:: db

; [8-bit] Nonzero freezes the match simulation: UpdateMatchFrame skips ClearSpriteSlots, UpdateMatchCamera, UpdateAllChars, ball events, UpdateBallVisuals, timers and the mode hook. $ff during match setup and while the pause menu is open
wMatchSimFrozen:: db

; [8-bit] Nonzero freezes actor drawing: UpdateMatchFrame skips DrawActorsByDepth. Set $ff alongside wMatchSimFrozen while the pause menu is open
wMatchDrawFrozen:: db

; [8-bit] Nonzero blocks the pause menu (HandlePauseMenu returns at once). Set during match setup, the changeover sequence (RunChangeoverSequence) and the walk off court (WalkCharsOffCourt); cleared by ResetPointState and PlayMinigameCountdown
wPauseDisabled:: db

; [8-bit] $ff = abort the match (bit 7 breaks the point/game/set/match loops); set by every pause/quit-menu action, cleared per point by ResetPointState
wMatchAbortFlag:: db

; [8-bit] Nonzero draws edge arrows for off-screen characters (set during the rally)
wOffscreenArrowsEnabled:: db

; [8-bit] Set to 1 by PlayMinigamePoint as the rally starts; nothing reads it
wUnusedMinigamePointFlag:: db

; [8-bit] Set to 1 by ApplyFallbackBallTrajectory_24, the shared handler the court banks use when the requested trajectory row is out of range; cleared by ExecuteShot. StartLandingMarker then draws the lob landing marker, and AiIsIncomingLobShot treats the shot as SHOTTYPE_LOB
wFallbackTrajectoryFlag:: db

; [8-bit] Nonzero when the player chose Retry / Select New Level / Quit in the quit menu (discriminated by wMatchRetryRequest/wMatchSelectNewLevelRequest); outer mode loops branch on it
wMatchExitRequest:: db

; [8-bit] Set by InitViewFlipPreference when the court view is fixed instead of following the saved preference (link matches, game modes $08/$09, any minigame); the pause menus then lock the view row
wCourtViewLocked:: db

; [8-bit] Nonzero makes UpdateMatchCamera retarget to wBallGroundProjX/Y every frame instead of holding SetCameraTarget's target. Cleared by SetCameraTarget, SnapCameraTo and KeepMinigameCameraFixed; set to 1 when the rally starts and by the bank $0d wall bounce
wCameraFollowBall:: db

; [8-bit] Set in singles only; enables the wide flickering ground shadow under grounded characters
wStandingShadowsEnabled:: db

; [8-bit] Nonzero when the court view is mirrored so the human player stays on the near side: (wCourtViewOption != 0) && (bit 1 of $c8cf), recomputed by UpdateViewFlipState. FlipAllCharPositions skips flipping court-position codes when 0; RefreshCourtScoreboard picks the mirrored scoreboard layout when set
wCourtViewFlipped:: db

; [8-bit] Nonzero makes RunChangeoverSequence walk the characters to their new ends without the CHANGE ENDS banner. Set at the start of a set, at set end and when a tiebreak begins; cleared by the sequence
wChangeoverSkipBanner:: db

; [8-bit] Set to 1 when bit 1 of the game-count state $c8cf toggles (players change ends). RunChangeoverSequence then shows court banner $00, walks the characters over and clears it; also cleared at match setup
wChangeEndsPending:: db

; [8-bit] Nonzero when wCourtViewFlipped changed on the last UpdateViewFlipState (old minus new). RefreshCourtAfterEndChange returns at once on 0; ReinitPointAfterPause uses it to decide whether to redraw the court
wCourtViewFlipChanged:: db

; [8-bit] wOnCourtCharCount - 1 (0x00-0x03); jumptable index for the match engine's per-character-count dispatches
wOnCourtCharCountMinus1:: db

; [8-bit] Set when the point ended as a service ace (point outcome 6 with rally length 1); credited to the winner's ServiceAces stat
wServiceAceFlag:: db

; [8-bit] Set when the point ended as a return ace (point outcome 6 with rally length 2); credited to the winner's ReturnAces stat
wReturnAceFlag:: db

; [8-bit] WRAM bank (4-7) of the serving character, from FindServerCharBank in IdentifyServingPlayer. ReinitPointAfterPause maps it in to put the server back into the serve state
wServingCharWramBank:: db

; [8-bit] Current Serving Player (0x00-0x03)
wCurrentServingPlayer:: db

; [8-bit] wCharCourtPos of the serving character, from IdentifyServingPlayer. Bit 1 (server's side of the net) selects the serve camera target (GetServeCameraTarget) and the ace-banner offset; bank $09 uses the whole value as the serve-indicator template index and mixes it with wServeFaultFlag
wServingCharCourtPos:: db

; [8-bit] Match-point indicator: $01/$ff = P1/P2 side wins the match by taking the next point, 0 = none (EvaluatePointSituation simulates the next point)
wMatchPointFlag:: db

; [8-bit] Set-point indicator ($01/$ff/0, same scheme as wMatchPointFlag)
wSetPointFlag:: db

; [8-bit] Game-point indicator ($01/$ff/0, same scheme as wMatchPointFlag)
wGamePointFlag:: db

; [8-bit] 0 while the rally runs; point-end cause code once the point resolves
wPointOutcome:: db

; [8-bit] Side code stored with wPointOutcome when a point-ending event fires ($01/$ff); negated through the court-side parity bits to decide who won the point
wPointOutcomeSide:: db

; [8-bit] Nonzero while the lob landing marker is shown. Set with sound $6d by StartLandingMarker after it fills wLandingMarkerX/Y; DrawLandingMarker returns when 0. Cleared by HandleBallHitEvent, HandleBallBounceEvent, EndPointBallEffects, ResetPointState and bank $0d; the AI reads it as "a lob is coming"
wLandingMarkerActive:: db

; [8-bit] wMatchTypeNumberOfSets >> 1, set at match setup. ShowMatchRulesPages forms wRulesPageListIndex = this * 2 + wRulesGamesIndex, selecting one of the six MatchRulesPageLists records
wRulesSetsIndex:: db

; [8-bit] Bit 2 of wMatchTypeNumberOfGames, set at match setup; low term of wRulesPageListIndex
wRulesGamesIndex:: db

; [8-bit] Saved camera / court view option, loaded from story save-slot flag B (forced to 0 for minigames and game mode 8); edited by MatchPauseMenu_CameraSelect, which writes it back with SetStorySlotFlagB. UpdateViewFlipState mirrors the court only when nonzero
wCourtViewOption:: db

; [8-bit] Set to 1 by MatchQuitMenu_Retry; reruns the current drill/minigame (RunTrainingDrillByID)
wMatchRetryRequest:: db

; [8-bit] Set to 1 by MatchQuitMenu_SelectNewLevel; returns to the level-select screen after the match teardown
wMatchSelectNewLevelRequest:: db

; [8-bit] Pause/quit menu selection (rst00 jumptable index: check rules / review controls / change options / save-quit); $ff = cancelled
wMatchMenuSelection:: db

; [8-bit] Item id of the first entry of the story option submenu to draw ($04 court view, $06 message speed, $09 music, $0b save; $0e for the story pause root). RunStoryTwoOptionMenu and RunStoryThreeOptionMenu draw this id, +1 and +2, and add wMatchMenuSelection to it for the caption text ($0162 + n) and highlighted item graphics
wStoryMenuFirstItem:: db

; [8-bit] Nonzero means the shadow tilemap needs flushing to VRAM: Unused_06_FlushTilemapToVramIfDirty returns on 0, FlushTilemapToVram clears it, the debug stats editor sets it after redrawing
wTilemapDirtyFlag:: db

; [16-bit] Base position of the match scoreboard layout (low byte x, high byte y), added to each element's fixed offset. Set by PrepareScoreboardGfx ($0002 or $0202 by wScoreboardLayout) and ShowMatchScoreboardScreen (low byte 5). Read by the ScoreboardCaption_* handlers, DrawScoreboard, the pip drawers, and (shifted left 3) DrawScoreboardSprites and DrawScoreboardModeTitle
wScoreboardOrigin:: dw

; [8-bit] Rules/description page list to display, set by ShowMatchRulesPages (from wRulesSetsIndex/wRulesGamesIndex), ShowTrainingRulesPages (wCurrentMinigameStoryMatch + 1) and the minigame variant (drill id * 3 + wMinigameLevel). Indexes a 4-byte-per-record page list (MatchRulesPageLists and siblings)
wRulesPageListIndex:: db

; [8-bit] menu_def record the pause menu system should run, set before every RunMatchMenu / RunMatchQuitMenu / RunStoryMenu call in bank $06. GetMatchMenuItemCount and GetStoryMenuItemCount index their 8-byte menu_def tables with it
wPauseMenuId:: db

; [8-bit] Item count of the running menu, from Get*MenuItemCount in RunMatchMenu / RunStoryMenu. Wrap modulus for MoveCursorHorizontal, loop count in DrawMatchMenuItems / DrawStoryMenuItems, and index into the per-count item-position tables
wPauseMenuItemCount:: db

; [16-bit] Text id of the first body page of the rules sequence ($2c62 match rules, $2c6a training rules, or a per-minigame table value); ShowRulesPageSequence adds the page number to it
wRulesFirstPageTextId:: dw

; [16-bit] Text id of the caption above the rules pages: a fixed base plus wRulesPageListIndex ($2c25 + n match, $2c2b + n training, $2c47 + n minigame); passed to DrawMenuCaptionWindow
wRulesTitleTextId:: dw

; [16-bit] Saved best score for the current minigame, copied from the record ReadMinigameRecord returns (WRAM bank 7, $de00). Drawn instead of wMinigamesTargetScore when $c7bc marks a high-score attempt; bank $0d compares the current score against it
wMinigameHighScore:: dw

; [8-bit] Flags for the built-in debug test match; $fe from Unused_07_RunDebugTestMatch. Bit 1 makes character setup call OverrideCharStatsForDebug; bit 0 makes the frame-stepping loop skip the input wait
wDebugMatchFlags:: db
	ds 17

; [160 bytes] Second shadow OAM page: hOAMDMARoutine sources $c0 or $c5 as wSpriteBufferPage toggles, so this is built while wShadowOAM is copied (and vice versa). Only reached through pointers, with wSpriteBufferPage as the high byte
wShadowOAM2:: ds 160
	ds 96

; Dialogue string buffer (160 bytes); text-bank fetch routines copy string N here when called with a = 0. Also the save engine's staging area: MirrorSaveHeaderToBank1 copies each 512-byte SRAM header region through $c600-$c7ff on its way to SRAM bank 1, overwriting this buffer, wTilemapRowStage, wInlineTextBuffer and the debug-menu variables
wTextBuffer:: ds 160
	export_size wTextBuffer

; [32 bytes] One tilemap row staged by RestoreShadowTilemapRow: read from the map buffer (wrapping at the map edge), then written back into the shadow tilemap
wTilemapRowStage:: ds 32
	export_size wTilemapRowStage

; 32-byte staging buffer for inline text args (player name, arg strings, short texts) rendered via RenderInlineString
wInlineTextBuffer:: ds 32
	export_size wInlineTextBuffer
	ds 32

; [8-bit] Window struct index of the debug menu's own window, from CreateMenuWindowFromText; RunDebugMenu passes it to RunMenuSelection and CloseWindow
wDebugMenuWindowId:: db

; [8-bit] Window struct index of the debug warp submenu, addressed the same way by DebugDrawWarpMenu
wDebugWarpWindowId:: db

; [8-bit] Story location count from GetStoryLocationCount; RunDebugWarpMenu's location stepper wraps at it
wDebugWarpLocationCount:: db

; [8-bit] Debug warp menu field under the cursor: 0 = location number, 1 = entry point (toggled with xor 1, row drawn at *2+2). The location number is held in $c700 during this menu. The colour editor formats its G digits over these bytes
wDebugWarpCursorRow:: db

; [8-bit] Entry point the debug warp menu is editing, written to wStoryModeEntryPoint when A confirms. $c700-$c709 is shared debug scratch: the window ids here in one submenu, the "RRRGGGBBB" decimal buffer in the colour editor, eight bytes of wCharPosX in the stats editor
wDebugWarpEntryPoint:: db
	ds 1

; [3 bytes] Last third of the colour editor's $c700-$c709 digit string: DebugDrawColorComponents formats R/G/B as 3-digit groups at $c700/$c703/$c706, puts the $0d cursor glyph over the selected component's first digit, and WriteStringToWindow draws the run. R and G overlap the warp-menu names
wDebugColorBlueDigits:: ds 3

; [8-bit] NUL terminator after the nine RGB digits; last byte of the $c700-$c709 debug scratch
wDebugColorDigitsEnd:: db
	ds 6

; [8-bit] Window handle of the debug palette viewer's grid window (RunDebugPaletteViewer)
wDebugPaletteViewerWindowId:: db

; [8-bit] Window handle of the debug colour editor opened on top of the palette viewer (RunDebugColorEditor)
wDebugColorEditorWindowId:: db

; [8-bit] Which of the four colours in the selected palette the debug cursor is on, masked to $03
wDebugPaletteColorIndex:: db

; [8-bit] Palette under the debug cursor, masked to $0f. GetSelectedBGPaletteColorPtr indexes wBGPalettes with (palette * 4 + colour) * 2, so 8-15 run on into wOBJPalettes
wDebugPaletteIndex:: db

; [8-bit] Page of 64 game flags shown by the debug flag editor; the flag number DebugToggleSelectedFlag builds is page * 64 + byte * 8 + bit
wDebugFlagPage:: db

; [8-bit] Bit 0-7 the flag cursor sits on (the low term of the flag number)
wDebugFlagBit:: db

; [8-bit] Flag byte within the page, scaled by 8 into the flag number
wDebugFlagByte:: db

; [8-bit] Window handle of the debug flag editor's two-row hex header
wDebugFlagHeaderWindowId:: db

; [8-bit] Window handle of the debug flag editor's first flag grid
wDebugFlagWindow1Id:: db

; [8-bit] Window handle of the debug flag editor's second flag grid; all three windows are redrawn on every cursor move
wDebugFlagWindow2Id:: db
	ds 6

; [16 bytes] The debug warp menu's number-entry prompt: copied here, then FormatDecimalNumber overwrites the digits in place
wDebugNumberEntryText:: ds 16
	export_size wDebugNumberEntryText
	ds 48

; [8 bytes] Four 16-bit values the debug stats page shows as words. Only +$00, +$04 and +$06 are drawn; +$02 is skipped
wDebugStatWords:: ds 8

; [8 bytes] The debug stats editor's eight byte fields, drawn by Unused_06_DrawDebugStatByte and stepped in place: the first three wrap at 2, 8 and 2, the last five are decimal digits 0-9
wDebugStatBytes:: ds 8

; [8 bytes] Four more 16-bit values on the same page, drawn after wDebugStatBytes
wDebugStatWords2:: ds 8
	ds 8

; Mode-local scratch: $c780-$c78f is reused by each game mode. The match
; engine's two `ld hl, $c780 / ld c, $08 / call ClearMemory16` sites zero
; the whole $c780-$c7ff mode page (c * 16 bytes), resetting every union
; variant, the wTargetZone*/wDrillGate* flats and the mode-hook table.
; ResetMugshotPalettes_1b writes $ff to $c780; nothing reads it back.
wModeScratch::
UNION
; character select (bank $1b)
	ds 1
; [8-bit] Character id under the char-select cursor, from the roster grid at $c7a0 (Unused_1b_UpdateCharSelectSelection)
wCharSelectChar:: db
; [8-bit] Character id selected on the previous frame (change detection)
wCharSelectPrevChar:: db
; [8-bit] Char-select cursor column in the roster grid
wCharSelectCol:: db
; [8-bit] Char-select cursor row in the roster grid
wCharSelectRow:: db
	ds 7
NEXTU
; minigames (bank $0d)
; [16-bit] Serves launched this round. LaunchMinigameServe increments it and derives the ball speed from it (count / 10, capped at $19), so the feed speeds up
wMinigameServeCount:: dw
; [16-bit] Points shown by the score popup; AwardHitScore and the per-minigame scorers store the award here before AddToMinigameScore
wScorePopupValue:: dw
; [8-bit] Ball speed LaunchMinigameServe passed to LaunchBall for this serve
wMinigameServeSpeed:: db
; [8-bit] Which serve the tennis machine plays next; the machine hooks advance it by 1 or 2 per point and wrap it, and ApplyMinigameCharTargetFromTable indexes the aim table with it
wMinigameServeSlot:: db
; [8-bit] wMinigameServeSlot / 3, taken by LaunchMinigameServe and read back by LaunchBall
wMinigameServeGroup:: db
; [8-bit] Frames left on the score popup, seeded with $10 by StartScorePopup; UpdateScorePopup ticks it and uses it as the rise offset
wScorePopupTimer:: db
; [8-bit] Set while a hit is being scored; ResetTargetHitState clears the streak only when this is clear, which keeps a streak alive across one rally's points
wMinigameHitScored:: db
; [8-bit] Consecutive scoring hits, stepped by IncrementCappedCounter (cap in b). AwardHitScore indexes a sound table and a score table with it
wMinigameHitStreak:: db
; [8-bit] Treasure Box actor state, stepped by AdvanceTreasureBoxActorState and used by DrawTreasureBoxSprite to pick the frame
wTreasureBoxState:: db
NEXTU
; training drills (bank $0b)
	ds 11
; [8-bit] Set while the serve gate stands: RecordGateCrossOnServe clears it when the serve passes through (recording the bit in wDrillGateCrossBits); QueueDrillMarker1/2 draw the gate markers only while set
wDrillGateActive:: db
NEXTU
; scoreboard (bank $18)
; [8-bit] Cleared by Unused_18_InitConfirmScreen; Unused_18_DrawScoreNumbersTask raises wScorePanelBobActive for the frame's score digits when it equals 3. Nothing advances it, and the confirm screen's only caller is Unused_1b_ShowHighScoreConfirmScreen, so the bob is dead (ramp table UnusedBobRamp_18)
wScorePanelBobStep:: db
	ds 2
; [8-bit] Raised by Unused_18_DrawScoreNumbersTask around drawing the wScorePanelScore digits; Unused_18_DrawGlyphSprite then adds a per-glyph Y offset from UnusedBobRamp_18
wScorePanelBobActive:: db
	ds 6
; [8-bit] Snapshot of wStoryMainCharExpTier taken by Unused_18_LoadScorePanelValue, drawn by Unused_18_DrawScoreNumbersTask
wScorePanelExpTier:: db
; [8-bit named; read as a 16-bit word] Unused_18_DrawScoreNumbersTask draws $c78b-$c78c as a 3-digit sprite number beside wScorePanelExpTier. Nothing in bank $18 writes it and the high byte is wTargetZoneEnabled, so it reads whatever the mode-page clear left (0)
wScorePanelScore:: db
ENDU

; [8-bit] Nonzero draws the 4-corner court target zone (training drills)
wTargetZoneEnabled:: db

; The last three bytes of the $c780 mode-local scratch block, above
; wTargetZoneEnabled. The minigame target code and the scoreboard both own
; them, in different modes.
UNION
; minigame targets (banks $0a/$0d)
; [8-bit] Type of the target the ball just hit, an index into MinigameTargetTypeScores; $ff = scores nothing
wMinigameHitTargetType:: db
; [8-bit] Set by the deflect hit-test and cleared by ScoreMinigameTargetHitOrDeflectBall once the hit has been scored
wMinigameHitPending:: db
	ds 1
NEXTU
; scoreboard (bank $18)
; [3 bytes] Three values Unused_18_SetupScoreboardDisplay draws as 6x2 tile blocks, each via Unused_18_GetTextSlotPointer
wScorePanelValues:: ds 3
ENDU

; [16-bit] Target zone X bound 1 (world units)
wTargetZoneX1:: dw

; [16-bit] Target zone depth bound 1 (world units)
wTargetZoneDepth1:: dw

; [16-bit] Target zone X bound 2 (world units)
wTargetZoneX2:: dw

; [16-bit] Target zone depth bound 2 (world units)
wTargetZoneDepth2:: dw

; [4 bytes] First drill gate: two 16-bit coordinates (+$00 from hl, +$02 from de in SetBallGatePoint1). DidBallCrossGate tests the ball against it each frame; QueueDrillMarker1_0b draws the marker there
wDrillGate1:: ds 4

; [4 bytes] The second gate, set and tested the same way
wDrillGate2:: ds 4

; Mode-local scratch, the first five bytes above $c780, used by the
; minigame banks. Bank $1b loads its 32-byte nav grids from the same
; address on past the named mode bytes above (harmless: the match engine
; re-zeroes the $c780-$c7ff page), so only the base byte carries the symbol.
UNION
; menu-shell nav grid (bank $1b)
; [8-bit] Base of the 32-byte 4x8 grid of character/menu-cell ids the menu shell's grid cursor walks; it runs past this union. Unused_1b_LoadCharSelectNavGrid copies CharSelectNavGridTable here and the unlock-debug screen copies UnlockDebugNavGridTable ($ff = empty cell, $fe/$fd = wrap sentinels). Unused_18_MoveGridCursor takes hl = this base; the selection readers index it split-base with row*8+col
wNavGridBuffer:: db
	ds 4
NEXTU
; minigame targets (banks $0a/$0d)
; [4 bytes] Start position of the floating score popup, copied from wBallHistory + 30 by StartScorePopup and stepped by UpdateScorePopup
wScorePopupSource:: ds 4
; [8-bit] Set at init by Banana Bunch and Fruit Fantasy, whose targets deflect the ball instead of absorbing it; UpdateMinigameTarget then runs the Alt draw, hit-test and scoring handlers
wMinigameTargetsAltMode:: db
ENDU

; [8-bit] Random roll SelectRandomMinigameShot and SelectRandomTreasureBoxTargetZone keep while walking their weight tables
wMinigameShotRoll:: db

; [8-bit] Set when the ball lands on a target tile; ProcessTargetTileHit clears it as it scores the hit
wTargetTileHit:: db

; [8-bit] Where the minigame is in its serve: StartMinigameMatch seeds it, DrawMinigameScoreHud and LaunchMinigameServe branch on it
wMinigameServeState:: db

; [8-bit] Nonzero makes AiServePressToss release the serve at once instead of running the wAiServeStyle toss table (the coach drills' plain feed). The bank $0b drill hooks set it at point start and clear it around RunMinigameMatch
wAiServeSkipToss:: db
	ds 7

; [16-bit] Pointer to the layout table for the current minigame point, set by SetMinigamePointTable and walked by LoadMinigamePointLayout and RunMinigamePointLoop
wMinigamePointTable:: dw

; [16-bit] Pointer to the current game mode's callback table (indexed by CallModeHook)
wModeHookTable:: dw

; [8-bit] ROM bank of the mode callback table (0 = no hooks registered)
wModeHookBank:: db

; [8-bit] Aim AiApplyServeAim uses for the next serve; $ff (set by RunMatch) = random from AiApplyServeAimTable. The drill point-start hooks write a fixed aim
wAiServeAimOverride:: db

; [16-bit] Spot the serving CPU walks to; zero makes AiServeWalkToSpot roll a new one. The drill runner clears it before each match
wAiServeTargetX:: dw

; [8-bit] Set to 1 by the InitMinigame_* routines fed by the tennis machine (Tennis Machine 1-4, Target Shot, Shooting Star, Treasure Box, Medallion Match); the match engine reads it for the scoreboard layout, point reset and serve phase
wMinigameUsesTennisMachine:: db

; [8-bit] Set to 1 by the InitMinigame_* routines played against the wall (Wall Practice 1-4, Banana Bunch, Perfect Shot, Fruit Fantasy); read by SelectScoreboardLayout, HandleBallNetCrossing and the serve positioning
wMinigameUsesWall:: db

; [8-bit] Set to 1 by InitMinigame_BooBlast
wMinigameIsBooBlast:: db

; [8-bit] Set to 1 by the bank $0b Service/NetGame practice drills (coach lessons). RecordDrillPointResultBits stores per-point results differently while set; SelectScoreboardLayout picks layout 3
wDrillIsPracticeLesson:: db

; [8-bit] Set to 1 for a high-score attempt: outright by the InitMinigame_*HighScore entries, and by ordinary minigames at wMinigameLevel 2. SelectScoreboardLayout picks layout 7
wMinigameHighScoreMode:: db

; [8-bit] Passed in b to LoadPlayer1ScoreDigitGfx/LoadPlayer2ScoreDigitGfx so the score panel shows tiebreak counts instead of 0/15/30/40. CheckSetComplete sets it entering a tiebreak and clears it at the start of an ordinary game
wScoreDisplayIsTiebreak:: db

; Mode-local scratch above the named mode flags; as with the $c780 block,
; each mode reuses the bytes; variants belong to the owning bank.
UNION
; minigame targets (banks $0a/$0d)
; [8-bit] Set while the target actors are live; UpdateMinigameTargets returns at once when it is clear
wMinigameTargetsActive:: db
; [8-bit] Grid cell the ball last bounced off, recorded by the Banana Bunch / Fruit Fantasy deflection handlers and read when the hit is scored
wMinigameLastHitCell:: db
; [24 bytes] The 3 x 8 target grid, one byte per cell. AreAllTargetsHit passes when all 24 are 1; ResetTargetGrid clears it a row at a time (+$07, +$0f, +$17 are the row ends)
wMinigameTargetGrid:: ds 24
	export_size wMinigameTargetGrid
NEXTU
; character select and new game (bank $1b)
; [8-bit] Cursor column carried in and out of RunCharacterSelectScreen, so the new-game roster loop resumes where the player left off
wCharSelectCursorCol:: db
; [8-bit] Cursor row, the same
wCharSelectCursorRow:: db
; [8 bytes] Two bytes per starting character (wCharRecordBuffer + 14 and + 12), collected by RunNewGameSetup before the roster is shown
wNewGameRosterFields:: ds 8
; [8-bit] Cleared by Unused_1b_RunStoryDataConfirmMenu as the prompt opens
wStoryDataPromptFlag:: db
ENDU

	ds 40

; [buffer] Base of the story-slot state image ($c800-$caff): the main character, game mode, match settings and roster fields, saved whole as save block 2N (docs/save_format.md) and reloaded on slot load
wStorySlotData:: db

; [6 bytes] Bytes 1-6 of the saved-slot mirror's main character name (record +$01-$06); byte 0 is wStorySlotData. The mirror pair at $c800/$c840 is kept in step with the live records at $c900/$c940 by a 128-byte copy ($02:$4795)
wSavedMainCharacterName:: ds 6

; [4 bytes] Saved-slot mirror record +$07-$0a: name terminator and padding after the 7-character name
wStoryModeMainCharacterNamePad:: ds 4

; [8-bit] Saved-slot mirror record +$0b: character id (after RemapExtendedCharId), mirror of $c90b
wSavedMainCharacterId:: db

; [8-bit] Saved-slot mirror of the main character record +$0c: palette index (GetCharPaletteIndex)
wSavedMainCharacterPaletteIndex:: db

; [8-bit] Saved-slot mirror of the main character record +$0d: gender, 0 male, 1 female
wSavedMainCharacterGender:: db

; [8-bit] Saved-slot mirror of the main character record +$0e: left-handed flag
wSavedMainCharacterLeftHanded:: db

; [9 bytes] Saved-slot mirror record +$0f-$17: AI and physics attributes from StoryCharacterRecords_02: +$0f personality byte, +$10-$17 reach windows, smash and dive speeds and reaction delays, refreshed by RecomputeCharacterStats from the +$30 template
wStoryModeMainCharacterPhysics:: ds 9

; [8-bit] Story Mode - Main Character Level (0x01-0x63)
wStoryModeMainCharacterLevel:: db

; [2 bytes] Saved-slot mirror record +$19-$1a: swing attribute word
wStoryModeMainCharacterSwingAttrWord:: dw

; [5 bytes] Saved-slot mirror record +$1b-$1f: AI personality parameters (docs/story_mode.md, "The character record")
wStoryModeMainCharacterAiParams:: ds 5

; [8-bit] Story Mode - Main Character Top Stat (0x00-0x09)
wStoryModeMainCharacterTopStat:: db

; [8-bit] Story Mode - Main Character Slice Stat (0x00-0x09)
wStoryModeMainCharacterSliceStat:: db

; [8-bit] Story Mode - Main Character Serve Stat (0x00-0x09)
wStoryModeMainCharacterServeStat:: db

; [8-bit] Story Mode - Main Character Stroke Stat (0x00-0x09)
wStoryModeMainCharacterStrokeStat:: db

; [8-bit] Story Mode - Main Character Volley Stat (0x00-0x09)
wStoryModeMainCharacterVolleyStat:: db

; [8-bit] Story Mode - Main Character Angle Stat (0x00-0x09)
wStoryModeMainCharacterAngleStat:: db

; [8-bit] Story Mode - Main Character Placement Stat (0x00-0x09)
wStoryModeMainCharacterPlacementStat:: db

; [8-bit] Story Mode - Main Character Speed Stat (0x00-0x09)
wStoryModeMainCharacterSpeedStat:: db

; [8-bit] Story Mode - Main Character Dash Stat (0x00-0x09)
wStoryModeMainCharacterDashStat:: db

; [8-bit] Story Mode - Main Character Reaction Stat (0x00-0x09)
wStoryModeMainCharacterReactionStat:: db

; [8-bit] Story Mode - Main Character Stop Stat (0x00-0x09)
wStoryModeMainCharacterStopStat:: db
; [8-bit] Character record +$2b of the saved-slot mirror: speed bonus (see wStoryMainCharSpeedBonus)
wStoryModeMainCharacterSpeedBonus:: db

; [3 bytes] Story Mode - Main Character EXP, capped at 99999 by AddExpCapped
wStoryModeMainCharacterEXP:: ds 3
; [8-bit] Character record +$2f of the saved-slot mirror: write-only build tag (see wStoryMainCharBuildKind)
wStoryModeMainCharacterBuildKind:: db

; [8 bytes] Saved-slot mirror record +$30-$37: physics template, copied into +$10-$17 by RecomputeCharacterStats
wStoryModeMainCharacterPhysicsTemplate:: ds 8

; [8-bit] Story Mode - Main Character Spin Level
wStoryModeMainCharacterSpinLevel:: db

; [8-bit] Story Mode - Main Character Power Level
wStoryModeMainCharacterPowerLevel:: db

; [8-bit] Story Mode - Main Character Control Level
wStoryModeMainCharacterControlLevel:: db

; [8-bit] Story Mode - Main Character Speed Level
wStoryModeMainCharacterSpeedLevel:: db

; [8-bit] Main character's equipment nibbles, normalised by RefreshMainCharacterStats before the stats are recomputed: a low nibble of 3 clears the low nibble, a high nibble of 1 clears the high one
wMainCharEquipmentBits:: db
	ds 3

; [7 bytes] Saved-slot mirror of the partner record +$00-$06: the 7-character name, NUL-padded
wSavedPartnerCharacterName:: ds 7

; [4 bytes] Saved-slot mirror partner record +$07-$0a: name terminator and padding after the 7-character name
wStoryModePartnerCharacterNamePad:: ds 4

; [8-bit] Saved-slot mirror partner record +$0b: character id (after RemapExtendedCharId), mirror of $c94b
wSavedPartnerCharacterId:: db

; [8-bit] Saved-slot mirror of the partner record +$0c: palette index (GetCharPaletteIndex)
wSavedPartnerCharacterPaletteIndex:: db

; [8-bit] Saved-slot mirror of the partner record +$0d: gender, 0 male, 1 female
wSavedPartnerCharacterGender:: db

; [8-bit] Saved-slot mirror of the partner record +$0e: left-handed flag
wSavedPartnerCharacterLeftHanded:: db

; [9 bytes] Saved-slot mirror partner record +$0f-$17: AI and physics attributes from StoryCharacterRecords_02: +$0f personality byte, +$10-$17 reach windows, smash and dive speeds and reaction delays, refreshed by RecomputeCharacterStats from the +$30 template
wStoryModePartnerCharacterPhysics:: ds 9

; [8-bit] Story Mode - Partner Character Level (0x01-0x63)
wStoryModePartnerCharacterLevel:: db

; [2 bytes] Saved-slot mirror partner record +$19-$1a: swing attribute word
wStoryModePartnerCharacterSwingAttrWord:: dw

; [5 bytes] Saved-slot mirror partner record +$1b-$1f: AI personality parameters (docs/story_mode.md, "The character record")
wStoryModePartnerCharacterAiParams:: ds 5

; [8-bit] Story Mode - Partner Character Top Stat (0x00-0x09)
wStoryModePartnerCharacterTopStat:: db

; [8-bit] Story Mode - Partner Character Slice Stat (0x00-0x09)
wStoryModePartnerCharacterSliceStat:: db

; [8-bit] Story Mode - Partner Character Serve Stat (0x00-0x09)
wStoryModePartnerCharacterServeStat:: db

; [8-bit] Story Mode - Partner Character Stroke Stat (0x00-0x09)
wStoryModePartnerCharacterStrokeStat:: db

; [8-bit] Story Mode - Partner Character Volley Stat (0x00-0x09)
wStoryModePartnerCharacterVolleyStat:: db

; [8-bit] Story Mode - Partner Character Angle Stat (0x00-0x09)
wStoryModePartnerCharacterAngleStat:: db

; [8-bit] Story Mode - Partner Character Placement Stat (0x00-0x09)
wStoryModePartnerCharacterPlacementStat:: db

; [8-bit] Story Mode - Partner Character Speed Stat (0x00-0x09)
wStoryModePartnerCharacterSpeedStat:: db

; [8-bit] Story Mode - Partner Character Dash Stat (0x00-0x09)
wStoryModePartnerCharacterDashStat:: db

; [8-bit] Story Mode - Partner Character Reaction Stat (0x00-0x09)
wStoryModePartnerCharacterReactionStat:: db

; [8-bit] Story Mode - Partner Character Stop Stat (0x00-0x09)
wStoryModePartnerCharacterStopStat:: db
; [8-bit] Character record +$2b of the saved-slot mirror: speed bonus (see wStoryMainCharSpeedBonus)
wStoryModePartnerCharacterSpeedBonus:: db

; [3 bytes] Story Mode - Partner Character EXP, capped at 99999 by AddExpCapped
wStoryModePartnerCharacterEXP:: ds 3
; [8-bit] Character record +$2f of the saved-slot mirror: write-only build tag (see wStoryMainCharBuildKind)
wStoryModePartnerCharacterBuildKind:: db

; [8 bytes] Saved-slot mirror partner record +$30-$37: physics template, copied into +$10-$17 by RecomputeCharacterStats
wStoryModePartnerCharacterPhysicsTemplate:: ds 8

; [8-bit] Story Mode - Partner Character Spin Level
wStoryModePartnerCharacterSpinLevel:: db

; [8-bit] Story Mode - Partner Character Power Level
wStoryModePartnerCharacterPowerLevel:: db

; [8-bit] Story Mode - Partner Character Control Level
wStoryModePartnerCharacterControlLevel:: db

; [8-bit] Story Mode - Partner Character Speed Level
wStoryModePartnerCharacterSpeedLevel:: db
	ds 4

; [4 bytes] Signature that tells story saves apart. CacheStorySlotSummaries copies each slot's to $d400 + slot * 4, CheckStorySignatureCollision compares them, GenerateUniqueStorySaveSignature rerolls from wStoryRandomBytes until no slot matches
wStorySaveSignature:: ds 4

; [3 bytes] Tag InitStoryModeState stamps on a fresh story slot: $56 then two zero bytes
wStorySlotBlockTag:: ds 3
	ds 7

; [4 bytes] Copy of wGameTimer taken by SaveGameTimer with interrupts off, so a screen that stops the clock can restore it (RestoreGameTimer)
wSavedGameTimer:: dw

; [2 bytes] The pair CharDataValuesSyncTask pushes into the character-data screen at $d14c when $d149 is clear (wGameTimer + 2 when set)
wCharDataSyncValues:: dw
	ds 17

; [8-bit] Sound options. Bit 0 is music on/off: Unused_1a_ToggleMusicSetting flips it and Unused_00_SyncBGMEnableFlag mirrors it into hMusic bit 0, stopping the BGM when clear. Other bits are preserved
wSoundOptionBits:: db

; [8-bit] Message Speed
;
; 0x00 - Fast
; 0x01 - Normal
; 0x02 - Slow
wMessageSpeed:: db

; [8-bit] Set to 1 by the Save & Quit entries of the match and story pause menus (MatchQuitMenu_SaveAndQuit, StoryPauseMenu_SaveQuit, the story menu's confirm prompt), which also call SaveStoryReturnPoint. Bank $10's post-match code then shows the results screen and saves the slot, and clears it with wKeepMatchStatsFlag
wSaveAndQuitRequest:: db

; [8-bit] Game Mode
;
; 0x00 - Not playing tennis
; 0x01 - Story Mode - Ranking Match
; 0x02 - Story Mode - Island Open Match
; 0x03 - Story Mode - Practice Match
; 0x04 - Exhibition Mode
; 0x05 - Story Mode - Training Court Minigames
; 0x06 - Story Mode - Tennis Machine
; 0x07 - Story Mode - Wall Practice
; 0x08 - Mario Minigames
; 0x09 - Link-cable Versus Match
; 0x0a - Story Mode - Dream Match
;
; See GAMEMODE_* in include/constants.inc. Bank $38 sets 0x09 right after RunLinkCharSelectScreen. SaveQuitMenuIdByGameMode and ScoreboardModeGfxPointers index it unguarded, 11 entries each
wGameMode:: db

; [8-bit] Nonzero makes ResetMatchState keep the per-character match stats (set by MatchQuitMenu_SaveAndQuit so a resumed match keeps them); cleared after use
wKeepMatchStatsFlag:: db

; [8-bit] Nonzero selects VictoryScoreTable1 over VictoryScoreTable in GetVictoryScore; set on two paths of the match-select handler
wVictoryScoreTableAlt:: db

; [8-bit] Location SaveStoryReturnPoint recorded to return to; called with b = $ff it snapshots the live position instead of a door
wStoryReturnLocation:: db

; [8-bit] Entry point paired with wStoryReturnLocation, or $ff = no door, restore wStoryReturnPosition (RestoreStoryReturnPoint)
wStoryReturnEntryPoint:: db

; [5 bytes] Player X, Y and facing saved with the return point, in the wStoryModeSpawnPosition layout it is copied back into
wStoryReturnPosition:: ds 5
	export_size wStoryReturnPosition
	ds 1

; [16-bit] EXP an exhibition match earned, held by AwardExhibitionMatchExp until ApplyPendingExpAwards runs after the results screens
wPendingExpExhibition:: dw

; [16-bit] The same for a linked-play match (AwardLinkedPlayMatchExp)
wPendingExpLinked:: dw

; [4 bytes] Per player slot, the character the suspended or link match was set up with, from wCharSelectSlotChars (StoreLinkMatchCharInfo) or the exhibition save block (CopyExhibitionCharSlotIds). Bit 7 marks a created story character, the low bits its story slot
wMatchSlotCharRefs:: ds 4

; [8-bit] hLinkState as StoreLinkMatchCharInfo saw it when the link match's characters were committed. The results and EXP screens turn it into the local player's per-character WRAM bank with `srl a / add a, $04`
wLinkMatchRole:: db

; [8-bit] Byte +$02 of the chosen created-character record, saved by StoreLinkMatchCharInfo for the EXP screen panels
wLinkMatchCharLevel:: db

; [4 bytes] Random bytes stirred by RollStoryRandomByte; GenerateUniqueStorySaveSignature copies them into wStorySaveSignature
wStoryRandomBytes:: ds 4
	ds 1

; [8-bit] Character 1 Service Aces
wCharacter1ServiceAces:: db

; [8-bit] Character 1 Return Aces
wCharacter1ReturnAces:: db

; [8-bit] Character 1 Smash Aces
wCharacter1SmashAces:: db

; [8-bit] Character 1 Lob Shot Winners
wCharacter1LobShotWinners:: db

; [8-bit] Character 1 Drop Shot Winners
wCharacter1DropShotWinners:: db

; [8-bit] Character 1 Faults
wCharacter1Faults:: db

; [8-bit] Character 1 Double Faults
wCharacter1DoubleFaults:: db
	ds 1

; [8-bit] Character 2 Service Aces
wCharacter2ServiceAces:: db

; [8-bit] Character 2 Return Aces
wCharacter2ReturnAces:: db

; [8-bit] Character 2 Smash Aces
wCharacter2SmashAces:: db

; [8-bit] Character 2 Lob Shot Winners
wCharacter2LobShotWinners:: db

; [8-bit] Character 2 Drop Shot Winners
wCharacter2DropShotWinners:: db

; [8-bit] Character 2 Faults
wCharacter2Faults:: db

; [8-bit] Character 2 Double Faults
wCharacter2DoubleFaults:: db

; [8-bit] wCharCourtPos as of last frame. CheckServerEndChanged swaps the new value in and raises wChangeEndsPending when bit 1 differs; UpdateViewFlipState reads it for the flipped view
wPrevCourtPos:: db

; [8-bit] Character 3 Service Aces
wCharacter3ServiceAces:: db

; [8-bit] Character 3 Return Aces
wCharacter3ReturnAces:: db

; [8-bit] Character 3 Smash Aces
wCharacter3SmashAces:: db

; [8-bit] Character 3 Lob Shot Winners
wCharacter3LobShotWinners:: db

; [8-bit] Character 3 Drop Shot Winners
wCharacter3DropShotWinners:: db

; [8-bit] Character 3 Faults (sixth byte of the stat block; the label repeats DropShotWinners)
wCharacter3Faults:: db

; [8-bit] Character 3 Double Faults
wCharacter3DoubleFaults:: db
	ds 1

; [8-bit] Character 4 Service Aces
wCharacter4ServiceAces:: db

; [8-bit] Character 4 Return Aces
wCharacter4ReturnAces:: db

; [8-bit] Character 4 Smash Aces
wCharacter4SmashAces:: db

; [8-bit] Player 4 Lob Shot Winners
wCharacter4LobShotWinners:: db

; [8-bit] Character 4 Drop Shot Winners
wCharacter4DropShotWinners:: db

; [8-bit] Character 4 Faults
wCharacter4Faults:: db

; [8-bit] Character 4 Double Faults
wCharacter4DoubleFaults:: db

; [8-bit] Match RNG state: seeded from hVBlankCounter at match start, stirred by AdvanceMatchRng (+$73 plus ball position bytes)
wMatchRngState:: db

; [8-bit] Player 1 Sets Won (0x00-0x03)
wPlayer1SetsWon:: db

; [8-bit] Player 2 Sets Won (0x00-0x03)
wPlayer2SetsWon:: db

; [8-bit] Player 1 Games Won (0x00-0x07)
wPlayer1GamesWon:: db

; [8-bit] Player 2 Games Won (0x00-0x07)
wPlayer2GamesWon:: db

; [8-bit] Player 1 Points Won
;
; 0x00 - 0
; 0x01 - 15
; 0x02 - 30
; 0x03 - 40
; 0x04 - Advantage/Deuce
; 0x05-0x07 - Tiebreaker only
wPlayer1PointsWon:: db

; [8-bit] Player 2 Points Won; values as wPlayer1PointsWon
wPlayer2PointsWon:: db

; [8-bit] Deuce Indicator (0x01 when deuce, 0x00 otherwise)
wDeuceIndicator:: db

; [8-bit] Tiebreaker Indicator (0x01 when tiebreaker, 0x00 otherwise)
wTiebreakerIndicator:: db

; [8-bit] Match Win/Lose Flag (0x01 - win, 0xff - lose, 0x00 otherwise)
wMatchWinLoseFlag:: db

; [8-bit] Set Win/Lose Flag (0x01 - win, 0xff - lose, 0x00 otherwise)
wSetWinLoseFlag:: db

; [8-bit] Game Win/Lose Flag (0x01 - win, 0xff - lose, 0x00 otherwise)
wGameWinLoseFlag:: db

; [8-bit] Point Win/Lose Flag (0x01 - win, 0xff - lose, 0x00 otherwise)
wPointWinLoseFlag:: db

; [8-bit] Total Games Won In Match
wTotalGamesWonInMatch:: db

; [8-bit] Total Points Scored In Current Game
wTotalPointsScoredInCurrentGame:: db

; [8-bit] 1 after a first-serve fault (the next fault is a double fault, point outcome 2); cleared on double fault and at match reset
wServeFaultFlag:: db
	ds 1

; [8-bit] Match Type - Number Of Sets (0x01, 0x03, 0x05)
wMatchTypeNumberOfSets:: db

; [8-bit] Match Type - Number Of Games (0x02, 0x06)
wMatchTypeNumberOfGames:: db

; [8-bit] Nonzero when the current match is doubles; selects the wider court bound and 4 on-court characters
wMatchIsDoubles:: db

; [8-bit] Number of characters on court (2 singles, 4 doubles, 3 in Two-On-One); one banked WRAM struct each in banks 4-7
wOnCourtCharCount:: db

; [8-bit] Currently Used Court
;
; 0x00 - Hard Court
; 0x01 - Clay Court
; 0x02 - Grass Court (Exhibition)
; 0x03 - Composition Court
; 0x04 - Star Court
; 0x05 - Castle Court
; 0x06 - Tropics Court
; 0x07 - Jungle Court
; 0x08 - Warehouse Court
; 0x09 - Training Court (Practice)
; 0x0a - Tennis Machine
; 0x0b - Wall Practice
; 0x0c - Center Court (Island Open Finals)
; 0x0d - Grass Court (Island Open)
; 0x0f - Target Shot
; 0x10 - Shooting Star
; 0x11 - Banana Bunch
; 0x12 - Boo Blast
; 0x13 - Perfect Shot
; 0x14 - Treasure Box
; 0x15 - Medallion Match
; 0x16 - Fruit Fantasy
; 0x17 - Two-On-One
; 0x18 - Training Court (Match)
wCurrentlyUsedCourt:: db

; [8-bit] Kind of match running: 0 = exhibition (cleared by RestoreOverworldAfterMatch), 1 = story match (InitStoryMatchSettings), 2 = minigame/drill (InitMinigameMatchSettings, RunDoublesDrillMatch). At 2, SelectScoreboardLayout forces the doubles scoreboard and InitViewFlipPreference the fixed court view
wMatchContext:: db

; [16-bit BE] Current Minigame/Story Match
;
; 0x0000 - Singles Junior Practice Match
; 0x0001 - Singles Junior #4
; 0x0002 - Singles Junior #3
; 0x0003 - Singles Junior #2
; 0x0004 - Singles Junior #1
; 0x0005 - Singles Senior Practice Match
; 0x0006 - Singles Senior #4
; 0x0007 - Singles Senior #3
; 0x0008 - Singles Senior #2
; 0x0009 - Singles Senior #1
; 0x000a - Singles Varsity Practice Match
; 0x000b - Singles Varsity #4
; 0x0010 - Singles Island Open Round 1
; 0x0011 - Singles Island Open Round 2
; 0x0012 - Singles Island Open Semifinals
; 0x0013 - Singles Island Open Finals
; 0x0016 - Singles Dream Match (MAX)
; 0x0017 - Singles Dream Match (Intense)
; 0x0018 - Singles Dream Match (Hard/First time)
; 0x0100 - Doubles Junior Practice Match
; 0x0102 - Doubles Junior #3
; 0x0103 - Doubles Junior #2
; 0x0104 - Doubles Junior #1
; 0x0105 - Doubles Senior Practice Match
; 0x0107 - Doubles Senior #3
; 0x0108 - Doubles Senior #2
; 0x0109 - Doubles Senior #1
; 0x010a - Doubles Varsity Practice Match
; 0x010d - Doubles Varsity #2
; 0x0111 - Doubles Island Open Round 1
; 0x0112 - Doubles Island Open Semifinals
; 0x0113 - Doubles Island Open Finals
; 0x0116 - Doubles Dream Match (MAX)
; 0x0117 - Doubles Dream Match (Intense)
; 0x0118 - Doubles Dream Match (Hard/First time)
; 0x0200 - Service Match 1
; 0x0201 - Service Match 2
; 0x0202 - Service Match 3
; 0x0203 - Service Practice 1
; 0x0204 - Service Practice 2
; 0x0205 - Service Practice 3
; 0x0206 - Net Play Match 1
; 0x0207 - Net Play Match 2
; 0x0208 - Net Play Match 3
; 0x0209 - Net Play Practice 1
; 0x020a - Net Play Practice 2
; 0x020b - Net Play Practice 3
; 0x020c - Stroke Match 1
; 0x020d - Stroke Match 2
; 0x020e - Stroke Match 3
; 0x020f - Stroke Practice 1
; 0x0210 - Stroke Practice 2
; 0x0211 - Stroke Practice 3
; 0x0212 - Tennis Machine 1
; 0x0213 - Tennis Machine 2
; 0x0214 - Tennis Machine 3
; 0x0215 - Tennis Machine 4
; 0x0216 - Wall Practice 1
; 0x0217 - Wall Practice 2
; 0x0218 - Wall Practice 3
; 0x0219 - Wall Practice 4
; 0x021a - Tennis Machine High Score
; 0x021b - Wall Practice High Score
; 0x021c - Boo Blast
; 0x021d - Shooting Star
; 0x021e - Perfect Shot
; 0x021f - Target Shot
; 0x0220 - Fruit Fantasy
; 0x0221 - Banana Bunch
; 0x0222 - Treasure Box
; 0x0223 - Medallion Match
; 0x0224 - Two-On-One
wCurrentMinigameStoryMatch:: dw

; [8-bit] BGM id (wCurrentBGM values) for the current match/court; a tiebreak overrides it with $0e
wMatchBGM:: db
	ds 7

; [ASCII, 7 Bytes] Story Mode - Name of Main Character
wStoryModeNameOfMainCharacter:: ds 7

; [4 bytes] Live main character record +$07-$0a: name terminator and padding after the 7-character name
wStoryMainCharNamePad:: ds 4

; [8-bit] Story Mode - Main Character Overworld Sprite
;
; 0x00 - Alex
; 0x01 - Nina
; 0x02 - Harry
; 0x03 - Kate
; Loops for all other values
wStoryModeMainCharacterOverworldSprite:: db

; [8-bit] Story Mode - Main Character Overworld Sprite Color
;
; 0x00 - Green
; 0x01 - Pink
; 0x02 - Yellow
; 0x03 - Red
; 0x04 - Blue
; All other values result in glitched sprite
wStoryModeMainCharacterOverworldSpriteColor:: db

; [8-bit] Main character's gender: $00 = male, $01 = female. Set from StoryCharGenderTable by InitPlayerRecordFromTemplate, read-only after. Selects gendered dialogue lines through AdvanceDialogueTextCursor (e.g. $30:433/$30:434 "him"/"her", $31:60/$31:61 "He's"/"She's") and the overworld object def ($56 + gender)
wStoryModeGenderOfMainCharacter:: db

; [8-bit] Nonzero when the main character is left-handed (record +$0e). Written from wCharSelectHandedness by bank $38 and, on bank $02's new-game path, from bit 2 of the character id. Bank $17 swaps the spin-serve briefing between $36:696 and its mirror $36:697 on it
wStoryModeMainCharacterLeftHanded:: db

; [9 bytes] Live main character record +$0f-$17: AI and physics attributes from StoryCharacterRecords_02: +$0f personality byte, +$10-$17 reach windows, smash and dive speeds and reaction delays, refreshed by RecomputeCharacterStats from the +$30 template
wStoryMainCharPhysics:: ds 9

; [8-bit] EXP tier of the main character's record (+$18, the field LoadCharacterAttributes turns into wCharExpTier on court). ScaleExpByPlayerLevel averages it with wStoryPartnerCharExpTier and scales match EXP down against $0a
wStoryMainCharExpTier:: db

; [2 bytes] Live main character record +$19-$1a: swing attribute word
wStoryMainCharSwingAttrWord:: dw

; [5 bytes] Live main character record +$1b-$1f: AI personality parameters (docs/story_mode.md, "The character record")
wStoryMainCharAiParams:: ds 5

; [11 bytes] The eleven 0-9 stats of the main character's record (+$20): Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop
wStoryMainCharStats:: ds 11
; [8-bit] Record +$2b: speed bonus, the last byte InitCa00RecordFromCharId copies from the roster row; LoadCharacterAttributes adds it to the Speed stat to pick the shot-placement row
wStoryMainCharSpeedBonus:: db

; [3 bytes] EXP in the main character's record (+$2c), capped at 99999 by AddExpCapped
wStoryMainCharExp:: ds 3
; [8-bit] Record +$2f: written by InitCa00RecordFromCharId ($02 roster, $03 story main character, $00 cleared); nothing reads it
wStoryMainCharBuildKind:: db

; [8 bytes] Live main character record +$30-$37: physics template, copied into +$10-$17 by RecomputeCharacterStats
wStoryMainCharPhysicsTemplate:: ds 8

; [8-bit] Spin level (record +$38); the four levels shown on character select start here
wStoryMainCharSpinLevel:: db

; [8-bit] Power level, the record's +$39
wStoryMainCharPowerLevel:: db

; [8-bit] Control level, the record's +$3a
wStoryMainCharControlLevel:: db

; [8-bit] Speed level, the record's +$3b
wStoryMainCharSpeedLevel:: db

; [Lower4] Equipped Racket
;
; 0x0 - Normal Racket
; 0x1 - Large Racket
; 0x2 - Small Racket
; 0x3 - Iron Racket
; 0x4 - Gold Racket
; 0x5 - Silver Racket
; 0x6 - Drive Racket
;
; [Upper4] Equipped Shoes
;
; 0x0 - Normal Shoes
; 0x1 - Iron Shoes
; 0x2 - Light Shoes
wEquippedRacket:: db
	ds 3

; [ASCII, 7 Bytes] Story Mode - Name of Partner Character
wStoryModeNameOfPartnerCharacter:: ds 7

; [4 bytes] Live partner record +$07-$0a: name terminator and padding after the 7-character name
wStoryPartnerCharNamePad:: ds 4

; [8-bit] Partner Character Overworld Sprite; values as wStoryModeMainCharacterOverworldSprite
wStoryModePartnerCharacterOverworldSprite:: db

; [8-bit] Partner Character Overworld Sprite Color; values as wStoryModeMainCharacterOverworldSpriteColor
wStoryModePartnerCharacterOverworldSpriteColor:: db

; [8-bit] Doubles partner's gender ($00 male, $01 female). Selects the partner object def ($58 + gender) and, with the main character's, the four-way scene key (main << 1) | (main XOR partner) passed to RunStorySceneByMode in bank $13
wStoryModeGenderOfPartnerCharacter:: db

; [8-bit] Partner's left-handed flag (record +$0e), written by the same character-select path as wStoryModeMainCharacterLeftHanded
wStoryModePartnerCharacterLeftHanded:: db

; [9 bytes] Live partner record +$0f-$17: AI and physics attributes, as wStoryMainCharPhysics
wStoryPartnerCharPhysics:: ds 9

; [8-bit] EXP tier of the partner's record (+$18), the partner half of wStoryMainCharExpTier
wStoryPartnerCharExpTier:: db

; [2 bytes] Live partner record +$19-$1a: swing attribute word
wStoryPartnerCharSwingAttrWord:: dw

; [5 bytes] Live partner record +$1b-$1f: AI personality parameters
wStoryPartnerCharAiParams:: ds 5

; [11 bytes] Live partner record +$20-$2a: the eleven 0-9 stats, order as wStoryMainCharStats
wStoryPartnerCharStats:: ds 11
; [8-bit] Record +$2b: speed bonus (see wStoryMainCharSpeedBonus)
wStoryPartnerCharSpeedBonus:: db

; [3 bytes] EXP in the partner's record (+$2c), capped at 99999 by AddExpCapped
wStoryPartnerCharExp:: ds 3
; [8-bit] Record +$2f: build tag, write-only (see wStoryMainCharBuildKind)
wStoryPartnerCharBuildKind:: db

; [8 bytes] Live partner record +$30-$37: physics template, copied into +$10-$17 by RecomputeCharacterStats
wStoryPartnerCharPhysicsTemplate:: ds 8

; [8-bit] Spin level (record +$38)
wStoryPartnerCharSpinLevel:: db

; [8-bit] Power level, the record's +$39
wStoryPartnerCharPowerLevel:: db

; [8-bit] Control level, the record's +$3a
wStoryPartnerCharControlLevel:: db

; [8-bit] Speed level, the record's +$3b
wStoryPartnerCharSpeedLevel:: db
	ds 52

; [16-bit] EXP a story match earned, pending like wPendingExpExhibition / wPendingExpLinked. ApplyPendingExpAwards adds it to wPendingExpTrophy, scales the total by player level and folds in the trophy awards
wPendingExpStory:: dw

; [16-bit] Trophy half of the pending award, summed with wPendingExpStory before scaling. Unused_02_ValidateN64TransferRecord and the debug stats screen treat the pair as the head of the N64 transfer record that wN64TransferMarker ends
wPendingExpTrophy:: dw

; [8-bit] Marker byte of the N64 transfer record at $c9b0: Unused_02_ValidateN64TransferRecord rejects the record unless it is $64, then checksums the bytes around it
wN64TransferMarker:: db

; [2 bytes] Trophies transferred from the N64 game, two bits per trophy (0-3) for eight trophies. DecodeTrophyCounts unpacks them into the trophy screen's cells; the EXP award path walks them tier by tier to pick a TrophyExpForGroupTable row
wN64TrophyCounts:: dw
	ds 9

; [32 bytes] Per-story-slot progress flags, $c9c0-$c9df, saved as the slot's +$1c0 block. rst $20/$28/$30 (SetGameFlag/ClearGameFlag/TestGameFlag) take d = byte index, e = bit << 5 and apply mask $80 >> bit; the *GameFlagByNumber wrappers take the flat number byte * 8 + bit, as held by the FLAG_* constants in include/flag_constants.inc. The array is only accessed through these, so the named entries below are views of the same storage: byte $05 = doubles, $06/$07 = Island Open + Dream Match, $08-$0b = class rank wins, $0c/$0d = equipment owned, $18-$1b = training-drill clears, $1c-$1f = temporary (wGameFlagsTemp)
wGameFlags:: ds 5

; [8-bit] Singles/Doubles Indicator (Story & Exhibition Mode)
;
; 0x00 - Singles
; 0x01 - Doubles
wSinglesDoublesIndicator:: db

; [Lower4] Story Mode - Match Completion Flags (1/6)
;
; Bit 0 - Doubles Island Open Round 1
; Bit 1 - Doubles Island Open Semifinals
; Bit 2 - Doubles Island Open Finals
; Bit 3 - Doubles Dream Match
wStoryModeMatchCompletionFlags1:: db

; [8-bit] Story Mode - Match Completion Flags (2/6)
;
; Bit 0 - Singles Island Open Round 1
; Bit 1 - Singles Island Open Round 2
; Bit 2 - Singles Island Open Semifinals
; Bit 3 - Singles Island Open Finals
; Bit 4 - Singles Dream Match
wStoryModeMatchCompletionFlags2:: db

; [8-bit] Story Mode - Match Completion Flags (3/6)
;
; Bit 7 - Doubles Junior Rank 3
; Bit 6 - Doubles Junior Rank 2
; Bit 5 - Doubles Junior Rank 1
; Bit 3 - Doubles Senior Rank 3
; Bit 2 - Doubles Senior Rank 2
; Bit 1 - Doubles Senior Rank 1
wStoryModeMatchCompletionFlags3:: db

; [Upper4] Story Mode - Match Completion Flags (4/6)
;
; Bit 7 - Doubles Varsity Rank 2
wStoryModeMatchCompletionFlags4:: db

; [8-bit] Story Mode - Match Completion Flags (5/6)
;
; Bit 7 - Singles Junior Rank 4
; Bit 6 - Singles Junior Rank 3
; Bit 5 - Singles Junior Rank 2
; Bit 4 - Singles Junior Rank 1
; Bit 3 - Singles Senior Rank 4
; Bit 2 - Singles Senior Rank 3
; Bit 1 - Singles Senior Rank 2
; Bit 0 - Singles Senior Rank 1
wStoryModeMatchCompletionFlags5:: db

; [Upper4] Story Mode - Match Completion Flags (6/6)
;
; Bit 7 - Singles Varsity Rank 4
wStoryModeMatchCompletionFlags6:: db

; [8-bit] Story Mode - Equipment Flags (1/2)
;
; Bit 6 - Large Racket
; Bit 5 - Small Racket
; Bit 4 - Iron Racket
; Bit 3 - Silver Racket
; Bit 2 - Gold Racket
; Bit 1 - Drive Racket
; Bit 0 - Iron Shoes
wStoryModeEquipmentFlags1:: db

; [Upper4] Story Mode - Equipment Flags (2/2)
;
; Bit 7 - Light Shoes
wStoryModeEquipmentFlags2:: db

; [3 bytes] wGameFlags bytes $0e-$10 (flags 112-135): NPC talked/moved/turned and scene-seen flags (FLAG_*_TALKED_*, FLAG_*_MOVED, FLAG_REPAIR_COUNTER_*, FLAG_AWARDS_CEREMONY_SEEN_*, ...; include/flag_constants.inc)
wStoryModeNpcEventFlags:: ds 3

; [3 bytes] wGameFlags bytes $11-$13 (flags 136-159): no FLAG_* uses them; saved with the slot, never used
wGameFlagsSpare:: ds 3

; [2 bytes] wGameFlags bytes $14-$15 (flags 160-175): FLAG_CHEAT_UNLOCK_0-12 (set by the unlock-everything cheat, never read), then FLAG_REACHED_ISLAND_OPEN_SINGLES/DOUBLES
wCheatUnlockFlags:: dw

; [2 bytes] wGameFlags bytes $16-$17 (flags 176-191): FLAG_STORY_COMPLETE_*, FLAG_REACHED_MARIO_WORLD_*, FLAG_ENDING_SEEN_*, FLAG_ISLAND_OPEN_IN_PROGRESS, the three *_CHALLENGER_DEFEATED and three *_COACH_GREETED bits
wStoryProgressFlags:: dw

; [8-bit] Story Mode - Minigame Completion Flags (1/4)
;
; Bit 7 - Service Match 1
; Bit 6 - Service Match 2
; Bit 5 - Service Match 3
; Bit 4 - Service Practice 1
; Bit 3 - Service Practice 2
; Bit 2 - Service Practice 3
; Bit 1 - Net Play Match 1
; Bit 0 - Net Play Match 2
wStoryModeMinigameCompletionFlags1:: db

; [8-bit] Story Mode - Minigame Completion Flags (2/4)
;
; Bit 7 - Net Play Match 3
; Bit 6 - Net Play Practice 1
; Bit 5 - Net Play Practice 2
; Bit 4 - Net Play Practice 3
; Bit 3 - Stroke Match 1
; Bit 2 - Stroke Match 2
; Bit 1 - Stroke Match 3
; Bit 0 - Stroke Practice 1
wStoryModeMinigameCompletionFlags2:: db

; [8-bit] Story Mode - Minigame Completion Flags (3/4)
;
; Bit 7 - Stroke Practice 2
; Bit 6 - Stroke Practice 3
; Bit 5 - Machine Level 1
; Bit 4 - Machine Level 2
; Bit 3 - Machine Level 3
; Bit 2 - Machine Level 4
; Bit 1 - Wall Level 1
; Bit 0 - Wall Level 2
wStoryModeMinigameCompletionFlags3:: db

; [Upper4] Story Mode - Minigame Completion Flags (4/4)
;
; Bit 7 - Wall Level 3
; Bit 6 - Wall Level 4
wStoryModeMinigameCompletionFlags4:: db

; [4 bytes] wGameFlags bytes $1c-$1f (flags $e0-$ff), temporary: ClearTemporaryStoryFlags zeroes them at the top of RunStoryLocation, so they last until the next location load. Used for per-location NPC/scene-variant state ($1c) and the screen-mode bits the progress and results screens set and clear ($1f)
wGameFlagsTemp:: ds 4
	ds 32

; [7 bytes] Display name of the player-1 main character, base of its $40-byte on-court character record. The results screen draws it via CopyStringToTextBuffer; LoadCharacterAttributes copies the record's physics and AI attributes into the character's banked struct
wPlayer1MainName:: ds 7

; [3 bytes] Player-1 main record +$07-$09: name terminator and padding
wPlayer1MainNamePad:: ds 3

; [8-bit] Record +$0a of the player-1 main record, borrowed by ExchangeLinkUnlockFlags as the cell the peer's bonus-court unlock mask arrives in. Whichever of this and wPlayer2MainLinkCourtMask matches the link role is copied to wLinkPartnerCourtMask, then both are cleared
wPlayer1MainLinkCourtMask:: db

; [8-bit] Player 1 Current Main Character
;
; 0x00 - Alex
; 0x01 - Nina
; 0x02 - Harry
; 0x03 - Kate
; 0x04 - Allie
; 0x05 - Joy
; 0x06 - Brian
; 0x07 - Pam
; 0x08 - Bob
; 0x09 - Beth
; 0x0a - Fay
; 0x0b - Curt
; 0x0c - Mark
; 0x0d - Sean
; 0x0e - Sammi
; 0x0f - Elden
; 0x10 - Spike
; 0x11 - Emily
; 0x12 - B. Coz
; 0x13 - A. Coz
; 0x14 - Kevin (dummied out)
; 0x15 - Tennis Machine
; 0x16 - Allie 2
; 0x17 - Luigi
; 0x18 - Donkey Kong
; 0x19 - Baby Mario
; 0x1a - Mario
; 0x1b - Waluigi
; 0x1c - Yoshi
; 0x1d - Bowser
; 0x1e - Wario
; 0x1f - Peach
wPlayer1CurrentMainCharacter:: db

; [8-bit] Palette index of the player-1 main character: LoadResultPortraitSlot passes it to LoadIndexedPalette_18; InitChar passes it plus 3 to SetupCharacterSprite as the OBJ palette
wPlayer1MainPalette:: db
; [8-bit] Record +$0d: gender, 0 male / 1 female (InitPlayerRecordFromTemplate; StoryCharGenderTable for story records)
wPlayer1MainGender:: db

; [8-bit] Nonzero mirrors the player-1 main character: LoadCharacterAttributes turns it into wCharMirrorAttrMask ($20, OAM X-flip) and the results-screen portrait XORs the same bit. ApplyStarFlagsToCharRecords seeds it from wCharSelectSlotStar
wPlayer1MainLeftHanded:: db

; [9 bytes] Player-1 main record +$0f-$17: AI and physics attributes, as wStoryMainCharPhysics
wPlayer1MainPhysics:: ds 9

; [8-bit] EXP tier of the player-1 main character (record +$18): the level (1-99) for a player character, the class tier for a roster NPC
wPlayer1MainExpTier:: db

; [2 bytes] Player-1 main record +$19-$1a: swing attribute word
wPlayer1MainSwingAttrWord:: dw

; [5 bytes] Player-1 main record +$1b-$1f: AI personality parameters (docs/story_mode.md, "The character record")
wPlayer1MainAiParams:: ds 5

; [11 bytes] Player-1 main record +$20-$2a: the eleven 0-9 stats, order as wStoryMainCharStats
wPlayer1MainStats:: ds 11
; [8-bit] Record +$2b: speed bonus (see wStoryMainCharSpeedBonus)
wPlayer1MainSpeedBonus:: db

; [3 bytes] Player-1 main record +$2c-$2e: EXP, capped at 99999 by AddExpCapped
wPlayer1MainExp:: ds 3
; [8-bit] Record +$2f: build tag, write-only (see wStoryMainCharBuildKind)
wPlayer1MainBuildKind:: db

; [8 bytes] Player-1 main record +$30-$37: physics template, copied into +$10-$17 by RecomputeCharacterStats
wPlayer1MainPhysicsTemplate:: ds 8

; [4 bytes] Player-1 main record +$38-$3b: the four trainable levels: Spin, Power, Control, Speed
wPlayer1MainTrainLevels:: ds 4

; [8-bit] Equipment nibbles of the player-1 main character (as wEquippedRacket in the story record). ApplyMatchSettingsExpBonus gives a handicap EXP bonus: low nibble $03 is one step, high nibble $01 another, two steps double the match EXP
wPlayer1MainEquipment:: db
	ds 3

; [7 bytes] Display name and record base of the player-1 partner (doubles counterpart of wPlayer1MainName)
wPlayer1PartnerName:: ds 7

; [4 bytes] Player-1 partner record +$07-$0a: name terminator and padding
wPlayer1PartnerNamePad:: ds 4

; [8-bit] Player 1 Current Partner Character; values as wPlayer1CurrentMainCharacter
wPlayer1CurrentPartnerCharacter:: db

; [8-bit] Palette index of the player-1 partner (see wPlayer1MainPalette)
wPlayer1PartnerPalette:: db
; [8-bit] Record +$0d: gender, 0 male / 1 female (see wPlayer1MainGender)
wPlayer1PartnerGender:: db

; [8-bit] Mirror flag of the player-1 partner (see wPlayer1MainLeftHanded)
wPlayer1PartnerLeftHanded:: db

; [9 bytes] Player-1 partner record +$0f-$17: AI and physics attributes, as wStoryMainCharPhysics
wPlayer1PartnerPhysics:: ds 9

; [8-bit] EXP tier of the player-1 partner (record +$18). ApplyCpuDifficultyToCharRecords writes it from the difficulty row unless the slot is a created character, which keeps its earned tier
wPlayer1PartnerExpTier:: db

; [2 bytes] Player-1 partner record +$19-$1a: swing attribute word
wPlayer1PartnerSwingAttrWord:: dw

; [4 bytes] Four of the player-1 partner's six AI personality parameters (record +$1b-$1e; +$0f and +$1f are the others). ApplyCpuDifficultyToCharRecords copies them from the difficulty row; OverrideCharStatsForDebug rewrites this block
wPlayer1PartnerAiParams:: ds 4

; [8-bit] Exhibition Mode - Player Partner Character Difficulty
;
; 0x00 - Easy
; 0x01 - Normal
; 0x02 - Hard
; 0x03 - Intense
wExhibitionModePlayerPartnerCharacterDifficulty:: db

; [11 bytes] Player-1 partner record +$20-$2a: the eleven 0-9 stats, order as wStoryMainCharStats
wPlayer1PartnerStats:: ds 11
; [8-bit] Record +$2b: speed bonus (see wStoryMainCharSpeedBonus)
wPlayer1PartnerSpeedBonus:: db

; [3 bytes] Player-1 partner record +$2c-$2e: EXP, capped at 99999 by AddExpCapped
wPlayer1PartnerExp:: ds 3
; [8-bit] Record +$2f: build tag, write-only (see wStoryMainCharBuildKind)
wPlayer1PartnerBuildKind:: db

; [8 bytes] Player-1 partner record +$30-$37: physics template, copied into +$10-$17 by RecomputeCharacterStats
wPlayer1PartnerPhysicsTemplate:: ds 8

; [4 bytes] Player-1 partner record +$38-$3b: the four trainable levels: Spin, Power, Control, Speed
wPlayer1PartnerTrainLevels:: ds 4
	ds 4

; [7 bytes] Display name and record base of the player-2 main character
wPlayer2MainName:: ds 7

; [3 bytes] Player-2 main record +$07-$09: name terminator and padding
wPlayer2MainNamePad:: ds 3

; [8-bit] The player-2 main record's copy of the unlock-mask exchange cell (see wPlayer1MainLinkCourtMask)
wPlayer2MainLinkCourtMask:: db

; [8-bit] Player 2 Current Main Character; values as wPlayer1CurrentMainCharacter
wPlayer2CurrentMainCharacter:: db

; [8-bit] Palette index of the player-2 main character (see wPlayer1MainPalette)
wPlayer2MainPalette:: db
; [8-bit] Record +$0d: gender, 0 male / 1 female (see wPlayer1MainGender)
wPlayer2MainGender:: db

; [8-bit] Mirror flag of the player-2 main character (see wPlayer1MainLeftHanded)
wPlayer2MainLeftHanded:: db

; [8-bit] Record +$0f: last byte of BooBlastInitParams, stored as the minigame is set up; nothing reads it back
wPlayer2MainInitByte:: db

; [8 bytes] Player-2 main record +$10-$17: reach windows, smash and dive speeds and reaction delays (as wStoryMainCharPhysics +1)
wPlayer2MainPhysicsFrom10:: ds 8

; [8-bit] EXP tier of the player-2 main character (see wPlayer1PartnerExpTier)
wPlayer2MainExpTier:: db

; [2 bytes] Player-2 main record +$19-$1a: swing attribute word
wPlayer2MainSwingAttrWord:: dw

; [4 bytes] Player-2 main character's AI parameter block (see wPlayer1PartnerAiParams); the bank $0b and $0d minigame setups write it to give a drill opponent a fixed personality
wPlayer2MainAiParams:: ds 4

; [8-bit] Exhibition Mode - CPU Main Character Difficulty; values as wExhibitionModePlayerPartnerCharacterDifficulty
wExhibitionModeCPUMainCharacterDifficulty:: db

; [11 bytes] Player-2 main record +$20-$2a: the eleven 0-9 stats, order as wStoryMainCharStats
wPlayer2MainStats:: ds 11
; [8-bit] Record +$2b: speed bonus (see wStoryMainCharSpeedBonus)
wPlayer2MainSpeedBonus:: db

; [3 bytes] Player-2 main record +$2c-$2e: EXP, capped at 99999 by AddExpCapped
wPlayer2MainExp:: ds 3
; [8-bit] Record +$2f: build tag, write-only (see wStoryMainCharBuildKind)
wPlayer2MainBuildKind:: db

; [8 bytes] Player-2 main record +$30-$37: physics template, copied into +$10-$17 by RecomputeCharacterStats
wPlayer2MainPhysicsTemplate:: ds 8

; [4 bytes] Player-2 main record +$38-$3b: the four trainable levels: Spin, Power, Control, Speed
wPlayer2MainTrainLevels:: ds 4

; [8-bit] Equipment of the player-2 main character (see wPlayer1MainEquipment); read by the link-match EXP path when the local player is player 2
wPlayer2MainEquipment:: db
	ds 3

; [7 bytes] Display name and record base of the player-2 partner
wPlayer2PartnerName:: ds 7

; [4 bytes] Player-2 partner record +$07-$0a: name terminator and padding
wPlayer2PartnerNamePad:: ds 4

; [8-bit] Player 2 Current Partner Character; values as wPlayer1CurrentMainCharacter
wPlayer2CurrentPartnerCharacter:: db

; [8-bit] Palette index of the player-2 partner (see wPlayer1MainPalette)
wPlayer2PartnerPalette:: db
; [8-bit] Record +$0d: gender, 0 male / 1 female (see wPlayer1MainGender)
wPlayer2PartnerGender:: db

; [8-bit] Mirror flag of the player-2 partner (see wPlayer1MainLeftHanded)
wPlayer2PartnerLeftHanded:: db

; [9 bytes] Player-2 partner record +$0f-$17: AI and physics attributes, as wStoryMainCharPhysics
wPlayer2PartnerPhysics:: ds 9

; [8-bit] EXP tier of the player-2 partner (see wPlayer1PartnerExpTier)
wPlayer2PartnerExpTier:: db

; [2 bytes] Player-2 partner record +$19-$1a: swing attribute word
wPlayer2PartnerSwingAttrWord:: dw

; [4 bytes] The player-2 partner's AI parameter block (see wPlayer1PartnerAiParams)
wPlayer2PartnerAiParams:: ds 4

; [8-bit] Exhibition Mode - CPU Partner Character Difficulty; values as wExhibitionModePlayerPartnerCharacterDifficulty
wExhibitionModeCPUPartnerCharacterDifficulty:: db

; [11 bytes] Player-2 partner record +$20-$2a: the eleven 0-9 stats, order as wStoryMainCharStats
wPlayer2PartnerStats:: ds 11
; [8-bit] Record +$2b: speed bonus (see wStoryMainCharSpeedBonus)
wPlayer2PartnerSpeedBonus:: db

; [3 bytes] Player-2 partner record +$2c-$2e: EXP, capped at 99999 by AddExpCapped
wPlayer2PartnerExp:: ds 3
; [8-bit] Record +$2f: build tag, write-only (see wStoryMainCharBuildKind)
wPlayer2PartnerBuildKind:: db

; [8 bytes] Player-2 partner record +$30-$37: physics template, copied into +$10-$17 by RecomputeCharacterStats
wPlayer2PartnerPhysicsTemplate:: ds 8

; [4 bytes] Player-2 partner record +$38-$3b: the four trainable levels: Spin, Power, Control, Speed
wPlayer2PartnerTrainLevels:: ds 4
	ds 4

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


SECTION "WRAMX bank 1", WRAMX[$d000], BANK[1]

; WRAMX bank 1 at a glance:
;
;   $d000-$dfff  cutscene text scroll buffer / character record copy / VRAM staging

; WRAM bank $01 is VRAM staging: every screen decompresses into it and
; QueueVRAMCopies out of it, so an offset means whatever the current screen
; put there (tile graphics, a tilemap plane, its attribute plane). Offsets
; in use are multiples of TILE_SIZE.
; The one fixed overlay is bank $1b's character-record copy:
; LoadCharacterRecordToBuffer writes $d580 in whichever bank the caller
; selected, and bank $1b selects this one while building the new-game roster.
; ShowDmgLockoutScreen (bank $01) also stages here: on a DMG $d000-$dfff is
; the single upper WRAM half, the bytes a CGB calls bank 1.
UNION
; cutscene text scroll buffer (bank $03)
; [640 bytes] Eight 80-column rows of rendered cutscene text: DrawCutsceneTextLines draws each line from column 19 of row 1, and BlitCutsceneTextWindow copies a 20-column window of it, one column further per call, into wWindowShadowTilemap to scroll the text. Both select the bank themselves
wCutsceneTextScrollBuffer:: ds 640
	ds 3456
NEXTU
; character record copy (bank $1b)
	ds 1408
; [128 bytes] Copy of a character record LoadCharacterRecordToBuffer takes from wPlayer2MainName, so one character's fields can be read without disturbing the live records. CheckCharacterUnlocked tests +$0b (the id) against $ff; RunNewGameSetup reads +$0c and +$0e of each starting character
wCharRecordBuffer:: ds 128
NEXTU
; VRAM staging (WRAM bank $01)
; [2048 bytes] Where DecompressData lands and QueueVRAMCopy reads from. A screen may slice it several ways: the cutscene frame loaders keep six frames at tiles 0, 4, 8, 12, 14 and 16; the EXP screen puts a tilemap plane at tile 0 and its attributes at tile 64. Unused_00_CopyMapToScrollBuffers expands map planes from it into WRAM bank $02
wDecompBuffer:: ds 2048
; [2048 bytes] The other half: Unused_1a_DrawStringToTileBuffer renders strings here as tile data (the EXP screen's captions and bonus messages), uploaded like any other graphics
wTextTileBuffer:: ds 2048
	export_size wTextTileBuffer
ENDU


SECTION "WRAMX bank 2", WRAMX[$d000], BANK[2]

; WRAMX bank 2 at a glance:
;
;   $d000-$d3ff  wActiveTilemap  [mirrored with bank 5]
;   $d000-$d41f  wCharDataScreenCell  [mirrored with bank 3]
;   $d000-$dfff  5 overlays: N64 block presence probe / match court planes / overworld scroll buffers / +2 more
;   $d000-$dfff  wMapBuffer64  [mirrored with bank 3]
;   $d400-$d7df  wCharDataPagePlane  [mirrored with bank 3]
;   $d400-$d7ff  wActiveAttrmap  [mirrored with bank 5]
;   $d430-$d66f  wCharDataScreenBackup  [mirrored with bank 3]
;   $d600-$d68f  wMugshotBuffer  [mirrored with bank 3, 4]
;   $d7e0-$da1f  wCharDataPageSlot1  [mirrored with bank 3]
;   $da20-$dc5f  wCharDataPageSlot2  [mirrored with bank 3]
;   $dc60-$de9f  wCharDataPageSlot3  [mirrored with bank 3]

; WRAM bank $02 holds tilemap planes, used three ways: the match keeps the
; court tilemap and attrmap here as a pair, the overworld builds two of its
; four wide scroll planes here, and every full-screen UI uses $d000 as the
; attribute half of the tilemap whose tile half is wShadowTilemap in WRAM
; bank $03. Bank $08 reaches both this bank and WRAM bank $04
; (RefreshCourtScoreboard's $de9x bytes are not court planes).
; Bank $06's in-match UI (ShowMessageWindow, the pause menu) selects this
; bank and calls RestoreBgTilemap / RestoreBgTilemapRegion /
; FlushTilemapToVram, so there $d000 is the tile half sent to VRAM bank 0.
; Bank $0a's LoadCourtSceneGraphics decompresses the court into the saved
; pair at $d800/$dc00 before the match. Bank $0d's LoadMatchUiCourtTilemap
; writes all four planes: the target-zone overlay's tile and attribute
; halves go to $d12b, $d92b, $d52b and $dd2b; QueueMinigameHudVRAMCopy sends
; $d120 to $9920 and $d520 to $9920 + VRAM_BANK1.
UNION
; N64 block presence probe (bank $3b)
; [2 bytes] First two bytes of save block $0b, staged here for CheckN64DataPresent; nonzero means Transfer Pak records exist, which unlocks the N64 entries on the status menu
wN64BlockProbe:: dw
	ds 4094
NEXTU
; match court planes (banks $08/$0d/$06/$0a)
; [1024 bytes] The match's court tilemap; UploadCourtTilemap sends it to $9800 in VRAM bank 0. Kept in WRAM bank $02 because the match uses bank $03 for other things
wCourtTilemap:: ds 1024
	export_size wCourtTilemap
; [1024 bytes] Its CGB attribute plane, cell for cell, uploaded to $9800 in VRAM bank 1 by UploadCourtAttrmap
wCourtAttrmap:: ds 1024
	export_size wCourtAttrmap
; [1024 bytes] Copy of the court tilemap taken when the players change ends; SnapshotCourtTilemaps copies it back over wCourtTilemap to restore the unflipped view
wCourtTilemapSaved:: ds 1024
; [1024 bytes] The attribute half of the same snapshot
wCourtAttrmapSaved:: ds 1024
NEXTU
; overworld scroll buffers (bank 0)
; [1024 bytes] One of the four 64-wide planes Unused_00_CopyMapToScrollBuffers expands the map into, 16 rows of 64 cells, from wDecompBuffer (WRAM bank $01) via wTextBuffer a row block at a time
wMapScrollPlane0:: ds 1024
	ds 1024
; [1024 bytes] The second plane, built the same way and then cleared (2048 bytes, twice what was written). wScreenScratch in WRAM bank $03 gets the same treatment, so two of the four planes are built and discarded
wMapScrollPlane1:: ds 1024
NEXTU
; screen attribute plane
; [1024 bytes] CGB attributes for the full-screen UIs, cell for cell with wShadowTilemap in WRAM bank $03; FlushCharDataTilemapChunk sends the pair to $99e0 in VRAM banks 0 and 1. Written by seventeen ROM banks. The character-data page images above it keep numeric addresses. Plane writers such as FillTilemapRun, WriteTextToTilemap and RenderProportionalTextAt select both banks themselves (tile under $03, attribute under $02)
wScreenAttrmap:: ds 1024
	export_size wScreenAttrmap
NEXTU
; character record scratch (banks $18/$1b/$3b)
	ds 1408
; [128 bytes] The character record a menu is about to draw: LoadCharacterRecordToBuffer has LoadCharacterRecordToCa80 build it and copies 128 bytes here from wPlayer2MainName, so fields line up with that block. +$0b is the character id, tested against $ff by CheckCharacterUnlocked and used as the index by the mugshot and portrait loaders; the `.fixedRecord` shortcut writes $3e into +$0b directly.
; The bank is never selected at the reference; bank $3b's BuildSaveSlotSummaries selects WRAM bank $02 around the call, and reads must use the bank the write went to.
wCharRecordScratch:: ds 128
	export_size wCharRecordScratch
ENDU


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


SECTION "WRAMX bank 4", WRAMX[$d000], BANK[4]

; WRAMX bank 4 at a glance:
;
;   $d000-$d5ff  overworld actors
;   $d600-$d68f  wMugshotBuffer  [mirrored with bank 2, 3]
;   $d800-$dbff  wIntroCharactersTilemap
;   $da00-$da31  actor engine
;   $dac0-$dae9  actor engine
;   $daea-$daf7  actor engine
;   $dc00-$dcd1  minigames / minigame targets
;   $dc00-$dfff  wIntroCharactersAttrmap
;   $dcf0-$dcff  minigame targets
;   $dd00-$dd23  match ball history ring
;   $dd80-$ddcf  match object slots
;   $ddf0-$ddff  match object slots
;   $de00-$de1f  match ball sprite slots
;   $de80-$decf  court scoreboard columns
;   $df00-$df96  match character struct  [one copy per bank 4-7]

; Overworld / story actor slots: 24 records of ACTOR_SIZE bytes, the array
; SpawnActor allocates from and the bank $04 engine walks once a frame.
; Several helpers (GetActorStateAddr, AttachActorWaypointFollower,
; AttachActorStepMover, script_get_actor_state) select WRAM bank $04
; themselves, so callers such as the bank $0e-$15 cutscene scripts load slot
; addresses (`ld de, $d000` / `ld bc, $d040`) with another bank selected.
; Fields are ACTORF_* offsets (`ld hl, ACTORF_* / add hl, bc`); the
; field-size table the script opcodes use is ActorFieldTypeTable_04.
; overworld actors (WRAM bank $04)
; [24 x ACTOR_SIZE] Actor slots; fields are the ACTORF_* offsets (include/constants.inc). A slot is free when ACTORF_SCRIPT + 1 is zero
wActors:: ds 1536
	export_size wActors

	ds 1024

; List of actor slots near the player, rebuilt by BuildNearbyActorList
; (banks $18/$1b/$28/$38 keep unrelated screen state at the same addresses
; in WRAM bank $03).
; actor engine (bank $04)
; [up to 24 x 2 bytes + terminator] Pointers to the live actor slots BuildNearbyActorList selected (nonzero +$01, +$30 bit 7 and +$05 bit 3 set, close enough to the player). A zero word ends the list; FindActorAtPoint and the proximity searches walk it
wNearbyActorList:: ds 50

	ds 142

; Actor-engine staging buffers: two ROM records are copied here because
; they live in whichever bank the caller was running and the engine wants
; them at a fixed address.
; actor engine (bank $04)
; [14 bytes] One map_actor record, copied from the ROM list by SpawnActorsFromList and passed to SpawnActorFromTemplate. +$09 (obj_id) is $ff on the list terminator
wActorTemplate:: ds 14
	export_size wActorTemplate
	ds 2
; [16 bytes] The object-definition record LoadActorObjectDef copies from the ObjectIdList_04 entry and distributes into the slot: +$00 to +$37, +$01 to +$35, +$04/+$05 to +$24, +$06/+$07 to +$28, +$0a/+$0b to +$38, and +$08 as a far pointer to palette data when +$00 is $63 (the palette copy reuses the first 8 bytes as destination)
wActorObjDef:: ds 16
	export_size wActorObjDef
; [16-bit] Negated camera X plus screen shake, recomputed each frame; DrawActorSprite adds it to an actor position to get a screen coordinate
wActorScreenOriginX:: dw
; [16-bit] The same for Y, from wCameraY and wScreenShakeOffsetY (plus the $cb02 offset while the ending credits run)
wActorScreenOriginY:: dw
	ds 5
; [8-bit] Cleared by SetPlayerActorObjectDef before it reloads actor 0's object definition; nothing reads it
wPlayerObjDefPending:: db

; Overworld actor engine scratch, owned by the bank $04 actor-script VM
; (which selects WRAM bank $04 once on entry).
; actor engine (bank $04)
; [8-bit] Heading the D-pad asks the overworld player to walk ($40 per quarter turn, as FACE_*). UpdatePlayerControl also writes it to actor field +$34, then probes $20/$40/$e0/$c0 away from it to slide along a blocked wall
wPlayerMoveAngle:: db
	ds 1
; [8-bit] Heading actually walked this frame, 0 when the move was blocked
wPlayerMoveAngleApplied:: db
; [8-bit] Previous frame's wPlayerMoveAngleApplied, saved before it is recomputed
wPlayerMoveAnglePrev:: db
; [8-bit] Cleared when no direction is held, so the walk animation stops
wPlayerMoving:: db
; [8-bit] How far ahead GetPointAheadOfActorRanged probes: times 32 plus the facing nibble indexes ActorMoveVectors_04, selecting the table's 32-byte range row. The unranged entry point uses $40
wActorProbeRange:: db
; [16-bit] First coordinate of the point FindActorAtPoint searches at (from hl), before it walks wNearbyActorList
wActorQueryPointX:: dw
; [16-bit] Second coordinate of the query point (from de), compared against the word at actor + $0e for each candidate
wActorQueryPointY:: dw
; [8-bit] Random direction TryPickRandomReachableTarget probes in: AdvanceRandomSeed's low byte & $fc (one of 64 angles). ProjectPointFromActor casts a ray this way (distance $0100, then $00e0 once inside the box) to get a candidate destination
wActorProbeAngle:: db
; [8-bit] Half-width of the box ActorScriptOp_RandBox confines a random target to (operand low byte). Passed to TestPointInBox as h, checked against the box centre's first coordinate
wActorRandBoxHalfWidth:: db
; [8-bit] Half-depth of the same box (operand high byte); passed to TestPointInBox as l. The centre is the word at actor + $16
wActorRandBoxHalfDepth:: db
; [8-bit] ROM bank of the executing actor script, from actor field +$22; every ActorScriptOp_* passes it to FarReadByte / FarReadWord / CallHLInBankA
wActorScriptBank:: db

	ds 264

; Minigame actor records, owned by bank $0d. Bank $08's
; RunMinigamePointLoop and UpdateMatchFrame select WRAM bank $04 before
; CallModeHook, and ClearMinigameActors / SetMinigameActorHandler /
; SetMinigameActorPosition select it again.
; Bank $0a lays a different array over the same bytes: fifteen 14-byte
; target records instead of seven 16-byte actors. Both use bit 0 of +$00 as
; the live flag, but strides and fields differ (bank $0a's script pointer
; is at +$04, bank $0d's handler pointer at +$0e).
UNION
; minigames (bank $0d)
; [112 bytes] Seven 16-byte actor records, cleared as a block by
; ClearMinigameActors. Fields, addressed through bc by the helpers:
; +$00 flags (bit 0 = enabled, bit 1 = has a handler), +$02 state,
; +$03 timer, +$06 world X (16-bit), +$08 world depth (16-bit),
; +$0a projected screen X (16-bit), +$0c projected screen Y (16-bit),
; +$0e handler pointer.
wMinigameActors:: ds 112
	export_size wMinigameActors
; [16 bytes] The eighth record, same layout, outside the
; ClearMinigameActors block: the object the minigame drives (shot target,
; Boo, treasure box). The only record addressed by literal address, so its
; fields appear as wMinigameSceneActor + n.
wMinigameSceneActor:: ds 16
	export_size wMinigameSceneActor
	ds 82
NEXTU
; minigame targets (bank $0a)
; [210 bytes] Fifteen 14-byte target records for the target-shot minigames, walked by UpdateMinigameTargets and filled by SpawnMinigameTargetsFromList from a formation's script-pointer list. Fields: +$00 flags (bit 0 = live), +$01 the delay ActivateMinigameTarget zeroes, +$04 target script pointer. UpdateMinigameTarget works on a copy in wMinigameTargetWork. InitMinigameTargets clears 256 bytes (`ld c, $10` through ClearMemory16), past the array and over wMinigameTargetWork
wMinigameTargets:: ds 210
ENDU

	ds 30

; Working copy of the minigame target being updated (as wObjSlotWork):
; UpdateMinigameTarget copies the slot in, runs its script, movement, draw
; and hit checks on this record, and copies it back. Owned by bank $0a.
; minigame targets (bank $0a)
; [16 bytes] +$00 flags (bit 0 live, bit 1 moving toward the goal), +$02 delay counter, +$06/+$08 current position, +$0a/+$0c goal position. MoveMinigameTargetTowardGoal steps toward the goal $10 units at a time
wMinigameTargetWork:: ds 16
	export_size wMinigameTargetWork

; Match ball-visuals history ring (bank $08 renderer).
; match ball history ring (WRAM bank 4)
; [36 bytes] Ball position-history ring: six 6-byte records [projX word, projY word, tile+8, attr]; UpdateBallVisuals shifts it down one record per frame and BuildBallSlot writes the newest at +$1e
wBallHistory:: ds 36

	ds 92

; Match object slots: five 16-byte records the bank $09 sprite engine
; animates along a move curve (serve indicators, the court banner, the
; point-situation banner, special-shot effects). Spawners pass a slot base
; in bc. $ddd0-$ddef above them belongs to the bank $18/$1b menu screens.
; match object slots (banks $08/$09)
; [16 bytes] Match object slot 0. UpdateAllObjSprites walks the five in order; each spawner claims a fixed one (the court banner and the special-shot effect both take slot 3). Object-slot record, 16 bytes:
;   +$00 object id, $ff = slot free (ProcessObjSlot skips it)
;   +$01 flags; bit 0 = draw this frame
;   +$02 sprite template pointer, passed to QueueSpriteTemplate as hl
;   +$04 OAM attribute (b), +$05 base tile (c)
;   +$06 X offset, +$07 Y offset
;   +$08 handler pointer -- ProcessObjSlot `jp`s to it with DrawObjSlot
;        pushed as the return address
;   +$0a X from the move curve, +$0b Y
;   +$0c handler sub-state, an RST00 index the handler steps
;   +$0d curve step, incremented every frame by FinishObjSlotUpdate
;   +$0e curve id, indexing MoveCurveTable_09
;   +$0f anchor: 0 draws at the offsets as they stand, 1 adds the serving
;        character's wCharScreenX/Y first
wObjSlot0:: ds 16
; [16 bytes] Match object slot 1 (layout as wObjSlot0)
wObjSlot1:: ds 16
; [16 bytes] Match object slot 2 (layout as wObjSlot0)
wObjSlot2:: ds 16
; [16 bytes] Match object slot 3 (layout as wObjSlot0)
wObjSlot3:: ds 16
; [16 bytes] Match object slot 4 (layout as wObjSlot0)
wObjSlot4:: ds 16

	ds 32

; Working copy of the object slot being processed: ProcessObjSlot copies
; the slot here and calls its handler, and FinishObjSlotUpdate copies it
; back, so every handler addresses one fixed record.
; match object slots (banks $08/$09)
; [16 bytes] The slot ProcessObjSlot is running (layout as wObjSlot0). GetNextMoveCurveValue frees the slot by writing $ff to +$00 when the curve hits its $81 terminator
wObjSlotWork:: ds 16
	export_size wObjSlotWork

; Match ball sprite slots (bank $08 renderer), alongside the per-character
; $df80+ slots. (WRAM bank $07 has the save engine's minigame records at
; the same address.)
; match ball sprite slots (WRAM bank 4)
; [4 bytes] Sprite-slot record [tile, attr, screenY, screenX]: ball-at-net marker (tile $4e), drawn after the point when the ball rests within $1e0 of the net (BuildNetBallSlot)
wNetBallSlot:: ds 4
; [4 bytes] Sprite-slot record: the ball, tile by height band / off-screen ($40/$42/$44), gated by wBallSpriteEnabled (BuildBallSlot)
wBallSlot:: ds 4
; [4 bytes] Sprite-slot record: ball ground shadow (tile $46) at the ball's height-0 projection, gated by wBallShadowEnabled (BuildBallShadowSlot)
wBallShadowSlot:: ds 4
; [20 bytes] Five sprite-slot records: ball-trail afterimages (tile = ball tile + 8) from the history ring; slots 3-5 only when wBallTrailColor is nonzero (BuildBallTrailSlots)
wBallTrailSlots:: ds 20

	ds 96

; Pre-rendered scoreboard columns for the flipped court. LoadCourtSceneGraphics
; copies two $28-byte blocks here from the scene record;
; RefreshCourtScoreboardFlipped feeds them to CopyScoreboardTileColumn, which
; reads under WRAM bank $04 and writes under bank $02.
; court scoreboard columns (banks $08/$0a)
; [40 bytes] Tile half of the scoreboard columns for a court played from the far side. RefreshCourtScoreboardFlipped copies it (and the row at $de9e) into wCourtTilemapSaved; $de94 is the second column
wScoreboardColumnTiles:: ds 40
	export_size wScoreboardColumnTiles
; [40 bytes] Attribute half of the same columns, cell for cell with wScoreboardColumnTiles, copied into wCourtAttrmapSaved
wScoreboardColumnAttrs:: ds 40
	export_size wScoreboardColumnAttrs


SECTION "WRAMX bank 5", WRAMX[$d000], BANK[5]

; WRAMX bank 5 at a glance:
;
;   $d000-$d3ff  wActiveTilemap  [mirrored with bank 2]
;   $d000-$d7ff  window shadow tilemap
;   $d400-$d7ff  wActiveAttrmap  [mirrored with bank 2]
;   $d800-$d80f  window / menu engine
;   $d810-$d83e  window / menu engine
;   $d841-$d87f  text and window engine
;   $d880-$d88f  short-text fetch
;   $d8b0-$d8ff  text argument queues
;   $d900-$da7f  scene tile animation staging
;   $da80-$db13  scene tile animations
;   $dc00-$dc7f  window system
;   $df00-$df96  match character struct  [one copy per bank 4-7]

; Shadow tilemap for text windows: the same 32 x 32 tile plane plus CGB
; attribute plane the full-screen UIs keep in WRAM bank $03, owned by the
; window engine. ResetTextWindowState clears both and points
; wShadowTilemapPtr / wShadowTilemapBank at $d000 / $05; the dirty-row
; flusher copies changed rows to $9800. Bank $05 code also uses $d000/$d400
; literals for whichever plane the current screen owns, and its glyph
; buffers are at $d300-$d7ff in WRAM bank $07. RestoreShadowTilemapRow
; reads wMapBuffer64 under WRAM banks $03/$02 and writes these planes under
; bank $05.
; window shadow tilemap (WRAM bank $05)
; Tile plane of the text-window shadow tilemap: 32 x 32 cells, rows TILEMAP_WIDTH apart, of which the top-left 20 x 18 is on screen
wWindowShadowTilemap:: ds 1024
; CGB attribute plane of the text-window shadow tilemap, cell for cell with wWindowShadowTilemap and copied to $9800 in VRAM bank 1
wWindowShadowAttrmap:: ds 1024

; Window-fit table: four 4-byte entries.
; window / menu engine (bank $05)
; [16 bytes] FitWindowToText turns a window id into an offset with two `sla a` and reads the entry's first word into hl before centring the text against wDialogueWindowWidth / Height. ResetTextWindowState clears it with the rest of $d800-$dfff
wWindowFitTable:: ds 16

; Window and menu engine state.
; window / menu engine (bank $05, WRAM bank $05)
	ds 16
; [8-bit] Window struct index AllocWindowStruct returned for the window being built, $ff when none was free; CreateMenuWindowFromText passes it to SetWindowTextId / SetWindowState and returns it
wWindowId:: db
; [8-bit] Window struct index the glyph stream renders into, set by RedrawWindowText / Unused_05_RenderWindowTextToCompletion; InitGlyphStreamForWindow, Unused_05_DrawWindowGlyphRun, FlushGlyphRow and UploadLastGlyphTiles resolve the window through it
wGlyphWindowId:: db
; [8-bit] While nonzero the glyph buffer is kept: PrepareGlyphBuffer calls ClearGlyphBuffer and ResetGlyphStream only on 0. Unused_05_CloseMenuWindow (never called) decrements it and nothing increments it, so the keep branch never runs (docs/bugs.md)
wGlyphBufferHoldCount:: db
	ds 1
; [8-bit] Window struct index of the on-screen dialogue window, set by CreateDialogueWindow; used by RedrawActiveTextWindow, RenderActiveWindowText, CloseActiveDialogueWindow and the speaker-dialogue helpers
wDialogueWindowId:: db
; [8-bit] Dialogue window top-left tilemap column (wrapped to $1f)
wDialogueWindowCol:: db
; [8-bit] Dialogue window top-left tilemap row (wrapped to $1f)
wDialogueWindowRow:: db
; [8-bit] Dialogue window width in cells, from b at CreateDialogueWindow
wDialogueWindowWidth:: db
; [8-bit] Dialogue window height in cells, from c at CreateDialogueWindow
wDialogueWindowHeight:: db
; [8-bit] Re-entrancy guard around RedrawActiveTextWindow: the delay/wait text commands redraw only while it is 0 and set it during their own redraw
wTextRedrawGuard:: db
; [8-bit] Text cursor column, 0-31. RenderTextString seeds it from d & $1f with wTextCursorRow; TextCmdNewline reloads it into d for GetTilemapCellAddress to re-point the write pointer
wTextCursorColumn:: db
; [8-bit] Text cursor row, 0-31. TextCmdNewline advances it by two rows (the font is double height), wrapping with `and $1f`; the two glyph-stream row commands compare it against a row computed from the stream offset
wTextCursorRow:: db
	ds 3
; [8-bit] Window struct index of the menu window CreateMenuWindowFromText just built (copy of wWindowId taken as the menu is pushed)
wMenuWindowId:: db
; [8-bit] Row the menu cursor sits on; RunMenuSelection steps it against wMenuRowCount and returns it as the chosen entry
wMenuCursorRow:: db
; [8-bit] Selectable rows in the current menu, (lines - 1) / 2 from MeasureTextDimensions
wMenuRowCount:: db
; [12 bytes] Six two-byte frames, one per nested menu, indexed by wMenuDepth * 2: [wMenuRowCount << 4 | saved wMenuCursorRow, window id]. Pushed by CreateMenuWindowFromText, unwound when a menu is cancelled
wMenuStack:: ds 12
; [8-bit] Number of menus currently stacked; indexes wMenuStack
wMenuDepth:: db

	ds 2

; Text and dialogue engine state, owned by the bank $05 text/window engine
; and driven from the bank $0a story scripts and bank $0b drill messages.
; The engine selects WRAM bank $05 once on entry. Bank $1b keeps its
; ranking-marker animation channels at the same $d84x bytes in another
; WRAM bank, and banks $18/$1a/$6b use $d8bx/$d8fx as screen tilemap cells.
; text and window engine (banks $05/$0a/$0b)
; [8-bit] Frame counter of the menu-cursor arrow blink task; bit 4 picks the tile written ($20 blank / $0d arrow)
wTextArrowBlinkCounter:: db
; [16-bit] Shadow-tilemap address of the cell the cursor arrow is in. AnimateTextArrowTask converts it to a VRAM address (+ $3000 + $9800) and blinks the arrow there; RunMenuSelection primes it to $ffff and rewrites it whenever the cursor moves
wTextArrowCell:: dw
; [16-bit] VRAM address of the cell the arrow just left, overwritten with tile $20 by the blink task, which then clears it; zero means nothing pending (AnimateTextArrowTask tests the low byte, Unused_05_AnimateMenuScrollArrowsTask the high)
wTextArrowEraseAddr:: dw
; [8-bit] Page RunPagedTextMenu shows; left/right step and wrap it. The returned entry is wMenuPage * 4 + row (four rows a page)
wMenuPage:: db
; [8-bit] Cursor into wTextArgStringQueue: PushTextArgString writes at it, TextCmdPrintArgString reads at it, the dialogue entry points reset it between messages. Stops at 16
wTextArgStringWriteIndex:: db
; [8-bit] The same cursor for wTextArgNumberQueue, shared by PushTextArgNumber and TextCmdPrintArgNumber
wTextArgNumberWriteIndex:: db
; [8-bit] The same cursor for wTextArgShortTextQueue, written by Unused_05_PushTextArgShortTextId
wTextArgShortTextWriteIndex:: db
; [8-bit] String args pushed. Kept in step with wTextArgStringWriteIndex while queueing and not reset with the cursor, so it is the limit the print command stops at
wTextArgStringCount:: db
; [8-bit] The same count for wTextArgNumberQueue; TextCmdPrintArgNumber prints nothing once the cursor reaches it
wTextArgNumberCount:: db
; [8-bit] The same count for wTextArgShortTextQueue
wTextArgShortTextCount:: db
	ds 1
; [16-bit] Text-stream pointer to resume from instead of the start of wTextBuffer; a nonzero high byte is the "set" flag RenderTextString and FitWindowToText test and clear. Filled by TextInterpreterLoop at a TextCmdWaitButtonPage, and by FindDialogueChoiceMarker with the position of the $02 choice marker so the yes/no prompt measures and renders only the tail
wTextResumePtr:: dw
; [8-bit] Set by TextCmdWaitButtonPage: TextInterpreterLoop saves the resume offset to wTextResumePtr and returns, and the dialogue loops re-enter while it is set
wTextPageBreakRequest:: db
; [8-bit] Owner of the current dialogue, as passed to ShowSpeakerDialogue ($ff becomes 0). Bit 7 set: the low bits are a literal screen row. Clear: they are an actor id, and OpenSpeechBubble / ShowYesNoPromptWindow compare that actor's Y with the camera to open the window on the top or bottom half
wDialogueSpeaker:: db
; [16-bit] Text id the story script is up to: InitDialogueTextCursor seeds it and every Script*Dialogue call in bank $0a shows it and increments, so a cutscene walks consecutive ids
wScriptDialogueTextId:: dw
; [8-bit] Widest line of the measured text in whole cells; written by FitWindowToText, returned by MeasureDialogueWidthTiles
wFitTextWidthCells:: db
	ds 7
; [8-bit] 1 when OpenSpeechBubble / Unused_05_OpenCenteredDialogueWindow put the window on the lower half (speaker near the top), else 0. Write-only
wSpeechBubbleLowerHalf:: db
; [8-bit] Stored by Unused_05_SetTextVar; nothing reads it
wUnusedTextByte:: db
	ds 1
; [8-bit] 1 when RenderWindowText bails on the "no text" sentinel ($03 in the text id's high byte), 0 otherwise. Write-only
wWindowTextEmpty:: db
	ds 2
; [8-bit] Speaker voice for the per-character text blip: DelayTextCharacter plays sound $9a + voice * 4 + (glyph & 3) per glyph. Set from GetSpeakerVoice; $08 = silent, also forced by a negative message speed
wDialogueVoice:: db
; [8-bit] Window Unused_05_SetFixedMenuWindowTextId built, closed by Unused_05_RunFixedTextMenu with the menu window. Neither is called; Unused_05_SetFixedMenuWindowTextId loads hWramBank into b before SetWindowTextId, so the "window id" they pass around is really the WRAM bank number
wFixedMenuWindowId:: db
; [16-bit] Current VRAM destination address for glyph tiles (lo/hi)
wGlyphVramDest:: dw
; [8-bit] Second cursor into wTextArgStringQueue, stepped by MeasureNextArgStringWidth: FitWindowToText measures the whole message before drawing, so each queue has a separate measure cursor. The dialogue entry points reset all six cursors together
wTextArgStringMeasureIndex:: db
; [8-bit] The measure-pass cursor into wTextArgNumberQueue, stepped by MeasureNextArgNumberWidth
wTextArgNumberMeasureIndex:: db
; [8-bit] The measure-pass cursor into wTextArgShortTextQueue, stepped by GetNextArgShortTextLength
wTextArgShortTextMeasureIndex:: db
; [16-bit] Current read pointer into the text byte stream
wTextStreamPtr:: dw
	ds 4
; [8-bit] Line count of the measured text, companion of wFitTextWidthCells; ShowDrillMessageByIndex makes a window height of lines * 2 + 1
wFitTextLineCount:: db
	ds 16

; Short-text scratch buffer. Every string bank ends with the same
; FetchShortText tail, which copies into $d880; the bank $6b intro cutscene
; uses the same bytes as tilemap rows in WRAM banks $03/$04.
; short-text fetch (text banks)
; [16 bytes] Short string buffer: the text-bank fetch routines copy the string here instead of wTextBuffer when called with a != 0
wShortTextBuffer:: ds 16
	export_size wShortTextBuffer

	ds 32

; Text-argument queues: three parallel 16-entry rings the text control
; codes pop from, each with a write cursor, a count and a measure-pass
; cursor ($d847-$d84c / $d866-$d868). Banks $18/$1a/$1b/$6b use these
; bytes as screen tilemap cells in other WRAM banks.
; text argument queues (banks $05/$0a/$0b)
; 16 x 2-byte string pointers queued by PushTextArgString. The high nibble carries a WRAM bank tag, so an argument can point into a banked buffer
wTextArgStringQueue:: ds 32
; 16 x 2-byte values queued by PushTextArgNumber for TextCmdPrintArgNumber
wTextArgNumberQueue:: ds 32
; 16 x 1-byte short-text ids queued by Unused_05_PushTextArgShortTextId; GetNextArgShortTextLength measures them, but the $08 control code that would print one is a bare ret (TextCmdNop2)
wTextArgShortTextQueue:: ds 16

; Staging buffer UpdateSceneTileAnimations assembles the scene's animated
; tiles in before queueing them to VRAM; bounded by the animation header at
; $da80.
; scene tile animation staging (bank $0a)
; [384 bytes] The tile staging buffer, $d900-$da7f. Referenced only as the initial value of wSceneTileAnimBufferPtr; filled by FarCopyBytes through that cursor, read by QueueVRAMCopy
wSceneTileAnimBuffer:: ds 384

; Scene tile-animation record: an $88-byte slot InitSceneTileAnimations
; copies in before building its animation slots.
; scene tile animations (bank $0a)
; [8 bytes] Header of the tile-animation record; the entry list follows at wSceneTileAnimEntries
wSceneTileAnimHeader:: ds 8
; [128 bytes] The scene's tile-animation entries; InitSceneTileAnimations builds no slots when the first byte is $fe (empty list)
wSceneTileAnimEntries:: ds 128
	ds 8
; [16-bit] Write cursor into wSceneTileAnimBuffer: UpdateSceneTileAnimations seeds it with the buffer base each pass, uses it as FarCopyBytes destination and QueueVRAMCopy source, and advances it by the bytes copied
wSceneTileAnimBufferPtr:: dw
; [16-bit] Far source pointer for the frame being staged, copied from the scene's slot 6 record by FarCopyBytes, then offset by the frame index
wSceneTileAnimSrcPtr:: dw
	export_size wSceneTileAnimSrcPtr

	ds 236

; Window bookkeeping, owned by the bank $05 window system: the window struct
; array, the dirty-row flags that drive the shadow tilemap flush, and the
; allocator mask. Unused_05_WriteStringToTilemapStreamed keeps its own
; cursor at $dc05-$dc0a in the caller's WRAM bank, so those bytes are not
; windows. Banks $0d and $17/$3b use the same addresses in WRAM banks $04
; and $03.
; window system (bank $05)
; [64 bytes] Eight 8-byte window records, indexed by window id (GetWindowStructPtr: id & 7, << 3):
;   +$00 column, +$01 row (both wrapped to $1f by SetWindowRect)
;   +$02 width in cells, +$03 height in cells
;   +$04 state, read and written through GetWindowState / SetWindowState
;   +$06 text id (lo/hi), stored by SetWindowTextId; $03 in the high byte
;        is the "no text" sentinel RenderWindowText bails on
; AllocWindowStruct fills a free slot from de/bc, FreeWindow zeroes all
; eight bytes and releases the wWindowSlotMask bit
wWindowStructs:: ds 64
; [32 bytes] One flag per tilemap row. SetRowDirtyFlags clears the array and marks e rows from d (wrapping at 32), telling the flusher which rows a window redraw changed
wTilemapRowDirty:: ds 32
; [16 bytes] Run list BuildDirtyRowRuns makes from wTilemapRowDirty: (first row, length) pairs ending in $ff, runs capped at 7 rows so one FlushDirtyRowsPerFrame pass fits in a VBlank; one run per frame
wTilemapRowRuns:: ds 16
; [8-bit] One bit per window struct, set while in use; Unused_05_AllocWindowSlotBit claims a clear bit, FreeWindow clears it
wWindowSlotMask:: db
	ds 5
; [16-bit] Byte offset Unused_05_RefreshShadowTilemapFromMapBuffer adds to wShadowTilemapPtr when copying rows back. Never written, so it stays 0 from ResetTextWindowState
wShadowTilemapReadOffset:: dw
; [8 bytes] Scratch copy of one window record made by SaveWindowStruct, so a routine can rewrite the live one and compare against the start (OpenSpeechBubble grows the bubble one cell at a time against the saved column)
wSavedWindowStruct:: ds 8


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


SECTION "WRAMX bank 7", WRAMX[$d000], BANK[7]

; WRAMX bank 7 at a glance:
;
;   $d000-$d01f  sound driver
;   $d02a-$d219  sound engine
;   $d300-$daff  text glyph tiles / save-block staging
;   $db26-$db27  story-data confirm menu
;   $de00-$de1f  minigame record parameter
;   $df00-$df96  match character struct  [one copy per bank 4-7]

; Where the shared HRAM pool goes during an audio update. (Bank $05 and the
; boot path also load $d000 with WRAM bank $07 selected, as the base of a
; 4 KiB clear of the whole bank.)
; sound driver (bank 0)
; [32 bytes] Copy of $ffd0-$ffef saved by RunSoundEngine on entry and restored on exit. The driver keeps its channel state in that HRAM window, so four other subsystems can keep their own bytes there across an audio update (see the $ffd0 union)
wSndHramSave:: ds 32
	export_size wSndHramSave

	ds 10

; Sound engine channel state. (The same offsets in WRAM bank $06 are the
; palette fade engine and screen state.)
; sound engine (bank 0)
	ds 214
; [192 bytes] Six 32-byte channel state blocks (channels 0-1 sound effects, 2-5 music; StopMusic clears the four from +64). The active channel's block is mirrored into HRAM $ffd0 each pass; first word = script pointer ($ffff = idle)
wSndChannels:: ds 192
; [72 bytes] Per-channel loop bookkeeping (counter + return pointer per loop level); base resolved by GetChannelLoopSlot
wSndLoopSlots:: ds 72
; [8-bit] Bitmask of channels already serviced/keyed this update pass (AbortIfChannelTriggered tests it; folded into rAUDTERM at the end)
wSndActiveMask:: db
; [8-bit] Shadow of rAUDTERM: per-channel left/right output enable bits accumulated across channels
wSndPanShadow:: db
; [8-bit] Current channel type (0=square1/sweep, 1=square2, 2=wave, 3=noise)
wSndChannelType:: db
; [8-bit] Current channel's stereo output bit-pair (ch1=$11 .. ch4=$88), used for active-channel tracking
wSndChannelBits:: db
; [8-bit] Same bit-pair as wSndChannelBits, masked against hSndPanMask to build wSndPanShadow
wSndChannelPanMask:: db
; [8-bit] Current channel's APU register offset (type*5); WriteChannelReg forms rAUD via $ff10+this+reg
wSndRegBase:: db
; [8-bit] Free-running update counter; low nibble supplies the vibrato phase in TickVibrato
wSndFrameCounter:: db
; [8-bit] Index (0-5) of the channel currently being updated
wSndChannelIndex:: db
	ds 2
; [8-bit] Pending channel-update request: mask of channels to reconfigure (SetChannelUpdateRequest)
wSndUpdateReqMask:: db
; [8-bit] Value applied by the pending channel-update request (low nibble)
wSndUpdateReqData:: db
; [8-bit] Accumulator of channels that have acknowledged the pending update request
wSndUpdateReqAck:: db
; [8-bit] Channel index the update pass starts from (normally 0)
wSndFirstChannel:: db
	ds 1
; [8-bit] Wave-pattern id currently loaded into wave RAM (change detection for the wave channel)
wSndLoadedWaveId:: db
; [8-bit] Global transpose added to note ids (cmd $a9 $fe/$f2/$f3)
wSndTranspose:: db
; [8-bit] Non-zero to force the wave channel to reload its pattern on the next note
wSndWaveReloadPending:: db

	ds 230

; Two overlays on this 2 KiB: the text engine's glyph tiles (uploaded to
; VRAM $8800), and the bank $03 save engine's block staging (a save never
; runs while text is being composed). Banks $05/$3f use $d3xx-$dafx literals
; for other buffers in other WRAM banks too.
; Bank $03's debug save editor hex-dumps the region from $d300. Its "wipe
; the block" branch clears from $d300 and its slot-3 branch edits $d300+,
; both $200 short of where Unused_03_ReadCurrentSlotBlock puts the block.
UNION
; text glyph tiles (banks $05/$3f)
; [2048 bytes] 128 proportional-font glyph tiles, 1:1 with VRAM $8800 (tile n at + n * TILE_SIZE). PlotGlyphRow adds the pen position with a signed shift (sra d / rr e), so a negative pen writes below the base: the lesson menu's second page puts five glyph tiles at $d2b0-$d2ff, harmless since bank $07 is unused there (docs/bugs.md). ClearGlyphBuffer fills all 128 with the blank glyph; UploadGlyphBufferFull sends the first 80 as five 256-byte pages; UploadGlyphTilesPartial / Unused_05_UploadGlyphTileRange send narrower runs
wGlyphTileBuffer:: ds 2048
NEXTU
; save-block staging (bank $03)
	ds 384
; [32 bytes] Image of a minigame-record save block ($38 + story slot): 16 16-bit records by record id. ReadMinigameRecord zeroes it, reads the block over it and returns record b in wMinigameRecordValue; UpdateMinigameRecord does the reverse and verifies the block
wMinigameRecordBlock:: ds 32
	ds 96
; [512 bytes] Image of the $200-byte block the save engine is working on: the story slot block for Unused_03_ReadCurrentSlotBlock / Unused_03_WriteCurrentSlotBlock (ids from StorySlotBlockIds_03), or block $0b for the N64 transfer records. ApplyN64RecordsUnlockFlags and UpdateUnlockablesSaveBlock use the unlock bytes at +$00-$07
wSaveBlockBuffer:: ds 512
ENDU

	ds 38

; State for a stubbed-out frame task.
; story-data confirm menu (bank $1b)
; [2 bytes] Unused_1b_RunStoryDataConfirmMenu clears +$00, sets +$01 to $0c and registers StubNop_1b_09 as a frame task, whose body is a bare ret, so neither byte is read
wStubbedPromptTaskState:: dw

	ds 728

; Minigame record parameter. (WRAM bank $04 has the match ball sprite slots
; at this address.)
; minigame record parameter (WRAM bank $07)
; [16-bit] In/out parameter of ReadMinigameRecord / UpdateMinigameRecord: one record's high score, read from or written into wMinigameRecordBlock. Callers select WRAM bank $07 around it
wMinigameRecordValue:: dw
	ds 30


SECTION "WRAMX bank 4 $df00", WRAMX[$df00], BANK[4]

; One copy per character of a structure that lives in WRAM banks 4-7 at
; once. Each bank declares its own copy under a bank-tagged name so the
; symbol file resolves the right one in a debugger; this is bank 4's. Code
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
w4ClearStatusMode:: db
; [8-bit] 0 singles, 1 doubles, copied from FLAG_DOUBLES when Set is chosen; picks the singles or doubles rank list and result-code row
w4ClearStatusDoubles:: db
; [8-bit] Second menu (Text_34_217): 0 Mini-Game, 1 Ranking Match; $ff steps back
w4ClearStatusFormat:: db
; [8-bit] Third menu (Text_34_218): 0 Junior, 1 Senior, 2 Varsity; $ff steps back. SetTrainingCourtClearFlags reads it as the drill level to mark cleared, the ranking routines as how many classes of wins to set
w4ClearStatusClass:: db
; [8-bit] Fourth menu: the drill (Text_34_219) for a Mini-Game clear, or the rank within the class (Text_34_220 and the per-class lists after it) for a Ranking Match clear; $ff steps back
w4ClearStatusRank:: db
; [8-bit] Window struct index of the caption frame CreateWindowFromScreenRect opened; redrawn before every menu
w4ClearStatusWindowId:: db
; [8-bit] What RunClearStatusSetupMenu returns in b: 8 cancelled, 1 Continue, else the ClearStatusResultCodeIndexTable entry for the choice
w4ClearStatusResultCode:: db
	ds 144
NEXTU
; text-arg fetch buffer (menu banks reuse the idle char struct)
; [NUL-terminated string] Bank 5 buffer PushTextArgFetchedString fills with a short-text string (FetchShortTextToBuffer) and pushes as a text argument; overlaps the idle far-P1 character struct
w4TextArgFetchBuffer:: db
NEXTU
; match character struct (WRAM banks 4-7, and the match/shot/results banks that address it with the bank already selected)
; [3 bytes] Lateral X position, 24-bit fixed point (fraction byte + signed 16-bit integer)
w4CharPosX:: ds 3
; [3 bytes] Depth position (toward/away from the net), same format; the two court sides have opposite signs
w4CharPosDepth:: ds 3
; [3 bytes] Height above the court, same format (zeroed by SetCharPosAndTarget)
w4CharPosHeight:: ds 3
; [8-bit] Serve/side role code (court-position record bytes 4-7); XORed with 2 on the per-point side swap, mapped through the $4fa0 table at point start
w4CharServeRole:: db
; [8-bit] Court position code (court-position record bytes 0-3); XORed with 3 on the tiebreak side swap
w4CharCourtPos:: db
; [8-bit] Character index 0-3 (= WRAM bank - 4); bit 0 set = far side (CharPointEndReaction, the edge-arrow sprite)
w4CharIndex:: db
; [8-bit] Facing the character returns to for its court position, from CourtPosFacingTable_08; PlaceCharAtBasePosition and UpdateCharFacingOctant measure the displayed facing against it
w4CharBaseFacing:: db
; [8-bit] Desired facing; wCharFacingShown eases toward it
w4CharFacingDesired:: db
; [8-bit] Displayed facing, eased toward wCharFacingDesired by at most wCharFacingEaseRate per frame
w4CharFacingShown:: db
; [8-bit] State flags; bit 2 = airborne (set on a jump, cleared on landing; selects the shadow slot drawn)
w4CharFlags:: db
; [8-bit] Frames the character is frozen: UpdateCharStateMachine decrements it and skips the state. SetCharState clears it; FreezeMinigameOpponentOnReturn sets it to hold the minigame opponent still
w4CharFreezeTimer:: db
; [8-bit] Frames left to press a second shot button; BufferShotButtonPress seeds 5 on the first press, the state-machine dispatch counts it down
w4CharShotComboTimer:: db
; [8-bit] AI countdown: the reaction delay AiSetReactionDelay randomises, and the hold time AiServePressToss uses for the toss button
w4AiActionTimer:: db
; [8-bit] Frames the AI holds its first shot button before adding the second: AiWaitThenPickShot sets 5 after AiPressFirstShotButton, and AiSwingControlSingles/Doubles skip AiPressSecondShotButton while nonzero. Counted down only after wAiActionTimer reaches 0
w4AiSecondButtonDelay:: db
; [8-bit] SHOTTYPE_* of the swing about to happen, from the two buffered buttons via SelectServeShotType / SelectRallyShotType
w4CharShotType:: db
; [8-bit] Swing animation id SelectForehandBackhand picked; the windup plays it + $08, the contact phase plays it as is
w4CharSwingAnim:: db
; [8-bit] First shot button of the swing (1 = A, 2 = B), 0 = none. With wCharShotButton2 it indexes RallyShotTypeTable0/1, turning A+B combinations into lobs, drops and power shots
w4CharShotButton1:: db
; [8-bit] Second shot button, captured while wCharShotComboTimer runs
w4CharShotButton2:: db
; [8-bit] State-machine index (RST00 jumptable at $6a77; set via SetCharState)
w4CharState:: db
; [8-bit] Sub-step within wCharState; AdvanceCharStatePhase increments it, each state's phase routine dispatches on it
w4CharStatePhase:: db
; [8-bit] Sub-step of the AI state machine, advanced by AiAdvancePhase
w4AiPhase:: db
; [3 bytes] Current sprite frame pointer (hi/lo) + h-flip flag, used by DrawCharSprite
w4CharSpriteFrame:: ds 3
; [8-bit] Which input drives this character; ReadCharInput indexes CharInputPtrs with it (pad, CPU and link handlers)
w4CharInputSource:: db
; [8-bit] Input ReadCharInput produces: held buttons in the high nibble, newly pressed in the low (ReadCharPadInput builds it from hPlayerInputFlags and hInputRisingEdge); test with PADB_*
w4CharInputBits:: db
	ds 1
; [8-bit] Object-definition id passed to SetupCharSpriteFromObjectDef; write-only
w4CharObjectDefId:: db
; [8-bit] ROM bank of the character's object definition, animation scripts and frame tables, banked in by GetPerspectiveScale and passed to FarReadWordDI by SetCharAnimation / StepCharAnimation. 0 = no object loaded (UpdateChar exits)
w4CharObjectBank:: db
	ds 1
; [16-bit] Pointer (in wCharObjectBank) to the frame graphics table GetPerspectiveScale walks for a frame's tile data
w4CharFrameTablePtr:: dw
; [16-bit] VRAM destination of the character's frame tiles
w4CharFrameVramDest:: dw
; [16-bit] Pointer (in wCharObjectBank) to the animation-pointer table; SetCharAnimation indexes it by animation id
w4CharAnimTablePtr:: dw
; [16-bit] Start of the current animation script, where the $ff (jump) command rewinds to
w4CharAnimScriptBase:: dw
; [16-bit] Cursor into the current animation script. Word-sized commands: < $f0 is [frame, delay], $ff jumps, $fe switches animation, $fb toggles the flip bits of wCharSpriteAttr
w4CharAnimScriptPtr:: dw
; [8-bit] Animation playing; SetCharAnimation returns early when asked for the same one
w4CharAnimId:: db
; [8-bit] Frames left on the current animation frame; $ff = hold indefinitely
w4CharAnimDelay:: db
; [8-bit] Sprite bookkeeping flags. Bit 6 = frame or facing octant changed, so ReloadCharFacingTiles uploads new tiles (and clears the bit)
w4CharSpriteDirty:: db
	ds 1
; [8-bit] Facing octant 0-7 from wCharFacingShown; picks the tile row and, for octants 2 and 6, the mirrored sprite
w4CharFacingOctant:: db
; [8-bit] Frame id the animation script last selected
w4CharAnimFrame:: db
	ds 2
; [8-bit] First VRAM tile of the character's sprite, from a per-character-index table
w4CharTileBase:: db
; [8-bit] OAM attribute byte. The low three bits are the CGB OBJ palette (wCharIndex + 4) and also the tile block ReloadCharFrameGfx uploads into (& $07, + $08); the high bits are the flip bits the animation's $fb command toggles, cleared by SetCharAnimation (`and $0f`)
w4CharSpriteAttr:: db
; [16-bit] Pointer (in wCharObjectBank) to the per-frame shadow/scale table GetPerspectiveScale reads
w4CharShadowTablePtr:: dw
; [8-bit] ROM bank of the character's frame graphics; ReloadCharFrameGfx and LoadCharChargeFlashGfx pass it to the far-call vector at $0110
w4CharGfxBank:: db
	ds 5
; [16-bit] X velocity (zeroed on placement and at point end)
w4CharVelX:: dw
; [16-bit] Depth velocity
w4CharVelDepth:: dw
; [16-bit] Height velocity
w4CharVelHeight:: dw
; [16-bit] Walk-target X (integer part)
w4CharWalkTargetX:: dw
; [16-bit] Walk-target depth; MoveCharTowardTarget walks toward the target, snapping when both deltas are < $18 (CheckCharNearTarget)
w4CharWalkTargetDepth:: dw
; [8-bit] Left/right aim held at the moment of the shot, captured by CaptureServeAim / CaptureShotAim; GetShotAimOffsetForSide and ComputeShotTargetX turn it into the target's lateral offset
w4CharAimOffset:: db
; [8-bit] Frames in the current swing phase, reset at windup start, incremented by the windup and contact phases
w4CharSwingFrames:: db
; [8-bit] Set when the swing was quick (uncharged): written by StartCharSwing, copied to wShotWasQuickSwing by ExecuteShot so the shot gets no charge bonus
w4CharQuickSwing:: db
; [8-bit] Shot button latched while the swing is held, from b in CheckSwingRelease; cleared there when SELECT is down and by CharRallyReadyPhase. Write-only
w4CharSwingHoldButton:: db
; [8-bit] Frames the swing has been held: CheckSwingRelease increments it per frame and zeroes it on release or with SELECT down. Write-only
w4CharSwingHoldFrames:: db
; [8-bit] Shot button already recorded, so BufferShotButtonPress ignores it while held
w4CharLastShotButton:: db
; [8-bit] This frame's ball-geometry tests, rebuilt by UpdateCharBallGeometry: bit 0 = ball within swing range, bit 1 = inside the contact window, bit 4 = within normal reach (clear selects the stretching shot table)
w4CharBallReachFlags:: db
; [8-bit] Set while the charge flash plays; cleared when the swing starts or aborts
w4CharChargeFlashOn:: db
; [8-bit] 1 while the flashed tiles are in VRAM. UpdateChargeFlash toggles the flash on wCharSwingFrames bit 2; this latch makes each half load its graphics once (set + LoadCharChargeFlashGfx, or clear + ReloadCharFrameGfx)
w4CharChargeFlashGfxLoaded:: db
; [8-bit] Last projected screen X (BuildCharSpriteSlots)
w4CharScreenX:: db
; [8-bit] Last projected screen Y
w4CharScreenY:: db
; [8-bit] Zeroed right after each write of wCharWalkTargetX / wCharWalkTargetDepth; nothing reads it
w4CharWalkTargetFlag:: db
; [8-bit] Set to 1 by MoveCharTowardTarget when it steps the character toward the walk target; UpdateCharStateMachine clears it each frame and UpdateCharVelocityFromInput returns while it is set, so a scripted walk overrides the stick
w4CharScriptedMove:: db
; [8-bit] Point result from this character's side (signed wPointWinLoseFlag)
w4CharPointResult:: db
; [8-bit] Shot buttons the AI chose for this swing (AiPickServeButtons / AiPickShotButtons); AiPressFirstShotButton and AiPressSecondShotButton feed them into wCharInputBits one at a time
w4AiShotButtons:: db
; [8-bit] Countdown seeded from wAiTrackingParam whenever the AI advances a phase after fixing a target. AiWaitThenPickShot decrements it per frame and picks no shot until 0 (or until wCharBallReachFlags bit 0 says the ball is in reach), so a larger parameter commits later
w4AiTrackingCountdown:: db
; [8-bit] Set to 1 by CharRallyReadyPhase, cleared with wCharShotButton1/2 when a shot is abandoned. AiTrackBallPhase does not steer while it is 0
w4CharRallyReady:: db
	ds 5
; [16-bit] Speed limit on X: ClampCharXSpeed multiplies it by the cosine of wCharFacingDesired. From CharStatTable_07_0 indexed by attribute byte $0027
w4CharMaxSpeedX:: dw
; [16-bit] Speed limit on depth: ClampCharDepthSpeed multiplies it by the sine of wCharFacingDesired. LoadCharacterAttributes indexes CharStatTable_07_0 with attribute bytes ($0027 + $002b) * 2, clamped to ten entries, so this axis gets the $002b bonus that wCharMaxSpeedX does not
w4CharMaxSpeedDepth:: dw
; [16-bit] Acceleration, from CharStatTable_07_1 via attribute offset $0028. AccelerateCharDepth / AccelerateCharX multiply it by the sine/cosine of wCharFacingDesired into wCharVelDepth / wCharVelX
w4CharAcceleration:: dw
; [16-bit] Deceleration when not accelerating, from CharStatTable_07_2 via attribute offset $002a. The brake routines negate it against the velocity's sign; one uses a flat $0040 when wCharFlags bit 1 is clear
w4CharDeceleration:: dw
; [8-bit] Max facing change per frame (wCharFacingShown toward wCharFacingDesired)
w4CharFacingEaseRate:: db
; [8-bit] Fraction ComputeAimBaseOffset applies (MulHLByAFrac) to the base aim offset. From CharStatTable_07_4 via attribute offset $0025
w4CharAimOffsetScale:: db
; [8-bit] Random aim component: GetRandomAimJitter multiplies an AdvanceMatchRng byte by it; higher is less accurate. From CharStatTable_07_5 via attribute offset $0026
w4CharAimJitterScale:: db
; [8-bit] Speed-row index (e) into the ShotPlacementData tables for ground strokes (topspin/slice/power variants/neutral); selects bytes 4-5 (shot speed) in LoadShotPlacementEntry
w4GroundStrokeSpeedIndex:: db
; [8-bit] Speed-row index (e) into ShotPlacementData for the smash and all three serves
w4SmashServeSpeedIndex:: db
; [8-bit] Speed-row index (e) into ShotPlacementData for the reach (smash-range) shot variants
w4ReachSpeedIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementData for topspin and serve-topspin; selects bytes 0-3 (target offsets) in LoadShotPlacementEntry
w4TopspinPlacementIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementData for slice and serve-slice
w4SlicePlacementIndex:: db
; [16-bit] How far above or below the character the ball can be hit; CheckCharBallContact compares |wBallRelCharHeight| with it. Attribute record +$10, minus $10
w4CharReachHeight:: dw
; [16-bit] Lateral reach; CheckCharBallContact compares |wBallRelCharX| * 2 with it. Attribute record +$12
w4CharReachX:: dw
; [16-bit] Upward speed of a jump smash, negated into wCharVelHeight by StartCharSwing. Attribute record +$14, plus $0200
w4CharSmashJumpSpeed:: dw
; [16-bit] Lunge speed of a dive, turned into wCharVelX/wCharVelDepth along the facing by VectorFromLengthAndAngleRaw. Attribute record +$16
w4CharDiveSpeed:: dw
; [8-bit] Character id passed to InitChar, before RemapExtendedCharId
w4CharId:: db
; [8-bit] Base frames the AI waits before reacting to a ball within normal reach; AiSetReactionDelay adds 0-3 at random into wAiActionTimer. Attribute record +$1b
w4AiReactionDelayNear:: db
; [8-bit] The same for a ball outside normal reach (wCharBallReachFlags bit 4 clear). Attribute record +$1c
w4AiReactionDelayFar:: db
; [8-bit] How the AI chases the ball; read by AiTrackBallPhase and the baseliner rally state. Attribute record +$1d
w4AiTrackingParam:: db
; [8-bit] RNG threshold in AiMaybeAimAwayFromChar: the AI aims away from the opponent when the roll is under it. Attribute record +$1e
w4AiAimAwayChance:: db
; [8-bit] AI serve/shot habit: low nibble indexes ServePressTossPtrs for toss timing; AiPickShotButtons reads it too. Attribute record +$1f
w4AiServeStyle:: db
; [8-bit] Character id after RemapExtendedCharId; LookupCharSpriteSet and bank $09's LoadOnCourtCharacterGfx find the sprite bank with it
w4CharSpriteSetId:: db
; [8-bit] Where the AI stands between shots (0/5 baseline, 1 net, others mid-court); RST00 index in AiChooseHomePosition and AiChoosePositionByStrategy. Attribute record +$0f
w4AiPositionStrategy:: db
; [4 bytes] Sprite-slot record [tile, attr, screenY, screenX] for the character sprite
w4CharSpriteSlot:: ds 4
; [4 bytes] Frame descriptor the single-character screens (Unused_1a_DrawCharViewerCharSprite, the results/EXP screen drawers) write after the sprite slot: wCharSpriteFrame + 2 (the 32x32 flag), + 1 and + 0 (Y and X offsets for QueueSprite24x32), and a depth key (slot * 8 + $80). The match engine's drawer does not use it
w4CharSpriteSlotFrame:: ds 4
; [4 bytes] Sprite-slot record for the airborne shadow (tiles $50/$52/$54/$56 shrinking with height; drawn only while wCharFlags bit 2 is set)
w4CharAirShadowSlot:: ds 4
; [4 bytes] Sprite-slot record for the standing shadow (tile $58, flickered while grounded)
w4CharGroundShadowSlot:: ds 4
; [16-bit] Attribute word from character record +$19; StartCharSwing tests bit 7 of the low byte; bits 0 and 1 of the high byte select the lob and drop placement rows
w4CharSwingAttrWord:: dw
; [8-bit] Placement-row index (d) into ShotPlacementDataLob (from wCharSwingAttrWord + 1 bit 0)
w4LobPlacementIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementDataDrop (from wCharSwingAttrWord + 1 bit 1)
w4DropPlacementIndex:: db
; [8-bit] Attribute bits XORed into wCharSpriteAttr for facing octants 2 and 6 (sprite drawn mirrored)
w4CharMirrorAttrMask:: db
; [8-bit] Character class/tier from attribute record +$18; LookupExpTierForChar reads it on the EXP screen
w4CharExpTier:: db
; [8-bit] Draw-order depth key ((depth * 8) >> 8 + $80); DrawActorsByDepth draws back to front
w4CharDepthKey:: db
ENDU


SECTION "WRAMX bank 5 $df00", WRAMX[$df00], BANK[5]

; One copy per character of a structure that lives in WRAM banks 4-7 at
; once. Each bank declares its own copy under a bank-tagged name so the
; symbol file resolves the right one in a debugger; this is bank 5's. Code
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
w5ClearStatusMode:: db
; [8-bit] 0 singles, 1 doubles, copied from FLAG_DOUBLES when Set is chosen; picks the singles or doubles rank list and result-code row
w5ClearStatusDoubles:: db
; [8-bit] Second menu (Text_34_217): 0 Mini-Game, 1 Ranking Match; $ff steps back
w5ClearStatusFormat:: db
; [8-bit] Third menu (Text_34_218): 0 Junior, 1 Senior, 2 Varsity; $ff steps back. SetTrainingCourtClearFlags reads it as the drill level to mark cleared, the ranking routines as how many classes of wins to set
w5ClearStatusClass:: db
; [8-bit] Fourth menu: the drill (Text_34_219) for a Mini-Game clear, or the rank within the class (Text_34_220 and the per-class lists after it) for a Ranking Match clear; $ff steps back
w5ClearStatusRank:: db
; [8-bit] Window struct index of the caption frame CreateWindowFromScreenRect opened; redrawn before every menu
w5ClearStatusWindowId:: db
; [8-bit] What RunClearStatusSetupMenu returns in b: 8 cancelled, 1 Continue, else the ClearStatusResultCodeIndexTable entry for the choice
w5ClearStatusResultCode:: db
	ds 144
NEXTU
; text-arg fetch buffer (menu banks reuse the idle char struct)
; [NUL-terminated string] Bank 5 buffer PushTextArgFetchedString fills with a short-text string (FetchShortTextToBuffer) and pushes as a text argument; overlaps the idle far-P1 character struct
w5TextArgFetchBuffer:: db
NEXTU
; match character struct (WRAM banks 4-7, and the match/shot/results banks that address it with the bank already selected)
; [3 bytes] Lateral X position, 24-bit fixed point (fraction byte + signed 16-bit integer)
w5CharPosX:: ds 3
; [3 bytes] Depth position (toward/away from the net), same format; the two court sides have opposite signs
w5CharPosDepth:: ds 3
; [3 bytes] Height above the court, same format (zeroed by SetCharPosAndTarget)
w5CharPosHeight:: ds 3
; [8-bit] Serve/side role code (court-position record bytes 4-7); XORed with 2 on the per-point side swap, mapped through the $4fa0 table at point start
w5CharServeRole:: db
; [8-bit] Court position code (court-position record bytes 0-3); XORed with 3 on the tiebreak side swap
w5CharCourtPos:: db
; [8-bit] Character index 0-3 (= WRAM bank - 4); bit 0 set = far side (CharPointEndReaction, the edge-arrow sprite)
w5CharIndex:: db
; [8-bit] Facing the character returns to for its court position, from CourtPosFacingTable_08; PlaceCharAtBasePosition and UpdateCharFacingOctant measure the displayed facing against it
w5CharBaseFacing:: db
; [8-bit] Desired facing; wCharFacingShown eases toward it
w5CharFacingDesired:: db
; [8-bit] Displayed facing, eased toward wCharFacingDesired by at most wCharFacingEaseRate per frame
w5CharFacingShown:: db
; [8-bit] State flags; bit 2 = airborne (set on a jump, cleared on landing; selects the shadow slot drawn)
w5CharFlags:: db
; [8-bit] Frames the character is frozen: UpdateCharStateMachine decrements it and skips the state. SetCharState clears it; FreezeMinigameOpponentOnReturn sets it to hold the minigame opponent still
w5CharFreezeTimer:: db
; [8-bit] Frames left to press a second shot button; BufferShotButtonPress seeds 5 on the first press, the state-machine dispatch counts it down
w5CharShotComboTimer:: db
; [8-bit] AI countdown: the reaction delay AiSetReactionDelay randomises, and the hold time AiServePressToss uses for the toss button
w5AiActionTimer:: db
; [8-bit] Frames the AI holds its first shot button before adding the second: AiWaitThenPickShot sets 5 after AiPressFirstShotButton, and AiSwingControlSingles/Doubles skip AiPressSecondShotButton while nonzero. Counted down only after wAiActionTimer reaches 0
w5AiSecondButtonDelay:: db
; [8-bit] SHOTTYPE_* of the swing about to happen, from the two buffered buttons via SelectServeShotType / SelectRallyShotType
w5CharShotType:: db
; [8-bit] Swing animation id SelectForehandBackhand picked; the windup plays it + $08, the contact phase plays it as is
w5CharSwingAnim:: db
; [8-bit] First shot button of the swing (1 = A, 2 = B), 0 = none. With wCharShotButton2 it indexes RallyShotTypeTable0/1, turning A+B combinations into lobs, drops and power shots
w5CharShotButton1:: db
; [8-bit] Second shot button, captured while wCharShotComboTimer runs
w5CharShotButton2:: db
; [8-bit] State-machine index (RST00 jumptable at $6a77; set via SetCharState)
w5CharState:: db
; [8-bit] Sub-step within wCharState; AdvanceCharStatePhase increments it, each state's phase routine dispatches on it
w5CharStatePhase:: db
; [8-bit] Sub-step of the AI state machine, advanced by AiAdvancePhase
w5AiPhase:: db
; [3 bytes] Current sprite frame pointer (hi/lo) + h-flip flag, used by DrawCharSprite
w5CharSpriteFrame:: ds 3
; [8-bit] Which input drives this character; ReadCharInput indexes CharInputPtrs with it (pad, CPU and link handlers)
w5CharInputSource:: db
; [8-bit] Input ReadCharInput produces: held buttons in the high nibble, newly pressed in the low (ReadCharPadInput builds it from hPlayerInputFlags and hInputRisingEdge); test with PADB_*
w5CharInputBits:: db
	ds 1
; [8-bit] Object-definition id passed to SetupCharSpriteFromObjectDef; write-only
w5CharObjectDefId:: db
; [8-bit] ROM bank of the character's object definition, animation scripts and frame tables, banked in by GetPerspectiveScale and passed to FarReadWordDI by SetCharAnimation / StepCharAnimation. 0 = no object loaded (UpdateChar exits)
w5CharObjectBank:: db
	ds 1
; [16-bit] Pointer (in wCharObjectBank) to the frame graphics table GetPerspectiveScale walks for a frame's tile data
w5CharFrameTablePtr:: dw
; [16-bit] VRAM destination of the character's frame tiles
w5CharFrameVramDest:: dw
; [16-bit] Pointer (in wCharObjectBank) to the animation-pointer table; SetCharAnimation indexes it by animation id
w5CharAnimTablePtr:: dw
; [16-bit] Start of the current animation script, where the $ff (jump) command rewinds to
w5CharAnimScriptBase:: dw
; [16-bit] Cursor into the current animation script. Word-sized commands: < $f0 is [frame, delay], $ff jumps, $fe switches animation, $fb toggles the flip bits of wCharSpriteAttr
w5CharAnimScriptPtr:: dw
; [8-bit] Animation playing; SetCharAnimation returns early when asked for the same one
w5CharAnimId:: db
; [8-bit] Frames left on the current animation frame; $ff = hold indefinitely
w5CharAnimDelay:: db
; [8-bit] Sprite bookkeeping flags. Bit 6 = frame or facing octant changed, so ReloadCharFacingTiles uploads new tiles (and clears the bit)
w5CharSpriteDirty:: db
	ds 1
; [8-bit] Facing octant 0-7 from wCharFacingShown; picks the tile row and, for octants 2 and 6, the mirrored sprite
w5CharFacingOctant:: db
; [8-bit] Frame id the animation script last selected
w5CharAnimFrame:: db
	ds 2
; [8-bit] First VRAM tile of the character's sprite, from a per-character-index table
w5CharTileBase:: db
; [8-bit] OAM attribute byte. The low three bits are the CGB OBJ palette (wCharIndex + 4) and also the tile block ReloadCharFrameGfx uploads into (& $07, + $08); the high bits are the flip bits the animation's $fb command toggles, cleared by SetCharAnimation (`and $0f`)
w5CharSpriteAttr:: db
; [16-bit] Pointer (in wCharObjectBank) to the per-frame shadow/scale table GetPerspectiveScale reads
w5CharShadowTablePtr:: dw
; [8-bit] ROM bank of the character's frame graphics; ReloadCharFrameGfx and LoadCharChargeFlashGfx pass it to the far-call vector at $0110
w5CharGfxBank:: db
	ds 5
; [16-bit] X velocity (zeroed on placement and at point end)
w5CharVelX:: dw
; [16-bit] Depth velocity
w5CharVelDepth:: dw
; [16-bit] Height velocity
w5CharVelHeight:: dw
; [16-bit] Walk-target X (integer part)
w5CharWalkTargetX:: dw
; [16-bit] Walk-target depth; MoveCharTowardTarget walks toward the target, snapping when both deltas are < $18 (CheckCharNearTarget)
w5CharWalkTargetDepth:: dw
; [8-bit] Left/right aim held at the moment of the shot, captured by CaptureServeAim / CaptureShotAim; GetShotAimOffsetForSide and ComputeShotTargetX turn it into the target's lateral offset
w5CharAimOffset:: db
; [8-bit] Frames in the current swing phase, reset at windup start, incremented by the windup and contact phases
w5CharSwingFrames:: db
; [8-bit] Set when the swing was quick (uncharged): written by StartCharSwing, copied to wShotWasQuickSwing by ExecuteShot so the shot gets no charge bonus
w5CharQuickSwing:: db
; [8-bit] Shot button latched while the swing is held, from b in CheckSwingRelease; cleared there when SELECT is down and by CharRallyReadyPhase. Write-only
w5CharSwingHoldButton:: db
; [8-bit] Frames the swing has been held: CheckSwingRelease increments it per frame and zeroes it on release or with SELECT down. Write-only
w5CharSwingHoldFrames:: db
; [8-bit] Shot button already recorded, so BufferShotButtonPress ignores it while held
w5CharLastShotButton:: db
; [8-bit] This frame's ball-geometry tests, rebuilt by UpdateCharBallGeometry: bit 0 = ball within swing range, bit 1 = inside the contact window, bit 4 = within normal reach (clear selects the stretching shot table)
w5CharBallReachFlags:: db
; [8-bit] Set while the charge flash plays; cleared when the swing starts or aborts
w5CharChargeFlashOn:: db
; [8-bit] 1 while the flashed tiles are in VRAM. UpdateChargeFlash toggles the flash on wCharSwingFrames bit 2; this latch makes each half load its graphics once (set + LoadCharChargeFlashGfx, or clear + ReloadCharFrameGfx)
w5CharChargeFlashGfxLoaded:: db
; [8-bit] Last projected screen X (BuildCharSpriteSlots)
w5CharScreenX:: db
; [8-bit] Last projected screen Y
w5CharScreenY:: db
; [8-bit] Zeroed right after each write of wCharWalkTargetX / wCharWalkTargetDepth; nothing reads it
w5CharWalkTargetFlag:: db
; [8-bit] Set to 1 by MoveCharTowardTarget when it steps the character toward the walk target; UpdateCharStateMachine clears it each frame and UpdateCharVelocityFromInput returns while it is set, so a scripted walk overrides the stick
w5CharScriptedMove:: db
; [8-bit] Point result from this character's side (signed wPointWinLoseFlag)
w5CharPointResult:: db
; [8-bit] Shot buttons the AI chose for this swing (AiPickServeButtons / AiPickShotButtons); AiPressFirstShotButton and AiPressSecondShotButton feed them into wCharInputBits one at a time
w5AiShotButtons:: db
; [8-bit] Countdown seeded from wAiTrackingParam whenever the AI advances a phase after fixing a target. AiWaitThenPickShot decrements it per frame and picks no shot until 0 (or until wCharBallReachFlags bit 0 says the ball is in reach), so a larger parameter commits later
w5AiTrackingCountdown:: db
; [8-bit] Set to 1 by CharRallyReadyPhase, cleared with wCharShotButton1/2 when a shot is abandoned. AiTrackBallPhase does not steer while it is 0
w5CharRallyReady:: db
	ds 5
; [16-bit] Speed limit on X: ClampCharXSpeed multiplies it by the cosine of wCharFacingDesired. From CharStatTable_07_0 indexed by attribute byte $0027
w5CharMaxSpeedX:: dw
; [16-bit] Speed limit on depth: ClampCharDepthSpeed multiplies it by the sine of wCharFacingDesired. LoadCharacterAttributes indexes CharStatTable_07_0 with attribute bytes ($0027 + $002b) * 2, clamped to ten entries, so this axis gets the $002b bonus that wCharMaxSpeedX does not
w5CharMaxSpeedDepth:: dw
; [16-bit] Acceleration, from CharStatTable_07_1 via attribute offset $0028. AccelerateCharDepth / AccelerateCharX multiply it by the sine/cosine of wCharFacingDesired into wCharVelDepth / wCharVelX
w5CharAcceleration:: dw
; [16-bit] Deceleration when not accelerating, from CharStatTable_07_2 via attribute offset $002a. The brake routines negate it against the velocity's sign; one uses a flat $0040 when wCharFlags bit 1 is clear
w5CharDeceleration:: dw
; [8-bit] Max facing change per frame (wCharFacingShown toward wCharFacingDesired)
w5CharFacingEaseRate:: db
; [8-bit] Fraction ComputeAimBaseOffset applies (MulHLByAFrac) to the base aim offset. From CharStatTable_07_4 via attribute offset $0025
w5CharAimOffsetScale:: db
; [8-bit] Random aim component: GetRandomAimJitter multiplies an AdvanceMatchRng byte by it; higher is less accurate. From CharStatTable_07_5 via attribute offset $0026
w5CharAimJitterScale:: db
; [8-bit] Speed-row index (e) into the ShotPlacementData tables for ground strokes (topspin/slice/power variants/neutral); selects bytes 4-5 (shot speed) in LoadShotPlacementEntry
w5GroundStrokeSpeedIndex:: db
; [8-bit] Speed-row index (e) into ShotPlacementData for the smash and all three serves
w5SmashServeSpeedIndex:: db
; [8-bit] Speed-row index (e) into ShotPlacementData for the reach (smash-range) shot variants
w5ReachSpeedIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementData for topspin and serve-topspin; selects bytes 0-3 (target offsets) in LoadShotPlacementEntry
w5TopspinPlacementIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementData for slice and serve-slice
w5SlicePlacementIndex:: db
; [16-bit] How far above or below the character the ball can be hit; CheckCharBallContact compares |wBallRelCharHeight| with it. Attribute record +$10, minus $10
w5CharReachHeight:: dw
; [16-bit] Lateral reach; CheckCharBallContact compares |wBallRelCharX| * 2 with it. Attribute record +$12
w5CharReachX:: dw
; [16-bit] Upward speed of a jump smash, negated into wCharVelHeight by StartCharSwing. Attribute record +$14, plus $0200
w5CharSmashJumpSpeed:: dw
; [16-bit] Lunge speed of a dive, turned into wCharVelX/wCharVelDepth along the facing by VectorFromLengthAndAngleRaw. Attribute record +$16
w5CharDiveSpeed:: dw
; [8-bit] Character id passed to InitChar, before RemapExtendedCharId
w5CharId:: db
; [8-bit] Base frames the AI waits before reacting to a ball within normal reach; AiSetReactionDelay adds 0-3 at random into wAiActionTimer. Attribute record +$1b
w5AiReactionDelayNear:: db
; [8-bit] The same for a ball outside normal reach (wCharBallReachFlags bit 4 clear). Attribute record +$1c
w5AiReactionDelayFar:: db
; [8-bit] How the AI chases the ball; read by AiTrackBallPhase and the baseliner rally state. Attribute record +$1d
w5AiTrackingParam:: db
; [8-bit] RNG threshold in AiMaybeAimAwayFromChar: the AI aims away from the opponent when the roll is under it. Attribute record +$1e
w5AiAimAwayChance:: db
; [8-bit] AI serve/shot habit: low nibble indexes ServePressTossPtrs for toss timing; AiPickShotButtons reads it too. Attribute record +$1f
w5AiServeStyle:: db
; [8-bit] Character id after RemapExtendedCharId; LookupCharSpriteSet and bank $09's LoadOnCourtCharacterGfx find the sprite bank with it
w5CharSpriteSetId:: db
; [8-bit] Where the AI stands between shots (0/5 baseline, 1 net, others mid-court); RST00 index in AiChooseHomePosition and AiChoosePositionByStrategy. Attribute record +$0f
w5AiPositionStrategy:: db
; [4 bytes] Sprite-slot record [tile, attr, screenY, screenX] for the character sprite
w5CharSpriteSlot:: ds 4
; [4 bytes] Frame descriptor the single-character screens (Unused_1a_DrawCharViewerCharSprite, the results/EXP screen drawers) write after the sprite slot: wCharSpriteFrame + 2 (the 32x32 flag), + 1 and + 0 (Y and X offsets for QueueSprite24x32), and a depth key (slot * 8 + $80). The match engine's drawer does not use it
w5CharSpriteSlotFrame:: ds 4
; [4 bytes] Sprite-slot record for the airborne shadow (tiles $50/$52/$54/$56 shrinking with height; drawn only while wCharFlags bit 2 is set)
w5CharAirShadowSlot:: ds 4
; [4 bytes] Sprite-slot record for the standing shadow (tile $58, flickered while grounded)
w5CharGroundShadowSlot:: ds 4
; [16-bit] Attribute word from character record +$19; StartCharSwing tests bit 7 of the low byte; bits 0 and 1 of the high byte select the lob and drop placement rows
w5CharSwingAttrWord:: dw
; [8-bit] Placement-row index (d) into ShotPlacementDataLob (from wCharSwingAttrWord + 1 bit 0)
w5LobPlacementIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementDataDrop (from wCharSwingAttrWord + 1 bit 1)
w5DropPlacementIndex:: db
; [8-bit] Attribute bits XORed into wCharSpriteAttr for facing octants 2 and 6 (sprite drawn mirrored)
w5CharMirrorAttrMask:: db
; [8-bit] Character class/tier from attribute record +$18; LookupExpTierForChar reads it on the EXP screen
w5CharExpTier:: db
; [8-bit] Draw-order depth key ((depth * 8) >> 8 + $80); DrawActorsByDepth draws back to front
w5CharDepthKey:: db
ENDU


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


SECTION "WRAMX bank 7 $df00", WRAMX[$df00], BANK[7]

; One copy per character of a structure that lives in WRAM banks 4-7 at
; once. Each bank declares its own copy under a bank-tagged name so the
; symbol file resolves the right one in a debugger; this is bank 7's. Code
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
w7ClearStatusMode:: db
; [8-bit] 0 singles, 1 doubles, copied from FLAG_DOUBLES when Set is chosen; picks the singles or doubles rank list and result-code row
w7ClearStatusDoubles:: db
; [8-bit] Second menu (Text_34_217): 0 Mini-Game, 1 Ranking Match; $ff steps back
w7ClearStatusFormat:: db
; [8-bit] Third menu (Text_34_218): 0 Junior, 1 Senior, 2 Varsity; $ff steps back. SetTrainingCourtClearFlags reads it as the drill level to mark cleared, the ranking routines as how many classes of wins to set
w7ClearStatusClass:: db
; [8-bit] Fourth menu: the drill (Text_34_219) for a Mini-Game clear, or the rank within the class (Text_34_220 and the per-class lists after it) for a Ranking Match clear; $ff steps back
w7ClearStatusRank:: db
; [8-bit] Window struct index of the caption frame CreateWindowFromScreenRect opened; redrawn before every menu
w7ClearStatusWindowId:: db
; [8-bit] What RunClearStatusSetupMenu returns in b: 8 cancelled, 1 Continue, else the ClearStatusResultCodeIndexTable entry for the choice
w7ClearStatusResultCode:: db
	ds 144
NEXTU
; text-arg fetch buffer (menu banks reuse the idle char struct)
; [NUL-terminated string] Bank 5 buffer PushTextArgFetchedString fills with a short-text string (FetchShortTextToBuffer) and pushes as a text argument; overlaps the idle far-P1 character struct
w7TextArgFetchBuffer:: db
NEXTU
; match character struct (WRAM banks 4-7, and the match/shot/results banks that address it with the bank already selected)
; [3 bytes] Lateral X position, 24-bit fixed point (fraction byte + signed 16-bit integer)
w7CharPosX:: ds 3
; [3 bytes] Depth position (toward/away from the net), same format; the two court sides have opposite signs
w7CharPosDepth:: ds 3
; [3 bytes] Height above the court, same format (zeroed by SetCharPosAndTarget)
w7CharPosHeight:: ds 3
; [8-bit] Serve/side role code (court-position record bytes 4-7); XORed with 2 on the per-point side swap, mapped through the $4fa0 table at point start
w7CharServeRole:: db
; [8-bit] Court position code (court-position record bytes 0-3); XORed with 3 on the tiebreak side swap
w7CharCourtPos:: db
; [8-bit] Character index 0-3 (= WRAM bank - 4); bit 0 set = far side (CharPointEndReaction, the edge-arrow sprite)
w7CharIndex:: db
; [8-bit] Facing the character returns to for its court position, from CourtPosFacingTable_08; PlaceCharAtBasePosition and UpdateCharFacingOctant measure the displayed facing against it
w7CharBaseFacing:: db
; [8-bit] Desired facing; wCharFacingShown eases toward it
w7CharFacingDesired:: db
; [8-bit] Displayed facing, eased toward wCharFacingDesired by at most wCharFacingEaseRate per frame
w7CharFacingShown:: db
; [8-bit] State flags; bit 2 = airborne (set on a jump, cleared on landing; selects the shadow slot drawn)
w7CharFlags:: db
; [8-bit] Frames the character is frozen: UpdateCharStateMachine decrements it and skips the state. SetCharState clears it; FreezeMinigameOpponentOnReturn sets it to hold the minigame opponent still
w7CharFreezeTimer:: db
; [8-bit] Frames left to press a second shot button; BufferShotButtonPress seeds 5 on the first press, the state-machine dispatch counts it down
w7CharShotComboTimer:: db
; [8-bit] AI countdown: the reaction delay AiSetReactionDelay randomises, and the hold time AiServePressToss uses for the toss button
w7AiActionTimer:: db
; [8-bit] Frames the AI holds its first shot button before adding the second: AiWaitThenPickShot sets 5 after AiPressFirstShotButton, and AiSwingControlSingles/Doubles skip AiPressSecondShotButton while nonzero. Counted down only after wAiActionTimer reaches 0
w7AiSecondButtonDelay:: db
; [8-bit] SHOTTYPE_* of the swing about to happen, from the two buffered buttons via SelectServeShotType / SelectRallyShotType
w7CharShotType:: db
; [8-bit] Swing animation id SelectForehandBackhand picked; the windup plays it + $08, the contact phase plays it as is
w7CharSwingAnim:: db
; [8-bit] First shot button of the swing (1 = A, 2 = B), 0 = none. With wCharShotButton2 it indexes RallyShotTypeTable0/1, turning A+B combinations into lobs, drops and power shots
w7CharShotButton1:: db
; [8-bit] Second shot button, captured while wCharShotComboTimer runs
w7CharShotButton2:: db
; [8-bit] State-machine index (RST00 jumptable at $6a77; set via SetCharState)
w7CharState:: db
; [8-bit] Sub-step within wCharState; AdvanceCharStatePhase increments it, each state's phase routine dispatches on it
w7CharStatePhase:: db
; [8-bit] Sub-step of the AI state machine, advanced by AiAdvancePhase
w7AiPhase:: db
; [3 bytes] Current sprite frame pointer (hi/lo) + h-flip flag, used by DrawCharSprite
w7CharSpriteFrame:: ds 3
; [8-bit] Which input drives this character; ReadCharInput indexes CharInputPtrs with it (pad, CPU and link handlers)
w7CharInputSource:: db
; [8-bit] Input ReadCharInput produces: held buttons in the high nibble, newly pressed in the low (ReadCharPadInput builds it from hPlayerInputFlags and hInputRisingEdge); test with PADB_*
w7CharInputBits:: db
	ds 1
; [8-bit] Object-definition id passed to SetupCharSpriteFromObjectDef; write-only
w7CharObjectDefId:: db
; [8-bit] ROM bank of the character's object definition, animation scripts and frame tables, banked in by GetPerspectiveScale and passed to FarReadWordDI by SetCharAnimation / StepCharAnimation. 0 = no object loaded (UpdateChar exits)
w7CharObjectBank:: db
	ds 1
; [16-bit] Pointer (in wCharObjectBank) to the frame graphics table GetPerspectiveScale walks for a frame's tile data
w7CharFrameTablePtr:: dw
; [16-bit] VRAM destination of the character's frame tiles
w7CharFrameVramDest:: dw
; [16-bit] Pointer (in wCharObjectBank) to the animation-pointer table; SetCharAnimation indexes it by animation id
w7CharAnimTablePtr:: dw
; [16-bit] Start of the current animation script, where the $ff (jump) command rewinds to
w7CharAnimScriptBase:: dw
; [16-bit] Cursor into the current animation script. Word-sized commands: < $f0 is [frame, delay], $ff jumps, $fe switches animation, $fb toggles the flip bits of wCharSpriteAttr
w7CharAnimScriptPtr:: dw
; [8-bit] Animation playing; SetCharAnimation returns early when asked for the same one
w7CharAnimId:: db
; [8-bit] Frames left on the current animation frame; $ff = hold indefinitely
w7CharAnimDelay:: db
; [8-bit] Sprite bookkeeping flags. Bit 6 = frame or facing octant changed, so ReloadCharFacingTiles uploads new tiles (and clears the bit)
w7CharSpriteDirty:: db
	ds 1
; [8-bit] Facing octant 0-7 from wCharFacingShown; picks the tile row and, for octants 2 and 6, the mirrored sprite
w7CharFacingOctant:: db
; [8-bit] Frame id the animation script last selected
w7CharAnimFrame:: db
	ds 2
; [8-bit] First VRAM tile of the character's sprite, from a per-character-index table
w7CharTileBase:: db
; [8-bit] OAM attribute byte. The low three bits are the CGB OBJ palette (wCharIndex + 4) and also the tile block ReloadCharFrameGfx uploads into (& $07, + $08); the high bits are the flip bits the animation's $fb command toggles, cleared by SetCharAnimation (`and $0f`)
w7CharSpriteAttr:: db
; [16-bit] Pointer (in wCharObjectBank) to the per-frame shadow/scale table GetPerspectiveScale reads
w7CharShadowTablePtr:: dw
; [8-bit] ROM bank of the character's frame graphics; ReloadCharFrameGfx and LoadCharChargeFlashGfx pass it to the far-call vector at $0110
w7CharGfxBank:: db
	ds 5
; [16-bit] X velocity (zeroed on placement and at point end)
w7CharVelX:: dw
; [16-bit] Depth velocity
w7CharVelDepth:: dw
; [16-bit] Height velocity
w7CharVelHeight:: dw
; [16-bit] Walk-target X (integer part)
w7CharWalkTargetX:: dw
; [16-bit] Walk-target depth; MoveCharTowardTarget walks toward the target, snapping when both deltas are < $18 (CheckCharNearTarget)
w7CharWalkTargetDepth:: dw
; [8-bit] Left/right aim held at the moment of the shot, captured by CaptureServeAim / CaptureShotAim; GetShotAimOffsetForSide and ComputeShotTargetX turn it into the target's lateral offset
w7CharAimOffset:: db
; [8-bit] Frames in the current swing phase, reset at windup start, incremented by the windup and contact phases
w7CharSwingFrames:: db
; [8-bit] Set when the swing was quick (uncharged): written by StartCharSwing, copied to wShotWasQuickSwing by ExecuteShot so the shot gets no charge bonus
w7CharQuickSwing:: db
; [8-bit] Shot button latched while the swing is held, from b in CheckSwingRelease; cleared there when SELECT is down and by CharRallyReadyPhase. Write-only
w7CharSwingHoldButton:: db
; [8-bit] Frames the swing has been held: CheckSwingRelease increments it per frame and zeroes it on release or with SELECT down. Write-only
w7CharSwingHoldFrames:: db
; [8-bit] Shot button already recorded, so BufferShotButtonPress ignores it while held
w7CharLastShotButton:: db
; [8-bit] This frame's ball-geometry tests, rebuilt by UpdateCharBallGeometry: bit 0 = ball within swing range, bit 1 = inside the contact window, bit 4 = within normal reach (clear selects the stretching shot table)
w7CharBallReachFlags:: db
; [8-bit] Set while the charge flash plays; cleared when the swing starts or aborts
w7CharChargeFlashOn:: db
; [8-bit] 1 while the flashed tiles are in VRAM. UpdateChargeFlash toggles the flash on wCharSwingFrames bit 2; this latch makes each half load its graphics once (set + LoadCharChargeFlashGfx, or clear + ReloadCharFrameGfx)
w7CharChargeFlashGfxLoaded:: db
; [8-bit] Last projected screen X (BuildCharSpriteSlots)
w7CharScreenX:: db
; [8-bit] Last projected screen Y
w7CharScreenY:: db
; [8-bit] Zeroed right after each write of wCharWalkTargetX / wCharWalkTargetDepth; nothing reads it
w7CharWalkTargetFlag:: db
; [8-bit] Set to 1 by MoveCharTowardTarget when it steps the character toward the walk target; UpdateCharStateMachine clears it each frame and UpdateCharVelocityFromInput returns while it is set, so a scripted walk overrides the stick
w7CharScriptedMove:: db
; [8-bit] Point result from this character's side (signed wPointWinLoseFlag)
w7CharPointResult:: db
; [8-bit] Shot buttons the AI chose for this swing (AiPickServeButtons / AiPickShotButtons); AiPressFirstShotButton and AiPressSecondShotButton feed them into wCharInputBits one at a time
w7AiShotButtons:: db
; [8-bit] Countdown seeded from wAiTrackingParam whenever the AI advances a phase after fixing a target. AiWaitThenPickShot decrements it per frame and picks no shot until 0 (or until wCharBallReachFlags bit 0 says the ball is in reach), so a larger parameter commits later
w7AiTrackingCountdown:: db
; [8-bit] Set to 1 by CharRallyReadyPhase, cleared with wCharShotButton1/2 when a shot is abandoned. AiTrackBallPhase does not steer while it is 0
w7CharRallyReady:: db
	ds 5
; [16-bit] Speed limit on X: ClampCharXSpeed multiplies it by the cosine of wCharFacingDesired. From CharStatTable_07_0 indexed by attribute byte $0027
w7CharMaxSpeedX:: dw
; [16-bit] Speed limit on depth: ClampCharDepthSpeed multiplies it by the sine of wCharFacingDesired. LoadCharacterAttributes indexes CharStatTable_07_0 with attribute bytes ($0027 + $002b) * 2, clamped to ten entries, so this axis gets the $002b bonus that wCharMaxSpeedX does not
w7CharMaxSpeedDepth:: dw
; [16-bit] Acceleration, from CharStatTable_07_1 via attribute offset $0028. AccelerateCharDepth / AccelerateCharX multiply it by the sine/cosine of wCharFacingDesired into wCharVelDepth / wCharVelX
w7CharAcceleration:: dw
; [16-bit] Deceleration when not accelerating, from CharStatTable_07_2 via attribute offset $002a. The brake routines negate it against the velocity's sign; one uses a flat $0040 when wCharFlags bit 1 is clear
w7CharDeceleration:: dw
; [8-bit] Max facing change per frame (wCharFacingShown toward wCharFacingDesired)
w7CharFacingEaseRate:: db
; [8-bit] Fraction ComputeAimBaseOffset applies (MulHLByAFrac) to the base aim offset. From CharStatTable_07_4 via attribute offset $0025
w7CharAimOffsetScale:: db
; [8-bit] Random aim component: GetRandomAimJitter multiplies an AdvanceMatchRng byte by it; higher is less accurate. From CharStatTable_07_5 via attribute offset $0026
w7CharAimJitterScale:: db
; [8-bit] Speed-row index (e) into the ShotPlacementData tables for ground strokes (topspin/slice/power variants/neutral); selects bytes 4-5 (shot speed) in LoadShotPlacementEntry
w7GroundStrokeSpeedIndex:: db
; [8-bit] Speed-row index (e) into ShotPlacementData for the smash and all three serves
w7SmashServeSpeedIndex:: db
; [8-bit] Speed-row index (e) into ShotPlacementData for the reach (smash-range) shot variants
w7ReachSpeedIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementData for topspin and serve-topspin; selects bytes 0-3 (target offsets) in LoadShotPlacementEntry
w7TopspinPlacementIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementData for slice and serve-slice
w7SlicePlacementIndex:: db
; [16-bit] How far above or below the character the ball can be hit; CheckCharBallContact compares |wBallRelCharHeight| with it. Attribute record +$10, minus $10
w7CharReachHeight:: dw
; [16-bit] Lateral reach; CheckCharBallContact compares |wBallRelCharX| * 2 with it. Attribute record +$12
w7CharReachX:: dw
; [16-bit] Upward speed of a jump smash, negated into wCharVelHeight by StartCharSwing. Attribute record +$14, plus $0200
w7CharSmashJumpSpeed:: dw
; [16-bit] Lunge speed of a dive, turned into wCharVelX/wCharVelDepth along the facing by VectorFromLengthAndAngleRaw. Attribute record +$16
w7CharDiveSpeed:: dw
; [8-bit] Character id passed to InitChar, before RemapExtendedCharId
w7CharId:: db
; [8-bit] Base frames the AI waits before reacting to a ball within normal reach; AiSetReactionDelay adds 0-3 at random into wAiActionTimer. Attribute record +$1b
w7AiReactionDelayNear:: db
; [8-bit] The same for a ball outside normal reach (wCharBallReachFlags bit 4 clear). Attribute record +$1c
w7AiReactionDelayFar:: db
; [8-bit] How the AI chases the ball; read by AiTrackBallPhase and the baseliner rally state. Attribute record +$1d
w7AiTrackingParam:: db
; [8-bit] RNG threshold in AiMaybeAimAwayFromChar: the AI aims away from the opponent when the roll is under it. Attribute record +$1e
w7AiAimAwayChance:: db
; [8-bit] AI serve/shot habit: low nibble indexes ServePressTossPtrs for toss timing; AiPickShotButtons reads it too. Attribute record +$1f
w7AiServeStyle:: db
; [8-bit] Character id after RemapExtendedCharId; LookupCharSpriteSet and bank $09's LoadOnCourtCharacterGfx find the sprite bank with it
w7CharSpriteSetId:: db
; [8-bit] Where the AI stands between shots (0/5 baseline, 1 net, others mid-court); RST00 index in AiChooseHomePosition and AiChoosePositionByStrategy. Attribute record +$0f
w7AiPositionStrategy:: db
; [4 bytes] Sprite-slot record [tile, attr, screenY, screenX] for the character sprite
w7CharSpriteSlot:: ds 4
; [4 bytes] Frame descriptor the single-character screens (Unused_1a_DrawCharViewerCharSprite, the results/EXP screen drawers) write after the sprite slot: wCharSpriteFrame + 2 (the 32x32 flag), + 1 and + 0 (Y and X offsets for QueueSprite24x32), and a depth key (slot * 8 + $80). The match engine's drawer does not use it
w7CharSpriteSlotFrame:: ds 4
; [4 bytes] Sprite-slot record for the airborne shadow (tiles $50/$52/$54/$56 shrinking with height; drawn only while wCharFlags bit 2 is set)
w7CharAirShadowSlot:: ds 4
; [4 bytes] Sprite-slot record for the standing shadow (tile $58, flickered while grounded)
w7CharGroundShadowSlot:: ds 4
; [16-bit] Attribute word from character record +$19; StartCharSwing tests bit 7 of the low byte; bits 0 and 1 of the high byte select the lob and drop placement rows
w7CharSwingAttrWord:: dw
; [8-bit] Placement-row index (d) into ShotPlacementDataLob (from wCharSwingAttrWord + 1 bit 0)
w7LobPlacementIndex:: db
; [8-bit] Placement-row index (d) into ShotPlacementDataDrop (from wCharSwingAttrWord + 1 bit 1)
w7DropPlacementIndex:: db
; [8-bit] Attribute bits XORed into wCharSpriteAttr for facing octants 2 and 6 (sprite drawn mirrored)
w7CharMirrorAttrMask:: db
; [8-bit] Character class/tier from attribute record +$18; LookupExpTierForChar reads it on the EXP screen
w7CharExpTier:: db
; [8-bit] Draw-order depth key ((depth * 8) >> 8 + $80); DrawActorsByDepth draws back to front
w7CharDepthKey:: db
ENDU
