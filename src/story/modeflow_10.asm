RunMinigameModeFlow:
	xor a ; $5216
	ld [wMatchSuspendedFlag], a ; $5217
	farcall RunMinigameSelect ; $521a
	cp $ff ; $521d
	jr nz, .levelMenu ; $521f
	ld a, MENUSLIDE_BACK ; $5221
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
	ld a, MENUSLIDE_BACK ; $5239
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
	jr nz, .runDrill ; $5254
	call DisableLCDSafely ; $5256
	farcall LoadMenuFontGfx ; $5259
	farcall ResetScreenAndTextWindows ; $525c
	call EnableLCD ; $525f
	script_fade_in 16 ; $5262
	ld a, MENUSLIDE_BACK ; $5267
	ld [wMenuSlideDirection], a ; $5269
	jr .levelMenu ; $526c
.runDrill:
	ld a, [wSelectedMinigame] ; $526e
	call GetMinigameDrillId ; $5271
	farcall RunTrainingDrillByID ; $5274
	ld a, MENUSLIDE_FORWARD ; $5277
	ld [wMenuSlideDirection], a ; $5279
	call DisableLCDSafely ; $527c
	farcall LoadMenuFontGfx ; $527f
	farcall ResetScreenAndTextWindows ; $5282
	call EnableLCD ; $5285
	script_fade_in 16 ; $5288
	call WaitFadeEnd ; $528d
	ld a, [wMatchSelectNewLevelRequest] ; $5290
	or a ; $5293
	jr nz, .levelMenu ; $5294
	ld a, [wPointWinLoseFlag] ; $5296
	cp WINLOSE_WIN ; $5299
	jr z, .levelMenu ; $529b
	jp RunTitleAndMainMenuLoop.menuLoop ; $529d
RunLinkedPlayFlow:
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
	ld a, MENUSLIDE_FORWARD ; $52b8
	ld [wMenuSlideDirection], a ; $52ba
	call DisableLCDSafely ; $52bd
	farcall LoadMenuFontGfx ; $52c0
	farcall ResetScreenAndTextWindows ; $52c3
	call EnableLCD ; $52c6
	script_fade_in 16 ; $52c9
	jp RunTitleAndMainMenuLoop.menuLoop ; $52ce
RunStatusMenuFlow:
	farcall RunStatusSourceSelect ; $52d1
	cp $ff ; $52d4
	jp z, RunTitleAndMainMenuLoop.menuLoop ; $52d6
	cp NUM_STORY_SLOTS ; $52d9
	jp nc, .pickNonFileMenu ; $52db
	ld [wCurrentStorySlot], a ; $52de
	farcall CheckStorySlot ; $52e1
.gbDataMenu:
	farcall RunGbDataItemSelect ; $52e4
	cp $ff ; $52e7
	jp z, RunStatusMenuFlow ; $52e9
	or a ; $52ec
	jr nz, .progressMenu ; $52ed
	script_fade_out 16 ; $52ef
	call WaitFadeEnd ; $52f4
	ld a, $00 ; $52f7
	farcall ShowCharDataScreen ; $52f9
	call DisableLCDSafely ; $52fc
	farcall LoadMenuFontGfx ; $52ff
	farcall ResetScreenAndTextWindows ; $5302
	call EnableLCD ; $5305
	script_fade_in 16 ; $5308
	ld a, MENUSLIDE_BACK ; $530d
	ld [wMenuSlideDirection], a ; $530f
	jp .gbDataMenu ; $5312
.progressMenu:
	cp $01 ; $5315
	jr nz, .trophiesMenu ; $5317
	script_fade_out 16 ; $5319
	call WaitFadeEnd ; $531e
	farcall ShowGameProgressScreen ; $5321
	script_fade_out 16 ; $5324
	call WaitFadeEnd ; $5329
	call DisableLCDSafely ; $532c
	farcall LoadMenuFontGfx ; $532f
	farcall ResetScreenAndTextWindows ; $5332
	call EnableLCD ; $5335
	script_fade_in 16 ; $5338
	ld a, MENUSLIDE_BACK ; $533d
	ld [wMenuSlideDirection], a ; $533f
	jp .gbDataMenu ; $5342
.trophiesMenu:
	cp $02 ; $5345
	jr nz, .equipmentMenu ; $5347
	script_fade_out 16 ; $5349
	call WaitFadeEnd ; $534e
	farcall RunTrophiesScreen ; $5351
	call DisableLCDSafely ; $5354
	farcall LoadMenuFontGfx ; $5357
	farcall ResetScreenAndTextWindows ; $535a
	call EnableLCD ; $535d
	script_fade_in 16 ; $5360
	ld a, MENUSLIDE_BACK ; $5365
	ld [wMenuSlideDirection], a ; $5367
	jp .gbDataMenu ; $536a
.equipmentMenu:
	farcall RunRacketShoesChoiceMenu ; $536d
	cp $00 ; $5370
	jr z, .racketSelect ; $5372
	cp $01 ; $5374
	jr z, .shoesSelect ; $5376
	ld a, MENUSLIDE_BACK ; $5378
	ld [wMenuSlideDirection], a ; $537a
	jp .gbDataMenu ; $537d
.racketSelect:
	script_fade_out 16 ; $5380
	call WaitFadeEnd ; $5385
	farcall RunRacketSelectScreen ; $5388
	farcall ShowEquipmentStatusScreen ; $538b
	farcall SaveStorySlot ; $538e
	call DisableLCDSafely ; $5391
	farcall LoadMenuFontGfx ; $5394
	farcall ResetScreenAndTextWindows ; $5397
	call EnableLCD ; $539a
	script_fade_in 16 ; $539d
	ld a, MENUSLIDE_BACK ; $53a2
	ld [wMenuSlideDirection], a ; $53a4
	jp .equipmentMenu ; $53a7
.shoesSelect:
	script_fade_out 16 ; $53aa
	call WaitFadeEnd ; $53af
	farcall RunShoesSelectScreen ; $53b2
	farcall ShowEquipmentStatusScreen ; $53b5
	farcall SaveStorySlot ; $53b8
	call DisableLCDSafely ; $53bb
	farcall LoadMenuFontGfx ; $53be
	farcall ResetScreenAndTextWindows ; $53c1
	call EnableLCD ; $53c4
	script_fade_in 16 ; $53c7
	ld a, MENUSLIDE_BACK ; $53cc
	ld [wMenuSlideDirection], a ; $53ce
	jp .equipmentMenu ; $53d1
.pickNonFileMenu:
	cp $03 ; $53d4
	jr nz, .n64RecordMenu ; $53d6
.marioCharDataMenu:
	farcall RunMarioCharDataTypeSelect ; $53d8
	cp $ff ; $53db
	jr nz, .marioCharDataOption ; $53dd
	jp RunStatusMenuFlow ; $53df
.marioCharDataOption:
	or a ; $53e2
	jr nz, .minigameData ; $53e3
	script_fade_out 16 ; $53e5
	call WaitFadeEnd ; $53ea
	farcall RunMarioCastExhibResults ; $53ed
	script_fade_out 16 ; $53f0
	call WaitFadeEnd ; $53f5
	call DisableLCDSafely ; $53f8
	farcall LoadMenuFontGfx ; $53fb
	farcall ResetScreenAndTextWindows ; $53fe
	call EnableLCD ; $5401
	script_fade_in 16 ; $5404
	ld a, MENUSLIDE_BACK ; $5409
	ld [wMenuSlideDirection], a ; $540b
	jp .marioCharDataMenu ; $540e
.minigameData:
	script_fade_out 16 ; $5411
	call WaitFadeEnd ; $5416
	farcall ShowMinigameDataScreen ; $5419
	script_fade_out 16 ; $541c
	call WaitFadeEnd ; $5421
	call DisableLCDSafely ; $5424
	farcall LoadMenuFontGfx ; $5427
	farcall ResetScreenAndTextWindows ; $542a
	call EnableLCD ; $542d
	script_fade_in 16 ; $5430
	ld a, MENUSLIDE_BACK ; $5435
	ld [wMenuSlideDirection], a ; $5437
	jp .marioCharDataMenu ; $543a
.n64RecordMenu:
	farcall RunN64RecordTypeSelect ; $543d
	cp $ff ; $5440
	jp z, RunStatusMenuFlow ; $5442
	or a ; $5445
	jr nz, .n64RecordOption1 ; $5446
	script_fade_out 16 ; $5448
	call WaitFadeEnd ; $544d
	farcall RunN64TnmtData ; $5450
	call DisableLCDSafely ; $5453
	farcall LoadMenuFontGfx ; $5456
	farcall ResetScreenAndTextWindows ; $5459
	call EnableLCD ; $545c
	script_fade_in 16 ; $545f
	ld a, MENUSLIDE_BACK ; $5464
	ld [wMenuSlideDirection], a ; $5466
	jp .pickNonFileMenu ; $5469
.n64RecordOption1:
	cp $01 ; $546c
	jr nz, .ringShotData ; $546e
	script_fade_out 16 ; $5470
	call WaitFadeEnd ; $5475
	farcall RunN64ExhibDataAlias1 ; $5478
	call DisableLCDSafely ; $547b
	farcall LoadMenuFontGfx ; $547e
	farcall ResetScreenAndTextWindows ; $5481
	call EnableLCD ; $5484
	script_fade_in 16 ; $5487
	ld a, MENUSLIDE_BACK ; $548c
	ld [wMenuSlideDirection], a ; $548e
	jp .pickNonFileMenu ; $5491
.ringShotData:
	farcall RunN64RingShotData ; $5494
	call DisableLCDSafely ; $5497
	farcall LoadMenuFontGfx ; $549a
	farcall ResetScreenAndTextWindows ; $549d
	call EnableLCD ; $54a0
	script_fade_in 16 ; $54a3
	ld a, MENUSLIDE_BACK ; $54a8
	ld [wMenuSlideDirection], a ; $54aa
	jp .pickNonFileMenu ; $54ad
RunDictionaryFlow:
	script_fade_out 16 ; $54b0
	call WaitFadeEnd ; $54b5
	ld a, TENNISDICT_INDEX ; $54b8
	farcall TennisDictionaryScreen ; $54ba
	call DisableLCDSafely ; $54bd
	farcall LoadMenuFontGfx ; $54c0
	farcall ResetScreenAndTextWindows ; $54c3
	call EnableLCD ; $54c6
	script_fade_in 16 ; $54c9
	ld a, MENUSLIDE_BACK ; $54ce
	ld [wMenuSlideDirection], a ; $54d0
	jp RunTitleAndMainMenuLoop.menuLoop ; $54d3
RunEraseSavedDataFlow:
	farcall RunEraseSavedDataSelect ; $54d6
	cp $ff ; $54d9
	jp z, RunTitleAndMainMenuLoop.menuLoop ; $54db
	ld b, a ; $54de
	add a ; $54df
	ld hl, EraseSavedDataFlowHandlers_10 ; $54e0
	add_hl_a ; $54e3
	ld a, [hl+] ; $54e8
	ld h, [hl] ; $54e9
	ld l, a ; $54ea
	jp hl ; $54eb
EraseSavedDataFlowHandlers_10:
	; $54ec, 10 bytes (records:2)
	dw EraseStoryFileFlow ; record 0
	dw EraseStoryFileFlow ; record 1
	dw EraseStoryFileFlow ; record 2
	dw EraseN64RecordsFlow ; record 3
	dw EraseAllDataFlow ; record 4
EraseStoryFileFlow:
	ld a, b ; $54f6
	ld [wCurrentStorySlot], a ; $54f7
	farcall CheckStorySlot ; $54fa
	push bc ; $54fd
	script_fade_out 16 ; $54fe
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
	script_fade_in 16 ; $552c
	ld a, MENUSLIDE_BACK ; $5531
	ld [wMenuSlideDirection], a ; $5533
	jp RunEraseSavedDataFlow ; $5536
EraseN64RecordsFlow:
	script_fade_out 16 ; $5539
	call WaitFadeEnd ; $553e
	ld b, $01 ; $5541
	farcall RunEraseDataConfirmMenu ; $5543
	or a ; $5546
	jr z, .redrawAfterBlockErase ; $5547
	farcall ClearN64RecordsSaveBlock ; $5549
.redrawAfterBlockErase:
	call DisableLCDSafely ; $554c
	farcall LoadMenuFontGfx ; $554f
	farcall ResetScreenAndTextWindows ; $5552
	call EnableLCD ; $5555
	script_fade_in 16 ; $5558
	ld a, MENUSLIDE_BACK ; $555d
	ld [wMenuSlideDirection], a ; $555f
	jp RunEraseSavedDataFlow ; $5562
EraseAllDataFlow:
	script_fade_out 16 ; $5565
	call WaitFadeEnd ; $556a
	ld b, $00 ; $556d
	farcall RunEraseDataConfirmMenu ; $556f
	or a ; $5572
	jr nz, .reinitSram ; $5573
	call DisableLCDSafely ; $5575
	farcall LoadMenuFontGfx ; $5578
	farcall ResetScreenAndTextWindows ; $557b
	call EnableLCD ; $557e
	script_fade_in 16 ; $5581
	ld a, MENUSLIDE_BACK ; $5586
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
	script_fade_in 16 ; $55a1
	ld a, MENUSLIDE_BACK ; $55a6
	ld [wMenuSlideDirection], a ; $55a8
	xor a ; $55ab
	ld [wMainMenuCursor], a ; $55ac
	ld [wSelectedMinigame], a ; $55af
	jp RunEraseSavedDataFlow ; $55b2
	ret ; $55b5
ResumeSuspendedStoryMatch:
	farcall RunMatch ; $55b6
	ld a, [wSaveAndQuitRequest] ; $55b9
	or a ; $55bc
	jr z, .matchFinished ; $55bd
	farcall SaveStorySlotWithTimer ; $55bf
	ld a, STORYLOC_MAIN_MENU ; $55c2
	ld [wStoryModeCurrentLocation], a ; $55c4
	ld a, ENTRY_MAIN_MENU_FROM_STORY ; $55c7
	ld [wStoryModeEntryPoint], a ; $55c9
	ld a, EXITTRIGGER_DIRECT ; $55cc
	ld [wUnusedExitTriggerIdMirror], a ; $55ce
	ld [wStoryModeExitTriggerRequest], a ; $55d1
	ret ; $55d4
.matchFinished:
	ld a, [wGameMode] ; $55d5
	cp GAMEMODE_EXHIBITION ; $55d8
	jr nz, .chooseReturn ; $55da
	clear_flag FLAG_ISLAND_SKY_SCENE_ACTIVE ; $55dc
	xor a ; $55df
	ld [wMatchSuspendedFlag], a ; $55e0
	ld b, STORYLOC_MAIN_MENU ; $55e3
	ld c, ENTRY_MAIN_MENU_FROM_STORY ; $55e5
	farcall SaveStoryReturnPoint ; $55e7
	farcall SaveStorySlotWithTimer ; $55ea
	test_flag FLAG_DEBUG_SKIP_LOCATION_EXIT ; $55ed
	jr nz, .testExit ; $55f0
	ld a, EXIT_MAIN_MENU_CONTINUE ; $55f2
	ld [wUnusedExitTriggerIdMirror], a ; $55f4
	ld [wStoryModeExitTriggerRequest], a ; $55f7
	ret ; $55fa
.testExit:
	ld a, EXIT_MAIN_MENU_TEST_2 ; $55fb
	ld [wUnusedExitTriggerIdMirror], a ; $55fd
	ld [wStoryModeExitTriggerRequest], a ; $5600
	ret ; $5603
.chooseReturn:
	ld a, [wCurrentMatchIndex] ; $5604
	cp STORYMATCH_ISLAND_OPEN_FINAL + 1 ; $5607
	jr c, .tournament ; $5609
	ld a, STORYLOC_SPECIAL_COURT ; $560b
	ld [wStoryModeCurrentLocation], a ; $560d
	ld a, ENTRY_SPECIAL_COURT_MATCH_RESULT ; $5610
	ld [wStoryModeEntryPoint], a ; $5612
	ld a, EXITTRIGGER_DIRECT ; $5615
	ld [wUnusedExitTriggerIdMirror], a ; $5617
	ld [wStoryModeExitTriggerRequest], a ; $561a
	ret ; $561d
.tournament:
	cp STORYMATCH_VARSITY_1 + 1 ; $561e
	jr c, .varsity ; $5620
	test_flag FLAG_DOUBLES ; $5622
	jr nz, .tournamentDoubles ; $5625
	ld a, STORYLOC_TOURNAMENT ; $5627
	ld [wStoryModeCurrentLocation], a ; $5629
	ld a, ENTRY_TOURNAMENT_AFTER_ROUND_SINGLES ; $562c
	ld [wStoryModeEntryPoint], a ; $562e
	ld a, EXITTRIGGER_DIRECT ; $5631
	ld [wUnusedExitTriggerIdMirror], a ; $5633
	ld [wStoryModeExitTriggerRequest], a ; $5636
	ret ; $5639
.tournamentDoubles:
	ld a, STORYLOC_TOURNAMENT ; $563a
	ld [wStoryModeCurrentLocation], a ; $563c
	ld a, ENTRY_TOURNAMENT_AFTER_ROUND_DOUBLES ; $563f
	ld [wStoryModeEntryPoint], a ; $5641
	ld a, EXITTRIGGER_DIRECT ; $5644
	ld [wUnusedExitTriggerIdMirror], a ; $5646
	ld [wStoryModeExitTriggerRequest], a ; $5649
	ret ; $564c
.varsity:
	cp STORYMATCH_VARSITY_PRACTICE ; $564d
	jr c, .senior ; $564f
	ld a, STORYLOC_COURTYARD ; $5651
	ld [wStoryModeCurrentLocation], a ; $5653
	ld a, ENTRY_COURTYARD_VARSITY_MATCH_RETURN ; $5656
	ld [wStoryModeEntryPoint], a ; $5658
	ld a, EXITTRIGGER_DIRECT ; $565b
	ld [wUnusedExitTriggerIdMirror], a ; $565d
	ld [wStoryModeExitTriggerRequest], a ; $5660
	ret ; $5663
.senior:
	cp STORYMATCH_SENIOR_PRACTICE ; $5664
	jr c, .junior ; $5666
	jr z, .seniorPractice ; $5668
	ld a, STORYLOC_SENIOR_CLASS_COURT ; $566a
	ld [wStoryModeCurrentLocation], a ; $566c
	ld a, ENTRY_SENIOR_CLASS_COURT_MATCH_RETURN ; $566f
	ld [wStoryModeEntryPoint], a ; $5671
	ld a, EXITTRIGGER_DIRECT ; $5674
	ld [wUnusedExitTriggerIdMirror], a ; $5676
	ld [wStoryModeExitTriggerRequest], a ; $5679
	ret ; $567c
.seniorPractice:
	ld a, STORYLOC_SENIOR_CLASS_COURT ; $567d
	ld [wStoryModeCurrentLocation], a ; $567f
	ld a, ENTRY_SENIOR_CLASS_COURT_PRACTICE_MATCH_RETURN ; $5682
	ld [wStoryModeEntryPoint], a ; $5684
	ld a, EXITTRIGGER_DIRECT ; $5687
	ld [wUnusedExitTriggerIdMirror], a ; $5689
	ld [wStoryModeExitTriggerRequest], a ; $568c
	ret ; $568f
.junior:
	test_flag FLAG_DOUBLES ; $5690
	jr nz, .otherRoom ; $5693
	cp STORYMATCH_JUNIOR_PRACTICE ; $5695
	jr z, .practiceRoomAlt ; $5697
	ld a, STORYLOC_JUNIOR_CLASS_COURT_SINGLES ; $5699
	ld [wStoryModeCurrentLocation], a ; $569b
	ld a, ENTRY_JUNIOR_CLASS_COURT_SINGLES_MATCH_RETURN ; $569e
	ld [wStoryModeEntryPoint], a ; $56a0
	ld a, EXITTRIGGER_DIRECT ; $56a3
	ld [wUnusedExitTriggerIdMirror], a ; $56a5
	ld [wStoryModeExitTriggerRequest], a ; $56a8
	ret ; $56ab
.practiceRoomAlt:
	ld a, STORYLOC_JUNIOR_CLASS_COURT_SINGLES ; $56ac
	ld [wStoryModeCurrentLocation], a ; $56ae
	ld a, ENTRY_JUNIOR_CLASS_COURT_SINGLES_PRACTICE_MATCH_RETURN ; $56b1
	ld [wStoryModeEntryPoint], a ; $56b3
	ld a, EXITTRIGGER_DIRECT ; $56b6
	ld [wUnusedExitTriggerIdMirror], a ; $56b8
	ld [wStoryModeExitTriggerRequest], a ; $56bb
	ret ; $56be
.otherRoom:
	cp STORYMATCH_JUNIOR_PRACTICE ; $56bf
	jr z, .otherRoomAlt ; $56c1
	ld a, STORYLOC_JUNIOR_CLASS_COURT_DOUBLES ; $56c3
	ld [wStoryModeCurrentLocation], a ; $56c5
	ld a, ENTRY_JUNIOR_CLASS_COURT_DOUBLES_MATCH_RETURN ; $56c8
	ld [wStoryModeEntryPoint], a ; $56ca
	ld a, EXITTRIGGER_DIRECT ; $56cd
	ld [wUnusedExitTriggerIdMirror], a ; $56cf
	ld [wStoryModeExitTriggerRequest], a ; $56d2
	ret ; $56d5
.otherRoomAlt:
	ld a, STORYLOC_JUNIOR_CLASS_COURT_DOUBLES ; $56d6
	ld [wStoryModeCurrentLocation], a ; $56d8
	ld a, ENTRY_JUNIOR_CLASS_COURT_DOUBLES_PRACTICE_MATCH_RETURN ; $56db
	ld [wStoryModeEntryPoint], a ; $56dd
	ld a, EXITTRIGGER_DIRECT ; $56e0
	ld [wUnusedExitTriggerIdMirror], a ; $56e2
	ld [wStoryModeExitTriggerRequest], a ; $56e5
	ret ; $56e8
