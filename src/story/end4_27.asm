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
	map_actor $0000, ActorScript_27_27, $2b00, $3300, FACE_RIGHT, $3d, $01, $00
	map_actor $0000, ActorScript_27_27, $2b00, $3100, FACE_RIGHT, $3d, $01, $00
	map_actor $0000, ActorScript_27_27, $2d00, $2b00, FACE_LEFT, $3e, $01, $00
	map_actor $0000, ActorScript_27_27, $1900, $1100, FACE_UP, $39, $01, $06
	map_actor $0000, ActorScript_27_27, $0d00, $1300, FACE_RIGHT, $39, $01, $07
	map_actor_end
End7TrainingCtrEntryPoints_27:
	; $61dd, 17 bytes (map_entries)
	map_entry $01, FACE_UP, $2b00, $3900, $0000
	map_entry $02, FACE_UP, $1600, $1800, $0000
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
	jr z, ComputeMachineCourtProgress_27.eq01 ; $6207
	cp $02 ; $6209
	jp z, ComputeMachineCourtProgress_27.placeActors ; $620b
	ret ; $620e
ComputeMachineCourtProgress_27:
	ld a, $00 ; $620f
	test_flag FLAG_CLEARED_MACHINE_LEVEL_1 ; $6211
	jp z, .store ; $6214
	script_copy_scene_rect $1e, $2c, $30, $2c, $02, $02 ; $6217
	ld a, $01 ; $6226
	test_flag FLAG_CLEARED_MACHINE_LEVEL_2 ; $6228
	jp z, .store ; $622b
	script_copy_scene_rect $1e, $30, $30, $30, $02, $02 ; $622e
	ld a, $02 ; $623d
	test_flag FLAG_CLEARED_MACHINE_LEVEL_3 ; $623f
	jr z, .store ; $6242
	script_copy_scene_rect $1e, $34, $30, $34, $02, $02 ; $6244
	ld a, $03 ; $6253
	test_flag FLAG_CLEARED_MACHINE_LEVEL_4 ; $6255
	jr z, .store ; $6258
	script_copy_scene_rect $1e, $38, $30, $38, $02, $02 ; $625a
	ld a, $04 ; $6269
	ld b, a ; $626b
.store:
	ld [wMapSceneStage], a ; $626c
	ret ; $626f
.eq01:
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
	script_set_position ACTOR_PLAYER, $2900, $3700 ; $6295
	script_set_position ACTOR_PARTNER, $2900, $3700 ; $62a0
	script_fade_in $04 ; $62ab
	script_move_player $2900, $2b00 ; $62b0
	script_move_target ACTOR_PLAYER, $2900, $2b00 ; $62ba
	script_wait_move ACTOR_PLAYER ; $62c5
	script_move_target ACTOR_PLAYER, $2b00, $2b00 ; $62ca
	script_wait_move ACTOR_PLAYER ; $62d5
	script_face ACTOR_PARTNER, FACE_RIGHT ; $62da
	script_face ACTOR_PLAYER, FACE_RIGHT ; $62e1
	script_wait_frames $1e ; $62e8
	script_set_anim $05, $03 ; $62ef
	script_wait_idle $05 ; $62f6
	script_move_target $05, $2d00, $2900 ; $62fb
	script_wait_move $05 ; $6306
	script_face $05, FACE_DOWN ; $630b
	script_null_script ACTOR_PARTNER ; $6312
	script_set_speed ACTOR_PLAYER, $0020 ; $6317
	script_move_player $3800, $3300 ; $631f
	script_move_target ACTOR_PLAYER, $3300, $2b00 ; $6329
	script_wait_move ACTOR_PLAYER ; $6334
	script_move_target ACTOR_PLAYER, $3300, $3300 ; $6339
	script_wait_move ACTOR_PLAYER ; $6344
	script_move_target ACTOR_PLAYER, $3800, $3500 ; $6349
	script_wait_move ACTOR_PLAYER ; $6354
	script_face ACTOR_PLAYER, FACE_UP ; $6359
	script_wait_frames $0a ; $6360
	ld a, $01 ; $6367
	ld [wUnusedExitTriggerIdMirror], a ; $6369
	ld [wStoryModeExitTriggerRequest], a ; $636c
	ret ; $636f
.placeActors:
	script_set_position ACTOR_PARTNER, $1600, $1a00 ; $6370
	script_set_speed ACTOR_PARTNER, $0010 ; $637b
	script_set_speed ACTOR_PLAYER, $0010 ; $6383
	script_player_speed $0018 ; $638b
	script_fade_in $04 ; $6391
	script_move_angle ACTOR_PLAYER, FACE_UP, $0400 ; $6396
	script_wait_move ACTOR_PLAYER ; $63a0
	script_move_player $0f00, $1300 ; $63a5
	script_move_target ACTOR_PLAYER, $1100, $1300 ; $63af
	script_wait_move ACTOR_PLAYER ; $63ba
	script_face_toward ACTOR_PLAYER, $07 ; $63bf
	script_wait_frames $14 ; $63c7
	script_set_anim ACTOR_PLAYER, $02 ; $63ce
	script_wait_idle ACTOR_PLAYER ; $63d5
	script_set_anim $07, $03 ; $63da
	script_wait_idle $07 ; $63e1
	script_face ACTOR_PLAYER, FACE_DOWN ; $63e6
	script_set_actor_script ACTOR_PLAYER, ActorScript_27_13 ; $63ed
	script_wait_frames $78 ; $63f8
	script_null_script ACTOR_PLAYER ; $63ff
	script_set_anim ACTOR_PLAYER, $01 ; $6404
	script_set_speed ACTOR_PLAYER, $0020 ; $640b
	script_face_toward $07, ACTOR_PLAYER ; $6413
	ld a, $01 ; $641b
	ld [wUnusedExitTriggerIdMirror], a ; $641d
	ld [wStoryModeExitTriggerRequest], a ; $6420
	ret ; $6423
ActorScript_27_13:
	; $6424, 35 bytes (actor_script)
	as_anim $0b
	as_set_field $14, FACE_RIGHT
	as_wait $32
	as_set_field $14, FACE_DOWN
	as_anim $01
	as_wait $01
	as_anim $0b
	as_set_field $14, FACE_LEFT
	as_wait $32
	as_set_field $14, FACE_DOWN
	as_anim $01
	as_wait $01
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
	map_actor $0000, ActorScript_27_27, $1100, $1900, FACE_LEFT, $2f, $01, $00
	map_actor $0000, ActorScript_27_27, $2100, $1500, FACE_UP, $2f, $01, $07
	map_actor $0000, ActorScript_27_27, $1600, $1300, FACE_DOWN, $30, $01, $00
	map_actor $0000, ActorScript_27_27, $1d00, $1700, FACE_UP, $31, $01, $00
	map_actor $0000, ActorScript_27_27, $2900, $2900, FACE_RIGHT, $4c, $01, $00
	map_actor $0000, ActorScript_27_27, $2100, $1100, FACE_RIGHT, $33, $01, $00
	map_actor $0000, ActorScript_27_27, $0900, $0f00, FACE_RIGHT, $34, $01, $00
	map_actor $0000, ActorScript_27_28, $0b00, $1900, FACE_LEFT, $30, $01, $06
	map_actor $0000, ActorScript_27_27, $0d00, $0f00, FACE_LEFT, $3a, $01, $00
	map_actor $0000, ActorScript_27_27, $1500, $0b00, FACE_LEFT, $33, $01, $00
	map_actor $0000, ActorScript_27_27, $1d00, $0b00, FACE_LEFT, $3c, $01, $04
	map_actor $0000, ActorScript_27_27, $1b00, $0900, FACE_DOWN, $3b, $01, $00
	map_actor $0000, ActorScript_27_27, $1d00, $0f00, FACE_LEFT, $3c, $01, $00
	map_actor $0000, ActorScript_27_27, $1900, $0f00, FACE_RIGHT, $3b, $01, $06
	map_actor $0000, ActorScript_27_27, $2900, $2900, FACE_RIGHT, $4f, $01, $00
	map_actor $0000, ActorScript_27_27, $1b00, $1200, FACE_DOWN, $3a, $01, $00
	map_actor $0000, ActorScript_27_27, $1900, $0900, FACE_DOWN, $35, $01, $00
	map_actor_end
End5ServiceAceEntryPoints_27:
	; $654d, 17 bytes (map_entries)
	map_entry $01, FACE_RIGHT, $0d00, $1d00, $0000
	map_entry $02, FACE_DOWN, $0500, $1700, $0000
	db $ff
End5ServiceAceExitTriggers_27:
	; $655e, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_END5_SERVICE_ACE, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_27, STORYLOC_CAFETERIA, $01
	db $ff
End5ServiceAceCutscene_27:
	farcall BeginCutsceneScriptMode ; $656f
	script_player_speed $0010 ; $6572
	script_move_player $0f00, $1100 ; $6578
	script_fade_in $08 ; $6582
	script_set_speed ACTOR_PLAYER, $0018 ; $6587
	script_move_target ACTOR_PLAYER, $0d00, $1700 ; $658f
	script_wait_move ACTOR_PLAYER ; $659a
	script_move_target ACTOR_PLAYER, $0f00, $1700 ; $659f
	script_wait_move ACTOR_PLAYER ; $65aa
	script_move_target ACTOR_PLAYER, $0f00, $1100 ; $65af
	script_wait_move ACTOR_PLAYER ; $65ba
	script_player_speed $0018 ; $65bf
	script_move_player $1900, $1100 ; $65c5
	script_move_target ACTOR_PLAYER, $1900, $1100 ; $65cf
	script_wait_move ACTOR_PLAYER ; $65da
	script_wait_frames $14 ; $65df
	script_face $12, FACE_LEFT ; $65e6
	script_wait_frames $28 ; $65ed
	sound SFX_CHIME ; $65f4
	script_set_position $07, $1c00, $1100 ; $65f6
	script_set_anim $12, $02 ; $6601
	script_wait_frames $3c ; $6608
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
	map_actor $0000, ActorScript_27_27, $1300, $1300, FACE_DOWN, $37, $01, $00
	map_actor $0000, ActorScript_27_27, $2300, $1700, FACE_LEFT, $68, $01, $05
	map_actor $0000, ActorScript_27_27, $0500, $1500, FACE_RIGHT, $6b, $01, $04
	map_actor $0000, ActorScript_27_27, $1300, $0d00, FACE_RIGHT, $67, $01, $07
	map_actor $0000, ActorScript_27_27, $1f00, $1500, FACE_LEFT, $6a, $01, $07
	map_actor $0000, ActorScript_27_27, $2500, $0900, FACE_RIGHT, $66, $01, $03
	map_actor $0000, ActorScript_27_27, $3100, $1500, FACE_RIGHT, $65, $01, $06
	map_actor $0000, ActorScript_27_27, $3d00, $1900, FACE_LEFT, $64, $01, $04
	map_actor $0000, ActorScript_27_16, $3100, $0700, FACE_DOWN, $69, $01, $03
	map_actor $0000, ActorScript_27_32, $0800, $0b00, FACE_DOWN, $54, $01, $05
	map_actor $0000, ActorScript_27_33, $0c00, $1700, FACE_UP, $54, $01, $00
	map_actor $0000, ActorScript_27_30, $1800, $0b00, FACE_DOWN, $54, $01, $00
	map_actor $0000, ActorScript_27_31, $1c00, $1700, FACE_UP, $54, $01, $05
	map_actor $0000, ActorScript_27_32, $3400, $0b00, FACE_DOWN, $54, $01, $05
	map_actor $0000, ActorScript_27_33, $3800, $1700, FACE_UP, $54, $01, $00
	map_actor $0000, ActorScript_27_27, $4000, $4000, FACE_UP, $53, $01, $00
	map_actor_end
End4JrCourtActorsAlt_27:
	; $671a, 192 bytes (map_actors)
	map_actor $0000, ActorScript_27_27, $1300, $1300, FACE_DOWN, $37, $01, $00
	map_actor $0000, ActorScript_27_27, $2300, $1700, FACE_LEFT, $68, $01, $05
	map_actor $0000, ActorScript_27_27, $0500, $1500, FACE_RIGHT, $6b, $01, $04
	map_actor $0000, ActorScript_27_27, $2100, $1500, FACE_DOWN, $67, $01, $07
	map_actor $0000, ActorScript_27_27, $0500, $1300, FACE_RIGHT, $6a, $01, $07
	map_actor $0000, ActorScript_27_27, $1b00, $1300, FACE_DOWN, $66, $01, $03
	map_actor $0000, ActorScript_27_27, $1b00, $1500, FACE_UP, $65, $01, $06
	map_actor $0000, ActorScript_27_27, $3700, $0700, FACE_LEFT, $64, $01, $04
	map_actor $0000, ActorScript_27_27, $3500, $0700, FACE_RIGHT, $69, $01, $03
	map_actor $0000, ActorScript_27_32, $0800, $0b00, FACE_DOWN, $54, $01, $05
	map_actor $0000, ActorScript_27_33, $0c00, $1700, FACE_UP, $54, $01, $00
	map_actor $0000, ActorScript_27_30, $2a00, $0b00, FACE_DOWN, $54, $01, $00
	map_actor $0000, ActorScript_27_31, $2e00, $1700, FACE_UP, $54, $01, $05
	map_actor_end
End4JrCourtEntryPoints_27:
	; $67da, 10 bytes (map_entries)
	map_entry $01, FACE_UP, $1300, $2100, $0000
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
	as_anim $01
	as_wait $0a
	as_set_target $1f00, $0d00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_27_15:
	; $6820, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $1f00, $1300
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_27_16:
	; $682f, 55 bytes (actor_script)
	as_flag $01, $05, $02
	as_set_field $06, $0008
.L8:
	as_set_target $2d00, $0700
	as_wait_move2
	as_set_field $14, FACE_DOWN
	as_wait $c8
	as_wait $f0
	as_set_target $3300, $0700
	as_wait_move2
	as_wait $3c
	as_set_target $2d00, $0700
	as_wait_move2
	as_wait $3c
	as_set_target $3300, $0700
	as_wait_move2
	as_set_field $14, FACE_DOWN
	as_wait $f0
	as_wait $f0
	as_jump .L8
End4JrCourtApproachSingles_27:
	script_wait_frames $0f ; $6866
	script_face_toward $07, $03 ; $686d
	script_wait_frames $0a ; $6875
	script_face_toward $07, ACTOR_PLAYER ; $687c
	script_wait_frames $1e ; $6884
	script_player_speed $0020 ; $688b
	script_move_player_to_actor $07 ; $6891
	farcall WaitPlayerMoveDone ; $6898
	script_face_toward $03, $07 ; $689b
	script_set_anim $07, $03 ; $68a3
	script_wait_idle $07 ; $68aa
	script_face $07, FACE_DOWN ; $68af
	script_wait_frames $0a ; $68b6
	script_set_actor_script $07, ActorScript_27_17 ; $68bd
	script_wait_frames $14 ; $68c8
	script_move_player_to_actor ACTOR_PLAYER ; $68cf
	script_face $03, FACE_DOWN ; $68d6
	script_move_player_to_actor ACTOR_PLAYER ; $68dd
	script_wait_actor_script $07 ; $68e4
	script_face_toward ACTOR_PLAYER, $07 ; $68e9
	script_set_anim $07, $02 ; $68f1
	script_wait_idle $07 ; $68f8
	script_set_anim $07, $03 ; $68fd
	script_wait_idle $07 ; $6904
	script_wait_frames $0f ; $6909
	script_face $07, FACE_UP ; $6910
	ret ; $6917
ActorScript_27_17:
	; $6918, 23 bytes (actor_script)
	as_set_target $1f00, $1900
	as_wait_move
	as_set_target $1500, $1900
	as_wait_move
	as_set_target $1500, $1500
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_27_18:
	; $692f, 17 bytes (actor_script)
	as_set_target $1500, $0900
	as_wait_move
	as_set_target $1900, $0900
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_27_19:
	; $6940, 17 bytes (actor_script)
	as_set_target $1300, $1900
	as_wait_move
	as_set_target $1b00, $1900
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
End4JrCourtSceneSingles_27:
	farcall BeginCutsceneScriptMode ; $6951
	script_face $03, FACE_DOWN ; $6954
	call End4JrCourtApproachSingles_27 ; $695b
	script_face ACTOR_PLAYER, FACE_UP ; $695e
	script_wait_frames $0f ; $6965
	script_set_anim $03, $02 ; $696c
	script_wait_idle $03 ; $6973
	script_face $03, FACE_RIGHT ; $6978
	script_wait_frames $0f ; $697f
	script_face ACTOR_PLAYER, FACE_RIGHT ; $6986
	script_face $07, FACE_RIGHT ; $698d
	script_wait_frames $1e ; $6994
	script_set_actor_script $0e, ActorScript_27_14 ; $699b
	script_set_actor_script $0f, ActorScript_27_15 ; $69a6
	script_wait_actor_script $0f ; $69b1
	script_move_player $1700, $1100 ; $69b6
	script_set_actor_script $07, ActorScript_27_18 ; $69c0
	script_set_actor_script ACTOR_PLAYER, ActorScript_27_19 ; $69cb
	farcall WaitPlayerMoveDone ; $69d6
	script_wait_actor_script $07 ; $69d9
	script_wait_frames $14 ; $69de
	ld a, $01 ; $69e5
	ld [wUnusedExitTriggerIdMirror], a ; $69e7
	ld [wStoryModeExitTriggerRequest], a ; $69ea
	ret ; $69ed
.loop:
	farcall BeginCutsceneScriptMode ; $69ee
	script_face_toward $03, ACTOR_PLAYER ; $69f1
	script_wait_frames $1e ; $69f9
	script_face_toward ACTOR_PLAYER, $03 ; $6a00
	call End4JrCourtApproachDoubles_27 ; $6a08
	script_face ACTOR_PLAYER, FACE_UP ; $6a0b
	script_wait_frames $0f ; $6a12
	script_set_anim $03, $02 ; $6a19
	script_wait_idle $03 ; $6a20
	script_face $03, FACE_RIGHT ; $6a25
	script_wait_frames $0f ; $6a2c
	script_face ACTOR_PLAYER, FACE_RIGHT ; $6a33
	script_face $07, FACE_RIGHT ; $6a3a
	script_wait_frames $1e ; $6a41
	call End4JrCourtDepartureDoubles_27 ; $6a48
	ld a, $01 ; $6a4b
	ld [wUnusedExitTriggerIdMirror], a ; $6a4d
	ld [wStoryModeExitTriggerRequest], a ; $6a50
	ret ; $6a53
.walkPlayer:
	script_move_player $1300, $1500 ; $6a54
	script_fade_in $04 ; $6a5e
	script_move_target ACTOR_PLAYER, $1300, $1500 ; $6a63
	script_wait_move ACTOR_PLAYER ; $6a6e
	test_flag FLAG_DOUBLES ; $6a73
	jp nz, .loop ; $6a76
	call End4JrCourtSceneSingles_27 ; $6a79
	ret ; $6a7c
End4JrCourtApproachDoubles_27:
	script_player_speed $0020 ; $6a7d
	script_face $03, FACE_RIGHT ; $6a83
	script_move_player_to_actor $08 ; $6a8a
	farcall WaitPlayerMoveDone ; $6a91
	script_face ACTOR_PLAYER, FACE_RIGHT ; $6a94
	script_face ACTOR_PARTNER, FACE_RIGHT ; $6a9b
	script_null_script $08 ; $6aa2
	script_face $08, FACE_LEFT ; $6aa7
	script_set_anim $08, $02 ; $6aae
	script_wait_idle $08 ; $6ab5
	script_move_player_to_actor ACTOR_PLAYER ; $6aba
	script_move_target $08, $1500, $1500 ; $6ac1
	script_move_target $09, $1500, $1700 ; $6acc
	script_wait_move $09 ; $6ad7
	script_face $09, FACE_LEFT ; $6adc
	script_face $03, FACE_DOWN ; $6ae3
	script_set_anim $08, $02 ; $6aea
	script_wait_idle $08 ; $6af1
	script_set_anim $09, $03 ; $6af6
	script_wait_frames $0f ; $6afd
	script_face ACTOR_PLAYER, FACE_UP ; $6b04
	script_face ACTOR_PARTNER, FACE_UP ; $6b0b
	script_face $08, FACE_UP ; $6b12
	script_face $09, FACE_UP ; $6b19
	ret ; $6b20
End4JrCourtDepartureDoubles_27:
	script_face $03, FACE_RIGHT ; $6b21
	script_wait_frames $1e ; $6b28
	script_null_script ACTOR_PARTNER ; $6b2f
	script_move_player $1900, $1100 ; $6b34
	script_set_actor_script $08, ActorScript_27_24 ; $6b3e
	script_set_actor_script $09, ActorScript_27_25 ; $6b49
	script_move_target ACTOR_PLAYER, $1b00, $1900 ; $6b54
	script_wait_frames $0a ; $6b5f
	script_move_target ACTOR_PARTNER, $1900, $1500 ; $6b66
	script_wait_move ACTOR_PLAYER ; $6b71
	script_face ACTOR_PLAYER, FACE_UP ; $6b76
	script_face ACTOR_PARTNER, FACE_UP ; $6b7d
	script_wait_frames $3c ; $6b84
	ld a, $0f ; $6b8b
	ld [wUnusedExitTriggerIdMirror], a ; $6b8d
	ld [wStoryModeExitTriggerRequest], a ; $6b90
	ret ; $6b93
