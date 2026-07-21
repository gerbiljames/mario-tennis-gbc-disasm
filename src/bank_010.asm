SECTION "ROM Bank $10", ROMX[$4000], BANK[$10]

DataPtr_MatchSelectMapScripts_10:
	dw MatchSelectMapScripts_10 ; $4000
DataPtr_Test2MapScripts_10:
	dw Test2MapScripts_10 ; $4002
DataPtr_DevelopmentMapScripts_10:
	dw DevelopmentMapScripts_10 ; $4004
DataPtr_MainMenuMapScripts_10:
	dw MainMenuMapScripts_10 ; $4006
DataPtr_CafeteriaMapScripts_10:
	dw CafeteriaMapScripts_10 ; $4008
DataPtr_RestaurantMapScripts_10:
	dw RestaurantMapScripts_10 ; $400a
DataPtr_AcademyWingMapScripts_10:
	dw AcademyWingMapScripts_10 ; $400c
DataPtr_AcademyMainBldgMapScripts_10:
	dw AcademyMainBldgMapScripts_10 ; $400e
MatchSelectMapScripts_10:
	; $4010, 14 bytes (map_tree)
	dw MatchSelectEntryPoints_10 ; slot 0 EntryPoints
	dw MatchSelectExitTriggers_10 ; slot 1 ExitTriggers
	dw MatchSelectActors_10 ; slot 2 Actors
	dw MatchSelectHandlerTable_10 ; slot 3 NpcScripts
	dw MatchSelectFacingScripts_10 ; slot 4 FacingScripts
	dw MatchSelectTileTriggers_10 ; slot 5 TileTriggers
	dw MatchSelectInitScript_10 ; slot 6 InitScript
MatchSelectActors_10:
	; $401e, 136 bytes (map_actors)
	map_actor $0000, ActorScript_10_7bd1, $0700, $1100, FACE_DOWN, $49, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $0700, $0700, FACE_LEFT, $46, $01, $03
	map_actor $0000, ActorScript_10_7bd1, $0d00, $0700, FACE_LEFT, $47, $01, $03
	map_actor $0000, ActorScript_10_7bd1, $0700, $0b00, FACE_DOWN, $54, $01, $03
	map_actor $0000, ActorScript_10_7bd1, $0d00, $0b00, FACE_DOWN, $55, $01, $03
	map_actor $0000, ActorScript_10_7bd1, $0d00, $1100, FACE_DOWN, $6c, $01, $05
	map_actor $0000, ActorScript_10_7bd1, $0500, $0e00, FACE_DOWN, $43, $01, $03
	map_actor $0000, ActorScript_10_7bd1, $1100, $0e00, FACE_DOWN, $43, $01, $03
	map_actor $0000, ActorScript_10_7bd1, $1100, $0c00, FACE_DOWN, $43, $01, $03
	map_actor_end
MatchSelectEntryPoints_10:
	; $40a6, 9 bytes (map_entries)
	map_entry $01, FACE_UP, $0a00, $0900, $0000
	db $ff
MatchSelectExitTriggers_10:
	ds 1, $ff ; $40af, fill
Func_10_40b0:
	farcall BeginCutsceneScriptMode ; $40b0
	ld c, $10 ; $40b3
	call BeginFadeOut ; $40b5
	call WaitFadeEnd ; $40b8
	ld b, $00 ; $40bb
	farcall Func_38_47c7 ; $40bd
	ld c, $10 ; $40c0
	call BeginFadeOut ; $40c2
	call WaitFadeEnd ; $40c5
	farcall LoadStoryObjPalettes ; $40c8
	call DisableLCDSafely ; $40cb
	farcall Func_01_50e2 ; $40ce
	call EnableLCD ; $40d1
	ld hl, wStoryModePlayersXPosition ; $40d4
	ld de, wStoryModeSpawnPosition ; $40d7
	ld bc, $0005 ; $40da
	call CopyMemoryBC ; $40dd
	ld a, $ff ; $40e0
	ld [wStoryModeEntryPoint], a ; $40e2
	ld [$c294], a ; $40e5
	ld [wStoryModeExitLocationRequest], a ; $40e8
	farcall EndCutsceneScriptMode ; $40eb
	ret ; $40ee
Func_10_40ef:
	farcall BeginCutsceneScriptMode ; $40ef
	farcall Func_03_59c5 ; $40f2
	call WaitFramesCmd ; $40f5
	db $3c ; $40f8 inline arg
	call EnableLCD ; $40f9
	farcall Func_03_5b28 ; $40fc
	script_fade_in $04 ; $40ff
	call WaitFadeEnd ; $4104
	sound $14 ; $4107
	ld a, $01 ; $4109
	ld hl, Func_10_4141 ; $410b
	call RegisterFrameTask ; $410e
	call WaitFramesCmd ; $4111
	db $78 ; $4114 inline arg
	call WaitFramesCmd ; $4115
	db $ff ; $4118 inline arg
	call WaitFramesCmd ; $4119
	db $ff ; $411c inline arg
	call WaitFramesCmd ; $411d
	db $ff ; $4120 inline arg
	call WaitFramesCmd ; $4121
	db $ff ; $4124 inline arg
	call WaitFramesCmd ; $4125
	db $ff ; $4128 inline arg
	call WaitFramesCmd ; $4129
	db $ff ; $412c inline arg
	ld hl, Func_10_4141 ; $412d
	call UnregisterFrameTask ; $4130
	farcall EndCutsceneScriptMode ; $4133
	ret ; $4136
Func_10_4137:
	farcall BeginCutsceneScriptMode ; $4137
	farcall RunEndingCreditsSequence ; $413a
	farcall EndCutsceneScriptMode ; $413d
	ret ; $4140
Func_10_4141:
	farcall Func_03_5b4d ; $4141
	ret ; $4144
MatchSelectHandlerTable_10:
	; $4145, 73 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Func_10_40b0, $00, $00
	map_script $04, FACEMASK_ANY, $0000, RunSinglesMatchListMenu, $00, $00
	map_script $05, FACEMASK_ANY, $0000, RunDoublesMatchListMenu, $00, $00
	map_script $06, FACEMASK_ANY, $0000, RunDrillMatchListMenu, $00, $00
	map_script $07, FACEMASK_ANY, $0000, Func_10_448d, $00, $00
	map_script $08, FACEMASK_ANY, $0000, RunLessonSelectMenu, $00, $00
	map_script $09, FACEMASK_ANY, $0000, RunMinigameSelectMenu, $00, $00
	map_script $0a, FACEMASK_ANY, $0000, Func_10_40ef, $00, $00
	map_script $0b, FACEMASK_ANY, $0000, Func_10_4137, $00, $00
	db $ff
MatchSelectFacingScripts_10:
	ds 1, $ff ; $418e, fill
MatchSelectTileTriggers_10:
	ds 1, $ff ; $418f, fill
MatchSelectInitScript_10:
	xor a, a ; $4190
	ld [wStoryModeShowLocationName], a ; $4191
	ret ; $4194
RunSinglesMatchListMenu:
	ld hl, $0484 ; $4195
	ld de, $0101 ; $4198
	ld a, $05 ; $419b
	farcall RunPagedTextMenu ; $419d
	cp a, $ff ; $41a0
	jp z, Label_10_421f ; $41a2
	ld [$c2b0], a ; $41a5
	ld hl, wStoryModePlayersXPosition ; $41a8
	ld de, wStoryModeSpawnPosition ; $41ab
	ld bc, $0005 ; $41ae
	call CopyMemoryBC ; $41b1
	ld a, $ff ; $41b4
	ld [wStoryModeEntryPoint], a ; $41b6
	ld [$c294], a ; $41b9
	ld [wStoryModeExitLocationRequest], a ; $41bc
	farcall InitStoryMatchSettings ; $41bf
	ld a, [$c2b0] ; $41c2
	add a, a ; $41c5
	add a, $20 ; $41c6
	ld l, a ; $41c8
	adc a, $42 ; $41c9
	sub a, l ; $41cb
	ld h, a ; $41cc
	ld a, [hl+] ; $41cd
	ld h, [hl] ; $41ce
	ld l, a ; $41cf
	call JumpToHL ; $41d0
	farcall RunStoryMatch ; $41d3
	farcall RestoreOverworldAfterMatch ; $41d6
	ret ; $41d9
RunDoublesMatchListMenu:
	ld hl, $0489 ; $41da
	ld de, $0101 ; $41dd
	ld a, $04 ; $41e0
	farcall RunPagedTextMenu ; $41e2
	cp a, $ff ; $41e5
	jp z, Label_10_421f ; $41e7
	ld [$c2b0], a ; $41ea
	ld hl, wStoryModePlayersXPosition ; $41ed
	ld de, wStoryModeSpawnPosition ; $41f0
	ld bc, $0005 ; $41f3
	call CopyMemoryBC ; $41f6
	ld a, $ff ; $41f9
	ld [wStoryModeEntryPoint], a ; $41fb
	ld [$c294], a ; $41fe
	ld [wStoryModeExitLocationRequest], a ; $4201
	farcall InitStoryMatchSettings ; $4204
	ld a, [$c2b0] ; $4207
	add a, a ; $420a
	add a, $46 ; $420b
	ld l, a ; $420d
	adc a, $42 ; $420e
	sub a, l ; $4210
	ld h, a ; $4211
	ld a, [hl+] ; $4212
	ld h, [hl] ; $4213
	ld l, a ; $4214
	call JumpToHL ; $4215
	farcall RunStoryMatch ; $4218
	farcall RestoreOverworldAfterMatch ; $421b
	ret ; $421e
Label_10_421f:
	ret ; $421f
	dw Func_10_4354 ; $4220
	dw Func_10_4346 ; $4222
	dw Func_10_4338 ; $4224
	dw Func_10_432a ; $4226
	dw Func_10_438c ; $4228
	dw Func_10_437e ; $422a
	dw Func_10_4370 ; $422c
	dw Func_10_4362 ; $422e
	dw Func_10_43a8 ; $4230
	dw Func_10_431c ; $4232
	dw Func_10_439a ; $4234
	dw Func_10_43b6 ; $4236
	dw Func_10_42ba ; $4238
	dw Func_10_42c8 ; $423a
	dw Func_10_42d6 ; $423c
	dw Func_10_42e4 ; $423e
	dw Func_10_4266 ; $4240
	dw Func_10_4274 ; $4242
	dw Func_10_4282 ; $4244
	dw Func_10_43d2 ; $4246
	dw Func_10_43e0 ; $4248
	dw Func_10_43ee ; $424a
	dw Func_10_43c4 ; $424c
	dw Func_10_440a ; $424e
	dw Func_10_4418 ; $4250
	dw Func_10_4426 ; $4252
	dw Func_10_43fc ; $4254
	dw Func_10_4434 ; $4256
	dw Func_10_4442 ; $4258
	dw Func_10_42f2 ; $425a
	dw Func_10_4300 ; $425c
	dw Func_10_430e ; $425e
	dw Func_10_4290 ; $4260
	dw Func_10_429e ; $4262
	dw Func_10_42ac ; $4264
Func_10_4266:
	load_match_settings $0018 ; $4266
	ret ; $4273
Func_10_4274:
	load_match_settings $0017 ; $4274
	ret ; $4281
Func_10_4282:
	load_match_settings $0016 ; $4282
	ret ; $428f
Func_10_4290:
	load_match_settings $0118 ; $4290
	ret ; $429d
Func_10_429e:
	load_match_settings $0117 ; $429e
	ret ; $42ab
Func_10_42ac:
	load_match_settings $0116 ; $42ac
	ret ; $42b9
Func_10_42ba:
	load_match_settings $0010 ; $42ba
	ret ; $42c7
Func_10_42c8:
	load_match_settings $0011 ; $42c8
	ret ; $42d5
Func_10_42d6:
	load_match_settings $0012 ; $42d6
	ret ; $42e3
Func_10_42e4:
	load_match_settings $0013 ; $42e4
	ret ; $42f1
Func_10_42f2:
	load_match_settings $0111 ; $42f2
	ret ; $42ff
Func_10_4300:
	load_match_settings $0112 ; $4300
	ret ; $430d
Func_10_430e:
	load_match_settings $0113 ; $430e
	ret ; $431b
Func_10_431c:
	load_match_settings $0000 ; $431c
	ret ; $4329
Func_10_432a:
	load_match_settings $0004 ; $432a
	ret ; $4337
Func_10_4338:
	load_match_settings $0003 ; $4338
	ret ; $4345
Func_10_4346:
	load_match_settings $0002 ; $4346
	ret ; $4353
Func_10_4354:
	load_match_settings $0001 ; $4354
	ret ; $4361
Func_10_4362:
	load_match_settings $0009 ; $4362
	ret ; $436f
Func_10_4370:
	load_match_settings $0008 ; $4370
	ret ; $437d
Func_10_437e:
	load_match_settings $0007 ; $437e
	ret ; $438b
Func_10_438c:
	load_match_settings $0006 ; $438c
	ret ; $4399
Func_10_439a:
	load_match_settings $0005 ; $439a
	ret ; $43a7
Func_10_43a8:
	load_match_settings $0002 ; $43a8
	ret ; $43b5
Func_10_43b6:
	load_match_settings $000a ; $43b6
	ret ; $43c3
Func_10_43c4:
	load_match_settings $0100 ; $43c4
	ret ; $43d1
Func_10_43d2:
	load_match_settings $0102 ; $43d2
	ret ; $43df
Func_10_43e0:
	load_match_settings $0103 ; $43e0
	ret ; $43ed
Func_10_43ee:
	load_match_settings $0104 ; $43ee
	ret ; $43fb
Func_10_43fc:
	load_match_settings $0105 ; $43fc
	ret ; $4409
Func_10_440a:
	load_match_settings $0107 ; $440a
	ret ; $4417
Func_10_4418:
	load_match_settings $0108 ; $4418
	ret ; $4425
Func_10_4426:
	load_match_settings $0109 ; $4426
	ret ; $4433
Func_10_4434:
	load_match_settings $010d ; $4434
	ret ; $4441
Func_10_4442:
	load_match_settings $010a ; $4442
	ret ; $444f
RunDrillMatchListMenu:
	ld hl, $048d ; $4450
	ld a, $09 ; $4453
	farcall RunPagedTextMenu ; $4455
	cp a, $ff ; $4458
	jp z, Label_10_421f ; $445a
	push af ; $445d
	ld hl, wStoryModePlayersXPosition ; $445e
	ld de, wStoryModeSpawnPosition ; $4461
	ld bc, $0005 ; $4464
	call CopyMemoryBC ; $4467
	ld a, $ff ; $446a
	ld [wStoryModeEntryPoint], a ; $446c
	ld [$c294], a ; $446f
	ld [wStoryModeExitLocationRequest], a ; $4472
	ld a, $00 ; $4475
	ld [wCurrentStorySlot], a ; $4477
	farcall CheckStorySlot ; $447a
	pop af ; $447d
	set_flag $03, 6 ; $447e
	farcall RunTrainingDrillByID ; $4481
	ld a, $00 ; $4484
	ld [wCurrentStorySlot], a ; $4486
	farcall SaveStorySlotWithTimer ; $4489
	ret ; $448c
Func_10_448d:
	script_set_text Text_25_164 ; $448d
	script_speak $80 ; $4493
	ret ; $4498
	ld hl, wStoryModePlayersXPosition ; $4499
	ld de, wStoryModeSpawnPosition ; $449c
	ld bc, $0005 ; $449f
	call CopyMemoryBC ; $44a2
	ld a, $ff ; $44a5
	ld [wStoryModeEntryPoint], a ; $44a7
	ld [$c294], a ; $44aa
	ld [wStoryModeExitLocationRequest], a ; $44ad
	ld a, $00 ; $44b0
	ld [wCurrentStorySlot], a ; $44b2
	farcall CheckStorySlot ; $44b5
	set_flag $03, 4 ; $44b8
	ld c, $00 ; $44bb
	farcall Func_1c_401a ; $44bd
	clear_flag $03, 4 ; $44c0
	ld a, $00 ; $44c3
	ld [wCurrentStorySlot], a ; $44c5
	farcall SaveStorySlotWithTimer ; $44c8
	ret ; $44cb
RunLessonSelectMenu:
	call ClearFrameTasks ; $44cc
	ld b, $00 ; $44cf
	ld c, $02 ; $44d1
	ld d, $03 ; $44d3
	farcall ShowRankingBoard ; $44d5
	ld b, $01 ; $44d8
	ld c, $02 ; $44da
	ld d, $03 ; $44dc
	farcall ShowRankingBoard ; $44de
	ldh a, [hWramBank] ; $44e1
	push af ; $44e3
	wram_bank $07 ; $44e4
	ld de, $0000 ; $44ea
	ld hl, $de00 ; $44ed
	ld a, [hl+] ; $44f0
	ld d, [hl] ; $44f1
	ld e, a ; $44f2
	ld a, $01 ; $44f3
	farcall UpdateMinigameRecord ; $44f5
	ld a, $00 ; $44f8
	farcall UpdateMinigameRecord ; $44fa
	pop af ; $44fd
	wram_bank ; $44fe
	ld l, c ; $4502
	ld h, b ; $4503
	ld a, l ; $4504
	sub a, e ; $4505
	ld l, a ; $4506
	ld a, h ; $4507
	sbc a, d ; $4508
	ld h, a ; $4509
	ld hl, $1c0c ; $450a
	ld de, $0101 ; $450d
	ld a, $01 ; $4510
	farcall RunPagedTextMenu ; $4512
	cp a, $ff ; $4515
	jp z, Label_10_421f ; $4517
	ld a, a ; $451a
	rst Rst00 ; $451b
	dw RunServiceLessonMenu ; $451c jumptable
	dw RunNetLessonMenu ; $451e jumptable
	dw RunStrokeLessonMenu ; $4520 jumptable
	dw Label_10_45cc ; $4522 jumptable
RunServiceLessonMenu:
	ld hl, $1c0d ; $4524
	ld de, $0101 ; $4527
	ld a, $01 ; $452a
	farcall RunPagedTextMenu ; $452c
	cp a, $ff ; $452f
	jp z, Label_10_421f ; $4531
	add a, $03 ; $4534
	ld [wCurrentMinigameStoryMatch + 1], a ; $4536
	ld hl, wStoryModePlayersXPosition ; $4539
	ld de, wStoryModeSpawnPosition ; $453c
	ld bc, $0005 ; $453f
	call CopyMemoryBC ; $4542
	ld a, $ff ; $4545
	ld [wStoryModeEntryPoint], a ; $4547
	ld [$c294], a ; $454a
	ld [wStoryModeExitLocationRequest], a ; $454d
	ld c, $10 ; $4550
	call BeginFadeOut ; $4552
	call WaitFadeEnd ; $4555
	farcall ShowDrillBriefingScreen ; $4558
	ret ; $455b
RunNetLessonMenu:
	ld hl, $1c0e ; $455c
	ld de, $0101 ; $455f
	ld a, $01 ; $4562
	farcall RunPagedTextMenu ; $4564
	cp a, $ff ; $4567
	jp z, Label_10_421f ; $4569
	add a, $09 ; $456c
	ld [wCurrentMinigameStoryMatch + 1], a ; $456e
	ld hl, wStoryModePlayersXPosition ; $4571
	ld de, wStoryModeSpawnPosition ; $4574
	ld bc, $0005 ; $4577
	call CopyMemoryBC ; $457a
	ld a, $ff ; $457d
	ld [wStoryModeEntryPoint], a ; $457f
	ld [$c294], a ; $4582
	ld [wStoryModeExitLocationRequest], a ; $4585
	ld c, $10 ; $4588
	call BeginFadeOut ; $458a
	call WaitFadeEnd ; $458d
	farcall ShowDrillBriefingScreen ; $4590
	ret ; $4593
RunStrokeLessonMenu:
	ld hl, $1c0f ; $4594
	ld de, $0101 ; $4597
	ld a, $01 ; $459a
	farcall RunPagedTextMenu ; $459c
	cp a, $ff ; $459f
	jp z, Label_10_421f ; $45a1
	add a, $0f ; $45a4
	ld [wCurrentMinigameStoryMatch + 1], a ; $45a6
	ld hl, wStoryModePlayersXPosition ; $45a9
	ld de, wStoryModeSpawnPosition ; $45ac
	ld bc, $0005 ; $45af
	call CopyMemoryBC ; $45b2
	ld a, $ff ; $45b5
	ld [wStoryModeEntryPoint], a ; $45b7
	ld [$c294], a ; $45ba
	ld [wStoryModeExitLocationRequest], a ; $45bd
	ld c, $10 ; $45c0
	call BeginFadeOut ; $45c2
	call WaitFadeEnd ; $45c5
	farcall ShowDrillBriefingScreen ; $45c8
	ret ; $45cb
Label_10_45cc:
	ld hl, wStoryModePlayersXPosition ; $45cc
	ld de, wStoryModeSpawnPosition ; $45cf
	ld bc, $0005 ; $45d2
	call CopyMemoryBC ; $45d5
	ld a, $ff ; $45d8
	ld [wStoryModeEntryPoint], a ; $45da
	ld [$c294], a ; $45dd
	ld [wStoryModeExitLocationRequest], a ; $45e0
	ld c, $10 ; $45e3
	call BeginFadeOut ; $45e5
	call WaitFadeEnd ; $45e8
	call ClearFrameTasks ; $45eb
	xor a, a ; $45ee
	ldh [hBGColumnBlitPending], a ; $45ef
	ldh [hBGRowBlitPending], a ; $45f1
	ldh [hScrollY], a ; $45f3
	ldh [hScrollX], a ; $45f5
	ld [wCameraX + 1], a ; $45f7
	ld [wCameraY + 1], a ; $45fa
	call ClearFrameTasks ; $45fd
	ld b, $00 ; $4600
	ld c, $01 ; $4602
	ld d, $00 ; $4604
	farcall ShowRankingBoard ; $4606
	xor a, a ; $4609
	ldh [hBGColumnBlitPending], a ; $460a
	ldh [hBGRowBlitPending], a ; $460c
	ldh [hScrollY], a ; $460e
	ldh [hScrollX], a ; $4610
	ld [wCameraX + 1], a ; $4612
	ld [wCameraY + 1], a ; $4615
	call ClearFrameTasks ; $4618
	ld b, $00 ; $461b
	ld c, $02 ; $461d
	ld d, $00 ; $461f
	farcall ShowRankingBoard ; $4621
	xor a, a ; $4624
	ldh [hBGColumnBlitPending], a ; $4625
	ldh [hBGRowBlitPending], a ; $4627
	ldh [hScrollY], a ; $4629
	ldh [hScrollX], a ; $462b
	ld [wCameraX + 1], a ; $462d
	ld [wCameraY + 1], a ; $4630
	call ClearFrameTasks ; $4633
	ld b, $00 ; $4636
	ld c, $03 ; $4638
	ld d, $00 ; $463a
	farcall ShowRankingBoard ; $463c
	ret ; $463f
RunMinigameSelectMenu:
	ld hl, $0496 ; $4640
	ld a, $03 ; $4643
	farcall RunPagedTextMenu ; $4645
	cp a, $ff ; $4648
	jp z, Label_10_421f ; $464a
	ld de, $4684 ; $464d
	add a, e ; $4650
	ld e, a ; $4651
	jr nc, Label_10_4655 ; $4652
	inc d ; $4654
Label_10_4655:
	ld hl, $0499 ; $4655
	ld a, $01 ; $4658
	farcall RunPagedTextMenu ; $465a
	cp a, $ff ; $465d
	jp z, RunMinigameSelectMenu ; $465f
	ld [wMinigameLevel], a ; $4662
	ld a, [de] ; $4665
	set_flag $03, 6 ; $4666
	farcall RunTrainingDrillByID ; $4669
	ld hl, wStoryModePlayersXPosition ; $466c
	ld de, wStoryModeSpawnPosition ; $466f
	ld bc, $0005 ; $4672
	call CopyMemoryBC ; $4675
	ld a, $ff ; $4678
	ld [wStoryModeEntryPoint], a ; $467a
	ld [$c294], a ; $467d
	ld [wStoryModeExitLocationRequest], a ; $4680
	ret ; $4683
	; $4684, 9 bytes (bytes:16)
	db $1c, $1d, $1e, $1f, $20, $21, $22, $23, $24 ; 0x00
Test2MapScripts_10:
	; $468d, 14 bytes (map_tree)
	dw Test2EntryPoints_10 ; slot 0 EntryPoints
	dw Test2ExitTriggers_10 ; slot 1 ExitTriggers
	dw Test2Actors_10 ; slot 2 Actors
	dw Test2NpcScripts_10 ; slot 3 NpcScripts
	dw Test2FacingScripts_10 ; slot 4 FacingScripts
	dw Test2TileTriggers_10 ; slot 5 TileTriggers
	dw Test2InitScript_10 ; slot 6 InitScript
Test2Actors_10:
	; $469b, 234 bytes (map_actors)
	map_actor $0000, ActorScript_10_7bd1, $0500, $0f00, FACE_DOWN, $55, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $0500, $0500, FACE_DOWN, $27, $01, $07
	map_actor $0000, ActorScript_10_7bd1, $0500, $0300, FACE_DOWN, $26, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $0500, $0900, FACE_DOWN, $29, $01, $05
	map_actor $0000, ActorScript_10_7bd1, $0500, $0700, FACE_DOWN, $28, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $0500, $0d00, FACE_DOWN, $2a, $01, $07
	map_actor $0000, ActorScript_10_7bd1, $0500, $0b00, FACE_DOWN, $2d, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $0500, $1100, FACE_DOWN, $2b, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $0d00, $0300, FACE_DOWN, $2f, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $0d00, $0500, FACE_DOWN, $2f, $01, $07
	map_actor $0000, ActorScript_10_7bd1, $0d00, $0700, FACE_DOWN, $30, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $0d00, $0900, FACE_DOWN, $30, $01, $05
	map_actor $0000, ActorScript_10_7bd1, $0d00, $0b00, FACE_DOWN, $2f, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $0d00, $0d00, FACE_DOWN, $2f, $01, $07
	map_actor $0000, ActorScript_10_7bd1, $0d00, $0f00, FACE_DOWN, $30, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $0d00, $1100, FACE_DOWN, $30, $01, $00
	map_actor_end
Test2EntryPoints_10:
	; $4785, 9 bytes (map_entries)
	map_entry $01, FACE_DOWN, $0900, $0d00, $0000
	db $ff
Test2ExitTriggers_10:
	; $478e, 65 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_10, $0f, $0b
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_10, $0f, $0c
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_10, $0f, $0d
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_10, $0b, $0f
	map_script $05, FACEMASK_ANY, $0000, MapScriptNop_10, $0c, $0f
	map_script $06, FACEMASK_ANY, $0000, MapScriptNop_10, $10, $01
	map_script $07, FACEMASK_ANY, $0000, MapScriptNop_10, $07, $01
	map_script $08, FACEMASK_ANY, $0000, MapScriptNop_10, $00, $01
	db $ff
	ld hl, wStoryModePlayersXPosition ; $47cf
	ld de, wStoryModeSpawnPosition ; $47d2
	ld bc, $0005 ; $47d5
	call CopyMemoryBC ; $47d8
	ld a, $ff ; $47db
	ld [wStoryModeEntryPoint], a ; $47dd
	ld [$c294], a ; $47e0
	ld [wStoryModeExitLocationRequest], a ; $47e3
	set_flag $03, 6 ; $47e6
	ld hl, $0001 ; $47e9
	farcall PushTextArgNumber ; $47ec
	script_set_text Text_30_353 ; $47ef
	script_speak $80 ; $47f5
	ld a, $01 ; $47fa
	farcall RunTrainingDrillByID ; $47fc
	ret ; $47ff
	ld hl, wStoryModePlayersXPosition ; $4800
	ld de, wStoryModeSpawnPosition ; $4803
	ld bc, $0005 ; $4806
	call CopyMemoryBC ; $4809
	ld a, $ff ; $480c
	ld [wStoryModeEntryPoint], a ; $480e
	ld [$c294], a ; $4811
	ld [wStoryModeExitLocationRequest], a ; $4814
	set_flag $03, 6 ; $4817
	ld hl, $0002 ; $481a
	farcall PushTextArgNumber ; $481d
	script_set_text Text_30_353 ; $4820
	script_speak $80 ; $4826
	ld a, $02 ; $482b
	farcall RunTrainingDrillByID ; $482d
	ret ; $4830
	ld hl, wStoryModePlayersXPosition ; $4831
	ld de, wStoryModeSpawnPosition ; $4834
	ld bc, $0005 ; $4837
	call CopyMemoryBC ; $483a
	ld a, $ff ; $483d
	ld [wStoryModeEntryPoint], a ; $483f
	ld [$c294], a ; $4842
	ld [wStoryModeExitLocationRequest], a ; $4845
	set_flag $03, 6 ; $4848
	ld hl, $0003 ; $484b
	farcall PushTextArgNumber ; $484e
	script_set_text Text_30_353 ; $4851
	script_speak $80 ; $4857
	ld a, $03 ; $485c
	farcall RunTrainingDrillByID ; $485e
	ret ; $4861
	ld hl, wStoryModePlayersXPosition ; $4862
	ld de, wStoryModeSpawnPosition ; $4865
	ld bc, $0005 ; $4868
	call CopyMemoryBC ; $486b
	ld a, $ff ; $486e
	ld [wStoryModeEntryPoint], a ; $4870
	ld [$c294], a ; $4873
	ld [wStoryModeExitLocationRequest], a ; $4876
	set_flag $03, 6 ; $4879
	ld hl, $0004 ; $487c
	farcall PushTextArgNumber ; $487f
	script_set_text Text_30_353 ; $4882
	script_speak $80 ; $4888
	ld a, $04 ; $488d
	farcall RunTrainingDrillByID ; $488f
	ret ; $4892
	ld hl, wStoryModePlayersXPosition ; $4893
	ld de, wStoryModeSpawnPosition ; $4896
	ld bc, $0005 ; $4899
	call CopyMemoryBC ; $489c
	ld a, $ff ; $489f
	ld [wStoryModeEntryPoint], a ; $48a1
	ld [$c294], a ; $48a4
	ld [wStoryModeExitLocationRequest], a ; $48a7
	set_flag $03, 6 ; $48aa
	ld hl, $0005 ; $48ad
	farcall PushTextArgNumber ; $48b0
	script_set_text Text_30_353 ; $48b3
	script_speak $80 ; $48b9
	ld a, $05 ; $48be
	farcall RunTrainingDrillByID ; $48c0
	ret ; $48c3
	ld hl, wStoryModePlayersXPosition ; $48c4
	ld de, wStoryModeSpawnPosition ; $48c7
	ld bc, $0005 ; $48ca
	call CopyMemoryBC ; $48cd
	ld a, $ff ; $48d0
	ld [wStoryModeEntryPoint], a ; $48d2
	ld [$c294], a ; $48d5
	ld [wStoryModeExitLocationRequest], a ; $48d8
	set_flag $03, 6 ; $48db
	ld hl, $0006 ; $48de
	farcall PushTextArgNumber ; $48e1
	script_set_text Text_30_353 ; $48e4
	script_speak $80 ; $48ea
	ld a, $06 ; $48ef
	farcall RunTrainingDrillByID ; $48f1
	ret ; $48f4
	ld hl, wStoryModePlayersXPosition ; $48f5
	ld de, wStoryModeSpawnPosition ; $48f8
	ld bc, $0005 ; $48fb
	call CopyMemoryBC ; $48fe
	ld a, $ff ; $4901
	ld [wStoryModeEntryPoint], a ; $4903
	ld [$c294], a ; $4906
	ld [wStoryModeExitLocationRequest], a ; $4909
	set_flag $03, 6 ; $490c
	ld hl, $0007 ; $490f
	farcall PushTextArgNumber ; $4912
	script_set_text Text_30_353 ; $4915
	script_speak $80 ; $491b
	ld a, $07 ; $4920
	farcall RunTrainingDrillByID ; $4922
	ret ; $4925
	ld hl, wStoryModePlayersXPosition ; $4926
	ld de, wStoryModeSpawnPosition ; $4929
	ld bc, $0005 ; $492c
	call CopyMemoryBC ; $492f
	ld a, $ff ; $4932
	ld [wStoryModeEntryPoint], a ; $4934
	ld [$c294], a ; $4937
	ld [wStoryModeExitLocationRequest], a ; $493a
	set_flag $03, 6 ; $493d
	ld hl, $0008 ; $4940
	farcall PushTextArgNumber ; $4943
	script_set_text Text_30_353 ; $4946
	script_speak $80 ; $494c
	ld a, $08 ; $4951
	farcall RunTrainingDrillByID ; $4953
	ret ; $4956
Test2Npc0B_10:
	ld hl, wStoryModePlayersXPosition ; $4957
	ld de, wStoryModeSpawnPosition ; $495a
	ld bc, $0005 ; $495d
	call CopyMemoryBC ; $4960
	ld a, $ff ; $4963
	ld [wStoryModeEntryPoint], a ; $4965
	ld [$c294], a ; $4968
	ld [wStoryModeExitLocationRequest], a ; $496b
	set_flag $03, 6 ; $496e
	ld hl, $0009 ; $4971
	farcall PushTextArgNumber ; $4974
	script_set_text Text_30_353 ; $4977
	script_speak $80 ; $497d
	ld a, $09 ; $4982
	farcall RunTrainingDrillByID ; $4984
	ret ; $4987
Test2Npc0C_10:
	ld hl, wStoryModePlayersXPosition ; $4988
	ld de, wStoryModeSpawnPosition ; $498b
	ld bc, $0005 ; $498e
	call CopyMemoryBC ; $4991
	ld a, $ff ; $4994
	ld [wStoryModeEntryPoint], a ; $4996
	ld [$c294], a ; $4999
	ld [wStoryModeExitLocationRequest], a ; $499c
	set_flag $03, 6 ; $499f
	ld hl, $000a ; $49a2
	farcall PushTextArgNumber ; $49a5
	script_set_text Text_30_353 ; $49a8
	script_speak $80 ; $49ae
	ld a, $0a ; $49b3
	farcall RunTrainingDrillByID ; $49b5
	ret ; $49b8
Test2Npc0D_10:
	ld hl, wStoryModePlayersXPosition ; $49b9
	ld de, wStoryModeSpawnPosition ; $49bc
	ld bc, $0005 ; $49bf
	call CopyMemoryBC ; $49c2
	ld a, $ff ; $49c5
	ld [wStoryModeEntryPoint], a ; $49c7
	ld [$c294], a ; $49ca
	ld [wStoryModeExitLocationRequest], a ; $49cd
	set_flag $03, 6 ; $49d0
	ld hl, $000b ; $49d3
	farcall PushTextArgNumber ; $49d6
	script_set_text Text_30_353 ; $49d9
	script_speak $80 ; $49df
	ld a, $0b ; $49e4
	farcall RunTrainingDrillByID ; $49e6
	ret ; $49e9
Test2Npc0E_10:
	ld hl, wStoryModePlayersXPosition ; $49ea
	ld de, wStoryModeSpawnPosition ; $49ed
	ld bc, $0005 ; $49f0
	call CopyMemoryBC ; $49f3
	ld a, $ff ; $49f6
	ld [wStoryModeEntryPoint], a ; $49f8
	ld [$c294], a ; $49fb
	ld [wStoryModeExitLocationRequest], a ; $49fe
	set_flag $03, 6 ; $4a01
	ld hl, $000c ; $4a04
	farcall PushTextArgNumber ; $4a07
	script_set_text Text_30_353 ; $4a0a
	script_speak $80 ; $4a10
	ld a, $0c ; $4a15
	farcall RunTrainingDrillByID ; $4a17
	ret ; $4a1a
Test2Npc0F_10:
	ld hl, wStoryModePlayersXPosition ; $4a1b
	ld de, wStoryModeSpawnPosition ; $4a1e
	ld bc, $0005 ; $4a21
	call CopyMemoryBC ; $4a24
	ld a, $ff ; $4a27
	ld [wStoryModeEntryPoint], a ; $4a29
	ld [$c294], a ; $4a2c
	ld [wStoryModeExitLocationRequest], a ; $4a2f
	set_flag $03, 6 ; $4a32
	ld hl, $000d ; $4a35
	farcall PushTextArgNumber ; $4a38
	script_set_text Text_30_353 ; $4a3b
	script_speak $80 ; $4a41
	ld a, $0d ; $4a46
	farcall RunTrainingDrillByID ; $4a48
	ret ; $4a4b
Test2Npc10_10:
	ld hl, wStoryModePlayersXPosition ; $4a4c
	ld de, wStoryModeSpawnPosition ; $4a4f
	ld bc, $0005 ; $4a52
	call CopyMemoryBC ; $4a55
	ld a, $ff ; $4a58
	ld [wStoryModeEntryPoint], a ; $4a5a
	ld [$c294], a ; $4a5d
	ld [wStoryModeExitLocationRequest], a ; $4a60
	set_flag $03, 6 ; $4a63
	ld hl, $000e ; $4a66
	farcall PushTextArgNumber ; $4a69
	script_set_text Text_30_353 ; $4a6c
	script_speak $80 ; $4a72
	ld a, $0e ; $4a77
	farcall RunTrainingDrillByID ; $4a79
	ret ; $4a7c
Test2Npc11_10:
	ld hl, wStoryModePlayersXPosition ; $4a7d
	ld de, wStoryModeSpawnPosition ; $4a80
	ld bc, $0005 ; $4a83
	call CopyMemoryBC ; $4a86
	ld a, $ff ; $4a89
	ld [wStoryModeEntryPoint], a ; $4a8b
	ld [$c294], a ; $4a8e
	ld [wStoryModeExitLocationRequest], a ; $4a91
	set_flag $03, 6 ; $4a94
	ld hl, $000f ; $4a97
	farcall PushTextArgNumber ; $4a9a
	script_set_text Text_30_353 ; $4a9d
	script_speak $80 ; $4aa3
	ld a, $0f ; $4aa8
	farcall RunTrainingDrillByID ; $4aaa
	ret ; $4aad
Test2Npc12_10:
	ld hl, wStoryModePlayersXPosition ; $4aae
	ld de, wStoryModeSpawnPosition ; $4ab1
	ld bc, $0005 ; $4ab4
	call CopyMemoryBC ; $4ab7
	ld a, $ff ; $4aba
	ld [wStoryModeEntryPoint], a ; $4abc
	ld [$c294], a ; $4abf
	ld [wStoryModeExitLocationRequest], a ; $4ac2
	set_flag $03, 6 ; $4ac5
	ld hl, $0010 ; $4ac8
	farcall PushTextArgNumber ; $4acb
	script_set_text Text_30_353 ; $4ace
	script_speak $80 ; $4ad4
	ld a, $10 ; $4ad9
	farcall RunTrainingDrillByID ; $4adb
	ret ; $4ade
Test2NpcScripts_10:
	; $4adf, 129 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Text_33_33, $00, $00
	map_script $04, FACEMASK_ANY, $0000, Text_33_34, $00, $00
	map_script $05, FACEMASK_ANY, $0000, Text_33_35, $00, $00
	map_script $06, FACEMASK_ANY, $0000, Text_33_36, $00, $00
	map_script $07, FACEMASK_ANY, $0000, Text_33_37, $00, $00
	map_script $08, FACEMASK_ANY, $0000, Text_33_38, $00, $00
	map_script $09, FACEMASK_ANY, $0000, Text_33_39, $00, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_33_40, $00, $00
	map_script $0b, FACEMASK_ANY, $0000, Test2Npc0B_10, $00, $00
	map_script $0c, FACEMASK_ANY, $0000, Test2Npc0C_10, $00, $00
	map_script $0d, FACEMASK_ANY, $0000, Test2Npc0D_10, $00, $00
	map_script $0e, FACEMASK_ANY, $0000, Test2Npc0E_10, $00, $00
	map_script $0f, FACEMASK_ANY, $0000, Test2Npc0F_10, $00, $00
	map_script $10, FACEMASK_ANY, $0000, Test2Npc10_10, $00, $00
	map_script $11, FACEMASK_ANY, $0000, Test2Npc11_10, $00, $00
	map_script $12, FACEMASK_ANY, $0000, Test2Npc12_10, $00, $00
	db $ff
Test2FacingScripts_10:
	; $4b60, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, Test2Facing01_10, $00, $00
	db $ff
Test2Facing01_10:
	farcall BeginCutsceneScriptMode ; $4b69
	script_fade_in $10 ; $4b6c
	script_set_text Text_31_131 ; $4b71
	script_speak ACTOR_PLAYER ; $4b77
	farcall EndCutsceneScriptMode ; $4b7c
	ret ; $4b7f
Test2TileTriggers_10:
	; $4b80, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, Test2Tile01_10, $00, $00
	db $ff
Test2Tile01_10:
	farcall BeginCutsceneScriptMode ; $4b89
	script_set_text Text_31_128 ; $4b8c
	script_speak ACTOR_PLAYER ; $4b92
	farcall EndCutsceneScriptMode ; $4b97
	ret ; $4b9a
Test2InitScript_10:
	ld a, [wStoryModeEntryPoint] ; $4b9b
	cp a, $0f ; $4b9e
	ret z ; $4ba0
	farcall ClearStatusSetupMenuEntry ; $4ba1
	ld a, a ; $4ba4
	ld [$c294], a ; $4ba5
	ld [wStoryModeExitLocationRequest], a ; $4ba8
	ret ; $4bab
	farcall Func_08_6544 ; $4bac
	ld a, $02 ; $4baf
	ld [wCurrentlyUsedCourt], a ; $4bb1
	ld a, $02 ; $4bb4
	ld [wOnCourtCharCount], a ; $4bb6
	ldh a, [hRomBank] ; $4bb9
	ld de, $4bd8 ; $4bbb
	farcall SetModeHookTable ; $4bbe
	ld de, $4c13 ; $4bc1
	farcall SetMinigamePointTable ; $4bc4
	ld a, $1a ; $4bc7
	ld [wMatchPlayerChar], a ; $4bc9
	ld a, $04 ; $4bcc
	ld [wMatchOpponentChar], a ; $4bce
	farcall RunN64ExhibData ; $4bd1
	farcall RunMinigameMatch ; $4bd4
	ret ; $4bd7
	INCBIN "data/bank_010/d_4bd8.bin" ; $4bd8, 243 bytes
DevelopmentMapScripts_10:
	; $4ccb, 14 bytes (map_tree)
	dw DevelopmentEntryPoints_10 ; slot 0 EntryPoints
	dw DevelopmentExitTriggers_10 ; slot 1 ExitTriggers
	dw DevelopmentActors_10 ; slot 2 Actors
	dw DevelopmentNpcScripts_10 ; slot 3 NpcScripts
	dw DevelopmentFacingScripts_10 ; slot 4 FacingScripts
	dw DevelopmentTileTriggers_10 ; slot 5 TileTriggers
	dw DevelopmentInitScript_10 ; slot 6 InitScript
DevelopmentActors_10:
	; $4cd9, 20 bytes (map_actors)
	map_actor_end
	map_actor_end
DevelopmentEntryPoints_10:
	; $4ced, 9 bytes (map_entries)
	map_entry $01, FACE_DOWN, $0900, $0900, $0000
	db $ff
DevelopmentExitTriggers_10:
	; $4cf6, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_10, $01, $01
	db $ff
DevelopmentRespawnActors_10:
	ld c, $10 ; $4cff
	call BeginFadeOut ; $4d01
	call WaitFadeEnd ; $4d04
	ldh a, [hRomBank] ; $4d07
	ld hl, $4ce3 ; $4d09
	farcall ScriptRespawnLocationActors ; $4d0c
	script_fade_in $10 ; $4d0f
	call WaitFadeEnd ; $4d14
	ret ; $4d17
	script_move_target $03, $0100, $0100 ; $4d18
	script_wait_move $03 ; $4d23
	script_move_target $07, $0100, $0100 ; $4d28
	script_wait_move $07 ; $4d33
	script_move_target $0b, $0100, $0100 ; $4d38
	script_wait_move $0b ; $4d43
	script_move_target $10, $0100, $0100 ; $4d48
	script_wait_move $10 ; $4d53
	ld hl, wStoryModePlayersXPosition ; $4d58
	ld de, wStoryModeSpawnPosition ; $4d5b
	ld bc, $0005 ; $4d5e
	call CopyMemoryBC ; $4d61
	ld a, $ff ; $4d64
	ld [wStoryModeEntryPoint], a ; $4d66
	ld [$c294], a ; $4d69
	ld [wStoryModeExitLocationRequest], a ; $4d6c
	ret ; $4d6f
DevelopmentRespawnActorsAlt_10:
	ld c, $10 ; $4d70
	call BeginFadeOut ; $4d72
	call WaitFadeEnd ; $4d75
	ldh a, [hRomBank] ; $4d78
	ld hl, DevelopmentActors_10 ; $4d7a
	farcall ScriptRespawnLocationActors ; $4d7d
	script_fade_in $10 ; $4d80
	call WaitFadeEnd ; $4d85
	ret ; $4d88
	farcall BeginCutsceneScriptMode ; $4d89
	script_set_text Text_30_1 ; $4d8c
	script_speak ACTOR_PLAYER ; $4d92
	farcall EndCutsceneScriptMode ; $4d97
	ret ; $4d9a
	ret ; $4d9b
	INCBIN "data/bank_010/d_4d9c.bin" ; $4d9c, 10 bytes
	ld a, $0e ; $4da6
	ld [$c294], a ; $4da8
	ld [wStoryModeExitLocationRequest], a ; $4dab
	ret ; $4dae
DevelopmentNpcScripts_10:
	; $4daf, 129 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, DevelopmentRespawnActors_10, $00, $00
	map_script $04, FACEMASK_ANY, $0000, DevelopmentRespawnActors_10, $00, $00
	map_script $05, FACEMASK_ANY, $0000, DevelopmentRespawnActors_10, $00, $00
	map_script $06, FACEMASK_ANY, $0000, DevelopmentRespawnActors_10, $00, $00
	map_script $07, FACEMASK_ANY, $0000, DevelopmentRespawnActors_10, $00, $00
	map_script $08, FACEMASK_ANY, $0000, DevelopmentRespawnActors_10, $00, $00
	map_script $09, FACEMASK_ANY, $0000, DevelopmentRespawnActors_10, $00, $00
	map_script $0a, FACEMASK_ANY, $0000, DevelopmentRespawnActors_10, $00, $00
	map_script $0b, FACEMASK_ANY, $0000, DevelopmentRespawnActorsAlt_10, $00, $00
	map_script $0c, FACEMASK_ANY, $0000, DevelopmentRespawnActorsAlt_10, $00, $00
	map_script $0d, FACEMASK_ANY, $0000, DevelopmentRespawnActorsAlt_10, $03, $00
	map_script $0e, FACEMASK_ANY, $0000, DevelopmentRespawnActorsAlt_10, $00, $00
	map_script $0f, FACEMASK_ANY, $0000, DevelopmentRespawnActorsAlt_10, $00, $00
	map_script $10, FACEMASK_ANY, $0000, DevelopmentRespawnActorsAlt_10, $00, $00
	map_script $11, FACEMASK_ANY, $0000, DevelopmentRespawnActorsAlt_10, $00, $00
	map_script $12, FACEMASK_ANY, $0000, DevelopmentRespawnActorsAlt_10, $00, $00
	db $ff
DevelopmentFacingScripts_10:
	; $4e30, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, DevelopmentFacing01_10, $00, $00
	db $ff
DevelopmentFacing01_10:
	farcall BeginCutsceneScriptMode ; $4e39
	script_fade_in $10 ; $4e3c
	script_set_text Text_31_131 ; $4e41
	script_speak ACTOR_PLAYER ; $4e47
	farcall EndCutsceneScriptMode ; $4e4c
	ret ; $4e4f
DevelopmentTileTriggers_10:
	; $4e50, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, DevelopmentTile01_10, $00, $00
	db $ff
DevelopmentTile01_10:
	farcall BeginCutsceneScriptMode ; $4e59
	script_set_text Text_31_128 ; $4e5c
	script_speak ACTOR_PLAYER ; $4e62
	farcall EndCutsceneScriptMode ; $4e67
	ret ; $4e6a
DevelopmentInitScript_10:
	ret ; $4e6b
MainMenuMapScripts_10:
	; $4e6c, 14 bytes (map_tree)
	dw MainMenuEntryPoints_10 ; slot 0 EntryPoints
	dw MainMenuExitTriggers_10 ; slot 1 ExitTriggers
	dw MainMenuActors_10 ; slot 2 Actors
	dw MainMenuNpcScripts_10 ; slot 3 NpcScripts
	dw MainMenuFacingScripts_10 ; slot 4 FacingScripts
	dw MainMenuTileTriggers_10 ; slot 5 TileTriggers
	dw MainMenuInitScript_10 ; slot 6 InitScript
MainMenuActors_10:
	; $4e7a, 10 bytes (map_actors)
	map_actor_end
MainMenuEntryPoints_10:
	; $4e84, 9 bytes (map_entries)
	map_entry $01, FACE_DOWN, $ff00, $ff00, $0000
	db $ff
MainMenuExitTriggers_10:
	; $4e8d, 41 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_10, $14, $0f
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_10, $0a, $01
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_10, $04, $01
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_10, $06, $0f
	map_script $05, FACEMASK_ANY, $0000, MapScriptNop_10, $1d, $0f
	db $ff
MainMenuNpcScripts_10:
	ds 1, $ff ; $4eb6, fill
MainMenuFacingScripts_10:
	ds 1, $ff ; $4eb7, fill
MainMenuTileTriggers_10:
	ds 1, $ff ; $4eb8, fill
MainMenuInitScript_10:
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $4eb9
	call Func_10_4f0d ; $4ec4
	farcall TestStorySlotFlagA ; $4ec7
	call SetMusicMuted ; $4eca
	ret ; $4ecd
ApplyMatchTypeSettings:
	ld hl, $4f08 ; $4ece
	ld a, [wMatchFormatSets] ; $4ed1
	add a, l ; $4ed4
	ld l, a ; $4ed5
	jr nc, Label_10_4ed9 ; $4ed6
	inc h ; $4ed8
Label_10_4ed9:
	ld a, [hl] ; $4ed9
	ld [wMatchTypeNumberOfSets], a ; $4eda
	ld hl, $4f0b ; $4edd
	ld a, [wMatchFormatGames] ; $4ee0
	add a, l ; $4ee3
	ld l, a ; $4ee4
	jr nc, Label_10_4ee8 ; $4ee5
	inc h ; $4ee7
Label_10_4ee8:
	ld a, [hl] ; $4ee8
	ld [wMatchTypeNumberOfGames], a ; $4ee9
	ld a, [wMatchFormatDoubles] ; $4eec
	ld [wMatchIsDoubles], a ; $4eef
	or a, a ; $4ef2
	jr z, Label_10_4eff ; $4ef3
	ld a, $04 ; $4ef5
	ld [wOnCourtCharCount], a ; $4ef7
	set_flag $05, 7 ; $4efa
	jr Label_10_4f07 ; $4efd
Label_10_4eff:
	ld a, $02 ; $4eff
	ld [wOnCourtCharCount], a ; $4f01
	clear_flag $05, 7 ; $4f04
Label_10_4f07:
	ret ; $4f07
	; $4f08, 5 bytes (bytes:16)
	db $01, $03, $05, $02, $06 ; 0x00
Func_10_4f0d:
	call ClearFrameTasks ; $4f0d
	sound $00 ; $4f10
	call ResumeBGM ; $4f12
	ld a, [wStoryModeEntryPoint] ; $4f15
	cp a, $0a ; $4f18
	jr nz, Label_10_4f3c ; $4f1a
	call ClearFrameTasks ; $4f1c
	sound $00 ; $4f1f
	call ResumeBGM ; $4f21
	xor a, a ; $4f24
	ld [$cb71], a ; $4f25
Label_10_4f28:
	farcall Func_6b_51ae ; $4f28
	farcall Func_6b_51e7 ; $4f2b
	farcall Func_6b_402a ; $4f2e
Label_10_4f31:
	farcall Func_6b_75af ; $4f31
	cp a, $ff ; $4f34
	jr z, Label_10_4f28 ; $4f36
	cp a, $01 ; $4f38
	jr z, Label_10_4f28 ; $4f3a
Label_10_4f3c:
	farcall InitDefaultMatchSettings ; $4f3c
	xor a, a ; $4f3f
	ld [$cb1b], a ; $4f40
	ld [$cb1c], a ; $4f43
	ld [$cb1d], a ; $4f46
	ld [$cb1e], a ; $4f49
	ld [wMatchFormatDoubles], a ; $4f4c
	ld [wMatchFormatGames], a ; $4f4f
	ld [wMatchFormatSets], a ; $4f52
	call EnableLCD ; $4f55
	ld c, $7f ; $4f58
	call BeginFadeOut ; $4f5a
	call WaitFadeEnd ; $4f5d
	call DisableLCDSafely ; $4f60
	ld a, $01 ; $4f63
	ld [wMenuSlideDirection], a ; $4f65
Label_10_4f68:
	call DisableLCDSafely ; $4f68
	farcall Func_01_50e2 ; $4f6b
	farcall ResetScreenAndTextWindows ; $4f6e
	call EnableLCD ; $4f71
	script_fade_in $10 ; $4f74
	call WaitFadeEnd ; $4f79
Label_10_4f7c:
	xor a, a ; $4f7c
	ld [$cb22], a ; $4f7d
	ld [$cb1c], a ; $4f80
	ld [$cb1d], a ; $4f83
	ld [$cb1e], a ; $4f86
	ld [wMatchFormatDoubles], a ; $4f89
	ld [wMatchFormatGames], a ; $4f8c
	ld [wMatchFormatSets], a ; $4f8f
	ld [$cb0b], a ; $4f92
	ldh [hScrollX], a ; $4f95
	ldh [hScrollY], a ; $4f97
	ld [wCameraX], a ; $4f99
	ld [wCameraX + 1], a ; $4f9c
	ld [wCameraY], a ; $4f9f
	ld [wCameraY + 1], a ; $4fa2
	ld a, $03 ; $4fa5
	ld [$cb0c], a ; $4fa7
	call ResumeBGM ; $4faa
	call InitSerialLink ; $4fad
	farcall RunMainMenu ; $4fb0
	cp a, $ff ; $4fb3
	jp z, Label_10_4f31 ; $4fb5
	ld e, a ; $4fb8
	ld hl, MatchSelectHandlersB_10 ; $4fb9
	add a, a ; $4fbc
	add a, l ; $4fbd
	ld l, a ; $4fbe
	jr nc, Label_10_4fc2 ; $4fbf
	inc h ; $4fc1
Label_10_4fc2:
	ld a, [hl+] ; $4fc2
	ld h, [hl] ; $4fc3
	ld l, a ; $4fc4
	jp hl ; $4fc5
MatchSelectHandlersB_10:
	; $4fc6, 18 bytes (records:2)
	dw $4fd8 ; record 0
	dw $4fd8 ; record 1
	dw $4fd8 ; record 2
	dw $50fe ; record 3
	dw Label_10_5216 ; record 4
	dw $52a0 ; record 5
	dw Label_10_52d1 ; record 6
	dw $54b0 ; record 7
	dw Label_10_54d6 ; record 8
	ld a, e ; $4fd8
	cp a, $ff ; $4fd9
	jr z, Label_10_5041 ; $4fdb
	and a, $7f ; $4fdd
	ld [wCurrentStorySlot], a ; $4fdf
	farcall CheckStorySlot ; $4fe2
	cp a, $fe ; $4fe5
	jr z, Label_10_5041 ; $4fe7
	farcall Func_1e_6afd ; $4fe9
	or a, a ; $4fec
	jr z, Label_10_5006 ; $4fed
	call DisableLCDSafely ; $4fef
	farcall ResetScreenAndTextWindows ; $4ff2
	call EnableLCD ; $4ff5
	ld a, [$c8a5] ; $4ff8
	or a, a ; $4ffb
	jr nz, Label_10_5006 ; $4ffc
	script_fade_in $10 ; $4ffe
	call WaitFadeEnd ; $5003
Label_10_5006:
	ld a, [$c8a5] ; $5006
	or a, a ; $5009
	jp z, Label_10_50a4 ; $500a
	ld c, $00 ; $500d
	farcall ShowMatchResultsScreen ; $500f
	push af ; $5012
	call RestoreGameTimer ; $5013
	pop af ; $5016
	or a, a ; $5017
	jp z, Label_10_5093 ; $5018
	cp a, $ff ; $501b
	jp z, Label_10_4f68 ; $501d
	xor a, a ; $5020
	ld [$c8a5], a ; $5021
	farcall SaveStorySlotWithTimer ; $5024
	ld a, [wKeepMatchStatsFlag] ; $5027
	or a, a ; $502a
	jr z, Label_10_5030 ; $502b
	jp Label_10_55b6 ; $502d
Label_10_5030:
	farcall RestoreStoryReturnPoint ; $5030
	ld b, $0a ; $5033
	ld c, $01 ; $5035
	farcall SaveStoryReturnPoint ; $5037
	farcall SaveStorySlotWithTimer ; $503a
	farcall EndCutsceneScriptMode ; $503d
	ret ; $5040
Label_10_5041:
	ld a, $03 ; $5041
	ld [$cb0c], a ; $5043
	ld c, $10 ; $5046
	call BeginFadeOut ; $5048
	call WaitFadeEnd ; $504b
	ld a, e ; $504e
	ld [wCurrentStorySlot], a ; $504f
	farcall RunNewGameSetup ; $5052
	cp a, $ff ; $5055
	jp nz, Label_10_5073 ; $5057
	ld a, $00 ; $505a
	ld [wMenuSlideDirection], a ; $505c
	call DisableLCDSafely ; $505f
	farcall Func_01_50e2 ; $5062
	farcall ResetScreenAndTextWindows ; $5065
	call EnableLCD ; $5068
	script_fade_in $10 ; $506b
	jp Label_10_4f7c ; $5070
Label_10_5073:
	call ResetGameTimer ; $5073
	farcall Func_02_4364 ; $5076
	farcall SaveStorySlotWithTimer ; $5079
	test_flag $02, 5 ; $507c
	jr nz, Label_10_508a ; $507f
	ld a, $01 ; $5081
	ld [$c294], a ; $5083
	ld [wStoryModeExitLocationRequest], a ; $5086
	ret ; $5089
Label_10_508a:
	ld a, $03 ; $508a
	ld [$c294], a ; $508c
	ld [wStoryModeExitLocationRequest], a ; $508f
	ret ; $5092
Label_10_5093:
	call DisableLCDSafely ; $5093
	farcall ResetScreenAndTextWindows ; $5096
	call EnableLCD ; $5099
	script_fade_in $10 ; $509c
	call WaitFadeEnd ; $50a1
Label_10_50a4:
	xor a, a ; $50a4
	ld [$c8a5], a ; $50a5
	ld [wKeepMatchStatsFlag], a ; $50a8
	call RestoreGameTimer ; $50ab
	farcall SaveStorySlotWithTimer ; $50ae
	call Func_10_5752 ; $50b1
	ld [$cb74], a ; $50b4
	cp a, $04 ; $50b7
	jr z, Label_10_50ca ; $50b9
	farcall RunPlayAlonePartnerMenu ; $50bb
	cp a, $ff ; $50be
	jr nz, Label_10_50ca ; $50c0
	ld a, $00 ; $50c2
	ld [wMenuSlideDirection], a ; $50c4
	jp Label_10_4f7c ; $50c7
Label_10_50ca:
	call Func_10_5752 ; $50ca
	ld [$cb74], a ; $50cd
	call RestoreGameTimer ; $50d0
	ld a, $00 ; $50d3
	ld [wGameMode], a ; $50d5
	clear_flag $09, 7 ; $50d8
	ld b, $0a ; $50db
	ld c, $01 ; $50dd
	farcall SaveStoryReturnPoint ; $50df
	farcall SaveStorySlotWithTimer ; $50e2
	test_flag $02, 5 ; $50e5
	jr nz, Label_10_50f5 ; $50e8
	ld a, [$cb74] ; $50ea
	ld a, a ; $50ed
	ld [$c294], a ; $50ee
	ld [wStoryModeExitLocationRequest], a ; $50f1
	ret ; $50f4
Label_10_50f5:
	ld a, $03 ; $50f5
	ld [$c294], a ; $50f7
	ld [wStoryModeExitLocationRequest], a ; $50fa
	ret ; $50fd
	ld a, $03 ; $50fe
	ld [wCurrentStorySlot], a ; $5100
	farcall ReadExhibitionSaveBlock ; $5103
	bit 7, a ; $5106
	jr nz, Label_10_5137 ; $5108
	ld a, [$c8a5] ; $510a
	or a, a ; $510d
	jr z, Label_10_5137 ; $510e
	ld c, $00 ; $5110
	farcall ShowMatchResultsScreen ; $5112
	or a, a ; $5115
	jr z, Label_10_5124 ; $5116
	cp a, $ff ; $5118
	jp z, Label_10_4f68 ; $511a
	ld a, [wKeepMatchStatsFlag] ; $511d
	or a, a ; $5120
	jp nz, Label_10_51db ; $5121
Label_10_5124:
	call DisableLCDSafely ; $5124
	farcall ResetScreenAndTextWindows ; $5127
	call EnableLCD ; $512a
	push af ; $512d
	script_fade_in $10 ; $512e
	call WaitFadeEnd ; $5133
	pop af ; $5136
Label_10_5137:
	xor a, a ; $5137
	ld [$c8a8], a ; $5138
	ld a, $03 ; $513b
	ld [wCurrentStorySlot], a ; $513d
	farcall InitStoryModeState ; $5140
	farcall InitDefaultMatchSettings ; $5143
	farcall WriteExhibitionSaveBlock ; $5146
Label_10_5149:
	farcall RunMatchFormatSelect ; $5149
	cp a, $ff ; $514c
	jp z, Label_10_4f7c ; $514e
	ld c, $10 ; $5151
	call BeginFadeOut ; $5153
	call WaitFadeEnd ; $5156
Label_10_5159:
	ld a, [wMatchFormatDoubles] ; $5159
	ld b, a ; $515c
	farcall Func_38_4e65 ; $515d
	call Func_10_56fc ; $5160
	push af ; $5163
	call ClearFrameTasks ; $5164
	call DisableLCDSafely ; $5167
	farcall Func_01_50e2 ; $516a
	farcall ResetScreenAndTextWindows ; $516d
	xor a, a ; $5170
	ld [$cb53], a ; $5171
	ld [$cb54], a ; $5174
	farcall ComputeUnlockedCourtFlags ; $5177
	farcall LoadCourtSelectGraphics ; $517a
	pop af ; $517d
	cp a, $ff ; $517e
	jr nz, Label_10_5191 ; $5180
	call EnableLCD ; $5182
	script_fade_in $10 ; $5185
	ld a, $00 ; $518a
	ld [wMenuSlideDirection], a ; $518c
	jr Label_10_5149 ; $518f
Label_10_5191:
	ld a, $01 ; $5191
	ld [wMenuSlideDirection], a ; $5193
	farcall StubNop_3e ; $5196
	ld a, [$cb54] ; $5199
	or a, a ; $519c
	jr z, Label_10_51b6 ; $519d
	call EnableLCD ; $519f
	script_fade_in $10 ; $51a2
	farcall RunCourtSelect9Menu ; $51a7
	cp a, $ff ; $51aa
	jr nz, Label_10_51cd ; $51ac
	ld a, $00 ; $51ae
	ld [wMenuSlideDirection], a ; $51b0
	jp z, Label_10_5159 ; $51b3
Label_10_51b6:
	call EnableLCD ; $51b6
	script_fade_in $10 ; $51b9
	farcall RunCourtSelect4Menu ; $51be
	cp a, $ff ; $51c1
	jr nz, Label_10_51cd ; $51c3
	ld a, $00 ; $51c5
	ld [wMenuSlideDirection], a ; $51c7
	jp z, Label_10_5159 ; $51ca
Label_10_51cd:
	ld d, a ; $51cd
	wram_bank $04 ; $51ce
	ld a, d ; $51d4
	ld [wCurrentlyUsedCourt], a ; $51d5
	call ApplyMatchTypeSettings ; $51d8
Label_10_51db:
	ld a, $03 ; $51db
	ld [wCurrentStorySlot], a ; $51dd
	xor a, a ; $51e0
	ld [$c8a5], a ; $51e1
	farcall WriteExhibitionSaveBlock ; $51e4
	ld a, $04 ; $51e7
	ld [wGameMode], a ; $51e9
	farcall RunMatch ; $51ec
	ld a, [$c8a5] ; $51ef
	or a, a ; $51f2
	jr z, Label_10_51fd ; $51f3
	ld a, $01 ; $51f5
	ld [$c8a8], a ; $51f7
	farcall WriteExhibitionSaveBlock ; $51fa
Label_10_51fd:
	ld a, $01 ; $51fd
	ld [wMenuSlideDirection], a ; $51ff
	call DisableLCDSafely ; $5202
	farcall Func_01_50e2 ; $5205
	farcall ResetScreenAndTextWindows ; $5208
	call EnableLCD ; $520b
	script_fade_in $10 ; $520e
	jp Label_10_4f7c ; $5213
Label_10_5216:
	xor a, a ; $5216
	ld [wKeepMatchStatsFlag], a ; $5217
	farcall RunMinigameSelect ; $521a
	cp a, $ff ; $521d
	jr nz, Label_10_5229 ; $521f
	ld a, $00 ; $5221
	ld [wMenuSlideDirection], a ; $5223
	jp Label_10_4f7c ; $5226
Label_10_5229:
	ld a, $03 ; $5229
	ld [wCurrentStorySlot], a ; $522b
	ld a, [$cb20] ; $522e
	ld c, a ; $5231
	farcall RunMinigameLevelSelect ; $5232
	cp a, $ff ; $5235
	jr nz, Label_10_5241 ; $5237
	ld a, $00 ; $5239
	ld [wMenuSlideDirection], a ; $523b
	jp Label_10_5216 ; $523e
Label_10_5241:
	ld [wMinigameLevel], a ; $5241
	ld a, [$cb20] ; $5244
	ld b, a ; $5247
	add a, a ; $5248
	add a, b ; $5249
	ld c, a ; $524a
	ld a, [wMinigameLevel] ; $524b
	add a, c ; $524e
	farcall ShowRulesScreen ; $524f
	cp a, $ff ; $5252
	jr nz, Label_10_526e ; $5254
	call DisableLCDSafely ; $5256
	farcall Func_01_50e2 ; $5259
	farcall ResetScreenAndTextWindows ; $525c
	call EnableLCD ; $525f
	script_fade_in $10 ; $5262
	ld a, $00 ; $5267
	ld [wMenuSlideDirection], a ; $5269
	jr Label_10_5229 ; $526c
Label_10_526e:
	ld a, [$cb20] ; $526e
	call Func_10_56e9 ; $5271
	farcall RunTrainingDrillByID ; $5274
	ld a, $01 ; $5277
	ld [wMenuSlideDirection], a ; $5279
	call DisableLCDSafely ; $527c
	farcall Func_01_50e2 ; $527f
	farcall ResetScreenAndTextWindows ; $5282
	call EnableLCD ; $5285
	script_fade_in $10 ; $5288
	call WaitFadeEnd ; $528d
	ld a, [wMatchSelectNewLevelRequest] ; $5290
	or a, a ; $5293
	jr nz, Label_10_5229 ; $5294
	ld a, [wPointWinLoseFlag] ; $5296
	cp a, $01 ; $5299
	jr z, Label_10_5229 ; $529b
	jp Label_10_4f7c ; $529d
	ld a, $03 ; $52a0
	ld [wCurrentStorySlot], a ; $52a2
	farcall InitStoryModeState ; $52a5
	farcall InitDefaultMatchSettings ; $52a8
	farcall Func_38_7408Alias1 ; $52ab
	push af ; $52ae
	call InitSerialLink ; $52af
	pop af ; $52b2
	cp a, $ff ; $52b3
	jp z, Label_10_4f7c ; $52b5
	ld a, $01 ; $52b8
	ld [wMenuSlideDirection], a ; $52ba
	call DisableLCDSafely ; $52bd
	farcall Func_01_50e2 ; $52c0
	farcall ResetScreenAndTextWindows ; $52c3
	call EnableLCD ; $52c6
	script_fade_in $10 ; $52c9
	jp Label_10_4f7c ; $52ce
Label_10_52d1:
	farcall RunSavedDataSourceSelect ; $52d1
	cp a, $ff ; $52d4
	jp z, Label_10_4f7c ; $52d6
	cp a, $03 ; $52d9
	jp nc, Label_10_53d4 ; $52db
	ld [wCurrentStorySlot], a ; $52de
	farcall CheckStorySlot ; $52e1
Label_10_52e4:
	farcall RunN64TransferItemSelect ; $52e4
	cp a, $ff ; $52e7
	jp z, Label_10_52d1 ; $52e9
	or a, a ; $52ec
	jr nz, Label_10_5315 ; $52ed
	ld c, $10 ; $52ef
	call BeginFadeOut ; $52f1
	call WaitFadeEnd ; $52f4
	ld a, $00 ; $52f7
	farcall ShowCharDataScreen ; $52f9
	call DisableLCDSafely ; $52fc
	farcall Func_01_50e2 ; $52ff
	farcall ResetScreenAndTextWindows ; $5302
	call EnableLCD ; $5305
	script_fade_in $10 ; $5308
	ld a, $00 ; $530d
	ld [wMenuSlideDirection], a ; $530f
	jp Label_10_52e4 ; $5312
Label_10_5315:
	cp a, $01 ; $5315
	jr nz, Label_10_5345 ; $5317
	ld c, $10 ; $5319
	call BeginFadeOut ; $531b
	call WaitFadeEnd ; $531e
	farcall ShowGameProgressScreen ; $5321
	ld c, $10 ; $5324
	call BeginFadeOut ; $5326
	call WaitFadeEnd ; $5329
	call DisableLCDSafely ; $532c
	farcall Func_01_50e2 ; $532f
	farcall ResetScreenAndTextWindows ; $5332
	call EnableLCD ; $5335
	script_fade_in $10 ; $5338
	ld a, $00 ; $533d
	ld [wMenuSlideDirection], a ; $533f
	jp Label_10_52e4 ; $5342
Label_10_5345:
	cp a, $02 ; $5345
	jr nz, Label_10_536d ; $5347
	ld c, $10 ; $5349
	call BeginFadeOut ; $534b
	call WaitFadeEnd ; $534e
	farcall RunTrophiesScreen ; $5351
	call DisableLCDSafely ; $5354
	farcall Func_01_50e2 ; $5357
	farcall ResetScreenAndTextWindows ; $535a
	call EnableLCD ; $535d
	script_fade_in $10 ; $5360
	ld a, $00 ; $5365
	ld [wMenuSlideDirection], a ; $5367
	jp Label_10_52e4 ; $536a
Label_10_536d:
	farcall RunRacketShoesChoiceMenu ; $536d
	cp a, $00 ; $5370
	jr z, Label_10_5380 ; $5372
	cp a, $01 ; $5374
	jr z, Label_10_53aa ; $5376
	ld a, $00 ; $5378
	ld [wMenuSlideDirection], a ; $537a
	jp Label_10_52e4 ; $537d
Label_10_5380:
	ld c, $10 ; $5380
	call BeginFadeOut ; $5382
	call WaitFadeEnd ; $5385
	farcall RunRacketSelectScreen ; $5388
	farcall ShowEquipmentStatusScreen ; $538b
	farcall SaveStorySlot ; $538e
	call DisableLCDSafely ; $5391
	farcall Func_01_50e2 ; $5394
	farcall ResetScreenAndTextWindows ; $5397
	call EnableLCD ; $539a
	script_fade_in $10 ; $539d
	ld a, $00 ; $53a2
	ld [wMenuSlideDirection], a ; $53a4
	jp Label_10_536d ; $53a7
Label_10_53aa:
	ld c, $10 ; $53aa
	call BeginFadeOut ; $53ac
	call WaitFadeEnd ; $53af
	farcall RunShoesSelectScreen ; $53b2
	farcall ShowEquipmentStatusScreen ; $53b5
	farcall SaveStorySlot ; $53b8
	call DisableLCDSafely ; $53bb
	farcall Func_01_50e2 ; $53be
	farcall ResetScreenAndTextWindows ; $53c1
	call EnableLCD ; $53c4
	script_fade_in $10 ; $53c7
	ld a, $00 ; $53cc
	ld [wMenuSlideDirection], a ; $53ce
	jp Label_10_536d ; $53d1
Label_10_53d4:
	cp a, $03 ; $53d4
	jr nz, Label_10_543d ; $53d6
Label_10_53d8:
	farcall RunSavedDataTypeSelect ; $53d8
	cp a, $ff ; $53db
	jr nz, Label_10_53e2 ; $53dd
	jp Label_10_52d1 ; $53df
Label_10_53e2:
	or a, a ; $53e2
	jr nz, Label_10_5411 ; $53e3
	ld c, $10 ; $53e5
	call BeginFadeOut ; $53e7
	call WaitFadeEnd ; $53ea
	farcall RunStarCharExhibResults ; $53ed
	ld c, $10 ; $53f0
	call BeginFadeOut ; $53f2
	call WaitFadeEnd ; $53f5
	call DisableLCDSafely ; $53f8
	farcall Func_01_50e2 ; $53fb
	farcall ResetScreenAndTextWindows ; $53fe
	call EnableLCD ; $5401
	script_fade_in $10 ; $5404
	ld a, $00 ; $5409
	ld [wMenuSlideDirection], a ; $540b
	jp Label_10_53d8 ; $540e
Label_10_5411:
	ld c, $10 ; $5411
	call BeginFadeOut ; $5413
	call WaitFadeEnd ; $5416
	farcall ShowMinigameDataScreen ; $5419
	ld c, $10 ; $541c
	call BeginFadeOut ; $541e
	call WaitFadeEnd ; $5421
	call DisableLCDSafely ; $5424
	farcall Func_01_50e2 ; $5427
	farcall ResetScreenAndTextWindows ; $542a
	call EnableLCD ; $542d
	script_fade_in $10 ; $5430
	ld a, $00 ; $5435
	ld [wMenuSlideDirection], a ; $5437
	jp Label_10_53d8 ; $543a
Label_10_543d:
	farcall RunN64RecordTypeSelect ; $543d
	cp a, $ff ; $5440
	jp z, Label_10_52d1 ; $5442
	or a, a ; $5445
	jr nz, Label_10_546c ; $5446
	ld c, $10 ; $5448
	call BeginFadeOut ; $544a
	call WaitFadeEnd ; $544d
	farcall RunN64TnmtData ; $5450
	call DisableLCDSafely ; $5453
	farcall Func_01_50e2 ; $5456
	farcall ResetScreenAndTextWindows ; $5459
	call EnableLCD ; $545c
	script_fade_in $10 ; $545f
	ld a, $00 ; $5464
	ld [wMenuSlideDirection], a ; $5466
	jp Label_10_53d4 ; $5469
Label_10_546c:
	cp a, $01 ; $546c
	jr nz, Label_10_5494 ; $546e
	ld c, $10 ; $5470
	call BeginFadeOut ; $5472
	call WaitFadeEnd ; $5475
	farcall RunN64ExhibDataAlias1 ; $5478
	call DisableLCDSafely ; $547b
	farcall Func_01_50e2 ; $547e
	farcall ResetScreenAndTextWindows ; $5481
	call EnableLCD ; $5484
	script_fade_in $10 ; $5487
	ld a, $00 ; $548c
	ld [wMenuSlideDirection], a ; $548e
	jp Label_10_53d4 ; $5491
Label_10_5494:
	farcall RunN64RingShotData ; $5494
	call DisableLCDSafely ; $5497
	farcall Func_01_50e2 ; $549a
	farcall ResetScreenAndTextWindows ; $549d
	call EnableLCD ; $54a0
	script_fade_in $10 ; $54a3
	ld a, $00 ; $54a8
	ld [wMenuSlideDirection], a ; $54aa
	jp Label_10_53d4 ; $54ad
	ld c, $10 ; $54b0
	call BeginFadeOut ; $54b2
	call WaitFadeEnd ; $54b5
	ld a, $06 ; $54b8
	farcall TennisDictionaryScreen ; $54ba
	call DisableLCDSafely ; $54bd
	farcall Func_01_50e2 ; $54c0
	farcall ResetScreenAndTextWindows ; $54c3
	call EnableLCD ; $54c6
	script_fade_in $10 ; $54c9
	ld a, $00 ; $54ce
	ld [wMenuSlideDirection], a ; $54d0
	jp Label_10_4f7c ; $54d3
Label_10_54d6:
	farcall RunEraseSavedDataSelect ; $54d6
	cp a, $ff ; $54d9
	jp z, Label_10_4f7c ; $54db
	ld b, a ; $54de
	add a, a ; $54df
	ld hl, $54ec ; $54e0
	add a, l ; $54e3
	ld l, a ; $54e4
	jr nc, Label_10_54e8 ; $54e5
	inc h ; $54e7
Label_10_54e8:
	ld a, [hl+] ; $54e8
	ld h, [hl] ; $54e9
	ld l, a ; $54ea
	jp hl ; $54eb
	or a, $54 ; $54ec
	or a, $54 ; $54ee
	or a, $54 ; $54f0
	add hl, sp ; $54f2
	ld d, l ; $54f3
	ld h, l ; $54f4
	ld d, l ; $54f5
	ld a, b ; $54f6
	ld [wCurrentStorySlot], a ; $54f7
	farcall CheckStorySlot ; $54fa
	push bc ; $54fd
	ld c, $10 ; $54fe
	call BeginFadeOut ; $5500
	call WaitFadeEnd ; $5503
	farcall Func_1a_7945 ; $5506
	pop bc ; $5509
	or a, a ; $550a
	jr nz, Label_10_5520 ; $550b
	call Func_10_578a ; $550d
	or a, a ; $5510
	jr nz, Label_10_5520 ; $5511
	ld a, b ; $5513
	ld [wCurrentStorySlot], a ; $5514
	ld a, $00 ; $5517
	farcall EraseStorySlotSaveData ; $5519
	xor a, a ; $551c
	ld [$cb1b], a ; $551d
Label_10_5520:
	call DisableLCDSafely ; $5520
	farcall Func_01_50e2 ; $5523
	farcall ResetScreenAndTextWindows ; $5526
	call EnableLCD ; $5529
	script_fade_in $10 ; $552c
	ld a, $00 ; $5531
	ld [wMenuSlideDirection], a ; $5533
	jp Label_10_54d6 ; $5536
	ld c, $10 ; $5539
	call BeginFadeOut ; $553b
	call WaitFadeEnd ; $553e
	ld b, $01 ; $5541
	farcall RunEraseDataConfirmMenu ; $5543
	or a, a ; $5546
	jr z, Label_10_554c ; $5547
	farcall ClearSaveBlock11 ; $5549
Label_10_554c:
	call DisableLCDSafely ; $554c
	farcall Func_01_50e2 ; $554f
	farcall ResetScreenAndTextWindows ; $5552
	call EnableLCD ; $5555
	script_fade_in $10 ; $5558
	ld a, $00 ; $555d
	ld [wMenuSlideDirection], a ; $555f
	jp Label_10_54d6 ; $5562
	ld c, $10 ; $5565
	call BeginFadeOut ; $5567
	call WaitFadeEnd ; $556a
	ld b, $00 ; $556d
	farcall RunEraseDataConfirmMenu ; $556f
	or a, a ; $5572
	jr nz, Label_10_5592 ; $5573
	call DisableLCDSafely ; $5575
	farcall Func_01_50e2 ; $5578
	farcall ResetScreenAndTextWindows ; $557b
	call EnableLCD ; $557e
	script_fade_in $10 ; $5581
	ld a, $00 ; $5586
	ld [wMenuSlideDirection], a ; $5588
	xor a, a ; $558b
	ld [$cb1b], a ; $558c
	jp Label_10_54d6 ; $558f
Label_10_5592:
	farcall ReinitSaveRamPreservingBlock6 ; $5592
	call DisableLCDSafely ; $5595
	farcall Func_01_50e2 ; $5598
	farcall ResetScreenAndTextWindows ; $559b
	call EnableLCD ; $559e
	script_fade_in $10 ; $55a1
	ld a, $00 ; $55a6
	ld [wMenuSlideDirection], a ; $55a8
	xor a, a ; $55ab
	ld [$cb1b], a ; $55ac
	ld [$cb20], a ; $55af
	jp Label_10_54d6 ; $55b2
	ret ; $55b5
Label_10_55b6:
	farcall RunMatch ; $55b6
	ld a, [$c8a5] ; $55b9
	or a, a ; $55bc
	jr z, Label_10_55d5 ; $55bd
	farcall SaveStorySlotWithTimer ; $55bf
	ld a, $00 ; $55c2
	ld [wStoryModeCurrentLocation], a ; $55c4
	ld a, $01 ; $55c7
	ld [wStoryModeEntryPoint], a ; $55c9
	ld a, $ff ; $55cc
	ld [$c294], a ; $55ce
	ld [wStoryModeExitLocationRequest], a ; $55d1
	ret ; $55d4
Label_10_55d5:
	ld a, [wGameMode] ; $55d5
	cp a, $04 ; $55d8
	jr nz, Label_10_5604 ; $55da
	clear_flag $09, 7 ; $55dc
	xor a, a ; $55df
	ld [wKeepMatchStatsFlag], a ; $55e0
	ld b, $00 ; $55e3
	ld c, $01 ; $55e5
	farcall SaveStoryReturnPoint ; $55e7
	farcall SaveStorySlotWithTimer ; $55ea
	test_flag $02, 5 ; $55ed
	jr nz, Label_10_55fb ; $55f0
	ld a, $02 ; $55f2
	ld [$c294], a ; $55f4
	ld [wStoryModeExitLocationRequest], a ; $55f7
	ret ; $55fa
Label_10_55fb:
	ld a, $03 ; $55fb
	ld [$c294], a ; $55fd
	ld [wStoryModeExitLocationRequest], a ; $5600
	ret ; $5603
Label_10_5604:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $5604
	cp a, $14 ; $5607
	jr c, Label_10_561e ; $5609
	ld a, $1c ; $560b
	ld [wStoryModeCurrentLocation], a ; $560d
	ld a, $0a ; $5610
	ld [wStoryModeEntryPoint], a ; $5612
	ld a, $ff ; $5615
	ld [$c294], a ; $5617
	ld [wStoryModeExitLocationRequest], a ; $561a
	ret ; $561d
Label_10_561e:
	cp a, $0f ; $561e
	jr c, Label_10_564d ; $5620
	test_flag $05, 7 ; $5622
	jr nz, Label_10_563a ; $5625
	ld a, $19 ; $5627
	ld [wStoryModeCurrentLocation], a ; $5629
	ld a, $0a ; $562c
	ld [wStoryModeEntryPoint], a ; $562e
	ld a, $ff ; $5631
	ld [$c294], a ; $5633
	ld [wStoryModeExitLocationRequest], a ; $5636
	ret ; $5639
Label_10_563a:
	ld a, $19 ; $563a
	ld [wStoryModeCurrentLocation], a ; $563c
	ld a, $0b ; $563f
	ld [wStoryModeEntryPoint], a ; $5641
	ld a, $ff ; $5644
	ld [$c294], a ; $5646
	ld [wStoryModeExitLocationRequest], a ; $5649
	ret ; $564c
Label_10_564d:
	cp a, $0a ; $564d
	jr c, Label_10_5664 ; $564f
	ld a, $07 ; $5651
	ld [wStoryModeCurrentLocation], a ; $5653
	ld a, $0d ; $5656
	ld [wStoryModeEntryPoint], a ; $5658
	ld a, $ff ; $565b
	ld [$c294], a ; $565d
	ld [wStoryModeExitLocationRequest], a ; $5660
	ret ; $5663
Label_10_5664:
	cp a, $05 ; $5664
	jr c, Label_10_5690 ; $5666
	jr z, Label_10_567d ; $5668
	ld a, $10 ; $566a
	ld [wStoryModeCurrentLocation], a ; $566c
	ld a, $0f ; $566f
	ld [wStoryModeEntryPoint], a ; $5671
	ld a, $ff ; $5674
	ld [$c294], a ; $5676
	ld [wStoryModeExitLocationRequest], a ; $5679
	ret ; $567c
Label_10_567d:
	ld a, $10 ; $567d
	ld [wStoryModeCurrentLocation], a ; $567f
	ld a, $09 ; $5682
	ld [wStoryModeEntryPoint], a ; $5684
	ld a, $ff ; $5687
	ld [$c294], a ; $5689
	ld [wStoryModeExitLocationRequest], a ; $568c
	ret ; $568f
Label_10_5690:
	test_flag $05, 7 ; $5690
	jr nz, Label_10_56bf ; $5693
	cp a, $00 ; $5695
	jr z, Label_10_56ac ; $5697
	ld a, $0b ; $5699
	ld [wStoryModeCurrentLocation], a ; $569b
	ld a, $0f ; $569e
	ld [wStoryModeEntryPoint], a ; $56a0
	ld a, $ff ; $56a3
	ld [$c294], a ; $56a5
	ld [wStoryModeExitLocationRequest], a ; $56a8
	ret ; $56ab
Label_10_56ac:
	ld a, $0b ; $56ac
	ld [wStoryModeCurrentLocation], a ; $56ae
	ld a, $09 ; $56b1
	ld [wStoryModeEntryPoint], a ; $56b3
	ld a, $ff ; $56b6
	ld [$c294], a ; $56b8
	ld [wStoryModeExitLocationRequest], a ; $56bb
	ret ; $56be
Label_10_56bf:
	cp a, $00 ; $56bf
	jr z, Label_10_56d6 ; $56c1
	ld a, $0c ; $56c3
	ld [wStoryModeCurrentLocation], a ; $56c5
	ld a, $0f ; $56c8
	ld [wStoryModeEntryPoint], a ; $56ca
	ld a, $ff ; $56cd
	ld [$c294], a ; $56cf
	ld [wStoryModeExitLocationRequest], a ; $56d2
	ret ; $56d5
Label_10_56d6:
	ld a, $0c ; $56d6
	ld [wStoryModeCurrentLocation], a ; $56d8
	ld a, $09 ; $56db
	ld [wStoryModeEntryPoint], a ; $56dd
	ld a, $ff ; $56e0
	ld [$c294], a ; $56e2
	ld [wStoryModeExitLocationRequest], a ; $56e5
	ret ; $56e8
Func_10_56e9:
	ld hl, $56f3 ; $56e9
	add a, l ; $56ec
	ld l, a ; $56ed
	jr nc, Label_10_56f1 ; $56ee
	inc h ; $56f0
Label_10_56f1:
	ld a, [hl] ; $56f1
	ret ; $56f2
	; $56f3, 9 bytes (bytes:16)
	db $1c, $1d, $1e, $1f, $20, $21, $22, $23, $24 ; 0x00
Func_10_56fc:
	push af ; $56fc
	ldh a, [hWramBank] ; $56fd
	push af ; $56ff
	wram_bank $03 ; $5700
	ld hl, $d816 ; $5706
	ld de, $c8b5 ; $5709
	ld a, [hl+] ; $570c
	ld [de], a ; $570d
	inc de ; $570e
	ld a, [hl+] ; $570f
	ld [de], a ; $5710
	inc de ; $5711
	ld a, [hl+] ; $5712
	ld [de], a ; $5713
	inc de ; $5714
	ld a, [hl+] ; $5715
	ld [de], a ; $5716
	pop af ; $5717
	wram_bank ; $5718
	pop af ; $571c
	ret ; $571d
	ld a, [wCurrentStorySlot] ; $571e
	push af ; $5721
	xor a, a ; $5722
	ld [wCurrentStorySlot], a ; $5723
	farcall CheckStorySlot ; $5726
	cp a, $fe ; $5729
	jr nz, Label_10_574b ; $572b
	ld a, $01 ; $572d
	ld [wCurrentStorySlot], a ; $572f
	farcall CheckStorySlot ; $5732
	cp a, $fe ; $5735
	jr nz, Label_10_574b ; $5737
	ld a, $02 ; $5739
	ld [wCurrentStorySlot], a ; $573b
	farcall CheckStorySlot ; $573e
	cp a, $fe ; $5741
	jr nz, Label_10_574b ; $5743
	pop af ; $5745
	xor a, a ; $5746
	ld [wCurrentStorySlot], a ; $5747
	ret ; $574a
Label_10_574b:
	pop af ; $574b
	ld [wCurrentStorySlot], a ; $574c
	ld a, $01 ; $574f
	ret ; $5751
Func_10_5752:
	test_flag $05, 7 ; $5752
	jr nz, Label_10_5770 ; $5755
	test_flag $07, 4 ; $5757
	ld a, $02 ; $575a
	jr z, Label_10_5789 ; $575c
	test_flag $16, 0 ; $575e
	ld a, $04 ; $5761
	jr z, Label_10_5789 ; $5763
	test_flag $16, 2 ; $5765
	ld a, $05 ; $5768
	jr z, Label_10_5789 ; $576a
	ld a, $02 ; $576c
	jr Label_10_5789 ; $576e
Label_10_5770:
	test_flag $06, 5 ; $5770
	ld a, $02 ; $5773
	jr z, Label_10_5789 ; $5775
	test_flag $16, 1 ; $5777
	ld a, $04 ; $577a
	jr z, Label_10_5789 ; $577c
	test_flag $16, 3 ; $577e
	ld a, $05 ; $5781
	jr z, Label_10_5789 ; $5783
	ld a, $02 ; $5785
	jr Label_10_5789 ; $5787
Label_10_5789:
	ret ; $5789
Func_10_578a:
	push af ; $578a
	push bc ; $578b
	farcall ReadExhibitionSaveBlock ; $578c
	bit 7, a ; $578f
	jr nz, Label_10_57f3 ; $5791
	ld a, [$c8a5] ; $5793
	or a, a ; $5796
	jr z, Label_10_57f3 ; $5797
	ld a, [wCurrentStorySlot] ; $5799
	ld b, a ; $579c
	ld a, [$c8b5] ; $579d
	bit 7, a ; $57a0
	jr z, Label_10_57ab ; $57a2
	and a, $7f ; $57a4
	srl a ; $57a6
	cp a, b ; $57a8
	jr z, Label_10_57d7 ; $57a9
Label_10_57ab:
	ld a, [$c8b6] ; $57ab
	bit 7, a ; $57ae
	jr z, Label_10_57b9 ; $57b0
	and a, $7f ; $57b2
	srl a ; $57b4
	cp a, b ; $57b6
	jr z, Label_10_57d7 ; $57b7
Label_10_57b9:
	ld a, [$c8b7] ; $57b9
	bit 7, a ; $57bc
	jr z, Label_10_57c7 ; $57be
	and a, $7f ; $57c0
	srl a ; $57c2
	cp a, b ; $57c4
	jr z, Label_10_57d7 ; $57c5
Label_10_57c7:
	ld a, [$c8b8] ; $57c7
	bit 7, a ; $57ca
	jr z, Label_10_57d5 ; $57cc
	and a, $7f ; $57ce
	srl a ; $57d0
	cp a, b ; $57d2
	jr z, Label_10_57d7 ; $57d3
Label_10_57d5:
	jr Label_10_57f3 ; $57d5
Label_10_57d7:
	ld b, $02 ; $57d7
	farcall RunEraseDataConfirmMenu ; $57d9
	or a, a ; $57dc
	jr z, Label_10_57ee ; $57dd
	xor a, a ; $57df
	ld [$c8a5], a ; $57e0
	ld [wKeepMatchStatsFlag], a ; $57e3
	farcall WriteExhibitionSaveBlock ; $57e6
	pop bc ; $57e9
	pop af ; $57ea
	ld a, $00 ; $57eb
	ret ; $57ed
Label_10_57ee:
	pop bc ; $57ee
	pop af ; $57ef
	ld a, $01 ; $57f0
	ret ; $57f2
Label_10_57f3:
	pop bc ; $57f3
	pop af ; $57f4
	ret ; $57f5
CafeteriaMapScripts_10:
	; $57f6, 14 bytes (map_tree)
	dw CafeteriaEntryPoints_10 ; slot 0 EntryPoints
	dw CafeteriaExitTriggers_10 ; slot 1 ExitTriggers
	dw CafeteriaActors_10 ; slot 2 Actors
	dw CafeteriaNpcScripts_10 ; slot 3 NpcScripts
	dw CafeteriaFacingScripts_10 ; slot 4 FacingScripts
	dw CafeteriaTileTriggers_10 ; slot 5 TileTriggers
	dw CafeteriaInitScript_10 ; slot 6 InitScript
CafeteriaActors_10:
	; $5804, 108 bytes (map_actors)
	map_actor $0000, ActorScript_10_7bd1, $3b00, $3700, FACE_DOWN, $30, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $3d00, $3900, FACE_LEFT, $30, $01, $05
	map_actor $0000, ActorScript_10_7bd1, $3d00, $3b00, FACE_LEFT, $3a, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $2f00, $3100, FACE_RIGHT, $3a, $01, $07
	map_actor $0000, ActorScript_10_7bd1, $3300, $3100, FACE_LEFT, $3b, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $3700, $2f00, FACE_RIGHT, $3c, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $3b00, $2f00, FACE_LEFT, $3b, $01, $04
	map_actor_end
CafeteriaEntryPoints_10:
	; $5870, 9 bytes (map_entries)
	map_entry $01, FACE_DOWN, $2700, $3700, $0000
	db $ff
CafeteriaExitTriggers_10:
	; $5879, 9 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Func_10_7b1f, $0d, $02
	db $ff
CafeteriaNpc03_10:
	ld a, [$c2b0] ; $5882
	add a, a ; $5885
	add a, $99 ; $5886
	ld l, a ; $5888
	adc a, $58 ; $5889
	sub a, l ; $588b
	ld h, a ; $588c
	ld a, [hl+] ; $588d
	ld h, [hl] ; $588e
	ld l, a ; $588f
	farcall InitDialogueTextCursor ; $5890
	script_speak $03 ; $5893
	ret ; $5898
	; $5899, 20 bytes (records:2)
	dw $0c3b ; record 0
	dw $0c3c ; record 1
	dw $0c62 ; record 2
	dw $0c63 ; record 3
	dw $0c8f ; record 4
	dw $0c8f ; record 5
	dw $0cb7 ; record 6
	dw $0cb7 ; record 7
	dw $0cda ; record 8
	dw $0cda ; record 9
CafeteriaNpc04_10:
	ld a, [$c2b1] ; $58ad
	add a, a ; $58b0
	add a, $21 ; $58b1
	ld l, a ; $58b3
	adc a, $59 ; $58b4
	sub a, l ; $58b6
	ld h, a ; $58b7
	ld a, [hl+] ; $58b8
	ld h, [hl] ; $58b9
	ld l, a ; $58ba
	farcall InitDialogueTextCursor ; $58bb
	ld a, [$c2b1] ; $58be
	cp a, $03 ; $58c1
	jr c, Label_10_58e4 ; $58c3
	ld a, [$c2b1] ; $58c5
	cp a, $04 ; $58c8
	jr z, Label_10_58ea ; $58ca
	ld a, $04 ; $58cc
	farcall ScriptShowSpeakerDialogueRestoreBG ; $58ce
	farcall RunDialogueYesNoPrompt ; $58d1
	farcall ScriptCloseDialogueWindow ; $58d4
	script_wait_frames $05 ; $58d7
	and a, a ; $58de
	jr z, Label_10_58e4 ; $58df
	farcall AdvanceDialogueTextCursor ; $58e1
Label_10_58e4:
	script_speak $04 ; $58e4
	ret ; $58e9
Label_10_58ea:
	ld a, [$c2b0] ; $58ea
	cp a, $09 ; $58ed
	jr nz, Label_10_58f4 ; $58ef
	farcall AdvanceDialogueTextCursor ; $58f1
Label_10_58f4:
	ld a, $04 ; $58f4
	farcall ScriptShowSpeakerDialogueRestoreBG ; $58f6
	farcall RunDialogueYesNoPrompt ; $58f9
	farcall ScriptCloseDialogueWindow ; $58fc
	script_wait_frames $05 ; $58ff
	and a, a ; $5906
	jr z, Label_10_5915 ; $5907
	script_set_text Text_33_222 ; $5909
	script_speak $04 ; $590f
	ret ; $5914
Label_10_5915:
	script_set_text Text_33_221 ; $5915
	script_speak $04 ; $591b
	ret ; $5920
	; $5921, 10 bytes (records:2)
	dw $0c3d ; record 0
	dw $0c64 ; record 1
	dw $0c90 ; record 2
	dw $0cb8 ; record 3
	dw $0cdb ; record 4
CafeteriaNpc05_10:
	ld a, [$c2b1] ; $592b
	add a, a ; $592e
	add a, $61 ; $592f
	ld l, a ; $5931
	adc a, $59 ; $5932
	sub a, l ; $5934
	ld h, a ; $5935
	ld a, [hl+] ; $5936
	ld h, [hl] ; $5937
	ld l, a ; $5938
	farcall InitDialogueTextCursor ; $5939
	ld a, [$c2b1] ; $593c
	cp a, $01 ; $593f
	jr nz, Label_10_595b ; $5941
	ld a, $05 ; $5943
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5945
	farcall RunDialogueYesNoPrompt ; $5948
	farcall ScriptCloseDialogueWindow ; $594b
	script_wait_frames $05 ; $594e
	and a, a ; $5955
	jr z, Label_10_595b ; $5956
	farcall AdvanceDialogueTextCursor ; $5958
Label_10_595b:
	script_speak $05 ; $595b
	ret ; $5960
	; $5961, 10 bytes (records:2)
	dw $0c3e ; record 0
	dw $0c65 ; record 1
	dw $0c91 ; record 2
	dw $0cbb ; record 3
	dw $0cdf ; record 4
CafeteriaNpc06_10:
	ld a, [$c2b0] ; $596b
	add a, a ; $596e
	add a, $82 ; $596f
	ld l, a ; $5971
	adc a, $59 ; $5972
	sub a, l ; $5974
	ld h, a ; $5975
	ld a, [hl+] ; $5976
	ld h, [hl] ; $5977
	ld l, a ; $5978
	farcall InitDialogueTextCursor ; $5979
	script_speak $06 ; $597c
	ret ; $5981
	; $5982, 20 bytes (records:2)
	dw $0c3f ; record 0
	dw $0c3f ; record 1
	dw $0c68 ; record 2
	dw $0c69 ; record 3
	dw $0c92 ; record 4
	dw $0c93 ; record 5
	dw $0cbc ; record 6
	dw $0cbd ; record 7
	dw $0cbc ; record 8
	dw $0cbd ; record 9
CafeteriaNpc07_10:
	ld a, [$c2b0] ; $5996
	add a, a ; $5999
	add a, $ad ; $599a
	ld l, a ; $599c
	adc a, $59 ; $599d
	sub a, l ; $599f
	ld h, a ; $59a0
	ld a, [hl+] ; $59a1
	ld h, [hl] ; $59a2
	ld l, a ; $59a3
	farcall InitDialogueTextCursor ; $59a4
	script_speak $07 ; $59a7
	ret ; $59ac
	; $59ad, 20 bytes (records:2)
	dw $0c40 ; record 0
	dw $0c40 ; record 1
	dw $0c6a ; record 2
	dw $0c6b ; record 3
	dw $0c94 ; record 4
	dw $0c95 ; record 5
	dw $0cbe ; record 6
	dw $0cbf ; record 7
	dw $0cbe ; record 8
	dw $0cbf ; record 9
CafeteriaNpc08_10:
	ld a, [$c2b0] ; $59c1
	add a, a ; $59c4
	add a, $d8 ; $59c5
	ld l, a ; $59c7
	adc a, $59 ; $59c8
	sub a, l ; $59ca
	ld h, a ; $59cb
	ld a, [hl+] ; $59cc
	ld h, [hl] ; $59cd
	ld l, a ; $59ce
	farcall InitDialogueTextCursor ; $59cf
	script_speak $08 ; $59d2
	ret ; $59d7
	; $59d8, 20 bytes (records:2)
	dw $0c41 ; record 0
	dw $0c41 ; record 1
	dw $0c6c ; record 2
	dw $0c6c ; record 3
	dw $0c96 ; record 4
	dw $0c97 ; record 5
	dw $0cc0 ; record 6
	dw $0cc1 ; record 7
	dw $0ce0 ; record 8
	dw $0cc1 ; record 9
CafeteriaNpc09_10:
	ld a, [$c2b0] ; $59ec
	add a, a ; $59ef
	add a, $03 ; $59f0
	ld l, a ; $59f2
	adc a, $5a ; $59f3
	sub a, l ; $59f5
	ld h, a ; $59f6
	ld a, [hl+] ; $59f7
	ld h, [hl] ; $59f8
	ld l, a ; $59f9
	farcall InitDialogueTextCursor ; $59fa
	script_speak $09 ; $59fd
	ret ; $5a02
	; $5a03, 20 bytes (records:2)
	dw $0c42 ; record 0
	dw $0c42 ; record 1
	dw $0c6d ; record 2
	dw $0c6d ; record 3
	dw $0c98 ; record 4
	dw $0c98 ; record 5
	dw $0cc2 ; record 6
	dw $0cc3 ; record 7
	dw $0cc2 ; record 8
	dw $0cc3 ; record 9
CafeteriaNpcScripts_10:
	; $5a17, 57 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, CafeteriaNpc03_10, $03, $00
	map_script $04, FACEMASK_ANY, $0000, CafeteriaNpc04_10, $03, $00
	map_script $05, FACEMASK_ANY, $0000, CafeteriaNpc05_10, $03, $00
	map_script $06, FACEMASK_ANY, $0000, CafeteriaNpc06_10, $03, $00
	map_script $07, FACEMASK_ANY, $0000, CafeteriaNpc07_10, $03, $00
	map_script $08, FACEMASK_ANY, $0000, CafeteriaNpc08_10, $03, $00
	map_script $09, FACEMASK_ANY, $0000, CafeteriaNpc09_10, $03, $00
	db $ff
CafeteriaFacingScripts_10:
	ds 1, $ff ; $5a50, fill
CafeteriaTileTriggers_10:
	ds 1, $ff ; $5a51, fill
CafeteriaInitScript_10:
	call Func_10_7dbd ; $5a52
	ld a, [$c2b0] ; $5a55
	sra a ; $5a58
	ld [$c2b1], a ; $5a5a
	ld a, $22 ; $5a5d
	ld [$c329], a ; $5a5f
	ld a, $26 ; $5a62
	ld [$c32a], a ; $5a64
	ld a, $40 ; $5a67
	ld [$c32b], a ; $5a69
	ld a, $3e ; $5a6c
	ld [$c32c], a ; $5a6e
	call DisableLCDSafely ; $5a71
	ld a, $00 ; $5a74
	farcall CopyScrolledSceneTilemapToVram ; $5a76
	call EnableLCD ; $5a79
	call MapArrivalWalkPair_10 ; $5a7c
	ret ; $5a7f
RestaurantMapScripts_10:
	; $5a80, 14 bytes (map_tree)
	dw RestaurantEntryPoints_10 ; slot 0 EntryPoints
	dw RestaurantExitTriggers_10 ; slot 1 ExitTriggers
	dw RestaurantActors_10 ; slot 2 Actors
	dw RestaurantNpcScripts_10 ; slot 3 NpcScripts
	dw RestaurantFacingScripts_10 ; slot 4 FacingScripts
	dw RestaurantTileTriggers_10 ; slot 5 TileTriggers
	dw RestaurantInitScript_10 ; slot 6 InitScript
RestaurantActors_10:
	; $5a8e, 248 bytes (map_actors)
	map_actor $0000, ActorScript_10_7bd1, $1100, $1900, FACE_LEFT, $2f, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $2100, $1500, FACE_UP, $2f, $01, $07
	map_actor $0000, ActorScript_10_7bd1, $1600, $1300, FACE_DOWN, $30, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $1d00, $1700, FACE_UP, $31, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $2900, $2900, FACE_RIGHT, $4c, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $2100, $1100, FACE_RIGHT, $33, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $0900, $0f00, FACE_RIGHT, $34, $01, $00
	map_actor $0000, ActorScript_10_7bdb, $0b00, $1900, FACE_LEFT, $30, $01, $06
	map_actor $0000, ActorScript_10_7bd1, $0d00, $0f00, FACE_LEFT, $3a, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $1500, $0b00, FACE_LEFT, $33, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $1d00, $0b00, FACE_LEFT, $3c, $01, $04
	map_actor $0000, ActorScript_10_7bd1, $1b00, $0900, FACE_DOWN, $3b, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $1d00, $0f00, FACE_LEFT, $3c, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $1900, $0f00, FACE_RIGHT, $3b, $01, $06
	map_actor $0000, ActorScript_10_7bd1, $2900, $2900, FACE_RIGHT, $4f, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $1b00, $1200, FACE_DOWN, $3a, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $1900, $0900, FACE_DOWN, $35, $01, $00
	map_actor_end
RestaurantEntryPoints_10:
	; $5b86, 17 bytes (map_entries)
	map_entry $01, FACE_UP, $0c00, $2100, RestaurantArrival01_10
	map_entry $02, FACE_DOWN, $0500, $1700, MapArrivalWalkPair_10
	db $ff
RestaurantArrival01_10:
	ld a, [wStoryModeEntryPoint] ; $5b97
	cp a, $ff ; $5b9a
	jp z, Label_10_5bdc ; $5b9c
	test_flag $05, 7 ; $5b9f
	jr z, Label_10_5bca ; $5ba2
	script_set_speed ACTOR_PARTNER, $00ff ; $5ba4
	script_move_angle ACTOR_PARTNER, FACE_DOWN, $0200 ; $5bac
	script_wait_move ACTOR_PARTNER ; $5bb6
	script_face ACTOR_PARTNER, FACE_UP ; $5bbb
	script_set_speed ACTOR_PARTNER, $0010 ; $5bc2
Label_10_5bca:
	script_set_speed ACTOR_PLAYER, $0010 ; $5bca
	script_move_angle ACTOR_PLAYER, FACE_UP, $0200 ; $5bd2
Label_10_5bdc:
	ret ; $5bdc
RestaurantExitTriggers_10:
	; $5bdd, 17 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, RestaurantExit01_10, $08, $02
	map_script $02, FACEMASK_ANY, $0000, Func_10_7ae6, $0e, $01
	db $ff
RestaurantExit01_10:
	clear_flag $0f, 3 ; $5bee
	ret ; $5bf1
RestaurantNpc03_10:
	ld a, [$c2b1] ; $5bf2
	add a, a ; $5bf5
	add a, $13 ; $5bf6
	ld l, a ; $5bf8
	adc a, $5c ; $5bf9
	sub a, l ; $5bfb
	ld h, a ; $5bfc
	ld a, [hl+] ; $5bfd
	ld h, [hl] ; $5bfe
	ld l, a ; $5bff
	farcall InitDialogueTextCursor ; $5c00
	ld a, [$c2b0] ; $5c03
	cp a, $03 ; $5c06
	jr nz, Label_10_5c0d ; $5c08
	farcall AdvanceDialogueTextCursor ; $5c0a
Label_10_5c0d:
	script_speak $03 ; $5c0d
	ret ; $5c12
	; $5c13, 10 bytes (records:2)
	dw $0c21 ; record 0
	dw $0c44 ; record 1
	dw $0c6f ; record 2
	dw $0c99 ; record 3
	dw $0cc4 ; record 4
RestaurantNpc04_10:
	ld a, [$c2b1] ; $5c1d
	add a, a ; $5c20
	add a, $34 ; $5c21
	ld l, a ; $5c23
	adc a, $5c ; $5c24
	sub a, l ; $5c26
	ld h, a ; $5c27
	ld a, [hl+] ; $5c28
	ld h, [hl] ; $5c29
	ld l, a ; $5c2a
	farcall InitDialogueTextCursor ; $5c2b
	script_speak $04 ; $5c2e
	ret ; $5c33
	; $5c34, 10 bytes (records:2)
	dw $0c22 ; record 0
	dw $0c46 ; record 1
	dw $0c70 ; record 2
	dw $0c9a ; record 3
	dw $0cc5 ; record 4
RestaurantNpc05_10:
	script_face_toward ACTOR_PLAYER, $05 ; $5c3e
	ld a, [$c2b0] ; $5c46
	add a, a ; $5c49
	add a, $9c ; $5c4a
	ld l, a ; $5c4c
	adc a, $5c ; $5c4d
	sub a, l ; $5c4f
	ld h, a ; $5c50
	ld a, [hl+] ; $5c51
	ld h, [hl] ; $5c52
	ld l, a ; $5c53
	farcall InitDialogueTextCursor ; $5c54
	script_speak $05 ; $5c57
	script_face $05, FACE_DOWN ; $5c5c
	script_set_anim $05, $02 ; $5c63
	script_wait_idle $05 ; $5c6a
	script_speak $05 ; $5c6f
	script_face_toward ACTOR_PLAYER, $05 ; $5c74
	script_set_anim $05, $04 ; $5c7c
	script_wait_idle $05 ; $5c83
	script_speak $05 ; $5c88
	script_wait_frames $14 ; $5c8d
	script_face $05, FACE_DOWN ; $5c94
	ret ; $5c9b
	; $5c9c, 20 bytes (records:2)
	dw $0c23 ; record 0
	dw $0c23 ; record 1
	dw $0c47 ; record 2
	dw $0c47 ; record 3
	dw $0c71 ; record 4
	dw $0c74 ; record 5
	dw $0c9b ; record 6
	dw $0c9e ; record 7
	dw $0cc6 ; record 8
	dw $0cc6 ; record 9
RestaurantNpc06_10:
	script_set_anim $06, $04 ; $5cb0
	script_wait_idle $06 ; $5cb7
	ld a, [$c2b1] ; $5cbc
	add a, a ; $5cbf
	add a, $fb ; $5cc0
	ld l, a ; $5cc2
	adc a, $5c ; $5cc3
	sub a, l ; $5cc5
	ld h, a ; $5cc6
	ld a, [hl+] ; $5cc7
	ld h, [hl] ; $5cc8
	ld l, a ; $5cc9
	farcall InitDialogueTextCursor ; $5cca
	ld a, [$c2b0] ; $5ccd
	cp a, $05 ; $5cd0
	jr nz, Label_10_5cda ; $5cd2
	farcall AdvanceDialogueTextCursor ; $5cd4
	farcall AdvanceDialogueTextCursor ; $5cd7
Label_10_5cda:
	script_speak $06 ; $5cda
	ld a, [$c2b1] ; $5cdf
	cp a, $00 ; $5ce2
	jr nz, Label_10_5ce9 ; $5ce4
	call Func_10_615a ; $5ce6
Label_10_5ce9:
	script_set_anim $06, $03 ; $5ce9
	script_wait_idle $06 ; $5cf0
	script_speak $06 ; $5cf5
	ret ; $5cfa
	INCBIN "data/bank_010/d_5cfb.bin" ; $5cfb, 10 bytes
RestaurantNpc12_10:
	call Func_10_612c ; $5d05
	jp nz, Label_10_5db6 ; $5d08
	script_set_anim $12, $03 ; $5d0b
	script_wait_idle $12 ; $5d12
	ld a, [$c2b1] ; $5d17
	add a, a ; $5d1a
	add a, $dc ; $5d1b
	ld l, a ; $5d1d
	adc a, $5d ; $5d1e
	sub a, l ; $5d20
	ld h, a ; $5d21
	ld a, [hl+] ; $5d22
	ld h, [hl] ; $5d23
	ld l, a ; $5d24
	farcall InitDialogueTextCursor ; $5d25
	script_speak $12 ; $5d28
	script_face_toward ACTOR_PLAYER, $12 ; $5d2d
	script_set_position $07, $1c00, $1100 ; $5d35
	sound $97 ; $5d40
	script_set_anim $12, $02 ; $5d42
	script_wait_frames $28 ; $5d49
	script_set_position $07, $3f00, $3f00 ; $5d50
	script_speak $12 ; $5d5b
	script_face $12, FACE_DOWN ; $5d60
	script_wait_frames $14 ; $5d67
	script_facing_lock $12, $01 ; $5d6e
	script_move_angle $12, FACE_UP, $0100 ; $5d75
	call Func_10_613e ; $5d7f
	script_face_toward ACTOR_PLAYER, $12 ; $5d82
	ld a, [$c2b1] ; $5d8a
	add a, a ; $5d8d
	add a, $dc ; $5d8e
	ld l, a ; $5d90
	adc a, $5d ; $5d91
	sub a, l ; $5d93
	ld h, a ; $5d94
	ld a, [hl+] ; $5d95
	ld h, [hl] ; $5d96
	ld l, a ; $5d97
	ld a, $02 ; $5d98
	add a, l ; $5d9a
	ld l, a ; $5d9b
	jr nc, Label_10_5d9f ; $5d9c
	inc h ; $5d9e
Label_10_5d9f:
	farcall InitDialogueTextCursor ; $5d9f
	script_speak $12 ; $5da2
	script_facing_lock $12, FACE_RIGHT ; $5da7
	script_face $12, FACE_DOWN ; $5dae
	ret ; $5db5
Label_10_5db6:
	script_face_toward ACTOR_PLAYER, $12 ; $5db6
	ld a, [$c2b1] ; $5dbe
	add a, a ; $5dc1
	add a, $dc ; $5dc2
	ld l, a ; $5dc4
	adc a, $5d ; $5dc5
	sub a, l ; $5dc7
	ld h, a ; $5dc8
	ld a, [hl+] ; $5dc9
	ld h, [hl] ; $5dca
	ld l, a ; $5dcb
	ld a, $02 ; $5dcc
	add a, l ; $5dce
	ld l, a ; $5dcf
	jr nc, Label_10_5dd3 ; $5dd0
	inc h ; $5dd2
Label_10_5dd3:
	farcall InitDialogueTextCursor ; $5dd3
	script_speak $12 ; $5dd6
	ret ; $5ddb
	; $5ddc, 10 bytes (records:2)
	dw $0c28 ; record 0
	dw $0c4c ; record 1
	dw $0c7b ; record 2
	dw $0ca3 ; record 3
	dw $0ccb ; record 4
RestaurantNpc08FaceDown_10:
	set_flag $1c, 1 ; $5de6
RestaurantNpc08_10:
	test_flag $0f, 3 ; $5de9
	jr nz, Label_10_5e5c ; $5dec
	ld a, [$c2b1] ; $5dee
	add a, a ; $5df1
	add a, $81 ; $5df2
	ld l, a ; $5df4
	adc a, $5e ; $5df5
	sub a, l ; $5df7
	ld h, a ; $5df8
	ld a, [hl+] ; $5df9
	ld h, [hl] ; $5dfa
	ld l, a ; $5dfb
	farcall InitDialogueTextCursor ; $5dfc
	script_speak $08 ; $5dff
	script_set_speed $08, $0010 ; $5e04
	test_flag $1c, 1 ; $5e0c
	jr z, Label_10_5e30 ; $5e0f
	script_jump_velocity ACTOR_PLAYER, $ff80 ; $5e11
	script_move_target ACTOR_PLAYER, $1f00, $0f00 ; $5e19
	script_wait_move ACTOR_PLAYER ; $5e24
	script_face ACTOR_PLAYER, FACE_RIGHT ; $5e29
Label_10_5e30:
	script_move_target $08, $2140, $0f00 ; $5e30
	script_wait_move $08 ; $5e3b
	script_wait_frames $0a ; $5e40
	script_set_anim $08, $02 ; $5e47
	script_face $08, FACE_RIGHT ; $5e4e
	set_flag $0f, 3 ; $5e55
	clear_flag $1c, 1 ; $5e58
	ret ; $5e5b
Label_10_5e5c:
	ld a, [$c2b1] ; $5e5c
	add a, a ; $5e5f
	add a, $81 ; $5e60
	ld l, a ; $5e62
	adc a, $5e ; $5e63
	sub a, l ; $5e65
	ld h, a ; $5e66
	ld a, [hl+] ; $5e67
	ld h, [hl] ; $5e68
	ld l, a ; $5e69
	ld a, $01 ; $5e6a
	add a, l ; $5e6c
	ld l, a ; $5e6d
	jr nc, Label_10_5e71 ; $5e6e
	inc h ; $5e70
Label_10_5e71:
	farcall InitDialogueTextCursor ; $5e71
	script_speak $08 ; $5e74
	script_face $08, FACE_RIGHT ; $5e79
	ret ; $5e80
	; $5e81, 10 bytes (records:2)
	dw $0c2b ; record 0
	dw $0c4f ; record 1
	dw $0c7e ; record 2
	dw $0ca6 ; record 3
	dw $0cce ; record 4
RestaurantNpc09_10:
	ld a, [$c2b0] ; $5e8b
	add a, a ; $5e8e
	add a, $de ; $5e8f
	ld l, a ; $5e91
	adc a, $5e ; $5e92
	sub a, l ; $5e94
	ld h, a ; $5e95
	ld a, [hl+] ; $5e96
	ld h, [hl] ; $5e97
	ld l, a ; $5e98
	farcall InitDialogueTextCursor ; $5e99
	ld a, [$c2b0] ; $5e9c
	cp a, $06 ; $5e9f
	jr nc, Label_10_5ea9 ; $5ea1
	script_speak $09 ; $5ea3
	ret ; $5ea8
Label_10_5ea9:
	ld a, $09 ; $5ea9
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5eab
	farcall RunDialogueYesNoPrompt ; $5eae
	farcall ScriptCloseDialogueWindow ; $5eb1
	script_wait_frames $05 ; $5eb4
	and a, a ; $5ebb
	jr nz, Label_10_5ed2 ; $5ebc
	script_set_text Text_33_169 ; $5ebe
	test_flag $05, 7 ; $5ec4
	jr z, Label_10_5ecc ; $5ec7
	farcall AdvanceDialogueTextCursor ; $5ec9
Label_10_5ecc:
	script_speak $09 ; $5ecc
	ret ; $5ed1
Label_10_5ed2:
	script_set_text Text_33_171 ; $5ed2
	script_speak $09 ; $5ed8
	ret ; $5edd
	; $5ede, 20 bytes (records:2)
	dw $0c2d ; record 0
	dw $0c2d ; record 1
	dw $0c51 ; record 2
	dw $0c52 ; record 3
	dw $0c80 ; record 4
	dw $0c81 ; record 5
	dw $0ca8 ; record 6
	dw $0ca8 ; record 7
	dw $0cd0 ; record 8
	dw $0cd0 ; record 9
RestaurantNpc0A_10:
	script_face_toward ACTOR_PLAYER, $0a ; $5ef2
	ld a, [$c2b0] ; $5efa
	add a, a ; $5efd
	add a, $30 ; $5efe
	ld l, a ; $5f00
	adc a, $5f ; $5f01
	sub a, l ; $5f03
	ld h, a ; $5f04
	ld a, [hl+] ; $5f05
	ld h, [hl] ; $5f06
	ld l, a ; $5f07
	farcall InitDialogueTextCursor ; $5f08
	ld a, [$c2b0] ; $5f0b
	cp a, $06 ; $5f0e
	jr nc, Label_10_5f2a ; $5f10
	ld a, $0a ; $5f12
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5f14
	farcall RunDialogueYesNoPrompt ; $5f17
	farcall ScriptCloseDialogueWindow ; $5f1a
	script_wait_frames $05 ; $5f1d
	and a, a ; $5f24
	jr z, Label_10_5f2a ; $5f25
	farcall AdvanceDialogueTextCursor ; $5f27
Label_10_5f2a:
	script_speak $0a ; $5f2a
	ret ; $5f2f
	; $5f30, 20 bytes (records:2)
	dw $0c2e ; record 0
	dw $0c31 ; record 1
	dw $0c53 ; record 2
	dw $0c56 ; record 3
	dw $0c82 ; record 4
	dw $0c82 ; record 5
	dw $0cac ; record 6
	dw $0cac ; record 7
	dw $0cd1 ; record 8
	dw $0cd1 ; record 9
RestaurantNpc0B_10:
	ld a, [$c2b1] ; $5f44
	add a, a ; $5f47
	add a, $65 ; $5f48
	ld l, a ; $5f4a
	adc a, $5f ; $5f4b
	sub a, l ; $5f4d
	ld h, a ; $5f4e
	ld a, [hl+] ; $5f4f
	ld h, [hl] ; $5f50
	ld l, a ; $5f51
	farcall InitDialogueTextCursor ; $5f52
	ld a, [$c2b0] ; $5f55
	cp a, $01 ; $5f58
	jr nz, Label_10_5f5f ; $5f5a
	farcall AdvanceDialogueTextCursor ; $5f5c
Label_10_5f5f:
	script_speak $0b ; $5f5f
	ret ; $5f64
	; $5f65, 10 bytes (records:2)
	dw $0c34 ; record 0
	dw $0c59 ; record 1
	dw $0c85 ; record 2
	dw $0cad ; record 3
	dw $0cd2 ; record 4
RestaurantNpc0C_10:
	ld a, [$c2b1] ; $5f6f
	add a, a ; $5f72
	add a, $bf ; $5f73
	ld l, a ; $5f75
	adc a, $5f ; $5f76
	sub a, l ; $5f78
	ld h, a ; $5f79
	ld a, [hl+] ; $5f7a
	ld h, [hl] ; $5f7b
	ld l, a ; $5f7c
	farcall InitDialogueTextCursor ; $5f7d
	ld a, [$c2b1] ; $5f80
	cp a, $00 ; $5f83
	jr z, Label_10_5fb9 ; $5f85
	cp a, $03 ; $5f87
	jr nc, Label_10_5faf ; $5f89
	ld a, $0c ; $5f8b
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5f8d
	farcall RunDialogueYesNoPrompt ; $5f90
	farcall ScriptCloseDialogueWindow ; $5f93
	script_wait_frames $05 ; $5f96
	and a, a ; $5f9d
	jr z, Label_10_5fb9 ; $5f9e
	farcall AdvanceDialogueTextCursor ; $5fa0
	ld a, [$c2b0] ; $5fa3
	cp a, $05 ; $5fa6
	jr nz, Label_10_5fb9 ; $5fa8
	farcall AdvanceDialogueTextCursor ; $5faa
	jr Label_10_5fb9 ; $5fad
Label_10_5faf:
	ld a, [$c2b0] ; $5faf
	and a, $01 ; $5fb2
	jr z, Label_10_5fb9 ; $5fb4
	farcall AdvanceDialogueTextCursor ; $5fb6
Label_10_5fb9:
	script_speak $0c ; $5fb9
	ret ; $5fbe
	; $5fbf, 10 bytes (records:2)
	dw $0c36 ; record 0
	dw $0c5a ; record 1
	dw $0c86 ; record 2
	dw $0cae ; record 3
	dw $0cd3 ; record 4
RestaurantNpc0D_10:
	ld a, [$c2b1] ; $5fc9
	add a, a ; $5fcc
	add a, $09 ; $5fcd
	ld l, a ; $5fcf
	adc a, $60 ; $5fd0
	sub a, l ; $5fd2
	ld h, a ; $5fd3
	ld a, [hl+] ; $5fd4
	ld h, [hl] ; $5fd5
	ld l, a ; $5fd6
	farcall InitDialogueTextCursor ; $5fd7
	ld a, [$c2b1] ; $5fda
	cp a, $03 ; $5fdd
	jr nz, Label_10_5ff9 ; $5fdf
	ld a, $0d ; $5fe1
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5fe3
	farcall RunDialogueYesNoPrompt ; $5fe6
	farcall ScriptCloseDialogueWindow ; $5fe9
	script_wait_frames $05 ; $5fec
	and a, a ; $5ff3
	jr z, Label_10_5ff9 ; $5ff4
	farcall AdvanceDialogueTextCursor ; $5ff6
Label_10_5ff9:
	ld a, [$c2b0] ; $5ff9
	cp a, $03 ; $5ffc
	jr nz, Label_10_6003 ; $5ffe
	farcall AdvanceDialogueTextCursor ; $6000
Label_10_6003:
	script_speak $0d ; $6003
	ret ; $6008
	; $6009, 10 bytes (records:2)
	dw $0c37 ; record 0
	dw $0c5d ; record 1
	dw $0c8a ; record 2
	dw $0cb0 ; record 3
	dw $0cd5 ; record 4
RestaurantNpc0E_10:
	ld a, [$c2b1] ; $6013
	add a, a ; $6016
	add a, $2a ; $6017
	ld l, a ; $6019
	adc a, $60 ; $601a
	sub a, l ; $601c
	ld h, a ; $601d
	ld a, [hl+] ; $601e
	ld h, [hl] ; $601f
	ld l, a ; $6020
	farcall InitDialogueTextCursor ; $6021
	script_speak $0e ; $6024
	ret ; $6029
	; $602a, 10 bytes (records:2)
	dw $0c38 ; record 0
	dw $0c5f ; record 1
	dw $0c8b ; record 2
	dw $0cb3 ; record 3
	dw $0cd6 ; record 4
RestaurantNpc0F_10:
	ld a, [$c2b1] ; $6034
	add a, a ; $6037
	add a, $4b ; $6038
	ld l, a ; $603a
	adc a, $60 ; $603b
	sub a, l ; $603d
	ld h, a ; $603e
	ld a, [hl+] ; $603f
	ld h, [hl] ; $6040
	ld l, a ; $6041
	farcall InitDialogueTextCursor ; $6042
	script_speak $0f ; $6045
	ret ; $604a
	; $604b, 10 bytes (records:2)
	dw $0c39 ; record 0
	dw $0c60 ; record 1
	dw $0c8c ; record 2
	dw $0cb4 ; record 3
	dw $0cd7 ; record 4
RestaurantNpc10_10:
	ld a, [$c2b1] ; $6055
	add a, a ; $6058
	add a, $6c ; $6059
	ld l, a ; $605b
	adc a, $60 ; $605c
	sub a, l ; $605e
	ld h, a ; $605f
	ld a, [hl+] ; $6060
	ld h, [hl] ; $6061
	ld l, a ; $6062
	farcall InitDialogueTextCursor ; $6063
	script_speak $10 ; $6066
	ret ; $606b
	; $606c, 10 bytes (records:2)
	dw $0c3a ; record 0
	dw $0c61 ; record 1
	dw $0c8e ; record 2
	dw $0cb6 ; record 3
	dw $0cd9 ; record 4
RestaurantNpcScripts_10:
	; $6076, 121 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, RestaurantNpc03_10, $03, $00
	map_script $04, FACEMASK_ANY, $0000, RestaurantNpc04_10, $03, $00
	map_script $05, FACEMASK_ANY, $0000, RestaurantNpc05_10, $03, $00
	map_script $06, FACEMASK_ANY, $0000, RestaurantNpc06_10, $03, $00
	map_script $12, FACEMASK_ANY, $0000, RestaurantNpc12_10, $00, $00
	map_script $08, FACEMASK_DOWN, $0000, RestaurantNpc08FaceDown_10, $03, $00
	map_script $08, FACEMASK_ANY, $0000, RestaurantNpc08_10, $03, $00
	map_script $09, FACEMASK_ANY, $0000, RestaurantNpc09_10, $03, $00
	map_script $0a, FACEMASK_ANY, $0000, RestaurantNpc0A_10, $13, $00
	map_script $0b, FACEMASK_ANY, $0000, RestaurantNpc0B_10, $03, $00
	map_script $0c, FACEMASK_ANY, $0000, RestaurantNpc0C_10, $03, $00
	map_script $0d, FACEMASK_ANY, $0000, RestaurantNpc0D_10, $03, $00
	map_script $0e, FACEMASK_ANY, $0000, RestaurantNpc0E_10, $13, $00
	map_script $0f, FACEMASK_ANY, $0000, RestaurantNpc0F_10, $03, $00
	map_script $10, FACEMASK_ANY, $0000, RestaurantNpc10_10, $03, $00
	db $ff
RestaurantFacingScripts_10:
	ds 1, $ff ; $60ef, fill
RestaurantTileTriggers_10:
	ds 1, $ff ; $60f0, fill
RestaurantInitScript_10:
	call Func_10_7dbd ; $60f1
	ld a, [$c2b0] ; $60f4
	sra a ; $60f7
	ld [$c2b1], a ; $60f9
	call Func_10_611b ; $60fc
	call Func_10_6103 ; $60ff
	ret ; $6102
Func_10_6103:
	test_flag $0f, 3 ; $6103
	jr z, Label_10_611a ; $6106
	script_set_position $08, $2140, $0f00 ; $6108
	script_face $08, FACE_RIGHT ; $6113
Label_10_611a:
	ret ; $611a
Func_10_611b:
	call Func_10_612c ; $611b
	jr z, Label_10_612b ; $611e
	script_set_position $12, $1b00, $1100 ; $6120
Label_10_612b:
	ret ; $612b
Func_10_612c:
	ld a, [$c2b1] ; $612c
	add a, a ; $612f
	add a, $50 ; $6130
	ld l, a ; $6132
	adc a, $61 ; $6133
	sub a, l ; $6135
	ld h, a ; $6136
	ld a, [hl+] ; $6137
	ld d, [hl] ; $6138
	ld e, a ; $6139
	call TestGameFlagByNumber ; $613a
	ret ; $613d
Func_10_613e:
	ld a, [$c2b1] ; $613e
	add a, a ; $6141
	add a, $50 ; $6142
	ld l, a ; $6144
	adc a, $61 ; $6145
	sub a, l ; $6147
	ld h, a ; $6148
	ld a, [hl+] ; $6149
	ld d, [hl] ; $614a
	ld e, a ; $614b
	call SetGameFlagByNumber ; $614c
	ret ; $614f
	ld [hl], b ; $6150
	nop ; $6151
	ld [hl], c ; $6152
	nop ; $6153
	ld [hl], d ; $6154
	nop ; $6155
	ld [hl], e ; $6156
	nop ; $6157
	ld a, d ; $6158
	nop ; $6159
Func_10_615a:
	wram_bank $04 ; $615a
	script_get_actor_state ACTOR_PLAYER ; $6160
	ld c, l ; $6165
	ld b, h ; $6166
	ld hl, $000c ; $6167
	add hl, bc ; $616a
	ld a, [hl+] ; $616b
	ld h, [hl] ; $616c
	ld l, a ; $616d
	ld de, $0180 ; $616e
	add hl, de ; $6171
	ld e, l ; $6172
	ld d, h ; $6173
	ld hl, $c2b8 ; $6174
	ld a, e ; $6177
	ld [hl+], a ; $6178
	ld [hl], d ; $6179
	ld hl, $000e ; $617a
	add hl, bc ; $617d
	ld a, [hl+] ; $617e
	ld h, [hl] ; $617f
	ld l, a ; $6180
	ld de, $fe80 ; $6181
	add hl, de ; $6184
	ld e, l ; $6185
	ld d, h ; $6186
	ld hl, wWaterSpriteMinigameFlag ; $6187
	ld a, e ; $618a
	ld [hl+], a ; $618b
	ld [hl], d ; $618c
	ld hl, $c2b8 ; $618d
	ld a, [hl+] ; $6190
	ld b, [hl] ; $6191
	ld c, a ; $6192
	ld hl, wWaterSpriteMinigameFlag ; $6193
	ld a, [hl+] ; $6196
	ld d, [hl] ; $6197
	ld e, a ; $6198
	ld a, $11 ; $6199
	farcall ScriptSetActorPosition ; $619b
	script_wait_frames $46 ; $619e
	script_set_position $11, $3f00, $3f00 ; $61a5
	ret ; $61b0
AcademyWingMapScripts_10:
	; $61b1, 14 bytes (map_tree)
	dw AcademyWingEntryPoints_10 ; slot 0 EntryPoints
	dw AcademyWingExitTriggers_10 ; slot 1 ExitTriggers
	dw AcademyWingActors_10 ; slot 2 Actors
	dw AcademyWingNpcScripts_10 ; slot 3 NpcScripts
	dw AcademyWingFacingScripts_10 ; slot 4 FacingScripts
	dw AcademyWingTileTriggers_10 ; slot 5 TileTriggers
	dw AcademyWingInitScript_10 ; slot 6 InitScript
AcademyWingActors_10:
	; $61bf, 66 bytes (map_actors)
	map_actor $0000, ActorScript_10_7bd1, $3f00, $1900, FACE_RIGHT, $63, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $1900, $3f00, FACE_RIGHT, $36, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $2700, $3240, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $2700, $30c0, FACE_DOWN, $74, $01, $00
	map_actor_end
AcademyWingEntryPoints_10:
	; $6201, 17 bytes (map_entries)
	map_entry $01, FACE_DOWN, $3b00, $3900, MapArrivalWalkPair_10
	map_entry $0f, FACE_UP, $2000, $3400, MapScriptNop_10
	db $ff
AcademyWingExitTriggers_10:
	; $6212, 41 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_10, $14, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_10, $07, $03
	map_script $03, FACEMASK_ANY, $0000, Func_10_7ae6, $05, $04
	map_script $04, FACEMASK_ANY, $0000, Func_10_7b1f, $05, $03
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_10, $07, $0f
	db $ff
AcademyWingNpc03_10:
	script_face_toward ACTOR_PLAYER, $03 ; $623b
	test_flag $1c, 0 ; $6243
	jr z, Label_10_6250 ; $6246
	script_set_text Text_30_517 ; $6248
	jr Label_10_62b0 ; $624e
Label_10_6250:
	script_get_actor_state $06 ; $6250
	ld c, l ; $6255
	ld b, h ; $6256
	ld hl, $0037 ; $6257
	add hl, bc ; $625a
	ld a, [hl] ; $625b
	or a, $20 ; $625c
	ld [hl], a ; $625e
	script_set_position $06, $1b80, $2e00 ; $625f
	sound $97 ; $626a
	script_wait_frames $3c ; $626c
	script_set_position $06, $0100, $0100 ; $6273
	script_set_text Text_30_513 ; $627e
	test_flag $05, 7 ; $6284
	jr z, Label_10_628c ; $6287
	farcall AdvanceDialogueTextCursor ; $6289
Label_10_628c:
	ld a, $03 ; $628c
	farcall ScriptShowSpeakerDialogueRestoreBG ; $628e
	script_set_text Text_30_515 ; $6291
	farcall RunDialogueYesNoPrompt ; $6297
	farcall ScriptCloseDialogueWindow ; $629a
	script_wait_frames $05 ; $629d
	and a, a ; $62a4
	jr nz, Label_10_62b0 ; $62a5
	script_set_text Text_30_516 ; $62a7
	set_flag $1c, 0 ; $62ad
Label_10_62b0:
	script_speak $03 ; $62b0
	ret ; $62b5
AcademyWingNpcScripts_10:
	; $62b6, 9 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, AcademyWingNpc03_10, $01, $00
	db $ff
AcademyWingFacingScripts_10:
	; $62bf, 17 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, AcademyWingFacing01_10, $00, $00
	map_script $02, FACEMASK_ANY, $0000, AcademyWingFacing02_10, $00, $00
	db $ff
AcademyWingFacing02_10:
	ld a, [$c2b0] ; $62d0
	cp a, $01 ; $62d3
	jr nz, AcademyWingFacing01_10 ; $62d5
	farcall BeginCutsceneScriptMode ; $62d7
	script_player_speed $0020 ; $62da
	script_move_player $2100, $3300 ; $62e0
	script_set_text Text_30_449 ; $62ea
	script_face $03, FACE_DOWN ; $62f0
	script_wait_frames $0a ; $62f7
	script_speak $04 ; $62fe
	script_wait_frames $0a ; $6303
	script_set_anim ACTOR_PARTNER, $02 ; $630a
	script_set_anim ACTOR_PLAYER, $02 ; $6311
	script_wait_idle ACTOR_PLAYER ; $6318
	script_set_anim $03, $04 ; $631d
	script_wait_idle $03 ; $6324
	script_player_speed $0018 ; $6329
	script_speak $04 ; $632f
	script_face $03, FACE_RIGHT ; $6334
	script_move_player $2100, $3b00 ; $633b
	script_set_anim ACTOR_PLAYER, $02 ; $6345
	script_wait_idle ACTOR_PLAYER ; $634c
	farcall EndCutsceneScriptMode ; $6351
	ret ; $6354
AcademyWingFacing01_10:
	script_set_text Text_30_451 ; $6355
	script_speak ACTOR_PLAYER ; $635b
	ret ; $6360
AcademyWingTileTriggers_10:
	; $6361, 17 bytes (map_scripts)
	map_script $01, FACEMASK_UP, $0000, AcademyWingTile01_10, $00, $00
	map_script $02, FACEMASK_DOWN, $0000, AcademyWingTile02_10, $00, $00
	db $ff
AcademyWingTile01_10:
	script_set_speed ACTOR_PLAYER, $0014 ; $6372
	script_face ACTOR_PLAYER, FACE_UP ; $637a
	call Func_10_7339 ; $6381
	test_flag $05, 7 ; $6384
	jr z, Label_10_6399 ; $6387
	script_move_target ACTOR_PARTNER, $2100, $3d00 ; $6389
	script_wait_move ACTOR_PARTNER ; $6394
Label_10_6399:
	script_move_target ACTOR_PLAYER, $2100, $3900 ; $6399
	script_wait_move ACTOR_PLAYER ; $63a4
	script_wait_frames $02 ; $63a9
	script_move_angle ACTOR_PLAYER, FACE_UP, $0200 ; $63b0
	script_wait_move ACTOR_PLAYER ; $63ba
	script_move_angle ACTOR_PLAYER, FACE_LEFT, $0200 ; $63bf
	script_wait_move ACTOR_PLAYER ; $63c9
	script_wait_frames $0a ; $63ce
	script_face ACTOR_PLAYER, FACE_UP ; $63d5
	call Func_10_736f ; $63dc
	ret ; $63df
AcademyWingTile02_10:
	script_face ACTOR_PLAYER, FACE_DOWN ; $63e0
	script_set_speed ACTOR_PLAYER, $0010 ; $63e7
	call Func_10_7339 ; $63ef
	script_move_target ACTOR_PARTNER, $2100, $3500 ; $63f2
	test_flag $05, 7 ; $63fd
	jr z, Label_10_6402 ; $6400
Label_10_6402:
	script_move_target ACTOR_PLAYER, $2100, $3900 ; $6402
	script_wait_move ACTOR_PLAYER ; $640d
	script_move_angle ACTOR_PLAYER, FACE_DOWN, $0200 ; $6412
	script_wait_move ACTOR_PLAYER ; $641c
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $0200 ; $6421
	script_wait_move ACTOR_PLAYER ; $642b
	script_wait_frames $05 ; $6430
	call Func_10_736f ; $6437
	ret ; $643a
AcademyWingInitScript_10:
	script_set_anim $05, $06 ; $643b
	test_flag $07, 4 ; $6442
	jr nz, Label_10_6452 ; $6445
	script_set_position $05, $0100, $0100 ; $6447
Label_10_6452:
	test_flag $06, 5 ; $6452
	jr nz, Label_10_6462 ; $6455
	script_set_position $06, $0100, $0100 ; $6457
Label_10_6462:
	call Func_10_7472 ; $6462
	ld a, [$c2b0] ; $6465
	cp a, $03 ; $6468
	jr nz, Label_10_649e ; $646a
	ldh a, [hRomBank] ; $646c
	ld hl, $739e ; $646e
	farcall ScriptRespawnLocationActors ; $6471
	farcall BeginCutsceneScriptMode ; $6474
	ld b, $1e ; $6477
	ld c, $38 ; $6479
	ld d, $20 ; $647b
	ld e, $38 ; $647d
	ld h, $02 ; $647f
	ld l, $02 ; $6481
	farcall CopyBehaviorMapRect ; $6483
	call MapArrivalWalkPair_10 ; $6486
	call Func_10_7443 ; $6489
	script_set_position $03, $1d00, $3000 ; $648c
	script_face $03, FACE_UP ; $6497
Label_10_649e:
	ld a, [$c2b0] ; $649e
	cp a, $01 ; $64a1
	jr nz, Label_10_64b0 ; $64a3
	script_set_position $03, $19a0, $32c0 ; $64a5
Label_10_64b0:
	ld a, $16 ; $64b0
	ld [$c329], a ; $64b2
	ld a, $28 ; $64b5
	ld [$c32a], a ; $64b7
	ld a, $40 ; $64ba
	ld [$c32b], a ; $64bc
	ld a, $3e ; $64bf
	ld [$c32c], a ; $64c1
	call DisableLCDSafely ; $64c4
	ld a, $00 ; $64c7
	farcall CopyScrolledSceneTilemapToVram ; $64c9
	call EnableLCD ; $64cc
	ld a, [wStoryModeEntryPoint] ; $64cf
	cp a, $0d ; $64d2
	jp z, Label_10_64e0 ; $64d4
	cp a, $0f ; $64d7
	jp z, Label_10_6fcd ; $64d9
	call Func_10_7429 ; $64dc
	ret ; $64df
Label_10_64e0:
	ldh a, [hRomBank] ; $64e0
	ld hl, $6f45 ; $64e2
	farcall ScriptRespawnLocationActors ; $64e5
	farcall BeginCutsceneScriptMode ; $64e8
	script_set_anim $0a, $06 ; $64eb
	test_flag $07, 4 ; $64f2
	jr nz, Label_10_6502 ; $64f5
	script_set_position $0a, $0100, $0100 ; $64f7
Label_10_6502:
	test_flag $06, 5 ; $6502
	jr nz, Label_10_6512 ; $6505
	script_set_position $0b, $0100, $0100 ; $6507
Label_10_6512:
	script_player_speed $00f0 ; $6512
	script_move_player $1f00, $3b00 ; $6518
	farcall WaitPlayerMoveDone ; $6522
	script_set_position ACTOR_PLAYER, $3500, $3b00 ; $6525
	xor a, a ; $6530
	ld [wStoryModeShowLocationName], a ; $6531
	script_set_position ACTOR_PLAYER, $2b00, $3b00 ; $6534
	script_fade_in $08 ; $653f
	call WaitFadeEnd ; $6544
	script_wait_frames $3c ; $6547
	script_set_anim $06, $02 ; $654e
	script_wait_idle $06 ; $6555
	script_set_text Text_30_475 ; $655a
	script_speak $06 ; $6560
	script_set_anim $07, $02 ; $6565
	script_set_anim $08, $02 ; $656c
	script_set_anim $09, $02 ; $6573
	script_wait_idle $09 ; $657a
	script_face_pair $07, $08 ; $657f
	script_wait_frames $28 ; $6587
	script_face $07, FACE_UP ; $658e
	script_face $08, FACE_UP ; $6595
	script_wait_frames $28 ; $659c
	script_set_position $05, $2380, $3100 ; $65a3
	sound $97 ; $65ae
	script_speak $07 ; $65b0
	script_set_position $05, $3f00, $3f00 ; $65b5
	script_set_anim $06, $03 ; $65c0
	script_wait_idle $06 ; $65c7
	script_speak $06 ; $65cc
	test_flag $05, 7 ; $65d1
	jp z, Label_10_66a2 ; $65d4
	script_set_position $03, $2180, $3100 ; $65d7
	sound $99 ; $65e2
	script_wait_frames $0a ; $65e4
	farcall AdvanceDialogueTextCursor ; $65eb
	script_speak $08 ; $65ee
	script_set_position $03, $3f00, $3f00 ; $65f3
	script_face_toward $08, $07 ; $65fe
	script_wait_frames $01 ; $6606
	script_facing_lock $07, $01 ; $660d
	script_move_target $07, $2100, $3300 ; $6614
	script_wait_move $07 ; $661f
	script_set_anim $08, $02 ; $6624
	script_move_target $07, $2200, $3300 ; $662b
	script_wait_move $07 ; $6636
	script_facing_lock $07, FACE_RIGHT ; $663b
	script_face_pair $08, $07 ; $6642
	script_speak $07 ; $664a
	script_face_toward $08, $09 ; $664f
	script_wait_frames $01 ; $6657
	script_facing_lock $09, $01 ; $665e
	script_move_target $09, $1f00, $3300 ; $6665
	script_wait_move $09 ; $6670
	script_set_anim $08, $02 ; $6675
	script_move_target $09, $1e00, $3300 ; $667c
	script_wait_move $09 ; $6687
	script_facing_lock $09, FACE_RIGHT ; $668c
	script_face_pair $08, $09 ; $6693
	script_speak $09 ; $669b
	jr Label_10_66c6 ; $66a0
Label_10_66a2:
	script_set_position $05, $2180, $3100 ; $66a2
	sound $97 ; $66ad
	script_wait_frames $1e ; $66af
	script_speak $08 ; $66b6
	script_set_position $05, $3f00, $3f00 ; $66bb
Label_10_66c6:
	script_face_toward $08, $07 ; $66c6
	script_wait_frames $01 ; $66ce
	script_facing_lock $07, $01 ; $66d5
	script_move_target $07, $2100, $3300 ; $66dc
	script_wait_move $07 ; $66e7
	script_move_target $07, $2200, $3300 ; $66ec
	script_wait_move $07 ; $66f7
	script_facing_lock $07, FACE_RIGHT ; $66fc
	script_face_pair $08, $07 ; $6703
	script_set_anim $08, $02 ; $670b
	script_wait_idle $08 ; $6712
	script_face_toward $08, $09 ; $6717
	script_wait_frames $01 ; $671f
	script_facing_lock $09, $01 ; $6726
	script_move_target $09, $1f00, $3300 ; $672d
	script_wait_move $09 ; $6738
	script_move_target $09, $1e00, $3300 ; $673d
	script_wait_move $09 ; $6748
	script_facing_lock $09, FACE_RIGHT ; $674d
	script_face_pair $08, $09 ; $6754
	script_set_anim $08, $02 ; $675c
	script_wait_idle $08 ; $6763
	script_set_anim $09, $03 ; $6768
	script_set_anim $07, $03 ; $676f
	script_wait_idle $07 ; $6776
	script_move_target $06, $1e00, $2f00 ; $677b
	script_wait_move $06 ; $6786
	script_face $06, FACE_DOWN ; $678b
	script_wait_frames $1e ; $6792
	script_move_target $06, $2200, $2f00 ; $6799
	script_wait_move $06 ; $67a4
	script_face $06, FACE_DOWN ; $67a9
	script_wait_frames $1e ; $67b0
	script_move_target $06, $2000, $2f00 ; $67b7
	script_wait_move $06 ; $67c2
	script_face $06, FACE_DOWN ; $67c7
	script_wait_frames $0a ; $67ce
	script_set_anim $06, $02 ; $67d5
	script_wait_idle $06 ; $67dc
	script_face $07, FACE_UP ; $67e1
	script_face $08, FACE_UP ; $67e8
	script_face $09, FACE_UP ; $67ef
	script_set_text Text_30_482 ; $67f6
	script_speak $06 ; $67fc
	script_set_objdef $53, $03 ; $6801
	script_set_anim $03, $01 ; $680d
	script_set_objdef $53, $05 ; $6814
	script_set_anim $05, $01 ; $6820
	script_set_position $03, $1f80, $3100 ; $6827
	sound $96 ; $6832
	script_wait_frames $28 ; $6834
	script_set_position $04, $2180, $3100 ; $683b
	sound $96 ; $6846
	script_wait_frames $28 ; $6848
	script_set_position $03, $3f00, $3f00 ; $684f
	script_set_position $05, $2380, $3100 ; $685a
	sound $96 ; $6865
	script_wait_frames $28 ; $6867
	script_set_position $04, $3f00, $3f00 ; $686e
	script_wait_frames $28 ; $6879
	script_set_position $05, $3f00, $3f00 ; $6880
	script_face $07, FACE_DOWN ; $688b
	script_face $08, FACE_DOWN ; $6892
	script_face $09, FACE_DOWN ; $6899
	script_wait_frames $78 ; $68a0
	script_face $07, FACE_UP ; $68a7
	script_face $08, FACE_UP ; $68ae
	script_face $09, FACE_UP ; $68b5
	script_wait_frames $28 ; $68bc
	script_face_toward $07, $08 ; $68c3
	script_wait_frames $01 ; $68cb
	script_set_anim $08, $02 ; $68d2
	script_wait_idle $08 ; $68d9
	script_set_position $05, $2380, $3100 ; $68de
	sound $96 ; $68e9
	script_wait_frames $3c ; $68eb
	script_face_toward $09, $08 ; $68f2
	script_wait_frames $01 ; $68fa
	script_set_anim $08, $02 ; $6901
	script_wait_idle $08 ; $6908
	script_set_position $03, $1f80, $3100 ; $690d
	sound $96 ; $6918
	script_wait_frames $3c ; $691a
	test_flag $05, 7 ; $6921
	jp z, Label_10_69c0 ; $6924
	script_null_script ACTOR_PARTNER ; $6927
	script_set_position ACTOR_PARTNER, $2d00, $3b00 ; $692c
	script_move_target ACTOR_PLAYER, $2100, $3b00 ; $6937
	script_move_target ACTOR_PARTNER, $2300, $3b00 ; $6942
	script_wait_move ACTOR_PARTNER ; $694d
	script_wait_frames $05 ; $6952
	script_face ACTOR_PLAYER, FACE_UP ; $6959
	call Func_10_7339 ; $6960
	script_move_target ACTOR_PLAYER, $2100, $3500 ; $6963
	script_move_target ACTOR_PARTNER, $2100, $3b00 ; $696e
	script_wait_move ACTOR_PARTNER ; $6979
	script_move_target ACTOR_PLAYER, $1f00, $3500 ; $697e
	script_move_target ACTOR_PARTNER, $2100, $3500 ; $6989
	script_wait_move ACTOR_PARTNER ; $6994
	script_move_target ACTOR_PARTNER, $2100, $3500 ; $6999
	script_wait_move ACTOR_PARTNER ; $69a4
	script_face ACTOR_PLAYER, FACE_UP ; $69a9
	script_face ACTOR_PARTNER, FACE_UP ; $69b0
	script_wait_frames $01 ; $69b7
	jr Label_10_6a08 ; $69be
Label_10_69c0:
	script_move_target ACTOR_PLAYER, $2100, $3b00 ; $69c0
	script_wait_move ACTOR_PLAYER ; $69cb
	script_face ACTOR_PLAYER, FACE_UP ; $69d0
	call Func_10_7339 ; $69d7
	script_move_target ACTOR_PLAYER, $2100, $3500 ; $69da
	script_wait_move ACTOR_PLAYER ; $69e5
	script_move_target ACTOR_PLAYER, $2000, $3500 ; $69ea
	script_wait_move ACTOR_PLAYER ; $69f5
	script_face ACTOR_PLAYER, FACE_UP ; $69fa
	script_wait_frames $01 ; $6a01
Label_10_6a08:
	call Func_10_736f ; $6a08
	script_set_position $03, $3f00, $3f00 ; $6a0b
	script_set_position $05, $3f00, $3f00 ; $6a16
	script_wait_frames $0a ; $6a21
	script_face $07, FACE_DOWN ; $6a28
	script_face $08, FACE_DOWN ; $6a2f
	script_face $09, FACE_DOWN ; $6a36
	script_wait_frames $01 ; $6a3d
	script_set_anim $06, $02 ; $6a44
	script_set_anim $07, $02 ; $6a4b
	script_set_anim $08, $02 ; $6a52
	script_set_anim $09, $02 ; $6a59
	script_wait_idle $09 ; $6a60
	script_wait_frames $1e ; $6a65
	script_move_target $08, $2300, $3300 ; $6a6c
	script_move_target $07, $2500, $3300 ; $6a77
	script_move_target $09, $1d00, $3500 ; $6a82
	script_wait_move $09 ; $6a8d
	script_face $09, FACE_RIGHT ; $6a92
	script_move_target $08, $2300, $3500 ; $6a99
	script_move_target $07, $2500, $3500 ; $6aa4
	script_wait_move $07 ; $6aaf
	script_face $08, FACE_LEFT ; $6ab4
	script_face $07, FACE_LEFT ; $6abb
	script_wait_frames $0a ; $6ac2
	test_flag $05, 7 ; $6ac9
	jp z, Label_10_6b73 ; $6acc
	script_wait_frames $3c ; $6acf
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $6ad6
	script_set_anim ACTOR_PLAYER, $02 ; $6ade
	script_wait_idle ACTOR_PLAYER ; $6ae5
	script_wait_frames $14 ; $6aea
	script_face_toward ACTOR_PLAYER, ACTOR_PARTNER ; $6af1
	script_wait_frames $01 ; $6af9
	script_set_anim ACTOR_PARTNER, $03 ; $6b00
	script_wait_idle ACTOR_PARTNER ; $6b07
	script_wait_frames $14 ; $6b0c
	script_face ACTOR_PLAYER, FACE_UP ; $6b13
	script_face ACTOR_PARTNER, FACE_UP ; $6b1a
	script_set_anim $07, $03 ; $6b21
	script_set_anim $08, $03 ; $6b28
	script_set_anim $09, $03 ; $6b2f
	script_wait_idle $09 ; $6b36
	script_wait_frames $28 ; $6b3b
	script_set_anim ACTOR_PLAYER, $03 ; $6b42
	script_set_anim ACTOR_PARTNER, $03 ; $6b49
	script_wait_idle ACTOR_PARTNER ; $6b50
	script_move_target ACTOR_PLAYER, $1f00, $3200 ; $6b55
	script_move_target ACTOR_PARTNER, $2100, $3200 ; $6b60
	script_wait_move ACTOR_PARTNER ; $6b6b
	jp Label_10_6c02 ; $6b70
Label_10_6b73:
	script_set_position $04, $2180, $3300 ; $6b73
	sound $96 ; $6b7e
	script_wait_frames $50 ; $6b80
	script_set_position $04, $3f00, $3f00 ; $6b87
	script_face_toward $09, ACTOR_PLAYER ; $6b92
	script_wait_frames $28 ; $6b9a
	script_face_toward ACTOR_PLAYER, $09 ; $6ba1
	script_wait_frames $01 ; $6ba9
	script_set_anim $09, $03 ; $6bb0
	script_wait_idle $09 ; $6bb7
	script_wait_frames $14 ; $6bbc
	script_face ACTOR_PLAYER, FACE_UP ; $6bc3
	script_set_anim $07, $03 ; $6bca
	script_set_anim $08, $03 ; $6bd1
	script_set_anim $09, $03 ; $6bd8
	script_wait_idle $09 ; $6bdf
	script_wait_frames $28 ; $6be4
	script_set_anim ACTOR_PLAYER, $03 ; $6beb
	script_move_target ACTOR_PLAYER, $2000, $3200 ; $6bf2
	script_wait_move ACTOR_PLAYER ; $6bfd
Label_10_6c02:
	script_wait_frames $01 ; $6c02
	script_move_target $09, $1e00, $3500 ; $6c09
	script_move_target $08, $2000, $3500 ; $6c14
	script_move_target $07, $2200, $3500 ; $6c1f
	script_wait_move $07 ; $6c2a
	script_face $09, FACE_UP ; $6c2f
	script_face $08, FACE_UP ; $6c36
	script_face $07, FACE_UP ; $6c3d
	script_set_anim $06, $03 ; $6c44
	script_wait_idle $06 ; $6c4b
	ld h, $00 ; $6c50
	ld l, $02 ; $6c52
	test_flag $15, 6 ; $6c54
	jr z, Label_10_6c5a ; $6c57
	inc l ; $6c59
Label_10_6c5a:
	test_flag $15, 7 ; $6c5a
	jr z, Label_10_6c60 ; $6c5d
	inc l ; $6c5f
Label_10_6c60:
	farcall PushTextArgNumber ; $6c60
	script_speak $06 ; $6c63
	script_set_anim ACTOR_PLAYER, $02 ; $6c68
	script_wait_idle ACTOR_PLAYER ; $6c6f
	script_speak $06 ; $6c74
	script_set_anim ACTOR_PLAYER, $03 ; $6c79
	script_wait_idle ACTOR_PLAYER ; $6c80
	script_set_objdef $51, $05 ; $6c85
	script_set_anim $05, $01 ; $6c91
	script_set_position $05, $2380, $3300 ; $6c98
	sound $97 ; $6ca3
	script_wait_frames $14 ; $6ca5
	script_speak $07 ; $6cac
	script_set_position $05, $3f00, $3f00 ; $6cb1
	script_set_anim $06, $03 ; $6cbc
	script_wait_idle $06 ; $6cc3
	script_speak $06 ; $6cc8
	script_face_pair $08, $07 ; $6ccd
	script_set_anim $07, $03 ; $6cd5
	script_set_anim $08, $03 ; $6cdc
	script_wait_idle $08 ; $6ce3
	script_wait_frames $28 ; $6ce8
	script_face_pair $08, $09 ; $6cef
	script_set_anim $09, $03 ; $6cf7
	script_set_anim $08, $03 ; $6cfe
	script_wait_idle $08 ; $6d05
	script_wait_frames $28 ; $6d0a
	script_face $07, FACE_UP ; $6d11
	script_face $08, FACE_UP ; $6d18
	script_face $09, FACE_UP ; $6d1f
	script_wait_frames $28 ; $6d26
	script_set_anim $09, $03 ; $6d2d
	script_set_anim $07, $03 ; $6d34
	script_set_anim $08, $03 ; $6d3b
	script_wait_idle $08 ; $6d42
	script_wait_frames $3c ; $6d47
	script_set_objdef $4d, $05 ; $6d4e
	script_set_anim $05, $01 ; $6d5a
	script_set_position $05, $2180, $2d80 ; $6d61
	sound $98 ; $6d6c
	script_wait_frames $50 ; $6d6e
	script_set_position $05, $3f00, $3f00 ; $6d75
	ld a, $06 ; $6d80
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6d82
	farcall RunDialogueYesNoPrompt ; $6d85
	farcall ScriptCloseDialogueWindow ; $6d88
	script_wait_frames $05 ; $6d8b
	and a, a ; $6d92
	jp z, Label_10_6eae ; $6d93
	script_set_anim $06, $02 ; $6d96
	script_wait_idle $06 ; $6d9d
	script_speak $06 ; $6da2
	test_flag $05, 7 ; $6da7
	jp z, Label_10_6e27 ; $6daa
	script_move_target $08, $2000, $3400 ; $6dad
	script_wait_move $08 ; $6db8
	script_face_toward $08, ACTOR_PLAYER ; $6dbd
	script_face_toward $08, ACTOR_PARTNER ; $6dc5
	script_speak $08 ; $6dcd
	script_wait_frames $1e ; $6dd2
	script_move_target $07, $2200, $3400 ; $6dd9
	script_wait_move $07 ; $6de4
	script_face_toward $07, ACTOR_PLAYER ; $6de9
	script_face_toward $07, ACTOR_PARTNER ; $6df1
	script_speak $07 ; $6df9
	script_wait_frames $1e ; $6dfe
	script_move_target $09, $1d00, $3200 ; $6e05
	script_wait_move $09 ; $6e10
	script_face_pair $09, ACTOR_PLAYER ; $6e15
	script_face_toward $09, ACTOR_PARTNER ; $6e1d
	jr Label_10_6e87 ; $6e25
Label_10_6e27:
	script_move_target $08, $2000, $3400 ; $6e27
	script_wait_move $08 ; $6e32
	script_face_toward $08, ACTOR_PLAYER ; $6e37
	script_speak $08 ; $6e3f
	script_wait_frames $1e ; $6e44
	script_move_target $07, $2200, $3400 ; $6e4b
	script_wait_move $07 ; $6e56
	script_face_toward $07, ACTOR_PLAYER ; $6e5b
	script_speak $07 ; $6e63
	script_wait_frames $1e ; $6e68
	script_move_target $09, $1e00, $3200 ; $6e6f
	script_wait_move $09 ; $6e7a
	script_face_pair $09, ACTOR_PLAYER ; $6e7f
Label_10_6e87:
	script_set_anim $09, $04 ; $6e87
	script_wait_idle $09 ; $6e8e
	script_set_text Text_30_491 ; $6e93
	ld a, $09 ; $6e99
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6e9b
	farcall RunDialogueYesNoPrompt ; $6e9e
	farcall ScriptCloseDialogueWindow ; $6ea1
	script_wait_frames $05 ; $6ea4
	and a, a ; $6eab
	jr nz, Label_10_6e87 ; $6eac
Label_10_6eae:
	script_set_anim $06, $03 ; $6eae
	script_wait_idle $06 ; $6eb5
	script_face $07, FACE_UP ; $6eba
	script_face $08, FACE_UP ; $6ec1
	script_face $09, FACE_UP ; $6ec8
	script_face ACTOR_PLAYER, FACE_UP ; $6ecf
	test_flag $05, 7 ; $6ed6
	jp z, Label_10_6ee3 ; $6ed9
	script_face ACTOR_PARTNER, FACE_UP ; $6edc
Label_10_6ee3:
	script_wait_frames $14 ; $6ee3
	script_set_anim $07, $03 ; $6eea
	script_set_anim $08, $03 ; $6ef1
	script_set_anim $09, $03 ; $6ef8
	test_flag $05, 7 ; $6eff
	jp z, Label_10_6f0c ; $6f02
	script_set_anim ACTOR_PARTNER, $03 ; $6f05
Label_10_6f0c:
	script_set_anim ACTOR_PLAYER, $03 ; $6f0c
	script_wait_idle ACTOR_PLAYER ; $6f13
	script_set_text Text_30_492 ; $6f18
	script_speak $06 ; $6f1e
	ld c, $04 ; $6f23
	call BeginFadeOut ; $6f25
	call WaitFadeEnd ; $6f28
	script_wait_frames $32 ; $6f2b
	ld a, $0a ; $6f32
	ld [wStoryModeCurrentLocation], a ; $6f34
	ld a, $0a ; $6f37
	ld [wStoryModeEntryPoint], a ; $6f39
	ld a, $ff ; $6f3c
	ld [$c294], a ; $6f3e
	ld [wStoryModeExitLocationRequest], a ; $6f41
	ret ; $6f44
	; $6f45, 136 bytes (map_actors)
	map_actor $0000, ActorScript_10_7bd1, $fd00, $0100, FACE_DOWN, $4e, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $fd00, $0100, FACE_DOWN, $53, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $fd00, $0100, FACE_DOWN, $51, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $2000, $2f00, FACE_DOWN, $63, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $2200, $3300, FACE_UP, $4b, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $2000, $3300, FACE_UP, $4a, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $1e00, $3300, FACE_UP, $49, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $2700, $3240, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $2700, $30c0, FACE_DOWN, $74, $01, $00
	map_actor_end
Label_10_6fcd:
	ldh a, [hRomBank] ; $6fcd
	ld hl, $739e ; $6fcf
	farcall ScriptRespawnLocationActors ; $6fd2
	farcall BeginCutsceneScriptMode ; $6fd5
	script_set_anim $04, $06 ; $6fd8
	test_flag $05, 7 ; $6fdf
	jp z, Label_10_7019 ; $6fe2
	script_null_script ACTOR_PARTNER ; $6fe5
	script_set_position ACTOR_PLAYER, $1f00, $3400 ; $6fea
	script_set_position ACTOR_PARTNER, $2100, $3400 ; $6ff5
	script_face ACTOR_PARTNER, FACE_UP ; $7000
	test_flag $07, 4 ; $7007
	jr nz, Label_10_7029 ; $700a
	script_set_position $04, $3f00, $3f00 ; $700c
	jr Label_10_7029 ; $7017
Label_10_7019:
	test_flag $06, 5 ; $7019
	jr nz, Label_10_7029 ; $701c
	script_set_position $05, $3f00, $3f00 ; $701e
Label_10_7029:
	script_face ACTOR_PLAYER, FACE_UP ; $7029
	xor a, a ; $7030
	ld [wStoryModeShowLocationName], a ; $7031
	script_fade_in $04 ; $7034
	call WaitFadeEnd ; $7039
	script_wait_frames $3c ; $703c
	script_set_text Text_30_498 ; $7043
	call Func_10_73ee ; $7049
	test_flag $05, 7 ; $704c
	jp z, Label_10_7059 ; $704f
	script_set_anim ACTOR_PARTNER, $02 ; $7052
Label_10_7059:
	script_set_anim ACTOR_PLAYER, $02 ; $7059
	script_wait_idle ACTOR_PLAYER ; $7060
	call Func_10_7405 ; $7065
	farcall RunDialogueYesNoPrompt ; $7068
	farcall ScriptCloseDialogueWindow ; $706b
	script_wait_frames $05 ; $706e
	and a, a ; $7075
	jr nz, Label_10_7089 ; $7076
	script_set_anim ACTOR_PLAYER, $03 ; $7078
	script_wait_idle ACTOR_PLAYER ; $707f
	farcall AdvanceDialogueTextCursor ; $7084
	jr Label_10_7095 ; $7087
Label_10_7089:
	script_set_anim ACTOR_PLAYER, $04 ; $7089
	script_wait_idle ACTOR_PLAYER ; $7090
Label_10_7095:
	script_wait_frames $0a ; $7095
	script_set_anim $03, $03 ; $709c
	script_wait_idle $03 ; $70a3
	script_speak $03 ; $70a8
	script_face $03, FACE_UP ; $70ad
	script_wait_frames $50 ; $70b4
	script_set_text Text_30_504 ; $70bb
	call Func_10_73ee ; $70c1
	test_flag $05, 7 ; $70c4
	jp z, Label_10_7101 ; $70c7
	script_set_position $06, $2080, $3200 ; $70ca
	script_set_position $07, $2280, $3200 ; $70d5
	sound $97 ; $70e0
	script_wait_frames $50 ; $70e2
	script_set_position $06, $3f00, $3f00 ; $70e9
	script_set_position $07, $3f00, $3f00 ; $70f4
	jr Label_10_7120 ; $70ff
Label_10_7101:
	script_set_position $06, $2180, $3200 ; $7101
	sound $97 ; $710c
	script_wait_frames $50 ; $710e
	script_set_position $06, $3f00, $3f00 ; $7115
Label_10_7120:
	script_face $03, FACE_DOWN ; $7120
	script_wait_frames $01 ; $7127
	call Func_10_73ee ; $712e
	script_wait_frames $1e ; $7131
	script_set_anim $03, $03 ; $7138
	script_wait_idle $03 ; $713f
	script_speak $03 ; $7144
	script_set_speed $03, $0010 ; $7149
	script_move_target $03, $2200, $3000 ; $7151
	script_wait_move $03 ; $715c
	script_wait_frames $28 ; $7161
	script_set_anim $03, $03 ; $7168
	script_wait_idle $03 ; $716f
	script_set_anim $03, $03 ; $7174
	script_wait_idle $03 ; $717b
	script_move_target $03, $2000, $3000 ; $7180
	script_wait_move $03 ; $718b
	script_face $03, FACE_DOWN ; $7190
	script_wait_frames $0a ; $7197
	script_speak $03 ; $719e
	script_set_anim ACTOR_PLAYER, $02 ; $71a3
	script_wait_idle ACTOR_PLAYER ; $71aa
	script_set_anim $03, $03 ; $71af
	script_wait_idle $03 ; $71b6
Label_10_71bb:
	ld a, $03 ; $71bb
	farcall ScriptShowSpeakerDialogueRestoreBG ; $71bd
	farcall RunDialogueYesNoPrompt ; $71c0
	farcall ScriptCloseDialogueWindow ; $71c3
	script_wait_frames $05 ; $71c6
	and a, a ; $71cd
	jr z, Label_10_71f0 ; $71ce
	script_set_anim ACTOR_PLAYER, $04 ; $71d0
	script_wait_idle ACTOR_PLAYER ; $71d7
	script_set_anim $03, $02 ; $71dc
	script_wait_idle $03 ; $71e3
	script_set_text Text_30_511 ; $71e8
	jr Label_10_71bb ; $71ee
Label_10_71f0:
	test_flag $05, 7 ; $71f0
	jp z, Label_10_72a9 ; $71f3
	script_set_anim ACTOR_PLAYER, $03 ; $71f6
	script_wait_idle ACTOR_PLAYER ; $71fd
	script_set_anim $03, $03 ; $7202
	script_wait_idle $03 ; $7209
	script_set_text Text_30_512 ; $720e
	script_speak $03 ; $7214
	script_set_anim ACTOR_PLAYER, $03 ; $7219
	script_set_anim ACTOR_PARTNER, $03 ; $7220
	script_wait_idle ACTOR_PARTNER ; $7227
	script_wait_frames $0a ; $722c
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $7233
	script_wait_frames $1e ; $723b
	script_set_anim ACTOR_PLAYER, $03 ; $7242
	script_set_anim ACTOR_PARTNER, $03 ; $7249
	script_wait_idle ACTOR_PARTNER ; $7250
	script_face ACTOR_PARTNER, FACE_DOWN ; $7255
	script_move_target ACTOR_PLAYER, $2100, $3600 ; $725c
	script_wait_move ACTOR_PLAYER ; $7267
	script_move_target ACTOR_PLAYER, $2100, $3700 ; $726c
	script_move_target ACTOR_PARTNER, $2100, $3500 ; $7277
	script_wait_move ACTOR_PARTNER ; $7282
	call Func_10_7339 ; $7287
	script_set_actor_script ACTOR_PLAYER, ActorScript_10_741c ; $728a
	script_set_actor_script ACTOR_PARTNER, ActorScript_10_741c ; $7295
	script_wait_frames $28 ; $72a0
	jr Label_10_7314 ; $72a7
Label_10_72a9:
	script_set_anim ACTOR_PLAYER, $03 ; $72a9
	script_wait_idle ACTOR_PLAYER ; $72b0
	script_set_anim $03, $03 ; $72b5
	script_wait_idle $03 ; $72bc
	script_set_text Text_30_512 ; $72c1
	script_speak $03 ; $72c7
	script_set_anim ACTOR_PLAYER, $03 ; $72cc
	script_wait_idle ACTOR_PLAYER ; $72d3
	script_wait_frames $1e ; $72d8
	script_move_target ACTOR_PLAYER, $2100, $3400 ; $72df
	script_wait_move ACTOR_PLAYER ; $72ea
	script_move_target ACTOR_PLAYER, $2100, $3700 ; $72ef
	script_wait_move ACTOR_PLAYER ; $72fa
	call Func_10_7339 ; $72ff
	script_set_actor_script ACTOR_PLAYER, ActorScript_10_741c ; $7302
	script_wait_frames $14 ; $730d
Label_10_7314:
	call Func_10_736f ; $7314
	script_wait_frames $3c ; $7317
	ld c, $02 ; $731e
	call BeginFadeOut ; $7320
	call WaitFadeEnd ; $7323
	ld a, $14 ; $7326
	ld [wStoryModeCurrentLocation], a ; $7328
	ld a, $0c ; $732b
	ld [wStoryModeEntryPoint], a ; $732d
	ld a, $ff ; $7330
	ld [$c294], a ; $7332
	ld [wStoryModeExitLocationRequest], a ; $7335
	ret ; $7338
Func_10_7339:
	script_wait_frames $0a ; $7339
	sound $79 ; $7340
	script_copy_scene_rect $07, $38, $20, $38, $02, $02 ; $7342
	script_wait_frames $02 ; $7351
	script_copy_scene_rect $0b, $38, $20, $38, $02, $02 ; $7358
	script_wait_frames $04 ; $7367
	ret ; $736e
Func_10_736f:
	sound $79 ; $736f
	script_copy_scene_rect $07, $38, $20, $38, $02, $02 ; $7371
	script_wait_frames $02 ; $7380
	script_copy_scene_rect $03, $38, $20, $38, $02, $02 ; $7387
	script_wait_frames $04 ; $7396
	ret ; $739d
	; $739e, 80 bytes (map_actors)
	map_actor $0000, ActorScript_10_7bd1, $2000, $3000, FACE_DOWN, $63, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $2700, $3240, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $2700, $30c0, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $fd00, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $fd00, $0100, FACE_DOWN, $4c, $01, $00
	map_actor_end
Func_10_73ee:
	test_flag $05, 7 ; $73ee
	jr z, Label_10_73fc ; $73f1
	farcall AdvanceDialogueTextCursor ; $73f3
	script_speak $03 ; $73f6
	ret ; $73fb
Label_10_73fc:
	script_speak $03 ; $73fc
	farcall AdvanceDialogueTextCursor ; $7401
	ret ; $7404
Func_10_7405:
	test_flag $05, 7 ; $7405
	jr z, Label_10_7413 ; $7408
	farcall AdvanceDialogueTextCursor ; $740a
	ld a, $03 ; $740d
	farcall ScriptShowSpeakerDialogueRestoreBG ; $740f
	ret ; $7412
Label_10_7413:
	ld a, $03 ; $7413
	farcall ScriptShowSpeakerDialogueRestoreBG ; $7415
	farcall AdvanceDialogueTextCursor ; $7418
	ret ; $741b
ActorScript_10_741c:
	; $741c, 13 bytes (actor_script)
	as_set_pos $2100, $3b00
	as_wait_move
	as_set_pos $3500, $3b00
	as_wait_move
	as_halt
Func_10_7429:
	ld a, [$c2b0] ; $7429
	cp a, $03 ; $742c
	jr nz, Label_10_7442 ; $742e
	ld a, $11 ; $7430
	ld d, $20 ; $7432
	ld e, $3a ; $7434
	farcall WriteBehaviorMapCell ; $7436
	ld a, $21 ; $7439
	ld d, $20 ; $743b
	ld e, $36 ; $743d
	farcall WriteBehaviorMapCell ; $743f
Label_10_7442:
	ret ; $7442
Func_10_7443:
	script_set_anim $04, $06 ; $7443
	test_flag $05, 7 ; $744a
	jr z, Label_10_7461 ; $744d
	test_flag $07, 4 ; $744f
	jr nz, Label_10_7471 ; $7452
	script_set_position $04, $0100, $0100 ; $7454
	jr Label_10_7471 ; $745f
Label_10_7461:
	test_flag $06, 5 ; $7461
	jr nz, Label_10_7471 ; $7464
	script_set_position $05, $0100, $0100 ; $7466
Label_10_7471:
	ret ; $7471
Func_10_7472:
	ld a, $00 ; $7472
	test_flag $05, 7 ; $7474
	jr z, Label_10_7490 ; $7477
	test_flag $08, 6 ; $7479
	jr z, Label_10_74a5 ; $747c
	ld a, $01 ; $747e
	test_flag $15, 7 ; $7480
	jr z, Label_10_74a5 ; $7483
	ld a, $02 ; $7485
	test_flag $16, 1 ; $7487
	jr z, Label_10_74a5 ; $748a
	ld a, $03 ; $748c
	jr Label_10_74a5 ; $748e
Label_10_7490:
	test_flag $0a, 7 ; $7490
	jr z, Label_10_74a5 ; $7493
	ld a, $01 ; $7495
	test_flag $15, 6 ; $7497
	jr z, Label_10_74a5 ; $749a
	ld a, $02 ; $749c
	test_flag $16, 0 ; $749e
	jr z, Label_10_74a5 ; $74a1
	ld a, $03 ; $74a3
Label_10_74a5:
	ld [$c2b0], a ; $74a5
	ret ; $74a8
AcademyMainBldgMapScripts_10:
	; $74a9, 14 bytes (map_tree)
	dw AcademyMainBldgEntryPoints_10 ; slot 0 EntryPoints
	dw AcademyMainBldgExitTriggers_10 ; slot 1 ExitTriggers
	dw AcademyMainBldgActors_10 ; slot 2 Actors
	dw AcademyMainBldgNpcScripts_10 ; slot 3 NpcScripts
	dw AcademyMainBldgFacingScripts_10 ; slot 4 FacingScripts
	dw AcademyMainBldgTileTriggers_10 ; slot 5 TileTriggers
	dw AcademyMainBldgInitScript_10 ; slot 6 InitScript
AcademyMainBldgActors_10:
	; $74b7, 66 bytes (map_actors)
	map_actor $0000, ActorScript_10_7bd1, $1d00, $1780, FACE_DOWN, $3f, $01, $04
	map_actor $0000, ActorScript_10_7bd1, $0e80, $0f00, FACE_LEFT, $40, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $0500, $0f80, FACE_DOWN, $3f, $01, $07
	map_actor $0000, ActorScript_10_7bdb, $2800, $1e00, FACE_DOWN, $41, $01, $03
	map_actor_end
AcademyMainBldgEntryPoints_10:
	; $74f9, 57 bytes (map_entries)
	map_entry $01, FACE_UP, $2200, $2100, AcademyMainBldgArrival01_10
	map_entry $02, FACE_DOWN, $2200, $0700, AcademyMainBldgArrival02_10
	map_entry $03, FACE_DOWN, $3500, $1900, MapArrivalWalkPair_10
	map_entry $04, FACE_DOWN, $3b00, $3900, MapArrivalWalkPair_10
	map_entry $0d, FACE_UP, $2100, $3b00, $0000
	map_entry $0e, FACE_UP, $2200, $1300, $0000
	map_entry $0f, FACE_UP, $2200, $1d00, $0000
	db $ff
AcademyMainBldgArrival02_10:
	ld a, [wStoryModeEntryPoint] ; $7532
	cp a, $ff ; $7535
	jp z, Label_10_7577 ; $7537
	test_flag $05, 7 ; $753a
	jr z, Label_10_7565 ; $753d
	script_set_speed ACTOR_PARTNER, $00ff ; $753f
	script_move_angle ACTOR_PARTNER, FACE_UP, $0200 ; $7547
	script_wait_move ACTOR_PARTNER ; $7551
	script_face ACTOR_PARTNER, FACE_DOWN ; $7556
	script_set_speed ACTOR_PARTNER, $0010 ; $755d
Label_10_7565:
	script_set_speed ACTOR_PLAYER, $0010 ; $7565
	script_move_angle ACTOR_PLAYER, FACE_DOWN, $0200 ; $756d
Label_10_7577:
	ret ; $7577
AcademyMainBldgArrival01_10:
	ld a, [wStoryModeEntryPoint] ; $7578
	cp a, $ff ; $757b
	jp z, Label_10_75bd ; $757d
	test_flag $05, 7 ; $7580
	jr z, Label_10_75ab ; $7583
	script_set_speed ACTOR_PARTNER, $00ff ; $7585
	script_move_angle ACTOR_PARTNER, FACE_DOWN, $0200 ; $758d
	script_wait_move ACTOR_PARTNER ; $7597
	script_face ACTOR_PARTNER, FACE_UP ; $759c
	script_set_speed ACTOR_PARTNER, $0010 ; $75a3
Label_10_75ab:
	script_set_speed ACTOR_PLAYER, $0010 ; $75ab
	script_move_angle ACTOR_PLAYER, FACE_UP, $0200 ; $75b3
Label_10_75bd:
	ret ; $75bd
AcademyMainBldgExitTriggers_10:
	; $75be, 41 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_10, $14, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_10, $07, $03
	map_script $03, FACEMASK_ANY, $0000, Func_10_7ae6, $06, $01
	map_script $04, FACEMASK_ANY, $0000, Func_10_7b1f, $05, $03
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_10, $07, $0f
	db $ff
AcademyMainBldgNpc03_10:
	ld a, [$c2b0] ; $75e7
	sra a ; $75ea
	add a, a ; $75ec
	add a, $27 ; $75ed
	ld l, a ; $75ef
	adc a, $76 ; $75f0
	sub a, l ; $75f2
	ld h, a ; $75f3
	ld a, [hl+] ; $75f4
	ld h, [hl] ; $75f5
	ld l, a ; $75f6
	farcall InitDialogueTextCursor ; $75f7
	ld a, [$c2b0] ; $75fa
	sra a ; $75fd
	cp a, $03 ; $75ff
	jr z, Label_10_7609 ; $7601
	script_speak $03 ; $7603
	ret ; $7608
Label_10_7609:
	ld a, $03 ; $7609
	farcall ScriptShowSpeakerDialogueRestoreBG ; $760b
	farcall RunDialogueYesNoPrompt ; $760e
	farcall ScriptCloseDialogueWindow ; $7611
	script_wait_frames $05 ; $7614
	and a, a ; $761b
	jr z, Label_10_7621 ; $761c
	farcall AdvanceDialogueTextCursor ; $761e
Label_10_7621:
	script_speak $03 ; $7621
	ret ; $7626
	; $7627, 10 bytes (records:2)
	dw $01b8 ; record 0
	dw $01bb ; record 1
	dw $01be ; record 2
	dw $01c4 ; record 3
	dw $01c9 ; record 4
AcademyMainBldgNpc04_10:
	ld a, [$c2b0] ; $7631
	sra a ; $7634
	add a, a ; $7636
	add a, $4a ; $7637
	ld l, a ; $7639
	adc a, $76 ; $763a
	sub a, l ; $763c
	ld h, a ; $763d
	ld a, [hl+] ; $763e
	ld h, [hl] ; $763f
	ld l, a ; $7640
	farcall InitDialogueTextCursor ; $7641
	script_speak $04 ; $7644
	ret ; $7649
	; $764a, 10 bytes (records:2)
	dw $01b9 ; record 0
	dw $01bc ; record 1
	dw $01bf ; record 2
	dw $01c7 ; record 3
	dw $01ca ; record 4
AcademyMainBldgNpc05_10:
	script_set_text Text_30_462 ; $7654
	script_speak $05 ; $765a
	script_face $05, FACE_DOWN ; $765f
	test_flag $05, 7 ; $7666
	jr nz, Label_10_76a2 ; $7669
	script_speak $05 ; $766b
	ld a, [$c2b0] ; $7670
	sra a ; $7673
	add a, a ; $7675
	add a, $98 ; $7676
	ld l, a ; $7678
	adc a, $76 ; $7679
	sub a, l ; $767b
	ld h, a ; $767c
	ld a, [hl+] ; $767d
	ld h, [hl] ; $767e
	ld l, a ; $767f
	farcall InitDialogueTextCursor ; $7680
Label_10_7683:
	script_wait_frames $14 ; $7683
	script_face_toward ACTOR_PLAYER, $05 ; $768a
	script_speak $05 ; $7692
	ret ; $7697
	; $7698, 10 bytes (records:2)
	dw $01d0 ; record 0
	dw $01d1 ; record 1
	dw $01d2 ; record 2
	dw $01d3 ; record 3
	dw $01d4 ; record 4
Label_10_76a2:
	script_set_text Text_30_469 ; $76a2
	script_wait_frames $14 ; $76a8
	script_speak $05 ; $76af
	call Func_10_7bb6 ; $76b4
	add a, a ; $76b7
	add a, $c7 ; $76b8
	ld l, a ; $76ba
	adc a, $76 ; $76bb
	sub a, l ; $76bd
	ld h, a ; $76be
	ld a, [hl+] ; $76bf
	ld h, [hl] ; $76c0
	ld l, a ; $76c1
	farcall InitDialogueTextCursor ; $76c2
	jr Label_10_7683 ; $76c5
	; $76c7, 10 bytes (records:2)
	dw $01d6 ; record 0
	dw $01d7 ; record 1
	dw $01d8 ; record 2
	dw $01d9 ; record 3
	dw $01da ; record 4
AcademyMainBldgNpc06_10:
	ld a, [$c2b0] ; $76d1
	sra a ; $76d4
	add a, a ; $76d6
	add a, $ea ; $76d7
	ld l, a ; $76d9
	adc a, $76 ; $76da
	sub a, l ; $76dc
	ld h, a ; $76dd
	ld a, [hl+] ; $76de
	ld h, [hl] ; $76df
	ld l, a ; $76e0
	farcall InitDialogueTextCursor ; $76e1
	script_speak $06 ; $76e4
	ret ; $76e9
	; $76ea, 10 bytes (records:2)
	dw $01ba ; record 0
	dw $01bd ; record 1
	dw $01c0 ; record 2
	dw $01c8 ; record 3
	dw $01cb ; record 4
AcademyMainBldgNpcScripts_10:
	; $76f4, 33 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, AcademyMainBldgNpc03_10, $13, $00
	map_script $04, FACEMASK_ANY, $0000, AcademyMainBldgNpc04_10, $03, $00
	map_script $05, FACEMASK_ANY, $0000, AcademyMainBldgNpc05_10, $03, $00
	map_script $06, FACEMASK_ANY, $0000, AcademyMainBldgNpc06_10, $13, $00
	db $ff
AcademyMainBldgFacingScripts_10:
	ds 1, $ff ; $7715, fill
AcademyMainBldgTileTriggers_10:
	ds 1, $ff ; $7716, fill
AcademyMainBldgInitScript_10:
	call Func_10_7dbd ; $7717
	ld a, [$c2b0] ; $771a
	sra a ; $771d
	cp a, $02 ; $771f
	jr nz, Label_10_772e ; $7721
	script_set_actor_script $03, ActorScript_10_7b8b ; $7723
Label_10_772e:
	ld a, $01 ; $772e
	ld hl, Func_10_79d0 ; $7730
	call RegisterFrameTask ; $7733
	ld a, [wStoryModeEntryPoint] ; $7736
	cp a, $0f ; $7739
	jr nz, Label_10_7740 ; $773b
	call Func_10_7741 ; $773d
Label_10_7740:
	ret ; $7740
Func_10_7741:
	ldh a, [hRomBank] ; $7741
	ld hl, $7980 ; $7743
	farcall ScriptRespawnLocationActors ; $7746
	farcall BeginCutsceneScriptMode ; $7749
	script_set_position ACTOR_PLAYER, $2200, $2580 ; $774c
	script_set_position $03, $2200, $2400 ; $7757
	script_fade_in $04 ; $7762
	script_wait_frames $1e ; $7767
	script_face $03, FACE_UP ; $776e
	script_wait_frames $0a ; $7775
	script_set_anim $04, $02 ; $777c
	script_wait_frames $1e ; $7783
	script_move_target $03, $2200, $1700 ; $778a
	script_move_player $2200, $1700 ; $7795
	script_wait_frames $0a ; $779f
	script_move_target ACTOR_PLAYER, $2200, $1900 ; $77a6
	script_face $04, FACE_RIGHT ; $77b1
	farcall WaitPlayerMoveDone ; $77b8
	script_set_text Text_30_430 ; $77bb
	script_speak $04 ; $77c1
	script_wait_move $03 ; $77c6
	script_wait_frames $0a ; $77cb
	script_move_player $1d00, $1900 ; $77d2
	script_face_toward $04, $03 ; $77dc
	script_wait_frames $1e ; $77e4
	script_face_toward $04, ACTOR_PLAYER ; $77eb
	script_wait_frames $1e ; $77f3
	farcall WaitPlayerMoveDone ; $77fa
	script_set_anim $04, $03 ; $77fd
	script_wait_idle $04 ; $7804
	script_speak $04 ; $7809
	script_wait_frames $0a ; $780e
	script_set_anim $03, $03 ; $7815
	script_wait_idle $03 ; $781c
	script_speak $03 ; $7821
	script_face_toward ACTOR_PLAYER, $03 ; $7826
	script_wait_frames $32 ; $782e
	script_face_toward $04, $03 ; $7835
	script_wait_frames $1e ; $783d
	ld a, [$c90d] ; $7844
	or a, a ; $7847
	jr z, Label_10_784d ; $7848
	farcall AdvanceDialogueTextCursor ; $784a
Label_10_784d:
	script_speak $03 ; $784d
	ld a, [$c90d] ; $7852
	or a, a ; $7855
	jr nz, Label_10_785b ; $7856
	farcall AdvanceDialogueTextCursor ; $7858
Label_10_785b:
	script_wait_frames $0f ; $785b
	script_set_anim $04, $03 ; $7862
	script_wait_idle $04 ; $7869
	script_speak $04 ; $786e
	script_wait_frames $0f ; $7873
	script_set_anim ACTOR_PLAYER, $03 ; $787a
	script_wait_idle ACTOR_PLAYER ; $7881
	script_wait_frames $0f ; $7886
	script_set_anim $04, $03 ; $788d
	script_wait_idle $04 ; $7894
	script_speak $04 ; $7899
	script_wait_frames $0f ; $789e
	script_set_anim $03, $02 ; $78a5
	script_wait_idle $03 ; $78ac
	script_speak $03 ; $78b1
	script_face_toward $03, ACTOR_PLAYER ; $78b6
	script_set_position $06, $2300, $1700 ; $78be
	sound $98 ; $78c9
	script_wait_frames $3c ; $78cb
	script_set_position $06, $3f00, $3f00 ; $78d2
	script_set_anim $04, $03 ; $78dd
	script_wait_idle $04 ; $78e4
	script_speak $04 ; $78e9
	script_set_anim ACTOR_PLAYER, $02 ; $78ee
	script_wait_idle ACTOR_PLAYER ; $78f5
	script_wait_frames $0a ; $78fa
	script_face_toward $04, ACTOR_PLAYER ; $7901
	script_set_anim ACTOR_PLAYER, $03 ; $7909
	script_wait_idle ACTOR_PLAYER ; $7910
	script_wait_frames $0f ; $7915
	script_face_pair $04, $03 ; $791c
	script_set_anim $03, $03 ; $7924
	script_set_anim $04, $03 ; $792b
	script_wait_idle $04 ; $7932
	script_move_player $2200, $1700 ; $7937
	script_wait_frames $28 ; $7941
	script_move_target $03, $2200, $0300 ; $7948
	script_wait_frames $0a ; $7953
	script_move_player $2200, $0300 ; $795a
	script_move_target ACTOR_PLAYER, $2200, $0300 ; $7964
	script_wait_move ACTOR_PLAYER ; $796f
	ld a, $0f ; $7974
	ld [$c294], a ; $7976
	ld [wStoryModeExitLocationRequest], a ; $7979
	farcall EndCutsceneScriptMode ; $797c
	ret ; $797f
	; $7980, 80 bytes (map_actors)
	map_actor $0000, ActorScript_10_7bd1, $2b00, $0b00, FACE_DOWN, $49, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $1d00, $1700, FACE_DOWN, $3f, $01, $04
	map_actor $0000, ActorScript_10_7bd1, $fd00, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $fd00, $0100, FACE_DOWN, $4d, $01, $00
	map_actor $0000, ActorScript_10_7bd1, $fd00, $0100, FACE_DOWN, $4f, $01, $00
	map_actor_end
Func_10_79d0:
	ld a, $00 ; $79d0
	call Func_10_79df ; $79d2
	test_flag $05, 7 ; $79d5
	ret z ; $79d8
	ld a, $02 ; $79d9
	call Func_10_79df ; $79db
	ret ; $79de
Func_10_79df:
	ld h, a ; $79df
	ld l, $00 ; $79e0
	push af ; $79e2
	wram_bank $04 ; $79e3
	srl h ; $79e9
	rr l ; $79eb
	srl h ; $79ed
	rr l ; $79ef
	ld bc, $d000 ; $79f1
	add hl, bc ; $79f4
	ld b, h ; $79f5
	ld c, l ; $79f6
	ld hl, $000c ; $79f7
	add hl, bc ; $79fa
	ld a, [hl+] ; $79fb
	ld h, [hl] ; $79fc
	ld l, a ; $79fd
	ld de, $ffb0 ; $79fe
	add hl, de ; $7a01
	ld d, h ; $7a02
	ld hl, $000e ; $7a03
	add hl, bc ; $7a06
	ld a, [hl+] ; $7a07
	add a, $40 ; $7a08
	ld a, [hl] ; $7a0a
	adc a, $00 ; $7a0b
	ld e, a ; $7a0d
	dec e ; $7a0e
	pop af ; $7a0f
	or a, a ; $7a10
	jr z, Label_10_7a15 ; $7a11
	dec e ; $7a13
	dec e ; $7a14
Label_10_7a15:
	push de ; $7a15
	call Func_10_7ac8 ; $7a16
	pop de ; $7a19
	and a, $87 ; $7a1a
	cp a, $06 ; $7a1c
	jr nz, Label_10_7a2f ; $7a1e
	wram_bank $04 ; $7a20
	ld hl, $0020 ; $7a26
	add hl, bc ; $7a29
	ld a, [hl] ; $7a2a
	xor a, $01 ; $7a2b
	ld [hl], a ; $7a2d
	ret ; $7a2e
Label_10_7a2f:
	inc d ; $7a2f
	call Func_10_7ac8 ; $7a30
	and a, $07 ; $7a33
	cp a, $06 ; $7a35
	jr nz, Label_10_7a48 ; $7a37
	wram_bank $04 ; $7a39
	ld hl, $0020 ; $7a3f
	add hl, bc ; $7a42
	ld a, [hl] ; $7a43
	xor a, $01 ; $7a44
	ld [hl], a ; $7a46
	ret ; $7a47
Label_10_7a48:
	wram_bank $04 ; $7a48
	ld hl, $0020 ; $7a4e
	add hl, bc ; $7a51
	ld a, $02 ; $7a52
	ld [hl], a ; $7a54
	ret ; $7a55
	ld h, a ; $7a56
	ld l, $00 ; $7a57
	wram_bank $04 ; $7a59
	srl h ; $7a5f
	rr l ; $7a61
	srl h ; $7a63
	rr l ; $7a65
	ld bc, $d000 ; $7a67
	add hl, bc ; $7a6a
	ld b, h ; $7a6b
	ld c, l ; $7a6c
	ld hl, $000c ; $7a6d
	add hl, bc ; $7a70
	ld a, [hl+] ; $7a71
	ld h, [hl] ; $7a72
	ld l, a ; $7a73
	ld de, $ffb0 ; $7a74
	add hl, de ; $7a77
	ld d, h ; $7a78
	ld hl, $000e ; $7a79
	add hl, bc ; $7a7c
	ld a, [hl+] ; $7a7d
	add a, $40 ; $7a7e
	ld a, [hl] ; $7a80
	adc a, $00 ; $7a81
	ld e, a ; $7a83
	dec e ; $7a84
	dec e ; $7a85
	dec e ; $7a86
	push de ; $7a87
	call Func_10_7ac8 ; $7a88
	pop de ; $7a8b
	and a, $87 ; $7a8c
	cp a, $06 ; $7a8e
	jr nz, Label_10_7aa1 ; $7a90
	wram_bank $04 ; $7a92
	ld hl, $0020 ; $7a98
	add hl, bc ; $7a9b
	ld a, [hl] ; $7a9c
	xor a, $01 ; $7a9d
	ld [hl], a ; $7a9f
	ret ; $7aa0
Label_10_7aa1:
	inc d ; $7aa1
	call Func_10_7ac8 ; $7aa2
	and a, $07 ; $7aa5
	cp a, $06 ; $7aa7
	jr nz, Label_10_7aba ; $7aa9
	wram_bank $04 ; $7aab
	ld hl, $0020 ; $7ab1
	add hl, bc ; $7ab4
	ld a, [hl] ; $7ab5
	xor a, $01 ; $7ab6
	ld [hl], a ; $7ab8
	ret ; $7ab9
Label_10_7aba:
	wram_bank $04 ; $7aba
	ld hl, $0020 ; $7ac0
	add hl, bc ; $7ac3
	ld a, $02 ; $7ac4
	ld [hl], a ; $7ac6
	ret ; $7ac7
Func_10_7ac8:
	wram_bank $02 ; $7ac8
	ld h, e ; $7ace
	ld l, $00 ; $7acf
	srl h ; $7ad1
	rr l ; $7ad3
	srl h ; $7ad5
	rr l ; $7ad7
	ld a, d ; $7ad9
	add a, l ; $7ada
	ld l, a ; $7adb
	jr nc, Label_10_7adf ; $7adc
	inc h ; $7ade
Label_10_7adf:
	ld d, h ; $7adf
	ld e, l ; $7ae0
	ld l, c ; $7ae1
	ld h, b ; $7ae2
	add hl, de ; $7ae3
	ld a, [hl] ; $7ae4
	ret ; $7ae5
Func_10_7ae6:
	script_set_speed ACTOR_PLAYER, $0010 ; $7ae6
	script_set_speed ACTOR_PARTNER, $0010 ; $7aee
	script_move_angle ACTOR_PLAYER, FACE_UP, $0100 ; $7af6
	script_wait_move ACTOR_PLAYER ; $7b00
	script_move_angle ACTOR_PLAYER, $e0, $0080 ; $7b05
	script_wait_move ACTOR_PLAYER ; $7b0f
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $00c0 ; $7b14
	ret ; $7b1e
Func_10_7b1f:
	ld a, [wStoryModeEntryPoint] ; $7b1f
	cp a, $ff ; $7b22
	jr z, Label_10_7b5e ; $7b24
	script_set_speed ACTOR_PARTNER, $0010 ; $7b26
	script_set_speed ACTOR_PLAYER, $0010 ; $7b2e
	script_move_angle ACTOR_PLAYER, FACE_UP, $00c0 ; $7b36
	script_wait_move ACTOR_PLAYER ; $7b40
	script_move_angle ACTOR_PLAYER, $a0, $0080 ; $7b45
	script_wait_move ACTOR_PLAYER ; $7b4f
	script_move_angle ACTOR_PLAYER, FACE_LEFT, $0080 ; $7b54
Label_10_7b5e:
	ret ; $7b5e
MapArrivalWalkPair_10:
	ld a, [wStoryModeEntryPoint] ; $7b5f
	cp a, $ff ; $7b62
	jr z, Label_10_7b8a ; $7b64
	script_set_speed ACTOR_PLAYER, $0010 ; $7b66
	script_set_speed ACTOR_PARTNER, $0010 ; $7b6e
	script_move_angle ACTOR_PLAYER, FACE_DOWN, $0280 ; $7b76
	script_move_angle ACTOR_PARTNER, FACE_DOWN, $0200 ; $7b80
Label_10_7b8a:
	ret ; $7b8a
ActorScript_10_7b8b:
	; $7b8b, 43 bytes (actor_script)
	as_set_field $06, $0018
	as_flag $01, $05, $02
.L8:
	as_set_pos $1b00, $1720
	as_wait_move2
	as_wait $05
	as_set_pos $1d00, $1720
	as_wait_move2
	as_wait $0a
	as_set_pos $1d00, $1600
	as_wait_move2
	as_wait $0a
	as_set_pos $1d00, $1720
	as_wait_move2
	as_wait $05
	as_jump .L8
Func_10_7bb6:
	ld a, $00 ; $7bb6
	test_flag $08, 2 ; $7bb8
	jr z, Label_10_7bd0 ; $7bbb
	inc a ; $7bbd
	test_flag $08, 6 ; $7bbe
	jr z, Label_10_7bd0 ; $7bc1
	inc a ; $7bc3
	test_flag $09, 0 ; $7bc4
	jr z, Label_10_7bd0 ; $7bc7
	inc a ; $7bc9
	test_flag $16, 1 ; $7bca
	jr z, Label_10_7bd0 ; $7bcd
	inc a ; $7bcf
Label_10_7bd0:
	ret ; $7bd0
ActorScript_10_7bd1:
	; $7bd1, 10 bytes (actor_script)
	as_halt
	as_anim $00
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
ActorScript_10_7bdb:
	; $7bdb, 30 bytes (actor_script)
	as_begin_path
.L1:
	as_rand_box $02, $02
	as_wait_move2
	as_wait $28
	as_jump .L1
	as_begin_path
.Lb:
	as_rand_box $01, $02
	as_wait_move2
	as_wait $28
	as_jump .Lb
	as_begin_path
.L15:
	as_rand_box $01, $01
	as_wait_move2
	as_wait $28
	as_jump .L15
MapScriptNop_10:
	ret ; $7bf9
MapScriptClearActiveFlag_10:
	xor a, a ; $7bfa
	ld [$c2da], a ; $7bfb
	ret ; $7bfe
	INCBIN "data/bank_010/d_7bff.bin" ; $7bff, 446 bytes
Func_10_7dbd:
	test_flag $05, 7 ; $7dbd
	jr nz, Label_10_7de4 ; $7dc0
	ld a, $00 ; $7dc2
	test_flag $0a, 3 ; $7dc4
	jr z, Label_10_7de0 ; $7dc7
	ld a, $02 ; $7dc9
	test_flag $0a, 7 ; $7dcb
	jr z, Label_10_7de0 ; $7dce
	ld a, $04 ; $7dd0
	test_flag $15, 6 ; $7dd2
	jr z, Label_10_7de0 ; $7dd5
	ld a, $06 ; $7dd7
	test_flag $16, 0 ; $7dd9
	jr z, Label_10_7de0 ; $7ddc
	ld a, $08 ; $7dde
Label_10_7de0:
	ld [$c2b0], a ; $7de0
	ret ; $7de3
Label_10_7de4:
	ld a, $01 ; $7de4
	test_flag $08, 2 ; $7de6
	jr z, Label_10_7de0 ; $7de9
	ld a, $03 ; $7deb
	test_flag $08, 6 ; $7ded
	jr z, Label_10_7de0 ; $7df0
	ld a, $05 ; $7df2
	test_flag $15, 7 ; $7df4
	jr z, Label_10_7de0 ; $7df7
	ld a, $07 ; $7df9
	test_flag $16, 1 ; $7dfb
	jr z, Label_10_7de0 ; $7dfe
	ld a, $09 ; $7e00
	jr Label_10_7de0 ; $7e02
	ld a, $00 ; $7e04
	test_flag $0a, 3 ; $7e06
	jr z, Label_10_7e23 ; $7e09
	inc a ; $7e0b
	test_flag $0a, 7 ; $7e0c
	jr z, Label_10_7e23 ; $7e0f
	inc a ; $7e11
	test_flag $05, 7 ; $7e12
	jr nz, Label_10_7e27 ; $7e15
	test_flag $15, 6 ; $7e17
	jr z, Label_10_7e23 ; $7e1a
	inc a ; $7e1c
	test_flag $16, 0 ; $7e1d
	jr z, Label_10_7e23 ; $7e20
	inc a ; $7e22
Label_10_7e23:
	ld [$c2b0], a ; $7e23
	ret ; $7e26
Label_10_7e27:
	test_flag $15, 7 ; $7e27
	jr z, Label_10_7e23 ; $7e2a
	inc a ; $7e2c
	test_flag $16, 1 ; $7e2d
	jr z, Label_10_7e23 ; $7e30
	inc a ; $7e32
	jr Label_10_7e23 ; $7e33
	ds 459, $ff ; $7e35, fill
