; AcademyWingOpenDoor_<bank>, one copy in each of banks $10, $27.

AcademyWingOpenDoor_{TWIN}:
	script_wait_frames 10
	sound SFX_DOOR_ALT
	script_copy_scene_rect 7, 56, 32, 56, 2, 2
	script_wait_frames 2
	script_copy_scene_rect 11, 56, 32, 56, 2, 2
	script_wait_frames 4
	ret
