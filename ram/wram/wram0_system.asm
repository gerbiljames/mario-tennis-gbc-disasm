; WRAM0 $c000-$c3ff: OAM and VRAM queues, timers, palettes, frame tasks, story location and camera state.

SECTION "WRAM0 $c000", WRAM0[$c000]

; [160 bytes] Shadow OAM: 40 x 4-byte entries [y, x, tile, attr], copied to $fe00 every frame by hOAMDMARoutine. Cleared on its own by the boot path; only written through pointers
wShadowOAM:: ds 160
	export_size wShadowOAM

; [80 bytes] VBlank VRAM copy queue: 10 x 8-byte entries [rom bank (0 = slot free), wram bank, src hi, src lo, vbk, dest hi, dest lo, length in 16-byte blocks - 1]. ProcessVRAMCopyQueues banks in the source, writes +$02..+$06 to $ff51-$ff54 and rVBK, starts the transfer by writing +$07 to $ff55, and clears +$00
wVRAMCopyQueue:: ds NUM_VRAMCOPY_SLOTS * VRAMCOPY_SLOT_SIZE
	export_size wVRAMCopyQueue

; [4 bytes] Play timer: frames (0-59), seconds, minutes, hours (caps at 99)
wGameTimer:: ds 4

; [8-bit] Enables wSecondaryTimer: UpdateGameTimer ticks it only while this is exactly 1. Unused_00_TickSecondaryTimerCountdown writes $ff here when its clock runs out ($ff = expired)
wSecondaryTimerMode:: db

; [3 bytes] Second clock, ticked by Unused_00_TickSecondaryTimer: frames (0-59), seconds, minutes. Saturates at 9:59. Unused_00_TickSecondaryTimerCountdown runs it downwards, sound $af each second and sound $b0 at zero
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

; [8-bit] Set to 1 by UpdatePlayerControl when the point straight ahead of the player is blocked. The location event loop consumes it; together with wPlayerWallPushFrames reaching $1e frames against an unchanged wPlayerBlockedBy it turns walking into a door or sign into an interaction
wStoryAutoInteractArmed:: db

; [8-bit] $ff once the auto-interact has raised wStoryModeInteractRequest this frame, else 0. Read only by the debug-menu check later in the frame, which then stands down
wStoryAutoInteractFired:: db

; [8-bit] Set to 1 on an A press in the overworld; the event loop then tries NPC interaction (FindActorFacingPlayer), facing-tile script, and tile trigger
wStoryModeInteractRequest:: db

; [8-bit] Set to 1 on a Start press in the overworld; opens RunStoryModeMenu
wStoryModeMenuRequest:: db
	ds 10

UNION
; [8-bit] Scene stage of the loaded location, derived from save flags by the map's init script (SetupCenterCourtSceneVariant, InitCourt1SceneVariant, ComputeIslandOpenRound, Unused_27_ComputeRankingProgressIndex, ...). NPC scripts index per-stage text-id tables with it. Values are per location. First byte of the $c2b0-$c2bf per-location scratch block
wMapSceneStage:: db
; [8-bit] Second per-location scene stage, set by map init scripts (CafeteriaInitScript_10, RestaurantInitScript_10, ComputeSeniorCourtStage) and read by that location's NPC scripts to pick a text id
wMapSceneStage2:: db
NEXTU
	ds 1
; [8-bit] Training Court (bank $15): the actor slot of the challenger a result scene walks on, from TrainingCourtReentryDispatch or the scene itself: $06 Bob (serve), $0c Allie (stroke), $11 Brian (net)
wChallengerActor:: db
NEXTU
; plane cutscenes (bank $14: IslandSkyInitScript_14, IslandSkyHomeFromIslandOpenScene, IslandSkyHomeFromPeachsCastleScene, IslandSkyToPeachsCastleScene and the plane sprite drawers)
; [8-bit] World X of the plane sprite; GetSceneObjectScreenPos_14 subtracts hScrollX
wCutscenePlaneX:: db
; [8-bit] World Y of the plane sprite; GetSceneObjectScreenPos_14 subtracts hScrollY, QueuePlaneSpriteByHeight_14 picks the sprite size from it
wCutscenePlaneY:: db
NEXTU
; [16-bit] Frames left in Unused_10_SwingContestPrototype; Unused_10_SwingContestCountTask counts it down (the bank $15 contest keeps it 2 bytes higher)
wUnusedSwingProtoTimer:: dw
ENDU

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
; [2 bytes] Per-slot phase limit, rerolled from the RNG when a splash respawns; AnimateIslandSkyEffectSprites_14 instead counts frames in byte 0 (sprite frame 1-3, wraps at 3)
wCutsceneObjLimit:: dw
; [2 bytes] Frames left in the rise, counted down by AdvanceWaterSplash0Rise_14 / AdvanceWaterSplash1Rise_14, which also lift wCutsceneObjY by 2 per frame
wCutsceneObjRiseTimer:: dw
; [2 bytes] Per-slot halt flag: 0 while the effect runs (cleared when it starts), 1 set just before the scene exits. Nonzero skips the rise step and the island anim tick, and lets a splash finish instead of respawning
wCutsceneObjHalt:: dw
NEXTU
; water-sprite swing contest (bank $15)
	ds 2
; [16-bit] Frames left in the swing contest; WaterSpriteSwingCountTask counts it down and ends the contest at 0
wSwingContestTimer:: dw
; [16-bit] Swings counted, incremented per A/B press and printed by PrintHexWord
wSwingContestSwings:: dw
; [8-bit] Previous frame's A/B state, so one press counts once
wSwingContestPrevInput:: db
; [8-bit] Player pose: starts 1 (recover), each counted swing flips 1 <-> 2 (swing); 0 when the timer runs out ends the contest
wSwingContestSwingState:: db
; [8-bit] Screen X of the timer panel QueueWaterSpriteMinigameHudPanels draws; slid on and off by the scene
wSwingContestTimerPanelX:: db
; [8-bit] Screen X of the counter panel; seeded by InitWaterSpriteMinigameHud
wSwingContestCounterPanelX:: db
NEXTU
; bank $10's swing contest prototype (Unused_10_SwingContestPrototype)
; [16-bit] Swings counted and printed by PrintHexWord
wUnusedSwingProtoSwings:: dw
; [8-bit] Previous frame's A/B state
wUnusedSwingProtoPrevInput:: db
; [8-bit] 1 while the count task runs; the prototype waits for 0
wUnusedSwingProtoRunning:: db
NEXTU
; Training Court challenger dialogue ids (bank $15, $5d00-$6400)
; [16-bit] Each challenger result scene writes its court's tied-point text id here (Text_ServeRivalTiedKeepGoing serve, Text_BrianTiedKeepGoing net, Text_AllieEvenKeepGoing stroke) when wPointWinLoseFlag is WINLOSE_NONE, one slot below the ids the handlers read. Nothing reads it; the live copy is wChallengerTiedTextId
wUnusedChallengerTiedTextId:: dw
; [16-bit] Tied-point text id (Text_*TiedKeepGoing) seeded per court by the challenger setup scenes; ChallengerResultTied (WINLOSE_NONE) speaks it
wChallengerTiedTextId:: dw
; [16-bit] Rival-won text id, spoken by ChallengerResultRivalWon (WINLOSE_LOSE, the player lost)
wChallengerRivalWonTextId:: dw
; [16-bit] Rival-lost text id, spoken by ChallengerResultRivalLost (WINLOSE_WIN, the player won)
wChallengerRivalLostTextId:: dw
; [16-bit] Follow-up dialogue text id spoken after the verdict line; overlaps the swing contest's two HUD bytes
wChallengerFollowupTextId:: dw
NEXTU
; saved player position (SavePlayerActorPosition, bank $0f; the test maps read it back)
; [16-bit] Player actor's ACTORF_X
wSavedPlayerX:: dw
; [16-bit] Player actor's ACTORF_Y
wSavedPlayerY:: dw
NEXTU
; Training Center (bank $0e): gym runners and the repair counter
; [16-bit] The running student's ACTORF_X; TrainingGymRunnerCheckClearance compares it with wGymRunnerTargetX
wGymRunnerX:: dw
; [16-bit] The running student's ACTORF_Y
wGymRunnerY:: dw
; [16-bit] The next runner's ACTORF_TARGET_X
wGymRunnerTargetX:: dw
; [16-bit] The next runner's ACTORF_TARGET_Y
wGymRunnerTargetY:: dw
; [8-bit] wStoryMainEquipment before the racket/shoes select screen; CheckEquipmentUnchanged compares against it
wRepairCounterEquipSnapshot:: db
	ds 1
; [8-bit] Text_MenuEquipChange choice: 0 rackets, 1 shoes, 2 / $ff leave. Also the offset added to the per-item text ids
wRepairCounterChoice:: db
NEXTU
; Peach's exhibition match prompt (bank $0e: PromptExhibitionMatch, ExhibitionMatchIntroCutscene, RunExhibitionMatch)
; [16-bit] Text id of the singles/doubles prompt
wExhibitionPromptTextId:: dw
; [8-bit] ENTRY_SPECIAL_COURT_* the warp enters by; the Special Court intro rewrites it as entry - 1, ExhibitionMatchSettingsPtrs's index
wExhibitionMatchEntry:: db
NEXTU
; roommate dialogue (bank $13: DormRoomReturnFromEntranceScene, RunAcademyQuestionsMenu)
; [16-bit] First text id of the scene's dialogue variant; the scene and the AcademyTopic* handlers add line offsets to it
wRoommateTextIdBase:: dw
NEXTU
	ds 6
; [8-bit] Tennis Machine level being offered (0-based); MachinePracticeLevelPrompt prints it + 1 and runs MINIGAME_TENNIS_MACHINE_1 + it
wMachinePracticeLevel:: db
NEXTU
	ds 6
; actor placement near the player (ComputeEmoteActorPosition_13, PlaceRoommateAtPlayerTarget_13, RestaurantShowEllipsisBalloonNearPlayer_10), passed to ScriptSetActorPosition
; [16-bit] World X
wPlaceActorX:: dw
; [16-bit] World Y
wPlaceActorY:: dw
NEXTU
; generic location scratch
; [14 bytes] Rest of the location's scratch block after wMapSceneStage / wMapSceneStage2. Story scripts in banks $0e-$13 use it for whatever the location needs (a saved actor position, a name for a text argument, menu working bytes); the fixed-layout overlays are the variants above
wMapScratch:: ds 14
ENDU

; [8 bytes] Staging copy of one map-table record, far-copied from wStoryLocationBank after FindStoryScriptEntry finds it. Read through the MAPENTRY_* or MAPSCRIPT_* fields (RunLocationExit reads the two map_script args as destination location and entry point)
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

; [8-bit] The talked-to actor's ACTORF_ANIM_RATE_MOVING, saved by RunNpcInteraction while it forces it to 1 for the script, restored afterwards
wStoryScriptSavedActorAnimRate:: db

; [8-bit] The talked-to actor's ACTORF_ANIM, saved by RunNpcInteraction when the handler's arg0 has bit 3 set and restored with SetActorAnimationChecked afterwards
wStoryScriptSavedActorAnim:: db

; [8-bit] Set to 1 by RunStoryScriptOrDialogue when it dispatches a location script; the overworld loop clears it before checking interactions and stops looking for triggers this frame once set
wStoryScriptRan:: db

; [8-bit] Write-only: RunNpcInteraction, RunFacingTileScript, RunQueuedTriggerScript and RunLocationExit store the id they look up; nothing reads it
wUnusedStoryScriptId:: db
	ds 4

; [8-bit] Frames left before a drill point gives up: UpdateDrillAbortCountdown decrements it while wDrillAbortCountdownActive is set and wPointOutcome is 0, setting wMatchAbortFlag at 0. Point start loads DRILL_ABORT_FRAMES
wDrillAbortCountdown:: db

; [8-bit] Nonzero enables wDrillAbortCountdown; cleared at point start, set once the drill waits for the point-ending shot
wDrillAbortCountdownActive:: db

; [8-bit] Cleared by ServiceMatch2Hook_PointStart and read by nothing
wUnusedDrillPointStartByte:: db

; [8-bit] Why the coach's drill ended, written by each ServicePractice*/NetGamePractice*/StrokePractice* EvaluateResult (LESSON_*: LESSON_PASSED, else a per-coach, per-lesson reason). The bank $15 training-court coaches pick their follow-up dialogue on it
wDrillLessonResult:: db

; [8-bit] One bit per point of the drill, set by RecordDrillTargetZoneMiss when the ball's first bounce landed outside the target zone (IsBallInTargetZone returned z); CountDrillTargetZoneMisses and CheckDrillTargetZoneHit read it back
wDrillTargetZoneMissBits:: db

; [8-bit] One bit per point of the drill, set by RecordGateCrossOnServe when the serve passed through the gate; counted by CountDrillGateCrosses, this point's bit tested by TestDrillGateCrossThisPoint
wDrillGateCrossBits:: db

; [8-bit] Queued drill message: index into DrillMessageTextIds_0b, $ff = none. Set by the Queue*/Set*Message helpers from the point outcome and server; ShowQueuedDrillMessage defaults it to $6c and shows it
wDrillMessageId:: db

; [9 bytes] Per-drill counters (DRILLCTR_*). Each drill's hooks clear the ones they need at MinigameStart/PointStart and increment them; successful-shot counts go to wPlayer1PointsWon/wPlayer2PointsWon at point end, and EvaluateResult compares them against 4 (shots per drill)
wDrillCounters:: ds 9
	ds 8

; [2 bytes] Indexed by wCurrentServingPlayer: +1 (target hit) / -1 (missed) from CheckDrillTargetZoneHit; only the unreferenced Unused_0b_StoreDrillServeTargetResult stores it. Read by ServiceMatch2HandlePointEnd and the Service Match 2 ace message
wDrillServeTargetResult:: dw
	ds 2

; [2 bytes] Two bits per shot of the point, one byte per side. RecordDrillPointResultBits rotates wPointWinLoseFlag into the byte DrillPointResultBitsTable selects; CountDrillShotSuccesses counts pairs equal to 1; bank $06's DrawScoreboardPackedPips draws them as pip rows
wDrillShotResultBits:: dw
	ds 1

; [8-bit] Judgement of the current drill point in WINLOSE_* terms for the drilling player: WINLOSE_NONE until judged, then WINLOSE_WIN or WINLOSE_LOSE. *JudgeOn* hooks store their JudgePoint result; JudgePoint returns early while it is nonzero, so the first judgement wins. The HandlePointEnd routines copy it into wPointWinLoseFlag, negated on odd points
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

; [8-bit] Scene index of the current story location or court (LoadStorySceneGraphics, LoadCourtSceneGraphics); GetSceneSlotPtr indexes SceneGfxSlotTable with it (index*16)
wCurrentScene:: db
	ds 1

; [8 bytes] Four scene tile-animation slots, 2 bytes each: current offset into the animation script at wSceneTileAnimEntries, then frame countdown. The scroll task calls AdvanceSceneTileAnimation on a slot whose countdown reaches zero
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
; 0x07 - Exhibition Match (link)
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
; 0x2a - Island Open Lost
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

; [8-bit] Nonzero makes RenderInlineNumber right-align its number in a five-character field. Set and cleared around the Text_NumberArg line only
wTextNumberRightAlign:: db

; [8-bit] Argument of text control code $0e: a character id, which TextCmdPrintCharName and MeasureCharNameArgWidth print as text id $1b + id
wTextCharNameArg:: db

; [8-bit] Destination row pitch, negated: the text setup writes -c (-$20 for a tilemap); TextCmdNextGlyphStreamRow negates and doubles it to step wTextRowStartPtr two rows. Zeroed when a text window closes
wTextRowPitchNeg:: db

; [8-bit] Screen shake strength: $ff = off, else 1-3 (SetScreenShake clamps to 3 and registers/unregisters the UpdateScreenShake frame task). UpdateScreenShake masks a random word to that many bits for the two offsets
wScreenShakeMagnitude:: db
	ds 4

; [8-bit] Signed screen-shake X offset, regenerated each frame by UpdateScreenShake. UpdateSceneScroll adds it before writing hScrollX; bank $04's ComputeSpriteScrollOffset applies it to objects
wScreenShakeOffsetX:: db

; [8-bit] Signed screen-shake Y offset; biases hScrollY like wScreenShakeOffsetX
wScreenShakeOffsetY:: db
	ds 2

; [8-bit] Active story save-slot index (0-2, or STORYSLOT_NONE outside story mode); selects which SRAM story slot CheckStorySlot / SaveStorySlotWithTimer operate on
wCurrentStorySlot:: db
	ds 2

; [8-bit] Message id Unused_1a_DrawExpBonusMessage shows ($01-$03, $14-$1e) when the EXP screen has a bonus to add after the gauge fills, else 0; the level-up path folds wExpBonusAmount into wExpAwardTotal and clears it
wExpBonusMessageId:: db

; [16-bit] The bonus EXP added to wExpAwardTotal after the first fill
wExpBonusAmount:: dw
	ds 4

; [8-bit] Minigame level - 1 (0x00-0x03); MINIGAMELEVEL_HIGH_SCORE is a Mario minigame's high-score level
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

; [8-bit] Write-only: the court slot 0 character id, stored by match setup (InitStoryMatchSettings, RunLinkMatchSequence, RunTwoOnOneMatch, the drill and minigame starters, the debug test modes and character viewer); nothing reads it
wMatchPlayerChar:: db

; [8-bit] Character id assigned to court slot 2 (opponent's main character) during match setup
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
