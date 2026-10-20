NetGamePractice3Drill:
	; $614e, 16 bytes
	drill_def CHAR_DRILL_NET_GAME_PRACTICE_3, COURT_TRAINING_PRACTICE, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_NET_GAME_PRACTICE_3, BGM_DRILL_PRACTICE, CHAR_STORY_MAIN, NetGamePractice3Hooks, PracticeDrillPointTable, NetGamePractice3DrillInit
NetGamePractice3DrillInit:
	ld a, $01 ; $615e
	ld [wDrillIsPracticeLesson], a ; $6160
	ret ; $6163
NetGamePractice3Hooks:
	; $6164, 16 bytes (mode_hooks)
	table_width 2
	dw NetGamePractice3Hook_PerFrame ; MODEHOOK_PER_FRAME
	dw NetGamePractice3Hook_PointStart ; MODEHOOK_POINT_START
	dw NetGamePractice3Hook_PointEnd ; MODEHOOK_POINT_END
	dw NetGamePractice3Hook_MinigameStart ; MODEHOOK_MINIGAME_START
	dw NetGamePractice3Hook_BallHit ; MODEHOOK_BALL_HIT
	dw NetGamePractice3Hook_Bounce ; MODEHOOK_BOUNCE
	dw NetGamePractice3Hook_RallyTick ; MODEHOOK_RALLY_TICK
	dw RetStub ; MODEHOOK_DRAW
	assert_table_length NUM_MODEHOOKS
	twin_named net_game_practice2_hook_minigame_start, NetGamePractice3Hook_MinigameStart ; $6174
NetGamePractice3Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $6186
	ret ; $6189
NetGamePractice3Hook_PointStart:
	xor a ; $618a
	ld [wDrillAbortCountdownActive], a ; $618b
	ld a, DRILL_ABORT_FRAMES ; $618e
	ld [wDrillAbortCountdown], a ; $6190
	ld a, $01 ; $6193
	ld [wTargetZoneEnabled], a ; $6195
	ld hl, NetGamePractice3PointStartDrillPositions ; $6198
	call SetDrillTargetZoneForPoint ; $619b
	ld a, CHAR_DRILL_NET_GAME_PRACTICE_3 ; $619e
	call LoadDrillOpponentChar ; $61a0
	ASSERT DRILLMSG_NONE == 0
	xor a ; $61a3
	ld [wDrillMessageId], a ; $61a4
	xor a ; $61a7
	ld [wDrillPointJudgement], a ; $61a8
	ret ; $61ab
NetGamePractice3Hook_PointEnd:
	call NetGamePractice3JudgeOnPointEnd ; $61ac
	ld a, [wPointOutcome] ; $61af
	cp POINTOUTCOME_NET ; $61b2
	jr z, .countNetOrOut ; $61b4
	cp POINTOUTCOME_OUT ; $61b6
	jr z, .countNetOrOut ; $61b8
	jr .handlePointEnd ; $61ba
.countNetOrOut:
	ld hl, wDrillCounters + DRILLCTR_NET_OR_OUT ; $61bc
	inc [hl] ; $61bf
.handlePointEnd:
	call NetGamePractice3HandlePointEnd ; $61c0
	ld a, [wTotalPointsScoredInCurrentGame] ; $61c3
	cp DRILL_LESSON_POINTS ; $61c6
	ret c ; $61c8
	call NetGamePractice3EvaluateResult ; $61c9
	ld [wPointWinLoseFlag], a ; $61cc
	ret ; $61cf
NetGamePractice3EvaluateResult:
	ld a, [wDrillCounters + DRILLCTR_PASSES] ; $61d0
	cp DRILL_LESSON_POINTS ; $61d3
	jr nz, .checkCharacter1DoubleFaults ; $61d5
	ASSERT LESSON_PASSED == 0
	xor a ; $61d7
	ld [wDrillLessonResult], a ; $61d8
	ld a, WINLOSE_WIN ; $61db
	ret ; $61dd
.checkCharacter1DoubleFaults:
	ld a, [wCharacter1DoubleFaults] ; $61de
	cp DRILL_LESSON_POINTS ; $61e1
	jr nz, .compare ; $61e3
	ld a, LESSON_NET_ALL_FAULTS ; $61e5
	ld [wDrillLessonResult], a ; $61e7
	jr .lessonFailed ; $61ea
.compare:
	or a ; $61ec
	jr z, .noDoubleFaults ; $61ed
	ld a, LESSON_NET_DOUBLE_FAULT ; $61ef
	ld [wDrillLessonResult], a ; $61f1
	jr .lessonFailed ; $61f4
.noDoubleFaults:
	ld a, [wDrillCounters + DRILLCTR_PASSES] ; $61f6
	cp DRILL_LESSON_POINTS - 1 ; $61f9
	jr nz, .countTargetZoneMisses ; $61fb
	ld a, LESSON_DROP_ALMOST ; $61fd
	ld [wDrillLessonResult], a ; $61ff
	jr .lessonFailed ; $6202
.countTargetZoneMisses:
	call CountDrillTargetZoneMisses ; $6204
	or a ; $6207
	jr z, .checkCounter5 ; $6208
	ld a, LESSON_DROP_SERVE_SHALLOW ; $620a
	ld [wDrillLessonResult], a ; $620c
	jr .lessonFailed ; $620f
.checkCounter5:
	ld a, [wDrillCounters + DRILLCTR_SHOTS_LEFT] ; $6211
	or a ; $6214
	jr nz, .checkCounter4Range ; $6215
	ld a, LESSON_DROP_MISSED ; $6217
	ld [wDrillLessonResult], a ; $6219
	jr .lessonFailed ; $621c
.checkCounter4Range:
	ld a, [wDrillCounters + DRILLCTR_PASSES] ; $621e
	cp $01 ; $6221
	jr c, .result4 ; $6223
	cp $03 ; $6225
	jr nc, .result4 ; $6227
	ld a, LESSON_DROP_TIMING ; $6229
	ld [wDrillLessonResult], a ; $622b
	jr .lessonFailed ; $622e
.result4:
	ld a, LESSON_DROP_NOT_ALL_SIDES ; $6230
	ld [wDrillLessonResult], a ; $6232
	jr .lessonFailed ; $6235
.lessonFailed:
	ld a, WINLOSE_LOSE ; $6237
	ret ; $6239
NetGamePractice3Hook_RallyTick:
	call NetGamePractice3JudgeOnRallyTick ; $623a
	ret ; $623d
NetGamePractice3Hook_Bounce:
	call NetGamePractice3JudgeOnBounce ; $623e
	ret ; $6241
NetGamePractice3Hook_BallHit:
	call NetGamePractice3JudgeOnBallHit ; $6242
	ld a, [wLastShotCharIndex] ; $6245
	cp $01 ; $6248
	jr nz, .done ; $624a
	call ResetActiveCharState ; $624c
.done:
	ret ; $624f
NetGamePractice3PointStartDrillPositions:
	; $6250, 34 bytes (drill_gates)
; drill_gates x1, depth1, x2, depth2
	drill_gates $fe50, $fd60, $0000, $fe40 ; point 0
	drill_gates $0000, $fd60, $01b0, $fe40 ; point 1
	drill_gates $0000, $01c0, $01b0, $02a0 ; point 2
	drill_gates $fe50, $01c0, $0000, $02a0 ; point 3
	db $ff, $ff ; end
	twin_named net_game_practice1_handle_point_end, NetGamePractice3HandlePointEnd ; $6272
NetGamePractice3JudgeOnPointEnd:
	ld a, JUDGEEVENT_POINT_END ; $62c1
	call NetGamePractice3JudgePoint ; $62c3
	ld [wDrillPointJudgement], a ; $62c6
	ret ; $62c9
NetGamePractice3JudgeOnBallHit:
	ld a, JUDGEEVENT_BALL_HIT ; $62ca
	call NetGamePractice3JudgePoint ; $62cc
	ld [wDrillPointJudgement], a ; $62cf
	ret ; $62d2
NetGamePractice3JudgeOnBounce:
	ld a, JUDGEEVENT_BOUNCE ; $62d3
	call NetGamePractice3JudgePoint ; $62d5
	ld [wDrillPointJudgement], a ; $62d8
	ret ; $62db
NetGamePractice3JudgeOnRallyTick:
	ret ; $62dc
	ld a, JUDGEEVENT_RALLY_TICK ; $62dd
	call NetGamePractice3JudgePoint ; $62df
	ld [wDrillPointJudgement], a ; $62e2
	ret ; $62e5
NetGamePractice3JudgePoint:
	ld b, a ; $62e6
	ld a, [wDrillPointJudgement] ; $62e7
	or a ; $62ea
	ret nz ; $62eb
	ld a, [wRallyLength] ; $62ec
	dec a ; $62ef
	jumptable a ; $62f0
	dw NetGamePractice3JudgePoint.rally1 ; $62f2 jumptable
	dw NetGamePractice3Cases1.dispatchResult ; $62f4 jumptable
	dw NetGamePractice3Cases2.dispatchResult ; $62f6 jumptable
.rally1:
	ld a, b ; $62f8
	jumptable a ; $62f9
	dw NetGamePractice3JudgePoint.result0 ; $62fb jumptable
	dw NetGamePractice3Cases1 ; $62fd jumptable
	dw NetGamePractice3Cases1.checkBallBounceCount ; $62ff jumptable
	dw NetGamePractice3Cases1.ignoreRallyTick ; $6301 jumptable
.result0:
	ld a, [wPointOutcome] ; $6303
	ld hl, NetGamePractice3JudgePointMessages ; $6306
	add_hl_a ; $6309
	ld a, [hl] ; $630e
	ld a, a ; $630f
	ld b, DRILLWORDING_SAME ; $6310
	call QueueDrillResultMessage ; $6312
	ld a, [wPointOutcome] ; $6315
	ld hl, OddRallyVerdicts ; $6318
	add_hl_a ; $631b
	ld a, [hl] ; $6320
	ret ; $6321
NetGamePractice3JudgePointMessages:
	; $6322, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_DOUBLE_FAULT_YOU_FAIL, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL_2, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED
NetGamePractice3Cases1:
	xor a ; $632c
	ret ; $632d
.checkBallBounceCount:
	ld a, [wBallBounceCount] ; $632e
	cp $01 ; $6331
	ld a, $00 ; $6333
	ret nz ; $6335
	ld a, [wBallHasBouncedFlag] ; $6336
	or a ; $6339
	ld a, $00 ; $633a
	ret nz ; $633c
	ld a, [wPointOutcome] ; $633d
	cp POINTOUTCOME_OUT ; $6340
	ld a, $00 ; $6342
	ret z ; $6344
	ld a, DRILLMSG_YOU_DIDNT_HIT_A_LONG_DEEP_SERVE_SO_YOU_FAIL ; $6345
	ld b, DRILLWORDING_SAME ; $6347
	call QueueDrillResultMessage ; $6349
	call RecordDrillTargetZoneMiss ; $634c
	call CheckDrillTargetZoneHit ; $634f
	or a ; $6352
	jp z, DrillPointLost_6 ; $6353
	xor a ; $6356
	ret ; $6357
.ignoreRallyTick:
	xor a ; $6358
	ret ; $6359
.dispatchResult:
	ld a, b ; $635a
	jumptable a ; $635b
	dw NetGamePractice3Cases1.checkPointOutcome ; $635d jumptable
	dw NetGamePractice3Cases2 ; $635f jumptable
	dw NetGamePractice3Cases2.ignoreBounce ; $6361 jumptable
	dw NetGamePractice3Cases2.ignoreRallyTick ; $6363 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6365
	ld hl, NetGamePractice3Cases1Messages ; $6368
	add_hl_a ; $636b
	ld a, [hl] ; $6370
	ld a, a ; $6371
	ld b, DRILLWORDING_SAME ; $6372
	call QueueDrillResultMessage ; $6374
	ld a, [wPointOutcome] ; $6377
	ld hl, EvenRallyVerdicts ; $637a
	add_hl_a ; $637d
	ld a, [hl] ; $6382
	ret ; $6383
NetGamePractice3Cases1Messages:
	; $6384, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED, DRILLMSG_YOU_DIDNT_HIT_A_DROP_SHOT_SO_YOU_FAIL, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED, DRILLMSG_I_DIDNT_RETURN_IT_SO_YOU_SUCCEED, DRILLMSG_YOU_DIDNT_HIT_A_DROP_SHOT_SO_YOU_FAIL
NetGamePractice3Cases2:
	xor a ; $638e
	ret ; $638f
.ignoreBounce:
	xor a ; $6390
	ret ; $6391
.ignoreRallyTick:
	xor a ; $6392
	ret ; $6393
.dispatchResult:
	ld a, b ; $6394
	jumptable a ; $6395
	dw NetGamePractice3Cases2.checkPointOutcome ; $6397 jumptable
	dw NetGamePractice3Cases3 ; $6399 jumptable
	dw NetGamePractice3Cases3.ignoreBounce ; $639b jumptable
	dw NetGamePractice3Cases3.ignoreRallyTick ; $639d jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $639f
	ld hl, NetGamePractice3Cases2Messages ; $63a2
	add_hl_a ; $63a5
	ld a, [hl] ; $63aa
	ld a, a ; $63ab
	ld b, DRILLWORDING_SAME ; $63ac
	call QueueDrillResultMessage ; $63ae
	ld a, [wPointOutcome] ; $63b1
	ld hl, OddRallyVerdicts ; $63b4
	add_hl_a ; $63b7
	ld a, [hl] ; $63bc
	ret ; $63bd
NetGamePractice3Cases2Messages:
	; $63be, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_YOU_DIDNT_SCORE_WITH_YOUR_DROP_SHOT_SO_YOU_FAIL, DRILLMSG_YOU_DIDNT_SCORE_WITH_YOUR_DROP_SHOT_SO_YOU_FAIL, DRILLMSG_NICE_DROP_SHOT_YOU_DID_IT, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_NICE_DROP_SHOT_YOU_DID_IT
NetGamePractice3Cases3:
	ld a, DRILLMSG_YOU_DIDNT_HIT_FROM_IN_FRONT_OF_THE_SERVICE_LINE_2 ; $63c8
	ld b, DRILLWORDING_SAME ; $63ca
	call QueueDrillResultMessage ; $63cc
	xor a ; $63cf
	call IsCharNearNet ; $63d0
	or a ; $63d3
	jp z, DrillPointLost_6 ; $63d4
	ld a, DRILLMSG_YOU_DIDNT_HIT_A_DROP_SHOT_SO_YOU_FAIL ; $63d7
	ld b, DRILLWORDING_SAME ; $63d9
	call QueueDrillResultMessage ; $63db
	ld a, [wCurrentShotType] ; $63de
	cp SHOTTYPE_DROP ; $63e1
	jp nz, DrillPointLost_6 ; $63e3
	ld hl, wDrillCounters + DRILLCTR_SHOTS_LEFT ; $63e6
	dec [hl] ; $63e9
	xor a ; $63ea
	ret ; $63eb
.ignoreBounce:
	xor a ; $63ec
	ret ; $63ed
.ignoreRallyTick:
	xor a ; $63ee
	ret ; $63ef
Unused_0b_DrillPointWon_6:
	ld a, MATCHABORT_POINT ; $63f0
	ld [wMatchAbortFlag], a ; $63f2
	ld a, WINLOSE_WIN ; $63f5
	ret ; $63f7
DrillPointLost_6:
	ld a, MATCHABORT_POINT ; $63f8
	ld [wMatchAbortFlag], a ; $63fa
	ld a, WINLOSE_LOSE ; $63fd
	ret ; $63ff
StrokeMatch1Drill:
	; $6400, 16 bytes
	drill_def CHAR_DRILL_STROKE_MATCH_1, COURT_TRAINING_MATCH, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_STROKE_MATCH_1, BGM_DRILL_MATCH, CHAR_STORY_MAIN, StrokeMatch1Hooks, StrokeMatchPointTable, $0000
StrokeMatch1Hooks:
	; $6410, 16 bytes (mode_hooks)
	table_width 2
	dw StrokeMatch1Hook_PerFrame ; MODEHOOK_PER_FRAME
	dw StrokeMatch1Hook_PointStart ; MODEHOOK_POINT_START
	dw StrokeMatch1Hook_PointEnd ; MODEHOOK_POINT_END
	dw StrokeMatch1Hook_MinigameStart ; MODEHOOK_MINIGAME_START
	dw StrokeMatch1Hook_BallHit ; MODEHOOK_BALL_HIT
	dw StrokeMatch1Hook_Bounce ; MODEHOOK_BOUNCE
	dw StrokeMatch1Hook_RallyTick ; MODEHOOK_RALLY_TICK
	dw RetStub ; MODEHOOK_DRAW
	assert_table_length NUM_MODEHOOKS
StrokeMatch1Hook_MinigameStart:
	ld a, SCOREBOARD_POINT_PIPS ; $6420
	ld [wScoreboardLayout], a ; $6422
	ret ; $6425
StrokeMatch1Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $6426
	ret ; $6429
StrokeMatch1Hook_PointStart:
	xor a ; $642a
	ld [wDrillAbortCountdownActive], a ; $642b
	ld a, DRILL_ABORT_FRAMES ; $642e
	ld [wDrillAbortCountdown], a ; $6430
	ASSERT DRILLMSG_NONE == 0
	xor a ; $6433
	ld [wDrillMessageId], a ; $6434
	xor a ; $6437
	ld [wDrillPointJudgement], a ; $6438
	ld a, $01 ; $643b
	ld [wAiServeSkipToss], a ; $643d
	ret ; $6440
StrokeMatch1Hook_PointEnd:
	call StrokeMatch1JudgeOnPointEnd ; $6441
	call StrokeMatch1HandlePointEnd ; $6444
	ld a, [wPlayer1PointsWon] ; $6447
	ld b, a ; $644a
	ld a, [wPlayer2PointsWon] ; $644b
	sub b ; $644e
	ld b, a ; $644f
	bit 7, a ; $6450
	jr z, .compare ; $6452
	cpl ; $6454
	inc a ; $6455
.compare:
	cp $02 ; $6456
	jr c, .checkTotalPointsScoredInCurrentGame ; $6458
	xor a ; $645a
	rl b ; $645b
	rl a ; $645d
	or a ; $645f
	jr nz, .store ; $6460
	ld a, WINLOSE_LOSE ; $6462
.store:
	ld [wPointWinLoseFlag], a ; $6464
	ld a, MATCHABORT_MATCH ; $6467
	ld [wMatchAbortFlag], a ; $6469
	ret ; $646c
.checkTotalPointsScoredInCurrentGame:
	ld a, [wTotalPointsScoredInCurrentGame] ; $646d
	cp DRILL_MATCH_POINTS ; $6470
	ret nz ; $6472
	ASSERT WINLOSE_NONE == 0
	xor a ; $6473
	ld [wPointWinLoseFlag], a ; $6474
	ld a, MATCHABORT_MATCH ; $6477
	ld [wMatchAbortFlag], a ; $6479
	ret ; $647c
StrokeMatch1Hook_RallyTick:
	call StrokeMatch1JudgeOnRallyTick ; $647d
	ret ; $6480
StrokeMatch1Hook_Bounce:
	call StrokeMatch1JudgeOnBounce ; $6481
	ret ; $6484
StrokeMatch1Hook_BallHit:
	call StrokeMatch1JudgeOnBallHit ; $6485
	ret ; $6488
StrokeMatch1HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $6489
	ld a, [wDrillPointJudgement] ; $648c
	ld b, a ; $648f
	ld a, [wTotalPointsScoredInCurrentGame] ; $6490
	bit 0, a ; $6493
	ld a, b ; $6495
	jr z, .store ; $6496
	cpl ; $6498
	inc a ; $6499
.store:
	ld [wPointWinLoseFlag], a ; $649a
	call RecordDrillPointResultBits ; $649d
	call ShowQueuedDrillMessage ; $64a0
	farcall UpdatePointStats ; $64a3
	call StrokeMatch1AwardPointToSide ; $64a6
	ld a, [wPlayer1PointsWon] ; $64a9
	ld b, $01 ; $64ac
	farcall LoadPlayer1PointsDigitGfx ; $64ae
	ld a, [wPlayer2PointsWon] ; $64b1
	ld b, $01 ; $64b4
	farcall LoadPlayer2PointsDigitGfx ; $64b6
	farcall StepMatchFrame ; $64b9
	farcall StartPointEndReactions ; $64bc
	call PlayDrillPointEndSequence ; $64bf
	ret ; $64c2
StrokeMatch1AwardPointToSide:
	ld a, [wPointWinLoseFlag] ; $64c3
	ASSERT WINLOSE_NONE == 0
	or a ; $64c6
	ret z ; $64c7
	inc a ; $64c8
	srl a ; $64c9
	or a ; $64cb
	jr nz, .player1Point ; $64cc
	ld hl, wPlayer2PointsWon ; $64ce
	jr .bump ; $64d1
.player1Point:
	ld hl, wPlayer1PointsWon ; $64d3
.bump:
	inc [hl] ; $64d6
	xor a ; $64d7
	ld [wServeFaultFlag], a ; $64d8
	ld hl, wTotalPointsScoredInCurrentGame ; $64db
	inc [hl] ; $64de
	ret ; $64df
StrokeMatch1JudgeOnPointEnd:
	ld a, JUDGEEVENT_POINT_END ; $64e0
	call StrokeMatch1JudgePoint ; $64e2
	ld [wDrillPointJudgement], a ; $64e5
	ret ; $64e8
StrokeMatch1JudgeOnBallHit:
	ld a, JUDGEEVENT_BALL_HIT ; $64e9
	call StrokeMatch1JudgePoint ; $64eb
	ld [wDrillPointJudgement], a ; $64ee
	ret ; $64f1
StrokeMatch1JudgeOnBounce:
	ld a, JUDGEEVENT_BOUNCE ; $64f2
	call StrokeMatch1JudgePoint ; $64f4
	ld [wDrillPointJudgement], a ; $64f7
	ret ; $64fa
StrokeMatch1JudgeOnRallyTick:
	ret ; $64fb
	ld a, JUDGEEVENT_RALLY_TICK ; $64fc
	call StrokeMatch1JudgePoint ; $64fe
	ld [wDrillPointJudgement], a ; $6501
	ret ; $6504
StrokeMatch1JudgePoint:
	ld b, a ; $6505
	ld a, [wDrillPointJudgement] ; $6506
	or a ; $6509
	ret nz ; $650a
	ld a, [wRallyLength] ; $650b
	dec a ; $650e
	jp z, .branch13 ; $650f
	cp $01 ; $6512
	jp z, StrokeMatch1Cases1.rally2 ; $6514
	and $01 ; $6517
	jp z, StrokeMatch1Cases2.maskClear ; $6519
	jp StrokeMatch1Cases3.dispatchResult ; $651c
.branch13:
	ld a, b ; $651f
	jumptable a ; $6520
	dw StrokeMatch1JudgePoint.rally1 ; $6522 jumptable
	dw StrokeMatch1Cases1 ; $6524 jumptable
	dw StrokeMatch1Cases1.ignoreBounce ; $6526 jumptable
	dw StrokeMatch1Cases1.ignoreRallyTick ; $6528 jumptable
.rally1:
	ld a, [wPointOutcome] ; $652a
	ld hl, StrokeMatch1JudgePointMessages ; $652d
	add_hl_a ; $6530
	ld a, [hl] ; $6535
	ld a, a ; $6536
	ld b, DRILLWORDING_STROKE ; $6537
	call SetDrillMessageByRallyParity ; $6539
	call SelectRallyVerdictsByPointParity ; $653c
	ld a, [wPointOutcome] ; $653f
	add_hl_a ; $6542
	ld a, [hl] ; $6547
	ret ; $6548
StrokeMatch1JudgePointMessages:
	; $6549, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_DOUBLE_FAULT_MY_POINT, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_I_DIDNT_RETURN_IT_YOUR_POINT, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_I_DIDNT_RETURN_IT_YOUR_POINT
StrokeMatch1Cases1:
	xor a ; $6553
	ret ; $6554
.ignoreBounce:
	xor a ; $6555
	ret ; $6556
.ignoreRallyTick:
	xor a ; $6557
	ret ; $6558
.rally2:
	ld a, b ; $6559
	jumptable a ; $655a
	dw StrokeMatch1Cases1.checkPointOutcome ; $655c jumptable
	dw StrokeMatch1Cases2 ; $655e jumptable
	dw StrokeMatch1Cases2.judgeBounce ; $6560 jumptable
	dw StrokeMatch1Cases2.ignoreRallyTick ; $6562 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6564
	ld hl, StrokeMatch1Cases1Messages ; $6567
	add_hl_a ; $656a
	ld a, [hl] ; $656f
	ld a, a ; $6570
	ld b, DRILLWORDING_STROKE ; $6571
	call SetDrillMessageByRallyParity ; $6573
	call SelectRallyVerdictsByPointParityInverted ; $6576
	ld a, [wPointOutcome] ; $6579
	add_hl_a ; $657c
	ld a, [hl] ; $6581
	ret ; $6582
StrokeMatch1Cases1Messages:
	; $6583, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_I_DIDNT_RETURN_IT_YOUR_POINT, DRILLMSG_I_DIDNT_RETURN_IT_YOUR_POINT, DRILLMSG_NICE_STROKE_YOUR_POINT, DRILLMSG_YOU_RETURNED_MY_SERVE_BEFORE_IT_BOUNCED_MY_POINT, DRILLMSG_YOU_RETURNED_MY_SERVE_BEFORE_IT_BOUNCED_MY_POINT, DRILLMSG_I_DIDNT_RETURN_IT_YOUR_POINT
StrokeMatch1Cases2:
	ld a, [wBallBounceCount] ; $658d
	cp $01 ; $6590
	ret nz ; $6592
	ld a, DRILLMSG_YOU_MOVED_PAST_THE_SERVICE_LINE_MY_POINT ; $6593
	ld b, DRILLWORDING_STROKE ; $6595
	call SetDrillMessageByRallyParity ; $6597
	ld a, [wLastShotCharIndex] ; $659a
	call IsCharNearNet ; $659d
	jp nz, StrokeMatch1Cases4.abortLose ; $65a0
	xor a ; $65a3
	ret ; $65a4
.judgeBounce:
	ld a, [wPointOutcome] ; $65a5
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $65a8
	ld a, $00 ; $65aa
	ret z ; $65ac
	ld a, DRILLMSG_YOUR_BALL_DIDNT_LAND_PAST_MY_SERVICE_LINE_MY_POINT ; $65ad
	ld b, DRILLWORDING_STROKE ; $65af
	call SetDrillMessageByRallyParity ; $65b1
	call TestBallBounceDepth ; $65b4
	or a ; $65b7
	jp z, StrokeMatch1Cases4.abortLose ; $65b8
	xor a ; $65bb
	ret ; $65bc
.ignoreRallyTick:
	xor a ; $65bd
	ret ; $65be
.maskClear:
	ld a, b ; $65bf
	jumptable a ; $65c0
	dw StrokeMatch1Cases2.queuePointOutcomeMessage ; $65c2 jumptable
	dw StrokeMatch1Cases3 ; $65c4 jumptable
	dw StrokeMatch1Cases3.judgeBounce ; $65c6 jumptable
	dw StrokeMatch1Cases3.ignoreRallyTick ; $65c8 jumptable
.queuePointOutcomeMessage:
	ld a, [wPointOutcome] ; $65ca
	ld hl, StrokeMatch1Cases2Messages ; $65cd
	add_hl_a ; $65d0
	ld a, [hl] ; $65d5
	ld a, a ; $65d6
	ld b, DRILLWORDING_STROKE ; $65d7
	call SetDrillMessageByRallyParity ; $65d9
	call SelectRallyVerdictsByPointParity ; $65dc
	ld a, [wPointOutcome] ; $65df
	add_hl_a ; $65e2
	ld a, [hl] ; $65e7
	ret ; $65e8
StrokeMatch1Cases2Messages:
	; $65e9, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_YOU_DIDNT_RETURN_IT_TO_MY_COURT_SO_MY_POINT, DRILLMSG_YOU_DIDNT_RETURN_IT_TO_MY_COURT_SO_MY_POINT, DRILLMSG_NICE_STROKE_YOUR_POINT, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_I_DIDNT_RETURN_IT_YOUR_POINT
StrokeMatch1Cases3:
	ld a, DRILLMSG_YOU_MOVED_PAST_THE_SERVICE_LINE_MY_POINT ; $65f3
	ld b, DRILLWORDING_STROKE ; $65f5
	call SetDrillMessageByRallyParity ; $65f7
	ld a, [wLastShotCharIndex] ; $65fa
	call IsCharNearNet ; $65fd
	jp nz, StrokeMatch1Cases4.abortWin ; $6600
	xor a ; $6603
	ret ; $6604
.judgeBounce:
	ld a, [wPointOutcome] ; $6605
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $6608
	ld a, $00 ; $660a
	ret z ; $660c
	ld a, DRILLMSG_YOUR_BALL_DIDNT_LAND_PAST_MY_SERVICE_LINE_MY_POINT ; $660d
	ld b, DRILLWORDING_STROKE ; $660f
	call SetDrillMessageByRallyParity ; $6611
	call TestBallBounceDepth ; $6614
	or a ; $6617
	jp z, StrokeMatch1Cases4.abortWin ; $6618
	xor a ; $661b
	ret ; $661c
.ignoreRallyTick:
	xor a ; $661d
	ret ; $661e
.dispatchResult:
	ld a, b ; $661f
	jumptable a ; $6620
	dw StrokeMatch1Cases3.queuePointOutcomeMessage ; $6622 jumptable
	dw StrokeMatch1Cases4 ; $6624 jumptable
	dw StrokeMatch1Cases4.checkPointOutcome ; $6626 jumptable
	dw StrokeMatch1Cases4.ignoreRallyTick ; $6628 jumptable
.queuePointOutcomeMessage:
	ld a, [wPointOutcome] ; $662a
	ld hl, StrokeMatch1Cases3Messages ; $662d
	add_hl_a ; $6630
	ld a, [hl] ; $6635
	ld a, a ; $6636
	ld b, DRILLWORDING_STROKE ; $6637
	call SetDrillMessageByRallyParity ; $6639
	call SelectRallyVerdictsByPointParityInverted ; $663c
	ld a, [wPointOutcome] ; $663f
	add_hl_a ; $6642
	ld a, [hl] ; $6647
	ret ; $6648
StrokeMatch1Cases3Messages:
	; $6649, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_YOU_DIDNT_RETURN_IT_TO_MY_COURT_SO_MY_POINT, DRILLMSG_YOU_DIDNT_RETURN_IT_TO_MY_COURT_SO_MY_POINT, DRILLMSG_NICE_STROKE_YOUR_POINT, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_I_DIDNT_RETURN_IT_YOUR_POINT
StrokeMatch1Cases4:
	ld a, DRILLMSG_YOU_MOVED_PAST_THE_SERVICE_LINE_MY_POINT ; $6653
	ld b, DRILLWORDING_STROKE ; $6655
	call SetDrillMessageByRallyParity ; $6657
	ld a, [wLastShotCharIndex] ; $665a
	call IsCharNearNet ; $665d
	jp nz, .abortLose ; $6660
	xor a ; $6663
	ret ; $6664
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6665
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $6668
	ld a, $00 ; $666a
	ret z ; $666c
	ld a, DRILLMSG_YOUR_BALL_DIDNT_LAND_PAST_MY_SERVICE_LINE_MY_POINT ; $666d
	ld b, DRILLWORDING_STROKE ; $666f
	call SetDrillMessageByRallyParity ; $6671
	call TestBallBounceDepth ; $6674
	or a ; $6677
	jp z, .abortLose ; $6678
	xor a ; $667b
	ret ; $667c
.ignoreRallyTick:
	xor a ; $667d
	ret ; $667e
.abortWin:
	ld a, MATCHABORT_POINT ; $667f
	ld [wMatchAbortFlag], a ; $6681
	ld a, WINLOSE_WIN ; $6684
	ret ; $6686
.abortLose:
	ld a, MATCHABORT_POINT ; $6687
	ld [wMatchAbortFlag], a ; $6689
	ld a, WINLOSE_LOSE ; $668c
	ret ; $668e
SelectRallyVerdictsByPointParity:
	ld a, [wTotalPointsScoredInCurrentGame] ; $668f
	and $01 ; $6692
	ld a, $00 ; $6694
	or a ; $6696
	jr nz, .oddVerdicts ; $6697
	ld hl, EvenRallyVerdicts ; $6699
	jr .done ; $669c
.oddVerdicts:
	ld hl, OddRallyVerdicts ; $669e
.done:
	ret ; $66a1
SelectRallyVerdictsByPointParityInverted:
	ld a, [wTotalPointsScoredInCurrentGame] ; $66a2
	and $01 ; $66a5
	ld a, $00 ; $66a7
	or a ; $66a9
	jr nz, .evenVerdicts ; $66aa
	ld hl, OddRallyVerdicts ; $66ac
	jr .done ; $66af
.evenVerdicts:
	ld hl, EvenRallyVerdicts ; $66b1
.done:
	ret ; $66b4
