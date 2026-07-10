INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $02", ROMX[$4000], BANK[$02]

	INCBIN "data/bank_002/d_4000.bin" ; $4000, 2 bytes
FarPtr_02_02:
	dw Func_02_421c ; $4002
	INCBIN "data/bank_002/d_4004.bin" ; $4004, 2 bytes
FarPtr_02_06:
	dw Func_02_43a3 ; $4006
	INCBIN "data/bank_002/d_4008.bin" ; $4008, 2 bytes
FarPtr_02_0a:
	dw Func_02_49be ; $400a
FarPtr_02_0c:
	dw Func_02_4a00 ; $400c
FarPtr_02_0e:
	dw Func_02_4485 ; $400e
FarPtr_02_10:
	dw Func_02_478f ; $4010
FarPtr_02_12:
	dw Func_02_47c6 ; $4012
FarPtr_02_14:
	dw Func_02_434e ; $4014
FarPtr_02_16:
	dw Func_02_4364 ; $4016
FarPtr_02_18:
	dw Func_02_4066 ; $4018
FarPtr_02_1a:
	dw Func_02_52aa ; $401a
	INCBIN "data/bank_002/d_401c.bin" ; $401c, 12 bytes
FarPtr_02_28:
	dw Func_02_4d8f ; $4028
FarPtr_02_2a:
	dw Func_02_4d99 ; $402a
FarPtr_02_2c:
	dw Func_02_4dc8 ; $402c
FarPtr_02_2e:
	dw Func_02_4e02 ; $402e
FarPtr_02_30:
	dw Func_02_4e3a ; $4030
	INCBIN "data/bank_002/d_4032.bin" ; $4032, 2 bytes
FarPtr_02_34:
	dw Func_02_4173 ; $4034
FarPtr_02_36:
	dw Func_02_4c58 ; $4036
FarPtr_02_38:
	dw Func_02_5eb3 ; $4038
FarPtr_02_3a:
	dw Func_02_5ee2 ; $403a
FarPtr_02_3c:
	dw Func_02_4cb1 ; $403c
FarPtr_02_3e:
	dw Func_02_4cd4 ; $403e
FarPtr_02_40:
	dw Func_02_4ced ; $4040
FarPtr_02_42:
	dw Func_02_4d10 ; $4042
	INCBIN "data/bank_002/d_4044.bin" ; $4044, 34 bytes
Func_02_4066:
	ld a, b ; $4066
	push af ; $4067
	ld a, c ; $4068
	call Func_02_420e ; $4069
	ld l, c ; $406c
	ld h, b ; $406d
	pop af ; $406e
	cp a, $ff ; $406f
	jr z, Label_02_40b6 ; $4071
	cp a, $90 ; $4073
	jr z, Label_02_409f ; $4075
	bit 7, a ; $4077
	jr z, Label_02_40c4 ; $4079
	ld b, a ; $407b
	ld a, [$c36c] ; $407c
	cp a, $0f ; $407f
	jr z, Label_02_409e ; $4081
	push hl ; $4083
	ld c, $04 ; $4084
	call ClearMemory16 ; $4086
	pop de ; $4089
	ld a, b ; $408a
	and a, $01 ; $408b
	swap a ; $408d
	add a, a ; $408f
	add a, a ; $4090
	add a, $00 ; $4091
	ld l, a ; $4093
	adc a, $c9 ; $4094
	sub a, l ; $4096
	ld h, a ; $4097
	ld c, $04 ; $4098
	call CopyMemoryFast ; $409a
	ret ; $409d
Label_02_409e:
	ret ; $409e
Label_02_409f:
	push hl ; $409f
	ld c, $04 ; $40a0
	call ClearMemory16 ; $40a2
	pop de ; $40a5
	ld a, [wStoryModeNameOfMainCharacter] ; $40a6
	ld [hl], a ; $40a9
	push de ; $40aa
	ld h, d ; $40ab
	ld l, e ; $40ac
	pop de ; $40ad
	ld hl, $002f ; $40ae
	add hl, de ; $40b1
	ld [hl], $03 ; $40b2
	ret ; $40b4
	INCBIN "data/bank_002/d_40b5.bin" ; $40b5, 1 bytes
Label_02_40b6:
	push hl ; $40b6
	ld c, $04 ; $40b7
	call ClearMemory16 ; $40b9
	pop de ; $40bc
	ld hl, $000b ; $40bd
	add hl, de ; $40c0
	ld [hl], $ff ; $40c1
	ret ; $40c3
Label_02_40c4:
	push af ; $40c4
	push hl ; $40c5
	ld c, $04 ; $40c6
	call ClearMemory16 ; $40c8
	pop de ; $40cb
	pop af ; $40cc
	push af ; $40cd
	push de ; $40ce
	call Func_02_41ee ; $40cf
	ld b, a ; $40d2
	push de ; $40d3
	ld a, $0f ; $40d4
	add a, e ; $40d6
	ld e, a ; $40d7
	jr nc, Label_02_40db ; $40d8
	inc d ; $40da
Label_02_40db:
	ld c, $1d ; $40db
Label_02_40dd:
	ld a, [hl+] ; $40dd
	ld [de], a ; $40de
	inc e ; $40df
	dec c ; $40e0
	jr nz, Label_02_40dd ; $40e1
	pop de ; $40e3
	ld a, b ; $40e4
	call Func_02_4c58 ; $40e5
	ld hl, $000b ; $40e8
	add hl, de ; $40eb
	ld [hl], a ; $40ec
	ld a, b ; $40ed
	call Func_02_4173 ; $40ee
	ld hl, $000c ; $40f1
	add hl, de ; $40f4
	ld [hl], a ; $40f5
	ld hl, $000b ; $40f6
	add hl, de ; $40f9
	ld a, [hl] ; $40fa
	ld hl, $001b ; $40fb
	add a, l ; $40fe
	ld l, a ; $40ff
	jr nc, Label_02_4103 ; $4100
	inc h ; $4102
Label_02_4103:
	push hl ; $4103
	ld hl, $0000 ; $4104
	add hl, de ; $4107
	ld d, h ; $4108
	ld e, l ; $4109
	pop hl ; $410a
	farcall FarPtr_05_4e ; $410b
	pop de ; $410e
	pop af ; $410f
	bit 6, a ; $4110
	ret z ; $4112
	ld hl, $002f ; $4113
	add hl, de ; $4116
	ld [hl], $02 ; $4117
	ldh a, [$ff96] ; $4119
	push af ; $411b
	ld a, $06 ; $411c
	ldh [$ff96], a ; $411e
	ldh [rWBK], a ; $4120
	pop af ; $4122
	ldh [$ff96], a ; $4123
	ldh [rWBK], a ; $4125
	ret ; $4127
	INCBIN "data/bank_002/d_4128.bin" ; $4128, 75 bytes
Func_02_4173:
	push hl ; $4173
	add a, $7e ; $4174
	ld l, a ; $4176
	adc a, $41 ; $4177
	sub a, l ; $4179
	ld h, a ; $417a
	ld a, [hl] ; $417b
	pop hl ; $417c
	ret ; $417d
	INCBIN "data/bank_002/d_417e.bin" ; $417e, 112 bytes
Func_02_41ee:
	push af ; $41ee
	push de ; $41ef
	push bc ; $41f0
	ld h, $00 ; $41f1
	ld l, a ; $41f3
	ld d, h ; $41f4
	ld e, l ; $41f5
	add hl, hl ; $41f6
	add hl, hl ; $41f7
	add hl, de ; $41f8
	add hl, de ; $41f9
	add hl, de ; $41fa
	add hl, hl ; $41fb
	add hl, hl ; $41fc
	add hl, de ; $41fd
	ld de, $52cf ; $41fe
	add hl, de ; $4201
	pop bc ; $4202
	pop de ; $4203
	pop af ; $4204
	ret ; $4205
Func_02_4206:
	ld bc, $c900 ; $4206
	or a, a ; $4209
	ret z ; $420a
	ld c, $40 ; $420b
	ret ; $420d
Func_02_420e:
	and a, $03 ; $420e
	swap a ; $4210
	add a, a ; $4212
	add a, a ; $4213
	add a, $00 ; $4214
	ld c, a ; $4216
	adc a, $ca ; $4217
	sub a, c ; $4219
	ld b, a ; $421a
	ret ; $421b
Func_02_421c:
	call Func_02_4261 ; $421c
	ld hl, $c800 ; $421f
	ld c, $30 ; $4222
	call ClearMemory16 ; $4224
	ld a, $00 ; $4227
	ld d, $00 ; $4229
	call Func_02_43a3 ; $422b
	ld a, $01 ; $422e
	ld d, $02 ; $4230
	call Func_02_43a3 ; $4232
	ld hl, $c280 ; $4235
	ld [hl], $00 ; $4238
	ld hl, $c295 ; $423a
	ld [hl], $02 ; $423d
	ld a, $01 ; $423f
	ld [wMessageSpeed], a ; $4241
	farcall FarPtr_08_00 ; $4244
	rst Rst28 ; $4247
	ret nz ; $4248
	INCBIN "data/bank_002/d_4249.bin" ; $4249, 1 bytes
	rst Rst20 ; $424a
	ldh [rSB], a ; $424b
	ld hl, $c884 ; $424d
	xor a, a ; $4250
	ld [hl], $56 ; $4251
	inc hl ; $4253
	ld [hl+], a ; $4254
	ld [hl], a ; $4255
	ret ; $4256
	INCBIN "data/bank_002/d_4257.bin" ; $4257, 10 bytes
Func_02_4261:
	push af ; $4261
	push bc ; $4262
	push de ; $4263
	push hl ; $4264
	ldh a, [$ff96] ; $4265
	push af ; $4267
	ld a, $06 ; $4268
	ldh [$ff96], a ; $426a
	ldh [rWBK], a ; $426c
	xor a, a ; $426e
	ld c, $0c ; $426f
	ld hl, $d400 ; $4271
Label_02_4274:
	ld [hl+], a ; $4274
	dec c ; $4275
	jr nz, Label_02_4274 ; $4276
	ld a, [$c36c] ; $4278
	push af ; $427b
	ld a, $00 ; $427c
	ld [$c36c], a ; $427e
	farcall FarPtr_03_1a ; $4281
	cp a, $fe ; $4284
	jr z, Label_02_4291 ; $4286
	ld hl, $c880 ; $4288
	ld de, $d400 ; $428b
	call Func_02_42c9 ; $428e
Label_02_4291:
	ld a, $01 ; $4291
	ld [$c36c], a ; $4293
	farcall FarPtr_03_1a ; $4296
	cp a, $fe ; $4299
	jr z, Label_02_42a6 ; $429b
	ld hl, $c880 ; $429d
	ld de, $d404 ; $42a0
	call Func_02_42c9 ; $42a3
Label_02_42a6:
	ld a, $02 ; $42a6
	ld [$c36c], a ; $42a8
	farcall FarPtr_03_1a ; $42ab
	cp a, $fe ; $42ae
	jr z, Label_02_42bb ; $42b0
	ld hl, $c880 ; $42b2
	ld de, $d408 ; $42b5
	call Func_02_42c9 ; $42b8
Label_02_42bb:
	pop af ; $42bb
	ld [$c36c], a ; $42bc
	pop af ; $42bf
	ldh [$ff96], a ; $42c0
	ldh [rWBK], a ; $42c2
	pop hl ; $42c4
	pop de ; $42c5
	pop bc ; $42c6
	pop af ; $42c7
	ret ; $42c8
Func_02_42c9:
	ld a, [hl+] ; $42c9
	ld [de], a ; $42ca
	inc de ; $42cb
	ld a, [hl+] ; $42cc
	ld [de], a ; $42cd
	inc de ; $42ce
	ld a, [hl+] ; $42cf
	ld [de], a ; $42d0
	inc de ; $42d1
	ld a, [hl+] ; $42d2
	ld [de], a ; $42d3
	inc de ; $42d4
	ret ; $42d5
Func_02_42d6:
	push de ; $42d6
	push hl ; $42d7
	ldh a, [$ff96] ; $42d8
	push af ; $42da
	ld a, $06 ; $42db
	ldh [$ff96], a ; $42dd
	ldh [rWBK], a ; $42df
	ld hl, $c880 ; $42e1
	ld a, [hl+] ; $42e4
	or a, [hl] ; $42e5
	inc hl ; $42e6
	or a, [hl] ; $42e7
	inc hl ; $42e8
	or a, [hl] ; $42e9
	ld a, $ff ; $42ea
	jr z, Label_02_433d ; $42ec
	ld de, $c880 ; $42ee
	ld hl, $d400 ; $42f1
	call Func_02_4347 ; $42f4
	jr z, Label_02_433d ; $42f7
	call Func_02_4347 ; $42f9
	jr z, Label_02_433d ; $42fc
	call Func_02_4347 ; $42fe
	jr z, Label_02_433d ; $4301
	call Func_02_4347 ; $4303
	jr z, Label_02_433d ; $4306
	ld de, $c880 ; $4308
	ld hl, $d404 ; $430b
	call Func_02_4347 ; $430e
	jr z, Label_02_433d ; $4311
	call Func_02_4347 ; $4313
	jr z, Label_02_433d ; $4316
	call Func_02_4347 ; $4318
	jr z, Label_02_433d ; $431b
	call Func_02_4347 ; $431d
	jr z, Label_02_433d ; $4320
	ld de, $c880 ; $4322
	ld hl, $d408 ; $4325
	call Func_02_4347 ; $4328
	jr z, Label_02_433d ; $432b
	call Func_02_4347 ; $432d
	jr z, Label_02_433d ; $4330
	call Func_02_4347 ; $4332
	jr z, Label_02_433d ; $4335
	call Func_02_4347 ; $4337
	jr z, Label_02_433d ; $433a
	xor a, a ; $433c
Label_02_433d:
	ld h, a ; $433d
	pop af ; $433e
	ldh [$ff96], a ; $433f
	ldh [rWBK], a ; $4341
	ld a, h ; $4343
	pop hl ; $4344
	pop de ; $4345
	ret ; $4346
Func_02_4347:
	ld a, [de] ; $4347
	cp a, [hl] ; $4348
	inc de ; $4349
	inc hl ; $434a
	ld a, $ff ; $434b
	ret ; $434d
Func_02_434e:
	push af ; $434e
	push bc ; $434f
	push de ; $4350
	push hl ; $4351
	ld de, $c8bb ; $4352
	add a, e ; $4355
	ld e, a ; $4356
	jr nc, Label_02_435a ; $4357
	inc d ; $4359
Label_02_435a:
	call Func_00_0a3a ; $435a
	ld a, h ; $435d
	ld [de], a ; $435e
	pop hl ; $435f
	pop de ; $4360
	pop bc ; $4361
	pop af ; $4362
	ret ; $4363
Func_02_4364:
	push af ; $4364
	push bc ; $4365
	push de ; $4366
	push hl ; $4367
	ld hl, $c8bb ; $4368
	ld de, $c880 ; $436b
	ld a, [hl+] ; $436e
	ld [de], a ; $436f
	inc de ; $4370
	ld a, [hl+] ; $4371
	ld [de], a ; $4372
	inc de ; $4373
	ld a, [hl+] ; $4374
	ld [de], a ; $4375
	inc de ; $4376
	ld a, [hl+] ; $4377
	ld [de], a ; $4378
	inc de ; $4379
Label_02_437a:
	call Func_02_42d6 ; $437a
	or a, a ; $437d
	jr z, Label_02_439e ; $437e
	call Func_00_0a3a ; $4380
	ld a, h ; $4383
	ld [$c880], a ; $4384
	call Func_00_0a3a ; $4387
	ld a, h ; $438a
	ld [$c881], a ; $438b
	call Func_00_0a3a ; $438e
	ld a, h ; $4391
	ld [$c882], a ; $4392
	call Func_00_0a3a ; $4395
	ld a, h ; $4398
	ld [$c883], a ; $4399
	jr Label_02_437a ; $439c
Label_02_439e:
	pop hl ; $439e
	pop de ; $439f
	pop bc ; $43a0
	pop af ; $43a1
	ret ; $43a2
Func_02_43a3:
	push af ; $43a3
	ld a, d ; $43a4
	and a, $03 ; $43a5
	ld d, a ; $43a7
	pop af ; $43a8
	and a, $01 ; $43a9
	call Func_02_4206 ; $43ab
	push bc ; $43ae
	ld l, c ; $43af
	ld h, b ; $43b0
	ld c, $04 ; $43b1
	call ClearMemory16 ; $43b3
	pop bc ; $43b6
	ld a, d ; $43b7
	call Func_02_4c58 ; $43b8
	ld hl, $000b ; $43bb
	add hl, bc ; $43be
	ld [hl], a ; $43bf
	ld a, d ; $43c0
	call Func_02_4173 ; $43c1
	ld hl, $000c ; $43c4
	add hl, bc ; $43c7
	ld [hl], a ; $43c8
	ld a, d ; $43c9
	push de ; $43ca
	add a, $1b ; $43cb
	ld l, a ; $43cd
	adc a, $00 ; $43ce
	sub a, l ; $43d0
	ld h, a ; $43d1
	ld a, $00 ; $43d2
	add a, c ; $43d4
	ld e, a ; $43d5
	ld d, b ; $43d6
	farcall FarPtr_05_4e ; $43d7
	pop de ; $43da
	ld a, d ; $43db
	add a, $1b ; $43dc
	ld l, a ; $43de
	adc a, $44 ; $43df
	sub a, l ; $43e1
	ld h, a ; $43e2
	ld a, [hl] ; $43e3
	ld hl, $000d ; $43e4
	add hl, bc ; $43e7
	ld [hl], a ; $43e8
	push bc ; $43e9
	ld a, d ; $43ea
	add a, a ; $43eb
	add a, $f2 ; $43ec
	ld l, a ; $43ee
	adc a, $47 ; $43ef
	sub a, l ; $43f1
	ld h, a ; $43f2
	ld a, [hl+] ; $43f3
	ld h, [hl] ; $43f4
	ld l, a ; $43f5
	ld a, [hl+] ; $43f6
	push hl ; $43f7
	ld hl, $0018 ; $43f8
	add hl, bc ; $43fb
	ld [hl], a ; $43fc
	pop hl ; $43fd
	ld a, $30 ; $43fe
	add a, c ; $4400
	ld e, a ; $4401
	ld d, b ; $4402
	ld c, $0c ; $4403
Label_02_4405:
	ld a, [hl+] ; $4405
	ld [de], a ; $4406
	inc de ; $4407
	dec c ; $4408
	jr nz, Label_02_4405 ; $4409
	pop bc ; $440b
	call Func_02_44e9 ; $440c
	ld hl, $c900 ; $440f
	ld de, $c800 ; $4412
	ld c, $08 ; $4415
	call CopyMemoryFast ; $4417
	ret ; $441a
	INCBIN "data/bank_002/d_441b.bin" ; $441b, 106 bytes
Func_02_4485:
	call Func_02_4206 ; $4485
	ld hl, $0018 ; $4488
	add hl, bc ; $448b
	call Func_02_44e9 ; $448c
	ld hl, $0018 ; $448f
	add hl, bc ; $4492
	ret ; $4493
Func_02_4494:
	ld e, $00 ; $4494
	ld d, $09 ; $4496
Label_02_4498:
	push hl ; $4498
	push bc ; $4499
	ld c, [hl] ; $449a
	ld l, b ; $449b
	call Func_00_091b ; $449c
	call Func_00_090d ; $449f
	ld a, l ; $44a2
	sub a, c ; $44a3
	ld l, a ; $44a4
	ld a, h ; $44a5
	sbc a, b ; $44a6
	ld h, a ; $44a7
	ld a, h ; $44a8
	or a, l ; $44a9
	bit 7, h ; $44aa
	pop bc ; $44ac
	pop hl ; $44ad
	ret nz ; $44ae
	or a, a ; $44af
	ret z ; $44b0
	inc e ; $44b1
	inc hl ; $44b2
	dec d ; $44b3
	jr nz, Label_02_4498 ; $44b4
	ret ; $44b6
Func_02_44b7:
	ld l, [hl] ; $44b7
	ld h, $00 ; $44b8
	call Func_00_0926 ; $44ba
	push hl ; $44bd
	ld hl, $0018 ; $44be
	add hl, bc ; $44c1
	ld e, [hl] ; $44c2
	ld d, $00 ; $44c3
	dec e ; $44c5
	pop hl ; $44c6
	ld a, l ; $44c7
	sub a, e ; $44c8
	ld l, a ; $44c9
	ld a, h ; $44ca
	sbc a, d ; $44cb
	ld h, a ; $44cc
	push hl ; $44cd
	ld de, $ff81 ; $44ce
	add hl, de ; $44d1
	bit 7, h ; $44d2
	pop hl ; $44d4
	jr z, Label_02_44e3 ; $44d5
	push hl ; $44d7
	ld de, $007f ; $44d8
	add hl, de ; $44db
	bit 7, h ; $44dc
	pop hl ; $44de
	jr nz, Label_02_44e6 ; $44df
	ld b, l ; $44e1
	ret ; $44e2
Label_02_44e3:
	ld b, $7f ; $44e3
	ret ; $44e5
Label_02_44e6:
	ld b, $81 ; $44e6
	ret ; $44e8
Func_02_44e9:
	push bc ; $44e9
	ld hl, $000b ; $44ea
	add hl, bc ; $44ed
	ld a, [hl] ; $44ee
	and a, $03 ; $44ef
	add a, a ; $44f1
	add a, $f2 ; $44f2
	ld l, a ; $44f4
	adc a, $47 ; $44f5
	sub a, l ; $44f7
	ld h, a ; $44f8
	ld a, [hl+] ; $44f9
	ld d, [hl] ; $44fa
	ld e, a ; $44fb
	push de ; $44fc
	push bc ; $44fd
	push de ; $44fe
	ld hl, $0038 ; $44ff
	add hl, bc ; $4502
	ld a, $05 ; $4503
	call Func_02_44b7 ; $4505
	pop de ; $4508
	ld hl, $000d ; $4509
	add hl, de ; $450c
	call Func_02_4494 ; $450d
	pop bc ; $4510
	ld hl, $0020 ; $4511
	add hl, bc ; $4514
	ld [hl], e ; $4515
	pop de ; $4516
	push de ; $4517
	push bc ; $4518
	push de ; $4519
	ld hl, $0038 ; $451a
	add hl, bc ; $451d
	ld a, $05 ; $451e
	call Func_02_44b7 ; $4520
	pop de ; $4523
	ld hl, $0016 ; $4524
	add hl, de ; $4527
	call Func_02_4494 ; $4528
	pop bc ; $452b
	ld hl, $0021 ; $452c
	add hl, bc ; $452f
	ld [hl], e ; $4530
	pop de ; $4531
	push de ; $4532
	push bc ; $4533
	push de ; $4534
	ld hl, $0039 ; $4535
	add hl, bc ; $4538
	ld a, $05 ; $4539
	call Func_02_44b7 ; $453b
	pop de ; $453e
	ld hl, $001f ; $453f
	add hl, de ; $4542
	call Func_02_4494 ; $4543
	pop bc ; $4546
	ld hl, $0022 ; $4547
	add hl, bc ; $454a
	ld [hl], e ; $454b
	pop de ; $454c
	push de ; $454d
	push bc ; $454e
	push de ; $454f
	ld hl, $0039 ; $4550
	add hl, bc ; $4553
	ld a, $05 ; $4554
	call Func_02_44b7 ; $4556
	pop de ; $4559
	ld hl, $0028 ; $455a
	add hl, de ; $455d
	call Func_02_4494 ; $455e
	pop bc ; $4561
	ld hl, $0023 ; $4562
	add hl, bc ; $4565
	ld [hl], e ; $4566
	pop de ; $4567
	push de ; $4568
	push bc ; $4569
	push de ; $456a
	ld hl, $0039 ; $456b
	add hl, bc ; $456e
	ld a, $05 ; $456f
	call Func_02_44b7 ; $4571
	pop de ; $4574
	ld hl, $0031 ; $4575
	add hl, de ; $4578
	call Func_02_4494 ; $4579
	pop bc ; $457c
	ld hl, $0024 ; $457d
	add hl, bc ; $4580
	ld [hl], e ; $4581
	pop de ; $4582
	push de ; $4583
	push bc ; $4584
	push de ; $4585
	ld hl, $003a ; $4586
	add hl, bc ; $4589
	ld a, $05 ; $458a
	call Func_02_44b7 ; $458c
	pop de ; $458f
	ld hl, $003a ; $4590
	add hl, de ; $4593
	call Func_02_4494 ; $4594
	pop bc ; $4597
	ld hl, $0025 ; $4598
	add hl, bc ; $459b
	ld [hl], e ; $459c
	pop de ; $459d
	push de ; $459e
	push bc ; $459f
	push de ; $45a0
	ld hl, $003a ; $45a1
	add hl, bc ; $45a4
	ld a, $05 ; $45a5
	call Func_02_44b7 ; $45a7
	pop de ; $45aa
	ld hl, $0043 ; $45ab
	add hl, de ; $45ae
	call Func_02_4494 ; $45af
	pop bc ; $45b2
	ld hl, $0026 ; $45b3
	add hl, bc ; $45b6
	ld [hl], e ; $45b7
	pop de ; $45b8
	push de ; $45b9
	push bc ; $45ba
	push de ; $45bb
	ld hl, $003b ; $45bc
	add hl, bc ; $45bf
	ld a, $05 ; $45c0
	call Func_02_44b7 ; $45c2
	pop de ; $45c5
	ld hl, $004c ; $45c6
	add hl, de ; $45c9
	call Func_02_4494 ; $45ca
	pop bc ; $45cd
	ld hl, $0027 ; $45ce
	add hl, bc ; $45d1
	ld [hl], e ; $45d2
	pop de ; $45d3
	push de ; $45d4
	push bc ; $45d5
	push de ; $45d6
	ld hl, $003b ; $45d7
	add hl, bc ; $45da
	ld a, $05 ; $45db
	call Func_02_44b7 ; $45dd
	pop de ; $45e0
	ld hl, $0055 ; $45e1
	add hl, de ; $45e4
	call Func_02_4494 ; $45e5
	pop bc ; $45e8
	ld hl, $0028 ; $45e9
	add hl, bc ; $45ec
	ld [hl], e ; $45ed
	pop de ; $45ee
	push de ; $45ef
	push bc ; $45f0
	push de ; $45f1
	ld hl, $003b ; $45f2
	add hl, bc ; $45f5
	ld a, $05 ; $45f6
	call Func_02_44b7 ; $45f8
	pop de ; $45fb
	ld hl, $005e ; $45fc
	add hl, de ; $45ff
	call Func_02_4494 ; $4600
	pop bc ; $4603
	ld hl, $0029 ; $4604
	add hl, bc ; $4607
	ld [hl], e ; $4608
	pop de ; $4609
	push de ; $460a
	push bc ; $460b
	push de ; $460c
	ld hl, $003b ; $460d
	add hl, bc ; $4610
	ld a, $05 ; $4611
	call Func_02_44b7 ; $4613
	pop de ; $4616
	ld hl, $0067 ; $4617
	add hl, de ; $461a
	call Func_02_4494 ; $461b
	pop bc ; $461e
	ld hl, $002a ; $461f
	add hl, bc ; $4622
	ld [hl], e ; $4623
	pop de ; $4624
	ld hl, $0018 ; $4625
	add hl, bc ; $4628
	ld a, [hl] ; $4629
	ld hl, $0070 ; $462a
	add hl, de ; $462d
	ld d, a ; $462e
Label_02_462f:
	ld a, [hl+] ; $462f
	cp a, $ff ; $4630
	jr z, Label_02_4654 ; $4632
	cp a, d ; $4634
	jr nz, Label_02_4651 ; $4635
	ld a, [hl] ; $4637
	push hl ; $4638
	and a, $0f ; $4639
	add a, a ; $463b
	add a, $6e ; $463c
	ld l, a ; $463e
	adc a, $46 ; $463f
	sub a, l ; $4641
	ld h, a ; $4642
	ld a, $19 ; $4643
	add a, c ; $4645
	ld e, a ; $4646
	ld d, b ; $4647
	ld a, [de] ; $4648
	or a, [hl] ; $4649
	ld [de], a ; $464a
	inc hl ; $464b
	inc de ; $464c
	ld a, [de] ; $464d
	or a, [hl] ; $464e
	ld [de], a ; $464f
	pop hl ; $4650
Label_02_4651:
	inc hl ; $4651
	jr Label_02_462f ; $4652
Label_02_4654:
	ld hl, $0030 ; $4654
	add hl, bc ; $4657
	ld a, $10 ; $4658
	add a, c ; $465a
	ld e, a ; $465b
	ld d, b ; $465c
	ld c, $08 ; $465d
Label_02_465f:
	ld a, [hl+] ; $465f
	ld [de], a ; $4660
	inc e ; $4661
	dec c ; $4662
	jr nz, Label_02_465f ; $4663
	pop bc ; $4665
	push bc ; $4666
	ld a, c ; $4667
	or a, a ; $4668
	call z, Func_02_468e ; $4669
	pop bc ; $466c
	ret ; $466d
	INCBIN "data/bank_002/d_466e.bin" ; $466e, 32 bytes
Func_02_468e:
	push af ; $468e
	push bc ; $468f
	push de ; $4690
	push hl ; $4691
	push bc ; $4692
	ld hl, $003c ; $4693
	add hl, bc ; $4696
	ld a, [hl] ; $4697
	and a, $0f ; $4698
	ld d, $00 ; $469a
	call Func_02_46b3 ; $469c
	pop bc ; $469f
	ld hl, $003c ; $46a0
	add hl, bc ; $46a3
	ld a, [hl] ; $46a4
	swap a ; $46a5
	and a, $0f ; $46a7
	ld d, $01 ; $46a9
	call Func_02_46b3 ; $46ab
	pop hl ; $46ae
	pop de ; $46af
	pop bc ; $46b0
	pop af ; $46b1
	ret ; $46b2
Func_02_46b3:
	push bc ; $46b3
	ld c, a ; $46b4
	ld a, d ; $46b5
	add a, a ; $46b6
	ld hl, $46eb ; $46b7
	add a, l ; $46ba
	ld l, a ; $46bb
	jr nc, Label_02_46bf ; $46bc
	inc h ; $46be
Label_02_46bf:
	ld a, [hl+] ; $46bf
	ld h, [hl] ; $46c0
	ld l, a ; $46c1
	ld d, h ; $46c2
	ld e, l ; $46c3
	ld h, $00 ; $46c4
	ld l, c ; $46c6
	add hl, hl ; $46c7
	add hl, hl ; $46c8
	add hl, hl ; $46c9
	add hl, hl ; $46ca
	add hl, de ; $46cb
	pop bc ; $46cc
	ld a, $20 ; $46cd
	add a, c ; $46cf
	ld e, a ; $46d0
	ld d, b ; $46d1
	ld c, $0b ; $46d2
Label_02_46d4:
	ld b, [hl] ; $46d4
	ld a, [de] ; $46d5
	add a, b ; $46d6
	bit 7, a ; $46d7
	jr z, Label_02_46de ; $46d9
	xor a, a ; $46db
	jr Label_02_46e4 ; $46dc
Label_02_46de:
	cp a, $09 ; $46de
	jr c, Label_02_46e4 ; $46e0
	ld a, $09 ; $46e2
Label_02_46e4:
	ld [de], a ; $46e4
	inc hl ; $46e5
	inc de ; $46e6
	dec c ; $46e7
	jr nz, Label_02_46d4 ; $46e8
	ret ; $46ea
	INCBIN "data/bank_002/d_46eb.bin" ; $46eb, 164 bytes
Func_02_478f:
	ld bc, $c900 ; $478f
	call Func_02_44e9 ; $4792
	ld hl, $c900 ; $4795
	ld de, $c800 ; $4798
	ld c, $08 ; $479b
	call CopyMemoryFast ; $479d
	ld a, [$c83c] ; $47a0
	ld b, a ; $47a3
	and a, $0f ; $47a4
	cp a, $03 ; $47a6
	jr nz, Label_02_47ae ; $47a8
	ld a, b ; $47aa
	and a, $f0 ; $47ab
	ld b, a ; $47ad
Label_02_47ae:
	ld a, b ; $47ae
	swap a ; $47af
	and a, $0f ; $47b1
	cp a, $01 ; $47b3
	jr nz, Label_02_47bb ; $47b5
	ld a, b ; $47b7
	and a, $0f ; $47b8
	ld b, a ; $47ba
Label_02_47bb:
	ld a, b ; $47bb
	ld [$c83c], a ; $47bc
	ld bc, $c800 ; $47bf
	call Func_02_44e9 ; $47c2
	ret ; $47c5
Func_02_47c6:
	ld hl, $c93c ; $47c6
	ld a, [hl] ; $47c9
	push af ; $47ca
	xor a, a ; $47cb
	ld [hl], a ; $47cc
	ld bc, $c900 ; $47cd
	call Func_02_44e9 ; $47d0
	pop af ; $47d3
	ld [wEquippedRacket], a ; $47d4
	ret ; $47d7
	INCBIN "data/bank_002/d_47d8.bin" ; $47d8, 486 bytes
Func_02_49be:
	call Func_02_4206 ; $49be
Func_02_49c1:
	ld hl, $0018 ; $49c1
	add hl, bc ; $49c4
	ld a, [hl] ; $49c5
	cp a, $63 ; $49c6
	jp nc, Label_02_49ff ; $49c8
	ld a, d ; $49cb
	or a, a ; $49cc
	jr nz, Label_02_49d6 ; $49cd
	ld hl, $0038 ; $49cf
	add hl, bc ; $49d2
	inc [hl] ; $49d3
	jr Label_02_49f7 ; $49d4
Label_02_49d6:
	cp a, $01 ; $49d6
	jr nz, Label_02_49e1 ; $49d8
	ld hl, $0039 ; $49da
	add hl, bc ; $49dd
	inc [hl] ; $49de
	jr Label_02_49f7 ; $49df
Label_02_49e1:
	cp a, $02 ; $49e1
	jr nz, Label_02_49ec ; $49e3
	ld hl, $003a ; $49e5
	add hl, bc ; $49e8
	inc [hl] ; $49e9
	jr Label_02_49f7 ; $49ea
Label_02_49ec:
	cp a, $03 ; $49ec
	jr nz, Label_02_49f7 ; $49ee
	ld hl, $003b ; $49f0
	add hl, bc ; $49f3
	inc [hl] ; $49f4
	jr Label_02_49f7 ; $49f5
Label_02_49f7:
	ld hl, $0018 ; $49f7
	add hl, bc ; $49fa
	inc [hl] ; $49fb
	call Func_02_44e9 ; $49fc
Label_02_49ff:
	ret ; $49ff
Func_02_4a00:
	ld e, a ; $4a00
	ld a, l ; $4a01
	ldh [$ffb0], a ; $4a02
	ld a, h ; $4a04
	ldh [$ffb1], a ; $4a05
	add sp, -64 ; $4a07
	ld hl, sp + 0 ; $4a09
	ld a, l ; $4a0b
	ldh [$ffb2], a ; $4a0c
	ld a, h ; $4a0e
	ldh [$ffb3], a ; $4a0f
	ld a, e ; $4a11
	call Func_02_4206 ; $4a12
	push bc ; $4a15
	push bc ; $4a16
	push de ; $4a17
	ld e, l ; $4a18
	ld d, h ; $4a19
	ld l, c ; $4a1a
	ld h, b ; $4a1b
	ld bc, $0004 ; $4a1c
	call CopyMemoryFast ; $4a1f
	pop de ; $4a22
	pop bc ; $4a23
	call Func_02_49c1 ; $4a24
	ld hl, $ffb2 ; $4a27
	ld a, [hl+] ; $4a2a
	ld h, [hl] ; $4a2b
	ld l, a ; $4a2c
	ld de, $0020 ; $4a2d
	add hl, de ; $4a30
	ld d, [hl] ; $4a31
	ld hl, $0020 ; $4a32
	add hl, bc ; $4a35
	ld a, [hl] ; $4a36
	sub a, d ; $4a37
	ld d, a ; $4a38
	ld hl, $ffb0 ; $4a39
	ld a, [hl+] ; $4a3c
	ld h, [hl] ; $4a3d
	ld l, a ; $4a3e
	ld [hl], d ; $4a3f
	inc hl ; $4a40
	ld a, l ; $4a41
	ldh [$ffb0], a ; $4a42
	ld a, h ; $4a44
	ldh [$ffb1], a ; $4a45
	ld hl, $ffb2 ; $4a47
	ld a, [hl+] ; $4a4a
	ld h, [hl] ; $4a4b
	ld l, a ; $4a4c
	ld de, $0021 ; $4a4d
	add hl, de ; $4a50
	ld d, [hl] ; $4a51
	ld hl, $0021 ; $4a52
	add hl, bc ; $4a55
	ld a, [hl] ; $4a56
	sub a, d ; $4a57
	ld d, a ; $4a58
	ld hl, $ffb0 ; $4a59
	ld a, [hl+] ; $4a5c
	ld h, [hl] ; $4a5d
	ld l, a ; $4a5e
	ld [hl], d ; $4a5f
	inc hl ; $4a60
	ld a, l ; $4a61
	ldh [$ffb0], a ; $4a62
	ld a, h ; $4a64
	ldh [$ffb1], a ; $4a65
	ld hl, $ffb2 ; $4a67
	ld a, [hl+] ; $4a6a
	ld h, [hl] ; $4a6b
	ld l, a ; $4a6c
	ld de, $0022 ; $4a6d
	add hl, de ; $4a70
	ld d, [hl] ; $4a71
	ld hl, $0022 ; $4a72
	add hl, bc ; $4a75
	ld a, [hl] ; $4a76
	sub a, d ; $4a77
	ld d, a ; $4a78
	ld hl, $ffb0 ; $4a79
	ld a, [hl+] ; $4a7c
	ld h, [hl] ; $4a7d
	ld l, a ; $4a7e
	ld [hl], d ; $4a7f
	inc hl ; $4a80
	ld a, l ; $4a81
	ldh [$ffb0], a ; $4a82
	ld a, h ; $4a84
	ldh [$ffb1], a ; $4a85
	ld hl, $ffb2 ; $4a87
	ld a, [hl+] ; $4a8a
	ld h, [hl] ; $4a8b
	ld l, a ; $4a8c
	ld de, $0023 ; $4a8d
	add hl, de ; $4a90
	ld d, [hl] ; $4a91
	ld hl, $0023 ; $4a92
	add hl, bc ; $4a95
	ld a, [hl] ; $4a96
	sub a, d ; $4a97
	ld d, a ; $4a98
	ld hl, $ffb0 ; $4a99
	ld a, [hl+] ; $4a9c
	ld h, [hl] ; $4a9d
	ld l, a ; $4a9e
	ld [hl], d ; $4a9f
	inc hl ; $4aa0
	ld a, l ; $4aa1
	ldh [$ffb0], a ; $4aa2
	ld a, h ; $4aa4
	ldh [$ffb1], a ; $4aa5
	ld hl, $ffb2 ; $4aa7
	ld a, [hl+] ; $4aaa
	ld h, [hl] ; $4aab
	ld l, a ; $4aac
	ld de, $0024 ; $4aad
	add hl, de ; $4ab0
	ld d, [hl] ; $4ab1
	ld hl, $0024 ; $4ab2
	add hl, bc ; $4ab5
	ld a, [hl] ; $4ab6
	sub a, d ; $4ab7
	ld d, a ; $4ab8
	ld hl, $ffb0 ; $4ab9
	ld a, [hl+] ; $4abc
	ld h, [hl] ; $4abd
	ld l, a ; $4abe
	ld [hl], d ; $4abf
	inc hl ; $4ac0
	ld a, l ; $4ac1
	ldh [$ffb0], a ; $4ac2
	ld a, h ; $4ac4
	ldh [$ffb1], a ; $4ac5
	ld hl, $ffb2 ; $4ac7
	ld a, [hl+] ; $4aca
	ld h, [hl] ; $4acb
	ld l, a ; $4acc
	ld de, $0025 ; $4acd
	add hl, de ; $4ad0
	ld d, [hl] ; $4ad1
	ld hl, $0025 ; $4ad2
	add hl, bc ; $4ad5
	ld a, [hl] ; $4ad6
	sub a, d ; $4ad7
	ld d, a ; $4ad8
	ld hl, $ffb0 ; $4ad9
	ld a, [hl+] ; $4adc
	ld h, [hl] ; $4add
	ld l, a ; $4ade
	ld [hl], d ; $4adf
	inc hl ; $4ae0
	ld a, l ; $4ae1
	ldh [$ffb0], a ; $4ae2
	ld a, h ; $4ae4
	ldh [$ffb1], a ; $4ae5
	ld hl, $ffb2 ; $4ae7
	ld a, [hl+] ; $4aea
	ld h, [hl] ; $4aeb
	ld l, a ; $4aec
	ld de, $0026 ; $4aed
	add hl, de ; $4af0
	ld d, [hl] ; $4af1
	ld hl, $0026 ; $4af2
	add hl, bc ; $4af5
	ld a, [hl] ; $4af6
	sub a, d ; $4af7
	ld d, a ; $4af8
	ld hl, $ffb0 ; $4af9
	ld a, [hl+] ; $4afc
	ld h, [hl] ; $4afd
	ld l, a ; $4afe
	ld [hl], d ; $4aff
	inc hl ; $4b00
	ld a, l ; $4b01
	ldh [$ffb0], a ; $4b02
	ld a, h ; $4b04
	ldh [$ffb1], a ; $4b05
	ld hl, $ffb2 ; $4b07
	ld a, [hl+] ; $4b0a
	ld h, [hl] ; $4b0b
	ld l, a ; $4b0c
	ld de, $0027 ; $4b0d
	add hl, de ; $4b10
	ld d, [hl] ; $4b11
	ld hl, $0027 ; $4b12
	add hl, bc ; $4b15
	ld a, [hl] ; $4b16
	sub a, d ; $4b17
	ld d, a ; $4b18
	ld hl, $ffb0 ; $4b19
	ld a, [hl+] ; $4b1c
	ld h, [hl] ; $4b1d
	ld l, a ; $4b1e
	ld [hl], d ; $4b1f
	inc hl ; $4b20
	ld a, l ; $4b21
	ldh [$ffb0], a ; $4b22
	ld a, h ; $4b24
	ldh [$ffb1], a ; $4b25
	ld hl, $ffb2 ; $4b27
	ld a, [hl+] ; $4b2a
	ld h, [hl] ; $4b2b
	ld l, a ; $4b2c
	ld de, $0028 ; $4b2d
	add hl, de ; $4b30
	ld d, [hl] ; $4b31
	ld hl, $0028 ; $4b32
	add hl, bc ; $4b35
	ld a, [hl] ; $4b36
	sub a, d ; $4b37
	ld d, a ; $4b38
	ld hl, $ffb0 ; $4b39
	ld a, [hl+] ; $4b3c
	ld h, [hl] ; $4b3d
	ld l, a ; $4b3e
	ld [hl], d ; $4b3f
	inc hl ; $4b40
	ld a, l ; $4b41
	ldh [$ffb0], a ; $4b42
	ld a, h ; $4b44
	ldh [$ffb1], a ; $4b45
	ld hl, $ffb2 ; $4b47
	ld a, [hl+] ; $4b4a
	ld h, [hl] ; $4b4b
	ld l, a ; $4b4c
	ld de, $0029 ; $4b4d
	add hl, de ; $4b50
	ld d, [hl] ; $4b51
	ld hl, $0029 ; $4b52
	add hl, bc ; $4b55
	ld a, [hl] ; $4b56
	sub a, d ; $4b57
	ld d, a ; $4b58
	ld hl, $ffb0 ; $4b59
	ld a, [hl+] ; $4b5c
	ld h, [hl] ; $4b5d
	ld l, a ; $4b5e
	ld [hl], d ; $4b5f
	inc hl ; $4b60
	ld a, l ; $4b61
	ldh [$ffb0], a ; $4b62
	ld a, h ; $4b64
	ldh [$ffb1], a ; $4b65
	ld hl, $ffb2 ; $4b67
	ld a, [hl+] ; $4b6a
	ld h, [hl] ; $4b6b
	ld l, a ; $4b6c
	ld de, $002a ; $4b6d
	add hl, de ; $4b70
	ld d, [hl] ; $4b71
	ld hl, $002a ; $4b72
	add hl, bc ; $4b75
	ld a, [hl] ; $4b76
	sub a, d ; $4b77
	ld d, a ; $4b78
	ld hl, $ffb0 ; $4b79
	ld a, [hl+] ; $4b7c
	ld h, [hl] ; $4b7d
	ld l, a ; $4b7e
	ld [hl], d ; $4b7f
	inc hl ; $4b80
	ld a, l ; $4b81
	ldh [$ffb0], a ; $4b82
	ld a, h ; $4b84
	ldh [$ffb1], a ; $4b85
	pop bc ; $4b87
	ld hl, $ffb2 ; $4b88
	ld a, [hl+] ; $4b8b
	ld h, [hl] ; $4b8c
	ld l, a ; $4b8d
	ld e, c ; $4b8e
	ld d, b ; $4b8f
	ld bc, $0004 ; $4b90
	call CopyMemoryFast ; $4b93
	add sp, 64 ; $4b96
	ret ; $4b98
	INCBIN "data/bank_002/d_4b99.bin" ; $4b99, 191 bytes
Func_02_4c58:
	cp a, $20 ; $4c58
	ret c ; $4c5a
	push hl ; $4c5b
	sub a, $20 ; $4c5c
	and a, $7f ; $4c5e
	add a, $6a ; $4c60
	ld l, a ; $4c62
	adc a, $4c ; $4c63
	sub a, l ; $4c65
	ld h, a ; $4c66
	ld a, [hl] ; $4c67
	pop hl ; $4c68
	ret ; $4c69
	INCBIN "data/bank_002/d_4c6a.bin" ; $4c6a, 71 bytes
Func_02_4cb1:
	push af ; $4cb1
	ld a, [$c36c] ; $4cb2
	add a, a ; $4cb5
	add a, $cc ; $4cb6
	ld l, a ; $4cb8
	adc a, $4c ; $4cb9
	sub a, l ; $4cbb
	ld h, a ; $4cbc
	ld a, [hl+] ; $4cbd
	ld d, [hl] ; $4cbe
	ld e, a ; $4cbf
	pop af ; $4cc0
	and a, a ; $4cc1
	jr nz, Label_02_4cc8 ; $4cc2
	farcall FarPtr_03_20 ; $4cc4
	ret ; $4cc7
Label_02_4cc8:
	farcall FarPtr_03_1e ; $4cc8
	ret ; $4ccb
	INCBIN "data/bank_002/d_4ccc.bin" ; $4ccc, 8 bytes
Func_02_4cd4:
	ld a, [$c36c] ; $4cd4
	add a, a ; $4cd7
	add a, $cc ; $4cd8
	ld l, a ; $4cda
	adc a, $4c ; $4cdb
	sub a, l ; $4cdd
	ld h, a ; $4cde
	ld a, [hl+] ; $4cdf
	ld d, [hl] ; $4ce0
	ld e, a ; $4ce1
	farcall FarPtr_03_1c ; $4ce2
	jr z, Label_02_4cea ; $4ce5
	ld a, $01 ; $4ce7
	ret ; $4ce9
Label_02_4cea:
	ld a, $00 ; $4cea
	ret ; $4cec
Func_02_4ced:
	push af ; $4ced
	ld a, [$c36c] ; $4cee
	add a, a ; $4cf1
	add a, $08 ; $4cf2
	ld l, a ; $4cf4
	adc a, $4d ; $4cf5
	sub a, l ; $4cf7
	ld h, a ; $4cf8
	ld a, [hl+] ; $4cf9
	ld d, [hl] ; $4cfa
	ld e, a ; $4cfb
	pop af ; $4cfc
	and a, a ; $4cfd
	jr nz, Label_02_4d04 ; $4cfe
	farcall FarPtr_03_20 ; $4d00
	ret ; $4d03
Label_02_4d04:
	farcall FarPtr_03_1e ; $4d04
	ret ; $4d07
	INCBIN "data/bank_002/d_4d08.bin" ; $4d08, 8 bytes
Func_02_4d10:
	ld a, [$c36c] ; $4d10
	add a, a ; $4d13
	add a, $08 ; $4d14
	ld l, a ; $4d16
	adc a, $4d ; $4d17
	sub a, l ; $4d19
	ld h, a ; $4d1a
	ld a, [hl+] ; $4d1b
	ld d, [hl] ; $4d1c
	ld e, a ; $4d1d
	farcall FarPtr_03_1c ; $4d1e
	jr z, Label_02_4d26 ; $4d21
	ld a, $01 ; $4d23
	ret ; $4d25
Label_02_4d26:
	ld a, $00 ; $4d26
	ret ; $4d28
	INCBIN "data/bank_002/d_4d29.bin" ; $4d29, 7 bytes
Label_02_4d30:
	ld a, [hl] ; $4d30
	add a, e ; $4d31
	ld [hl+], a ; $4d32
	ld a, [hl] ; $4d33
	adc a, d ; $4d34
	ld [hl+], a ; $4d35
	ld a, [hl] ; $4d36
	adc a, $00 ; $4d37
	ld [hl], a ; $4d39
	dec hl ; $4d3a
	dec hl ; $4d3b
	ld de, $4d50 ; $4d3c
	call Func_02_4d54 ; $4d3f
	ret z ; $4d42
	dec hl ; $4d43
	dec hl ; $4d44
	dec de ; $4d45
	dec de ; $4d46
	ld a, [de] ; $4d47
	ld [hl+], a ; $4d48
	inc de ; $4d49
	ld a, [de] ; $4d4a
	ld [hl+], a ; $4d4b
	inc de ; $4d4c
	ld a, [de] ; $4d4d
	ld [hl], a ; $4d4e
	ret ; $4d4f
	INCBIN "data/bank_002/d_4d50.bin" ; $4d50, 4 bytes
Func_02_4d54:
	ld a, [de] ; $4d54
	inc de ; $4d55
	sub a, [hl] ; $4d56
	inc hl ; $4d57
	ld a, [de] ; $4d58
	inc de ; $4d59
	sbc a, [hl] ; $4d5a
	inc hl ; $4d5b
	ld a, [de] ; $4d5c
	sbc a, [hl] ; $4d5d
	bit 7, a ; $4d5e
	ret ; $4d60
	INCBIN "data/bank_002/d_4d61.bin" ; $4d61, 46 bytes
Func_02_4d8f:
	call Func_02_4206 ; $4d8f
	ld hl, $002c ; $4d92
	add hl, bc ; $4d95
	jp Label_02_4d30 ; $4d96
Func_02_4d99:
	call Func_02_4206 ; $4d99
	ld hl, $0018 ; $4d9c
	add hl, bc ; $4d9f
	ld a, [hl] ; $4da0
	cp a, $63 ; $4da1
	jp nc, Label_02_4dc4 ; $4da3
	ld h, $00 ; $4da6
	ld l, a ; $4da8
	ld d, h ; $4da9
	ld e, l ; $4daa
	add hl, hl ; $4dab
	add hl, de ; $4dac
	push hl ; $4dad
	xor a, a ; $4dae
	ld hl, $4e78 ; $4daf
	add a, l ; $4db2
	ld l, a ; $4db3
	jr nc, Label_02_4db7 ; $4db4
	inc h ; $4db6
Label_02_4db7:
	ld a, [hl+] ; $4db7
	ld h, [hl] ; $4db8
	ld l, a ; $4db9
	pop de ; $4dba
	add hl, de ; $4dbb
	ld a, $2c ; $4dbc
	add a, c ; $4dbe
	ld e, a ; $4dbf
	ld d, b ; $4dc0
	jp Func_02_4d54 ; $4dc1
Label_02_4dc4:
	ld a, $80 ; $4dc4
	or a, a ; $4dc6
	ret ; $4dc7
Func_02_4dc8:
	call Func_02_4206 ; $4dc8
	ld hl, $0018 ; $4dcb
	add hl, bc ; $4dce
	ld a, [hl] ; $4dcf
	cp a, $63 ; $4dd0
	jp nc, Label_02_4dfe ; $4dd2
	ld h, $00 ; $4dd5
	ld l, a ; $4dd7
	ld d, h ; $4dd8
	ld e, l ; $4dd9
	add hl, hl ; $4dda
	add hl, de ; $4ddb
	push hl ; $4ddc
	xor a, a ; $4ddd
	ld hl, $4e78 ; $4dde
	add a, l ; $4de1
	ld l, a ; $4de2
	jr nc, Label_02_4de6 ; $4de3
	inc h ; $4de5
Label_02_4de6:
	ld a, [hl+] ; $4de6
	ld h, [hl] ; $4de7
	ld l, a ; $4de8
	pop de ; $4de9
	add hl, de ; $4dea
	ld a, [hl+] ; $4deb
	ld h, [hl] ; $4dec
	ld l, a ; $4ded
	push hl ; $4dee
	ld hl, $002c ; $4def
	add hl, bc ; $4df2
	ld a, [hl+] ; $4df3
	ld d, [hl] ; $4df4
	ld e, a ; $4df5
	pop hl ; $4df6
	ld a, l ; $4df7
	sub a, e ; $4df8
	ld l, a ; $4df9
	ld a, h ; $4dfa
	sbc a, d ; $4dfb
	ld h, a ; $4dfc
	ret ; $4dfd
Label_02_4dfe:
	ld hl, $0000 ; $4dfe
	ret ; $4e01
Func_02_4e02:
	call Func_02_4206 ; $4e02
	ld hl, $0018 ; $4e05
	add hl, bc ; $4e08
	ld a, [hl] ; $4e09
	cp a, $63 ; $4e0a
	jr nc, Label_02_4e36 ; $4e0c
	dec a ; $4e0e
	ld h, $00 ; $4e0f
	ld l, a ; $4e11
	ld d, h ; $4e12
	ld e, l ; $4e13
	add hl, hl ; $4e14
	add hl, de ; $4e15
	push hl ; $4e16
	xor a, a ; $4e17
	ld hl, $4e78 ; $4e18
	add a, l ; $4e1b
	ld l, a ; $4e1c
	jr nc, Label_02_4e20 ; $4e1d
	inc h ; $4e1f
Label_02_4e20:
	ld a, [hl+] ; $4e20
	ld h, [hl] ; $4e21
	ld l, a ; $4e22
	pop de ; $4e23
	add hl, de ; $4e24
	ld a, [hl+] ; $4e25
	ld d, [hl] ; $4e26
	ld e, a ; $4e27
	ld hl, $002c ; $4e28
	add hl, bc ; $4e2b
	ld a, [hl+] ; $4e2c
	ld h, [hl] ; $4e2d
	ld l, a ; $4e2e
	ld a, l ; $4e2f
	sub a, e ; $4e30
	ld l, a ; $4e31
	ld a, h ; $4e32
	sbc a, d ; $4e33
	ld h, a ; $4e34
	ret ; $4e35
Label_02_4e36:
	ld hl, $0000 ; $4e36
	ret ; $4e39
Func_02_4e3a:
	push af ; $4e3a
	dec a ; $4e3b
	ld h, $00 ; $4e3c
	ld l, a ; $4e3e
	ld d, h ; $4e3f
	ld e, l ; $4e40
	add hl, hl ; $4e41
	add hl, de ; $4e42
	push hl ; $4e43
	xor a, a ; $4e44
	ld hl, $4e78 ; $4e45
	add a, l ; $4e48
	ld l, a ; $4e49
	jr nc, Label_02_4e4d ; $4e4a
	inc h ; $4e4c
Label_02_4e4d:
	ld a, [hl+] ; $4e4d
	ld h, [hl] ; $4e4e
	ld l, a ; $4e4f
	pop de ; $4e50
	add hl, de ; $4e51
	ld a, [hl+] ; $4e52
	ld d, [hl] ; $4e53
	ld e, a ; $4e54
	pop af ; $4e55
	push de ; $4e56
	ld h, $00 ; $4e57
	ld l, a ; $4e59
	ld d, h ; $4e5a
	ld e, l ; $4e5b
	add hl, hl ; $4e5c
	add hl, de ; $4e5d
	push hl ; $4e5e
	xor a, a ; $4e5f
	ld hl, $4e78 ; $4e60
	add a, l ; $4e63
	ld l, a ; $4e64
	jr nc, Label_02_4e68 ; $4e65
	inc h ; $4e67
Label_02_4e68:
	ld a, [hl+] ; $4e68
	ld h, [hl] ; $4e69
	ld l, a ; $4e6a
	pop de ; $4e6b
	add hl, de ; $4e6c
	ld a, [hl+] ; $4e6d
	ld h, [hl] ; $4e6e
	ld l, a ; $4e6f
	pop de ; $4e70
	ld a, l ; $4e71
	sub a, e ; $4e72
	ld l, a ; $4e73
	ld a, h ; $4e74
	sbc a, d ; $4e75
	ld h, a ; $4e76
	ret ; $4e77
	INCBIN "data/bank_002/d_4e78.bin" ; $4e78, 975 bytes
Func_02_5247:
	push de ; $5247
	ld hl, $c800 ; $5248
	ld b, a ; $524b
	ld c, a ; $524c
	push bc ; $524d
	ld [$c36c], a ; $524e
	farcall FarPtr_03_1a ; $5251
	pop bc ; $5254
	pop de ; $5255
	or a, a ; $5256
	jr z, Label_02_5275 ; $5257
	ld a, [$c33f] ; $5259
	or a, a ; $525c
	ld a, h ; $525d
	jr nz, Label_02_526f ; $525e
	ld a, $3f ; $5260
	ld [wPlayer1CurrentMainCharacter], a ; $5262
	ld a, $03 ; $5265
	ld [$ca0c], a ; $5267
	ld a, b ; $526a
	ld [$c36c], a ; $526b
	ret ; $526e
Label_02_526f:
	ld a, $ff ; $526f
	ld [wPlayer1CurrentMainCharacter], a ; $5271
	ret ; $5274
Label_02_5275:
	push bc ; $5275
	push de ; $5276
	xor a, a ; $5277
	ld [$c36c], a ; $5278
	ld bc, $8000 ; $527b
	call Func_02_4066 ; $527e
	pop de ; $5281
	pop bc ; $5282
	ret ; $5283
	INCBIN "data/bank_002/d_5284.bin" ; $5284, 38 bytes
Func_02_52aa:
	push af ; $52aa
	push bc ; $52ab
	push de ; $52ac
	push hl ; $52ad
	bit 7, a ; $52ae
	jr z, Label_02_52c4 ; $52b0
	res 7, a ; $52b2
	call Func_02_5247 ; $52b4
	ld hl, $ca00 ; $52b7
	ld de, $ca80 ; $52ba
	ld c, $08 ; $52bd
	call CopyMemoryFast ; $52bf
	jr Label_02_52ca ; $52c2
Label_02_52c4:
	ld b, a ; $52c4
	ld c, $02 ; $52c5
	call Func_02_4066 ; $52c7
Label_02_52ca:
	pop hl ; $52ca
	pop de ; $52cb
	pop bc ; $52cc
	pop af ; $52cd
	ret ; $52ce
	INCBIN "data/bank_002/d_52cf.bin" ; $52cf, 3044 bytes
Func_02_5eb3:
	add a, a ; $5eb3
	add a, a ; $5eb4
	add a, a ; $5eb5
	add a, a ; $5eb6
	add a, $23 ; $5eb7
	ld l, a ; $5eb9
	adc a, $5e ; $5eba
	sub a, l ; $5ebc
	ld h, a ; $5ebd
	ld a, b ; $5ebe
	and a, $0f ; $5ebf
	add a, l ; $5ec1
	ld l, a ; $5ec2
	jr nc, Label_02_5ec6 ; $5ec3
	inc h ; $5ec5
Label_02_5ec6:
	ld a, [hl] ; $5ec6
	ret ; $5ec7
	INCBIN "data/bank_002/d_5ec8.bin" ; $5ec8, 26 bytes
Func_02_5ee2:
	add a, a ; $5ee2
	add a, a ; $5ee3
	add a, a ; $5ee4
	add a, a ; $5ee5
	add a, $23 ; $5ee6
	ld l, a ; $5ee8
	adc a, $5e ; $5ee9
	sub a, l ; $5eeb
	ld h, a ; $5eec
	ld c, $10 ; $5eed
Label_02_5eef:
	ld a, [hl+] ; $5eef
	cp a, b ; $5ef0
	jr z, Label_02_5ef8 ; $5ef1
	dec c ; $5ef3
	jr nz, Label_02_5eef ; $5ef4
	xor a, a ; $5ef6
	ret ; $5ef7
Label_02_5ef8:
	ld a, $01 ; $5ef8
	ret ; $5efa
	INCBIN "data/bank_002/d_5efb.bin" ; $5efb, 8453 bytes
