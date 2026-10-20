; Actor-script bytecode (the objdef blobs a map_actor points at).

; SpawnActor installs the blob as the actor's script pointer (state
; +$00/+$01 = address, +$02 = bank). StepActorScript runs it each frame,
; dispatching 1-byte opcodes through a 22-entry handler table; a handler
; returns 0 to yield for the frame or nonzero to run the next opcode. A script
; is a pool of fragments, each ending in an as_jump loop, entered at different
; offsets. Coordinates are 16-bit fixed-point map units. Full opcode reference:
; docs/actor_script.md.
MACRO as_halt        ; $00 inert: yield forever (no pointer advance)
	db $00
ENDM

MACRO as_wait        ; $01 wait `n` frames (state +$03 = n-1), then yield
	db $01, \1
ENDM

MACRO as_wait_move   ; $02 yield until the current move finishes (+$05 bit7)
	db $02
ENDM

MACRO as_set_pos     ; $03 teleport: set current position -> state +$0c/+$0e, clears the +$05 bit7 move flag
	map_pos \1, \2
	db $03
	dw (\1) >> 8, (\2) >> 8
ENDM

MACRO as_set_target  ; $04 set move target -> state +$08/+$0a, sets the +$05 bit7 move flag
	map_pos \1, \2
	db $04
	dw (\1) >> 8, (\2) >> 8
ENDM

MACRO as_halt5       ; $05 inert (handler alias of $00)
	db $05
ENDM

MACRO as_move_by     ; $06 start a move to the current position + (dx, dy), in tiles with a point (4.0, -2.0)
	map_offset \1, \2
	db $06
	dw (\1) >> 8, (\2) >> 8
ENDM

MACRO as_move        ; $07 move by angle (byte) + distance (word), absolute
	db $07, \1
	dw \2
ENDM

MACRO as_move_rel    ; $08 move by angle + distance, angle relative to facing
	db $08, \1
	dw \2
ENDM

MACRO as_rand_box    ; $09 pick a random reachable target in a box around the as_set_wander_home centre (only while ACTORSTATUSB_ON_SCREEN)
	db $09, \1, \2
ENDM

MACRO as_step        ; $0a trail the ACTORF_ANCHOR actor (2 tiles behind, its speed), then yield
	db $0a
ENDM

MACRO as_follow_wp   ; $0b head for the ACTORF_ANCHOR actor's position, then yield
	db $0b
ENDM

MACRO as_jump        ; $0c jump to `target` (signed rel16, relative to the operand)
	db $0c
	dw \1 - @
ENDM

MACRO as_set_field   ; $0d write a state field (selector byte, value word; type table $04:$47fd). selector = ACTORF_* offset
	db $0d, \1
	dw \2
ENDM

MACRO as_add_field   ; $0e add to a state field (selector byte, value word); unused, and adds the wrong word (docs/bugs.md)
	db $0e, \1
	dw \2
ENDM

MACRO as_halt15      ; $0f inert (handler alias of $00)
	db $0f
ENDM

MACRO as_anim        ; $10 set animation id
	db $10, \1
ENDM

MACRO as_sound       ; $11 play sound id
	db $11, \1
ENDM

MACRO as_call        ; $12 call a same-bank function (actor state in bc); yield+retry if busy
	db $12
	dw \1
ENDM

MACRO as_set_wander_home ; $13 centre as_rand_box's box (ACTORF_ANCHOR) on the current tile, speed 8, set ACTORFLAGB_YIELD
	db $13
ENDM

MACRO as_wait_move_or_blocked ; $14 yield until the move finishes (then wait 40 frames) or stops short for the player (ACTORFLAGB_BLOCKED, then wait 10)
	db $14
ENDM

MACRO as_flag        ; $15 set or clear a state flag bit (mode: $01 set, else clear; field offset; bit index)
	db $15, \1, \2, \3
ENDM
