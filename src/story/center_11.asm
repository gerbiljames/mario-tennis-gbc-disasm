DataPtr_CenterCourtMapScripts_11:
	dw CenterCourtMapScripts_11 ; $4000
DataPtr_AcademyArrivalMapScripts_11:
	dw AcademyArrivalMapScripts_11 ; $4002
DataPtr_JuniorClassCourtDoublesMapScripts_11:
	dw JuniorClassCourtDoublesMapScripts_11 ; $4004
DataPtr_JuniorClassCourtSinglesMapScripts_11:
	dw JuniorClassCourtSinglesMapScripts_11 ; $4006
CenterCourtMapScripts_11:
	; $4008, 14 bytes (map_tree)
	dw CenterCourtEntryPoints_11 ; slot 0 EntryPoints
	dw CenterCourtExitTriggers_11 ; slot 1 ExitTriggers
	dw CenterCourtActors_11 ; slot 2 Actors
	dw CenterCourtNpcScripts_11 ; slot 3 NpcScripts
	dw CenterCourtFacingScripts_11 ; slot 4 FacingScripts
	dw CenterCourtTileTriggers_11 ; slot 5 TileTriggers
	dw CenterCourtInitScript_11 ; slot 6 InitScript
CenterCourtActors_11:
	; $4016, 66 bytes (map_actors)
	map_actor $0000, ActorScript_11_45, $0f00, $2e00, FACE_LEFT, OBJ_WALK_6F_07, $01, $00, CENTER_COURT_WALK_6F_07_1
	map_actor $0000, ActorScript_11_45, $0d00, $1300, FACE_DOWN, OBJ_WALK_6F_07, $01, $00, CENTER_COURT_WALK_6F_07_2
	map_actor $0000, ActorScript_11_45, $1f00, $2e00, FACE_RIGHT, OBJ_WALK_72_02, $01, $07, CENTER_COURT_WALK_72_02
	map_actor $0000, ActorScript_11_45, $2100, $2e00, FACE_LEFT, OBJ_WALK_71_05, $01, $07, CENTER_COURT_WALK_71_05
	map_actor_end
CenterCourtEntryPoints_11:
	; $4058, 25 bytes (map_entries)
	map_entry $01, FACE_UP, $0c00, $3100, $0000
	map_entry $02, FACE_UP, $2400, $3100, $0000
	map_entry $0f, FACE_UP, $0c00, $3100, $0000
	db $ff
CenterCourtExitTriggers_11:
	; $4071, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_11, STORYLOC_TOURNAMENT, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_11, STORYLOC_TOURNAMENT, $02
	db $ff
CenterCourtNpc03_11:
	script_set_text Text_1f_80 ; $4082
	test_flag FLAG_DOUBLES ; $4088
	jr nz, .isDoubles ; $408b
	ld a, [wMapSceneStage] ; $408d
	cp ISLANDOPENSTAGE_SINGLES_FINAL ; $4090
	jr nz, .speak ; $4092
	script_set_text Text_1f_91 ; $4094
	jr .speak ; $409a
.isDoubles:
	ld a, [wMapSceneStage] ; $409c
	cp ISLANDOPENSTAGE_DOUBLES_FINAL ; $409f
	jr nz, .speak ; $40a1
	script_set_text Text_1f_91 ; $40a3
.speak:
	script_speak ACTOR_CENTER_COURT_WALK_6F_07_1 ; $40a9
	ret ; $40ae
CenterCourtNpc04_11:
	test_flag FLAG_DOUBLES ; $40af
	jr z, .altText ; $40b2
	script_set_text Text_1f_96 ; $40b4
	ld a, [wMapSceneStage] ; $40ba
	cp ISLANDOPENSTAGE_DOUBLES_FINAL ; $40bd
	jr nz, .done ; $40bf
	script_set_text Text_1f_101 ; $40c1
	jr .done ; $40c7
.altText:
	script_set_text Text_1f_81 ; $40c9
	ld a, $04 ; $40cf
	farcall ScriptShowSpeakerDialogueRestoreBG ; $40d1
	farcall RunDialogueYesNoPrompt ; $40d4
	farcall ScriptCloseDialogueWindow ; $40d7
	script_wait_frames $05 ; $40da
	and a ; $40e1
	jr z, .speak ; $40e2
	farcall AdvanceDialogueTextCursor ; $40e4
	script_speak ACTOR_CENTER_COURT_WALK_6F_07_2 ; $40e7
	ret ; $40ec
.speak:
	ld a, [wMapSceneStage] ; $40ed
	cp ISLANDOPENSTAGE_SINGLES_FINAL ; $40f0
	jr nz, .done ; $40f2
	farcall AdvanceDialogueTextCursor ; $40f4
	farcall AdvanceDialogueTextCursor ; $40f7
.done:
	script_speak ACTOR_CENTER_COURT_WALK_6F_07_2 ; $40fa
	ret ; $40ff
CenterCourtNpc05_11:
	ld a, [wMapSceneStage] ; $4100
	add a ; $4103
	ld_hl_indexed CenterCourtNpc05TextIds ; $4104
	ld a, [hl+] ; $410b
	ld h, [hl] ; $410c
	ld l, a ; $410d
	farcall InitDialogueTextCursor ; $410e
	ld a, [wMapSceneStage] ; $4111
	cp ISLANDOPENSTAGE_SINGLES_FINAL ; $4114
	jr z, .eq03 ; $4116
	script_speak ACTOR_CENTER_COURT_WALK_72_02 ; $4118
	ret ; $411d
.eq03:
	ld a, $05 ; $411e
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4120
	farcall RunDialogueYesNoPrompt ; $4123
	farcall ScriptCloseDialogueWindow ; $4126
	script_wait_frames $05 ; $4129
	and a ; $4130
	jr z, .speak ; $4131
	farcall AdvanceDialogueTextCursor ; $4133
.speak:
	script_speak ACTOR_CENTER_COURT_WALK_72_02 ; $4136
	ret ; $413b
CenterCourtNpc05TextIds:
	; $413c, 14 bytes (text_ids)
	dw Text_1f_85 ; record 0
	dw Text_1f_87 ; record 1
	dw Text_1f_89 ; record 2
	dw Text_1f_92 ; record 3
	dw Text_1f_97 ; record 4
	dw Text_1f_99 ; record 5
	dw Text_1f_102 ; record 6
CenterCourtNpc06_11:
	ld a, [wMapSceneStage] ; $414a
	add a ; $414d
	ld_hl_indexed CenterCourtNpc06TextIds ; $414e
	ld a, [hl+] ; $4155
	ld h, [hl] ; $4156
	ld l, a ; $4157
	farcall InitDialogueTextCursor ; $4158
	script_speak ACTOR_CENTER_COURT_WALK_72_02 ; $415b
	ret ; $4160
CenterCourtNpc06TextIds:
	; $4161, 14 bytes (text_ids)
	dw Text_1f_86 ; record 0
	dw Text_1f_88 ; record 1
	dw Text_1f_90 ; record 2
	dw Text_1f_95 ; record 3
	dw Text_1f_98 ; record 4
	dw Text_1f_100 ; record 5
	dw Text_1f_103 ; record 6
CenterCourtNpcScripts_11:
	; $416f, 33 bytes (map_scripts)
	map_script ACTOR_CENTER_COURT_WALK_6F_07_1, FACEMASK_ANY, $0000, CenterCourtNpc03_11, $03, $00
	map_script ACTOR_CENTER_COURT_WALK_6F_07_2, FACEMASK_ANY, $0000, CenterCourtNpc04_11, $03, $00
	map_script ACTOR_CENTER_COURT_WALK_72_02, FACEMASK_ANY, $0000, CenterCourtNpc05_11, $03, $00
	map_script ACTOR_CENTER_COURT_WALK_71_05, FACEMASK_ANY, $0000, CenterCourtNpc06_11, $03, $00
	db $ff
CenterCourtFacingScripts_11:
	; $4190, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, CenterCourtFacing01_11, $00, $00
	db $ff
CenterCourtFacing01_11:
	ret ; $4199
CenterCourtTileTriggers_11:
	; $419a, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, CenterCourtTile01_11, $00, $00
	db $ff
CenterCourtTile01_11:
	ret ; $41a3
CenterCourtInitScript_11:
	call SetupCenterCourtSceneVariant ; $41a4
	call SetPlayerAndPartnerObjectDefs_11 ; $41a7
	ld a, [wStoryModeEntryPoint] ; $41aa
	cp $0f ; $41ad
	jp z, SetPlayerAndPartnerObjectDefs_11.placeActors ; $41af
	call MapArrivalWalk_11 ; $41b2
	ret ; $41b5
SetupCenterCourtSceneVariant:
	ld a, ISLANDOPENSTAGE_SINGLES_ROUND1 ; $41b6
	ld [wMapSceneStage], a ; $41b8
	test_flag FLAG_DOUBLES ; $41bb
	jr nz, .doneEarly ; $41be
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; $41c0
	jr z, .stage1 ; $41c3
	ld a, ISLANDOPENSTAGE_SINGLES_FINAL ; $41c5
	ld [wMapSceneStage], a ; $41c7
	ldh a, [hRomBank] ; $41ca
	ld hl, CenterCourtSceneVariantActors_11 ; $41cc
	farcall ScriptRespawnLocationActors ; $41cf
	farcall BeginCutsceneScriptMode ; $41d2
	ret ; $41d5
.stage1:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $41d6
	jr z, .stage2 ; $41d9
	ld a, ISLANDOPENSTAGE_SINGLES_SEMIFINAL ; $41db
	ld [wMapSceneStage], a ; $41dd
	ret ; $41e0
.stage2:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; $41e1
	jr z, .stage3 ; $41e4
	ld a, ISLANDOPENSTAGE_SINGLES_ROUND2 ; $41e6
	ld [wMapSceneStage], a ; $41e8
.stage3:
	ret ; $41eb
.doneEarly:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $41ec
	jr z, .stage4 ; $41ef
	ld a, ISLANDOPENSTAGE_DOUBLES_FINAL ; $41f1
	ld [wMapSceneStage], a ; $41f3
	ldh a, [hRomBank] ; $41f6
	ld hl, CenterCourtSceneVariantActors_11 ; $41f8
	farcall ScriptRespawnLocationActors ; $41fb
	farcall BeginCutsceneScriptMode ; $41fe
	ret ; $4201
.stage4:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 ; $4202
	jr z, .done ; $4205
	ld a, ISLANDOPENSTAGE_DOUBLES_SEMIFINAL ; $4207
	ld [wMapSceneStage], a ; $4209
	ret ; $420c
.done:
	ld a, ISLANDOPENSTAGE_DOUBLES_ROUND1 ; $420d
	ld [wMapSceneStage], a ; $420f
	ret ; $4212
CenterCourtSceneVariantActors_11:
	; $4213, 234 bytes (map_actors)
	map_actor $0000, ActorScript_11_45, $0f00, $2e00, FACE_LEFT, OBJ_WALK_6F_07, $01, $00, CENTER_COURT_SCENE_VARIANT_WALK_6F_07_1
	map_actor $0000, ActorScript_11_45, $0d00, $2700, FACE_DOWN, OBJ_WALK_6F_07, $01, $00, CENTER_COURT_SCENE_VARIANT_WALK_6F_07_2
	map_actor $0000, ActorScript_11_45, $2500, $2400, FACE_LEFT, OBJ_WALK_72_02, $01, $07, CENTER_COURT_SCENE_VARIANT_WALK_72_02_1
	map_actor $0000, ActorScript_11_45, $2300, $2100, FACE_LEFT, OBJ_WALK_71_05, $01, $07, CENTER_COURT_SCENE_VARIANT_WALK_71_05
	map_actor $0000, ActorScript_11_45, $2700, $2300, FACE_LEFT, OBJ_WALK_6F_05, $01, $04, CENTER_COURT_SCENE_VARIANT_WALK_6F_05
	map_actor $0000, ActorScript_11_45, $2700, $2100, FACE_LEFT, OBJ_WALK_72_02, $01, $06, CENTER_COURT_SCENE_VARIANT_WALK_72_02_2
	map_actor $0000, ActorScript_11_45, $2500, $2000, FACE_LEFT, OBJ_WALK_72_03, $01, $03, CENTER_COURT_SCENE_VARIANT_WALK_72_03_1
	map_actor $0000, ActorScript_11_45, $0b00, $2400, FACE_RIGHT, OBJ_WALK_71_06, $01, $00, CENTER_COURT_SCENE_VARIANT_WALK_71_06_1
	map_actor $0000, ActorScript_11_45, $0d00, $2100, FACE_RIGHT, OBJ_WALK_72_03, $01, $04, CENTER_COURT_SCENE_VARIANT_WALK_72_03_2
	map_actor $0000, ActorScript_11_45, $0900, $2300, FACE_RIGHT, OBJ_WALK_72_02, $01, $03, CENTER_COURT_SCENE_VARIANT_WALK_72_02_3
	map_actor $0000, ActorScript_11_45, $0500, $2000, FACE_RIGHT, OBJ_WALK_72_02, $01, $06, CENTER_COURT_SCENE_VARIANT_WALK_72_02_4
	map_actor $0000, ActorScript_11_45, $0900, $2100, FACE_RIGHT, OBJ_WALK_72_03, $01, $03, CENTER_COURT_SCENE_VARIANT_WALK_72_03_3
	map_actor $0000, ActorScript_11_45, $2b00, $2200, FACE_LEFT, OBJ_WALK_71_06, $01, $00, CENTER_COURT_SCENE_VARIANT_WALK_71_06_2
	map_actor $0000, ActorScript_11_45, $2b00, $2000, FACE_LEFT, OBJ_WALK_72_03, $01, $04, CENTER_COURT_SCENE_VARIANT_WALK_72_03_4
	map_actor $0000, ActorScript_11_45, $2b00, $1e00, FACE_LEFT, OBJ_BETH, $01, $00, CENTER_COURT_SCENE_VARIANT_BETH
	map_actor $0000, ActorScript_11_45, $2700, $1d00, FACE_LEFT, OBJ_PAM, $01, $04, CENTER_COURT_SCENE_VARIANT_PAM
	map_actor_end
; Instruction-identical to AcademyMainBldgArrival01_10, RestaurantArrival01_10, DormEntranceArrival01_12 and RestaurantPlazaArrival04_13 (one copy per bank); a change here belongs in every copy.
	twin_named academy_main_bldg_arrival01, MapArrivalWalk_11 ; $42fd
SetPlayerAndPartnerObjectDefs_11:
	test_flag FLAG_DOUBLES ; $4343
	jp z, .notDoubles ; $4346
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $4349
	ld d, OBJ_HARRY_B ; $434c
	add d ; $434e
	ld d, a ; $434f
	script_get_actor_state ACTOR_PARTNER ; $4350
	ld c, l ; $4355
	ld b, h ; $4356
	farcall LoadActorObjectDefIfValid ; $4357
	script_set_anim ACTOR_PARTNER, $01 ; $435a
.notDoubles:
	ld a, [wStoryModeGenderOfMainCharacter] ; $4361
	ld d, OBJ_ALEX_B ; $4364
	add d ; $4366
	ld d, a ; $4367
	script_get_actor_state ACTOR_PLAYER ; $4368
	ld c, l ; $436d
	ld b, h ; $436e
	farcall LoadActorObjectDefIfValid ; $436f
	script_set_anim ACTOR_PLAYER, $01 ; $4372
	ret ; $4379
.placeActors:
	script_set_position $0a, $2500, $2400 ; $437a
	test_flag FLAG_DOUBLES ; $4385
	jr z, .notDoubles2 ; $4388
	script_set_position ACTOR_PARTNER, $0c00, $3300 ; $438a
.notDoubles2:
	xor a ; $4395
	ld [wStoryModeShowLocationName], a ; $4396
	script_fade_in $04 ; $4399
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_00 ; $439e
	script_wait_frames $50 ; $43a9
	script_set_anim ACTOR_PLAYER, $03 ; $43b0
	script_wait_idle ACTOR_PLAYER ; $43b7
	script_wait_frames $1e ; $43bc
	script_wait_actor_script ACTOR_PLAYER ; $43c3
	script_move_player $2300, $2400 ; $43c8
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_01 ; $43d2
	script_wait_frames $f0 ; $43dd
	ld a, $01 ; $43e4
	ld [wUnusedExitTriggerIdMirror], a ; $43e6
	ld [wStoryModeExitTriggerRequest], a ; $43e9
	ret ; $43ec
ActorScript_11_00:
	; $43ed, 7 bytes (actor_script)
	as_set_target $0c00, $2b00
	as_wait_move
	as_halt
ActorScript_11_01:
	; $43f4, 13 bytes (actor_script)
	as_set_target $2300, $2b00
	as_wait_move
	as_set_target $2300, $2400
	as_wait_move
	as_halt
AcademyArrivalMapScripts_11:
	; $4401, 14 bytes (map_tree)
	dw AcademyArrivalEntryPoints_11 ; slot 0 EntryPoints
	dw AcademyArrivalExitTriggers_11 ; slot 1 ExitTriggers
	dw AcademyArrivalActors_11 ; slot 2 Actors
	dw AcademyArrivalNpcScripts_11 ; slot 3 NpcScripts
	dw AcademyArrivalFacingScripts_11 ; slot 4 FacingScripts
	dw AcademyArrivalTileTriggers_11 ; slot 5 TileTriggers
	dw AcademyArrivalInitScript_11 ; slot 6 InitScript
AcademyArrivalActors_11:
	; $440f, 262 bytes (map_actors)
	map_actor $0000, ActorScript_11_46, $1900, $1900, FACE_DOWN, OBJ_WALK_71_03, $01, $05, ACADEMY_ARRIVAL_WALK_71_03_1
	map_actor $0000, ActorScript_11_45, $1500, $2500, FACE_LEFT, OBJ_WALK_71_05, $01, $00, ACADEMY_ARRIVAL_WALK_71_05
	map_actor $0000, ActorScript_11_45, $1500, $2700, FACE_LEFT, OBJ_WALK_72_02, $01, $00, ACADEMY_ARRIVAL_WALK_72_02
	map_actor $0000, ActorScript_11_48, $0100, $1c00, FACE_DOWN, OBJ_WALK_74_00, $01, $03, ACADEMY_ARRIVAL_WALK_74_00_1
	map_actor $0000, ActorScript_11_49, $0500, $2800, FACE_UP, OBJ_WALK_74_00, $01, $04, ACADEMY_ARRIVAL_WALK_74_00_2
	map_actor $0000, ActorScript_11_50, $0a00, $1c00, FACE_DOWN, OBJ_WALK_74_00, $01, $07, ACADEMY_ARRIVAL_WALK_74_00_3
	map_actor $0000, ActorScript_11_51, $0f00, $2800, FACE_UP, OBJ_WALK_74_00, $01, $06, ACADEMY_ARRIVAL_WALK_74_00_4
	map_actor $0000, ActorScript_11_48, $2200, $1c00, FACE_DOWN, OBJ_WALK_74_00, $01, $06, ACADEMY_ARRIVAL_WALK_74_00_5
	map_actor $0000, ActorScript_11_49, $2600, $2800, FACE_UP, OBJ_WALK_74_00, $01, $03, ACADEMY_ARRIVAL_WALK_74_00_6
	map_actor $0000, ActorScript_11_50, $2c00, $1c00, FACE_DOWN, OBJ_WALK_74_00, $01, $07, ACADEMY_ARRIVAL_WALK_74_00_7
	map_actor $0000, ActorScript_11_51, $3000, $2800, FACE_UP, OBJ_WALK_74_00, $01, $04, ACADEMY_ARRIVAL_WALK_74_00_8
	map_actor $0000, ActorScript_11_45, $1500, $3d00, FACE_RIGHT, OBJ_WALK_73_13, $01, $00, ACADEMY_ARRIVAL_WALK_73_13
	map_actor $0000, ActorScript_11_45, $1500, $3d00, FACE_RIGHT, OBJ_WALK_73_12, $01, $00, ACADEMY_ARRIVAL_WALK_73_12
	map_actor $0000, ActorScript_11_45, $1500, $3d00, FACE_RIGHT, OBJ_WALK_73_19, $01, $00, ACADEMY_ARRIVAL_WALK_73_19
	map_actor $0000, ActorScript_11_45, $1500, $3d00, FACE_DOWN, OBJ_WALK_75_06, $01, $00, ACADEMY_ARRIVAL_WALK_75_06
	map_actor $0000, ActorScript_11_45, $1500, $3d00, FACE_DOWN, OBJ_EMILY, $01, $00, ACADEMY_ARRIVAL_EMILY
	map_actor $0000, ActorScript_11_45, $1500, $3d00, FACE_RIGHT, OBJ_WALK_73_15, $01, $00, ACADEMY_ARRIVAL_WALK_73_15
	map_actor $0000, ActorScript_11_45, $1800, $3300, FACE_UP, OBJ_WALK_71_03, $01, $03, ACADEMY_ARRIVAL_WALK_71_03_2
	map_actor_end
AcademyArrivalEntryPoints_11:
	; $4515, 33 bytes (map_entries)
	map_entry $01, FACE_DOWN, $1800, $1100, AcademyArrivalArrival01_11
	map_entry $02, FACE_UP, $1800, $3300, MapArrivalWalk_11
	map_entry $0c, FACE_DOWN, $1800, $2f00, $0000
	map_entry $0f, FACE_UP, $1800, $2f00, $0000
	db $ff
; Instruction-identical to AcademyMainBldgArrival02_10 and DormEntranceArrival02_12 (one copy per bank); a change here belongs in every copy.
	twin_named academy_main_bldg_arrival02, AcademyArrivalArrival01_11 ; $4536
AcademyArrivalExitTriggers_11:
	; $457c, 33 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_11, STORYLOC_ACADEMY_MAIN_BLDG, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_11, STORYLOC_ISLAND_SKY, $01
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_11, STORYLOC_ISLAND_SKY, $0f
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_11, STORYLOC_ACADEMY_MAIN_BLDG, $0f
	db $ff
AcademyArrivalNpc03_11:
	ld a, [wMapSceneStage] ; $459d
	add a ; $45a0
	ld_hl_indexed AcademyArrivalNpc03TextIds ; $45a1
	ld a, [hl+] ; $45a8
	ld h, [hl] ; $45a9
	ld l, a ; $45aa
	farcall InitDialogueTextCursor ; $45ab
	ld a, [wMapSceneStage] ; $45ae
	cp STORYRANK_SINGLES_COMPLETE ; $45b1
	jr nc, .altText ; $45b3
	cp STORYRANK_SINGLES_SENIOR_CHAMP ; $45b5
	jr nc, .speak ; $45b7
	cp STORYRANK_SINGLES_JUNIOR_CHAMP ; $45b9
	jr c, .speak ; $45bb
.altText:
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_71_03_1 ; $45bd
	ret ; $45c2
.speak:
	ld a, $03 ; $45c3
	farcall ScriptShowSpeakerDialogueRestoreBG ; $45c5
	farcall RunDialogueYesNoPrompt ; $45c8
	farcall ScriptCloseDialogueWindow ; $45cb
	script_wait_frames $05 ; $45ce
	and a ; $45d5
	jr z, .done ; $45d6
	farcall AdvanceDialogueTextCursor ; $45d8
.done:
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_71_03_1 ; $45db
	ret ; $45e0
AcademyArrivalNpc03TextIds:
	; $45e1, 20 bytes (text_ids)
	dw Text_36_54 ; record 0
	dw Text_36_57 ; record 1
	dw Text_36_63 ; record 2
	dw Text_36_63 ; record 3
	dw Text_36_66 ; record 4
	dw Text_36_66 ; record 5
	dw Text_36_71 ; record 6
	dw Text_36_71 ; record 7
	dw Text_36_76 ; record 8
	dw Text_36_76 ; record 9
AcademyArrivalNpc04_11:
	ld a, [wMapSceneStage] ; $45f5
	add a ; $45f8
	ld_hl_indexed AcademyArrivalNpc04TextIds ; $45f9
	ld a, [hl+] ; $4600
	ld h, [hl] ; $4601
	ld l, a ; $4602
	farcall InitDialogueTextCursor ; $4603
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_71_05 ; $4606
	ret ; $460b
AcademyArrivalNpc04TextIds:
	; $460c, 20 bytes (text_ids)
	dw Text_36_60 ; record 0
	dw Text_36_61 ; record 1
	dw Text_36_64 ; record 2
	dw Text_36_64 ; record 3
	dw Text_36_69 ; record 4
	dw Text_36_69 ; record 5
	dw Text_36_74 ; record 6
	dw Text_36_74 ; record 7
	dw Text_36_77 ; record 8
	dw Text_36_77 ; record 9
AcademyArrivalNpc05_11:
	ld a, [wMapSceneStage] ; $4620
	sra a ; $4623
	add a ; $4625
	ld_hl_indexed AcademyArrivalNpc05TextIds ; $4626
	ld a, [hl+] ; $462d
	ld h, [hl] ; $462e
	ld l, a ; $462f
	farcall InitDialogueTextCursor ; $4630
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_72_02 ; $4633
	ret ; $4638
AcademyArrivalNpc05TextIds:
	; $4639, 10 bytes (text_ids)
	dw Text_36_62 ; record 0
	dw Text_36_65 ; record 1
	dw Text_36_70 ; record 2
	dw Text_36_75 ; record 3
	dw Text_36_78 ; record 4
AcademyArrivalNpc14_11:
	script_set_text Text_36_96 ; $4643
	test_flag FLAG_DOUBLES ; $4649
	jr nz, .checkFlag ; $464c
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $464e
	jr z, .loop ; $4651
	farcall AdvanceDialogueTextCursor ; $4653
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $4656
	jr z, .loop ; $4659
	farcall AdvanceDialogueTextCursor ; $465b
.loop:
	script_set_anim ACTOR_ACADEMY_ARRIVAL_WALK_71_03_2, $04 ; $465e
	script_wait_idle ACTOR_ACADEMY_ARRIVAL_WALK_71_03_2 ; $4665
	script_speak ACTOR_ACADEMY_ARRIVAL_WALK_71_03_2 ; $466a
	ret ; $466f
.checkFlag:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $4670
	jr z, .loop ; $4673
	farcall AdvanceDialogueTextCursor ; $4675
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $4678
	jr z, .loop ; $467b
	farcall AdvanceDialogueTextCursor ; $467d
	jr .loop ; $4680
AcademyArrivalNpcScripts_11:
	; $4682, 33 bytes (map_scripts)
	map_script ACTOR_ACADEMY_ARRIVAL_WALK_71_03_1, FACEMASK_ANY, $0000, AcademyArrivalNpc03_11, $13, $00
	map_script ACTOR_ACADEMY_ARRIVAL_WALK_71_05, FACEMASK_ANY, $0000, AcademyArrivalNpc04_11, $01, $00
	map_script ACTOR_ACADEMY_ARRIVAL_WALK_72_02, FACEMASK_ANY, $0000, AcademyArrivalNpc05_11, $01, $00
	map_script ACTOR_ACADEMY_ARRIVAL_WALK_71_03_2, FACEMASK_ANY, $0000, AcademyArrivalNpc14_11, $03, $00
	db $ff
AcademyArrivalFacingScripts_11:
	ds 1, $ff ; $46a3, fill
AcademyArrivalTileTriggers_11:
	; $46a4, 9 bytes (map_scripts)
	map_script $0f, FACEMASK_ANY, $0000, AcademyArrivalTile0F_11, $00, $00
	db $ff
AcademyArrivalTile0F_11:
	call ResumeAcademyGuideTour ; $46ad
	ret ; $46b0
AcademyArrivalInitScript_11:
	call ComputeRankingProgressIndex_11 ; $46b1
	call EnableAcademyCampusExit ; $46b4
	call MoveCampusGateGuardAside ; $46b7
	ld a, [wStoryModeEntryPoint] ; $46ba
	cp $0a ; $46bd
	jp z, AcademyArrivalInitScriptActorListEnd_11.scriptRespawnLocationActors ; $46bf
	cp $0c ; $46c2
	jp z, ActorList_11_0.scriptRespawnLocationActors2 ; $46c4
	cp $0f ; $46c7
	jr nz, .done ; $46c9
	call LateStudentCrashCutscene ; $46cb
.done:
	ret ; $46ce
