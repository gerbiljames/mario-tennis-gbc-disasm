; OpenRestaurantEntDoor_<bank>, one copy in each of banks $13, $27.

OpenRestaurantEntDoor_{TWIN}:
	sound SFX_DOOR
	script_copy_scene_rect 20, 8, 6, 21, 2, 2
	script_copy_scene_rect 0, 21, 20, 8, 2, 2
	script_wait_frames 2
	script_copy_scene_rect 2, 21, 20, 8, 2, 2
	script_wait_frames 2
	script_copy_scene_rect 4, 21, 20, 8, 2, 2
	script_wait_frames 2
	ret
