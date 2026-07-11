INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $12", ROMX[$4000], BANK[$12]

DataPtr_12_00:
	dw Data_12_4006 ; $4000
DataPtr_12_02:
	dw Data_12_467c ; $4002
DataPtr_12_04:
	dw Data_12_52f7 ; $4004
Data_12_4006:
	INCBIN "data/bank_012/d_4006.bin" ; $4006, 14 bytes
	INCBIN "data/bank_012/d_4014.bin" ; $4014, 91 bytes
	ld a, [$c295] ; $406f
	cp a, $ff ; $4072
	jp z, Label_12_40b4 ; $4074
	test_flag $05, 7 ; $4077
	jr z, Label_12_40a2 ; $407a
	ld a, $02 ; $407c
	ld bc, $00ff ; $407e
	farcall FarPtr_0a_18 ; $4081
	ld a, $02 ; $4084
	ld b, $c0 ; $4086
	ld de, $0200 ; $4088
	farcall FarPtr_0a_2a ; $408b
	ld a, $02 ; $408e
	farcall FarPtr_0a_20 ; $4090
	ld a, $02 ; $4093
	ld b, $40 ; $4095
	farcall FarPtr_0a_2e ; $4097
	ld a, $02 ; $409a
	ld bc, $0010 ; $409c
	farcall FarPtr_0a_18 ; $409f
Label_12_40a2:
	ld a, $00 ; $40a2
	ld bc, $0010 ; $40a4
	farcall FarPtr_0a_18 ; $40a7
	ld a, $00 ; $40aa
	ld b, $40 ; $40ac
	ld de, $0200 ; $40ae
	farcall FarPtr_0a_2a ; $40b1
Label_12_40b4:
	ret ; $40b4
	ld a, [$c295] ; $40b5
	cp a, $ff ; $40b8
	jp z, Label_12_40fa ; $40ba
	test_flag $05, 7 ; $40bd
	jr z, Label_12_40e8 ; $40c0
	ld a, $02 ; $40c2
	ld bc, $00ff ; $40c4
	farcall FarPtr_0a_18 ; $40c7
	ld a, $02 ; $40ca
	ld b, $40 ; $40cc
	ld de, $0200 ; $40ce
	farcall FarPtr_0a_2a ; $40d1
	ld a, $02 ; $40d4
	farcall FarPtr_0a_20 ; $40d6
	ld a, $02 ; $40d9
	ld b, $c0 ; $40db
	farcall FarPtr_0a_2e ; $40dd
	ld a, $02 ; $40e0
	ld bc, $0010 ; $40e2
	farcall FarPtr_0a_18 ; $40e5
Label_12_40e8:
	ld a, $00 ; $40e8
	ld bc, $0010 ; $40ea
	farcall FarPtr_0a_18 ; $40ed
	ld a, $00 ; $40f0
	ld b, $c0 ; $40f2
	ld de, $0200 ; $40f4
	farcall FarPtr_0a_2a ; $40f7
Label_12_40fa:
	ret ; $40fa
	INCBIN "data/bank_012/d_40fb.bin" ; $40fb, 36 bytes
	ld a, $00 ; $411f
	ld b, $00 ; $4121
	farcall FarPtr_0a_48 ; $4123
	ld a, $00 ; $4126
	ld bc, $1600 ; $4128
	ld de, $0900 ; $412b
	farcall FarPtr_0a_24 ; $412e
	ld a, $00 ; $4131
	farcall FarPtr_0a_20 ; $4133
	ld bc, $0010 ; $4136
	farcall FarPtr_0a_38 ; $4139
	xor a, a ; $413c
	ld bc, $1600 ; $413d
	ld de, $0800 ; $4140
	farcall FarPtr_0a_3a ; $4143
	push af ; $4146
	ld a, $0f ; $4147
	farcall FarPtr_0a_04 ; $4149
	pop af ; $414c
	ld c, $04 ; $414d
	call Func_00_1d20 ; $414f
	farcall FarPtr_0a_3e ; $4152
	call Func_00_1da4 ; $4155
	ld a, [$c90d] ; $4158
	or a, a ; $415b
	jr nz, Label_12_4167 ; $415c
	ld a, $01 ; $415e
	ld [$c294], a ; $4160
	ld [$c2a1], a ; $4163
	ret ; $4166
Label_12_4167:
	ld a, $01 ; $4167
	ld [$c294], a ; $4169
	ld [$c2a1], a ; $416c
	ret ; $416f
	ld a, [$c295] ; $4170
	cp a, $0f ; $4173
	call z, Func_12_4179 ; $4175
	ret ; $4178
Func_12_4179:
	ld a, $03 ; $4179
	ld bc, $0010 ; $417b
	farcall FarPtr_0a_18 ; $417e
	ld a, $04 ; $4181
	ld bc, $0010 ; $4183
	farcall FarPtr_0a_18 ; $4186
	ld a, $00 ; $4189
	ld bc, $0010 ; $418b
	farcall FarPtr_0a_18 ; $418e
	ld bc, $0010 ; $4191
	farcall FarPtr_0a_38 ; $4194
	ld a, $00 ; $4197
	ld bc, $1600 ; $4199
	ld de, $1f00 ; $419c
	farcall FarPtr_0a_22 ; $419f
	ld a, $03 ; $41a2
	ld bc, $1600 ; $41a4
	ld de, $1d00 ; $41a7
	farcall FarPtr_0a_22 ; $41aa
	ld a, $03 ; $41ad
	ld b, $c0 ; $41af
	farcall FarPtr_0a_2e ; $41b1
	ld c, $20 ; $41b4
	call Func_00_1d2e ; $41b6
	push af ; $41b9
	ld a, $14 ; $41ba
	farcall FarPtr_0a_04 ; $41bc
	pop af ; $41bf
	ld a, $03 ; $41c0
	ld bc, $1600 ; $41c2
	ld de, $1100 ; $41c5
	farcall FarPtr_0a_24 ; $41c8
	xor a, a ; $41cb
	ld bc, $1600 ; $41cc
	ld de, $0f00 ; $41cf
	farcall FarPtr_0a_3a ; $41d2
	ld a, $00 ; $41d5
	ld bc, $1600 ; $41d7
	ld de, $1400 ; $41da
	farcall FarPtr_0a_24 ; $41dd
	ld a, $00 ; $41e0
	farcall FarPtr_0a_20 ; $41e2
	ld a, $03 ; $41e5
	ld bc, $1600 ; $41e7
	ld de, $1100 ; $41ea
	farcall FarPtr_0a_24 ; $41ed
	ld a, $00 ; $41f0
	ld bc, $1600 ; $41f2
	ld de, $1300 ; $41f5
	farcall FarPtr_0a_24 ; $41f8
	ld a, $00 ; $41fb
	farcall FarPtr_0a_20 ; $41fd
	push af ; $4200
	ld a, $14 ; $4201
	farcall FarPtr_0a_04 ; $4203
	pop af ; $4206
	ld a, $03 ; $4207
	farcall FarPtr_0a_20 ; $4209
	ld a, $00 ; $420c
	ld b, a ; $420e
	ld a, $03 ; $420f
	farcall FarPtr_0a_30 ; $4211
	ld hl, $044a ; $4214
	farcall FarPtr_0a_0e ; $4217
	ld a, $03 ; $421a
	farcall FarPtr_0a_08 ; $421c
	ld a, $03 ; $421f
	ld d, $03 ; $4221
	farcall FarPtr_0a_34 ; $4223
	ld a, $03 ; $4226
	farcall FarPtr_0a_36 ; $4228
	ld a, $03 ; $422b
	farcall FarPtr_0a_08 ; $422d
	ld a, $00 ; $4230
	ld d, $02 ; $4232
	farcall FarPtr_0a_34 ; $4234
	ld bc, $0018 ; $4237
	farcall FarPtr_0a_38 ; $423a
	xor a, a ; $423d
	ld bc, $1600 ; $423e
	ld de, $0b00 ; $4241
	farcall FarPtr_0a_3a ; $4244
	farcall FarPtr_0a_3e ; $4247
	push af ; $424a
	ld a, $14 ; $424b
	farcall FarPtr_0a_04 ; $424d
	pop af ; $4250
	xor a, a ; $4251
	ld bc, $1100 ; $4252
	ld de, $0b00 ; $4255
	farcall FarPtr_0a_3a ; $4258
	farcall FarPtr_0a_3e ; $425b
	push af ; $425e
	ld a, $0a ; $425f
	farcall FarPtr_0a_04 ; $4261
	pop af ; $4264
	xor a, a ; $4265
	ld bc, $1a00 ; $4266
	ld de, $0b00 ; $4269
	farcall FarPtr_0a_3a ; $426c
	farcall FarPtr_0a_3e ; $426f
	push af ; $4272
	ld a, $0a ; $4273
	farcall FarPtr_0a_04 ; $4275
	pop af ; $4278
	xor a, a ; $4279
	ld bc, $1600 ; $427a
	ld de, $0b00 ; $427d
	farcall FarPtr_0a_3a ; $4280
	farcall FarPtr_0a_3e ; $4283
	push af ; $4286
	ld a, $1e ; $4287
	farcall FarPtr_0a_04 ; $4289
	pop af ; $428c
	xor a, a ; $428d
	ld bc, $1600 ; $428e
	ld de, $1000 ; $4291
	farcall FarPtr_0a_3a ; $4294
	ld a, $00 ; $4297
	ld d, $02 ; $4299
	farcall FarPtr_0a_34 ; $429b
	ld a, $00 ; $429e
	farcall FarPtr_0a_36 ; $42a0
	push af ; $42a3
	ld a, $14 ; $42a4
	farcall FarPtr_0a_04 ; $42a6
	pop af ; $42a9
	ld bc, $0010 ; $42aa
	farcall FarPtr_0a_38 ; $42ad
	ld a, $05 ; $42b0
	ld bc, $1780 ; $42b2
	ld de, $0f00 ; $42b5
	farcall FarPtr_0a_22 ; $42b8
	sound $97 ; $42bb
	ld a, $03 ; $42bd
	ld d, $02 ; $42bf
	farcall FarPtr_0a_34 ; $42c1
	ld a, $03 ; $42c4
	farcall FarPtr_0a_36 ; $42c6
	ld a, $05 ; $42c9
	ld bc, $0100 ; $42cb
	ld de, $0100 ; $42ce
	farcall FarPtr_0a_22 ; $42d1
	ld a, $03 ; $42d4
	farcall FarPtr_0a_08 ; $42d6
	ld a, $03 ; $42d9
	ld bc, $1600 ; $42db
	ld de, $0b00 ; $42de
	farcall FarPtr_0a_24 ; $42e1
	ld a, $03 ; $42e4
	farcall FarPtr_0a_20 ; $42e6
	ld a, $04 ; $42e9
	ld bc, $1700 ; $42eb
	ld de, $0b00 ; $42ee
	farcall FarPtr_0a_22 ; $42f1
	push af ; $42f4
	ld a, $a0 ; $42f5
	farcall FarPtr_0a_04 ; $42f7
	pop af ; $42fa
	ld a, $00 ; $42fb
	ld bc, $1600 ; $42fd
	ld de, $1500 ; $4300
	farcall FarPtr_0a_24 ; $4303
	ld a, $00 ; $4306
	farcall FarPtr_0a_20 ; $4308
	ld a, $00 ; $430b
	ld b, $40 ; $430d
	farcall FarPtr_0a_2e ; $430f
	push af ; $4312
	ld a, $14 ; $4313
	farcall FarPtr_0a_04 ; $4315
	pop af ; $4318
	ld a, $00 ; $4319
	ld d, $04 ; $431b
	farcall FarPtr_0a_34 ; $431d
	ld a, $00 ; $4320
	farcall FarPtr_0a_36 ; $4322
	ld a, $00 ; $4325
	ld b, $c0 ; $4327
	farcall FarPtr_0a_2e ; $4329
	push af ; $432c
	ld a, $a0 ; $432d
	farcall FarPtr_0a_04 ; $432f
	pop af ; $4332
	ld a, $00 ; $4333
	ld b, $40 ; $4335
	farcall FarPtr_0a_2e ; $4337
	push af ; $433a
	ld a, $14 ; $433b
	farcall FarPtr_0a_04 ; $433d
	pop af ; $4340
	ld a, $00 ; $4341
	ld d, $04 ; $4343
	farcall FarPtr_0a_34 ; $4345
	ld a, $00 ; $4348
	farcall FarPtr_0a_36 ; $434a
	push af ; $434d
	ld a, $14 ; $434e
	farcall FarPtr_0a_04 ; $4350
	pop af ; $4353
	ld a, $03 ; $4354
	ld b, $00 ; $4356
	farcall FarPtr_0a_48 ; $4358
	ld a, $03 ; $435b
	ld bc, $1700 ; $435d
	ld de, $1900 ; $4360
	farcall FarPtr_0a_22 ; $4363
	ld a, $03 ; $4366
	farcall FarPtr_0a_08 ; $4368
	ld a, $00 ; $436b
	ld bc, $1680 ; $436d
	ld de, $1200 ; $4370
	farcall FarPtr_0a_24 ; $4373
	ld a, $00 ; $4376
	ld de, $ff80 ; $4378
	farcall FarPtr_0a_42 ; $437b
	ld a, $00 ; $437e
	farcall FarPtr_0a_44 ; $4380
	ld a, $00 ; $4383
	ld b, $c0 ; $4385
	farcall FarPtr_0a_2e ; $4387
	ld a, $03 ; $438a
	ld b, $02 ; $438c
	farcall FarPtr_0a_48 ; $438e
	ld a, $03 ; $4391
	ld bc, $1500 ; $4393
	ld de, $0b00 ; $4396
	farcall FarPtr_0a_22 ; $4399
	ld a, [$c94d] ; $439c
	or a, a ; $439f
	jr nz, Label_12_43bb ; $43a0
	ld hl, $045c ; $43a2
	farcall FarPtr_0a_0e ; $43a5
	ld d, $28 ; $43a8
	ld a, $04 ; $43aa
	farcall FarPtr_0a_16 ; $43ac
	ld c, l ; $43af
	ld b, h ; $43b0
	farcall FarPtr_04_2c ; $43b1
	ld a, $04 ; $43b4
	ld d, $01 ; $43b6
	farcall FarPtr_0a_34 ; $43b8
Label_12_43bb:
	ld a, $03 ; $43bb
	ld bc, $1500 ; $43bd
	ld de, $0f00 ; $43c0
	farcall FarPtr_0a_24 ; $43c3
	ld a, $03 ; $43c6
	farcall FarPtr_0a_20 ; $43c8
	ld a, $04 ; $43cb
	ld bc, $1700 ; $43cd
	ld de, $0f00 ; $43d0
	farcall FarPtr_0a_24 ; $43d3
	ld a, $04 ; $43d6
	farcall FarPtr_0a_20 ; $43d8
	ld a, $06 ; $43db
	ld bc, $1800 ; $43dd
	ld de, $1100 ; $43e0
	farcall FarPtr_0a_22 ; $43e3
	sound $98 ; $43e6
	push af ; $43e8
	ld a, $3c ; $43e9
	farcall FarPtr_0a_04 ; $43eb
	pop af ; $43ee
	ld a, $03 ; $43ef
	ld d, $04 ; $43f1
	farcall FarPtr_0a_34 ; $43f3
	ld a, $03 ; $43f6
	farcall FarPtr_0a_36 ; $43f8
	ld a, $06 ; $43fb
	ld bc, $0100 ; $43fd
	ld de, $0100 ; $4400
	farcall FarPtr_0a_22 ; $4403
	ld a, $03 ; $4406
	farcall FarPtr_0a_08 ; $4408
	ld a, $04 ; $440b
	ld b, a ; $440d
	ld a, $03 ; $440e
	farcall FarPtr_0a_30 ; $4410
	push af ; $4413
	ld a, $3c ; $4414
	farcall FarPtr_0a_04 ; $4416
	pop af ; $4419
	ld a, $00 ; $441a
	ld b, a ; $441c
	ld a, $03 ; $441d
	farcall FarPtr_0a_30 ; $441f
	ld a, $03 ; $4422
	farcall FarPtr_0a_08 ; $4424
	ld a, $04 ; $4427
	ld d, $03 ; $4429
	farcall FarPtr_0a_34 ; $442b
	ld a, $04 ; $442e
	farcall FarPtr_0a_36 ; $4430
	ld a, $04 ; $4433
	farcall FarPtr_0a_08 ; $4435
	ld a, $00 ; $4438
	ld d, $03 ; $443a
	farcall FarPtr_0a_34 ; $443c
	ld a, $00 ; $443f
	farcall FarPtr_0a_36 ; $4441
	push af ; $4444
	ld a, $14 ; $4445
	farcall FarPtr_0a_04 ; $4447
	pop af ; $444a
	ld a, $03 ; $444b
	ld d, $03 ; $444d
	farcall FarPtr_0a_34 ; $444f
	ld a, $03 ; $4452
	farcall FarPtr_0a_36 ; $4454
	ld a, $03 ; $4457
	farcall FarPtr_0a_08 ; $4459
	ld a, $03 ; $445c
	ld b, a ; $445e
	ld a, $04 ; $445f
	farcall FarPtr_0a_30 ; $4461
	ld a, $04 ; $4464
	ld d, $04 ; $4466
	farcall FarPtr_0a_34 ; $4468
	ld a, $04 ; $446b
	farcall FarPtr_0a_36 ; $446d
	ld a, $04 ; $4470
	farcall FarPtr_0a_08 ; $4472
	ld a, $04 ; $4475
	ld b, a ; $4477
	ld a, $03 ; $4478
	farcall FarPtr_0a_30 ; $447a
	ld a, $03 ; $447d
	farcall FarPtr_0a_08 ; $447f
	ld a, $04 ; $4482
	ld d, $03 ; $4484
	farcall FarPtr_0a_34 ; $4486
	ld a, $04 ; $4489
	farcall FarPtr_0a_36 ; $448b
	ld a, $00 ; $448e
	ld b, a ; $4490
	ld a, $04 ; $4491
	farcall FarPtr_0a_30 ; $4493
	ld a, $04 ; $4496
	farcall FarPtr_0a_0a ; $4498
	ld a, $00 ; $449b
	ld b, a ; $449d
	ld a, $03 ; $449e
	farcall FarPtr_0a_30 ; $44a0
	farcall FarPtr_0a_12 ; $44a3
	farcall FarPtr_0a_0c ; $44a6
	push af ; $44a9
	ld a, $05 ; $44aa
	farcall FarPtr_0a_04 ; $44ac
	pop af ; $44af
	and a, a ; $44b0
	jr nz, Label_12_44bd ; $44b1
	ld a, $04 ; $44b3
	farcall FarPtr_0a_08 ; $44b5
	farcall FarPtr_0a_10 ; $44b8
	jr Label_12_44c5 ; $44bb
Label_12_44bd:
	farcall FarPtr_0a_10 ; $44bd
	ld a, $04 ; $44c0
	farcall FarPtr_0a_08 ; $44c2
Label_12_44c5:
	ld a, $03 ; $44c5
	ld d, $03 ; $44c7
	farcall FarPtr_0a_34 ; $44c9
	ld a, $03 ; $44cc
	farcall FarPtr_0a_36 ; $44ce
	ld a, $03 ; $44d1
	farcall FarPtr_0a_08 ; $44d3
	ld a, $04 ; $44d6
	ld d, $03 ; $44d8
	farcall FarPtr_0a_34 ; $44da
	ld a, $04 ; $44dd
	farcall FarPtr_0a_36 ; $44df
	ld a, $03 ; $44e2
	ld d, $02 ; $44e4
	farcall FarPtr_0a_34 ; $44e6
	ld a, $03 ; $44e9
	farcall FarPtr_0a_36 ; $44eb
	ld a, $03 ; $44ee
	farcall FarPtr_0a_08 ; $44f0
	ld a, $06 ; $44f3
	ld bc, $1800 ; $44f5
	ld de, $1100 ; $44f8
	farcall FarPtr_0a_22 ; $44fb
	sound $98 ; $44fe
	push af ; $4500
	ld a, $3c ; $4501
	farcall FarPtr_0a_04 ; $4503
	pop af ; $4506
	ld a, $06 ; $4507
	ld bc, $0100 ; $4509
	ld de, $0100 ; $450c
	farcall FarPtr_0a_22 ; $450f
	ld a, $04 ; $4512
	ld d, $03 ; $4514
	farcall FarPtr_0a_34 ; $4516
	ld a, $04 ; $4519
	farcall FarPtr_0a_36 ; $451b
	ld a, $04 ; $451e
	farcall FarPtr_0a_08 ; $4520
	ld a, $04 ; $4523
	ld b, a ; $4525
	ld a, $03 ; $4526
	farcall FarPtr_0a_30 ; $4528
	push af ; $452b
	ld a, $1e ; $452c
	farcall FarPtr_0a_04 ; $452e
	pop af ; $4531
	ld a, $00 ; $4532
	ld b, a ; $4534
	ld a, $03 ; $4535
	farcall FarPtr_0a_30 ; $4537
	push af ; $453a
	ld a, $1e ; $453b
	farcall FarPtr_0a_04 ; $453d
	pop af ; $4540
	ld a, $03 ; $4541
	ld d, $03 ; $4543
	farcall FarPtr_0a_34 ; $4545
	ld a, $03 ; $4548
	farcall FarPtr_0a_36 ; $454a
	ld hl, $045a ; $454d
	farcall FarPtr_0a_0e ; $4550
	ld a, $04 ; $4553
	farcall FarPtr_0a_08 ; $4555
	ld a, $03 ; $4558
	ld b, a ; $455a
	ld a, $04 ; $455b
	farcall FarPtr_0a_30 ; $455d
	ld a, $00 ; $4560
	ld d, $03 ; $4562
	farcall FarPtr_0a_34 ; $4564
	ld a, $04 ; $4567
	ld d, $03 ; $4569
	farcall FarPtr_0a_34 ; $456b
	ld a, $04 ; $456e
	farcall FarPtr_0a_36 ; $4570
	xor a, a ; $4573
	ld bc, $1600 ; $4574
	ld de, $1300 ; $4577
	farcall FarPtr_0a_3a ; $457a
	ld a, $03 ; $457d
	ld bc, $1500 ; $457f
	ld de, $1300 ; $4582
	farcall FarPtr_0a_24 ; $4585
	ld a, $03 ; $4588
	farcall FarPtr_0a_20 ; $458a
	ld a, $04 ; $458d
	ld b, $40 ; $458f
	farcall FarPtr_0a_2e ; $4591
	ld a, $00 ; $4594
	ld b, $40 ; $4596
	farcall FarPtr_0a_2e ; $4598
	ld a, $03 ; $459b
	ld bc, $1500 ; $459d
	ld de, $1500 ; $45a0
	farcall FarPtr_0a_24 ; $45a3
	ld a, $03 ; $45a6
	farcall FarPtr_0a_20 ; $45a8
	ld a, $03 ; $45ab
	ld b, $c0 ; $45ad
	farcall FarPtr_0a_2e ; $45af
	ld a, $00 ; $45b2
	ld b, $40 ; $45b4
	farcall FarPtr_0a_2e ; $45b6
	ld a, $04 ; $45b9
	farcall FarPtr_0a_08 ; $45bb
	ld a, $00 ; $45be
	ld d, $03 ; $45c0
	farcall FarPtr_0a_34 ; $45c2
	ld a, $04 ; $45c5
	ld d, $03 ; $45c7
	farcall FarPtr_0a_34 ; $45c9
	ld a, $04 ; $45cc
	farcall FarPtr_0a_36 ; $45ce
	ld a, $03 ; $45d1
	ld d, $03 ; $45d3
	farcall FarPtr_0a_34 ; $45d5
	ld a, $03 ; $45d8
	farcall FarPtr_0a_36 ; $45da
	ld a, $03 ; $45dd
	ld b, $40 ; $45df
	farcall FarPtr_0a_2e ; $45e1
	push af ; $45e4
	ld a, $1e ; $45e5
	farcall FarPtr_0a_04 ; $45e7
	pop af ; $45ea
	ld a, $03 ; $45eb
	ld bc, $1500 ; $45ed
	ld de, $1f00 ; $45f0
	farcall FarPtr_0a_24 ; $45f3
	push af ; $45f6
	ld a, $78 ; $45f7
	farcall FarPtr_0a_04 ; $45f9
	pop af ; $45fc
	ld a, $00 ; $45fd
	ld b, a ; $45ff
	ld a, $04 ; $4600
	farcall FarPtr_0a_32 ; $4602
	ld a, $00 ; $4605
	ld d, $03 ; $4607
	farcall FarPtr_0a_34 ; $4609
	ld a, $04 ; $460c
	ld d, $03 ; $460e
	farcall FarPtr_0a_34 ; $4610
	ld a, $04 ; $4613
	farcall FarPtr_0a_36 ; $4615
	xor a, a ; $4618
	ld bc, $1500 ; $4619
	ld de, $0f00 ; $461c
	farcall FarPtr_0a_3a ; $461f
	ld a, $00 ; $4622
	ld bc, $1500 ; $4624
	ld de, $0f00 ; $4627
	farcall FarPtr_0a_24 ; $462a
	ld a, $00 ; $462d
	farcall FarPtr_0a_20 ; $462f
	ld a, $04 ; $4632
	ld bc, $1700 ; $4634
	ld de, $0b00 ; $4637
	farcall FarPtr_0a_24 ; $463a
	ld a, $00 ; $463d
	ld bc, $1500 ; $463f
	ld de, $0b00 ; $4642
	farcall FarPtr_0a_24 ; $4645
	ld a, $00 ; $4648
	farcall FarPtr_0a_20 ; $464a
	xor a, a ; $464d
	ld bc, $1600 ; $464e
	ld de, $0b00 ; $4651
	farcall FarPtr_0a_3a ; $4654
	ld b, $0a ; $4657
	ld c, $0f ; $4659
	farcall FarPtr_0a_62 ; $465b
	farcall FarPtr_03_18 ; $465e
	ld a, $01 ; $4661
	farcall FarPtr_03_16 ; $4663
	farcall FarPtr_03_18 ; $4666
	sound $00 ; $4669
	ld c, $04 ; $466b
	call Func_00_1d20 ; $466d
	call Func_00_1da4 ; $4670
	ld a, $0f ; $4673
	ld [$c294], a ; $4675
	ld [$c2a1], a ; $4678
	ret ; $467b
Data_12_467c:
	INCBIN "data/bank_012/d_467c.bin" ; $467c, 119 bytes
	ld a, [$c295] ; $46f3
	cp a, $ff ; $46f6
	jp z, Label_12_4715 ; $46f8
	clear_flag $0f, 5 ; $46fb
	test_flag $05, 7 ; $46fe
	jr z, Label_12_4715 ; $4701
	ld a, $02 ; $4703
	ld bc, $0f00 ; $4705
	ld de, $3b00 ; $4708
	farcall FarPtr_0a_22 ; $470b
	ld a, $02 ; $470e
	ld b, $c0 ; $4710
	farcall FarPtr_0a_2e ; $4712
Label_12_4715:
	ret ; $4715
	INCBIN "data/bank_012/d_4716.bin" ; $4716, 238 bytes
	ld a, $06 ; $4804
	farcall FarPtr_0a_08 ; $4806
	ret ; $4809
	INCBIN "data/bank_012/d_480a.bin" ; $480a, 55 bytes
Label_12_4841:
	ld c, $06 ; $4841
	call Func_00_1d2e ; $4843
	call Func_00_1da4 ; $4846
	xor a, a ; $4849
	ld [$c2d5], a ; $484a
	test_flag $1b, 5 ; $484d
	jr z, Label_12_485c ; $4850
	ld a, [wPointWinLoseFlag] ; $4852
	cp a, $01 ; $4855
	jr nz, Label_12_485c ; $4857
	jp Label_12_4936 ; $4859
Label_12_485c:
	ld c, $06 ; $485c
	call Func_00_1d2e ; $485e
	call Func_00_1da4 ; $4861
	xor a, a ; $4864
	ld [$c2d5], a ; $4865
	ld hl, wMinigamesCurrentScore ; $4868
	ld a, [hl+] ; $486b
	ld b, [hl] ; $486c
	ld c, a ; $486d
	ldh a, [hWramBank] ; $486e
	push af ; $4870
	wram_bank $07 ; $4871
	ld a, $00 ; $4877
	farcall FarPtr_03_2c ; $4879
	ld hl, $de00 ; $487c
	ld a, [hl+] ; $487f
	ld d, [hl] ; $4880
	ld e, a ; $4881
	pop af ; $4882
	wram_bank ; $4883
	ld l, c ; $4887
	ld h, b ; $4888
	inc de ; $4889
	ld a, l ; $488a
	sub a, e ; $488b
	ld l, a ; $488c
	ld a, h ; $488d
	sbc a, d ; $488e
	ld h, a ; $488f
	jp nc, Label_12_48eb ; $4890
	ld a, [wPointOutcome] ; $4893
	cp a, $09 ; $4896
	jr nz, Label_12_48a2 ; $4898
	ld hl, $14fa ; $489a
	farcall FarPtr_0a_0e ; $489d
	jr Label_12_48b5 ; $48a0
Label_12_48a2:
	ld a, [wPointOutcome] ; $48a2
	and a, $03 ; $48a5
	add a, a ; $48a7
	add a, $af ; $48a8
	ld l, a ; $48aa
	adc a, $4a ; $48ab
	sub a, l ; $48ad
	ld h, a ; $48ae
	ld a, [hl+] ; $48af
	ld h, [hl] ; $48b0
	ld l, a ; $48b1
	farcall FarPtr_0a_0e ; $48b2
Label_12_48b5:
	ld hl, wMinigamesCurrentScore ; $48b5
	ld a, [hl+] ; $48b8
	ld h, [hl] ; $48b9
	ld l, a ; $48ba
	farcall FarPtr_05_48 ; $48bb
	ld a, $07 ; $48be
	farcall FarPtr_0a_0a ; $48c0
	farcall FarPtr_0a_12 ; $48c3
	farcall FarPtr_0a_0c ; $48c6
	push af ; $48c9
	ld a, $05 ; $48ca
	farcall FarPtr_0a_04 ; $48cc
	pop af ; $48cf
	and a, a ; $48d0
	jp nz, Label_12_4b2e ; $48d1
	ld a, $07 ; $48d4
	ld b, $c0 ; $48d6
	farcall FarPtr_0a_2e ; $48d8
	ld a, $07 ; $48db
	ld d, $02 ; $48dd
	farcall FarPtr_0a_34 ; $48df
	ld a, $07 ; $48e2
	farcall FarPtr_0a_36 ; $48e4
	jp Label_12_528d ; $48e7
	INCBIN "data/bank_012/d_48ea.bin" ; $48ea, 1 bytes
Label_12_48eb:
	ldh a, [hWramBank] ; $48eb
	push af ; $48ed
	wram_bank $07 ; $48ee
	ld hl, wMinigamesCurrentScore ; $48f4
	ld a, [hl+] ; $48f7
	ld d, [hl] ; $48f8
	ld e, a ; $48f9
	ld hl, $de00 ; $48fa
	ld a, e ; $48fd
	ld [hl+], a ; $48fe
	ld [hl], d ; $48ff
	ld a, $00 ; $4900
	farcall FarPtr_03_2a ; $4902
	pop af ; $4905
	wram_bank ; $4906
	call Func_12_505f ; $490a
	ld hl, $1828 ; $490d
	farcall FarPtr_0a_0e ; $4910
	ld hl, wMinigamesCurrentScore ; $4913
	ld a, [hl+] ; $4916
	ld h, [hl] ; $4917
	ld l, a ; $4918
	farcall FarPtr_05_48 ; $4919
	ld a, $07 ; $491c
	farcall FarPtr_0a_0a ; $491e
	farcall FarPtr_0a_12 ; $4921
	farcall FarPtr_0a_0c ; $4924
	push af ; $4927
	ld a, $05 ; $4928
	farcall FarPtr_0a_04 ; $492a
	pop af ; $492d
	and a, a ; $492e
	jp nz, Label_12_4b2e ; $492f
	jp Label_12_528d ; $4932
	INCBIN "data/bank_012/d_4935.bin" ; $4935, 1 bytes
Label_12_4936:
	ld hl, $1829 ; $4936
	farcall FarPtr_0a_0e ; $4939
	ld a, $07 ; $493c
	farcall FarPtr_0a_08 ; $493e
	ldh a, [hWramBank] ; $4941
	push af ; $4943
	wram_bank $07 ; $4944
	ld a, $00 ; $494a
	farcall FarPtr_03_2c ; $494c
	ld hl, $de00 ; $494f
	ld a, [hl+] ; $4952
	ld h, [hl] ; $4953
	ld l, a ; $4954
	pop af ; $4955
	wram_bank ; $4956
	ld de, $270f ; $495a
	ld a, l ; $495d
	sub a, e ; $495e
	ld l, a ; $495f
	ld a, h ; $4960
	sbc a, d ; $4961
	ld h, a ; $4962
	jp c, Label_12_49e5 ; $4963
	ld hl, $182b ; $4966
	farcall FarPtr_0a_0e ; $4969
	ld a, $07 ; $496c
	farcall FarPtr_0a_0a ; $496e
	farcall FarPtr_0a_12 ; $4971
	farcall FarPtr_0a_0c ; $4974
	push af ; $4977
	ld a, $05 ; $4978
	farcall FarPtr_0a_04 ; $497a
	pop af ; $497d
	and a, a ; $497e
	jr z, Label_12_49cd ; $497f
	ld a, $00 ; $4981
	ld bc, $0020 ; $4983
	farcall FarPtr_0a_18 ; $4986
	ld a, $00 ; $4989
	ld bc, $0500 ; $498b
	ld de, $3100 ; $498e
	farcall FarPtr_0a_24 ; $4991
	ld a, $00 ; $4994
	farcall FarPtr_0a_20 ; $4996
	xor a, a ; $4999
	ld bc, $0500 ; $499a
	ld de, $3700 ; $499d
	farcall FarPtr_0a_3a ; $49a0
	ld a, $00 ; $49a3
	ld bc, $0500 ; $49a5
	ld de, $3900 ; $49a8
	farcall FarPtr_0a_24 ; $49ab
	ld a, $00 ; $49ae
	farcall FarPtr_0a_20 ; $49b0
	ld a, $07 ; $49b3
	ld bc, $0500 ; $49b5
	ld de, $3700 ; $49b8
	farcall FarPtr_0a_24 ; $49bb
	ld a, $07 ; $49be
	farcall FarPtr_0a_20 ; $49c0
	ld a, $07 ; $49c3
	ld b, $40 ; $49c5
	farcall FarPtr_0a_2e ; $49c7
	jp Label_12_4a6c ; $49ca
Label_12_49cd:
	ld a, $13 ; $49cd
	ld [wStoryModeCurrentLocation], a ; $49cf
	ld a, $0a ; $49d2
	ld [$c295], a ; $49d4
	ld a, $ff ; $49d7
	ld [$c294], a ; $49d9
	ld [$c2a1], a ; $49dc
	ld a, $1b ; $49df
	farcall FarPtr_0b_00 ; $49e1
	ret ; $49e4
Label_12_49e5:
	ldh a, [hWramBank] ; $49e5
	push af ; $49e7
	wram_bank $07 ; $49e8
	ld hl, wMinigamesCurrentScore ; $49ee
	ld a, [hl+] ; $49f1
	ld d, [hl] ; $49f2
	ld e, a ; $49f3
	ld hl, $de00 ; $49f4
	ld a, e ; $49f7
	ld [hl+], a ; $49f8
	ld [hl], d ; $49f9
	ld a, $00 ; $49fa
	farcall FarPtr_03_2a ; $49fc
	pop af ; $49ff
	wram_bank ; $4a00
	ld a, $00 ; $4a04
	ld bc, $0020 ; $4a06
	farcall FarPtr_0a_18 ; $4a09
	ld a, $00 ; $4a0c
	ld bc, $0500 ; $4a0e
	ld de, $3100 ; $4a11
	farcall FarPtr_0a_24 ; $4a14
	ld a, $00 ; $4a17
	farcall FarPtr_0a_20 ; $4a19
	xor a, a ; $4a1c
	ld bc, $0500 ; $4a1d
	ld de, $3700 ; $4a20
	farcall FarPtr_0a_3a ; $4a23
	ld a, $00 ; $4a26
	ld bc, $0500 ; $4a28
	ld de, $3900 ; $4a2b
	farcall FarPtr_0a_24 ; $4a2e
	ld a, $00 ; $4a31
	farcall FarPtr_0a_20 ; $4a33
	ld a, $07 ; $4a36
	ld bc, $0500 ; $4a38
	ld de, $3700 ; $4a3b
	farcall FarPtr_0a_24 ; $4a3e
	ld a, $07 ; $4a41
	farcall FarPtr_0a_20 ; $4a43
	ld a, $07 ; $4a46
	ld b, $40 ; $4a48
	farcall FarPtr_0a_2e ; $4a4a
	ld a, $00 ; $4a4d
	ld b, $c0 ; $4a4f
	farcall FarPtr_0a_2e ; $4a51
	push af ; $4a54
	ld a, $32 ; $4a55
	farcall FarPtr_0a_04 ; $4a57
	pop af ; $4a5a
	ld a, $07 ; $4a5b
	ld d, $02 ; $4a5d
	farcall FarPtr_0a_34 ; $4a5f
	ld a, $07 ; $4a62
	farcall FarPtr_0a_36 ; $4a64
	ld a, $07 ; $4a67
	farcall FarPtr_0a_08 ; $4a69
Label_12_4a6c:
	test_flag $05, 7 ; $4a6c
	jr z, Label_12_4aae ; $4a6f
	push af ; $4a71
	ld a, $28 ; $4a72
	farcall FarPtr_0a_04 ; $4a74
	pop af ; $4a77
	ld a, $02 ; $4a78
	ld b, a ; $4a7a
	ld a, $00 ; $4a7b
	farcall FarPtr_0a_32 ; $4a7d
	push af ; $4a80
	ld a, $1e ; $4a81
	farcall FarPtr_0a_04 ; $4a83
	pop af ; $4a86
	ld a, $00 ; $4a87
	ld d, $03 ; $4a89
	farcall FarPtr_0a_34 ; $4a8b
	ld a, $02 ; $4a8e
	ld d, $03 ; $4a90
	farcall FarPtr_0a_34 ; $4a92
	ld a, $02 ; $4a95
	farcall FarPtr_0a_36 ; $4a97
	ld a, $02 ; $4a9a
	farcall FarPtr_0a_16 ; $4a9c
	ld c, l ; $4a9f
	ld b, h ; $4aa0
	ld de, $d000 ; $4aa1
	farcall FarPtr_04_20 ; $4aa4
	push af ; $4aa7
	ld a, $28 ; $4aa8
	farcall FarPtr_0a_04 ; $4aaa
	pop af ; $4aad
Label_12_4aae:
	ret ; $4aae
	INCBIN "data/bank_012/d_4aaf.bin" ; $4aaf, 6 bytes
Label_12_4ab5:
	xor a, a ; $4ab5
	ld [$c2d5], a ; $4ab6
	ld a, [wPointWinLoseFlag] ; $4ab9
	cp a, $01 ; $4abc
	jp nz, Label_12_4ad0 ; $4abe
	ld a, [$c2b0] ; $4ac1
	sub a, $01 ; $4ac4
	ld a, a ; $4ac6
	rst Rst00 ; $4ac7
	dw Label_12_4bee ; $4ac8 jumptable
	dw Label_12_4bde ; $4aca jumptable
	dw Label_12_4bb2 ; $4acc jumptable
	dw Label_12_4ba2 ; $4ace jumptable
Label_12_4ad0:
	ld a, [$c2b0] ; $4ad0
	cp a, $04 ; $4ad3
	jp z, Label_12_485c ; $4ad5
	ld c, $06 ; $4ad8
	call Func_00_1d2e ; $4ada
	call Func_00_1da4 ; $4add
	ld a, [wPointOutcome] ; $4ae0
	cp a, $09 ; $4ae3
	jr nz, Label_12_4aef ; $4ae5
	ld hl, $14f6 ; $4ae7
	farcall FarPtr_0a_0e ; $4aea
	jr Label_12_4b02 ; $4aed
Label_12_4aef:
	ld a, [wPointOutcome] ; $4aef
	and a, $03 ; $4af2
	add a, a ; $4af4
	add a, $9c ; $4af5
	ld l, a ; $4af7
	adc a, $4b ; $4af8
	sub a, l ; $4afa
	ld h, a ; $4afb
	ld a, [hl+] ; $4afc
	ld h, [hl] ; $4afd
	ld l, a ; $4afe
	farcall FarPtr_0a_0e ; $4aff
Label_12_4b02:
	ld a, $07 ; $4b02
	farcall FarPtr_0a_0a ; $4b04
	farcall FarPtr_0a_12 ; $4b07
	farcall FarPtr_0a_0c ; $4b0a
	push af ; $4b0d
	ld a, $05 ; $4b0e
	farcall FarPtr_0a_04 ; $4b10
	pop af ; $4b13
	and a, a ; $4b14
	jp nz, Label_12_4b2e ; $4b15
	ld a, $07 ; $4b18
	ld b, $c0 ; $4b1a
	farcall FarPtr_0a_2e ; $4b1c
	ld a, $07 ; $4b1f
	ld d, $02 ; $4b21
	farcall FarPtr_0a_34 ; $4b23
	ld a, $07 ; $4b26
	farcall FarPtr_0a_36 ; $4b28
	jp Label_12_528d ; $4b2b
Label_12_4b2e:
	ld hl, $14fb ; $4b2e
	farcall FarPtr_0a_0e ; $4b31
	ld a, $07 ; $4b34
	farcall FarPtr_0a_08 ; $4b36
	ld a, $00 ; $4b39
	ld bc, $0020 ; $4b3b
	farcall FarPtr_0a_18 ; $4b3e
	ld a, $00 ; $4b41
	ld bc, $0500 ; $4b43
	ld de, $3100 ; $4b46
	farcall FarPtr_0a_24 ; $4b49
	ld a, $00 ; $4b4c
	farcall FarPtr_0a_20 ; $4b4e
	xor a, a ; $4b51
	ld bc, $0500 ; $4b52
	ld de, $3700 ; $4b55
	farcall FarPtr_0a_3a ; $4b58
	ld a, $00 ; $4b5b
	ld bc, $0500 ; $4b5d
	ld de, $3900 ; $4b60
	farcall FarPtr_0a_24 ; $4b63
	ld a, $00 ; $4b66
	farcall FarPtr_0a_20 ; $4b68
	ld a, $07 ; $4b6b
	ld bc, $0500 ; $4b6d
	ld de, $3700 ; $4b70
	farcall FarPtr_0a_24 ; $4b73
	ld a, $07 ; $4b76
	farcall FarPtr_0a_20 ; $4b78
	ld a, $07 ; $4b7b
	ld b, $40 ; $4b7d
	farcall FarPtr_0a_2e ; $4b7f
	test_flag $05, 7 ; $4b82
	jr z, Label_12_4b94 ; $4b85
	ld a, $02 ; $4b87
	farcall FarPtr_0a_16 ; $4b89
	ld c, l ; $4b8c
	ld b, h ; $4b8d
	ld de, $d000 ; $4b8e
	farcall FarPtr_04_20 ; $4b91
Label_12_4b94:
	push af ; $4b94
	ld a, $0a ; $4b95
	farcall FarPtr_0a_04 ; $4b97
	pop af ; $4b9a
	ret ; $4b9b
	INCBIN "data/bank_012/d_4b9c.bin" ; $4b9c, 6 bytes
Label_12_4ba2:
	ld hl, $14ff ; $4ba2
	farcall FarPtr_0a_0e ; $4ba5
	ld c, $06 ; $4ba8
	call Func_00_1d2e ; $4baa
	call Func_00_1da4 ; $4bad
	jr Label_12_4bfc ; $4bb0
Label_12_4bb2:
	ldh a, [hWramBank] ; $4bb2
	push af ; $4bb4
	wram_bank $07 ; $4bb5
	ld de, $0032 ; $4bbb
	ld hl, $de00 ; $4bbe
	ld a, e ; $4bc1
	ld [hl+], a ; $4bc2
	ld [hl], d ; $4bc3
	ld a, $00 ; $4bc4
	farcall FarPtr_03_2a ; $4bc6
	pop af ; $4bc9
	wram_bank ; $4bca
	ld hl, $14fe ; $4bce
	farcall FarPtr_0a_0e ; $4bd1
	ld c, $06 ; $4bd4
	call Func_00_1d2e ; $4bd6
	call Func_00_1da4 ; $4bd9
	jr Label_12_4bfc ; $4bdc
Label_12_4bde:
	ld hl, $14fd ; $4bde
	farcall FarPtr_0a_0e ; $4be1
	ld c, $06 ; $4be4
	call Func_00_1d2e ; $4be6
	call Func_00_1da4 ; $4be9
	jr Label_12_4bfc ; $4bec
Label_12_4bee:
	ld hl, $14fc ; $4bee
	farcall FarPtr_0a_0e ; $4bf1
	ld c, $06 ; $4bf4
	call Func_00_1d2e ; $4bf6
	call Func_00_1da4 ; $4bf9
Label_12_4bfc:
	ld a, $07 ; $4bfc
	ld d, $02 ; $4bfe
	farcall FarPtr_0a_34 ; $4c00
	ld a, $07 ; $4c03
	farcall FarPtr_0a_36 ; $4c05
	ld a, $07 ; $4c08
	farcall FarPtr_0a_08 ; $4c0a
	ld a, $00 ; $4c0d
	ld bc, $0020 ; $4c0f
	farcall FarPtr_0a_18 ; $4c12
	ld a, $00 ; $4c15
	ld bc, $0500 ; $4c17
	ld de, $3100 ; $4c1a
	farcall FarPtr_0a_24 ; $4c1d
	ld a, $00 ; $4c20
	farcall FarPtr_0a_20 ; $4c22
	xor a, a ; $4c25
	ld bc, $0500 ; $4c26
	ld de, $3700 ; $4c29
	farcall FarPtr_0a_3a ; $4c2c
	ld a, $00 ; $4c2f
	ld bc, $0500 ; $4c31
	ld de, $3900 ; $4c34
	farcall FarPtr_0a_24 ; $4c37
	ld a, $00 ; $4c3a
	farcall FarPtr_0a_20 ; $4c3c
	ld a, $07 ; $4c3f
	ld bc, $0500 ; $4c41
	ld de, $3700 ; $4c44
	farcall FarPtr_0a_24 ; $4c47
	ld a, $07 ; $4c4a
	farcall FarPtr_0a_20 ; $4c4c
	ld a, $07 ; $4c4f
	ld b, $40 ; $4c51
	farcall FarPtr_0a_2e ; $4c53
	test_flag $05, 7 ; $4c56
	jr z, Label_12_4c98 ; $4c59
	push af ; $4c5b
	ld a, $1e ; $4c5c
	farcall FarPtr_0a_04 ; $4c5e
	pop af ; $4c61
	ld a, $02 ; $4c62
	ld b, a ; $4c64
	ld a, $00 ; $4c65
	farcall FarPtr_0a_32 ; $4c67
	push af ; $4c6a
	ld a, $1e ; $4c6b
	farcall FarPtr_0a_04 ; $4c6d
	pop af ; $4c70
	ld a, $00 ; $4c71
	ld d, $03 ; $4c73
	farcall FarPtr_0a_34 ; $4c75
	ld a, $02 ; $4c78
	ld d, $03 ; $4c7a
	farcall FarPtr_0a_34 ; $4c7c
	ld a, $02 ; $4c7f
	farcall FarPtr_0a_36 ; $4c81
	ld a, $02 ; $4c84
	farcall FarPtr_0a_16 ; $4c86
	ld c, l ; $4c89
	ld b, h ; $4c8a
	ld de, $d000 ; $4c8b
	farcall FarPtr_04_20 ; $4c8e
	push af ; $4c91
	ld a, $14 ; $4c92
	farcall FarPtr_0a_04 ; $4c94
	pop af ; $4c97
Label_12_4c98:
	push af ; $4c98
	ld a, $0a ; $4c99
	farcall FarPtr_0a_04 ; $4c9b
	pop af ; $4c9e
	ret ; $4c9f
	INCBIN "data/bank_012/d_4ca0.bin" ; $4ca0, 86 bytes
	farcall FarPtr_0a_20 ; $4cf6
	ld a, $07 ; $4cf9
	ld bc, $0500 ; $4cfb
	ld de, $3700 ; $4cfe
	farcall FarPtr_0a_24 ; $4d01
	ld a, $07 ; $4d04
	farcall FarPtr_0a_20 ; $4d06
	ld a, $07 ; $4d09
	ld b, $40 ; $4d0b
	farcall FarPtr_0a_2e ; $4d0d
	clear_flag $1c, 0 ; $4d10
	clear_flag $0f, 5 ; $4d13
	test_flag $05, 7 ; $4d16
	jr z, Label_12_4d28 ; $4d19
	ld a, $02 ; $4d1b
	farcall FarPtr_0a_16 ; $4d1d
	ld c, l ; $4d20
	ld b, h ; $4d21
	ld de, $d000 ; $4d22
	farcall FarPtr_04_20 ; $4d25
Label_12_4d28:
	ret ; $4d28
	INCBIN "data/bank_012/d_4d29.bin" ; $4d29, 477 bytes
	ld a, $00 ; $4f06
	ld [$c329], a ; $4f08
	ld a, $27 ; $4f0b
	ld [$c32a], a ; $4f0d
	ld a, $18 ; $4f10
	ld [$c32b], a ; $4f12
	ld a, $3c ; $4f15
	ld [$c32c], a ; $4f17
	call DisableLCDSafely ; $4f1a
	ld a, $00 ; $4f1d
	farcall FarPtr_0a_76 ; $4f1f
	call EnableLCD ; $4f22
	call Func_12_505f ; $4f25
	ld a, [$c295] ; $4f28
	cp a, $0a ; $4f2b
	jp z, Label_12_4f39 ; $4f2d
	cp a, $0b ; $4f30
	jp z, Label_12_4f8a ; $4f32
	call Func_12_52c0 ; $4f35
	ret ; $4f38
Label_12_4f39:
	test_flag $05, 7 ; $4f39
	jr z, Label_12_4f55 ; $4f3c
	ld a, $02 ; $4f3e
	farcall FarPtr_0a_1c ; $4f40
	ld a, $02 ; $4f43
	ld bc, $0700 ; $4f45
	ld de, $3900 ; $4f48
	farcall FarPtr_0a_22 ; $4f4b
	ld a, $02 ; $4f4e
	ld b, $c0 ; $4f50
	farcall FarPtr_0a_2e ; $4f52
Label_12_4f55:
	ld a, $07 ; $4f55
	ld bc, $0300 ; $4f57
	ld de, $3700 ; $4f5a
	farcall FarPtr_0a_22 ; $4f5d
	ld a, $07 ; $4f60
	ld b, $00 ; $4f62
	farcall FarPtr_0a_2e ; $4f64
	ld a, [$c4c7] ; $4f67
	cp a, $01 ; $4f6a
	jp nz, Label_12_4f7e ; $4f6c
	ld c, $06 ; $4f6f
	call Func_00_1d2e ; $4f71
	call Func_00_1da4 ; $4f74
	xor a, a ; $4f77
	ld [$c2d5], a ; $4f78
	jp Label_12_4b2e ; $4f7b
Label_12_4f7e:
	ld a, [$c2b0] ; $4f7e
	cp a, $05 ; $4f81
	jp nc, Label_12_4841 ; $4f83
	jp Label_12_4ab5 ; $4f86
	INCBIN "data/bank_012/d_4f89.bin" ; $4f89, 1 bytes
Label_12_4f8a:
	test_flag $05, 7 ; $4f8a
	jr z, Label_12_4fa6 ; $4f8d
	ld a, $02 ; $4f8f
	farcall FarPtr_0a_1c ; $4f91
	ld a, $02 ; $4f94
	ld bc, $0700 ; $4f96
	ld de, $3900 ; $4f99
	farcall FarPtr_0a_22 ; $4f9c
	ld a, $02 ; $4f9f
	ld b, $c0 ; $4fa1
	farcall FarPtr_0a_2e ; $4fa3
Label_12_4fa6:
	set_flag $1c, 0 ; $4fa6
	ld a, $07 ; $4fa9
	ld bc, $0300 ; $4fab
	ld de, $3700 ; $4fae
	farcall FarPtr_0a_22 ; $4fb1
	ld a, $07 ; $4fb4
	ld b, $00 ; $4fb6
	farcall FarPtr_0a_2e ; $4fb8
	ld c, $06 ; $4fbb
	call Func_00_1d2e ; $4fbd
	call Func_00_1da4 ; $4fc0
	xor a, a ; $4fc3
	ld [$c2d5], a ; $4fc4
	ld a, [$c4c7] ; $4fc7
	cp a, $01 ; $4fca
	jp z, Label_12_505e ; $4fcc
	ld a, [wPointWinLoseFlag] ; $4fcf
	cp a, $01 ; $4fd2
	jr nz, Label_12_4ff3 ; $4fd4
	ld hl, $1835 ; $4fd6
	farcall FarPtr_0a_0e ; $4fd9
	ld a, $07 ; $4fdc
	farcall FarPtr_0a_0a ; $4fde
	farcall FarPtr_0a_12 ; $4fe1
	farcall FarPtr_0a_0c ; $4fe4
	push af ; $4fe7
	ld a, $05 ; $4fe8
	farcall FarPtr_0a_04 ; $4fea
	pop af ; $4fed
	and a, a ; $4fee
	jr nz, Label_12_505e ; $4fef
	jr Label_12_502b ; $4ff1
Label_12_4ff3:
	ld a, [wPointOutcome] ; $4ff3
	cp a, $09 ; $4ff6
	jr nz, Label_12_5002 ; $4ff8
	ld hl, $14f6 ; $4ffa
	farcall FarPtr_0a_0e ; $4ffd
	jr Label_12_5015 ; $5000
Label_12_5002:
	ld a, [wPointOutcome] ; $5002
	and a, $03 ; $5005
	add a, a ; $5007
	add a, $9c ; $5008
	ld l, a ; $500a
	adc a, $4b ; $500b
	sub a, l ; $500d
	ld h, a ; $500e
	ld a, [hl+] ; $500f
	ld h, [hl] ; $5010
	ld l, a ; $5011
	farcall FarPtr_0a_0e ; $5012
Label_12_5015:
	ld a, $07 ; $5015
	farcall FarPtr_0a_0a ; $5017
	farcall FarPtr_0a_12 ; $501a
	farcall FarPtr_0a_0c ; $501d
	push af ; $5020
	ld a, $05 ; $5021
	farcall FarPtr_0a_04 ; $5023
	pop af ; $5026
	and a, a ; $5027
	jp nz, Label_12_505e ; $5028
Label_12_502b:
	ld a, $07 ; $502b
	ld b, $c0 ; $502d
	farcall FarPtr_0a_2e ; $502f
	ld a, $07 ; $5032
	ld d, $02 ; $5034
	farcall FarPtr_0a_34 ; $5036
	ld a, $07 ; $5039
	farcall FarPtr_0a_36 ; $503b
	ld c, $04 ; $503e
	call Func_00_1d20 ; $5040
	call Func_00_1da4 ; $5043
	ld a, $13 ; $5046
	ld [wStoryModeCurrentLocation], a ; $5048
	ld a, $0b ; $504b
	ld [$c295], a ; $504d
	ld a, $ff ; $5050
	ld [$c294], a ; $5052
	ld [$c2a1], a ; $5055
	ld a, [$c8f7] ; $5058
	farcall FarPtr_0b_00 ; $505b
Label_12_505e:
	ret ; $505e
Func_12_505f:
	ld a, $00 ; $505f
	test_flag $1a, 6 ; $5061
	jp z, Label_12_50c8 ; $5064
	ld b, $1e ; $5067
	ld c, $2c ; $5069
	ld d, $02 ; $506b
	ld e, $2c ; $506d
	ld h, $02 ; $506f
	ld l, $02 ; $5071
	farcall FarPtr_0a_7e ; $5073
	ld a, $01 ; $5076
	test_flag $1a, 7 ; $5078
	jr z, Label_12_50c8 ; $507b
	ld b, $1e ; $507d
	ld c, $30 ; $507f
	ld d, $06 ; $5081
	ld e, $2c ; $5083
	ld h, $02 ; $5085
	ld l, $02 ; $5087
	farcall FarPtr_0a_7e ; $5089
	ld a, $02 ; $508c
	test_flag $1b, 0 ; $508e
	jr z, Label_12_50c8 ; $5091
	ld b, $1e ; $5093
	ld c, $34 ; $5095
	ld d, $10 ; $5097
	ld e, $2c ; $5099
	ld h, $02 ; $509b
	ld l, $02 ; $509d
	farcall FarPtr_0a_7e ; $509f
	ld a, $03 ; $50a2
	test_flag $1b, 1 ; $50a4
	jr z, Label_12_50c8 ; $50a7
	ld b, $1e ; $50a9
	ld c, $38 ; $50ab
	ld d, $14 ; $50ad
	ld e, $2c ; $50af
	ld h, $02 ; $50b1
	ld l, $02 ; $50b3
	farcall FarPtr_0a_7e ; $50b5
	ld a, $04 ; $50b8
	test_flag $1b, 3 ; $50ba
	jr z, Label_12_50c8 ; $50bd
	ld a, $05 ; $50bf
	test_flag $1b, 5 ; $50c1
	jr z, Label_12_50c8 ; $50c4
	ld a, $06 ; $50c6
Label_12_50c8:
	ld [$c2b0], a ; $50c8
	ret ; $50cb
	test_flag $1c, 0 ; $50cc
	jr z, Label_12_50dd ; $50cf
	ld hl, $1508 ; $50d1
	farcall FarPtr_0a_0e ; $50d4
	ld a, $07 ; $50d7
	farcall FarPtr_0a_08 ; $50d9
	ret ; $50dc
Label_12_50dd:
	ld a, [$c2b0] ; $50dd
	add a, a ; $50e0
	add a, $71 ; $50e1
	ld l, a ; $50e3
	adc a, $52 ; $50e4
	sub a, l ; $50e6
	ld h, a ; $50e7
	ld a, [hl+] ; $50e8
	ld h, [hl] ; $50e9
	ld l, a ; $50ea
	farcall FarPtr_0a_0e ; $50eb
	ld a, [$c2b0] ; $50ee
	cp a, $05 ; $50f1
	jr nz, Label_12_5111 ; $50f3
	ldh a, [hWramBank] ; $50f5
	push af ; $50f7
	wram_bank $07 ; $50f8
	ld a, $00 ; $50fe
	farcall FarPtr_03_2c ; $5100
	ld hl, $de00 ; $5103
	ld a, [hl+] ; $5106
	ld h, [hl] ; $5107
	ld l, a ; $5108
	pop af ; $5109
	wram_bank ; $510a
	farcall FarPtr_05_48 ; $510e
Label_12_5111:
	ld a, $07 ; $5111
	farcall FarPtr_0a_0a ; $5113
	farcall FarPtr_0a_12 ; $5116
	farcall FarPtr_0a_0c ; $5119
	push af ; $511c
	ld a, $05 ; $511d
	farcall FarPtr_0a_04 ; $511f
	pop af ; $5122
	and a, a ; $5123
	jp z, Label_12_51ba ; $5124
	ld a, [$c2b0] ; $5127
	add a, a ; $512a
	add a, $7f ; $512b
	ld l, a ; $512d
	adc a, $52 ; $512e
	sub a, l ; $5130
	ld h, a ; $5131
	ld a, [hl+] ; $5132
	ld h, [hl] ; $5133
	ld l, a ; $5134
	farcall FarPtr_0a_0e ; $5135
	ld a, $07 ; $5138
	farcall FarPtr_0a_0a ; $513a
	farcall FarPtr_0a_12 ; $513d
	farcall FarPtr_0a_0c ; $5140
	push af ; $5143
	ld a, $05 ; $5144
	farcall FarPtr_0a_04 ; $5146
	pop af ; $5149
	and a, a ; $514a
	jp nz, Label_12_51b1 ; $514b
	ld a, [$c2b0] ; $514e
	and a, a ; $5151
	jp z, Label_12_51b4 ; $5152
	ld a, $07 ; $5155
	ld bc, $0300 ; $5157
	ld de, $3700 ; $515a
	farcall FarPtr_0a_24 ; $515d
	ld a, $07 ; $5160
	farcall FarPtr_0a_20 ; $5162
	ld a, $07 ; $5165
	ld b, $00 ; $5167
	farcall FarPtr_0a_2e ; $5169
	ld a, $07 ; $516c
	farcall FarPtr_0a_08 ; $516e
	test_flag $05, 7 ; $5171
	jr z, Label_12_5192 ; $5174
	ld a, $02 ; $5176
	farcall FarPtr_0a_1c ; $5178
	ld a, $02 ; $517b
	ld bc, $0700 ; $517d
	ld de, $3900 ; $5180
	farcall FarPtr_0a_24 ; $5183
	ld a, $02 ; $5186
	farcall FarPtr_0a_20 ; $5188
	ld a, $02 ; $518b
	ld b, $c0 ; $518d
	farcall FarPtr_0a_2e ; $518f
Label_12_5192:
	ld a, $00 ; $5192
	ld bc, $0020 ; $5194
	farcall FarPtr_0a_18 ; $5197
	ld a, $00 ; $519a
	ld bc, $0500 ; $519c
	ld de, $3500 ; $519f
	farcall FarPtr_0a_24 ; $51a2
	ld a, $00 ; $51a5
	farcall FarPtr_0a_20 ; $51a7
	set_flag $1c, 0 ; $51aa
	set_flag $0f, 5 ; $51ad
	ret ; $51b0
Label_12_51b1:
	farcall FarPtr_0a_10 ; $51b1
Label_12_51b4:
	ld a, $07 ; $51b4
	farcall FarPtr_0a_08 ; $51b6
	ret ; $51b9
Label_12_51ba:
	ld a, $07 ; $51ba
	ld d, $03 ; $51bc
	farcall FarPtr_0a_34 ; $51be
	ld a, $07 ; $51c1
	farcall FarPtr_0a_36 ; $51c3
	ld a, $07 ; $51c6
	farcall FarPtr_0a_08 ; $51c8
	ld a, $07 ; $51cb
	ld bc, $0300 ; $51cd
	ld de, $3700 ; $51d0
	farcall FarPtr_0a_24 ; $51d3
	ld a, $07 ; $51d6
	farcall FarPtr_0a_20 ; $51d8
	ld a, $07 ; $51db
	ld b, $00 ; $51dd
	farcall FarPtr_0a_2e ; $51df
	test_flag $05, 7 ; $51e2
	jr z, Label_12_522c ; $51e5
	push af ; $51e7
	ld a, $14 ; $51e8
	farcall FarPtr_0a_04 ; $51ea
	pop af ; $51ed
	ld a, $02 ; $51ee
	farcall FarPtr_0a_1c ; $51f0
	ld a, $02 ; $51f3
	ld bc, $0700 ; $51f5
	ld de, $3900 ; $51f8
	farcall FarPtr_0a_24 ; $51fb
	ld a, $02 ; $51fe
	farcall FarPtr_0a_20 ; $5200
	ld a, $02 ; $5203
	ld b, a ; $5205
	ld a, $00 ; $5206
	farcall FarPtr_0a_32 ; $5208
	push af ; $520b
	ld a, $1e ; $520c
	farcall FarPtr_0a_04 ; $520e
	pop af ; $5211
	ld a, $00 ; $5212
	ld d, $03 ; $5214
	farcall FarPtr_0a_34 ; $5216
	ld a, $02 ; $5219
	ld d, $03 ; $521b
	farcall FarPtr_0a_34 ; $521d
	ld a, $02 ; $5220
	farcall FarPtr_0a_36 ; $5222
	push af ; $5225
	ld a, $14 ; $5226
	farcall FarPtr_0a_04 ; $5228
	pop af ; $522b
Label_12_522c:
	ld a, $00 ; $522c
	ld bc, $0020 ; $522e
	farcall FarPtr_0a_18 ; $5231
	ld a, $00 ; $5234
	ld bc, $0500 ; $5236
	ld de, $3700 ; $5239
	farcall FarPtr_0a_24 ; $523c
	ld a, $00 ; $523f
	farcall FarPtr_0a_20 ; $5241
	ld a, $00 ; $5244
	ld bc, $0500 ; $5246
	ld de, $3100 ; $5249
	farcall FarPtr_0a_24 ; $524c
	ld a, $00 ; $524f
	farcall FarPtr_0a_20 ; $5251
	ld a, $07 ; $5254
	ld b, $c0 ; $5256
	farcall FarPtr_0a_2e ; $5258
	ld a, $07 ; $525b
	ld d, $02 ; $525d
	farcall FarPtr_0a_34 ; $525f
	ld a, $00 ; $5262
	ld bc, $0c00 ; $5264
	ld de, $3100 ; $5267
	farcall FarPtr_0a_24 ; $526a
	jp Label_12_528d ; $526d
	INCBIN "data/bank_012/d_5270.bin" ; $5270, 29 bytes
Label_12_528d:
	ld c, $04 ; $528d
	call Func_00_1d20 ; $528f
	call Func_00_1da4 ; $5292
	ld a, $13 ; $5295
	ld [wStoryModeCurrentLocation], a ; $5297
	ld a, $0a ; $529a
	ld [$c295], a ; $529c
	ld a, $ff ; $529f
	ld [$c294], a ; $52a1
	ld [$c2a1], a ; $52a4
	ld a, [$c2b0] ; $52a7
	add a, $b9 ; $52aa
	ld l, a ; $52ac
	adc a, $52 ; $52ad
	sub a, l ; $52af
	ld h, a ; $52b0
	ld a, [hl] ; $52b1
	farcall FarPtr_0b_00 ; $52b2
	farcall FarPtr_0a_02 ; $52b5
	ret ; $52b8
	INCBIN "data/bank_012/d_52b9.bin" ; $52b9, 7 bytes
Func_12_52c0:
	test_flag $0f, 5 ; $52c0
	jr z, Label_12_52f6 ; $52c3
	set_flag $1c, 0 ; $52c5
	ld a, $07 ; $52c8
	ld bc, $0300 ; $52ca
	ld de, $3700 ; $52cd
	farcall FarPtr_0a_22 ; $52d0
	ld a, $07 ; $52d3
	ld b, $00 ; $52d5
	farcall FarPtr_0a_2e ; $52d7
	test_flag $05, 7 ; $52da
	jr z, Label_12_52f6 ; $52dd
	ld a, $02 ; $52df
	farcall FarPtr_0a_1c ; $52e1
	ld a, $02 ; $52e4
	ld bc, $0700 ; $52e6
	ld de, $3900 ; $52e9
	farcall FarPtr_0a_22 ; $52ec
	ld a, $02 ; $52ef
	ld b, $c0 ; $52f1
	farcall FarPtr_0a_2e ; $52f3
Label_12_52f6:
	ret ; $52f6
Data_12_52f7:
	INCBIN "data/bank_012/d_52f7.bin" ; $52f7, 1888 bytes
	farcall FarPtr_0a_0e ; $5a57
	ld a, [$c2b1] ; $5a5a
	cp a, $02 ; $5a5d
	jr nc, Label_12_5a68 ; $5a5f
	ld a, $09 ; $5a61
	ld b, $40 ; $5a63
	farcall FarPtr_0a_2e ; $5a65
Label_12_5a68:
	ld a, $09 ; $5a68
	farcall FarPtr_0a_08 ; $5a6a
	ret ; $5a6d
	INCBIN "data/bank_012/d_5a6e.bin" ; $5a6e, 1870 bytes
	farcall FarPtr_0a_04 ; $61bc
	pop af ; $61bf
	ld a, $00 ; $61c0
	ld b, $80 ; $61c2
	farcall FarPtr_0a_2e ; $61c4
	ld a, $07 ; $61c7
	ld b, $80 ; $61c9
	farcall FarPtr_0a_2e ; $61cb
	ldh a, [$ff95] ; $61ce
	ld b, a ; $61d0
	ld a, $05 ; $61d1
	ld de, $796f ; $61d3
	farcall FarPtr_0a_1a ; $61d6
	ldh a, [$ff95] ; $61d9
	ld b, a ; $61db
	ld a, $04 ; $61dc
	ld de, $7980 ; $61de
	farcall FarPtr_0a_1a ; $61e1
	ldh a, [$ff95] ; $61e4
	ld b, a ; $61e6
	ld a, $02 ; $61e7
	ld de, $6d0e ; $61e9
	farcall FarPtr_0a_1a ; $61ec
	ldh a, [$ff95] ; $61ef
	ld b, a ; $61f1
	ld a, $00 ; $61f2
	ld de, $6cec ; $61f4
	farcall FarPtr_0a_1a ; $61f7
	xor a, a ; $61fa
	ld bc, $2400 ; $61fb
	ld de, $1700 ; $61fe
	farcall FarPtr_0a_3a ; $6201
	farcall FarPtr_0a_3e ; $6204
	ld a, $04 ; $6207
	farcall FarPtr_0a_1e ; $6209
	push af ; $620c
	ld a, $1e ; $620d
	farcall FarPtr_0a_04 ; $620f
	pop af ; $6212
	ld a, $0f ; $6213
	ld [$c294], a ; $6215
	ld [$c2a1], a ; $6218
	farcall FarPtr_0a_4a ; $621b
	ld a, $01 ; $621e
	ld [wCurrentMinigameStoryMatch], a ; $6220
	ld a, $09 ; $6223
	ld [$c8f7], a ; $6225
	farcall FarPtr_0a_5a ; $6228
	farcall FarPtr_0a_4c ; $622b
	farcall FarPtr_0a_4e ; $622e
	ret ; $6231
	INCBIN "data/bank_012/d_6232.bin" ; $6232, 622 bytes
Func_12_64a0:
	ld a, $0f ; $64a0
	ld bc, $3200 ; $64a2
	ld de, $1100 ; $64a5
	farcall FarPtr_0a_24 ; $64a8
	ld a, $10 ; $64ab
	ld bc, $3600 ; $64ad
	ld de, $1d00 ; $64b0
	farcall FarPtr_0a_24 ; $64b3
	ld a, $0f ; $64b6
	farcall FarPtr_0a_20 ; $64b8
	ld a, $10 ; $64bb
	farcall FarPtr_0a_20 ; $64bd
	ld a, $10 ; $64c0
	ld b, $c0 ; $64c2
	farcall FarPtr_0a_2e ; $64c4
	ldh a, [$ff95] ; $64c7
	ld b, a ; $64c9
	ld a, $0f ; $64ca
	ld de, $7b89 ; $64cc
	farcall FarPtr_0a_1a ; $64cf
	ldh a, [$ff95] ; $64d2
	ld b, a ; $64d4
	ld a, $10 ; $64d5
	ld de, $7bf0 ; $64d7
	farcall FarPtr_0a_1a ; $64da
	ret ; $64dd
	INCBIN "data/bank_012/d_64de.bin" ; $64de, 358 bytes
	farcall FarPtr_0a_36 ; $6644
	ldh a, [$ff95] ; $6647
	ld b, a ; $6649
	ld a, $07 ; $664a
	ld de, $78ab ; $664c
	farcall FarPtr_0a_1a ; $664f
	ldh a, [$ff95] ; $6652
	ld b, a ; $6654
	ld a, $06 ; $6655
	ld de, $78c2 ; $6657
	farcall FarPtr_0a_1a ; $665a
	ld a, $03 ; $665d
	ld b, $40 ; $665f
	farcall FarPtr_0a_2e ; $6661
	ld a, $07 ; $6664
	farcall FarPtr_0a_1e ; $6666
	ld a, $01 ; $6669
	farcall FarPtr_0a_1c ; $666b
	ld a, $00 ; $666e
	ld b, $00 ; $6670
	farcall FarPtr_0a_3c ; $6672
	farcall FarPtr_0a_3e ; $6675
	ld hl, $107c ; $6678
	farcall FarPtr_0a_0e ; $667b
	ld a, $06 ; $667e
	ld d, $03 ; $6680
	farcall FarPtr_0a_34 ; $6682
	ld a, $06 ; $6685
	farcall FarPtr_0a_36 ; $6687
	ld a, $06 ; $668a
	farcall FarPtr_0a_08 ; $668c
	ld a, $07 ; $668f
	ld d, $03 ; $6691
	farcall FarPtr_0a_34 ; $6693
	ld a, $07 ; $6696
	farcall FarPtr_0a_36 ; $6698
	ld a, $07 ; $669b
	farcall FarPtr_0a_08 ; $669d
	ld a, $07 ; $66a0
	ld b, $c0 ; $66a2
	farcall FarPtr_0a_2e ; $66a4
	ld a, $06 ; $66a7
	ld b, $c0 ; $66a9
	farcall FarPtr_0a_2e ; $66ab
	ret ; $66ae
	INCBIN "data/bank_012/d_66af.bin" ; $66af, 2220 bytes
	farcall FarPtr_0a_16 ; $6f5b
	ld c, l ; $6f5e
	ld b, h ; $6f5f
	ld de, $d000 ; $6f60
	farcall FarPtr_04_20 ; $6f63
	farcall FarPtr_0a_02 ; $6f66
	ret ; $6f69
	INCBIN "data/bank_012/d_6f6a.bin" ; $6f6a, 109 bytes
	farcall FarPtr_0a_36 ; $6fd7
	push af ; $6fda
	ld a, $14 ; $6fdb
	farcall FarPtr_0a_04 ; $6fdd
	pop af ; $6fe0
	ld a, $03 ; $6fe1
	ld de, $ff80 ; $6fe3
	farcall FarPtr_0a_42 ; $6fe6
	ld a, $03 ; $6fe9
	farcall FarPtr_0a_44 ; $6feb
	ld a, $03 ; $6fee
	ld de, $ff80 ; $6ff0
	farcall FarPtr_0a_42 ; $6ff3
	ld a, $03 ; $6ff6
	farcall FarPtr_0a_44 ; $6ff8
	ld a, $03 ; $6ffb
	farcall FarPtr_0a_08 ; $6ffd
	push af ; $7000
	ld a, $3c ; $7001
	farcall FarPtr_0a_04 ; $7003
	pop af ; $7006
	ld a, $03 ; $7007
	ld bc, $2d00 ; $7009
	ld de, $1900 ; $700c
	farcall FarPtr_0a_24 ; $700f
	xor a, a ; $7012
	ld bc, $2d00 ; $7013
	ld de, $1b00 ; $7016
	farcall FarPtr_0a_3a ; $7019
	ld a, $00 ; $701c
	ld bc, $2d00 ; $701e
	ld de, $1b00 ; $7021
	farcall FarPtr_0a_24 ; $7024
	ld a, $02 ; $7027
	ld bc, $2d00 ; $7029
	ld de, $1d00 ; $702c
	farcall FarPtr_0a_24 ; $702f
	ldh a, [$ff95] ; $7032
	ld b, a ; $7034
	ld a, $07 ; $7035
	ld de, $7940 ; $7037
	farcall FarPtr_0a_1a ; $703a
	ldh a, [$ff95] ; $703d
	ld b, a ; $703f
	ld a, $06 ; $7040
	ld de, $7929 ; $7042
	farcall FarPtr_0a_1a ; $7045
	call Func_12_64a0 ; $7048
	ld a, $03 ; $704b
	ld b, $40 ; $704d
	farcall FarPtr_0a_2e ; $704f
	ld a, $00 ; $7052
	ld b, $40 ; $7054
	farcall FarPtr_0a_2e ; $7056
	ld a, $02 ; $7059
	ld b, $40 ; $705b
	farcall FarPtr_0a_2e ; $705d
	ld a, $02 ; $7060
	farcall FarPtr_0a_16 ; $7062
	ld c, l ; $7065
	ld b, h ; $7066
	ld de, $d000 ; $7067
	farcall FarPtr_04_20 ; $706a
	farcall FarPtr_0a_02 ; $706d
	ret ; $7070
	INCBIN "data/bank_012/d_7071.bin" ; $7071, 2624 bytes
	ret ; $7ab1
	INCBIN "data/bank_012/d_7ab2.bin" ; $7ab2, 571 bytes
	ds 787, $ff ; $7ced, fill
