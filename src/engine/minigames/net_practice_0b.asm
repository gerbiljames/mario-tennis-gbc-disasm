NetGameMatch3JudgeOnPointEnd:
	ld a, JUDGEEVENT_POINT_END ; $5a78
	call NetGameMatch3JudgePoint ; $5a7a
	ld [wDrillPointJudgement], a ; $5a7d
	ret ; $5a80
NetGameMatch3JudgeOnBallHit:
	ld a, JUDGEEVENT_BALL_HIT ; $5a81
	call NetGameMatch3JudgePoint ; $5a83
	ld [wDrillPointJudgement], a ; $5a86
	ret ; $5a89
NetGameMatch3JudgeOnBounce:
	ret ; $5a8a
	ld a, JUDGEEVENT_BOUNCE ; $5a8b
	call NetGameMatch3JudgePoint ; $5a8d
	ld [wDrillPointJudgement], a ; $5a90
	ret ; $5a93
NetGameMatch3JudgeOnNetCross:
	ret ; $5a94
	ld a, JUDGEEVENT_NET_CROSS ; $5a95
	call NetGameMatch3JudgePoint ; $5a97
	ld [wDrillPointJudgement], a ; $5a9a
	ret ; $5a9d
NetGameMatch3JudgePoint:
	ld b, a ; $5a9e
	ld a, [wDrillPointJudgement] ; $5a9f
	or a ; $5aa2
	ret nz ; $5aa3
	ld a, [wRallyLength] ; $5aa4
	dec a ; $5aa7
	jumptable a ; $5aa8
	dw NetGameMatch3JudgePoint.rally1 ; $5aaa jumptable
	dw NetGameMatch3Cases1.rally2 ; $5aac jumptable
	dw NetGameMatch3Cases2.rally3 ; $5aae jumptable
	dw NetGameMatch3Cases3.rally4 ; $5ab0 jumptable
	dw NetGameMatch3Cases4.rally5 ; $5ab2 jumptable
.rally1:
	ld a, b ; $5ab4
	jumptable a ; $5ab5
	dw NetGameMatch3JudgePoint.rally1PointEnd ; $5ab7 jumptable
	dw NetGameMatch3Cases1 ; $5ab9 jumptable
	dw NetGameMatch3Cases1.ignoreBounce ; $5abb jumptable
	dw NetGameMatch3Cases1.ignoreNetCross ; $5abd jumptable
.rally1PointEnd:
	ld a, [wPointOutcome] ; $5abf
	ld hl, NetGameMatch3Rally1Messages ; $5ac2
	add_hl_a ; $5ac5
	ld a, [hl] ; $5aca
	ld a, a ; $5acb
	ld b, DRILLWORDING_NET ; $5acc
	call SetDrillServerMessage ; $5ace
	ld a, [wPointOutcome] ; $5ad1
	ld hl, OddRallyVerdicts ; $5ad4
	add_hl_a ; $5ad7
	ld a, [hl] ; $5adc
	ret ; $5add
NetGameMatch3Rally1Messages:
	; $5ade, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_DOUBLE_FAULT_YOU_FAILED_3, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_YOU_DIDNT_SCORE_SO_YOU_FAIL, DRILLMSG_I_DIDNT_RETURN_THE_BALL_SO_YOU_GET_A_POINT, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_I_DIDNT_RETURN_THE_BALL_SO_YOU_GET_A_POINT
NetGameMatch3Cases1:
	xor a ; $5ae8
	ret ; $5ae9
.ignoreBounce:
	xor a ; $5aea
	ret ; $5aeb
.ignoreNetCross:
	xor a ; $5aec
	ret ; $5aed
.rally2:
	ld a, b ; $5aee
	jumptable a ; $5aef
	dw NetGameMatch3Cases1.rally2PointEnd ; $5af1 jumptable
	dw NetGameMatch3Cases2 ; $5af3 jumptable
	dw NetGameMatch3Cases2.ignoreBounce ; $5af5 jumptable
	dw NetGameMatch3Cases2.ignoreNetCross ; $5af7 jumptable
.rally2PointEnd:
	ld a, [wPointOutcome] ; $5af9
	ld hl, NetGameMatch3Rally2Messages ; $5afc
	add_hl_a ; $5aff
	ld a, [hl] ; $5b04
	ld a, a ; $5b05
	ld b, DRILLWORDING_NET ; $5b06
	call SetDrillServerMessage ; $5b08
	ld a, [wPointOutcome] ; $5b0b
	ld hl, EvenRallyVerdicts ; $5b0e
	add_hl_a ; $5b11
	ld a, [hl] ; $5b16
	ret ; $5b17
NetGameMatch3Rally2Messages:
	; $5b18, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_I_DIDNT_RETURN_THE_BALL_SO_YOU_GET_A_POINT, DRILLMSG_I_DIDNT_RETURN_THE_BALL_SO_YOU_GET_A_POINT, DRILLMSG_YOU_DIDNT_PLAY_THE_NET_SO_YOU_FAIL, DRILLMSG_I_RETURNED_THE_SERVE_BEFORE_IT_BOUNCED_SO_YOU_GET_2, DRILLMSG_I_RETURNED_THE_SERVE_BEFORE_IT_BOUNCED_SO_YOU_GET_2, DRILLMSG_YOU_DIDNT_PLAY_THE_NET_SO_YOU_FAIL
NetGameMatch3Cases2:
	xor a ; $5b22
	ret ; $5b23
.ignoreBounce:
	xor a ; $5b24
	ret ; $5b25
.ignoreNetCross:
	xor a ; $5b26
	ret ; $5b27
.rally3:
	ld a, b ; $5b28
	jumptable a ; $5b29
	dw NetGameMatch3Cases2.rally3PointEnd ; $5b2b jumptable
	dw NetGameMatch3Cases3 ; $5b2d jumptable
	dw NetGameMatch3Cases3.ignoreBounce ; $5b2f jumptable
	dw NetGameMatch3Cases3.ignoreNetCross ; $5b31 jumptable
.rally3PointEnd:
	ld a, [wPointOutcome] ; $5b33
	ld hl, NetGameMatch3Rally3Messages ; $5b36
	add_hl_a ; $5b39
	ld a, [hl] ; $5b3e
	ld a, a ; $5b3f
	ld b, DRILLWORDING_NET ; $5b40
	call SetDrillServerMessage ; $5b42
	ld a, [wPointOutcome] ; $5b45
	ld hl, OddRallyVerdicts ; $5b48
	add_hl_a ; $5b4b
	ld a, [hl] ; $5b50
	ret ; $5b51
NetGameMatch3Rally3Messages:
	; $5b52, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_YOU_DIDNT_SCORE_SO_YOU_FAIL, DRILLMSG_YOU_DIDNT_SCORE_SO_YOU_FAIL, DRILLMSG_WAY_TO_PLAY_THE_NET_YOU_GET_A_POINT, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_WAY_TO_PLAY_THE_NET_YOU_GET_A_POINT
NetGameMatch3Cases3:
	ld a, DRILLMSG_YOU_DIDNT_HIT_FROM_IN_FRONT_OF_THE_SERVICE_LINE ; $5b5c
	ld b, DRILLWORDING_NET ; $5b5e
	call SetDrillServerMessage ; $5b60
	ld a, [wTotalPointsScoredInCurrentGame] ; $5b63
	and $01 ; $5b66
	call IsCharNearNet ; $5b68
	or a ; $5b6b
	jp z, DrillPointLost_5 ; $5b6c
	xor a ; $5b6f
	ret ; $5b70
.ignoreBounce:
	xor a ; $5b71
	ret ; $5b72
.ignoreNetCross:
	xor a ; $5b73
	ret ; $5b74
.rally4:
	ld a, b ; $5b75
	jumptable a ; $5b76
	dw NetGameMatch3Cases3.rally4PointEnd ; $5b78 jumptable
	dw NetGameMatch3Cases4 ; $5b7a jumptable
	dw NetGameMatch3Cases4.ignoreBounce ; $5b7c jumptable
	dw NetGameMatch3Cases4.ignoreNetCross ; $5b7e jumptable
.rally4PointEnd:
	ld a, [wPointOutcome] ; $5b80
	ld hl, NetGameMatch3Rally4Messages ; $5b83
	add_hl_a ; $5b86
	ld a, [hl] ; $5b8b
	ld a, a ; $5b8c
	ld b, DRILLWORDING_NET ; $5b8d
	call SetDrillServerMessage ; $5b8f
	ld a, [wPointOutcome] ; $5b92
	ld hl, EvenRallyVerdicts ; $5b95
	add_hl_a ; $5b98
	ld a, [hl] ; $5b9d
	ret ; $5b9e
NetGameMatch3Rally4Messages:
	; $5b9f, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_WAY_TO_PLAY_THE_NET_YOU_GET_A_POINT, DRILLMSG_WAY_TO_PLAY_THE_NET_YOU_GET_A_POINT, DRILLMSG_YOU_DIDNT_SCORE_SO_YOU_FAIL, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_YOU_DIDNT_SCORE_SO_YOU_FAIL
NetGameMatch3Cases4:
	xor a ; $5ba9
	ret ; $5baa
.ignoreBounce:
	xor a ; $5bab
	ret ; $5bac
.ignoreNetCross:
	xor a ; $5bad
	ret ; $5bae
.rally5:
	ld a, b ; $5baf
	jumptable a ; $5bb0
	dw NetGameMatch3Cases4.rally5IgnorePointEnd ; $5bb2 jumptable
	dw NetGameMatch3Cases4.rally5FailBallHit ; $5bb4 jumptable
	dw NetGameMatch3Cases4.rally5IgnoreBounce ; $5bb6 jumptable
	dw NetGameMatch3Cases4.rally5IgnoreNetCross ; $5bb8 jumptable
.rally5IgnorePointEnd:
	xor a ; $5bba
	ret ; $5bbb
.rally5FailBallHit:
	ld a, DRILLMSG_YOU_DIDNT_SCORE_SO_YOU_FAIL ; $5bbc
	ld b, DRILLWORDING_NET ; $5bbe
	call SetDrillServerMessage ; $5bc0
	jp DrillPointLost_5 ; $5bc3
.rally5IgnoreBounce:
	xor a ; $5bc6
	ret ; $5bc7
.rally5IgnoreNetCross:
	xor a ; $5bc8
	ret ; $5bc9
Unused_0b_DrillPointWon_5:
	ld a, MATCHABORT_POINT ; $5bca
	ld [wMatchAbortFlag], a ; $5bcc
	ld a, WINLOSE_WIN ; $5bcf
	ret ; $5bd1
DrillPointLost_5:
	ld a, MATCHABORT_POINT ; $5bd2
	ld [wMatchAbortFlag], a ; $5bd4
	ld a, WINLOSE_LOSE ; $5bd7
	ret ; $5bd9
NetGamePractice1Drill:
	; $5bda, 16 bytes
	drill_def CHAR_DRILL_NET_GAME_PRACTICE_1, COURT_TRAINING_PRACTICE, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_NET_GAME_PRACTICE_1, BGM_DRILL_PRACTICE, CHAR_STORY_MAIN, NetGamePractice1Hooks, PracticeDrillPointTable, NetGamePractice1DrillInit
NetGamePractice1DrillInit:
	ld a, $01 ; $5bea
	ld [wDrillIsPracticeLesson], a ; $5bec
	ret ; $5bef
NetGamePractice1Hooks:
	; $5bf0, 16 bytes (mode_hooks)
	table_width 2
	dw NetGamePractice1Hook_PerFrame ; MODEHOOK_PER_FRAME
	dw NetGamePractice1Hook_PointStart ; MODEHOOK_POINT_START
	dw NetGamePractice1Hook_PointEnd ; MODEHOOK_POINT_END
	dw NetGamePractice1Hook_MinigameStart ; MODEHOOK_MINIGAME_START
	dw NetGamePractice1Hook_BallHit ; MODEHOOK_BALL_HIT
	dw NetGamePractice1Hook_Bounce ; MODEHOOK_BOUNCE
	dw NetGamePractice1Hook_NetCross ; MODEHOOK_NET_CROSS
	dw RetStub ; MODEHOOK_DRAW
	assert_table_length NUM_MODEHOOKS
NetGamePractice1Hook_MinigameStart:
	xor a ; $5c00
	ld [wDrillCounters + DRILLCTR_NETP1_NET_OR_OUT], a ; $5c01
	ld [wDrillCounters + DRILLCTR_OFF_TARGET], a ; $5c04
	ld [wDrillCounters + DRILLCTR_PASSES], a ; $5c07
	ld a, $04 ; $5c0a
	ld [wDrillCounters + DRILLCTR_SHOTS_LEFT], a ; $5c0c
	ld a, $01 ; $5c0f
	ld [wDrillIsPracticeLesson], a ; $5c11
	ret ; $5c14
NetGamePractice1Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $5c15
	ret ; $5c18
NetGamePractice1Hook_PointStart:
	xor a ; $5c19
	ld [wDrillAbortCountdownActive], a ; $5c1a
	ld a, DRILL_ABORT_FRAMES ; $5c1d
	ld [wDrillAbortCountdown], a ; $5c1f
	xor a ; $5c22
	ld [wDrillCounters + 6], a ; $5c23
	ld a, $01 ; $5c26
	ld [wTargetZoneEnabled], a ; $5c28
	ld hl, NetGamePractice1TargetZones ; $5c2b
	call SetDrillTargetZoneForPoint ; $5c2e
	ld a, CHAR_DRILL_NET_GAME_PRACTICE_1 ; $5c31
	call LoadDrillOpponentChar ; $5c33
	ASSERT DRILLMSG_NONE == 0
	xor a ; $5c36
	ld [wDrillMessageId], a ; $5c37
	xor a ; $5c3a
	ld [wDrillPointJudgement], a ; $5c3b
	ld a, [wTotalPointsScoredInCurrentGame] ; $5c3e
	ld hl, NetGamePractice1ServeAims ; $5c41
	add_hl_a ; $5c44
	ld a, [hl] ; $5c49
	ld [wAiServeAimOverride], a ; $5c4a
	ret ; $5c4d
NetGamePractice1ServeAims:
	; $5c4e, 4 bytes (bytes:4)
	db PADF_LEFT, PADF_RIGHT, PADF_RIGHT, PADF_LEFT
NetGamePractice1Hook_PointEnd:
	call NetGamePractice1JudgeOnPointEnd ; $5c52
	ld a, [wPointOutcome] ; $5c55
	cp POINTOUTCOME_NET ; $5c58
	jr z, .countNetOrOut ; $5c5a
	cp POINTOUTCOME_OUT ; $5c5c
	jr z, .countNetOrOut ; $5c5e
	jr .handlePointEnd ; $5c60
.countNetOrOut:
	ld hl, wDrillCounters + DRILLCTR_NETP1_NET_OR_OUT ; $5c62
	inc [hl] ; $5c65
.handlePointEnd:
	call NetGamePractice1HandlePointEnd ; $5c66
	ld a, [wTotalPointsScoredInCurrentGame] ; $5c69
	cp DRILL_LESSON_POINTS ; $5c6c
	ret c ; $5c6e
	call NetGamePractice1EvaluateResult ; $5c6f
	ld [wPointWinLoseFlag], a ; $5c72
	ret ; $5c75
NetGamePractice1EvaluateResult:
	ld a, [wDrillCounters + DRILLCTR_PASSES] ; $5c76
	cp DRILL_LESSON_POINTS ; $5c79
	jr nz, .checkCharacter1DoubleFaults ; $5c7b
	ASSERT LESSON_PASSED == 0
	xor a ; $5c7d
	ld [wDrillLessonResult], a ; $5c7e
	ld a, WINLOSE_WIN ; $5c81
	ret ; $5c83
.checkCharacter1DoubleFaults:
	ld a, [wCharacter1DoubleFaults] ; $5c84
	cp DRILL_LESSON_POINTS ; $5c87
	jr nz, .compare ; $5c89
	ld a, LESSON_NET_ALL_FAULTS ; $5c8b
	ld [wDrillLessonResult], a ; $5c8d
	jr .lessonFailed ; $5c90
.compare:
	or a ; $5c92
	jr z, .noDoubleFaults ; $5c93
	ld a, LESSON_NET_DOUBLE_FAULT ; $5c95
	ld [wDrillLessonResult], a ; $5c97
	jr .lessonFailed ; $5c9a
.noDoubleFaults:
	ld a, [wDrillCounters + DRILLCTR_PASSES] ; $5c9c
	cp DRILL_LESSON_POINTS - 1 ; $5c9f
	jr nz, .checkShotsLeft ; $5ca1
	ld a, LESSON_VOLLEY_ALMOST ; $5ca3
	ld [wDrillLessonResult], a ; $5ca5
	jr .lessonFailed ; $5ca8
.checkShotsLeft:
	ld a, [wDrillCounters + DRILLCTR_SHOTS_LEFT] ; $5caa
	or a ; $5cad
	jr nz, .volleyMissed ; $5cae
	ld a, LESSON_VOLLEY_WRONG_SIDE ; $5cb0
	ld [wDrillLessonResult], a ; $5cb2
	jr .lessonFailed ; $5cb5
.volleyMissed:
	ld a, LESSON_VOLLEY_MISSED ; $5cb7
	ld [wDrillLessonResult], a ; $5cb9
	jr .lessonFailed ; $5cbc
.lessonFailed:
	ld a, WINLOSE_LOSE ; $5cbe
	ret ; $5cc0
NetGamePractice1Hook_NetCross:
	call NetGamePractice1JudgeOnNetCross ; $5cc1
	ret ; $5cc4
NetGamePractice1Hook_Bounce:
	call NetGamePractice1JudgeOnBounce ; $5cc5
	ret ; $5cc8
NetGamePractice1Hook_BallHit:
	call NetGamePractice1JudgeOnBallHit ; $5cc9
	ld a, [wLastShotCharIndex] ; $5ccc
	cp $01 ; $5ccf
	jr nz, .done ; $5cd1
	call SetOpponentCharInert ; $5cd3
.done:
	ret ; $5cd6
NetGamePractice1TargetZones:
	; $5cd7, 34 bytes (records:2)
	dw $0000 ; record 0
	dw $fb20 ; record 1
	dw $01b0 ; record 2
	dw $feb0 ; record 3
	dw $fe50 ; record 4
	dw $fb20 ; record 5
	dw $0000 ; record 6
	dw $feb0 ; record 7
	dw $fe50 ; record 8
	dw $0150 ; record 9
	dw $0000 ; record 10
	dw $04e0 ; record 11
	dw $0000 ; record 12
	dw $0150 ; record 13
	dw $01b0 ; record 14
	dw $04e0 ; record 15
	dw $ffff ; record 16
	twin_named net_game_practice1_handle_point_end, NetGamePractice1HandlePointEnd ; $5cf9
NetGamePractice1JudgeOnPointEnd:
	ld a, JUDGEEVENT_POINT_END ; $5d48
	call NetGamePractice1JudgePoint ; $5d4a
	ld [wDrillPointJudgement], a ; $5d4d
	ret ; $5d50
NetGamePractice1JudgeOnBallHit:
	ld a, JUDGEEVENT_BALL_HIT ; $5d51
	call NetGamePractice1JudgePoint ; $5d53
	ld [wDrillPointJudgement], a ; $5d56
	ret ; $5d59
NetGamePractice1JudgeOnBounce:
	ld a, JUDGEEVENT_BOUNCE ; $5d5a
	call NetGamePractice1JudgePoint ; $5d5c
	ld [wDrillPointJudgement], a ; $5d5f
	ret ; $5d62
; Judges the point on the rally-tick event -- except that the leading `ret`
; means the body never runs. Called from NetGamePractice1Hook_NetCross, the
; fourth of this drill's four judges; see docs/bugs.md.
NetGamePractice1JudgeOnNetCross:
	ret ; $5d63
	ld a, JUDGEEVENT_NET_CROSS ; $5d64
	call NetGamePractice1JudgePoint ; $5d66
	ld [wDrillPointJudgement], a ; $5d69
	ret ; $5d6c
NetGamePractice1JudgePoint:
	ld b, a ; $5d6d
	ld a, [wDrillPointJudgement] ; $5d6e
	or a ; $5d71
	ret nz ; $5d72
	ld a, [wRallyLength] ; $5d73
	dec a ; $5d76
	jumptable a ; $5d77
	dw NetGamePractice1JudgePoint.rally1 ; $5d79 jumptable
	dw NetGamePractice1Cases1.rally2 ; $5d7b jumptable
	dw NetGamePractice1Cases2.rally3 ; $5d7d jumptable
.rally1:
	ld a, b ; $5d7f
	jumptable a ; $5d80
	dw NetGamePractice1JudgePoint.rally1PointEnd ; $5d82 jumptable
	dw NetGamePractice1Cases1 ; $5d84 jumptable
	dw NetGamePractice1Cases1.ignoreBounce ; $5d86 jumptable
	dw NetGamePractice1Cases1.ignoreNetCross ; $5d88 jumptable
.rally1PointEnd:
	ld a, [wPointOutcome] ; $5d8a
	ld hl, NetGamePractice1Rally1Messages ; $5d8d
	add_hl_a ; $5d90
	ld a, [hl] ; $5d95
	ld a, a ; $5d96
	ld b, DRILLWORDING_SAME ; $5d97
	call SetDrillServerMessage ; $5d99
	ld a, [wPointOutcome] ; $5d9c
	ld hl, OddRallyVerdicts ; $5d9f
	add_hl_a ; $5da2
	ld a, [hl] ; $5da7
	ret ; $5da8
NetGamePractice1Rally1Messages:
	; $5da9, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_DOUBLE_FAULT_YOU_FAIL, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL_2, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED
NetGamePractice1Cases1:
	xor a ; $5db3
	ret ; $5db4
.ignoreBounce:
	xor a ; $5db5
	ret ; $5db6
.ignoreNetCross:
	xor a ; $5db7
	ret ; $5db8
.rally2:
	ld a, b ; $5db9
	jumptable a ; $5dba
	dw NetGamePractice1Cases1.rally2PointEnd ; $5dbc jumptable
	dw NetGamePractice1Cases2 ; $5dbe jumptable
	dw NetGamePractice1Cases2.ignoreBounce ; $5dc0 jumptable
	dw NetGamePractice1Cases2.ignoreNetCross ; $5dc2 jumptable
.rally2PointEnd:
	ld a, [wPointOutcome] ; $5dc4
	ld hl, NetGamePractice1Rally2Messages ; $5dc7
	add_hl_a ; $5dca
	ld a, [hl] ; $5dcf
	ld a, a ; $5dd0
	ld b, DRILLWORDING_SAME ; $5dd1
	call SetDrillServerMessage ; $5dd3
	ld a, [wPointOutcome] ; $5dd6
	ld hl, EvenRallyVerdicts ; $5dd9
	add_hl_a ; $5ddc
	ld a, [hl] ; $5de1
	ret ; $5de2
NetGamePractice1Rally2Messages:
	; $5de3, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED, DRILLMSG_YOU_DIDNT_VOLLEY_SO_YOU_FAIL, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED, DRILLMSG_YOU_DIDNT_VOLLEY_SO_YOU_FAIL
NetGamePractice1Cases2:
	xor a ; $5ded
	ret ; $5dee
.ignoreBounce:
	xor a ; $5def
	ret ; $5df0
.ignoreNetCross:
	xor a ; $5df1
	ret ; $5df2
.rally3:
	ld a, b ; $5df3
	jumptable a ; $5df4
	dw NetGamePractice1Cases2.rally3PointEnd ; $5df6 jumptable
	dw NetGamePractice1Cases3 ; $5df8 jumptable
	dw NetGamePractice1Cases3.judgeBounce ; $5dfa jumptable
	dw NetGamePractice1Cases3.ignoreNetCross ; $5dfc jumptable
.rally3PointEnd:
	ld a, [wPointOutcome] ; $5dfe
	ld hl, NetGamePractice1Rally3Messages ; $5e01
	add_hl_a ; $5e04
	ld a, [hl] ; $5e09
	ld a, a ; $5e0a
	ld b, DRILLWORDING_SAME ; $5e0b
	call SetDrillServerMessage ; $5e0d
	ld a, [wPointOutcome] ; $5e10
	ld hl, NetGamePractice1Rally3Verdicts ; $5e13
	add_hl_a ; $5e16
	ld a, [hl] ; $5e1b
	ret ; $5e1c
NetGamePractice1Rally3Verdicts:
	; $5e1d, 10 bytes (drill_verdicts)
	drill_verdicts WINLOSE_NONE, WINLOSE_NONE, WINLOSE_LOSE, WINLOSE_NONE, WINLOSE_LOSE, WINLOSE_LOSE, WINLOSE_LOSE, WINLOSE_LOSE, WINLOSE_LOSE, WINLOSE_LOSE
NetGamePractice1Rally3Messages:
	; $5e27, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL_2, DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL_2, DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL_2, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL_2
NetGamePractice1Cases3:
	ld a, DRILLMSG_YOU_DIDNT_HIT_FROM_IN_FRONT_OF_THE_SERVICE_LINE_2 ; $5e31
	ld b, DRILLWORDING_SAME ; $5e33
	call SetDrillServerMessage ; $5e35
	xor a ; $5e38
	call IsCharNearNet ; $5e39
	or a ; $5e3c
	jp z, .pointLost ; $5e3d
	ld a, DRILLMSG_YOU_DIDNT_VOLLEY_SO_YOU_FAIL ; $5e40
	ld b, DRILLWORDING_SAME ; $5e42
	call SetDrillServerMessage ; $5e44
	ld a, [wShotClass] ; $5e47
	cp SHOTCLASS_VOLLEY ; $5e4a
	jp nz, .pointLost ; $5e4c
	ld hl, wDrillCounters + DRILLCTR_SHOTS_LEFT ; $5e4f
	dec [hl] ; $5e52
	xor a ; $5e53
	ret ; $5e54
.judgeBounce:
	ld a, [wBallBounceCount] ; $5e55
	cp $01 ; $5e58
	ld a, $00 ; $5e5a
	ret nz ; $5e5c
	ld a, [wPointOutcome] ; $5e5d
	cp POINTOUTCOME_NET ; $5e60
	jr z, .missedTarget ; $5e62
	ld a, DRILLMSG_NICE_VOLLEY_YOU_DID_IT ; $5e64
	ld b, DRILLWORDING_SAME ; $5e66
	call SetDrillServerMessage ; $5e68
	call RecordDrillTargetZoneMiss ; $5e6b
	call CheckDrillTargetZoneHit ; $5e6e
	or a ; $5e71
	jp nz, .hitTarget ; $5e72
.missedTarget:
	ld a, DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL_2 ; $5e75
	ld b, DRILLWORDING_SAME ; $5e77
	call SetDrillServerMessage ; $5e79
	ld hl, wDrillCounters + DRILLCTR_OFF_TARGET ; $5e7c
	inc [hl] ; $5e7f
	jp .pointLost ; $5e80
.ignoreNetCross:
	xor a ; $5e83
	ret ; $5e84
.hitTarget:
	ld a, MATCHABORT_POINT ; $5e85
	ld [wMatchAbortFlag], a ; $5e87
	ld a, WINLOSE_WIN ; $5e8a
	ret ; $5e8c
.pointLost:
	ld a, MATCHABORT_POINT ; $5e8d
	ld [wMatchAbortFlag], a ; $5e8f
	ld a, WINLOSE_LOSE ; $5e92
	ret ; $5e94
NetGamePractice2Drill:
	; $5e95, 16 bytes
	drill_def CHAR_DRILL_NET_GAME_PRACTICE_2, COURT_TRAINING_PRACTICE, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_NET_GAME_PRACTICE_2, BGM_DRILL_PRACTICE, CHAR_STORY_MAIN, NetGamePractice2Hooks, PracticeDrillPointTable, NetGamePractice2DrillInit
NetGamePractice2DrillInit:
	ld a, $01 ; $5ea5
	ld [wDrillIsPracticeLesson], a ; $5ea7
	ret ; $5eaa
NetGamePractice2Hooks:
	; $5eab, 16 bytes (mode_hooks)
	table_width 2
	dw NetGamePractice2Hook_PerFrame ; MODEHOOK_PER_FRAME
	dw NetGamePractice2Hook_PointStart ; MODEHOOK_POINT_START
	dw NetGamePractice2Hook_PointEnd ; MODEHOOK_POINT_END
	dw NetGamePractice2Hook_MinigameStart ; MODEHOOK_MINIGAME_START
	dw NetGamePractice2Hook_BallHit ; MODEHOOK_BALL_HIT
	dw NetGamePractice2Hook_Bounce ; MODEHOOK_BOUNCE
	dw NetGamePractice2Hook_NetCross ; MODEHOOK_NET_CROSS
	dw RetStub ; MODEHOOK_DRAW
	assert_table_length NUM_MODEHOOKS
	twin_named net_game_practice2_hook_minigame_start, NetGamePractice2Hook_MinigameStart ; $5ebb
NetGamePractice2Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $5ecd
	ret ; $5ed0
NetGamePractice2Hook_PointStart:
	xor a ; $5ed1
	ld [wDrillAbortCountdownActive], a ; $5ed2
	ld a, DRILL_ABORT_FRAMES ; $5ed5
	ld [wDrillAbortCountdown], a ; $5ed7
	xor a ; $5eda
	ld [wDrillCounters + 1], a ; $5edb
	ld [wDrillCounters + 6], a ; $5ede
	ld a, $01 ; $5ee1
	ld [wTargetZoneEnabled], a ; $5ee3
	ld hl, NetGamePractice2TargetZones ; $5ee6
	call SetDrillTargetZoneForPoint ; $5ee9
	ld a, CHAR_DRILL_NET_GAME_PRACTICE_2 ; $5eec
	call LoadDrillOpponentChar ; $5eee
	ASSERT DRILLMSG_NONE == 0
	xor a ; $5ef1
	ld [wDrillMessageId], a ; $5ef2
	xor a ; $5ef5
	ld [wDrillPointJudgement], a ; $5ef6
	ret ; $5ef9
NetGamePractice2Hook_PointEnd:
	call NetGamePractice2JudgeOnPointEnd ; $5efa
	ld a, [wPointOutcome] ; $5efd
	cp POINTOUTCOME_NET ; $5f00
	jr z, .countNetOrOut ; $5f02
	cp POINTOUTCOME_OUT ; $5f04
	jr z, .countNetOrOut ; $5f06
	jr .handlePointEnd ; $5f08
.countNetOrOut:
	ld hl, wDrillCounters + DRILLCTR_NET_OR_OUT ; $5f0a
	inc [hl] ; $5f0d
.handlePointEnd:
	call NetGamePractice2HandlePointEnd ; $5f0e
	ld a, [wTotalPointsScoredInCurrentGame] ; $5f11
	cp DRILL_LESSON_POINTS ; $5f14
	ret c ; $5f16
	call NetGamePractice2EvaluateResult ; $5f17
	ld [wPointWinLoseFlag], a ; $5f1a
	ret ; $5f1d
NetGamePractice2EvaluateResult:
	ld a, [wDrillCounters + DRILLCTR_PASSES] ; $5f1e
	cp DRILL_LESSON_POINTS ; $5f21
	jr nz, .checkCharacter1DoubleFaults ; $5f23
	ASSERT LESSON_PASSED == 0
	xor a ; $5f25
	ld [wDrillLessonResult], a ; $5f26
	ld a, WINLOSE_WIN ; $5f29
	ret ; $5f2b
.checkCharacter1DoubleFaults:
	ld a, [wCharacter1DoubleFaults] ; $5f2c
	cp DRILL_LESSON_POINTS ; $5f2f
	jr nz, .compare ; $5f31
	ld a, LESSON_NET_ALL_FAULTS ; $5f33
	ld [wDrillLessonResult], a ; $5f35
	jr .lessonFailed ; $5f38
.compare:
	or a ; $5f3a
	jr z, .noDoubleFaults ; $5f3b
	ld a, LESSON_NET_DOUBLE_FAULT ; $5f3d
	ld [wDrillLessonResult], a ; $5f3f
	jr .lessonFailed ; $5f42
.noDoubleFaults:
	ld a, [wDrillCounters + DRILLCTR_PASSES] ; $5f44
	cp DRILL_LESSON_POINTS - 1 ; $5f47
	jr nz, .checkShotsLeft ; $5f49
	ld a, LESSON_SMASH_ALMOST ; $5f4b
	ld [wDrillLessonResult], a ; $5f4d
	jr .lessonFailed ; $5f50
.checkShotsLeft:
	ld a, [wDrillCounters + DRILLCTR_SHOTS_LEFT] ; $5f52
	or a ; $5f55
	jr nz, .checkOneOrTwoPasses ; $5f56
	ld a, LESSON_SMASH_MISSED ; $5f58
	ld [wDrillLessonResult], a ; $5f5a
	jr .lessonFailed ; $5f5d
.checkOneOrTwoPasses:
	ld a, [wDrillCounters + DRILLCTR_PASSES] ; $5f5f
	cp $01 ; $5f62
	jr c, .notAllSides ; $5f64
	cp $03 ; $5f66
	jr nc, .notAllSides ; $5f68
	ld a, LESSON_SMASH_JUDGE_POSITION ; $5f6a
	ld [wDrillLessonResult], a ; $5f6c
	jr .lessonFailed ; $5f6f
.notAllSides:
	ld a, LESSON_SMASH_NOT_ALL_SIDES ; $5f71
	ld [wDrillLessonResult], a ; $5f73
	jr .lessonFailed ; $5f76
.lessonFailed:
	ld a, WINLOSE_LOSE ; $5f78
	ret ; $5f7a
NetGamePractice2Hook_NetCross:
	call NetGamePractice2JudgeOnNetCross ; $5f7b
	ret ; $5f7e
NetGamePractice2Hook_Bounce:
	call NetGamePractice2JudgeOnBounce ; $5f7f
	ret ; $5f82
NetGamePractice2Hook_BallHit:
	call NetGamePractice2JudgeOnBallHit ; $5f83
	ld a, [wLastShotCharIndex] ; $5f86
	cp $01 ; $5f89
	jr nz, .done ; $5f8b
	call SetOpponentCharInert ; $5f8d
.done:
	ret ; $5f90
NetGamePractice2TargetZones:
	; $5f91, 34 bytes (drill_target_zone)
; drill_target_zone x1, depth1, x2, depth2
	drill_target_zone $fe50, $fd60, $0000, $fe40 ; point 0
	drill_target_zone $0000, $fd60, $01b0, $fe40 ; point 1
	drill_target_zone $0000, $01c0, $01b0, $02a0 ; point 2
	drill_target_zone $fe50, $01c0, $0000, $02a0 ; point 3
	db $ff, $ff ; end
	twin_named net_game_practice1_handle_point_end, NetGamePractice2HandlePointEnd ; $5fb3
NetGamePractice2JudgeOnPointEnd:
	ld a, JUDGEEVENT_POINT_END ; $6002
	call NetGamePractice2JudgePoint ; $6004
	ld [wDrillPointJudgement], a ; $6007
	ret ; $600a
NetGamePractice2JudgeOnBallHit:
	ld a, JUDGEEVENT_BALL_HIT ; $600b
	call NetGamePractice2JudgePoint ; $600d
	ld [wDrillPointJudgement], a ; $6010
	ret ; $6013
NetGamePractice2JudgeOnBounce:
	ld a, JUDGEEVENT_BOUNCE ; $6014
	call NetGamePractice2JudgePoint ; $6016
	ld [wDrillPointJudgement], a ; $6019
	ret ; $601c
NetGamePractice2JudgeOnNetCross:
	ret ; $601d
	ld a, JUDGEEVENT_NET_CROSS ; $601e
	call NetGamePractice2JudgePoint ; $6020
	ld [wDrillPointJudgement], a ; $6023
	ret ; $6026
NetGamePractice2JudgePoint:
	ld b, a ; $6027
	ld a, [wDrillPointJudgement] ; $6028
	or a ; $602b
	ret nz ; $602c
	ld a, [wRallyLength] ; $602d
	dec a ; $6030
	jumptable a ; $6031
	dw NetGamePractice2JudgePoint.rally1 ; $6033 jumptable
	dw NetGamePractice2Cases1.rally2 ; $6035 jumptable
	dw NetGamePractice2Cases2.rally3 ; $6037 jumptable
.rally1:
	ld a, b ; $6039
	jumptable a ; $603a
	dw NetGamePractice2JudgePoint.rally1PointEnd ; $603c jumptable
	dw NetGamePractice2Cases1 ; $603e jumptable
	dw NetGamePractice2Cases1.judgeBounce ; $6040 jumptable
	dw NetGamePractice2Cases1.ignoreNetCross ; $6042 jumptable
.rally1PointEnd:
	ld a, [wPointOutcome] ; $6044
	ld hl, NetGamePractice2Rally1Messages ; $6047
	add_hl_a ; $604a
	ld a, [hl] ; $604f
	ld a, a ; $6050
	ld b, DRILLWORDING_SAME ; $6051
	call SetDrillServerMessage ; $6053
	ld a, [wPointOutcome] ; $6056
	ld hl, OddRallyVerdicts ; $6059
	add_hl_a ; $605c
	ld a, [hl] ; $6061
	ret ; $6062
NetGamePractice2Rally1Messages:
	; $6063, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_DOUBLE_FAULT_YOU_FAIL, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_YOU_DIDNT_HIT_A_LONG_DEEP_SERVE_SO_YOU_FAIL, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED
NetGamePractice2Cases1:
	xor a ; $606d
	ret ; $606e
.judgeBounce:
	ld a, [wBallBounceCount] ; $606f
	cp $01 ; $6072
	ld a, $00 ; $6074
	ret nz ; $6076
	ld a, [wBallTouchedNetFlag] ; $6077
	or a ; $607a
	ld a, $00 ; $607b
	ret nz ; $607d
	ld a, [wPointOutcome] ; $607e
	cp POINTOUTCOME_OUT ; $6081
	ld a, $00 ; $6083
	ret z ; $6085
	ld a, [wPointOutcome] ; $6086
	cp POINTOUTCOME_DOUBLE_FAULT ; $6089
	ld a, $00 ; $608b
	ret z ; $608d
	ld a, DRILLMSG_YOU_DIDNT_HIT_A_LONG_DEEP_SERVE_SO_YOU_FAIL ; $608e
	ld b, DRILLWORDING_SAME ; $6090
	call SetDrillServerMessage ; $6092
	call RecordDrillTargetZoneMiss ; $6095
	call CheckDrillTargetZoneHit ; $6098
	or a ; $609b
	jp z, NetGamePractice2Cases3.pointLost ; $609c
	xor a ; $609f
	ret ; $60a0
.ignoreNetCross:
	xor a ; $60a1
	ret ; $60a2
.rally2:
	ld a, b ; $60a3
	jumptable a ; $60a4
	dw NetGamePractice2Cases1.rally2PointEnd ; $60a6 jumptable
	dw NetGamePractice2Cases2 ; $60a8 jumptable
	dw NetGamePractice2Cases2.ignoreBounce ; $60aa jumptable
	dw NetGamePractice2Cases2.ignoreNetCross ; $60ac jumptable
.rally2PointEnd:
	ld a, [wPointOutcome] ; $60ae
	ld hl, NetGamePractice2Rally2Messages ; $60b1
	add_hl_a ; $60b4
	ld a, [hl] ; $60b9
	ld a, a ; $60ba
	ld b, DRILLWORDING_SAME ; $60bb
	call SetDrillServerMessage ; $60bd
	ld a, [wPointOutcome] ; $60c0
	ld hl, EvenRallyVerdicts ; $60c3
	add_hl_a ; $60c6
	ld a, [hl] ; $60cb
	ret ; $60cc
NetGamePractice2Rally2Messages:
	; $60cd, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED, DRILLMSG_YOU_DIDNT_HIT_A_SMASH_SO_YOU_FAIL_2, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED, DRILLMSG_YOU_DIDNT_HIT_A_SMASH_SO_YOU_FAIL_2
NetGamePractice2Cases2:
	ld a, [wBallBounceCount] ; $60d7
	or a ; $60da
	ret z ; $60db
	ld a, DRILLMSG_I_DIDNT_HIT_A_LOB_SO_YOU_SUCCEED ; $60dc
	ld b, DRILLWORDING_SAME ; $60de
	call SetDrillServerMessage ; $60e0
	ld a, [wCurrentShotType] ; $60e3
	cp SHOTTYPE_LOB ; $60e6
	jp nz, NetGamePractice2Cases3.pointWon ; $60e8
	xor a ; $60eb
	ret ; $60ec
.ignoreBounce:
	xor a ; $60ed
	ret ; $60ee
.ignoreNetCross:
	xor a ; $60ef
	ret ; $60f0
.rally3:
	ld a, b ; $60f1
	jumptable a ; $60f2
	dw NetGamePractice2Cases2.rally3PointEnd ; $60f4 jumptable
	dw NetGamePractice2Cases3 ; $60f6 jumptable
	dw NetGamePractice2Cases3.ignoreBounce ; $60f8 jumptable
	dw NetGamePractice2Cases3.ignoreNetCross ; $60fa jumptable
.rally3PointEnd:
	ld a, [wPointOutcome] ; $60fc
	ld hl, NetGamePractice2Rally3Messages ; $60ff
	add_hl_a ; $6102
	ld a, [hl] ; $6107
	ld a, a ; $6108
	ld b, DRILLWORDING_SAME ; $6109
	call SetDrillServerMessage ; $610b
	ld a, [wPointOutcome] ; $610e
	ld hl, OddRallyVerdicts ; $6111
	add_hl_a ; $6114
	ld a, [hl] ; $6119
	ret ; $611a
NetGamePractice2Rally3Messages:
	; $611b, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_YOU_DIDNT_HIT_A_SMASH_WINNER_SO_YOU_FAIL, DRILLMSG_YOU_DIDNT_HIT_A_SMASH_WINNER_SO_YOU_FAIL, DRILLMSG_NICE_SMASH_YOU_DID_IT, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_NICE_SMASH_YOU_DID_IT
NetGamePractice2Cases3:
	ld a, DRILLMSG_YOU_DIDNT_HIT_A_SMASH_SO_YOU_FAIL_2 ; $6125
	ld b, DRILLWORDING_SAME ; $6127
	call SetDrillServerMessage ; $6129
	ld a, [wCurrentShotType] ; $612c
	cp SHOTTYPE_SMASH ; $612f
	jp nz, .pointLost ; $6131
	ld hl, wDrillCounters + DRILLCTR_SHOTS_LEFT ; $6134
	dec [hl] ; $6137
	xor a ; $6138
	ret ; $6139
.ignoreBounce:
	xor a ; $613a
	ret ; $613b
.ignoreNetCross:
	xor a ; $613c
	ret ; $613d
.pointWon:
	ld a, MATCHABORT_POINT ; $613e
	ld [wMatchAbortFlag], a ; $6140
	ld a, WINLOSE_WIN ; $6143
	ret ; $6145
.pointLost:
	ld a, MATCHABORT_POINT ; $6146
	ld [wMatchAbortFlag], a ; $6148
	ld a, WINLOSE_LOSE ; $614b
	ret ; $614d
