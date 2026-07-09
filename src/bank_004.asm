INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $04", ROMX[$4000], BANK[$04]

	INCBIN "data/bank_004/d_4000.bin" ; $4000, 50 bytes
Func_04_4032:
	ld a, $04 ; $4032
	ldh [$ff96], a ; $4034
	ldh [rWBK], a ; $4036
	ld hl, $d000 ; $4038
	ld c, $60 ; $403b
	call ClearMemory16 ; $403d
	ret ; $4040
	call Func_04_4032 ; $4041
	ld a, $10 ; $4044
	ld hl, $41e7 ; $4046
	call Func_00_1b6a ; $4049
	ld a, $01 ; $404c
	ld hl, $4a82 ; $404e
	call Func_00_1b6a ; $4051
	ret ; $4054
Func_04_4055:
	push af ; $4055
	push de ; $4056
	push hl ; $4057
	ld a, $04 ; $4058
	ldh [$ff96], a ; $405a
	ldh [rWBK], a ; $405c
	ld hl, $d000 ; $405e
	ld c, $18 ; $4061
Label_04_4063:
	inc hl ; $4063
	ld a, [hl-] ; $4064
	or a, a ; $4065
	jr z, Label_04_4076 ; $4066
	ld de, $0040 ; $4068
	add hl, de ; $406b
	dec c ; $406c
	jr nz, Label_04_4063 ; $406d
	ld bc, $0000 ; $406f
	pop hl ; $4072
	pop de ; $4073
	pop af ; $4074
	ret ; $4075
Label_04_4076:
	ld c, l ; $4076
	ld b, h ; $4077
	ld de, $b000 ; $4078
	add hl, de ; $407b
	ld e, l ; $407c
	ld d, h ; $407d
	ld hl, $0026 ; $407e
	add hl, bc ; $4081
	ld a, e ; $4082
	ld [hl+], a ; $4083
	ld [hl], d ; $4084
	ld l, c ; $4085
	ld h, b ; $4086
	add hl, hl ; $4087
	add hl, hl ; $4088
	add hl, hl ; $4089
	add hl, hl ; $408a
	ld a, h ; $408b
	ld hl, $0036 ; $408c
	add hl, bc ; $408f
	ld [hl], a ; $4090
	ld hl, $0020 ; $4091
	add hl, bc ; $4094
	ld [hl], $00 ; $4095
	ld hl, $0015 ; $4097
	add hl, bc ; $409a
	ld [hl], $10 ; $409b
	ld hl, $0006 ; $409d
	add hl, bc ; $40a0
	ld a, $20 ; $40a1
	ld [hl+], a ; $40a3
	ld a, $00 ; $40a4
	ld [hl+], a ; $40a6
	pop hl ; $40a7
	pop de ; $40a8
	pop af ; $40a9
	jr Label_04_40af ; $40aa
Func_04_40ac:
	inc b ; $40ac
	dec b ; $40ad
	ret z ; $40ae
Label_04_40af:
	push af ; $40af
	push bc ; $40b0
	push af ; $40b1
	ld a, $04 ; $40b2
	ldh [$ff96], a ; $40b4
	ldh [rWBK], a ; $40b6
	ld a, l ; $40b8
	ld [bc], a ; $40b9
	inc bc ; $40ba
	ld a, h ; $40bb
	ld [bc], a ; $40bc
	inc bc ; $40bd
	pop af ; $40be
	ld [bc], a ; $40bf
	inc bc ; $40c0
	xor a, a ; $40c1
	ld [bc], a ; $40c2
	pop bc ; $40c3
	pop af ; $40c4
	ret ; $40c5
Func_04_40c6:
	inc b ; $40c6
	dec b ; $40c7
	ret z ; $40c8
	push af ; $40c9
	push de ; $40ca
	push hl ; $40cb
	ld a, $04 ; $40cc
	ldh [$ff96], a ; $40ce
	ldh [rWBK], a ; $40d0
	push hl ; $40d2
	ld hl, $000e ; $40d3
	add hl, bc ; $40d6
	ld a, e ; $40d7
	ld [hl+], a ; $40d8
	ld [hl], d ; $40d9
	ld hl, $000a ; $40da
	add hl, bc ; $40dd
	ld a, e ; $40de
	ld [hl+], a ; $40df
	ld [hl], d ; $40e0
	pop de ; $40e1
	ld hl, $000c ; $40e2
	add hl, bc ; $40e5
	ld a, e ; $40e6
	ld [hl+], a ; $40e7
	ld [hl], d ; $40e8
	ld hl, $0008 ; $40e9
	add hl, bc ; $40ec
	ld a, e ; $40ed
	ld [hl+], a ; $40ee
	ld [hl], d ; $40ef
	pop hl ; $40f0
	pop de ; $40f1
	pop af ; $40f2
	ret ; $40f3
	INCBIN "data/bank_004/d_40f4.bin" ; $40f4, 84 bytes
Func_04_4148:
	inc b ; $4148
	dec b ; $4149
	ret z ; $414a
	push af ; $414b
	push hl ; $414c
	ld a, $04 ; $414d
	ldh [$ff96], a ; $414f
	ldh [rWBK], a ; $4151
	ld hl, $0020 ; $4153
	add hl, bc ; $4156
	ld [hl], d ; $4157
	pop hl ; $4158
	pop af ; $4159
	ret ; $415a
	INCBIN "data/bank_004/d_415b.bin" ; $415b, 32 bytes
Func_04_417b:
	inc b ; $417b
	dec b ; $417c
	ret z ; $417d
	push af ; $417e
	push de ; $417f
	push hl ; $4180
	ld a, $04 ; $4181
	ldh [$ff96], a ; $4183
	ldh [rWBK], a ; $4185
	ld hl, $0016 ; $4187
	add hl, bc ; $418a
	ld a, e ; $418b
	ld [hl+], a ; $418c
	ld [hl], d ; $418d
	ldh a, [$ff95] ; $418e
	ld hl, $41d8 ; $4190
	call Func_04_40ac ; $4193
	ld hl, $0020 ; $4196
	add hl, bc ; $4199
	ld [hl], $01 ; $419a
	ld hl, $0015 ; $419c
	add hl, bc ; $419f
	ld [hl], $40 ; $41a0
	pop hl ; $41a2
	pop de ; $41a3
	pop af ; $41a4
	ret ; $41a5
Func_04_41a6:
	inc b ; $41a6
	dec b ; $41a7
	ret z ; $41a8
	push af ; $41a9
	push de ; $41aa
	push hl ; $41ab
	ld hl, $0016 ; $41ac
	add hl, bc ; $41af
	ld a, e ; $41b0
	ld [hl+], a ; $41b1
	ld [hl], d ; $41b2
	ldh a, [$ff95] ; $41b3
	ld hl, $41dc ; $41b5
	call Func_04_40ac ; $41b8
	ld hl, $0005 ; $41bb
	add hl, bc ; $41be
	res 3, [hl] ; $41bf
	ld hl, $0015 ; $41c1
	add hl, bc ; $41c4
	ld [hl], $40 ; $41c5
	ld hl, $0005 ; $41c7
	add hl, bc ; $41ca
	res 4, [hl] ; $41cb
	pop hl ; $41cd
	pop de ; $41ce
	pop af ; $41cf
	ret ; $41d0
	INCBIN "data/bank_004/d_41d1.bin" ; $41d1, 22 bytes
	ld a, $04 ; $41e7
	ldh [$ff96], a ; $41e9
	ldh [rWBK], a ; $41eb
	ld hl, $d000 ; $41ed
	ld c, $18 ; $41f0
Label_04_41f2:
	inc hl ; $41f2
	ld a, [hl-] ; $41f3
	or a, a ; $41f4
	jr z, Label_04_420f ; $41f5
	push bc ; $41f7
	push hl ; $41f8
	ld a, l ; $41f9
	ldh [$ffea], a ; $41fa
	ld a, h ; $41fc
	ldh [$ffeb], a ; $41fd
	ld c, l ; $41ff
	ld b, h ; $4200
	call Func_04_4229 ; $4201
	call Func_04_426e ; $4204
	call Func_04_42ae ; $4207
	call Func_04_4402 ; $420a
	pop hl ; $420d
	pop bc ; $420e
Label_04_420f:
	ld de, $0040 ; $420f
	add hl, de ; $4212
	dec c ; $4213
	jr nz, Label_04_41f2 ; $4214
	ld hl, $d00c ; $4216
	ld de, $c2d0 ; $4219
	ld bc, $0004 ; $421c
	call CopyMemoryBC ; $421f
	ld a, [$d032] ; $4222
	ld [$c2d4], a ; $4225
	ret ; $4228
Func_04_4229:
	ld hl, $0005 ; $4229
	add hl, bc ; $422c
	bit 0, [hl] ; $422d
	ret nz ; $422f
	ld hl, $0003 ; $4230
	add hl, bc ; $4233
	ld a, [hl] ; $4234
	or a, a ; $4235
	jr z, Label_04_423a ; $4236
	dec [hl] ; $4238
	ret ; $4239
Label_04_423a:
	push bc ; $423a
	ld hl, $0000 ; $423b
	add hl, bc ; $423e
	ld a, [hl+] ; $423f
	ld e, a ; $4240
	ld a, [hl+] ; $4241
	ld d, a ; $4242
	ld a, [hl+] ; $4243
	ld [$daf7], a ; $4244
Label_04_4247:
	push bc ; $4247
	ld a, [$daf7] ; $4248
	ld l, e ; $424b
	ld h, d ; $424c
	call Func_00_0628 ; $424d
	ld hl, $4260 ; $4250
	push hl ; $4253
	add a, a ; $4254
	add a, $7d ; $4255
	ld l, a ; $4257
	adc a, $44 ; $4258
	sub a, l ; $425a
	ld h, a ; $425b
	ld a, [hl+] ; $425c
	ld h, [hl] ; $425d
	ld l, a ; $425e
	jp hl ; $425f
	pop bc ; $4260
	ld hl, $0000 ; $4261
	add hl, bc ; $4264
	ld [hl], e ; $4265
	inc hl ; $4266
	ld [hl], d ; $4267
	inc hl ; $4268
	or a, a ; $4269
	jr nz, Label_04_4247 ; $426a
	pop bc ; $426c
	ret ; $426d
Func_04_426e:
	ld hl, $0012 ; $426e
	add hl, bc ; $4271
	ld a, [hl+] ; $4272
	ld d, [hl] ; $4273
	ld e, a ; $4274
	ld hl, $0010 ; $4275
	add hl, bc ; $4278
	ld a, [hl+] ; $4279
	ld h, [hl] ; $427a
	ld l, a ; $427b
	or a, h ; $427c
	or a, d ; $427d
	or a, e ; $427e
	jr z, Label_04_42ad ; $427f
	push hl ; $4281
	ld hl, $0010 ; $4282
	add hl, de ; $4285
	ld e, l ; $4286
	ld d, h ; $4287
	pop hl ; $4288
	add hl, de ; $4289
	bit 7, h ; $428a
	jr nz, Label_04_429d ; $428c
	xor a, a ; $428e
	ld hl, $0010 ; $428f
	add hl, bc ; $4292
	ld [hl+], a ; $4293
	ld [hl+], a ; $4294
	ld hl, $0012 ; $4295
	add hl, bc ; $4298
	ld [hl+], a ; $4299
	ld [hl+], a ; $429a
	jr Label_04_42ad ; $429b
Label_04_429d:
	push hl ; $429d
	ld hl, $0012 ; $429e
	add hl, bc ; $42a1
	ld a, e ; $42a2
	ld [hl+], a ; $42a3
	ld [hl], d ; $42a4
	pop de ; $42a5
	ld hl, $0010 ; $42a6
	add hl, bc ; $42a9
	ld a, e ; $42aa
	ld [hl+], a ; $42ab
	ld [hl], d ; $42ac
Label_04_42ad:
	ret ; $42ad
Func_04_42ae:
	ld hl, $0005 ; $42ae
	add hl, bc ; $42b1
	res 6, [hl] ; $42b2
	bit 1, [hl] ; $42b4
	ret nz ; $42b6
	bit 7, [hl] ; $42b7
	ret z ; $42b9
	push bc ; $42ba
	ld hl, $0008 ; $42bb
	add hl, bc ; $42be
	ld a, [hl+] ; $42bf
	ld d, [hl] ; $42c0
	ld e, a ; $42c1
	ld hl, $000c ; $42c2
	add hl, bc ; $42c5
	ld a, [hl+] ; $42c6
	ld h, [hl] ; $42c7
	ld l, a ; $42c8
	ld a, l ; $42c9
	sub a, e ; $42ca
	ld l, a ; $42cb
	ld a, h ; $42cc
	sbc a, d ; $42cd
	ld h, a ; $42ce
	push hl ; $42cf
	ld hl, $000a ; $42d0
	add hl, bc ; $42d3
	ld a, [hl+] ; $42d4
	ld d, [hl] ; $42d5
	ld e, a ; $42d6
	ld hl, $000e ; $42d7
	add hl, bc ; $42da
	ld a, [hl+] ; $42db
	ld h, [hl] ; $42dc
	ld l, a ; $42dd
	ld a, l ; $42de
	sub a, e ; $42df
	ld l, a ; $42e0
	ld a, h ; $42e1
	sbc a, d ; $42e2
	ld h, a ; $42e3
	pop de ; $42e4
	push de ; $42e5
	push hl ; $42e6
	call Func_00_0a54 ; $42e7
	add a, $80 ; $42ea
	push af ; $42ec
	ld hl, $0014 ; $42ed
	add hl, bc ; $42f0
	ld e, [hl] ; $42f1
	sub a, e ; $42f2
	ld d, a ; $42f3
	bit 7, a ; $42f4
	jr z, Label_04_42fa ; $42f6
	cpl ; $42f8
	inc a ; $42f9
Label_04_42fa:
	cp a, $60 ; $42fa
	jr c, Label_04_430c ; $42fc
	ld a, e ; $42fe
	add a, $80 ; $42ff
	ld e, a ; $4301
	ld a, d ; $4302
	add a, $80 ; $4303
	ld d, a ; $4305
	bit 7, a ; $4306
	jr z, Label_04_430c ; $4308
	cpl ; $430a
	inc a ; $430b
Label_04_430c:
	inc hl ; $430c
	cp a, [hl] ; $430d
	ld a, d ; $430e
	jr c, Label_04_4318 ; $430f
	ld a, [hl] ; $4311
	bit 7, d ; $4312
	jr z, Label_04_4318 ; $4314
	cpl ; $4316
	inc a ; $4317
Label_04_4318:
	add a, e ; $4318
	dec hl ; $4319
	ld [hl], a ; $431a
	ld e, a ; $431b
	ld hl, $0006 ; $431c
	add hl, bc ; $431f
	ld a, [hl+] ; $4320
	ld h, [hl] ; $4321
	ld l, a ; $4322
	ld a, e ; $4323
	call Func_00_0af8 ; $4324
	push hl ; $4327
	ld hl, $ffea ; $4328
	ld a, [hl+] ; $432b
	ld b, [hl] ; $432c
	ld c, a ; $432d
	ld hl, $0005 ; $432e
	add hl, bc ; $4331
	bit 2, [hl] ; $4332
	pop hl ; $4334
	jr z, Label_04_4365 ; $4335
	push de ; $4337
	push hl ; $4338
	push de ; $4339
	ld e, l ; $433a
	ld d, h ; $433b
	ld hl, $000c ; $433c
	add hl, bc ; $433f
	ld a, [hl+] ; $4340
	ld h, [hl] ; $4341
	ld l, a ; $4342
	add hl, de ; $4343
	pop de ; $4344
	push hl ; $4345
	ld hl, $000e ; $4346
	add hl, bc ; $4349
	ld a, [hl+] ; $434a
	ld h, [hl] ; $434b
	ld l, a ; $434c
	add hl, de ; $434d
	ld e, l ; $434e
	ld d, h ; $434f
	pop hl ; $4350
	call Func_04_537a ; $4351
	pop hl ; $4354
	pop de ; $4355
	and a, a ; $4356
	jr z, Label_04_4365 ; $4357
	ld hl, $0005 ; $4359
	add hl, bc ; $435c
	set 6, [hl] ; $435d
	pop af ; $435f
	pop hl ; $4360
	pop de ; $4361
	jp Label_04_4400 ; $4362
Label_04_4365:
	ld bc, $0001 ; $4365
	pop af ; $4368
	add a, $20 ; $4369
	and a, $40 ; $436b
	jr z, Label_04_4370 ; $436d
	inc c ; $436f
Label_04_4370:
	push hl ; $4370
	ld hl, $ffea ; $4371
	ld a, [hl+] ; $4374
	ld h, [hl] ; $4375
	add a, $0e ; $4376
	ld l, a ; $4378
	push hl ; $4379
	ld a, [hl+] ; $437a
	ld h, [hl] ; $437b
	ld l, a ; $437c
	add hl, de ; $437d
	pop de ; $437e
	ld a, l ; $437f
	ld [de], a ; $4380
	inc de ; $4381
	ld a, h ; $4382
	ld [de], a ; $4383
	push hl ; $4384
	ld hl, $ffea ; $4385
	ld a, [hl+] ; $4388
	ld h, [hl] ; $4389
	add a, $0a ; $438a
	ld l, a ; $438c
	ld a, [hl+] ; $438d
	ld d, [hl] ; $438e
	ld e, a ; $438f
	pop hl ; $4390
	ld a, l ; $4391
	sub a, e ; $4392
	ld l, a ; $4393
	ld a, h ; $4394
	sbc a, d ; $4395
	ld h, a ; $4396
	ld a, h ; $4397
	or a, l ; $4398
	jr nz, Label_04_439d ; $4399
	set 1, b ; $439b
Label_04_439d:
	pop de ; $439d
	ld a, h ; $439e
	pop hl ; $439f
	xor a, h ; $43a0
	bit 7, a ; $43a1
	jr z, Label_04_43a7 ; $43a3
	set 1, b ; $43a5
Label_04_43a7:
	ld hl, $ffea ; $43a7
	ld a, [hl+] ; $43aa
	ld h, [hl] ; $43ab
	add a, $0c ; $43ac
	ld l, a ; $43ae
	push hl ; $43af
	ld a, [hl+] ; $43b0
	ld h, [hl] ; $43b1
	ld l, a ; $43b2
	add hl, de ; $43b3
	pop de ; $43b4
	ld a, l ; $43b5
	ld [de], a ; $43b6
	inc de ; $43b7
	ld a, h ; $43b8
	ld [de], a ; $43b9
	push hl ; $43ba
	ld hl, $ffea ; $43bb
	ld a, [hl+] ; $43be
	ld h, [hl] ; $43bf
	add a, $08 ; $43c0
	ld l, a ; $43c2
	ld a, [hl+] ; $43c3
	ld d, [hl] ; $43c4
	ld e, a ; $43c5
	pop hl ; $43c6
	ld a, l ; $43c7
	sub a, e ; $43c8
	ld l, a ; $43c9
	ld a, h ; $43ca
	sbc a, d ; $43cb
	ld h, a ; $43cc
	ld a, h ; $43cd
	or a, l ; $43ce
	jr nz, Label_04_43d3 ; $43cf
	set 0, b ; $43d1
Label_04_43d3:
	ld a, h ; $43d3
	pop hl ; $43d4
	xor a, h ; $43d5
	bit 7, a ; $43d6
	jr z, Label_04_43dc ; $43d8
	set 0, b ; $43da
Label_04_43dc:
	ld a, b ; $43dc
	and a, c ; $43dd
	jr z, Label_04_4400 ; $43de
	ld hl, $ffea ; $43e0
	ld a, [hl+] ; $43e3
	ld b, [hl] ; $43e4
	ld c, a ; $43e5
	ld hl, $0005 ; $43e6
	add hl, bc ; $43e9
	res 7, [hl] ; $43ea
	ld a, $0c ; $43ec
	add a, c ; $43ee
	ld e, a ; $43ef
	ld d, b ; $43f0
	ld hl, $0008 ; $43f1
	add hl, bc ; $43f4
	ld a, [hl+] ; $43f5
	ld [de], a ; $43f6
	inc de ; $43f7
	ld a, [hl+] ; $43f8
	ld [de], a ; $43f9
	inc de ; $43fa
	ld a, [hl+] ; $43fb
	ld [de], a ; $43fc
	inc de ; $43fd
	ld a, [hl+] ; $43fe
	ld [de], a ; $43ff
Label_04_4400:
	pop bc ; $4400
	ret ; $4401
Func_04_4402:
	ld hl, $0020 ; $4402
	add hl, bc ; $4405
	ld a, [hl] ; $4406
	cp a, $01 ; $4407
	ret nz ; $4409
	push af ; $440a
	push de ; $440b
	push hl ; $440c
	ld a, $04 ; $440d
	ldh [$ff96], a ; $440f
	ldh [rWBK], a ; $4411
	ld hl, $000c ; $4413
	add hl, bc ; $4416
	ld a, [hl+] ; $4417
	ld h, [hl] ; $4418
	ld l, a ; $4419
	ld de, $f610 ; $441a
	add hl, de ; $441d
	ld a, [$c329] ; $441e
	ld d, a ; $4421
	ld a, h ; $4422
	sub a, d ; $4423
	bit 7, a ; $4424
	jr z, Label_04_442d ; $4426
	ld h, d ; $4428
	ld l, $00 ; $4429
	jr Label_04_443c ; $442b
Label_04_442d:
	ld a, [$c32b] ; $442d
	sub a, $14 ; $4430
	ld d, a ; $4432
	ld a, h ; $4433
	sub a, d ; $4434
	bit 7, a ; $4435
	jr nz, Label_04_443c ; $4437
	ld h, d ; $4439
	ld l, $00 ; $443a
Label_04_443c:
	ld a, l ; $443c
	and a, $e0 ; $443d
	ld [$c320], a ; $443f
	ld a, h ; $4442
	ld [$c321], a ; $4443
	ld hl, $000e ; $4446
	add hl, bc ; $4449
	ld a, [hl+] ; $444a
	ld h, [hl] ; $444b
	ld l, a ; $444c
	ld de, $f710 ; $444d
	add hl, de ; $4450
	ld a, [$c32a] ; $4451
	ld d, a ; $4454
	ld a, h ; $4455
	sub a, d ; $4456
	bit 7, a ; $4457
	jr z, Label_04_4460 ; $4459
	ld h, d ; $445b
	ld l, $00 ; $445c
	jr Label_04_446f ; $445e
Label_04_4460:
	ld a, [$c32c] ; $4460
	sub a, $12 ; $4463
	ld d, a ; $4465
	ld a, h ; $4466
	sub a, d ; $4467
	bit 7, a ; $4468
	jr nz, Label_04_446f ; $446a
	ld h, d ; $446c
	ld l, $00 ; $446d
Label_04_446f:
	ld a, l ; $446f
	and a, $e0 ; $4470
	ld [$c322], a ; $4472
	ld a, h ; $4475
	ld [$c323], a ; $4476
	pop hl ; $4479
	pop de ; $447a
	pop af ; $447b
	ret ; $447c
	INCBIN "data/bank_004/d_447d.bin" ; $447d, 83 bytes
	inc de ; $44d0
	ld a, [$daf7] ; $44d1
	ld l, e ; $44d4
	ld h, d ; $44d5
	call Func_00_063d ; $44d6
	add hl, bc ; $44d9
	ld e, l ; $44da
	ld d, h ; $44db
	ld a, $01 ; $44dc
	ret ; $44de
	INCBIN "data/bank_004/d_44df.bin" ; $44df, 299 bytes
	xor a, a ; $460a
	ret ; $460b
	INCBIN "data/bank_004/d_460c.bin" ; $460c, 23 bytes
	inc de ; $4623
	push de ; $4624
	ld hl, $ffea ; $4625
	ld a, [hl+] ; $4628
	ld b, [hl] ; $4629
	ld c, a ; $462a
	ld hl, $0016 ; $462b
	add hl, bc ; $462e
	ld a, [hl+] ; $462f
	ld d, [hl] ; $4630
	ld e, a ; $4631
	ld hl, $000c ; $4632
	add hl, de ; $4635
	ld a, $08 ; $4636
	add a, c ; $4638
	ld e, a ; $4639
	ld d, b ; $463a
	ld a, [hl+] ; $463b
	ld [de], a ; $463c
	inc de ; $463d
	ld a, [hl+] ; $463e
	ld [de], a ; $463f
	inc de ; $4640
	ld a, [hl+] ; $4641
	ld [de], a ; $4642
	inc de ; $4643
	ld a, [hl+] ; $4644
	ld [de], a ; $4645
	call Func_04_475a ; $4646
	jr z, Label_04_46ad ; $4649
	ld hl, $0009 ; $464b
	add hl, bc ; $464e
	ld a, [hl] ; $464f
	ld hl, $000d ; $4650
	add hl, bc ; $4653
	sub a, [hl] ; $4654
	bit 7, a ; $4655
	jr z, Label_04_465b ; $4657
	cpl ; $4659
	inc a ; $465a
Label_04_465b:
	call Func_00_106e ; $465b
	push hl ; $465e
	ld hl, $000b ; $465f
	add hl, bc ; $4662
	ld a, [hl] ; $4663
	ld hl, $000f ; $4664
	add hl, bc ; $4667
	sub a, [hl] ; $4668
	bit 7, a ; $4669
	jr z, Label_04_466f ; $466b
	cpl ; $466d
	inc a ; $466e
Label_04_466f:
	call Func_00_106e ; $466f
	pop de ; $4672
	add hl, de ; $4673
	ld a, h ; $4674
	or a, a ; $4675
	jr nz, Label_04_469d ; $4676
	ld a, l ; $4678
	cp a, $01 ; $4679
	jr nc, Label_04_4682 ; $467b
	ld de, $0010 ; $467d
	jr Label_04_46a0 ; $4680
Label_04_4682:
	cp a, $04 ; $4682
	jr nc, Label_04_468b ; $4684
	ld de, $0018 ; $4686
	jr Label_04_46a0 ; $4689
Label_04_468b:
	cp a, $09 ; $468b
	jr nc, Label_04_4694 ; $468d
	ld de, $0020 ; $468f
	jr Label_04_46a0 ; $4692
Label_04_4694:
	cp a, $10 ; $4694
	jr nc, Label_04_469d ; $4696
	ld de, $0040 ; $4698
	jr Label_04_46a0 ; $469b
Label_04_469d:
	ld de, $0080 ; $469d
Label_04_46a0:
	ld hl, $0006 ; $46a0
	add hl, bc ; $46a3
	ld a, e ; $46a4
	ld [hl+], a ; $46a5
	ld [hl], d ; $46a6
	ld hl, $0005 ; $46a7
	add hl, bc ; $46aa
	set 7, [hl] ; $46ab
Label_04_46ad:
	pop de ; $46ad
	xor a, a ; $46ae
	ret ; $46af
	INCBIN "data/bank_004/d_46b0.bin" ; $46b0, 170 bytes
Func_04_475a:
	ld hl, $000c ; $475a
	add hl, bc ; $475d
	ld a, $08 ; $475e
	add a, c ; $4760
	ld e, a ; $4761
	ld d, b ; $4762
	ld a, [de] ; $4763
	cp a, [hl] ; $4764
	jr nz, Label_04_477b ; $4765
	inc hl ; $4767
	inc de ; $4768
	ld a, [de] ; $4769
	cp a, [hl] ; $476a
	jr nz, Label_04_477b ; $476b
	inc hl ; $476d
	inc de ; $476e
	ld a, [de] ; $476f
	cp a, [hl] ; $4770
	jr nz, Label_04_477b ; $4771
	inc hl ; $4773
	inc de ; $4774
	ld a, [de] ; $4775
	cp a, [hl] ; $4776
	jr nz, Label_04_477b ; $4777
	xor a, a ; $4779
	ret ; $477a
Label_04_477b:
	ld a, $01 ; $477b
	or a, a ; $477d
	ret ; $477e
	INCBIN "data/bank_004/d_477f.bin" ; $477f, 680 bytes
Func_04_4a27:
	ld hl, $c320 ; $4a27
	ld a, [hl+] ; $4a2a
	ld d, [hl] ; $4a2b
	ld e, a ; $4a2c
	ld a, [$c368] ; $4a2d
	ld l, a ; $4a30
	ld h, $00 ; $4a31
	bit 7, l ; $4a33
	jr z, Label_04_4a39 ; $4a35
	ld h, $ff ; $4a37
Label_04_4a39:
	add hl, hl ; $4a39
	add hl, hl ; $4a3a
	add hl, hl ; $4a3b
	add hl, hl ; $4a3c
	add hl, hl ; $4a3d
	add hl, de ; $4a3e
	xor a, a ; $4a3f
	sub a, l ; $4a40
	ld l, a ; $4a41
	sbc a, a ; $4a42
	sub a, h ; $4a43
	ld h, a ; $4a44
	ld c, l ; $4a45
	ld b, h ; $4a46
	ld hl, $dae0 ; $4a47
	ld a, c ; $4a4a
	ld [hl+], a ; $4a4b
	ld [hl], b ; $4a4c
	ld hl, $c322 ; $4a4d
	ld a, [hl+] ; $4a50
	ld d, [hl] ; $4a51
	ld e, a ; $4a52
	rst Rst30 ; $4a53
	ret nz ; $4a54
	dec c ; $4a55
	jr z, Label_04_4a61 ; $4a56
	ld hl, $cb02 ; $4a58
	ld a, [hl+] ; $4a5b
	ld h, [hl] ; $4a5c
	ld l, a ; $4a5d
	add hl, de ; $4a5e
	ld d, h ; $4a5f
	ld e, l ; $4a60
Label_04_4a61:
	ld a, [$c369] ; $4a61
	ld l, a ; $4a64
	ld h, $00 ; $4a65
	bit 7, l ; $4a67
	jr z, Label_04_4a6d ; $4a69
	ld h, $ff ; $4a6b
Label_04_4a6d:
	add hl, hl ; $4a6d
	add hl, hl ; $4a6e
	add hl, hl ; $4a6f
	add hl, hl ; $4a70
	add hl, hl ; $4a71
	add hl, de ; $4a72
	xor a, a ; $4a73
	sub a, l ; $4a74
	ld l, a ; $4a75
	sbc a, a ; $4a76
	sub a, h ; $4a77
	ld h, a ; $4a78
	ld c, l ; $4a79
	ld b, h ; $4a7a
	ld hl, $dae2 ; $4a7b
	ld a, c ; $4a7e
	ld [hl+], a ; $4a7f
	ld [hl], b ; $4a80
	ret ; $4a81
	rst Rst30 ; $4a82
	add a, b ; $4a83
	ld [bc], a ; $4a84
	ret nz ; $4a85
	ld a, $04 ; $4a86
	ldh [$ff96], a ; $4a88
	ldh [rWBK], a ; $4a8a
	call Func_04_4a27 ; $4a8c
	ld bc, $d000 ; $4a8f
	ld e, $18 ; $4a92
Label_04_4a94:
	inc c ; $4a94
	ld a, [bc] ; $4a95
	dec c ; $4a96
	or a, a ; $4a97
	jr z, Label_04_4ab9 ; $4a98
	ld hl, $0031 ; $4a9a
	add hl, bc ; $4a9d
	ld a, [hl] ; $4a9e
	and a, a ; $4a9f
	jr z, Label_04_4aa5 ; $4aa0
	dec [hl] ; $4aa2
	jr Label_04_4ab9 ; $4aa3
Label_04_4aa5:
	push de ; $4aa5
	ld hl, $0022 ; $4aa6
	add hl, bc ; $4aa9
	ld a, [hl] ; $4aaa
	ld [$daf7], a ; $4aab
	ld hl, $0020 ; $4aae
	add hl, bc ; $4ab1
	ld a, [hl] ; $4ab2
	cp a, $02 ; $4ab3
	call z, Func_04_5526 ; $4ab5
	pop de ; $4ab8
Label_04_4ab9:
	ld hl, $0040 ; $4ab9
	add hl, bc ; $4abc
	ld c, l ; $4abd
	ld b, h ; $4abe
	dec e ; $4abf
	jr nz, Label_04_4a94 ; $4ac0
	ret ; $4ac2
	INCBIN "data/bank_004/d_4ac3.bin" ; $4ac3, 3 bytes
Func_04_4ac6:
	push af ; $4ac6
	push de ; $4ac7
	push hl ; $4ac8
	ld a, $04 ; $4ac9
	ldh [$ff96], a ; $4acb
	ldh [rWBK], a ; $4acd
	ld hl, $0021 ; $4acf
	add hl, bc ; $4ad2
	ld [hl], d ; $4ad3
	ld a, d ; $4ad4
	add a, a ; $4ad5
	add a, $75 ; $4ad6
	ld l, a ; $4ad8
	adc a, $4f ; $4ad9
	sub a, l ; $4adb
	ld h, a ; $4adc
	ld a, [hl+] ; $4add
	ld h, [hl] ; $4ade
	ld l, a ; $4adf
	ld a, $22 ; $4ae0
	add a, c ; $4ae2
	ld e, a ; $4ae3
	ld d, b ; $4ae4
	ld a, h ; $4ae5
	ld [de], a ; $4ae6
	push bc ; $4ae7
	ld de, $dad0 ; $4ae8
	ld bc, $0010 ; $4aeb
	call CopyDataFromBank ; $4aee
	pop bc ; $4af1
	ld a, [$dad0] ; $4af2
	ld hl, $0037 ; $4af5
	add hl, bc ; $4af8
	ld [hl], a ; $4af9
	ld a, [$dad1] ; $4afa
	ld hl, $0035 ; $4afd
	add hl, bc ; $4b00
	ld [hl], a ; $4b01
	ld hl, $0024 ; $4b02
	add hl, bc ; $4b05
	ld a, [$dad4] ; $4b06
	ld [hl+], a ; $4b09
	ld a, [$dad5] ; $4b0a
	ld [hl+], a ; $4b0d
	ld hl, $0028 ; $4b0e
	add hl, bc ; $4b11
	ld a, [$dad6] ; $4b12
	ld [hl+], a ; $4b15
	ld a, [$dad7] ; $4b16
	ld [hl+], a ; $4b19
	ld hl, $0038 ; $4b1a
	add hl, bc ; $4b1d
	ld a, [$dada] ; $4b1e
	ld [hl+], a ; $4b21
	ld a, [$dadb] ; $4b22
	ld [hl+], a ; $4b25
	ld hl, $0037 ; $4b26
	add hl, bc ; $4b29
	ld a, [hl] ; $4b2a
	cp a, $63 ; $4b2b
	jr nz, Label_04_4b51 ; $4b2d
	ld [hl], $02 ; $4b2f
	push bc ; $4b31
	ld hl, $dad8 ; $4b32
	ld a, [hl+] ; $4b35
	ld h, [hl] ; $4b36
	ld l, a ; $4b37
	ld a, $22 ; $4b38
	add a, c ; $4b3a
	ld e, a ; $4b3b
	ld d, b ; $4b3c
	ld a, [de] ; $4b3d
	ld de, $dad0 ; $4b3e
	ld bc, $0008 ; $4b41
	call Func_00_067a ; $4b44
	ld hl, $dad0 ; $4b47
	ld de, $0a01 ; $4b4a
	call Func_00_05e1 ; $4b4d
	pop bc ; $4b50
Label_04_4b51:
	ld hl, $0020 ; $4b51
	add hl, bc ; $4b54
	ld [hl], $02 ; $4b55
	ld hl, $0032 ; $4b57
	add hl, bc ; $4b5a
	ld a, $ff ; $4b5b
	ld [hl+], a ; $4b5d
	ld [hl+], a ; $4b5e
	ld d, $00 ; $4b5f
	call Func_04_4bbe ; $4b61
	pop hl ; $4b64
	pop de ; $4b65
	pop af ; $4b66
	ret ; $4b67
	ld a, d ; $4b68
	ld [$df21], a ; $4b69
	add a, a ; $4b6c
	add a, $75 ; $4b6d
	ld l, a ; $4b6f
	adc a, $4f ; $4b70
	sub a, l ; $4b72
	ld h, a ; $4b73
	ld a, [hl+] ; $4b74
	ld h, [hl] ; $4b75
	ld l, a ; $4b76
	ld a, h ; $4b77
	ld [$df22], a ; $4b78
	ld de, $dad0 ; $4b7b
	ld bc, $0010 ; $4b7e
	call CopyDataFromBank ; $4b81
	ld a, [$dad0] ; $4b84
	ld [$df37], a ; $4b87
	ld [$df3a], a ; $4b8a
	ld hl, $df24 ; $4b8d
	ld a, [$dad4] ; $4b90
	ld [hl+], a ; $4b93
	ld a, [$dad5] ; $4b94
	ld [hl+], a ; $4b97
	ld hl, $df28 ; $4b98
	ld a, [$dad6] ; $4b9b
	ld [hl+], a ; $4b9e
	ld a, [$dad7] ; $4b9f
	ld [hl+], a ; $4ba2
	ld hl, $df38 ; $4ba3
	ld a, [$dada] ; $4ba6
	ld [hl+], a ; $4ba9
	ld a, [$dadb] ; $4baa
	ld [hl+], a ; $4bad
	ld hl, $df32 ; $4bae
	ld a, $ff ; $4bb1
	ld [hl+], a ; $4bb3
	ld [hl+], a ; $4bb4
	ld d, $01 ; $4bb5
	rst Rst18 ; $4bb7
	jr nz, $4bc2 ; $4bb8
	ret ; $4bba
	INCBIN "data/bank_004/d_4bbb.bin" ; $4bbb, 3 bytes
Func_04_4bbe:
	push af ; $4bbe
	push de ; $4bbf
	push hl ; $4bc0
	ld a, $04 ; $4bc1
	ldh [$ff96], a ; $4bc3
	ldh [rWBK], a ; $4bc5
	ld hl, $002e ; $4bc7
	add hl, bc ; $4bca
	ld a, [hl] ; $4bcb
	cp a, d ; $4bcc
	jr z, Label_04_4c07 ; $4bcd
	ld [hl], d ; $4bcf
	ld hl, $002f ; $4bd0
	add hl, bc ; $4bd3
	ld [hl], $00 ; $4bd4
	ld hl, $df37 ; $4bd6
	ld a, [hl] ; $4bd9
	and a, $0f ; $4bda
	ld [hl], a ; $4bdc
	push bc ; $4bdd
	ld hl, $0028 ; $4bde
	add hl, bc ; $4be1
	ld a, [hl+] ; $4be2
	ld h, [hl] ; $4be3
	ld l, a ; $4be4
	ld a, d ; $4be5
	add a, a ; $4be6
	add a, l ; $4be7
	ld l, a ; $4be8
	jr nc, Label_04_4bec ; $4be9
	inc h ; $4beb
Label_04_4bec:
	push hl ; $4bec
	ld hl, $0022 ; $4bed
	add hl, bc ; $4bf0
	ld a, [hl] ; $4bf1
	pop hl ; $4bf2
	call Func_00_063d ; $4bf3
	ld e, c ; $4bf6
	ld d, b ; $4bf7
	pop bc ; $4bf8
	ld hl, $002a ; $4bf9
	add hl, bc ; $4bfc
	ld a, e ; $4bfd
	ld [hl+], a ; $4bfe
	ld [hl], d ; $4bff
	ld hl, $002c ; $4c00
	add hl, bc ; $4c03
	ld a, e ; $4c04
	ld [hl+], a ; $4c05
	ld [hl], d ; $4c06
Label_04_4c07:
	pop hl ; $4c07
	pop de ; $4c08
	pop af ; $4c09
	ret ; $4c0a
	INCBIN "data/bank_004/d_4c0b.bin" ; $4c0b, 62 bytes
Func_04_4c49:
	ld a, e ; $4c49
	or a, d ; $4c4a
	ret z ; $4c4b
	bit 7, d ; $4c4c
	jr nz, Label_04_4c54 ; $4c4e
	call Func_00_249f ; $4c50
	ret ; $4c53
Label_04_4c54:
	res 7, d ; $4c54
	call Func_00_249f ; $4c56
	jr z, Label_04_4c5d ; $4c59
	xor a, a ; $4c5b
	ret ; $4c5c
Label_04_4c5d:
	xor a, a ; $4c5d
	inc a ; $4c5e
	ret ; $4c5f
Func_04_4c60:
	push af ; $4c60
	push de ; $4c61
	push hl ; $4c62
	ld b, a ; $4c63
	push de ; $4c64
	ld a, [hl+] ; $4c65
	ld e, a ; $4c66
	ld a, [hl+] ; $4c67
	ld d, a ; $4c68
	call Func_04_4c49 ; $4c69
	pop de ; $4c6c
	jr z, Label_04_4c79 ; $4c6d
	ldh a, [$ff95] ; $4c6f
	ld hl, $41d1 ; $4c71
	call Func_04_4055 ; $4c74
	jr Label_04_4cf3 ; $4c77
Label_04_4c79:
	ld a, [hl+] ; $4c79
	ld e, a ; $4c7a
	ld a, [hl+] ; $4c7b
	ld d, a ; $4c7c
	ld a, b ; $4c7d
	push hl ; $4c7e
	ld l, e ; $4c7f
	ld h, d ; $4c80
	call Func_04_4055 ; $4c81
	pop hl ; $4c84
	inc b ; $4c85
	dec b ; $4c86
	jr z, Label_04_4cf3 ; $4c87
	ld a, $0c ; $4c89
	add a, c ; $4c8b
	ld e, a ; $4c8c
	ld d, b ; $4c8d
	ld a, [hl+] ; $4c8e
	ld [de], a ; $4c8f
	inc de ; $4c90
	ld a, [hl-] ; $4c91
	ld [de], a ; $4c92
	ld a, $08 ; $4c93
	add a, c ; $4c95
	ld e, a ; $4c96
	ld d, b ; $4c97
	ld a, [hl+] ; $4c98
	ld [de], a ; $4c99
	inc de ; $4c9a
	ld a, [hl+] ; $4c9b
	ld [de], a ; $4c9c
	ld a, $0e ; $4c9d
	add a, c ; $4c9f
	ld e, a ; $4ca0
	ld d, b ; $4ca1
	ld a, [hl+] ; $4ca2
	ld [de], a ; $4ca3
	inc de ; $4ca4
	ld a, [hl-] ; $4ca5
	ld [de], a ; $4ca6
	ld a, $0a ; $4ca7
	add a, c ; $4ca9
	ld e, a ; $4caa
	ld d, b ; $4cab
	ld a, [hl+] ; $4cac
	ld [de], a ; $4cad
	inc de ; $4cae
	ld a, [hl+] ; $4caf
	ld [de], a ; $4cb0
	ld a, $14 ; $4cb1
	add a, c ; $4cb3
	ld e, a ; $4cb4
	ld d, b ; $4cb5
	ld a, [hl+] ; $4cb6
	ld [de], a ; $4cb7
	inc hl ; $4cb8
	ld a, [hl+] ; $4cb9
	ld d, a ; $4cba
	call Func_04_4ac6 ; $4cbb
	ld a, [hl+] ; $4cbe
	ld d, a ; $4cbf
	call Func_04_4bbe ; $4cc0
	ld a, [hl] ; $4cc3
	cp a, $00 ; $4cc4
	jr z, Label_04_4ccf ; $4cc6
	ld a, $37 ; $4cc8
	add a, c ; $4cca
	ld e, a ; $4ccb
	ld d, b ; $4ccc
	ld a, [hl] ; $4ccd
	ld [de], a ; $4cce
Label_04_4ccf:
	inc hl ; $4ccf
	inc hl ; $4cd0
	ld hl, $0005 ; $4cd1
	add hl, bc ; $4cd4
	set 3, [hl] ; $4cd5
	set 4, [hl] ; $4cd7
	ld l, c ; $4cd9
	ld h, b ; $4cda
	add hl, hl ; $4cdb
	add hl, hl ; $4cdc
	ld a, h ; $4cdd
	and a, $0f ; $4cde
	ld hl, $0031 ; $4ce0
	add hl, bc ; $4ce3
	ld [hl], a ; $4ce4
	ld hl, $0018 ; $4ce5
	add hl, bc ; $4ce8
	ld a, $01 ; $4ce9
	ld [hl], a ; $4ceb
	ld hl, $0019 ; $4cec
	add hl, bc ; $4cef
	ld a, $02 ; $4cf0
	ld [hl], a ; $4cf2
Label_04_4cf3:
	pop hl ; $4cf3
	pop de ; $4cf4
	pop af ; $4cf5
	ret ; $4cf6
	push af ; $4cf7
	push bc ; $4cf8
	push de ; $4cf9
	push hl ; $4cfa
	ld b, a ; $4cfb
	ldh a, [$ff96] ; $4cfc
	push af ; $4cfe
	ld a, $04 ; $4cff
	ldh [$ff96], a ; $4d01
	ldh [rWBK], a ; $4d03
	ld a, b ; $4d05
Label_04_4d06:
	push af ; $4d06
	ld de, $dac0 ; $4d07
	ld bc, $000e ; $4d0a
	call Func_00_067a ; $4d0d
	ld a, [$dac9] ; $4d10
	inc a ; $4d13
	jr z, Label_04_4d21 ; $4d14
	pop af ; $4d16
	push hl ; $4d17
	ld hl, $dac0 ; $4d18
	call Func_04_4c60 ; $4d1b
	pop hl ; $4d1e
	jr Label_04_4d06 ; $4d1f
Label_04_4d21:
	pop af ; $4d21
	pop af ; $4d22
	ldh [$ff96], a ; $4d23
	ldh [rWBK], a ; $4d25
	pop hl ; $4d27
	pop de ; $4d28
	pop bc ; $4d29
	pop af ; $4d2a
	ret ; $4d2b
	INCBIN "data/bank_004/d_4d2c.bin" ; $4d2c, 319 bytes
	push af ; $4e6b
	push bc ; $4e6c
	push de ; $4e6d
	push hl ; $4e6e
	ld a, $04 ; $4e6f
	ldh [$ff96], a ; $4e71
	ldh [rWBK], a ; $4e73
	push hl ; $4e75
	push bc ; $4e76
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4e77
	and a, $03 ; $4e7a
	add a, a ; $4e7c
	add a, $5f ; $4e7d
	ld l, a ; $4e7f
	adc a, $4e ; $4e80
	sub a, l ; $4e82
	ld h, a ; $4e83
	ld a, [hl+] ; $4e84
	ld h, [hl] ; $4e85
	ld l, a ; $4e86
	ldh a, [$ff95] ; $4e87
	call Func_04_4c60 ; $4e89
	pop bc ; $4e8c
	ld a, c ; $4e8d
	ld [$d014], a ; $4e8e
	ld [$daea], a ; $4e91
	pop hl ; $4e94
	ld bc, $d000 ; $4e95
	call Func_04_40c6 ; $4e98
	push de ; $4e9b
	push hl ; $4e9c
	ldh a, [$ff95] ; $4e9d
	ld de, $41d1 ; $4e9f
	call Func_04_4055 ; $4ea2
	ld a, $01 ; $4ea5
	call Func_04_4148 ; $4ea7
	ld de, $d000 ; $4eaa
	call Func_04_417b ; $4ead
	pop hl ; $4eb0
	pop de ; $4eb1
	call Func_04_40c6 ; $4eb2
	ld hl, $c90c ; $4eb5
	ld a, [hl] ; $4eb8
	add a, $03 ; $4eb9
	ld bc, $d000 ; $4ebb
	ld hl, $0037 ; $4ebe
	add hl, bc ; $4ec1
	ld [hl], a ; $4ec2
	pop hl ; $4ec3
	pop de ; $4ec4
	pop bc ; $4ec5
	pop af ; $4ec6
	ret ; $4ec7
	INCBIN "data/bank_004/d_4ec8.bin" ; $4ec8, 72 bytes
	push af ; $4f10
	push bc ; $4f11
	push de ; $4f12
	push hl ; $4f13
	ld a, $04 ; $4f14
	ldh [$ff96], a ; $4f16
	ldh [rWBK], a ; $4f18
	ld a, [$c94d] ; $4f1a
	or a, a ; $4f1d
	jr nz, Label_04_4f2c ; $4f1e
	ld hl, $4ec8 ; $4f20
	ld a, $02 ; $4f23
	rst Rst30 ; $4f25
	ldh [rTIMA], a ; $4f26
	jr nz, Label_04_4f3b ; $4f28
	jr Label_04_4f36 ; $4f2a
Label_04_4f2c:
	ld hl, $4ee0 ; $4f2c
	ld a, $03 ; $4f2f
	rst Rst30 ; $4f31
	ldh [rTIMA], a ; $4f32
	jr nz, Label_04_4f3b ; $4f34
Label_04_4f36:
	ld hl, $4ef8 ; $4f36
	ld a, $ff ; $4f39
Label_04_4f3b:
	ld [$cb5e], a ; $4f3b
	ldh a, [$ff95] ; $4f3e
	call Func_04_4c60 ; $4f40
	ld a, [$cb5e] ; $4f43
	cp a, $ff ; $4f46
	jr z, Label_04_4f70 ; $4f48
	ld de, $d000 ; $4f4a
	call Func_04_41a6 ; $4f4d
	ld de, $d000 ; $4f50
	ld hl, $0014 ; $4f53
	add hl, de ; $4f56
	ld a, [hl] ; $4f57
	ld hl, $0014 ; $4f58
	add hl, bc ; $4f5b
	ld [hl], a ; $4f5c
	ld hl, $000c ; $4f5d
	add hl, de ; $4f60
	push hl ; $4f61
	ld hl, $000e ; $4f62
	add hl, de ; $4f65
	ld a, [hl+] ; $4f66
	ld d, [hl] ; $4f67
	ld e, a ; $4f68
	pop hl ; $4f69
	ld a, [hl+] ; $4f6a
	ld h, [hl] ; $4f6b
	ld l, a ; $4f6c
	call Func_04_40c6 ; $4f6d
Label_04_4f70:
	pop hl ; $4f70
	pop de ; $4f71
	pop bc ; $4f72
	pop af ; $4f73
	ret ; $4f74
	INCBIN "data/bank_004/d_4f75.bin" ; $4f75, 1029 bytes
Func_04_537a:
	push bc ; $537a
	push de ; $537b
	push hl ; $537c
	ld c, l ; $537d
	ld b, h ; $537e
	ld hl, $d00a ; $537f
	ld a, [hl+] ; $5382
	ld h, [hl] ; $5383
	ld l, a ; $5384
	ld a, l ; $5385
	sub a, e ; $5386
	ld l, a ; $5387
	ld a, h ; $5388
	sbc a, d ; $5389
	ld h, a ; $538a
	bit 7, h ; $538b
	jr z, Label_04_5395 ; $538d
	xor a, a ; $538f
	sub a, l ; $5390
	ld l, a ; $5391
	sbc a, a ; $5392
	sub a, h ; $5393
	ld h, a ; $5394
Label_04_5395:
	srl h ; $5395
	rr l ; $5397
	ld a, h ; $5399
	and a, a ; $539a
	jr nz, Label_04_53d2 ; $539b
	ld a, l ; $539d
	call Func_00_106e ; $539e
	ld e, l ; $53a1
	ld d, h ; $53a2
	ld hl, $d008 ; $53a3
	ld a, [hl+] ; $53a6
	ld h, [hl] ; $53a7
	ld l, a ; $53a8
	ld a, l ; $53a9
	sub a, c ; $53aa
	ld l, a ; $53ab
	ld a, h ; $53ac
	sbc a, b ; $53ad
	ld h, a ; $53ae
	bit 7, h ; $53af
	jr z, Label_04_53b9 ; $53b1
	xor a, a ; $53b3
	sub a, l ; $53b4
	ld l, a ; $53b5
	sbc a, a ; $53b6
	sub a, h ; $53b7
	ld h, a ; $53b8
Label_04_53b9:
	srl h ; $53b9
	rr l ; $53bb
	ld a, h ; $53bd
	and a, a ; $53be
	jr nz, Label_04_53d2 ; $53bf
	ld a, l ; $53c1
	call Func_00_106e ; $53c2
	add hl, de ; $53c5
	jr c, Label_04_53d2 ; $53c6
	ld de, $4000 ; $53c8
	add hl, de ; $53cb
	jr c, Label_04_53d2 ; $53cc
	ld a, $01 ; $53ce
	jr Label_04_53d3 ; $53d0
Label_04_53d2:
	xor a, a ; $53d2
Label_04_53d3:
	pop hl ; $53d3
	pop de ; $53d4
	pop bc ; $53d5
	ret ; $53d6
	INCBIN "data/bank_004/d_53d7.bin" ; $53d7, 335 bytes
Func_04_5526:
	call Func_04_5542 ; $5526
	ld hl, $0030 ; $5529
	add hl, bc ; $552c
	bit 7, [hl] ; $552d
	jr nz, Label_04_5538 ; $552f
	bit 3, [hl] ; $5531
	ret z ; $5533
	call Func_04_55c1 ; $5534
	ret ; $5537
Label_04_5538:
	call Func_04_55c1 ; $5538
	call Func_04_5673 ; $553b
	call Func_04_56c3 ; $553e
	ret ; $5541
Func_04_5542:
	ld hl, $0030 ; $5542
	add hl, bc ; $5545
	res 7, [hl] ; $5546
	ld hl, $dae2 ; $5548
	ld a, [hl+] ; $554b
	ld d, [hl] ; $554c
	ld e, a ; $554d
	ld hl, $0010 ; $554e
	add hl, bc ; $5551
	ld a, [hl+] ; $5552
	ld h, [hl] ; $5553
	ld l, a ; $5554
	bit 7, h ; $5555
	jr z, Label_04_557b ; $5557
	xor a, a ; $5559
	sub a, l ; $555a
	ld l, a ; $555b
	sbc a, a ; $555c
	sub a, h ; $555d
	ld h, a ; $555e
	xor a, a ; $555f
	sub a, e ; $5560
	ld e, a ; $5561
	sbc a, a ; $5562
	sub a, d ; $5563
	ld d, a ; $5564
	srl h ; $5565
	rr l ; $5567
	add hl, de ; $5569
	ld e, l ; $556a
	ld d, h ; $556b
	ld hl, $000e ; $556c
	add hl, bc ; $556f
	ld a, [hl+] ; $5570
	ld h, [hl] ; $5571
	ld l, a ; $5572
	ld a, l ; $5573
	sub a, e ; $5574
	ld l, a ; $5575
	ld a, h ; $5576
	sbc a, d ; $5577
	ld h, a ; $5578
	jr Label_04_5583 ; $5579
Label_04_557b:
	ld hl, $000e ; $557b
	add hl, bc ; $557e
	ld a, [hl+] ; $557f
	ld h, [hl] ; $5580
	ld l, a ; $5581
	add hl, de ; $5582
Label_04_5583:
	ld de, $0090 ; $5583
	add hl, de ; $5586
	ld a, h ; $5587
	cp a, $14 ; $5588
	jr nc, Label_04_55c0 ; $558a
	add hl, hl ; $558c
	add hl, hl ; $558d
	add hl, hl ; $558e
	ld e, h ; $558f
	push de ; $5590
	ld hl, $dae0 ; $5591
	ld a, [hl+] ; $5594
	ld d, [hl] ; $5595
	ld e, a ; $5596
	ld hl, $000c ; $5597
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
	cp a, $16 ; $55a6
	jr nc, Label_04_55c0 ; $55a8
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
	call Func_00_1e55 ; $55b6
	pop bc ; $55b9
	ld hl, $0030 ; $55ba
	add hl, bc ; $55bd
	set 7, [hl] ; $55be
Label_04_55c0:
	ret ; $55c0
Func_04_55c1:
	ld hl, $0030 ; $55c1
	add hl, bc ; $55c4
	bit 1, [hl] ; $55c5
	jr nz, Label_04_562b ; $55c7
	ld hl, $002f ; $55c9
	add hl, bc ; $55cc
	ld a, [hl] ; $55cd
	and a, a ; $55ce
	jr nz, Label_04_562b ; $55cf
Label_04_55d1:
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
	call Func_00_063d ; $55e0
	ld e, c ; $55e3
	ld d, b ; $55e4
	pop bc ; $55e5
	ld a, e ; $55e6
	cp a, $f0 ; $55e7
	jr c, Label_04_5616 ; $55e9
	cp a, $ff ; $55eb
	jr z, Label_04_55fb ; $55ed
	cp a, $fe ; $55ef
	jr z, Label_04_5611 ; $55f1
	ld hl, $002f ; $55f3
	add hl, bc ; $55f6
	ld [hl], $ff ; $55f7
	jr Label_04_562b ; $55f9
Label_04_55fb:
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
	jr Label_04_55d1 ; $560f
Label_04_5611:
	call Func_04_4bbe ; $5611
	jr Label_04_55d1 ; $5614
Label_04_5616:
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
	jr Label_04_5630 ; $5629
Label_04_562b:
	ld hl, $0033 ; $562b
	add hl, bc ; $562e
	ld e, [hl] ; $562f
Label_04_5630:
	push bc ; $5630
	ld hl, $0005 ; $5631
	add hl, bc ; $5634
	bit 7, [hl] ; $5635
	jr z, Label_04_564c ; $5637
	ld hl, $0019 ; $5639
	add hl, bc ; $563c
	push hl ; $563d
	ld hl, $002f ; $563e
	add hl, bc ; $5641
	ld c, [hl] ; $5642
	pop hl ; $5643
	ld b, [hl] ; $5644
	ld a, c ; $5645
	sub a, b ; $5646
	jr nc, Label_04_565d ; $5647
	xor a, a ; $5649
	jr Label_04_565d ; $564a
Label_04_564c:
	ld hl, $0018 ; $564c
	add hl, bc ; $564f
	push hl ; $5650
	ld hl, $002f ; $5651
	add hl, bc ; $5654
	ld c, [hl] ; $5655
	pop hl ; $5656
	ld b, [hl] ; $5657
	ld a, c ; $5658
	sub a, b ; $5659
	jr nc, Label_04_565d ; $565a
	xor a, a ; $565c
Label_04_565d:
	pop bc ; $565d
	ld hl, $002f ; $565e
	add hl, bc ; $5661
	ld [hl], a ; $5662
	ld hl, $0033 ; $5663
	add hl, bc ; $5666
	ld a, [hl] ; $5667
	cp a, e ; $5668
	jr z, Label_04_5672 ; $5669
	ld [hl], e ; $566b
	ld hl, $0030 ; $566c
	add hl, bc ; $566f
	set 6, [hl] ; $5670
Label_04_5672:
	ret ; $5672
Func_04_5673:
	ld hl, $0030 ; $5673
	add hl, bc ; $5676
	bit 0, [hl] ; $5677
	jr nz, Label_04_5685 ; $5679
	ld hl, $0014 ; $567b
	add hl, bc ; $567e
	ld a, [hl] ; $567f
	ld hl, $0034 ; $5680
	add hl, bc ; $5683
	ld [hl], a ; $5684
Label_04_5685:
	ld d, $00 ; $5685
	ld hl, $0035 ; $5687
	add hl, bc ; $568a
	ld a, [hl] ; $568b
	cp a, $01 ; $568c
	jr z, Label_04_56a3 ; $568e
	ld hl, $0034 ; $5690
	add hl, bc ; $5693
	ld a, [hl] ; $5694
	add a, $08 ; $5695
	swap a ; $5697
	and a, $0f ; $5699
	add a, $b3 ; $569b
	ld l, a ; $569d
	adc a, $56 ; $569e
	sub a, l ; $56a0
	ld h, a ; $56a1
	ld d, [hl] ; $56a2
Label_04_56a3:
	ld hl, $0032 ; $56a3
	add hl, bc ; $56a6
	ld a, [hl] ; $56a7
	cp a, d ; $56a8
	jr z, Label_04_56b2 ; $56a9
	ld [hl], d ; $56ab
	ld hl, $0030 ; $56ac
	add hl, bc ; $56af
	set 6, [hl] ; $56b0
Label_04_56b2:
	ret ; $56b2
	INCBIN "data/bank_004/d_56b3.bin" ; $56b3, 16 bytes
Func_04_56c3:
	rst Rst30 ; $56c3
	ldh [$ff0d], a ; $56c4
	ret nz ; $56c6
	ld hl, $0030 ; $56c7
	add hl, bc ; $56ca
	bit 6, [hl] ; $56cb
	ret z ; $56cd
	res 6, [hl] ; $56ce
	push bc ; $56d0
	ld hl, $0024 ; $56d1
	add hl, bc ; $56d4
	ld a, [hl+] ; $56d5
	ld h, [hl] ; $56d6
	ld l, a ; $56d7
	ld a, e ; $56d8
	add a, a ; $56d9
	add a, l ; $56da
	ld l, a ; $56db
	jr nc, Label_04_56df ; $56dc
	inc h ; $56de
Label_04_56df:
	ld a, [$daf7] ; $56df
	call Func_00_063d ; $56e2
	ld l, c ; $56e5
	ld h, b ; $56e6
	ld a, d ; $56e7
	add a, l ; $56e8
	ld l, a ; $56e9
	jr nc, Label_04_56ed ; $56ea
	inc h ; $56ec
Label_04_56ed:
	pop bc ; $56ed
	push hl ; $56ee
	ld hl, $0026 ; $56ef
	add hl, bc ; $56f2
	ld a, [hl+] ; $56f3
	ld d, [hl] ; $56f4
	ld e, a ; $56f5
	pop hl ; $56f6
	push bc ; $56f7
	ld a, [$daf7] ; $56f8
	ld b, a ; $56fb
	ld c, $04 ; $56fc
	call Func_00_046d ; $56fe
	pop bc ; $5701
	ret ; $5702
	INCBIN "data/bank_004/d_5703.bin" ; $5703, 10493 bytes
