ReadScriptedMatchInput:
	ldh a, [hLinkInput] ; $4425
	ret ; $4427
StepMatchFrames:
	ld b, a ; $4428
.loop:
	ld a, [wMatchFramesAbort] ; $4429
	and a ; $442c
	jr nz, .done ; $442d
	call StepMatchFrame ; $442f
	dec b ; $4432
	jr nz, .loop ; $4433
.done:
	ret ; $4435
StepMatchFramesSkippable:
	ld b, a ; $4436
.loop:
	ld a, [wMatchFramesAbort] ; $4437
	and a ; $443a
	jr nz, .done ; $443b
	call StepMatchFrame ; $443d
	call ReadMatchInputHeld ; $4440
	and $03 ; $4443
	jr nz, .done ; $4445
	ld a, [wDebugMatchFlags] ; $4447
	bit 0, a ; $444a
	jr nz, .loop ; $444c
	dec b ; $444e
	jr nz, .loop ; $444f
.done:
	ret ; $4451
RunMatchFramesUntilInput:
	ld a, [wMatchFramesAbort] ; $4452
	and a ; $4455
	jr nz, .done ; $4456
	call StepMatchFrame ; $4458
	call ReadMatchInputHeld ; $445b
	and $f3 ; $445e
	jr nz, .done ; $4460
	jr RunMatchFramesUntilInput ; $4462
.done:
	ret ; $4464
StepMatchFrame:
	push af ; $4465
	push bc ; $4466
	push de ; $4467
	push hl ; $4468
	ldh a, [hWramBank] ; $4469
	push af ; $446b
	ldh a, [hLinkExchangeActive] ; $446c
	and a ; $446e
	jr z, .localFrame ; $446f
	farcall RunLinkMatchFrame ; $4471
	jr .afterFrame ; $4474
.localFrame:
	call AdvanceFrame ; $4476
	call UpdateMatchFrame ; $4479
	ld hl, hMatchFrameCounter ; $447c
	inc [hl] ; $447f
.afterFrame:
	ld a, [wMatchSimFrozen] ; $4480
	and a ; $4483
	jr nz, .done ; $4484
	call HandlePauseMenu ; $4486
	call CheckDebugStatsEditorHotkey ; $4489
.done:
	pop_wram_bank ; $448c
	pop hl ; $4491
	pop de ; $4492
	pop bc ; $4493
	pop af ; $4494
	ret ; $4495
HandlePauseMenu:
	call ReadMatchInputPressed ; $4496
	and $08 ; $4499
	ret z ; $449b
	ld a, [wPauseDisabled] ; $449c
	and a ; $449f
	ret nz ; $44a0
	ld a, [wMatchWinLoseFlag] ; $44a1
	and a ; $44a4
	ret nz ; $44a5
	ld a, $ff ; $44a6
	ld [wMatchSimFrozen], a ; $44a8
	ld [wMatchDrawFrozen], a ; $44ab
	farcall RunMatchPauseMenu ; $44ae
	call ReinitPointAfterPause ; $44b1
	ld a, $00 ; $44b4
	ld [wMatchDrawFrozen], a ; $44b6
	ld [wMatchSimFrozen], a ; $44b9
	ret ; $44bc
ReinitPointAfterPause:
	ld a, [wCourtViewLocked] ; $44bd
	and a ; $44c0
	ret nz ; $44c1
	call AssignCourtPositions ; $44c2
	ld a, [wCourtViewFlipChanged] ; $44c5
	and a ; $44c8
	ret z ; $44c9
	call RefreshCourtAfterEndChange ; $44ca
	call ResetCameraForServe ; $44cd
	call UpdateMatchCamera ; $44d0
	ld hl, MoveCharToBaseCourtPosition ; $44d3
	call ForEachCharBank ; $44d6
	farcall LoadServeGfx ; $44d9
	ld a, [wServingCharWramBank] ; $44dc
	wram_bank ; $44df
	ld a, CHARSTATE_SERVE ; $44e3
	call SetCharState ; $44e5
	wram_bank $04 ; $44e8
	ret ; $44ee
CheckDebugStatsEditorHotkey:
	ret ; $44ef
	call ReadMatchInputPressed ; $44f0
	and $04 ; $44f3
	ret z ; $44f5
	ldh a, [hDebugStepMode] ; $44f6
	and a ; $44f8
	ret z ; $44f9
	ld a, $ff ; $44fa
	ld [wMatchSimFrozen], a ; $44fc
	ld [wMatchDrawFrozen], a ; $44ff
	farcall RunDebugStatsEditor ; $4502
	ld a, $00 ; $4505
	ld [wMatchSimFrozen], a ; $4507
	ld [wMatchDrawFrozen], a ; $450a
	ret ; $450d
InitViewFlipPreference:
	ld a, [wGameMode] ; $450e
	cp GAMEMODE_LINK_MATCH ; $4511
	jr z, .storeFlip ; $4513
	ld a, [wMatchContext] ; $4515
	cp MATCHCONTEXT_MINIGAME ; $4518
	jr z, .storeFlip ; $451a
	ld a, [wGameMode] ; $451c
	cp GAMEMODE_MARIO_MINIGAME ; $451f
	jr z, .storeFlip ; $4521
	farcall TestStorySlotFlagB ; $4523
	ld [wCourtViewOption], a ; $4526
	xor a ; $4529
	ld [wCourtViewLocked], a ; $452a
	ret ; $452d
.storeFlip:
	ld a, $00 ; $452e
	ld [wCourtViewOption], a ; $4530
	ld a, $01 ; $4533
	ld [wCourtViewLocked], a ; $4535
	ret ; $4538
ApplyMatchBgmPreference:
	ld a, [wGameMode] ; $4539
	cp GAMEMODE_LINK_MATCH ; $453c
	jr z, .resume ; $453e
	farcall TestStorySlotFlagA ; $4540
	call SetMusicMuted ; $4543
	ret ; $4546
.resume:
	call ResumeBGM ; $4547
	ret ; $454a
SelectScoreboardLayout:
	ld a, [wMatchContext] ; $454b
	cp MATCHCONTEXT_MINIGAME ; $454e
	jr z, .doubles ; $4550
	ld a, [wOnCourtCharCount] ; $4552
	sub $02 ; $4555
	and $03 ; $4557
	ld [wScoreboardLayout], a ; $4559
	ret ; $455c
.doubles:
	ld b, $03 ; $455d
	ld a, [wDrillIsPracticeLesson] ; $455f
	and a ; $4562
	jr nz, .done ; $4563
	ld b, $07 ; $4565
	ld a, [wMinigameHighScoreMode] ; $4567
	and a ; $456a
	jr nz, .done ; $456b
	ld b, $06 ; $456d
	ld a, [wMinigameUsesWall] ; $456f
	and a ; $4572
	jr nz, .done ; $4573
	ld a, [wMinigameUsesTennisMachine] ; $4575
	and a ; $4578
	jr nz, .done ; $4579
	ld a, [wMinigameIsBooBlast] ; $457b
	and a ; $457e
	jr nz, .done ; $457f
	ld b, $04 ; $4581
.done:
	ld a, b ; $4583
	ld [wScoreboardLayout], a ; $4584
	ret ; $4587
UnusedTickTimerTrampoline:
	jp TickTimer ; $4588
SetBallPosition:
	push hl ; $458b
	xor a ; $458c
	ld hl, wBallHeightFrac ; $458d
	ld [hl+], a ; $4590
	ld [hl+], a ; $4591
	ld a, c ; $4592
	ld [hl+], a ; $4593
	ld [hl], b ; $4594
	xor a ; $4595
	ld hl, wBallDepthFrac ; $4596
	ld [hl+], a ; $4599
	ld [hl+], a ; $459a
	ld a, e ; $459b
	ld [hl+], a ; $459c
	ld [hl], d ; $459d
	pop de ; $459e
	xor a ; $459f
	ld hl, wBallXFrac ; $45a0
	ld [hl+], a ; $45a3
	ld [hl+], a ; $45a4
	ld a, e ; $45a5
	ld [hl+], a ; $45a6
	ld [hl], d ; $45a7
	ret ; $45a8
SetBallVelocityPolar:
	ld a, l ; $45a9
	ld [wBallVelocityPolarLength], a ; $45aa
	ld a, h ; $45ad
	ld [wBallVelocityPolarLength + 1], a ; $45ae
	push de ; $45b1
	call MulSinCosSigned ; $45b2
	ld c, l ; $45b5
	ld b, h ; $45b6
	xor a ; $45b7
	ld hl, wBallVelocityHeightFrac ; $45b8
	ld [hl+], a ; $45bb
	ld a, e ; $45bc
	ld [hl+], a ; $45bd
	ld [hl], d ; $45be
	ld l, c ; $45bf
	ld h, b ; $45c0
	pop bc ; $45c1
	call MulSinCosSigned ; $45c2
	ld c, l ; $45c5
	ld b, h ; $45c6
	xor a ; $45c7
	ld hl, wBallVelocityXFrac ; $45c8
	ld [hl+], a ; $45cb
	ld a, c ; $45cc
	ld [hl+], a ; $45cd
	ld [hl], b ; $45ce
	xor a ; $45cf
	ld hl, wBallVelocityDepthFrac ; $45d0
	ld [hl+], a ; $45d3
	ld a, e ; $45d4
	ld [hl+], a ; $45d5
	ld [hl], d ; $45d6
	ret ; $45d7
SetBallSpinComponents:
	ld hl, wBallSideSpin ; $45d8
	ld a, e ; $45db
	ld [hl+], a ; $45dc
	ld [hl], d ; $45dd
	ld hl, wBallTopspin ; $45de
	ld a, c ; $45e1
	ld [hl+], a ; $45e2
	ld [hl], b ; $45e3
	ret ; $45e4
UpdateBallAnglesAndSpeed:
	ld hl, wBallVelocityX ; $45e5
	ld a, [hl+] ; $45e8
	ld d, [hl] ; $45e9
	ld e, a ; $45ea
	ld hl, wBallVelocityDepth ; $45eb
	ld a, [hl+] ; $45ee
	ld h, [hl] ; $45ef
	ld l, a ; $45f0
	call AngleFromVector16 ; $45f1
	ld hl, wBallHeadingAngle ; $45f4
	ld a, c ; $45f7
	ld [hl+], a ; $45f8
	ld [hl], b ; $45f9
	ld hl, wBallVelocityDepth ; $45fa
	ld a, [hl+] ; $45fd
	ld d, [hl] ; $45fe
	ld e, a ; $45ff
	ld hl, wBallVelocityX ; $4600
	ld a, [hl+] ; $4603
	ld h, [hl] ; $4604
	ld l, a ; $4605
	call VectorLengthFromAngle ; $4606
	ld e, l ; $4609
	ld d, h ; $460a
	ld hl, wBallSpeedHorizontalFrac ; $460b
	xor a ; $460e
	ld [hl+], a ; $460f
	ld a, e ; $4610
	ld [hl+], a ; $4611
	ld [hl], d ; $4612
	ld hl, wBallVelocityHeight ; $4613
	ld a, [hl+] ; $4616
	ld h, [hl] ; $4617
	ld l, a ; $4618
	call AngleFromVector16 ; $4619
	ld hl, wBallPitchAngle ; $461c
	ld a, c ; $461f
	ld [hl+], a ; $4620
	ld [hl], b ; $4621
	ld hl, wBallVelocityHeight ; $4622
	ld a, [hl+] ; $4625
	ld d, [hl] ; $4626
	ld e, a ; $4627
	ld hl, wBallSpeedHorizontal ; $4628
	ld a, [hl+] ; $462b
	ld h, [hl] ; $462c
	ld l, a ; $462d
	call VectorLengthFromAngle ; $462e
	ld e, l ; $4631
	ld d, h ; $4632
	ld hl, wBallSpeed3D ; $4633
	ld a, e ; $4636
	ld [hl+], a ; $4637
	ld [hl], d ; $4638
	ret ; $4639
CheckBallOutOfBounds:
	ld d, $00 ; $463a
	ld hl, wCourtLimitX ; $463c
	ld a, [hl+] ; $463f
	ld b, [hl] ; $4640
	ld c, a ; $4641
	ld hl, wBallX ; $4642
	ld a, [hl+] ; $4645
	ld h, [hl] ; $4646
	ld l, a ; $4647
	bit 7, h ; $4648
	jr z, .checkDepth ; $464a
	xor a ; $464c
	sub l ; $464d
	ld l, a ; $464e
	sbc a ; $464f
	sub h ; $4650
	ld h, a ; $4651
.checkDepth:
	add hl, bc ; $4652
	jr nc, .outOfBounds ; $4653
	set 0, d ; $4655
.outOfBounds:
	ld hl, wCourtLimitDepth ; $4657
	ld a, [hl+] ; $465a
	ld b, [hl] ; $465b
	ld c, a ; $465c
	ld hl, wBallDepth ; $465d
	ld a, [hl+] ; $4660
	ld h, [hl] ; $4661
	ld l, a ; $4662
	bit 7, h ; $4663
	jr z, .inBounds ; $4665
	xor a ; $4667
	sub l ; $4668
	ld l, a ; $4669
	sbc a ; $466a
	sub h ; $466b
	ld h, a ; $466c
.inBounds:
	add hl, bc ; $466d
	jr nc, .done ; $466e
	set 1, d ; $4670
.done:
	ld a, d ; $4672
	ld [wBallOutOfBoundsBits], a ; $4673
	ret ; $4676
GetBallHeightSign:
	ld hl, wBallHeightFrac ; $4677
	ld a, [hl+] ; $467a
	or [hl] ; $467b
	inc hl ; $467c
	or [hl] ; $467d
	inc hl ; $467e
	or [hl] ; $467f
	jr z, .done ; $4680
	ld a, $01 ; $4682
	bit 7, [hl] ; $4684
	jr z, .done ; $4686
	ld a, $ff ; $4688
.done:
	ret ; $468a
MulMem24ByFrac:
	inc hl ; $468b
	inc hl ; $468c
	ld a, [hl-] ; $468d
	ld d, a ; $468e
	ld a, [hl-] ; $468f
	ld e, a ; $4690
	ld a, [hl] ; $4691
	bit 7, d ; $4692
	jr nz, .negate ; $4694
	ld l, e ; $4696
	ld h, d ; $4697
	ld a, b ; $4698
	call MulHLByAFracSigned ; $4699
	xor a ; $469c
	ld e, l ; $469d
	ld d, h ; $469e
	ret ; $469f
.negate:
	call NegateADE ; $46a0
	ld l, e ; $46a3
	ld h, d ; $46a4
	ld a, b ; $46a5
	call MulHLByAFracSigned ; $46a6
	xor a ; $46a9
	ld e, l ; $46aa
	ld d, h ; $46ab
	call NegateADE ; $46ac
	ret ; $46af
ApplyCourtBounceDamping:
	ld hl, wBallVelocityXFrac ; $46b0
	ld a, [wCourtSurfaceFriction] ; $46b3
	ld b, a ; $46b6
	call MulMem24ByFrac ; $46b7
	ld hl, wBallVelocityXFrac ; $46ba
	ld [hl+], a ; $46bd
	ld a, e ; $46be
	ld [hl+], a ; $46bf
	ld a, d ; $46c0
	ld [hl+], a ; $46c1
	ld hl, wBallVelocityDepthFrac ; $46c2
	ld a, [wCourtSurfaceFriction] ; $46c5
	ld b, a ; $46c8
	call MulMem24ByFrac ; $46c9
	ld hl, wBallVelocityDepthFrac ; $46cc
	ld [hl+], a ; $46cf
	ld a, e ; $46d0
	ld [hl+], a ; $46d1
	ld a, d ; $46d2
	ld [hl+], a ; $46d3
	ld hl, wBallVelocityHeightFrac ; $46d4
	ld a, [wCourtSurfaceBounce] ; $46d7
	ld b, a ; $46da
	call MulMem24ByFrac ; $46db
	ld hl, wBallVelocityHeightFrac ; $46de
	ld [hl+], a ; $46e1
	ld a, e ; $46e2
	ld [hl+], a ; $46e3
	ld a, d ; $46e4
	ld [hl+], a ; $46e5
	ret ; $46e6
FindServerCharBank:
	ld hl, wCharServeRole ; $46e7
	ld b, $04 ; $46ea
	ld a, b ; $46ec
	wram_bank ; $46ed
	ld a, [hl] ; $46f1
	and a ; $46f2
	jr z, .setBank ; $46f3
	ld b, $05 ; $46f5
	ld a, b ; $46f7
	wram_bank ; $46f8
	ld a, [hl] ; $46fc
	and a ; $46fd
	jr z, .setBank ; $46fe
	ld b, $06 ; $4700
	ld a, b ; $4702
	wram_bank ; $4703
	ld a, [hl] ; $4707
	and a ; $4708
	jr z, .setBank ; $4709
	ld b, $07 ; $470b
.setBank:
	wram_bank $04 ; $470d
	ret ; $4713
