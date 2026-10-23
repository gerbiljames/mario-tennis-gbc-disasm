ActorScript_27_02:
	; $4b67, 25 bytes (actor_script)
	as_set_target 19.0, 21.0
	as_wait_move
	as_set_target 19.0, 11.0
	as_wait_move
	as_set_target 14.0, 11.0
	as_wait_move
	as_set_target 14.0, 7.0
	as_wait_move
	as_halt
ActorScript_27_03:
	; $4b80, 60 bytes (actor_script)
	as_set_target 19.0, 19.0
	as_wait_move
	as_set_target 19.0, 11.0
	as_wait_move
	as_set_target 14.0, 11.0
	as_wait_move
	as_set_target 14.0, 7.0
	as_wait_move
	as_halt
	as_flag $01, ACTORF_FLAGS, ACTORFLAGB_YIELD
	as_set_field ACTORF_SPEED, $0010
.pace:
	as_move_by -2.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_wait 75
	as_move_by 2.0, 0.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_wait 75
	as_jump .pace
End12PrincipalsOfficeMapScripts_27:
	; $4bbc, 14 bytes (map_tree)
	dw End12PrincipalsOfficeEntryPoints_27 ; slot 0 EntryPoints
	dw End12PrincipalsOfficeExitTriggers_27 ; slot 1 ExitTriggers
	dw End12PrincipalsOfficeActors_27 ; slot 2 Actors
	dw End12PrincipalsOfficeNpcScripts_27 ; slot 3 NpcScripts
	dw End12PrincipalsOfficeFacingScripts_27 ; slot 4 FacingScripts
	dw End12PrincipalsOfficeTileTriggers_27 ; slot 5 TileTriggers
	dw End12PrincipalsOfficeInitScript_27 ; slot 6 InitScript
End12PrincipalsOfficeActors_27:
	; $4bca, 122 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_ANGRY, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_BALLOON_ANGRY
	map_actor $0000, ActorScript_27_27, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_BALLOON_SWEAT_1
	map_actor $0000, ActorScript_27_27, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_MUSIC, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_BALLOON_MUSIC
	map_actor $0000, ActorScript_27_27, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_BALLOON_SWEAT_2
	map_actor $0000, ActorScript_27_27, 32.0, 47.0, FACE_DOWN, OBJ_HEADMASTER, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_HEADMASTER
	map_actor $0000, ActorScript_27_27, 34.0, 51.0, FACE_LEFT, OBJ_KEVIN, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_KEVIN
	map_actor $0000, ActorScript_27_27, 32.0, 51.0, FACE_LEFT, OBJ_MARK, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_MARK
	map_actor $0000, ActorScript_27_27, 30.0, 51.0, FACE_RIGHT, OBJ_EMILY, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_EMILY
	map_actor_end
End12PrincipalsOfficeEntryPoints_27:
	; $4c44, 17 bytes (map_entries)
	map_entry $01, FACE_LEFT, 31.0, 59.0, $0000, END12_PRINCIPALS_OFFICE_SCENE_A
	map_entry $02, FACE_LEFT, 31.0, 59.0, $0000, END12_PRINCIPALS_OFFICE_SCENE_B
	db $ff
End12PrincipalsOfficeExitTriggers_27:
	; $4c55, 9 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_ACADEMY_ENTRANCE, ENTRY_ACADEMY_ENTRANCE_FROM_ACADEMY_MAIN_BLDG, END12_PRINCIPALS_OFFICE_DONE
	db $ff
End12PrincipalsOfficeNpcScripts_27:
	db $ff ; $4c5e
End12PrincipalsOfficeFacingScripts_27:
	db $ff ; $4c5f
End12PrincipalsOfficeTileTriggers_27:
	db $ff ; $4c60
End12PrincipalsOfficeInitScript_27:
	ld a, $16 ; $4c61
	ld [wMapScrollMinX], a ; $4c63
	ld a, $28 ; $4c66
	ld [wMapScrollMinY], a ; $4c68
	ld a, $40 ; $4c6b
	ld [wMapWidthTiles], a ; $4c6d
	ld a, $3e ; $4c70
	ld [wMapHeightTiles], a ; $4c72
	call DisableLCDSafely ; $4c75
	ld a, SCENECOPY_FROM_PLAYER ; $4c78
	farcall CopyScrolledSceneTilemapToVram ; $4c7a
	call EnableLCD ; $4c7d
	ld a, [wStoryModeEntryPoint] ; $4c80
	cp ENTRY_END12_PRINCIPALS_OFFICE_SCENE_B ; $4c83
	jp z, .altScene ; $4c85
	jp .sceneA ; $4c88
	ret ; $4c8b
.sceneA:
	xor a ; $4c8c
	ld [wStoryModeShowLocationName], a ; $4c8d
	script_set_position ACTOR_PLAYER, 43.0, 59.0 ; $4c90
	script_set_position ACTOR_PARTNER, 43.0, 59.0 ; $4c9b
	script_fade_in 4 ; $4ca6
	script_delay 20 ; $4cab
	script_move_target ACTOR_END12_PRINCIPALS_OFFICE_HEADMASTER, 30.0, 47.0 ; $4cb0
	script_wait_move ACTOR_END12_PRINCIPALS_OFFICE_HEADMASTER ; $4cbb
	script_face ACTOR_END12_PRINCIPALS_OFFICE_HEADMASTER, FACE_DOWN ; $4cc0
	script_delay 30 ; $4cc7
	script_move_target ACTOR_END12_PRINCIPALS_OFFICE_HEADMASTER, 34.0, 47.0 ; $4ccc
	script_wait_move ACTOR_END12_PRINCIPALS_OFFICE_HEADMASTER ; $4cd7
	script_face ACTOR_END12_PRINCIPALS_OFFICE_HEADMASTER, FACE_DOWN ; $4cdc
	script_delay 30 ; $4ce3
	script_move_target ACTOR_END12_PRINCIPALS_OFFICE_HEADMASTER, 32.0, 47.0 ; $4ce8
	script_wait_move ACTOR_END12_PRINCIPALS_OFFICE_HEADMASTER ; $4cf3
	script_face ACTOR_END12_PRINCIPALS_OFFICE_HEADMASTER, FACE_DOWN ; $4cf8
	script_delay 10 ; $4cff
	script_set_anim ACTOR_END12_PRINCIPALS_OFFICE_HEADMASTER, ANIM_BOUNCE ; $4d04
	script_wait_idle ACTOR_END12_PRINCIPALS_OFFICE_HEADMASTER ; $4d0b
	script_face ACTOR_END12_PRINCIPALS_OFFICE_KEVIN, FACE_UP ; $4d10
	script_face ACTOR_END12_PRINCIPALS_OFFICE_MARK, FACE_UP ; $4d17
	script_face ACTOR_END12_PRINCIPALS_OFFICE_EMILY, FACE_UP ; $4d1e
	sound SFX_APPEAR2 ; $4d25
	script_set_position ACTOR_END12_PRINCIPALS_OFFICE_BALLOON_SWEAT_1, 31.5, 49.5 ; $4d27
	script_delay 40 ; $4d32
	sound SFX_APPEAR2 ; $4d37
	script_set_position ACTOR_END12_PRINCIPALS_OFFICE_BALLOON_SWEAT_2, 33.5, 49.5 ; $4d39
	script_delay 40 ; $4d44
	sound SFX_APPEAR2 ; $4d49
	script_set_position ACTOR_END12_PRINCIPALS_OFFICE_BALLOON_SWEAT_1, 35.5, 49.5 ; $4d4b
	script_delay 40 ; $4d56
	script_set_position ACTOR_END12_PRINCIPALS_OFFICE_BALLOON_SWEAT_2, 63.0, 63.0 ; $4d5b
	script_delay 40 ; $4d66
	script_set_position ACTOR_END12_PRINCIPALS_OFFICE_BALLOON_SWEAT_1, 63.0, 63.0 ; $4d6b
	test_flag FLAG_DOUBLES ; $4d76
	jp z, .walkPlayer ; $4d79
	script_null_script ACTOR_PARTNER ; $4d7c
	script_set_position ACTOR_PARTNER, 45.0, 59.0 ; $4d81
	script_move_target ACTOR_PLAYER, 33.0, 59.0 ; $4d8c
	script_move_target ACTOR_PARTNER, 35.0, 59.0 ; $4d97
	script_wait_move ACTOR_PARTNER ; $4da2
	script_wait_frames 5 ; $4da7
	script_face ACTOR_PLAYER, FACE_UP ; $4dae
	call AcademyWingOpenDoor_27 ; $4db5
	script_move_target ACTOR_PLAYER, 33.0, 53.0 ; $4db8
	script_move_target ACTOR_PARTNER, 33.0, 59.0 ; $4dc3
	script_wait_move ACTOR_PARTNER ; $4dce
	script_move_target ACTOR_PLAYER, 31.0, 53.0 ; $4dd3
	script_move_target ACTOR_PARTNER, 33.0, 53.0 ; $4dde
	script_wait_move ACTOR_PARTNER ; $4de9
	script_move_target ACTOR_PARTNER, 33.0, 53.0 ; $4dee
	script_wait_move ACTOR_PARTNER ; $4df9
	script_face ACTOR_PLAYER, FACE_UP ; $4dfe
	script_face ACTOR_PARTNER, FACE_UP ; $4e05
	script_delay 1 ; $4e0c
	jr .closePrincipalsOfficeDoor ; $4e11
.walkPlayer:
	script_move_target ACTOR_PLAYER, 33.0, 59.0 ; $4e13
	script_wait_move ACTOR_PLAYER ; $4e1e
	script_face ACTOR_PLAYER, FACE_UP ; $4e23
	call AcademyWingOpenDoor_27 ; $4e2a
	script_move_target ACTOR_PLAYER, 33.0, 53.0 ; $4e2d
	script_wait_move ACTOR_PLAYER ; $4e38
	script_move_target ACTOR_PLAYER, 32.0, 53.0 ; $4e3d
	script_wait_move ACTOR_PLAYER ; $4e48
	script_face ACTOR_PLAYER, FACE_UP ; $4e4d
	script_delay 1 ; $4e54
.closePrincipalsOfficeDoor:
	call AcademyWingCloseDoor_27 ; $4e59
	script_set_anim ACTOR_END12_PRINCIPALS_OFFICE_HEADMASTER, ANIM_BOUNCE ; $4e5c
	script_set_anim ACTOR_END12_PRINCIPALS_OFFICE_KEVIN, ANIM_BOUNCE ; $4e63
	script_set_anim ACTOR_END12_PRINCIPALS_OFFICE_MARK, ANIM_BOUNCE ; $4e6a
	script_set_anim ACTOR_END12_PRINCIPALS_OFFICE_EMILY, ANIM_BOUNCE ; $4e71
	script_wait_idle ACTOR_END12_PRINCIPALS_OFFICE_EMILY ; $4e78
	script_delay 30 ; $4e7d
	script_move_target ACTOR_END12_PRINCIPALS_OFFICE_EMILY, 29.0, 53.0 ; $4e82
	script_move_target ACTOR_END12_PRINCIPALS_OFFICE_MARK, 35.0, 53.0 ; $4e8d
	script_move_target ACTOR_END12_PRINCIPALS_OFFICE_KEVIN, 37.0, 53.0 ; $4e98
	script_wait_move ACTOR_END12_PRINCIPALS_OFFICE_KEVIN ; $4ea3
	script_face ACTOR_END12_PRINCIPALS_OFFICE_EMILY, FACE_RIGHT ; $4ea8
	script_face ACTOR_END12_PRINCIPALS_OFFICE_MARK, FACE_LEFT ; $4eaf
	script_face ACTOR_END12_PRINCIPALS_OFFICE_KEVIN, FACE_LEFT ; $4eb6
	script_delay 10 ; $4ebd
	test_flag FLAG_DOUBLES ; $4ec2
	jp z, .singles ; $4ec5
	script_delay 60 ; $4ec8
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $4ecd
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $4ed5
	script_wait_idle ACTOR_PLAYER ; $4edc
	script_delay 20 ; $4ee1
	script_face_toward ACTOR_PLAYER, ACTOR_PARTNER ; $4ee6
	script_delay 1 ; $4eee
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $4ef3
	script_wait_idle ACTOR_PARTNER ; $4efa
	script_delay 20 ; $4eff
	script_face ACTOR_PLAYER, FACE_UP ; $4f04
	script_face ACTOR_PARTNER, FACE_UP ; $4f0b
	script_set_anim ACTOR_END12_PRINCIPALS_OFFICE_KEVIN, ANIM_NOD ; $4f12
	script_set_anim ACTOR_END12_PRINCIPALS_OFFICE_MARK, ANIM_NOD ; $4f19
	script_set_anim ACTOR_END12_PRINCIPALS_OFFICE_EMILY, ANIM_NOD ; $4f20
	script_wait_idle ACTOR_END12_PRINCIPALS_OFFICE_EMILY ; $4f27
	script_delay 40 ; $4f2c
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4f31
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $4f38
	script_wait_idle ACTOR_PARTNER ; $4f3f
	script_move_target ACTOR_PLAYER, 31.0, 50.0 ; $4f44
	script_move_target ACTOR_PARTNER, 33.0, 50.0 ; $4f4f
	script_wait_move ACTOR_PARTNER ; $4f5a
	jp .exit ; $4f5f
.singles:
	sound SFX_APPEAR2 ; $4f62
	script_set_position ACTOR_END12_PRINCIPALS_OFFICE_BALLOON_SWEAT_1, 33.5, 51.5 ; $4f64
	script_delay 80 ; $4f6f
	script_set_position ACTOR_END12_PRINCIPALS_OFFICE_BALLOON_SWEAT_1, 63.0, 63.0 ; $4f74
	script_face_toward ACTOR_END12_PRINCIPALS_OFFICE_EMILY, ACTOR_PLAYER ; $4f7f
	script_delay 40 ; $4f87
	script_face_toward ACTOR_PLAYER, ACTOR_END12_PRINCIPALS_OFFICE_EMILY ; $4f8c
	script_delay 1 ; $4f94
	script_set_anim ACTOR_END12_PRINCIPALS_OFFICE_EMILY, ANIM_NOD ; $4f99
	script_wait_idle ACTOR_END12_PRINCIPALS_OFFICE_EMILY ; $4fa0
	script_delay 20 ; $4fa5
	script_face ACTOR_PLAYER, FACE_UP ; $4faa
	script_set_anim ACTOR_END12_PRINCIPALS_OFFICE_KEVIN, ANIM_NOD ; $4fb1
	script_set_anim ACTOR_END12_PRINCIPALS_OFFICE_MARK, ANIM_NOD ; $4fb8
	script_set_anim ACTOR_END12_PRINCIPALS_OFFICE_EMILY, ANIM_NOD ; $4fbf
	script_wait_idle ACTOR_END12_PRINCIPALS_OFFICE_EMILY ; $4fc6
	script_delay 40 ; $4fcb
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4fd0
	script_move_target ACTOR_PLAYER, 32.0, 50.0 ; $4fd7
	script_wait_move ACTOR_PLAYER ; $4fe2
.exit:
	ld a, EXIT_END12_PRINCIPALS_OFFICE_DONE ; $4fe7
	ld [wUnusedExitTriggerIdMirror], a ; $4fe9
	ld [wStoryModeExitTriggerRequest], a ; $4fec
	ret ; $4fef
.altScene:
	script_respawn_actors End12PrincipalsOfficeActorsAlt_27 ; $4ff0
	farcall BeginCutsceneScriptMode ; $4ff8
	script_set_anim ACTOR_END12_PRINCIPALS_OFFICE_ALT_TROPHY_1, ANIM_TROPHY_SINGLES ; $4ffb
	test_flag FLAG_DOUBLES ; $5002
	jp z, .altSingles ; $5005
	script_null_script ACTOR_PARTNER ; $5008
	script_set_position ACTOR_PLAYER, 31.0, 52.0 ; $500d
	script_set_position ACTOR_PARTNER, 33.0, 52.0 ; $5018
	script_face ACTOR_PARTNER, FACE_UP ; $5023
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $502a
	jr nz, .face ; $502d
	script_set_position ACTOR_END12_PRINCIPALS_OFFICE_ALT_TROPHY_1, 63.0, 63.0 ; $502f
	jr .face ; $503a
.altSingles:
	script_set_position ACTOR_PLAYER, 32.0, 52.0 ; $503c
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $5047
	jr nz, .face ; $504a
	script_set_position ACTOR_END12_PRINCIPALS_OFFICE_ALT_TROPHY_2, 63.0, 63.0 ; $504c
.face:
	script_face ACTOR_PLAYER, FACE_UP ; $5057
	xor a ; $505e
	ld [wStoryModeShowLocationName], a ; $505f
	script_fade_in 4 ; $5062
	call WaitFadeEnd ; $5067
	test_flag FLAG_DOUBLES ; $506a
	jp z, .altSinglesExit ; $506d
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $5070
	script_wait_idle ACTOR_PLAYER ; $5077
	script_set_anim ACTOR_END12_PRINCIPALS_OFFICE_ALT_HEADMASTER, ANIM_NOD ; $507c
	script_wait_idle ACTOR_END12_PRINCIPALS_OFFICE_ALT_HEADMASTER ; $5083
	script_delay 60 ; $5088
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $508d
	script_delay 30 ; $5095
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $509a
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $50a1
	script_wait_idle ACTOR_PARTNER ; $50a8
	script_face ACTOR_PARTNER, FACE_DOWN ; $50ad
	script_move_target ACTOR_PLAYER, 33.0, 54.0 ; $50b4
	script_wait_move ACTOR_PLAYER ; $50bf
	script_move_target ACTOR_PLAYER, 33.0, 55.0 ; $50c4
	script_move_target ACTOR_PARTNER, 33.0, 53.0 ; $50cf
	script_wait_move ACTOR_PARTNER ; $50da
	call AcademyWingOpenDoor_27 ; $50df
	script_set_actor_script ACTOR_PLAYER, ActorScript_27_04 ; $50e2
	script_set_actor_script ACTOR_PARTNER, ActorScript_27_04 ; $50ed
	script_delay 20 ; $50f8
	jr .closeDoorBehind ; $50fd
.altSinglesExit:
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $50ff
	script_wait_idle ACTOR_PLAYER ; $5106
	script_set_anim ACTOR_END12_PRINCIPALS_OFFICE_ALT_HEADMASTER, ANIM_NOD ; $510b
	script_wait_idle ACTOR_END12_PRINCIPALS_OFFICE_ALT_HEADMASTER ; $5112
	script_delay 60 ; $5117
	script_move_target ACTOR_PLAYER, 33.0, 52.0 ; $511c
	script_wait_move ACTOR_PLAYER ; $5127
	script_move_target ACTOR_PLAYER, 33.0, 55.0 ; $512c
	script_wait_move ACTOR_PLAYER ; $5137
	call AcademyWingOpenDoor_27 ; $513c
	script_set_actor_script ACTOR_PLAYER, ActorScript_27_04 ; $513f
	script_delay 20 ; $514a
.closeDoorBehind:
	call AcademyWingCloseDoor_27 ; $514f
	script_delay 60 ; $5152
	set_flag FLAG_ENDING_CREDITS_PENDING ; $5157
	script_fade_out 4 ; $515a
	call WaitFadeEnd ; $515f
	ld a, EXIT_END12_PRINCIPALS_OFFICE_DONE ; $5162
	ld [wUnusedExitTriggerIdMirror], a ; $5164
	ld [wStoryModeExitTriggerRequest], a ; $5167
	ret ; $516a
	twin academy_wing_open_door, 27 ; $516b AcademyWingOpenDoor_27
	twin academy_wing_close_door, 27 ; $51a1 AcademyWingCloseDoor_27
ActorScript_27_04:
	; $51d0, 13 bytes (actor_script)
	as_set_target 33.0, 59.0
	as_wait_move
	as_set_target 53.0, 59.0
	as_wait_move
	as_halt
End12PrincipalsOfficeActorsAlt_27:
	; $51dd, 52 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, 32.0, 48.0, FACE_DOWN, OBJ_HEADMASTER, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_ALT_HEADMASTER
	map_actor $0000, ActorScript_27_27, 39.0, 50.25, FACE_DOWN, OBJ_TROPHY, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_ALT_TROPHY_1
	map_actor $0000, ActorScript_27_27, 39.0, 48.75, FACE_DOWN, OBJ_TROPHY, ANIM_WALK, $00, END12_PRINCIPALS_OFFICE_ALT_TROPHY_2
	map_actor_end
End11TrainingCourtMapScripts_27:
	; $5211, 14 bytes (map_tree)
	dw End11TrainingCourtEntryPoints_27 ; slot 0 EntryPoints
	dw End11TrainingCourtExitTriggers_27 ; slot 1 ExitTriggers
	dw End11TrainingCourtActors_27 ; slot 2 Actors
	dw End11TrainingCourtNpcScripts_27 ; slot 3 NpcScripts
	dw End11TrainingCourtFacingScripts_27 ; slot 4 FacingScripts
	dw End11TrainingCourtTileTriggers_27 ; slot 5 TileTriggers
	dw End11TrainingCourtInitScript_27 ; slot 6 InitScript
End11TrainingCourtActors_27:
	; $521f, 52 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, 63.0, 5.0, FACE_DOWN, OBJ_WATER_SPRITE, ANIM_WALK, $00, END11_TRAINING_COURT_WATER_SPRITE
	map_actor $0000, ActorScript_27_27, 63.0, 5.0, FACE_DOWN, OBJ_BALLOON_QUESTION, ANIM_WALK, $00, END11_TRAINING_COURT_BALLOON_QUESTION
	map_actor $0000, ActorScript_27_27, 63.0, 5.0, FACE_DOWN, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, END11_TRAINING_COURT_BALLOON_EXCLAIM
	map_actor_end
End11TrainingCourtEntryPoints_27:
	; $5253, 17 bytes (map_entries)
	map_entry $01, FACE_DOWN, 51.0, 13.0, $0000, END11_TRAINING_COURT_SCENE_A
	map_entry $02, FACE_UP, 24.0, 17.0, $0000, END11_TRAINING_COURT_SCENE_B
	db $ff
End11TrainingCourtExitTriggers_27:
	; $5264, 9 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_RESTAURANT_PLAZA, $00, END11_TRAINING_COURT_DONE
	db $ff
End11TrainingCourtNpcScripts_27:
	db $ff ; $526d
End11TrainingCourtFacingScripts_27:
	db $ff ; $526e
End11TrainingCourtTileTriggers_27:
	db $ff ; $526f
End11TrainingCourtInitScript_27:
	ld a, [wStoryModeEntryPoint] ; $5270
	cp ENTRY_END11_TRAINING_COURT_SCENE_A ; $5273
	jp z, .sceneA ; $5275
	cp ENTRY_END11_TRAINING_COURT_SCENE_B ; $5278
	jp z, .altScene ; $527a
	ret ; $527d
.sceneA:
	test_flag FLAG_DOUBLES ; $527e
	jr z, .mirrorIfLeftHanded ; $5281
	script_set_actor_script ACTOR_PARTNER, ActorScript_27_27 ; $5283
	script_set_position ACTOR_PARTNER, 63.0, 63.0 ; $528e
.mirrorIfLeftHanded:
	ld a, [wStoryMainLeftHanded] ; $5299
	and a ; $529c
	jr z, .face ; $529d
	script_get_actor_state ACTOR_PLAYER ; $529f
	ld c, l ; $52a4
	ld b, h ; $52a5
	ld hl, ACTORF_OAM_ATTR ; $52a6
	add hl, bc ; $52a9
	ld a, [hl] ; $52aa
	xor $20 ; $52ab
	ld [hl], a ; $52ad
.face:
	script_face ACTOR_PLAYER, FACE_DOWN ; $52ae
	script_set_actor_script ACTOR_PLAYER, ActorScript_27_06 ; $52b5
	xor a ; $52c0
	ld [wStoryModeShowLocationName], a ; $52c1
	script_fade_in 4 ; $52c4
	script_delay 120 ; $52c9
	script_get_actor_state ACTOR_PLAYER ; $52ce
	ld a, $01 ; $52d3
	ld e, l ; $52d5
	ld d, h ; $52d6
	ld hl, ACTORF_ANIM_RATE ; $52d7
	add hl, de ; $52da
	ld [hl], a ; $52db
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $52dc
	script_wait_idle ACTOR_PLAYER ; $52e3
	script_null_script ACTOR_PLAYER ; $52e8
	script_set_anim ACTOR_PLAYER, ANIM_WALK ; $52ed
	script_delay 60 ; $52f4
	script_face ACTOR_PLAYER, FACE_LEFT ; $52f9
	script_delay 30 ; $5300
	script_face ACTOR_PLAYER, FACE_RIGHT ; $5305
	script_delay 30 ; $530c
	script_face ACTOR_PLAYER, FACE_LEFT ; $5311
	script_delay 30 ; $5318
	script_face ACTOR_PLAYER, FACE_RIGHT ; $531d
	script_delay 30 ; $5324
	script_face ACTOR_PLAYER, FACE_DOWN ; $5329
	script_delay 30 ; $5330
	sound SFX_EMOTE ; $5335
	script_set_position ACTOR_END11_TRAINING_COURT_BALLOON_QUESTION, 52.5, 11.5 ; $5337
	script_delay 60 ; $5342
	script_set_position ACTOR_END11_TRAINING_COURT_WATER_SPRITE, 51.0, 7.0 ; $5347
	script_set_actor_mode ACTOR_END11_TRAINING_COURT_WATER_SPRITE, ACTORMODE_HIDDEN ; $5352
	script_player_speed 0.5 ; $5359
	script_move_player_to_actor ACTOR_END11_TRAINING_COURT_WATER_SPRITE ; $535f
	ld hl, End11TrainingCourtDimPalettes_27 ; $5366
	ld_bg_pals de, 2, 6 ; $5369
	call LoadPalettesImmediate ; $536c
	script_delay 30 ; $536f
	ld hl, End11TrainingCourtDarkPalettes_27 ; $5374
	ld_bg_pals de, 2, 6 ; $5377
	call LoadPalettesImmediate ; $537a
	ld a, $10 ; $537d
.loop:
	ld d, a ; $537f
	script_set_actor_mode ACTOR_END11_TRAINING_COURT_WATER_SPRITE, ACTORMODE_VISIBLE ; $5380
	script_wait_frames 4 ; $5387
	script_set_actor_mode ACTOR_END11_TRAINING_COURT_WATER_SPRITE, ACTORMODE_HIDDEN ; $538e
	push af ; $5395
	ld a, d ; $5396
	farcall WaitScriptFrames ; $5397
	pop af ; $539a
	ld a, d ; $539b
	sub $02 ; $539c
	jp nz, .loop ; $539e
	script_set_actor_mode ACTOR_END11_TRAINING_COURT_WATER_SPRITE, ACTORMODE_VISIBLE ; $53a1
	script_delay 60 ; $53a8
	script_set_position ACTOR_END11_TRAINING_COURT_BALLOON_QUESTION, 63.0, 63.0 ; $53ad
	script_face ACTOR_PLAYER, FACE_UP ; $53b8
	script_delay 30 ; $53bf
	sound SFX_CHIME ; $53c4
	script_set_position ACTOR_END11_TRAINING_COURT_BALLOON_EXCLAIM, 52.5, 11.5 ; $53c6
	script_delay 20 ; $53d1
	script_jump_velocity ACTOR_END11_TRAINING_COURT_BALLOON_EXCLAIM, -3.0 ; $53d6
	script_jump_velocity ACTOR_PLAYER, -3.0 ; $53de
	script_wait_jump ACTOR_PLAYER ; $53e6
	script_delay 30 ; $53eb
	ld a, EXIT_END11_TRAINING_COURT_DONE ; $53f0
	ld [wUnusedExitTriggerIdMirror], a ; $53f2
	ld [wStoryModeExitTriggerRequest], a ; $53f5
	ret ; $53f8
.altScene:
	script_respawn_actors End11TrainingCourtActorsAlt_27 ; $53f9
	script_set_position ACTOR_PLAYER, 24.0, 17.0 ; $5401
	farcall BeginCutsceneScriptMode ; $540c
	script_face ACTOR_PLAYER, FACE_UP ; $540f
	script_set_position ACTOR_END11_TRAINING_COURT_ALT_BOB, 24.0, 13.0 ; $5416
	script_face ACTOR_END11_TRAINING_COURT_ALT_BOB, FACE_DOWN ; $5421
	script_null_script ACTOR_PARTNER ; $5428
	script_set_position ACTOR_PARTNER, 19.0, 17.0 ; $542d
	script_face ACTOR_PARTNER, FACE_RIGHT ; $5438
	script_move_player 24.0, 15.0 ; $543f
	farcall WaitPlayerMoveDone ; $5449
	script_fade_in 8 ; $544c
	call WaitFadeEnd ; $5451
	script_wait_frames 30 ; $5454
	script_set_anim ACTOR_END11_TRAINING_COURT_ALT_BOB, ANIM_BOUNCE ; $545b
	script_wait_idle ACTOR_END11_TRAINING_COURT_ALT_BOB ; $5462
	script_lock_facing ACTOR_END11_TRAINING_COURT_ALT_BOB ; $5467
	script_move_angle ACTOR_END11_TRAINING_COURT_ALT_BOB, FACE_UP, 1.0 ; $546e
	script_wait_move ACTOR_END11_TRAINING_COURT_ALT_BOB ; $5478
	script_wait_frames 40 ; $547d
	script_move_angle ACTOR_END11_TRAINING_COURT_ALT_BOB, FACE_UP, 1.0 ; $5484
	script_wait_move ACTOR_END11_TRAINING_COURT_ALT_BOB ; $548e
	script_set_anim ACTOR_END11_TRAINING_COURT_ALT_BOB, ANIM_BOUNCE ; $5493
	script_wait_idle ACTOR_END11_TRAINING_COURT_ALT_BOB ; $549a
	script_unlock_facing ACTOR_END11_TRAINING_COURT_ALT_BOB ; $549f
	script_set_speed ACTOR_END11_TRAINING_COURT_ALT_BOB, 1.5 ; $54a6
	script_get_actor_state ACTOR_END11_TRAINING_COURT_ALT_BOB ; $54ae
	ld a, $04 ; $54b3
	ld e, l ; $54b5
	ld d, h ; $54b6
	ld hl, ACTORF_ANIM_RATE ; $54b7
	add hl, de ; $54ba
	ld [hl], a ; $54bb
	script_move_target ACTOR_END11_TRAINING_COURT_ALT_BOB, 31.0, 11.0 ; $54bc
	script_wait_move ACTOR_END11_TRAINING_COURT_ALT_BOB ; $54c7
	script_move_target ACTOR_END11_TRAINING_COURT_ALT_BOB, 31.0, 17.0 ; $54cc
	script_wait_move ACTOR_END11_TRAINING_COURT_ALT_BOB ; $54d7
	script_face ACTOR_PLAYER, FACE_DOWN ; $54dc
	script_move_target ACTOR_END11_TRAINING_COURT_ALT_BOB, 31.0, 31.0 ; $54e3
	script_wait_move ACTOR_END11_TRAINING_COURT_ALT_BOB ; $54ee
	script_set_position ACTOR_END11_TRAINING_COURT_ALT_BOB, 63.0, 63.0 ; $54f3
	ld a, EXIT_END11_TRAINING_COURT_DONE ; $54fe
	ld [wUnusedExitTriggerIdMirror], a ; $5500
	ld [wStoryModeExitTriggerRequest], a ; $5503
	ret ; $5506
End11TrainingCourtActorsAlt_27:
	; $5507, 80 bytes (map_actors)
	map_actor $0000, ActorScript_27_05, 11.0, 7.0, FACE_DOWN, OBJ_STUDENT_CAP_BOY, ANIM_WALK, $03, END11_TRAINING_COURT_ALT_STUDENT_CAP_BOY
	map_actor $0000, ActorScript_27_05, 11.0, 23.0, FACE_UP, OBJ_STUDENT_PONYTAIL_GIRL, ANIM_WALK, $07, END11_TRAINING_COURT_ALT_STUDENT_PONYTAIL_GIRL
	map_actor $0000, ActorScript_27_05, 14.0, 23.0, FACE_UP, OBJ_STUDENT_WAVY_HAIR_GIRL, ANIM_WALK, $05, END11_TRAINING_COURT_ALT_STUDENT_WAVY_HAIR_GIRL
	map_actor $0000, ActorScript_27_27, 19.0, 11.0, FACE_LEFT, OBJ_BOB, ANIM_WALK, $00, END11_TRAINING_COURT_ALT_BOB
	map_actor $0000, ActorScript_27_27, 19.0, 21.0, FACE_LEFT, OBJ_CURT, ANIM_WALK, $06, END11_TRAINING_COURT_ALT_CURT
	map_actor_end
