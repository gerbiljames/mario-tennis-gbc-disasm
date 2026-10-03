NetChallengerResultScene:
	xor a ; $5d74
	ld [wStoryModeShowLocationName], a ; $5d75
	ld a, $11 ; $5d78
	ld [wMapSceneStage2], a ; $5d7a
	script_set_position ACTOR_PLAYER, 40.0, 42.0 ; $5d7d
	script_face ACTOR_PLAYER, FACE_UP ; $5d88
	ld a, [wMapSceneStage2] ; $5d8f
	ld bc, $2800 ; $5d92
	ld de, $2500 ; $5d95
	farcall ScriptSetActorPosition ; $5d98
	ld a, [wMapSceneStage2] ; $5d9b
	ld b, $40 ; $5d9e
	farcall SetActorFacing ; $5da0
	script_null_script ACTOR_PARTNER ; $5da3
	script_set_position ACTOR_PARTNER, 45.0, 45.0 ; $5da8
	script_face ACTOR_PARTNER, FACE_LEFT ; $5db3
	script_player_speed $00f0 ; $5dba
	script_move_player 40.0, 41.0 ; $5dc0
	farcall WaitPlayerMoveDone ; $5dca
	script_fade_in $08 ; $5dcd
	call WaitFadeEnd ; $5dd2
	ld a, [wPointWinLoseFlag] ; $5dd5
	inc a ; $5dd8
	cp $01 ; $5dd9
	jr nz, .dispatch ; $5ddb
	ld hl, wUnusedChallengerLoseTextId ; $5ddd
	ld de, Text_6e_74 ; $5de0
	ld a, e ; $5de3
	ld [hl+], a ; $5de4
	ld [hl], d ; $5de5
	ld a, [wPointWinLoseFlag] ; $5de6
	inc a ; $5de9
.dispatch:
	ld a, a ; $5dea
	rst Rst00 ; $5deb
	dw ServiceMatch3ResultScene.finish ; $5dec jumptable
	dw ServiceMatch3ResultScene.lose ; $5dee jumptable
	dw ServiceMatch3ResultScene.draw ; $5df0 jumptable
	ret ; $5df2
StrokeChallengerResultScene:
	xor a ; $5df3
	ld [wStoryModeShowLocationName], a ; $5df4
	ld a, $0c ; $5df7
	ld [wMapSceneStage2], a ; $5df9
	script_set_position ACTOR_PLAYER, 24.0, 42.0 ; $5dfc
	script_face ACTOR_PLAYER, FACE_UP ; $5e07
	ld a, [wMapSceneStage2] ; $5e0e
	ld bc, $1800 ; $5e11
	ld de, $2500 ; $5e14
	farcall ScriptSetActorPosition ; $5e17
	ld a, [wMapSceneStage2] ; $5e1a
	ld b, $40 ; $5e1d
	farcall SetActorFacing ; $5e1f
	script_null_script ACTOR_PARTNER ; $5e22
	script_set_position ACTOR_PARTNER, 19.0, 45.0 ; $5e27
	script_face ACTOR_PARTNER, FACE_RIGHT ; $5e32
	script_player_speed $00f0 ; $5e39
	script_move_player 24.0, 40.0 ; $5e3f
	farcall WaitPlayerMoveDone ; $5e49
	script_fade_in $08 ; $5e4c
	call WaitFadeEnd ; $5e51
	ld a, [wPointWinLoseFlag] ; $5e54
	inc a ; $5e57
	cp $01 ; $5e58
	jr nz, .dispatch ; $5e5a
	ld hl, wUnusedChallengerLoseTextId ; $5e5c
	ld de, Text_6e_120 ; $5e5f
	ld a, e ; $5e62
	ld [hl+], a ; $5e63
	ld [hl], d ; $5e64
	ld a, [wPointWinLoseFlag] ; $5e65
	inc a ; $5e68
.dispatch:
	ld a, a ; $5e69
	rst Rst00 ; $5e6a
	dw ServiceMatch3ResultScene.finish ; $5e6b jumptable
	dw ServiceMatch3ResultScene.lose ; $5e6d jumptable
	dw ServiceMatch3ResultScene.draw ; $5e6f jumptable
	dw StrokeChallengerResultScene.jumpForJoy ; $5e71 jumptable
	ret ; $5e73
.jumpForJoy:
	script_jump_velocity ACTOR_PLAYER, $ff40 ; $5e74
	ld a, $00 ; $5e7c
	farcall ScriptWaitActorJumpDone ; $5e7e
	jp ServiceMatch3ResultScene.finish ; $5e81
	ret ; $5e84
ServiceMatch1ResultScene:
	ld hl, wChallengerFollowupTextId ; $5e85
	ld de, Text_6e_32 ; $5e88
	ld a, e ; $5e8b
	ld [hl+], a ; $5e8c
	ld [hl], d ; $5e8d
	ld hl, wChallengerLoseTextId ; $5e8e
	ld de, Text_6e_29 ; $5e91
	ld a, e ; $5e94
	ld [hl+], a ; $5e95
	ld [hl], d ; $5e96
	ld hl, wChallengerWinTextId ; $5e97
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $5e9a
	jr z, .celebrateWait ; $5e9d
	ld de, $2023 ; $5e9f
	jr .celebrateLoop ; $5ea2
.celebrateWait:
	ld de, $2022 ; $5ea4
.celebrateLoop:
	ld a, e ; $5ea7
	ld [hl+], a ; $5ea8
	ld [hl], d ; $5ea9
	ld hl, wChallengerDrawTextId ; $5eaa
	ld de, Text_6e_36 ; $5ead
	ld a, e ; $5eb0
	ld [hl+], a ; $5eb1
	ld [hl], d ; $5eb2
	call ServeChallengerResultScene ; $5eb3
	ret ; $5eb6
ServiceMatch2ResultScene:
	ld hl, wChallengerFollowupTextId ; $5eb7
	ld de, Text_6e_32 ; $5eba
	ld a, e ; $5ebd
	ld [hl+], a ; $5ebe
	ld [hl], d ; $5ebf
	ld hl, wChallengerLoseTextId ; $5ec0
	ld de, Text_6e_29 ; $5ec3
	ld a, e ; $5ec6
	ld [hl+], a ; $5ec7
	ld [hl], d ; $5ec8
	ld hl, wChallengerWinTextId ; $5ec9
	ld de, Text_6e_49 ; $5ecc
	ld a, e ; $5ecf
	ld [hl+], a ; $5ed0
	ld [hl], d ; $5ed1
	ld hl, wChallengerDrawTextId ; $5ed2
	ld de, Text_6e_50 ; $5ed5
	ld a, e ; $5ed8
	ld [hl+], a ; $5ed9
	ld [hl], d ; $5eda
	call ServeChallengerResultScene ; $5edb
	ret ; $5ede
ServiceMatch3ResultScene:
	ld hl, wChallengerFollowupTextId ; $5edf
	ld de, Text_6e_32 ; $5ee2
	ld a, e ; $5ee5
	ld [hl+], a ; $5ee6
	ld [hl], d ; $5ee7
	ld hl, wChallengerLoseTextId ; $5ee8
	ld de, Text_6e_29 ; $5eeb
	ld a, e ; $5eee
	ld [hl+], a ; $5eef
	ld [hl], d ; $5ef0
	ld hl, wChallengerWinTextId ; $5ef1
	ld de, Text_6e_61 ; $5ef4
	ld a, e ; $5ef7
	ld [hl+], a ; $5ef8
	ld [hl], d ; $5ef9
	ld hl, wChallengerDrawTextId ; $5efa
	ld de, Text_6e_62 ; $5efd
	ld a, e ; $5f00
	ld [hl+], a ; $5f01
	ld [hl], d ; $5f02
	call ServeChallengerResultScene ; $5f03
	ret ; $5f06
.lose:
	ld hl, wChallengerLoseTextId ; $5f07
	ld a, [hl+] ; $5f0a
	ld h, [hl] ; $5f0b
	ld l, a ; $5f0c
	farcall InitDialogueTextCursor ; $5f0d
	script_speak_restore [wMapSceneStage2] ; $5f10
	farcall RunDialogueYesNoPrompt ; $5f16
	farcall ScriptCloseDialogueWindow ; $5f19
	script_wait_frames 5 ; $5f1c
	and a ; $5f23
	jr nz, .loseSpeak ; $5f24
	ld a, [wMapSceneStage2] ; $5f26
	farcall ScriptShowSpeakerDialogue ; $5f29
	ld a, STORYLOC_TRAINING_COURT ; $5f2c
	ld [wStoryModeCurrentLocation], a ; $5f2e
	ld a, $0a ; $5f31
	ld [wStoryModeEntryPoint], a ; $5f33
	ld a, $ff ; $5f36
	ld [wUnusedExitTriggerIdMirror], a ; $5f38
	ld [wStoryModeExitTriggerRequest], a ; $5f3b
	ld a, [wCurrentMinigameStoryMatch + 1] ; $5f3e
	farcall RunTrainingDrillByID ; $5f41
	farcall EndCutsceneScriptMode ; $5f44
	ret ; $5f47
.loseSpeak:
	farcall AdvanceDialogueTextCursor ; $5f48
	ld a, [wMapSceneStage2] ; $5f4b
	farcall ScriptShowSpeakerDialogue ; $5f4e
	call WalkChallengerOntoCourt ; $5f51
	farcall EndCutsceneScriptMode ; $5f54
	ret ; $5f57
.finish:
	ld hl, wChallengerWinTextId ; $5f58
	ld a, [hl+] ; $5f5b
	ld h, [hl] ; $5f5c
	ld l, a ; $5f5d
	farcall InitDialogueTextCursor ; $5f5e
	script_speak_restore [wMapSceneStage2] ; $5f61
	farcall RunDialogueYesNoPrompt ; $5f67
	farcall ScriptCloseDialogueWindow ; $5f6a
	script_wait_frames 5 ; $5f6d
	and a ; $5f74
	jr nz, .finishDoubles ; $5f75
	ld hl, wChallengerFollowupTextId ; $5f77
	ld a, [hl+] ; $5f7a
	ld h, [hl] ; $5f7b
	ld l, a ; $5f7c
	farcall InitDialogueTextCursor ; $5f7d
	ld a, [wMapSceneStage2] ; $5f80
	farcall ScriptShowSpeakerDialogue ; $5f83
	ld a, STORYLOC_TRAINING_COURT ; $5f86
	ld [wStoryModeCurrentLocation], a ; $5f88
	ld a, $0a ; $5f8b
	ld [wStoryModeEntryPoint], a ; $5f8d
	ld a, $ff ; $5f90
	ld [wUnusedExitTriggerIdMirror], a ; $5f92
	ld [wStoryModeExitTriggerRequest], a ; $5f95
	ld a, [wCurrentMinigameStoryMatch + 1] ; $5f98
	farcall RunTrainingDrillByID ; $5f9b
	farcall EndCutsceneScriptMode ; $5f9e
	ret ; $5fa1
.finishDoubles:
	ld hl, wChallengerFollowupTextId ; $5fa2
	ld a, [hl+] ; $5fa5
	ld h, [hl] ; $5fa6
	ld l, a ; $5fa7
	farcall InitDialogueTextCursor ; $5fa8
	farcall AdvanceDialogueTextCursor ; $5fab
	ld a, [wMapSceneStage2] ; $5fae
	farcall ScriptShowSpeakerDialogue ; $5fb1
	call WalkChallengerOntoCourt ; $5fb4
	farcall EndCutsceneScriptMode ; $5fb7
	ret ; $5fba
	call WalkChallengerOntoCourt ; $5fbb
	farcall EndCutsceneScriptMode ; $5fbe
	ret ; $5fc1
.draw:
	ld a, [wMapSceneStage2] ; $5fc2
	ld d, ANIM_BOUNCE ; $5fc5
	farcall ScriptSetActorAnimation ; $5fc7
	ld a, [wMapSceneStage2] ; $5fca
	farcall ScriptWaitActorIdle ; $5fcd
	ld hl, wChallengerDrawTextId ; $5fd0
	ld a, [hl+] ; $5fd3
	ld h, [hl] ; $5fd4
	ld l, a ; $5fd5
	farcall InitDialogueTextCursor ; $5fd6
	ld a, [wMapSceneStage2] ; $5fd9
	farcall ScriptShowSpeakerDialogue ; $5fdc
	ld a, [wMapSceneStage2] ; $5fdf
	ld b, $01 ; $5fe2
	farcall ScriptSetActorFacingLock ; $5fe4
	ld a, [wMapSceneStage2] ; $5fe7
	ld b, $c0 ; $5fea
	ld de, $0100 ; $5fec
	farcall MoveActorByAngle ; $5fef
	ld a, [wMapSceneStage2] ; $5ff2
	farcall ScriptWaitActorMoveDone ; $5ff5
	script_wait_frames 40 ; $5ff8
	ld a, [wMapSceneStage2] ; $5fff
	ld b, $c0 ; $6002
	ld de, $0100 ; $6004
	farcall MoveActorByAngle ; $6007
	ld a, [wMapSceneStage2] ; $600a
	farcall ScriptWaitActorMoveDone ; $600d
	ld a, [wMapSceneStage2] ; $6010
	ld d, ANIM_BOUNCE ; $6013
	farcall ScriptSetActorAnimation ; $6015
	ld a, [wMapSceneStage2] ; $6018
	farcall ScriptWaitActorIdle ; $601b
	ld a, [wMapSceneStage2] ; $601e
	farcall ScriptShowSpeakerDialogue ; $6021
	ld a, [wMapSceneStage2] ; $6024
	ld b, $00 ; $6027
	farcall ScriptSetActorFacingLock ; $6029
	call WalkChallengerAwayDefeated ; $602c
	ld a, [wMapSceneStage2] ; $602f
	ld bc, $3f00 ; $6032
	ld de, $3f00 ; $6035
	farcall ScriptSetActorPosition ; $6038
	call MovePlayerToLessonCourtSpot ; $603b
	farcall EndCutsceneScriptMode ; $603e
	ret ; $6041
WalkChallengerAwayDefeated:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $6042
	sub $0a ; $6045
	jp nc, .done ; $6047
	ld a, [wCurrentMinigameStoryMatch + 1] ; $604a
	sub $04 ; $604d
	jp c, .serveChallenger ; $604f
	jp .netChallenger ; $6052
	ret ; $6055
.serveChallenger:
	ld a, [wMapSceneStage2] ; $6056
	ld bc, $0030 ; $6059
	farcall ScriptSetActorMoveSpeed ; $605c
	ld a, [wMapSceneStage2] ; $605f
	farcall GetActorStateAddr ; $6062
	ld a, $04 ; $6065
	ld e, l ; $6067
	ld d, h ; $6068
	ld hl, $0018 ; $6069
	add hl, de ; $606c
	ld [hl], a ; $606d
	ld a, [wMapSceneStage2] ; $606e
	ld bc, $1f00 ; $6071
	ld de, $0b00 ; $6074
	farcall ScriptSetActorMoveTarget ; $6077
	ld a, [wMapSceneStage2] ; $607a
	farcall ScriptWaitActorMoveDone ; $607d
	ld a, [wMapSceneStage2] ; $6080
	ld bc, $1f00 ; $6083
	ld de, $1100 ; $6086
	farcall ScriptSetActorMoveTarget ; $6089
	ld a, [wMapSceneStage2] ; $608c
	farcall ScriptWaitActorMoveDone ; $608f
	script_face ACTOR_PLAYER, FACE_DOWN ; $6092
	ld a, [wMapSceneStage2] ; $6099
	ld bc, $1f00 ; $609c
	ld de, $1f00 ; $609f
	farcall ScriptSetActorMoveTarget ; $60a2
	ld a, [wMapSceneStage2] ; $60a5
	farcall ScriptWaitActorMoveDone ; $60a8
	set_flag FLAG_SERVE_CHALLENGER_DEFEATED ; $60ab
	ret ; $60ae
.netChallenger:
	ld a, [wMapSceneStage2] ; $60af
	ld bc, $0030 ; $60b2
	farcall ScriptSetActorMoveSpeed ; $60b5
	ld a, [wMapSceneStage2] ; $60b8
	farcall GetActorStateAddr ; $60bb
	ld a, $04 ; $60be
	ld e, l ; $60c0
	ld d, h ; $60c1
	ld hl, $0018 ; $60c2
	add hl, de ; $60c5
	ld [hl], a ; $60c6
	ld a, [wMapSceneStage2] ; $60c7
	ld bc, $2100 ; $60ca
	ld de, $2500 ; $60cd
	farcall ScriptSetActorMoveTarget ; $60d0
	ld a, [wMapSceneStage2] ; $60d3
	farcall ScriptWaitActorMoveDone ; $60d6
	script_face ACTOR_PLAYER, FACE_DOWN ; $60d9
	ld a, [wMapSceneStage2] ; $60e0
	ld bc, $1f00 ; $60e3
	ld de, $3500 ; $60e6
	farcall ScriptSetActorMoveTarget ; $60e9
	ld a, [wMapSceneStage2] ; $60ec
	farcall ScriptWaitActorMoveDone ; $60ef
	set_flag FLAG_NET_CHALLENGER_DEFEATED ; $60f2
	ret ; $60f5
.done:
	ld a, [wMapSceneStage2] ; $60f6
	ld b, $c0 ; $60f9
	farcall SetActorFacing ; $60fb
	ld a, [wMapSceneStage2] ; $60fe
	ld d, ANIM_BOUNCE ; $6101
	farcall ScriptSetActorAnimation ; $6103
	ld a, [wMapSceneStage2] ; $6106
	farcall ScriptWaitActorIdle ; $6109
	ld a, [wMapSceneStage2] ; $610c
	ld d, ANIM_BOUNCE ; $610f
	farcall ScriptSetActorAnimation ; $6111
	ld a, [wMapSceneStage2] ; $6114
	farcall ScriptWaitActorIdle ; $6117
	ld a, [wMapSceneStage2] ; $611a
	farcall ScriptShowSpeakerDialogue ; $611d
	ld a, [wMapSceneStage2] ; $6120
	ld bc, $0030 ; $6123
	farcall ScriptSetActorMoveSpeed ; $6126
	ld a, [wMapSceneStage2] ; $6129
	farcall GetActorStateAddr ; $612c
	ld a, $04 ; $612f
	ld e, l ; $6131
	ld d, h ; $6132
	ld hl, $0018 ; $6133
	add hl, de ; $6136
	ld [hl], a ; $6137
	ld a, [wMapSceneStage2] ; $6138
	ld bc, $1f00 ; $613b
	ld de, $2500 ; $613e
	farcall ScriptSetActorMoveTarget ; $6141
	ld a, [wMapSceneStage2] ; $6144
	farcall ScriptWaitActorMoveDone ; $6147
	ld a, [wMapSceneStage2] ; $614a
	ld bc, $1f00 ; $614d
	ld de, $2900 ; $6150
	farcall ScriptSetActorMoveTarget ; $6153
	ld a, [wMapSceneStage2] ; $6156
	farcall ScriptWaitActorMoveDone ; $6159
	script_face ACTOR_PLAYER, FACE_DOWN ; $615c
	ld a, [wMapSceneStage2] ; $6163
	ld bc, $1f00 ; $6166
	ld de, $3500 ; $6169
	farcall ScriptSetActorMoveTarget ; $616c
	ld a, [wMapSceneStage2] ; $616f
	farcall ScriptWaitActorMoveDone ; $6172
	set_flag FLAG_STROKE_CHALLENGER_DEFEATED ; $6175
	ret ; $6178
WalkChallengerOntoCourt:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $6179
	sub $0a ; $617c
	jr nc, .northCourt ; $617e
	ld a, [wCurrentMinigameStoryMatch + 1] ; $6180
	sub $04 ; $6183
	jr c, .southCourt ; $6185
	jp .eastCourt ; $6187
	ret ; $618a
.northCourt:
	ld a, [wMapSceneStage2] ; $618b
	ld bc, $1300 ; $618e
	ld de, $2500 ; $6191
	farcall ScriptSetActorMoveTarget ; $6194
	ld a, [wMapSceneStage2] ; $6197
	farcall ScriptWaitActorMoveDone ; $619a
	ld a, [wMapSceneStage2] ; $619d
	ld bc, $1300 ; $61a0
	ld de, $2700 ; $61a3
	farcall ScriptSetActorMoveTarget ; $61a6
	script_move_target ACTOR_PLAYER, 19.0, 43.0 ; $61a9
	script_wait_move ACTOR_PLAYER ; $61b4
	script_get_actor_state ACTOR_PARTNER ; $61b9
	ld c, l ; $61be
	ld b, h ; $61bf
	ld de, wActors ; $61c0
	farcall AttachActorStepMover ; $61c3
	ld a, [wMapSceneStage2] ; $61c6
	farcall ScriptWaitActorMoveDone ; $61c9
	ld a, [wMapSceneStage2] ; $61cc
	ld b, $40 ; $61cf
	farcall SetActorFacing ; $61d1
	ret ; $61d4
.southCourt:
	ld a, [wMapSceneStage2] ; $61d5
	ld bc, $1300 ; $61d8
	ld de, $0b00 ; $61db
	farcall ScriptSetActorMoveTarget ; $61de
	script_wait_frames 30 ; $61e1
	script_move_target ACTOR_PLAYER, 19.0, 19.0 ; $61e8
	script_wait_move ACTOR_PLAYER ; $61f3
	script_get_actor_state ACTOR_PARTNER ; $61f8
	ld c, l ; $61fd
	ld b, h ; $61fe
	ld de, wActors ; $61ff
	farcall AttachActorStepMover ; $6202
	ld a, [wMapSceneStage2] ; $6205
	farcall ScriptWaitActorMoveDone ; $6208
	ld a, [wMapSceneStage2] ; $620b
	ld b, $00 ; $620e
	farcall SetActorFacing ; $6210
	ret ; $6213
.eastCourt:
	ld a, [wMapSceneStage2] ; $6214
	ld bc, $2d00 ; $6217
	ld de, $2100 ; $621a
	farcall ScriptSetActorMoveTarget ; $621d
	script_wait_frames 30 ; $6220
	script_move_target ACTOR_PLAYER, 45.0, 43.0 ; $6227
	script_wait_move ACTOR_PLAYER ; $6232
	script_get_actor_state ACTOR_PARTNER ; $6237
	ld c, l ; $623c
	ld b, h ; $623d
	ld de, wActors ; $623e
	farcall AttachActorStepMover ; $6241
	ld a, [wMapSceneStage2] ; $6244
	farcall ScriptWaitActorMoveDone ; $6247
	ld a, [wMapSceneStage2] ; $624a
	ld b, $00 ; $624d
	farcall SetActorFacing ; $624f
	ret ; $6252
