; --- Story-map behaviour cells (wBehaviorMap, docs/story_mode.md) ---
; A cell is `id << 4 | kind`: the low nibble says what the cell does, the high
; nibble which script, exit or facing handler it names.
def BEHAVIOR_NONE       equ $00
def BEHAVIOR_TRIGGER    equ $01 ; step-on: the id goes to wStoryModeTriggerScript
def BEHAVIOR_EXIT       equ $03 ; the id goes to wStoryModeExitTriggerRequest
def BEHAVIOR_ACTION     equ $08 ; facing tile: the id is the FacingScripts entry
def BEHAVIOR_TALK_REACH equ $0c ; FindActorFacingPlayer probes twice as far ahead

; --- Animation scripts (anim_frame, docs/graphics_formats.md) ---
; An anim_frame delay of $ff never runs out: the frame is held for good, the
; same state anim_hold leaves behind.
def ANIM_FOREVER equ $ff

; --- Dialogue speaker (script_speak, script_speak_restore, ShowSpeakerDialogue) ---
; The operand is the speaking actor's slot. With bit 7 set no actor speaks:
; OpenSpeechBubble skips the actor lookup, the window is not anchored to
; anyone, the voice is the fixed one ($08), and the low bits shifted left
; land in wSpeechBubbleLowerHalf, so $80 opens in the upper half.
def SPEAKER_NONE equ $80

; --- Overworld actor record fields ---
; Offsets into one wActors record, which the engine and the story scripts
; reach as `ld hl, ACTORF_* / add hl, bc` with the record in bc.
	rsreset
def ACTORF_SCRIPT           rw ; $00 the actor script's next opcode
def ACTORF_SCRIPT_BANK      rb ; $02
def ACTORF_WAIT             rb ; $03 as_wait counter
	rb_skip                       ; $04
def ACTORF_FLAGS            rb ; $05 bit 0 paused, bit 7 moving; bits 3 and 4 set at spawn
def ACTORF_SPEED            rw ; $06 step length per frame (1/256 tile)
def ACTORF_TARGET_X         rw ; $08 where the actor is walking to
def ACTORF_TARGET_Y         rw ; $0a
def ACTORF_X                rw ; $0c world position (1/256 tile)
def ACTORF_Y                rw ; $0e
def ACTORF_HEIGHT           rw ; $10 height above the ground, negative = up (64 = 1 px)
def ACTORF_JUMP_VEL         rw ; $12 added to ACTORF_HEIGHT each update; gravity adds $10
def ACTORF_HEADING          rb ; $14 movement direction, a full angle byte
def ACTORF_TURN_RATE        rb ; $15 largest heading change per step toward the target
def ACTORF_ANCHOR           rw ; $16 record this actor follows (as_follow_wp, as_step); as_set_wander_home's box centre (tile y, x) for as_rand_box
def ACTORF_ANIM_RATE        rb ; $18 subtracted from ACTORF_ANIM_DELAY each frame while standing
def ACTORF_ANIM_RATE_MOVING rb ; $19 the same while ACTORFLAGB_MOVING is set
	rb_skip 6                     ; $1a
def ACTORF_MODE             rb ; $20 ACTORMODE_*: SetActorMode / script_set_actor_mode
def ACTORF_OBJECT           rb ; $21 OBJ_* id (LoadActorObjectDef)
def ACTORF_OBJECT_BANK      rb ; $22 bank of the object header and its frame and animation tables
	rb_skip                       ; $23
def ACTORF_FRAME_TABLE      rw ; $24 object header's frame array
def ACTORF_VRAM_TILES       rw ; $26 the slot's 4 sprite tiles in VRAM bank 1
def ACTORF_ANIM_TABLE       rw ; $28 object header's animation scripts
def ACTORF_ANIM_SCRIPT      rw ; $2a start of the current animation script
def ACTORF_ANIM_PTR         rw ; $2c its next command
def ACTORF_ANIM             rb ; $2e ANIM_* id playing
def ACTORF_ANIM_DELAY       rb ; $2f ticks left on the frame shown; $ff = held
def ACTORF_STATUS           rb ; $30 bit 0 facing locked, bit 6 frame dirty, bit 7 live
def ACTORF_DRAW_DELAY       rb ; $31 frames DrawActors waits before the first draw: spawn staggers slots
def ACTORF_DRAWN_FACING     rb ; $32 FACE_*: ACTORF_FACING quantised by DirectionToFacing_04
def ACTORF_ANIM_FRAME       rb ; $33 frame the animation script shows
def ACTORF_FACING           rb ; $34 angle byte: follows ACTORF_HEADING unless locked
def ACTORF_FACING_COUNT     rb ; $35 object header byte 1; 1 = one facing only
def ACTORF_TILE             rb ; $36 OAM tile of the slot's tiles; read as a word with ACTORF_OAM_ATTR
def ACTORF_OAM_ATTR         rb ; $37 object header byte 0, or the map_actor palette override
def ACTORF_FRAME_PLACE_TABLE rw ; $38 OBJDEF_FRAME_PLACE_TABLE; written, never read
	rb_skip 6                     ; $3a
; wActors is 24 records of this size in WRAM bank $04. The engine walks them
; with `ld de, $0040 / add hl, de`, and SpawnActor turns an actor id into a
; slot with two `srl h / rra` pairs (id * 64).
def ACTOR_SIZE equ _RS
	ASSERT ACTOR_SIZE == $40
; ACTORF_FLAGS bits
def ACTORFLAGB_PAUSED   equ 0 ; StepActorScript yields without running the script
	const_def $02
	const ACTORFLAGB_YIELD    ; $02 a move stops short when it would step next to the player
	const ACTORFLAGB_SOLID    ; $03 BuildNearbyActorList: blocks the player (IsPointBlocked)
	const ACTORFLAGB_TALKABLE ; $04 BuildActorQueryList: FindActorFacingPlayer can pick it
def ACTORFLAGB_BLOCKED  equ 6 ; set the frame a move yielded to the player
def ACTORFLAGB_MOVING   equ 7
; ACTORF_STATUS bits
def ACTORSTATUSB_FACING_LOCKED equ 0 ; ACTORF_FACING stops following ACTORF_HEADING
def ACTORSTATUSB_FRAME_DIRTY   equ 6 ; ACTORF_DRAWN_FACING changed: upload the frame again
def ACTORSTATUSB_ON_SCREEN     equ 7 ; DrawActorSprite queued it inside the screen bounds this frame
; ACTORF_MODE values
	const_def
	const ACTORMODE_HIDDEN  ; $00 not drawn (SpawnActor)
	const ACTORMODE_CAMERA  ; $01 not drawn; the camera follows it (the hidden player slot)
	const ACTORMODE_VISIBLE ; $02 DrawActors draws only this mode

; --- Object definition header (ObjectIdList_04 rows, docs/graphics_formats.md) ---
; LoadActorObjectDef and SetupCharSpriteFromObjectDef copy it to wActorObjDef.
	rsreset
def OBJDEF_ATTR              rb ; $00 OAM attribute / OBJ palette, or OBJDEF_ATTR_PALETTE_PTR
def OBJDEF_FACING_COUNT      rb ; $01 1 = one facing only
	rb_skip 2                      ; $02 not read
def OBJDEF_FRAME_TABLE       rw ; $04
def OBJDEF_ANIM_TABLE        rw ; $06
def OBJDEF_PALETTE           rw ; $08 8-byte OBJ palette, read only under OBJDEF_ATTR_PALETTE_PTR
; The character banks' per-frame placement records. Walk-sprite headers are
; 10 bytes, so there this is the first frame pointer.
def OBJDEF_FRAME_PLACE_TABLE rw ; $0a
def OBJDEF_SIZE equ _RS
; OBJDEF_ATTR sentinel: attr $02, OBJDEF_PALETTE loaded into OBJ palette 2
; (LoadActorObjectDef only; no object uses it)
def OBJDEF_ATTR_PALETTE_PTR equ $63

; --- Overworld actor facing (map_actor `facing`, map_entry `sprite`) ---
; The facing byte stored in an actor's state ($daXX). Its top 2 bits are a
; direction index (0-3); CheckTriggerFacingMask shifts them out and looks them
; up in a table -> PADF bit to test against a FACEMASK_* below. The byte
; doubles as the movement angle fed to as_move (0/64/128/192 on a 256-unit
; circle). Distinct from the PADF_* joypad masks even where the value coincides.
def FACE_RIGHT   equ $00
def FACE_DOWN    equ $40
def FACE_LEFT    equ $80
def FACE_UP      equ $c0

; --- Cutscene actor slots ---
; The actor an overworld/cutscene `script_*` command targets (index into the
; actor state array at $d000, stride $40). InitLocationActors fills slots in a
; fixed order: the player and two paired system actors first, then the
; location's `map_actor` list (SpawnActor takes the first free slot, so list
; entry i -> slot 3+i). Only the three system slots have a stable name; the
; rest are scene-local. ACTOR_PLAYER_SHADOW and ACTOR_PARTNER both trail
; slot 0: ActorScript_FollowWaypoints and ActorScript_StepToTarget.
	const_def
	const ACTOR_PLAYER        ; $00 the main character sprite
	const ACTOR_PLAYER_SHADOW ; $01 player's paired follower actor (AttachActorWaypointFollower)
	const ACTOR_PARTNER       ; $02 companion/doubles partner (SpawnCompanionActor)

; --- map_entry / map_script record fields (include/macros/story_maps.inc) ---
; The bank $0a engine copies the matched record to wStoryMapRecord.
	rsreset
def MAPENTRY_ID     rb ; $00
def MAPENTRY_FACING rb ; $01 FACE_*
def MAPENTRY_X      rw ; $02
def MAPENTRY_Y      rw ; $04
def MAPENTRY_SCRIPT rw ; $06 arrival_script
def MAPENTRY_SIZE   equ _RS
	rsreset
def MAPSCRIPT_ID          rb ; $00 an NpcScripts record's is the actor slot
def MAPSCRIPT_FACING_MASK rb ; $01 FACEMASK_*
def MAPSCRIPT_FLAG_COND   rw ; $02
def MAPSCRIPT_HANDLER     rw ; $04 text id or code address
def MAPSCRIPT_ARG0        rb ; $06 NpcScripts: NPC_* flags; ExitTriggers: STORYLOC_*
def MAPSCRIPT_ARG1        rb ; $07 ExitTriggers: the destination's entry id
def MAPSCRIPT_SIZE        equ _RS
	ASSERT MAPSCRIPT_SIZE == MAPENTRY_SIZE

; --- Story-script facing mask (map_script `facing_mask`) ---
; The direction an actor must face for FindStoryScriptEntry to run the record.
; PADF-layout bits (matched against the facing->PADF table lookup);
; FACEMASK_ANY ($ff) matches every facing.
def FACEMASK_ANY   equ $ff
def FACEMASK_RIGHT equ $10
def FACEMASK_LEFT  equ $20
def FACEMASK_UP    equ $40
def FACEMASK_DOWN  equ $80

; --- NPC talk behaviour (arg0 of an NpcScripts map_script record) ---
; RunNpcInteraction applies these around the handler.
def NPC_FACE_PLAYER    equ $01 ; turn the actor toward the player first
def NPC_RESTORE_FACING equ $02 ; and back to its old facing afterwards
def NPC_IDLE_ANIM      equ $08 ; hold animation 1 while the handler runs
def NPC_FREEZE         equ $10 ; set ACTORF_FLAGS bits 0 and 1 while it runs
DEF NPCB_FACE_PLAYER    EQU 0
DEF NPCB_RESTORE_FACING EQU 1

; --- Tile-trigger behaviour (arg0 of a TileTriggers map_script record) ---
; RunQueuedTriggerScript ignores a queued (walked-onto) trigger whose arg0 is
; this, so the tile only acts on a deliberate A press.
def TILETRIGGER_PRESS_ONLY equ $01

; --- Overworld walk-sprite animations (script_set_anim, as_anim, map_actor) ---
; Animation ids 0-4 mean the same in every walk sprite's AnimPtrs table; ids
; 5 and up differ by sprite (a racket swing for the racket holders, another
; bounce for the rest).
	const_def
	const ANIM_STILL  ; $00 frame 0, held
	const ANIM_WALK   ; $01 frames 0 and 1, the stepping loop (also the idle shuffle)
	const ANIM_BOUNCE ; $02 stand, crouch, stand, crouch, then back to ANIM_WALK
	const ANIM_NOD    ; $03 head lowered for half a second, then ANIM_WALK
	const ANIM_SHAKE  ; $04 upper body swayed left, right, left, right: a head shake
	const ANIM_SWING  ; $05 a racket swing, in the sprites that have one (racket-holding
                        ; students, Bob, Pam, the twelve-animation sprites); elsewhere a bounce
; Ids 5 and up, each named for the sprites whose AnimPtrs table gives it that
; meaning; the same id is something else in other sprites, or reads past the
; end of their frame array. The twelve-animation sprites are OBJ_ALEX,
; OBJ_NINA, the WALK_6F_* students, Toad, Bob-omb, Boo and OBJ_MARIO_WORLD_HOSTESS;
; only Alex and Nina have the frames their ids 8 and 11 show.
def ANIM_EXERCISE       equ $05 ; OBJ_JUMPING_JACKS_A/_B: the exercise, four poses held $30 frames each, looped
def ANIM_HOP            equ $05 ; OBJ_HEADMASTER: one quick crouch, then ANIM_WALK
def ANIM_SWING_LOOP     equ $06 ; the racket holders (the twelve-animation sprites, Bob, Pam, Beth, Fay,
                                ; OBJ_STUDENT_SIDE_PART_BOY, OBJ_STUDENT_PONYTAIL_GIRL-07): backswing, follow-through, repeated
def ANIM_TROPHY_SINGLES equ $06 ; OBJ_TROPHY frames 2-3: the singles cup (ANIM_WALK shows the doubles trophy)
def ANIM_DISTANT        equ $08 ; Alex, Nina, Harry, Kate, Emily, Luigi, DK, Baby Mario: a smaller figure
                                ; stepping, as if far off (walking away through a doorway); Alex's and
                                ; Nina's sideways facings show a full-size front view instead
def ANIM_TROPHY_SMALL   equ $08 ; OBJ_TROPHY frames 4-5: the small trophy, glinting
def ANIM_OVERHEAD_SWING equ $08 ; Bob and OBJ_STUDENT_PONYTAIL_GIRL-07: racket held overhead, a quick swing, the
                                ; follow-through held, looped
	const_def $09
	const ANIM_SWING_BACK    ; $09 the twelve-animation sprites: the backswing pose, held
	const ANIM_SWING_THROUGH ; $0a the twelve-animation sprites: the follow-through pose, held
	const ANIM_SIDESTEP      ; $0b Alex and Nina: a lean to the side, twice, then held
