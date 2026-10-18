; Shared by AcademyMainBldgArrival01_10, MapArrivalWalk_11,
; RestaurantArrival01_10, RestaurantPlazaArrival04_13,
; DormEntranceArrival01_12 (banks $10, $11, $12, $13).

{TWIN_LABEL}:
	ld a, [wStoryModeEntryPoint]
	cp STORYENTRY_NONE
	jp z, .done
	test_flag FLAG_DOUBLES
	jr z, .walkOff
	script_set_speed ACTOR_PARTNER, 7.96875
	script_move_angle ACTOR_PARTNER, FACE_DOWN, 2.0
	script_wait_move ACTOR_PARTNER
	script_face ACTOR_PARTNER, FACE_UP
	script_set_speed ACTOR_PARTNER, 0.5
.walkOff:
	script_set_speed ACTOR_PLAYER, 0.5
	script_move_angle ACTOR_PLAYER, FACE_UP, 2.0
.done:
	ret
