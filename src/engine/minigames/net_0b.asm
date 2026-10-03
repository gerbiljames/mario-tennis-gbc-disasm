NetGameMatch1Drill:
	; $53dd, 16 bytes
	drill_def CHAR_DRILL_NET_GAME_MATCH_1, COURT_TRAINING_MATCH, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_NET_GAME_MATCH_1, BGM_DRILL_MATCH, CHAR_STORY_MAIN, NetGameMatch1Hooks, MatchDrillPointTable, $0000
NetGameMatch1Hooks:
	; $53ed, 16 bytes (mode_hooks)
	dw NetGameMatch1Hook_PerFrame ; record 0
	dw NetGameMatch1Hook_PointStart ; record 1
	dw NetGameMatch1Hook_PointEnd ; record 2
	dw RetStub ; record 3
	dw NetGameMatch1Hook_BallHit ; record 4
	dw NetGameMatch1Hook_Bounce ; record 5
	dw NetGameMatch1Hook_RallyTick ; record 6
	dw RetStub ; record 7
NetGameMatch1Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $53fd
	ret ; $5400
NetGameMatch1Hook_PointStart:
	xor a ; $5401
	ld [wDrillAbortCountdownActive], a ; $5402
	ld a, $0a ; $5405
	ld [wDrillAbortCountdown], a ; $5407
	ld hl, NetGameMatch1DrillOpponent ; $540a
	call LoadDrillOpponentBySide ; $540d
	xor a ; $5410
	ld [wDrillMessageId], a ; $5411
	xor a ; $5414
	ld [wDrillPointJudgement], a ; $5415
	ld a, [wTotalPointsScoredInCurrentGame] ; $5418
	bit 0, a ; $541b
	ret nz ; $541d
	xor a ; $541e
	ld [wDrillCounters + 1], a ; $541f
	ld [wDrillCounters + 2], a ; $5422
	ld [wDrillCounters + 3], a ; $5425
	ld [wDrillCounters + 4], a ; $5428
	ret ; $542b
NetGameMatch1DrillOpponent:
	db CHAR_DRILL_NET_GAME_MATCH_1 ; $542c
	db CHAR_DRILL_NET_GAME_MATCH_1_SERVING ; $542d
NetGameMatch1Hook_PointEnd:
	call NetGameMatch1JudgeOnPointEnd ; $542e
	call NetGameMatch1HandlePointEnd ; $5431
	ld a, [wTotalPointsScoredInCurrentGame] ; $5434
	bit 0, a ; $5437
	ret nz ; $5439
	call NetGameMatch1DecideWinner ; $543a
	ld a, [wPlayer2PointsWon] ; $543d
	ld hl, wPlayer1PointsWon ; $5440
	sub [hl] ; $5443
	ret z ; $5444
	ld a, MATCHABORT_MATCH ; $5445
	ld [wMatchAbortFlag], a ; $5447
	ret ; $544a
NetGameMatch1Hook_RallyTick:
	call NetGameMatch1JudgeOnRallyTick ; $544b
	ret ; $544e
NetGameMatch1Hook_Bounce:
	call NetGameMatch1JudgeOnBounce ; $544f
	ret ; $5452
NetGameMatch1Hook_BallHit:
	call NetGameMatch1JudgeOnBallHit ; $5453
	ret ; $5456
NetGameMatch1HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $5457
	ld a, [wDrillPointJudgement] ; $545a
	ld b, a ; $545d
	ld a, [wTotalPointsScoredInCurrentGame] ; $545e
	bit 0, a ; $5461
	ld a, b ; $5463
	jr z, .store ; $5464
	cpl ; $5466
	inc a ; $5467
.store:
	ld [wPointWinLoseFlag], a ; $5468
	call RecordDrillPointResultBits ; $546b
	call ShowQueuedDrillMessage ; $546e
	farcall UpdatePointStats ; $5471
	call NetGameMatch1AwardPointToSide ; $5474
	ld a, [wPlayer1PointsWon] ; $5477
	ld b, $01 ; $547a
	farcall LoadPlayer1PointsDigitGfx ; $547c
	ld a, [wPlayer2PointsWon] ; $547f
	ld b, $01 ; $5482
	farcall LoadPlayer2PointsDigitGfx ; $5484
	farcall StepMatchFrame ; $5487
	farcall StartPointEndReactions ; $548a
	call PlayDrillPointEndSequence ; $548d
	ret ; $5490
; Instruction-identical to NetGameMatch2AwardPointToSide, NetGameMatch3AwardPointToSide, ServiceMatch2AwardPointToSide, ServiceMatch3AwardPointToSide, StrokeMatch2AwardPointToSide and StrokeMatch3AwardPointToSide (in this bank); a change here belongs in every copy.
	twin_named net_game_match1_award_point_to_side, NetGameMatch1AwardPointToSide ; $5491
NetGameMatch1DecideWinner:
	ld a, [wPlayer1PointsWon] ; $54ba
	ld b, a ; $54bd
	ld a, [wPlayer2PointsWon] ; $54be
	sub b ; $54c1
	jr nc, .compare ; $54c2
	ld a, WINLOSE_WIN ; $54c4
	ld [wPointWinLoseFlag], a ; $54c6
	ret ; $54c9
.compare:
	or a ; $54ca
	jr z, .store ; $54cb
	ld a, WINLOSE_LOSE ; $54cd
.store:
	ld [wPointWinLoseFlag], a ; $54cf
	ret ; $54d2
NetGameMatch1JudgeOnPointEnd:
	ld a, $00 ; $54d3
	call NetGameMatch1JudgePoint ; $54d5
	ld [wDrillPointJudgement], a ; $54d8
	ret ; $54db
NetGameMatch1JudgeOnBallHit:
	ld a, $01 ; $54dc
	call NetGameMatch1JudgePoint ; $54de
	ld [wDrillPointJudgement], a ; $54e1
	ret ; $54e4
NetGameMatch1JudgeOnBounce:
	ret ; $54e5
	ld a, $02 ; $54e6
	call NetGameMatch1JudgePoint ; $54e8
	ld [wDrillPointJudgement], a ; $54eb
	ret ; $54ee
NetGameMatch1JudgeOnRallyTick:
	ret ; $54ef
	ld a, $03 ; $54f0
	call NetGameMatch1JudgePoint ; $54f2
	ld [wDrillPointJudgement], a ; $54f5
	ret ; $54f8
NetGameMatch1JudgePoint:
	ld b, a ; $54f9
	ld a, [wDrillPointJudgement] ; $54fa
	or a ; $54fd
	ret nz ; $54fe
	ld a, [wRallyLength] ; $54ff
	dec a ; $5502
	ld a, a ; $5503
	rst Rst00 ; $5504
	dw NetGameMatch1JudgePoint.rally1 ; $5505 jumptable
	dw NetGameMatch1Cases1.dispatchResult ; $5507 jumptable
	dw NetGameMatch1Cases2.dispatchResult ; $5509 jumptable
	dw NetGameMatch1Cases3.dispatchResult ; $550b jumptable
	dw NetGameMatch1Cases4.dispatchResult ; $550d jumptable
.rally1:
	ld a, b ; $550f
	ld a, a ; $5510
	rst Rst00 ; $5511
	dw NetGameMatch1JudgePoint.result0 ; $5512 jumptable
	dw NetGameMatch1Cases1 ; $5514 jumptable
	dw NetGameMatch1Cases1.returnZero ; $5516 jumptable
	dw NetGameMatch1Cases1.returnZero2 ; $5518 jumptable
.result0:
	ld a, [wPointOutcome] ; $551a
	ld hl, NetGameMatch1JudgePointDrillShotTable ; $551d
	add l ; $5520
	ld l, a ; $5521
	jr nc, .readEntry1 ; $5522
	inc h ; $5524
.readEntry1:
	ld a, [hl] ; $5525
	ld a, a ; $5526
	ld b, $0d ; $5527
	call QueueDrillResultMessage ; $5529
	ld a, [wPointOutcome] ; $552c
	ld hl, SignedTable_0b_00 ; $552f
	add l ; $5532
	ld l, a ; $5533
	jr nc, .readEntry2 ; $5534
	inc h ; $5536
.readEntry2:
	ld a, [hl] ; $5537
	ret ; $5538
NetGameMatch1JudgePointDrillShotTable:
	; $5539, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $19, $ff, $ff, $1d, $17, $ff, $ff, $17
NetGameMatch1Cases1:
	xor a ; $5543
	ret ; $5544
.returnZero:
	xor a ; $5545
	ret ; $5546
.returnZero2:
	xor a ; $5547
	ret ; $5548
.dispatchResult:
	ld a, b ; $5549
	ld a, a ; $554a
	rst Rst00 ; $554b
	dw NetGameMatch1Cases1.checkPointOutcome ; $554c jumptable
	dw NetGameMatch1Cases2 ; $554e jumptable
	dw NetGameMatch1Cases2.returnZero ; $5550 jumptable
	dw NetGameMatch1Cases2.returnZero2 ; $5552 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $5554
	ld hl, NetGameMatch1Cases1DrillShotTable ; $5557
	add l ; $555a
	ld l, a ; $555b
	jr nc, .read ; $555c
	inc h ; $555e
.read:
	ld a, [hl] ; $555f
	ld a, a ; $5560
	ld b, $0d ; $5561
	call QueueDrillResultMessage ; $5563
	ld a, [wPointOutcome] ; $5566
	ld hl, SignedTable_0b_01 ; $5569
	add l ; $556c
	ld l, a ; $556d
	jr nc, .readB ; $556e
	inc h ; $5570
.readB:
	ld a, [hl] ; $5571
	ret ; $5572
NetGameMatch1Cases1DrillShotTable:
	; $5573, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $17, $17, $1f, $1e, $1e, $1f
NetGameMatch1Cases2:
	xor a ; $557d
	ret ; $557e
.returnZero:
	xor a ; $557f
	ret ; $5580
.returnZero2:
	xor a ; $5581
	ret ; $5582
.dispatchResult:
	ld a, b ; $5583
	ld a, a ; $5584
	rst Rst00 ; $5585
	dw NetGameMatch1Cases2.checkPointOutcome ; $5586 jumptable
	dw NetGameMatch1Cases3 ; $5588 jumptable
	dw NetGameMatch1Cases3.returnZero ; $558a jumptable
	dw NetGameMatch1Cases3.returnZero2 ; $558c jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $558e
	ld hl, NetGameMatch1Cases2DrillShotTable ; $5591
	add l ; $5594
	ld l, a ; $5595
	jr nc, .read ; $5596
	inc h ; $5598
.read:
	ld a, [hl] ; $5599
	ld a, a ; $559a
	ld b, $0d ; $559b
	call QueueDrillResultMessage ; $559d
	ld a, [wPointOutcome] ; $55a0
	ld hl, SignedTable_0b_00 ; $55a3
	add l ; $55a6
	ld l, a ; $55a7
	jr nc, .readB ; $55a8
	inc h ; $55aa
.readB:
	ld a, [hl] ; $55ab
	ret ; $55ac
NetGameMatch1Cases2DrillShotTable:
	; $55ad, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $1d, $1d, $14, $ff, $ff, $14
NetGameMatch1Cases3:
	ld a, DRILLMSG_YOU_DIDNT_HIT_FROM_IN_FRONT_OF_THE_SERVICE_LINE ; $55b7
	ld b, $0d ; $55b9
	call QueueDrillResultMessage ; $55bb
	ld a, [wTotalPointsScoredInCurrentGame] ; $55be
	and $01 ; $55c1
	call TestCharStateBit4 ; $55c3
	or a ; $55c6
	jp z, UnusedStoreMatchAbortFlag_4.storeMatchAbortFlag ; $55c7
	ld a, DRILLMSG_YOU_DIDNT_VOLLEY_THE_BALL_SO_YOU_FAIL ; $55ca
	ld b, $0d ; $55cc
	call QueueDrillResultMessage ; $55ce
	ld a, [wShotRecoilVariant] ; $55d1
	cp $01 ; $55d4
	jp nz, UnusedStoreMatchAbortFlag_4.storeMatchAbortFlag ; $55d6
	xor a ; $55d9
	ret ; $55da
.returnZero:
	xor a ; $55db
	ret ; $55dc
.returnZero2:
	xor a ; $55dd
	ret ; $55de
.dispatchResult:
	ld a, b ; $55df
	ld a, a ; $55e0
	rst Rst00 ; $55e1
	dw NetGameMatch1Cases3.checkPointOutcome ; $55e2 jumptable
	dw NetGameMatch1Cases4 ; $55e4 jumptable
	dw NetGameMatch1Cases4.noAction ; $55e6 jumptable
	dw NetGameMatch1Cases4.noAction2 ; $55e8 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $55ea
	ld hl, NetGameMatch1Cases3DrillShotTable ; $55ed
	add l ; $55f0
	ld l, a ; $55f1
	jr nc, .read ; $55f2
	inc h ; $55f4
.read:
	ld a, [hl] ; $55f5
	ld a, a ; $55f6
	ld b, $0d ; $55f7
	call QueueDrillResultMessage ; $55f9
	ld a, [wPointOutcome] ; $55fc
	ld hl, SignedTable_0b_01 ; $55ff
	add l ; $5602
	ld l, a ; $5603
	jr nc, .readB ; $5604
	inc h ; $5606
.readB:
	ld a, [hl] ; $5607
	ret ; $5608
NetGameMatch1Cases3DrillShotTable:
	; $5609, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $14, $14, $1d, $ff, $ff, $1d
NetGameMatch1Cases4:
	xor a ; $5613
	ret ; $5614
.noAction:
	xor a ; $5615
	ret ; $5616
.noAction2:
	xor a ; $5617
	ret ; $5618
.dispatchResult:
	ld a, b ; $5619
	ld a, a ; $561a
	rst Rst00 ; $561b
	dw NetGameMatch1Cases4.queueDrillResultMessage2 ; $561c jumptable
	dw NetGameMatch1Cases4.queueDrillResultMessage ; $561e jumptable
	dw NetGameMatch1Cases4.noAction3 ; $5620 jumptable
	dw NetGameMatch1Cases4.storeMatchAbortFlag2 ; $5622 jumptable
.queueDrillResultMessage2:
	xor a ; $5624
	ret ; $5625
.queueDrillResultMessage:
	ld a, DRILLMSG_YOU_DIDNT_SCORE_SO_YOU_FAIL ; $5626
	ld b, $0d ; $5628
	call QueueDrillResultMessage ; $562a
	jp UnusedStoreMatchAbortFlag_4.storeMatchAbortFlag ; $562d
.noAction3:
	xor a ; $5630
	ret ; $5631
.storeMatchAbortFlag2:
	xor a ; $5632
	ret ; $5633
UnusedStoreMatchAbortFlag_4:
	ld a, MATCHABORT_POINT ; $5634
	ld [wMatchAbortFlag], a ; $5636
	ld a, $01 ; $5639
	ret ; $563b
.storeMatchAbortFlag:
	ld a, MATCHABORT_POINT ; $563c
	ld [wMatchAbortFlag], a ; $563e
	ld a, $ff ; $5641
	ret ; $5643
NetGameMatch2Drill:
	; $5644, 16 bytes
	drill_def CHAR_DRILL_NET_GAME_MATCH_2, COURT_TRAINING_MATCH, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_NET_GAME_MATCH_2, BGM_DRILL_MATCH, CHAR_STORY_MAIN, NetGameMatch2Hooks, MatchDrillPointTable, $0000
NetGameMatch2Hooks:
	; $5654, 16 bytes (mode_hooks)
	dw NetGameMatch2Hook_PerFrame ; record 0
	dw NetGameMatch2Hook_PointStart ; record 1
	dw NetGameMatch2Hook_PointEnd ; record 2
	dw RetStub ; record 3
	dw NetGameMatch2Hook_BallHit ; record 4
	dw NetGameMatch2Hook_Bounce ; record 5
	dw NetGameMatch2Hook_RallyTick ; record 6
	dw RetStub ; record 7
NetGameMatch2Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $5664
	ret ; $5667
NetGameMatch2Hook_PointStart:
	xor a ; $5668
	ld [wDrillAbortCountdownActive], a ; $5669
	ld a, $0a ; $566c
	ld [wDrillAbortCountdown], a ; $566e
	ld hl, NetGameMatch2DrillOpponent ; $5671
	call LoadDrillOpponentBySide ; $5674
	xor a ; $5677
	ld [wDrillMessageId], a ; $5678
	xor a ; $567b
	ld [wDrillPointJudgement], a ; $567c
	ld a, [wTotalPointsScoredInCurrentGame] ; $567f
	bit 0, a ; $5682
	ret nz ; $5684
	xor a ; $5685
	ld [wDrillCounters + 1], a ; $5686
	ld [wDrillCounters + 2], a ; $5689
	ld [wDrillCounters + 3], a ; $568c
	ld [wDrillCounters + 4], a ; $568f
	ld [wDrillCounters + 5], a ; $5692
	ld [wDrillCounters + 6], a ; $5695
	ret ; $5698
NetGameMatch2DrillOpponent:
	db CHAR_DRILL_NET_GAME_MATCH_2 ; $5699
	db CHAR_DRILL_NET_GAME_MATCH_2_SERVING ; $569a
NetGameMatch2Hook_PointEnd:
	call NetGameMatch2JudgeOnPointEnd ; $569b
	call NetGameMatch2HandlePointEnd ; $569e
	ld a, [wTotalPointsScoredInCurrentGame] ; $56a1
	bit 0, a ; $56a4
	ret nz ; $56a6
	ld a, [wPlayer1PointsWon] ; $56a7
	ld b, a ; $56aa
	ld a, [wPlayer2PointsWon] ; $56ab
	sub b ; $56ae
	ld b, a ; $56af
	bit 7, a ; $56b0
	jr z, .compare ; $56b2
	cpl ; $56b4
	inc a ; $56b5
.compare:
	cp $02 ; $56b6
	jr c, .checkTotalPointsScoredInCurrentGame ; $56b8
	xor a ; $56ba
	rl b ; $56bb
	rl a ; $56bd
	or a ; $56bf
	jr nz, .store ; $56c0
	ld a, WINLOSE_LOSE ; $56c2
.store:
	ld [wPointWinLoseFlag], a ; $56c4
	ld a, MATCHABORT_MATCH ; $56c7
	ld [wMatchAbortFlag], a ; $56c9
	ret ; $56cc
.checkTotalPointsScoredInCurrentGame:
	ld a, [wTotalPointsScoredInCurrentGame] ; $56cd
	cp $08 ; $56d0
	ret nz ; $56d2
	ld a, WINLOSE_NONE ; $56d3
	ld [wPointWinLoseFlag], a ; $56d5
	ld a, MATCHABORT_MATCH ; $56d8
	ld [wMatchAbortFlag], a ; $56da
	ret ; $56dd
NetGameMatch2Hook_RallyTick:
	call NetGameMatch2JudgeOnRallyTick ; $56de
	ret ; $56e1
NetGameMatch2Hook_Bounce:
	call NetGameMatch2JudgeOnBounce ; $56e2
	ret ; $56e5
NetGameMatch2Hook_BallHit:
	call NetGameMatch2JudgeOnBallHit ; $56e6
	ret ; $56e9
NetGameMatch2HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $56ea
	ld a, [wDrillPointJudgement] ; $56ed
	ld b, a ; $56f0
	ld a, [wTotalPointsScoredInCurrentGame] ; $56f1
	bit 0, a ; $56f4
	ld a, b ; $56f6
	jr z, .store ; $56f7
	cpl ; $56f9
	inc a ; $56fa
.store:
	ld [wPointWinLoseFlag], a ; $56fb
	call RecordDrillPointResultBits ; $56fe
	call ShowQueuedDrillMessage ; $5701
	farcall UpdatePointStats ; $5704
	call NetGameMatch2AwardPointToSide ; $5707
	ld a, [wPlayer1PointsWon] ; $570a
	ld b, $01 ; $570d
	farcall LoadPlayer1PointsDigitGfx ; $570f
	ld a, [wPlayer2PointsWon] ; $5712
	ld b, $01 ; $5715
	farcall LoadPlayer2PointsDigitGfx ; $5717
	farcall StepMatchFrame ; $571a
	farcall StartPointEndReactions ; $571d
	call PlayDrillPointEndSequence ; $5720
	ret ; $5723
; Instruction-identical to NetGameMatch1AwardPointToSide, NetGameMatch3AwardPointToSide, ServiceMatch2AwardPointToSide, ServiceMatch3AwardPointToSide, StrokeMatch2AwardPointToSide and StrokeMatch3AwardPointToSide (in this bank); a change here belongs in every copy.
	twin_named net_game_match1_award_point_to_side, NetGameMatch2AwardPointToSide ; $5724
NetGameMatch2JudgeOnPointEnd:
	ld a, $00 ; $574d
	call NetGameMatch2JudgePoint ; $574f
	ld [wDrillPointJudgement], a ; $5752
	ret ; $5755
NetGameMatch2JudgeOnBallHit:
	ld a, $01 ; $5756
	call NetGameMatch2JudgePoint ; $5758
	ld [wDrillPointJudgement], a ; $575b
	ret ; $575e
NetGameMatch2JudgeOnBounce:
	ret ; $575f
	ld a, $02 ; $5760
	call NetGameMatch2JudgePoint ; $5762
	ld [wDrillPointJudgement], a ; $5765
	ret ; $5768
NetGameMatch2JudgeOnRallyTick:
	ret ; $5769
	ld a, $03 ; $576a
	call NetGameMatch2JudgePoint ; $576c
	ld [wDrillPointJudgement], a ; $576f
	ret ; $5772
NetGameMatch2JudgePoint:
	ld b, a ; $5773
	ld a, [wDrillPointJudgement] ; $5774
	or a ; $5777
	ret nz ; $5778
	ld a, [wRallyLength] ; $5779
	dec a ; $577c
	ld a, a ; $577d
	rst Rst00 ; $577e
	dw NetGameMatch2JudgePoint.rally1 ; $577f jumptable
	dw NetGameMatch2Cases1.dispatchResult ; $5781 jumptable
	dw NetGameMatch2Cases2.dispatchResult ; $5783 jumptable
	dw NetGameMatch2Cases3.dispatchResult ; $5785 jumptable
	dw NetGameMatch2Cases4.dispatchResult ; $5787 jumptable
.rally1:
	ld a, b ; $5789
	ld a, a ; $578a
	rst Rst00 ; $578b
	dw NetGameMatch2JudgePoint.result0 ; $578c jumptable
	dw NetGameMatch2Cases1 ; $578e jumptable
	dw NetGameMatch2Cases1.returnZero ; $5790 jumptable
	dw NetGameMatch2Cases1.returnZero2 ; $5792 jumptable
.result0:
	ld a, [wPointOutcome] ; $5794
	ld hl, NetGameMatch2JudgePointDrillShotTable ; $5797
	add l ; $579a
	ld l, a ; $579b
	jr nc, .readEntry1 ; $579c
	inc h ; $579e
.readEntry1:
	ld a, [hl] ; $579f
	ld a, a ; $57a0
	ld b, $0d ; $57a1
	call QueueDrillResultMessage ; $57a3
	ld a, [wPointOutcome] ; $57a6
	ld hl, SignedTable_0b_00 ; $57a9
	add l ; $57ac
	ld l, a ; $57ad
	jr nc, .readEntry2 ; $57ae
	inc h ; $57b0
.readEntry2:
	ld a, [hl] ; $57b1
	ret ; $57b2
NetGameMatch2JudgePointDrillShotTable:
	; $57b3, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $19, $ff, $ff, $1d, $18, $ff, $ff, $18
NetGameMatch2Cases1:
	xor a ; $57bd
	ret ; $57be
.returnZero:
	xor a ; $57bf
	ret ; $57c0
.returnZero2:
	xor a ; $57c1
	ret ; $57c2
.dispatchResult:
	ld a, b ; $57c3
	ld a, a ; $57c4
	rst Rst00 ; $57c5
	dw NetGameMatch2Cases1.checkPointOutcome ; $57c6 jumptable
	dw NetGameMatch2Cases2 ; $57c8 jumptable
	dw NetGameMatch2Cases2.returnZero ; $57ca jumptable
	dw NetGameMatch2Cases2.returnZero2 ; $57cc jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $57ce
	ld hl, NetGameMatch2Cases1DrillShotTable ; $57d1
	add l ; $57d4
	ld l, a ; $57d5
	jr nc, .read ; $57d6
	inc h ; $57d8
.read:
	ld a, [hl] ; $57d9
	ld a, a ; $57da
	ld b, $0d ; $57db
	call QueueDrillResultMessage ; $57dd
	ld a, [wPointOutcome] ; $57e0
	ld hl, SignedTable_0b_01 ; $57e3
	add l ; $57e6
	ld l, a ; $57e7
	jr nc, .readB ; $57e8
	inc h ; $57ea
.readB:
	ld a, [hl] ; $57eb
	ret ; $57ec
NetGameMatch2Cases1DrillShotTable:
	; $57ed, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $17, $17, $1c, $1e, $1e, $1c
NetGameMatch2Cases2:
	ld a, [wBallBounceCount] ; $57f7
	or a ; $57fa
	ret z ; $57fb
	ld a, DRILLMSG_I_DIDNT_LOB_THE_BALL_SO_YOU_GET_A_POINT ; $57fc
	ld b, $0d ; $57fe
	call QueueDrillResultMessage ; $5800
	ld a, [wCurrentShotType] ; $5803
	cp SHOTTYPE_LOB ; $5806
	jp nz, NetGameMatch2Cases4.storeMatchAbortFlag ; $5808
	xor a ; $580b
	ret ; $580c
.returnZero:
	xor a ; $580d
	ret ; $580e
.returnZero2:
	xor a ; $580f
	ret ; $5810
.dispatchResult:
	ld a, b ; $5811
	ld a, a ; $5812
	rst Rst00 ; $5813
	dw NetGameMatch2Cases2.checkPointOutcome ; $5814 jumptable
	dw NetGameMatch2Cases3 ; $5816 jumptable
	dw NetGameMatch2Cases3.returnZero ; $5818 jumptable
	dw NetGameMatch2Cases3.returnZero2 ; $581a jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $581c
	ld hl, NetGameMatch2Cases2DrillShotTable ; $581f
	add l ; $5822
	ld l, a ; $5823
	jr nc, .read ; $5824
	inc h ; $5826
.read:
	ld a, [hl] ; $5827
	ld a, a ; $5828
	ld b, $0d ; $5829
	call QueueDrillResultMessage ; $582b
	ld a, [wPointOutcome] ; $582e
	ld hl, SignedTable_0b_00 ; $5831
	add l ; $5834
	ld l, a ; $5835
	jr nc, .readB ; $5836
	inc h ; $5838
.readB:
	ld a, [hl] ; $5839
	ret ; $583a
NetGameMatch2Cases2DrillShotTable:
	; $583b, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $1d, $1d, $15, $ff, $ff, $15
NetGameMatch2Cases3:
	ld a, DRILLMSG_YOU_DIDNT_HIT_A_SMASH_SO_YOU_FAIL ; $5845
	ld b, $0d ; $5847
	call QueueDrillResultMessage ; $5849
	ld a, [wShotRecoilVariant] ; $584c
	cp $02 ; $584f
	jp nz, NetGameMatch2Cases4.storeMatchAbortFlag2 ; $5851
	xor a ; $5854
	ret ; $5855
.returnZero:
	xor a ; $5856
	ret ; $5857
.returnZero2:
	xor a ; $5858
	ret ; $5859
.dispatchResult:
	ld a, b ; $585a
	ld a, a ; $585b
	rst Rst00 ; $585c
	dw NetGameMatch2Cases3.checkPointOutcome ; $585d jumptable
	dw NetGameMatch2Cases4 ; $585f jumptable
	dw NetGameMatch2Cases4.noAction ; $5861 jumptable
	dw NetGameMatch2Cases4.noAction2 ; $5863 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $5865
	ld hl, NetGameMatch2Cases3DrillShotTable ; $5868
	add l ; $586b
	ld l, a ; $586c
	jr nc, .read ; $586d
	inc h ; $586f
.read:
	ld a, [hl] ; $5870
	ld a, a ; $5871
	ld b, $0d ; $5872
	call QueueDrillResultMessage ; $5874
	ld a, [wPointOutcome] ; $5877
	ld hl, SignedTable_0b_01 ; $587a
	add l ; $587d
	ld l, a ; $587e
	jr nc, .readB ; $587f
	inc h ; $5881
.readB:
	ld a, [hl] ; $5882
	ret ; $5883
NetGameMatch2Cases3DrillShotTable:
	; $5884, 10 bytes (drill_outcomes)
	drill_outcomes $ff, $ff, $ff, $ff, $15, $15, $1d, $ff, $ff, $1d
NetGameMatch2Cases4:
	xor a ; $588e
	ret ; $588f
.noAction:
	xor a ; $5890
	ret ; $5891
.noAction2:
	xor a ; $5892
	ret ; $5893
.dispatchResult:
	ld a, b ; $5894
	ld a, a ; $5895
	rst Rst00 ; $5896
	dw NetGameMatch2Cases4.queueDrillResultMessage2 ; $5897 jumptable
	dw NetGameMatch2Cases4.queueDrillResultMessage ; $5899 jumptable
	dw NetGameMatch2Cases4.noAction3 ; $589b jumptable
	dw NetGameMatch2Cases4.storeMatchAbortFlag3 ; $589d jumptable
.queueDrillResultMessage2:
	xor a ; $589f
	ret ; $58a0
.queueDrillResultMessage:
	ld a, DRILLMSG_YOU_DIDNT_SCORE_SO_YOU_FAIL ; $58a1
	ld b, $0d ; $58a3
	call QueueDrillResultMessage ; $58a5
	jp .storeMatchAbortFlag2 ; $58a8
.noAction3:
	xor a ; $58ab
	ret ; $58ac
.storeMatchAbortFlag3:
	xor a ; $58ad
	ret ; $58ae
.storeMatchAbortFlag:
	ld a, MATCHABORT_POINT ; $58af
	ld [wMatchAbortFlag], a ; $58b1
	ld a, $01 ; $58b4
	ret ; $58b6
.storeMatchAbortFlag2:
	ld a, MATCHABORT_POINT ; $58b7
	ld [wMatchAbortFlag], a ; $58b9
	ld a, $ff ; $58bc
	ret ; $58be
NetGameMatch3Drill:
	; $58bf, 16 bytes
	drill_def CHAR_DRILL_NET_GAME_MATCH_3, COURT_TRAINING_MATCH, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_NET_GAME_MATCH_3, BGM_DRILL_MATCH, CHAR_STORY_MAIN, NetGameMatch3Hooks, MatchDrillPointTable, $0000
NetGameMatch3Hooks:
	; $58cf, 16 bytes (mode_hooks)
	dw NetGameMatch3Hook_PerFrame ; record 0
	dw NetGameMatch3Hook_PointStart ; record 1
	dw NetGameMatch3Hook_PointEnd ; record 2
	dw RetStub ; record 3
	dw NetGameMatch3Hook_BallHit ; record 4
	dw NetGameMatch3Hook_Bounce ; record 5
	dw NetGameMatch3Hook_RallyTick ; record 6
	dw RetStub ; record 7
NetGameMatch3Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $58df
	ret ; $58e2
NetGameMatch3Hook_PointStart:
	xor a ; $58e3
	ld [wDrillAbortCountdownActive], a ; $58e4
	ld a, $0a ; $58e7
	ld [wDrillAbortCountdown], a ; $58e9
	xor a ; $58ec
	ld [wDrillMessageId], a ; $58ed
	xor a ; $58f0
	ld [wDrillPointJudgement], a ; $58f1
	ld a, [wTotalPointsScoredInCurrentGame] ; $58f4
	bit 1, a ; $58f7
	ret nz ; $58f9
	xor a ; $58fa
	ld [wDrillCounters + 1], a ; $58fb
	ld [wDrillCounters + 2], a ; $58fe
	ld [wDrillCounters + 5], a ; $5901
	ld [wDrillCounters + 6], a ; $5904
	ret ; $5907
NetGameMatch3Hook_PointEnd:
	call NetGameMatch3JudgeOnPointEnd ; $5908
	call NetGameMatch3HandlePointEnd ; $590b
	ld hl, NetGameMatch3DrillOpponent ; $590e
	call LoadDrillOpponentBySide ; $5911
	ld a, [wTotalPointsScoredInCurrentGame] ; $5914
	bit 0, a ; $5917
	ret nz ; $5919
	ld a, [wPlayer1PointsWon] ; $591a
	ld b, a ; $591d
	ld a, [wPlayer2PointsWon] ; $591e
	sub b ; $5921
	ld b, a ; $5922
	bit 7, a ; $5923
	jr z, .compare ; $5925
	cpl ; $5927
	inc a ; $5928
.compare:
	cp $02 ; $5929
	jr c, .checkTotalPointsScoredInCurrentGame ; $592b
	xor a ; $592d
	rl b ; $592e
	rl a ; $5930
	or a ; $5932
	jr nz, .store ; $5933
	ld a, WINLOSE_LOSE ; $5935
.store:
	ld [wPointWinLoseFlag], a ; $5937
	ld a, MATCHABORT_MATCH ; $593a
	ld [wMatchAbortFlag], a ; $593c
	ret ; $593f
.checkTotalPointsScoredInCurrentGame:
	ld a, [wTotalPointsScoredInCurrentGame] ; $5940
	cp $08 ; $5943
	ret c ; $5945
	ld a, WINLOSE_NONE ; $5946
	ld [wPointWinLoseFlag], a ; $5948
	ret ; $594b
NetGameMatch3DrillOpponent:
	db CHAR_DRILL_NET_GAME_MATCH_3 ; $594c
	db CHAR_DRILL_NET_GAME_MATCH_3_SERVING ; $594d
NetGameMatch3Hook_RallyTick:
	call NetGameMatch3JudgeOnRallyTick ; $594e
	ret ; $5951
NetGameMatch3Hook_Bounce:
	call NetGameMatch3JudgeOnBounce ; $5952
	ret ; $5955
NetGameMatch3Hook_BallHit:
	call NetGameMatch3JudgeOnBallHit ; $5956
	ret ; $5959
NetGameMatch3HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $595a
	ld a, [wDrillPointJudgement] ; $595d
	ld b, a ; $5960
	ld a, [wTotalPointsScoredInCurrentGame] ; $5961
	bit 0, a ; $5964
	ld a, b ; $5966
	jr z, .store ; $5967
	cpl ; $5969
	inc a ; $596a
.store:
	ld [wPointWinLoseFlag], a ; $596b
	call RecordDrillPointResultBits ; $596e
	call ShowQueuedDrillMessage ; $5971
	farcall UpdatePointStats ; $5974
	call NetGameMatch3AwardPointToSide ; $5977
	ld a, [wPlayer1PointsWon] ; $597a
	ld b, $01 ; $597d
	farcall LoadPlayer1PointsDigitGfx ; $597f
	ld a, [wPlayer2PointsWon] ; $5982
	ld b, $01 ; $5985
	farcall LoadPlayer2PointsDigitGfx ; $5987
	farcall StepMatchFrame ; $598a
	farcall StartPointEndReactions ; $598d
	call PlayDrillPointEndSequence ; $5990
	ret ; $5993
UnusedNetGameMatch3JudgePoint:
	ld a, [wPointOutcome] ; $5994
	cp POINTOUTCOME_FAULT ; $5997
	jp z, UnusedNetGameMatch3JudgePoint.checkPointWinLoseFlag ; $5999
	cp POINTOUTCOME_LET ; $599c
	jp z, UnusedNetGameMatch3JudgePoint.checkPointWinLoseFlag ; $599e
	ld a, [wRallyLength] ; $59a1
	dec a ; $59a4
	and $03 ; $59a5
	add a ; $59a7
	ld hl, NetGameMatch3HandlePointEndTable ; $59a8
	add l ; $59ab
	ld l, a ; $59ac
	jr nc, .read ; $59ad
	inc h ; $59af
.read:
	ld a, [hl+] ; $59b0
	ld h, [hl] ; $59b1
	ld l, a ; $59b2
	jp hl ; $59b3
NetGameMatch3HandlePointEndTable:
	dw UnusedNetGameMatch3JudgePoint.queueDrillResultMessage ; $59b4 jumptable
	dw UnusedNetGameMatch3JudgePoint.queueDrillResultMessage3 ; $59b6 jumptable
	dw UnusedNetGameMatch3JudgePoint.queueDrillResultMessage2 ; $59b8 jumptable
	dw UnusedNetGameMatch3JudgePoint.queueDrillResultMessage4 ; $59ba jumptable
UnusedNetGameMatch3JudgePoint.queueDrillResultMessage:
	ld a, DRILLMSG_I_DIDNT_RETURN_THE_BALL_SO_YOU_GET_A_POINT ; $59bc
	ld b, $0d ; $59be
	call QueueDrillResultMessage ; $59c0
	ld a, [wPointOutcome] ; $59c3
	cp POINTOUTCOME_WINNER ; $59c6
	jr z, UnusedNetGameMatch3JudgePoint.checkTotalPointsScoredInCurrentGame ; $59c8
	ld a, DRILLMSG_DOUBLE_FAULT_YOU_FAILED_3 ; $59ca
	ld b, $0d ; $59cc
	call QueueDrillResultMessage ; $59ce
	jp UnusedNetGameMatch3JudgePoint.checkTotalPointsScoredInCurrentGame2 ; $59d1
UnusedNetGameMatch3JudgePoint.queueDrillResultMessage2:
	ld a, DRILLMSG_YOU_DIDNT_HIT_FROM_IN_FRONT_OF_THE_SERVICE_LINE ; $59d4
	ld b, $0d ; $59d6
	call QueueDrillResultMessage ; $59d8
	ld a, [wTotalPointsScoredInCurrentGame] ; $59db
	and $01 ; $59de
	ld hl, wDrillCounters + 5 ; $59e0
	add l ; $59e3
	ld l, a ; $59e4
	jr nc, UnusedNetGameMatch3JudgePoint.readB ; $59e5
	inc h ; $59e7
UnusedNetGameMatch3JudgePoint.readB:
	ld a, [hl] ; $59e8
	or a ; $59e9
	jr z, UnusedNetGameMatch3JudgePoint.checkTotalPointsScoredInCurrentGame2 ; $59ea
	ld a, DRILLMSG_WAY_TO_PLAY_THE_NET_YOU_GET_A_POINT ; $59ec
	ld b, $0d ; $59ee
	call QueueDrillResultMessage ; $59f0
	ld a, [wPointOutcome] ; $59f3
	cp POINTOUTCOME_WINNER ; $59f6
	jr z, UnusedNetGameMatch3JudgePoint.checkTotalPointsScoredInCurrentGame ; $59f8
	jr UnusedNetGameMatch3JudgePoint.checkTotalPointsScoredInCurrentGame2 ; $59fa
UnusedNetGameMatch3JudgePoint.queueDrillResultMessage3:
	ld a, DRILLMSG_YOU_DIDNT_SCORE_SO_YOU_FAIL ; $59fc
	ld b, $0d ; $59fe
	call QueueDrillResultMessage ; $5a00
	ld a, [wPointOutcome] ; $5a03
	cp POINTOUTCOME_WINNER ; $5a06
	jr z, UnusedNetGameMatch3JudgePoint.checkTotalPointsScoredInCurrentGame2 ; $5a08
	push af ; $5a0a
	ld a, DRILLMSG_I_RETURNED_THE_SERVE_BEFORE_IT_BOUNCED_SO_YOU_GET_2 ; $5a0b
	ld b, $0d ; $5a0d
	call QueueDrillResultMessage ; $5a0f
	pop af ; $5a12
	cp $07 ; $5a13
	jr z, UnusedNetGameMatch3JudgePoint.checkTotalPointsScoredInCurrentGame ; $5a15
	ld a, DRILLMSG_I_DIDNT_RETURN_THE_BALL_SO_YOU_GET_A_POINT ; $5a17
	ld b, $0d ; $5a19
	call QueueDrillResultMessage ; $5a1b
	jr UnusedNetGameMatch3JudgePoint.checkTotalPointsScoredInCurrentGame ; $5a1e
UnusedNetGameMatch3JudgePoint.queueDrillResultMessage4:
	ld a, DRILLMSG_I_DIDNT_RETURN_THE_BALL_SO_YOU_GET_A_POINT ; $5a20
	ld b, $0d ; $5a22
	call QueueDrillResultMessage ; $5a24
	ld a, [wPointOutcome] ; $5a27
	or a ; $5a2a
	jr nz, UnusedNetGameMatch3JudgePoint.checkTotalPointsScoredInCurrentGame ; $5a2b
	ld a, DRILLMSG_YOU_DIDNT_SCORE_SO_YOU_FAIL ; $5a2d
	ld b, $0d ; $5a2f
	call QueueDrillResultMessage ; $5a31
	jr UnusedNetGameMatch3JudgePoint.checkTotalPointsScoredInCurrentGame2 ; $5a34
UnusedNetGameMatch3JudgePoint.checkTotalPointsScoredInCurrentGame:
	ld a, [wTotalPointsScoredInCurrentGame] ; $5a36
	and $01 ; $5a39
	xor $01 ; $5a3b
	add a ; $5a3d
	dec a ; $5a3e
	ret ; $5a3f
UnusedNetGameMatch3JudgePoint.checkTotalPointsScoredInCurrentGame2:
	ld a, [wTotalPointsScoredInCurrentGame] ; $5a40
	and $01 ; $5a43
	add a ; $5a45
	dec a ; $5a46
	ret ; $5a47
UnusedNetGameMatch3JudgePoint.checkPointWinLoseFlag:
	ld a, DRILLMSG_HIDE ; $5a48
	ld [wDrillMessageId], a ; $5a4a
	xor a ; $5a4d
	ret ; $5a4e
; Instruction-identical to NetGameMatch1AwardPointToSide, NetGameMatch2AwardPointToSide, ServiceMatch2AwardPointToSide, ServiceMatch3AwardPointToSide, StrokeMatch2AwardPointToSide and StrokeMatch3AwardPointToSide (in this bank); a change here belongs in every copy.
	twin_named net_game_match1_award_point_to_side, NetGameMatch3AwardPointToSide ; $5a4f
