StartBounceEffect:
	ld hl, wBallHeight ; $5383
	ld a, [hl+] ; $5386
	ld b, [hl] ; $5387
	ld c, a ; $5388
	ld hl, wBallDepth ; $5389
	ld a, [hl+] ; $538c
	ld d, [hl] ; $538d
	ld e, a ; $538e
	ld hl, wBallX ; $538f
	ld a, [hl+] ; $5392
	ld h, [hl] ; $5393
	ld l, a ; $5394
	call ProjectWorldToScreen_08 ; $5395
	ld e, l ; $5398
	ld d, h ; $5399
	ld hl, wBounceEffectX ; $539a
	ld a, e ; $539d
	ld [hl+], a ; $539e
	ld [hl], d ; $539f
	ld hl, wBounceEffectY ; $53a0
	ld a, c ; $53a3
	ld [hl+], a ; $53a4
	ld [hl], b ; $53a5
	ld a, $14 ; $53a6
	ld [wBounceEffectTimer], a ; $53a8
	ret ; $53ab
DrawBounceEffect:
	ld a, [wBounceEffectTimer] ; $53ac
	and a ; $53af
	ret z ; $53b0
	ld hl, wBounceEffectY ; $53b1
	ld a, [hl+] ; $53b4
	ld b, [hl] ; $53b5
	ld c, a ; $53b6
	ld hl, wBounceEffectX ; $53b7
	ld a, [hl+] ; $53ba
	ld h, [hl] ; $53bb
	ld l, a ; $53bc
	call ApplyCameraProjection ; $53bd
	ld bc, $0a60 ; $53c0
	ld a, [wBounceEffectTimer] ; $53c3
	cp $0a ; $53c6
	jr nc, .queue ; $53c8
	inc c ; $53ca
	inc c ; $53cb
.queue:
	call QueueSprite ; $53cc
	ret ; $53cf
StartHitEffect:
	ld hl, wBallHeight ; $53d0
	ld a, [hl+] ; $53d3
	ld b, [hl] ; $53d4
	ld c, a ; $53d5
	ld hl, wBallDepth ; $53d6
	ld a, [hl+] ; $53d9
	ld d, [hl] ; $53da
	ld e, a ; $53db
	ld hl, wBallX ; $53dc
	ld a, [hl+] ; $53df
	ld h, [hl] ; $53e0
	ld l, a ; $53e1
	call ProjectWorldToScreen_08 ; $53e2
	ld e, l ; $53e5
	ld d, h ; $53e6
	ld hl, wHitEffectX ; $53e7
	ld a, e ; $53ea
	ld [hl+], a ; $53eb
	ld [hl], d ; $53ec
	ld hl, wHitEffectY ; $53ed
	ld a, c ; $53f0
	ld [hl+], a ; $53f1
	ld [hl], b ; $53f2
	ld a, [wSpecialShotFlag] ; $53f3
	and a ; $53f6
	jr nz, .specialEffect ; $53f7
	ld a, [wShotChargeLevel] ; $53f9
	cp $3f ; $53fc
	jr z, .specialEffect ; $53fe
	ld a, $10 ; $5400
	ld [wHitSparkTimer], a ; $5402
	ret ; $5405
.specialEffect:
	ld a, $10 ; $5406
	ld [wSpecialHitTimer], a ; $5408
	sound SFX_SPECIAL_HIT ; $540b
	ret ; $540d
DrawHitSpark:
	ld a, [wHitSparkTimer] ; $540e
	and a ; $5411
	ret z ; $5412
	ld hl, wHitEffectY ; $5413
	ld a, [hl+] ; $5416
	ld b, [hl] ; $5417
	ld c, a ; $5418
	ld hl, wHitEffectX ; $5419
	ld a, [hl+] ; $541c
	ld h, [hl] ; $541d
	ld l, a ; $541e
	call ApplyCameraProjection ; $541f
	ld a, [wHitSparkTimer] ; $5422
	rra ; $5425
	rra ; $5426
	and $03 ; $5427
	cpl ; $5429
	add $04 ; $542a
	add a ; $542c
	add $68 ; $542d
	ld c, a ; $542f
	ld b, $0a ; $5430
	call QueueSprite ; $5432
	ret ; $5435
DrawSpecialHitEffect:
	ld a, [wSpecialHitTimer] ; $5436
	and a ; $5439
	ret z ; $543a
	ld hl, wHitEffectY ; $543b
	ld a, [hl+] ; $543e
	ld b, [hl] ; $543f
	ld c, a ; $5440
	ld hl, wHitEffectX ; $5441
	ld a, [hl+] ; $5444
	ld h, [hl] ; $5445
	ld l, a ; $5446
	call ApplyCameraProjection ; $5447
	ld a, e ; $544a
	add $08 ; $544b
	ld e, a ; $544d
	ld bc, $0974 ; $544e
	call QueueSprite16 ; $5451
	ld hl, wSpecialHitTimer ; $5454
	call TickTimer ; $5457
	ld a, [wSpecialHitTimer] ; $545a
	ld_hl_indexed DrawSpecialHitEffectTable ; $545d
	ld a, [hl] ; $5464
	cp $ff ; $5465
	ret z ; $5467
	farcall LoadSpecialHitEffectTiles ; $5468
	ret ; $546b
DrawSpecialHitEffectTable:
	; $546c, 16 bytes (bytes:4)
	db $ff, $ff, $ff, $03 ; 0x00
	db $ff, $ff, $ff, $02 ; 0x04
	db $ff, $ff, $ff, $01 ; 0x08
	db $ff, $ff, $ff, $00 ; 0x0c
StartBallTouchCharEffect:
	ld a, $28 ; $547c
	ld [wBallTouchCharTimer], a ; $547e
	ret ; $5481
DrawBallTouchCharEffect:
	ld a, [wBallTouchCharTimer] ; $5482
	and a ; $5485
	ret z ; $5486
	ld a, [wBallTouchCharIndex] ; $5487
	call CharIndexToWramBank ; $548a
	ld a, a ; $548d
	wram_bank ; $548e
	ld a, [wCharScreenX] ; $5492
	add $08 ; $5495
	ld d, a ; $5497
	ld a, [wCharScreenY] ; $5498
	add $f8 ; $549b
	ld e, a ; $549d
	wram_bank $04 ; $549e
	ld bc, $0a78 ; $54a4
	call QueueSprite16 ; $54a7
	ld hl, wBallTouchCharTimer ; $54aa
	call TickTimer ; $54ad
	ld a, [wBallTouchCharTimer] ; $54b0
	ld_hl_indexed DrawBallTouchCharEffectTable ; $54b3
	ld a, [hl] ; $54ba
	cp $ff ; $54bb
	ret z ; $54bd
	farcall LoadBallTouchCharEffectTilesA ; $54be
	ret ; $54c1
DrawBallTouchCharEffectTable:
	; $54c2, 40 bytes (bytes:8)
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $00 ; 0x00
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $01 ; 0x08
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $00 ; 0x10
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $01 ; 0x18
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $00 ; 0x20
	ld bc, $0000 ; $54ea
	ld hl, wShotAimTargetDepth ; $54ed
	ld a, [hl+] ; $54f0
	ld d, [hl] ; $54f1
	ld e, a ; $54f2
	ld hl, wShotAimTargetX ; $54f3
	ld a, [hl+] ; $54f6
	ld h, [hl] ; $54f7
	ld l, a ; $54f8
	call ProjectWorldToScreen_08 ; $54f9
	call ApplyCameraProjection ; $54fc
	lb bc, $09, $5e ; $54ff attr, tile
	call QueueSprite ; $5502
	ret ; $5505
UnusedDrawBallTargetMarker:
	ld bc, $0000 ; $5506
	ld hl, wBallTargetDepth ; $5509
	ld a, [hl+] ; $550c
	ld d, [hl] ; $550d
	ld e, a ; $550e
	ld hl, wBallTargetX ; $550f
	ld a, [hl+] ; $5512
	ld h, [hl] ; $5513
	ld l, a ; $5514
	call ProjectWorldToScreen_08 ; $5515
	call ApplyCameraProjection ; $5518
	lb bc, $0c, $5e ; $551b attr, tile
	call QueueSprite ; $551e
	ret ; $5521
DrawTargetZone:
	ld a, [wTargetZoneEnabled] ; $5522
	and a ; $5525
	ret z ; $5526
	ld hl, wTargetZoneDepth1 ; $5527
	ld a, [hl+] ; $552a
	ld d, [hl] ; $552b
	ld e, a ; $552c
	ld hl, wTargetZoneX1 ; $552d
	ld a, [hl+] ; $5530
	ld h, [hl] ; $5531
	ld l, a ; $5532
	ld bc, $0000 ; $5533
	call ProjectWorldToScreen_08 ; $5536
	call ApplyCameraProjection ; $5539
	ld hl, DrawTargetZone_SpriteTemplate0 ; $553c
	lb bc, $09, $20 ; $553f attr, tile
	call QueueSpriteTemplate ; $5542
	ld hl, wTargetZoneDepth1 ; $5545
	ld a, [hl+] ; $5548
	ld d, [hl] ; $5549
	ld e, a ; $554a
	ld hl, wTargetZoneX2 ; $554b
	ld a, [hl+] ; $554e
	ld h, [hl] ; $554f
	ld l, a ; $5550
	ld bc, $0000 ; $5551
	call ProjectWorldToScreen_08 ; $5554
	call ApplyCameraProjection ; $5557
	ld hl, DrawTargetZone_SpriteTemplate1 ; $555a
	lb bc, $09, $22 ; $555d attr, tile
	call QueueSpriteTemplate ; $5560
	ld hl, wTargetZoneDepth2 ; $5563
	ld a, [hl+] ; $5566
	ld d, [hl] ; $5567
	ld e, a ; $5568
	ld hl, wTargetZoneX1 ; $5569
	ld a, [hl+] ; $556c
	ld h, [hl] ; $556d
	ld l, a ; $556e
	ld bc, $0000 ; $556f
	call ProjectWorldToScreen_08 ; $5572
	call ApplyCameraProjection ; $5575
	ld hl, DrawTargetZone_SpriteTemplate2 ; $5578
	lb bc, $09, $24 ; $557b attr, tile
	call QueueSpriteTemplate ; $557e
	ld hl, wTargetZoneDepth2 ; $5581
	ld a, [hl+] ; $5584
	ld d, [hl] ; $5585
	ld e, a ; $5586
	ld hl, wTargetZoneX2 ; $5587
	ld a, [hl+] ; $558a
	ld h, [hl] ; $558b
	ld l, a ; $558c
	ld bc, $0000 ; $558d
	call ProjectWorldToScreen_08 ; $5590
	call ApplyCameraProjection ; $5593
	ld hl, DrawTargetZone_SpriteTemplate3 ; $5596
	lb bc, $09, $26 ; $5599 attr, tile
	call QueueSpriteTemplate ; $559c
	ret ; $559f
DrawTargetZone_SpriteTemplate0:
	; $55a0, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
DrawTargetZone_SpriteTemplate1:
	; $55a5, 5 bytes (sprite_template)
	oam_sprite $10, $01, $00, $00
	oam_sprite_end
DrawTargetZone_SpriteTemplate2:
	; $55aa, 5 bytes (sprite_template)
	oam_sprite $09, $08, $00, $00
	oam_sprite_end
DrawTargetZone_SpriteTemplate3:
	; $55af, 5 bytes (sprite_template)
	oam_sprite $09, $01, $00, $00
	oam_sprite_end
ApplyBallAirDrag:
	ld a, [wBallSpeed3D + 1] ; $55b4
	bit 7, a ; $55b7
	jr z, .toNibble ; $55b9
	cpl ; $55bb
	inc a ; $55bc
.toNibble:
	swap a ; $55bd
	and $0f ; $55bf
	inc a ; $55c1
	ld b, a ; $55c2
	push bc ; $55c3
	ld hl, wBallVelocityX ; $55c4
	ld a, [hl+] ; $55c7
	ld h, [hl] ; $55c8
	ld l, a ; $55c9
	sra h ; $55ca
	rr l ; $55cc
	ld a, b ; $55ce
	call MulSignedHLByAFrac ; $55cf
	ld e, l ; $55d2
	ld d, h ; $55d3
	call NegateADE ; $55d4
	ld hl, wBallVelocityXFrac ; $55d7
	call Add24ToMem24 ; $55da
	pop bc ; $55dd
	push bc ; $55de
	ld hl, wBallVelocityDepth ; $55df
	ld a, [hl+] ; $55e2
	ld h, [hl] ; $55e3
	ld l, a ; $55e4
	sra h ; $55e5
	rr l ; $55e7
	ld a, b ; $55e9
	call MulSignedHLByAFrac ; $55ea
	ld e, l ; $55ed
	ld d, h ; $55ee
	call NegateADE ; $55ef
	ld hl, wBallVelocityDepthFrac ; $55f2
	call Add24ToMem24 ; $55f5
	pop bc ; $55f8
	ld hl, wBallVelocityHeight ; $55f9
	ld a, [hl+] ; $55fc
	ld h, [hl] ; $55fd
	ld l, a ; $55fe
	sra h ; $55ff
	rr l ; $5601
	ld a, b ; $5603
	call MulSignedHLByAFrac ; $5604
	ld e, l ; $5607
	ld d, h ; $5608
	call NegateADE ; $5609
	ld hl, wBallVelocityHeightFrac ; $560c
	call Add24ToMem24 ; $560f
	ret ; $5612
ApplyBallSpin:
	ld hl, wBallSideSpin ; $5613
	ld a, [hl+] ; $5616
	or [hl] ; $5617
	jp z, .checkTopspin ; $5618
	ld hl, wBallVelocityDepth ; $561b
	ld a, [hl+] ; $561e
	ld d, [hl] ; $561f
	ld e, a ; $5620
	ld hl, wBallSideSpin ; $5621
	ld a, [hl+] ; $5624
	ld h, [hl] ; $5625
	ld l, a ; $5626
	call MulHLByDEAbs ; $5627
	ldh a, [hMulResult + 1] ; $562a
	ld e, l ; $562c
	ld d, h ; $562d
	sra d ; $562e
	rr e ; $5630
	rra ; $5632
	sra d ; $5633
	rr e ; $5635
	rra ; $5637
	sra d ; $5638
	rr e ; $563a
	rra ; $563c
	sra d ; $563d
	rr e ; $563f
	rra ; $5641
	ld hl, hMathSign ; $5642
	bit 7, [hl] ; $5645
	jr nz, .applySide ; $5647
	call NegateADE ; $5649
.applySide:
	push af ; $564c
	push de ; $564d
	ld hl, wBallVelocityX ; $564e
	ld a, [hl+] ; $5651
	ld d, [hl] ; $5652
	ld e, a ; $5653
	ld hl, wBallSideSpin ; $5654
	ld a, [hl+] ; $5657
	ld h, [hl] ; $5658
	ld l, a ; $5659
	call MulHLByDEAbs ; $565a
	ldh a, [hMulResult + 1] ; $565d
	ld e, l ; $565f
	ld d, h ; $5660
	sra d ; $5661
	rr e ; $5663
	rra ; $5665
	sra d ; $5666
	rr e ; $5668
	rra ; $566a
	sra d ; $566b
	rr e ; $566d
	rra ; $566f
	sra d ; $5670
	rr e ; $5672
	rra ; $5674
	ld hl, hMathSign ; $5675
	bit 7, [hl] ; $5678
	jr z, .accumulateX ; $567a
	call NegateADE ; $567c
.accumulateX:
	ld hl, wBallVelocityDepthFrac ; $567f
	call Add24ToMem24 ; $5682
	pop de ; $5685
	pop af ; $5686
	ld hl, wBallVelocityXFrac ; $5687
	call Add24ToMem24 ; $568a
	ld hl, wBallSideSpin ; $568d
	ld a, [hl+] ; $5690
	ld h, [hl] ; $5691
	ld l, a ; $5692
	ld a, h ; $5693
	add a ; $5694
	sbc a ; $5695
	ld d, a ; $5696
	ld e, h ; $5697
	xor a ; $5698
	sub e ; $5699
	ld e, a ; $569a
	sbc a ; $569b
	sub d ; $569c
	ld d, a ; $569d
	add hl, de ; $569e
	add hl, de ; $569f
	add hl, de ; $56a0
	ld a, l ; $56a1
	ld [wBallSideSpin], a ; $56a2
	ld a, h ; $56a5
	ld [wBallSideSpin + 1], a ; $56a6
.checkTopspin:
	ld hl, wBallTopspin ; $56a9
	ld a, [hl+] ; $56ac
	or [hl] ; $56ad
	jp z, .done ; $56ae
	ld hl, wBallVelocityHeight ; $56b1
	ld a, [hl+] ; $56b4
	ld d, [hl] ; $56b5
	ld e, a ; $56b6
	ld hl, wBallTopspin ; $56b7
	ld a, [hl+] ; $56ba
	ld h, [hl] ; $56bb
	ld l, a ; $56bc
	call MulHLByDEAbs ; $56bd
	ldh a, [hMulResult + 1] ; $56c0
	ld e, l ; $56c2
	ld d, h ; $56c3
	sra d ; $56c4
	rr e ; $56c6
	rra ; $56c8
	sra d ; $56c9
	rr e ; $56cb
	rra ; $56cd
	sra d ; $56ce
	rr e ; $56d0
	rra ; $56d2
	sra d ; $56d3
	rr e ; $56d5
	rra ; $56d7
	sra d ; $56d8
	rr e ; $56da
	rra ; $56dc
	ld d, e ; $56dd
	ld e, a ; $56de
	ld hl, hMathSign ; $56df
	bit 7, [hl] ; $56e2
	jr nz, .applyTopspin ; $56e4
	xor a ; $56e6
	sub e ; $56e7
	ld e, a ; $56e8
	sbc a ; $56e9
	sub d ; $56ea
	ld d, a ; $56eb
.applyTopspin:
	push de ; $56ec
	ld hl, wBallSpeedHorizontal ; $56ed
	ld a, [hl+] ; $56f0
	ld d, [hl] ; $56f1
	ld e, a ; $56f2
	ld hl, wBallTopspin ; $56f3
	ld a, [hl+] ; $56f6
	ld h, [hl] ; $56f7
	ld l, a ; $56f8
	call MulHLByDEAbs ; $56f9
	ldh a, [hMulResult + 1] ; $56fc
	ld e, l ; $56fe
	ld d, h ; $56ff
	sra d ; $5700
	rr e ; $5702
	rra ; $5704
	sra d ; $5705
	rr e ; $5707
	rra ; $5709
	sra d ; $570a
	rr e ; $570c
	rra ; $570e
	sra d ; $570f
	rr e ; $5711
	rra ; $5713
	ld hl, hMathSign ; $5714
	bit 7, [hl] ; $5717
	jr z, .accumulateDepth ; $5719
	call NegateADE ; $571b
.accumulateDepth:
	ld hl, wBallVelocityHeightFrac ; $571e
	call Add24ToMem24 ; $5721
	ld hl, wBallHeadingAngle ; $5724
	ld a, [hl+] ; $5727
	ld b, [hl] ; $5728
	ld c, a ; $5729
	pop hl ; $572a
	call MulSinCosSigned ; $572b
	ld c, l ; $572e
	ld b, h ; $572f
	ld l, e ; $5730
	ld h, d ; $5731
	add hl, hl ; $5732
	sbc a ; $5733
	ld d, a ; $5734
	ld e, h ; $5735
	ld a, l ; $5736
	ld hl, wBallVelocityDepthFrac ; $5737
	call Add24ToMem24 ; $573a
	ld l, c ; $573d
	ld h, b ; $573e
	add hl, hl ; $573f
	sbc a ; $5740
	ld d, a ; $5741
	ld e, h ; $5742
	ld a, l ; $5743
	ld hl, wBallVelocityXFrac ; $5744
	call Add24ToMem24 ; $5747
	ld hl, wBallTopspin ; $574a
	ld a, [hl+] ; $574d
	ld h, [hl] ; $574e
	ld l, a ; $574f
	ld a, h ; $5750
	add a ; $5751
	sbc a ; $5752
	ld d, a ; $5753
	ld e, h ; $5754
	xor a ; $5755
	sub e ; $5756
	ld e, a ; $5757
	sbc a ; $5758
	sub d ; $5759
	ld d, a ; $575a
	add hl, de ; $575b
	add hl, de ; $575c
	add hl, de ; $575d
	ld a, l ; $575e
	ld [wBallTopspin], a ; $575f
	ld a, h ; $5762
	ld [wBallTopspin + 1], a ; $5763
.done:
	ret ; $5766
StepBallPhysics:
	xor a ; $5767
	ld [wBallBounceEvent], a ; $5768
	ld hl, wBallXFrac ; $576b
	ld de, wBallPrevXFrac ; $576e
	ld bc, $000c ; $5771
	call CopyMemoryBC ; $5774
	ld hl, wBallXFrac ; $5777
	ld de, wBallVelocityXFrac ; $577a
	call AddVel24ToPos32 ; $577d
	ld hl, wBallDepthFrac ; $5780
	ld de, wBallVelocityDepthFrac ; $5783
	call AddVel24ToPos32 ; $5786
	ld hl, wBallHeightFrac ; $5789
	ld de, wBallVelocityHeightFrac ; $578c
	call AddVel24ToPos32 ; $578f
	call BounceBallOffCourtFences ; $5792
	call HandleBallNetCrossing ; $5795
	ld b, $00 ; $5798
	ld a, [wBallDepth + 1] ; $579a
	add a ; $579d
	rl b ; $579e
	ld a, [wBallX + 1] ; $57a0
	add a ; $57a3
	rl b ; $57a4
	ld hl, wBallCourtQuadrant ; $57a6
	ld [hl], b ; $57a9
	call UpdateBallAnglesAndSpeed ; $57aa
	call ApplyBallAirDrag ; $57ad
	call ApplyBallSpin ; $57b0
	call GetBallHeightSign ; $57b3
	cp $ff ; $57b6
	jr z, .rising ; $57b8
	jr .falling ; $57ba
.rising:
	ld de, $4a00 ; $57bc
	ld hl, wBallVelocityHeightFrac ; $57bf
	call AddDEToMem24 ; $57c2
	ret ; $57c5
.falling:
	call ApplyCourtBounceDamping ; $57c6
	ld hl, wBallHeightFrac ; $57c9
	ld a, [hl] ; $57cc
	cpl ; $57cd
	add $01 ; $57ce
	ld [hl+], a ; $57d0
	ld a, [hl] ; $57d1
	cpl ; $57d2
	adc $00 ; $57d3
	ld [hl+], a ; $57d5
	ld a, [hl] ; $57d6
	cpl ; $57d7
	adc $00 ; $57d8
	ld [hl+], a ; $57da
	ld a, [hl] ; $57db
	cpl ; $57dc
	adc $00 ; $57dd
	ld [hl+], a ; $57df
	call GetBallHeightSign ; $57e0
	and a ; $57e3
	jr z, .done ; $57e4
	ld a, $01 ; $57e6
	ld [wBallBounceEvent], a ; $57e8
	ld hl, wBallVelocityHeightFrac ; $57eb
	ld a, [hl] ; $57ee
	cpl ; $57ef
	ld [hl+], a ; $57f0
	ld a, [hl] ; $57f1
	cpl ; $57f2
	ld [hl+], a ; $57f3
	ld a, [hl] ; $57f4
	cpl ; $57f5
	ld [hl+], a ; $57f6
	ld hl, wBallVelocityHeight ; $57f7
	ld a, [hl+] ; $57fa
	ld h, [hl] ; $57fb
	ld l, a ; $57fc
	ld de, $0250 ; $57fd
	add hl, de ; $5800
	bit 7, h ; $5801
	jr nz, .done ; $5803
	xor a ; $5805
	ld hl, wBallHeightFrac ; $5806
	ld [hl+], a ; $5809
	ld [hl+], a ; $580a
	ld [hl+], a ; $580b
	ld [hl+], a ; $580c
	ld hl, wBallVelocityHeightFrac ; $580d
	ld [hl+], a ; $5810
	ld [hl+], a ; $5811
	ld [hl+], a ; $5812
.done:
	ret ; $5813
HandleBallNetCrossing:
	xor a ; $5814
	ld [wBallCrossedNetFlag], a ; $5815
	ld hl, wBallDepth + 1 ; $5818
	ld a, [hl] ; $581b
	ld hl, wBallPrevDepth + 1 ; $581c
	xor [hl] ; $581f
	bit 7, a ; $5820
	jp z, .done ; $5822
	ld a, $01 ; $5825
	ld [wBallCrossedNetFlag], a ; $5827
	ld a, [wMinigameUsesWall] ; $582a
	and a ; $582d
	jr nz, .done ; $582e
	ld hl, wNetHeight ; $5830
	ld a, [hl+] ; $5833
	ld d, [hl] ; $5834
	ld e, a ; $5835
	ld hl, wBallHeight ; $5836
	ld a, [hl+] ; $5839
	ld h, [hl] ; $583a
	ld l, a ; $583b
	add hl, de ; $583c
	bit 7, h ; $583d
	jr nz, .done ; $583f
	sound SFX_NET_CORD ; $5841
	call StartBounceEffect ; $5843
	ld a, $01 ; $5846
	ld [wBallHasBouncedFlag], a ; $5848
	ld hl, wBallDepthFrac ; $584b
	ld a, [hl] ; $584e
	cpl ; $584f
	ld [hl+], a ; $5850
	ld a, [hl] ; $5851
	cpl ; $5852
	ld [hl+], a ; $5853
	ld a, [hl] ; $5854
	cpl ; $5855
	ld [hl+], a ; $5856
	ld a, [hl] ; $5857
	cpl ; $5858
	ld [hl+], a ; $5859
	ld hl, wBallVelocityX ; $585a
	ld a, [hl+] ; $585d
	ld d, [hl] ; $585e
	ld e, a ; $585f
	sra d ; $5860
	rr e ; $5862
	sra d ; $5864
	rr e ; $5866
	ld hl, wBallVelocityX ; $5868
	ld a, e ; $586b
	ld [hl+], a ; $586c
	ld [hl], d ; $586d
	ld hl, wBallHeight ; $586e
	ld a, [hl+] ; $5871
	ld d, [hl] ; $5872
	ld e, a ; $5873
	ld hl, $005a ; $5874
	add hl, de ; $5877
	bit 7, h ; $5878
	jr nz, .clearSpin ; $587a
	ld hl, $0058 ; $587c
	add hl, de ; $587f
	bit 7, h ; $5880
	jr nz, .crossed ; $5882
	ld hl, wBallVelocityDepth ; $5884
	ld a, [hl+] ; $5887
	ld d, [hl] ; $5888
	ld e, a ; $5889
	xor a ; $588a
	sub e ; $588b
	ld e, a ; $588c
	sbc a ; $588d
	sub d ; $588e
	ld d, a ; $588f
	sra d ; $5890
	rr e ; $5892
	sra d ; $5894
	rr e ; $5896
	sra d ; $5898
	rr e ; $589a
	ld hl, wBallVelocityDepth ; $589c
	ld a, e ; $589f
	ld [hl+], a ; $58a0
	ld [hl], d ; $58a1
.done:
	ret ; $58a2
.crossed:
	ld hl, wBallVelocityDepth ; $58a3
	ld a, [hl+] ; $58a6
	ld d, [hl] ; $58a7
	ld e, a ; $58a8
	sra d ; $58a9
	rr e ; $58ab
	sra d ; $58ad
	rr e ; $58af
	sra d ; $58b1
	rr e ; $58b3
	bit 7, d ; $58b5
	jr z, .jitter ; $58b7
	xor a ; $58b9
	sub e ; $58ba
	ld e, a ; $58bb
	sbc a ; $58bc
	sub d ; $58bd
	ld d, a ; $58be
.jitter:
	call AdvanceMatchRng ; $58bf
	ld h, $00 ; $58c2
	ld l, a ; $58c4
	add hl, hl ; $58c5
	add hl, hl ; $58c6
	add hl, de ; $58c7
	ld e, l ; $58c8
	ld d, h ; $58c9
	xor a ; $58ca
	sub e ; $58cb
	ld e, a ; $58cc
	sbc a ; $58cd
	sub d ; $58ce
	ld d, a ; $58cf
	ld hl, wBallVelocityHeight ; $58d0
	ld a, e ; $58d3
	ld [hl+], a ; $58d4
	ld [hl], d ; $58d5
	ld hl, wBallVelocityDepth ; $58d6
	ld a, [hl+] ; $58d9
	ld d, [hl] ; $58da
	ld e, a ; $58db
	xor a ; $58dc
	sub e ; $58dd
	ld e, a ; $58de
	sbc a ; $58df
	sub d ; $58e0
	ld d, a ; $58e1
	sra d ; $58e2
	rr e ; $58e4
	sra d ; $58e6
	rr e ; $58e8
	sra d ; $58ea
	rr e ; $58ec
	ld hl, wBallVelocityDepth ; $58ee
	ld a, e ; $58f1
	ld [hl+], a ; $58f2
	ld [hl], d ; $58f3
	ret ; $58f4
.clearSpin:
	ld hl, wBallHeightFrac ; $58f5
	xor a ; $58f8
	ld [hl+], a ; $58f9
	ld [hl+], a ; $58fa
	ld de, $ffa0 ; $58fb
	ld a, e ; $58fe
	ld [hl+], a ; $58ff
	ld [hl], d ; $5900
	ld hl, wBallVelocityDepth ; $5901
	ld a, [hl+] ; $5904
	ld d, [hl] ; $5905
	ld e, a ; $5906
	sra d ; $5907
	rr e ; $5909
	sra d ; $590b
	rr e ; $590d
	sra d ; $590f
	rr e ; $5911
	bit 7, d ; $5913
	jr z, .store ; $5915
	xor a ; $5917
	sub e ; $5918
	ld e, a ; $5919
	sbc a ; $591a
	sub d ; $591b
	ld d, a ; $591c
.store:
	call AdvanceMatchRng ; $591d
	ld h, $00 ; $5920
	ld l, a ; $5922
	add hl, hl ; $5923
	add hl, hl ; $5924
	add hl, de ; $5925
	ld e, l ; $5926
	ld d, h ; $5927
	xor a ; $5928
	sub e ; $5929
	ld e, a ; $592a
	sbc a ; $592b
	sub d ; $592c
	ld d, a ; $592d
	ld hl, wBallVelocityHeight ; $592e
	ld a, e ; $5931
	ld [hl+], a ; $5932
	ld [hl], d ; $5933
	ld hl, wBallVelocityDepth ; $5934
	ld a, [hl+] ; $5937
	ld d, [hl] ; $5938
	ld e, a ; $5939
	sra d ; $593a
	rr e ; $593c
	sra d ; $593e
	rr e ; $5940
	ld hl, wBallVelocityDepth ; $5942
	ld a, e ; $5945
	ld [hl+], a ; $5946
	ld [hl], d ; $5947
	ret ; $5948
BounceBallOffCourtFences:
	ld hl, wBallDepth ; $5949
	ld a, [hl+] ; $594c
	ld h, [hl] ; $594d
	ld l, a ; $594e
	bit 7, h ; $594f
	jr nz, .checkFarFence ; $5951
	ld de, $f920 ; $5953
	add hl, de ; $5956
	jr nc, .checkSideFences ; $5957
	jr .bounceDepth ; $5959
.checkFarFence:
	ld de, $0700 ; $595b
	add hl, de ; $595e
	jr c, .checkSideFences ; $595f
.bounceDepth:
	ld hl, wBallVelocityDepthFrac ; $5961
	ld a, [hl] ; $5964
	cpl ; $5965
	ld [hl+], a ; $5966
	ld a, [hl] ; $5967
	cpl ; $5968
	ld [hl+], a ; $5969
	ld a, [hl] ; $596a
	cpl ; $596b
	ld [hl+], a ; $596c
	ld hl, wBallDepthFrac ; $596d
	ld de, wBallVelocityDepthFrac ; $5970
	call AddVel24ToPos32 ; $5973
	call ApplyCourtBounceDamping ; $5976
	call ApplyCourtBounceDamping ; $5979
	ld a, $02 ; $597c
	ld [wBallBounceEvent], a ; $597e
.checkSideFences:
	ld hl, wBallX ; $5981
	ld a, [hl+] ; $5984
	ld h, [hl] ; $5985
	ld l, a ; $5986
	bit 7, h ; $5987
	jr z, .checkFarSide ; $5989
	xor a ; $598b
	sub l ; $598c
	ld l, a ; $598d
	sbc a ; $598e
	sub h ; $598f
	ld h, a ; $5990
.checkFarSide:
	ld de, $fc60 ; $5991
	add hl, de ; $5994
	jr nc, .done ; $5995
	ld hl, wBallVelocityXFrac ; $5997
	ld a, [hl] ; $599a
	cpl ; $599b
	ld [hl+], a ; $599c
	ld a, [hl] ; $599d
	cpl ; $599e
	ld [hl+], a ; $599f
	ld a, [hl] ; $59a0
	cpl ; $59a1
	ld [hl+], a ; $59a2
	ld hl, wBallXFrac ; $59a3
	ld de, wBallVelocityXFrac ; $59a6
	call AddVel24ToPos32 ; $59a9
	call ApplyCourtBounceDamping ; $59ac
	call ApplyCourtBounceDamping ; $59af
	ld a, $02 ; $59b2
	ld [wBallBounceEvent], a ; $59b4
.done:
	ret ; $59b7
