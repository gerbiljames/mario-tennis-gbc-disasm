; Story-script commands (script_*): actor moves, dialogue, waits.

; Cutscene script commands. Story cutscenes are native code: register setups
; feeding farcalls into the bank $0a script engine. Each macro is one
; setup+farcall. `actor` is the target actor slot (ACTOR_PLAYER = the player).
; Usage: script_move_target actor, x, y
MACRO script_move_target
	map_pos \2, \3
	ld a, \1
	ld bc, (\2) >> 8
	ld de, (\3) >> 8
	farcall ScriptSetActorMoveTarget
ENDM

; Instantly places an actor (no walking).
; Usage: script_set_position actor, x, y
MACRO script_set_position
	map_pos \2, \3
	ld a, \1
	ld bc, (\2) >> 8
	ld de, (\3) >> 8
	farcall ScriptSetActorPosition
ENDM

; Usage: script_move_angle actor, angle, distance  (angle is a FACE_* cardinal;
; distance in tiles with a point, like a map position)
MACRO script_move_angle
	ASSERT (\3) % 256 == 0 && (\3) >= 0 && (\3) < 256.0, "distance \3: write tiles with a point, e.g. 2.0"
	ld a, \1
	ld b, \2
	ld de, (\3) >> 8
	farcall MoveActorByAngle
ENDM

; px_speed speed -- assert a move speed is written in pixels per frame with a
; point (1.0, 0.75). 1 px is $20 in position units (1/256 tile); the macros
; store `speed >> 11` of the Q16.16 literal, so it must be a multiple of 1/32 px.
MACRO px_speed
	ASSERT (\1) % 2048 == 0 && (\1) >= 0 && (\1) < 2048.0, "speed \1: write pixels per frame with a point, in 1/32 px"
ENDM

; Usage: script_set_speed actor, speed (pixels per frame)
MACRO script_set_speed
	px_speed \2
	ld a, \1
	ld bc, (\2) >> 11
	farcall ScriptSetActorMoveSpeed
ENDM

; Starts an actor's jump: velocity in pixels per frame, negative = up. Height
; is 64 units to the pixel and gravity adds 1/4 px per frame every frame, so
; -2.0 rises 8 px and lands 16 frames later.
; Usage: script_jump_velocity actor, velocity
MACRO script_jump_velocity
	ASSERT (\2) % 1024 == 0 && (\2) >= -512.0 && (\2) < 512.0, "jump velocity \2: write pixels per frame with a point, in 1/64 px"
	ld a, \1
	ld de, ((\2) >> 10) & $ffff
	farcall ScriptSetActorJumpVelocity
ENDM

; Usage: script_move_player x, y (moves actor $00, the player)
MACRO script_move_player
	map_pos \1, \2
	xor a
	ld bc, (\1) >> 8
	ld de, (\2) >> 8
	farcall MovePlayerToPosition
ENDM

; Usage: script_player_speed speed (pixels per frame)
MACRO script_player_speed
	px_speed \1
	ld bc, (\1) >> 11
	farcall SetPlayerMoveSpeed
ENDM

; Usage: script_set_text text_id (sets the next dialogue's text)
MACRO script_set_text
	ld hl, \1
	farcall InitDialogueTextCursor
ENDM

; Usage: script_set_anim actor, anim
MACRO script_set_anim
	ld a, \1
	ld d, \2
	farcall ScriptSetActorAnimation
ENDM

; Installs object definition `objdef` into `actor`: fetch the actor's state
; pointer into bc, then LoadActorObjectDefIfValid(bc, d = objdef).
; Usage: script_set_objdef objdef, actor
MACRO script_set_objdef
	ld d, \1
	ld a, \2
	farcall GetActorStateAddr
	ld c, l
	ld b, h
	farcall LoadActorObjectDefIfValid
ENDM

; Fetch `actor`'s state-struct address ($d000 + actor*$40) into hl.
; Usage: script_get_actor_state actor
MACRO script_get_actor_state
	ld a, \1
	farcall GetActorStateAddr
ENDM

; Usage: script_face actor, facing  (facing is a FACE_* constant)
MACRO script_face
	ld a, \1
	ld b, \2
	farcall SetActorFacing
ENDM

; Turns two actors to face each other (actor1 in b, actor2 in a).
; Usage: script_face_pair actor1, actor2
MACRO script_face_pair
	ld a, \1
	ld b, a
	ld a, \2
	farcall FaceActorsTowardEachOther
ENDM

; Turns `actor` (in b) to face `target` (in a); only `actor` turns.
; Usage: script_face_toward actor, target
MACRO script_face_toward
	ld a, \1
	ld b, a
	ld a, \2
	farcall FaceActorTowardActor
ENDM

; ScriptSetActorFacingLock with b != 0: sets bit 0 of the actor's +$30, so it
; keeps its facing while it walks.
; Usage: script_lock_facing actor
MACRO script_lock_facing
	ld a, \1
	ld b, $01
	farcall ScriptSetActorFacingLock
ENDM

; ScriptSetActorFacingLock with b = 0: clears the lock bit and copies the
; actor's facing (+$14) into +$34.
; Usage: script_unlock_facing actor
MACRO script_unlock_facing
	ld a, \1
	ld b, $00
	farcall ScriptSetActorFacingLock
ENDM

; Writes `state` to the actor's activity byte (state struct +$20).
; Usage: script_set_active actor, state
MACRO script_set_active
	ld a, \1
	ld b, \2
	farcall SetActorActive
ENDM

; Walks the player to `actor` (b is a position offset, always $00 here).
; Usage: script_move_player_to_actor actor
MACRO script_move_player_to_actor
	ld a, \1
	ld b, $00
	farcall MovePlayerToActor
ENDM

; Usage: script_speak actor
MACRO script_speak
	ld a, \1
	farcall ScriptShowSpeakerDialogue
ENDM

; script_speak, then restores the background the speaker's window covered.
; Usage: script_speak_restore actor
MACRO script_speak_restore
	ld a, \1
	farcall ScriptShowSpeakerDialogueRestoreBG
ENDM

; Usage: script_wait_idle actor
MACRO script_wait_idle
	ld a, \1
	farcall ScriptWaitActorIdle
ENDM

; Usage: script_wait_move actor
MACRO script_wait_move
	ld a, \1
	farcall ScriptWaitActorMoveDone
ENDM

; Blocks the cutscene until `actor`'s script finishes (CheckActorScriptEnd),
; advancing a frame each poll, with a ~600-frame timeout.
; Usage: script_wait_actor_script actor
MACRO script_wait_actor_script
	ld a, \1
	farcall WaitActorScriptDone
ENDM

; Detaches `actor`'s script: installs the shared idle script so the cutscene
; can drive the actor directly.
; Usage: script_null_script actor
MACRO script_null_script
	ld a, \1
	farcall SetActorNullScript
ENDM

; Waits `frames` frames, preserving a (callers hold an actor id there while the
; wait clobbers it with the frame count).
; Usage: script_wait_frames frames
MACRO script_wait_frames
	push af
	ld a, \1
	farcall WaitScriptFrames
	pop af
ENDM

; Copy a width x height tile rectangle between two scene-tilemap cells
; (CopySceneTilemapRect). Cells are (col, row) on the scene tilemap at
; $d000 + col + row*$40.
; Usage: script_copy_scene_rect src_col, src_row, dst_col, dst_row, width, height
MACRO script_copy_scene_rect
	ld b, \1
	ld c, \2
	ld d, \3
	ld e, \4
	ld h, \5
	ld l, \6
	farcall CopySceneTilemapRect
ENDM

; Wait `frames` frames through WaitScriptFramesSaveA (preserves af).
; Usage: script_delay frames
MACRO script_delay
	ld a, \1
	call WaitScriptFramesSaveA
ENDM

; Start a screen fade-in (BeginFadeIn; speed 0 is treated as 1).
; Usage: script_fade_in speed
MACRO script_fade_in
	ld c, \1
	call BeginFadeIn
ENDM

; Set actor `actor`'s script to `script`, a code pointer in the current bank
; (bank taken from hRomBank).
; Usage: script_set_actor_script actor, script
MACRO script_set_actor_script
	ldh a, [hRomBank]
	ld b, a
	ld a, \1
	ld de, \2
	farcall ScriptSetActorScript
ENDM
