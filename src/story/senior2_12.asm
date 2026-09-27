SetPartnerObjDefByGender_12:
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $5e91
	or a ; $5e94
	jr nz, .done ; $5e95
	script_get_actor_state ACTOR_SENIOR_COURT_A_KATE ; $5e97
	ld c, l ; $5e9c
	ld b, h ; $5e9d
	ld d, OBJ_HARRY ; $5e9e
	farcall LoadActorObjectDefIfValid ; $5ea0
	script_set_anim ACTOR_SENIOR_COURT_A_KATE, ANIM_WALK ; $5ea3
.done:
	ret ; $5eaa
SeniorCourtWalkPlayersOntoCourt:
	ld a, [wStoryModeEntryPoint] ; $5eab
	cp $01 ; $5eae
	jp nz, .done ; $5eb0
	test_flag FLAG_DOUBLES ; $5eb3
	jr z, .walkOff ; $5eb6
	script_set_speed ACTOR_PARTNER, $00ff ; $5eb8
	script_move_angle ACTOR_PARTNER, FACE_DOWN, $0200 ; $5ec0
	script_wait_move ACTOR_PARTNER ; $5eca
	script_face ACTOR_PARTNER, FACE_UP ; $5ecf
	script_set_speed ACTOR_PARTNER, $0010 ; $5ed6
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $5ede
	script_move_angle ACTOR_PLAYER, FACE_UP, $0200 ; $5ee6
.done:
	ret ; $5ef0
SeniorRankOfferScenePrep:
	script_set_speed ACTOR_PLAYER, $0010 ; $5ef1
	test_flag FLAG_DOUBLES ; $5ef9
	jp z, SeniorSinglesRankOfferScene ; $5efc
	call SeniorDoublesRankOfferScene ; $5eff
	ret ; $5f02
SeniorRankOfferScenePrepFacingUp:
	script_set_speed ACTOR_PLAYER, $0008 ; $5f03
	script_face ACTOR_PLAYER, FACE_UP ; $5f0b
	script_lock_facing ACTOR_PLAYER ; $5f12
	test_flag FLAG_DOUBLES ; $5f19
	jr z, SeniorSinglesRankOfferScene ; $5f1c
	call SeniorDoublesRankOfferScene ; $5f1e
	ret ; $5f21
SeniorSinglesRankOfferScene:
	script_move_target ACTOR_PLAYER, $2d00, $1b00 ; $5f22
	script_wait_move ACTOR_PLAYER ; $5f2d
	script_wait_frames $0a ; $5f32
	script_unlock_facing ACTOR_PLAYER ; $5f39
	script_face_toward ACTOR_SENIOR_COURT_EMILY, ACTOR_PLAYER ; $5f40
	script_face_toward ACTOR_PLAYER, ACTOR_SENIOR_COURT_EMILY ; $5f48
	script_set_text Text_34_60 ; $5f50
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_4 ; $5f56
	jr z, .prompt ; $5f59
	farcall AdvanceDialogueTextCursor ; $5f5b
.prompt:
	ld a, $03 ; $5f5e
	farcall ScriptShowSpeakerDialogueRestoreBG ; $5f60
	farcall RunDialogueYesNoPrompt ; $5f63
	farcall ScriptCloseDialogueWindow ; $5f66
	script_wait_frames $05 ; $5f69
	and a ; $5f70
	jp nz, .done ; $5f71
	script_set_text Text_34_64 ; $5f74
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_4 ; $5f7a
	jr z, .accepted ; $5f7d
	farcall AdvanceDialogueTextCursor ; $5f7f
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_3 ; $5f82
	jr z, .accepted ; $5f85
	farcall AdvanceDialogueTextCursor ; $5f87
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_2 ; $5f8a
	jr z, .accepted ; $5f8d
	farcall AdvanceDialogueTextCursor ; $5f8f
.accepted:
	script_speak ACTOR_SENIOR_COURT_EMILY ; $5f92
	call RunSeniorRankingMatchIntro ; $5f97
	script_face ACTOR_PLAYER, FACE_UP ; $5f9a
	script_wait_frames $0f ; $5fa1
	script_set_anim ACTOR_SENIOR_COURT_EMILY, ANIM_BOUNCE ; $5fa8
	script_wait_idle ACTOR_SENIOR_COURT_EMILY ; $5faf
	call SeniorSinglesMatchConfirm ; $5fb4
	ret ; $5fb7
.done:
	script_set_text Text_34_62 ; $5fb8
	script_speak ACTOR_SENIOR_COURT_EMILY ; $5fbe
	farcall EndCutsceneScriptMode ; $5fc3
	ret ; $5fc6
SeniorDoublesRankOfferScene:
	script_null_script ACTOR_PARTNER ; $5fc7
	script_wait_frames $0a ; $5fcc
	script_move_target ACTOR_PARTNER, $2d00, $1d00 ; $5fd3
	script_move_target ACTOR_PLAYER, $2d00, $1b00 ; $5fde
	script_wait_frames $0a ; $5fe9
	script_wait_move ACTOR_PLAYER ; $5ff0
	script_unlock_facing ACTOR_PLAYER ; $5ff5
	script_face_toward ACTOR_SENIOR_COURT_EMILY, ACTOR_PLAYER ; $5ffc
	script_wait_move ACTOR_PARTNER ; $6004
	script_face_toward ACTOR_SENIOR_COURT_EMILY, ACTOR_PARTNER ; $6009
	script_wait_frames $1e ; $6011
	script_face_toward ACTOR_PLAYER, ACTOR_SENIOR_COURT_EMILY ; $6018
	script_set_text Text_34_110 ; $6020
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_3 ; $6026
	jr z, .prompt ; $6029
	farcall AdvanceDialogueTextCursor ; $602b
.prompt:
	ld a, $03 ; $602e
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6030
	farcall RunDialogueYesNoPrompt ; $6033
	farcall ScriptCloseDialogueWindow ; $6036
	script_wait_frames $05 ; $6039
	and a ; $6040
	jp nz, .setText ; $6041
	script_set_text Text_34_113 ; $6044
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_3 ; $604a
	jr z, .accepted ; $604d
	farcall AdvanceDialogueTextCursor ; $604f
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_2 ; $6052
	jr z, .accepted ; $6055
	farcall AdvanceDialogueTextCursor ; $6057
.accepted:
	script_speak ACTOR_SENIOR_COURT_EMILY ; $605a
	call RunSeniorRankingMatchIntro ; $605f
	script_face ACTOR_PLAYER, FACE_UP ; $6062
	script_face ACTOR_PARTNER, FACE_UP ; $6069
	script_wait_frames $0f ; $6070
	script_set_anim ACTOR_SENIOR_COURT_EMILY, ANIM_BOUNCE ; $6077
	script_wait_idle ACTOR_SENIOR_COURT_EMILY ; $607e
	call SeniorDoublesMatchConfirm ; $6083
	ret ; $6086
.setText:
	script_set_text Text_34_112 ; $6087
	script_speak ACTOR_SENIOR_COURT_EMILY ; $608d
	script_get_actor_state ACTOR_PARTNER ; $6092
	ld c, l ; $6097
	ld b, h ; $6098
	ld de, wActors ; $6099
	farcall AttachActorStepMover ; $609c
	ret ; $609f
StartSeniorRankingMatch:
	script_set_speed ACTOR_PLAYER, $0020 ; $60a0
	script_set_speed ACTOR_PARTNER, $0020 ; $60a8
	ld a, [wMapSceneStage2] ; $60b0
	sub SENIORCOURTSTAGE_SINGLES_RANK4 ; $60b3
	rst Rst00 ; $60b5
	dw StartSeniorRankingMatch.rank4 ; $60b6 jumptable
	dw StartSeniorRankingMatch.rank5 ; $60b8 jumptable
	dw StartSeniorRankingMatch.rank6 ; $60ba jumptable
	dw StartSeniorRankingMatch.rank7 ; $60bc jumptable
	dw StartSeniorRankingMatch.rank1 ; $60be jumptable
	dw StartSeniorRankingMatch.rank2 ; $60c0 jumptable
	dw StartSeniorRankingMatch.rank3 ; $60c2 jumptable
.rank1:
	script_face ACTOR_SENIOR_COURT_EMILY, FACE_LEFT ; $60c4
	script_wait_frames $0f ; $60cb
	script_set_actor_script ACTOR_SENIOR_COURT_CURT, ActorScript_12_26 ; $60d2
	script_set_actor_script ACTOR_SENIOR_COURT_BETH, ActorScript_12_22 ; $60dd
	script_set_actor_script ACTOR_PARTNER, ActorScript_12_15 ; $60e8
	script_set_actor_script ACTOR_PLAYER, ActorScript_12_13 ; $60f3
	script_move_player $2400, $1700 ; $60fe
	farcall WaitPlayerMoveDone ; $6108
	script_wait_actor_script ACTOR_SENIOR_COURT_BETH ; $610b
	script_wait_frames $1e ; $6110
	ld a, $0f ; $6117
	ld [wUnusedExitTriggerIdMirror], a ; $6119
	ld [wStoryModeExitTriggerRequest], a ; $611c
	farcall InitStoryMatchSettings ; $611f
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_SENIOR_3 ; $6122
	farcall RunStoryMatch ; $612f
	farcall RestoreOverworldAfterMatch ; $6132
	ret ; $6135
.rank2:
	script_face ACTOR_SENIOR_COURT_EMILY, FACE_RIGHT ; $6136
	script_wait_frames $0f ; $613d
	script_face ACTOR_PLAYER, FACE_RIGHT ; $6144
	script_face ACTOR_PARTNER, FACE_RIGHT ; $614b
	script_face ACTOR_SENIOR_COURT_BRIAN, FACE_RIGHT ; $6152
	script_face ACTOR_SENIOR_COURT_JOY, FACE_RIGHT ; $6159
	call ApproachSeniorCourtPairB ; $6160
	script_set_actor_script ACTOR_SENIOR_COURT_JOY, ActorScript_12_31 ; $6163
	script_set_actor_script ACTOR_SENIOR_COURT_BRIAN, ActorScript_12_32 ; $616e
	script_set_actor_script ACTOR_PARTNER, ActorScript_12_16 ; $6179
	farcall WaitPlayerMoveDone ; $6184
	script_wait_actor_script ACTOR_SENIOR_COURT_BRIAN ; $6187
	script_wait_frames $1e ; $618c
	ld a, $0f ; $6193
	ld [wUnusedExitTriggerIdMirror], a ; $6195
	ld [wStoryModeExitTriggerRequest], a ; $6198
	farcall InitStoryMatchSettings ; $619b
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_SENIOR_2 ; $619e
	farcall RunStoryMatch ; $61ab
	farcall RestoreOverworldAfterMatch ; $61ae
	ret ; $61b1
.rank3:
	script_face ACTOR_SENIOR_COURT_EMILY, FACE_LEFT ; $61b2
	script_wait_frames $0f ; $61b9
	script_face ACTOR_PLAYER, FACE_LEFT ; $61c0
	script_face ACTOR_SENIOR_COURT_BRIAN, FACE_LEFT ; $61c7
	script_set_actor_script ACTOR_SENIOR_COURT_ALLIE, ActorScript_12_39 ; $61ce
	script_set_actor_script ACTOR_SENIOR_COURT_FAY, ActorScript_12_40 ; $61d9
	script_set_actor_script ACTOR_PARTNER, ActorScript_12_15 ; $61e4
	script_set_actor_script ACTOR_PLAYER, ActorScript_12_13 ; $61ef
	script_move_player $2400, $1700 ; $61fa
	farcall WaitPlayerMoveDone ; $6204
	script_wait_actor_script ACTOR_SENIOR_COURT_FAY ; $6207
	script_wait_frames $1e ; $620c
	ld a, $0f ; $6213
	ld [wUnusedExitTriggerIdMirror], a ; $6215
	ld [wStoryModeExitTriggerRequest], a ; $6218
	farcall InitStoryMatchSettings ; $621b
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_SENIOR_1 ; $621e
	farcall RunStoryMatch ; $622b
	farcall RestoreOverworldAfterMatch ; $622e
	ret ; $6231
.rank4:
	script_face ACTOR_SENIOR_COURT_EMILY, FACE_LEFT ; $6232
	script_wait_frames $0f ; $6239
	script_face ACTOR_PLAYER, FACE_LEFT ; $6240
	script_face ACTOR_SENIOR_COURT_BRIAN, FACE_LEFT ; $6247
	call ApproachSeniorCourtPairA ; $624e
	script_set_actor_script ACTOR_SENIOR_COURT_BRIAN, ActorScript_12_01 ; $6251
	farcall WaitPlayerMoveDone ; $625c
	script_wait_actor_script ACTOR_SENIOR_COURT_BRIAN ; $625f
	script_wait_frames $1e ; $6264
	ld a, $0f ; $626b
	ld [wUnusedExitTriggerIdMirror], a ; $626d
	ld [wStoryModeExitTriggerRequest], a ; $6270
	farcall InitStoryMatchSettings ; $6273
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_SENIOR_4 ; $6276
	farcall RunStoryMatch ; $6283
	farcall RestoreOverworldAfterMatch ; $6286
	ret ; $6289
.rank5:
	script_face ACTOR_SENIOR_COURT_EMILY, FACE_RIGHT ; $628a
	script_wait_frames $0f ; $6291
	script_face ACTOR_PLAYER, FACE_RIGHT ; $6298
	script_face ACTOR_SENIOR_COURT_JOY, FACE_RIGHT ; $629f
	script_wait_frames $1e ; $62a6
	call ApproachSeniorCourtPairB ; $62ad
	script_set_actor_script ACTOR_SENIOR_COURT_JOY, ActorScript_12_05 ; $62b0
	farcall WaitPlayerMoveDone ; $62bb
	script_wait_actor_script ACTOR_SENIOR_COURT_JOY ; $62be
	script_wait_frames $1e ; $62c3
	ld a, $0f ; $62ca
	ld [wUnusedExitTriggerIdMirror], a ; $62cc
	ld [wStoryModeExitTriggerRequest], a ; $62cf
	farcall InitStoryMatchSettings ; $62d2
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_SENIOR_3 ; $62d5
	farcall RunStoryMatch ; $62e2
	farcall RestoreOverworldAfterMatch ; $62e5
	ret ; $62e8
.rank6:
	script_face ACTOR_SENIOR_COURT_EMILY, FACE_RIGHT ; $62e9
	script_wait_frames $0f ; $62f0
	script_face ACTOR_PLAYER, FACE_RIGHT ; $62f7
	script_face ACTOR_SENIOR_COURT_ALLIE, FACE_RIGHT ; $62fe
	script_wait_frames $1e ; $6305
	call ApproachSeniorCourtPairB ; $630c
	script_set_actor_script ACTOR_SENIOR_COURT_ALLIE, ActorScript_12_05 ; $630f
	farcall WaitPlayerMoveDone ; $631a
	script_wait_frames $78 ; $631d
	script_wait_move ACTOR_PLAYER ; $6324
	ld a, $0f ; $6329
	ld [wUnusedExitTriggerIdMirror], a ; $632b
	ld [wStoryModeExitTriggerRequest], a ; $632e
	farcall InitStoryMatchSettings ; $6331
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_SENIOR_2 ; $6334
	farcall RunStoryMatch ; $6341
	farcall RestoreOverworldAfterMatch ; $6344
	ret ; $6347
.rank7:
	script_face ACTOR_SENIOR_COURT_EMILY, FACE_LEFT ; $6348
	script_wait_frames $0f ; $634f
	script_face ACTOR_PLAYER, FACE_LEFT ; $6356
	script_face ACTOR_SENIOR_COURT_FAY, FACE_LEFT ; $635d
	script_wait_frames $1e ; $6364
	call ApproachSeniorCourtPairA ; $636b
	script_set_actor_script ACTOR_SENIOR_COURT_FAY, ActorScript_12_01 ; $636e
	farcall WaitPlayerMoveDone ; $6379
	script_wait_frames $b4 ; $637c
	ld a, $0f ; $6383
	ld [wUnusedExitTriggerIdMirror], a ; $6385
	ld [wStoryModeExitTriggerRequest], a ; $6388
	farcall InitStoryMatchSettings ; $638b
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_SENIOR_1 ; $638e
	farcall RunStoryMatch ; $639b
	farcall RestoreOverworldAfterMatch ; $639e
	ret ; $63a1
ApproachSeniorCourtPairA:
	script_set_actor_script ACTOR_SENIOR_COURT_WALK_74_00_1, ActorScript_12_17 ; $63a2
	script_set_actor_script ACTOR_SENIOR_COURT_WALK_74_00_2, ActorScript_12_18 ; $63ad
	script_wait_actor_script ACTOR_SENIOR_COURT_WALK_74_00_2 ; $63b8
	script_move_player $2400, $1700 ; $63bd
	script_set_actor_script ACTOR_PLAYER, ActorScript_12_13 ; $63c7
	ret ; $63d2
ApproachSeniorCourtPairB:
	script_set_actor_script $0f, ActorScript_12_19 ; $63d3
	script_set_actor_script $10, ActorScript_12_20 ; $63de
	script_wait_actor_script $0f ; $63e9
	script_move_player $3500, $1700 ; $63ee
	script_set_actor_script ACTOR_PLAYER, ActorScript_12_14 ; $63f8
	ret ; $6403
PlaceSeniorCourtPairA:
	script_null_script $0d ; $6404
	script_null_script $0e ; $6409
	script_set_position $0d, $2900, $1300 ; $640e
	script_set_position $0e, $2900, $1900 ; $6419
	script_face $0d, FACE_LEFT ; $6424
	script_face $0e, FACE_LEFT ; $642b
	ret ; $6432
PlaceSeniorCourtPairB:
	script_null_script $0f ; $6433
	script_null_script $10 ; $6438
	script_set_position $0f, $3900, $1300 ; $643d
	script_set_position $10, $3900, $1900 ; $6448
	script_face $0f, FACE_LEFT ; $6453
	script_face $10, FACE_LEFT ; $645a
	script_wait_frames $14 ; $6461
	ret ; $6468
StartSeniorCourtPairARally:
	script_move_target $0d, $2200, $1100 ; $6469
	script_move_target $0e, $2500, $1d00 ; $6474
	script_wait_move $0d ; $647f
	script_wait_move $0e ; $6484
	script_set_actor_script $0d, ActorScript_12_53 ; $6489
	script_set_actor_script $0e, ActorScript_12_54 ; $6494
	ret ; $649f
StartSeniorCourtPairBRally:
	script_move_target $0f, $3200, $1100 ; $64a0
	script_move_target $10, $3600, $1d00 ; $64ab
	script_wait_move $0f ; $64b6
	script_wait_move $10 ; $64bb
	script_face $10, FACE_UP ; $64c0
	script_set_actor_script $0f, ActorScript_12_55 ; $64c7
	script_set_actor_script $10, ActorScript_12_56 ; $64d2
	ret ; $64dd
RunSeniorRankingMatchIntro:
	ld a, [wMapSceneStage2] ; $64de
	sub SENIORCOURTSTAGE_SINGLES_RANK4 ; $64e1
	add a ; $64e3
	ld_hl_indexed SeniorRankingMatchIntroPtrs ; $64e4
	ld a, [hl+] ; $64eb
	ld h, [hl] ; $64ec
	ld l, a ; $64ed
	call JumpToHL ; $64ee
	ret ; $64f1
SeniorRankingMatchIntroPtrs:
	; $64f2, 14 bytes (records:2)
	dw SeniorSinglesRank4Intro ; record 0
	dw SeniorSinglesRank3Intro ; record 1
	dw SeniorSinglesRank2Intro ; record 2
	dw SeniorSinglesRank1Intro ; record 3
	dw SeniorDoublesRank3Intro ; record 4
	dw SeniorDoublesRank2Intro ; record 5
	dw SeniorDoublesRank1Intro ; record 6
SeniorDoublesRank3Intro:
	script_wait_frames $0f ; $6500
	script_face_toward $09, $03 ; $6507
	script_wait_frames $1e ; $650f
	script_face_toward $09, ACTOR_PLAYER ; $6516
	script_face_toward $09, ACTOR_PARTNER ; $651e
	script_wait_frames $1e ; $6526
	script_player_speed $0020 ; $652d
	script_move_player_to_actor $09 ; $6533
	farcall WaitPlayerMoveDone ; $653a
	ld bc, wActors + 1 * ACTOR_SIZE ; $653d
	script_get_actor_state $09 ; $6540
	ld e, l ; $6545
	ld d, h ; $6546
	farcall AttachActorWaypointFollower ; $6547
	script_face_toward $03, $09 ; $654a
	script_null_script $08 ; $6552
	script_set_anim $08, ANIM_WALK ; $6557
	script_face_toward $03, $08 ; $655e
	script_set_anim $09, ANIM_NOD ; $6566
	script_wait_idle $09 ; $656d
	script_set_actor_script $09, ActorScript_12_21 ; $6572
	script_set_actor_script $08, ActorScript_12_25 ; $657d
	script_face $03, FACE_DOWN ; $6588
	script_wait_actor_script $09 ; $658f
	script_null_script ACTOR_PLAYER_SHADOW ; $6594
	script_move_player_to_actor ACTOR_PLAYER ; $6599
	farcall WaitPlayerMoveDone ; $65a0
	script_face_toward $09, ACTOR_PLAYER ; $65a3
	script_set_text Text_34_126 ; $65ab
	script_set_anim $08, ANIM_NOD ; $65b1
	script_wait_idle $08 ; $65b8
	script_speak $08 ; $65bd
	script_set_anim $09, ANIM_NOD ; $65c2
	script_wait_idle $09 ; $65c9
	script_speak $09 ; $65ce
	script_face $09, FACE_UP ; $65d3
	script_face $08, FACE_UP ; $65da
	script_face ACTOR_PARTNER, FACE_UP ; $65e1
	ret ; $65e8
SeniorDoublesRank2Intro:
	script_wait_frames $0f ; $65e9
	script_face_toward $06, $03 ; $65f0
	script_wait_frames $1e ; $65f8
	script_face_toward $07, ACTOR_PLAYER ; $65ff
	script_face_toward $06, ACTOR_PARTNER ; $6607
	script_wait_frames $1e ; $660f
	script_player_speed $0020 ; $6616
	script_move_player_to_actor $07 ; $661c
	farcall WaitPlayerMoveDone ; $6623
	ld bc, wActors + 1 * ACTOR_SIZE ; $6626
	script_get_actor_state $07 ; $6629
	ld e, l ; $662e
	ld d, h ; $662f
	farcall AttachActorWaypointFollower ; $6630
	script_face_toward $03, $07 ; $6633
	script_set_anim $07, ANIM_NOD ; $663b
	script_wait_idle $07 ; $6642
	script_set_actor_script $07, ActorScript_12_29 ; $6647
	script_set_actor_script $06, ActorScript_12_30 ; $6652
	script_face $03, FACE_DOWN ; $665d
	script_wait_actor_script $07 ; $6664
	script_null_script ACTOR_PLAYER_SHADOW ; $6669
	script_move_player_to_actor ACTOR_PLAYER ; $666e
	farcall WaitPlayerMoveDone ; $6675
	script_set_text Text_34_124 ; $6678
	script_set_anim $06, ANIM_NOD ; $667e
	script_wait_idle $06 ; $6685
	script_speak $06 ; $668a
	script_set_anim $07, ANIM_NOD ; $668f
	script_wait_idle $07 ; $6696
	script_speak $07 ; $669b
	script_face $07, FACE_UP ; $66a0
	script_face $06, FACE_UP ; $66a7
	ret ; $66ae
SeniorDoublesRank1Intro:
	script_wait_frames $0f ; $66af
	script_face_toward $05, $03 ; $66b6
	script_wait_frames $1e ; $66be
	script_face_toward $04, ACTOR_PLAYER ; $66c5
	script_face_toward $05, ACTOR_PARTNER ; $66cd
	script_null_script $04 ; $66d5
	script_set_anim $04, ANIM_WALK ; $66da
	script_wait_frames $1e ; $66e1
	script_player_speed $0020 ; $66e8
	script_null_script $04 ; $66ee
	script_face $04, FACE_DOWN ; $66f3
	script_move_target $05, $2b00, $1100 ; $66fa
	script_move_player_to_actor $05 ; $6705
	farcall WaitPlayerMoveDone ; $670c
	script_face $05, FACE_DOWN ; $670f
	script_face_toward $03, $05 ; $6716
	script_set_anim $05, ANIM_NOD ; $671e
	script_wait_idle $05 ; $6725
	script_set_actor_script $05, ActorScript_12_37 ; $672a
	script_wait_frames $0f ; $6735
	script_move_player_to_actor ACTOR_PLAYER ; $673c
	script_set_actor_script $04, ActorScript_12_38 ; $6743
	script_face $03, FACE_DOWN ; $674e
	script_wait_actor_script $04 ; $6755
	script_face_toward $04, ACTOR_PLAYER ; $675a
	script_face_toward $05, ACTOR_PARTNER ; $6762
	script_set_text Text_34_122 ; $676a
	script_set_anim $04, ANIM_NOD ; $6770
	script_wait_idle $04 ; $6777
	script_speak $04 ; $677c
	script_set_anim $05, ANIM_NOD ; $6781
	script_wait_idle $05 ; $6788
	script_speak $05 ; $678d
	script_face $05, FACE_UP ; $6792
	script_face $04, FACE_UP ; $6799
	ret ; $67a0
SeniorSinglesRank4Intro:
	script_wait_frames $0f ; $67a1
	script_face_toward $07, $03 ; $67a8
	script_wait_frames $1e ; $67b0
	script_face_toward $07, ACTOR_PLAYER ; $67b7
	script_wait_frames $1e ; $67bf
	script_player_speed $0020 ; $67c6
	script_move_player_to_actor $07 ; $67cc
	farcall WaitPlayerMoveDone ; $67d3
	ld bc, wActors + 1 * ACTOR_SIZE ; $67d6
	script_get_actor_state $07 ; $67d9
	ld e, l ; $67de
	ld d, h ; $67df
	farcall AttachActorWaypointFollower ; $67e0
	script_face_toward $03, $07 ; $67e3
	script_set_anim $07, ANIM_NOD ; $67eb
	script_wait_idle $07 ; $67f2
	script_set_actor_script $07, ActorScript_12_00 ; $67f7
	script_face $03, FACE_DOWN ; $6802
	script_wait_actor_script $07 ; $6809
	script_null_script ACTOR_PLAYER_SHADOW ; $680e
	script_face_toward $07, ACTOR_PLAYER ; $6813
	script_set_anim $07, ANIM_BOUNCE ; $681b
	script_wait_idle $07 ; $6822
	script_set_anim $07, ANIM_NOD ; $6827
	script_wait_idle $07 ; $682e
	script_face $07, FACE_UP ; $6833
	ret ; $683a
SeniorSinglesRank3Intro:
	script_wait_frames $0f ; $683b
	script_face_toward $06, $03 ; $6842
	script_wait_frames $1e ; $684a
	script_face_toward $06, ACTOR_PLAYER ; $6851
	script_wait_frames $1e ; $6859
	script_player_speed $0020 ; $6860
	script_move_player_to_actor $06 ; $6866
	farcall WaitPlayerMoveDone ; $686d
	ld bc, wActors + 1 * ACTOR_SIZE ; $6870
	script_get_actor_state $06 ; $6873
	ld e, l ; $6878
	ld d, h ; $6879
	farcall AttachActorWaypointFollower ; $687a
	script_face_toward $03, $06 ; $687d
	script_set_anim $06, ANIM_NOD ; $6885
	script_wait_idle $06 ; $688c
	script_set_actor_script $06, ActorScript_12_04 ; $6891
	script_face $03, FACE_DOWN ; $689c
	script_move_player_to_actor ACTOR_PLAYER ; $68a3
	script_wait_actor_script $06 ; $68aa
	script_null_script ACTOR_PLAYER_SHADOW ; $68af
	script_face_pair ACTOR_PLAYER, $06 ; $68b4
	script_set_anim $06, ANIM_BOUNCE ; $68bc
	script_wait_idle $06 ; $68c3
	script_set_text Text_34_58 ; $68c8
	script_speak $06 ; $68ce
	script_set_anim $06, ANIM_NOD ; $68d3
	script_wait_idle $06 ; $68da
	script_speak $06 ; $68df
	script_wait_frames $0f ; $68e4
	script_face $06, FACE_UP ; $68eb
	ret ; $68f2
SeniorSinglesRank2Intro:
	script_wait_frames $0f ; $68f3
	script_face_toward $05, $03 ; $68fa
	script_wait_frames $1e ; $6902
	script_face_toward $05, ACTOR_PLAYER ; $6909
	script_wait_frames $1e ; $6911
	script_player_speed $0020 ; $6918
	script_move_player_to_actor $05 ; $691e
	farcall WaitPlayerMoveDone ; $6925
	ld bc, wActors + 1 * ACTOR_SIZE ; $6928
	script_get_actor_state $05 ; $692b
	ld e, l ; $6930
	ld d, h ; $6931
	farcall AttachActorWaypointFollower ; $6932
	script_face_toward $03, $05 ; $6935
	script_set_anim $05, ANIM_NOD ; $693d
	script_wait_idle $05 ; $6944
	script_set_actor_script $05, ActorScript_12_08 ; $6949
	script_face $03, FACE_DOWN ; $6954
	script_null_script ACTOR_PLAYER_SHADOW ; $695b
	script_move_player_to_actor ACTOR_PLAYER ; $6960
	farcall WaitPlayerMoveDone ; $6967
	script_face_toward ACTOR_PLAYER, $05 ; $696a
	script_set_anim $05, ANIM_BOUNCE ; $6972
	script_wait_idle $05 ; $6979
	script_set_text Text_34_56 ; $697e
	script_speak $05 ; $6984
	script_set_anim $05, ANIM_NOD ; $6989
	script_wait_idle $05 ; $6990
	script_speak $05 ; $6995
	script_wait_frames $0f ; $699a
	script_face $05, FACE_UP ; $69a1
	ret ; $69a8
SeniorSinglesRank1Intro:
	script_wait_frames $0f ; $69a9
	script_face_toward $04, $03 ; $69b0
	script_wait_frames $1e ; $69b8
	script_face_toward $04, ACTOR_PLAYER ; $69bf
	script_wait_frames $1e ; $69c7
	script_player_speed $0020 ; $69ce
	script_move_player_to_actor $04 ; $69d4
	farcall WaitPlayerMoveDone ; $69db
	script_face_toward $03, $04 ; $69de
	script_set_anim $04, ANIM_NOD ; $69e6
	script_wait_idle $04 ; $69ed
	script_set_actor_script $04, ActorScript_12_11 ; $69f2
	script_face $03, FACE_DOWN ; $69fd
	script_move_player_to_actor ACTOR_PLAYER ; $6a04
	farcall WaitPlayerMoveDone ; $6a0b
	script_face_toward ACTOR_PLAYER, $04 ; $6a0e
	script_set_text Text_34_54 ; $6a16
	script_speak $04 ; $6a1c
	script_set_anim $04, ANIM_NOD ; $6a21
	script_wait_idle $04 ; $6a28
	script_speak $04 ; $6a2d
	script_wait_frames $0f ; $6a32
	script_face $04, FACE_UP ; $6a39
	ret ; $6a40
