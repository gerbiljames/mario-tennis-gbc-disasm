End7TrainingCtrMapScripts_27:
	; $617f, 14 bytes (map_tree)
	dw End7TrainingCtrEntryPoints_27 ; slot 0 EntryPoints
	dw End7TrainingCtrExitTriggers_27 ; slot 1 ExitTriggers
	dw End7TrainingCtrActors_27 ; slot 2 Actors
	dw End7TrainingCtrNpcScripts_27 ; slot 3 NpcScripts
	dw End7TrainingCtrFacingScripts_27 ; slot 4 FacingScripts
	dw End7TrainingCtrTileTriggers_27 ; slot 5 TileTriggers
	dw End7TrainingCtrInitScript_27 ; slot 6 InitScript
End7TrainingCtrActors_27:
	; $618d, 80 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, 43.0, 51.0, FACE_RIGHT, OBJ_WALK_72_06, ANIM_WALK, $00, END7_TRAINING_CTR_WALK_72_06_1
	map_actor $0000, ActorScript_27_27, 43.0, 49.0, FACE_RIGHT, OBJ_WALK_72_06, ANIM_WALK, $00, END7_TRAINING_CTR_WALK_72_06_2
	map_actor $0000, ActorScript_27_27, 45.0, 43.0, FACE_LEFT, OBJ_WALK_72_07, ANIM_WALK, $00, END7_TRAINING_CTR_WALK_72_07
	map_actor $0000, ActorScript_27_27, 25.0, 17.0, FACE_UP, OBJ_WALK_72_02, ANIM_WALK, $06, END7_TRAINING_CTR_WALK_72_02_1
	map_actor $0000, ActorScript_27_27, 13.0, 19.0, FACE_RIGHT, OBJ_WALK_72_02, ANIM_WALK, $07, END7_TRAINING_CTR_WALK_72_02_2
	map_actor_end
End7TrainingCtrEntryPoints_27:
	; $61dd, 17 bytes (map_entries)
	map_entry $01, FACE_UP, 43.0, 57.0, $0000
	map_entry $02, FACE_UP, 22.0, 24.0, $0000
	db $ff
End7TrainingCtrExitTriggers_27:
	; $61ee, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_TRAINING_CENTER, $03
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_TRAINING_CENTER, $03
	db $ff
End7TrainingCtrNpcScripts_27:
	ds 1, $ff ; $61ff, fill
End7TrainingCtrFacingScripts_27:
	ds 1, $ff ; $6200, fill
End7TrainingCtrTileTriggers_27:
	ds 1, $ff ; $6201, fill
End7TrainingCtrInitScript_27:
	ld a, [wStoryModeEntryPoint] ; $6202
	cp $01 ; $6205
	jr z, End7TrainingCtrEntry01Scene ; $6207
	cp $02 ; $6209
	jp z, End7TrainingCtrEntry02Scene ; $620b
	ret ; $620e
ComputeMachineCourtProgress_27:
	ld a, $00 ; $620f
	test_flag FLAG_CLEARED_MACHINE_LEVEL_1 ; $6211
	jp z, .store ; $6214
	script_copy_scene_rect 30, 44, 48, 44, 2, 2 ; $6217
	ld a, $01 ; $6226
	test_flag FLAG_CLEARED_MACHINE_LEVEL_2 ; $6228
	jp z, .store ; $622b
	script_copy_scene_rect 30, 48, 48, 48, 2, 2 ; $622e
	ld a, $02 ; $623d
	test_flag FLAG_CLEARED_MACHINE_LEVEL_3 ; $623f
	jr z, .store ; $6242
	script_copy_scene_rect 30, 52, 48, 52, 2, 2 ; $6244
	ld a, $03 ; $6253
	test_flag FLAG_CLEARED_MACHINE_LEVEL_4 ; $6255
	jr z, .store ; $6258
	script_copy_scene_rect 30, 56, 48, 56, 2, 2 ; $625a
	ld a, $04 ; $6269
	ld b, a ; $626b
.store:
	ld [wMapSceneStage], a ; $626c
	ret ; $626f
End7TrainingCtrEntry01Scene:
	ld a, $26 ; $6270
	ld [wMapScrollMinX], a ; $6272
	ld a, $23 ; $6275
	ld [wMapScrollMinY], a ; $6277
	ld a, $40 ; $627a
	ld [wMapWidthTiles], a ; $627c
	ld a, $3c ; $627f
	ld [wMapHeightTiles], a ; $6281
	call DisableLCDSafely ; $6284
	ld a, $00 ; $6287
	farcall CopyScrolledSceneTilemapToVram ; $6289
	call EnableLCD ; $628c
	call ComputeMachineCourtProgress_27 ; $628f
	farcall WaitPlayerMoveDone ; $6292
	script_set_position ACTOR_PLAYER, 41.0, 55.0 ; $6295
	script_set_position ACTOR_PARTNER, 41.0, 55.0 ; $62a0
	script_fade_in 4 ; $62ab
	script_move_player 41.0, 43.0 ; $62b0
	script_move_target ACTOR_PLAYER, 41.0, 43.0 ; $62ba
	script_wait_move ACTOR_PLAYER ; $62c5
	script_move_target ACTOR_PLAYER, 43.0, 43.0 ; $62ca
	script_wait_move ACTOR_PLAYER ; $62d5
	script_face ACTOR_PARTNER, FACE_RIGHT ; $62da
	script_face ACTOR_PLAYER, FACE_RIGHT ; $62e1
	script_wait_frames 30 ; $62e8
	script_set_anim ACTOR_END7_TRAINING_CTR_WALK_72_07, ANIM_NOD ; $62ef
	script_wait_idle ACTOR_END7_TRAINING_CTR_WALK_72_07 ; $62f6
	script_move_target ACTOR_END7_TRAINING_CTR_WALK_72_07, 45.0, 41.0 ; $62fb
	script_wait_move ACTOR_END7_TRAINING_CTR_WALK_72_07 ; $6306
	script_face ACTOR_END7_TRAINING_CTR_WALK_72_07, FACE_DOWN ; $630b
	script_null_script ACTOR_PARTNER ; $6312
	script_set_speed ACTOR_PLAYER, 1.0 ; $6317
	script_move_player 56.0, 51.0 ; $631f
	script_move_target ACTOR_PLAYER, 51.0, 43.0 ; $6329
	script_wait_move ACTOR_PLAYER ; $6334
	script_move_target ACTOR_PLAYER, 51.0, 51.0 ; $6339
	script_wait_move ACTOR_PLAYER ; $6344
	script_move_target ACTOR_PLAYER, 56.0, 53.0 ; $6349
	script_wait_move ACTOR_PLAYER ; $6354
	script_face ACTOR_PLAYER, FACE_UP ; $6359
	script_wait_frames 10 ; $6360
	ld a, $01 ; $6367
	ld [wUnusedExitTriggerIdMirror], a ; $6369
	ld [wStoryModeExitTriggerRequest], a ; $636c
	ret ; $636f
End7TrainingCtrEntry02Scene:
	script_set_position ACTOR_PARTNER, 22.0, 26.0 ; $6370
	script_set_speed ACTOR_PARTNER, 0.5 ; $637b
	script_set_speed ACTOR_PLAYER, 0.5 ; $6383
	script_player_speed 0.75 ; $638b
	script_fade_in 4 ; $6391
	script_move_angle ACTOR_PLAYER, FACE_UP, 4.0 ; $6396
	script_wait_move ACTOR_PLAYER ; $63a0
	script_move_player 15.0, 19.0 ; $63a5
	script_move_target ACTOR_PLAYER, 17.0, 19.0 ; $63af
	script_wait_move ACTOR_PLAYER ; $63ba
	script_face_toward ACTOR_PLAYER, ACTOR_END7_TRAINING_CTR_WALK_72_02_2 ; $63bf
	script_wait_frames 20 ; $63c7
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $63ce
	script_wait_idle ACTOR_PLAYER ; $63d5
	script_set_anim ACTOR_END7_TRAINING_CTR_WALK_72_02_2, ANIM_NOD ; $63da
	script_wait_idle ACTOR_END7_TRAINING_CTR_WALK_72_02_2 ; $63e1
	script_face ACTOR_PLAYER, FACE_DOWN ; $63e6
	script_set_actor_script ACTOR_PLAYER, ActorScript_27_13 ; $63ed
	script_wait_frames 120 ; $63f8
	script_null_script ACTOR_PLAYER ; $63ff
	script_set_anim ACTOR_PLAYER, ANIM_WALK ; $6404
	script_set_speed ACTOR_PLAYER, 1.0 ; $640b
	script_face_toward ACTOR_END7_TRAINING_CTR_WALK_72_02_2, ACTOR_PLAYER ; $6413
	ld a, $01 ; $641b
	ld [wUnusedExitTriggerIdMirror], a ; $641d
	ld [wStoryModeExitTriggerRequest], a ; $6420
	ret ; $6423
ActorScript_27_13:
	; $6424, 35 bytes (actor_script)
	as_anim ANIM_SIDESTEP
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_wait 50
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_WALK
	as_wait 1
	as_anim ANIM_SIDESTEP
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_wait 50
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_WALK
	as_wait 1
	as_jump ActorScript_27_13
End5ServiceAceMapScripts_27:
	; $6447, 14 bytes (map_tree)
	dw End5ServiceAceEntryPoints_27 ; slot 0 EntryPoints
	dw End5ServiceAceExitTriggers_27 ; slot 1 ExitTriggers
	dw End5ServiceAceActors_27 ; slot 2 Actors
	dw End5ServiceAceNpcScripts_27 ; slot 3 NpcScripts
	dw End5ServiceAceFacingScripts_27 ; slot 4 FacingScripts
	dw End5ServiceAceTileTriggers_27 ; slot 5 TileTriggers
	dw End5ServiceAceInitScript_27 ; slot 6 InitScript
End5ServiceAceActors_27:
	; $6455, 248 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, 17.0, 25.0, FACE_LEFT, OBJ_WALK_71_02, ANIM_WALK, $00, END5_SERVICE_ACE_WALK_71_02_1
	map_actor $0000, ActorScript_27_27, 33.0, 21.0, FACE_UP, OBJ_WALK_71_02, ANIM_WALK, $07, END5_SERVICE_ACE_WALK_71_02_2
	map_actor $0000, ActorScript_27_27, 22.0, 19.0, FACE_DOWN, OBJ_WALK_71_03, ANIM_WALK, $00, END5_SERVICE_ACE_WALK_71_03_1
	map_actor $0000, ActorScript_27_27, 29.0, 23.0, FACE_UP, OBJ_WALK_71_04, ANIM_WALK, $00, END5_SERVICE_ACE_WALK_71_04
	map_actor $0000, ActorScript_27_27, 41.0, 41.0, FACE_RIGHT, OBJ_BALLOON_EXCLAIM, ANIM_WALK, $00, END5_SERVICE_ACE_BALLOON_EXCLAIM
	map_actor $0000, ActorScript_27_27, 33.0, 17.0, FACE_RIGHT, OBJ_WALK_71_06, ANIM_WALK, $00, END5_SERVICE_ACE_WALK_71_06_1
	map_actor $0000, ActorScript_27_27, 9.0, 15.0, FACE_RIGHT, OBJ_WALK_71_07, ANIM_WALK, $00, END5_SERVICE_ACE_WALK_71_07
	map_actor $0000, ActorScript_27_28, 11.0, 25.0, FACE_LEFT, OBJ_WALK_71_03, ANIM_WALK, $06, END5_SERVICE_ACE_WALK_71_03_2
	map_actor $0000, ActorScript_27_27, 13.0, 15.0, FACE_LEFT, OBJ_WALK_72_03, ANIM_WALK, $00, END5_SERVICE_ACE_WALK_72_03_1
	map_actor $0000, ActorScript_27_27, 21.0, 11.0, FACE_LEFT, OBJ_WALK_71_06, ANIM_WALK, $00, END5_SERVICE_ACE_WALK_71_06_2
	map_actor $0000, ActorScript_27_27, 29.0, 11.0, FACE_LEFT, OBJ_WALK_72_05, ANIM_WALK, $04, END5_SERVICE_ACE_WALK_72_05_1
	map_actor $0000, ActorScript_27_27, 27.0, 9.0, FACE_DOWN, OBJ_WALK_72_04, ANIM_WALK, $00, END5_SERVICE_ACE_WALK_72_04_1
	map_actor $0000, ActorScript_27_27, 29.0, 15.0, FACE_LEFT, OBJ_WALK_72_05, ANIM_WALK, $00, END5_SERVICE_ACE_WALK_72_05_2
	map_actor $0000, ActorScript_27_27, 25.0, 15.0, FACE_RIGHT, OBJ_WALK_72_04, ANIM_WALK, $06, END5_SERVICE_ACE_WALK_72_04_2
	map_actor $0000, ActorScript_27_27, 41.0, 41.0, FACE_RIGHT, OBJ_BALLOON_ELLIPSIS, ANIM_WALK, $00, END5_SERVICE_ACE_BALLOON_ELLIPSIS
	map_actor $0000, ActorScript_27_27, 27.0, 18.0, FACE_DOWN, OBJ_WALK_72_03, ANIM_WALK, $00, END5_SERVICE_ACE_WALK_72_03_2
	map_actor $0000, ActorScript_27_27, 25.0, 9.0, FACE_DOWN, OBJ_RACKET, ANIM_WALK, $00, END5_SERVICE_ACE_RACKET
	map_actor_end
End5ServiceAceEntryPoints_27:
	; $654d, 17 bytes (map_entries)
	map_entry $01, FACE_RIGHT, 13.0, 29.0, $0000
	map_entry $02, FACE_DOWN, 5.0, 23.0, $0000 ; debug warp only
	db $ff
End5ServiceAceExitTriggers_27:
	; $655e, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_END5_SERVICE_ACE, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_CAFETERIA, $01
	db $ff
End5ServiceAceCutscene_27:
	farcall BeginCutsceneScriptMode ; $656f
	script_player_speed 0.5 ; $6572
	script_move_player 15.0, 17.0 ; $6578
	script_fade_in 8 ; $6582
	script_set_speed ACTOR_PLAYER, 0.75 ; $6587
	script_move_target ACTOR_PLAYER, 13.0, 23.0 ; $658f
	script_wait_move ACTOR_PLAYER ; $659a
	script_move_target ACTOR_PLAYER, 15.0, 23.0 ; $659f
	script_wait_move ACTOR_PLAYER ; $65aa
	script_move_target ACTOR_PLAYER, 15.0, 17.0 ; $65af
	script_wait_move ACTOR_PLAYER ; $65ba
	script_player_speed 0.75 ; $65bf
	script_move_player 25.0, 17.0 ; $65c5
	script_move_target ACTOR_PLAYER, 25.0, 17.0 ; $65cf
	script_wait_move ACTOR_PLAYER ; $65da
	script_wait_frames 20 ; $65df
	script_face ACTOR_END5_SERVICE_ACE_WALK_72_03_2, FACE_LEFT ; $65e6
	script_wait_frames 40 ; $65ed
	sound SFX_CHIME ; $65f4
	script_set_position ACTOR_END5_SERVICE_ACE_BALLOON_EXCLAIM, 28.0, 17.0 ; $65f6
	script_set_anim ACTOR_END5_SERVICE_ACE_WALK_72_03_2, ANIM_BOUNCE ; $6601
	script_wait_frames 60 ; $6608
	ld a, $01 ; $660f
	ld [wUnusedExitTriggerIdMirror], a ; $6611
	ld [wStoryModeExitTriggerRequest], a ; $6614
	farcall EndCutsceneScriptMode ; $6617
	ret ; $661a
End5ServiceAceNpcScripts_27:
	ds 1, $ff ; $661b, fill
End5ServiceAceFacingScripts_27:
	ds 1, $ff ; $661c, fill
End5ServiceAceTileTriggers_27:
	ds 1, $ff ; $661d, fill
End5ServiceAceInitScript_27:
	call End5ServiceAceCutscene_27 ; $661e
	ret ; $6621
End4JrCourtMapScripts_27:
	; $6622, 14 bytes (map_tree)
	dw End4JrCourtEntryPoints_27 ; slot 0 EntryPoints
	dw End4JrCourtExitTriggers_27 ; slot 1 ExitTriggers
	dw End4JrCourtActors_27 ; slot 2 Actors
	dw End4JrCourtNpcScripts_27 ; slot 3 NpcScripts
	dw End4JrCourtFacingScripts_27 ; slot 4 FacingScripts
	dw End4JrCourtTileTriggers_27 ; slot 5 TileTriggers
	dw End4JrCourtInitScript_27 ; slot 6 InitScript
End4JrCourtActors_27:
	; $6630, 234 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, 19.0, 19.0, FACE_DOWN, OBJ_WALK_72_00, ANIM_WALK, $00, END4_JR_COURT_WALK_72_00
	map_actor $0000, ActorScript_27_27, 35.0, 23.0, FACE_LEFT, OBJ_BOB, ANIM_WALK, $05, END4_JR_COURT_BOB
	map_actor $0000, ActorScript_27_27, 5.0, 21.0, FACE_RIGHT, OBJ_BETH, ANIM_WALK, $04, END4_JR_COURT_BETH
	map_actor $0000, ActorScript_27_27, 19.0, 13.0, FACE_RIGHT, OBJ_CURT, ANIM_WALK, $07, END4_JR_COURT_CURT
	map_actor $0000, ActorScript_27_27, 31.0, 21.0, FACE_LEFT, OBJ_PAM, ANIM_WALK, $07, END4_JR_COURT_PAM
	map_actor $0000, ActorScript_27_27, 37.0, 9.0, FACE_RIGHT, OBJ_BRIAN, ANIM_WALK, $03, END4_JR_COURT_BRIAN
	map_actor $0000, ActorScript_27_27, 49.0, 21.0, FACE_RIGHT, OBJ_FAY, ANIM_WALK, $06, END4_JR_COURT_FAY
	map_actor $0000, ActorScript_27_27, 61.0, 25.0, FACE_LEFT, OBJ_ALLIE, ANIM_WALK, $04, END4_JR_COURT_ALLIE
	map_actor $0000, ActorScript_27_16, 49.0, 7.0, FACE_DOWN, OBJ_JOY, ANIM_WALK, $03, END4_JR_COURT_JOY
	map_actor $0000, ActorScript_27_32, 8.0, 11.0, FACE_DOWN, OBJ_RACKET_STUDENT, ANIM_WALK, $05, END4_JR_COURT_RACKET_STUDENT_1
	map_actor $0000, ActorScript_27_33, 12.0, 23.0, FACE_UP, OBJ_RACKET_STUDENT, ANIM_WALK, $00, END4_JR_COURT_RACKET_STUDENT_2
	map_actor $0000, ActorScript_27_30, 24.0, 11.0, FACE_DOWN, OBJ_RACKET_STUDENT, ANIM_WALK, $00, END4_JR_COURT_RACKET_STUDENT_3
	map_actor $0000, ActorScript_27_31, 28.0, 23.0, FACE_UP, OBJ_RACKET_STUDENT, ANIM_WALK, $05, END4_JR_COURT_RACKET_STUDENT_4
	map_actor $0000, ActorScript_27_32, 52.0, 11.0, FACE_DOWN, OBJ_RACKET_STUDENT, ANIM_WALK, $05, END4_JR_COURT_RACKET_STUDENT_5
	map_actor $0000, ActorScript_27_33, 56.0, 23.0, FACE_UP, OBJ_RACKET_STUDENT, ANIM_WALK, $00, END4_JR_COURT_RACKET_STUDENT_6
	map_actor $0000, ActorScript_27_27, 64.0, 64.0, FACE_UP, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, END4_JR_COURT_BALLOON_SWEAT
	map_actor_end
End4JrCourtActorsAlt_27:
	; $671a, 192 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, 19.0, 19.0, FACE_DOWN, OBJ_WALK_72_00, ANIM_WALK, $00, END4_JR_COURT_ALT_WALK_72_00
	map_actor $0000, ActorScript_27_27, 35.0, 23.0, FACE_LEFT, OBJ_BOB, ANIM_WALK, $05, END4_JR_COURT_ALT_BOB
	map_actor $0000, ActorScript_27_27, 5.0, 21.0, FACE_RIGHT, OBJ_BETH, ANIM_WALK, $04, END4_JR_COURT_ALT_BETH
	map_actor $0000, ActorScript_27_27, 33.0, 21.0, FACE_DOWN, OBJ_CURT, ANIM_WALK, $07, END4_JR_COURT_ALT_CURT
	map_actor $0000, ActorScript_27_27, 5.0, 19.0, FACE_RIGHT, OBJ_PAM, ANIM_WALK, $07, END4_JR_COURT_ALT_PAM
	map_actor $0000, ActorScript_27_27, 27.0, 19.0, FACE_DOWN, OBJ_BRIAN, ANIM_WALK, $03, END4_JR_COURT_ALT_BRIAN
	map_actor $0000, ActorScript_27_27, 27.0, 21.0, FACE_UP, OBJ_FAY, ANIM_WALK, $06, END4_JR_COURT_ALT_FAY
	map_actor $0000, ActorScript_27_27, 55.0, 7.0, FACE_LEFT, OBJ_ALLIE, ANIM_WALK, $04, END4_JR_COURT_ALT_ALLIE
	map_actor $0000, ActorScript_27_27, 53.0, 7.0, FACE_RIGHT, OBJ_JOY, ANIM_WALK, $03, END4_JR_COURT_ALT_JOY
	map_actor $0000, ActorScript_27_32, 8.0, 11.0, FACE_DOWN, OBJ_RACKET_STUDENT, ANIM_WALK, $05, END4_JR_COURT_ALT_RACKET_STUDENT_1
	map_actor $0000, ActorScript_27_33, 12.0, 23.0, FACE_UP, OBJ_RACKET_STUDENT, ANIM_WALK, $00, END4_JR_COURT_ALT_RACKET_STUDENT_2
	map_actor $0000, ActorScript_27_30, 42.0, 11.0, FACE_DOWN, OBJ_RACKET_STUDENT, ANIM_WALK, $00, END4_JR_COURT_ALT_RACKET_STUDENT_3
	map_actor $0000, ActorScript_27_31, 46.0, 23.0, FACE_UP, OBJ_RACKET_STUDENT, ANIM_WALK, $05, END4_JR_COURT_ALT_RACKET_STUDENT_4
	map_actor_end
End4JrCourtEntryPoints_27:
	; $67da, 10 bytes (map_entries)
	map_entry $01, FACE_UP, 19.0, 33.0, $0000
	db $ff, $c9
End4JrCourtExitTriggers_27:
	; $67e4, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_RESTAURANT_PLAZA, $05
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_JUNIOR_CLASS_COURT_SINGLES, $0f
	db $ff
End4JrCourtNpcScripts_27:
	ds 1, $ff ; $67f5, fill
End4JrCourtFacingScripts_27:
	ds 1, $ff ; $67f6, fill
End4JrCourtTileTriggers_27:
	ds 1, $ff ; $67f7, fill
End4JrCourtInitScript_27:
	test_flag FLAG_DOUBLES ; $67f8
	jr z, .checkStoryModeEntryPoint ; $67fb
	ldh a, [hRomBank] ; $67fd
	ld hl, End4JrCourtActorsAlt_27 ; $67ff
	farcall ScriptRespawnLocationActors ; $6802
	farcall BeginCutsceneScriptMode ; $6805
.checkStoryModeEntryPoint:
	ld a, [wStoryModeEntryPoint] ; $6808
	cp $01 ; $680b
	jp z, End4JrCourtSceneSingles_27.walkPlayer ; $680d
	ret ; $6810
ActorScript_27_14:
	; $6811, 15 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait 10
	as_set_target 31.0, 13.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_27_15:
	; $6820, 15 bytes (actor_script)
	as_anim ANIM_WALK
	as_wait 10
	as_set_target 31.0, 19.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_27_16:
	; $682f, 55 bytes (actor_script)
	as_flag $01, $05, $02
	as_set_field $06, $0008
.L8:
	as_set_target 45.0, 7.0
	as_wait_move2
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_wait 200
	as_wait 240
	as_set_target 51.0, 7.0
	as_wait_move2
	as_wait 60
	as_set_target 45.0, 7.0
	as_wait_move2
	as_wait 60
	as_set_target 51.0, 7.0
	as_wait_move2
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_wait 240
	as_wait 240
	as_jump .L8
End4JrCourtApproachSingles_27:
	script_wait_frames 15 ; $6866
	script_face_toward ACTOR_END4_JR_COURT_ALT_PAM, ACTOR_END4_JR_COURT_ALT_WALK_72_00 ; $686d
	script_wait_frames 10 ; $6875
	script_face_toward ACTOR_END4_JR_COURT_ALT_PAM, ACTOR_PLAYER ; $687c
	script_wait_frames 30 ; $6884
	script_player_speed 1.0 ; $688b
	script_move_player_to_actor ACTOR_END4_JR_COURT_ALT_PAM ; $6891
	farcall WaitPlayerMoveDone ; $6898
	script_face_toward ACTOR_END4_JR_COURT_ALT_WALK_72_00, ACTOR_END4_JR_COURT_ALT_PAM ; $689b
	script_set_anim ACTOR_END4_JR_COURT_ALT_PAM, ANIM_NOD ; $68a3
	script_wait_idle ACTOR_END4_JR_COURT_ALT_PAM ; $68aa
	script_face ACTOR_END4_JR_COURT_ALT_PAM, FACE_DOWN ; $68af
	script_wait_frames 10 ; $68b6
	script_set_actor_script ACTOR_END4_JR_COURT_ALT_PAM, ActorScript_27_17 ; $68bd
	script_wait_frames 20 ; $68c8
	script_move_player_to_actor ACTOR_PLAYER ; $68cf
	script_face ACTOR_END4_JR_COURT_ALT_WALK_72_00, FACE_DOWN ; $68d6
	script_move_player_to_actor ACTOR_PLAYER ; $68dd
	script_wait_actor_script ACTOR_END4_JR_COURT_ALT_PAM ; $68e4
	script_face_toward ACTOR_PLAYER, ACTOR_END4_JR_COURT_ALT_PAM ; $68e9
	script_set_anim ACTOR_END4_JR_COURT_ALT_PAM, ANIM_BOUNCE ; $68f1
	script_wait_idle ACTOR_END4_JR_COURT_ALT_PAM ; $68f8
	script_set_anim ACTOR_END4_JR_COURT_ALT_PAM, ANIM_NOD ; $68fd
	script_wait_idle ACTOR_END4_JR_COURT_ALT_PAM ; $6904
	script_wait_frames 15 ; $6909
	script_face ACTOR_END4_JR_COURT_ALT_PAM, FACE_UP ; $6910
	ret ; $6917
ActorScript_27_17:
	; $6918, 23 bytes (actor_script)
	as_set_target 31.0, 25.0
	as_wait_move
	as_set_target 21.0, 25.0
	as_wait_move
	as_set_target 21.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_27_18:
	; $692f, 17 bytes (actor_script)
	as_set_target 21.0, 9.0
	as_wait_move
	as_set_target 25.0, 9.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_27_19:
	; $6940, 17 bytes (actor_script)
	as_set_target 19.0, 25.0
	as_wait_move
	as_set_target 27.0, 25.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
End4JrCourtSceneSingles_27:
	farcall BeginCutsceneScriptMode ; $6951
	script_face ACTOR_END4_JR_COURT_ALT_WALK_72_00, FACE_DOWN ; $6954
	call End4JrCourtApproachSingles_27 ; $695b
	script_face ACTOR_PLAYER, FACE_UP ; $695e
	script_wait_frames 15 ; $6965
	script_set_anim ACTOR_END4_JR_COURT_ALT_WALK_72_00, ANIM_BOUNCE ; $696c
	script_wait_idle ACTOR_END4_JR_COURT_ALT_WALK_72_00 ; $6973
	script_face ACTOR_END4_JR_COURT_ALT_WALK_72_00, FACE_RIGHT ; $6978
	script_wait_frames 15 ; $697f
	script_face ACTOR_PLAYER, FACE_RIGHT ; $6986
	script_face ACTOR_END4_JR_COURT_ALT_PAM, FACE_RIGHT ; $698d
	script_wait_frames 30 ; $6994
	script_set_actor_script ACTOR_END4_JR_COURT_ALT_RACKET_STUDENT_3, ActorScript_27_14 ; $699b
	script_set_actor_script ACTOR_END4_JR_COURT_ALT_RACKET_STUDENT_4, ActorScript_27_15 ; $69a6
	script_wait_actor_script ACTOR_END4_JR_COURT_ALT_RACKET_STUDENT_4 ; $69b1
	script_move_player 23.0, 17.0 ; $69b6
	script_set_actor_script ACTOR_END4_JR_COURT_ALT_PAM, ActorScript_27_18 ; $69c0
	script_set_actor_script ACTOR_PLAYER, ActorScript_27_19 ; $69cb
	farcall WaitPlayerMoveDone ; $69d6
	script_wait_actor_script ACTOR_END4_JR_COURT_ALT_PAM ; $69d9
	script_wait_frames 20 ; $69de
	ld a, $01 ; $69e5
	ld [wUnusedExitTriggerIdMirror], a ; $69e7
	ld [wStoryModeExitTriggerRequest], a ; $69ea
	ret ; $69ed
.loop:
	farcall BeginCutsceneScriptMode ; $69ee
	script_face_toward ACTOR_END4_JR_COURT_ALT_WALK_72_00, ACTOR_PLAYER ; $69f1
	script_wait_frames 30 ; $69f9
	script_face_toward ACTOR_PLAYER, ACTOR_END4_JR_COURT_ALT_WALK_72_00 ; $6a00
	call End4JrCourtApproachDoubles_27 ; $6a08
	script_face ACTOR_PLAYER, FACE_UP ; $6a0b
	script_wait_frames 15 ; $6a12
	script_set_anim ACTOR_END4_JR_COURT_ALT_WALK_72_00, ANIM_BOUNCE ; $6a19
	script_wait_idle ACTOR_END4_JR_COURT_ALT_WALK_72_00 ; $6a20
	script_face ACTOR_END4_JR_COURT_ALT_WALK_72_00, FACE_RIGHT ; $6a25
	script_wait_frames 15 ; $6a2c
	script_face ACTOR_PLAYER, FACE_RIGHT ; $6a33
	script_face ACTOR_END4_JR_COURT_ALT_PAM, FACE_RIGHT ; $6a3a
	script_wait_frames 30 ; $6a41
	call End4JrCourtDepartureDoubles_27 ; $6a48
	ld a, $01 ; $6a4b
	ld [wUnusedExitTriggerIdMirror], a ; $6a4d
	ld [wStoryModeExitTriggerRequest], a ; $6a50
	ret ; $6a53
.walkPlayer:
	script_move_player 19.0, 21.0 ; $6a54
	script_fade_in 4 ; $6a5e
	script_move_target ACTOR_PLAYER, 19.0, 21.0 ; $6a63
	script_wait_move ACTOR_PLAYER ; $6a6e
	test_flag FLAG_DOUBLES ; $6a73
	jp nz, .loop ; $6a76
	call End4JrCourtSceneSingles_27 ; $6a79
	ret ; $6a7c
End4JrCourtApproachDoubles_27:
	script_player_speed 1.0 ; $6a7d
	script_face ACTOR_END4_JR_COURT_ALT_WALK_72_00, FACE_RIGHT ; $6a83
	script_move_player_to_actor ACTOR_END4_JR_COURT_ALT_BRIAN ; $6a8a
	farcall WaitPlayerMoveDone ; $6a91
	script_face ACTOR_PLAYER, FACE_RIGHT ; $6a94
	script_face ACTOR_PARTNER, FACE_RIGHT ; $6a9b
	script_null_script ACTOR_END4_JR_COURT_ALT_BRIAN ; $6aa2
	script_face ACTOR_END4_JR_COURT_ALT_BRIAN, FACE_LEFT ; $6aa7
	script_set_anim ACTOR_END4_JR_COURT_ALT_BRIAN, ANIM_BOUNCE ; $6aae
	script_wait_idle ACTOR_END4_JR_COURT_ALT_BRIAN ; $6ab5
	script_move_player_to_actor ACTOR_PLAYER ; $6aba
	script_move_target ACTOR_END4_JR_COURT_ALT_BRIAN, 21.0, 21.0 ; $6ac1
	script_move_target ACTOR_END4_JR_COURT_ALT_FAY, 21.0, 23.0 ; $6acc
	script_wait_move ACTOR_END4_JR_COURT_ALT_FAY ; $6ad7
	script_face ACTOR_END4_JR_COURT_ALT_FAY, FACE_LEFT ; $6adc
	script_face ACTOR_END4_JR_COURT_ALT_WALK_72_00, FACE_DOWN ; $6ae3
	script_set_anim ACTOR_END4_JR_COURT_ALT_BRIAN, ANIM_BOUNCE ; $6aea
	script_wait_idle ACTOR_END4_JR_COURT_ALT_BRIAN ; $6af1
	script_set_anim ACTOR_END4_JR_COURT_ALT_FAY, ANIM_NOD ; $6af6
	script_wait_frames 15 ; $6afd
	script_face ACTOR_PLAYER, FACE_UP ; $6b04
	script_face ACTOR_PARTNER, FACE_UP ; $6b0b
	script_face ACTOR_END4_JR_COURT_ALT_BRIAN, FACE_UP ; $6b12
	script_face ACTOR_END4_JR_COURT_ALT_FAY, FACE_UP ; $6b19
	ret ; $6b20
End4JrCourtDepartureDoubles_27:
	script_face ACTOR_END4_JR_COURT_ALT_WALK_72_00, FACE_RIGHT ; $6b21
	script_wait_frames 30 ; $6b28
	script_null_script ACTOR_PARTNER ; $6b2f
	script_move_player 25.0, 17.0 ; $6b34
	script_set_actor_script ACTOR_END4_JR_COURT_ALT_BRIAN, ActorScript_27_24 ; $6b3e
	script_set_actor_script ACTOR_END4_JR_COURT_ALT_FAY, ActorScript_27_25 ; $6b49
	script_move_target ACTOR_PLAYER, 27.0, 25.0 ; $6b54
	script_wait_frames 10 ; $6b5f
	script_move_target ACTOR_PARTNER, 25.0, 21.0 ; $6b66
	script_wait_move ACTOR_PLAYER ; $6b71
	script_face ACTOR_PLAYER, FACE_UP ; $6b76
	script_face ACTOR_PARTNER, FACE_UP ; $6b7d
	script_wait_frames 60 ; $6b84
	ld a, $0f ; $6b8b
	ld [wUnusedExitTriggerIdMirror], a ; $6b8d
	ld [wStoryModeExitTriggerRequest], a ; $6b90
	ret ; $6b93
