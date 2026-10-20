NetChallengerResultScene:
	xor a ; $5d74
	ld [wStoryModeShowLocationName], a ; $5d75
	ld a, $11 ; $5d78
	ld [wChallengerActor], a ; $5d7a
	script_set_position ACTOR_PLAYER, 40.0, 42.0 ; $5d7d
	script_face ACTOR_PLAYER, FACE_UP ; $5d88
	script_set_position [wChallengerActor], 40.0, 37.0 ; $5d8f
	script_face [wChallengerActor], FACE_DOWN ; $5d9b
	script_null_script ACTOR_PARTNER ; $5da3
	script_set_position ACTOR_PARTNER, 45.0, 45.0 ; $5da8
	script_face ACTOR_PARTNER, FACE_LEFT ; $5db3
	script_player_speed 7.5 ; $5dba
	script_move_player 40.0, 41.0 ; $5dc0
	farcall WaitPlayerMoveDone ; $5dca
	script_fade_in 8 ; $5dcd
	call WaitFadeEnd ; $5dd2
	ld a, [wPointWinLoseFlag] ; $5dd5
	inc a ; $5dd8
	cp WINLOSE_NONE + 1 ; $5dd9
	jr nz, .dispatch ; $5ddb
	ld hl, wUnusedChallengerTiedTextId ; $5ddd
	ld de, Text_BrianTiedKeepGoing ; $5de0
	ld a, e ; $5de3
	ld [hl+], a ; $5de4
	ld [hl], d ; $5de5
	ld a, [wPointWinLoseFlag] ; $5de6
	inc a ; $5de9
.dispatch:
	jumptable a ; $5dea
	dw ChallengerResultRivalWon ; $5dec jumptable
	dw ChallengerResultTied ; $5dee jumptable
	dw ChallengerResultRivalLost ; $5df0 jumptable
	ret ; $5df2
StrokeChallengerResultScene:
	xor a ; $5df3
	ld [wStoryModeShowLocationName], a ; $5df4
	ld a, $0c ; $5df7
	ld [wChallengerActor], a ; $5df9
	script_set_position ACTOR_PLAYER, 24.0, 42.0 ; $5dfc
	script_face ACTOR_PLAYER, FACE_UP ; $5e07
	script_set_position [wChallengerActor], 24.0, 37.0 ; $5e0e
	script_face [wChallengerActor], FACE_DOWN ; $5e1a
	script_null_script ACTOR_PARTNER ; $5e22
	script_set_position ACTOR_PARTNER, 19.0, 45.0 ; $5e27
	script_face ACTOR_PARTNER, FACE_RIGHT ; $5e32
	script_player_speed 7.5 ; $5e39
	script_move_player 24.0, 40.0 ; $5e3f
	farcall WaitPlayerMoveDone ; $5e49
	script_fade_in 8 ; $5e4c
	call WaitFadeEnd ; $5e51
	ld a, [wPointWinLoseFlag] ; $5e54
	inc a ; $5e57
	cp WINLOSE_NONE + 1 ; $5e58
	jr nz, .dispatch ; $5e5a
	ld hl, wUnusedChallengerTiedTextId ; $5e5c
	ld de, Text_AllieEvenKeepGoing ; $5e5f
	ld a, e ; $5e62
	ld [hl+], a ; $5e63
	ld [hl], d ; $5e64
	ld a, [wPointWinLoseFlag] ; $5e65
	inc a ; $5e68
.dispatch:
	jumptable a ; $5e69
	dw ChallengerResultRivalWon ; $5e6b jumptable
	dw ChallengerResultTied ; $5e6d jumptable
	dw ChallengerResultRivalLost ; $5e6f jumptable
	dw ChallengerResultJumpForJoy ; $5e71 jumptable
	ret ; $5e73
ChallengerResultJumpForJoy:
	script_jump_velocity ACTOR_PLAYER, -3.0 ; $5e74
	script_wait_jump ACTOR_PLAYER ; $5e7c
	jp ChallengerResultRivalWon ; $5e81
	ret ; $5e84
ServiceMatch1ResultScene:
	ld hl, wChallengerFollowupTextId ; $5e85
	ld de, Text_ServeRivalLetsGetGoing ; $5e88
	ld a, e ; $5e8b
	ld [hl+], a ; $5e8c
	ld [hl], d ; $5e8d
	ld hl, wChallengerTiedTextId ; $5e8e
	ld de, Text_ServeRivalTiedKeepGoing ; $5e91
	ld a, e ; $5e94
	ld [hl+], a ; $5e95
	ld [hl], d ; $5e96
	ld hl, wChallengerRivalWonTextId ; $5e97
	test_flag FLAG_WON_JUNIOR_SINGLES_RANK_1 ; $5e9a
	jr z, .stillJunior ; $5e9d
	ld de, Text_ServeRivalPracticeUpRetry ; $5e9f
	jr .storeWinText ; $5ea2
.stillJunior:
	ld de, Text_ServeRivalJuniorClassRetry ; $5ea4
.storeWinText:
	ld a, e ; $5ea7
	ld [hl+], a ; $5ea8
	ld [hl], d ; $5ea9
	ld hl, wChallengerRivalLostTextId ; $5eaa
	ld de, Text_ServeRivalCantLose ; $5ead
	ld a, e ; $5eb0
	ld [hl+], a ; $5eb1
	ld [hl], d ; $5eb2
	call ServeChallengerResultScene ; $5eb3
	ret ; $5eb6
ServiceMatch2ResultScene:
	ld hl, wChallengerFollowupTextId ; $5eb7
	ld de, Text_ServeRivalLetsGetGoing ; $5eba
	ld a, e ; $5ebd
	ld [hl+], a ; $5ebe
	ld [hl], d ; $5ebf
	ld hl, wChallengerTiedTextId ; $5ec0
	ld de, Text_ServeRivalTiedKeepGoing ; $5ec3
	ld a, e ; $5ec6
	ld [hl+], a ; $5ec7
	ld [hl], d ; $5ec8
	ld hl, wChallengerRivalWonTextId ; $5ec9
	ld de, Text_ServeRivalGotRevenge ; $5ecc
	ld a, e ; $5ecf
	ld [hl+], a ; $5ed0
	ld [hl], d ; $5ed1
	ld hl, wChallengerRivalLostTextId ; $5ed2
	ld de, Text_ServeRivalLostAgain ; $5ed5
	ld a, e ; $5ed8
	ld [hl+], a ; $5ed9
	ld [hl], d ; $5eda
	call ServeChallengerResultScene ; $5edb
	ret ; $5ede
ServiceMatch3ResultScene:
	ld hl, wChallengerFollowupTextId ; $5edf
	ld de, Text_ServeRivalLetsGetGoing ; $5ee2
	ld a, e ; $5ee5
	ld [hl+], a ; $5ee6
	ld [hl], d ; $5ee7
	ld hl, wChallengerTiedTextId ; $5ee8
	ld de, Text_ServeRivalTiedKeepGoing ; $5eeb
	ld a, e ; $5eee
	ld [hl+], a ; $5eef
	ld [hl], d ; $5ef0
	ld hl, wChallengerRivalWonTextId ; $5ef1
	ld de, Text_ServeRivalBeatYouThisTime ; $5ef4
	ld a, e ; $5ef7
	ld [hl+], a ; $5ef8
	ld [hl], d ; $5ef9
	ld hl, wChallengerRivalLostTextId ; $5efa
	ld de, Text_ServeRivalFinalLoss ; $5efd
	ld a, e ; $5f00
	ld [hl+], a ; $5f01
	ld [hl], d ; $5f02
	call ServeChallengerResultScene ; $5f03
	ret ; $5f06
ChallengerResultTied:
	ld hl, wChallengerTiedTextId ; $5f07
	ld a, [hl+] ; $5f0a
	ld h, [hl] ; $5f0b
	ld l, a ; $5f0c
	farcall InitDialogueTextCursor ; $5f0d
	script_speak_restore [wChallengerActor] ; $5f10
	farcall RunDialogueYesNoPrompt ; $5f16
	farcall ScriptCloseDialogueWindow ; $5f19
	script_wait_frames 5 ; $5f1c
	and a ; $5f23
	jr nz, .declined ; $5f24
	script_speak [wChallengerActor] ; $5f26
	ld a, STORYLOC_TRAINING_COURT ; $5f2c
	ld [wStoryModeCurrentLocation], a ; $5f2e
	ld a, ENTRY_TRAINING_COURT_DRILL_RESULT ; $5f31
	ld [wStoryModeEntryPoint], a ; $5f33
	ld a, EXITTRIGGER_DIRECT ; $5f36
	ld [wUnusedExitTriggerIdMirror], a ; $5f38
	ld [wStoryModeExitTriggerRequest], a ; $5f3b
	ld a, [wCurrentMatchIndex] ; $5f3e
	farcall RunTrainingDrillByID ; $5f41
	farcall EndCutsceneScriptMode ; $5f44
	ret ; $5f47
.declined:
	farcall AdvanceDialogueTextCursor ; $5f48
	script_speak [wChallengerActor] ; $5f4b
	call WalkChallengerOntoCourt ; $5f51
	farcall EndCutsceneScriptMode ; $5f54
	ret ; $5f57
ChallengerResultRivalWon:
	ld hl, wChallengerRivalWonTextId ; $5f58
	ld a, [hl+] ; $5f5b
	ld h, [hl] ; $5f5c
	ld l, a ; $5f5d
	farcall InitDialogueTextCursor ; $5f5e
	script_speak_restore [wChallengerActor] ; $5f61
	farcall RunDialogueYesNoPrompt ; $5f67
	farcall ScriptCloseDialogueWindow ; $5f6a
	script_wait_frames 5 ; $5f6d
	and a ; $5f74
	jr nz, .declined ; $5f75
	ld hl, wChallengerFollowupTextId ; $5f77
	ld a, [hl+] ; $5f7a
	ld h, [hl] ; $5f7b
	ld l, a ; $5f7c
	farcall InitDialogueTextCursor ; $5f7d
	script_speak [wChallengerActor] ; $5f80
	ld a, STORYLOC_TRAINING_COURT ; $5f86
	ld [wStoryModeCurrentLocation], a ; $5f88
	ld a, ENTRY_TRAINING_COURT_DRILL_RESULT ; $5f8b
	ld [wStoryModeEntryPoint], a ; $5f8d
	ld a, EXITTRIGGER_DIRECT ; $5f90
	ld [wUnusedExitTriggerIdMirror], a ; $5f92
	ld [wStoryModeExitTriggerRequest], a ; $5f95
	ld a, [wCurrentMatchIndex] ; $5f98
	farcall RunTrainingDrillByID ; $5f9b
	farcall EndCutsceneScriptMode ; $5f9e
	ret ; $5fa1
.declined:
	ld hl, wChallengerFollowupTextId ; $5fa2
	ld a, [hl+] ; $5fa5
	ld h, [hl] ; $5fa6
	ld l, a ; $5fa7
	farcall InitDialogueTextCursor ; $5fa8
	farcall AdvanceDialogueTextCursor ; $5fab
	script_speak [wChallengerActor] ; $5fae
	call WalkChallengerOntoCourt ; $5fb4
	farcall EndCutsceneScriptMode ; $5fb7
	ret ; $5fba
	call WalkChallengerOntoCourt ; $5fbb
	farcall EndCutsceneScriptMode ; $5fbe
	ret ; $5fc1
ChallengerResultRivalLost:
	script_set_anim [wChallengerActor], ANIM_BOUNCE ; $5fc2
	script_wait_idle [wChallengerActor] ; $5fca
	ld hl, wChallengerRivalLostTextId ; $5fd0
	ld a, [hl+] ; $5fd3
	ld h, [hl] ; $5fd4
	ld l, a ; $5fd5
	farcall InitDialogueTextCursor ; $5fd6
	script_speak [wChallengerActor] ; $5fd9
	script_lock_facing [wChallengerActor] ; $5fdf
	script_move_angle [wChallengerActor], FACE_UP, 1.0 ; $5fe7
	script_wait_move [wChallengerActor] ; $5ff2
	script_wait_frames 40 ; $5ff8
	script_move_angle [wChallengerActor], FACE_UP, 1.0 ; $5fff
	script_wait_move [wChallengerActor] ; $600a
	script_set_anim [wChallengerActor], ANIM_BOUNCE ; $6010
	script_wait_idle [wChallengerActor] ; $6018
	script_speak [wChallengerActor] ; $601e
	script_unlock_facing [wChallengerActor] ; $6024
	call WalkChallengerAwayDefeated ; $602c
	script_set_position [wChallengerActor], 63.0, 63.0 ; $602f
	call MovePlayerToLessonCourtSpot ; $603b
	farcall EndCutsceneScriptMode ; $603e
	ret ; $6041
WalkChallengerAwayDefeated:
	ld a, [wCurrentMatchIndex] ; $6042
	sub $0a ; $6045
	jp nc, .strokeChallenger ; $6047
	ld a, [wCurrentMatchIndex] ; $604a
	sub $04 ; $604d
	jp c, .serveChallenger ; $604f
	jp .netChallenger ; $6052
	ret ; $6055
.serveChallenger:
	script_set_speed [wChallengerActor], 1.5 ; $6056
	script_get_actor_state [wChallengerActor] ; $605f
	ld a, $04 ; $6065
	ld e, l ; $6067
	ld d, h ; $6068
	ld hl, ACTORF_ANIM_RATE ; $6069
	add hl, de ; $606c
	ld [hl], a ; $606d
	script_move_target [wChallengerActor], 31.0, 11.0 ; $606e
	script_wait_move [wChallengerActor] ; $607a
	script_move_target [wChallengerActor], 31.0, 17.0 ; $6080
	script_wait_move [wChallengerActor] ; $608c
	script_face ACTOR_PLAYER, FACE_DOWN ; $6092
	script_move_target [wChallengerActor], 31.0, 31.0 ; $6099
	script_wait_move [wChallengerActor] ; $60a5
	set_flag FLAG_SERVE_CHALLENGER_DEFEATED ; $60ab
	ret ; $60ae
.netChallenger:
	script_set_speed [wChallengerActor], 1.5 ; $60af
	script_get_actor_state [wChallengerActor] ; $60b8
	ld a, $04 ; $60be
	ld e, l ; $60c0
	ld d, h ; $60c1
	ld hl, ACTORF_ANIM_RATE ; $60c2
	add hl, de ; $60c5
	ld [hl], a ; $60c6
	script_move_target [wChallengerActor], 33.0, 37.0 ; $60c7
	script_wait_move [wChallengerActor] ; $60d3
	script_face ACTOR_PLAYER, FACE_DOWN ; $60d9
	script_move_target [wChallengerActor], 31.0, 53.0 ; $60e0
	script_wait_move [wChallengerActor] ; $60ec
	set_flag FLAG_NET_CHALLENGER_DEFEATED ; $60f2
	ret ; $60f5
.strokeChallenger:
	script_face [wChallengerActor], FACE_UP ; $60f6
	script_set_anim [wChallengerActor], ANIM_BOUNCE ; $60fe
	script_wait_idle [wChallengerActor] ; $6106
	script_set_anim [wChallengerActor], ANIM_BOUNCE ; $610c
	script_wait_idle [wChallengerActor] ; $6114
	script_speak [wChallengerActor] ; $611a
	script_set_speed [wChallengerActor], 1.5 ; $6120
	script_get_actor_state [wChallengerActor] ; $6129
	ld a, $04 ; $612f
	ld e, l ; $6131
	ld d, h ; $6132
	ld hl, ACTORF_ANIM_RATE ; $6133
	add hl, de ; $6136
	ld [hl], a ; $6137
	script_move_target [wChallengerActor], 31.0, 37.0 ; $6138
	script_wait_move [wChallengerActor] ; $6144
	script_move_target [wChallengerActor], 31.0, 41.0 ; $614a
	script_wait_move [wChallengerActor] ; $6156
	script_face ACTOR_PLAYER, FACE_DOWN ; $615c
	script_move_target [wChallengerActor], 31.0, 53.0 ; $6163
	script_wait_move [wChallengerActor] ; $616f
	set_flag FLAG_STROKE_CHALLENGER_DEFEATED ; $6175
	ret ; $6178
WalkChallengerOntoCourt:
	ld a, [wCurrentMatchIndex] ; $6179
	sub $0a ; $617c
	jr nc, .strokeCourt ; $617e
	ld a, [wCurrentMatchIndex] ; $6180
	sub $04 ; $6183
	jr c, .serveCourt ; $6185
	jp .netCourt ; $6187
	ret ; $618a
.strokeCourt:
	script_move_target [wChallengerActor], 19.0, 37.0 ; $618b
	script_wait_move [wChallengerActor] ; $6197
	script_move_target [wChallengerActor], 19.0, 39.0 ; $619d
	script_move_target ACTOR_PLAYER, 19.0, 43.0 ; $61a9
	script_wait_move ACTOR_PLAYER ; $61b4
	script_follow ACTOR_PARTNER, ACTOR_PLAYER ; $61b9
	script_wait_move [wChallengerActor] ; $61c6
	script_face [wChallengerActor], FACE_DOWN ; $61cc
	ret ; $61d4
.serveCourt:
	script_move_target [wChallengerActor], 19.0, 11.0 ; $61d5
	script_wait_frames 30 ; $61e1
	script_move_target ACTOR_PLAYER, 19.0, 19.0 ; $61e8
	script_wait_move ACTOR_PLAYER ; $61f3
	script_follow ACTOR_PARTNER, ACTOR_PLAYER ; $61f8
	script_wait_move [wChallengerActor] ; $6205
	script_face [wChallengerActor], FACE_RIGHT ; $620b
	ret ; $6213
.netCourt:
	script_move_target [wChallengerActor], 45.0, 33.0 ; $6214
	script_wait_frames 30 ; $6220
	script_move_target ACTOR_PLAYER, 45.0, 43.0 ; $6227
	script_wait_move ACTOR_PLAYER ; $6232
	script_follow ACTOR_PARTNER, ACTOR_PLAYER ; $6237
	script_wait_move [wChallengerActor] ; $6244
	script_face [wChallengerActor], FACE_RIGHT ; $624a
	ret ; $6252
