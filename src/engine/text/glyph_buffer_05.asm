PlotGlyphRow:
	push bc ; $737a
	push de ; $737b
	push hl ; $737c
	ld b, a ; $737d
	ld a, e ; $737e
	and $07 ; $737f
	ld c, a ; $7381
	push de ; $7382
	ld de, $ffff ; $7383
	push bc ; $7386
	or a ; $7387
	ld a, b ; $7388
	jr z, .restore ; $7389
.loop:
	srl a ; $738b
	srl e ; $738d
	dec c ; $738f
	jr nz, .loop ; $7390
.restore:
	pop bc ; $7392
	ld h, a ; $7393
	ld a, $08 ; $7394
	sub c ; $7396
	ld c, a ; $7397
	or a ; $7398
	ld a, b ; $7399
	jr z, .zero ; $739a
.loopB:
	sla a ; $739c
	sla d ; $739e
	dec c ; $73a0
	jr nz, .loopB ; $73a1
.zero:
	ld c, a ; $73a3
	ld b, h ; $73a4
	ld h, d ; $73a5
	ld l, e ; $73a6
	pop de ; $73a7
	push hl ; $73a8
	sra d ; $73a9
	rr e ; $73ab
	sra d ; $73ad
	rr e ; $73af
	sra d ; $73b1
	rr e ; $73b3
	ld hl, wGlyphTileBuffer ; $73b5
	add hl, de ; $73b8
	pop de ; $73b9
	ld a, [hl] ; $73ba
	and d ; $73bb
	or b ; $73bc
	ld [hl+], a ; $73bd
	ld b, e ; $73be
	ld de, $000f ; $73bf
	add hl, de ; $73c2
	ld a, [hl] ; $73c3
	and b ; $73c4
	or c ; $73c5
	ld [hl], a ; $73c6
	pop hl ; $73c7
	pop de ; $73c8
	pop bc ; $73c9
	ret ; $73ca
ClearGlyphBuffer:
	push af ; $73cb
	push bc ; $73cc
	push de ; $73cd
	push hl ; $73ce
	ld de, wGlyphTileBuffer ; $73cf
	ld b, $80 ; $73d2
.glyphLoop:
	ld hl, FontGlyphs ; $73d4
	ld c, 1 ; $73d7 -- 1 of FontGlyphs's 102 tiles
	call CopyMemoryFast ; $73d9
	dec b ; $73dc
	jr nz, .glyphLoop ; $73dd
	pop hl ; $73df
	pop de ; $73e0
	pop bc ; $73e1
	pop af ; $73e2
	ret ; $73e3
ClearWindowGlyphTiles:
	push af ; $73e4
	push bc ; $73e5
	push de ; $73e6
	push hl ; $73e7
	wram_bank WRAM_TEXT ; $73e8
	ld a, [wGlyphWindowId] ; $73ee
	farcall GetWindowStructPtr ; $73f1
	inc hl ; $73f4
	inc hl ; $73f5
	ld a, [hl+] ; $73f6
	dec a ; $73f7
	dec a ; $73f8
	ld b, [hl] ; $73f9
	dec b ; $73fa
	dec b ; $73fb
	sra b ; $73fc
	inc b ; $73fe
	ld l, b ; $73ff
	ld h, $00 ; $7400
	call MulHLByA ; $7402
	ld b, l ; $7405
	ld de, wWindowShadowTilemap + 24 * TILEMAP_WIDTH ; $7406
	ld a, [wGlyphRowStartCol] ; $7409
	ld l, a ; $740c
	ld h, $00 ; $740d
	add hl, hl ; $740f
	add hl, hl ; $7410
	add hl, hl ; $7411
	add hl, hl ; $7412
	add hl, de ; $7413
	ld d, h ; $7414
	ld e, l ; $7415
	wram_bank WRAM_SOUND ; $7416
.loop:
	ld hl, FontGlyphs ; $741c
	ld c, 1 ; $741f -- 1 of FontGlyphs's 102 tiles
	call CopyMemoryFast ; $7421
	dec b ; $7424
	jr nz, .loop ; $7425
	pop hl ; $7427
	pop de ; $7428
	pop bc ; $7429
	pop af ; $742a
	ret ; $742b
UploadGlyphBufferFull:
	push af ; $742c
	push bc ; $742d
	push de ; $742e
	push hl ; $742f
	ldh a, [hWramBank] ; $7430
	push af ; $7432
	set_flag FLAG_VRAM_UPDATE_BUSY ; $7433
	push af ; $7436
	ldh a, [rLCDC] ; $7437
	bit 7, a ; $7439
	jr z, .lcdSettled ; $743b
	call AdvanceFrame ; $743d
.lcdSettled:
	pop af ; $7440
	ld hl, vTiles1 + $40 * TILE_SIZE ; $7441
	wram_bank WRAM_TEXT ; $7444
	ld a, [wWindowTileAttr] ; $744a
	bit 3, a ; $744d
	jr z, .pushPageDests ; $744f
	ld hl, vTiles1 + $40 * TILE_SIZE + VRAM_BANK1 ; $7451
.pushPageDests:
	push hl ; $7454
	ld de, $ff00 ; $7455
	add hl, de ; $7458
	push hl ; $7459
	add hl, de ; $745a
	push hl ; $745b
	add hl, de ; $745c
	push hl ; $745d
	add hl, de ; $745e
	ld d, h ; $745f
	ld e, l ; $7460
	wram_bank WRAM_SOUND ; $7461
	ld hl, wGlyphTileBuffer ; $7467
	ld c, 16 ; $746a
	call QueueVRAMCopy ; $746c
	push af ; $746f
	ldh a, [rLCDC] ; $7470
	bit 7, a ; $7472
	jr z, .page2 ; $7474
	call AdvanceFrame ; $7476
.page2:
	pop af ; $7479
	ld hl, wGlyphTileBuffer + 16 * TILE_SIZE ; $747a
	pop de ; $747d
	ld c, 16 ; $747e
	call QueueVRAMCopy ; $7480
	push af ; $7483
	ldh a, [rLCDC] ; $7484
	bit 7, a ; $7486
	jr z, .page3 ; $7488
	call AdvanceFrame ; $748a
.page3:
	pop af ; $748d
	ld hl, wGlyphTileBuffer + 32 * TILE_SIZE ; $748e
	pop de ; $7491
	ld c, 16 ; $7492
	call QueueVRAMCopy ; $7494
	push af ; $7497
	ldh a, [rLCDC] ; $7498
	bit 7, a ; $749a
	jr z, .page4 ; $749c
	call AdvanceFrame ; $749e
.page4:
	pop af ; $74a1
	ld hl, wGlyphTileBuffer + 48 * TILE_SIZE ; $74a2
	pop de ; $74a5
	ld c, 16 ; $74a6
	call QueueVRAMCopy ; $74a8
	push af ; $74ab
	ldh a, [rLCDC] ; $74ac
	bit 7, a ; $74ae
	jr z, .page5 ; $74b0
	call AdvanceFrame ; $74b2
.page5:
	pop af ; $74b5
	ld c, $10 ; $74b6
	test_flag FLAG_DEBUG_SHORT_GLYPH_UPLOAD ; $74b8
	jr z, .uploadPage5 ; $74bb
	ld c, $07 ; $74bd
.uploadPage5:
	ld hl, wGlyphTileBuffer + 64 * TILE_SIZE ; $74bf
	pop de ; $74c2
	call QueueVRAMCopy ; $74c3
	push af ; $74c6
	ldh a, [rLCDC] ; $74c7
	bit 7, a ; $74c9
	jr z, .done ; $74cb
	call AdvanceFrame ; $74cd
.done:
	pop af ; $74d0
	clear_flag FLAG_VRAM_UPDATE_BUSY ; $74d1
	pop_wram_bank ; $74d4
	pop hl ; $74d9
	pop de ; $74da
	pop bc ; $74db
	pop af ; $74dc
	ret ; $74dd
Unused_05_DrawWindowGlyphRun:
	push af ; $74de
	push bc ; $74df
	push de ; $74e0
	push hl ; $74e1
	ldh a, [hWramBank] ; $74e2
	push af ; $74e4
	push hl ; $74e5
	wram_bank WRAM_TEXT ; $74e6
	ld a, [wGlyphWindowId] ; $74ec
	farcall GetWindowStructPtr ; $74ef
	inc hl ; $74f2
	inc hl ; $74f3
	ld b, [hl] ; $74f4
	dec b ; $74f5
	dec b ; $74f6
	ld c, b ; $74f7
	pop hl ; $74f8
	wram_bank WRAM_SOUND ; $74f9
	call ClearGlyphBuffer ; $74ff
	ld de, $0000 ; $7502
.glyphLoop:
	ld a, [hl+] ; $7505
	cp $02 ; $7506
	jr z, .done ; $7508
	cp $03 ; $750a
	jr z, .done ; $750c
	cp $01 ; $750e
	jr nz, .drawGlyph ; $7510
	ld e, $00 ; $7512
	ld d, c ; $7514
	sra d ; $7515
	rr e ; $7517
	ld a, c ; $7519
	add b ; $751a
	ld c, a ; $751b
	jr .glyphLoop ; $751c
.drawGlyph:
	call DrawGlyph ; $751e
	jr .glyphLoop ; $7521
.done:
	pop_wram_bank ; $7523
	pop hl ; $7528
	pop de ; $7529
	pop bc ; $752a
	pop af ; $752b
	ret ; $752c
InitGlyphStreamForWindow:
	push af ; $752d
	push bc ; $752e
	push de ; $752f
	push hl ; $7530
	push_wram_bank WRAM_TEXT ; $7531
	ld de, $0000 ; $753a
	ld a, [wGlyphWindowId] ; $753d
	or a ; $7540
	jr z, .zero ; $7541
	ld a, [wGlyphRowStartCol] ; $7543
	ld d, a ; $7546
	ld e, $00 ; $7547
	sra d ; $7549
	rr e ; $754b
.zero:
	ld hl, wGlyphPenX ; $754d
	ld [hl], e ; $7550
	inc hl ; $7551
	ld [hl], d ; $7552
	ld a, [wGlyphWindowId] ; $7553
	farcall GetWindowStructPtr ; $7556
	inc hl ; $7559
	inc hl ; $755a
	ld a, [hl] ; $755b
	dec a ; $755c
	dec a ; $755d
	ld d, a ; $755e
	ld e, a ; $755f
	ld a, [wGlyphWindowId] ; $7560
	or a ; $7563
	jr z, .zero2 ; $7564
	ld a, [wGlyphRowStartCol] ; $7566
	add e ; $7569
	ld e, a ; $756a
.zero2:
	ld hl, wTextRowWidth ; $756b
	ld [hl], d ; $756e
	inc hl ; $756f
	ld [hl], e ; $7570
	call ClearWindowGlyphTiles ; $7571
	pop_wram_bank ; $7574
	pop hl ; $7579
	pop de ; $757a
	pop bc ; $757b
	pop af ; $757c
	ret ; $757d
DrawStreamGlyph:
	push af ; $757e
	push bc ; $757f
	push de ; $7580
	push hl ; $7581
	push_wram_bank WRAM_TEXT ; $7582
	ld hl, wTextRowWidth ; $758b
	ld b, [hl] ; $758e
	inc hl ; $758f
	ld c, [hl] ; $7590
	ld hl, wGlyphPenX ; $7591
	ld a, [hl+] ; $7594
	ld d, [hl] ; $7595
	ld e, a ; $7596
	ld hl, wTextStreamPtr ; $7597
	ld a, [hl+] ; $759a
	ld h, [hl] ; $759b
	ld l, a ; $759c
	ld a, [hl+] ; $759d
	cp $02 ; $759e
	jr z, .step2 ; $75a0
	cp $03 ; $75a2
	jr z, .step2 ; $75a4
	cp $01 ; $75a6
	jr nz, .ne01 ; $75a8
	ld e, $00 ; $75aa
	ld d, c ; $75ac
	sra d ; $75ad
	rr e ; $75af
	ld a, c ; $75b1
	add b ; $75b2
	ld [wTextRowColumn], a ; $75b3
	jr .step2 ; $75b6
.ne01:
	push af ; $75b8
	wram_bank WRAM_SOUND ; $75b9
	pop af ; $75bf
	call DrawGlyph ; $75c0
.step2:
	ld hl, wGlyphPenX ; $75c3
	ld a, e ; $75c6
	ld [hl+], a ; $75c7
	ld [hl], d ; $75c8
	sla e ; $75c9
	rl d ; $75cb
	ld a, d ; $75cd
	ld [wGlyphRowStartCol], a ; $75ce
	pop_wram_bank ; $75d1
	pop hl ; $75d6
	pop de ; $75d7
	pop bc ; $75d8
	pop af ; $75d9
	ret ; $75da
StartGlyphStreamRow:
	push af ; $75db
	push bc ; $75dc
	push de ; $75dd
	push hl ; $75de
	ld hl, wTextRowWidth ; $75df
	ld b, [hl] ; $75e2
	inc hl ; $75e3
	ld c, [hl] ; $75e4
	ld e, $00 ; $75e5
	ld d, c ; $75e7
	sra d ; $75e8
	rr e ; $75ea
	ld a, c ; $75ec
	add b ; $75ed
	ld [wTextRowColumn], a ; $75ee
	ld hl, wGlyphPenX ; $75f1
	ld a, e ; $75f4
	ld [hl+], a ; $75f5
	ld [hl], d ; $75f6
	sla e ; $75f7
	rl d ; $75f9
	ld a, d ; $75fb
	ld [wGlyphRowStartCol], a ; $75fc
	ld [wGlyphFlushedCol], a ; $75ff
	pop hl ; $7602
	pop de ; $7603
	pop bc ; $7604
	pop af ; $7605
	ret ; $7606
UploadLastGlyphTiles:
	push af ; $7607
	push bc ; $7608
	push de ; $7609
	push hl ; $760a
	ld a, [wGlyphWindowId] ; $760b
	ld b, a ; $760e
	ld a, [wWindowId] ; $760f
	cp b ; $7612
	jr nz, .restore ; $7613
	ld b, a ; $7615
	ld a, [wDialogueWindowId] ; $7616
	cp b ; $7619
	jr z, .checkMessageSpeed ; $761a
	pop hl ; $761c
	pop de ; $761d
	pop bc ; $761e
	pop af ; $761f
	ret ; $7620
.checkMessageSpeed:
	ld a, [wMessageSpeed] ; $7621
	bit 7, a ; $7624
	jr nz, .restore ; $7626
	and $7f ; $7628
	jr nz, .maskSet ; $762a
.restore:
	pop hl ; $762c
	pop de ; $762d
	pop bc ; $762e
	pop af ; $762f
	ret ; $7630
.maskSet:
	push_wram_bank WRAM_SOUND ; $7631
	ld a, [wKeepMatchStatsFlag] ; $763a
	or a ; $763d
	jr z, .zero ; $763e
	ld b, $5f ; $7640
	jr .step3 ; $7642
.zero:
	ld b, $7f ; $7644
.step3:
	ld a, [wGlyphRowStartCol] ; $7646
	cp b ; $7649
	jr nc, .restore2 ; $764a
	ld hl, wGlyphPenX ; $764c
	ld a, [hl+] ; $764f
	ld h, [hl] ; $7650
	ld l, a ; $7651
	rl l ; $7652
	ld l, h ; $7654
	rl l ; $7655
	ld h, $00 ; $7657
	rl h ; $7659
	ld a, h ; $765b
	or l ; $765c
	jr z, .offset ; $765d
	dec hl ; $765f
.offset:
	add hl, hl ; $7660
	add hl, hl ; $7661
	add hl, hl ; $7662
	add hl, hl ; $7663
	ld d, h ; $7664
	ld e, l ; $7665
	ld bc, wGlyphTileBuffer ; $7666
	add hl, bc ; $7669
	push hl ; $766a
	ld hl, vTiles1 ; $766b
	add hl, de ; $766e
	ld d, h ; $766f
	ld e, l ; $7670
	pop hl ; $7671
	ld c, 2 ; $7672
	call QueueVRAMCopy ; $7674
.restore2:
	pop_wram_bank ; $7677
	pop hl ; $767c
	pop de ; $767d
	pop bc ; $767e
	pop af ; $767f
	ret ; $7680
