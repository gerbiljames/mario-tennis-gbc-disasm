SECTION "WRAMX bank 4", WRAMX[$d000], BANK[4]

; WRAMX bank 4 at a glance:
;
;   $d000-$d5ff  overworld actors
;   $d600-$d68f  wMugshotBuffer  [mirrored with bank 2, 3]
;   $d800-$dbff  wIntroMarioTilemap
;   $da00-$da31  actor engine
;   $dac0-$dae9  actor engine
;   $daea-$daf7  actor engine
;   $dc00-$dcd1  minigames / minigame targets
;   $dc00-$dfff  wIntroMarioAttrmap
;   $dcf0-$dcff  minigame targets
;   $dd00-$dd23  match ball history ring
;   $dd80-$ddcf  match object slots
;   $ddf0-$ddff  match object slots
;   $de00-$de1f  match ball sprite slots
;   $de80-$decf  court scoreboard columns
;   $df00-$df96  match character struct  [one copy per bank 4-7]

; Overworld / story actor slots: 24 records of ACTOR_SIZE bytes, the array
; SpawnActor allocates from and the bank $04 engine walks once a frame.
; Several helpers (GetActorStateAddr, AttachActorChaser,
; AttachActorTrailer, script_get_actor_state) select WRAM bank $04
; themselves, so callers such as the bank $0e-$15 cutscene scripts load slot
; addresses (`ld de, wActors` / `ld bc, wActors + ACTOR_SIZE`) with another bank selected.
; Fields are ACTORF_* offsets (`ld hl, ACTORF_* / add hl, bc`); the
; field-size table the script opcodes use is ActorFieldTypeTable_04.
; overworld actors (WRAM bank $04)
; [24 x ACTOR_SIZE] Actor slots; fields are the ACTORF_* offsets (include/constants/). A slot is free when ACTORF_SCRIPT + 1 is zero
wActors:: ds 1536
	export_size wActors

	ds 1024

; List of actor slots, rebuilt by BuildNearbyActorList or BuildTalkableActorList
; (banks $18/$1b/$28/$38 keep unrelated screen state at the same addresses
; in WRAM bank $03).
; actor engine (bank $04)
; [up to 24 x 2 bytes + terminator] Pointers to the live, on-screen actor slots BuildNearbyActorList (+$05 bit 3 set, close enough to the player) or BuildTalkableActorList (+$05 bit 4 set, any distance) selected. A zero word ends the list; FindActorAtPoint and the proximity searches walk it
wNearbyActorList:: ds 50

	ds 142

; Actor-engine staging buffers: two ROM records are copied here because
; they live in whichever bank the caller was running and the engine wants
; them at a fixed address.
; actor engine (bank $04)
; [14 bytes] One map_actor record, copied from the ROM list by SpawnActorsFromList and passed to SpawnActorFromTemplate. +$09 (the pad byte after facing) is $ff on the list terminator
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
; [8-bit] What stopped the player's straight-ahead move this frame (IsPointBlocked: actor slot, or terrain cell | $80); 0 when not blocked
wPlayerBlockedBy:: db
; [8-bit] Previous frame's wPlayerBlockedBy, saved before it is recomputed
wPlayerBlockedByPrev:: db
; [8-bit] Frames the player has kept walking into the same blocker; reset when unblocked or no direction is held. The location loop turns $1e frames into an interaction
wPlayerWallPushFrames:: db
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
; [8-bit] ROM bank the actor VM reads from: ACTORF_SCRIPT_BANK while StepActorScript runs (every ActorScriptOp_* passes it to FarReadByte / FarReadWord / CallHLInBankA); DrawActors reloads it from ACTORF_OBJECT_BANK for the frame-table read
wActorScriptBank:: db

	ds 264

; Minigame actor records, owned by bank $0d. Bank $08's
; RunMinigamePointLoop and UpdateMatchFrame select WRAM bank $04 before
; CallModeHook, and ClearMinigameActors / SetMinigameActorHandler /
; SetMinigameActorPosition select it again.
; Bank $0a lays its MGTARGET_ records over the same bytes.
UNION
; minigames (bank $0d)
; [112 bytes] Seven MGACTOR_SIZE records, cleared as a block by
; ClearMinigameActors.
wMinigameActors:: ds 112
	export_size wMinigameActors
; [16 bytes] The eighth record, outside the ClearMinigameActors block:
; the working copy UpdateMinigameActor runs each handler on.
wMinigameSceneActor:: ds 16
	export_size wMinigameSceneActor
	ds 82
NEXTU
; minigame targets (bank $0a)
; [210 bytes] Fifteen MGTARGET_SIZE records for the target-shot minigames, walked by UpdateMinigameTargets and filled by SpawnMinigameTargetsFromList from a formation's script-pointer list. InitMinigameTargets clears 256 bytes (`ld c, $10` through ClearMemory16), past the array and over wMinigameTargetWork
wMinigameTargets:: ds 210
ENDU

	ds 30

; Working copy of the minigame target being updated (as wObjSlotWork):
; UpdateMinigameTarget copies the slot in, runs its script, movement, draw
; and hit checks on this record, and copies it back. Owned by bank $0a.
; minigame targets (bank $0a)
; [16 bytes] MGTARGET_* fields
wMinigameTargetWork:: ds 16
	export_size wMinigameTargetWork

; Match ball-visuals history ring (bank $08 renderer).
; match ball history ring (WRAM bank 4)
; [36 bytes] Ball position-history ring: NUM_BALLHIST BALLHIST_* records, oldest first; UpdateBallVisuals shifts it down one record per frame and BuildBallSlot writes the newest at BALLHIST_NEWEST
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

; Pre-rendered court scoreboard columns (banks $08/$0a), copied here from the
; scene record by LoadCourtSceneGraphics. Each half holds four 2x5 blocks:
; flipped-view left, normal-view left, normal-view right, flipped-view right.
; RefreshCourtScoreboard copies +10/+20 and RefreshCourtScoreboardFlipped
; +0/+30 to tilemap row 12, columns 4 and 26, via CopyScoreboardTileColumn,
; which reads under WRAM bank $04 and writes under bank $02.
; [40 bytes] Tile half of the scoreboard columns, copied into wCourtTilemapBase
wScoreboardColumnTiles:: ds 40
	export_size wScoreboardColumnTiles
; [40 bytes] Attribute half of the same columns, cell for cell with wScoreboardColumnTiles, copied into wCourtAttrmapBase
wScoreboardColumnAttrs:: ds 40
	export_size wScoreboardColumnAttrs

SECTION "WRAMX bank 4 $df00", WRAMX[$df00], BANK[4]

	match_char_struct w4
