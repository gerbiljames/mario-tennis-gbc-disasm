RestoreShadowTilemap:
	push af ; $436f
	push bc ; $4370
	push de ; $4371
	push hl ; $4372
	ldh a, [hWramBank] ; $4373
	push af ; $4375
	call RestoreAllShadowTilemapRows ; $4376
	pop_wram_bank ; $4379
	pop hl ; $437e
	pop de ; $437f
	pop bc ; $4380
	pop af ; $4381
	ret ; $4382
RestoreAllShadowTilemapRows:
	ld a, [wCameraY + 1] ; $4383
	and $3f ; $4386
	ld c, $04 ; $4388
.loop:
	ld b, $05 ; $438a
.loopB:
	push af ; $438c
	push bc ; $438d
	call RestoreShadowTilemapRow ; $438e
	pop bc ; $4391
	pop af ; $4392
	inc a ; $4393
	and $3f ; $4394
	dec b ; $4396
	jr nz, .loopB ; $4397
	push af ; $4399
	ldh a, [rLCDC] ; $439a
	bit 7, a ; $439c
	jr z, .restore ; $439e
	call AdvanceFrame ; $43a0
.restore:
	pop af ; $43a3
	dec c ; $43a4
	jr nz, .loop ; $43a5
	ret ; $43a7
RestoreTilemapUnderWindow:
	push af ; $43a8
	push bc ; $43a9
	push de ; $43aa
	push hl ; $43ab
	call GetWindowStructPtr ; $43ac
	inc hl ; $43af
	ld b, [hl] ; $43b0
	inc hl ; $43b1
	inc hl ; $43b2
	ld c, [hl] ; $43b3
	ld a, [wCameraY + 1] ; $43b4
	cp b ; $43b7
	jr c, .gotRow ; $43b8
	jr z, .gotRow ; $43ba
	ld a, $20 ; $43bc
	add b ; $43be
	ld b, a ; $43bf
.gotRow:
	ld a, b ; $43c0
.rowLoop:
	push af ; $43c1
	push bc ; $43c2
	ld a, b ; $43c3
	call RestoreShadowTilemapRow ; $43c4
	pop bc ; $43c7
	pop af ; $43c8
	inc b ; $43c9
	dec c ; $43ca
	jr nz, .rowLoop ; $43cb
	pop hl ; $43cd
	pop de ; $43ce
	pop bc ; $43cf
	pop af ; $43d0
	ret ; $43d1
RestoreShadowTilemapRow:
	and $3f ; $43d2
	ld e, a ; $43d4
	ld hl, wMapBuffer64 ; $43d5
	ld a, $06 ; $43d8
	ld bc, $0040 ; $43da
	ld d, e ; $43dd
.loop:
	rr d ; $43de
	jr nc, .noCarry ; $43e0
	add hl, bc ; $43e2
.noCarry:
	sla c ; $43e3
	rl b ; $43e5
	dec a ; $43e7
	jr nz, .loop ; $43e8
	ld a, [wCameraX + 1] ; $43ea
	and $3f ; $43ed
	ld d, a ; $43ef
	ld c, d ; $43f0
	ld b, $00 ; $43f1
	add hl, bc ; $43f3
	ld b, h ; $43f4
	ld c, l ; $43f5
	push bc ; $43f6
	wram_bank WRAM_SCREEN ; $43f7
	ld hl, wTilemapRowStage ; $43fd
	ld a, c ; $4400
	and $1f ; $4401
	add l ; $4403
	ld l, a ; $4404
	jr nc, .gotPtr ; $4405
	inc h ; $4407
.gotPtr:
	ld d, $20 ; $4408
.loopB:
	ld a, [bc] ; $440a
	ld [hl+], a ; $440b
	inc bc ; $440c
	ld a, c ; $440d
	and $1f ; $440e
	jr nz, .next ; $4410
	ld hl, wTilemapRowStage ; $4412
	ld a, c ; $4415
	and $3f ; $4416
	jr nz, .next ; $4418
	dec bc ; $441a
	ld a, c ; $441b
	and $c0 ; $441c
	ld c, a ; $441e
.next:
	dec d ; $441f
	jr nz, .loopB ; $4420
	ld hl, wWindowShadowTilemap ; $4422
	ld a, e ; $4425
	and $1f ; $4426
	ld d, a ; $4428
	ld a, $05 ; $4429
	ld bc, $0020 ; $442b
.loop2:
	rr d ; $442e
	jr nc, .noCarry2 ; $4430
	add hl, bc ; $4432
.noCarry2:
	sla c ; $4433
	rl b ; $4435
	dec a ; $4437
	jr nz, .loop2 ; $4438
	push de ; $443a
	ld d, h ; $443b
	ld e, l ; $443c
	ld hl, wTilemapRowStage ; $443d
	wram_bank WRAM_TEXT ; $4440
	ld bc, $0002 ; $4446
	call CopyMemoryFast ; $4449
	pop de ; $444c
	pop bc ; $444d
	ld hl, wTilemapRowStage ; $444e
	wram_bank WRAM_COURT_PLANES ; $4451
	ld a, c ; $4457
	and $1f ; $4458
	add l ; $445a
	ld l, a ; $445b
	jr nc, .gotPtr2 ; $445c
	inc h ; $445e
.gotPtr2:
	ld d, $20 ; $445f
.loop3:
	ld a, [bc] ; $4461
	ld [hl+], a ; $4462
	inc bc ; $4463
	ld a, c ; $4464
	and $1f ; $4465
	jr nz, .next2 ; $4467
	ld hl, wTilemapRowStage ; $4469
	ld a, c ; $446c
	and $3f ; $446d
	jr nz, .next2 ; $446f
	dec bc ; $4471
	ld a, c ; $4472
	and $c0 ; $4473
	ld c, a ; $4475
.next2:
	dec d ; $4476
	jr nz, .loop3 ; $4477
	ld hl, wWindowShadowAttrmap ; $4479
	ld a, e ; $447c
	and $1f ; $447d
	ld d, a ; $447f
	ld a, $05 ; $4480
	ld bc, $0020 ; $4482
.loop4:
	rr d ; $4485
	jr nc, .noCarry3 ; $4487
	add hl, bc ; $4489
.noCarry3:
	sla c ; $448a
	rl b ; $448c
	dec a ; $448e
	jr nz, .loop4 ; $448f
	ld d, h ; $4491
	ld e, l ; $4492
	ld hl, wTilemapRowStage ; $4493
	wram_bank WRAM_TEXT ; $4496
	ld bc, $0002 ; $449c
	call CopyMemoryFast ; $449f
	ret ; $44a2
RefreshShadowTilemapFromMapBuffer:
	push af ; $44a3
	push bc ; $44a4
	push de ; $44a5
	push hl ; $44a6
	push_wram_bank WRAM_TEXT ; $44a7
	ld a, [wShadowTilemapBank] ; $44b0
	push af ; $44b3
	ld hl, wShadowTilemapPtr ; $44b4
	ld a, [hl+] ; $44b7
	ld d, [hl] ; $44b8
	ld e, a ; $44b9
	ld hl, wShadowTilemapReadOffset ; $44ba
	ld a, [hl+] ; $44bd
	ld b, [hl] ; $44be
	ld c, a ; $44bf
	pop af ; $44c0
	ld a, a ; $44c1
	wram_bank ; $44c2
	ldh a, [hScrollY] ; $44c6
	and $f8 ; $44c8
	ld l, a ; $44ca
	ld h, $00 ; $44cb
	add hl, hl ; $44cd
	add hl, hl ; $44ce
	push hl ; $44cf
	add hl, de ; $44d0
	ld d, h ; $44d1
	ld e, l ; $44d2
	pop hl ; $44d3
	add hl, bc ; $44d4
	ld b, $15 ; $44d5
.loop:
	ld c, $02 ; $44d7
	call CopyMemoryFast ; $44d9
	ld a, h ; $44dc
	cp $e0 ; $44dd
	jr nc, .restore ; $44df
	ld a, d ; $44e1
	cp $e0 ; $44e2
	jr nc, .restore ; $44e4
	dec b ; $44e6
	jr nz, .loop ; $44e7
.restore:
	pop_wram_bank ; $44e9
	pop hl ; $44ee
	pop de ; $44ef
	pop bc ; $44f0
	pop af ; $44f1
	ret ; $44f2
Unused_05_GetCameraTileRow:
	ld a, [wCameraY + 1] ; $44f3
	and $3f ; $44f6
	ret ; $44f8
SetFixedMenuWindowTextId:
	push bc ; $44f9
	push de ; $44fa
	push hl ; $44fb
	ldh a, [hWramBank] ; $44fc
	push af ; $44fe
	ld b, a ; $44ff
	call SetWindowTextId ; $4500
	pop_wram_bank ; $4503
	ld a, b ; $4508
	ld [wFixedMenuWindowId], a ; $4509
	pop hl ; $450c
	pop de ; $450d
	pop bc ; $450e
	ret ; $450f
RunFixedTextMenu:
	push hl ; $4510
	ldh a, [hWramBank] ; $4511
	push af ; $4513
	ld hl, Text_30_26 ; $4514
	call CreateMenuWindowFromText ; $4517
	call RestoreShadowTilemap ; $451a
	call StubNop_05_0 ; $451d
	call RunMenuSelection ; $4520
	ld h, a ; $4523
	ld a, [wMenuWindowId] ; $4524
	call CloseWindow ; $4527
	ld a, [wFixedMenuWindowId] ; $452a
	call CloseWindow ; $452d
	pop_wram_bank ; $4530
	ld a, h ; $4535
	pop hl ; $4536
	ret ; $4537
SetWindowRect:
	push hl ; $4538
	ld a, d ; $4539
	and $1f ; $453a
	ld [hl+], a ; $453c
	ld a, e ; $453d
	and $1f ; $453e
	ld [hl+], a ; $4540
	ld [hl], b ; $4541
	inc hl ; $4542
	ld [hl], c ; $4543
	pop hl ; $4544
	ret ; $4545
DrawTextWindowFrameSaveRegs:
	push af ; $4546
	push bc ; $4547
	push de ; $4548
	push hl ; $4549
	call DrawTextWindowFrame ; $454a
	pop hl ; $454d
	pop de ; $454e
	pop bc ; $454f
	pop af ; $4550
	ret ; $4551
DrawTileAttrRect:
	push af ; $4552
	push bc ; $4553
	push de ; $4554
	push hl ; $4555
	ld a, [hl+] ; $4556
	ld d, [hl] ; $4557
	inc hl ; $4558
	ld e, [hl] ; $4559
	inc hl ; $455a
	ld b, [hl] ; $455b
	inc hl ; $455c
	ld c, [hl] ; $455d
	inc hl ; $455e
	push af ; $455f
.loop:
	push de ; $4560
	push bc ; $4561
	call GetTilemapCellAddress ; $4562
.loopB:
	ld a, [hl] ; $4565
	inc hl ; $4566
	ld [de], a ; $4567
	ld a, [hl] ; $4568
	inc hl ; $4569
	push hl ; $456a
	ld hl, $0400 ; $456b
	add hl, de ; $456e
	ld [hl], a ; $456f
	ld a, e ; $4570
	and $1f ; $4571
	cp $1f ; $4573
	jr nz, .ne1f ; $4575
	ld hl, $ffe0 ; $4577
	add hl, de ; $457a
	ld d, h ; $457b
	ld e, l ; $457c
.ne1f:
	inc de ; $457d
	pop hl ; $457e
	dec b ; $457f
	jr nz, .loopB ; $4580
	ld a, c ; $4582
	pop bc ; $4583
	ld c, a ; $4584
	pop de ; $4585
	inc e ; $4586
	dec c ; $4587
	jr nz, .loop ; $4588
	pop af ; $458a
	pop hl ; $458b
	pop de ; $458c
	pop bc ; $458d
	pop af ; $458e
	ret ; $458f
Unused_05_ClearShadowMapRect:
	push af ; $4590
	push bc ; $4591
	push de ; $4592
	ld a, [hl+] ; $4593
	ld d, [hl] ; $4594
	inc hl ; $4595
	ld e, [hl] ; $4596
	inc hl ; $4597
	ld b, [hl] ; $4598
	inc hl ; $4599
	ld c, [hl] ; $459a
	inc hl ; $459b
.loop2:
	push de ; $459c
	push bc ; $459d
.loop3:
	ld a, $00 ; $459e
	push de ; $45a0
	call GetTilemapCellAddress ; $45a1
	ld [de], a ; $45a4
	pop de ; $45a5
	dec b ; $45a6
	jr z, .countDone ; $45a7
	inc d ; $45a9
	jr .loop3 ; $45aa
.countDone:
	ld a, c ; $45ac
	pop bc ; $45ad
	ld c, a ; $45ae
	ld a, e ; $45af
	pop de ; $45b0
	ld e, a ; $45b1
	inc e ; $45b2
	dec c ; $45b3
	jr nz, .loop2 ; $45b4
	pop de ; $45b6
	pop bc ; $45b7
	pop af ; $45b8
	ret ; $45b9
Unused_05_CloseMenuWindow:
	push hl ; $45ba
	push bc ; $45bb
	push de ; $45bc
	push af ; $45bd
	ld b, a ; $45be
	call FreeWindow ; $45bf
	cp $ff ; $45c2
	jr z, .restore ; $45c4
	ld a, b ; $45c6
	call FreeWindow ; $45c7
	ld a, $04 ; $45ca
	add l ; $45cc
	ld l, a ; $45cd
	jr nc, .gotPtr ; $45ce
	inc h ; $45d0
.gotPtr:
	ld d, h ; $45d1
	ld e, l ; $45d2
	ld a, [wGlyphBufferHoldCount] ; $45d3
	dec a ; $45d6
	ld [wGlyphBufferHoldCount], a ; $45d7
	ld a, [de] ; $45da
	and $02 ; $45db
	jr z, .restore ; $45dd
	ld a, [wMenuDepth] ; $45df
	or a ; $45e2
	jr z, .zero ; $45e3
	dec a ; $45e5
	ld hl, wMenuStack ; $45e6
	sla a ; $45e9
	ld c, a ; $45eb
	ld b, $00 ; $45ec
	add hl, bc ; $45ee
	ld a, [hl] ; $45ef
	and $0f ; $45f0
	ld [wMenuCursorRow], a ; $45f2
.zero:
	ld a, [wMenuDepth] ; $45f5
	dec a ; $45f8
	ld [wMenuDepth], a ; $45f9
	cp $ff ; $45fc
	jr z, .restore ; $45fe
	ld a, [wMenuDepth] ; $4600
	ld hl, wMenuStack ; $4603
	sla a ; $4606
	ld c, a ; $4608
	ld b, $00 ; $4609
	add hl, bc ; $460b
	ld a, [hl] ; $460c
	sra a ; $460d
	sra a ; $460f
	sra a ; $4611
	sra a ; $4613
	and $0f ; $4615
	ld [wMenuRowCount], a ; $4617
	inc hl ; $461a
	ld a, [hl] ; $461b
	and $0f ; $461c
	ld [wMenuWindowId], a ; $461e
.restore:
	pop af ; $4621
	pop de ; $4622
	pop bc ; $4623
	pop hl ; $4624
	ret ; $4625
