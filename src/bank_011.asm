SECTION "ROM Bank $11", ROMX[$4000], BANK[$11]

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
	map_actor $0000, ActorScript_11_7ba9, $0f00, $2e00, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $0d00, $1300, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $1f00, $2e00, FACE_RIGHT, $39, $01, $07
	map_actor $0000, ActorScript_11_7ba9, $2100, $2e00, FACE_LEFT, $32, $01, $07
	map_actor_end
CenterCourtEntryPoints_11:
	; $4058, 25 bytes (map_entries)
	map_entry $01, FACE_UP, $0c00, $3100, $0000
	map_entry $02, FACE_UP, $2400, $3100, $0000
	map_entry $0f, FACE_UP, $0c00, $3100, $0000
	db $ff
CenterCourtExitTriggers_11:
	; $4071, 17 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_11, $19, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_11, $19, $02
	db $ff
CenterCourtNpc03_11:
	script_set_text Text_1f_80 ; $4082
	test_flag FLAG_DOUBLES ; $4088
	jr nz, .isDoubles ; $408b
	ld a, [$c2b0] ; $408d
	cp a, $03 ; $4090
	jr nz, .speak ; $4092
	script_set_text Text_1f_91 ; $4094
	jr .speak ; $409a
.isDoubles:
	ld a, [$c2b0] ; $409c
	cp a, $06 ; $409f
	jr nz, .speak ; $40a1
	script_set_text Text_1f_91 ; $40a3
.speak:
	script_speak $03 ; $40a9
	ret ; $40ae
CenterCourtNpc04_11:
	test_flag FLAG_DOUBLES ; $40af
	jr z, .altText ; $40b2
	script_set_text Text_1f_96 ; $40b4
	ld a, [$c2b0] ; $40ba
	cp a, $06 ; $40bd
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
	and a, a ; $40e1
	jr z, .speak ; $40e2
	farcall AdvanceDialogueTextCursor ; $40e4
	script_speak $04 ; $40e7
	ret ; $40ec
.speak:
	ld a, [$c2b0] ; $40ed
	cp a, $03 ; $40f0
	jr nz, .done ; $40f2
	farcall AdvanceDialogueTextCursor ; $40f4
	farcall AdvanceDialogueTextCursor ; $40f7
.done:
	script_speak $04 ; $40fa
	ret ; $40ff
CenterCourtNpc05_11:
	ld a, [$c2b0] ; $4100
	add a, a ; $4103
	add a, $3c ; $4104
	ld l, a ; $4106
	adc a, $41 ; $4107
	sub a, l ; $4109
	ld h, a ; $410a
	ld a, [hl+] ; $410b
	ld h, [hl] ; $410c
	ld l, a ; $410d
	farcall InitDialogueTextCursor ; $410e
	ld a, [$c2b0] ; $4111
	cp a, $03 ; $4114
	jr z, .eq03 ; $4116
	script_speak $05 ; $4118
	ret ; $411d
.eq03:
	ld a, $05 ; $411e
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4120
	farcall RunDialogueYesNoPrompt ; $4123
	farcall ScriptCloseDialogueWindow ; $4126
	script_wait_frames $05 ; $4129
	and a, a ; $4130
	jr z, .speak ; $4131
	farcall AdvanceDialogueTextCursor ; $4133
.speak:
	script_speak $05 ; $4136
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
	ld a, [$c2b0] ; $414a
	add a, a ; $414d
	add a, $61 ; $414e
	ld l, a ; $4150
	adc a, $41 ; $4151
	sub a, l ; $4153
	ld h, a ; $4154
	ld a, [hl+] ; $4155
	ld h, [hl] ; $4156
	ld l, a ; $4157
	farcall InitDialogueTextCursor ; $4158
	script_speak $05 ; $415b
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
	map_script $03, FACEMASK_ANY, $0000, CenterCourtNpc03_11, $03, $00
	map_script $04, FACEMASK_ANY, $0000, CenterCourtNpc04_11, $03, $00
	map_script $05, FACEMASK_ANY, $0000, CenterCourtNpc05_11, $03, $00
	map_script $06, FACEMASK_ANY, $0000, CenterCourtNpc06_11, $03, $00
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
	cp a, $0f ; $41ad
	jp z, SetPlayerAndPartnerObjectDefs_11.placeActors ; $41af
	call MapArrivalWalk_11 ; $41b2
	ret ; $41b5
SetupCenterCourtSceneVariant:
	ld a, $00 ; $41b6
	ld [$c2b0], a ; $41b8
	test_flag FLAG_DOUBLES ; $41bb
	jr nz, .doneEarly ; $41be
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; $41c0
	jr z, .stage1 ; $41c3
	ld a, $03 ; $41c5
	ld [$c2b0], a ; $41c7
	ldh a, [hRomBank] ; $41ca
	ld hl, $4213 ; $41cc
	farcall ScriptRespawnLocationActors ; $41cf
	farcall BeginCutsceneScriptMode ; $41d2
	ret ; $41d5
.stage1:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $41d6
	jr z, .stage2 ; $41d9
	ld a, $02 ; $41db
	ld [$c2b0], a ; $41dd
	ret ; $41e0
.stage2:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; $41e1
	jr z, .stage3 ; $41e4
	ld a, $01 ; $41e6
	ld [$c2b0], a ; $41e8
.stage3:
	ret ; $41eb
.doneEarly:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $41ec
	jr z, .stage4 ; $41ef
	ld a, $06 ; $41f1
	ld [$c2b0], a ; $41f3
	ldh a, [hRomBank] ; $41f6
	ld hl, $4213 ; $41f8
	farcall ScriptRespawnLocationActors ; $41fb
	farcall BeginCutsceneScriptMode ; $41fe
	ret ; $4201
.stage4:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 ; $4202
	jr z, .done ; $4205
	ld a, $05 ; $4207
	ld [$c2b0], a ; $4209
	ret ; $420c
.done:
	ld a, $04 ; $420d
	ld [$c2b0], a ; $420f
	ret ; $4212
	; $4213, 234 bytes (map_actors)
	map_actor $0000, ActorScript_11_7ba9, $0f00, $2e00, FACE_LEFT, $25, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $0d00, $2700, FACE_DOWN, $25, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $2500, $2400, FACE_LEFT, $39, $01, $07
	map_actor $0000, ActorScript_11_7ba9, $2300, $2100, FACE_LEFT, $32, $01, $07
	map_actor $0000, ActorScript_11_7ba9, $2700, $2300, FACE_LEFT, $23, $01, $04
	map_actor $0000, ActorScript_11_7ba9, $2700, $2100, FACE_LEFT, $39, $01, $06
	map_actor $0000, ActorScript_11_7ba9, $2500, $2000, FACE_LEFT, $3a, $01, $03
	map_actor $0000, ActorScript_11_7ba9, $0b00, $2400, FACE_RIGHT, $33, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $0d00, $2100, FACE_RIGHT, $3a, $01, $04
	map_actor $0000, ActorScript_11_7ba9, $0900, $2300, FACE_RIGHT, $39, $01, $03
	map_actor $0000, ActorScript_11_7ba9, $0500, $2000, FACE_RIGHT, $39, $01, $06
	map_actor $0000, ActorScript_11_7ba9, $0900, $2100, FACE_RIGHT, $3a, $01, $03
	map_actor $0000, ActorScript_11_7ba9, $2b00, $2200, FACE_LEFT, $33, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $2b00, $2000, FACE_LEFT, $3a, $01, $04
	map_actor $0000, ActorScript_11_7ba9, $2b00, $1e00, FACE_LEFT, $6b, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $2700, $1d00, FACE_LEFT, $6a, $01, $04
	map_actor_end
MapArrivalWalk_11:
	ld a, [wStoryModeEntryPoint] ; $42fd
	cp a, $ff ; $4300
	jp z, .done ; $4302
	test_flag FLAG_DOUBLES ; $4305
	jr z, .walkOff ; $4308
	script_set_speed ACTOR_PARTNER, $00ff ; $430a
	script_move_angle ACTOR_PARTNER, FACE_DOWN, $0200 ; $4312
	script_wait_move ACTOR_PARTNER ; $431c
	script_face ACTOR_PARTNER, FACE_UP ; $4321
	script_set_speed ACTOR_PARTNER, $0010 ; $4328
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $4330
	script_move_angle ACTOR_PLAYER, FACE_UP, $0200 ; $4338
.done:
	ret ; $4342
SetPlayerAndPartnerObjectDefs_11:
	test_flag FLAG_DOUBLES ; $4343
	jp z, .notDoubles ; $4346
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $4349
	ld d, $58 ; $434c
	add a, d ; $434e
	ld d, a ; $434f
	script_get_actor_state ACTOR_PARTNER ; $4350
	ld c, l ; $4355
	ld b, h ; $4356
	farcall LoadActorObjectDefIfValid ; $4357
	script_set_anim ACTOR_PARTNER, $01 ; $435a
.notDoubles:
	ld a, [wStoryModeGenderOfMainCharacter] ; $4361
	ld d, $56 ; $4364
	add a, d ; $4366
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
	xor a, a ; $4395
	ld [wStoryModeShowLocationName], a ; $4396
	script_fade_in $04 ; $4399
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_43ed ; $439e
	script_wait_frames $50 ; $43a9
	script_set_anim ACTOR_PLAYER, $03 ; $43b0
	script_wait_idle ACTOR_PLAYER ; $43b7
	script_wait_frames $1e ; $43bc
	script_wait_actor_script ACTOR_PLAYER ; $43c3
	script_move_player $2300, $2400 ; $43c8
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_43f4 ; $43d2
	script_wait_frames $f0 ; $43dd
	ld a, $01 ; $43e4
	ld [$c294], a ; $43e6
	ld [wStoryModeExitLocationRequest], a ; $43e9
	ret ; $43ec
ActorScript_11_43ed:
	; $43ed, 7 bytes (actor_script)
	as_set_target $0c00, $2b00
	as_wait_move
	as_halt
ActorScript_11_43f4:
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
	map_actor $0000, ActorScript_11_7bb3, $1900, $1900, FACE_DOWN, $30, $01, $05
	map_actor $0000, ActorScript_11_7ba9, $1500, $2500, FACE_LEFT, $32, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $1500, $2700, FACE_LEFT, $39, $01, $00
	map_actor $0000, ActorScript_11_7bdf, $0100, $1c00, FACE_DOWN, $54, $01, $03
	map_actor $0000, ActorScript_11_7c42, $0500, $2800, FACE_UP, $54, $01, $04
	map_actor $0000, ActorScript_11_7ca9, $0a00, $1c00, FACE_DOWN, $54, $01, $07
	map_actor $0000, ActorScript_11_7d10, $0f00, $2800, FACE_UP, $54, $01, $06
	map_actor $0000, ActorScript_11_7bdf, $2200, $1c00, FACE_DOWN, $54, $01, $06
	map_actor $0000, ActorScript_11_7c42, $2600, $2800, FACE_UP, $54, $01, $03
	map_actor $0000, ActorScript_11_7ca9, $2c00, $1c00, FACE_DOWN, $54, $01, $07
	map_actor $0000, ActorScript_11_7d10, $3000, $2800, FACE_UP, $54, $01, $04
	map_actor $0000, ActorScript_11_7ba9, $1500, $3d00, FACE_RIGHT, $4d, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $1500, $3d00, FACE_RIGHT, $4c, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $1500, $3d00, FACE_RIGHT, $53, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $1500, $3d00, FACE_DOWN, $63, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $1500, $3d00, FACE_DOWN, $49, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $1500, $3d00, FACE_RIGHT, $4f, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $1800, $3300, FACE_UP, $30, $01, $03
	map_actor_end
AcademyArrivalEntryPoints_11:
	; $4515, 33 bytes (map_entries)
	map_entry $01, FACE_DOWN, $1800, $1100, AcademyArrivalArrival01_11
	map_entry $02, FACE_UP, $1800, $3300, MapArrivalWalk_11
	map_entry $0c, FACE_DOWN, $1800, $2f00, $0000
	map_entry $0f, FACE_UP, $1800, $2f00, $0000
	db $ff
AcademyArrivalArrival01_11:
	ld a, [wStoryModeEntryPoint] ; $4536
	cp a, $ff ; $4539
	jp z, .done ; $453b
	test_flag FLAG_DOUBLES ; $453e
	jr z, .walkOff ; $4541
	script_set_speed ACTOR_PARTNER, $00ff ; $4543
	script_move_angle ACTOR_PARTNER, FACE_UP, $0200 ; $454b
	script_wait_move ACTOR_PARTNER ; $4555
	script_face ACTOR_PARTNER, FACE_DOWN ; $455a
	script_set_speed ACTOR_PARTNER, $0010 ; $4561
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $4569
	script_move_angle ACTOR_PLAYER, FACE_DOWN, $0200 ; $4571
.done:
	ret ; $457b
AcademyArrivalExitTriggers_11:
	; $457c, 33 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_11, $05, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_11, $1b, $01
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_11, $1b, $0f
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_11, $05, $0f
	db $ff
AcademyArrivalNpc03_11:
	ld a, [$c2b0] ; $459d
	add a, a ; $45a0
	add a, $e1 ; $45a1
	ld l, a ; $45a3
	adc a, $45 ; $45a4
	sub a, l ; $45a6
	ld h, a ; $45a7
	ld a, [hl+] ; $45a8
	ld h, [hl] ; $45a9
	ld l, a ; $45aa
	farcall InitDialogueTextCursor ; $45ab
	ld a, [$c2b0] ; $45ae
	cp a, $08 ; $45b1
	jr nc, .altText ; $45b3
	cp a, $04 ; $45b5
	jr nc, .speak ; $45b7
	cp a, $02 ; $45b9
	jr c, .speak ; $45bb
.altText:
	script_speak $03 ; $45bd
	ret ; $45c2
.speak:
	ld a, $03 ; $45c3
	farcall ScriptShowSpeakerDialogueRestoreBG ; $45c5
	farcall RunDialogueYesNoPrompt ; $45c8
	farcall ScriptCloseDialogueWindow ; $45cb
	script_wait_frames $05 ; $45ce
	and a, a ; $45d5
	jr z, .done ; $45d6
	farcall AdvanceDialogueTextCursor ; $45d8
.done:
	script_speak $03 ; $45db
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
	ld a, [$c2b0] ; $45f5
	add a, a ; $45f8
	add a, $0c ; $45f9
	ld l, a ; $45fb
	adc a, $46 ; $45fc
	sub a, l ; $45fe
	ld h, a ; $45ff
	ld a, [hl+] ; $4600
	ld h, [hl] ; $4601
	ld l, a ; $4602
	farcall InitDialogueTextCursor ; $4603
	script_speak $04 ; $4606
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
	ld a, [$c2b0] ; $4620
	sra a ; $4623
	add a, a ; $4625
	add a, $39 ; $4626
	ld l, a ; $4628
	adc a, $46 ; $4629
	sub a, l ; $462b
	ld h, a ; $462c
	ld a, [hl+] ; $462d
	ld h, [hl] ; $462e
	ld l, a ; $462f
	farcall InitDialogueTextCursor ; $4630
	script_speak $05 ; $4633
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
	script_set_anim $14, $04 ; $465e
	script_wait_idle $14 ; $4665
	script_speak $14 ; $466a
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
	map_script $03, FACEMASK_ANY, $0000, AcademyArrivalNpc03_11, $13, $00
	map_script $04, FACEMASK_ANY, $0000, AcademyArrivalNpc04_11, $01, $00
	map_script $05, FACEMASK_ANY, $0000, AcademyArrivalNpc05_11, $01, $00
	map_script $14, FACEMASK_ANY, $0000, AcademyArrivalNpc14_11, $03, $00
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
	call ComputeRankingProgressIndex ; $46b1
	call EnableAcademyCampusExit ; $46b4
	call MoveCampusGateGuardAside ; $46b7
	ld a, [wStoryModeEntryPoint] ; $46ba
	cp a, $0a ; $46bd
	jp z, ActorListEnd_11_4fc5.scriptRespawnLocationActors ; $46bf
	cp a, $0c ; $46c2
	jp z, ActorListEnd_11_4fc5.scriptRespawnLocationActors2 ; $46c4
	cp a, $0f ; $46c7
	jr nz, .done ; $46c9
	call LateStudentCrashCutscene ; $46cb
.done:
	ret ; $46ce
LateStudentCrashCutscene:
	script_set_speed ACTOR_PLAYER, $0010 ; $46cf
	xor a, a ; $46d7
	ld [wStoryModeShowLocationName], a ; $46d8
	script_set_position $11, $1800, $0d00 ; $46db
	script_set_position ACTOR_PLAYER, $1800, $3700 ; $46e6
	script_set_position $14, $3f00, $3f00 ; $46f1
	script_set_position $03, $2280, $1500 ; $46fc
	script_face $03, FACE_RIGHT ; $4707
	script_set_position $04, $3300, $1500 ; $470e
	script_set_position $05, $3300, $1500 ; $4719
	script_fade_in $04 ; $4724
	call WaitFadeEnd ; $4729
	script_move_target ACTOR_PLAYER, $1800, $2d00 ; $472c
	script_wait_move ACTOR_PLAYER ; $4737
	script_face ACTOR_PLAYER, FACE_RIGHT ; $473c
	script_wait_frames $28 ; $4743
	script_face ACTOR_PLAYER, FACE_UP ; $474a
	script_wait_frames $28 ; $4751
	script_face ACTOR_PLAYER, FACE_LEFT ; $4758
	script_wait_frames $28 ; $475f
	script_face ACTOR_PLAYER, FACE_UP ; $4766
	script_wait_frames $28 ; $476d
	script_face ACTOR_PLAYER, FACE_RIGHT ; $4774
	script_wait_frames $0a ; $477b
	script_face ACTOR_PLAYER, FACE_DOWN ; $4782
	script_wait_frames $3c ; $4789
	script_set_anim ACTOR_PLAYER, $03 ; $4790
	script_wait_idle ACTOR_PLAYER ; $4797
	script_wait_frames $3c ; $479c
	script_move_target ACTOR_PLAYER, $1800, $2100 ; $47a3
	script_player_speed $0040 ; $47ae
	script_move_player $1800, $1200 ; $47b4
	farcall WaitPlayerMoveDone ; $47be
	script_wait_frames $3c ; $47c1
	script_set_position ACTOR_PLAYER, $1800, $2000 ; $47c8
	script_face ACTOR_PLAYER, FACE_UP ; $47d3
	script_set_speed $11, $0024 ; $47da
	script_move_target $11, $1800, $1400 ; $47e2
	script_wait_move $11 ; $47ed
	script_set_anim $11, $04 ; $47f2
	script_wait_idle $11 ; $47f9
	script_face $11, FACE_UP ; $47fe
	script_set_text Text_36_79 ; $4805
	script_speak $11 ; $480b
	script_set_anim $11, $03 ; $4810
	script_wait_idle $11 ; $4817
	script_set_speed $11, $0020 ; $481c
	script_speak $11 ; $4824
	script_face $11, FACE_DOWN ; $4829
	script_jump_velocity $11, $ff80 ; $4830
	ld a, $11 ; $4838
	farcall ScriptWaitActorJumpDone ; $483a
	script_move_target $11, $1800, $1700 ; $483d
	script_wait_move $11 ; $4848
	script_set_position $0e, $1980, $15c0 ; $484d
	sound $98 ; $4858
	script_set_speed $11, $0010 ; $485a
	script_set_speed $0e, $0010 ; $4862
	script_move_target $0e, $1980, $18c0 ; $486a
	script_move_target $11, $1800, $1a00 ; $4875
	script_wait_move $11 ; $4880
	script_speak $11 ; $4885
	script_set_position $0e, $3f00, $3f00 ; $488a
	script_move_target $11, $1800, $1600 ; $4895
	script_wait_move $11 ; $48a0
	script_wait_frames $1e ; $48a5
	script_set_anim $11, $02 ; $48ac
	script_set_position $0f, $1980, $14c0 ; $48b3
	sound $97 ; $48be
	script_wait_frames $14 ; $48c0
	script_speak $11 ; $48c7
	script_set_position $0f, $3f00, $3f00 ; $48cc
	script_set_speed $11, $0020 ; $48d7
	script_jump_velocity $11, $ff80 ; $48df
	ld a, $11 ; $48e7
	farcall ScriptWaitActorJumpDone ; $48e9
	script_move_target $11, $1800, $2000 ; $48ec
	script_wait_frames $1e ; $48f7
	ld bc, $d040 ; $48fe
	script_get_actor_state $11 ; $4901
	ld e, l ; $4906
	ld d, h ; $4907
	farcall AttachActorWaypointFollower ; $4908
	script_move_target ACTOR_PLAYER, $1800, $1e00 ; $490b
	script_wait_frames $14 ; $4916
	call LateStudentCrashImpact ; $491d
	script_wait_move $11 ; $4920
	script_set_anim $11, $02 ; $4925
	script_set_position $10, $1900, $1e00 ; $492c
	sound $96 ; $4937
	script_wait_frames $3c ; $4939
	script_set_position $10, $3f00, $3f00 ; $4940
	script_move_target $11, $1700, $2200 ; $494b
	script_wait_move $11 ; $4956
	script_face_toward ACTOR_PLAYER, $11 ; $495b
	script_speak $11 ; $4963
	script_move_target $11, $1900, $2400 ; $4968
	script_wait_move $11 ; $4973
	script_null_script ACTOR_PLAYER_SHADOW ; $4978
	script_face_toward ACTOR_PLAYER, $11 ; $497d
	script_set_anim $11, $02 ; $4985
	script_wait_idle $11 ; $498c
	script_speak $11 ; $4991
	script_set_position $13, $1a80, $2280 ; $4996
	script_wait_frames $3c ; $49a1
	script_set_position $13, $3f00, $3f00 ; $49a8
	script_move_target $11, $1900, $2300 ; $49b3
	script_wait_move $11 ; $49be
	script_move_target $11, $1a00, $2300 ; $49c3
	script_wait_move $11 ; $49ce
	script_move_target $11, $1a00, $2400 ; $49d3
	script_wait_move $11 ; $49de
	script_move_target $11, $1900, $2400 ; $49e3
	script_wait_move $11 ; $49ee
	script_move_target $11, $1900, $2500 ; $49f3
	script_wait_move $11 ; $49fe
	script_move_target $11, $1a00, $2500 ; $4a03
	script_wait_move $11 ; $4a0e
	script_move_target $11, $1a00, $2400 ; $4a13
	script_wait_move $11 ; $4a1e
	script_move_target $11, $1900, $2400 ; $4a23
	script_wait_move $11 ; $4a2e
	script_face_toward ACTOR_PLAYER, $11 ; $4a33
	script_wait_frames $3c ; $4a3b
	script_set_anim $11, $02 ; $4a42
	script_wait_idle $11 ; $4a49
	script_speak $11 ; $4a4e
	call KnockPlayerAirborneFlipped_11 ; $4a53
	script_facing_lock $11, $01 ; $4a56
	script_set_anim $11, $05 ; $4a5d
	script_wait_frames $14 ; $4a64
	script_jump_velocity $11, $ff80 ; $4a6b
	script_move_target $11, $1b00, $2400 ; $4a73
	script_wait_frames $14 ; $4a7e
	script_face_toward $11, ACTOR_PLAYER ; $4a85
	script_wait_frames $14 ; $4a8d
	script_set_anim ACTOR_PLAYER, $02 ; $4a94
	script_wait_idle ACTOR_PLAYER ; $4a9b
	script_set_anim $11, $02 ; $4aa0
	script_wait_idle $11 ; $4aa7
	script_face_toward ACTOR_PLAYER, $11 ; $4aac
	script_move_target $11, $1a00, $2400 ; $4ab4
	script_wait_move $11 ; $4abf
	script_facing_lock $11, FACE_RIGHT ; $4ac4
	script_set_anim ACTOR_PLAYER, $02 ; $4acb
	script_wait_idle ACTOR_PLAYER ; $4ad2
	script_set_anim $11, $02 ; $4ad7
	script_wait_idle $11 ; $4ade
	script_speak $11 ; $4ae3
	script_set_anim $11, $02 ; $4ae8
	script_wait_idle $11 ; $4aef
.loop:
	script_set_text Text_36_87 ; $4af4
	ld a, $11 ; $4afa
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4afc
	farcall RunDialogueYesNoPrompt ; $4aff
	farcall ScriptCloseDialogueWindow ; $4b02
	script_wait_frames $05 ; $4b05
	and a, a ; $4b0c
	jr z, .setText ; $4b0d
	script_set_anim $11, $02 ; $4b0f
	script_speak $11 ; $4b16
	jr .loop ; $4b1b
.setText:
	script_set_text Text_36_89 ; $4b1d
	script_set_anim $11, $03 ; $4b23
	script_wait_idle $11 ; $4b2a
	script_speak $11 ; $4b2f
	script_wait_frames $3c ; $4b34
	script_set_position $0e, $1b80, $21c0 ; $4b3b
	sound $98 ; $4b46
	script_wait_frames $28 ; $4b48
	script_set_position $0e, $3f00, $3f00 ; $4b4f
	script_move_angle $11, FACE_LEFT, $0100 ; $4b5a
	script_wait_move $11 ; $4b64
	script_speak $11 ; $4b69
	script_set_anim ACTOR_PLAYER, $03 ; $4b6e
	script_wait_idle ACTOR_PLAYER ; $4b75
	script_set_position $0e, $1a80, $21c0 ; $4b7a
	script_wait_frames $3c ; $4b85
	script_set_position $0e, $3f00, $3f00 ; $4b8c
	script_wait_frames $3c ; $4b97
	script_set_position $0f, $1a80, $21c0 ; $4b9e
	sound $97 ; $4ba9
	script_jump_velocity $11, $ff80 ; $4bab
	ld a, $11 ; $4bb3
	farcall ScriptWaitActorJumpDone ; $4bb5
	script_wait_frames $0a ; $4bb8
	script_set_position $0f, $3f00, $3f00 ; $4bbf
	script_speak $11 ; $4bca
	script_set_anim $11, $02 ; $4bcf
	script_wait_idle $11 ; $4bd6
	script_speak $11 ; $4bdb
	script_set_anim ACTOR_PLAYER, $03 ; $4be0
	script_wait_idle ACTOR_PLAYER ; $4be7
	script_set_anim $11, $03 ; $4bec
	script_wait_idle $11 ; $4bf3
	script_speak $11 ; $4bf8
	script_wait_frames $0a ; $4bfd
	script_set_anim ACTOR_PLAYER, $03 ; $4c04
	script_wait_idle ACTOR_PLAYER ; $4c0b
	script_wait_frames $3c ; $4c10
	script_player_speed $0060 ; $4c17
	script_face $11, FACE_UP ; $4c1d
	script_set_anim $11, $02 ; $4c24
	script_wait_idle $11 ; $4c2b
	script_set_position $0f, $1a80, $21c0 ; $4c30
	sound $97 ; $4c3b
	script_wait_frames $28 ; $4c3d
	script_set_position $0f, $3f00, $3f00 ; $4c44
	script_face $11, FACE_UP ; $4c4f
	script_set_anim $11, $02 ; $4c56
	script_move_player $1800, $0b00 ; $4c5d
	farcall WaitPlayerMoveDone ; $4c67
	script_set_active $11, $00 ; $4c6a
	script_set_position $11, $1900, $0600 ; $4c71
	script_speak $11 ; $4c7c
	script_set_position $11, $1900, $2400 ; $4c81
	script_set_active $11, $02 ; $4c8c
	script_move_player $1800, $2400 ; $4c93
	farcall WaitPlayerMoveDone ; $4c9d
	script_face_toward ACTOR_PLAYER, $11 ; $4ca0
	script_speak $11 ; $4ca8
	script_set_anim $11, $03 ; $4cad
	script_wait_idle $11 ; $4cb4
	script_set_anim ACTOR_PLAYER, $03 ; $4cb9
	script_wait_idle ACTOR_PLAYER ; $4cc0
	script_jump_velocity $11, $ff80 ; $4cc5
	ld a, $11 ; $4ccd
	farcall ScriptWaitActorJumpDone ; $4ccf
	script_move_target $11, $1800, $3300 ; $4cd2
	script_wait_frames $14 ; $4cdd
	script_face ACTOR_PLAYER, FACE_DOWN ; $4ce4
	script_wait_frames $5a ; $4ceb
	call AcademyArrivalGreetingScene ; $4cf2
	ret ; $4cf5
LateStudentCrashImpact:
	script_null_script ACTOR_PLAYER_SHADOW ; $4cf6
	sound $70 ; $4cfb
	ld a, $03 ; $4cfd
	farcall SetScreenShake ; $4cff
	script_wait_frames $0a ; $4d02
	ld a, $00 ; $4d09
	farcall SetScreenShake ; $4d0b
	script_set_speed ACTOR_PLAYER, $0040 ; $4d0e
	script_move_player $1800, $2400 ; $4d16
	script_move_target ACTOR_PLAYER, $1700, $2400 ; $4d20
	script_jump_velocity ACTOR_PLAYER, $ff00 ; $4d2b
	script_get_actor_state ACTOR_PLAYER ; $4d33
	ld c, l ; $4d38
	ld b, h ; $4d39
	ld hl, $0037 ; $4d3a
	add hl, bc ; $4d3d
	ld a, [hl] ; $4d3e
	or a, $40 ; $4d3f
	ld [hl], a ; $4d41
	script_wait_frames $1e ; $4d42
	script_set_anim ACTOR_PLAYER, $02 ; $4d49
	script_wait_idle ACTOR_PLAYER ; $4d50
	script_wait_frames $1e ; $4d55
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_4d8d ; $4d5c
	ret ; $4d67
KnockPlayerAirborneFlipped_11:
	script_null_script ACTOR_PLAYER ; $4d68
	script_set_speed ACTOR_PLAYER, $0010 ; $4d6d
	script_jump_velocity ACTOR_PLAYER, $ff80 ; $4d75
	script_get_actor_state ACTOR_PLAYER ; $4d7d
	ld c, l ; $4d82
	ld b, h ; $4d83
	ld hl, $0037 ; $4d84
	add hl, bc ; $4d87
	ld a, [hl] ; $4d88
	xor a, $40 ; $4d89
	ld [hl], a ; $4d8b
	ret ; $4d8c
ActorScript_11_4d8d:
	; $4d8d, 7 bytes (actor_script)
	as_anim $02
	as_wait $50
	as_jump ActorScript_11_4d8d
AcademyArrivalGreetingScene:
	script_player_speed $0010 ; $4d94
	script_set_speed ACTOR_PLAYER, $0018 ; $4d9a
	script_set_speed $12, $0018 ; $4da2
	script_move_player $1800, $1300 ; $4daa
	script_move_target ACTOR_PLAYER, $1800, $2400 ; $4db4
	script_wait_move ACTOR_PLAYER ; $4dbf
	script_move_target ACTOR_PLAYER, $1800, $1300 ; $4dc4
	script_set_text Text_30_419 ; $4dcf
	script_wait_frames $78 ; $4dd5
	script_set_position $12, $1800, $0f00 ; $4ddc
	script_wait_move ACTOR_PLAYER ; $4de7
	ld a, [wStoryModeGenderOfMainCharacter] ; $4dec
	or a, a ; $4def
	jr z, .doubles ; $4df0
	farcall AdvanceDialogueTextCursor ; $4df2
.doubles:
	script_speak $12 ; $4df5
	script_set_position $0f, $1940, $11c0 ; $4dfa
	sound $97 ; $4e05
	script_wait_frames $28 ; $4e07
	script_set_position $0f, $3f00, $3f00 ; $4e0e
	script_face_toward $12, ACTOR_PLAYER ; $4e19
	script_player_speed $0020 ; $4e21
	script_move_target $12, $1800, $1100 ; $4e27
	script_wait_frames $0f ; $4e32
	script_move_player $1800, $1100 ; $4e39
	farcall WaitPlayerMoveDone ; $4e43
	script_wait_frames $3c ; $4e46
	script_face_pair ACTOR_PLAYER, $12 ; $4e4d
	script_wait_frames $1e ; $4e55
	script_set_anim ACTOR_PLAYER, $03 ; $4e5c
	script_wait_idle ACTOR_PLAYER ; $4e63
	script_wait_frames $0f ; $4e68
	script_set_anim $12, $03 ; $4e6f
	script_wait_idle $12 ; $4e76
	script_set_text Text_30_421 ; $4e7b
	script_speak $03 ; $4e81
	script_set_position $0e, $1940, $11c0 ; $4e86
	sound $98 ; $4e91
	script_wait_frames $32 ; $4e93
	script_set_position $0e, $3f00, $3f00 ; $4e9a
	script_set_anim $12, $03 ; $4ea5
	script_wait_idle $12 ; $4eac
	script_speak $12 ; $4eb1
	script_wait_frames $0f ; $4eb6
	script_set_anim $12, $02 ; $4ebd
	script_wait_idle $12 ; $4ec4
	ld a, $12 ; $4ec9
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4ecb
	farcall RunDialogueYesNoPrompt ; $4ece
	farcall ScriptCloseDialogueWindow ; $4ed1
	script_wait_frames $05 ; $4ed4
	and a, a ; $4edb
	jr z, .finish ; $4edc
	farcall AdvanceDialogueTextCursor ; $4ede
.finish:
	ld a, $12 ; $4ee1
	farcall ScriptShowSpeakerDialogueRestoreBG ; $4ee3
	farcall RunDialogueYesNoPrompt ; $4ee6
	farcall ScriptCloseDialogueWindow ; $4ee9
	script_wait_frames $05 ; $4eec
	and a, a ; $4ef3
	jr z, .done ; $4ef4
	xor a, a ; $4ef6
	ld [wStoryModeShowLocationName], a ; $4ef7
	script_set_text Text_30_427 ; $4efa
	script_speak $12 ; $4f00
	set_flag FLAG_STORY_MENU_LOCKED ; $4f05
	call ArmAcademyEntranceTileTrigger ; $4f08
	ret ; $4f0b
.done:
	script_set_text Text_30_426 ; $4f0c
	script_speak $12 ; $4f12
	call FollowGuideIntoAcademy ; $4f17
	ret ; $4f1a
ArmAcademyEntranceTileTrigger:
	ld a, $f1 ; $4f1b
	ld d, $16 ; $4f1d
	ld e, $10 ; $4f1f
	farcall WriteBehaviorMapCell ; $4f21
	ld a, $f1 ; $4f24
	ld d, $18 ; $4f26
	ld e, $10 ; $4f28
	farcall WriteBehaviorMapCell ; $4f2a
	ld a, $f1 ; $4f2d
	ld d, $16 ; $4f2f
	ld e, $12 ; $4f31
	farcall WriteBehaviorMapCell ; $4f33
	ld a, $f1 ; $4f36
	ld d, $18 ; $4f38
	ld e, $12 ; $4f3a
	farcall WriteBehaviorMapCell ; $4f3c
	ret ; $4f3f
ResumeAcademyGuideTour:
	script_set_anim $12, $02 ; $4f40
	script_wait_idle $12 ; $4f47
	script_move_target ACTOR_PLAYER, $1800, $1300 ; $4f4c
	script_wait_move ACTOR_PLAYER ; $4f57
	script_face_toward $12, ACTOR_PLAYER ; $4f5c
	script_set_anim $12, $03 ; $4f64
	script_wait_idle $12 ; $4f6b
	script_set_text Text_30_428 ; $4f70
	script_speak $12 ; $4f76
	script_speak $12 ; $4f7b
	call FollowGuideIntoAcademy ; $4f80
	ret ; $4f83
FollowGuideIntoAcademy:
	script_set_speed ACTOR_PLAYER, $0018 ; $4f84
	script_set_speed $12, $0018 ; $4f8c
	clear_flag FLAG_STORY_MENU_LOCKED ; $4f94
	script_move_target $12, $1800, $0e00 ; $4f97
	script_move_target ACTOR_PLAYER, $1800, $0e00 ; $4fa2
	script_wait_frames $1e ; $4fad
	ld a, $0f ; $4fb4
	ld [$c294], a ; $4fb6
	ld [wStoryModeExitLocationRequest], a ; $4fb9
	ld c, $04 ; $4fbc
	call BeginFadeOut ; $4fbe
	call WaitFadeEnd ; $4fc1
	ret ; $4fc4
ActorListEnd_11_4fc5:
	; $4fc5, 10 bytes (bytes:10)
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x00
.scriptRespawnLocationActors:
	ldh a, [hRomBank] ; $4fcf
	ld hl, $537d ; $4fd1
	farcall ScriptRespawnLocationActors ; $4fd4
	farcall BeginCutsceneScriptMode ; $4fd7
	test_flag FLAG_DOUBLES ; $4fda
	jp z, .notDoubles ; $4fdd
	script_null_script ACTOR_PARTNER ; $4fe0
	script_set_position ACTOR_PARTNER, $3f00, $3f00 ; $4fe5
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $4ff0
	ld d, $58 ; $4ff3
	add a, d ; $4ff5
	ld d, a ; $4ff6
	script_get_actor_state $05 ; $4ff7
	ld c, l ; $4ffc
	ld b, h ; $4ffd
	farcall LoadActorObjectDefIfValid ; $4ffe
	script_set_anim $05, $01 ; $5001
	script_set_position $07, $1a00, $1100 ; $5008
	script_face $07, FACE_DOWN ; $5013
.notDoubles:
	ld a, [wStoryModeGenderOfMainCharacter] ; $501a
	ld d, $56 ; $501d
	add a, d ; $501f
	ld d, a ; $5020
	script_get_actor_state ACTOR_PLAYER ; $5021
	ld c, l ; $5026
	ld b, h ; $5027
	farcall LoadActorObjectDefIfValid ; $5028
	script_set_anim ACTOR_PLAYER, $01 ; $502b
	script_set_position ACTOR_PLAYER, $1700, $1700 ; $5032
	script_face ACTOR_PLAYER, FACE_UP ; $503d
	script_move_player_to_actor $03 ; $5044
	farcall WaitPlayerMoveDone ; $504b
	script_fade_in $08 ; $504e
	call WaitFadeEnd ; $5053
	script_wait_frames $3c ; $5056
	script_set_text Text_30_493 ; $505d
	script_speak $03 ; $5063
	test_flag FLAG_DOUBLES ; $5068
	jp z, .animate ; $506b
	script_set_anim $04, $03 ; $506e
	script_set_anim $06, $03 ; $5075
	script_wait_idle $06 ; $507c
	script_wait_frames $1e ; $5081
	script_face_pair $05, ACTOR_PLAYER ; $5088
	script_wait_frames $1e ; $5090
	script_set_anim ACTOR_PLAYER, $03 ; $5097
	script_set_anim $05, $03 ; $509e
	script_wait_idle $05 ; $50a5
	script_wait_frames $1e ; $50aa
	script_face $05, FACE_UP ; $50b1
	script_wait_frames $1e ; $50b8
	script_set_anim ACTOR_PLAYER, $03 ; $50bf
	script_set_anim $05, $03 ; $50c6
	script_wait_idle $05 ; $50cd
	script_wait_frames $1e ; $50d2
	script_set_anim $03, $03 ; $50d9
	script_wait_idle $03 ; $50e0
	script_wait_frames $0a ; $50e5
	script_set_anim $07, $02 ; $50ec
	script_wait_idle $07 ; $50f3
	script_speak $07 ; $50f8
	script_set_anim $04, $03 ; $50fd
	script_set_anim $05, $03 ; $5104
	script_set_anim ACTOR_PLAYER, $03 ; $510b
	script_set_anim $06, $03 ; $5112
	script_wait_idle $06 ; $5119
	script_wait_frames $1e ; $511e
	script_face_pair $07, $03 ; $5125
	script_set_anim $03, $03 ; $512d
	script_set_anim $07, $03 ; $5134
	script_wait_idle $07 ; $513b
	script_face $07, FACE_DOWN ; $5140
	script_face $03, FACE_DOWN ; $5147
	script_wait_frames $1e ; $514e
	jp .speak ; $5155
.animate:
	script_set_anim $04, $03 ; $5158
	script_set_anim $05, $03 ; $515f
	script_wait_idle $05 ; $5166
	script_wait_frames $1e ; $516b
	script_face_pair $06, ACTOR_PLAYER ; $5172
	script_wait_frames $1e ; $517a
	script_set_anim ACTOR_PLAYER, $03 ; $5181
	script_set_anim $06, $03 ; $5188
	script_wait_idle $06 ; $518f
	script_wait_frames $1e ; $5194
	script_face ACTOR_PLAYER, FACE_UP ; $519b
	script_face $06, FACE_UP ; $51a2
	script_wait_frames $1e ; $51a9
	script_set_anim ACTOR_PLAYER, $03 ; $51b0
	script_set_anim $06, $03 ; $51b7
	script_wait_idle $06 ; $51be
	script_wait_frames $1e ; $51c3
	script_set_anim $03, $03 ; $51ca
	script_wait_idle $03 ; $51d1
	farcall AdvanceDialogueTextCursor ; $51d6
.speak:
	script_speak $03 ; $51d9
	script_wait_frames $1e ; $51de
	script_set_anim $04, $03 ; $51e5
	script_set_anim $05, $03 ; $51ec
	script_set_anim ACTOR_PLAYER, $03 ; $51f3
	script_set_anim $06, $03 ; $51fa
	script_wait_idle $06 ; $5201
	script_wait_frames $14 ; $5206
	script_face_pair $06, ACTOR_PLAYER ; $520d
	script_face_pair $04, $05 ; $5215
	script_wait_frames $0a ; $521d
	script_facing_lock ACTOR_PLAYER, $01 ; $5224
	script_facing_lock $06, $01 ; $522b
	script_facing_lock $05, $01 ; $5232
	script_facing_lock $04, $01 ; $5239
	script_move_target ACTOR_PLAYER, $1600, $1700 ; $5240
	script_move_target $06, $1a00, $1700 ; $524b
	script_move_target $05, $1500, $1500 ; $5256
	script_move_target $04, $1b00, $1500 ; $5261
	script_wait_move $04 ; $526c
	script_move_player $1800, $2f00 ; $5271
	script_move_target $03, $1800, $1900 ; $527b
	script_wait_move $03 ; $5286
	script_facing_lock ACTOR_PLAYER, FACE_RIGHT ; $528b
	script_facing_lock $06, FACE_RIGHT ; $5292
	script_facing_lock $05, FACE_RIGHT ; $5299
	script_facing_lock $04, FACE_RIGHT ; $52a0
	script_move_target ACTOR_PLAYER, $1600, $2b00 ; $52a7
	script_move_target $06, $1a00, $2b00 ; $52b2
	script_move_target $05, $1500, $2900 ; $52bd
	script_move_target $04, $1b00, $2900 ; $52c8
	script_move_target $03, $1800, $2d00 ; $52d3
	script_wait_move $03 ; $52de
	script_set_anim $08, $03 ; $52e3
	script_move_target ACTOR_PLAYER, $1700, $2f00 ; $52ea
	script_move_target $06, $1900, $2f00 ; $52f5
	script_move_target $05, $1700, $2d00 ; $5300
	script_move_target $04, $1900, $2d00 ; $530b
	script_move_target $03, $1800, $3100 ; $5316
	script_wait_move $03 ; $5321
	script_move_target ACTOR_PLAYER, $1700, $3b00 ; $5326
	script_move_target $06, $1900, $3b00 ; $5331
	script_move_target $05, $1700, $3900 ; $533c
	script_move_target $04, $1900, $3900 ; $5347
	script_move_target $03, $1800, $3d00 ; $5352
	script_wait_move $03 ; $535d
	ld c, $04 ; $5362
	call BeginFadeOut ; $5364
	call WaitFadeEnd ; $5367
	ld a, $1b ; $536a
	ld [wStoryModeCurrentLocation], a ; $536c
	ld a, $01 ; $536f
	ld [wStoryModeEntryPoint], a ; $5371
	ld a, $ff ; $5374
	ld [$c294], a ; $5376
	ld [wStoryModeExitLocationRequest], a ; $5379
	ret ; $537c
	; $537d, 94 bytes (map_actors)
	map_actor $0000, ActorScript_11_7ba9, $1800, $1100, FACE_DOWN, $63, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $1a00, $1500, FACE_UP, $5c, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $1600, $1500, FACE_UP, $5b, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $1900, $1700, FACE_UP, $5a, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $0100, $1900, FACE_UP, $4a, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $1500, $2f00, FACE_RIGHT, $30, $01, $03
	map_actor_end
.scriptRespawnLocationActors2:
	ldh a, [hRomBank] ; $53db
	ld hl, $546a ; $53dd
	farcall ScriptRespawnLocationActors ; $53e0
	farcall BeginCutsceneScriptMode ; $53e3
	script_player_speed $00ff ; $53e6
	script_move_player $1800, $2f00 ; $53ec
	farcall WaitPlayerMoveDone ; $53f6
	test_flag FLAG_DOUBLES ; $53f9
	jp z, .placeActors ; $53fc
	script_set_position ACTOR_PARTNER, $1800, $1d00 ; $53ff
	script_move_target ACTOR_PARTNER, $1800, $3900 ; $540a
.placeActors:
	script_set_position ACTOR_PLAYER, $1800, $1f00 ; $5415
	script_move_target ACTOR_PLAYER, $1800, $3b00 ; $5420
	xor a, a ; $542b
	ld [wStoryModeShowLocationName], a ; $542c
	script_fade_in $04 ; $542f
	call WaitFadeEnd ; $5434
	script_wait_frames $3c ; $5437
	script_set_anim $03, $03 ; $543e
	script_wait_idle $03 ; $5445
	script_wait_move ACTOR_PLAYER ; $544a
	ld c, $04 ; $544f
	call BeginFadeOut ; $5451
	call WaitFadeEnd ; $5454
	ld a, $1b ; $5457
	ld [wStoryModeCurrentLocation], a ; $5459
	ld a, $0f ; $545c
	ld [wStoryModeEntryPoint], a ; $545e
	ld a, $ff ; $5461
	ld [$c294], a ; $5463
	ld [wStoryModeExitLocationRequest], a ; $5466
	ret ; $5469
	; $546a, 24 bytes (map_actors)
	map_actor $0000, ActorScript_11_7ba9, $1500, $2f00, FACE_RIGHT, $30, $01, $03
	map_actor_end
EnableAcademyCampusExit:
	test_flag FLAG_DOUBLES ; $5482
	jr nz, .checkFlag ; $5485
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $5487
	jr nz, .writeBehaviorMapCell ; $548a
	ret ; $548c
.checkFlag:
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $548d
	jr nz, .writeBehaviorMapCell ; $5490
	ret ; $5492
.writeBehaviorMapCell:
	ld a, $33 ; $5493
	ld d, $16 ; $5495
	ld e, $34 ; $5497
	farcall WriteBehaviorMapCell ; $5499
	ld a, $33 ; $549c
	ld d, $18 ; $549e
	ld e, $34 ; $54a0
	farcall WriteBehaviorMapCell ; $54a2
	ret ; $54a5
MoveCampusGateGuardAside:
	ld a, [$c2b0] ; $54a6
	cp a, $06 ; $54a9
	jr c, .done ; $54ab
	script_set_position $14, $1500, $3000 ; $54ad
	script_face $14, FACE_RIGHT ; $54b8
.done:
	ret ; $54bf
JuniorClassCourtDoublesMapScripts_11:
	; $54c0, 14 bytes (map_tree)
	dw JuniorClassCourtDoublesEntryPoints_11 ; slot 0 EntryPoints
	dw JuniorClassCourtDoublesExitTriggers_11 ; slot 1 ExitTriggers
	dw JuniorClassCourtDoublesActors_11 ; slot 2 Actors
	dw JuniorClassCourtDoublesNpcScripts_11 ; slot 3 NpcScripts
	dw JuniorClassCourtDoublesFacingScripts_11 ; slot 4 FacingScripts
	dw JuniorClassCourtDoublesTileTriggers_11 ; slot 5 TileTriggers
	dw JuniorClassCourtDoublesInitScript_11 ; slot 6 InitScript
JuniorClassCourtDoublesActors_11:
	; $54ce, 192 bytes (map_actors)
	map_actor $0000, ActorScript_11_7ba9, $1300, $1300, FACE_DOWN, $37, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $2300, $1700, FACE_LEFT, $68, $01, $05
	map_actor $0000, ActorScript_11_7ba9, $0500, $1500, FACE_RIGHT, $6b, $01, $04
	map_actor $0000, ActorScript_11_7ba9, $2100, $1500, FACE_DOWN, $67, $01, $07
	map_actor $0000, ActorScript_11_7ba9, $0500, $1300, FACE_RIGHT, $6a, $01, $07
	map_actor $0000, ActorScript_11_7d86, $1b00, $1300, FACE_DOWN, $66, $01, $03
	map_actor $0000, ActorScript_11_681f, $1b00, $1500, FACE_UP, $65, $01, $06
	map_actor $0000, ActorScript_11_7ba9, $3700, $0700, FACE_LEFT, $64, $01, $04
	map_actor $0000, ActorScript_11_7ba9, $3500, $0700, FACE_RIGHT, $69, $01, $03
	map_actor $0000, ActorScript_11_7ca9, $0800, $0b00, FACE_DOWN, $54, $01, $05
	map_actor $0000, ActorScript_11_7d10, $0c00, $1700, FACE_UP, $54, $01, $00
	map_actor $0000, ActorScript_11_7bdf, $2a00, $0b00, FACE_DOWN, $54, $01, $00
	map_actor $0000, ActorScript_11_7c42, $2e00, $1700, FACE_UP, $54, $01, $05
	map_actor_end
JuniorClassCourtDoublesEntryPoints_11:
	; $558e, 17 bytes (map_entries)
	map_entry $01, FACE_UP, $1300, $1d00, MapArrivalWalk_11
	map_entry $09, FACE_UP, $3700, $1900, $0000
	db $ff
JuniorClassCourtDoublesExitTriggers_11:
	; $559f, 17 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_11, $08, $05
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_11, $0c, $0f
	db $ff
JuniorClassCourtDoublesNpc04_11:
	script_set_text Text_32_105 ; $55b0
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $55b6
	jr nz, .speak ; $55b9
	farcall AdvanceDialogueTextCursor ; $55bb
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_2 ; $55be
	jr nz, .speak ; $55c1
	farcall AdvanceDialogueTextCursor ; $55c3
.speak:
	script_speak $04 ; $55c6
	ret ; $55cb
JuniorClassCourtDoublesNpc05_11:
	script_set_text Text_32_120 ; $55cc
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_2 ; $55d2
	jr nz, .speak ; $55d5
	farcall AdvanceDialogueTextCursor ; $55d7
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $55da
	jr nz, .speak ; $55dd
	farcall AdvanceDialogueTextCursor ; $55df
.speak:
	script_speak $05 ; $55e2
	ret ; $55e7
JuniorClassCourtDoublesNpc06_11:
	script_set_text Text_32_108 ; $55e8
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $55ee
	jr nz, .speak ; $55f1
	farcall AdvanceDialogueTextCursor ; $55f3
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_2 ; $55f6
	jr nz, .speak ; $55f9
	farcall AdvanceDialogueTextCursor ; $55fb
	ld a, $06 ; $55fe
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5600
	farcall RunDialogueYesNoPrompt ; $5603
	farcall ScriptCloseDialogueWindow ; $5606
	script_wait_frames $05 ; $5609
	and a, a ; $5610
	jr z, .speak ; $5611
	farcall AdvanceDialogueTextCursor ; $5613
.speak:
	script_speak $06 ; $5616
	ret ; $561b
JuniorClassCourtDoublesNpc07_11:
	script_set_text Text_32_123 ; $561c
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_2 ; $5622
	jr nz, .speak ; $5625
	farcall AdvanceDialogueTextCursor ; $5627
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $562a
	jr nz, .speak ; $562d
	farcall AdvanceDialogueTextCursor ; $562f
.speak:
	script_speak $07 ; $5632
	ret ; $5637
JuniorClassCourtDoublesNpc08_11:
	script_set_text Text_32_126 ; $5638
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $563e
	jr nz, .loop ; $5641
	farcall AdvanceDialogueTextCursor ; $5643
.loop:
	script_speak $08 ; $5646
	ret ; $564b
JuniorClassCourtDoublesNpc09_11:
	script_set_text Text_32_128 ; $564c
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $5652
	jr nz, JuniorClassCourtDoublesNpc08_11.loop ; $5655
	farcall AdvanceDialogueTextCursor ; $5657
	script_speak $09 ; $565a
	ret ; $565f
.loop:
	script_speak $0a ; $5660
	script_face_pair $0b, $0a ; $5665
	ret ; $566d
JuniorClassCourtDoublesNpc0A_11:
	script_set_text Text_32_135 ; $566e
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $5674
	jp nz, JuniorClassCourtDoublesNpc09_11.loop ; $5677
	script_set_text Text_32_131 ; $567a
	ld a, $0a ; $5680
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5682
	farcall RunDialogueYesNoPrompt ; $5685
	farcall ScriptCloseDialogueWindow ; $5688
	script_wait_frames $05 ; $568b
	and a, a ; $5692
	jr nz, JuniorClassCourtDoublesNpc09_11.loop ; $5693
	farcall AdvanceDialogueTextCursor ; $5695
	script_face_toward ACTOR_PLAYER, $0b ; $5698
	ld a, $0a ; $56a0
	farcall ScriptShowSpeakerDialogueRestoreBG ; $56a2
	farcall RunDialogueYesNoPrompt ; $56a5
	farcall ScriptCloseDialogueWindow ; $56a8
	script_wait_frames $05 ; $56ab
	and a, a ; $56b2
	jr nz, JuniorClassCourtDoublesNpc09_11.loop ; $56b3
	script_set_anim ACTOR_PLAYER, $03 ; $56b5
	script_null_script ACTOR_PARTNER ; $56bc
	script_set_speed ACTOR_PARTNER, $0020 ; $56c1
	script_set_speed ACTOR_PLAYER, $0020 ; $56c9
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_5bc6 ; $56d1
	script_wait_frames $14 ; $56dc
	script_set_actor_script ACTOR_PARTNER, ActorScript_11_5be0 ; $56e3
	script_wait_frames $1e ; $56ee
	script_move_player $3500, $1100 ; $56f5
	script_move_target $0a, $3700, $0d00 ; $56ff
	script_move_target $0b, $3500, $0900 ; $570a
	script_wait_move $0a ; $5715
	script_face $0a, FACE_DOWN ; $571a
	script_face $0b, FACE_DOWN ; $5721
	script_wait_actor_script ACTOR_PLAYER ; $5728
	ld hl, wStoryModePlayersXPosition ; $572d
	ld de, wStoryModeSpawnPosition ; $5730
	ld bc, $0005 ; $5733
	call CopyMemoryBC ; $5736
	ld a, $ff ; $5739
	ld [wStoryModeEntryPoint], a ; $573b
	ld [$c294], a ; $573e
	ld [wStoryModeExitLocationRequest], a ; $5741
	farcall WaitPlayerMoveDone ; $5744
	script_set_anim $0a, $03 ; $5747
	script_set_anim ACTOR_PLAYER, $03 ; $574e
	script_wait_idle ACTOR_PLAYER ; $5755
	farcall InitStoryMatchSettings ; $575a
	load_match_settings $0100 ; $575d
	farcall RunStoryMatch ; $576a
	farcall RestoreOverworldAfterMatch ; $576d
	ret ; $5770
JuniorClassCourtDoublesNpc0B_11:
	script_set_text Text_32_136 ; $5771
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $5777
	jr nz, .speak ; $577a
	script_set_text Text_32_130 ; $577c
	script_speak $0b ; $5782
	script_face_toward ACTOR_PLAYER, $0a ; $5787
	script_set_anim $0a, $02 ; $578f
	script_wait_idle $0a ; $5796
	jp JuniorClassCourtDoublesNpc0A_11 ; $579b
	script_set_text Text_32_82 ; $579e
	script_face_toward ACTOR_PLAYER, $0a ; $57a4
	script_set_anim $0a, $04 ; $57ac
	script_wait_idle $0a ; $57b3
	script_speak $0a ; $57b8
	script_face_toward $0b, $0a ; $57bd
	ret ; $57c5
.speak:
	script_speak $0b ; $57c6
	ret ; $57cb
JuniorClassCourtDoublesANpc0A_11:
	script_set_text Text_32_151 ; $57cc
	script_speak $0a ; $57d2
	script_set_anim $0a, $04 ; $57d7
	script_wait_idle $0a ; $57de
	script_speak $0a ; $57e3
	ret ; $57e8
JuniorClassCourtDoublesNpc03FaceUp_11:
	script_set_speed ACTOR_PLAYER, $0008 ; $57e9
	script_facing_lock ACTOR_PLAYER, $01 ; $57f1
	script_move_target ACTOR_PLAYER, $1300, $1500 ; $57f8
	script_wait_move ACTOR_PLAYER ; $5803
	script_facing_lock ACTOR_PLAYER, FACE_RIGHT ; $5808
	script_face ACTOR_PLAYER, FACE_UP ; $580f
JuniorClassCourtDoublesNpc03_11:
	call OfferDoublesRankingMatch ; $5816
	ret ; $5819
JuniorClassCourtDoublesNpcScripts_11:
	; $581a, 81 bytes (map_scripts)
	map_script $03, FACEMASK_UP, $0000, JuniorClassCourtDoublesNpc03FaceUp_11, $03, $00
	map_script $03, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc03_11, $03, $00
	map_script $04, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc04_11, $03, $00
	map_script $05, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc05_11, $03, $00
	map_script $06, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc06_11, $01, $00
	map_script $07, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc07_11, $03, $00
	map_script $08, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc08_11, $1b, $00
	map_script $09, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc09_11, $1b, $00
	map_script $0a, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc0A_11, $03, $00
	map_script $0b, FACEMASK_ANY, $0000, JuniorClassCourtDoublesNpc0B_11, $03, $00
	db $ff
JuniorClassCourtDoublesNpcScriptsA_11:
	; $586b, 73 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Text_32_137, $03, $00
	map_script $04, FACEMASK_ANY, $0000, Text_32_145, $01, $00
	map_script $05, FACEMASK_ANY, $0000, Text_32_147, $03, $00
	map_script $06, FACEMASK_ANY, $0000, Text_32_146, $11, $00
	map_script $07, FACEMASK_ANY, $0000, Text_32_148, $03, $00
	map_script $08, FACEMASK_ANY, $0000, Text_32_149, $1b, $00
	map_script $09, FACEMASK_ANY, $0000, Text_32_150, $1b, $00
	map_script $0a, FACEMASK_ANY, $0000, JuniorClassCourtDoublesANpc0A_11, $03, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_32_153, $03, $00
	db $ff
JuniorClassCourtDoublesNpcScriptsB_11:
	; $58b4, 73 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Text_32_162, $03, $00
	map_script $04, FACEMASK_ANY, $0000, Text_32_163, $01, $00
	map_script $05, FACEMASK_ANY, $0000, Text_32_165, $03, $00
	map_script $06, FACEMASK_ANY, $0000, Text_32_164, $11, $00
	map_script $07, FACEMASK_ANY, $0000, Text_32_166, $03, $00
	map_script $08, FACEMASK_ANY, $0000, Text_32_167, $1b, $00
	map_script $09, FACEMASK_ANY, $0000, Text_32_168, $1b, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_32_169, $01, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_32_170, $01, $00
	db $ff
JuniorClassCourtDoublesNpcScriptsC_11:
	; $58fd, 73 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Text_32_182, $03, $00
	map_script $04, FACEMASK_ANY, $0000, Text_32_183, $03, $00
	map_script $05, FACEMASK_ANY, $0000, Text_32_185, $03, $00
	map_script $06, FACEMASK_ANY, $0000, Text_32_184, $11, $00
	map_script $07, FACEMASK_ANY, $0000, JuniorClassCourtDoublesCNpc07_11, $03, $00
	map_script $08, FACEMASK_ANY, $0000, Text_32_189, $13, $00
	map_script $09, FACEMASK_ANY, $0000, Text_32_190, $1b, $00
	map_script $0a, FACEMASK_ANY, $0000, JuniorClassCourtDoublesCNpc0A_11, $03, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_32_195, $03, $00
	db $ff
JuniorClassCourtDoublesCNpc07_11:
	script_set_text Text_32_186 ; $5946
	ld a, $07 ; $594c
	farcall ScriptShowSpeakerDialogueRestoreBG ; $594e
	farcall RunDialogueYesNoPrompt ; $5951
	farcall ScriptCloseDialogueWindow ; $5954
	script_wait_frames $05 ; $5957
	and a, a ; $595e
	jp z, .speak ; $595f
	farcall AdvanceDialogueTextCursor ; $5962
.speak:
	script_speak $07 ; $5965
	ret ; $596a
JuniorClassCourtDoublesDNpc07_11:
	script_set_text Text_33_24 ; $596b
	ld a, $07 ; $5971
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5973
	farcall RunDialogueYesNoPrompt ; $5976
	farcall ScriptCloseDialogueWindow ; $5979
	script_wait_frames $05 ; $597c
	and a, a ; $5983
	jp z, .speak ; $5984
	farcall AdvanceDialogueTextCursor ; $5987
.speak:
	script_speak $07 ; $598a
	ret ; $598f
JuniorClassCourtDoublesCNpc0A_11:
	script_set_text Text_32_191 ; $5990
	script_speak $0a ; $5996
	set_flag FLAG_JUNIOR_COURT_NPC0A_TALKED ; $599b
	ret ; $599e
JuniorClassCourtDoublesNpcScriptsD_11:
	; $599f, 73 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Text_33_20, $01, $00
	map_script $04, FACEMASK_ANY, $0000, Text_33_21, $03, $00
	map_script $05, FACEMASK_ANY, $0000, Text_33_23, $03, $00
	map_script $06, FACEMASK_ANY, $0000, Text_33_22, $11, $00
	map_script $07, FACEMASK_ANY, $0000, JuniorClassCourtDoublesDNpc07_11, $03, $00
	map_script $08, FACEMASK_ANY, $0000, Text_33_27, $13, $00
	map_script $09, FACEMASK_ANY, $0000, Text_33_28, $1b, $00
	map_script $0a, FACEMASK_ANY, $0000, JuniorClassCourtDoublesDNpc0A_11, $03, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_33_29, $03, $00
	db $ff
JuniorClassCourtDoublesDNpc0A_11:
	test_flag FLAG_JUNIOR_COURT_NPC0A_TALKED ; $59e8
	jr nz, .setText ; $59eb
	script_set_text Text_33_15 ; $59ed
	script_speak $0a ; $59f3
	ret ; $59f8
.setText:
	script_set_text Text_33_30 ; $59f9
	ld a, $0a ; $59ff
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5a01
	farcall RunDialogueYesNoPrompt ; $5a04
	farcall ScriptCloseDialogueWindow ; $5a07
	script_wait_frames $05 ; $5a0a
	and a, a ; $5a11
	jp z, .speak ; $5a12
	farcall AdvanceDialogueTextCursor ; $5a15
.speak:
	script_speak $0a ; $5a18
	ret ; $5a1d
JuniorClassCourtDoublesFacingScripts_11:
	; $5a1e, 2 bytes (map_scripts)
	db $ff, $c9
JuniorClassCourtDoublesTileTriggers_11:
	; $5a20, 2 bytes (map_scripts)
	db $ff, $c9
JuniorClassCourtDoublesInitScript_11:
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $5a22
	jr nz, .stage2 ; $5a25
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $5a27
	jr z, .stage2 ; $5a2a
	script_set_position $08, $2500, $0900 ; $5a2c
	script_face $08, FACE_RIGHT ; $5a37
	script_set_actor_script $08, ActorScript_11_7ba9 ; $5a3e
	script_set_position $09, $2500, $0b00 ; $5a49
	script_face $09, FACE_RIGHT ; $5a54
	script_set_actor_script $09, ActorScript_11_7ba9 ; $5a5b
.stage2:
	ld a, [wStoryModeEntryPoint] ; $5a66
	cp a, $0f ; $5a69
	jp z, ActorScript_11_5d27.checkMatchExitRequest ; $5a6b
	cp a, $0e ; $5a6e
	jp z, ActorScript_11_5d27.eq012 ; $5a70
	cp a, $0d ; $5a73
	jp z, ActorScript_11_5d27.storeStoryModeShowLocationName ; $5a75
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $5a78
	jr nz, .stage3 ; $5a7b
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $5a7d
	jr nz, .stage4 ; $5a80
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $5a82
	jr nz, .placeActors ; $5a85
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $5a87
	jr nz, .done ; $5a8a
	ret ; $5a8c
.stage3:
	ld hl, JuniorClassCourtDoublesNpcScriptsD_11 ; $5a8d
	ld de, $000c ; $5a90
	farcall WriteStoryStateWord ; $5a93
	script_set_position $06, $2000, $1900 ; $5a96
	script_set_actor_script $06, ActorScript_11_7bb3 ; $5aa1
	ret ; $5aac
.stage4:
	ld hl, JuniorClassCourtDoublesNpcScriptsC_11 ; $5aad
	ld de, $000c ; $5ab0
	farcall WriteStoryStateWord ; $5ab3
	script_set_position $06, $2000, $1900 ; $5ab6
	script_set_actor_script $06, ActorScript_11_7bb3 ; $5ac1
	ret ; $5acc
.placeActors:
	ld hl, JuniorClassCourtDoublesNpcScriptsB_11 ; $5acd
	ld de, $000c ; $5ad0
	farcall WriteStoryStateWord ; $5ad3
	script_set_position $06, $2000, $1900 ; $5ad6
	script_set_actor_script $06, ActorScript_11_7bb3 ; $5ae1
	ret ; $5aec
.done:
	ld hl, JuniorClassCourtDoublesNpcScriptsA_11 ; $5aed
	ld de, $000c ; $5af0
	farcall WriteStoryStateWord ; $5af3
	script_set_position $06, $2000, $1900 ; $5af6
	script_set_actor_script $06, ActorScript_11_7bb3 ; $5b01
	script_face $0a, FACE_DOWN ; $5b0c
	ret ; $5b13
ActorScript_11_5b14:
	; $5b14, 20 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $1b00, $1300
	as_wait_move
	as_set_target $1b00, $1300
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_11_5b28:
	; $5b28, 26 bytes (actor_script)
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
ActorScript_11_5b42:
	; $5b42, 20 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $1b00, $1500
	as_wait_move
	as_set_target $1b00, $1500
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_11_5b56:
	; $5b56, 26 bytes (actor_script)
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
ActorScript_11_5b70:
	; $5b70, 20 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $1500, $0900
	as_wait_move
	as_set_target $1700, $0900
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_11_5b84:
	; $5b84, 20 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $1500, $0e00
	as_wait_move
	as_set_target $1b00, $0e00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_11_5b98:
	; $5b98, 26 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $1100, $0a00
	as_wait_move
	as_set_target $1100, $0a00
	as_wait_move
	as_set_target $0900, $0900
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_11_5bb2:
	; $5bb2, 20 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $1100, $0d00
	as_wait_move
	as_set_target $0b00, $0d00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_11_5bc6:
	; $5bc6, 26 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $3b00, $0a00
	as_wait_move
	as_set_target $3b00, $1900
	as_wait_move
	as_set_target $3700, $1900
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_11_5be0:
	; $5be0, 26 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $3b00, $0900
	as_wait_move
	as_set_target $3b00, $1500
	as_wait_move
	as_set_target $3500, $1500
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_11_5bfa:
	; $5bfa, 26 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $1100, $1900
	as_wait_move
	as_set_target $0500, $1900
	as_wait_move
	as_set_target $0500, $1500
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_11_5c14:
	; $5c14, 26 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $0900, $0900
	as_wait_move
	as_set_target $0500, $0900
	as_wait_move
	as_set_target $0500, $1500
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_11_5c2e:
	; $5c2e, 23 bytes (actor_script)
	as_set_target $0500, $1900
	as_wait_move
	as_set_target $1100, $1900
	as_wait_move
	as_set_target $1100, $1700
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_11_5c45:
	; $5c45, 26 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $1100, $1900
	as_wait_move
	as_set_target $0500, $1900
	as_wait_move
	as_set_target $0500, $1300
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_11_5c5f:
	; $5c5f, 32 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $0b00, $0d00
	as_wait_move
	as_set_target $0b00, $0900
	as_wait_move
	as_set_target $0500, $0900
	as_wait_move
	as_set_target $0500, $1300
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_11_5c7f:
	; $5c7f, 64 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $1500, $1900
	as_wait_move
	as_set_target $2100, $1900
	as_wait_move
	as_set_target $2100, $1700
	as_wait_move
	as_set_target $2300, $1700
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
	as_anim $01
	as_wait_move
	as_set_target $1900, $0900
	as_wait_move
	as_set_target $2700, $0900
	as_wait_move
	as_set_target $2500, $0900
	as_wait_move
	as_set_target $2500, $0900
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_11_5cbf:
	; $5cbf, 64 bytes (actor_script)
	as_anim $01
	as_wait_move
	as_set_target $1500, $1900
	as_wait_move
	as_set_target $2100, $1900
	as_wait_move
	as_set_target $2100, $1700
	as_wait_move
	as_set_target $2100, $1500
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
	as_anim $01
	as_wait_move
	as_set_target $2700, $0d00
	as_wait_move
	as_set_target $2700, $0b00
	as_wait_move
	as_set_target $2500, $0b00
	as_wait_move
	as_set_target $2500, $0b00
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_11_5cff:
	; $5cff, 40 bytes (actor_script)
	as_set_target $2100, $1900
	as_wait_move
	as_set_target $1500, $1900
	as_wait_move
	as_set_target $1500, $1700
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
	as_set_target $1300, $1900
	as_wait_move
	as_set_target $1900, $1500
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_11_5d27:
	; $5d27, 17 bytes (actor_script)
	as_set_target $1300, $1900
	as_wait_move
	as_set_target $0900, $1500
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
.checkMatchExitRequest:
	wram_bank $04 ; $5d38
	ld a, [wMatchExitRequest] ; $5d3e
	cp a, $01 ; $5d41
	jr z, .eq01 ; $5d43
	ld a, [wMatchWinLoseFlag] ; $5d45
	cp a, $01 ; $5d48
	jp z, .eq012 ; $5d4a
.eq01:
	script_player_speed $0040 ; $5d4d
	script_move_player $1300, $1500 ; $5d53
	script_set_position ACTOR_PLAYER, $1300, $1500 ; $5d5d
	script_set_position ACTOR_PARTNER, $1300, $1700 ; $5d68
	script_face ACTOR_PLAYER, FACE_UP ; $5d73
	script_face ACTOR_PARTNER, FACE_UP ; $5d7a
	farcall WaitPlayerMoveDone ; $5d81
	ret ; $5d84
.eq012:
	ld a, $0c ; $5d85
	ld [wStoryModeCurrentLocation], a ; $5d87
	ld a, $0d ; $5d8a
	ld [wStoryModeEntryPoint], a ; $5d8c
	ld a, $ff ; $5d8f
	ld [$c294], a ; $5d91
	ld [wStoryModeExitLocationRequest], a ; $5d94
	farcall StubNop_1e ; $5d97
	ret ; $5d9a
.storeStoryModeShowLocationName:
	xor a, a ; $5d9b
	ld [wStoryModeShowLocationName], a ; $5d9c
	script_null_script ACTOR_PARTNER ; $5d9f
	script_player_speed $0040 ; $5da4
	ld a, [wCurrentMinigameStoryMatch + 1] ; $5daa
	sub a, $02 ; $5dad
	ld a, a ; $5daf
	rst Rst00 ; $5db0
	dw ActorScript_11_5d27.setFlag ; $5db1 jumptable
	dw ActorScript_11_5d27.setFlag2 ; $5db3 jumptable
	dw ActorScript_11_5d27.setFlag3 ; $5db5 jumptable
.setFlag:
	set_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $5db7
	script_player_speed $0040 ; $5dba
	script_move_player $1900, $1100 ; $5dc0
	script_null_script $08 ; $5dca
	script_null_script $09 ; $5dcf
	script_set_anim $08, $01 ; $5dd4
	script_set_anim $09, $01 ; $5ddb
	script_set_position $08, $1900, $0d00 ; $5de2
	script_set_position $09, $1b00, $0d00 ; $5ded
	script_set_position ACTOR_PLAYER, $1b00, $1500 ; $5df8
	script_set_position ACTOR_PARTNER, $1900, $1500 ; $5e03
	script_face ACTOR_PLAYER, FACE_UP ; $5e0e
	script_face ACTOR_PARTNER, FACE_UP ; $5e15
	script_face $08, FACE_DOWN ; $5e1c
	script_face $09, FACE_DOWN ; $5e23
	script_face $03, FACE_RIGHT ; $5e2a
	farcall WaitPlayerMoveDone ; $5e31
	script_fade_in $04 ; $5e34
	call WaitFadeEnd ; $5e39
	script_set_text Text_32_101 ; $5e3c
	script_set_anim $08, $02 ; $5e42
	script_speak $08 ; $5e49
	script_set_anim $09, $04 ; $5e4e
	script_speak $09 ; $5e55
	script_jump_velocity $03, $ff80 ; $5e5a
	ld a, $03 ; $5e62
	farcall ScriptWaitActorJumpDone ; $5e64
	script_speak $03 ; $5e67
	script_set_actor_script $08, ActorScript_11_5b28 ; $5e6c
	script_set_actor_script $09, ActorScript_11_5b56 ; $5e77
	script_move_target ACTOR_PLAYER, $1300, $1700 ; $5e82
	script_move_target ACTOR_PARTNER, $1300, $1500 ; $5e8d
	script_face $03, FACE_DOWN ; $5e98
	script_wait_move ACTOR_PLAYER ; $5e9f
	script_face ACTOR_PLAYER, FACE_DOWN ; $5ea4
	script_wait_frames $28 ; $5eab
	script_get_actor_state ACTOR_PARTNER ; $5eb2
	ld c, l ; $5eb7
	ld b, h ; $5eb8
	ld de, $d000 ; $5eb9
	farcall AttachActorStepMover ; $5ebc
	ret ; $5ebf
.setFlag2:
	set_flag FLAG_WON_JUNIOR_DOUBLES_RANK_2 ; $5ec0
	call ParkLeftCourtPracticePairLeftSide ; $5ec3
	script_player_speed $0040 ; $5ec6
	script_move_player $0b00, $0f00 ; $5ecc
	script_set_position $07, $0b00, $0d00 ; $5ed6
	script_set_position $05, $0900, $0d00 ; $5ee1
	script_set_position ACTOR_PLAYER, $0900, $1500 ; $5eec
	script_set_position ACTOR_PARTNER, $0b00, $1900 ; $5ef7
	script_face ACTOR_PLAYER, FACE_UP ; $5f02
	script_face ACTOR_PARTNER, FACE_UP ; $5f09
	script_face $07, FACE_DOWN ; $5f10
	script_face $05, FACE_DOWN ; $5f17
	script_face $03, FACE_LEFT ; $5f1e
	farcall WaitPlayerMoveDone ; $5f25
	script_fade_in $04 ; $5f28
	call WaitFadeEnd ; $5f2d
	script_set_text Text_32_101 ; $5f30
	script_set_anim $07, $02 ; $5f36
	script_speak $07 ; $5f3d
	script_set_anim $05, $04 ; $5f42
	script_speak $05 ; $5f49
	script_set_text Text_32_104 ; $5f4e
	script_jump_velocity $03, $ff80 ; $5f54
	ld a, $03 ; $5f5c
	farcall ScriptWaitActorJumpDone ; $5f5e
	script_speak $03 ; $5f61
	script_set_actor_script $07, ActorScript_11_5c14 ; $5f66
	script_set_actor_script $05, ActorScript_11_5c5f ; $5f71
	script_move_target ACTOR_PLAYER, $1300, $1700 ; $5f7c
	script_move_target ACTOR_PARTNER, $1300, $1500 ; $5f87
	call ResumeLeftCourtPractice ; $5f92
	script_face $03, FACE_DOWN ; $5f95
	script_wait_frames $3c ; $5f9c
	script_wait_move ACTOR_PLAYER ; $5fa3
	script_face ACTOR_PLAYER, FACE_DOWN ; $5fa8
	script_get_actor_state ACTOR_PARTNER ; $5faf
	ld c, l ; $5fb4
	ld b, h ; $5fb5
	ld de, $d000 ; $5fb6
	farcall AttachActorStepMover ; $5fb9
	ret ; $5fbc
.setFlag3:
	set_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $5fbd
	script_player_speed $0040 ; $5fc0
	script_move_player $1900, $0d00 ; $5fc6
	script_set_position $08, $2500, $0900 ; $5fd0
	script_face $08, FACE_RIGHT ; $5fdb
	script_set_actor_script $08, ActorScript_11_7ba9 ; $5fe2
	script_set_position $09, $2500, $0b00 ; $5fed
	script_face $09, FACE_RIGHT ; $5ff8
	script_set_position $03, $1300, $1f00 ; $5fff
	script_set_position $04, $1900, $0e00 ; $600a
	script_set_position $06, $1b00, $0e00 ; $6015
	script_set_position ACTOR_PLAYER, $1b00, $1300 ; $6020
	script_set_position ACTOR_PARTNER, $1900, $1300 ; $602b
	script_face ACTOR_PLAYER, FACE_UP ; $6036
	script_face ACTOR_PARTNER, FACE_UP ; $603d
	script_face $04, FACE_DOWN ; $6044
	script_face $06, FACE_DOWN ; $604b
	script_face $03, FACE_UP ; $6052
	farcall WaitPlayerMoveDone ; $6059
	script_fade_in $04 ; $605c
	call WaitFadeEnd ; $6061
	script_wait_frames $1e ; $6064
	script_set_text Text_32_113 ; $606b
	script_set_anim $04, $02 ; $6071
	script_speak $04 ; $6078
	script_set_anim $06, $04 ; $607d
	script_speak $06 ; $6084
	script_set_anim $03, $03 ; $6089
	script_speak $03 ; $6090
	script_set_anim $04, $02 ; $6095
	script_set_anim $06, $02 ; $609c
	script_set_anim ACTOR_PLAYER, $02 ; $60a3
	script_set_anim ACTOR_PARTNER, $02 ; $60aa
	script_wait_frames $1e ; $60b1
	script_face ACTOR_PLAYER, FACE_DOWN ; $60b8
	script_face ACTOR_PARTNER, FACE_DOWN ; $60bf
	script_player_speed $0010 ; $60c6
	script_set_speed $03, $0010 ; $60cc
	script_move_player $1500, $1700 ; $60d4
	farcall WaitPlayerMoveDone ; $60de
	script_move_target $03, $1300, $1b00 ; $60e1
	script_wait_move $03 ; $60ec
	farcall WaitPlayerMoveDone ; $60f1
	script_move_player $1a00, $1300 ; $60f4
	script_move_target $03, $1a00, $1700 ; $60fe
	script_wait_move $03 ; $6109
	script_face $03, FACE_UP ; $610e
	script_set_anim $03, $02 ; $6115
	script_wait_idle $03 ; $611c
	script_speak $03 ; $6121
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $6126
	script_wait_frames $1e ; $612e
	script_face ACTOR_PLAYER, FACE_DOWN ; $6135
	script_face ACTOR_PARTNER, FACE_DOWN ; $613c
	script_set_anim ACTOR_PLAYER, $03 ; $6143
	script_set_anim ACTOR_PARTNER, $03 ; $614a
	script_wait_idle ACTOR_PARTNER ; $6151
	script_wait_frames $1e ; $6156
	script_set_text Text_32_117 ; $615d
	script_set_anim $03, $03 ; $6163
	script_wait_idle $03 ; $616a
	script_speak $03 ; $616f
	script_move_target $03, $1b00, $1500 ; $6174
	script_wait_move $03 ; $617f
	script_speak ACTOR_PLAYER ; $6184
	script_wait_frames $1e ; $6189
	script_set_anim $03, $02 ; $6190
	script_speak $03 ; $6197
	script_set_anim ACTOR_PLAYER, $03 ; $619c
	script_set_anim ACTOR_PARTNER, $03 ; $61a3
	script_wait_idle ACTOR_PARTNER ; $61aa
	script_set_anim $03, $03 ; $61af
	script_wait_idle $03 ; $61b6
	script_face_pair $06, $04 ; $61bb
	script_wait_frames $1e ; $61c3
	script_face $04, FACE_DOWN ; $61ca
	script_face $06, FACE_DOWN ; $61d1
	script_set_anim $06, $02 ; $61d8
	script_speak $06 ; $61df
	script_face ACTOR_PLAYER, FACE_UP ; $61e4
	script_face ACTOR_PARTNER, FACE_UP ; $61eb
	script_set_anim $04, $03 ; $61f2
	script_wait_idle $04 ; $61f9
	script_speak $06 ; $61fe
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $6203
	script_wait_frames $14 ; $620b
	script_set_anim ACTOR_PLAYER, $02 ; $6212
	script_set_anim ACTOR_PARTNER, $02 ; $6219
	script_wait_idle ACTOR_PARTNER ; $6220
	script_wait_frames $1e ; $6225
	script_face ACTOR_PLAYER, FACE_UP ; $622c
	script_face ACTOR_PARTNER, FACE_UP ; $6233
	script_set_anim ACTOR_PLAYER, $03 ; $623a
	script_set_anim ACTOR_PARTNER, $03 ; $6241
	script_wait_idle ACTOR_PARTNER ; $6248
	script_wait_frames $1e ; $624d
	script_set_anim $04, $03 ; $6254
	script_set_anim $06, $03 ; $625b
	script_wait_idle $06 ; $6262
	script_wait_frames $3c ; $6267
	script_set_anim $03, $03 ; $626e
	ld a, $0c ; $6275
	ld [wStoryModeCurrentLocation], a ; $6277
	ld a, $01 ; $627a
	ld [wStoryModeEntryPoint], a ; $627c
	ld a, $ff ; $627f
	ld [$c294], a ; $6281
	ld [wStoryModeExitLocationRequest], a ; $6284
	script_wait_frames $3c ; $6287
	ld c, $04 ; $628e
	call BeginFadeOut ; $6290
	call WaitFadeEnd ; $6293
	script_wait_frames $1e ; $6296
	ret ; $629d
OfferDoublesRankingMatch:
	script_set_text Text_32_90 ; $629e
	ld a, $03 ; $62a4
	farcall ScriptShowSpeakerDialogueRestoreBG ; $62a6
	farcall RunDialogueYesNoPrompt ; $62a9
	farcall ScriptCloseDialogueWindow ; $62ac
	script_wait_frames $05 ; $62af
	and a, a ; $62b6
	jp nz, .speak ; $62b7
	script_set_speed ACTOR_PLAYER, $0010 ; $62ba
	script_set_speed ACTOR_PARTNER, $0010 ; $62c2
	script_move_target ACTOR_PLAYER, $1300, $1500 ; $62ca
	script_move_target ACTOR_PARTNER, $1300, $1700 ; $62d5
	farcall AdvanceDialogueTextCursor ; $62e0
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $62e3
	jr z, .wait ; $62e6
	farcall AdvanceDialogueTextCursor ; $62e8
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_2 ; $62eb
	jr z, .wait ; $62ee
	farcall AdvanceDialogueTextCursor ; $62f0
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $62f3
	jr z, .wait ; $62f6
	farcall AdvanceDialogueTextCursor ; $62f8
.wait:
	script_wait_move ACTOR_PLAYER ; $62fb
	script_face ACTOR_PLAYER, FACE_UP ; $6300
	script_face $03, FACE_DOWN ; $6307
	script_move_target ACTOR_PARTNER, $1300, $1700 ; $630e
	script_wait_move ACTOR_PARTNER ; $6319
	script_face ACTOR_PARTNER, FACE_UP ; $631e
	script_speak $03 ; $6325
	call DrawDoublesRankingOpponentInfo ; $632a
	script_face ACTOR_PLAYER, FACE_UP ; $632d
	script_wait_frames $0f ; $6334
	script_set_anim $03, $02 ; $633b
	script_wait_idle $03 ; $6342
	call PromptChallengeRankingOpponent ; $6347
	ret ; $634a
.speak:
	script_speak $03 ; $634b
	ret ; $6350
DrawDoublesRankingOpponentInfo:
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $6351
	jp z, .rank2 ; $6354
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_2 ; $6357
	jp z, .rank3 ; $635a
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $635d
	jp z, .done ; $6360
	ret ; $6363
.rank2:
	script_player_speed $0020 ; $6364
	script_face $03, FACE_RIGHT ; $636a
	script_move_player_to_actor $08 ; $6371
	farcall WaitPlayerMoveDone ; $6378
	script_null_script $08 ; $637b
	script_null_script $09 ; $6380
	script_set_anim $09, $01 ; $6385
	script_face $08, FACE_LEFT ; $638c
	script_face $09, FACE_LEFT ; $6393
	script_wait_frames $32 ; $639a
	script_face ACTOR_PLAYER, FACE_RIGHT ; $63a1
	script_face ACTOR_PARTNER, FACE_RIGHT ; $63a8
	script_set_text Text_32_95 ; $63af
	script_set_anim $08, $02 ; $63b5
	script_wait_idle $08 ; $63bc
	script_move_target $08, $1500, $1500 ; $63c1
	script_move_target $09, $1500, $1700 ; $63cc
	script_wait_move $09 ; $63d7
	script_face $09, FACE_LEFT ; $63dc
	script_move_player_to_actor ACTOR_PLAYER ; $63e3
	script_face $03, FACE_DOWN ; $63ea
	script_set_anim $08, $02 ; $63f1
	script_wait_idle $08 ; $63f8
	script_speak $08 ; $63fd
	script_set_anim $09, $03 ; $6402
	script_speak $09 ; $6409
	script_wait_frames $0f ; $640e
	script_face ACTOR_PLAYER, FACE_UP ; $6415
	script_face ACTOR_PARTNER, FACE_UP ; $641c
	script_face $08, FACE_UP ; $6423
	script_face $09, FACE_UP ; $642a
	ret ; $6431
.rank3:
	script_player_speed $0020 ; $6432
	script_face $03, FACE_LEFT ; $6438
	script_move_player_to_actor $05 ; $643f
	farcall WaitPlayerMoveDone ; $6446
	script_face ACTOR_PLAYER, FACE_LEFT ; $6449
	script_face ACTOR_PARTNER, FACE_LEFT ; $6450
	script_wait_frames $1e ; $6457
	script_set_text Text_32_97 ; $645e
	script_set_actor_script $05, ActorScript_11_76e9 ; $6464
	script_set_actor_script $07, ActorScript_11_5c2e ; $646f
	script_move_player_to_actor ACTOR_PLAYER ; $647a
	script_face $03, FACE_DOWN ; $6481
	farcall WaitPlayerMoveDone ; $6488
	script_wait_frames $1e ; $648b
	script_set_anim $05, $04 ; $6492
	script_wait_idle $05 ; $6499
	script_speak $05 ; $649e
	script_face_pair $07, $05 ; $64a3
	script_wait_frames $1e ; $64ab
	script_set_anim $07, $03 ; $64b2
	script_speak $07 ; $64b9
	script_face ACTOR_PLAYER, FACE_UP ; $64be
	script_face ACTOR_PARTNER, FACE_UP ; $64c5
	script_face $05, FACE_UP ; $64cc
	script_face $07, FACE_UP ; $64d3
	ret ; $64da
.done:
	script_player_speed $0020 ; $64db
	script_face $03, FACE_RIGHT ; $64e1
	script_wait_frames $14 ; $64e8
	script_face ACTOR_PLAYER, FACE_RIGHT ; $64ef
	script_face ACTOR_PARTNER, FACE_RIGHT ; $64f6
	script_move_player_to_actor $04 ; $64fd
	farcall WaitPlayerMoveDone ; $6504
	script_face $06, FACE_LEFT ; $6507
	script_set_anim $06, $02 ; $650e
	script_wait_idle $06 ; $6515
	script_set_text Text_32_99 ; $651a
	script_set_actor_script $04, ActorScript_11_7728 ; $6520
	script_wait_frames $0f ; $652b
	script_set_actor_script $06, ActorScript_11_5cff ; $6532
	script_move_player_to_actor ACTOR_PLAYER ; $653d
	script_face $03, FACE_DOWN ; $6544
	farcall WaitPlayerMoveDone ; $654b
	script_wait_frames $0f ; $654e
	script_set_anim $04, $02 ; $6555
	script_wait_idle $04 ; $655c
	script_speak $04 ; $6561
	script_set_anim $06, $03 ; $6566
	script_speak $06 ; $656d
	script_wait_frames $14 ; $6572
	script_face ACTOR_PLAYER, FACE_UP ; $6579
	script_face ACTOR_PARTNER, FACE_UP ; $6580
	script_face $04, FACE_UP ; $6587
	script_face $06, FACE_UP ; $658e
	ret ; $6595
StartNextDoublesRankingMatch:
	script_set_speed ACTOR_PLAYER, $0020 ; $6596
	script_set_speed ACTOR_PARTNER, $0020 ; $659e
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $65a6
	jp z, .rank2 ; $65a9
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_2 ; $65ac
	jp z, .rank3 ; $65af
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $65b2
	jp z, .done ; $65b5
	ret ; $65b8
.rank2:
	script_face $03, FACE_RIGHT ; $65b9
	script_wait_frames $1e ; $65c0
	script_null_script ACTOR_PARTNER ; $65c7
	script_move_player $1900, $1100 ; $65cc
	script_set_actor_script $08, ActorScript_11_5b70 ; $65d6
	script_set_actor_script $09, ActorScript_11_5b84 ; $65e1
	script_move_target ACTOR_PLAYER, $1b00, $1900 ; $65ec
	script_wait_frames $0a ; $65f7
	script_move_target ACTOR_PARTNER, $1900, $1500 ; $65fe
	script_wait_move ACTOR_PLAYER ; $6609
	script_face ACTOR_PLAYER, FACE_UP ; $660e
	script_face ACTOR_PARTNER, FACE_UP ; $6615
	script_wait_frames $3c ; $661c
	ld a, $0f ; $6623
	ld [$c294], a ; $6625
	ld [wStoryModeExitLocationRequest], a ; $6628
	farcall InitStoryMatchSettings ; $662b
	load_match_settings $0102 ; $662e
	farcall RunStoryMatch ; $663b
	farcall RestoreOverworldAfterMatch ; $663e
	ret ; $6641
.rank3:
	script_face $03, FACE_LEFT ; $6642
	script_wait_frames $0f ; $6649
	script_face ACTOR_PLAYER, FACE_LEFT ; $6650
	script_face ACTOR_PARTNER, FACE_LEFT ; $6657
	script_face $05, FACE_LEFT ; $665e
	script_face $07, FACE_LEFT ; $6665
	script_set_actor_script $0c, ActorScript_11_6df8 ; $666c
	script_set_actor_script $0d, ActorScript_11_6e07 ; $6677
	script_wait_actor_script $0d ; $6682
	script_null_script ACTOR_PARTNER ; $6687
	script_move_player $0b00, $1100 ; $668c
	script_set_actor_script $05, ActorScript_11_5b98 ; $6696
	script_set_actor_script $07, ActorScript_11_5bb2 ; $66a1
	script_wait_frames $1e ; $66ac
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_7773 ; $66b3
	script_set_actor_script ACTOR_PARTNER, ActorScript_11_5d27 ; $66be
	script_wait_actor_script ACTOR_PLAYER ; $66c9
	script_face ACTOR_PLAYER, FACE_UP ; $66ce
	script_face ACTOR_PARTNER, FACE_UP ; $66d5
	script_wait_frames $3c ; $66dc
	ld a, $0f ; $66e3
	ld [$c294], a ; $66e5
	ld [wStoryModeExitLocationRequest], a ; $66e8
	farcall InitStoryMatchSettings ; $66eb
	load_match_settings $0103 ; $66ee
	farcall RunStoryMatch ; $66fb
	farcall RestoreOverworldAfterMatch ; $66fe
	ret ; $6701
.done:
	script_face $03, FACE_RIGHT ; $6702
	script_wait_frames $0f ; $6709
	script_face ACTOR_PLAYER, FACE_RIGHT ; $6710
	script_face $07, FACE_RIGHT ; $6717
	script_wait_frames $1e ; $671e
	script_null_script ACTOR_PARTNER ; $6725
	script_move_player $1900, $1100 ; $672a
	script_set_actor_script $04, ActorScript_11_5b70 ; $6734
	script_set_actor_script $06, ActorScript_11_5b84 ; $673f
	script_move_target ACTOR_PLAYER, $1b00, $1900 ; $674a
	script_wait_frames $14 ; $6755
	script_move_target ACTOR_PARTNER, $1900, $1500 ; $675c
	script_wait_move ACTOR_PLAYER ; $6767
	script_face ACTOR_PLAYER, FACE_UP ; $676c
	script_face ACTOR_PARTNER, FACE_UP ; $6773
	script_wait_frames $3c ; $677a
	ld a, $0f ; $6781
	ld [$c294], a ; $6783
	ld [wStoryModeExitLocationRequest], a ; $6786
	farcall InitStoryMatchSettings ; $6789
	load_match_settings $0104 ; $678c
	farcall RunStoryMatch ; $6799
	farcall RestoreOverworldAfterMatch ; $679c
	ret ; $679f
LoadDoublesRankingOpponentGraphics:
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $67a0
	jr z, .rank2 ; $67a3
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_2 ; $67a5
	jr z, .rank3 ; $67a8
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $67aa
	jr z, .done ; $67ad
	ret ; $67af
.rank2:
	script_set_actor_script $08, ActorScript_11_5b14 ; $67b0
	script_set_actor_script $09, ActorScript_11_5b42 ; $67bb
	script_wait_actor_script $09 ; $67c6
	script_set_actor_script $09, ActorScript_11_681f ; $67cb
	script_wait_actor_script $08 ; $67d6
	script_set_actor_script $08, ActorScript_11_7d86 ; $67db
	ret ; $67e6
.rank3:
	script_set_actor_script $05, ActorScript_11_5bfa ; $67e7
	script_set_actor_script $07, ActorScript_11_5c45 ; $67f2
	script_wait_actor_script $05 ; $67fd
	ret ; $6802
.done:
	script_set_actor_script $04, ActorScript_11_5c7f ; $6803
	script_set_actor_script $06, ActorScript_11_5cbf ; $680e
	script_wait_actor_script $04 ; $6819
	ret ; $681e
ActorScript_11_681f:
	; $681f, 3 bytes (actor_script)
	as_anim $06
	as_halt
JuniorClassCourtSinglesMapScripts_11:
	; $6822, 14 bytes (map_tree)
	dw JuniorClassCourtSinglesEntryPoints_11 ; slot 0 EntryPoints
	dw JuniorClassCourtSinglesExitTriggers_11 ; slot 1 ExitTriggers
	dw JuniorClassCourtSinglesActors_11 ; slot 2 Actors
	dw JuniorClassCourtSinglesNpcScripts_11 ; slot 3 NpcScripts
	dw JuniorClassCourtSinglesFacingScripts_11 ; slot 4 FacingScripts
	dw JuniorClassCourtSinglesTileTriggers_11 ; slot 5 TileTriggers
	dw JuniorClassCourtSinglesInitScript_11 ; slot 6 InitScript
JuniorClassCourtSinglesActors_11:
	; $6830, 234 bytes (map_actors)
	map_actor $0000, ActorScript_11_7ba9, $1300, $1300, FACE_DOWN, $37, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $2300, $1700, FACE_LEFT, $68, $01, $05
	map_actor $0000, ActorScript_11_7ba9, $0500, $1500, FACE_RIGHT, $6b, $01, $04
	map_actor $0000, ActorScript_11_7ba9, $1300, $0d00, FACE_RIGHT, $67, $01, $07
	map_actor $0000, ActorScript_11_7ba9, $1f00, $1500, FACE_LEFT, $6a, $01, $07
	map_actor $0000, ActorScript_11_7ba9, $2500, $0900, FACE_RIGHT, $66, $01, $03
	map_actor $0000, ActorScript_11_7ba9, $3100, $1500, FACE_RIGHT, $65, $01, $06
	map_actor $0000, ActorScript_11_7ba9, $3d00, $1900, FACE_LEFT, $64, $01, $04
	map_actor $0000, ActorScript_11_6e16, $3100, $0700, FACE_DOWN, $69, $01, $03
	map_actor $0000, ActorScript_11_7ca9, $0800, $0b00, FACE_DOWN, $54, $01, $05
	map_actor $0000, ActorScript_11_7d10, $0c00, $1700, FACE_UP, $54, $01, $00
	map_actor $0000, ActorScript_11_7bdf, $1800, $0b00, FACE_DOWN, $54, $01, $00
	map_actor $0000, ActorScript_11_7c42, $1c00, $1700, FACE_UP, $54, $01, $05
	map_actor $0000, ActorScript_11_7ca9, $3400, $0b00, FACE_DOWN, $54, $01, $05
	map_actor $0000, ActorScript_11_7d10, $3800, $1700, FACE_UP, $54, $01, $00
	map_actor $0000, ActorScript_11_7ba9, $4000, $4000, FACE_UP, $53, $01, $00
	map_actor_end
JuniorClassCourtSinglesEntryPoints_11:
	; $691a, 18 bytes (map_entries)
	map_entry $01, FACE_UP, $1300, $1d00, MapArrivalWalk_11
	map_entry $09, FACE_UP, $2d00, $1900, $0000
	db $ff, $c9
JuniorClassCourtSinglesExitTriggers_11:
	; $692c, 17 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_11, $08, $05
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_11, $0b, $0f
	db $ff
JuniorClassCourtSinglesNpc03FaceUp_11:
	script_set_speed ACTOR_PLAYER, $0008 ; $693d
	script_facing_lock ACTOR_PLAYER, $01 ; $6945
	script_move_target ACTOR_PLAYER, $1300, $1500 ; $694c
	script_wait_move ACTOR_PLAYER ; $6957
	script_facing_lock ACTOR_PLAYER, FACE_RIGHT ; $695c
	script_face ACTOR_PLAYER, FACE_UP ; $6963
JuniorClassCourtSinglesNpc03_11:
	call OfferSinglesRankingMatch ; $696a
	ret ; $696d
JuniorClassCourtSinglesNpc04_11:
	script_set_text Text_32_62 ; $696e
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $6974
	jr nz, .speak ; $6977
	farcall AdvanceDialogueTextCursor ; $6979
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_2 ; $697c
	jr nz, .speak ; $697f
	farcall AdvanceDialogueTextCursor ; $6981
.speak:
	script_speak $04 ; $6984
	ret ; $6989
JuniorClassCourtSinglesNpc05_11:
	script_set_text Text_32_65 ; $698a
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_2 ; $6990
	jr nz, .altText ; $6993
	farcall AdvanceDialogueTextCursor ; $6995
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_3 ; $6998
	jr nz, .speak ; $699b
	script_set_text Text_32_69 ; $699d
.altText:
	script_speak $05 ; $69a3
	ret ; $69a8
.speak:
	ld a, $05 ; $69a9
	farcall ScriptShowSpeakerDialogueRestoreBG ; $69ab
	farcall RunDialogueYesNoPrompt ; $69ae
	farcall ScriptCloseDialogueWindow ; $69b1
	script_wait_frames $05 ; $69b4
	and a, a ; $69bb
	jr z, .done ; $69bc
	farcall AdvanceDialogueTextCursor ; $69be
.done:
	script_speak $05 ; $69c1
	ret ; $69c6
JuniorClassCourtSinglesNpc06_11:
	script_set_text Text_32_70 ; $69c7
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_3 ; $69cd
	jr nz, .speak ; $69d0
	farcall AdvanceDialogueTextCursor ; $69d2
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $69d5
	jr nz, .speak ; $69d8
	farcall AdvanceDialogueTextCursor ; $69da
	ld a, $06 ; $69dd
	farcall ScriptShowSpeakerDialogueRestoreBG ; $69df
	farcall RunDialogueYesNoPrompt ; $69e2
	farcall ScriptCloseDialogueWindow ; $69e5
	script_wait_frames $05 ; $69e8
	and a, a ; $69ef
	jr z, .speak ; $69f0
	farcall AdvanceDialogueTextCursor ; $69f2
.speak:
	script_speak $06 ; $69f5
	ret ; $69fa
JuniorClassCourtSinglesNpc07_11:
	script_set_text Text_32_75 ; $69fb
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $6a01
	jr nz, .speak ; $6a04
	farcall AdvanceDialogueTextCursor ; $6a06
.speak:
	script_speak $07 ; $6a09
	ret ; $6a0e
JuniorClassCourtSinglesNpc08_11:
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $6a0f
	jr z, .altText ; $6a12
	script_set_text Text_32_86 ; $6a14
	script_speak $08 ; $6a1a
	ret ; $6a1f
.altText:
	script_set_text Text_32_77 ; $6a20
	ld a, $08 ; $6a26
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6a28
	farcall RunDialogueYesNoPrompt ; $6a2b
	farcall ScriptCloseDialogueWindow ; $6a2e
	script_wait_frames $05 ; $6a31
	and a, a ; $6a38
	jr z, .done ; $6a39
.speak:
	script_speak $08 ; $6a3b
	ret ; $6a40
.done:
	farcall AdvanceDialogueTextCursor ; $6a41
	ld a, $08 ; $6a44
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6a46
	farcall RunDialogueYesNoPrompt ; $6a49
	farcall ScriptCloseDialogueWindow ; $6a4c
	script_wait_frames $05 ; $6a4f
	and a, a ; $6a56
	jr nz, .speak ; $6a57
	script_set_anim ACTOR_PLAYER, $03 ; $6a59
	script_wait_idle ACTOR_PLAYER ; $6a60
	script_move_player $2b00, $1100 ; $6a65
	script_move_target ACTOR_PLAYER, $2700, $1900 ; $6a6f
	script_wait_frames $1e ; $6a7a
	script_move_target $08, $2b00, $0900 ; $6a81
	script_wait_move $08 ; $6a8c
	script_face $08, FACE_DOWN ; $6a91
	script_wait_move ACTOR_PLAYER ; $6a98
	script_move_target ACTOR_PLAYER, $2d00, $1900 ; $6a9d
	script_wait_move ACTOR_PLAYER ; $6aa8
	script_face ACTOR_PLAYER, FACE_UP ; $6aad
	script_wait_frames $3c ; $6ab4
	ld hl, wStoryModePlayersXPosition ; $6abb
	ld de, wStoryModeSpawnPosition ; $6abe
	ld bc, $0005 ; $6ac1
	call CopyMemoryBC ; $6ac4
	ld a, $ff ; $6ac7
	ld [wStoryModeEntryPoint], a ; $6ac9
	ld [$c294], a ; $6acc
	ld [wStoryModeExitLocationRequest], a ; $6acf
	farcall InitStoryMatchSettings ; $6ad2
	load_match_settings $0000 ; $6ad5
	farcall RunStoryMatch ; $6ae2
	farcall RestoreOverworldAfterMatch ; $6ae5
	ret ; $6ae8
JuniorClassCourtSinglesNpc09_11:
	script_set_text Text_32_81 ; $6ae9
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $6aef
	jr z, .speak ; $6af2
	script_set_text Text_32_87 ; $6af4
.speak:
	script_speak $09 ; $6afa
	ret ; $6aff
JuniorClassCourtSinglesNpc0A_11:
	script_set_text Text_32_82 ; $6b00
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $6b06
	jr z, .speak ; $6b09
	script_set_text Text_32_88 ; $6b0b
.speak:
	script_speak $0a ; $6b11
	ret ; $6b16
JuniorClassCourtSinglesNpc0B_11:
	script_face_toward ACTOR_PLAYER, $0b ; $6b17
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $6b1f
	jr z, .setText ; $6b22
	script_set_text Text_32_89 ; $6b24
	script_speak $0b ; $6b2a
	ret ; $6b2f
.setText:
	script_set_text Text_32_83 ; $6b30
	ld a, $0b ; $6b36
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6b38
	farcall RunDialogueYesNoPrompt ; $6b3b
	farcall ScriptCloseDialogueWindow ; $6b3e
	script_wait_frames $05 ; $6b41
	and a, a ; $6b48
	jr z, .speak ; $6b49
	farcall AdvanceDialogueTextCursor ; $6b4b
.speak:
	script_speak $0b ; $6b4e
	ret ; $6b53
JuniorClassCourtSinglesNpcScripts_11:
	; $6b54, 81 bytes (map_scripts)
	map_script $03, FACEMASK_UP, $0000, JuniorClassCourtSinglesNpc03FaceUp_11, $03, $00
	map_script $03, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc03_11, $03, $00
	map_script $04, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc04_11, $03, $00
	map_script $05, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc05_11, $03, $00
	map_script $06, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc06_11, $03, $00
	map_script $07, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc07_11, $03, $00
	map_script $08, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc08_11, $01, $00
	map_script $09, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc09_11, $03, $00
	map_script $0a, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc0A_11, $03, $00
	map_script $0b, FACEMASK_ANY, $0000, JuniorClassCourtSinglesNpc0B_11, $1b, $00
	db $ff
JuniorClassCourtSinglesNpcScriptsA_11:
	; $6ba5, 65 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Text_32_137, $01, $00
	map_script $05, FACEMASK_ANY, $0000, Text_32_138, $03, $00
	map_script $06, FACEMASK_ANY, $0000, Text_32_139, $01, $00
	map_script $07, FACEMASK_ANY, $0000, Text_32_140, $03, $00
	map_script $08, FACEMASK_ANY, $0000, Text_32_141, $03, $00
	map_script $09, FACEMASK_ANY, $0000, Text_32_142, $03, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_32_143, $13, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_32_144, $13, $00
	db $ff
JuniorClassCourtSinglesNpcScriptsB_11:
	; $6be6, 65 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Text_32_154, $03, $00
	map_script $05, FACEMASK_ANY, $0000, Text_32_155, $03, $00
	map_script $06, FACEMASK_ANY, $0000, Text_32_156, $01, $00
	map_script $07, FACEMASK_ANY, $0000, Text_32_157, $03, $00
	map_script $08, FACEMASK_ANY, $0000, Text_32_158, $03, $00
	map_script $09, FACEMASK_ANY, $0000, Text_32_159, $03, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_32_160, $13, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_32_161, $13, $00
	db $ff
JuniorClassCourtSinglesNpcScriptsC_11:
	; $6c27, 65 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Text_32_171, $03, $00
	map_script $05, FACEMASK_ANY, $0000, Text_32_172, $03, $00
	map_script $06, FACEMASK_ANY, $0000, Text_32_173, $01, $00
	map_script $07, FACEMASK_ANY, $0000, Text_32_174, $03, $00
	map_script $08, FACEMASK_ANY, $0000, Text_32_175, $03, $00
	map_script $09, FACEMASK_ANY, $0000, Text_32_176, $03, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_32_177, $03, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_32_181, $13, $00
	db $ff
JuniorClassCourtSinglesNpcScriptsD_11:
	; $6c68, 65 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Text_33_9, $01, $00
	map_script $05, FACEMASK_ANY, $0000, Text_33_10, $03, $00
	map_script $06, FACEMASK_ANY, $0000, Text_33_11, $01, $00
	map_script $07, FACEMASK_ANY, $0000, Text_33_12, $03, $00
	map_script $08, FACEMASK_ANY, $0000, Text_33_13, $03, $00
	map_script $09, FACEMASK_ANY, $0000, Text_33_14, $03, $00
	map_script $0a, FACEMASK_ANY, $0000, JuniorClassCourtSinglesDNpc0A_11, $03, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_33_19, $13, $00
	db $ff
JuniorClassCourtSinglesDNpc0A_11:
	test_flag FLAG_JUNIOR_COURT_NPC0A_TALKED ; $6ca9
	jr nz, .altText ; $6cac
	script_set_text Text_33_15 ; $6cae
	script_speak $0a ; $6cb4
	ret ; $6cb9
.altText:
	script_set_text Text_33_16 ; $6cba
	ld a, $0a ; $6cc0
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6cc2
	farcall RunDialogueYesNoPrompt ; $6cc5
	farcall ScriptCloseDialogueWindow ; $6cc8
	script_wait_frames $05 ; $6ccb
	and a, a ; $6cd2
	jp z, .speak ; $6cd3
	farcall AdvanceDialogueTextCursor ; $6cd6
.speak:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $6cd9
	jr nz, .done ; $6cdc
	script_speak $0a ; $6cde
	ret ; $6ce3
.done:
	script_set_anim $0a, $03 ; $6ce4
	script_wait_idle $0a ; $6ceb
	script_set_text Text_33_31 ; $6cf0
	script_speak $0a ; $6cf6
	ret ; $6cfb
JuniorClassCourtSinglesFacingScripts_11:
	ds 1, $ff ; $6cfc, fill
JuniorClassCourtSinglesTileTriggers_11:
	ds 1, $ff ; $6cfd, fill
JuniorClassCourtSinglesInitScript_11:
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $6cfe
	jr z, .stage2 ; $6d01
	script_set_position $07, $2500, $0b00 ; $6d03
	script_face $07, FACE_RIGHT ; $6d0e
.stage2:
	ld a, [wStoryModeEntryPoint] ; $6d15
	cp a, $0f ; $6d18
	jp z, ActorScript_11_6e16.checkMatchExitRequest ; $6d1a
	cp a, $0e ; $6d1d
	jp z, ActorScript_11_6e16.eq012 ; $6d1f
	cp a, $0d ; $6d22
	jp z, ActorScript_11_6e16.storeStoryModeShowLocationName ; $6d24
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $6d27
	jr nz, .stage3 ; $6d2a
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $6d2c
	jr nz, .stage4 ; $6d2f
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $6d31
	jr nz, .placeActors ; $6d34
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $6d36
	jr nz, .done ; $6d39
	ret ; $6d3b
.stage3:
	ld hl, JuniorClassCourtSinglesNpcScriptsD_11 ; $6d3c
	ld de, $000c ; $6d3f
	farcall WriteStoryStateWord ; $6d42
	script_set_position $04, $3f00, $2900 ; $6d45
	ret ; $6d50
.stage4:
	ld hl, JuniorClassCourtSinglesNpcScriptsC_11 ; $6d51
	ld de, $000c ; $6d54
	farcall WriteStoryStateWord ; $6d57
	script_set_position $04, $3f00, $2900 ; $6d5a
	ret ; $6d65
.placeActors:
	ld hl, JuniorClassCourtSinglesNpcScriptsB_11 ; $6d66
	ld de, $000c ; $6d69
	farcall WriteStoryStateWord ; $6d6c
	script_set_position $0a, $3d00, $1100 ; $6d6f
	script_set_actor_script $0a, ActorScript_11_7bbd ; $6d7a
	script_set_position $04, $3f00, $2900 ; $6d85
	ret ; $6d90
.done:
	ld hl, JuniorClassCourtSinglesNpcScriptsA_11 ; $6d91
	ld de, $000c ; $6d94
	farcall WriteStoryStateWord ; $6d97
	script_set_position $0a, $3d00, $1100 ; $6d9a
	script_set_actor_script $0a, ActorScript_11_7bbd ; $6da5
	script_set_position $04, $3f00, $2900 ; $6db0
	ret ; $6dbb
ActorScript_11_6dbc:
	; $6dbc, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $1f00, $0d00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_11_6dcb:
	; $6dcb, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $1f00, $1300
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_11_6dda:
	; $6dda, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $0f00, $0d00
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_11_6de9:
	; $6de9, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $0f00, $1300
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_11_6df8:
	; $6df8, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $0500, $0d00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_11_6e07:
	; $6e07, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $0500, $1300
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_11_6e16:
	; $6e16, 55 bytes (actor_script)
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
.checkMatchExitRequest:
	wram_bank $04 ; $6e4d
	ld a, [wMatchExitRequest] ; $6e53
	cp a, $01 ; $6e56
	jr z, .eq01 ; $6e58
	ld a, [wMatchWinLoseFlag] ; $6e5a
	cp a, $01 ; $6e5d
	jp z, .eq012 ; $6e5f
.eq01:
	script_player_speed $0040 ; $6e62
	script_move_player $1300, $1500 ; $6e68
	script_set_position ACTOR_PLAYER, $1300, $1500 ; $6e72
	script_face ACTOR_PLAYER, FACE_UP ; $6e7d
	farcall WaitPlayerMoveDone ; $6e84
	ret ; $6e87
.eq012:
	ld a, $0b ; $6e88
	ld [wStoryModeCurrentLocation], a ; $6e8a
	ld a, $0d ; $6e8d
	ld [wStoryModeEntryPoint], a ; $6e8f
	ld a, $ff ; $6e92
	ld [$c294], a ; $6e94
	ld [wStoryModeExitLocationRequest], a ; $6e97
	farcall StubNop_1e ; $6e9a
	ret ; $6e9d
.storeStoryModeShowLocationName:
	xor a, a ; $6e9e
	ld [wStoryModeShowLocationName], a ; $6e9f
	ld a, [wCurrentMinigameStoryMatch + 1] ; $6ea2
	sub a, $01 ; $6ea5
	ld a, a ; $6ea7
	rst Rst00 ; $6ea8
	dw ActorScript_11_6e16.parkMiddleCourtPracticePair ; $6ea9 jumptable
	dw ActorScript_11_6e16.parkLeftCourtPracticePairRightSide ; $6eab jumptable
	dw ActorScript_11_6e16.parkLeftCourtPracticePairRightSide2 ; $6ead jumptable
	dw ActorScript_11_6e16.waitPlayerMoveDone ; $6eaf jumptable
.parkMiddleCourtPracticePair:
	call ParkMiddleCourtPracticePair ; $6eb1
	script_player_speed $0040 ; $6eb4
	script_set_position $07, $1a00, $0900 ; $6eba
	script_set_position ACTOR_PLAYER, $1a00, $1400 ; $6ec5
	script_move_player $1a00, $0f00 ; $6ed0
	farcall WaitPlayerMoveDone ; $6eda
	script_face ACTOR_PLAYER, FACE_UP ; $6edd
	script_face $07, FACE_DOWN ; $6ee4
	script_face $03, FACE_RIGHT ; $6eeb
	script_fade_in $04 ; $6ef2
	call WaitFadeEnd ; $6ef7
	script_set_text Text_32_51 ; $6efa
	script_speak $07 ; $6f00
	script_jump_velocity $03, $ff80 ; $6f05
	ld a, $03 ; $6f0d
	farcall ScriptWaitActorJumpDone ; $6f0f
	script_speak $03 ; $6f12
	script_set_actor_script $07, ActorScript_11_7682 ; $6f17
	script_move_target ACTOR_PLAYER, $1300, $1500 ; $6f22
	script_wait_move ACTOR_PLAYER ; $6f2d
	script_face ACTOR_PLAYER, FACE_DOWN ; $6f32
	call ResumeMiddleCourtPractice ; $6f39
	script_face $03, FACE_DOWN ; $6f3c
	ret ; $6f43
.parkLeftCourtPracticePairRightSide:
	call ParkLeftCourtPracticePairRightSide ; $6f44
	script_player_speed $0040 ; $6f47
	script_set_position $06, $0900, $0900 ; $6f4d
	script_set_position ACTOR_PLAYER, $0b00, $1400 ; $6f58
	script_move_player $0b00, $0f00 ; $6f63
	farcall WaitPlayerMoveDone ; $6f6d
	script_face ACTOR_PLAYER, FACE_UP ; $6f70
	script_face $06, FACE_DOWN ; $6f77
	script_face $03, FACE_LEFT ; $6f7e
	script_fade_in $04 ; $6f85
	call WaitFadeEnd ; $6f8a
	script_set_text Text_32_70 ; $6f8d
	script_speak $06 ; $6f93
	script_jump_velocity $03, $ff80 ; $6f98
	ld a, $03 ; $6fa0
	farcall ScriptWaitActorJumpDone ; $6fa2
	script_set_text Text_32_53 ; $6fa5
	script_speak $03 ; $6fab
	script_set_actor_script $06, ActorScript_11_76de ; $6fb0
	script_move_target ACTOR_PLAYER, $1300, $1500 ; $6fbb
	script_wait_move ACTOR_PLAYER ; $6fc6
	script_face ACTOR_PLAYER, FACE_DOWN ; $6fcb
	call ResumeLeftCourtPractice ; $6fd2
	script_face $03, FACE_DOWN ; $6fd5
	ret ; $6fdc
.parkLeftCourtPracticePairRightSide2:
	call ParkLeftCourtPracticePairRightSide ; $6fdd
	script_player_speed $0040 ; $6fe0
	script_set_position $05, $0900, $0900 ; $6fe6
	script_set_position ACTOR_PLAYER, $0b00, $1400 ; $6ff1
	script_move_player $0b00, $0f00 ; $6ffc
	farcall WaitPlayerMoveDone ; $7006
	script_face ACTOR_PLAYER, FACE_UP ; $7009
	script_face $05, FACE_DOWN ; $7010
	script_face $03, FACE_LEFT ; $7017
	script_fade_in $04 ; $701e
	call WaitFadeEnd ; $7023
	script_set_text Text_32_65 ; $7026
	script_speak $05 ; $702c
	script_jump_velocity $03, $ff80 ; $7031
	ld a, $03 ; $7039
	farcall ScriptWaitActorJumpDone ; $703b
	script_set_text Text_32_54 ; $703e
	script_speak $03 ; $7044
	script_set_actor_script $05, ActorScript_11_7717 ; $7049
	script_move_target ACTOR_PLAYER, $1300, $1500 ; $7054
	script_wait_move ACTOR_PLAYER ; $705f
	script_face ACTOR_PLAYER, FACE_DOWN ; $7064
	call ResumeLeftCourtPractice ; $706b
	script_face $03, FACE_DOWN ; $706e
	ret ; $7075
.waitPlayerMoveDone:
	script_player_speed $0040 ; $7076
	script_set_position $03, $1300, $1f00 ; $707c
	script_set_position $04, $1a00, $0b00 ; $7087
	script_set_position ACTOR_PLAYER, $1a00, $1400 ; $7092
	script_move_player $1a00, $1100 ; $709d
	farcall WaitPlayerMoveDone ; $70a7
	script_face ACTOR_PLAYER, FACE_UP ; $70aa
	script_face $04, FACE_DOWN ; $70b1
	script_face $03, FACE_UP ; $70b8
	call ParkMiddleCourtPracticePair ; $70bf
	script_fade_in $04 ; $70c2
	call WaitFadeEnd ; $70c7
	script_wait_frames $3c ; $70ca
	script_set_text Text_32_55 ; $70d1
	script_move_target $04, $1a00, $0d00 ; $70d7
	script_wait_move $04 ; $70e2
	script_set_anim $04, $02 ; $70e7
	script_speak $04 ; $70ee
	script_set_anim $03, $03 ; $70f3
	script_speak $03 ; $70fa
	script_set_anim $04, $02 ; $70ff
	script_set_anim ACTOR_PLAYER, $02 ; $7106
	script_face ACTOR_PLAYER, FACE_DOWN ; $710d
	script_player_speed $0010 ; $7114
	script_set_speed $03, $0010 ; $711a
	script_move_player $1300, $1900 ; $7122
	script_move_target $03, $1300, $1b00 ; $712c
	script_wait_move $03 ; $7137
	farcall WaitPlayerMoveDone ; $713c
	script_move_player $1a00, $1400 ; $713f
	script_move_target $03, $1a00, $1700 ; $7149
	script_wait_move $03 ; $7154
	script_face $03, FACE_UP ; $7159
	script_set_anim $03, $02 ; $7160
	script_wait_idle $03 ; $7167
	script_speak $03 ; $716c
	script_set_anim ACTOR_PLAYER, $03 ; $7171
	script_wait_idle ACTOR_PLAYER ; $7178
	script_set_anim $03, $03 ; $717d
	script_wait_idle $03 ; $7184
	script_speak $03 ; $7189
	script_move_target $03, $1a00, $1600 ; $718e
	script_wait_move $03 ; $7199
	script_set_anim $03, $02 ; $719e
	script_wait_idle $03 ; $71a5
	script_wait_frames $1e ; $71aa
	script_set_anim $03, $03 ; $71b1
	script_set_anim ACTOR_PLAYER, $03 ; $71b8
	script_wait_idle ACTOR_PLAYER ; $71bf
	script_speak ACTOR_PLAYER ; $71c4
	script_set_anim $03, $02 ; $71c9
	script_wait_idle $03 ; $71d0
	script_speak $03 ; $71d5
	script_set_anim ACTOR_PLAYER, $03 ; $71da
	script_wait_idle ACTOR_PLAYER ; $71e1
	script_set_anim $03, $03 ; $71e6
	script_wait_idle $03 ; $71ed
	script_set_anim ACTOR_PLAYER, $02 ; $71f2
	script_wait_idle ACTOR_PLAYER ; $71f9
	script_face ACTOR_PLAYER, FACE_UP ; $71fe
	script_set_position $12, $1b80, $1280 ; $7205
	sound $96 ; $7210
	script_wait_frames $28 ; $7212
	script_set_anim $04, $02 ; $7219
	script_wait_frames $28 ; $7220
	script_move_target $04, $1a00, $0e00 ; $7227
	script_wait_move $04 ; $7232
	script_set_position $12, $3f00, $3f00 ; $7237
	script_speak $04 ; $7242
	ld a, $0b ; $7247
	ld [wStoryModeCurrentLocation], a ; $7249
	ld a, $01 ; $724c
	ld [wStoryModeEntryPoint], a ; $724e
	ld a, $ff ; $7251
	ld [$c294], a ; $7253
	ld [wStoryModeExitLocationRequest], a ; $7256
	script_set_anim $03, $03 ; $7259
	script_wait_idle $03 ; $7260
	script_wait_frames $28 ; $7265
	script_set_anim ACTOR_PLAYER, $02 ; $726c
	script_wait_idle ACTOR_PLAYER ; $7273
	script_wait_frames $28 ; $7278
	ld c, $04 ; $727f
	call BeginFadeOut ; $7281
	call WaitFadeEnd ; $7284
	ret ; $7287
PromptChallengeRankingOpponent:
	script_set_text Text_32_34 ; $7288
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $728e
	jr z, .prompt ; $7291
	farcall AdvanceDialogueTextCursor ; $7293
.prompt:
	ld a, $03 ; $7296
	farcall ScriptShowSpeakerDialogueRestoreBG ; $7298
	farcall RunDialogueYesNoPrompt ; $729b
	farcall ScriptCloseDialogueWindow ; $729e
	script_wait_frames $05 ; $72a1
	and a, a ; $72a8
	jp nz, .done ; $72a9
	script_set_anim $03, $03 ; $72ac
	script_wait_idle $03 ; $72b3
.declined:
	script_set_anim $03, $03 ; $72b8
	script_wait_idle $03 ; $72bf
	script_set_text Text_32_40 ; $72c4
	script_speak $03 ; $72ca
	call StartNextRankingMatch ; $72cf
	script_set_speed ACTOR_PLAYER, $0018 ; $72d2
	script_set_speed ACTOR_PARTNER, $0018 ; $72da
	ret ; $72e2
.accepted:
	script_speak $03 ; $72e3
	call LoadRankingOpponentGraphics ; $72e8
	ret ; $72eb
.done:
	script_set_text Text_32_37 ; $72ec
	ld a, $03 ; $72f2
	farcall ScriptShowSpeakerDialogueRestoreBG ; $72f4
	farcall RunDialogueYesNoPrompt ; $72f7
	farcall ScriptCloseDialogueWindow ; $72fa
	script_wait_frames $05 ; $72fd
	and a, a ; $7304
	jr z, .accepted ; $7305
	jp .declined ; $7307
LoadRankingOpponentGraphics:
	test_flag FLAG_DOUBLES ; $730a
	jp nz, LoadDoublesRankingOpponentGraphics ; $730d
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $7310
	jr z, .rank2 ; $7313
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_3 ; $7315
	jr z, .rank3 ; $7318
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_2 ; $731a
	jr z, .rank4 ; $731d
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $731f
	jr z, .done ; $7322
	ret ; $7324
.rank2:
	script_set_actor_script $07, ActorScript_11_766b ; $7325
	script_wait_actor_script $07 ; $7330
	ret ; $7335
.rank3:
	script_set_actor_script $06, ActorScript_11_76cd ; $7336
	script_wait_actor_script $06 ; $7341
	ret ; $7346
.rank4:
	script_set_actor_script $05, ActorScript_11_7700 ; $7347
	script_wait_actor_script $05 ; $7352
	ret ; $7357
.done:
	script_set_actor_script $04, ActorScript_11_7745 ; $7358
	script_wait_actor_script $04 ; $7363
	ret ; $7368
DrawRankingOpponentInfo:
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $7369
	jr z, .rank2 ; $736c
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_3 ; $736e
	jp z, .rank3 ; $7371
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_2 ; $7374
	jp z, .rank4 ; $7377
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $737a
	jp z, .done ; $737d
	ret ; $7380
.rank2:
	script_wait_frames $0f ; $7381
	script_face_toward $07, $03 ; $7388
	script_wait_frames $1e ; $7390
	script_face_toward $07, ACTOR_PLAYER ; $7397
	script_wait_frames $1e ; $739f
	script_player_speed $0020 ; $73a6
	script_move_player_to_actor $07 ; $73ac
	farcall WaitPlayerMoveDone ; $73b3
	script_face_toward $03, $07 ; $73b6
	script_set_anim $07, $03 ; $73be
	script_wait_idle $07 ; $73c5
	script_wait_frames $0a ; $73ca
	script_set_actor_script $07, ActorScript_11_7643 ; $73d1
	script_wait_frames $0a ; $73dc
	script_move_player_to_actor ACTOR_PLAYER ; $73e3
	script_face $03, FACE_DOWN ; $73ea
	farcall WaitPlayerMoveDone ; $73f1
	script_wait_actor_script $07 ; $73f4
	script_face_toward ACTOR_PLAYER, $07 ; $73f9
	script_set_anim $07, $02 ; $7401
	script_wait_idle $07 ; $7408
	script_set_text Text_32_42 ; $740d
	script_speak $07 ; $7413
	script_set_anim $07, $03 ; $7418
	script_wait_idle $07 ; $741f
	script_speak $07 ; $7424
	script_wait_frames $0f ; $7429
	script_face $07, FACE_UP ; $7430
	ret ; $7437
.rank3:
	script_wait_frames $0f ; $7438
	script_face_toward $06, $03 ; $743f
	script_wait_frames $1e ; $7447
	script_face_toward $06, ACTOR_PLAYER ; $744e
	script_wait_frames $1e ; $7456
	script_player_speed $0020 ; $745d
	script_move_player_to_actor $06 ; $7463
	farcall WaitPlayerMoveDone ; $746a
	script_face_toward $03, $06 ; $746d
	script_set_anim $06, $03 ; $7475
	script_wait_idle $06 ; $747c
	script_set_actor_script $06, ActorScript_11_76ab ; $7481
	script_move_player_to_actor ACTOR_PLAYER ; $748c
	script_face $03, FACE_DOWN ; $7493
	script_wait_actor_script $06 ; $749a
	script_face_toward $06, ACTOR_PLAYER ; $749f
	script_wait_actor_script $06 ; $74a7
	script_set_anim $06, $02 ; $74ac
	script_wait_idle $06 ; $74b3
	script_set_text Text_32_44 ; $74b8
	script_speak $06 ; $74be
	script_set_anim $06, $03 ; $74c3
	script_wait_idle $06 ; $74ca
	script_speak $06 ; $74cf
	script_wait_frames $0f ; $74d4
	script_face $06, FACE_UP ; $74db
	ret ; $74e2
.rank4:
	script_wait_frames $0f ; $74e3
	script_face_toward $05, $03 ; $74ea
	script_wait_frames $1e ; $74f2
	script_face_toward $05, ACTOR_PLAYER ; $74f9
	script_wait_frames $1e ; $7501
	script_player_speed $0020 ; $7508
	script_move_player_to_actor $05 ; $750e
	farcall WaitPlayerMoveDone ; $7515
	script_face_toward $03, $05 ; $7518
	script_set_anim $05, $03 ; $7520
	script_wait_idle $05 ; $7527
	script_set_actor_script $05, ActorScript_11_76e9 ; $752c
	script_wait_frames $0a ; $7537
	script_move_player_to_actor ACTOR_PLAYER ; $753e
	script_face $03, FACE_DOWN ; $7545
	script_wait_actor_script $05 ; $754c
	script_face_toward $05, ACTOR_PLAYER ; $7551
	script_set_anim $05, $02 ; $7559
	script_wait_idle $05 ; $7560
	script_set_text Text_32_46 ; $7565
	script_speak $05 ; $756b
	script_set_anim $05, $03 ; $7570
	script_wait_idle $05 ; $7577
	script_speak $05 ; $757c
	script_wait_frames $0f ; $7581
	script_face $05, FACE_UP ; $7588
	ret ; $758f
.done:
	script_wait_frames $0f ; $7590
	script_face_toward $04, $03 ; $7597
	script_wait_frames $1e ; $759f
	script_face_toward $04, ACTOR_PLAYER ; $75a6
	script_wait_frames $1e ; $75ae
	script_player_speed $0020 ; $75b5
	script_move_player_to_actor $04 ; $75bb
	farcall WaitPlayerMoveDone ; $75c2
	ld bc, $d040 ; $75c5
	script_get_actor_state $04 ; $75c8
	ld e, l ; $75cd
	ld d, h ; $75ce
	farcall AttachActorWaypointFollower ; $75cf
	script_face_toward $03, $04 ; $75d2
	script_set_anim $04, $03 ; $75da
	script_wait_idle $04 ; $75e1
	script_set_actor_script $04, ActorScript_11_7728 ; $75e6
	script_face $03, FACE_DOWN ; $75f1
	script_move_player_to_actor ACTOR_PLAYER ; $75f8
	script_wait_actor_script $04 ; $75ff
	script_face_toward $04, ACTOR_PLAYER ; $7604
	script_set_anim $04, $02 ; $760c
	script_wait_idle $04 ; $7613
	script_set_text Text_32_48 ; $7618
	script_speak $04 ; $761e
	script_set_anim $04, $03 ; $7623
	script_wait_idle $04 ; $762a
	script_speak $04 ; $762f
	script_wait_frames $0f ; $7634
	script_face $04, FACE_UP ; $763b
	ret ; $7642
ActorScript_11_7643:
	; $7643, 23 bytes (actor_script)
	as_set_target $1f00, $1900
	as_wait_move
	as_set_target $1500, $1900
	as_wait_move
	as_set_target $1500, $1500
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_11_765a:
	; $765a, 17 bytes (actor_script)
	as_set_target $1500, $0900
	as_wait_move
	as_set_target $1900, $0900
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_11_766b:
	; $766b, 23 bytes (actor_script)
	as_set_target $1500, $1900
	as_wait_move
	as_set_target $1f00, $1900
	as_wait_move
	as_set_target $1f00, $1500
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_11_7682:
	; $7682, 41 bytes (actor_script)
	as_set_target $1a00, $0900
	as_wait_move
	as_set_target $2100, $0900
	as_wait_move
	as_set_target $2100, $0d00
	as_wait_move
	as_set_target $2700, $0d00
	as_wait_move
	as_set_target $2700, $0b00
	as_wait_move
	as_set_target $2500, $0b00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_11_76ab:
	; $76ab, 17 bytes (actor_script)
	as_set_target $1100, $0d00
	as_wait_move
	as_set_target $1100, $1500
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_11_76bc:
	; $76bc, 17 bytes (actor_script)
	as_set_target $1100, $0a00
	as_wait_move
	as_set_target $0900, $0900
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_halt
ActorScript_11_76cd:
	; $76cd, 17 bytes (actor_script)
	as_set_target $1100, $0d00
	as_wait_move
	as_set_target $1300, $0d00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_11_76de:
	; $76de, 11 bytes (actor_script)
	as_set_target $1300, $0d00
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_11_76e9:
	; $76e9, 23 bytes (actor_script)
	as_set_target $0500, $1900
	as_wait_move
	as_set_target $1100, $1900
	as_wait_move
	as_set_target $1100, $1500
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_11_7700:
	; $7700, 23 bytes (actor_script)
	as_set_target $1100, $1900
	as_wait_move
	as_set_target $0500, $1900
	as_wait_move
	as_set_target $0500, $1500
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_11_7717:
	; $7717, 17 bytes (actor_script)
	as_set_target $0500, $0900
	as_wait_move
	as_set_target $0500, $1500
	as_wait_move
	as_set_field $14, FACE_RIGHT
	as_halt
ActorScript_11_7728:
	; $7728, 29 bytes (actor_script)
	as_set_target $2100, $1700
	as_wait_move
	as_set_target $2100, $1900
	as_wait_move
	as_set_target $1500, $1900
	as_wait_move
	as_set_target $1500, $1500
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_11_7745:
	; $7745, 29 bytes (actor_script)
	as_set_target $1500, $1900
	as_wait_move
	as_set_target $2100, $1900
	as_wait_move
	as_set_target $2100, $1700
	as_wait_move
	as_set_target $2300, $1700
	as_wait_move
	as_set_field $14, FACE_LEFT
	as_halt
ActorScript_11_7762:
	; $7762, 17 bytes (actor_script)
	as_set_target $1300, $1900
	as_wait_move
	as_set_target $1b00, $1900
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
ActorScript_11_7773:
	; $7773, 17 bytes (actor_script)
	as_set_target $1300, $1900
	as_wait_move
	as_set_target $0b00, $1900
	as_wait_move
	as_set_field $14, FACE_UP
	as_halt
OfferSinglesRankingMatch:
	script_set_text Text_32_28 ; $7784
	ld a, $03 ; $778a
	farcall ScriptShowSpeakerDialogueRestoreBG ; $778c
	farcall RunDialogueYesNoPrompt ; $778f
	farcall ScriptCloseDialogueWindow ; $7792
	script_wait_frames $05 ; $7795
	and a, a ; $779c
	jp nz, .speak2 ; $779d
	script_facing_lock ACTOR_PLAYER, FACE_RIGHT ; $77a0
	script_set_speed ACTOR_PLAYER, $0018 ; $77a7
	script_move_target ACTOR_PLAYER, $1300, $1500 ; $77af
	script_wait_move ACTOR_PLAYER ; $77ba
	script_face_toward $03, ACTOR_PLAYER ; $77bf
	script_wait_frames $1e ; $77c7
	script_face_toward ACTOR_PLAYER, $03 ; $77ce
	farcall AdvanceDialogueTextCursor ; $77d6
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $77d9
	jr z, .speak ; $77dc
	farcall AdvanceDialogueTextCursor ; $77de
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_3 ; $77e1
	jr z, .speak ; $77e4
	farcall AdvanceDialogueTextCursor ; $77e6
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_2 ; $77e9
	jr z, .speak ; $77ec
	farcall AdvanceDialogueTextCursor ; $77ee
.speak:
	script_speak $03 ; $77f1
	call DrawRankingOpponentInfo ; $77f6
	script_face ACTOR_PLAYER, FACE_UP ; $77f9
	script_wait_frames $0f ; $7800
	script_set_anim $03, $02 ; $7807
	script_wait_idle $03 ; $780e
	call PromptChallengeRankingOpponent ; $7813
	ret ; $7816
.speak2:
	script_speak $03 ; $7817
	ret ; $781c
StartNextRankingMatch:
	script_set_speed ACTOR_PLAYER, $0020 ; $781d
	test_flag FLAG_DOUBLES ; $7825
	jp nz, StartNextDoublesRankingMatch ; $7828
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $782b
	jr z, .rank2 ; $782e
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_3 ; $7830
	jp z, .rank3 ; $7833
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_2 ; $7836
	jp z, .rank4 ; $7839
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $783c
	jp z, .done ; $783f
	ret ; $7842
.rank2:
	script_face $03, FACE_RIGHT ; $7843
	script_wait_frames $0f ; $784a
	script_face ACTOR_PLAYER, FACE_RIGHT ; $7851
	script_face $07, FACE_RIGHT ; $7858
	script_wait_frames $1e ; $785f
	script_set_actor_script $0e, ActorScript_11_6dbc ; $7866
	script_set_actor_script $0f, ActorScript_11_6dcb ; $7871
	script_wait_actor_script $0f ; $787c
	script_move_player $1b00, $1100 ; $7881
	script_set_actor_script $07, ActorScript_11_765a ; $788b
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_7762 ; $7896
	farcall WaitPlayerMoveDone ; $78a1
	script_wait_actor_script $07 ; $78a4
	script_wait_frames $14 ; $78a9
	ld a, $0f ; $78b0
	ld [$c294], a ; $78b2
	ld [wStoryModeExitLocationRequest], a ; $78b5
	farcall InitStoryMatchSettings ; $78b8
	load_match_settings $0001 ; $78bb
	farcall RunStoryMatch ; $78c8
	farcall RestoreOverworldAfterMatch ; $78cb
	ret ; $78ce
.rank3:
	script_face $03, FACE_LEFT ; $78cf
	script_wait_frames $0f ; $78d6
	script_face ACTOR_PLAYER, FACE_LEFT ; $78dd
	script_face $06, FACE_LEFT ; $78e4
	script_wait_frames $1e ; $78eb
	script_set_actor_script $0c, ActorScript_11_6dda ; $78f2
	script_set_actor_script $0d, ActorScript_11_6de9 ; $78fd
	script_wait_frames $78 ; $7908
	script_move_player $0b00, $1100 ; $790f
	script_set_actor_script $06, ActorScript_11_76bc ; $7919
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_7773 ; $7924
	farcall WaitPlayerMoveDone ; $792f
	script_wait_actor_script $06 ; $7932
	script_wait_frames $28 ; $7937
	ld a, $0f ; $793e
	ld [$c294], a ; $7940
	ld [wStoryModeExitLocationRequest], a ; $7943
	farcall InitStoryMatchSettings ; $7946
	load_match_settings $0002 ; $7949
	farcall RunStoryMatch ; $7956
	farcall RestoreOverworldAfterMatch ; $7959
	ret ; $795c
.rank4:
	script_face $03, FACE_LEFT ; $795d
	script_wait_frames $0f ; $7964
	script_face ACTOR_PLAYER, FACE_LEFT ; $796b
	script_face $05, FACE_LEFT ; $7972
	script_wait_frames $1e ; $7979
	script_set_actor_script $0c, ActorScript_11_6dda ; $7980
	script_set_actor_script $0d, ActorScript_11_6de9 ; $798b
	script_wait_frames $78 ; $7996
	script_move_player $0b00, $1100 ; $799d
	script_set_actor_script $05, ActorScript_11_76bc ; $79a7
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_7773 ; $79b2
	script_wait_actor_script $05 ; $79bd
	script_wait_frames $28 ; $79c2
	ld a, $0f ; $79c9
	ld [$c294], a ; $79cb
	ld [wStoryModeExitLocationRequest], a ; $79ce
	farcall InitStoryMatchSettings ; $79d1
	load_match_settings $0003 ; $79d4
	farcall RunStoryMatch ; $79e1
	farcall RestoreOverworldAfterMatch ; $79e4
	ret ; $79e7
.done:
	script_face $03, FACE_RIGHT ; $79e8
	script_wait_frames $0f ; $79ef
	script_face ACTOR_PLAYER, FACE_RIGHT ; $79f6
	script_face $04, FACE_RIGHT ; $79fd
	script_wait_frames $1e ; $7a04
	script_set_actor_script $0e, ActorScript_11_6dbc ; $7a0b
	script_set_actor_script $0f, ActorScript_11_6dcb ; $7a16
	script_wait_frames $78 ; $7a21
	script_move_player $1700, $1300 ; $7a28
	script_set_actor_script $04, ActorScript_11_765a ; $7a32
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_7762 ; $7a3d
	farcall WaitPlayerMoveDone ; $7a48
	script_wait_actor_script $04 ; $7a4b
	script_wait_frames $28 ; $7a50
	ld a, $0f ; $7a57
	ld [$c294], a ; $7a59
	ld [wStoryModeExitLocationRequest], a ; $7a5c
	farcall InitStoryMatchSettings ; $7a5f
	load_match_settings $0004 ; $7a62
	farcall RunStoryMatch ; $7a6f
	farcall RestoreOverworldAfterMatch ; $7a72
	ret ; $7a75
ParkMiddleCourtPracticePair:
	script_null_script $0e ; $7a76
	script_null_script $0f ; $7a7b
	script_set_anim $0e, $01 ; $7a80
	script_set_anim $0f, $01 ; $7a87
	script_set_position $0e, $1f00, $0b00 ; $7a8e
	script_set_position $0f, $1f00, $1300 ; $7a99
	script_face $0e, FACE_LEFT ; $7aa4
	script_face $0f, FACE_LEFT ; $7aab
	ret ; $7ab2
ParkLeftCourtPracticePairRightSide:
	script_null_script $0c ; $7ab3
	script_null_script $0d ; $7ab8
	script_set_anim $0c, $01 ; $7abd
	script_set_anim $0d, $01 ; $7ac4
	script_set_position $0c, $0f00, $0b00 ; $7acb
	script_set_position $0d, $0f00, $1300 ; $7ad6
	script_face $0c, FACE_LEFT ; $7ae1
	script_face $0d, FACE_LEFT ; $7ae8
	script_wait_frames $14 ; $7aef
	ret ; $7af6
ParkLeftCourtPracticePairLeftSide:
	script_null_script $0c ; $7af7
	script_null_script $0d ; $7afc
	script_set_position $0c, $0500, $0b00 ; $7b01
	script_set_position $0d, $0500, $1300 ; $7b0c
	script_face $0c, FACE_RIGHT ; $7b17
	script_face $0d, FACE_RIGHT ; $7b1e
	script_wait_frames $14 ; $7b25
	ret ; $7b2c
ResumeMiddleCourtPractice:
	script_move_target $0e, $1800, $0b00 ; $7b2d
	script_move_target $0f, $1c00, $1700 ; $7b38
	script_wait_move $0f ; $7b43
	script_face $0f, FACE_UP ; $7b48
	script_wait_move $0e ; $7b4f
	script_set_actor_script $0e, ActorScript_11_7bdf ; $7b54
	script_set_actor_script $0f, ActorScript_11_7c42 ; $7b5f
	ret ; $7b6a
ResumeLeftCourtPractice:
	script_move_target $0c, $0800, $0b00 ; $7b6b
	script_move_target $0d, $0c00, $1700 ; $7b76
	script_wait_move $0d ; $7b81
	script_face $0d, FACE_UP ; $7b86
	script_wait_move $0c ; $7b8d
	script_set_actor_script $0c, ActorScript_11_7ca9 ; $7b92
	script_set_actor_script $0d, ActorScript_11_7d10 ; $7b9d
	ret ; $7ba8
ActorScript_11_7ba9:
	; $7ba9, 10 bytes (actor_script)
	as_halt
	as_anim $00
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
ActorScript_11_7bb3:
	; $7bb3, 10 bytes (actor_script)
	as_begin_path
.L1:
	as_rand_box $02, $02
	as_wait_move2
	as_wait $28
	as_jump .L1
ActorScript_11_7bbd:
	; $7bbd, 20 bytes (actor_script)
	as_begin_path
.L1:
	as_rand_box $01, $02
	as_wait_move2
	as_wait $28
	as_jump .L1
	as_begin_path
.Lb:
	as_rand_box $01, $01
	as_wait_move2
	as_wait $28
	as_jump .Lb
MapScriptNop_11:
	ret ; $7bd1
	xor a, a ; $7bd2
	ld [$c2da], a ; $7bd3
	ret ; $7bd6
	sound $a2 ; $7bd7
	ret ; $7bd9
	xor a, a ; $7bda
	ld [wStoryModeShowLocationName], a ; $7bdb
	ret ; $7bde
ActorScript_11_7bdf:
	; $7bdf, 99 bytes (actor_script)
	as_anim $01
	as_target_rel $0400, $0200
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $fe00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_jump ActorScript_11_7bdf
ActorScript_11_7c42:
	; $7c42, 103 bytes (actor_script)
	as_anim $00
	as_wait $3c
.L4:
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $fe00
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0200
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_jump .L4
ActorScript_11_7ca9:
	; $7ca9, 103 bytes (actor_script)
	as_anim $00
	as_wait $1e
.L4:
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0200
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $fe00
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_DOWN
	as_anim $05
	as_wait $4b
	as_jump .L4
ActorScript_11_7d10:
	; $7d10, 118 bytes (actor_script)
	as_anim $00
	as_wait $1e
	as_wait $3c
.L6:
	as_anim $01
	as_target_rel $fc00, $fe00
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0200
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $fc00, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_anim $01
	as_target_rel $0400, $0000
	as_wait_move
	as_set_field $14, FACE_UP
	as_anim $05
	as_wait $4b
	as_jump .L6
.L69:
	as_wait $f0
	as_anim $03
	as_wait $50
	as_anim $03
	as_wait $3c
	as_jump .L69
ActorScript_11_7d86:
	; $7d86, 15 bytes (actor_script)
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $03
	as_jump ActorScript_11_7d86
ComputeRankingProgressIndex:
	test_flag FLAG_DOUBLES ; $7d95
	jr nz, .doubles ; $7d98
	ld a, $00 ; $7d9a
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7d9c
	jr z, .store ; $7d9f
	ld a, $02 ; $7da1
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7da3
	jr z, .store ; $7da6
	ld a, $04 ; $7da8
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7daa
	jr z, .store ; $7dad
	ld a, $06 ; $7daf
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7db1
	jr z, .store ; $7db4
	ld a, $08 ; $7db6
.store:
	ld [$c2b0], a ; $7db8
	ret ; $7dbb
.doubles:
	ld a, $01 ; $7dbc
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7dbe
	jr z, .store ; $7dc1
	ld a, $03 ; $7dc3
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7dc5
	jr z, .store ; $7dc8
	ld a, $05 ; $7dca
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7dcc
	jr z, .store ; $7dcf
	ld a, $07 ; $7dd1
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7dd3
	jr z, .store ; $7dd6
	ld a, $09 ; $7dd8
	jr .store ; $7dda
	ld a, $00 ; $7ddc
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7dde
	jr z, .storeIsland ; $7de1
	inc a ; $7de3
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7de4
	jr z, .storeIsland ; $7de7
	inc a ; $7de9
	test_flag FLAG_DOUBLES ; $7dea
	jr nz, .doublesIsland ; $7ded
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7def
	jr z, .storeIsland ; $7df2
	inc a ; $7df4
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7df5
	jr z, .storeIsland ; $7df8
	inc a ; $7dfa
.storeIsland:
	ld [$c2b0], a ; $7dfb
	ret ; $7dfe
.doublesIsland:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7dff
	jr z, .storeIsland ; $7e02
	inc a ; $7e04
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7e05
	jr z, .storeIsland ; $7e08
	inc a ; $7e0a
	jr .storeIsland ; $7e0b
	; $7e0d, 499 bytes fill to bank end (linker-padded)
