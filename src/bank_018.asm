SECTION "ROM Bank $18", ROMX[$4000], BANK[$18]

	farptr LoadAllIndexedPalettes_18 ; $4000
	farptr LoadIndexedPalette_18 ; $4002
	farptr RenderProportionalTextAt32 ; $4004
	farptr LoadMenuHandCursorGfx ; $4006
	farptr StubLoadFontTiles ; $4008
	farptr DrawBox ; $400a
	farptr FlushBgMapShadowToVram ; $400c
	farptr WriteTilemapByteAdvance ; $400e
	farptr DrawStringToTilemap ; $4010
	farptr AddBobbingOffsetXY ; $4012
	farptr AddBobbingOffsetY ; $4014
	farptr AddBobbingOffsetYLarge ; $4016
	farptr StubNop_18 ; $4018
	farptr DrawDecimalNumberToTilemap ; $401a
	farptr FindRosterEntry ; $401c
	farptr ApplySpriteBobOffset_18 ; $401e
	farptr LoadCharSelectCursorGfx ; $4020
	farptr DrawCharSelectCursor ; $4022
	farptr LoadCharacterRecordToBuffer ; $4024
	farptr CheckCharacterUnlocked ; $4026
	farptr CheckUnlockFlag ; $4028
	farptr MoveGridCursor ; $402a
	farptr InitPlayerRecordForCharacter ; $402c
	farptr ForceFlushBgMapToVram ; $402e
	farptr DrawConfirmScreenBox ; $4030
	farptr RunTwoOptionSelect ; $4032
	farptr RunTwoOptionSelectB ; $4034
	farptr InitConfirmScreen ; $4036
	farptr SetupScoreboardDisplay ; $4038
	farptr LoadScorePanelValue ; $403a
	farptr StubNop_18_5379 ; $403c
	farptr DrawDecimalNumberSprites ; $403e
	farptr DrawYesNoLabels ; $4040
	farptr DrawTileBlock6x2ToTilemap ; $4042
	farptr LoadOnCourtCharTilesA ; $4044
	farptr LoadOnCourtCharTilesB ; $4046
DataPtr_CharRosterIcon00:
	dw CharRosterIcon00 ; $4048
DataPtr_CharRosterIcon01:
	dw CharRosterIcon01 ; $404a
DataPtr_CharRosterIcon02:
	dw CharRosterIcon02 ; $404c
DataPtr_CharRosterIcon03:
	dw CharRosterIcon03 ; $404e
DataPtr_CharRosterIcon04:
	dw CharRosterIcon04 ; $4050
DataPtr_CharRosterIcon05:
	dw CharRosterIcon05 ; $4052
DataPtr_CharRosterIcon06:
	dw CharRosterIcon06 ; $4054
DataPtr_CharRosterIcon07:
	dw CharRosterIcon07 ; $4056
DataPtr_CharRosterIcon08:
	dw CharRosterIcon08 ; $4058
DataPtr_CharRosterIcon09:
	dw CharRosterIcon09 ; $405a
DataPtr_CharRosterIcon10:
	dw CharRosterIcon10 ; $405c
DataPtr_CharRosterIcon11:
	dw CharRosterIcon11 ; $405e
DataPtr_CharRosterIcon12:
	dw CharRosterIcon12 ; $4060
DataPtr_CharRosterIcon13:
	dw CharRosterIcon13 ; $4062
DataPtr_CharRosterIcon14:
	dw CharRosterIcon14 ; $4064
DataPtr_CharRosterIcon15:
	dw CharRosterIcon15 ; $4066
DataPtr_CharRosterIcon16:
	dw CharRosterIcon16 ; $4068
DataPtr_CharRosterIcon17:
	dw CharRosterIcon17 ; $406a
DataPtr_CharRosterIcon18:
	dw CharRosterIcon18 ; $406c
DataPtr_CharRosterIcon19:
	dw CharRosterIcon19 ; $406e
DataPtr_CharRosterIcon20:
	dw CharRosterIcon20 ; $4070
DataPtr_CharRosterIcon21:
	dw CharRosterIcon21 ; $4072
DataPtr_CharRosterIcon22:
	dw CharRosterIcon22 ; $4074
DataPtr_CharRosterIcon23:
	dw CharRosterIcon23 ; $4076
DataPtr_CharRosterIcon24:
	dw CharRosterIcon24 ; $4078
DataPtr_CharRosterIcon25:
	dw CharRosterIcon25 ; $407a
DataPtr_CharRosterIcon26:
	dw CharRosterIcon26 ; $407c
DataPtr_CharRosterIcon27:
	dw CharRosterIcon27 ; $407e
DataPtr_CharRosterIcon28:
	dw CharRosterIcon28 ; $4080
DataPtr_CharRosterIcon29:
	dw CharRosterIcon29 ; $4082
DataPtr_CharRosterIcon30:
	dw CharRosterIcon30 ; $4084
DataPtr_CharRosterIcon31:
	dw CharRosterIcon31 ; $4086
DataPtr_MarioMiniGamesTilemap:
	dw MarioMiniGamesTilemap ; $4088
DataPtr_MarioMiniGamesAttrmap:
	dw MarioMiniGamesAttrmap ; $408a
DataPtr_MarioMiniGamesPalettes:
	dw MarioMiniGamesPalettes ; $408c
	farptr RunStorySceneByMode ; $408e
	farptr DebugScreenAssetViewer ; $4090
DataPtr_MatchWinLoseGfx:
	dw MatchWinLoseGfx ; $4092
DataPtr_CharSelectMiscGfx:
	dw CharSelectMiscGfx ; $4094
Padding_18_4096:
	; $4096, 10 bytes (fill)
	ds 10, $00
FontTiles:
	INCBIN "data/bank_018/d_40a0.bin" ; $40a0, 512 bytes
MenuHandCursorGfx:
	INCBIN "data/bank_018/d_42a0.bin" ; $42a0, 64 bytes
Palette_18_42e0:
	INCLUDE "data/bank_018/palettes_42e0.asm" ; $42e0, 32 bytes (palettes)
Palette_18_4300:
	INCLUDE "data/bank_018/palettes_4300.asm" ; $4300, 40 bytes (palettes)
LoadAllIndexedPalettes_18:
	push af ; $4328
	push bc ; $4329
	push de ; $432a
	push hl ; $432b
	ld hl, Palette_18_4300 ; $432c
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
	and a, $0f ; $433d
	add a, a ; $433f
	add a, a ; $4340
	add a, a ; $4341
	add a, $00 ; $4342
	ld l, a ; $4344
	adc a, $43 ; $4345
	sub a, l ; $4347
	ld h, a ; $4348
	ld e, $01 ; $4349
	call LoadPaletteShadow ; $434b
	pop hl ; $434e
	pop de ; $434f
	pop bc ; $4350
	pop af ; $4351
	ret ; $4352
FlushBgMapShadowToVram:
	ld a, [wBgMapShadowDirty] ; $4353
	and a, $0f ; $4356
	jr z, .attrPlane ; $4358
	ld hl, $d800 ; $435a
	ld de, $9800 ; $435d
	ld c, $24 ; $4360
	call QueueVRAMCopy ; $4362
.attrPlane:
	ld a, [wBgMapShadowDirty] ; $4365
	and a, $f0 ; $4368
	jr z, .done ; $436a
	ld hl, $dc00 ; $436c
	ld de, $b800 ; $436f
	ld c, $24 ; $4372
	call QueueVRAMCopy ; $4374
.done:
	xor a, a ; $4377
	ld [wBgMapShadowDirty], a ; $4378
	ret ; $437b
LoadMenuHandCursorGfx:
	push hl ; $437c
	ld hl, Palette_18_42e0 ; $437d
	call LoadPaletteShadow ; $4380
	pop de ; $4383
	ld hl, MenuHandCursorGfx ; $4384
	ld c, (Palette_18_42e0 - MenuHandCursorGfx) / 16 ; $4387
	call QueueVRAMCopy ; $4389
	ret ; $438c
StubLoadFontTiles:
	ret ; $438d
	ld hl, FontTiles ; $438e
	ld de, $9000 ; $4391
	ld c, $10 ; $4394
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
	add a, l ; $43e1
	ld l, a ; $43e2
	jr nc, .nextRowAttr ; $43e3
	inc h ; $43e5
.nextRowAttr:
	ld a, $20 ; $43e6
	add a, e ; $43e8
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
	add a, l ; $43f8
	ld l, a ; $43f9
	jr nc, .topRowDone ; $43fa
	inc h ; $43fc
.topRowDone:
	dec c ; $43fd
	dec c ; $43fe
.bottomRow:
	call DrawBoxSideRow ; $43ff
	ld a, $20 ; $4402
	add a, l ; $4404
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
	add a, l ; $442c
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
	and a, $0f ; $4448
	add a, LOW(Data_18_4468) ; $444a
	ld l, a ; $444c
	adc a, HIGH(Data_18_4468) ; $444d
	sub a, l ; $444f
	ld h, a ; $4450
	ld a, [hl] ; $4451
	add a, d ; $4452
	ld d, a ; $4453
	ldh a, [hVBlankCounter] ; $4454
	add a, $04 ; $4456
	and a, $0f ; $4458
	add a, LOW(Data_18_4468) ; $445a
	ld l, a ; $445c
	adc a, HIGH(Data_18_4468) ; $445d
	sub a, l ; $445f
	ld h, a ; $4460
	ld a, [hl] ; $4461
	cpl ; $4462
	add a, e ; $4463
	ld e, a ; $4464
	pop af ; $4465
	pop hl ; $4466
	ret ; $4467
Data_18_4468:
	; $4468, 16 bytes (bytes:16)
	db $00, $01, $01, $01, $02, $02, $03, $04, $03, $02, $02, $01, $01, $01, $00, $00 ; 0x00
AddBobbingOffsetY:
	push af ; $4478
	push hl ; $4479
	ldh a, [hVBlankCounter] ; $447a
	and a, $0f ; $447c
	add a, LOW(Data_18_448b) ; $447e
	ld l, a ; $4480
	adc a, HIGH(Data_18_448b) ; $4481
	sub a, l ; $4483
	ld h, a ; $4484
	ld a, [hl] ; $4485
	add a, e ; $4486
	ld e, a ; $4487
	pop af ; $4488
	pop hl ; $4489
	ret ; $448a
Data_18_448b:
	; $448b, 16 bytes (bytes:16)
	db $00, $01, $01, $02, $03, $04, $06, $08, $06, $04, $03, $02, $01, $01, $00, $00 ; 0x00
AddBobbingOffsetYLarge:
	push af ; $449b
	push hl ; $449c
	ldh a, [hVBlankCounter] ; $449d
	and a, $3f ; $449f
	add a, LOW(Data_18_44ae) ; $44a1
	ld l, a ; $44a3
	adc a, HIGH(Data_18_44ae) ; $44a4
	sub a, l ; $44a6
	ld h, a ; $44a7
	ld a, [hl] ; $44a8
	add a, e ; $44a9
	ld e, a ; $44aa
	pop af ; $44ab
	pop hl ; $44ac
	ret ; $44ad
Data_18_44ae:
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
	cp a, b ; $44f3
	jr z, .found ; $44f4
	cp a, $ff ; $44f6
	jr z, .found ; $44f8
	ld a, $08 ; $44fa
	add a, l ; $44fc
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
	cp a, $84 ; $4507
	jr z, .fixedRecord ; $4509
	push af ; $450b
	push bc ; $450c
	push de ; $450d
	push hl ; $450e
	farcall LoadCharacterRecordToCa80 ; $450f
	ld hl, $ca80 ; $4512
	ld de, $d580 ; $4515
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
	ld [$d58b], a ; $4525
	pop af ; $4528
	ret ; $4529
CheckCharacterUnlocked:
	bit 7, a ; $452a
	jr z, .checkRange ; $452c
	ld a, [$d58b] ; $452e
	cp a, $ff ; $4531
	ret ; $4533
.checkRange:
	cp a, $04 ; $4534
	jr nc, .lookup ; $4536
	cp a, $ff ; $4538
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
	cp a, $10 ; $454d
	jr nc, .done ; $454f
	ld a, $01 ; $4551
	and a, a ; $4553
	ret ; $4554
.done:
	xor a, a ; $4555
	ret ; $4556
CheckUnlockFlag:
	bit 7, a ; $4557
	jr z, TestUnlockFlagById ; $4559
	cp a, $84 ; $455b
	jr nz, .locked ; $455d
	cp a, $ff ; $455f
	ret ; $4561
.locked:
	xor a, a ; $4562
	ret ; $4563
TestUnlockFlagById:
	push hl ; $4564
	push de ; $4565
	ld hl, UnlockFlagIds_18 ; $4566
	add a, a ; $4569
	add a, l ; $456a
	ld l, a ; $456b
	jr nc, .readFlagId ; $456c
	inc h ; $456e
.readFlagId:
	ld a, [hl+] ; $456f
	ld d, [hl] ; $4570
	ld e, a ; $4571
	or a, d ; $4572
	jr nz, .gameFlag ; $4573
	cp a, $ff ; $4575
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
	add a, a ; $45e5
	jr nc, .checkMaxX ; $45e6
	ld a, $08 ; $45e8
	dec a ; $45ea
	jr .wrapY ; $45eb
.checkMaxX:
	rra ; $45ed
	cp a, $08 ; $45ee
	jr c, .wrapY ; $45f0
	xor a, a ; $45f2
.wrapY:
	ld d, a ; $45f3
	ld a, e ; $45f4
	add a, a ; $45f5
	jr nc, .checkMaxY ; $45f6
	ld a, $04 ; $45f8
	dec a ; $45fa
	jr .readCell ; $45fb
.checkMaxY:
	rra ; $45fd
	cp a, $04 ; $45fe
	jr c, .readCell ; $4600
	xor a, a ; $4602
.readCell:
	ld e, a ; $4603
	ld a, e ; $4604
	add a, a ; $4605
	add a, a ; $4606
	add a, a ; $4607
	add a, d ; $4608
	push hl ; $4609
	add a, l ; $460a
	ld l, a ; $460b
	jr nc, .haveCell ; $460c
	inc h ; $460e
.haveCell:
	ld a, [hl] ; $460f
	pop hl ; $4610
	cp a, $ff ; $4611
	jr z, MoveGridCursor ; $4613
	cp a, $fe ; $4615
	jr nz, .occupied ; $4617
	inc d ; $4619
	inc e ; $461a
	jr MoveGridCursor ; $461b
.occupied:
	cp a, $fd ; $461d
	jr nz, .store ; $461f
	dec d ; $4621
	dec e ; $4622
	jr MoveGridCursor ; $4623
.store:
	cp a, $fc ; $4625
	jr nz, .retry ; $4627
	dec d ; $4629
	jr MoveGridCursor ; $462a
.retry:
	cp a, $fb ; $462c
	jr nz, .done ; $462e
	ld a, b ; $4630
	and a, $20 ; $4631
	bit 5, a ; $4633
	jr nz, .done ; $4635
	inc d ; $4637
	jr MoveGridCursor ; $4638
.done:
	ret ; $463a
InitPlayerRecordForCharacter:
	push af ; $463b
	ld d, a ; $463c
	ldh a, [hPlayerInputFlags] ; $463d
	bit PADB_SELECT, a ; $463f
	jr z, .fromTemplate ; $4641
	ldh a, [hDebugStepMode] ; $4643
	or a, a ; $4645
	jr z, .fromTemplate ; $4646
	ld a, b ; $4648
	farcall LoadMainCharacterFromRoster ; $4649
	jr .storeRecord ; $464c
.fromTemplate:
	ld a, b ; $464e
	farcall InitPlayerRecordFromTemplate ; $464f
.storeRecord:
	pop af ; $4652
	add a, a ; $4653
	add a, $c0 ; $4654
	ld l, a ; $4656
	adc a, $c7 ; $4657
	sub a, l ; $4659
	ld h, a ; $465a
	ld d, h ; $465b
	ld e, l ; $465c
	push af ; $465d
	ld hl, wStoryModeNameOfMainCharacter ; $465e
	ld a, [wStoryCharacterSlot] ; $4661
	or a, a ; $4664
	jr z, .partnerSlot ; $4665
	ld l, $40 ; $4667
.partnerSlot:
	pop af ; $4669
	ld b, h ; $466a
	ld c, l ; $466b
	ld a, [de] ; $466c
	inc de ; $466d
	ld hl, $000e ; $466e
	add hl, bc ; $4671
	ld [hl], a ; $4672
	ld a, [de] ; $4673
	ld hl, $000c ; $4674
	add hl, bc ; $4677
	ld [hl], a ; $4678
	ret ; $4679
ConfirmScreenGfx0:
	INCBIN "data/bank_018/d_467a.bin" ; $467a, 2233 bytes
Palette_18_4f33:
	INCLUDE "data/bank_018/palettes_4f33.asm" ; $4f33, 64 bytes (palettes)
ConfirmScreenGfx1:
	INCBIN "data/bank_018/d_4f73.bin" ; $4f73, 347 bytes
ConfirmScreenGfx2:
	INCBIN "data/bank_018/d_50ce.bin" ; $50ce, 138 bytes
ThreeOptionLabelsData0:
	INCBIN "data/bank_018/d_5158.bin" ; $5158, 16 bytes
ThreeOptionLabelsData1:
	INCBIN "data/bank_018/d_5168.bin" ; $5168, 16 bytes
ThreeOptionLabelsData2:
	INCBIN "data/bank_018/d_5178.bin" ; $5178, 16 bytes
ThreeOptionLabelsData3:
	INCBIN "data/bank_018/d_5188.bin" ; $5188, 16 bytes
ThreeOptionLabelsData4:
	INCBIN "data/bank_018/d_5198.bin" ; $5198, 16 bytes
ThreeOptionLabelsData5:
	INCBIN "data/bank_018/d_51a8.bin" ; $51a8, 16 bytes
YesNoLabels0:
	; $51b8, 16 bytes (bytes:16)
	db $8b, $8b, $dd, $de, $df, $8b, $8b, $bd, $be, $bf, $8b, $8b, $ff, $ff, $ff, $ff ; 0x00
YesNoLabels1:
	; $51c8, 16 bytes (bytes:16)
	db $8b, $8b, $ed, $ee, $ef, $8b, $8b, $cd, $ce, $cf, $8b, $8b, $ff, $ff, $ff, $ff ; 0x00
YesNoLabels2:
	; $51d8, 16 bytes (bytes:16)
	db $08, $08, $0e, $0e, $0e, $08, $08, $0e, $0e, $0e, $08, $08, $09, $09, $09, $09 ; 0x00
YesNoLabels3:
	; $51e8, 16 bytes (bytes:16)
	db $08, $08, $0e, $0e, $0e, $08, $08, $0e, $0e, $0e, $08, $08, $09, $09, $09, $09 ; 0x00
ConfirmScreenGfx3:
	INCBIN "data/bank_018/d_51f8.bin" ; $51f8, 206 bytes
Palette_18_52c6:
	INCLUDE "data/bank_018/palettes_52c6.asm" ; $52c6, 24 bytes (palettes)
InitConfirmScreen:
	call ClearFrameTasks ; $52de
	call ClearSpriteQueue ; $52e1
	call ClearTileVramBothBanks ; $52e4
	call LoadScorePanelValue ; $52e7
	xor a, a ; $52ea
	ld [$c783], a ; $52eb
	ld [$c780], a ; $52ee
	ld hl, ConfirmScreenGfx0 ; $52f1
	ld de, $d000 ; $52f4
	call DecompressData ; $52f7
	ld hl, $d000 ; $52fa
	ld de, $b000 ; $52fd
	ld c, $80 ; $5300
	call QueueVRAMCopy ; $5302
	ld hl, $d800 ; $5305
	ld de, $a800 ; $5308
	ld c, $80 ; $530b
	call QueueVRAMCopy ; $530d
	ld hl, Palette_18_4f33 ; $5310
	ld de, $0008 ; $5313
	call LoadPaletteShadow ; $5316
	ld hl, ConfirmScreenGfx2 ; $5319
	ld de, $dc00 ; $531c
	call DecompressData ; $531f
	ld hl, ConfirmScreenGfx1 ; $5322
	ld de, $d800 ; $5325
	call DecompressData ; $5328
	call StubLoadFontTiles ; $532b
	call DrawConfirmScreenBox ; $532e
	ld hl, ConfirmScreenGfx3 ; $5331
	ld de, $d000 ; $5334
	call DecompressData ; $5337
	ld hl, $d000 ; $533a
	ld de, $8300 ; $533d
	ld c, $14 ; $5340
	call QueueVRAMCopy ; $5342
	ld hl, Palette_18_52c6 ; $5345
	ld de, $0903 ; $5348
	call LoadPaletteShadow ; $534b
	ld hl, $8500 ; $534e
	ld de, $0e01 ; $5351
	call LoadMenuHandCursorGfx ; $5354
	call LoadConfirmScreenSpriteGfx ; $5357
	call SetupScoreboardDisplay ; $535a
	ld hl, $c7bc ; $535d
	ld b, [hl] ; $5360
	call StubNop_18_5379 ; $5361
	ret ; $5364
DrawConfirmScreenBox:
	ld hl, $d9a0 ; $5365
	ld de, $dda0 ; $5368
	ld bc, $0e05 ; $536b
	call DrawBox ; $536e
	ret ; $5371
LoadScorePanelValue:
	ld a, [$c918] ; $5372
	ld [$c78a], a ; $5375
	ret ; $5378
StubNop_18_5379:
	ret ; $5379
SetupScoreboardDisplay:
	ld a, [$c78d] ; $537a
	call GetTextSlotPointer ; $537d
	ld de, $d84b ; $5380
	call DrawTileBlock6x2ToTilemap ; $5383
	ld a, [$c78e] ; $5386
	call GetTextSlotPointer ; $5389
	ld de, $d88b ; $538c
	call DrawTileBlock6x2ToTilemap ; $538f
	ld a, [$c78f] ; $5392
	call GetTextSlotPointer ; $5395
	ld de, wTextArgStringQueue + 27 ; $5398
	call DrawTileBlock6x2ToTilemap ; $539b
	ld a, [wTargetZoneX1] ; $539e
	call GetTextSlotPointer ; $53a1
	ld de, $d90b ; $53a4
	call DrawTileBlock6x2ToTilemap ; $53a7
	ld a, $0a ; $53aa
	ld hl, DrawScoreNumbersTask ; $53ac
	call RegisterFrameTask ; $53af
	ret ; $53b2
DrawScoreNumbersTask:
	ld a, [$c78a] ; $53b3
	ld h, $00 ; $53b6
	ld l, a ; $53b8
	ld de, $4404 ; $53b9
	ld b, $03 ; $53bc
	ld a, $02 ; $53be
	call DrawDecimalNumberSprites ; $53c0
	ld a, [$c780] ; $53c3
	cp a, $03 ; $53c6
	jr nz, .draw ; $53c8
	ld a, $01 ; $53ca
	ld [$c783], a ; $53cc
.draw:
	ld hl, $c78b ; $53cf
	ld a, [hl+] ; $53d2
	ld h, [hl] ; $53d3
	ld l, a ; $53d4
	ld de, $4454 ; $53d5
	ld b, $01 ; $53d8
	ld a, $03 ; $53da
	call DrawDecimalNumberSprites ; $53dc
	xor a, a ; $53df
	ld [$c783], a ; $53e0
	ret ; $53e3
GetTextSlotPointer:
	add a, $04 ; $53e4
	and a, $0f ; $53e6
	add a, a ; $53e8
	add a, LOW(TextSlotPointerTable) ; $53e9
	ld l, a ; $53eb
	adc a, HIGH(TextSlotPointerTable) ; $53ec
	sub a, l ; $53ee
	ld h, a ; $53ef
	ld a, [hl+] ; $53f0
	ld h, [hl] ; $53f1
	ld l, a ; $53f2
	ld de, $d800 ; $53f3
	add hl, de ; $53f6
	ret ; $53f7
TextSlotPointerTable:
	; $53f8, 32 bytes (records:2)
	dw $0016 ; record 0
	dw $0056 ; record 1
	dw $0096 ; record 2
	dw $00d6 ; record 3
	dw $0116 ; record 4
	dw $0156 ; record 5
	dw $0196 ; record 6
	dw $01d6 ; record 7
	dw $0216 ; record 8
	dw $0016 ; record 9
	dw $0016 ; record 10
	dw $0016 ; record 11
	dw $0016 ; record 12
	dw $0016 ; record 13
	dw $0016 ; record 14
	dw $0016 ; record 15
ForceFlushBgMapToVram:
	ld a, $ff ; $5418
	ld [wBgMapShadowDirty], a ; $541a
	call FlushBgMapShadowToVram ; $541d
	ret ; $5420
RunTwoOptionSelect:
	ldh a, [hInputRisingEdge] ; $5421
	and a, PADF_LEFT ; $5423
	jr z, .inputLoop ; $5425
	ld b, $00 ; $5427
	sound $5e ; $5429
.inputLoop:
	ldh a, [hInputRisingEdge] ; $542b
	and a, PADF_RIGHT ; $542d
	jr z, .checkUp ; $542f
	ld b, $01 ; $5431
	sound $5e ; $5433
.checkUp:
	ldh a, [hInputRisingEdge] ; $5435
	and a, PADF_A ; $5437
	jr nz, .confirm ; $5439
	ldh a, [hInputRisingEdge] ; $543b
	and a, PADF_B ; $543d
	jr z, .checkDown ; $543f
	ld b, $ff ; $5441
	jr .confirm ; $5443
.checkDown:
	ld de, $128e ; $5445
	ld a, b ; $5448
	and a, a ; $5449
	jr z, .redraw ; $544a
	ld de, $3a8e ; $544c
.redraw:
	call AddBobbingOffsetXY ; $544f
	push bc ; $5452
	ld bc, $0650 ; $5453
	call QueueSprite16 ; $5456
	pop bc ; $5459
	call AdvanceFrame ; $545a
	jr RunTwoOptionSelect ; $545d
.confirm:
	ld a, b ; $545f
	and a, a ; $5460
	jr z, .done ; $5461
	sound $62 ; $5463
	ret ; $5465
.done:
	sound $5f ; $5466
	ret ; $5468
RunTwoOptionSelectB:
	ldh a, [hInputRisingEdge] ; $5469
	and a, PADF_LEFT ; $546b
	jr z, .inputLoop ; $546d
	ld b, $00 ; $546f
	sound $5e ; $5471
.inputLoop:
	ldh a, [hInputRisingEdge] ; $5473
	and a, PADF_RIGHT ; $5475
	jr z, .checkUp ; $5477
	ld b, $01 ; $5479
	sound $5e ; $547b
.checkUp:
	ldh a, [hInputRisingEdge] ; $547d
	and a, PADF_A ; $547f
	jr nz, .confirm ; $5481
	ldh a, [hInputRisingEdge] ; $5483
	and a, PADF_B ; $5485
	jr z, .checkDown ; $5487
	ld b, $ff ; $5489
	jr .confirm ; $548b
.checkDown:
	ld de, $2892 ; $548d
	ld a, b ; $5490
	and a, a ; $5491
	jr z, .redraw ; $5492
	ld de, TwoOptionSelectBTable ; $5494
.redraw:
	call AddBobbingOffsetXY ; $5497
	push bc ; $549a
	ld bc, $0650 ; $549b
	call QueueSprite16 ; $549e
	pop bc ; $54a1
	call AdvanceFrame ; $54a2
	jr RunTwoOptionSelectB ; $54a5
.confirm:
	ld a, b ; $54a7
	and a, a ; $54a8
	jr z, .done ; $54a9
	sound $62 ; $54ab
	ret ; $54ad
.done:
	sound $5f ; $54ae
	ret ; $54b0
DrawDecimalNumberSprites:
	push af ; $54b1
	push bc ; $54b2
	push hl ; $54b3
	add sp, -10 ; $54b4
	push bc ; $54b6
	push de ; $54b7
	ld c, l ; $54b8
	ld b, h ; $54b9
	ld hl, sp + 4 ; $54ba
	ld e, l ; $54bc
	ld d, h ; $54bd
	ld l, c ; $54be
	ld h, b ; $54bf
	ld c, e ; $54c0
	ld b, d ; $54c1
	call FormatDecimalNumber ; $54c2
	ld l, c ; $54c5
	ld h, b ; $54c6
	pop de ; $54c7
	pop bc ; $54c8
	call DrawStringSprites ; $54c9
	add sp, 10 ; $54cc
	pop hl ; $54ce
	pop bc ; $54cf
	pop af ; $54d0
	ret ; $54d1
DrawStringSprites:
	ld a, [hl+] ; $54d2
	and a, a ; $54d3
	jr z, .done ; $54d4
	call DrawGlyphSprite ; $54d6
	jr DrawStringSprites ; $54d9
.done:
	ret ; $54db
DrawGlyphSprite:
	sub a, $30 ; $54dc
	jr c, .advance ; $54de
	push de ; $54e0
	push hl ; $54e1
	add a, a ; $54e2
	add a, $30 ; $54e3
	ld c, a ; $54e5
	ld a, [$c783] ; $54e6
	and a, a ; $54e9
	jr z, .queue ; $54ea
	ld a, d ; $54ec
	ld hl, hVBlankCounter ; $54ed
	sub a, [hl] ; $54f0
	and a, $1f ; $54f1
	add a, LOW(UnusedBobRamp_18) ; $54f3
	ld l, a ; $54f5
	adc a, HIGH(UnusedBobRamp_18) ; $54f6
	sub a, l ; $54f8
	ld h, a ; $54f9
	ld a, [hl] ; $54fa
	add a, e ; $54fb
	ld e, a ; $54fc
.queue:
	call QueueSprite ; $54fd
	pop hl ; $5500
	pop de ; $5501
.advance:
	ld a, d ; $5502
	add a, $08 ; $5503
	ld d, a ; $5505
	ret ; $5506
UnusedBobRamp_18:
	INCBIN "data/bank_018/d_5507.bin" ; $5507, 32 bytes
DrawThreeOptionLabels:
	call DrawConfirmScreenBox ; $5527
	ld hl, ThreeOptionLabelsData3 ; $552a
	ld de, $ddc1 ; $552d
	call CopyBytes11 ; $5530
	ld hl, ThreeOptionLabelsData4 ; $5533
	ld de, $dde1 ; $5536
	call CopyBytes11 ; $5539
	ld hl, ThreeOptionLabelsData5 ; $553c
	ld de, $de01 ; $553f
	call CopyBytes11 ; $5542
	ld hl, ThreeOptionLabelsData0 ; $5545
	ld de, $d9c1 ; $5548
	call CopyBytes11 ; $554b
	ld hl, ThreeOptionLabelsData1 ; $554e
	ld de, $d9e1 ; $5551
	call CopyBytes11 ; $5554
	ld hl, ThreeOptionLabelsData2 ; $5557
	ld de, $da01 ; $555a
	call CopyBytes11 ; $555d
	ret ; $5560
DrawYesNoLabels:
	ld hl, YesNoLabels2 ; $5561
	ld de, $dde1 ; $5564
	call CopyBytes11 ; $5567
	ld hl, YesNoLabels3 ; $556a
	ld de, $de01 ; $556d
	call CopyBytes11 ; $5570
	ld hl, YesNoLabels0 ; $5573
	ld de, $d9e1 ; $5576
	call CopyBytes11 ; $5579
	ld hl, YesNoLabels1 ; $557c
	ld de, $da01 ; $557f
	call CopyBytes11 ; $5582
	ret ; $5585
DrawTileBlock6x2ToTilemap:
	ld a, [hl+] ; $5586
	ld [de], a ; $5587
	inc de ; $5588
	ld a, [hl+] ; $5589
	ld [de], a ; $558a
	inc de ; $558b
	ld a, [hl+] ; $558c
	ld [de], a ; $558d
	inc de ; $558e
	ld a, [hl+] ; $558f
	ld [de], a ; $5590
	inc de ; $5591
	ld a, [hl+] ; $5592
	ld [de], a ; $5593
	inc de ; $5594
	ld a, [hl+] ; $5595
	ld [de], a ; $5596
	inc de ; $5597
	ld a, $1a ; $5598
	add a, l ; $559a
	ld l, a ; $559b
	jr nc, .gotSource ; $559c
	inc h ; $559e
.gotSource:
	ld a, $1a ; $559f
	add a, e ; $55a1
	ld e, a ; $55a2
	jr nc, .copyRows ; $55a3
	inc d ; $55a5
.copyRows:
	ld a, [hl+] ; $55a6
	ld [de], a ; $55a7
	inc de ; $55a8
	ld a, [hl+] ; $55a9
	ld [de], a ; $55aa
	inc de ; $55ab
	ld a, [hl+] ; $55ac
	ld [de], a ; $55ad
	inc de ; $55ae
	ld a, [hl+] ; $55af
	ld [de], a ; $55b0
	inc de ; $55b1
	ld a, [hl+] ; $55b2
	ld [de], a ; $55b3
	inc de ; $55b4
	ld a, [hl+] ; $55b5
	ld [de], a ; $55b6
	inc de ; $55b7
	ret ; $55b8
CopyBytes11:
	ld a, [hl+] ; $55b9
	ld [de], a ; $55ba
	inc de ; $55bb
	ld a, [hl+] ; $55bc
	ld [de], a ; $55bd
	inc de ; $55be
	ld a, [hl+] ; $55bf
	ld [de], a ; $55c0
	inc de ; $55c1
	ld a, [hl+] ; $55c2
	ld [de], a ; $55c3
	inc de ; $55c4
	ld a, [hl+] ; $55c5
	ld [de], a ; $55c6
	inc de ; $55c7
	ld a, [hl+] ; $55c8
	ld [de], a ; $55c9
	inc de ; $55ca
	ld a, [hl+] ; $55cb
	ld [de], a ; $55cc
	inc de ; $55cd
	ld a, [hl+] ; $55ce
	ld [de], a ; $55cf
	inc de ; $55d0
	ld a, [hl+] ; $55d1
	ld [de], a ; $55d2
	inc de ; $55d3
	ld a, [hl+] ; $55d4
	ld [de], a ; $55d5
	inc de ; $55d6
	ld a, [hl+] ; $55d7
	ld [de], a ; $55d8
	inc de ; $55d9
	ret ; $55da
ClearTileVramBothBanks:
	ld hl, $8000 ; $55db
	ld c, $80 ; $55de
	call ClearMemory16 ; $55e0
	ldh a, [rVBK] ; $55e3
	xor a, $01 ; $55e5
	ldh [rVBK], a ; $55e7
	ld hl, $8000 ; $55e9
	ld c, $80 ; $55ec
	call ClearMemory16 ; $55ee
	ldh a, [rVBK] ; $55f1
	xor a, $01 ; $55f3
	ldh [rVBK], a ; $55f5
	ret ; $55f7
LoadConfirmScreenSpriteGfx:
	ld hl, ConfirmScreenSpriteGfx0 ; $55f8
	ld de, $d000 ; $55fb
	call DecompressData ; $55fe
	ld hl, $d000 ; $5601
	ld de, $a000 ; $5604
	ld c, $1c ; $5607
	call QueueVRAMCopy ; $5609
	ld hl, Palette_18_582d ; $560c
	ld de, $0c03 ; $560f
	call LoadPalettesImmediate ; $5612
	ld hl, ConfirmScreenSpriteGfx1 ; $5615
	ld de, $d000 ; $5618
	call DecompressData ; $561b
	ld hl, $d000 ; $561e
	ld de, $a200 ; $5621
	ld c, $0c ; $5624
	call QueueVRAMCopy ; $5626
	ld hl, Palette_18_58ad ; $5629
	ld de, $0801 ; $562c
	call LoadPalettesImmediate ; $562f
	ret ; $5632
ConfirmScreenSpriteGfx0:
	INCBIN "data/bank_018/d_5633.bin" ; $5633, 506 bytes
Palette_18_582d:
	INCLUDE "data/bank_018/palettes_582d.asm" ; $582d, 24 bytes (palettes)
ConfirmScreenSpriteGfx1:
	INCBIN "data/bank_018/d_5845.bin" ; $5845, 77 bytes
TwoOptionSelectBTable:
	; $5892, 27 bytes (bytes:16)
	db $92, $ec, $e1, $10, $6c, $7c, $d5, $e2, $92, $e8, $e7, $00, $de, $e5, $b4, $e3 ; 0x00
	db $88, $e3, $c8, $e9, $da, $ef, $ff, $eb, $00, $00, $00 ; 0x10
Palette_18_58ad:
	INCLUDE "data/bank_018/palettes_58ad.asm" ; $58ad, 51 bytes (palettes)
CharSelectCursorGfx:
	INCBIN "data/bank_018/d_58e0.bin" ; $58e0, 217 bytes
Palette_18_59b9:
	INCLUDE "data/bank_018/palettes_59b9.asm" ; $59b9, 8 bytes (palettes)
LoadCharSelectCursorGfx:
	ld hl, CharSelectCursorGfx ; $59c1
	ld de, $8400 ; $59c4
	ld c, $0c ; $59c7
	call QueueVRAMCopy ; $59c9
	ld hl, Palette_18_59b9 ; $59cc
	ld de, $0a01 ; $59cf
	call LoadPaletteShadow ; $59d2
	ret ; $59d5
DrawCharSelectCursor:
	ld c, $00 ; $59d6
	cp a, $84 ; $59d8
	jr nz, .animate ; $59da
	ld c, $01 ; $59dc
.animate:
	ldh a, [hVBlankCounter] ; $59de
	and a, $1f ; $59e0
	add a, LOW(CharSelectCursorAnimTable) ; $59e2
	ld l, a ; $59e4
	adc a, HIGH(CharSelectCursorAnimTable) ; $59e5
	sub a, l ; $59e7
	ld h, a ; $59e8
	ld a, c ; $59e9
	add a, a ; $59ea
	add a, [hl] ; $59eb
	add a, a ; $59ec
	add a, LOW(CharSelectCursorTemplatePtrs) ; $59ed
	ld l, a ; $59ef
	adc a, HIGH(CharSelectCursorTemplatePtrs) ; $59f0
	sub a, l ; $59f2
	ld h, a ; $59f3
	ld a, [hl+] ; $59f4
	ld h, [hl] ; $59f5
	ld l, a ; $59f6
	ld bc, $0240 ; $59f7
	call QueueSpriteTemplate ; $59fa
	ret ; $59fd
CharSelectCursorAnimTable:
	INCBIN "data/bank_018/d_59fe.bin" ; $59fe, 32 bytes
CharSelectCursorTemplatePtrs:
	INCBIN "data/bank_018/d_5a1e.bin" ; $5a1e, 8 bytes
CharSelectCursorTemplate0:
	INCBIN "data/bank_018/d_5a26.bin" ; $5a26, 17 bytes
CharSelectCursorTemplate1:
	INCBIN "data/bank_018/d_5a37.bin" ; $5a37, 17 bytes
CharSelectCursorTemplate2:
	INCBIN "data/bank_018/d_5a48.bin" ; $5a48, 17 bytes
CharSelectCursorTemplate3:
	INCBIN "data/bank_018/d_5a59.bin" ; $5a59, 17 bytes
ApplySpriteBobOffset_18:
	ldh a, [hVBlankCounter] ; $5a6a
	and a, $3f ; $5a6c
	add a, LOW(SpriteBobRamp_18) ; $5a6e
	ld l, a ; $5a70
	adc a, HIGH(SpriteBobRamp_18) ; $5a71
	sub a, l ; $5a73
	ld h, a ; $5a74
	ld a, [hl] ; $5a75
	add a, e ; $5a76
	ld e, a ; $5a77
	ret ; $5a78
SpriteBobRamp_18:
	; $5a79, 64 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $02, $02, $02, $03, $03, $03, $03, $03, $03, $03 ; 0x00
	db $03, $03, $03, $03, $03, $03, $03, $03, $02, $02, $02, $01, $01, $01, $00, $00 ; 0x10
	db $00, $00, $00, $ff, $ff, $ff, $fe, $fe, $fe, $fd, $fd, $fd, $fd, $fd, $fd, $fd ; 0x20
	db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fe, $fe, $fe, $ff, $ff, $ff, $00, $00 ; 0x30
LoadOnCourtCharTilesA:
	ld h, a ; $5ab9
	ld l, $00 ; $5aba
	srl h ; $5abc
	rr l ; $5abe
	srl h ; $5ac0
	rr l ; $5ac2
	ld bc, OnCourtCharTilesAGfx ; $5ac4
	add hl, bc ; $5ac7
	ld c, $04 ; $5ac8
	call QueueVRAMCopy ; $5aca
	ret ; $5acd
LoadOnCourtCharTilesB:
	cp a, $ff ; $5ace
	jr z, LoadOnCourtCharTilesFallback ; $5ad0
	ld h, a ; $5ad2
	ld l, $00 ; $5ad3
	srl h ; $5ad5
	rr l ; $5ad7
	srl h ; $5ad9
	rr l ; $5adb
	ld bc, OnCourtCharTilesBGfx ; $5add
	add hl, bc ; $5ae0
	ld c, $04 ; $5ae1
	call QueueVRAMCopy ; $5ae3
	ret ; $5ae6
LoadOnCourtCharTilesFallback:
	ld hl, OnCourtCharTilesFallbackGfx ; $5ae7
	ld c, (CharRosterIcon00 - OnCourtCharTilesFallbackGfx) / 16 ; $5aea
	call QueueVRAMCopy ; $5aec
	ret ; $5aef
OnCourtCharTilesAGfx:
	INCBIN "data/bank_018/d_5af0.bin" ; $5af0, 2048 bytes
OnCourtCharTilesBGfx:
	INCBIN "data/bank_018/d_62f0.bin" ; $62f0, 2048 bytes
OnCourtCharTilesFallbackGfx:
	INCBIN "data/bank_018/d_6af0.bin" ; $6af0, 64 bytes
CharRosterIcon00:
	INCBIN "data/bank_018/lz_6b30.bin" ; $6b30, 67 bytes
CharRosterIcon01:
	INCBIN "data/bank_018/lz_6b73.bin" ; $6b73, 66 bytes
CharRosterIcon02:
	INCBIN "data/bank_018/lz_6bb5.bin" ; $6bb5, 62 bytes
CharRosterIcon03:
	INCBIN "data/bank_018/lz_6bf3.bin" ; $6bf3, 48 bytes
CharRosterIcon04:
	INCBIN "data/bank_018/lz_6c23.bin" ; $6c23, 44 bytes
CharRosterIcon05:
	INCBIN "data/bank_018/lz_6c4f.bin" ; $6c4f, 46 bytes
CharRosterIcon06:
	INCBIN "data/bank_018/lz_6c7d.bin" ; $6c7d, 59 bytes
CharRosterIcon07:
	INCBIN "data/bank_018/lz_6cb8.bin" ; $6cb8, 65 bytes
CharRosterIcon08:
	INCBIN "data/bank_018/lz_6cf9.bin" ; $6cf9, 67 bytes
CharRosterIcon09:
	INCBIN "data/bank_018/lz_6d3c.bin" ; $6d3c, 65 bytes
CharRosterIcon10:
	INCBIN "data/bank_018/lz_6d7d.bin" ; $6d7d, 60 bytes
CharRosterIcon11:
	INCBIN "data/bank_018/lz_6db9.bin" ; $6db9, 50 bytes
CharRosterIcon12:
	INCBIN "data/bank_018/lz_6deb.bin" ; $6deb, 45 bytes
CharRosterIcon13:
	INCBIN "data/bank_018/lz_6e18.bin" ; $6e18, 51 bytes
CharRosterIcon14:
	INCBIN "data/bank_018/lz_6e4b.bin" ; $6e4b, 61 bytes
CharRosterIcon15:
	INCBIN "data/bank_018/lz_6e88.bin" ; $6e88, 66 bytes
CharRosterIcon16:
	INCBIN "data/bank_018/lz_6eca.bin" ; $6eca, 73 bytes
CharRosterIcon17:
	INCBIN "data/bank_018/lz_6f13.bin" ; $6f13, 68 bytes
CharRosterIcon18:
	INCBIN "data/bank_018/lz_6f57.bin" ; $6f57, 64 bytes
CharRosterIcon19:
	INCBIN "data/bank_018/lz_6f97.bin" ; $6f97, 59 bytes
CharRosterIcon20:
	INCBIN "data/bank_018/lz_6fd2.bin" ; $6fd2, 53 bytes
CharRosterIcon21:
	INCBIN "data/bank_018/lz_7007.bin" ; $7007, 57 bytes
CharRosterIcon22:
	INCBIN "data/bank_018/lz_7040.bin" ; $7040, 66 bytes
CharRosterIcon23:
	INCBIN "data/bank_018/lz_7082.bin" ; $7082, 73 bytes
CharRosterIcon24:
	INCBIN "data/bank_018/lz_70cb.bin" ; $70cb, 71 bytes
CharRosterIcon25:
	INCBIN "data/bank_018/lz_7112.bin" ; $7112, 68 bytes
CharRosterIcon26:
	INCBIN "data/bank_018/lz_7156.bin" ; $7156, 66 bytes
CharRosterIcon27:
	INCBIN "data/bank_018/lz_7198.bin" ; $7198, 64 bytes
CharRosterIcon28:
	INCBIN "data/bank_018/lz_71d8.bin" ; $71d8, 58 bytes
CharRosterIcon29:
	INCBIN "data/bank_018/lz_7212.bin" ; $7212, 60 bytes
CharRosterIcon30:
	INCBIN "data/bank_018/lz_724e.bin" ; $724e, 68 bytes
CharRosterIcon31:
	INCBIN "data/bank_018/lz_7292.bin" ; $7292, 73 bytes
MarioMiniGamesTilemap:
	INCBIN "data/bank_018/lz_72db.bin" ; $72db, 304 bytes
MarioMiniGamesAttrmap:
	INCBIN "data/bank_018/lz_740b.bin" ; $740b, 214 bytes
MarioMiniGamesPalettes:
	INCLUDE "data/bank_018/palettes_74e1.asm" ; $74e1, 64 bytes (palettes)
MatchWinLoseGfx:
	INCBIN "data/bank_018/lz_7521.bin" ; $7521, 71 bytes
CharSelectMiscGfx:
	INCBIN "data/bank_018/lz_7568.bin" ; $7568, 175 bytes
RunStorySceneByMode:
	ld a, c ; $7617
	ld [wStorySceneAssetIndex], a ; $7618
	call FadeOutAndResetScreen ; $761b
	ld a, b ; $761e
	or a, a ; $761f
	jr nz, .checkMode1 ; $7620
	call PlayScreenSequence0 ; $7622
	ret ; $7625
.checkMode1:
	cp a, $01 ; $7626
	jr nz, .mode2 ; $7628
	call PlayScreenSequence1 ; $762a
	ret ; $762d
.mode2:
	call PlayScreenSequence2 ; $762e
	ret ; $7631
FadeOutAndResetScreen:
	call EnableLCD ; $7632
	ld c, $10 ; $7635
	call BeginFadeOut ; $7637
	call WaitFadeEnd ; $763a
	call DisableLCDSafely ; $763d
	call ClearFrameTasks ; $7640
	call ResetScrollAndCamera ; $7643
	ret ; $7646
ResetScrollAndCamera:
	xor a, a ; $7647
	ldh [hScrollX], a ; $7648
	ldh [hScrollY], a ; $764a
	ld [wCameraX], a ; $764c
	ld [wCameraX + 1], a ; $764f
	ld [wCameraY], a ; $7652
	ld [wCameraY + 1], a ; $7655
	ret ; $7658
DebugScreenAssetViewer:
	call FadeOutAndResetScreen ; $7659
	ld c, $00 ; $765c
.screenLoop:
	push bc ; $765e
	ld a, c ; $765f
	ld hl, DebugScreenAssetViewerRecords ; $7660
	add a, l ; $7663
	ld l, a ; $7664
	jr nc, .loadScreen ; $7665
	inc h ; $7667
.loadScreen:
	ld c, [hl] ; $7668
	push bc ; $7669
	ld c, $10 ; $766a
	call BeginFadeOut ; $766c
	call WaitFadeEnd ; $766f
	call DisableLCDSafely ; $7672
	pop bc ; $7675
	farcall LoadScreenAssetRecord ; $7676
	farcall QueueWram3MapToVRAM ; $7679
	call EnableLCD ; $767c
	script_fade_in $10 ; $767f
	call WaitFadeEnd ; $7684
.inputLoop:
	call AdvanceFrame ; $7687
	ldh a, [hInputPressed] ; $768a
	or a, a ; $768c
	jr z, .inputLoop ; $768d
	pop bc ; $768f
	ld a, c ; $7690
	inc a ; $7691
	ld c, a ; $7692
	cp a, $18 ; $7693
	jr nz, .screenLoop ; $7695
	ld c, $00 ; $7697
	jr .screenLoop ; $7699
	ret ; $769b
DebugScreenAssetViewerRecords:
	; $769c, 24 bytes (bytes:12)
	db $2c, $2d, $2e, $2f, $30, $31, $32, $33, $34, $35, $36, $37 ; 0x00
	db $38, $39, $3a, $3b, $3c, $3d, $3e, $3f, $40, $41, $42, $43 ; 0x0c
PlayScreenSequence0:
	call SetupScreen0Assets ; $76b4
	call LoadScreen0TilesAndPalette ; $76b7
	call EnableLCD ; $76ba
	script_fade_in $02 ; $76bd
	call WaitFadeEnd ; $76c2
	wram_bank $03 ; $76c5
	xor a, a ; $76cb
	ld [$da01], a ; $76cc
.scrollLoop:
	call AdvanceFrame ; $76cf
	ld a, [$da01] ; $76d2
	inc a ; $76d5
	ld [$da01], a ; $76d6
	cp a, $fa ; $76d9
	jr nz, .scrollLoop ; $76db
	farcall InitGrayscalePaletteFade ; $76dd
	ld b, $3f ; $76e0
	ld c, $3f ; $76e2
	ld d, $1e ; $76e4
	farcall SetupPaletteFadeMask ; $76e6
	farcall AnimatePaletteFadeToTarget ; $76e9
.waitInput:
	call AdvanceFrame ; $76ec
	ldh a, [hInputPressed] ; $76ef
	and a, PADF_A | PADF_B ; $76f1
	jr z, .waitInput ; $76f3
	ld c, $10 ; $76f5
	call BeginFadeOut ; $76f7
	call WaitFadeEnd ; $76fa
	call DisableLCDSafely ; $76fd
	call FillAllBgPalettes ; $7700
	call EnableLCD ; $7703
	script_fade_in $10 ; $7706
	call WaitFadeEnd ; $770b
	ld a, $01 ; $770e
	ld hl, QueueScreen0Sprites ; $7710
	call RegisterFrameTask ; $7713
.done:
	call AdvanceFrame ; $7716
	ldh a, [hInputPressed] ; $7719
	and a, PADF_A | PADF_B ; $771b
	jr z, .done ; $771d
	ret ; $771f
SetupScreen0Assets:
	call ResetScrollAndCamera ; $7720
	call LookupScreen0AssetId ; $7723
	farcall LoadScreenAssetRecord ; $7726
	farcall QueueWram3MapToVRAM ; $7729
	ret ; $772c
LookupScreen0AssetId:
	ld a, [wStorySceneAssetIndex] ; $772d
	ld hl, Screen0AssetIdTable ; $7730
	add a, l ; $7733
	ld l, a ; $7734
	jr nc, .read ; $7735
	inc h ; $7737
.read:
	ld c, [hl] ; $7738
	ret ; $7739
Screen0AssetIdTable:
	; $773a, 6 bytes (bytes:6)
	db $2c, $2d, $2f, $2e, $30, $31 ; 0x00
LoadScreen0TilesAndPalette:
	ld b, $06 ; $7740
	ld c, $28 ; $7742
	ld de, $8000 ; $7744
	farcall LoadCompressedTileBlock ; $7747
	ld hl, Palette_18_7754 ; $774a
	ld de, $0801 ; $774d
	call LoadPaletteShadow ; $7750
	ret ; $7753
Palette_18_7754:
	INCLUDE "data/bank_018/palettes_7754.asm" ; $7754, 8 bytes (palettes)
QueueScreen0Sprites:
	ld hl, SpriteTemplate_18_776a ; $775c
	ld de, $283a ; $775f
	ld c, $00 ; $7762
	ld b, $00 ; $7764
	call QueueSpriteTemplate ; $7766
	ret ; $7769
SpriteTemplate_18_776a:
	; $776a, 81 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite $10, $28, $10, $00
	oam_sprite $20, $28, $12, $00
	oam_sprite $10, $30, $14, $00
	oam_sprite $20, $30, $16, $00
	oam_sprite $10, $38, $18, $00
	oam_sprite $20, $38, $1a, $00
	oam_sprite $10, $40, $1c, $00
	oam_sprite $20, $40, $1e, $00
	oam_sprite $10, $48, $20, $00
	oam_sprite $20, $48, $22, $00
	oam_sprite $10, $50, $24, $00
	oam_sprite $20, $50, $26, $00
	oam_sprite_end
PlayScreenSequence1:
	call SetupScreen1Assets ; $77bb
	call InitObjectSceneA ; $77be
	ld a, $01 ; $77c1
	ld hl, TaskDrawObjectSprites_18 ; $77c3
	call RegisterFrameTask ; $77c6
	ld a, $01 ; $77c9
	ld hl, TaskUpdateObjects_18 ; $77cb
	call RegisterFrameTask ; $77ce
	sound $2c ; $77d1
	call EnableLCD ; $77d3
	script_fade_in $02 ; $77d6
	call WaitFadeEnd ; $77db
	wram_bank $03 ; $77de
	xor a, a ; $77e4
	ld [$da01], a ; $77e5
.scrollLoop:
	call AdvanceFrame ; $77e8
	ldh a, [hVBlankCounter] ; $77eb
	and a, $03 ; $77ed
	jr nz, .scrollLoop ; $77ef
	ld a, [$da01] ; $77f1
	inc a ; $77f4
	ld [$da01], a ; $77f5
	cp a, $af ; $77f8
	jr nz, .scrollLoop ; $77fa
	ld c, $01 ; $77fc
	call BeginFadeOut ; $77fe
	call WaitFadeEnd ; $7801
	call ClearFrameTasks ; $7804
	call DisableLCDSafely ; $7807
	farcall RunScrollingTextScreen ; $780a
	call DisableLCDSafely ; $780d
	call LoadScreen1ObjTiles ; $7810
	call FillAllBgPalettes ; $7813
	ld a, $01 ; $7816
	ld hl, QueueScreen1Sprites ; $7818
	call RegisterFrameTask ; $781b
	call EnableLCD ; $781e
	script_fade_in $40 ; $7821
	call WaitFadeEnd ; $7826
	sound $2d ; $7829
.waitInput:
	call AdvanceFrame ; $782b
	ldh a, [hInputPressed] ; $782e
	and a, PADF_A | PADF_B ; $7830
	jr z, .waitInput ; $7832
	ret ; $7834
SetupScreen1Assets:
	call ResetScrollAndCamera ; $7835
	call LookupScreen1AssetId ; $7838
	farcall LoadScreenAssetRecord ; $783b
	farcall QueueWram3MapToVRAM ; $783e
	ret ; $7841
LookupScreen1AssetId:
	ld a, [wStorySceneAssetIndex] ; $7842
	ld hl, Screen1AssetIdTable ; $7845
	add a, l ; $7848
	ld l, a ; $7849
	jr nc, .read ; $784a
	inc h ; $784c
.read:
	ld c, [hl] ; $784d
	ret ; $784e
Screen1AssetIdTable:
	; $784f, 6 bytes (bytes:6)
	db $32, $33, $35, $34, $36, $37 ; 0x00
FillAllBgPalettes:
	call ResetScrollAndCamera ; $7855
	ld c, $32 ; $7858
	farcall LoadScreenAssetRecord ; $785a
	ld hl, Palette_18_78a9 ; $785d
	ld de, $0001 ; $7860
	call LoadPaletteShadow ; $7863
	ld hl, Palette_18_78a9 ; $7866
	ld de, $0101 ; $7869
	call LoadPaletteShadow ; $786c
	ld hl, Palette_18_78a9 ; $786f
	ld de, $0201 ; $7872
	call LoadPaletteShadow ; $7875
	ld hl, Palette_18_78a9 ; $7878
	ld de, $0301 ; $787b
	call LoadPaletteShadow ; $787e
	ld hl, Palette_18_78a9 ; $7881
	ld de, $0401 ; $7884
	call LoadPaletteShadow ; $7887
	ld hl, Palette_18_78a9 ; $788a
	ld de, $0501 ; $788d
	call LoadPaletteShadow ; $7890
	ld hl, Palette_18_78a9 ; $7893
	ld de, $0601 ; $7896
	call LoadPaletteShadow ; $7899
	ld hl, Palette_18_78a9 ; $789c
	ld de, $0701 ; $789f
	call LoadPaletteShadow ; $78a2
	farcall QueueWram3MapToVRAM ; $78a5
	ret ; $78a8
Palette_18_78a9:
	INCLUDE "data/bank_018/palettes_78a9.asm" ; $78a9, 8 bytes (palettes)
LoadScreen1ObjTiles:
	ld b, $07 ; $78b1
	ld c, $28 ; $78b3
	ld de, $8000 ; $78b5
	farcall LoadCompressedTileBlock ; $78b8
	ld hl, Palette_18_78c5 ; $78bb
	ld de, $0801 ; $78be
	call LoadPaletteShadow ; $78c1
	ret ; $78c4
Palette_18_78c5:
	INCLUDE "data/bank_018/palettes_78c5.asm" ; $78c5, 8 bytes (palettes)
QueueScreen1Sprites:
	ld hl, SpriteTemplate_18_78db ; $78cd
	ld de, $283a ; $78d0
	ld c, $00 ; $78d3
	ld b, $00 ; $78d5
	call QueueSpriteTemplate ; $78d7
	ret ; $78da
SpriteTemplate_18_78db:
	; $78db, 81 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite $10, $28, $10, $00
	oam_sprite $20, $28, $12, $00
	oam_sprite $10, $30, $14, $00
	oam_sprite $20, $30, $16, $00
	oam_sprite $10, $38, $18, $00
	oam_sprite $20, $38, $1a, $00
	oam_sprite $10, $40, $1c, $00
	oam_sprite $20, $40, $1e, $00
	oam_sprite $10, $48, $20, $00
	oam_sprite $20, $48, $22, $00
	oam_sprite $10, $50, $24, $00
	oam_sprite $20, $50, $26, $00
	oam_sprite_end
PlayScreenSequence2:
	call ResetScrollAndCamera ; $792c
	sound $09 ; $792f
	call LookupScreen2AssetIdA ; $7931
	farcall LoadScreenAssetRecord ; $7934
	farcall QueueWram3MapToVRAM ; $7937
	call InitObjectSceneB ; $793a
	ld a, $01 ; $793d
	ld hl, TaskDrawObjectSprites_18 ; $793f
	call RegisterFrameTask ; $7942
	ld a, $01 ; $7945
	ld hl, TaskUpdateObjects_18 ; $7947
	call RegisterFrameTask ; $794a
	call EnableLCD ; $794d
	script_fade_in $01 ; $7950
	call WaitFadeEnd ; $7955
.scene1:
	call AdvanceFrame ; $7958
	ldh a, [hInputPressed] ; $795b
	and a, PADF_A | PADF_B ; $795d
	jr z, .scene1 ; $795f
	ld c, $02 ; $7961
	call BeginFadeOut ; $7963
	call WaitFadeEnd ; $7966
	ld de, $05e0 ; $7969
	call TestGameFlag ; $796c
	jr z, .scene2 ; $796f
	ld de, $1700 ; $7971
	call TestGameFlag ; $7974
	jr z, .scene2Wait ; $7977
	jr .scene3 ; $7979
.scene2:
	ld de, $16e0 ; $797b
	call TestGameFlag ; $797e
	jr z, .scene2Wait ; $7981
	jr .scene3 ; $7983
.scene2Wait:
	sound $2c ; $7985
	farcall RunEndingCreditsSequence ; $7987
.scene3:
	wram_bank $03 ; $798a
	xor a, a ; $7990
	ld [$da00], a ; $7991
	call ClearFrameTasks ; $7994
	call ResetScrollAndCamera ; $7997
	call DisableLCDSafely ; $799a
	call LookupScreen2AssetIdB ; $799d
	farcall LoadScreenAssetRecord ; $79a0
	farcall QueueWram3MapToVRAM ; $79a3
	call LoadScreen2ObjTiles ; $79a6
	call EnableLCD ; $79a9
	script_fade_in $02 ; $79ac
	call WaitFadeEnd ; $79b1
	wram_bank $03 ; $79b4
	xor a, a ; $79ba
	ld [$da01], a ; $79bb
.scene4:
	call AdvanceFrame ; $79be
	ld a, [$da01] ; $79c1
	inc a ; $79c4
	ld [$da01], a ; $79c5
	cp a, $b4 ; $79c8
	jr nz, .scene4 ; $79ca
	ld a, $01 ; $79cc
	ld hl, TaskFadeInPalette_18 ; $79ce
	call RegisterFrameTask ; $79d1
	ld a, $01 ; $79d4
	ld hl, QueueScreen2Sprites ; $79d6
	call RegisterFrameTask ; $79d9
	sound $2d ; $79dc
.scene5:
	call AdvanceFrame ; $79de
	ldh a, [hInputPressed] ; $79e1
	and a, PADF_A | PADF_B ; $79e3
	jr z, .scene5 ; $79e5
	ld de, SAVEFLAG_OPENING_SEEN ; $79e7
	farcall SetSaveFlag ; $79ea
	ld de, $05e0 ; $79ed
	call TestGameFlag ; $79f0
	jr z, .fadeOut ; $79f3
	ld de, $1700 ; $79f5
	call SetGameFlag ; $79f8
	jr .done ; $79fb
.fadeOut:
	ld de, $16e0 ; $79fd
	call SetGameFlag ; $7a00
.done:
	farcall SaveStorySlotWithTimer ; $7a03
	ret ; $7a06
LookupScreen2AssetIdA:
	ld a, [wStorySceneAssetIndex] ; $7a07
	ld hl, Screen2AssetIdATable ; $7a0a
	add a, l ; $7a0d
	ld l, a ; $7a0e
	jr nc, .read ; $7a0f
	inc h ; $7a11
.read:
	ld c, [hl] ; $7a12
	ret ; $7a13
Screen2AssetIdATable:
	; $7a14, 6 bytes (bytes:6)
	db $38, $39, $3b, $3a, $3c, $3d ; 0x00
LookupScreen2AssetIdB:
	ld a, [wStorySceneAssetIndex] ; $7a1a
	ld hl, Screen2AssetIdBTable ; $7a1d
	add a, l ; $7a20
	ld l, a ; $7a21
	jr nc, .read ; $7a22
	inc h ; $7a24
.read:
	ld c, [hl] ; $7a25
	ret ; $7a26
Screen2AssetIdBTable:
	; $7a27, 6 bytes (bytes:6)
	db $3e, $3f, $41, $40, $42, $43 ; 0x00
LoadScreen2ObjTiles:
	ld b, $08 ; $7a2d
	ld c, $14 ; $7a2f
	ld de, $8000 ; $7a31
	farcall LoadCompressedTileBlock ; $7a34
	ld hl, Palette_18_7a41 ; $7a37
	ld de, $0801 ; $7a3a
	call LoadPaletteShadow ; $7a3d
	ret ; $7a40
Palette_18_7a41:
	INCLUDE "data/bank_018/palettes_7a41.asm" ; $7a41, 8 bytes (palettes)
QueueScreen2Sprites:
	ld hl, SpriteTemplate_18_7a57 ; $7a49
	ld de, $2840 ; $7a4c
	ld c, $00 ; $7a4f
	ld b, $00 ; $7a51
	call QueueSpriteTemplate ; $7a53
	ret ; $7a56
SpriteTemplate_18_7a57:
	; $7a57, 41 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite $10, $48, $10, $00
	oam_sprite $10, $50, $12, $00
	oam_sprite_end
	ret ; $7a80
TaskFadeInPalette_18:
	ldh a, [hWramBank] ; $7a81
	push af ; $7a83
	wram_bank $03 ; $7a84
	ld a, [$da00] ; $7a8a
	cp a, $10 ; $7a8d
	jr z, .alt2 ; $7a8f
	add a, a ; $7a91
	add a, a ; $7a92
	add a, a ; $7a93
	ld hl, PaletteFadeTable_18 ; $7a94
	add a, l ; $7a97
	ld l, a ; $7a98
	jr nc, .read ; $7a99
	inc h ; $7a9b
.read:
	ld de, $0801 ; $7a9c
	call LoadPalettesImmediate ; $7a9f
	ldh a, [hVBlankCounter] ; $7aa2
	and a, $03 ; $7aa4
	jr nz, .alt2 ; $7aa6
	ld a, [$da00] ; $7aa8
	inc a ; $7aab
	ld [$da00], a ; $7aac
.alt2:
	pop af ; $7aaf
	wram_bank ; $7ab0
	ret ; $7ab4
PaletteFadeTable_18:
	INCLUDE "data/bank_018/palettes_7ab5.asm" ; $7ab5, 129 bytes (palettes)
TaskDrawObjectSprites_18:
	ld c, $00 ; $7b36
.objectLoop:
	push bc ; $7b38
	ld hl, $d800 ; $7b39
	ld a, c ; $7b3c
	add a, a ; $7b3d
	add a, a ; $7b3e
	add a, a ; $7b3f
	add a, a ; $7b40
	add a, l ; $7b41
	ld l, a ; $7b42
	jr nc, .read ; $7b43
	inc h ; $7b45
.read:
	ld a, [hl+] ; $7b46
	ld b, a ; $7b47
	inc hl ; $7b48
	ld a, [hl+] ; $7b49
	ld d, a ; $7b4a
	inc hl ; $7b4b
	ld a, [hl+] ; $7b4c
	ld e, a ; $7b4d
	inc hl ; $7b4e
	inc hl ; $7b4f
	ld a, [hl] ; $7b50
	ld c, a ; $7b51
	push af ; $7b52
	push bc ; $7b53
	push de ; $7b54
	push hl ; $7b55
	call QueueSprite ; $7b56
	pop hl ; $7b59
	pop de ; $7b5a
	pop bc ; $7b5b
	pop af ; $7b5c
	ld a, $08 ; $7b5d
	add a, d ; $7b5f
	ld d, a ; $7b60
	inc c ; $7b61
	inc c ; $7b62
	call QueueSprite ; $7b63
	pop bc ; $7b66
	inc c ; $7b67
	ld a, c ; $7b68
	cp a, $10 ; $7b69
	jr nz, .objectLoop ; $7b6b
	ret ; $7b6d
TaskUpdateObjects_18:
	ld c, $00 ; $7b6e
.objectLoop:
	push bc ; $7b70
	ld hl, $d800 ; $7b71
	ld a, c ; $7b74
	add a, a ; $7b75
	add a, a ; $7b76
	add a, a ; $7b77
	add a, a ; $7b78
	add a, l ; $7b79
	ld l, a ; $7b7a
	jr nc, .updateObject ; $7b7b
	inc h ; $7b7d
.updateObject:
	ld b, h ; $7b7e
	ld c, l ; $7b7f
	ld hl, $0005 ; $7b80
	add hl, bc ; $7b83
	ld a, [hl] ; $7b84
	ld e, a ; $7b85
	ld hl, $0001 ; $7b86
	add hl, bc ; $7b89
	ld a, [hl+] ; $7b8a
	ld h, [hl] ; $7b8b
	ld l, a ; $7b8c
	ld d, $00 ; $7b8d
	add hl, de ; $7b8f
	ld d, h ; $7b90
	ld e, l ; $7b91
	ld hl, $0001 ; $7b92
	add hl, bc ; $7b95
	ld [hl], e ; $7b96
	inc hl ; $7b97
	ld [hl], d ; $7b98
	ld hl, $0006 ; $7b99
	add hl, bc ; $7b9c
	ld a, [hl] ; $7b9d
	ld e, a ; $7b9e
	ld hl, $0003 ; $7b9f
	add hl, bc ; $7ba2
	ld a, [hl+] ; $7ba3
	ld h, [hl] ; $7ba4
	ld l, a ; $7ba5
	ld d, $00 ; $7ba6
	add hl, de ; $7ba8
	ld d, h ; $7ba9
	ld e, l ; $7baa
	ld hl, $0003 ; $7bab
	add hl, bc ; $7bae
	ld [hl], e ; $7baf
	inc hl ; $7bb0
	ld [hl], d ; $7bb1
	ld hl, $0009 ; $7bb2
	add hl, bc ; $7bb5
	ld a, [hl+] ; $7bb6
	ld h, [hl] ; $7bb7
	ld l, a ; $7bb8
	jp hl ; $7bb9
	ld hl, $0004 ; $7bba
	add hl, bc ; $7bbd
	ld a, [hl] ; $7bbe
	cp a, $c0 ; $7bbf
	jr c, .next ; $7bc1
	ld a, $10 ; $7bc3
	ld [hl], a ; $7bc5
.next:
	pop bc ; $7bc6
	inc c ; $7bc7
	ld a, c ; $7bc8
	cp a, $10 ; $7bc9
	jr nz, .objectLoop ; $7bcb
	ret ; $7bcd
InitObjectSceneA:
	ldh a, [hWramBank] ; $7bce
	push af ; $7bd0
	wram_bank $03 ; $7bd1
	ld hl, $d800 ; $7bd7
	ld bc, $0100 ; $7bda
	call ClearBytes ; $7bdd
	call PopulateObjectArrayA ; $7be0
	call LoadObjectSceneATiles ; $7be3
	ret ; $7be6
LoadObjectSceneATiles:
	ld b, $00 ; $7be7
	ld c, $10 ; $7be9
	ld de, $8000 ; $7beb
	farcall LoadCompressedTileBlock ; $7bee
	ld b, $01 ; $7bf1
	ld c, $10 ; $7bf3
	ld de, $8100 ; $7bf5
	farcall LoadCompressedTileBlock ; $7bf8
	ld b, $02 ; $7bfb
	ld c, $10 ; $7bfd
	ld de, $8200 ; $7bff
	farcall LoadCompressedTileBlock ; $7c02
	ld hl, ObjectSceneATilesPalettes ; $7c05
	ld de, $0903 ; $7c08
	call LoadPaletteShadow ; $7c0b
	ret ; $7c0e
ObjectSceneATilesPalettes:
	; $7c0f, 24 bytes (bytes:8)
	db $ff, $6b, $df, $5a, $ff, $20, $00, $00 ; 0x00
	db $ff, $6b, $b8, $3b, $80, $12, $00, $00 ; 0x08
	db $ff, $6b, $bf, $53, $9f, $02, $00, $00 ; 0x10
PopulateObjectArrayA:
	ld c, $00 ; $7c27
	ld hl, ObjectSpawnTable_18_7c53 ; $7c29
	ld de, $d800 ; $7c2c
.spawnLoop:
	push af ; $7c2f
	push bc ; $7c30
	push de ; $7c31
	push hl ; $7c32
	ld bc, $000b ; $7c33
	call CopyMemoryBC ; $7c36
	pop hl ; $7c39
	pop de ; $7c3a
	pop bc ; $7c3b
	pop af ; $7c3c
	push hl ; $7c3d
	ld hl, $0010 ; $7c3e
	add hl, de ; $7c41
	ld d, h ; $7c42
	ld e, l ; $7c43
	pop hl ; $7c44
	ld a, $0b ; $7c45
	add a, l ; $7c47
	ld l, a ; $7c48
	jr nc, .read ; $7c49
	inc h ; $7c4b
.read:
	inc c ; $7c4c
	ld a, c ; $7c4d
	cp a, $10 ; $7c4e
	jr nz, .spawnLoop ; $7c50
	ret ; $7c52
ObjectSpawnTable_18_7c53:
	; $7c53, 176 bytes (records:11)
; 16 records x 11 bytes
	db $01, $00, $14, $00, $00, $40, $a0, $00, $00, $38, $7e ; record 0
	db $02, $00, $24, $00, $18, $50, $c3, $04, $01, $38, $7e ; record 1
	db $03, $00, $a3, $00, $3c, $45, $85, $08, $02, $38, $7e ; record 2
	db $01, $00, $d0, $00, $00, $70, $ff, $0c, $01, $38, $7e ; record 3
	db $02, $00, $54, $00, $24, $40, $b3, $10, $03, $38, $7e ; record 4
	db $03, $00, $48, $00, $48, $80, $c5, $14, $01, $38, $7e ; record 5
	db $01, $00, $9c, $00, $24, $30, $d2, $18, $00, $38, $7e ; record 6
	db $02, $00, $66, $00, $10, $45, $82, $1c, $01, $38, $7e ; record 7
	db $03, $00, $44, $00, $14, $61, $90, $20, $03, $38, $7e ; record 8
	db $01, $00, $c2, $00, $28, $4f, $a4, $24, $00, $38, $7e ; record 9
	db $02, $00, $5a, $00, $4c, $43, $55, $28, $01, $38, $7e ; record 10
	db $03, $00, $30, $00, $60, $42, $b4, $2c, $02, $38, $7e ; record 11
	db $01, $00, $63, $00, $44, $64, $f0, $00, $01, $38, $7e ; record 12
	db $02, $00, $18, $00, $98, $34, $52, $00, $02, $38, $7e ; record 13
	db $03, $00, $8c, $00, $0c, $45, $c0, $00, $01, $38, $7e ; record 14
	db $01, $00, $a0, $00, $30, $55, $a0, $00, $00, $38, $7e ; record 15
InitObjectSceneB:
	ldh a, [hWramBank] ; $7d03
	push af ; $7d05
	wram_bank $03 ; $7d06
	ld hl, $d800 ; $7d0c
	ld bc, $0100 ; $7d0f
	call ClearBytes ; $7d12
	call PopulateObjectArrayB ; $7d15
	call LoadObjectSceneBTiles ; $7d18
	ret ; $7d1b
LoadObjectSceneBTiles:
	ld b, $03 ; $7d1c
	ld c, $10 ; $7d1e
	ld de, $8000 ; $7d20
	farcall LoadCompressedTileBlock ; $7d23
	ld b, $04 ; $7d26
	ld c, $10 ; $7d28
	ld de, $8100 ; $7d2a
	farcall LoadCompressedTileBlock ; $7d2d
	ld b, $05 ; $7d30
	ld c, $10 ; $7d32
	ld de, $8200 ; $7d34
	farcall LoadCompressedTileBlock ; $7d37
	ld hl, Palette_18_7d44 ; $7d3a
	ld de, $0903 ; $7d3d
	call LoadPaletteShadow ; $7d40
	ret ; $7d43
Palette_18_7d44:
	INCLUDE "data/bank_018/palettes_7d44.asm" ; $7d44, 24 bytes (palettes)
PopulateObjectArrayB:
	ld c, $00 ; $7d5c
	ld hl, ObjectSpawnTable_18_7d88 ; $7d5e
	ld de, $d800 ; $7d61
.spawnLoop:
	push af ; $7d64
	push bc ; $7d65
	push de ; $7d66
	push hl ; $7d67
	ld bc, $000b ; $7d68
	call CopyMemoryBC ; $7d6b
	pop hl ; $7d6e
	pop de ; $7d6f
	pop bc ; $7d70
	pop af ; $7d71
	push hl ; $7d72
	ld hl, $0010 ; $7d73
	add hl, de ; $7d76
	ld d, h ; $7d77
	ld e, l ; $7d78
	pop hl ; $7d79
	ld a, $0b ; $7d7a
	add a, l ; $7d7c
	ld l, a ; $7d7d
	jr nc, .read ; $7d7e
	inc h ; $7d80
.read:
	inc c ; $7d81
	ld a, c ; $7d82
	cp a, $10 ; $7d83
	jr nz, .spawnLoop ; $7d85
	ret ; $7d87
ObjectSpawnTable_18_7d88:
	INCBIN "data/bank_018/d_7d88.bin" ; $7d88, 365 bytes
	; $7ef5, 267 bytes fill to bank end (linker-padded)
