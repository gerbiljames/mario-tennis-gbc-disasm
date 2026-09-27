ApplyCharFlagShotSpeedPenalty:
	ld hl, wCharFlags ; $53a2
	bit CHARB_DIVING, [hl] ; $53a5
	jr z, .done ; $53a7
	ld hl, $f400 ; $53a9
	add hl, bc ; $53ac
	ld c, l ; $53ad
	ld b, h ; $53ae
.done:
	ret ; $53af
ExecuteShot:
	ld hl, wBallHitEvent ; $53b0
	ld a, [hl] ; $53b3
	and a ; $53b4
	ret nz ; $53b5
	ld a, $01 ; $53b6
	ld [wBallHitEvent], a ; $53b8
	ld a, [wCharIndex] ; $53bb
	ld [wLastShotCharIndex], a ; $53be
	ld a, [wCharServeRole] ; $53c1
	ld [wLastShotServeRole], a ; $53c4
	ld a, [wCharAimOffset] ; $53c7
	ld [wLastShotAimOffset], a ; $53ca
	ld a, [wCharShotType] ; $53cd
	ld [wCurrentShotType], a ; $53d0
	ld a, [wCharShotButton1] ; $53d3
	swap a ; $53d6
	ld hl, wCharShotButton2 ; $53d8
	or [hl] ; $53db
	ld [wLastShotButtons], a ; $53dc
	ld a, [wBallCourtQuadrant] ; $53df
	ld [wBallQuadrantAtHit], a ; $53e2
	xor a ; $53e5
	ld [wSpecialShotFlag], a ; $53e6
	ld [wLastShotWasPowerShot], a ; $53e9
	ld [wFallbackTrajectoryFlag], a ; $53ec
	ld b, $00 ; $53ef
	ld a, [wCharSwingAnim] ; $53f1
	cp CHARANIM_BACKHAND ; $53f4
	jr nz, .checkShot0a ; $53f6
	inc b ; $53f8
.checkShot0a:
	cp CHARANIM_BACKHAND_QUICK ; $53f9
	jr nz, .checkLeftHanded ; $53fb
	inc b ; $53fd
.checkLeftHanded:
	ld a, [wCharMirrorAttrMask] ; $53fe
	and a ; $5401
	jr z, .checkServe ; $5402
	inc b ; $5404
.checkServe:
	ld a, [wRallyLength] ; $5405
	cp $00 ; $5408
	jr nz, .storeMirror ; $540a
	inc b ; $540c
.storeMirror:
	ld a, b ; $540d
	and $01 ; $540e
	ld [wShotAimMirror], a ; $5410
	ld a, [wCharSwingFrames] ; $5413
	cp $3f ; $5416
	jr c, .storeCharge ; $5418
	ld a, $3f ; $541a
.storeCharge:
	ld [wShotChargeLevel], a ; $541c
	ld a, [wCharQuickSwing] ; $541f
	ld [wShotWasQuickSwing], a ; $5422
	ld hl, wBallVelocityX ; $5425
	ld a, [hl+] ; $5428
	ld d, [hl] ; $5429
	ld e, a ; $542a
	ld hl, wShotRecoilVelocityX ; $542b
	ld a, e ; $542e
	ld [hl+], a ; $542f
	ld [hl], d ; $5430
	ld hl, wBallVelocityDepth ; $5431
	ld a, [hl+] ; $5434
	ld d, [hl] ; $5435
	ld e, a ; $5436
	ld hl, wShotRecoilVelocityDepth ; $5437
	ld a, e ; $543a
	ld [hl+], a ; $543b
	ld [hl], d ; $543c
	ld hl, ShotRecoilFrameTask ; $543d
	push hl ; $5440
	ld a, [wCurrentShotType] ; $5441
	rst Rst00 ; $5444
	dw ExecuteShotTopspin ; $5445 jumptable
	dw ExecuteShotPowerTopspin ; $5447 jumptable
	dw ExecuteShotSlice ; $5449 jumptable
	dw ExecuteShotPowerSlice ; $544b jumptable
	dw ExecuteShotNeutral ; $544d jumptable
	dw ExecuteShotReach ; $544f jumptable
	dw ExecuteShotReachPowerTopspin ; $5451 jumptable
	dw ExecuteShotReachPowerSlice ; $5453 jumptable
	dw ExecuteShotReachBasic ; $5455 jumptable
	dw ExecuteShotSmash ; $5457 jumptable
	dw ExecuteShotLob ; $5459 jumptable
	dw ExecuteShotDrop ; $545b jumptable
	dw ExecuteShotServeTopspin ; $545d jumptable
	dw ExecuteShotServeSlice ; $545f jumptable
	dw ExecuteShotServeFlat ; $5461 jumptable
ShotRecoilFrameTask:
	call ApplyShotRecoil ; $5463
	xor a ; $5466
	ld [wCharSwingFrames], a ; $5467
	ret ; $546a
ApplyShotRecoil:
	ld hl, wCharFlags ; $546b
	set CHARB_RECOIL, [hl] ; $546e
	res CHARB_CHARGING, [hl] ; $5470
	ld a, [wShotRecoilVariant] ; $5472
	add a ; $5475
	ld_hl_indexed ShotRecoilVarPtrs_07 ; $5476
	ld a, [hl+] ; $547d
	ld h, [hl] ; $547e
	ld l, a ; $547f
	ld a, [hl] ; $5480
	ld_hl_indexed ShotRecoilTable_07 ; $5481
	ld b, [hl] ; $5488
	ld hl, wShotRecoilVelocityDepth ; $5489
	ld a, [hl+] ; $548c
	ld h, [hl] ; $548d
	ld l, a ; $548e
	ld a, b ; $548f
	call MulHLByAFracSigned ; $5490
	ld e, l ; $5493
	ld d, h ; $5494
	ld hl, wCharVelDepth ; $5495
	ld a, [hl+] ; $5498
	ld h, [hl] ; $5499
	ld l, a ; $549a
	sra h ; $549b
	rr l ; $549d
	sra h ; $549f
	rr l ; $54a1
	add hl, de ; $54a3
	ld e, l ; $54a4
	ld d, h ; $54a5
	ld hl, wCharVelDepth ; $54a6
	ld a, e ; $54a9
	ld [hl+], a ; $54aa
	ld [hl], d ; $54ab
	ld hl, wCharFlags ; $54ac
	bit CHARB_DIVING, [hl] ; $54af
	jr nz, .done ; $54b1
	ld hl, wCharVelX ; $54b3
	ld a, [hl+] ; $54b6
	ld h, [hl] ; $54b7
	ld l, a ; $54b8
	sra h ; $54b9
	rr l ; $54bb
	sra h ; $54bd
	rr l ; $54bf
	ld e, l ; $54c1
	ld d, h ; $54c2
	ld hl, wCharVelX ; $54c3
	ld a, e ; $54c6
	ld [hl+], a ; $54c7
	ld [hl], d ; $54c8
.done:
	ret ; $54c9
ShotRecoilVarPtrs_07:
	; $54ca, 10 bytes (ram_ptrs:0)
	dw wGroundStrokeSpeedIndex ; record 0
	dw wReachSpeedIndex ; record 1
	dw wSmashServeSpeedIndex ; record 2
	dw wGroundStrokeSpeedIndex ; record 3
	dw wSmashServeSpeedIndex ; record 4
ShotRecoilTable_07:
	; $54d4, 10 bytes (bytes:10)
	db $58, $50, $48, $40, $38, $30, $28, $20, $18, $10 ; 0x00
WeakenShotByCharge:
	ld a, [wShotChargeLevel] ; $54de
	ld l, a ; $54e1
	ld h, $00 ; $54e2
	add hl, hl ; $54e4
	add hl, hl ; $54e5
	ld a, c ; $54e6
	sub l ; $54e7
	ld c, a ; $54e8
	ld a, b ; $54e9
	sbc h ; $54ea
	ld b, a ; $54eb
	ret ; $54ec
BoostShotByCharge:
	ld a, [wShotChargeLevel] ; $54ed
	ld l, a ; $54f0
	ld h, $00 ; $54f1
	add hl, hl ; $54f3
	ld e, l ; $54f4
	ld d, h ; $54f5
	add hl, hl ; $54f6
	add hl, hl ; $54f7
	add hl, de ; $54f8
	add hl, de ; $54f9
	add hl, bc ; $54fa
	ld c, l ; $54fb
	ld b, h ; $54fc
	ret ; $54fd
NudgeShotByPlayerMomentum:
	ld hl, wCharVelDepth ; $54fe
	ld a, [hl+] ; $5501
	ld h, [hl] ; $5502
	ld l, a ; $5503
	sra h ; $5504
	rr l ; $5506
	sra h ; $5508
	rr l ; $550a
	sra h ; $550c
	rr l ; $550e
	sra h ; $5510
	rr l ; $5512
	ld a, [wCharCourtPos] ; $5514
	and $02 ; $5517
	jr nz, .addMomentum ; $5519
	xor a ; $551b
	sub l ; $551c
	ld l, a ; $551d
	sbc a ; $551e
	sub h ; $551f
	ld h, a ; $5520
.addMomentum:
	add hl, bc ; $5521
	ld c, l ; $5522
	ld b, h ; $5523
	ret ; $5524
CheckBallInSmashRange:
	ld hl, wBallDepth ; $5525
	ld a, [hl+] ; $5528
	ld h, [hl] ; $5529
	ld l, a ; $552a
	bit 7, h ; $552b
	jr z, .absX ; $552d
	xor a ; $552f
	sub l ; $5530
	ld l, a ; $5531
	sbc a ; $5532
	sub h ; $5533
	ld h, a ; $5534
.absX:
	ld e, l ; $5535
	ld d, h ; $5536
	sra d ; $5537
	rr e ; $5539
	add hl, de ; $553b
	sra h ; $553c
	rr l ; $553e
	ld e, l ; $5540
	ld d, h ; $5541
	ld hl, wBallHeight ; $5542
	ld a, [hl+] ; $5545
	ld h, [hl] ; $5546
	ld l, a ; $5547
	ld bc, $0070 ; $5548
	add hl, bc ; $554b
	bit 7, h ; $554c
	jr z, .done ; $554e
	call AngleFromVector16 ; $5550
	push bc ; $5553
	ld hl, wBallDepth ; $5554
	ld a, [hl+] ; $5557
	ld h, [hl] ; $5558
	ld l, a ; $5559
	bit 7, h ; $555a
	jr z, .absDepth ; $555c
	xor a ; $555e
	sub l ; $555f
	ld l, a ; $5560
	sbc a ; $5561
	sub h ; $5562
	ld h, a ; $5563
.absDepth:
	ld de, $04e0 ; $5564
	add hl, de ; $5567
	ld e, l ; $5568
	ld d, h ; $5569
	ld hl, wBallHeight ; $556a
	ld a, [hl+] ; $556d
	ld h, [hl] ; $556e
	ld l, a ; $556f
	xor a ; $5570
	sub l ; $5571
	ld l, a ; $5572
	sbc a ; $5573
	sub h ; $5574
	ld h, a ; $5575
	call AngleFromVector16 ; $5576
	pop hl ; $5579
	add hl, bc ; $557a
	bit 7, h ; $557b
.done:
	ret ; $557d
ApplyShotTypePresets:
	ld a, [wCurrentShotType] ; $557e
	ld b, a ; $5581
	add a ; $5582
	add a ; $5583
	add b ; $5584
	ld_hl_indexed ShotTypePresets_07 ; $5585
	ld a, [hl+] ; $558c
	call PlaySoundManaged ; $558d
	ld a, [hl+] ; $5590
	ld [wShotRecoilVariant], a ; $5591
	ld a, [hl+] ; $5594
	push hl ; $5595
	farcall SetBallTrailColor ; $5596
	pop hl ; $5599
	ld a, [hl+] ; $559a
	ld b, [hl] ; $559b
	ld c, a ; $559c
	ret ; $559d
ShotTypePresets_07:
	; $559e, 75 bytes (shot_preset)
; shot_preset sound, recoil variant, trail colour, target depth
	shot_preset SFX_HIT_TOPSPIN, 0, 0, $0280 ; SHOTTYPE_TOPSPIN
	shot_preset SFX_HIT_TOPSPIN, 0, 1, $03c0 ; SHOTTYPE_POWER_TOPSPIN
	shot_preset SFX_HIT_SLICE, 0, 0, $0280 ; SHOTTYPE_SLICE
	shot_preset SFX_HIT_SLICE, 0, 2, $03c0 ; SHOTTYPE_POWER_SLICE
	shot_preset SFX_HIT_TOPSPIN, 0, 0, $03c0 ; SHOTTYPE_NEUTRAL
	shot_preset SFX_HIT_TOPSPIN, 1, 0, $03c0 ; SHOTTYPE_REACH
	shot_preset SFX_HIT_TOPSPIN, 1, 0, $0480 ; SHOTTYPE_REACH_POWER_TOPSPIN
	shot_preset SFX_HIT_TOPSPIN, 1, 0, $0380 ; SHOTTYPE_REACH_POWER_SLICE
	shot_preset SFX_HIT_TOPSPIN, 1, 0, $03c0 ; SHOTTYPE_REACH_BASIC
	shot_preset SFX_HIT_SLICE, 2, 3, $0440 ; SHOTTYPE_SMASH
	shot_preset SFX_HIT_LOB, 3, 0, $0200 ; SHOTTYPE_LOB
	shot_preset SFX_HIT_DROP, 3, 0, $0200 ; SHOTTYPE_DROP
	shot_preset SFX_HIT_SERVE, 4, 1, $02a0 ; SHOTTYPE_SERVE_TOPSPIN
	shot_preset SFX_HIT_SERVE, 4, 2, $02a0 ; SHOTTYPE_SERVE_SLICE
	shot_preset SFX_HIT_SERVE, 4, 3, $02a0 ; SHOTTYPE_SERVE_FLAT
GetShotAimOffsetForSide:
	ld hl, ShotAimOffsetForSideCourtSideOffsets ; $55e9
	ld a, [wMinigameUsesWall] ; $55ec
	and a ; $55ef
	jr nz, .readAim ; $55f0
	ld a, [wCharCourtPos] ; $55f2
	and $01 ; $55f5
	add a ; $55f7
	add a ; $55f8
	add a ; $55f9
	ld_hl_indexed CourtSideOffsets_07_0 ; $55fa
.readAim:
	ld a, [wCharAimOffset] ; $5601
	inc a ; $5604
	add a ; $5605
	add l ; $5606
	ld l, a ; $5607
	jr nc, .done ; $5608
	inc h ; $560a
.done:
	ld a, [hl+] ; $560b
	ld d, [hl] ; $560c
	ld e, a ; $560d
	ld hl, wCharPosX + 1 ; $560e
	ld a, [hl+] ; $5611
	ld h, [hl] ; $5612
	ld l, a ; $5613
	xor a ; $5614
	sub l ; $5615
	ld l, a ; $5616
	sbc a ; $5617
	sub h ; $5618
	ld h, a ; $5619
	sra h ; $561a
	rr l ; $561c
	sra h ; $561e
	rr l ; $5620
	sra h ; $5622
	rr l ; $5624
	sra h ; $5626
	rr l ; $5628
	add hl, de ; $562a
	ld e, l ; $562b
	ld d, h ; $562c
	ret ; $562d
CourtSideOffsets_07_0:
	; $562e, 8 bytes (records:2)
	dw $fe60 ; record 0
	dw $ff20 ; record 1
	dw $ffdc ; record 2
	dw $0000 ; record 3
CourtSideOffsets_07_1:
	; $5636, 8 bytes (records:2)
	dw $0024 ; record 0
	dw $00e0 ; record 1
	dw $01a0 ; record 2
	dw $0000 ; record 3
ShotAimOffsetForSideCourtSideOffsets:
	; $563e, 8 bytes (records:2)
	dw $ff20 ; record 0
	dw $0000 ; record 1
	dw $00e0 ; record 2
	dw $0000 ; record 3
ComputeShotTargetX:
	ld a, [wRallyLength] ; $5646
	and a ; $5649
	jr z, GetShotAimOffsetForSide ; $564a
	call ComputeAimBaseOffset ; $564c
	ld a, [wCharAimOffset] ; $564f
	add $02 ; $5652
	and $07 ; $5654
	ld a, a ; $5656
	rst Rst00 ; $5657
	dw ComputeShotTargetX.fromBallX ; $5658 jumptable
	dw ComputeShotTargetX.halveShort ; $565a jumptable
	dw ComputeShotTargetX.straight ; $565c jumptable
	dw ComputeShotTargetX.halveLong ; $565e jumptable
	dw ComputeShotTargetX.fromBallXLong ; $5660 jumptable
	dw ComputeShotTargetX.straight ; $5662 jumptable
	dw ComputeShotTargetX.straight ; $5664 jumptable
	dw ComputeShotTargetX.straight ; $5666 jumptable
.halveShort:
	sra d ; $5668
	rr e ; $566a
.fromBallX:
	ld hl, wBallX ; $566c
	ld a, [hl+] ; $566f
	ld h, [hl] ; $5670
	ld l, a ; $5671
	xor a ; $5672
	sub l ; $5673
	ld l, a ; $5674
	sbc a ; $5675
	sub h ; $5676
	ld h, a ; $5677
	add hl, de ; $5678
	ld e, l ; $5679
	ld d, h ; $567a
	call ClampShotTargetX ; $567b
	xor a ; $567e
	sub e ; $567f
	ld e, a ; $5680
	sbc a ; $5681
	sub d ; $5682
	ld d, a ; $5683
	ret ; $5684
.halveLong:
	sra d ; $5685
	rr e ; $5687
.fromBallXLong:
	ld hl, wBallX ; $5689
	ld a, [hl+] ; $568c
	ld h, [hl] ; $568d
	ld l, a ; $568e
	add hl, de ; $568f
	ld e, l ; $5690
	ld d, h ; $5691
	call ClampShotTargetX ; $5692
	ret ; $5695
.straight:
	ld hl, wBallX ; $5696
	ld a, [hl+] ; $5699
	ld d, [hl] ; $569a
	ld e, a ; $569b
	sra d ; $569c
	rr e ; $569e
	sra d ; $56a0
	rr e ; $56a2
	call GetRandomAimJitter ; $56a4
	ld a, e ; $56a7
	sub h ; $56a8
	ld e, a ; $56a9
	jr nc, .absTarget ; $56aa
	dec d ; $56ac
.absTarget:
	call GetRandomAimJitter ; $56ad
	ld a, h ; $56b0
	add e ; $56b1
	ld e, a ; $56b2
	jr nc, .store ; $56b3
	inc d ; $56b5
.store:
	ret ; $56b6
