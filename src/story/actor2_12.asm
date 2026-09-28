IslandOpenDoublesVictory:
	script_set_position $09, $1b00, $0b00 ; $7071
	script_set_position ACTOR_SENIOR_COURT_A_BETH, $1b00, $0d00 ; $707c
	script_face $09, FACE_LEFT ; $7087
	script_face ACTOR_SENIOR_COURT_A_BETH, FACE_LEFT ; $708e
	script_null_script ACTOR_SENIOR_COURT_A_BETH ; $7095
	script_set_anim ACTOR_SENIOR_COURT_A_BETH, ANIM_WALK ; $709a
	script_null_script ACTOR_PARTNER ; $70a1
	script_set_position ACTOR_SENIOR_COURT_A_EMILY, $2b00, $2700 ; $70a6
	script_set_position $04, $2500, $0f00 ; $70b1
	script_face $04, FACE_DOWN ; $70bc
	script_null_script $04 ; $70c3
	script_set_anim $04, ANIM_WALK ; $70c8
	script_set_position ACTOR_SENIOR_COURT_A_ALLIE, $2300, $1300 ; $70cf
	script_face ACTOR_SENIOR_COURT_A_ALLIE, FACE_DOWN ; $70da
	script_null_script ACTOR_SENIOR_COURT_A_ALLIE ; $70e1
	script_set_anim ACTOR_SENIOR_COURT_A_ALLIE, ANIM_WALK ; $70e6
	script_set_position ACTOR_PLAYER, $2500, $1b00 ; $70ed
	script_face ACTOR_PLAYER, FACE_UP ; $70f8
	script_set_position ACTOR_PARTNER, $2300, $1b00 ; $70ff
	script_face ACTOR_PARTNER, FACE_UP ; $710a
	script_player_speed $0040 ; $7111
	script_move_player $2400, $1500 ; $7117
	farcall WaitPlayerMoveDone ; $7121
	script_face ACTOR_SENIOR_COURT_A_EMILY, FACE_LEFT ; $7124
	farcall WaitPlayerMoveDone ; $712b
	script_fade_in $20 ; $712e
	call WaitFadeEnd ; $7133
	script_set_text Text_34_130 ; $7136
	script_move_target $04, $2500, $1300 ; $713c
	script_wait_move $04 ; $7147
	script_face_pair ACTOR_SENIOR_COURT_A_ALLIE, $04 ; $714c
	script_set_anim $04, ANIM_BOUNCE ; $7154
	script_speak $04 ; $715b
	script_face ACTOR_SENIOR_COURT_A_ALLIE, FACE_DOWN ; $7160
	script_set_anim ACTOR_SENIOR_COURT_A_ALLIE, ANIM_SHAKE ; $7167
	script_wait_idle ACTOR_SENIOR_COURT_A_ALLIE ; $716e
	script_speak ACTOR_SENIOR_COURT_A_ALLIE ; $7173
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_NOD ; $7178
	script_speak ACTOR_SENIOR_COURT_A_EMILY ; $717f
	script_set_anim $04, ANIM_BOUNCE ; $7184
	script_set_anim ACTOR_SENIOR_COURT_A_ALLIE, ANIM_BOUNCE ; $718b
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $7192
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $7199
	script_face ACTOR_PLAYER, FACE_DOWN ; $71a0
	script_face ACTOR_PARTNER, FACE_DOWN ; $71a7
	script_face $04, FACE_DOWN ; $71ae
	script_player_speed $0010 ; $71b5
	script_set_speed ACTOR_SENIOR_COURT_A_EMILY, $0010 ; $71bb
	script_move_player $2b00, $2000 ; $71c3
	script_move_target ACTOR_SENIOR_COURT_A_EMILY, $2b00, $2000 ; $71cd
	script_wait_move ACTOR_SENIOR_COURT_A_EMILY ; $71d8
	farcall WaitPlayerMoveDone ; $71dd
	script_move_player $2400, $1b00 ; $71e0
	script_move_target ACTOR_SENIOR_COURT_A_EMILY, $2500, $1f00 ; $71ea
	script_wait_move ACTOR_SENIOR_COURT_A_EMILY ; $71f5
	script_face ACTOR_SENIOR_COURT_A_EMILY, FACE_UP ; $71fa
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_BOUNCE ; $7201
	script_wait_idle ACTOR_SENIOR_COURT_A_EMILY ; $7208
	script_speak ACTOR_SENIOR_COURT_A_EMILY ; $720d
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $7212
	script_wait_frames $1e ; $721a
	script_face ACTOR_PLAYER, FACE_DOWN ; $7221
	script_face ACTOR_PARTNER, FACE_DOWN ; $7228
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $722f
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $7236
	script_wait_idle ACTOR_PLAYER ; $723d
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_NOD ; $7242
	script_wait_idle ACTOR_SENIOR_COURT_A_EMILY ; $7249
	script_set_text Text_34_135 ; $724e
	script_speak ACTOR_SENIOR_COURT_A_EMILY ; $7254
	script_move_target ACTOR_SENIOR_COURT_A_EMILY, $2500, $1d00 ; $7259
	script_wait_move ACTOR_SENIOR_COURT_A_EMILY ; $7264
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_BOUNCE ; $7269
	script_wait_idle ACTOR_SENIOR_COURT_A_EMILY ; $7270
	script_wait_frames $1e ; $7275
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_NOD ; $727c
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $7283
	script_wait_idle ACTOR_PLAYER ; $728a
	script_speak ACTOR_PLAYER ; $728f
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_BOUNCE ; $7294
	script_wait_idle ACTOR_SENIOR_COURT_A_EMILY ; $729b
	script_speak ACTOR_SENIOR_COURT_A_EMILY ; $72a0
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_NOD ; $72a5
	script_wait_idle ACTOR_SENIOR_COURT_A_EMILY ; $72ac
	script_speak ACTOR_SENIOR_COURT_A_EMILY ; $72b1
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $72b6
	script_wait_idle ACTOR_PLAYER ; $72bd
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_NOD ; $72c2
	script_wait_idle ACTOR_SENIOR_COURT_A_EMILY ; $72c9
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $72ce
	script_wait_idle ACTOR_PLAYER ; $72d5
	script_face ACTOR_PLAYER, FACE_UP ; $72da
	script_face ACTOR_PARTNER, FACE_UP ; $72e1
	script_wait_frames $28 ; $72e8
	script_move_player $2400, $1700 ; $72ef
	farcall WaitPlayerMoveDone ; $72f9
	script_set_anim ACTOR_SENIOR_COURT_A_ALLIE, ANIM_BOUNCE ; $72fc
	script_wait_frames $28 ; $7303
	script_speak ACTOR_SENIOR_COURT_A_ALLIE ; $730a
	script_move_target $04, $2500, $1500 ; $730f
	script_wait_move $04 ; $731a
	script_speak $04 ; $731f
	script_face_pair ACTOR_PARTNER, ACTOR_PLAYER ; $7324
	script_wait_frames $0a ; $732c
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $7333
	script_set_anim ACTOR_PARTNER, ANIM_BOUNCE ; $733a
	script_wait_idle ACTOR_PARTNER ; $7341
	script_face ACTOR_PLAYER, FACE_UP ; $7346
	script_face ACTOR_PARTNER, FACE_UP ; $734d
	script_set_anim ACTOR_PARTNER, ANIM_NOD ; $7354
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $735b
	script_wait_idle ACTOR_PLAYER ; $7362
	script_wait_frames $0a ; $7367
	script_set_anim $04, ANIM_NOD ; $736e
	script_set_anim ACTOR_SENIOR_COURT_A_ALLIE, ANIM_NOD ; $7375
	script_wait_idle ACTOR_SENIOR_COURT_A_ALLIE ; $737c
	ld a, STORYLOC_SENIOR_CLASS_COURT ; $7381
	ld [wStoryModeCurrentLocation], a ; $7383
	ld a, $01 ; $7386
	ld [wStoryModeEntryPoint], a ; $7388
	ld a, $ff ; $738b
	ld [wUnusedExitTriggerIdMirror], a ; $738d
	ld [wStoryModeExitTriggerRequest], a ; $7390
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_NOD ; $7393
	script_wait_idle ACTOR_SENIOR_COURT_A_EMILY ; $739a
	script_wait_frames $1e ; $739f
	ld c, $08 ; $73a6
	call BeginFadeOut ; $73a8
	call WaitFadeEnd ; $73ab
	farcall EndCutsceneScriptMode ; $73ae
	ret ; $73b1
SeniorSinglesRank4And3Victory:
	script_set_position ACTOR_SENIOR_COURT_A_BRIAN, $2300, $0f00 ; $73b2
	script_face ACTOR_SENIOR_COURT_A_BRIAN, FACE_DOWN ; $73bd
	call FadeInSeniorCourtNearPairA ; $73c4
	script_set_text Text_34_74 ; $73c7
	script_speak ACTOR_SENIOR_COURT_A_BRIAN ; $73cd
	script_jump_velocity ACTOR_SENIOR_COURT_A_EMILY, $ff80 ; $73d2
	ld a, $03 ; $73da
	farcall ScriptWaitActorJumpDone ; $73dc
	script_speak ACTOR_SENIOR_COURT_A_EMILY ; $73df
	script_set_actor_script ACTOR_SENIOR_COURT_A_BRIAN, ActorScript_12_03 ; $73e4
	script_wait_frames $3c ; $73ef
	script_move_target ACTOR_SENIOR_COURT_A_EMILY, $2d00, $1900 ; $73f6
	script_move_player $2d00, $1b00 ; $7401
	script_move_target ACTOR_PLAYER, $2400, $1d00 ; $740b
	script_wait_move ACTOR_PLAYER ; $7416
	script_move_target ACTOR_PLAYER, $2d00, $1d00 ; $741b
	script_wait_frames $3c ; $7426
	call StartSeniorCourtPairARally ; $742d
	script_face ACTOR_SENIOR_COURT_A_EMILY, FACE_DOWN ; $7430
	script_face ACTOR_PLAYER, FACE_DOWN ; $7437
	script_wait_frames $01 ; $743e
	farcall EndCutsceneScriptMode ; $7445
	ret ; $7448
SeniorSinglesRank2Victory:
	set_flag FLAG_WON_SENIOR_SINGLES_RANK_3 ; $7449
	script_set_position $06, $3300, $0f00 ; $744c
	script_face $06, FACE_DOWN ; $7457
	call FadeInSeniorCourtNearPairB ; $745e
	script_set_position ACTOR_PLAYER, $3400, $1b00 ; $7461
	script_set_text Text_34_35 ; $746c
	script_speak $06 ; $7472
	script_jump_velocity ACTOR_SENIOR_COURT_A_EMILY, $ff80 ; $7477
	ld a, $03 ; $747f
	farcall ScriptWaitActorJumpDone ; $7481
	script_set_text Text_34_76 ; $7484
	script_speak ACTOR_SENIOR_COURT_A_EMILY ; $748a
	script_set_actor_script $06, ActorScript_12_07 ; $748f
	script_move_target ACTOR_PLAYER, $2d00, $1b00 ; $749a
	script_wait_move ACTOR_PLAYER ; $74a5
	script_face ACTOR_PLAYER, FACE_DOWN ; $74aa
	call StartSeniorCourtPairBRally ; $74b1
	farcall EndCutsceneScriptMode ; $74b4
	ret ; $74b7
SeniorSinglesRank1Victory:
	set_flag FLAG_WON_SENIOR_SINGLES_RANK_2 ; $74b8
	call PlaceSeniorCourtPairB ; $74bb
	script_set_position ACTOR_SENIOR_COURT_A_ALLIE, $3300, $0f00 ; $74be
	script_face ACTOR_SENIOR_COURT_A_ALLIE, FACE_DOWN ; $74c9
	call FadeInSeniorCourtNearPairB ; $74d0
	script_set_position ACTOR_PLAYER, $3400, $1b00 ; $74d3
	script_set_text Text_34_32 ; $74de
	script_speak ACTOR_SENIOR_COURT_A_ALLIE ; $74e4
	script_jump_velocity ACTOR_SENIOR_COURT_A_EMILY, $ff80 ; $74e9
	ld a, $03 ; $74f1
	farcall ScriptWaitActorJumpDone ; $74f3
	script_set_text Text_34_77 ; $74f6
	script_speak ACTOR_SENIOR_COURT_A_EMILY ; $74fc
	script_set_actor_script ACTOR_SENIOR_COURT_A_ALLIE, ActorScript_12_10 ; $7501
	script_move_target ACTOR_PLAYER, $2d00, $1b00 ; $750c
	script_wait_move ACTOR_PLAYER ; $7517
	script_face ACTOR_PLAYER, FACE_DOWN ; $751c
	call StartSeniorCourtPairBRally ; $7523
	farcall EndCutsceneScriptMode ; $7526
	ret ; $7529
SeniorSharedVictoryScene:
	script_player_speed $0040 ; $752a
	script_set_speed $04, $0018 ; $7530
	script_set_position ACTOR_SENIOR_COURT_A_EMILY, $2b00, $2700 ; $7538
	script_set_position $04, $2200, $0f00 ; $7543
	script_set_position ACTOR_PLAYER, $2400, $1b00 ; $754e
	script_move_player $2400, $1500 ; $7559
	farcall WaitPlayerMoveDone ; $7563
	script_face ACTOR_PLAYER, FACE_UP ; $7566
	script_face $04, FACE_DOWN ; $756d
	script_face ACTOR_SENIOR_COURT_A_EMILY, FACE_UP ; $7574
	call PlaceSeniorCourtPairA ; $757b
	script_fade_in $08 ; $757e
	call WaitFadeEnd ; $7583
	script_wait_frames $1e ; $7586
	script_set_text Text_34_78 ; $758d
	script_move_target $04, $2400, $1300 ; $7593
	script_wait_move $04 ; $759e
	script_set_anim $04, ANIM_BOUNCE ; $75a3
	script_speak $04 ; $75aa
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_NOD ; $75af
	script_speak ACTOR_SENIOR_COURT_A_EMILY ; $75b6
	script_set_anim $04, ANIM_BOUNCE ; $75bb
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $75c2
	script_face ACTOR_PLAYER, FACE_DOWN ; $75c9
	script_player_speed $0010 ; $75d0
	script_set_speed ACTOR_SENIOR_COURT_A_EMILY, $0010 ; $75d6
	script_move_player $2b00, $2000 ; $75de
	script_move_target ACTOR_SENIOR_COURT_A_EMILY, $2b00, $1f00 ; $75e8
	script_wait_move ACTOR_SENIOR_COURT_A_EMILY ; $75f3
	farcall WaitPlayerMoveDone ; $75f8
	script_move_player $2400, $1e00 ; $75fb
	script_move_target ACTOR_SENIOR_COURT_A_EMILY, $2400, $1f00 ; $7605
	script_wait_move ACTOR_SENIOR_COURT_A_EMILY ; $7610
	script_move_target ACTOR_SENIOR_COURT_A_EMILY, $2400, $1e00 ; $7615
	script_wait_move ACTOR_SENIOR_COURT_A_EMILY ; $7620
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_BOUNCE ; $7625
	script_wait_idle ACTOR_SENIOR_COURT_A_EMILY ; $762c
	script_speak ACTOR_SENIOR_COURT_A_EMILY ; $7631
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $7636
	script_wait_idle ACTOR_PLAYER ; $763d
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_NOD ; $7642
	script_wait_idle ACTOR_SENIOR_COURT_A_EMILY ; $7649
	script_speak ACTOR_SENIOR_COURT_A_EMILY ; $764e
	script_move_target ACTOR_SENIOR_COURT_A_EMILY, $2400, $1d00 ; $7653
	script_wait_move ACTOR_SENIOR_COURT_A_EMILY ; $765e
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_BOUNCE ; $7663
	script_wait_idle ACTOR_SENIOR_COURT_A_EMILY ; $766a
	script_wait_frames $1e ; $766f
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_NOD ; $7676
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $767d
	script_wait_idle ACTOR_PLAYER ; $7684
	script_speak ACTOR_PLAYER ; $7689
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_BOUNCE ; $768e
	script_wait_idle ACTOR_SENIOR_COURT_A_EMILY ; $7695
	script_speak ACTOR_SENIOR_COURT_A_EMILY ; $769a
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $769f
	script_wait_idle ACTOR_PLAYER ; $76a6
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_NOD ; $76ab
	script_wait_idle ACTOR_SENIOR_COURT_A_EMILY ; $76b2
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $76b7
	script_wait_idle ACTOR_PLAYER ; $76be
	script_face ACTOR_PLAYER, FACE_UP ; $76c3
	script_set_position $11, $2580, $1980 ; $76ca
	sound SFX_APPEAR2 ; $76d5
	script_wait_frames $28 ; $76d7
	script_move_player $2400, $1700 ; $76de
	farcall WaitPlayerMoveDone ; $76e8
	script_set_anim $04, ANIM_BOUNCE ; $76eb
	script_wait_frames $28 ; $76f2
	script_move_target $04, $2400, $1500 ; $76f9
	script_wait_move $04 ; $7704
	script_set_position $11, $3f00, $3f00 ; $7709
	script_speak $04 ; $7714
	ld a, STORYLOC_SENIOR_CLASS_COURT ; $7719
	ld [wStoryModeCurrentLocation], a ; $771b
	ld a, $01 ; $771e
	ld [wStoryModeEntryPoint], a ; $7720
	ld a, $ff ; $7723
	ld [wUnusedExitTriggerIdMirror], a ; $7725
	ld [wStoryModeExitTriggerRequest], a ; $7728
	script_set_anim ACTOR_SENIOR_COURT_A_EMILY, ANIM_NOD ; $772b
	script_wait_idle ACTOR_SENIOR_COURT_A_EMILY ; $7732
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $7737
	script_wait_idle ACTOR_PLAYER ; $773e
	script_wait_frames $1e ; $7743
	ld c, $08 ; $774a
	call BeginFadeOut ; $774c
	call WaitFadeEnd ; $774f
	farcall EndCutsceneScriptMode ; $7752
	ret ; $7755
ComputeSeniorCourtStage:
	test_flag FLAG_DOUBLES ; $7756
	jp nz, .isDoubles ; $7759
	ld a, SENIORCOURTSTAGE_SINGLES_PRE_JUNIOR ; $775c
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $775e
	jr z, .loop ; $7761
	ld a, SENIORCOURTSTAGE_SINGLES_RANK4 ; $7763
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_4 ; $7765
	jr z, .loop ; $7768
	ld a, SENIORCOURTSTAGE_SINGLES_RANK3 ; $776a
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_3 ; $776c
	jr z, .loop ; $776f
	ld a, SENIORCOURTSTAGE_SINGLES_RANK2 ; $7771
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_2 ; $7773
	jr z, .loop ; $7776
	ld a, SENIORCOURTSTAGE_SINGLES_RANK1 ; $7778
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_1 ; $777a
	jr z, .loop ; $777d
	ld a, SENIORCOURTSTAGE_SINGLES_SENIOR_CHAMP ; $777f
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $7781
	jr z, .loop ; $7784
	ld a, SENIORCOURTSTAGE_SINGLES_ISLAND_OPEN ; $7786
	test_flag FLAG_STORY_COMPLETE_SINGLES ; $7788
	jr z, .loop ; $778b
	ld a, SENIORCOURTSTAGE_SINGLES_COMPLETE ; $778d
.loop:
	ld [wMapSceneStage2], a ; $778f
	ret ; $7792
.isDoubles:
	ld a, SENIORCOURTSTAGE_DOUBLES_PRE_JUNIOR ; $7793
	test_flag FLAG_WON_JUNIOR_DOUBLES_RANK_1 ; $7795
	jr z, .loop ; $7798
	ld a, SENIORCOURTSTAGE_DOUBLES_RANK3 ; $779a
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_3 ; $779c
	jr z, .loop ; $779f
	ld a, SENIORCOURTSTAGE_DOUBLES_RANK2 ; $77a1
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_2 ; $77a3
	jr z, .loop ; $77a6
	ld a, SENIORCOURTSTAGE_DOUBLES_RANK1 ; $77a8
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_1 ; $77aa
	jr z, .loop ; $77ad
	ld a, SENIORCOURTSTAGE_DOUBLES_SENIOR_CHAMP ; $77af
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $77b1
	jr z, .loop ; $77b4
	ld a, SENIORCOURTSTAGE_DOUBLES_ISLAND_OPEN ; $77b6
	test_flag FLAG_STORY_COMPLETE_DOUBLES ; $77b8
	jr z, .loop ; $77bb
	ld a, SENIORCOURTSTAGE_DOUBLES_COMPLETE ; $77bd
	jr .loop ; $77bf
	ret ; $77c1
FadeInSeniorCourtNearPairA:
	call PlaceSeniorCourtPairA ; $77c2
	script_player_speed $0040 ; $77c5
	script_set_position ACTOR_PLAYER, $2400, $1b00 ; $77cb
	script_move_player $2400, $1500 ; $77d6
	farcall WaitPlayerMoveDone ; $77e0
	script_face ACTOR_PLAYER, FACE_UP ; $77e3
	script_face ACTOR_SENIOR_COURT_A_EMILY, FACE_LEFT ; $77ea
	farcall WaitPlayerMoveDone ; $77f1
	script_fade_in $20 ; $77f4
	call WaitFadeEnd ; $77f9
	ret ; $77fc
FadeInSeniorCourtNearPairB:
	call PlaceSeniorCourtPairB ; $77fd
	script_player_speed $0040 ; $7800
	script_move_player $3500, $1500 ; $7806
	farcall WaitPlayerMoveDone ; $7810
	script_face ACTOR_PLAYER, FACE_UP ; $7813
	script_face ACTOR_SENIOR_COURT_A_EMILY, FACE_RIGHT ; $781a
	farcall WaitPlayerMoveDone ; $7821
	script_fade_in $20 ; $7824
	call WaitFadeEnd ; $7829
	ret ; $782c
ActorScript_12_21:
	; $782d, 11 bytes (actor_script)
	as_set_target $2b00, $1b00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_12_22:
	; $7838, 17 bytes (actor_script)
	as_set_target $2b00, $0f00
	as_wait_move
	as_set_target $2300, $0f00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_12_23:
	; $7849, 11 bytes (actor_script)
	as_set_target $2300, $1c00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_12_24:
	; $7854, 23 bytes (actor_script)
	as_set_target $1900, $0f00
	as_wait_move
	as_set_target $1900, $0b00
	as_wait_move
	as_set_target $1b00, $0b00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_25:
	; $786b, 11 bytes (actor_script)
	as_set_target $2b00, $1d00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_12_26:
	; $7876, 17 bytes (actor_script)
	as_set_target $2b00, $1300
	as_wait_move
	as_set_target $2500, $1300
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_12_27:
	; $7887, 13 bytes (actor_script)
	as_set_target $2300, $1e00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING_LOOP
	as_halt
ActorScript_12_28:
	; $7894, 23 bytes (actor_script)
	as_set_target $1900, $0f00
	as_wait_move
	as_set_target $1900, $0d00
	as_wait_move
	as_set_target $1b00, $0d00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_29:
	; $78ab, 23 bytes (actor_script)
	as_set_target $3900, $1f00
	as_wait_move
	as_set_target $2f00, $1f00
	as_wait_move
	as_set_target $2f00, $1d00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_30:
	; $78c2, 23 bytes (actor_script)
	as_set_target $3900, $1f00
	as_wait_move
	as_set_target $2f00, $1f00
	as_wait_move
	as_set_target $2f00, $1b00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_31:
	; $78d9, 17 bytes (actor_script)
	as_set_target $2f00, $0f00
	as_wait_move
	as_set_target $3300, $0f00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_12_32:
	; $78ea, 17 bytes (actor_script)
	as_set_target $2f00, $1300
	as_wait_move
	as_set_target $3500, $1300
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_12_33:
	; $78fb, 23 bytes (actor_script)
	as_set_target $2f00, $1f00
	as_wait_move
	as_set_target $3900, $1f00
	as_wait_move
	as_set_target $3900, $1b00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_34:
	; $7912, 23 bytes (actor_script)
	as_set_target $2f00, $1f00
	as_wait_move
	as_set_target $3900, $1f00
	as_wait_move
	as_set_target $3900, $1d00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_35:
	; $7929, 23 bytes (actor_script)
	as_set_target $3900, $0f00
	as_wait_move
	as_set_target $3b00, $1300
	as_wait_move
	as_set_target $3900, $1d00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_36:
	; $7940, 19 bytes (actor_script)
	as_wait $10
	as_set_target $3b00, $1300
	as_wait_move
	as_set_target $3900, $1b00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_37:
	; $7953, 11 bytes (actor_script)
	as_set_target $2b00, $1d00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_12_38:
	; $795e, 17 bytes (actor_script)
	as_set_target $2b00, $1100
	as_wait_move
	as_set_target $2b00, $1b00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_12_39:
	; $796f, 17 bytes (actor_script)
	as_set_target $2b00, $1300
	as_wait_move
	as_set_target $2500, $1300
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_12_40:
	; $7980, 17 bytes (actor_script)
	as_set_target $2b00, $0f00
	as_wait_move
	as_set_target $2300, $0f00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_12_41:
	; $7991, 17 bytes (actor_script)
	as_set_target $2b00, $0f00
	as_wait_move
	as_set_target $2d00, $0f00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_12_42:
	; $79a2, 65 bytes (actor_script)
	as_set_target $2b00, $1100
	as_wait_move
	as_set_target $2d00, $1100
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING_LOOP
	as_halt
	as_set_target $1900, $0f00
	as_wait_move
	as_set_target $1900, $0d00
	as_wait_move
	as_set_target $1b00, $0d00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
	as_set_target $1900, $0f00
	as_wait_move
	as_set_target $1900, $0d00
	as_wait_move
	as_set_target $1b00, $0d00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_43:
	; $79e3, 7 bytes (actor_script)
	as_set_field ACTORF_HEADING, FACE_UP
	as_anim ANIM_SWING_LOOP
	as_halt
ActorScript_12_44:
	; $79ea, 7 bytes (actor_script)
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_anim ANIM_SWING_LOOP
	as_halt
ActorScript_12_45:
	; $79f1, 11 bytes (actor_script)
	as_set_target $0900, $0900
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_12_46:
	; $79fc, 11 bytes (actor_script)
	as_set_target $0b00, $0d00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_12_47:
	; $7a07, 29 bytes (actor_script)
	as_set_target $0700, $0900
	as_wait_move
	as_set_target $0500, $0900
	as_wait_move
	as_set_target $0500, $1900
	as_wait_move
	as_set_target $0b00, $1900
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_12_48:
	; $7a24, 29 bytes (actor_script)
	as_set_target $0700, $0900
	as_wait_move
	as_set_target $0500, $0900
	as_wait_move
	as_set_target $0500, $1500
	as_wait_move
	as_set_target $0900, $1500
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_12_49:
	; $7a41, 25 bytes (actor_script)
	as_anim ANIM_BOUNCE
	as_set_target $0f00, $1500
	as_wait_move
	as_set_target $0f00, $0900
	as_wait_move
	as_set_target $0900, $0900
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_12_50:
	; $7a5a, 11 bytes (actor_script)
	as_set_target $0b00, $1900
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
