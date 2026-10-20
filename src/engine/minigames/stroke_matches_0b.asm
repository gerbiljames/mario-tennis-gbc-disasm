TestBallBounceDepth:
	ld a, [wBallBounceCount] ; $66b5
	cp $01 ; $66b8
	ret nz ; $66ba
	ld hl, wBallDepth ; $66bb
	ld a, [hl+] ; $66be
	ld h, [hl] ; $66bf
	ld l, a ; $66c0
	abs_hl ; $66c1
	ld de, $02a0 ; $66cb
	sub_hl_de ; $66ce
	ld a, $01 ; $66d4
	bit 7, h ; $66d6
	ret z ; $66d8
	xor a ; $66d9
	ret ; $66da
StrokeMatch2Drill:
	; $66db, 16 bytes
	drill_def CHAR_DRILL_STROKE_MATCH_2, COURT_TRAINING_MATCH, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_STROKE_MATCH_2, BGM_DRILL_MATCH, CHAR_STORY_MAIN, StrokeMatch2Hooks, StrokeMatchPointTable, $0000
StrokeMatch2Hooks:
	; $66eb, 16 bytes (mode_hooks)
	table_width 2
	dw StrokeMatch2Hook_PerFrame ; MODEHOOK_PER_FRAME
	dw StrokeMatch2Hook_PointStart ; MODEHOOK_POINT_START
	dw StrokeMatch2Hook_PointEnd ; MODEHOOK_POINT_END
	dw StrokeMatch2Hook_MinigameStart ; MODEHOOK_MINIGAME_START
	dw StrokeMatch2Hook_BallHit ; MODEHOOK_BALL_HIT
	dw StrokeMatch2Hook_Bounce ; MODEHOOK_BOUNCE
	dw StrokeMatch2Hook_RallyTick ; MODEHOOK_RALLY_TICK
	dw RetStub ; MODEHOOK_DRAW
	assert_table_length NUM_MODEHOOKS
StrokeMatch2Hook_MinigameStart:
	ret ; $66fb
StrokeMatch2Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $66fc
	ret ; $66ff
StrokeMatch2Hook_PointStart:
	xor a ; $6700
	ld [wDrillAbortCountdownActive], a ; $6701
	ld a, DRILL_ABORT_FRAMES ; $6704
	ld [wDrillAbortCountdown], a ; $6706
	ld hl, StrokeMatch2DrillOpponent ; $6709
	call LoadDrillOpponentBySide ; $670c
	ASSERT DRILLMSG_NONE == 0
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
	db CHAR_DRILL_STROKE_MATCH_2_RECEIVING ; $6737
	db CHAR_DRILL_STROKE_MATCH_2 ; $6738
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
	cp DRILL_MATCH_POINTS ; $676e
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
	ld b, DIGITGFX_NUMERALS ; $67ab
	farcall LoadPlayer1PointsDigitGfx ; $67ad
	ld a, [wPlayer2PointsWon] ; $67b0
	ld b, DIGITGFX_NUMERALS ; $67b3
	farcall LoadPlayer2PointsDigitGfx ; $67b5
	farcall StepMatchFrame ; $67b8
	farcall StartPointEndReactions ; $67bb
	call PlayDrillPointEndSequence ; $67be
	ret ; $67c1
	twin_named net_game_match1_award_point_to_side, StrokeMatch2AwardPointToSide ; $67c2
StrokeMatch2JudgeOnPointEnd:
	ld a, JUDGEEVENT_POINT_END ; $67eb
	call StrokeMatch2JudgePoint ; $67ed
	ld [wDrillPointJudgement], a ; $67f0
	ret ; $67f3
StrokeMatch2JudgeOnBallHit:
	ld a, JUDGEEVENT_BALL_HIT ; $67f4
	call StrokeMatch2JudgePoint ; $67f6
	ld [wDrillPointJudgement], a ; $67f9
	ret ; $67fc
StrokeMatch2JudgeOnBounce:
	ld a, JUDGEEVENT_BOUNCE ; $67fd
	call StrokeMatch2JudgePoint ; $67ff
	ld [wDrillPointJudgement], a ; $6802
	ret ; $6805
StrokeMatch2JudgeOnRallyTick:
	ret ; $6806
	ld a, JUDGEEVENT_RALLY_TICK ; $6807
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
	jumptable a ; $681a
	dw StrokeMatch2JudgePoint.rally1 ; $681c jumptable
	dw StrokeMatch2Cases1.rally2 ; $681e jumptable
	dw StrokeMatch2Cases2.rally3 ; $6820 jumptable
	dw StrokeMatch2Cases3.rally4 ; $6822 jumptable
.rally1:
	ld a, b ; $6824
	jumptable a ; $6825
	dw StrokeMatch2JudgePoint.rally1PointEnd ; $6827 jumptable
	dw StrokeMatch2Cases1 ; $6829 jumptable
	dw StrokeMatch2Cases1.ignoreBounce ; $682b jumptable
	dw StrokeMatch2Cases1.ignoreRallyTick ; $682d jumptable
.rally1PointEnd:
	ld a, [wPointOutcome] ; $682f
	ld hl, StrokeMatch2Rally1Messages ; $6832
	add_hl_a ; $6835
	ld a, [hl] ; $683a
	ld a, a ; $683b
	ld b, DRILLWORDING_NET ; $683c
	call SetDrillReceiverMessage ; $683e
	ld a, [wPointOutcome] ; $6841
	ld hl, EvenRallyVerdicts ; $6844
	add_hl_a ; $6847
	ld a, [hl] ; $684c
	ret ; $684d
StrokeMatch2Rally1Messages:
	; $684e, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_DOUBLE_FAULT_YOU_GET_A_POINT, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_YOU_DIDNT_RETURN_MY_SERVE_SO_YOU_FAIL, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_YOU_DIDNT_RETURN_MY_SERVE_SO_YOU_FAIL
StrokeMatch2Cases1:
	xor a ; $6858
	ret ; $6859
.ignoreBounce:
	xor a ; $685a
	ret ; $685b
.ignoreRallyTick:
	xor a ; $685c
	ret ; $685d
.rally2:
	ld a, b ; $685e
	jumptable a ; $685f
	dw StrokeMatch2Cases1.rally2PointEnd ; $6861 jumptable
	dw StrokeMatch2Cases2 ; $6863 jumptable
	dw StrokeMatch2Cases2.ignoreBounce ; $6865 jumptable
	dw StrokeMatch2Cases2.ignoreRallyTick ; $6867 jumptable
.rally2PointEnd:
	ld a, [wPointOutcome] ; $6869
	ld hl, StrokeMatch2Rally2Messages ; $686c
	add_hl_a ; $686f
	ld a, [hl] ; $6874
	ld a, a ; $6875
	ld b, DRILLWORDING_NET ; $6876
	call SetDrillReceiverMessage ; $6878
	ld a, [wPointOutcome] ; $687b
	ld hl, OddRallyVerdicts ; $687e
	add_hl_a ; $6881
	ld a, [hl] ; $6886
	ret ; $6887
StrokeMatch2Rally2Messages:
	; $6888, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, $48, $48, DRILLMSG_NICE_LOB_YOU_GET_A_POINT, DRILLMSG_YOU_RETURNED_MY_SERVE_BEFORE_IT_BOUNCED_SO_YOU_FAIL, DRILLMSG_YOU_RETURNED_MY_SERVE_BEFORE_IT_BOUNCED_SO_YOU_FAIL, DRILLMSG_NICE_LOB_YOU_GET_A_POINT
StrokeMatch2Cases2:
	ld a, [wBallBounceCount] ; $6892
	or a ; $6895
	ret z ; $6896
	ld a, DRILLMSG_YOU_DIDNT_RETURN_MY_SERVE_WITH_A_LOB_SO_YOU ; $6897
	ld b, DRILLWORDING_NET ; $6899
	call SetDrillReceiverMessage ; $689b
	ld a, [wCurrentShotType] ; $689e
	cp SHOTTYPE_LOB ; $68a1
	jp nz, StrokeMatch2Cases3.pointLost ; $68a3
	xor a ; $68a6
	ret ; $68a7
.ignoreBounce:
	xor a ; $68a8
	ret ; $68a9
.ignoreRallyTick:
	xor a ; $68aa
	ret ; $68ab
.rally3:
	ld a, b ; $68ac
	jumptable a ; $68ad
	dw StrokeMatch2Cases2.rally3PointEnd ; $68af jumptable
	dw StrokeMatch2Cases3 ; $68b1 jumptable
	dw StrokeMatch2Cases3.ignoreBounce ; $68b3 jumptable
	dw StrokeMatch2Cases3.ignoreRallyTick ; $68b5 jumptable
.rally3PointEnd:
	ld a, [wPointOutcome] ; $68b7
	ld hl, StrokeMatch2Rally3Messages ; $68ba
	add_hl_a ; $68bd
	ld a, [hl] ; $68c2
	ld a, a ; $68c3
	ld b, DRILLWORDING_NET ; $68c4
	call SetDrillReceiverMessage ; $68c6
	ld a, [wPointOutcome] ; $68c9
	ld hl, EvenRallyVerdicts ; $68cc
	add_hl_a ; $68cf
	ld a, [hl] ; $68d4
	ret ; $68d5
StrokeMatch2Rally3Messages:
	; $68d6, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_NICE_LOB_YOU_GET_A_POINT, DRILLMSG_NICE_LOB_YOU_GET_A_POINT, DRILLMSG_I_PLAYED_THE_NET_SO_YOU_FAIL, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_I_PLAYED_THE_NET_SO_YOU_FAIL
StrokeMatch2Cases3:
	ld a, DRILLMSG_I_DIDNT_HIT_FROM_IN_FRONT_OF_THE_SERVICE_LINE_2 ; $68e0
	ld b, DRILLWORDING_NET ; $68e2
	call SetDrillReceiverMessage ; $68e4
	ld a, [wTotalPointsScoredInCurrentGame] ; $68e7
	and $01 ; $68ea
	xor $01 ; $68ec
	call IsCharNearNet ; $68ee
	or a ; $68f1
	jp z, .pointWon ; $68f2
	xor a ; $68f5
	ret ; $68f6
.ignoreBounce:
	xor a ; $68f7
	ret ; $68f8
.ignoreRallyTick:
	xor a ; $68f9
	ret ; $68fa
.rally4:
	ld a, b ; $68fb
	jumptable a ; $68fc
	dw StrokeMatch2Cases3.rally4IgnorePointEnd ; $68fe jumptable
	dw StrokeMatch2Cases3.rally4FailBallHit ; $6900 jumptable
	dw StrokeMatch2Cases3.rally4IgnoreBounce ; $6902 jumptable
	dw StrokeMatch2Cases3.rally4IgnoreRallyTick ; $6904 jumptable
.rally4IgnorePointEnd:
	xor a ; $6906
	ret ; $6907
.rally4FailBallHit:
	ld a, DRILLMSG_I_PLAYED_THE_NET_SO_YOU_FAIL ; $6908
	ld b, DRILLWORDING_NET ; $690a
	call SetDrillReceiverMessage ; $690c
	jp .pointLost ; $690f
.rally4IgnoreBounce:
	xor a ; $6912
	ret ; $6913
.rally4IgnoreRallyTick:
	xor a ; $6914
	ret ; $6915
.pointWon:
	ld a, MATCHABORT_POINT ; $6916
	ld [wMatchAbortFlag], a ; $6918
	ld a, WINLOSE_WIN ; $691b
	ret ; $691d
.pointLost:
	ld a, MATCHABORT_POINT ; $691e
	ld [wMatchAbortFlag], a ; $6920
	ld a, WINLOSE_LOSE ; $6923
	ret ; $6925
StrokeMatch3Drill:
	; $6926, 16 bytes
	drill_def CHAR_DRILL_STROKE_MATCH_3, COURT_TRAINING_MATCH, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_STROKE_MATCH_3, BGM_DRILL_MATCH, CHAR_STORY_MAIN, StrokeMatch3Hooks, StrokeMatchPointTable, $0000
StrokeMatch3Hooks:
	; $6936, 16 bytes (mode_hooks)
	table_width 2
	dw StrokeMatch3Hook_PerFrame ; MODEHOOK_PER_FRAME
	dw StrokeMatch3Hook_PointStart ; MODEHOOK_POINT_START
	dw StrokeMatch3Hook_PointEnd ; MODEHOOK_POINT_END
	dw StrokeMatch3Hook_MinigameStart ; MODEHOOK_MINIGAME_START
	dw StrokeMatch3Hook_BallHit ; MODEHOOK_BALL_HIT
	dw StrokeMatch3Hook_Bounce ; MODEHOOK_BOUNCE
	dw StrokeMatch3Hook_RallyTick ; MODEHOOK_RALLY_TICK
	dw RetStub ; MODEHOOK_DRAW
	assert_table_length NUM_MODEHOOKS
StrokeMatch3Hook_MinigameStart:
	ret ; $6946
StrokeMatch3Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $6947
	ret ; $694a
StrokeMatch3Hook_PointStart:
	xor a ; $694b
	ld [wDrillAbortCountdownActive], a ; $694c
	ld a, DRILL_ABORT_FRAMES ; $694f
	ld [wDrillAbortCountdown], a ; $6951
	ld hl, StrokeMatch3DrillOpponent ; $6954
	call LoadDrillOpponentBySide ; $6957
	ASSERT DRILLMSG_NONE == 0
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
	db CHAR_DRILL_STROKE_MATCH_3_RECEIVING ; $6982
	db CHAR_DRILL_STROKE_MATCH_3 ; $6983
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
	cp DRILL_MATCH_POINTS ; $69b9
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
	ld b, DIGITGFX_NUMERALS ; $69f6
	farcall LoadPlayer1PointsDigitGfx ; $69f8
	ld a, [wPlayer2PointsWon] ; $69fb
	ld b, DIGITGFX_NUMERALS ; $69fe
	farcall LoadPlayer2PointsDigitGfx ; $6a00
	farcall StepMatchFrame ; $6a03
	farcall StartPointEndReactions ; $6a06
	call PlayDrillPointEndSequence ; $6a09
	ret ; $6a0c
	twin_named net_game_match1_award_point_to_side, StrokeMatch3AwardPointToSide ; $6a0d
StrokeMatch3JudgeOnPointEnd:
	ld a, JUDGEEVENT_POINT_END ; $6a36
	call StrokeMatch3JudgePoint ; $6a38
	ld [wDrillPointJudgement], a ; $6a3b
	ret ; $6a3e
StrokeMatch3JudgeOnBallHit:
	ld a, JUDGEEVENT_BALL_HIT ; $6a3f
	call StrokeMatch3JudgePoint ; $6a41
	ld [wDrillPointJudgement], a ; $6a44
	ret ; $6a47
StrokeMatch3JudgeOnBounce:
	ld a, JUDGEEVENT_BOUNCE ; $6a48
	call StrokeMatch3JudgePoint ; $6a4a
	ld [wDrillPointJudgement], a ; $6a4d
	ret ; $6a50
StrokeMatch3JudgeOnRallyTick:
	ret ; $6a51
	ld a, JUDGEEVENT_RALLY_TICK ; $6a52
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
	jumptable a ; $6a65
	dw StrokeMatch3JudgePoint.rally1 ; $6a67 jumptable
	dw StrokeMatch3Cases1.rally2 ; $6a69 jumptable
	dw StrokeMatch3Cases2.rally3 ; $6a6b jumptable
	dw StrokeMatch3Cases3.rally4 ; $6a6d jumptable
.rally1:
	ld a, b ; $6a6f
	jumptable a ; $6a70
	dw StrokeMatch3JudgePoint.rally1PointEnd ; $6a72 jumptable
	dw StrokeMatch3Cases1 ; $6a74 jumptable
	dw StrokeMatch3Cases1.ignoreBounce ; $6a76 jumptable
	dw StrokeMatch3Cases1.ignoreRallyTick ; $6a78 jumptable
.rally1PointEnd:
	ld a, [wPointOutcome] ; $6a7a
	ld hl, StrokeMatch3Rally1Messages ; $6a7d
	add_hl_a ; $6a80
	ld a, [hl] ; $6a85
	ld a, a ; $6a86
	ld b, DRILLWORDING_NET ; $6a87
	call SetDrillReceiverMessage ; $6a89
	ld a, [wPointOutcome] ; $6a8c
	ld hl, EvenRallyVerdicts ; $6a8f
	add_hl_a ; $6a92
	ld a, [hl] ; $6a97
	ret ; $6a98
StrokeMatch3Rally1Messages:
	; $6a99, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_DOUBLE_FAULT_YOU_GET_A_POINT, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_YOU_DIDNT_RETURN_MY_SERVE_SO_YOU_FAIL, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_YOU_DIDNT_RETURN_MY_SERVE_SO_YOU_FAIL
StrokeMatch3Cases1:
	xor a ; $6aa3
	ret ; $6aa4
.ignoreBounce:
	xor a ; $6aa5
	ret ; $6aa6
.ignoreRallyTick:
	xor a ; $6aa7
	ret ; $6aa8
.rally2:
	ld a, b ; $6aa9
	jumptable a ; $6aaa
	dw StrokeMatch3Cases1.rally2PointEnd ; $6aac jumptable
	dw StrokeMatch3Cases2 ; $6aae jumptable
	dw StrokeMatch3Cases2.ignoreBounce ; $6ab0 jumptable
	dw StrokeMatch3Cases2.ignoreRallyTick ; $6ab2 jumptable
.rally2PointEnd:
	ld a, [wPointOutcome] ; $6ab4
	ld hl, StrokeMatch3Rally2Messages ; $6ab7
	add_hl_a ; $6aba
	ld a, [hl] ; $6abf
	ld a, a ; $6ac0
	ld b, DRILLWORDING_NET ; $6ac1
	call SetDrillReceiverMessage ; $6ac3
	ld a, [wPointOutcome] ; $6ac6
	ld hl, OddRallyVerdicts ; $6ac9
	add_hl_a ; $6acc
	ld a, [hl] ; $6ad1
	ret ; $6ad2
StrokeMatch3Rally2Messages:
	; $6ad3, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_YOU_DIDNT_RETURN_MY_SERVE_SO_YOU_FAIL, $49, DRILLMSG_NICE_RETURN_YOU_GET_A_POINT, DRILLMSG_YOU_RETURNED_MY_SERVE_BEFORE_IT_BOUNCED_SO_YOU_FAIL, DRILLMSG_YOU_RETURNED_MY_SERVE_BEFORE_IT_BOUNCED_SO_YOU_FAIL, DRILLMSG_NICE_RETURN_YOU_GET_A_POINT
StrokeMatch3Cases2:
	xor a ; $6add
	ret ; $6ade
.ignoreBounce:
	xor a ; $6adf
	ret ; $6ae0
.ignoreRallyTick:
	xor a ; $6ae1
	ret ; $6ae2
.rally3:
	ld a, b ; $6ae3
	jumptable a ; $6ae4
	dw StrokeMatch3Cases2.rally3PointEnd ; $6ae6 jumptable
	dw StrokeMatch3Cases3 ; $6ae8 jumptable
	dw StrokeMatch3Cases3.ignoreBounce ; $6aea jumptable
	dw StrokeMatch3Cases3.ignoreRallyTick ; $6aec jumptable
.rally3PointEnd:
	ld a, [wPointOutcome] ; $6aee
	ld hl, StrokeMatch3Rally3Messages ; $6af1
	add_hl_a ; $6af4
	ld a, [hl] ; $6af9
	ld a, a ; $6afa
	ld b, DRILLWORDING_NET ; $6afb
	call SetDrillReceiverMessage ; $6afd
	ld a, [wPointOutcome] ; $6b00
	ld hl, EvenRallyVerdicts ; $6b03
	add_hl_a ; $6b06
	ld a, [hl] ; $6b0b
	ret ; $6b0c
StrokeMatch3Rally3Messages:
	; $6b0d, 10 bytes (drill_messages)
	drill_messages DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_NICE_RETURN_YOU_GET_A_POINT, DRILLMSG_NICE_RETURN_YOU_GET_A_POINT, DRILLMSG_I_PLAYED_THE_NET_SO_YOU_FAIL, DRILLMSG_HIDE, DRILLMSG_HIDE, DRILLMSG_I_PLAYED_THE_NET_SO_YOU_FAIL
StrokeMatch3Cases3:
	ld a, DRILLMSG_I_DIDNT_HIT_FROM_IN_FRONT_OF_THE_SERVICE_LINE_2 ; $6b17
	ld b, DRILLWORDING_NET ; $6b19
	call SetDrillReceiverMessage ; $6b1b
	ld a, [wTotalPointsScoredInCurrentGame] ; $6b1e
	and $01 ; $6b21
	xor $01 ; $6b23
	call IsCharNearNet ; $6b25
	or a ; $6b28
	jp z, .pointWon ; $6b29
	xor a ; $6b2c
	ret ; $6b2d
.ignoreBounce:
	xor a ; $6b2e
	ret ; $6b2f
.ignoreRallyTick:
	xor a ; $6b30
	ret ; $6b31
.rally4:
	ld a, b ; $6b32
	jumptable a ; $6b33
	dw StrokeMatch3Cases3.rally4IgnorePointEnd ; $6b35 jumptable
	dw StrokeMatch3Cases3.rally4FailBallHit ; $6b37 jumptable
	dw StrokeMatch3Cases3.rally4IgnoreBounce ; $6b39 jumptable
	dw StrokeMatch3Cases3.rally4IgnoreRallyTick ; $6b3b jumptable
.rally4IgnorePointEnd:
	xor a ; $6b3d
	ret ; $6b3e
.rally4FailBallHit:
	ld a, DRILLMSG_I_PLAYED_THE_NET_SO_YOU_FAIL ; $6b3f
	ld b, DRILLWORDING_NET ; $6b41
	call SetDrillReceiverMessage ; $6b43
	jp .pointLost ; $6b46
.rally4IgnoreBounce:
	xor a ; $6b49
	ret ; $6b4a
.rally4IgnoreRallyTick:
	xor a ; $6b4b
	ret ; $6b4c
.pointWon:
	ld a, MATCHABORT_POINT ; $6b4d
	ld [wMatchAbortFlag], a ; $6b4f
	ld a, WINLOSE_WIN ; $6b52
	ret ; $6b54
.pointLost:
	ld a, MATCHABORT_POINT ; $6b55
	ld [wMatchAbortFlag], a ; $6b57
	ld a, WINLOSE_LOSE ; $6b5a
	ret ; $6b5c
StrokePractice1Drill:
	; $6b5d, 16 bytes
	drill_def CHAR_DRILL_STROKE_PRACTICE_1, COURT_TRAINING_PRACTICE, 2, GAMEMODE_TRAINING_DRILL, MINIGAME_STROKE_PRACTICE_1, BGM_DRILL_PRACTICE, CHAR_STORY_MAIN, StrokePractice1Hooks, StrokePracticePointTable, StrokePractice1DrillInit
StrokePractice1DrillInit:
	ld a, $01 ; $6b6d
	ld [wDrillIsPracticeLesson], a ; $6b6f
	ret ; $6b72
StrokePractice1Hooks:
	; $6b73, 16 bytes (mode_hooks)
	table_width 2
	dw StrokePractice1Hook_PerFrame ; MODEHOOK_PER_FRAME
	dw StrokePractice1Hook_PointStart ; MODEHOOK_POINT_START
	dw StrokePractice1Hook_PointEnd ; MODEHOOK_POINT_END
	dw StrokePractice1Hook_MinigameStart ; MODEHOOK_MINIGAME_START
	dw StrokePractice1Hook_BallHit ; MODEHOOK_BALL_HIT
	dw StrokePractice1Hook_Bounce ; MODEHOOK_BOUNCE
	dw StrokePractice1Hook_RallyTick ; MODEHOOK_RALLY_TICK
	dw RetStub ; MODEHOOK_DRAW
	assert_table_length NUM_MODEHOOKS
	twin_named stroke_practice1_hook_minigame_start, StrokePractice1Hook_MinigameStart ; $6b83
StrokePractice1Hook_PerFrame:
	call UpdateDrillAbortCountdown ; $6b90
	ret ; $6b93
StrokePractice1Hook_PointStart:
	xor a ; $6b94
	ld [wDrillAbortCountdownActive], a ; $6b95
	ld a, DRILL_ABORT_FRAMES ; $6b98
	ld [wDrillAbortCountdown], a ; $6b9a
	xor a ; $6b9d
	ld [wTargetZoneEnabled], a ; $6b9e
	ld hl, StrokePractice1TargetZones ; $6ba1
	call SetDrillTargetZoneForPoint ; $6ba4
	ASSERT DRILLMSG_NONE == 0
	xor a ; $6ba7
	ld [wDrillMessageId], a ; $6ba8
	xor a ; $6bab
	ld [wDrillPointJudgement], a ; $6bac
	ld a, $5a ; $6baf
	ld [wDrillCounters + DRILLCTR_TARGET_ZONE_DELAY], a ; $6bb1
	frame_task EnableTargetZoneAfterDelayTask ; $6bb4
	ld a, [wTotalPointsScoredInCurrentGame] ; $6bbc
	ld hl, StrokePractice1ServeAims ; $6bbf
	add_hl_a ; $6bc2
	ld a, [hl] ; $6bc7
	ld [wAiServeAimOverride], a ; $6bc8
	ret ; $6bcb
StrokePractice1ServeAims:
	; $6bcc, 4 bytes (bytes:4)
	db PADF_LEFT, PADF_RIGHT, PADF_RIGHT, PADF_LEFT
