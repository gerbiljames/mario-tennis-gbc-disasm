PracticeDrillPointTable:
	; $4300, 32 bytes (court_positions)
; court_positions pos0, pos1, pos2, pos3, role0, role1, role2, role3
	court_positions COURTPOS_NEAR_RIGHT, COURTPOS_FAR_LEFT, COURTPOS_NONE, COURTPOS_NONE, SERVEROLE_SERVER, SERVEROLE_RECEIVER, SERVEROLE_NONE, SERVEROLE_NONE ; point 0
	court_positions COURTPOS_NEAR_LEFT, COURTPOS_FAR_RIGHT, COURTPOS_NONE, COURTPOS_NONE, SERVEROLE_SERVER, SERVEROLE_RECEIVER, SERVEROLE_NONE, SERVEROLE_NONE ; point 1
	court_positions COURTPOS_FAR_LEFT, COURTPOS_NEAR_RIGHT, COURTPOS_NONE, COURTPOS_NONE, SERVEROLE_SERVER, SERVEROLE_RECEIVER, SERVEROLE_NONE, SERVEROLE_NONE ; point 2
	court_positions COURTPOS_FAR_RIGHT, COURTPOS_NEAR_LEFT, COURTPOS_NONE, COURTPOS_NONE, SERVEROLE_SERVER, SERVEROLE_RECEIVER, SERVEROLE_NONE, SERVEROLE_NONE ; point 3
	; $4320, 1 bytes (fill)
	ds 1, $ff
StrokePracticePointTable:
	; $4321, 32 bytes (court_positions)
; court_positions pos0, pos1, pos2, pos3, role0, role1, role2, role3
	court_positions COURTPOS_NEAR_RIGHT, COURTPOS_FAR_LEFT, COURTPOS_NONE, COURTPOS_NONE, SERVEROLE_RECEIVER, SERVEROLE_SERVER, SERVEROLE_NONE, SERVEROLE_NONE ; point 0
	court_positions COURTPOS_NEAR_LEFT, COURTPOS_FAR_RIGHT, COURTPOS_NONE, COURTPOS_NONE, SERVEROLE_RECEIVER, SERVEROLE_SERVER, SERVEROLE_NONE, SERVEROLE_NONE ; point 1
	court_positions COURTPOS_FAR_LEFT, COURTPOS_NEAR_RIGHT, COURTPOS_NONE, COURTPOS_NONE, SERVEROLE_RECEIVER, SERVEROLE_SERVER, SERVEROLE_NONE, SERVEROLE_NONE ; point 2
	court_positions COURTPOS_FAR_RIGHT, COURTPOS_NEAR_LEFT, COURTPOS_NONE, COURTPOS_NONE, SERVEROLE_RECEIVER, SERVEROLE_SERVER, SERVEROLE_NONE, SERVEROLE_NONE ; point 3
	; $4341, 1 bytes (fill)
	ds 1, $ff
Unused_0b_TargetPositions16:
	; $4342, 64 bytes (records:4)
; 16 records x 4 bytes
	dw $fe40, $fd40 ; record 0
	dw $0000, $0000 ; record 1
	dw $0000, $0000 ; record 2
	dw $01c0, $02c0 ; record 3
	dw $0000, $fd40 ; record 4
	dw $01c0, $0000 ; record 5
	dw $fe40, $0000 ; record 6
	dw $0000, $02c0 ; record 7
	dw $0000, $0000 ; record 8
	dw $01c0, $02c0 ; record 9
	dw $fe40, $fd40 ; record 10
	dw $0000, $0000 ; record 11
	dw $fe40, $0000 ; record 12
	dw $0000, $02c0 ; record 13
	dw $0000, $fd40 ; record 14
	dw $01c0, $0000 ; record 15
	; $4382, 2 bytes (fill)
	ds 2, $ff
Unused_0b_TargetPositions8:
	; $4384, 32 bytes (records:4)
; 8 records x 4 bytes
	dw $fe40, $fd40 ; record 0
	dw $0000, $0000 ; record 1
	dw $0000, $fd40 ; record 2
	dw $01c0, $0000 ; record 3
	dw $0000, $0000 ; record 4
	dw $01c0, $02c0 ; record 5
	dw $fe40, $0000 ; record 6
	dw $0000, $02c0 ; record 7
	; $43a4, 2 bytes (fill)
	ds 2, $ff
PlayDrillPointEndSequence:
	ld hl, wMatchCameraY ; $43a6
	ld a, [hl+] ; $43a9
	ld d, [hl] ; $43aa
	ld e, a ; $43ab
	ld hl, wMatchCameraX ; $43ac
	ld a, [hl+] ; $43af
	ld h, [hl] ; $43b0
	ld l, a ; $43b1
	farcall SetCameraTarget ; $43b2
	ld a, [wPointOutcome] ; $43b5
	cp POINTOUTCOME_WINNER ; $43b8
	jr z, .showScore ; $43ba
	cp POINTOUTCOME_SERVE_VOLLEYED ; $43bc
	jr z, .showScore ; $43be
	cp POINTOUTCOME_FAULT ; $43c0
	jr z, .showBanner ; $43c2
	cp POINTOUTCOME_LET ; $43c4
	jr z, .showBanner ; $43c6
	jr .waitBanner ; $43c8
.showBanner:
	add BANNER_FAULT - POINTOUTCOME_FAULT ; $43ca
	farcall ShowCourtBanner ; $43cc
.waitBanner:
	ld a, 30 ; $43cf
	farcall StepMatchFrames ; $43d1
	farcall HideCourtBanner ; $43d4
	ld a, 15 ; $43d7
	farcall StepMatchFrames ; $43d9
.showScore:
	farcall SpawnGameScoreDisplayObjs ; $43dc
	ld a, 10 ; $43df
	farcall StepMatchFrames ; $43e1
	ld a, $0a ; $43e4
	farcall StepMatchFramesSkippable ; $43e6
	farcall UpdateScorePanelDisplay ; $43e9
	ld a, 10 ; $43ec
	farcall StepMatchFrames ; $43ee
	ld a, $1e ; $43f1
	farcall StepMatchFramesSkippable ; $43f3
	farcall DismissGameScoreDisplayObjs ; $43f6
	ld a, $46 ; $43f9
	farcall StepMatchFramesSkippable ; $43fb
	ld a, 8 ; $43fe
	farcall StepMatchFrames ; $4400
	ret ; $4403
LoadDrillOpponentChar:
	ld b, a ; $4404
	ld c, MATCHREC_P2_MAIN ; $4405
	farcall InitMatchRecordFromCharId ; $4407
	push_wram_bank WRAM_TEXT ; $440a
	farcall LoadCharacterAttributes ; $4413
	pop_wram_bank ; $4416
	ret ; $441b
LoadDrillOpponentBySide:
	ld a, [wCurrentServingPlayer] ; $441c
	and $01 ; $441f
	add_hl_a ; $4421
	ld a, [hl] ; $4426
	call LoadDrillOpponentChar ; $4427
	ret ; $442a
Unused_0b_WriteCharStructByte:
	ld b, a ; $442b
	push_wram_bank WRAM_CHAR1 ; $442c
	ld de, wCharStruct ; $4435
	add hl, de ; $4438
	ld [hl], b ; $4439
	pop_wram_bank ; $443a
	ret ; $443f
Unused_0b_SetAiReactionDelayFar:
	ld hl, $007a ; $4440
	call Unused_0b_WriteCharStructByte ; $4443
	ret ; $4446
IsCharNearNet:
	ld b, a ; $4447
	ldh a, [hWramBank] ; $4448
	push af ; $444a
	ld a, $04 ; $444b
	add b ; $444d
	wram_bank a ; $444e
	ld de, wCharStruct ; $4453
	ld hl, wCharBallReachFlags - wCharStruct ; $4456
	add hl, de ; $4459
	ld a, [hl] ; $445a
	bit BALLREACHB_NEAR_NET, a ; $445b
	jr z, .clear ; $445d
	pop_wram_bank ; $445f
	ld a, $01 ; $4464
	ret ; $4466
.clear:
	pop_wram_bank ; $4467
	xor a ; $446c
	ret ; $446d
SyncPointWinLoseFlagTask:
	push_wram_bank WRAM_CHAR1 ; $446e
	ld hl, wCharPointResult ; $4477
	ld a, [wPointWinLoseFlag] ; $447a
	ld [hl], a ; $447d
	pop_wram_bank ; $447e
	ret ; $4483
Unused_0b_QueueDrillOutcomeMessage:
	ld a, [wPointOutcome] ; $4484
	cp POINTOUTCOME_FAULT ; $4487
	jr z, .hideMessage ; $4489
	cp POINTOUTCOME_LET ; $448b
	jr z, .hideMessage ; $448d
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $448f
	ld a, DRILLMSG_SERVICE_ACE_YOU_GET_A_POINT ; $4491
	jr z, .checkCurrentServingPlayer ; $4493
	ld a, [wCurrentMatchIndex] ; $4495
	cp MINIGAME_SERVICE_MATCH_2 ; $4498
	jr nz, .checkRallyLength ; $449a
	ld hl, wDrillServeTargetResult ; $449c
	ld a, [wCurrentServingPlayer] ; $449f
	add_hl_a ; $44a2
	ld a, [hl] ; $44a7
	or a ; $44a8
	jr nz, .checkRallyLength ; $44a9
	ld a, DRILLMSG_YOU_DIDNT_HIT_IT_THROUGH_THE_POLES_SO_YOU_FAILED ; $44ab
	jr .checkCurrentServingPlayer ; $44ad
.checkRallyLength:
	ld a, [wRallyLength] ; $44af
	cp $01 ; $44b2
	jr nz, .checkPointOutcome ; $44b4
	ld a, [wServiceAceFlag] ; $44b6
	or a ; $44b9
	jr z, .notAce ; $44ba
	ld a, DRILLMSG_SERVICE_ACE_YOU_GET_A_POINT ; $44bc
	jr .checkCurrentServingPlayer ; $44be
.notAce:
	ld a, DRILLMSG_DOUBLE_FAULT_YOU_FAILED ; $44c0
	jr .checkCurrentServingPlayer ; $44c2
.checkPointOutcome:
	ld a, [wPointOutcome] ; $44c4
	or a ; $44c7
	jr nz, .compare ; $44c8
	ld a, DRILLMSG_I_RETURNED_IT_SO_YOU_FAILED ; $44ca
	jr .checkCurrentServingPlayer ; $44cc
.compare:
	cp POINTOUTCOME_SERVE_VOLLEYED ; $44ce
	ld a, DRILLMSG_I_RETURNED_THE_SERVE_BEFORE_IT_BOUNCED_SO_YOU_GET ; $44d0
	jr z, .checkCurrentServingPlayer ; $44d2
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $44d4
	ld a, DRILLMSG_SERVICE_ACE_YOU_GET_A_POINT ; $44d6
	jr z, .checkCurrentServingPlayer ; $44d8
	ld a, DRILLMSG_I_TOUCHED_IT_SO_YOU_FAILED ; $44da
	jr .checkCurrentServingPlayer ; $44dc
.checkCurrentServingPlayer:
	ld b, a ; $44de
	ld a, [wCurrentServingPlayer] ; $44df
	or a ; $44e2
	jr z, .storeMessage ; $44e3
	ld a, DRILLWORDING_SERVICE ; $44e5
.storeMessage:
	add b ; $44e7
	ld [wDrillMessageId], a ; $44e8
	ret ; $44eb
.hideMessage:
	ld a, DRILLMSG_HIDE ; $44ec
	ld [wDrillMessageId], a ; $44ee
	ret ; $44f1
QueueDrillOutcomeMessage:
	ld a, [wPointOutcome] ; $44f2
	cp POINTOUTCOME_FAULT ; $44f5
	jr z, .hide ; $44f7
	cp POINTOUTCOME_LET ; $44f9
	jr z, .hide ; $44fb
	call CheckDrillTargetZoneHit ; $44fd
	or a ; $4500
	jr nz, .checkRallyLength ; $4501
	ld a, DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL ; $4503
	jr .store ; $4505
.checkRallyLength:
	ld a, [wRallyLength] ; $4507
	cp $01 ; $450a
	jr nz, .checkPointOutcome ; $450c
	ld a, [wServiceAceFlag] ; $450e
	or a ; $4511
	jr z, .notAce ; $4512
	ld a, DRILLMSG_NICE_SERVE_YOU_GET_A_POINT ; $4514
	jr .store ; $4516
.notAce:
	ld a, DRILLMSG_DOUBLE_FAULT_YOU_FAILED_2 ; $4518
	jr .store ; $451a
.checkPointOutcome:
	ld a, [wPointOutcome] ; $451c
	or a ; $451f
	jr nz, .otherOutcome ; $4520
	ld a, DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL ; $4522
	jr .store ; $4524
.otherOutcome:
	ld a, DRILLMSG_YOU_DIDNT_HIT_THE_TARGET_AREA_SO_YOU_FAIL ; $4526
	jr .store ; $4528
.store:
	ld [wDrillMessageId], a ; $452a
	ret ; $452d
.hide:
	ld a, DRILLMSG_HIDE ; $452e
	ld [wDrillMessageId], a ; $4530
	ret ; $4533
QueueDrillResultMessage:
	cp DRILLMSG_HIDE ; $4534
	jr z, .store ; $4536
	ld c, a ; $4538
	ld a, [wCurrentServingPlayer] ; $4539
	or a ; $453c
	jr z, .addOffset ; $453d
	ld a, b ; $453f
.addOffset:
	add c ; $4540
.store:
	ld [wDrillMessageId], a ; $4541
	ret ; $4544
SetDrillMessageByServer:
	cp DRILLMSG_HIDE ; $4545
	jr z, .store ; $4547
	ld c, a ; $4549
	ld a, [wCurrentServingPlayer] ; $454a
	xor $01 ; $454d
	or a ; $454f
	jr z, .addOffset ; $4550
	ld a, b ; $4552
.addOffset:
	add c ; $4553
.store:
	ld [wDrillMessageId], a ; $4554
	ret ; $4557
SetDrillMessageByRallyParity:
	cp DRILLMSG_HIDE ; $4558
	jr z, .store ; $455a
	ld c, a ; $455c
	ld a, [wTotalPointsScoredInCurrentGame] ; $455d
	xor $01 ; $4560
	ld d, a ; $4562
	ld a, [wRallyLength] ; $4563
	xor $01 ; $4566
	add d ; $4568
	and $01 ; $4569
	or a ; $456b
	jr z, .addOffset ; $456c
	ld a, b ; $456e
.addOffset:
	add c ; $456f
.store:
	ld [wDrillMessageId], a ; $4570
	ret ; $4573
ShowQueuedDrillMessage:
	ld a, [wDrillMessageId] ; $4574
	ASSERT DRILLMSG_NONE == 0
	or a ; $4577
	jr nz, .show ; $4578
	ld a, DRILLMSG_THERE_IS_NO_MESSAGE_FOR_THIS_CASE ; $457a
	ld [wDrillMessageId], a ; $457c
.show:
	call ShowDrillMessageByIndex ; $457f
	ret ; $4582
ShowDrillMessageByIndex:
	cp DRILLMSG_HIDE ; $4583
	ret z ; $4585
	ld h, $00 ; $4586
	ld l, a ; $4588
	add hl, hl ; $4589
	ld de, DrillMessageTextIds_0b ; $458a
	add hl, de ; $458d
	ld a, [hl+] ; $458e
	ld b, [hl] ; $458f
	ld c, a ; $4590
	ld h, b ; $4591
	ld l, c ; $4592
	xor a ; $4593
	farcall AddTextIdOffset ; $4594
	ld b, h ; $4597
	ld c, l ; $4598
	farcall MeasureDialogueWidthTiles ; $4599
	ld h, b ; $459c
	ld l, c ; $459d
	add $02 ; $459e
	ld b, a ; $45a0
	push_wram_bank WRAM_TEXT ; $45a1
	ld a, [wFitTextLineCount] ; $45aa
	ld e, a ; $45ad
	pop_wram_bank ; $45ae
	ld a, e ; $45b3
	add a ; $45b4
	inc a ; $45b5
	ld c, a ; $45b6
	ld d, b ; $45b7
	ld a, $14 ; $45b8
	sub d ; $45ba
	srl a ; $45bb
	ld d, a ; $45bd
	ld e, $06 ; $45be
	farcall ShowMessageWindow ; $45c0
	ret ; $45c3
DrillMessageTextIds_0b:
	; $45c4, 218 bytes (records:2)
	dw Text_DrillServiceMatchAceYourPoint ; record 0
	dw Text_DrillServiceMatchAceYourPoint ; record 1
	dw Text_DrillServiceMatchDoubleFaultYouFail ; record 2
	dw Text_DrillServiceMatchMissedPolesYouFail ; record 3
	dw Text_DrillServiceMatchReturnedYouFail ; record 4
	dw Text_DrillServiceMatchTouchedYouFail ; record 5
	dw Text_DrillServiceMatchEarlyReturnYourPoint ; record 6
	dw Text_DrillServiceMatchAceMyPoint ; record 7
	dw Text_DrillServiceMatchDoubleFaultIFail ; record 8
	dw Text_DrillServiceMatchMissedPolesIFail ; record 9
	dw Text_DrillServiceMatchReturnedIFail ; record 10
	dw Text_DrillServiceMatchTouchedIFail ; record 11
	dw Text_DrillServiceMatchEarlyReturnMyPoint ; record 12
	dw Text_DrillServicePracticeNiceServe ; record 13
	dw Text_DrillServicePracticeDoubleFault ; record 14
	dw Text_DrillServicePracticeMissedPoles ; record 15
	dw Text_DrillServicePracticeMissedTarget ; record 16
	dw Text_DrillServicePracticeNoTopspinOut ; record 17
	dw Text_DrillServicePracticeNoSliceOut ; record 18
	dw Text_DrillServicePracticeBadTiming ; record 19
	dw Text_DrillNetMatchNiceVolleyYourPoint ; record 20
	dw Text_DrillNetMatchNiceSmashYourPoint ; record 21
	dw Text_DrillNetMatchPlayedNetYourPoint ; record 22
	dw Text_DrillNetMatchNoReturnYourPoint ; record 23
	dw Text_DrillNetMatchNoLobYourPoint ; record 24
	dw Text_DrillNetMatchDoubleFaultYouFail ; record 25
	dw Text_DrillNetMatchNoVolleyReturnYouFail ; record 26
	dw Text_DrillNetMatchBehindServiceLineYouFail ; record 27
	dw Text_DrillNetMatchNoSmashYouFail ; record 28
	dw Text_DrillNetMatchNoScoreYouFail ; record 29
	dw Text_DrillNetMatchEarlyReturnYourPoint ; record 30
	dw Text_DrillNetMatchDidntVolleyYouFail ; record 31
	dw Text_DrillNetMatchDidntPlayNetYouFail ; record 32
	dw Text_DrillNetMatchNiceVolleyMyPoint ; record 33
	dw Text_DrillNetMatchNiceSmashMyPoint ; record 34
	dw Text_DrillNetMatchPlayedNetMyPoint ; record 35
	dw Text_DrillNetMatchNoReturnMyPoint ; record 36
	dw Text_DrillNetMatchNoLobMyPoint ; record 37
	dw Text_DrillNetMatchDoubleFaultIFail ; record 38
	dw Text_DrillNetMatchNoVolleyReturnIFail ; record 39
	dw Text_DrillNetMatchBehindServiceLineIFail ; record 40
	dw Text_DrillNetMatchNoSmashIFail ; record 41
	dw Text_DrillNetMatchNoScoreIFail ; record 42
	dw Text_DrillNetMatchEarlyReturnMyPoint ; record 43
	dw Text_DrillNetMatchDidntVolleyIFail ; record 44
	dw Text_DrillNetMatchDidntPlayNetIFail ; record 45
	dw Text_DrillNetPracticeNiceVolley ; record 46
	dw Text_DrillNetPracticeNiceSmash ; record 47
	dw Text_DrillNetPracticeNiceDropShot ; record 48
	dw Text_DrillNetPracticeNoReturnSucceed ; record 49
	dw Text_DrillNetPracticeNoLobSucceed ; record 50
	dw Text_DrillNetPracticeDoubleFault ; record 51
	dw Text_DrillNetPracticeNoVolleyReturn ; record 52
	dw Text_DrillNetPracticeBehindServiceLine ; record 53
	dw Text_DrillNetPracticeNoSmash ; record 54
	dw Text_DrillNetPracticeNoSmashWinner ; record 55
	dw Text_DrillNetPracticeMissedTarget ; record 56
	dw Text_DrillNetPracticeNoDropShot ; record 57
	dw Text_DrillNetPracticeDidntVolley ; record 58
	dw Text_DrillNetPracticeNoDeepServe ; record 59
	dw Text_DrillNetPracticeDropShotNoScore ; record 60
	dw Text_DrillStrokeNiceLob ; record 61
	dw Text_DrillStrokeNiceReturn ; record 62
	dw Text_DrillStrokeNoServeReturn ; record 63
	dw Text_DrillStrokeNoLobReturn ; record 64
	dw Text_DrillStrokeNoReturnYourPoint ; record 65
	dw Text_DrillStrokeDoubleFaultYourPoint ; record 66
	dw Text_DrillStrokePlayedNetYouFail ; record 67
	dw Text_DrillStrokeVolleyedYouFail ; record 68
	dw Text_DrillStrokeSmashedYouFail ; record 69
	dw Text_DrillStrokeBehindServiceLineYourPoint ; record 70
	dw Text_DrillStrokeEarlyReturnYouFail ; record 71
IF DEF(FIXES)
	dw Text_DrillYourLobFellShortFail
ELSE
	dw $290b ; record 72, past text bank $25's table (docs/bugs.md)
ENDC
IF DEF(FIXES)
	dw Text_DrillYouMissedMyCourtFail
ELSE
	dw $290c ; record 73, past text bank $25's table (docs/bugs.md)
ENDC
IF DEF(FIXES)
	dw Text_DrillNiceLobIGetPoint
ELSE
	dw $290d ; record 74, past text bank $25's table (docs/bugs.md)
ENDC
IF DEF(FIXES)
	dw Text_DrillNiceReturnIGetPoint
ELSE
	dw $290e ; record 75, past text bank $25's table (docs/bugs.md)
ENDC
IF DEF(FIXES)
	dw Text_DrillCoachMissedServeFail
ELSE
	dw $290f ; record 76, past text bank $25's table (docs/bugs.md)
ENDC
IF DEF(FIXES)
	dw Text_DrillCoachNoLobReturnFail
ELSE
	dw $2910 ; record 77, past text bank $25's table (docs/bugs.md)
ENDC
IF DEF(FIXES)
	dw Text_DrillYouMissedBallCoachPoint
ELSE
	dw $2911 ; record 78, past text bank $25's table (docs/bugs.md)
ENDC
IF DEF(FIXES)
	dw Text_DrillDoubleFaultCoachPoint
ELSE
	dw $2912 ; record 79, past text bank $25's table (docs/bugs.md)
ENDC
IF DEF(FIXES)
	dw Text_DrillYouPlayedNetCoachFail
ELSE
	dw $2913 ; record 80, past text bank $25's table (docs/bugs.md)
ENDC
IF DEF(FIXES)
	dw Text_DrillYouVolleyedCoachFail
ELSE
	dw $2914 ; record 81, past text bank $25's table (docs/bugs.md)
ENDC
IF DEF(FIXES)
	dw Text_DrillYouSmashedCoachFail
ELSE
	dw $2915 ; record 82, past text bank $25's table (docs/bugs.md)
ENDC
IF DEF(FIXES)
	dw Text_DrillNotInsideServiceLineMyPoint
ELSE
	dw $2916 ; record 83, past text bank $25's table (docs/bugs.md)
ENDC
IF DEF(FIXES)
	dw Text_DrillCoachReturnedServeEarlyFail
ELSE
	dw $2917 ; record 84, past text bank $25's table (docs/bugs.md)
ENDC
IF DEF(FIXES)
	dw Text_DrillCoachLobFellShortFail
ELSE
	dw $2918 ; record 85, past text bank $25's table (docs/bugs.md)
ENDC
IF DEF(FIXES)
	dw Text_DrillCoachMissedYourCourtFail
ELSE
	dw $2919 ; record 86, past text bank $25's table (docs/bugs.md)
ENDC
	dw Text_DrillNiceReturnYouDidIt ; record 87
	dw Text_DrillNiceLobYouDidIt ; record 88
	dw Text_DrillYouDidntReturnFail ; record 89
	dw Text_DrillMissedTargetAreaFail ; record 90
	dw Text_DrillNoLobFail ; record 91
	dw Text_DrillDoubleFaultYouPass ; record 92
	dw Text_DrillYouReturnedServeEarlyFail ; record 93
	dw Text_DrillNiceStrokeYourPoint ; record 94
	dw Text_DrillYouMissedMyCourtMyPoint ; record 95
	dw Text_DrillCoachMissedYourPoint ; record 96
	dw Text_DrillShortOfServiceLineMyPoint ; record 97
	dw Text_DrillYouPassedServiceLineMyPoint ; record 98
	dw Text_DrillDoubleFaultMyPoint ; record 99
	dw Text_DrillYouReturnedServeEarlyMyPoint ; record 100
	dw Text_DrillNiceStrokeMyPoint ; record 101
	dw Text_DrillCoachMissedYourCourtYourPoint ; record 102
	dw Text_DrillYouDidntReturnMyPoint ; record 103
	dw Text_DrillCoachShortOfServiceLineYourPoint ; record 104
	dw Text_DrillCoachPlayedNetYourPoint ; record 105
	dw Text_DrillCoachDoubleFaultYourPoint ; record 106
	dw Text_DrillCoachReturnedServeEarlyYourPoint ; record 107
	dw Text_DrillNoMessageForCase ; record 108
Unused_0b_DrillMessageTableTail:
	; $469e, 2 bytes (bytes:2)
	db $00, $02 ; 0x00
QueueDrillMarker1_0b:
	ld a, [wDrillGateActive] ; $46a0
	and a ; $46a3
	ret z ; $46a4
	ld bc, $0000 ; $46a5
	ld hl, wDrillGate1 + 2 ; $46a8
	ld a, [hl+] ; $46ab
	ld d, [hl] ; $46ac
	ld e, a ; $46ad
	ld hl, wDrillGate1 ; $46ae
	ld a, [hl+] ; $46b1
	ld h, [hl] ; $46b2
	ld l, a ; $46b3
	farcall ProjectWorldToScreen_08 ; $46b4
	farcall ApplyCameraProjection ; $46b7
	ld hl, DrillSpriteTemplate_0b ; $46ba
	ld_oam bc, OAM_BANK1 | 1, $30 ; $46bd
	call QueueSpriteTemplate ; $46c0
	ret ; $46c3
QueueDrillMarker2_0b:
	ld a, [wDrillGateActive] ; $46c4
	and a ; $46c7
	ret z ; $46c8
	ld bc, $0000 ; $46c9
	ld hl, wDrillGate2 + 2 ; $46cc
	ld a, [hl+] ; $46cf
	ld d, [hl] ; $46d0
	ld e, a ; $46d1
	ld hl, wDrillGate2 ; $46d2
	ld a, [hl+] ; $46d5
	ld h, [hl] ; $46d6
	ld l, a ; $46d7
	farcall ProjectWorldToScreen_08 ; $46d8
	farcall ApplyCameraProjection ; $46db
	ld hl, DrillSpriteTemplate_0b ; $46de
	ld_oam bc, OAM_BANK1 | 1, $30 ; $46e1
	call QueueSpriteTemplate ; $46e4
	ret ; $46e7
DrillSpriteTemplate_0b:
	; $46e8, 9 bytes (sprite_template)
	oam_sprite $f1, $04, $00, $00
	oam_sprite $01, $04, $02, $00
	oam_sprite_end
