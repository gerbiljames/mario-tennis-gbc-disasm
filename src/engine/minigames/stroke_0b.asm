NetGamePractice3Drill:
	; $614e, 16 bytes
	drill_def CHAR_DRILL_NET_GAME_PRACTICE_3, COURT_TRAINING_PRACTICE, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_NET_GAME_PRACTICE_3, BGM_DRILL_PRACTICE, CHAR_STORY_MAIN, NetGamePractice3Hooks, PracticeDrillPointTable, NetGamePractice3DrillInit
NetGamePractice3DrillInit:
	ld a, $01 ; $615e
	ld [wDrillIsPracticeLesson], a ; $6160
	ret ; $6163
NetGamePractice3Hooks:
	; $6164, 16 bytes (mode_hooks)
	dw NetGamePractice3Hook_PerFrame ; record 0
	dw NetGamePractice3Hook_PointStart ; record 1
	dw NetGamePractice3Hook_PointEnd ; record 2
	dw NetGamePractice3Hook_MinigameStart ; record 3
	dw NetGamePractice3Hook_BallHit ; record 4
	dw NetGamePractice3Hook_Bounce ; record 5
	dw NetGamePractice3Hook_RallyTick ; record 6
	dw RetStub ; record 7
NetGamePractice3Hook_MinigameStart:
	xor a ; $6174
	ld [wDrillCounters + 3], a ; $6175
	ld [wDrillCounters + 4], a ; $6178
	ld a, $04 ; $617b
	ld [wDrillCounters + 5], a ; $617d
	ld a, $01 ; $6180
	ld [wDrillIsPracticeLesson], a ; $6182
	ret ; $6185
NetGamePractice3Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $6186
	ret ; $6189
NetGamePractice3Hook_PointStart:
	xor a ; $618a
	ld [wDrillAbortCountdownActive], a ; $618b
	ld a, $0a ; $618e
	ld [wDrillAbortCountdown], a ; $6190
	ld a, $01 ; $6193
	ld [wTargetZoneEnabled], a ; $6195
	ld hl, NetGamePractice3PointStartDrillPositions ; $6198
	call SetDrillTargetZoneForPoint ; $619b
	ld a, CHAR_DRILL_NET_GAME_PRACTICE_3 ; $619e
	call LoadDrillOpponentChar ; $61a0
	xor a ; $61a3
	ld [wDrillMessageId], a ; $61a4
	xor a ; $61a7
	ld [wDrillPointJudgement], a ; $61a8
	ret ; $61ab
NetGamePractice3Hook_PointEnd:
	call NetGamePractice3JudgeOnPointEnd ; $61ac
	ld a, [wPointOutcome] ; $61af
	cp POINTOUTCOME_NET ; $61b2
	jr z, .netGamePractice3HandlePointEnd2 ; $61b4
	cp POINTOUTCOME_OUT ; $61b6
	jr z, .netGamePractice3HandlePointEnd2 ; $61b8
	jr .netGamePractice3HandlePointEnd ; $61ba
.netGamePractice3HandlePointEnd2:
	ld hl, wDrillCounters + 3 ; $61bc
	inc [hl] ; $61bf
.netGamePractice3HandlePointEnd:
	call NetGamePractice3HandlePointEnd ; $61c0
	ld a, [wTotalPointsScoredInCurrentGame] ; $61c3
	cp $04 ; $61c6
	ret c ; $61c8
	call NetGamePractice3EvaluateResult ; $61c9
	ld [wPointWinLoseFlag], a ; $61cc
	ret ; $61cf
NetGamePractice3EvaluateResult:
	ld a, [wDrillCounters + 4] ; $61d0
	cp $04 ; $61d3
	jr nz, .checkCharacter1DoubleFaults ; $61d5
	xor a ; $61d7
	ld [wDrillLessonResult], a ; $61d8
	ld a, $01 ; $61db
	ret ; $61dd
.checkCharacter1DoubleFaults:
	ld a, [wCharacter1DoubleFaults] ; $61de
	cp $04 ; $61e1
	jr nz, .compare ; $61e3
	ld a, $01 ; $61e5
	ld [wDrillLessonResult], a ; $61e7
	jr .notFound ; $61ea
.compare:
	or a ; $61ec
	jr z, .zero ; $61ed
	ld a, $02 ; $61ef
	ld [wDrillLessonResult], a ; $61f1
	jr .notFound ; $61f4
.zero:
	ld a, [wDrillCounters + 4] ; $61f6
	cp $03 ; $61f9
	jr nz, .countDrillResultBitsSet ; $61fb
	ld a, $07 ; $61fd
	ld [wDrillLessonResult], a ; $61ff
	jr .notFound ; $6202
.countDrillResultBitsSet:
	call CountDrillResultBitsSet ; $6204
	or a ; $6207
	jr z, .zero2 ; $6208
	ld a, $03 ; $620a
	ld [wDrillLessonResult], a ; $620c
	jr .notFound ; $620f
.zero2:
	ld a, [wDrillCounters + 5] ; $6211
	or a ; $6214
	jr nz, .nonZero ; $6215
	ld a, $06 ; $6217
	ld [wDrillLessonResult], a ; $6219
	jr .notFound ; $621c
.nonZero:
	ld a, [wDrillCounters + 4] ; $621e
	cp $01 ; $6221
	jr c, .step4 ; $6223
	cp $03 ; $6225
	jr nc, .step4 ; $6227
	ld a, $05 ; $6229
	ld [wDrillLessonResult], a ; $622b
	jr .notFound ; $622e
.step4:
	ld a, $04 ; $6230
	ld [wDrillLessonResult], a ; $6232
	jr .notFound ; $6235
.notFound:
	ld a, $ff ; $6237
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
; Instruction-identical to NetGamePractice1HandlePointEnd and NetGamePractice2HandlePointEnd (in this bank); a change here belongs in every copy.
	twin_named net_game_practice1_handle_point_end, NetGamePractice3HandlePointEnd ; $6272
NetGamePractice3JudgeOnPointEnd:
	ld a, $00 ; $62c1
	call NetGamePractice3JudgePoint ; $62c3
	ld [wDrillPointJudgement], a ; $62c6
	ret ; $62c9
NetGamePractice3JudgeOnBallHit:
	ld a, $01 ; $62ca
	call NetGamePractice3JudgePoint ; $62cc
	ld [wDrillPointJudgement], a ; $62cf
	ret ; $62d2
NetGamePractice3JudgeOnBounce:
	ld a, $02 ; $62d3
	call NetGamePractice3JudgePoint ; $62d5
	ld [wDrillPointJudgement], a ; $62d8
	ret ; $62db
NetGamePractice3JudgeOnRallyTick:
	ret ; $62dc
	ld a, $03 ; $62dd
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
	ld a, a ; $62f0
	rst Rst00 ; $62f1
	dw NetGamePractice3JudgePoint.rally1 ; $62f2 jumptable
	dw NetGamePractice3Cases1.dispatchResult ; $62f4 jumptable
	dw NetGamePractice3Cases2.dispatchResult ; $62f6 jumptable
.rally1:
	ld a, b ; $62f8
	ld a, a ; $62f9
	rst Rst00 ; $62fa
	dw NetGamePractice3JudgePoint.result0 ; $62fb jumptable
	dw NetGamePractice3Cases1 ; $62fd jumptable
	dw NetGamePractice3Cases1.checkBallBounceCount ; $62ff jumptable
	dw NetGamePractice3Cases1.returnZero ; $6301 jumptable
.result0:
	ld a, [wPointOutcome] ; $6303
	ld hl, NetGamePractice3JudgePointDrillShotTable ; $6306
	add l ; $6309
	ld l, a ; $630a
	jr nc, .readEntry1 ; $630b
	inc h ; $630d
.readEntry1:
	ld a, [hl] ; $630e
	ld a, a ; $630f
	ld b, $00 ; $6310
	call QueueDrillResultMessage ; $6312
	ld a, [wPointOutcome] ; $6315
	ld hl, SignedTable_0b_00 ; $6318
	add l ; $631b
	ld l, a ; $631c
	jr nc, .readEntry2 ; $631d
	inc h ; $631f
.readEntry2:
	ld a, [hl] ; $6320
	ret ; $6321
NetGamePractice3JudgePointDrillShotTable:
	; $6322, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $33, $ff, $ff, $38, $31, $ff, $ff, $31
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
	ld a, $3b ; $6345
	ld b, $00 ; $6347
	call QueueDrillResultMessage ; $6349
	call RecordDrillTargetZoneHit ; $634c
	call CheckDrillTargetZoneMissed ; $634f
	or a ; $6352
	jp z, UnusedStoreMatchAbortFlag_6.storeMatchAbortFlag ; $6353
	xor a ; $6356
	ret ; $6357
.returnZero:
	xor a ; $6358
	ret ; $6359
.dispatchResult:
	ld a, b ; $635a
	ld a, a ; $635b
	rst Rst00 ; $635c
	dw NetGamePractice3Cases1.checkPointOutcome ; $635d jumptable
	dw NetGamePractice3Cases2 ; $635f jumptable
	dw NetGamePractice3Cases2.returnZero ; $6361 jumptable
	dw NetGamePractice3Cases2.returnZero2 ; $6363 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6365
	ld hl, NetGamePractice3Cases1DrillShotTable ; $6368
	add l ; $636b
	ld l, a ; $636c
	jr nc, .read ; $636d
	inc h ; $636f
.read:
	ld a, [hl] ; $6370
	ld a, a ; $6371
	ld b, $00 ; $6372
	call QueueDrillResultMessage ; $6374
	ld a, [wPointOutcome] ; $6377
	ld hl, SignedTable_0b_01 ; $637a
	add l ; $637d
	ld l, a ; $637e
	jr nc, .readB ; $637f
	inc h ; $6381
.readB:
	ld a, [hl] ; $6382
	ret ; $6383
NetGamePractice3Cases1DrillShotTable:
	; $6384, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $31, $31, $39, $31, $31, $39
NetGamePractice3Cases2:
	xor a ; $638e
	ret ; $638f
.returnZero:
	xor a ; $6390
	ret ; $6391
.returnZero2:
	xor a ; $6392
	ret ; $6393
.dispatchResult:
	ld a, b ; $6394
	ld a, a ; $6395
	rst Rst00 ; $6396
	dw NetGamePractice3Cases2.checkPointOutcome ; $6397 jumptable
	dw NetGamePractice3Cases3 ; $6399 jumptable
	dw NetGamePractice3Cases3.returnZero ; $639b jumptable
	dw NetGamePractice3Cases3.storeMatchAbortFlag2 ; $639d jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $639f
	ld hl, NetGamePractice3Cases2DrillShotTable ; $63a2
	add l ; $63a5
	ld l, a ; $63a6
	jr nc, .read ; $63a7
	inc h ; $63a9
.read:
	ld a, [hl] ; $63aa
	ld a, a ; $63ab
	ld b, $00 ; $63ac
	call QueueDrillResultMessage ; $63ae
	ld a, [wPointOutcome] ; $63b1
	ld hl, SignedTable_0b_00 ; $63b4
	add l ; $63b7
	ld l, a ; $63b8
	jr nc, .readB ; $63b9
	inc h ; $63bb
.readB:
	ld a, [hl] ; $63bc
	ret ; $63bd
NetGamePractice3Cases2DrillShotTable:
	; $63be, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $3c, $3c, $30, $ff, $ff, $30
NetGamePractice3Cases3:
	ld a, $35 ; $63c8
	ld b, $00 ; $63ca
	call QueueDrillResultMessage ; $63cc
	xor a ; $63cf
	call TestCharStateBit4 ; $63d0
	or a ; $63d3
	jp z, UnusedStoreMatchAbortFlag_6.storeMatchAbortFlag ; $63d4
	ld a, $39 ; $63d7
	ld b, $00 ; $63d9
	call QueueDrillResultMessage ; $63db
	ld a, [wCurrentShotType] ; $63de
	cp SHOTTYPE_DROP ; $63e1
	jp nz, UnusedStoreMatchAbortFlag_6.storeMatchAbortFlag ; $63e3
	ld hl, wDrillCounters + 5 ; $63e6
	dec [hl] ; $63e9
	xor a ; $63ea
	ret ; $63eb
.returnZero:
	xor a ; $63ec
	ret ; $63ed
.storeMatchAbortFlag2:
	xor a ; $63ee
	ret ; $63ef
UnusedStoreMatchAbortFlag_6:
	ld a, MATCHABORT_POINT ; $63f0
	ld [wMatchAbortFlag], a ; $63f2
	ld a, $01 ; $63f5
	ret ; $63f7
.storeMatchAbortFlag:
	ld a, MATCHABORT_POINT ; $63f8
	ld [wMatchAbortFlag], a ; $63fa
	ld a, $ff ; $63fd
	ret ; $63ff
StrokeMatch1Drill:
	; $6400, 16 bytes
	drill_def CHAR_DRILL_STROKE_MATCH_1, COURT_TRAINING_MATCH, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_STROKE_MATCH_1, BGM_DRILL_MATCH, CHAR_STORY_MAIN, StrokeMatch1Hooks, StrokeMatchPointTable, $0000
StrokeMatch1Hooks:
	; $6410, 16 bytes (mode_hooks)
	dw StrokeMatch1Hook_PerFrame ; record 0
	dw StrokeMatch1Hook_PointStart ; record 1
	dw StrokeMatch1Hook_PointEnd ; record 2
	dw StrokeMatch1Hook_MinigameStart ; record 3
	dw StrokeMatch1Hook_BallHit ; record 4
	dw StrokeMatch1Hook_Bounce ; record 5
	dw StrokeMatch1Hook_RallyTick ; record 6
	dw RetStub ; record 7
StrokeMatch1Hook_MinigameStart:
	ld a, $05 ; $6420
	ld [wScoreboardLayout], a ; $6422
	ret ; $6425
StrokeMatch1Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $6426
	ret ; $6429
StrokeMatch1Hook_PointStart:
	xor a ; $642a
	ld [wDrillAbortCountdownActive], a ; $642b
	ld a, $0a ; $642e
	ld [wDrillAbortCountdown], a ; $6430
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
	cp $08 ; $6470
	ret nz ; $6472
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
	or a ; $64c6
	ret z ; $64c7
	inc a ; $64c8
	srl a ; $64c9
	or a ; $64cb
	jr nz, .nonZero ; $64cc
	ld hl, wPlayer2PointsWon ; $64ce
	jr .bump ; $64d1
.nonZero:
	ld hl, wPlayer1PointsWon ; $64d3
.bump:
	inc [hl] ; $64d6
	xor a ; $64d7
	ld [wServeFaultFlag], a ; $64d8
	ld hl, wTotalPointsScoredInCurrentGame ; $64db
	inc [hl] ; $64de
	ret ; $64df
StrokeMatch1JudgeOnPointEnd:
	ld a, $00 ; $64e0
	call StrokeMatch1JudgePoint ; $64e2
	ld [wDrillPointJudgement], a ; $64e5
	ret ; $64e8
StrokeMatch1JudgeOnBallHit:
	ld a, $01 ; $64e9
	call StrokeMatch1JudgePoint ; $64eb
	ld [wDrillPointJudgement], a ; $64ee
	ret ; $64f1
StrokeMatch1JudgeOnBounce:
	ld a, $02 ; $64f2
	call StrokeMatch1JudgePoint ; $64f4
	ld [wDrillPointJudgement], a ; $64f7
	ret ; $64fa
StrokeMatch1JudgeOnRallyTick:
	ret ; $64fb
	ld a, $03 ; $64fc
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
	jp z, StrokeMatch1Cases1.eq01 ; $6514
	and $01 ; $6517
	jp z, StrokeMatch1Cases2.maskClear ; $6519
	jp StrokeMatch1Cases3.dispatchResult ; $651c
.branch13:
	ld a, b ; $651f
	ld a, a ; $6520
	rst Rst00 ; $6521
	dw StrokeMatch1JudgePoint.rally1 ; $6522 jumptable
	dw StrokeMatch1Cases1 ; $6524 jumptable
	dw StrokeMatch1Cases1.returnZero ; $6526 jumptable
	dw StrokeMatch1Cases1.returnZero2 ; $6528 jumptable
.rally1:
	ld a, [wPointOutcome] ; $652a
	ld hl, StrokeMatch1JudgePointDrillShotTable ; $652d
	add l ; $6530
	ld l, a ; $6531
	jr nc, .readEntry1 ; $6532
	inc h ; $6534
.readEntry1:
	ld a, [hl] ; $6535
	ld a, a ; $6536
	ld b, $07 ; $6537
	call SetDrillMessageByRallyParity ; $6539
	call SelectStrokeTargetTableByPoint ; $653c
	ld a, [wPointOutcome] ; $653f
	add l ; $6542
	ld l, a ; $6543
	jr nc, .readEntry2 ; $6544
	inc h ; $6546
.readEntry2:
	ld a, [hl] ; $6547
	ret ; $6548
StrokeMatch1JudgePointDrillShotTable:
	; $6549, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $63, $ff, $ff, $ff, $60, $ff, $ff, $60
StrokeMatch1Cases1:
	xor a ; $6553
	ret ; $6554
.returnZero:
	xor a ; $6555
	ret ; $6556
.returnZero2:
	xor a ; $6557
	ret ; $6558
.eq01:
	ld a, b ; $6559
	ld a, a ; $655a
	rst Rst00 ; $655b
	dw StrokeMatch1Cases1.checkPointOutcome ; $655c jumptable
	dw StrokeMatch1Cases2 ; $655e jumptable
	dw StrokeMatch1Cases2.checkPointOutcome ; $6560 jumptable
	dw StrokeMatch1Cases2.returnZero ; $6562 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6564
	ld hl, StrokeMatch1Cases1DrillShotTable ; $6567
	add l ; $656a
	ld l, a ; $656b
	jr nc, .read ; $656c
	inc h ; $656e
.read:
	ld a, [hl] ; $656f
	ld a, a ; $6570
	ld b, $07 ; $6571
	call SetDrillMessageByRallyParity ; $6573
	call SelectStrokeTargetTableByPointAlt ; $6576
	ld a, [wPointOutcome] ; $6579
	add l ; $657c
	ld l, a ; $657d
	jr nc, .readB ; $657e
	inc h ; $6580
.readB:
	ld a, [hl] ; $6581
	ret ; $6582
StrokeMatch1Cases1DrillShotTable:
	; $6583, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $60, $60, $5e, $64, $64, $60
StrokeMatch1Cases2:
	ld a, [wBallBounceCount] ; $658d
	cp $01 ; $6590
	ret nz ; $6592
	ld a, $62 ; $6593
	ld b, $07 ; $6595
	call SetDrillMessageByRallyParity ; $6597
	ld a, [wLastShotCharIndex] ; $659a
	call TestCharStateBit4 ; $659d
	jp nz, StrokeMatch1Cases4.storeMatchAbortFlag2 ; $65a0
	xor a ; $65a3
	ret ; $65a4
.checkPointOutcome:
	ld a, [wPointOutcome] ; $65a5
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $65a8
	ld a, $00 ; $65aa
	ret z ; $65ac
	ld a, $61 ; $65ad
	ld b, $07 ; $65af
	call SetDrillMessageByRallyParity ; $65b1
	call TestBallBounceDepth ; $65b4
	or a ; $65b7
	jp z, StrokeMatch1Cases4.storeMatchAbortFlag2 ; $65b8
	xor a ; $65bb
	ret ; $65bc
.returnZero:
	xor a ; $65bd
	ret ; $65be
.maskClear:
	ld a, b ; $65bf
	ld a, a ; $65c0
	rst Rst00 ; $65c1
	dw StrokeMatch1Cases2.checkPointOutcome2 ; $65c2 jumptable
	dw StrokeMatch1Cases3 ; $65c4 jumptable
	dw StrokeMatch1Cases3.checkPointOutcome ; $65c6 jumptable
	dw StrokeMatch1Cases3.returnZero ; $65c8 jumptable
.checkPointOutcome2:
	ld a, [wPointOutcome] ; $65ca
	ld hl, StrokeMatch1Cases2DrillShotTable ; $65cd
	add l ; $65d0
	ld l, a ; $65d1
	jr nc, .read ; $65d2
	inc h ; $65d4
.read:
	ld a, [hl] ; $65d5
	ld a, a ; $65d6
	ld b, $07 ; $65d7
	call SetDrillMessageByRallyParity ; $65d9
	call SelectStrokeTargetTableByPoint ; $65dc
	ld a, [wPointOutcome] ; $65df
	add l ; $65e2
	ld l, a ; $65e3
	jr nc, .readB ; $65e4
	inc h ; $65e6
.readB:
	ld a, [hl] ; $65e7
	ret ; $65e8
StrokeMatch1Cases2DrillShotTable:
	; $65e9, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $5f, $5f, $5e, $ff, $ff, $60
StrokeMatch1Cases3:
	ld a, $62 ; $65f3
	ld b, $07 ; $65f5
	call SetDrillMessageByRallyParity ; $65f7
	ld a, [wLastShotCharIndex] ; $65fa
	call TestCharStateBit4 ; $65fd
	jp nz, StrokeMatch1Cases4.storeMatchAbortFlag ; $6600
	xor a ; $6603
	ret ; $6604
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6605
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $6608
	ld a, $00 ; $660a
	ret z ; $660c
	ld a, $61 ; $660d
	ld b, $07 ; $660f
	call SetDrillMessageByRallyParity ; $6611
	call TestBallBounceDepth ; $6614
	or a ; $6617
	jp z, StrokeMatch1Cases4.storeMatchAbortFlag ; $6618
	xor a ; $661b
	ret ; $661c
.returnZero:
	xor a ; $661d
	ret ; $661e
.dispatchResult:
	ld a, b ; $661f
	ld a, a ; $6620
	rst Rst00 ; $6621
	dw StrokeMatch1Cases3.checkPointOutcome2 ; $6622 jumptable
	dw StrokeMatch1Cases4 ; $6624 jumptable
	dw StrokeMatch1Cases4.checkPointOutcome ; $6626 jumptable
	dw StrokeMatch1Cases4.storeMatchAbortFlag3 ; $6628 jumptable
.checkPointOutcome2:
	ld a, [wPointOutcome] ; $662a
	ld hl, StrokeMatch1Cases3DrillShotTable ; $662d
	add l ; $6630
	ld l, a ; $6631
	jr nc, .read ; $6632
	inc h ; $6634
.read:
	ld a, [hl] ; $6635
	ld a, a ; $6636
	ld b, $07 ; $6637
	call SetDrillMessageByRallyParity ; $6639
	call SelectStrokeTargetTableByPointAlt ; $663c
	ld a, [wPointOutcome] ; $663f
	add l ; $6642
	ld l, a ; $6643
	jr nc, .readB ; $6644
	inc h ; $6646
.readB:
	ld a, [hl] ; $6647
	ret ; $6648
StrokeMatch1Cases3DrillShotTable:
	; $6649, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $5f, $5f, $5e, $ff, $ff, $60
StrokeMatch1Cases4:
	ld a, $62 ; $6653
	ld b, $07 ; $6655
	call SetDrillMessageByRallyParity ; $6657
	ld a, [wLastShotCharIndex] ; $665a
	call TestCharStateBit4 ; $665d
	jp nz, .storeMatchAbortFlag2 ; $6660
	xor a ; $6663
	ret ; $6664
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6665
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $6668
	ld a, $00 ; $666a
	ret z ; $666c
	ld a, $61 ; $666d
	ld b, $07 ; $666f
	call SetDrillMessageByRallyParity ; $6671
	call TestBallBounceDepth ; $6674
	or a ; $6677
	jp z, .storeMatchAbortFlag2 ; $6678
	xor a ; $667b
	ret ; $667c
.storeMatchAbortFlag3:
	xor a ; $667d
	ret ; $667e
.storeMatchAbortFlag:
	ld a, MATCHABORT_POINT ; $667f
	ld [wMatchAbortFlag], a ; $6681
	ld a, $01 ; $6684
	ret ; $6686
.storeMatchAbortFlag2:
	ld a, MATCHABORT_POINT ; $6687
	ld [wMatchAbortFlag], a ; $6689
	ld a, $ff ; $668c
	ret ; $668e
SelectStrokeTargetTableByPoint:
	ld a, [wTotalPointsScoredInCurrentGame] ; $668f
	and $01 ; $6692
	ld a, $00 ; $6694
	or a ; $6696
	jr nz, .nonZero ; $6697
	ld hl, SignedTable_0b_01 ; $6699
	jr .done ; $669c
.nonZero:
	ld hl, SignedTable_0b_00 ; $669e
.done:
	ret ; $66a1
SelectStrokeTargetTableByPointAlt:
	ld a, [wTotalPointsScoredInCurrentGame] ; $66a2
	and $01 ; $66a5
	ld a, $00 ; $66a7
	or a ; $66a9
	jr nz, .nonZero ; $66aa
	ld hl, SignedTable_0b_00 ; $66ac
	jr .done ; $66af
.nonZero:
	ld hl, SignedTable_0b_01 ; $66b1
.done:
	ret ; $66b4
