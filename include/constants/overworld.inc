; --- Overworld actor slot stride ---
; wActors is 24 records of this size in WRAM bank $04. The engine walks them
; with `ld de, $0040 / add hl, de`, and SpawnActor turns an actor id into a
; slot with two `srl h / rra` pairs (id * 64).
def ACTOR_SIZE equ $40

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
def ACTORF_SCRIPT       equ $00 ; word: the actor script's next opcode
def ACTORF_SCRIPT_BANK  equ $02
def ACTORF_WAIT         equ $03 ; as_wait counter
def ACTORF_FLAGS        equ $05 ; bit 0 paused, bit 7 moving; bits 3 and 4 set at spawn
def ACTORF_TARGET_X     equ $08 ; word: where the actor is walking to
def ACTORF_TARGET_Y     equ $0a ; word
def ACTORF_X            equ $0c ; word: world position (1/256 tile)
def ACTORF_Y            equ $0e ; word
def ACTORF_HEIGHT       equ $10 ; word: height above the ground, negative = up (64 = 1 px)
def ACTORF_JUMP_VEL     equ $12 ; word: added to ACTORF_HEIGHT each update; gravity adds $10
def ACTORF_HEADING      equ $14 ; movement direction, a full angle byte
def ACTORF_MODE         equ $20 ; SetActorMode / script_set_active
def ACTORF_OBJECT       equ $21 ; OBJ_* id (LoadActorObjectDef)
def ACTORF_FRAME_TABLE  equ $24 ; word: object header's frame array
def ACTORF_ANIM_TABLE   equ $28 ; word: object header's animation scripts
def ACTORF_STATUS       equ $30 ; bit 0 facing locked, bit 6 frame dirty, bit 7 live
def ACTORF_DRAWN_FACING equ $32 ; FACE_*: ACTORF_FACING quantised by DirectionToFacing_04
def ACTORF_FACING       equ $34 ; angle byte: follows ACTORF_HEADING unless locked
def ACTORF_FACING_COUNT equ $35 ; object header byte 1; 1 = one facing only
def ACTORF_OAM_ATTR     equ $37 ; object header byte 0, or the map_actor palette override
def ACTORF_SHADOW_TABLE equ $38 ; word: per-frame placement records
; ACTORF_FLAGS bits
def ACTORFLAGB_PAUSED   equ 0 ; StepActorScript yields without running the script
def ACTORFLAGB_SOLID    equ 3 ; BuildNearbyActorList: blocks the player (IsPointBlocked)
def ACTORFLAGB_TALKABLE equ 4 ; BuildActorQueryList: FindActorFacingPlayer can pick it
def ACTORFLAGB_MOVING   equ 7
; ACTORF_STATUS bits
def ACTORSTATUSB_FACING_LOCKED equ 0 ; ACTORF_FACING stops following ACTORF_HEADING
def ACTORSTATUSB_FRAME_DIRTY   equ 6 ; ACTORF_DRAWN_FACING changed: upload the frame again
def ACTORSTATUSB_LIVE          equ 7

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
; rest are scene-local. ACTOR_PLAYER_SHADOW and ACTOR_PARTNER both run the
; $04:$41d1 follower script.
def ACTOR_PLAYER        equ $00 ; the main character sprite
def ACTOR_PLAYER_SHADOW equ $01 ; player's paired follower actor ($41d1)
def ACTOR_PARTNER       equ $02 ; companion/doubles partner (SpawnCompanionActor)

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
def ANIM_STILL  equ $00 ; frame 0, held
def ANIM_WALK   equ $01 ; frames 0 and 1, the stepping loop (also the idle shuffle)
def ANIM_BOUNCE equ $02 ; stand, crouch, stand, crouch, then back to ANIM_WALK
def ANIM_NOD    equ $03 ; head lowered for half a second, then ANIM_WALK
def ANIM_SHAKE  equ $04 ; upper body swayed left, right, left, right: a head shake
def ANIM_SWING  equ $05 ; a racket swing, in the sprites that have one (racket-holding
                        ; students, Bob, Pam, the twelve-animation sprites); elsewhere a bounce
; Ids 5 and up, each named for the sprites whose AnimPtrs table gives it that
; meaning; the same id is something else in other sprites, or reads past the
; end of their frame array. The twelve-animation sprites are OBJ_ALEX,
; OBJ_NINA, the WALK_6F_* students, Toad, Bob-omb, Boo and OBJ_WALK_77_05;
; only Alex and Nina have the frames their ids 8 and 11 show.
def ANIM_EXERCISE       equ $05 ; OBJ_JUMPING_JACKS_A/_B: the exercise, four poses held $30 frames each, looped
def ANIM_HOP            equ $05 ; OBJ_WALK_75_06: one quick crouch, then ANIM_WALK
def ANIM_SWING_LOOP     equ $06 ; the racket holders (the twelve-animation sprites, Bob, Pam, Beth, Fay,
                                ; OBJ_WALK_72_02, OBJ_WALK_71_05-07): backswing, follow-through, repeated
def ANIM_TROPHY_SINGLES equ $06 ; OBJ_TROPHY frames 2-3: the singles cup (ANIM_WALK shows the doubles trophy)
def ANIM_DISTANT        equ $08 ; Alex, Nina, Harry, Kate, Emily, Luigi, DK, Baby Mario: a smaller figure
                                ; stepping, as if far off (walking away through a doorway); Alex's and
                                ; Nina's sideways facings show a full-size front view instead
def ANIM_TROPHY_SMALL   equ $08 ; OBJ_TROPHY frames 4-5: the small trophy, glinting
def ANIM_OVERHEAD_SWING equ $08 ; Bob and OBJ_WALK_71_05-07: racket held overhead, a quick swing, the
                                ; follow-through held, looped
def ANIM_SWING_BACK     equ $09 ; the twelve-animation sprites: the backswing pose, held
def ANIM_SWING_THROUGH  equ $0a ; the twelve-animation sprites: the follow-through pose, held
def ANIM_SIDESTEP       equ $0b ; Alex and Nina: a lean to the side, twice, then held
