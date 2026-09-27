JuniorClassCourtDoublesMatchReturn:
	wram_bank WRAM_ACTORS ; $5d38
	ld a, [wMatchExitRequest] ; $5d3e
	cp $01 ; $5d41
	jr z, .eq01 ; $5d43
	ld a, [wMatchWinLoseFlag] ; $5d45
	cp WINLOSE_WIN ; $5d48
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
	ld a, STORYLOC_JUNIOR_CLASS_COURT_DOUBLES ; $5d85
	ld [wStoryModeCurrentLocation], a ; $5d87
	ld a, $0d ; $5d8a
	ld [wStoryModeEntryPoint], a ; $5d8c
	ld a, $ff ; $5d8f
	ld [wUnusedExitTriggerIdMirror], a ; $5d91
	ld [wStoryModeExitTriggerRequest], a ; $5d94
	farcall StubNop_1e ; $5d97
	ret ; $5d9a
.storeStoryModeShowLocationName:
	xor a ; $5d9b
	ld [wStoryModeShowLocationName], a ; $5d9c
	script_null_script ACTOR_PARTNER ; $5d9f
	script_player_speed $0040 ; $5da4
	ld a, [wCurrentMinigameStoryMatch + 1] ; $5daa
	sub $02 ; $5dad
	ld a, a ; $5daf
	rst Rst00 ; $5db0
	dw JuniorClassCourtDoublesMatchReturn.setFlag ; $5db1 jumptable
	dw JuniorClassCourtDoublesMatchReturn.setFlag2 ; $5db3 jumptable
	dw JuniorClassCourtDoublesMatchReturn.setFlag3 ; $5db5 jumptable
.setFlag:
	set_flag FLAG_WON_JUNIOR_DOUBLES_RANK_3 ; $5db7
	script_player_speed $0040 ; $5dba
	script_move_player $1900, $1100 ; $5dc0
	script_null_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN ; $5dca
	script_null_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY ; $5dcf
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, $01 ; $5dd4
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, $01 ; $5ddb
	script_set_position ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, $1900, $0d00 ; $5de2
	script_set_position ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, $1b00, $0d00 ; $5ded
	script_set_position ACTOR_PLAYER, $1b00, $1500 ; $5df8
	script_set_position ACTOR_PARTNER, $1900, $1500 ; $5e03
	script_face ACTOR_PLAYER, FACE_UP ; $5e0e
	script_face ACTOR_PARTNER, FACE_UP ; $5e15
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, FACE_DOWN ; $5e1c
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, FACE_DOWN ; $5e23
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_RIGHT ; $5e2a
	farcall WaitPlayerMoveDone ; $5e31
	script_fade_in $04 ; $5e34
	call WaitFadeEnd ; $5e39
	script_set_text Text_32_101 ; $5e3c
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, $02 ; $5e42
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN ; $5e49
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, $04 ; $5e4e
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY ; $5e55
	script_jump_velocity ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, $ff80 ; $5e5a
	ld a, $03 ; $5e62
	farcall ScriptWaitActorJumpDone ; $5e64
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $5e67
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, ActorScript_11_04 ; $5e6c
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, ActorScript_11_06 ; $5e77
	script_move_target ACTOR_PLAYER, $1300, $1700 ; $5e82
	script_move_target ACTOR_PARTNER, $1300, $1500 ; $5e8d
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_DOWN ; $5e98
	script_wait_move ACTOR_PLAYER ; $5e9f
	script_face ACTOR_PLAYER, FACE_DOWN ; $5ea4
	script_wait_frames $28 ; $5eab
	script_get_actor_state ACTOR_PARTNER ; $5eb2
	ld c, l ; $5eb7
	ld b, h ; $5eb8
	ld de, wActors ; $5eb9
	farcall AttachActorStepMover ; $5ebc
	ret ; $5ebf
.setFlag2:
	set_flag FLAG_WON_JUNIOR_DOUBLES_RANK_2 ; $5ec0
	call ParkLeftCourtPracticePairLeftSide ; $5ec3
	script_player_speed $0040 ; $5ec6
	script_move_player $0b00, $0f00 ; $5ecc
	script_set_position ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, $0b00, $0d00 ; $5ed6
	script_set_position ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, $0900, $0d00 ; $5ee1
	script_set_position ACTOR_PLAYER, $0900, $1500 ; $5eec
	script_set_position ACTOR_PARTNER, $0b00, $1900 ; $5ef7
	script_face ACTOR_PLAYER, FACE_UP ; $5f02
	script_face ACTOR_PARTNER, FACE_UP ; $5f09
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, FACE_DOWN ; $5f10
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, FACE_DOWN ; $5f17
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_LEFT ; $5f1e
	farcall WaitPlayerMoveDone ; $5f25
	script_fade_in $04 ; $5f28
	call WaitFadeEnd ; $5f2d
	script_set_text Text_32_101 ; $5f30
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, $02 ; $5f36
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM ; $5f3d
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, $04 ; $5f42
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH ; $5f49
	script_set_text Text_32_104 ; $5f4e
	script_jump_velocity ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, $ff80 ; $5f54
	ld a, $03 ; $5f5c
	farcall ScriptWaitActorJumpDone ; $5f5e
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $5f61
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, ActorScript_11_14 ; $5f66
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, ActorScript_11_17 ; $5f71
	script_move_target ACTOR_PLAYER, $1300, $1700 ; $5f7c
	script_move_target ACTOR_PARTNER, $1300, $1500 ; $5f87
	call ResumeLeftCourtPractice ; $5f92
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_DOWN ; $5f95
	script_wait_frames $3c ; $5f9c
	script_wait_move ACTOR_PLAYER ; $5fa3
	script_face ACTOR_PLAYER, FACE_DOWN ; $5fa8
	script_get_actor_state ACTOR_PARTNER ; $5faf
	ld c, l ; $5fb4
	ld b, h ; $5fb5
	ld de, wActors ; $5fb6
	farcall AttachActorStepMover ; $5fb9
	ret ; $5fbc
.setFlag3:
	set_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $5fbd
	script_player_speed $0040 ; $5fc0
	script_move_player $1900, $0d00 ; $5fc6
	script_set_position ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, $2500, $0900 ; $5fd0
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, FACE_RIGHT ; $5fdb
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, ActorScript_11_45 ; $5fe2
	script_set_position ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, $2500, $0b00 ; $5fed
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, FACE_RIGHT ; $5ff8
	script_set_position ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, $1300, $1f00 ; $5fff
	script_set_position ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, $1900, $0e00 ; $600a
	script_set_position ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, $1b00, $0e00 ; $6015
	script_set_position ACTOR_PLAYER, $1b00, $1300 ; $6020
	script_set_position ACTOR_PARTNER, $1900, $1300 ; $602b
	script_face ACTOR_PLAYER, FACE_UP ; $6036
	script_face ACTOR_PARTNER, FACE_UP ; $603d
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, FACE_DOWN ; $6044
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, FACE_DOWN ; $604b
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_UP ; $6052
	farcall WaitPlayerMoveDone ; $6059
	script_fade_in $04 ; $605c
	call WaitFadeEnd ; $6061
	script_wait_frames $1e ; $6064
	script_set_text Text_32_113 ; $606b
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, $02 ; $6071
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB ; $6078
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, $04 ; $607d
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT ; $6084
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, $03 ; $6089
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $6090
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, $02 ; $6095
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, $02 ; $609c
	script_set_anim ACTOR_PLAYER, $02 ; $60a3
	script_set_anim ACTOR_PARTNER, $02 ; $60aa
	script_wait_frames $1e ; $60b1
	script_face ACTOR_PLAYER, FACE_DOWN ; $60b8
	script_face ACTOR_PARTNER, FACE_DOWN ; $60bf
	script_player_speed $0010 ; $60c6
	script_set_speed ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, $0010 ; $60cc
	script_move_player $1500, $1700 ; $60d4
	farcall WaitPlayerMoveDone ; $60de
	script_move_target ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, $1300, $1b00 ; $60e1
	script_wait_move ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $60ec
	farcall WaitPlayerMoveDone ; $60f1
	script_move_player $1a00, $1300 ; $60f4
	script_move_target ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, $1a00, $1700 ; $60fe
	script_wait_move ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $6109
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_UP ; $610e
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, $02 ; $6115
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $611c
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $6121
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $6126
	script_wait_frames $1e ; $612e
	script_face ACTOR_PLAYER, FACE_DOWN ; $6135
	script_face ACTOR_PARTNER, FACE_DOWN ; $613c
	script_set_anim ACTOR_PLAYER, $03 ; $6143
	script_set_anim ACTOR_PARTNER, $03 ; $614a
	script_wait_idle ACTOR_PARTNER ; $6151
	script_wait_frames $1e ; $6156
	script_set_text Text_32_117 ; $615d
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, $03 ; $6163
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $616a
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $616f
	script_move_target ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, $1b00, $1500 ; $6174
	script_wait_move ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $617f
	script_speak ACTOR_PLAYER ; $6184
	script_wait_frames $1e ; $6189
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, $02 ; $6190
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $6197
	script_set_anim ACTOR_PLAYER, $03 ; $619c
	script_set_anim ACTOR_PARTNER, $03 ; $61a3
	script_wait_idle ACTOR_PARTNER ; $61aa
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, $03 ; $61af
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $61b6
	script_face_pair ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB ; $61bb
	script_wait_frames $1e ; $61c3
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, FACE_DOWN ; $61ca
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, FACE_DOWN ; $61d1
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, $02 ; $61d8
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT ; $61df
	script_face ACTOR_PLAYER, FACE_UP ; $61e4
	script_face ACTOR_PARTNER, FACE_UP ; $61eb
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, $03 ; $61f2
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB ; $61f9
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT ; $61fe
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
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, $03 ; $6254
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, $03 ; $625b
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT ; $6262
	script_wait_frames $3c ; $6267
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, $03 ; $626e
	ld a, STORYLOC_JUNIOR_CLASS_COURT_DOUBLES ; $6275
	ld [wStoryModeCurrentLocation], a ; $6277
	ld a, $01 ; $627a
	ld [wStoryModeEntryPoint], a ; $627c
	ld a, $ff ; $627f
	ld [wUnusedExitTriggerIdMirror], a ; $6281
	ld [wStoryModeExitTriggerRequest], a ; $6284
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
	and a ; $62b6
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
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_DOWN ; $6307
	script_move_target ACTOR_PARTNER, $1300, $1700 ; $630e
	script_wait_move ACTOR_PARTNER ; $6319
	script_face ACTOR_PARTNER, FACE_UP ; $631e
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $6325
	call DrawDoublesRankingOpponentInfo ; $632a
	script_face ACTOR_PLAYER, FACE_UP ; $632d
	script_wait_frames $0f ; $6334
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, $02 ; $633b
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $6342
	call PromptChallengeRankingOpponent ; $6347
	ret ; $634a
.speak:
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00 ; $634b
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
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_RIGHT ; $636a
	script_move_player_to_actor ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN ; $6371
	farcall WaitPlayerMoveDone ; $6378
	script_null_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN ; $637b
	script_null_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY ; $6380
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, $01 ; $6385
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, FACE_LEFT ; $638c
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, FACE_LEFT ; $6393
	script_wait_frames $32 ; $639a
	script_face ACTOR_PLAYER, FACE_RIGHT ; $63a1
	script_face ACTOR_PARTNER, FACE_RIGHT ; $63a8
	script_set_text Text_32_95 ; $63af
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, $02 ; $63b5
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN ; $63bc
	script_move_target ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, $1500, $1500 ; $63c1
	script_move_target ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, $1500, $1700 ; $63cc
	script_wait_move ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY ; $63d7
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, FACE_LEFT ; $63dc
	script_move_player_to_actor ACTOR_PLAYER ; $63e3
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_DOWN ; $63ea
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, $02 ; $63f1
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN ; $63f8
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN ; $63fd
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, $03 ; $6402
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY ; $6409
	script_wait_frames $0f ; $640e
	script_face ACTOR_PLAYER, FACE_UP ; $6415
	script_face ACTOR_PARTNER, FACE_UP ; $641c
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BRIAN, FACE_UP ; $6423
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_FAY, FACE_UP ; $642a
	ret ; $6431
.rank3:
	script_player_speed $0020 ; $6432
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_LEFT ; $6438
	script_move_player_to_actor ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH ; $643f
	farcall WaitPlayerMoveDone ; $6446
	script_face ACTOR_PLAYER, FACE_LEFT ; $6449
	script_face ACTOR_PARTNER, FACE_LEFT ; $6450
	script_wait_frames $1e ; $6457
	script_set_text Text_32_97 ; $645e
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, ActorScript_11_38 ; $6464
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, ActorScript_11_15 ; $646f
	script_move_player_to_actor ACTOR_PLAYER ; $647a
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_DOWN ; $6481
	farcall WaitPlayerMoveDone ; $6488
	script_wait_frames $1e ; $648b
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, $04 ; $6492
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH ; $6499
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH ; $649e
	script_face_pair ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH ; $64a3
	script_wait_frames $1e ; $64ab
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, $03 ; $64b2
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM ; $64b9
	script_face ACTOR_PLAYER, FACE_UP ; $64be
	script_face ACTOR_PARTNER, FACE_UP ; $64c5
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, FACE_UP ; $64cc
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, FACE_UP ; $64d3
	ret ; $64da
.done:
	script_player_speed $0020 ; $64db
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_RIGHT ; $64e1
	script_wait_frames $14 ; $64e8
	script_face ACTOR_PLAYER, FACE_RIGHT ; $64ef
	script_face ACTOR_PARTNER, FACE_RIGHT ; $64f6
	script_move_player_to_actor ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB ; $64fd
	farcall WaitPlayerMoveDone ; $6504
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, FACE_LEFT ; $6507
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, $02 ; $650e
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT ; $6515
	script_set_text Text_32_99 ; $651a
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, ActorScript_11_41 ; $6520
	script_wait_frames $0f ; $652b
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, ActorScript_11_20 ; $6532
	script_move_player_to_actor ACTOR_PLAYER ; $653d
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_DOWN ; $6544
	farcall WaitPlayerMoveDone ; $654b
	script_wait_frames $0f ; $654e
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, $02 ; $6555
	script_wait_idle ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB ; $655c
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB ; $6561
	script_set_anim ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, $03 ; $6566
	script_speak ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT ; $656d
	script_wait_frames $14 ; $6572
	script_face ACTOR_PLAYER, FACE_UP ; $6579
	script_face ACTOR_PARTNER, FACE_UP ; $6580
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, FACE_UP ; $6587
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, FACE_UP ; $658e
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
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_RIGHT ; $65b9
	script_wait_frames $1e ; $65c0
	script_null_script ACTOR_PARTNER ; $65c7
	script_move_player $1900, $1100 ; $65cc
	script_set_actor_script $08, ActorScript_11_07 ; $65d6
	script_set_actor_script $09, ActorScript_11_08 ; $65e1
	script_move_target ACTOR_PLAYER, $1b00, $1900 ; $65ec
	script_wait_frames $0a ; $65f7
	script_move_target ACTOR_PARTNER, $1900, $1500 ; $65fe
	script_wait_move ACTOR_PLAYER ; $6609
	script_face ACTOR_PLAYER, FACE_UP ; $660e
	script_face ACTOR_PARTNER, FACE_UP ; $6615
	script_wait_frames $3c ; $661c
	ld a, $0f ; $6623
	ld [wUnusedExitTriggerIdMirror], a ; $6625
	ld [wStoryModeExitTriggerRequest], a ; $6628
	farcall InitStoryMatchSettings ; $662b
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_JUNIOR_3 ; $662e
	farcall RunStoryMatch ; $663b
	farcall RestoreOverworldAfterMatch ; $663e
	ret ; $6641
.rank3:
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_LEFT ; $6642
	script_wait_frames $0f ; $6649
	script_face ACTOR_PLAYER, FACE_LEFT ; $6650
	script_face ACTOR_PARTNER, FACE_LEFT ; $6657
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, FACE_LEFT ; $665e
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, FACE_LEFT ; $6665
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_74_00_1, ActorScript_11_27 ; $666c
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_74_00_2, ActorScript_11_28 ; $6677
	script_wait_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_74_00_2 ; $6682
	script_null_script ACTOR_PARTNER ; $6687
	script_move_player $0b00, $1100 ; $668c
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, ActorScript_11_09 ; $6696
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, ActorScript_11_10 ; $66a1
	script_wait_frames $1e ; $66ac
	script_set_actor_script ACTOR_PLAYER, ActorScript_11_44 ; $66b3
	script_set_actor_script ACTOR_PARTNER, ActorScript_11_21 ; $66be
	script_wait_actor_script ACTOR_PLAYER ; $66c9
	script_face ACTOR_PLAYER, FACE_UP ; $66ce
	script_face ACTOR_PARTNER, FACE_UP ; $66d5
	script_wait_frames $3c ; $66dc
	ld a, $0f ; $66e3
	ld [wUnusedExitTriggerIdMirror], a ; $66e5
	ld [wStoryModeExitTriggerRequest], a ; $66e8
	farcall InitStoryMatchSettings ; $66eb
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_JUNIOR_2 ; $66ee
	farcall RunStoryMatch ; $66fb
	farcall RestoreOverworldAfterMatch ; $66fe
	ret ; $6701
.done:
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_WALK_72_00, FACE_RIGHT ; $6702
	script_wait_frames $0f ; $6709
	script_face ACTOR_PLAYER, FACE_RIGHT ; $6710
	script_face ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, FACE_RIGHT ; $6717
	script_wait_frames $1e ; $671e
	script_null_script ACTOR_PARTNER ; $6725
	script_move_player $1900, $1100 ; $672a
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, ActorScript_11_07 ; $6734
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, ActorScript_11_08 ; $673f
	script_move_target ACTOR_PLAYER, $1b00, $1900 ; $674a
	script_wait_frames $14 ; $6755
	script_move_target ACTOR_PARTNER, $1900, $1500 ; $675c
	script_wait_move ACTOR_PLAYER ; $6767
	script_face ACTOR_PLAYER, FACE_UP ; $676c
	script_face ACTOR_PARTNER, FACE_UP ; $6773
	script_wait_frames $3c ; $677a
	ld a, $0f ; $6781
	ld [wUnusedExitTriggerIdMirror], a ; $6783
	ld [wStoryModeExitTriggerRequest], a ; $6786
	farcall InitStoryMatchSettings ; $6789
	load_match_settings MATCHLIST_DOUBLES, STORYMATCH_JUNIOR_1 ; $678c
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
	script_set_actor_script $08, ActorScript_11_03 ; $67b0
	script_set_actor_script $09, ActorScript_11_05 ; $67bb
	script_wait_actor_script $09 ; $67c6
	script_set_actor_script $09, ActorScript_11_22 ; $67cb
	script_wait_actor_script $08 ; $67d6
	script_set_actor_script $08, ActorScript_11_52 ; $67db
	ret ; $67e6
.rank3:
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH, ActorScript_11_13 ; $67e7
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_PAM, ActorScript_11_16 ; $67f2
	script_wait_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BETH ; $67fd
	ret ; $6802
.done:
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB, ActorScript_11_18 ; $6803
	script_set_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_CURT, ActorScript_11_19 ; $680e
	script_wait_actor_script ACTOR_JUNIOR_CLASS_COURT_DOUBLES_BOB ; $6819
	ret ; $681e
