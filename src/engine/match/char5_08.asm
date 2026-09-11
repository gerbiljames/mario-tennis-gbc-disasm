UnusedLatchSwingHoldButton:
	ld a, b ; $7278
	ld [wCharSwingHoldButton], a ; $7279
	xor a ; $727c
	ld [wCharSwingHoldFrames], a ; $727d
.tickTimer:
	ld hl, wCharSwingHoldFrames ; $7280
	inc [hl] ; $7283
	xor a ; $7284
	ret ; $7285
DpadToFacingTable_08:
	; $7286, 16 bytes (bytes:8)
	db $ff, $00, $80, $ff, $c0, $e0, $a0, $c0 ; 0x00
	db $40, $20, $60, $40, $ff, $00, $80, $ff ; 0x08
AngleToDpadTable_08:
	INCBIN "data/bank_008/AngleToDpadTable_08.bin" ; $7296, 16 bytes
StepCharJumpPhysics:
	ld hl, wCharFlags ; $72a6
	bit CHARB_AIRBORNE, [hl] ; $72a9
	ret z ; $72ab
	ld hl, wCharVelHeight ; $72ac
	ld a, [hl+] ; $72af
	ld d, [hl] ; $72b0
	ld e, a ; $72b1
	ld hl, wCharPosHeight ; $72b2
	call AddDEToMem24 ; $72b5
	ld a, [wCharPosHeight + 2] ; $72b8
	bit 7, a ; $72bb
	jr z, .clearHeight ; $72bd
	ld hl, wCharVelHeight ; $72bf
	ld de, $0090 ; $72c2
	ld a, [hl] ; $72c5
	add e ; $72c6
	ld [hl+], a ; $72c7
	ld a, [hl] ; $72c8
	adc d ; $72c9
	ld [hl+], a ; $72ca
	ret ; $72cb
.clearHeight:
	xor a ; $72cc
	ld hl, wCharPosHeight ; $72cd
	ld [hl+], a ; $72d0
	ld [hl+], a ; $72d1
	ld [hl+], a ; $72d2
	ld hl, wCharVelHeight ; $72d3
	ld [hl+], a ; $72d6
	ld [hl+], a ; $72d7
	ld hl, wCharFlags ; $72d8
	res CHARB_AIRBORNE, [hl] ; $72db
	ret ; $72dd
StepCharMovement:
	ld hl, wCharVelX ; $72de
	ld a, [hl+] ; $72e1
	ld b, [hl] ; $72e2
	ld c, a ; $72e3
	ld hl, wCharVelDepth ; $72e4
	ld a, [hl+] ; $72e7
	ld d, [hl] ; $72e8
	ld e, a ; $72e9
	ld hl, wCharFlags ; $72ea
	bit CHARB_CHARGING, [hl] ; $72ed
	jr z, .move ; $72ef
	sra b ; $72f1
	rr c ; $72f3
	sra b ; $72f5
	rr c ; $72f7
	sra b ; $72f9
	rr c ; $72fb
	sra d ; $72fd
	rr e ; $72ff
	sra d ; $7301
	rr e ; $7303
	sra d ; $7305
	rr e ; $7307
.move:
	ld hl, wCharFlags ; $7309
	res CHARB_MOVE_BLOCKED, [hl] ; $730c
	ld a, [wCharInputSource] ; $730e
	cp $01 ; $7311
	jp z, .unclamped ; $7313
	push de ; $7316
	ld e, c ; $7317
	ld d, b ; $7318
	ld hl, wCharPosX ; $7319
	call AddDEToMem24IntoBC ; $731c
	ld hl, $fc60 ; $731f
	add hl, bc ; $7322
	bit 7, h ; $7323
	jr z, .blockX ; $7325
	ld hl, $03a0 ; $7327
	add hl, bc ; $732a
	bit 7, h ; $732b
	jr nz, .blockX ; $732d
	ld hl, $fdc0 ; $732f
	add hl, bc ; $7332
	bit 7, h ; $7333
	jr nz, .applyX ; $7335
	ld hl, wCharPosDepth + 1 ; $7337
	ld a, [hl+] ; $733a
	ld b, [hl] ; $733b
	ld c, a ; $733c
	bit 7, b ; $733d
	jr z, .applyX ; $733f
	ld hl, $02a0 ; $7341
	add hl, bc ; $7344
	bit 7, h ; $7345
	jr nz, .applyX ; $7347
.blockX:
	ld hl, wCharFlags ; $7349
	set CHARB_MOVE_BLOCKED, [hl] ; $734c
	jr .stepDepth ; $734e
.applyX:
	ld hl, wCharPosX ; $7350
	call AddDEToMem24 ; $7353
.stepDepth:
	pop de ; $7356
	ld hl, wCharPosDepth ; $7357
	call AddDEToMem24IntoBC ; $735a
	bit 7, b ; $735d
	jr nz, .farSide ; $735f
	ld hl, $ff70 ; $7361
	add hl, bc ; $7364
	jr nc, .blockDepth ; $7365
	ld hl, $f920 ; $7367
	add hl, bc ; $736a
	jr c, .blockDepth ; $736b
	jr .applyDepth ; $736d
.farSide:
	ld hl, $0100 ; $736f
	add hl, bc ; $7372
	jr c, .blockDepth ; $7373
	ld hl, $0700 ; $7375
	add hl, bc ; $7378
	jr nc, .blockDepth ; $7379
	ld hl, $02a0 ; $737b
	add hl, bc ; $737e
	bit 7, h ; $737f
	jr nz, .applyDepth ; $7381
	ld hl, wCharPosX + 1 ; $7383
	ld a, [hl+] ; $7386
	ld b, [hl] ; $7387
	ld c, a ; $7388
	ld hl, $fdc0 ; $7389
	add hl, bc ; $738c
	bit 7, h ; $738d
	jr nz, .applyDepth ; $738f
.blockDepth:
	ld hl, wCharFlags ; $7391
	set CHARB_MOVE_BLOCKED, [hl] ; $7394
	jr .done ; $7396
.applyDepth:
	ld hl, wCharPosDepth ; $7398
	call AddDEToMem24 ; $739b
.done:
	ret ; $739e
.unclamped:
	ld hl, wCharPosX ; $739f
	call AddBCToMem24 ; $73a2
	ld hl, wCharPosDepth ; $73a5
	call AddDEToMem24IntoBC ; $73a8
	bit 7, b ; $73ab
	jr nz, .unclampedFarSide ; $73ad
	ld hl, $ff70 ; $73af
	add hl, bc ; $73b2
	jr nc, .doneUnclamped ; $73b3
	jr .applyDepthUnclamped ; $73b5
.unclampedFarSide:
	ld hl, $0100 ; $73b7
	add hl, bc ; $73ba
	jr c, .doneUnclamped ; $73bb
.applyDepthUnclamped:
	ld hl, wCharPosDepth ; $73bd
	call AddDEToMem24 ; $73c0
	ret ; $73c3
.doneUnclamped:
	ld hl, wCharFlags ; $73c4
	set CHARB_MOVE_BLOCKED, [hl] ; $73c7
	ret ; $73c9
UpdateCharVelocityFromInput:
	ld a, [wCharScriptedMove] ; $73ca
	and a ; $73cd
	ret nz ; $73ce
	ld hl, wCharFlags ; $73cf
	bit CHARB_DIVING, [hl] ; $73d2
	jp nz, .clearAxisFlags ; $73d4
	bit CHARB_RECOIL, [hl] ; $73d7
	jp nz, .clearAxisFlags ; $73d9
	jr .stepX ; $73dc
.clearAxisFlags:
	ld hl, wCharBallReachFlags ; $73de
	res 6, [hl] ; $73e1
	res 7, [hl] ; $73e3
.stepX:
	ld hl, wCharBallReachFlags ; $73e5
	bit 6, [hl] ; $73e8
	jr z, .decelX ; $73ea
	call AccelerateCharX ; $73ec
	jr .stepDepth ; $73ef
.decelX:
	call DecelerateCharX ; $73f1
.stepDepth:
	ld hl, wCharBallReachFlags ; $73f4
	bit 7, [hl] ; $73f7
	jr z, .decelDepth ; $73f9
	call AccelerateCharDepth ; $73fb
	jr .clampX ; $73fe
.decelDepth:
	call DecelerateCharDepth ; $7400
.clampX:
	ld hl, wCharBallReachFlags ; $7403
	bit 6, [hl] ; $7406
	jr z, .clampDepth ; $7408
	call ClampCharXSpeed ; $740a
.clampDepth:
	ld hl, wCharBallReachFlags ; $740d
	bit 7, [hl] ; $7410
	jr z, .markMoving ; $7412
	call ClampCharDepthSpeed ; $7414
.markMoving:
	ld hl, wCharBallReachFlags ; $7417
	res 6, [hl] ; $741a
	res 7, [hl] ; $741c
	ld hl, wCharFlags ; $741e
	set CHARB_MOVING, [hl] ; $7421
	ld hl, wCharVelX ; $7423
	ld a, [hl+] ; $7426
	or [hl] ; $7427
	inc hl ; $7428
	or [hl] ; $7429
	inc hl ; $742a
	or [hl] ; $742b
	jr nz, .done ; $742c
	ld hl, wCharFlags ; $742e
	res CHARB_MOVING, [hl] ; $7431
	ld a, [wCharInputBits] ; $7433
	and $f0 ; $7436
	jr nz, .done ; $7438
	ld a, [wCharBaseFacing] ; $743a
	ld [wCharFacingDesired], a ; $743d
.done:
	ret ; $7440
AccelerateCharDepth:
	ld hl, wCharAcceleration ; $7441
	ld a, [hl+] ; $7444
	ld h, [hl] ; $7445
	ld l, a ; $7446
	ld a, [wCharFacingDesired] ; $7447
	call MulHLBySin ; $744a
	add hl, hl ; $744d
	add hl, hl ; $744e
	ld e, l ; $744f
	ld d, h ; $7450
	ld hl, wCharVelDepth ; $7451
	ld a, [hl] ; $7454
	add e ; $7455
	ld [hl+], a ; $7456
	ld a, [hl] ; $7457
	adc d ; $7458
	ld [hl+], a ; $7459
	ret ; $745a
AccelerateCharX:
	ld hl, wCharAcceleration ; $745b
	ld a, [hl+] ; $745e
	ld h, [hl] ; $745f
	ld l, a ; $7460
	ld a, [wCharFacingDesired] ; $7461
	call MulHLByCos ; $7464
	add hl, hl ; $7467
	add hl, hl ; $7468
	ld e, l ; $7469
	ld d, h ; $746a
	ld hl, wCharVelX ; $746b
	ld a, [hl] ; $746e
	add e ; $746f
	ld [hl+], a ; $7470
	ld a, [hl] ; $7471
	adc d ; $7472
	ld [hl+], a ; $7473
	ret ; $7474
DecelerateCharDepth:
	ld hl, wCharVelDepth ; $7475
	ld a, [hl+] ; $7478
	ld d, [hl] ; $7479
	ld e, a ; $747a
	ld a, d ; $747b
	or e ; $747c
	ret z ; $747d
	ld hl, wCharDeceleration ; $747e
	ld a, [hl+] ; $7481
	ld h, [hl] ; $7482
	ld l, a ; $7483
	bit 7, d ; $7484
	jr nz, .negate ; $7486
	xor a ; $7488
	sub l ; $7489
	ld l, a ; $748a
	sbc a ; $748b
	sub h ; $748c
	ld h, a ; $748d
.negate:
	add hl, de ; $748e
	ld a, d ; $748f
	xor h ; $7490
	bit 7, a ; $7491
	jr z, .apply ; $7493
	ld hl, $0000 ; $7495
.apply:
	ld a, l ; $7498
	ld [wCharVelDepth], a ; $7499
	ld a, h ; $749c
	ld [wCharVelDepth + 1], a ; $749d
	ret ; $74a0
DecelerateCharX:
	ld hl, wCharVelX ; $74a1
	ld a, [hl+] ; $74a4
	ld d, [hl] ; $74a5
	ld e, a ; $74a6
	ld a, d ; $74a7
	or e ; $74a8
	ret z ; $74a9
	ld hl, wCharDeceleration ; $74aa
	ld a, [hl+] ; $74ad
	ld h, [hl] ; $74ae
	ld l, a ; $74af
	ld a, [wCharFlags] ; $74b0
	bit CHARB_DIVING, a ; $74b3
	jr z, .negate ; $74b5
	ld hl, $0040 ; $74b7
.negate:
	bit 7, d ; $74ba
	jr nz, .apply ; $74bc
	xor a ; $74be
	sub l ; $74bf
	ld l, a ; $74c0
	sbc a ; $74c1
	sub h ; $74c2
	ld h, a ; $74c3
.apply:
	add hl, de ; $74c4
	ld a, d ; $74c5
	xor h ; $74c6
	bit 7, a ; $74c7
	jr z, .store ; $74c9
	ld hl, $0000 ; $74cb
.store:
	ld a, l ; $74ce
	ld [wCharVelX], a ; $74cf
	ld a, h ; $74d2
	ld [wCharVelX + 1], a ; $74d3
	ret ; $74d6
ClampCharDepthSpeed:
	ld hl, wCharMaxSpeedDepth ; $74d7
	ld a, [hl+] ; $74da
	ld h, [hl] ; $74db
	ld l, a ; $74dc
	ld a, [wCharFacingDesired] ; $74dd
	call MulHLBySinSigned ; $74e0
	ld c, l ; $74e3
	ld b, h ; $74e4
	ld e, l ; $74e5
	ld d, h ; $74e6
	ld hl, wCharVelDepth ; $74e7
	ld a, [hl+] ; $74ea
	ld h, [hl] ; $74eb
	ld l, a ; $74ec
	bit 7, h ; $74ed
	jr z, .clamp ; $74ef
	xor a ; $74f1
	sub l ; $74f2
	ld l, a ; $74f3
	sbc a ; $74f4
	sub h ; $74f5
	ld h, a ; $74f6
	xor a ; $74f7
	sub c ; $74f8
	ld c, a ; $74f9
	sbc a ; $74fa
	sub b ; $74fb
	ld b, a ; $74fc
.clamp:
	ld a, c ; $74fd
	sub l ; $74fe
	ld c, a ; $74ff
	ld a, b ; $7500
	sbc h ; $7501
	ld b, a ; $7502
	jr nc, .done ; $7503
	ld hl, wCharVelDepth ; $7505
	ld a, e ; $7508
	ld [hl+], a ; $7509
	ld [hl], d ; $750a
.done:
	ret ; $750b
ClampCharXSpeed:
	ld hl, wCharMaxSpeedX ; $750c
	ld a, [hl+] ; $750f
	ld h, [hl] ; $7510
	ld l, a ; $7511
	ld a, [wCharFacingDesired] ; $7512
	call MulHLByCosSigned ; $7515
	ld c, l ; $7518
	ld b, h ; $7519
	ld e, l ; $751a
	ld d, h ; $751b
	ld hl, wCharVelX ; $751c
	ld a, [hl+] ; $751f
	ld h, [hl] ; $7520
	ld l, a ; $7521
	bit 7, h ; $7522
	jr z, .clamp ; $7524
	xor a ; $7526
	sub l ; $7527
	ld l, a ; $7528
	sbc a ; $7529
	sub h ; $752a
	ld h, a ; $752b
	xor a ; $752c
	sub c ; $752d
	ld c, a ; $752e
	sbc a ; $752f
	sub b ; $7530
	ld b, a ; $7531
.clamp:
	ld a, c ; $7532
	sub l ; $7533
	ld c, a ; $7534
	ld a, b ; $7535
	sbc h ; $7536
	ld b, a ; $7537
	jr nc, .done ; $7538
	ld hl, wCharVelX ; $753a
	ld a, e ; $753d
	ld [hl+], a ; $753e
	ld [hl], d ; $753f
.done:
	ret ; $7540
MoveCharTowardTarget:
	call CheckCharNearTarget ; $7541
	and a ; $7544
	jp nz, .toward ; $7545
	ld hl, wCharPosX + 1 ; $7548
	ld a, [hl+] ; $754b
	ld b, [hl] ; $754c
	ld c, a ; $754d
	ld hl, wCharWalkTargetX ; $754e
	ld a, [hl+] ; $7551
	ld d, [hl] ; $7552
	ld e, a ; $7553
	ld a, e ; $7554
	sub c ; $7555
	ld e, a ; $7556
	ld a, d ; $7557
	sbc b ; $7558
	ld d, a ; $7559
	ld hl, wCharPosDepth + 1 ; $755a
	ld a, [hl+] ; $755d
	ld b, [hl] ; $755e
	ld c, a ; $755f
	ld hl, wCharWalkTargetDepth ; $7560
	ld a, [hl+] ; $7563
	ld h, [hl] ; $7564
	ld l, a ; $7565
	ld a, l ; $7566
	sub c ; $7567
	ld l, a ; $7568
	ld a, h ; $7569
	sbc b ; $756a
	ld h, a ; $756b
	call AngleFromVectorCoarse ; $756c
	ld [wCharFacingDesired], a ; $756f
	ld a, [wCharFacingDesired] ; $7572
	ld b, a ; $7575
	ld c, $00 ; $7576
	ld hl, $1000 ; $7578
	call MulSinCos ; $757b
	ld c, l ; $757e
	ld b, h ; $757f
	ld hl, wCharPosX ; $7580
	call AddBCToMem24 ; $7583
	ld hl, wCharPosDepth ; $7586
	call AddDEToMem24 ; $7589
	ld hl, wCharFlags ; $758c
	set CHARB_MOVING, [hl] ; $758f
	ld a, $01 ; $7591
	ld [wCharScriptedMove], a ; $7593
	ld a, $01 ; $7596
	ret ; $7598
.toward:
	ld hl, wCharWalkTargetX ; $7599
	ld a, [hl+] ; $759c
	ld b, [hl] ; $759d
	ld c, a ; $759e
	ld hl, wCharPosX + 1 ; $759f
	ld a, c ; $75a2
	ld [hl+], a ; $75a3
	ld [hl], b ; $75a4
	ld hl, wCharWalkTargetDepth ; $75a5
	ld a, [hl+] ; $75a8
	ld b, [hl] ; $75a9
	ld c, a ; $75aa
	ld hl, wCharPosDepth + 1 ; $75ab
	ld a, c ; $75ae
	ld [hl+], a ; $75af
	ld [hl], b ; $75b0
	xor a ; $75b1
	ld hl, wCharVelX ; $75b2
	ld [hl+], a ; $75b5
	ld [hl+], a ; $75b6
	ld [hl+], a ; $75b7
	ld [hl+], a ; $75b8
	ld hl, wCharFlags ; $75b9
	res CHARB_MOVING, [hl] ; $75bc
	xor a ; $75be
	ret ; $75bf
EaseCharFacing:
	ld hl, wCharFlags ; $75c0
	bit CHARB_DIVING, [hl] ; $75c3
	ret nz ; $75c5
	ld a, [wCharFacingEaseRate] ; $75c6
	ld b, a ; $75c9
	ld a, [wCharFacingDesired] ; $75ca
	ld hl, wCharFacingShown ; $75cd
	sub [hl] ; $75d0
	ret z ; $75d1
	bit 7, a ; $75d2
	jr nz, .negative ; $75d4
	cp b ; $75d6
	jr c, .stepUp ; $75d7
	ld a, b ; $75d9
.stepUp:
	add [hl] ; $75da
	ld [hl], a ; $75db
	ret ; $75dc
.negative:
	cpl ; $75dd
	inc a ; $75de
	cp b ; $75df
	jr c, .stepDown ; $75e0
	ld a, b ; $75e2
.stepDown:
	cpl ; $75e3
	inc a ; $75e4
	add [hl] ; $75e5
	ld [hl], a ; $75e6
	ret ; $75e7
UpdateCharFacingOctant:
	ld a, [wCharAnimId] ; $75e8
	cp CHARANIM_RUN ; $75eb
	jr z, .mirrored ; $75ed
	cp CHARANIM_IDLE ; $75ef
	jr z, .mirrored ; $75f1
	cp CHARANIM_DIVE ; $75f3
	jr z, .easeToShown ; $75f5
	ld a, [wCharBaseFacing] ; $75f7
	jr .toOctant ; $75fa
.easeToShown:
	ld a, [wCharFacingShown] ; $75fc
	ld hl, wCharBaseFacing ; $75ff
	sub [hl] ; $7602
	sra a ; $7603
	add [hl] ; $7605
	jr .toOctant ; $7606
.mirrored:
	ld a, [wCharFacingShown] ; $7608
	add $10 ; $760b
.toOctant:
	rlca ; $760d
	rlca ; $760e
	rlca ; $760f
	and $07 ; $7610
	ld d, a ; $7612
	ld hl, wCharFacingOctant ; $7613
	ld a, [hl] ; $7616
	cp d ; $7617
	jr z, .store ; $7618
	ld [hl], d ; $761a
	ld hl, wCharSpriteDirty ; $761b
	set 6, [hl] ; $761e
.store:
	ret ; $7620
ReloadCharFacingTiles:
	ld hl, wCharSpriteDirty ; $7621
	bit 6, [hl] ; $7624
	ret z ; $7626
	res 6, [hl] ; $7627
	ld a, d ; $7629
	ld_hl_indexed ReloadCharFacingTilesTable ; $762a
	ld d, [hl] ; $7631
	ld a, [wCharAnimFrame] ; $7632
	ld e, a ; $7635
	add a ; $7636
	add a ; $7637
	add e ; $7638
	add d ; $7639
	ld h, $00 ; $763a
	ld l, a ; $763c
	add hl, hl ; $763d
	ld e, l ; $763e
	ld d, h ; $763f
	jp GetPerspectiveScale.checkRomBank ; $7640
ReloadCharFacingTilesTable:
	; $7643, 8 bytes (bytes:8)
	db $02, $03, $04, $03, $02, $01, $00, $01 ; 0x00
