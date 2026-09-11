TestBallBounceDepth:
	ld a, [wBallBounceCount] ; $66b5
	cp $01 ; $66b8
	ret nz ; $66ba
	ld hl, wBallDepth ; $66bb
	ld a, [hl+] ; $66be
	ld h, [hl] ; $66bf
	ld l, a ; $66c0
	bit 7, h ; $66c1
	jr z, .positive ; $66c3
	xor a ; $66c5
	sub l ; $66c6
	ld l, a ; $66c7
	sbc a ; $66c8
	sub h ; $66c9
	ld h, a ; $66ca
.positive:
	ld de, $02a0 ; $66cb
	ld a, l ; $66ce
	sub e ; $66cf
	ld l, a ; $66d0
	ld a, h ; $66d1
	sbc d ; $66d2
	ld h, a ; $66d3
	ld a, $01 ; $66d4
	bit 7, h ; $66d6
	ret z ; $66d8
	xor a ; $66d9
	ret ; $66da
StrokeMatch2Drill:
	; $66db, 16 bytes (drill_definition)
	db $44, $18, $02, $05, $0d, $24, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw StrokeMatch2Hooks, StrokeMatchPointTable, $0000 ; mode hooks, point table, init
	db $00, $00
StrokeMatch2Hooks:
	; $66eb, 16 bytes (mode_hooks)
	dw StrokeMatch2Hook_PerFrame ; record 0
	dw StrokeMatch2Hook_PointStart ; record 1
	dw StrokeMatch2Hook_PointEnd ; record 2
	dw StrokeMatch2Hook_MinigameStart ; record 3
	dw StrokeMatch2Hook_BallHit ; record 4
	dw StrokeMatch2Hook_Bounce ; record 5
	dw StrokeMatch2Hook_RallyTick ; record 6
	dw RetStub ; record 7
StrokeMatch2Hook_MinigameStart:
	ret ; $66fb
StrokeMatch2Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $66fc
	ret ; $66ff
StrokeMatch2Hook_PointStart:
	xor a ; $6700
	ld [wDrillAbortCountdownActive], a ; $6701
	ld a, $0a ; $6704
	ld [wDrillAbortCountdown], a ; $6706
	ld hl, StrokeMatch2DrillOpponent ; $6709
	call LoadDrillOpponentBySide ; $670c
	xor a ; $670f
	ld [wDrillMessageId], a ; $6710
	xor a ; $6713
	ld [wDrillPointJudgement], a ; $6714
	ld a, [wTotalPointsScoredInCurrentGame] ; $6717
	bit 0, a ; $671a
	ret nz ; $671c
	xor a ; $671d
	ld [wDrillCounters + 1], a ; $671e
	ld [wDrillCounters + 2], a ; $6721
	ld [wDrillCounters + 3], a ; $6724
	ld [wDrillCounters + 4], a ; $6727
	ld [wDrillCounters + 5], a ; $672a
	ld [wDrillCounters + 6], a ; $672d
	ld [wDrillCounters + 7], a ; $6730
	ld [wDrillCounters + 8], a ; $6733
	ret ; $6736
StrokeMatch2DrillOpponent:
	db $58 ; $6737
	db $44 ; $6738
StrokeMatch2Hook_PointEnd:
	call StrokeMatch2JudgeOnPointEnd ; $6739
	call StrokeMatch2HandlePointEnd ; $673c
	ld a, [wTotalPointsScoredInCurrentGame] ; $673f
	bit 0, a ; $6742
	ret nz ; $6744
	ld a, [wPlayer1PointsWon] ; $6745
	ld b, a ; $6748
	ld a, [wPlayer2PointsWon] ; $6749
	sub b ; $674c
	ld b, a ; $674d
	bit 7, a ; $674e
	jr z, .compare ; $6750
	cpl ; $6752
	inc a ; $6753
.compare:
	cp $02 ; $6754
	jr c, .checkTotalPointsScoredInCurrentGame ; $6756
	xor a ; $6758
	rl b ; $6759
	rl a ; $675b
	or a ; $675d
	jr nz, .store ; $675e
	ld a, WINLOSE_LOSE ; $6760
.store:
	ld [wPointWinLoseFlag], a ; $6762
	ld a, MATCHABORT_MATCH ; $6765
	ld [wMatchAbortFlag], a ; $6767
	ret ; $676a
.checkTotalPointsScoredInCurrentGame:
	ld a, [wTotalPointsScoredInCurrentGame] ; $676b
	cp $08 ; $676e
	ret nz ; $6770
	ld a, WINLOSE_NONE ; $6771
	ld [wPointWinLoseFlag], a ; $6773
	ld a, MATCHABORT_MATCH ; $6776
	ld [wMatchAbortFlag], a ; $6778
	ret ; $677b
StrokeMatch2Hook_RallyTick:
	call StrokeMatch2JudgeOnRallyTick ; $677c
	ret ; $677f
StrokeMatch2Hook_Bounce:
	call StrokeMatch2JudgeOnBounce ; $6780
	ret ; $6783
StrokeMatch2Hook_BallHit:
	call StrokeMatch2JudgeOnBallHit ; $6784
	ret ; $6787
StrokeMatch2HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $6788
	ld a, [wDrillPointJudgement] ; $678b
	ld b, a ; $678e
	ld a, [wTotalPointsScoredInCurrentGame] ; $678f
	bit 0, a ; $6792
	ld a, b ; $6794
	jr z, .store ; $6795
	cpl ; $6797
	inc a ; $6798
.store:
	ld [wPointWinLoseFlag], a ; $6799
	call RecordDrillPointResultBits ; $679c
	call ShowQueuedDrillMessage ; $679f
	farcall UpdatePointStats ; $67a2
	call StrokeMatch2AwardPointToSide ; $67a5
	ld a, [wPlayer1PointsWon] ; $67a8
	ld b, $01 ; $67ab
	farcall LoadPlayer1PointsDigitGfx ; $67ad
	ld a, [wPlayer2PointsWon] ; $67b0
	ld b, $01 ; $67b3
	farcall LoadPlayer2PointsDigitGfx ; $67b5
	farcall StepMatchFrame ; $67b8
	farcall StartPointEndReactions ; $67bb
	call PlayDrillPointEndSequence ; $67be
	ret ; $67c1
; Instruction-identical to NetGameMatch1AwardPointToSide, NetGameMatch2AwardPointToSide, NetGameMatch3AwardPointToSide, ServiceMatch2AwardPointToSide, ServiceMatch3AwardPointToSide and StrokeMatch3AwardPointToSide (in this bank); a change here belongs in every copy.
StrokeMatch2AwardPointToSide:
	ld a, [wPointWinLoseFlag] ; $67c2
	or a ; $67c5
	ret z ; $67c6
	inc a ; $67c7
	srl a ; $67c8
	ld b, a ; $67ca
	ld a, [wTotalPointsScoredInCurrentGame] ; $67cb
	and $01 ; $67ce
	xor $01 ; $67d0
	add b ; $67d2
	bit 0, a ; $67d3
	jr nz, .clearServeFaultFlag ; $67d5
	ld hl, wPlayer2PointsWon ; $67d7
	bit 1, a ; $67da
	jr z, .bump ; $67dc
	ld hl, wPlayer1PointsWon ; $67de
.bump:
	inc [hl] ; $67e1
.clearServeFaultFlag:
	xor a ; $67e2
	ld [wServeFaultFlag], a ; $67e3
	ld hl, wTotalPointsScoredInCurrentGame ; $67e6
	inc [hl] ; $67e9
	ret ; $67ea
StrokeMatch2JudgeOnPointEnd:
	ld a, $00 ; $67eb
	call StrokeMatch2JudgePoint ; $67ed
	ld [wDrillPointJudgement], a ; $67f0
	ret ; $67f3
StrokeMatch2JudgeOnBallHit:
	ld a, $01 ; $67f4
	call StrokeMatch2JudgePoint ; $67f6
	ld [wDrillPointJudgement], a ; $67f9
	ret ; $67fc
StrokeMatch2JudgeOnBounce:
	ld a, $02 ; $67fd
	call StrokeMatch2JudgePoint ; $67ff
	ld [wDrillPointJudgement], a ; $6802
	ret ; $6805
StrokeMatch2JudgeOnRallyTick:
	ret ; $6806
	ld a, $03 ; $6807
	call StrokeMatch2JudgePoint ; $6809
	ld [wDrillPointJudgement], a ; $680c
	ret ; $680f
StrokeMatch2JudgePoint:
	ld b, a ; $6810
	ld a, [wDrillPointJudgement] ; $6811
	or a ; $6814
	ret nz ; $6815
	ld a, [wRallyLength] ; $6816
	dec a ; $6819
	ld a, a ; $681a
	rst Rst00 ; $681b
	dw StrokeMatch2JudgePoint.rally1 ; $681c jumptable
	dw StrokeMatch2Cases1.dispatchResult ; $681e jumptable
	dw StrokeMatch2Cases2.dispatchResult ; $6820 jumptable
	dw StrokeMatch2Cases3.dispatchResult ; $6822 jumptable
.rally1:
	ld a, b ; $6824
	ld a, a ; $6825
	rst Rst00 ; $6826
	dw StrokeMatch2JudgePoint.result0 ; $6827 jumptable
	dw StrokeMatch2Cases1 ; $6829 jumptable
	dw StrokeMatch2Cases1.returnZero ; $682b jumptable
	dw StrokeMatch2Cases1.returnZero2 ; $682d jumptable
.result0:
	ld a, [wPointOutcome] ; $682f
	ld hl, StrokeMatch2JudgePointDrillShotTable ; $6832
	add l ; $6835
	ld l, a ; $6836
	jr nc, .readEntry1 ; $6837
	inc h ; $6839
.readEntry1:
	ld a, [hl] ; $683a
	ld a, a ; $683b
	ld b, $0d ; $683c
	call SetDrillMessageByServer ; $683e
	ld a, [wPointOutcome] ; $6841
	ld hl, SignedTable_0b_01 ; $6844
	add l ; $6847
	ld l, a ; $6848
	jr nc, .readEntry2 ; $6849
	inc h ; $684b
.readEntry2:
	ld a, [hl] ; $684c
	ret ; $684d
StrokeMatch2JudgePointDrillShotTable:
	; $684e, 10 bytes (bytes:10)
	db $ff, $ff, $42, $ff, $ff, $ff, $3f, $ff, $ff, $3f ; 0x00
StrokeMatch2Cases1:
	xor a ; $6858
	ret ; $6859
.returnZero:
	xor a ; $685a
	ret ; $685b
.returnZero2:
	xor a ; $685c
	ret ; $685d
.dispatchResult:
	ld a, b ; $685e
	ld a, a ; $685f
	rst Rst00 ; $6860
	dw StrokeMatch2Cases1.checkPointOutcome ; $6861 jumptable
	dw StrokeMatch2Cases2 ; $6863 jumptable
	dw StrokeMatch2Cases2.returnZero ; $6865 jumptable
	dw StrokeMatch2Cases2.returnZero2 ; $6867 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6869
	ld hl, StrokeMatch2Cases1DrillShotTable ; $686c
	add l ; $686f
	ld l, a ; $6870
	jr nc, .read ; $6871
	inc h ; $6873
.read:
	ld a, [hl] ; $6874
	ld a, a ; $6875
	ld b, $0d ; $6876
	call SetDrillMessageByServer ; $6878
	ld a, [wPointOutcome] ; $687b
	ld hl, SignedTable_0b_00 ; $687e
	add l ; $6881
	ld l, a ; $6882
	jr nc, .readB ; $6883
	inc h ; $6885
.readB:
	ld a, [hl] ; $6886
	ret ; $6887
StrokeMatch2Cases1DrillShotTable:
	; $6888, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $48, $48, $3d, $47, $47, $3d ; 0x00
StrokeMatch2Cases2:
	ld a, [wBallBounceCount] ; $6892
	or a ; $6895
	ret z ; $6896
	ld a, $40 ; $6897
	ld b, $0d ; $6899
	call SetDrillMessageByServer ; $689b
	ld a, [wCurrentShotType] ; $689e
	cp SHOTTYPE_LOB ; $68a1
	jp nz, StrokeMatch2Cases3.storeMatchAbortFlag ; $68a3
	xor a ; $68a6
	ret ; $68a7
.returnZero:
	xor a ; $68a8
	ret ; $68a9
.returnZero2:
	xor a ; $68aa
	ret ; $68ab
.dispatchResult:
	ld a, b ; $68ac
	ld a, a ; $68ad
	rst Rst00 ; $68ae
	dw StrokeMatch2Cases2.checkPointOutcome ; $68af jumptable
	dw StrokeMatch2Cases3 ; $68b1 jumptable
	dw StrokeMatch2Cases3.noAction ; $68b3 jumptable
	dw StrokeMatch2Cases3.noAction2 ; $68b5 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $68b7
	ld hl, StrokeMatch2Cases2DrillShotTable ; $68ba
	add l ; $68bd
	ld l, a ; $68be
	jr nc, .read ; $68bf
	inc h ; $68c1
.read:
	ld a, [hl] ; $68c2
	ld a, a ; $68c3
	ld b, $0d ; $68c4
	call SetDrillMessageByServer ; $68c6
	ld a, [wPointOutcome] ; $68c9
	ld hl, SignedTable_0b_01 ; $68cc
	add l ; $68cf
	ld l, a ; $68d0
	jr nc, .readB ; $68d1
	inc h ; $68d3
.readB:
	ld a, [hl] ; $68d4
	ret ; $68d5
StrokeMatch2Cases2DrillShotTable:
	; $68d6, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $3d, $3d, $43, $ff, $ff, $43 ; 0x00
StrokeMatch2Cases3:
	ld a, $46 ; $68e0
	ld b, $0d ; $68e2
	call SetDrillMessageByServer ; $68e4
	ld a, [wTotalPointsScoredInCurrentGame] ; $68e7
	and $01 ; $68ea
	xor $01 ; $68ec
	call TestCharStateBit4 ; $68ee
	or a ; $68f1
	jp z, .zero ; $68f2
	xor a ; $68f5
	ret ; $68f6
.noAction:
	xor a ; $68f7
	ret ; $68f8
.noAction2:
	xor a ; $68f9
	ret ; $68fa
.dispatchResult:
	ld a, b ; $68fb
	ld a, a ; $68fc
	rst Rst00 ; $68fd
	dw StrokeMatch2Cases3.setDrillMessageByServer2 ; $68fe jumptable
	dw StrokeMatch2Cases3.setDrillMessageByServer ; $6900 jumptable
	dw StrokeMatch2Cases3.noAction3 ; $6902 jumptable
	dw StrokeMatch2Cases3.storeMatchAbortFlag2 ; $6904 jumptable
.setDrillMessageByServer2:
	xor a ; $6906
	ret ; $6907
.setDrillMessageByServer:
	ld a, $43 ; $6908
	ld b, $0d ; $690a
	call SetDrillMessageByServer ; $690c
	jp .storeMatchAbortFlag ; $690f
.noAction3:
	xor a ; $6912
	ret ; $6913
.storeMatchAbortFlag2:
	xor a ; $6914
	ret ; $6915
.zero:
	ld a, MATCHABORT_POINT ; $6916
	ld [wMatchAbortFlag], a ; $6918
	ld a, $01 ; $691b
	ret ; $691d
.storeMatchAbortFlag:
	ld a, MATCHABORT_POINT ; $691e
	ld [wMatchAbortFlag], a ; $6920
	ld a, $ff ; $6923
	ret ; $6925
StrokeMatch3Drill:
	; $6926, 16 bytes (drill_definition)
	db $45, $18, $02, $05, $0e, $24, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw StrokeMatch3Hooks, StrokeMatchPointTable, $0000 ; mode hooks, point table, init
	db $00, $00
StrokeMatch3Hooks:
	; $6936, 16 bytes (mode_hooks)
	dw StrokeMatch3Hook_PerFrame ; record 0
	dw StrokeMatch3Hook_PointStart ; record 1
	dw StrokeMatch3Hook_PointEnd ; record 2
	dw StrokeMatch3Hook_MinigameStart ; record 3
	dw StrokeMatch3Hook_BallHit ; record 4
	dw StrokeMatch3Hook_Bounce ; record 5
	dw StrokeMatch3Hook_RallyTick ; record 6
	dw RetStub ; record 7
StrokeMatch3Hook_MinigameStart:
	ret ; $6946
StrokeMatch3Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $6947
	ret ; $694a
StrokeMatch3Hook_PointStart:
	xor a ; $694b
	ld [wDrillAbortCountdownActive], a ; $694c
	ld a, $0a ; $694f
	ld [wDrillAbortCountdown], a ; $6951
	ld hl, StrokeMatch3DrillOpponent ; $6954
	call LoadDrillOpponentBySide ; $6957
	xor a ; $695a
	ld [wDrillMessageId], a ; $695b
	xor a ; $695e
	ld [wDrillPointJudgement], a ; $695f
	ld a, [wTotalPointsScoredInCurrentGame] ; $6962
	bit 0, a ; $6965
	ret nz ; $6967
	xor a ; $6968
	ld [wDrillCounters + 1], a ; $6969
	ld [wDrillCounters + 2], a ; $696c
	ld [wDrillCounters + 3], a ; $696f
	ld [wDrillCounters + 4], a ; $6972
	ld [wDrillCounters + 5], a ; $6975
	ld [wDrillCounters + 6], a ; $6978
	ld [wDrillCounters + 7], a ; $697b
	ld [wDrillCounters + 8], a ; $697e
	ret ; $6981
StrokeMatch3DrillOpponent:
	db $59 ; $6982
	db $45 ; $6983
StrokeMatch3Hook_PointEnd:
	call StrokeMatch3JudgeOnPointEnd ; $6984
	call StrokeMatch3HandlePointEnd ; $6987
	ld a, [wTotalPointsScoredInCurrentGame] ; $698a
	bit 0, a ; $698d
	ret nz ; $698f
	ld a, [wPlayer1PointsWon] ; $6990
	ld b, a ; $6993
	ld a, [wPlayer2PointsWon] ; $6994
	sub b ; $6997
	ld b, a ; $6998
	bit 7, a ; $6999
	jr z, .compare ; $699b
	cpl ; $699d
	inc a ; $699e
.compare:
	cp $02 ; $699f
	jr c, .checkTotalPointsScoredInCurrentGame ; $69a1
	xor a ; $69a3
	rl b ; $69a4
	rl a ; $69a6
	or a ; $69a8
	jr nz, .store ; $69a9
	ld a, WINLOSE_LOSE ; $69ab
.store:
	ld [wPointWinLoseFlag], a ; $69ad
	ld a, MATCHABORT_MATCH ; $69b0
	ld [wMatchAbortFlag], a ; $69b2
	ret ; $69b5
.checkTotalPointsScoredInCurrentGame:
	ld a, [wTotalPointsScoredInCurrentGame] ; $69b6
	cp $08 ; $69b9
	ret nz ; $69bb
	ld a, WINLOSE_NONE ; $69bc
	ld [wPointWinLoseFlag], a ; $69be
	ld a, MATCHABORT_MATCH ; $69c1
	ld [wMatchAbortFlag], a ; $69c3
	ret ; $69c6
StrokeMatch3Hook_RallyTick:
	call StrokeMatch3JudgeOnRallyTick ; $69c7
	ret ; $69ca
StrokeMatch3Hook_Bounce:
	call StrokeMatch3JudgeOnBounce ; $69cb
	ret ; $69ce
StrokeMatch3Hook_BallHit:
	call StrokeMatch3JudgeOnBallHit ; $69cf
	ret ; $69d2
StrokeMatch3HandlePointEnd:
	farcall UpdateScorePanelDisplay ; $69d3
	ld a, [wDrillPointJudgement] ; $69d6
	ld b, a ; $69d9
	ld a, [wTotalPointsScoredInCurrentGame] ; $69da
	bit 0, a ; $69dd
	ld a, b ; $69df
	jr z, .store ; $69e0
	cpl ; $69e2
	inc a ; $69e3
.store:
	ld [wPointWinLoseFlag], a ; $69e4
	call RecordDrillPointResultBits ; $69e7
	call ShowQueuedDrillMessage ; $69ea
	farcall UpdatePointStats ; $69ed
	call StrokeMatch3AwardPointToSide ; $69f0
	ld a, [wPlayer1PointsWon] ; $69f3
	ld b, $01 ; $69f6
	farcall LoadPlayer1PointsDigitGfx ; $69f8
	ld a, [wPlayer2PointsWon] ; $69fb
	ld b, $01 ; $69fe
	farcall LoadPlayer2PointsDigitGfx ; $6a00
	farcall StepMatchFrame ; $6a03
	farcall StartPointEndReactions ; $6a06
	call PlayDrillPointEndSequence ; $6a09
	ret ; $6a0c
; Instruction-identical to NetGameMatch1AwardPointToSide, NetGameMatch2AwardPointToSide, NetGameMatch3AwardPointToSide, ServiceMatch2AwardPointToSide, ServiceMatch3AwardPointToSide and StrokeMatch2AwardPointToSide (in this bank); a change here belongs in every copy.
StrokeMatch3AwardPointToSide:
	ld a, [wPointWinLoseFlag] ; $6a0d
	or a ; $6a10
	ret z ; $6a11
	inc a ; $6a12
	srl a ; $6a13
	ld b, a ; $6a15
	ld a, [wTotalPointsScoredInCurrentGame] ; $6a16
	and $01 ; $6a19
	xor $01 ; $6a1b
	add b ; $6a1d
	bit 0, a ; $6a1e
	jr nz, .clearServeFaultFlag ; $6a20
	ld hl, wPlayer2PointsWon ; $6a22
	bit 1, a ; $6a25
	jr z, .bump ; $6a27
	ld hl, wPlayer1PointsWon ; $6a29
.bump:
	inc [hl] ; $6a2c
.clearServeFaultFlag:
	xor a ; $6a2d
	ld [wServeFaultFlag], a ; $6a2e
	ld hl, wTotalPointsScoredInCurrentGame ; $6a31
	inc [hl] ; $6a34
	ret ; $6a35
StrokeMatch3JudgeOnPointEnd:
	ld a, $00 ; $6a36
	call StrokeMatch3JudgePoint ; $6a38
	ld [wDrillPointJudgement], a ; $6a3b
	ret ; $6a3e
StrokeMatch3JudgeOnBallHit:
	ld a, $01 ; $6a3f
	call StrokeMatch3JudgePoint ; $6a41
	ld [wDrillPointJudgement], a ; $6a44
	ret ; $6a47
StrokeMatch3JudgeOnBounce:
	ld a, $02 ; $6a48
	call StrokeMatch3JudgePoint ; $6a4a
	ld [wDrillPointJudgement], a ; $6a4d
	ret ; $6a50
StrokeMatch3JudgeOnRallyTick:
	ret ; $6a51
	ld a, $03 ; $6a52
	call StrokeMatch3JudgePoint ; $6a54
	ld [wDrillPointJudgement], a ; $6a57
	ret ; $6a5a
StrokeMatch3JudgePoint:
	ld b, a ; $6a5b
	ld a, [wDrillPointJudgement] ; $6a5c
	or a ; $6a5f
	ret nz ; $6a60
	ld a, [wRallyLength] ; $6a61
	dec a ; $6a64
	ld a, a ; $6a65
	rst Rst00 ; $6a66
	dw StrokeMatch3JudgePoint.rally1 ; $6a67 jumptable
	dw StrokeMatch3Cases1.dispatchResult ; $6a69 jumptable
	dw StrokeMatch3Cases2.dispatchResult ; $6a6b jumptable
	dw StrokeMatch3Cases3.dispatchResult ; $6a6d jumptable
.rally1:
	ld a, b ; $6a6f
	ld a, a ; $6a70
	rst Rst00 ; $6a71
	dw StrokeMatch3JudgePoint.result0 ; $6a72 jumptable
	dw StrokeMatch3Cases1 ; $6a74 jumptable
	dw StrokeMatch3Cases1.returnZero ; $6a76 jumptable
	dw StrokeMatch3Cases1.returnZero2 ; $6a78 jumptable
.result0:
	ld a, [wPointOutcome] ; $6a7a
	ld hl, StrokeMatch3JudgePointDrillShotTable ; $6a7d
	add l ; $6a80
	ld l, a ; $6a81
	jr nc, .readEntry1 ; $6a82
	inc h ; $6a84
.readEntry1:
	ld a, [hl] ; $6a85
	ld a, a ; $6a86
	ld b, $0d ; $6a87
	call SetDrillMessageByServer ; $6a89
	ld a, [wPointOutcome] ; $6a8c
	ld hl, SignedTable_0b_01 ; $6a8f
	add l ; $6a92
	ld l, a ; $6a93
	jr nc, .readEntry2 ; $6a94
	inc h ; $6a96
.readEntry2:
	ld a, [hl] ; $6a97
	ret ; $6a98
StrokeMatch3JudgePointDrillShotTable:
	; $6a99, 10 bytes (bytes:10)
	db $ff, $ff, $42, $ff, $ff, $ff, $3f, $ff, $ff, $3f ; 0x00
StrokeMatch3Cases1:
	xor a ; $6aa3
	ret ; $6aa4
.returnZero:
	xor a ; $6aa5
	ret ; $6aa6
.returnZero2:
	xor a ; $6aa7
	ret ; $6aa8
.dispatchResult:
	ld a, b ; $6aa9
	ld a, a ; $6aaa
	rst Rst00 ; $6aab
	dw StrokeMatch3Cases1.checkPointOutcome ; $6aac jumptable
	dw StrokeMatch3Cases2 ; $6aae jumptable
	dw StrokeMatch3Cases2.returnZero ; $6ab0 jumptable
	dw StrokeMatch3Cases2.returnZero2 ; $6ab2 jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6ab4
	ld hl, StrokeMatch3Cases1DrillShotTable ; $6ab7
	add l ; $6aba
	ld l, a ; $6abb
	jr nc, .read ; $6abc
	inc h ; $6abe
.read:
	ld a, [hl] ; $6abf
	ld a, a ; $6ac0
	ld b, $0d ; $6ac1
	call SetDrillMessageByServer ; $6ac3
	ld a, [wPointOutcome] ; $6ac6
	ld hl, SignedTable_0b_00 ; $6ac9
	add l ; $6acc
	ld l, a ; $6acd
	jr nc, .readB ; $6ace
	inc h ; $6ad0
.readB:
	ld a, [hl] ; $6ad1
	ret ; $6ad2
StrokeMatch3Cases1DrillShotTable:
	; $6ad3, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $3f, $49, $3e, $47, $47, $3e ; 0x00
StrokeMatch3Cases2:
	xor a ; $6add
	ret ; $6ade
.returnZero:
	xor a ; $6adf
	ret ; $6ae0
.returnZero2:
	xor a ; $6ae1
	ret ; $6ae2
.dispatchResult:
	ld a, b ; $6ae3
	ld a, a ; $6ae4
	rst Rst00 ; $6ae5
	dw StrokeMatch3Cases2.checkPointOutcome ; $6ae6 jumptable
	dw StrokeMatch3Cases3 ; $6ae8 jumptable
	dw StrokeMatch3Cases3.noAction ; $6aea jumptable
	dw StrokeMatch3Cases3.noAction2 ; $6aec jumptable
.checkPointOutcome:
	ld a, [wPointOutcome] ; $6aee
	ld hl, StrokeMatch3Cases2DrillShotTable ; $6af1
	add l ; $6af4
	ld l, a ; $6af5
	jr nc, .read ; $6af6
	inc h ; $6af8
.read:
	ld a, [hl] ; $6af9
	ld a, a ; $6afa
	ld b, $0d ; $6afb
	call SetDrillMessageByServer ; $6afd
	ld a, [wPointOutcome] ; $6b00
	ld hl, SignedTable_0b_01 ; $6b03
	add l ; $6b06
	ld l, a ; $6b07
	jr nc, .readB ; $6b08
	inc h ; $6b0a
.readB:
	ld a, [hl] ; $6b0b
	ret ; $6b0c
StrokeMatch3Cases2DrillShotTable:
	; $6b0d, 10 bytes (bytes:10)
	db $ff, $ff, $ff, $ff, $3e, $3e, $43, $ff, $ff, $43 ; 0x00
StrokeMatch3Cases3:
	ld a, $46 ; $6b17
	ld b, $0d ; $6b19
	call SetDrillMessageByServer ; $6b1b
	ld a, [wTotalPointsScoredInCurrentGame] ; $6b1e
	and $01 ; $6b21
	xor $01 ; $6b23
	call TestCharStateBit4 ; $6b25
	or a ; $6b28
	jp z, .zero ; $6b29
	xor a ; $6b2c
	ret ; $6b2d
.noAction:
	xor a ; $6b2e
	ret ; $6b2f
.noAction2:
	xor a ; $6b30
	ret ; $6b31
.dispatchResult:
	ld a, b ; $6b32
	ld a, a ; $6b33
	rst Rst00 ; $6b34
	dw StrokeMatch3Cases3.setDrillMessageByServer2 ; $6b35 jumptable
	dw StrokeMatch3Cases3.setDrillMessageByServer ; $6b37 jumptable
	dw StrokeMatch3Cases3.noAction3 ; $6b39 jumptable
	dw StrokeMatch3Cases3.storeMatchAbortFlag2 ; $6b3b jumptable
.setDrillMessageByServer2:
	xor a ; $6b3d
	ret ; $6b3e
.setDrillMessageByServer:
	ld a, $43 ; $6b3f
	ld b, $0d ; $6b41
	call SetDrillMessageByServer ; $6b43
	jp .storeMatchAbortFlag ; $6b46
.noAction3:
	xor a ; $6b49
	ret ; $6b4a
.storeMatchAbortFlag2:
	xor a ; $6b4b
	ret ; $6b4c
.zero:
	ld a, MATCHABORT_POINT ; $6b4d
	ld [wMatchAbortFlag], a ; $6b4f
	ld a, $01 ; $6b52
	ret ; $6b54
.storeMatchAbortFlag:
	ld a, MATCHABORT_POINT ; $6b55
	ld [wMatchAbortFlag], a ; $6b57
	ld a, $ff ; $6b5a
	ret ; $6b5c
StrokePractice1Drill:
	; $6b5d, 16 bytes (drill_definition)
	db $46, $09, $02, $05, $0f, $25, $00, $80 ; opponent, court, chars, mode, story, bgm, -, player
	dw StrokePractice1Hooks, StrokePracticePointTable, StrokePractice1DrillInit ; mode hooks, point table, init
	db $00, $00
StrokePractice1DrillInit:
	ld a, $01 ; $6b6d
	ld [wDrillIsPracticeLesson], a ; $6b6f
	ret ; $6b72
StrokePractice1Hooks:
	; $6b73, 16 bytes (mode_hooks)
	dw StrokePractice1Hook_PerFrame ; record 0
	dw StrokePractice1Hook_PointStart ; record 1
	dw StrokePractice1Hook_PointEnd ; record 2
	dw StrokePractice1Hook_MinigameStart ; record 3
	dw StrokePractice1Hook_BallHit ; record 4
	dw StrokePractice1Hook_Bounce ; record 5
	dw StrokePractice1Hook_RallyTick ; record 6
	dw RetStub ; record 7
StrokePractice1Hook_MinigameStart:
	ld a, $01 ; $6b83
	ld [wDrillIsPracticeLesson], a ; $6b85
	xor a ; $6b88
	ld [wDrillCounters + 2], a ; $6b89
	ld [wDrillCounters + 1], a ; $6b8c
	ret ; $6b8f
StrokePractice1Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $6b90
	ret ; $6b93
StrokePractice1Hook_PointStart:
	xor a ; $6b94
	ld [wDrillAbortCountdownActive], a ; $6b95
	ld a, $0a ; $6b98
	ld [wDrillAbortCountdown], a ; $6b9a
	xor a ; $6b9d
	ld [wTargetZoneEnabled], a ; $6b9e
	ld hl, StrokePractice1Table ; $6ba1
	call SetDrillTargetZoneForPoint ; $6ba4
	xor a ; $6ba7
	ld [wDrillMessageId], a ; $6ba8
	xor a ; $6bab
	ld [wDrillPointJudgement], a ; $6bac
	ld a, $5a ; $6baf
	ld [wDrillCounters + 8], a ; $6bb1
	ld a, $01 ; $6bb4
	ld hl, EnableTargetZoneAfterDelayTask ; $6bb6
	call RegisterFrameTask ; $6bb9
	ld a, [wTotalPointsScoredInCurrentGame] ; $6bbc
	ld hl, StrokePractice1PointStartTable ; $6bbf
	add l ; $6bc2
	ld l, a ; $6bc3
	jr nc, .read ; $6bc4
	inc h ; $6bc6
.read:
	ld a, [hl] ; $6bc7
	ld [wAiServeAimOverride], a ; $6bc8
	ret ; $6bcb
StrokePractice1PointStartTable:
	; $6bcc, 4 bytes (bytes:4)
	db $20, $10, $10, $20 ; 0x00
