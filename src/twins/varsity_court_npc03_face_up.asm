; Shared by VarsityCourtANpc03FaceUp_13, VarsityCourtBNpc03FaceUp_13 (bank $13).

{TWIN_LABEL}:
	script_set_speed ACTOR_PLAYER, 0.25
	script_lock_facing ACTOR_PLAYER
	script_move_target ACTOR_PLAYER, 13.0, 31.0
	script_wait_move ACTOR_PLAYER
	script_unlock_facing ACTOR_PLAYER
	script_face ACTOR_PLAYER, FACE_UP
