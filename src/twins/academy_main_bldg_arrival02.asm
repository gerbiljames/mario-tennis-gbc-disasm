; Shared by AcademyMainBldgArrival02_10, AcademyArrivalArrival01_11,
; DormEntranceArrival02_12 (banks $10, $11, $12).

{TWIN_LABEL}:
	ld a, [wStoryModeEntryPoint]
	cp STORYENTRY_NONE
	jp z, .done
	test_flag FLAG_DOUBLES
	jr z, .playerWalkIn
	script_set_speed ACTOR_PARTNER, 7.96875
	script_move_angle ACTOR_PARTNER, FACE_UP, 2.0
	script_wait_move ACTOR_PARTNER
	script_face ACTOR_PARTNER, FACE_DOWN
	script_set_speed ACTOR_PARTNER, 0.5
.playerWalkIn:
	script_set_speed ACTOR_PLAYER, 0.5
	script_move_angle ACTOR_PLAYER, FACE_DOWN, 2.0
.done:
	ret
