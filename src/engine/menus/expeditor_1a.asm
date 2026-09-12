CheckDebugExpEditorHotkey:
	push af ; $4399
	ldh a, [hDebugStepMode] ; $439a
	or a ; $439c
	jr z, .restore ; $439d
	ldh a, [hPlayerInputFlags] ; $439f
	bit PADB_SELECT, a ; $43a1
	jr z, .restore ; $43a3
	call RunDebugExpEditor ; $43a5
.restore:
	pop af ; $43a8
	ret ; $43a9
RunDebugExpEditor:
	push af ; $43aa
	push bc ; $43ab
	push de ; $43ac
	push hl ; $43ad
	push_wram_bank WRAM_TEXT ; $43ae
	ld de, $0000 ; $43b7
	ld bc, $1404 ; $43ba
	farcall CreateWindow ; $43bd
	ld [wPauseMenuWindowId], a ; $43c0
	farcall RestoreShadowTilemap ; $43c3
	farcall StubNop_05_0 ; $43c6
	ld c, $00 ; $43c9
.loop:
	ld hl, wStoryMainCharExp ; $43cb
	ld a, [hl+] ; $43ce
	ld h, [hl] ; $43cf
	ld l, a ; $43d0
	ld a, $04 ; $43d1
	ld de, wWindowShadowTilemap ; $43d3
	call FormatDecimalNumber ; $43d6
	ld hl, wWindowShadowTilemap ; $43d9
	ld de, $0801 ; $43dc
	ld a, [wPauseMenuWindowId] ; $43df
	farcall WriteStringToWindow ; $43e2
	ld hl, wStoryPartnerCharExp ; $43e5
	ld a, [hl+] ; $43e8
	ld h, [hl] ; $43e9
	ld l, a ; $43ea
	ld a, $04 ; $43eb
	ld de, wWindowShadowTilemap ; $43ed
	call FormatDecimalNumber ; $43f0
	ld hl, wWindowShadowTilemap ; $43f3
	ld de, $0802 ; $43f6
	ld a, [wPauseMenuWindowId] ; $43f9
	farcall WriteStringToWindow ; $43fc
	farcall RestoreShadowTilemap ; $43ff
	farcall StubNop_05_0 ; $4402
	call AdvanceFrame ; $4405
	ldh a, [hPlayerInputFlags] ; $4408
	and PADF_A ; $440a
	jr z, .checkPlayerInputFlags ; $440c
	sound SFX_MENU_SELECT ; $440e
	ld de, $0064 ; $4410
	call DebugAddExp ; $4413
	jr .loop ; $4416
.checkPlayerInputFlags:
	ldh a, [hPlayerInputFlags] ; $4418
	and PADF_RIGHT ; $441a
	jr z, .checkPlayerInputFlags2 ; $441c
	sound SFX_MENU_MOVE ; $441e
	ld de, $000a ; $4420
	call DebugAddExp ; $4423
	jr .loop ; $4426
.checkPlayerInputFlags2:
	ldh a, [hPlayerInputFlags] ; $4428
	and PADF_LEFT ; $442a
	jr z, .checkPlayerInputFlags3 ; $442c
	sound SFX_MENU_MOVE ; $442e
	ld de, $0001 ; $4430
	call DebugAddExp ; $4433
	jr .loop ; $4436
.checkPlayerInputFlags3:
	ldh a, [hPlayerInputFlags] ; $4438
	and PADF_UP | PADF_DOWN ; $443a
	jr z, .checkPlayerInputFlags4 ; $443c
	sound SFX_MENU_CANCEL ; $443e
	ld a, c ; $4440
	xor $01 ; $4441
	ld c, a ; $4443
	jr .loop ; $4444
.checkPlayerInputFlags4:
	ldh a, [hPlayerInputFlags] ; $4446
	and PADF_B ; $4448
	jp z, .loop ; $444a
	ld a, [wPauseMenuWindowId] ; $444d
	farcall CloseWindow ; $4450
	ld hl, wStoryMainCharExp ; $4453
	ld a, [hl+] ; $4456
	ld d, [hl] ; $4457
	ld e, a ; $4458
	ld l, $00 ; $4459
	call ResetCharDataScreenAnim ; $445b
	ld hl, wStoryPartnerCharExp ; $445e
	ld a, [hl+] ; $4461
	ld d, [hl] ; $4462
	ld e, a ; $4463
	ld l, $01 ; $4464
	call ResetCharDataScreenAnim ; $4466
	pop_wram_bank ; $4469
	pop hl ; $446e
	pop de ; $446f
	pop bc ; $4470
	pop af ; $4471
	ret ; $4472
DebugAddExp:
	ld a, c ; $4473
	or a ; $4474
	jr nz, .nonZero ; $4475
	push bc ; $4477
	farcall AddPlayerExp ; $4478
	pop bc ; $447b
	ret ; $447c
.nonZero:
	push bc ; $447d
	farcall AddPlayerExp ; $447e
	pop bc ; $4481
	ret ; $4482
ExtendModifierByteTable0:
	; $4483, 24 bytes (bytes:16)
	db $01, $01, $01, $7e, $de, $9d, $76, $72, $89, $82, $82, $de, $77, $66, $20, $20 ; 0x00
	db $20, $20, $20, $20, $20, $20, $20, $00 ; 0x10
ExtendModifierByteGfx1:
	; $449b, 13 bytes (bytes:13)
	db $01, $03, $01, $cc, $df, $da, $b2, $7c, $8f, $7d, $76, $3f, $00 ; 0x00
ExtendModifierByteTable2:
	; $44a8, 25 bytes (bytes:16)
	db $01, $01, $01, $81, $6d, $73, $80, $de, $9d, $c3, $de, $b0, $c0, $76, $de, $20 ; 0x00
	db $77, $74, $83, $7c, $8f, $72, $8f, $7d, $00 ; 0x10
ExtendModifierByteGfx3:
	; $44c1, 23 bytes (bytes:13)
	db $01, $03, $01, $96, $9b, $7c, $72, $83, $de, $7d, $76, $3f, $00 ; 0x00
	db $08, $10, $01, $bd, $ba, $b1, $20, $60, $30, $00 ; 0x0d
ShowExpGainScreen:
	push bc ; $44d8
	push de ; $44d9
	push hl ; $44da
	push af ; $44db
	ld a, l ; $44dc
	ld [wStoryCharacterSlot], a ; $44dd
	pop af ; $44e0
	ld h, a ; $44e1
	ldh a, [hWramBank] ; $44e2
	push af ; $44e4
	push hl ; $44e5
	ld c, $10 ; $44e6
	call BeginFadeOut ; $44e8
	call WaitFadeEnd ; $44eb
	call ClearFrameTasks ; $44ee
	farcall InitTextWindows ; $44f1
	farcall LoadMenuFontGfx ; $44f4
	call DisableLCDSafely ; $44f7
	call ClearSpriteQueue ; $44fa
	xor a ; $44fd
	ldh [hScrollY], a ; $44fe
	ldh [hScrollX], a ; $4500
	pop hl ; $4502
	push hl ; $4503
	call LoadExpScreenGfx ; $4504
	call DrawExpScreenNameAndLevel ; $4507
	pop hl ; $450a
	ld a, h ; $450b
	cp $00 ; $450c
	jr nz, .done ; $450e
	call DrawExpScreenYesNoBox ; $4510
	ld a, $0e ; $4513
	ld hl, StubNop_1a_0 ; $4515
	call RegisterFrameTask ; $4518
	call StubNop_1a_1 ; $451b
	jp .queueVRAMCopy ; $451e
	call StubNop_1a_2 ; $4521
	jp .queueVRAMCopy ; $4524
.done:
	pop_wram_bank ; $4527
	pop hl ; $452c
	pop de ; $452d
	ld b, h ; $452e
	ldh a, [hWramBank] ; $452f
	push af ; $4531
	push hl ; $4532
	push de ; $4533
	ld a, b ; $4534
	call DrawExpScreenCaption ; $4535
	wram_bank WRAM_SCENE ; $4538
	push af ; $453e
	ld hl, wStoryModeNameOfMainCharacter ; $453f
	ld a, [wStoryCharacterSlot] ; $4542
	or a ; $4545
	jr z, .gotRecord ; $4546
	ld l, $40 ; $4548
.gotRecord:
	ld a, l ; $454a
	add $18 ; $454b
	ld l, a ; $454d
	ld a, h ; $454e
	adc $00 ; $454f
	ld h, a ; $4551
	pop af ; $4552
	ld a, [hl] ; $4553
	cp $63 ; $4554
	jr z, .captionMaxLevel ; $4556
	ld a, $02 ; $4558
	call DrawExpScreenCaption ; $455a
	jr .captionDrawn ; $455d
.captionMaxLevel:
	ld a, $05 ; $455f
	call DrawExpScreenCaption ; $4561
.captionDrawn:
	pop de ; $4564
	push de ; $4565
	wram_bank WRAM_SCENE ; $4566
	ld hl, wExpAwardTotal ; $456c
	ld a, e ; $456f
	ld [hl+], a ; $4570
	ld [hl], d ; $4571
	inc hl ; $4572
	xor a ; $4573
	ld [hl+], a ; $4574
	ld [hl+], a ; $4575
	ld a, $1c ; $4576
	ld [hl+], a ; $4578
	ld a, $6c ; $4579
	ld [hl+], a ; $457b
	ld a, $ca ; $457c
	ld [hl+], a ; $457e
	ld a, $0f ; $457f
	ld [hl+], a ; $4581
	xor a ; $4582
	ld [hl+], a ; $4583
	ld [hl+], a ; $4584
	ld [hl], a ; $4585
	pop de ; $4586
	pop hl ; $4587
	push hl ; $4588
	push de ; $4589
	ld a, l ; $458a
	ld [wExpAwardSlot], a ; $458b
	ld de, $0000 ; $458e
	farcall GetExpRemainingToNextLevel ; $4591
	ld d, h ; $4594
	ld e, l ; $4595
	ld hl, wExpToNextLevel ; $4596
	ld a, e ; $4599
	ld [hl+], a ; $459a
	ld [hl], d ; $459b
	ld hl, wExpToNextDisplayed ; $459c
	ld a, e ; $459f
	ld [hl+], a ; $45a0
	ld [hl], d ; $45a1
	ld hl, wExpToNextSprite ; $45a2
	ld a, $68 ; $45a5
	ld [hl+], a ; $45a7
	ld a, $84 ; $45a8
	ld [hl+], a ; $45aa
	ld a, $ca ; $45ab
	ld [hl+], a ; $45ad
	ld a, $08 ; $45ae
	ld [hl+], a ; $45b0
	xor a ; $45b1
	ld [wExpLevelUpQueued], a ; $45b2
	ld [wExpScreenFlags], a ; $45b5
	wram_bank WRAM_STAGING ; $45b8
	ld hl, wDecompBuffer ; $45be
	ld de, vBGMap0 + VRAM_BANK1 ; $45c1
	ld c, $24 ; $45c4
	call QueueVRAMCopy ; $45c6
	ld hl, wDecompBuffer + 64 * TILE_SIZE ; $45c9
	ld de, vBGMap0 ; $45cc
	ld c, $24 ; $45cf
	call QueueVRAMCopy ; $45d1
	call CopyMapToScrollBuffers ; $45d4
	ld a, $0f ; $45d7
	ld hl, ExpScreenDrawTask ; $45d9
	call RegisterFrameTask ; $45dc
	call EnableLCD ; $45df
	script_fade_in $10 ; $45e2
	call WaitFadeEnd ; $45e7
	ld a, $0f ; $45ea
	ld hl, ExpScreenNumberTask ; $45ec
	call RegisterFrameTask ; $45ef
	wram_bank WRAM_SCENE ; $45f2
	pop de ; $45f8
	pop hl ; $45f9
	push hl ; $45fa
	push de ; $45fb
	ld a, h ; $45fc
	sub $04 ; $45fd
	jp z, .finish ; $45ff
	ld hl, wExpAwardTotal ; $4602
	ld a, [hl+] ; $4605
	ld h, [hl] ; $4606
	ld l, a ; $4607
	ld a, h ; $4608
	or l ; $4609
	jp z, .finish ; $460a
.fillLoop:
	call AdvanceExpGaugeFill ; $460d
	ld a, [wExpCountDone] ; $4610
	and a ; $4613
	jr nz, .levelUp ; $4614
	ld a, [wExpCountFastForward] ; $4616
	and a ; $4619
	jr nz, .gaugeFull ; $461a
	ldh a, [hPlayerInputFlags] ; $461c
	and PADF_A | PADF_B ; $461e
	jr nz, .gaugeFull ; $4620
	sound SFX_MENU_MOVE ; $4622
	wait_frames $04 ; $4624
	jr .fillLoop ; $4628
.gaugeFull:
	ld a, $01 ; $462a
	ld [wExpCountFastForward], a ; $462c
	sound SFX_MENU_SELECT ; $462f
	call AdvanceExpGaugeFill ; $4631
	ld hl, wExpAwardTotal ; $4634
	ld a, [hl+] ; $4637
	ld h, [hl] ; $4638
	ld l, a ; $4639
	ld de, $fc18 ; $463a
	add hl, de ; $463d
	jr nc, .nextFrame ; $463e
	ld hl, wExpAwardTotal ; $4640
	ld a, [hl+] ; $4643
	ld h, [hl] ; $4644
	ld l, a ; $4645
	ld de, $d8f0 ; $4646
	add hl, de ; $4649
	jr nc, .fastFill ; $464a
	call AdvanceExpGaugeFill ; $464c
	call AdvanceExpGaugeFill ; $464f
	call AdvanceExpGaugeFill ; $4652
	call AdvanceExpGaugeFill ; $4655
	call AdvanceExpGaugeFill ; $4658
	call AdvanceExpGaugeFill ; $465b
	call AdvanceExpGaugeFill ; $465e
	call AdvanceExpGaugeFill ; $4661
.fastFill:
	call AdvanceExpGaugeFill ; $4664
	call AdvanceExpGaugeFill ; $4667
	call AdvanceExpGaugeFill ; $466a
	call AdvanceExpGaugeFill ; $466d
	call AdvanceExpGaugeFill ; $4670
	call AdvanceExpGaugeFill ; $4673
.nextFrame:
	call AdvanceFrame ; $4676
	jr .fillLoop ; $4679
.levelUp:
	sound SFX_MENU_SELECT ; $467b
	ld a, [wExpBonusPending] ; $467d
	and a ; $4680
	jr z, .finish ; $4681
	push af ; $4683
	wram_bank WRAM_SCENE ; $4684
	ld c, $00 ; $468a
	ld a, [wCharDataAnimCounter] ; $468c
	and a ; $468f
	jr nz, .storeScroll ; $4690
	ld c, $fc ; $4692
.storeScroll:
	ld a, c ; $4694
	ld hl, wExpNumberSpriteShiftX ; $4695
	ld [hl], a ; $4698
	ld b, $28 ; $4699
.bonusWaitLoop:
	ld hl, wExpNumberSpriteShiftX ; $469b
	ld a, [hl] ; $469e
	and a ; $469f
	jr z, .bonusFrame ; $46a0
	inc a ; $46a2
	ld [hl], a ; $46a3
.bonusFrame:
	call AdvanceFrame ; $46a4
	dec b ; $46a7
	jr z, .bonusDone ; $46a8
	ldh a, [hInputRisingEdge] ; $46aa
	or a ; $46ac
	jr z, .bonusWaitLoop ; $46ad
.bonusDone:
	pop af ; $46af
	call DrawExpBonusMessage ; $46b0
	sound SFX_MENU_SELECT ; $46b3
	wait_frames $14 ; $46b5
	wram_bank WRAM_SCENE ; $46b9
	ld hl, wExpBonusAmount ; $46bf
	ld a, [hl+] ; $46c2
	ld d, [hl] ; $46c3
	ld e, a ; $46c4
	ld hl, wExpAwardTotal ; $46c5
	ld a, [hl+] ; $46c8
	ld h, [hl] ; $46c9
	ld l, a ; $46ca
	add hl, de ; $46cb
	ld d, h ; $46cc
	ld e, l ; $46cd
	ld hl, wExpAwardTotal ; $46ce
	ld a, e ; $46d1
	ld [hl+], a ; $46d2
	ld [hl], d ; $46d3
	xor a ; $46d4
	ld [wExpBonusPending], a ; $46d5
	ld [wExpCountDone], a ; $46d8
	jp .fillLoop ; $46db
.finish:
	wram_bank WRAM_SCENE ; $46de
	ld c, $00 ; $46e4
	ld a, [wCharDataAnimCounter] ; $46e6
	and a ; $46e9
	jr nz, .storeFinalScroll ; $46ea
	ld c, $fc ; $46ec
.storeFinalScroll:
	ld a, c ; $46ee
	ld hl, wExpNumberSpriteShiftX ; $46ef
	ld [hl], a ; $46f2
	ld b, $f0 ; $46f3
.finalWaitLoop:
	ld hl, wExpNumberSpriteShiftX ; $46f5
	ld a, [hl] ; $46f8
	and a ; $46f9
	jr z, .finalFrame ; $46fa
	inc a ; $46fc
	ld [hl], a ; $46fd
.finalFrame:
	call AdvanceFrame ; $46fe
	dec b ; $4701
	jr z, .fadeOut ; $4702
	ldh a, [hInputRisingEdge] ; $4704
	or a ; $4706
	jr z, .finalWaitLoop ; $4707
.fadeOut:
	ld c, $10 ; $4709
	call BeginFadeOut ; $470b
	call WaitFadeEnd ; $470e
	ld hl, ExpScreenDrawTask ; $4711
	call UnregisterFrameTask ; $4714
	ld hl, ExpScreenNumberTask ; $4717
	call UnregisterFrameTask ; $471a
	call AdvanceFrame ; $471d
	pop de ; $4720
	pop hl ; $4721
	pop_wram_bank ; $4722
	pop bc ; $4727
	wram_bank WRAM_SCENE ; $4728
	ld hl, wExpAwardTotal ; $472e
	ld a, [hl+] ; $4731
	ld d, [hl] ; $4732
	ld e, a ; $4733
	ld a, d ; $4734
	or e ; $4735
	ret z ; $4736
	ld a, [wExpAwardSlot] ; $4737
	farcall AddPlayerExp ; $473a
	ret ; $473d
.queueVRAMCopy:
	wram_bank WRAM_STAGING ; $473e
	ld hl, wDecompBuffer ; $4744
	ld de, vBGMap0 + VRAM_BANK1 ; $4747
	ld c, $24 ; $474a
	call QueueVRAMCopy ; $474c
	ld hl, wDecompBuffer + 64 * TILE_SIZE ; $474f
	ld de, vBGMap0 ; $4752
	ld c, $24 ; $4755
	call QueueVRAMCopy ; $4757
	call CopyMapToScrollBuffers ; $475a
	ld a, $0f ; $475d
	ld hl, ExpScreenDrawTask ; $475f
	call RegisterFrameTask ; $4762
	call EnableLCD ; $4765
	script_fade_in $10 ; $4768
	call WaitFadeEnd ; $476d
	pop_wram_bank ; $4770
	pop hl ; $4775
	pop de ; $4776
	pop bc ; $4777
	ret ; $4778
