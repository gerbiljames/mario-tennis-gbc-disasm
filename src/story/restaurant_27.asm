ActorScript_27_20:
	; $6b94, 20 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $1b00, $1300
	as_wait_move
	as_set_target $1b00, $1300
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_27_21:
	; $6ba8, 26 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $2700, $0d00
	as_wait_move
	as_set_target $2700, $0900
	as_wait_move
	as_set_target $2500, $0900
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_27_22:
	; $6bc2, 20 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $1b00, $1500
	as_wait_move
	as_set_target $1b00, $1500
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_27_23:
	; $6bd6, 26 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $2700, $0d00
	as_wait_move
	as_set_target $2700, $0b00
	as_wait_move
	as_set_target $2500, $0b00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_27_24:
	; $6bf0, 20 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $1500, $0900
	as_wait_move
	as_set_target $1700, $0900
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_27_25:
	; $6c04, 20 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $1500, $0e00
	as_wait_move
	as_set_target $1b00, $0e00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
End3DormEntMapScripts_27:
	; $6c18, 14 bytes (map_tree)
	dw End3DormEntEntryPoints_27 ; slot 0 EntryPoints
	dw End3DormEntExitTriggers_27 ; slot 1 ExitTriggers
	dw End3DormEntActors_27 ; slot 2 Actors
	dw End3DormEntNpcScripts_27 ; slot 3 NpcScripts
	dw End3DormEntFacingScripts_27 ; slot 4 FacingScripts
	dw End3DormEntTileTriggers_27 ; slot 5 TileTriggers
	dw End3DormEntInitScript_27 ; slot 6 InitScript
End3DormEntActors_27:
	; $6c26, 66 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, $0100, $0100, FACE_DOWN, $49, $01, $00
	map_actor $0000, ActorScript_27_27, $0100, $0100, FACE_DOWN, $29, $01, $00
	map_actor $0000, ActorScript_27_27, $0100, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_27_27, $0100, $0100, FACE_DOWN, $4d, $01, $00
	map_actor_end
End3DormEntEntryPoints_27:
	; $6c68, 25 bytes (map_entries)
	map_entry $01, FACE_UP, $1600, $1b00, $0000
	map_entry $02, FACE_DOWN, $1600, $0d00, $0000
	map_entry $0f, FACE_UP, $1600, $1b00, $0000
	db $ff
End3DormEntExitTriggers_27:
	ds 1, $ff ; $6c81, fill
End3DormEntNpcScripts_27:
	ds 1, $ff ; $6c82, fill
End3DormEntFacingScripts_27:
	ds 1, $ff ; $6c83, fill
End3DormEntTileTriggers_27:
	ds 1, $ff ; $6c84, fill
End3DormEntInitScript_27:
	farcall BeginCutsceneScriptMode ; $6c85
	ld a, [wStoryModeEntryPoint] ; $6c88
	cp $01 ; $6c8b
	call z, End3DormEntCutscene_27 ; $6c8d
	farcall EndCutsceneScriptMode ; $6c90
	ret ; $6c93
End3DormEntCutscene_27:
	test_flag FLAG_DOUBLES ; $6c94
	jr z, .notDoubles ; $6c97
	script_set_actor_script ACTOR_PARTNER, ActorScript_27_27 ; $6c99
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $6ca4
.notDoubles:
	script_set_speed $03, $0010 ; $6caf
	script_set_speed $04, $0010 ; $6cb7
	script_set_speed ACTOR_PLAYER, $0010 ; $6cbf
	script_player_speed $0010 ; $6cc7
	script_set_position ACTOR_PLAYER, $1600, $1f00 ; $6ccd
	script_set_position $03, $1600, $1d00 ; $6cd8
	script_face $03, FACE_UP ; $6ce3
	script_fade_in $20 ; $6cea
	script_move_target $03, $1600, $1100 ; $6cef
	script_move_player $1600, $0f00 ; $6cfa
	script_move_target ACTOR_PLAYER, $1600, $1400 ; $6d04
	script_wait_move ACTOR_PLAYER ; $6d0f
	script_move_target $03, $1600, $1100 ; $6d14
	script_move_target ACTOR_PLAYER, $1600, $1300 ; $6d1f
	script_wait_move ACTOR_PLAYER ; $6d2a
	script_wait_frames $14 ; $6d2f
	script_wait_move $03 ; $6d36
	script_face_toward ACTOR_PLAYER, $03 ; $6d3b
	script_set_anim $03, $03 ; $6d43
	script_wait_idle $03 ; $6d4a
	script_set_anim ACTOR_PLAYER, $02 ; $6d4f
	script_player_speed $0018 ; $6d56
	script_move_player $1600, $0b00 ; $6d5c
	farcall WaitPlayerMoveDone ; $6d66
	script_wait_frames $14 ; $6d69
	script_move_player $1100, $0b00 ; $6d70
	farcall WaitPlayerMoveDone ; $6d7a
	script_wait_frames $0a ; $6d7d
	script_move_player $1a00, $0b00 ; $6d84
	farcall WaitPlayerMoveDone ; $6d8e
	script_wait_frames $0a ; $6d91
	script_move_player $1600, $0b00 ; $6d98
	farcall WaitPlayerMoveDone ; $6da2
	script_wait_frames $1e ; $6da5
	script_move_player $1600, $1000 ; $6dac
	script_set_anim ACTOR_PLAYER, $02 ; $6db6
	script_wait_idle ACTOR_PLAYER ; $6dbd
	script_wait_frames $14 ; $6dc2
	script_player_speed $0010 ; $6dc9
	sound SFX_CHIME ; $6dcf
	script_set_position $05, $1780, $0f00 ; $6dd1
	script_set_anim $03, $02 ; $6ddc
	script_wait_idle $03 ; $6de3
	script_set_position $05, $0100, $0100 ; $6de8
	script_move_target $03, $1600, $0b00 ; $6df3
	script_wait_move $03 ; $6dfe
	script_set_position $04, $1700, $0b00 ; $6e03
	script_wait_frames $3c ; $6e0e
	script_face ACTOR_PLAYER, FACE_DOWN ; $6e15
	script_wait_frames $14 ; $6e1c
	script_set_anim ACTOR_PLAYER, $04 ; $6e23
	script_wait_idle ACTOR_PLAYER ; $6e2a
	script_wait_frames $14 ; $6e2f
	script_face ACTOR_PLAYER, FACE_UP ; $6e36
	script_set_active $03, $02 ; $6e3d
	script_set_position $03, $1500, $0b00 ; $6e44
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $6e4f
	or a ; $6e52
	jr nz, .walk ; $6e53
	script_set_objdef $28, $04 ; $6e55
	script_set_anim $04, $01 ; $6e61
.walk:
	script_move_target $03, $1500, $0f00 ; $6e68
	script_wait_move $03 ; $6e73
	script_move_target $04, $1700, $0f00 ; $6e78
	script_wait_move $04 ; $6e83
	sound SFX_EMOTE ; $6e88
	script_set_position $06, $1780, $1100 ; $6e8a
	script_wait_frames $3c ; $6e95
	script_set_anim $03, $04 ; $6e9c
	script_wait_idle $03 ; $6ea3
	script_set_position $06, $0100, $0100 ; $6ea8
	script_face_toward $04, $03 ; $6eb3
	script_wait_frames $3c ; $6ebb
	script_face_toward ACTOR_PLAYER, $03 ; $6ec2
	script_set_anim $04, $03 ; $6eca
	script_wait_idle $04 ; $6ed1
	ld a, $0f ; $6ed6
	ld [wUnusedExitTriggerIdMirror], a ; $6ed8
	ld [wStoryModeExitTriggerRequest], a ; $6edb
	ret ; $6ede
EndRestaurantEntMapScripts_27:
	; $6edf, 14 bytes (map_tree)
	dw EndRestaurantEntEntryPoints_27 ; slot 0 EntryPoints
	dw EndRestaurantEntExitTriggers_27 ; slot 1 ExitTriggers
	dw EndRestaurantEntActors_27 ; slot 2 Actors
	dw EndRestaurantEntNpcScripts_27 ; slot 3 NpcScripts
	dw EndRestaurantEntFacingScripts_27 ; slot 4 FacingScripts
	dw EndRestaurantEntTileTriggers_27 ; slot 5 TileTriggers
	dw EndRestaurantEntInitScript_27 ; slot 6 InitScript
EndRestaurantEntActors_27:
	; $6eed, 10 bytes (map_actors)
	map_actor_end
EndRestaurantEntEntryPoints_27:
	; $6ef7, 9 bytes (map_entries)
	map_entry $01, FACE_DOWN, $0700, $0840, $0000
	db $ff
EndRestaurantEntExitTriggers_27:
	; $6f00, 73 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_DORM_ENTRANCE, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_RESTAURANT, $01
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_SENIOR_CLASS_COURT, $01
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_COURTYARD, $02
	map_script $05, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_JUNIOR_CLASS_COURT_SINGLES, $01
	map_script $06, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_TRAINING_COURT, $01
	map_script $0d, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_JUNIOR_CLASS_COURT_DOUBLES, $01
	map_script $0e, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_DORM_ENTRANCE, $0f
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_TRAINING_COURT, $0f
	db $ff
EndRestaurantEntNpcScripts_27:
	ds 1, $ff ; $6f49, fill
EndRestaurantEntFacingScripts_27:
	ds 1, $ff ; $6f4a, fill
EndRestaurantEntTileTriggers_27:
	ds 1, $ff ; $6f4b, fill
EndRestaurantEntInitScript_27:
	ld a, [wStoryModeEntryPoint] ; $6f4c
	cp $01 ; $6f4f
	jr nz, .done ; $6f51
	call EndRestaurantEntCutscene_27 ; $6f53
.done:
	ret ; $6f56
EndRestaurantEntCutscene_27:
	ldh a, [hRomBank] ; $6f57
	ld hl, EndRestaurantEntActorsAlt_27 ; $6f59
	farcall ScriptRespawnLocationActors ; $6f5c
	farcall BeginCutsceneScriptMode ; $6f5f
	test_flag FLAG_DOUBLES ; $6f62
	jr z, .placeActors ; $6f65
	script_set_actor_script ACTOR_PARTNER, ActorScript_27_27 ; $6f67
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $6f72
.placeActors:
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $6f7d
	script_set_position $06, $3f00, $3f00 ; $6f88
	script_set_position $07, $3f00, $3f00 ; $6f93
	script_set_position $08, $3f00, $3f00 ; $6f9e
	script_fade_in $04 ; $6fa9
	script_set_position $06, $4100, $0d00 ; $6fae
	script_move_target $06, $1b00, $0d00 ; $6fb9
	script_set_position ACTOR_PLAYER, $4300, $0d00 ; $6fc4
	script_move_target ACTOR_PLAYER, $1d00, $0d00 ; $6fcf
	script_wait_frames $0f ; $6fda
	script_move_player $1b00, $0d00 ; $6fe1
	script_wait_move ACTOR_PLAYER ; $6feb
	script_wait_frames $1e ; $6ff0
	script_face_toward ACTOR_PLAYER, $06 ; $6ff7
	script_set_anim ACTOR_PLAYER, $03 ; $6fff
	script_wait_idle ACTOR_PLAYER ; $7006
	script_face $06, FACE_UP ; $700b
	script_wait_frames $0f ; $7012
	script_face ACTOR_PLAYER, FACE_UP ; $7019
	script_set_anim ACTOR_PLAYER, $03 ; $7020
	script_wait_idle ACTOR_PLAYER ; $7027
	script_wait_frames $1e ; $702c
	call OpenRestaurantEntDoor_27 ; $7033
	script_wait_frames $0f ; $7036
	sound SFX_CHIME ; $703d
	script_set_position $03, $1c00, $0b00 ; $703f
	script_wait_frames $1e ; $704a
	script_set_position $03, $3f00, $3f00 ; $7051
	script_face $06, FACE_LEFT ; $705c
	script_wait_frames $0f ; $7063
	script_face ACTOR_PLAYER, FACE_LEFT ; $706a
	script_move_player $1800, $0d00 ; $7071
	script_wait_frames $0f ; $707b
	script_set_position $07, $1500, $0980 ; $7082
	script_wait_frames $0f ; $708d
	script_set_speed $07, $0010 ; $7094
	script_move_target $07, $1500, $0d00 ; $709c
	script_wait_move $07 ; $70a7
	script_face $07, FACE_RIGHT ; $70ac
	script_set_position $08, $1500, $0900 ; $70b3
	script_wait_frames $0f ; $70be
	script_set_speed $08, $0010 ; $70c5
	script_move_target $08, $1500, $0b00 ; $70cd
	script_wait_move $08 ; $70d8
	call CloseRestaurantEntDoor_27 ; $70dd
	script_face $08, FACE_RIGHT ; $70e0
	script_wait_frames $0f ; $70e7
	script_set_anim $06, $02 ; $70ee
	script_wait_idle $06 ; $70f5
	script_face $07, FACE_DOWN ; $70fa
	ld a, $0e ; $7101
	ld [wUnusedExitTriggerIdMirror], a ; $7103
	ld [wStoryModeExitTriggerRequest], a ; $7106
	farcall EndCutsceneScriptMode ; $7109
	ret ; $710c
EndRestaurantEntActorsAlt_27:
	; $710d, 94 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, $fd00, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_27_27, $fd00, $0100, FACE_DOWN, $4d, $01, $00
	map_actor $0000, ActorScript_27_27, $fd00, $0100, FACE_DOWN, $4f, $01, $00
	map_actor $0000, ActorScript_27_27, $4100, $0d00, FACE_LEFT, $49, $01, $00
	map_actor $0000, ActorScript_27_27, $1500, $0d00, FACE_DOWN, $4a, $01, $00
	map_actor $0000, ActorScript_27_27, $1300, $0d00, FACE_DOWN, $4b, $01, $00
	map_actor_end
OpenRestaurantEntDoor_27:
	sound SFX_DOOR ; $716b
	script_copy_scene_rect $14, $08, $06, $15, $02, $02 ; $716d
	script_copy_scene_rect $00, $15, $14, $08, $02, $02 ; $717c
	script_wait_frames $02 ; $718b
	script_copy_scene_rect $02, $15, $14, $08, $02, $02 ; $7192
	script_wait_frames $02 ; $71a1
	script_copy_scene_rect $04, $15, $14, $08, $02, $02 ; $71a8
	script_wait_frames $02 ; $71b7
	ret ; $71be
CloseRestaurantEntDoor_27:
	sound SFX_DOOR ; $71bf
	script_copy_scene_rect $04, $15, $14, $08, $02, $02 ; $71c1
	script_wait_frames $01 ; $71d0
	script_copy_scene_rect $02, $15, $14, $08, $02, $02 ; $71d7
	script_wait_frames $01 ; $71e6
	script_copy_scene_rect $00, $15, $14, $08, $02, $02 ; $71ed
	script_wait_frames $01 ; $71fc
	script_copy_scene_rect $06, $15, $14, $08, $02, $02 ; $7203
	ret ; $7212
End1MainBldgMapScripts_27:
	; $7213, 14 bytes (map_tree)
	dw End1MainBldgEntryPoints_27 ; slot 0 EntryPoints
	dw End1MainBldgExitTriggers_27 ; slot 1 ExitTriggers
	dw End1MainBldgActors_27 ; slot 2 Actors
	dw End1MainBldgNpcScripts_27 ; slot 3 NpcScripts
	dw End1MainBldgFacingScripts_27 ; slot 4 FacingScripts
	dw End1MainBldgTileTriggers_27 ; slot 5 TileTriggers
	dw End1MainBldgInitScript_27 ; slot 6 InitScript
End1MainBldgActors_27:
	; $7221, 150 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, $1500, $3d00, FACE_RIGHT, $4d, $01, $00
	map_actor $0000, ActorScript_27_27, $1500, $3d00, FACE_RIGHT, $4c, $01, $00
	map_actor $0000, ActorScript_27_27, $1500, $3d00, FACE_RIGHT, $53, $01, $00
	map_actor $0000, ActorScript_27_27, $1500, $3d00, FACE_DOWN, $63, $01, $00
	map_actor $0000, ActorScript_27_27, $1500, $3d00, FACE_RIGHT, $4f, $01, $00
	map_actor $0000, ActorScript_27_27, $1800, $1100, FACE_DOWN, $63, $01, $00
	map_actor $0000, ActorScript_27_27, $1a00, $1500, FACE_UP, $5c, $01, $00
	map_actor $0000, ActorScript_27_27, $1600, $1500, FACE_UP, $5b, $01, $00
	map_actor $0000, ActorScript_27_27, $1900, $1700, FACE_UP, $5a, $01, $00
	map_actor $0000, ActorScript_27_27, $0100, $1900, FACE_UP, $4a, $01, $00
	map_actor_end
End1MainBldgEntryPoints_27:
	; $72b7, 25 bytes (map_entries)
	map_entry $01, FACE_DOWN, $1800, $1100, $0000
	map_entry $02, FACE_UP, $1800, $1100, $0000
	map_entry $0f, FACE_UP, $1800, $2f00, $0000
	db $ff
End1MainBldgExitTriggers_27:
	; $72d0, 41 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_ACADEMY_MAIN_BLDG, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_ISLAND_SKY, $01
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_ISLAND_SKY, $0f
	map_script $05, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_END1_MAIN_BLDG, $02
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_ACADEMY_MAIN_BLDG, $0f
	db $ff
End1MainBldgNpcScripts_27:
	ds 1, $ff ; $72f9, fill
End1MainBldgFacingScripts_27:
	ds 1, $ff ; $72fa, fill
End1MainBldgTileTriggers_27:
	ds 1, $ff ; $72fb, fill
End1MainBldgInitScript_27:
	ld a, [wStoryModeEntryPoint] ; $72fc
	cp $01 ; $72ff
	jp z, .walkOff ; $7301
	cp $02 ; $7304
	jp z, End1MainBldgGroupDepartureCutscene_27 ; $7306
	ret ; $7309
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $730a
	xor a ; $7312
	ld [wStoryModeShowLocationName], a ; $7313
	script_set_position $06, $1800, $0d00 ; $7316
	script_set_position ACTOR_PLAYER, $1800, $3700 ; $7321
	script_set_position $0b, $3f00, $3f00 ; $732c
	script_set_position $0a, $3f00, $3f00 ; $7337
	script_set_position $09, $3f00, $3f00 ; $7342
	script_set_position $08, $3f00, $3f00 ; $734d
	script_set_position $0c, $3f00, $3f00 ; $7358
	test_flag FLAG_DOUBLES ; $7363
	jr z, .notDoubles ; $7366
	script_set_actor_script ACTOR_PARTNER, ActorScript_27_27 ; $7368
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $7373
.notDoubles:
	script_player_speed $0040 ; $737e
	script_move_player $1800, $1200 ; $7384
	farcall WaitPlayerMoveDone ; $738e
	script_fade_in $04 ; $7391
	call WaitFadeEnd ; $7396
	script_move_target ACTOR_PLAYER, $1800, $2100 ; $7399
	script_wait_frames $14 ; $73a4
	script_set_position ACTOR_PLAYER, $1800, $2000 ; $73ab
	script_face ACTOR_PLAYER, FACE_UP ; $73b6
	script_set_speed $06, $0024 ; $73bd
	script_move_target $06, $1800, $1400 ; $73c5
	script_wait_move $06 ; $73d0
	script_set_anim $06, $04 ; $73d5
	script_wait_idle $06 ; $73dc
	script_face $06, FACE_UP ; $73e1
	script_set_anim $06, $03 ; $73e8
	script_wait_idle $06 ; $73ef
	script_set_speed $06, $0020 ; $73f4
	script_face $06, FACE_DOWN ; $73fc
	script_jump_velocity $06, $ff80 ; $7403
	ld a, $06 ; $740b
	farcall ScriptWaitActorJumpDone ; $740d
	script_move_target $06, $1800, $1700 ; $7410
	script_wait_move $06 ; $741b
	sound SFX_EMOTE ; $7420
	script_set_position $03, $1980, $15c0 ; $7422
	script_set_speed $06, $0010 ; $742d
	script_set_speed $03, $0010 ; $7435
	script_move_target $03, $1980, $18c0 ; $743d
	script_move_target $06, $1800, $1a00 ; $7448
	script_wait_move $06 ; $7453
	script_set_position $03, $3f00, $3f00 ; $7458
	script_move_target $06, $1800, $1600 ; $7463
	script_wait_move $06 ; $746e
	script_wait_frames $1e ; $7473
	script_set_anim $06, $02 ; $747a
	sound SFX_CHIME ; $7481
	script_set_position $04, $1980, $14c0 ; $7483
	script_wait_frames $14 ; $748e
	script_set_position $04, $3f00, $3f00 ; $7495
	script_set_speed $06, $0020 ; $74a0
	script_jump_velocity $06, $ff80 ; $74a8
	ld a, $06 ; $74b0
	farcall ScriptWaitActorJumpDone ; $74b2
	script_move_target $06, $1800, $2000 ; $74b5
	script_wait_frames $1e ; $74c0
	ld bc, wActors + 1 * ACTOR_SIZE ; $74c7
	script_get_actor_state $06 ; $74ca
	ld e, l ; $74cf
	ld d, h ; $74d0
	farcall AttachActorWaypointFollower ; $74d1
	script_move_target ACTOR_PLAYER, $1800, $1e00 ; $74d4
	script_wait_frames $14 ; $74df
	call End1MainBldgKnockdown_27 ; $74e6
	script_wait_move $06 ; $74e9
	script_set_anim $06, $02 ; $74ee
	sound SFX_APPEAR2 ; $74f5
	script_set_position $05, $1900, $1e00 ; $74f7
	script_wait_frames $3c ; $7502
	script_set_position $05, $3f00, $3f00 ; $7509
	script_move_target $06, $1700, $2200 ; $7514
	script_wait_move $06 ; $751f
	script_face_toward ACTOR_PLAYER, $06 ; $7524
	script_wait_frames $14 ; $752c
	script_move_target $06, $1900, $2400 ; $7533
	script_wait_move $06 ; $753e
	script_null_script ACTOR_PLAYER_SHADOW ; $7543
	script_face_toward ACTOR_PLAYER, $06 ; $7548
	script_set_anim $06, $02 ; $7550
	script_wait_idle $06 ; $7557
	script_wait_frames $14 ; $755c
	script_set_position $07, $1a80, $2280 ; $7563
	script_wait_frames $3c ; $756e
	script_set_position $07, $3f00, $3f00 ; $7575
	script_set_anim $06, $02 ; $7580
	script_wait_idle $06 ; $7587
	ld a, $01 ; $758c
	ld [wUnusedExitTriggerIdMirror], a ; $758e
	ld [wStoryModeExitTriggerRequest], a ; $7591
	ret ; $7594
End1MainBldgKnockdown_27:
	sound SFX_IMPACT ; $7595
	script_null_script ACTOR_PLAYER_SHADOW ; $7597
	ld a, $03 ; $759c
	farcall SetScreenShake ; $759e
	script_wait_frames $0a ; $75a1
	ld a, $00 ; $75a8
	farcall SetScreenShake ; $75aa
	script_set_speed ACTOR_PLAYER, $0040 ; $75ad
	script_move_player $1800, $2400 ; $75b5
	script_move_target ACTOR_PLAYER, $1700, $2400 ; $75bf
	script_jump_velocity ACTOR_PLAYER, $ff00 ; $75ca
	script_get_actor_state ACTOR_PLAYER ; $75d2
	ld c, l ; $75d7
	ld b, h ; $75d8
	ld hl, $0037 ; $75d9
	add hl, bc ; $75dc
	ld a, [hl] ; $75dd
	or $40 ; $75de
	ld [hl], a ; $75e0
	script_wait_frames $1e ; $75e1
	script_set_anim ACTOR_PLAYER, $02 ; $75e8
	script_wait_idle ACTOR_PLAYER ; $75ef
	script_wait_frames $1e ; $75f4
	script_set_actor_script ACTOR_PLAYER, ActorScript_27_26 ; $75fb
	ret ; $7606
