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
	map_actor $0000, ActorScript_10_2, 7.0, 17.0, FACE_DOWN, OBJ_EMILY, ANIM_WALK, $00, MATCH_SELECT_EMILY
	map_actor $0000, ActorScript_10_2, 7.0, 7.0, FACE_LEFT, OBJ_JUMPING_JACKS_A, ANIM_WALK, $03, MATCH_SELECT_JUMPING_JACKS_A
	map_actor $0000, ActorScript_10_2, 13.0, 7.0, FACE_LEFT, OBJ_JUMPING_JACKS_B, ANIM_WALK, $03, MATCH_SELECT_JUMPING_JACKS_B
	map_actor $0000, ActorScript_10_2, 7.0, 11.0, FACE_DOWN, OBJ_RACKET_STUDENT, ANIM_WALK, $03, MATCH_SELECT_RACKET_STUDENT
	map_actor $0000, ActorScript_10_2, 13.0, 11.0, FACE_DOWN, OBJ_CAT, ANIM_WALK, $03, MATCH_SELECT_CAT
	map_actor $0000, ActorScript_10_2, 13.0, 17.0, FACE_DOWN, OBJ_WALK_76_06, ANIM_WALK, $05, MATCH_SELECT_WALK_76_06
	map_actor $0000, ActorScript_10_2, 5.0, 14.0, FACE_DOWN, OBJ_SITUPS_A, ANIM_WALK, $03, MATCH_SELECT_SITUPS_A_1
	map_actor $0000, ActorScript_10_2, 17.0, 14.0, FACE_DOWN, OBJ_SITUPS_A, ANIM_WALK, $03, MATCH_SELECT_SITUPS_A_2
	map_actor $0000, ActorScript_10_2, 17.0, 12.0, FACE_DOWN, OBJ_SITUPS_A, ANIM_WALK, $03, MATCH_SELECT_SITUPS_A_3
	map_actor_end
MatchSelectEntryPoints_10:
	; $40a6, 9 bytes (map_entries)
	map_entry $01, FACE_UP, 10.0, 9.0, $0000
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
	ld bc, wStoryModeSpawnPosition_SIZE ; $40da
	call CopyMemoryBC ; $40dd
	ld a, STORYENTRY_NONE ; $40e0
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
	map_script ACTOR_MATCH_SELECT_EMILY, FACEMASK_ANY, $0000, MatchSelectRunCharacterSelect, $00, $00
	map_script ACTOR_MATCH_SELECT_JUMPING_JACKS_A, FACEMASK_ANY, $0000, RunSinglesMatchListMenu, $00, $00
	map_script ACTOR_MATCH_SELECT_JUMPING_JACKS_B, FACEMASK_ANY, $0000, RunDoublesMatchListMenu, $00, $00
	map_script ACTOR_MATCH_SELECT_RACKET_STUDENT, FACEMASK_ANY, $0000, RunDrillMatchListMenu, $00, $00
	map_script ACTOR_MATCH_SELECT_CAT, FACEMASK_ANY, $0000, MatchSelectCharDataOptionDisabled, $00, $00
	map_script ACTOR_MATCH_SELECT_WALK_76_06, FACEMASK_ANY, $0000, RunLessonSelectMenu, $00, $00
	map_script ACTOR_MATCH_SELECT_SITUPS_A_1, FACEMASK_ANY, $0000, RunMinigameSelectMenu, $00, $00
	map_script ACTOR_MATCH_SELECT_SITUPS_A_2, FACEMASK_ANY, $0000, MatchSelectPlayEpilogueScene, $00, $00
	map_script ACTOR_MATCH_SELECT_SITUPS_A_3, FACEMASK_ANY, $0000, MatchSelectRunEndingCredits, $00, $00
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
	ld bc, wStoryModeSpawnPosition_SIZE ; $41ae
	call CopyMemoryBC ; $41b1
	ld a, STORYENTRY_NONE ; $41b4
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
	ld bc, wStoryModeSpawnPosition_SIZE ; $41f3
	call CopyMemoryBC ; $41f6
	ld a, STORYENTRY_NONE ; $41f9
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
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_DREAM_HARD ; $4266
	ret ; $4273
LoadMatchSinglesDreamIntense:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_DREAM_INTENSE ; $4274
	ret ; $4281
LoadMatchSinglesDreamMax:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_DREAM_MAX ; $4282
	ret ; $428f
LoadMatchDoublesDreamHard:
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_DREAM_HARD ; $4290
	ret ; $429d
LoadMatchDoublesDreamIntense:
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_DREAM_INTENSE ; $429e
	ret ; $42ab
LoadMatchDoublesDreamMax:
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_DREAM_MAX ; $42ac
	ret ; $42b9
LoadMatchSinglesOpenRound1:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_ISLAND_OPEN_ROUND_1 ; $42ba
	ret ; $42c7
LoadMatchSinglesOpenRound2:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_ISLAND_OPEN_ROUND_2 ; $42c8
	ret ; $42d5
LoadMatchSinglesOpenSemifinals:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_ISLAND_OPEN_SEMIFINAL ; $42d6
	ret ; $42e3
LoadMatchSinglesOpenFinals:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_ISLAND_OPEN_FINAL ; $42e4
	ret ; $42f1
LoadMatchDoublesOpenRound1:
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_ISLAND_OPEN_ROUND_2 ; $42f2
	ret ; $42ff
LoadMatchDoublesOpenSemifinals:
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_ISLAND_OPEN_SEMIFINAL ; $4300
	ret ; $430d
LoadMatchDoublesOpenFinals:
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_ISLAND_OPEN_FINAL ; $430e
	ret ; $431b
LoadMatchSinglesJuniorPractice:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_JUNIOR_PRACTICE ; $431c
	ret ; $4329
LoadMatchSinglesJunior1:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_JUNIOR_1 ; $432a
	ret ; $4337
LoadMatchSinglesJunior2:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_JUNIOR_2 ; $4338
	ret ; $4345
LoadMatchSinglesJunior3:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_JUNIOR_3 ; $4346
	ret ; $4353
LoadMatchSinglesJunior4:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_JUNIOR_4 ; $4354
	ret ; $4361
LoadMatchSinglesSenior1:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_SENIOR_1 ; $4362
	ret ; $436f
LoadMatchSinglesSenior2:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_SENIOR_2 ; $4370
	ret ; $437d
LoadMatchSinglesSenior3:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_SENIOR_3 ; $437e
	ret ; $438b
LoadMatchSinglesSenior4:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_SENIOR_4 ; $438c
	ret ; $4399
LoadMatchSinglesSeniorPractice:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_SENIOR_PRACTICE ; $439a
	ret ; $43a7
LoadMatchSinglesJunior3Alias:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_JUNIOR_3 ; $43a8
	ret ; $43b5
LoadMatchSinglesVarsityPractice:
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_VARSITY_PRACTICE ; $43b6
	ret ; $43c3
LoadMatchDoublesJuniorPractice:
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_JUNIOR_PRACTICE ; $43c4
	ret ; $43d1
LoadMatchDoublesJunior3:
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_JUNIOR_3 ; $43d2
	ret ; $43df
LoadMatchDoublesJunior2:
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_JUNIOR_2 ; $43e0
	ret ; $43ed
LoadMatchDoublesJunior1:
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_JUNIOR_1 ; $43ee
	ret ; $43fb
LoadMatchDoublesSeniorPractice:
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_SENIOR_PRACTICE ; $43fc
	ret ; $4409
LoadMatchDoublesSenior3:
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_SENIOR_3 ; $440a
	ret ; $4417
LoadMatchDoublesSenior2:
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_SENIOR_2 ; $4418
	ret ; $4425
LoadMatchDoublesSenior1:
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_SENIOR_1 ; $4426
	ret ; $4433
LoadMatchDoublesVarsity2:
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_VARSITY_2 ; $4434
	ret ; $4441
LoadMatchDoublesVarsityPractice:
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_VARSITY_PRACTICE ; $4442
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
	ld bc, wStoryModeSpawnPosition_SIZE ; $4464
	call CopyMemoryBC ; $4467
	ld a, STORYENTRY_NONE ; $446a
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
	ld bc, wStoryModeSpawnPosition_SIZE ; $449f
	call CopyMemoryBC ; $44a2
	ld a, STORYENTRY_NONE ; $44a5
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
	push_wram_bank WRAM_SOUND ; $44e1
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
	ld bc, wStoryModeSpawnPosition_SIZE ; $453f
	call CopyMemoryBC ; $4542
	ld a, STORYENTRY_NONE ; $4545
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
	ld bc, wStoryModeSpawnPosition_SIZE ; $4577
	call CopyMemoryBC ; $457a
	ld a, STORYENTRY_NONE ; $457d
	ld [wStoryModeEntryPoint], a ; $457f
	ld [wUnusedExitTriggerIdMirror], a ; $4582
	ld [wStoryModeExitTriggerRequest], a ; $4585
	ld c, $10 ; $4588
	call BeginFadeOut ; $458a
	call WaitFadeEnd ; $458d
	farcall ShowDrillBriefingScreen ; $4590
	ret ; $4593
