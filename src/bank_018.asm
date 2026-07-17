SECTION "ROM Bank $18", ROMX[$4000], BANK[$18]

FarPtr_18_00:
	dw Func_18_4328 ; $4000
FarPtr_18_02:
	dw Func_18_4339 ; $4002
FarPtr_18_04:
	dw Func_18_439a ; $4004
FarPtr_18_06:
	dw Func_18_437c ; $4006
FarPtr_18_08:
	dw Func_18_438d ; $4008
FarPtr_DrawBox:
	dw DrawBox ; $400a
FarPtr_FlushBgMapShadowToVram:
	dw FlushBgMapShadowToVram ; $400c
FarPtr_18_0e:
	dw Func_18_43a6 ; $400e
FarPtr_DrawStringToTilemap:
	dw DrawStringToTilemap ; $4010
FarPtr_18_12:
	dw Func_18_4444 ; $4012
FarPtr_18_14:
	dw Func_18_4478 ; $4014
FarPtr_18_16:
	dw Func_18_449b ; $4016
FarPtr_18_18:
	dw Func_18_44ee ; $4018
FarPtr_DrawDecimalNumberToTilemap:
	dw DrawDecimalNumberToTilemap ; $401a
FarPtr_18_1c:
	dw Func_18_44ef ; $401c
FarPtr_18_1e:
	dw Func_18_5a6a ; $401e
FarPtr_18_20:
	dw Func_18_59c1 ; $4020
FarPtr_18_22:
	dw Func_18_59d6 ; $4022
FarPtr_18_24:
	dw Func_18_4507 ; $4024
FarPtr_18_26:
	dw Func_18_452a ; $4026
FarPtr_18_28:
	dw Func_18_4557 ; $4028
FarPtr_18_2a:
	dw Func_18_45ca ; $402a
FarPtr_18_2c:
	dw Func_18_463b ; $402c
FarPtr_ForceFlushBgMapToVram:
	dw ForceFlushBgMapToVram ; $402e
FarPtr_18_30:
	dw Func_18_5365 ; $4030
FarPtr_18_32:
	dw Func_18_5421 ; $4032
FarPtr_18_34:
	dw Func_18_5469 ; $4034
FarPtr_18_36:
	dw Func_18_52de ; $4036
FarPtr_18_38:
	dw Func_18_537a ; $4038
FarPtr_18_3a:
	dw Func_18_5372 ; $403a
FarPtr_18_3c:
	dw Func_18_5379 ; $403c
FarPtr_DrawDecimalNumberSprites:
	dw DrawDecimalNumberSprites ; $403e
FarPtr_18_40:
	dw Func_18_5561 ; $4040
FarPtr_18_42:
	dw Func_18_5586 ; $4042
FarPtr_LoadOnCourtCharTilesA:
	dw LoadOnCourtCharTilesA ; $4044
FarPtr_LoadOnCourtCharTilesB:
	dw LoadOnCourtCharTilesB ; $4046
DataPtr_18_48:
	dw Lz_18_6b30 ; $4048
DataPtr_18_4a:
	dw Lz_18_6b73 ; $404a
DataPtr_18_4c:
	dw Lz_18_6bb5 ; $404c
DataPtr_18_4e:
	dw Lz_18_6bf3 ; $404e
DataPtr_18_50:
	dw Lz_18_6c23 ; $4050
DataPtr_18_52:
	dw Lz_18_6c4f ; $4052
DataPtr_18_54:
	dw Lz_18_6c7d ; $4054
DataPtr_18_56:
	dw Lz_18_6cb8 ; $4056
DataPtr_18_58:
	dw Lz_18_6cf9 ; $4058
DataPtr_18_5a:
	dw Lz_18_6d3c ; $405a
DataPtr_18_5c:
	dw Lz_18_6d7d ; $405c
DataPtr_18_5e:
	dw Lz_18_6db9 ; $405e
DataPtr_18_60:
	dw Lz_18_6deb ; $4060
DataPtr_18_62:
	dw Lz_18_6e18 ; $4062
DataPtr_18_64:
	dw Lz_18_6e4b ; $4064
DataPtr_18_66:
	dw Lz_18_6e88 ; $4066
DataPtr_18_68:
	dw Lz_18_6eca ; $4068
DataPtr_18_6a:
	dw Lz_18_6f13 ; $406a
DataPtr_18_6c:
	dw Lz_18_6f57 ; $406c
DataPtr_18_6e:
	dw Lz_18_6f97 ; $406e
DataPtr_18_70:
	dw Lz_18_6fd2 ; $4070
DataPtr_18_72:
	dw Lz_18_7007 ; $4072
DataPtr_18_74:
	dw Lz_18_7040 ; $4074
DataPtr_18_76:
	dw Lz_18_7082 ; $4076
DataPtr_18_78:
	dw Lz_18_70cb ; $4078
DataPtr_18_7a:
	dw Lz_18_7112 ; $407a
DataPtr_18_7c:
	dw Lz_18_7156 ; $407c
DataPtr_18_7e:
	dw Lz_18_7198 ; $407e
DataPtr_18_80:
	dw Lz_18_71d8 ; $4080
DataPtr_18_82:
	dw Lz_18_7212 ; $4082
DataPtr_18_84:
	dw Lz_18_724e ; $4084
DataPtr_18_86:
	dw Lz_18_7292 ; $4086
DataPtr_MarioMiniGamesTilemap:
	dw MarioMiniGamesTilemap ; $4088
DataPtr_MarioMiniGamesAttrmap:
	dw MarioMiniGamesAttrmap ; $408a
DataPtr_MarioMiniGamesPalettes:
	dw MarioMiniGamesPalettes ; $408c
FarPtr_18_8e:
	dw Func_18_7617 ; $408e
	INCBIN "data/bank_018/d_4090.bin" ; $4090, 664 bytes
Func_18_4328:
	push af ; $4328
	push bc ; $4329
	push de ; $432a
	push hl ; $432b
	ld hl, $4300 ; $432c
	ld e, $05 ; $432f
	call LoadPaletteShadow ; $4331
	pop hl ; $4334
	pop de ; $4335
	pop bc ; $4336
	pop af ; $4337
	ret ; $4338
Func_18_4339:
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
	ld a, [$cb61] ; $4353
	and a, $0f ; $4356
	jr z, Label_18_4365 ; $4358
	ld hl, $d800 ; $435a
	ld de, $9800 ; $435d
	ld c, $24 ; $4360
	call QueueVRAMCopy ; $4362
Label_18_4365:
	ld a, [$cb61] ; $4365
	and a, $f0 ; $4368
	jr z, Label_18_4377 ; $436a
	ld hl, $dc00 ; $436c
	ld de, $b800 ; $436f
	ld c, $24 ; $4372
	call QueueVRAMCopy ; $4374
Label_18_4377:
	xor a, a ; $4377
	ld [$cb61], a ; $4378
	ret ; $437b
Func_18_437c:
	push hl ; $437c
	ld hl, $42e0 ; $437d
	call LoadPaletteShadow ; $4380
	pop de ; $4383
	ld hl, $42a0 ; $4384
	ld c, $04 ; $4387
	call QueueVRAMCopy ; $4389
	ret ; $438c
Func_18_438d:
	ret ; $438d
	ld hl, $40a0 ; $438e
	ld de, $9000 ; $4391
	ld c, $10 ; $4394
	call QueueVRAMCopy ; $4396
	ret ; $4399
Func_18_439a:
	push bc ; $439a
	ld c, $20 ; $439b
	farcall FarPtr_RenderProportionalTextAt ; $439d
	pop bc ; $43a0
	ret ; $43a1
DrawStringToTilemap:
	farcall FarPtr_WriteStringToTilemap ; $43a2
	ret ; $43a5
Func_18_43a6:
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
Label_18_43cf:
	push bc ; $43cf
	push de ; $43d0
	push hl ; $43d1
Label_18_43d2:
	ld a, $20 ; $43d2
	ld [hl+], a ; $43d4
	ld a, $00 ; $43d5
	ld [de], a ; $43d7
	inc de ; $43d8
	dec b ; $43d9
	jr nz, Label_18_43d2 ; $43da
	pop hl ; $43dc
	pop de ; $43dd
	pop bc ; $43de
	ld a, $20 ; $43df
	add a, l ; $43e1
	ld l, a ; $43e2
	jr nc, Label_18_43e6 ; $43e3
	inc h ; $43e5
Label_18_43e6:
	ld a, $20 ; $43e6
	add a, e ; $43e8
	ld e, a ; $43e9
	jr nc, Label_18_43ed ; $43ea
	inc d ; $43ec
Label_18_43ed:
	dec c ; $43ed
	jr nz, Label_18_43cf ; $43ee
	pop hl ; $43f0
	pop de ; $43f1
	pop bc ; $43f2
	call DrawBoxTopRow ; $43f3
	ld a, $20 ; $43f6
	add a, l ; $43f8
	ld l, a ; $43f9
	jr nc, Label_18_43fd ; $43fa
	inc h ; $43fc
Label_18_43fd:
	dec c ; $43fd
	dec c ; $43fe
Label_18_43ff:
	call DrawBoxSideRow ; $43ff
	ld a, $20 ; $4402
	add a, l ; $4404
	ld l, a ; $4405
	jr nc, Label_18_4409 ; $4406
	inc h ; $4408
Label_18_4409:
	dec c ; $4409
	jr nz, Label_18_43ff ; $440a
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
Label_18_441b:
	ld a, $03 ; $441b
	ld [hl+], a ; $441d
	dec b ; $441e
	jr nz, Label_18_441b ; $441f
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
	jr nc, Label_18_4431 ; $442e
	inc h ; $4430
Label_18_4431:
	ld [hl], $06 ; $4431
	pop hl ; $4433
	ret ; $4434
DrawBoxBottomRow:
	ld a, $07 ; $4435
	ld [hl+], a ; $4437
	dec b ; $4438
	dec b ; $4439
Label_18_443a:
	ld a, $08 ; $443a
	ld [hl+], a ; $443c
	dec b ; $443d
	jr nz, Label_18_443a ; $443e
	ld a, $09 ; $4440
	ld [hl+], a ; $4442
	ret ; $4443
Func_18_4444:
	push af ; $4444
	push hl ; $4445
	ldh a, [hVBlankCounter] ; $4446
	and a, $0f ; $4448
	add a, $68 ; $444a
	ld l, a ; $444c
	adc a, $44 ; $444d
	sub a, l ; $444f
	ld h, a ; $4450
	ld a, [hl] ; $4451
	add a, d ; $4452
	ld d, a ; $4453
	ldh a, [hVBlankCounter] ; $4454
	add a, $04 ; $4456
	and a, $0f ; $4458
	add a, $68 ; $445a
	ld l, a ; $445c
	adc a, $44 ; $445d
	sub a, l ; $445f
	ld h, a ; $4460
	ld a, [hl] ; $4461
	cpl ; $4462
	add a, e ; $4463
	ld e, a ; $4464
	pop af ; $4465
	pop hl ; $4466
	ret ; $4467
	; $4468, 16 bytes (bytes:16)
	db $00, $01, $01, $01, $02, $02, $03, $04, $03, $02, $02, $01, $01, $01, $00, $00 ; 0x00
Func_18_4478:
	push af ; $4478
	push hl ; $4479
	ldh a, [hVBlankCounter] ; $447a
	and a, $0f ; $447c
	add a, $8b ; $447e
	ld l, a ; $4480
	adc a, $44 ; $4481
	sub a, l ; $4483
	ld h, a ; $4484
	ld a, [hl] ; $4485
	add a, e ; $4486
	ld e, a ; $4487
	pop af ; $4488
	pop hl ; $4489
	ret ; $448a
	INCBIN "data/bank_018/d_448b.bin" ; $448b, 16 bytes
Func_18_449b:
	push af ; $449b
	push hl ; $449c
	ldh a, [hVBlankCounter] ; $449d
	and a, $3f ; $449f
	add a, $ae ; $44a1
	ld l, a ; $44a3
	adc a, $44 ; $44a4
	sub a, l ; $44a6
	ld h, a ; $44a7
	ld a, [hl] ; $44a8
	add a, e ; $44a9
	ld e, a ; $44aa
	pop af ; $44ab
	pop hl ; $44ac
	ret ; $44ad
	INCBIN "data/bank_018/d_44ae.bin" ; $44ae, 64 bytes
Func_18_44ee:
	ret ; $44ee
Func_18_44ef:
	push af ; $44ef
	push bc ; $44f0
	ld b, a ; $44f1
Label_18_44f2:
	ld a, [hl] ; $44f2
	cp a, b ; $44f3
	jr z, Label_18_4503 ; $44f4
	cp a, $ff ; $44f6
	jr z, Label_18_4503 ; $44f8
	ld a, $08 ; $44fa
	add a, l ; $44fc
	ld l, a ; $44fd
	jr nc, Label_18_4501 ; $44fe
	inc h ; $4500
Label_18_4501:
	jr Label_18_44f2 ; $4501
Label_18_4503:
	add hl, de ; $4503
	pop bc ; $4504
	pop af ; $4505
	ret ; $4506
Func_18_4507:
	cp a, $84 ; $4507
	jr z, Label_18_4522 ; $4509
	push af ; $450b
	push bc ; $450c
	push de ; $450d
	push hl ; $450e
	farcall FarPtr_02_1a ; $450f
	ld hl, $ca80 ; $4512
	ld de, $d580 ; $4515
	ld c, $08 ; $4518
	call CopyMemoryFast ; $451a
	pop hl ; $451d
	pop de ; $451e
	pop bc ; $451f
	pop af ; $4520
	ret ; $4521
Label_18_4522:
	push af ; $4522
	ld a, $3e ; $4523
	ld [$d58b], a ; $4525
	pop af ; $4528
	ret ; $4529
Func_18_452a:
	bit 7, a ; $452a
	jr z, Label_18_4534 ; $452c
	ld a, [$d58b] ; $452e
	cp a, $ff ; $4531
	ret ; $4533
Label_18_4534:
	cp a, $04 ; $4534
	jr nc, Label_18_453b ; $4536
	cp a, $ff ; $4538
	ret ; $453a
Label_18_453b:
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
	farcall FarPtr_TestSaveFlag ; $4547
	pop de ; $454a
	pop hl ; $454b
	ret ; $454c
	cp a, $10 ; $454d
	jr nc, Label_18_4555 ; $454f
	ld a, $01 ; $4551
	and a, a ; $4553
	ret ; $4554
Label_18_4555:
	xor a, a ; $4555
	ret ; $4556
Func_18_4557:
	bit 7, a ; $4557
	jr z, Label_18_4564 ; $4559
	cp a, $84 ; $455b
	jr nz, Label_18_4562 ; $455d
	cp a, $ff ; $455f
	ret ; $4561
Label_18_4562:
	xor a, a ; $4562
	ret ; $4563
Label_18_4564:
	push hl ; $4564
	push de ; $4565
	ld hl, $458a ; $4566
	add a, a ; $4569
	add a, l ; $456a
	ld l, a ; $456b
	jr nc, Label_18_456f ; $456c
	inc h ; $456e
Label_18_456f:
	ld a, [hl+] ; $456f
	ld d, [hl] ; $4570
	ld e, a ; $4571
	or a, d ; $4572
	jr nz, Label_18_4579 ; $4573
	cp a, $ff ; $4575
	jr Label_18_4587 ; $4577
Label_18_4579:
	bit 0, e ; $4579
	jr nz, Label_18_4582 ; $457b
	call TestGameFlag ; $457d
	jr Label_18_4587 ; $4580
Label_18_4582:
	res 0, e ; $4582
	farcall FarPtr_TestSaveFlag ; $4584
Label_18_4587:
	pop de ; $4587
	pop hl ; $4588
	ret ; $4589
	INCBIN "data/bank_018/d_458a.bin" ; $458a, 64 bytes
Func_18_45ca:
	bit 5, b ; $45ca
	jr z, Label_18_45d1 ; $45cc
	dec d ; $45ce
	jr Label_18_45e4 ; $45cf
Label_18_45d1:
	bit 4, b ; $45d1
	jr z, Label_18_45d8 ; $45d3
	inc d ; $45d5
	jr Label_18_45e4 ; $45d6
Label_18_45d8:
	bit 6, b ; $45d8
	jr z, Label_18_45df ; $45da
	dec e ; $45dc
	jr Label_18_45e4 ; $45dd
Label_18_45df:
	bit 7, b ; $45df
	jr z, Label_18_45e4 ; $45e1
	inc e ; $45e3
Label_18_45e4:
	ld a, d ; $45e4
	add a, a ; $45e5
	jr nc, Label_18_45ed ; $45e6
	ld a, $08 ; $45e8
	dec a ; $45ea
	jr Label_18_45f3 ; $45eb
Label_18_45ed:
	rra ; $45ed
	cp a, $08 ; $45ee
	jr c, Label_18_45f3 ; $45f0
	xor a, a ; $45f2
Label_18_45f3:
	ld d, a ; $45f3
	ld a, e ; $45f4
	add a, a ; $45f5
	jr nc, Label_18_45fd ; $45f6
	ld a, $04 ; $45f8
	dec a ; $45fa
	jr Label_18_4603 ; $45fb
Label_18_45fd:
	rra ; $45fd
	cp a, $04 ; $45fe
	jr c, Label_18_4603 ; $4600
	xor a, a ; $4602
Label_18_4603:
	ld e, a ; $4603
	ld a, e ; $4604
	add a, a ; $4605
	add a, a ; $4606
	add a, a ; $4607
	add a, d ; $4608
	push hl ; $4609
	add a, l ; $460a
	ld l, a ; $460b
	jr nc, Label_18_460f ; $460c
	inc h ; $460e
Label_18_460f:
	ld a, [hl] ; $460f
	pop hl ; $4610
	cp a, $ff ; $4611
	jr z, Func_18_45ca ; $4613
	cp a, $fe ; $4615
	jr nz, Label_18_461d ; $4617
	inc d ; $4619
	inc e ; $461a
	jr Func_18_45ca ; $461b
Label_18_461d:
	cp a, $fd ; $461d
	jr nz, Label_18_4625 ; $461f
	dec d ; $4621
	dec e ; $4622
	jr Func_18_45ca ; $4623
Label_18_4625:
	cp a, $fc ; $4625
	jr nz, Label_18_462c ; $4627
	dec d ; $4629
	jr Func_18_45ca ; $462a
Label_18_462c:
	cp a, $fb ; $462c
	jr nz, Label_18_463a ; $462e
	ld a, b ; $4630
	and a, $20 ; $4631
	bit 5, a ; $4633
	jr nz, Label_18_463a ; $4635
	inc d ; $4637
	jr Func_18_45ca ; $4638
Label_18_463a:
	ret ; $463a
Func_18_463b:
	push af ; $463b
	ld d, a ; $463c
	ldh a, [hPlayerInputFlags] ; $463d
	bit 2, a ; $463f
	jr z, Label_18_464e ; $4641
	ldh a, [hDebugStepMode] ; $4643
	or a, a ; $4645
	jr z, Label_18_464e ; $4646
	ld a, b ; $4648
	farcall FarPtr_LoadMainCharacterFromRoster ; $4649
	jr Label_18_4652 ; $464c
Label_18_464e:
	ld a, b ; $464e
	farcall FarPtr_InitPlayerRecordFromTemplate ; $464f
Label_18_4652:
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
	ld a, [$cb00] ; $4661
	or a, a ; $4664
	jr z, Label_18_4669 ; $4665
	ld l, $40 ; $4667
Label_18_4669:
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
	INCBIN "data/bank_018/d_467a.bin" ; $467a, 3172 bytes
Func_18_52de:
	call ClearFrameTasks ; $52de
	call ClearSpriteQueue ; $52e1
	call ClearTileVramBothBanks ; $52e4
	call Func_18_5372 ; $52e7
	xor a, a ; $52ea
	ld [$c783], a ; $52eb
	ld [$c780], a ; $52ee
	ld hl, $467a ; $52f1
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
	ld hl, $4f33 ; $5310
	ld de, $0008 ; $5313
	call LoadPaletteShadow ; $5316
	ld hl, $50ce ; $5319
	ld de, $dc00 ; $531c
	call DecompressData ; $531f
	ld hl, $4f73 ; $5322
	ld de, $d800 ; $5325
	call DecompressData ; $5328
	call Func_18_438d ; $532b
	call Func_18_5365 ; $532e
	ld hl, $51f8 ; $5331
	ld de, $d000 ; $5334
	call DecompressData ; $5337
	ld hl, $d000 ; $533a
	ld de, $8300 ; $533d
	ld c, $14 ; $5340
	call QueueVRAMCopy ; $5342
	ld hl, $52c6 ; $5345
	ld de, $0903 ; $5348
	call LoadPaletteShadow ; $534b
	ld hl, $8500 ; $534e
	ld de, $0e01 ; $5351
	call Func_18_437c ; $5354
	call Func_18_55f8 ; $5357
	call Func_18_537a ; $535a
	ld hl, $c7bc ; $535d
	ld b, [hl] ; $5360
	call Func_18_5379 ; $5361
	ret ; $5364
Func_18_5365:
	ld hl, $d9a0 ; $5365
	ld de, $dda0 ; $5368
	ld bc, $0e05 ; $536b
	call DrawBox ; $536e
	ret ; $5371
Func_18_5372:
	ld a, [$c918] ; $5372
	ld [$c78a], a ; $5375
	ret ; $5378
Func_18_5379:
	ret ; $5379
Func_18_537a:
	ld a, [$c78d] ; $537a
	call Func_18_53e4 ; $537d
	ld de, $d84b ; $5380
	call Func_18_5586 ; $5383
	ld a, [$c78e] ; $5386
	call Func_18_53e4 ; $5389
	ld de, $d88b ; $538c
	call Func_18_5586 ; $538f
	ld a, [$c78f] ; $5392
	call Func_18_53e4 ; $5395
	ld de, $d8cb ; $5398
	call Func_18_5586 ; $539b
	ld a, [wTargetZoneX1] ; $539e
	call Func_18_53e4 ; $53a1
	ld de, $d90b ; $53a4
	call Func_18_5586 ; $53a7
	ld a, $0a ; $53aa
	ld hl, $53b3 ; $53ac
	call RegisterFrameTask ; $53af
	ret ; $53b2
	ld a, [$c78a] ; $53b3
	ld h, $00 ; $53b6
	ld l, a ; $53b8
	ld de, $4404 ; $53b9
	ld b, $03 ; $53bc
	ld a, $02 ; $53be
	call DrawDecimalNumberSprites ; $53c0
	ld a, [$c780] ; $53c3
	cp a, $03 ; $53c6
	jr nz, Label_18_53cf ; $53c8
	ld a, $01 ; $53ca
	ld [$c783], a ; $53cc
Label_18_53cf:
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
Func_18_53e4:
	add a, $04 ; $53e4
	and a, $0f ; $53e6
	add a, a ; $53e8
	add a, $f8 ; $53e9
	ld l, a ; $53eb
	adc a, $53 ; $53ec
	sub a, l ; $53ee
	ld h, a ; $53ef
	ld a, [hl+] ; $53f0
	ld h, [hl] ; $53f1
	ld l, a ; $53f2
	ld de, $d800 ; $53f3
	add hl, de ; $53f6
	ret ; $53f7
	; $53f8, 32 bytes (records:2)
; 16 records x 2 bytes
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
	ld [$cb61], a ; $541a
	call FlushBgMapShadowToVram ; $541d
	ret ; $5420
Func_18_5421:
	ldh a, [hInputRisingEdge] ; $5421
	and a, $20 ; $5423
	jr z, Label_18_542b ; $5425
	ld b, $00 ; $5427
	sound $5e ; $5429
Label_18_542b:
	ldh a, [hInputRisingEdge] ; $542b
	and a, $10 ; $542d
	jr z, Label_18_5435 ; $542f
	ld b, $01 ; $5431
	sound $5e ; $5433
Label_18_5435:
	ldh a, [hInputRisingEdge] ; $5435
	and a, $01 ; $5437
	jr nz, Label_18_545f ; $5439
	ldh a, [hInputRisingEdge] ; $543b
	and a, $02 ; $543d
	jr z, Label_18_5445 ; $543f
	ld b, $ff ; $5441
	jr Label_18_545f ; $5443
Label_18_5445:
	ld de, $128e ; $5445
	ld a, b ; $5448
	and a, a ; $5449
	jr z, Label_18_544f ; $544a
	ld de, $3a8e ; $544c
Label_18_544f:
	call Func_18_4444 ; $544f
	push bc ; $5452
	ld bc, $0650 ; $5453
	call QueueSprite16 ; $5456
	pop bc ; $5459
	call AdvanceFrame ; $545a
	jr Func_18_5421 ; $545d
Label_18_545f:
	ld a, b ; $545f
	and a, a ; $5460
	jr z, Label_18_5466 ; $5461
	sound $62 ; $5463
	ret ; $5465
Label_18_5466:
	sound $5f ; $5466
	ret ; $5468
Func_18_5469:
	ldh a, [hInputRisingEdge] ; $5469
	and a, $20 ; $546b
	jr z, Label_18_5473 ; $546d
	ld b, $00 ; $546f
	sound $5e ; $5471
Label_18_5473:
	ldh a, [hInputRisingEdge] ; $5473
	and a, $10 ; $5475
	jr z, Label_18_547d ; $5477
	ld b, $01 ; $5479
	sound $5e ; $547b
Label_18_547d:
	ldh a, [hInputRisingEdge] ; $547d
	and a, $01 ; $547f
	jr nz, Label_18_54a7 ; $5481
	ldh a, [hInputRisingEdge] ; $5483
	and a, $02 ; $5485
	jr z, Label_18_548d ; $5487
	ld b, $ff ; $5489
	jr Label_18_54a7 ; $548b
Label_18_548d:
	ld de, $2892 ; $548d
	ld a, b ; $5490
	and a, a ; $5491
	jr z, Label_18_5497 ; $5492
	ld de, $5892 ; $5494
Label_18_5497:
	call Func_18_4444 ; $5497
	push bc ; $549a
	ld bc, $0650 ; $549b
	call QueueSprite16 ; $549e
	pop bc ; $54a1
	call AdvanceFrame ; $54a2
	jr Func_18_5469 ; $54a5
Label_18_54a7:
	ld a, b ; $54a7
	and a, a ; $54a8
	jr z, Label_18_54ae ; $54a9
	sound $62 ; $54ab
	ret ; $54ad
Label_18_54ae:
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
	jr z, Label_18_54db ; $54d4
	call DrawGlyphSprite ; $54d6
	jr DrawStringSprites ; $54d9
Label_18_54db:
	ret ; $54db
DrawGlyphSprite:
	sub a, $30 ; $54dc
	jr c, Label_18_5502 ; $54de
	push de ; $54e0
	push hl ; $54e1
	add a, a ; $54e2
	add a, $30 ; $54e3
	ld c, a ; $54e5
	ld a, [$c783] ; $54e6
	and a, a ; $54e9
	jr z, Label_18_54fd ; $54ea
	ld a, d ; $54ec
	ld hl, hVBlankCounter ; $54ed
	sub a, [hl] ; $54f0
	and a, $1f ; $54f1
	add a, $07 ; $54f3
	ld l, a ; $54f5
	adc a, $55 ; $54f6
	sub a, l ; $54f8
	ld h, a ; $54f9
	ld a, [hl] ; $54fa
	add a, e ; $54fb
	ld e, a ; $54fc
Label_18_54fd:
	call QueueSprite ; $54fd
	pop hl ; $5500
	pop de ; $5501
Label_18_5502:
	ld a, d ; $5502
	add a, $08 ; $5503
	ld d, a ; $5505
	ret ; $5506
	INCBIN "data/bank_018/d_5507.bin" ; $5507, 90 bytes
Func_18_5561:
	ld hl, $51d8 ; $5561
	ld de, $dde1 ; $5564
	call Func_18_55b9 ; $5567
	ld hl, $51e8 ; $556a
	ld de, $de01 ; $556d
	call Func_18_55b9 ; $5570
	ld hl, $51b8 ; $5573
	ld de, $d9e1 ; $5576
	call Func_18_55b9 ; $5579
	ld hl, $51c8 ; $557c
	ld de, $da01 ; $557f
	call Func_18_55b9 ; $5582
	ret ; $5585
Func_18_5586:
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
	jr nc, Label_18_559f ; $559c
	inc h ; $559e
Label_18_559f:
	ld a, $1a ; $559f
	add a, e ; $55a1
	ld e, a ; $55a2
	jr nc, Label_18_55a6 ; $55a3
	inc d ; $55a5
Label_18_55a6:
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
Func_18_55b9:
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
Func_18_55f8:
	ld hl, $5633 ; $55f8
	ld de, $d000 ; $55fb
	call DecompressData ; $55fe
	ld hl, $d000 ; $5601
	ld de, $a000 ; $5604
	ld c, $1c ; $5607
	call QueueVRAMCopy ; $5609
	ld hl, $582d ; $560c
	ld de, $0c03 ; $560f
	call LoadPalettesImmediate ; $5612
	ld hl, $5845 ; $5615
	ld de, $d000 ; $5618
	call DecompressData ; $561b
	ld hl, $d000 ; $561e
	ld de, $a200 ; $5621
	ld c, $0c ; $5624
	call QueueVRAMCopy ; $5626
	ld hl, $58ad ; $5629
	ld de, $0801 ; $562c
	call LoadPalettesImmediate ; $562f
	ret ; $5632
	INCBIN "data/bank_018/d_5633.bin" ; $5633, 910 bytes
Func_18_59c1:
	ld hl, $58e0 ; $59c1
	ld de, $8400 ; $59c4
	ld c, $0c ; $59c7
	call QueueVRAMCopy ; $59c9
	ld hl, $59b9 ; $59cc
	ld de, $0a01 ; $59cf
	call LoadPaletteShadow ; $59d2
	ret ; $59d5
Func_18_59d6:
	ld c, $00 ; $59d6
	cp a, $84 ; $59d8
	jr nz, Label_18_59de ; $59da
	ld c, $01 ; $59dc
Label_18_59de:
	ldh a, [hVBlankCounter] ; $59de
	and a, $1f ; $59e0
	add a, $fe ; $59e2
	ld l, a ; $59e4
	adc a, $59 ; $59e5
	sub a, l ; $59e7
	ld h, a ; $59e8
	ld a, c ; $59e9
	add a, a ; $59ea
	add a, [hl] ; $59eb
	add a, a ; $59ec
	add a, $1e ; $59ed
	ld l, a ; $59ef
	adc a, $5a ; $59f0
	sub a, l ; $59f2
	ld h, a ; $59f3
	ld a, [hl+] ; $59f4
	ld h, [hl] ; $59f5
	ld l, a ; $59f6
	ld bc, $0240 ; $59f7
	call QueueSpriteTemplate ; $59fa
	ret ; $59fd
	INCBIN "data/bank_018/d_59fe.bin" ; $59fe, 108 bytes
Func_18_5a6a:
	ldh a, [hVBlankCounter] ; $5a6a
	and a, $3f ; $5a6c
	add a, $79 ; $5a6e
	ld l, a ; $5a70
	adc a, $5a ; $5a71
	sub a, l ; $5a73
	ld h, a ; $5a74
	ld a, [hl] ; $5a75
	add a, e ; $5a76
	ld e, a ; $5a77
	ret ; $5a78
	INCBIN "data/bank_018/d_5a79.bin" ; $5a79, 64 bytes
LoadOnCourtCharTilesA:
	ld h, a ; $5ab9
	ld l, $00 ; $5aba
	srl h ; $5abc
	rr l ; $5abe
	srl h ; $5ac0
	rr l ; $5ac2
	ld bc, $5af0 ; $5ac4
	add hl, bc ; $5ac7
	ld c, $04 ; $5ac8
	call QueueVRAMCopy ; $5aca
	ret ; $5acd
LoadOnCourtCharTilesB:
	cp a, $ff ; $5ace
	jr z, Label_18_5ae7 ; $5ad0
	ld h, a ; $5ad2
	ld l, $00 ; $5ad3
	srl h ; $5ad5
	rr l ; $5ad7
	srl h ; $5ad9
	rr l ; $5adb
	ld bc, $62f0 ; $5add
	add hl, bc ; $5ae0
	ld c, $04 ; $5ae1
	call QueueVRAMCopy ; $5ae3
	ret ; $5ae6
Label_18_5ae7:
	ld hl, $6af0 ; $5ae7
	ld c, $04 ; $5aea
	call QueueVRAMCopy ; $5aec
	ret ; $5aef
	INCBIN "data/bank_018/d_5af0.bin" ; $5af0, 4160 bytes
Lz_18_6b30:
	INCBIN "data/bank_018/lz_6b30.bin" ; $6b30, 67 bytes
Lz_18_6b73:
	INCBIN "data/bank_018/lz_6b73.bin" ; $6b73, 66 bytes
Lz_18_6bb5:
	INCBIN "data/bank_018/lz_6bb5.bin" ; $6bb5, 62 bytes
Lz_18_6bf3:
	INCBIN "data/bank_018/lz_6bf3.bin" ; $6bf3, 48 bytes
Lz_18_6c23:
	INCBIN "data/bank_018/lz_6c23.bin" ; $6c23, 44 bytes
Lz_18_6c4f:
	INCBIN "data/bank_018/lz_6c4f.bin" ; $6c4f, 46 bytes
Lz_18_6c7d:
	INCBIN "data/bank_018/lz_6c7d.bin" ; $6c7d, 59 bytes
Lz_18_6cb8:
	INCBIN "data/bank_018/lz_6cb8.bin" ; $6cb8, 65 bytes
Lz_18_6cf9:
	INCBIN "data/bank_018/lz_6cf9.bin" ; $6cf9, 67 bytes
Lz_18_6d3c:
	INCBIN "data/bank_018/lz_6d3c.bin" ; $6d3c, 65 bytes
Lz_18_6d7d:
	INCBIN "data/bank_018/lz_6d7d.bin" ; $6d7d, 60 bytes
Lz_18_6db9:
	INCBIN "data/bank_018/lz_6db9.bin" ; $6db9, 50 bytes
Lz_18_6deb:
	INCBIN "data/bank_018/lz_6deb.bin" ; $6deb, 45 bytes
Lz_18_6e18:
	INCBIN "data/bank_018/lz_6e18.bin" ; $6e18, 51 bytes
Lz_18_6e4b:
	INCBIN "data/bank_018/lz_6e4b.bin" ; $6e4b, 61 bytes
Lz_18_6e88:
	INCBIN "data/bank_018/lz_6e88.bin" ; $6e88, 66 bytes
Lz_18_6eca:
	INCBIN "data/bank_018/lz_6eca.bin" ; $6eca, 73 bytes
Lz_18_6f13:
	INCBIN "data/bank_018/lz_6f13.bin" ; $6f13, 68 bytes
Lz_18_6f57:
	INCBIN "data/bank_018/lz_6f57.bin" ; $6f57, 64 bytes
Lz_18_6f97:
	INCBIN "data/bank_018/lz_6f97.bin" ; $6f97, 59 bytes
Lz_18_6fd2:
	INCBIN "data/bank_018/lz_6fd2.bin" ; $6fd2, 53 bytes
Lz_18_7007:
	INCBIN "data/bank_018/lz_7007.bin" ; $7007, 57 bytes
Lz_18_7040:
	INCBIN "data/bank_018/lz_7040.bin" ; $7040, 66 bytes
Lz_18_7082:
	INCBIN "data/bank_018/lz_7082.bin" ; $7082, 73 bytes
Lz_18_70cb:
	INCBIN "data/bank_018/lz_70cb.bin" ; $70cb, 71 bytes
Lz_18_7112:
	INCBIN "data/bank_018/lz_7112.bin" ; $7112, 68 bytes
Lz_18_7156:
	INCBIN "data/bank_018/lz_7156.bin" ; $7156, 66 bytes
Lz_18_7198:
	INCBIN "data/bank_018/lz_7198.bin" ; $7198, 64 bytes
Lz_18_71d8:
	INCBIN "data/bank_018/lz_71d8.bin" ; $71d8, 58 bytes
Lz_18_7212:
	INCBIN "data/bank_018/lz_7212.bin" ; $7212, 60 bytes
Lz_18_724e:
	INCBIN "data/bank_018/lz_724e.bin" ; $724e, 68 bytes
Lz_18_7292:
	INCBIN "data/bank_018/lz_7292.bin" ; $7292, 73 bytes
MarioMiniGamesTilemap:
	INCBIN "data/bank_018/lz_72db.bin" ; $72db, 304 bytes
MarioMiniGamesAttrmap:
	INCBIN "data/bank_018/lz_740b.bin" ; $740b, 214 bytes
MarioMiniGamesPalettes:
	; $74e1, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $5ad6, $01bf, $0000, $6bff ; pal 0: #b4b4b4 #ff6a00 #000000 #ffffd5
	dw $0300, $0240, $0180, $0100 ; pal 1: #00c500 #009400 #006200 #004100
	dw $0000, $0000, $0000, $0000 ; pal 2: #000000 #000000 #000000 #000000
	dw $7fff, $6bff, $1e40, $0000 ; pal 3: #ffffff #ffffd5 #009439 #000000
	dw $225f, $6bff, $505c, $0000 ; pal 4: #ff9441 #ffffd5 #e610a4 #000000
	dw $331f, $6bff, $01df, $0000 ; pal 5: #ffc562 #ffffd5 #ff7300 #000000
	dw $029f, $6bff, $001f, $0000 ; pal 6: #ffa400 #ffffd5 #ff0000 #000000
	dw $318c, $6bff, $7d4a, $0000 ; pal 7: #626262 #ffffd5 #5252ff #000000
	INCBIN "data/bank_018/d_7521.bin" ; $7521, 246 bytes
Func_18_7617:
	ld a, c ; $7617
	ld [$cb6d], a ; $7618
	call Func_18_7632 ; $761b
	ld a, b ; $761e
	or a, a ; $761f
	jr nz, Label_18_7626 ; $7620
	call Func_18_76b4 ; $7622
	ret ; $7625
Label_18_7626:
	cp a, $01 ; $7626
	jr nz, Label_18_762e ; $7628
	call Func_18_77bb ; $762a
	ret ; $762d
Label_18_762e:
	call Func_18_792c ; $762e
	ret ; $7631
Func_18_7632:
	call EnableLCD ; $7632
	ld c, $10 ; $7635
	call BeginFadeOut ; $7637
	call WaitFadeEnd ; $763a
	call DisableLCDSafely ; $763d
	call ClearFrameTasks ; $7640
	call Func_18_7647 ; $7643
	ret ; $7646
Func_18_7647:
	xor a, a ; $7647
	ldh [hScrollX], a ; $7648
	ldh [hScrollY], a ; $764a
	ld [wCameraX], a ; $764c
	ld [$c321], a ; $764f
	ld [wCameraY], a ; $7652
	ld [$c323], a ; $7655
	ret ; $7658
	call Func_18_7632 ; $7659
	ld c, $00 ; $765c
Label_18_765e:
	push bc ; $765e
	ld a, c ; $765f
	ld hl, $769c ; $7660
	add a, l ; $7663
	ld l, a ; $7664
	jr nc, Label_18_7668 ; $7665
	inc h ; $7667
Label_18_7668:
	ld c, [hl] ; $7668
	push bc ; $7669
	ld c, $10 ; $766a
	call BeginFadeOut ; $766c
	call WaitFadeEnd ; $766f
	call DisableLCDSafely ; $7672
	pop bc ; $7675
	farcall FarPtr_LoadScreenAssetRecord ; $7676
	farcall FarPtr_Func_39_4325 ; $7679
	call EnableLCD ; $767c
	ld c, $10 ; $767f
	call BeginFadeIn ; $7681
	call WaitFadeEnd ; $7684
Label_18_7687:
	call AdvanceFrame ; $7687
	ldh a, [hInputPressed] ; $768a
	or a, a ; $768c
	jr z, Label_18_7687 ; $768d
	pop bc ; $768f
	ld a, c ; $7690
	inc a ; $7691
	ld c, a ; $7692
	cp a, $18 ; $7693
	jr nz, Label_18_765e ; $7695
	ld c, $00 ; $7697
	jr Label_18_765e ; $7699
	INCBIN "data/bank_018/d_769b.bin" ; $769b, 25 bytes
Func_18_76b4:
	call Func_18_7720 ; $76b4
	call Func_18_7740 ; $76b7
	call EnableLCD ; $76ba
	ld c, $02 ; $76bd
	call BeginFadeIn ; $76bf
	call WaitFadeEnd ; $76c2
	wram_bank $03 ; $76c5
	xor a, a ; $76cb
	ld [$da01], a ; $76cc
Label_18_76cf:
	call AdvanceFrame ; $76cf
	ld a, [$da01] ; $76d2
	inc a ; $76d5
	ld [$da01], a ; $76d6
	cp a, $fa ; $76d9
	jr nz, Label_18_76cf ; $76db
	farcall FarPtr_03_40 ; $76dd
	ld b, $3f ; $76e0
	ld c, $3f ; $76e2
	ld d, $1e ; $76e4
	farcall FarPtr_03_42 ; $76e6
	farcall FarPtr_03_44 ; $76e9
Label_18_76ec:
	call AdvanceFrame ; $76ec
	ldh a, [hInputPressed] ; $76ef
	and a, $03 ; $76f1
	jr z, Label_18_76ec ; $76f3
	ld c, $10 ; $76f5
	call BeginFadeOut ; $76f7
	call WaitFadeEnd ; $76fa
	call DisableLCDSafely ; $76fd
	call FillAllBgPalettes ; $7700
	call EnableLCD ; $7703
	ld c, $10 ; $7706
	call BeginFadeIn ; $7708
	call WaitFadeEnd ; $770b
	ld a, $01 ; $770e
	ld hl, $775c ; $7710
	call RegisterFrameTask ; $7713
Label_18_7716:
	call AdvanceFrame ; $7716
	ldh a, [hInputPressed] ; $7719
	and a, $03 ; $771b
	jr z, Label_18_7716 ; $771d
	ret ; $771f
Func_18_7720:
	call Func_18_7647 ; $7720
	call Func_18_772d ; $7723
	farcall FarPtr_LoadScreenAssetRecord ; $7726
	farcall FarPtr_Func_39_4325 ; $7729
	ret ; $772c
Func_18_772d:
	ld a, [$cb6d] ; $772d
	ld hl, $773a ; $7730
	add a, l ; $7733
	ld l, a ; $7734
	jr nc, Label_18_7738 ; $7735
	inc h ; $7737
Label_18_7738:
	ld c, [hl] ; $7738
	ret ; $7739
	INCBIN "data/bank_018/d_773a.bin" ; $773a, 6 bytes
Func_18_7740:
	ld b, $06 ; $7740
	ld c, $28 ; $7742
	ld de, $8000 ; $7744
	farcall FarPtr_39_10 ; $7747
	ld hl, $7754 ; $774a
	ld de, $0801 ; $774d
	call LoadPaletteShadow ; $7750
	ret ; $7753
	INCBIN "data/bank_018/d_7754.bin" ; $7754, 8 bytes
	ld hl, $776a ; $775c
	ld de, $283a ; $775f
	ld c, $00 ; $7762
	ld b, $00 ; $7764
	call QueueSpriteTemplate ; $7766
	ret ; $7769
	; $776a, 81 bytes (bytes:4)
	db $10, $08, $00, $00 ; 0x00
	db $20, $08, $02, $00 ; 0x04
	db $10, $10, $04, $00 ; 0x08
	db $20, $10, $06, $00 ; 0x0c
	db $10, $18, $08, $00 ; 0x10
	db $20, $18, $0a, $00 ; 0x14
	db $10, $20, $0c, $00 ; 0x18
	db $20, $20, $0e, $00 ; 0x1c
	db $10, $28, $10, $00 ; 0x20
	db $20, $28, $12, $00 ; 0x24
	db $10, $30, $14, $00 ; 0x28
	db $20, $30, $16, $00 ; 0x2c
	db $10, $38, $18, $00 ; 0x30
	db $20, $38, $1a, $00 ; 0x34
	db $10, $40, $1c, $00 ; 0x38
	db $20, $40, $1e, $00 ; 0x3c
	db $10, $48, $20, $00 ; 0x40
	db $20, $48, $22, $00 ; 0x44
	db $10, $50, $24, $00 ; 0x48
	db $20, $50, $26, $00 ; 0x4c
	db $80 ; 0x50
Func_18_77bb:
	call Func_18_7835 ; $77bb
	call Func_18_7bce ; $77be
	ld a, $01 ; $77c1
	ld hl, $7b36 ; $77c3
	call RegisterFrameTask ; $77c6
	ld a, $01 ; $77c9
	ld hl, $7b6e ; $77cb
	call RegisterFrameTask ; $77ce
	sound $2c ; $77d1
	call EnableLCD ; $77d3
	ld c, $02 ; $77d6
	call BeginFadeIn ; $77d8
	call WaitFadeEnd ; $77db
	wram_bank $03 ; $77de
	xor a, a ; $77e4
	ld [$da01], a ; $77e5
Label_18_77e8:
	call AdvanceFrame ; $77e8
	ldh a, [hVBlankCounter] ; $77eb
	and a, $03 ; $77ed
	jr nz, Label_18_77e8 ; $77ef
	ld a, [$da01] ; $77f1
	inc a ; $77f4
	ld [$da01], a ; $77f5
	cp a, $af ; $77f8
	jr nz, Label_18_77e8 ; $77fa
	ld c, $01 ; $77fc
	call BeginFadeOut ; $77fe
	call WaitFadeEnd ; $7801
	call ClearFrameTasks ; $7804
	call DisableLCDSafely ; $7807
	farcall FarPtr_03_36 ; $780a
	call DisableLCDSafely ; $780d
	call Func_18_78b1 ; $7810
	call FillAllBgPalettes ; $7813
	ld a, $01 ; $7816
	ld hl, $78cd ; $7818
	call RegisterFrameTask ; $781b
	call EnableLCD ; $781e
	ld c, $40 ; $7821
	call BeginFadeIn ; $7823
	call WaitFadeEnd ; $7826
	sound $2d ; $7829
Label_18_782b:
	call AdvanceFrame ; $782b
	ldh a, [hInputPressed] ; $782e
	and a, $03 ; $7830
	jr z, Label_18_782b ; $7832
	ret ; $7834
Func_18_7835:
	call Func_18_7647 ; $7835
	call Func_18_7842 ; $7838
	farcall FarPtr_LoadScreenAssetRecord ; $783b
	farcall FarPtr_Func_39_4325 ; $783e
	ret ; $7841
Func_18_7842:
	ld a, [$cb6d] ; $7842
	ld hl, $784f ; $7845
	add a, l ; $7848
	ld l, a ; $7849
	jr nc, Label_18_784d ; $784a
	inc h ; $784c
Label_18_784d:
	ld c, [hl] ; $784d
	ret ; $784e
	INCBIN "data/bank_018/d_784f.bin" ; $784f, 6 bytes
FillAllBgPalettes:
	call Func_18_7647 ; $7855
	ld c, $32 ; $7858
	farcall FarPtr_LoadScreenAssetRecord ; $785a
	ld hl, $78a9 ; $785d
	ld de, $0001 ; $7860
	call LoadPaletteShadow ; $7863
	ld hl, $78a9 ; $7866
	ld de, $0101 ; $7869
	call LoadPaletteShadow ; $786c
	ld hl, $78a9 ; $786f
	ld de, $0201 ; $7872
	call LoadPaletteShadow ; $7875
	ld hl, $78a9 ; $7878
	ld de, $0301 ; $787b
	call LoadPaletteShadow ; $787e
	ld hl, $78a9 ; $7881
	ld de, $0401 ; $7884
	call LoadPaletteShadow ; $7887
	ld hl, $78a9 ; $788a
	ld de, $0501 ; $788d
	call LoadPaletteShadow ; $7890
	ld hl, $78a9 ; $7893
	ld de, $0601 ; $7896
	call LoadPaletteShadow ; $7899
	ld hl, $78a9 ; $789c
	ld de, $0701 ; $789f
	call LoadPaletteShadow ; $78a2
	farcall FarPtr_Func_39_4325 ; $78a5
	ret ; $78a8
	INCBIN "data/bank_018/d_78a9.bin" ; $78a9, 8 bytes
Func_18_78b1:
	ld b, $07 ; $78b1
	ld c, $28 ; $78b3
	ld de, $8000 ; $78b5
	farcall FarPtr_39_10 ; $78b8
	ld hl, $78c5 ; $78bb
	ld de, $0801 ; $78be
	call LoadPaletteShadow ; $78c1
	ret ; $78c4
	INCBIN "data/bank_018/d_78c5.bin" ; $78c5, 8 bytes
	ld hl, $78db ; $78cd
	ld de, $283a ; $78d0
	ld c, $00 ; $78d3
	ld b, $00 ; $78d5
	call QueueSpriteTemplate ; $78d7
	ret ; $78da
	; $78db, 81 bytes (bytes:4)
	db $10, $08, $00, $00 ; 0x00
	db $20, $08, $02, $00 ; 0x04
	db $10, $10, $04, $00 ; 0x08
	db $20, $10, $06, $00 ; 0x0c
	db $10, $18, $08, $00 ; 0x10
	db $20, $18, $0a, $00 ; 0x14
	db $10, $20, $0c, $00 ; 0x18
	db $20, $20, $0e, $00 ; 0x1c
	db $10, $28, $10, $00 ; 0x20
	db $20, $28, $12, $00 ; 0x24
	db $10, $30, $14, $00 ; 0x28
	db $20, $30, $16, $00 ; 0x2c
	db $10, $38, $18, $00 ; 0x30
	db $20, $38, $1a, $00 ; 0x34
	db $10, $40, $1c, $00 ; 0x38
	db $20, $40, $1e, $00 ; 0x3c
	db $10, $48, $20, $00 ; 0x40
	db $20, $48, $22, $00 ; 0x44
	db $10, $50, $24, $00 ; 0x48
	db $20, $50, $26, $00 ; 0x4c
	db $80 ; 0x50
Func_18_792c:
	call Func_18_7647 ; $792c
	sound $09 ; $792f
	call Func_18_7a07 ; $7931
	farcall FarPtr_LoadScreenAssetRecord ; $7934
	farcall FarPtr_Func_39_4325 ; $7937
	call Func_18_7d03 ; $793a
	ld a, $01 ; $793d
	ld hl, $7b36 ; $793f
	call RegisterFrameTask ; $7942
	ld a, $01 ; $7945
	ld hl, $7b6e ; $7947
	call RegisterFrameTask ; $794a
	call EnableLCD ; $794d
	ld c, $01 ; $7950
	call BeginFadeIn ; $7952
	call WaitFadeEnd ; $7955
Label_18_7958:
	call AdvanceFrame ; $7958
	ldh a, [hInputPressed] ; $795b
	and a, $03 ; $795d
	jr z, Label_18_7958 ; $795f
	ld c, $02 ; $7961
	call BeginFadeOut ; $7963
	call WaitFadeEnd ; $7966
	ld de, $05e0 ; $7969
	call TestGameFlag ; $796c
	jr z, Label_18_797b ; $796f
	ld de, $1700 ; $7971
	call TestGameFlag ; $7974
	jr z, Label_18_7985 ; $7977
	jr Label_18_798a ; $7979
Label_18_797b:
	ld de, $16e0 ; $797b
	call TestGameFlag ; $797e
	jr z, Label_18_7985 ; $7981
	jr Label_18_798a ; $7983
Label_18_7985:
	sound $2c ; $7985
	farcall FarPtr_0a_a2 ; $7987
Label_18_798a:
	wram_bank $03 ; $798a
	xor a, a ; $7990
	ld [$da00], a ; $7991
	call ClearFrameTasks ; $7994
	call Func_18_7647 ; $7997
	call DisableLCDSafely ; $799a
	call Func_18_7a1a ; $799d
	farcall FarPtr_LoadScreenAssetRecord ; $79a0
	farcall FarPtr_Func_39_4325 ; $79a3
	call Func_18_7a2d ; $79a6
	call EnableLCD ; $79a9
	ld c, $02 ; $79ac
	call BeginFadeIn ; $79ae
	call WaitFadeEnd ; $79b1
	wram_bank $03 ; $79b4
	xor a, a ; $79ba
	ld [$da01], a ; $79bb
Label_18_79be:
	call AdvanceFrame ; $79be
	ld a, [$da01] ; $79c1
	inc a ; $79c4
	ld [$da01], a ; $79c5
	cp a, $b4 ; $79c8
	jr nz, Label_18_79be ; $79ca
	ld a, $01 ; $79cc
	ld hl, $7a81 ; $79ce
	call RegisterFrameTask ; $79d1
	ld a, $01 ; $79d4
	ld hl, $7a49 ; $79d6
	call RegisterFrameTask ; $79d9
	sound $2d ; $79dc
Label_18_79de:
	call AdvanceFrame ; $79de
	ldh a, [hInputPressed] ; $79e1
	and a, $03 ; $79e3
	jr z, Label_18_79de ; $79e5
	ld de, $0120 ; $79e7
	farcall FarPtr_SetSaveFlag ; $79ea
	ld de, $05e0 ; $79ed
	call TestGameFlag ; $79f0
	jr z, Label_18_79fd ; $79f3
	ld de, $1700 ; $79f5
	call SetGameFlag ; $79f8
	jr Label_18_7a03 ; $79fb
Label_18_79fd:
	ld de, $16e0 ; $79fd
	call SetGameFlag ; $7a00
Label_18_7a03:
	farcall FarPtr_03_18 ; $7a03
	ret ; $7a06
Func_18_7a07:
	ld a, [$cb6d] ; $7a07
	ld hl, $7a14 ; $7a0a
	add a, l ; $7a0d
	ld l, a ; $7a0e
	jr nc, Label_18_7a12 ; $7a0f
	inc h ; $7a11
Label_18_7a12:
	ld c, [hl] ; $7a12
	ret ; $7a13
	INCBIN "data/bank_018/d_7a14.bin" ; $7a14, 6 bytes
Func_18_7a1a:
	ld a, [$cb6d] ; $7a1a
	ld hl, $7a27 ; $7a1d
	add a, l ; $7a20
	ld l, a ; $7a21
	jr nc, Label_18_7a25 ; $7a22
	inc h ; $7a24
Label_18_7a25:
	ld c, [hl] ; $7a25
	ret ; $7a26
	INCBIN "data/bank_018/d_7a27.bin" ; $7a27, 6 bytes
Func_18_7a2d:
	ld b, $08 ; $7a2d
	ld c, $14 ; $7a2f
	ld de, $8000 ; $7a31
	farcall FarPtr_39_10 ; $7a34
	ld hl, $7a41 ; $7a37
	ld de, $0801 ; $7a3a
	call LoadPaletteShadow ; $7a3d
	ret ; $7a40
	INCBIN "data/bank_018/d_7a41.bin" ; $7a41, 8 bytes
	ld hl, $7a57 ; $7a49
	ld de, $2840 ; $7a4c
	ld c, $00 ; $7a4f
	ld b, $00 ; $7a51
	call QueueSpriteTemplate ; $7a53
	ret ; $7a56
	; $7a57, 375 bytes (bytes:4)
	db $10, $08, $00, $00 ; 0x00
	db $10, $10, $02, $00 ; 0x04
	db $10, $18, $04, $00 ; 0x08
	db $10, $20, $06, $00 ; 0x0c
	db $10, $28, $08, $00 ; 0x10
	db $10, $30, $0a, $00 ; 0x14
	db $10, $38, $0c, $00 ; 0x18
	db $10, $40, $0e, $00 ; 0x1c
	db $10, $48, $10, $00 ; 0x20
	db $10, $50, $12, $00 ; 0x24
	db $80, $c9, $f0, $96 ; 0x28
	db $f5, $3e, $03, $e0 ; 0x2c
	db $96, $e0, $70, $fa ; 0x30
	db $00, $da, $fe, $10 ; 0x34
	db $28, $1e, $87, $87 ; 0x38
	db $87, $21, $b5, $7a ; 0x3c
	db $85, $6f, $30, $01 ; 0x40
	db $24, $11, $01, $08 ; 0x44
	db $cd, $b5, $05, $f0 ; 0x48
	db $8c, $e6, $03, $20 ; 0x4c
	db $07, $fa, $00, $da ; 0x50
	db $3c, $ea, $00, $da ; 0x54
	db $f1, $e0, $96, $e0 ; 0x58
	db $70, $c9, $80, $02 ; 0x5c
	db $dd, $3a, $3e, $53 ; 0x60
	db $bf, $6f, $80, $02 ; 0x64
	db $dd, $3e, $fe, $4e ; 0x68
	db $3f, $63, $80, $02 ; 0x6c
	db $fd, $46, $de, $4e ; 0x70
	db $df, $5a, $80, $02 ; 0x74
	db $1d, $4f, $be, $4e ; 0x78
	db $7f, $52, $80, $02 ; 0x7c
	db $3d, $53, $9e, $4e ; 0x80
	db $1f, $4a, $80, $02 ; 0x84
	db $5d, $5b, $7e, $4a ; 0x88
	db $9f, $41, $80, $02 ; 0x8c
	db $7d, $63, $5e, $4a ; 0x90
	db $3f, $39, $80, $02 ; 0x94
	db $9d, $67, $3e, $4a ; 0x98
	db $df, $30, $80, $02 ; 0x9c
	db $bd, $6f, $1e, $4a ; 0xa0
	db $7f, $28, $80, $02 ; 0xa4
	db $de, $77, $fe, $49 ; 0xa8
	db $1f, $20, $80, $02 ; 0xac
	db $de, $77, $fb, $49 ; 0xb0
	db $19, $20, $80, $02 ; 0xb4
	db $de, $77, $f9, $49 ; 0xb8
	db $14, $20, $80, $02 ; 0xbc
	db $de, $7b, $f6, $4d ; 0xc0
	db $0f, $24, $80, $02 ; 0xc4
	db $de, $7b, $f4, $4d ; 0xc8
	db $0a, $24, $80, $02 ; 0xcc
	db $de, $7b, $f1, $4d ; 0xd0
	db $05, $24, $80, $02 ; 0xd4
	db $ff, $7f, $ef, $51 ; 0xd8
	db $00, $28, $c9, $0e ; 0xdc
	db $00, $c5, $21, $00 ; 0xe0
	db $d8, $79, $87, $87 ; 0xe4
	db $87, $87, $85, $6f ; 0xe8
	db $30, $01, $24, $2a ; 0xec
	db $47, $23, $2a, $57 ; 0xf0
	db $23, $2a, $5f, $23 ; 0xf4
	db $23, $7e, $4f, $f5 ; 0xf8
	db $c5, $d5, $e5, $cd ; 0xfc
	db $51, $1f, $e1, $d1 ; 0x100
	db $c1, $f1, $3e, $08 ; 0x104
	db $82, $57, $0c, $0c ; 0x108
	db $cd, $51, $1f, $c1 ; 0x10c
	db $0c, $79, $fe, $10 ; 0x110
	db $20, $cb, $c9, $0e ; 0x114
	db $00, $c5, $21, $00 ; 0x118
	db $d8, $79, $87, $87 ; 0x11c
	db $87, $87, $85, $6f ; 0x120
	db $30, $01, $24, $44 ; 0x124
	db $4d, $21, $05, $00 ; 0x128
	db $09, $7e, $5f, $21 ; 0x12c
	db $01, $00, $09, $2a ; 0x130
	db $66, $6f, $16, $00 ; 0x134
	db $19, $54, $5d, $21 ; 0x138
	db $01, $00, $09, $73 ; 0x13c
	db $23, $72, $21, $06 ; 0x140
	db $00, $09, $7e, $5f ; 0x144
	db $21, $03, $00, $09 ; 0x148
	db $2a, $66, $6f, $16 ; 0x14c
	db $00, $19, $54, $5d ; 0x150
	db $21, $03, $00, $09 ; 0x154
	db $73, $23, $72, $21 ; 0x158
	db $09, $00, $09, $2a ; 0x15c
	db $66, $6f, $e9, $21 ; 0x160
	db $04, $00, $09, $7e ; 0x164
	db $fe, $c0, $38, $03 ; 0x168
	db $3e, $10, $77, $c1 ; 0x16c
	db $0c, $79, $fe, $10 ; 0x170
	db $20, $a3, $c9 ; 0x174
Func_18_7bce:
	ldh a, [hWramBank] ; $7bce
	push af ; $7bd0
	wram_bank $03 ; $7bd1
	ld hl, $d800 ; $7bd7
	ld bc, $0100 ; $7bda
	call ClearBytes ; $7bdd
	call Func_18_7c27 ; $7be0
	call Func_18_7be7 ; $7be3
	ret ; $7be6
Func_18_7be7:
	ld b, $00 ; $7be7
	ld c, $10 ; $7be9
	ld de, $8000 ; $7beb
	farcall FarPtr_39_10 ; $7bee
	ld b, $01 ; $7bf1
	ld c, $10 ; $7bf3
	ld de, $8100 ; $7bf5
	farcall FarPtr_39_10 ; $7bf8
	ld b, $02 ; $7bfb
	ld c, $10 ; $7bfd
	ld de, $8200 ; $7bff
	farcall FarPtr_39_10 ; $7c02
	ld hl, $7c0f ; $7c05
	ld de, $0903 ; $7c08
	call LoadPaletteShadow ; $7c0b
	ret ; $7c0e
	; $7c0f, 24 bytes (bytes:8)
	db $ff, $6b, $df, $5a, $ff, $20, $00, $00 ; 0x00
	db $ff, $6b, $b8, $3b, $80, $12, $00, $00 ; 0x08
	db $ff, $6b, $bf, $53, $9f, $02, $00, $00 ; 0x10
Func_18_7c27:
	ld c, $00 ; $7c27
	ld hl, $7c53 ; $7c29
	ld de, $d800 ; $7c2c
Label_18_7c2f:
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
	jr nc, Label_18_7c4c ; $7c49
	inc h ; $7c4b
Label_18_7c4c:
	inc c ; $7c4c
	ld a, c ; $7c4d
	cp a, $10 ; $7c4e
	jr nz, Label_18_7c2f ; $7c50
	ret ; $7c52
	INCBIN "data/bank_018/d_7c53.bin" ; $7c53, 176 bytes
Func_18_7d03:
	ldh a, [hWramBank] ; $7d03
	push af ; $7d05
	wram_bank $03 ; $7d06
	ld hl, $d800 ; $7d0c
	ld bc, $0100 ; $7d0f
	call ClearBytes ; $7d12
	call Func_18_7d5c ; $7d15
	call Func_18_7d1c ; $7d18
	ret ; $7d1b
Func_18_7d1c:
	ld b, $03 ; $7d1c
	ld c, $10 ; $7d1e
	ld de, $8000 ; $7d20
	farcall FarPtr_39_10 ; $7d23
	ld b, $04 ; $7d26
	ld c, $10 ; $7d28
	ld de, $8100 ; $7d2a
	farcall FarPtr_39_10 ; $7d2d
	ld b, $05 ; $7d30
	ld c, $10 ; $7d32
	ld de, $8200 ; $7d34
	farcall FarPtr_39_10 ; $7d37
	ld hl, $7d44 ; $7d3a
	ld de, $0903 ; $7d3d
	call LoadPaletteShadow ; $7d40
	ret ; $7d43
	INCBIN "data/bank_018/d_7d44.bin" ; $7d44, 24 bytes
Func_18_7d5c:
	ld c, $00 ; $7d5c
	ld hl, $7d88 ; $7d5e
	ld de, $d800 ; $7d61
Label_18_7d64:
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
	jr nc, Label_18_7d81 ; $7d7e
	inc h ; $7d80
Label_18_7d81:
	inc c ; $7d81
	ld a, c ; $7d82
	cp a, $10 ; $7d83
	jr nz, Label_18_7d64 ; $7d85
	ret ; $7d87
	INCBIN "data/bank_018/d_7d88.bin" ; $7d88, 365 bytes
	ds 267, $ff ; $7ef5, fill
