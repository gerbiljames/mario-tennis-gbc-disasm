StandingShadowOamTemplate:
	; $6301, 13 bytes (sprite_template)
	oam_sprite $02, $fc, $00, $00
	oam_sprite $02, $04, $02, $00
	oam_sprite $02, $0c, $04, $00
	oam_sprite_end
ClearSpriteSlots:
	ld a, $ff ; $630e
	ld [wNetBallSlot], a ; $6310
	ld [wBallSlot], a ; $6313
	ld [wBallTrailSlots], a ; $6316
	ld [wBallTrailSlots + 4], a ; $6319
	ld [wBallTrailSlots + 8], a ; $631c
	ld [wBallTrailSlots + 12], a ; $631f
	ld [wBallTrailSlots + 16], a ; $6322
	ld [wBallShadowSlot], a ; $6325
	wram_bank WRAM_CHAR3 ; $6328
	ld a, $ff ; $632e
	ld [wCharSpriteSlot], a ; $6330
	ld [wCharAirShadowSlot], a ; $6333
	ld [wCharGroundShadowSlot], a ; $6336
	wram_bank WRAM_CHAR2 ; $6339
	ld a, $ff ; $633f
	ld [wCharSpriteSlot], a ; $6341
	ld [wCharAirShadowSlot], a ; $6344
	ld [wCharGroundShadowSlot], a ; $6347
	wram_bank WRAM_CHAR1 ; $634a
	ld a, $ff ; $6350
	ld [wCharSpriteSlot], a ; $6352
	ld [wCharAirShadowSlot], a ; $6355
	ld [wCharGroundShadowSlot], a ; $6358
	wram_bank WRAM_CHAR0 ; $635b
	ld a, $ff ; $6361
	ld [wCharSpriteSlot], a ; $6363
	ld [wCharAirShadowSlot], a ; $6366
	ld [wCharGroundShadowSlot], a ; $6369
	ret ; $636c
DrawNearTeamChars:
	ld hl, wCharDepthKey ; $636d
	wram_bank WRAM_CHAR2 ; $6370
	ld b, [hl] ; $6376
	wram_bank WRAM_CHAR0 ; $6377
	ld a, [hl] ; $637d
	cp b ; $637e
	jr c, DrawNearTeamCharsDoubles ; $637f
	wram_bank WRAM_CHAR0 ; $6381
	ld hl, wCharSpriteSlot ; $6387
	call DrawCharSprite ; $638a
	wram_bank WRAM_CHAR2 ; $638d
	ld hl, wCharSpriteSlot ; $6393
	call DrawCharSprite ; $6396
	wram_bank WRAM_CHAR0 ; $6399
	ret ; $639f
DrawNearTeamCharsDoubles:
	wram_bank WRAM_CHAR2 ; $63a0
	ld hl, wCharSpriteSlot ; $63a6
	call DrawCharSprite ; $63a9
	wram_bank WRAM_CHAR0 ; $63ac
	ld hl, wCharSpriteSlot ; $63b2
	call DrawCharSprite ; $63b5
	wram_bank WRAM_CHAR0 ; $63b8
	ret ; $63be
DrawFarTeamChars:
	ld hl, wCharDepthKey ; $63bf
	wram_bank WRAM_CHAR3 ; $63c2
	ld b, [hl] ; $63c8
	wram_bank WRAM_CHAR1 ; $63c9
	ld a, [hl] ; $63cf
	cp b ; $63d0
	jr c, DrawFarTeamCharsDoubles ; $63d1
	wram_bank WRAM_CHAR1 ; $63d3
	ld hl, wCharSpriteSlot ; $63d9
	call DrawCharSprite ; $63dc
	wram_bank WRAM_CHAR3 ; $63df
	ld hl, wCharSpriteSlot ; $63e5
	call DrawCharSprite ; $63e8
	wram_bank WRAM_CHAR0 ; $63eb
	ret ; $63f1
DrawFarTeamCharsDoubles:
	wram_bank WRAM_CHAR3 ; $63f2
	ld hl, wCharSpriteSlot ; $63f8
	call DrawCharSprite ; $63fb
	wram_bank WRAM_CHAR1 ; $63fe
	ld hl, wCharSpriteSlot ; $6404
	call DrawCharSprite ; $6407
	wram_bank WRAM_ACTORS ; $640a
	ret ; $6410
DrawBallAndEffects:
	call DrawHitSpark ; $6411
	call DrawSpecialHitEffect ; $6414
	ld hl, wNetBallSlot ; $6417
	call DrawSlotSprite ; $641a
	ld hl, wBallSlot ; $641d
	call DrawSlotSprite ; $6420
	ld d, $07 ; $6423
	call CallModeHook ; $6425
	ret ; $6428
DrawActorsByDepth:
	ld a, [wMinigameUsesTennisMachine] ; $6429
	and a ; $642c
	jr nz, .done ; $642d
	ld hl, wCharDepthKey ; $642f
	wram_bank WRAM_TEXT ; $6432
	ld b, [hl] ; $6438
	wram_bank WRAM_ACTORS ; $6439
	ld a, [hl] ; $643f
	cp b ; $6440
	jr nc, .drawLoop ; $6441
	ld a, [wPointOutcome] ; $6443
	and a ; $6446
	jr z, .sortLoop ; $6447
	call DrawFarTeamChars ; $6449
	call DrawNearTeamChars ; $644c
	call DrawBallAndEffects ; $644f
	ret ; $6452
.sortLoop:
	call DrawFarTeamChars ; $6453
	call DrawBallAndEffects ; $6456
	call DrawNearTeamChars ; $6459
	ret ; $645c
.drawLoop:
	ld a, [wPointOutcome] ; $645d
	and a ; $6460
	jr z, .next ; $6461
	call DrawNearTeamChars ; $6463
	call DrawFarTeamChars ; $6466
	call DrawBallAndEffects ; $6469
	ret ; $646c
.next:
	call DrawNearTeamChars ; $646d
	call DrawBallAndEffects ; $6470
	call DrawFarTeamChars ; $6473
	ret ; $6476
.done:
	call DrawNearTeamChars ; $6477
	call DrawBallAndEffects ; $647a
	call DrawFarTeamChars ; $647d
	ret ; $6480
DrawMarkersAndShadows:
	call DrawTargetZone ; $6481
	call DrawLandingMarker ; $6484
	ld hl, wBallTrailSlots ; $6487
	call DrawSlotSprite ; $648a
	ld hl, wBallTrailSlots + 4 ; $648d
	call DrawSlotSprite ; $6490
	ld hl, wBallTrailSlots + 8 ; $6493
	call DrawSlotSprite ; $6496
	ld hl, wBallTrailSlots + 12 ; $6499
	call DrawSlotSprite ; $649c
	ld hl, wBallTrailSlots + 16 ; $649f
	call DrawSlotSprite ; $64a2
	call DrawBounceEffect ; $64a5
	ld hl, wCharAirShadowSlot ; $64a8
	wram_bank WRAM_CHAR3 ; $64ab
	call DrawSlotSprite ; $64b1
	ld hl, wCharAirShadowSlot ; $64b4
	wram_bank WRAM_CHAR2 ; $64b7
	call DrawSlotSprite ; $64bd
	ld hl, wCharAirShadowSlot ; $64c0
	wram_bank WRAM_CHAR1 ; $64c3
	call DrawSlotSprite ; $64c9
	ld hl, wCharAirShadowSlot ; $64cc
	wram_bank WRAM_CHAR0 ; $64cf
	call DrawSlotSprite ; $64d5
	ld hl, wBallShadowSlot ; $64d8
	call DrawSlotSprite ; $64db
	ld hl, wCharGroundShadowSlot ; $64de
	wram_bank WRAM_CHAR1 ; $64e1
	call DrawStandingShadowSlot ; $64e7
	ld hl, wCharGroundShadowSlot ; $64ea
	wram_bank WRAM_CHAR0 ; $64ed
	call DrawStandingShadowSlot ; $64f3
	wram_bank WRAM_CHAR0 ; $64f6
	ret ; $64fc
DrawSlotSprite:
	ld a, [hl+] ; $64fd
	cp $ff ; $64fe
	ret z ; $6500
	ld c, a ; $6501
	ld a, [hl+] ; $6502
	ld b, a ; $6503
	ld a, [hl+] ; $6504
	ld e, a ; $6505
	ld d, [hl] ; $6506
	jp QueueSprite ; $6507
DrawCharSprite:
	ld a, [hl+] ; $650a
	cp $ff ; $650b
	ret z ; $650d
	ld c, a ; $650e
	ld a, [hl+] ; $650f
	ld b, a ; $6510
	ld a, [hl+] ; $6511
	ld e, a ; $6512
	ld a, [hl+] ; $6513
	ld d, a ; $6514
	ld a, [wCharSpriteFrame] ; $6515
	ld h, a ; $6518
	ld a, [wCharSpriteFrame + 1] ; $6519
	ld l, a ; $651c
	ld a, [wCharSpriteFrame + 2] ; $651d
	and a ; $6520
	jp z, QueueSprite24x32 ; $6521
	jp QueueSprite32x32 ; $6524
DrawStandingShadowSlot:
	ld a, [hl+] ; $6527
	cp $ff ; $6528
	ret z ; $652a
	ld c, a ; $652b
	ld a, [hl+] ; $652c
	ld b, a ; $652d
	ld a, [hl+] ; $652e
	ld e, a ; $652f
	ld d, [hl] ; $6530
	ld hl, StandingShadowOamTemplate ; $6531
	jp QueueSpriteTemplate ; $6534
; Instruction-for-instruction the same as DrawSlotSprite, with the operands aimed at slot 16. Nothing calls it.
UnusedDrawStandingShadowSlot16:
	ld a, [hl+] ; $6537
	cp $ff ; $6538
	ret z ; $653a
	ld c, a ; $653b
	ld a, [hl+] ; $653c
	ld b, a ; $653d
	ld a, [hl+] ; $653e
	ld e, a ; $653f
	ld d, [hl] ; $6540
	jp QueueSprite16 ; $6541
InitMinigameMatchSettings:
	call InitDefaultMatchSettings ; $6544
	ld a, MATCHCONTEXT_MINIGAME ; $6547
	ld [wMatchContext], a ; $6549
	ld a, $01 ; $654c
	ld [wScoreDisplayIsTiebreak], a ; $654e
	ld a, $ff ; $6551
	ld [wAiServeAimOverride], a ; $6553
	ret ; $6556
RunMinigameMatch:
	ld c, $20 ; $6557
	call BeginFadeOut ; $6559
	call WaitFadeEnd ; $655c
	call AdvanceFrame ; $655f
	call DisableLCDSafely ; $6562
	call InitMatchScene ; $6565
	call EnableLCD ; $6568
	ld a, [wMatchBGM] ; $656b
	call PlaySoundManaged ; $656e
	script_fade_in $20 ; $6571
	xor a ; $6576
	ld [wMatchSimFrozen], a ; $6577
	call RunMinigamePointLoop ; $657a
	call ShowMatchResultScreens ; $657d
	ld c, $20 ; $6580
	call BeginFadeOut ; $6582
	call WaitFadeEnd ; $6585
	call AdvanceFrame ; $6588
	farcall LoadMenuFontGfx ; $658b
	call AdvanceFrame ; $658e
	ret ; $6591
ShowMatchResultScreens:
	ld a, [wMatchExitRequest] ; $6592
	and a ; $6595
	ret nz ; $6596
	ld a, $ff ; $6597
	ld [wMatchSimFrozen], a ; $6599
	ld [wMatchDrawFrozen], a ; $659c
	ld a, [wGameMode] ; $659f
	cp GAMEMODE_MARIO_MINIGAME ; $65a2
	jr nz, .scoreboard ; $65a4
	ld a, [wPointWinLoseFlag] ; $65a6
	cp WINLOSE_WIN ; $65a9
	jr z, .scoreboard ; $65ab
	farcall RunMinigameEndMenu ; $65ad
	jr .unfreeze ; $65b0
.scoreboard:
	farcall ShowMatchScoreboardScreen ; $65b2
.unfreeze:
	ld a, $00 ; $65b5
	ld [wMatchDrawFrozen], a ; $65b7
	ld [wMatchSimFrozen], a ; $65ba
	ret ; $65bd
RunMinigamePointLoop:
	wram_bank WRAM_CHAR0 ; $65be
	ld a, $00 ; $65c4
	ld [wAiPositionStrategy], a ; $65c6
	xor a ; $65c9
	ld [wAiReactionDelayNear], a ; $65ca
	ld [wAiReactionDelayFar], a ; $65cd
	ld a, $00 ; $65d0
	ld [wAiAimAwayChance], a ; $65d2
	ld d, $03 ; $65d5
	call CallModeHook ; $65d7
	ld a, [wMatchAbortFlag] ; $65da
	and MATCHABORT_MATCH ; $65dd
	jr nz, .done ; $65df
.pointLoop:
	call LoadMinigamePointLayout ; $65e1
	call ResetPointState ; $65e4
	ld d, $01 ; $65e7
	call CallModeHook ; $65e9
	ld a, [wMatchAbortFlag] ; $65ec
	and MATCHABORT_MATCH ; $65ef
	jr nz, .done ; $65f1
	ld a, [wMinigameUsesTennisMachine] ; $65f3
	and a ; $65f6
	jr nz, .playPoint ; $65f7
	ld hl, SetCharStateFromServeRole ; $65f9
	call ForEachCharBank ; $65fc
.playPoint:
	call PlayMinigamePoint ; $65ff
	ld a, [wMatchAbortFlag] ; $6602
	and MATCHABORT_MATCH ; $6605
	jr nz, .done ; $6607
	ld d, $02 ; $6609
	call CallModeHook ; $660b
	ld a, [wMatchAbortFlag] ; $660e
	and MATCHABORT_MATCH ; $6611
	jr nz, .done ; $6613
	ld hl, wMinigamePointTable ; $6615
	ld a, [hl+] ; $6618
	ld h, [hl] ; $6619
	ld l, a ; $661a
	ld a, [wTotalPointsScoredInCurrentGame] ; $661b
	add a ; $661e
	add a ; $661f
	add a ; $6620
	add l ; $6621
	ld l, a ; $6622
	jr nc, .nextPoint ; $6623
	inc h ; $6625
.nextPoint:
	ld a, [wModeHookBank] ; $6626
	call FarReadByte ; $6629
	cp $ff ; $662c
	jr nz, .pointLoop ; $662e
.done:
	ret ; $6630
PlayMinigamePoint:
	farcall LoadServeGfx ; $6631
	call StepMatchFrame ; $6634
	ld a, $01 ; $6637
	ld [wUnusedMinigamePointFlag], a ; $6639
.rallyLoop:
	call StepMatchFrame ; $663c
	ld a, [wMatchAbortFlag] ; $663f
	and MATCHABORT_POINT ; $6642
	jr nz, .pointOver ; $6644
	ld a, [wPointOutcome] ; $6646
	and a ; $6649
	jr z, .rallyLoop ; $664a
.pointOver:
	ld a, [wPointOutcome] ; $664c
	cp POINTOUTCOME_BALL_HIT_PLAYER ; $664f
	jr nz, .settle ; $6651
	ld a, $28 ; $6653
	call StepMatchFrames ; $6655
.settle:
	call EndPointBallEffects ; $6658
	call HandleServeFault ; $665b
	call FlagServiceReturnAce ; $665e
	ret ; $6661
LoadMinigamePointLayout:
	ld a, [wModeHookBank] ; $6662
	and a ; $6665
	ret z ; $6666
	add sp, -8 ; $6667
	ld hl, sp + 0 ; $6669
	ld e, l ; $666b
	ld d, h ; $666c
	push hl ; $666d
	ld hl, wMinigamePointTable ; $666e
	ld a, [hl+] ; $6671
	ld h, [hl] ; $6672
	ld l, a ; $6673
	ld a, [wTotalPointsScoredInCurrentGame] ; $6674
	add a ; $6677
	add a ; $6678
	add a ; $6679
	add l ; $667a
	ld l, a ; $667b
	jr nc, .copyLayout ; $667c
	inc h ; $667e
.copyLayout:
	ld a, [wModeHookBank] ; $667f
	ld bc, $0008 ; $6682
	call FarCopyBytes ; $6685
	pop hl ; $6688
	ld de, wCharCourtPos ; $6689
	wram_bank WRAM_CHAR0 ; $668c
	ld a, [hl+] ; $6692
	and $03 ; $6693
	ld [de], a ; $6695
	wram_bank WRAM_CHAR1 ; $6696
	ld a, [hl+] ; $669c
	and $03 ; $669d
	ld [de], a ; $669f
	wram_bank WRAM_CHAR2 ; $66a0
	ld a, [hl+] ; $66a6
	and $03 ; $66a7
	ld [de], a ; $66a9
	wram_bank WRAM_CHAR3 ; $66aa
	ld a, [hl+] ; $66b0
	and $03 ; $66b1
	ld [de], a ; $66b3
	ld de, wCharServeRole ; $66b4
	wram_bank WRAM_CHAR0 ; $66b7
	ld a, [hl+] ; $66bd
	and $03 ; $66be
	ld [de], a ; $66c0
	wram_bank WRAM_CHAR1 ; $66c1
	ld a, [hl+] ; $66c7
	and $03 ; $66c8
	ld [de], a ; $66ca
	wram_bank WRAM_CHAR2 ; $66cb
	ld a, [hl+] ; $66d1
	and $03 ; $66d2
	ld [de], a ; $66d4
	wram_bank WRAM_CHAR3 ; $66d5
	ld a, [hl+] ; $66db
	and $03 ; $66dc
	ld [de], a ; $66de
	wram_bank WRAM_ACTORS ; $66df
	call IdentifyServingPlayer ; $66e5
	ld hl, SetCharFacingFromCourtPos ; $66e8
	call ForEachCharBank ; $66eb
	add sp, 8 ; $66ee
	ret ; $66f0
CallModeHook:
	ld a, [wModeHookBank] ; $66f1
	and a ; $66f4
	ret z ; $66f5
	push af ; $66f6
	push bc ; $66f7
	push de ; $66f8
	push hl ; $66f9
	ld hl, wModeHookTable ; $66fa
	ld a, [hl+] ; $66fd
	ld h, [hl] ; $66fe
	ld l, a ; $66ff
	ld a, d ; $6700
	add a ; $6701
	add l ; $6702
	ld l, a ; $6703
	jr nc, .readHook ; $6704
	inc h ; $6706
.readHook:
	ld a, [wModeHookBank] ; $6707
	call FarReadWord ; $670a
	ld l, c ; $670d
	ld h, b ; $670e
	ld a, [wModeHookBank] ; $670f
	call CallHLInBankA ; $6712
	pop hl ; $6715
	pop de ; $6716
	pop bc ; $6717
	pop af ; $6718
	ret ; $6719
SetModeHookTable:
	push af ; $671a
	push hl ; $671b
	ld [wModeHookBank], a ; $671c
	ld hl, wModeHookTable ; $671f
	ld a, e ; $6722
	ld [hl+], a ; $6723
	ld [hl], d ; $6724
	pop hl ; $6725
	pop af ; $6726
	ret ; $6727
