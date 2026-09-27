Padding_18:
	; $4096, 10 bytes (fill)
	ds 10, $00
	ds ALIGN[4]
FontTiles:
	INCBIN "data/bank_018/FontTiles.bin" ; $40a0, 512 bytes
	ds ALIGN[4]
MenuHandCursorGfx:
	INCBIN "data/bank_018/MenuHandCursorGfx.bin" ; $42a0, 64 bytes
MenuHandCursorPalette:
	INCLUDE "data/bank_018/MenuHandCursorPalette.asm" ; $42e0, 32 bytes (palettes)
AllIndexedPalettes_18:
	INCLUDE "data/bank_018/AllIndexedPalettes_18.asm" ; $4300, 40 bytes (palettes)
LoadAllIndexedPalettes_18:
	push af ; $4328
	push bc ; $4329
	push de ; $432a
	push hl ; $432b
	ld hl, AllIndexedPalettes_18 ; $432c
	ld e, $05 ; $432f
	call LoadPaletteShadow ; $4331
	pop hl ; $4334
	pop de ; $4335
	pop bc ; $4336
	pop af ; $4337
	ret ; $4338
LoadIndexedPalette_18:
	push af ; $4339
	push bc ; $433a
	push de ; $433b
	push hl ; $433c
	and $0f ; $433d
	add a ; $433f
	add a ; $4340
	add a ; $4341
	ld_hl_indexed AllIndexedPalettes_18 ; $4342
	ld e, $01 ; $4349
	call LoadPaletteShadow ; $434b
	pop hl ; $434e
	pop de ; $434f
	pop bc ; $4350
	pop af ; $4351
	ret ; $4352
FlushBgMapShadowToVram:
	ld a, [wBgMapShadowDirty] ; $4353
	and $0f ; $4356
	jr z, .attrPlane ; $4358
	ld hl, wTextTileBuffer ; $435a
	ld de, vBGMap0 ; $435d
	ld c, $24 ; $4360
	call QueueVRAMCopy ; $4362
.attrPlane:
	ld a, [wBgMapShadowDirty] ; $4365
	and $f0 ; $4368
	jr z, .done ; $436a
	ld hl, wTextTileBuffer + 64 * TILE_SIZE ; $436c
	ld de, vBGMap0 + VRAM_BANK1 ; $436f
	ld c, $24 ; $4372
	call QueueVRAMCopy ; $4374
.done:
	xor a ; $4377
	ld [wBgMapShadowDirty], a ; $4378
	ret ; $437b
LoadMenuHandCursorGfx:
	push hl ; $437c
	ld hl, MenuHandCursorPalette ; $437d
	call LoadPaletteShadow ; $4380
	pop de ; $4383
	ld hl, MenuHandCursorGfx ; $4384
	ld c, (MenuHandCursorPalette - MenuHandCursorGfx) / 16 ; $4387
	call QueueVRAMCopy ; $4389
	ret ; $438c
; Copies FontTiles to $9000, 16 blocks. The leading `ret` means it never does:
; the one caller gets a no-op, and whatever put the font there has already
; done so by the time this is reached.
LoadFontTiles:
	ret ; $438d
	ld hl, FontTiles ; $438e
	ld de, vTiles2 ; $4391
	ld c, $10 ; $4394 -- 16 of FontTiles's 32 tiles
	call QueueVRAMCopy ; $4396
	ret ; $4399
RenderProportionalTextAt32:
	push bc ; $439a
	ld c, $20 ; $439b
	farcall RenderProportionalTextAt ; $439d
	pop bc ; $43a0
	ret ; $43a1
DrawStringToTilemap:
	farcall WriteStringToTilemap ; $43a2
	ret ; $43a5
WriteTilemapByteAdvance:
	ld [de], a ; $43a6
	inc de ; $43a7
	ret ; $43a8
DrawDecimalNumberToTilemap:
	push af ; $43a9
	push bc ; $43aa
	push hl ; $43ab
	add sp, -10 ; $43ac
	push de ; $43ae
	ld c, l ; $43af
	ld b, h ; $43b0
	ld hl, sp + 2 ; $43b1
	ld e, l ; $43b3
	ld d, h ; $43b4
	ld l, c ; $43b5
	ld h, b ; $43b6
	ld c, e ; $43b7
	ld b, d ; $43b8
	call FormatDecimalNumber ; $43b9
	ld l, c ; $43bc
	ld h, b ; $43bd
	pop de ; $43be
	call DrawStringToTilemap ; $43bf
	add sp, 10 ; $43c2
	pop hl ; $43c4
	pop bc ; $43c5
	pop af ; $43c6
	ret ; $43c7
DrawBox:
	push af ; $43c8
	push bc ; $43c9
	push de ; $43ca
	push hl ; $43cb
	push bc ; $43cc
	push de ; $43cd
	push hl ; $43ce
.rowLoop:
	push bc ; $43cf
	push de ; $43d0
	push hl ; $43d1
.cellLoop:
	ld a, $20 ; $43d2
	ld [hl+], a ; $43d4
	ld a, $00 ; $43d5
	ld [de], a ; $43d7
	inc de ; $43d8
	dec b ; $43d9
	jr nz, .cellLoop ; $43da
	pop hl ; $43dc
	pop de ; $43dd
	pop bc ; $43de
	ld a, $20 ; $43df
	add l ; $43e1
	ld l, a ; $43e2
	jr nc, .nextRowAttr ; $43e3
	inc h ; $43e5
.nextRowAttr:
	ld a, $20 ; $43e6
	add e ; $43e8
	ld e, a ; $43e9
	jr nc, .nextRow ; $43ea
	inc d ; $43ec
.nextRow:
	dec c ; $43ed
	jr nz, .rowLoop ; $43ee
	pop hl ; $43f0
	pop de ; $43f1
	pop bc ; $43f2
	call DrawBoxTopRow ; $43f3
	ld a, $20 ; $43f6
	add l ; $43f8
	ld l, a ; $43f9
	jr nc, .topRowDone ; $43fa
	inc h ; $43fc
.topRowDone:
	dec c ; $43fd
	dec c ; $43fe
.bottomRow:
	call DrawBoxSideRow ; $43ff
	ld a, $20 ; $4402
	add l ; $4404
	ld l, a ; $4405
	jr nc, .done ; $4406
	inc h ; $4408
.done:
	dec c ; $4409
	jr nz, .bottomRow ; $440a
	call DrawBoxBottomRow ; $440c
	pop hl ; $440f
	pop de ; $4410
	pop bc ; $4411
	pop af ; $4412
	ret ; $4413
DrawBoxTopRow:
	push bc ; $4414
	push hl ; $4415
	ld a, $02 ; $4416
	ld [hl+], a ; $4418
	dec b ; $4419
	dec b ; $441a
.fillLoop:
	ld a, $03 ; $441b
	ld [hl+], a ; $441d
	dec b ; $441e
	jr nz, .fillLoop ; $441f
	ld a, $04 ; $4421
	ld [hl+], a ; $4423
	pop hl ; $4424
	pop bc ; $4425
	ret ; $4426
DrawBoxSideRow:
	push hl ; $4427
	ld [hl], $05 ; $4428
	ld a, b ; $442a
	dec a ; $442b
	add l ; $442c
	ld l, a ; $442d
	jr nc, .read ; $442e
	inc h ; $4430
.read:
	ld [hl], $06 ; $4431
	pop hl ; $4433
	ret ; $4434
DrawBoxBottomRow:
	ld a, $07 ; $4435
	ld [hl+], a ; $4437
	dec b ; $4438
	dec b ; $4439
.fillLoop:
	ld a, $08 ; $443a
	ld [hl+], a ; $443c
	dec b ; $443d
	jr nz, .fillLoop ; $443e
	ld a, $09 ; $4440
	ld [hl+], a ; $4442
	ret ; $4443
AddBobbingOffsetXY:
	push af ; $4444
	push hl ; $4445
	ldh a, [hVBlankCounter] ; $4446
	and $0f ; $4448
	ld_hl_indexed AddBobbingOffsetXYTable ; $444a
	ld a, [hl] ; $4451
	add d ; $4452
	ld d, a ; $4453
	ldh a, [hVBlankCounter] ; $4454
	add $04 ; $4456
	and $0f ; $4458
	ld_hl_indexed AddBobbingOffsetXYTable ; $445a
	ld a, [hl] ; $4461
	cpl ; $4462
	add e ; $4463
	ld e, a ; $4464
	pop af ; $4465
	pop hl ; $4466
	ret ; $4467
AddBobbingOffsetXYTable:
	; $4468, 16 bytes (bytes:16)
	db $00, $01, $01, $01, $02, $02, $03, $04, $03, $02, $02, $01, $01, $01, $00, $00 ; 0x00
AddBobbingOffsetY:
	push af ; $4478
	push hl ; $4479
	ldh a, [hVBlankCounter] ; $447a
	and $0f ; $447c
	ld_hl_indexed AddBobbingOffsetYTable ; $447e
	ld a, [hl] ; $4485
	add e ; $4486
	ld e, a ; $4487
	pop af ; $4488
	pop hl ; $4489
	ret ; $448a
AddBobbingOffsetYTable:
	; $448b, 16 bytes (bytes:16)
	db $00, $01, $01, $02, $03, $04, $06, $08, $06, $04, $03, $02, $01, $01, $00, $00 ; 0x00
AddBobbingOffsetYLarge:
	push af ; $449b
	push hl ; $449c
	ldh a, [hVBlankCounter] ; $449d
	and $3f ; $449f
	ld_hl_indexed AddBobbingOffsetYLargeTable ; $44a1
	ld a, [hl] ; $44a8
	add e ; $44a9
	ld e, a ; $44aa
	pop af ; $44ab
	pop hl ; $44ac
	ret ; $44ad
AddBobbingOffsetYLargeTable:
	; $44ae, 64 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $02, $02, $02, $03, $03, $03, $03, $03, $03, $03 ; 0x00
	db $03, $03, $03, $03, $03, $03, $03, $03, $02, $02, $02, $01, $01, $01, $00, $00 ; 0x10
	db $00, $00, $00, $ff, $ff, $ff, $fe, $fe, $fe, $fd, $fd, $fd, $fd, $fd, $fd, $fd ; 0x20
	db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fe, $fe, $fe, $ff, $ff, $ff, $00, $00 ; 0x30
StubNop_18:
	ret ; $44ee
FindRosterEntry:
	push af ; $44ef
	push bc ; $44f0
	ld b, a ; $44f1
.searchLoop:
	ld a, [hl] ; $44f2
	cp b ; $44f3
	jr z, .found ; $44f4
	cp $ff ; $44f6
	jr z, .found ; $44f8
	ld a, $08 ; $44fa
	add l ; $44fc
	ld l, a ; $44fd
	jr nc, .next ; $44fe
	inc h ; $4500
.next:
	jr .searchLoop ; $4501
.found:
	add hl, de ; $4503
	pop bc ; $4504
	pop af ; $4505
	ret ; $4506
LoadCharacterRecordToBuffer:
	cp $84 ; $4507
	jr z, .fixedRecord ; $4509
	push af ; $450b
	push bc ; $450c
	push de ; $450d
	push hl ; $450e
	farcall LoadCharacterRecordToCa80 ; $450f
	ld hl, wPlayer2MainName ; $4512
	ld de, wCharRecordScratch ; $4515
	ld c, $08 ; $4518
	call CopyMemoryFast ; $451a
	pop hl ; $451d
	pop de ; $451e
	pop bc ; $451f
	pop af ; $4520
	ret ; $4521
.fixedRecord:
	push af ; $4522
	ld a, $3e ; $4523
	ld [wCharRecordScratch + 11], a ; $4525
	pop af ; $4528
	ret ; $4529
CheckCharacterUnlocked:
	bit 7, a ; $452a
	jr z, .checkRange ; $452c
	ld a, [wCharRecordScratch + 11] ; $452e
	cp $ff ; $4531
	ret ; $4533
.checkRange:
	cp $04 ; $4534
	jr nc, .lookup ; $4536
	cp $ff ; $4538
	ret ; $453a
.lookup:
	push hl ; $453b
	push de ; $453c
	ld h, $00 ; $453d
	ld l, a ; $453f
	add hl, hl ; $4540
	add hl, hl ; $4541
	add hl, hl ; $4542
	add hl, hl ; $4543
	add hl, hl ; $4544
	ld d, h ; $4545
	ld e, l ; $4546
	farcall TestSaveFlag ; $4547
	pop de ; $454a
	pop hl ; $454b
	ret ; $454c
UnusedCheckCharacterIdUnlocked:
	cp $10 ; $454d
	jr nc, .done ; $454f
	ld a, $01 ; $4551
	and a ; $4553
	ret ; $4554
.done:
	xor a ; $4555
	ret ; $4556
CheckUnlockFlag:
	bit 7, a ; $4557
	jr z, TestUnlockFlagById ; $4559
	cp $84 ; $455b
	jr nz, .locked ; $455d
	cp $ff ; $455f
	ret ; $4561
.locked:
	xor a ; $4562
	ret ; $4563
TestUnlockFlagById:
	push hl ; $4564
	push de ; $4565
	ld hl, UnlockFlagIds_18 ; $4566
	add a ; $4569
	add l ; $456a
	ld l, a ; $456b
	jr nc, .readFlagId ; $456c
	inc h ; $456e
.readFlagId:
	ld a, [hl+] ; $456f
	ld d, [hl] ; $4570
	ld e, a ; $4571
	or d ; $4572
	jr nz, .gameFlag ; $4573
	cp $ff ; $4575
	jr .done ; $4577
.gameFlag:
	bit 0, e ; $4579
	jr nz, .saveFlag ; $457b
	call TestGameFlag ; $457d
	jr .done ; $4580
.saveFlag:
	res 0, e ; $4582
	farcall TestSaveFlag ; $4584
.done:
	pop de ; $4587
	pop hl ; $4588
	ret ; $4589
UnlockFlagIds_18:
	; $458a, 64 bytes (bytes:16)
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x10
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x20
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x30
MoveGridCursor:
	bit 5, b ; $45ca
	jr z, .checkRight ; $45cc
	dec d ; $45ce
	jr .wrapX ; $45cf
.checkRight:
	bit 4, b ; $45d1
	jr z, .checkUp ; $45d3
	inc d ; $45d5
	jr .wrapX ; $45d6
.checkUp:
	bit 6, b ; $45d8
	jr z, .checkDown ; $45da
	dec e ; $45dc
	jr .wrapX ; $45dd
.checkDown:
	bit 7, b ; $45df
	jr z, .wrapX ; $45e1
	inc e ; $45e3
.wrapX:
	ld a, d ; $45e4
	add a ; $45e5
	jr nc, .checkMaxX ; $45e6
	ld a, $08 ; $45e8
	dec a ; $45ea
	jr .wrapY ; $45eb
.checkMaxX:
	rra ; $45ed
	cp $08 ; $45ee
	jr c, .wrapY ; $45f0
	xor a ; $45f2
.wrapY:
	ld d, a ; $45f3
	ld a, e ; $45f4
	add a ; $45f5
	jr nc, .checkMaxY ; $45f6
	ld a, $04 ; $45f8
	dec a ; $45fa
	jr .readCell ; $45fb
.checkMaxY:
	rra ; $45fd
	cp $04 ; $45fe
	jr c, .readCell ; $4600
	xor a ; $4602
.readCell:
	ld e, a ; $4603
	ld a, e ; $4604
	add a ; $4605
	add a ; $4606
	add a ; $4607
	add d ; $4608
	push hl ; $4609
	add l ; $460a
	ld l, a ; $460b
	jr nc, .haveCell ; $460c
	inc h ; $460e
.haveCell:
	ld a, [hl] ; $460f
	pop hl ; $4610
	cp $ff ; $4611
	jr z, MoveGridCursor ; $4613
	cp $fe ; $4615
	jr nz, .occupied ; $4617
	inc d ; $4619
	inc e ; $461a
	jr MoveGridCursor ; $461b
.occupied:
	cp $fd ; $461d
	jr nz, .store ; $461f
	dec d ; $4621
	dec e ; $4622
	jr MoveGridCursor ; $4623
.store:
	cp $fc ; $4625
	jr nz, .retry ; $4627
	dec d ; $4629
	jr MoveGridCursor ; $462a
.retry:
	cp $fb ; $462c
	jr nz, .done ; $462e
	ld a, b ; $4630
	and $20 ; $4631
	bit 5, a ; $4633
	jr nz, .done ; $4635
	inc d ; $4637
	jr MoveGridCursor ; $4638
.done:
	ret ; $463a
