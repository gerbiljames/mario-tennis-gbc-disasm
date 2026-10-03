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
; [24 x ACTOR_SIZE] Actor slots; fields are the ACTORF_* offsets (include/constants/). A slot is free when ACTORF_SCRIPT + 1 is zero
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
