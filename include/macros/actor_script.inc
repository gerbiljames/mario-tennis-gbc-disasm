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

MACRO as_target_rel  ; $06 offset the move target by (dx, dy), in tiles with a point (4.0, -2.0)
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

MACRO as_rand_box    ; $09 pick a random reachable point in a box (gated on +$30 bit7)
	db $09, \1, \2
ENDM

MACRO as_step        ; $0a step one tick toward the target waypoint (+$16), then yield
	db $0a
ENDM

MACRO as_follow_wp   ; $0b advance along the waypoint list at +$16, then yield
	db $0b
ENDM

MACRO as_jump        ; $0c jump to `target` (signed rel16, relative to the operand)
	db $0c
	dw \1 - @
ENDM

MACRO as_set_field   ; $0d write a state field (selector byte, value word; type table $04:$47fd). Selector $14 = facing (FACE_* value)
	db $0d, \1
	dw \2
ENDM

MACRO as_add_field   ; $0e add to / set a state field (selector byte, value word)
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

MACRO as_begin_path  ; $13 seed the path target (+$16) from the current position
	db $13
ENDM

MACRO as_wait_move2  ; $14 wait for the move to finish / countdown
	db $14
ENDM

MACRO as_flag        ; $15 set or clear a state flag bit (mode: $01 set, else clear; field offset; bit index)
	db $15, \1, \2, \3
ENDM
