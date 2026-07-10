INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $12", ROMX[$4000], BANK[$12]

	ld b, $40 ; $4000
	ld a, h ; $4002
	ld b, [hl] ; $4003
	rst Rst30 ; $4004
	ld d, d ; $4005
	ld d, [hl] ; $4006
	ld b, b ; $4007
	ei ; $4008
	ld b, b ; $4009
	inc d ; $400a
	ld b, b ; $400b
	inc d ; $400c
	ld b, c ; $400d
	dec d ; $400e
	ld b, c ; $400f
	ld d, $41 ; $4010
	ld [hl], b ; $4012
	ld b, c ; $4013
	nop ; $4014
	nop ; $4015
	adc a, c ; $4016
	ld a, d ; $4017
	nop ; $4018
	ld bc, $0100 ; $4019
	ld b, b ; $401c
	nop ; $401d
	ld c, c ; $401e
	ld bc, $0000 ; $401f
	nop ; $4022
	nop ; $4023
	adc a, c ; $4024
	ld a, d ; $4025
	nop ; $4026
	ld bc, $0100 ; $4027
	ld b, b ; $402a
	nop ; $402b
	add hl, hl ; $402c
	ld bc, $0000 ; $402d
	nop ; $4030
	nop ; $4031
	adc a, c ; $4032
	ld a, d ; $4033
	nop ; $4034
	ld bc, $0100 ; $4035
	ld b, b ; $4038
	nop ; $4039
	ld c, h ; $403a
	ld bc, $0000 ; $403b
	nop ; $403e
	nop ; $403f
	adc a, c ; $4040
	ld a, d ; $4041
	nop ; $4042
	ld bc, $0100 ; $4043
	ld b, b ; $4046
	nop ; $4047
	ld c, l ; $4048
	ld bc, $0000 ; $4049
	nop ; $404c
	nop ; $404d
	nop ; $404e
	nop ; $404f
	nop ; $4050
	nop ; $4051
	nop ; $4052
	nop ; $4053
	nop ; $4054
	rst Rst38 ; $4055
	ld bc, $00c0 ; $4056
	ld d, $00 ; $4059
	dec de ; $405b
	or a, l ; $405c
	ld b, b ; $405d
	ld [bc], a ; $405e
	ld b, b ; $405f
	nop ; $4060
	ld d, $00 ; $4061
	dec c ; $4063
	ld l, a ; $4064
	ld b, b ; $4065
	rrca ; $4066
	ret nz ; $4067
	nop ; $4068
	ld d, $00 ; $4069
	dec de ; $406b
	nop ; $406c
	nop ; $406d
	rst Rst38 ; $406e
	ld a, [$c295] ; $406f
	cp a, $ff ; $4072
	jp z, Label_12_40b4 ; $4074
	rst Rst30 ; $4077
	ldh [rTIMA], a ; $4078
	jr z, Label_12_40a2 ; $407a
	ld a, $02 ; $407c
	ld bc, $00ff ; $407e
	rst Rst18 ; $4081
	jr Label_12_408e ; $4082
	INCBIN "data/bank_012/d_4084.bin" ; $4084, 10 bytes
Label_12_408e:
	ld a, $02 ; $408e
	rst Rst18 ; $4090
	jr nz, Label_12_409d ; $4091
	ld a, $02 ; $4093
	ld b, $40 ; $4095
	rst Rst18 ; $4097
	ld l, $0a ; $4098
	ld a, $02 ; $409a
	INCBIN "data/bank_012/d_409c.bin" ; $409c, 1 bytes
Label_12_409d:
	stop ; $409d
	rst Rst18 ; $409f
	jr Label_12_40ac ; $40a0
Label_12_40a2:
	ld a, $00 ; $40a2
	ld bc, $0010 ; $40a4
	rst Rst18 ; $40a7
	jr Label_12_40b4 ; $40a8
	INCBIN "data/bank_012/d_40aa.bin" ; $40aa, 2 bytes
Label_12_40ac:
	ld b, $40 ; $40ac
	ld de, $0200 ; $40ae
	rst Rst18 ; $40b1
	ld a, [hl+] ; $40b2
	ld a, [bc] ; $40b3
Label_12_40b4:
	ret ; $40b4
	INCBIN "data/bank_012/d_40b5.bin" ; $40b5, 187 bytes
	ld a, [$c295] ; $4170
	cp a, $0f ; $4173
	call z, Func_12_4179 ; $4175
	ret ; $4178
Func_12_4179:
	ld a, $03 ; $4179
	ld bc, $0010 ; $417b
	rst Rst18 ; $417e
	jr Label_12_418b ; $417f
	ld a, $04 ; $4181
	ld bc, $0010 ; $4183
	rst Rst18 ; $4186
	jr $4193 ; $4187
	ld a, $00 ; $4189
Label_12_418b:
	ld bc, $0010 ; $418b
	rst Rst18 ; $418e
	jr $419b ; $418f
	ld bc, $0010 ; $4191
	rst Rst18 ; $4194
	jr c, Label_12_41a1 ; $4195
	ld a, $00 ; $4197
	ld bc, $1600 ; $4199
	ld de, $1f00 ; $419c
	rst Rst18 ; $419f
	ld [hl+], a ; $41a0
Label_12_41a1:
	ld a, [bc] ; $41a1
	ld a, $03 ; $41a2
	ld bc, $1600 ; $41a4
	ld de, $1d00 ; $41a7
	rst Rst18 ; $41aa
	ld [hl+], a ; $41ab
	ld a, [bc] ; $41ac
	ld a, $03 ; $41ad
	ld b, $c0 ; $41af
	rst Rst18 ; $41b1
	ld l, $0a ; $41b2
	ld c, $20 ; $41b4
	call Func_00_1d2e ; $41b6
	push af ; $41b9
	ld a, $14 ; $41ba
	rst Rst18 ; $41bc
	inc b ; $41bd
	ld a, [bc] ; $41be
	pop af ; $41bf
	ld a, $03 ; $41c0
	ld bc, $1600 ; $41c2
	ld de, $1100 ; $41c5
	rst Rst18 ; $41c8
	inc h ; $41c9
	ld a, [bc] ; $41ca
	xor a, a ; $41cb
	ld bc, $1600 ; $41cc
	ld de, $0f00 ; $41cf
	rst Rst18 ; $41d2
	ld a, [hl-] ; $41d3
	ld a, [bc] ; $41d4
	ld a, $00 ; $41d5
	ld bc, $1600 ; $41d7
	ld de, $1400 ; $41da
	rst Rst18 ; $41dd
	inc h ; $41de
	ld a, [bc] ; $41df
	ld a, $00 ; $41e0
	rst Rst18 ; $41e2
	jr nz, Label_12_41ef ; $41e3
	ld a, $03 ; $41e5
	ld bc, $1600 ; $41e7
	ld de, $1100 ; $41ea
	rst Rst18 ; $41ed
	inc h ; $41ee
Label_12_41ef:
	ld a, [bc] ; $41ef
	ld a, $00 ; $41f0
	ld bc, $1600 ; $41f2
	ld de, $1300 ; $41f5
	rst Rst18 ; $41f8
	inc h ; $41f9
	ld a, [bc] ; $41fa
	ld a, $00 ; $41fb
	rst Rst18 ; $41fd
	jr nz, Label_12_420a ; $41fe
	push af ; $4200
	ld a, $14 ; $4201
	rst Rst18 ; $4203
	inc b ; $4204
	ld a, [bc] ; $4205
	pop af ; $4206
	ld a, $03 ; $4207
	rst Rst18 ; $4209
Label_12_420a:
	jr nz, $4216 ; $420a
	ld a, $00 ; $420c
	ld b, a ; $420e
	ld a, $03 ; $420f
	rst Rst18 ; $4211
	jr nc, Label_12_421e ; $4212
	ld hl, $044a ; $4214
	rst Rst18 ; $4217
	ld c, $0a ; $4218
	ld a, $03 ; $421a
	rst Rst18 ; $421c
	INCBIN "data/bank_012/d_421d.bin" ; $421d, 1 bytes
Label_12_421e:
	ld a, [bc] ; $421e
	ld a, $03 ; $421f
	ld d, $03 ; $4221
	rst Rst18 ; $4223
	inc [hl] ; $4224
	ld a, [bc] ; $4225
	ld a, $03 ; $4226
	rst Rst18 ; $4228
	ld [hl], $0a ; $4229
	ld a, $03 ; $422b
	rst Rst18 ; $422d
	INCBIN "data/bank_012/d_422e.bin" ; $422e, 2 bytes
	ld a, $00 ; $4230
	ld d, $02 ; $4232
	rst Rst18 ; $4234
	inc [hl] ; $4235
	ld a, [bc] ; $4236
	ld bc, $0018 ; $4237
	rst Rst18 ; $423a
	jr c, Label_12_4247 ; $423b
	xor a, a ; $423d
	ld bc, $1600 ; $423e
	ld de, $0b00 ; $4241
	rst Rst18 ; $4244
	ld a, [hl-] ; $4245
	ld a, [bc] ; $4246
Label_12_4247:
	rst Rst18 ; $4247
	ld a, $0a ; $4248
	push af ; $424a
	ld a, $14 ; $424b
	rst Rst18 ; $424d
	inc b ; $424e
	ld a, [bc] ; $424f
	pop af ; $4250
	xor a, a ; $4251
	ld bc, $1100 ; $4252
	ld de, $0b00 ; $4255
	rst Rst18 ; $4258
	ld a, [hl-] ; $4259
	ld a, [bc] ; $425a
	rst Rst18 ; $425b
	ld a, $0a ; $425c
	push af ; $425e
	ld a, $0a ; $425f
	rst Rst18 ; $4261
	inc b ; $4262
	ld a, [bc] ; $4263
	pop af ; $4264
	xor a, a ; $4265
	ld bc, $1a00 ; $4266
	ld de, $0b00 ; $4269
	rst Rst18 ; $426c
	ld a, [hl-] ; $426d
	ld a, [bc] ; $426e
	rst Rst18 ; $426f
	ld a, $0a ; $4270
	push af ; $4272
	ld a, $0a ; $4273
	rst Rst18 ; $4275
	inc b ; $4276
	ld a, [bc] ; $4277
	pop af ; $4278
	xor a, a ; $4279
	ld bc, $1600 ; $427a
	ld de, $0b00 ; $427d
	rst Rst18 ; $4280
	ld a, [hl-] ; $4281
	ld a, [bc] ; $4282
	rst Rst18 ; $4283
	ld a, $0a ; $4284
	push af ; $4286
	ld a, $1e ; $4287
	rst Rst18 ; $4289
	inc b ; $428a
	ld a, [bc] ; $428b
	pop af ; $428c
	xor a, a ; $428d
	ld bc, $1600 ; $428e
	ld de, $1000 ; $4291
	rst Rst18 ; $4294
	ld a, [hl-] ; $4295
	ld a, [bc] ; $4296
	ld a, $00 ; $4297
	ld d, $02 ; $4299
	rst Rst18 ; $429b
	inc [hl] ; $429c
	ld a, [bc] ; $429d
	ld a, $00 ; $429e
	rst Rst18 ; $42a0
	ld [hl], $0a ; $42a1
	push af ; $42a3
	ld a, $14 ; $42a4
	rst Rst18 ; $42a6
	inc b ; $42a7
	ld a, [bc] ; $42a8
	pop af ; $42a9
	ld bc, $0010 ; $42aa
	rst Rst18 ; $42ad
	jr c, Label_12_42ba ; $42ae
	ld a, $05 ; $42b0
	ld bc, $1780 ; $42b2
	ld de, $0f00 ; $42b5
	rst Rst18 ; $42b8
	ld [hl+], a ; $42b9
Label_12_42ba:
	ld a, [bc] ; $42ba
	rst Rst08 ; $42bb
	sub a, a ; $42bc
	ld a, $03 ; $42bd
	ld d, $02 ; $42bf
	rst Rst18 ; $42c1
	inc [hl] ; $42c2
	ld a, [bc] ; $42c3
	ld a, $03 ; $42c4
	rst Rst18 ; $42c6
	ld [hl], $0a ; $42c7
	ld a, $05 ; $42c9
	ld bc, $0100 ; $42cb
	ld de, $0100 ; $42ce
	rst Rst18 ; $42d1
	ld [hl+], a ; $42d2
	ld a, [bc] ; $42d3
	ld a, $03 ; $42d4
	rst Rst18 ; $42d6
	INCBIN "data/bank_012/d_42d7.bin" ; $42d7, 2 bytes
	ld a, $03 ; $42d9
	ld bc, $1600 ; $42db
	ld de, $0b00 ; $42de
	rst Rst18 ; $42e1
	inc h ; $42e2
	ld a, [bc] ; $42e3
	ld a, $03 ; $42e4
	rst Rst18 ; $42e6
	jr nz, Label_12_42f3 ; $42e7
	ld a, $04 ; $42e9
	ld bc, $1700 ; $42eb
	ld de, $0b00 ; $42ee
	rst Rst18 ; $42f1
	ld [hl+], a ; $42f2
Label_12_42f3:
	ld a, [bc] ; $42f3
	push af ; $42f4
	ld a, $a0 ; $42f5
	rst Rst18 ; $42f7
	inc b ; $42f8
	ld a, [bc] ; $42f9
	pop af ; $42fa
	ld a, $00 ; $42fb
	ld bc, $1600 ; $42fd
	ld de, $1500 ; $4300
	rst Rst18 ; $4303
	inc h ; $4304
	ld a, [bc] ; $4305
	ld a, $00 ; $4306
	rst Rst18 ; $4308
	jr nz, Label_12_4315 ; $4309
	ld a, $00 ; $430b
	ld b, $40 ; $430d
	rst Rst18 ; $430f
	ld l, $0a ; $4310
	push af ; $4312
	ld a, $14 ; $4313
Label_12_4315:
	rst Rst18 ; $4315
	inc b ; $4316
	ld a, [bc] ; $4317
	pop af ; $4318
	ld a, $00 ; $4319
	ld d, $04 ; $431b
	rst Rst18 ; $431d
	inc [hl] ; $431e
	ld a, [bc] ; $431f
	ld a, $00 ; $4320
	rst Rst18 ; $4322
	ld [hl], $0a ; $4323
	ld a, $00 ; $4325
	ld b, $c0 ; $4327
	rst Rst18 ; $4329
	ld l, $0a ; $432a
	push af ; $432c
	ld a, $a0 ; $432d
	rst Rst18 ; $432f
	inc b ; $4330
	ld a, [bc] ; $4331
	pop af ; $4332
	ld a, $00 ; $4333
	ld b, $40 ; $4335
	rst Rst18 ; $4337
	ld l, $0a ; $4338
	push af ; $433a
	ld a, $14 ; $433b
	rst Rst18 ; $433d
	inc b ; $433e
	ld a, [bc] ; $433f
	pop af ; $4340
	ld a, $00 ; $4341
	ld d, $04 ; $4343
	rst Rst18 ; $4345
	inc [hl] ; $4346
	ld a, [bc] ; $4347
	ld a, $00 ; $4348
	rst Rst18 ; $434a
	ld [hl], $0a ; $434b
	push af ; $434d
	ld a, $14 ; $434e
	rst Rst18 ; $4350
	inc b ; $4351
	ld a, [bc] ; $4352
	pop af ; $4353
	ld a, $03 ; $4354
	ld b, $00 ; $4356
	rst Rst18 ; $4358
	ld c, b ; $4359
	ld a, [bc] ; $435a
	ld a, $03 ; $435b
	ld bc, $1700 ; $435d
	ld de, $1900 ; $4360
	rst Rst18 ; $4363
	ld [hl+], a ; $4364
	ld a, [bc] ; $4365
	ld a, $03 ; $4366
	rst Rst18 ; $4368
	INCBIN "data/bank_012/d_4369.bin" ; $4369, 2 bytes
	ld a, $00 ; $436b
	ld bc, $1680 ; $436d
	ld de, $1200 ; $4370
	rst Rst18 ; $4373
	inc h ; $4374
	ld a, [bc] ; $4375
	ld a, $00 ; $4376
	ld de, $ff80 ; $4378
	rst Rst18 ; $437b
	ld b, d ; $437c
	ld a, [bc] ; $437d
	ld a, $00 ; $437e
	rst Rst18 ; $4380
	ld b, h ; $4381
	ld a, [bc] ; $4382
	ld a, $00 ; $4383
	ld b, $c0 ; $4385
	rst Rst18 ; $4387
	ld l, $0a ; $4388
	ld a, $03 ; $438a
	ld b, $02 ; $438c
	rst Rst18 ; $438e
	ld c, b ; $438f
	ld a, [bc] ; $4390
	ld a, $03 ; $4391
	ld bc, $1500 ; $4393
	ld de, $0b00 ; $4396
	rst Rst18 ; $4399
	ld [hl+], a ; $439a
	ld a, [bc] ; $439b
	ld a, [$c94d] ; $439c
	or a, a ; $439f
	jr nz, Label_12_43bb ; $43a0
	ld hl, $045c ; $43a2
	rst Rst18 ; $43a5
	ld c, $0a ; $43a6
	ld d, $28 ; $43a8
	ld a, $04 ; $43aa
	rst Rst18 ; $43ac
	ld d, $0a ; $43ad
	ld c, l ; $43af
	ld b, h ; $43b0
	rst Rst18 ; $43b1
	inc l ; $43b2
	inc b ; $43b3
	ld a, $04 ; $43b4
	ld d, $01 ; $43b6
	rst Rst18 ; $43b8
	inc [hl] ; $43b9
	ld a, [bc] ; $43ba
Label_12_43bb:
	ld a, $03 ; $43bb
	ld bc, $1500 ; $43bd
	ld de, $0f00 ; $43c0
	rst Rst18 ; $43c3
	inc h ; $43c4
	ld a, [bc] ; $43c5
	ld a, $03 ; $43c6
	rst Rst18 ; $43c8
	jr nz, Label_12_43d5 ; $43c9
	ld a, $04 ; $43cb
	ld bc, $1700 ; $43cd
	ld de, $0f00 ; $43d0
	rst Rst18 ; $43d3
	inc h ; $43d4
Label_12_43d5:
	ld a, [bc] ; $43d5
	ld a, $04 ; $43d6
	rst Rst18 ; $43d8
	jr nz, Label_12_43e5 ; $43d9
	ld a, $06 ; $43db
	ld bc, $1800 ; $43dd
	ld de, $1100 ; $43e0
	rst Rst18 ; $43e3
	ld [hl+], a ; $43e4
Label_12_43e5:
	ld a, [bc] ; $43e5
	rst Rst08 ; $43e6
	sbc a, b ; $43e7
	push af ; $43e8
	ld a, $3c ; $43e9
	rst Rst18 ; $43eb
	inc b ; $43ec
	ld a, [bc] ; $43ed
	pop af ; $43ee
	ld a, $03 ; $43ef
	ld d, $04 ; $43f1
	rst Rst18 ; $43f3
	inc [hl] ; $43f4
	ld a, [bc] ; $43f5
	ld a, $03 ; $43f6
	rst Rst18 ; $43f8
	ld [hl], $0a ; $43f9
	ld a, $06 ; $43fb
	ld bc, $0100 ; $43fd
	ld de, $0100 ; $4400
	rst Rst18 ; $4403
	ld [hl+], a ; $4404
	ld a, [bc] ; $4405
	ld a, $03 ; $4406
	rst Rst18 ; $4408
	INCBIN "data/bank_012/d_4409.bin" ; $4409, 2 bytes
	ld a, $04 ; $440b
	ld b, a ; $440d
	ld a, $03 ; $440e
	rst Rst18 ; $4410
	jr nc, Label_12_441d ; $4411
	push af ; $4413
	ld a, $3c ; $4414
	rst Rst18 ; $4416
	inc b ; $4417
	ld a, [bc] ; $4418
	pop af ; $4419
	ld a, $00 ; $441a
	ld b, a ; $441c
Label_12_441d:
	ld a, $03 ; $441d
	rst Rst18 ; $441f
	jr nc, Label_12_442c ; $4420
	ld a, $03 ; $4422
	rst Rst18 ; $4424
	INCBIN "data/bank_012/d_4425.bin" ; $4425, 2 bytes
	ld a, $04 ; $4427
	ld d, $03 ; $4429
	rst Rst18 ; $442b
Label_12_442c:
	inc [hl] ; $442c
	ld a, [bc] ; $442d
	ld a, $04 ; $442e
	rst Rst18 ; $4430
	ld [hl], $0a ; $4431
	ld a, $04 ; $4433
	rst Rst18 ; $4435
	INCBIN "data/bank_012/d_4436.bin" ; $4436, 2 bytes
	ld a, $00 ; $4438
	ld d, $03 ; $443a
	rst Rst18 ; $443c
	inc [hl] ; $443d
	ld a, [bc] ; $443e
	ld a, $00 ; $443f
	rst Rst18 ; $4441
	ld [hl], $0a ; $4442
	push af ; $4444
	ld a, $14 ; $4445
	rst Rst18 ; $4447
	inc b ; $4448
	ld a, [bc] ; $4449
	pop af ; $444a
	ld a, $03 ; $444b
	ld d, $03 ; $444d
	rst Rst18 ; $444f
	inc [hl] ; $4450
	ld a, [bc] ; $4451
	ld a, $03 ; $4452
	rst Rst18 ; $4454
	ld [hl], $0a ; $4455
	ld a, $03 ; $4457
	rst Rst18 ; $4459
	INCBIN "data/bank_012/d_445a.bin" ; $445a, 2 bytes
	ld a, $03 ; $445c
	ld b, a ; $445e
	ld a, $04 ; $445f
	rst Rst18 ; $4461
	jr nc, Label_12_446e ; $4462
	ld a, $04 ; $4464
	ld d, $04 ; $4466
	rst Rst18 ; $4468
	inc [hl] ; $4469
	ld a, [bc] ; $446a
	ld a, $04 ; $446b
	rst Rst18 ; $446d
Label_12_446e:
	ld [hl], $0a ; $446e
	ld a, $04 ; $4470
	rst Rst18 ; $4472
	INCBIN "data/bank_012/d_4473.bin" ; $4473, 2 bytes
	ld a, $04 ; $4475
	ld b, a ; $4477
	ld a, $03 ; $4478
	rst Rst18 ; $447a
	jr nc, Label_12_4487 ; $447b
	ld a, $03 ; $447d
	rst Rst18 ; $447f
	INCBIN "data/bank_012/d_4480.bin" ; $4480, 2 bytes
	ld a, $04 ; $4482
	ld d, $03 ; $4484
	rst Rst18 ; $4486
Label_12_4487:
	inc [hl] ; $4487
	ld a, [bc] ; $4488
	ld a, $04 ; $4489
	rst Rst18 ; $448b
	ld [hl], $0a ; $448c
	ld a, $00 ; $448e
	ld b, a ; $4490
	ld a, $04 ; $4491
	rst Rst18 ; $4493
	jr nc, Label_12_44a0 ; $4494
	ld a, $04 ; $4496
	rst Rst18 ; $4498
	ld a, [bc] ; $4499
	ld a, [bc] ; $449a
	ld a, $00 ; $449b
	ld b, a ; $449d
	ld a, $03 ; $449e
Label_12_44a0:
	rst Rst18 ; $44a0
	jr nc, Label_12_44ad ; $44a1
	rst Rst18 ; $44a3
	ld [de], a ; $44a4
	ld a, [bc] ; $44a5
	rst Rst18 ; $44a6
	inc c ; $44a7
	ld a, [bc] ; $44a8
	push af ; $44a9
	ld a, $05 ; $44aa
	rst Rst18 ; $44ac
Label_12_44ad:
	inc b ; $44ad
	ld a, [bc] ; $44ae
	pop af ; $44af
	and a, a ; $44b0
	jr nz, Label_12_44bd ; $44b1
	ld a, $04 ; $44b3
	rst Rst18 ; $44b5
	INCBIN "data/bank_012/d_44b6.bin" ; $44b6, 2 bytes
	rst Rst18 ; $44b8
	INCBIN "data/bank_012/d_44b9.bin" ; $44b9, 2 bytes
	jr Label_12_44c5 ; $44bb
Label_12_44bd:
	rst Rst18 ; $44bd
	INCBIN "data/bank_012/d_44be.bin" ; $44be, 7 bytes
Label_12_44c5:
	ld a, $03 ; $44c5
	ld d, $03 ; $44c7
	rst Rst18 ; $44c9
	inc [hl] ; $44ca
	ld a, [bc] ; $44cb
	ld a, $03 ; $44cc
	rst Rst18 ; $44ce
	ld [hl], $0a ; $44cf
	ld a, $03 ; $44d1
	rst Rst18 ; $44d3
	INCBIN "data/bank_012/d_44d4.bin" ; $44d4, 2 bytes
	ld a, $04 ; $44d6
	ld d, $03 ; $44d8
	rst Rst18 ; $44da
	inc [hl] ; $44db
	ld a, [bc] ; $44dc
	ld a, $04 ; $44dd
	rst Rst18 ; $44df
	ld [hl], $0a ; $44e0
	ld a, $03 ; $44e2
	ld d, $02 ; $44e4
	rst Rst18 ; $44e6
	inc [hl] ; $44e7
	ld a, [bc] ; $44e8
	ld a, $03 ; $44e9
	rst Rst18 ; $44eb
	ld [hl], $0a ; $44ec
	ld a, $03 ; $44ee
	rst Rst18 ; $44f0
	INCBIN "data/bank_012/d_44f1.bin" ; $44f1, 2 bytes
	ld a, $06 ; $44f3
	ld bc, $1800 ; $44f5
	ld de, $1100 ; $44f8
	rst Rst18 ; $44fb
	ld [hl+], a ; $44fc
	ld a, [bc] ; $44fd
	rst Rst08 ; $44fe
	sbc a, b ; $44ff
	push af ; $4500
	ld a, $3c ; $4501
	rst Rst18 ; $4503
	inc b ; $4504
	ld a, [bc] ; $4505
	pop af ; $4506
	ld a, $06 ; $4507
	ld bc, $0100 ; $4509
	ld de, $0100 ; $450c
	rst Rst18 ; $450f
	ld [hl+], a ; $4510
	ld a, [bc] ; $4511
	ld a, $04 ; $4512
	ld d, $03 ; $4514
	rst Rst18 ; $4516
	inc [hl] ; $4517
	ld a, [bc] ; $4518
	ld a, $04 ; $4519
	rst Rst18 ; $451b
	ld [hl], $0a ; $451c
	ld a, $04 ; $451e
	rst Rst18 ; $4520
	INCBIN "data/bank_012/d_4521.bin" ; $4521, 2 bytes
	ld a, $04 ; $4523
	ld b, a ; $4525
	ld a, $03 ; $4526
	rst Rst18 ; $4528
	jr nc, Label_12_4535 ; $4529
	push af ; $452b
	ld a, $1e ; $452c
	rst Rst18 ; $452e
	inc b ; $452f
	ld a, [bc] ; $4530
	pop af ; $4531
	ld a, $00 ; $4532
	ld b, a ; $4534
Label_12_4535:
	ld a, $03 ; $4535
	rst Rst18 ; $4537
	jr nc, $4544 ; $4538
	push af ; $453a
	ld a, $1e ; $453b
	rst Rst18 ; $453d
	inc b ; $453e
	ld a, [bc] ; $453f
	pop af ; $4540
	ld a, $03 ; $4541
	ld d, $03 ; $4543
	rst Rst18 ; $4545
	inc [hl] ; $4546
	ld a, [bc] ; $4547
	ld a, $03 ; $4548
	rst Rst18 ; $454a
	ld [hl], $0a ; $454b
	ld hl, $045a ; $454d
	rst Rst18 ; $4550
	ld c, $0a ; $4551
	ld a, $04 ; $4553
	rst Rst18 ; $4555
	INCBIN "data/bank_012/d_4556.bin" ; $4556, 2 bytes
	ld a, $03 ; $4558
	ld b, a ; $455a
	ld a, $04 ; $455b
	rst Rst18 ; $455d
	jr nc, $456a ; $455e
	ld a, $00 ; $4560
	ld d, $03 ; $4562
	rst Rst18 ; $4564
	inc [hl] ; $4565
	ld a, [bc] ; $4566
	ld a, $04 ; $4567
	ld d, $03 ; $4569
	rst Rst18 ; $456b
	inc [hl] ; $456c
	ld a, [bc] ; $456d
	ld a, $04 ; $456e
	rst Rst18 ; $4570
	ld [hl], $0a ; $4571
	xor a, a ; $4573
	ld bc, $1600 ; $4574
	ld de, $1300 ; $4577
	rst Rst18 ; $457a
	ld a, [hl-] ; $457b
	ld a, [bc] ; $457c
	ld a, $03 ; $457d
	ld bc, $1500 ; $457f
	ld de, $1300 ; $4582
	rst Rst18 ; $4585
	inc h ; $4586
	ld a, [bc] ; $4587
	ld a, $03 ; $4588
	rst Rst18 ; $458a
	jr nz, $4597 ; $458b
	ld a, $04 ; $458d
	ld b, $40 ; $458f
	rst Rst18 ; $4591
	ld l, $0a ; $4592
	ld a, $00 ; $4594
	ld b, $40 ; $4596
	rst Rst18 ; $4598
	ld l, $0a ; $4599
	ld a, $03 ; $459b
	ld bc, $1500 ; $459d
	ld de, $1500 ; $45a0
	rst Rst18 ; $45a3
	inc h ; $45a4
	ld a, [bc] ; $45a5
	ld a, $03 ; $45a6
	rst Rst18 ; $45a8
	jr nz, $45b5 ; $45a9
	ld a, $03 ; $45ab
	ld b, $c0 ; $45ad
	rst Rst18 ; $45af
	ld l, $0a ; $45b0
	ld a, $00 ; $45b2
	ld b, $40 ; $45b4
	rst Rst18 ; $45b6
	ld l, $0a ; $45b7
	ld a, $04 ; $45b9
	rst Rst18 ; $45bb
	INCBIN "data/bank_012/d_45bc.bin" ; $45bc, 2 bytes
	ld a, $00 ; $45be
	ld d, $03 ; $45c0
	rst Rst18 ; $45c2
	inc [hl] ; $45c3
	ld a, [bc] ; $45c4
	ld a, $04 ; $45c5
	ld d, $03 ; $45c7
	rst Rst18 ; $45c9
	inc [hl] ; $45ca
	ld a, [bc] ; $45cb
	ld a, $04 ; $45cc
	rst Rst18 ; $45ce
	ld [hl], $0a ; $45cf
	ld a, $03 ; $45d1
	ld d, $03 ; $45d3
	rst Rst18 ; $45d5
	inc [hl] ; $45d6
	ld a, [bc] ; $45d7
	ld a, $03 ; $45d8
	rst Rst18 ; $45da
	ld [hl], $0a ; $45db
	ld a, $03 ; $45dd
	ld b, $40 ; $45df
	rst Rst18 ; $45e1
	ld l, $0a ; $45e2
	push af ; $45e4
	ld a, $1e ; $45e5
	rst Rst18 ; $45e7
	inc b ; $45e8
	ld a, [bc] ; $45e9
	pop af ; $45ea
	ld a, $03 ; $45eb
	ld bc, $1500 ; $45ed
	ld de, $1f00 ; $45f0
	rst Rst18 ; $45f3
	inc h ; $45f4
	ld a, [bc] ; $45f5
	push af ; $45f6
	ld a, $78 ; $45f7
	rst Rst18 ; $45f9
	inc b ; $45fa
	ld a, [bc] ; $45fb
	pop af ; $45fc
	ld a, $00 ; $45fd
	ld b, a ; $45ff
	ld a, $04 ; $4600
	rst Rst18 ; $4602
	ld [hl-], a ; $4603
	ld a, [bc] ; $4604
	ld a, $00 ; $4605
	ld d, $03 ; $4607
	rst Rst18 ; $4609
	inc [hl] ; $460a
	ld a, [bc] ; $460b
	ld a, $04 ; $460c
	ld d, $03 ; $460e
	rst Rst18 ; $4610
	inc [hl] ; $4611
	ld a, [bc] ; $4612
	ld a, $04 ; $4613
	rst Rst18 ; $4615
	ld [hl], $0a ; $4616
	xor a, a ; $4618
	ld bc, $1500 ; $4619
	ld de, $0f00 ; $461c
	rst Rst18 ; $461f
	ld a, [hl-] ; $4620
	ld a, [bc] ; $4621
	ld a, $00 ; $4622
	ld bc, $1500 ; $4624
	ld de, $0f00 ; $4627
	rst Rst18 ; $462a
	inc h ; $462b
	ld a, [bc] ; $462c
	ld a, $00 ; $462d
	rst Rst18 ; $462f
	jr nz, Label_12_463c ; $4630
	ld a, $04 ; $4632
	ld bc, $1700 ; $4634
	ld de, $0b00 ; $4637
	rst Rst18 ; $463a
	inc h ; $463b
Label_12_463c:
	ld a, [bc] ; $463c
	ld a, $00 ; $463d
	ld bc, $1500 ; $463f
	ld de, $0b00 ; $4642
	rst Rst18 ; $4645
	inc h ; $4646
	ld a, [bc] ; $4647
	ld a, $00 ; $4648
	rst Rst18 ; $464a
	jr nz, Label_12_4657 ; $464b
	xor a, a ; $464d
	ld bc, $1600 ; $464e
	ld de, $0b00 ; $4651
	rst Rst18 ; $4654
	ld a, [hl-] ; $4655
	ld a, [bc] ; $4656
Label_12_4657:
	ld b, $0a ; $4657
	ld c, $0f ; $4659
	rst Rst18 ; $465b
	ld h, d ; $465c
	ld a, [bc] ; $465d
	rst Rst18 ; $465e
	jr Label_12_4664 ; $465f
	ld a, $01 ; $4661
	rst Rst18 ; $4663
Label_12_4664:
	ld d, $03 ; $4664
	rst Rst18 ; $4666
	jr $466c ; $4667
	rst Rst08 ; $4669
	nop ; $466a
	ld c, $04 ; $466b
	call Func_00_1d20 ; $466d
	call Func_00_1da4 ; $4670
	ld a, $0f ; $4673
	ld [$c294], a ; $4675
	ld [$c2a1], a ; $4678
	ret ; $467b
	INCBIN "data/bank_012/d_467c.bin" ; $467c, 392 bytes
	ld a, $06 ; $4804
	rst Rst18 ; $4806
	ld [$c90a], sp ; $4807
	INCBIN "data/bank_012/d_480a.bin" ; $480a, 1260 bytes
	rst Rst18 ; $4cf6
	jr nz, Label_12_4d03 ; $4cf7
	ld a, $07 ; $4cf9
	ld bc, $0500 ; $4cfb
	ld de, $3700 ; $4cfe
	rst Rst18 ; $4d01
	inc h ; $4d02
Label_12_4d03:
	ld a, [bc] ; $4d03
	ld a, $07 ; $4d04
	rst Rst18 ; $4d06
	jr nz, Label_12_4d13 ; $4d07
	ld a, $07 ; $4d09
	ld b, $40 ; $4d0b
	rst Rst18 ; $4d0d
	ld l, $0a ; $4d0e
	rst Rst28 ; $4d10
	nop ; $4d11
	inc e ; $4d12
Label_12_4d13:
	rst Rst28 ; $4d13
	and a, b ; $4d14
	rrca ; $4d15
	rst Rst30 ; $4d16
	ldh [rTIMA], a ; $4d17
	jr z, Label_12_4d28 ; $4d19
	ld a, $02 ; $4d1b
	rst Rst18 ; $4d1d
	ld d, $0a ; $4d1e
	ld c, l ; $4d20
	ld b, h ; $4d21
	ld de, $d000 ; $4d22
	rst Rst18 ; $4d25
	jr nz, Label_12_4d2c ; $4d26
Label_12_4d28:
	ret ; $4d28
	INCBIN "data/bank_012/d_4d29.bin" ; $4d29, 3 bytes
Label_12_4d2c:
	rst Rst18 ; $4d2c
	ld c, $0a ; $4d2d
	ld a, $07 ; $4d2f
	rst Rst18 ; $4d31
	ld a, [bc] ; $4d32
	ld a, [bc] ; $4d33
	rst Rst18 ; $4d34
	ld [de], a ; $4d35
	ld a, [bc] ; $4d36
	rst Rst18 ; $4d37
	inc c ; $4d38
	ld a, [bc] ; $4d39
	push af ; $4d3a
	ld a, $05 ; $4d3b
	rst Rst18 ; $4d3d
	inc b ; $4d3e
	ld a, [bc] ; $4d3f
	pop af ; $4d40
	and a, a ; $4d41
	jr nz, Label_12_4d97 ; $4d42
	ld a, $07 ; $4d44
	ld b, $c0 ; $4d46
	rst Rst18 ; $4d48
	ld l, $0a ; $4d49
	ld a, $07 ; $4d4b
	ld d, $02 ; $4d4d
	rst Rst18 ; $4d4f
	inc [hl] ; $4d50
	ld a, [bc] ; $4d51
	ld a, $00 ; $4d52
	ld bc, $0020 ; $4d54
	rst Rst18 ; $4d57
	jr Label_12_4d64 ; $4d58
	INCBIN "data/bank_012/d_4d5a.bin" ; $4d5a, 10 bytes
Label_12_4d64:
	ld a, [bc] ; $4d64
	ld a, $00 ; $4d65
	rst Rst18 ; $4d67
	jr nz, Label_12_4d74 ; $4d68
	ld a, $00 ; $4d6a
	ld bc, $0c00 ; $4d6c
	ld de, $3100 ; $4d6f
	rst Rst18 ; $4d72
	inc h ; $4d73
Label_12_4d74:
	ld a, [bc] ; $4d74
	ld c, $04 ; $4d75
	call Func_00_1d20 ; $4d77
	call Func_00_1da4 ; $4d7a
	ld a, $13 ; $4d7d
	ld [wStoryModeCurrentLocation], a ; $4d7f
	ld a, $0b ; $4d82
	ld [$c295], a ; $4d84
	ld a, $ff ; $4d87
	ld [$c294], a ; $4d89
	ld [$c2a1], a ; $4d8c
	ld a, $16 ; $4d8f
	rst Rst18 ; $4d91
	nop ; $4d92
	dec bc ; $4d93
	rst Rst18 ; $4d94
	ld [bc], a ; $4d95
	ld a, [bc] ; $4d96
Label_12_4d97:
	ret ; $4d97
	INCBIN "data/bank_012/d_4d98.bin" ; $4d98, 1054 bytes
	rst Rst18 ; $51b6
	ld [$c90a], sp ; $51b7
	ld a, $07 ; $51ba
	ld d, $03 ; $51bc
	rst Rst18 ; $51be
	inc [hl] ; $51bf
	ld a, [bc] ; $51c0
	ld a, $07 ; $51c1
	rst Rst18 ; $51c3
	ld [hl], $0a ; $51c4
	ld a, $07 ; $51c6
	rst Rst18 ; $51c8
	ld [$3e0a], sp ; $51c9
	rlca ; $51cc
	ld bc, $0300 ; $51cd
	ld de, $3700 ; $51d0
	rst Rst18 ; $51d3
	inc h ; $51d4
	ld a, [bc] ; $51d5
	ld a, $07 ; $51d6
	rst Rst18 ; $51d8
	jr nz, Label_12_51e5 ; $51d9
	ld a, $07 ; $51db
	ld b, $00 ; $51dd
	rst Rst18 ; $51df
	ld l, $0a ; $51e0
	rst Rst30 ; $51e2
	ldh [rTIMA], a ; $51e3
Label_12_51e5:
	jr z, Label_12_522c ; $51e5
	push af ; $51e7
	ld a, $14 ; $51e8
	rst Rst18 ; $51ea
	inc b ; $51eb
	ld a, [bc] ; $51ec
	pop af ; $51ed
	ld a, $02 ; $51ee
	rst Rst18 ; $51f0
	inc e ; $51f1
	ld a, [bc] ; $51f2
	ld a, $02 ; $51f3
	ld bc, $0700 ; $51f5
	ld de, $3900 ; $51f8
	rst Rst18 ; $51fb
	inc h ; $51fc
	ld a, [bc] ; $51fd
	ld a, $02 ; $51fe
	rst Rst18 ; $5200
	jr nz, Label_12_520d ; $5201
	ld a, $02 ; $5203
	ld b, a ; $5205
	ld a, $00 ; $5206
	rst Rst18 ; $5208
	ld [hl-], a ; $5209
	ld a, [bc] ; $520a
	push af ; $520b
	INCBIN "data/bank_012/d_520c.bin" ; $520c, 1 bytes
Label_12_520d:
	ld e, $df ; $520d
	inc b ; $520f
	ld a, [bc] ; $5210
	pop af ; $5211
	ld a, $00 ; $5212
	ld d, $03 ; $5214
	rst Rst18 ; $5216
	inc [hl] ; $5217
	ld a, [bc] ; $5218
	ld a, $02 ; $5219
	ld d, $03 ; $521b
	rst Rst18 ; $521d
	inc [hl] ; $521e
	ld a, [bc] ; $521f
	ld a, $02 ; $5220
	rst Rst18 ; $5222
	ld [hl], $0a ; $5223
	push af ; $5225
	ld a, $14 ; $5226
	rst Rst18 ; $5228
	inc b ; $5229
	ld a, [bc] ; $522a
	pop af ; $522b
Label_12_522c:
	ld a, $00 ; $522c
	ld bc, $0020 ; $522e
	rst Rst18 ; $5231
	jr Label_12_523e ; $5232
	INCBIN "data/bank_012/d_5234.bin" ; $5234, 10 bytes
Label_12_523e:
	ld a, [bc] ; $523e
	ld a, $00 ; $523f
	rst Rst18 ; $5241
	jr nz, Label_12_524e ; $5242
	ld a, $00 ; $5244
	ld bc, $0500 ; $5246
	ld de, $3100 ; $5249
	rst Rst18 ; $524c
	inc h ; $524d
Label_12_524e:
	ld a, [bc] ; $524e
	ld a, $00 ; $524f
	rst Rst18 ; $5251
	jr nz, Label_12_525e ; $5252
	ld a, $07 ; $5254
	ld b, $c0 ; $5256
	rst Rst18 ; $5258
	ld l, $0a ; $5259
	ld a, $07 ; $525b
	INCBIN "data/bank_012/d_525d.bin" ; $525d, 1 bytes
Label_12_525e:
	ld [bc], a ; $525e
	rst Rst18 ; $525f
	inc [hl] ; $5260
	ld a, [bc] ; $5261
	ld a, $00 ; $5262
	ld bc, $0c00 ; $5264
	ld de, $3100 ; $5267
	rst Rst18 ; $526a
	inc h ; $526b
	ld a, [bc] ; $526c
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
	rst Rst18 ; $52b2
	nop ; $52b3
	dec bc ; $52b4
	rst Rst18 ; $52b5
	ld [bc], a ; $52b6
	ld a, [bc] ; $52b7
	ret ; $52b8
	INCBIN "data/bank_012/d_52b9.bin" ; $52b9, 1950 bytes
	rst Rst18 ; $5a57
	ld c, $0a ; $5a58
	ld a, [$c2b1] ; $5a5a
	cp a, $02 ; $5a5d
	jr nc, Label_12_5a68 ; $5a5f
	ld a, $09 ; $5a61
	ld b, $40 ; $5a63
	rst Rst18 ; $5a65
	ld l, $0a ; $5a66
Label_12_5a68:
	ld a, $09 ; $5a68
	rst Rst18 ; $5a6a
	ld [$c90a], sp ; $5a6b
	inc de ; $5a6e
	INCBIN "data/bank_012/d_5a6f.bin" ; $5a6f, 1869 bytes
	rst Rst18 ; $61bc
	inc b ; $61bd
	ld a, [bc] ; $61be
	pop af ; $61bf
	ld a, $00 ; $61c0
	ld b, $80 ; $61c2
	rst Rst18 ; $61c4
	ld l, $0a ; $61c5
	ld a, $07 ; $61c7
	ld b, $80 ; $61c9
	rst Rst18 ; $61cb
	ld l, $0a ; $61cc
	ldh a, [$ff95] ; $61ce
	ld b, a ; $61d0
	ld a, $05 ; $61d1
	ld de, $796f ; $61d3
	rst Rst18 ; $61d6
	ld a, [de] ; $61d7
	ld a, [bc] ; $61d8
	ldh a, [$ff95] ; $61d9
	ld b, a ; $61db
	ld a, $04 ; $61dc
	ld de, $7980 ; $61de
	rst Rst18 ; $61e1
	ld a, [de] ; $61e2
	ld a, [bc] ; $61e3
	ldh a, [$ff95] ; $61e4
	ld b, a ; $61e6
	ld a, $02 ; $61e7
	ld de, $6d0e ; $61e9
	rst Rst18 ; $61ec
	ld a, [de] ; $61ed
	ld a, [bc] ; $61ee
	ldh a, [$ff95] ; $61ef
	ld b, a ; $61f1
	ld a, $00 ; $61f2
	ld de, $6cec ; $61f4
	rst Rst18 ; $61f7
	ld a, [de] ; $61f8
	ld a, [bc] ; $61f9
	xor a, a ; $61fa
	ld bc, $2400 ; $61fb
	ld de, $1700 ; $61fe
	rst Rst18 ; $6201
	ld a, [hl-] ; $6202
	ld a, [bc] ; $6203
	rst Rst18 ; $6204
	ld a, $0a ; $6205
	ld a, $04 ; $6207
	rst Rst18 ; $6209
	ld e, $0a ; $620a
	push af ; $620c
	ld a, $1e ; $620d
	rst Rst18 ; $620f
	inc b ; $6210
	ld a, [bc] ; $6211
	pop af ; $6212
	ld a, $0f ; $6213
	ld [$c294], a ; $6215
	ld [$c2a1], a ; $6218
	rst Rst18 ; $621b
	ld c, d ; $621c
	ld a, [bc] ; $621d
	ld a, $01 ; $621e
	ld [wCurrentMinigameStoryMatch], a ; $6220
	ld a, $09 ; $6223
	ld [$c8f7], a ; $6225
	rst Rst18 ; $6228
	ld e, d ; $6229
	ld a, [bc] ; $622a
	rst Rst18 ; $622b
	ld c, h ; $622c
	ld a, [bc] ; $622d
	rst Rst18 ; $622e
	ld c, [hl] ; $622f
	ld a, [bc] ; $6230
	ret ; $6231
	INCBIN "data/bank_012/d_6232.bin" ; $6232, 513 bytes
Func_12_6433:
	ld a, $0f ; $6433
	rst Rst18 ; $6435
	inc e ; $6436
	ld a, [bc] ; $6437
	ld a, $10 ; $6438
	rst Rst18 ; $643a
	inc e ; $643b
	ld a, [bc] ; $643c
	ld a, $0f ; $643d
	ld bc, $3900 ; $643f
	ld de, $1300 ; $6442
	rst Rst18 ; $6445
	ld [hl+], a ; $6446
	ld a, [bc] ; $6447
	ld a, $10 ; $6448
	ld bc, $3900 ; $644a
	ld de, $1900 ; $644d
	rst Rst18 ; $6450
	ld [hl+], a ; $6451
	ld a, [bc] ; $6452
	ld a, $0f ; $6453
	ld b, $80 ; $6455
	rst Rst18 ; $6457
	ld l, $0a ; $6458
	ld a, $10 ; $645a
	ld b, $80 ; $645c
	rst Rst18 ; $645e
	ld l, $0a ; $645f
	push af ; $6461
	ld a, $14 ; $6462
	rst Rst18 ; $6464
	inc b ; $6465
	ld a, [bc] ; $6466
	pop af ; $6467
	ret ; $6468
	INCBIN "data/bank_012/d_6469.bin" ; $6469, 55 bytes
Func_12_64a0:
	ld a, $0f ; $64a0
	ld bc, $3200 ; $64a2
	ld de, $1100 ; $64a5
	rst Rst18 ; $64a8
	inc h ; $64a9
	ld a, [bc] ; $64aa
	ld a, $10 ; $64ab
	ld bc, $3600 ; $64ad
	ld de, $1d00 ; $64b0
	rst Rst18 ; $64b3
	inc h ; $64b4
	ld a, [bc] ; $64b5
	ld a, $0f ; $64b6
	rst Rst18 ; $64b8
	jr nz, Label_12_64c5 ; $64b9
	ld a, $10 ; $64bb
	rst Rst18 ; $64bd
	jr nz, Label_12_64ca ; $64be
	ld a, $10 ; $64c0
	ld b, $c0 ; $64c2
	rst Rst18 ; $64c4
Label_12_64c5:
	ld l, $0a ; $64c5
	ldh a, [$ff95] ; $64c7
	ld b, a ; $64c9
Label_12_64ca:
	ld a, $0f ; $64ca
	ld de, $7b89 ; $64cc
	rst Rst18 ; $64cf
	ld a, [de] ; $64d0
	ld a, [bc] ; $64d1
	ldh a, [$ff95] ; $64d2
	ld b, a ; $64d4
	ld a, $10 ; $64d5
	ld de, $7bf0 ; $64d7
	rst Rst18 ; $64da
	ld a, [de] ; $64db
	ld a, [bc] ; $64dc
	ret ; $64dd
	INCBIN "data/bank_012/d_64de.bin" ; $64de, 358 bytes
	rst Rst18 ; $6644
	ld [hl], $0a ; $6645
	ldh a, [$ff95] ; $6647
	ld b, a ; $6649
	ld a, $07 ; $664a
	ld de, $78ab ; $664c
	rst Rst18 ; $664f
	ld a, [de] ; $6650
	ld a, [bc] ; $6651
	ldh a, [$ff95] ; $6652
	ld b, a ; $6654
	ld a, $06 ; $6655
	ld de, $78c2 ; $6657
	rst Rst18 ; $665a
	ld a, [de] ; $665b
	ld a, [bc] ; $665c
	ld a, $03 ; $665d
	ld b, $40 ; $665f
	rst Rst18 ; $6661
	ld l, $0a ; $6662
	ld a, $07 ; $6664
	rst Rst18 ; $6666
	ld e, $0a ; $6667
	ld a, $01 ; $6669
	rst Rst18 ; $666b
	inc e ; $666c
	ld a, [bc] ; $666d
	ld a, $00 ; $666e
	ld b, $00 ; $6670
	rst Rst18 ; $6672
	inc a ; $6673
	ld a, [bc] ; $6674
	rst Rst18 ; $6675
	ld a, $0a ; $6676
	ld hl, $107c ; $6678
	rst Rst18 ; $667b
	ld c, $0a ; $667c
	ld a, $06 ; $667e
	ld d, $03 ; $6680
	rst Rst18 ; $6682
	inc [hl] ; $6683
	ld a, [bc] ; $6684
	ld a, $06 ; $6685
	rst Rst18 ; $6687
	ld [hl], $0a ; $6688
	ld a, $06 ; $668a
	rst Rst18 ; $668c
	ld [$3e0a], sp ; $668d
	rlca ; $6690
	ld d, $03 ; $6691
	rst Rst18 ; $6693
	inc [hl] ; $6694
	ld a, [bc] ; $6695
	ld a, $07 ; $6696
	rst Rst18 ; $6698
	ld [hl], $0a ; $6699
	ld a, $07 ; $669b
	rst Rst18 ; $669d
	ld [$3e0a], sp ; $669e
	rlca ; $66a1
	ld b, $c0 ; $66a2
	rst Rst18 ; $66a4
	ld l, $0a ; $66a5
	ld a, $06 ; $66a7
	ld b, $c0 ; $66a9
	rst Rst18 ; $66ab
	ld l, $0a ; $66ac
	ret ; $66ae
	INCBIN "data/bank_012/d_66af.bin" ; $66af, 2220 bytes
	rst Rst18 ; $6f5b
	ld d, $0a ; $6f5c
	ld c, l ; $6f5e
	ld b, h ; $6f5f
	ld de, $d000 ; $6f60
	rst Rst18 ; $6f63
	jr nz, Label_12_6f6a ; $6f64
	rst Rst18 ; $6f66
	ld [bc], a ; $6f67
	ld a, [bc] ; $6f68
	ret ; $6f69
Label_12_6f6a:
	ld a, $02 ; $6f6a
	rst Rst18 ; $6f6c
	inc e ; $6f6d
	ld a, [bc] ; $6f6e
	ld a, $03 ; $6f6f
	ld b, $00 ; $6f71
	rst Rst18 ; $6f73
	ld l, $0a ; $6f74
	ld a, $07 ; $6f76
	ld bc, $3300 ; $6f78
	ld de, $1100 ; $6f7b
	rst Rst18 ; $6f7e
	ld [hl+], a ; $6f7f
	ld a, [bc] ; $6f80
	ld a, $07 ; $6f81
	ld b, $40 ; $6f83
	rst Rst18 ; $6f85
	ld l, $0a ; $6f86
	ld a, $06 ; $6f88
	ld bc, $3500 ; $6f8a
	ld de, $1300 ; $6f8d
	rst Rst18 ; $6f90
	ld [hl+], a ; $6f91
	ld a, [bc] ; $6f92
	ld a, $06 ; $6f93
	ld b, $40 ; $6f95
	rst Rst18 ; $6f97
	ld l, $0a ; $6f98
	ld a, $00 ; $6f9a
	ld bc, $3300 ; $6f9c
	ld de, $1b00 ; $6f9f
	rst Rst18 ; $6fa2
	ld [hl+], a ; $6fa3
	ld a, [bc] ; $6fa4
	ld a, $02 ; $6fa5
	ld bc, $3500 ; $6fa7
	ld de, $1b00 ; $6faa
	rst Rst18 ; $6fad
	ld [hl+], a ; $6fae
	ld a, [bc] ; $6faf
	ld a, $00 ; $6fb0
	ld b, $c0 ; $6fb2
	rst Rst18 ; $6fb4
	ld l, $0a ; $6fb5
	ld a, $02 ; $6fb7
	ld b, $c0 ; $6fb9
	rst Rst18 ; $6fbb
	ld l, $0a ; $6fbc
	call Func_12_77fd ; $6fbe
	ld hl, $1081 ; $6fc1
	rst Rst18 ; $6fc4
	ld c, $0a ; $6fc5
	push af ; $6fc7
	ld a, $28 ; $6fc8
	rst Rst18 ; $6fca
	inc b ; $6fcb
	ld a, [bc] ; $6fcc
	pop af ; $6fcd
	ld a, $07 ; $6fce
	ld d, $02 ; $6fd0
	rst Rst18 ; $6fd2
	inc [hl] ; $6fd3
	ld a, [bc] ; $6fd4
	ld a, $07 ; $6fd5
	rst Rst18 ; $6fd7
	ld [hl], $0a ; $6fd8
	push af ; $6fda
	ld a, $14 ; $6fdb
	rst Rst18 ; $6fdd
	inc b ; $6fde
	ld a, [bc] ; $6fdf
	pop af ; $6fe0
	ld a, $03 ; $6fe1
	ld de, $ff80 ; $6fe3
	rst Rst18 ; $6fe6
	ld b, d ; $6fe7
	ld a, [bc] ; $6fe8
	ld a, $03 ; $6fe9
	rst Rst18 ; $6feb
	ld b, h ; $6fec
	ld a, [bc] ; $6fed
	ld a, $03 ; $6fee
	ld de, $ff80 ; $6ff0
	rst Rst18 ; $6ff3
	ld b, d ; $6ff4
	ld a, [bc] ; $6ff5
	ld a, $03 ; $6ff6
	rst Rst18 ; $6ff8
	ld b, h ; $6ff9
	ld a, [bc] ; $6ffa
	ld a, $03 ; $6ffb
	rst Rst18 ; $6ffd
	ld [$f50a], sp ; $6ffe
	ld a, $3c ; $7001
	rst Rst18 ; $7003
	inc b ; $7004
	ld a, [bc] ; $7005
	pop af ; $7006
	ld a, $03 ; $7007
	ld bc, $2d00 ; $7009
	ld de, $1900 ; $700c
	rst Rst18 ; $700f
	inc h ; $7010
	ld a, [bc] ; $7011
	xor a, a ; $7012
	ld bc, $2d00 ; $7013
	ld de, $1b00 ; $7016
	rst Rst18 ; $7019
	ld a, [hl-] ; $701a
	ld a, [bc] ; $701b
	ld a, $00 ; $701c
	ld bc, $2d00 ; $701e
	ld de, $1b00 ; $7021
	rst Rst18 ; $7024
	inc h ; $7025
	ld a, [bc] ; $7026
	ld a, $02 ; $7027
	ld bc, $2d00 ; $7029
	ld de, $1d00 ; $702c
	rst Rst18 ; $702f
	inc h ; $7030
	ld a, [bc] ; $7031
	ldh a, [$ff95] ; $7032
	ld b, a ; $7034
	ld a, $07 ; $7035
	ld de, $7940 ; $7037
	rst Rst18 ; $703a
	ld a, [de] ; $703b
	ld a, [bc] ; $703c
	ldh a, [$ff95] ; $703d
	ld b, a ; $703f
	ld a, $06 ; $7040
	ld de, $7929 ; $7042
	rst Rst18 ; $7045
	ld a, [de] ; $7046
	ld a, [bc] ; $7047
	call Func_12_64a0 ; $7048
	ld a, $03 ; $704b
	ld b, $40 ; $704d
	rst Rst18 ; $704f
	ld l, $0a ; $7050
	ld a, $00 ; $7052
	ld b, $40 ; $7054
	rst Rst18 ; $7056
	ld l, $0a ; $7057
	ld a, $02 ; $7059
	ld b, $40 ; $705b
	rst Rst18 ; $705d
	ld l, $0a ; $705e
	ld a, $02 ; $7060
	rst Rst18 ; $7062
	ld d, $0a ; $7063
	ld c, l ; $7065
	ld b, h ; $7066
	ld de, $d000 ; $7067
	rst Rst18 ; $706a
	jr nz, Label_12_7071 ; $706b
	rst Rst18 ; $706d
	ld [bc], a ; $706e
	ld a, [bc] ; $706f
	ret ; $7070
Label_12_7071:
	ld a, $09 ; $7071
	ld bc, $1b00 ; $7073
	ld de, $0b00 ; $7076
	rst Rst18 ; $7079
	ld [hl+], a ; $707a
	ld a, [bc] ; $707b
	ld a, $08 ; $707c
	ld bc, $1b00 ; $707e
	ld de, $0d00 ; $7081
	rst Rst18 ; $7084
	ld [hl+], a ; $7085
	ld a, [bc] ; $7086
	ld a, $09 ; $7087
	ld b, $80 ; $7089
	rst Rst18 ; $708b
	ld l, $0a ; $708c
	ld a, $08 ; $708e
	ld b, $80 ; $7090
	rst Rst18 ; $7092
	ld l, $0a ; $7093
	ld a, $08 ; $7095
	rst Rst18 ; $7097
	inc e ; $7098
	ld a, [bc] ; $7099
	ld a, $08 ; $709a
	ld d, $01 ; $709c
	rst Rst18 ; $709e
	inc [hl] ; $709f
	ld a, [bc] ; $70a0
	ld a, $02 ; $70a1
	rst Rst18 ; $70a3
	inc e ; $70a4
	ld a, [bc] ; $70a5
	ld a, $03 ; $70a6
	ld bc, $2b00 ; $70a8
	ld de, $2700 ; $70ab
	rst Rst18 ; $70ae
	ld [hl+], a ; $70af
	ld a, [bc] ; $70b0
	ld a, $04 ; $70b1
	ld bc, $2500 ; $70b3
	ld de, $0f00 ; $70b6
	rst Rst18 ; $70b9
	ld [hl+], a ; $70ba
	ld a, [bc] ; $70bb
	ld a, $04 ; $70bc
	ld b, $40 ; $70be
	rst Rst18 ; $70c0
	ld l, $0a ; $70c1
	ld a, $04 ; $70c3
	rst Rst18 ; $70c5
	inc e ; $70c6
	ld a, [bc] ; $70c7
	ld a, $04 ; $70c8
	ld d, $01 ; $70ca
	rst Rst18 ; $70cc
	inc [hl] ; $70cd
	ld a, [bc] ; $70ce
	ld a, $05 ; $70cf
	ld bc, $2300 ; $70d1
	ld de, $1300 ; $70d4
	rst Rst18 ; $70d7
	ld [hl+], a ; $70d8
	ld a, [bc] ; $70d9
	ld a, $05 ; $70da
	ld b, $40 ; $70dc
	rst Rst18 ; $70de
	ld l, $0a ; $70df
	ld a, $05 ; $70e1
	rst Rst18 ; $70e3
	inc e ; $70e4
	ld a, [bc] ; $70e5
	ld a, $05 ; $70e6
	ld d, $01 ; $70e8
	rst Rst18 ; $70ea
	inc [hl] ; $70eb
	ld a, [bc] ; $70ec
	ld a, $00 ; $70ed
	ld bc, $2500 ; $70ef
	ld de, $1b00 ; $70f2
	rst Rst18 ; $70f5
	ld [hl+], a ; $70f6
	ld a, [bc] ; $70f7
	ld a, $00 ; $70f8
	ld b, $c0 ; $70fa
	rst Rst18 ; $70fc
	ld l, $0a ; $70fd
	ld a, $02 ; $70ff
	ld bc, $2300 ; $7101
	ld de, $1b00 ; $7104
	rst Rst18 ; $7107
	ld [hl+], a ; $7108
	ld a, [bc] ; $7109
	ld a, $02 ; $710a
	ld b, $c0 ; $710c
	rst Rst18 ; $710e
	ld l, $0a ; $710f
	ld bc, $0040 ; $7111
	rst Rst18 ; $7114
	jr c, Label_12_7121 ; $7115
	xor a, a ; $7117
	ld bc, $2400 ; $7118
	ld de, $1500 ; $711b
	rst Rst18 ; $711e
	ld a, [hl-] ; $711f
	ld a, [bc] ; $7120
Label_12_7121:
	rst Rst18 ; $7121
	ld a, $0a ; $7122
	ld a, $03 ; $7124
	ld b, $80 ; $7126
	rst Rst18 ; $7128
	ld l, $0a ; $7129
	rst Rst18 ; $712b
	ld a, $0a ; $712c
	ld c, $20 ; $712e
	call Func_00_1d2e ; $7130
	call Func_00_1da4 ; $7133
	ld hl, $1082 ; $7136
	rst Rst18 ; $7139
	ld c, $0a ; $713a
	ld a, $04 ; $713c
	ld bc, $2500 ; $713e
	ld de, $1300 ; $7141
	rst Rst18 ; $7144
	inc h ; $7145
	ld a, [bc] ; $7146
	ld a, $04 ; $7147
	rst Rst18 ; $7149
	jr nz, Label_12_7156 ; $714a
	ld a, $05 ; $714c
	ld b, a ; $714e
	ld a, $04 ; $714f
	rst Rst18 ; $7151
	ld [hl-], a ; $7152
	ld a, [bc] ; $7153
	ld a, $04 ; $7154
Label_12_7156:
	ld d, $02 ; $7156
	rst Rst18 ; $7158
	inc [hl] ; $7159
	ld a, [bc] ; $715a
	ld a, $04 ; $715b
	rst Rst18 ; $715d
	ld [$3e0a], sp ; $715e
	dec b ; $7161
	ld b, $40 ; $7162
	rst Rst18 ; $7164
	ld l, $0a ; $7165
	ld a, $05 ; $7167
	ld d, $04 ; $7169
	rst Rst18 ; $716b
	inc [hl] ; $716c
	ld a, [bc] ; $716d
	ld a, $05 ; $716e
	rst Rst18 ; $7170
	ld [hl], $0a ; $7171
	ld a, $05 ; $7173
	rst Rst18 ; $7175
	ld [$3e0a], sp ; $7176
	inc bc ; $7179
	ld d, $03 ; $717a
	rst Rst18 ; $717c
	inc [hl] ; $717d
	ld a, [bc] ; $717e
	ld a, $03 ; $717f
	rst Rst18 ; $7181
	ld [$3e0a], sp ; $7182
	inc b ; $7185
	ld d, $02 ; $7186
	rst Rst18 ; $7188
	inc [hl] ; $7189
	ld a, [bc] ; $718a
	ld a, $05 ; $718b
	ld d, $02 ; $718d
	rst Rst18 ; $718f
	inc [hl] ; $7190
	ld a, [bc] ; $7191
	ld a, $02 ; $7192
	ld d, $02 ; $7194
	rst Rst18 ; $7196
	inc [hl] ; $7197
	ld a, [bc] ; $7198
	ld a, $00 ; $7199
	ld d, $02 ; $719b
	rst Rst18 ; $719d
	inc [hl] ; $719e
	ld a, [bc] ; $719f
	ld a, $00 ; $71a0
	ld b, $40 ; $71a2
	rst Rst18 ; $71a4
	ld l, $0a ; $71a5
	ld a, $02 ; $71a7
	ld b, $40 ; $71a9
	rst Rst18 ; $71ab
	ld l, $0a ; $71ac
	ld a, $04 ; $71ae
	ld b, $40 ; $71b0
	rst Rst18 ; $71b2
	ld l, $0a ; $71b3
	ld bc, $0010 ; $71b5
	rst Rst18 ; $71b8
	jr c, Label_12_71c5 ; $71b9
	ld a, $03 ; $71bb
	ld bc, $0010 ; $71bd
	rst Rst18 ; $71c0
	jr Label_12_71cd ; $71c1
	INCBIN "data/bank_012/d_71c3.bin" ; $71c3, 2 bytes
Label_12_71c5:
	nop ; $71c5
	dec hl ; $71c6
	ld de, $2000 ; $71c7
	rst Rst18 ; $71ca
	ld a, [hl-] ; $71cb
	ld a, [bc] ; $71cc
Label_12_71cd:
	ld a, $03 ; $71cd
	ld bc, $2b00 ; $71cf
	ld de, $2000 ; $71d2
	rst Rst18 ; $71d5
	inc h ; $71d6
	ld a, [bc] ; $71d7
	ld a, $03 ; $71d8
	rst Rst18 ; $71da
	jr nz, Label_12_71e7 ; $71db
	rst Rst18 ; $71dd
	ld a, $0a ; $71de
	xor a, a ; $71e0
	ld bc, $2400 ; $71e1
	ld de, $1b00 ; $71e4
Label_12_71e7:
	rst Rst18 ; $71e7
	ld a, [hl-] ; $71e8
	ld a, [bc] ; $71e9
	ld a, $03 ; $71ea
	ld bc, $2500 ; $71ec
	ld de, $1f00 ; $71ef
	rst Rst18 ; $71f2
	inc h ; $71f3
	ld a, [bc] ; $71f4
	ld a, $03 ; $71f5
	rst Rst18 ; $71f7
	jr nz, Label_12_7204 ; $71f8
	ld a, $03 ; $71fa
	ld b, $c0 ; $71fc
	rst Rst18 ; $71fe
	ld l, $0a ; $71ff
	ld a, $03 ; $7201
	INCBIN "data/bank_012/d_7203.bin" ; $7203, 1 bytes
Label_12_7204:
	ld [bc], a ; $7204
	rst Rst18 ; $7205
	inc [hl] ; $7206
	ld a, [bc] ; $7207
	ld a, $03 ; $7208
	rst Rst18 ; $720a
	ld [hl], $0a ; $720b
	ld a, $03 ; $720d
	rst Rst18 ; $720f
	ld [$3e0a], sp ; $7210
	ld [bc], a ; $7213
	ld b, a ; $7214
	ld a, $00 ; $7215
	rst Rst18 ; $7217
	ld [hl-], a ; $7218
	ld a, [bc] ; $7219
	push af ; $721a
	ld a, $1e ; $721b
	rst Rst18 ; $721d
	inc b ; $721e
	ld a, [bc] ; $721f
	pop af ; $7220
	ld a, $00 ; $7221
	ld b, $40 ; $7223
	rst Rst18 ; $7225
	ld l, $0a ; $7226
	ld a, $02 ; $7228
	ld b, $40 ; $722a
	rst Rst18 ; $722c
	ld l, $0a ; $722d
	ld a, $02 ; $722f
	ld d, $03 ; $7231
	rst Rst18 ; $7233
	inc [hl] ; $7234
	ld a, [bc] ; $7235
	ld a, $00 ; $7236
	ld d, $03 ; $7238
	rst Rst18 ; $723a
	inc [hl] ; $723b
	ld a, [bc] ; $723c
	ld a, $00 ; $723d
	rst Rst18 ; $723f
	ld [hl], $0a ; $7240
	ld a, $03 ; $7242
	ld d, $03 ; $7244
	rst Rst18 ; $7246
	inc [hl] ; $7247
	ld a, [bc] ; $7248
	ld a, $03 ; $7249
	rst Rst18 ; $724b
	ld [hl], $0a ; $724c
	ld hl, $1087 ; $724e
	rst Rst18 ; $7251
	ld c, $0a ; $7252
	ld a, $03 ; $7254
	rst Rst18 ; $7256
	ld [$3e0a], sp ; $7257
	inc bc ; $725a
	ld bc, $2500 ; $725b
	ld de, $1d00 ; $725e
	rst Rst18 ; $7261
	inc h ; $7262
	ld a, [bc] ; $7263
	ld a, $03 ; $7264
	rst Rst18 ; $7266
	jr nz, Label_12_7273 ; $7267
	ld a, $03 ; $7269
	ld d, $02 ; $726b
	rst Rst18 ; $726d
	inc [hl] ; $726e
	ld a, [bc] ; $726f
	ld a, $03 ; $7270
	rst Rst18 ; $7272
Label_12_7273:
	ld [hl], $0a ; $7273
	push af ; $7275
	ld a, $1e ; $7276
	rst Rst18 ; $7278
	inc b ; $7279
	ld a, [bc] ; $727a
	pop af ; $727b
	ld a, $03 ; $727c
	ld d, $03 ; $727e
	rst Rst18 ; $7280
	inc [hl] ; $7281
	ld a, [bc] ; $7282
	ld a, $00 ; $7283
	ld d, $03 ; $7285
	rst Rst18 ; $7287
	inc [hl] ; $7288
	ld a, [bc] ; $7289
	ld a, $00 ; $728a
	rst Rst18 ; $728c
	ld [hl], $0a ; $728d
	ld a, $00 ; $728f
	rst Rst18 ; $7291
	ld [$3e0a], sp ; $7292
	inc bc ; $7295
	ld d, $02 ; $7296
	rst Rst18 ; $7298
	inc [hl] ; $7299
	ld a, [bc] ; $729a
	ld a, $03 ; $729b
	rst Rst18 ; $729d
	ld [hl], $0a ; $729e
	ld a, $03 ; $72a0
	rst Rst18 ; $72a2
	ld [$3e0a], sp ; $72a3
	inc bc ; $72a6
	ld d, $03 ; $72a7
	rst Rst18 ; $72a9
	inc [hl] ; $72aa
	ld a, [bc] ; $72ab
	ld a, $03 ; $72ac
	rst Rst18 ; $72ae
	ld [hl], $0a ; $72af
	ld a, $03 ; $72b1
	rst Rst18 ; $72b3
	ld [$3e0a], sp ; $72b4
	nop ; $72b7
	ld d, $03 ; $72b8
	rst Rst18 ; $72ba
	inc [hl] ; $72bb
	ld a, [bc] ; $72bc
	ld a, $00 ; $72bd
	rst Rst18 ; $72bf
	ld [hl], $0a ; $72c0
	ld a, $03 ; $72c2
	ld d, $03 ; $72c4
	rst Rst18 ; $72c6
	inc [hl] ; $72c7
	ld a, [bc] ; $72c8
	ld a, $03 ; $72c9
	rst Rst18 ; $72cb
	ld [hl], $0a ; $72cc
	ld a, $00 ; $72ce
	ld d, $02 ; $72d0
	rst Rst18 ; $72d2
	inc [hl] ; $72d3
	ld a, [bc] ; $72d4
	ld a, $00 ; $72d5
	rst Rst18 ; $72d7
	ld [hl], $0a ; $72d8
	ld a, $00 ; $72da
	ld b, $c0 ; $72dc
	rst Rst18 ; $72de
	ld l, $0a ; $72df
	ld a, $02 ; $72e1
	ld b, $c0 ; $72e3
	rst Rst18 ; $72e5
	ld l, $0a ; $72e6
	push af ; $72e8
	ld a, $28 ; $72e9
	rst Rst18 ; $72eb
	inc b ; $72ec
	ld a, [bc] ; $72ed
	pop af ; $72ee
	xor a, a ; $72ef
	ld bc, $2400 ; $72f0
	ld de, $1700 ; $72f3
	rst Rst18 ; $72f6
	ld a, [hl-] ; $72f7
	ld a, [bc] ; $72f8
	rst Rst18 ; $72f9
	ld a, $0a ; $72fa
	ld a, $05 ; $72fc
	ld d, $02 ; $72fe
	rst Rst18 ; $7300
	inc [hl] ; $7301
	ld a, [bc] ; $7302
	push af ; $7303
	ld a, $28 ; $7304
	rst Rst18 ; $7306
	inc b ; $7307
	ld a, [bc] ; $7308
	pop af ; $7309
	ld a, $05 ; $730a
	rst Rst18 ; $730c
	ld [$3e0a], sp ; $730d
	inc b ; $7310
	ld bc, $2500 ; $7311
	ld de, $1500 ; $7314
	rst Rst18 ; $7317
	inc h ; $7318
	ld a, [bc] ; $7319
	ld a, $04 ; $731a
	rst Rst18 ; $731c
	jr nz, Label_12_7329 ; $731d
	ld a, $04 ; $731f
	rst Rst18 ; $7321
	ld [$3e0a], sp ; $7322
	ld [bc], a ; $7325
	ld b, a ; $7326
	ld a, $00 ; $7327
Label_12_7329:
	rst Rst18 ; $7329
	ld [hl-], a ; $732a
	ld a, [bc] ; $732b
	push af ; $732c
	ld a, $0a ; $732d
	rst Rst18 ; $732f
	inc b ; $7330
	ld a, [bc] ; $7331
	pop af ; $7332
	ld a, $00 ; $7333
	ld d, $02 ; $7335
	rst Rst18 ; $7337
	inc [hl] ; $7338
	ld a, [bc] ; $7339
	ld a, $02 ; $733a
	ld d, $02 ; $733c
	rst Rst18 ; $733e
	inc [hl] ; $733f
	ld a, [bc] ; $7340
	ld a, $02 ; $7341
	rst Rst18 ; $7343
	ld [hl], $0a ; $7344
	ld a, $00 ; $7346
	ld b, $c0 ; $7348
	rst Rst18 ; $734a
	ld l, $0a ; $734b
	ld a, $02 ; $734d
	ld b, $c0 ; $734f
	rst Rst18 ; $7351
	ld l, $0a ; $7352
	ld a, $02 ; $7354
	ld d, $03 ; $7356
	rst Rst18 ; $7358
	inc [hl] ; $7359
	ld a, [bc] ; $735a
	ld a, $00 ; $735b
	ld d, $03 ; $735d
	rst Rst18 ; $735f
	inc [hl] ; $7360
	ld a, [bc] ; $7361
	ld a, $00 ; $7362
	rst Rst18 ; $7364
	ld [hl], $0a ; $7365
	push af ; $7367
	ld a, $0a ; $7368
	rst Rst18 ; $736a
	inc b ; $736b
	ld a, [bc] ; $736c
	pop af ; $736d
	ld a, $04 ; $736e
	ld d, $03 ; $7370
	rst Rst18 ; $7372
	inc [hl] ; $7373
	ld a, [bc] ; $7374
	ld a, $05 ; $7375
	ld d, $03 ; $7377
	rst Rst18 ; $7379
	inc [hl] ; $737a
	ld a, [bc] ; $737b
	ld a, $05 ; $737c
	rst Rst18 ; $737e
	ld [hl], $0a ; $737f
	ld a, $10 ; $7381
	ld [wStoryModeCurrentLocation], a ; $7383
	ld a, $01 ; $7386
	ld [$c295], a ; $7388
	ld a, $ff ; $738b
	ld [$c294], a ; $738d
	ld [$c2a1], a ; $7390
	ld a, $03 ; $7393
	ld d, $03 ; $7395
	rst Rst18 ; $7397
	inc [hl] ; $7398
	ld a, [bc] ; $7399
	ld a, $03 ; $739a
	rst Rst18 ; $739c
	ld [hl], $0a ; $739d
	push af ; $739f
	ld a, $1e ; $73a0
	rst Rst18 ; $73a2
	inc b ; $73a3
	ld a, [bc] ; $73a4
	pop af ; $73a5
	ld c, $08 ; $73a6
	call Func_00_1d20 ; $73a8
	call Func_00_1da4 ; $73ab
	rst Rst18 ; $73ae
	ld [bc], a ; $73af
	ld a, [bc] ; $73b0
	ret ; $73b1
	INCBIN "data/bank_012/d_73b2.bin" ; $73b2, 1099 bytes
Func_12_77fd:
	call Func_12_6433 ; $77fd
	ld bc, $0040 ; $7800
	rst Rst18 ; $7803
	jr c, Label_12_7810 ; $7804
	xor a, a ; $7806
	ld bc, $3500 ; $7807
	ld de, $1500 ; $780a
	rst Rst18 ; $780d
	ld a, [hl-] ; $780e
	ld a, [bc] ; $780f
Label_12_7810:
	rst Rst18 ; $7810
	ld a, $0a ; $7811
	ld a, $00 ; $7813
	ld b, $c0 ; $7815
	rst Rst18 ; $7817
	ld l, $0a ; $7818
	ld a, $03 ; $781a
	ld b, $00 ; $781c
	rst Rst18 ; $781e
	ld l, $0a ; $781f
	rst Rst18 ; $7821
	ld a, $0a ; $7822
	ld c, $20 ; $7824
	call Func_00_1d2e ; $7826
	call Func_00_1da4 ; $7829
	ret ; $782c
	INCBIN "data/bank_012/d_782d.bin" ; $782d, 644 bytes
	ret ; $7ab1
	INCBIN "data/bank_012/d_7ab2.bin" ; $7ab2, 1358 bytes
