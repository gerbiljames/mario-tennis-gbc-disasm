Unused_0b_StoreMatchAbortFlag_2:
	ld a, MATCHABORT_POINT ; $4c03
	ld [wMatchAbortFlag], a ; $4c05
	ld a, WINLOSE_WIN ; $4c08
	ret ; $4c0a
.storeMatchAbortFlag:
	ld a, MATCHABORT_POINT ; $4c0b
	ld [wMatchAbortFlag], a ; $4c0d
	ld a, WINLOSE_LOSE ; $4c10
	ret ; $4c12
ServiceMatch3Drill:
	; $4c13, 16 bytes
	drill_def CHAR_DRILL_SERVICE_MATCH_3, COURT_TRAINING_MATCH, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_SERVICE_MATCH_3, BGM_DRILL_MATCH, CHAR_STORY_MAIN, ServiceMatch3Hooks, MatchDrillPointTable, $0000
ServiceMatch3Hooks:
	; $4c23, 16 bytes (mode_hooks)
	table_width 2
	dw ServiceMatch3Hook_PerFrame ; MODEHOOK_PER_FRAME
	dw ServiceMatch3Hook_PointStart ; MODEHOOK_POINT_START
	dw ServiceMatch3Hook_PointEnd ; MODEHOOK_POINT_END
	dw RetStub ; MODEHOOK_MINIGAME_START
	dw ServiceMatch3Hook_BallHit ; MODEHOOK_BALL_HIT
	dw ServiceMatch3Hook_Bounce ; MODEHOOK_BOUNCE
	dw ServiceMatch3Hook_RallyTick ; MODEHOOK_RALLY_TICK
	dw RetStub ; MODEHOOK_DRAW
	assert_table_length NUM_MODEHOOKS
ServiceMatch3Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $4c33
	ret ; $4c36
	twin_named service_match1_hook_point_start, ServiceMatch3Hook_PointStart ; $4c37
ServiceMatch3Hook_PointEnd:
	call ServiceMatch3JudgeOnPointEnd ; $4c49
	call ServiceMatch3HandlePointEnd ; $4c4c
	ld a, [wPointWinLoseFlag] ; $4c4f
	ASSERT WINLOSE_NONE == 0
	or a ; $4c52
	ret z ; $4c53
	ld a, [wTotalPointsScoredInCurrentGame] ; $4c54
	bit 0, a ; $4c57
	ret nz ; $4c59
	ld a, [wPlayer1PointsWon] ; $4c5a
	ld b, a ; $4c5d
	ld a, [wPlayer2PointsWon] ; $4c5e
	sub b ; $4c61
	ld b, a ; $4c62
	bit 7, a ; $4c63
	jr z, .compare ; $4c65
	cpl ; $4c67
	inc a ; $4c68
.compare:
	cp $02 ; $4c69
	jr c, .checkTotalPointsScoredInCurrentGame ; $4c6b
	xor a ; $4c6d
	rl b ; $4c6e
	rl a ; $4c70
	or a ; $4c72
	jr nz, .store ; $4c73
	ld a, WINLOSE_LOSE ; $4c75
.store:
	ld [wPointWinLoseFlag], a ; $4c77
	ld a, MATCHABORT_MATCH ; $4c7a
	ld [wMatchAbortFlag], a ; $4c7c
	ret ; $4c7f
.checkTotalPointsScoredInCurrentGame:
	ld a, [wTotalPointsScoredInCurrentGame] ; $4c80
	cp DRILL_MATCH_POINTS ; $4c83
	ret c ; $4c85
	ld a, WINLOSE_NONE ; $4c86
	ld [wPointWinLoseFlag], a ; $4c88
	ret ; $4c8b
ServiceMatch3Hook_RallyTick:
	call ServiceMatch3JudgeOnRallyTick ; $4c8c
	ret ; $4c8f
ServiceMatch3Hook_Bounce:
	call ServiceMatch3JudgeOnBounce ; $4c90
	ret ; $4c93
ServiceMatch3Hook_BallHit:
	call ServiceMatch3JudgeOnBallHit ; $4c94
	ret ; $4c97
ServiceMatch3HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $4c98
	ld a, [wDrillPointJudgement] ; $4c9b
	ld b, a ; $4c9e
	ld a, [wTotalPointsScoredInCurrentGame] ; $4c9f
	bit 0, a ; $4ca2
	ld a, b ; $4ca4
	jr z, .store ; $4ca5
	cpl ; $4ca7
	inc a ; $4ca8
.store:
	ld [wPointWinLoseFlag], a ; $4ca9
	call RecordDrillPointResultBits ; $4cac
	ld a, $00 ; $4caf
	call CountDrillShotSuccesses ; $4cb1
	ld [wDrillCounters + DRILLCTR_P1_SUCCESSES], a ; $4cb4
	ld a, $01 ; $4cb7
	call CountDrillShotSuccesses ; $4cb9
	ld [wDrillCounters + DRILLCTR_P2_SUCCESSES], a ; $4cbc
	call ShowQueuedDrillMessage ; $4cbf
	farcall UpdatePointStats ; $4cc2
	call ServiceMatch3AwardPointToSide ; $4cc5
	ld a, [wDrillCounters + DRILLCTR_P1_SUCCESSES] ; $4cc8
	ld [wPlayer1PointsWon], a ; $4ccb
	ld a, [wDrillCounters + DRILLCTR_P2_SUCCESSES] ; $4cce
	ld [wPlayer2PointsWon], a ; $4cd1
	ld a, [wPlayer1PointsWon] ; $4cd4
	ld b, $01 ; $4cd7
	farcall LoadPlayer1PointsDigitGfx ; $4cd9
	ld a, [wPlayer2PointsWon] ; $4cdc
	ld b, $01 ; $4cdf
	farcall LoadPlayer2PointsDigitGfx ; $4ce1
	farcall StepMatchFrame ; $4ce4
	farcall StartPointEndReactions ; $4ce7
	call PlayDrillPointEndSequence ; $4cea
	ret ; $4ced
	twin_named net_game_match1_award_point_to_side, ServiceMatch3AwardPointToSide ; $4cee
ServiceMatch3JudgeOnPointEnd:
	ld a, JUDGEEVENT_POINT_END ; $4d17
	call ServiceMatch3JudgePoint ; $4d19
	ld [wDrillPointJudgement], a ; $4d1c
	ret ; $4d1f
ServiceMatch3JudgeOnBallHit:
	ld a, JUDGEEVENT_BALL_HIT ; $4d20
	call ServiceMatch3JudgePoint ; $4d22
	ld [wDrillPointJudgement], a ; $4d25
	ret ; $4d28
ServiceMatch3JudgeOnBounce:
	ret ; $4d29
	ld a, JUDGEEVENT_BOUNCE ; $4d2a
	call ServiceMatch3JudgePoint ; $4d2c
	ld [wDrillPointJudgement], a ; $4d2f
	ret ; $4d32
ServiceMatch3JudgeOnRallyTick:
	ret ; $4d33
	ld a, JUDGEEVENT_RALLY_TICK ; $4d34
	call ServiceMatch3JudgePoint ; $4d36
	ld [wDrillPointJudgement], a ; $4d39
	ret ; $4d3c
ServiceMatch3JudgePoint:
	ld b, a ; $4d3d
	ld a, [wDrillPointJudgement] ; $4d3e
	or a ; $4d41
	ret nz ; $4d42
	ld a, [wRallyLength] ; $4d43
	dec a ; $4d46
	jumptable a ; $4d47
	dw ServiceMatch3JudgePoint.rally1 ; $4d49 jumptable
	dw ServiceMatch3Cases1.dispatchResult ; $4d4b jumptable
.rally1:
	ld a, b ; $4d4d
	jumptable a ; $4d4e
	dw ServiceMatch3JudgePoint.result0 ; $4d50 jumptable
	dw ServiceMatch3Cases1 ; $4d52 jumptable
	dw ServiceMatch3Cases1.ignoreBounce ; $4d54 jumptable
	dw ServiceMatch3Cases1.ignoreRallyTick ; $4d56 jumptable
.result0:
	ld a, [wPointOutcome] ; $4d58
	ld hl, ServiceMatch3JudgePointMessages ; $4d5b
	add_hl_a ; $4d5e
	ld a, [hl] ; $4d63
	ld a, a ; $4d64
	ld b, DRILLWORDING_SERVICE ; $4d65
	call QueueDrillResultMessage ; $4d67
	ld a, [wPointOutcome] ; $4d6a
	ld hl, OddRallyVerdicts ; $4d6d
	add_hl_a ; $4d70
	ld a, [hl] ; $4d75
	ret ; $4d76
ServiceMatch3JudgePointMessages:
	; $4d77, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_DOUBLE_FAULT_YOU_FAILED, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_DOUBLE_FAULT_YOU_FAILED, DRILLMSG_SERVICE_ACE_YOU_GET_A_POINT, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_SERVICE_ACE_YOU_GET_A_POINT
ServiceMatch3Cases1:
	xor a ; $4d81
	ret ; $4d82
.ignoreBounce:
	xor a ; $4d83
	ret ; $4d84
.ignoreRallyTick:
	xor a ; $4d85
	ret ; $4d86
.dispatchResult:
	ld a, b ; $4d87
	jumptable a ; $4d88
	dw ServiceMatch3Cases1.checkPointOutcome ; $4d8a jumptable
	dw ServiceMatch3Cases2 ; $4d8c jumptable
	dw ServiceMatch3Cases2.ignoreBounce ; $4d8e jumptable
	dw ServiceMatch3Cases2.ignoreRallyTick ; $4d90 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $4d92
	ld hl, ServiceMatch3Cases1Messages ; $4d95
	add_hl_a ; $4d98
	ld a, [hl] ; $4d9d
	ld a, a ; $4d9e
	ld b, DRILLWORDING_SERVICE ; $4d9f
	call QueueDrillResultMessage ; $4da1
	ld a, [wPointOutcome] ; $4da4
	ld hl, EvenRallyVerdicts ; $4da7
	add_hl_a ; $4daa
	ld a, [hl] ; $4daf
	ret ; $4db0
ServiceMatch3Cases1Messages:
	; $4db1, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_I_RETURNED_THE_SERVE_BEFORE_IT_BOUNCED_SO_YOU_GET, DRILLMSG_I_RETURNED_THE_SERVE_BEFORE_IT_BOUNCED_SO_YOU_GET, DRILLMSG_HIDE
ServiceMatch3Cases2:
	ld a, [wPointOutcome] ; $4dbb
	cp POINTOUTCOME_SERVE_VOLLEYED ; $4dbe
	ld a, $00 ; $4dc0
	ret z ; $4dc2
	ld a, DRILLMSG_I_RETURNED_IT_SO_YOU_FAILED ; $4dc3
	ld b, DRILLWORDING_SERVICE ; $4dc5
	call QueueDrillResultMessage ; $4dc7
	jr Unused_0b_StoreMatchAbortFlag_3.storeMatchAbortFlag ; $4dca
.unreachable:
	xor a ; $4dcc
	ret ; $4dcd
.ignoreBounce:
	xor a ; $4dce
	ret ; $4dcf
.ignoreRallyTick:
	xor a ; $4dd0
	ret ; $4dd1
Unused_0b_StoreMatchAbortFlag_3:
	ld a, MATCHABORT_POINT ; $4dd2
	ld [wMatchAbortFlag], a ; $4dd4
	ld a, WINLOSE_WIN ; $4dd7
	ret ; $4dd9
.storeMatchAbortFlag:
	ld a, MATCHABORT_POINT ; $4dda
	ld [wMatchAbortFlag], a ; $4ddc
	ld a, WINLOSE_LOSE ; $4ddf
	ret ; $4de1
ServicePractice1Drill:
	; $4de2, 16 bytes
	drill_def CHAR_DRILL_SERVICE_PRACTICE_1, COURT_TRAINING_PRACTICE, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_SERVICE_PRACTICE_1, BGM_DRILL_PRACTICE, CHAR_STORY_MAIN, ServicePractice1Hooks, PracticeDrillPointTable, ServicePractice1DrillInit
ServicePractice1DrillInit:
	ld a, $01 ; $4df2
	ld [wDrillIsPracticeLesson], a ; $4df4
	ret ; $4df7
ServicePractice1Hooks:
	; $4df8, 16 bytes (mode_hooks)
	table_width 2
	dw ServicePractice1Hook_PerFrame ; MODEHOOK_PER_FRAME
	dw ServicePractice1Hook_PointStart ; MODEHOOK_POINT_START
	dw ServicePractice1Hook_PointEnd ; MODEHOOK_POINT_END
	dw RetStub ; MODEHOOK_MINIGAME_START
	dw ServicePractice1Hook_BallHit ; MODEHOOK_BALL_HIT
	dw ServicePractice1Hook_Bounce ; MODEHOOK_BOUNCE
	dw ServicePractice1Hook_RallyTick ; MODEHOOK_RALLY_TICK
	dw RetStub ; MODEHOOK_DRAW
	assert_table_length NUM_MODEHOOKS
ServicePractice1Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $4e08
	ret ; $4e0b
ServicePractice1Hook_PointStart:
	xor a ; $4e0c
	ld [wDrillAbortCountdownActive], a ; $4e0d
	ld a, DRILL_ABORT_FRAMES ; $4e10
	ld [wDrillAbortCountdown], a ; $4e12
	ASSERT DRILLMSG_NONE == 0
	xor a ; $4e15
	ld [wDrillMessageId], a ; $4e16
	ld a, $01 ; $4e19
	ld [wTargetZoneEnabled], a ; $4e1b
	ld hl, ServicePractice1PointStartDrillPositions ; $4e1e
	call SetDrillTargetZoneForPoint ; $4e21
	ret ; $4e24
ServicePractice1Hook_PointEnd:
	call ServicePractice1HandlePointEnd ; $4e25
	ld a, [wTotalPointsScoredInCurrentGame] ; $4e28
	cp DRILL_LESSON_POINTS ; $4e2b
	ret c ; $4e2d
	ld a, [wPointWinLoseFlag] ; $4e2e
	ASSERT WINLOSE_NONE == 0
	or a ; $4e31
	ret z ; $4e32
	call ServicePractice1EvaluateResult ; $4e33
	ld [wPointWinLoseFlag], a ; $4e36
	ld a, MATCHABORT_MATCH ; $4e39
	ld [wMatchAbortFlag], a ; $4e3b
	ret ; $4e3e
ServicePractice1EvaluateResult:
	ld a, [wDrillCounters + DRILLCTR_SERVES_SCORED] ; $4e3f
	ld b, a ; $4e42
	ld a, DRILL_LESSON_POINTS ; $4e43
	sub b ; $4e45
	ld b, a ; $4e46
	cp $04 ; $4e47
	jr nz, .checkCharacter1DoubleFaults ; $4e49
	ld a, LESSON_SERVE_NO_POINTS ; $4e4b
	ld [wDrillLessonResult], a ; $4e4d
	jr .lessonFailed ; $4e50
.checkCharacter1DoubleFaults:
	ld a, [wCharacter1DoubleFaults] ; $4e52
	or a ; $4e55
	jr z, .noDoubleFaults ; $4e56
	ld a, LESSON_SERVE_DOUBLE_FAULT ; $4e58
	ld [wDrillLessonResult], a ; $4e5a
	jr .lessonFailed ; $4e5d
.noDoubleFaults:
	ld a, b ; $4e5f
	or a ; $4e60
	jr z, .allPassed ; $4e61
	ld a, LESSON_SERVE_MISSED_TARGET ; $4e63
	ld [wDrillLessonResult], a ; $4e65
	jr .lessonFailed ; $4e68
.lessonFailed:
	ld a, WINLOSE_LOSE ; $4e6a
	ret ; $4e6c
.allPassed:
	ASSERT LESSON_PASSED == 0
	xor a ; $4e6d
	ld [wDrillLessonResult], a ; $4e6e
	ld a, WINLOSE_WIN ; $4e71
	ret ; $4e73
ServicePractice1Hook_RallyTick:
	ret ; $4e74
	twin_named service_practice1_hook_bounce, ServicePractice1Hook_Bounce ; $4e75
Unused_0b_ServeSecondBounceSound_1:
	ld a, [wBallBounceCount] ; $4e7f
	cp $02 ; $4e82
	ret nz ; $4e84
	ld a, [wRallyLength] ; $4e85
	cp $01 ; $4e88
	ret nz ; $4e8a
	sound SFX_BEEP ; $4e8b
	ret ; $4e8d
ServicePractice1Hook_BallHit:
	ld a, [wRallyLength] ; $4e8e
	cp $02 ; $4e91
	jr c, .done ; $4e93
	ld a, $01 ; $4e95
	ld [wDrillAbortCountdownActive], a ; $4e97
	call ResetActiveCharState ; $4e9a
	sound SFX_MENU_SELECT ; $4e9d
.done:
	ret ; $4e9f
ServicePractice1PointStartDrillPositions:
	; $4ea0, 34 bytes (drill_gates)
; drill_gates x1, depth1, x2, depth2
	drill_gates $fe50, $fd60, $ff28, $feb0 ; point 0
	drill_gates $00d8, $fd60, $01b0, $feb0 ; point 1
	drill_gates $00d8, $0150, $01b0, $02a0 ; point 2
	drill_gates $fe50, $0150, $ff28, $02a0 ; point 3
	db $ff, $ff ; end
ServicePractice1HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $4ec2
	call ServicePractice1QueueOutcomeMessage ; $4ec5
	ld [wPointWinLoseFlag], a ; $4ec8
	call RecordDrillPointResultBits ; $4ecb
	ld a, $00 ; $4ece
	call CountDrillShotSuccesses ; $4ed0
	ld [wDrillCounters + DRILLCTR_P1_SUCCESSES], a ; $4ed3
	ld a, $01 ; $4ed6
	call CountDrillShotSuccesses ; $4ed8
	ld [wDrillCounters + DRILLCTR_P2_SUCCESSES], a ; $4edb
	call ShowQueuedDrillMessage ; $4ede
	farcall UpdatePointStats ; $4ee1
	farcall AwardPoint ; $4ee4
	ld a, [wDrillCounters + DRILLCTR_P1_SUCCESSES] ; $4ee7
	ld [wPlayer1PointsWon], a ; $4eea
	xor a ; $4eed
	ld [wPlayer2PointsWon], a ; $4eee
	ld a, [wPlayer1PointsWon] ; $4ef1
	ld b, $01 ; $4ef4
	farcall LoadPlayer1PointsDigitGfx ; $4ef6
	ld a, [wPlayer2PointsWon] ; $4ef9
	ld b, $01 ; $4efc
	farcall LoadPlayer2PointsDigitGfx ; $4efe
	farcall StepMatchFrame ; $4f01
	frame_task SyncPointWinLoseFlagTask ; $4f04
	farcall StartPointEndReactions ; $4f0c
	ld hl, SyncPointWinLoseFlagTask ; $4f0f
	call UnregisterFrameTask ; $4f12
	call PlayDrillPointEndSequence ; $4f15
	ret ; $4f18
Unused_0b_StoreDrillServeTargetResult:
	call CheckDrillTargetZoneHit ; $4f19
	add a ; $4f1c
	dec a ; $4f1d
	ld [wDrillServeTargetResult], a ; $4f1e
	ret ; $4f21
ServicePractice1QueueOutcomeMessage:
	ld a, [wPointOutcome] ; $4f22
	cp POINTOUTCOME_FAULT ; $4f25
	jp z, .hide ; $4f27
	cp POINTOUTCOME_LET ; $4f2a
	jp z, .hide ; $4f2c
	ld a, [wPointOutcome] ; $4f2f
	cp POINTOUTCOME_DOUBLE_FAULT ; $4f32
	jr z, .doubleFault ; $4f34
	ld a, DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL ; $4f36
	ld b, DRILLWORDING_SAME ; $4f38
	call QueueDrillResultMessage ; $4f3a
	call CheckDrillTargetZoneHit ; $4f3d
	or a ; $4f40
	jr z, .missed ; $4f41
	ld a, DRILLMSG_NICE_SERVE_YOU_GET_A_POINT ; $4f43
	ld b, DRILLWORDING_SAME ; $4f45
	call QueueDrillResultMessage ; $4f47
	jr .targetHit ; $4f4a
.doubleFault:
	ld a, DRILLMSG_DOUBLE_FAULT_YOU_FAILED_2 ; $4f4c
	ld b, DRILLWORDING_SAME ; $4f4e
	call QueueDrillResultMessage ; $4f50
	ld a, WINLOSE_LOSE ; $4f53
	ret ; $4f55
.unreachable:
	jr .missed ; $4f56
.targetHit:
	ld hl, wDrillCounters + DRILLCTR_SERVES_SCORED ; $4f58
	inc [hl] ; $4f5b
	ld a, WINLOSE_WIN ; $4f5c
	ret ; $4f5e
.missed:
	ld a, WINLOSE_LOSE ; $4f5f
	ret ; $4f61
.hide:
	ld a, DRILLMSG_HIDE ; $4f62
	ld [wDrillMessageId], a ; $4f64
	xor a ; $4f67
	ret ; $4f68
ServicePractice2Drill:
	; $4f69, 16 bytes
	drill_def CHAR_DRILL_SERVICE_PRACTICE_2, COURT_TRAINING_PRACTICE, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_SERVICE_PRACTICE_2, BGM_DRILL_PRACTICE, CHAR_STORY_MAIN, ServicePractice2Hooks, PracticeDrillPointTable, ServicePractice2DrillInit
ServicePractice2DrillInit:
	ld a, $01 ; $4f79
	ld [wDrillIsPracticeLesson], a ; $4f7b
	ret ; $4f7e
ServicePractice2Hooks:
	; $4f7f, 16 bytes (mode_hooks)
	table_width 2
	dw ServicePractice2Hook_PerFrame ; MODEHOOK_PER_FRAME
	dw ServicePractice2Hook_PointStart ; MODEHOOK_POINT_START
	dw ServicePractice2Hook_PointEnd ; MODEHOOK_POINT_END
	dw ServicePractice2Hook_MinigameStart ; MODEHOOK_MINIGAME_START
	dw ServicePractice2Hook_BallHit ; MODEHOOK_BALL_HIT
	dw ServicePractice2Hook_Bounce ; MODEHOOK_BOUNCE
	dw ServicePractice2Hook_RallyTick ; MODEHOOK_RALLY_TICK
	dw RetStub ; MODEHOOK_DRAW
	assert_table_length NUM_MODEHOOKS
ServicePractice2Hook_MinigameStart:
	ld a, $02 ; $4f8f
	ld [wDrillCounters + DRILLCTR_TOPSPIN_SERVES_LEFT], a ; $4f91
	ld [wDrillCounters + DRILLCTR_SLICE_SERVES_LEFT], a ; $4f94
	ret ; $4f97
ServicePractice2Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $4f98
	ret ; $4f9b
ServicePractice2Hook_PointStart:
	xor a ; $4f9c
	ld [wDrillAbortCountdownActive], a ; $4f9d
	ld a, DRILL_ABORT_FRAMES ; $4fa0
	ld [wDrillAbortCountdown], a ; $4fa2
	ld a, $01 ; $4fa5
	ld [wTargetZoneEnabled], a ; $4fa7
	ld hl, ServicePractice2PointStartDrillPositions ; $4faa
	call SetDrillTargetZoneForPoint ; $4fad
	ASSERT DRILLMSG_NONE == 0
	xor a ; $4fb0
	ld [wDrillMessageId], a ; $4fb1
	ret ; $4fb4
ServicePractice2Hook_PointEnd:
	call ServicePractice2HandlePointEnd ; $4fb5
	ld a, [wTotalPointsScoredInCurrentGame] ; $4fb8
	cp DRILL_LESSON_POINTS ; $4fbb
	ret c ; $4fbd
	ld a, [wPointWinLoseFlag] ; $4fbe
	ASSERT WINLOSE_NONE == 0
	or a ; $4fc1
	ret z ; $4fc2
	call ServicePractice2EvaluateResult ; $4fc3
	ld [wPointWinLoseFlag], a ; $4fc6
	ld a, MATCHABORT_MATCH ; $4fc9
	ld [wMatchAbortFlag], a ; $4fcb
	ret ; $4fce
ServicePractice2EvaluateResult:
	ld a, [wPlayer1PointsWon] ; $4fcf
	or a ; $4fd2
	jr nz, .checkCharacter1DoubleFaults ; $4fd3
	ld a, LESSON_SERVE_NO_POINTS ; $4fd5
	ld [wDrillLessonResult], a ; $4fd7
	jr .lessonFailed ; $4fda
.checkCharacter1DoubleFaults:
	ld a, [wCharacter1DoubleFaults] ; $4fdc
	or a ; $4fdf
	jr z, .countTargetZoneMisses ; $4fe0
	ld a, LESSON_SERVE_DOUBLE_FAULT ; $4fe2
	ld [wDrillLessonResult], a ; $4fe4
	jr .lessonFailed ; $4fe7
.countTargetZoneMisses:
	call CountDrillTargetZoneMisses ; $4fe9
	or a ; $4fec
	jr z, .checkCounter2 ; $4fed
	ld a, LESSON_SERVE_MISSED_TARGET ; $4fef
	ld [wDrillLessonResult], a ; $4ff1
	jr .lessonFailed ; $4ff4
.checkCounter2:
	ld a, [wDrillCounters + DRILLCTR_SLICE_SERVES_LEFT] ; $4ff6
	or a ; $4ff9
	jr z, .checkCounter1 ; $4ffa
	ld a, [wDrillCounters + DRILLCTR_TOPSPIN_SERVES_LEFT] ; $4ffc
	or a ; $4fff
	jr z, .byHandedness ; $5000
	ld a, LESSON_SPIN_NO_SPIN ; $5002
	ld [wDrillLessonResult], a ; $5004
	jr .lessonFailed ; $5007
.byHandedness:
	ld b, LESSON_SPIN_RIGHT_ONLY ; $5009
	ld a, [wStoryMainLeftHanded] ; $500b
	cpl ; $500e
	inc a ; $500f
	add b ; $5010
	ld [wDrillLessonResult], a ; $5011
	jr .lessonFailed ; $5014
.checkCounter1:
	ld a, [wDrillCounters + DRILLCTR_TOPSPIN_SERVES_LEFT] ; $5016
	or a ; $5019
	jr z, .allPassed ; $501a
	ld b, LESSON_SPIN_LEFT_ONLY ; $501c
	ld a, [wStoryMainLeftHanded] ; $501e
	add b ; $5021
	ld [wDrillLessonResult], a ; $5022
	jr .lessonFailed ; $5025
.lessonFailed:
	ld a, WINLOSE_LOSE ; $5027
	ret ; $5029
.allPassed:
	ASSERT LESSON_PASSED == 0
	xor a ; $502a
	ld [wDrillLessonResult], a ; $502b
	ld a, WINLOSE_WIN ; $502e
	ret ; $5030
ServicePractice2Hook_RallyTick:
	ret ; $5031
ServicePractice2Hook_Bounce:
	ld a, [wBallHasBouncedFlag] ; $5032
	or a ; $5035
	ret nz ; $5036
	ld a, [wRallyLength] ; $5037
	cp $01 ; $503a
	ret nz ; $503c
	call RecordDrillTargetZoneMissIfInPlay ; $503d
	ret ; $5040
