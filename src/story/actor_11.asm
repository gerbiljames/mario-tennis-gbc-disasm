PromptChallengeRankingOpponent:
	script_set_text Text_32_34 ; $7288
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_4 ; $728e
	jr z, .prompt ; $7291
	farcall AdvanceDialogueTextCursor ; $7293
.prompt:
	script_speak_restore ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $7296
	farcall RunDialogueYesNoPrompt ; $729b
	farcall ScriptCloseDialogueWindow ; $729e
	script_wait_frames $05 ; $72a1
	and a ; $72a8
	jp nz, .done ; $72a9
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, ANIM_NOD ; $72ac
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $72b3
.declined:
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, ANIM_NOD ; $72b8
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $72bf
	script_set_text Text_32_40 ; $72c4
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $72ca
	call StartNextRankingMatch ; $72cf
	script_set_speed ACTOR_PLAYER, $0018 ; $72d2
	script_set_speed ACTOR_PARTNER, $0018 ; $72da
	ret ; $72e2
.accepted:
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $72e3
	call LoadRankingOpponentGraphics ; $72e8
	ret ; $72eb
.done:
	script_set_text Text_32_37 ; $72ec
	script_speak_restore ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $72f2
	farcall RunDialogueYesNoPrompt ; $72f7
	farcall ScriptCloseDialogueWindow ; $72fa
	script_wait_frames $05 ; $72fd
	and a ; $7304
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
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, ActorScript_11_32 ; $7325
	script_wait_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM ; $7330
	ret ; $7335
.rank3:
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, ActorScript_11_36 ; $7336
	script_wait_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT ; $7341
	ret ; $7346
.rank4:
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, ActorScript_11_39 ; $7347
	script_wait_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH ; $7352
	ret ; $7357
.done:
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, ActorScript_11_42 ; $7358
	script_wait_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB ; $7363
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
	script_face_toward ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM, ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $7388
	script_wait_frames $1e ; $7390
	script_face_toward ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM, ACTOR_PLAYER ; $7397
	script_wait_frames $1e ; $739f
	script_player_speed $0020 ; $73a6
	script_move_player_to_actor ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM ; $73ac
	farcall WaitPlayerMoveDone ; $73b3
	script_face_toward ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM ; $73b6
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM, ANIM_NOD ; $73be
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM ; $73c5
	script_wait_frames $0a ; $73ca
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM, ActorScript_11_30 ; $73d1
	script_wait_frames $0a ; $73dc
	script_move_player_to_actor ACTOR_PLAYER ; $73e3
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACE_DOWN ; $73ea
	farcall WaitPlayerMoveDone ; $73f1
	script_wait_actor_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM ; $73f4
	script_face_toward ACTOR_PLAYER, ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM ; $73f9
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM, ANIM_BOUNCE ; $7401
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM ; $7408
	script_set_text Text_32_42 ; $740d
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM ; $7413
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM, ANIM_NOD ; $7418
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM ; $741f
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM ; $7424
	script_wait_frames $0f ; $7429
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_PAM, FACE_UP ; $7430
	ret ; $7437
.rank3:
	script_wait_frames $0f ; $7438
	script_face_toward ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT, ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $743f
	script_wait_frames $1e ; $7447
	script_face_toward ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT, ACTOR_PLAYER ; $744e
	script_wait_frames $1e ; $7456
	script_player_speed $0020 ; $745d
	script_move_player_to_actor ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT ; $7463
	farcall WaitPlayerMoveDone ; $746a
	script_face_toward ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT ; $746d
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT, ANIM_NOD ; $7475
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT ; $747c
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT, ActorScript_11_34 ; $7481
	script_move_player_to_actor ACTOR_PLAYER ; $748c
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACE_DOWN ; $7493
	script_wait_actor_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT ; $749a
	script_face_toward ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT, ACTOR_PLAYER ; $749f
	script_wait_actor_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT ; $74a7
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT, ANIM_BOUNCE ; $74ac
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT ; $74b3
	script_set_text Text_32_44 ; $74b8
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT ; $74be
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT, ANIM_NOD ; $74c3
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT ; $74ca
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT ; $74cf
	script_wait_frames $0f ; $74d4
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_CURT, FACE_UP ; $74db
	ret ; $74e2
.rank4:
	script_wait_frames $0f ; $74e3
	script_face_toward ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH, ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $74ea
	script_wait_frames $1e ; $74f2
	script_face_toward ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH, ACTOR_PLAYER ; $74f9
	script_wait_frames $1e ; $7501
	script_player_speed $0020 ; $7508
	script_move_player_to_actor ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH ; $750e
	farcall WaitPlayerMoveDone ; $7515
	script_face_toward ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH ; $7518
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH, ANIM_NOD ; $7520
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH ; $7527
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH, ActorScript_11_38 ; $752c
	script_wait_frames $0a ; $7537
	script_move_player_to_actor ACTOR_PLAYER ; $753e
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACE_DOWN ; $7545
	script_wait_actor_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH ; $754c
	script_face_toward ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH, ACTOR_PLAYER ; $7551
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH, ANIM_BOUNCE ; $7559
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH ; $7560
	script_set_text Text_32_46 ; $7565
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH ; $756b
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH, ANIM_NOD ; $7570
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH ; $7577
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH ; $757c
	script_wait_frames $0f ; $7581
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_BETH, FACE_UP ; $7588
	ret ; $758f
.done:
	script_wait_frames $0f ; $7590
	script_face_toward ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $7597
	script_wait_frames $1e ; $759f
	script_face_toward ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, ACTOR_PLAYER ; $75a6
	script_wait_frames $1e ; $75ae
	script_player_speed $0020 ; $75b5
	script_move_player_to_actor ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB ; $75bb
	farcall WaitPlayerMoveDone ; $75c2
	ld bc, wActors + 1 * ACTOR_SIZE ; $75c5
	script_get_actor_state ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB ; $75c8
	ld e, l ; $75cd
	ld d, h ; $75ce
	farcall AttachActorWaypointFollower ; $75cf
	script_face_toward ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB ; $75d2
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, ANIM_NOD ; $75da
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB ; $75e1
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, ActorScript_11_41 ; $75e6
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, FACE_DOWN ; $75f1
	script_move_player_to_actor ACTOR_PLAYER ; $75f8
	script_wait_actor_script ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB ; $75ff
	script_face_toward ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, ACTOR_PLAYER ; $7604
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, ANIM_BOUNCE ; $760c
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB ; $7613
	script_set_text Text_32_48 ; $7618
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB ; $761e
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, ANIM_NOD ; $7623
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB ; $762a
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB ; $762f
	script_wait_frames $0f ; $7634
	script_face ACTOR_JUNIOR_CLASS_COURT_SINGLES_BOB, FACE_UP ; $763b
	ret ; $7642
ActorScript_11_30:
	; $7643, 23 bytes (actor_script)
	as_set_target 31.0, 25.0
	as_wait_move
	as_set_target 21.0, 25.0
	as_wait_move
	as_set_target 21.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_11_31:
	; $765a, 17 bytes (actor_script)
	as_set_target 21.0, 9.0
	as_wait_move
	as_set_target 25.0, 9.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_11_32:
	; $766b, 23 bytes (actor_script)
	as_set_target 21.0, 25.0
	as_wait_move
	as_set_target 31.0, 25.0
	as_wait_move
	as_set_target 31.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_11_33:
	; $7682, 41 bytes (actor_script)
	as_set_target 26.0, 9.0
	as_wait_move
	as_set_target 33.0, 9.0
	as_wait_move
	as_set_target 33.0, 13.0
	as_wait_move
	as_set_target 39.0, 13.0
	as_wait_move
	as_set_target 39.0, 11.0
	as_wait_move
	as_set_target 37.0, 11.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_11_34:
	; $76ab, 17 bytes (actor_script)
	as_set_target 17.0, 13.0
	as_wait_move
	as_set_target 17.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_11_35:
	; $76bc, 17 bytes (actor_script)
	as_set_target 17.0, 10.0
	as_wait_move
	as_set_target 9.0, 9.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_11_36:
	; $76cd, 17 bytes (actor_script)
	as_set_target 17.0, 13.0
	as_wait_move
	as_set_target 19.0, 13.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_11_37:
	; $76de, 11 bytes (actor_script)
	as_set_target 19.0, 13.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_11_38:
	; $76e9, 23 bytes (actor_script)
	as_set_target 5.0, 25.0
	as_wait_move
	as_set_target 17.0, 25.0
	as_wait_move
	as_set_target 17.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_11_39:
	; $7700, 23 bytes (actor_script)
	as_set_target 17.0, 25.0
	as_wait_move
	as_set_target 5.0, 25.0
	as_wait_move
	as_set_target 5.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_11_40:
	; $7717, 17 bytes (actor_script)
	as_set_target 5.0, 9.0
	as_wait_move
	as_set_target 5.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_11_41:
	; $7728, 29 bytes (actor_script)
	as_set_target 33.0, 23.0
	as_wait_move
	as_set_target 33.0, 25.0
	as_wait_move
	as_set_target 21.0, 25.0
	as_wait_move
	as_set_target 21.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_11_42:
	; $7745, 29 bytes (actor_script)
	as_set_target 21.0, 25.0
	as_wait_move
	as_set_target 33.0, 25.0
	as_wait_move
	as_set_target 33.0, 23.0
	as_wait_move
	as_set_target 35.0, 23.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_11_43:
	; $7762, 17 bytes (actor_script)
	as_set_target 19.0, 25.0
	as_wait_move
	as_set_target 27.0, 25.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_11_44:
	; $7773, 17 bytes (actor_script)
	as_set_target 19.0, 25.0
	as_wait_move
	as_set_target 11.0, 25.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
OfferSinglesRankingMatch:
	script_set_text Text_32_28 ; $7784
	script_speak_restore ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $778a
	farcall RunDialogueYesNoPrompt ; $778f
	farcall ScriptCloseDialogueWindow ; $7792
	script_wait_frames $05 ; $7795
	and a ; $779c
	jp nz, .speak2 ; $779d
	script_unlock_facing ACTOR_PLAYER ; $77a0
	script_set_speed ACTOR_PLAYER, $0018 ; $77a7
	script_move_target ACTOR_PLAYER, 19.0, 21.0 ; $77af
	script_wait_move ACTOR_PLAYER ; $77ba
	script_face_toward ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, ACTOR_PLAYER ; $77bf
	script_wait_frames $1e ; $77c7
	script_face_toward ACTOR_PLAYER, ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $77ce
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
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $77f1
	call DrawRankingOpponentInfo ; $77f6
	script_face ACTOR_PLAYER, FACE_UP ; $77f9
	script_wait_frames $0f ; $7800
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00, ANIM_BOUNCE ; $7807
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $780e
	call PromptChallengeRankingOpponent ; $7813
	ret ; $7816
.speak2:
	script_speak ACTOR_JUNIOR_CLASS_COURT_SINGLES_WALK_72_00 ; $7817
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
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_RIGHT ; $7843
	script_wait_frames $0f ; $784a
	script_face ACTOR_PLAYER, FACE_RIGHT ; $7851
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, FACE_RIGHT ; $7858
	script_wait_frames $1e ; $785f
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_3, ActorScript_11_23 ; $7866
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_4, ActorScript_11_24 ; $7871
	script_wait_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_4 ; $787c
	script_move_player 27.0, 17.0 ; $7881
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, ActorScript_11_31 ; $788b
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_43 ; $7896
	farcall WaitPlayerMoveDone ; $78a1
	script_wait_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM ; $78a4
	script_wait_frames $14 ; $78a9
	ld a, $0f ; $78b0
	ld [wUnusedExitTriggerIdMirror], a ; $78b2
	ld [wStoryModeExitTriggerRequest], a ; $78b5
	farcall InitStoryMatchSettings ; $78b8
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_JUNIOR_4 ; $78bb
	farcall RunStoryMatch ; $78c8
	farcall RestoreOverworldAfterMatch ; $78cb
	ret ; $78ce
.rank3:
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_LEFT ; $78cf
	script_wait_frames $0f ; $78d6
	script_face ACTOR_PLAYER, FACE_LEFT ; $78dd
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, FACE_LEFT ; $78e4
	script_wait_frames $1e ; $78eb
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_1, ActorScript_11_25 ; $78f2
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_2, ActorScript_11_26 ; $78fd
	script_wait_frames $78 ; $7908
	script_move_player 11.0, 17.0 ; $790f
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, ActorScript_11_35 ; $7919
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_44 ; $7924
	farcall WaitPlayerMoveDone ; $792f
	script_wait_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT ; $7932
	script_wait_frames $28 ; $7937
	ld a, $0f ; $793e
	ld [wUnusedExitTriggerIdMirror], a ; $7940
	ld [wStoryModeExitTriggerRequest], a ; $7943
	farcall InitStoryMatchSettings ; $7946
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_JUNIOR_3 ; $7949
	farcall RunStoryMatch ; $7956
	farcall RestoreOverworldAfterMatch ; $7959
	ret ; $795c
.rank4:
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_LEFT ; $795d
	script_wait_frames $0f ; $7964
	script_face ACTOR_PLAYER, FACE_LEFT ; $796b
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, FACE_LEFT ; $7972
	script_wait_frames $1e ; $7979
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_1, ActorScript_11_25 ; $7980
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_2, ActorScript_11_26 ; $798b
	script_wait_frames $78 ; $7996
	script_move_player 11.0, 17.0 ; $799d
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, ActorScript_11_35 ; $79a7
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_44 ; $79b2
	script_wait_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH ; $79bd
	script_wait_frames $28 ; $79c2
	ld a, $0f ; $79c9
	ld [wUnusedExitTriggerIdMirror], a ; $79cb
	ld [wStoryModeExitTriggerRequest], a ; $79ce
	farcall InitStoryMatchSettings ; $79d1
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_JUNIOR_2 ; $79d4
	farcall RunStoryMatch ; $79e1
	farcall RestoreOverworldAfterMatch ; $79e4
	ret ; $79e7
.done:
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_RIGHT ; $79e8
	script_wait_frames $0f ; $79ef
	script_face ACTOR_PLAYER, FACE_RIGHT ; $79f6
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, FACE_RIGHT ; $79fd
	script_wait_frames $1e ; $7a04
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_3, ActorScript_11_23 ; $7a0b
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_RACKET_STUDENT_4, ActorScript_11_24 ; $7a16
	script_wait_frames $78 ; $7a21
	script_move_player 23.0, 19.0 ; $7a28
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, ActorScript_11_31 ; $7a32
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_43 ; $7a3d
	farcall WaitPlayerMoveDone ; $7a48
	script_wait_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB ; $7a4b
	script_wait_frames $28 ; $7a50
	ld a, $0f ; $7a57
	ld [wUnusedExitTriggerIdMirror], a ; $7a59
	ld [wStoryModeExitTriggerRequest], a ; $7a5c
	farcall InitStoryMatchSettings ; $7a5f
	load_match_settings MATCHLIST_SINGLES, STORYMATCH_JUNIOR_1 ; $7a62
	farcall RunStoryMatch ; $7a6f
	farcall RestoreOverworldAfterMatch ; $7a72
	ret ; $7a75
