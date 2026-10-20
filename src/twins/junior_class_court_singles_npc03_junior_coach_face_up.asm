; Shared by JuniorClassCourtSinglesNpc03JuniorCoachFaceUp_11, JuniorClassCourtDoublesNpc03JuniorCoachFaceUp_11 (bank $11).

{TWIN_LABEL}:
	script_set_speed ACTOR_PLAYER, 0.25
	script_lock_facing ACTOR_PLAYER
	script_move_target ACTOR_PLAYER, 19.0, 21.0
	script_wait_move ACTOR_PLAYER
	script_unlock_facing ACTOR_PLAYER
	script_face ACTOR_PLAYER, FACE_UP
