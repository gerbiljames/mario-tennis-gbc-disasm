; Shared by Court2EntryWalkIn, RestaurantPlazaFromTrainingCourt_13 (banks $13, $14).

{TWIN_LABEL}:
	ld a, [wStoryModeEntryPoint]
	cp STORYENTRY_NONE
	jp z, .done
	test_flag FLAG_DOUBLES
	jr z, .playerWalkIn
	script_set_speed ACTOR_PARTNER, 7.96875
	script_move_angle ACTOR_PARTNER, FACE_RIGHT, 2.0
	script_wait_move ACTOR_PARTNER
	script_face ACTOR_PARTNER, FACE_LEFT
	script_set_speed ACTOR_PARTNER, 0.5
.playerWalkIn:
	script_set_speed ACTOR_PLAYER, 0.5
	script_move_angle ACTOR_PLAYER, FACE_LEFT, 2.0
.done:
	ret
