; WRAM layout. Each symbol's note gives its size and what reads and writes
; it; the banked and overlaid ranges are UNION blocks, one variant per owner
; (docs/ram_map.md). Hand-maintained.

SECTION "WRAM0 $c000", WRAM0[$c000]

; [160 bytes] Shadow OAM: 40 x 4-byte entries [y, x, tile, attr], copied to $fe00 every frame by hOAMDMARoutine (which sources page $c0). Cleared as its own unit by the boot path (ld hl, $c000 / ld c, $0a / ClearMemory16); only ever written through pointers, never by a direct [$c0xx] operand
wShadowOAM:: ds 160
	export_size wShadowOAM

; [80 bytes] VBlank VRAM copy queue: 10 x 8-byte entries, one per pending transfer. A slot is the five CGB VDMA registers plus the two banks needed to reach the source: [rom bank (0 = slot free), wram bank, src hi, src lo, vbk, dest hi, dest lo, length in 16-byte blocks - 1]. ProcessVRAMCopyQueues banks in the source, writes +$02..+$06 straight through to $ff51-$ff54 and rVBK, and writing +$07 to $ff55 starts the transfer; it clears +$00 as it consumes the slot
wVRAMCopyQueue:: ds 80
	export_size wVRAMCopyQueue

; [4 bytes] Play timer: frames (0-59), seconds, minutes, hours (caps at 99)
wGameTimer:: ds 4

; [8-bit] Enables the second timer at wSecondaryTimer: UpdateGameTimer ticks it only while this reads exactly 1. The stranded countdown routine at $00:$240a (nothing calls it) writes $ff here when its clock runs out, so $ff means expired
wSecondaryTimerMode:: db

; [3 bytes] Second clock alongside wGameTimer, ticked by Unused_00_TickSecondaryTimer: frames (0-59), seconds, minutes. It saturates at 9:59 rather than wrapping (minutes reaching $0a is undone and seconds pinned to $3b). The stranded countdown at $00:$240a runs the same three bytes downwards, one sound $af per second and sound $b0 at zero
wSecondaryTimer:: ds 3

; [8-bit] Width in pixels of the glyph Unused_00_RenderGlyphToTiles is drawing, read from the glyph's first byte. It is the inner loop count, one iteration per pixel column, and the caller re-reads the same byte after the call to advance the pen
wGlyphBlitWidth:: db

; [8-bit] Rows still to draw in Unused_00_RenderGlyphToTiles, seeded from the glyph's second byte and decremented once per row
wGlyphBlitRowsLeft:: db

; [8-bit] Destination bit mask for Unused_00_RenderGlyphToTiles, PixelMaskTable[penX & 7]. It is rotated right once per pixel; the wrap from $01 back to $80 is what advances the destination to the next tile column
wGlyphBlitDestMask:: db

; [5 bytes] Peak LY of the last frame as four hex digits, written by AdvanceFrame with FormatHexWord and copied to $9d08 by UpdateDebugOverlay
wDebugPeakLYText:: ds 5

; [64 bytes] Live BG palette buffer, uploaded in VBlank when hPaletteDirtyFlags bit 0 set
wBGPalettes:: ds 64

; [64 bytes] Live OBJ palette buffer, uploaded in VBlank when hPaletteDirtyFlags bit 1 set
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
; The RetroAchievements note this list comes from says "Castle Court" for 0x1c; that is a mix-up with the adjacent id and is corrected above. LoadStoryLocationHeader ($0a:$5142) computes the location popup's text id as $0179 + id, which makes 0x1c the string "Special Court" and 0x1d "Peach's Castle" (there is no "Castle Court" string in the ROM); the note's own BGM list puts Castle Court's music (0x12) on 0x1d, and 0x1c's story_location record selects BGM 0x08. The full space is 0x00-0x29, one record each in StoryLocationTable_0a; see the STORYLOC_* defs in include/constants.inc for the game's own wording of every id, including the 0x01-0x04 debug maps the note omits
wStoryModeCurrentLocation:: db

; [8-bit] Scene id of the loaded story location, byte 1 of its story_location record. Passed in a to LoadStorySceneGraphics, which indexes SceneGfxSlotTable with it
wStoryLocationScene:: db

; [2 bytes] The loaded location's map_scripts reference, copied straight out of its story_location record in the dslot encoding: slot offset into the target bank's $4000 directory, then the ROM bank. LoadStoryLocationHeader takes the bank byte for wStoryLocationBank and hands the pair to CopyDataFromBank, which resolves it and copies the 7-word map_tree to wMapEntryPointsPtr
wStoryLocationMapScriptsSlot:: dw

; [8-bit] BGM id from the loaded location's story_location record; $ff means leave the current music playing, anything else is handed to PlaySoundManaged as the location loads
wStoryLocationBGM:: db
	ds 1

; [16-bit] Slot 0 of the loaded location's map_tree: its map_entry spawn-record table. LoadStoryEntryPointRecord searches it for wStoryModeEntryPoint, and the not-found path falls back to the table's first record
wMapEntryPointsPtr:: dw

; [16-bit] Slot 1 of the map_tree: the map_script table RunLocationExit searches when the location loop is asked to leave
wMapExitTriggersPtr:: dw

; [16-bit] Slot 2 of the map_tree: the location's map_actor spawn list, passed to InitLocationActors
wMapActorsPtr:: dw

; [16-bit] Slot 3 of the map_tree: the map_script table RunNpcInteraction searches when the player talks to an actor
wMapNpcScriptsPtr:: dw

; [16-bit] Slot 4 of the map_tree: the map_script table RunFacingTileScript searches for the tile the player is facing
wMapFacingScriptsPtr:: dw

; [16-bit] Slot 5 of the map_tree: the map_script table RunTileTriggerScript and RunQueuedTriggerScript search for step-on triggers
wMapTileTriggersPtr:: dw

; [16-bit] Slot 6 of the map_tree: the location's init code, run by RunLocationInitScript once the map is up
wMapInitScriptPtr:: dw

; [8-bit] Write-only mirror of wStoryModeExitTriggerRequest ($c2a1): all 204 stores write the same value to both, and no instruction anywhere reads this one. Vestigial -- changing it has no effect
wUnusedExitTriggerIdMirror:: db

; [8-bit] Story Mode - entry point / spawn-door ID for the location being loaded; $ff = none (keep saved player position). LoadStoryEntryPointRecord searches the location's entry table with it
wStoryModeEntryPoint:: db

; [5 bytes] Story Mode - player spawn/return buffer: X (16-bit), Y (16-bit), facing; filled from the matched entry-point record or backed up from wStoryModePlayersXPosition before a submode
wStoryModeSpawnPosition:: ds 5
	export_size wStoryModeSpawnPosition

; [8-bit] ROM bank of the current story location's header and script data: the high byte of the far pointer at $c282, taken by LoadStoryLocationHeader. Every consumer (LoadStoryEntryPointRecord, FindStoryScriptEntry, GetTileTriggerAtPlayer, RunNpcInteraction, RunLocationExit, ...) passes it to FarReadByte or a farcall
wStoryLocationBank:: db

; [16-bit] The selected entry point's arrival_script, bytes 6-7 of its map_entry record. The location loader calls it through CallHLInBankA in wStoryLocationBank right after the LCD comes back on, and skips the call when the word is zero
wStoryArrivalScript:: dw
	ds 2

; [8-bit] Story Mode - queued tile trigger-script id (behavior-map cell with low nibble 1 stores its high nibble here); nonzero makes the overworld loop run RunQueuedTriggerScript
wStoryModeTriggerScript:: db

; [8-bit] Story Mode - nonzero requests leaving the current location loop (RunLocationExit + reload); one of the event-request flags at $c2a0-$c2a5 cleared by ClearStoryEventRequests. The value is an exit-trigger id, not a location: RunLocationExit ($0a:$560b) passes it in d to FindStoryScriptEntry, which matches it against the id column of the location's ExitTriggers table (map_tree slot 1), and the destination STORYLOC_* id is that row's arg0. So the same $01 leaves different locations for different places
wStoryModeExitTriggerRequest:: db

; [8-bit] Set to 1 by the overworld player-move code ($04:$52a6) on the frame the point ahead of the player resolves to a nonzero behaviour value. The location event loop consumes and clears it; combined with wPlayerMoving having reached $1e frames at an unchanged angle, it is what turns walking into a door or sign into an interaction
wStoryAutoInteractArmed:: db

; [8-bit] $ff once the auto-interact above has raised wStoryModeInteractRequest this frame, 0 otherwise. Its only reader is the debug-menu check further down the same frame, which stands down when an interaction already fired
wStoryAutoInteractFired:: db

; [8-bit] Story Mode - set to 1 on an A-press in the overworld; the event loop then tries NPC interaction (FindActorFacingPlayer), facing-tile script, and tile trigger
wStoryModeInteractRequest:: db

; [8-bit] Story Mode - set to 1 on a Start-press in the overworld; opens the story-mode menu (RunStoryModeMenu)
wStoryModeMenuRequest:: db
	ds 10

; [8-bit] Scene stage of the story location that is currently loaded. Each map's init script derives it from the save flags (SetupCenterCourtSceneVariant, InitCourt1SceneVariant, ComputeIslandOpenRound, ComputeRankingProgressIndex_27, ...) and the location's NPC scripts index their per-stage text-id tables with it, so one NPC speaks a different line as the story advances. Values are per location. $c2b0-$c2bf is the location's scratch block as a whole: the bank $14 island-sky and firework cutscenes borrow it for sprite positions and timers once a map is loaded, and the water-sprite minigame keeps its counters at $c2b4-$c2ba
wMapSceneStage:: db

; [8-bit] Second per-location scene stage, alongside wMapSceneStage; set by the map init scripts (CafeteriaInitScript_10, RestaurantInitScript_10, TrainingCourtReentryDispatch, the challenger result scenes) and read by the same location's NPC scripts to pick a text id
wMapSceneStage2:: db

; Story-script scratch, second half ($c2b0-$c2bf as a whole is the
; current location's scratch block; wMapSceneStage and wMapSceneStage2
; are its first two bytes). Two consumers overlay it: bank $14's island
; cutscenes keep two sprite slots here as parallel byte arrays, and bank
; $15's water-sprite swing contest keeps 16-bit counters over the same
; bytes. The three wWaterSpriteMinigame* names that used to sit here were
; global, so they also labelled the generic scratch use
; in banks $0e/$0f/$10/$13, which is what STATUS flagged as mis-scoped.
; Everywhere else the block is generic per-location scratch, which is what
; the default variant names.
UNION
; island cutscene sprite slots (bank $14, $5300-$7900)
; [2 bytes] World X of cutscene sprite slot 0 and slot 1; the drawers subtract hScrollX to get the OAM X. The plane sequence has no second object and borrows slot 0's byte as its frame counter (AdvancePlaneFrameCounter_14)
wCutsceneObjX:: dw
; [2 bytes] World Y of the two cutscene sprite slots
wCutsceneObjY:: dw
; [2 bytes] Animation phase of each slot: the splash's rise/fall step and the firework's burst step, both used to index the frame tables
wCutsceneObjPhase:: dw
; [2 bytes] Per-slot frame timer -- the splash's hit counter (0-8) and the firework's countdown to the next burst frame
wCutsceneObjTimer:: dw
; [2 bytes] Per-slot phase limit, rerolled from the RNG when a splash respawns
wCutsceneObjLimit:: dw
; [2 bytes] Frames left in the rise, counted down by AdvanceWaterSplash0Rise_14 / AdvanceWaterSplash1Rise_14, which also lift wCutsceneObjY by 2 each frame
wCutsceneObjRiseTimer:: dw
; [2 bytes] Per-slot active flag; 0 means the object is still rising and the hit test is skipped
wCutsceneObjActive:: dw
NEXTU
; water-sprite swing contest (bank $15)
	ds 2
; [16-bit] Frames left in the swing contest; WaterSpriteSwingCountTask counts it down and ends the contest at 0
wSwingContestTimer:: dw
; [16-bit] Swings counted so far, incremented on each A/B press and printed by PrintHexWord as the contest runs
wSwingContestSwings:: dw
; [8-bit] A/B rising edge from the previous frame, so one press counts once
wSwingContestPrevInput:: db
; [8-bit] 2 once a swing has been registered, 1 on the frame after -- which is how the swing animation is triggered exactly once
wSwingContestSwingState:: db
; [8-bit] Which HUD panels QueueWaterSpriteMinigameHudPanels draws
wSwingContestHudMode:: db
; [8-bit] Which HUD page the swing contest shows; InitWaterSpriteMinigameHud seeds it and QueueWaterSpriteMinigameHudPanels queues the panels for it
wSwingContestHudPage:: db
NEXTU
; Training Court challenger dialogue ids (bank $15, $5d00-$6400)
; [16-bit] Each challenger result scene writes its court's lose-dialogue text id here ($201d serve, $204a net, $2078 stroke) when the point was lost -- one slot below the id block the handlers actually read. The pre-scene setup seeds the same word into wChallengerLoseTextId, and nothing anywhere reads this copy, so the write is a vestigial duplicate of the lose slot
wUnusedChallengerLoseTextId:: dw
; [16-bit] Lose-dialogue text id the challenger setup scenes seed per court; the shared result handler's .lose arm reads it into hl for InitDialogueTextCursor. The bank-wide swing-contest names used to cover these sites, which is why the challenger machinery once read as contest timers
wChallengerLoseTextId:: dw
; [16-bit] Win-dialogue text id, read by the result handler's finish arm
wChallengerWinTextId:: dw
; [16-bit] Draw-dialogue text id, read by the result handler's draw arm
wChallengerDrawTextId:: dw
; [16-bit] Follow-up dialogue text id the result scenes speak after the verdict line; the setup scenes write it as a word across what the swing contest treats as two byte-wide HUD variables
wChallengerFollowupTextId:: dw
NEXTU
; generic location scratch
; [14 bytes] The rest of the current location's scratch block, after wMapSceneStage / wMapSceneStage2. Every story script in banks $0e-$13 uses it for whatever that location needs -- a saved actor position, a name being assembled for a text argument, a menu's working bytes -- so the block has a name and the offsets do not. The two overlays that do have a fixed layout (bank $14's cutscene sprite slots, bank $15's swing contest) are the scoped variants above
wMapScratch:: ds 14
ENDU

; [8 bytes] Staging copy of one record from the loaded location's map tables, far-copied here out of wStoryLocationBank after FindStoryScriptEntry locates it. Both record shapes land in the same eight bytes, so the field meanings depend on which table was searched: a map_entry gives facing at +1, X and Y at +2 and +4, and the arrival_script at +6; a map_script gives the flag condition at +2, the handler at +4 and its two argument bytes at +6 and +7 (RunLocationExit reads those two as destination location and entry point)
wStoryMapRecord:: ds 8
	export_size wStoryMapRecord
	ds 8

; [16-bit] Story Mode - Player's X Position
wStoryModePlayersXPosition:: dw

; [16-bit] Story Mode - Player's Y Position
wStoryModePlayersYPosition:: dw

; [8-bit] Player's facing in the overworld, one of the FACE_* values. UpdateActors snapshots it from the player actor's $d032 right after copying X/Y into wStoryModePlayersXPosition; observed live taking FACE_UP, FACE_RIGHT and FACE_DOWN as the player turns
wStoryModePlayerFacing:: db

; [8-bit] Story Mode - nonzero shows the location-name popup after fade-in (derived from wStoryModeEntryPoint != $ff; name pointer at $c2d6/$c2d7)
wStoryModeShowLocationName:: db

; [16-bit] Story Mode - text id of the current location's name, passed in hl to ShowLocationNamePopup when wStoryModeShowLocationName is set
wStoryModeLocationNameTextId:: dw

; [8-bit] The talked-to actor's +$19 byte, saved by RunNpcInteraction while it forces the byte to 1 for the duration of the script and restored when the script returns
wStoryScriptSavedActorBusy:: db

; [8-bit] The talked-to actor's +$2e animation, saved by RunNpcInteraction when the handler's arg0 has bit 3 set, and put back through SetActorAnimationChecked once the script returns
wStoryScriptSavedActorAnim:: db

; [8-bit] Set to 1 by RunStoryScriptOrDialogue whenever it dispatches a location script; the overworld frame loop clears it before checking for an interaction and stops looking for further triggers this frame once it is set
wStoryScriptRan:: db

; [8-bit] Write-only: RunNpcInteraction, RunFacingTileScript, RunQueuedTriggerScript and RunLocationExit each store the id they are about to look up, and nothing reads it back
wUnusedStoryScriptId:: db
	ds 4

; [8-bit] Frames left before a drill point gives up: UpdateDrillAbortCountdown decrements it each frame while wDrillAbortCountdownActive is set and wPointOutcome is still 0, and sets wMatchAbortFlag when it reaches 0. The point start hooks load it with $0a
wDrillAbortCountdown:: db

; [8-bit] Nonzero enables wDrillAbortCountdown; cleared at point start and set once the drill is waiting for the shot that ends the point
wDrillAbortCountdownActive:: db

; [8-bit] Cleared by ServiceMatch2Hook_PointStart and read by nothing
wUnusedDrillPointStartByte:: db

; [8-bit] Why the coach's drill ended, written by each ServicePractice*/NetGamePractice* EvaluateResult (0 = passed, 1 = no points won, 2 = double fault, 3 = target missed, 4+ = partial, offset by wStoryModeMainCharacterLeftHanded). The bank $15 training-court coaches dispatch their follow-up dialogue on it
wDrillLessonResult:: db

; [8-bit] One bit per point of the drill, set by RecordDrillTargetZoneHit when the ball bounced inside the target zone; CountDrillResultBitsSet and CheckDrillTargetZoneMissed read it back
wDrillTargetZoneHitBits:: db

; [8-bit] One bit per point of the drill, set by RecordGateCrossOnServe when the serve passed through the gate; counted by CountDrillResultBitsSetAlt
wDrillGateCrossBits:: db

; [8-bit] Queued drill message: index into DrillMessageTextIds_0b, $ff = say nothing. The Queue*/Set*Message helpers pick it from the point outcome and the serving player; ShowQueuedDrillMessage defaults it to $6c and shows it
wDrillMessageId:: db

; [9 bytes] Per-drill counter scratch. Each drill's hooks clear the subset it needs at MinigameStart/PointStart and step them with `ld hl, $c2ex / inc [hl]`; the successful-shot counts land in wPlayer1PointsWon/wPlayer2PointsWon at point end, and the EvaluateResult helpers compare them against 4 (the four shots of a drill)
wDrillCounters:: ds 9
	ds 8

; [2 bytes] Indexed by wCurrentServingPlayer: 0 until the serve has been judged, then +1/-1 from CheckDrillTargetZoneMissed
wDrillServeTargetResult:: dw
	ds 2

; [2 bytes] Two bits per shot of the point, one byte per side; RecordDrillPointResultBits rotates wPointWinLoseFlag into the byte DrillPointResultBitsTable selects, CountDrillShotSuccesses counts the pairs equal to 1, and bank $06's DrawScoreboardPackedPips draws them as the scoreboard pip rows
wDrillShotResultBits:: dw
	ds 1

; [8-bit] Result of judging the current drill point, 0 until judged. Each drill's JudgeShot0-3 stores the value its JudgePoint returns, and JudgePoint returns early while this is already nonzero so the first judgement of a point wins
wDrillPointJudgement:: db

; [32 bytes] One tilemap row of CGB attributes, sent to VRAM bank 1 at wBGRowBlitDest by ProcessBGBlitQueue when hBGRowBlitPending is set. Rows go out by VRAM DMA, columns by the byte loop in wBGColumnBlitAttrs
wBGRowBlitAttrs:: ds 32

; [16-bit] BG scroll-buffer camera X (tiles<<3?)
wCameraX:: dw

; [16-bit] BG scroll-buffer camera Y
wCameraY:: dw

; [8-bit] wCameraX's high byte as of the previous UpdateSceneScroll. Comparing it against the live value is how the task notices the camera crossed a tile boundary and decides whether to blit a new BG column in from the 64-wide map, and which side
wCameraTileXPrev:: db

; [8-bit] wCameraY's high byte as of the previous UpdateSceneScroll, the row counterpart of wCameraTileXPrev
wCameraTileYPrev:: db

; [16-bit] Tilemap address for the queued BG row blit
wBGRowBlitDest:: dw

; [8-bit] Tilemap column for the queued BG column blit
wBGColumnBlitX:: db

; [8-bit] Lowest camera X (in tiles) the overworld scroll clamp allows; set to 0 by InitSceneScroll
wMapScrollMinX:: db

; [8-bit] Lowest camera Y (in tiles) the overworld scroll clamp allows
wMapScrollMinY:: db

; [8-bit] Map width in tiles; the camera clamp stops at this minus $14 (the 20-tile screen width), so the X limit is the last fully visible column
wMapWidthTiles:: db

; [8-bit] Map height in tiles; the camera clamp stops at this minus $12 (18 rows)
wMapHeightTiles:: db

; [8-bit] Number of entries in the scrolling list a side-scrolling menu is showing; both RunMenuSelection and the scene viewer turn it into a page count with `dec a / srl a / srl a` (four entries a page). InitSceneScroll sets it to $25
wScrollListLength:: db

; [8-bit] Current story-cutscene scene index; indexes SceneGfxSlotTable (index*16) and drives Unused_0a_LoadAndDisplayScene / InitSceneTileAnimations
wCurrentScene:: db
	ds 1

; [8 bytes] Four scene tile-animation slots, 2 bytes each: the slot's current byte offset into the animation script at $05:$da88, then its frame countdown. The scroll task decrements each countdown and calls AdvanceSceneTileAnimation on the slot that reaches zero
wSceneTileAnimState:: ds 8

; [4 bytes] Where each of the four tile-animation slots' scripts begins, one byte per slot. AdvanceSceneTileAnimation rewinds a slot here when its script hits the $ff terminator, and $ff in this array marks a slot that was never built
wSceneTileAnimStart:: ds 4

; [8-bit] Scratch cursor AdvanceSceneTileAnimation works with: loaded from the slot's wSceneTileAnimState entry, walked forward over the script (four bytes per command), and written back at the end
wSceneTileAnimCursor:: db

; [8-bit] Write-only: the two paged-text-menu paths in bank $0a stash wCurrentScene here before stopping the tile animations, and the scene loader writes $ff, but nothing ever reads it
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

; [8-bit] Nonzero while a cable-link match is in progress. Bank $38's link character select sets it to 1 just before RunMatch, EndLinkSession clears it, and the match and menu code branch on it to pick link behaviour over single-player
wLinkSessionActive:: db

; [32 bytes] The tile plane of the same row blit, sent to VRAM bank 0
wBGRowBlitTiles:: ds 32

; [8-bit] Nonzero makes RenderInlineNumber right-align its formatted number in a five-character field by padding the pen instead of writing at the pen. Only one caller sets it, around the Text_30_310 line, and clears it again straight after
wTextNumberRightAlign:: db

; [8-bit] Argument byte of text control code $0e: a character id, which TextCmdPrintShortText and MeasureIndexedShortTextWidth turn into text id $1b + id -- the same 27-entry bias the character roster uses -- and fetch as an inline string
wTextCharNameArg:: db

; [8-bit] Glyph-row indent, stored negated. The dialogue setup writes -c here; StartGlyphStreamRow's caller negates it back, doubles it and adds it to wGlyphVramDest so the row starts that far in. Zeroed when a text window is torn down
wTextRowIndent:: db

; [8-bit] Screen shake strength, $ff when off and 1-3 otherwise (SetScreenShake clamps anything larger to 3, and registers/unregisters the UpdateScreenShake frame task on the transitions). UpdateScreenShake turns it into a mask of that many bits and ANDs it with a fresh random word to pick the two offsets
wScreenShakeMagnitude:: db
	ds 4

; [8-bit] Signed screen-shake X offset, regenerated each frame by UpdateScreenShake. UpdateSceneScroll adds it to the camera before writing hScrollX, and bank $04's ComputeSpriteScrollOffset sign-extends it so objects shake with the background
wScreenShakeOffsetX:: db

; [8-bit] Signed screen-shake Y offset, the counterpart of wScreenShakeOffsetX; it biases hScrollY the same way
wScreenShakeOffsetY:: db
	ds 2

; [8-bit] Active story save-slot index (0-2); selects which SRAM story slot CheckStorySlot / SaveStorySlotWithTimer operate on
wCurrentStorySlot:: db
	ds 2

; [8-bit] Nonzero when the EXP screen still has a bonus to add once the gauge finishes; the level-up path reads it and clears it after folding wExpBonusAmount into wExpAwardTotal
wExpBonusPending:: db

; [16-bit] The bonus EXP added to wExpAwardTotal after the first fill
wExpBonusAmount:: dw
	ds 4

; [8-bit] Minigame Level (0x00-0x03)
;
; Value is current minigame level - 1
wMinigameLevel:: db
	ds 9

; [32 bytes] One tilemap column of CGB attributes, blitted to VRAM bank 1 at wBGColumnBlitX by ProcessBGBlitQueue when hBGColumnBlitPending is set. The tile plane it pairs with is wBGColumnBlitTiles
wBGColumnBlitAttrs:: ds 32

; [16-bit] Tile-plane source address for Unused_00_QueueDeferredTilemapCopy's pending copy to $9800
wDeferredTilemapSrc:: dw

; [16-bit] Attribute-plane source address for the same copy, sent to $9800 in VRAM bank 1
wDeferredTilemapAttrSrc:: dw

; [8-bit] WRAM bank the two source pointers live in; Unused_00_VBlankDeferredTilemapCopyTask selects it before queueing either half and restores the previous bank afterwards
wDeferredTilemapWramBank:: db

; [8-bit] Length of the deferred tilemap copy in 16-byte blocks, passed to QueueVRAMCopy in c for both planes
wDeferredTilemapLength:: db

; [8-bit] Which halves of the deferred tilemap copy are still owed: low nibble the tile plane, high nibble the attribute plane. Unused_00_QueueDeferredTilemapCopy clears it, the frame task acts on whichever nibbles are set and clears it again, so the copy only happens once something else marks the planes dirty
wDeferredTilemapPending:: db

; [8-bit] High byte of current OAM shadow buffer ($c0/$c5); toggled each frame, OAM DMA source
wSpriteBufferPage:: db
	ds 8

; [8-bit] Character id (see 0xca0b values) assigned to court slot 0 (player's main character) during match setup; also used for portraits/sprites
wMatchPlayerChar:: db

; [8-bit] Character id assigned to court slot 2 (opponent's main character) during match setup ($ff = none); set via Unused_0a_SetStoryMatchOpponent
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

; [8-bit] Width in cells of the row the glyph stream is composing. FlushGlyphRow adds it to wTextRowColumn to step to the next row, and InitGlyphStreamForWindow derives it from the window width (less the two frame cells, plus wGlyphRowStartCol when a window owns the stream)
wTextRowWidth:: db

; [8-bit] Column the current text row starts at, the window's x plus its indent. InitGlyphStreamAt stores the same value into wGlyphRowStartCol, and the row-flush path passes this copy as the destination column alongside the row in c
wTextRowColumn:: db

; [8-bit] Tilemap cell column the current glyph row starts at. InitGlyphStreamForWindow seeds wGlyphPenX from it (column * $80, the sub-pixel scale) and StartGlyphStreamRow reloads both from the pen at each row break
wGlyphRowStartCol:: db

; [8-bit] Tilemap cell column already flushed out of the glyph buffer; StampGlyphTileAtPen subtracts it from the pen's column to find how far the write pointer has to advance
wGlyphFlushedCol:: db

; [8-bit] Number of glyph tiles Unused_05_UploadGlyphTileRange should send, capped at $20 -- one QueueVRAMCopy is 32 tiles
wGlyphUploadCount:: db

; [8-bit] First glyph tile of the range to upload; the source is wGlyphTileBuffer + n * TILE_SIZE and the destination $8800 + n * TILE_SIZE
wGlyphUploadFirstTile:: db

; [8-bit] Nonzero to send the range to VRAM bank 1 instead of bank 0 (Unused_05_UploadGlyphTileRange adds $2000 to the destination)
wGlyphUploadVramBank:: db

; [32 bytes] The tile plane of the same column blit, sent to VRAM bank 0
wBGColumnBlitTiles:: ds 32
	ds 32

; [16-bit] Fractional half of the ball X position; wBallX is the integer half above it. Position is 16.16 fixed point, and the three axes are one 12-byte block from here -- SetBallPosition writes each as a zero fraction plus an integer, and StepBallPhysics copies the block to wBallPrevXFrac before adding velocity
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

; [16-bit] Vertical angle of the ball's velocity, the companion of wBallHeadingAngle. UpdateBallAnglesAndSpeed writes it as AngleFromVector16(wBallVelocityHeight, wBallSpeedHorizontal), same $100-per-turn encoding
wBallPitchAngle:: dw

; [16-bit] Ball physics - horizontal heading angle of the ball's velocity (same $100-per-turn encoding as wShotAimAngle). Written by UpdateBallAnglesAndSpeed ($08:$45f1) as AngleFromVector16(de=wBallVelocityX, hl=wBallVelocityDepth); read by ApplyBallSpin ($08:$5724, MulSinCosSigned to split the topspin term back onto the X/depth axes) and by PredictBallLateralOffset ($08:$70f5).
wBallHeadingAngle:: dw

; [16-bit] Start-of-frame copy of the whole position block: StepBallPhysics copies $c400-$c40b here before integrating, so this mirrors wBallXFrac and the five words after it mirror their originals
wBallPrevXFrac:: dw

; [16-bit] Ball X at the start of the frame (integer part)
wBallPrevX:: dw

; [16-bit] Fractional half of wBallPrevDepth
wBallPrevDepthFrac:: dw

; [16-bit] Ball depth at the start of the frame (integer part). StepBallPhysics ($08:$576b) copies the whole 12-byte position block $c400-$c40b to $c410-$c41b before adding velocity, so $c410/$c414/$c418 mirror the wBallX/wBallDepth/wBallHeight 32-bit triples; only the depth integer part is ever read back. HandleBallNetCrossing ($08:$581c) XORs wBallDepth+1 with $c417 and tests bit 7 to detect the net crossing; DidBallCrossGate ($08:$6773) reads the full word.
wBallPrevDepth:: dw

; [16-bit] Fractional half of wBallPrevHeight
wBallPrevHeightFrac:: dw

; [16-bit] Ball height at the start of the frame (integer part)
wBallPrevHeight:: dw

; [16-bit] Ball physics - top/backspin coefficient (rotation about the lateral axis). Set from bc by Unused_08_SetBallSpinComponents ($08:$45de). ApplyBallSpin ($08:$56a9-$5765): while nonzero it multiplies wBallVelocityHeight by it and adds the (negated) product along wBallHeadingAngle into the X/depth velocities ($c420/$c423), and multiplies wBallSpeedHorizontal by it and adds that into the height velocity ($c426) - i.e. a Magnus rotation of the (horizontal, vertical) velocity pair. Decayed by 3/256 per frame at $08:$574a-$5765.
wBallTopspin:: dw

; [16-bit] Ball physics - sidespin/curve coefficient (rotation about the vertical axis). Set from de by Unused_08_SetBallSpinComponents ($08:$45d8). ApplyBallSpin ($08:$5613-$56a8): while nonzero it adds +k*wBallVelocityDepth to the X velocity ($c420) and -k*wBallVelocityX to the depth velocity ($c423), curving the ball laterally; then decays itself by 3/256 per frame ($08:$568d-$56a8).
wBallSideSpin:: dw

; [8-bit] Fraction byte of wBallVelocityX. The three velocity components are 24-bit fixed point (8.16), each written as a zero fraction plus a 16-bit integer by SetBallVelocityPolar
wBallVelocityXFrac:: db

; [16-bit] Ball X velocity, integer part (24-bit fixed-point triple $c420-$c422, fraction byte at $c420); decayed by ApplyBallAirDrag
wBallVelocityX:: dw

; [8-bit] Fraction byte of wBallVelocityDepth
wBallVelocityDepthFrac:: db

; [16-bit] Ball depth velocity, integer part (triple $c423-$c425); curved by ApplyBallSpin
wBallVelocityDepth:: dw

; [8-bit] Fraction byte of wBallVelocityHeight
wBallVelocityHeightFrac:: db

; [16-bit] Ball height (vertical) velocity, integer part (triple $c426-$c428)
wBallVelocityHeight:: dw

; [8-bit] Fraction byte of wBallSpeedHorizontal
wBallSpeedHorizontalFrac:: db

; [16-bit] Magnitude of the ball's horizontal (X,depth) velocity, integer part of the 24-bit triple $c429-$c42b (fraction byte at $c429). Written by UpdateBallAnglesAndSpeed ($08:$4606) as VectorLengthFromAngle(bc=wBallHeadingAngle, hl=wBallVelocityDepth, de=wBallVelocityX); read by ApplyBallSpin ($08:$56ed) as the horizontal-speed factor of the topspin lift term.
wBallSpeedHorizontal:: dw

; [16-bit] The ball's full three-dimensional speed: VectorLengthFromAngle of wBallVelocityHeight against wBallSpeedHorizontal, recomputed whenever the velocity is rebuilt. ApplyBallAirDrag reads only its high byte, takes the magnitude and uses the top nibble as the drag-table index
wBallSpeed3D:: dw
	ds 2

; [16-bit] World X the shot is aimed at, in the same units as wBallX. Written by ComputeShotTrajectory ($07:$5746) from ComputeShotTargetX, copied on to wBallTargetX at $07:$5863, and drawn as a world-space marker sprite at $08:$54f3 (ProjectWorldToScreen + QueueSprite). Cleared with $c432 by ResetBallState ($08:$5149).
wShotAimTargetX:: dw

; [16-bit] World depth the shot is aimed at (companion to wShotAimTargetX; net at 0, sign already corrected for the hitter's court side at $07:$5725). Written by ComputeShotTrajectory ($07:$572b), copied on to wBallTargetDepth at $07:$5863, read as the depth of the aim marker sprite at $08:$54ed.
wShotAimTargetDepth:: dw

; [16-bit] wShotAimTargetX - wBallX, the lateral leg of the ball->target vector. Written by ComputeShotTrajectory ($07:$5758). Read by every court bank's SetBallTargetByPrediction ($20/$21/$22/$23/$2a/$2b/$2c:$40a3, $24:$40af, $29:$40a3) and by the trajectory-length path at $20:$416a, where it is passed as the hl argument of VectorLengthFromAngle together with wShotAimDeltaDepth in de.
wShotAimDeltaX:: dw

; [16-bit] wShotAimTargetDepth - wBallDepth, the depth leg of the ball->target vector. Written by ComputeShotTrajectory ($07:$573d) and immediately fed to AngleFromVector16 at $07:$5764 (with wShotAimDeltaX in de) to produce wShotAimAngle; read again as the de argument of VectorLengthFromAngle at $20:$4164 and in the other court banks.
wShotAimDeltaDepth:: dw
	ds 2

; [16-bit] Aim angle of the shot being launched (high byte = angle, $100 per turn; low byte = fraction, top nibble used by MulSinCos); projected from ball position into wBallTargetX/Depth
wShotAimAngle:: dw
	ds 2

; [16-bit] Base lateral aim spread used to place a rally shot's target: $0220 in singles, $0320 in doubles ($08:$4104-$4111, at match init). ComputeAimBaseOffset ($07:$56b7) returns (this + |wCharPosDepth|/8) scaled by the character's aim stat $df69, which ComputeShotTargetX then adds to / subtracts from wBallX before clamping.
wAimSpreadBase:: dw

; [16-bit] Match camera current X (projected space). SnapCameraTo ($08:$61ac) sets it and the target together; UpdateMatchCamera eases it toward wMatchCameraTargetX ($08:$61f4-$625c) and then derives wCameraOffsetX from it at $08:$6281-$62c3.
wMatchCameraX:: dw

; [16-bit] Match camera current Y (projected space); eased toward wMatchCameraTargetY and shifted into wCameraOffsetY at $08:$62c4.
wMatchCameraY:: dw

; [16-bit] Match camera target X. Written by SetCameraTarget ($08:$61cb) and SnapCameraTo ($08:$61b2, plus the bank $0d copy SnapCameraTo_0d $4942), overwritten every frame from wBallGroundProjX while wCameraFollowBall is set; UpdateMatchCamera steps wMatchCameraX toward it with a fixed $0040 step (VectorFromLengthAndAngleRaw at $08:$6222).
wMatchCameraTargetX:: dw

; [16-bit] Match camera target Y (companion to wMatchCameraTargetX; same writers and the same snap-on-overshoot logic at $08:$6263-$6280).
wMatchCameraTargetY:: dw

; [16-bit] Ball X minus the current character's X (wBallX - wCharPosX+1), signed. Written by UpdateCharBallGeometry ($08:$6e6a-$6e75) for whichever character bank is mapped; read by AiSteerTowardBall ($08:$7944) as the de leg of AngleFromVectorCoarse and by the swing/contact range checks at $08:$6ef2/$6fed/$704e.
wBallRelCharX:: dw

; [16-bit] Ball depth minus the current character's depth, signed (same struct as wBallRelCharX). Read by CheckBallContactWindow ($08:$6fa7), CheckBallInSwingRange ($08:$702a), Unused_08_ComputeBallEtaToChar ($08:$70ca-$70e7, divided by wBallVelocityDepth to get frames-to-arrival), PredictBallLateralOffset ($08:$70fb) and the AI at $08:$7b99.
wBallRelCharDepth:: dw

; [16-bit] Ball height minus the current character's height, signed (third word of the same struct). Read by the reach/height gates at $08:$6f12 and $08:$700d, each comparing |value| against the character's reach field $df70.
wBallRelCharHeight:: dw
	ds 2

; [16-bit] Projected ball target/landing X (same world units as wBallX)
wBallTargetX:: dw

; [16-bit] Projected ball target/landing depth (companion to wBallTargetX; net at 0)
wBallTargetDepth:: dw

; [16-bit] The ball's X velocity as the shot was struck, saved by ExecuteShot
wShotRecoilVelocityX:: dw

; [16-bit] The same for depth velocity. ApplyShotRecoil scales it by the ShotRecoilTable_07 factor for the shot type and pushes the striking character back along it
wShotRecoilVelocityDepth:: dw

; [16-bit] Shot speed as FinalizeShotSpeed leaves it, after momentum and the character-flag penalty and clamped up to $0100. Write-only, like the three term traces above it
wShotSpeedFinal:: dw

; [16-bit] The incoming ball's contribution to the shot speed, as AddBallSpeedEighth computed it (signed, then made positive). Write-only
wShotSpeedBallTerm:: dw

; [16-bit] The striker's own depth velocity contribution, halved and signed by which end of the court the character is on (AddPlayerMomentumToShot). Write-only
wShotSpeedMomentumTerm:: dw

; [16-bit] The charge bonus AddChargeSpeedBonusHalf added, scaled $40 or $20 depending on sign. Write-only; the four traces together are the shot-speed sum broken into its terms, and nothing in the ROM reads any of them back
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

; [16-bit] Projected screen-space X of the ball's ground (shadow) position, from ProjectWorldToScreen(wBallX, wBallDepth) in BuildBallShadowSlot ($08:$5267). UpdateMatchCamera ($08:$61e2) copies $c46c-$c46f into the camera target $c444-$c447 whenever wCameraFollowBall is set.
wBallGroundProjX:: dw

; [16-bit] Projected screen-space Y of the ball's ground position (companion to wBallGroundProjX, from the bc return of ProjectWorldToScreen at $08:$526d).
wBallGroundProjY:: dw

; [16-bit] Negated wBallHeight, the drop the trajectory solver has to cover. ComputeShotTrajectory writes it just before it copies the aim target into wBallTargetX
wShotSolverNegHeight:: dw

; [8-bit] Aim row (0-$1f) the shot banks derive from the ball's angle to index their per-aim target tables. Written by every bank's SetBallTargetFromAim and read by nothing -- the value is used from a, so this is a leftover store
wShotAimRow:: db
	ds 1

; [16-bit] The magnitude SetBallVelocityPolar was called with, saved before it is resolved into X/depth components through MulSinCosSigned. Write-only
wBallVelocityPolarLength:: dw

; [16-bit] First word of the shot-table entry SetBallTargetByPrediction_* is acting on, stored before the aim delta is applied. Every shot bank writes it and nothing reads it
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

; [16-bit] In-bounds lateral limit, stored as the two's-complement negative of the |X| bound: $fe50 (= -$1b0) in singles, $fdc0 (= -$240) in doubles ($08:$40e8, $08:$4300-$430d, $0d:$4690). CheckBallOutOfBounds ($08:$463c) adds it to |wBallX| and treats the carry as 'out'; ClampShotTargetX ($07:$56e3) clamps the aim target to (-value - $20); ComputeShotTrajectory ($07:$57f4) uses the same figure to shorten wShotDistMax when the aim line would leave the court sideways.
wCourtLimitX:: dw

; [16-bit] In-bounds depth limit, also stored negated: $fb20 (= -$4e0, the baseline) normally, tightened to $fd60 (= -$2a0, the service line) while a serve is in flight ($08:$4cff) and restored at $08:$40ee / $0d:$4bd2. CheckBallOutOfBounds ($08:$4657) adds it to |wBallDepth| and sets bit 1 of the out-of-bounds mask on carry.
wCourtLimitDepth:: dw

; [16-bit] Height of the net in ball-height units ($0060 in a normal match, $08:$40f7; $0000 for the solo minigames that have no net, $0d:$4b0b). HandleBallNetCrossing ($08:$5830-$5853) adds it to wBallHeight at the moment the ball crosses depth 0 and, if the sum is still non-negative (heights are negative-up), plays sound $5a, starts the bounce effect, sets wBallHasBouncedFlag and negates the depth position and velocity - i.e. the ball clipped the net.
wNetHeight:: dw

; [16-bit] Shot solver - minimum distance along the aim line, i.e. the distance from the ball to where the aim line crosses depth $0140 past the net. ComputeShotTrajectory ($07:$5783-$57a1) computes |wBallDepth| + $0140, divides by sin(wShotAimAngle) (DivBySin, $07:$5787), takes the absolute value and stores it here; $c48e caches value>>6. Every court bank's ApplyBallTrajectory ($20:$4108, $4135, $419c, $41cf and the same offsets in $21-$24, $29-$2c) loads it into de and passes it to BallTrajEntryPtr6/4 as the starting row of the trajectory table.
wShotDistMin:: dw

; [16-bit] Shot solver - maximum distance along the aim line: distance to where the aim line crosses depth $0480 (just inside the baseline at $4e0), computed the same way at $07:$57b8-$57d6, then shortened at $07:$582c-$5850 to the distance at which the aim line would cross the sideline (wCourtLimitX + $0020) if that comes first. $c48f caches value>>6. Read by the court banks at $20:$4175/$4183 (and the same offsets elsewhere) to clamp the actual ball->target length before selecting a trajectory row.
wShotDistMax:: dw

; [8-bit] wShotDistMin >> 6 - the first row index of the per-court ball-trajectory table to consider. Written at $07:$5799 as the high byte of (wShotDistMin << 2). Loaded into d as the loop counter by every court bank's SeekBallTrajEntry6/4 ($20:$401f and $20:$403e, mirrored in $21-$24, $29-$2c).
wShotTrajRowMin:: db

; [8-bit] wShotDistMax >> 6 - the last row index the trajectory search may reach. Written at $07:$57ce and re-written at $07:$5848 when wShotDistMax is shortened by the sideline clamp. Loaded into e by SeekBallTrajEntry6/4, which stops as soon as d (wShotTrajRowMin, incremented per row) reaches it.
wShotTrajRowMax:: db

; [8-bit] Which shot buttons produced the swing, packed as wCharShotButton1 in the high nibble and wCharShotButton2 in the low nibble at the moment of contact. The bank $0d minigame shot tables match a required combination against it
wLastShotButtons:: db

; [8-bit] Winning-shot type for the point just won: 0=none, 1=service ace, 2=return ace, 3=smash ace, 4=lob winner, 5=drop-shot winner. Reset to 0 in the per-point state clear ($08:$4cd5); set by the Record*Stat functions ($08:$5c5f+) which also credit the matching wCharacterN stat. The on-court winner banner is ShowCourtBanner(value+$17) at $08:$4e75, i.e. banner ids 24-28 (SERVICE/RETURN/SMASH ACE, LOB, DROP SHOT) - confirmed in-game.
wPointWinnerShotType:: db

; [8-bit] Companion abort flag to wMatchAbortFlag ($ff set by every quit-menu action): makes StepMatchFrames return immediately and suppresses result jingles
wMatchFramesAbort:: db

; [8-bit] hLinkState as it stood when RunMatchPlayLoop returned, taken just before EndLinkSession tears the session down. Write-only
wMatchEndLinkState:: db

; [8-bit] Scoreboard layout/caption style code, 0-7. Chosen by SelectScoreboardLayout ($08:$454b) from wOnCourtCharCount (singles/doubles) or, for minigames ($c8f5 == 2), from $c7ba/$c7bb as 3/4/7. Used as an rst00 jumptable index by DrawScoreboardCaption ($06:$477a) and DrawScoreboard ($06:$49c0), as a table index at $06:$49ae and $06:$507b, and checked against 3 by the bank $09 serve-indicator spawner ($09:$4133, $09:$425a).
wScoreboardLayout:: db
	ds 11

; [8-bit] Shot-type code of the shot in flight (rst00 jumptable in ExecuteShot; $09 smash, $0a lob, $0b drop - checked by RecordSmashAceStat/RecordLobWinnerStat/RecordDropShotWinnerStat)
wCurrentShotType:: db

; [8-bit] Recoil kind for the shot in flight: ApplyShotTypePresets stores it from the ShotTypePresets_07 record and ApplyShotRecoil indexes ShotRecoilVarPtrs_07 with it
wShotRecoilVariant:: db

; [8-bit] Charge level of the shot being executed, 0-$3f. Snapshotted from the hitter's $df4b and clamped to $3f in ExecuteShot ($07:$5413-$541c). Scales the shot speed in AddChargeSpeedBonus / AddChargeSpeedBonusHalf ($07:$5345, $535c, both offsetting by $ffe0 first) and in WeakenShotByCharge / BoostShotByCharge ($07:$54de, $54ed); $08:$53f9 compares it against $3f (fully charged) to pick the special hit flash instead of the normal spark.
wShotChargeLevel:: db

; [8-bit] Copy of the striking character's wCharQuickSwing taken by ExecuteShot, so the shot keeps the value the swing was started with
wShotWasQuickSwing:: db

; [8-bit] The striker's wCharAimOffset at the moment of contact, snapshotted by ExecuteShot alongside wLastShotCharIndex and wLastShotServeRole. Write-only
wLastShotAimOffset:: db

; [8-bit] Nonzero when the shot just struck counts as a special/power hit. Cleared at the top of ExecuteShot ($07:$53e6); set to 1 at $07:$59f8 when the ball is struck above height $0140, and set from the 32-entry toss-height table at $07:$5a1c on the serve paths. Read at $08:$53f3, where it forces the special-shot flash (wSpecialHitTimer) instead of the normal swing spark, and at $08:$42d4, where a nonzero value on the first shot of the rally shows court banner $0e.
wSpecialShotFlag:: db

; [8-bit] Set to 1 by each ExecuteShotPower* variant and cleared by ExecuteShot at the start of every swing, so it marks the power version of topspin/slice/flat. Write-only
wLastShotWasPowerShot:: db

; [8-bit] 0/1 parity flag: when 1, the shot's lateral aim offsets are negated. Written by ExecuteShot ($07:$540d) as the low bit of a count of four conditions (hitter state $df15 == 6, == $0a, $df94 nonzero, wRallyLength == 0). Read by LoadShotPlacementEntry ($07:$52b5) to negate the placement entry's angle offset before storing it at $c41e, and by every court bank's SetBallVelocityFromEntry6 ($20:$406a, $2a:$40c7 and the same offsets in the other court banks) to negate the table entry's angle delta before adding it to wShotAimAngle.
wShotAimMirror:: db

; [8-bit] Frames left of the ball-bounce dust effect (starts at $14)
wBounceEffectTimer:: db

; [8-bit] Frames left of the normal swing-hit spark (starts at $10)
wHitSparkTimer:: db

; [8-bit] Frames left of the special-shot hit flash (starts at $10; drives the bank $28 screen effect)
wSpecialHitTimer:: db

; [8-bit] Frames left of the 'ball hit a character' effect; started at $28 by StartBallTouchCharEffect ($08:$547c), ticked and used as an animation-table index by DrawBallTouchCharEffect ($08:$5482-$54bb).
wBallTouchCharTimer:: db

; [8-bit] Court surface horizontal bounce damping (8-bit fraction, e.g. $cd = 0.80 on court 0). Loaded per court from the 4-byte-per-court table at $08:$5dc4 ($08:$5e3e). ApplyCourtBounceDamping ($08:$46b3, $46c5) multiplies both horizontal velocity triples ($c420 = X, $c423 = depth) by it.
wCourtSurfaceFriction:: db

; [8-bit] Court surface vertical restitution (8-bit fraction), loaded from the same per-court record at $08:$5e42. ApplyCourtBounceDamping ($08:$46d7) multiplies the height velocity triple $c426 by it.
wCourtSurfaceBounce:: db

; [8-bit] Set to 1 at $08:$6f30 when the ball reaches a character's body (the same site sets bit 2 of $df50 and forces the character to state 0). HandleBallTouchCharEvent ($08:$43d3) consumes it once per frame: clears it, plays sound $77, starts the effect and calls ApplyBallTouchOutcome. Cleared by ResetPointState ($08:$4cc6).
wBallTouchCharFlag:: db

; [8-bit] Character index (0-3) of the character the ball touched, stored from wCharIndex alongside wBallTouchCharFlag at $08:$6f36. DrawBallTouchCharEffect ($08:$5487) maps it through CharIndexToWramBank to read that character's screen position; $08:$5dbc turns its low bit into the +1/-1 side sign for the point outcome.
wBallTouchCharIndex:: db

; [8-bit] Which quadrant of the court the ball is currently over: bit 1 = sign of wBallDepth (which side of the net), bit 0 = sign of wBallX (which half laterally). Rebuilt every frame by StepBallPhysics ($08:$5798-$57a9) by rotating the two sign bits into b; forced to $02 by the bank $0d wall-practice setup ($0d:$480f).
wBallCourtQuadrant:: db

; [8-bit] CheckBallOutOfBounds' verdict bits for the frame - which court bound the ball passed. Write-only; the caller uses the value it returns in a
wBallOutOfBoundsBits:: db

; [8-bit] Number of bounces since the last time the ball was struck, saturating at $0a. Zeroed by HandleBallHitEvent ($08:$42c5) and by ResetPointState ($08:$4cbd); incremented by HandleBallBounceEvent ($08:$4360-$4368). Read as 'first bounce' (== 1) by EvaluateBounceOutcome ($08:$4389), the fault check ($08:$4342), the drill graders in bank $0b ($41e6, $5e55, $6d75, $721f) and $0d:$47d0.
wBallBounceCount:: db

; [8-bit] Per-frame bounce event code, cleared at the top of StepBallPhysics ($08:$5768): 1 = the ball reached the ground this frame ($08:$57e8, set right after GetBallHeightSign), 2 = the ball bounced off a court fence/wall ($08:$597e and $08:$59b4, inside BounceBallOffCourtFences after ApplyCourtBounceDamping). HandleBallBounceEvent ($08:$4352) returns immediately when it is 0.
wBallBounceEvent:: db

; [8-bit] Set to 1 for the single frame in which the ball crosses the net plane; cleared at the top of HandleBallNetCrossing ($08:$5815) and set at $08:$5827 once the wBallDepth sign flip is detected. Read by TickRallyTimers ($08:$4242), by AiTrackBallPhase ($08:$7d77) and by the minigame target checks CheckBallHitsMinigameTarget ($0a:$672d) and CheckBallHitsMinigameTargetAlt ($0a:$6df4).
wBallCrossedNetFlag:: db

; [8-bit] Frames the ball has spent past the net this point: TickRallyTimers increments it while wBallCrossedNetFlag is set and stops at $64, and ResetPointState clears it alongside wRallyLength. Nothing reads it apart from its own cap test
wRallyNetFrames:: db

; [8-bit] Rally Length; number of times the ball was hit in the span of a point
wRallyLength:: db

; [8-bit] Set to 1 by ExecuteShot ($07:$53b8), which also refuses to run twice while it is set ($07:$53b0-$53b5). HandleBallHitEvent ($08:$427a) consumes it once per frame: increments wRallyLength, clears it, clears wBallHasBouncedFlag and wLandingMarkerActive, then starts the landing marker and hit effect and pokes every character's state. Cleared by ResetPointState ($08:$4cc3).
wBallHitEvent:: db

; [8-bit] Character index (0-3) of the character who hit the ball, snapshotted from wCharIndex by ExecuteShot ($07:$53be). Used at $08:$5cb2 to select the wCharacterN stat block (index * 8) when crediting an ace/winner, at $08:$5da9 to turn the low bit into the point-outcome side sign, and by the bank $0d minigames ($4e80, $5292, $56f0) to test whether the player or the machine hit.
wLastShotCharIndex:: db

; [8-bit] wCharServeRole of the character who hit the ball, snapshotted by ExecuteShot ($07:$53c4). Read once, at $08:$4337 in DetectServeAceOutcome: on the second hit of a point, role 1 (the receiver) with the ball still unbounced gives POINTOUTCOME_SERVE_VOLLEYED, and any other role gives POINTOUTCOME_WRONG_RECEIVER
wLastShotServeRole:: db

; [8-bit] Nonzero draws the ball sprite slot
wBallSpriteEnabled:: db

; [8-bit] Nonzero draws the ball ground-shadow slot
wBallShadowEnabled:: db

; [8-bit] Nonzero draws the ball trail afterimages from the position history ring
wBallTrailEnabled:: db

; [8-bit] Trail palette index into BallTrailPalettes; nonzero also extends the trail from 2 to 5 ghosts
wBallTrailColor:: db

; [8-bit] wBallCourtQuadrant captured at the moment the shot was struck ($07:$53df-$53e2). EvaluateBounceOutcome XORs it against the live wBallCourtQuadrant and tests bit 1 ($08:$4394-$439b, did the ball reach the other side of the net) and bit 0 ($08:$43b4-$43bb, did it change lateral half - the serve's diagonal-box rule). The bank $0d wall-practice bounce flips its bit 1 manually at $0d:$4b7c.
wBallQuadrantAtHit:: db

; [8-bit] Set to 1 when the ball bounces on the court ($08:$5848, in the net-crossing/ground-contact path that also fires StartBounceEffect); cleared by HandleBallHitEvent ($08:$428c) and ResetPointState ($08:$4cc9). Read by EvaluateBounceOutcome ($08:$43c3), by TickRallyTimers ($08:$4262) and by AiTrackBallPhase ($08:$7d73).
wBallHasBouncedFlag:: db

; [8-bit] Nonzero freezes the per-frame match simulation: UpdateMatchFrame skips ClearSpriteSlots/UpdateMatchCamera/UpdateAllChars/ball events/UpdateBallVisuals/timers and the mode hook. Set $ff during match setup and while the pause menu is open, cleared before the play loop
wMatchSimFrozen:: db

; [8-bit] Nonzero freezes actor drawing: UpdateMatchFrame skips DrawActorsByDepth. Set $ff alongside wMatchSimFrozen while the pause menu is open
wMatchDrawFrozen:: db

; [8-bit] Nonzero blocks the pause menu: HandlePauseMenu ($08:$449c) returns immediately when it is set. Set to 1 during match setup ($08:$40d2), for the whole changeover sequence (RunChangeoverSequence $08:$5f8e) and while the characters walk off court (WalkCharsOffCourt $08:$6012); cleared by ResetPointState ($08:$4ce3) and by PlayMinigameCountdown ($0d:$48d5).
wPauseDisabled:: db

; [8-bit] $ff = abort the match (bit 7 breaks the point/game/set/match loops); set by every pause/quit-menu action, cleared per point by ResetPointState
wMatchAbortFlag:: db

; [8-bit] Nonzero draws edge arrows for off-screen characters (set during the rally)
wOffscreenArrowsEnabled:: db

; [8-bit] Set to 1 by PlayMinigamePoint as the rally starts and read by nothing
wUnusedMinigamePointFlag:: db

; [8-bit] Set to 1 by ApplyFallbackBallTrajectory_24 ($24:$57ff), the shared handler the court banks jump to when the requested trajectory row is out of range; cleared at the top of ExecuteShot ($07:$53ec). Read by StartLandingMarker ($08:$52e1), which then draws the lob landing marker, and by AiIsIncomingLobShot ($08:$79e7), which treats it like SHOTTYPE_LOB.
wFallbackTrajectoryFlag:: db

; [8-bit] Nonzero when the player chose Retry / Select New Level / Quit in the quit menu (discriminated by wMatchRetryRequest/wMatchSelectNewLevelRequest); outer mode loops branch on it
wMatchExitRequest:: db

; [8-bit] Set by InitViewFlipPreference when the court view is fixed rather than the player's saved preference (link matches, game mode $08/$09, and any minigame). The pause menus read it to decide whether the view row can be changed
wCourtViewLocked:: db

; [8-bit] Nonzero makes UpdateMatchCamera ($08:$61dc) overwrite the camera target from wBallGroundProjX/Y each frame instead of holding the target set by SetCameraTarget. Cleared by SetCameraTarget and SnapCameraTo ($08:$61c5, $61d8, $0d:$4955); set to 1 when the rally starts ($08:$425f), by the bank $0d wall bounce ($0d:$4b72), and explicitly cleared by KeepMinigameCameraFixed ($0d:$47be).
wCameraFollowBall:: db

; [8-bit] Set in singles only; enables the wide flickering ground shadow under grounded characters
wStandingShadowsEnabled:: db

; [8-bit] Nonzero when the court view is mirrored so the human player stays on the near side. Recomputed by UpdateViewFlipState ($08:$4c33-$4c4a) as (wCourtViewOption != 0) && (bit 1 of $c8cf). FlipAllCharPositions ($08:$4c4e) skips flipping every character's court-position code when it is 0, and RefreshCourtScoreboard ($08:$5e99) picks the mirrored scoreboard column layout when it is set.
wCourtViewFlipped:: db

; [8-bit] Nonzero makes RunChangeoverSequence walk the characters to their new ends without showing the CHANGE ENDS banner first. Set at the start of a set, when a set completes and when a tiebreak begins - the boundaries where the players swap ends but the mid-set announcement would be wrong - and cleared by the sequence itself
wChangeoverSkipBanner:: db

; [8-bit] Set to 1 at $08:$4c2f when bit 1 of the game-count state $c8cf toggles, i.e. the players must change ends. RunChangeoverSequence ($08:$5f97) shows court banner $00 and walks the characters to their new ends when it is set, then clears it with $c4cc at $08:$5fb8; also cleared during match setup ($08:$4177).
wChangeEndsPending:: db

; [8-bit] Nonzero when wCourtViewFlipped changed on the last UpdateViewFlipState pass - computed there as old minus new ($08:$4c44-$4c4a). RefreshCourtAfterEndChange ($08:$5f43) returns immediately when it is 0, and ReinitPointAfterPause ($08:$44c5) uses it to decide whether the court needs redrawing after the pause menu.
wCourtViewFlipChanged:: db

; [8-bit] wOnCourtCharCount - 1 (0x00-0x03); jumptable index for the match engine's per-character-count dispatches
wOnCourtCharCountMinus1:: db

; [8-bit] Set when the point ended as a service ace (point outcome 6 with rally length 1); credited to the winner's ServiceAces stat
wServiceAceFlag:: db

; [8-bit] Set when the point ended as a return ace (point outcome 6 with rally length 2); credited to the winner's ReturnAces stat
wReturnAceFlag:: db

; [8-bit] WRAM bank (4-7) of the character currently serving, stored by IdentifyServingPlayer ($08:$4c83) from FindServerCharBank. Read once, at $08:$44dc, where ReinitPointAfterPause maps that bank in to put the server back into the serve state.
wServingCharWramBank:: db

; [8-bit] Current Serving Player (0x00-0x03)
wCurrentServingPlayer:: db

; [8-bit] wCharCourtPos of the serving character, stored by IdentifyServingPlayer ($08:$4c8f). Bit 1 (which side of the net the server is on) selects the serve camera target in GetServeCameraTarget ($08:$6199) and the ace-banner offset at $08:$42df; bank $09 uses the whole value as the serve-indicator object template index ($09:$4248, $4261, $4310) and mixes it with wServeFaultFlag at $09:$6c54.
wServingCharCourtPos:: db

; [8-bit] Match-point indicator: $01/$ff = P1/P2 side wins the match by taking the next point, 0 = none (EvaluatePointSituation simulates the next point)
wMatchPointFlag:: db

; [8-bit] Set-point indicator ($01/$ff/0, same scheme as wMatchPointFlag)
wSetPointFlag:: db

; [8-bit] Game-point indicator ($01/$ff/0, same scheme as wMatchPointFlag)
wGamePointFlag:: db

; [8-bit] 0 while the rally runs; point-end cause code once the point resolves
wPointOutcome:: db

; [8-bit] Side/sign code stored alongside wPointOutcome when a point-ending event fires ($01/$ff); negated through the court-side parity bits to decide which side won the point
wPointOutcomeSide:: db

; [8-bit] Nonzero while the lob landing marker is shown. Set to 1 with sound $6d by StartLandingMarker ($08:$533c) right after it fills wLandingMarkerX/Y; DrawLandingMarker ($08:$5342) returns when it is 0. Cleared by HandleBallHitEvent ($08:$428f), HandleBallBounceEvent ($08:$436a), EndPointBallEffects ($08:$4fad), ResetPointState ($08:$4cd2) and $0d:$4bc9; the AI reads it at $08:$7b7b as 'a lob is coming'.
wLandingMarkerActive:: db

; [8-bit] wMatchTypeNumberOfSets >> 1, stored during match setup ($08:$4120). ShowMatchRulesPages ($06:$4137) combines it as (this * 2 + wRulesGamesIndex) to form wRulesPageListIndex, selecting one of the six MatchRulesPageLists records.
wRulesSetsIndex:: db

; [8-bit] Bit 2 of wMatchTypeNumberOfGames, stored during match setup ($08:$412a); the low half of the wRulesPageListIndex computation at $06:$4133.
wRulesGamesIndex:: db

; [8-bit] The saved 'camera / court view' option. Loaded from story save-slot flag B at $08:$4526 (forced to 0 for minigames and game mode 8 at $08:$4530), edited by MatchPauseMenu_CameraSelect ($06:$441e/$4433, which writes it back with SetStorySlotFlagB). UpdateViewFlipState ($08:$4c35) only mirrors the court when it is nonzero.
wCourtViewOption:: db

; [8-bit] Set to 1 by MatchQuitMenu_Retry; reruns the current drill/minigame (RunTrainingDrillByID)
wMatchRetryRequest:: db

; [8-bit] Set to 1 by MatchQuitMenu_SelectNewLevel; returns to the level-select screen after the match teardown
wMatchSelectNewLevelRequest:: db

; [8-bit] Pause/quit menu selection (rst00 jumptable index: check rules / review controls / change options / save-quit); $ff = cancelled
wMatchMenuSelection:: db

; [8-bit] Item id of the first entry of the story option submenu about to be drawn ($04 court view, $06 message speed, $09 music, $0b save; $0e for the story pause root at $06:$6fec). RunStoryTwoOptionMenu ($06:$70cc) and RunStoryThreeOptionMenu ($06:$717a) draw this id, +1 and +2, add wMatchMenuSelection to it to pick the caption text ($0162 + n) and to load the highlighted item graphics.
wStoryMenuFirstItem:: db

; [8-bit] Nonzero means the shadow tilemap needs flushing to VRAM. Unused_06_FlushTilemapToVramIfDirty ($06:$45f3) returns when it is 0 and FlushTilemapToVram clears it at $06:$45f9; set to 1 by the debug stats editor after redrawing ($06:$6c0f).
wTilemapDirtyFlag:: db

; [16-bit] Packed base position of the match scoreboard layout (low byte $c4e3, high byte $c4e4), added to the fixed offsets of each element. Set by PrepareScoreboardGfx ($06:$4917/$491c, to $0002 or $0202 depending on wScoreboardLayout) and to 5 in the low byte by ShowMatchScoreboardScreen ($06:$48bb). Read as a coordinate pair by all four ScoreboardCaption_* handlers ($06:$478e, $47a1, $47b4, $47df), by DrawScoreboard ($06:$49a8), by the pip drawers ($06:$4a13, $4a3d, $4a57) and, as h/l shifted left 3, by the sprite helpers DrawScoreboardSprites ($06:$506a) and DrawScoreboardModeTitle ($06:$69ca).
wScoreboardOrigin:: dw

; [8-bit] Which rules/description page list to display. Set by ShowMatchRulesPages ($06:$413c, from wRulesSetsIndex/wRulesGamesIndex), ShowTrainingRulesPages ($06:$4180, from wCurrentMinigameStoryMatch+1) and the minigame variant at $06:$422a (drill id * 3 + wMinigameLevel). Each of those then indexes a 4-byte-per-record page list (MatchRulesPageLists at $06:$4165 and its siblings) with it.
wRulesPageListIndex:: db

; [8-bit] Which menu_def record the pause menu system should run. Set before every RunMatchMenu / RunMatchQuitMenu / RunStoryMenu call in bank $06 ($06:$404c, $40c7, $43fd, $4426, $4443, $4470, $447b, $6fc9, $6ff1). GetMatchMenuItemCount ($06:$4820) and GetStoryMenuItemCount ($06:$6d8a) both index their 8-byte menu_def tables with it.
wPauseMenuId:: db

; [8-bit] Number of items in the menu currently being run. RunMatchMenu ($06:$46ea) and RunStoryMenu ($06:$6d13) store the result of Get*MenuItemCount here; it is the wrap modulus passed to MoveCursorHorizontal ($06:$4724, $6d3e), the loop counter in DrawMatchMenuItems / DrawStoryMenuItems ($06:$483d, $6da7) and the index into the per-count item-position tables ($06:$482f, $4873, $6d99, $6ddd).
wPauseMenuItemCount:: db

; [16-bit] Text id of the first body page of the rules sequence being shown ($2c62 for match rules at $06:$414f, $2c6a for training rules at $06:$4193, or a per-minigame value loaded from a table at $06:$424a). ShowRulesPageSequence adds the current page number to it at $06:$4342 to get the page's text id.
wRulesFirstPageTextId:: dw

; [16-bit] Text id of the caption/title shown above the rules pages, computed as a fixed base plus wRulesPageListIndex ($2c25 + n at $06:$4146, $2c2b + n at $06:$418a, $2c47 + n at $06:$4234). Read at $06:$432d and passed to DrawMenuCaptionWindow.
wRulesTitleTextId:: dw

; [16-bit] The saved best score for the current minigame, copied out of the record ReadMinigameRecord returns in WRAM bank 7 at $de00 ($0d:$4107). $06:$50cf draws it instead of wMinigamesTargetScore when $c7bc marks a high-score attempt, and $0d:$41fc compares the current score against it.
wMinigameHighScore:: dw

; [8-bit] Flag byte for the built-in debug test match; set to $fe by Unused_07_RunDebugTestMatch ($07:$5e9a). Bit 1 makes the character setup call OverrideCharStatsForDebug ($07:$5c35); bit 0 makes the frame-stepping loop at $08:$4447 ignore the input wait.
wDebugMatchFlags:: db
	ds 17

; [160 bytes] The second shadow OAM page: hOAMDMARoutine sources page $c0 or $c5 as wSpriteBufferPage toggles each frame, so this is the buffer being built while wShadowOAM is being copied. Like wShadowOAM it is only ever reached through pointers (the sprite queue writes via wSpriteBufferPage as the high byte), never by a direct [$c5xx] operand, which is why it went unnamed until the 2026-09-11 RAM-poison run showed it written in every flow
wShadowOAM2:: ds 160
	ds 96

; Dialogue string buffer (160 bytes); text-bank fetch routines copy string N here when called with a = 0. Also the save engine's staging area: MirrorSaveHeaderToBank1 ($03:$48a1) copies each 512-byte SRAM header region through $c600-$c7ff on its way to SRAM bank 1 (ld c, $20 = 32 blocks of 16), running over this buffer, wTilemapRowStage, wInlineTextBuffer and the debug-menu variables up to $c7ff; the directory entries its last copy leaves behind are what a RAM poison run found at $c6e0-$c75f
wTextBuffer:: ds 160
	export_size wTextBuffer

; [32 bytes] One tilemap row staged by RestoreShadowTilemapRow: it reads the row out of the map buffer, wrapping at the map edge, and writes it back into the shadow tilemap from here
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

; [8-bit] Number of story locations GetStoryLocationCount reported, the upper bound RunDebugWarpMenu's location stepper wraps at
wDebugWarpLocationCount:: db

; [8-bit] Which field the debug warp menu's cursor is on: 0 = location number, 1 = entry point (toggled with xor 1, row drawn at *2+2). The location number itself lives in $c700 during this menu. The colour editor formats its G digits over the same three bytes
wDebugWarpCursorRow:: db

; [8-bit] Entry point the debug warp menu is editing, written to wStoryModeEntryPoint when A confirms the warp. Note that $c700-$c709 is shared debug scratch: the same bytes are wDebugMenuWindowId and wDebugWarpWindowId in one submenu, the "RRRGGGBBB" decimal buffer in the colour editor, and a save slot for eight bytes of wCharPosX in the stats editor
wDebugWarpEntryPoint:: db
	ds 1

; [3 bytes] Last third of the colour editor's $c700-$c709 digit string: DebugDrawColorComponents formats the R/G/B components as three 3-digit groups at $c700/$c703/$c706, plants the $0d cursor glyph over the selected component's first digit, and WriteStringToWindow draws the whole run under the R/G/B header. Only these and the terminator have free addresses; R and G land on the warp-menu names
wDebugColorBlueDigits:: ds 3

; [8-bit] NUL terminator DebugDrawColorComponents plants after the nine RGB digits so WriteStringToWindow stops here; also the last byte of the shared $c700-$c709 debug scratch block
wDebugColorDigitsEnd:: db
	ds 6

; [8-bit] Window handle of the debug palette viewer's grid window (RunDebugPaletteViewer)
wDebugPaletteViewerWindowId:: db

; [8-bit] Window handle of the debug colour editor opened on top of the palette viewer (RunDebugColorEditor)
wDebugColorEditorWindowId:: db

; [8-bit] Which of the four colours in the selected palette the debug cursor is on, masked to $03
wDebugPaletteColorIndex:: db

; [8-bit] Which palette the debug cursor is on, masked to $0f. GetSelectedBGPaletteColorPtr indexes wBGPalettes with palette * 4 + colour, doubled, so 0-7 reach the BG palettes and 8-15 run on into wOBJPalettes
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

; [8-bit] Window handle of the debug flag editor's second flag grid; the editor redraws all three windows on every cursor move
wDebugFlagWindow2Id:: db
	ds 6

; [16 bytes] Text buffer the debug warp menu builds its number-entry prompt in -- the prompt string is copied here and FormatDecimalNumber overwrites the digits in place
wDebugNumberEntryText:: ds 16
	export_size wDebugNumberEntryText
	ds 48

; [8 bytes] Four 16-bit values the debug stats page shows as words. Only +$00, +$04 and +$06 are drawn; +$02 is skipped
wDebugStatWords:: ds 8

; [8 bytes] The eight single-byte fields of the debug stats editor, drawn by Unused_06_DrawDebugStatByte and stepped in place: the first three wrap at 2, 8 and 2, the last five are decimal digits 0-9. They sit in a larger scratch block whose 16-bit fields start at $c760
wDebugStatBytes:: ds 8

; [8 bytes] Four more 16-bit values on the same page, drawn after wDebugStatBytes
wDebugStatWords2:: ds 8
	ds 8

; Mode-local scratch ($c780-$c78f is reused by each game mode;
; only proven consumers are named, sites in other modes stay numeric).
; The match engine's two `ld hl, $c780 / ld c, $08 / call ClearMemory16`
; sites ($08:$4084/$41ad) zero the ENTIRE $c780-$c7ff mode page, not 8
; bytes -- ClearMemory16 clears c*16 -- which is what resets every union
; variant, the wTargetZone*/wDrillGate* flats and the mode-hook table
; between modes. ResetMugshotPalettes_1b also writes $ff to $c780 before
; reloading palettes; nothing in bank $1b reads it back.
wModeScratch::
UNION
; character select (bank $1b)
	ds 1
; [8-bit] Character id under the char-select cursor, looked up from the roster grid at $c7a0 by Unused_1b_UpdateCharSelectSelection
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
; [16-bit] Serves the minigame has launched. LaunchMinigameServe increments it and derives the ball speed from it (count / 10, capped at $19), so the feed speeds up as the round goes on
wMinigameServeCount:: dw
; [16-bit] Points the floating score popup shows; AwardHitScore and the per-minigame scorers store the award here before calling AddToMinigameScore
wScorePopupValue:: dw
; [8-bit] Ball speed LaunchMinigameServe passed to LaunchBall for this serve
wMinigameServeSpeed:: db
; [8-bit] Which serve the tennis machine plays next; the machine hooks advance it by 1 or 2 per point and wrap it, and ApplyMinigameCharTargetFromTable indexes the aim table with it
wMinigameServeSlot:: db
; [8-bit] wMinigameServeSlot / 3, taken by LaunchMinigameServe and read back by LaunchBall
wMinigameServeGroup:: db
; [8-bit] Frames left on the score popup, seeded with $10 by StartScorePopup; UpdateScorePopup ticks it and also uses it as the popup's rise offset
wScorePopupTimer:: db
; [8-bit] Set while a hit is being scored; ResetTargetHitState only clears the streak when it finds this clear, which is what keeps a streak alive across the points of one rally
wMinigameHitScored:: db
; [8-bit] Consecutive scoring hits, stepped by IncrementCappedCounter (b is the cap). AwardHitScore indexes both a sound table and a score table with it, so a longer streak is worth more and sounds different
wMinigameHitStreak:: db
; [8-bit] Treasure Box actor state, stepped by AdvanceTreasureBoxActorState and used by DrawTreasureBoxSprite to pick the frame
wTreasureBoxState:: db
NEXTU
; training drills (bank $0b)
	ds 11
; [8-bit] Set while the serve gate is still standing: RecordGateCrossOnServe clears it once the serve has passed through (and records the bit in wDrillGateCrossBits), and QueueDrillMarker1/2 only draw the gate markers while it is set
wDrillGateActive:: db
NEXTU
; scoreboard (bank $18)
; [8-bit] Cleared by Unused_18_InitConfirmScreen; Unused_18_DrawScoreNumbersTask compares it against 3 every frame and, on a match, raises wScorePanelBobActive for that frame's score digits. Nothing reachable ever advances it: the confirm screen's only caller is Unused_1b_ShowHighScoreConfirmScreen, so the whole bob is dead code (its ramp table is likewise UnusedBobRamp_18)
wScorePanelBobStep:: db
	ds 2
; [8-bit] Transient flag Unused_18_DrawScoreNumbersTask raises while drawing the wScorePanelScore digits and clears immediately after; Unused_18_DrawGlyphSprite reads it to add a per-glyph Y offset from UnusedBobRamp_18
wScorePanelBobActive:: db
	ds 6
; [8-bit] wStoryMainCharExpTier as Unused_18_LoadScorePanelValue copied it for the scoreboard, so Unused_18_DrawScoreNumbersTask draws from a snapshot rather than the live value
wScorePanelExpTier:: db
; [8-bit named; read as a 16-bit word] Unused_18_DrawScoreNumbersTask loads hl from $c78b-$c78c and draws it as a 3-digit sprite number beside the wScorePanelExpTier draw. No writer exists in bank $18 (Unused_18_LoadScorePanelValue fills only the exp tier), and the high byte is wTargetZoneEnabled -- the dead high-score confirm screen predates the target-zone layout, so on any real entry the value is whatever the mode-page clear left (0)
wScorePanelScore:: db
ENDU

; [8-bit] Nonzero draws the 4-corner court target zone (training drills)
wTargetZoneEnabled:: db

; The last three bytes of the $c780 mode-local scratch block, which sit
; above wTargetZoneEnabled and so need a union of their own. The minigame
; target code and the scoreboard both own them, in different modes.
UNION
; minigame targets (banks $0a/$0d)
; [8-bit] Type of the target the ball just hit, an index into MinigameTargetTypeScores; $ff means the hit scores nothing
wMinigameHitTargetType:: db
; [8-bit] Set by the deflect hit-test and cleared by ScoreMinigameTargetHitOrDeflectBall once the hit has been scored
wMinigameHitPending:: db
	ds 1
NEXTU
; scoreboard (bank $18)
; [3 bytes] Three values Unused_18_SetupScoreboardDisplay draws as 6x2 tile blocks, each fetched through Unused_18_GetTextSlotPointer. The minigame code uses the first two of the same bytes for its hit bookkeeping
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

; [4 bytes] First drill gate: two 16-bit coordinates, +$00 from hl and +$02 from de at SetBallGatePoint1. DidBallCrossGate tests the ball against the pair each frame and QueueDrillMarker1_0b draws the marker there
wDrillGate1:: ds 4

; [4 bytes] The second gate, set and tested the same way
wDrillGate2:: ds 4

; Mode-local scratch, the first five bytes above $c780. Scoped to the
; minigame banks; bank $1b loads its 32-byte nav grids over the same
; address and on past the named mode bytes above -- dead while the menu
; shell runs, and the match engine re-zeroes the whole $c780-$c7ff page
; anyway -- so only the buffer's base byte can carry the union symbol and
; the 32-byte extent lives in its note.
UNION
; menu-shell nav grid (bank $1b)
; [8-bit] Base of the 32-byte 4x8 grid of character/menu-cell ids the menu shell's grid cursor walks -- the buffer runs past this union into the named minigame block, so only the base byte carries the symbol. Unused_1b_LoadCharSelectNavGrid copies CharSelectNavGridTable here and the unlock-debug screen copies UnlockDebugNavGridTable ($ff = empty cell, $fe/$fd = wrap sentinels). Unused_18_MoveGridCursor takes hl = this base, and the selection readers index it split-base with row*8+col
wNavGridBuffer:: db
	ds 4
NEXTU
; minigame targets (banks $0a/$0d)
; [4 bytes] Position the floating score popup starts from, copied out of wBallHistory + 30 by StartScorePopup and stepped by UpdateScorePopup
wScorePopupSource:: ds 4
; [8-bit] Set at init by Banana Bunch and Fruit Fantasy, the two minigames whose targets deflect the ball rather than absorb it. While it is nonzero UpdateMinigameTarget runs the Alt draw, hit-test and scoring handlers instead of the ordinary ones
wMinigameTargetsAltMode:: db
ENDU

; [8-bit] Random roll SelectRandomMinigameShot and SelectRandomTreasureBoxTargetZone keep while they walk their weight tables to pick the next shot or target zone
wMinigameShotRoll:: db

; [8-bit] Set when the ball lands on a target tile and read by ProcessTargetTileHit, which clears it as it scores the hit
wTargetTileHit:: db

; [8-bit] Where the minigame is in its serve: StartMinigameMatch seeds it, DrawMinigameScoreHud and LaunchMinigameServe branch on it
wMinigameServeState:: db

; [8-bit] Nonzero makes AiServePressToss release the serve immediately instead of running the wAiServeStyle toss table - the plain feed the coach's practice drills want. The bank $0b drill hooks set it at point start and clear it around RunMinigameMatch
wAiServeSkipToss:: db
	ds 7

; [16-bit] Pointer to the layout table for the current minigame point, set by SetMinigamePointTable and walked by LoadMinigamePointLayout and RunMinigamePointLoop
wMinigamePointTable:: dw

; [16-bit] Pointer to the current game mode's callback table (indexed by CallModeHook)
wModeHookTable:: dw

; [8-bit] ROM bank of the mode callback table (0 = no hooks registered)
wModeHookBank:: db

; [8-bit] Aim AiApplyServeAim must use for the next serve; $ff (set by RunMatch) means pick one at random from AiApplyServeAimTable. The drill point-start hooks write a specific aim so a lesson always serves where the script needs it
wAiServeAimOverride:: db

; [16-bit] Spot the serving CPU is walking to. Zero means "not chosen yet", which is what makes AiServeWalkToSpot roll a new one; the drill runner clears it before each match
wAiServeTargetX:: dw

; [8-bit] Set to 1 by the InitMinigame_* routines whose ball is fed by the tennis machine (Tennis Machine 1-4, Target Shot, Shooting Star, Treasure Box, Medallion Match). The shared match engine reads it for the scoreboard layout, the point reset and the serve phase
wMinigameUsesTennisMachine:: db

; [8-bit] Set to 1 by the InitMinigame_* routines played against the wall (Wall Practice 1-4, Banana Bunch, Perfect Shot, Fruit Fantasy); read by SelectScoreboardLayout, HandleBallNetCrossing and the serve positioning
wMinigameUsesWall:: db

; [8-bit] Set to 1 by InitMinigame_BooBlast
wMinigameIsBooBlast:: db

; [8-bit] Set to 1 by the bank $0b Service/NetGame practice drills (the coach lessons). RecordDrillPointResultBits stores the per-point result differently while it is set, and SelectScoreboardLayout picks layout 3
wDrillIsPracticeLesson:: db

; [8-bit] Set to 1 when the minigame is being played for a high score: the InitMinigame_*HighScore entries set it outright, and the ordinary minigames set it when wMinigameLevel is 2 (the third level). SelectScoreboardLayout picks layout 7
wMinigameHighScoreMode:: db

; [8-bit] Passed in b to LoadPlayer1ScoreDigitGfx/LoadPlayer2ScoreDigitGfx, so the score panel shows tiebreak point counts instead of 0/15/30/40. CheckSetComplete sets it entering a tiebreak and clears it at the start of an ordinary game
wScoreDisplayIsTiebreak:: db

; Mode-local scratch above the named mode flags, same rule as the $c780
; block: each mode reuses the bytes, so the variants are scoped to the
; owning ROM bank and anything outside them stays numeric.
UNION
; minigame targets (banks $0a/$0d)
; [8-bit] Set while the target actors are live; UpdateMinigameTargets returns at once when it is clear
wMinigameTargetsActive:: db
; [8-bit] Grid cell the ball last bounced off, recorded by the banana-bunch and fruit-fantasy deflection handlers and read back when the hit is scored
wMinigameLastHitCell:: db
; [24 bytes] The 3 x 8 target grid, one byte per cell. AreAllTargetsHit passes only when all 24 read 1; ResetTargetGrid clears it a row at a time (+$07, +$0f, +$17 are the row ends)
wMinigameTargetGrid:: ds 24
	export_size wMinigameTargetGrid
NEXTU
; character select and new game (bank $1b)
; [8-bit] Cursor column carried in and out of RunCharacterSelectScreen, so the new-game roster loop resumes where the player left off
wCharSelectCursorCol:: db
; [8-bit] Cursor row, the same
wCharSelectCursorRow:: db
; [8 bytes] Two bytes per starting character (wCharRecordBuffer + 14 and + 12), collected by RunNewGameSetup before the roster is offered
wNewGameRosterFields:: ds 8
; [8-bit] Cleared by Unused_1b_RunStoryDataConfirmMenu as the prompt opens
wStoryDataPromptFlag:: db
ENDU

	ds 40

; [buffer] Base of the story-slot state image (WRAM $c800-$caff): the live region holding the wStoryModeMainCharacter*/wGameMode/match-settings/roster fields, saved wholesale as save block 2N (see docs/save_format.md) and reloaded from it on slot load
wStorySlotData:: db

; [6 bytes] Bytes 1-6 of the saved-slot mirror's main character name (record +$01-$06); byte 0 of the name is the slot image base wStorySlotData. The mirror pair at $c800/$c840 is kept in step with the live records at $c900/$c940 by a 128-byte copy ($02:$4795)
wSavedMainCharacterName:: ds 6

; [4 bytes] Character record +$07-$0a of the saved-slot mirror of the story main character record: name terminator and padding after the 7-character name; the drawer scans to the NUL, so these are read
wStoryModeMainCharacterNamePad:: ds 4

; [8-bit] Saved-slot mirror of the main character record +$0b: character id (post-RemapExtendedCharId), the mirror of $c90b
wSavedMainCharacterId:: db

; [8-bit] Saved-slot mirror of the main character record +$0c: palette index (GetCharPaletteIndex)
wSavedMainCharacterPaletteIndex:: db

; [8-bit] Saved-slot mirror of the main character record +$0d: gender, 0 male, 1 female
wSavedMainCharacterGender:: db

; [8-bit] Saved-slot mirror of the main character record +$0e: left-handed flag
wSavedMainCharacterLeftHanded:: db

; [9 bytes] Character record +$0f-$17 of the saved-slot mirror of the story main character record: AI and physics attributes copied from the ROM record (StoryCharacterRecords_02): +$0f a personality byte, +$10-$17 the reach windows, smash and dive speeds and reaction delays that RecomputeCharacterStats refreshes from the +$30 template
wStoryModeMainCharacterPhysics:: ds 9

; [8-bit] Story Mode - Main Character Level (0x01-0x63)
wStoryModeMainCharacterLevel:: db

; [2 bytes] Character record +$19-$1a of the saved-slot mirror of the story main character record: swing attribute word
wStoryModeMainCharacterSwingAttrWord:: dw

; [5 bytes] Character record +$1b-$1f of the saved-slot mirror of the story main character record: the AI personality parameters (docs/story_mode.md, "The character record")
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

; [3 bytes] Story Mode - Main Character EXP -- a 3-byte accumulator, capped at 99999 by AddExpCapped
wStoryModeMainCharacterEXP:: ds 3
; [8-bit] Character record +$2f of the saved-slot mirror: write-only build tag (see wStoryMainCharBuildKind)
wStoryModeMainCharacterBuildKind:: db

; [8 bytes] Character record +$30-$37 of the saved-slot mirror of the story main character record: physics template, copied into +$10-+$17 on every RecomputeCharacterStats
wStoryModeMainCharacterPhysicsTemplate:: ds 8

; [8-bit] Story Mode - Main Character Spin Level
wStoryModeMainCharacterSpinLevel:: db

; [8-bit] Story Mode - Main Character Power Level
wStoryModeMainCharacterPowerLevel:: db

; [8-bit] Story Mode - Main Character Control Level
wStoryModeMainCharacterControlLevel:: db

; [8-bit] Story Mode - Main Character Speed Level
wStoryModeMainCharacterSpeedLevel:: db

; [8-bit] Equipment nibbles for the main character, cleaned up by RefreshMainCharacterStats before the stats are recomputed: a low nibble of 3 drops the low nibble, a high nibble of 1 drops the high one
wMainCharEquipmentBits:: db
	ds 3

; [7 bytes] Saved-slot mirror of the partner record +$00-$06: the 7-character name, NUL-padded
wSavedPartnerCharacterName:: ds 7

; [4 bytes] Character record +$07-$0a of the saved-slot mirror of the partner record: name terminator and padding after the 7-character name; the drawer scans to the NUL, so these are read
wStoryModePartnerCharacterNamePad:: ds 4

; [8-bit] Saved-slot mirror of the partner record +$0b: character id (post-RemapExtendedCharId), the mirror of $c94b
wSavedPartnerCharacterId:: db

; [8-bit] Saved-slot mirror of the partner record +$0c: palette index (GetCharPaletteIndex)
wSavedPartnerCharacterPaletteIndex:: db

; [8-bit] Saved-slot mirror of the partner record +$0d: gender, 0 male, 1 female
wSavedPartnerCharacterGender:: db

; [8-bit] Saved-slot mirror of the partner record +$0e: left-handed flag
wSavedPartnerCharacterLeftHanded:: db

; [9 bytes] Character record +$0f-$17 of the saved-slot mirror of the partner record: AI and physics attributes copied from the ROM record (StoryCharacterRecords_02): +$0f a personality byte, +$10-$17 the reach windows, smash and dive speeds and reaction delays that RecomputeCharacterStats refreshes from the +$30 template
wStoryModePartnerCharacterPhysics:: ds 9

; [8-bit] Story Mode - Partner Character Level (0x01-0x63)
wStoryModePartnerCharacterLevel:: db

; [2 bytes] Character record +$19-$1a of the saved-slot mirror of the partner record: swing attribute word
wStoryModePartnerCharacterSwingAttrWord:: dw

; [5 bytes] Character record +$1b-$1f of the saved-slot mirror of the partner record: the AI personality parameters (docs/story_mode.md, "The character record")
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

; [3 bytes] Story Mode - Partner Character EXP -- a 3-byte accumulator, capped at 99999 by AddExpCapped
wStoryModePartnerCharacterEXP:: ds 3
; [8-bit] Character record +$2f of the saved-slot mirror: write-only build tag (see wStoryMainCharBuildKind)
wStoryModePartnerCharacterBuildKind:: db

; [8 bytes] Character record +$30-$37 of the saved-slot mirror of the partner record: physics template, copied into +$10-+$17 on every RecomputeCharacterStats
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

; [4 bytes] Signature identifying a story save, so two slots can be told apart. CacheStorySlotSummaries copies each slot's into $d400 + slot * 4, CheckStorySignatureCollision compares them and GenerateUniqueStorySaveSignature rerolls from wStoryRandomBytes until no slot matches
wStorySaveSignature:: ds 4

; [3 bytes] Tag InitStoryModeState stamps on a fresh story slot: $56 then two zero bytes
wStorySlotBlockTag:: ds 3
	ds 7

; [4 bytes] Copy of wGameTimer taken by SaveGameTimer with interrupts off, so a screen that stops the clock can put it back exactly (RestoreGameTimer)
wSavedGameTimer:: dw

; [2 bytes] The pair CharDataValuesSyncTask pushes into the character-data screen at $d14c when $d149 is clear; it uses wGameTimer + 2 instead when it is set
wCharDataSyncValues:: dw
	ds 17

; [8-bit] Sound options from the pause menu. Bit 0 is music on/off: Unused_1a_ToggleMusicSetting flips just that bit and Unused_00_SyncBGMEnableFlag mirrors it into hMusic bit 0, stopping the BGM when it goes clear. The remaining bits are preserved by both
wSoundOptionBits:: db

; [8-bit] Message Speed
;
; 0x00 - Fast
; 0x01 - Normal
; 0x02 - Slow
wMessageSpeed:: db

; [8-bit] Set to 1 by the Save & Quit entries of the match and story pause menus (MatchQuitMenu_SaveAndQuit, StoryPauseMenu_SaveQuit, and the story menu's confirm prompt), each of which also calls SaveStoryReturnPoint. The post-match code in bank $10 branches on it to show the results screen and save the slot, then clears it beside wKeepMatchStatsFlag
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
; The RetroAchievements note this list comes from omits 0x09; it is added above. Bank $38 sets it at $7448, one instruction after farcall RunLinkCharSelectScreen; ScoreboardModeGfxPointers record 9 is ScoreboardModeGfx_LinkedMatch, i.e. the scoreboard word-art for the mode spells it out; and every mode-0x09 test in banks $06/$08/$16/$1e either reads wLinkMatchRole immediately or bypasses the story/save path. The space is exactly 0x00-0x0a: SaveQuitMenuIdByGameMode ($06:$44f3) and ScoreboardModeGfxPointers ($06:$5cc9) both index it unguarded and both hold 11 entries. See the GAMEMODE_* defs in include/constants.inc
wGameMode:: db

; [8-bit] Nonzero makes ResetMatchState skip clearing the per-character match stats (set by MatchQuitMenu_SaveAndQuit so a resumed match keeps its stats); cleared after use
wKeepMatchStatsFlag:: db

; [8-bit] Nonzero selects VictoryScoreTable1 over VictoryScoreTable in GetVictoryScore. Set on two paths of the match-select handler
wVictoryScoreTableAlt:: db

; [8-bit] Location SaveStoryReturnPoint recorded to come back to. Called with b = $ff it snapshots the live position instead of a fixed door
wStoryReturnLocation:: db

; [8-bit] Entry point paired with wStoryReturnLocation, or $ff to mean 'no door - restore wStoryReturnPosition instead'. RestoreStoryReturnPoint branches on exactly that
wStoryReturnEntryPoint:: db

; [5 bytes] Player X, Y and facing saved with the return point, in the wStoryModeSpawnPosition layout it is copied back into
wStoryReturnPosition:: ds 5
	export_size wStoryReturnPosition
	ds 1

; [16-bit] EXP an exhibition match earned, parked here by AwardExhibitionMatchExp and applied by ApplyPendingExpAwards once the results screens are done
wPendingExpExhibition:: dw

; [16-bit] The same for a linked-play match (AwardLinkedPlayMatchExp)
wPendingExpLinked:: dw

; [4 bytes] One byte per player slot naming the character the suspended or link match was set up with, copied out of wCharSelectSlotChars by StoreLinkMatchCharInfo (or out of the exhibition save block by CopyExhibitionCharSlotIds). Bit 7 marks a created story character and the low bits then say which story slot it came from
wMatchSlotCharRefs:: ds 4

; [8-bit] Copy of hLinkState taken by StoreLinkMatchCharInfo when the link match's characters are committed. The results and EXP screens turn it back into a WRAM bank with `srl a / add a, $04`, i.e. which per-character struct is the local player's
wLinkMatchRole:: db

; [8-bit] Byte at +$02 of the chosen created-character record, taken by StoreLinkMatchCharInfo before the link match and read back by the EXP screen panels
wLinkMatchCharLevel:: db

; [4 bytes] Rolling random bytes RollStoryRandomByte stirs; GenerateUniqueStorySaveSignature copies them into wStorySaveSignature
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

; [8-bit] wCharCourtPos as it was last frame. CheckServerEndChanged swaps the new value in and raises wChangeEndsPending when bit 1 differs, which is the ends-change; UpdateViewFlipState reads it for the flipped-court view
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

; [8-bit] Character 3 Drop Shot Winners
wCharacter3DropShotWinners2:: db

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
wPlayer4LobShotWinners:: db

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

; [8-bit] Player 2 Points Won; for values see 0xc8e4
wPlayer2PointsWon:: db

; [8-bit] Deuce Indicator (0x01 when deuce, 0x00 otherwise)
wDeuceIndicator:: db

; [8-bit] Tiebreaker Indicator (0x01 when tiebreaker, 0x00 otherwise)
wTiebreakerIndicator:: db

; [8-bit] Match Win/Lose Flag (0x01 - win, 0xff - lose, 0x00 otherwise)
wMatchWinLoseFlag:: db

; [8-bit] Set Win/Lose Flag (0x01 - win, 0xff - lose, 0x00 otherwise)
wSetWinLoseFlag:: db

; [8-bit] Game Win/Lose Flag (0x01 - win, 0xff - lose, 0x00 otherwise))
wGameWinLoseFlag:: db

; [8-bit] Point Win/Lose Flag (0x01 - win, 0xff - lose, 0x00 otherwise)
wPointWinLoseFlag:: db

; [8-bit] Total Games Won In Match
wTotalGamesWonInMatch:: db

; [8-bit] Total Points Scored In Current Game
wTotalPointsScoredInCurrentGame:: db

; [8-bit] 1 after a first-serve fault (the next fault becomes a double fault, point outcome 2); cleared on double fault and at match reset
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

; [8-bit] What kind of match is running: 0 = exhibition (cleared by RestoreOverworldAfterMatch), 1 = story match (InitStoryMatchSettings), 2 = minigame/drill (InitMinigameMatchSettings, RunDoublesDrillMatch). SelectScoreboardLayout forces the doubles scoreboard and InitViewFlipPreference forces the fixed court view when it is 2
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

; [8-bit] BGM id (see wCurrentBGM values) played for the current match/court; tiebreak overrides it with $0e
wMatchBGM:: db
	ds 7

; [ASCII, 7 Bytes] Story Mode - Name of Main Character
wStoryModeNameOfMainCharacter:: ds 7

; [4 bytes] Character record +$07-$0a of the live story main character record: name terminator and padding after the 7-character name; the drawer scans to the NUL, so these are read
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

; [8-bit] Story Mode - main character's gender: $00 = male, $01 = female. Copied from StoryCharGenderTable by InitPlayerRecordFromTemplate ($02:$43db) and read-only thereafter. Proven by the dialogue pairs it selects via AdvanceDialogueTextCursor: $30:433 "Take good care of him, OK?" vs $30:434 "...of her, OK?" ($10:$7844), and $31:60 "He's , the Academy's newest student." vs $31:61 "She's ..." ($13:$49b8). Also picks the gendered overworld object defs ($56 + gender).
wStoryModeGenderOfMainCharacter:: db

; [8-bit] Story Mode - nonzero when the main character plays left-handed. Written from wCharSelectHandedness at $38:$48ba (record offset +$0e) and, on the bank $02 new-game path, from bit 2 of the character id ($02:$51c5). Bank $17 uses it to swap the spin-serve briefing text between $36:696 ("serve to the right with topspin and to the left with slice") and $36:697, its mirror image.
wStoryModeMainCharacterLeftHanded:: db

; [9 bytes] Character record +$0f-$17 of the live story main character record: AI and physics attributes copied from the ROM record (StoryCharacterRecords_02): +$0f a personality byte, +$10-$17 the reach windows, smash and dive speeds and reaction delays that RecomputeCharacterStats refreshes from the +$30 template
wStoryMainCharPhysics:: ds 9

; [8-bit] EXP tier of the story main character's record ($c900 + $18, the same field LoadCharacterAttributes turns into wCharExpTier for an on-court character). ScaleExpByPlayerLevel averages it with wStoryPartnerCharExpTier and compares the result against $0a to decide whether match EXP is scaled down
wStoryMainCharExpTier:: db

; [2 bytes] Character record +$19-$1a of the live story main character record: swing attribute word
wStoryMainCharSwingAttrWord:: dw

; [5 bytes] Character record +$1b-$1f of the live story main character record: the AI personality parameters (docs/story_mode.md, "The character record")
wStoryMainCharAiParams:: ds 5

; [11 bytes] The eleven 0-9 stats of the story main character's record ($c900 + $20), in the wStoryModeMainCharacter*Stat order: Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop
wStoryMainCharStats:: ds 11
; [8-bit] Character record +$2b: speed bonus, the last byte InitCa00RecordFromCharId copies from the roster row; LoadCharacterAttributes adds it to the Speed stat to pick the shot-placement row
wStoryMainCharSpeedBonus:: db

; [3 bytes] EXP in the story main character's record ($c900 + $2c) -- a 3-byte accumulator, capped at 99999 by AddExpCapped
wStoryMainCharExp:: ds 3
; [8-bit] Character record +$2f: written by InitCa00RecordFromCharId ($02 roster, $03 the story main character, $00 cleared) and read by nothing
wStoryMainCharBuildKind:: db

; [8 bytes] Character record +$30-$37 of the live story main character record: physics template, copied into +$10-+$17 on every RecomputeCharacterStats
wStoryMainCharPhysicsTemplate:: ds 8

; [8-bit] Spin level in the story main character's record ($c900 + $38); the four levels shown on character select run from here
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

; [4 bytes] Character record +$07-$0a of the live partner record: name terminator and padding after the 7-character name; the drawer scans to the NUL, so these are read
wStoryPartnerCharNamePad:: ds 4

; [8-bit] Story Mode - Partner Character Overworld Sprite; for values see 0x00c90b
wStoryModePartnerCharacterOverworldSprite:: db

; [8-bit] Story Mode - Partner Character Overworld Sprite Color; for values see 0x00c90c
wStoryModePartnerCharacterOverworldSpriteColor:: db

; [8-bit] Story Mode - doubles partner's gender ($00 male, $01 female), the partner record's copy of the field at the $40 stride. Selects the partner object def ($58 + gender) and, with the main character's gender, the four-way scene key (main << 1) | (main XOR partner) that $13:$78c4 passes to RunStorySceneByMode.
wStoryModeGenderOfPartnerCharacter:: db

; [8-bit] Story Mode - the partner record's copy of the left-handed flag (record offset +$0e at the $40 stride); written by the same character-select path as wStoryModeMainCharacterLeftHanded.
wStoryModePartnerCharacterLeftHanded:: db

; [9 bytes] Character record +$0f-$17 of the live partner record: AI and physics attributes copied from the ROM record (StoryCharacterRecords_02): +$0f a personality byte, +$10-$17 the reach windows, smash and dive speeds and reaction delays that RecomputeCharacterStats refreshes from the +$30 template
wStoryPartnerCharPhysics:: ds 9

; [8-bit] EXP tier of the story partner's record ($c940 + $18), the partner half of wStoryMainCharExpTier
wStoryPartnerCharExpTier:: db

; [2 bytes] Character record +$19-$1a of the live partner record: swing attribute word
wStoryPartnerCharSwingAttrWord:: dw

; [5 bytes] Character record +$1b-$1f of the live partner record: the AI personality parameters (docs/story_mode.md, "The character record")
wStoryPartnerCharAiParams:: ds 5

; [11 bytes] Character record +$20-$2a of the live partner record: the eleven displayed stat bars 0-9: Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop
wStoryPartnerCharStats:: ds 11
; [8-bit] Character record +$2b: speed bonus, the last byte InitCa00RecordFromCharId copies from the roster row; LoadCharacterAttributes adds it to the Speed stat to pick the shot-placement row
wStoryPartnerCharSpeedBonus:: db

; [3 bytes] EXP in the story partner's record ($c940 + $2c) -- a 3-byte accumulator, capped at 99999 by AddExpCapped
wStoryPartnerCharExp:: ds 3
; [8-bit] Character record +$2f: written by InitCa00RecordFromCharId ($02 roster, $03 the story main character, $00 cleared) and read by nothing
wStoryPartnerCharBuildKind:: db

; [8 bytes] Character record +$30-$37 of the live partner record: physics template, copied into +$10-+$17 on every RecomputeCharacterStats
wStoryPartnerCharPhysicsTemplate:: ds 8

; [8-bit] Spin level in the story partner's record ($c940 + $38)
wStoryPartnerCharSpinLevel:: db

; [8-bit] Power level, the record's +$39
wStoryPartnerCharPowerLevel:: db

; [8-bit] Control level, the record's +$3a
wStoryPartnerCharControlLevel:: db

; [8-bit] Speed level, the record's +$3b
wStoryPartnerCharSpeedLevel:: db
	ds 52

; [16-bit] EXP a story match earned, the third of the pending awards alongside wPendingExpExhibition and wPendingExpLinked. ApplyPendingExpAwards adds it to wPendingExpTrophy, scales the total by the player level and folds in the trophy awards
wPendingExpStory:: dw

; [16-bit] The trophy half of the same pending award, summed with wPendingExpStory before scaling. Unused_02_ValidateN64TransferRecord and the debug stats screen address the pair as the head of the N64 transfer record that wN64TransferMarker ends
wPendingExpTrophy:: dw

; [8-bit] Marker byte of the N64 transfer record at $c9b0: Unused_02_ValidateN64TransferRecord ($02:$4044) rejects the record unless it reads exactly $64, then checksums the bytes around it
wN64TransferMarker:: db

; [2 bytes] Trophies transferred from the N64 game, packed two bits per trophy (0-3) for eight trophies. DecodeTrophyCounts ($3b:$4c53) unpacks all eight into the trophy screen's cells, and the EXP award path walks the same two bytes tier by tier to pick a TrophyExpForGroupTable row
wN64TrophyCounts:: dw
	ds 9

; [32 bytes] Per-story-slot progress flags, $c9c0-$c9df, saved as the story slot's +$1c0 block. rst $20/$28/$30 (SetGameFlag/ClearGameFlag/TestGameFlag, $00:$24ba/$24d4/$249f) take d = byte index, e = bit << 5 and apply mask $80 >> bit to wGameFlags[d]; the *GameFlagByNumber wrappers ($00:$24ef) take the flat flag number byte * 8 + bit instead, which is what the FLAG_* constants in include/flag_constants.inc hold. Nothing reads the array as bytes, so the wSinglesDoublesIndicator / wStoryMode*Flags* entries below are the same storage under the RetroAchievements names: byte $05 = doubles, $06/$07 = Island Open + Dream Match, $08-$0b = class rank wins, $0c/$0d = equipment owned, $18-$1b = training-drill clears. Bytes $1c-$1f are scratch: ClearTemporaryStoryFlags ($0a:$50e4) zeroes them on every story-location load, the way pokecrystal's first eight event flags reset on map reload.
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

; [3 bytes] wGameFlags bytes $0e-$10 (flags 112-135): the NPC talked/moved/turned and scene-seen flags -- FLAG_SENIOR_COURT_NPC03_TURNED, FLAG_TOURNAMENT_NPC05_TALKED_*, FLAG_COURT2_SPECTATORS_TALKED_*, FLAG_RESTAURANT_NPC08_MOVED, FLAG_PRACTICE_ROOM_SESSION_ACTIVE, FLAG_REPAIR_COUNTER_*, FLAG_SWING_PRACTICE_KID_PLACED, FLAG_JUNIOR_COURT_NPC0A_TALKED, FLAG_AWARDS_CEREMONY_SEEN_* (include/flag_constants.inc)
wStoryModeNpcEventFlags:: ds 3

; [3 bytes] wGameFlags bytes $11-$13 (flags 136-159): no FLAG_* number lands here and no site sets or tests one -- saved with the slot, never used
wGameFlagsSpare:: ds 3

; [2 bytes] wGameFlags bytes $14-$15 (flags 160-175): FLAG_CHEAT_UNLOCK_0-12, the per-slot bits the unlock-everything cheat sets and nothing reads, then FLAG_REACHED_ISLAND_OPEN_SINGLES/DOUBLES
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

; [4 bytes] wGameFlags bytes $1c-$1f (flags $e0-$ff): the temporary end of the array. ClearTemporaryStoryFlags ($0a:$50e4) zeroes all four at the top of RunStoryLocation, so anything stored here lasts only until the next location load - per-location NPC/scene-variant state ($1c) and the screen-mode bits the progress and results screens set and clear around themselves ($1f).
wGameFlagsTemp:: ds 4
	ds 32

; [7 bytes] Display name of the player-1 main character, base of its $40-byte on-court character record. The results screen draws it straight from here through CopyStringToTextBuffer, and the same record supplies the physics and AI attributes LoadCharacterAttributes copies into the character's banked struct
wPlayer1MainName:: ds 7

; [3 bytes] Character record +$07-$09 of on-court record for player 1 main: name terminator and padding after the 7-character name; the drawer scans to the NUL, so these are read
wPlayer1MainNamePad:: ds 3

; [8-bit] Byte +$0a of the player-1 main record, borrowed by ExchangeLinkUnlockFlags ($38:$7603) as the cell the peer's bonus-court unlock mask arrives in. Whichever of this and wPlayer2MainLinkCourtMask matches the link role is copied to wLinkPartnerCourtMask, then both are cleared
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
; 0x16 - Allie 2 (never shows up?)
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

; [8-bit] Palette index of the player-1 main character: LoadResultPortraitSlot hands it to LoadIndexedPalette_18, and InitChar passes it (plus 3) to SetupCharacterSprite as the OBJ palette the character is drawn with
wPlayer1MainPalette:: db
; [8-bit] Character record +$0d: gender, 0 male / 1 female (InitPlayerRecordFromTemplate, from StoryCharGenderTable for the story records)
wPlayer1MainGender:: db

; [8-bit] Nonzero mirrors the player-1 main character: LoadCharacterAttributes turns it into wCharMirrorAttrMask ($20, the OAM X-flip bit) and the results-screen portrait code XORs the same bit in. ApplyStarFlagsToCharRecords seeds it from wCharSelectSlotStar
wPlayer1MainLeftHanded:: db

; [9 bytes] Character record +$0f-$17 of on-court record for player 1 main: AI and physics attributes copied from the ROM record (StoryCharacterRecords_02): +$0f a personality byte, +$10-$17 the reach windows, smash and dive speeds and reaction delays that RecomputeCharacterStats refreshes from the +$30 template
wPlayer1MainPhysics:: ds 9

; [8-bit] EXP tier of the player-1 main character, record +$18 -- the level for a player character (1-99), the class tier for a roster NPC; the counterpart of wPlayer1PartnerExpTier
wPlayer1MainExpTier:: db

; [2 bytes] Character record +$19-$1a of on-court record for player 1 main: swing attribute word
wPlayer1MainSwingAttrWord:: dw

; [5 bytes] Character record +$1b-$1f of on-court record for player 1 main: the AI personality parameters (docs/story_mode.md, "The character record")
wPlayer1MainAiParams:: ds 5

; [11 bytes] Character record +$20-$2a of on-court record for player 1 main: the eleven displayed stat bars 0-9: Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop
wPlayer1MainStats:: ds 11
; [8-bit] Character record +$2b: speed bonus, the last byte InitCa00RecordFromCharId copies from the roster row; LoadCharacterAttributes adds it to the Speed stat to pick the shot-placement row
wPlayer1MainSpeedBonus:: db

; [3 bytes] Character record +$2c-$2e of the on-court record: EXP, a 3-byte accumulator capped at 99999 by AddExpCapped
wPlayer1MainExp:: ds 3
; [8-bit] Character record +$2f: written by InitCa00RecordFromCharId ($02 roster, $03 the story main character, $00 cleared) and read by nothing
wPlayer1MainBuildKind:: db

; [8 bytes] Character record +$30-$37 of on-court record for player 1 main: physics template, copied into +$10-+$17 on every RecomputeCharacterStats
wPlayer1MainPhysicsTemplate:: ds 8

; [4 bytes] Character record +$38-$3b of on-court record for player 1 main: the four trainable levels: Spin, Power, Control, Speed
wPlayer1MainTrainLevels:: ds 4

; [8-bit] Equipment the player-1 main character is carrying, one nibble each (same field as wEquippedRacket in the story record). ApplyMatchSettingsExpBonus reads it for the handicap EXP bonus: low nibble $03 is worth one step, high nibble $01 another, and two steps double the match EXP
wPlayer1MainEquipment:: db
	ds 3

; [7 bytes] Display name and record base of the player-1 partner, the doubles counterpart of wPlayer1MainName
wPlayer1PartnerName:: ds 7

; [4 bytes] Character record +$07-$0a of on-court record for player 1 partner: name terminator and padding after the 7-character name; the drawer scans to the NUL, so these are read
wPlayer1PartnerNamePad:: ds 4

; [8-bit] Player 1 Current Partner Character; for values see 0xca0b
wPlayer1CurrentPartnerCharacter:: db

; [8-bit] Palette index of the player-1 partner (see wPlayer1MainPalette)
wPlayer1PartnerPalette:: db
; [8-bit] Character record +$0d: gender, 0 male / 1 female (InitPlayerRecordFromTemplate, from StoryCharGenderTable for the story records)
wPlayer1PartnerGender:: db

; [8-bit] Mirror flag of the player-1 partner (see wPlayer1MainLeftHanded)
wPlayer1PartnerLeftHanded:: db

; [9 bytes] Character record +$0f-$17 of on-court record for player 1 partner: AI and physics attributes copied from the ROM record (StoryCharacterRecords_02): +$0f a personality byte, +$10-$17 the reach windows, smash and dive speeds and reaction delays that RecomputeCharacterStats refreshes from the +$30 template
wPlayer1PartnerPhysics:: ds 9

; [8-bit] EXP tier of the player-1 partner, record +$18. ApplyCpuDifficultyToCharRecords writes it from the difficulty row only when the slot is not a created character, so a story character keeps the tier it earned
wPlayer1PartnerExpTier:: db

; [2 bytes] Character record +$19-$1a of on-court record for player 1 partner: swing attribute word
wPlayer1PartnerSwingAttrWord:: dw

; [4 bytes] Four of the player-1 partner's six AI personality parameters (record +$1b-$1e; +$0f and +$1f are the other two). ApplyCpuDifficultyToCharRecords copies them out of the chosen difficulty's row, and OverrideCharStatsForDebug rewrites exactly this block
wPlayer1PartnerAiParams:: ds 4

; [8-bit] Exhibition Mode - Player Partner Character Difficulty
;
; 0x00 - Easy
; 0x01 - Normal
; 0x02 - Hard
; 0x03 - Intense
wExhibitionModePlayerPartnerCharacterDifficulty:: db

; [11 bytes] Character record +$20-$2a of on-court record for player 1 partner: the eleven displayed stat bars 0-9: Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop
wPlayer1PartnerStats:: ds 11
; [8-bit] Character record +$2b: speed bonus, the last byte InitCa00RecordFromCharId copies from the roster row; LoadCharacterAttributes adds it to the Speed stat to pick the shot-placement row
wPlayer1PartnerSpeedBonus:: db

; [3 bytes] Character record +$2c-$2e of the on-court record: EXP, a 3-byte accumulator capped at 99999 by AddExpCapped
wPlayer1PartnerExp:: ds 3
; [8-bit] Character record +$2f: written by InitCa00RecordFromCharId ($02 roster, $03 the story main character, $00 cleared) and read by nothing
wPlayer1PartnerBuildKind:: db

; [8 bytes] Character record +$30-$37 of on-court record for player 1 partner: physics template, copied into +$10-+$17 on every RecomputeCharacterStats
wPlayer1PartnerPhysicsTemplate:: ds 8

; [4 bytes] Character record +$38-$3b of on-court record for player 1 partner: the four trainable levels: Spin, Power, Control, Speed
wPlayer1PartnerTrainLevels:: ds 4
	ds 4

; [7 bytes] Display name and record base of the player-2 main character
wPlayer2MainName:: ds 7

; [3 bytes] Character record +$07-$09 of on-court record for player 2 main: name terminator and padding after the 7-character name; the drawer scans to the NUL, so these are read
wPlayer2MainNamePad:: ds 3

; [8-bit] The player-2 main record's copy of the unlock-mask exchange cell (see wPlayer1MainLinkCourtMask)
wPlayer2MainLinkCourtMask:: db

; [8-bit] Player 2 Current Main Character; for values see 0xca0b
wPlayer2CurrentMainCharacter:: db

; [8-bit] Palette index of the player-2 main character (see wPlayer1MainPalette)
wPlayer2MainPalette:: db
; [8-bit] Character record +$0d: gender, 0 male / 1 female (InitPlayerRecordFromTemplate, from StoryCharGenderTable for the story records)
wPlayer2MainGender:: db

; [8-bit] Mirror flag of the player-2 main character (see wPlayer1MainLeftHanded)
wPlayer2MainLeftHanded:: db

; [8-bit] Last byte of BooBlastInitParams, stored into the CPU character record at +$0f as the minigame is set up. Nothing reads it back
wPlayer2MainInitByte:: db

; [8 bytes] Character record +$10-$17 of on-court record for player 2 main: AI and physics attributes copied from the ROM record (StoryCharacterRecords_02): +$0f a personality byte, +$10-$17 the reach windows, smash and dive speeds and reaction delays that RecomputeCharacterStats refreshes from the +$30 template
wPlayer2MainPhysicsFrom10:: ds 8

; [8-bit] EXP tier of the player-2 main character (see wPlayer1PartnerExpTier)
wPlayer2MainExpTier:: db

; [2 bytes] Character record +$19-$1a of on-court record for player 2 main: swing attribute word
wPlayer2MainSwingAttrWord:: dw

; [4 bytes] The player-2 main character's AI parameter block (see wPlayer1PartnerAiParams). The bank $0b and $0d minigame setups write it directly to give a drill opponent a fixed personality
wPlayer2MainAiParams:: ds 4

; [8-bit] Exhibition Mode - CPU Main Character Difficulty; for values see 0x00ca5f
wExhibitionModeCPUMainCharacterDifficulty:: db

; [11 bytes] Character record +$20-$2a of on-court record for player 2 main: the eleven displayed stat bars 0-9: Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop
wPlayer2MainStats:: ds 11
; [8-bit] Character record +$2b: speed bonus, the last byte InitCa00RecordFromCharId copies from the roster row; LoadCharacterAttributes adds it to the Speed stat to pick the shot-placement row
wPlayer2MainSpeedBonus:: db

; [3 bytes] Character record +$2c-$2e of the on-court record: EXP, a 3-byte accumulator capped at 99999 by AddExpCapped
wPlayer2MainExp:: ds 3
; [8-bit] Character record +$2f: written by InitCa00RecordFromCharId ($02 roster, $03 the story main character, $00 cleared) and read by nothing
wPlayer2MainBuildKind:: db

; [8 bytes] Character record +$30-$37 of on-court record for player 2 main: physics template, copied into +$10-+$17 on every RecomputeCharacterStats
wPlayer2MainPhysicsTemplate:: ds 8

; [4 bytes] Character record +$38-$3b of on-court record for player 2 main: the four trainable levels: Spin, Power, Control, Speed
wPlayer2MainTrainLevels:: ds 4

; [8-bit] Equipment of the player-2 main character (see wPlayer1MainEquipment); the link-match EXP path reads it when the local player is player 2
wPlayer2MainEquipment:: db
	ds 3

; [7 bytes] Display name and record base of the player-2 partner
wPlayer2PartnerName:: ds 7

; [4 bytes] Character record +$07-$0a of on-court record for player 2 partner: name terminator and padding after the 7-character name; the drawer scans to the NUL, so these are read
wPlayer2PartnerNamePad:: ds 4

; [8-bit] Player 2 Current Partner Character; for values see 0xca0b
wPlayer2CurrentPartnerCharacter:: db

; [8-bit] Palette index of the player-2 partner (see wPlayer1MainPalette)
wPlayer2PartnerPalette:: db
; [8-bit] Character record +$0d: gender, 0 male / 1 female (InitPlayerRecordFromTemplate, from StoryCharGenderTable for the story records)
wPlayer2PartnerGender:: db

; [8-bit] Mirror flag of the player-2 partner (see wPlayer1MainLeftHanded)
wPlayer2PartnerLeftHanded:: db

; [9 bytes] Character record +$0f-$17 of on-court record for player 2 partner: AI and physics attributes copied from the ROM record (StoryCharacterRecords_02): +$0f a personality byte, +$10-$17 the reach windows, smash and dive speeds and reaction delays that RecomputeCharacterStats refreshes from the +$30 template
wPlayer2PartnerPhysics:: ds 9

; [8-bit] EXP tier of the player-2 partner (see wPlayer1PartnerExpTier)
wPlayer2PartnerExpTier:: db

; [2 bytes] Character record +$19-$1a of on-court record for player 2 partner: swing attribute word
wPlayer2PartnerSwingAttrWord:: dw

; [4 bytes] The player-2 partner's AI parameter block (see wPlayer1PartnerAiParams)
wPlayer2PartnerAiParams:: ds 4

; [8-bit] Exhibition Mode - CPU Partner Character Difficulty; for values see 0x00ca5f
wExhibitionModeCPUPartnerCharacterDifficulty:: db

; [11 bytes] Character record +$20-$2a of on-court record for player 2 partner: the eleven displayed stat bars 0-9: Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop
wPlayer2PartnerStats:: ds 11
; [8-bit] Character record +$2b: speed bonus, the last byte InitCa00RecordFromCharId copies from the roster row; LoadCharacterAttributes adds it to the Speed stat to pick the shot-placement row
wPlayer2PartnerSpeedBonus:: db

; [3 bytes] Character record +$2c-$2e of the on-court record: EXP, a 3-byte accumulator capped at 99999 by AddExpCapped
wPlayer2PartnerExp:: ds 3
; [8-bit] Character record +$2f: written by InitCa00RecordFromCharId ($02 roster, $03 the story main character, $00 cleared) and read by nothing
wPlayer2PartnerBuildKind:: db

; [8 bytes] Character record +$30-$37 of on-court record for player 2 partner: physics template, copied into +$10-+$17 on every RecomputeCharacterStats
wPlayer2PartnerPhysicsTemplate:: ds 8

; [4 bytes] Character record +$38-$3b of on-court record for player 2 partner: the four trainable levels: Spin, Power, Control, Speed
wPlayer2PartnerTrainLevels:: ds 4
	ds 4

; [8-bit] Story Mode - which of the two story character records the character-select / name-entry / char-data screens are acting on: 0 = main character, 1 = partner. Used as a $40-stride index into the wStoryModeMainCharacter*/wStoryModePartnerCharacter* pair (GetActiveStoryNameBuffer at $38:$73fa returns wStoryModeNameOfMainCharacter or ...OfPartnerCharacter straight off it).
wStoryCharacterSlot:: db

; [8-bit] rSCX the LCD STAT handler applies inside a scanline band, giving the results and cutscene screens a horizontally offset strip. The band's first and last lines live in the two bytes after it, which the credits and window-slide code reuse as a 16-bit camera offset instead - the STAT handler is not running then
wRasterScrollX:: db

; [8-bit] Scanline at which LCDStatHandler starts applying wRasterScrollX to rSCX -- the top of the split
wRasterScrollStartLY:: db

; [8-bit] Scanline at which it puts rSCX back to 0, ending the split. The win/lose screen, the ending credits and the intro cutscene each set their own pair
wRasterScrollEndLY:: db

; [8-bit] Menu cursor column; MoveMenuCursorGrid_3b wraps it at the column count in b
wMenuCursorX:: db

; [8-bit] Menu cursor row; MoveMenuCursorGrid_3b wraps it at the row count in c
wMenuCursorY:: db

; [8-bit] Secondary menu cursor column (parallel to wMenuCursorX; second selection region of the shared menu-input handler)
wMenuCursor2X:: db

; [8-bit] Secondary menu cursor row (parallel to wMenuCursorY)
wMenuCursor2Y:: db

; [8-bit] Menu cursor lock flags: bit 0 / bit 1 freeze the primary / secondary cursor's movement (set on confirm) in the shared menu-input handler
wMenuCursorLockFlags:: db

; [8-bit] Animation step for the current tile set, advanced whenever wAnimatedTileTimer wraps; its low nibble picks the frame
wAnimatedTileFrame:: db

; [8-bit] Frame counter UpdateAnimatedTiles runs against wAnimatedTilePeriod; the tiles only change on the tick where it reaches zero
wAnimatedTileTimer:: db

; [8-bit] Which animated-tile set the shared UpdateAnimatedTiles frame task ($39:$4342) cycles: masked with $03 and used as the index into the two pointer tables at $39:$4403 and $39:$440b. Written (values $00-$03 only) by the screen setup routines that install the task: $10:$4f92 (main menu, 0), $17:$44a6/$44f5 (court diagram, 0), $17:$6f4c (1), $1b:$73e7 (1), $1e:$7333 (1), $3b:$44b3/$496d/$4d03/$5151 (0), $3b:$7a03 (star-chart results, 1), $3e:$49f7/$4abc/$4c2b (link screens, 0), $16:$4a18/$4a30 (match result: 2 on win, 3 on lose, alongside the matching palette load).
wAnimatedTileSet:: db

; [8-bit] Frame period of the animated-tile task: $cb0a counts 0,1,..,period-1 and the animation only steps on the frame it wraps to 0 ($39:$434e-$4363). Written with $03 by almost every caller, $05 at $3e:$4ac1, $06 at $16:$4a6c.
wAnimatedTilePeriod:: db

; [8-bit] Menu loop's copy of hInputPressed (same bit layout as hPlayerInputFlags)
wMenuInputPressed:: db

; [8-bit] Match-format menu: singles (0) / doubles (1) selection; copied to wMatchIsDoubles
wMatchFormatDoubles:: db

; [8-bit] Match-format menu: games-per-set selection index; table-mapped to wMatchTypeNumberOfGames
wMatchFormatGames:: db

; [8-bit] Match-format menu: number-of-sets selection index (0-2); table-mapped to wMatchTypeNumberOfSets
wMatchFormatSets:: db

; [8-bit] Menu transition direction (1 = forward into submenu, 0 = back); direction arg to the *SlideIn/*SlideOut menu transitions
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

; [8-bit] How many button presses of the cheat code have been entered. It indexes the 32-byte buffer at WRAM bank $01 $d000 (masked to $1f) that UpdateCheatCodeEntry compares against CheatCodeEntryTable, and ResetCheatCodeBuffer zeroes both
wCheatCodeLength:: db

; [8-bit] Cell index the main-menu cursor was last left on, so the menu reopens where you were; RunMainMenu restores it through SetMenuCursorFromIndex_3b and stores it back on exit. Cleared with the other saved cursors when a new game starts
wMainMenuCursor:: db

; [8-bit] Saved cursor cell for the saved-data source menu (RunSavedDataSourceSelect)
wSavedDataMenuCursor:: db

; [8-bit] Saved cursor cell for the N64 transfer item menu (RunN64TransferItemSelect)
wN64TransferMenuCursor:: db

; [8-bit] Saved cursor cell shared by the N64 record-type menu and the two court-select menus in bank $3e
wSubMenuCursor:: db

; [8-bit] Selected entry on the minigame-flags debug screen, passed to Unused_1b_UpdateUnlockDebugSelection by address
wUnlockDebugSelection:: db

; [8-bit] Minigame chosen on the minigame-select screen; RunMinigameModeFlow turns it into the config-table row (index * 3 + wMinigameLevel) and RunMinigameRulesPages picks the rules pages from it
wSelectedMinigame:: db
	ds 1

; [8-bit] Zeroed with the other menu cursors each time the main menu loop restarts. Nothing reads it
wUnusedMenuCursor:: db
	ds 1

; [8-bit] Tab the racket/shoes choice menu was left on, so reopening it puts the cursor back
wRacketShoesTabIndex:: db

; [8-bit] The same for the saved-data type select
wSavedDataTypeTabIndex:: db

; [8-bit] Window handle owned by bank $1a's menu code. Stored from the return value of CreateMenuWindowFromText ($1a:$403c) and CreateWindow ($1a:$43c0), then passed in a to Unused_05_RunMenuSelectionShared ($1a:$404b), CloseWindow ($1a:$4070, $1a:$444d), WriteStringToWindow ($1a:$43df/$43f9) and GetWindowStructPtr ($1a:$4149).
wPauseMenuWindowId:: db

; [8-bit] Preset cursor row for the next Unused_05_RunMenuSelectionShared ($05:$4aa8) call: at menu open it is copied into the live row variable ($d830, WRAM bank $05) and then cleared to 0 ($05:$4ad1-$4ad8), so it defaults to row 0. Bank $1a writes the last selected row here ($1a:$41b8/$41ca/$4203/$4232) before rebuilding the pause menu so re-entry restores the cursor; $1a:$4093 clears it when the menu closes for good.
wMenuInitialRow:: db

; [8-bit] Per-row mask of menu rows on which LEFT/RIGHT act as a value adjust: bit 7 = mask present, bits 0-6 = one bit per row (tested by rotating right ($d830)+1 times, $05:$4c77-$4c8e and $05:$4ca3-$4cba). Gates the LEFT/RIGHT branch of the menu driver (Unused_05_IsCursorOnAdjustRow, called at $05:$4bd5) and makes Unused_05_AnimateMenuScrollArrowsTask draw the left/right arrows on that row. Set by bank $1a: $83 (rows 0-1) for the pause menu at $1a:$4249, $8c (rows 2-3) for the minigame pause menu at $1a:$4386; cleared at $1a:$4096.
wMenuAdjustRowMask:: db

; [8-bit] Per-row mask (same bit7-present + rotate-by-row encoding as $cb28) of menu rows that must NOT close the menu window when chosen: after Unused_05_RunMenuSelectionShared returns, $1a:$4057-$406e tests the bit for the chosen row and jumps past the CloseWindow call at $1a:$4070 when set. Written with the same values as $cb28 ($83 at $1a:$424e, $8c at $1a:$4389); cleared at $1a:$409c.
wMenuKeepOpenRowMask:: db

; [8-bit] Pause-menu options state: the low nibble holds the per-option toggle bits the music/sound rows flip, bit 5 gates Unused_1a_DrawPauseMenuSettingValues, and bits 6-7 are set once a row has been visited. Cleared by Unused_1a_ResetPauseMenuState
wPauseMenuOptionBits:: db

; [8-bit] Written as the pause menu opens and read by Unused_1a_RunMinigameModePauseMenu, which is how the shared window knows which pause menu it is running
wPauseMenuIsMinigame:: db

; [8-bit] When nonzero the minigame pause menu is built without setting FLAG_MINIGAME_PAUSE_MENU_OPEN, which is what keeps the scroll-arrow task off that variant
wSuppressMinigamePauseFlag:: db

; [8-bit] Study Vocabulary / Tennis Dictionary screen (bank $3f): index of the first entry shown in the 6-row scrolling term list. Absolute entry = ($cb2d + $cb2e) mod $cb2f (GetTennisDictionarySelectedIndex, $3f:$5181). Advanced/wrapped against $cb2f when the cursor runs off the top/bottom ($3f:$56d6-$56e2, $3f:$5700-$570c), recomputed by the page-jump helpers ScrollTennisDictionaryToPrevLetter/ScrollTennisDictionaryToNextLetter, and used as the render start in DrawTennisDictionaryList ($3f:$528d). Cleared on screen entry at $3f:$40c8.
wTennisDictScrollTop:: db

; [8-bit] Study Vocabulary screen (bank $3f): cursor row within the visible page. On the scrolling term list it is clamped to 0-5 ($3f:$56c6-$56f8) and scrolls $cb2d past those limits; on the 9-cell category index page it is clamped to 0-8 ($3f:$55b0-$55de). Drives the highlight row (stride $80 = 4 tilemap rows, DrawTennisDictionaryIndexCursor) and the hand-cursor sprite Y (stride $10 px, $3f:$4f9a-$4fab). Cleared at $3f:$40cb and reset to 0 by the page-jump helpers ($3f:$51a2, $3f:$522c, $3f:$5495).
wTennisDictCursorRow:: db

; [8-bit] Study Vocabulary screen (bank $3f): number of list entries that pass the current category filter. Computed by CountTennisDictionaryEntries ($3f:$5102-$5116) by counting bytes of SelectionMaskGrid_3f that AND with $cb32 (up to the $40 terminator), and used as the wrap modulus for the scroll offset ($3f:$5181, $3f:$5700, $3f:$51ac).
wTennisDictEntryCount:: db

; [16-bit] Address of the $40 terminator FindTennisDictionaryListEnd found in the selection grid, stored **high byte first** -- +$00 is h and +$01 is l. WrapTennisDictionaryScanToEnd reads it back the same way to wrap a scan round to the last entry
wTennisDictListEnd:: dw

; [8-bit] Study Vocabulary screen (bank $3f): category filter mask. Set from the screen mode at $3f:$40be - $01/$02/$04/$08/$10 for modes 0-4, $1f (all categories) for mode 5 and any other value. Every list walk ANDs it against the per-entry category byte in SelectionMaskGrid_3f to decide whether an entry is listed ($3f:$5102, $3f:$5295, $3f:$5339, $3f:$5422, $3f:$547c, $3f:$51a5, $3f:$522f, $3f:$5625).
wTennisDictCategoryMask:: db

; [8-bit] Set to 1 in the two Study Vocabulary modes ($05 and $06) that show one fixed entry rather than the scrolling list, which is what makes the description path skip GetTennisDictionarySelectedIndex
wTennisDictSingleEntry:: db

; [8-bit] Study Vocabulary screen (bank $3f): the mode argument passed in a to TennisDictionaryScreen, stored at $3f:$4082. Modes 0-5 pick the category mask in $cb32 and open the term list directly; mode 6 (the only value used in the retail flow, $10:$54b8) opens the 9-cell category index page instead - checked at $3f:$40f0, $3f:$412a, $3f:$4ed4 (index-page sprite animation) and $3f:$56ab (B-button return code $10 vs $01).
wTennisDictMode:: db
	ds 2

; [8-bit] Study Vocabulary screen (bank $3f) display flags, cleared at $3f:$40c5. bit 0 = a description window is open: set at $3f:$5620 before CreateDialogueWindow, cleared at $3f:$5699/$413a, and freezes the hand-cursor animation counter $cb3e ($3f:$4f8c). bit 1 = the scrolling term list is on screen (set $3f:$414d/$41d0, cleared $3f:$421a for the index page); gates drawing of the cursor sprites ($3f:$4f85) and shifts the index-page sprites by $10 px ($3f:$4f1f/$4f3a/$4f55/$4f70). bit 2 / bit 3 = flash the left / right page arrow this frame - set on LEFT ($3f:$571b) and RIGHT ($3f:$5731), drawn from UpdateTennisDictionarySprites_SpriteTemplate0 at X $18 / $88 ($3f:$4fc9/$4fdc), and both cleared at the top of every input tick ($3f:$560a).
wTennisDictFlags:: db

; [8-bit] Animation state of the tennis-dictionary mascot: 3 and 4 alternate on a wTennisDictAnimTimer expiry, and StartTennisDictionaryAnim restarts it from the VBlank counter's low bits so the pose varies
wTennisDictAnimState:: db

; [8-bit] Eight-frame divider for the Study Vocabulary demo sprite: UpdateTennisDictionarySprites counts it down, reloads $08 and steps wTennisDictSpritePhase each time it reaches zero
wTennisDictSpriteTimer:: db

; [8-bit] Phase 0-15 of the Study Vocabulary demo sprite animation, wrapped at $10
wTennisDictSpritePhase:: db
	ds 2

; [8-bit] Frames left in the current wTennisDictAnimState; $b4 on a restart and $ff for the long idle
wTennisDictAnimTimer:: db

; [8-bit] Second animation counter for the tennis-dictionary screen, stepped only while wTennisDictFlags bit 1 is set and bit 0 is clear -- the list is scrolling and not yet settled. TennisDictionaryScreen seeds it when the screen opens
wTennisDictScrollTimer:: db

; [8-bit] Bank $6b cutscene driver (intro/title/award ceremony): current step index, dispatched through the per-scene jumptable
wCutsceneStep:: db

; [8-bit] Bank $6b cutscene driver: frame counter for the current step; incremented per frame and compared against per-step thresholds to advance wCutsceneStep
wCutsceneStepTimer:: db

; [8-bit] Intro Cutscene Check (0x00 when in intro cutscene, 0x01 otherwise)
wIntroCutsceneCheck:: db

; [8-bit] Bank $6b cutscene driver: accumulated horizontal pan position, copied to hScrollX each frame
wCutsceneScrollX:: db

; [8-bit] Sub-state within the intro cutscene's current state; the State*Init routines seed it and the matching State*Update routines step it
wIntroCutsceneSubState:: db

; [8-bit] X of the intro cutscene's first sprite group; the state Update routines walk it and QueueCutsceneSpriteGroupA adds each template's offset to it
wCutsceneSpriteAX:: db

; [8-bit] Y of the intro cutscene's first sprite group
wCutsceneSpriteAY:: db

; [8-bit] X of the intro cutscene's second sprite group (QueueCutsceneSpriteGroupB)
wCutsceneSpriteBX:: db

; [8-bit] Y of the intro cutscene's second sprite group
wCutsceneSpriteBY:: db

; [16-bit] Running scroll position for the intro cutscene: UpdateCutsceneScrollY subtracts this frame's CutsceneScrollYTable entry from it each tick, and QueueScrollingSprite places sprites against it
wCutsceneScrollAccum:: dw

; [16-bit] Intro cutscene (bank $6b): world-space vertical scroll/camera position, little-endian. Initialised to $0120 at the start of scenes 00/12/19 ($6b:$41bf, $6b:$4916, $6b:$4c65) and decremented every frame by the per-frame delta table at $6b:$4cc1 indexed by wCutsceneStepTimer ($6b:$4caa-$4cbd). Consumers: ApplyCutsceneScrollToSpriteX ($6b:$5191) subtracts it from the sprite base coordinate that QueueSpriteTemplate treats as Y (the sp+0 slot, $00:$1ebf - so despite the existing label it is the Y axis), and SetCameraYFromScrollPos ($6b:$60d5) shifts it left 5 into wCameraY. $6b:$60fe uses ($cb48 - $cb4a) as the on-screen Y of the object drawn by QueueIntroSpriteBlock.
wIntroCutsceneScrollY:: dw

; [8-bit] Animation frame the intro cutscene's scrolling sprites are drawn on, derived from wCutsceneSpriteAnimTick's bits 4-5 shifted down, so it steps once every 16 ticks
wCutsceneSpriteAnimFrame:: db

; [8-bit] Free-running counter AdvanceSpriteAnimTimer increments each call; the intro cutscene state inits clear it together with wCutsceneSpriteAnimFrame
wCutsceneSpriteAnimTick:: db
	ds 1

; [8-bit] Idle-animation state of the character-select portrait, cleared everywhere wCharSelectIdleTimer and wCharSelectHandedness are (screen setup, page reload, and after a fresh animation is set) and stepped by TickCharSelectIdleAnim when the timer expires
wCharSelectIdleAnimState:: db

; [8-bit] Story-mode character-select screen (bank $38): handedness toggle, 0 = default, 1 = mirrored (left-handed). Cleared on entry ($38:$4815, $38:$4984, $38:$4a82) and flipped by START ($38:$48fc `xor $01`) - the on-screen prompt for that row is text 30:118 'START: Change Hands' ($38:$4b0c). When non-zero, DrawCharacterSelectChars sets bit 5 (OAM X-flip) in wCharSpriteSlot+1 for all four displayed characters ($38:$4c6f-$4ca6), and DrawCharacterSelectCursor draws the marker sprite with tile base $00 instead of $02 ($38:$4e3c). The chosen value is written into the story character record at +$0e ($38:$48ba).
wCharSelectHandedness:: db

; [8-bit] Frames until the character-select portrait plays its idle animation: TickCharSelectIdleAnim counts to $0f, then switches the shown character from animation 5 to 7 and starts again
wCharSelectIdleTimer:: db

; [8-bit] Story-mode character-select screen (bank $38): which pick is in progress - 0 = main character, 1 = partner. Stored from the b argument of RunCharacterSelectScreen ($38:$47d0; callers pass 0 at $10:$40bb and $1b:$61fa, 1 at $1b:$629b). Selects the prompt text (0 -> text 30:117 'Pick a Character' at $38:$4ae8, 1 -> text 30:119 'Choose Partner' at $38:$4afb), swaps in mugshots 2/3 and repositions the two character sprites ($38:$4a27, $38:$4c13), and is doubled into the character id: id = 2*$cb52 + cursor ($38:$4896, $38:$4958, $38:$4e09).
wCharSelectIsPartner:: db

; [8-bit] Court-select: the link partner's bonus-court unlock mask, received over the cable. Cleared at $10:$5171 for local play; set at $38:$75ef/$75f7 from the received link block ($ca8a or $ca0a depending on hLinkState) right after the block-$26 exchange that sends our own $cb54 ($38:$759c). ORed with $cb54 before StoreCourtUnlockBits ($3e:$5d18, $3e:$65db) and before choosing the 9-court vs 4-court menu ($38:$748d).
wLinkPartnerCourtMask:: db

; [8-bit] Bitmask of the five unlockable bonus courts (court ids 4-8; courts 0-3 are always available per IsCourtUnlocked $3e:$697b). Built from the save flags by ComputeUnlockedCourtFlags ($3e:$69a0-$69c9, one bit per row of the 5-entry table at $3e:$69ca) and cleared at $10:$5174. Passed in b to StoreCourtUnlockBits ($3e:$695a), which explodes it into the five per-court bytes at $d000 in WRAM bank $02; also decides whether the 9-court or the 4-court select menu runs ($10:$5199, $38:$7489) and is the payload of link block $26 ($38:$759c).
wUnlockedCourtMask:: db

; [4 bytes] The other Game Boy's packed unlock flags, filled by the ExchangeLinkDataBlock that sends wLinkUnlockFlagsSend. MergeLinkUnlockFlags folds the two together so both sides end up with the union of what each has unlocked
wLinkUnlockFlagsRecv:: ds 4
	export_size wLinkUnlockFlagsRecv

; [4 bytes] This side's unlock flags, packed one bit per character by PackUnlockFlagsForLink before the exchange
wLinkUnlockFlagsSend:: ds 4
	export_size wLinkUnlockFlagsSend

; [8-bit] One bit per Mario-cast grid slot, built by BuildMarioCastUnlockMask from six passes and read by GetUnlockedMarioCastCharAtGridSlot to skip locked slots
wMarioCastUnlockMask:: db

; [8-bit] Actor slot SpawnCompanionActor is filling -- 3 in doubles, $ff in singles, which is how it knows to skip attaching the step-mover
wCompanionActorSlot:: db

; [8-bit] Written as RunStoryModeOverworld starts and read by nothing
wOverworldEnterFlag:: db

; [8-bit] Frame counter of bank $03's scrolling story cutscene. AnimateWindowSlideUpTask increments it and drives rWY from $90 minus its low 6 bits, sliding the window up; UpdateSceneAnimation takes its low 2 bits as the gate that steps the cutscene's animation frame
wCutsceneSlideTimer:: db

; Dirty flags for the bank $18 BG map shadow buffers: low nibble set -> queue $d800->$9800 tilemap copy, high nibble -> $dc00->VRAM1 $9800 attrmap copy (Unused_18_FlushBgMapShadowToVram clears it).
wBgMapShadowDirty:: db

; [8-bit] Debug character viewer (Unused_1a_RunDebugCharViewer, reachable only from the unused debug path at $01:$41bf/$41fd with hDebugStepMode set): page of the 2x16 character grid, 0 or 1. Cleared at $1a:$67d5, incremented/decremented when the cursor wraps off the bottom/top row ($1a:$695f, $1a:$698f), and combined into the selected character id as ($cb62 << 4) + $cb63 -> $d002 ($1a:$69d0-$69dc), which is then fed to LoadOnCourtCharTilesA ($1a:$6837).
wDebugCharViewerPage:: db

; [8-bit] Debug character viewer (Unused_1a_RunDebugCharViewer): cursor index 0-15 within the current page - LEFT/RIGHT step by 1 and wrap inside the current row of 8 ($1a:$691b-$692d, $1a:$6934-$6945), UP/DOWN step by 8 and roll into $cb62 ($1a:$694c, $1a:$6979). Selected character id = ($cb62 << 4) + $cb63 ($1a:$69d8). Also indexes the cursor-sprite position table at $1a:$6b0f ($1a:$6af9).
wDebugCharViewerIndex:: db

; [7 bytes] Per-digit working bytes for the number-sprite drawer, cleared by InitNumberSpriteGfx alongside wDigitSpriteTileBase and wDigitSpriteAttr
wDigitSpriteSlots:: ds 7
	export_size wDigitSpriteSlots

; [8-bit] First tile of the loaded digit sprite set; DrawDigitSprite_39 forms the tile as digit * 2 + this, so the narrow and wide digit sets can share one drawer
wDigitSpriteTileBase:: db

; [8-bit] OAM attribute DrawDigitSprite_39 queues digits with
wDigitSpriteAttr:: db

; [8-bit] Scene selector RunStorySceneByMode stores from c ($18:$7617); each LookupScreen<N>AssetId indexes its Screen<N>AssetIdTable with it to pick the screen's asset record
wStorySceneAssetIndex:: db

; [16-bit] Rules/briefing screens: base text id of the minigame's rules pages, taken from MinigameRulesTextIdBases_17 ($17:$6fdb) at $17:$6fc6. Each page offset from the minigame's MinigameRulesPageLists_17 row is added to it ($17:$70ef) and the result rendered through PrepareGlyphBuffer / RenderProportionalTextAt.
wRulesPageTextIdBase:: dw

; [8-bit] Written twice by RunMinigameSelect and read by nothing
wMinigameSelectUnused:: db

; [8-bit] Set to 1 once the cheat code has been matched and TriggerCheatUnlock has run, which stops UpdateCheatCodeEntry accepting any more input. The title and main-menu loops clear it when they re-enter
wCheatUnlockTriggered:: db

; [8-bit] Frames the link character-select screen waits before it accepts input; WaitLinkSelectStartupFrames counts it down
wLinkSelectStartupFrames:: db

; [8-bit] Which stage RunMatchWinLoseScreen is in, set as the screen opens and branched on twice as it plays out
wMatchWinLoseState:: db

; [8-bit] Sub-state of the first match-select handler, set on two paths and read back once
wMatchSelectSubState:: db

; [8-bit] Next window tile id the text engine will stamp into the shadow tilemap. A row starts at wGlyphRowStartCol + $80 and the cell loop increments it per cell before writing it back, so a wrapped row carries on where the previous one stopped
wTextRowNextTile:: db

; VRAM tile-data write pointer for the proportional-glyph renderer (bank $05 text engine)
wGlyphTileWritePtr:: dw

; [8-bit] Nonzero when the text being rendered belongs to a window other than wMenuWindowId, which is the condition StampGlyphTileAtPen requires before it writes a glyph tile through wGlyphTileWritePtr. Menu text goes through the tilemap alone
wGlyphStampEnabled:: db
	ds 119

; [8-bit] Court-scene graphics still to queue; the loader decrements it each pass and stops once it hits zero
wCourtSceneGfxStepsLeft:: db

; [8-bit] Byte offset into CameraFromPlayerSpriteList, advanced 4 at a time (one record) and wrapped to 0 when the record reads $ff
wCourtSceneGfxCursor:: db
	ds 14

; [576 bytes] Debug text console tilemap buffer, DMAed to $9d00 rows when active
wDebugTextBuffer:: ds 576
	export_size wDebugTextBuffer

; The top of WRAM0, shared by two things that never run together: the
; serial link's nibble staging and the character-select roster. Scoped to
; the owning ROM bank.
UNION
; serial link nibble staging (bank $07)
; [96 bytes] The block being exchanged, one nibble per byte. Both directions refuse a count that would take it past $5f nibbles. UnpackBytesToNibbles fills it from wLinkByteBuffer and PackNibblesToBytes folds it back
wLinkNibbleBuffer:: ds 96
; [48 bytes] The packed form of the same block -- two nibbles per byte -- which is what the caller reads and writes
wLinkByteBuffer:: ds 48
	ds 48
NEXTU
; character select roster (bank $1b)
; [128 bytes] Copy of CharSelectRosterTable, the grid of character ids the select screen and the unlock-debug screen page through. Unused_1b_FindCharSelectRosterEntry searches it and Unused_1b_DrawCharSelectMugshots walks it
wCharSelectRoster:: ds 128
	export_size wCharSelectRoster
ENDU


SECTION "WRAMX bank 1", WRAMX[$d000], BANK[1]

; WRAMX bank 1 at a glance:
;
;   $d000-$dfff  cutscene text scroll buffer / character record copy / VRAM staging

; WRAM bank $01 is staging for VRAM, and almost nothing else: every screen
; in the game decompresses into it and then QueueVRAMCopies out of it.
; What a given offset means therefore depends on what the current screen
; put there -- tile graphics, a tilemap plane, its attribute plane -- so
; the two halves get names and the offsets do not. Every offset in use is a
; whole multiple of TILE_SIZE, which is why they render as tile indices.
; Scoped to a provable WRAM bank $01: $d000 is eight different things and
; twenty ROM banks stage through this one.
; The one overlay with a fixed meaning is bank $1b's character-record copy:
; LoadCharacterRecordToBuffer writes $d580 in whichever bank the caller left
; selected, and bank $1b selects this one, so the record lands on top of the
; staging buffer while the new-game roster is being built.
; ShowDmgLockoutScreen (bank $01, $6034-$6068) is scoped here by range without a
; WRAM bank: it only runs on a DMG, where rWBK does not exist and $d000-$dfff
; is the single upper half of WRAM -- the bytes a CGB calls bank 1. The lockout
; screen stages its tiles there and copies them to VRAM like every other screen.
UNION
; cutscene text scroll buffer (bank $03)
; [640 bytes] Eight 80-column rows of rendered cutscene text in WRAM bank $01: DrawCutsceneTextLines draws each line into it from column 19 of row 1 on, and BlitCutsceneTextWindow copies a 20-column window of it, one column further along per call, into wWindowShadowTilemap to scroll the text across the window. Both routines select the bank themselves, so the sites are scoped by range
wCutsceneTextScrollBuffer:: ds 640
	ds 3456
NEXTU
; character record copy (bank $1b)
	ds 1408
; [128 bytes] Copy of a character record that LoadCharacterRecordToBuffer takes from wPlayer2MainName, so a caller can read one character's fields without disturbing the live records. +$0b is the id CheckCharacterUnlocked tests against $ff, and RunNewGameSetup reads +$0c and +$0e for each of the four starting characters
wCharRecordBuffer:: ds 128
NEXTU
; VRAM staging (WRAM bank $01)
; [2048 bytes] Where DecompressData lands and QueueVRAMCopy reads from. A screen may slice it several ways at once -- the cutscene frame loaders keep six frames at tiles 0, 4, 8, 12, 14 and 16, while the EXP screen puts a tilemap plane at tile 0 and its attributes at tile 64. Unused_00_CopyMapToScrollBuffers reads the map planes back out of it to expand them into WRAM bank $02
wDecompBuffer:: ds 2048
; [2048 bytes] The other half, where Unused_1a_DrawStringToTileBuffer renders a string as tile data rather than as tilemap cells -- the EXP screen's captions and bonus messages are built here and uploaded like any other graphics
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

; WRAM bank $02 holds tilemap planes, and until now not one byte of it had
; a name -- it was the only WRAMX bank with no SECTION at all. Three
; subsystems use it three different ways, so $d000 is a tile plane, an
; attribute plane or a 64-wide scroll buffer depending on who is asking:
; the match keeps the court tilemap and attrmap here as a pair, the
; overworld builds two of its four wide scroll planes here, and every
; full-screen UI uses $d000 as the attribute half of the tilemap whose
; tile half is wShadowTilemap in WRAM bank $03.
; Every scope carries wram_bank $02 as well as its ROM bank, and the common
; screen case is scoped rather than a default. A default variant here was
; the first thing tried and it was wrong twice over: it named the bank $07
; save-editor window at $d300 as an attribute cell, and bank $08 reaches
; both this bank and WRAM bank $04 -- RefreshCourtScoreboard's $de9x bytes
; are not court planes at all.
; The match owns the court planes from two more banks, over instruction
; ranges rather than whole banks. Bank $06's in-match UI restores and
; flushes them: ShowMessageWindow and the pause menu select WRAM bank $02
; and then call RestoreBgTilemap / RestoreBgTilemapRegion /
; FlushTilemapToVram, which is why $d000 there is the tile half sent to VRAM
; bank 0 and not the attribute plane the whole-bank variant below would name
; it. Bank $0a's LoadCourtSceneGraphics decompresses the court into the
; saved pair at $d800/$dc00 before the match starts.
; Bank $0d gets a whole-bank scope like $08's, and it is the one bank that
; names all four planes in one routine: LoadMatchUiCourtTilemap pushes the
; target-zone overlay's tile and attribute halves twice each and CopyTextRects
; them to $d12b, $d92b, $d52b and $dd2b, tiles to the two tilemaps and
; attributes to the two attrmaps. QueueMinigameHudVRAMCopy says the same with
; the VRAM bank bit: $d120 goes to $9920 and $d520 to $9920 + VRAM_BANK1.
UNION
; N64 block presence probe (bank $3b)
; [2 bytes] The first two bytes of save block $0b as staged here before CheckN64DataPresent runs; non-zero means Transfer Pak records exist, which is what unlocks the N64 entries on the status menu
wN64BlockProbe:: dw
	ds 4094
NEXTU
; match court planes (banks $08/$0d/$06/$0a)
; [1024 bytes] The court tilemap the match renders from; UploadCourtTilemap sends it to $9800 in VRAM bank 0. Held in WRAM bank $02 rather than the usual $03 because the match owns bank $03 for other things
wCourtTilemap:: ds 1024
	export_size wCourtTilemap
; [1024 bytes] Its CGB attribute plane, cell for cell, uploaded to $9800 in VRAM bank 1 by UploadCourtAttrmap
wCourtAttrmap:: ds 1024
	export_size wCourtAttrmap
; [1024 bytes] Copy of the court tilemap taken when the players change ends. SnapshotCourtTilemaps copies it back over wCourtTilemap to restore the un-flipped view
wCourtTilemapSaved:: ds 1024
; [1024 bytes] The attribute half of the same snapshot
wCourtAttrmapSaved:: ds 1024
NEXTU
; overworld scroll buffers (bank 0)
; [1024 bytes] One of the four 64-wide planes Unused_00_CopyMapToScrollBuffers expands the map into, 16 rows of 64 cells. The narrow source comes from wDecompBuffer in WRAM bank $01 through wTextBuffer, a row block at a time
wMapScrollPlane0:: ds 1024
	ds 1024
; [1024 bytes] The second plane, built the same way and then immediately cleared -- 2048 bytes of it, twice what was written. wScreenScratch in WRAM bank $03 gets the same treatment, so two of the four planes are assembled and thrown away
wMapScrollPlane1:: ds 1024
NEXTU
; screen attribute plane
; [1024 bytes] CGB attributes for the full-screen UIs, cell for cell with wShadowTilemap in WRAM bank $03 -- the pair is what FlushCharDataTilemapChunk sends to $99e0 in VRAM banks 0 and 1. Seventeen ROM banks write cells here, which is why it is the default rather than a scoped variant. The page images the character-data screens patch from sit above it and keep their numeric addresses, being cells in two banks at once. The three bank $1e ranges are the EXP award screen's first argument to a plane writer that selects both banks itself -- FillTilemapRun stores the tile under WRAM bank $03 and the attribute under $02, WriteTextToTilemap and RenderProportionalTextAt likewise -- so at the head of DrawExpTotalPanel, DrawExpMessageWindow and the two message lines of DrawNextExpAwardMessage the live bank is the caller's ($06, or unprovable) and not the operand's. Each of those routines' later cells already render from a provable bank $02, only because FillTilemapRun happens to leave it selected on return
wScreenAttrmap:: ds 1024
	export_size wScreenAttrmap
NEXTU
; character record scratch (banks $18/$1b/$3b)
	ds 1408
; [128 bytes] The character record a menu is about to draw. LoadCharacterRecordToBuffer asks LoadCharacterRecordToCa80 to build the record and then copies 128 bytes of it here from wPlayer2MainName, so the fields line up with that block: +$0b is the character id (wPlayer2CurrentMainCharacter's offset), which is what CheckCharacterUnlocked tests against $ff and what the mugshot and portrait loaders take as their index. The `.fixedRecord` shortcut writes $3e straight into +$0b without loading anything.
; Scoped to instruction ranges rather than a WRAM bank because the bank is never selected at the reference: bank $3b's BuildSaveSlotSummaries is the one caller that says it out loud, running `wram_bank $02` on both sides of the call, and the reads have to be in the bank the write went to.
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

; Screen tilemap buffers, WRAM bank $03. The full-screen UIs assemble their
; BG map at $d000 and its CGB attributes at $d400 -- 32 x 32 cells each, rows
; TILEMAP_WIDTH apart, of which the top-left 20 x 18 is on screen -- then
; QueueVRAMCopy them to $9800 in VRAM banks 0 and 1. Not every screen pairs
; the planes this way: the bank $03 cutscenes keep the attribute plane at
; $d000 in WRAM bank $02 instead, which is why these names are scoped to a
; provable WRAM bank $03 rather than to the addresses.
; wShadowTilemapBank / wShadowTilemapPtr point the text engine at whichever
; bank the current screen uses ($03 for screens, $05 for text windows, $02 for
; the match). Cell addresses render as `base + row * TILEMAP_WIDTH + column`,
; which is what they are.
; The ranking board's row and marker drawers are one shape repeated behind a
; jump table; rows 0-8 and markers 1-4 were traced in WRAM bank $03, and
; rows 9-11 and markers 5/6 -- which no ShowRankingBoard argument selects --
; are scoped by range on the strength of their siblings.
; screen tilemap (any bank, where WRAM bank $03 is provable)
; [1024 bytes] BG tile map the screen is being assembled into, 32 x 32 cells
; with rows TILEMAP_WIDTH apart; CopyTilemapRect steps rows by $0020
wShadowTilemap:: ds 1024
; [1024 bytes] CGB attribute plane for wShadowTilemap, same geometry $400
; higher; SetWinLosePortraitPaletteAttrs writes $d48b for the cell whose
; tile byte is $d08b
wShadowAttrmap:: ds 1024

; Screen-local scratch in WRAM bank $03, low half. Like the $d810 block above
; each full-screen UI reuses these bytes, so the variants are scoped to the
; owning ROM bank (and, where one bank runs several screens, to that screen's
; code range).
; The minigame data screen and the trophies screen each lay an array across
; $d810, so their first symbol here is declared only as far as this block
; reaches and the rest of the screen sits in the $d810 union under a variant
; of the same name.
UNION
; link error flash palette (bank $3e)
; [8 bytes] One 4-colour palette AnimateLinkErrorPalette rebuilds each frame for the link-error screen, colour 1 (+2) replaced from a flash table indexed by the frame counter, then uploaded through LoadPaletteShadow as palette 3
wLinkErrorPalette:: ds 8
	export_size wLinkErrorPalette
	ds 8
NEXTU
; equipment select (bank $3e, $5400-$5c00)
; [8 bytes] Item ids the player owns, compacted by BuildOwnedItemList from wEquipOwnedMap; the cursor indexes this list
wEquipItemList:: ds 8
	export_size wEquipItemList
; [8 bytes] One byte per item slot: 0 not owned, 1 owned, 2 owned and equipped. MarkOwnedRackets / MarkOwnedShoes fill it from the save data
wEquipOwnedMap:: ds 8
	export_size wEquipOwnedMap
NEXTU
; name entry (bank $38, $6e00-$7500)
; [11 bytes] Name being typed, terminated by $00; AppendCharToName / DeleteLastNameChar edit it and RunNameEntryScreen copies it into the character record on accept ($de is the blank-cell filler). Eleven bytes, not the eight the visible cells suggest: every copy in or out of it is `ld bc, $000b`, and TrimTrailingSpacesFromName starts its backwards scan at the last of them
wNameEntryBuffer:: ds 11
	export_size wNameEntryBuffer
NEXTU
; match results (bank $16)
; [8-bit] 1 if the player won the match just played, 0 if not; written beside wResultScreenMode by RunMatchWinLoseScreen and used by LoadWinLoseScreenAssets / LoadResultScreenTileGraphics to pick the graphics set
wResultScreenWon:: db
; [8-bit] Stored from a by RunMatchWinLoseScreen and RunMatchStatsScreen; SetWinLosePortraitPaletteAttrs and LoadResultPortraitSlot branch on it
wResultScreenMode:: db
NEXTU
; ranking board (bank $1b)
; [8-bit] Nonzero shows the doubles ranking rather than the singles one; ShowRankingBoard takes it from b, and it picks both the screen asset record and Draw/HighlightSinglesRankingRows vs the doubles pair
wRankingBoardDoubles:: db
; [8-bit] Which ranking row is the player's, from c; the highlight and the marker animation address the board through it
wRankingBoardPlayerRow:: db
; [8-bit] How the board is presented, from d: 0 plain, 1 plays fanfare $2b, 2 plays the second fanfare and registers RankingCursorBobTask. A 3 is turned back into 0 with w3_d85a set instead
wRankingBoardMode:: db
; [8-bit] Base of the ranking marker slots: twelve 4-byte records, $d803-$d832, so the array runs past this block into the $d810 one. GetRankingMarkerSlot returns base + index * 4 and DrawRankingMarkersTask walks all twelve, skipping any whose +0 reads $ff and queueing the rest as a sprite with +0 the tile, +1 the X and +2 the Y. ClearRankingMarkerSlots clears the $30 bytes of the array and LoadRankingMarkerCoords copies $30 bytes of coordinates over it; the separate $53-byte clear at the head of BuildRankingBoardScreen is wider than the array -- it wipes the whole screen's state from here up to wRankingBannerAnimFrame, animation channels included
wRankingMarkerSlots:: db
NEXTU
; trophy / N64-tournament / bracket screens (bank $3b)
	ds 1
; [8-bit] Page the bank $3b data screens are showing; DrawN64TnmtPageLabels and the bracket builders key off it and N64TnmtScrollArrowsTask decides from it which scroll arrows to draw
wDataScreenPage:: db
; [8-bit] Cursor row within the page, stepped by ScrollN64TnmtDataCursor
wDataScreenCursorRow:: db
NEXTU
; minigame data screen (bank $1b, $73dd-$78bd)
	ds 9
; [7 of 9 bytes] One byte per list row, nonzero when that row's minigame has its level-1 clear flag. LoadMinigameClearFlags clears nine bytes here and walks MinigameClearFlagsTable ($0280/$02e0/$0340/$03a0/$0500/$0560/$05c0/$0620/$0680 -- the SAVEFLAG_CLEARED_*_1 of Boo Blast through Two-On-One) through TestSaveFlag; DrawMinigameClearMarks indexes it by wMenuCursorY and draws mark 0 for each of the five visible rows. Only seven of the nine bytes are declared here: the array runs to $d811, two bytes past this block and into the $d810 one
wMinigameDataClearFlags:: ds 7
NEXTU
; trophies screen (bank $3b, $49e5-$4cfa)
; [6 bytes] One trophy row: six cells, each 0 or 1, drawn as one icon per set cell by DrawTrophyRowPair (three cells, a gap, three more). DecodeTrophyCounts fills the first three from wN64TrophyCounts bits 0-1 and the second three from bits 4-5, one `1` per unit of the 0-3 count. This row is the main character's first set -- DrawTrophiesWonRows draws it where DrawTrophiesCharSprite has just put wStoryModeMainCharacterOverworldSprite
wTrophyCellsMainSet1:: ds 6
; [6 bytes] The partner's first-set row, from wN64TrophyCounts + 1 bits 0-1 and 4-5; drawn beside wStoryModePartnerCharacterOverworldSprite
wTrophyCellsPartnerSet1:: ds 6
; [4 of 6 bytes] The main character's second-set row, from wN64TrophyCounts bits 2-3 and 6-7. Only drawn when wTrophySecondSetPresent, which is what turns the screen from two rows into four. Four of the six bytes are declared here: the row runs to $d811, two bytes past this block and into the $d810 one
wTrophyCellsMainSet2:: ds 4
NEXTU
; title screen (bank $6b)
	ds 1
; [8-bit] Frame of the title screen's animated sprite; QueueTitleSprite reads it and StepTitleSpriteAnimation advances it
wTitleSpriteFrame:: db
; [8-bit] Frames left on the current title sprite frame
wTitleSpriteTimer:: db
NEXTU
; screen scratch (any other screen, where WRAM bank $03 is provable)
; [8-bit] Base of the screen-local scratch block in WRAM bank $03. Screens
; with no named variant here still use it as their working buffer -- an
; object array (bank $18), a decompression staging area (banks $1b/$39), a
; cursor or mode byte (banks $3b/$6b) -- so this only records where the
; block starts. Sites whose WRAM bank compute_wram_bank cannot prove keep
; the bare address.
wScreenScratch:: db
ENDU

; Screen-local state in WRAM bank $03: each full-screen UI reuses these
; bytes for its own purpose, so the variants are scoped to the ROM bank
; that owns the screen rather than to the WRAM bank -- banks $16/$17/$38
; all select WRAM bank $03 here, and most sites select it in a callee so
; compute_wram_bank cannot prove it at the reference.
UNION
; N64 tournament data screen (bank $3b)
; [16 bytes] Copy of N64TnmtData taken by LoadN64TnmtDataRecords. +$0e and +$0f are the singles and doubles column masks: forced to $10 when bit 0 / bit 1 of the records block's byte +344 is clear, i.e. when that half of the tournament has no data
wN64TnmtLayout:: ds 16
	export_size wN64TnmtLayout
	ds 16
; [12 bytes] First of 16 rows of 12 cells, one row per character in N64CharTrophyRowPtrTable order, filled by BuildN64TnmtTrophyGrid from DecodeN64CharTrophyCounts; the rows run on to $d8ef. CheckN64TnmtSecondPage scans +2 and +5 of the first fourteen rows to decide whether a second page exists
wN64TnmtTrophyCells:: ds 12
	ds 3
NEXTU
; erase-confirm flash palette (bank $3e)
; [8 bytes] One 4-colour palette AnimateEraseConfirmPalette rebuilds every frame from EraseConfirmPalette_3e and uploads as palette 4 through LoadPaletteShadow; colour 2 (+4) is replaced each frame from EraseConfirmFlashColors_3e indexed by hVBlankCounter -- the warning text flashing on the erase-confirm screen
wEraseConfirmPalette:: ds 8
	export_size wEraseConfirmPalette
NEXTU
; drill briefings (bank $17)
; [8-bit] Drill-briefing diagram: player sprite X, queued by DrawBriefingPlayerSprite (d = X, e = Y in QueueSprite)
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
; [8-bit] Drill-briefing animation step; each briefing's *_AdvanceAnim wraps it (and a & $03) and indexes its 4-byte-per-step position table with it
wBriefingAnimStep:: db
	ds 1
; [8 bytes] Drill-briefing target palette scratch: CycleDiagramTargetPaletteData copied here, colour 2 ($d834) replaced with the cycling colour, then uploaded by LoadPaletteShadow
wBriefingTargetPalette:: ds 8
	export_size wBriefingTargetPalette
NEXTU
; character-select grid (banks $38/$10)
	ds 1
; [8-bit] Character-select grid: top row currently shown (wMenuCursorX/Y address the cell within it); MoveCharGridCursor* wrap it and rebuild the page sprite list
wCharGridPage:: db
; [8-bit] Character-select grid: number of pages, looked up from wCharGridEntryCount through CharGridPageCountTable
wCharGridPageCount:: db
; [8-bit] Character-select mode id stored on entry by RunExhibitionCharSelectScreen / RunLinkCharSelectScreen; picks the slot-box table and the starting slot (3 and 5 start at slot 2)
wCharSelectMode:: db
; [8-bit] Character-select: player slot being chosen (0-3); $04 means every slot is filled and the screen shows the wait banner
wCharSelectSlot:: db
; [8-bit] Character-select result polled by the frame loop: 0 keep running, 1 finished, 2 cancelled out
wCharSelectExitCode:: db
; [4 bytes] Character id chosen for each player slot ($ff = empty); ResolveSelectedCharIds and InitMatchCharsFromSelection read it. Bank $10's CopyExhibitionCharSlotIds copies all four out to wMatchSlotCharRefs once the screen is done, which is the only reference to this block from outside bank $38
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
; [8-bit] Character-select grid: entries present in the nine created-character rows at $da00 (counted alongside wCharGridEntryCount)
wCharGridCreatedCount:: db
; [8-bit] Set when the slot just filled needs the CPU-difficulty submenu; the frame loop runs RunCpuDifficultySubmenu instead of normal input while it is set
wCpuDifficultyPrompt:: db
; [8-bit] Set once OpenCpuDifficultyPanel has drawn the panel, so the submenu only opens it on the first pass
wCpuDifficultyPanelOpen:: db
; [8-bit] Cursor value in the CPU-difficulty submenu; stored into wCharSelectSlotDifficulty on confirm
wCpuDifficultyCursor:: db
	ds 9
; [4 bytes] CPU difficulty chosen per player slot; ApplyCpuDifficultyToCharRecords copies it into the match character records
wCharSelectSlotDifficulty:: ds 4
; [4 bytes] Left-handed flag per player slot, toggled with START on the character grid (only the nine Mario-cast characters may be toggled). ApplyHandednessToCharRecords copies it to the four match records' +$0e, which LoadCharacterAttributes turns into wCharMirrorAttrMask -- the OAM X-flip plus the forehand/backhand swap in SelectForehandBackhand
wCharSelectSlotLeftHanded:: ds 4
; [8-bit] Link character-select: result byte ProcessLinkSelectCommand leaves for commands $24-$27
wLinkSelectCmdResult:: db
; [8-bit] Link character-select: CPU difficulty for the link match, stepped by Unused_38_HandleLinkCpuDifficultyInput
wLinkCpuDifficulty:: db
NEXTU
; equipment select (bank $3e, $5400-$5c00)
; [8-bit] Number of entries BuildOwnedItemList put in wEquipItemList
wEquipItemCount:: db
; [8-bit] Index within wEquipItemList of the item currently equipped (the slot BuildOwnedItemList saw marked 2)
wEquipEquippedIndex:: db
; [8-bit] 0 while the screen is running; once a choice is made it counts up each frame and the screen fades out at $14
wEquipSelectExitTimer:: db
; [8-bit] 0 = rackets, 1 = shoes; selects the icon set, the info panel and which stat-modifier table GetItemStatModListPtr reads
wEquipItemKind:: db
; [8-bit] Which row-address table GetStatModRowAddr uses for the stat-modifier panel; both loaders set it to 0
wEquipStatRowSet:: db
NEXTU
; match results (bank $16)
; [8 bytes] Digit scratch PrintSinglesMatchStats / PrintDoublesMatchStats hand to PrintNumberRightAligned as bc while writing each stat into the shadow tilemap
wStatsPrintBuffer:: ds 8
NEXTU
; minigame data screen (bank $1b, $73dd-$78bd)
	ds 2
; [9 bytes] One byte per list row, nonzero when that row's minigame has its level-2 clear flag. LoadMinigameStarFlags fills it from MinigameStarFlagsTable ($02a0/$0300/$0360/$03c0/$0520/$0580/$05e0/$0640/$06a0, the SAVEFLAG_CLEARED_*_2 run) exactly as wMinigameDataClearFlags is filled from the level-1 flags. DrawMinigameStarMarks draws mark 1 for each set row; DrawStarLegendMark copies the legend swatch onto the screen if any of the nine is set; and DrawMinigameHighScoreNumber returns early unless the row's byte here is set, so a row with no star shows no number
wMinigameDataStarFlags:: ds 9
	export_size wMinigameDataStarFlags
; [8 x 16-bit] The number shown on each of the first eight rows. LoadMinigameHighScores calls ReadMinigameRecord with the record id row + 2 -- records 2-9 of the block $38 minigame records, whose 16-bit value comes back in wMinigameRecordValue under WRAM bank $07 -- and stores it at row * 2. DrawMinigameHighScoreNumber skips row 8, which has no record: that slot holds wMinigameDataTwoOnOneCleared instead
wMinigameDataHighScores:: ds 16
; [2 bytes] Row 8's slot in the high-score array, used as a flag pair rather than a number: LoadMinigameHighScores writes $01 into both bytes when SAVEFLAG_CLEARED_TWO_ON_ONE_3 is set, having cleared all 18 bytes from $d81b first. DrawMinigameSpecialMark reads the pair as a word and, once the list is scrolled to the bottom (wMenuCursorY = 4, so row 8 is the fifth visible row), draws mark 2 there
wMinigameDataTwoOnOneCleared:: dw
NEXTU
; trophies screen (bank $3b, $49e5-$4cfa)
	ds 2
; [6 bytes] The partner's second-set trophy row, from wN64TrophyCounts + 1 bits 2-3 and 6-7; the fourth and last row DrawTrophiesWonRows draws, and only when wTrophySecondSetPresent
wTrophyCellsPartnerSet2:: ds 6
	ds 1
; [8-bit] Set by DecodeTrophyCounts when any of the four second-set counts came out nonzero. It picks screen asset record $0d over $0e and switches DrawTrophiesWonRows and the character sprites from two rows (main at tilemap row 8, partner at 10) to four (rows 6/8 and 13/15)
wTrophySecondSetPresent:: db
ENDU

	ds 1

; Two screens over the same 40 bytes of WRAM bank $03: bank $38 keeps the
; character-unlock array here and bank $1b its ranking-banner animation.
; The array runs straight through where the banner bytes sit, so they are
; variants of one union rather than two unions side by side.
UNION
; character unlock flags (bank $38)
; [40 bytes] One byte per character, nonzero when unlocked. BuildCharUnlockFlags clears the array and walks CharUnlockFlagsTable0, marking a character either because its entry reads $ffff (always available) or because TestSaveFlag says so. PackUnlockFlagsForLink folds eight at a time into one bit each for the link exchange
wCharUnlockFlags:: ds 40
	export_size wCharUnlockFlags
NEXTU
; ranking board (bank $1b)
; [4 x 16-bit] One pointer per animation channel to the ranking marker slot that channel moves, stored from hl by StartRankingMarkerAnim<N> (the callers get it from GetRankingMarkerSlot). UpdateScriptedOffsetChannel<N> reloads it each frame and adds the script's delta to the slot's +1 on channels 0 and 1 and to its +2 on channels 2 and 3 -- the X and Y DrawRankingMarkersTask hands to QueueSprite as d and e
wRankingAnimSlotPtrs:: ds 8
; [4 x 16-bit] One pointer per channel to the delta script it is playing, stored from de by StartRankingMarkerAnim<N>. A script is one byte of movement per frame -- $01 or $ff in every table here -- ending at $40, which is UpdateScriptedOffsetChannel<N>'s cue to unregister its own frame task rather than a delta
wRankingAnimScriptPtrs:: ds 8
; [4 bytes] How far into its script each channel is. StartRankingMarkerAnim<N> zeroes its byte; UpdateScriptedOffsetChannel<N> reads the script at this offset and, unless it was the $40 terminator, increments it -- so the byte is the frame counter as well as the index
wRankingAnimStepIndex:: ds 4
	ds 1
; [8-bit] Frame counter for the sliding banner sprite. RankingBoardAnimTask_1b indexes RankingBoardAnimTaskTable with it for this frame's X delta, and unregisters itself once it reaches $87
wRankingBannerAnimFrame:: db
; [8-bit] X the banner sprite is drawn at, seeded to $a0 on frame 0 and advanced by the table delta every frame after
wRankingBannerX:: db
	ds 1
; [8-bit] Set to 1 at the end of each ranking-board animation state, which is how the state machine knows the current step has played out
wRankingAnimStateDone:: db
	ds 1
; [8-bit] Set when ShowRankingBoard is called with mode $03, which it then rewrites to $00. It suppresses the board's entrance animation (DispatchRankingBoardAnim returns at once) and the closing jingle -- the quiet variant used when the board is shown as part of a longer sequence
wRankingBoardSilent:: db
	ds 5
; [7 bytes] Where a ranking name too long for one row is split. RenderPlayerNameFitted measures the name with GetStringLength and, at six characters or more, calls RenderNameTwoRows: RenderNameTopRow copies the first four characters here and appends $2d ('-') and a terminator, RenderNameBottomRow copies the seven bytes from the fifth character on, and each row is then drawn from here by DrawNameWithDiacritics_1b
wRankingNameRowBuffer:: ds 7
	export_size wRankingNameRowBuffer
ENDU

	ds 152

; Screen-sized buffers in WRAM bank $03 that three unrelated screens keep
; at the same addresses, so the variants are scoped to the owning ROM bank.
; Bank $3b's copy is the largest and covers the whole span; the other two
; sit inside it.
UNION
; created characters and the character grid (bank $38)
; [$c0 bytes] Six $20-byte records for the player-created characters, built by BuildCreatedCharRecords from the save and walked by DrawCreatedCharStats (which seeks with a $20 stride). A record whose first byte is $ff ends the list
wCreatedCharRecords:: ds 192
	export_size wCreatedCharRecords
	ds 64
; [$80 bytes] The character-select grid as 32 four-byte entries, cleared when the screen opens and filled by BuildCharUnlockFlags. AddCreatedCharsToCharGrid appends the created characters from $da24 on, four bytes per slot
wCharGridEntries:: ds 128
	export_size wCharGridEntries
	ds 128
NEXTU
; N64 transfer records (bank $3b)
; [512 bytes] Image of save block $0b, the N64 (Transfer Pak) records, read here by ReadN64RecordsSaveBlock for the trophies screen and the ring-shot and star-victory grids. Same block the bank $03 engine stages at wSaveBlockBuffer in WRAM bank $07 -- this is the screen's own copy
wN64RecordsBlock:: ds 512
	export_size wN64RecordsBlock
NEXTU
; screen sequences (bank $18, past the dead confirm-label drawers)
	ds 256
; [8-bit] Cleared as the ending sequence enters its third scene and stepped through the scenes that follow
wEndingSceneStep:: db
; [8-bit] Frame counter each PlayScreenSequence* routine runs from 0 to $fa while its screen scrolls, then fades out
wScreenSequenceTimer:: db
ENDU

; Chart row store for the bank $3b N64 exhibition and Mario-cast screens
; (WRAM bank $03). Sixteen rows of 17 bytes each -- a flag byte and sixteen
; cells -- which is $110 in all, so the array actually reaches $dc0f and the
; last row runs into the block below. That is why wChartColumnList begins at
; $dc01 rather than $dc00.
; chart rows (bank $3b)
; [256 bytes, of $110 used] The decoded chart. InitChartRowFlags writes 1 to the head of each of the 16 rows, stepping 17 at a time; BuildN64ExhibResultsGrid and DecodeN64ExhibResultsRow fill the cells behind them from the N64 records block
wChartRows:: ds 256

; Screen state in WRAM bank $03 at $dc00. Bank $17's rules screen and bank
; $3b's N64 exhibition-data screen each keep their own bytes here, so the
; variants are scoped to the owning ROM bank. Bank $0d keeps its minigame
; actor records at the same addresses in WRAM bank $04 -- a separate union.
UNION
; rules screen (bank $17)
	ds 1
; [8-bit] Which rules page-list the screen is showing, from a at ShowRulesScreen; MinigameRulesPageLoop indexes MinigameRulesPageLists_17 with it
wRulesPageListId:: db
; [8-bit] Value ShowRulesScreen returns once the page loop finishes
wRulesExitCode:: db
; [8-bit] Nonzero lets AdvanceRulesScreenAnimFrame run; cleared while a page transition is in progress
wRulesAnimEnabled:: db
; [8-bit] Frame counter AdvanceRulesScreenAnimFrame increments, wrapping at $ff
wRulesAnimCounter:: db
; [8-bit] 0 for the minigame rules (PrepareRulesPageTilemap then reads wRulesMinigameLevel), nonzero for the match and training rules
wRulesIsMinigame:: db
; [8-bit] Copy of wMinigameLevel taken on entry, so the rules page matches the level being played
wRulesMinigameLevel:: db
	ds 13
NEXTU
; N64 exhibition and Mario-cast charts (bank $3b)
	ds 1
; [16 bytes] Which column each chart row shows, one byte per row. BuildMarioCastChartColumnList fills it from MarioCastChartColumnTable, substituting $10 -- the blank column -- for any entry whose save flag is clear, so a locked character leaves a gap rather than shifting the chart
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

; Bank $3b's results-screen scratch (WRAM bank $03): the exhibition victory grid's expanded cell bits, and the ring-shot entry list that the N64 records screen keeps in the same bytes.
UNION
; exhibition victory grid bits (bank $3b)
; [64 bytes] The victory grid's row bytes expanded one bit per byte by ExpandRowBytesToBits (it clears 4 x 16 bytes first), which CombineExhibCellBits indexes by the low nibble of b to fold cells back into bits
wExhibCellBits:: ds 64
	export_size wExhibCellBits
NEXTU
; ring-shot results (bank $3b)
	ds 32
; [16 bytes] The ring-shot rows to show, copied from the N64RingShot table and then patched: an entry becomes $10 (the blank row) when the matching bit in the N64 records block is clear, so a course the player never transferred is left out
wRingShotEntryList:: ds 16
	export_size wRingShotEntryList
ENDU

	ds 416

; Character-grid scroll counter (WRAM bank $03), owned by bank $38.
; character select (bank $38)
; [8-bit] Incremented every time the grid scrolls down a row. The select screen prints it as a decimal byte at row 3, column 1 each frame, which makes it a counter left on screen -- there is no other reader
wCharGridScrollCount:: db

	ds 255

; Character-select handedness (WRAM bank $03), owned by bank $38. The same
; address is the per-character match struct in WRAM banks $04-$07, which is
; a different union in different banks.
; character select (bank $38)
; [8-bit] Handedness the exhibition and link character grids are offering for the highlighted character: 0 right, 1 left, 2 not yet chosen. START toggles it with `xor $01` but only when IsMarioCastCharacter passes, and 2 becomes 1 on the first press. DrawCharSelectSlotLabel picks one of three pre-rendered labels off it -- 30:150/151/152, "START: Right-Handed", "START: Left-Handed" and "START: Change Hands". The story-mode screen keeps its own copy at wCharSelectHandedness in WRAM0
wCharGridHandedness:: db


SECTION "WRAMX bank 4", WRAMX[$d000], BANK[4]

; WRAMX bank 4 at a glance:
;
;   $d000-$d5ff  overworld actors
;   $d600-$d68f  wMugshotBuffer  [mirrored with bank 2, 3]
;   $d800-$dbff  wIntroCharactersTilemap  [mirrored with bank ]
;   $da00-$da31  actor engine
;   $dac0-$dae9  actor engine
;   $daea-$daf7  actor engine
;   $dc00-$dcd1  minigames / minigame targets
;   $dc00-$dfff  wIntroCharactersAttrmap  [mirrored with bank ]
;   $dcf0-$dcff  minigame targets
;   $dd00-$dd23  match ball history ring
;   $dd80-$ddcf  match object slots
;   $ddf0-$ddff  match object slots
;   $de00-$de1f  match ball sprite slots
;   $de80-$decf  court scoreboard columns
;   $df00-$df96  match character struct  [one copy per bank 4-7]

; Overworld / story actor slots (WRAM bank $04): 24 records of ACTOR_SIZE
; bytes, the array SpawnActor allocates from and the bank $04 engine walks
; once a frame. Scoped to a provable WRAM bank $04 -- $d000 is eight
; different things and seven ROM banks reach the array, so nothing but the
; dataflow can say which one a literal means.
; Two bank $0a sites get instruction ranges instead, because there the bank
; is selected in the callee and never at the reference: GetActorStateAddr
; builds its slot address and only then runs `wram_bank $04`, and
; EndCutsceneScriptMode hands slots 1 and 0 to AttachActorWaypointFollower,
; which selects the bank itself.
; Record fields are addressed as offsets (`ld hl, ACTORF_* / add hl, bc`),
; not as absolute addresses, so they are ACTORF_* constants rather than RAM
; symbols; the field-size table the script opcodes use is
; ActorFieldTypeTable_04.
; The story cutscene scripts in banks $0e-$15 load slot 0 or slot 1 (`ld de,
; $d000` / `ld bc, $d040`) and hand it straight to AttachActorStepMover or
; script_get_actor_state, which select WRAM bank $04 themselves; those loads
; are scoped by instruction range, like WaitPlayerMoveDone's.
; overworld actors (WRAM bank $04)
; [24 x ACTOR_SIZE] Actor slots; the fields are the ACTORF_* offsets (include/constants.inc). A slot is free when ACTORF_SCRIPT + 1 is zero
wActors:: ds 1536
	export_size wActors

	ds 1024

; List of actor slots near the player (WRAM bank $04), rebuilt by
; BuildNearbyActorList. Scoped to the bank $04 actor engine as well as to
; the WRAM bank: banks $18/$1b/$28/$38 keep unrelated screen state at the
; same addresses in WRAM bank $03.
; actor engine (bank $04)
; [up to 24 x 2 bytes + terminator] Pointers to the live actor slots BuildNearbyActorList selected -- those with a nonzero +$01, +$30 bit 7 set and +$05 bit 3 set, close enough to the player. A zero word ends the list, which is how FindActorAtPoint and the proximity searches stop
wNearbyActorList:: ds 50

	ds 142

; Actor-engine staging buffers (WRAM bank $04), owned by bank $04. Two ROM
; records are copied through here rather than read in place, because both
; live in whichever bank the caller was running and the engine wants them
; at a fixed address.
; actor engine (bank $04)
; [14 bytes] One map_actor record, copied out of the ROM list by SpawnActorsFromList and handed to SpawnActorFromTemplate. +$09 (the obj_id byte) reads $ff on the entry that terminates the list
wActorTemplate:: ds 14
	export_size wActorTemplate
	ds 2
; [16 bytes] The object-definition record LoadActorObjectDef copies in from the ObjectIdList_04 entry, then distributes into the slot: +$00 to +$37, +$01 to +$35, +$04/+$05 to +$24, +$06/+$07 to +$28, +$0a/+$0b to +$38, and +$08 as a far pointer to palette data when +$00 came out $63. The palette path reuses the first 8 bytes as the copy destination
wActorObjDef:: ds 16
	export_size wActorObjDef
; [16-bit] Negated camera X plus screen shake, recomputed each frame. DrawActorSprite adds it to an actor position to get a screen coordinate, which is why it is stored already negated
wActorScreenOriginX:: dw
; [16-bit] The same for Y, from wCameraY and wScreenShakeOffsetY (plus the $cb02 offset while the ending credits run)
wActorScreenOriginY:: dw
	ds 5
; [8-bit] Cleared by SetPlayerActorObjectDef before it reloads actor 0's object definition. Nothing reads it
wPlayerObjDefPending:: db

; Overworld actor engine scratch (WRAM bank $04), owned by the bank $04
; actor-script VM. Scoped to that bank as well as to the WRAM bank: the
; VM selects the bank once on entry, so most references cannot prove it.
; actor engine (bank $04)
; [8-bit] Heading the D-pad asks the overworld player to walk in ($40 per quarter turn, matching the FACE_* encoding). UpdatePlayerControl also writes it to actor field +$34, then probes $20/$40/$e0/$c0 away from it to slide along a blocked wall
wPlayerMoveAngle:: db
	ds 1
; [8-bit] Heading actually walked this frame, 0 when the move was blocked
wPlayerMoveAngleApplied:: db
; [8-bit] Previous frame's wPlayerMoveAngleApplied, saved before it is recomputed
wPlayerMoveAnglePrev:: db
; [8-bit] Cleared when no direction is held, so the walk animation stops
wPlayerMoving:: db
; [8-bit] How far ahead GetPointAheadOfActorRanged probes: multiplied by 32 (five `add a`) and added to the facing nibble to index ActorMoveVectors_04, so it selects which 32-byte range row of that table the direction vector is read from. The unranged entry point next to it hard-codes $40 instead.
wActorProbeRange:: db
; [16-bit LE] First coordinate of the point FindActorAtPoint is searching at, stashed from hl before it walks wNearbyActorList.
wActorQueryPointX:: dw
; [16-bit LE] Second coordinate of the same query point, stashed from de. The actor loop reads it back into de for each candidate, comparing against the word at actor + $0e.
wActorQueryPointY:: dw
; [8-bit] Random direction TryPickRandomReachableTarget probes in: the low byte of AdvanceRandomSeed masked with $fc, so one of 64 angles. ProjectPointFromActor casts a ray this way (first at distance $0100, then at $00e0 once the point is confirmed inside the box) to turn the angle into a candidate destination.
wActorProbeAngle:: db
; [8-bit] Half-width of the box ActorScriptOp_RandBox confines a random target to; the low byte of the operand word it reads with FarReadWord. TryPickRandomReachableTarget passes it to TestPointInBox as h, which is checked against the box centre's first coordinate (b +/- h vs d).
wActorRandBoxHalfWidth:: db
; [8-bit] Half-depth of the same box, the high byte of ActorScriptOp_RandBox's operand word. Passed to TestPointInBox as l and checked against the second coordinate (c +/- l vs e); the centre itself is the word at actor + $16.
wActorRandBoxHalfDepth:: db
; [8-bit] ROM bank of the actor script currently executing, taken from the actor's field +$22. Every ActorScriptOp_* passes it to FarReadByte / FarReadWord / CallHLInBankA to reach the script bytes
wActorScriptBank:: db

	ds 264

; Minigame actor records (WRAM bank $04), owned by bank $0d. The bank is
; earned from the dispatcher rather than the references: bank $08's
; RunMinigamePointLoop and UpdateMatchFrame select bank $04 before
; CallModeHook, and ClearMinigameActors / SetMinigameActorHandler /
; SetMinigameActorPosition each select it again, but the hooks are reached
; through a far pointer so compute_wram_bank cannot follow the edge.
; Bank $0a lays a second array over the same bytes with a different record
; size: fifteen 14-byte target records where bank $0d has seven 16-byte
; actors. Both start with bit 0 of +$00 as the live flag, but the strides
; and the field offsets differ (bank $0a's spawn writes its script pointer
; at +$04, bank $0d's handler pointer goes to +$0e), so they are two
; overlays rather than one structure.
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
; [16 bytes] The eighth record, same layout, left out of the
; ClearMinigameActors block. It is the object the minigame itself drives --
; the shot target, the Boo, the treasure box -- and the only record the
; code addresses by literal address rather than through bc, which is why
; its fields show up as wMinigameSceneActor + n.
wMinigameSceneActor:: ds 16
	export_size wMinigameSceneActor
	ds 82
NEXTU
; minigame targets (bank $0a)
; [210 bytes] Fifteen 14-byte target records for the target-shot minigames. UpdateMinigameTargets walks exactly fifteen of them with `ld de, $000e` between records, and SpawnMinigameTargetsFromList fills them from a formation's script-pointer list with the same stride. Fields, addressed through bc: +$00 flags (bit 0 = live), +$01 the delay ActivateMinigameTarget zeroes, +$04 the target script pointer. UpdateMinigameTarget copies the record it is working on out to wMinigameTargetWork and back. InitMinigameTargets clears with `ld c, $10` through ClearMemory16, i.e. 256 bytes -- past the array's end and over wMinigameTargetWork as well.
wMinigameTargets:: ds 210
ENDU

	ds 30

; Working copy of the minigame target actor being updated (WRAM bank $04),
; the same pattern as wObjSlotWork: UpdateMinigameTarget copies the slot in,
; runs its script, movement, draw and hit checks against this one fixed
; record, and copies it back. Owned by bank $0a.
; minigame targets (bank $0a)
; [16 bytes] +$00 flags (bit 0 live, bit 1 moving toward the goal), +$02 delay counter the update ticks down, +$06/+$08 current position, +$0a/+$0c goal position. MoveMinigameTargetTowardGoal steps the current position toward the goal $10 units at a time
wMinigameTargetWork:: ds 16
	export_size wMinigameTargetWork

; Match ball-visuals history ring (WRAM bank 4 only); shared renderer
; state, so scoped by the selected WRAM bank plus the bank-$08 renderer.
; match ball history ring (WRAM bank 4)
; [36 bytes] Ball position-history ring (WRAM bank 4): six 6-byte records [projX word, projY word, tile+8, attr]; UpdateBallVisuals ($5153) shifts it down one record per frame and BuildBallSlot writes the newest at +$1e
wBallHistory:: ds 36

	ds 92

; Match object slots (WRAM bank $04): five 16-byte records the bank $09
; sprite engine animates along a move curve -- serve indicators, the
; court banner, the point-situation banner, special-shot effects.
; Scoped to banks $08/$09 as well as the WRAM bank because the spawners
; pass a slot base in bc without selecting the bank at the reference.
; $ddd0-$ddef above them belongs to the bank $18/$1b menu screens.
; Only the bank $08 scope carries wram_bank $04. Bank $08 reaches WRAM bank
; $02 as well -- RefreshCourtScoreboard's saved-court-plane addresses were
; rendering as object slots until a bank-annotated trace showed the bank --
; whereas bank $09 is the object engine itself and never selects another.
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
; [16 bytes] Match object slot 1. UpdateAllObjSprites walks the five in order; each spawner claims a fixed one (the court banner and the special-shot effect both take slot 3). Object-slot record, 16 bytes:
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
wObjSlot1:: ds 16
; [16 bytes] Match object slot 2. UpdateAllObjSprites walks the five in order; each spawner claims a fixed one (the court banner and the special-shot effect both take slot 3). Object-slot record, 16 bytes:
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
wObjSlot2:: ds 16
; [16 bytes] Match object slot 3. UpdateAllObjSprites walks the five in order; each spawner claims a fixed one (the court banner and the special-shot effect both take slot 3). Object-slot record, 16 bytes:
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
wObjSlot3:: ds 16
; [16 bytes] Match object slot 4. UpdateAllObjSprites walks the five in order; each spawner claims a fixed one (the court banner and the special-shot effect both take slot 3). Object-slot record, 16 bytes:
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
wObjSlot4:: ds 16

	ds 32

; Working copy of the object slot being processed (WRAM bank $04).
; ProcessObjSlot copies the slot here, calls its handler, and
; FinishObjSlotUpdate copies it back to the slot it pushed -- so every
; handler addresses one fixed record instead of indexing bc.
; match object slots (banks $08/$09)
; [16 bytes] The slot ProcessObjSlot is currently running, copied in from wObjSlot0-4 and copied back by FinishObjSlotUpdate. Writing $ff to +$00 here is how GetNextMoveCurveValue frees the slot when the curve hits its $81 terminator. Object-slot record, 16 bytes:
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
wObjSlotWork:: ds 16
	export_size wObjSlotWork

; Match ball sprite slots (WRAM bank 4 only), alongside the per-character
; $df80+ slots; scoped by the selected WRAM bank plus the bank-$08 renderer.
; The bank $03 save engine passes minigame records through the same address
; in WRAM bank $07, which is a different variable in a different bank.
; match ball sprite slots (WRAM bank 4)
; [4 bytes] Match sprite-slot record [tile, attr, screenY, screenX] (WRAM bank 4): ball-at-net marker (tile $4e), drawn after the point resolves when the ball rests within $1e0 of the net (BuildNetBallSlot)
wNetBallSlot:: ds 4
; [4 bytes] Match sprite-slot record (WRAM bank 4): the ball, tile picked by height band / off-screen state ($40/$42/$44), gated by wBallSpriteEnabled (BuildBallSlot)
wBallSlot:: ds 4
; [4 bytes] Match sprite-slot record (WRAM bank 4): ball ground shadow (tile $46) at the ball's height-0 projection, gated by wBallShadowEnabled (BuildBallShadowSlot)
wBallShadowSlot:: ds 4
; [20 bytes] Five match sprite-slot records (WRAM bank 4): ball-trail afterimages (tile = ball tile + 8) fed from the history ring; slots 3-5 only when wBallTrailColor is nonzero (BuildBallTrailSlots)
wBallTrailSlots:: ds 20

	ds 96

; Pre-rendered scoreboard columns for the flipped court, WRAM bank $04.
; LoadCourtSceneGraphics copies two $28-byte blocks here out of the scene
; record; RefreshCourtScoreboardFlipped feeds them to CopyScoreboardTileColumn,
; which reads its source under bank $04 and writes its destination under bank
; $02 -- which is why the court planes it writes into are named from a ROM
; range rather than a provable WRAM bank.
; court scoreboard columns (banks $08/$0a)
; [40 bytes] Tile half of the scoreboard columns for a court played from the far side. RefreshCourtScoreboardFlipped copies it, and the row 30 bytes in ($de9e), into wCourtTilemapSaved; the middle offset $de94 is the second column it draws.
wScoreboardColumnTiles:: ds 40
	export_size wScoreboardColumnTiles
; [40 bytes] CGB attribute half of the same columns, laid out cell for cell with wScoreboardColumnTiles and copied into wCourtAttrmapSaved by the same routine.
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

; Shadow tilemap for text windows (WRAM bank $05). The same 32 x 32 cell
; plane plus CGB attribute plane the full-screen UIs keep in WRAM bank
; $03, but owned by the window engine: ResetTextWindowState clears both
; and points wShadowTilemapPtr / wShadowTilemapBank at $d000 / $05, and
; the dirty-row flusher copies changed rows out to $9800.
; Scoped to a provable WRAM bank $05 alone -- bank $05 is full of $d000
; and $d400 literals that address whichever plane the current screen
; owns, and its glyph buffers live at $d300-$d7ff in WRAM bank $07.
; The one instruction range is the exception RestoreShadowTilemapRow forces:
; it reads a row out of wMapBuffer64 under WRAM banks $03 and $02 and writes
; it back into these planes under bank $05, so the bank live at the `ld hl,
; $d400` is the source's, not the destination's.
; window shadow tilemap (WRAM bank $05)
; Tile plane of the text-window shadow tilemap: 32 x 32 cells, rows TILEMAP_WIDTH apart, of which the top-left 20 x 18 is on screen
wWindowShadowTilemap:: ds 1024
; CGB attribute plane of the text-window shadow tilemap, cell for cell with wWindowShadowTilemap and copied to $9800 in VRAM bank 1
wWindowShadowAttrmap:: ds 1024

; Window-fit table, WRAM bank $05: four 4-byte entries FitWindowToText indexes
; with a window id shifted twice, reading the first word of the entry.
; window / menu engine (bank $05)
; [16 bytes] Four 4-byte entries. FitWindowToText turns a window id into an offset with two `sla a` and reads the entry's first word into hl before centring the text against wDialogueWindowWidth / Height. ResetTextWindowState clears it along with the rest of $d800-$dfff in this bank.
wWindowFitTable:: ds 16

; Screen-local state in WRAM bank $03: each full-screen UI reuses these
; bytes for its own purpose, so the variants are scoped to the ROM bank
; that owns the screen rather than to the WRAM bank -- banks $16/$17/$38
; all select WRAM bank $03 here, and most sites select it in a callee so
; compute_wram_bank cannot prove it at the reference.
; window / menu engine (bank $05, WRAM bank $05)
	ds 16
; [8-bit] Window struct index AllocWindowStruct handed out for the window being built, $ff when none was free; CreateMenuWindowFromText passes it to SetWindowTextId / SetWindowState and returns it
wWindowId:: db
; [8-bit] Window struct index the glyph stream is rendering into, set by RedrawWindowText / Unused_05_RenderWindowTextToCompletion. InitGlyphStreamForWindow, Unused_05_DrawWindowGlyphRun, FlushGlyphRow and UploadLastGlyphTiles all resolve the window through it
wGlyphWindowId:: db
; [8-bit] While nonzero the glyph buffer survives: PrepareGlyphBuffer only calls ClearGlyphBuffer and ResetGlyphStream when it reads 0, and Unused_05_CloseMenuWindow, which nothing calls, decrements it. Nothing in the ROM increments it, so it stays 0 and the keep branch never runs (docs/bugs.md).
wGlyphBufferHoldCount:: db
	ds 1
; [8-bit] Window struct index of the dialogue window currently on screen, stored by CreateDialogueWindow. RedrawActiveTextWindow, RenderActiveWindowText, CloseActiveDialogueWindow and the speaker-dialogue helpers all address the window through it
wDialogueWindowId:: db
; [8-bit] Dialogue window top-left tilemap column (wrapped to $1f)
wDialogueWindowCol:: db
; [8-bit] Dialogue window top-left tilemap row (wrapped to $1f)
wDialogueWindowRow:: db
; [8-bit] Dialogue window width in cells, from b at CreateDialogueWindow
wDialogueWindowWidth:: db
; [8-bit] Dialogue window height in cells, from c at CreateDialogueWindow
wDialogueWindowHeight:: db
; [8-bit] Re-entrancy guard around RedrawActiveTextWindow: the delay/wait text commands only redraw while it is 0, and set it for the duration of their own redraw
wTextRedrawGuard:: db
; [8-bit] Column of the text-drawing cursor, 0-31. RenderTextString seeds it from d masked to $1f alongside wTextCursorRow, and TextCmdNewline reloads it into d for the GetTilemapCellAddress call that re-points the write pointer -- d is the column there, e the row (the row counter is what steps hl by $0020).
wTextCursorColumn:: db
; [8-bit] Row of the text-drawing cursor, 0-31. TextCmdNewline advances it by *two* rows, not one, because the font is double height; it wraps with `and $1f`. The two glyph-stream row commands at $5425/$544f compare it against a row computed from the stream offset to decide whether to step.
wTextCursorRow:: db
	ds 3
; [8-bit] Window struct index of the menu window CreateMenuWindowFromText just built (a copy of wWindowId taken as the menu is pushed)
wMenuWindowId:: db
; [8-bit] Row the menu cursor sits on; RunMenuSelection steps it against wMenuRowCount and returns it as the chosen entry
wMenuCursorRow:: db
; [8-bit] Number of selectable rows in the current menu, derived from MeasureTextDimensions ((lines - 1) / 2)
wMenuRowCount:: db
; [12 bytes] Six two-byte frames, one per nested menu, indexed by wMenuDepth * 2: [wMenuRowCount << 4 | saved wMenuCursorRow, window id]. Pushed by CreateMenuWindowFromText and unwound when a menu is cancelled
wMenuStack:: ds 12
; [8-bit] Number of menus currently stacked; indexes wMenuStack
wMenuDepth:: db

	ds 2

; Text and dialogue engine state (WRAM bank $05), owned by the bank $05
; text/window engine and driven from the bank $0a story scripts and the
; bank $0b drill messages. Scoped to those three ROM banks as well as to
; the WRAM bank, because the engine selects bank $05 once on entry and
; then saves and restores an unknown bank around its glyph-buffer work,
; so compute_wram_bank cannot prove it at every reference.
; The scope is not decoration: bank $1b keeps its ranking-marker
; animation channels over the same $d84x bytes in a different WRAM bank,
; and banks $18/$1a/$6b address $d8bx/$d8fx as screen tilemap cells.
; text and window engine (banks $05/$0a/$0b)
; [8-bit] Frame counter for the menu-cursor arrow blink task; bit 4 selects the tile it writes ($20 blank / $0d arrow)
wTextArrowBlinkCounter:: db
; [16-bit] Shadow-tilemap address of the cell the cursor arrow sits in. AnimateTextArrowTask turns it into a VRAM address (+ $3000 + $9800) and blinks the arrow there; RunMenuSelection primes it to $ffff and rewrites it every time the cursor moves
wTextArrowCell:: dw
; [16-bit] VRAM address of the cell the arrow just left, handed to the blink task to overwrite with tile $20. The task clears it once erased, so a zero here is also how it knows nothing is pending -- AnimateTextArrowTask tests the low byte, Unused_05_AnimateMenuScrollArrowsTask the high one
wTextArrowEraseAddr:: dw
; [8-bit] Page RunPagedTextMenu is showing; left/right step it and wrap against the page count. The entry it returns is wMenuPage * 4 + the row picked, so each page holds four rows
wMenuPage:: db
; [8-bit] Cursor into wTextArgStringQueue: PushTextArgString writes at it, TextCmdPrintArgString reads at it, and the dialogue entry points reset it to 0 between messages. Stops at 16
wTextArgStringWriteIndex:: db
; [8-bit] The same cursor for wTextArgNumberQueue, shared by PushTextArgNumber and TextCmdPrintArgNumber
wTextArgNumberWriteIndex:: db
; [8-bit] The same cursor for wTextArgShortTextQueue, written by Unused_05_PushTextArgShortTextId
wTextArgShortTextWriteIndex:: db
; [8-bit] How many string args were pushed. Kept in step with wTextArgStringWriteIndex while queuing and left alone when the cursor is reset, which is what makes it the limit the print command stops at
wTextArgStringCount:: db
; [8-bit] The same count for wTextArgNumberQueue; TextCmdPrintArgNumber prints nothing once the cursor reaches it
wTextArgNumberCount:: db
; [8-bit] The same count for wTextArgShortTextQueue
wTextArgShortTextCount:: db
	ds 1
; [16-bit] Text-stream pointer to pick up from instead of the start of wTextBuffer, with a nonzero high byte as the "set" flag that RenderTextString and FitWindowToText test and then clear. Two producers fill it: TextCmdWaitButtonPage makes TextInterpreterLoop store the byte it stopped on, and FindDialogueChoiceMarker stores the position of the $02 choice marker so the yes/no prompt measures and renders only the tail
wTextResumePtr:: dw
; [8-bit] Set by TextCmdWaitButtonPage; TextInterpreterLoop saves the resume offset to wTextResumePtr and returns, and the dialogue loops keep re-entering while it is set
wTextPageBreakRequest:: db
; [8-bit] Who the current dialogue belongs to, as passed to ShowSpeakerDialogue ($ff becomes 0). Bit 7 set means the low bits are a literal screen row; clear means they are an actor id, and OpenSpeechBubble / ShowYesNoPromptWindow read that actor's Y against the camera to decide whether the window opens on the top or the bottom half of the screen
wDialogueSpeaker:: db
; [16-bit] Text id the story script is up to. InitDialogueTextCursor seeds it and every Script*Dialogue call in bank $0a shows it and increments, so a cutscene walks a run of consecutive ids without naming each one
wScriptDialogueTextId:: dw
; [8-bit] Widest line of the measured text, rounded up to whole cells -- FitWindowToText writes it, MeasureDialogueWidthTiles returns it
wFitTextWidthCells:: db
	ds 7
; [8-bit] 1 when OpenSpeechBubble / Unused_05_OpenCenteredDialogueWindow put the window on the lower half of the screen because the speaking actor is near the top, 0 otherwise. Written by both, read by nothing
wSpeechBubbleLowerHalf:: db
; [8-bit] The byte Unused_05_SetTextVar stores. Nothing reads it
wUnusedTextByte:: db
	ds 1
; [8-bit] Set to 1 when RenderWindowText bails because the window's text id has $03 in its high byte (the "no text" sentinel), 0 when it goes on to fetch and render. Written by nothing else and read by nothing
wWindowTextEmpty:: db
	ds 2
; [8-bit] Speaker voice for the per-character text blip: DelayTextCharacter plays sound $9a + voice * 4 + (glyph & 3) as each glyph lands. GetSpeakerVoice supplies it, and $08 means silent -- which is also what a negative message speed forces
wDialogueVoice:: db
; [8-bit] Window Unused_05_SetFixedMenuWindowTextId built, so Unused_05_RunFixedTextMenu can close it alongside the menu window. Both are exported through the bank $05 farptr table and neither is called, which is just as well: Unused_05_SetFixedMenuWindowTextId loads hWramBank into b before calling SetWindowTextId, so the "window id" both routines pass around is really the WRAM bank number
wFixedMenuWindowId:: db
; [16-bit] Current VRAM destination address for glyph tiles (lo/hi)
wGlyphVramDest:: dw
; [8-bit] Second cursor into wTextArgStringQueue, stepped by MeasureNextArgStringWidth. FitWindowToText walks the whole message to size the window before a glyph is drawn, so the measure pass needs its own cursor per queue; the dialogue entry points reset all six together
wTextArgStringMeasureIndex:: db
; [8-bit] The measure-pass cursor into wTextArgNumberQueue, stepped by MeasureNextArgNumberWidth
wTextArgNumberMeasureIndex:: db
; [8-bit] The measure-pass cursor into wTextArgShortTextQueue, stepped by GetNextArgShortTextLength
wTextArgShortTextMeasureIndex:: db
; [16-bit] Current read pointer into the text byte stream
wTextStreamPtr:: dw
	ds 4
; [8-bit] Number of lines the measured text came to, the companion of wFitTextWidthCells. ShowDrillMessageByIndex turns it into a window height of lines * 2 + 1
wFitTextLineCount:: db
	ds 16

; Short-text scratch buffer (WRAM bank $05). Scoped wider than the rest of
; the text engine because the copy into it lives in the text banks: every
; bank that holds strings ends with the same FetchShortText tail, and it
; is that tail, not the engine, that names $d880. The bank $6b intro
; cutscene addresses the same bytes as tilemap rows in WRAM banks $03/$04,
; which is what the scope keeps out.
; short-text fetch (text banks)
; [16 bytes] Short string buffer: the text-bank fetch routines copy the string here instead of into wTextBuffer when called with a != 0
wShortTextBuffer:: ds 16
	export_size wShortTextBuffer

	ds 32

; Text-argument queues (WRAM bank $05): three parallel 16-entry rings the
; text control codes pop from, each with a cursor, a count and a second
; cursor for the measuring pass at $d847-$d84c / $d866-$d868. Same scope as
; the $d841 block -- banks $18/$1a/$1b/$6b address these bytes as screen
; tilemap cells in other WRAM banks.
; text argument queues (banks $05/$0a/$0b)
; 16 x 2-byte string pointers queued by PushTextArgString. The high nibble carries a WRAM bank tag, so an argument can point into a banked buffer
wTextArgStringQueue:: ds 32
; 16 x 2-byte values queued by PushTextArgNumber for TextCmdPrintArgNumber
wTextArgNumberQueue:: ds 32
; 16 x 1-byte short-text ids queued by Unused_05_PushTextArgShortTextId; GetNextArgShortTextLength measures them, but the $08 control code that would print one is a bare ret (TextCmdNop2)
wTextArgShortTextQueue:: ds 16

; Staging buffer UpdateSceneTileAnimations ($0a:$6460) assembles the scene's
; animated tiles in before queueing them to VRAM. Same subsystem and the same
; scope as the $da80 union below, kept separate only because the animation
; header starts at $da80 -- which is also what bounds the buffer, since no
; length for it appears in the code.
; scene tile animation staging (bank $0a)
; [384 bytes] The tile staging buffer, $d900-$da7f, bounded by wSceneTileAnimHeader above it. Referenced once, as the initial value of wSceneTileAnimBufferPtr; the bytes are filled by FarCopyBytes through that cursor and read out by QueueVRAMCopy
wSceneTileAnimBuffer:: ds 384

; Scene tile-animation record, WRAM bank $05: an $88-byte slot InitSceneTileAnimations
; copies in before building its animation slots.
; scene tile animations (bank $0a)
; [8 bytes] Header of the tile-animation record InitSceneTileAnimations copies from the scene slot; the entry list follows at wSceneTileAnimEntries.
wSceneTileAnimHeader:: ds 8
; [128 bytes] The scene's tile-animation entries. InitSceneTileAnimations tests the first byte against $fe and skips building any slots when the list is empty.
wSceneTileAnimEntries:: ds 128
	ds 8
; [16-bit] Rolling write cursor into wSceneTileAnimBuffer. UpdateSceneTileAnimations ($0a:$647a) seeds it with the buffer base each pass, reads it back as the FarCopyBytes destination and as the QueueVRAMCopy source, then advances it by the number of bytes copied ($0a:$6571)
wSceneTileAnimBufferPtr:: dw
; [16-bit] Far source pointer for the frame being staged, copied two bytes at a time out of the scene's slot 6 record by FarCopyBytes ($0a:$652c), then offset by the frame index before the tile data is fetched
wSceneTileAnimSrcPtr:: dw
	export_size wSceneTileAnimSrcPtr

	ds 236

; Window bookkeeping (WRAM bank $05), owned by the bank $05 window system:
; the window struct array, the dirty-row flags that drive the shadow
; tilemap flush, and the allocator mask above them. Scoped to bank $05
; in two ranges rather than one, because Unused_05_WriteStringToTilemapStreamed at
; $6bf0-$6c4f keeps its own cursor at $dc05-$dc0a in *the caller's* WRAM
; bank -- it writes glyphs straight to a tilemap the caller selected --
; so those bytes are not windows and stay numeric. Banks $0d and $17/$3b
; overlay the same addresses in WRAM banks $04 and $03 (separate unions).
; window system (bank $05)
; [64 bytes] Eight 8-byte window records, indexed by window id (GetWindowStructPtr masks the id to 3 bits and shifts left 3):
;   +$00 column, +$01 row (both wrapped to $1f by SetWindowRect)
;   +$02 width in cells, +$03 height in cells
;   +$04 state, read and written through GetWindowState / SetWindowState
;   +$06 text id (lo/hi), stored by SetWindowTextId; $03 in the high byte
;        is the "no text" sentinel RenderWindowText bails on
; AllocWindowStruct fills a free slot from de/bc, FreeWindow zeroes all
; eight bytes and releases the wWindowSlotMask bit
wWindowStructs:: ds 64
; [32 bytes] One flag per tilemap row. SetRowDirtyFlags clears the array and marks the e rows starting at d (wrapping at 32), which is how a window redraw tells the flusher which rows changed
wTilemapRowDirty:: ds 32
; [16 bytes] Run list BuildDirtyRowRuns folds wTilemapRowDirty into: (first row, run length) pairs terminated by $ff, with runs capped at 7 rows so one FlushDirtyRowsPerFrame pass fits in a VBlank. The flusher copies each run and waits a frame between them
wTilemapRowRuns:: ds 16
; [8-bit] One bit per window struct, set while the slot is in use. Unused_05_AllocWindowSlotBit scans for a clear bit and claims it; FreeWindow clears it again
wWindowSlotMask:: db
	ds 5
; [16-bit] Byte offset added to wShadowTilemapPtr by Unused_05_RefreshShadowTilemapFromMapBuffer when it copies rows back to the shadow tilemap. Nothing ever writes it, so it stays at the 0 ResetTextWindowState leaves behind
wShadowTilemapReadOffset:: dw
; [8 bytes] Scratch copy of one window record. SaveWindowStruct parks the struct here so a routine can rewrite the live one and still compare against where the window started -- OpenSpeechBubble walks the bubble outward one cell at a time against the saved column
wSavedWindowStruct:: ds 8


SECTION "WRAMX bank 6", WRAMX[$d000], BANK[6]

; WRAMX bank 6 at a glance:
;
;   $d000-$d029  9 overlays: scrolling story cutscene slide flag / scene animation frame counter / star warp transition / +6 more
;   $d000-$d3ff  wCollisionMap  [mirrored with bank ]
;   $d02a-$d219  10 overlays: results continue prompt rows / star warp transition / trophy EXP awards / +7 more
;   $d230-$d259  scrolling text screen / EXP award screen
;   $d400-$d5ff  story slot signatures / unlock flags block
;   $d400-$d7ff  wBehaviorMap  [mirrored with bank ]
;   $d800-$dbff  story scene load
;   $dc08-$dc8f  story scene load
;   $df00-$df96  match character struct  [one copy per bank 4-7]

; Character-data (level-up) screen working set, WRAM bank $06, shared by
; the bank $1a/$1c/$1d screen code. The first four bytes are a smaller
; scratch that three screens overlay -- the debug character viewer, the
; results continue prompt and the character-data screen itself -- so those
; get their own range-scoped variants ahead of it.
; Every scope carries wram_bank $06. The viewer and the continue prompt both
; started with ROM-range-only scopes and both were naming other banks' bytes
; at $d000 -- the results screen's tilemap planes, the viewer's actors --
; which the scope audit found once traced banks made the sites provable.
UNION
; scrolling story cutscene slide flag (bank $03)
; [8-bit] Set to 1 by AnimateWindowSlideUpTask when the text window has finished sliding; PlayScrollingStoryCutscene clears it before registering the task and spins until it is set
wCutsceneSlideDone:: db
	ds 41
NEXTU
; scene animation frame counter (bank $03)
; [8-bit] Which frame of the ending's animated scene is showing: zeroed by SetupSceneAnimationPalettes, stepped by UpdateSceneAnimation every fourth tick of wCutsceneSlideTimer until $36, and read by the six LoadCutsceneAnimFrameGfx_* loaders to pick the frame graphics they decompress
wSceneAnimFrame:: db
NEXTU
; star warp transition (bank $0e)
; [8-bit] Animation frame of the warp star, 0-5, stepped every other VBlank by UpdateStarWarpSprite
wStarWarpFrame:: db
; [8-bit] How far the star has travelled along its path, stepped by two each frame. OffsetStarWarpPathPoint indexes StarWarpPathX and StarWarpPathY with it to get the point wStarWarpPathX/Y then carry
wStarWarpPathIndex:: db
; [8-bit] Frames left in the transition, seeded to $5a. The wait loop starts the fade out when it reaches $1e and returns at zero
wStarWarpCountdown:: db
; [16 bytes] One life counter per trail sparkle. UpdateStarWarpTrailSparkles finds the first zero, sets it to $10 and seeds that slot's position from wStarWarpPathX/Y; the positions themselves are two bytes per slot from $d014
wStarWarpSparkleLife:: ds 16
NEXTU
; debug character viewer (bank $1a, $6800-$7000)
; [8-bit] Which row of the debug character viewer the cursor is on, toggled with `xor $01`: 0 = the character grid, 1 = the palette row
wCharViewerRow:: db
; [8-bit] Cursor index within the current row; up/down step it by $0b, the grid width
wCharViewerCursor:: db
; [8-bit] Character the viewer is showing, chosen by Unused_1a_RunCharViewerSelectGrid and turned into wCharViewerPalette by GetCharPaletteIndex
wCharViewerCharId:: db
; [8-bit] Grid cursor saved while the palette row has focus, so switching rows comes back to the same character
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
; [10 bytes] Row 1 of the four-row tilemap strip the continue prompt queues to $9800 from wContinuePromptKind (8 blocks of 16 bytes, so row 0 is the prompt's own variables). The row runs on to $d03f; DrawSaveWarningTextLine1 writes it from column 1
wContinuePromptTilemapRow1:: ds 10
NEXTU
; character-data screen (banks $1a/$1c/$1d)
; [8-bit] Free-running counter CharDataScreenAnimTask steps every frame the screen is idle; its low nibble indexes the animation table
wCharDataAnimCounter:: db
; [8-bit] Cleared alongside wCharDataAnimCounter when the screen opens. Nothing in banks $1a/$1c/$1d reads it back -- the byte belongs to whichever screen ran before
wCharDataAnimSubStep:: db
; [8-bit] Which third of the screen still needs pushing to VRAM. FlushCharDataTilemapChunk sends one chunk per call and branches on 0, 1 and 2; while it is nonzero the animation task holds off
wCharDataFlushChunk:: db
; [8-bit] Points still unspent while the player is editing. It heads the six bytes BackupCharData copies out and RestoreCharData copies back -- this byte, wCharDataLevel and the four wCharDataNewLevels -- which together are everything a cancelled visit has to forget
wCharDataPointsWorking:: db
; [8-bit] Level the character-data screen is committing; WriteCharStatsToDisplayBuffer stores it back into record +$18 (wStoryModeMainCharacterLevel)
wCharDataLevel:: db
; [4 bytes] Spin/Power/Control/Speed levels the screen is committing; WriteCharStatsToDisplayBuffer stores them back into record +$38-$3b
wCharDataNewLevels:: ds 4
; [8-bit] Unspent level-up points on the character-data screen, copied in from $d003 and decremented by CharDataScreen_InputLoop after each LevelUpPlayer
wCharDataPointsLeft:: db
; [4 bytes] Spin/Power/Control/Speed levels as loaded from record +$38-$3b (LoadCharStats / LoadCharStatsWithLevelUpDeltas)
wCharDataLevels:: ds 4
; [11 bytes] The eleven displayed stats, loaded from record +$20-$2a with 1 added to each (Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop -- the order of wStoryModeMainCharacterTopStat onwards)
wCharDataStats:: ds 11
; [11 bytes] Per-stat change the pending level-up would apply, filled by ComputeLevelUpStatDeltas (or cleared when wCharDataPage is $04); DrawStatArrowIndicators turns each into an up/down arrow beside its stat
wCharDataStatDeltas:: ds 11
; [8-bit] Which of the four level-up choices the cursor is on, or $04 for the confirm cell; CharDataScreen_DrawPageColumns and DrawStatValueSprites both key off it
wCharDataPage:: db
; [8-bit] Step of the confirm prompt (RunCharDataConfirmScreen); DrawConfirmSelectionCursor_1a draws the cursor from it
wCharDataConfirmState:: db
; [8-bit] AnimateCharDataStatsReveal countdown between stat rows; CharDataScreen_InitState seeds it with $0a
wCharDataRevealTimer:: db
; [8-bit] AnimateCharDataStatsReveal step; CharDataScreen_InitState seeds it with $03
wCharDataRevealStep:: db
; [8-bit] 0 while the allocation page is live: DrawStatValueSprites then draws the level one higher, in palette $0f, to preview the level about to be gained. CharDataScreen_InitState sets it to $03 on re-entry and CharDataScreen_Show clears it
wCharDataLevelPreview:: db
; [8-bit] Number of entries written to wCharDataChoiceLog so far; also the write index
wCharDataChoiceCount:: db
NEXTU
; EXP award screen (bank $1e)
	ds 4
; [8-bit] First byte of the EXP award screen's working set. InitExpAwardScreenState clears $d004-$d027 from here -- wExpAwardRunningTotal, wExpAwardAmount, wExpAwardIndex and wExpAwardMessageTimer all fall inside -- then seeds $d009-$d00c and $d019-$d01c to $20 and $d00d/$d01d to $30. Nothing in bank $1e reads the byte itself; only the address is used, as the base of that clear
wExpAwardScreenState:: db
; [16-bit] The EXP total ticking up on screen. CountUpExpTotal increments it and decrements the amount still to add, one point and one sound per pass, and DrawExpTotalDigits redraws it
wExpAwardRunningTotal:: dw
; [16-bit] The award being counted in, set as each message is shown
wExpAwardAmount:: dw
	ds 27
; [8-bit] Which award message is being shown; BeginNextExpAward steps it and DrawNextExpAwardMessage returns zero once the list runs out
wExpAwardIndex:: db
	ds 1
; [8-bit] Cleared as each award begins, so the message holds for its full dwell
wExpAwardMessageTimer:: db
NEXTU
; cutscene text window (bank $03)
	ds 1
; [8-bit] First byte of the current TextPageDescriptors_03 entry: how many rows the page scrolls by. ScrollCutsceneTextWindow masks it to two bits and treats zero as one, so a descriptor that forgets the field still scrolls a single row
wCutsceneTextScrollRows:: db
NEXTU
; trophy EXP awards (bank $1e)
	ds 40
; [16-bit] EXP for trophy group 0. It is the head of the six-word run ComputeTrophyExpAwards fills, but it falls below the union wTrophyExpByGroup is filed under, so groups 1-5 carry that name and this one stands alone
wTrophyExpGroup0:: dw
ENDU

; WRAM bank $06 from $d02a up, shared by four subsystems that never run at
; once. The palette fade engine's two 128-byte buffers straddle what used
; to be the boundary between two unions, which is why they are one now.
; Every scope carries a ROM bank and wram_bank $06: the working palette
; buffer and the character-data screen's stat arrays start at the same
; address, and only the owning bank tells them apart.
; The sound driver's scope keeps its wram_bank $07 alternative, since the
; same offsets are its channel state in that bank.
UNION
; results continue prompt rows (bank $1e)
	ds 22
; [32 bytes] Row 2 of the continue prompt's tilemap strip; DrawContinuePromptText writes the prompt from column 1
wContinuePromptTilemapRow2:: ds 32
; [32 bytes] Row 3 of the strip; DrawSaveWarningTextLine2 writes the second warning line from column 1
wContinuePromptTilemapRow3:: ds 32
	ds 410
NEXTU
; star warp transition (bank $0e)
	ds 22
; [8-bit] Y of the point the star has reached along its path, copied into each sparkle as it spawns
wStarWarpPathY:: db
; [8-bit] X of the same point
wStarWarpPathX:: db
NEXTU
; trophy EXP awards (bank $1e)
; [10 bytes] EXP for trophy groups 1-5, five 16-bit words. ComputeTrophyExpAwards fills them one group at a time carrying a running sum in hl -- group 0's word goes two bytes lower still, onto the byte the character-data screen calls wCharDataLevelPreview, which is why the array cannot be declared from its true base here
wTrophyExpByGroup:: ds 10
; [16-bit] ComputeTrophyExpForGroup's own accumulator while it walks one group's trophies, testing and setting each award flag as it goes
wTrophyExpGroupAccum:: dw
; [16-bit] The sum of all six groups, which ApplyPendingExpAwards adds to the match award
wTrophyExpTotal:: dw
; [8-bit] Character group being totalled; indexes TrophyExpForGroupTable0-4 and selects the row GetTrophyExpValue reads
wTrophyExpGroup:: db
NEXTU
; character-data screen (bank $1a)
; [100 bytes] One byte per level-up taken on this visit: the wCharDataPage the player confirmed. Cleared by WriteCharStatsToDisplayBuffer before the screen opens
wCharDataChoiceLog:: ds 100
; [6 bytes] Scratch the character-data and EXP screens format numbers into. FormatExp24BitDecimal puts the 24-bit value's top byte at +$00 and formats the low word to five places from +$01, which is what makes the buffer six wide
wCharDataNumberBuffer:: ds 6
	export_size wCharDataNumberBuffer
	ds 11
; [8-bit] Cleared with the rest of the screen state by CharDataScreen_InitState and read by nothing else in the character-data banks -- the byte sits between wCharDataNumberBuffer and the working palette buffer, so whichever screen ran before is what left a value in it
wCharDataRevealDone:: db
; [11 bytes] The eleven stats recomputed as if no racket were equipped, so the screen can show what the equipment is worth. CharDataScreen_BuildStats fills it from wStoryMainCharStats after RecomputeStatsWithoutRacket, and leaves it alone when nothing is equipped
wCharDataStatsNoRacket:: ds 11
; [11 bytes] Per-stat difference the equipped racket makes, cleared to zero before anything else so an unequipped character shows no arrows at all. DrawStatChangeArrows reads it alongside wCharDataStatsNoRacket
wCharDataRacketDeltas:: ds 11
; [8-bit] Nonzero opens the character-data screen read-only: CharDataScreen_Show skips the allocation flow, LoadCharStatsWithLevelUpDeltas returns without computing deltas, and the input loop will not spend a point. Set by RunExpDistributionFlow and RestoreCharData
wCharDataViewOnly:: db
; [6 bytes] Copy of wCharDataEditState taken as the screen opens; RestoreCharData copies it back and sets wCharDataViewOnly, which is how cancelling out of a level-up returns everything unspent
wCharDataEditBackup:: ds 6
	export_size wCharDataEditBackup
; [101 bytes] The matching backup of wCharDataChoiceCount and the choice log behind it, so a cancelled visit forgets every level-up the player had provisionally taken
wCharDataChoiceBackup:: ds 101
	export_size wCharDataChoiceBackup
NEXTU
; character-data and EXP screens (banks $1a/$1c/$1d)
	ds 283
; [16-bit] X offset the stat digits are drawn at while a page slides. The Slide*StatPage routines step it and DrawCharStatDigitsTask hands it to ApplySlideOffsetToSpriteX for every digit it queues
wCharDataStatsSlideX:: dw
; [16-bit] The same offset for the value column, stepped in step with wCharDataStatsSlideX and applied by CharDataValuesSyncTask -- two offsets because the two columns slide in and out at different times
wCharDataValuesSlideX:: dw
	ds 24
; [2 x 15 bytes] Per-character record the EXP award screen works on, selected by wStoryCharacterSlot (slot 0 at +0, slot 1 at +15). InitExpScreenCharStats fills $d161-$d16f; +8 is the 16-bit total CheckExpLevelUp/Down compare, and DrawExpScreenLevelNumber, DrawExpScreenLevelBar and the SweepExpBarMarker routines read +0 and +3
wExpScreenCharStats:: ds 30
NEXTU
; palette fade engine (bank $03)
	ds 118
; [128 bytes] The fade's endpoint: 16 palettes of four 16-bit colours. CopyMasterPalettesToFadeBuffers seeds it from wMasterPalettes, then the caller rewrites it -- Unused_03_ClearFadeTargetPalettes zeroes all 64 colours (fade to black), DesaturateFadeTargetPalettes greys each one through SplitColorComponents. StepPaletteColorsTowardTarget reads it and SnapPalettesToTarget copies it over wPaletteFadeLive; AdvanceToPaletteEntry walks it 8 bytes at a time
wPaletteFadeTarget:: ds 128
	ds 32
; [128 bytes] The buffer the fade animates and shows: seeded from wMasterPalettes at the same moment, then every AnimatePaletteFadeToTarget pass steps each masked palette's components +/-1 toward wPaletteFadeTarget (StepPaletteColorsTowardTarget writes back here) and LoadPalettesImmediate uploads all 16 palettes from it
wPaletteFadeLive:: ds 128
	ds 32
; [16 bytes] One byte per palette, all 16 -- InitGrayscalePaletteFade clears $10 of them and the animate/snap loops walk $10 -- of which SetupPaletteFadeMask sets the first eight from the bits of b (bit 7 is palette 0). Only flagged palettes are stepped
wPaletteFadeMask:: ds 16
; [8-bit] Passes remaining, as passed in d; AnimatePaletteFadeToTarget decrements it once per pass and snaps when it reaches zero
wPaletteFadeAmount:: db
; [8-bit] Palette currently being stepped, saved across the AdvanceToPaletteEntry calls that resolve the same entry in both buffers
wPaletteFadeIndex:: db
; [6 bytes] The two colours being interpolated, unpacked to red, green and blue by SplitColorComponents -- the working colour at +$00 and the target at +$03
wPaletteColorSplit:: ds 6
	ds 1
; [8-bit] wPaletteFadeAmount divided by $1f: the frames AnimatePaletteFadeToTarget waits before each pass. The colour step itself is always +/-1 per component (StepColorComponentTowardTarget)
wPaletteFadeFrameDelay:: db
	ds 4
; [8-bit] Set while a cutscene text window is sliding, by AnimateWindowSlideUpTask and the scrolling-story player
wCutsceneWindowSliding:: db
NEXTU
; character-data page arrows (banks $1a/$1c/$1d)
	ds 280
; [8-bit] Which page arrows to bob: 1 draws the left one, 2 the right, 0 neither. DrawCharDataPageArrowsTask reads it every frame
wCharDataPageArrowMode:: db
; [8-bit] Nonzero freezes the arrow bob; while it is clear the task steps wCharDataArrowPhase
wCharDataArrowHold:: db
; [8-bit] Free-running counter the arrow bob reads for its offset
wCharDataArrowPhase:: db
NEXTU
; EXP distribution screen (bank $1d)
	ds 248
; [13 bytes] The main character's stat page as it will be drawn: +$00 the four Spin/Power/Control/Speed levels copied out of wCharDataLevels, +$04 six values the page copies to wCharStatPageShown, +$0a three more the value sync task reads
wCharStatPageMain:: ds 13
; [13 bytes] The partner's page, same layout 13 bytes on -- which is what makes the two a pair rather than two unrelated blocks
wCharStatPagePartner:: ds 13
; [6 bytes] Whichever page is on screen, copied from +$04 of the main or partner record as the screen slides between them. DrawCharStatDigitsTask draws from here
wCharStatPageShown:: ds 6
	export_size wCharStatPageShown
	ds 7
; [8-bit] Which pair CharDataValuesSyncTask pushes into the screen: zero takes wCharDataSyncValues, nonzero takes wGameTimer + 2
wCharDataSyncSource:: db
	ds 2
; [2 bytes] The two bytes it copied in, formatted and drawn as the screen's live readout
wCharDataSyncPair:: dw
; [16-bit] EXP points still to hand out. AssignExpPointToChar decrements it per point spent, DrawExpPoolReadout prints it and DrawExpPoolGauge draws it as a fraction of wExpPoolTotal
wExpPoolRemaining:: dw
; [16-bit] What the pool started at, kept so the gauge has a denominator. Both are seeded from hl by InitLevelUpScreenState
wExpPoolTotal:: dw
	ds 45
; [8-bit] Which character the distribution cursor is on; cleared when the screen opens
wExpCursorChar:: db
; [8-bit] Slide progress for the cursor moving between characters, stepped by SlideExpCursorToMainCharTask
wExpCursorSlide:: db
; [8-bit] X of the marker sweeping along the EXP bar. $a8 is its home; SweepExpBarMarkerLeft subtracts the per-frame step and snaps back to $a8 once it passes $18
wExpBarMarkerX:: db
; [8-bit] Row the confirm prompt cursor sits on
wExpPromptCursorRow:: db
; [8-bit] Frames before a held direction starts repeating, seeded to $08 when the screen opens
wExpRepeatDelay:: db
; [8-bit] Set when something changed and the screen needs its tilemap rows pushed again
wExpRedrawPending:: db
; [8-bit] Set once a held direction has begun repeating, so the delay is only applied on the first step
wExpInputRepeating:: db
; [8-bit] $ff when a level-up has just happened; TickLevelUpJingle plays the jingle off it and clears it
wExpLevelUpFanfare:: db
NEXTU
; pending EXP award list (banks $1d/$1e)
	ds 296
; [10 bytes] Five 16-bit EXP amounts, one per line of the results screen's award list: 0 story, 1 exhibition, 2 linked, 3 match/minigame, 4 trophy. RecordDrillResult takes the line in `b` and dispatches through DrillSubHandlers_1d, each handler storing `de` at this base + 2 * line; ClearDrillResultBuffer zeroes all 15 bytes of the pair. DrawNextExpAwardMessage reads the word back with split-base addressing (`add $52 / adc $d1`) and skips a line whose amount is zero, and HasPendingExpAwards ORs the five words to decide whether the screen is worth showing at all.
wPendingExpAwardAmounts:: ds 10
; [5 bytes] One byte per award line, the `c` argument of RecordDrillResult. DrawNextExpAwardMessage adds it to the line's base text id from DrawNextExpAwardMessageTable, so it picks between wordings of the same message -- ShowExpAwardForMatch passes 0, 2, 3 or 4 for a normal, Island Open, practice or Dream match, and the trophy pass numbers the six trophy groups.
wPendingExpAwardVariants:: ds 5
NEXTU
; EXP award screen (bank $1a)
	ds 295
; [8-bit] Bit flags the EXP award screen runs on: Unused_1a_ExpScreenNumberTask sets bit 7 once the EXP-to-next figure has reached zero, Unused_1a_ExpScreenDrawTask branches on it each frame, and Unused_1a_SignExtendModifierByte rewrites it as it works. Bank $1d keeps the high half of wExpPoolTotal over the same byte, which is why this variant is scoped to bank $1a
wExpScreenFlags:: db
ENDU

	ds 22

; Scrolling text screen (the staff-roll style crawl), WRAM bank $06,
; owned by bank $03's RunScrollingTextScreen.
; The EXP award screen (bank $1a) overlays the same bytes with its gauge
; state, and banks $1c/$1d put the character-data screen's $40-byte stat
; blocks at $d240/$d280/$d2d0 -- those stay numeric, being neither.
UNION
; scrolling text screen (bank $03)
; [8-bit] Frames until the crawl scrolls one line; reloaded with 2 each time it hits 0
wScrollTextDelay:: db
; [8-bit] The value it reloads with, seeded alongside it
wScrollTextDelayReload:: db
; [16-bit] Text id the crawl is rendering, seeded with $1863
wScrollTextId:: dw
; [8-bit] Set once the last line has scrolled off, which stops the scroll without leaving the loop
wScrollTextDone:: db
	ds 37
NEXTU
; EXP award screen (bank $1a)
; [16-bit] EXP being awarded, the target the gauge counts up to
wExpAwardTotal:: dw
; [16-bit] EXP counted so far. Unused_1a_AdvanceExpGaugeFill increments it once per tick and sets wExpCountDone when it reaches wExpAwardTotal
wExpAwardCounted:: dw
; [4 bytes] How the counted number is drawn: +$00 X, +$01 Y, +$02 first digit tile ("0"; a digit adds its value * 2), +$03 OAM attribute
wExpCountedSprite:: ds 4
; [8-bit] Set once wExpAwardCounted has reached the total; the fill loop leaves and the level-up path runs
wExpCountDone:: db
; [8-bit] Set when the player presses A or B during the count, which switches the gauge to the fast path
wExpCountFastForward:: db
; [8-bit] Added to the X of every digit Unused_1a_QueueNumberSpritesShifted draws, which is how the counted number slides while the gauge fills
wExpNumberSpriteShiftX:: db
; [8-bit] Latched once the EXP-to-next-level figure reaches zero, so the level-up is requested exactly once
wExpLevelUpQueued:: db
; [16-bit] EXP still needed for the next level, seeded from GetExpRemainingToNextLevel and counted down alongside the gauge
wExpToNextLevel:: dw
; [4 bytes] The same X/Y/tile/attribute record for the EXP-to-next-level number
wExpToNextSprite:: ds 4
; [16-bit] The value actually shown for EXP-to-next; reaching zero is what sets wExpLevelUpQueued
wExpToNextDisplayed:: dw
; [5 bytes] Decimal digits of wExpToNextDisplayed, formatted unsigned to five places
wExpToNextDigits:: ds 5
	ds 5
; [5 bytes] Decimal digits of wExpAwardCounted, formatted the same way
wExpCountedDigits:: ds 5
	ds 1
; [8-bit] Which character record the award belongs to, kept so the screen can hand it to AddPlayerExp once the count finishes
wExpAwardSlot:: db
ENDU

	ds 422

; Two save-block readers share $d400 in WRAM bank $06. Scoped to the owning
; ROM bank as well as the WRAM bank -- bank $1e writes shadow-tilemap cells
; at these addresses in WRAM bank $03, which is what a bank-only scope
; would have claimed.
UNION
; story slot signatures (bank $02)
; [12 bytes] One wStorySaveSignature per story slot, cached four bytes apart by CacheStorySlotSummaries so CheckStorySignatureCollision can compare a new signature against all three without touching SRAM again
wStorySlotSignatures:: ds 12
	ds 500
NEXTU
; unlock flags block (bank $1b)
; [512 bytes] Image of save block $0b read by Unused_1b_ReadUnlockFlagsSaveBlock for the minigame-flags debug screen -- the same block bank $3b stages at wN64RecordsBlock in WRAM bank $03 and the bank $03 engine at wSaveBlockBuffer in bank $07
wUnlockFlagsBlock:: ds 512
ENDU

	ds 512

; Story-scene decompression scratch, WRAM bank $06.
; story scene load (bank $0a)
; [1024 bytes] Third decompression destination of LoadStorySceneGraphics, and the only one nothing lands in: the `ld de, $d800` that selects it is overwritten by the next `ld de, $d400` before any call, so the store is dead. Its two live siblings decompress into $d400 and $d000 of this bank, and the planes after those go to wScreenAttrmap and the bank $03 tilemap.
wStorySceneUnusedBuffer:: ds 1024

	ds 8

; Story-scene record, WRAM bank $06: the $88-byte slot LoadStorySceneGraphics
; copies out of the scene table before handing the scene to the overworld engine.
; story scene load (bank $0a)
; [136 bytes] The current story scene's record, copied here from its slot with CopyDataFromBank. The loader reads four bytes at +2 straight back out into wMapScrollMinX, wMapScrollMinY, wMapWidthTiles and wMapHeightTiles, so the first fields are the map's scroll bounds and tile dimensions.
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

; Where the shared HRAM pool goes during an audio update (WRAM bank $07).
; Scoped to RunSoundEngine itself: bank $05 and the boot path also load
; $d000 with WRAM bank $07 selected, and there it is the base of a
; 4 KiB clear over the whole bank, not this buffer.
; sound driver (bank 0)
; [32 bytes] Copy of $ffd0-$ffef taken by RunSoundEngine on entry and put back on exit. The driver keeps its channel state in that HRAM window, so context-switching it is what lets four other subsystems keep their own bytes there across an audio update -- see the $ffd0 union
wSndHramSave:: ds 32
	export_size wSndHramSave

	ds 10

; WRAM bank $06 from $d02a up, shared by four subsystems that never run at
; once. The palette fade engine's two 128-byte buffers straddle what used
; to be the boundary between two unions, which is why they are one now.
; Every scope carries a ROM bank and wram_bank $06: the working palette
; buffer and the character-data screen's stat arrays start at the same
; address, and only the owning bank tells them apart.
; The sound driver's scope keeps its wram_bank $07 alternative, since the
; same offsets are its channel state in that bank.
; sound engine (bank 0)
	ds 214
; [192 bytes] Six 32-byte channel state blocks (channels 0-1 music, 2-5 SFX); the active channel's block is mirrored into HRAM $ffd0 each pass, first word = script pointer ($ffff = idle)
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

; Two subsystems overlay this 2 KiB of WRAM bank $07. The text engine keeps
; its glyph tiles here and uploads them to VRAM $8800; the bank $03 save
; engine borrows the same bytes as block staging, because a save never runs
; while text is being composed.
; Both constraints are needed on every scope. The WRAM bank alone cannot
; separate the two overlays -- an interior byte would take whichever symbol
; was registered first -- and the ROM bank alone is far too coarse: a 2 KiB
; extent would otherwise claim every $d3xx-$dafx literal in banks $05/$3f,
; which is most of the window engine and two decompression buffers in other
; WRAM banks.
; Bank $03's debug save editor loads $d300 as well -- it hex-dumps the whole
; region from there, one byte at a time under a cursor, so that literal is a
; window base rather than a variable and is left numeric. (Its "wipe the
; block" branch clears from $d300 and its slot-3 branch edits $d300+, both
; $200 short of where Unused_03_ReadCurrentSlotBlock actually puts the block.)
UNION
; text glyph tiles (banks $05/$3f)
; [2048 bytes] 128 proportional-font glyph tiles, laid out 1:1 against VRAM $8800 so tile n is at + n * TILE_SIZE and uploads to $8800 + n * TILE_SIZE. PlotGlyphRow adds the pen position to this base with a signed shift (sra d / rr e), so a negative pen writes below it: the lesson menu's second page puts five glyph tiles at $d2b0-$d2ff, harmless because bank $07 is unused there (docs/bugs.md). ClearGlyphBuffer fills all 128 with the blank glyph; UploadGlyphBufferFull sends the first 80 as five 256-byte pages, and UploadGlyphTilesPartial / Unused_05_UploadGlyphTileRange send narrower runs
wGlyphTileBuffer:: ds 2048
NEXTU
; save-block staging (bank $03)
	ds 384
; [32 bytes] Image of a minigame-record save block ($38 + story slot): 16 16-bit records indexed by record id. ReadMinigameRecord zeroes it, reads the block over it and hands record b back through wMinigameRecordValue; UpdateMinigameRecord does the reverse and verifies the block afterwards
wMinigameRecordBlock:: ds 32
	ds 96
; [512 bytes] Image of whichever $200-byte block the save engine is working on: the story slot block for Unused_03_ReadCurrentSlotBlock / Unused_03_WriteCurrentSlotBlock (ids from StorySlotBlockIds_03), and block $0b for the N64 transfer records. ApplyN64RecordsUnlockFlags and UpdateUnlockablesSaveBlock address the unlock bytes at +$00-$07 directly
wSaveBlockBuffer:: ds 512
ENDU

	ds 38

; State for a frame task that was stubbed out (WRAM bank $07).
; story-data confirm menu (bank $1b)
; [2 bytes] Unused_1b_RunStoryDataConfirmMenu selects WRAM bank $07, clears +$00, sets +$01 to $0c and registers StubNop_1b_09 as a per-frame task. That task's body is a bare ret, so nothing ever reads either byte -- the register/unregister pair around the prompt is real, only the work is missing
wStubbedPromptTaskState:: dw

	ds 728

; Match ball sprite slots (WRAM bank 4 only), alongside the per-character
; $df80+ slots; scoped by the selected WRAM bank plus the bank-$08 renderer.
; The bank $03 save engine passes minigame records through the same address
; in WRAM bank $07, which is a different variable in a different bank.
; minigame record parameter (WRAM bank $07)
; [16-bit] In/out parameter of ReadMinigameRecord / UpdateMinigameRecord: the high score for one record, pulled out of wMinigameRecordBlock or written into it. Every caller selects WRAM bank $07 around the two bytes, which is how the bank is provable at sites in banks $03/$0d/$12/$14/$17/$1b/$1e
wMinigameRecordValue:: dw
	ds 30


SECTION "WRAMX bank 4 $df00", WRAMX[$df00], BANK[4]

; One copy per character of a structure that lives in WRAM banks 4-7
; at once. Each bank declares its own copy under a bank-tagged name, so the
; symbol file resolves the right one whichever bank the debugger is stopped in
; -- this is bank 4's. The disassembly itself uses the untagged name, an EQU
; in include/ram_mirrored.inc, because the bank is chosen at run time.

; Match-engine per-character struct, replicated across WRAM banks 4-7
; (bank = character: 4 near-P1, 5 far-P1, 6 near-partner, 7 far-partner).
; Same field, different character per bank -- one name each. Scoped by the
; provably-selected WRAM bank, plus the match banks $07/$08 whose
; callback-reached (jp hl) accesses the dataflow can't prove. Only the
; named field offsets render; other $dfxx bytes stay numeric.
; The character-select screen drives the same struct: bank $38 runs
; UpdateCharSelectCharSprite and TickCharSelectIdleAnim once per preview
; character, selecting WRAM banks $04-$07 in turn, so those two routines get
; instruction-range scopes rather than a whole-bank one -- bank $38's own
; $df00 is wCharSelectHandedness in WRAM bank $03.
UNION
; clear-status developer menu (bank $0a, WRAM bank $05)
; [8-bit] RunClearStatusSetupMenu's first choice (Text_34_215): 0 Set, 1 Continue, $ff cancelled. Continue and cancel skip straight to the result code; the menu keeps its state in WRAM bank $05 on top of the idle far-P1 character struct, cleared 32 bytes at a time on entry
w4ClearStatusMode:: db
; [8-bit] 0 singles, 1 doubles -- not asked, copied from FLAG_DOUBLES when Set is chosen. Picks the singles or doubles rank list and result-code row
w4ClearStatusDoubles:: db
; [8-bit] Second menu (Text_34_217): 0 Mini-Game, 1 Ranking Match; $ff steps back
w4ClearStatusFormat:: db
; [8-bit] Third menu (Text_34_218): 0 Junior, 1 Senior, 2 Varsity; $ff steps back. SetTrainingCourtClearFlags reads it as the drill level to mark cleared, the ranking routines as how many classes of wins to set
w4ClearStatusClass:: db
; [8-bit] Fourth menu: the drill (Text_34_219) for a Mini-Game clear, or the rank within the class (Text_34_220 and the per-class lists after it) for a Ranking Match clear; $ff steps back
w4ClearStatusRank:: db
; [8-bit] Window struct index of the caption frame CreateWindowFromScreenRect opened, redrawn before every menu
w4ClearStatusWindowId:: db
; [8-bit] What RunClearStatusSetupMenu returns in b: 8 cancelled, 1 Continue, else the ClearStatusResultCodeIndexTable entry for the choice
w4ClearStatusResultCode:: db
	ds 144
NEXTU
; text-arg fetch buffer (menu banks reuse the idle char struct)
; [bank 5] Scratch buffer that PushTextArgFetchedString fills (via FetchShortTextToBuffer) with a fetched short-text string, then pushes as a text argument; overlaps the idle far-P1 character struct at $df00
w4TextArgFetchBuffer:: db
NEXTU
; match character struct (WRAM banks 4-7, and the match/shot/results banks that address it with the bank already selected)
; [3 bytes] Per-character banked struct (WRAM4-7): lateral X position, 24-bit fixed point (fraction byte + signed 16-bit integer part)
w4CharPosX:: ds 3
; [3 bytes] Per-character banked struct (WRAM4-7): depth position (toward/away from net), same 24-bit fixed-point format; the two court sides carry opposite signs
w4CharPosDepth:: ds 3
; [3 bytes] Per-character banked struct (WRAM4-7): height above court, same 24-bit fixed-point format (zeroed by SetCharPosAndTarget)
w4CharPosHeight:: ds 3
; [8-bit] Per-character banked struct (WRAM4-7): serve/side role code (court-position record byte 4-7); XORed with 2 on the per-point side swap, mapped through the $4fa0 table at point start
w4CharServeRole:: db
; [8-bit] Per-character banked struct (WRAM4-7): court position code (court-position record byte 0-3; XORed with 3 on the tiebreak side-swap)
w4CharCourtPos:: db
; [8-bit] Per-character banked struct (WRAM4-7): character index 0-3 (== WRAM bank - 4); bit 0 set = far side (used by CharPointEndReaction and the edge-arrow sprite)
w4CharIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): facing this character returns to for its court position, from CourtPosFacingTable_08; PlaceCharAtBasePosition and UpdateCharFacingOctant measure the displayed facing against it
w4CharBaseFacing:: db
; [8-bit] Per-character banked struct (WRAM4-7): desired facing direction, eased toward by wCharFacingShown
w4CharFacingDesired:: db
; [8-bit] Per-character banked struct (WRAM4-7): displayed facing, eased toward wCharFacingDesired by at most wCharFacingEaseRate per frame ($75c0)
w4CharFacingShown:: db
; [8-bit] Per-character banked struct (WRAM4-7): state flags; bit 2 = airborne (set on jump $6dd5, cleared on landing; selects the shadow slot drawn)
w4CharFlags:: db
; [8-bit] Per-character banked struct (WRAM4-7): frames the character is frozen for: UpdateCharStateMachine decrements it and returns without running the state, so nothing moves. SetCharState clears it, and FreezeMinigameOpponentOnReturn sets it to hold the minigame opponent still
w4CharFreezeTimer:: db
; [8-bit] Per-character banked struct (WRAM4-7): frames left to press a second shot button; BufferShotButtonPress seeds it with 5 on the first press and the state-machine dispatch counts it down
w4CharShotComboTimer:: db
; [8-bit] Per-character banked struct (WRAM4-7): AI countdown -- the reaction delay AiSetReactionDelay randomises, and the hold time AiServePressToss uses to press and release the toss button
w4AiActionTimer:: db
; [8-bit] Frames the AI holds its first shot button before adding the second. AiWaitThenPickShot sets it to 5 right after AiPressFirstShotButton; AiSwingControlSingles/Doubles will not call AiPressSecondShotButton while it is nonzero, and the per-frame tick counts it down only once wAiActionTimer ($df12) has reached 0, so the two run in sequence rather than together.
w4AiSecondButtonDelay:: db
; [8-bit] Per-character banked struct (WRAM4-7): resolved SHOTTYPE_* for the swing about to happen, looked up by SelectServeShotType / SelectRallyShotType from the two buffered buttons
w4CharShotType:: db
; [8-bit] Per-character banked struct (WRAM4-7): animation id of the swing SelectForehandBackhand picked; the windup plays it + $08 and the contact phase plays it as-is
w4CharSwingAnim:: db
; [8-bit] Per-character banked struct (WRAM4-7): first shot button of the current swing (1 = A, 2 = B), 0 = none. The pair with wCharShotButton2 indexes RallyShotTypeTable0/1, which is how A+B combinations become lobs, drops and power shots
w4CharShotButton1:: db
; [8-bit] Per-character banked struct (WRAM4-7): second shot button, captured while wCharShotComboTimer is still running
w4CharShotButton2:: db
; [8-bit] Per-character banked struct (WRAM4-7): state-machine index (RST00 jumptable at $6a77; set via SetCharState)
w4CharState:: db
; [8-bit] Per-character banked struct (WRAM4-7): sub-step within wCharState; AdvanceCharStatePhase increments it and each state's phase routine dispatches on it
w4CharStatePhase:: db
; [8-bit] Per-character banked struct (WRAM4-7): sub-step of the AI state machine, advanced by AiAdvancePhase (the AI's own counter, separate from wCharStatePhase)
w4AiPhase:: db
; [3 bytes] Per-character banked struct (WRAM4-7): current sprite frame pointer (hi/lo) + h-flip flag, consumed by DrawCharSprite ($650a)
w4CharSpriteFrame:: ds 3
; [8-bit] Which input drives this character; ReadCharInput indexes CharInputPtrs with it (pad, CPU and link handlers)
w4CharInputSource:: db
; [8-bit] Input word ReadCharInput produces: held buttons in the high nibble, newly pressed in the low one (ReadCharPadInput builds it from hPlayerInputFlags and hInputRisingEdge); read with the PADB_* bits
w4CharInputBits:: db
	ds 1
; [8-bit] Per-character banked struct (WRAM4-7): object-definition id SetupCharSpriteFromObjectDef was handed; stored and never read again
w4CharObjectDefId:: db
; [8-bit] Per-character banked struct (WRAM4-7): ROM bank of this character's object definition, animation scripts and frame tables. GetPerspectiveScale banks it in through hRomBank / $2000 and SetCharAnimation and StepCharAnimation pass it to FarReadWordDI. 0 means no object is loaded, which is the test UpdateChar exits on
w4CharObjectBank:: db
	ds 1
; [16-bit] Per-character banked struct (WRAM4-7): pointer (in wCharObjectBank) to the frame graphics table GetPerspectiveScale walks to find a frame's tile data
w4CharFrameTablePtr:: dw
; [16-bit] Per-character banked struct (WRAM4-7): VRAM destination the character's frame tiles are copied to
w4CharFrameVramDest:: dw
; [16-bit] Per-character banked struct (WRAM4-7): pointer (in wCharObjectBank) to the object's animation-pointer table; SetCharAnimation indexes it by animation id
w4CharAnimTablePtr:: dw
; [16-bit] Per-character banked struct (WRAM4-7): start of the current animation script, which the $ff (jump) command rewinds to
w4CharAnimScriptBase:: dw
; [16-bit] Per-character banked struct (WRAM4-7): cursor into the current animation script. Commands are word-sized: < $f0 is [frame, delay], $ff jumps, $fe switches animation, $fb toggles the flip bits of wCharSpriteAttr
w4CharAnimScriptPtr:: dw
; [8-bit] Per-character banked struct (WRAM4-7): animation currently playing; SetCharAnimation returns early when asked for the one already running
w4CharAnimId:: db
; [8-bit] Per-character banked struct (WRAM4-7): frames left on the current animation frame; $ff means hold it indefinitely
w4CharAnimDelay:: db
; [8-bit] Per-character banked struct (WRAM4-7): sprite bookkeeping flags. Bit 6 = the frame or the facing octant changed, so ReloadCharFacingTiles must upload new tiles; it clears the bit itself
w4CharSpriteDirty:: db
	ds 1
; [8-bit] Per-character banked struct (WRAM4-7): facing octant 0-7, derived from wCharFacingShown; picks the tile row and, for octants 2 and 6, the mirrored sprite
w4CharFacingOctant:: db
; [8-bit] Per-character banked struct (WRAM4-7): frame id the animation script last selected
w4CharAnimFrame:: db
	ds 2
; [8-bit] Per-character banked struct (WRAM4-7): first VRAM tile of this character's sprite, from a per-character-index table
w4CharTileBase:: db
; [8-bit] Per-character banked struct (WRAM4-7): OAM attribute byte for the character. The low three bits are the CGB OBJ palette (wCharIndex + 4) and double as the tile-block index ReloadCharFrameGfx uploads into (& $07, + $08); the high bits are the flip bits the animation script's $fb command toggles, and SetCharAnimation clears them with `and $0f`
w4CharSpriteAttr:: db
; [16-bit] Per-character banked struct (WRAM4-7): pointer (in wCharObjectBank) to the per-frame shadow/scale table GetPerspectiveScale reads
w4CharShadowTablePtr:: dw
; [8-bit] Per-character banked struct (WRAM4-7): ROM bank holding the character's frame graphics; ReloadCharFrameGfx and LoadCharChargeFlashGfx pass it to the bank $00 far-call vector at $0110
w4CharGfxBank:: db
	ds 5
; [16-bit] Per-character banked struct (WRAM4-7): X velocity (zeroed on placement and at point end)
w4CharVelX:: dw
; [16-bit] Per-character banked struct (WRAM4-7): depth velocity
w4CharVelDepth:: dw
; [16-bit] Per-character banked struct (WRAM4-7): height velocity
w4CharVelHeight:: dw
; [16-bit] Per-character banked struct (WRAM4-7): walk-target X (integer part)
w4CharWalkTargetX:: dw
; [16-bit] Per-character banked struct (WRAM4-7): walk-target depth; MoveCharTowardTarget ($7541) walks toward it, snapping when both deltas < $18 (CheckCharNearTarget $78be)
w4CharWalkTargetDepth:: dw
; [8-bit] Per-character banked struct (WRAM4-7): aim the player asked for with left/right at the moment of the shot, captured by CaptureServeAim / CaptureShotAim. GetShotAimOffsetForSide and ComputeShotTargetX turn it into the target's lateral offset
w4CharAimOffset:: db
; [8-bit] Per-character banked struct (WRAM4-7): frames elapsed in the current swing phase, reset when the windup starts and incremented by the windup and contact phases
w4CharSwingFrames:: db
; [8-bit] Set when this character's swing was a quick (uncharged) one. StartCharSwing writes it as the swing begins and ExecuteShot reads it back to seed wShotWasQuickSwing, which is what makes the shot resolve without a charge bonus. It was previously declared on the menu-bank variant of this union, where nothing could reach it.
w4CharQuickSwing:: db
; [8-bit] Shot button latched while the swing is being held, from b in CheckSwingRelease; cleared there when SELECT is down and again by CharRallyReadyPhase alongside wCharSwingFrames. Nothing ever reads it -- the byte is written on three paths and consumed on none, so it is vestigial.
w4CharSwingHoldButton:: db
; [8-bit] Frames the swing has been held: CheckSwingRelease increments it once per frame through `ld hl, $df4e / inc [hl]` and zeroes it on release or when SELECT is down. Write-only like wCharSwingHoldButton -- no site reads the count back, so whatever charge mechanic it fed is gone.
w4CharSwingHoldFrames:: db
; [8-bit] Per-character banked struct (WRAM4-7): shot button already recorded, so BufferShotButtonPress ignores it being held
w4CharLastShotButton:: db
; [8-bit] Per-character banked struct (WRAM4-7): result of this frame's ball-geometry tests: bit 0 = ball within swing range, bit 1 = inside the contact window, bit 4 = within normal reach (clear selects the stretching shot table). Rebuilt every frame by UpdateCharBallGeometry
w4CharBallReachFlags:: db
; [8-bit] Per-character banked struct (WRAM4-7): set while the charge flash is playing; cleared when the swing starts or aborts
w4CharChargeFlashOn:: db
; [8-bit] Per-character banked struct (WRAM4-7): 1 while the flashed tiles are the ones in VRAM. UpdateChargeFlash toggles the flash on wCharSwingFrames bit 2, and this latch is what makes each half of that cycle load its graphics once -- set it and call LoadCharChargeFlashGfx, or clear it and call ReloadCharFrameGfx
w4CharChargeFlashGfxLoaded:: db
; [8-bit] Per-character banked struct (WRAM4-7): last projected screen X (BuildCharSpriteSlots $7672)
w4CharScreenX:: db
; [8-bit] Per-character banked struct (WRAM4-7): last projected screen Y
w4CharScreenY:: db
; [8-bit] Zeroed immediately after each write of wCharWalkTargetX / wCharWalkTargetDepth, on both paths that set a walk target. Nothing reads it -- the two writes are the only references in the ROM -- so whatever it once qualified about the target is gone.
w4CharWalkTargetFlag:: db
; [8-bit] Per-character banked struct (WRAM4-7): set to 1 by MoveCharTowardTarget once it has stepped the character toward wCharWalkTargetX/wCharWalkTargetDepth. UpdateCharStateMachine clears it at the top of every frame and UpdateCharVelocityFromInput returns immediately while it is set, so a scripted walk overrides the stick for that frame
w4CharScriptedMove:: db
; [8-bit] Per-character banked struct (WRAM4-7): point result from this character's perspective (signed wPointWinLoseFlag)
w4CharPointResult:: db
; [8-bit] Per-character banked struct (WRAM4-7): shot buttons the AI decided to press this swing (AiPickServeButtons / AiPickShotButtons); AiPressFirstShotButton and AiPressSecondShotButton feed them into wCharInputBits one at a time
w4AiShotButtons:: db
; [8-bit] Working countdown seeded from wAiTrackingParam every time the AI advances a phase after fixing a target. AiWaitThenPickShot decrements it once per frame and will not pick a shot until it reaches 0 (or until bit 0 of wCharBallReachFlags says the ball is already in reach), so a larger tracking parameter makes the character commit later.
w4AiTrackingCountdown:: db
; [8-bit] Set to 1 by CharRallyReadyPhase and cleared alongside wCharShotButton1/2 when a shot is abandoned. AiTrackBallPhase returns without steering while it is 0, so it gates AI movement toward the target on the character actually being in the rally-ready state.
w4CharRallyReady:: db
	ds 5
; [16-bit LE] Speed limit along the X axis: ClampCharXSpeed multiplies it by the cosine of wCharFacingDesired, mirroring what ClampCharDepthSpeed does with wCharMaxSpeedDepth. From CharStatTable_07_0 indexed by attribute byte $0027 alone.
w4CharMaxSpeedX:: dw
; [16-bit LE] Speed limit along the depth axis: ClampCharDepthSpeed multiplies it by the sine of wCharFacingDesired so the clamp follows the run direction. LoadCharacterAttributes indexes CharStatTable_07_0 with attribute bytes $0027 + $002b summed and doubled, clamped to the table's ten entries -- the same table wCharMaxSpeedX reads, but that one uses $0027 alone, so this axis gets whatever bonus $002b carries.
w4CharMaxSpeedDepth:: dw
; [16-bit LE] How hard this character accelerates, from CharStatTable_07_1 via attribute-struct offset $0028. AccelerateCharDepth and AccelerateCharX multiply it by the sine/cosine of wCharFacingDesired and add the result to wCharVelDepth / wCharVelX, so one value drives both axes.
w4CharAcceleration:: dw
; [16-bit LE] How hard this character slows when not accelerating, from CharStatTable_07_2 via attribute-struct offset $002a. The two brake routines negate it against bit 7 of the current velocity so it always opposes motion; one of them substitutes a flat $0040 when bit 1 of wCharFlags is clear.
w4CharDeceleration:: dw
; [8-bit] Per-character banked struct (WRAM4-7): max facing change per frame, easing wCharFacingShown toward wCharFacingDesired
w4CharFacingEaseRate:: db
; [8-bit] Scales how far this character's aim is pushed off centre: ComputeAimBaseOffset feeds it to MulHLByAFrac as the fraction applied to the base offset. From CharStatTable_07_4 via attribute-struct offset $0025.
w4CharAimOffsetScale:: db
; [8-bit] Magnitude of the random component of this character's aim: GetRandomAimJitter multiplies a fresh AdvanceMatchRng byte by it (MulHLByA). Higher means a less accurate shot. From CharStatTable_07_5 via attribute-struct offset $0026.
w4CharAimJitterScale:: db
; [8-bit] Per-character banked struct (WRAM4-7): speed-row index (e) into the ShotPlacementData tables for ground strokes (topspin/slice/power variants/neutral); selects bytes 4-5 -> shot speed in LoadShotPlacementEntry
w4GroundStrokeSpeedIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): speed-row index (e) into ShotPlacementData for the smash and all three serves
w4SmashServeSpeedIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): speed-row index (e) into ShotPlacementData for the reach (smash-range) shot variants
w4ReachSpeedIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): placement-row index (d) into ShotPlacementData for topspin and serve-topspin; selects bytes 0-3 -> target offsets in LoadShotPlacementEntry
w4TopspinPlacementIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): placement-row index (d) into ShotPlacementData for slice and serve-slice
w4SlicePlacementIndex:: db
; [16-bit] Per-character banked struct (WRAM4-7): how far above or below the character the ball may be and still be hit; CheckCharBallContact compares |wBallRelCharHeight| against it. Loaded from the character attribute record +$10, minus $10
w4CharReachHeight:: dw
; [16-bit] Per-character banked struct (WRAM4-7): lateral reach: CheckCharBallContact compares |wBallRelCharX| * 2 against it. Attribute record +$12
w4CharReachX:: dw
; [16-bit] Per-character banked struct (WRAM4-7): upward speed of a jump smash, negated into wCharVelHeight by StartCharSwing. Attribute record +$14, plus $0200
w4CharSmashJumpSpeed:: dw
; [16-bit] Per-character banked struct (WRAM4-7): lunge speed of a dive, turned into wCharVelX/wCharVelDepth through VectorFromLengthAndAngleRaw at the character's facing. Attribute record +$16
w4CharDiveSpeed:: dw
; [8-bit] Per-character banked struct (WRAM4-7): character id InitChar was handed, before RemapExtendedCharId
w4CharId:: db
; [8-bit] Per-character banked struct (WRAM4-7): base frames the AI waits before reacting when the ball is within normal reach; AiSetReactionDelay adds a 0-3 random and stores wAiActionTimer. Attribute record +$1b
w4AiReactionDelayNear:: db
; [8-bit] Per-character banked struct (WRAM4-7): same, for a ball outside normal reach (wCharBallReachFlags bit 4 clear), so a stretching return can be made deliberately slower. Attribute record +$1c
w4AiReactionDelayFar:: db
; [8-bit] Per-character banked struct (WRAM4-7): how the AI chases the ball -- read by AiTrackBallPhase and the baseliner rally state. Attribute record +$1d
w4AiTrackingParam:: db
; [8-bit] Per-character banked struct (WRAM4-7): RNG threshold in AiMaybeAimAwayFromChar: the AI aims away from the opponent when the roll is under it, so a higher value places more shots. Attribute record +$1e
w4AiAimAwayChance:: db
; [8-bit] Per-character banked struct (WRAM4-7): AI serve/shot habit: the low nibble indexes ServePressTossPtrs for the toss timing, and AiPickShotButtons reads it too. Attribute record +$1f
w4AiServeStyle:: db
; [8-bit] Per-character banked struct (WRAM4-7): character id after RemapExtendedCharId; LookupCharSpriteSet and bank $09's LoadOnCourtCharacterGfx use it to find the sprite bank
w4CharSpriteSetId:: db
; [8-bit] Per-character banked struct (WRAM4-7): where the AI stands between shots (0/5 baseline, 1 net, others mid-court); an RST00 jumptable index in AiChooseHomePosition and AiChoosePositionByStrategy. Attribute record +$0f
w4AiPositionStrategy:: db
; [4 bytes] Per-character banked struct (WRAM4-7): sprite-slot record [tile, attr, screenY, screenX] for the character sprite
w4CharSpriteSlot:: ds 4
; [4 bytes] The frame descriptor the single-character screens park after the sprite slot: Unused_1a_DrawCharViewerCharSprite ($1a:$706c) and the results/EXP screen drawers ($1e:$4b08, $5947) write eight bytes at wCharSpriteSlot -- the slot's [tile, attr, y, x], then wCharSpriteFrame + 2 (the 32x32 flag), + 1 and + 0 (the Y and X offsets QueueSprite24x32 adds) and a depth key (slot * 8 + $80, the shape of wCharDepthKey). The match engine's own drawer never writes it (its slot reset covers only the three records at +$00, +$08, +$0c), which is why a RAM poison run saw it filled on the status screen and in the credits but not in a match
w4CharSpriteSlotFrame:: ds 4
; [4 bytes] Per-character banked struct (WRAM4-7): sprite-slot record for the airborne shadow (tiles $50/$52/$54/$56 shrink with jump height; drawn only while wCharFlags bit 2 set)
w4CharAirShadowSlot:: ds 4
; [4 bytes] Per-character banked struct (WRAM4-7): sprite-slot record for the standing shadow (tile $58; flicker-transparency while grounded)
w4CharGroundShadowSlot:: ds 4
; [16-bit] Per-character banked struct (WRAM4-7): attribute word read from the character record +$19; StartCharSwing tests bit 7 of the low byte, and bits 0 and 1 of wCharSwingAttrWord + 1 select the lob and drop placement rows
w4CharSwingAttrWord:: dw
; [8-bit] Per-character banked struct (WRAM4-7): placement-row index (d) into ShotPlacementDataLob (set from df91 bit 0)
w4LobPlacementIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): placement-row index (d) into ShotPlacementDataDrop (set from df91 bit 1)
w4DropPlacementIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): attribute bits XORed into wCharSpriteAttr when the facing octant is 2 or 6, i.e. when the sprite is drawn mirrored
w4CharMirrorAttrMask:: db
; [8-bit] Per-character banked struct (WRAM4-7): character class/tier from attribute record +$18; LookupExpTierForChar reads it on the EXP screen
w4CharExpTier:: db
; [8-bit] Per-character banked struct (WRAM4-7): draw-order depth key ((depth*8)>>8 + $80); DrawActorsByDepth paints teammates back-to-front
w4CharDepthKey:: db
ENDU


SECTION "WRAMX bank 5 $df00", WRAMX[$df00], BANK[5]

; One copy per character of a structure that lives in WRAM banks 4-7
; at once. Each bank declares its own copy under a bank-tagged name, so the
; symbol file resolves the right one whichever bank the debugger is stopped in
; -- this is bank 5's. The disassembly itself uses the untagged name, an EQU
; in include/ram_mirrored.inc, because the bank is chosen at run time.

; Match-engine per-character struct, replicated across WRAM banks 4-7
; (bank = character: 4 near-P1, 5 far-P1, 6 near-partner, 7 far-partner).
; Same field, different character per bank -- one name each. Scoped by the
; provably-selected WRAM bank, plus the match banks $07/$08 whose
; callback-reached (jp hl) accesses the dataflow can't prove. Only the
; named field offsets render; other $dfxx bytes stay numeric.
; The character-select screen drives the same struct: bank $38 runs
; UpdateCharSelectCharSprite and TickCharSelectIdleAnim once per preview
; character, selecting WRAM banks $04-$07 in turn, so those two routines get
; instruction-range scopes rather than a whole-bank one -- bank $38's own
; $df00 is wCharSelectHandedness in WRAM bank $03.
UNION
; clear-status developer menu (bank $0a, WRAM bank $05)
; [8-bit] RunClearStatusSetupMenu's first choice (Text_34_215): 0 Set, 1 Continue, $ff cancelled. Continue and cancel skip straight to the result code; the menu keeps its state in WRAM bank $05 on top of the idle far-P1 character struct, cleared 32 bytes at a time on entry
w5ClearStatusMode:: db
; [8-bit] 0 singles, 1 doubles -- not asked, copied from FLAG_DOUBLES when Set is chosen. Picks the singles or doubles rank list and result-code row
w5ClearStatusDoubles:: db
; [8-bit] Second menu (Text_34_217): 0 Mini-Game, 1 Ranking Match; $ff steps back
w5ClearStatusFormat:: db
; [8-bit] Third menu (Text_34_218): 0 Junior, 1 Senior, 2 Varsity; $ff steps back. SetTrainingCourtClearFlags reads it as the drill level to mark cleared, the ranking routines as how many classes of wins to set
w5ClearStatusClass:: db
; [8-bit] Fourth menu: the drill (Text_34_219) for a Mini-Game clear, or the rank within the class (Text_34_220 and the per-class lists after it) for a Ranking Match clear; $ff steps back
w5ClearStatusRank:: db
; [8-bit] Window struct index of the caption frame CreateWindowFromScreenRect opened, redrawn before every menu
w5ClearStatusWindowId:: db
; [8-bit] What RunClearStatusSetupMenu returns in b: 8 cancelled, 1 Continue, else the ClearStatusResultCodeIndexTable entry for the choice
w5ClearStatusResultCode:: db
	ds 144
NEXTU
; text-arg fetch buffer (menu banks reuse the idle char struct)
; [bank 5] Scratch buffer that PushTextArgFetchedString fills (via FetchShortTextToBuffer) with a fetched short-text string, then pushes as a text argument; overlaps the idle far-P1 character struct at $df00
w5TextArgFetchBuffer:: db
NEXTU
; match character struct (WRAM banks 4-7, and the match/shot/results banks that address it with the bank already selected)
; [3 bytes] Per-character banked struct (WRAM4-7): lateral X position, 24-bit fixed point (fraction byte + signed 16-bit integer part)
w5CharPosX:: ds 3
; [3 bytes] Per-character banked struct (WRAM4-7): depth position (toward/away from net), same 24-bit fixed-point format; the two court sides carry opposite signs
w5CharPosDepth:: ds 3
; [3 bytes] Per-character banked struct (WRAM4-7): height above court, same 24-bit fixed-point format (zeroed by SetCharPosAndTarget)
w5CharPosHeight:: ds 3
; [8-bit] Per-character banked struct (WRAM4-7): serve/side role code (court-position record byte 4-7); XORed with 2 on the per-point side swap, mapped through the $4fa0 table at point start
w5CharServeRole:: db
; [8-bit] Per-character banked struct (WRAM4-7): court position code (court-position record byte 0-3; XORed with 3 on the tiebreak side-swap)
w5CharCourtPos:: db
; [8-bit] Per-character banked struct (WRAM4-7): character index 0-3 (== WRAM bank - 4); bit 0 set = far side (used by CharPointEndReaction and the edge-arrow sprite)
w5CharIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): facing this character returns to for its court position, from CourtPosFacingTable_08; PlaceCharAtBasePosition and UpdateCharFacingOctant measure the displayed facing against it
w5CharBaseFacing:: db
; [8-bit] Per-character banked struct (WRAM4-7): desired facing direction, eased toward by wCharFacingShown
w5CharFacingDesired:: db
; [8-bit] Per-character banked struct (WRAM4-7): displayed facing, eased toward wCharFacingDesired by at most wCharFacingEaseRate per frame ($75c0)
w5CharFacingShown:: db
; [8-bit] Per-character banked struct (WRAM4-7): state flags; bit 2 = airborne (set on jump $6dd5, cleared on landing; selects the shadow slot drawn)
w5CharFlags:: db
; [8-bit] Per-character banked struct (WRAM4-7): frames the character is frozen for: UpdateCharStateMachine decrements it and returns without running the state, so nothing moves. SetCharState clears it, and FreezeMinigameOpponentOnReturn sets it to hold the minigame opponent still
w5CharFreezeTimer:: db
; [8-bit] Per-character banked struct (WRAM4-7): frames left to press a second shot button; BufferShotButtonPress seeds it with 5 on the first press and the state-machine dispatch counts it down
w5CharShotComboTimer:: db
; [8-bit] Per-character banked struct (WRAM4-7): AI countdown -- the reaction delay AiSetReactionDelay randomises, and the hold time AiServePressToss uses to press and release the toss button
w5AiActionTimer:: db
; [8-bit] Frames the AI holds its first shot button before adding the second. AiWaitThenPickShot sets it to 5 right after AiPressFirstShotButton; AiSwingControlSingles/Doubles will not call AiPressSecondShotButton while it is nonzero, and the per-frame tick counts it down only once wAiActionTimer ($df12) has reached 0, so the two run in sequence rather than together.
w5AiSecondButtonDelay:: db
; [8-bit] Per-character banked struct (WRAM4-7): resolved SHOTTYPE_* for the swing about to happen, looked up by SelectServeShotType / SelectRallyShotType from the two buffered buttons
w5CharShotType:: db
; [8-bit] Per-character banked struct (WRAM4-7): animation id of the swing SelectForehandBackhand picked; the windup plays it + $08 and the contact phase plays it as-is
w5CharSwingAnim:: db
; [8-bit] Per-character banked struct (WRAM4-7): first shot button of the current swing (1 = A, 2 = B), 0 = none. The pair with wCharShotButton2 indexes RallyShotTypeTable0/1, which is how A+B combinations become lobs, drops and power shots
w5CharShotButton1:: db
; [8-bit] Per-character banked struct (WRAM4-7): second shot button, captured while wCharShotComboTimer is still running
w5CharShotButton2:: db
; [8-bit] Per-character banked struct (WRAM4-7): state-machine index (RST00 jumptable at $6a77; set via SetCharState)
w5CharState:: db
; [8-bit] Per-character banked struct (WRAM4-7): sub-step within wCharState; AdvanceCharStatePhase increments it and each state's phase routine dispatches on it
w5CharStatePhase:: db
; [8-bit] Per-character banked struct (WRAM4-7): sub-step of the AI state machine, advanced by AiAdvancePhase (the AI's own counter, separate from wCharStatePhase)
w5AiPhase:: db
; [3 bytes] Per-character banked struct (WRAM4-7): current sprite frame pointer (hi/lo) + h-flip flag, consumed by DrawCharSprite ($650a)
w5CharSpriteFrame:: ds 3
; [8-bit] Which input drives this character; ReadCharInput indexes CharInputPtrs with it (pad, CPU and link handlers)
w5CharInputSource:: db
; [8-bit] Input word ReadCharInput produces: held buttons in the high nibble, newly pressed in the low one (ReadCharPadInput builds it from hPlayerInputFlags and hInputRisingEdge); read with the PADB_* bits
w5CharInputBits:: db
	ds 1
; [8-bit] Per-character banked struct (WRAM4-7): object-definition id SetupCharSpriteFromObjectDef was handed; stored and never read again
w5CharObjectDefId:: db
; [8-bit] Per-character banked struct (WRAM4-7): ROM bank of this character's object definition, animation scripts and frame tables. GetPerspectiveScale banks it in through hRomBank / $2000 and SetCharAnimation and StepCharAnimation pass it to FarReadWordDI. 0 means no object is loaded, which is the test UpdateChar exits on
w5CharObjectBank:: db
	ds 1
; [16-bit] Per-character banked struct (WRAM4-7): pointer (in wCharObjectBank) to the frame graphics table GetPerspectiveScale walks to find a frame's tile data
w5CharFrameTablePtr:: dw
; [16-bit] Per-character banked struct (WRAM4-7): VRAM destination the character's frame tiles are copied to
w5CharFrameVramDest:: dw
; [16-bit] Per-character banked struct (WRAM4-7): pointer (in wCharObjectBank) to the object's animation-pointer table; SetCharAnimation indexes it by animation id
w5CharAnimTablePtr:: dw
; [16-bit] Per-character banked struct (WRAM4-7): start of the current animation script, which the $ff (jump) command rewinds to
w5CharAnimScriptBase:: dw
; [16-bit] Per-character banked struct (WRAM4-7): cursor into the current animation script. Commands are word-sized: < $f0 is [frame, delay], $ff jumps, $fe switches animation, $fb toggles the flip bits of wCharSpriteAttr
w5CharAnimScriptPtr:: dw
; [8-bit] Per-character banked struct (WRAM4-7): animation currently playing; SetCharAnimation returns early when asked for the one already running
w5CharAnimId:: db
; [8-bit] Per-character banked struct (WRAM4-7): frames left on the current animation frame; $ff means hold it indefinitely
w5CharAnimDelay:: db
; [8-bit] Per-character banked struct (WRAM4-7): sprite bookkeeping flags. Bit 6 = the frame or the facing octant changed, so ReloadCharFacingTiles must upload new tiles; it clears the bit itself
w5CharSpriteDirty:: db
	ds 1
; [8-bit] Per-character banked struct (WRAM4-7): facing octant 0-7, derived from wCharFacingShown; picks the tile row and, for octants 2 and 6, the mirrored sprite
w5CharFacingOctant:: db
; [8-bit] Per-character banked struct (WRAM4-7): frame id the animation script last selected
w5CharAnimFrame:: db
	ds 2
; [8-bit] Per-character banked struct (WRAM4-7): first VRAM tile of this character's sprite, from a per-character-index table
w5CharTileBase:: db
; [8-bit] Per-character banked struct (WRAM4-7): OAM attribute byte for the character. The low three bits are the CGB OBJ palette (wCharIndex + 4) and double as the tile-block index ReloadCharFrameGfx uploads into (& $07, + $08); the high bits are the flip bits the animation script's $fb command toggles, and SetCharAnimation clears them with `and $0f`
w5CharSpriteAttr:: db
; [16-bit] Per-character banked struct (WRAM4-7): pointer (in wCharObjectBank) to the per-frame shadow/scale table GetPerspectiveScale reads
w5CharShadowTablePtr:: dw
; [8-bit] Per-character banked struct (WRAM4-7): ROM bank holding the character's frame graphics; ReloadCharFrameGfx and LoadCharChargeFlashGfx pass it to the bank $00 far-call vector at $0110
w5CharGfxBank:: db
	ds 5
; [16-bit] Per-character banked struct (WRAM4-7): X velocity (zeroed on placement and at point end)
w5CharVelX:: dw
; [16-bit] Per-character banked struct (WRAM4-7): depth velocity
w5CharVelDepth:: dw
; [16-bit] Per-character banked struct (WRAM4-7): height velocity
w5CharVelHeight:: dw
; [16-bit] Per-character banked struct (WRAM4-7): walk-target X (integer part)
w5CharWalkTargetX:: dw
; [16-bit] Per-character banked struct (WRAM4-7): walk-target depth; MoveCharTowardTarget ($7541) walks toward it, snapping when both deltas < $18 (CheckCharNearTarget $78be)
w5CharWalkTargetDepth:: dw
; [8-bit] Per-character banked struct (WRAM4-7): aim the player asked for with left/right at the moment of the shot, captured by CaptureServeAim / CaptureShotAim. GetShotAimOffsetForSide and ComputeShotTargetX turn it into the target's lateral offset
w5CharAimOffset:: db
; [8-bit] Per-character banked struct (WRAM4-7): frames elapsed in the current swing phase, reset when the windup starts and incremented by the windup and contact phases
w5CharSwingFrames:: db
; [8-bit] Set when this character's swing was a quick (uncharged) one. StartCharSwing writes it as the swing begins and ExecuteShot reads it back to seed wShotWasQuickSwing, which is what makes the shot resolve without a charge bonus. It was previously declared on the menu-bank variant of this union, where nothing could reach it.
w5CharQuickSwing:: db
; [8-bit] Shot button latched while the swing is being held, from b in CheckSwingRelease; cleared there when SELECT is down and again by CharRallyReadyPhase alongside wCharSwingFrames. Nothing ever reads it -- the byte is written on three paths and consumed on none, so it is vestigial.
w5CharSwingHoldButton:: db
; [8-bit] Frames the swing has been held: CheckSwingRelease increments it once per frame through `ld hl, $df4e / inc [hl]` and zeroes it on release or when SELECT is down. Write-only like wCharSwingHoldButton -- no site reads the count back, so whatever charge mechanic it fed is gone.
w5CharSwingHoldFrames:: db
; [8-bit] Per-character banked struct (WRAM4-7): shot button already recorded, so BufferShotButtonPress ignores it being held
w5CharLastShotButton:: db
; [8-bit] Per-character banked struct (WRAM4-7): result of this frame's ball-geometry tests: bit 0 = ball within swing range, bit 1 = inside the contact window, bit 4 = within normal reach (clear selects the stretching shot table). Rebuilt every frame by UpdateCharBallGeometry
w5CharBallReachFlags:: db
; [8-bit] Per-character banked struct (WRAM4-7): set while the charge flash is playing; cleared when the swing starts or aborts
w5CharChargeFlashOn:: db
; [8-bit] Per-character banked struct (WRAM4-7): 1 while the flashed tiles are the ones in VRAM. UpdateChargeFlash toggles the flash on wCharSwingFrames bit 2, and this latch is what makes each half of that cycle load its graphics once -- set it and call LoadCharChargeFlashGfx, or clear it and call ReloadCharFrameGfx
w5CharChargeFlashGfxLoaded:: db
; [8-bit] Per-character banked struct (WRAM4-7): last projected screen X (BuildCharSpriteSlots $7672)
w5CharScreenX:: db
; [8-bit] Per-character banked struct (WRAM4-7): last projected screen Y
w5CharScreenY:: db
; [8-bit] Zeroed immediately after each write of wCharWalkTargetX / wCharWalkTargetDepth, on both paths that set a walk target. Nothing reads it -- the two writes are the only references in the ROM -- so whatever it once qualified about the target is gone.
w5CharWalkTargetFlag:: db
; [8-bit] Per-character banked struct (WRAM4-7): set to 1 by MoveCharTowardTarget once it has stepped the character toward wCharWalkTargetX/wCharWalkTargetDepth. UpdateCharStateMachine clears it at the top of every frame and UpdateCharVelocityFromInput returns immediately while it is set, so a scripted walk overrides the stick for that frame
w5CharScriptedMove:: db
; [8-bit] Per-character banked struct (WRAM4-7): point result from this character's perspective (signed wPointWinLoseFlag)
w5CharPointResult:: db
; [8-bit] Per-character banked struct (WRAM4-7): shot buttons the AI decided to press this swing (AiPickServeButtons / AiPickShotButtons); AiPressFirstShotButton and AiPressSecondShotButton feed them into wCharInputBits one at a time
w5AiShotButtons:: db
; [8-bit] Working countdown seeded from wAiTrackingParam every time the AI advances a phase after fixing a target. AiWaitThenPickShot decrements it once per frame and will not pick a shot until it reaches 0 (or until bit 0 of wCharBallReachFlags says the ball is already in reach), so a larger tracking parameter makes the character commit later.
w5AiTrackingCountdown:: db
; [8-bit] Set to 1 by CharRallyReadyPhase and cleared alongside wCharShotButton1/2 when a shot is abandoned. AiTrackBallPhase returns without steering while it is 0, so it gates AI movement toward the target on the character actually being in the rally-ready state.
w5CharRallyReady:: db
	ds 5
; [16-bit LE] Speed limit along the X axis: ClampCharXSpeed multiplies it by the cosine of wCharFacingDesired, mirroring what ClampCharDepthSpeed does with wCharMaxSpeedDepth. From CharStatTable_07_0 indexed by attribute byte $0027 alone.
w5CharMaxSpeedX:: dw
; [16-bit LE] Speed limit along the depth axis: ClampCharDepthSpeed multiplies it by the sine of wCharFacingDesired so the clamp follows the run direction. LoadCharacterAttributes indexes CharStatTable_07_0 with attribute bytes $0027 + $002b summed and doubled, clamped to the table's ten entries -- the same table wCharMaxSpeedX reads, but that one uses $0027 alone, so this axis gets whatever bonus $002b carries.
w5CharMaxSpeedDepth:: dw
; [16-bit LE] How hard this character accelerates, from CharStatTable_07_1 via attribute-struct offset $0028. AccelerateCharDepth and AccelerateCharX multiply it by the sine/cosine of wCharFacingDesired and add the result to wCharVelDepth / wCharVelX, so one value drives both axes.
w5CharAcceleration:: dw
; [16-bit LE] How hard this character slows when not accelerating, from CharStatTable_07_2 via attribute-struct offset $002a. The two brake routines negate it against bit 7 of the current velocity so it always opposes motion; one of them substitutes a flat $0040 when bit 1 of wCharFlags is clear.
w5CharDeceleration:: dw
; [8-bit] Per-character banked struct (WRAM4-7): max facing change per frame, easing wCharFacingShown toward wCharFacingDesired
w5CharFacingEaseRate:: db
; [8-bit] Scales how far this character's aim is pushed off centre: ComputeAimBaseOffset feeds it to MulHLByAFrac as the fraction applied to the base offset. From CharStatTable_07_4 via attribute-struct offset $0025.
w5CharAimOffsetScale:: db
; [8-bit] Magnitude of the random component of this character's aim: GetRandomAimJitter multiplies a fresh AdvanceMatchRng byte by it (MulHLByA). Higher means a less accurate shot. From CharStatTable_07_5 via attribute-struct offset $0026.
w5CharAimJitterScale:: db
; [8-bit] Per-character banked struct (WRAM4-7): speed-row index (e) into the ShotPlacementData tables for ground strokes (topspin/slice/power variants/neutral); selects bytes 4-5 -> shot speed in LoadShotPlacementEntry
w5GroundStrokeSpeedIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): speed-row index (e) into ShotPlacementData for the smash and all three serves
w5SmashServeSpeedIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): speed-row index (e) into ShotPlacementData for the reach (smash-range) shot variants
w5ReachSpeedIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): placement-row index (d) into ShotPlacementData for topspin and serve-topspin; selects bytes 0-3 -> target offsets in LoadShotPlacementEntry
w5TopspinPlacementIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): placement-row index (d) into ShotPlacementData for slice and serve-slice
w5SlicePlacementIndex:: db
; [16-bit] Per-character banked struct (WRAM4-7): how far above or below the character the ball may be and still be hit; CheckCharBallContact compares |wBallRelCharHeight| against it. Loaded from the character attribute record +$10, minus $10
w5CharReachHeight:: dw
; [16-bit] Per-character banked struct (WRAM4-7): lateral reach: CheckCharBallContact compares |wBallRelCharX| * 2 against it. Attribute record +$12
w5CharReachX:: dw
; [16-bit] Per-character banked struct (WRAM4-7): upward speed of a jump smash, negated into wCharVelHeight by StartCharSwing. Attribute record +$14, plus $0200
w5CharSmashJumpSpeed:: dw
; [16-bit] Per-character banked struct (WRAM4-7): lunge speed of a dive, turned into wCharVelX/wCharVelDepth through VectorFromLengthAndAngleRaw at the character's facing. Attribute record +$16
w5CharDiveSpeed:: dw
; [8-bit] Per-character banked struct (WRAM4-7): character id InitChar was handed, before RemapExtendedCharId
w5CharId:: db
; [8-bit] Per-character banked struct (WRAM4-7): base frames the AI waits before reacting when the ball is within normal reach; AiSetReactionDelay adds a 0-3 random and stores wAiActionTimer. Attribute record +$1b
w5AiReactionDelayNear:: db
; [8-bit] Per-character banked struct (WRAM4-7): same, for a ball outside normal reach (wCharBallReachFlags bit 4 clear), so a stretching return can be made deliberately slower. Attribute record +$1c
w5AiReactionDelayFar:: db
; [8-bit] Per-character banked struct (WRAM4-7): how the AI chases the ball -- read by AiTrackBallPhase and the baseliner rally state. Attribute record +$1d
w5AiTrackingParam:: db
; [8-bit] Per-character banked struct (WRAM4-7): RNG threshold in AiMaybeAimAwayFromChar: the AI aims away from the opponent when the roll is under it, so a higher value places more shots. Attribute record +$1e
w5AiAimAwayChance:: db
; [8-bit] Per-character banked struct (WRAM4-7): AI serve/shot habit: the low nibble indexes ServePressTossPtrs for the toss timing, and AiPickShotButtons reads it too. Attribute record +$1f
w5AiServeStyle:: db
; [8-bit] Per-character banked struct (WRAM4-7): character id after RemapExtendedCharId; LookupCharSpriteSet and bank $09's LoadOnCourtCharacterGfx use it to find the sprite bank
w5CharSpriteSetId:: db
; [8-bit] Per-character banked struct (WRAM4-7): where the AI stands between shots (0/5 baseline, 1 net, others mid-court); an RST00 jumptable index in AiChooseHomePosition and AiChoosePositionByStrategy. Attribute record +$0f
w5AiPositionStrategy:: db
; [4 bytes] Per-character banked struct (WRAM4-7): sprite-slot record [tile, attr, screenY, screenX] for the character sprite
w5CharSpriteSlot:: ds 4
; [4 bytes] The frame descriptor the single-character screens park after the sprite slot: Unused_1a_DrawCharViewerCharSprite ($1a:$706c) and the results/EXP screen drawers ($1e:$4b08, $5947) write eight bytes at wCharSpriteSlot -- the slot's [tile, attr, y, x], then wCharSpriteFrame + 2 (the 32x32 flag), + 1 and + 0 (the Y and X offsets QueueSprite24x32 adds) and a depth key (slot * 8 + $80, the shape of wCharDepthKey). The match engine's own drawer never writes it (its slot reset covers only the three records at +$00, +$08, +$0c), which is why a RAM poison run saw it filled on the status screen and in the credits but not in a match
w5CharSpriteSlotFrame:: ds 4
; [4 bytes] Per-character banked struct (WRAM4-7): sprite-slot record for the airborne shadow (tiles $50/$52/$54/$56 shrink with jump height; drawn only while wCharFlags bit 2 set)
w5CharAirShadowSlot:: ds 4
; [4 bytes] Per-character banked struct (WRAM4-7): sprite-slot record for the standing shadow (tile $58; flicker-transparency while grounded)
w5CharGroundShadowSlot:: ds 4
; [16-bit] Per-character banked struct (WRAM4-7): attribute word read from the character record +$19; StartCharSwing tests bit 7 of the low byte, and bits 0 and 1 of wCharSwingAttrWord + 1 select the lob and drop placement rows
w5CharSwingAttrWord:: dw
; [8-bit] Per-character banked struct (WRAM4-7): placement-row index (d) into ShotPlacementDataLob (set from df91 bit 0)
w5LobPlacementIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): placement-row index (d) into ShotPlacementDataDrop (set from df91 bit 1)
w5DropPlacementIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): attribute bits XORed into wCharSpriteAttr when the facing octant is 2 or 6, i.e. when the sprite is drawn mirrored
w5CharMirrorAttrMask:: db
; [8-bit] Per-character banked struct (WRAM4-7): character class/tier from attribute record +$18; LookupExpTierForChar reads it on the EXP screen
w5CharExpTier:: db
; [8-bit] Per-character banked struct (WRAM4-7): draw-order depth key ((depth*8)>>8 + $80); DrawActorsByDepth paints teammates back-to-front
w5CharDepthKey:: db
ENDU


SECTION "WRAMX bank 6 $df00", WRAMX[$df00], BANK[6]

; One copy per character of a structure that lives in WRAM banks 4-7
; at once. Each bank declares its own copy under a bank-tagged name, so the
; symbol file resolves the right one whichever bank the debugger is stopped in
; -- this is bank 6's. The disassembly itself uses the untagged name, an EQU
; in include/ram_mirrored.inc, because the bank is chosen at run time.

; Match-engine per-character struct, replicated across WRAM banks 4-7
; (bank = character: 4 near-P1, 5 far-P1, 6 near-partner, 7 far-partner).
; Same field, different character per bank -- one name each. Scoped by the
; provably-selected WRAM bank, plus the match banks $07/$08 whose
; callback-reached (jp hl) accesses the dataflow can't prove. Only the
; named field offsets render; other $dfxx bytes stay numeric.
; The character-select screen drives the same struct: bank $38 runs
; UpdateCharSelectCharSprite and TickCharSelectIdleAnim once per preview
; character, selecting WRAM banks $04-$07 in turn, so those two routines get
; instruction-range scopes rather than a whole-bank one -- bank $38's own
; $df00 is wCharSelectHandedness in WRAM bank $03.
UNION
; clear-status developer menu (bank $0a, WRAM bank $05)
; [8-bit] RunClearStatusSetupMenu's first choice (Text_34_215): 0 Set, 1 Continue, $ff cancelled. Continue and cancel skip straight to the result code; the menu keeps its state in WRAM bank $05 on top of the idle far-P1 character struct, cleared 32 bytes at a time on entry
w6ClearStatusMode:: db
; [8-bit] 0 singles, 1 doubles -- not asked, copied from FLAG_DOUBLES when Set is chosen. Picks the singles or doubles rank list and result-code row
w6ClearStatusDoubles:: db
; [8-bit] Second menu (Text_34_217): 0 Mini-Game, 1 Ranking Match; $ff steps back
w6ClearStatusFormat:: db
; [8-bit] Third menu (Text_34_218): 0 Junior, 1 Senior, 2 Varsity; $ff steps back. SetTrainingCourtClearFlags reads it as the drill level to mark cleared, the ranking routines as how many classes of wins to set
w6ClearStatusClass:: db
; [8-bit] Fourth menu: the drill (Text_34_219) for a Mini-Game clear, or the rank within the class (Text_34_220 and the per-class lists after it) for a Ranking Match clear; $ff steps back
w6ClearStatusRank:: db
; [8-bit] Window struct index of the caption frame CreateWindowFromScreenRect opened, redrawn before every menu
w6ClearStatusWindowId:: db
; [8-bit] What RunClearStatusSetupMenu returns in b: 8 cancelled, 1 Continue, else the ClearStatusResultCodeIndexTable entry for the choice
w6ClearStatusResultCode:: db
	ds 144
NEXTU
; text-arg fetch buffer (menu banks reuse the idle char struct)
; [bank 5] Scratch buffer that PushTextArgFetchedString fills (via FetchShortTextToBuffer) with a fetched short-text string, then pushes as a text argument; overlaps the idle far-P1 character struct at $df00
w6TextArgFetchBuffer:: db
NEXTU
; match character struct (WRAM banks 4-7, and the match/shot/results banks that address it with the bank already selected)
; [3 bytes] Per-character banked struct (WRAM4-7): lateral X position, 24-bit fixed point (fraction byte + signed 16-bit integer part)
w6CharPosX:: ds 3
; [3 bytes] Per-character banked struct (WRAM4-7): depth position (toward/away from net), same 24-bit fixed-point format; the two court sides carry opposite signs
w6CharPosDepth:: ds 3
; [3 bytes] Per-character banked struct (WRAM4-7): height above court, same 24-bit fixed-point format (zeroed by SetCharPosAndTarget)
w6CharPosHeight:: ds 3
; [8-bit] Per-character banked struct (WRAM4-7): serve/side role code (court-position record byte 4-7); XORed with 2 on the per-point side swap, mapped through the $4fa0 table at point start
w6CharServeRole:: db
; [8-bit] Per-character banked struct (WRAM4-7): court position code (court-position record byte 0-3; XORed with 3 on the tiebreak side-swap)
w6CharCourtPos:: db
; [8-bit] Per-character banked struct (WRAM4-7): character index 0-3 (== WRAM bank - 4); bit 0 set = far side (used by CharPointEndReaction and the edge-arrow sprite)
w6CharIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): facing this character returns to for its court position, from CourtPosFacingTable_08; PlaceCharAtBasePosition and UpdateCharFacingOctant measure the displayed facing against it
w6CharBaseFacing:: db
; [8-bit] Per-character banked struct (WRAM4-7): desired facing direction, eased toward by wCharFacingShown
w6CharFacingDesired:: db
; [8-bit] Per-character banked struct (WRAM4-7): displayed facing, eased toward wCharFacingDesired by at most wCharFacingEaseRate per frame ($75c0)
w6CharFacingShown:: db
; [8-bit] Per-character banked struct (WRAM4-7): state flags; bit 2 = airborne (set on jump $6dd5, cleared on landing; selects the shadow slot drawn)
w6CharFlags:: db
; [8-bit] Per-character banked struct (WRAM4-7): frames the character is frozen for: UpdateCharStateMachine decrements it and returns without running the state, so nothing moves. SetCharState clears it, and FreezeMinigameOpponentOnReturn sets it to hold the minigame opponent still
w6CharFreezeTimer:: db
; [8-bit] Per-character banked struct (WRAM4-7): frames left to press a second shot button; BufferShotButtonPress seeds it with 5 on the first press and the state-machine dispatch counts it down
w6CharShotComboTimer:: db
; [8-bit] Per-character banked struct (WRAM4-7): AI countdown -- the reaction delay AiSetReactionDelay randomises, and the hold time AiServePressToss uses to press and release the toss button
w6AiActionTimer:: db
; [8-bit] Frames the AI holds its first shot button before adding the second. AiWaitThenPickShot sets it to 5 right after AiPressFirstShotButton; AiSwingControlSingles/Doubles will not call AiPressSecondShotButton while it is nonzero, and the per-frame tick counts it down only once wAiActionTimer ($df12) has reached 0, so the two run in sequence rather than together.
w6AiSecondButtonDelay:: db
; [8-bit] Per-character banked struct (WRAM4-7): resolved SHOTTYPE_* for the swing about to happen, looked up by SelectServeShotType / SelectRallyShotType from the two buffered buttons
w6CharShotType:: db
; [8-bit] Per-character banked struct (WRAM4-7): animation id of the swing SelectForehandBackhand picked; the windup plays it + $08 and the contact phase plays it as-is
w6CharSwingAnim:: db
; [8-bit] Per-character banked struct (WRAM4-7): first shot button of the current swing (1 = A, 2 = B), 0 = none. The pair with wCharShotButton2 indexes RallyShotTypeTable0/1, which is how A+B combinations become lobs, drops and power shots
w6CharShotButton1:: db
; [8-bit] Per-character banked struct (WRAM4-7): second shot button, captured while wCharShotComboTimer is still running
w6CharShotButton2:: db
; [8-bit] Per-character banked struct (WRAM4-7): state-machine index (RST00 jumptable at $6a77; set via SetCharState)
w6CharState:: db
; [8-bit] Per-character banked struct (WRAM4-7): sub-step within wCharState; AdvanceCharStatePhase increments it and each state's phase routine dispatches on it
w6CharStatePhase:: db
; [8-bit] Per-character banked struct (WRAM4-7): sub-step of the AI state machine, advanced by AiAdvancePhase (the AI's own counter, separate from wCharStatePhase)
w6AiPhase:: db
; [3 bytes] Per-character banked struct (WRAM4-7): current sprite frame pointer (hi/lo) + h-flip flag, consumed by DrawCharSprite ($650a)
w6CharSpriteFrame:: ds 3
; [8-bit] Which input drives this character; ReadCharInput indexes CharInputPtrs with it (pad, CPU and link handlers)
w6CharInputSource:: db
; [8-bit] Input word ReadCharInput produces: held buttons in the high nibble, newly pressed in the low one (ReadCharPadInput builds it from hPlayerInputFlags and hInputRisingEdge); read with the PADB_* bits
w6CharInputBits:: db
	ds 1
; [8-bit] Per-character banked struct (WRAM4-7): object-definition id SetupCharSpriteFromObjectDef was handed; stored and never read again
w6CharObjectDefId:: db
; [8-bit] Per-character banked struct (WRAM4-7): ROM bank of this character's object definition, animation scripts and frame tables. GetPerspectiveScale banks it in through hRomBank / $2000 and SetCharAnimation and StepCharAnimation pass it to FarReadWordDI. 0 means no object is loaded, which is the test UpdateChar exits on
w6CharObjectBank:: db
	ds 1
; [16-bit] Per-character banked struct (WRAM4-7): pointer (in wCharObjectBank) to the frame graphics table GetPerspectiveScale walks to find a frame's tile data
w6CharFrameTablePtr:: dw
; [16-bit] Per-character banked struct (WRAM4-7): VRAM destination the character's frame tiles are copied to
w6CharFrameVramDest:: dw
; [16-bit] Per-character banked struct (WRAM4-7): pointer (in wCharObjectBank) to the object's animation-pointer table; SetCharAnimation indexes it by animation id
w6CharAnimTablePtr:: dw
; [16-bit] Per-character banked struct (WRAM4-7): start of the current animation script, which the $ff (jump) command rewinds to
w6CharAnimScriptBase:: dw
; [16-bit] Per-character banked struct (WRAM4-7): cursor into the current animation script. Commands are word-sized: < $f0 is [frame, delay], $ff jumps, $fe switches animation, $fb toggles the flip bits of wCharSpriteAttr
w6CharAnimScriptPtr:: dw
; [8-bit] Per-character banked struct (WRAM4-7): animation currently playing; SetCharAnimation returns early when asked for the one already running
w6CharAnimId:: db
; [8-bit] Per-character banked struct (WRAM4-7): frames left on the current animation frame; $ff means hold it indefinitely
w6CharAnimDelay:: db
; [8-bit] Per-character banked struct (WRAM4-7): sprite bookkeeping flags. Bit 6 = the frame or the facing octant changed, so ReloadCharFacingTiles must upload new tiles; it clears the bit itself
w6CharSpriteDirty:: db
	ds 1
; [8-bit] Per-character banked struct (WRAM4-7): facing octant 0-7, derived from wCharFacingShown; picks the tile row and, for octants 2 and 6, the mirrored sprite
w6CharFacingOctant:: db
; [8-bit] Per-character banked struct (WRAM4-7): frame id the animation script last selected
w6CharAnimFrame:: db
	ds 2
; [8-bit] Per-character banked struct (WRAM4-7): first VRAM tile of this character's sprite, from a per-character-index table
w6CharTileBase:: db
; [8-bit] Per-character banked struct (WRAM4-7): OAM attribute byte for the character. The low three bits are the CGB OBJ palette (wCharIndex + 4) and double as the tile-block index ReloadCharFrameGfx uploads into (& $07, + $08); the high bits are the flip bits the animation script's $fb command toggles, and SetCharAnimation clears them with `and $0f`
w6CharSpriteAttr:: db
; [16-bit] Per-character banked struct (WRAM4-7): pointer (in wCharObjectBank) to the per-frame shadow/scale table GetPerspectiveScale reads
w6CharShadowTablePtr:: dw
; [8-bit] Per-character banked struct (WRAM4-7): ROM bank holding the character's frame graphics; ReloadCharFrameGfx and LoadCharChargeFlashGfx pass it to the bank $00 far-call vector at $0110
w6CharGfxBank:: db
	ds 5
; [16-bit] Per-character banked struct (WRAM4-7): X velocity (zeroed on placement and at point end)
w6CharVelX:: dw
; [16-bit] Per-character banked struct (WRAM4-7): depth velocity
w6CharVelDepth:: dw
; [16-bit] Per-character banked struct (WRAM4-7): height velocity
w6CharVelHeight:: dw
; [16-bit] Per-character banked struct (WRAM4-7): walk-target X (integer part)
w6CharWalkTargetX:: dw
; [16-bit] Per-character banked struct (WRAM4-7): walk-target depth; MoveCharTowardTarget ($7541) walks toward it, snapping when both deltas < $18 (CheckCharNearTarget $78be)
w6CharWalkTargetDepth:: dw
; [8-bit] Per-character banked struct (WRAM4-7): aim the player asked for with left/right at the moment of the shot, captured by CaptureServeAim / CaptureShotAim. GetShotAimOffsetForSide and ComputeShotTargetX turn it into the target's lateral offset
w6CharAimOffset:: db
; [8-bit] Per-character banked struct (WRAM4-7): frames elapsed in the current swing phase, reset when the windup starts and incremented by the windup and contact phases
w6CharSwingFrames:: db
; [8-bit] Set when this character's swing was a quick (uncharged) one. StartCharSwing writes it as the swing begins and ExecuteShot reads it back to seed wShotWasQuickSwing, which is what makes the shot resolve without a charge bonus. It was previously declared on the menu-bank variant of this union, where nothing could reach it.
w6CharQuickSwing:: db
; [8-bit] Shot button latched while the swing is being held, from b in CheckSwingRelease; cleared there when SELECT is down and again by CharRallyReadyPhase alongside wCharSwingFrames. Nothing ever reads it -- the byte is written on three paths and consumed on none, so it is vestigial.
w6CharSwingHoldButton:: db
; [8-bit] Frames the swing has been held: CheckSwingRelease increments it once per frame through `ld hl, $df4e / inc [hl]` and zeroes it on release or when SELECT is down. Write-only like wCharSwingHoldButton -- no site reads the count back, so whatever charge mechanic it fed is gone.
w6CharSwingHoldFrames:: db
; [8-bit] Per-character banked struct (WRAM4-7): shot button already recorded, so BufferShotButtonPress ignores it being held
w6CharLastShotButton:: db
; [8-bit] Per-character banked struct (WRAM4-7): result of this frame's ball-geometry tests: bit 0 = ball within swing range, bit 1 = inside the contact window, bit 4 = within normal reach (clear selects the stretching shot table). Rebuilt every frame by UpdateCharBallGeometry
w6CharBallReachFlags:: db
; [8-bit] Per-character banked struct (WRAM4-7): set while the charge flash is playing; cleared when the swing starts or aborts
w6CharChargeFlashOn:: db
; [8-bit] Per-character banked struct (WRAM4-7): 1 while the flashed tiles are the ones in VRAM. UpdateChargeFlash toggles the flash on wCharSwingFrames bit 2, and this latch is what makes each half of that cycle load its graphics once -- set it and call LoadCharChargeFlashGfx, or clear it and call ReloadCharFrameGfx
w6CharChargeFlashGfxLoaded:: db
; [8-bit] Per-character banked struct (WRAM4-7): last projected screen X (BuildCharSpriteSlots $7672)
w6CharScreenX:: db
; [8-bit] Per-character banked struct (WRAM4-7): last projected screen Y
w6CharScreenY:: db
; [8-bit] Zeroed immediately after each write of wCharWalkTargetX / wCharWalkTargetDepth, on both paths that set a walk target. Nothing reads it -- the two writes are the only references in the ROM -- so whatever it once qualified about the target is gone.
w6CharWalkTargetFlag:: db
; [8-bit] Per-character banked struct (WRAM4-7): set to 1 by MoveCharTowardTarget once it has stepped the character toward wCharWalkTargetX/wCharWalkTargetDepth. UpdateCharStateMachine clears it at the top of every frame and UpdateCharVelocityFromInput returns immediately while it is set, so a scripted walk overrides the stick for that frame
w6CharScriptedMove:: db
; [8-bit] Per-character banked struct (WRAM4-7): point result from this character's perspective (signed wPointWinLoseFlag)
w6CharPointResult:: db
; [8-bit] Per-character banked struct (WRAM4-7): shot buttons the AI decided to press this swing (AiPickServeButtons / AiPickShotButtons); AiPressFirstShotButton and AiPressSecondShotButton feed them into wCharInputBits one at a time
w6AiShotButtons:: db
; [8-bit] Working countdown seeded from wAiTrackingParam every time the AI advances a phase after fixing a target. AiWaitThenPickShot decrements it once per frame and will not pick a shot until it reaches 0 (or until bit 0 of wCharBallReachFlags says the ball is already in reach), so a larger tracking parameter makes the character commit later.
w6AiTrackingCountdown:: db
; [8-bit] Set to 1 by CharRallyReadyPhase and cleared alongside wCharShotButton1/2 when a shot is abandoned. AiTrackBallPhase returns without steering while it is 0, so it gates AI movement toward the target on the character actually being in the rally-ready state.
w6CharRallyReady:: db
	ds 5
; [16-bit LE] Speed limit along the X axis: ClampCharXSpeed multiplies it by the cosine of wCharFacingDesired, mirroring what ClampCharDepthSpeed does with wCharMaxSpeedDepth. From CharStatTable_07_0 indexed by attribute byte $0027 alone.
w6CharMaxSpeedX:: dw
; [16-bit LE] Speed limit along the depth axis: ClampCharDepthSpeed multiplies it by the sine of wCharFacingDesired so the clamp follows the run direction. LoadCharacterAttributes indexes CharStatTable_07_0 with attribute bytes $0027 + $002b summed and doubled, clamped to the table's ten entries -- the same table wCharMaxSpeedX reads, but that one uses $0027 alone, so this axis gets whatever bonus $002b carries.
w6CharMaxSpeedDepth:: dw
; [16-bit LE] How hard this character accelerates, from CharStatTable_07_1 via attribute-struct offset $0028. AccelerateCharDepth and AccelerateCharX multiply it by the sine/cosine of wCharFacingDesired and add the result to wCharVelDepth / wCharVelX, so one value drives both axes.
w6CharAcceleration:: dw
; [16-bit LE] How hard this character slows when not accelerating, from CharStatTable_07_2 via attribute-struct offset $002a. The two brake routines negate it against bit 7 of the current velocity so it always opposes motion; one of them substitutes a flat $0040 when bit 1 of wCharFlags is clear.
w6CharDeceleration:: dw
; [8-bit] Per-character banked struct (WRAM4-7): max facing change per frame, easing wCharFacingShown toward wCharFacingDesired
w6CharFacingEaseRate:: db
; [8-bit] Scales how far this character's aim is pushed off centre: ComputeAimBaseOffset feeds it to MulHLByAFrac as the fraction applied to the base offset. From CharStatTable_07_4 via attribute-struct offset $0025.
w6CharAimOffsetScale:: db
; [8-bit] Magnitude of the random component of this character's aim: GetRandomAimJitter multiplies a fresh AdvanceMatchRng byte by it (MulHLByA). Higher means a less accurate shot. From CharStatTable_07_5 via attribute-struct offset $0026.
w6CharAimJitterScale:: db
; [8-bit] Per-character banked struct (WRAM4-7): speed-row index (e) into the ShotPlacementData tables for ground strokes (topspin/slice/power variants/neutral); selects bytes 4-5 -> shot speed in LoadShotPlacementEntry
w6GroundStrokeSpeedIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): speed-row index (e) into ShotPlacementData for the smash and all three serves
w6SmashServeSpeedIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): speed-row index (e) into ShotPlacementData for the reach (smash-range) shot variants
w6ReachSpeedIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): placement-row index (d) into ShotPlacementData for topspin and serve-topspin; selects bytes 0-3 -> target offsets in LoadShotPlacementEntry
w6TopspinPlacementIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): placement-row index (d) into ShotPlacementData for slice and serve-slice
w6SlicePlacementIndex:: db
; [16-bit] Per-character banked struct (WRAM4-7): how far above or below the character the ball may be and still be hit; CheckCharBallContact compares |wBallRelCharHeight| against it. Loaded from the character attribute record +$10, minus $10
w6CharReachHeight:: dw
; [16-bit] Per-character banked struct (WRAM4-7): lateral reach: CheckCharBallContact compares |wBallRelCharX| * 2 against it. Attribute record +$12
w6CharReachX:: dw
; [16-bit] Per-character banked struct (WRAM4-7): upward speed of a jump smash, negated into wCharVelHeight by StartCharSwing. Attribute record +$14, plus $0200
w6CharSmashJumpSpeed:: dw
; [16-bit] Per-character banked struct (WRAM4-7): lunge speed of a dive, turned into wCharVelX/wCharVelDepth through VectorFromLengthAndAngleRaw at the character's facing. Attribute record +$16
w6CharDiveSpeed:: dw
; [8-bit] Per-character banked struct (WRAM4-7): character id InitChar was handed, before RemapExtendedCharId
w6CharId:: db
; [8-bit] Per-character banked struct (WRAM4-7): base frames the AI waits before reacting when the ball is within normal reach; AiSetReactionDelay adds a 0-3 random and stores wAiActionTimer. Attribute record +$1b
w6AiReactionDelayNear:: db
; [8-bit] Per-character banked struct (WRAM4-7): same, for a ball outside normal reach (wCharBallReachFlags bit 4 clear), so a stretching return can be made deliberately slower. Attribute record +$1c
w6AiReactionDelayFar:: db
; [8-bit] Per-character banked struct (WRAM4-7): how the AI chases the ball -- read by AiTrackBallPhase and the baseliner rally state. Attribute record +$1d
w6AiTrackingParam:: db
; [8-bit] Per-character banked struct (WRAM4-7): RNG threshold in AiMaybeAimAwayFromChar: the AI aims away from the opponent when the roll is under it, so a higher value places more shots. Attribute record +$1e
w6AiAimAwayChance:: db
; [8-bit] Per-character banked struct (WRAM4-7): AI serve/shot habit: the low nibble indexes ServePressTossPtrs for the toss timing, and AiPickShotButtons reads it too. Attribute record +$1f
w6AiServeStyle:: db
; [8-bit] Per-character banked struct (WRAM4-7): character id after RemapExtendedCharId; LookupCharSpriteSet and bank $09's LoadOnCourtCharacterGfx use it to find the sprite bank
w6CharSpriteSetId:: db
; [8-bit] Per-character banked struct (WRAM4-7): where the AI stands between shots (0/5 baseline, 1 net, others mid-court); an RST00 jumptable index in AiChooseHomePosition and AiChoosePositionByStrategy. Attribute record +$0f
w6AiPositionStrategy:: db
; [4 bytes] Per-character banked struct (WRAM4-7): sprite-slot record [tile, attr, screenY, screenX] for the character sprite
w6CharSpriteSlot:: ds 4
; [4 bytes] The frame descriptor the single-character screens park after the sprite slot: Unused_1a_DrawCharViewerCharSprite ($1a:$706c) and the results/EXP screen drawers ($1e:$4b08, $5947) write eight bytes at wCharSpriteSlot -- the slot's [tile, attr, y, x], then wCharSpriteFrame + 2 (the 32x32 flag), + 1 and + 0 (the Y and X offsets QueueSprite24x32 adds) and a depth key (slot * 8 + $80, the shape of wCharDepthKey). The match engine's own drawer never writes it (its slot reset covers only the three records at +$00, +$08, +$0c), which is why a RAM poison run saw it filled on the status screen and in the credits but not in a match
w6CharSpriteSlotFrame:: ds 4
; [4 bytes] Per-character banked struct (WRAM4-7): sprite-slot record for the airborne shadow (tiles $50/$52/$54/$56 shrink with jump height; drawn only while wCharFlags bit 2 set)
w6CharAirShadowSlot:: ds 4
; [4 bytes] Per-character banked struct (WRAM4-7): sprite-slot record for the standing shadow (tile $58; flicker-transparency while grounded)
w6CharGroundShadowSlot:: ds 4
; [16-bit] Per-character banked struct (WRAM4-7): attribute word read from the character record +$19; StartCharSwing tests bit 7 of the low byte, and bits 0 and 1 of wCharSwingAttrWord + 1 select the lob and drop placement rows
w6CharSwingAttrWord:: dw
; [8-bit] Per-character banked struct (WRAM4-7): placement-row index (d) into ShotPlacementDataLob (set from df91 bit 0)
w6LobPlacementIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): placement-row index (d) into ShotPlacementDataDrop (set from df91 bit 1)
w6DropPlacementIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): attribute bits XORed into wCharSpriteAttr when the facing octant is 2 or 6, i.e. when the sprite is drawn mirrored
w6CharMirrorAttrMask:: db
; [8-bit] Per-character banked struct (WRAM4-7): character class/tier from attribute record +$18; LookupExpTierForChar reads it on the EXP screen
w6CharExpTier:: db
; [8-bit] Per-character banked struct (WRAM4-7): draw-order depth key ((depth*8)>>8 + $80); DrawActorsByDepth paints teammates back-to-front
w6CharDepthKey:: db
ENDU


SECTION "WRAMX bank 7 $df00", WRAMX[$df00], BANK[7]

; One copy per character of a structure that lives in WRAM banks 4-7
; at once. Each bank declares its own copy under a bank-tagged name, so the
; symbol file resolves the right one whichever bank the debugger is stopped in
; -- this is bank 7's. The disassembly itself uses the untagged name, an EQU
; in include/ram_mirrored.inc, because the bank is chosen at run time.

; Match-engine per-character struct, replicated across WRAM banks 4-7
; (bank = character: 4 near-P1, 5 far-P1, 6 near-partner, 7 far-partner).
; Same field, different character per bank -- one name each. Scoped by the
; provably-selected WRAM bank, plus the match banks $07/$08 whose
; callback-reached (jp hl) accesses the dataflow can't prove. Only the
; named field offsets render; other $dfxx bytes stay numeric.
; The character-select screen drives the same struct: bank $38 runs
; UpdateCharSelectCharSprite and TickCharSelectIdleAnim once per preview
; character, selecting WRAM banks $04-$07 in turn, so those two routines get
; instruction-range scopes rather than a whole-bank one -- bank $38's own
; $df00 is wCharSelectHandedness in WRAM bank $03.
UNION
; clear-status developer menu (bank $0a, WRAM bank $05)
; [8-bit] RunClearStatusSetupMenu's first choice (Text_34_215): 0 Set, 1 Continue, $ff cancelled. Continue and cancel skip straight to the result code; the menu keeps its state in WRAM bank $05 on top of the idle far-P1 character struct, cleared 32 bytes at a time on entry
w7ClearStatusMode:: db
; [8-bit] 0 singles, 1 doubles -- not asked, copied from FLAG_DOUBLES when Set is chosen. Picks the singles or doubles rank list and result-code row
w7ClearStatusDoubles:: db
; [8-bit] Second menu (Text_34_217): 0 Mini-Game, 1 Ranking Match; $ff steps back
w7ClearStatusFormat:: db
; [8-bit] Third menu (Text_34_218): 0 Junior, 1 Senior, 2 Varsity; $ff steps back. SetTrainingCourtClearFlags reads it as the drill level to mark cleared, the ranking routines as how many classes of wins to set
w7ClearStatusClass:: db
; [8-bit] Fourth menu: the drill (Text_34_219) for a Mini-Game clear, or the rank within the class (Text_34_220 and the per-class lists after it) for a Ranking Match clear; $ff steps back
w7ClearStatusRank:: db
; [8-bit] Window struct index of the caption frame CreateWindowFromScreenRect opened, redrawn before every menu
w7ClearStatusWindowId:: db
; [8-bit] What RunClearStatusSetupMenu returns in b: 8 cancelled, 1 Continue, else the ClearStatusResultCodeIndexTable entry for the choice
w7ClearStatusResultCode:: db
	ds 144
NEXTU
; text-arg fetch buffer (menu banks reuse the idle char struct)
; [bank 5] Scratch buffer that PushTextArgFetchedString fills (via FetchShortTextToBuffer) with a fetched short-text string, then pushes as a text argument; overlaps the idle far-P1 character struct at $df00
w7TextArgFetchBuffer:: db
NEXTU
; match character struct (WRAM banks 4-7, and the match/shot/results banks that address it with the bank already selected)
; [3 bytes] Per-character banked struct (WRAM4-7): lateral X position, 24-bit fixed point (fraction byte + signed 16-bit integer part)
w7CharPosX:: ds 3
; [3 bytes] Per-character banked struct (WRAM4-7): depth position (toward/away from net), same 24-bit fixed-point format; the two court sides carry opposite signs
w7CharPosDepth:: ds 3
; [3 bytes] Per-character banked struct (WRAM4-7): height above court, same 24-bit fixed-point format (zeroed by SetCharPosAndTarget)
w7CharPosHeight:: ds 3
; [8-bit] Per-character banked struct (WRAM4-7): serve/side role code (court-position record byte 4-7); XORed with 2 on the per-point side swap, mapped through the $4fa0 table at point start
w7CharServeRole:: db
; [8-bit] Per-character banked struct (WRAM4-7): court position code (court-position record byte 0-3; XORed with 3 on the tiebreak side-swap)
w7CharCourtPos:: db
; [8-bit] Per-character banked struct (WRAM4-7): character index 0-3 (== WRAM bank - 4); bit 0 set = far side (used by CharPointEndReaction and the edge-arrow sprite)
w7CharIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): facing this character returns to for its court position, from CourtPosFacingTable_08; PlaceCharAtBasePosition and UpdateCharFacingOctant measure the displayed facing against it
w7CharBaseFacing:: db
; [8-bit] Per-character banked struct (WRAM4-7): desired facing direction, eased toward by wCharFacingShown
w7CharFacingDesired:: db
; [8-bit] Per-character banked struct (WRAM4-7): displayed facing, eased toward wCharFacingDesired by at most wCharFacingEaseRate per frame ($75c0)
w7CharFacingShown:: db
; [8-bit] Per-character banked struct (WRAM4-7): state flags; bit 2 = airborne (set on jump $6dd5, cleared on landing; selects the shadow slot drawn)
w7CharFlags:: db
; [8-bit] Per-character banked struct (WRAM4-7): frames the character is frozen for: UpdateCharStateMachine decrements it and returns without running the state, so nothing moves. SetCharState clears it, and FreezeMinigameOpponentOnReturn sets it to hold the minigame opponent still
w7CharFreezeTimer:: db
; [8-bit] Per-character banked struct (WRAM4-7): frames left to press a second shot button; BufferShotButtonPress seeds it with 5 on the first press and the state-machine dispatch counts it down
w7CharShotComboTimer:: db
; [8-bit] Per-character banked struct (WRAM4-7): AI countdown -- the reaction delay AiSetReactionDelay randomises, and the hold time AiServePressToss uses to press and release the toss button
w7AiActionTimer:: db
; [8-bit] Frames the AI holds its first shot button before adding the second. AiWaitThenPickShot sets it to 5 right after AiPressFirstShotButton; AiSwingControlSingles/Doubles will not call AiPressSecondShotButton while it is nonzero, and the per-frame tick counts it down only once wAiActionTimer ($df12) has reached 0, so the two run in sequence rather than together.
w7AiSecondButtonDelay:: db
; [8-bit] Per-character banked struct (WRAM4-7): resolved SHOTTYPE_* for the swing about to happen, looked up by SelectServeShotType / SelectRallyShotType from the two buffered buttons
w7CharShotType:: db
; [8-bit] Per-character banked struct (WRAM4-7): animation id of the swing SelectForehandBackhand picked; the windup plays it + $08 and the contact phase plays it as-is
w7CharSwingAnim:: db
; [8-bit] Per-character banked struct (WRAM4-7): first shot button of the current swing (1 = A, 2 = B), 0 = none. The pair with wCharShotButton2 indexes RallyShotTypeTable0/1, which is how A+B combinations become lobs, drops and power shots
w7CharShotButton1:: db
; [8-bit] Per-character banked struct (WRAM4-7): second shot button, captured while wCharShotComboTimer is still running
w7CharShotButton2:: db
; [8-bit] Per-character banked struct (WRAM4-7): state-machine index (RST00 jumptable at $6a77; set via SetCharState)
w7CharState:: db
; [8-bit] Per-character banked struct (WRAM4-7): sub-step within wCharState; AdvanceCharStatePhase increments it and each state's phase routine dispatches on it
w7CharStatePhase:: db
; [8-bit] Per-character banked struct (WRAM4-7): sub-step of the AI state machine, advanced by AiAdvancePhase (the AI's own counter, separate from wCharStatePhase)
w7AiPhase:: db
; [3 bytes] Per-character banked struct (WRAM4-7): current sprite frame pointer (hi/lo) + h-flip flag, consumed by DrawCharSprite ($650a)
w7CharSpriteFrame:: ds 3
; [8-bit] Which input drives this character; ReadCharInput indexes CharInputPtrs with it (pad, CPU and link handlers)
w7CharInputSource:: db
; [8-bit] Input word ReadCharInput produces: held buttons in the high nibble, newly pressed in the low one (ReadCharPadInput builds it from hPlayerInputFlags and hInputRisingEdge); read with the PADB_* bits
w7CharInputBits:: db
	ds 1
; [8-bit] Per-character banked struct (WRAM4-7): object-definition id SetupCharSpriteFromObjectDef was handed; stored and never read again
w7CharObjectDefId:: db
; [8-bit] Per-character banked struct (WRAM4-7): ROM bank of this character's object definition, animation scripts and frame tables. GetPerspectiveScale banks it in through hRomBank / $2000 and SetCharAnimation and StepCharAnimation pass it to FarReadWordDI. 0 means no object is loaded, which is the test UpdateChar exits on
w7CharObjectBank:: db
	ds 1
; [16-bit] Per-character banked struct (WRAM4-7): pointer (in wCharObjectBank) to the frame graphics table GetPerspectiveScale walks to find a frame's tile data
w7CharFrameTablePtr:: dw
; [16-bit] Per-character banked struct (WRAM4-7): VRAM destination the character's frame tiles are copied to
w7CharFrameVramDest:: dw
; [16-bit] Per-character banked struct (WRAM4-7): pointer (in wCharObjectBank) to the object's animation-pointer table; SetCharAnimation indexes it by animation id
w7CharAnimTablePtr:: dw
; [16-bit] Per-character banked struct (WRAM4-7): start of the current animation script, which the $ff (jump) command rewinds to
w7CharAnimScriptBase:: dw
; [16-bit] Per-character banked struct (WRAM4-7): cursor into the current animation script. Commands are word-sized: < $f0 is [frame, delay], $ff jumps, $fe switches animation, $fb toggles the flip bits of wCharSpriteAttr
w7CharAnimScriptPtr:: dw
; [8-bit] Per-character banked struct (WRAM4-7): animation currently playing; SetCharAnimation returns early when asked for the one already running
w7CharAnimId:: db
; [8-bit] Per-character banked struct (WRAM4-7): frames left on the current animation frame; $ff means hold it indefinitely
w7CharAnimDelay:: db
; [8-bit] Per-character banked struct (WRAM4-7): sprite bookkeeping flags. Bit 6 = the frame or the facing octant changed, so ReloadCharFacingTiles must upload new tiles; it clears the bit itself
w7CharSpriteDirty:: db
	ds 1
; [8-bit] Per-character banked struct (WRAM4-7): facing octant 0-7, derived from wCharFacingShown; picks the tile row and, for octants 2 and 6, the mirrored sprite
w7CharFacingOctant:: db
; [8-bit] Per-character banked struct (WRAM4-7): frame id the animation script last selected
w7CharAnimFrame:: db
	ds 2
; [8-bit] Per-character banked struct (WRAM4-7): first VRAM tile of this character's sprite, from a per-character-index table
w7CharTileBase:: db
; [8-bit] Per-character banked struct (WRAM4-7): OAM attribute byte for the character. The low three bits are the CGB OBJ palette (wCharIndex + 4) and double as the tile-block index ReloadCharFrameGfx uploads into (& $07, + $08); the high bits are the flip bits the animation script's $fb command toggles, and SetCharAnimation clears them with `and $0f`
w7CharSpriteAttr:: db
; [16-bit] Per-character banked struct (WRAM4-7): pointer (in wCharObjectBank) to the per-frame shadow/scale table GetPerspectiveScale reads
w7CharShadowTablePtr:: dw
; [8-bit] Per-character banked struct (WRAM4-7): ROM bank holding the character's frame graphics; ReloadCharFrameGfx and LoadCharChargeFlashGfx pass it to the bank $00 far-call vector at $0110
w7CharGfxBank:: db
	ds 5
; [16-bit] Per-character banked struct (WRAM4-7): X velocity (zeroed on placement and at point end)
w7CharVelX:: dw
; [16-bit] Per-character banked struct (WRAM4-7): depth velocity
w7CharVelDepth:: dw
; [16-bit] Per-character banked struct (WRAM4-7): height velocity
w7CharVelHeight:: dw
; [16-bit] Per-character banked struct (WRAM4-7): walk-target X (integer part)
w7CharWalkTargetX:: dw
; [16-bit] Per-character banked struct (WRAM4-7): walk-target depth; MoveCharTowardTarget ($7541) walks toward it, snapping when both deltas < $18 (CheckCharNearTarget $78be)
w7CharWalkTargetDepth:: dw
; [8-bit] Per-character banked struct (WRAM4-7): aim the player asked for with left/right at the moment of the shot, captured by CaptureServeAim / CaptureShotAim. GetShotAimOffsetForSide and ComputeShotTargetX turn it into the target's lateral offset
w7CharAimOffset:: db
; [8-bit] Per-character banked struct (WRAM4-7): frames elapsed in the current swing phase, reset when the windup starts and incremented by the windup and contact phases
w7CharSwingFrames:: db
; [8-bit] Set when this character's swing was a quick (uncharged) one. StartCharSwing writes it as the swing begins and ExecuteShot reads it back to seed wShotWasQuickSwing, which is what makes the shot resolve without a charge bonus. It was previously declared on the menu-bank variant of this union, where nothing could reach it.
w7CharQuickSwing:: db
; [8-bit] Shot button latched while the swing is being held, from b in CheckSwingRelease; cleared there when SELECT is down and again by CharRallyReadyPhase alongside wCharSwingFrames. Nothing ever reads it -- the byte is written on three paths and consumed on none, so it is vestigial.
w7CharSwingHoldButton:: db
; [8-bit] Frames the swing has been held: CheckSwingRelease increments it once per frame through `ld hl, $df4e / inc [hl]` and zeroes it on release or when SELECT is down. Write-only like wCharSwingHoldButton -- no site reads the count back, so whatever charge mechanic it fed is gone.
w7CharSwingHoldFrames:: db
; [8-bit] Per-character banked struct (WRAM4-7): shot button already recorded, so BufferShotButtonPress ignores it being held
w7CharLastShotButton:: db
; [8-bit] Per-character banked struct (WRAM4-7): result of this frame's ball-geometry tests: bit 0 = ball within swing range, bit 1 = inside the contact window, bit 4 = within normal reach (clear selects the stretching shot table). Rebuilt every frame by UpdateCharBallGeometry
w7CharBallReachFlags:: db
; [8-bit] Per-character banked struct (WRAM4-7): set while the charge flash is playing; cleared when the swing starts or aborts
w7CharChargeFlashOn:: db
; [8-bit] Per-character banked struct (WRAM4-7): 1 while the flashed tiles are the ones in VRAM. UpdateChargeFlash toggles the flash on wCharSwingFrames bit 2, and this latch is what makes each half of that cycle load its graphics once -- set it and call LoadCharChargeFlashGfx, or clear it and call ReloadCharFrameGfx
w7CharChargeFlashGfxLoaded:: db
; [8-bit] Per-character banked struct (WRAM4-7): last projected screen X (BuildCharSpriteSlots $7672)
w7CharScreenX:: db
; [8-bit] Per-character banked struct (WRAM4-7): last projected screen Y
w7CharScreenY:: db
; [8-bit] Zeroed immediately after each write of wCharWalkTargetX / wCharWalkTargetDepth, on both paths that set a walk target. Nothing reads it -- the two writes are the only references in the ROM -- so whatever it once qualified about the target is gone.
w7CharWalkTargetFlag:: db
; [8-bit] Per-character banked struct (WRAM4-7): set to 1 by MoveCharTowardTarget once it has stepped the character toward wCharWalkTargetX/wCharWalkTargetDepth. UpdateCharStateMachine clears it at the top of every frame and UpdateCharVelocityFromInput returns immediately while it is set, so a scripted walk overrides the stick for that frame
w7CharScriptedMove:: db
; [8-bit] Per-character banked struct (WRAM4-7): point result from this character's perspective (signed wPointWinLoseFlag)
w7CharPointResult:: db
; [8-bit] Per-character banked struct (WRAM4-7): shot buttons the AI decided to press this swing (AiPickServeButtons / AiPickShotButtons); AiPressFirstShotButton and AiPressSecondShotButton feed them into wCharInputBits one at a time
w7AiShotButtons:: db
; [8-bit] Working countdown seeded from wAiTrackingParam every time the AI advances a phase after fixing a target. AiWaitThenPickShot decrements it once per frame and will not pick a shot until it reaches 0 (or until bit 0 of wCharBallReachFlags says the ball is already in reach), so a larger tracking parameter makes the character commit later.
w7AiTrackingCountdown:: db
; [8-bit] Set to 1 by CharRallyReadyPhase and cleared alongside wCharShotButton1/2 when a shot is abandoned. AiTrackBallPhase returns without steering while it is 0, so it gates AI movement toward the target on the character actually being in the rally-ready state.
w7CharRallyReady:: db
	ds 5
; [16-bit LE] Speed limit along the X axis: ClampCharXSpeed multiplies it by the cosine of wCharFacingDesired, mirroring what ClampCharDepthSpeed does with wCharMaxSpeedDepth. From CharStatTable_07_0 indexed by attribute byte $0027 alone.
w7CharMaxSpeedX:: dw
; [16-bit LE] Speed limit along the depth axis: ClampCharDepthSpeed multiplies it by the sine of wCharFacingDesired so the clamp follows the run direction. LoadCharacterAttributes indexes CharStatTable_07_0 with attribute bytes $0027 + $002b summed and doubled, clamped to the table's ten entries -- the same table wCharMaxSpeedX reads, but that one uses $0027 alone, so this axis gets whatever bonus $002b carries.
w7CharMaxSpeedDepth:: dw
; [16-bit LE] How hard this character accelerates, from CharStatTable_07_1 via attribute-struct offset $0028. AccelerateCharDepth and AccelerateCharX multiply it by the sine/cosine of wCharFacingDesired and add the result to wCharVelDepth / wCharVelX, so one value drives both axes.
w7CharAcceleration:: dw
; [16-bit LE] How hard this character slows when not accelerating, from CharStatTable_07_2 via attribute-struct offset $002a. The two brake routines negate it against bit 7 of the current velocity so it always opposes motion; one of them substitutes a flat $0040 when bit 1 of wCharFlags is clear.
w7CharDeceleration:: dw
; [8-bit] Per-character banked struct (WRAM4-7): max facing change per frame, easing wCharFacingShown toward wCharFacingDesired
w7CharFacingEaseRate:: db
; [8-bit] Scales how far this character's aim is pushed off centre: ComputeAimBaseOffset feeds it to MulHLByAFrac as the fraction applied to the base offset. From CharStatTable_07_4 via attribute-struct offset $0025.
w7CharAimOffsetScale:: db
; [8-bit] Magnitude of the random component of this character's aim: GetRandomAimJitter multiplies a fresh AdvanceMatchRng byte by it (MulHLByA). Higher means a less accurate shot. From CharStatTable_07_5 via attribute-struct offset $0026.
w7CharAimJitterScale:: db
; [8-bit] Per-character banked struct (WRAM4-7): speed-row index (e) into the ShotPlacementData tables for ground strokes (topspin/slice/power variants/neutral); selects bytes 4-5 -> shot speed in LoadShotPlacementEntry
w7GroundStrokeSpeedIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): speed-row index (e) into ShotPlacementData for the smash and all three serves
w7SmashServeSpeedIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): speed-row index (e) into ShotPlacementData for the reach (smash-range) shot variants
w7ReachSpeedIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): placement-row index (d) into ShotPlacementData for topspin and serve-topspin; selects bytes 0-3 -> target offsets in LoadShotPlacementEntry
w7TopspinPlacementIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): placement-row index (d) into ShotPlacementData for slice and serve-slice
w7SlicePlacementIndex:: db
; [16-bit] Per-character banked struct (WRAM4-7): how far above or below the character the ball may be and still be hit; CheckCharBallContact compares |wBallRelCharHeight| against it. Loaded from the character attribute record +$10, minus $10
w7CharReachHeight:: dw
; [16-bit] Per-character banked struct (WRAM4-7): lateral reach: CheckCharBallContact compares |wBallRelCharX| * 2 against it. Attribute record +$12
w7CharReachX:: dw
; [16-bit] Per-character banked struct (WRAM4-7): upward speed of a jump smash, negated into wCharVelHeight by StartCharSwing. Attribute record +$14, plus $0200
w7CharSmashJumpSpeed:: dw
; [16-bit] Per-character banked struct (WRAM4-7): lunge speed of a dive, turned into wCharVelX/wCharVelDepth through VectorFromLengthAndAngleRaw at the character's facing. Attribute record +$16
w7CharDiveSpeed:: dw
; [8-bit] Per-character banked struct (WRAM4-7): character id InitChar was handed, before RemapExtendedCharId
w7CharId:: db
; [8-bit] Per-character banked struct (WRAM4-7): base frames the AI waits before reacting when the ball is within normal reach; AiSetReactionDelay adds a 0-3 random and stores wAiActionTimer. Attribute record +$1b
w7AiReactionDelayNear:: db
; [8-bit] Per-character banked struct (WRAM4-7): same, for a ball outside normal reach (wCharBallReachFlags bit 4 clear), so a stretching return can be made deliberately slower. Attribute record +$1c
w7AiReactionDelayFar:: db
; [8-bit] Per-character banked struct (WRAM4-7): how the AI chases the ball -- read by AiTrackBallPhase and the baseliner rally state. Attribute record +$1d
w7AiTrackingParam:: db
; [8-bit] Per-character banked struct (WRAM4-7): RNG threshold in AiMaybeAimAwayFromChar: the AI aims away from the opponent when the roll is under it, so a higher value places more shots. Attribute record +$1e
w7AiAimAwayChance:: db
; [8-bit] Per-character banked struct (WRAM4-7): AI serve/shot habit: the low nibble indexes ServePressTossPtrs for the toss timing, and AiPickShotButtons reads it too. Attribute record +$1f
w7AiServeStyle:: db
; [8-bit] Per-character banked struct (WRAM4-7): character id after RemapExtendedCharId; LookupCharSpriteSet and bank $09's LoadOnCourtCharacterGfx use it to find the sprite bank
w7CharSpriteSetId:: db
; [8-bit] Per-character banked struct (WRAM4-7): where the AI stands between shots (0/5 baseline, 1 net, others mid-court); an RST00 jumptable index in AiChooseHomePosition and AiChoosePositionByStrategy. Attribute record +$0f
w7AiPositionStrategy:: db
; [4 bytes] Per-character banked struct (WRAM4-7): sprite-slot record [tile, attr, screenY, screenX] for the character sprite
w7CharSpriteSlot:: ds 4
; [4 bytes] The frame descriptor the single-character screens park after the sprite slot: Unused_1a_DrawCharViewerCharSprite ($1a:$706c) and the results/EXP screen drawers ($1e:$4b08, $5947) write eight bytes at wCharSpriteSlot -- the slot's [tile, attr, y, x], then wCharSpriteFrame + 2 (the 32x32 flag), + 1 and + 0 (the Y and X offsets QueueSprite24x32 adds) and a depth key (slot * 8 + $80, the shape of wCharDepthKey). The match engine's own drawer never writes it (its slot reset covers only the three records at +$00, +$08, +$0c), which is why a RAM poison run saw it filled on the status screen and in the credits but not in a match
w7CharSpriteSlotFrame:: ds 4
; [4 bytes] Per-character banked struct (WRAM4-7): sprite-slot record for the airborne shadow (tiles $50/$52/$54/$56 shrink with jump height; drawn only while wCharFlags bit 2 set)
w7CharAirShadowSlot:: ds 4
; [4 bytes] Per-character banked struct (WRAM4-7): sprite-slot record for the standing shadow (tile $58; flicker-transparency while grounded)
w7CharGroundShadowSlot:: ds 4
; [16-bit] Per-character banked struct (WRAM4-7): attribute word read from the character record +$19; StartCharSwing tests bit 7 of the low byte, and bits 0 and 1 of wCharSwingAttrWord + 1 select the lob and drop placement rows
w7CharSwingAttrWord:: dw
; [8-bit] Per-character banked struct (WRAM4-7): placement-row index (d) into ShotPlacementDataLob (set from df91 bit 0)
w7LobPlacementIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): placement-row index (d) into ShotPlacementDataDrop (set from df91 bit 1)
w7DropPlacementIndex:: db
; [8-bit] Per-character banked struct (WRAM4-7): attribute bits XORed into wCharSpriteAttr when the facing octant is 2 or 6, i.e. when the sprite is drawn mirrored
w7CharMirrorAttrMask:: db
; [8-bit] Per-character banked struct (WRAM4-7): character class/tier from attribute record +$18; LookupExpTierForChar reads it on the EXP screen
w7CharExpTier:: db
; [8-bit] Per-character banked struct (WRAM4-7): draw-order depth key ((depth*8)>>8 + $80); DrawActorsByDepth paints teammates back-to-front
w7CharDepthKey:: db
ENDU
