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
	map_actor $0000, ActorScript_10_2, $0700, $1100, FACE_DOWN, $49, $01, $00
	map_actor $0000, ActorScript_10_2, $0700, $0700, FACE_LEFT, $46, $01, $03
	map_actor $0000, ActorScript_10_2, $0d00, $0700, FACE_LEFT, $47, $01, $03
	map_actor $0000, ActorScript_10_2, $0700, $0b00, FACE_DOWN, $54, $01, $03
	map_actor $0000, ActorScript_10_2, $0d00, $0b00, FACE_DOWN, $55, $01, $03
	map_actor $0000, ActorScript_10_2, $0d00, $1100, FACE_DOWN, $6c, $01, $05
	map_actor $0000, ActorScript_10_2, $0500, $0e00, FACE_DOWN, $43, $01, $03
	map_actor $0000, ActorScript_10_2, $1100, $0e00, FACE_DOWN, $43, $01, $03
	map_actor $0000, ActorScript_10_2, $1100, $0c00, FACE_DOWN, $43, $01, $03
	map_actor_end
MatchSelectEntryPoints_10:
	; $40a6, 9 bytes (map_entries)
	map_entry $01, FACE_UP, $0a00, $0900, $0000
	db $ff
MatchSelectExitTriggers_10:
	ds 1, $ff ; $40af, fill
MatchSelectRunCharacterSelect:
	farcall BeginCutsceneScriptMode ; $40b0
	ld c, $10 ; $40b3
	call BeginFadeOut ; $40b5
	call WaitFadeEnd ; $40b8
	ld b, $00 ; $40bb
	farcall RunCharacterSelectScreen ; $40bd
	ld c, $10 ; $40c0
	call BeginFadeOut ; $40c2
	call WaitFadeEnd ; $40c5
	farcall LoadStoryObjPalettes ; $40c8
	call DisableLCDSafely ; $40cb
	farcall LoadMenuFontGfx ; $40ce
	call EnableLCD ; $40d1
	ld hl, wStoryModePlayersXPosition ; $40d4
	ld de, wStoryModeSpawnPosition ; $40d7
	ld bc, $0005 ; $40da
	call CopyMemoryBC ; $40dd
	ld a, $ff ; $40e0
	ld [wStoryModeEntryPoint], a ; $40e2
	ld [wUnusedExitTriggerIdMirror], a ; $40e5
	ld [wStoryModeExitTriggerRequest], a ; $40e8
	farcall EndCutsceneScriptMode ; $40eb
	ret ; $40ee
MatchSelectPlayEpilogueScene:
	farcall BeginCutsceneScriptMode ; $40ef
	farcall RunScrollingTextScreen ; $40f2
	wait_frames $3c ; $40f5
	call EnableLCD ; $40f9
	farcall SetupSceneAnimationPalettes ; $40fc
	script_fade_in $04 ; $40ff
	call WaitFadeEnd ; $4104
	sound BGM_COURT_WAREHOUSE ; $4107
	ld a, $01 ; $4109
	ld hl, SceneAnimationFrameTask_10 ; $410b
	call RegisterFrameTask ; $410e
	wait_frames $78 ; $4111
	wait_frames $ff ; $4115
	wait_frames $ff ; $4119
	wait_frames $ff ; $411d
	wait_frames $ff ; $4121
	wait_frames $ff ; $4125
	wait_frames $ff ; $4129
	ld hl, SceneAnimationFrameTask_10 ; $412d
	call UnregisterFrameTask ; $4130
	farcall EndCutsceneScriptMode ; $4133
	ret ; $4136
MatchSelectRunEndingCredits:
	farcall BeginCutsceneScriptMode ; $4137
	farcall RunEndingCreditsSequence ; $413a
	farcall EndCutsceneScriptMode ; $413d
	ret ; $4140
SceneAnimationFrameTask_10:
	farcall UpdateSceneAnimation ; $4141
	ret ; $4144
MatchSelectHandlerTable_10:
	; $4145, 73 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, MatchSelectRunCharacterSelect, $00, $00
	map_script $04, FACEMASK_ANY, $0000, RunSinglesMatchListMenu, $00, $00
	map_script $05, FACEMASK_ANY, $0000, RunDoublesMatchListMenu, $00, $00
	map_script $06, FACEMASK_ANY, $0000, RunDrillMatchListMenu, $00, $00
	map_script $07, FACEMASK_ANY, $0000, MatchSelectCharDataOptionDisabled, $00, $00
	map_script $08, FACEMASK_ANY, $0000, RunLessonSelectMenu, $00, $00
	map_script $09, FACEMASK_ANY, $0000, RunMinigameSelectMenu, $00, $00
	map_script $0a, FACEMASK_ANY, $0000, MatchSelectPlayEpilogueScene, $00, $00
	map_script $0b, FACEMASK_ANY, $0000, MatchSelectRunEndingCredits, $00, $00
	db $ff
MatchSelectFacingScripts_10:
	ds 1, $ff ; $418e, fill
MatchSelectTileTriggers_10:
	ds 1, $ff ; $418f, fill
MatchSelectInitScript_10:
	xor a ; $4190
	ld [wStoryModeShowLocationName], a ; $4191
	ret ; $4194
RunSinglesMatchListMenu:
	ld hl, Text_31_132 ; $4195
	ld de, $0101 ; $4198
	ld a, $05 ; $419b
	farcall RunPagedTextMenu ; $419d
	cp $ff ; $41a0
	jp z, RunDoublesMatchListMenu.done ; $41a2
	ld [wMapSceneStage], a ; $41a5
	ld hl, wStoryModePlayersXPosition ; $41a8
	ld de, wStoryModeSpawnPosition ; $41ab
	ld bc, $0005 ; $41ae
	call CopyMemoryBC ; $41b1
	ld a, $ff ; $41b4
	ld [wStoryModeEntryPoint], a ; $41b6
	ld [wUnusedExitTriggerIdMirror], a ; $41b9
	ld [wStoryModeExitTriggerRequest], a ; $41bc
	farcall InitStoryMatchSettings ; $41bf
	ld a, [wMapSceneStage] ; $41c2
	add a ; $41c5
	ld_hl_indexed RunSinglesMatchListMenuTable ; $41c6
	ld a, [hl+] ; $41cd
	ld h, [hl] ; $41ce
	ld l, a ; $41cf
	call JumpToHL ; $41d0
	farcall RunStoryMatch ; $41d3
	farcall RestoreOverworldAfterMatch ; $41d6
	ret ; $41d9
RunDoublesMatchListMenu:
	ld hl, Text_31_137 ; $41da
	ld de, $0101 ; $41dd
	ld a, $04 ; $41e0
	farcall RunPagedTextMenu ; $41e2
	cp $ff ; $41e5
	jp z, .done ; $41e7
	ld [wMapSceneStage], a ; $41ea
	ld hl, wStoryModePlayersXPosition ; $41ed
	ld de, wStoryModeSpawnPosition ; $41f0
	ld bc, $0005 ; $41f3
	call CopyMemoryBC ; $41f6
	ld a, $ff ; $41f9
	ld [wStoryModeEntryPoint], a ; $41fb
	ld [wUnusedExitTriggerIdMirror], a ; $41fe
	ld [wStoryModeExitTriggerRequest], a ; $4201
	farcall InitStoryMatchSettings ; $4204
	ld a, [wMapSceneStage] ; $4207
	add a ; $420a
	ld_hl_indexed RunDoublesMatchListMenuTable ; $420b
	ld a, [hl+] ; $4212
	ld h, [hl] ; $4213
	ld l, a ; $4214
	call JumpToHL ; $4215
	farcall RunStoryMatch ; $4218
	farcall RestoreOverworldAfterMatch ; $421b
	ret ; $421e
.done:
	ret ; $421f
RunSinglesMatchListMenuTable:
	dw LoadMatchSinglesJunior4 ; $4220
	dw LoadMatchSinglesJunior3 ; $4222
	dw LoadMatchSinglesJunior2 ; $4224
	dw LoadMatchSinglesJunior1 ; $4226
	dw LoadMatchSinglesSenior4 ; $4228
	dw LoadMatchSinglesSenior3 ; $422a
	dw LoadMatchSinglesSenior2 ; $422c
	dw LoadMatchSinglesSenior1 ; $422e
	dw LoadMatchSinglesJunior3Alias ; $4230
	dw LoadMatchSinglesJuniorPractice ; $4232
	dw LoadMatchSinglesSeniorPractice ; $4234
	dw LoadMatchSinglesVarsityPractice ; $4236
	dw LoadMatchSinglesOpenRound1 ; $4238
	dw LoadMatchSinglesOpenRound2 ; $423a
	dw LoadMatchSinglesOpenSemifinals ; $423c
	dw LoadMatchSinglesOpenFinals ; $423e
	dw LoadMatchSinglesDreamHard ; $4240
	dw LoadMatchSinglesDreamIntense ; $4242
	dw LoadMatchSinglesDreamMax ; $4244
RunDoublesMatchListMenuTable:
	dw LoadMatchDoublesJunior3 ; $4246
	dw LoadMatchDoublesJunior2 ; $4248
	dw LoadMatchDoublesJunior1 ; $424a
	dw LoadMatchDoublesJuniorPractice ; $424c
	dw LoadMatchDoublesSenior3 ; $424e
	dw LoadMatchDoublesSenior2 ; $4250
	dw LoadMatchDoublesSenior1 ; $4252
	dw LoadMatchDoublesSeniorPractice ; $4254
	dw LoadMatchDoublesVarsity2 ; $4256
	dw LoadMatchDoublesVarsityPractice ; $4258
	dw LoadMatchDoublesOpenRound1 ; $425a
	dw LoadMatchDoublesOpenSemifinals ; $425c
	dw LoadMatchDoublesOpenFinals ; $425e
	dw LoadMatchDoublesDreamHard ; $4260
	dw LoadMatchDoublesDreamIntense ; $4262
	dw LoadMatchDoublesDreamMax ; $4264
LoadMatchSinglesDreamHard:
	load_match_settings $0018 ; $4266
	ret ; $4273
LoadMatchSinglesDreamIntense:
	load_match_settings $0017 ; $4274
	ret ; $4281
LoadMatchSinglesDreamMax:
	load_match_settings $0016 ; $4282
	ret ; $428f
LoadMatchDoublesDreamHard:
	load_match_settings $0118 ; $4290
	ret ; $429d
LoadMatchDoublesDreamIntense:
	load_match_settings $0117 ; $429e
	ret ; $42ab
LoadMatchDoublesDreamMax:
	load_match_settings $0116 ; $42ac
	ret ; $42b9
LoadMatchSinglesOpenRound1:
	load_match_settings $0010 ; $42ba
	ret ; $42c7
LoadMatchSinglesOpenRound2:
	load_match_settings $0011 ; $42c8
	ret ; $42d5
LoadMatchSinglesOpenSemifinals:
	load_match_settings $0012 ; $42d6
	ret ; $42e3
LoadMatchSinglesOpenFinals:
	load_match_settings $0013 ; $42e4
	ret ; $42f1
LoadMatchDoublesOpenRound1:
	load_match_settings $0111 ; $42f2
	ret ; $42ff
LoadMatchDoublesOpenSemifinals:
	load_match_settings $0112 ; $4300
	ret ; $430d
LoadMatchDoublesOpenFinals:
	load_match_settings $0113 ; $430e
	ret ; $431b
LoadMatchSinglesJuniorPractice:
	load_match_settings $0000 ; $431c
	ret ; $4329
LoadMatchSinglesJunior1:
	load_match_settings $0004 ; $432a
	ret ; $4337
LoadMatchSinglesJunior2:
	load_match_settings $0003 ; $4338
	ret ; $4345
LoadMatchSinglesJunior3:
	load_match_settings $0002 ; $4346
	ret ; $4353
LoadMatchSinglesJunior4:
	load_match_settings $0001 ; $4354
	ret ; $4361
LoadMatchSinglesSenior1:
	load_match_settings $0009 ; $4362
	ret ; $436f
LoadMatchSinglesSenior2:
	load_match_settings $0008 ; $4370
	ret ; $437d
LoadMatchSinglesSenior3:
	load_match_settings $0007 ; $437e
	ret ; $438b
LoadMatchSinglesSenior4:
	load_match_settings $0006 ; $438c
	ret ; $4399
LoadMatchSinglesSeniorPractice:
	load_match_settings $0005 ; $439a
	ret ; $43a7
LoadMatchSinglesJunior3Alias:
	load_match_settings $0002 ; $43a8
	ret ; $43b5
LoadMatchSinglesVarsityPractice:
	load_match_settings $000a ; $43b6
	ret ; $43c3
LoadMatchDoublesJuniorPractice:
	load_match_settings $0100 ; $43c4
	ret ; $43d1
LoadMatchDoublesJunior3:
	load_match_settings $0102 ; $43d2
	ret ; $43df
LoadMatchDoublesJunior2:
	load_match_settings $0103 ; $43e0
	ret ; $43ed
LoadMatchDoublesJunior1:
	load_match_settings $0104 ; $43ee
	ret ; $43fb
LoadMatchDoublesSeniorPractice:
	load_match_settings $0105 ; $43fc
	ret ; $4409
LoadMatchDoublesSenior3:
	load_match_settings $0107 ; $440a
	ret ; $4417
LoadMatchDoublesSenior2:
	load_match_settings $0108 ; $4418
	ret ; $4425
LoadMatchDoublesSenior1:
	load_match_settings $0109 ; $4426
	ret ; $4433
LoadMatchDoublesVarsity2:
	load_match_settings $010d ; $4434
	ret ; $4441
LoadMatchDoublesVarsityPractice:
	load_match_settings $010a ; $4442
	ret ; $444f
RunDrillMatchListMenu:
	ld hl, Text_31_141 ; $4450
	ld a, $09 ; $4453
	farcall RunPagedTextMenu ; $4455
	cp $ff ; $4458
	jp z, RunDoublesMatchListMenu.done ; $445a
	push af ; $445d
	ld hl, wStoryModePlayersXPosition ; $445e
	ld de, wStoryModeSpawnPosition ; $4461
	ld bc, $0005 ; $4464
	call CopyMemoryBC ; $4467
	ld a, $ff ; $446a
	ld [wStoryModeEntryPoint], a ; $446c
	ld [wUnusedExitTriggerIdMirror], a ; $446f
	ld [wStoryModeExitTriggerRequest], a ; $4472
	ld a, $00 ; $4475
	ld [wCurrentStorySlot], a ; $4477
	farcall CheckStorySlot ; $447a
	pop af ; $447d
	set_flag FLAG_DRILL_FROM_MENU ; $447e
	farcall RunTrainingDrillByID ; $4481
	ld a, $00 ; $4484
	ld [wCurrentStorySlot], a ; $4486
	farcall SaveStorySlotWithTimer ; $4489
	ret ; $448c
MatchSelectCharDataOptionDisabled:
	script_set_text Text_25_164 ; $448d
	script_speak $80 ; $4493
	ret ; $4498
Unused_10_RunCharDataScreen:
	ld hl, wStoryModePlayersXPosition ; $4499
	ld de, wStoryModeSpawnPosition ; $449c
	ld bc, $0005 ; $449f
	call CopyMemoryBC ; $44a2
	ld a, $ff ; $44a5
	ld [wStoryModeEntryPoint], a ; $44a7
	ld [wUnusedExitTriggerIdMirror], a ; $44aa
	ld [wStoryModeExitTriggerRequest], a ; $44ad
	ld a, $00 ; $44b0
	ld [wCurrentStorySlot], a ; $44b2
	farcall CheckStorySlot ; $44b5
	set_flag FLAG_CHAR_DATA_START_EXITS ; $44b8
	ld c, $00 ; $44bb
	farcall CharDataScreen_Show ; $44bd
	clear_flag FLAG_CHAR_DATA_START_EXITS ; $44c0
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
	push_wram_bank $07 ; $44e1
	ld de, $0000 ; $44ea
	ld hl, wMinigameRecordValue ; $44ed
	ld a, [hl+] ; $44f0
	ld d, [hl] ; $44f1
	ld e, a ; $44f2
	ld a, $01 ; $44f3
	farcall UpdateMinigameRecord ; $44f5
	ld a, $00 ; $44f8
	farcall UpdateMinigameRecord ; $44fa
	pop_wram_bank ; $44fd
	ld l, c ; $4502
	ld h, b ; $4503
	ld a, l ; $4504
	sub e ; $4505
	ld l, a ; $4506
	ld a, h ; $4507
	sbc d ; $4508
	ld h, a ; $4509
	ld hl, Text_37_12 ; $450a
	ld de, $0101 ; $450d
	ld a, $01 ; $4510
	farcall RunPagedTextMenu ; $4512
	cp $ff ; $4515
	jp z, RunDoublesMatchListMenu.done ; $4517
	ld a, a ; $451a
	rst Rst00 ; $451b
	dw RunServiceLessonMenu ; $451c jumptable
	dw RunNetLessonMenu ; $451e jumptable
	dw RunStrokeLessonMenu ; $4520 jumptable
	dw ShowRankingBoardSamples ; $4522 jumptable
RunServiceLessonMenu:
	ld hl, Text_37_13 ; $4524
	ld de, $0101 ; $4527
	ld a, $01 ; $452a
	farcall RunPagedTextMenu ; $452c
	cp $ff ; $452f
	jp z, RunDoublesMatchListMenu.done ; $4531
	add MINIGAME_SERVICE_PRACTICE_1 ; $4534
	ld [wCurrentMinigameStoryMatch + 1], a ; $4536
	ld hl, wStoryModePlayersXPosition ; $4539
	ld de, wStoryModeSpawnPosition ; $453c
	ld bc, $0005 ; $453f
	call CopyMemoryBC ; $4542
	ld a, $ff ; $4545
	ld [wStoryModeEntryPoint], a ; $4547
	ld [wUnusedExitTriggerIdMirror], a ; $454a
	ld [wStoryModeExitTriggerRequest], a ; $454d
	ld c, $10 ; $4550
	call BeginFadeOut ; $4552
	call WaitFadeEnd ; $4555
	farcall ShowDrillBriefingScreen ; $4558
	ret ; $455b
RunNetLessonMenu:
	ld hl, Text_37_14 ; $455c
	ld de, $0101 ; $455f
	ld a, $01 ; $4562
	farcall RunPagedTextMenu ; $4564
	cp $ff ; $4567
	jp z, RunDoublesMatchListMenu.done ; $4569
	add MINIGAME_NET_GAME_PRACTICE_1 ; $456c
	ld [wCurrentMinigameStoryMatch + 1], a ; $456e
	ld hl, wStoryModePlayersXPosition ; $4571
	ld de, wStoryModeSpawnPosition ; $4574
	ld bc, $0005 ; $4577
	call CopyMemoryBC ; $457a
	ld a, $ff ; $457d
	ld [wStoryModeEntryPoint], a ; $457f
	ld [wUnusedExitTriggerIdMirror], a ; $4582
	ld [wStoryModeExitTriggerRequest], a ; $4585
	ld c, $10 ; $4588
	call BeginFadeOut ; $458a
	call WaitFadeEnd ; $458d
	farcall ShowDrillBriefingScreen ; $4590
	ret ; $4593
RunStrokeLessonMenu:
	ld hl, Text_37_15 ; $4594
	ld de, $0101 ; $4597
	ld a, $01 ; $459a
	farcall RunPagedTextMenu ; $459c
	cp $ff ; $459f
	jp z, RunDoublesMatchListMenu.done ; $45a1
	add MINIGAME_STROKE_PRACTICE_1 ; $45a4
	ld [wCurrentMinigameStoryMatch + 1], a ; $45a6
	ld hl, wStoryModePlayersXPosition ; $45a9
	ld de, wStoryModeSpawnPosition ; $45ac
	ld bc, $0005 ; $45af
	call CopyMemoryBC ; $45b2
	ld a, $ff ; $45b5
	ld [wStoryModeEntryPoint], a ; $45b7
	ld [wUnusedExitTriggerIdMirror], a ; $45ba
	ld [wStoryModeExitTriggerRequest], a ; $45bd
	ld c, $10 ; $45c0
	call BeginFadeOut ; $45c2
	call WaitFadeEnd ; $45c5
	farcall ShowDrillBriefingScreen ; $45c8
	ret ; $45cb
ShowRankingBoardSamples:
	ld hl, wStoryModePlayersXPosition ; $45cc
	ld de, wStoryModeSpawnPosition ; $45cf
	ld bc, $0005 ; $45d2
	call CopyMemoryBC ; $45d5
	ld a, $ff ; $45d8
	ld [wStoryModeEntryPoint], a ; $45da
	ld [wUnusedExitTriggerIdMirror], a ; $45dd
	ld [wStoryModeExitTriggerRequest], a ; $45e0
	ld c, $10 ; $45e3
	call BeginFadeOut ; $45e5
	call WaitFadeEnd ; $45e8
	call ClearFrameTasks ; $45eb
	xor a ; $45ee
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
	xor a ; $4609
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
	xor a ; $4624
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
	ld hl, Text_31_150 ; $4640
	ld a, $03 ; $4643
	farcall RunPagedTextMenu ; $4645
	cp $ff ; $4648
	jp z, RunDoublesMatchListMenu.done ; $464a
	ld de, MinigameSelectMenuTable ; $464d
	add e ; $4650
	ld e, a ; $4651
	jr nc, .runPagedTextMenu ; $4652
	inc d ; $4654
.runPagedTextMenu:
	ld hl, Text_31_153 ; $4655
	ld a, $01 ; $4658
	farcall RunPagedTextMenu ; $465a
	cp $ff ; $465d
	jp z, RunMinigameSelectMenu ; $465f
	ld [wMinigameLevel], a ; $4662
	ld a, [de] ; $4665
	set_flag FLAG_DRILL_FROM_MENU ; $4666
	farcall RunTrainingDrillByID ; $4669
	ld hl, wStoryModePlayersXPosition ; $466c
	ld de, wStoryModeSpawnPosition ; $466f
	ld bc, $0005 ; $4672
	call CopyMemoryBC ; $4675
	ld a, $ff ; $4678
	ld [wStoryModeEntryPoint], a ; $467a
	ld [wUnusedExitTriggerIdMirror], a ; $467d
	ld [wStoryModeExitTriggerRequest], a ; $4680
	ret ; $4683
MinigameSelectMenuTable:
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
	map_actor $0000, ActorScript_10_2, $0500, $0f00, FACE_DOWN, $55, $01, $00
	map_actor $0000, ActorScript_10_2, $0500, $0500, FACE_DOWN, $27, $01, $07
	map_actor $0000, ActorScript_10_2, $0500, $0300, FACE_DOWN, $26, $01, $00
	map_actor $0000, ActorScript_10_2, $0500, $0900, FACE_DOWN, $29, $01, $05
	map_actor $0000, ActorScript_10_2, $0500, $0700, FACE_DOWN, $28, $01, $00
	map_actor $0000, ActorScript_10_2, $0500, $0d00, FACE_DOWN, $2a, $01, $07
	map_actor $0000, ActorScript_10_2, $0500, $0b00, FACE_DOWN, $2d, $01, $00
	map_actor $0000, ActorScript_10_2, $0500, $1100, FACE_DOWN, $2b, $01, $00
	map_actor $0000, ActorScript_10_2, $0d00, $0300, FACE_DOWN, $2f, $01, $00
	map_actor $0000, ActorScript_10_2, $0d00, $0500, FACE_DOWN, $2f, $01, $07
	map_actor $0000, ActorScript_10_2, $0d00, $0700, FACE_DOWN, $30, $01, $00
	map_actor $0000, ActorScript_10_2, $0d00, $0900, FACE_DOWN, $30, $01, $05
	map_actor $0000, ActorScript_10_2, $0d00, $0b00, FACE_DOWN, $2f, $01, $00
	map_actor $0000, ActorScript_10_2, $0d00, $0d00, FACE_DOWN, $2f, $01, $07
	map_actor $0000, ActorScript_10_2, $0d00, $0f00, FACE_DOWN, $30, $01, $00
	map_actor $0000, ActorScript_10_2, $0d00, $1100, FACE_DOWN, $30, $01, $00
	map_actor_end
Test2EntryPoints_10:
	; $4785, 9 bytes (map_entries)
	map_entry $01, FACE_DOWN, $0900, $0d00, $0000
	db $ff
Test2ExitTriggers_10:
	; $478e, 65 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_TRAINING_COURT, $0b
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_TRAINING_COURT, $0c
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_TRAINING_COURT, $0d
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_JUNIOR_CLASS_COURT_SINGLES, $0f
	map_script $05, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_JUNIOR_CLASS_COURT_DOUBLES, $0f
	map_script $06, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_SENIOR_CLASS_COURT, $01
	map_script $07, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_COURTYARD, $01
	map_script $08, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_MAIN_MENU, $01
	db $ff
	ld hl, wStoryModePlayersXPosition ; $47cf
	ld de, wStoryModeSpawnPosition ; $47d2
	ld bc, $0005 ; $47d5
	call CopyMemoryBC ; $47d8
	ld a, $ff ; $47db
	ld [wStoryModeEntryPoint], a ; $47dd
	ld [wUnusedExitTriggerIdMirror], a ; $47e0
	ld [wStoryModeExitTriggerRequest], a ; $47e3
	set_flag FLAG_DRILL_FROM_MENU ; $47e6
	ld hl, $0001 ; $47e9
	farcall PushTextArgNumber ; $47ec
	script_set_text Text_30_353 ; $47ef
	script_speak $80 ; $47f5
	ld a, MINIGAME_SERVICE_MATCH_2 ; $47fa
	farcall RunTrainingDrillByID ; $47fc
	ret ; $47ff
; Test2Npc0B_10 with actor $04 in its two operands: one of seven identical template handlers for the Test 2 debug map's NPCs. No NpcScripts record points at it.
Unused_10_Test2Npc04:
	ld hl, wStoryModePlayersXPosition ; $4800
	ld de, wStoryModeSpawnPosition ; $4803
	ld bc, $0005 ; $4806
	call CopyMemoryBC ; $4809
	ld a, $ff ; $480c
	ld [wStoryModeEntryPoint], a ; $480e
	ld [wUnusedExitTriggerIdMirror], a ; $4811
	ld [wStoryModeExitTriggerRequest], a ; $4814
	set_flag FLAG_DRILL_FROM_MENU ; $4817
	ld hl, $0002 ; $481a
	farcall PushTextArgNumber ; $481d
	script_set_text Text_30_353 ; $4820
	script_speak $80 ; $4826
	ld a, MINIGAME_SERVICE_MATCH_3 ; $482b
	farcall RunTrainingDrillByID ; $482d
	ret ; $4830
; Test2Npc0B_10 with actor $05 in its two operands: one of seven identical template handlers for the Test 2 debug map's NPCs. No NpcScripts record points at it.
Unused_10_Test2Npc05:
	ld hl, wStoryModePlayersXPosition ; $4831
	ld de, wStoryModeSpawnPosition ; $4834
	ld bc, $0005 ; $4837
	call CopyMemoryBC ; $483a
	ld a, $ff ; $483d
	ld [wStoryModeEntryPoint], a ; $483f
	ld [wUnusedExitTriggerIdMirror], a ; $4842
	ld [wStoryModeExitTriggerRequest], a ; $4845
	set_flag FLAG_DRILL_FROM_MENU ; $4848
	ld hl, $0003 ; $484b
	farcall PushTextArgNumber ; $484e
	script_set_text Text_30_353 ; $4851
	script_speak $80 ; $4857
	ld a, MINIGAME_SERVICE_PRACTICE_1 ; $485c
	farcall RunTrainingDrillByID ; $485e
	ret ; $4861
; Test2Npc0B_10 with actor $06 in its two operands: one of seven identical template handlers for the Test 2 debug map's NPCs. No NpcScripts record points at it.
Unused_10_Test2Npc06:
	ld hl, wStoryModePlayersXPosition ; $4862
	ld de, wStoryModeSpawnPosition ; $4865
	ld bc, $0005 ; $4868
	call CopyMemoryBC ; $486b
	ld a, $ff ; $486e
	ld [wStoryModeEntryPoint], a ; $4870
	ld [wUnusedExitTriggerIdMirror], a ; $4873
	ld [wStoryModeExitTriggerRequest], a ; $4876
	set_flag FLAG_DRILL_FROM_MENU ; $4879
	ld hl, $0004 ; $487c
	farcall PushTextArgNumber ; $487f
	script_set_text Text_30_353 ; $4882
	script_speak $80 ; $4888
	ld a, MINIGAME_SERVICE_PRACTICE_2 ; $488d
	farcall RunTrainingDrillByID ; $488f
	ret ; $4892
; Test2Npc0B_10 with actor $07 in its two operands: one of seven identical template handlers for the Test 2 debug map's NPCs. No NpcScripts record points at it.
Unused_10_Test2Npc07:
	ld hl, wStoryModePlayersXPosition ; $4893
	ld de, wStoryModeSpawnPosition ; $4896
	ld bc, $0005 ; $4899
	call CopyMemoryBC ; $489c
	ld a, $ff ; $489f
	ld [wStoryModeEntryPoint], a ; $48a1
	ld [wUnusedExitTriggerIdMirror], a ; $48a4
	ld [wStoryModeExitTriggerRequest], a ; $48a7
	set_flag FLAG_DRILL_FROM_MENU ; $48aa
	ld hl, $0005 ; $48ad
	farcall PushTextArgNumber ; $48b0
	script_set_text Text_30_353 ; $48b3
	script_speak $80 ; $48b9
	ld a, MINIGAME_SERVICE_PRACTICE_3 ; $48be
	farcall RunTrainingDrillByID ; $48c0
	ret ; $48c3
; Test2Npc0B_10 with actor $08 in its two operands: one of seven identical template handlers for the Test 2 debug map's NPCs. No NpcScripts record points at it.
Unused_10_Test2Npc08:
	ld hl, wStoryModePlayersXPosition ; $48c4
	ld de, wStoryModeSpawnPosition ; $48c7
	ld bc, $0005 ; $48ca
	call CopyMemoryBC ; $48cd
	ld a, $ff ; $48d0
	ld [wStoryModeEntryPoint], a ; $48d2
	ld [wUnusedExitTriggerIdMirror], a ; $48d5
	ld [wStoryModeExitTriggerRequest], a ; $48d8
	set_flag FLAG_DRILL_FROM_MENU ; $48db
	ld hl, $0006 ; $48de
	farcall PushTextArgNumber ; $48e1
	script_set_text Text_30_353 ; $48e4
	script_speak $80 ; $48ea
	ld a, MINIGAME_NET_GAME_MATCH_1 ; $48ef
	farcall RunTrainingDrillByID ; $48f1
	ret ; $48f4
; Test2Npc0B_10 with actor $09 in its two operands: one of seven identical template handlers for the Test 2 debug map's NPCs. No NpcScripts record points at it.
Unused_10_Test2Npc09:
	ld hl, wStoryModePlayersXPosition ; $48f5
	ld de, wStoryModeSpawnPosition ; $48f8
	ld bc, $0005 ; $48fb
	call CopyMemoryBC ; $48fe
	ld a, $ff ; $4901
	ld [wStoryModeEntryPoint], a ; $4903
	ld [wUnusedExitTriggerIdMirror], a ; $4906
	ld [wStoryModeExitTriggerRequest], a ; $4909
	set_flag FLAG_DRILL_FROM_MENU ; $490c
	ld hl, $0007 ; $490f
	farcall PushTextArgNumber ; $4912
	script_set_text Text_30_353 ; $4915
	script_speak $80 ; $491b
	ld a, MINIGAME_NET_GAME_MATCH_2 ; $4920
	farcall RunTrainingDrillByID ; $4922
	ret ; $4925
; Test2Npc0B_10 with actor $0a in its two operands: one of seven identical template handlers for the Test 2 debug map's NPCs. No NpcScripts record points at it.
Unused_10_Test2Npc0A:
	ld hl, wStoryModePlayersXPosition ; $4926
	ld de, wStoryModeSpawnPosition ; $4929
	ld bc, $0005 ; $492c
	call CopyMemoryBC ; $492f
	ld a, $ff ; $4932
	ld [wStoryModeEntryPoint], a ; $4934
	ld [wUnusedExitTriggerIdMirror], a ; $4937
	ld [wStoryModeExitTriggerRequest], a ; $493a
	set_flag FLAG_DRILL_FROM_MENU ; $493d
	ld hl, $0008 ; $4940
	farcall PushTextArgNumber ; $4943
	script_set_text Text_30_353 ; $4946
	script_speak $80 ; $494c
	ld a, MINIGAME_NET_GAME_MATCH_3 ; $4951
	farcall RunTrainingDrillByID ; $4953
	ret ; $4956
Test2Npc0B_10:
	ld hl, wStoryModePlayersXPosition ; $4957
	ld de, wStoryModeSpawnPosition ; $495a
	ld bc, $0005 ; $495d
	call CopyMemoryBC ; $4960
	ld a, $ff ; $4963
	ld [wStoryModeEntryPoint], a ; $4965
	ld [wUnusedExitTriggerIdMirror], a ; $4968
	ld [wStoryModeExitTriggerRequest], a ; $496b
	set_flag FLAG_DRILL_FROM_MENU ; $496e
	ld hl, $0009 ; $4971
	farcall PushTextArgNumber ; $4974
	script_set_text Text_30_353 ; $4977
	script_speak $80 ; $497d
	ld a, MINIGAME_NET_GAME_PRACTICE_1 ; $4982
	farcall RunTrainingDrillByID ; $4984
	ret ; $4987
Test2Npc0C_10:
	ld hl, wStoryModePlayersXPosition ; $4988
	ld de, wStoryModeSpawnPosition ; $498b
	ld bc, $0005 ; $498e
	call CopyMemoryBC ; $4991
	ld a, $ff ; $4994
	ld [wStoryModeEntryPoint], a ; $4996
	ld [wUnusedExitTriggerIdMirror], a ; $4999
	ld [wStoryModeExitTriggerRequest], a ; $499c
	set_flag FLAG_DRILL_FROM_MENU ; $499f
	ld hl, $000a ; $49a2
	farcall PushTextArgNumber ; $49a5
	script_set_text Text_30_353 ; $49a8
	script_speak $80 ; $49ae
	ld a, MINIGAME_NET_GAME_PRACTICE_2 ; $49b3
	farcall RunTrainingDrillByID ; $49b5
	ret ; $49b8
Test2Npc0D_10:
	ld hl, wStoryModePlayersXPosition ; $49b9
	ld de, wStoryModeSpawnPosition ; $49bc
	ld bc, $0005 ; $49bf
	call CopyMemoryBC ; $49c2
	ld a, $ff ; $49c5
	ld [wStoryModeEntryPoint], a ; $49c7
	ld [wUnusedExitTriggerIdMirror], a ; $49ca
	ld [wStoryModeExitTriggerRequest], a ; $49cd
	set_flag FLAG_DRILL_FROM_MENU ; $49d0
	ld hl, $000b ; $49d3
	farcall PushTextArgNumber ; $49d6
	script_set_text Text_30_353 ; $49d9
	script_speak $80 ; $49df
	ld a, MINIGAME_NET_GAME_PRACTICE_3 ; $49e4
	farcall RunTrainingDrillByID ; $49e6
	ret ; $49e9
Test2Npc0E_10:
	ld hl, wStoryModePlayersXPosition ; $49ea
	ld de, wStoryModeSpawnPosition ; $49ed
	ld bc, $0005 ; $49f0
	call CopyMemoryBC ; $49f3
	ld a, $ff ; $49f6
	ld [wStoryModeEntryPoint], a ; $49f8
	ld [wUnusedExitTriggerIdMirror], a ; $49fb
	ld [wStoryModeExitTriggerRequest], a ; $49fe
	set_flag FLAG_DRILL_FROM_MENU ; $4a01
	ld hl, $000c ; $4a04
	farcall PushTextArgNumber ; $4a07
	script_set_text Text_30_353 ; $4a0a
	script_speak $80 ; $4a10
	ld a, MINIGAME_STROKE_MATCH_1 ; $4a15
	farcall RunTrainingDrillByID ; $4a17
	ret ; $4a1a
Test2Npc0F_10:
	ld hl, wStoryModePlayersXPosition ; $4a1b
	ld de, wStoryModeSpawnPosition ; $4a1e
	ld bc, $0005 ; $4a21
	call CopyMemoryBC ; $4a24
	ld a, $ff ; $4a27
	ld [wStoryModeEntryPoint], a ; $4a29
	ld [wUnusedExitTriggerIdMirror], a ; $4a2c
	ld [wStoryModeExitTriggerRequest], a ; $4a2f
	set_flag FLAG_DRILL_FROM_MENU ; $4a32
	ld hl, $000d ; $4a35
	farcall PushTextArgNumber ; $4a38
	script_set_text Text_30_353 ; $4a3b
	script_speak $80 ; $4a41
	ld a, MINIGAME_STROKE_MATCH_2 ; $4a46
	farcall RunTrainingDrillByID ; $4a48
	ret ; $4a4b
Test2Npc10_10:
	ld hl, wStoryModePlayersXPosition ; $4a4c
	ld de, wStoryModeSpawnPosition ; $4a4f
	ld bc, $0005 ; $4a52
	call CopyMemoryBC ; $4a55
	ld a, $ff ; $4a58
	ld [wStoryModeEntryPoint], a ; $4a5a
	ld [wUnusedExitTriggerIdMirror], a ; $4a5d
	ld [wStoryModeExitTriggerRequest], a ; $4a60
	set_flag FLAG_DRILL_FROM_MENU ; $4a63
	ld hl, $000e ; $4a66
	farcall PushTextArgNumber ; $4a69
	script_set_text Text_30_353 ; $4a6c
	script_speak $80 ; $4a72
	ld a, MINIGAME_STROKE_MATCH_3 ; $4a77
	farcall RunTrainingDrillByID ; $4a79
	ret ; $4a7c
Test2Npc11_10:
	ld hl, wStoryModePlayersXPosition ; $4a7d
	ld de, wStoryModeSpawnPosition ; $4a80
	ld bc, $0005 ; $4a83
	call CopyMemoryBC ; $4a86
	ld a, $ff ; $4a89
	ld [wStoryModeEntryPoint], a ; $4a8b
	ld [wUnusedExitTriggerIdMirror], a ; $4a8e
	ld [wStoryModeExitTriggerRequest], a ; $4a91
	set_flag FLAG_DRILL_FROM_MENU ; $4a94
	ld hl, $000f ; $4a97
	farcall PushTextArgNumber ; $4a9a
	script_set_text Text_30_353 ; $4a9d
	script_speak $80 ; $4aa3
	ld a, MINIGAME_STROKE_PRACTICE_1 ; $4aa8
	farcall RunTrainingDrillByID ; $4aaa
	ret ; $4aad
Test2Npc12_10:
	ld hl, wStoryModePlayersXPosition ; $4aae
	ld de, wStoryModeSpawnPosition ; $4ab1
	ld bc, $0005 ; $4ab4
	call CopyMemoryBC ; $4ab7
	ld a, $ff ; $4aba
	ld [wStoryModeEntryPoint], a ; $4abc
	ld [wUnusedExitTriggerIdMirror], a ; $4abf
	ld [wStoryModeExitTriggerRequest], a ; $4ac2
	set_flag FLAG_DRILL_FROM_MENU ; $4ac5
	ld hl, $0010 ; $4ac8
	farcall PushTextArgNumber ; $4acb
	script_set_text Text_30_353 ; $4ace
	script_speak $80 ; $4ad4
	ld a, MINIGAME_STROKE_PRACTICE_2 ; $4ad9
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
	cp $0f ; $4b9e
	ret z ; $4ba0
	farcall ClearStatusSetupMenuEntry ; $4ba1
	ld a, a ; $4ba4
	ld [wUnusedExitTriggerIdMirror], a ; $4ba5
	ld [wStoryModeExitTriggerRequest], a ; $4ba8
	ret ; $4bab
Unused_10_RunWaterSpriteMinigame:
	farcall InitMinigameMatchSettings ; $4bac
	ld a, COURT_GRASS ; $4baf
	ld [wCurrentlyUsedCourt], a ; $4bb1
	ld a, $02 ; $4bb4
	ld [wOnCourtCharCount], a ; $4bb6
	ldh a, [hRomBank] ; $4bb9
	ld de, WaterSpriteModeHooks_10 ; $4bbb
	farcall SetModeHookTable ; $4bbe
	ld de, Test2InitScriptMinigamePointTable_10 ; $4bc1
	farcall SetMinigamePointTable ; $4bc4
	ld a, CHAR_MARIO ; $4bc7
	ld [wMatchPlayerChar], a ; $4bc9
	ld a, CHAR_ALLIE ; $4bcc
	ld [wMatchOpponentChar], a ; $4bce
	farcall RunN64ExhibData ; $4bd1
	farcall RunMinigameMatch ; $4bd4
	ret ; $4bd7
WaterSpriteModeHooks_10:
	; $4bd8, 16 bytes (mode_hooks)
	dw WaterSpriteHook_Frame ; record 0
	dw WaterSpriteHook_PointStart ; record 1
	dw WaterSpriteHook_PointEnd ; record 2
	dw RetStub ; record 3
	dw WaterSpriteHook_BallHit ; record 4
	dw WaterSpriteHook_Bounce ; record 5
	dw WaterSpriteHook_RallyTick ; record 6
	dw RetStub ; record 7
WaterSpriteHook_Frame:
	ret ; $4be8
WaterSpriteHook_RallyTick:
	ret ; $4be9
WaterSpriteHook_Bounce:
	ret ; $4bea
WaterSpriteHook_BallHit:
	ld a, [wRallyLength] ; $4beb
	cp $02 ; $4bee
	jr c, .done ; $4bf0
	ld a, MATCHABORT_POINT ; $4bf2
	ld [wMatchAbortFlag], a ; $4bf4
	ld hl, wTotalPointsScoredInCurrentGame ; $4bf7
	inc [hl] ; $4bfa
.done:
	ret ; $4bfb
WaterSpriteHook_PointStart:
	ret ; $4bfc
WaterSpriteHook_PointEnd:
	ld a, [wTotalPointsScoredInCurrentGame] ; $4bfd
	bit 0, a ; $4c00
	ret nz ; $4c02
	ld a, [wCharacter1ServiceAces] ; $4c03
	ld hl, wCharacter2ServiceAces ; $4c06
	cp [hl] ; $4c09
	jr nz, .storeMatchAbortFlag ; $4c0a
	ret ; $4c0c
.storeMatchAbortFlag:
	ld a, MATCHABORT_MATCH ; $4c0d
	ld [wMatchAbortFlag], a ; $4c0f
	ret ; $4c12
Test2InitScriptMinigamePointTable_10:
	; $4c13, 184 bytes (bytes:4)
	db $00, $03, $09, $09 ; 0x00
	db $00, $01, $09, $09 ; 0x04
	db $03, $00, $09, $09 ; 0x08
	db $01, $00, $09, $09 ; 0x0c
	db $01, $02, $09, $09 ; 0x10
	db $00, $01, $09, $09 ; 0x14
	db $02, $01, $09, $09 ; 0x18
	db $01, $00, $09, $09 ; 0x1c
	db $03, $00, $09, $09 ; 0x20
	db $00, $01, $09, $09 ; 0x24
	db $00, $03, $09, $09 ; 0x28
	db $01, $00, $09, $09 ; 0x2c
	db $02, $01, $09, $09 ; 0x30
	db $00, $01, $09, $09 ; 0x34
	db $01, $02, $09, $09 ; 0x38
	db $01, $00, $09, $09 ; 0x3c
	db $ff, $f0, $94, $e6 ; 0x40
	db $03, $57, $21, $b4 ; 0x44
	db $c2, $7e, $b7, $72 ; 0x48
	db $20, $1d, $7a, $b7 ; 0x4c
	db $28, $19, $21, $b2 ; 0x50
	db $c2, $2a, $56, $5f ; 0x54
	db $13, $21, $b2, $c2 ; 0x58
	db $7b, $22, $72, $e5 ; 0x5c
	db $d5, $62, $6b, $11 ; 0x60
	db $04, $0f, $cd, $ce ; 0x64
	db $1a, $d1, $e1, $21 ; 0x68
	db $b0, $c2, $2a, $56 ; 0x6c
	db $5f, $1b, $7a, $b3 ; 0x70
	db $28, $0c, $21, $b0 ; 0x74
	db $c2, $7b, $22, $72 ; 0x78
	db $3e, $01, $ea, $b5 ; 0x7c
	db $c2, $c9, $21, $54 ; 0x80
	db $4c, $cd, $cb, $1b ; 0x84
	db $af, $ea, $b5, $c2 ; 0x88
	db $c9, $cf, $74, $11 ; 0x8c
	db $58, $02, $21, $b0 ; 0x90
	db $c2, $7b, $22, $72 ; 0x94
	db $21, $b2, $c2, $af ; 0x98
	db $22, $22, $22, $22 ; 0x9c
	db $3e, $01, $21, $54 ; 0xa0
	db $4c, $cd, $6a, $1b ; 0xa4
	db $cd, $31, $26, $fa ; 0xa8
	db $b5, $c2, $b7, $20 ; 0xac
	db $f7, $cf, $75, $cd ; 0xb0
	db $25, $27, $78, $c9 ; 0xb4
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
	; $4cd9, 10 bytes (map_actors)
	map_actor_end
DevelopmentRespawnActorList_10:
	; $4ce3, 10 bytes (map_actors)
	map_actor_end
DevelopmentEntryPoints_10:
	; $4ced, 9 bytes (map_entries)
	map_entry $01, FACE_DOWN, $0900, $0900, $0000
	db $ff
DevelopmentExitTriggers_10:
	; $4cf6, 9 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_DEVELOPMENT, $01
	db $ff
DevelopmentRespawnActors_10:
	ld c, $10 ; $4cff
	call BeginFadeOut ; $4d01
	call WaitFadeEnd ; $4d04
	ldh a, [hRomBank] ; $4d07
	ld hl, DevelopmentRespawnActorList_10 ; $4d09
	farcall ScriptRespawnLocationActors ; $4d0c
	script_fade_in $10 ; $4d0f
	call WaitFadeEnd ; $4d14
	ret ; $4d17
Unused_10_DevelopmentMoveActorsAndExit:
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
	ld [wUnusedExitTriggerIdMirror], a ; $4d69
	ld [wStoryModeExitTriggerRequest], a ; $4d6c
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
Unused_10_SpeakCheckedChest:
	farcall BeginCutsceneScriptMode ; $4d89
	script_set_text Text_30_1 ; $4d8c
	script_speak ACTOR_PLAYER ; $4d92
	farcall EndCutsceneScriptMode ; $4d97
	ret ; $4d9a
StubNop_10_0:
	ret ; $4d9b
StubNop_10_1:
	ret ; $4d9c
StubNop_10_2:
	ret ; $4d9d
StubNop_10_3:
	ret ; $4d9e
StubNop_10_4:
	ret ; $4d9f
StubNop_10_5:
	ret ; $4da0
StubNop_10_6:
	ret ; $4da1
StubNop_10_7:
	ret ; $4da2
StubNop_10_8:
	ret ; $4da3
StubNop_10_9:
	ret ; $4da4
StubNop_10_10:
	ret ; $4da5
Unused_10_RequestExitTrigger0e:
	ld a, $0e ; $4da6
	ld [wUnusedExitTriggerIdMirror], a ; $4da8
	ld [wStoryModeExitTriggerRequest], a ; $4dab
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
	; $4e8d, 41 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_ACADEMY_ENTRANCE, $0f
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_DORM_ROOM, $01
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_TEST_2, $01
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_ACADEMY_WING, $0f
	map_script $05, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_PEACHS_CASTLE, $0f
	db $ff
MainMenuNpcScripts_10:
	ds 1, $ff ; $4eb6, fill
MainMenuFacingScripts_10:
	ds 1, $ff ; $4eb7, fill
MainMenuTileTriggers_10:
	ds 1, $ff ; $4eb8, fill
MainMenuInitScript_10:
	script_set_position ACTOR_PLAYER, $3f00, $3f00 ; $4eb9
	call RunTitleAndMainMenuLoop ; $4ec4
	farcall TestStorySlotFlagA ; $4ec7
	call SetMusicMuted ; $4eca
	ret ; $4ecd
ApplyMatchTypeSettings:
	ld hl, MatchTypeSettingsTable0 ; $4ece
	ld a, [wMatchFormatSets] ; $4ed1
	add l ; $4ed4
	ld l, a ; $4ed5
	jr nc, .readSets ; $4ed6
	inc h ; $4ed8
.readSets:
	ld a, [hl] ; $4ed9
	ld [wMatchTypeNumberOfSets], a ; $4eda
	ld hl, MatchTypeSettingsTable1 ; $4edd
	ld a, [wMatchFormatGames] ; $4ee0
	add l ; $4ee3
	ld l, a ; $4ee4
	jr nc, .readGames ; $4ee5
	inc h ; $4ee7
.readGames:
	ld a, [hl] ; $4ee8
	ld [wMatchTypeNumberOfGames], a ; $4ee9
	ld a, [wMatchFormatDoubles] ; $4eec
	ld [wMatchIsDoubles], a ; $4eef
	or a ; $4ef2
	jr z, .singles ; $4ef3
	ld a, $04 ; $4ef5
	ld [wOnCourtCharCount], a ; $4ef7
	set_flag FLAG_DOUBLES ; $4efa
	jr .done ; $4efd
.singles:
	ld a, $02 ; $4eff
	ld [wOnCourtCharCount], a ; $4f01
	clear_flag FLAG_DOUBLES ; $4f04
.done:
	ret ; $4f07
MatchTypeSettingsTable0:
	; $4f08, 3 bytes (bytes:16)
	db $01, $03, $05 ; 0x00
MatchTypeSettingsTable1:
	db $02 ; $4f0b
	db $06 ; $4f0c
RunTitleAndMainMenuLoop:
	call ClearFrameTasks ; $4f0d
	sound BGM_NONE ; $4f10
	call ResumeBGM ; $4f12
	ld a, [wStoryModeEntryPoint] ; $4f15
	cp $0a ; $4f18
	jr nz, .newGame ; $4f1a
	call ClearFrameTasks ; $4f1c
	sound BGM_NONE ; $4f1f
	call ResumeBGM ; $4f21
	xor a ; $4f24
	ld [wCheatUnlockTriggered], a ; $4f25
.intro:
	farcall ShowIntroLogoScreen ; $4f28
	farcall ScrollOutIntroLogo ; $4f2b
	farcall RunIntroCutscene ; $4f2e
.titleScreen:
	farcall RunTitleScreen ; $4f31
	cp $ff ; $4f34
	jr z, .intro ; $4f36
	cp $01 ; $4f38
	jr z, .intro ; $4f3a
.newGame:
	farcall InitDefaultMatchSettings ; $4f3c
	xor a ; $4f3f
	ld [wMainMenuCursor], a ; $4f40
	ld [wSavedDataMenuCursor], a ; $4f43
	ld [wN64TransferMenuCursor], a ; $4f46
	ld [wSubMenuCursor], a ; $4f49
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
.redrawMenu:
	call DisableLCDSafely ; $4f68
	farcall LoadMenuFontGfx ; $4f6b
	farcall ResetScreenAndTextWindows ; $4f6e
	call EnableLCD ; $4f71
	script_fade_in $10 ; $4f74
	call WaitFadeEnd ; $4f79
.menuLoop:
	xor a ; $4f7c
	ld [wUnusedMenuCursor], a ; $4f7d
	ld [wSavedDataMenuCursor], a ; $4f80
	ld [wN64TransferMenuCursor], a ; $4f83
	ld [wSubMenuCursor], a ; $4f86
	ld [wMatchFormatDoubles], a ; $4f89
	ld [wMatchFormatGames], a ; $4f8c
	ld [wMatchFormatSets], a ; $4f8f
	ld [wAnimatedTileSet], a ; $4f92
	ldh [hScrollX], a ; $4f95
	ldh [hScrollY], a ; $4f97
	ld [wCameraX], a ; $4f99
	ld [wCameraX + 1], a ; $4f9c
	ld [wCameraY], a ; $4f9f
	ld [wCameraY + 1], a ; $4fa2
	ld a, $03 ; $4fa5
	ld [wAnimatedTilePeriod], a ; $4fa7
	call ResumeBGM ; $4faa
	call InitSerialLink ; $4fad
	farcall RunMainMenu ; $4fb0
	cp $ff ; $4fb3
	jp z, .titleScreen ; $4fb5
	ld e, a ; $4fb8
	ld hl, MatchSelectHandlersB_10 ; $4fb9
	add a ; $4fbc
	add l ; $4fbd
	ld l, a ; $4fbe
	jr nc, .done ; $4fbf
	inc h ; $4fc1
.done:
	ld a, [hl+] ; $4fc2
	ld h, [hl] ; $4fc3
	ld l, a ; $4fc4
	jp hl ; $4fc5
MatchSelectHandlersB_10:
	; $4fc6, 18 bytes (records:2)
	dw MatchSelectHandlersBHandler0 ; record 0
	dw MatchSelectHandlersBHandler0 ; record 1
	dw MatchSelectHandlersBHandler0 ; record 2
	dw MatchSelectHandlersBHandler3 ; record 3
	dw RunMinigameModeFlow ; record 4
	dw MatchSelectHandlersBHandler5 ; record 5
	dw RunSavedDataMenuFlow ; record 6
	dw MatchSelectHandlersBHandler7 ; record 7
	dw RunEraseSavedDataFlow ; record 8
MatchSelectHandlersBHandler0:
	ld a, e ; $4fd8
	cp $ff ; $4fd9
	jr z, .backToTitle ; $4fdb
	and $7f ; $4fdd
	ld [wCurrentStorySlot], a ; $4fdf
	farcall CheckStorySlot ; $4fe2
	cp $fe ; $4fe5
	jr z, .backToTitle ; $4fe7
	farcall ApplyPendingExpAwards ; $4fe9
	or a ; $4fec
	jr z, .checkMatchResult ; $4fed
	call DisableLCDSafely ; $4fef
	farcall ResetScreenAndTextWindows ; $4ff2
	call EnableLCD ; $4ff5
	ld a, [wSaveAndQuitRequest] ; $4ff8
	or a ; $4ffb
	jr nz, .checkMatchResult ; $4ffc
	script_fade_in $10 ; $4ffe
	call WaitFadeEnd ; $5003
.checkMatchResult:
	ld a, [wSaveAndQuitRequest] ; $5006
	or a ; $5009
	jp z, .clearMatchState ; $500a
	ld c, $00 ; $500d
	farcall ShowMatchResultsScreen ; $500f
	push af ; $5012
	call RestoreGameTimer ; $5013
	pop af ; $5016
	or a ; $5017
	jp z, .resetScreen ; $5018
	cp $ff ; $501b
	jp z, RunTitleAndMainMenuLoop.redrawMenu ; $501d
	xor a ; $5020
	ld [wSaveAndQuitRequest], a ; $5021
	farcall SaveStorySlotWithTimer ; $5024
	ld a, [wKeepMatchStatsFlag] ; $5027
	or a ; $502a
	jr z, .restoreReturnPoint ; $502b
	jp EraseSavedDataFlowHandler4_10.runMatch ; $502d
.restoreReturnPoint:
	farcall RestoreStoryReturnPoint ; $5030
	ld b, STORYLOC_DORM_ROOM ; $5033
	ld c, $01 ; $5035
	farcall SaveStoryReturnPoint ; $5037
	farcall SaveStorySlotWithTimer ; $503a
	farcall EndCutsceneScriptMode ; $503d
	ret ; $5040
.backToTitle:
	ld a, $03 ; $5041
	ld [wAnimatedTilePeriod], a ; $5043
	ld c, $10 ; $5046
	call BeginFadeOut ; $5048
	call WaitFadeEnd ; $504b
	ld a, e ; $504e
	ld [wCurrentStorySlot], a ; $504f
	farcall RunNewGameSetup ; $5052
	cp $ff ; $5055
	jp nz, .newStorySlot ; $5057
	ld a, $00 ; $505a
	ld [wMenuSlideDirection], a ; $505c
	call DisableLCDSafely ; $505f
	farcall LoadMenuFontGfx ; $5062
	farcall ResetScreenAndTextWindows ; $5065
	call EnableLCD ; $5068
	script_fade_in $10 ; $506b
	jp RunTitleAndMainMenuLoop.menuLoop ; $5070
.newStorySlot:
	call ResetGameTimer ; $5073
	farcall GenerateUniqueStorySaveSignature ; $5076
	farcall SaveStorySlotWithTimer ; $5079
	test_flag FLAG_DEBUG_SKIP_LOCATION_EXIT ; $507c
	jr nz, .exitToLocation3 ; $507f
	ld a, $01 ; $5081
	ld [wUnusedExitTriggerIdMirror], a ; $5083
	ld [wStoryModeExitTriggerRequest], a ; $5086
	ret ; $5089
.exitToLocation3:
	ld a, $03 ; $508a
	ld [wUnusedExitTriggerIdMirror], a ; $508c
	ld [wStoryModeExitTriggerRequest], a ; $508f
	ret ; $5092
.resetScreen:
	call DisableLCDSafely ; $5093
	farcall ResetScreenAndTextWindows ; $5096
	call EnableLCD ; $5099
	script_fade_in $10 ; $509c
	call WaitFadeEnd ; $50a1
.clearMatchState:
	xor a ; $50a4
	ld [wSaveAndQuitRequest], a ; $50a5
	ld [wKeepMatchStatsFlag], a ; $50a8
	call RestoreGameTimer ; $50ab
	farcall SaveStorySlotWithTimer ; $50ae
	call GetStoryContinueDestination ; $50b1
	ld [wMatchSelectSubState], a ; $50b4
	cp $04 ; $50b7
	jr z, .continueStory ; $50b9
	farcall RunPlayAlonePartnerMenu ; $50bb
	cp $ff ; $50be
	jr nz, .continueStory ; $50c0
	ld a, $00 ; $50c2
	ld [wMenuSlideDirection], a ; $50c4
	jp RunTitleAndMainMenuLoop.menuLoop ; $50c7
.continueStory:
	call GetStoryContinueDestination ; $50ca
	ld [wMatchSelectSubState], a ; $50cd
	call RestoreGameTimer ; $50d0
	ld a, GAMEMODE_NONE ; $50d3
	ld [wGameMode], a ; $50d5
	clear_flag FLAG_ISLAND_SKY_SCENE_ACTIVE ; $50d8
	ld b, STORYLOC_DORM_ROOM ; $50db
	ld c, $01 ; $50dd
	farcall SaveStoryReturnPoint ; $50df
	farcall SaveStorySlotWithTimer ; $50e2
	test_flag FLAG_DEBUG_SKIP_LOCATION_EXIT ; $50e5
	jr nz, .loadSlot ; $50e8
	ld a, [wMatchSelectSubState] ; $50ea
	ld a, a ; $50ed
	ld [wUnusedExitTriggerIdMirror], a ; $50ee
	ld [wStoryModeExitTriggerRequest], a ; $50f1
	ret ; $50f4
.loadSlot:
	ld a, $03 ; $50f5
	ld [wUnusedExitTriggerIdMirror], a ; $50f7
	ld [wStoryModeExitTriggerRequest], a ; $50fa
	ret ; $50fd
MatchSelectHandlersBHandler3:
	ld a, STORYSLOT_NONE ; $50fe
	ld [wCurrentStorySlot], a ; $5100
	farcall ReadExhibitionSaveBlock ; $5103
	bit 7, a ; $5106
	jr nz, .noSlot ; $5108
	ld a, [wSaveAndQuitRequest] ; $510a
	or a ; $510d
	jr z, .noSlot ; $510e
	ld c, $00 ; $5110
	farcall ShowMatchResultsScreen ; $5112
	or a ; $5115
	jr z, .startStory ; $5116
	cp $ff ; $5118
	jp z, RunTitleAndMainMenuLoop.redrawMenu ; $511a
	ld a, [wKeepMatchStatsFlag] ; $511d
	or a ; $5120
	jp nz, .optionsFlow ; $5121
.startStory:
	call DisableLCDSafely ; $5124
	farcall ResetScreenAndTextWindows ; $5127
	call EnableLCD ; $512a
	push af ; $512d
	script_fade_in $10 ; $512e
	call WaitFadeEnd ; $5133
	pop af ; $5136
.noSlot:
	xor a ; $5137
	ld [wVictoryScoreTableAlt], a ; $5138
	ld a, STORYSLOT_NONE ; $513b
	ld [wCurrentStorySlot], a ; $513d
	farcall InitStoryModeState ; $5140
	farcall InitDefaultMatchSettings ; $5143
	farcall WriteExhibitionSaveBlock ; $5146
.eraseFlow:
	farcall RunMatchFormatSelect ; $5149
	cp $ff ; $514c
	jp z, RunTitleAndMainMenuLoop.menuLoop ; $514e
	ld c, $10 ; $5151
	call BeginFadeOut ; $5153
	call WaitFadeEnd ; $5156
.savedDataFlow:
	ld a, [wMatchFormatDoubles] ; $5159
	ld b, a ; $515c
	farcall RunExhibitionCharSelectScreen ; $515d
	call CopyExhibitionCharSlotIds ; $5160
	push af ; $5163
	call ClearFrameTasks ; $5164
	call DisableLCDSafely ; $5167
	farcall LoadMenuFontGfx ; $516a
	farcall ResetScreenAndTextWindows ; $516d
	xor a ; $5170
	ld [wLinkPartnerCourtMask], a ; $5171
	ld [wUnlockedCourtMask], a ; $5174
	farcall ComputeUnlockedCourtFlags ; $5177
	farcall LoadCourtSelectGraphics ; $517a
	pop af ; $517d
	cp $ff ; $517e
	jr nz, .minigameFlow ; $5180
	call EnableLCD ; $5182
	script_fade_in $10 ; $5185
	ld a, $00 ; $518a
	ld [wMenuSlideDirection], a ; $518c
	jr .eraseFlow ; $518f
.minigameFlow:
	ld a, $01 ; $5191
	ld [wMenuSlideDirection], a ; $5193
	farcall StubNop_3e ; $5196
	ld a, [wUnlockedCourtMask] ; $5199
	or a ; $519c
	jr z, .exhibitionFlow ; $519d
	call EnableLCD ; $519f
	script_fade_in $10 ; $51a2
	farcall RunCourtSelect9Menu ; $51a7
	cp $ff ; $51aa
	jr nz, .linkFlow ; $51ac
	ld a, $00 ; $51ae
	ld [wMenuSlideDirection], a ; $51b0
	jp z, .savedDataFlow ; $51b3
.exhibitionFlow:
	call EnableLCD ; $51b6
	script_fade_in $10 ; $51b9
	farcall RunCourtSelect4Menu ; $51be
	cp $ff ; $51c1
	jr nz, .linkFlow ; $51c3
	ld a, $00 ; $51c5
	ld [wMenuSlideDirection], a ; $51c7
	jp z, .savedDataFlow ; $51ca
.linkFlow:
	ld d, a ; $51cd
	wram_bank $04 ; $51ce
	ld a, d ; $51d4
	ld [wCurrentlyUsedCourt], a ; $51d5
	call ApplyMatchTypeSettings ; $51d8
.optionsFlow:
	ld a, STORYSLOT_NONE ; $51db
	ld [wCurrentStorySlot], a ; $51dd
	xor a ; $51e0
	ld [wSaveAndQuitRequest], a ; $51e1
	farcall WriteExhibitionSaveBlock ; $51e4
	ld a, GAMEMODE_EXHIBITION ; $51e7
	ld [wGameMode], a ; $51e9
	farcall RunMatch ; $51ec
	ld a, [wSaveAndQuitRequest] ; $51ef
	or a ; $51f2
	jr z, .done ; $51f3
	ld a, $01 ; $51f5
	ld [wVictoryScoreTableAlt], a ; $51f7
	farcall WriteExhibitionSaveBlock ; $51fa
.done:
	ld a, $01 ; $51fd
	ld [wMenuSlideDirection], a ; $51ff
	call DisableLCDSafely ; $5202
	farcall LoadMenuFontGfx ; $5205
	farcall ResetScreenAndTextWindows ; $5208
	call EnableLCD ; $520b
	script_fade_in $10 ; $520e
	jp RunTitleAndMainMenuLoop.menuLoop ; $5213
RunMinigameModeFlow:
	xor a ; $5216
	ld [wKeepMatchStatsFlag], a ; $5217
	farcall RunMinigameSelect ; $521a
	cp $ff ; $521d
	jr nz, .levelMenu ; $521f
	ld a, $00 ; $5221
	ld [wMenuSlideDirection], a ; $5223
	jp RunTitleAndMainMenuLoop.menuLoop ; $5226
.levelMenu:
	ld a, STORYSLOT_NONE ; $5229
	ld [wCurrentStorySlot], a ; $522b
	ld a, [wSelectedMinigame] ; $522e
	ld c, a ; $5231
	farcall RunMinigameLevelSelect ; $5232
	cp $ff ; $5235
	jr nz, .startMinigame ; $5237
	ld a, $00 ; $5239
	ld [wMenuSlideDirection], a ; $523b
	jp RunMinigameModeFlow ; $523e
.startMinigame:
	ld [wMinigameLevel], a ; $5241
	ld a, [wSelectedMinigame] ; $5244
	ld b, a ; $5247
	add a ; $5248
	add b ; $5249
	ld c, a ; $524a
	ld a, [wMinigameLevel] ; $524b
	add c ; $524e
	farcall ShowRulesScreen ; $524f
	cp $ff ; $5252
	jr nz, .done ; $5254
	call DisableLCDSafely ; $5256
	farcall LoadMenuFontGfx ; $5259
	farcall ResetScreenAndTextWindows ; $525c
	call EnableLCD ; $525f
	script_fade_in $10 ; $5262
	ld a, $00 ; $5267
	ld [wMenuSlideDirection], a ; $5269
	jr .levelMenu ; $526c
.done:
	ld a, [wSelectedMinigame] ; $526e
	call GetMinigameDrillId ; $5271
	farcall RunTrainingDrillByID ; $5274
	ld a, $01 ; $5277
	ld [wMenuSlideDirection], a ; $5279
	call DisableLCDSafely ; $527c
	farcall LoadMenuFontGfx ; $527f
	farcall ResetScreenAndTextWindows ; $5282
	call EnableLCD ; $5285
	script_fade_in $10 ; $5288
	call WaitFadeEnd ; $528d
	ld a, [wMatchSelectNewLevelRequest] ; $5290
	or a ; $5293
	jr nz, .levelMenu ; $5294
	ld a, [wPointWinLoseFlag] ; $5296
	cp WINLOSE_WIN ; $5299
	jr z, .levelMenu ; $529b
	jp RunTitleAndMainMenuLoop.menuLoop ; $529d
MatchSelectHandlersBHandler5:
	ld a, STORYSLOT_NONE ; $52a0
	ld [wCurrentStorySlot], a ; $52a2
	farcall InitStoryModeState ; $52a5
	farcall InitDefaultMatchSettings ; $52a8
	farcall RunLinkMatchSequenceAlias1 ; $52ab
	push af ; $52ae
	call InitSerialLink ; $52af
	pop af ; $52b2
	cp $ff ; $52b3
	jp z, RunTitleAndMainMenuLoop.menuLoop ; $52b5
	ld a, $01 ; $52b8
	ld [wMenuSlideDirection], a ; $52ba
	call DisableLCDSafely ; $52bd
	farcall LoadMenuFontGfx ; $52c0
	farcall ResetScreenAndTextWindows ; $52c3
	call EnableLCD ; $52c6
	script_fade_in $10 ; $52c9
	jp RunTitleAndMainMenuLoop.menuLoop ; $52ce
RunSavedDataMenuFlow:
	farcall RunSavedDataSourceSelect ; $52d1
	cp $ff ; $52d4
	jp z, RunTitleAndMainMenuLoop.menuLoop ; $52d6
	cp NUM_STORY_SLOTS ; $52d9
	jp nc, .checkSavedData ; $52db
	ld [wCurrentStorySlot], a ; $52de
	farcall CheckStorySlot ; $52e1
.transferMenu:
	farcall RunN64TransferItemSelect ; $52e4
	cp $ff ; $52e7
	jp z, RunSavedDataMenuFlow ; $52e9
	or a ; $52ec
	jr nz, .transferOption1 ; $52ed
	ld c, $10 ; $52ef
	call BeginFadeOut ; $52f1
	call WaitFadeEnd ; $52f4
	ld a, $00 ; $52f7
	farcall ShowCharDataScreen ; $52f9
	call DisableLCDSafely ; $52fc
	farcall LoadMenuFontGfx ; $52ff
	farcall ResetScreenAndTextWindows ; $5302
	call EnableLCD ; $5305
	script_fade_in $10 ; $5308
	ld a, $00 ; $530d
	ld [wMenuSlideDirection], a ; $530f
	jp .transferMenu ; $5312
.transferOption1:
	cp $01 ; $5315
	jr nz, .transferOption2 ; $5317
	ld c, $10 ; $5319
	call BeginFadeOut ; $531b
	call WaitFadeEnd ; $531e
	farcall ShowGameProgressScreen ; $5321
	ld c, $10 ; $5324
	call BeginFadeOut ; $5326
	call WaitFadeEnd ; $5329
	call DisableLCDSafely ; $532c
	farcall LoadMenuFontGfx ; $532f
	farcall ResetScreenAndTextWindows ; $5332
	call EnableLCD ; $5335
	script_fade_in $10 ; $5338
	ld a, $00 ; $533d
	ld [wMenuSlideDirection], a ; $533f
	jp .transferMenu ; $5342
.transferOption2:
	cp $02 ; $5345
	jr nz, .equipmentMenu ; $5347
	ld c, $10 ; $5349
	call BeginFadeOut ; $534b
	call WaitFadeEnd ; $534e
	farcall RunTrophiesScreen ; $5351
	call DisableLCDSafely ; $5354
	farcall LoadMenuFontGfx ; $5357
	farcall ResetScreenAndTextWindows ; $535a
	call EnableLCD ; $535d
	script_fade_in $10 ; $5360
	ld a, $00 ; $5365
	ld [wMenuSlideDirection], a ; $5367
	jp .transferMenu ; $536a
.equipmentMenu:
	farcall RunRacketShoesChoiceMenu ; $536d
	cp $00 ; $5370
	jr z, .racketSelect ; $5372
	cp $01 ; $5374
	jr z, .shoesSelect ; $5376
	ld a, $00 ; $5378
	ld [wMenuSlideDirection], a ; $537a
	jp .transferMenu ; $537d
.racketSelect:
	ld c, $10 ; $5380
	call BeginFadeOut ; $5382
	call WaitFadeEnd ; $5385
	farcall RunRacketSelectScreen ; $5388
	farcall ShowEquipmentStatusScreen ; $538b
	farcall SaveStorySlot ; $538e
	call DisableLCDSafely ; $5391
	farcall LoadMenuFontGfx ; $5394
	farcall ResetScreenAndTextWindows ; $5397
	call EnableLCD ; $539a
	script_fade_in $10 ; $539d
	ld a, $00 ; $53a2
	ld [wMenuSlideDirection], a ; $53a4
	jp .equipmentMenu ; $53a7
.shoesSelect:
	ld c, $10 ; $53aa
	call BeginFadeOut ; $53ac
	call WaitFadeEnd ; $53af
	farcall RunShoesSelectScreen ; $53b2
	farcall ShowEquipmentStatusScreen ; $53b5
	farcall SaveStorySlot ; $53b8
	call DisableLCDSafely ; $53bb
	farcall LoadMenuFontGfx ; $53be
	farcall ResetScreenAndTextWindows ; $53c1
	call EnableLCD ; $53c4
	script_fade_in $10 ; $53c7
	ld a, $00 ; $53cc
	ld [wMenuSlideDirection], a ; $53ce
	jp .equipmentMenu ; $53d1
.checkSavedData:
	cp $03 ; $53d4
	jr nz, .n64RecordMenu ; $53d6
.savedDataMenu:
	farcall RunSavedDataTypeSelect ; $53d8
	cp $ff ; $53db
	jr nz, .savedDataOption ; $53dd
	jp RunSavedDataMenuFlow ; $53df
.savedDataOption:
	or a ; $53e2
	jr nz, .minigameData ; $53e3
	ld c, $10 ; $53e5
	call BeginFadeOut ; $53e7
	call WaitFadeEnd ; $53ea
	farcall RunMarioCastExhibResults ; $53ed
	ld c, $10 ; $53f0
	call BeginFadeOut ; $53f2
	call WaitFadeEnd ; $53f5
	call DisableLCDSafely ; $53f8
	farcall LoadMenuFontGfx ; $53fb
	farcall ResetScreenAndTextWindows ; $53fe
	call EnableLCD ; $5401
	script_fade_in $10 ; $5404
	ld a, $00 ; $5409
	ld [wMenuSlideDirection], a ; $540b
	jp .savedDataMenu ; $540e
.minigameData:
	ld c, $10 ; $5411
	call BeginFadeOut ; $5413
	call WaitFadeEnd ; $5416
	farcall ShowMinigameDataScreen ; $5419
	ld c, $10 ; $541c
	call BeginFadeOut ; $541e
	call WaitFadeEnd ; $5421
	call DisableLCDSafely ; $5424
	farcall LoadMenuFontGfx ; $5427
	farcall ResetScreenAndTextWindows ; $542a
	call EnableLCD ; $542d
	script_fade_in $10 ; $5430
	ld a, $00 ; $5435
	ld [wMenuSlideDirection], a ; $5437
	jp .savedDataMenu ; $543a
.n64RecordMenu:
	farcall RunN64RecordTypeSelect ; $543d
	cp $ff ; $5440
	jp z, RunSavedDataMenuFlow ; $5442
	or a ; $5445
	jr nz, .n64RecordOption1 ; $5446
	ld c, $10 ; $5448
	call BeginFadeOut ; $544a
	call WaitFadeEnd ; $544d
	farcall RunN64TnmtData ; $5450
	call DisableLCDSafely ; $5453
	farcall LoadMenuFontGfx ; $5456
	farcall ResetScreenAndTextWindows ; $5459
	call EnableLCD ; $545c
	script_fade_in $10 ; $545f
	ld a, $00 ; $5464
	ld [wMenuSlideDirection], a ; $5466
	jp .checkSavedData ; $5469
.n64RecordOption1:
	cp $01 ; $546c
	jr nz, .done ; $546e
	ld c, $10 ; $5470
	call BeginFadeOut ; $5472
	call WaitFadeEnd ; $5475
	farcall RunN64ExhibDataAlias1 ; $5478
	call DisableLCDSafely ; $547b
	farcall LoadMenuFontGfx ; $547e
	farcall ResetScreenAndTextWindows ; $5481
	call EnableLCD ; $5484
	script_fade_in $10 ; $5487
	ld a, $00 ; $548c
	ld [wMenuSlideDirection], a ; $548e
	jp .checkSavedData ; $5491
.done:
	farcall RunN64RingShotData ; $5494
	call DisableLCDSafely ; $5497
	farcall LoadMenuFontGfx ; $549a
	farcall ResetScreenAndTextWindows ; $549d
	call EnableLCD ; $54a0
	script_fade_in $10 ; $54a3
	ld a, $00 ; $54a8
	ld [wMenuSlideDirection], a ; $54aa
	jp .checkSavedData ; $54ad
MatchSelectHandlersBHandler7:
	ld c, $10 ; $54b0
	call BeginFadeOut ; $54b2
	call WaitFadeEnd ; $54b5
	ld a, $06 ; $54b8
	farcall TennisDictionaryScreen ; $54ba
	call DisableLCDSafely ; $54bd
	farcall LoadMenuFontGfx ; $54c0
	farcall ResetScreenAndTextWindows ; $54c3
	call EnableLCD ; $54c6
	script_fade_in $10 ; $54c9
	ld a, $00 ; $54ce
	ld [wMenuSlideDirection], a ; $54d0
	jp RunTitleAndMainMenuLoop.menuLoop ; $54d3
RunEraseSavedDataFlow:
	farcall RunEraseSavedDataSelect ; $54d6
	cp $ff ; $54d9
	jp z, RunTitleAndMainMenuLoop.menuLoop ; $54db
	ld b, a ; $54de
	add a ; $54df
	ld hl, EraseSavedDataFlowHandlers_10 ; $54e0
	add l ; $54e3
	ld l, a ; $54e4
	jr nc, .readHandler ; $54e5
	inc h ; $54e7
.readHandler:
	ld a, [hl+] ; $54e8
	ld h, [hl] ; $54e9
	ld l, a ; $54ea
	jp hl ; $54eb
EraseSavedDataFlowHandlers_10:
	; $54ec, 10 bytes (records:2)
	dw EraseSavedDataFlowHandler0_10 ; record 0
	dw EraseSavedDataFlowHandler0_10 ; record 1
	dw EraseSavedDataFlowHandler0_10 ; record 2
	dw EraseSavedDataFlowHandler3_10 ; record 3
	dw EraseSavedDataFlowHandler4_10 ; record 4
EraseSavedDataFlowHandler0_10:
	ld a, b ; $54f6
	ld [wCurrentStorySlot], a ; $54f7
	farcall CheckStorySlot ; $54fa
	push bc ; $54fd
	ld c, $10 ; $54fe
	call BeginFadeOut ; $5500
	call WaitFadeEnd ; $5503
	farcall RunCharDataConfirmScreen ; $5506
	pop bc ; $5509
	or a ; $550a
	jr nz, .redrawAfterErase ; $550b
	call ConfirmDiscardSuspendedExhibMatch ; $550d
	or a ; $5510
	jr nz, .redrawAfterErase ; $5511
	ld a, b ; $5513
	ld [wCurrentStorySlot], a ; $5514
	ld a, $00 ; $5517
	farcall EraseStorySlotSaveData ; $5519
	xor a ; $551c
	ld [wMainMenuCursor], a ; $551d
.redrawAfterErase:
	call DisableLCDSafely ; $5520
	farcall LoadMenuFontGfx ; $5523
	farcall ResetScreenAndTextWindows ; $5526
	call EnableLCD ; $5529
	script_fade_in $10 ; $552c
	ld a, $00 ; $5531
	ld [wMenuSlideDirection], a ; $5533
	jp RunEraseSavedDataFlow ; $5536
EraseSavedDataFlowHandler3_10:
	ld c, $10 ; $5539
	call BeginFadeOut ; $553b
	call WaitFadeEnd ; $553e
	ld b, $01 ; $5541
	farcall RunEraseDataConfirmMenu ; $5543
	or a ; $5546
	jr z, .redrawAfterBlockErase ; $5547
	farcall ClearSaveBlock11 ; $5549
.redrawAfterBlockErase:
	call DisableLCDSafely ; $554c
	farcall LoadMenuFontGfx ; $554f
	farcall ResetScreenAndTextWindows ; $5552
	call EnableLCD ; $5555
	script_fade_in $10 ; $5558
	ld a, $00 ; $555d
	ld [wMenuSlideDirection], a ; $555f
	jp RunEraseSavedDataFlow ; $5562
EraseSavedDataFlowHandler4_10:
	ld c, $10 ; $5565
	call BeginFadeOut ; $5567
	call WaitFadeEnd ; $556a
	ld b, $00 ; $556d
	farcall RunEraseDataConfirmMenu ; $556f
	or a ; $5572
	jr nz, .reinitSram ; $5573
	call DisableLCDSafely ; $5575
	farcall LoadMenuFontGfx ; $5578
	farcall ResetScreenAndTextWindows ; $557b
	call EnableLCD ; $557e
	script_fade_in $10 ; $5581
	ld a, $00 ; $5586
	ld [wMenuSlideDirection], a ; $5588
	xor a ; $558b
	ld [wMainMenuCursor], a ; $558c
	jp RunEraseSavedDataFlow ; $558f
.reinitSram:
	farcall ReinitSaveRamPreservingBlock6 ; $5592
	call DisableLCDSafely ; $5595
	farcall LoadMenuFontGfx ; $5598
	farcall ResetScreenAndTextWindows ; $559b
	call EnableLCD ; $559e
	script_fade_in $10 ; $55a1
	ld a, $00 ; $55a6
	ld [wMenuSlideDirection], a ; $55a8
	xor a ; $55ab
	ld [wMainMenuCursor], a ; $55ac
	ld [wSelectedMinigame], a ; $55af
	jp RunEraseSavedDataFlow ; $55b2
	ret ; $55b5
.runMatch:
	farcall RunMatch ; $55b6
	ld a, [wSaveAndQuitRequest] ; $55b9
	or a ; $55bc
	jr z, .matchFinished ; $55bd
	farcall SaveStorySlotWithTimer ; $55bf
	ld a, STORYLOC_MAIN_MENU ; $55c2
	ld [wStoryModeCurrentLocation], a ; $55c4
	ld a, $01 ; $55c7
	ld [wStoryModeEntryPoint], a ; $55c9
	ld a, $ff ; $55cc
	ld [wUnusedExitTriggerIdMirror], a ; $55ce
	ld [wStoryModeExitTriggerRequest], a ; $55d1
	ret ; $55d4
.matchFinished:
	ld a, [wGameMode] ; $55d5
	cp GAMEMODE_EXHIBITION ; $55d8
	jr nz, .chooseReturn ; $55da
	clear_flag FLAG_ISLAND_SKY_SCENE_ACTIVE ; $55dc
	xor a ; $55df
	ld [wKeepMatchStatsFlag], a ; $55e0
	ld b, STORYLOC_MAIN_MENU ; $55e3
	ld c, $01 ; $55e5
	farcall SaveStoryReturnPoint ; $55e7
	farcall SaveStorySlotWithTimer ; $55ea
	test_flag FLAG_DEBUG_SKIP_LOCATION_EXIT ; $55ed
	jr nz, .returnToLocation3 ; $55f0
	ld a, $02 ; $55f2
	ld [wUnusedExitTriggerIdMirror], a ; $55f4
	ld [wStoryModeExitTriggerRequest], a ; $55f7
	ret ; $55fa
.returnToLocation3:
	ld a, $03 ; $55fb
	ld [wUnusedExitTriggerIdMirror], a ; $55fd
	ld [wStoryModeExitTriggerRequest], a ; $5600
	ret ; $5603
.chooseReturn:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $5604
	cp $14 ; $5607
	jr c, .below14 ; $5609
	ld a, STORYLOC_SPECIAL_COURT ; $560b
	ld [wStoryModeCurrentLocation], a ; $560d
	ld a, $0a ; $5610
	ld [wStoryModeEntryPoint], a ; $5612
	ld a, $ff ; $5615
	ld [wUnusedExitTriggerIdMirror], a ; $5617
	ld [wStoryModeExitTriggerRequest], a ; $561a
	ret ; $561d
.below14:
	cp $0f ; $561e
	jr c, .below0f ; $5620
	test_flag FLAG_DOUBLES ; $5622
	jr nz, .below14Doubles ; $5625
	ld a, STORYLOC_TOURNAMENT ; $5627
	ld [wStoryModeCurrentLocation], a ; $5629
	ld a, $0a ; $562c
	ld [wStoryModeEntryPoint], a ; $562e
	ld a, $ff ; $5631
	ld [wUnusedExitTriggerIdMirror], a ; $5633
	ld [wStoryModeExitTriggerRequest], a ; $5636
	ret ; $5639
.below14Doubles:
	ld a, STORYLOC_TOURNAMENT ; $563a
	ld [wStoryModeCurrentLocation], a ; $563c
	ld a, $0b ; $563f
	ld [wStoryModeEntryPoint], a ; $5641
	ld a, $ff ; $5644
	ld [wUnusedExitTriggerIdMirror], a ; $5646
	ld [wStoryModeExitTriggerRequest], a ; $5649
	ret ; $564c
.below0f:
	cp $0a ; $564d
	jr c, .below0a ; $564f
	ld a, STORYLOC_COURTYARD ; $5651
	ld [wStoryModeCurrentLocation], a ; $5653
	ld a, $0d ; $5656
	ld [wStoryModeEntryPoint], a ; $5658
	ld a, $ff ; $565b
	ld [wUnusedExitTriggerIdMirror], a ; $565d
	ld [wStoryModeExitTriggerRequest], a ; $5660
	ret ; $5663
.below0a:
	cp $05 ; $5664
	jr c, .below05 ; $5666
	jr z, .id05 ; $5668
	ld a, STORYLOC_SENIOR_CLASS_COURT ; $566a
	ld [wStoryModeCurrentLocation], a ; $566c
	ld a, $0f ; $566f
	ld [wStoryModeEntryPoint], a ; $5671
	ld a, $ff ; $5674
	ld [wUnusedExitTriggerIdMirror], a ; $5676
	ld [wStoryModeExitTriggerRequest], a ; $5679
	ret ; $567c
.id05:
	ld a, STORYLOC_SENIOR_CLASS_COURT ; $567d
	ld [wStoryModeCurrentLocation], a ; $567f
	ld a, $09 ; $5682
	ld [wStoryModeEntryPoint], a ; $5684
	ld a, $ff ; $5687
	ld [wUnusedExitTriggerIdMirror], a ; $5689
	ld [wStoryModeExitTriggerRequest], a ; $568c
	ret ; $568f
.below05:
	test_flag FLAG_DOUBLES ; $5690
	jr nz, .otherRoom ; $5693
	cp $00 ; $5695
	jr z, .practiceRoomAlt ; $5697
	ld a, STORYLOC_JUNIOR_CLASS_COURT_SINGLES ; $5699
	ld [wStoryModeCurrentLocation], a ; $569b
	ld a, $0f ; $569e
	ld [wStoryModeEntryPoint], a ; $56a0
	ld a, $ff ; $56a3
	ld [wUnusedExitTriggerIdMirror], a ; $56a5
	ld [wStoryModeExitTriggerRequest], a ; $56a8
	ret ; $56ab
.practiceRoomAlt:
	ld a, STORYLOC_JUNIOR_CLASS_COURT_SINGLES ; $56ac
	ld [wStoryModeCurrentLocation], a ; $56ae
	ld a, $09 ; $56b1
	ld [wStoryModeEntryPoint], a ; $56b3
	ld a, $ff ; $56b6
	ld [wUnusedExitTriggerIdMirror], a ; $56b8
	ld [wStoryModeExitTriggerRequest], a ; $56bb
	ret ; $56be
.otherRoom:
	cp $00 ; $56bf
	jr z, .otherRoomAlt ; $56c1
	ld a, STORYLOC_JUNIOR_CLASS_COURT_DOUBLES ; $56c3
	ld [wStoryModeCurrentLocation], a ; $56c5
	ld a, $0f ; $56c8
	ld [wStoryModeEntryPoint], a ; $56ca
	ld a, $ff ; $56cd
	ld [wUnusedExitTriggerIdMirror], a ; $56cf
	ld [wStoryModeExitTriggerRequest], a ; $56d2
	ret ; $56d5
.otherRoomAlt:
	ld a, STORYLOC_JUNIOR_CLASS_COURT_DOUBLES ; $56d6
	ld [wStoryModeCurrentLocation], a ; $56d8
	ld a, $09 ; $56db
	ld [wStoryModeEntryPoint], a ; $56dd
	ld a, $ff ; $56e0
	ld [wUnusedExitTriggerIdMirror], a ; $56e2
	ld [wStoryModeExitTriggerRequest], a ; $56e5
	ret ; $56e8
GetMinigameDrillId:
	ld hl, MinigameDrillIdTable ; $56e9
	add l ; $56ec
	ld l, a ; $56ed
	jr nc, .read ; $56ee
	inc h ; $56f0
.read:
	ld a, [hl] ; $56f1
	ret ; $56f2
MinigameDrillIdTable:
	; $56f3, 9 bytes (bytes:16)
	db $1c, $1d, $1e, $1f, $20, $21, $22, $23, $24 ; 0x00
CopyExhibitionCharSlotIds:
	push af ; $56fc
	push_wram_bank $03 ; $56fd
	ld hl, wCharSelectSlotChars ; $5706
	ld de, wMatchSlotCharRefs ; $5709
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
	pop_wram_bank ; $5717
	pop af ; $571c
	ret ; $571d
Unused_10_CheckAnyStorySlot:
	ld a, [wCurrentStorySlot] ; $571e
	push af ; $5721
	xor a ; $5722
	ld [wCurrentStorySlot], a ; $5723
	farcall CheckStorySlot ; $5726
	cp $fe ; $5729
	jr nz, .restore ; $572b
	ld a, $01 ; $572d
	ld [wCurrentStorySlot], a ; $572f
	farcall CheckStorySlot ; $5732
	cp $fe ; $5735
	jr nz, .restore ; $5737
	ld a, $02 ; $5739
	ld [wCurrentStorySlot], a ; $573b
	farcall CheckStorySlot ; $573e
	cp $fe ; $5741
	jr nz, .restore ; $5743
	pop af ; $5745
	xor a ; $5746
	ld [wCurrentStorySlot], a ; $5747
	ret ; $574a
.restore:
	pop af ; $574b
	ld [wCurrentStorySlot], a ; $574c
	ld a, $01 ; $574f
	ret ; $5751
GetStoryContinueDestination:
	test_flag FLAG_DOUBLES ; $5752
	jr nz, .checkFlag ; $5755
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $5757
	ld a, $02 ; $575a
	jr z, .done ; $575c
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $575e
	ld a, $04 ; $5761
	jr z, .done ; $5763
	test_flag FLAG_REACHED_MARIO_WORLD_SINGLES ; $5765
	ld a, $05 ; $5768
	jr z, .done ; $576a
	ld a, $02 ; $576c
	jr .done ; $576e
.checkFlag:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $5770
	ld a, $02 ; $5773
	jr z, .done ; $5775
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $5777
	ld a, $04 ; $577a
	jr z, .done ; $577c
	test_flag FLAG_REACHED_MARIO_WORLD_DOUBLES ; $577e
	ld a, $05 ; $5781
	jr z, .done ; $5783
	ld a, $02 ; $5785
	jr .done ; $5787
.done:
	ret ; $5789
ConfirmDiscardSuspendedExhibMatch:
	push af ; $578a
	push bc ; $578b
	farcall ReadExhibitionSaveBlock ; $578c
	bit 7, a ; $578f
	jr nz, .done ; $5791
	ld a, [wSaveAndQuitRequest] ; $5793
	or a ; $5796
	jr z, .done ; $5797
	ld a, [wCurrentStorySlot] ; $5799
	ld b, a ; $579c
	ld a, [wMatchSlotCharRefs] ; $579d
	bit 7, a ; $57a0
	jr z, .checkSlot2 ; $57a2
	and $7f ; $57a4
	srl a ; $57a6
	cp b ; $57a8
	jr z, .prompt ; $57a9
.checkSlot2:
	ld a, [wMatchSlotCharRefs + 1] ; $57ab
	bit 7, a ; $57ae
	jr z, .checkSlot3 ; $57b0
	and $7f ; $57b2
	srl a ; $57b4
	cp b ; $57b6
	jr z, .prompt ; $57b7
.checkSlot3:
	ld a, [wMatchSlotCharRefs + 2] ; $57b9
	bit 7, a ; $57bc
	jr z, .checkSlot4 ; $57be
	and $7f ; $57c0
	srl a ; $57c2
	cp b ; $57c4
	jr z, .prompt ; $57c5
.checkSlot4:
	ld a, [wMatchSlotCharRefs + 3] ; $57c7
	bit 7, a ; $57ca
	jr z, .noMatch ; $57cc
	and $7f ; $57ce
	srl a ; $57d0
	cp b ; $57d2
	jr z, .prompt ; $57d3
.noMatch:
	jr .done ; $57d5
.prompt:
	ld b, $02 ; $57d7
	farcall RunEraseDataConfirmMenu ; $57d9
	or a ; $57dc
	jr z, .discarded ; $57dd
	xor a ; $57df
	ld [wSaveAndQuitRequest], a ; $57e0
	ld [wKeepMatchStatsFlag], a ; $57e3
	farcall WriteExhibitionSaveBlock ; $57e6
	pop bc ; $57e9
	pop af ; $57ea
	ld a, $00 ; $57eb
	ret ; $57ed
.discarded:
	pop bc ; $57ee
	pop af ; $57ef
	ld a, $01 ; $57f0
	ret ; $57f2
.done:
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
	map_actor $0000, ActorScript_10_2, $3b00, $3700, FACE_DOWN, $30, $01, $00
	map_actor $0000, ActorScript_10_2, $3d00, $3900, FACE_LEFT, $30, $01, $05
	map_actor $0000, ActorScript_10_2, $3d00, $3b00, FACE_LEFT, $3a, $01, $00
	map_actor $0000, ActorScript_10_2, $2f00, $3100, FACE_RIGHT, $3a, $01, $07
	map_actor $0000, ActorScript_10_2, $3300, $3100, FACE_LEFT, $3b, $01, $00
	map_actor $0000, ActorScript_10_2, $3700, $2f00, FACE_RIGHT, $3c, $01, $00
	map_actor $0000, ActorScript_10_2, $3b00, $2f00, FACE_LEFT, $3b, $01, $04
	map_actor_end
CafeteriaEntryPoints_10:
	; $5870, 9 bytes (map_entries)
	map_entry $01, FACE_DOWN, $2700, $3700, $0000
	db $ff
CafeteriaExitTriggers_10:
	; $5879, 9 bytes (map_scripts:exit)
	map_script $03, FACEMASK_ANY, $0000, MapExitWalkCurveLeft_10, STORYLOC_RESTAURANT, $02
	db $ff
CafeteriaNpc03_10:
	ld a, [wMapSceneStage] ; $5882
	add a ; $5885
	ld_hl_indexed CafeteriaNpc03TextIds ; $5886
	ld a, [hl+] ; $588d
	ld h, [hl] ; $588e
	ld l, a ; $588f
	farcall InitDialogueTextCursor ; $5890
	script_speak $03 ; $5893
	ret ; $5898
CafeteriaNpc03TextIds:
	; $5899, 20 bytes (text_ids)
	dw Text_33_59 ; record 0
	dw Text_33_60 ; record 1
	dw Text_33_98 ; record 2
	dw Text_33_99 ; record 3
	dw Text_33_143 ; record 4
	dw Text_33_143 ; record 5
	dw Text_33_183 ; record 6
	dw Text_33_183 ; record 7
	dw Text_33_218 ; record 8
	dw Text_33_218 ; record 9
CafeteriaNpc04_10:
	ld a, [wMapSceneStage2] ; $58ad
	add a ; $58b0
	ld_hl_indexed CafeteriaNpc04TextIds ; $58b1
	ld a, [hl+] ; $58b8
	ld h, [hl] ; $58b9
	ld l, a ; $58ba
	farcall InitDialogueTextCursor ; $58bb
	ld a, [wMapSceneStage2] ; $58be
	cp STORYTIER_ISLAND_OPEN ; $58c1
	jr c, .speak ; $58c3
	ld a, [wMapSceneStage2] ; $58c5
	cp STORYTIER_COMPLETE ; $58c8
	jr z, .prompt ; $58ca
	ld a, $04 ; $58cc
	farcall ScriptShowSpeakerDialogueRestoreBG ; $58ce
	farcall RunDialogueYesNoPrompt ; $58d1
	farcall ScriptCloseDialogueWindow ; $58d4
	script_wait_frames $05 ; $58d7
	and a ; $58de
	jr z, .speak ; $58df
	farcall AdvanceDialogueTextCursor ; $58e1
.speak:
	script_speak $04 ; $58e4
	ret ; $58e9
.prompt:
	ld a, [wMapSceneStage] ; $58ea
	cp STORYRANK_DOUBLES_COMPLETE ; $58ed
	jr nz, .askQuestion ; $58ef
	farcall AdvanceDialogueTextCursor ; $58f1
.askQuestion:
	ld a, $04 ; $58f4
	farcall ScriptShowSpeakerDialogueRestoreBG ; $58f6
	farcall RunDialogueYesNoPrompt ; $58f9
	farcall ScriptCloseDialogueWindow ; $58fc
	script_wait_frames $05 ; $58ff
	and a ; $5906
	jr z, .declined ; $5907
	script_set_text Text_33_222 ; $5909
	script_speak $04 ; $590f
	ret ; $5914
.declined:
	script_set_text Text_33_221 ; $5915
	script_speak $04 ; $591b
	ret ; $5920
CafeteriaNpc04TextIds:
	; $5921, 10 bytes (text_ids)
	dw Text_33_61 ; record 0
	dw Text_33_100 ; record 1
	dw Text_33_144 ; record 2
	dw Text_33_184 ; record 3
	dw Text_33_219 ; record 4
CafeteriaNpc05_10:
	ld a, [wMapSceneStage2] ; $592b
	add a ; $592e
	ld_hl_indexed CafeteriaNpc05TextIds ; $592f
	ld a, [hl+] ; $5936
	ld h, [hl] ; $5937
	ld l, a ; $5938
	farcall InitDialogueTextCursor ; $5939
	ld a, [wMapSceneStage2] ; $593c
	cp STORYTIER_JUNIOR_CHAMP ; $593f
	jr nz, .speak ; $5941
	ld a, $05 ; $5943
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5945
	farcall RunDialogueYesNoPrompt ; $5948
	farcall ScriptCloseDialogueWindow ; $594b
	script_wait_frames $05 ; $594e
	and a ; $5955
	jr z, .speak ; $5956
	farcall AdvanceDialogueTextCursor ; $5958
.speak:
	script_speak $05 ; $595b
	ret ; $5960
CafeteriaNpc05TextIds:
	; $5961, 10 bytes (text_ids)
	dw Text_33_62 ; record 0
	dw Text_33_101 ; record 1
	dw Text_33_145 ; record 2
	dw Text_33_187 ; record 3
	dw Text_33_223 ; record 4
CafeteriaNpc06_10:
	ld a, [wMapSceneStage] ; $596b
	add a ; $596e
	ld_hl_indexed CafeteriaNpc06TextIds ; $596f
	ld a, [hl+] ; $5976
	ld h, [hl] ; $5977
	ld l, a ; $5978
	farcall InitDialogueTextCursor ; $5979
	script_speak $06 ; $597c
	ret ; $5981
CafeteriaNpc06TextIds:
	; $5982, 20 bytes (text_ids)
	dw Text_33_63 ; record 0
	dw Text_33_63 ; record 1
	dw Text_33_104 ; record 2
	dw Text_33_105 ; record 3
	dw Text_33_146 ; record 4
	dw Text_33_147 ; record 5
	dw Text_33_188 ; record 6
	dw Text_33_189 ; record 7
	dw Text_33_188 ; record 8
	dw Text_33_189 ; record 9
CafeteriaNpc07_10:
	ld a, [wMapSceneStage] ; $5996
	add a ; $5999
	ld_hl_indexed CafeteriaNpc07TextIds ; $599a
	ld a, [hl+] ; $59a1
	ld h, [hl] ; $59a2
	ld l, a ; $59a3
	farcall InitDialogueTextCursor ; $59a4
	script_speak $07 ; $59a7
	ret ; $59ac
CafeteriaNpc07TextIds:
	; $59ad, 20 bytes (text_ids)
	dw Text_33_64 ; record 0
	dw Text_33_64 ; record 1
	dw Text_33_106 ; record 2
	dw Text_33_107 ; record 3
	dw Text_33_148 ; record 4
	dw Text_33_149 ; record 5
	dw Text_33_190 ; record 6
	dw Text_33_191 ; record 7
	dw Text_33_190 ; record 8
	dw Text_33_191 ; record 9
CafeteriaNpc08_10:
	ld a, [wMapSceneStage] ; $59c1
	add a ; $59c4
	ld_hl_indexed CafeteriaNpc08TextIds ; $59c5
	ld a, [hl+] ; $59cc
	ld h, [hl] ; $59cd
	ld l, a ; $59ce
	farcall InitDialogueTextCursor ; $59cf
	script_speak $08 ; $59d2
	ret ; $59d7
CafeteriaNpc08TextIds:
	; $59d8, 20 bytes (text_ids)
	dw Text_33_65 ; record 0
	dw Text_33_65 ; record 1
	dw Text_33_108 ; record 2
	dw Text_33_108 ; record 3
	dw Text_33_150 ; record 4
	dw Text_33_151 ; record 5
	dw Text_33_192 ; record 6
	dw Text_33_193 ; record 7
	dw Text_33_224 ; record 8
	dw Text_33_193 ; record 9
CafeteriaNpc09_10:
	ld a, [wMapSceneStage] ; $59ec
	add a ; $59ef
	ld_hl_indexed CafeteriaNpc09TextIds ; $59f0
	ld a, [hl+] ; $59f7
	ld h, [hl] ; $59f8
	ld l, a ; $59f9
	farcall InitDialogueTextCursor ; $59fa
	script_speak $09 ; $59fd
	ret ; $5a02
CafeteriaNpc09TextIds:
	; $5a03, 20 bytes (text_ids)
	dw Text_33_66 ; record 0
	dw Text_33_66 ; record 1
	dw Text_33_109 ; record 2
	dw Text_33_109 ; record 3
	dw Text_33_152 ; record 4
	dw Text_33_152 ; record 5
	dw Text_33_194 ; record 6
	dw Text_33_195 ; record 7
	dw Text_33_194 ; record 8
	dw Text_33_195 ; record 9
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
	call SetStoryDialogueStage_10 ; $5a52
	ld a, [wMapSceneStage] ; $5a55
	sra a ; $5a58
	ld [wMapSceneStage2], a ; $5a5a
	ld a, $22 ; $5a5d
	ld [wMapScrollMinX], a ; $5a5f
	ld a, $26 ; $5a62
	ld [wMapScrollMinY], a ; $5a64
	ld a, $40 ; $5a67
	ld [wMapWidthTiles], a ; $5a69
	ld a, $3e ; $5a6c
	ld [wMapHeightTiles], a ; $5a6e
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
	map_actor $0000, ActorScript_10_2, $1100, $1900, FACE_LEFT, $2f, $01, $00
	map_actor $0000, ActorScript_10_2, $2100, $1500, FACE_UP, $2f, $01, $07
	map_actor $0000, ActorScript_10_2, $1600, $1300, FACE_DOWN, $30, $01, $00
	map_actor $0000, ActorScript_10_2, $1d00, $1700, FACE_UP, $31, $01, $00
	map_actor $0000, ActorScript_10_2, $2900, $2900, FACE_RIGHT, $4c, $01, $00
	map_actor $0000, ActorScript_10_2, $2100, $1100, FACE_RIGHT, $33, $01, $00
	map_actor $0000, ActorScript_10_2, $0900, $0f00, FACE_RIGHT, $34, $01, $00
	map_actor $0000, ActorScript_10_3, $0b00, $1900, FACE_LEFT, $30, $01, $06
	map_actor $0000, ActorScript_10_2, $0d00, $0f00, FACE_LEFT, $3a, $01, $00
	map_actor $0000, ActorScript_10_2, $1500, $0b00, FACE_LEFT, $33, $01, $00
	map_actor $0000, ActorScript_10_2, $1d00, $0b00, FACE_LEFT, $3c, $01, $04
	map_actor $0000, ActorScript_10_2, $1b00, $0900, FACE_DOWN, $3b, $01, $00
	map_actor $0000, ActorScript_10_2, $1d00, $0f00, FACE_LEFT, $3c, $01, $00
	map_actor $0000, ActorScript_10_2, $1900, $0f00, FACE_RIGHT, $3b, $01, $06
	map_actor $0000, ActorScript_10_2, $2900, $2900, FACE_RIGHT, $4f, $01, $00
	map_actor $0000, ActorScript_10_2, $1b00, $1200, FACE_DOWN, $3a, $01, $00
	map_actor $0000, ActorScript_10_2, $1900, $0900, FACE_DOWN, $35, $01, $00
	map_actor_end
RestaurantEntryPoints_10:
	; $5b86, 17 bytes (map_entries)
	map_entry $01, FACE_UP, $0c00, $2100, RestaurantArrival01_10
	map_entry $02, FACE_DOWN, $0500, $1700, MapArrivalWalkPair_10
	db $ff
; Instruction-identical to AcademyMainBldgArrival01_10, MapArrivalWalk_11, DormEntranceArrival01_12 and RestaurantPlazaArrival04_13 (one copy per bank); a change here belongs in every copy.
RestaurantArrival01_10:
	ld a, [wStoryModeEntryPoint] ; $5b97
	cp STORYENTRY_NONE ; $5b9a
	jp z, .done ; $5b9c
	test_flag FLAG_DOUBLES ; $5b9f
	jr z, .walkOff ; $5ba2
	script_set_speed ACTOR_PARTNER, $00ff ; $5ba4
	script_move_angle ACTOR_PARTNER, FACE_DOWN, $0200 ; $5bac
	script_wait_move ACTOR_PARTNER ; $5bb6
	script_face ACTOR_PARTNER, FACE_UP ; $5bbb
	script_set_speed ACTOR_PARTNER, $0010 ; $5bc2
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $5bca
	script_move_angle ACTOR_PLAYER, FACE_UP, $0200 ; $5bd2
.done:
	ret ; $5bdc
RestaurantExitTriggers_10:
	; $5bdd, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, RestaurantExit01_10, STORYLOC_RESTAURANT_PLAZA, $02
	map_script $02, FACEMASK_ANY, $0000, MapExitWalkCurveRight_10, STORYLOC_CAFETERIA, $01
	db $ff
RestaurantExit01_10:
	clear_flag FLAG_RESTAURANT_NPC08_MOVED ; $5bee
	ret ; $5bf1
RestaurantNpc03_10:
	ld a, [wMapSceneStage2] ; $5bf2
	add a ; $5bf5
	ld_hl_indexed RestaurantNpc03TextIds ; $5bf6
	ld a, [hl+] ; $5bfd
	ld h, [hl] ; $5bfe
	ld l, a ; $5bff
	farcall InitDialogueTextCursor ; $5c00
	ld a, [wMapSceneStage] ; $5c03
	cp STORYRANK_DOUBLES_JUNIOR_CHAMP ; $5c06
	jr nz, .speak ; $5c08
	farcall AdvanceDialogueTextCursor ; $5c0a
.speak:
	script_speak $03 ; $5c0d
	ret ; $5c12
RestaurantNpc03TextIds:
	; $5c13, 10 bytes (text_ids)
	dw Text_33_33 ; record 0
	dw Text_33_68 ; record 1
	dw Text_33_111 ; record 2
	dw Text_33_153 ; record 3
	dw Text_33_196 ; record 4
RestaurantNpc04_10:
	ld a, [wMapSceneStage2] ; $5c1d
	add a ; $5c20
	ld_hl_indexed RestaurantNpc04TextIds ; $5c21
	ld a, [hl+] ; $5c28
	ld h, [hl] ; $5c29
	ld l, a ; $5c2a
	farcall InitDialogueTextCursor ; $5c2b
	script_speak $04 ; $5c2e
	ret ; $5c33
RestaurantNpc04TextIds:
	; $5c34, 10 bytes (text_ids)
	dw Text_33_34 ; record 0
	dw Text_33_70 ; record 1
	dw Text_33_112 ; record 2
	dw Text_33_154 ; record 3
	dw Text_33_197 ; record 4
RestaurantNpc05_10:
	script_face_toward ACTOR_PLAYER, $05 ; $5c3e
	ld a, [wMapSceneStage] ; $5c46
	add a ; $5c49
	ld_hl_indexed RestaurantNpc05TextIds ; $5c4a
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
RestaurantNpc05TextIds:
	; $5c9c, 20 bytes (text_ids)
	dw Text_33_35 ; record 0
	dw Text_33_35 ; record 1
	dw Text_33_71 ; record 2
	dw Text_33_71 ; record 3
	dw Text_33_113 ; record 4
	dw Text_33_116 ; record 5
	dw Text_33_155 ; record 6
	dw Text_33_158 ; record 7
	dw Text_33_198 ; record 8
	dw Text_33_198 ; record 9
RestaurantNpc06_10:
	script_set_anim $06, $04 ; $5cb0
	script_wait_idle $06 ; $5cb7
	ld a, [wMapSceneStage2] ; $5cbc
	add a ; $5cbf
	ld_hl_indexed RestaurantNpc06TextIds_10 ; $5cc0
	ld a, [hl+] ; $5cc7
	ld h, [hl] ; $5cc8
	ld l, a ; $5cc9
	farcall InitDialogueTextCursor ; $5cca
	ld a, [wMapSceneStage] ; $5ccd
	cp STORYRANK_DOUBLES_SENIOR_CHAMP ; $5cd0
	jr nz, .speak ; $5cd2
	farcall AdvanceDialogueTextCursor ; $5cd4
	farcall AdvanceDialogueTextCursor ; $5cd7
.speak:
	script_speak $06 ; $5cda
	ld a, [wMapSceneStage2] ; $5cdf
	cp STORYTIER_ACADEMY ; $5ce2
	jr nz, .animate ; $5ce4
	call RestaurantShowActor11NearPlayer_10 ; $5ce6
.animate:
	script_set_anim $06, $03 ; $5ce9
	script_wait_idle $06 ; $5cf0
	script_speak $06 ; $5cf5
	ret ; $5cfa
RestaurantNpc06TextIds_10:
	; $5cfb, 10 bytes (text_ids)
	dw Text_33_38 ; record 0
	dw Text_33_74 ; record 1
	dw Text_33_119 ; record 2
	dw Text_33_161 ; record 3
	dw Text_33_201 ; record 4
RestaurantNpc12_10:
	call TestRestaurantNpc12StageFlag_10 ; $5d05
	jp nz, .speak ; $5d08
	script_set_anim $12, $03 ; $5d0b
	script_wait_idle $12 ; $5d12
	ld a, [wMapSceneStage2] ; $5d17
	add a ; $5d1a
	ld_hl_indexed RestaurantNpc12TextIds ; $5d1b
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
	call SetRestaurantNpc12StageFlag_10 ; $5d7f
	script_face_toward ACTOR_PLAYER, $12 ; $5d82
	ld a, [wMapSceneStage2] ; $5d8a
	add a ; $5d8d
	ld_hl_indexed RestaurantNpc12TextIds ; $5d8e
	ld a, [hl+] ; $5d95
	ld h, [hl] ; $5d96
	ld l, a ; $5d97
	ld a, $02 ; $5d98
	add l ; $5d9a
	ld l, a ; $5d9b
	jr nc, .altText ; $5d9c
	inc h ; $5d9e
.altText:
	farcall InitDialogueTextCursor ; $5d9f
	script_speak $12 ; $5da2
	script_facing_lock $12, FACE_RIGHT ; $5da7
	script_face $12, FACE_DOWN ; $5dae
	ret ; $5db5
.speak:
	script_face_toward ACTOR_PLAYER, $12 ; $5db6
	ld a, [wMapSceneStage2] ; $5dbe
	add a ; $5dc1
	ld_hl_indexed RestaurantNpc12TextIds ; $5dc2
	ld a, [hl+] ; $5dc9
	ld h, [hl] ; $5dca
	ld l, a ; $5dcb
	ld a, $02 ; $5dcc
	add l ; $5dce
	ld l, a ; $5dcf
	jr nc, .done ; $5dd0
	inc h ; $5dd2
.done:
	farcall InitDialogueTextCursor ; $5dd3
	script_speak $12 ; $5dd6
	ret ; $5ddb
RestaurantNpc12TextIds:
	; $5ddc, 10 bytes (text_ids)
	dw Text_33_40 ; record 0
	dw Text_33_76 ; record 1
	dw Text_33_123 ; record 2
	dw Text_33_163 ; record 3
	dw Text_33_203 ; record 4
RestaurantNpc08FaceDown_10:
	set_flag FLAG_TEMP_SCENE_VARIANT_B ; $5de6
RestaurantNpc08_10:
	test_flag FLAG_RESTAURANT_NPC08_MOVED ; $5de9
	jr nz, .speak ; $5dec
	ld a, [wMapSceneStage2] ; $5dee
	add a ; $5df1
	ld_hl_indexed RestaurantNpc08TextIds ; $5df2
	ld a, [hl+] ; $5df9
	ld h, [hl] ; $5dfa
	ld l, a ; $5dfb
	farcall InitDialogueTextCursor ; $5dfc
	script_speak $08 ; $5dff
	script_set_speed $08, $0010 ; $5e04
	test_flag FLAG_TEMP_SCENE_VARIANT_B ; $5e0c
	jr z, .altText ; $5e0f
	script_jump_velocity ACTOR_PLAYER, $ff80 ; $5e11
	script_move_target ACTOR_PLAYER, $1f00, $0f00 ; $5e19
	script_wait_move ACTOR_PLAYER ; $5e24
	script_face ACTOR_PLAYER, FACE_RIGHT ; $5e29
.altText:
	script_move_target $08, $2140, $0f00 ; $5e30
	script_wait_move $08 ; $5e3b
	script_wait_frames $0a ; $5e40
	script_set_anim $08, $02 ; $5e47
	script_face $08, FACE_RIGHT ; $5e4e
	set_flag FLAG_RESTAURANT_NPC08_MOVED ; $5e55
	clear_flag FLAG_TEMP_SCENE_VARIANT_B ; $5e58
	ret ; $5e5b
.speak:
	ld a, [wMapSceneStage2] ; $5e5c
	add a ; $5e5f
	ld_hl_indexed RestaurantNpc08TextIds ; $5e60
	ld a, [hl+] ; $5e67
	ld h, [hl] ; $5e68
	ld l, a ; $5e69
	ld a, $01 ; $5e6a
	add l ; $5e6c
	ld l, a ; $5e6d
	jr nc, .done ; $5e6e
	inc h ; $5e70
.done:
	farcall InitDialogueTextCursor ; $5e71
	script_speak $08 ; $5e74
	script_face $08, FACE_RIGHT ; $5e79
	ret ; $5e80
RestaurantNpc08TextIds:
	; $5e81, 10 bytes (text_ids)
	dw Text_33_43 ; record 0
	dw Text_33_79 ; record 1
	dw Text_33_126 ; record 2
	dw Text_33_166 ; record 3
	dw Text_33_206 ; record 4
RestaurantNpc09_10:
	ld a, [wMapSceneStage] ; $5e8b
	add a ; $5e8e
	ld_hl_indexed RestaurantNpc09TextIds ; $5e8f
	ld a, [hl+] ; $5e96
	ld h, [hl] ; $5e97
	ld l, a ; $5e98
	farcall InitDialogueTextCursor ; $5e99
	ld a, [wMapSceneStage] ; $5e9c
	cp STORYRANK_SINGLES_ISLAND_OPEN ; $5e9f
	jr nc, .altText ; $5ea1
	script_speak $09 ; $5ea3
	ret ; $5ea8
.altText:
	ld a, $09 ; $5ea9
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5eab
	farcall RunDialogueYesNoPrompt ; $5eae
	farcall ScriptCloseDialogueWindow ; $5eb1
	script_wait_frames $05 ; $5eb4
	and a ; $5ebb
	jr nz, .done ; $5ebc
	script_set_text Text_33_169 ; $5ebe
	test_flag FLAG_DOUBLES ; $5ec4
	jr z, .speak ; $5ec7
	farcall AdvanceDialogueTextCursor ; $5ec9
.speak:
	script_speak $09 ; $5ecc
	ret ; $5ed1
.done:
	script_set_text Text_33_171 ; $5ed2
	script_speak $09 ; $5ed8
	ret ; $5edd
RestaurantNpc09TextIds:
	; $5ede, 20 bytes (text_ids)
	dw Text_33_45 ; record 0
	dw Text_33_45 ; record 1
	dw Text_33_81 ; record 2
	dw Text_33_82 ; record 3
	dw Text_33_128 ; record 4
	dw Text_33_129 ; record 5
	dw Text_33_168 ; record 6
	dw Text_33_168 ; record 7
	dw Text_33_208 ; record 8
	dw Text_33_208 ; record 9
RestaurantNpc0A_10:
	script_face_toward ACTOR_PLAYER, $0a ; $5ef2
	ld a, [wMapSceneStage] ; $5efa
	add a ; $5efd
	ld_hl_indexed RestaurantNpc0ATextIds ; $5efe
	ld a, [hl+] ; $5f05
	ld h, [hl] ; $5f06
	ld l, a ; $5f07
	farcall InitDialogueTextCursor ; $5f08
	ld a, [wMapSceneStage] ; $5f0b
	cp STORYRANK_SINGLES_ISLAND_OPEN ; $5f0e
	jr nc, .speak ; $5f10
	ld a, $0a ; $5f12
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5f14
	farcall RunDialogueYesNoPrompt ; $5f17
	farcall ScriptCloseDialogueWindow ; $5f1a
	script_wait_frames $05 ; $5f1d
	and a ; $5f24
	jr z, .speak ; $5f25
	farcall AdvanceDialogueTextCursor ; $5f27
.speak:
	script_speak $0a ; $5f2a
	ret ; $5f2f
RestaurantNpc0ATextIds:
	; $5f30, 20 bytes (text_ids)
	dw Text_33_46 ; record 0
	dw Text_33_49 ; record 1
	dw Text_33_83 ; record 2
	dw Text_33_86 ; record 3
	dw Text_33_130 ; record 4
	dw Text_33_130 ; record 5
	dw Text_33_172 ; record 6
	dw Text_33_172 ; record 7
	dw Text_33_209 ; record 8
	dw Text_33_209 ; record 9
RestaurantNpc0B_10:
	ld a, [wMapSceneStage2] ; $5f44
	add a ; $5f47
	ld_hl_indexed RestaurantNpc0BTextIds ; $5f48
	ld a, [hl+] ; $5f4f
	ld h, [hl] ; $5f50
	ld l, a ; $5f51
	farcall InitDialogueTextCursor ; $5f52
	ld a, [wMapSceneStage] ; $5f55
	cp STORYRANK_DOUBLES_ACADEMY ; $5f58
	jr nz, .speak ; $5f5a
	farcall AdvanceDialogueTextCursor ; $5f5c
.speak:
	script_speak $0b ; $5f5f
	ret ; $5f64
RestaurantNpc0BTextIds:
	; $5f65, 10 bytes (text_ids)
	dw Text_33_52 ; record 0
	dw Text_33_89 ; record 1
	dw Text_33_133 ; record 2
	dw Text_33_173 ; record 3
	dw Text_33_210 ; record 4
RestaurantNpc0C_10:
	ld a, [wMapSceneStage2] ; $5f6f
	add a ; $5f72
	ld_hl_indexed RestaurantNpc0CTextIds ; $5f73
	ld a, [hl+] ; $5f7a
	ld h, [hl] ; $5f7b
	ld l, a ; $5f7c
	farcall InitDialogueTextCursor ; $5f7d
	ld a, [wMapSceneStage2] ; $5f80
	cp STORYTIER_ACADEMY ; $5f83
	jr z, .speak ; $5f85
	cp $03 ; $5f87
	jr nc, .ge03 ; $5f89
	ld a, $0c ; $5f8b
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5f8d
	farcall RunDialogueYesNoPrompt ; $5f90
	farcall ScriptCloseDialogueWindow ; $5f93
	script_wait_frames $05 ; $5f96
	and a ; $5f9d
	jr z, .speak ; $5f9e
	farcall AdvanceDialogueTextCursor ; $5fa0
	ld a, [wMapSceneStage] ; $5fa3
	cp STORYRANK_DOUBLES_SENIOR_CHAMP ; $5fa6
	jr nz, .speak ; $5fa8
	farcall AdvanceDialogueTextCursor ; $5faa
	jr .speak ; $5fad
.ge03:
	ld a, [wMapSceneStage] ; $5faf
	and $01 ; $5fb2
	jr z, .speak ; $5fb4
	farcall AdvanceDialogueTextCursor ; $5fb6
.speak:
	script_speak $0c ; $5fb9
	ret ; $5fbe
RestaurantNpc0CTextIds:
	; $5fbf, 10 bytes (text_ids)
	dw Text_33_54 ; record 0
	dw Text_33_90 ; record 1
	dw Text_33_134 ; record 2
	dw Text_33_174 ; record 3
	dw Text_33_211 ; record 4
RestaurantNpc0D_10:
	ld a, [wMapSceneStage2] ; $5fc9
	add a ; $5fcc
	ld_hl_indexed RestaurantNpc0DTextIds ; $5fcd
	ld a, [hl+] ; $5fd4
	ld h, [hl] ; $5fd5
	ld l, a ; $5fd6
	farcall InitDialogueTextCursor ; $5fd7
	ld a, [wMapSceneStage2] ; $5fda
	cp STORYTIER_ISLAND_OPEN ; $5fdd
	jr nz, .advanceDialogueTextCursor ; $5fdf
	ld a, $0d ; $5fe1
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5fe3
	farcall RunDialogueYesNoPrompt ; $5fe6
	farcall ScriptCloseDialogueWindow ; $5fe9
	script_wait_frames $05 ; $5fec
	and a ; $5ff3
	jr z, .advanceDialogueTextCursor ; $5ff4
	farcall AdvanceDialogueTextCursor ; $5ff6
.advanceDialogueTextCursor:
	ld a, [wMapSceneStage] ; $5ff9
	cp STORYRANK_DOUBLES_JUNIOR_CHAMP ; $5ffc
	jr nz, .speak ; $5ffe
	farcall AdvanceDialogueTextCursor ; $6000
.speak:
	script_speak $0d ; $6003
	ret ; $6008
RestaurantNpc0DTextIds:
	; $6009, 10 bytes (text_ids)
	dw Text_33_55 ; record 0
	dw Text_33_93 ; record 1
	dw Text_33_138 ; record 2
	dw Text_33_176 ; record 3
	dw Text_33_213 ; record 4
RestaurantNpc0E_10:
	ld a, [wMapSceneStage2] ; $6013
	add a ; $6016
	ld_hl_indexed RestaurantNpc0ETextIds ; $6017
	ld a, [hl+] ; $601e
	ld h, [hl] ; $601f
	ld l, a ; $6020
	farcall InitDialogueTextCursor ; $6021
	script_speak $0e ; $6024
	ret ; $6029
RestaurantNpc0ETextIds:
	; $602a, 10 bytes (text_ids)
	dw Text_33_56 ; record 0
	dw Text_33_95 ; record 1
	dw Text_33_139 ; record 2
	dw Text_33_179 ; record 3
	dw Text_33_214 ; record 4
RestaurantNpc0F_10:
	ld a, [wMapSceneStage2] ; $6034
	add a ; $6037
	ld_hl_indexed RestaurantNpc0FTextIds ; $6038
	ld a, [hl+] ; $603f
	ld h, [hl] ; $6040
	ld l, a ; $6041
	farcall InitDialogueTextCursor ; $6042
	script_speak $0f ; $6045
	ret ; $604a
RestaurantNpc0FTextIds:
	; $604b, 10 bytes (text_ids)
	dw Text_33_57 ; record 0
	dw Text_33_96 ; record 1
	dw Text_33_140 ; record 2
	dw Text_33_180 ; record 3
	dw Text_33_215 ; record 4
RestaurantNpc10_10:
	ld a, [wMapSceneStage2] ; $6055
	add a ; $6058
	ld_hl_indexed RestaurantNpc10TextIds ; $6059
	ld a, [hl+] ; $6060
	ld h, [hl] ; $6061
	ld l, a ; $6062
	farcall InitDialogueTextCursor ; $6063
	script_speak $10 ; $6066
	ret ; $606b
RestaurantNpc10TextIds:
	; $606c, 10 bytes (text_ids)
	dw Text_33_58 ; record 0
	dw Text_33_97 ; record 1
	dw Text_33_142 ; record 2
	dw Text_33_182 ; record 3
	dw Text_33_217 ; record 4
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
	call SetStoryDialogueStage_10 ; $60f1
	ld a, [wMapSceneStage] ; $60f4
	sra a ; $60f7
	ld [wMapSceneStage2], a ; $60f9
	call RestaurantRestoreNpc12Position_10 ; $60fc
	call RestaurantRestoreNpc08Position_10 ; $60ff
	ret ; $6102
RestaurantRestoreNpc08Position_10:
	test_flag FLAG_RESTAURANT_NPC08_MOVED ; $6103
	jr z, .done ; $6106
	script_set_position $08, $2140, $0f00 ; $6108
	script_face $08, FACE_RIGHT ; $6113
.done:
	ret ; $611a
RestaurantRestoreNpc12Position_10:
	call TestRestaurantNpc12StageFlag_10 ; $611b
	jr z, .done ; $611e
	script_set_position $12, $1b00, $1100 ; $6120
.done:
	ret ; $612b
TestRestaurantNpc12StageFlag_10:
	ld a, [wMapSceneStage2] ; $612c
	add a ; $612f
	ld_hl_indexed RestaurantNpc12StageFlagTable_10 ; $6130
	ld a, [hl+] ; $6137
	ld d, [hl] ; $6138
	ld e, a ; $6139
	call TestGameFlagByNumber ; $613a
	ret ; $613d
SetRestaurantNpc12StageFlag_10:
	ld a, [wMapSceneStage2] ; $613e
	add a ; $6141
	ld_hl_indexed RestaurantNpc12StageFlagTable_10 ; $6142
	ld a, [hl+] ; $6149
	ld d, [hl] ; $614a
	ld e, a ; $614b
	call SetGameFlagByNumber ; $614c
	ret ; $614f
RestaurantNpc12StageFlagTable_10:
	; $6150, 10 bytes (flag_ids)
	dw $0070 ; 0: flag $00, 3
	dw $0071 ; 1: flag $00, 3
	dw $0072 ; 2: flag $00, 3
	dw $0073 ; 3: flag $00, 3
	dw $007a ; 4: flag $00, 3
RestaurantShowActor11NearPlayer_10:
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
	ld hl, wMapScratch + 6 ; $6174
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
	ld hl, wMapScratch + 8 ; $6187
	ld a, e ; $618a
	ld [hl+], a ; $618b
	ld [hl], d ; $618c
	ld hl, wMapScratch + 6 ; $618d
	ld a, [hl+] ; $6190
	ld b, [hl] ; $6191
	ld c, a ; $6192
	ld hl, wMapScratch + 8 ; $6193
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
	map_actor $0000, ActorScript_10_2, $3f00, $1900, FACE_RIGHT, $63, $01, $00
	map_actor $0000, ActorScript_10_2, $1900, $3f00, FACE_RIGHT, $36, $01, $00
	map_actor $0000, ActorScript_10_2, $2700, $3240, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_10_2, $2700, $30c0, FACE_DOWN, $74, $01, $00
	map_actor_end
AcademyWingEntryPoints_10:
	; $6201, 17 bytes (map_entries)
	map_entry $01, FACE_DOWN, $3b00, $3900, MapArrivalWalkPair_10
	map_entry $0f, FACE_UP, $2000, $3400, MapScriptNop_10
	db $ff
AcademyWingExitTriggers_10:
	; $6212, 41 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_ACADEMY_ENTRANCE, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_COURTYARD, $03
	map_script $03, FACEMASK_ANY, $0000, MapExitWalkCurveRight_10, STORYLOC_ACADEMY_MAIN_BLDG, $04
	map_script $04, FACEMASK_ANY, $0000, MapExitWalkCurveLeft_10, STORYLOC_ACADEMY_MAIN_BLDG, $03
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_COURTYARD, $0f
	db $ff
AcademyWingNpc03_10:
	script_face_toward ACTOR_PLAYER, $03 ; $623b
	test_flag FLAG_TEMP_SCENE_VARIANT_A ; $6243
	jr z, .altText ; $6246
	script_set_text Text_30_517 ; $6248
	jr .done ; $624e
.altText:
	script_get_actor_state $06 ; $6250
	ld c, l ; $6255
	ld b, h ; $6256
	ld hl, $0037 ; $6257
	add hl, bc ; $625a
	ld a, [hl] ; $625b
	or $20 ; $625c
	ld [hl], a ; $625e
	script_set_position $06, $1b80, $2e00 ; $625f
	sound $97 ; $626a
	script_wait_frames $3c ; $626c
	script_set_position $06, $0100, $0100 ; $6273
	script_set_text Text_30_513 ; $627e
	test_flag FLAG_DOUBLES ; $6284
	jr z, .speak ; $6287
	farcall AdvanceDialogueTextCursor ; $6289
.speak:
	ld a, $03 ; $628c
	farcall ScriptShowSpeakerDialogueRestoreBG ; $628e
	script_set_text Text_30_515 ; $6291
	farcall RunDialogueYesNoPrompt ; $6297
	farcall ScriptCloseDialogueWindow ; $629a
	script_wait_frames $05 ; $629d
	and a ; $62a4
	jr nz, .done ; $62a5
	script_set_text Text_30_516 ; $62a7
	set_flag FLAG_TEMP_SCENE_VARIANT_A ; $62ad
.done:
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
	ld a, [wMapSceneStage] ; $62d0
	cp ACADEMYWINGSTAGE_SENIOR_CHAMP ; $62d3
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
	call AcademyWingOpenDoor_10 ; $6381
	test_flag FLAG_DOUBLES ; $6384
	jr z, .walkPlayer ; $6387
	script_move_target ACTOR_PARTNER, $2100, $3d00 ; $6389
	script_wait_move ACTOR_PARTNER ; $6394
.walkPlayer:
	script_move_target ACTOR_PLAYER, $2100, $3900 ; $6399
	script_wait_move ACTOR_PLAYER ; $63a4
	script_wait_frames $02 ; $63a9
	script_move_angle ACTOR_PLAYER, FACE_UP, $0200 ; $63b0
	script_wait_move ACTOR_PLAYER ; $63ba
	script_move_angle ACTOR_PLAYER, FACE_LEFT, $0200 ; $63bf
	script_wait_move ACTOR_PLAYER ; $63c9
	script_wait_frames $0a ; $63ce
	script_face ACTOR_PLAYER, FACE_UP ; $63d5
	call AcademyWingCloseDoor_10 ; $63dc
	ret ; $63df
AcademyWingTile02_10:
	script_face ACTOR_PLAYER, FACE_DOWN ; $63e0
	script_set_speed ACTOR_PLAYER, $0010 ; $63e7
	call AcademyWingOpenDoor_10 ; $63ef
	script_move_target ACTOR_PARTNER, $2100, $3500 ; $63f2
	test_flag FLAG_DOUBLES ; $63fd
	jr z, .walkPlayer ; $6400
.walkPlayer:
	script_move_target ACTOR_PLAYER, $2100, $3900 ; $6402
	script_wait_move ACTOR_PLAYER ; $640d
	script_move_angle ACTOR_PLAYER, FACE_DOWN, $0200 ; $6412
	script_wait_move ACTOR_PLAYER ; $641c
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $0200 ; $6421
	script_wait_move ACTOR_PLAYER ; $642b
	script_wait_frames $05 ; $6430
	call AcademyWingCloseDoor_10 ; $6437
	ret ; $643a
AcademyWingInitScript_10:
	script_set_anim $05, $06 ; $643b
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $6442
	jr nz, .checkDoublesFinal ; $6445
	script_set_position $05, $0100, $0100 ; $6447
.checkDoublesFinal:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $6452
	jr nz, .byStage ; $6455
	script_set_position $06, $0100, $0100 ; $6457
.byStage:
	call SetAcademyWingDialogueStage_10 ; $6462
	ld a, [wMapSceneStage] ; $6465
	cp ACADEMYWINGSTAGE_COMPLETE ; $6468
	jr nz, .stage4 ; $646a
	ldh a, [hRomBank] ; $646c
	ld hl, AcademyWingInitActors1_10 ; $646e
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
	call AcademyWingHideActorByProgressFlag_10 ; $6489
	script_set_position $03, $1d00, $3000 ; $648c
	script_face $03, FACE_UP ; $6497
.stage4:
	ld a, [wMapSceneStage] ; $649e
	cp ACADEMYWINGSTAGE_SENIOR_CHAMP ; $64a1
	jr nz, .stage5 ; $64a3
	script_set_position $03, $19a0, $32c0 ; $64a5
.stage5:
	ld a, $16 ; $64b0
	ld [wMapScrollMinX], a ; $64b2
	ld a, $28 ; $64b5
	ld [wMapScrollMinY], a ; $64b7
	ld a, $40 ; $64ba
	ld [wMapWidthTiles], a ; $64bc
	ld a, $3e ; $64bf
	ld [wMapHeightTiles], a ; $64c1
	call DisableLCDSafely ; $64c4
	ld a, $00 ; $64c7
	farcall CopyScrolledSceneTilemapToVram ; $64c9
	call EnableLCD ; $64cc
	ld a, [wStoryModeEntryPoint] ; $64cf
	cp $0d ; $64d2
	jp z, .stage6 ; $64d4
	cp $0f ; $64d7
	jp z, AcademyWingInitActors0_10.eq0f ; $64d9
	call AcademyWingInstallDoorTriggers_10 ; $64dc
	ret ; $64df
.stage6:
	ldh a, [hRomBank] ; $64e0
	ld hl, AcademyWingInitActors0_10 ; $64e2
	farcall ScriptRespawnLocationActors ; $64e5
	farcall BeginCutsceneScriptMode ; $64e8
	script_set_anim $0a, $06 ; $64eb
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $64f2
	jr nz, .placeActors ; $64f5
	script_set_position $0a, $0100, $0100 ; $64f7
.placeActors:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $6502
	jr nz, .done ; $6505
	script_set_position $0b, $0100, $0100 ; $6507
.done:
	script_player_speed $00f0 ; $6512
	script_move_player $1f00, $3b00 ; $6518
	farcall WaitPlayerMoveDone ; $6522
	script_set_position ACTOR_PLAYER, $3500, $3b00 ; $6525
	xor a ; $6530
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
	test_flag FLAG_DOUBLES ; $65d1
	jp z, .placeActors2 ; $65d4
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
	jr .face ; $66a0
.placeActors2:
	script_set_position $05, $2180, $3100 ; $66a2
	sound $97 ; $66ad
	script_wait_frames $1e ; $66af
	script_speak $08 ; $66b6
	script_set_position $05, $3f00, $3f00 ; $66bb
.face:
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
	test_flag FLAG_DOUBLES ; $6921
	jp z, .walkPlayer ; $6924
	script_null_script ACTOR_PARTNER ; $6927
	script_set_position ACTOR_PARTNER, $2d00, $3b00 ; $692c
	script_move_target ACTOR_PLAYER, $2100, $3b00 ; $6937
	script_move_target ACTOR_PARTNER, $2300, $3b00 ; $6942
	script_wait_move ACTOR_PARTNER ; $694d
	script_wait_frames $05 ; $6952
	script_face ACTOR_PLAYER, FACE_UP ; $6959
	call AcademyWingOpenDoor_10 ; $6960
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
	jr .academyWingCloseDoor ; $69be
.walkPlayer:
	script_move_target ACTOR_PLAYER, $2100, $3b00 ; $69c0
	script_wait_move ACTOR_PLAYER ; $69cb
	script_face ACTOR_PLAYER, FACE_UP ; $69d0
	call AcademyWingOpenDoor_10 ; $69d7
	script_move_target ACTOR_PLAYER, $2100, $3500 ; $69da
	script_wait_move ACTOR_PLAYER ; $69e5
	script_move_target ACTOR_PLAYER, $2000, $3500 ; $69ea
	script_wait_move ACTOR_PLAYER ; $69f5
	script_face ACTOR_PLAYER, FACE_UP ; $69fa
	script_wait_frames $01 ; $6a01
.academyWingCloseDoor:
	call AcademyWingCloseDoor_10 ; $6a08
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
	test_flag FLAG_DOUBLES ; $6ac9
	jp z, .placeActors3 ; $6acc
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
	jp .wait ; $6b70
.placeActors3:
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
.wait:
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
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $6c54
	jr z, .checkFlag ; $6c57
	inc l ; $6c59
.checkFlag:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $6c5a
	jr z, .pushArg ; $6c5d
	inc l ; $6c5f
.pushArg:
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
	and a ; $6d92
	jp z, .animate ; $6d93
	script_set_anim $06, $02 ; $6d96
	script_wait_idle $06 ; $6d9d
	script_speak $06 ; $6da2
	test_flag FLAG_DOUBLES ; $6da7
	jp z, .walk ; $6daa
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
	jr .loop ; $6e25
.walk:
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
.loop:
	script_set_anim $09, $04 ; $6e87
	script_wait_idle $09 ; $6e8e
	script_set_text Text_30_491 ; $6e93
	ld a, $09 ; $6e99
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6e9b
	farcall RunDialogueYesNoPrompt ; $6e9e
	farcall ScriptCloseDialogueWindow ; $6ea1
	script_wait_frames $05 ; $6ea4
	and a ; $6eab
	jr nz, .loop ; $6eac
.animate:
	script_set_anim $06, $03 ; $6eae
	script_wait_idle $06 ; $6eb5
	script_face $07, FACE_UP ; $6eba
	script_face $08, FACE_UP ; $6ec1
	script_face $09, FACE_UP ; $6ec8
	script_face ACTOR_PLAYER, FACE_UP ; $6ecf
	test_flag FLAG_DOUBLES ; $6ed6
	jp z, .wait2 ; $6ed9
	script_face ACTOR_PARTNER, FACE_UP ; $6edc
.wait2:
	script_wait_frames $14 ; $6ee3
	script_set_anim $07, $03 ; $6eea
	script_set_anim $08, $03 ; $6ef1
	script_set_anim $09, $03 ; $6ef8
	test_flag FLAG_DOUBLES ; $6eff
	jp z, .animate2 ; $6f02
	script_set_anim ACTOR_PARTNER, $03 ; $6f05
.animate2:
	script_set_anim ACTOR_PLAYER, $03 ; $6f0c
	script_wait_idle ACTOR_PLAYER ; $6f13
	script_set_text Text_30_492 ; $6f18
	script_speak $06 ; $6f1e
	ld c, $04 ; $6f23
	call BeginFadeOut ; $6f25
	call WaitFadeEnd ; $6f28
	script_wait_frames $32 ; $6f2b
	ld a, STORYLOC_DORM_ROOM ; $6f32
	ld [wStoryModeCurrentLocation], a ; $6f34
	ld a, $0a ; $6f37
	ld [wStoryModeEntryPoint], a ; $6f39
	ld a, $ff ; $6f3c
	ld [wUnusedExitTriggerIdMirror], a ; $6f3e
	ld [wStoryModeExitTriggerRequest], a ; $6f41
	ret ; $6f44
AcademyWingInitActors0_10:
	; $6f45, 136 bytes (map_actors)
	map_actor $0000, ActorScript_10_2, $fd00, $0100, FACE_DOWN, $4e, $01, $00
	map_actor $0000, ActorScript_10_2, $fd00, $0100, FACE_DOWN, $53, $01, $00
	map_actor $0000, ActorScript_10_2, $fd00, $0100, FACE_DOWN, $51, $01, $00
	map_actor $0000, ActorScript_10_2, $2000, $2f00, FACE_DOWN, $63, $01, $00
	map_actor $0000, ActorScript_10_2, $2200, $3300, FACE_UP, $4b, $01, $00
	map_actor $0000, ActorScript_10_2, $2000, $3300, FACE_UP, $4a, $01, $00
	map_actor $0000, ActorScript_10_2, $1e00, $3300, FACE_UP, $49, $01, $00
	map_actor $0000, ActorScript_10_2, $2700, $3240, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_10_2, $2700, $30c0, FACE_DOWN, $74, $01, $00
	map_actor_end
.eq0f:
	ldh a, [hRomBank] ; $6fcd
	ld hl, AcademyWingInitActors1_10 ; $6fcf
	farcall ScriptRespawnLocationActors ; $6fd2
	farcall BeginCutsceneScriptMode ; $6fd5
	script_set_anim $04, $06 ; $6fd8
	test_flag FLAG_DOUBLES ; $6fdf
	jp z, .checkFlag2 ; $6fe2
	script_null_script ACTOR_PARTNER ; $6fe5
	script_set_position ACTOR_PLAYER, $1f00, $3400 ; $6fea
	script_set_position ACTOR_PARTNER, $2100, $3400 ; $6ff5
	script_face ACTOR_PARTNER, FACE_UP ; $7000
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $7007
	jr nz, .face2 ; $700a
	script_set_position $04, $3f00, $3f00 ; $700c
	jr .face2 ; $7017
.checkFlag2:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $7019
	jr nz, .face2 ; $701c
	script_set_position $05, $3f00, $3f00 ; $701e
.face2:
	script_face ACTOR_PLAYER, FACE_UP ; $7029
	xor a ; $7030
	ld [wStoryModeShowLocationName], a ; $7031
	script_fade_in $04 ; $7034
	call WaitFadeEnd ; $7039
	script_wait_frames $3c ; $703c
	script_set_text Text_30_498 ; $7043
	call SpeakNpc03SinglesOrDoublesLine_10 ; $7049
	test_flag FLAG_DOUBLES ; $704c
	jp z, .animate3 ; $704f
	script_set_anim ACTOR_PARTNER, $02 ; $7052
.animate3:
	script_set_anim ACTOR_PLAYER, $02 ; $7059
	script_wait_idle ACTOR_PLAYER ; $7060
	call ShowNpc03SinglesOrDoublesPrompt_10 ; $7065
	farcall RunDialogueYesNoPrompt ; $7068
	farcall ScriptCloseDialogueWindow ; $706b
	script_wait_frames $05 ; $706e
	and a ; $7075
	jr nz, .animate4 ; $7076
	script_set_anim ACTOR_PLAYER, $03 ; $7078
	script_wait_idle ACTOR_PLAYER ; $707f
	farcall AdvanceDialogueTextCursor ; $7084
	jr .wait3 ; $7087
.animate4:
	script_set_anim ACTOR_PLAYER, $04 ; $7089
	script_wait_idle ACTOR_PLAYER ; $7090
.wait3:
	script_wait_frames $0a ; $7095
	script_set_anim $03, $03 ; $709c
	script_wait_idle $03 ; $70a3
	script_speak $03 ; $70a8
	script_face $03, FACE_UP ; $70ad
	script_wait_frames $50 ; $70b4
	script_set_text Text_30_504 ; $70bb
	call SpeakNpc03SinglesOrDoublesLine_10 ; $70c1
	test_flag FLAG_DOUBLES ; $70c4
	jp z, .placeActors4 ; $70c7
	script_set_position $06, $2080, $3200 ; $70ca
	script_set_position $07, $2280, $3200 ; $70d5
	sound $97 ; $70e0
	script_wait_frames $50 ; $70e2
	script_set_position $06, $3f00, $3f00 ; $70e9
	script_set_position $07, $3f00, $3f00 ; $70f4
	jr .face3 ; $70ff
.placeActors4:
	script_set_position $06, $2180, $3200 ; $7101
	sound $97 ; $710c
	script_wait_frames $50 ; $710e
	script_set_position $06, $3f00, $3f00 ; $7115
.face3:
	script_face $03, FACE_DOWN ; $7120
	script_wait_frames $01 ; $7127
	call SpeakNpc03SinglesOrDoublesLine_10 ; $712e
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
.loopB:
	ld a, $03 ; $71bb
	farcall ScriptShowSpeakerDialogueRestoreBG ; $71bd
	farcall RunDialogueYesNoPrompt ; $71c0
	farcall ScriptCloseDialogueWindow ; $71c3
	script_wait_frames $05 ; $71c6
	and a ; $71cd
	jr z, .checkDoubles ; $71ce
	script_set_anim ACTOR_PLAYER, $04 ; $71d0
	script_wait_idle ACTOR_PLAYER ; $71d7
	script_set_anim $03, $02 ; $71dc
	script_wait_idle $03 ; $71e3
	script_set_text Text_30_511 ; $71e8
	jr .loopB ; $71ee
.checkDoubles:
	test_flag FLAG_DOUBLES ; $71f0
	jp z, .animate5 ; $71f3
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
	call AcademyWingOpenDoor_10 ; $7287
	script_set_actor_script ACTOR_PLAYER, ActorScript_10_0 ; $728a
	script_set_actor_script ACTOR_PARTNER, ActorScript_10_0 ; $7295
	script_wait_frames $28 ; $72a0
	jr .academyWingCloseDoor2 ; $72a7
.animate5:
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
	call AcademyWingOpenDoor_10 ; $72ff
	script_set_actor_script ACTOR_PLAYER, ActorScript_10_0 ; $7302
	script_wait_frames $14 ; $730d
.academyWingCloseDoor2:
	call AcademyWingCloseDoor_10 ; $7314
	script_wait_frames $3c ; $7317
	ld c, $02 ; $731e
	call BeginFadeOut ; $7320
	call WaitFadeEnd ; $7323
	ld a, STORYLOC_ACADEMY_ENTRANCE ; $7326
	ld [wStoryModeCurrentLocation], a ; $7328
	ld a, $0c ; $732b
	ld [wStoryModeEntryPoint], a ; $732d
	ld a, $ff ; $7330
	ld [wUnusedExitTriggerIdMirror], a ; $7332
	ld [wStoryModeExitTriggerRequest], a ; $7335
	ret ; $7338
AcademyWingOpenDoor_10:
	script_wait_frames $0a ; $7339
	sound SFX_DOOR_ALT ; $7340
	script_copy_scene_rect $07, $38, $20, $38, $02, $02 ; $7342
	script_wait_frames $02 ; $7351
	script_copy_scene_rect $0b, $38, $20, $38, $02, $02 ; $7358
	script_wait_frames $04 ; $7367
	ret ; $736e
AcademyWingCloseDoor_10:
	sound SFX_DOOR_ALT ; $736f
	script_copy_scene_rect $07, $38, $20, $38, $02, $02 ; $7371
	script_wait_frames $02 ; $7380
	script_copy_scene_rect $03, $38, $20, $38, $02, $02 ; $7387
	script_wait_frames $04 ; $7396
	ret ; $739d
AcademyWingInitActors1_10:
	; $739e, 80 bytes (map_actors)
	map_actor $0000, ActorScript_10_2, $2000, $3000, FACE_DOWN, $63, $01, $00
	map_actor $0000, ActorScript_10_2, $2700, $3240, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_10_2, $2700, $30c0, FACE_DOWN, $74, $01, $00
	map_actor $0000, ActorScript_10_2, $fd00, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_10_2, $fd00, $0100, FACE_DOWN, $4c, $01, $00
	map_actor_end
SpeakNpc03SinglesOrDoublesLine_10:
	test_flag FLAG_DOUBLES ; $73ee
	jr z, .doubles ; $73f1
	farcall AdvanceDialogueTextCursor ; $73f3
	script_speak $03 ; $73f6
	ret ; $73fb
.doubles:
	script_speak $03 ; $73fc
	farcall AdvanceDialogueTextCursor ; $7401
	ret ; $7404
ShowNpc03SinglesOrDoublesPrompt_10:
	test_flag FLAG_DOUBLES ; $7405
	jr z, .notDoubles ; $7408
	farcall AdvanceDialogueTextCursor ; $740a
	ld a, $03 ; $740d
	farcall ScriptShowSpeakerDialogueRestoreBG ; $740f
	ret ; $7412
.notDoubles:
	ld a, $03 ; $7413
	farcall ScriptShowSpeakerDialogueRestoreBG ; $7415
	farcall AdvanceDialogueTextCursor ; $7418
	ret ; $741b
ActorScript_10_0:
	; $741c, 13 bytes (actor_script)
	as_set_target $2100, $3b00
	as_wait_move
	as_set_target $3500, $3b00
	as_wait_move
	as_halt
AcademyWingInstallDoorTriggers_10:
	ld a, [wMapSceneStage] ; $7429
	cp ACADEMYWINGSTAGE_COMPLETE ; $742c
	jr nz, .done ; $742e
	ld a, $11 ; $7430
	ld d, $20 ; $7432
	ld e, $3a ; $7434
	farcall WriteBehaviorMapCell ; $7436
	ld a, $21 ; $7439
	ld d, $20 ; $743b
	ld e, $36 ; $743d
	farcall WriteBehaviorMapCell ; $743f
.done:
	ret ; $7442
AcademyWingHideActorByProgressFlag_10:
	script_set_anim $04, $06 ; $7443
	test_flag FLAG_DOUBLES ; $744a
	jr z, .checkFlag ; $744d
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; $744f
	jr nz, .done ; $7452
	script_set_position $04, $0100, $0100 ; $7454
	jr .done ; $745f
.checkFlag:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_FINAL ; $7461
	jr nz, .done ; $7464
	script_set_position $05, $0100, $0100 ; $7466
.done:
	ret ; $7471
SetAcademyWingDialogueStage_10:
	ld a, ACADEMYWINGSTAGE_PRE_SENIOR_CHAMP ; $7472
	test_flag FLAG_DOUBLES ; $7474
	jr z, .checkFlag ; $7477
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7479
	jr z, .step ; $747c
	ld a, ACADEMYWINGSTAGE_SENIOR_CHAMP ; $747e
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7480
	jr z, .step ; $7483
	ld a, ACADEMYWINGSTAGE_ISLAND_OPEN ; $7485
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7487
	jr z, .step ; $748a
	ld a, ACADEMYWINGSTAGE_COMPLETE ; $748c
	jr .step ; $748e
.checkFlag:
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7490
	jr z, .step ; $7493
	ld a, ACADEMYWINGSTAGE_SENIOR_CHAMP ; $7495
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7497
	jr z, .step ; $749a
	ld a, ACADEMYWINGSTAGE_ISLAND_OPEN ; $749c
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $749e
	jr z, .step ; $74a1
	ld a, ACADEMYWINGSTAGE_COMPLETE ; $74a3
.step:
	ld [wMapSceneStage], a ; $74a5
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
	map_actor $0000, ActorScript_10_2, $1d00, $1780, FACE_DOWN, $3f, $01, $04
	map_actor $0000, ActorScript_10_2, $0e80, $0f00, FACE_LEFT, $40, $01, $00
	map_actor $0000, ActorScript_10_2, $0500, $0f80, FACE_DOWN, $3f, $01, $07
	map_actor $0000, ActorScript_10_3, $2800, $1e00, FACE_DOWN, $41, $01, $03
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
; Instruction-identical to AcademyArrivalArrival01_11 and DormEntranceArrival02_12 (one copy per bank); a change here belongs in every copy.
AcademyMainBldgArrival02_10:
	ld a, [wStoryModeEntryPoint] ; $7532
	cp STORYENTRY_NONE ; $7535
	jp z, .done ; $7537
	test_flag FLAG_DOUBLES ; $753a
	jr z, .walkOff ; $753d
	script_set_speed ACTOR_PARTNER, $00ff ; $753f
	script_move_angle ACTOR_PARTNER, FACE_UP, $0200 ; $7547
	script_wait_move ACTOR_PARTNER ; $7551
	script_face ACTOR_PARTNER, FACE_DOWN ; $7556
	script_set_speed ACTOR_PARTNER, $0010 ; $755d
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $7565
	script_move_angle ACTOR_PLAYER, FACE_DOWN, $0200 ; $756d
.done:
	ret ; $7577
; Instruction-identical to RestaurantArrival01_10, MapArrivalWalk_11, DormEntranceArrival01_12 and RestaurantPlazaArrival04_13 (one copy per bank); a change here belongs in every copy.
AcademyMainBldgArrival01_10:
	ld a, [wStoryModeEntryPoint] ; $7578
	cp STORYENTRY_NONE ; $757b
	jp z, .done ; $757d
	test_flag FLAG_DOUBLES ; $7580
	jr z, .walkOff ; $7583
	script_set_speed ACTOR_PARTNER, $00ff ; $7585
	script_move_angle ACTOR_PARTNER, FACE_DOWN, $0200 ; $758d
	script_wait_move ACTOR_PARTNER ; $7597
	script_face ACTOR_PARTNER, FACE_UP ; $759c
	script_set_speed ACTOR_PARTNER, $0010 ; $75a3
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $75ab
	script_move_angle ACTOR_PLAYER, FACE_UP, $0200 ; $75b3
.done:
	ret ; $75bd
AcademyMainBldgExitTriggers_10:
	; $75be, 41 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_ACADEMY_ENTRANCE, $01
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_COURTYARD, $03
	map_script $03, FACEMASK_ANY, $0000, MapExitWalkCurveRight_10, STORYLOC_ACADEMY_WING, $01
	map_script $04, FACEMASK_ANY, $0000, MapExitWalkCurveLeft_10, STORYLOC_ACADEMY_MAIN_BLDG, $03
	map_script $0f, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_COURTYARD, $0f
	db $ff
AcademyMainBldgNpc03_10:
	ld a, [wMapSceneStage] ; $75e7
	sra a ; $75ea
	add a ; $75ec
	ld_hl_indexed AcademyMainBldgNpc03TextIds ; $75ed
	ld a, [hl+] ; $75f4
	ld h, [hl] ; $75f5
	ld l, a ; $75f6
	farcall InitDialogueTextCursor ; $75f7
	ld a, [wMapSceneStage] ; $75fa
	sra a ; $75fd
	cp STORYTIER_ISLAND_OPEN ; $75ff
	jr z, .eq03 ; $7601
	script_speak $03 ; $7603
	ret ; $7608
.eq03:
	ld a, $03 ; $7609
	farcall ScriptShowSpeakerDialogueRestoreBG ; $760b
	farcall RunDialogueYesNoPrompt ; $760e
	farcall ScriptCloseDialogueWindow ; $7611
	script_wait_frames $05 ; $7614
	and a ; $761b
	jr z, .speak ; $761c
	farcall AdvanceDialogueTextCursor ; $761e
.speak:
	script_speak $03 ; $7621
	ret ; $7626
AcademyMainBldgNpc03TextIds:
	; $7627, 10 bytes (text_ids)
	dw Text_30_440 ; record 0
	dw Text_30_443 ; record 1
	dw Text_30_446 ; record 2
	dw Text_30_452 ; record 3
	dw Text_30_457 ; record 4
AcademyMainBldgNpc04_10:
	ld a, [wMapSceneStage] ; $7631
	sra a ; $7634
	add a ; $7636
	ld_hl_indexed AcademyMainBldgNpc04TextIds ; $7637
	ld a, [hl+] ; $763e
	ld h, [hl] ; $763f
	ld l, a ; $7640
	farcall InitDialogueTextCursor ; $7641
	script_speak $04 ; $7644
	ret ; $7649
AcademyMainBldgNpc04TextIds:
	; $764a, 10 bytes (text_ids)
	dw Text_30_441 ; record 0
	dw Text_30_444 ; record 1
	dw Text_30_447 ; record 2
	dw Text_30_455 ; record 3
	dw Text_30_458 ; record 4
AcademyMainBldgNpc05_10:
	script_set_text Text_30_462 ; $7654
	script_speak $05 ; $765a
	script_face $05, FACE_DOWN ; $765f
	test_flag FLAG_DOUBLES ; $7666
	jr nz, AcademyMainBldgNpc05TextIds.setText ; $7669
	script_speak $05 ; $766b
	ld a, [wMapSceneStage] ; $7670
	sra a ; $7673
	add a ; $7675
	ld_hl_indexed AcademyMainBldgNpc05TextIds ; $7676
	ld a, [hl+] ; $767d
	ld h, [hl] ; $767e
	ld l, a ; $767f
	farcall InitDialogueTextCursor ; $7680
.loop:
	script_wait_frames $14 ; $7683
	script_face_toward ACTOR_PLAYER, $05 ; $768a
	script_speak $05 ; $7692
	ret ; $7697
AcademyMainBldgNpc05TextIds:
	; $7698, 10 bytes (text_ids)
	dw Text_30_464 ; record 0
	dw Text_30_465 ; record 1
	dw Text_30_466 ; record 2
	dw Text_30_467 ; record 3
	dw Text_30_468 ; record 4
.setText:
	script_set_text Text_30_469 ; $76a2
	script_wait_frames $14 ; $76a8
	script_speak $05 ; $76af
	call GetDoublesProgressStage_10 ; $76b4
	add a ; $76b7
	ld_hl_indexed AcademyMainBldgNpc05TextIds2 ; $76b8
	ld a, [hl+] ; $76bf
	ld h, [hl] ; $76c0
	ld l, a ; $76c1
	farcall InitDialogueTextCursor ; $76c2
	jr AcademyMainBldgNpc05_10.loop ; $76c5
AcademyMainBldgNpc05TextIds2:
	; $76c7, 10 bytes (text_ids)
	dw Text_30_470 ; record 0
	dw Text_30_471 ; record 1
	dw Text_30_472 ; record 2
	dw Text_30_473 ; record 3
	dw Text_30_474 ; record 4
AcademyMainBldgNpc06_10:
	ld a, [wMapSceneStage] ; $76d1
	sra a ; $76d4
	add a ; $76d6
	ld_hl_indexed AcademyMainBldgNpc06TextIds ; $76d7
	ld a, [hl+] ; $76de
	ld h, [hl] ; $76df
	ld l, a ; $76e0
	farcall InitDialogueTextCursor ; $76e1
	script_speak $06 ; $76e4
	ret ; $76e9
AcademyMainBldgNpc06TextIds:
	; $76ea, 10 bytes (text_ids)
	dw Text_30_442 ; record 0
	dw Text_30_445 ; record 1
	dw Text_30_448 ; record 2
	dw Text_30_456 ; record 3
	dw Text_30_459 ; record 4
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
	call SetStoryDialogueStage_10 ; $7717
	ld a, [wMapSceneStage] ; $771a
	sra a ; $771d
	cp STORYTIER_SENIOR_CHAMP ; $771f
	jr nz, .ne02 ; $7721
	script_set_actor_script $03, ActorScript_10_1 ; $7723
.ne02:
	ld a, $01 ; $772e
	ld hl, UpdatePlayerPairTileAnimState_10 ; $7730
	call RegisterFrameTask ; $7733
	ld a, [wStoryModeEntryPoint] ; $7736
	cp $0f ; $7739
	jr nz, .done ; $773b
	call AcademyMainBldgNewStudentCutscene_10 ; $773d
.done:
	ret ; $7740
AcademyMainBldgNewStudentCutscene_10:
	ldh a, [hRomBank] ; $7741
	ld hl, AcademyMainBldgNewStudentActors_10 ; $7743
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
	ld a, [wStoryModeGenderOfMainCharacter] ; $7844
	or a ; $7847
	jr z, .speak ; $7848
	farcall AdvanceDialogueTextCursor ; $784a
.speak:
	script_speak $03 ; $784d
	ld a, [wStoryModeGenderOfMainCharacter] ; $7852
	or a ; $7855
	jr nz, .wait ; $7856
	farcall AdvanceDialogueTextCursor ; $7858
.wait:
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
	ld [wUnusedExitTriggerIdMirror], a ; $7976
	ld [wStoryModeExitTriggerRequest], a ; $7979
	farcall EndCutsceneScriptMode ; $797c
	ret ; $797f
AcademyMainBldgNewStudentActors_10:
	; $7980, 80 bytes (map_actors)
	map_actor $0000, ActorScript_10_2, $2b00, $0b00, FACE_DOWN, $49, $01, $00
	map_actor $0000, ActorScript_10_2, $1d00, $1700, FACE_DOWN, $3f, $01, $04
	map_actor $0000, ActorScript_10_2, $fd00, $0100, FACE_DOWN, $4c, $01, $00
	map_actor $0000, ActorScript_10_2, $fd00, $0100, FACE_DOWN, $4d, $01, $00
	map_actor $0000, ActorScript_10_2, $fd00, $0100, FACE_DOWN, $4f, $01, $00
	map_actor_end
UpdatePlayerPairTileAnimState_10:
	ld a, $00 ; $79d0
	call UpdateActorTileAnimState_10 ; $79d2
	test_flag FLAG_DOUBLES ; $79d5
	ret z ; $79d8
	ld a, $02 ; $79d9
	call UpdateActorTileAnimState_10 ; $79db
	ret ; $79de
UpdateActorTileAnimState_10:
	ld h, a ; $79df
	ld l, $00 ; $79e0
	push af ; $79e2
	wram_bank $04 ; $79e3
	srl h ; $79e9
	rr l ; $79eb
	srl h ; $79ed
	rr l ; $79ef
	ld bc, wActors ; $79f1
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
	add $40 ; $7a08
	ld a, [hl] ; $7a0a
	adc $00 ; $7a0b
	ld e, a ; $7a0d
	dec e ; $7a0e
	pop af ; $7a0f
	or a ; $7a10
	jr z, .readCell ; $7a11
	dec e ; $7a13
	dec e ; $7a14
.readCell:
	push de ; $7a15
	call ReadSceneTilemapTile_10 ; $7a16
	pop de ; $7a19
	and $87 ; $7a1a
	cp $06 ; $7a1c
	jr nz, .checkBelow ; $7a1e
	wram_bank $04 ; $7a20
	ld hl, $0020 ; $7a26
	add hl, bc ; $7a29
	ld a, [hl] ; $7a2a
	xor $01 ; $7a2b
	ld [hl], a ; $7a2d
	ret ; $7a2e
.checkBelow:
	inc d ; $7a2f
	call ReadSceneTilemapTile_10 ; $7a30
	and $07 ; $7a33
	cp $06 ; $7a35
	jr nz, .actorLoop ; $7a37
	wram_bank $04 ; $7a39
	ld hl, $0020 ; $7a3f
	add hl, bc ; $7a42
	ld a, [hl] ; $7a43
	xor $01 ; $7a44
	ld [hl], a ; $7a46
	ret ; $7a47
.actorLoop:
	wram_bank $04 ; $7a48
	ld hl, $0020 ; $7a4e
	add hl, bc ; $7a51
	ld a, $02 ; $7a52
	ld [hl], a ; $7a54
	ret ; $7a55
; UpdateActorTileAnimState_10 without the push af / pop af / or a / jr z zero-argument guard. Nothing calls it.
Unused_10_UpdateActorTileAnimStateByIndex:
	ld h, a ; $7a56
	ld l, $00 ; $7a57
	wram_bank $04 ; $7a59
	srl h ; $7a5f
	rr l ; $7a61
	srl h ; $7a63
	rr l ; $7a65
	ld bc, wActors ; $7a67
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
	add $40 ; $7a7e
	ld a, [hl] ; $7a80
	adc $00 ; $7a81
	ld e, a ; $7a83
	dec e ; $7a84
	dec e ; $7a85
	dec e ; $7a86
	push de ; $7a87
	call ReadSceneTilemapTile_10 ; $7a88
	pop de ; $7a8b
	and $87 ; $7a8c
	cp $06 ; $7a8e
	jr nz, .nextActor ; $7a90
	wram_bank $04 ; $7a92
	ld hl, $0020 ; $7a98
	add hl, bc ; $7a9b
	ld a, [hl] ; $7a9c
	xor $01 ; $7a9d
	ld [hl], a ; $7a9f
	ret ; $7aa0
.nextActor:
	inc d ; $7aa1
	call ReadSceneTilemapTile_10 ; $7aa2
	and $07 ; $7aa5
	cp $06 ; $7aa7
	jr nz, .done ; $7aa9
	wram_bank $04 ; $7aab
	ld hl, $0020 ; $7ab1
	add hl, bc ; $7ab4
	ld a, [hl] ; $7ab5
	xor $01 ; $7ab6
	ld [hl], a ; $7ab8
	ret ; $7ab9
.done:
	wram_bank $04 ; $7aba
	ld hl, $0020 ; $7ac0
	add hl, bc ; $7ac3
	ld a, $02 ; $7ac4
	ld [hl], a ; $7ac6
	ret ; $7ac7
; Instruction-identical to ReadSceneTilemapTile_0f (one copy per bank); a change here belongs in every copy.
ReadSceneTilemapTile_10:
	wram_bank $02 ; $7ac8
	ld h, e ; $7ace
	ld l, $00 ; $7acf
	srl h ; $7ad1
	rr l ; $7ad3
	srl h ; $7ad5
	rr l ; $7ad7
	ld a, d ; $7ad9
	add l ; $7ada
	ld l, a ; $7adb
	jr nc, .read ; $7adc
	inc h ; $7ade
.read:
	ld d, h ; $7adf
	ld e, l ; $7ae0
	ld l, c ; $7ae1
	ld h, b ; $7ae2
	add hl, de ; $7ae3
	ld a, [hl] ; $7ae4
	ret ; $7ae5
MapExitWalkCurveRight_10:
	script_set_speed ACTOR_PLAYER, $0010 ; $7ae6
	script_set_speed ACTOR_PARTNER, $0010 ; $7aee
	script_move_angle ACTOR_PLAYER, FACE_UP, $0100 ; $7af6
	script_wait_move ACTOR_PLAYER ; $7b00
	script_move_angle ACTOR_PLAYER, $e0, $0080 ; $7b05
	script_wait_move ACTOR_PLAYER ; $7b0f
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $00c0 ; $7b14
	ret ; $7b1e
MapExitWalkCurveLeft_10:
	ld a, [wStoryModeEntryPoint] ; $7b1f
	cp STORYENTRY_NONE ; $7b22
	jr z, .done ; $7b24
	script_set_speed ACTOR_PARTNER, $0010 ; $7b26
	script_set_speed ACTOR_PLAYER, $0010 ; $7b2e
	script_move_angle ACTOR_PLAYER, FACE_UP, $00c0 ; $7b36
	script_wait_move ACTOR_PLAYER ; $7b40
	script_move_angle ACTOR_PLAYER, $a0, $0080 ; $7b45
	script_wait_move ACTOR_PLAYER ; $7b4f
	script_move_angle ACTOR_PLAYER, FACE_LEFT, $0080 ; $7b54
.done:
	ret ; $7b5e
MapArrivalWalkPair_10:
	ld a, [wStoryModeEntryPoint] ; $7b5f
	cp STORYENTRY_NONE ; $7b62
	jr z, .done ; $7b64
	script_set_speed ACTOR_PLAYER, $0010 ; $7b66
	script_set_speed ACTOR_PARTNER, $0010 ; $7b6e
	script_move_angle ACTOR_PLAYER, FACE_DOWN, $0280 ; $7b76
	script_move_angle ACTOR_PARTNER, FACE_DOWN, $0200 ; $7b80
.done:
	ret ; $7b8a
ActorScript_10_1:
	; $7b8b, 43 bytes (actor_script)
	as_set_field $06, $0018
	as_flag $01, $05, $02
.L8:
	as_set_target $1b00, $1720
	as_wait_move2
	as_wait $05
	as_set_target $1d00, $1720
	as_wait_move2
	as_wait $0a
	as_set_target $1d00, $1600
	as_wait_move2
	as_wait $0a
	as_set_target $1d00, $1720
	as_wait_move2
	as_wait $05
	as_jump .L8
GetDoublesProgressStage_10:
	ld a, $00 ; $7bb6
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7bb8
	jr z, .done ; $7bbb
	inc a ; $7bbd
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7bbe
	jr z, .done ; $7bc1
	inc a ; $7bc3
	test_flag FLAG_WON_VARSITY_DOUBLES_RANK_2 ; $7bc4
	jr z, .done ; $7bc7
	inc a ; $7bc9
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7bca
	jr z, .done ; $7bcd
	inc a ; $7bcf
.done:
	ret ; $7bd0
ActorScript_10_2:
	; $7bd1, 10 bytes (actor_script)
	as_halt
	as_anim $00
	as_halt
.L4:
	as_step
	as_wait $01
	as_jump .L4
ActorScript_10_3:
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
	xor a ; $7bfa
	ld [wStoryScriptRan], a ; $7bfb
	ret ; $7bfe
MapScriptPlaySoundA2_10:
	sound $a2 ; $7bff
	ret ; $7c01
MapScriptHideLocationName_10:
	xor a ; $7c02
	ld [wStoryModeShowLocationName], a ; $7c03
	ret ; $7c06
ActorScript_10_4:
	; $7c07, 438 bytes (actor_script)
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
	as_jump ActorScript_10_4
	as_anim $00
	as_wait $3c
.L67:
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
	as_jump .L67
	as_anim $00
	as_wait $1e
.Lce:
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
	as_jump .Lce
	as_anim $00
	as_wait $1e
	as_wait $3c
.L137:
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
	as_jump .L137
.L19a:
	as_wait $f0
	as_anim $03
	as_wait $50
	as_anim $03
	as_wait $3c
	as_jump .L19a
.L1a7:
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $04
	as_wait $8c
	as_anim $03
	as_jump .L1a7
SetStoryDialogueStage_10:
	test_flag FLAG_DOUBLES ; $7dbd
	jr nz, .doublesStage ; $7dc0
	ld a, STORYRANK_SINGLES_ACADEMY ; $7dc2
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7dc4
	jr z, .store ; $7dc7
	ld a, STORYRANK_SINGLES_JUNIOR_CHAMP ; $7dc9
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7dcb
	jr z, .store ; $7dce
	ld a, STORYRANK_SINGLES_SENIOR_CHAMP ; $7dd0
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7dd2
	jr z, .store ; $7dd5
	ld a, STORYRANK_SINGLES_ISLAND_OPEN ; $7dd7
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7dd9
	jr z, .store ; $7ddc
	ld a, STORYRANK_SINGLES_COMPLETE ; $7dde
.store:
	ld [wMapSceneStage], a ; $7de0
	ret ; $7de3
.doublesStage:
	ld a, STORYRANK_DOUBLES_ACADEMY ; $7de4
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7de6
	jr z, .store ; $7de9
	ld a, STORYRANK_DOUBLES_JUNIOR_CHAMP ; $7deb
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $7ded
	jr z, .store ; $7df0
	ld a, STORYRANK_DOUBLES_SENIOR_CHAMP ; $7df2
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7df4
	jr z, .store ; $7df7
	ld a, STORYRANK_DOUBLES_ISLAND_OPEN ; $7df9
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7dfb
	jr z, .store ; $7dfe
	ld a, STORYRANK_DOUBLES_COMPLETE ; $7e00
	jr .store ; $7e02
; This bank's copy of ComputeStoryRankTier_13, identical instruction for instruction: the shared story include carried it into every story bank, and only bank $13's copy is called (by SetStoryRankTier). Nothing calls this one.
Unused_10_ComputeStoryRankTier:
	ld a, $00 ; $7e04
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $7e06
	jr z, .storeIsland ; $7e09
	inc a ; $7e0b
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $7e0c
	jr z, .storeIsland ; $7e0f
	inc a ; $7e11
	test_flag FLAG_DOUBLES ; $7e12
	jr nz, .doublesIsland ; $7e15
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7e17
	jr z, .storeIsland ; $7e1a
	inc a ; $7e1c
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7e1d
	jr z, .storeIsland ; $7e20
	inc a ; $7e22
.storeIsland:
	ld [wMapSceneStage], a ; $7e23
	ret ; $7e26
.doublesIsland:
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $7e27
	jr z, .storeIsland ; $7e2a
	inc a ; $7e2c
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $7e2d
	jr z, .storeIsland ; $7e30
	inc a ; $7e32
	jr .storeIsland ; $7e33
	; $7e35, 459 bytes fill to bank end (linker-padded)
