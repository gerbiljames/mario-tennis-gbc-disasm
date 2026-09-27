ResumeSeniorOpponentScripts:
	ld a, [wMapSceneStage2] ; $6a41
	sub SENIORCOURTSTAGE_SINGLES_RANK4 ; $6a44
	add a ; $6a46
	ld_hl_indexed ResumeSeniorOpponentScriptsPtrs ; $6a47
	ld a, [hl+] ; $6a4e
	ld h, [hl] ; $6a4f
	ld l, a ; $6a50
	call JumpToHL ; $6a51
	ret ; $6a54
ResumeSeniorOpponentScriptsPtrs:
	; $6a55, 14 bytes (records:2)
	dw ResumeSeniorSinglesRank4Opponents ; record 0
	dw ResumeSeniorSinglesRank3Opponents ; record 1
	dw ResumeSeniorSinglesRank2Opponents ; record 2
	dw ResumeSeniorSinglesRank1Opponents ; record 3
	dw ResumeSeniorDoublesRank3Opponents ; record 4
	dw ResumeSeniorDoublesRank2Opponents ; record 5
	dw ResumeSeniorDoublesRank1Opponents ; record 6
ResumeSeniorDoublesRank3Opponents:
	script_set_actor_script $09, ActorScript_12_23 ; $6a63
	script_set_actor_script $08, ActorScript_12_27 ; $6a6e
	ret ; $6a79
ResumeSeniorDoublesRank2Opponents:
	script_set_actor_script $07, ActorScript_12_33 ; $6a7a
	script_set_actor_script $06, ActorScript_12_34 ; $6a85
	ret ; $6a90
ResumeSeniorDoublesRank1Opponents:
	script_set_actor_script $05, ActorScript_12_41 ; $6a91
	script_set_actor_script $04, ActorScript_12_42 ; $6a9c
	script_wait_actor_script $05 ; $6aa7
	script_set_actor_script $05, ActorScript_12_57 ; $6aac
	ret ; $6ab7
ResumeSeniorSinglesRank4Opponents:
	script_set_actor_script $07, ActorScript_12_02 ; $6ab8
	ret ; $6ac3
ResumeSeniorSinglesRank3Opponents:
	script_set_actor_script $06, ActorScript_12_06 ; $6ac4
	ret ; $6acf
ResumeSeniorSinglesRank2Opponents:
	script_set_actor_script $05, ActorScript_12_09 ; $6ad0
	ret ; $6adb
ResumeSeniorSinglesRank1Opponents:
	script_set_actor_script $04, ActorScript_12_12 ; $6adc
	ret ; $6ae7
SeniorSinglesMatchConfirm:
	script_set_text Text_34_68 ; $6ae8
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_4 ; $6aee
	jr z, .prompt ; $6af1
	farcall AdvanceDialogueTextCursor ; $6af3
.prompt:
	ld a, $03 ; $6af6
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6af8
	farcall RunDialogueYesNoPrompt ; $6afb
	farcall ScriptCloseDialogueWindow ; $6afe
	script_wait_frames $05 ; $6b01
	and a ; $6b08
	jp nz, .done ; $6b09
	script_set_anim ACTOR_SENIOR_COURT_EMILY, $03 ; $6b0c
	script_wait_idle ACTOR_SENIOR_COURT_EMILY ; $6b13
.declined:
	script_set_anim ACTOR_SENIOR_COURT_EMILY, $03 ; $6b18
	script_wait_idle ACTOR_SENIOR_COURT_EMILY ; $6b1f
	script_set_text Text_34_70 ; $6b24
	script_speak ACTOR_SENIOR_COURT_EMILY ; $6b2a
	call StartSeniorRankingMatch ; $6b2f
	farcall EndCutsceneScriptMode ; $6b32
	ret ; $6b35
.accepted:
	script_set_text Text_34_72 ; $6b36
	test_flag FLAG_WON_SENIOR_SINGLES_RANK_4 ; $6b3c
	jr z, .startMatch ; $6b3f
	farcall AdvanceDialogueTextCursor ; $6b41
.startMatch:
	script_speak ACTOR_SENIOR_COURT_EMILY ; $6b44
	call ResumeSeniorOpponentScripts ; $6b49
	script_wait_frames $1e ; $6b4c
	farcall EndCutsceneScriptMode ; $6b53
	ret ; $6b56
.done:
	script_set_text Text_34_71 ; $6b57
	ld a, $03 ; $6b5d
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6b5f
	farcall RunDialogueYesNoPrompt ; $6b62
	farcall ScriptCloseDialogueWindow ; $6b65
	script_wait_frames $05 ; $6b68
	and a ; $6b6f
	jr z, .accepted ; $6b70
	jp .declined ; $6b72
	ret ; $6b75
SeniorDoublesMatchConfirm:
	script_set_text Text_34_116 ; $6b76
	test_flag FLAG_WON_SENIOR_DOUBLES_RANK_2 ; $6b7c
	jr z, .prompt ; $6b7f
	farcall AdvanceDialogueTextCursor ; $6b81
.prompt:
	ld a, $03 ; $6b84
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6b86
	farcall RunDialogueYesNoPrompt ; $6b89
	farcall ScriptCloseDialogueWindow ; $6b8c
	script_wait_frames $05 ; $6b8f
	and a ; $6b96
	jp nz, .done ; $6b97
	script_set_anim ACTOR_SENIOR_COURT_EMILY, $03 ; $6b9a
	script_wait_idle ACTOR_SENIOR_COURT_EMILY ; $6ba1
	script_set_anim ACTOR_SENIOR_COURT_EMILY, $03 ; $6ba6
	script_wait_idle ACTOR_SENIOR_COURT_EMILY ; $6bad
	script_set_text Text_34_118 ; $6bb2
	script_speak ACTOR_SENIOR_COURT_EMILY ; $6bb8
.declined:
	call StartSeniorRankingMatch ; $6bbd
	farcall EndCutsceneScriptMode ; $6bc0
	ret ; $6bc3
.accepted:
	script_speak ACTOR_SENIOR_COURT_EMILY ; $6bc4
	call ResumeSeniorOpponentScripts ; $6bc9
	script_wait_frames $1e ; $6bcc
	script_get_actor_state ACTOR_PARTNER ; $6bd3
	ld c, l ; $6bd8
	ld b, h ; $6bd9
	ld de, wActors ; $6bda
	farcall AttachActorStepMover ; $6bdd
	farcall EndCutsceneScriptMode ; $6be0
	ret ; $6be3
.done:
	script_set_text Text_34_119 ; $6be4
	ld a, $03 ; $6bea
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6bec
	farcall RunDialogueYesNoPrompt ; $6bef
	farcall ScriptCloseDialogueWindow ; $6bf2
	script_wait_frames $05 ; $6bf5
	and a ; $6bfc
	jr z, .accepted ; $6bfd
	script_set_text Text_34_121 ; $6bff
	script_speak ACTOR_SENIOR_COURT_EMILY ; $6c05
	jp .declined ; $6c0a
ActorScript_12_00:
	; $6c0d, 11 bytes (actor_script)
	as_set_target $2b00, $1b00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_12_01:
	; $6c18, 17 bytes (actor_script)
	as_set_target $2b00, $0f00
	as_wait_move
	as_set_target $2300, $0f00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_12_02:
	; $6c29, 17 bytes (actor_script)
	as_set_target $2b00, $0f00
	as_wait_move
	as_set_target $2b00, $1100
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_03:
	; $6c3a, 23 bytes (actor_script)
	as_set_target $1900, $0f00
	as_wait_move
	as_set_target $1900, $0d00
	as_wait_move
	as_set_target $1b00, $0d00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_04:
	; $6c51, 17 bytes (actor_script)
	as_set_target $2f00, $1300
	as_wait_move
	as_set_target $2f00, $1b00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_05:
	; $6c62, 17 bytes (actor_script)
	as_set_target $2f00, $0f00
	as_wait_move
	as_set_target $3300, $0f00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_12_06:
	; $6c73, 17 bytes (actor_script)
	as_set_target $2f00, $0f00
	as_wait_move
	as_set_target $2f00, $1300
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_12_07:
	; $6c84, 17 bytes (actor_script)
	as_set_target $2d00, $0f00
	as_wait_move
	as_set_target $2d00, $1300
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_12_08:
	; $6c95, 23 bytes (actor_script)
	as_set_target $3900, $1f00
	as_wait_move
	as_set_target $2f00, $1f00
	as_wait_move
	as_set_target $2f00, $1b00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_09:
	; $6cac, 23 bytes (actor_script)
	as_set_target $2f00, $1f00
	as_wait_move
	as_set_target $3900, $1f00
	as_wait_move
	as_set_target $3900, $1d00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_10:
	; $6cc3, 23 bytes (actor_script)
	as_set_target $3900, $0f00
	as_wait_move
	as_set_target $3b00, $1700
	as_wait_move
	as_set_target $3900, $1d00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_11:
	; $6cda, 11 bytes (actor_script)
	as_set_target $2b00, $1b00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
ActorScript_12_12:
	; $6ce5, 7 bytes (actor_script)
	as_set_target $2900, $1b00
	as_wait_move
	as_halt
ActorScript_12_13:
	; $6cec, 17 bytes (actor_script)
	as_set_target $2d00, $1f00
	as_wait_move
	as_set_target $2500, $1f00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_12_14:
	; $6cfd, 17 bytes (actor_script)
	as_set_target $2d00, $1f00
	as_wait_move
	as_set_target $3700, $1f00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_12_15:
	; $6d0e, 17 bytes (actor_script)
	as_set_target $2900, $1f00
	as_wait_move
	as_set_target $2300, $1c00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_12_16:
	; $6d1f, 17 bytes (actor_script)
	as_set_target $2d00, $1f00
	as_wait_move
	as_set_target $3300, $1b00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_UP
	as_halt
ActorScript_12_17:
	; $6d30, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $2900, $1300
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_18:
	; $6d3f, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $2900, $1900
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_19:
	; $6d4e, 15 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $3900, $1300
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
ActorScript_12_20:
	; $6d5d, 45 bytes (actor_script)
	as_anim $01
	as_wait $0a
	as_set_target $3900, $1900
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_LEFT
	as_halt
	as_anim $01
	as_wait $0a
	as_set_target $0500, $0b00
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
	as_anim $01
	as_wait $0a
	as_set_target $0500, $1300
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_RIGHT
	as_halt
SeniorCourtReloadIntoVictoryScene:
	ld a, STORYLOC_SENIOR_CLASS_COURT ; $6d8a
	ld [wStoryModeCurrentLocation], a ; $6d8c
	ld a, $0d ; $6d8f
	ld [wStoryModeEntryPoint], a ; $6d91
	ld a, $ff ; $6d94
	ld [wUnusedExitTriggerIdMirror], a ; $6d96
	ld [wStoryModeExitTriggerRequest], a ; $6d99
	farcall StubNop_1e ; $6d9c
	ret ; $6d9f
SeniorCourtPostMatchReturn:
	wram_bank WRAM_ACTORS ; $6da0
	ld a, [wMatchExitRequest] ; $6da6
	cp $01 ; $6da9
	jr z, .eq01 ; $6dab
	ld a, [wMatchWinLoseFlag] ; $6dad
	cp WINLOSE_WIN ; $6db0
	jp z, SeniorMatchVictorySceneDispatch ; $6db2
.eq01:
	script_player_speed $0040 ; $6db5
	script_move_player $2d00, $1b00 ; $6dbb
	script_set_position ACTOR_PLAYER, $2d00, $1b00 ; $6dc5
	script_face ACTOR_PLAYER, FACE_UP ; $6dd0
	script_set_position ACTOR_PARTNER, $2d00, $1d00 ; $6dd7
	script_face ACTOR_PARTNER, FACE_UP ; $6de2
	farcall WaitPlayerMoveDone ; $6de9
	ret ; $6dec
SeniorMatchVictorySceneDispatch:
	xor a ; $6ded
	ld [wStoryModeShowLocationName], a ; $6dee
	script_null_script ACTOR_PLAYER_SHADOW ; $6df1
	ld a, [wMapSceneStage2] ; $6df6
	sub SENIORCOURTSTAGE_SINGLES_RANK4 ; $6df9
	add a ; $6dfb
	ld_hl_indexed SeniorMatchVictorySceneDispatchPtrs ; $6dfc
	ld a, [hl+] ; $6e03
	ld h, [hl] ; $6e04
	ld l, a ; $6e05
	call JumpToHL ; $6e06
	call ComputeSeniorCourtStage ; $6e09
	ret ; $6e0c
SeniorMatchVictorySceneDispatchPtrs:
	; $6e0d, 18 bytes (records:2)
	dw SeniorSinglesRank4And3Victory ; record 0
	dw SeniorSinglesRank4And3Victory ; record 1
	dw SeniorSinglesRank2Victory ; record 2
	dw SeniorSinglesRank1Victory ; record 3
	dw SeniorSharedVictoryScene ; record 4
	dw SeniorDoublesRank2Victory ; record 5
	dw SeniorDoublesRank1Victory ; record 6
	dw SeniorSharedVictoryScene ; record 7
	dw IslandOpenDoublesVictory ; record 8
SeniorDoublesRank2Victory:
	script_null_script ACTOR_PARTNER ; $6e1f
	script_null_script $08 ; $6e24
	script_face $03, FACE_LEFT ; $6e29
	script_set_position $08, $2500, $1300 ; $6e30
	script_face $08, FACE_DOWN ; $6e3b
	script_set_position $09, $2300, $0f00 ; $6e42
	script_face $09, FACE_DOWN ; $6e4d
	script_set_text Text_34_128 ; $6e54
	script_set_position ACTOR_PLAYER, $2500, $1b00 ; $6e5a
	script_set_position ACTOR_PARTNER, $2300, $1b00 ; $6e65
	script_face ACTOR_PLAYER, FACE_UP ; $6e70
	script_face ACTOR_PARTNER, FACE_UP ; $6e77
	script_player_speed $0040 ; $6e7e
	script_move_player $2600, $1700 ; $6e84
	farcall WaitPlayerMoveDone ; $6e8e
	script_fade_in $08 ; $6e91
	call WaitFadeEnd ; $6e96
	script_wait_frames $3c ; $6e99
	script_move_target $09, $2300, $1300 ; $6ea0
	script_wait_move $09 ; $6eab
	script_face_pair $09, $08 ; $6eb0
	script_wait_frames $14 ; $6eb8
	script_set_position $11, $2400, $1180 ; $6ebf
	sound SFX_APPEAR2 ; $6eca
	script_wait_frames $1e ; $6ecc
	script_set_anim $08, $04 ; $6ed3
	script_wait_idle $08 ; $6eda
	script_set_position $11, $3f00, $3f00 ; $6edf
	script_jump_velocity $03, $ff80 ; $6eea
	ld a, $03 ; $6ef2
	farcall ScriptWaitActorJumpDone ; $6ef4
	script_speak $03 ; $6ef7
	script_set_actor_script $08, ActorScript_12_28 ; $6efc
	script_set_actor_script $09, ActorScript_12_24 ; $6f07
	script_wait_frames $3c ; $6f12
	script_move_target $03, $2d00, $1900 ; $6f19
	script_move_player $2d00, $1b00 ; $6f24
	script_move_target ACTOR_PLAYER, $2d00, $1b00 ; $6f2e
	script_move_target ACTOR_PARTNER, $2d00, $1d00 ; $6f39
	script_wait_frames $3c ; $6f44
	script_face $03, FACE_DOWN ; $6f4b
	script_face ACTOR_PLAYER, FACE_DOWN ; $6f52
	script_get_actor_state ACTOR_PARTNER ; $6f59
	ld c, l ; $6f5e
	ld b, h ; $6f5f
	ld de, wActors ; $6f60
	farcall AttachActorStepMover ; $6f63
	farcall EndCutsceneScriptMode ; $6f66
	ret ; $6f69
SeniorDoublesRank1Victory:
	script_null_script ACTOR_PARTNER ; $6f6a
	script_face $03, FACE_RIGHT ; $6f6f
	script_set_position $07, $3300, $1100 ; $6f76
	script_face $07, FACE_DOWN ; $6f81
	script_set_position $06, $3500, $1300 ; $6f88
	script_face $06, FACE_DOWN ; $6f93
	script_set_position ACTOR_PLAYER, $3300, $1b00 ; $6f9a
	script_set_position ACTOR_PARTNER, $3500, $1b00 ; $6fa5
	script_face ACTOR_PLAYER, FACE_UP ; $6fb0
	script_face ACTOR_PARTNER, FACE_UP ; $6fb7
	call FadeInSeniorCourtNearPairB ; $6fbe
	script_set_text Text_34_129 ; $6fc1
	script_wait_frames $28 ; $6fc7
	script_set_anim $07, $02 ; $6fce
	script_wait_idle $07 ; $6fd5
	script_wait_frames $14 ; $6fda
	script_jump_velocity $03, $ff80 ; $6fe1
	ld a, $03 ; $6fe9
	farcall ScriptWaitActorJumpDone ; $6feb
	script_jump_velocity $03, $ff80 ; $6fee
	ld a, $03 ; $6ff6
	farcall ScriptWaitActorJumpDone ; $6ff8
	script_speak $03 ; $6ffb
	script_wait_frames $3c ; $7000
	script_move_target $03, $2d00, $1900 ; $7007
	script_move_player $2d00, $1b00 ; $7012
	script_move_target ACTOR_PLAYER, $2d00, $1b00 ; $701c
	script_move_target ACTOR_PARTNER, $2d00, $1d00 ; $7027
	script_set_actor_script $07, ActorScript_12_36 ; $7032
	script_set_actor_script $06, ActorScript_12_35 ; $703d
	call StartSeniorCourtPairBRally ; $7048
	script_face $03, FACE_DOWN ; $704b
	script_face ACTOR_PLAYER, FACE_DOWN ; $7052
	script_face ACTOR_PARTNER, FACE_DOWN ; $7059
	script_get_actor_state ACTOR_PARTNER ; $7060
	ld c, l ; $7065
	ld b, h ; $7066
	ld de, wActors ; $7067
	farcall AttachActorStepMover ; $706a
	farcall EndCutsceneScriptMode ; $706d
	ret ; $7070
