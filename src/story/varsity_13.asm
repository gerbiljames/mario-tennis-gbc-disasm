SetRoommateDoublesNoReplyText_13:
	call GetDormRoomStoryStage_13 ; $5b8b
	cp $01 ; $5b8e
	jp nz, .done ; $5b90
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $5b93
	jr z, .setText ; $5b96
	script_set_text Text_31_275 ; $5b98
	jr .done ; $5b9e
.setText:
	script_set_text Text_31_270 ; $5ba0
.done:
	ret ; $5ba6
SetRoommateSinglesNoReplyText_13:
	call GetDormRoomStoryStage_13 ; $5ba7
	cp $01 ; $5baa
	jp nz, .done ; $5bac
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $5baf
	jr z, .setText ; $5bb2
	script_set_text Text_31_276 ; $5bb4
	jr .done ; $5bba
.setText:
	script_set_text Text_31_271 ; $5bbc
.done:
	ret ; $5bc2
SetRoommateSinglesYesReplyText_13:
	call GetDormRoomStoryStage_13 ; $5bc3
	cp $01 ; $5bc6
	jp nz, .done ; $5bc8
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $5bcb
	jr z, .setText ; $5bce
	script_set_text Text_31_276 ; $5bd0
	jr .done ; $5bd6
.setText:
	script_set_text Text_31_271 ; $5bd8
.done:
	ret ; $5bde
SetRoommateDoublesYesReplyText_13:
	call GetDormRoomStoryStage_13 ; $5bdf
	cp $01 ; $5be2
	jp nz, .done ; $5be4
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $5be7
	jr z, .setText ; $5bea
	script_set_text Text_31_277 ; $5bec
	jr .done ; $5bf2
.setText:
	script_set_text Text_31_272 ; $5bf4
.done:
	ret ; $5bfa
ComputeEmoteActorPosition_13:
	farcall GetActorStateAddr ; $5bfb
	ld c, l ; $5bfe
	ld b, h ; $5bff
	ld hl, ACTORF_X ; $5c00
	add hl, bc ; $5c03
	ld a, [hl+] ; $5c04
	ld h, [hl] ; $5c05
	ld l, a ; $5c06
	ld de, $0180 ; $5c07
	add hl, de ; $5c0a
	ld e, l ; $5c0b
	ld d, h ; $5c0c
	ld hl, wMapScratch + 6 ; $5c0d
	ld a, e ; $5c10
	ld [hl+], a ; $5c11
	ld [hl], d ; $5c12
	ld hl, ACTORF_Y ; $5c13
	add hl, bc ; $5c16
	ld a, [hl+] ; $5c17
	ld h, [hl] ; $5c18
	ld l, a ; $5c19
	ld de, $fe80 ; $5c1a
	add hl, de ; $5c1d
	ld e, l ; $5c1e
	ld d, h ; $5c1f
	ld hl, wMapScratch + 8 ; $5c20
	ld a, e ; $5c23
	ld [hl+], a ; $5c24
	ld [hl], d ; $5c25
	ret ; $5c26
PlaceEmoteActorAtComputedPosition_13:
	ld hl, wMapScratch + 6 ; $5c27
	ld a, [hl+] ; $5c2a
	ld b, [hl] ; $5c2b
	ld c, a ; $5c2c
	ld hl, wMapScratch + 8 ; $5c2d
	ld a, [hl+] ; $5c30
	ld d, [hl] ; $5c31
	ld e, a ; $5c32
	ld a, $05 ; $5c33
	farcall ScriptSetActorPosition ; $5c35
	ret ; $5c38
PlaceRoommateAtPlayerTarget_13:
	script_get_actor_state ACTOR_PLAYER ; $5c39
	ld c, l ; $5c3e
	ld b, h ; $5c3f
	ld hl, ACTORF_X ; $5c40
	add hl, bc ; $5c43
	ld a, [hl+] ; $5c44
	ld h, [hl] ; $5c45
	ld l, a ; $5c46
	ld de, $0000 ; $5c47
	add hl, de ; $5c4a
	ld e, l ; $5c4b
	ld d, h ; $5c4c
	ld hl, wMapScratch + 6 ; $5c4d
	ld a, e ; $5c50
	ld [hl+], a ; $5c51
	ld [hl], d ; $5c52
	ld hl, ACTORF_Y ; $5c53
	add hl, bc ; $5c56
	ld a, [hl+] ; $5c57
	ld h, [hl] ; $5c58
	ld l, a ; $5c59
	ld de, $0000 ; $5c5a
	add hl, de ; $5c5d
	ld e, l ; $5c5e
	ld d, h ; $5c5f
	ld hl, wMapScratch + 8 ; $5c60
	ld a, e ; $5c63
	ld [hl+], a ; $5c64
	ld [hl], d ; $5c65
	ld hl, wMapScratch + 6 ; $5c66
	ld a, [hl+] ; $5c69
	ld b, [hl] ; $5c6a
	ld c, a ; $5c6b
	ld hl, wMapScratch + 8 ; $5c6c
	ld a, [hl+] ; $5c6f
	ld d, [hl] ; $5c70
	ld e, a ; $5c71
	ld a, $03 ; $5c72
	farcall ScriptSetActorPosition ; $5c74
	ret ; $5c77
CourtyardMapScripts_13:
	; $5c78, 14 bytes (map_tree)
	dw CourtyardEntryPoints_13 ; slot 0 EntryPoints
	dw CourtyardExitTriggers_13 ; slot 1 ExitTriggers
	dw CourtyardActors_13 ; slot 2 Actors
	dw CourtyardNpcScripts_13 ; slot 3 NpcScripts
	dw CourtyardFacingScripts_13 ; slot 4 FacingScripts
	dw CourtyardTileTriggers_13 ; slot 5 TileTriggers
	dw CourtyardInitScript_13 ; slot 6 InitScript
CourtyardActors_13:
	; $5c86, 94 bytes (map_actors)
	map_actor $0000, ActorScript_13_27, 13.0, 29.0, FACE_DOWN, OBJ_KEVIN, ANIM_WALK, $00, COURTYARD_KEVIN
	map_actor $0000, ActorScript_13_27, 5.0, 29.0, FACE_RIGHT, OBJ_BOB, ANIM_WALK, $07, COURTYARD_BOB
	map_actor $0000, ActorScript_13_20, 13.0, 35.0, FACE_UP, OBJ_FAY, ANIM_SWING_LOOP, $03, COURTYARD_FAY
	map_actor $0000, ActorScript_13_27, 8.0, 19.0, FACE_UP, OBJ_CURT, ANIM_WALK, $06, COURTYARD_CURT
	map_actor $0000, ActorScript_13_28, 15.0, 23.0, FACE_DOWN, OBJ_BETH, ANIM_WALK, $06, COURTYARD_BETH
	map_actor $0000, ActorScript_13_27, 16.75, 26.375, FACE_LEFT, OBJ_INVISIBLE, ANIM_WALK, $00, COURTYARD_INVISIBLE
	map_actor_end
VarsityCourtActorsA_13:
	; $5ce4, 108 bytes (map_actors)
	map_actor $0000, ActorScript_13_27, 13.0, 29.0, FACE_DOWN, OBJ_KEVIN, ANIM_WALK, $00, VARSITY_COURT_A_KEVIN
	map_actor $0000, ActorScript_13_27, 5.0, 29.0, FACE_RIGHT, OBJ_BOB, ANIM_WALK, $07, VARSITY_COURT_A_BOB
	map_actor $0000, ActorScript_13_20, 13.0, 35.0, FACE_UP, OBJ_FAY, ANIM_WALK, $03, VARSITY_COURT_A_FAY
	map_actor $0000, ActorScript_13_27, 8.0, 19.0, FACE_UP, OBJ_CURT, ANIM_WALK, $04, VARSITY_COURT_A_CURT
	map_actor $0000, ActorScript_13_28, 15.0, 23.0, FACE_DOWN, OBJ_BETH, ANIM_WALK, $06, VARSITY_COURT_A_BETH
	map_actor $0000, ActorScript_13_27, 45.0, 61.0, FACE_DOWN, OBJ_EMILY, ANIM_WALK, $00, VARSITY_COURT_A_EMILY
	map_actor $0000, ActorScript_13_27, 16.75, 26.375, FACE_LEFT, OBJ_INVISIBLE, ANIM_WALK, $00, VARSITY_COURT_A_INVISIBLE
	map_actor_end
VarsityCourtActorsB_13:
	; $5d50, 122 bytes (map_actors)
	map_actor $0000, ActorScript_13_27, 13.0, 29.0, FACE_DOWN, OBJ_KEVIN, ANIM_WALK, $00, VARSITY_COURT_B_KEVIN
	map_actor $0000, ActorScript_13_27, 5.0, 35.0, FACE_UP, OBJ_BOB, ANIM_WALK, $07, VARSITY_COURT_B_BOB
	map_actor $0000, ActorScript_13_20, 13.0, 37.0, FACE_UP, OBJ_FAY, ANIM_WALK, $03, VARSITY_COURT_B_FAY
	map_actor $0000, ActorScript_13_27, 16.0, 37.0, FACE_LEFT, OBJ_CURT, ANIM_WALK, $04, VARSITY_COURT_B_CURT
	map_actor $0000, ActorScript_13_27, 8.0, 19.0, FACE_UP, OBJ_BETH, ANIM_WALK, $06, VARSITY_COURT_B_BETH
	map_actor $0000, ActorScript_13_27, 45.0, 61.0, FACE_DOWN, OBJ_EMILY, ANIM_WALK, $00, VARSITY_COURT_B_EMILY
	map_actor $0000, ActorScript_13_27, 5.0, 33.0, FACE_DOWN, OBJ_MARK, ANIM_WALK, $00, VARSITY_COURT_B_MARK
	map_actor $0000, ActorScript_13_27, 16.75, 26.375, FACE_LEFT, OBJ_INVISIBLE, ANIM_WALK, $00, VARSITY_COURT_B_INVISIBLE
	map_actor_end
VarsityCourtActorsC_13:
	; $5dca, 52 bytes (map_actors)
	map_actor $0000, ActorScript_13_20, 16.0, 21.0, FACE_DOWN, OBJ_BOB, ANIM_WALK, $07, VARSITY_COURT_C_BOB
	map_actor $0000, ActorScript_13_20, 13.0, 37.0, FACE_UP, OBJ_FAY, ANIM_WALK, $03, VARSITY_COURT_C_FAY
	map_actor $0000, ActorScript_13_27, 16.75, 26.375, FACE_LEFT, OBJ_INVISIBLE, ANIM_WALK, $00, VARSITY_COURT_C_INVISIBLE
	map_actor_end
VarsityCourtActorsD_13:
	; $5dfe, 66 bytes (map_actors)
	map_actor $0000, ActorScript_13_20, 13.0, 29.0, FACE_DOWN, OBJ_BOB, ANIM_WALK, $07, VARSITY_COURT_D_BOB
	map_actor $0000, ActorScript_13_20, 13.0, 35.0, FACE_UP, OBJ_FAY, ANIM_WALK, $03, VARSITY_COURT_D_FAY
	map_actor $0000, ActorScript_13_28, 9.0, 21.0, FACE_DOWN, OBJ_MARK, ANIM_WALK, $00, VARSITY_COURT_D_MARK
	map_actor $0000, ActorScript_13_27, 16.75, 26.375, FACE_LEFT, OBJ_INVISIBLE, ANIM_WALK, $00, VARSITY_COURT_D_INVISIBLE
	map_actor_end
CourtyardEntryPoints_13:
	; $5e40, 57 bytes (map_entries)
	map_entry $01, FACE_DOWN, 54.0, 22.0, $0000
	map_entry $02, FACE_DOWN, 34.0, 11.0, $0000
	map_entry $03, FACE_UP, 34.0, 49.0, $0000
	map_entry $0a, FACE_UP, 17.0, 29.0, $0000
	map_entry $0d, FACE_UP, 13.0, 31.0, $0000
	map_entry $0e, FACE_UP, 15.0, 31.0, $0000
	map_entry $0f, FACE_UP, 34.0, 47.0, $0000
	db $ff
CourtyardExitTriggers_13:
	; $5e79, 49 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, $0000, STORYLOC_TRAINING_CENTER, $01
	map_script $02, FACEMASK_ANY, $0000, $0000, STORYLOC_RESTAURANT_PLAZA, $04
	map_script $03, FACEMASK_ANY, $0000, $0000, STORYLOC_ACADEMY_MAIN_BLDG, $02
	map_script $0a, FACEMASK_ANY, $0000, MapScriptNop_13, STORYLOC_MAIN_MENU, $0a
	map_script $0e, FACEMASK_ANY, $0000, $0000, STORYLOC_COURTYARD, $0e
	map_script $0f, FACEMASK_ANY, $0000, $0000, STORYLOC_RESTAURANT_PLAZA, $0f
	db $ff
CourtyardNpc03_13:
	script_set_text Text_30_527 ; $5eaa
	test_flag FLAG_DOUBLES ; $5eb0
	jr z, .notDoubles ; $5eb3
	script_set_text Text_30_529 ; $5eb5
.notDoubles:
	script_speak_restore ACTOR_COURTYARD_KEVIN ; $5ebb
	farcall RunDialogueYesNoPrompt ; $5ec0
	farcall ScriptCloseDialogueWindow ; $5ec3
	script_wait_frames 5 ; $5ec6
	and a ; $5ecd
	jr nz, .speak ; $5ece
	script_set_text Text_30_531 ; $5ed0
.speak:
	script_speak ACTOR_COURTYARD_KEVIN ; $5ed6
	ret ; $5edb
CourtyardNpcScripts_13:
	; $5edc, 57 bytes (map_scripts)
	map_script ACTOR_COURTYARD_KEVIN, FACEMASK_ANY, $0000, CourtyardNpc03_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_COURTYARD_BOB, FACEMASK_ANY, $05e0, Text_30_532, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_COURTYARD_FAY, FACEMASK_ANY, $05e0, Text_30_533, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_COURTYARD_BOB, FACEMASK_ANY, $0000, Text_30_536, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_COURTYARD_FAY, FACEMASK_ANY, $0000, Text_30_537, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_IDLE_ANIM | NPC_FREEZE, $00
	map_script ACTOR_COURTYARD_CURT, FACEMASK_ANY, $0000, Text_30_534, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_COURTYARD_BETH, FACEMASK_ANY, $0000, Text_30_535, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	db $ff
VarsityCourtANpc05_13:
	script_null_script ACTOR_VARSITY_COURT_A_FAY ; $5f15
	script_set_anim ACTOR_VARSITY_COURT_A_FAY, ANIM_WALK ; $5f1a
	script_set_text Text_30_539 ; $5f21
	script_speak_restore ACTOR_VARSITY_COURT_A_FAY ; $5f27
	farcall RunDialogueYesNoPrompt ; $5f2c
	farcall ScriptCloseDialogueWindow ; $5f2f
	script_wait_frames 5 ; $5f32
	and a ; $5f39
	jr z, .advanceText ; $5f3a
	script_speak ACTOR_VARSITY_COURT_A_FAY ; $5f3c
	script_set_actor_script ACTOR_VARSITY_COURT_A_FAY, ActorScript_13_20 ; $5f41
	ret ; $5f4c
.advanceText:
	farcall AdvanceDialogueTextCursor ; $5f4d
	script_speak ACTOR_VARSITY_COURT_A_FAY ; $5f50
	ld hl, wStoryModePlayersXPosition ; $5f55
	ld de, wStoryModeSpawnPosition ; $5f58
	ld bc, wStoryModeSpawnPosition_SIZE ; $5f5b
	call CopyMemoryBC ; $5f5e
	ld a, STORYENTRY_NONE ; $5f61
	ld [wStoryModeEntryPoint], a ; $5f63
	ld [wUnusedExitTriggerIdMirror], a ; $5f66
	ld [wStoryModeExitTriggerRequest], a ; $5f69
	call SetupStoryMinigameMatch0 ; $5f6c
	ret ; $5f6f
VarsityCourtNpcScriptsA_13:
	; $5f70, 49 bytes (map_scripts)
	map_script ACTOR_VARSITY_COURT_A_KEVIN, FACEMASK_UP, $0000, VarsityCourtANpc03FaceUp_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_A_KEVIN, FACEMASK_ANY, $0000, VarsityCourtANpc03_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_A_BOB, FACEMASK_ANY, $0000, Text_30_538, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_A_FAY, FACEMASK_ANY, $0000, VarsityCourtANpc05_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_A_CURT, FACEMASK_ANY, $0000, Text_30_542, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_VARSITY_COURT_A_BETH, FACEMASK_ANY, $0000, Text_30_543, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	db $ff
VarsityCourtBNpc09_13:
	script_set_text Text_31_3 ; $5fa1
	script_speak_restore ACTOR_VARSITY_COURT_B_MARK ; $5fa7
	farcall RunDialogueYesNoPrompt ; $5fac
	farcall ScriptCloseDialogueWindow ; $5faf
	script_wait_frames 5 ; $5fb2
	and a ; $5fb9
	jr z, .speak ; $5fba
	farcall AdvanceDialogueTextCursor ; $5fbc
.speak:
	script_speak ACTOR_VARSITY_COURT_B_MARK ; $5fbf
	ret ; $5fc4
VarsityCourtBNpc05_13:
	script_null_script ACTOR_VARSITY_COURT_B_FAY ; $5fc5
	script_set_anim ACTOR_VARSITY_COURT_B_FAY, ANIM_WALK ; $5fca
	script_set_text Text_31_7 ; $5fd1
	script_speak_restore ACTOR_VARSITY_COURT_B_FAY ; $5fd7
	farcall RunDialogueYesNoPrompt ; $5fdc
	farcall ScriptCloseDialogueWindow ; $5fdf
	script_wait_frames 5 ; $5fe2
	and a ; $5fe9
	jr z, .advanceText ; $5fea
	script_speak ACTOR_VARSITY_COURT_B_FAY ; $5fec
	script_set_actor_script ACTOR_VARSITY_COURT_B_FAY, ActorScript_13_20 ; $5ff1
	ret ; $5ffc
.advanceText:
	farcall AdvanceDialogueTextCursor ; $5ffd
	script_speak ACTOR_VARSITY_COURT_B_FAY ; $6000
	ld hl, wStoryModePlayersXPosition ; $6005
	ld de, wStoryModeSpawnPosition ; $6008
	ld bc, wStoryModeSpawnPosition_SIZE ; $600b
	call CopyMemoryBC ; $600e
	ld a, STORYENTRY_NONE ; $6011
	ld [wStoryModeEntryPoint], a ; $6013
	ld [wUnusedExitTriggerIdMirror], a ; $6016
	ld [wStoryModeExitTriggerRequest], a ; $6019
	call SetupVarsityCourtDoublesMatch_13 ; $601c
	ret ; $601f
VarsityCourtNpcScriptsB_13:
	; $6020, 57 bytes (map_scripts)
	map_script ACTOR_VARSITY_COURT_B_KEVIN, FACEMASK_UP, $0000, VarsityCourtBNpc03FaceUp_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_B_KEVIN, FACEMASK_ANY, $0000, VarsityCourtBNpc03_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_B_BOB, FACEMASK_ANY, $0000, Text_31_6, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_B_FAY, FACEMASK_ANY, $0000, VarsityCourtBNpc05_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_B_CURT, FACEMASK_ANY, $0000, Text_31_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_B_BETH, FACEMASK_ANY, $0000, Text_31_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_VARSITY_COURT_B_MARK, FACEMASK_ANY, $0000, VarsityCourtBNpc09_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
VarsityCourtCNpc03_13:
	script_null_script ACTOR_VARSITY_COURT_C_BOB ; $6059
	script_set_anim ACTOR_VARSITY_COURT_C_BOB, ANIM_WALK ; $605e
	script_set_text Text_31_34 ; $6065
	script_speak ACTOR_VARSITY_COURT_C_BOB ; $606b
	script_set_actor_script ACTOR_VARSITY_COURT_C_BOB, ActorScript_13_20 ; $6070
	ret ; $607b
VarsityCourtCNpc04_13:
	script_null_script ACTOR_VARSITY_COURT_C_BOB ; $607c
	script_set_anim ACTOR_VARSITY_COURT_C_FAY, ANIM_WALK ; $6081
	script_set_text Text_31_35 ; $6088
	script_speak ACTOR_VARSITY_COURT_C_FAY ; $608e
	script_set_actor_script ACTOR_VARSITY_COURT_C_FAY, ActorScript_13_20 ; $6093
	ret ; $609e
VarsityCourtNpcScriptsC_13:
	; $609f, 25 bytes (map_scripts)
	map_script ACTOR_VARSITY_COURT_C_BOB, FACEMASK_ANY, $0000, VarsityCourtCNpc03_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_C_FAY, FACEMASK_ANY, $0000, VarsityCourtCNpc04_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $05, FACEMASK_ANY, $0000, VarsityCourtCNpc05_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	db $ff
VarsityCourtCNpc05_13:
	script_set_text Text_31_36 ; $60b8
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $60be
	jr z, .speak ; $60c1
	farcall AdvanceDialogueTextCursor ; $60c3
.speak:
	script_speak $05 ; $60c6
	ret ; $60cb
VarsityCourtDNpc05_13:
	script_null_script ACTOR_COURTYARD_FAY ; $60cc
	script_set_anim ACTOR_COURTYARD_FAY, ANIM_WALK ; $60d1
	script_set_text Text_31_40 ; $60d8
	script_speak ACTOR_COURTYARD_FAY ; $60de
	script_set_actor_script ACTOR_COURTYARD_FAY, ActorScript_13_20 ; $60e3
	ret ; $60ee
VarsityCourtNpcScriptsD_13:
	; $60ef, 41 bytes (map_scripts)
	map_script ACTOR_COURTYARD_KEVIN, FACEMASK_ANY, $0000, Text_31_38, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_COURTYARD_BOB, FACEMASK_ANY, $0000, Text_31_39, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_COURTYARD_FAY, FACEMASK_ANY, $0000, VarsityCourtDNpc05_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_COURTYARD_CURT, FACEMASK_ANY, $0000, Text_31_41, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_COURTYARD_BETH, FACEMASK_ANY, $0000, Text_31_42, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	db $ff
VarsityCourtENpc05_13:
	script_null_script ACTOR_VARSITY_COURT_B_FAY ; $6118
	script_set_anim ACTOR_VARSITY_COURT_B_FAY, ANIM_WALK ; $611d
	script_set_text Text_31_45 ; $6124
	script_speak ACTOR_VARSITY_COURT_B_FAY ; $612a
	script_set_actor_script ACTOR_VARSITY_COURT_B_FAY, ActorScript_13_20 ; $612f
	ret ; $613a
VarsityCourtNpcScriptsE_13:
	; $613b, 41 bytes (map_scripts)
	map_script ACTOR_VARSITY_COURT_B_KEVIN, FACEMASK_ANY, $0000, Text_31_43, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_B_BOB, FACEMASK_ANY, $0000, Text_31_44, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_B_FAY, FACEMASK_ANY, $0000, VarsityCourtENpc05_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_VARSITY_COURT_B_CURT, FACEMASK_ANY, $0000, Text_31_46, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_VARSITY_COURT_B_BETH, FACEMASK_ANY, $0000, Text_31_47, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	db $ff
CourtyardFacingScripts_13:
	; $6164, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, CourtyardFacing01_13, $00, $00
	db $ff
CourtyardFacing01_13:
	call ShowStoryTournamentBracket_13 ; $616d
	ld hl, wStoryModePlayersXPosition ; $6170
	ld de, wStoryModeSpawnPosition ; $6173
	ld bc, wStoryModeSpawnPosition_SIZE ; $6176
	call CopyMemoryBC ; $6179
	ld a, STORYENTRY_NONE ; $617c
	ld [wStoryModeEntryPoint], a ; $617e
	ld [wUnusedExitTriggerIdMirror], a ; $6181
	ld [wStoryModeExitTriggerRequest], a ; $6184
	ret ; $6187
CourtyardTileTriggers_13:
	ds 1, $ff ; $6188, fill
CourtyardInitScript_13:
	call SetupVarsityCourtSceneVariant ; $6189
	ld a, [wStoryModeEntryPoint] ; $618c
	cp $0f ; $618f
	jr nz, .doubles ; $6191
	jp VarsityCourtTourCutscene ; $6193
.doubles:
	cp $0d ; $6196
	jr nz, .placeActors ; $6198
	call RunTravelingTeamBracketIfWon_13 ; $619a
	ret ; $619d
.placeActors:
	cp $0e ; $619e
	jr nz, .done ; $61a0
	jp RunTravelingTeamVictoryCutscene_13 ; $61a2
.done:
	call CourtyardEntryWalkIn_13 ; $61a5
	ret ; $61a8
SetupVarsityCourtSceneVariant:
	test_flag FLAG_DOUBLES ; $61a9
	jr nz, .stage3 ; $61ac
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $61ae
	jr z, .stage1 ; $61b1
	ld hl, VarsityCourtNpcScriptsD_13 ; $61b3
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $61b6
	farcall WriteStoryStateWord ; $61b9
	ld a, BEHAVIOR_ACTION | 1 << 4 ; $61bc
	map_cell 8, 16 ; $61be
	farcall WriteBehaviorMapCell ; $61c2
	ld a, BEHAVIOR_ACTION | 1 << 4 ; $61c5
	map_cell 6, 16 ; $61c7
	farcall WriteBehaviorMapCell ; $61cb
	script_set_position ACTOR_COURTYARD_CURT, 5.0, 21.0 ; $61ce
	script_face ACTOR_COURTYARD_CURT, FACE_RIGHT ; $61d9
	ret ; $61e0
.stage1:
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $61e1
	jr z, .stage2 ; $61e4
	ldh a, [hRomBank] ; $61e6
	ld hl, VarsityCourtActorsC_13 ; $61e8
	farcall ScriptRespawnLocationActors ; $61eb
	ld hl, VarsityCourtNpcScriptsC_13 ; $61ee
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $61f1
	farcall WriteStoryStateWord ; $61f4
	ld a, BEHAVIOR_ACTION | 1 << 4 ; $61f7
	map_cell 8, 16 ; $61f9
	farcall WriteBehaviorMapCell ; $61fd
	ld a, BEHAVIOR_ACTION | 1 << 4 ; $6200
	map_cell 6, 16 ; $6202
	farcall WriteBehaviorMapCell ; $6206
	ret ; $6209
.stage2:
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $620a
	jp z, .done ; $620d
	ldh a, [hRomBank] ; $6210
	ld hl, VarsityCourtActorsA_13 ; $6212
	farcall ScriptRespawnLocationActors ; $6215
	ld hl, VarsityCourtNpcScriptsA_13 ; $6218
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $621b
	farcall WriteStoryStateWord ; $621e
	ret ; $6221
.stage3:
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $6222
	jr z, .stage4 ; $6225
	ldh a, [hRomBank] ; $6227
	ld hl, VarsityCourtActorsB_13 ; $6229
	farcall ScriptRespawnLocationActors ; $622c
	ld hl, VarsityCourtNpcScriptsE_13 ; $622f
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $6232
	farcall WriteStoryStateWord ; $6235
	script_set_position ACTOR_VARSITY_COURT_B_MARK, 63.0, 63.0 ; $6238
	script_face ACTOR_VARSITY_COURT_B_BOB, FACE_RIGHT ; $6243
	script_set_actor_script ACTOR_VARSITY_COURT_B_CURT, ActorScript_13_30 ; $624a
	ld a, BEHAVIOR_ACTION | 1 << 4 ; $6255
	map_cell 8, 16 ; $6257
	farcall WriteBehaviorMapCell ; $625b
	ld a, BEHAVIOR_ACTION | 1 << 4 ; $625e
	map_cell 6, 16 ; $6260
	farcall WriteBehaviorMapCell ; $6264
	script_set_position ACTOR_VARSITY_COURT_B_BETH, 15.0, 23.0 ; $6267
	script_set_actor_script ACTOR_VARSITY_COURT_B_BETH, ActorScript_13_28 ; $6272
	ret ; $627d
.stage4:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $627e
	jr z, .stage5 ; $6281
	ldh a, [hRomBank] ; $6283
	ld hl, VarsityCourtActorsD_13 ; $6285
	farcall ScriptRespawnLocationActors ; $6288
	ld hl, VarsityCourtNpcScriptsC_13 ; $628b
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $628e
	farcall WriteStoryStateWord ; $6291
	ld a, BEHAVIOR_ACTION | 1 << 4 ; $6294
	map_cell 8, 16 ; $6296
	farcall WriteBehaviorMapCell ; $629a
	ld a, BEHAVIOR_ACTION | 1 << 4 ; $629d
	map_cell 6, 16 ; $629f
	farcall WriteBehaviorMapCell ; $62a3
	ret ; $62a6
.stage5:
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $62a7
	jr z, .done ; $62aa
	ldh a, [hRomBank] ; $62ac
	ld hl, VarsityCourtActorsB_13 ; $62ae
	farcall ScriptRespawnLocationActors ; $62b1
	ld hl, VarsityCourtNpcScriptsB_13 ; $62b4
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $62b7
	farcall WriteStoryStateWord ; $62ba
.done:
	ret ; $62bd
