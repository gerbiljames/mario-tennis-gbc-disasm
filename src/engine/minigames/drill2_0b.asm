PracticeDrillPointTable:
	; $4300, 32 bytes (court_positions)
; court_positions pos0, pos1, pos2, pos3, role0, role1, role2, role3
	court_positions $00, $03, $09, $09, $00, $01, $09, $09 ; point 0
	court_positions $01, $02, $09, $09, $00, $01, $09, $09 ; point 1
	court_positions $03, $00, $09, $09, $00, $01, $09, $09 ; point 2
	court_positions $02, $01, $09, $09, $00, $01, $09, $09 ; point 3
	; $4320, 1 bytes (fill)
	ds 1, $ff
StrokePracticePointTable:
	; $4321, 32 bytes (court_positions)
; court_positions pos0, pos1, pos2, pos3, role0, role1, role2, role3
	court_positions $00, $03, $09, $09, $01, $00, $09, $09 ; point 0
	court_positions $01, $02, $09, $09, $01, $00, $09, $09 ; point 1
	court_positions $03, $00, $09, $09, $01, $00, $09, $09 ; point 2
	court_positions $02, $01, $09, $09, $01, $00, $09, $09 ; point 3
	; $4341, 1 bytes (fill)
	ds 1, $ff
TargetPositions_0b_0:
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
TargetPositions_0b_1:
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
	add $00 ; $43ca
	farcall ShowCourtBanner ; $43cc
.waitBanner:
	ld a, $1e ; $43cf
	farcall StepMatchFrames ; $43d1
	farcall HideCourtBanner ; $43d4
	ld a, $0f ; $43d7
	farcall StepMatchFrames ; $43d9
.showScore:
	farcall SpawnGameScoreDisplayObjs ; $43dc
	ld a, $0a ; $43df
	farcall StepMatchFrames ; $43e1
	ld a, $0a ; $43e4
	farcall StepMatchFramesSkippable ; $43e6
	farcall UpdateScorePanelDisplay ; $43e9
	ld a, $0a ; $43ec
	farcall StepMatchFrames ; $43ee
	ld a, $1e ; $43f1
	farcall StepMatchFramesSkippable ; $43f3
	farcall DismissGameScoreDisplayObjs ; $43f6
	ld a, $46 ; $43f9
	farcall StepMatchFramesSkippable ; $43fb
	ld a, $08 ; $43fe
	farcall StepMatchFrames ; $4400
	ret ; $4403
LoadDrillOpponentChar:
	ld b, a ; $4404
	ld c, $02 ; $4405
	farcall InitCa00RecordFromCharId ; $4407
	push_wram_bank WRAM_TEXT ; $440a
	farcall LoadCharacterAttributes ; $4413
	pop_wram_bank ; $4416
	ret ; $441b
LoadDrillOpponentBySide:
	ld a, [wCurrentServingPlayer] ; $441c
	and $01 ; $441f
	add l ; $4421
	ld l, a ; $4422
	jr nc, .load ; $4423
	inc h ; $4425
.load:
	ld a, [hl] ; $4426
	call LoadDrillOpponentChar ; $4427
	ret ; $442a
Unused_0b_WriteCharStructByte:
	ld b, a ; $442b
	push_wram_bank WRAM_CHAR1 ; $442c
	ld de, wCharPosX ; $4435
	add hl, de ; $4438
	ld [hl], b ; $4439
	pop_wram_bank ; $443a
	ret ; $443f
UnusedSetAiReactionDelayFar:
	ld hl, $007a ; $4440
	call Unused_0b_WriteCharStructByte ; $4443
	ret ; $4446
TestCharStateBit4:
	ld b, a ; $4447
	ldh a, [hWramBank] ; $4448
	push af ; $444a
	ld a, $04 ; $444b
	add b ; $444d
	ld a, a ; $444e
	wram_bank ; $444f
	ld de, wCharPosX ; $4453
	ld hl, $0050 ; $4456
	add hl, de ; $4459
	ld a, [hl] ; $445a
	bit 4, a ; $445b
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
UnusedQueueDrillOutcomeMessage:
	ld a, [wPointOutcome] ; $4484
	cp POINTOUTCOME_FAULT ; $4487
	jr z, .checkPointOutcome2 ; $4489
	cp POINTOUTCOME_LET ; $448b
	jr z, .checkPointOutcome2 ; $448d
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $448f
	ld a, $01 ; $4491
	jr z, .checkCurrentServingPlayer ; $4493
	ld a, [wCurrentMinigameStoryMatch + 1] ; $4495
	cp MINIGAME_SERVICE_MATCH_2 ; $4498
	jr nz, .checkRallyLength ; $449a
	ld hl, wDrillServeTargetResult ; $449c
	ld a, [wCurrentServingPlayer] ; $449f
	add l ; $44a2
	ld l, a ; $44a3
	jr nc, .read ; $44a4
	inc h ; $44a6
.read:
	ld a, [hl] ; $44a7
	or a ; $44a8
	jr nz, .checkRallyLength ; $44a9
	ld a, $03 ; $44ab
	jr .checkCurrentServingPlayer ; $44ad
.checkRallyLength:
	ld a, [wRallyLength] ; $44af
	cp $01 ; $44b2
	jr nz, .checkPointOutcome ; $44b4
	ld a, [wServiceAceFlag] ; $44b6
	or a ; $44b9
	jr z, .zero ; $44ba
	ld a, $01 ; $44bc
	jr .checkCurrentServingPlayer ; $44be
.zero:
	ld a, $02 ; $44c0
	jr .checkCurrentServingPlayer ; $44c2
.checkPointOutcome:
	ld a, [wPointOutcome] ; $44c4
	or a ; $44c7
	jr nz, .compare ; $44c8
	ld a, $04 ; $44ca
	jr .checkCurrentServingPlayer ; $44cc
.compare:
	cp $07 ; $44ce
	ld a, $06 ; $44d0
	jr z, .checkCurrentServingPlayer ; $44d2
	cp $09 ; $44d4
	ld a, $01 ; $44d6
	jr z, .checkCurrentServingPlayer ; $44d8
	ld a, $05 ; $44da
	jr .checkCurrentServingPlayer ; $44dc
.checkCurrentServingPlayer:
	ld b, a ; $44de
	ld a, [wCurrentServingPlayer] ; $44df
	or a ; $44e2
	jr z, .zero2 ; $44e3
	ld a, $06 ; $44e5
.zero2:
	add b ; $44e7
	ld [wDrillMessageId], a ; $44e8
	ret ; $44eb
.checkPointOutcome2:
	ld a, DRILLMSG_HIDE ; $44ec
	ld [wDrillMessageId], a ; $44ee
	ret ; $44f1
QueueDrillOutcomeMessage:
	ld a, [wPointOutcome] ; $44f2
	cp POINTOUTCOME_FAULT ; $44f5
	jr z, .step3 ; $44f7
	cp POINTOUTCOME_LET ; $44f9
	jr z, .step3 ; $44fb
	call CheckDrillTargetZoneMissed ; $44fd
	or a ; $4500
	jr nz, .checkRallyLength ; $4501
	ld a, $10 ; $4503
	jr .store ; $4505
.checkRallyLength:
	ld a, [wRallyLength] ; $4507
	cp $01 ; $450a
	jr nz, .checkPointOutcome ; $450c
	ld a, [wServiceAceFlag] ; $450e
	or a ; $4511
	jr z, .zero ; $4512
	ld a, $0d ; $4514
	jr .store ; $4516
.zero:
	ld a, $0e ; $4518
	jr .store ; $451a
.checkPointOutcome:
	ld a, [wPointOutcome] ; $451c
	or a ; $451f
	jr nz, .nonZero ; $4520
	ld a, $10 ; $4522
	jr .store ; $4524
.nonZero:
	ld a, $10 ; $4526
	jr .store ; $4528
.store:
	ld [wDrillMessageId], a ; $452a
	ret ; $452d
.step3:
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
	cp $ff ; $4558
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
	dw Text_25_196 ; record 0
	dw Text_25_196 ; record 1
	dw Text_25_197 ; record 2
	dw Text_25_198 ; record 3
	dw Text_25_199 ; record 4
	dw Text_25_200 ; record 5
	dw Text_25_201 ; record 6
	dw Text_25_202 ; record 7
	dw Text_25_203 ; record 8
	dw Text_25_204 ; record 9
	dw Text_25_205 ; record 10
	dw Text_25_206 ; record 11
	dw Text_25_207 ; record 12
	dw Text_25_208 ; record 13
	dw Text_25_209 ; record 14
	dw Text_25_210 ; record 15
	dw Text_25_211 ; record 16
	dw Text_25_212 ; record 17
	dw Text_25_213 ; record 18
	dw Text_25_214 ; record 19
	dw Text_25_215 ; record 20
	dw Text_25_216 ; record 21
	dw Text_25_217 ; record 22
	dw Text_25_218 ; record 23
	dw Text_25_219 ; record 24
	dw Text_25_220 ; record 25
	dw Text_25_221 ; record 26
	dw Text_25_222 ; record 27
	dw Text_25_223 ; record 28
	dw Text_25_224 ; record 29
	dw Text_25_225 ; record 30
	dw Text_25_226 ; record 31
	dw Text_25_227 ; record 32
	dw Text_25_228 ; record 33
	dw Text_25_229 ; record 34
	dw Text_25_230 ; record 35
	dw Text_25_231 ; record 36
	dw Text_25_232 ; record 37
	dw Text_25_233 ; record 38
	dw Text_25_234 ; record 39
	dw Text_25_235 ; record 40
	dw Text_25_236 ; record 41
	dw Text_25_237 ; record 42
	dw Text_25_238 ; record 43
	dw Text_25_239 ; record 44
	dw Text_25_240 ; record 45
	dw Text_25_241 ; record 46
	dw Text_25_242 ; record 47
	dw Text_25_243 ; record 48
	dw Text_25_244 ; record 49
	dw Text_25_245 ; record 50
	dw Text_25_246 ; record 51
	dw Text_25_247 ; record 52
	dw Text_25_248 ; record 53
	dw Text_25_249 ; record 54
	dw Text_25_250 ; record 55
	dw Text_25_251 ; record 56
	dw Text_25_252 ; record 57
	dw Text_25_253 ; record 58
	dw Text_25_254 ; record 59
	dw Text_25_255 ; record 60
	dw Text_25_256 ; record 61
	dw Text_25_257 ; record 62
	dw Text_25_258 ; record 63
	dw Text_25_259 ; record 64
	dw Text_25_260 ; record 65
	dw Text_25_261 ; record 66
	dw Text_25_262 ; record 67
	dw Text_25_263 ; record 68
	dw Text_25_264 ; record 69
	dw Text_25_265 ; record 70
	dw Text_25_266 ; record 71
	dw $290b ; record 72, past text bank $25's table (docs/bugs.md)
	dw $290c ; record 73, past text bank $25's table (docs/bugs.md)
	dw $290d ; record 74, past text bank $25's table (docs/bugs.md)
	dw $290e ; record 75, past text bank $25's table (docs/bugs.md)
	dw $290f ; record 76, past text bank $25's table (docs/bugs.md)
	dw $2910 ; record 77, past text bank $25's table (docs/bugs.md)
	dw $2911 ; record 78, past text bank $25's table (docs/bugs.md)
	dw $2912 ; record 79, past text bank $25's table (docs/bugs.md)
	dw $2913 ; record 80, past text bank $25's table (docs/bugs.md)
	dw $2914 ; record 81, past text bank $25's table (docs/bugs.md)
	dw $2915 ; record 82, past text bank $25's table (docs/bugs.md)
	dw $2916 ; record 83, past text bank $25's table (docs/bugs.md)
	dw $2917 ; record 84, past text bank $25's table (docs/bugs.md)
	dw $2918 ; record 85, past text bank $25's table (docs/bugs.md)
	dw $2919 ; record 86, past text bank $25's table (docs/bugs.md)
	dw Text_26_15 ; record 87
	dw Text_26_16 ; record 88
	dw Text_26_17 ; record 89
	dw Text_26_18 ; record 90
	dw Text_26_19 ; record 91
	dw Text_26_20 ; record 92
	dw Text_26_21 ; record 93
	dw Text_26_22 ; record 94
	dw Text_26_23 ; record 95
	dw Text_26_24 ; record 96
	dw Text_26_25 ; record 97
	dw Text_26_26 ; record 98
	dw Text_26_27 ; record 99
	dw Text_26_28 ; record 100
	dw Text_26_29 ; record 101
	dw Text_26_30 ; record 102
	dw Text_26_31 ; record 103
	dw Text_26_32 ; record 104
	dw Text_26_33 ; record 105
	dw Text_26_34 ; record 106
	dw Text_26_35 ; record 107
	dw Text_26_36 ; record 108
Unused_0b_1:
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
QueueDrillSprite_0b:
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
