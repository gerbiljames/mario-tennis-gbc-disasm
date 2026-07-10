INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $13", ROMX[$4000], BANK[$13]

	INCBIN "data/bank_013/d_4000.bin" ; $4000, 165 bytes
	ld a, [$c295] ; $40a5
	cp a, $ff ; $40a8
	jp z, Label_13_40ea ; $40aa
	rst Rst30 ; $40ad
	ldh [rTIMA], a ; $40ae
	jr z, Label_13_40d8 ; $40b0
	ld a, $02 ; $40b2
	ld bc, $00ff ; $40b4
	farcall FarPtr_0a_18 ; $40b7
	ld a, $02 ; $40ba
	ld b, $00 ; $40bc
	ld de, $0200 ; $40be
	farcall FarPtr_0a_2a ; $40c1
	ld a, $02 ; $40c4
	farcall FarPtr_0a_20 ; $40c6
	ld a, $02 ; $40c9
	ld b, $80 ; $40cb
	farcall FarPtr_0a_2e ; $40cd
	ld a, $02 ; $40d0
	ld bc, $0010 ; $40d2
	farcall FarPtr_0a_18 ; $40d5
Label_13_40d8:
	ld a, $00 ; $40d8
	ld bc, $0010 ; $40da
	farcall FarPtr_0a_18 ; $40dd
	ld a, $00 ; $40e0
	ld b, $80 ; $40e2
	ld de, $0200 ; $40e4
	farcall FarPtr_0a_2a ; $40e7
Label_13_40ea:
	ret ; $40ea
	ld a, [$c295] ; $40eb
	cp a, $ff ; $40ee
	jp z, Label_13_4235 ; $40f0
	ld a, $00 ; $40f3
	ld bc, $0018 ; $40f5
	farcall FarPtr_0a_18 ; $40f8
	ld a, $00 ; $40fb
	ld d, $08 ; $40fd
	farcall FarPtr_0a_34 ; $40ff
	ld a, $02 ; $4102
	ld bc, $0018 ; $4104
	farcall FarPtr_0a_18 ; $4107
	ld a, $02 ; $410a
	ld d, $08 ; $410c
	farcall FarPtr_0a_34 ; $410e
	ld c, $08 ; $4111
	call Func_00_1d2e ; $4113
	push af ; $4116
	ld a, $14 ; $4117
	farcall FarPtr_0a_04 ; $4119
	pop af ; $411c
	ld a, $00 ; $411d
	ld bc, $0700 ; $411f
	ld de, $0c80 ; $4122
	farcall FarPtr_0a_24 ; $4125
	push af ; $4128
	ld a, $14 ; $4129
	farcall FarPtr_0a_04 ; $412b
	pop af ; $412e
	ld a, $02 ; $412f
	ld bc, $0700 ; $4131
	ld de, $0b00 ; $4134
	farcall FarPtr_0a_24 ; $4137
	push af ; $413a
	ld a, $14 ; $413b
	farcall FarPtr_0a_04 ; $413d
	pop af ; $4140
	ld a, $00 ; $4141
	ld d, $01 ; $4143
	farcall FarPtr_0a_34 ; $4145
	push af ; $4148
	ld a, $0a ; $4149
	farcall FarPtr_0a_04 ; $414b
	pop af ; $414e
	ld a, $02 ; $414f
	ld d, $01 ; $4151
	farcall FarPtr_0a_34 ; $4153
	ld a, $00 ; $4156
	farcall FarPtr_0a_20 ; $4158
	ld a, $00 ; $415b
	ld b, $00 ; $415d
	farcall FarPtr_0a_2e ; $415f
	ret ; $4162
	ld a, [$c295] ; $4163
	cp a, $ff ; $4166
	jp z, Label_13_4235 ; $4168
	ld b, $14 ; $416b
	ld c, $08 ; $416d
	ld d, $06 ; $416f
	ld e, $15 ; $4171
	ld h, $02 ; $4173
	ld l, $02 ; $4175
	farcall FarPtr_0a_7e ; $4177
	ld b, $04 ; $417a
	ld c, $15 ; $417c
	ld d, $14 ; $417e
	ld e, $08 ; $4180
	ld h, $02 ; $4182
	ld l, $02 ; $4184
	farcall FarPtr_0a_7e ; $4186
	ld a, $00 ; $4189
	ld bc, $0018 ; $418b
	farcall FarPtr_0a_18 ; $418e
	ld c, $08 ; $4191
	call Func_00_1d2e ; $4193
	call Func_00_1da4 ; $4196
	push af ; $4199
	ld a, $05 ; $419a
	farcall FarPtr_0a_04 ; $419c
	pop af ; $419f
	rst Rst08 ; $41a0
	ld d, b ; $41a1
	push af ; $41a2
	ld a, $05 ; $41a3
	farcall FarPtr_0a_04 ; $41a5
	pop af ; $41a8
	ld a, $00 ; $41a9
	ld bc, $1500 ; $41ab
	ld de, $0d00 ; $41ae
	farcall FarPtr_0a_24 ; $41b1
	ld a, $02 ; $41b4
	ld bc, $1500 ; $41b6
	ld de, $0b00 ; $41b9
	farcall FarPtr_0a_24 ; $41bc
	rst Rst30 ; $41bf
	ldh [rTIMA], a ; $41c0
	jr z, Label_13_41cb ; $41c2
	push af ; $41c4
	ld a, $0c ; $41c5
	farcall FarPtr_0a_04 ; $41c7
	pop af ; $41ca
Label_13_41cb:
	call Func_13_4dcc ; $41cb
	ret ; $41ce
	INCBIN "data/bank_013/d_41cf.bin" ; $41cf, 102 bytes
Label_13_4235:
	ret ; $4235
	INCBIN "data/bank_013/d_4236.bin" ; $4236, 168 bytes
	ld a, $02 ; $42de
	ld bc, $0700 ; $42e0
	ld de, $0d00 ; $42e3
	farcall FarPtr_0a_24 ; $42e6
	ld a, $00 ; $42e9
	ld bc, $0010 ; $42eb
	farcall FarPtr_0a_18 ; $42ee
	ld a, $00 ; $42f1
	ld b, $c0 ; $42f3
	ld de, $0100 ; $42f5
	farcall FarPtr_0a_2a ; $42f8
	ld a, $00 ; $42fb
	farcall FarPtr_0a_20 ; $42fd
	call Func_13_4425 ; $4300
	ld a, $01 ; $4303
	ld [$c294], a ; $4305
	ld [$c2a1], a ; $4308
	ret ; $430b
	ld a, $00 ; $430c
	ld bc, $0010 ; $430e
	farcall FarPtr_0a_18 ; $4311
	ld a, $02 ; $4314
	ld bc, $1500 ; $4316
	ld de, $0d00 ; $4319
	farcall FarPtr_0a_24 ; $431c
	ld a, $00 ; $431f
	ld b, $c2 ; $4321
	ld de, $0200 ; $4323
	farcall FarPtr_0a_2a ; $4326
	ld a, $00 ; $4329
	farcall FarPtr_0a_20 ; $432b
	call Func_13_4d78 ; $432e
	ld a, $00 ; $4331
	ld b, $c2 ; $4333
	ld de, $0200 ; $4335
	farcall FarPtr_0a_2a ; $4338
	push af ; $433b
	ld a, $02 ; $433c
	farcall FarPtr_0a_04 ; $433e
	pop af ; $4341
	ld c, $10 ; $4342
	call Func_00_1d20 ; $4344
	push af ; $4347
	ld a, $1e ; $4348
	farcall FarPtr_0a_04 ; $434a
	pop af ; $434d
	ld a, $02 ; $434e
	ld [$c294], a ; $4350
	ld [$c2a1], a ; $4353
	ret ; $4356
	INCBIN "data/bank_013/d_4357.bin" ; $4357, 135 bytes
Label_13_43de:
	ret ; $43de
	ld a, $00 ; $43df
	ld bc, $0020 ; $43e1
	farcall FarPtr_0a_18 ; $43e4
	ld a, $02 ; $43e7
	ld bc, $3b00 ; $43e9
	ld de, $0d00 ; $43ec
	farcall FarPtr_0a_24 ; $43ef
	ld a, $00 ; $43f2
	ld b, $00 ; $43f4
	ld de, $0600 ; $43f6
	farcall FarPtr_0a_2a ; $43f9
	push af ; $43fc
	ld a, $3c ; $43fd
	farcall FarPtr_0a_04 ; $43ff
	pop af ; $4402
	ld c, $10 ; $4403
	call Func_00_1d20 ; $4405
	push af ; $4408
	ld a, $1e ; $4409
	farcall FarPtr_0a_04 ; $440b
	pop af ; $440e
	rst Rst30 ; $440f
	ldh [rTIMA], a ; $4410
	ld a, $06 ; $4412
	ld [$c294], a ; $4414
	ld [$c2a1], a ; $4417
	jr z, Label_13_43de ; $441a
	ld a, $06 ; $441c
	ld [$c294], a ; $441e
	ld [$c2a1], a ; $4421
	ret ; $4424
Func_13_4425:
	rst Rst30 ; $4425
	ldh [rTIMA], a ; $4426
	jr nz, Label_13_446a ; $4428
	ld a, $00 ; $442a
	ld b, $c0 ; $442c
	farcall FarPtr_0a_2e ; $442e
	ld a, $00 ; $4431
	ld b, $c8 ; $4433
	ld de, $0400 ; $4435
	farcall FarPtr_0a_2a ; $4438
	ld a, $00 ; $443b
	ld bc, $0010 ; $443d
	farcall FarPtr_0a_18 ; $4440
	push af ; $4443
	ld a, $28 ; $4444
	farcall FarPtr_0a_04 ; $4446
	pop af ; $4449
	ld a, $00 ; $444a
	ld d, $08 ; $444c
	farcall FarPtr_0a_34 ; $444e
	ld c, $08 ; $4451
	call Func_00_1d20 ; $4453
	ld a, $00 ; $4456
	farcall FarPtr_0a_20 ; $4458
	ld a, $00 ; $445b
	ld b, $00 ; $445d
	farcall FarPtr_0a_48 ; $445f
	push af ; $4462
	ld a, $0a ; $4463
	farcall FarPtr_0a_04 ; $4465
	pop af ; $4468
	ret ; $4469
Label_13_446a:
	ld a, $02 ; $446a
	farcall FarPtr_0a_20 ; $446c
	ld a, $00 ; $446f
	ld b, $c8 ; $4471
	ld de, $0280 ; $4473
	farcall FarPtr_0a_2a ; $4476
	ld a, $00 ; $4479
	ld bc, $0010 ; $447b
	farcall FarPtr_0a_18 ; $447e
	ld a, $02 ; $4481
	ld bc, $0010 ; $4483
	farcall FarPtr_0a_18 ; $4486
	push af ; $4489
	ld a, $0a ; $448a
	farcall FarPtr_0a_04 ; $448c
	pop af ; $448f
	ld a, $02 ; $4490
	ld b, $ca ; $4492
	ld de, $0500 ; $4494
	farcall FarPtr_0a_2a ; $4497
	ld a, $00 ; $449a
	farcall FarPtr_0a_20 ; $449c
	ld a, $00 ; $449f
	ld d, $08 ; $44a1
	farcall FarPtr_0a_34 ; $44a3
	ld a, $00 ; $44a6
	ld b, $ca ; $44a8
	ld de, $0100 ; $44aa
	farcall FarPtr_0a_2a ; $44ad
	ld a, $02 ; $44b0
	farcall FarPtr_0a_20 ; $44b2
	ld a, $02 ; $44b5
	ld d, $08 ; $44b7
	farcall FarPtr_0a_34 ; $44b9
	ld a, $02 ; $44bc
	ld b, $ca ; $44be
	ld de, $0200 ; $44c0
	farcall FarPtr_0a_2a ; $44c3
	ld a, $00 ; $44c6
	farcall FarPtr_0a_20 ; $44c8
	ld a, $00 ; $44cb
	ld b, $00 ; $44cd
	farcall FarPtr_0a_48 ; $44cf
	ld c, $10 ; $44d2
	call Func_00_1d20 ; $44d4
	push af ; $44d7
	ld a, $0a ; $44d8
	farcall FarPtr_0a_04 ; $44da
	pop af ; $44dd
	ret ; $44de
	ld a, [$c295] ; $44df
	cp a, $0f ; $44e2
	jr nz, Label_13_44e9 ; $44e4
	call Func_13_44f1 ; $44e6
Label_13_44e9:
	cp a, $0e ; $44e9
	jr nz, Label_13_44f0 ; $44eb
	call Func_13_476e ; $44ed
Label_13_44f0:
	ret ; $44f0
Func_13_44f1:
	ldh a, [$ff95] ; $44f1
	ld hl, $472c ; $44f3
	farcall FarPtr_0a_06 ; $44f6
	farcall FarPtr_0a_00 ; $44f9
	ld a, $00 ; $44fc
	ld bc, $3f00 ; $44fe
	ld de, $3f00 ; $4501
	farcall FarPtr_0a_22 ; $4504
	ld a, $06 ; $4507
	ld bc, $3f00 ; $4509
	ld de, $3f00 ; $450c
	farcall FarPtr_0a_22 ; $450f
	call Func_13_4cdc ; $4512
	ld c, $04 ; $4515
	call Func_00_1d2e ; $4517
	call Func_00_1da4 ; $451a
	ld a, $06 ; $451d
	ld bc, $3200 ; $451f
	ld de, $1300 ; $4522
	farcall FarPtr_0a_22 ; $4525
	ld a, $06 ; $4528
	ld bc, $3200 ; $452a
	ld de, $0d00 ; $452d
	farcall FarPtr_0a_24 ; $4530
	push af ; $4533
	ld a, $0f ; $4534
	farcall FarPtr_0a_04 ; $4536
	pop af ; $4539
	ld a, $00 ; $453a
	ld bc, $3200 ; $453c
	ld de, $1300 ; $453f
	farcall FarPtr_0a_22 ; $4542
	ld a, $00 ; $4545
	ld bc, $3200 ; $4547
	ld de, $0f00 ; $454a
	farcall FarPtr_0a_24 ; $454d
	ld a, $00 ; $4550
	farcall FarPtr_0a_20 ; $4552
	push af ; $4555
	ld a, $1e ; $4556
	farcall FarPtr_0a_04 ; $4558
	pop af ; $455b
	ld a, $00 ; $455c
	ld b, a ; $455e
	ld a, $06 ; $455f
	farcall FarPtr_0a_30 ; $4561
	push af ; $4564
	ld a, $3c ; $4565
	farcall FarPtr_0a_04 ; $4567
	pop af ; $456a
	ld a, $06 ; $456b
	ld b, $00 ; $456d
	farcall FarPtr_0a_2e ; $456f
	push af ; $4572
	ld a, $0f ; $4573
	farcall FarPtr_0a_04 ; $4575
	pop af ; $4578
	ld a, $00 ; $4579
	ld b, $00 ; $457b
	farcall FarPtr_0a_2e ; $457d
	push af ; $4580
	ld a, $0f ; $4581
	farcall FarPtr_0a_04 ; $4583
	pop af ; $4586
	xor a, a ; $4587
	ld bc, $3600 ; $4588
	ld de, $0d00 ; $458b
	farcall FarPtr_0a_3a ; $458e
	farcall FarPtr_0a_3e ; $4591
	ld a, $50 ; $4594
	ld [$c2b0], a ; $4596
	ld a, $48 ; $4599
	ld [$c2b1], a ; $459b
	ld a, $01 ; $459e
	ld hl, $4d0a ; $45a0
	call Func_00_1b6a ; $45a3
	ld hl, $0430 ; $45a6
	farcall FarPtr_0a_0e ; $45a9
	ld a, $06 ; $45ac
	farcall FarPtr_0a_08 ; $45ae
	ld hl, $4d0a ; $45b1
	call Func_00_1bcb ; $45b4
	xor a, a ; $45b7
	ld bc, $3200 ; $45b8
	ld de, $1300 ; $45bb
	farcall FarPtr_0a_3a ; $45be
	farcall FarPtr_0a_3e ; $45c1
	push af ; $45c4
	ld a, $1e ; $45c5
	farcall FarPtr_0a_04 ; $45c7
	pop af ; $45ca
	ld a, $00 ; $45cb
	ld b, a ; $45cd
	ld a, $06 ; $45ce
	farcall FarPtr_0a_32 ; $45d0
	ld a, $06 ; $45d3
	farcall FarPtr_0a_08 ; $45d5
	push af ; $45d8
	ld a, $0f ; $45d9
	farcall FarPtr_0a_04 ; $45db
	pop af ; $45de
	ld a, $00 ; $45df
	ld d, $03 ; $45e1
	farcall FarPtr_0a_34 ; $45e3
	ld a, $00 ; $45e6
	farcall FarPtr_0a_36 ; $45e8
	push af ; $45eb
	ld a, $1e ; $45ec
	farcall FarPtr_0a_04 ; $45ee
	pop af ; $45f1
	ld a, $06 ; $45f2
	ld b, $80 ; $45f4
	farcall FarPtr_0a_2e ; $45f6
	push af ; $45f9
	ld a, $0f ; $45fa
	farcall FarPtr_0a_04 ; $45fc
	pop af ; $45ff
	ld a, $00 ; $4600
	ld b, $80 ; $4602
	farcall FarPtr_0a_2e ; $4604
	push af ; $4607
	ld a, $0f ; $4608
	farcall FarPtr_0a_04 ; $460a
	pop af ; $460d
	xor a, a ; $460e
	ld bc, $2a00 ; $460f
	ld de, $0d00 ; $4612
	farcall FarPtr_0a_3a ; $4615
	farcall FarPtr_0a_3e ; $4618
	ld a, $20 ; $461b
	ld [$c2b0], a ; $461d
	ld a, $48 ; $4620
	ld [$c2b1], a ; $4622
	ld a, $01 ; $4625
	ld hl, $4d0a ; $4627
	call Func_00_1b6a ; $462a
	ld a, $06 ; $462d
	farcall FarPtr_0a_08 ; $462f
	ld hl, $4d0a ; $4632
	call Func_00_1bcb ; $4635
	xor a, a ; $4638
	ld bc, $3200 ; $4639
	ld de, $0d00 ; $463c
	farcall FarPtr_0a_3a ; $463f
	farcall FarPtr_0a_3e ; $4642
	ld a, $00 ; $4645
	ld b, a ; $4647
	ld a, $06 ; $4648
	farcall FarPtr_0a_32 ; $464a
	ld a, $06 ; $464d
	farcall FarPtr_0a_08 ; $464f
	ld a, $00 ; $4652
	ld d, $03 ; $4654
	farcall FarPtr_0a_34 ; $4656
	ld a, $00 ; $4659
	farcall FarPtr_0a_36 ; $465b
	ld a, $06 ; $465e
	ld d, $03 ; $4660
	farcall FarPtr_0a_34 ; $4662
	ld a, $06 ; $4665
	farcall FarPtr_0a_36 ; $4667
	push af ; $466a
	ld a, $32 ; $466b
	farcall FarPtr_0a_04 ; $466d
	pop af ; $4670
	ld a, $06 ; $4671
	ld b, $80 ; $4673
	farcall FarPtr_0a_2e ; $4675
	push af ; $4678
	ld a, $28 ; $4679
	farcall FarPtr_0a_04 ; $467b
	pop af ; $467e
	ld a, $06 ; $467f
	ld b, $40 ; $4681
	farcall FarPtr_0a_2e ; $4683
	push af ; $4686
	ld a, $0a ; $4687
	farcall FarPtr_0a_04 ; $4689
	pop af ; $468c
	ld a, $06 ; $468d
	ld b, $00 ; $468f
	farcall FarPtr_0a_2e ; $4691
	push af ; $4694
	ld a, $28 ; $4695
	farcall FarPtr_0a_04 ; $4697
	pop af ; $469a
	ld a, $06 ; $469b
	ld b, $40 ; $469d
	farcall FarPtr_0a_2e ; $469f
	push af ; $46a2
	ld a, $0a ; $46a3
	farcall FarPtr_0a_04 ; $46a5
	pop af ; $46a8
	ld a, $06 ; $46a9
	ld b, $80 ; $46ab
	farcall FarPtr_0a_2e ; $46ad
	push af ; $46b0
	ld a, $28 ; $46b1
	farcall FarPtr_0a_04 ; $46b3
	pop af ; $46b6
	ld a, $06 ; $46b7
	ld b, $40 ; $46b9
	farcall FarPtr_0a_2e ; $46bb
	push af ; $46be
	ld a, $0a ; $46bf
	farcall FarPtr_0a_04 ; $46c1
	pop af ; $46c4
	ld a, $06 ; $46c5
	ld b, $00 ; $46c7
	farcall FarPtr_0a_2e ; $46c9
	push af ; $46cc
	ld a, $32 ; $46cd
	farcall FarPtr_0a_04 ; $46cf
	pop af ; $46d2
	ld a, $06 ; $46d3
	ld d, $03 ; $46d5
	farcall FarPtr_0a_34 ; $46d7
	ld a, $06 ; $46da
	farcall FarPtr_0a_36 ; $46dc
	ld a, $06 ; $46df
	farcall FarPtr_0a_08 ; $46e1
	ld a, $06 ; $46e4
	ld bc, $4100 ; $46e6
	ld de, $0d00 ; $46e9
	farcall FarPtr_0a_24 ; $46ec
	push af ; $46ef
	ld a, $05 ; $46f0
	farcall FarPtr_0a_04 ; $46f2
	pop af ; $46f5
	xor a, a ; $46f6
	ld bc, $3600 ; $46f7
	ld de, $0d00 ; $46fa
	farcall FarPtr_0a_3a ; $46fd
	ld a, $00 ; $4700
	ld bc, $3200 ; $4702
	ld de, $0d20 ; $4705
	farcall FarPtr_0a_24 ; $4708
	ld a, $00 ; $470b
	farcall FarPtr_0a_20 ; $470d
	ld a, $00 ; $4710
	ld bc, $4100 ; $4712
	ld de, $0d20 ; $4715
	farcall FarPtr_0a_24 ; $4718
	ld a, $00 ; $471b
	farcall FarPtr_0a_20 ; $471d
	ld a, $0f ; $4720
	ld [$c294], a ; $4722
	ld [$c2a1], a ; $4725
	farcall FarPtr_0a_02 ; $4728
	ret ; $472b
	INCBIN "data/bank_013/d_472c.bin" ; $472c, 66 bytes
Func_13_476e:
	ldh a, [$ff95] ; $476e
	ld hl, $4c7e ; $4770
	farcall FarPtr_0a_06 ; $4773
	farcall FarPtr_0a_00 ; $4776
	ld a, $00 ; $4779
	ld bc, $3f00 ; $477b
	ld de, $3f00 ; $477e
	farcall FarPtr_0a_22 ; $4781
	ld a, $06 ; $4784
	ld bc, $3f00 ; $4786
	ld de, $3f00 ; $4789
	farcall FarPtr_0a_22 ; $478c
	ld a, $07 ; $478f
	ld bc, $3f00 ; $4791
	ld de, $3f00 ; $4794
	farcall FarPtr_0a_22 ; $4797
	ld a, $08 ; $479a
	ld bc, $3f00 ; $479c
	ld de, $3f00 ; $479f
	farcall FarPtr_0a_22 ; $47a2
	ld c, $04 ; $47a5
	call Func_00_1d2e ; $47a7
	call Func_00_1da4 ; $47aa
	ld a, $06 ; $47ad
	ld bc, $4100 ; $47af
	ld de, $0d00 ; $47b2
	farcall FarPtr_0a_22 ; $47b5
	ld a, $06 ; $47b8
	ld bc, $1b00 ; $47ba
	ld de, $0d00 ; $47bd
	farcall FarPtr_0a_24 ; $47c0
	ld a, $00 ; $47c3
	ld bc, $4300 ; $47c5
	ld de, $0d00 ; $47c8
	farcall FarPtr_0a_22 ; $47cb
	ld a, $00 ; $47ce
	ld bc, $1d00 ; $47d0
	ld de, $0d00 ; $47d3
	farcall FarPtr_0a_24 ; $47d6
	push af ; $47d9
	ld a, $0f ; $47da
	farcall FarPtr_0a_04 ; $47dc
	pop af ; $47df
	xor a, a ; $47e0
	ld bc, $1b00 ; $47e1
	ld de, $0d00 ; $47e4
	farcall FarPtr_0a_3a ; $47e7
	ld a, $00 ; $47ea
	farcall FarPtr_0a_20 ; $47ec
	push af ; $47ef
	ld a, $1e ; $47f0
	farcall FarPtr_0a_04 ; $47f2
	pop af ; $47f5
	ld a, $00 ; $47f6
	ld b, a ; $47f8
	ld a, $06 ; $47f9
	farcall FarPtr_0a_30 ; $47fb
	ld hl, $0435 ; $47fe
	farcall FarPtr_0a_0e ; $4801
	ld a, $06 ; $4804
	farcall FarPtr_0a_08 ; $4806
	ld a, $00 ; $4809
	ld d, $03 ; $480b
	farcall FarPtr_0a_34 ; $480d
	ld a, $00 ; $4810
	farcall FarPtr_0a_36 ; $4812
	ld a, $06 ; $4815
	ld b, $c0 ; $4817
	farcall FarPtr_0a_2e ; $4819
	push af ; $481c
	ld a, $0f ; $481d
	farcall FarPtr_0a_04 ; $481f
	pop af ; $4822
	ld a, $00 ; $4823
	ld b, $c0 ; $4825
	farcall FarPtr_0a_2e ; $4827
	ld a, $06 ; $482a
	farcall FarPtr_0a_08 ; $482c
	ld a, $00 ; $482f
	ld d, $03 ; $4831
	farcall FarPtr_0a_34 ; $4833
	ld a, $00 ; $4836
	farcall FarPtr_0a_36 ; $4838
	push af ; $483b
	ld a, $1e ; $483c
	farcall FarPtr_0a_04 ; $483e
	pop af ; $4841
	call Func_13_4d78 ; $4842
	ld a, $07 ; $4845
	farcall FarPtr_0a_08 ; $4847
	push af ; $484a
	ld a, $0f ; $484b
	farcall FarPtr_0a_04 ; $484d
	pop af ; $4850
	ld a, $03 ; $4851
	ld bc, $1c00 ; $4853
	ld de, $0b00 ; $4856
	farcall FarPtr_0a_22 ; $4859
	rst Rst08 ; $485c
	sub a, a ; $485d
	push af ; $485e
	ld a, $1e ; $485f
	farcall FarPtr_0a_04 ; $4861
	pop af ; $4864
	ld a, $03 ; $4865
	ld bc, $3f00 ; $4867
	ld de, $3f00 ; $486a
	farcall FarPtr_0a_22 ; $486d
	ld a, $06 ; $4870
	ld b, $80 ; $4872
	farcall FarPtr_0a_2e ; $4874
	push af ; $4877
	ld a, $0f ; $4878
	farcall FarPtr_0a_04 ; $487a
	pop af ; $487d
	ld a, $00 ; $487e
	ld b, $80 ; $4880
	farcall FarPtr_0a_2e ; $4882
	xor a, a ; $4885
	ld bc, $1800 ; $4886
	ld de, $0d00 ; $4889
	farcall FarPtr_0a_3a ; $488c
	push af ; $488f
	ld a, $0f ; $4890
	farcall FarPtr_0a_04 ; $4892
	pop af ; $4895
	ld a, $07 ; $4896
	ld bc, $1500 ; $4898
	ld de, $0980 ; $489b
	farcall FarPtr_0a_22 ; $489e
	push af ; $48a1
	ld a, $0f ; $48a2
	farcall FarPtr_0a_04 ; $48a4
	pop af ; $48a7
	ld a, $07 ; $48a8
	ld bc, $0010 ; $48aa
	farcall FarPtr_0a_18 ; $48ad
	ld a, $07 ; $48b0
	ld bc, $1500 ; $48b2
	ld de, $0d00 ; $48b5
	farcall FarPtr_0a_24 ; $48b8
	ld a, $07 ; $48bb
	farcall FarPtr_0a_20 ; $48bd
	ld a, $07 ; $48c0
	ld b, $00 ; $48c2
	farcall FarPtr_0a_2e ; $48c4
	ld a, $08 ; $48c7
	ld bc, $1500 ; $48c9
	ld de, $0900 ; $48cc
	farcall FarPtr_0a_22 ; $48cf
	push af ; $48d2
	ld a, $0f ; $48d3
	farcall FarPtr_0a_04 ; $48d5
	pop af ; $48d8
	ld a, $08 ; $48d9
	ld bc, $0010 ; $48db
	farcall FarPtr_0a_18 ; $48de
	ld a, $08 ; $48e1
	ld bc, $1500 ; $48e3
	ld de, $0b00 ; $48e6
	farcall FarPtr_0a_24 ; $48e9
	ld a, $08 ; $48ec
	farcall FarPtr_0a_20 ; $48ee
	call Func_13_4dcc ; $48f1
	ld a, $08 ; $48f4
	ld b, $00 ; $48f6
	farcall FarPtr_0a_2e ; $48f8
	push af ; $48fb
	ld a, $0f ; $48fc
	farcall FarPtr_0a_04 ; $48fe
	pop af ; $4901
	ld a, $06 ; $4902
	ld d, $02 ; $4904
	farcall FarPtr_0a_34 ; $4906
	ld a, $06 ; $4909
	farcall FarPtr_0a_36 ; $490b
	ld a, $06 ; $490e
	farcall FarPtr_0a_08 ; $4910
	ld a, $07 ; $4913
	ld b, $40 ; $4915
	farcall FarPtr_0a_2e ; $4917
	ld a, $07 ; $491a
	ld d, $04 ; $491c
	farcall FarPtr_0a_34 ; $491e
	ld a, $07 ; $4921
	farcall FarPtr_0a_36 ; $4923
	push af ; $4926
	ld a, $1e ; $4927
	farcall FarPtr_0a_04 ; $4929
	pop af ; $492c
	ld a, $06 ; $492d
	ld b, a ; $492f
	ld a, $07 ; $4930
	farcall FarPtr_0a_30 ; $4932
	ld a, $07 ; $4935
	farcall FarPtr_0a_08 ; $4937
	ld a, $06 ; $493a
	ld d, $02 ; $493c
	farcall FarPtr_0a_34 ; $493e
	ld a, $06 ; $4941
	farcall FarPtr_0a_36 ; $4943
	ld a, $06 ; $4946
	farcall FarPtr_0a_08 ; $4948
	ld a, $08 ; $494b
	ld d, $03 ; $494d
	farcall FarPtr_0a_34 ; $494f
	ld a, $08 ; $4952
	farcall FarPtr_0a_36 ; $4954
	ld a, $08 ; $4957
	farcall FarPtr_0a_08 ; $4959
	push af ; $495c
	ld a, $0f ; $495d
	farcall FarPtr_0a_04 ; $495f
	pop af ; $4962
	ld a, $08 ; $4963
	ld d, $02 ; $4965
	farcall FarPtr_0a_34 ; $4967
	ld a, $08 ; $496a
	farcall FarPtr_0a_36 ; $496c
	ld a, $04 ; $496f
	ld bc, $1640 ; $4971
	ld de, $0940 ; $4974
	farcall FarPtr_0a_22 ; $4977
	rst Rst08 ; $497a
	sbc a, b ; $497b
	push af ; $497c
	ld a, $1e ; $497d
	farcall FarPtr_0a_04 ; $497f
	pop af ; $4982
	ld a, $04 ; $4983
	ld bc, $3f00 ; $4985
	ld de, $3f00 ; $4988
	farcall FarPtr_0a_22 ; $498b
	push af ; $498e
	ld a, $1e ; $498f
	farcall FarPtr_0a_04 ; $4991
	pop af ; $4994
	ld a, $06 ; $4995
	ld d, $02 ; $4997
	farcall FarPtr_0a_34 ; $4999
	ld a, $06 ; $499c
	farcall FarPtr_0a_36 ; $499e
	ld a, $00 ; $49a1
	ld b, a ; $49a3
	ld a, $06 ; $49a4
	farcall FarPtr_0a_30 ; $49a6
	push af ; $49a9
	ld a, $32 ; $49aa
	farcall FarPtr_0a_04 ; $49ac
	pop af ; $49af
	ld a, $07 ; $49b0
	ld b, a ; $49b2
	ld a, $06 ; $49b3
	farcall FarPtr_0a_30 ; $49b5
	ld a, [$c90d] ; $49b8
	or a, a ; $49bb
	jr z, Label_13_49c1 ; $49bc
	farcall FarPtr_0a_10 ; $49be
Label_13_49c1:
	ld a, $06 ; $49c1
	farcall FarPtr_0a_08 ; $49c3
	ld hl, $043e ; $49c6
	farcall FarPtr_0a_0e ; $49c9
	push af ; $49cc
	ld a, $0f ; $49cd
	farcall FarPtr_0a_04 ; $49cf
	pop af ; $49d2
	ld a, $00 ; $49d3
	ld bc, $0018 ; $49d5
	farcall FarPtr_0a_18 ; $49d8
	ld a, $00 ; $49db
	ld bc, $1d00 ; $49dd
	ld de, $0c00 ; $49e0
	farcall FarPtr_0a_24 ; $49e3
	ld a, $00 ; $49e6
	farcall FarPtr_0a_20 ; $49e8
	ld a, $00 ; $49eb
	ld bc, $1b00 ; $49ed
	ld de, $0b00 ; $49f0
	farcall FarPtr_0a_24 ; $49f3
	ld a, $00 ; $49f6
	farcall FarPtr_0a_20 ; $49f8
	ld a, $00 ; $49fb
	ld b, $80 ; $49fd
	farcall FarPtr_0a_2e ; $49ff
	ld a, $00 ; $4a02
	ld bc, $0020 ; $4a04
	farcall FarPtr_0a_18 ; $4a07
	push af ; $4a0a
	ld a, $0f ; $4a0b
	farcall FarPtr_0a_04 ; $4a0d
	pop af ; $4a10
	ld a, $00 ; $4a11
	ld d, $03 ; $4a13
	farcall FarPtr_0a_34 ; $4a15
	ld a, $00 ; $4a18
	farcall FarPtr_0a_36 ; $4a1a
	push af ; $4a1d
	ld a, $0f ; $4a1e
	farcall FarPtr_0a_04 ; $4a20
	pop af ; $4a23
	ld a, $08 ; $4a24
	ld b, a ; $4a26
	ld a, $07 ; $4a27
	farcall FarPtr_0a_32 ; $4a29
	push af ; $4a2c
	ld a, $46 ; $4a2d
	farcall FarPtr_0a_04 ; $4a2f
	pop af ; $4a32
	ld a, $00 ; $4a33
	ld b, a ; $4a35
	ld a, $07 ; $4a36
	farcall FarPtr_0a_30 ; $4a38
	ld a, $00 ; $4a3b
	ld b, a ; $4a3d
	ld a, $08 ; $4a3e
	farcall FarPtr_0a_30 ; $4a40
	push af ; $4a43
	ld a, $0f ; $4a44
	farcall FarPtr_0a_04 ; $4a46
	pop af ; $4a49
	ld a, $07 ; $4a4a
	farcall FarPtr_0a_08 ; $4a4c
	ld a, $07 ; $4a4f
	ld d, $03 ; $4a51
	farcall FarPtr_0a_34 ; $4a53
	ld a, $07 ; $4a56
	farcall FarPtr_0a_36 ; $4a58
	ld a, $07 ; $4a5b
	farcall FarPtr_0a_08 ; $4a5d
	ld a, $00 ; $4a60
	ld d, $03 ; $4a62
	farcall FarPtr_0a_34 ; $4a64
	ld a, $00 ; $4a67
	farcall FarPtr_0a_36 ; $4a69
	push af ; $4a6c
	ld a, $1e ; $4a6d
	farcall FarPtr_0a_04 ; $4a6f
	pop af ; $4a72
	ld a, $08 ; $4a73
	ld d, $02 ; $4a75
	farcall FarPtr_0a_34 ; $4a77
	ld a, $08 ; $4a7a
	farcall FarPtr_0a_36 ; $4a7c
	ld a, $08 ; $4a7f
	farcall FarPtr_0a_08 ; $4a81
	ld a, $08 ; $4a84
	ld d, $03 ; $4a86
	farcall FarPtr_0a_34 ; $4a88
	ld a, $08 ; $4a8b
	farcall FarPtr_0a_36 ; $4a8d
	ld a, $08 ; $4a90
	farcall FarPtr_0a_08 ; $4a92
	push af ; $4a95
	ld a, $5a ; $4a96
	farcall FarPtr_0a_04 ; $4a98
	pop af ; $4a9b
	ld a, $08 ; $4a9c
	ld bc, $1500 ; $4a9e
	ld de, $0980 ; $4aa1
	farcall FarPtr_0a_24 ; $4aa4
	call Func_13_4d78 ; $4aa7
	ld a, $08 ; $4aaa
	ld bc, $14c0 ; $4aac
	ld de, $0900 ; $4aaf
	farcall FarPtr_0a_24 ; $4ab2
	ld a, $07 ; $4ab5
	ld bc, $1500 ; $4ab7
	ld de, $0b00 ; $4aba
	farcall FarPtr_0a_24 ; $4abd
	ld a, $08 ; $4ac0
	ld bc, $3f00 ; $4ac2
	ld de, $3f00 ; $4ac5
	farcall FarPtr_0a_22 ; $4ac8
	ld a, $07 ; $4acb
	farcall FarPtr_0a_20 ; $4acd
	push af ; $4ad0
	ld a, $0f ; $4ad1
	farcall FarPtr_0a_04 ; $4ad3
	pop af ; $4ad6
	ld a, $06 ; $4ad7
	ld b, a ; $4ad9
	ld a, $07 ; $4ada
	farcall FarPtr_0a_30 ; $4adc
	ld a, $07 ; $4adf
	farcall FarPtr_0a_08 ; $4ae1
	ld a, $07 ; $4ae4
	ld bc, $1500 ; $4ae6
	ld de, $0980 ; $4ae9
	farcall FarPtr_0a_24 ; $4aec
	ld a, $07 ; $4aef
	farcall FarPtr_0a_20 ; $4af1
	ld a, $07 ; $4af4
	ld bc, $14c0 ; $4af6
	ld de, $0900 ; $4af9
	farcall FarPtr_0a_24 ; $4afc
	push af ; $4aff
	ld a, $0f ; $4b00
	farcall FarPtr_0a_04 ; $4b02
	pop af ; $4b05
	ld a, $07 ; $4b06
	ld bc, $3f00 ; $4b08
	ld de, $3f00 ; $4b0b
	farcall FarPtr_0a_22 ; $4b0e
	call Func_13_4dcc ; $4b11
	xor a, a ; $4b14
	ld bc, $1b00 ; $4b15
	ld de, $0d00 ; $4b18
	farcall FarPtr_0a_3a ; $4b1b
	push af ; $4b1e
	ld a, $3c ; $4b1f
	farcall FarPtr_0a_04 ; $4b21
	pop af ; $4b24
	ld a, $06 ; $4b25
	ld b, a ; $4b27
	ld a, $00 ; $4b28
	farcall FarPtr_0a_30 ; $4b2a
	push af ; $4b2d
	ld a, $0f ; $4b2e
	farcall FarPtr_0a_04 ; $4b30
	pop af ; $4b33
	ld a, $05 ; $4b34
	ld bc, $1c00 ; $4b36
	ld de, $0900 ; $4b39
	farcall FarPtr_0a_22 ; $4b3c
	push af ; $4b3f
	ld a, $5a ; $4b40
	farcall FarPtr_0a_04 ; $4b42
	pop af ; $4b45
	ld a, $05 ; $4b46
	ld bc, $3f00 ; $4b48
	ld de, $3f00 ; $4b4b
	farcall FarPtr_0a_22 ; $4b4e
	push af ; $4b51
	ld a, $0f ; $4b52
	farcall FarPtr_0a_04 ; $4b54
	pop af ; $4b57
	ld a, $06 ; $4b58
	farcall FarPtr_0a_08 ; $4b5a
	ld a, $00 ; $4b5d
	ld b, a ; $4b5f
	ld a, $06 ; $4b60
	farcall FarPtr_0a_30 ; $4b62
	push af ; $4b65
	ld a, $1e ; $4b66
	farcall FarPtr_0a_04 ; $4b68
	pop af ; $4b6b
	ld a, $06 ; $4b6c
	farcall FarPtr_0a_08 ; $4b6e
	ld a, $00 ; $4b71
	ld d, $02 ; $4b73
	farcall FarPtr_0a_34 ; $4b75
	ld a, $00 ; $4b78
	farcall FarPtr_0a_36 ; $4b7a
	push af ; $4b7d
	ld a, $3c ; $4b7e
	farcall FarPtr_0a_04 ; $4b80
	pop af ; $4b83
	ld a, $06 ; $4b84
	ld bc, $1500 ; $4b86
	ld de, $0d00 ; $4b89
	farcall FarPtr_0a_24 ; $4b8c
	ld a, $06 ; $4b8f
	farcall FarPtr_0a_20 ; $4b91
	ld a, $00 ; $4b94
	ld b, a ; $4b96
	ld a, $06 ; $4b97
	farcall FarPtr_0a_30 ; $4b99
	push af ; $4b9c
	ld a, $1e ; $4b9d
	farcall FarPtr_0a_04 ; $4b9f
	pop af ; $4ba2
	ld a, $06 ; $4ba3
	farcall FarPtr_0a_08 ; $4ba5
	push af ; $4ba8
	ld a, $0f ; $4ba9
	farcall FarPtr_0a_04 ; $4bab
	pop af ; $4bae
	ld a, $00 ; $4baf
	ld bc, $1700 ; $4bb1
	ld de, $0d00 ; $4bb4
	farcall FarPtr_0a_24 ; $4bb7
	ld a, $00 ; $4bba
	farcall FarPtr_0a_20 ; $4bbc
	push af ; $4bbf
	ld a, $0a ; $4bc0
	farcall FarPtr_0a_04 ; $4bc2
	pop af ; $4bc5
	ld a, $06 ; $4bc6
	ld bc, $0700 ; $4bc8
	ld de, $0d00 ; $4bcb
	farcall FarPtr_0a_24 ; $4bce
	push af ; $4bd1
	ld a, $0a ; $4bd2
	farcall FarPtr_0a_04 ; $4bd4
	pop af ; $4bd7
	xor a, a ; $4bd8
	ld bc, $0900 ; $4bd9
	ld de, $0d00 ; $4bdc
	farcall FarPtr_0a_3a ; $4bdf
	ld a, $00 ; $4be2
	ld bc, $0700 ; $4be4
	ld de, $0d00 ; $4be7
	farcall FarPtr_0a_24 ; $4bea
	ld a, $06 ; $4bed
	farcall FarPtr_0a_20 ; $4bef
	ld a, $06 ; $4bf2
	ld b, $c0 ; $4bf4
	farcall FarPtr_0a_2e ; $4bf6
	ld a, $06 ; $4bf9
	ld b, $c0 ; $4bfb
	ld de, $0500 ; $4bfd
	farcall FarPtr_0a_2a ; $4c00
	ld a, $06 ; $4c03
	ld bc, $000b ; $4c05
	farcall FarPtr_0a_18 ; $4c08
	push af ; $4c0b
	ld a, $0a ; $4c0c
	farcall FarPtr_0a_04 ; $4c0e
	pop af ; $4c11
	ld a, $00 ; $4c12
	farcall FarPtr_0a_20 ; $4c14
	ld a, $00 ; $4c17
	ld b, $c0 ; $4c19
	farcall FarPtr_0a_2e ; $4c1b
	ld a, $00 ; $4c1e
	ld b, $c0 ; $4c20
	ld de, $0500 ; $4c22
	farcall FarPtr_0a_2a ; $4c25
	ld a, $00 ; $4c28
	ld bc, $000b ; $4c2a
	farcall FarPtr_0a_18 ; $4c2d
	ld a, $06 ; $4c30
	farcall FarPtr_0a_20 ; $4c32
	ld a, $06 ; $4c35
	ld d, $08 ; $4c37
	farcall FarPtr_0a_34 ; $4c39
	ld a, $06 ; $4c3c
	ld b, $c0 ; $4c3e
	ld de, $0100 ; $4c40
	farcall FarPtr_0a_2a ; $4c43
	ld a, $00 ; $4c46
	farcall FarPtr_0a_20 ; $4c48
	ld a, $00 ; $4c4b
	ld d, $08 ; $4c4d
	farcall FarPtr_0a_34 ; $4c4f
	ld a, $00 ; $4c52
	ld b, $c0 ; $4c54
	ld de, $0100 ; $4c56
	farcall FarPtr_0a_2a ; $4c59
	ld a, $06 ; $4c5c
	ld bc, $3f00 ; $4c5e
	ld de, $3f00 ; $4c61
	farcall FarPtr_0a_22 ; $4c64
	ld a, $00 ; $4c67
	ld bc, $3f00 ; $4c69
	ld de, $3f00 ; $4c6c
	farcall FarPtr_0a_22 ; $4c6f
	ld a, $0e ; $4c72
	ld [$c294], a ; $4c74
	ld [$c2a1], a ; $4c77
	farcall FarPtr_0a_02 ; $4c7a
	ret ; $4c7d
	INCBIN "data/bank_013/d_4c7e.bin" ; $4c7e, 94 bytes
Func_13_4cdc:
	ldh a, [$ff96] ; $4cdc
	push af ; $4cde
	ld a, $01 ; $4cdf
	ldh [$ff96], a ; $4ce1
	ldh [rWBK], a ; $4ce3
	ld hl, $4d30 ; $4ce5
	ld de, $a000 ; $4ce8
	ld c, $04 ; $4ceb
	call Func_00_0480 ; $4ced
	ld hl, $4d70 ; $4cf0
	ld de, $0801 ; $4cf3
	call Func_00_05b0 ; $4cf6
	pop af ; $4cf9
	ldh [$ff96], a ; $4cfa
	ldh [rWBK], a ; $4cfc
	ret ; $4cfe
Func_13_4cff:
	ld hl, $4d20 ; $4cff
	ld c, $00 ; $4d02
	ld b, $08 ; $4d04
	call Func_00_1e9d ; $4d06
	ret ; $4d09
	ld a, [$c2b0] ; $4d0a
	ld d, a ; $4d0d
	ldh a, [$ff8c] ; $4d0e
	srl a ; $4d10
	and a, $07 ; $4d12
	ld e, a ; $4d14
	ld a, [$c2b1] ; $4d15
	add a, $08 ; $4d18
	sub a, e ; $4d1a
	ld e, a ; $4d1b
	call Func_13_4cff ; $4d1c
	ret ; $4d1f
	INCBIN "data/bank_013/d_4d20.bin" ; $4d20, 88 bytes
Func_13_4d78:
	rst Rst08 ; $4d78
	ld [hl], c ; $4d79
	ld b, $14 ; $4d7a
	ld c, $08 ; $4d7c
	ld d, $06 ; $4d7e
	ld e, $15 ; $4d80
	ld h, $02 ; $4d82
	ld l, $02 ; $4d84
	farcall FarPtr_0a_7e ; $4d86
	ld b, $00 ; $4d89
	ld c, $15 ; $4d8b
	ld d, $14 ; $4d8d
	ld e, $08 ; $4d8f
	ld h, $02 ; $4d91
	ld l, $02 ; $4d93
	farcall FarPtr_0a_7e ; $4d95
	push af ; $4d98
	ld a, $02 ; $4d99
	farcall FarPtr_0a_04 ; $4d9b
	pop af ; $4d9e
	ld b, $02 ; $4d9f
	ld c, $15 ; $4da1
	ld d, $14 ; $4da3
	ld e, $08 ; $4da5
	ld h, $02 ; $4da7
	ld l, $02 ; $4da9
	farcall FarPtr_0a_7e ; $4dab
	push af ; $4dae
	ld a, $02 ; $4daf
	farcall FarPtr_0a_04 ; $4db1
	pop af ; $4db4
	ld b, $04 ; $4db5
	ld c, $15 ; $4db7
	ld d, $14 ; $4db9
	ld e, $08 ; $4dbb
	ld h, $02 ; $4dbd
	ld l, $02 ; $4dbf
	farcall FarPtr_0a_7e ; $4dc1
	push af ; $4dc4
	ld a, $02 ; $4dc5
	farcall FarPtr_0a_04 ; $4dc7
	pop af ; $4dca
	ret ; $4dcb
Func_13_4dcc:
	rst Rst08 ; $4dcc
	ld [hl], c ; $4dcd
	ld b, $04 ; $4dce
	ld c, $15 ; $4dd0
	ld d, $14 ; $4dd2
	ld e, $08 ; $4dd4
	ld h, $02 ; $4dd6
	ld l, $02 ; $4dd8
	farcall FarPtr_0a_7e ; $4dda
	push af ; $4ddd
	ld a, $01 ; $4dde
	farcall FarPtr_0a_04 ; $4de0
	pop af ; $4de3
	ld b, $02 ; $4de4
	ld c, $15 ; $4de6
	ld d, $14 ; $4de8
	ld e, $08 ; $4dea
	ld h, $02 ; $4dec
	ld l, $02 ; $4dee
	farcall FarPtr_0a_7e ; $4df0
	push af ; $4df3
	ld a, $01 ; $4df4
	farcall FarPtr_0a_04 ; $4df6
	pop af ; $4df9
	ld b, $00 ; $4dfa
	ld c, $15 ; $4dfc
	ld d, $14 ; $4dfe
	ld e, $08 ; $4e00
	ld h, $02 ; $4e02
	ld l, $02 ; $4e04
	farcall FarPtr_0a_7e ; $4e06
	push af ; $4e09
	ld a, $01 ; $4e0a
	farcall FarPtr_0a_04 ; $4e0c
	pop af ; $4e0f
	ld b, $06 ; $4e10
	ld c, $15 ; $4e12
	ld d, $14 ; $4e14
	ld e, $08 ; $4e16
	ld h, $02 ; $4e18
	ld l, $02 ; $4e1a
	farcall FarPtr_0a_7e ; $4e1c
	ret ; $4e1f
	INCBIN "data/bank_013/d_4e20.bin" ; $4e20, 522 bytes
	xor a, a ; $502a
	ld [$c2d5], a ; $502b
	ld a, [$c295] ; $502e
	cp a, $0a ; $5031
	jp z, Label_13_5a76 ; $5033
	cp a, $09 ; $5036
	jp z, Label_13_5a92 ; $5038
	cp a, $08 ; $503b
	jp z, Label_13_5aae ; $503d
	call Func_13_7d58 ; $5040
	call Func_13_5130 ; $5043
	call Func_13_51b0 ; $5046
	call Func_13_5067 ; $5049
	ld a, [$c295] ; $504c
	cp a, $0f ; $504f
	jp z, Label_13_53a1 ; $5051
	rst Rst08 ; $5054
	inc e ; $5055
	ld a, [$c295] ; $5056
	cp a, $01 ; $5059
	jp z, Label_13_52e7 ; $505b
	cp a, $02 ; $505e
	jp z, Label_13_5593 ; $5060
	farcall FarPtr_0a_02 ; $5063
	ret ; $5066
Func_13_5067:
	rst Rst30 ; $5067
	ldh [rTIMA], a ; $5068
	jr nz, Label_13_507c ; $506a
	rst Rst30 ; $506c
	nop ; $506d
	dec bc ; $506e
	jr nz, Label_13_5074 ; $506f
	jr Label_13_50de ; $5071
	INCBIN "data/bank_013/d_5073.bin" ; $5073, 1 bytes
Label_13_5074:
	rst Rst30 ; $5074
	ret nz ; $5075
	dec d ; $5076
	jr z, Label_13_508c ; $5077
	jr Label_13_50de ; $5079
	INCBIN "data/bank_013/d_507b.bin" ; $507b, 1 bytes
Label_13_507c:
	rst Rst30 ; $507c
	nop ; $507d
	add hl, bc ; $507e
	jr nz, Label_13_5084 ; $507f
	jr Label_13_50de ; $5081
	INCBIN "data/bank_013/d_5083.bin" ; $5083, 1 bytes
Label_13_5084:
	rst Rst30 ; $5084
	ldh [$ff15], a ; $5085
	jr z, Label_13_508c ; $5087
	jr Label_13_50de ; $5089
	INCBIN "data/bank_013/d_508b.bin" ; $508b, 1 bytes
Label_13_508c:
	ld a, $f1 ; $508c
	ld d, $08 ; $508e
	ld e, $0e ; $5090
	farcall FarPtr_0a_8a ; $5092
	ld a, $f1 ; $5095
	ld d, $0a ; $5097
	ld e, $0e ; $5099
	farcall FarPtr_0a_8a ; $509b
	ld a, $f1 ; $509e
	ld d, $0c ; $50a0
	ld e, $0e ; $50a2
	farcall FarPtr_0a_8a ; $50a4
	ld a, $f1 ; $50a7
	ld d, $08 ; $50a9
	ld e, $10 ; $50ab
	farcall FarPtr_0a_8a ; $50ad
	ld a, $f1 ; $50b0
	ld d, $0a ; $50b2
	ld e, $10 ; $50b4
	farcall FarPtr_0a_8a ; $50b6
	ld a, $f1 ; $50b9
	ld d, $0c ; $50bb
	ld e, $10 ; $50bd
	farcall FarPtr_0a_8a ; $50bf
	ld a, $f1 ; $50c2
	ld d, $08 ; $50c4
	ld e, $12 ; $50c6
	farcall FarPtr_0a_8a ; $50c8
	ld a, $f1 ; $50cb
	ld d, $0a ; $50cd
	ld e, $12 ; $50cf
	farcall FarPtr_0a_8a ; $50d1
	ld a, $f1 ; $50d4
	ld d, $0c ; $50d6
	ld e, $12 ; $50d8
	farcall FarPtr_0a_8a ; $50da
	ret ; $50dd
Label_13_50de:
	ld a, $00 ; $50de
	ld d, $08 ; $50e0
	ld e, $0e ; $50e2
	farcall FarPtr_0a_8a ; $50e4
	ld a, $00 ; $50e7
	ld d, $0a ; $50e9
	ld e, $0e ; $50eb
	farcall FarPtr_0a_8a ; $50ed
	ld a, $00 ; $50f0
	ld d, $0c ; $50f2
	ld e, $0e ; $50f4
	farcall FarPtr_0a_8a ; $50f6
	ld a, $00 ; $50f9
	ld d, $08 ; $50fb
	ld e, $10 ; $50fd
	farcall FarPtr_0a_8a ; $50ff
	ld a, $00 ; $5102
	ld d, $0a ; $5104
	ld e, $10 ; $5106
	farcall FarPtr_0a_8a ; $5108
	ld a, $00 ; $510b
	ld d, $0c ; $510d
	ld e, $10 ; $510f
	farcall FarPtr_0a_8a ; $5111
	ld a, $00 ; $5114
	ld d, $08 ; $5116
	ld e, $12 ; $5118
	farcall FarPtr_0a_8a ; $511a
	ld a, $00 ; $511d
	ld d, $0a ; $511f
	ld e, $12 ; $5121
	farcall FarPtr_0a_8a ; $5123
	ld a, $00 ; $5126
	ld d, $0c ; $5128
	ld e, $12 ; $512a
	farcall FarPtr_0a_8a ; $512c
	ret ; $512f
Func_13_5130:
	ld a, [$c94d] ; $5130
	or a, a ; $5133
	jr nz, Label_13_51ac ; $5134
	farcall FarPtr_0a_3e ; $5136
	ld b, $20 ; $5139
	ld c, $00 ; $513b
	ld d, $00 ; $513d
	ld e, $00 ; $513f
	ld h, $16 ; $5141
	ld l, $16 ; $5143
	farcall FarPtr_0a_80 ; $5145
	ld b, $20 ; $5148
	ld c, $00 ; $514a
	ld d, $00 ; $514c
	ld e, $00 ; $514e
	ld h, $16 ; $5150
	ld l, $16 ; $5152
	farcall FarPtr_0a_82 ; $5154
	ld b, $20 ; $5157
	ld c, $00 ; $5159
	ld d, $00 ; $515b
	ld e, $00 ; $515d
	ld h, $16 ; $515f
	ld l, $18 ; $5161
	farcall FarPtr_0a_7e ; $5163
	ld d, $28 ; $5166
	ld a, $03 ; $5168
	farcall FarPtr_0a_16 ; $516a
	ld c, l ; $516d
	ld b, h ; $516e
	farcall FarPtr_04_2c ; $516f
	ld a, $03 ; $5172
	ld d, $01 ; $5174
	farcall FarPtr_0a_34 ; $5176
	ld a, $04 ; $5179
	ld bc, $1f00 ; $517b
	ld de, $1500 ; $517e
	farcall FarPtr_0a_22 ; $5181
	ld a, $04 ; $5184
	farcall FarPtr_0a_1c ; $5186
	rst Rst20 ; $5189
	nop ; $518a
	inc e ; $518b
	ld a, $02 ; $518c
	ld [$c329], a ; $518e
	ld a, $02 ; $5191
	ld [$c32a], a ; $5193
	ld a, $16 ; $5196
	ld [$c32b], a ; $5198
	ld a, $14 ; $519b
	ld [$c32c], a ; $519d
	call DisableLCDSafely ; $51a0
	ld a, $00 ; $51a3
	farcall FarPtr_0a_76 ; $51a5
	call EnableLCD ; $51a8
	ret ; $51ab
Label_13_51ac:
	call Func_13_524e ; $51ac
	ret ; $51af
Func_13_51b0:
	ld a, [$c295] ; $51b0
	cp a, $ff ; $51b3
	jr z, Label_13_521b ; $51b5
	cp a, $01 ; $51b7
	jr z, Label_13_51d3 ; $51b9
	ld a, $04 ; $51bb
	ldh [$ff96], a ; $51bd
	ldh [rWBK], a ; $51bf
	rst Rst30 ; $51c1
	ldh [rTIMA], a ; $51c2
	jp nz, Label_13_527a ; $51c4
	ld a, $03 ; $51c7
	ld bc, $0b00 ; $51c9
	ld de, $0a00 ; $51cc
	farcall FarPtr_0a_22 ; $51cf
	ret ; $51d2
Label_13_51d3:
	rst Rst30 ; $51d3
	ldh [rTIMA], a ; $51d4
	jr z, Label_13_5208 ; $51d6
	ld a, $03 ; $51d8
	ld bc, $0b00 ; $51da
	ld de, $0a00 ; $51dd
	farcall FarPtr_0a_22 ; $51e0
	ld a, $03 ; $51e3
	ld b, $40 ; $51e5
	farcall FarPtr_0a_2e ; $51e7
	ld a, $02 ; $51ea
	farcall FarPtr_0a_1c ; $51ec
	ld a, $02 ; $51ef
	ld bc, $0100 ; $51f1
	ld de, $0100 ; $51f4
	farcall FarPtr_0a_22 ; $51f7
	ld a, $03 ; $51fa
	farcall FarPtr_0a_16 ; $51fc
	ld c, l ; $51ff
	ld b, h ; $5200
	ld hl, $0005 ; $5201
	add hl, bc ; $5204
	set 4, [hl] ; $5205
	ret ; $5207
Label_13_5208:
	ld a, $03 ; $5208
	ld bc, $0b00 ; $520a
	ld de, $0a00 ; $520d
	farcall FarPtr_0a_22 ; $5210
	ld a, $03 ; $5213
	ld b, $40 ; $5215
	farcall FarPtr_0a_2e ; $5217
	ret ; $521a
Label_13_521b:
	rst Rst30 ; $521b
	ldh [rTIMA], a ; $521c
	jr z, Label_13_5208 ; $521e
	ld a, $02 ; $5220
	farcall FarPtr_0a_1c ; $5222
	ld a, $02 ; $5225
	ld bc, $0100 ; $5227
	ld de, $0100 ; $522a
	farcall FarPtr_0a_22 ; $522d
	call Func_13_5c39 ; $5230
	ld a, $03 ; $5233
	farcall FarPtr_0a_16 ; $5235
	ld c, l ; $5238
	ld b, h ; $5239
	ld de, $d000 ; $523a
	farcall FarPtr_04_20 ; $523d
	ld a, $03 ; $5240
	farcall FarPtr_0a_16 ; $5242
	ld c, l ; $5245
	ld b, h ; $5246
	ld hl, $0005 ; $5247
	add hl, bc ; $524a
	set 4, [hl] ; $524b
	ret ; $524d
Func_13_524e:
	call Func_00_0a3a ; $524e
	ld a, l ; $5251
	and a, $07 ; $5252
	add a, a ; $5254
	add a, $6a ; $5255
	ld l, a ; $5257
	adc a, $52 ; $5258
	sub a, l ; $525a
	ld h, a ; $525b
	ld a, [hl+] ; $525c
	ld h, [hl] ; $525d
	ld l, a ; $525e
	ld e, l ; $525f
	ld d, h ; $5260
	ldh a, [$ff95] ; $5261
	ld b, a ; $5263
	ld a, $04 ; $5264
	farcall FarPtr_0a_1a ; $5266
	ret ; $5269
	INCBIN "data/bank_013/d_526a.bin" ; $526a, 16 bytes
Label_13_527a:
	ld a, $02 ; $527a
	farcall FarPtr_0a_1c ; $527c
	ld a, $02 ; $527f
	ld bc, $1500 ; $5281
	ld de, $1f00 ; $5284
	farcall FarPtr_0a_22 ; $5287
	ld a, $03 ; $528a
	ld bc, $0b00 ; $528c
	ld de, $1000 ; $528f
	farcall FarPtr_0a_22 ; $5292
	ld a, $03 ; $5295
	ld b, $c0 ; $5297
	farcall FarPtr_0a_2e ; $5299
	ld c, $04 ; $529c
	call Func_00_1d2e ; $529e
	call Func_00_1da4 ; $52a1
	ld a, $03 ; $52a4
	ld bc, $0b00 ; $52a6
	ld de, $0a00 ; $52a9
	farcall FarPtr_0a_24 ; $52ac
	ret ; $52af
	INCBIN "data/bank_013/d_52b0.bin" ; $52b0, 55 bytes
Label_13_52e7:
	call Func_13_5aca ; $52e7
	cp a, $01 ; $52ea
	jp z, Label_13_5aee ; $52ec
	rst Rst30 ; $52ef
	nop ; $52f0
	inc e ; $52f1
	jr z, Label_13_52fc ; $52f2
	ld hl, $0507 ; $52f4
	farcall FarPtr_0a_0e ; $52f7
	jr Label_13_5302 ; $52fa
Label_13_52fc:
	ld hl, $0502 ; $52fc
	farcall FarPtr_0a_0e ; $52ff
Label_13_5302:
	ld a, $02 ; $5302
	farcall FarPtr_0a_1c ; $5304
	ld a, $02 ; $5307
	ld bc, $0b00 ; $5309
	ld de, $1e00 ; $530c
	farcall FarPtr_0a_22 ; $530f
	ld a, $02 ; $5312
	ld b, $40 ; $5314
	farcall FarPtr_0a_2e ; $5316
	ld a, $03 ; $5319
	ld bc, $0b00 ; $531b
	ld de, $0a00 ; $531e
	farcall FarPtr_0a_22 ; $5321
	ld a, $03 ; $5324
	ld b, $40 ; $5326
	farcall FarPtr_0a_2e ; $5328
	ld c, $04 ; $532b
	call Func_00_1d2e ; $532d
	call Func_00_1da4 ; $5330
	rst Rst30 ; $5333
	ldh [rTIMA], a ; $5334
	jr z, Label_13_538f ; $5336
	farcall FarPtr_0a_10 ; $5338
	rst Rst30 ; $533b
	ldh [$ff15], a ; $533c
	jr nz, Label_13_5355 ; $533e
	ld a, $03 ; $5340
	farcall FarPtr_0a_08 ; $5342
	rst Rst30 ; $5345
	ld b, b ; $5346
	ld [$0b28], sp ; $5347
	farcall FarPtr_0a_10 ; $534a
	rst Rst30 ; $534d
	ret nz ; $534e
	ld [$0328], sp ; $534f
	farcall FarPtr_0a_10 ; $5352
Label_13_5355:
	ld a, $03 ; $5355
	farcall FarPtr_0a_08 ; $5357
	ld a, $00 ; $535a
	ld d, $03 ; $535c
	farcall FarPtr_0a_34 ; $535e
	ld a, $00 ; $5361
	farcall FarPtr_0a_36 ; $5363
	ld a, $03 ; $5366
	farcall FarPtr_0a_16 ; $5368
	ld c, l ; $536b
	ld b, h ; $536c
	ld de, $d000 ; $536d
	farcall FarPtr_04_20 ; $5370
	ld a, $00 ; $5373
	ld b, $40 ; $5375
	farcall FarPtr_0a_2e ; $5377
	ld a, $03 ; $537a
	farcall FarPtr_0a_16 ; $537c
	ld c, l ; $537f
	ld b, h ; $5380
	ld hl, $0005 ; $5381
	add hl, bc ; $5384
	set 4, [hl] ; $5385
	push af ; $5387
	ld a, $05 ; $5388
	farcall FarPtr_0a_04 ; $538a
	pop af ; $538d
	ret ; $538e
Label_13_538f:
	ld a, $03 ; $538f
	farcall FarPtr_0a_08 ; $5391
	ld a, $00 ; $5394
	ld d, $03 ; $5396
	farcall FarPtr_0a_34 ; $5398
	ld a, $00 ; $539b
	farcall FarPtr_0a_36 ; $539d
	ret ; $53a0
Label_13_53a1:
	rst Rst08 ; $53a1
	ld b, c ; $53a2
	ld a, $00 ; $53a3
	ld bc, $0010 ; $53a5
	farcall FarPtr_0a_18 ; $53a8
	ld bc, $0040 ; $53ab
	farcall FarPtr_0a_38 ; $53ae
	rst Rst30 ; $53b1
	nop ; $53b2
	inc e ; $53b3
	jr z, Label_13_53be ; $53b4
	ld hl, $0516 ; $53b6
	farcall FarPtr_0a_0e ; $53b9
	jr Label_13_53c4 ; $53bc
Label_13_53be:
	ld hl, $04f4 ; $53be
	farcall FarPtr_0a_0e ; $53c1
Label_13_53c4:
	ld a, $00 ; $53c4
	ld bc, $0b00 ; $53c6
	ld de, $0e00 ; $53c9
	farcall FarPtr_0a_22 ; $53cc
	ld a, $03 ; $53cf
	ld bc, $0b00 ; $53d1
	ld de, $0a00 ; $53d4
	farcall FarPtr_0a_22 ; $53d7
	xor a, a ; $53da
	ld bc, $0b00 ; $53db
	ld de, $0a00 ; $53de
	farcall FarPtr_0a_3a ; $53e1
	farcall FarPtr_0a_3e ; $53e4
	push af ; $53e7
	ld a, $78 ; $53e8
	farcall FarPtr_0a_04 ; $53ea
	pop af ; $53ed
	push af ; $53ee
	ld a, $b4 ; $53ef
	farcall FarPtr_0a_04 ; $53f1
	pop af ; $53f4
	ld c, $04 ; $53f5
	call Func_00_1d2e ; $53f7
	call Func_00_302a ; $53fa
	rst Rst08 ; $53fd
	inc e ; $53fe
	push af ; $53ff
	ld a, $0a ; $5400
	farcall FarPtr_0a_04 ; $5402
	pop af ; $5405
	ld a, $03 ; $5406
	farcall FarPtr_0a_0a ; $5408
	farcall FarPtr_0a_12 ; $540b
	farcall FarPtr_0a_0c ; $540e
	push af ; $5411
	ld a, $05 ; $5412
	farcall FarPtr_0a_04 ; $5414
	pop af ; $5417
	and a, a ; $5418
	jr nz, Label_13_5425 ; $5419
	ld a, $03 ; $541b
	farcall FarPtr_0a_08 ; $541d
	farcall FarPtr_0a_10 ; $5420
	jr Label_13_5430 ; $5423
Label_13_5425:
	farcall FarPtr_0a_10 ; $5425
	ld a, $03 ; $5428
	farcall FarPtr_0a_08 ; $542a
	rst Rst20 ; $542d
	jr nz, $544c ; $542e
Label_13_5430:
	ld a, $03 ; $5430
	ld bc, $0010 ; $5432
	farcall FarPtr_0a_18 ; $5435
	ld a, $03 ; $5438
	ld d, $03 ; $543a
	farcall FarPtr_0a_34 ; $543c
	ld a, $03 ; $543f
	farcall FarPtr_0a_36 ; $5441
	ld a, $03 ; $5444
	farcall FarPtr_0a_08 ; $5446
	ld a, $03 ; $5449
	ld bc, $0900 ; $544b
	ld de, $0a00 ; $544e
	farcall FarPtr_0a_24 ; $5451
	ld a, $03 ; $5454
	farcall FarPtr_0a_08 ; $5456
	ld a, $03 ; $5459
	farcall FarPtr_0a_20 ; $545b
	ld a, $03 ; $545e
	ld bc, $0d00 ; $5460
	ld de, $0a00 ; $5463
	farcall FarPtr_0a_24 ; $5466
	ld a, $03 ; $5469
	farcall FarPtr_0a_08 ; $546b
	ld a, $03 ; $546e
	farcall FarPtr_0a_20 ; $5470
	ld a, $03 ; $5473
	ld bc, $0b00 ; $5475
	ld de, $0a00 ; $5478
	farcall FarPtr_0a_24 ; $547b
	ld a, $03 ; $547e
	farcall FarPtr_0a_20 ; $5480
	ld a, $00 ; $5483
	ld b, a ; $5485
	ld a, $03 ; $5486
	farcall FarPtr_0a_30 ; $5488
	ld a, $03 ; $548b
	farcall FarPtr_0a_0a ; $548d
	farcall FarPtr_0a_12 ; $5490
	farcall FarPtr_0a_0c ; $5493
	push af ; $5496
	ld a, $05 ; $5497
	farcall FarPtr_0a_04 ; $5499
	pop af ; $549c
	and a, a ; $549d
	jr nz, Label_13_54aa ; $549e
	ld a, $03 ; $54a0
	farcall FarPtr_0a_08 ; $54a2
	farcall FarPtr_0a_10 ; $54a5
	jr Label_13_54b2 ; $54a8
Label_13_54aa:
	farcall FarPtr_0a_10 ; $54aa
	ld a, $03 ; $54ad
	farcall FarPtr_0a_08 ; $54af
Label_13_54b2:
	ld a, $03 ; $54b2
	ld bc, $0b00 ; $54b4
	ld de, $0b00 ; $54b7
	farcall FarPtr_0a_24 ; $54ba
	ld a, $03 ; $54bd
	farcall FarPtr_0a_20 ; $54bf
	ld a, $03 ; $54c2
	ld d, $02 ; $54c4
	farcall FarPtr_0a_34 ; $54c6
	ld a, $03 ; $54c9
	farcall FarPtr_0a_36 ; $54cb
	ld a, $03 ; $54ce
	farcall FarPtr_0a_08 ; $54d0
	ld a, $03 ; $54d3
	ld d, $03 ; $54d5
	farcall FarPtr_0a_34 ; $54d7
	ld a, $03 ; $54da
	farcall FarPtr_0a_36 ; $54dc
	ld a, $03 ; $54df
	farcall FarPtr_0a_08 ; $54e1
	ld a, $03 ; $54e4
	ld d, $03 ; $54e6
	farcall FarPtr_0a_34 ; $54e8
	ld a, $03 ; $54eb
	farcall FarPtr_0a_36 ; $54ed
	ld a, $03 ; $54f0
	farcall FarPtr_0a_0a ; $54f2
	farcall FarPtr_0a_12 ; $54f5
	farcall FarPtr_0a_0c ; $54f8
	push af ; $54fb
	ld a, $05 ; $54fc
	farcall FarPtr_0a_04 ; $54fe
	pop af ; $5501
	and a, a ; $5502
	jr nz, Label_13_5508 ; $5503
	call Func_13_58be ; $5505
Label_13_5508:
	rst Rst30 ; $5508
	nop ; $5509
	inc e ; $550a
	jr nz, Label_13_5550 ; $550b
	rst Rst30 ; $550d
	jr nz, Label_13_552c ; $550e
	jr nz, Label_13_5531 ; $5510
	push af ; $5512
	ld a, $14 ; $5513
	farcall FarPtr_0a_04 ; $5515
	pop af ; $5518
	ld a, $03 ; $5519
	ld d, $03 ; $551b
	farcall FarPtr_0a_34 ; $551d
	ld a, $03 ; $5520
	farcall FarPtr_0a_36 ; $5522
	ld hl, $0500 ; $5525
	farcall FarPtr_0a_0e ; $5528
	INCBIN "data/bank_013/d_552b.bin" ; $552b, 1 bytes
Label_13_552c:
	inc bc ; $552c
	farcall FarPtr_0a_08 ; $552d
	ret ; $5530
Label_13_5531:
	push af ; $5531
	ld a, $14 ; $5532
	farcall FarPtr_0a_04 ; $5534
	pop af ; $5537
	ld a, $03 ; $5538
	ld d, $03 ; $553a
	farcall FarPtr_0a_34 ; $553c
	ld a, $03 ; $553f
	farcall FarPtr_0a_36 ; $5541
	ld hl, $0501 ; $5544
	farcall FarPtr_0a_0e ; $5547
	ld a, $03 ; $554a
	farcall FarPtr_0a_08 ; $554c
	ret ; $554f
Label_13_5550:
	rst Rst30 ; $5550
	jr nz, $556f ; $5551
	jr nz, Label_13_5574 ; $5553
	push af ; $5555
	ld a, $14 ; $5556
	farcall FarPtr_0a_04 ; $5558
	pop af ; $555b
	ld a, $03 ; $555c
	ld d, $03 ; $555e
	farcall FarPtr_0a_34 ; $5560
	ld a, $03 ; $5563
	farcall FarPtr_0a_36 ; $5565
	ld hl, $0523 ; $5568
	farcall FarPtr_0a_0e ; $556b
	ld a, $03 ; $556e
	farcall FarPtr_0a_08 ; $5570
	ret ; $5573
Label_13_5574:
	push af ; $5574
	ld a, $14 ; $5575
	farcall FarPtr_0a_04 ; $5577
	pop af ; $557a
	ld a, $03 ; $557b
	ld d, $03 ; $557d
	farcall FarPtr_0a_34 ; $557f
	ld a, $03 ; $5582
	farcall FarPtr_0a_36 ; $5584
	ld hl, $0522 ; $5587
	farcall FarPtr_0a_0e ; $558a
	ld a, $03 ; $558d
	farcall FarPtr_0a_08 ; $558f
	ret ; $5592
Label_13_5593:
	rst Rst30 ; $5593
	nop ; $5594
	inc e ; $5595
	jr z, Label_13_55a3 ; $5596
	ld hl, $c2b2 ; $5598
	ld de, $052a ; $559b
	ld a, e ; $559e
	ld [hl+], a ; $559f
	ld [hl], d ; $55a0
	jr Label_13_55ac ; $55a1
Label_13_55a3:
	ld hl, $c2b2 ; $55a3
	ld de, $0524 ; $55a6
	ld a, e ; $55a9
	ld [hl+], a ; $55aa
	ld [hl], d ; $55ab
Label_13_55ac:
	ld hl, $c2b2 ; $55ac
	ld a, [hl+] ; $55af
	ld h, [hl] ; $55b0
	ld l, a ; $55b1
	farcall FarPtr_0a_0e ; $55b2
	rst Rst30 ; $55b5
	ldh [rTIMA], a ; $55b6
	jr z, Label_13_55bd ; $55b8
	farcall FarPtr_0a_10 ; $55ba
Label_13_55bd:
	push af ; $55bd
	ld a, $1e ; $55be
	farcall FarPtr_0a_04 ; $55c0
	pop af ; $55c3
	ld a, $00 ; $55c4
	ld bc, $0b00 ; $55c6
	ld de, $0e00 ; $55c9
	farcall FarPtr_0a_24 ; $55cc
	ld c, $04 ; $55cf
	call Func_00_1d2e ; $55d1
	call Func_00_1da4 ; $55d4
	xor a, a ; $55d7
	ld bc, $0b00 ; $55d8
	ld de, $0c40 ; $55db
	farcall FarPtr_0a_3a ; $55de
	farcall FarPtr_0a_3e ; $55e1
	ld a, $03 ; $55e4
	ld b, $40 ; $55e6
	farcall FarPtr_0a_2e ; $55e8
	ld a, $03 ; $55eb
	ld d, $03 ; $55ed
	farcall FarPtr_0a_34 ; $55ef
	ld a, $03 ; $55f2
	farcall FarPtr_0a_36 ; $55f4
	ld a, $03 ; $55f7
	farcall FarPtr_0a_08 ; $55f9
	call Func_13_5aca ; $55fc
	and a, a ; $55ff
	jp z, Label_13_560d ; $5600
	ld hl, $c2b2 ; $5603
	ld a, [hl+] ; $5606
	ld h, [hl] ; $5607
	ld l, a ; $5608
	ld a, $05 ; $5609
	jr Label_13_5615 ; $560b
Label_13_560d:
	ld hl, $c2b2 ; $560d
	ld a, [hl+] ; $5610
	ld h, [hl] ; $5611
	ld l, a ; $5612
	ld a, $02 ; $5613
Label_13_5615:
	add a, l ; $5615
	ld l, a ; $5616
	jr nc, Label_13_561a ; $5617
	inc h ; $5619
Label_13_561a:
	farcall FarPtr_0a_0e ; $561a
	ld a, $03 ; $561d
	ld d, $04 ; $561f
	farcall FarPtr_0a_34 ; $5621
	ld a, $03 ; $5624
	farcall FarPtr_0a_36 ; $5626
	ld a, $03 ; $5629
	farcall FarPtr_0a_0a ; $562b
	farcall FarPtr_0a_12 ; $562e
	farcall FarPtr_0a_0c ; $5631
	push af ; $5634
	ld a, $05 ; $5635
	farcall FarPtr_0a_04 ; $5637
	pop af ; $563a
	and a, a ; $563b
	jr nz, Label_13_568f ; $563c
	ld hl, $c2b2 ; $563e
	ld a, [hl+] ; $5641
	ld h, [hl] ; $5642
	ld l, a ; $5643
	ld a, $03 ; $5644
	add a, l ; $5646
	ld l, a ; $5647
	jr nc, Label_13_564b ; $5648
	inc h ; $564a
Label_13_564b:
	farcall FarPtr_0a_0e ; $564b
	ld a, $03 ; $564e
	farcall FarPtr_0a_08 ; $5650
	rst Rst08 ; $5653
	nop ; $5654
	push af ; $5655
	ld a, $02 ; $5656
	farcall FarPtr_0a_04 ; $5658
	pop af ; $565b
	rst Rst08 ; $565c
	ld b, c ; $565d
	ld a, $00 ; $565e
	ld d, $03 ; $5660
	farcall FarPtr_0a_34 ; $5662
	ld a, $03 ; $5665
	ld d, $03 ; $5667
	farcall FarPtr_0a_34 ; $5669
	ld a, $03 ; $566c
	farcall FarPtr_0a_36 ; $566e
	call Func_00_302a ; $5671
	ld c, $04 ; $5674
	call Func_00_1d20 ; $5676
	call Func_00_1da4 ; $5679
	ld a, $02 ; $567c
	ld [$c294], a ; $567e
	ld [$c2a1], a ; $5681
	ld b, $0a ; $5684
	ld c, $01 ; $5686
	farcall FarPtr_0a_62 ; $5688
	farcall FarPtr_03_18 ; $568b
	ret ; $568e
Label_13_568f:
	ld hl, $c2b2 ; $568f
	ld a, [hl+] ; $5692
	ld h, [hl] ; $5693
	ld l, a ; $5694
	ld a, $04 ; $5695
	add a, l ; $5697
	ld l, a ; $5698
	jr nc, Label_13_569c ; $5699
	inc h ; $569b
Label_13_569c:
	farcall FarPtr_0a_0e ; $569c
	ld a, $03 ; $569f
	farcall FarPtr_0a_0a ; $56a1
	farcall FarPtr_0a_12 ; $56a4
	farcall FarPtr_0a_0c ; $56a7
	push af ; $56aa
	ld a, $05 ; $56ab
	farcall FarPtr_0a_04 ; $56ad
	pop af ; $56b0
	and a, a ; $56b1
	jr nz, Label_13_56b7 ; $56b2
	call Func_13_58be ; $56b4
Label_13_56b7:
	call Func_13_56bb ; $56b7
	ret ; $56ba
Func_13_56bb:
	rst Rst30 ; $56bb
	ldh [rTIMA], a ; $56bc
	jp nz, Label_13_5782 ; $56be
	rst Rst30 ; $56c1
	nop ; $56c2
	inc e ; $56c3
	jr nz, Label_13_56ce ; $56c4
	ld hl, $0536 ; $56c6
	farcall FarPtr_0a_0e ; $56c9
	jr Label_13_56d4 ; $56cc
Label_13_56ce:
	ld hl, $0530 ; $56ce
	farcall FarPtr_0a_0e ; $56d1
Label_13_56d4:
	ld a, $03 ; $56d4
	farcall FarPtr_0a_0a ; $56d6
	farcall FarPtr_0a_12 ; $56d9
	farcall FarPtr_0a_0c ; $56dc
	push af ; $56df
	ld a, $05 ; $56e0
	farcall FarPtr_0a_04 ; $56e2
	pop af ; $56e5
	and a, a ; $56e6
	jr nz, Label_13_574c ; $56e7
	rst Rst20 ; $56e9
	ldh [rTIMA], a ; $56ea
	call Func_13_5bdf ; $56ec
	ld a, $03 ; $56ef
	farcall FarPtr_0a_08 ; $56f1
	ld a, $00 ; $56f4
	ld d, $03 ; $56f6
	farcall FarPtr_0a_34 ; $56f8
	ld a, $00 ; $56fb
	farcall FarPtr_0a_36 ; $56fd
	push af ; $5700
	ld a, $05 ; $5701
	farcall FarPtr_0a_04 ; $5703
	pop af ; $5706
	ld a, $00 ; $5707
	ld b, $40 ; $5709
	farcall FarPtr_0a_2e ; $570b
	ld a, $04 ; $570e
	ldh [$ff96], a ; $5710
	ldh [rWBK], a ; $5712
	ld a, $01 ; $5714
	ld [$c8f2], a ; $5716
	call Func_13_5067 ; $5719
	push af ; $571c
	ld a, $05 ; $571d
	farcall FarPtr_0a_04 ; $571f
	pop af ; $5722
	ld a, $03 ; $5723
	farcall FarPtr_0a_16 ; $5725
	ld c, l ; $5728
	ld b, h ; $5729
	ld de, $d000 ; $572a
	farcall FarPtr_04_20 ; $572d
	ld a, $03 ; $5730
	farcall FarPtr_0a_16 ; $5732
	ld c, l ; $5735
	ld b, h ; $5736
	ld hl, $0005 ; $5737
	add hl, bc ; $573a
	set 4, [hl] ; $573b
	push af ; $573d
	ld a, $05 ; $573e
	farcall FarPtr_0a_04 ; $5740
	pop af ; $5743
	ld a, $00 ; $5744
	ld b, $40 ; $5746
	farcall FarPtr_0a_2e ; $5748
	ret ; $574b
Label_13_574c:
	call Func_13_5b8b ; $574c
	farcall FarPtr_0a_10 ; $574f
	ld a, $03 ; $5752
	farcall FarPtr_0a_08 ; $5754
	rst Rst28 ; $5757
	ldh [rTIMA], a ; $5758
	ld a, $04 ; $575a
	ldh [$ff96], a ; $575c
	ldh [rWBK], a ; $575e
	ld a, $00 ; $5760
	ld [$c8f2], a ; $5762
	ld a, $03 ; $5765
	farcall FarPtr_0a_1c ; $5767
	ld a, $03 ; $576a
	farcall FarPtr_0a_16 ; $576c
	ld c, l ; $576f
	ld b, h ; $5770
	ld hl, $0005 ; $5771
	add hl, bc ; $5774
	set 3, [hl] ; $5775
	call Func_13_5067 ; $5777
	ld a, $03 ; $577a
	ld b, $40 ; $577c
	farcall FarPtr_0a_2e ; $577e
	ret ; $5781
Label_13_5782:
	rst Rst30 ; $5782
	nop ; $5783
	inc e ; $5784
	jr nz, Label_13_578f ; $5785
	ld hl, $0539 ; $5787
	farcall FarPtr_0a_0e ; $578a
	jr Label_13_5795 ; $578d
Label_13_578f:
	ld hl, $0533 ; $578f
	farcall FarPtr_0a_0e ; $5792
Label_13_5795:
	ld a, $03 ; $5795
	farcall FarPtr_0a_0a ; $5797
	farcall FarPtr_0a_12 ; $579a
	farcall FarPtr_0a_0c ; $579d
	push af ; $57a0
	ld a, $05 ; $57a1
	farcall FarPtr_0a_04 ; $57a3
	pop af ; $57a6
	and a, a ; $57a7
	jr nz, Label_13_5807 ; $57a8
	call Func_13_5bc3 ; $57aa
	ld a, $03 ; $57ad
	farcall FarPtr_0a_08 ; $57af
	ld a, $03 ; $57b2
	farcall FarPtr_0a_1c ; $57b4
	rst Rst28 ; $57b7
	ldh [rTIMA], a ; $57b8
	ld a, $04 ; $57ba
	ldh [$ff96], a ; $57bc
	ldh [rWBK], a ; $57be
	ld a, $00 ; $57c0
	ld [$c8f2], a ; $57c2
	ld a, $03 ; $57c5
	ld bc, $0b00 ; $57c7
	ld de, $0900 ; $57ca
	farcall FarPtr_0a_24 ; $57cd
	ld a, $03 ; $57d0
	farcall FarPtr_0a_20 ; $57d2
	push af ; $57d5
	ld a, $05 ; $57d6
	farcall FarPtr_0a_04 ; $57d8
	pop af ; $57db
	ld a, $03 ; $57dc
	ld b, $40 ; $57de
	farcall FarPtr_0a_2e ; $57e0
	push af ; $57e3
	ld a, $05 ; $57e4
	farcall FarPtr_0a_04 ; $57e6
	pop af ; $57e9
	ld a, $03 ; $57ea
	farcall FarPtr_0a_16 ; $57ec
	ld c, l ; $57ef
	ld b, h ; $57f0
	ld hl, $0005 ; $57f1
	add hl, bc ; $57f4
	set 3, [hl] ; $57f5
	call Func_13_5067 ; $57f7
	ld a, $03 ; $57fa
	farcall FarPtr_0a_1c ; $57fc
	ld a, $03 ; $57ff
	ld b, $40 ; $5801
	farcall FarPtr_0a_2e ; $5803
	ret ; $5806
Label_13_5807:
	call Func_13_5ba7 ; $5807
	farcall FarPtr_0a_10 ; $580a
	ld a, $03 ; $580d
	farcall FarPtr_0a_08 ; $580f
	ld a, $00 ; $5812
	ld d, $03 ; $5814
	farcall FarPtr_0a_34 ; $5816
	ld a, $00 ; $5819
	farcall FarPtr_0a_36 ; $581b
	ld a, $00 ; $581e
	ld b, $40 ; $5820
	farcall FarPtr_0a_2e ; $5822
	push af ; $5825
	ld a, $05 ; $5826
	farcall FarPtr_0a_04 ; $5828
	pop af ; $582b
	ld a, $04 ; $582c
	ldh [$ff96], a ; $582e
	ldh [rWBK], a ; $5830
	ld a, $01 ; $5832
	ld [$c8f2], a ; $5834
	rst Rst20 ; $5837
	ldh [rTIMA], a ; $5838
	call Func_13_5067 ; $583a
	ld a, $03 ; $583d
	farcall FarPtr_0a_16 ; $583f
	ld c, l ; $5842
	ld b, h ; $5843
	ld de, $d000 ; $5844
	farcall FarPtr_04_20 ; $5847
	ld a, $03 ; $584a
	farcall FarPtr_0a_16 ; $584c
	ld c, l ; $584f
	ld b, h ; $5850
	ld hl, $0005 ; $5851
	add hl, bc ; $5854
	set 4, [hl] ; $5855
	ld a, $00 ; $5857
	ld b, $40 ; $5859
	farcall FarPtr_0a_2e ; $585b
	ret ; $585e
	INCBIN "data/bank_013/d_585f.bin" ; $585f, 95 bytes
Func_13_58be:
	rst Rst30 ; $58be
	nop ; $58bf
	inc e ; $58c0
	jr z, Label_13_58cb ; $58c1
	ld hl, $c2b2 ; $58c3
	ld de, $054f ; $58c6
	jr Label_13_58d1 ; $58c9
Label_13_58cb:
	ld hl, $c2b2 ; $58cb
	ld de, $0808 ; $58ce
Label_13_58d1:
	ld a, e ; $58d1
	ld [hl+], a ; $58d2
	ld [hl], d ; $58d3
	ld hl, $054c ; $58d4
	rst Rst30 ; $58d7
	ldh [$ff0a], a ; $58d8
	jr z, Label_13_58e7 ; $58da
	ld hl, $054d ; $58dc
	rst Rst30 ; $58df
	nop ; $58e0
	dec bc ; $58e1
	jr z, Label_13_58e7 ; $58e2
	ld hl, $054e ; $58e4
Label_13_58e7:
	ld de, $0101 ; $58e7
	ld a, $01 ; $58ea
	farcall FarPtr_05_3e ; $58ec
	cp a, $ff ; $58ef
	jp z, Label_13_5927 ; $58f1
	add a, a ; $58f4
	add a, $28 ; $58f5
	ld l, a ; $58f7
	adc a, $59 ; $58f8
	sub a, l ; $58fa
	ld h, a ; $58fb
	ld a, [hl+] ; $58fc
	ld h, [hl] ; $58fd
	ld l, a ; $58fe
	call JumpToHL ; $58ff
	ld a, $03 ; $5902
	farcall FarPtr_0a_08 ; $5904
	ld hl, $c2b2 ; $5907
	ld a, [hl+] ; $590a
	ld h, [hl] ; $590b
	ld l, a ; $590c
	farcall FarPtr_0a_0e ; $590d
	ld a, $03 ; $5910
	farcall FarPtr_0a_0a ; $5912
	farcall FarPtr_0a_12 ; $5915
	farcall FarPtr_0a_0c ; $5918
	push af ; $591b
	ld a, $05 ; $591c
	farcall FarPtr_0a_04 ; $591e
	pop af ; $5921
	and a, a ; $5922
	jr nz, Label_13_5927 ; $5923
	jr Label_13_58d1 ; $5925
Label_13_5927:
	ret ; $5927
	INCBIN "data/bank_013/d_5928.bin" ; $5928, 256 bytes
Func_13_5a28:
	rst Rst08 ; $5a28
	nop ; $5a29
	ld a, $03 ; $5a2a
	ld bc, $3f00 ; $5a2c
	ld de, $3f00 ; $5a2f
	farcall FarPtr_0a_22 ; $5a32
	ld a, $04 ; $5a35
	ld bc, $3f00 ; $5a37
	ld de, $3f00 ; $5a3a
	farcall FarPtr_0a_22 ; $5a3d
	ld a, $00 ; $5a40
	ld b, $00 ; $5a42
	farcall FarPtr_0a_48 ; $5a44
	ld a, $02 ; $5a47
	ld b, $00 ; $5a49
	farcall FarPtr_0a_48 ; $5a4b
	ld b, $00 ; $5a4e
	ld c, $20 ; $5a50
	ld d, $00 ; $5a52
	ld e, $00 ; $5a54
	ld h, $16 ; $5a56
	ld l, $18 ; $5a58
	farcall FarPtr_0a_7e ; $5a5a
	ld c, $08 ; $5a5d
	call Func_00_1d2e ; $5a5f
	push af ; $5a62
	ld a, $04 ; $5a63
	farcall FarPtr_0a_04 ; $5a65
	pop af ; $5a68
	ld a, $85 ; $5a69
	farcall FarPtr_0a_08 ; $5a6b
	push af ; $5a6e
	ld a, $04 ; $5a6f
	farcall FarPtr_0a_04 ; $5a71
	pop af ; $5a74
	ret ; $5a75
Label_13_5a76:
	ld hl, $01f0 ; $5a76
	farcall FarPtr_0a_0e ; $5a79
	call Func_13_5a28 ; $5a7c
	ld a, $14 ; $5a7f
	ld [wStoryModeCurrentLocation], a ; $5a81
	ld a, $0a ; $5a84
	ld [$c295], a ; $5a86
	ld a, $ff ; $5a89
	ld [$c294], a ; $5a8b
	ld [$c2a1], a ; $5a8e
	ret ; $5a91
Label_13_5a92:
	ld hl, $01f1 ; $5a92
	farcall FarPtr_0a_0e ; $5a95
	call Func_13_5a28 ; $5a98
	ld a, $15 ; $5a9b
	ld [wStoryModeCurrentLocation], a ; $5a9d
	ld a, $0f ; $5aa0
	ld [$c295], a ; $5aa2
	ld a, $ff ; $5aa5
	ld [$c294], a ; $5aa7
	ld [$c2a1], a ; $5aaa
	ret ; $5aad
Label_13_5aae:
	ld hl, $01f0 ; $5aae
	farcall FarPtr_0a_0e ; $5ab1
	call Func_13_5a28 ; $5ab4
	ld a, $14 ; $5ab7
	ld [wStoryModeCurrentLocation], a ; $5ab9
	ld a, $0a ; $5abc
	ld [$c295], a ; $5abe
	ld a, $ff ; $5ac1
	ld [$c294], a ; $5ac3
	ld [$c2a1], a ; $5ac6
	ret ; $5ac9
Func_13_5aca:
	rst Rst30 ; $5aca
	ldh [rTIMA], a ; $5acb
	jr nz, Label_13_5ae2 ; $5acd
	rst Rst30 ; $5acf
	nop ; $5ad0
	INCBIN "data/bank_013/d_5ad1.bin" ; $5ad1, 1 bytes
	jr nz, Label_13_5adf ; $5ad2
	rst Rst30 ; $5ad4
	ret nz ; $5ad5
	dec d ; $5ad6
	jr nz, Label_13_5adc ; $5ad7
Label_13_5ad9:
	ld a, $00 ; $5ad9
	ret ; $5adb
Label_13_5adc:
	ld a, $01 ; $5adc
	ret ; $5ade
Label_13_5adf:
	ld a, $02 ; $5adf
	ret ; $5ae1
Label_13_5ae2:
	rst Rst30 ; $5ae2
	jr nz, Label_13_5afb ; $5ae3
	jr nz, Label_13_5adf ; $5ae5
	rst Rst30 ; $5ae7
	ldh [$ff15], a ; $5ae8
	jr nz, Label_13_5adc ; $5aea
	jr Label_13_5ad9 ; $5aec
Label_13_5aee:
	rst Rst30 ; $5aee
	nop ; $5aef
	inc e ; $5af0
	jr z, Label_13_5afb ; $5af1
	ld hl, $0511 ; $5af3
	farcall FarPtr_0a_0e ; $5af6
	jr Label_13_5b01 ; $5af9
Label_13_5afb:
	ld hl, $050c ; $5afb
	farcall FarPtr_0a_0e ; $5afe
Label_13_5b01:
	ld a, $02 ; $5b01
	farcall FarPtr_0a_1c ; $5b03
	ld a, $02 ; $5b06
	ld bc, $0b00 ; $5b08
	ld de, $1e00 ; $5b0b
	farcall FarPtr_0a_22 ; $5b0e
	ld a, $02 ; $5b11
	ld b, $40 ; $5b13
	farcall FarPtr_0a_2e ; $5b15
	ld a, $03 ; $5b18
	ld bc, $0b00 ; $5b1a
	ld de, $0a00 ; $5b1d
	farcall FarPtr_0a_22 ; $5b20
	ld a, $03 ; $5b23
	ld b, $40 ; $5b25
	farcall FarPtr_0a_2e ; $5b27
	ld c, $04 ; $5b2a
	call Func_00_1d2e ; $5b2c
	call Func_00_1da4 ; $5b2f
	rst Rst30 ; $5b32
	ldh [rTIMA], a ; $5b33
	jr z, Label_13_5b79 ; $5b35
	farcall FarPtr_0a_10 ; $5b37
	ld a, $03 ; $5b3a
	farcall FarPtr_0a_08 ; $5b3c
	ld a, $03 ; $5b3f
	farcall FarPtr_0a_08 ; $5b41
	ld a, $00 ; $5b44
	ld d, $03 ; $5b46
	farcall FarPtr_0a_34 ; $5b48
	ld a, $00 ; $5b4b
	farcall FarPtr_0a_36 ; $5b4d
	ld a, $00 ; $5b50
	ld b, $40 ; $5b52
	farcall FarPtr_0a_2e ; $5b54
	push af ; $5b57
	ld a, $05 ; $5b58
	farcall FarPtr_0a_04 ; $5b5a
	pop af ; $5b5d
	ld a, $03 ; $5b5e
	farcall FarPtr_0a_16 ; $5b60
	ld c, l ; $5b63
	ld b, h ; $5b64
	ld de, $d000 ; $5b65
	farcall FarPtr_04_20 ; $5b68
	ld a, $03 ; $5b6b
	farcall FarPtr_0a_16 ; $5b6d
	ld c, l ; $5b70
	ld b, h ; $5b71
	ld hl, $0005 ; $5b72
	add hl, bc ; $5b75
	set 4, [hl] ; $5b76
	ret ; $5b78
Label_13_5b79:
	ld a, $03 ; $5b79
	farcall FarPtr_0a_08 ; $5b7b
	ld a, $00 ; $5b7e
	ld d, $03 ; $5b80
	farcall FarPtr_0a_34 ; $5b82
	ld a, $00 ; $5b85
	farcall FarPtr_0a_36 ; $5b87
	ret ; $5b8a
Func_13_5b8b:
	call Func_13_5aca ; $5b8b
	cp a, $01 ; $5b8e
	jp nz, Label_13_5ba6 ; $5b90
	rst Rst30 ; $5b93
	nop ; $5b94
	inc e ; $5b95
	jr z, Label_13_5ba0 ; $5b96
	ld hl, $0513 ; $5b98
	farcall FarPtr_0a_0e ; $5b9b
	jr Label_13_5ba6 ; $5b9e
Label_13_5ba0:
	ld hl, $050e ; $5ba0
	farcall FarPtr_0a_0e ; $5ba3
Label_13_5ba6:
	ret ; $5ba6
Func_13_5ba7:
	call Func_13_5aca ; $5ba7
	cp a, $01 ; $5baa
	jp nz, Label_13_5bc2 ; $5bac
	rst Rst30 ; $5baf
	nop ; $5bb0
	inc e ; $5bb1
	jr z, Label_13_5bbc ; $5bb2
	ld hl, $0514 ; $5bb4
	farcall FarPtr_0a_0e ; $5bb7
	jr Label_13_5bc2 ; $5bba
Label_13_5bbc:
	ld hl, $050f ; $5bbc
	farcall FarPtr_0a_0e ; $5bbf
Label_13_5bc2:
	ret ; $5bc2
Func_13_5bc3:
	call Func_13_5aca ; $5bc3
	cp a, $01 ; $5bc6
	jp nz, Label_13_5bde ; $5bc8
	rst Rst30 ; $5bcb
	nop ; $5bcc
	inc e ; $5bcd
	jr z, Label_13_5bd8 ; $5bce
	ld hl, $0514 ; $5bd0
	farcall FarPtr_0a_0e ; $5bd3
	jr Label_13_5bde ; $5bd6
Label_13_5bd8:
	ld hl, $050f ; $5bd8
	farcall FarPtr_0a_0e ; $5bdb
Label_13_5bde:
	ret ; $5bde
Func_13_5bdf:
	call Func_13_5aca ; $5bdf
	cp a, $01 ; $5be2
	jp nz, Label_13_5bfa ; $5be4
	rst Rst30 ; $5be7
	nop ; $5be8
	inc e ; $5be9
	jr z, Label_13_5bf4 ; $5bea
	ld hl, $0515 ; $5bec
	farcall FarPtr_0a_0e ; $5bef
	jr Label_13_5bfa ; $5bf2
Label_13_5bf4:
	ld hl, $0510 ; $5bf4
	farcall FarPtr_0a_0e ; $5bf7
Label_13_5bfa:
	ret ; $5bfa
	INCBIN "data/bank_013/d_5bfb.bin" ; $5bfb, 62 bytes
Func_13_5c39:
	ld a, $00 ; $5c39
	farcall FarPtr_0a_16 ; $5c3b
	ld c, l ; $5c3e
	ld b, h ; $5c3f
	ld hl, $000c ; $5c40
	add hl, bc ; $5c43
	ld a, [hl+] ; $5c44
	ld h, [hl] ; $5c45
	ld l, a ; $5c46
	ld de, $0000 ; $5c47
	add hl, de ; $5c4a
	ld e, l ; $5c4b
	ld d, h ; $5c4c
	ld hl, $c2b8 ; $5c4d
	ld a, e ; $5c50
	ld [hl+], a ; $5c51
	ld [hl], d ; $5c52
	ld hl, $000e ; $5c53
	add hl, bc ; $5c56
	ld a, [hl+] ; $5c57
	ld h, [hl] ; $5c58
	ld l, a ; $5c59
	ld de, $0000 ; $5c5a
	add hl, de ; $5c5d
	ld e, l ; $5c5e
	ld d, h ; $5c5f
	ld hl, $c2ba ; $5c60
	ld a, e ; $5c63
	ld [hl+], a ; $5c64
	ld [hl], d ; $5c65
	ld hl, $c2b8 ; $5c66
	ld a, [hl+] ; $5c69
	ld b, [hl] ; $5c6a
	ld c, a ; $5c6b
	ld hl, $c2ba ; $5c6c
	ld a, [hl+] ; $5c6f
	ld d, [hl] ; $5c70
	ld e, a ; $5c71
	ld a, $03 ; $5c72
	farcall FarPtr_0a_22 ; $5c74
	ret ; $5c77
	INCBIN "data/bank_013/d_5c78.bin" ; $5c78, 562 bytes
	ld hl, $020f ; $5eaa
	farcall FarPtr_0a_0e ; $5ead
	rst Rst30 ; $5eb0
	ldh [rTIMA], a ; $5eb1
	jr z, Label_13_5ebb ; $5eb3
	ld hl, $0211 ; $5eb5
	farcall FarPtr_0a_0e ; $5eb8
Label_13_5ebb:
	ld a, $03 ; $5ebb
	farcall FarPtr_0a_0a ; $5ebd
	farcall FarPtr_0a_12 ; $5ec0
	farcall FarPtr_0a_0c ; $5ec3
	push af ; $5ec6
	ld a, $05 ; $5ec7
	farcall FarPtr_0a_04 ; $5ec9
	pop af ; $5ecc
	and a, a ; $5ecd
	jr nz, Label_13_5ed6 ; $5ece
	ld hl, $0213 ; $5ed0
	farcall FarPtr_0a_0e ; $5ed3
Label_13_5ed6:
	ld a, $03 ; $5ed6
	farcall FarPtr_0a_08 ; $5ed8
	ret ; $5edb
	INCBIN "data/bank_013/d_5edc.bin" ; $5edc, 685 bytes
	call Func_13_61a9 ; $6189
	ld a, [$c295] ; $618c
	cp a, $0f ; $618f
	jr nz, Label_13_6196 ; $6191
	jp Label_13_636c ; $6193
Label_13_6196:
	cp a, $0d ; $6196
	jr nz, Label_13_619e ; $6198
	call Func_13_7995 ; $619a
	ret ; $619d
Label_13_619e:
	cp a, $0e ; $619e
	jr nz, Label_13_61a5 ; $61a0
	jp Label_13_7988 ; $61a2
Label_13_61a5:
	call Func_13_62ff ; $61a5
	ret ; $61a8
Func_13_61a9:
	rst Rst30 ; $61a9
	ldh [rTIMA], a ; $61aa
	jr nz, Label_13_6222 ; $61ac
	rst Rst30 ; $61ae
	nop ; $61af
	INCBIN "data/bank_013/d_61b0.bin" ; $61b0, 1 bytes
	jr z, Label_13_61e1 ; $61b1
	ld hl, $60ef ; $61b3
	ld de, $000c ; $61b6
	farcall FarPtr_0a_60 ; $61b9
	ld a, $18 ; $61bc
	ld d, $08 ; $61be
	ld e, $10 ; $61c0
	farcall FarPtr_0a_8a ; $61c2
	ld a, $18 ; $61c5
	ld d, $06 ; $61c7
	ld e, $10 ; $61c9
	farcall FarPtr_0a_8a ; $61cb
	ld a, $06 ; $61ce
	ld bc, $0500 ; $61d0
	ld de, $1500 ; $61d3
	farcall FarPtr_0a_22 ; $61d6
	ld a, $06 ; $61d9
	ld b, $00 ; $61db
	farcall FarPtr_0a_2e ; $61dd
	ret ; $61e0
Label_13_61e1:
	rst Rst30 ; $61e1
	ret nz ; $61e2
	dec d ; $61e3
	jr z, Label_13_620a ; $61e4
	ldh a, [$ff95] ; $61e6
	ld hl, $5dca ; $61e8
	farcall FarPtr_0a_06 ; $61eb
	ld hl, $609f ; $61ee
	ld de, $000c ; $61f1
	farcall FarPtr_0a_60 ; $61f4
	ld a, $18 ; $61f7
	ld d, $08 ; $61f9
	ld e, $10 ; $61fb
	farcall FarPtr_0a_8a ; $61fd
	ld a, $18 ; $6200
	ld d, $06 ; $6202
	ld e, $10 ; $6204
	farcall FarPtr_0a_8a ; $6206
	ret ; $6209
Label_13_620a:
	rst Rst30 ; $620a
	ldh [$ff0a], a ; $620b
	jp z, Label_13_62bd ; $620d
	ldh a, [$ff95] ; $6210
	ld hl, $5ce4 ; $6212
	farcall FarPtr_0a_06 ; $6215
	ld hl, $5f70 ; $6218
	ld de, $000c ; $621b
	farcall FarPtr_0a_60 ; $621e
	ret ; $6221
Label_13_6222:
	rst Rst30 ; $6222
	jr nz, Label_13_623b ; $6223
	jr z, Label_13_627e ; $6225
	ldh a, [$ff95] ; $6227
	ld hl, $5d50 ; $6229
	farcall FarPtr_0a_06 ; $622c
	ld hl, $613b ; $622f
	ld de, $000c ; $6232
	farcall FarPtr_0a_60 ; $6235
	ld a, $09 ; $6238
	INCBIN "data/bank_013/d_623a.bin" ; $623a, 1 bytes
Label_13_623b:
	nop ; $623b
	ccf ; $623c
	ld de, $3f00 ; $623d
	farcall FarPtr_0a_22 ; $6240
	ld a, $04 ; $6243
	ld b, $00 ; $6245
	farcall FarPtr_0a_2e ; $6247
	ldh a, [$ff95] ; $624a
	ld b, a ; $624c
	ld a, $06 ; $624d
	ld de, $7cf5 ; $624f
	farcall FarPtr_0a_1a ; $6252
	ld a, $18 ; $6255
	ld d, $08 ; $6257
	ld e, $10 ; $6259
	farcall FarPtr_0a_8a ; $625b
	ld a, $18 ; $625e
	ld d, $06 ; $6260
	ld e, $10 ; $6262
	farcall FarPtr_0a_8a ; $6264
	ld a, $07 ; $6267
	ld bc, $0f00 ; $6269
	ld de, $1700 ; $626c
	farcall FarPtr_0a_22 ; $626f
	ldh a, [$ff95] ; $6272
	ld b, a ; $6274
	ld a, $07 ; $6275
	ld de, $7b2f ; $6277
	farcall FarPtr_0a_1a ; $627a
	ret ; $627d
Label_13_627e:
	rst Rst30 ; $627e
	ldh [$ff15], a ; $627f
	jr z, Label_13_62a7 ; $6281
	ldh a, [$ff95] ; $6283
	ld hl, $5dfe ; $6285
	farcall FarPtr_0a_06 ; $6288
	ld hl, $609f ; $628b
	ld de, $000c ; $628e
	farcall FarPtr_0a_60 ; $6291
	ld a, $18 ; $6294
	ld d, $08 ; $6296
	ld e, $10 ; $6298
	farcall FarPtr_0a_8a ; $629a
	ld a, $18 ; $629d
	ld d, $06 ; $629f
	ld e, $10 ; $62a1
	farcall FarPtr_0a_8a ; $62a3
	ret ; $62a6
Label_13_62a7:
	rst Rst30 ; $62a7
	ret nz ; $62a8
	ld [$1128], sp ; $62a9
	ldh a, [$ff95] ; $62ac
	ld hl, $5d50 ; $62ae
	farcall FarPtr_0a_06 ; $62b1
	ld hl, $6020 ; $62b4
	ld de, $000c ; $62b7
	farcall FarPtr_0a_60 ; $62ba
Label_13_62bd:
	ret ; $62bd
Func_13_62be:
	ld a, [$c94d] ; $62be
	or a, a ; $62c1
	jr nz, Label_13_62da ; $62c2
	ld d, $28 ; $62c4
	ld a, $0d ; $62c6
	farcall FarPtr_0a_16 ; $62c8
	ld c, l ; $62cb
	ld b, h ; $62cc
	farcall FarPtr_04_2c ; $62cd
	ld a, $0d ; $62d0
	ld d, $01 ; $62d2
	farcall FarPtr_0a_34 ; $62d4
	rst Rst20 ; $62d7
	nop ; $62d8
	inc e ; $62d9
Label_13_62da:
	ret ; $62da
	INCBIN "data/bank_013/d_62db.bin" ; $62db, 36 bytes
Func_13_62ff:
	ld a, [$c295] ; $62ff
	cp a, $ff ; $6302
	jp z, Label_13_6365 ; $6304
	rst Rst30 ; $6307
	ldh [rTIMA], a ; $6308
	jr z, Label_13_6348 ; $630a
	ld a, $02 ; $630c
	ld bc, $00ff ; $630e
	farcall FarPtr_0a_18 ; $6311
	ld a, [$c295] ; $6314
	dec a ; $6317
	add a, $69 ; $6318
	ld l, a ; $631a
	adc a, $63 ; $631b
	sub a, l ; $631d
	ld h, a ; $631e
	ld b, [hl] ; $631f
	ld a, $02 ; $6320
	ld b, b ; $6322
	ld de, $0200 ; $6323
	farcall FarPtr_0a_2a ; $6326
	ld a, $02 ; $6329
	farcall FarPtr_0a_20 ; $632b
	ld a, [$c295] ; $632e
	dec a ; $6331
	add a, $66 ; $6332
	ld l, a ; $6334
	adc a, $63 ; $6335
	sub a, l ; $6337
	ld h, a ; $6338
	ld b, [hl] ; $6339
	ld a, $02 ; $633a
	ld b, b ; $633c
	farcall FarPtr_0a_2e ; $633d
	ld a, $02 ; $6340
	ld bc, $0010 ; $6342
	farcall FarPtr_0a_18 ; $6345
Label_13_6348:
	ld a, $00 ; $6348
	ld bc, $0010 ; $634a
	farcall FarPtr_0a_18 ; $634d
	ld a, [$c295] ; $6350
	dec a ; $6353
	add a, $66 ; $6354
	ld l, a ; $6356
	adc a, $63 ; $6357
	sub a, l ; $6359
	ld h, a ; $635a
	ld b, [hl] ; $635b
	ld a, $00 ; $635c
	ld b, b ; $635e
	ld de, $0200 ; $635f
	farcall FarPtr_0a_2a ; $6362
Label_13_6365:
	ret ; $6365
	INCBIN "data/bank_013/d_6366.bin" ; $6366, 6 bytes
Label_13_636c:
	ldh a, [$ff95] ; $636c
	ld hl, $6638 ; $636e
	farcall FarPtr_0a_06 ; $6371
	farcall FarPtr_0a_00 ; $6374
	ld a, $00 ; $6377
	ld bc, $3f00 ; $6379
	ld de, $3f00 ; $637c
	farcall FarPtr_0a_22 ; $637f
	ld a, $06 ; $6382
	ld bc, $3f00 ; $6384
	ld de, $3f00 ; $6387
	farcall FarPtr_0a_22 ; $638a
	ld c, $04 ; $638d
	call Func_00_1d2e ; $638f
	call Func_00_1da4 ; $6392
	ld a, $06 ; $6395
	ld bc, $2200 ; $6397
	ld de, $3300 ; $639a
	farcall FarPtr_0a_22 ; $639d
	ld a, $06 ; $63a0
	ld bc, $2200 ; $63a2
	ld de, $1d00 ; $63a5
	farcall FarPtr_0a_24 ; $63a8
	push af ; $63ab
	ld a, $0f ; $63ac
	farcall FarPtr_0a_04 ; $63ae
	pop af ; $63b1
	xor a, a ; $63b2
	ld bc, $2200 ; $63b3
	ld de, $1d00 ; $63b6
	farcall FarPtr_0a_3a ; $63b9
	ld a, $00 ; $63bc
	ld bc, $2200 ; $63be
	ld de, $3300 ; $63c1
	farcall FarPtr_0a_22 ; $63c4
	ld a, $00 ; $63c7
	ld bc, $2200 ; $63c9
	ld de, $2100 ; $63cc
	farcall FarPtr_0a_24 ; $63cf
	ld a, $00 ; $63d2
	farcall FarPtr_0a_20 ; $63d4
	push af ; $63d7
	ld a, $0f ; $63d8
	farcall FarPtr_0a_04 ; $63da
	pop af ; $63dd
	ld a, $00 ; $63de
	ld bc, $2000 ; $63e0
	ld de, $1f00 ; $63e3
	farcall FarPtr_0a_24 ; $63e6
	ld a, $00 ; $63e9
	farcall FarPtr_0a_20 ; $63eb
	push af ; $63ee
	ld a, $1e ; $63ef
	farcall FarPtr_0a_04 ; $63f1
	pop af ; $63f4
	ld a, $06 ; $63f5
	ld b, $80 ; $63f7
	farcall FarPtr_0a_2e ; $63f9
	push af ; $63fc
	ld a, $1e ; $63fd
	farcall FarPtr_0a_04 ; $63ff
	pop af ; $6402
	ld a, $00 ; $6403
	ld b, $80 ; $6405
	farcall FarPtr_0a_2e ; $6407
	push af ; $640a
	ld a, $1e ; $640b
	farcall FarPtr_0a_04 ; $640d
	pop af ; $6410
	xor a, a ; $6411
	ld bc, $0c00 ; $6412
	ld de, $1b00 ; $6415
	farcall FarPtr_0a_3a ; $6418
	farcall FarPtr_0a_3e ; $641b
	push af ; $641e
	ld a, $1e ; $641f
	farcall FarPtr_0a_04 ; $6421
	pop af ; $6424
	ld hl, $0206 ; $6425
	farcall FarPtr_0a_0e ; $6428
	ld a, $06 ; $642b
	farcall FarPtr_0a_08 ; $642d
	push af ; $6430
	ld a, $0f ; $6431
	farcall FarPtr_0a_04 ; $6433
	pop af ; $6436
	ld bc, $0040 ; $6437
	farcall FarPtr_0a_38 ; $643a
	xor a, a ; $643d
	ld bc, $2200 ; $643e
	ld de, $1d00 ; $6441
	farcall FarPtr_0a_3a ; $6444
	farcall FarPtr_0a_3e ; $6447
	ld bc, $0020 ; $644a
	farcall FarPtr_0a_38 ; $644d
	ld a, $04 ; $6450
	ld bc, $2100 ; $6452
	ld de, $1d00 ; $6455
	farcall FarPtr_0a_22 ; $6458
	rst Rst08 ; $645b
	sbc a, b ; $645c
	push af ; $645d
	ld a, $32 ; $645e
	farcall FarPtr_0a_04 ; $6460
	pop af ; $6463
	ld a, $04 ; $6464
	ld bc, $3f00 ; $6466
	ld de, $3f00 ; $6469
	farcall FarPtr_0a_22 ; $646c
	ld a, $06 ; $646f
	ld d, $02 ; $6471
	farcall FarPtr_0a_34 ; $6473
	ld a, $06 ; $6476
	farcall FarPtr_0a_36 ; $6478
	ld a, $06 ; $647b
	farcall FarPtr_0a_08 ; $647d
	push af ; $6480
	ld a, $1e ; $6481
	farcall FarPtr_0a_04 ; $6483
	pop af ; $6486
	ld a, $06 ; $6487
	ld b, $40 ; $6489
	farcall FarPtr_0a_2e ; $648b
	push af ; $648e
	ld a, $0f ; $648f
	farcall FarPtr_0a_04 ; $6491
	pop af ; $6494
	ld a, $06 ; $6495
	farcall FarPtr_0a_08 ; $6497
	ld a, $06 ; $649a
	ld b, $80 ; $649c
	farcall FarPtr_0a_2e ; $649e
	push af ; $64a1
	ld a, $0f ; $64a2
	farcall FarPtr_0a_04 ; $64a4
	pop af ; $64a7
	ld bc, $0040 ; $64a8
	farcall FarPtr_0a_38 ; $64ab
	xor a, a ; $64ae
	ld bc, $0c00 ; $64af
	ld de, $1600 ; $64b2
	farcall FarPtr_0a_3a ; $64b5
	farcall FarPtr_0a_3e ; $64b8
	ld bc, $0020 ; $64bb
	farcall FarPtr_0a_38 ; $64be
	push af ; $64c1
	ld a, $3c ; $64c2
	farcall FarPtr_0a_04 ; $64c4
	pop af ; $64c7
	xor a, a ; $64c8
	ld bc, $0c00 ; $64c9
	ld de, $2200 ; $64cc
	farcall FarPtr_0a_3a ; $64cf
	farcall FarPtr_0a_3e ; $64d2
	push af ; $64d5
	ld a, $3c ; $64d6
	farcall FarPtr_0a_04 ; $64d8
	pop af ; $64db
	xor a, a ; $64dc
	ld bc, $0c00 ; $64dd
	ld de, $1b00 ; $64e0
	farcall FarPtr_0a_3a ; $64e3
	farcall FarPtr_0a_3e ; $64e6
	ld a, $06 ; $64e9
	farcall FarPtr_0a_08 ; $64eb
	push af ; $64ee
	ld a, $0f ; $64ef
	farcall FarPtr_0a_04 ; $64f1
	pop af ; $64f4
	ld bc, $0040 ; $64f5
	farcall FarPtr_0a_38 ; $64f8
	xor a, a ; $64fb
	ld bc, $2200 ; $64fc
	ld de, $1d00 ; $64ff
	farcall FarPtr_0a_3a ; $6502
	farcall FarPtr_0a_3e ; $6505
	ld bc, $0020 ; $6508
	farcall FarPtr_0a_38 ; $650b
	push af ; $650e
	ld a, $1e ; $650f
	farcall FarPtr_0a_04 ; $6511
	pop af ; $6514
	ld a, $06 ; $6515
	ld b, $00 ; $6517
	farcall FarPtr_0a_2e ; $6519
	push af ; $651c
	ld a, $0f ; $651d
	farcall FarPtr_0a_04 ; $651f
	pop af ; $6522
	ld a, $00 ; $6523
	ld b, $00 ; $6525
	farcall FarPtr_0a_2e ; $6527
	xor a, a ; $652a
	ld bc, $3000 ; $652b
	ld de, $2600 ; $652e
	farcall FarPtr_0a_3a ; $6531
	farcall FarPtr_0a_3e ; $6534
	ld a, $06 ; $6537
	farcall FarPtr_0a_08 ; $6539
	push af ; $653c
	ld a, $0f ; $653d
	farcall FarPtr_0a_04 ; $653f
	pop af ; $6542
	xor a, a ; $6543
	ld bc, $3600 ; $6544
	ld de, $1000 ; $6547
	farcall FarPtr_0a_3a ; $654a
	farcall FarPtr_0a_3e ; $654d
	ld a, $06 ; $6550
	farcall FarPtr_0a_08 ; $6552
	push af ; $6555
	ld a, $0f ; $6556
	farcall FarPtr_0a_04 ; $6558
	pop af ; $655b
	ld bc, $0040 ; $655c
	farcall FarPtr_0a_38 ; $655f
	xor a, a ; $6562
	ld bc, $2200 ; $6563
	ld de, $1d00 ; $6566
	farcall FarPtr_0a_3a ; $6569
	farcall FarPtr_0a_3e ; $656c
	ld bc, $0020 ; $656f
	farcall FarPtr_0a_38 ; $6572
	push af ; $6575
	ld a, $0f ; $6576
	farcall FarPtr_0a_04 ; $6578
	pop af ; $657b
	ld a, $06 ; $657c
	ld b, $40 ; $657e
	farcall FarPtr_0a_2e ; $6580
	ld a, $06 ; $6583
	farcall FarPtr_0a_08 ; $6585
	push af ; $6588
	ld a, $1e ; $6589
	farcall FarPtr_0a_04 ; $658b
	pop af ; $658e
	ld a, $00 ; $658f
	ld b, $c0 ; $6591
	farcall FarPtr_0a_2e ; $6593
	ld a, $00 ; $6596
	ld d, $03 ; $6598
	farcall FarPtr_0a_34 ; $659a
	ld a, $00 ; $659d
	farcall FarPtr_0a_36 ; $659f
	push af ; $65a2
	ld a, $0f ; $65a3
	farcall FarPtr_0a_04 ; $65a5
	pop af ; $65a8
	ld a, $06 ; $65a9
	ld d, $02 ; $65ab
	farcall FarPtr_0a_34 ; $65ad
	ld a, $06 ; $65b0
	farcall FarPtr_0a_36 ; $65b2
	ld a, $06 ; $65b5
	farcall FarPtr_0a_08 ; $65b7
	ld a, $00 ; $65ba
	ld d, $02 ; $65bc
	farcall FarPtr_0a_34 ; $65be
	ld a, $00 ; $65c1
	farcall FarPtr_0a_36 ; $65c3
	push af ; $65c6
	ld a, $1e ; $65c7
	farcall FarPtr_0a_04 ; $65c9
	pop af ; $65cc
	ld a, $06 ; $65cd
	ld d, $03 ; $65cf
	farcall FarPtr_0a_34 ; $65d1
	ld a, $06 ; $65d4
	farcall FarPtr_0a_36 ; $65d6
	ld a, $06 ; $65d9
	farcall FarPtr_0a_08 ; $65db
	ld a, $00 ; $65de
	ld bc, $2200 ; $65e0
	ld de, $1f00 ; $65e3
	farcall FarPtr_0a_24 ; $65e6
	ld a, $00 ; $65e9
	farcall FarPtr_0a_20 ; $65eb
	ld a, $00 ; $65ee
	ld b, $c0 ; $65f0
	farcall FarPtr_0a_2e ; $65f2
	push af ; $65f5
	ld a, $0f ; $65f6
	farcall FarPtr_0a_04 ; $65f8
	pop af ; $65fb
	ld a, $06 ; $65fc
	ld bc, $2200 ; $65fe
	ld de, $0700 ; $6601
	farcall FarPtr_0a_24 ; $6604
	push af ; $6607
	ld a, $05 ; $6608
	farcall FarPtr_0a_04 ; $660a
	pop af ; $660d
	ld a, $00 ; $660e
	ld bc, $2200 ; $6610
	ld de, $0700 ; $6613
	farcall FarPtr_0a_24 ; $6616
	push af ; $6619
	ld a, $0a ; $661a
	farcall FarPtr_0a_04 ; $661c
	pop af ; $661f
	xor a, a ; $6620
	ld bc, $2200 ; $6621
	ld de, $0d00 ; $6624
	farcall FarPtr_0a_3a ; $6627
	ld a, $00 ; $662a
	farcall FarPtr_0a_20 ; $662c
	ld a, $0f ; $662f
	ld [$c294], a ; $6631
	ld [$c2a1], a ; $6634
	ret ; $6637
	INCBIN "data/bank_013/d_6638.bin" ; $6638, 2346 bytes
	farcall FarPtr_0a_20 ; $6f62
	ld a, $04 ; $6f65
	ld b, $c0 ; $6f67
	farcall FarPtr_0a_2e ; $6f69
	ld a, $09 ; $6f6c
	ld b, $c0 ; $6f6e
	farcall FarPtr_0a_2e ; $6f70
	ld a, $00 ; $6f73
	ld b, $c0 ; $6f75
	farcall FarPtr_0a_2e ; $6f77
	ld a, $02 ; $6f7a
	ld b, $c0 ; $6f7c
	farcall FarPtr_0a_2e ; $6f7e
	push af ; $6f81
	ld a, $0f ; $6f82
	farcall FarPtr_0a_04 ; $6f84
	pop af ; $6f87
	ld a, $03 ; $6f88
	ld d, $02 ; $6f8a
	farcall FarPtr_0a_34 ; $6f8c
	ld a, $03 ; $6f8f
	farcall FarPtr_0a_36 ; $6f91
	ld a, $03 ; $6f94
	farcall FarPtr_0a_0a ; $6f96
	farcall FarPtr_0a_12 ; $6f99
	farcall FarPtr_0a_0c ; $6f9c
	push af ; $6f9f
	ld a, $05 ; $6fa0
	farcall FarPtr_0a_04 ; $6fa2
	pop af ; $6fa5
	and a, a ; $6fa6
	jp nz, Label_13_7090 ; $6fa7
	ld a, $03 ; $6faa
	ld d, $03 ; $6fac
	farcall FarPtr_0a_34 ; $6fae
	ld a, $03 ; $6fb1
	farcall FarPtr_0a_36 ; $6fb3
Label_13_6fb6:
	ld hl, $0410 ; $6fb6
	farcall FarPtr_0a_0e ; $6fb9
	ld a, $03 ; $6fbc
	ld d, $03 ; $6fbe
	farcall FarPtr_0a_34 ; $6fc0
	ld a, $03 ; $6fc3
	farcall FarPtr_0a_36 ; $6fc5
	ld a, $03 ; $6fc8
	farcall FarPtr_0a_08 ; $6fca
	ld a, $07 ; $6fcd
	ld [wStoryModeCurrentLocation], a ; $6fcf
	ld a, $0d ; $6fd2
	ld [$c295], a ; $6fd4
	ld a, $ff ; $6fd7
	ld [$c294], a ; $6fd9
	ld [$c2a1], a ; $6fdc
	ld a, $00 ; $6fdf
	ld bc, $0020 ; $6fe1
	farcall FarPtr_0a_18 ; $6fe4
	ld a, $02 ; $6fe7
	ld bc, $0020 ; $6fe9
	farcall FarPtr_0a_18 ; $6fec
	ldh a, [$ff95] ; $6fef
	ld b, a ; $6ff1
	ld a, $04 ; $6ff2
	ld de, $6bae ; $6ff4
	farcall FarPtr_0a_1a ; $6ff7
	ldh a, [$ff95] ; $6ffa
	ld b, a ; $6ffc
	ld a, $09 ; $6ffd
	ld de, $6bc5 ; $6fff
	farcall FarPtr_0a_1a ; $7002
	ldh a, [$ff95] ; $7005
	ld b, a ; $7007
	ld a, $00 ; $7008
	ld de, $6be7 ; $700a
	farcall FarPtr_0a_1a ; $700d
	ldh a, [$ff95] ; $7010
	ld b, a ; $7012
	ld a, $02 ; $7013
	ld de, $6bdc ; $7015
	farcall FarPtr_0a_1a ; $7018
	ld a, $07 ; $701b
	farcall FarPtr_0a_1c ; $701d
	ld a, $07 ; $7020
	ld bc, $0018 ; $7022
	farcall FarPtr_0a_18 ; $7025
	ldh a, [$ff95] ; $7028
	ld b, a ; $702a
	ld a, $03 ; $702b
	ld de, $6b19 ; $702d
	farcall FarPtr_0a_1a ; $7030
	ldh a, [$ff95] ; $7033
	ld b, a ; $7035
	ld a, $05 ; $7036
	ld de, $6b24 ; $7038
	farcall FarPtr_0a_1a ; $703b
	ldh a, [$ff95] ; $703e
	ld b, a ; $7040
	ld a, $06 ; $7041
	ld de, $6b3c ; $7043
	farcall FarPtr_0a_1a ; $7046
	ldh a, [$ff95] ; $7049
	ld b, a ; $704b
	ld a, $07 ; $704c
	ld de, $6b58 ; $704e
	farcall FarPtr_0a_1a ; $7051
	xor a, a ; $7054
	ld bc, $0c00 ; $7055
	ld de, $1b00 ; $7058
	farcall FarPtr_0a_3a ; $705b
	farcall FarPtr_0a_3e ; $705e
	ld a, $04 ; $7061
	farcall FarPtr_0a_1e ; $7063
	farcall FarPtr_0a_4a ; $7066
	ld a, $01 ; $7069
	ld [wCurrentMinigameStoryMatch], a ; $706b
	ld a, $0d ; $706e
	ld [$c8f7], a ; $7070
	farcall FarPtr_0a_5a ; $7073
	farcall FarPtr_0a_4c ; $7076
	farcall FarPtr_0a_4e ; $7079
	ret ; $707c
	INCBIN "data/bank_013/d_707d.bin" ; $707d, 19 bytes
Label_13_7090:
	farcall FarPtr_0a_10 ; $7090
	ld a, $03 ; $7093
	farcall FarPtr_0a_0a ; $7095
	farcall FarPtr_0a_12 ; $7098
	farcall FarPtr_0a_0c ; $709b
	push af ; $709e
	ld a, $05 ; $709f
	farcall FarPtr_0a_04 ; $70a1
	pop af ; $70a4
	and a, a ; $70a5
	jr z, Label_13_70ac ; $70a6
	jp Label_13_6fb6 ; $70a8
	INCBIN "data/bank_013/d_70ab.bin" ; $70ab, 1 bytes
Label_13_70ac:
	ld a, $03 ; $70ac
	farcall FarPtr_0a_08 ; $70ae
	call Func_13_70d5 ; $70b1
	push af ; $70b4
	ld a, $3c ; $70b5
	farcall FarPtr_0a_04 ; $70b7
	pop af ; $70ba
	ld a, $02 ; $70bb
	farcall FarPtr_0a_16 ; $70bd
	ld c, l ; $70c0
	ld b, h ; $70c1
	ld de, $d000 ; $70c2
	farcall FarPtr_04_20 ; $70c5
	ret ; $70c8
	INCBIN "data/bank_013/d_70c9.bin" ; $70c9, 12 bytes
Func_13_70d5:
	ldh a, [$ff95] ; $70d5
	ld b, a ; $70d7
	ld a, $04 ; $70d8
	ld de, $6bfd ; $70da
	farcall FarPtr_0a_1a ; $70dd
	ldh a, [$ff95] ; $70e0
	ld b, a ; $70e2
	ld a, $09 ; $70e3
	ld de, $6c08 ; $70e5
	farcall FarPtr_0a_1a ; $70e8
	ret ; $70eb
	INCBIN "data/bank_013/d_70ec.bin" ; $70ec, 15 bytes
Func_13_70fb:
	ld a, $06 ; $70fb
	ldh [$ff96], a ; $70fd
	ldh [rWBK], a ; $70ff
	ldh a, [$ff95] ; $7101
	ld hl, $739c ; $7103
	farcall FarPtr_0a_06 ; $7106
	ld a, $01 ; $7109
	farcall FarPtr_0a_1c ; $710b
	ld bc, $0040 ; $710e
	farcall FarPtr_0a_38 ; $7111
	call Func_13_62be ; $7114
	ld a, $00 ; $7117
	ld bc, $0b00 ; $7119
	ld de, $1d00 ; $711c
	farcall FarPtr_0a_22 ; $711f
	ld a, $02 ; $7122
	ld bc, $0d00 ; $7124
	ld de, $2300 ; $7127
	farcall FarPtr_0a_22 ; $712a
	ld a, $00 ; $712d
	ld b, $c0 ; $712f
	farcall FarPtr_0a_2e ; $7131
	ld a, $02 ; $7134
	ld b, $c0 ; $7136
	farcall FarPtr_0a_2e ; $7138
	xor a, a ; $713b
	ld bc, $0b00 ; $713c
	ld de, $1100 ; $713f
	farcall FarPtr_0a_3a ; $7142
	farcall FarPtr_0a_3e ; $7145
	ld c, $04 ; $7148
	call Func_00_1d2e ; $714a
	call Func_00_1da4 ; $714d
	push af ; $7150
	ld a, $3c ; $7151
	farcall FarPtr_0a_04 ; $7153
	pop af ; $7156
	ld hl, $022a ; $7157
	farcall FarPtr_0a_0e ; $715a
	ld bc, $0020 ; $715d
	farcall FarPtr_0a_38 ; $7160
	xor a, a ; $7163
	ld bc, $0b00 ; $7164
	ld de, $1700 ; $7167
	farcall FarPtr_0a_3a ; $716a
	farcall FarPtr_0a_3e ; $716d
	ld a, $04 ; $7170
	ld bc, $0b00 ; $7172
	ld de, $1700 ; $7175
	farcall FarPtr_0a_24 ; $7178
	ld a, $04 ; $717b
	farcall FarPtr_0a_20 ; $717d
	ld a, $04 ; $7180
	farcall FarPtr_0a_08 ; $7182
	ld a, $00 ; $7185
	ld d, $03 ; $7187
	farcall FarPtr_0a_34 ; $7189
	ld a, $00 ; $718c
	farcall FarPtr_0a_36 ; $718e
	ld a, $0d ; $7191
	farcall FarPtr_0a_08 ; $7193
	ld a, $0c ; $7196
	ld bc, $0c40 ; $7198
	ld de, $1bc0 ; $719b
	farcall FarPtr_0a_22 ; $719e
	rst Rst08 ; $71a1
	sbc a, b ; $71a2
	push af ; $71a3
	ld a, $28 ; $71a4
	farcall FarPtr_0a_04 ; $71a6
	pop af ; $71a9
	ld a, $0c ; $71aa
	ld bc, $3f00 ; $71ac
	ld de, $3f00 ; $71af
	farcall FarPtr_0a_22 ; $71b2
	ld a, $00 ; $71b5
	ld b, $00 ; $71b7
	farcall FarPtr_0a_2e ; $71b9
	ld a, $0d ; $71bc
	ld b, $00 ; $71be
	farcall FarPtr_0a_3c ; $71c0
	farcall FarPtr_0a_3e ; $71c3
	push af ; $71c6
	ld a, $28 ; $71c7
	farcall FarPtr_0a_04 ; $71c9
	pop af ; $71cc
	ld a, $00 ; $71cd
	ld b, $00 ; $71cf
	farcall FarPtr_0a_3c ; $71d1
	ldh a, [$ff95] ; $71d4
	ld b, a ; $71d6
	ld a, $08 ; $71d7
	ld de, $7a43 ; $71d9
	farcall FarPtr_0a_1a ; $71dc
	ldh a, [$ff95] ; $71df
	ld b, a ; $71e1
	ld a, $09 ; $71e2
	ld de, $7aa7 ; $71e4
	farcall FarPtr_0a_1a ; $71e7
	ldh a, [$ff95] ; $71ea
	ld b, a ; $71ec
	ld a, $0d ; $71ed
	ld de, $7aa0 ; $71ef
	farcall FarPtr_0a_1a ; $71f2
	push af ; $71f5
	ld a, $0a ; $71f6
	farcall FarPtr_0a_04 ; $71f8
	pop af ; $71fb
	ldh a, [$ff95] ; $71fc
	ld b, a ; $71fe
	ld a, $03 ; $71ff
	ld de, $7a7d ; $7201
	farcall FarPtr_0a_1a ; $7204
	farcall FarPtr_0a_3e ; $7207
	ld a, $03 ; $720a
	farcall FarPtr_0a_1e ; $720c
	ld a, $00 ; $720f
	ld b, a ; $7211
	ld a, $0d ; $7212
	farcall FarPtr_0a_30 ; $7214
	rst Rst30 ; $7217
	nop ; $7218
	inc e ; $7219
	jr z, Label_13_724d ; $721a
	farcall FarPtr_0a_10 ; $721c
	ld a, $0d ; $721f
	ld d, $02 ; $7221
	farcall FarPtr_0a_34 ; $7223
	ld a, $0d ; $7226
	farcall FarPtr_0a_36 ; $7228
	ld a, $0d ; $722b
	farcall FarPtr_0a_08 ; $722d
	ld a, $0d ; $7230
	ld b, a ; $7232
	ld a, $00 ; $7233
	farcall FarPtr_0a_30 ; $7235
	ld a, $0d ; $7238
	ld d, $03 ; $723a
	farcall FarPtr_0a_34 ; $723c
	ld a, $00 ; $723f
	ld d, $03 ; $7241
	farcall FarPtr_0a_34 ; $7243
	ld a, $00 ; $7246
	farcall FarPtr_0a_36 ; $7248
	jr Label_13_727c ; $724b
Label_13_724d:
	ld a, $0d ; $724d
	ld d, $02 ; $724f
	farcall FarPtr_0a_34 ; $7251
	ld a, $0d ; $7254
	farcall FarPtr_0a_36 ; $7256
	ld a, $0d ; $7259
	farcall FarPtr_0a_08 ; $725b
	ld a, $0d ; $725e
	ld b, a ; $7260
	ld a, $00 ; $7261
	farcall FarPtr_0a_30 ; $7263
	ld a, $0d ; $7266
	ld d, $03 ; $7268
	farcall FarPtr_0a_34 ; $726a
	ld a, $00 ; $726d
	ld d, $03 ; $726f
	farcall FarPtr_0a_34 ; $7271
	ld a, $00 ; $7274
	farcall FarPtr_0a_36 ; $7276
	farcall FarPtr_0a_10 ; $7279
Label_13_727c:
	ld a, $09 ; $727c
	ld b, $40 ; $727e
	farcall FarPtr_0a_2e ; $7280
	ld a, $09 ; $7283
	ld d, $04 ; $7285
	farcall FarPtr_0a_34 ; $7287
	ld a, $09 ; $728a
	farcall FarPtr_0a_36 ; $728c
	ld a, $09 ; $728f
	ld b, $00 ; $7291
	farcall FarPtr_0a_2e ; $7293
	ld a, $09 ; $7296
	ld b, a ; $7298
	ld a, $00 ; $7299
	farcall FarPtr_0a_30 ; $729b
	ld a, $09 ; $729e
	farcall FarPtr_0a_08 ; $72a0
	ld a, $00 ; $72a3
	ld d, $02 ; $72a5
	farcall FarPtr_0a_34 ; $72a7
	ld a, $00 ; $72aa
	farcall FarPtr_0a_36 ; $72ac
	push af ; $72af
	ld a, $14 ; $72b0
	farcall FarPtr_0a_04 ; $72b2
	pop af ; $72b5
	ld a, $08 ; $72b6
	ld bc, $0a00 ; $72b8
	ld de, $1f00 ; $72bb
	farcall FarPtr_0a_24 ; $72be
	ld a, $08 ; $72c1
	farcall FarPtr_0a_20 ; $72c3
	push af ; $72c6
	ld a, $14 ; $72c7
	farcall FarPtr_0a_04 ; $72c9
	pop af ; $72cc
	ld a, $08 ; $72cd
	ld b, a ; $72cf
	ld a, $00 ; $72d0
	farcall FarPtr_0a_30 ; $72d2
	ld a, $08 ; $72d5
	ld b, a ; $72d7
	ld a, $0d ; $72d8
	farcall FarPtr_0a_30 ; $72da
	push af ; $72dd
	ld a, $14 ; $72de
	farcall FarPtr_0a_04 ; $72e0
	pop af ; $72e3
	ld a, $08 ; $72e4
	ld d, $03 ; $72e6
	farcall FarPtr_0a_34 ; $72e8
	ld a, $08 ; $72eb
	farcall FarPtr_0a_36 ; $72ed
	ld a, $08 ; $72f0
	farcall FarPtr_0a_08 ; $72f2
	push af ; $72f5
	ld a, $14 ; $72f6
	farcall FarPtr_0a_04 ; $72f8
	pop af ; $72fb
	ld a, $03 ; $72fc
	ld bc, $0c00 ; $72fe
	ld de, $1f00 ; $7301
	farcall FarPtr_0a_24 ; $7304
	ld a, $03 ; $7307
	farcall FarPtr_0a_20 ; $7309
	push af ; $730c
	ld a, $14 ; $730d
	farcall FarPtr_0a_04 ; $730f
	pop af ; $7312
	ld a, $03 ; $7313
	ld d, $02 ; $7315
	farcall FarPtr_0a_34 ; $7317
	ld a, $03 ; $731a
	farcall FarPtr_0a_36 ; $731c
	ld a, $03 ; $731f
	farcall FarPtr_0a_08 ; $7321
	ld a, $0d ; $7324
	ld d, $02 ; $7326
	farcall FarPtr_0a_34 ; $7328
	ld a, $0d ; $732b
	farcall FarPtr_0a_36 ; $732d
	ld a, $00 ; $7330
	ld b, a ; $7332
	ld a, $0d ; $7333
	farcall FarPtr_0a_30 ; $7335
	rst Rst30 ; $7338
	nop ; $7339
	inc e ; $733a
	jr z, Label_13_7340 ; $733b
	farcall FarPtr_0a_10 ; $733d
Label_13_7340:
	ld a, $0d ; $7340
	farcall FarPtr_0a_08 ; $7342
	ld a, $0d ; $7345
	ld b, a ; $7347
	ld a, $00 ; $7348
	farcall FarPtr_0a_30 ; $734a
	ld a, $00 ; $734d
	ld d, $03 ; $734f
	farcall FarPtr_0a_34 ; $7351
	ld a, $00 ; $7354
	farcall FarPtr_0a_36 ; $7356
	push af ; $7359
	ld a, $0a ; $735a
	farcall FarPtr_0a_04 ; $735c
	pop af ; $735f
	ld a, $08 ; $7360
	ld b, a ; $7362
	ld a, $00 ; $7363
	farcall FarPtr_0a_30 ; $7365
	push af ; $7368
	ld a, $0a ; $7369
	farcall FarPtr_0a_04 ; $736b
	pop af ; $736e
	ld a, $00 ; $736f
	ld d, $03 ; $7371
	farcall FarPtr_0a_34 ; $7373
	ld c, $02 ; $7376
	call Func_00_1d20 ; $7378
	call Func_00_1da4 ; $737b
	ld b, $00 ; $737e
	ld a, [$c90d] ; $7380
	add a, $04 ; $7383
	ld c, a ; $7385
	farcall FarPtr_18_8e ; $7386
	ld a, $00 ; $7389
	ld [wStoryModeCurrentLocation], a ; $738b
	ld a, $0a ; $738e
	ld [$c295], a ; $7390
	ld a, $ff ; $7393
	ld [$c294], a ; $7395
	ld [$c2a1], a ; $7398
	ret ; $739b
	INCBIN "data/bank_013/d_739c.bin" ; $739c, 179 bytes
Func_13_744f:
	ld hl, $0416 ; $744f
	farcall FarPtr_0a_0e ; $7452
	ldh a, [$ff95] ; $7455
	ld hl, $78d7 ; $7457
	farcall FarPtr_0a_06 ; $745a
	farcall FarPtr_0a_00 ; $745d
	call Func_13_62be ; $7460
	ld a, $02 ; $7463
	farcall FarPtr_0a_1c ; $7465
	ld a, $01 ; $7468
	farcall FarPtr_0a_1c ; $746a
	ld bc, $0040 ; $746d
	farcall FarPtr_0a_38 ; $7470
	ld a, $00 ; $7473
	ld bc, $0b00 ; $7475
	ld de, $1d00 ; $7478
	farcall FarPtr_0a_22 ; $747b
	ld a, $02 ; $747e
	ld bc, $0d00 ; $7480
	ld de, $2300 ; $7483
	farcall FarPtr_0a_22 ; $7486
	ld a, $00 ; $7489
	ld b, $c0 ; $748b
	farcall FarPtr_0a_2e ; $748d
	ld a, $02 ; $7490
	ld b, $c0 ; $7492
	farcall FarPtr_0a_2e ; $7494
	xor a, a ; $7497
	ld bc, $0b00 ; $7498
	ld de, $1100 ; $749b
	farcall FarPtr_0a_3a ; $749e
	farcall FarPtr_0a_3e ; $74a1
	ld c, $04 ; $74a4
	call Func_00_1d2e ; $74a6
	call Func_00_1da4 ; $74a9
	push af ; $74ac
	ld a, $3c ; $74ad
	farcall FarPtr_0a_04 ; $74af
	pop af ; $74b2
	ld bc, $0020 ; $74b3
	farcall FarPtr_0a_38 ; $74b6
	xor a, a ; $74b9
	ld bc, $0b00 ; $74ba
	ld de, $1700 ; $74bd
	farcall FarPtr_0a_3a ; $74c0
	farcall FarPtr_0a_3e ; $74c3
	ld a, $02 ; $74c6
	ld bc, $0d00 ; $74c8
	ld de, $1d00 ; $74cb
	farcall FarPtr_0a_24 ; $74ce
	ld a, $09 ; $74d1
	ld bc, $0b00 ; $74d3
	ld de, $1700 ; $74d6
	farcall FarPtr_0a_24 ; $74d9
	ld a, $09 ; $74dc
	farcall FarPtr_0a_20 ; $74de
	ld a, $09 ; $74e1
	ld d, $04 ; $74e3
	farcall FarPtr_0a_34 ; $74e5
	ld a, $09 ; $74e8
	farcall FarPtr_0a_36 ; $74ea
	ld a, $09 ; $74ed
	farcall FarPtr_0a_08 ; $74ef
	ld a, $04 ; $74f2
	ld d, $02 ; $74f4
	farcall FarPtr_0a_34 ; $74f6
	ld a, $04 ; $74f9
	farcall FarPtr_0a_36 ; $74fb
	ld a, $04 ; $74fe
	farcall FarPtr_0a_08 ; $7500
	ld a, $02 ; $7503
	ld d, $03 ; $7505
	farcall FarPtr_0a_34 ; $7507
	ld a, $00 ; $750a
	ld d, $03 ; $750c
	farcall FarPtr_0a_34 ; $750e
	ld a, $00 ; $7511
	farcall FarPtr_0a_36 ; $7513
	ld a, $00 ; $7516
	ld b, a ; $7518
	ld a, $02 ; $7519
	farcall FarPtr_0a_30 ; $751b
	push af ; $751e
	ld a, $1e ; $751f
	farcall FarPtr_0a_04 ; $7521
	pop af ; $7524
	ld a, $02 ; $7525
	ld d, $03 ; $7527
	farcall FarPtr_0a_34 ; $7529
	ld a, $02 ; $752c
	farcall FarPtr_0a_36 ; $752e
	rst Rst30 ; $7531
	nop ; $7532
	inc e ; $7533
	jp z, Label_13_7672 ; $7534
	ld hl, $041a ; $7537
	farcall FarPtr_0a_0e ; $753a
	ld a, $02 ; $753d
	farcall FarPtr_0a_08 ; $753f
	ld a, $02 ; $7542
	ld b, a ; $7544
	ld a, $00 ; $7545
	farcall FarPtr_0a_30 ; $7547
	ld a, $02 ; $754a
	ld d, $02 ; $754c
	farcall FarPtr_0a_34 ; $754e
	ld a, $02 ; $7551
	farcall FarPtr_0a_36 ; $7553
	ld a, $02 ; $7556
	farcall FarPtr_0a_08 ; $7558
	ld a, $00 ; $755b
	ld b, $80 ; $755d
	farcall FarPtr_0a_2e ; $755f
	ld a, $00 ; $7562
	ld d, $02 ; $7564
	farcall FarPtr_0a_34 ; $7566
	ld a, $0a ; $7569
	ld bc, $0c00 ; $756b
	ld de, $1b80 ; $756e
	farcall FarPtr_0a_22 ; $7571
	rst Rst08 ; $7574
	sub a, [hl] ; $7575
	push af ; $7576
	ld a, $28 ; $7577
	farcall FarPtr_0a_04 ; $7579
	pop af ; $757c
	ld a, $0a ; $757d
	ld bc, $3f00 ; $757f
	ld de, $3f00 ; $7582
	farcall FarPtr_0a_22 ; $7585
	ld a, $02 ; $7588
	ld b, a ; $758a
	ld a, $00 ; $758b
	farcall FarPtr_0a_30 ; $758d
	push af ; $7590
	ld a, $0a ; $7591
	farcall FarPtr_0a_04 ; $7593
	pop af ; $7596
	ld a, $00 ; $7597
	ld b, $01 ; $7599
	farcall FarPtr_0a_2c ; $759b
	push af ; $759e
	ld a, $0a ; $759f
	farcall FarPtr_0a_04 ; $75a1
	pop af ; $75a4
	ld a, $00 ; $75a5
	ld b, $00 ; $75a7
	ld de, $0100 ; $75a9
	farcall FarPtr_0a_2a ; $75ac
	ld a, $00 ; $75af
	farcall FarPtr_0a_20 ; $75b1
	ld a, $00 ; $75b4
	ld d, $02 ; $75b6
	farcall FarPtr_0a_34 ; $75b8
	ld a, $00 ; $75bb
	farcall FarPtr_0a_36 ; $75bd
	ld a, $00 ; $75c0
	ld b, $80 ; $75c2
	ld de, $0100 ; $75c4
	farcall FarPtr_0a_2a ; $75c7
	ld a, $00 ; $75ca
	farcall FarPtr_0a_20 ; $75cc
	ld a, $02 ; $75cf
	farcall FarPtr_0a_16 ; $75d1
	ld de, $0018 ; $75d4
	add hl, de ; $75d7
	ld [hl], $04 ; $75d8
	ld a, $02 ; $75da
	ld d, $02 ; $75dc
	farcall FarPtr_0a_34 ; $75de
	ld a, $02 ; $75e1
	farcall FarPtr_0a_36 ; $75e3
	ld a, $02 ; $75e6
	ld b, $c0 ; $75e8
	farcall FarPtr_0a_2e ; $75ea
	ld a, $02 ; $75ed
	ld d, $02 ; $75ef
	farcall FarPtr_0a_34 ; $75f1
	ld a, $02 ; $75f4
	farcall FarPtr_0a_36 ; $75f6
	ld a, $02 ; $75f9
	ld d, $02 ; $75fb
	farcall FarPtr_0a_34 ; $75fd
	ld a, $02 ; $7600
	farcall FarPtr_0a_36 ; $7602
	ld a, $02 ; $7605
	ld b, $40 ; $7607
	farcall FarPtr_0a_2e ; $7609
	ld a, $02 ; $760c
	ld d, $02 ; $760e
	farcall FarPtr_0a_34 ; $7610
	ld a, $02 ; $7613
	farcall FarPtr_0a_36 ; $7615
	ld a, $02 ; $7618
	ld b, $c0 ; $761a
	farcall FarPtr_0a_2e ; $761c
	ld a, $02 ; $761f
	ld d, $02 ; $7621
	farcall FarPtr_0a_34 ; $7623
	ld a, $02 ; $7626
	farcall FarPtr_0a_36 ; $7628
	ld a, $02 ; $762b
	ld d, $02 ; $762d
	farcall FarPtr_0a_34 ; $762f
	ld a, $02 ; $7632
	farcall FarPtr_0a_36 ; $7634
	ld a, $02 ; $7637
	farcall FarPtr_0a_16 ; $7639
	ld de, $0018 ; $763c
	add hl, de ; $763f
	ld [hl], $01 ; $7640
	ld a, $02 ; $7642
	ld b, $80 ; $7644
	farcall FarPtr_0a_2e ; $7646
	push af ; $7649
	ld a, $14 ; $764a
	farcall FarPtr_0a_04 ; $764c
	pop af ; $764f
	ld a, $02 ; $7650
	ld d, $03 ; $7652
	farcall FarPtr_0a_34 ; $7654
	ld a, $02 ; $7657
	farcall FarPtr_0a_36 ; $7659
	push af ; $765c
	ld a, $14 ; $765d
	farcall FarPtr_0a_04 ; $765f
	pop af ; $7662
	ld a, $00 ; $7663
	ld d, $03 ; $7665
	farcall FarPtr_0a_34 ; $7667
	ld a, $00 ; $766a
	farcall FarPtr_0a_36 ; $766c
	jp Label_13_7769 ; $766f
Label_13_7672:
	ld hl, $0418 ; $7672
	farcall FarPtr_0a_0e ; $7675
	ld a, $02 ; $7678
	farcall FarPtr_0a_08 ; $767a
	ld a, $02 ; $767d
	ld d, $02 ; $767f
	farcall FarPtr_0a_34 ; $7681
	ld a, $02 ; $7684
	farcall FarPtr_0a_36 ; $7686
	ld a, $02 ; $7689
	farcall FarPtr_0a_08 ; $768b
	ld a, $02 ; $768e
	ld b, a ; $7690
	ld a, $00 ; $7691
	farcall FarPtr_0a_30 ; $7693
	ld a, $0a ; $7696
	ld bc, $0c00 ; $7698
	ld de, $1b80 ; $769b
	farcall FarPtr_0a_22 ; $769e
	rst Rst08 ; $76a1
	sub a, [hl] ; $76a2
	push af ; $76a3
	ld a, $28 ; $76a4
	farcall FarPtr_0a_04 ; $76a6
	pop af ; $76a9
	ld a, $0a ; $76aa
	ld bc, $3f00 ; $76ac
	ld de, $3f00 ; $76af
	farcall FarPtr_0a_22 ; $76b2
	push af ; $76b5
	ld a, $0a ; $76b6
	farcall FarPtr_0a_04 ; $76b8
	pop af ; $76bb
	ld a, $00 ; $76bc
	ld b, $01 ; $76be
	farcall FarPtr_0a_2c ; $76c0
	push af ; $76c3
	ld a, $0a ; $76c4
	farcall FarPtr_0a_04 ; $76c6
	pop af ; $76c9
	ld a, $00 ; $76ca
	ld b, $00 ; $76cc
	ld de, $0100 ; $76ce
	farcall FarPtr_0a_2a ; $76d1
	ld a, $00 ; $76d4
	farcall FarPtr_0a_20 ; $76d6
	ld a, $00 ; $76d9
	ld d, $02 ; $76db
	farcall FarPtr_0a_34 ; $76dd
	ld a, $00 ; $76e0
	farcall FarPtr_0a_36 ; $76e2
	ld a, $00 ; $76e5
	ld b, $80 ; $76e7
	ld de, $0100 ; $76e9
	farcall FarPtr_0a_2a ; $76ec
	ld a, $00 ; $76ef
	farcall FarPtr_0a_20 ; $76f1
	ld a, $02 ; $76f4
	farcall FarPtr_0a_16 ; $76f6
	ld de, $0018 ; $76f9
	add hl, de ; $76fc
	ld [hl], $03 ; $76fd
	ld a, $02 ; $76ff
	ld d, $02 ; $7701
	farcall FarPtr_0a_34 ; $7703
	ld a, $02 ; $7706
	farcall FarPtr_0a_36 ; $7708
	ld a, $02 ; $770b
	ld b, $40 ; $770d
	farcall FarPtr_0a_2e ; $770f
	ld a, $02 ; $7712
	ld d, $02 ; $7714
	farcall FarPtr_0a_34 ; $7716
	ld a, $02 ; $7719
	farcall FarPtr_0a_36 ; $771b
	push af ; $771e
	ld a, $28 ; $771f
	farcall FarPtr_0a_04 ; $7721
	pop af ; $7724
	ld a, $02 ; $7725
	ld d, $02 ; $7727
	farcall FarPtr_0a_34 ; $7729
	ld a, $02 ; $772c
	farcall FarPtr_0a_36 ; $772e
	ld a, $02 ; $7731
	farcall FarPtr_0a_16 ; $7733
	ld de, $0018 ; $7736
	add hl, de ; $7739
	ld [hl], $01 ; $773a
	ld a, $02 ; $773c
	ld b, $80 ; $773e
	farcall FarPtr_0a_2e ; $7740
	push af ; $7743
	ld a, $14 ; $7744
	farcall FarPtr_0a_04 ; $7746
	pop af ; $7749
	ld a, $02 ; $774a
	ld d, $03 ; $774c
	farcall FarPtr_0a_34 ; $774e
	ld a, $02 ; $7751
	farcall FarPtr_0a_36 ; $7753
	push af ; $7756
	ld a, $14 ; $7757
	farcall FarPtr_0a_04 ; $7759
	pop af ; $775c
	ld a, $00 ; $775d
	ld d, $03 ; $775f
	farcall FarPtr_0a_34 ; $7761
	ld a, $00 ; $7764
	farcall FarPtr_0a_36 ; $7766
Label_13_7769:
	ld hl, $041c ; $7769
	farcall FarPtr_0a_0e ; $776c
	push af ; $776f
	ld a, $14 ; $7770
	farcall FarPtr_0a_04 ; $7772
	pop af ; $7775
	ld a, $08 ; $7776
	farcall FarPtr_0a_08 ; $7778
	ld a, $00 ; $777b
	ld b, $00 ; $777d
	farcall FarPtr_0a_2c ; $777f
	ld a, $00 ; $7782
	ld b, $00 ; $7784
	farcall FarPtr_0a_2e ; $7786
	ld a, $02 ; $7789
	ld b, $00 ; $778b
	farcall FarPtr_0a_2e ; $778d
	ldh a, [$ff95] ; $7790
	ld b, a ; $7792
	ld a, $08 ; $7793
	ld de, $7a43 ; $7795
	farcall FarPtr_0a_1a ; $7798
	ldh a, [$ff95] ; $779b
	ld b, a ; $779d
	ld a, $03 ; $779e
	ld de, $7a60 ; $77a0
	farcall FarPtr_0a_1a ; $77a3
	push af ; $77a6
	ld a, $14 ; $77a7
	farcall FarPtr_0a_04 ; $77a9
	pop af ; $77ac
	ldh a, [$ff95] ; $77ad
	ld b, a ; $77af
	ld a, $09 ; $77b0
	ld de, $7ac9 ; $77b2
	farcall FarPtr_0a_1a ; $77b5
	xor a, a ; $77b8
	ld bc, $0b00 ; $77b9
	ld de, $1d00 ; $77bc
	farcall FarPtr_0a_3a ; $77bf
	farcall FarPtr_0a_3e ; $77c2
	ld a, $09 ; $77c5
	farcall FarPtr_0a_1e ; $77c7
	ld a, $00 ; $77ca
	ld b, a ; $77cc
	ld a, $09 ; $77cd
	farcall FarPtr_0a_30 ; $77cf
	ld a, $03 ; $77d2
	ld b, a ; $77d4
	ld a, $02 ; $77d5
	farcall FarPtr_0a_30 ; $77d7
	ld a, $09 ; $77da
	ld d, $04 ; $77dc
	farcall FarPtr_0a_34 ; $77de
	ld a, $09 ; $77e1
	farcall FarPtr_0a_36 ; $77e3
	ld a, $09 ; $77e6
	ld b, a ; $77e8
	ld a, $00 ; $77e9
	farcall FarPtr_0a_30 ; $77eb
	ld a, $09 ; $77ee
	farcall FarPtr_0a_08 ; $77f0
	ld a, $08 ; $77f3
	ld bc, $0a00 ; $77f5
	ld de, $1f00 ; $77f8
	farcall FarPtr_0a_24 ; $77fb
	ld a, $08 ; $77fe
	farcall FarPtr_0a_20 ; $7800
	ld a, $08 ; $7803
	ld b, a ; $7805
	ld a, $00 ; $7806
	farcall FarPtr_0a_30 ; $7808
	ld a, $03 ; $780b
	ld b, a ; $780d
	ld a, $02 ; $780e
	farcall FarPtr_0a_30 ; $7810
	ld a, $08 ; $7813
	ld d, $03 ; $7815
	farcall FarPtr_0a_34 ; $7817
	ld a, $08 ; $781a
	farcall FarPtr_0a_36 ; $781c
	ld a, $08 ; $781f
	farcall FarPtr_0a_08 ; $7821
	ld a, $03 ; $7824
	ld bc, $0c00 ; $7826
	ld de, $1f00 ; $7829
	farcall FarPtr_0a_24 ; $782c
	ld a, $03 ; $782f
	farcall FarPtr_0a_20 ; $7831
	ld a, $03 ; $7834
	ld d, $02 ; $7836
	farcall FarPtr_0a_34 ; $7838
	ld a, $03 ; $783b
	farcall FarPtr_0a_36 ; $783d
	ld a, $03 ; $7840
	farcall FarPtr_0a_08 ; $7842
	ld a, $00 ; $7845
	ld b, a ; $7847
	ld a, $02 ; $7848
	farcall FarPtr_0a_30 ; $784a
	ld a, $02 ; $784d
	ld d, $03 ; $784f
	farcall FarPtr_0a_34 ; $7851
	ld a, $02 ; $7854
	farcall FarPtr_0a_36 ; $7856
	rst Rst30 ; $7859
	nop ; $785a
	inc e ; $785b
	jr z, Label_13_7861 ; $785c
	farcall FarPtr_0a_10 ; $785e
Label_13_7861:
	ld a, $02 ; $7861
	farcall FarPtr_0a_08 ; $7863
	ld a, $02 ; $7866
	ld b, a ; $7868
	ld a, $00 ; $7869
	farcall FarPtr_0a_30 ; $786b
	ld a, $00 ; $786e
	ld d, $03 ; $7870
	farcall FarPtr_0a_34 ; $7872
	ld a, $00 ; $7875
	farcall FarPtr_0a_36 ; $7877
	push af ; $787a
	ld a, $0a ; $787b
	farcall FarPtr_0a_04 ; $787d
	pop af ; $7880
	ld a, $08 ; $7881
	ld b, a ; $7883
	ld a, $00 ; $7884
	farcall FarPtr_0a_30 ; $7886
	ld a, $03 ; $7889
	ld b, a ; $788b
	ld a, $02 ; $788c
	farcall FarPtr_0a_30 ; $788e
	push af ; $7891
	ld a, $0a ; $7892
	farcall FarPtr_0a_04 ; $7894
	pop af ; $7897
	ld a, $00 ; $7898
	ld d, $03 ; $789a
	farcall FarPtr_0a_34 ; $789c
	ld a, $02 ; $789f
	ld d, $03 ; $78a1
	farcall FarPtr_0a_34 ; $78a3
	ld c, $02 ; $78a6
	call Func_00_1d20 ; $78a8
	call Func_00_1da4 ; $78ab
	call Func_13_78c4 ; $78ae
	ld a, $00 ; $78b1
	ld [wStoryModeCurrentLocation], a ; $78b3
	ld a, $0a ; $78b6
	ld [$c295], a ; $78b8
	ld a, $ff ; $78bb
	ld [$c294], a ; $78bd
	ld [$c2a1], a ; $78c0
	ret ; $78c3
Func_13_78c4:
	ld b, $00 ; $78c4
	ld a, [$c90d] ; $78c6
	ld d, a ; $78c9
	sla a ; $78ca
	ld c, a ; $78cc
	ld a, [$c94d] ; $78cd
	xor a, d ; $78d0
	or a, c ; $78d1
	ld c, a ; $78d2
	farcall FarPtr_18_8e ; $78d3
	ret ; $78d6
	INCBIN "data/bank_013/d_78d7.bin" ; $78d7, 177 bytes
Label_13_7988:
	rst Rst30 ; $7988
	ldh [rTIMA], a ; $7989
	jr z, Label_13_7991 ; $798b
	call Func_13_744f ; $798d
	ret ; $7990
Label_13_7991:
	call Func_13_70fb ; $7991
	ret ; $7994
Func_13_7995:
	ld a, $04 ; $7995
	ldh [$ff96], a ; $7997
	ldh [rWBK], a ; $7999
	ld a, [wMatchWinLoseFlag] ; $799b
	cp a, $01 ; $799e
	jp z, Label_13_79a4 ; $79a0
	ret ; $79a3
Label_13_79a4:
	ld a, $07 ; $79a4
	ld [wStoryModeCurrentLocation], a ; $79a6
	ld a, $0e ; $79a9
	ld [$c295], a ; $79ab
	ld a, $ff ; $79ae
	ld [$c294], a ; $79b0
	ld [$c2a1], a ; $79b3
	rst Rst30 ; $79b6
	ldh [rTIMA], a ; $79b7
	jr nz, Label_13_79e5 ; $79b9
	ldh a, [$ff95] ; $79bb
	ld hl, $739c ; $79bd
	farcall FarPtr_0a_06 ; $79c0
	farcall FarPtr_0a_00 ; $79c3
	ld c, $04 ; $79c6
	call Func_00_1d2e ; $79c8
	call Func_00_1da4 ; $79cb
	ld bc, $0018 ; $79ce
	farcall FarPtr_0a_38 ; $79d1
	xor a, a ; $79d4
	ld bc, $0900 ; $79d5
	ld de, $1300 ; $79d8
	farcall FarPtr_0a_3a ; $79db
	farcall FarPtr_0a_3e ; $79de
	call Func_13_7ae0 ; $79e1
	ret ; $79e4
Label_13_79e5:
	ldh a, [$ff95] ; $79e5
	ld hl, $78d7 ; $79e7
	farcall FarPtr_0a_06 ; $79ea
	farcall FarPtr_0a_00 ; $79ed
	call Func_13_62be ; $79f0
	ld a, $02 ; $79f3
	farcall FarPtr_0a_1c ; $79f5
	ld a, $01 ; $79f8
	farcall FarPtr_0a_1c ; $79fa
	ld bc, $0040 ; $79fd
	farcall FarPtr_0a_38 ; $7a00
	ld a, $00 ; $7a03
	ld bc, $0b00 ; $7a05
	ld de, $1d00 ; $7a08
	farcall FarPtr_0a_22 ; $7a0b
	ld a, $02 ; $7a0e
	ld bc, $0d00 ; $7a10
	ld de, $2300 ; $7a13
	farcall FarPtr_0a_22 ; $7a16
	ld a, $00 ; $7a19
	ld b, $c0 ; $7a1b
	farcall FarPtr_0a_2e ; $7a1d
	ld a, $02 ; $7a20
	ld b, $c0 ; $7a22
	farcall FarPtr_0a_2e ; $7a24
	ld c, $04 ; $7a27
	call Func_00_1d2e ; $7a29
	call Func_00_1da4 ; $7a2c
	xor a, a ; $7a2f
	ld bc, $0900 ; $7a30
	ld de, $1300 ; $7a33
	farcall FarPtr_0a_3a ; $7a36
	farcall FarPtr_0a_3e ; $7a39
	call Func_13_7ae0 ; $7a3c
	ret ; $7a3f
	INCBIN "data/bank_013/d_7a40.bin" ; $7a40, 160 bytes
Func_13_7ae0:
	ld c, $08 ; $7ae0
	call Func_00_1d20 ; $7ae2
	call Func_00_1da4 ; $7ae5
	xor a, a ; $7ae8
	ldh [$ffb9], a ; $7ae9
	ldh [$ffb8], a ; $7aeb
	ldh [$ff8a], a ; $7aed
	ldh [$ff8b], a ; $7aef
	ld [$c321], a ; $7af1
	ld [$c323], a ; $7af4
	call Func_00_1b38 ; $7af7
	rst Rst30 ; $7afa
	ldh [rTIMA], a ; $7afb
	jr nz, Label_13_7b10 ; $7afd
	rst Rst30 ; $7aff
	add a, b ; $7b00
	rlca ; $7b01
	jr nz, Label_13_7b0a ; $7b02
	ld b, $00 ; $7b04
	ld c, $04 ; $7b06
	jr Label_13_7b1b ; $7b08
Label_13_7b0a:
	ld b, $00 ; $7b0a
	ld c, $01 ; $7b0c
	jr Label_13_7b1b ; $7b0e
Label_13_7b10:
	rst Rst30 ; $7b10
	and a, b ; $7b11
	ld b, $20 ; $7b12
	ld a, [bc] ; $7b14
	ld b, $01 ; $7b15
	ld c, $02 ; $7b17
	jr Label_13_7b1b ; $7b19
Label_13_7b1b:
	farcall FarPtr_3b_1c ; $7b1b
	ret ; $7b1e
	INCBIN "data/bank_013/d_7b1f.bin" ; $7b1f, 46 bytes
	ret ; $7b4d
	INCBIN "data/bank_013/d_7b4e.bin" ; $7b4e, 522 bytes
Func_13_7d58:
	ld a, $00 ; $7d58
	rst Rst30 ; $7d5a
	ld h, b ; $7d5b
	ld a, [bc] ; $7d5c
	jr z, Label_13_7d77 ; $7d5d
	inc a ; $7d5f
	rst Rst30 ; $7d60
	ldh [$ff0a], a ; $7d61
	jr z, Label_13_7d77 ; $7d63
	inc a ; $7d65
	rst Rst30 ; $7d66
	ldh [rTIMA], a ; $7d67
	jr nz, Label_13_7d7b ; $7d69
	rst Rst30 ; $7d6b
	ret nz ; $7d6c
	dec d ; $7d6d
	jr z, Label_13_7d77 ; $7d6e
	inc a ; $7d70
	rst Rst30 ; $7d71
	nop ; $7d72
	ld d, $28 ; $7d73
	INCBIN "data/bank_013/d_7d75.bin" ; $7d75, 2 bytes
Label_13_7d77:
	ld [$c2b0], a ; $7d77
	ret ; $7d7a
Label_13_7d7b:
	rst Rst30 ; $7d7b
	ldh [$ff15], a ; $7d7c
	jr z, Label_13_7d77 ; $7d7e
	inc a ; $7d80
	rst Rst30 ; $7d81
	jr nz, Label_13_7d9a ; $7d82
	jr z, Label_13_7d77 ; $7d84
	inc a ; $7d86
	jr Label_13_7d77 ; $7d87
	INCBIN "data/bank_013/d_7d89.bin" ; $7d89, 17 bytes
Label_13_7d9a:
	rst Rst38 ; $7d9a
	rst Rst38 ; $7d9b
	rst Rst38 ; $7d9c
	rst Rst38 ; $7d9d
	rst Rst38 ; $7d9e
	rst Rst38 ; $7d9f
	rst Rst38 ; $7da0
	rst Rst38 ; $7da1
	rst Rst38 ; $7da2
	rst Rst38 ; $7da3
	rst Rst38 ; $7da4
	rst Rst38 ; $7da5
	rst Rst38 ; $7da6
	rst Rst38 ; $7da7
	rst Rst38 ; $7da8
	rst Rst38 ; $7da9
	rst Rst38 ; $7daa
	rst Rst38 ; $7dab
	rst Rst38 ; $7dac
	rst Rst38 ; $7dad
	rst Rst38 ; $7dae
	rst Rst38 ; $7daf
	rst Rst38 ; $7db0
	rst Rst38 ; $7db1
	rst Rst38 ; $7db2
	rst Rst38 ; $7db3
	rst Rst38 ; $7db4
	rst Rst38 ; $7db5
	rst Rst38 ; $7db6
	rst Rst38 ; $7db7
	rst Rst38 ; $7db8
	rst Rst38 ; $7db9
	rst Rst38 ; $7dba
	rst Rst38 ; $7dbb
	rst Rst38 ; $7dbc
	rst Rst38 ; $7dbd
	rst Rst38 ; $7dbe
	rst Rst38 ; $7dbf
	rst Rst38 ; $7dc0
	rst Rst38 ; $7dc1
	rst Rst38 ; $7dc2
	rst Rst38 ; $7dc3
	rst Rst38 ; $7dc4
	rst Rst38 ; $7dc5
	rst Rst38 ; $7dc6
	rst Rst38 ; $7dc7
	rst Rst38 ; $7dc8
	rst Rst38 ; $7dc9
	rst Rst38 ; $7dca
	rst Rst38 ; $7dcb
	rst Rst38 ; $7dcc
	rst Rst38 ; $7dcd
	rst Rst38 ; $7dce
	rst Rst38 ; $7dcf
	rst Rst38 ; $7dd0
	rst Rst38 ; $7dd1
	rst Rst38 ; $7dd2
	rst Rst38 ; $7dd3
	rst Rst38 ; $7dd4
	rst Rst38 ; $7dd5
	rst Rst38 ; $7dd6
	rst Rst38 ; $7dd7
	rst Rst38 ; $7dd8
	rst Rst38 ; $7dd9
	rst Rst38 ; $7dda
	rst Rst38 ; $7ddb
	rst Rst38 ; $7ddc
	rst Rst38 ; $7ddd
	rst Rst38 ; $7dde
	rst Rst38 ; $7ddf
	rst Rst38 ; $7de0
	rst Rst38 ; $7de1
	rst Rst38 ; $7de2
	rst Rst38 ; $7de3
	rst Rst38 ; $7de4
	rst Rst38 ; $7de5
	rst Rst38 ; $7de6
	rst Rst38 ; $7de7
	rst Rst38 ; $7de8
	rst Rst38 ; $7de9
	rst Rst38 ; $7dea
	rst Rst38 ; $7deb
	rst Rst38 ; $7dec
	rst Rst38 ; $7ded
	rst Rst38 ; $7dee
	rst Rst38 ; $7def
	rst Rst38 ; $7df0
	rst Rst38 ; $7df1
	rst Rst38 ; $7df2
	rst Rst38 ; $7df3
	rst Rst38 ; $7df4
	rst Rst38 ; $7df5
	rst Rst38 ; $7df6
	rst Rst38 ; $7df7
	rst Rst38 ; $7df8
	rst Rst38 ; $7df9
	rst Rst38 ; $7dfa
	rst Rst38 ; $7dfb
	rst Rst38 ; $7dfc
	rst Rst38 ; $7dfd
	rst Rst38 ; $7dfe
	rst Rst38 ; $7dff
	rst Rst38 ; $7e00
	rst Rst38 ; $7e01
	rst Rst38 ; $7e02
	rst Rst38 ; $7e03
	rst Rst38 ; $7e04
	rst Rst38 ; $7e05
	rst Rst38 ; $7e06
	rst Rst38 ; $7e07
	rst Rst38 ; $7e08
	rst Rst38 ; $7e09
	rst Rst38 ; $7e0a
	rst Rst38 ; $7e0b
	rst Rst38 ; $7e0c
	rst Rst38 ; $7e0d
	rst Rst38 ; $7e0e
	rst Rst38 ; $7e0f
	rst Rst38 ; $7e10
	rst Rst38 ; $7e11
	rst Rst38 ; $7e12
	rst Rst38 ; $7e13
	rst Rst38 ; $7e14
	rst Rst38 ; $7e15
	rst Rst38 ; $7e16
	rst Rst38 ; $7e17
	rst Rst38 ; $7e18
	rst Rst38 ; $7e19
	rst Rst38 ; $7e1a
	rst Rst38 ; $7e1b
	rst Rst38 ; $7e1c
	rst Rst38 ; $7e1d
	rst Rst38 ; $7e1e
	rst Rst38 ; $7e1f
	rst Rst38 ; $7e20
	rst Rst38 ; $7e21
	rst Rst38 ; $7e22
	rst Rst38 ; $7e23
	rst Rst38 ; $7e24
	rst Rst38 ; $7e25
	rst Rst38 ; $7e26
	rst Rst38 ; $7e27
	rst Rst38 ; $7e28
	rst Rst38 ; $7e29
	rst Rst38 ; $7e2a
	rst Rst38 ; $7e2b
	rst Rst38 ; $7e2c
	rst Rst38 ; $7e2d
	rst Rst38 ; $7e2e
	rst Rst38 ; $7e2f
	rst Rst38 ; $7e30
	rst Rst38 ; $7e31
	rst Rst38 ; $7e32
	rst Rst38 ; $7e33
	rst Rst38 ; $7e34
	rst Rst38 ; $7e35
	rst Rst38 ; $7e36
	rst Rst38 ; $7e37
	rst Rst38 ; $7e38
	rst Rst38 ; $7e39
	rst Rst38 ; $7e3a
	rst Rst38 ; $7e3b
	rst Rst38 ; $7e3c
	rst Rst38 ; $7e3d
	rst Rst38 ; $7e3e
	rst Rst38 ; $7e3f
	rst Rst38 ; $7e40
	rst Rst38 ; $7e41
	rst Rst38 ; $7e42
	rst Rst38 ; $7e43
	rst Rst38 ; $7e44
	rst Rst38 ; $7e45
	rst Rst38 ; $7e46
	rst Rst38 ; $7e47
	rst Rst38 ; $7e48
	rst Rst38 ; $7e49
	rst Rst38 ; $7e4a
	rst Rst38 ; $7e4b
	rst Rst38 ; $7e4c
	rst Rst38 ; $7e4d
	rst Rst38 ; $7e4e
	rst Rst38 ; $7e4f
	rst Rst38 ; $7e50
	rst Rst38 ; $7e51
	rst Rst38 ; $7e52
	rst Rst38 ; $7e53
	rst Rst38 ; $7e54
	rst Rst38 ; $7e55
	rst Rst38 ; $7e56
	rst Rst38 ; $7e57
	rst Rst38 ; $7e58
	rst Rst38 ; $7e59
	rst Rst38 ; $7e5a
	rst Rst38 ; $7e5b
	rst Rst38 ; $7e5c
	rst Rst38 ; $7e5d
	rst Rst38 ; $7e5e
	rst Rst38 ; $7e5f
	rst Rst38 ; $7e60
	rst Rst38 ; $7e61
	rst Rst38 ; $7e62
	rst Rst38 ; $7e63
	rst Rst38 ; $7e64
	rst Rst38 ; $7e65
	rst Rst38 ; $7e66
	rst Rst38 ; $7e67
	rst Rst38 ; $7e68
	rst Rst38 ; $7e69
	rst Rst38 ; $7e6a
	rst Rst38 ; $7e6b
	rst Rst38 ; $7e6c
	rst Rst38 ; $7e6d
	rst Rst38 ; $7e6e
	rst Rst38 ; $7e6f
	rst Rst38 ; $7e70
	rst Rst38 ; $7e71
	rst Rst38 ; $7e72
	rst Rst38 ; $7e73
	rst Rst38 ; $7e74
	rst Rst38 ; $7e75
	rst Rst38 ; $7e76
	rst Rst38 ; $7e77
	rst Rst38 ; $7e78
	rst Rst38 ; $7e79
	rst Rst38 ; $7e7a
	rst Rst38 ; $7e7b
	rst Rst38 ; $7e7c
	rst Rst38 ; $7e7d
	rst Rst38 ; $7e7e
	rst Rst38 ; $7e7f
	rst Rst38 ; $7e80
	rst Rst38 ; $7e81
	rst Rst38 ; $7e82
	rst Rst38 ; $7e83
	rst Rst38 ; $7e84
	rst Rst38 ; $7e85
	rst Rst38 ; $7e86
	rst Rst38 ; $7e87
	rst Rst38 ; $7e88
	rst Rst38 ; $7e89
	rst Rst38 ; $7e8a
	rst Rst38 ; $7e8b
	rst Rst38 ; $7e8c
	rst Rst38 ; $7e8d
	rst Rst38 ; $7e8e
	rst Rst38 ; $7e8f
	rst Rst38 ; $7e90
	rst Rst38 ; $7e91
	rst Rst38 ; $7e92
	rst Rst38 ; $7e93
	rst Rst38 ; $7e94
	rst Rst38 ; $7e95
	rst Rst38 ; $7e96
	rst Rst38 ; $7e97
	rst Rst38 ; $7e98
	rst Rst38 ; $7e99
	rst Rst38 ; $7e9a
	rst Rst38 ; $7e9b
	rst Rst38 ; $7e9c
	rst Rst38 ; $7e9d
	rst Rst38 ; $7e9e
	rst Rst38 ; $7e9f
	rst Rst38 ; $7ea0
	rst Rst38 ; $7ea1
	rst Rst38 ; $7ea2
	rst Rst38 ; $7ea3
	rst Rst38 ; $7ea4
	rst Rst38 ; $7ea5
	rst Rst38 ; $7ea6
	rst Rst38 ; $7ea7
	rst Rst38 ; $7ea8
	rst Rst38 ; $7ea9
	rst Rst38 ; $7eaa
	rst Rst38 ; $7eab
	rst Rst38 ; $7eac
	rst Rst38 ; $7ead
	rst Rst38 ; $7eae
	rst Rst38 ; $7eaf
	rst Rst38 ; $7eb0
	rst Rst38 ; $7eb1
	rst Rst38 ; $7eb2
	rst Rst38 ; $7eb3
	rst Rst38 ; $7eb4
	rst Rst38 ; $7eb5
	rst Rst38 ; $7eb6
	rst Rst38 ; $7eb7
	rst Rst38 ; $7eb8
	rst Rst38 ; $7eb9
	rst Rst38 ; $7eba
	rst Rst38 ; $7ebb
	rst Rst38 ; $7ebc
	rst Rst38 ; $7ebd
	rst Rst38 ; $7ebe
	rst Rst38 ; $7ebf
	rst Rst38 ; $7ec0
	rst Rst38 ; $7ec1
	rst Rst38 ; $7ec2
	rst Rst38 ; $7ec3
	rst Rst38 ; $7ec4
	rst Rst38 ; $7ec5
	rst Rst38 ; $7ec6
	rst Rst38 ; $7ec7
	rst Rst38 ; $7ec8
	rst Rst38 ; $7ec9
	rst Rst38 ; $7eca
	rst Rst38 ; $7ecb
	rst Rst38 ; $7ecc
	rst Rst38 ; $7ecd
	rst Rst38 ; $7ece
	rst Rst38 ; $7ecf
	rst Rst38 ; $7ed0
	rst Rst38 ; $7ed1
	rst Rst38 ; $7ed2
	rst Rst38 ; $7ed3
	rst Rst38 ; $7ed4
	rst Rst38 ; $7ed5
	rst Rst38 ; $7ed6
	rst Rst38 ; $7ed7
	rst Rst38 ; $7ed8
	rst Rst38 ; $7ed9
	rst Rst38 ; $7eda
	rst Rst38 ; $7edb
	rst Rst38 ; $7edc
	rst Rst38 ; $7edd
	rst Rst38 ; $7ede
	rst Rst38 ; $7edf
	rst Rst38 ; $7ee0
	rst Rst38 ; $7ee1
	rst Rst38 ; $7ee2
	rst Rst38 ; $7ee3
	rst Rst38 ; $7ee4
	rst Rst38 ; $7ee5
	rst Rst38 ; $7ee6
	rst Rst38 ; $7ee7
	rst Rst38 ; $7ee8
	rst Rst38 ; $7ee9
	rst Rst38 ; $7eea
	rst Rst38 ; $7eeb
	rst Rst38 ; $7eec
	rst Rst38 ; $7eed
	rst Rst38 ; $7eee
	rst Rst38 ; $7eef
	rst Rst38 ; $7ef0
	rst Rst38 ; $7ef1
	rst Rst38 ; $7ef2
	rst Rst38 ; $7ef3
	rst Rst38 ; $7ef4
	rst Rst38 ; $7ef5
	rst Rst38 ; $7ef6
	rst Rst38 ; $7ef7
	rst Rst38 ; $7ef8
	rst Rst38 ; $7ef9
	rst Rst38 ; $7efa
	rst Rst38 ; $7efb
	rst Rst38 ; $7efc
	rst Rst38 ; $7efd
	rst Rst38 ; $7efe
	rst Rst38 ; $7eff
	rst Rst38 ; $7f00
	rst Rst38 ; $7f01
	rst Rst38 ; $7f02
	rst Rst38 ; $7f03
	rst Rst38 ; $7f04
	rst Rst38 ; $7f05
	rst Rst38 ; $7f06
	rst Rst38 ; $7f07
	rst Rst38 ; $7f08
	rst Rst38 ; $7f09
	rst Rst38 ; $7f0a
	rst Rst38 ; $7f0b
	rst Rst38 ; $7f0c
	rst Rst38 ; $7f0d
	rst Rst38 ; $7f0e
	rst Rst38 ; $7f0f
	rst Rst38 ; $7f10
	rst Rst38 ; $7f11
	rst Rst38 ; $7f12
	rst Rst38 ; $7f13
	rst Rst38 ; $7f14
	rst Rst38 ; $7f15
	rst Rst38 ; $7f16
	rst Rst38 ; $7f17
	rst Rst38 ; $7f18
	rst Rst38 ; $7f19
	rst Rst38 ; $7f1a
	rst Rst38 ; $7f1b
	rst Rst38 ; $7f1c
	rst Rst38 ; $7f1d
	rst Rst38 ; $7f1e
	rst Rst38 ; $7f1f
	rst Rst38 ; $7f20
	rst Rst38 ; $7f21
	rst Rst38 ; $7f22
	rst Rst38 ; $7f23
	rst Rst38 ; $7f24
	rst Rst38 ; $7f25
	rst Rst38 ; $7f26
	rst Rst38 ; $7f27
	rst Rst38 ; $7f28
	rst Rst38 ; $7f29
	rst Rst38 ; $7f2a
	rst Rst38 ; $7f2b
	rst Rst38 ; $7f2c
	rst Rst38 ; $7f2d
	rst Rst38 ; $7f2e
	rst Rst38 ; $7f2f
	rst Rst38 ; $7f30
	rst Rst38 ; $7f31
	rst Rst38 ; $7f32
	rst Rst38 ; $7f33
	rst Rst38 ; $7f34
	rst Rst38 ; $7f35
	rst Rst38 ; $7f36
	rst Rst38 ; $7f37
	rst Rst38 ; $7f38
	rst Rst38 ; $7f39
	rst Rst38 ; $7f3a
	rst Rst38 ; $7f3b
	rst Rst38 ; $7f3c
	rst Rst38 ; $7f3d
	rst Rst38 ; $7f3e
	rst Rst38 ; $7f3f
	rst Rst38 ; $7f40
	rst Rst38 ; $7f41
	rst Rst38 ; $7f42
	rst Rst38 ; $7f43
	rst Rst38 ; $7f44
	rst Rst38 ; $7f45
	rst Rst38 ; $7f46
	rst Rst38 ; $7f47
	rst Rst38 ; $7f48
	rst Rst38 ; $7f49
	rst Rst38 ; $7f4a
	rst Rst38 ; $7f4b
	rst Rst38 ; $7f4c
	rst Rst38 ; $7f4d
	rst Rst38 ; $7f4e
	rst Rst38 ; $7f4f
	rst Rst38 ; $7f50
	rst Rst38 ; $7f51
	rst Rst38 ; $7f52
	rst Rst38 ; $7f53
	rst Rst38 ; $7f54
	rst Rst38 ; $7f55
	rst Rst38 ; $7f56
	rst Rst38 ; $7f57
	rst Rst38 ; $7f58
	rst Rst38 ; $7f59
	rst Rst38 ; $7f5a
	rst Rst38 ; $7f5b
	rst Rst38 ; $7f5c
	rst Rst38 ; $7f5d
	rst Rst38 ; $7f5e
	rst Rst38 ; $7f5f
	rst Rst38 ; $7f60
	rst Rst38 ; $7f61
	rst Rst38 ; $7f62
	rst Rst38 ; $7f63
	rst Rst38 ; $7f64
	rst Rst38 ; $7f65
	rst Rst38 ; $7f66
	rst Rst38 ; $7f67
	rst Rst38 ; $7f68
	rst Rst38 ; $7f69
	rst Rst38 ; $7f6a
	rst Rst38 ; $7f6b
	rst Rst38 ; $7f6c
	rst Rst38 ; $7f6d
	rst Rst38 ; $7f6e
	rst Rst38 ; $7f6f
	rst Rst38 ; $7f70
	rst Rst38 ; $7f71
	rst Rst38 ; $7f72
	rst Rst38 ; $7f73
	rst Rst38 ; $7f74
	rst Rst38 ; $7f75
	rst Rst38 ; $7f76
	rst Rst38 ; $7f77
	rst Rst38 ; $7f78
	rst Rst38 ; $7f79
	rst Rst38 ; $7f7a
	rst Rst38 ; $7f7b
	rst Rst38 ; $7f7c
	rst Rst38 ; $7f7d
	rst Rst38 ; $7f7e
	rst Rst38 ; $7f7f
	rst Rst38 ; $7f80
	rst Rst38 ; $7f81
	rst Rst38 ; $7f82
	rst Rst38 ; $7f83
	rst Rst38 ; $7f84
	rst Rst38 ; $7f85
	rst Rst38 ; $7f86
	rst Rst38 ; $7f87
	rst Rst38 ; $7f88
	rst Rst38 ; $7f89
	rst Rst38 ; $7f8a
	rst Rst38 ; $7f8b
	rst Rst38 ; $7f8c
	rst Rst38 ; $7f8d
	rst Rst38 ; $7f8e
	rst Rst38 ; $7f8f
	rst Rst38 ; $7f90
	rst Rst38 ; $7f91
	rst Rst38 ; $7f92
	rst Rst38 ; $7f93
	rst Rst38 ; $7f94
	rst Rst38 ; $7f95
	rst Rst38 ; $7f96
	rst Rst38 ; $7f97
	rst Rst38 ; $7f98
	rst Rst38 ; $7f99
	rst Rst38 ; $7f9a
	rst Rst38 ; $7f9b
	rst Rst38 ; $7f9c
	rst Rst38 ; $7f9d
	rst Rst38 ; $7f9e
	rst Rst38 ; $7f9f
	rst Rst38 ; $7fa0
	rst Rst38 ; $7fa1
	rst Rst38 ; $7fa2
	rst Rst38 ; $7fa3
	rst Rst38 ; $7fa4
	rst Rst38 ; $7fa5
	rst Rst38 ; $7fa6
	rst Rst38 ; $7fa7
	rst Rst38 ; $7fa8
	rst Rst38 ; $7fa9
	rst Rst38 ; $7faa
	rst Rst38 ; $7fab
	rst Rst38 ; $7fac
	rst Rst38 ; $7fad
	rst Rst38 ; $7fae
	rst Rst38 ; $7faf
	rst Rst38 ; $7fb0
	rst Rst38 ; $7fb1
	rst Rst38 ; $7fb2
	rst Rst38 ; $7fb3
	rst Rst38 ; $7fb4
	rst Rst38 ; $7fb5
	rst Rst38 ; $7fb6
	rst Rst38 ; $7fb7
	rst Rst38 ; $7fb8
	rst Rst38 ; $7fb9
	rst Rst38 ; $7fba
	rst Rst38 ; $7fbb
	rst Rst38 ; $7fbc
	rst Rst38 ; $7fbd
	rst Rst38 ; $7fbe
	rst Rst38 ; $7fbf
	rst Rst38 ; $7fc0
	rst Rst38 ; $7fc1
	rst Rst38 ; $7fc2
	rst Rst38 ; $7fc3
	rst Rst38 ; $7fc4
	rst Rst38 ; $7fc5
	rst Rst38 ; $7fc6
	rst Rst38 ; $7fc7
	rst Rst38 ; $7fc8
	rst Rst38 ; $7fc9
	rst Rst38 ; $7fca
	rst Rst38 ; $7fcb
	rst Rst38 ; $7fcc
	rst Rst38 ; $7fcd
	rst Rst38 ; $7fce
	rst Rst38 ; $7fcf
	rst Rst38 ; $7fd0
	rst Rst38 ; $7fd1
	rst Rst38 ; $7fd2
	rst Rst38 ; $7fd3
	rst Rst38 ; $7fd4
	rst Rst38 ; $7fd5
	rst Rst38 ; $7fd6
	rst Rst38 ; $7fd7
	rst Rst38 ; $7fd8
	rst Rst38 ; $7fd9
	rst Rst38 ; $7fda
	rst Rst38 ; $7fdb
	rst Rst38 ; $7fdc
	rst Rst38 ; $7fdd
	rst Rst38 ; $7fde
	rst Rst38 ; $7fdf
	rst Rst38 ; $7fe0
	rst Rst38 ; $7fe1
	rst Rst38 ; $7fe2
	rst Rst38 ; $7fe3
	rst Rst38 ; $7fe4
	rst Rst38 ; $7fe5
	rst Rst38 ; $7fe6
	rst Rst38 ; $7fe7
	rst Rst38 ; $7fe8
	rst Rst38 ; $7fe9
	rst Rst38 ; $7fea
	rst Rst38 ; $7feb
	rst Rst38 ; $7fec
	rst Rst38 ; $7fed
	rst Rst38 ; $7fee
	rst Rst38 ; $7fef
	rst Rst38 ; $7ff0
	rst Rst38 ; $7ff1
	rst Rst38 ; $7ff2
	rst Rst38 ; $7ff3
	rst Rst38 ; $7ff4
	rst Rst38 ; $7ff5
	rst Rst38 ; $7ff6
	rst Rst38 ; $7ff7
	rst Rst38 ; $7ff8
	rst Rst38 ; $7ff9
	rst Rst38 ; $7ffa
	rst Rst38 ; $7ffb
	rst Rst38 ; $7ffc
	rst Rst38 ; $7ffd
	rst Rst38 ; $7ffe
	rst Rst38 ; $7fff
