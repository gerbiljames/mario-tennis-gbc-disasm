DpadMaskToAngleTable_04:
	; $532d, 16 bytes (bytes:1)
	db $ff ; 0x00
	db $00 ; 0x01
	db $80 ; 0x02
	db $ff ; 0x03
	db $c0 ; 0x04
	db $e0 ; 0x05
	db $a0 ; 0x06
	db $c0 ; 0x07
	db $40 ; 0x08
	db $20 ; 0x09
	db $60 ; 0x0a
	db $40 ; 0x0b
	db $ff ; 0x0c
	db $00 ; 0x0d
	db $80 ; 0x0e
	db $ff ; 0x0f
IsPointBlocked:
	call IsTerrainBlockedAtPoint ; $533d
	and a ; $5340
	jr nz, .terrain ; $5341
	call FindActorAtPoint ; $5343
	jr .done ; $5346
.terrain:
	or $80 ; $5348
.done:
	ret ; $534a
IsTerrainBlockedAtPoint:
	push de ; $534b
	ld e, d ; $534c
	ld d, h ; $534d
	farcall ReadCollisionMapCell ; $534e
	and $0f ; $5351
	jr z, .done ; $5353
	cp $0f ; $5355
	jr z, .done ; $5357
	xor a ; $5359
.done:
	pop de ; $535a
	ret ; $535b
TestPointInBox:
	ld a, b ; $535c
	dec a ; $535d
	sub h ; $535e
	cp d ; $535f
	jr nc, .inside ; $5360
	ld a, b ; $5362
	dec a ; $5363
	add h ; $5364
	cp d ; $5365
	jr c, .inside ; $5366
	ld a, c ; $5368
	dec a ; $5369
	sub l ; $536a
	cp e ; $536b
	jr nc, .inside ; $536c
	ld a, c ; $536e
	dec a ; $536f
	add l ; $5370
	cp e ; $5371
	jr c, .inside ; $5372
	xor a ; $5374
	jr .done ; $5375
.inside:
	ld a, $ff ; $5377
.done:
	ret ; $5379
IsPointNearPlayer:
	push bc ; $537a
	push de ; $537b
	push hl ; $537c
	ld c, l ; $537d
	ld b, h ; $537e
	ld hl, wActors + 10 ; $537f
	ld a, [hl+] ; $5382
	ld h, [hl] ; $5383
	ld l, a ; $5384
	ld a, l ; $5385
	sub e ; $5386
	ld l, a ; $5387
	ld a, h ; $5388
	sbc d ; $5389
	ld h, a ; $538a
	bit 7, h ; $538b
	jr z, .absX ; $538d
	xor a ; $538f
	sub l ; $5390
	ld l, a ; $5391
	sbc a ; $5392
	sub h ; $5393
	ld h, a ; $5394
.absX:
	srl h ; $5395
	rr l ; $5397
	ld a, h ; $5399
	and a ; $539a
	jr nz, .tooFar ; $539b
	ld a, l ; $539d
	call GetSquareOfByte ; $539e
	ld e, l ; $53a1
	ld d, h ; $53a2
	ld hl, wActors + 8 ; $53a3
	ld a, [hl+] ; $53a6
	ld h, [hl] ; $53a7
	ld l, a ; $53a8
	ld a, l ; $53a9
	sub c ; $53aa
	ld l, a ; $53ab
	ld a, h ; $53ac
	sbc b ; $53ad
	ld h, a ; $53ae
	bit 7, h ; $53af
	jr z, .absDepth ; $53b1
	xor a ; $53b3
	sub l ; $53b4
	ld l, a ; $53b5
	sbc a ; $53b6
	sub h ; $53b7
	ld h, a ; $53b8
.absDepth:
	srl h ; $53b9
	rr l ; $53bb
	ld a, h ; $53bd
	and a ; $53be
	jr nz, .tooFar ; $53bf
	ld a, l ; $53c1
	call GetSquareOfByte ; $53c2
	add hl, de ; $53c5
	jr c, .tooFar ; $53c6
	ld de, $4000 ; $53c8
	add hl, de ; $53cb
	jr c, .tooFar ; $53cc
	ld a, $01 ; $53ce
	jr .done ; $53d0
.tooFar:
	xor a ; $53d2
.done:
	pop hl ; $53d3
	pop de ; $53d4
	pop bc ; $53d5
	ret ; $53d6
FindActorAtPoint:
	push bc ; $53d7
	push de ; $53d8
	push hl ; $53d9
	ld c, l ; $53da
	ld b, h ; $53db
	ld hl, wActorQueryPointX ; $53dc
	ld a, c ; $53df
	ld [hl+], a ; $53e0
	ld a, b ; $53e1
	ld [hl+], a ; $53e2
	ld a, e ; $53e3
	ld [hl+], a ; $53e4
	ld a, d ; $53e5
	ld [hl+], a ; $53e6
	ld hl, wNearbyActorList ; $53e7
.actorLoop:
	ld a, [hl+] ; $53ea
	ld c, a ; $53eb
	ld a, [hl+] ; $53ec
	ld b, a ; $53ed
	and a ; $53ee
	jr z, .done ; $53ef
	push hl ; $53f1
	ld hl, wActorQueryPointY ; $53f2
	ld a, [hl+] ; $53f5
	ld d, [hl] ; $53f6
	ld e, a ; $53f7
	ld hl, ACTORF_Y ; $53f8
	add hl, bc ; $53fb
	ld a, [hl+] ; $53fc
	ld h, [hl] ; $53fd
	ld l, a ; $53fe
	ld a, l ; $53ff
	sub e ; $5400
	ld l, a ; $5401
	ld a, h ; $5402
	sbc d ; $5403
	ld h, a ; $5404
	bit 7, h ; $5405
	jr z, .checkX ; $5407
	xor a ; $5409
	sub l ; $540a
	ld l, a ; $540b
	sbc a ; $540c
	sub h ; $540d
	ld h, a ; $540e
.checkX:
	ld a, h ; $540f
	and a ; $5410
	jr nz, .nextActor ; $5411
	ld a, l ; $5413
	call GetSquareOfByte ; $5414
	push hl ; $5417
	ld hl, wActorQueryPointX ; $5418
	ld a, [hl+] ; $541b
	ld d, [hl] ; $541c
	ld e, a ; $541d
	ld hl, ACTORF_X ; $541e
	add hl, bc ; $5421
	ld a, [hl+] ; $5422
	ld h, [hl] ; $5423
	ld l, a ; $5424
	ld a, l ; $5425
	sub e ; $5426
	ld l, a ; $5427
	ld a, h ; $5428
	sbc d ; $5429
	ld h, a ; $542a
	bit 7, h ; $542b
	jr z, .checkDepth ; $542d
	xor a ; $542f
	sub l ; $5430
	ld l, a ; $5431
	sbc a ; $5432
	sub h ; $5433
	ld h, a ; $5434
.checkDepth:
	pop de ; $5435
	ld a, h ; $5436
	and a ; $5437
	jr nz, .nextActor ; $5438
	ld a, l ; $543a
	call GetSquareOfByte ; $543b
	add hl, de ; $543e
	jr c, .nextActor ; $543f
	ld de, $1f00 ; $5441
	add hl, de ; $5444
	jr c, .nextActor ; $5445
	pop hl ; $5447
	ld l, c ; $5448
	ld h, b ; $5449
	call ActorSlotPtrToIndex ; $544a
	jr .done ; $544d
.nextActor:
	pop hl ; $544f
	jr .actorLoop ; $5450
.done:
	pop hl ; $5452
	pop de ; $5453
	pop bc ; $5454
	ret ; $5455
BuildNearbyActorList:
	push af ; $5456
	push bc ; $5457
	push de ; $5458
	push hl ; $5459
	ld hl, wNearbyActorList ; $545a
	ld bc, wActors ; $545d
	ld a, $18 ; $5460
.actorLoop:
	push af ; $5462
	push hl ; $5463
	inc c ; $5464
	ld a, [bc] ; $5465
	dec c ; $5466
	or a ; $5467
	jr z, .done ; $5468
	ld hl, ACTORF_STATUS ; $546a
	add hl, bc ; $546d
	bit 7, [hl] ; $546e
	jr z, .done ; $5470
	ld hl, ACTORF_FLAGS ; $5472
	add hl, bc ; $5475
	bit 3, [hl] ; $5476
	jr z, .done ; $5478
	ld hl, wActors + 14 ; $547a
	ld a, [hl+] ; $547d
	ld d, [hl] ; $547e
	ld e, a ; $547f
	ld hl, ACTORF_Y ; $5480
	add hl, bc ; $5483
	ld a, [hl+] ; $5484
	ld h, [hl] ; $5485
	ld l, a ; $5486
	ld a, l ; $5487
	sub e ; $5488
	ld l, a ; $5489
	ld a, h ; $548a
	sbc d ; $548b
	ld h, a ; $548c
	bit 7, h ; $548d
	jr z, .withinRange ; $548f
	xor a ; $5491
	sub l ; $5492
	ld l, a ; $5493
	sbc a ; $5494
	sub h ; $5495
	ld h, a ; $5496
.withinRange:
	ld a, h ; $5497
	and $fe ; $5498
	jr nz, .done ; $549a
	ld hl, wActors + 12 ; $549c
	ld a, [hl+] ; $549f
	ld d, [hl] ; $54a0
	ld e, a ; $54a1
	ld hl, ACTORF_X ; $54a2
	add hl, bc ; $54a5
	ld a, [hl+] ; $54a6
	ld h, [hl] ; $54a7
	ld l, a ; $54a8
	ld a, l ; $54a9
	sub e ; $54aa
	ld l, a ; $54ab
	ld a, h ; $54ac
	sbc d ; $54ad
	ld h, a ; $54ae
	bit 7, h ; $54af
	jr z, .next ; $54b1
	xor a ; $54b3
	sub l ; $54b4
	ld l, a ; $54b5
	sbc a ; $54b6
	sub h ; $54b7
	ld h, a ; $54b8
.next:
	ld a, h ; $54b9
	and $fe ; $54ba
	jr nz, .done ; $54bc
	pop hl ; $54be
	ld a, c ; $54bf
	ld [hl+], a ; $54c0
	ld a, b ; $54c1
	ld [hl+], a ; $54c2
	push hl ; $54c3
.done:
	ld hl, $0040 ; $54c4
	add hl, bc ; $54c7
	ld c, l ; $54c8
	ld b, h ; $54c9
	pop hl ; $54ca
	pop af ; $54cb
	dec a ; $54cc
	jr nz, .actorLoop ; $54cd
	xor a ; $54cf
	ld [hl+], a ; $54d0
	ld [hl+], a ; $54d1
	pop hl ; $54d2
	pop de ; $54d3
	pop bc ; $54d4
	pop af ; $54d5
	ret ; $54d6
BuildActorQueryList:
	push af ; $54d7
	push bc ; $54d8
	push de ; $54d9
	push hl ; $54da
	ld hl, wNearbyActorList ; $54db
	ld bc, wActors ; $54de
	ld a, $18 ; $54e1
.actorLoop:
	push af ; $54e3
	push hl ; $54e4
	inc c ; $54e5
	ld a, [bc] ; $54e6
	dec c ; $54e7
	or a ; $54e8
	jr z, .done ; $54e9
	ld hl, ACTORF_STATUS ; $54eb
	add hl, bc ; $54ee
	bit 7, [hl] ; $54ef
	jr z, .done ; $54f1
	ld hl, ACTORF_FLAGS ; $54f3
	add hl, bc ; $54f6
	bit 4, [hl] ; $54f7
	jr z, .done ; $54f9
	pop hl ; $54fb
	ld a, c ; $54fc
	ld [hl+], a ; $54fd
	ld a, b ; $54fe
	ld [hl+], a ; $54ff
	push hl ; $5500
.done:
	ld hl, $0040 ; $5501
	add hl, bc ; $5504
	ld c, l ; $5505
	ld b, h ; $5506
	pop hl ; $5507
	pop af ; $5508
	dec a ; $5509
	jr nz, .actorLoop ; $550a
	xor a ; $550c
	ld [hl+], a ; $550d
	ld [hl+], a ; $550e
	pop hl ; $550f
	pop de ; $5510
	pop bc ; $5511
	pop af ; $5512
	ret ; $5513
ActorSlotPtrToIndex:
	push de ; $5514
	push hl ; $5515
	ld a, $ff ; $5516
	inc h ; $5518
	dec h ; $5519
	jr z, .done ; $551a
	ld de, $3000 ; $551c
	add hl, de ; $551f
	add hl, hl ; $5520
	add hl, hl ; $5521
	ld a, h ; $5522
.done:
	pop hl ; $5523
	pop de ; $5524
	ret ; $5525
DrawAndAnimateActor:
	call DrawActorSprite ; $5526
	ld hl, ACTORF_STATUS ; $5529
	add hl, bc ; $552c
	bit 7, [hl] ; $552d
	jr nz, .drawAndAnimate ; $552f
	bit 3, [hl] ; $5531
	ret z ; $5533
	call AdvanceActorAnimation ; $5534
	ret ; $5537
.drawAndAnimate:
	call AdvanceActorAnimation ; $5538
	call UpdateActorFacingFromHeading ; $553b
	call QueueActorFrameTileCopy ; $553e
	ret ; $5541
DrawActorSprite:
	ld hl, ACTORF_STATUS ; $5542
	add hl, bc ; $5545
	res 7, [hl] ; $5546
	ld hl, wActorScreenOriginY ; $5548
	ld a, [hl+] ; $554b
	ld d, [hl] ; $554c
	ld e, a ; $554d
	ld hl, $0010 ; $554e
	add hl, bc ; $5551
	ld a, [hl+] ; $5552
	ld h, [hl] ; $5553
	ld l, a ; $5554
	bit 7, h ; $5555
	jr z, .offscreen ; $5557
	xor a ; $5559
	sub l ; $555a
	ld l, a ; $555b
	sbc a ; $555c
	sub h ; $555d
	ld h, a ; $555e
	xor a ; $555f
	sub e ; $5560
	ld e, a ; $5561
	sbc a ; $5562
	sub d ; $5563
	ld d, a ; $5564
	srl h ; $5565
	rr l ; $5567
	add hl, de ; $5569
	ld e, l ; $556a
	ld d, h ; $556b
	ld hl, ACTORF_Y ; $556c
	add hl, bc ; $556f
	ld a, [hl+] ; $5570
	ld h, [hl] ; $5571
	ld l, a ; $5572
	ld a, l ; $5573
	sub e ; $5574
	ld l, a ; $5575
	ld a, h ; $5576
	sbc d ; $5577
	ld h, a ; $5578
	jr .queue ; $5579
.offscreen:
	ld hl, ACTORF_Y ; $557b
	add hl, bc ; $557e
	ld a, [hl+] ; $557f
	ld h, [hl] ; $5580
	ld l, a ; $5581
	add hl, de ; $5582
.queue:
	ld de, $0090 ; $5583
	add hl, de ; $5586
	ld a, h ; $5587
	cp $14 ; $5588
	jr nc, .done ; $558a
	add hl, hl ; $558c
	add hl, hl ; $558d
	add hl, hl ; $558e
	ld e, h ; $558f
	push de ; $5590
	ld hl, wActorScreenOriginX ; $5591
	ld a, [hl+] ; $5594
	ld d, [hl] ; $5595
	ld e, a ; $5596
	ld hl, ACTORF_X ; $5597
	add hl, bc ; $559a
	ld a, [hl+] ; $559b
	ld h, [hl] ; $559c
	ld l, a ; $559d
	add hl, de ; $559e
	ld de, $0010 ; $559f
	add hl, de ; $55a2
	pop de ; $55a3
	ld a, h ; $55a4
	inc a ; $55a5
	cp $16 ; $55a6
	jr nc, .done ; $55a8
	add hl, hl ; $55aa
	add hl, hl ; $55ab
	add hl, hl ; $55ac
	ld d, h ; $55ad
	push bc ; $55ae
	ld hl, $0036 ; $55af
	add hl, bc ; $55b2
	ld a, [hl+] ; $55b3
	ld b, [hl] ; $55b4
	ld c, a ; $55b5
	call QueueSprite16 ; $55b6
	pop bc ; $55b9
	ld hl, ACTORF_STATUS ; $55ba
	add hl, bc ; $55bd
	set 7, [hl] ; $55be
.done:
	ret ; $55c0
AdvanceActorAnimation:
	ld hl, ACTORF_STATUS ; $55c1
	add hl, bc ; $55c4
	bit 1, [hl] ; $55c5
	jr nz, .frameReady ; $55c7
	ld hl, $002f ; $55c9
	add hl, bc ; $55cc
	ld a, [hl] ; $55cd
	and a ; $55ce
	jr nz, .frameReady ; $55cf
.nextCommand:
	push bc ; $55d1
	ld hl, $0022 ; $55d2
	add hl, bc ; $55d5
	ld a, [hl] ; $55d6
	ld d, a ; $55d7
	ld hl, $002c ; $55d8
	add hl, bc ; $55db
	ld a, [hl+] ; $55dc
	ld h, [hl] ; $55dd
	ld l, a ; $55de
	ld a, d ; $55df
	call FarReadWord ; $55e0
	ld e, c ; $55e3
	ld d, b ; $55e4
	pop bc ; $55e5
	ld a, e ; $55e6
	cp $f0 ; $55e7
	jr c, .setFrameDelay ; $55e9
	cp $ff ; $55eb
	jr z, .jumpToFrames ; $55ed
	cp $fe ; $55ef
	jr z, .setAnimation ; $55f1
	ld hl, $002f ; $55f3
	add hl, bc ; $55f6
	ld [hl], $ff ; $55f7
	jr .frameReady ; $55f9
.jumpToFrames:
	ld hl, $002a ; $55fb
	add hl, bc ; $55fe
	ld a, [hl+] ; $55ff
	ld h, [hl] ; $5600
	ld l, a ; $5601
	ld e, d ; $5602
	ld d, $00 ; $5603
	add hl, de ; $5605
	ld e, l ; $5606
	ld d, h ; $5607
	ld hl, $002c ; $5608
	add hl, bc ; $560b
	ld a, e ; $560c
	ld [hl+], a ; $560d
	ld [hl], d ; $560e
	jr .nextCommand ; $560f
.setAnimation:
	call SetActorAnimation ; $5611
	jr .nextCommand ; $5614
.setFrameDelay:
	ld hl, $002f ; $5616
	add hl, bc ; $5619
	ld [hl], d ; $561a
	push de ; $561b
	ld hl, $002c ; $561c
	add hl, bc ; $561f
	ld a, [hl+] ; $5620
	ld d, [hl] ; $5621
	ld e, a ; $5622
	inc de ; $5623
	inc de ; $5624
	ld a, d ; $5625
	ld [hl-], a ; $5626
	ld [hl], e ; $5627
	pop de ; $5628
	jr .checkFlip ; $5629
.frameReady:
	ld hl, $0033 ; $562b
	add hl, bc ; $562e
	ld e, [hl] ; $562f
.checkFlip:
	push bc ; $5630
	ld hl, ACTORF_FLAGS ; $5631
	add hl, bc ; $5634
	bit 7, [hl] ; $5635
	jr z, .noFlip ; $5637
	ld hl, $0019 ; $5639
	add hl, bc ; $563c
	push hl ; $563d
	ld hl, $002f ; $563e
	add hl, bc ; $5641
	ld c, [hl] ; $5642
	pop hl ; $5643
	ld b, [hl] ; $5644
	ld a, c ; $5645
	sub b ; $5646
	jr nc, .storeFrame ; $5647
	xor a ; $5649
	jr .storeFrame ; $564a
.noFlip:
	ld hl, $0018 ; $564c
	add hl, bc ; $564f
	push hl ; $5650
	ld hl, $002f ; $5651
	add hl, bc ; $5654
	ld c, [hl] ; $5655
	pop hl ; $5656
	ld b, [hl] ; $5657
	ld a, c ; $5658
	sub b ; $5659
	jr nc, .storeFrame ; $565a
	xor a ; $565c
.storeFrame:
	pop bc ; $565d
	ld hl, $002f ; $565e
	add hl, bc ; $5661
	ld [hl], a ; $5662
	ld hl, $0033 ; $5663
	add hl, bc ; $5666
	ld a, [hl] ; $5667
	cp e ; $5668
	jr z, .done ; $5669
	ld [hl], e ; $566b
	ld hl, ACTORF_STATUS ; $566c
	add hl, bc ; $566f
	set 6, [hl] ; $5670
.done:
	ret ; $5672
UpdateActorFacingFromHeading:
	ld hl, ACTORF_STATUS ; $5673
	add hl, bc ; $5676
	bit 0, [hl] ; $5677
	jr nz, .fromTable ; $5679
	ld hl, ACTORF_HEADING ; $567b
	add hl, bc ; $567e
	ld a, [hl] ; $567f
	ld hl, ACTORF_FACING ; $5680
	add hl, bc ; $5683
	ld [hl], a ; $5684
.fromTable:
	ld d, $00 ; $5685
	ld hl, ACTORF_FACING_COUNT ; $5687
	add hl, bc ; $568a
	ld a, [hl] ; $568b
	cp $01 ; $568c
	jr z, .store ; $568e
	ld hl, ACTORF_FACING ; $5690
	add hl, bc ; $5693
	ld a, [hl] ; $5694
	add $08 ; $5695
	swap a ; $5697
	and $0f ; $5699
	ld_hl_indexed DirectionToFacing_04 ; $569b
	ld d, [hl] ; $56a2
.store:
	ld hl, ACTORF_DRAWN_FACING ; $56a3
	add hl, bc ; $56a6
	ld a, [hl] ; $56a7
	cp d ; $56a8
	jr z, .done ; $56a9
	ld [hl], d ; $56ab
	ld hl, ACTORF_STATUS ; $56ac
	add hl, bc ; $56af
	set 6, [hl] ; $56b0
.done:
	ret ; $56b2
DirectionToFacing_04:
	; $56b3, 16 bytes (enum:FACE:8)
	db FACE_RIGHT, FACE_RIGHT, FACE_DOWN, FACE_DOWN, FACE_DOWN, FACE_DOWN, FACE_DOWN, FACE_LEFT ; 0x00
	db FACE_LEFT, FACE_LEFT, FACE_UP, FACE_UP, FACE_UP, FACE_UP, FACE_UP, FACE_RIGHT ; 0x08
QueueActorFrameTileCopy:
	test_flag FLAG_ACTORS_FROZEN ; $56c3
	ret nz ; $56c6
	ld hl, ACTORF_STATUS ; $56c7
	add hl, bc ; $56ca
	bit 6, [hl] ; $56cb
	ret z ; $56cd
	res 6, [hl] ; $56ce
	push bc ; $56d0
	ld hl, ACTORF_FRAME_TABLE ; $56d1
	add hl, bc ; $56d4
	ld a, [hl+] ; $56d5
	ld h, [hl] ; $56d6
	ld l, a ; $56d7
	ld a, e ; $56d8
	add a ; $56d9
	add l ; $56da
	ld l, a ; $56db
	jr nc, .queue ; $56dc
	inc h ; $56de
.queue:
	ld a, [wActorScriptBank] ; $56df
	call FarReadWord ; $56e2
	ld l, c ; $56e5
	ld h, b ; $56e6
	ld a, d ; $56e7
	add l ; $56e8
	ld l, a ; $56e9
	jr nc, .done ; $56ea
	inc h ; $56ec
.done:
	pop bc ; $56ed
	push hl ; $56ee
	ld hl, $0026 ; $56ef
	add hl, bc ; $56f2
	ld a, [hl+] ; $56f3
	ld d, [hl] ; $56f4
	ld e, a ; $56f5
	pop hl ; $56f6
	push bc ; $56f7
	ld a, [wActorScriptBank] ; $56f8
	ld b, a ; $56fb
	ld c, $04 ; $56fc
	call QueueVRAMCopyFromBank ; $56fe
	pop bc ; $5701
	ret ; $5702
IsActorJumping:
	inc h ; $5703
	dec h ; $5704
	ret z ; $5705
	push bc ; $5706
	push de ; $5707
	push hl ; $5708
	wram_bank WRAM_ACTORS ; $5709
	ld c, l ; $570f
	ld b, h ; $5710
	ld hl, $0012 ; $5711
	add hl, bc ; $5714
	ld a, [hl+] ; $5715
	ld d, [hl] ; $5716
	ld e, a ; $5717
	ld hl, $0010 ; $5718
	add hl, bc ; $571b
	ld a, [hl+] ; $571c
	ld h, [hl] ; $571d
	ld l, a ; $571e
	or h ; $571f
	or d ; $5720
	or e ; $5721
	pop hl ; $5722
	pop de ; $5723
	pop bc ; $5724
	ret ; $5725
WaitActorJumpDone:
	push af ; $5726
	push bc ; $5727
	ld c, $b4 ; $5728
.waitLoop:
	call IsActorJumping ; $572a
	jr z, .done ; $572d
	call AdvanceFrame ; $572f
	dec c ; $5732
	jr nz, .waitLoop ; $5733
.done:
	pop bc ; $5735
	pop af ; $5736
	ret ; $5737
IsActorMoving:
	inc h ; $5738
	dec h ; $5739
	ret z ; $573a
	push hl ; $573b
	wram_bank WRAM_ACTORS ; $573c
	ld a, $05 ; $5742
	add l ; $5744
	ld l, a ; $5745
	jr nc, .readFlag ; $5746
	inc h ; $5748
.readFlag:
	bit 7, [hl] ; $5749
	jr z, .idle ; $574b
	ld a, $01 ; $574d
	jr .done ; $574f
.idle:
	ld a, $00 ; $5751
.done:
	pop hl ; $5753
	ret ; $5754
WaitActorMoveDone:
	push af ; $5755
	push bc ; $5756
	ld bc, $0258 ; $5757
.waitLoop:
	call IsActorMoving ; $575a
	jr z, .done ; $575d
	call AdvanceFrame ; $575f
	dec bc ; $5762
	ld a, c ; $5763
	or b ; $5764
	jr nz, .waitLoop ; $5765
.done:
	pop bc ; $5767
	pop af ; $5768
	ret ; $5769
	; $576a, 10390 bytes fill to bank end (linker-padded)
