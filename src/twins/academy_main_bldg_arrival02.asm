; One body under 3 names (banks $10, $11, $12), assembled through
; `twin_named academy_main_bldg_arrival02, <Label>` -- {TWIN_LABEL} is the label the bank gives it.
; No per-instruction addresses: the `twin_named` line carries the member's.
; A fix here lands in every copy.

{TWIN_LABEL}:
	ld a, [wStoryModeEntryPoint]
	cp STORYENTRY_NONE
	jp z, .done
	test_flag FLAG_DOUBLES
	jr z, .walkOff
	script_set_speed ACTOR_PARTNER, $00ff
	script_move_angle ACTOR_PARTNER, FACE_UP, $0200
	script_wait_move ACTOR_PARTNER
	script_face ACTOR_PARTNER, FACE_DOWN
	script_set_speed ACTOR_PARTNER, $0010
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010
	script_move_angle ACTOR_PLAYER, FACE_DOWN, $0200
.done:
	ret
