DataPtr_SmallCharTestMapScripts_0f:
	dw SmallCharTestMapScripts_0f ; $4000
DataPtr_AwardsCeremonyMapScripts_0f:
	dw AwardsCeremonyMapScripts_0f ; $4002
DataPtr_TournamentMapScripts_0f:
	dw TournamentMapScripts_0f ; $4004
SmallCharTestMapScripts_0f:
	; $4006, 14 bytes (map_tree)
	dw SmallCharTestEntryPoints_0f ; slot 0 EntryPoints
	dw SmallCharTestExitTriggers_0f ; slot 1 ExitTriggers
	dw SmallCharTestActors_0f ; slot 2 Actors
	dw SmallCharTestNpcScripts_0f ; slot 3 NpcScripts
	dw SmallCharTestFacingScripts_0f ; slot 4 FacingScripts
	dw SmallCharTestTileTriggers_0f ; slot 5 TileTriggers
	dw SmallCharTestInitScript_0f ; slot 6 InitScript
SmallCharTestActors_0f:
	; $4014, 178 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, 7.0, 3.0, FACE_DOWN, OBJ_ALEX, ANIM_WALK, $00, SMALL_CHAR_TEST_ALEX
	map_actor $0000, ActorScript_0f_09, 13.0, 3.0, FACE_DOWN, OBJ_WALUIGI, ANIM_WALK, $00, SMALL_CHAR_TEST_WALUIGI_1
	map_actor $0000, ActorScript_0f_09, 7.0, 7.0, FACE_DOWN, OBJ_YOSHI, ANIM_WALK, $00, SMALL_CHAR_TEST_YOSHI
	map_actor $0000, ActorScript_0f_09, 13.0, 7.0, FACE_DOWN, OBJ_BOWSER, ANIM_WALK, $00, SMALL_CHAR_TEST_BOWSER
	map_actor $0000, ActorScript_0f_09, 5.0, 13.0, FACE_DOWN, OBJ_TOAD, ANIM_WALK, $00, SMALL_CHAR_TEST_TOAD
	map_actor $0000, ActorScript_0f_09, 9.0, 13.0, FACE_DOWN, OBJ_BOB_OMB, ANIM_WALK, $00, SMALL_CHAR_TEST_BOB_OMB
	map_actor $0000, ActorScript_0f_09, 13.0, 13.0, FACE_DOWN, OBJ_WALK_77_05, ANIM_WALK, $00, SMALL_CHAR_TEST_WALK_77_05
	map_actor $0000, ActorScript_0f_09, 17.0, 13.0, FACE_DOWN, OBJ_BOO, ANIM_WALK, $00, SMALL_CHAR_TEST_BOO
	map_actor $0000, ActorScript_0f_09, 5.0, 17.0, FACE_DOWN, OBJ_LUIGI, ANIM_WALK, $00, SMALL_CHAR_TEST_LUIGI
	map_actor $0000, ActorScript_0f_09, 9.0, 17.0, FACE_DOWN, OBJ_DK, ANIM_WALK, $00, SMALL_CHAR_TEST_DK
	map_actor $0000, ActorScript_0f_09, 13.0, 17.0, FACE_DOWN, OBJ_WARIO, ANIM_WALK, $00, SMALL_CHAR_TEST_WARIO
	map_actor $0000, ActorScript_0f_09, 17.0, 17.0, FACE_DOWN, OBJ_WALUIGI, ANIM_WALK, $00, SMALL_CHAR_TEST_WALUIGI_2
	map_actor_end
SmallCharTestEntryPoints_0f:
	; $40c6, 9 bytes (map_entries)
	map_entry $01, FACE_DOWN, 11.0, 11.0, $0000
	db $ff
SmallCharTestExitTriggers_0f:
	ds 1, $ff ; $40cf, fill
Unused_0f_SmallCharTestStageStepDown:
	ld hl, wMapSceneStage ; $40d0
	ld a, [hl] ; $40d3
	dec a ; $40d4
	ld hl, wMapSceneStage2 ; $40d5
	add a ; $40d8
	jr nc, .checkMax ; $40d9
	ld a, [hl] ; $40db
	dec a ; $40dc
	jr .compare ; $40dd
.checkMax:
	rra ; $40df
	cp [hl] ; $40e0
	jr c, .compare ; $40e1
	xor a ; $40e3
.compare:
	cp $29 ; $40e4
	jr nc, SmallCharTestApplyStage_0f ; $40e6
	ld hl, wMapSceneStage2 ; $40e8
	ld a, [hl] ; $40eb
SmallCharTestApplyStage_0f:
	ld hl, wMapSceneStage ; $40ec
	ld [hl], a ; $40ef
	call SetPlayerActorObjectDef ; $40f0
	ret ; $40f3
SmallCharTestNpc03_0f:
	ld hl, wMapSceneStage ; $40f4
	ld a, [hl] ; $40f7
	inc [hl] ; $40f8
	and $03 ; $40f9
	add $26 ; $40fb
	call SetPlayerActorObjectDef ; $40fd
	ret ; $4100
SmallCharTestNpc04_0f:
	ld hl, wMapSceneStage ; $4101
	ld a, [hl] ; $4104
	inc a ; $4105
	ld hl, wMapSceneStage2 ; $4106
	add a ; $4109
	jr nc, .checkMax ; $410a
	ld a, [hl] ; $410c
	dec a ; $410d
	jr .compare ; $410e
.checkMax:
	rra ; $4110
	cp [hl] ; $4111
	jr c, .compare ; $4112
	xor a ; $4114
.compare:
	cp $2a ; $4115
	jr nc, SmallCharTestApplyStage_0f ; $4117
	ld hl, $002a ; $4119
	ld a, l ; $411c
	jr SmallCharTestApplyStage_0f ; $411d
; Instruction-for-instruction the same as SmallCharTestApplyStage_0f just above it: the same four-instruction body assembled twice. Nothing reaches this copy.
UnusedSmallCharTestApplyStage_0f:
	ld hl, wMapSceneStage ; $411f
	ld [hl], a ; $4122
	call SetPlayerActorObjectDef ; $4123
	ret ; $4126
SmallCharTestNpc05_0f:
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $4127
	ret ; $412e
SmallCharTestNpc06_0f:
	script_set_anim ACTOR_PLAYER, ANIM_SHAKE ; $412f
	ret ; $4136
MapScriptNop_0f:
	ret ; $4137
SmallCharTestNpcScripts_0f:
	; $4138, 97 bytes (map_scripts)
	map_script ACTOR_SMALL_CHAR_TEST_ALEX, FACEMASK_ANY, $0000, SmallCharTestNpc03_0f, $00, $00
	map_script ACTOR_SMALL_CHAR_TEST_WALUIGI_1, FACEMASK_ANY, $0000, SmallCharTestNpc04_0f, $00, $00
	map_script ACTOR_SMALL_CHAR_TEST_YOSHI, FACEMASK_ANY, $0000, SmallCharTestNpc05_0f, $00, $00
	map_script ACTOR_SMALL_CHAR_TEST_BOWSER, FACEMASK_ANY, $0000, SmallCharTestNpc06_0f, $00, $00
	map_script ACTOR_SMALL_CHAR_TEST_TOAD, FACEMASK_ANY, $0000, MapScriptNop_0f, NPC_FACE_PLAYER, $00
	map_script ACTOR_SMALL_CHAR_TEST_BOB_OMB, FACEMASK_ANY, $0000, MapScriptNop_0f, NPC_FACE_PLAYER, $00
	map_script ACTOR_SMALL_CHAR_TEST_WALK_77_05, FACEMASK_ANY, $0000, MapScriptNop_0f, NPC_FACE_PLAYER, $00
	map_script ACTOR_SMALL_CHAR_TEST_BOO, FACEMASK_ANY, $0000, MapScriptNop_0f, NPC_FACE_PLAYER, $00
	map_script ACTOR_SMALL_CHAR_TEST_LUIGI, FACEMASK_ANY, $0000, MapScriptNop_0f, NPC_FACE_PLAYER, $00
	map_script ACTOR_SMALL_CHAR_TEST_DK, FACEMASK_ANY, $0000, MapScriptNop_0f, NPC_FACE_PLAYER, $00
	map_script ACTOR_SMALL_CHAR_TEST_WARIO, FACEMASK_ANY, $0000, MapScriptNop_0f, NPC_FACE_PLAYER, $00
	map_script ACTOR_SMALL_CHAR_TEST_WALUIGI_2, FACEMASK_ANY, $0000, MapScriptNop_0f, NPC_FACE_PLAYER, $00
	db $ff
SmallCharTestFacingScripts_0f:
	ds 1, $ff ; $4199, fill
SmallCharTestTile01_0f:
	ret ; $419a
SmallCharTestTileTriggers_0f:
	; $419b, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, SmallCharTestTile01_0f, $00, $00
	db $ff
SmallCharTestInitScript_0f:
	xor a ; $41a4
	ld [wMapSceneStage], a ; $41a5
	farcall GetObjectDefCount ; $41a8
	ld [wMapSceneStage2], a ; $41ab
	ld a, $01 ; $41ae
	ld hl, SmallCharTestButtonTask_0f ; $41b0
	call RegisterFrameTask ; $41b3
	ret ; $41b6
SmallCharTestButtonTask_0f:
	ldh a, [hInputRisingEdge] ; $41b7
	and $f0 ; $41b9
	jr z, .done ; $41bb
	script_set_anim ACTOR_PLAYER, ANIM_WALK ; $41bd
.done:
	ret ; $41c4
SetPlayerActorObjectDef:
	ld d, a ; $41c5
	wram_bank WRAM_ACTORS ; $41c6
	ld hl, wPlayerObjDefPending ; $41cc
	ld [hl], $00 ; $41cf
	ld bc, wActors ; $41d1
	farcall LoadActorObjectDefIfValid ; $41d4
	call RestorePalettesFromMaster ; $41d7
	ret ; $41da
AwardsCeremonyMapScripts_0f:
	; $41db, 14 bytes (map_tree)
	dw AwardsCeremonyEntryPoints_0f ; slot 0 EntryPoints
	dw AwardsCeremonyExitTriggers_0f ; slot 1 ExitTriggers
	dw AwardsCeremonyActors_0f ; slot 2 Actors
	dw AwardsCeremonyNpcScripts_0f ; slot 3 NpcScripts
	dw AwardsCeremonyFacingScripts_0f ; slot 4 FacingScripts
	dw AwardsCeremonyTileTriggers_0f ; slot 5 TileTriggers
	dw AwardsCeremonyInitScript_0f ; slot 6 InitScript
AwardsCeremonyActors_0f:
	; $41e9, 290 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, 11.0, 39.0, FACE_UP, OBJ_WALK_74_08, ANIM_WALK, $00, AWARDS_CEREMONY_WALK_74_08
	map_actor $0000, ActorScript_0f_09, 13.0, 39.0, FACE_UP, OBJ_A_COZ, ANIM_WALK, $00, AWARDS_CEREMONY_A_COZ
	map_actor $0000, ActorScript_0f_09, 14.5, 27.0, FACE_LEFT, OBJ_B_COZ, ANIM_WALK, $00, AWARDS_CEREMONY_B_COZ
	map_actor $0000, ActorScript_0f_09, 8.0, 31.0, FACE_RIGHT, OBJ_SAMMI, ANIM_WALK, $00, AWARDS_CEREMONY_SAMMI
	map_actor $0000, ActorScript_0f_09, 7.0, 33.0, FACE_RIGHT, OBJ_SEAN, ANIM_WALK, $00, AWARDS_CEREMONY_SEAN
	map_actor $0000, ActorScript_0f_09, 8.0, 29.0, FACE_RIGHT, OBJ_SPIKE, ANIM_WALK, $00, AWARDS_CEREMONY_SPIKE
	map_actor $0000, ActorScript_0f_09, 15.0, 29.0, FACE_LEFT, OBJ_WALK_6F_06, ANIM_WALK, $00, AWARDS_CEREMONY_WALK_6F_06
	map_actor $0000, ActorScript_0f_09, 9.5, 27.0, FACE_RIGHT, OBJ_WALK_6F_05, ANIM_WALK, $00, AWARDS_CEREMONY_WALK_6F_05
	map_actor $0000, ActorScript_0f_09, 8.0, 25.25, FACE_RIGHT, OBJ_WALK_6F_07, ANIM_WALK, $05, AWARDS_CEREMONY_WALK_6F_07_1
	map_actor $0000, ActorScript_0f_09, 8.0, 23.0, FACE_RIGHT, OBJ_WALK_75_06, ANIM_WALK, $00, AWARDS_CEREMONY_WALK_75_06
	map_actor $0000, ActorScript_0f_09, 14.75, 23.5, FACE_DOWN, OBJ_TROPHY, ANIM_WALK, $00, AWARDS_CEREMONY_TROPHY_1
	map_actor $0000, ActorScript_0f_09, 16.25, 23.75, FACE_DOWN, OBJ_TROPHY, ANIM_WALK, $00, AWARDS_CEREMONY_TROPHY_2
	map_actor $0000, ActorScript_0f_09, 17.5, 23.75, FACE_DOWN, OBJ_TROPHY, ANIM_WALK, $00, AWARDS_CEREMONY_TROPHY_3
	map_actor $0000, ActorScript_0f_09, 15.0, 22.0, FACE_LEFT, OBJ_WALK_6F_07, ANIM_WALK, $00, AWARDS_CEREMONY_WALK_6F_07_2
	map_actor $0000, ActorScript_0f_09, 17.0, 33.0, FACE_LEFT, OBJ_WALK_74_07, ANIM_WALK, $00, AWARDS_CEREMONY_WALK_74_07
	map_actor $0000, ActorScript_0f_09, 16.0, 31.0, FACE_LEFT, OBJ_WALK_74_06, ANIM_WALK, $00, AWARDS_CEREMONY_WALK_74_06
	map_actor $0000, ActorScript_0f_09, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_ANGRY, ANIM_WALK, $00, AWARDS_CEREMONY_BALLOON_ANGRY
	map_actor $0000, ActorScript_0f_09, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, AWARDS_CEREMONY_BALLOON_SWEAT
	map_actor $0000, ActorScript_0f_09, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_QUESTION, ANIM_WALK, $00, AWARDS_CEREMONY_BALLOON_QUESTION
	map_actor $0000, ActorScript_0f_09, 253.0, 1.0, FACE_DOWN, OBJ_ALEX, ANIM_WALK, $00, AWARDS_CEREMONY_ALEX
	map_actor_end
AwardsCeremonyActorsDoubles_0f:
	; $430b, 290 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, 15.0, 27.0, FACE_LEFT, OBJ_WALK_74_08, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_WALK_74_08
	map_actor $0000, ActorScript_0f_09, 13.0, 39.0, FACE_UP, OBJ_A_COZ, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_A_COZ
	map_actor $0000, ActorScript_0f_09, 13.0, 41.0, FACE_UP, OBJ_B_COZ, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_B_COZ
	map_actor $0000, ActorScript_0f_09, 8.0, 31.0, FACE_RIGHT, OBJ_SAMMI, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_SAMMI
	map_actor $0000, ActorScript_0f_09, 7.0, 33.0, FACE_RIGHT, OBJ_SEAN, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_SEAN
	map_actor $0000, ActorScript_0f_09, 8.0, 29.0, FACE_RIGHT, OBJ_SPIKE, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_SPIKE
	map_actor $0000, ActorScript_0f_09, 15.0, 29.0, FACE_LEFT, OBJ_WALK_6F_06, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_WALK_6F_06
	map_actor $0000, ActorScript_0f_09, 9.0, 27.0, FACE_RIGHT, OBJ_WALK_6F_05, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_WALK_6F_05
	map_actor $0000, ActorScript_0f_09, 8.0, 25.25, FACE_RIGHT, OBJ_WALK_6F_07, ANIM_WALK, $05, AWARDS_CEREMONY_DOUBLES_WALK_6F_07_1
	map_actor $0000, ActorScript_0f_09, 8.0, 23.0, FACE_RIGHT, OBJ_WALK_75_06, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_WALK_75_06
	map_actor $0000, ActorScript_0f_09, 15.0, 23.5, FACE_DOWN, OBJ_TROPHY, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_TROPHY_1
	map_actor $0000, ActorScript_0f_09, 17.0, 23.75, FACE_DOWN, OBJ_TROPHY, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_TROPHY_2
	map_actor $0000, ActorScript_0f_09, 41.0, 41.0, FACE_DOWN, OBJ_TROPHY, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_TROPHY_3
	map_actor $0000, ActorScript_0f_09, 15.0, 22.0, FACE_LEFT, OBJ_WALK_6F_07, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_WALK_6F_07_2
	map_actor $0000, ActorScript_0f_09, 47.0, 33.0, FACE_LEFT, OBJ_WALK_74_07, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_WALK_74_07
	map_actor $0000, ActorScript_0f_09, 16.0, 32.0, FACE_LEFT, OBJ_WALK_74_06, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_WALK_74_06
	map_actor $0000, ActorScript_0f_09, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_ANGRY, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_BALLOON_ANGRY
	map_actor $0000, ActorScript_0f_09, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_SWEAT, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_BALLOON_SWEAT
	map_actor $0000, ActorScript_0f_09, 253.0, 1.0, FACE_DOWN, OBJ_BALLOON_QUESTION, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_BALLOON_QUESTION
	map_actor $0000, ActorScript_0f_09, 253.0, 1.0, FACE_DOWN, OBJ_ALEX, ANIM_WALK, $00, AWARDS_CEREMONY_DOUBLES_ALEX
	map_actor_end
AwardsCeremonyEntryPoints_0f:
	; $442d, 25 bytes (map_entries)
	map_entry $01, FACE_UP, 12.0, 41.0, $0000
	map_entry $0a, FACE_UP, 12.0, 41.0, $0000
	map_entry $0b, FACE_UP, 11.0, 41.0, $0000
	db $ff
AwardsCeremonyExitTriggers_0f:
	ds 1, $ff ; $4446, fill
AwardsCeremonyNpcScripts_0f:
	; $4447, 81 bytes (map_scripts)
	map_script ACTOR_AWARDS_CEREMONY_WALK_74_08, FACEMASK_ANY, $0000, $0000, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_AWARDS_CEREMONY_A_COZ, FACEMASK_ANY, $0000, Text_25_115, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_AWARDS_CEREMONY_B_COZ, FACEMASK_ANY, $0000, Text_25_132, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_AWARDS_CEREMONY_SAMMI, FACEMASK_ANY, $0000, Text_25_122, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_AWARDS_CEREMONY_SEAN, FACEMASK_ANY, $0000, Text_25_124, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_AWARDS_CEREMONY_SPIKE, FACEMASK_ANY, $0000, AwardsCeremonyNpc08_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_AWARDS_CEREMONY_WALK_6F_06, FACEMASK_ANY, $0000, Text_25_130, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_AWARDS_CEREMONY_WALK_6F_05, FACEMASK_ANY, $0000, Text_25_131, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_AWARDS_CEREMONY_WALK_74_07, FACEMASK_ANY, $0000, Text_25_121, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_AWARDS_CEREMONY_WALK_74_06, FACEMASK_ANY, $0000, Text_25_123, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
AwardsCeremonyFacingScripts_0f:
	; $4498, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, AwardsCeremonyFacing01_0f, $00, $00
	db $ff
AwardsCeremonyFacing01_0f:
	ret ; $44a1
AwardsCeremonyTileTriggers_0f:
	; $44a2, 17 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, AwardsCeremonyTile01_0f, $00, $00
	map_script $02, FACEMASK_ANY, $0000, AwardsCeremonyTile02_0f, $00, $00
	db $ff
AwardsCeremonyTile01_0f:
	ld b, $0a ; $44b3
	ld c, $1c ; $44b5
	ld d, $0a ; $44b7
	ld e, $1a ; $44b9
	ld h, $04 ; $44bb
	ld l, $02 ; $44bd
	farcall CopyBehaviorMapRect ; $44bf
	call CutsceneStompScreenShake ; $44c2
	call CutsceneStompScreenShake ; $44c5
	script_set_text Text_25_126 ; $44c8
	script_speak ACTOR_AWARDS_CEREMONY_SPIKE ; $44ce
	test_flag FLAG_DOUBLES ; $44d3
	jp z, .doubles ; $44d6
	set_flag FLAG_AWARDS_CEREMONY_SEEN_DOUBLES ; $44d9
	script_set_text Text_25_180 ; $44dc
	script_null_script ACTOR_PARTNER ; $44e2
	script_move_target ACTOR_PARTNER, 13.0, 27.0 ; $44e7
	script_wait_move ACTOR_PARTNER ; $44f2
	script_move_target ACTOR_PLAYER, 11.0, 27.0 ; $44f7
	script_wait_move ACTOR_PLAYER ; $4502
	call ReplacePlayerWithStandInActor ; $4507
	script_set_position ACTOR_AWARDS_CEREMONY_ALEX, 11.0, 27.0 ; $450a
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $4515
	ld d, OBJ_HARRY_B ; $4518
	add d ; $451a
	ld d, a ; $451b
	script_get_actor_state ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION ; $451c
	ld c, l ; $4521
	ld b, h ; $4522
	farcall LoadActorObjectDefIfValid ; $4523
	script_set_anim ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION, ANIM_WALK ; $4526
	script_set_position ACTOR_PARTNER, 63.0, 63.0 ; $452d
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION, 13.0, 27.0 ; $4538
	script_face ACTOR_AWARDS_CEREMONY_ALEX, FACE_DOWN ; $4543
	script_face ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION, FACE_DOWN ; $454a
	script_move_target ACTOR_AWARDS_CEREMONY_SPIKE, 12.0, 29.0 ; $4551
	script_wait_move ACTOR_AWARDS_CEREMONY_SPIKE ; $455c
	script_face ACTOR_AWARDS_CEREMONY_SPIKE, FACE_UP ; $4561
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 13.5, 27.0 ; $4568
	sound SFX_APPEAR1 ; $4573
	script_speak ACTOR_AWARDS_CEREMONY_SPIKE ; $4575
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 63.0, 63.0 ; $457a
	script_set_anim ACTOR_AWARDS_CEREMONY_SPIKE, ANIM_BOUNCE ; $4585
	script_wait_idle ACTOR_AWARDS_CEREMONY_SPIKE ; $458c
	script_speak ACTOR_AWARDS_CEREMONY_SPIKE ; $4591
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT, 12.5, 25.0 ; $4596
	sound SFX_APPEAR2 ; $45a1
	ld a, 120 ; $45a3
	call DelayFrames ; $45a5
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT, 63.0, 63.0 ; $45a8
	jp .ceremony ; $45b3
.doubles:
	set_flag FLAG_AWARDS_CEREMONY_SEEN_SINGLES ; $45b6
	script_null_script ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $45b9
	script_move_target ACTOR_PLAYER, 11.5, 27.0 ; $45be
	script_wait_move ACTOR_PLAYER ; $45c9
	call ReplacePlayerWithStandInActor ; $45ce
	script_set_position ACTOR_AWARDS_CEREMONY_ALEX, 11.5, 27.0 ; $45d1
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_74_08, 13.0, 29.0 ; $45dc
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $45e7
	script_face ACTOR_AWARDS_CEREMONY_WALK_74_08, FACE_LEFT ; $45ec
	ld a, 1 ; $45f3
	call DelayFrames ; $45f5
	script_move_target ACTOR_AWARDS_CEREMONY_SPIKE, 11.0, 29.0 ; $45f8
	script_wait_move ACTOR_AWARDS_CEREMONY_SPIKE ; $4603
	script_face ACTOR_AWARDS_CEREMONY_ALEX, FACE_DOWN ; $4608
	script_face ACTOR_AWARDS_CEREMONY_SPIKE, FACE_UP ; $460f
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 12.5, 27.0 ; $4616
	sound SFX_APPEAR1 ; $4621
	script_speak ACTOR_AWARDS_CEREMONY_SPIKE ; $4623
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 63.0, 63.0 ; $4628
	script_set_anim ACTOR_AWARDS_CEREMONY_SPIKE, ANIM_BOUNCE ; $4633
	script_wait_idle ACTOR_AWARDS_CEREMONY_SPIKE ; $463a
	script_speak ACTOR_AWARDS_CEREMONY_SPIKE ; $463f
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT, 13.0, 25.0 ; $4644
	sound SFX_APPEAR2 ; $464f
	ld a, 120 ; $4651
	call DelayFrames ; $4653
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_SWEAT, 63.0, 63.0 ; $4656
.ceremony:
	call CutsceneStompScreenShake ; $4661
	call CutsceneStompScreenShake ; $4664
	script_speak ACTOR_AWARDS_CEREMONY_SPIKE ; $4667
	call CutsceneStompScreenShake ; $466c
	call CutsceneStompScreenShake ; $466f
	script_move_target ACTOR_AWARDS_CEREMONY_SPIKE, 9.0, 29.0 ; $4672
	script_wait_move ACTOR_AWARDS_CEREMONY_SPIKE ; $467d
	script_face ACTOR_AWARDS_CEREMONY_SPIKE, FACE_RIGHT ; $4682
	ld a, 1 ; $4689
	call DelayFrames ; $468b
	script_set_position ACTOR_AWARDS_CEREMONY_ALEX, 63.0, 63.0 ; $468e
	test_flag FLAG_DOUBLES ; $4699
	jp z, .done ; $469c
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION, 63.0, 63.0 ; $469f
	script_set_objdef OBJ_BALLOON_QUESTION, ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION ; $46aa
	script_set_anim ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION, ANIM_WALK ; $46b6
	script_face ACTOR_PLAYER, FACE_DOWN ; $46bd
	script_set_position ACTOR_PLAYER, 11.0, 27.0 ; $46c4
	script_set_position ACTOR_PARTNER, 13.0, 27.0 ; $46cf
	ld a, 1 ; $46da
	call DelayFrames ; $46dc
	script_face ACTOR_PLAYER, FACE_DOWN ; $46df
	script_face ACTOR_PARTNER, FACE_DOWN ; $46e6
	ld a, 1 ; $46ed
	call DelayFrames ; $46ef
	script_get_actor_state ACTOR_PARTNER ; $46f2
	ld c, l ; $46f7
	ld b, h ; $46f8
	ld de, wActors ; $46f9
	farcall AttachActorStepMover ; $46fc
	ret ; $46ff
.done:
	script_set_position ACTOR_PLAYER, 11.5, 27.0 ; $4700
	script_face ACTOR_PLAYER, FACE_DOWN ; $470b
	ld a, 1 ; $4712
	call DelayFrames ; $4714
	script_get_actor_state ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $4717
	ld c, l ; $471c
	ld b, h ; $471d
	ld de, wActors ; $471e
	farcall AttachActorStepMover ; $4721
	ret ; $4724
AwardsCeremonyTile02_0f:
	test_flag FLAG_DOUBLES ; $4725
	jp nz, .doubles ; $4728
	script_null_script ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $472b
	script_move_target ACTOR_PLAYER, 12.0, 25.0 ; $4730
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_74_08, 12.0, 27.0 ; $473b
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_74_08 ; $4746
	ld a, 10 ; $474b
	call DelayFrames ; $474d
	script_face_toward ACTOR_AWARDS_CEREMONY_WALK_6F_07_1, ACTOR_PLAYER ; $4750
	script_face ACTOR_AWARDS_CEREMONY_WALK_74_08, FACE_UP ; $4758
	ld a, 60 ; $475f
	call DelayFrames ; $4761
	call AnnounceWinnersToPodiums ; $4764
	script_face ACTOR_PLAYER, FACE_DOWN ; $4767
	script_move_target ACTOR_AWARDS_CEREMONY_A_COZ, 12.0, 29.0 ; $476e
	script_wait_move ACTOR_AWARDS_CEREMONY_A_COZ ; $4779
	ld a, 10 ; $477e
	call DelayFrames ; $4780
	call FaceAwardsCeremonyCrowdUp ; $4783
	script_set_speed ACTOR_PLAYER, 1.0 ; $4786
	script_set_speed ACTOR_AWARDS_CEREMONY_WALK_74_08, 1.0 ; $478e
	script_set_speed ACTOR_AWARDS_CEREMONY_A_COZ, 1.0 ; $4796
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_00 ; $479e
	script_set_actor_script ACTOR_AWARDS_CEREMONY_WALK_74_08, ActorScript_0f_00 ; $47a9
	script_set_actor_script ACTOR_AWARDS_CEREMONY_A_COZ, ActorScript_0f_00 ; $47b4
	ld a, 180 ; $47bf
	call DelayFrames ; $47c1
	script_set_position ACTOR_PLAYER, 12.0, 13.25 ; $47c4
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_74_08, 14.0, 14.25 ; $47cf
	script_set_position ACTOR_AWARDS_CEREMONY_A_COZ, 10.0, 13.75 ; $47da
	call ReplacePlayerWithStandInActor ; $47e5
	script_set_position ACTOR_AWARDS_CEREMONY_ALEX, 12.0, 13.25 ; $47e8
	script_face ACTOR_AWARDS_CEREMONY_ALEX, FACE_DOWN ; $47f3
	script_face ACTOR_AWARDS_CEREMONY_WALK_74_08, FACE_DOWN ; $47fa
	script_face ACTOR_AWARDS_CEREMONY_A_COZ, FACE_DOWN ; $4801
	script_player_speed 0.1875 ; $4808
	script_move_player 12.0, 19.0 ; $480e
	farcall WaitPlayerMoveDone ; $4818
	call AwardsCeremonyChairmanSpeech ; $481b
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 14.0, 19.0 ; $481e
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $4829
	script_face ACTOR_AWARDS_CEREMONY_WALK_75_06, FACE_UP ; $482e
	script_set_speed ACTOR_AWARDS_CEREMONY_TROPHY_3, 0.5 ; $4835
	script_set_speed ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 0.5 ; $483d
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 17.0, 22.0 ; $4845
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $4850
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, FACE_DOWN ; $4855
	ld a, 20 ; $485c
	call DelayFrames ; $485e
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_3, 17.5, 22.0 ; $4861
	ld a, 20 ; $486c
	call DelayFrames ; $486e
	call AwardsCeremonySwapActors_0f ; $4871
	script_set_objdef OBJ_WALK_74_08, ACTOR_AWARDS_CEREMONY_WALK_74_07 ; $4874
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_74_07, ANIM_WALK ; $4880
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_74_08, 63.0, 63.0 ; $4887
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_74_07, 14.0, 14.25 ; $4892
	script_face ACTOR_AWARDS_CEREMONY_WALK_74_07, FACE_DOWN ; $489d
	script_set_speed ACTOR_AWARDS_CEREMONY_WALK_75_06, 0.5 ; $48a4
	script_set_speed ACTOR_AWARDS_CEREMONY_TROPHY_3, 0.5 ; $48ac
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 14.0, 17.0 ; $48b4
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_3, 14.0, 16.0 ; $48bf
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_3 ; $48ca
	ld a, 30 ; $48cf
	call DelayFrames ; $48d1
	script_speak ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $48d4
	ld a, 30 ; $48d9
	call DelayFrames ; $48db
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 14.0, 16.25 ; $48de
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_3, 14.0, 15.25 ; $48e9
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_3 ; $48f4
	ld a, 5 ; $48f9
	call DelayFrames ; $48fb
	script_lock_facing ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $48fe
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 14.0, 17.0 ; $4905
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $4910
	script_unlock_facing ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $4915
	script_face ACTOR_AWARDS_CEREMONY_WALK_75_06, FACE_UP ; $491c
	ld a, 20 ; $4923
	call DelayFrames ; $4925
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_3, 63.0, 63.0 ; $4928
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_74_07, ANIM_BOUNCE ; $4933
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_74_07 ; $493a
	script_speak ACTOR_AWARDS_CEREMONY_WALK_74_07 ; $493f
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION, 15.5, 15.5 ; $4944
	sound SFX_EMOTE ; $494f
	ld a, 120 ; $4951
	call DelayFrames ; $4953
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION, 63.0, 63.0 ; $4956
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_74_07, ANIM_SHAKE ; $4961
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_74_07 ; $4968
	script_speak ACTOR_AWARDS_CEREMONY_WALK_74_07 ; $496d
	script_get_actor_state ACTOR_AWARDS_CEREMONY_ALEX ; $4972
	ld a, $01 ; $4977
	ld e, l ; $4979
	ld d, h ; $497a
	ld hl, $0018 ; $497b
	add hl, de ; $497e
	ld [hl], a ; $497f
	script_get_actor_state ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $4980
	ld a, $01 ; $4985
	ld e, l ; $4987
	ld d, h ; $4988
	ld hl, $0018 ; $4989
	add hl, de ; $498c
	ld [hl], a ; $498d
	script_set_anim ACTOR_AWARDS_CEREMONY_ALEX, ANIM_BOUNCE ; $498e
	script_wait_idle ACTOR_AWARDS_CEREMONY_ALEX ; $4995
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_75_06, ANIM_NOD ; $499a
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $49a1
	script_speak ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $49a6
	ld a, 30 ; $49ab
	call DelayFrames ; $49ad
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 14.0, 19.0 ; $49b0
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $49bb
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 10.0, 19.0 ; $49c0
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $49cb
	script_face ACTOR_AWARDS_CEREMONY_WALK_75_06, FACE_UP ; $49d0
	ld a, 20 ; $49d7
	call DelayFrames ; $49d9
	script_set_speed ACTOR_AWARDS_CEREMONY_TROPHY_2, 0.5 ; $49dc
	script_set_speed ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 0.5 ; $49e4
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 16.0, 22.0 ; $49ec
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $49f7
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, FACE_DOWN ; $49fc
	ld a, 20 ; $4a03
	call DelayFrames ; $4a05
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_2, 16.5, 22.0 ; $4a08
	ld a, 20 ; $4a13
	call DelayFrames ; $4a15
	script_set_objdef OBJ_TROPHY, ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $4a18
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, ANIM_WALK ; $4a24
	script_set_objdef OBJ_WALK_6F_07, ACTOR_AWARDS_CEREMONY_TROPHY_2 ; $4a2b
	script_set_anim ACTOR_AWARDS_CEREMONY_TROPHY_2, ANIM_WALK ; $4a37
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_2, 16.0, 22.0 ; $4a3e
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 16.0, 21.0 ; $4a49
	script_face ACTOR_AWARDS_CEREMONY_TROPHY_2, FACE_UP ; $4a54
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, ANIM_TROPHY_SMALL ; $4a5b
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 16.0, 18.0 ; $4a62
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_2, 16.0, 19.0 ; $4a6d
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_2 ; $4a78
	script_set_objdef OBJ_WALK_6F_07, ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $4a7d
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, ANIM_WALK ; $4a89
	script_set_objdef OBJ_TROPHY, ACTOR_AWARDS_CEREMONY_TROPHY_2 ; $4a90
	script_set_anim ACTOR_AWARDS_CEREMONY_TROPHY_2, ANIM_WALK ; $4a9c
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 16.0, 19.0 ; $4aa3
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_2, 15.0, 19.0 ; $4aae
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, FACE_LEFT ; $4ab9
	script_set_anim ACTOR_AWARDS_CEREMONY_TROPHY_2, ANIM_TROPHY_SMALL ; $4ac0
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 12.0, 19.0 ; $4ac7
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_2, 11.0, 19.0 ; $4ad2
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_2 ; $4add
	script_lock_facing ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $4ae2
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 14.0, 19.0 ; $4ae9
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $4af4
	script_unlock_facing ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $4af9
	script_set_speed ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 1.0 ; $4b00
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 16.0, 22.0 ; $4b08
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $4b13
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, FACE_UP ; $4b18
	script_set_objdef OBJ_A_COZ, ACTOR_AWARDS_CEREMONY_WALK_74_06 ; $4b1f
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_74_06, ANIM_WALK ; $4b2b
	script_set_position ACTOR_AWARDS_CEREMONY_A_COZ, 63.0, 63.0 ; $4b32
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_74_06, 10.0, 13.75 ; $4b3d
	script_face ACTOR_AWARDS_CEREMONY_WALK_74_06, FACE_DOWN ; $4b48
	script_set_speed ACTOR_AWARDS_CEREMONY_WALK_75_06, 0.5 ; $4b4f
	script_set_speed ACTOR_AWARDS_CEREMONY_TROPHY_2, 0.5 ; $4b57
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 10.0, 17.0 ; $4b5f
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_2, 10.0, 16.0 ; $4b6a
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_2 ; $4b75
	ld a, 30 ; $4b7a
	call DelayFrames ; $4b7c
	script_speak ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $4b7f
	ld a, 30 ; $4b84
	call DelayFrames ; $4b86
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 10.0, 15.75 ; $4b89
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_2, 10.0, 14.75 ; $4b94
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_2 ; $4b9f
	ld a, 5 ; $4ba4
	call DelayFrames ; $4ba6
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_74_06, ANIM_BOUNCE ; $4ba9
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_74_06 ; $4bb0
	script_lock_facing ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $4bb5
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 10.0, 17.0 ; $4bbc
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $4bc7
	script_unlock_facing ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $4bcc
	script_face ACTOR_AWARDS_CEREMONY_WALK_75_06, FACE_UP ; $4bd3
	ld a, 20 ; $4bda
	call DelayFrames ; $4bdc
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_2, 63.0, 63.0 ; $4bdf
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 11.5, 12.25 ; $4bea
	sound SFX_APPEAR1 ; $4bf5
	script_speak ACTOR_AWARDS_CEREMONY_WALK_74_06 ; $4bf7
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 63.0, 63.0 ; $4bfc
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION, 11.5, 15.5 ; $4c07
	sound SFX_EMOTE ; $4c12
	ld a, 120 ; $4c14
	call DelayFrames ; $4c16
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION, 63.0, 63.0 ; $4c19
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_74_06, ANIM_SHAKE ; $4c24
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_74_06 ; $4c2b
	script_speak ACTOR_AWARDS_CEREMONY_WALK_74_06 ; $4c30
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_75_06, ANIM_NOD ; $4c35
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $4c3c
	script_speak ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $4c41
	ld a, 30 ; $4c46
	call DelayFrames ; $4c48
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 10.0, 19.0 ; $4c4b
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $4c56
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 12.0, 19.0 ; $4c5b
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $4c66
	script_face ACTOR_AWARDS_CEREMONY_WALK_75_06, FACE_UP ; $4c6b
	script_set_speed ACTOR_AWARDS_CEREMONY_TROPHY_1, 0.5 ; $4c72
	script_set_speed ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 0.5 ; $4c7a
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 15.0, 22.0 ; $4c82
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $4c8d
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, FACE_DOWN ; $4c92
	ld a, 20 ; $4c99
	call DelayFrames ; $4c9b
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_1, 15.5, 22.0 ; $4c9e
	ld a, 20 ; $4ca9
	call DelayFrames ; $4cab
	script_set_objdef OBJ_TROPHY, ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $4cae
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, ANIM_WALK ; $4cba
	script_set_objdef OBJ_WALK_6F_07, ACTOR_AWARDS_CEREMONY_TROPHY_1 ; $4cc1
	script_set_anim ACTOR_AWARDS_CEREMONY_TROPHY_1, ANIM_WALK ; $4ccd
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_1, 15.0, 22.0 ; $4cd4
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 15.0, 21.0 ; $4cdf
	script_face ACTOR_AWARDS_CEREMONY_TROPHY_1, FACE_UP ; $4cea
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, ANIM_TROPHY_SINGLES ; $4cf1
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 15.0, 18.0 ; $4cf8
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_1, 15.0, 19.0 ; $4d03
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_1 ; $4d0e
	script_set_objdef OBJ_WALK_6F_07, ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $4d13
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, ANIM_WALK ; $4d1f
	script_set_objdef OBJ_TROPHY, ACTOR_AWARDS_CEREMONY_TROPHY_1 ; $4d26
	script_set_anim ACTOR_AWARDS_CEREMONY_TROPHY_1, ANIM_WALK ; $4d32
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 15.0, 19.0 ; $4d39
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_1, 14.0, 19.0 ; $4d44
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, FACE_LEFT ; $4d4f
	script_set_anim ACTOR_AWARDS_CEREMONY_TROPHY_1, ANIM_TROPHY_SINGLES ; $4d56
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 14.0, 19.0 ; $4d5d
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_1, 13.0, 19.0 ; $4d68
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_1 ; $4d73
	script_lock_facing ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $4d78
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 15.0, 19.0 ; $4d7f
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $4d8a
	script_unlock_facing ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $4d8f
	script_set_speed ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 1.0 ; $4d96
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 15.0, 22.0 ; $4d9e
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $4da9
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, FACE_UP ; $4dae
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 12.0, 17.0 ; $4db5
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_1, 12.0, 16.0 ; $4dc0
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_1 ; $4dcb
	script_speak ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $4dd0
	ld a, 20 ; $4dd5
	call DelayFrames ; $4dd7
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 12.0, 15.5 ; $4dda
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_1, 12.0, 14.25 ; $4de5
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_1 ; $4df0
	script_lock_facing ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $4df5
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 12.0, 17.0 ; $4dfc
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $4e07
	script_unlock_facing ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $4e0c
	script_face ACTOR_AWARDS_CEREMONY_WALK_75_06, FACE_UP ; $4e13
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_6F_07_1, ANIM_BOUNCE ; $4e1a
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $4e21
	script_speak ACTOR_AWARDS_CEREMONY_ALEX ; $4e26
	script_face ACTOR_AWARDS_CEREMONY_WALK_74_07, FACE_LEFT ; $4e2b
	script_face ACTOR_AWARDS_CEREMONY_WALK_74_06, FACE_RIGHT ; $4e32
	ld a, 60 ; $4e39
	call DelayFrames ; $4e3b
	ld a, [wStoryModeGenderOfMainCharacter] ; $4e3e
	ld d, OBJ_ALEX ; $4e41
	add d ; $4e43
	ld d, a ; $4e44
	script_get_actor_state ACTOR_AWARDS_CEREMONY_ALEX ; $4e45
	ld c, l ; $4e4a
	ld b, h ; $4e4b
	farcall LoadActorObjectDefIfValid ; $4e4c
	script_set_anim ACTOR_AWARDS_CEREMONY_ALEX, ANIM_WALK ; $4e4f
	script_face ACTOR_AWARDS_CEREMONY_ALEX, FACE_RIGHT ; $4e56
	script_set_anim ACTOR_AWARDS_CEREMONY_ALEX, ANIM_DISTANT ; $4e5d
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_1, 11.25, 12.25 ; $4e64
	script_move_player 12.0, 13.0 ; $4e6f
	farcall WaitPlayerMoveDone ; $4e79
	ld a, 180 ; $4e7c
	call DelayFrames ; $4e7e
	ld c, $01 ; $4e81
	call BeginFadeOut ; $4e83
	call WaitFadeEnd ; $4e86
	ld b, $01 ; $4e89
	ld a, [wStoryModeGenderOfMainCharacter] ; $4e8b
	add $04 ; $4e8e
	ld c, a ; $4e90
	farcall RunStorySceneByMode ; $4e91
	ld a, STORYLOC_ACADEMY_WING ; $4e94
	ld [wStoryModeCurrentLocation], a ; $4e96
	ld a, $0f ; $4e99
	ld [wStoryModeEntryPoint], a ; $4e9b
	ld a, $ff ; $4e9e
	ld [wUnusedExitTriggerIdMirror], a ; $4ea0
	ld [wStoryModeExitTriggerRequest], a ; $4ea3
	ret ; $4ea6
.doubles:
	script_null_script ACTOR_PARTNER ; $4ea7
	script_move_target ACTOR_PLAYER, 12.0, 25.0 ; $4eac
	script_move_target ACTOR_PARTNER, 12.0, 27.0 ; $4eb7
	script_wait_move ACTOR_PARTNER ; $4ec2
	ld a, 10 ; $4ec7
	call DelayFrames ; $4ec9
	script_face_toward ACTOR_AWARDS_CEREMONY_WALK_6F_07_1, ACTOR_PLAYER ; $4ecc
	script_face ACTOR_PARTNER, FACE_UP ; $4ed4
	ld a, 60 ; $4edb
	call DelayFrames ; $4edd
	call AnnounceWinnersToPodiums ; $4ee0
	script_face ACTOR_PLAYER, FACE_DOWN ; $4ee3
	script_get_actor_state ACTOR_AWARDS_CEREMONY_B_COZ ; $4eea
	ld c, l ; $4eef
	ld b, h ; $4ef0
	script_get_actor_state ACTOR_AWARDS_CEREMONY_A_COZ ; $4ef1
	ld e, l ; $4ef6
	ld d, h ; $4ef7
	farcall AttachActorStepMover ; $4ef8
	script_move_target ACTOR_AWARDS_CEREMONY_A_COZ, 12.0, 29.0 ; $4efb
	script_wait_move ACTOR_AWARDS_CEREMONY_A_COZ ; $4f06
	ld a, 10 ; $4f0b
	call DelayFrames ; $4f0d
	script_null_script ACTOR_AWARDS_CEREMONY_B_COZ ; $4f10
	call FaceAwardsCeremonyCrowdUp ; $4f15
	script_face ACTOR_AWARDS_CEREMONY_WALK_74_08, FACE_UP ; $4f18
	script_set_speed ACTOR_PLAYER, 1.0 ; $4f1f
	script_set_speed ACTOR_PARTNER, 1.0 ; $4f27
	script_set_speed ACTOR_AWARDS_CEREMONY_A_COZ, 1.0 ; $4f2f
	script_set_speed ACTOR_AWARDS_CEREMONY_B_COZ, 1.0 ; $4f37
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_00 ; $4f3f
	script_set_actor_script ACTOR_PARTNER, ActorScript_0f_00 ; $4f4a
	script_set_actor_script ACTOR_AWARDS_CEREMONY_A_COZ, ActorScript_0f_00 ; $4f55
	script_set_actor_script ACTOR_AWARDS_CEREMONY_B_COZ, ActorScript_0f_00 ; $4f60
	ld a, 180 ; $4f6b
	call DelayFrames ; $4f6d
	call ReplacePlayerWithStandInActor ; $4f70
	script_set_position ACTOR_AWARDS_CEREMONY_ALEX, 13.0, 13.375 ; $4f73
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $4f7e
	ld d, OBJ_HARRY_B ; $4f81
	add d ; $4f83
	ld d, a ; $4f84
	script_get_actor_state ACTOR_AWARDS_CEREMONY_WALK_74_07 ; $4f85
	ld c, l ; $4f8a
	ld b, h ; $4f8b
	farcall LoadActorObjectDefIfValid ; $4f8c
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_74_07, ANIM_WALK ; $4f8f
	script_set_position ACTOR_PARTNER, 63.0, 63.0 ; $4f96
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_74_07, 15.0, 13.375 ; $4fa1
	script_set_objdef OBJ_A_COZ, ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY ; $4fac
	script_set_anim ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, ANIM_WALK ; $4fb8
	script_set_objdef OBJ_B_COZ, ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION ; $4fbf
	script_set_anim ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION, ANIM_WALK ; $4fcb
	script_set_position ACTOR_AWARDS_CEREMONY_A_COZ, 63.0, 63.0 ; $4fd2
	script_set_position ACTOR_AWARDS_CEREMONY_B_COZ, 63.0, 63.0 ; $4fdd
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, 11.0, 14.0 ; $4fe8
	script_set_position ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION, 9.0, 14.0 ; $4ff3
	script_set_objdef OBJ_BALLOON_ANGRY, ACTOR_AWARDS_CEREMONY_A_COZ ; $4ffe
	script_set_anim ACTOR_AWARDS_CEREMONY_A_COZ, ANIM_WALK ; $500a
	script_set_objdef OBJ_BALLOON_QUESTION, ACTOR_AWARDS_CEREMONY_B_COZ ; $5011
	script_set_anim ACTOR_AWARDS_CEREMONY_B_COZ, ANIM_WALK ; $501d
	script_face ACTOR_AWARDS_CEREMONY_ALEX, FACE_DOWN ; $5024
	script_face ACTOR_AWARDS_CEREMONY_WALK_74_07, FACE_DOWN ; $502b
	script_face ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, FACE_DOWN ; $5032
	script_face ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION, FACE_DOWN ; $5039
	script_player_speed 0.1875 ; $5040
	script_move_player 12.0, 19.0 ; $5046
	farcall WaitPlayerMoveDone ; $5050
	call AwardsCeremonyChairmanSpeech ; $5053
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 10.0, 19.0 ; $5056
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5061
	script_face ACTOR_AWARDS_CEREMONY_WALK_75_06, FACE_UP ; $5066
	script_set_speed ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 0.5 ; $506d
	script_set_speed ACTOR_AWARDS_CEREMONY_WALK_6F_06, 0.5 ; $5075
	script_set_speed ACTOR_AWARDS_CEREMONY_TROPHY_3, 0.5 ; $507d
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 17.0, 22.0 ; $5085
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $5090
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, FACE_DOWN ; $5095
	ld a, 20 ; $509c
	call DelayFrames ; $509e
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_2, 63.0, 63.0 ; $50a1
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_3, 17.0, 22.0 ; $50ac
	ld a, 20 ; $50b7
	call DelayFrames ; $50b9
	script_set_objdef OBJ_WALK_6F_07, ACTOR_AWARDS_CEREMONY_WALK_6F_06 ; $50bc
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_6F_06, ANIM_WALK ; $50c8
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 63.0, 63.0 ; $50cf
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_6F_06, 17.0, 22.0 ; $50da
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_3, 17.0, 21.0 ; $50e5
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_06, FACE_UP ; $50f0
	script_set_anim ACTOR_AWARDS_CEREMONY_TROPHY_3, ANIM_TROPHY_SMALL ; $50f7
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_3, 17.0, 18.0 ; $50fe
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_06, 17.0, 19.0 ; $5109
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_06 ; $5114
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_6F_06, 63.0, 63.0 ; $5119
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 17.0, 19.0 ; $5124
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_3, 16.0, 19.0 ; $512f
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, FACE_LEFT ; $513a
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 12.0, 19.0 ; $5141
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_3, 11.0, 19.0 ; $514c
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_3 ; $5157
	script_lock_facing ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $515c
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 15.0, 19.0 ; $5163
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $516e
	script_unlock_facing ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $5173
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 17.0, 22.0 ; $517a
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $5185
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, FACE_UP ; $518a
	script_set_text Text_25_185 ; $5191
	script_set_speed ACTOR_AWARDS_CEREMONY_WALK_75_06, 0.5 ; $5197
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 10.0, 17.0 ; $519f
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_3, 10.0, 16.0 ; $51aa
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_3 ; $51b5
	ld a, 30 ; $51ba
	call DelayFrames ; $51bc
	script_speak ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $51bf
	ld a, 30 ; $51c4
	call DelayFrames ; $51c6
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 10.0, 16.0 ; $51c9
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_3, 10.0, 15.0 ; $51d4
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_3 ; $51df
	ld a, 5 ; $51e4
	call DelayFrames ; $51e6
	script_set_anim ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, ANIM_BOUNCE ; $51e9
	script_wait_idle ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY ; $51f0
	script_lock_facing ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $51f5
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 10.0, 17.0 ; $51fc
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5207
	script_unlock_facing ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $520c
	script_face ACTOR_AWARDS_CEREMONY_WALK_75_06, FACE_UP ; $5213
	ld a, 50 ; $521a
	call DelayFrames ; $521c
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_3, 63.0, 63.0 ; $521f
	script_set_position ACTOR_AWARDS_CEREMONY_A_COZ, 12.5, 12.5 ; $522a
	sound SFX_APPEAR1 ; $5235
	ld a, 80 ; $5237
	call DelayFrames ; $5239
	script_set_position ACTOR_AWARDS_CEREMONY_A_COZ, 63.0, 63.0 ; $523c
	script_speak ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY ; $5247
	script_set_anim ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION, ANIM_BOUNCE ; $524c
	script_wait_idle ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION ; $5253
	script_speak ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION ; $5258
	script_set_position ACTOR_AWARDS_CEREMONY_B_COZ, 11.5, 15.5 ; $525d
	sound SFX_EMOTE ; $5268
	ld a, 120 ; $526a
	call DelayFrames ; $526c
	script_set_position ACTOR_AWARDS_CEREMONY_B_COZ, 63.0, 63.0 ; $526f
	script_set_anim ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, ANIM_SHAKE ; $527a
	script_wait_idle ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY ; $5281
	script_speak ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY ; $5286
	script_set_anim ACTOR_AWARDS_CEREMONY_ALEX, ANIM_BOUNCE ; $528b
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_74_07, ANIM_BOUNCE ; $5292
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_74_07 ; $5299
	script_face ACTOR_AWARDS_CEREMONY_ALEX, FACE_LEFT ; $529e
	script_face ACTOR_AWARDS_CEREMONY_WALK_74_07, FACE_LEFT ; $52a5
	ld a, 60 ; $52ac
	call DelayFrames ; $52ae
	script_face ACTOR_AWARDS_CEREMONY_ALEX, FACE_DOWN ; $52b1
	script_face ACTOR_AWARDS_CEREMONY_WALK_74_07, FACE_DOWN ; $52b8
	script_set_anim ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION, ANIM_BOUNCE ; $52bf
	script_wait_idle ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION ; $52c6
	script_speak ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION ; $52cb
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_75_06, ANIM_NOD ; $52d0
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $52d7
	script_speak ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $52dc
	ld a, 30 ; $52e1
	call DelayFrames ; $52e3
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 10.0, 19.0 ; $52e6
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $52f1
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 14.0, 19.0 ; $52f6
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5301
	script_face ACTOR_AWARDS_CEREMONY_WALK_75_06, FACE_UP ; $5306
	ld a, 20 ; $530d
	call DelayFrames ; $530f
	script_set_speed ACTOR_AWARDS_CEREMONY_TROPHY_1, 0.5 ; $5312
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 15.0, 22.0 ; $531a
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $5325
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, FACE_DOWN ; $532a
	ld a, 20 ; $5331
	call DelayFrames ; $5333
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_1, 15.5, 22.0 ; $5336
	ld a, 20 ; $5341
	call DelayFrames ; $5343
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 63.0, 63.0 ; $5346
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_6F_06, 15.0, 22.0 ; $5351
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_1, 15.0, 21.0 ; $535c
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_06, FACE_UP ; $5367
	script_set_anim ACTOR_AWARDS_CEREMONY_TROPHY_1, ANIM_TROPHY_SMALL ; $536e
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_1, 15.0, 19.0 ; $5375
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_06, 15.0, 20.0 ; $5380
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_06 ; $538b
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_6F_06, 63.0, 63.0 ; $5390
	script_set_position ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 15.0, 20.0 ; $539b
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, FACE_UP ; $53a6
	script_lock_facing ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $53ad
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, 15.0, 22.0 ; $53b4
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $53bf
	script_unlock_facing ACTOR_AWARDS_CEREMONY_WALK_6F_07_2 ; $53c4
	script_face ACTOR_AWARDS_CEREMONY_WALK_6F_07_2, FACE_UP ; $53cb
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_1, 14.75, 19.0 ; $53d2
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 15.0, 19.0 ; $53dd
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_1, 15.75, 19.0 ; $53e8
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_1 ; $53f3
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 15.0, 17.0 ; $53f8
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_1, 15.75, 17.0 ; $5403
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_1 ; $540e
	ld a, 30 ; $5413
	call DelayFrames ; $5415
	script_speak ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $5418
	ld a, 10 ; $541d
	call DelayFrames ; $541f
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_74_07, ANIM_NOD ; $5422
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_74_07 ; $5429
	script_speak ACTOR_AWARDS_CEREMONY_WALK_74_07 ; $542e
	ld a, 20 ; $5433
	call DelayFrames ; $5435
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_1, 14.25, 17.0 ; $5438
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 13.0, 17.0 ; $5443
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_1, 12.25, 17.0 ; $544e
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_1 ; $5459
	ld a, 4 ; $545e
	call DelayFrames ; $5460
	script_face ACTOR_AWARDS_CEREMONY_WALK_75_06, FACE_UP ; $5463
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_1, 13.0, 16.0 ; $546a
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_1 ; $5475
	ld a, 20 ; $547a
	call DelayFrames ; $547c
	script_speak ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $547f
	ld a, 30 ; $5484
	call DelayFrames ; $5486
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 13.0, 16.0 ; $5489
	script_move_target ACTOR_AWARDS_CEREMONY_TROPHY_1, 13.0, 14.5 ; $5494
	script_wait_move ACTOR_AWARDS_CEREMONY_TROPHY_1 ; $549f
	ld a, 5 ; $54a4
	call DelayFrames ; $54a6
	script_lock_facing ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $54a9
	script_move_target ACTOR_AWARDS_CEREMONY_WALK_75_06, 13.0, 17.0 ; $54b0
	script_wait_move ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $54bb
	script_unlock_facing ACTOR_AWARDS_CEREMONY_WALK_75_06 ; $54c0
	script_face ACTOR_AWARDS_CEREMONY_WALK_75_06, FACE_UP ; $54c7
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_6F_07_1, ANIM_BOUNCE ; $54ce
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_6F_07_1 ; $54d5
	script_speak ACTOR_AWARDS_CEREMONY_ALEX ; $54da
	script_set_anim ACTOR_AWARDS_CEREMONY_ALEX, ANIM_NOD ; $54df
	script_set_anim ACTOR_AWARDS_CEREMONY_WALK_74_07, ANIM_NOD ; $54e6
	script_wait_idle ACTOR_AWARDS_CEREMONY_WALK_74_07 ; $54ed
	script_speak ACTOR_AWARDS_CEREMONY_ALEX ; $54f2
	script_face ACTOR_AWARDS_CEREMONY_WALK_74_07, FACE_LEFT ; $54f7
	script_face ACTOR_AWARDS_CEREMONY_BALLOON_ANGRY, FACE_RIGHT ; $54fe
	script_face ACTOR_AWARDS_CEREMONY_BALLOON_QUESTION, FACE_RIGHT ; $5505
	ld a, 60 ; $550c
	call DelayFrames ; $550e
	ld a, [wStoryModeGenderOfMainCharacter] ; $5511
	ld d, OBJ_ALEX ; $5514
	add d ; $5516
	ld d, a ; $5517
	script_get_actor_state ACTOR_AWARDS_CEREMONY_ALEX ; $5518
	ld c, l ; $551d
	ld b, h ; $551e
	farcall LoadActorObjectDefIfValid ; $551f
	script_set_anim ACTOR_AWARDS_CEREMONY_ALEX, ANIM_WALK ; $5522
	script_face ACTOR_AWARDS_CEREMONY_ALEX, FACE_RIGHT ; $5529
	script_set_anim ACTOR_AWARDS_CEREMONY_ALEX, ANIM_DISTANT ; $5530
	script_set_position ACTOR_AWARDS_CEREMONY_TROPHY_1, 12.25, 12.375 ; $5537
	script_move_player 12.0, 13.0 ; $5542
	farcall WaitPlayerMoveDone ; $554c
	ld a, 180 ; $554f
	call DelayFrames ; $5551
	ld c, $01 ; $5554
	call BeginFadeOut ; $5556
	call WaitFadeEnd ; $5559
	ld b, $01 ; $555c
	ld a, [wStoryModeGenderOfMainCharacter] ; $555e
	ld d, a ; $5561
	sla a ; $5562
	ld c, a ; $5564
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $5565
	xor d ; $5568
	or c ; $5569
	ld c, a ; $556a
	farcall RunStorySceneByMode ; $556b
	ld a, STORYLOC_ACADEMY_WING ; $556e
	ld [wStoryModeCurrentLocation], a ; $5570
	ld a, $0f ; $5573
	ld [wStoryModeEntryPoint], a ; $5575
	ld a, $ff ; $5578
	ld [wUnusedExitTriggerIdMirror], a ; $557a
	ld [wStoryModeExitTriggerRequest], a ; $557d
	ret ; $5580
AwardsCeremonyInitScript_0f:
	test_flag FLAG_DOUBLES ; $5581
	jr z, .setAnims ; $5584
	ldh a, [hRomBank] ; $5586
	ld hl, AwardsCeremonyActorsDoubles_0f ; $5588
	farcall ScriptRespawnLocationActors ; $558b
	ld hl, AwardsCeremonyNpcScriptsDoubles_0f ; $558e
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $5591
	farcall WriteStoryStateWord ; $5594
	script_copy_scene_rect 26, 13, 8, 13, 8, 3 ; $5597
	farcall BeginCutsceneScriptMode ; $55a6
.setAnims:
	script_set_anim ACTOR_AWARDS_CEREMONY_DOUBLES_TROPHY_2, ANIM_TROPHY_SMALL ; $55a9
	script_set_anim ACTOR_AWARDS_CEREMONY_DOUBLES_TROPHY_3, ANIM_TROPHY_SMALL ; $55b0
	test_flag FLAG_DOUBLES ; $55b7
	jr nz, .setObjectDefs ; $55ba
	script_set_anim ACTOR_AWARDS_CEREMONY_DOUBLES_TROPHY_1, ANIM_TROPHY_SINGLES ; $55bc
.setObjectDefs:
	call SetPlayerAndPartnerObjectDefs ; $55c3
	ld a, [wStoryModeEntryPoint] ; $55c6
	cp $0a ; $55c9
	jp z, AwardsCeremonyEntry0aScene ; $55cb
	cp $0b ; $55ce
	jp z, AwardsCeremonyEntry0bScene ; $55d0
	call CheckAwardsCeremonyRivalSceneDone ; $55d3
	and $01 ; $55d6
	jr z, .checkDoubles ; $55d8
	script_move_target ACTOR_AWARDS_CEREMONY_DOUBLES_SPIKE, 9.0, 29.0 ; $55da
	script_wait_move ACTOR_AWARDS_CEREMONY_DOUBLES_SPIKE ; $55e5
	script_face ACTOR_AWARDS_CEREMONY_DOUBLES_SPIKE, FACE_RIGHT ; $55ea
	ld b, $0a ; $55f1
	ld c, $1c ; $55f3
	ld d, $0a ; $55f5
	ld e, $1a ; $55f7
	ld h, $04 ; $55f9
	ld l, $02 ; $55fb
	farcall CopyBehaviorMapRect ; $55fd
.checkDoubles:
	test_flag FLAG_DOUBLES ; $5600
	jp nz, .done ; $5603
	call SavePlayerActorPosition ; $5606
	ld hl, wMapScratch ; $5609
	ld a, [hl+] ; $560c
	ld b, [hl] ; $560d
	ld c, a ; $560e
	ld hl, wMapScratch + 2 ; $560f
	ld a, [hl+] ; $5612
	ld d, [hl] ; $5613
	ld e, a ; $5614
	ld a, $03 ; $5615
	farcall ScriptSetActorPosition ; $5617
	script_get_actor_state ACTOR_AWARDS_CEREMONY_DOUBLES_WALK_74_08 ; $561a
	ld c, l ; $561f
	ld b, h ; $5620
	ld de, wActors ; $5621
	farcall AttachActorStepMover ; $5624
.done:
	ret ; $5627
