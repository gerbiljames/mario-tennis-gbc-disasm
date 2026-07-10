INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $1c", ROMX[$4000], BANK[$1c]

	INCBIN "data/bank_01c/d_4000.bin" ; $4000, 716 bytes
Func_1c_42cc:
	ld a, $01 ; $42cc
	ldh [$ff96], a ; $42ce
	ldh [rWBK], a ; $42d0
	ld d, [hl] ; $42d2
	ld a, $03 ; $42d3
	ldh [$ff96], a ; $42d5
	ldh [rWBK], a ; $42d7
	ld [hl], d ; $42d9
	inc hl ; $42da
	dec bc ; $42db
	ld a, b ; $42dc
	or a, c ; $42dd
	jr nz, Func_1c_42cc ; $42de
	ret ; $42e0
Func_1c_42e1:
	ld a, $01 ; $42e1
	ldh [$ff96], a ; $42e3
	ldh [rWBK], a ; $42e5
	ld d, [hl] ; $42e7
	ld a, $02 ; $42e8
	ldh [$ff96], a ; $42ea
	ldh [rWBK], a ; $42ec
	ld [hl], d ; $42ee
	inc hl ; $42ef
	dec bc ; $42f0
	ld a, b ; $42f1
	or a, c ; $42f2
	jr nz, Func_1c_42e1 ; $42f3
	ret ; $42f5
	ld a, $06 ; $42f6
	ldh [$ff96], a ; $42f8
	ldh [rWBK], a ; $42fa
	ld a, [$d0b6] ; $42fc
	or a, a ; $42ff
	jr z, Label_1c_4305 ; $4300
	call Func_1c_4c43 ; $4302
Label_1c_4305:
	rst Rst18 ; $4305
	ld c, $1a ; $4306
	ld a, $06 ; $4308
	ldh [$ff96], a ; $430a
	ldh [rWBK], a ; $430c
	ld a, [$d00e] ; $430e
	ld c, a ; $4311
	ld a, [$d019] ; $4312
	add a, c ; $4315
	push af ; $4316
	ld h, $00 ; $4317
	ld l, a ; $4319
	ld a, $02 ; $431a
	ld de, $d08e ; $431c
	call Func_00_1a27 ; $431f
	ld de, $d251 ; $4322
	call Func_1c_44cc ; $4325
	pop af ; $4328
	ld c, $00 ; $4329
	ld de, $d256 ; $432b
	call Func_1c_4502 ; $432e
	ld a, $06 ; $4331
	ldh [$ff96], a ; $4333
	ldh [rWBK], a ; $4335
	ld a, [$d00f] ; $4337
	ld c, a ; $433a
	ld a, [$d01a] ; $433b
	add a, c ; $433e
	push af ; $433f
	ld h, $00 ; $4340
	ld l, a ; $4342
	ld a, $02 ; $4343
	ld de, $d08e ; $4345
	call Func_00_1a27 ; $4348
	ld de, $d265 ; $434b
	call Func_1c_44cc ; $434e
	pop af ; $4351
	ld c, $01 ; $4352
	ld de, $d26a ; $4354
	call Func_1c_4502 ; $4357
	ld a, $06 ; $435a
	ldh [$ff96], a ; $435c
	ldh [rWBK], a ; $435e
	ld a, [$d010] ; $4360
	ld c, a ; $4363
	ld a, [$d01b] ; $4364
	add a, c ; $4367
	push af ; $4368
	ld h, $00 ; $4369
	ld l, a ; $436b
	ld a, $02 ; $436c
	ld de, $d08e ; $436e
	call Func_00_1a27 ; $4371
	ld de, $d291 ; $4374
	call Func_1c_44cc ; $4377
	pop af ; $437a
	ld c, $00 ; $437b
	ld de, $d296 ; $437d
	call Func_1c_4502 ; $4380
	ld a, $06 ; $4383
	ldh [$ff96], a ; $4385
	ldh [rWBK], a ; $4387
	ld a, [$d011] ; $4389
	ld c, a ; $438c
	ld a, [$d01c] ; $438d
	add a, c ; $4390
	push af ; $4391
	ld h, $00 ; $4392
	ld l, a ; $4394
	ld a, $02 ; $4395
	ld de, $d08e ; $4397
	call Func_00_1a27 ; $439a
	ld de, $d2a5 ; $439d
	call Func_1c_44cc ; $43a0
	pop af ; $43a3
	ld c, $00 ; $43a4
	ld de, $d2aa ; $43a6
	call Func_1c_4502 ; $43a9
	ld a, $06 ; $43ac
	ldh [$ff96], a ; $43ae
	ldh [rWBK], a ; $43b0
	ld a, [$d012] ; $43b2
	ld c, a ; $43b5
	ld a, [$d01d] ; $43b6
	add a, c ; $43b9
	push af ; $43ba
	ld h, $00 ; $43bb
	ld l, a ; $43bd
	ld a, $02 ; $43be
	ld de, $d08e ; $43c0
	call Func_00_1a27 ; $43c3
	ld de, $d2b9 ; $43c6
	call Func_1c_44cc ; $43c9
	pop af ; $43cc
	ld c, $01 ; $43cd
	ld de, $d2be ; $43cf
	call Func_1c_4502 ; $43d2
	ld a, $06 ; $43d5
	ldh [$ff96], a ; $43d7
	ldh [rWBK], a ; $43d9
	ld a, [$d013] ; $43db
	ld c, a ; $43de
	ld a, [$d01e] ; $43df
	add a, c ; $43e2
	push af ; $43e3
	ld h, $00 ; $43e4
	ld l, a ; $43e6
	ld a, $02 ; $43e7
	ld de, $d08e ; $43e9
	call Func_00_1a27 ; $43ec
	ld de, $d2e1 ; $43ef
	call Func_1c_44cc ; $43f2
	pop af ; $43f5
	ld c, $00 ; $43f6
	ld de, $d2e6 ; $43f8
	call Func_1c_4502 ; $43fb
	ld a, $06 ; $43fe
	ldh [$ff96], a ; $4400
	ldh [rWBK], a ; $4402
	ld a, [$d014] ; $4404
	ld c, a ; $4407
	ld a, [$d01f] ; $4408
	add a, c ; $440b
	push af ; $440c
	ld h, $00 ; $440d
	ld l, a ; $440f
	ld a, $02 ; $4410
	ld de, $d08e ; $4412
	call Func_00_1a27 ; $4415
	ld de, $d2f5 ; $4418
	call Func_1c_44cc ; $441b
	pop af ; $441e
	ld c, $01 ; $441f
	ld de, $d2fa ; $4421
	call Func_1c_4502 ; $4424
	ld a, $06 ; $4427
	ldh [$ff96], a ; $4429
	ldh [rWBK], a ; $442b
	ld a, [$d015] ; $442d
	ld c, a ; $4430
	ld a, [$d020] ; $4431
	add a, c ; $4434
	push af ; $4435
	ld h, $00 ; $4436
	ld l, a ; $4438
	ld a, $02 ; $4439
	ld de, $d08e ; $443b
	call Func_00_1a27 ; $443e
	ld de, $d321 ; $4441
	call Func_1c_44cc ; $4444
	pop af ; $4447
	ld c, $00 ; $4448
	ld de, $d326 ; $444a
	call Func_1c_4502 ; $444d
	ld a, $06 ; $4450
	ldh [$ff96], a ; $4452
	ldh [rWBK], a ; $4454
	ld a, [$d016] ; $4456
	ld c, a ; $4459
	ld a, [$d021] ; $445a
	add a, c ; $445d
	push af ; $445e
	ld h, $00 ; $445f
	ld l, a ; $4461
	ld a, $02 ; $4462
	ld de, $d08e ; $4464
	call Func_00_1a27 ; $4467
	ld de, $d335 ; $446a
	call Func_1c_44cc ; $446d
	pop af ; $4470
	ld c, $00 ; $4471
	ld de, $d33a ; $4473
	call Func_1c_4502 ; $4476
	ld a, $06 ; $4479
	ldh [$ff96], a ; $447b
	ldh [rWBK], a ; $447d
	ld a, [$d017] ; $447f
	ld c, a ; $4482
	ld a, [$d022] ; $4483
	add a, c ; $4486
	push af ; $4487
	ld h, $00 ; $4488
	ld l, a ; $448a
	ld a, $02 ; $448b
	ld de, $d08e ; $448d
	call Func_00_1a27 ; $4490
	ld de, $d349 ; $4493
	call Func_1c_44cc ; $4496
	pop af ; $4499
	ld c, $00 ; $449a
	ld de, $d34e ; $449c
	call Func_1c_4502 ; $449f
	ld a, $06 ; $44a2
	ldh [$ff96], a ; $44a4
	ldh [rWBK], a ; $44a6
	ld a, [$d018] ; $44a8
	ld c, a ; $44ab
	ld a, [$d023] ; $44ac
	add a, c ; $44af
	push af ; $44b0
	ld h, $00 ; $44b1
	ld l, a ; $44b3
	ld a, $02 ; $44b4
	ld de, $d08e ; $44b6
	call Func_00_1a27 ; $44b9
	ld de, $d35d ; $44bc
	call Func_1c_44cc ; $44bf
	pop af ; $44c2
	ld c, $01 ; $44c3
	ld de, $d362 ; $44c5
	call Func_1c_4502 ; $44c8
	ret ; $44cb
Func_1c_44cc:
	ld a, $06 ; $44cc
	ldh [$ff96], a ; $44ce
	ldh [rWBK], a ; $44d0
	ld a, [$d08e] ; $44d2
	ld c, a ; $44d5
	ld a, $03 ; $44d6
	ldh [$ff96], a ; $44d8
	ldh [rWBK], a ; $44da
	ld a, c ; $44dc
	ld [de], a ; $44dd
	ld a, $02 ; $44de
	ldh [$ff96], a ; $44e0
	ldh [rWBK], a ; $44e2
	xor a, a ; $44e4
	ld [de], a ; $44e5
	inc de ; $44e6
	ld a, $06 ; $44e7
	ldh [$ff96], a ; $44e9
	ldh [rWBK], a ; $44eb
	ld a, [$d08f] ; $44ed
	ld c, a ; $44f0
	ld a, $03 ; $44f1
	ldh [$ff96], a ; $44f3
	ldh [rWBK], a ; $44f5
	ld a, c ; $44f7
	ld [de], a ; $44f8
	ld a, $02 ; $44f9
	ldh [$ff96], a ; $44fb
	ldh [rWBK], a ; $44fd
	xor a, a ; $44ff
	ld [de], a ; $4500
	ret ; $4501
Func_1c_4502:
	ld b, a ; $4502
	ld a, c ; $4503
	or a, a ; $4504
	jr nz, Label_1c_4515 ; $4505
	ld a, b ; $4507
	rlca ; $4508
	add a, $58 ; $4509
	ld l, a ; $450b
	adc a, $45 ; $450c
	sub a, l ; $450e
	ld h, a ; $450f
	ld a, [hl+] ; $4510
	ld h, [hl] ; $4511
	ld l, a ; $4512
	jr Label_1c_4521 ; $4513
Label_1c_4515:
	ld a, b ; $4515
	rlca ; $4516
	add a, $6e ; $4517
	ld l, a ; $4519
	adc a, $45 ; $451a
	sub a, l ; $451c
	ld h, a ; $451d
	ld a, [hl+] ; $451e
	ld h, [hl] ; $451f
	ld l, a ; $4520
Label_1c_4521:
	push de ; $4521
	ld a, $03 ; $4522
	ldh [$ff96], a ; $4524
	ldh [rWBK], a ; $4526
	ld a, [hl+] ; $4528
	ld [de], a ; $4529
	inc de ; $452a
	ld a, [hl+] ; $452b
	ld [de], a ; $452c
	inc de ; $452d
	ld a, [hl+] ; $452e
	ld [de], a ; $452f
	inc de ; $4530
	ld a, [hl+] ; $4531
	ld [de], a ; $4532
	inc de ; $4533
	ld a, [hl] ; $4534
	ld [de], a ; $4535
	ld a, $02 ; $4536
	ldh [$ff96], a ; $4538
	ldh [rWBK], a ; $453a
	ld a, b ; $453c
	rlca ; $453d
	add a, $84 ; $453e
	ld l, a ; $4540
	adc a, $45 ; $4541
	sub a, l ; $4543
	ld h, a ; $4544
	ld a, [hl+] ; $4545
	ld h, [hl] ; $4546
	ld l, a ; $4547
	pop de ; $4548
	ld a, [hl+] ; $4549
	ld [de], a ; $454a
	inc de ; $454b
	ld a, [hl+] ; $454c
	ld [de], a ; $454d
	inc de ; $454e
	ld a, [hl+] ; $454f
	ld [de], a ; $4550
	inc de ; $4551
	ld a, [hl+] ; $4552
	ld [de], a ; $4553
	inc de ; $4554
	ld a, [hl] ; $4555
	ld [de], a ; $4556
	ret ; $4557
	INCBIN "data/bank_01c/d_4558.bin" ; $4558, 162 bytes
	push af ; $45fa
	push bc ; $45fb
	push de ; $45fc
	push hl ; $45fd
	ldh a, [$ff96] ; $45fe
	push af ; $4600
	ld a, $06 ; $4601
	ldh [$ff96], a ; $4603
	ldh [rWBK], a ; $4605
	ld a, [$d002] ; $4607
	or a, a ; $460a
	jp nz, Label_1c_4666 ; $460b
	ld a, $06 ; $460e
	ldh [$ff96], a ; $4610
	ldh [rWBK], a ; $4612
	ld a, [$d000] ; $4614
	inc a ; $4617
	ld [$d000], a ; $4618
	and a, $0f ; $461b
	rlca ; $461d
	push af ; $461e
	add a, $79 ; $461f
	ld l, a ; $4621
	adc a, $56 ; $4622
	sub a, l ; $4624
	ld h, a ; $4625
	ld a, [hl+] ; $4626
	ld h, [hl] ; $4627
	ld l, a ; $4628
	push hl ; $4629
	ld de, $b2e0 ; $462a
	ld c, $02 ; $462d
	call Func_00_0480 ; $462f
	pop hl ; $4632
	ld a, $20 ; $4633
	add a, l ; $4635
	ld l, a ; $4636
	jr nc, Label_1c_463a ; $4637
	inc h ; $4639
Label_1c_463a:
	ld de, $b3e0 ; $463a
	ld c, $02 ; $463d
	call Func_00_0480 ; $463f
	pop af ; $4642
	add a, $99 ; $4643
	ld l, a ; $4645
	adc a, $56 ; $4646
	sub a, l ; $4648
	ld h, a ; $4649
	ld a, [hl+] ; $464a
	ld h, [hl] ; $464b
	ld l, a ; $464c
	push hl ; $464d
	ld de, $b4e0 ; $464e
	ld c, $02 ; $4651
	call Func_00_0480 ; $4653
	pop hl ; $4656
	ld a, $20 ; $4657
	add a, l ; $4659
	ld l, a ; $465a
	jr nc, Label_1c_465e ; $465b
	inc h ; $465d
Label_1c_465e:
	ld de, $b5e0 ; $465e
	ld c, $02 ; $4661
	call Func_00_0480 ; $4663
Label_1c_4666:
	ld a, $06 ; $4666
	ldh [$ff96], a ; $4668
	ldh [rWBK], a ; $466a
	ld a, [$d002] ; $466c
	inc a ; $466f
	cp a, $03 ; $4670
	jr nz, Label_1c_4675 ; $4672
	xor a, a ; $4674
Label_1c_4675:
	ld [$d002], a ; $4675
	pop af ; $4678
	ldh [$ff96], a ; $4679
	ldh [rWBK], a ; $467b
	pop hl ; $467d
	pop de ; $467e
	pop bc ; $467f
	pop af ; $4680
	ret ; $4681
	INCBIN "data/bank_01c/d_4682.bin" ; $4682, 1473 bytes
Func_1c_4c43:
	ld a, $06 ; $4c43
	ldh [$ff96], a ; $4c45
	ldh [rWBK], a ; $4c47
	push af ; $4c49
	ld hl, $c900 ; $4c4a
	ld a, [$cb00] ; $4c4d
	or a, a ; $4c50
	jr z, Label_1c_4c55 ; $4c51
	ld l, $40 ; $4c53
Label_1c_4c55:
	ld a, l ; $4c55
	add a, $38 ; $4c56
	ld l, a ; $4c58
	ld a, h ; $4c59
	adc a, $00 ; $4c5a
	ld h, a ; $4c5c
	pop af ; $4c5d
	ld a, [hl] ; $4c5e
	ld [$d00a], a ; $4c5f
	push af ; $4c62
	ld hl, $c900 ; $4c63
	ld a, [$cb00] ; $4c66
	or a, a ; $4c69
	jr z, Label_1c_4c6e ; $4c6a
	ld l, $40 ; $4c6c
Label_1c_4c6e:
	ld a, l ; $4c6e
	add a, $20 ; $4c6f
	ld l, a ; $4c71
	ld a, h ; $4c72
	adc a, $00 ; $4c73
	ld h, a ; $4c75
	pop af ; $4c76
	ld a, [hl] ; $4c77
	inc a ; $4c78
	ld [$d00e], a ; $4c79
	push af ; $4c7c
	ld hl, $c900 ; $4c7d
	ld a, [$cb00] ; $4c80
	or a, a ; $4c83
	jr z, Label_1c_4c88 ; $4c84
	ld l, $40 ; $4c86
Label_1c_4c88:
	ld a, l ; $4c88
	add a, $21 ; $4c89
	ld l, a ; $4c8b
	ld a, h ; $4c8c
	adc a, $00 ; $4c8d
	ld h, a ; $4c8f
	pop af ; $4c90
	ld a, [hl] ; $4c91
	inc a ; $4c92
	ld [$d00f], a ; $4c93
	push af ; $4c96
	ld hl, $c900 ; $4c97
	ld a, [$cb00] ; $4c9a
	or a, a ; $4c9d
	jr z, Label_1c_4ca2 ; $4c9e
	ld l, $40 ; $4ca0
Label_1c_4ca2:
	ld a, l ; $4ca2
	add a, $39 ; $4ca3
	ld l, a ; $4ca5
	ld a, h ; $4ca6
	adc a, $00 ; $4ca7
	ld h, a ; $4ca9
	pop af ; $4caa
	ld a, [hl] ; $4cab
	ld [$d00b], a ; $4cac
	push af ; $4caf
	ld hl, $c900 ; $4cb0
	ld a, [$cb00] ; $4cb3
	or a, a ; $4cb6
	jr z, Label_1c_4cbb ; $4cb7
	ld l, $40 ; $4cb9
Label_1c_4cbb:
	ld a, l ; $4cbb
	add a, $22 ; $4cbc
	ld l, a ; $4cbe
	ld a, h ; $4cbf
	adc a, $00 ; $4cc0
	ld h, a ; $4cc2
	pop af ; $4cc3
	ld a, [hl] ; $4cc4
	inc a ; $4cc5
	ld [$d010], a ; $4cc6
	push af ; $4cc9
	ld hl, $c900 ; $4cca
	ld a, [$cb00] ; $4ccd
	or a, a ; $4cd0
	jr z, Label_1c_4cd5 ; $4cd1
	ld l, $40 ; $4cd3
Label_1c_4cd5:
	ld a, l ; $4cd5
	add a, $23 ; $4cd6
	ld l, a ; $4cd8
	ld a, h ; $4cd9
	adc a, $00 ; $4cda
	ld h, a ; $4cdc
	pop af ; $4cdd
	ld a, [hl] ; $4cde
	inc a ; $4cdf
	ld [$d011], a ; $4ce0
	push af ; $4ce3
	ld hl, $c900 ; $4ce4
	ld a, [$cb00] ; $4ce7
	or a, a ; $4cea
	jr z, Label_1c_4cef ; $4ceb
	ld l, $40 ; $4ced
Label_1c_4cef:
	ld a, l ; $4cef
	add a, $24 ; $4cf0
	ld l, a ; $4cf2
	ld a, h ; $4cf3
	adc a, $00 ; $4cf4
	ld h, a ; $4cf6
	pop af ; $4cf7
	ld a, [hl] ; $4cf8
	inc a ; $4cf9
	ld [$d012], a ; $4cfa
	push af ; $4cfd
	ld hl, $c900 ; $4cfe
	ld a, [$cb00] ; $4d01
	or a, a ; $4d04
	jr z, Label_1c_4d09 ; $4d05
	ld l, $40 ; $4d07
Label_1c_4d09:
	ld a, l ; $4d09
	add a, $3a ; $4d0a
	ld l, a ; $4d0c
	ld a, h ; $4d0d
	adc a, $00 ; $4d0e
	ld h, a ; $4d10
	pop af ; $4d11
	ld a, [hl] ; $4d12
	ld [$d00c], a ; $4d13
	push af ; $4d16
	ld hl, $c900 ; $4d17
	ld a, [$cb00] ; $4d1a
	or a, a ; $4d1d
	jr z, Label_1c_4d22 ; $4d1e
	ld l, $40 ; $4d20
Label_1c_4d22:
	ld a, l ; $4d22
	add a, $25 ; $4d23
	ld l, a ; $4d25
	ld a, h ; $4d26
	adc a, $00 ; $4d27
	ld h, a ; $4d29
	pop af ; $4d2a
	ld a, [hl] ; $4d2b
	inc a ; $4d2c
	ld [$d013], a ; $4d2d
	push af ; $4d30
	ld hl, $c900 ; $4d31
	ld a, [$cb00] ; $4d34
	or a, a ; $4d37
	jr z, Label_1c_4d3c ; $4d38
	ld l, $40 ; $4d3a
Label_1c_4d3c:
	ld a, l ; $4d3c
	add a, $26 ; $4d3d
	ld l, a ; $4d3f
	ld a, h ; $4d40
	adc a, $00 ; $4d41
	ld h, a ; $4d43
	pop af ; $4d44
	ld a, [hl] ; $4d45
	inc a ; $4d46
	ld [$d014], a ; $4d47
	push af ; $4d4a
	ld hl, $c900 ; $4d4b
	ld a, [$cb00] ; $4d4e
	or a, a ; $4d51
	jr z, Label_1c_4d56 ; $4d52
	ld l, $40 ; $4d54
Label_1c_4d56:
	ld a, l ; $4d56
	add a, $3b ; $4d57
	ld l, a ; $4d59
	ld a, h ; $4d5a
	adc a, $00 ; $4d5b
	ld h, a ; $4d5d
	pop af ; $4d5e
	ld a, [hl] ; $4d5f
	ld [$d00d], a ; $4d60
	push af ; $4d63
	ld hl, $c900 ; $4d64
	ld a, [$cb00] ; $4d67
	or a, a ; $4d6a
	jr z, Label_1c_4d6f ; $4d6b
	ld l, $40 ; $4d6d
Label_1c_4d6f:
	ld a, l ; $4d6f
	add a, $27 ; $4d70
	ld l, a ; $4d72
	ld a, h ; $4d73
	adc a, $00 ; $4d74
	ld h, a ; $4d76
	pop af ; $4d77
	ld a, [hl] ; $4d78
	inc a ; $4d79
	ld [$d015], a ; $4d7a
	push af ; $4d7d
	ld hl, $c900 ; $4d7e
	ld a, [$cb00] ; $4d81
	or a, a ; $4d84
	jr z, Label_1c_4d89 ; $4d85
	ld l, $40 ; $4d87
Label_1c_4d89:
	ld a, l ; $4d89
	add a, $28 ; $4d8a
	ld l, a ; $4d8c
	ld a, h ; $4d8d
	adc a, $00 ; $4d8e
	ld h, a ; $4d90
	pop af ; $4d91
	ld a, [hl] ; $4d92
	inc a ; $4d93
	ld [$d016], a ; $4d94
	push af ; $4d97
	ld hl, $c900 ; $4d98
	ld a, [$cb00] ; $4d9b
	or a, a ; $4d9e
	jr z, Label_1c_4da3 ; $4d9f
	ld l, $40 ; $4da1
Label_1c_4da3:
	ld a, l ; $4da3
	add a, $29 ; $4da4
	ld l, a ; $4da6
	ld a, h ; $4da7
	adc a, $00 ; $4da8
	ld h, a ; $4daa
	pop af ; $4dab
	ld a, [hl] ; $4dac
	inc a ; $4dad
	ld [$d017], a ; $4dae
	push af ; $4db1
	ld hl, $c900 ; $4db2
	ld a, [$cb00] ; $4db5
	or a, a ; $4db8
	jr z, Label_1c_4dbd ; $4db9
	ld l, $40 ; $4dbb
Label_1c_4dbd:
	ld a, l ; $4dbd
	add a, $2a ; $4dbe
	ld l, a ; $4dc0
	ld a, h ; $4dc1
	adc a, $00 ; $4dc2
	ld h, a ; $4dc4
	pop af ; $4dc5
	ld a, [hl] ; $4dc6
	inc a ; $4dc7
	ld [$d018], a ; $4dc8
	ld hl, $d019 ; $4dcb
	ld b, $0b ; $4dce
	xor a, a ; $4dd0
Label_1c_4dd1:
	ld [hl+], a ; $4dd1
	dec b ; $4dd2
	jr nz, Label_1c_4dd1 ; $4dd3
	ret ; $4dd5
	INCBIN "data/bank_01c/d_4dd6.bin" ; $4dd6, 5036 bytes
	rst Rst18 ; $6182
	and a, a ; $6183
	rst Rst38 ; $6184
	ld sp, hl ; $6185
	rst Rst10 ; $6186
	ld sp, hl ; $6187
	adc a, e ; $6188
	INCBIN "data/bank_01c/d_6189.bin" ; $6189, 3464 bytes
	rst Rst08 ; $6f11
	INCBIN "data/bank_01c/d_6f12.bin" ; $6f12, 516 bytes
	ld hl, $598c ; $7116
	ld de, $0008 ; $7119
	call Func_00_05b0 ; $711c
	ld hl, $598c ; $711f
	ld de, $0808 ; $7122
	call Func_00_05b0 ; $7125
	ld a, $01 ; $7128
	ldh [$ff96], a ; $712a
	ldh [rWBK], a ; $712c
	ld hl, $7080 ; $712e
	ld de, $d000 ; $7131
	call DecompressData ; $7134
	ld hl, $d000 ; $7137
	ld de, $a000 ; $713a
	ld c, $14 ; $713d
	call Func_00_0480 ; $713f
	rst Rst18 ; $7142
	INCBIN "data/bank_01c/d_7143.bin" ; $7143, 2 bytes
	ld a, $01 ; $7145
	ldh [$ff96], a ; $7147
	ldh [rWBK], a ; $7149
	ld hl, $59cc ; $714b
	ld de, $d000 ; $714e
	call DecompressData ; $7151
	ld hl, $d000 ; $7154
	ld de, $b000 ; $7157
	ld c, $80 ; $715a
	call Func_00_0480 ; $715c
	ld hl, $d800 ; $715f
	ld de, $a800 ; $7162
	ld c, $80 ; $7165
	call Func_00_0480 ; $7167
	ld a, $01 ; $716a
	ldh [$ff96], a ; $716c
	ldh [rWBK], a ; $716e
	ld hl, $6406 ; $7170
	ld de, $d000 ; $7173
	call DecompressData ; $7176
	ld hl, $d000 ; $7179
	ld bc, $0240 ; $717c
	call Func_1c_42cc ; $717f
	ld a, $01 ; $7182
	ldh [$ff96], a ; $7184
	ldh [rWBK], a ; $7186
	ld hl, $6469 ; $7188
	ld de, $d000 ; $718b
	call DecompressData ; $718e
	ld hl, $d000 ; $7191
	ld bc, $0240 ; $7194
	call Func_1c_42e1 ; $7197
	ld a, $01 ; $719a
	ldh [$ff96], a ; $719c
	ldh [rWBK], a ; $719e
	ld hl, $6549 ; $71a0
	ld de, $d240 ; $71a3
	call DecompressData ; $71a6
	ld hl, $d240 ; $71a9
	ld bc, $0032 ; $71ac
	call Func_1c_42cc ; $71af
	ld a, $01 ; $71b2
	ldh [$ff96], a ; $71b4
	ldh [rWBK], a ; $71b6
	ld hl, $657f ; $71b8
	ld de, $d240 ; $71bb
	call DecompressData ; $71be
	ld hl, $d240 ; $71c1
	ld bc, $0032 ; $71c4
	call Func_1c_42e1 ; $71c7
	ld a, $01 ; $71ca
	ldh [$ff96], a ; $71cc
	ldh [rWBK], a ; $71ce
	ld hl, $65c8 ; $71d0
	ld de, $d280 ; $71d3
	call DecompressData ; $71d6
	ld hl, $d280 ; $71d9
	ld bc, $0046 ; $71dc
	call Func_1c_42cc ; $71df
	ld a, $01 ; $71e2
	ldh [$ff96], a ; $71e4
	ldh [rWBK], a ; $71e6
	ld hl, $660b ; $71e8
	ld de, $d280 ; $71eb
	call DecompressData ; $71ee
	ld hl, $d280 ; $71f1
	ld bc, $0046 ; $71f4
	call Func_1c_42e1 ; $71f7
	ld a, $01 ; $71fa
	ldh [$ff96], a ; $71fc
	ldh [rWBK], a ; $71fe
	ld hl, $6668 ; $7200
	ld de, $d2d0 ; $7203
	call DecompressData ; $7206
	ld hl, $d2d0 ; $7209
	ld bc, $0032 ; $720c
	call Func_1c_42cc ; $720f
	ld a, $01 ; $7212
	ldh [$ff96], a ; $7214
	ldh [rWBK], a ; $7216
	ld hl, $66a2 ; $7218
	ld de, $d2d0 ; $721b
	call DecompressData ; $721e
	ld hl, $d2d0 ; $7221
	ld bc, $0032 ; $7224
	call Func_1c_42e1 ; $7227
	ld a, $01 ; $722a
	ldh [$ff96], a ; $722c
	ldh [rWBK], a ; $722e
	ld hl, $66ec ; $7230
	ld de, $d310 ; $7233
	call DecompressData ; $7236
	ld hl, $d310 ; $7239
	ld bc, $005a ; $723c
	call Func_1c_42cc ; $723f
	ld a, $01 ; $7242
	ldh [$ff96], a ; $7244
	ldh [rWBK], a ; $7246
	ld hl, $6734 ; $7248
	ld de, $d310 ; $724b
	call DecompressData ; $724e
	ld hl, $d310 ; $7251
	ld bc, $005a ; $7254
	call Func_1c_42e1 ; $7257
	ld a, $01 ; $725a
	ldh [$ff96], a ; $725c
	ldh [rWBK], a ; $725e
	ld hl, $67c5 ; $7260
	ld de, $d370 ; $7263
	call DecompressData ; $7266
	ld hl, $d370 ; $7269
	ld bc, $0009 ; $726c
	call Func_1c_42cc ; $726f
	ld a, $01 ; $7272
	ldh [$ff96], a ; $7274
	ldh [rWBK], a ; $7276
	ld hl, $67d3 ; $7278
	ld de, $d370 ; $727b
	call DecompressData ; $727e
	ld hl, $d370 ; $7281
	ld bc, $0009 ; $7284
	call Func_1c_42e1 ; $7287
	ret ; $728a
	ld a, $01 ; $728b
	ldh [$ff96], a ; $728d
	ldh [rWBK], a ; $728f
	ld hl, $682e ; $7291
	ld de, $d550 ; $7294
	call DecompressData ; $7297
	ld hl, $d550 ; $729a
	ld bc, $0021 ; $729d
	call Func_1c_42cc ; $72a0
	ld a, $01 ; $72a3
	ldh [$ff96], a ; $72a5
	ldh [rWBK], a ; $72a7
	ld hl, $6848 ; $72a9
	ld de, $d550 ; $72ac
	call DecompressData ; $72af
	ld hl, $d550 ; $72b2
	ld bc, $0021 ; $72b5
	call Func_1c_42e1 ; $72b8
	ld a, $01 ; $72bb
	ldh [$ff96], a ; $72bd
	ldh [rWBK], a ; $72bf
	ld hl, $684f ; $72c1
	ld de, $d580 ; $72c4
	call DecompressData ; $72c7
	ld hl, $d580 ; $72ca
	ld bc, $0018 ; $72cd
	call Func_1c_42cc ; $72d0
	ld a, $01 ; $72d3
	ldh [$ff96], a ; $72d5
	ldh [rWBK], a ; $72d7
	ld hl, $686b ; $72d9
	ld de, $d580 ; $72dc
	call DecompressData ; $72df
	ld hl, $d580 ; $72e2
	ld bc, $0018 ; $72e5
	call Func_1c_42e1 ; $72e8
	ret ; $72eb
	ld a, $01 ; $72ec
	ld hl, $45fa ; $72ee
	call Func_00_1b6a ; $72f1
	ret ; $72f4
	ld hl, $45fa ; $72f5
	call Func_00_1bcb ; $72f8
	ret ; $72fb
	INCBIN "data/bank_01c/d_72fc.bin" ; $72fc, 3332 bytes
