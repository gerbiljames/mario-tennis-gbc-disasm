MovePlayerToLessonCourtSpot:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $6253
	sub $0a ; $6256
	jr nc, .netCourtSpot ; $6258
	ld a, [wCurrentMinigameStoryMatch + 1] ; $625a
	sub $04 ; $625d
	jr c, .serveCourtSpot ; $625f
	jp .strokeCourtSpot ; $6261
	ret ; $6264
.netCourtSpot:
	script_move_target ACTOR_PLAYER, 19.0, 43.0 ; $6265
	script_wait_move ACTOR_PLAYER ; $6270
	script_get_actor_state ACTOR_PARTNER ; $6275
	ld c, l ; $627a
	ld b, h ; $627b
	ld de, wActors ; $627c
	farcall AttachActorStepMover ; $627f
	ret ; $6282
.serveCourtSpot:
	script_move_target ACTOR_PLAYER, 19.0, 19.0 ; $6283
	script_wait_move ACTOR_PLAYER ; $628e
	script_get_actor_state ACTOR_PARTNER ; $6293
	ld c, l ; $6298
	ld b, h ; $6299
	ld de, wActors ; $629a
	farcall AttachActorStepMover ; $629d
	ret ; $62a0
.strokeCourtSpot:
	script_move_target ACTOR_PLAYER, 45.0, 43.0 ; $62a1
	script_wait_move ACTOR_PLAYER ; $62ac
	script_get_actor_state ACTOR_PARTNER ; $62b1
	ld c, l ; $62b6
	ld b, h ; $62b7
	ld de, wActors ; $62b8
	farcall AttachActorStepMover ; $62bb
	ret ; $62be
.netResultText:
	ld hl, wChallengerFollowupTextId ; $62bf
	ld de, Text_6e_77 ; $62c2
	ld a, e ; $62c5
	ld [hl+], a ; $62c6
	ld [hl], d ; $62c7
	ld hl, wChallengerLoseTextId ; $62c8
	ld de, Text_6e_74 ; $62cb
	ld a, e ; $62ce
	ld [hl+], a ; $62cf
	ld [hl], d ; $62d0
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $62d1
	jr z, .netResultTextAlt ; $62d4
	ld hl, wChallengerWinTextId ; $62d6
	ld de, Text_6e_80 ; $62d9
	ld a, e ; $62dc
	ld [hl+], a ; $62dd
	ld [hl], d ; $62de
	ld hl, wChallengerDrawTextId ; $62df
	ld de, Text_6e_83 ; $62e2
	ld a, e ; $62e5
	ld [hl+], a ; $62e6
	ld [hl], d ; $62e7
	jr .netResult ; $62e8
.netResultTextAlt:
	ld hl, wChallengerWinTextId ; $62ea
	ld de, Text_6e_79 ; $62ed
	ld a, e ; $62f0
	ld [hl+], a ; $62f1
	ld [hl], d ; $62f2
	ld hl, wChallengerDrawTextId ; $62f3
	ld de, Text_6e_81 ; $62f6
	ld a, e ; $62f9
	ld [hl+], a ; $62fa
	ld [hl], d ; $62fb
.netResult:
	call NetChallengerResultScene ; $62fc
	ret ; $62ff
.netResultDoubles:
	ld hl, wChallengerFollowupTextId ; $6300
	ld de, Text_6e_77 ; $6303
	ld a, e ; $6306
	ld [hl+], a ; $6307
	ld [hl], d ; $6308
	ld hl, wChallengerLoseTextId ; $6309
	ld de, Text_6e_74 ; $630c
	ld a, e ; $630f
	ld [hl+], a ; $6310
	ld [hl], d ; $6311
	ld hl, wChallengerWinTextId ; $6312
	ld de, Text_6e_95 ; $6315
	ld a, e ; $6318
	ld [hl+], a ; $6319
	ld [hl], d ; $631a
	ld hl, wChallengerDrawTextId ; $631b
	ld de, Text_6e_96 ; $631e
	ld a, e ; $6321
	ld [hl+], a ; $6322
	ld [hl], d ; $6323
	call NetChallengerResultScene ; $6324
	ret ; $6327
.serveResultText:
	ld hl, wChallengerFollowupTextId ; $6328
	ld de, Text_6e_77 ; $632b
	ld a, e ; $632e
	ld [hl+], a ; $632f
	ld [hl], d ; $6330
	ld hl, wChallengerLoseTextId ; $6331
	ld de, Text_6e_74 ; $6334
	ld a, e ; $6337
	ld [hl+], a ; $6338
	ld [hl], d ; $6339
	ld hl, wChallengerWinTextId ; $633a
	ld de, Text_6e_108 ; $633d
	ld a, e ; $6340
	ld [hl+], a ; $6341
	ld [hl], d ; $6342
	ld hl, wChallengerDrawTextId ; $6343
	ld de, Text_6e_109 ; $6346
	ld a, e ; $6349
	ld [hl+], a ; $634a
	ld [hl], d ; $634b
	call NetChallengerResultScene ; $634c
	ret ; $634f
.serveResultTextAlt:
	ld hl, wChallengerFollowupTextId ; $6350
	ld de, Text_6e_123 ; $6353
	ld a, e ; $6356
	ld [hl+], a ; $6357
	ld [hl], d ; $6358
	ld hl, wChallengerLoseTextId ; $6359
	ld de, Text_6e_120 ; $635c
	ld a, e ; $635f
	ld [hl+], a ; $6360
	ld [hl], d ; $6361
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $6362
	jr z, .serveResult ; $6365
	ld hl, wChallengerWinTextId ; $6367
	ld de, Text_6e_126 ; $636a
	ld a, e ; $636d
	ld [hl+], a ; $636e
	ld [hl], d ; $636f
	ld hl, wChallengerDrawTextId ; $6370
	ld de, Text_6e_130 ; $6373
	ld a, e ; $6376
	ld [hl+], a ; $6377
	ld [hl], d ; $6378
	jr .serveResultDoubles ; $6379
.serveResult:
	ld hl, wChallengerWinTextId ; $637b
	ld de, Text_6e_125 ; $637e
	ld a, e ; $6381
	ld [hl+], a ; $6382
	ld [hl], d ; $6383
	ld hl, wChallengerDrawTextId ; $6384
	ld de, Text_6e_127 ; $6387
	ld a, e ; $638a
	ld [hl+], a ; $638b
	ld [hl], d ; $638c
.serveResultDoubles:
	call StrokeChallengerResultScene ; $638d
	ret ; $6390
.strokeResultText:
	ld hl, wChallengerFollowupTextId ; $6391
	ld de, Text_6e_123 ; $6394
	ld a, e ; $6397
	ld [hl+], a ; $6398
	ld [hl], d ; $6399
	ld hl, wChallengerLoseTextId ; $639a
	ld de, Text_6e_120 ; $639d
	ld a, e ; $63a0
	ld [hl+], a ; $63a1
	ld [hl], d ; $63a2
	ld hl, wChallengerWinTextId ; $63a3
	ld de, Text_6e_145 ; $63a6
	ld a, e ; $63a9
	ld [hl+], a ; $63aa
	ld [hl], d ; $63ab
	ld hl, wChallengerDrawTextId ; $63ac
	ld de, Text_6e_146 ; $63af
	ld a, e ; $63b2
	ld [hl+], a ; $63b3
	ld [hl], d ; $63b4
	call StrokeChallengerResultScene ; $63b5
	ret ; $63b8
.strokeResult:
	ld hl, wChallengerFollowupTextId ; $63b9
	ld de, Text_6e_123 ; $63bc
	ld a, e ; $63bf
	ld [hl+], a ; $63c0
	ld [hl], d ; $63c1
	ld hl, wChallengerLoseTextId ; $63c2
	ld de, Text_6e_120 ; $63c5
	ld a, e ; $63c8
	ld [hl+], a ; $63c9
	ld [hl], d ; $63ca
	ld hl, wChallengerWinTextId ; $63cb
	ld de, Text_6e_163 ; $63ce
	ld a, e ; $63d1
	ld [hl+], a ; $63d2
	ld [hl], d ; $63d3
	ld hl, wChallengerDrawTextId ; $63d4
	ld de, Text_6e_164 ; $63d7
	ld a, e ; $63da
	ld [hl+], a ; $63db
	ld [hl], d ; $63dc
	call StrokeChallengerResultScene ; $63dd
	ret ; $63e0
ServiceAceMatchChallengeScene:
	script_face_toward ACTOR_TRAINING_COURT_BOB_1, ACTOR_PARTNER ; $63e1
	script_set_text Text_6e_20 ; $63e9
	script_speak_restore ACTOR_TRAINING_COURT_BOB_1 ; $63ef
	farcall RunDialogueYesNoPrompt ; $63f4
	farcall ScriptCloseDialogueWindow ; $63f7
	script_wait_frames $05 ; $63fa
	and a ; $6401
	jp nz, .loop ; $6402
	farcall AdvanceDialogueTextCursor ; $6405
	script_speak_restore ACTOR_TRAINING_COURT_BOB_1 ; $6408
	farcall RunDialogueYesNoPrompt ; $640d
	farcall ScriptCloseDialogueWindow ; $6410
	script_wait_frames $05 ; $6413
	and a ; $641a
	jp nz, .loop ; $641b
	farcall AdvanceDialogueTextCursor ; $641e
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $6421
	script_set_anim ACTOR_TRAINING_COURT_BOB_1, ANIM_NOD ; $6426
	script_wait_idle ACTOR_TRAINING_COURT_BOB_1 ; $642d
	script_face ACTOR_TRAINING_COURT_BOB_1, FACE_RIGHT ; $6432
	script_wait_frames $28 ; $6439
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_BOB_1 ; $6440
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $6448
	script_set_anim ACTOR_TRAINING_COURT_BOB_1, ANIM_NOD ; $644d
	script_wait_idle ACTOR_TRAINING_COURT_BOB_1 ; $6454
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $6459
	script_wait_frames $28 ; $645e
	script_set_anim ACTOR_TRAINING_COURT_BOB_1, ANIM_BOUNCE ; $6465
	script_wait_idle ACTOR_TRAINING_COURT_BOB_1 ; $646c
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $6471
	script_set_anim ACTOR_TRAINING_COURT_BOB_1, ANIM_NOD ; $6476
	script_wait_idle ACTOR_TRAINING_COURT_BOB_1 ; $647d
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $6482
	call WalkToServeChallengeCourtCutscene ; $6487
	ld a, STORYLOC_TRAINING_COURT ; $648a
	ld [wStoryModeCurrentLocation], a ; $648c
	ld a, $0a ; $648f
	ld [wStoryModeEntryPoint], a ; $6491
	ld a, $ff ; $6494
	ld [wUnusedExitTriggerIdMirror], a ; $6496
	ld [wStoryModeExitTriggerRequest], a ; $6499
	ld a, MINIGAME_SERVICE_MATCH_1 ; $649c
	farcall RunTrainingDrillByID ; $649e
	ret ; $64a1
.loop:
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $64a2
	ret ; $64a7
CenterLineServeMatchChallengeScene:
	script_face_toward ACTOR_TRAINING_COURT_BOB_1, ACTOR_PARTNER ; $64a8
	script_set_text Text_6e_38 ; $64b0
	script_speak_restore ACTOR_TRAINING_COURT_BOB_1 ; $64b6
	farcall RunDialogueYesNoPrompt ; $64bb
	farcall ScriptCloseDialogueWindow ; $64be
	script_wait_frames $05 ; $64c1
	and a ; $64c8
	jp nz, ServiceAceMatchChallengeScene.loop ; $64c9
	farcall AdvanceDialogueTextCursor ; $64cc
	script_speak_restore ACTOR_TRAINING_COURT_BOB_1 ; $64cf
	farcall RunDialogueYesNoPrompt ; $64d4
	farcall ScriptCloseDialogueWindow ; $64d7
	script_wait_frames $05 ; $64da
	and a ; $64e1
	jp nz, ServiceAceMatchChallengeScene.loop ; $64e2
	farcall AdvanceDialogueTextCursor ; $64e5
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $64e8
	script_set_anim ACTOR_TRAINING_COURT_BOB_1, ANIM_NOD ; $64ed
	script_wait_idle ACTOR_TRAINING_COURT_BOB_1 ; $64f4
	script_face ACTOR_TRAINING_COURT_BOB_1, FACE_RIGHT ; $64f9
	script_wait_frames $28 ; $6500
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_BOB_1 ; $6507
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $650f
	script_set_anim ACTOR_TRAINING_COURT_BOB_1, ANIM_SHAKE ; $6514
	script_wait_idle ACTOR_TRAINING_COURT_BOB_1 ; $651b
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $6520
	script_wait_frames $14 ; $6525
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $652c
	script_set_anim ACTOR_TRAINING_COURT_BOB_1, ANIM_NOD ; $6531
	script_wait_idle ACTOR_TRAINING_COURT_BOB_1 ; $6538
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $653d
	script_wait_frames $14 ; $6542
	script_set_anim ACTOR_TRAINING_COURT_BOB_1, ANIM_BOUNCE ; $6549
	script_wait_idle ACTOR_TRAINING_COURT_BOB_1 ; $6550
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $6555
	script_set_anim ACTOR_TRAINING_COURT_BOB_1, ANIM_NOD ; $655a
	script_wait_idle ACTOR_TRAINING_COURT_BOB_1 ; $6561
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $6566
	call WalkToServeChallengeCourtCutscene ; $656b
	ld a, STORYLOC_TRAINING_COURT ; $656e
	ld [wStoryModeCurrentLocation], a ; $6570
	ld a, $0a ; $6573
	ld [wStoryModeEntryPoint], a ; $6575
	ld a, $ff ; $6578
	ld [wUnusedExitTriggerIdMirror], a ; $657a
	ld [wStoryModeExitTriggerRequest], a ; $657d
	ld a, MINIGAME_SERVICE_MATCH_2 ; $6580
	farcall RunTrainingDrillByID ; $6582
	ret ; $6585
AcademyRulesServeMatchChallengeScene:
	script_face_toward ACTOR_TRAINING_COURT_BOB_1, ACTOR_PARTNER ; $6586
	script_set_text Text_6e_52 ; $658e
	script_speak_restore ACTOR_TRAINING_COURT_BOB_1 ; $6594
	farcall RunDialogueYesNoPrompt ; $6599
	farcall ScriptCloseDialogueWindow ; $659c
	script_wait_frames $05 ; $659f
	and a ; $65a6
	jp nz, ServiceAceMatchChallengeScene.loop ; $65a7
	farcall AdvanceDialogueTextCursor ; $65aa
	script_speak_restore ACTOR_TRAINING_COURT_BOB_1 ; $65ad
	farcall RunDialogueYesNoPrompt ; $65b2
	farcall ScriptCloseDialogueWindow ; $65b5
	script_wait_frames $05 ; $65b8
	and a ; $65bf
	jp nz, ServiceAceMatchChallengeScene.loop ; $65c0
	farcall AdvanceDialogueTextCursor ; $65c3
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $65c6
	script_set_anim ACTOR_TRAINING_COURT_BOB_1, ANIM_NOD ; $65cb
	script_wait_idle ACTOR_TRAINING_COURT_BOB_1 ; $65d2
	script_face ACTOR_TRAINING_COURT_BOB_1, FACE_RIGHT ; $65d7
	script_wait_frames $28 ; $65de
	script_face_toward ACTOR_PLAYER, ACTOR_TRAINING_COURT_BOB_1 ; $65e5
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $65ed
	script_set_anim ACTOR_TRAINING_COURT_BOB_1, ANIM_NOD ; $65f2
	script_wait_idle ACTOR_TRAINING_COURT_BOB_1 ; $65f9
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $65fe
	script_wait_frames $28 ; $6603
	script_set_anim ACTOR_TRAINING_COURT_BOB_1, ANIM_BOUNCE ; $660a
	script_wait_idle ACTOR_TRAINING_COURT_BOB_1 ; $6611
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $6616
	script_set_anim ACTOR_TRAINING_COURT_BOB_1, ANIM_NOD ; $661b
	script_wait_idle ACTOR_TRAINING_COURT_BOB_1 ; $6622
	script_speak ACTOR_TRAINING_COURT_BOB_1 ; $6627
	call WalkToServeChallengeCourtCutscene ; $662c
	ld a, STORYLOC_TRAINING_COURT ; $662f
	ld [wStoryModeCurrentLocation], a ; $6631
	ld a, $0a ; $6634
	ld [wStoryModeEntryPoint], a ; $6636
	ld a, $ff ; $6639
	ld [wUnusedExitTriggerIdMirror], a ; $663b
	ld [wStoryModeExitTriggerRequest], a ; $663e
	ld a, MINIGAME_SERVICE_MATCH_3 ; $6641
	farcall RunTrainingDrillByID ; $6643
	ret ; $6646
PlayerPartnerGestureCutscene:
	test_flag FLAG_DOUBLES ; $6647
	jr z, .playerOnly ; $664a
	script_face_toward ACTOR_PARTNER, ACTOR_PLAYER ; $664c
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $6654
	script_wait_idle ACTOR_PLAYER ; $665b
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $6660
	script_wait_idle ACTOR_PARTNER ; $6667
	script_face ACTOR_PLAYER, FACE_UP ; $666c
	script_wait_frames $0a ; $6673
	ret ; $667a
.playerOnly:
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $667b
	script_wait_idle ACTOR_PLAYER ; $6682
	script_wait_frames $0a ; $6687
	ret ; $668e
WalkToServeChallengeCourtCutscene:
	script_null_script ACTOR_PARTNER ; $668f
	script_move_player 24.0, 15.0 ; $6694
	script_set_actor_script ACTOR_PLAYER, ActorScript_15_05 ; $669e
	script_set_actor_script ACTOR_TRAINING_COURT_BOB_1, ActorScript_15_04 ; $66a9
	script_set_actor_script ACTOR_PARTNER, ActorScript_15_06 ; $66b4
	script_wait_actor_script ACTOR_PLAYER ; $66bf
	call PlayerPartnerGestureCutscene ; $66c4
	ret ; $66c7
ActorScript_15_04:
	; $66c8, 11 bytes (actor_script)
	as_set_target 23.0, 7.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_15_05:
	; $66d3, 17 bytes (actor_script)
	as_set_target 19.0, 19.0
	as_wait_move
	as_set_target 25.0, 23.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_15_06:
	; $66e4, 11 bytes (actor_script)
	as_set_target 19.0, 17.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
SpeakServeCoachDeclineLine:
	script_speak ACTOR_TRAINING_COURT_CURT ; $66ef
	ret ; $66f4
ServeCoachJuniorLessonScene:
	script_face_toward ACTOR_TRAINING_COURT_CURT, ACTOR_PARTNER ; $66f5
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $66fd
	jr nz, .setText ; $6700
	script_set_text Text_37_16 ; $6702
	jr .scriptShowSpeakerDialogueRestoreBG ; $6708
.setText:
	script_set_text Text_37_22 ; $670a
.scriptShowSpeakerDialogueRestoreBG:
	script_speak_restore ACTOR_TRAINING_COURT_CURT ; $6710
	farcall RunDialogueYesNoPrompt ; $6715
	farcall ScriptCloseDialogueWindow ; $6718
	script_wait_frames $05 ; $671b
	and a ; $6722
	jr nz, SpeakServeCoachDeclineLine ; $6723
	farcall AdvanceDialogueTextCursor ; $6725
	script_speak_restore ACTOR_TRAINING_COURT_CURT ; $6728
	farcall RunDialogueYesNoPrompt ; $672d
	farcall ScriptCloseDialogueWindow ; $6730
	script_wait_frames $05 ; $6733
	and a ; $673a
	jr nz, SpeakServeCoachDeclineLine ; $673b
	farcall AdvanceDialogueTextCursor ; $673d
	script_speak ACTOR_TRAINING_COURT_CURT ; $6740
	call MovePartyToServeCoachSpot ; $6745
	script_face ACTOR_TRAINING_COURT_CURT, FACE_RIGHT ; $6748
	script_wait_frames $14 ; $674f
	script_speak ACTOR_TRAINING_COURT_CURT ; $6756
	ld a, MINIGAME_SERVICE_PRACTICE_1 ; $675b
	ld [wCurrentMinigameStoryMatch + 1], a ; $675d
	ld a, STORYLOC_TRAINING_COURT ; $6760
	ld [wStoryModeCurrentLocation], a ; $6762
	ld a, $09 ; $6765
	ld [wStoryModeEntryPoint], a ; $6767
	ld a, $ff ; $676a
	ld [wUnusedExitTriggerIdMirror], a ; $676c
	ld [wStoryModeExitTriggerRequest], a ; $676f
	ld c, $10 ; $6772
	call BeginFadeOut ; $6774
	call WaitFadeEnd ; $6777
	farcall ShowDrillBriefingScreen ; $677a
	ret ; $677d
ServeCoachSeniorLessonScene:
	script_face_toward ACTOR_TRAINING_COURT_CURT, ACTOR_PARTNER ; $677e
	script_set_text Text_37_36 ; $6786
	script_speak_restore ACTOR_TRAINING_COURT_CURT ; $678c
	farcall RunDialogueYesNoPrompt ; $6791
	farcall ScriptCloseDialogueWindow ; $6794
	script_wait_frames $05 ; $6797
	and a ; $679e
	jp nz, SpeakServeCoachDeclineLine ; $679f
	farcall AdvanceDialogueTextCursor ; $67a2
	script_speak_restore ACTOR_TRAINING_COURT_CURT ; $67a5
	farcall RunDialogueYesNoPrompt ; $67aa
	farcall ScriptCloseDialogueWindow ; $67ad
	script_wait_frames $05 ; $67b0
	and a ; $67b7
	jp nz, SpeakServeCoachDeclineLine ; $67b8
	farcall AdvanceDialogueTextCursor ; $67bb
	script_speak ACTOR_TRAINING_COURT_CURT ; $67be
	call MovePartyToServeCoachSpot ; $67c3
	script_face ACTOR_TRAINING_COURT_CURT, FACE_RIGHT ; $67c6
	script_wait_frames $14 ; $67cd
	script_speak ACTOR_TRAINING_COURT_CURT ; $67d4
	ld a, MINIGAME_SERVICE_PRACTICE_2 ; $67d9
	ld [wCurrentMinigameStoryMatch + 1], a ; $67db
	ld a, STORYLOC_TRAINING_COURT ; $67de
	ld [wStoryModeCurrentLocation], a ; $67e0
	ld a, $09 ; $67e3
	ld [wStoryModeEntryPoint], a ; $67e5
	ld a, $ff ; $67e8
	ld [wUnusedExitTriggerIdMirror], a ; $67ea
	ld [wStoryModeExitTriggerRequest], a ; $67ed
	ld c, $10 ; $67f0
	call BeginFadeOut ; $67f2
	call WaitFadeEnd ; $67f5
	farcall ShowDrillBriefingScreen ; $67f8
	ret ; $67fb
ServeCoachVarsityLessonScene:
	script_face_toward ACTOR_TRAINING_COURT_CURT, ACTOR_PARTNER ; $67fc
	script_set_text Text_37_51 ; $6804
	script_speak_restore ACTOR_TRAINING_COURT_CURT ; $680a
	farcall RunDialogueYesNoPrompt ; $680f
	farcall ScriptCloseDialogueWindow ; $6812
	script_wait_frames $05 ; $6815
	and a ; $681c
	jp nz, SpeakServeCoachDeclineLine ; $681d
	farcall AdvanceDialogueTextCursor ; $6820
	script_speak_restore ACTOR_TRAINING_COURT_CURT ; $6823
	farcall RunDialogueYesNoPrompt ; $6828
	farcall ScriptCloseDialogueWindow ; $682b
	script_wait_frames $05 ; $682e
	and a ; $6835
	jp nz, SpeakServeCoachDeclineLine ; $6836
	farcall AdvanceDialogueTextCursor ; $6839
	script_speak ACTOR_TRAINING_COURT_CURT ; $683c
	call MovePartyToServeCoachSpot ; $6841
	script_face ACTOR_TRAINING_COURT_CURT, FACE_RIGHT ; $6844
	script_wait_frames $14 ; $684b
	script_speak ACTOR_TRAINING_COURT_CURT ; $6852
	ld a, MINIGAME_SERVICE_PRACTICE_3 ; $6857
	ld [wCurrentMinigameStoryMatch + 1], a ; $6859
	ld a, STORYLOC_TRAINING_COURT ; $685c
	ld [wStoryModeCurrentLocation], a ; $685e
	ld a, $09 ; $6861
	ld [wStoryModeEntryPoint], a ; $6863
	ld a, $ff ; $6866
	ld [wUnusedExitTriggerIdMirror], a ; $6868
	ld [wStoryModeExitTriggerRequest], a ; $686b
	ld c, $10 ; $686e
	call BeginFadeOut ; $6870
	call WaitFadeEnd ; $6873
	farcall ShowDrillBriefingScreen ; $6876
	ret ; $6879
Unused_15_SpeakServeCoachLines:
	script_speak $07 ; $687a
	script_speak $07 ; $687f
	script_speak $07 ; $6884
	script_speak $07 ; $6889
	ret ; $688e
