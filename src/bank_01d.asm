INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $1d", ROMX[$4000], BANK[$1d]

FarPtr_1d_00:
	dw Func_1d_4016 ; $4000
FarPtr_1d_02:
	dw Func_1d_5a63 ; $4002
FarPtr_1d_04:
	dw Func_1d_68a3 ; $4004
FarPtr_1d_06:
	dw Func_1d_682c ; $4006
FarPtr_1d_08:
	dw Func_1d_7cae ; $4008
FarPtr_1d_0a:
	dw Func_1d_7cc6 ; $400a
FarPtr_1d_0c:
	dw Func_1d_5be3 ; $400c
FarPtr_1d_0e:
	dw Func_1d_5c0b ; $400e
FarPtr_1d_10:
	dw Func_1d_5c15 ; $4010
FarPtr_1d_12:
	dw Func_1d_5c1e ; $4012
FarPtr_1d_14:
	dw Func_1d_7205 ; $4014
Func_1d_4016:
	ld b, a ; $4016
	ld a, $06 ; $4017
	ldh [$ff96], a ; $4019
	ldh [rWBK], a ; $401b
	ld a, b ; $401d
	ld [$d149], a ; $401e
	sound $04 ; $4021
	farcall FarPtr_02_10 ; $4023
	call EnableLCD ; $4026
	ld c, $7f ; $4029
	call Func_00_1d20 ; $402b
	call Func_00_1da4 ; $402e
	call Func_1d_5be3 ; $4031
	ld hl, $6334 ; $4034
	ld de, $0d01 ; $4037
	call LoadPaletteShadow ; $403a
	ld a, $01 ; $403d
	ldh [$ff96], a ; $403f
	ldh [rWBK], a ; $4041
	ld hl, $633c ; $4043
	ld de, $d000 ; $4046
	call DecompressData ; $4049
	ld hl, $d000 ; $404c
	ld de, $a600 ; $404f
	ld c, $14 ; $4052
	call Func_00_0480 ; $4054
	farcall FarPtr_39_24 ; $4057
	ld b, $05 ; $405a
	ld c, $05 ; $405c
	farcall FarPtr_39_26 ; $405e
	ld a, $0d ; $4061
	ld [$cb17], a ; $4063
	ld a, $0d ; $4066
	ld [$cb18], a ; $4068
	ld a, $60 ; $406b
	ld [$cb15], a ; $406d
	ld a, $60 ; $4070
	ld [$cb16], a ; $4072
	ld hl, rIE ; $4075
	res 2, [hl] ; $4078
	call EnableLCD ; $407a
	call Func_00_2631 ; $407d
	ld a, $01 ; $4080
	ld hl, $40cc ; $4082
	call Func_00_1b6a ; $4085
	ld a, $01 ; $4088
	ld hl, $4c04 ; $408a
	call Func_00_1b6a ; $408d
	ld a, $01 ; $4090
	ld hl, $48c7 ; $4092
	call Func_00_1b6a ; $4095
	farcall FarPtr_1c_12 ; $4098
	ld c, $10 ; $409b
	call Func_00_1d2e ; $409d
	call Func_00_1da4 ; $40a0
	call Func_1d_4cac ; $40a3
	ld hl, rIE ; $40a6
	set 2, [hl] ; $40a9
	ld c, $10 ; $40ab
	call Func_00_1d20 ; $40ad
	call Func_00_1da4 ; $40b0
	ld hl, $4c04 ; $40b3
	call Func_00_1bcb ; $40b6
	ld hl, $48c7 ; $40b9
	call Func_00_1bcb ; $40bc
	ld hl, $40cc ; $40bf
	call Func_00_1bcb ; $40c2
	farcall FarPtr_1c_14 ; $40c5
	call Func_00_1b38 ; $40c8
	ret ; $40cb
	farcall FarPtr_39_28 ; $40cc
	ret ; $40cf
Func_1d_40d0:
	ld a, $06 ; $40d0
	ldh [$ff96], a ; $40d2
	ldh [rWBK], a ; $40d4
	xor a, a ; $40d6
	ld [$d000], a ; $40d7
	ld [$d001], a ; $40da
	ld [$d002], a ; $40dd
	ld [$d142], a ; $40e0
	ld [$d143], a ; $40e3
	ld [$d144], a ; $40e6
	ld hl, $d145 ; $40e9
	ld de, $00a8 ; $40ec
	ld a, e ; $40ef
	ld [hl+], a ; $40f0
	ld [hl], d ; $40f1
	ld hl, $d147 ; $40f2
	ld de, $0000 ; $40f5
	ld a, e ; $40f8
	ld [hl+], a ; $40f9
	ld [hl], d ; $40fa
	xor a, a ; $40fb
	ld [$d019], a ; $40fc
	ld [$d01a], a ; $40ff
	ld [$d01b], a ; $4102
	ld [$d01c], a ; $4105
	ld [$d01d], a ; $4108
	ld [$d01e], a ; $410b
	ld [$d01f], a ; $410e
	ld [$d020], a ; $4111
	ld [$d021], a ; $4114
	ld [$d022], a ; $4117
	ld [$d023], a ; $411a
	ret ; $411d
Func_1d_411e:
	farcall FarPtr_1c_02 ; $411e
	call Func_1d_4175 ; $4121
	xor a, a ; $4124
	call Func_1d_4a14 ; $4125
	call Func_1d_4aa9 ; $4128
	call Func_1d_4aeb ; $412b
	ld a, $02 ; $412e
	call Func_1d_4a14 ; $4130
	call Func_1d_4aa9 ; $4133
	call Func_1d_4b50 ; $4136
	ld a, $03 ; $4139
	call Func_1d_4a14 ; $413b
	call Func_1d_4aa9 ; $413e
	call Func_1d_4acc ; $4141
	ld a, $01 ; $4144
	call Func_1d_4a14 ; $4146
	ld hl, $5c25 ; $4149
	ld bc, $d390 ; $414c
	call Func_1d_4bb6 ; $414f
	ld a, $03 ; $4152
	ldh [$ff96], a ; $4154
	ldh [rWBK], a ; $4156
	ld hl, $d000 ; $4158
	ld de, $9800 ; $415b
	ld c, $24 ; $415e
	call Func_00_0480 ; $4160
	ld a, $02 ; $4163
	ldh [$ff96], a ; $4165
	ldh [rWBK], a ; $4167
	ld hl, $d000 ; $4169
	ld de, $b800 ; $416c
	ld c, $24 ; $416f
	call Func_00_0480 ; $4171
	ret ; $4174
Func_1d_4175:
	ld a, $01 ; $4175
	ldh [$ff96], a ; $4177
	ldh [rWBK], a ; $4179
	ld hl, $65e4 ; $417b
	ld de, $d000 ; $417e
	call DecompressData ; $4181
	ld hl, $d000 ; $4184
	ld de, $a140 ; $4187
	ld c, $0a ; $418a
	call Func_00_0480 ; $418c
	ld a, $01 ; $418f
	ldh [$ff96], a ; $4191
	ldh [rWBK], a ; $4193
	ld hl, $667f ; $4195
	ld de, $d000 ; $4198
	call DecompressData ; $419b
	ld hl, $d000 ; $419e
	ld de, $a1e0 ; $41a1
	ld c, $0a ; $41a4
	call Func_00_0480 ; $41a6
	ld a, $01 ; $41a9
	ldh [$ff96], a ; $41ab
	ldh [rWBK], a ; $41ad
	ld hl, $6721 ; $41af
	ld de, $d000 ; $41b2
	call DecompressData ; $41b5
	ld hl, $d000 ; $41b8
	ld de, $a280 ; $41bb
	ld c, $08 ; $41be
	call Func_00_0480 ; $41c0
	ld a, $01 ; $41c3
	ldh [$ff96], a ; $41c5
	ldh [rWBK], a ; $41c7
	ld hl, $67ab ; $41c9
	ld de, $d000 ; $41cc
	call DecompressData ; $41cf
	ld hl, $d000 ; $41d2
	ld de, $a300 ; $41d5
	ld c, $08 ; $41d8
	call Func_00_0480 ; $41da
	ld a, $01 ; $41dd
	ldh [$ff96], a ; $41df
	ldh [rWBK], a ; $41e1
	ld hl, $6485 ; $41e3
	ld de, $d380 ; $41e6
	call DecompressData ; $41e9
	ld hl, $d380 ; $41ec
	ld bc, $0009 ; $41ef
	call Func_1d_4423 ; $41f2
	ld a, $01 ; $41f5
	ldh [$ff96], a ; $41f7
	ldh [rWBK], a ; $41f9
	ld hl, $6493 ; $41fb
	ld de, $d380 ; $41fe
	call DecompressData ; $4201
	ld hl, $d380 ; $4204
	ld bc, $0009 ; $4207
	call Func_1d_4438 ; $420a
	ld a, $01 ; $420d
	ldh [$ff96], a ; $420f
	ldh [rWBK], a ; $4211
	ld hl, $6321 ; $4213
	ld de, $d390 ; $4216
	call DecompressData ; $4219
	ld hl, $d390 ; $421c
	ld bc, $0028 ; $421f
	call Func_1d_4423 ; $4222
	ld a, $01 ; $4225
	ldh [$ff96], a ; $4227
	ldh [rWBK], a ; $4229
	ld hl, $632b ; $422b
	ld de, $d390 ; $422e
	call DecompressData ; $4231
	ld hl, $d390 ; $4234
	ld bc, $0028 ; $4237
	call Func_1d_4438 ; $423a
	ld a, $01 ; $423d
	ldh [$ff96], a ; $423f
	ldh [rWBK], a ; $4241
	ld hl, $63f4 ; $4243
	ld de, $d3c0 ; $4246
	call DecompressData ; $4249
	ld hl, $d3c0 ; $424c
	ld bc, $0082 ; $424f
	call Func_1d_4423 ; $4252
	ld a, $01 ; $4255
	ldh [$ff96], a ; $4257
	ldh [rWBK], a ; $4259
	ld hl, $6449 ; $425b
	ld de, $d3c0 ; $425e
	call DecompressData ; $4261
	ld hl, $d3c0 ; $4264
	ld bc, $0082 ; $4267
	call Func_1d_4438 ; $426a
	ld a, $01 ; $426d
	ldh [$ff96], a ; $426f
	ldh [rWBK], a ; $4271
	ld hl, $63f4 ; $4273
	ld de, $d450 ; $4276
	call DecompressData ; $4279
	ld hl, $d450 ; $427c
	ld bc, $0082 ; $427f
	call Func_1d_4423 ; $4282
	ld a, $01 ; $4285
	ldh [$ff96], a ; $4287
	ldh [rWBK], a ; $4289
	ld hl, $6449 ; $428b
	ld de, $d450 ; $428e
	call DecompressData ; $4291
	ld hl, $d450 ; $4294
	ld bc, $0082 ; $4297
	call Func_1d_4438 ; $429a
	ld a, $01 ; $429d
	ldh [$ff96], a ; $429f
	ldh [rWBK], a ; $42a1
	ld hl, $645b ; $42a3
	ld de, $d4e0 ; $42a6
	call DecompressData ; $42a9
	ld hl, $d4e0 ; $42ac
	ld bc, $001c ; $42af
	call Func_1d_4423 ; $42b2
	ld a, $01 ; $42b5
	ldh [$ff96], a ; $42b7
	ldh [rWBK], a ; $42b9
	ld hl, $647e ; $42bb
	ld de, $d4e0 ; $42be
	call DecompressData ; $42c1
	ld hl, $d4e0 ; $42c4
	ld bc, $001c ; $42c7
	call Func_1d_4438 ; $42ca
	ld a, $01 ; $42cd
	ldh [$ff96], a ; $42cf
	ldh [rWBK], a ; $42d1
	ld hl, $649a ; $42d3
	ld de, $d500 ; $42d6
	call DecompressData ; $42d9
	ld hl, $d500 ; $42dc
	ld bc, $002a ; $42df
	call Func_1d_4423 ; $42e2
	ld a, $01 ; $42e5
	ldh [$ff96], a ; $42e7
	ldh [rWBK], a ; $42e9
	ld hl, $64b2 ; $42eb
	ld de, $d500 ; $42ee
	call DecompressData ; $42f1
	ld hl, $d500 ; $42f4
	ld bc, $002a ; $42f7
	call Func_1d_4438 ; $42fa
	ld a, $01 ; $42fd
	ldh [$ff96], a ; $42ff
	ldh [rWBK], a ; $4301
	ld hl, $64bb ; $4303
	ld de, $d000 ; $4306
	call DecompressData ; $4309
	ld hl, $d000 ; $430c
	ld de, $a380 ; $430f
	ld c, $14 ; $4312
	call Func_00_0480 ; $4314
	ld hl, $656f ; $4317
	ld de, $d000 ; $431a
	call DecompressData ; $431d
	ld hl, $d000 ; $4320
	ld de, $a4c0 ; $4323
	ld c, $14 ; $4326
	call Func_00_0480 ; $4328
	ld a, $01 ; $432b
	ldh [$ff96], a ; $432d
	ldh [rWBK], a ; $432f
	ld hl, $6550 ; $4331
	ld de, $d530 ; $4334
	call DecompressData ; $4337
	ld hl, $d530 ; $433a
	ld bc, $001e ; $433d
	call Func_1d_4423 ; $4340
	ld a, $01 ; $4343
	ldh [$ff96], a ; $4345
	ldh [rWBK], a ; $4347
	ld hl, $6568 ; $4349
	ld de, $d530 ; $434c
	call DecompressData ; $434f
	ld hl, $d530 ; $4352
	ld bc, $001e ; $4355
	call Func_1d_4438 ; $4358
	xor a, a ; $435b
	ld [$cb00], a ; $435c
	push af ; $435f
	ld hl, $c900 ; $4360
	ld a, [$cb00] ; $4363
	or a, a ; $4366
	jr z, Label_1d_436b ; $4367
	ld l, $40 ; $4369
Label_1d_436b:
	ld a, l ; $436b
	add a, $0c ; $436c
	ld l, a ; $436e
	ld a, h ; $436f
	adc a, $00 ; $4370
	ld h, a ; $4372
	pop af ; $4373
	ld a, [hl] ; $4374
	ld de, $0401 ; $4375
	farcall FarPtr_1b_02 ; $4378
	ld a, $01 ; $437b
	ldh [$ff96], a ; $437d
	ldh [rWBK], a ; $437f
	push af ; $4381
	ld hl, $c900 ; $4382
	ld a, [$cb00] ; $4385
	or a, a ; $4388
	jr z, Label_1d_438d ; $4389
	ld l, $40 ; $438b
Label_1d_438d:
	ld a, l ; $438d
	add a, $0b ; $438e
	ld l, a ; $4390
	ld a, h ; $4391
	adc a, $00 ; $4392
	ld h, a ; $4394
	pop af ; $4395
	ld a, [hl] ; $4396
	ld de, $d000 ; $4397
	farcall FarPtr_1b_00 ; $439a
	ld hl, $d000 ; $439d
	ld de, $b200 ; $43a0
	ld c, $03 ; $43a3
	call Func_00_0480 ; $43a5
	ld hl, $d030 ; $43a8
	ld de, $b300 ; $43ab
	ld c, $03 ; $43ae
	call Func_00_0480 ; $43b0
	ld hl, $d060 ; $43b3
	ld de, $b400 ; $43b6
	ld c, $03 ; $43b9
	call Func_00_0480 ; $43bb
	ld a, $01 ; $43be
	ld [$cb00], a ; $43c0
	push af ; $43c3
	ld hl, $c900 ; $43c4
	ld a, [$cb00] ; $43c7
	or a, a ; $43ca
	jr z, Label_1d_43cf ; $43cb
	ld l, $40 ; $43cd
Label_1d_43cf:
	ld a, l ; $43cf
	add a, $0c ; $43d0
	ld l, a ; $43d2
	ld a, h ; $43d3
	adc a, $00 ; $43d4
	ld h, a ; $43d6
	pop af ; $43d7
	ld a, [hl] ; $43d8
	ld de, $0101 ; $43d9
	farcall FarPtr_1b_02 ; $43dc
	ld a, $01 ; $43df
	ldh [$ff96], a ; $43e1
	ldh [rWBK], a ; $43e3
	push af ; $43e5
	ld hl, $c900 ; $43e6
	ld a, [$cb00] ; $43e9
	or a, a ; $43ec
	jr z, Label_1d_43f1 ; $43ed
	ld l, $40 ; $43ef
Label_1d_43f1:
	ld a, l ; $43f1
	add a, $0b ; $43f2
	ld l, a ; $43f4
	ld a, h ; $43f5
	adc a, $00 ; $43f6
	ld h, a ; $43f8
	pop af ; $43f9
	ld a, [hl] ; $43fa
	ld de, $d000 ; $43fb
	farcall FarPtr_1b_00 ; $43fe
	ld hl, $d000 ; $4401
	ld de, $b230 ; $4404
	ld c, $03 ; $4407
	call Func_00_0480 ; $4409
	ld hl, $d030 ; $440c
	ld de, $b330 ; $440f
	ld c, $03 ; $4412
	call Func_00_0480 ; $4414
	ld hl, $d060 ; $4417
	ld de, $b430 ; $441a
	ld c, $03 ; $441d
	call Func_00_0480 ; $441f
	ret ; $4422
Func_1d_4423:
	ld a, $01 ; $4423
	ldh [$ff96], a ; $4425
	ldh [rWBK], a ; $4427
	ld d, [hl] ; $4429
	ld a, $03 ; $442a
	ldh [$ff96], a ; $442c
	ldh [rWBK], a ; $442e
	ld [hl], d ; $4430
	inc hl ; $4431
	dec bc ; $4432
	ld a, b ; $4433
	or a, c ; $4434
	jr nz, Func_1d_4423 ; $4435
	ret ; $4437
Func_1d_4438:
	ld a, $01 ; $4438
	ldh [$ff96], a ; $443a
	ldh [rWBK], a ; $443c
	ld d, [hl] ; $443e
	ld a, $02 ; $443f
	ldh [$ff96], a ; $4441
	ldh [rWBK], a ; $4443
	ld [hl], d ; $4445
	inc hl ; $4446
	dec bc ; $4447
	ld a, b ; $4448
	or a, c ; $4449
	jr nz, Func_1d_4438 ; $444a
	ret ; $444c
Func_1d_444d:
	xor a, a ; $444d
	ld [$cb00], a ; $444e
	push af ; $4451
	ld hl, $c900 ; $4452
	ld a, [$cb00] ; $4455
	or a, a ; $4458
	jr z, Label_1d_445d ; $4459
	ld l, $40 ; $445b
Label_1d_445d:
	ld a, l ; $445d
	add a, $00 ; $445e
	ld l, a ; $4460
	ld a, h ; $4461
	adc a, $00 ; $4462
	ld h, a ; $4464
	pop af ; $4465
	ld de, $d3cb ; $4466
	ld c, $0a ; $4469
	call Func_1d_47b0 ; $446b
	ld hl, $5d7e ; $446e
	ld de, $d3c0 ; $4471
	ld b, $0c ; $4474
	call Func_1d_4771 ; $4476
	push af ; $4479
	ld hl, $c900 ; $447a
	ld a, [$cb00] ; $447d
	or a, a ; $4480
	jr z, Label_1d_4485 ; $4481
	ld l, $40 ; $4483
Label_1d_4485:
	ld a, l ; $4485
	add a, $0e ; $4486
	ld l, a ; $4488
	ld a, h ; $4489
	adc a, $00 ; $448a
	ld h, a ; $448c
	pop af ; $448d
	ld a, [hl] ; $448e
	ld hl, $d3e3 ; $448f
	call Func_1d_4793 ; $4492
	ld a, $06 ; $4495
	ldh [$ff96], a ; $4497
	ldh [rWBK], a ; $4499
	push af ; $449b
	ld hl, $c900 ; $449c
	ld a, [$cb00] ; $449f
	or a, a ; $44a2
	jr z, Label_1d_44a7 ; $44a3
	ld l, $40 ; $44a5
Label_1d_44a7:
	ld a, l ; $44a7
	add a, $18 ; $44a8
	ld l, a ; $44aa
	ld a, h ; $44ab
	adc a, $00 ; $44ac
	ld h, a ; $44ae
	pop af ; $44af
	ld a, [hl] ; $44b0
	ld h, $00 ; $44b1
	ld l, a ; $44b3
	ld a, $02 ; $44b4
	ld de, $d08e ; $44b6
	call Func_00_1a27 ; $44b9
	ld de, $d3db ; $44bc
	farcall FarPtr_1c_04 ; $44bf
	ld a, $06 ; $44c2
	ldh [$ff96], a ; $44c4
	ldh [rWBK], a ; $44c6
	push af ; $44c8
	ld hl, $c900 ; $44c9
	ld a, [$cb00] ; $44cc
	or a, a ; $44cf
	jr z, Label_1d_44d4 ; $44d0
	ld l, $40 ; $44d2
Label_1d_44d4:
	ld a, l ; $44d4
	add a, $38 ; $44d5
	ld l, a ; $44d7
	ld a, h ; $44d8
	adc a, $00 ; $44d9
	ld h, a ; $44db
	pop af ; $44dc
	ld a, [hl] ; $44dd
	ld h, $00 ; $44de
	ld l, a ; $44e0
	ld a, $02 ; $44e1
	ld de, $d08e ; $44e3
	call Func_00_1a27 ; $44e6
	ld de, $d3f9 ; $44e9
	farcall FarPtr_1c_04 ; $44ec
	ld a, $06 ; $44ef
	ldh [$ff96], a ; $44f1
	ldh [rWBK], a ; $44f3
	push af ; $44f5
	ld hl, $c900 ; $44f6
	ld a, [$cb00] ; $44f9
	or a, a ; $44fc
	jr z, Label_1d_4501 ; $44fd
	ld l, $40 ; $44ff
Label_1d_4501:
	ld a, l ; $4501
	add a, $39 ; $4502
	ld l, a ; $4504
	ld a, h ; $4505
	adc a, $00 ; $4506
	ld h, a ; $4508
	pop af ; $4509
	ld a, [hl] ; $450a
	ld h, $00 ; $450b
	ld l, a ; $450d
	ld a, $02 ; $450e
	ld de, $d08e ; $4510
	call Func_00_1a27 ; $4513
	ld de, $d403 ; $4516
	farcall FarPtr_1c_04 ; $4519
	ld a, $06 ; $451c
	ldh [$ff96], a ; $451e
	ldh [rWBK], a ; $4520
	push af ; $4522
	ld hl, $c900 ; $4523
	ld a, [$cb00] ; $4526
	or a, a ; $4529
	jr z, Label_1d_452e ; $452a
	ld l, $40 ; $452c
Label_1d_452e:
	ld a, l ; $452e
	add a, $3a ; $452f
	ld l, a ; $4531
	ld a, h ; $4532
	adc a, $00 ; $4533
	ld h, a ; $4535
	pop af ; $4536
	ld a, [hl] ; $4537
	ld h, $00 ; $4538
	ld l, a ; $453a
	ld a, $02 ; $453b
	ld de, $d08e ; $453d
	call Func_00_1a27 ; $4540
	ld de, $d40d ; $4543
	farcall FarPtr_1c_04 ; $4546
	ld a, $06 ; $4549
	ldh [$ff96], a ; $454b
	ldh [rWBK], a ; $454d
	push af ; $454f
	ld hl, $c900 ; $4550
	ld a, [$cb00] ; $4553
	or a, a ; $4556
	jr z, Label_1d_455b ; $4557
	ld l, $40 ; $4559
Label_1d_455b:
	ld a, l ; $455b
	add a, $3b ; $455c
	ld l, a ; $455e
	ld a, h ; $455f
	adc a, $00 ; $4560
	ld h, a ; $4562
	pop af ; $4563
	ld a, [hl] ; $4564
	ld h, $00 ; $4565
	ld l, a ; $4567
	ld a, $02 ; $4568
	ld de, $d08e ; $456a
	call Func_00_1a27 ; $456d
	ld de, $d417 ; $4570
	farcall FarPtr_1c_04 ; $4573
	call Func_1d_59be ; $4576
	ld de, $d42f ; $4579
	call Func_1d_59fc ; $457c
	ld a, $06 ; $457f
	ldh [$ff96], a ; $4581
	ldh [rWBK], a ; $4583
	xor a, a ; $4585
	farcall FarPtr_02_2c ; $4586
	ld a, $03 ; $4589
	ld de, $d08e ; $458b
	call Func_00_1a27 ; $458e
	ld hl, $d08e ; $4591
	ld de, $d12c ; $4594
	ld a, [hl+] ; $4597
	ld [de], a ; $4598
	inc de ; $4599
	ld a, [hl+] ; $459a
	ld [de], a ; $459b
	inc de ; $459c
	ld a, [hl] ; $459d
	ld [de], a ; $459e
	ld a, $06 ; $459f
	ldh [$ff96], a ; $45a1
	ldh [rWBK], a ; $45a3
	push af ; $45a5
	ld hl, $c900 ; $45a6
	ld a, [$cb00] ; $45a9
	or a, a ; $45ac
	jr z, Label_1d_45b1 ; $45ad
	ld l, $40 ; $45af
Label_1d_45b1:
	ld a, l ; $45b1
	add a, $2c ; $45b2
	ld l, a ; $45b4
	ld a, h ; $45b5
	adc a, $00 ; $45b6
	ld h, a ; $45b8
	pop af ; $45b9
	call Func_1d_480e ; $45ba
	ld hl, $d08e ; $45bd
	ld de, $d126 ; $45c0
	ld a, [hl] ; $45c3
	or a, a ; $45c4
	jr nz, Label_1d_45cf ; $45c5
	ld bc, $0006 ; $45c7
	call CopyMemoryBC ; $45ca
	jr Label_1d_45db ; $45cd
Label_1d_45cf:
	ld h, d ; $45cf
	ld l, e ; $45d0
	ld a, $20 ; $45d1
	ld [hl+], a ; $45d3
	ld a, $39 ; $45d4
	ld [hl+], a ; $45d6
	ld [hl+], a ; $45d7
	ld [hl+], a ; $45d8
	ld [hl+], a ; $45d9
	ld [hl], a ; $45da
Label_1d_45db:
	ld a, $01 ; $45db
	ld [$cb00], a ; $45dd
	push af ; $45e0
	ld hl, $c900 ; $45e1
	ld a, [$cb00] ; $45e4
	or a, a ; $45e7
	jr z, Label_1d_45ec ; $45e8
	ld l, $40 ; $45ea
Label_1d_45ec:
	ld a, l ; $45ec
	add a, $00 ; $45ed
	ld l, a ; $45ef
	ld a, h ; $45f0
	adc a, $00 ; $45f1
	ld h, a ; $45f3
	pop af ; $45f4
	ld de, $d45b ; $45f5
	ld c, $0a ; $45f8
	call Func_1d_47b0 ; $45fa
	ld a, $03 ; $45fd
	ldh [$ff96], a ; $45ff
	ldh [rWBK], a ; $4601
	ld hl, $5d91 ; $4603
	ld de, $d450 ; $4606
	ld b, $09 ; $4609
	call Func_1d_4771 ; $460b
	push af ; $460e
	ld hl, $c900 ; $460f
	ld a, [$cb00] ; $4612
	or a, a ; $4615
	jr z, Label_1d_461a ; $4616
	ld l, $40 ; $4618
Label_1d_461a:
	ld a, l ; $461a
	add a, $0e ; $461b
	ld l, a ; $461d
	ld a, h ; $461e
	adc a, $00 ; $461f
	ld h, a ; $4621
	pop af ; $4622
	ld a, [hl] ; $4623
	ld hl, $d473 ; $4624
	call Func_1d_4793 ; $4627
	ld a, $06 ; $462a
	ldh [$ff96], a ; $462c
	ldh [rWBK], a ; $462e
	push af ; $4630
	ld hl, $c900 ; $4631
	ld a, [$cb00] ; $4634
	or a, a ; $4637
	jr z, Label_1d_463c ; $4638
	ld l, $40 ; $463a
Label_1d_463c:
	ld a, l ; $463c
	add a, $18 ; $463d
	ld l, a ; $463f
	ld a, h ; $4640
	adc a, $00 ; $4641
	ld h, a ; $4643
	pop af ; $4644
	ld a, [hl] ; $4645
	ld h, $00 ; $4646
	ld l, a ; $4648
	ld a, $02 ; $4649
	ld de, $d08e ; $464b
	call Func_00_1a27 ; $464e
	ld de, $d46b ; $4651
	farcall FarPtr_1c_04 ; $4654
	ld a, $06 ; $4657
	ldh [$ff96], a ; $4659
	ldh [rWBK], a ; $465b
	push af ; $465d
	ld hl, $c900 ; $465e
	ld a, [$cb00] ; $4661
	or a, a ; $4664
	jr z, Label_1d_4669 ; $4665
	ld l, $40 ; $4667
Label_1d_4669:
	ld a, l ; $4669
	add a, $38 ; $466a
	ld l, a ; $466c
	ld a, h ; $466d
	adc a, $00 ; $466e
	ld h, a ; $4670
	pop af ; $4671
	ld a, [hl] ; $4672
	ld h, $00 ; $4673
	ld l, a ; $4675
	ld a, $02 ; $4676
	ld de, $d08e ; $4678
	call Func_00_1a27 ; $467b
	ld de, $d489 ; $467e
	farcall FarPtr_1c_04 ; $4681
	ld a, $06 ; $4684
	ldh [$ff96], a ; $4686
	ldh [rWBK], a ; $4688
	push af ; $468a
	ld hl, $c900 ; $468b
	ld a, [$cb00] ; $468e
	or a, a ; $4691
	jr z, Label_1d_4696 ; $4692
	ld l, $40 ; $4694
Label_1d_4696:
	ld a, l ; $4696
	add a, $39 ; $4697
	ld l, a ; $4699
	ld a, h ; $469a
	adc a, $00 ; $469b
	ld h, a ; $469d
	pop af ; $469e
	ld a, [hl] ; $469f
	ld h, $00 ; $46a0
	ld l, a ; $46a2
	ld a, $02 ; $46a3
	ld de, $d08e ; $46a5
	call Func_00_1a27 ; $46a8
	ld de, $d493 ; $46ab
	farcall FarPtr_1c_04 ; $46ae
	ld a, $06 ; $46b1
	ldh [$ff96], a ; $46b3
	ldh [rWBK], a ; $46b5
	push af ; $46b7
	ld hl, $c900 ; $46b8
	ld a, [$cb00] ; $46bb
	or a, a ; $46be
	jr z, Label_1d_46c3 ; $46bf
	ld l, $40 ; $46c1
Label_1d_46c3:
	ld a, l ; $46c3
	add a, $3a ; $46c4
	ld l, a ; $46c6
	ld a, h ; $46c7
	adc a, $00 ; $46c8
	ld h, a ; $46ca
	pop af ; $46cb
	ld a, [hl] ; $46cc
	ld h, $00 ; $46cd
	ld l, a ; $46cf
	ld a, $02 ; $46d0
	ld de, $d08e ; $46d2
	call Func_00_1a27 ; $46d5
	ld de, $d49d ; $46d8
	farcall FarPtr_1c_04 ; $46db
	ld a, $06 ; $46de
	ldh [$ff96], a ; $46e0
	ldh [rWBK], a ; $46e2
	push af ; $46e4
	ld hl, $c900 ; $46e5
	ld a, [$cb00] ; $46e8
	or a, a ; $46eb
	jr z, Label_1d_46f0 ; $46ec
	ld l, $40 ; $46ee
Label_1d_46f0:
	ld a, l ; $46f0
	add a, $3b ; $46f1
	ld l, a ; $46f3
	ld a, h ; $46f4
	adc a, $00 ; $46f5
	ld h, a ; $46f7
	pop af ; $46f8
	ld a, [hl] ; $46f9
	ld h, $00 ; $46fa
	ld l, a ; $46fc
	ld a, $02 ; $46fd
	ld de, $d08e ; $46ff
	call Func_00_1a27 ; $4702
	ld de, $d4a7 ; $4705
	farcall FarPtr_1c_04 ; $4708
	call Func_1d_59be ; $470b
	ld de, $d4bf ; $470e
	call Func_1d_59fc ; $4711
	ld a, $06 ; $4714
	ldh [$ff96], a ; $4716
	ldh [rWBK], a ; $4718
	ld a, $01 ; $471a
	farcall FarPtr_02_2c ; $471c
	ld a, $03 ; $471f
	ld de, $d08e ; $4721
	call Func_00_1a27 ; $4724
	ld hl, $d08e ; $4727
	ld de, $d139 ; $472a
	ld a, [hl+] ; $472d
	ld [de], a ; $472e
	inc de ; $472f
	ld a, [hl+] ; $4730
	ld [de], a ; $4731
	inc de ; $4732
	ld a, [hl] ; $4733
	ld [de], a ; $4734
	ld a, $06 ; $4735
	ldh [$ff96], a ; $4737
	ldh [rWBK], a ; $4739
	push af ; $473b
	ld hl, $c900 ; $473c
	ld a, [$cb00] ; $473f
	or a, a ; $4742
	jr z, Label_1d_4747 ; $4743
	ld l, $40 ; $4745
Label_1d_4747:
	ld a, l ; $4747
	add a, $2c ; $4748
	ld l, a ; $474a
	ld a, h ; $474b
	adc a, $00 ; $474c
	ld h, a ; $474e
	pop af ; $474f
	call Func_1d_480e ; $4750
	ld hl, $d08e ; $4753
	ld de, $d133 ; $4756
	ld a, [hl] ; $4759
	or a, a ; $475a
	jr nz, Label_1d_4764 ; $475b
	ld bc, $0006 ; $475d
	call CopyMemoryBC ; $4760
	ret ; $4763
Label_1d_4764:
	ld h, d ; $4764
	ld l, e ; $4765
	ld a, $20 ; $4766
	ld [hl+], a ; $4768
	ld a, $39 ; $4769
	ld [hl+], a ; $476b
	ld [hl+], a ; $476c
	ld [hl+], a ; $476d
	ld [hl+], a ; $476e
	ld [hl], a ; $476f
	ret ; $4770
Func_1d_4771:
	push de ; $4771
	ld a, [hl+] ; $4772
	cp a, $ff ; $4773
	jr z, Label_1d_4791 ; $4775
	add a, e ; $4777
	ld e, a ; $4778
	jr nc, Label_1d_477c ; $4779
	inc d ; $477b
Label_1d_477c:
	ld a, [hl+] ; $477c
	ld c, a ; $477d
	ld a, $03 ; $477e
	ldh [$ff96], a ; $4780
	ldh [rWBK], a ; $4782
	ld a, c ; $4784
	ld [de], a ; $4785
	ld a, $02 ; $4786
	ldh [$ff96], a ; $4788
	ldh [rWBK], a ; $478a
	ld a, b ; $478c
	ld [de], a ; $478d
	pop de ; $478e
	jr Func_1d_4771 ; $478f
Label_1d_4791:
	pop de ; $4791
	ret ; $4792
Func_1d_4793:
	or a, a ; $4793
	jr nz, Label_1d_47a0 ; $4794
	ld a, $03 ; $4796
	ldh [$ff96], a ; $4798
	ldh [rWBK], a ; $479a
	ld a, $01 ; $479c
	jr Label_1d_47a8 ; $479e
Label_1d_47a0:
	ld a, $03 ; $47a0
	ldh [$ff96], a ; $47a2
	ldh [rWBK], a ; $47a4
	ld a, $05 ; $47a6
Label_1d_47a8:
	ld [hl+], a ; $47a8
	inc a ; $47a9
	ld [hl+], a ; $47aa
	inc a ; $47ab
	ld [hl+], a ; $47ac
	inc a ; $47ad
	ld [hl], a ; $47ae
	ret ; $47af
Func_1d_47b0:
	ld a, [hl+] ; $47b0
	or a, a ; $47b1
	ret z ; $47b2
	cp a, $de ; $47b3
	jr z, Label_1d_47cf ; $47b5
	cp a, $df ; $47b7
	jr z, Label_1d_47cf ; $47b9
	ld b, a ; $47bb
	ld a, $03 ; $47bc
	ldh [$ff96], a ; $47be
	ldh [rWBK], a ; $47c0
	ld a, b ; $47c2
	ld [de], a ; $47c3
	ld a, $02 ; $47c4
	ldh [$ff96], a ; $47c6
	ldh [rWBK], a ; $47c8
	xor a, a ; $47ca
	ld [de], a ; $47cb
	inc de ; $47cc
	jr Func_1d_47b0 ; $47cd
Label_1d_47cf:
	call Func_1d_47fe ; $47cf
	ld b, a ; $47d2
	ld a, $03 ; $47d3
	ldh [$ff96], a ; $47d5
	ldh [rWBK], a ; $47d7
	ld a, [de] ; $47d9
	or a, a ; $47da
	jr z, Label_1d_47ef ; $47db
	ld a, b ; $47dd
	sub a, $30 ; $47de
	ld [de], a ; $47e0
	ld a, $02 ; $47e1
	ldh [$ff96], a ; $47e3
	ldh [rWBK], a ; $47e5
	ld a, $08 ; $47e7
	ld [de], a ; $47e9
	call Func_1d_4806 ; $47ea
	jr Func_1d_47b0 ; $47ed
Label_1d_47ef:
	ld a, b ; $47ef
	ld [de], a ; $47f0
	ld a, $02 ; $47f1
	ldh [$ff96], a ; $47f3
	ldh [rWBK], a ; $47f5
	xor a, a ; $47f7
	ld [de], a ; $47f8
	call Func_1d_4806 ; $47f9
	jr Func_1d_47b0 ; $47fc
Func_1d_47fe:
	push bc ; $47fe
Label_1d_47ff:
	dec de ; $47ff
	dec c ; $4800
	jr nz, Label_1d_47ff ; $4801
	dec de ; $4803
	pop bc ; $4804
	ret ; $4805
Func_1d_4806:
	ld a, c ; $4806
	inc a ; $4807
	add a, e ; $4808
	ld e, a ; $4809
	jr nc, Label_1d_480d ; $480a
	inc d ; $480c
Label_1d_480d:
	ret ; $480d
Func_1d_480e:
	ld a, $06 ; $480e
	ldh [$ff96], a ; $4810
	ldh [rWBK], a ; $4812
	ld a, [hl+] ; $4814
	ld b, [hl] ; $4815
	ld c, a ; $4816
	inc hl ; $4817
	ld a, [hl] ; $4818
	ld [$d08e], a ; $4819
	ld h, b ; $481c
	ld l, c ; $481d
	ld de, $d08f ; $481e
	ld a, $05 ; $4821
	call Func_00_1a27 ; $4823
	ld hl, $d08e ; $4826
	ld a, [hl] ; $4829
	and a, a ; $482a
	ret z ; $482b
	ld c, a ; $482c
Label_1d_482d:
	ld de, $d093 ; $482d
	ld a, [de] ; $4830
	sub a, $20 ; $4831
	jr z, Label_1d_4837 ; $4833
	sub a, $10 ; $4835
Label_1d_4837:
	add a, $06 ; $4837
	cp a, $0a ; $4839
	jr c, Label_1d_4844 ; $483b
	sub a, $0a ; $483d
	ld b, a ; $483f
	ld a, $01 ; $4840
	ld [hl], a ; $4842
	ld a, b ; $4843
Label_1d_4844:
	add a, $30 ; $4844
	ld [de], a ; $4846
	ld de, $d092 ; $4847
	ld a, [de] ; $484a
	add a, [hl] ; $484b
	ld b, a ; $484c
	xor a, a ; $484d
	ld [hl], a ; $484e
	ld a, b ; $484f
	sub a, $20 ; $4850
	jr z, Label_1d_4856 ; $4852
	sub a, $10 ; $4854
Label_1d_4856:
	add a, $03 ; $4856
	cp a, $0a ; $4858
	jr c, Label_1d_4863 ; $485a
	sub a, $0a ; $485c
	ld b, a ; $485e
	ld a, $01 ; $485f
	ld [hl], a ; $4861
	ld a, b ; $4862
Label_1d_4863:
	add a, $30 ; $4863
	ld [de], a ; $4865
	ld de, $d091 ; $4866
	ld a, [de] ; $4869
	add a, [hl] ; $486a
	ld b, a ; $486b
	xor a, a ; $486c
	ld [hl], a ; $486d
	ld a, b ; $486e
	sub a, $20 ; $486f
	jr z, Label_1d_4875 ; $4871
	sub a, $10 ; $4873
Label_1d_4875:
	add a, $05 ; $4875
	cp a, $0a ; $4877
	jr c, Label_1d_4882 ; $4879
	sub a, $0a ; $487b
	ld b, a ; $487d
	ld a, $01 ; $487e
	ld [hl], a ; $4880
	ld a, b ; $4881
Label_1d_4882:
	add a, $30 ; $4882
	ld [de], a ; $4884
	ld de, $d090 ; $4885
	ld a, [de] ; $4888
	add a, [hl] ; $4889
	ld b, a ; $488a
	xor a, a ; $488b
	ld [hl], a ; $488c
	ld a, b ; $488d
	sub a, $20 ; $488e
	jr z, Label_1d_4894 ; $4890
	sub a, $10 ; $4892
Label_1d_4894:
	add a, $05 ; $4894
	cp a, $0a ; $4896
	jr c, Label_1d_48a1 ; $4898
	sub a, $0a ; $489a
	ld b, a ; $489c
	ld a, $01 ; $489d
	ld [hl], a ; $489f
	ld a, b ; $48a0
Label_1d_48a1:
	add a, $30 ; $48a1
	ld [de], a ; $48a3
	ld de, $d08f ; $48a4
	ld a, [de] ; $48a7
	add a, [hl] ; $48a8
	ld b, a ; $48a9
	xor a, a ; $48aa
	ld [hl], a ; $48ab
	ld a, b ; $48ac
	sub a, $20 ; $48ad
	jr z, Label_1d_48b3 ; $48af
	sub a, $10 ; $48b1
Label_1d_48b3:
	add a, $05 ; $48b3
	ld hl, $d08e ; $48b5
	add a, [hl] ; $48b8
	cp a, $0a ; $48b9
	jr c, Label_1d_48bf ; $48bb
	ld a, $09 ; $48bd
Label_1d_48bf:
	add a, $30 ; $48bf
	ld [de], a ; $48c1
	dec c ; $48c2
	jp nz, Label_1d_482d ; $48c3
	ret ; $48c6
	ld a, $06 ; $48c7
	ldh [$ff96], a ; $48c9
	ldh [rWBK], a ; $48cb
	ld a, [$d149] ; $48cd
	or a, a ; $48d0
	jr nz, Label_1d_48d8 ; $48d1
	ld hl, $c890 ; $48d3
	jr Label_1d_48db ; $48d6
Label_1d_48d8:
	ld hl, $c0f2 ; $48d8
Label_1d_48db:
	ld de, $d14c ; $48db
	ld a, [hl+] ; $48de
	ld [de], a ; $48df
	inc de ; $48e0
	ld a, [hl] ; $48e1
	ld [de], a ; $48e2
	ld a, [$d14d] ; $48e3
	ld h, $00 ; $48e6
	ld l, a ; $48e8
	ld a, $02 ; $48e9
	ld de, $d08e ; $48eb
	call Func_00_1a27 ; $48ee
	ld a, [$d08e] ; $48f1
	cp a, $20 ; $48f4
	jr z, Label_1d_4907 ; $48f6
	call Func_1d_59b5 ; $48f8
	ld de, $5d88 ; $48fb
	ld hl, $d147 ; $48fe
	call Func_1d_5997 ; $4901
	call Func_00_1f51 ; $4904
Label_1d_4907:
	ld a, [$d08f] ; $4907
	call Func_1d_59b5 ; $490a
	ld de, $6588 ; $490d
	ld hl, $d147 ; $4910
	call Func_1d_5997 ; $4913
	call Func_00_1f51 ; $4916
	ld a, [$d14c] ; $4919
	ld h, $00 ; $491c
	ld l, a ; $491e
	ld a, $02 ; $491f
	ld de, $d08e ; $4921
	call Func_00_1a27 ; $4924
	ld a, [$d08e] ; $4927
	cp a, $20 ; $492a
	jr z, Label_1d_4930 ; $492c
	jr Label_1d_4932 ; $492e
Label_1d_4930:
	ld a, $30 ; $4930
Label_1d_4932:
	call Func_1d_59b5 ; $4932
	ld de, $7488 ; $4935
	ld hl, $d147 ; $4938
	call Func_1d_5997 ; $493b
	call Func_00_1f51 ; $493e
	ld a, [$d08f] ; $4941
	call Func_1d_59b5 ; $4944
	ld de, $7c88 ; $4947
	ld hl, $d147 ; $494a
	call Func_1d_5997 ; $494d
	call Func_00_1f51 ; $4950
	ld a, $06 ; $4953
	ldh [$ff96], a ; $4955
	ldh [rWBK], a ; $4957
	ld a, [$d12c] ; $4959
	cp a, $20 ; $495c
	jr z, Label_1d_496f ; $495e
	call Func_1d_4a0b ; $4960
	ld de, $0864 ; $4963
	ld hl, $d147 ; $4966
	call Func_1d_5997 ; $4969
	call Func_00_1f51 ; $496c
Label_1d_496f:
	ld a, [$d12d] ; $496f
	cp a, $20 ; $4972
	jr z, Label_1d_4985 ; $4974
	call Func_1d_4a0b ; $4976
	ld de, $0d64 ; $4979
	ld hl, $d147 ; $497c
	call Func_1d_5997 ; $497f
	call Func_00_1f51 ; $4982
Label_1d_4985:
	ld a, [$d12e] ; $4985
	cp a, $20 ; $4988
	jr z, Label_1d_499b ; $498a
	call Func_1d_4a0b ; $498c
	ld de, $1264 ; $498f
	ld hl, $d147 ; $4992
	call Func_1d_5997 ; $4995
	call Func_00_1f51 ; $4998
Label_1d_499b:
	ld a, [$d139] ; $499b
	cp a, $20 ; $499e
	jr z, Label_1d_49b1 ; $49a0
	call Func_1d_4a0b ; $49a2
	ld de, $5864 ; $49a5
	ld hl, $d147 ; $49a8
	call Func_1d_5997 ; $49ab
	call Func_00_1f51 ; $49ae
Label_1d_49b1:
	ld a, [$d13a] ; $49b1
	cp a, $20 ; $49b4
	jr z, Label_1d_49c7 ; $49b6
	call Func_1d_4a0b ; $49b8
	ld de, $5d64 ; $49bb
	ld hl, $d147 ; $49be
	call Func_1d_5997 ; $49c1
	call Func_00_1f51 ; $49c4
Label_1d_49c7:
	ld a, [$d13b] ; $49c7
	cp a, $20 ; $49ca
	jr z, Label_1d_49dd ; $49cc
	call Func_1d_4a0b ; $49ce
	ld de, $6264 ; $49d1
	ld hl, $d147 ; $49d4
	call Func_1d_5997 ; $49d7
	call Func_00_1f51 ; $49da
Label_1d_49dd:
	ld a, [wEquippedRacket] ; $49dd
	push af ; $49e0
	and a, $0f ; $49e1
	jr z, Label_1d_49f5 ; $49e3
	ld b, $0e ; $49e5
	ld c, $d6 ; $49e7
	ld de, $303c ; $49e9
	ld hl, $d147 ; $49ec
	call Func_1d_5997 ; $49ef
	call Func_00_1f51 ; $49f2
Label_1d_49f5:
	pop af ; $49f5
	and a, $f0 ; $49f6
	jr z, Label_1d_4a0a ; $49f8
	ld b, $0e ; $49fa
	ld c, $d8 ; $49fc
	ld de, $383c ; $49fe
	ld hl, $d147 ; $4a01
	call Func_1d_5997 ; $4a04
	call Func_00_1f51 ; $4a07
Label_1d_4a0a:
	ret ; $4a0a
Func_1d_4a0b:
	sub a, $30 ; $4a0b
	rlca ; $4a0d
	add a, $4c ; $4a0e
	ld c, a ; $4a10
	ld b, $08 ; $4a11
	ret ; $4a13
Func_1d_4a14:
	or a, a ; $4a14
	jr z, Label_1d_4a86 ; $4a15
	dec a ; $4a17
	jr z, Label_1d_4a63 ; $4a18
	dec a ; $4a1a
	jr z, Label_1d_4a40 ; $4a1b
	ld a, $03 ; $4a1d
	ldh [$ff96], a ; $4a1f
	ldh [rWBK], a ; $4a21
	ld hl, $d000 ; $4a23
	ld de, $dc60 ; $4a26
	ld c, $24 ; $4a29
	call CopyMemoryFast ; $4a2b
	ld a, $02 ; $4a2e
	ldh [$ff96], a ; $4a30
	ldh [rWBK], a ; $4a32
	ld hl, $d000 ; $4a34
	ld de, $dc60 ; $4a37
	ld c, $24 ; $4a3a
	call CopyMemoryFast ; $4a3c
	ret ; $4a3f
Label_1d_4a40:
	ld a, $03 ; $4a40
	ldh [$ff96], a ; $4a42
	ldh [rWBK], a ; $4a44
	ld hl, $d000 ; $4a46
	ld de, $da20 ; $4a49
	ld c, $24 ; $4a4c
	call CopyMemoryFast ; $4a4e
	ld a, $02 ; $4a51
	ldh [$ff96], a ; $4a53
	ldh [rWBK], a ; $4a55
	ld hl, $d000 ; $4a57
	ld de, $da20 ; $4a5a
	ld c, $24 ; $4a5d
	call CopyMemoryFast ; $4a5f
	ret ; $4a62
Label_1d_4a63:
	ld a, $03 ; $4a63
	ldh [$ff96], a ; $4a65
	ldh [rWBK], a ; $4a67
	ld hl, $d000 ; $4a69
	ld de, $d7e0 ; $4a6c
	ld c, $24 ; $4a6f
	call CopyMemoryFast ; $4a71
	ld a, $02 ; $4a74
	ldh [$ff96], a ; $4a76
	ldh [rWBK], a ; $4a78
	ld hl, $d000 ; $4a7a
	ld de, $d7e0 ; $4a7d
	ld c, $24 ; $4a80
	call CopyMemoryFast ; $4a82
	ret ; $4a85
Label_1d_4a86:
	ld a, $03 ; $4a86
	ldh [$ff96], a ; $4a88
	ldh [rWBK], a ; $4a8a
	ld hl, $d000 ; $4a8c
	ld de, $d5a0 ; $4a8f
	ld c, $24 ; $4a92
	call CopyMemoryFast ; $4a94
	ld a, $02 ; $4a97
	ldh [$ff96], a ; $4a99
	ldh [rWBK], a ; $4a9b
	ld hl, $d000 ; $4a9d
	ld de, $d5a0 ; $4aa0
	ld c, $24 ; $4aa3
	call CopyMemoryFast ; $4aa5
	ret ; $4aa8
Func_1d_4aa9:
	ld a, $03 ; $4aa9
	ldh [$ff96], a ; $4aab
	ldh [rWBK], a ; $4aad
	ld hl, $d5a0 ; $4aaf
	ld de, $d000 ; $4ab2
	ld c, $24 ; $4ab5
	call CopyMemoryFast ; $4ab7
	ld a, $02 ; $4aba
	ldh [$ff96], a ; $4abc
	ldh [rWBK], a ; $4abe
	ld hl, $d5a0 ; $4ac0
	ld de, $d000 ; $4ac3
	ld c, $24 ; $4ac6
	call CopyMemoryFast ; $4ac8
	ret ; $4acb
Func_1d_4acc:
	call Func_1d_444d ; $4acc
	ld hl, $5c33 ; $4acf
	ld bc, $d3c0 ; $4ad2
	call Func_1d_4bb6 ; $4ad5
	ld hl, $5c68 ; $4ad8
	ld bc, $d450 ; $4adb
	call Func_1d_4bb6 ; $4ade
	ld hl, $5c9d ; $4ae1
	ld bc, $d4e0 ; $4ae4
	call Func_1d_4bb6 ; $4ae7
	ret ; $4aea
Func_1d_4aeb:
	xor a, a ; $4aeb
	ld [$cb00], a ; $4aec
	call Func_1d_4e8d ; $4aef
	ld a, $06 ; $4af2
	ldh [$ff96], a ; $4af4
	ldh [rWBK], a ; $4af6
	ld a, [$d00a] ; $4af8
	ld [$d122], a ; $4afb
	ld a, [$d00b] ; $4afe
	ld [$d123], a ; $4b01
	ld a, [$d00c] ; $4b04
	ld [$d124], a ; $4b07
	ld a, [$d00d] ; $4b0a
	ld [$d125], a ; $4b0d
	ld hl, $5da4 ; $4b10
	ld bc, $d370 ; $4b13
	call Func_1d_4bb6 ; $4b16
	ld hl, $5dcb ; $4b19
	ld bc, $d500 ; $4b1c
	call Func_1d_4bb6 ; $4b1f
	ld hl, $5ca6 ; $4b22
	ld bc, $d240 ; $4b25
	call Func_1d_4bb6 ; $4b28
	ld hl, $5cd0 ; $4b2b
	ld bc, $d280 ; $4b2e
	call Func_1d_4bb6 ; $4b31
	ld hl, $5d0a ; $4b34
	ld bc, $d2d0 ; $4b37
	call Func_1d_4bb6 ; $4b3a
	ld hl, $5d34 ; $4b3d
	ld bc, $d310 ; $4b40
	call Func_1d_4bb6 ; $4b43
	ld hl, $5de5 ; $4b46
	ld bc, $d530 ; $4b49
	call Func_1d_4bb6 ; $4b4c
	ret ; $4b4f
Func_1d_4b50:
	ld a, $01 ; $4b50
	ld [$cb00], a ; $4b52
	call Func_1d_4e8d ; $4b55
	ld a, $06 ; $4b58
	ldh [$ff96], a ; $4b5a
	ldh [rWBK], a ; $4b5c
	ld a, [$d00a] ; $4b5e
	ld [$d12f], a ; $4b61
	ld a, [$d00b] ; $4b64
	ld [$d130], a ; $4b67
	ld a, [$d00c] ; $4b6a
	ld [$d131], a ; $4b6d
	ld a, [$d00d] ; $4b70
	ld [$d132], a ; $4b73
	ld hl, $5dd8 ; $4b76
	ld bc, $d500 ; $4b79
	call Func_1d_4bb6 ; $4b7c
	ld hl, $5db1 ; $4b7f
	ld bc, $d380 ; $4b82
	call Func_1d_4bb6 ; $4b85
	ld hl, $5ca6 ; $4b88
	ld bc, $d240 ; $4b8b
	call Func_1d_4bb6 ; $4b8e
	ld hl, $5cd0 ; $4b91
	ld bc, $d280 ; $4b94
	call Func_1d_4bb6 ; $4b97
	ld hl, $5d0a ; $4b9a
	ld bc, $d2d0 ; $4b9d
	call Func_1d_4bb6 ; $4ba0
	ld hl, $5d34 ; $4ba3
	ld bc, $d310 ; $4ba6
	call Func_1d_4bb6 ; $4ba9
	ld hl, $5de5 ; $4bac
	ld bc, $d530 ; $4baf
	call Func_1d_4bb6 ; $4bb2
	ret ; $4bb5
Func_1d_4bb6:
	ld a, [hl] ; $4bb6
	cp a, $ff ; $4bb7
	ret z ; $4bb9
	push hl ; $4bba
	ld d, [hl] ; $4bbb
	inc hl ; $4bbc
	ld e, [hl] ; $4bbd
	push hl ; $4bbe
	ld hl, $d000 ; $4bbf
	add hl, de ; $4bc2
	ld d, h ; $4bc3
	ld e, l ; $4bc4
	pop hl ; $4bc5
	inc hl ; $4bc6
	push hl ; $4bc7
	ld a, [hl] ; $4bc8
	ld h, b ; $4bc9
	ld l, c ; $4bca
	add a, l ; $4bcb
	ld l, a ; $4bcc
	jr nc, Label_1d_4bd0 ; $4bcd
	inc h ; $4bcf
Label_1d_4bd0:
	ld a, $06 ; $4bd0
	ldh [$ff96], a ; $4bd2
	ldh [rWBK], a ; $4bd4
	ld a, l ; $4bd6
	ld [$d08e], a ; $4bd7
	ld a, h ; $4bda
	ld [$d08f], a ; $4bdb
	pop hl ; $4bde
	push bc ; $4bdf
	inc hl ; $4be0
	ld c, [hl] ; $4be1
	ld hl, $d08e ; $4be2
	ld a, [hl+] ; $4be5
	ld h, [hl] ; $4be6
	ld l, a ; $4be7
Label_1d_4be8:
	ld a, $03 ; $4be8
	ldh [$ff96], a ; $4bea
	ldh [rWBK], a ; $4bec
	ld a, [hl] ; $4bee
	ld [de], a ; $4bef
	ld a, $02 ; $4bf0
	ldh [$ff96], a ; $4bf2
	ldh [rWBK], a ; $4bf4
	ld a, [hl+] ; $4bf6
	ld [de], a ; $4bf7
	inc de ; $4bf8
	dec c ; $4bf9
	jr nz, Label_1d_4be8 ; $4bfa
	pop bc ; $4bfc
	pop hl ; $4bfd
	inc hl ; $4bfe
	inc hl ; $4bff
	inc hl ; $4c00
	inc hl ; $4c01
	jr Func_1d_4bb6 ; $4c02
	ld a, $06 ; $4c04
	ldh [$ff96], a ; $4c06
	ldh [rWBK], a ; $4c08
	ld a, [$d143] ; $4c0a
	or a, a ; $4c0d
	jr nz, Label_1d_4c14 ; $4c0e
	ld hl, $d144 ; $4c10
	inc [hl] ; $4c13
Label_1d_4c14:
	ld a, [$d142] ; $4c14
	or a, a ; $4c17
	jr z, Label_1d_4c3f ; $4c18
	dec a ; $4c1a
	jr z, Label_1d_4c2e ; $4c1b
	ld de, $0103 ; $4c1d
	call Func_1d_4c60 ; $4c20
	ld hl, $679a ; $4c23
	ld b, $0e ; $4c26
	ld c, $28 ; $4c28
	call Func_00_1e9d ; $4c2a
	ret ; $4c2d
Label_1d_4c2e:
	ld de, $7f03 ; $4c2e
	call Func_1d_4c80 ; $4c31
	ld hl, $681b ; $4c34
	ld b, $0e ; $4c37
	ld c, $30 ; $4c39
	call Func_00_1e9d ; $4c3b
	ret ; $4c3e
Label_1d_4c3f:
	ld de, $1010 ; $4c3f
	call Func_1d_4c60 ; $4c42
	ld hl, $666a ; $4c45
	ld b, $0e ; $4c48
	ld c, $14 ; $4c4a
	call Func_00_1e9d ; $4c4c
	ld de, $6810 ; $4c4f
	call Func_1d_4c80 ; $4c52
	ld hl, $670c ; $4c55
	ld b, $0e ; $4c58
	ld c, $1e ; $4c5a
	call Func_00_1e9d ; $4c5c
	ret ; $4c5f
Func_1d_4c60:
	ld a, $06 ; $4c60
	ldh [$ff96], a ; $4c62
	ldh [rWBK], a ; $4c64
	ld a, [$d144] ; $4c66
	rrca ; $4c69
	and a, $0f ; $4c6a
	add a, $9c ; $4c6c
	ld l, a ; $4c6e
	adc a, $4c ; $4c6f
	sub a, l ; $4c71
	ld h, a ; $4c72
	ld a, [hl] ; $4c73
	cpl ; $4c74
	inc a ; $4c75
	add a, d ; $4c76
	ld d, a ; $4c77
	ld a, [$d143] ; $4c78
	cpl ; $4c7b
	inc a ; $4c7c
	add a, d ; $4c7d
	ld d, a ; $4c7e
	ret ; $4c7f
Func_1d_4c80:
	ld a, $06 ; $4c80
	ldh [$ff96], a ; $4c82
	ldh [rWBK], a ; $4c84
	ld a, [$d144] ; $4c86
	rrca ; $4c89
	and a, $0f ; $4c8a
	add a, $9c ; $4c8c
	ld l, a ; $4c8e
	adc a, $4c ; $4c8f
	sub a, l ; $4c91
	ld h, a ; $4c92
	ld a, [hl] ; $4c93
	add a, d ; $4c94
	ld d, a ; $4c95
	ld a, [$d143] ; $4c96
	add a, d ; $4c99
	ld d, a ; $4c9a
	ret ; $4c9b
	INCBIN "data/bank_01d/d_4c9c.bin" ; $4c9c, 16 bytes
Func_1d_4cac:
	ld a, $06 ; $4cac
	ldh [$ff96], a ; $4cae
	ldh [rWBK], a ; $4cb0
	ld a, [$d142] ; $4cb2
	or a, a ; $4cb5
	jr z, Label_1d_4cbf ; $4cb6
	dec a ; $4cb8
	jp z, Label_1d_4da0 ; $4cb9
	jp Label_1d_4dff ; $4cbc
Label_1d_4cbf:
	call Func_00_2631 ; $4cbf
	ldh a, [$ff94] ; $4cc2
	bit 4, a ; $4cc4
	jr nz, Label_1d_4cd9 ; $4cc6
	bit 5, a ; $4cc8
	jp nz, Label_1d_4d3a ; $4cca
	bit 1, a ; $4ccd
	jp nz, Label_1d_4d9a ; $4ccf
	bit 0, a ; $4cd2
	jp nz, Label_1d_4d9d ; $4cd4
	jr Label_1d_4cbf ; $4cd7
Label_1d_4cd9:
	sound $5e ; $4cd9
	ld hl, $40cc ; $4cdb
	call Func_00_1bcb ; $4cde
	ld hl, $4e76 ; $4ce1
	call Func_00_1bcb ; $4ce4
	ld a, $01 ; $4ce7
	ld hl, $4e5e ; $4ce9
	call Func_00_1b6a ; $4cec
	ld a, $01 ; $4cef
	ld hl, $57d2 ; $4cf1
	call Func_00_1b6a ; $4cf4
	ld a, $06 ; $4cf7
	ldh [$ff96], a ; $4cf9
	ldh [rWBK], a ; $4cfb
	ld a, [$d12f] ; $4cfd
	ld [$d00a], a ; $4d00
	ld a, [$d130] ; $4d03
	ld [$d00b], a ; $4d06
	ld a, [$d131] ; $4d09
	ld [$d00c], a ; $4d0c
	ld a, [$d132] ; $4d0f
	ld [$d00d], a ; $4d12
	ld hl, $d133 ; $4d15
	ld de, $d13c ; $4d18
	ld bc, $0006 ; $4d1b
	call CopyMemoryBC ; $4d1e
	call Func_1d_543d ; $4d21
	ld a, $06 ; $4d24
	ldh [$ff96], a ; $4d26
	ldh [rWBK], a ; $4d28
	ld a, $02 ; $4d2a
	ld [$d142], a ; $4d2c
	ld a, $01 ; $4d2f
	ld hl, $4e76 ; $4d31
	call Func_00_1b6a ; $4d34
	jp Label_1d_4dff ; $4d37
Label_1d_4d3a:
	sound $5e ; $4d3a
	ld hl, $40cc ; $4d3c
	call Func_00_1bcb ; $4d3f
	ld hl, $4e76 ; $4d42
	call Func_00_1bcb ; $4d45
	ld a, $01 ; $4d48
	ld hl, $4e5e ; $4d4a
	call Func_00_1b6a ; $4d4d
	ld a, $01 ; $4d50
	ld hl, $57d2 ; $4d52
	call Func_00_1b6a ; $4d55
	ld a, $06 ; $4d58
	ldh [$ff96], a ; $4d5a
	ldh [rWBK], a ; $4d5c
	ld a, [$d122] ; $4d5e
	ld [$d00a], a ; $4d61
	ld a, [$d123] ; $4d64
	ld [$d00b], a ; $4d67
	ld a, [$d124] ; $4d6a
	ld [$d00c], a ; $4d6d
	ld a, [$d125] ; $4d70
	ld [$d00d], a ; $4d73
	ld hl, $d126 ; $4d76
	ld de, $d13c ; $4d79
	ld bc, $0006 ; $4d7c
	call CopyMemoryBC ; $4d7f
	call Func_1d_509c ; $4d82
	ld a, $06 ; $4d85
	ldh [$ff96], a ; $4d87
	ldh [rWBK], a ; $4d89
	ld a, $01 ; $4d8b
	ld [$d142], a ; $4d8d
	ld a, $01 ; $4d90
	ld hl, $4e76 ; $4d92
	call Func_00_1b6a ; $4d95
	jr Label_1d_4da0 ; $4d98
Label_1d_4d9a:
	sound $62 ; $4d9a
	ret ; $4d9c
Label_1d_4d9d:
	sound $5f ; $4d9d
	ret ; $4d9f
Label_1d_4da0:
	call Func_00_2631 ; $4da0
	ldh a, [$ff94] ; $4da3
	bit 4, a ; $4da5
	jr nz, Label_1d_4db3 ; $4da7
	bit 1, a ; $4da9
	jr nz, Label_1d_4df9 ; $4dab
	bit 0, a ; $4dad
	jr nz, Label_1d_4dfc ; $4daf
	jr Label_1d_4da0 ; $4db1
Label_1d_4db3:
	sound $5e ; $4db3
	ld hl, $4e76 ; $4db5
	call Func_00_1bcb ; $4db8
	ld a, $01 ; $4dbb
	ld hl, $4e5e ; $4dbd
	call Func_00_1b6a ; $4dc0
	call Func_1d_5268 ; $4dc3
	ld a, $06 ; $4dc6
	ldh [$ff96], a ; $4dc8
	ldh [rWBK], a ; $4dca
	xor a, a ; $4dcc
	ld [$d142], a ; $4dcd
	call Func_00_1b38 ; $4dd0
	ld a, $01 ; $4dd3
	ld hl, $40cc ; $4dd5
	call Func_00_1b6a ; $4dd8
	ld a, $01 ; $4ddb
	ld hl, $4e76 ; $4ddd
	call Func_00_1b6a ; $4de0
	ld a, $01 ; $4de3
	ld hl, $4c04 ; $4de5
	call Func_00_1b6a ; $4de8
	ld a, $01 ; $4deb
	ld hl, $48c7 ; $4ded
	call Func_00_1b6a ; $4df0
	farcall FarPtr_1c_12 ; $4df3
	jp Label_1d_4cbf ; $4df6
Label_1d_4df9:
	sound $62 ; $4df9
	ret ; $4dfb
Label_1d_4dfc:
	sound $5f ; $4dfc
	ret ; $4dfe
Label_1d_4dff:
	call Func_00_2631 ; $4dff
	ldh a, [$ff94] ; $4e02
	bit 5, a ; $4e04
	jr nz, Label_1d_4e12 ; $4e06
	bit 1, a ; $4e08
	jr nz, Label_1d_4e58 ; $4e0a
	bit 0, a ; $4e0c
	jr nz, Label_1d_4e5b ; $4e0e
	jr Label_1d_4dff ; $4e10
Label_1d_4e12:
	sound $5e ; $4e12
	ld hl, $4e76 ; $4e14
	call Func_00_1bcb ; $4e17
	ld a, $01 ; $4e1a
	ld hl, $4e5e ; $4e1c
	call Func_00_1b6a ; $4e1f
	call Func_1d_5603 ; $4e22
	ld a, $06 ; $4e25
	ldh [$ff96], a ; $4e27
	ldh [rWBK], a ; $4e29
	xor a, a ; $4e2b
	ld [$d142], a ; $4e2c
	call Func_00_1b38 ; $4e2f
	ld a, $01 ; $4e32
	ld hl, $40cc ; $4e34
	call Func_00_1b6a ; $4e37
	ld a, $01 ; $4e3a
	ld hl, $4e76 ; $4e3c
	call Func_00_1b6a ; $4e3f
	ld a, $01 ; $4e42
	ld hl, $4c04 ; $4e44
	call Func_00_1b6a ; $4e47
	ld a, $01 ; $4e4a
	ld hl, $48c7 ; $4e4c
	call Func_00_1b6a ; $4e4f
	farcall FarPtr_1c_12 ; $4e52
	jp Label_1d_4cbf ; $4e55
Label_1d_4e58:
	sound $62 ; $4e58
	ret ; $4e5a
Label_1d_4e5b:
	sound $5f ; $4e5b
	ret ; $4e5d
	INCBIN "data/bank_01d/d_4e5e.bin" ; $4e5e, 47 bytes
Func_1d_4e8d:
	ld a, $06 ; $4e8d
	ldh [$ff96], a ; $4e8f
	ldh [rWBK], a ; $4e91
	push af ; $4e93
	ld hl, $c900 ; $4e94
	ld a, [$cb00] ; $4e97
	or a, a ; $4e9a
	jr z, Label_1d_4e9f ; $4e9b
	ld l, $40 ; $4e9d
Label_1d_4e9f:
	ld a, l ; $4e9f
	add a, $38 ; $4ea0
	ld l, a ; $4ea2
	ld a, h ; $4ea3
	adc a, $00 ; $4ea4
	ld h, a ; $4ea6
	pop af ; $4ea7
	ld a, [hl] ; $4ea8
	ld [$d00a], a ; $4ea9
	push af ; $4eac
	ld hl, $c900 ; $4ead
	ld a, [$cb00] ; $4eb0
	or a, a ; $4eb3
	jr z, Label_1d_4eb8 ; $4eb4
	ld l, $40 ; $4eb6
Label_1d_4eb8:
	ld a, l ; $4eb8
	add a, $20 ; $4eb9
	ld l, a ; $4ebb
	ld a, h ; $4ebc
	adc a, $00 ; $4ebd
	ld h, a ; $4ebf
	pop af ; $4ec0
	ld a, [hl] ; $4ec1
	inc a ; $4ec2
	ld [$d00e], a ; $4ec3
	push af ; $4ec6
	ld hl, $c900 ; $4ec7
	ld a, [$cb00] ; $4eca
	or a, a ; $4ecd
	jr z, Label_1d_4ed2 ; $4ece
	ld l, $40 ; $4ed0
Label_1d_4ed2:
	ld a, l ; $4ed2
	add a, $21 ; $4ed3
	ld l, a ; $4ed5
	ld a, h ; $4ed6
	adc a, $00 ; $4ed7
	ld h, a ; $4ed9
	pop af ; $4eda
	ld a, [hl] ; $4edb
	inc a ; $4edc
	ld [$d00f], a ; $4edd
	push af ; $4ee0
	ld hl, $c900 ; $4ee1
	ld a, [$cb00] ; $4ee4
	or a, a ; $4ee7
	jr z, Label_1d_4eec ; $4ee8
	ld l, $40 ; $4eea
Label_1d_4eec:
	ld a, l ; $4eec
	add a, $39 ; $4eed
	ld l, a ; $4eef
	ld a, h ; $4ef0
	adc a, $00 ; $4ef1
	ld h, a ; $4ef3
	pop af ; $4ef4
	ld a, [hl] ; $4ef5
	ld [$d00b], a ; $4ef6
	push af ; $4ef9
	ld hl, $c900 ; $4efa
	ld a, [$cb00] ; $4efd
	or a, a ; $4f00
	jr z, Label_1d_4f05 ; $4f01
	ld l, $40 ; $4f03
Label_1d_4f05:
	ld a, l ; $4f05
	add a, $22 ; $4f06
	ld l, a ; $4f08
	ld a, h ; $4f09
	adc a, $00 ; $4f0a
	ld h, a ; $4f0c
	pop af ; $4f0d
	ld a, [hl] ; $4f0e
	inc a ; $4f0f
	ld [$d010], a ; $4f10
	push af ; $4f13
	ld hl, $c900 ; $4f14
	ld a, [$cb00] ; $4f17
	or a, a ; $4f1a
	jr z, Label_1d_4f1f ; $4f1b
	ld l, $40 ; $4f1d
Label_1d_4f1f:
	ld a, l ; $4f1f
	add a, $23 ; $4f20
	ld l, a ; $4f22
	ld a, h ; $4f23
	adc a, $00 ; $4f24
	ld h, a ; $4f26
	pop af ; $4f27
	ld a, [hl] ; $4f28
	inc a ; $4f29
	ld [$d011], a ; $4f2a
	push af ; $4f2d
	ld hl, $c900 ; $4f2e
	ld a, [$cb00] ; $4f31
	or a, a ; $4f34
	jr z, Label_1d_4f39 ; $4f35
	ld l, $40 ; $4f37
Label_1d_4f39:
	ld a, l ; $4f39
	add a, $24 ; $4f3a
	ld l, a ; $4f3c
	ld a, h ; $4f3d
	adc a, $00 ; $4f3e
	ld h, a ; $4f40
	pop af ; $4f41
	ld a, [hl] ; $4f42
	inc a ; $4f43
	ld [$d012], a ; $4f44
	push af ; $4f47
	ld hl, $c900 ; $4f48
	ld a, [$cb00] ; $4f4b
	or a, a ; $4f4e
	jr z, Label_1d_4f53 ; $4f4f
	ld l, $40 ; $4f51
Label_1d_4f53:
	ld a, l ; $4f53
	add a, $3a ; $4f54
	ld l, a ; $4f56
	ld a, h ; $4f57
	adc a, $00 ; $4f58
	ld h, a ; $4f5a
	pop af ; $4f5b
	ld a, [hl] ; $4f5c
	ld [$d00c], a ; $4f5d
	push af ; $4f60
	ld hl, $c900 ; $4f61
	ld a, [$cb00] ; $4f64
	or a, a ; $4f67
	jr z, Label_1d_4f6c ; $4f68
	ld l, $40 ; $4f6a
Label_1d_4f6c:
	ld a, l ; $4f6c
	add a, $25 ; $4f6d
	ld l, a ; $4f6f
	ld a, h ; $4f70
	adc a, $00 ; $4f71
	ld h, a ; $4f73
	pop af ; $4f74
	ld a, [hl] ; $4f75
	inc a ; $4f76
	ld [$d013], a ; $4f77
	push af ; $4f7a
	ld hl, $c900 ; $4f7b
	ld a, [$cb00] ; $4f7e
	or a, a ; $4f81
	jr z, Label_1d_4f86 ; $4f82
	ld l, $40 ; $4f84
Label_1d_4f86:
	ld a, l ; $4f86
	add a, $26 ; $4f87
	ld l, a ; $4f89
	ld a, h ; $4f8a
	adc a, $00 ; $4f8b
	ld h, a ; $4f8d
	pop af ; $4f8e
	ld a, [hl] ; $4f8f
	inc a ; $4f90
	ld [$d014], a ; $4f91
	push af ; $4f94
	ld hl, $c900 ; $4f95
	ld a, [$cb00] ; $4f98
	or a, a ; $4f9b
	jr z, Label_1d_4fa0 ; $4f9c
	ld l, $40 ; $4f9e
Label_1d_4fa0:
	ld a, l ; $4fa0
	add a, $3b ; $4fa1
	ld l, a ; $4fa3
	ld a, h ; $4fa4
	adc a, $00 ; $4fa5
	ld h, a ; $4fa7
	pop af ; $4fa8
	ld a, [hl] ; $4fa9
	ld [$d00d], a ; $4faa
	push af ; $4fad
	ld hl, $c900 ; $4fae
	ld a, [$cb00] ; $4fb1
	or a, a ; $4fb4
	jr z, Label_1d_4fb9 ; $4fb5
	ld l, $40 ; $4fb7
Label_1d_4fb9:
	ld a, l ; $4fb9
	add a, $27 ; $4fba
	ld l, a ; $4fbc
	ld a, h ; $4fbd
	adc a, $00 ; $4fbe
	ld h, a ; $4fc0
	pop af ; $4fc1
	ld a, [hl] ; $4fc2
	inc a ; $4fc3
	ld [$d015], a ; $4fc4
	push af ; $4fc7
	ld hl, $c900 ; $4fc8
	ld a, [$cb00] ; $4fcb
	or a, a ; $4fce
	jr z, Label_1d_4fd3 ; $4fcf
	ld l, $40 ; $4fd1
Label_1d_4fd3:
	ld a, l ; $4fd3
	add a, $28 ; $4fd4
	ld l, a ; $4fd6
	ld a, h ; $4fd7
	adc a, $00 ; $4fd8
	ld h, a ; $4fda
	pop af ; $4fdb
	ld a, [hl] ; $4fdc
	inc a ; $4fdd
	ld [$d016], a ; $4fde
	push af ; $4fe1
	ld hl, $c900 ; $4fe2
	ld a, [$cb00] ; $4fe5
	or a, a ; $4fe8
	jr z, Label_1d_4fed ; $4fe9
	ld l, $40 ; $4feb
Label_1d_4fed:
	ld a, l ; $4fed
	add a, $29 ; $4fee
	ld l, a ; $4ff0
	ld a, h ; $4ff1
	adc a, $00 ; $4ff2
	ld h, a ; $4ff4
	pop af ; $4ff5
	ld a, [hl] ; $4ff6
	inc a ; $4ff7
	ld [$d017], a ; $4ff8
	push af ; $4ffb
	ld hl, $c900 ; $4ffc
	ld a, [$cb00] ; $4fff
	or a, a ; $5002
	jr z, Label_1d_5007 ; $5003
	ld l, $40 ; $5005
Label_1d_5007:
	ld a, l ; $5007
	add a, $2a ; $5008
	ld l, a ; $500a
	ld a, h ; $500b
	adc a, $00 ; $500c
	ld h, a ; $500e
	pop af ; $500f
	ld a, [hl] ; $5010
	inc a ; $5011
	ld [$d018], a ; $5012
	farcall FarPtr_1c_06 ; $5015
	ld a, $03 ; $5018
	ldh [$ff96], a ; $501a
	ldh [rWBK], a ; $501c
	ld hl, $d501 ; $501e
	ld a, $a3 ; $5021
	ld [hl+], a ; $5023
	ld [hl+], a ; $5024
	ld [hl+], a ; $5025
	ld [hl+], a ; $5026
	ld [hl+], a ; $5027
	ld [hl+], a ; $5028
	ld [hl], a ; $5029
	ld hl, $d50f ; $502a
	xor a, a ; $502d
	ld [hl+], a ; $502e
	ld [hl+], a ; $502f
	ld [hl+], a ; $5030
	ld [hl+], a ; $5031
	ld [hl+], a ; $5032
	ld [hl+], a ; $5033
	ld [hl], a ; $5034
	ld a, $02 ; $5035
	ldh [$ff96], a ; $5037
	ldh [rWBK], a ; $5039
	ld hl, $d501 ; $503b
	ld a, $08 ; $503e
	ld [hl+], a ; $5040
	ld [hl+], a ; $5041
	ld [hl+], a ; $5042
	ld [hl+], a ; $5043
	ld [hl+], a ; $5044
	ld [hl+], a ; $5045
	ld [hl], a ; $5046
	ld hl, $d50f ; $5047
	ld [hl+], a ; $504a
	ld [hl+], a ; $504b
	ld [hl+], a ; $504c
	ld [hl+], a ; $504d
	ld [hl+], a ; $504e
	ld [hl+], a ; $504f
	ld [hl], a ; $5050
	push af ; $5051
	ld hl, $c900 ; $5052
	ld a, [$cb00] ; $5055
	or a, a ; $5058
	jr z, Label_1d_505d ; $5059
	ld l, $40 ; $505b
Label_1d_505d:
	ld a, l ; $505d
	add a, $00 ; $505e
	ld l, a ; $5060
	ld a, h ; $5061
	adc a, $00 ; $5062
	ld h, a ; $5064
	pop af ; $5065
	ld de, $d50f ; $5066
	ld c, $0e ; $5069
	call Func_1d_47b0 ; $506b
	ld a, $06 ; $506e
	ldh [$ff96], a ; $5070
	ldh [rWBK], a ; $5072
	push af ; $5074
	ld hl, $c900 ; $5075
	ld a, [$cb00] ; $5078
	or a, a ; $507b
	jr z, Label_1d_5080 ; $507c
	ld l, $40 ; $507e
Label_1d_5080:
	ld a, l ; $5080
	add a, $18 ; $5081
	ld l, a ; $5083
	ld a, h ; $5084
	adc a, $00 ; $5085
	ld h, a ; $5087
	pop af ; $5088
	ld a, [hl] ; $5089
	ld h, $00 ; $508a
	ld l, a ; $508c
	ld a, $02 ; $508d
	ld de, $d08e ; $508f
	call Func_00_1a27 ; $5092
	ld de, $d519 ; $5095
	farcall FarPtr_1c_04 ; $5098
	ret ; $509b
Func_1d_509c:
	call Func_00_2631 ; $509c
	ld a, [$d002] ; $509f
	or a, a ; $50a2
	jr nz, Func_1d_509c ; $50a3
	call Func_1d_4aa9 ; $50a5
	ld hl, $5e3d ; $50a8
	ld bc, $d7e0 ; $50ab
	call Func_1d_4bb6 ; $50ae
	ld hl, $5e52 ; $50b1
	ld bc, $d8e0 ; $50b4
	call Func_1d_4bb6 ; $50b7
	ld hl, $5e73 ; $50ba
	ld bc, $d9e0 ; $50bd
	call Func_1d_4bb6 ; $50c0
	ld hl, $5c25 ; $50c3
	ld bc, $d390 ; $50c6
	call Func_1d_4bb6 ; $50c9
	farcall FarPtr_1c_16 ; $50cc
	ld a, $06 ; $50cf
	ldh [$ff96], a ; $50d1
	ldh [rWBK], a ; $50d3
	ld hl, $d147 ; $50d5
	ld de, $0020 ; $50d8
	ld a, e ; $50db
	ld [hl+], a ; $50dc
	ld [hl], d ; $50dd
	call Func_1d_4aa9 ; $50de
	ld hl, $5e7c ; $50e1
	ld bc, $d7e0 ; $50e4
	call Func_1d_4bb6 ; $50e7
	ld hl, $5e91 ; $50ea
	ld bc, $d8e0 ; $50ed
	call Func_1d_4bb6 ; $50f0
	ld hl, $5eb2 ; $50f3
	ld bc, $d9e0 ; $50f6
	call Func_1d_4bb6 ; $50f9
	ld hl, $5c2e ; $50fc
	ld bc, $d390 ; $50ff
	call Func_1d_4bb6 ; $5102
	farcall FarPtr_1c_16 ; $5105
	ld a, $06 ; $5108
	ldh [$ff96], a ; $510a
	ldh [rWBK], a ; $510c
	ld hl, $d145 ; $510e
	ld de, $ff60 ; $5111
	ld a, e ; $5114
	ld [hl+], a ; $5115
	ld [hl], d ; $5116
	ld hl, $d147 ; $5117
	ld de, $0040 ; $511a
	ld a, e ; $511d
	ld [hl+], a ; $511e
	ld [hl], d ; $511f
	call Func_1d_4aa9 ; $5120
	ld hl, $5ebb ; $5123
	ld bc, $d7e0 ; $5126
	call Func_1d_4bb6 ; $5129
	ld hl, $5ed0 ; $512c
	ld bc, $d8e0 ; $512f
	call Func_1d_4bb6 ; $5132
	ld hl, $5ef1 ; $5135
	ld bc, $d9e0 ; $5138
	call Func_1d_4bb6 ; $513b
	ld hl, $615d ; $513e
	ld bc, $da20 ; $5141
	call Func_1d_4bb6 ; $5144
	ld hl, $6172 ; $5147
	ld bc, $db20 ; $514a
	call Func_1d_4bb6 ; $514d
	ld hl, $6193 ; $5150
	ld bc, $dc20 ; $5153
	call Func_1d_4bb6 ; $5156
	farcall FarPtr_1c_16 ; $5159
	ld a, $06 ; $515c
	ldh [$ff96], a ; $515e
	ldh [rWBK], a ; $5160
	ld hl, $d145 ; $5162
	ld de, $ff80 ; $5165
	ld a, e ; $5168
	ld [hl+], a ; $5169
	ld [hl], d ; $516a
	ld hl, $d147 ; $516b
	ld de, $0060 ; $516e
	ld a, e ; $5171
	ld [hl+], a ; $5172
	ld [hl], d ; $5173
	call Func_1d_4aa9 ; $5174
	ld hl, $5efa ; $5177
	ld bc, $d7e0 ; $517a
	call Func_1d_4bb6 ; $517d
	ld hl, $5f0f ; $5180
	ld bc, $d8e0 ; $5183
	call Func_1d_4bb6 ; $5186
	ld hl, $5f30 ; $5189
	ld bc, $d9e0 ; $518c
	call Func_1d_4bb6 ; $518f
	ld hl, $6116 ; $5192
	ld bc, $da20 ; $5195
	call Func_1d_4bb6 ; $5198
	ld hl, $6137 ; $519b
	ld bc, $db20 ; $519e
	call Func_1d_4bb6 ; $51a1
	ld hl, $6158 ; $51a4
	ld bc, $dc20 ; $51a7
	call Func_1d_4bb6 ; $51aa
	farcall FarPtr_1c_16 ; $51ad
	ld a, $06 ; $51b0
	ldh [$ff96], a ; $51b2
	ldh [rWBK], a ; $51b4
	ld hl, $d145 ; $51b6
	ld de, $ffa0 ; $51b9
	ld a, e ; $51bc
	ld [hl+], a ; $51bd
	ld [hl], d ; $51be
	ld hl, $d147 ; $51bf
	ld de, $0080 ; $51c2
	ld a, e ; $51c5
	ld [hl+], a ; $51c6
	ld [hl], d ; $51c7
	call Func_1d_4aa9 ; $51c8
	ld hl, $60cb ; $51cb
	ld bc, $da20 ; $51ce
	call Func_1d_4bb6 ; $51d1
	ld hl, $60ec ; $51d4
	ld bc, $db20 ; $51d7
	call Func_1d_4bb6 ; $51da
	ld hl, $610d ; $51dd
	ld bc, $dc20 ; $51e0
	call Func_1d_4bb6 ; $51e3
	farcall FarPtr_1c_16 ; $51e6
	ld a, $06 ; $51e9
	ldh [$ff96], a ; $51eb
	ldh [rWBK], a ; $51ed
	ld hl, $d145 ; $51ef
	ld de, $ffc0 ; $51f2
	ld a, e ; $51f5
	ld [hl+], a ; $51f6
	ld [hl], d ; $51f7
	ld hl, $d147 ; $51f8
	ld de, $00a0 ; $51fb
	ld a, e ; $51fe
	ld [hl+], a ; $51ff
	ld [hl], d ; $5200
	call Func_1d_4aa9 ; $5201
	ld hl, $6080 ; $5204
	ld bc, $da20 ; $5207
	call Func_1d_4bb6 ; $520a
	ld hl, $60a1 ; $520d
	ld bc, $db20 ; $5210
	call Func_1d_4bb6 ; $5213
	ld hl, $60c2 ; $5216
	ld bc, $dc20 ; $5219
	call Func_1d_4bb6 ; $521c
	farcall FarPtr_1c_16 ; $521f
	ld a, $06 ; $5222
	ldh [$ff96], a ; $5224
	ldh [rWBK], a ; $5226
	ld hl, $d145 ; $5228
	ld de, $ffe0 ; $522b
	ld a, e ; $522e
	ld [hl+], a ; $522f
	ld [hl], d ; $5230
	ld hl, $d147 ; $5231
	ld de, $00a8 ; $5234
	ld a, e ; $5237
	ld [hl+], a ; $5238
	ld [hl], d ; $5239
	call Func_1d_4aa9 ; $523a
	ld hl, $6035 ; $523d
	ld bc, $da20 ; $5240
	call Func_1d_4bb6 ; $5243
	ld hl, $6056 ; $5246
	ld bc, $db20 ; $5249
	call Func_1d_4bb6 ; $524c
	ld hl, $6077 ; $524f
	ld bc, $dc20 ; $5252
	call Func_1d_4bb6 ; $5255
	farcall FarPtr_1c_16 ; $5258
	ld a, $06 ; $525b
	ldh [$ff96], a ; $525d
	ldh [rWBK], a ; $525f
	ld hl, $d145 ; $5261
	xor a, a ; $5264
	ld [hl+], a ; $5265
	ld [hl], a ; $5266
	ret ; $5267
Func_1d_5268:
	call Func_00_2631 ; $5268
	ld a, [$d002] ; $526b
	or a, a ; $526e
	jr nz, Func_1d_5268 ; $526f
	ld a, $06 ; $5271
	ldh [$ff96], a ; $5273
	ldh [rWBK], a ; $5275
	ld hl, $d145 ; $5277
	ld de, $ffe0 ; $527a
	ld a, e ; $527d
	ld [hl+], a ; $527e
	ld [hl], d ; $527f
	call Func_1d_4aa9 ; $5280
	ld hl, $6080 ; $5283
	ld bc, $da20 ; $5286
	call Func_1d_4bb6 ; $5289
	ld hl, $60a1 ; $528c
	ld bc, $db20 ; $528f
	call Func_1d_4bb6 ; $5292
	ld hl, $60c2 ; $5295
	ld bc, $dc20 ; $5298
	call Func_1d_4bb6 ; $529b
	farcall FarPtr_1c_16 ; $529e
	ld a, $06 ; $52a1
	ldh [$ff96], a ; $52a3
	ldh [rWBK], a ; $52a5
	ld hl, $d145 ; $52a7
	ld de, $ffc0 ; $52aa
	ld a, e ; $52ad
	ld [hl+], a ; $52ae
	ld [hl], d ; $52af
	ld hl, $d147 ; $52b0
	ld de, $00a0 ; $52b3
	ld a, e ; $52b6
	ld [hl+], a ; $52b7
	ld [hl], d ; $52b8
	call Func_1d_4aa9 ; $52b9
	ld hl, $60cb ; $52bc
	ld bc, $da20 ; $52bf
	call Func_1d_4bb6 ; $52c2
	ld hl, $60ec ; $52c5
	ld bc, $db20 ; $52c8
	call Func_1d_4bb6 ; $52cb
	ld hl, $610d ; $52ce
	ld bc, $dc20 ; $52d1
	call Func_1d_4bb6 ; $52d4
	farcall FarPtr_1c_16 ; $52d7
	ld a, $06 ; $52da
	ldh [$ff96], a ; $52dc
	ldh [rWBK], a ; $52de
	ld hl, $d145 ; $52e0
	ld de, $ffa0 ; $52e3
	ld a, e ; $52e6
	ld [hl+], a ; $52e7
	ld [hl], d ; $52e8
	ld hl, $d147 ; $52e9
	ld de, $0080 ; $52ec
	ld a, e ; $52ef
	ld [hl+], a ; $52f0
	ld [hl], d ; $52f1
	call Func_1d_4aa9 ; $52f2
	ld hl, $5efa ; $52f5
	ld bc, $d7e0 ; $52f8
	call Func_1d_4bb6 ; $52fb
	ld hl, $5f0f ; $52fe
	ld bc, $d8e0 ; $5301
	call Func_1d_4bb6 ; $5304
	ld hl, $5f30 ; $5307
	ld bc, $d9e0 ; $530a
	call Func_1d_4bb6 ; $530d
	ld hl, $6116 ; $5310
	ld bc, $da20 ; $5313
	call Func_1d_4bb6 ; $5316
	ld hl, $6137 ; $5319
	ld bc, $db20 ; $531c
	call Func_1d_4bb6 ; $531f
	ld hl, $6158 ; $5322
	ld bc, $dc20 ; $5325
	call Func_1d_4bb6 ; $5328
	farcall FarPtr_1c_16 ; $532b
	ld a, $06 ; $532e
	ldh [$ff96], a ; $5330
	ldh [rWBK], a ; $5332
	ld hl, $d145 ; $5334
	ld de, $ff80 ; $5337
	ld a, e ; $533a
	ld [hl+], a ; $533b
	ld [hl], d ; $533c
	ld hl, $d147 ; $533d
	ld de, $0060 ; $5340
	ld a, e ; $5343
	ld [hl+], a ; $5344
	ld [hl], d ; $5345
	call Func_1d_4aa9 ; $5346
	ld hl, $5ebb ; $5349
	ld bc, $d7e0 ; $534c
	call Func_1d_4bb6 ; $534f
	ld hl, $5ed0 ; $5352
	ld bc, $d8e0 ; $5355
	call Func_1d_4bb6 ; $5358
	ld hl, $5ef1 ; $535b
	ld bc, $d9e0 ; $535e
	call Func_1d_4bb6 ; $5361
	ld hl, $615d ; $5364
	ld bc, $da20 ; $5367
	call Func_1d_4bb6 ; $536a
	ld hl, $6172 ; $536d
	ld bc, $db20 ; $5370
	call Func_1d_4bb6 ; $5373
	ld hl, $6193 ; $5376
	ld bc, $dc20 ; $5379
	call Func_1d_4bb6 ; $537c
	farcall FarPtr_1c_16 ; $537f
	ld a, $06 ; $5382
	ldh [$ff96], a ; $5384
	ldh [rWBK], a ; $5386
	ld hl, $d145 ; $5388
	ld de, $ff60 ; $538b
	ld a, e ; $538e
	ld [hl+], a ; $538f
	ld [hl], d ; $5390
	ld hl, $d147 ; $5391
	ld de, $0040 ; $5394
	ld a, e ; $5397
	ld [hl+], a ; $5398
	ld [hl], d ; $5399
	call Func_1d_4aa9 ; $539a
	ld hl, $5e7c ; $539d
	ld bc, $d7e0 ; $53a0
	call Func_1d_4bb6 ; $53a3
	ld hl, $5e91 ; $53a6
	ld bc, $d8e0 ; $53a9
	call Func_1d_4bb6 ; $53ac
	ld hl, $5eb2 ; $53af
	ld bc, $d9e0 ; $53b2
	call Func_1d_4bb6 ; $53b5
	ld hl, $5c2e ; $53b8
	ld bc, $d390 ; $53bb
	call Func_1d_4bb6 ; $53be
	farcall FarPtr_1c_16 ; $53c1
	ld a, $06 ; $53c4
	ldh [$ff96], a ; $53c6
	ldh [rWBK], a ; $53c8
	ld hl, $d145 ; $53ca
	ld de, $00a8 ; $53cd
	ld a, e ; $53d0
	ld [hl+], a ; $53d1
	ld [hl], d ; $53d2
	ld hl, $d147 ; $53d3
	ld de, $0010 ; $53d6
	ld a, e ; $53d9
	ld [hl+], a ; $53da
	ld [hl], d ; $53db
	call Func_1d_4aa9 ; $53dc
	ld hl, $5e3d ; $53df
	ld bc, $d7e0 ; $53e2
	call Func_1d_4bb6 ; $53e5
	ld hl, $5e52 ; $53e8
	ld bc, $d8e0 ; $53eb
	call Func_1d_4bb6 ; $53ee
	ld hl, $5e73 ; $53f1
	ld bc, $d9e0 ; $53f4
	call Func_1d_4bb6 ; $53f7
	ld hl, $5c25 ; $53fa
	ld bc, $d390 ; $53fd
	call Func_1d_4bb6 ; $5400
	farcall FarPtr_1c_16 ; $5403
	ld a, $06 ; $5406
	ldh [$ff96], a ; $5408
	ldh [rWBK], a ; $540a
	ld hl, $d147 ; $540c
	xor a, a ; $540f
	ld [hl+], a ; $5410
	ld [hl], a ; $5411
	call Func_1d_4aa9 ; $5412
	ld hl, $5df2 ; $5415
	ld bc, $d7e0 ; $5418
	call Func_1d_4bb6 ; $541b
	ld hl, $5e13 ; $541e
	ld bc, $d8e0 ; $5421
	call Func_1d_4bb6 ; $5424
	ld hl, $5e34 ; $5427
	ld bc, $d9e0 ; $542a
	call Func_1d_4bb6 ; $542d
	ld hl, $5c25 ; $5430
	ld bc, $d390 ; $5433
	call Func_1d_4bb6 ; $5436
	farcall FarPtr_1c_16 ; $5439
	ret ; $543c
Func_1d_543d:
	call Func_00_2631 ; $543d
	ld a, [$d002] ; $5440
	or a, a ; $5443
	jr nz, Func_1d_543d ; $5444
	ld a, $06 ; $5446
	ldh [$ff96], a ; $5448
	ldh [rWBK], a ; $544a
	ld hl, $d147 ; $544c
	ld de, $ffe0 ; $544f
	ld a, e ; $5452
	ld [hl+], a ; $5453
	ld [hl], d ; $5454
	call Func_1d_4aa9 ; $5455
	ld hl, $5f39 ; $5458
	ld bc, $d7e0 ; $545b
	call Func_1d_4bb6 ; $545e
	ld hl, $5f4e ; $5461
	ld bc, $d8e0 ; $5464
	call Func_1d_4bb6 ; $5467
	ld hl, $5f6f ; $546a
	ld bc, $d9e0 ; $546d
	call Func_1d_4bb6 ; $5470
	ld hl, $5c25 ; $5473
	ld bc, $d390 ; $5476
	call Func_1d_4bb6 ; $5479
	farcall FarPtr_1c_16 ; $547c
	ld a, $06 ; $547f
	ldh [$ff96], a ; $5481
	ldh [rWBK], a ; $5483
	ld hl, $d145 ; $5485
	ld de, $00a0 ; $5488
	ld a, e ; $548b
	ld [hl+], a ; $548c
	ld [hl], d ; $548d
	ld hl, $d147 ; $548e
	ld de, $ffc0 ; $5491
	ld a, e ; $5494
	ld [hl+], a ; $5495
	ld [hl], d ; $5496
	call Func_1d_4aa9 ; $5497
	ld hl, $5f78 ; $549a
	ld bc, $d7e0 ; $549d
	call Func_1d_4bb6 ; $54a0
	ld hl, $5f8d ; $54a3
	ld bc, $d8e0 ; $54a6
	call Func_1d_4bb6 ; $54a9
	ld hl, $5fae ; $54ac
	ld bc, $d9e0 ; $54af
	call Func_1d_4bb6 ; $54b2
	ld hl, $62c4 ; $54b5
	ld bc, $dc60 ; $54b8
	call Func_1d_4bb6 ; $54bb
	ld hl, $62d9 ; $54be
	ld bc, $dd60 ; $54c1
	call Func_1d_4bb6 ; $54c4
	ld hl, $62fa ; $54c7
	ld bc, $de60 ; $54ca
	call Func_1d_4bb6 ; $54cd
	ld hl, $5c2e ; $54d0
	ld bc, $d390 ; $54d3
	call Func_1d_4bb6 ; $54d6
	farcall FarPtr_1c_16 ; $54d9
	ld a, $06 ; $54dc
	ldh [$ff96], a ; $54de
	ldh [rWBK], a ; $54e0
	ld hl, $d145 ; $54e2
	ld de, $0080 ; $54e5
	ld a, e ; $54e8
	ld [hl+], a ; $54e9
	ld [hl], d ; $54ea
	ld hl, $d147 ; $54eb
	ld de, $ffa0 ; $54ee
	ld a, e ; $54f1
	ld [hl+], a ; $54f2
	ld [hl], d ; $54f3
	call Func_1d_4aa9 ; $54f4
	ld hl, $5fb7 ; $54f7
	ld bc, $d7e0 ; $54fa
	call Func_1d_4bb6 ; $54fd
	ld hl, $5fcc ; $5500
	ld bc, $d8e0 ; $5503
	call Func_1d_4bb6 ; $5506
	ld hl, $5fed ; $5509
	ld bc, $d9e0 ; $550c
	call Func_1d_4bb6 ; $550f
	ld hl, $6279 ; $5512
	ld bc, $dc60 ; $5515
	call Func_1d_4bb6 ; $5518
	ld hl, $629a ; $551b
	ld bc, $dd60 ; $551e
	call Func_1d_4bb6 ; $5521
	ld hl, $62bb ; $5524
	ld bc, $de60 ; $5527
	call Func_1d_4bb6 ; $552a
	farcall FarPtr_1c_16 ; $552d
	ld a, $06 ; $5530
	ldh [$ff96], a ; $5532
	ldh [rWBK], a ; $5534
	ld hl, $d145 ; $5536
	ld de, $0060 ; $5539
	ld a, e ; $553c
	ld [hl+], a ; $553d
	ld [hl], d ; $553e
	ld hl, $d147 ; $553f
	ld de, $ff80 ; $5542
	ld a, e ; $5545
	ld [hl+], a ; $5546
	ld [hl], d ; $5547
	call Func_1d_4aa9 ; $5548
	ld hl, $5ff6 ; $554b
	ld bc, $d7e0 ; $554e
	call Func_1d_4bb6 ; $5551
	ld hl, $600b ; $5554
	ld bc, $d8e0 ; $5557
	call Func_1d_4bb6 ; $555a
	ld hl, $602c ; $555d
	ld bc, $d9e0 ; $5560
	call Func_1d_4bb6 ; $5563
	ld hl, $622e ; $5566
	ld bc, $dc60 ; $5569
	call Func_1d_4bb6 ; $556c
	ld hl, $624f ; $556f
	ld bc, $dd60 ; $5572
	call Func_1d_4bb6 ; $5575
	ld hl, $6270 ; $5578
	ld bc, $de60 ; $557b
	call Func_1d_4bb6 ; $557e
	farcall FarPtr_1c_16 ; $5581
	ld a, $06 ; $5584
	ldh [$ff96], a ; $5586
	ldh [rWBK], a ; $5588
	ld hl, $d145 ; $558a
	ld de, $0040 ; $558d
	ld a, e ; $5590
	ld [hl+], a ; $5591
	ld [hl], d ; $5592
	ld hl, $d147 ; $5593
	ld de, $ff60 ; $5596
	ld a, e ; $5599
	ld [hl+], a ; $559a
	ld [hl], d ; $559b
	call Func_1d_4aa9 ; $559c
	ld hl, $61e3 ; $559f
	ld bc, $dc60 ; $55a2
	call Func_1d_4bb6 ; $55a5
	ld hl, $6204 ; $55a8
	ld bc, $dd60 ; $55ab
	call Func_1d_4bb6 ; $55ae
	ld hl, $6225 ; $55b1
	ld bc, $de60 ; $55b4
	call Func_1d_4bb6 ; $55b7
	farcall FarPtr_1c_16 ; $55ba
	ld a, $06 ; $55bd
	ldh [$ff96], a ; $55bf
	ldh [rWBK], a ; $55c1
	ld hl, $d145 ; $55c3
	ld de, $0020 ; $55c6
	ld a, e ; $55c9
	ld [hl+], a ; $55ca
	ld [hl], d ; $55cb
	ld hl, $d147 ; $55cc
	ld de, $00a8 ; $55cf
	ld a, e ; $55d2
	ld [hl+], a ; $55d3
	ld [hl], d ; $55d4
	call Func_1d_4aa9 ; $55d5
	ld hl, $6198 ; $55d8
	ld bc, $dc60 ; $55db
	call Func_1d_4bb6 ; $55de
	ld hl, $61b9 ; $55e1
	ld bc, $dd60 ; $55e4
	call Func_1d_4bb6 ; $55e7
	ld hl, $61da ; $55ea
	ld bc, $de60 ; $55ed
	call Func_1d_4bb6 ; $55f0
	farcall FarPtr_1c_16 ; $55f3
	ld a, $06 ; $55f6
	ldh [$ff96], a ; $55f8
	ldh [rWBK], a ; $55fa
	ld hl, $d145 ; $55fc
	xor a, a ; $55ff
	ld [hl+], a ; $5600
	ld [hl], a ; $5601
	ret ; $5602
Func_1d_5603:
	call Func_00_2631 ; $5603
	ld a, [$d002] ; $5606
	or a, a ; $5609
	jr nz, Func_1d_5603 ; $560a
	ld a, $06 ; $560c
	ldh [$ff96], a ; $560e
	ldh [rWBK], a ; $5610
	ld hl, $d145 ; $5612
	ld de, $0020 ; $5615
	ld a, e ; $5618
	ld [hl+], a ; $5619
	ld [hl], d ; $561a
	call Func_1d_4aa9 ; $561b
	ld hl, $61e3 ; $561e
	ld bc, $dc60 ; $5621
	call Func_1d_4bb6 ; $5624
	ld hl, $6204 ; $5627
	ld bc, $dd60 ; $562a
	call Func_1d_4bb6 ; $562d
	ld hl, $6225 ; $5630
	ld bc, $de60 ; $5633
	call Func_1d_4bb6 ; $5636
	farcall FarPtr_1c_16 ; $5639
	ld a, $06 ; $563c
	ldh [$ff96], a ; $563e
	ldh [rWBK], a ; $5640
	ld hl, $d147 ; $5642
	ld de, $ff60 ; $5645
	ld a, e ; $5648
	ld [hl+], a ; $5649
	ld [hl], d ; $564a
	ld hl, $d145 ; $564b
	ld de, $0040 ; $564e
	ld a, e ; $5651
	ld [hl+], a ; $5652
	ld [hl], d ; $5653
	call Func_1d_4aa9 ; $5654
	ld hl, $5ff6 ; $5657
	ld bc, $d7e0 ; $565a
	call Func_1d_4bb6 ; $565d
	ld hl, $600b ; $5660
	ld bc, $d8e0 ; $5663
	call Func_1d_4bb6 ; $5666
	ld hl, $602c ; $5669
	ld bc, $d9e0 ; $566c
	call Func_1d_4bb6 ; $566f
	ld hl, $622e ; $5672
	ld bc, $dc60 ; $5675
	call Func_1d_4bb6 ; $5678
	ld hl, $624f ; $567b
	ld bc, $dd60 ; $567e
	call Func_1d_4bb6 ; $5681
	ld hl, $6270 ; $5684
	ld bc, $de60 ; $5687
	call Func_1d_4bb6 ; $568a
	farcall FarPtr_1c_16 ; $568d
	ld a, $06 ; $5690
	ldh [$ff96], a ; $5692
	ldh [rWBK], a ; $5694
	ld hl, $d147 ; $5696
	ld de, $ff80 ; $5699
	ld a, e ; $569c
	ld [hl+], a ; $569d
	ld [hl], d ; $569e
	ld hl, $d145 ; $569f
	ld de, $0060 ; $56a2
	ld a, e ; $56a5
	ld [hl+], a ; $56a6
	ld [hl], d ; $56a7
	call Func_1d_4aa9 ; $56a8
	ld hl, $5fb7 ; $56ab
	ld bc, $d7e0 ; $56ae
	call Func_1d_4bb6 ; $56b1
	ld hl, $5fcc ; $56b4
	ld bc, $d8e0 ; $56b7
	call Func_1d_4bb6 ; $56ba
	ld hl, $5fed ; $56bd
	ld bc, $d9e0 ; $56c0
	call Func_1d_4bb6 ; $56c3
	ld hl, $6279 ; $56c6
	ld bc, $dc60 ; $56c9
	call Func_1d_4bb6 ; $56cc
	ld hl, $629a ; $56cf
	ld bc, $dd60 ; $56d2
	call Func_1d_4bb6 ; $56d5
	ld hl, $62bb ; $56d8
	ld bc, $de60 ; $56db
	call Func_1d_4bb6 ; $56de
	farcall FarPtr_1c_16 ; $56e1
	ld a, $06 ; $56e4
	ldh [$ff96], a ; $56e6
	ldh [rWBK], a ; $56e8
	ld hl, $d147 ; $56ea
	ld de, $ffa0 ; $56ed
	ld a, e ; $56f0
	ld [hl+], a ; $56f1
	ld [hl], d ; $56f2
	ld hl, $d145 ; $56f3
	ld de, $0080 ; $56f6
	ld a, e ; $56f9
	ld [hl+], a ; $56fa
	ld [hl], d ; $56fb
	call Func_1d_4aa9 ; $56fc
	ld hl, $5f78 ; $56ff
	ld bc, $d7e0 ; $5702
	call Func_1d_4bb6 ; $5705
	ld hl, $5f8d ; $5708
	ld bc, $d8e0 ; $570b
	call Func_1d_4bb6 ; $570e
	ld hl, $5fae ; $5711
	ld bc, $d9e0 ; $5714
	call Func_1d_4bb6 ; $5717
	ld hl, $62c4 ; $571a
	ld bc, $dc60 ; $571d
	call Func_1d_4bb6 ; $5720
	ld hl, $62d9 ; $5723
	ld bc, $dd60 ; $5726
	call Func_1d_4bb6 ; $5729
	ld hl, $62fa ; $572c
	ld bc, $de60 ; $572f
	call Func_1d_4bb6 ; $5732
	ld hl, $5c2e ; $5735
	ld bc, $d390 ; $5738
	call Func_1d_4bb6 ; $573b
	farcall FarPtr_1c_16 ; $573e
	ld a, $06 ; $5741
	ldh [$ff96], a ; $5743
	ldh [rWBK], a ; $5745
	ld hl, $d147 ; $5747
	ld de, $ffc0 ; $574a
	ld a, e ; $574d
	ld [hl+], a ; $574e
	ld [hl], d ; $574f
	ld hl, $d145 ; $5750
	ld de, $00a0 ; $5753
	ld a, e ; $5756
	ld [hl+], a ; $5757
	ld [hl], d ; $5758
	call Func_1d_4aa9 ; $5759
	ld hl, $5f39 ; $575c
	ld bc, $d7e0 ; $575f
	call Func_1d_4bb6 ; $5762
	ld hl, $5f4e ; $5765
	ld bc, $d8e0 ; $5768
	call Func_1d_4bb6 ; $576b
	ld hl, $5f6f ; $576e
	ld bc, $d9e0 ; $5771
	call Func_1d_4bb6 ; $5774
	ld hl, $5c25 ; $5777
	ld bc, $d390 ; $577a
	call Func_1d_4bb6 ; $577d
	farcall FarPtr_1c_16 ; $5780
	ld a, $06 ; $5783
	ldh [$ff96], a ; $5785
	ldh [rWBK], a ; $5787
	ld hl, $d147 ; $5789
	ld de, $ffe0 ; $578c
	ld a, e ; $578f
	ld [hl+], a ; $5790
	ld [hl], d ; $5791
	ld hl, $d145 ; $5792
	ld de, $00a8 ; $5795
	ld a, e ; $5798
	ld [hl+], a ; $5799
	ld [hl], d ; $579a
	call Func_1d_4aa9 ; $579b
	ld hl, $5df2 ; $579e
	ld bc, $d7e0 ; $57a1
	call Func_1d_4bb6 ; $57a4
	ld hl, $5e13 ; $57a7
	ld bc, $d8e0 ; $57aa
	call Func_1d_4bb6 ; $57ad
	ld hl, $5e34 ; $57b0
	ld bc, $d9e0 ; $57b3
	call Func_1d_4bb6 ; $57b6
	ld hl, $5c25 ; $57b9
	ld bc, $d390 ; $57bc
	call Func_1d_4bb6 ; $57bf
	farcall FarPtr_1c_16 ; $57c2
	ld a, $06 ; $57c5
	ldh [$ff96], a ; $57c7
	ldh [rWBK], a ; $57c9
	ld hl, $d147 ; $57cb
	xor a, a ; $57ce
	ld [hl+], a ; $57cf
	ld [hl], a ; $57d0
	ret ; $57d1
	INCBIN "data/bank_01d/d_57d2.bin" ; $57d2, 453 bytes
Func_1d_5997:
	push bc ; $5997
	ld b, $00 ; $5998
	ld c, d ; $599a
	ld a, $06 ; $599b
	ldh [$ff96], a ; $599d
	ldh [rWBK], a ; $599f
	ld a, [hl+] ; $59a1
	ld h, [hl] ; $59a2
	ld l, a ; $59a3
	add hl, bc ; $59a4
	ld a, h ; $59a5
	or a, a ; $59a6
	jr nz, Label_1d_59b1 ; $59a7
	ld a, l ; $59a9
	cp a, $a0 ; $59aa
	jr nc, Label_1d_59b1 ; $59ac
	ld d, l ; $59ae
	pop bc ; $59af
	ret ; $59b0
Label_1d_59b1:
	ld d, $a8 ; $59b1
	pop bc ; $59b3
	ret ; $59b4
Func_1d_59b5:
	sub a, $30 ; $59b5
	rlca ; $59b7
	add a, $38 ; $59b8
	ld c, a ; $59ba
	ld b, $08 ; $59bb
	ret ; $59bd
Func_1d_59be:
	ld a, [$cb00] ; $59be
	farcall FarPtr_02_2c ; $59c1
	ld a, h ; $59c4
	or a, l ; $59c5
	jp z, Label_1d_59da ; $59c6
	push hl ; $59c9
	ld a, [$cb00] ; $59ca
	farcall FarPtr_02_2e ; $59cd
	pop de ; $59d0
	push hl ; $59d1
	add hl, de ; $59d2
	pop de ; $59d3
	ld b, $40 ; $59d4
	call Func_1d_59dc ; $59d6
	ret ; $59d9
Label_1d_59da:
	xor a, a ; $59da
	ret ; $59db
Func_1d_59dc:
	push bc ; $59dc
	push hl ; $59dd
	ld h, $00 ; $59de
	ld l, b ; $59e0
	call Func_00_0c48 ; $59e1
	ldh a, [$ffa8] ; $59e4
	ld l, a ; $59e6
	ldh a, [$ffa9] ; $59e7
	ld h, a ; $59e9
	ldh a, [$ffaa] ; $59ea
	pop de ; $59ec
	call Func_00_0ea6 ; $59ed
	ld a, h ; $59f0
	or a, a ; $59f1
	jr nz, Label_1d_59f9 ; $59f2
	pop bc ; $59f4
	inc b ; $59f5
	ld a, l ; $59f6
	cp a, b ; $59f7
	ret c ; $59f8
Label_1d_59f9:
	pop bc ; $59f9
	ld a, b ; $59fa
	ret ; $59fb
Func_1d_59fc:
	ld b, a ; $59fc
	ld a, $03 ; $59fd
	ldh [$ff96], a ; $59ff
	ldh [rWBK], a ; $5a01
Label_1d_5a03:
	ld a, b ; $5a03
	sub a, $08 ; $5a04
	jr c, Label_1d_5a25 ; $5a06
	jr z, Label_1d_5a3b ; $5a08
	ld b, a ; $5a0a
	ld a, $08 ; $5a0b
	rlca ; $5a0d
	add a, $51 ; $5a0e
	ld l, a ; $5a10
	adc a, $5a ; $5a11
	sub a, l ; $5a13
	ld h, a ; $5a14
	ld a, [hl+] ; $5a15
	ld [de], a ; $5a16
	push de ; $5a17
	ld a, $0a ; $5a18
	add a, e ; $5a1a
	ld e, a ; $5a1b
	jr nc, Label_1d_5a1f ; $5a1c
	inc d ; $5a1e
Label_1d_5a1f:
	ld a, [hl] ; $5a1f
	ld [de], a ; $5a20
	pop de ; $5a21
	inc de ; $5a22
	jr Label_1d_5a03 ; $5a23
Label_1d_5a25:
	add a, $08 ; $5a25
	rlca ; $5a27
	add a, $51 ; $5a28
	ld l, a ; $5a2a
	adc a, $5a ; $5a2b
	sub a, l ; $5a2d
	ld h, a ; $5a2e
	ld a, [hl+] ; $5a2f
	ld [de], a ; $5a30
	ld a, $0a ; $5a31
	add a, e ; $5a33
	ld e, a ; $5a34
	jr nc, Label_1d_5a38 ; $5a35
	inc d ; $5a37
Label_1d_5a38:
	ld a, [hl] ; $5a38
	ld [de], a ; $5a39
	ret ; $5a3a
Label_1d_5a3b:
	ld a, $08 ; $5a3b
	rlca ; $5a3d
	add a, $51 ; $5a3e
	ld l, a ; $5a40
	adc a, $5a ; $5a41
	sub a, l ; $5a43
	ld h, a ; $5a44
	ld a, [hl+] ; $5a45
	ld [de], a ; $5a46
	ld a, $0a ; $5a47
	add a, e ; $5a49
	ld e, a ; $5a4a
	jr nc, Label_1d_5a4e ; $5a4b
	inc d ; $5a4d
Label_1d_5a4e:
	ld a, [hl] ; $5a4e
	ld [de], a ; $5a4f
	ret ; $5a50
	INCBIN "data/bank_01d/d_5a51.bin" ; $5a51, 18 bytes
Func_1d_5a63:
	push af ; $5a63
	call Func_00_1b38 ; $5a64
	call DisableLCDSafely ; $5a67
	xor a, a ; $5a6a
	ldh [$ff8b], a ; $5a6b
	ldh [$ff8a], a ; $5a6d
	ld [$c320], a ; $5a6f
	ld [$c321], a ; $5a72
	ld [$c322], a ; $5a75
	ld [$c323], a ; $5a78
	ld a, $90 ; $5a7b
	ldh [rWY], a ; $5a7d
	call Func_00_1e1d ; $5a7f
	call Func_1d_40d0 ; $5a82
	pop af ; $5a85
	call Func_1d_5b1a ; $5a86
	call EnableLCD ; $5a89
	call Func_00_2631 ; $5a8c
	farcall FarPtr_1c_12 ; $5a8f
	ld c, $10 ; $5a92
	call Func_00_1d2e ; $5a94
	call Func_00_1da4 ; $5a97
	ld a, $06 ; $5a9a
	ldh [$ff96], a ; $5a9c
	ldh [rWBK], a ; $5a9e
	ld a, $01 ; $5aa0
	ld [$d025], a ; $5aa2
Label_1d_5aa5:
	call Func_1d_5afa ; $5aa5
	call Func_00_2631 ; $5aa8
	ldh a, [$ff94] ; $5aab
	bit 0, a ; $5aad
	jr nz, Label_1d_5ac5 ; $5aaf
	bit 1, a ; $5ab1
	jr nz, Label_1d_5ad5 ; $5ab3
	and a, $c0 ; $5ab5
	jr z, Label_1d_5aa5 ; $5ab7
	sound $5e ; $5ab9
	ld a, [$d025] ; $5abb
	xor a, $01 ; $5abe
	ld [$d025], a ; $5ac0
	jr Label_1d_5aa5 ; $5ac3
Label_1d_5ac5:
	ld a, $06 ; $5ac5
	ldh [$ff96], a ; $5ac7
	ldh [rWBK], a ; $5ac9
	ld a, [$d025] ; $5acb
	or a, a ; $5ace
	jr nz, Label_1d_5ad5 ; $5acf
	sound $5f ; $5ad1
	jr Label_1d_5ae2 ; $5ad3
Label_1d_5ad5:
	ld a, $06 ; $5ad5
	ldh [$ff96], a ; $5ad7
	ldh [rWBK], a ; $5ad9
	ld a, $01 ; $5adb
	ld [$d025], a ; $5add
	sound $62 ; $5ae0
Label_1d_5ae2:
	ld c, $10 ; $5ae2
	call Func_00_1d20 ; $5ae4
	call Func_00_1da4 ; $5ae7
	farcall FarPtr_1c_14 ; $5aea
	call Func_00_1b38 ; $5aed
	ld a, $06 ; $5af0
	ldh [$ff96], a ; $5af2
	ldh [rWBK], a ; $5af4
	ld a, [$d025] ; $5af6
	ret ; $5af9
Func_1d_5afa:
	ld a, $06 ; $5afa
	ldh [$ff96], a ; $5afc
	ldh [rWBK], a ; $5afe
	ld a, [$d025] ; $5b00
	or a, a ; $5b03
	jr nz, Label_1d_5b10 ; $5b04
	ld bc, $0fd4 ; $5b06
	ld de, $7a0c ; $5b09
	call Func_00_1f51 ; $5b0c
	ret ; $5b0f
Label_1d_5b10:
	ld bc, $0fd4 ; $5b10
	ld de, $7a14 ; $5b13
	call Func_00_1f51 ; $5b16
	ret ; $5b19
Func_1d_5b1a:
	push af ; $5b1a
	farcall FarPtr_1c_02 ; $5b1b
	farcall FarPtr_1c_10 ; $5b1e
	pop af ; $5b21
	ld [$cb00], a ; $5b22
	push af ; $5b25
	ld hl, $c900 ; $5b26
	ld a, [$cb00] ; $5b29
	or a, a ; $5b2c
	jr z, Label_1d_5b31 ; $5b2d
	ld l, $40 ; $5b2f
Label_1d_5b31:
	ld a, l ; $5b31
	add a, $0c ; $5b32
	ld l, a ; $5b34
	ld a, h ; $5b35
	adc a, $00 ; $5b36
	ld h, a ; $5b38
	pop af ; $5b39
	ld a, [hl] ; $5b3a
	ld de, $0401 ; $5b3b
	farcall FarPtr_1b_02 ; $5b3e
	ld a, $01 ; $5b41
	ldh [$ff96], a ; $5b43
	ldh [rWBK], a ; $5b45
	push af ; $5b47
	ld hl, $c900 ; $5b48
	ld a, [$cb00] ; $5b4b
	or a, a ; $5b4e
	jr z, Label_1d_5b53 ; $5b4f
	ld l, $40 ; $5b51
Label_1d_5b53:
	ld a, l ; $5b53
	add a, $0b ; $5b54
	ld l, a ; $5b56
	ld a, h ; $5b57
	adc a, $00 ; $5b58
	ld h, a ; $5b5a
	pop af ; $5b5b
	ld a, [hl] ; $5b5c
	ld de, $d000 ; $5b5d
	farcall FarPtr_1b_00 ; $5b60
	ld hl, $d000 ; $5b63
	ld de, $b200 ; $5b66
	ld c, $03 ; $5b69
	call Func_00_0480 ; $5b6b
	ld hl, $d030 ; $5b6e
	ld de, $b300 ; $5b71
	ld c, $03 ; $5b74
	call Func_00_0480 ; $5b76
	ld hl, $d060 ; $5b79
	ld de, $b400 ; $5b7c
	ld c, $03 ; $5b7f
	call Func_00_0480 ; $5b81
	call Func_1d_4e8d ; $5b84
	ld hl, $5cbb ; $5b87
	ld bc, $d240 ; $5b8a
	call Func_1d_4bb6 ; $5b8d
	ld hl, $5ced ; $5b90
	ld bc, $d280 ; $5b93
	call Func_1d_4bb6 ; $5b96
	ld hl, $5d1f ; $5b99
	ld bc, $d2d0 ; $5b9c
	call Func_1d_4bb6 ; $5b9f
	ld hl, $5d59 ; $5ba2
	ld bc, $d310 ; $5ba5
	call Func_1d_4bb6 ; $5ba8
	ld hl, $5dbe ; $5bab
	ld bc, $d370 ; $5bae
	call Func_1d_4bb6 ; $5bb1
	ld hl, $6303 ; $5bb4
	ld bc, $d550 ; $5bb7
	call Func_1d_4bb6 ; $5bba
	call Func_1d_5c0b ; $5bbd
	ld a, $03 ; $5bc0
	ldh [$ff96], a ; $5bc2
	ldh [rWBK], a ; $5bc4
	ld hl, $d000 ; $5bc6
	ld de, $9800 ; $5bc9
	ld c, $24 ; $5bcc
	call Func_00_0480 ; $5bce
	ld a, $02 ; $5bd1
	ldh [$ff96], a ; $5bd3
	ldh [rWBK], a ; $5bd5
	ld hl, $d000 ; $5bd7
	ld de, $b800 ; $5bda
	ld c, $24 ; $5bdd
	call Func_00_0480 ; $5bdf
	ret ; $5be2
Func_1d_5be3:
	call Func_00_1b38 ; $5be3
	call DisableLCDSafely ; $5be6
	xor a, a ; $5be9
	ldh [$ff8b], a ; $5bea
	ldh [$ff8a], a ; $5bec
	ld [$c320], a ; $5bee
	ld [$c321], a ; $5bf1
	ld [$c322], a ; $5bf4
	ld [$c323], a ; $5bf7
	ld a, $90 ; $5bfa
	ldh [rWY], a ; $5bfc
	call Func_00_1e1d ; $5bfe
	farcall FarPtr_01_0a ; $5c01
	call Func_1d_40d0 ; $5c04
	call Func_1d_411e ; $5c07
	ret ; $5c0a
Func_1d_5c0b:
	ld hl, $6310 ; $5c0b
	ld bc, $d580 ; $5c0e
	call Func_1d_4bb6 ; $5c11
	ret ; $5c14
Func_1d_5c15:
	ld a, $01 ; $5c15
	ld hl, $48c7 ; $5c17
	call Func_00_1b6a ; $5c1a
	ret ; $5c1d
Func_1d_5c1e:
	ld hl, $48c7 ; $5c1e
	call Func_00_1bcb ; $5c21
	ret ; $5c24
	INCBIN "data/bank_01d/d_5c25.bin" ; $5c25, 3079 bytes
Func_1d_682c:
	ld a, $06 ; $682c
	ldh [$ff96], a ; $682e
	ldh [rWBK], a ; $6830
	xor a, a ; $6832
	ld [$d0b6], a ; $6833
Label_1d_6836:
	call Func_1d_68a3 ; $6836
	ld a, $06 ; $6839
	ldh [$ff96], a ; $683b
	ldh [rWBK], a ; $683d
	ld hl, $d167 ; $683f
	ld a, [hl+] ; $6842
	ld d, [hl] ; $6843
	ld e, a ; $6844
	xor a, a ; $6845
	farcall FarPtr_02_28 ; $6846
	ld hl, $d176 ; $6849
	ld a, [hl+] ; $684c
	ld d, [hl] ; $684d
	ld e, a ; $684e
	ld a, $01 ; $684f
	farcall FarPtr_02_28 ; $6851
Label_1d_6854:
	ld c, $00 ; $6854
	farcall FarPtr_1c_00 ; $6856
	dec a ; $6859
	jr z, Label_1d_6873 ; $685a
	inc a ; $685c
	jr nz, Label_1d_686a ; $685d
	farcall FarPtr_1c_0c ; $685f
	ld c, $01 ; $6862
	farcall FarPtr_1c_00 ; $6864
	dec a ; $6867
	jr z, Label_1d_689c ; $6868
Label_1d_686a:
	ld c, $01 ; $686a
	farcall FarPtr_1c_00 ; $686c
	dec a ; $686f
	jr z, Label_1d_68a1 ; $6870
	ret ; $6872
Label_1d_6873:
	ld a, $06 ; $6873
	ldh [$ff96], a ; $6875
	ldh [rWBK], a ; $6877
	ld hl, $d16d ; $6879
	ld de, $c92c ; $687c
	ld a, [hl+] ; $687f
	ld [de], a ; $6880
	inc de ; $6881
	ld a, [hl+] ; $6882
	ld [de], a ; $6883
	inc de ; $6884
	ld a, [hl] ; $6885
	ld [de], a ; $6886
	ld hl, $d17c ; $6887
	ld de, $c96c ; $688a
	ld a, [hl+] ; $688d
	ld [de], a ; $688e
	inc de ; $688f
	ld a, [hl+] ; $6890
	ld [de], a ; $6891
	inc de ; $6892
	ld a, [hl] ; $6893
	ld [de], a ; $6894
	ld a, $01 ; $6895
	ld [$d0b6], a ; $6897
	jr Label_1d_6836 ; $689a
Label_1d_689c:
	farcall FarPtr_1c_0e ; $689c
	jr Label_1d_6854 ; $689f
Label_1d_68a1:
	jr Label_1d_6873 ; $68a1
Func_1d_68a3:
	push hl ; $68a3
	sound $0c ; $68a4
	call Func_00_1b38 ; $68a6
	call DisableLCDSafely ; $68a9
	xor a, a ; $68ac
	ldh [$ff8b], a ; $68ad
	ldh [$ff8a], a ; $68af
	ld [$c320], a ; $68b1
	ld [$c321], a ; $68b4
	ld [$c322], a ; $68b7
	ld [$c323], a ; $68ba
	ld a, $90 ; $68bd
	ldh [rWY], a ; $68bf
	call Func_00_1e1d ; $68c1
	pop hl ; $68c4
	call Func_1d_6934 ; $68c5
	farcall FarPtr_1c_18 ; $68c8
	call Func_1d_6977 ; $68cb
	call EnableLCD ; $68ce
	call Func_00_2631 ; $68d1
	ld a, $04 ; $68d4
	ld hl, $7727 ; $68d6
	call Func_00_1b6a ; $68d9
	ld a, $04 ; $68dc
	ld hl, $7760 ; $68de
	call Func_00_1b6a ; $68e1
	ld a, $01 ; $68e4
	ld hl, $7789 ; $68e6
	call Func_00_1b6a ; $68e9
	ld a, $08 ; $68ec
	ld hl, $765e ; $68ee
	call Func_00_1b6a ; $68f1
	xor a, a ; $68f4
	ld [$cb00], a ; $68f5
	ld c, $10 ; $68f8
	call Func_00_1d2e ; $68fa
	call Func_00_1da4 ; $68fd
	ld a, $06 ; $6900
	ldh [$ff96], a ; $6902
	ldh [rWBK], a ; $6904
	xor a, a ; $6906
	ld [$cb00], a ; $6907
	call Func_1d_7189 ; $690a
	call Func_00_2631 ; $690d
	call Func_1d_6f3e ; $6910
	ld c, $10 ; $6913
	call Func_00_1d20 ; $6915
	call Func_00_1da4 ; $6918
	ld hl, $7727 ; $691b
	call Func_00_1bcb ; $691e
	ld hl, $7760 ; $6921
	call Func_00_1bcb ; $6924
	ld hl, $7789 ; $6927
	call Func_00_1bcb ; $692a
	ld hl, $765e ; $692d
	call Func_00_1bcb ; $6930
	ret ; $6933
Func_1d_6934:
	ld a, $06 ; $6934
	ldh [$ff96], a ; $6936
	ldh [rWBK], a ; $6938
	ld a, [$d0b6] ; $693a
	or a, a ; $693d
	jr nz, Label_1d_6967 ; $693e
	ld a, l ; $6940
	ld [$d14e], a ; $6941
	ld [$d150], a ; $6944
	ld a, h ; $6947
	ld [$d14f], a ; $6948
	ld [$d151], a ; $694b
	xor a, a ; $694e
	ld [$d167], a ; $694f
	ld [$d168], a ; $6952
	ld [$d176], a ; $6955
	ld [$d177], a ; $6958
	ld [$d186], a ; $695b
	xor a, a ; $695e
	ld [$d185], a ; $695f
	ld a, $08 ; $6962
	ld [$d183], a ; $6964
Label_1d_6967:
	xor a, a ; $6967
	ld [$d17f], a ; $6968
	ld [$d180], a ; $696b
	ld [$d184], a ; $696e
	ld a, $a8 ; $6971
	ld [$d181], a ; $6973
	ret ; $6976
Func_1d_6977:
	call Func_1d_6ace ; $6977
	call Func_1d_6b7b ; $697a
	xor a, a ; $697d
	ld [$cb00], a ; $697e
	call Func_1d_6de7 ; $6981
	call Func_1d_6ea2 ; $6984
	ld a, $01 ; $6987
	ld [$cb00], a ; $6989
	call Func_1d_6de7 ; $698c
	call Func_1d_6ea2 ; $698f
	ld a, $01 ; $6992
	ldh [$ff96], a ; $6994
	ldh [rWBK], a ; $6996
	ld hl, $7822 ; $6998
	ld de, $d240 ; $699b
	call DecompressData ; $699e
	ld hl, $d240 ; $69a1
	ld bc, $0030 ; $69a4
	call Func_1d_6aa4 ; $69a7
	ld a, $01 ; $69aa
	ldh [$ff96], a ; $69ac
	ldh [rWBK], a ; $69ae
	ld hl, $7851 ; $69b0
	ld de, $d240 ; $69b3
	call DecompressData ; $69b6
	ld hl, $d240 ; $69b9
	ld bc, $0030 ; $69bc
	call Func_1d_6ab9 ; $69bf
	ld a, $01 ; $69c2
	ldh [$ff96], a ; $69c4
	ldh [rWBK], a ; $69c6
	ld hl, $7876 ; $69c8
	ld de, $d000 ; $69cb
	call DecompressData ; $69ce
	ld hl, $d000 ; $69d1
	ld de, $a160 ; $69d4
	ld c, $02 ; $69d7
	call Func_00_0480 ; $69d9
	ld a, $01 ; $69dc
	ldh [$ff96], a ; $69de
	ldh [rWBK], a ; $69e0
	ld hl, $79c1 ; $69e2
	ld de, $d000 ; $69e5
	call DecompressData ; $69e8
	ld hl, $d000 ; $69eb
	ld de, $a180 ; $69ee
	ld c, $14 ; $69f1
	call Func_00_0480 ; $69f3
	ld a, $01 ; $69f6
	ldh [$ff96], a ; $69f8
	ldh [rWBK], a ; $69fa
	ld hl, $7a63 ; $69fc
	ld de, $d000 ; $69ff
	call DecompressData ; $6a02
	ld hl, $d000 ; $6a05
	ld de, $a2c0 ; $6a08
	ld c, $18 ; $6a0b
	call Func_00_0480 ; $6a0d
	ld a, $01 ; $6a10
	ldh [$ff96], a ; $6a12
	ldh [rWBK], a ; $6a14
	ld hl, $7b8a ; $6a16
	ld de, $d000 ; $6a19
	call DecompressData ; $6a1c
	ld hl, $d000 ; $6a1f
	ld de, $a440 ; $6a22
	ld c, $18 ; $6a25
	call Func_00_0480 ; $6a27
	ld hl, $788f ; $6a2a
	ld de, $0e02 ; $6a2d
	call LoadPaletteShadow ; $6a30
	ld a, $01 ; $6a33
	ldh [$ff96], a ; $6a35
	ldh [rWBK], a ; $6a37
	ld hl, $78a7 ; $6a39
	ld de, $d000 ; $6a3c
	call DecompressData ; $6a3f
	ld hl, $d000 ; $6a42
	ld de, $a000 ; $6a45
	ld c, $0c ; $6a48
	call Func_00_0480 ; $6a4a
	ld a, $01 ; $6a4d
	ldh [$ff96], a ; $6a4f
	ldh [rWBK], a ; $6a51
	ld hl, $7949 ; $6a53
	ld de, $d000 ; $6a56
	call DecompressData ; $6a59
	ld hl, $d000 ; $6a5c
	ld de, $a0c0 ; $6a5f
	ld c, $04 ; $6a62
	call Func_00_0480 ; $6a64
	ld a, $01 ; $6a67
	ldh [$ff96], a ; $6a69
	ldh [rWBK], a ; $6a6b
	ld hl, $7983 ; $6a6d
	ld de, $d000 ; $6a70
	call DecompressData ; $6a73
	ld hl, $d000 ; $6a76
	ld de, $a100 ; $6a79
	ld c, $06 ; $6a7c
	call Func_00_0480 ; $6a7e
	ld a, $03 ; $6a81
	ldh [$ff96], a ; $6a83
	ldh [rWBK], a ; $6a85
	ld hl, $d000 ; $6a87
	ld de, $9800 ; $6a8a
	ld c, $24 ; $6a8d
	call Func_00_0480 ; $6a8f
	ld a, $02 ; $6a92
	ldh [$ff96], a ; $6a94
	ldh [rWBK], a ; $6a96
	ld hl, $d000 ; $6a98
	ld de, $b800 ; $6a9b
	ld c, $24 ; $6a9e
	call Func_00_0480 ; $6aa0
	ret ; $6aa3
Func_1d_6aa4:
	ld a, $01 ; $6aa4
	ldh [$ff96], a ; $6aa6
	ldh [rWBK], a ; $6aa8
	ld d, [hl] ; $6aaa
	ld a, $03 ; $6aab
	ldh [$ff96], a ; $6aad
	ldh [rWBK], a ; $6aaf
	ld [hl], d ; $6ab1
	inc hl ; $6ab2
	dec bc ; $6ab3
	ld a, b ; $6ab4
	or a, c ; $6ab5
	jr nz, Func_1d_6aa4 ; $6ab6
	ret ; $6ab8
Func_1d_6ab9:
	ld a, $01 ; $6ab9
	ldh [$ff96], a ; $6abb
	ldh [rWBK], a ; $6abd
	ld d, [hl] ; $6abf
	ld a, $02 ; $6ac0
	ldh [$ff96], a ; $6ac2
	ldh [rWBK], a ; $6ac4
	ld [hl], d ; $6ac6
	inc hl ; $6ac7
	dec bc ; $6ac8
	ld a, b ; $6ac9
	or a, c ; $6aca
	jr nz, Func_1d_6ab9 ; $6acb
	ret ; $6acd
Func_1d_6ace:
	ld a, $06 ; $6ace
	ldh [$ff96], a ; $6ad0
	ldh [rWBK], a ; $6ad2
	ld hl, $d14e ; $6ad4
	ld a, [hl+] ; $6ad7
	ld h, [hl] ; $6ad8
	ld l, a ; $6ad9
	ld a, $05 ; $6ada
	ld de, $d08e ; $6adc
	call Func_00_1a27 ; $6adf
	ld hl, $d08e ; $6ae2
	ld de, $d201 ; $6ae5
	call Func_1d_6d6a ; $6ae8
	call Func_1d_6aef ; $6aeb
	ret ; $6aee
Func_1d_6aef:
	ld a, $06 ; $6aef
	ldh [$ff96], a ; $6af1
	ldh [rWBK], a ; $6af3
	ld hl, $d14e ; $6af5
	ld a, [hl+] ; $6af8
	ld d, [hl] ; $6af9
	ld e, a ; $6afa
	ld hl, $d150 ; $6afb
	ld a, [hl+] ; $6afe
	ld h, [hl] ; $6aff
	ld l, a ; $6b00
	bit 7, h ; $6b01
	jr z, Label_1d_6b0d ; $6b03
	srl h ; $6b05
	rr l ; $6b07
	srl d ; $6b09
	rr e ; $6b0b
Label_1d_6b0d:
	ld b, $58 ; $6b0d
	call Func_1d_59dc ; $6b0f
	ld de, $d161 ; $6b12
	ld b, a ; $6b15
	ld c, $0b ; $6b16
	ld a, $03 ; $6b18
	ldh [$ff96], a ; $6b1a
	ldh [rWBK], a ; $6b1c
Label_1d_6b1e:
	ld a, b ; $6b1e
	sub a, $08 ; $6b1f
	jr c, Label_1d_6b3b ; $6b21
	ld b, a ; $6b23
	ld a, $08 ; $6b24
	rlca ; $6b26
	add a, $69 ; $6b27
	ld l, a ; $6b29
	adc a, $6b ; $6b2a
	sub a, l ; $6b2c
	ld h, a ; $6b2d
	ld a, [hl+] ; $6b2e
	ld [de], a ; $6b2f
	inc de ; $6b30
	ld a, [hl] ; $6b31
	ld [de], a ; $6b32
	dec de ; $6b33
	dec c ; $6b34
	ret z ; $6b35
	call Func_1d_6b60 ; $6b36
	jr Label_1d_6b1e ; $6b39
Label_1d_6b3b:
	add a, $08 ; $6b3b
	rlca ; $6b3d
	add a, $69 ; $6b3e
	ld l, a ; $6b40
	adc a, $6b ; $6b41
	sub a, l ; $6b43
	ld h, a ; $6b44
	ld a, [hl+] ; $6b45
	ld [de], a ; $6b46
	inc de ; $6b47
	ld a, [hl] ; $6b48
	ld [de], a ; $6b49
	dec de ; $6b4a
	dec c ; $6b4b
	ret z ; $6b4c
	call Func_1d_6b60 ; $6b4d
Label_1d_6b50:
	ld hl, $6b69 ; $6b50
	ld a, [hl+] ; $6b53
	ld [de], a ; $6b54
	inc de ; $6b55
	ld a, [hl] ; $6b56
	ld [de], a ; $6b57
	dec de ; $6b58
	dec c ; $6b59
	ret z ; $6b5a
	call Func_1d_6b60 ; $6b5b
	jr Label_1d_6b50 ; $6b5e
Func_1d_6b60:
	push bc ; $6b60
	ld c, $20 ; $6b61
Label_1d_6b63:
	dec de ; $6b63
	dec c ; $6b64
	jr nz, Label_1d_6b63 ; $6b65
	pop bc ; $6b67
	ret ; $6b68
	INCBIN "data/bank_01d/d_6b69.bin" ; $6b69, 18 bytes
Func_1d_6b7b:
	ld a, $06 ; $6b7b
	ldh [$ff96], a ; $6b7d
	ldh [rWBK], a ; $6b7f
	ld a, [$d0b6] ; $6b81
	or a, a ; $6b84
	jp nz, Label_1d_6ccc ; $6b85
	xor a, a ; $6b88
	ld [$cb00], a ; $6b89
	push af ; $6b8c
	ld hl, $c900 ; $6b8d
	ld a, [$cb00] ; $6b90
	or a, a ; $6b93
	jr z, Label_1d_6b98 ; $6b94
	ld l, $40 ; $6b96
Label_1d_6b98:
	ld a, l ; $6b98
	add a, $00 ; $6b99
	ld l, a ; $6b9b
	ld a, h ; $6b9c
	adc a, $00 ; $6b9d
	ld h, a ; $6b9f
	pop af ; $6ba0
	ld de, $d0ec ; $6ba1
	ld c, $20 ; $6ba4
	call Func_1d_6d6a ; $6ba6
	ld a, $06 ; $6ba9
	ldh [$ff96], a ; $6bab
	ldh [rWBK], a ; $6bad
	push af ; $6baf
	ld hl, $c900 ; $6bb0
	ld a, [$cb00] ; $6bb3
	or a, a ; $6bb6
	jr z, Label_1d_6bbb ; $6bb7
	ld l, $40 ; $6bb9
Label_1d_6bbb:
	ld a, l ; $6bbb
	add a, $18 ; $6bbc
	ld l, a ; $6bbe
	ld a, h ; $6bbf
	adc a, $00 ; $6bc0
	ld h, a ; $6bc2
	pop af ; $6bc3
	ld a, [hl] ; $6bc4
	push af ; $6bc5
	inc a ; $6bc6
	ld de, $d161 ; $6bc7
	ld [de], a ; $6bca
	dec a ; $6bcb
	ld h, $00 ; $6bcc
	ld l, a ; $6bce
	ld a, $02 ; $6bcf
	ld de, $d08e ; $6bd1
	call Func_00_1a27 ; $6bd4
	ld de, $d06b ; $6bd7
	farcall FarPtr_1c_04 ; $6bda
	ld a, $06 ; $6bdd
	ldh [$ff96], a ; $6bdf
	ldh [rWBK], a ; $6be1
	pop af ; $6be3
	farcall FarPtr_02_30 ; $6be4
	ld a, l ; $6be7
	ld [$d162], a ; $6be8
	ld a, h ; $6beb
	ld [$d163], a ; $6bec
	xor a, a ; $6bef
	farcall FarPtr_02_2e ; $6bf0
	ld a, l ; $6bf3
	ld [$d165], a ; $6bf4
	ld a, h ; $6bf7
	ld [$d166], a ; $6bf8
	xor a, a ; $6bfb
	farcall FarPtr_02_2c ; $6bfc
	ld a, l ; $6bff
	ld [$d169], a ; $6c00
	ld a, h ; $6c03
	ld [$d16a], a ; $6c04
	push af ; $6c07
	ld hl, $c900 ; $6c08
	ld a, [$cb00] ; $6c0b
	or a, a ; $6c0e
	jr z, Label_1d_6c13 ; $6c0f
	ld l, $40 ; $6c11
Label_1d_6c13:
	ld a, l ; $6c13
	add a, $2c ; $6c14
	ld l, a ; $6c16
	ld a, h ; $6c17
	adc a, $00 ; $6c18
	ld h, a ; $6c1a
	pop af ; $6c1b
	ld a, [hl+] ; $6c1c
	ld [$d16d], a ; $6c1d
	ld a, [hl+] ; $6c20
	ld [$d16e], a ; $6c21
	ld a, [hl] ; $6c24
	ld [$d16f], a ; $6c25
	ld a, $01 ; $6c28
	ld [$cb00], a ; $6c2a
	push af ; $6c2d
	ld hl, $c900 ; $6c2e
	ld a, [$cb00] ; $6c31
	or a, a ; $6c34
	jr z, Label_1d_6c39 ; $6c35
	ld l, $40 ; $6c37
Label_1d_6c39:
	ld a, l ; $6c39
	add a, $00 ; $6c3a
	ld l, a ; $6c3c
	ld a, h ; $6c3d
	adc a, $00 ; $6c3e
	ld h, a ; $6c40
	pop af ; $6c41
	ld de, $d20c ; $6c42
	ld c, $20 ; $6c45
	call Func_1d_6d6a ; $6c47
	ld a, $06 ; $6c4a
	ldh [$ff96], a ; $6c4c
	ldh [rWBK], a ; $6c4e
	push af ; $6c50
	ld hl, $c900 ; $6c51
	ld a, [$cb00] ; $6c54
	or a, a ; $6c57
	jr z, Label_1d_6c5c ; $6c58
	ld l, $40 ; $6c5a
Label_1d_6c5c:
	ld a, l ; $6c5c
	add a, $18 ; $6c5d
	ld l, a ; $6c5f
	ld a, h ; $6c60
	adc a, $00 ; $6c61
	ld h, a ; $6c63
	pop af ; $6c64
	ld a, [hl] ; $6c65
	push af ; $6c66
	inc a ; $6c67
	ld de, $d170 ; $6c68
	ld [de], a ; $6c6b
	dec a ; $6c6c
	ld h, $00 ; $6c6d
	ld l, a ; $6c6f
	ld a, $02 ; $6c70
	ld de, $d08e ; $6c72
	call Func_00_1a27 ; $6c75
	ld de, $d18b ; $6c78
	farcall FarPtr_1c_04 ; $6c7b
	ld a, $06 ; $6c7e
	ldh [$ff96], a ; $6c80
	ldh [rWBK], a ; $6c82
	pop af ; $6c84
	farcall FarPtr_02_30 ; $6c85
	ld a, l ; $6c88
	ld [$d171], a ; $6c89
	ld a, h ; $6c8c
	ld [$d172], a ; $6c8d
	ld a, $01 ; $6c90
	farcall FarPtr_02_2e ; $6c92
	ld a, l ; $6c95
	ld [$d174], a ; $6c96
	ld a, h ; $6c99
	ld [$d175], a ; $6c9a
	ld a, $01 ; $6c9d
	farcall FarPtr_02_2c ; $6c9f
	ld a, l ; $6ca2
	ld [$d178], a ; $6ca3
	ld a, h ; $6ca6
	ld [$d179], a ; $6ca7
	push af ; $6caa
	ld hl, $c900 ; $6cab
	ld a, [$cb00] ; $6cae
	or a, a ; $6cb1
	jr z, Label_1d_6cb6 ; $6cb2
	ld l, $40 ; $6cb4
Label_1d_6cb6:
	ld a, l ; $6cb6
	add a, $2c ; $6cb7
	ld l, a ; $6cb9
	ld a, h ; $6cba
	adc a, $00 ; $6cbb
	ld h, a ; $6cbd
	pop af ; $6cbe
	ld a, [hl+] ; $6cbf
	ld [$d17c], a ; $6cc0
	ld a, [hl+] ; $6cc3
	ld [$d17d], a ; $6cc4
	ld a, [hl] ; $6cc7
	ld [$d17e], a ; $6cc8
	ret ; $6ccb
Label_1d_6ccc:
	xor a, a ; $6ccc
	ld [$cb00], a ; $6ccd
	push af ; $6cd0
	ld hl, $c900 ; $6cd1
	ld a, [$cb00] ; $6cd4
	or a, a ; $6cd7
	jr z, Label_1d_6cdc ; $6cd8
	ld l, $40 ; $6cda
Label_1d_6cdc:
	ld a, l ; $6cdc
	add a, $00 ; $6cdd
	ld l, a ; $6cdf
	ld a, h ; $6ce0
	adc a, $00 ; $6ce1
	ld h, a ; $6ce3
	pop af ; $6ce4
	ld de, $d0ec ; $6ce5
	ld c, $20 ; $6ce8
	call Func_1d_6d6a ; $6cea
	ld a, $06 ; $6ced
	ldh [$ff96], a ; $6cef
	ldh [rWBK], a ; $6cf1
	push af ; $6cf3
	ld hl, $c900 ; $6cf4
	ld a, [$cb00] ; $6cf7
	or a, a ; $6cfa
	jr z, Label_1d_6cff ; $6cfb
	ld l, $40 ; $6cfd
Label_1d_6cff:
	ld a, l ; $6cff
	add a, $18 ; $6d00
	ld l, a ; $6d02
	ld a, h ; $6d03
	adc a, $00 ; $6d04
	ld h, a ; $6d06
	pop af ; $6d07
	ld a, [hl] ; $6d08
	ld h, $00 ; $6d09
	ld l, a ; $6d0b
	ld a, $02 ; $6d0c
	ld de, $d08e ; $6d0e
	call Func_00_1a27 ; $6d11
	ld de, $d06b ; $6d14
	farcall FarPtr_1c_04 ; $6d17
	ld a, $01 ; $6d1a
	ld [$cb00], a ; $6d1c
	push af ; $6d1f
	ld hl, $c900 ; $6d20
	ld a, [$cb00] ; $6d23
	or a, a ; $6d26
	jr z, Label_1d_6d2b ; $6d27
	ld l, $40 ; $6d29
Label_1d_6d2b:
	ld a, l ; $6d2b
	add a, $00 ; $6d2c
	ld l, a ; $6d2e
	ld a, h ; $6d2f
	adc a, $00 ; $6d30
	ld h, a ; $6d32
	pop af ; $6d33
	ld de, $d20c ; $6d34
	ld c, $20 ; $6d37
	call Func_1d_6d6a ; $6d39
	ld a, $06 ; $6d3c
	ldh [$ff96], a ; $6d3e
	ldh [rWBK], a ; $6d40
	push af ; $6d42
	ld hl, $c900 ; $6d43
	ld a, [$cb00] ; $6d46
	or a, a ; $6d49
	jr z, Label_1d_6d4e ; $6d4a
	ld l, $40 ; $6d4c
Label_1d_6d4e:
	ld a, l ; $6d4e
	add a, $18 ; $6d4f
	ld l, a ; $6d51
	ld a, h ; $6d52
	adc a, $00 ; $6d53
	ld h, a ; $6d55
	pop af ; $6d56
	ld a, [hl] ; $6d57
	ld h, $00 ; $6d58
	ld l, a ; $6d5a
	ld a, $02 ; $6d5b
	ld de, $d08e ; $6d5d
	call Func_00_1a27 ; $6d60
	ld de, $d18b ; $6d63
	farcall FarPtr_1c_04 ; $6d66
	ret ; $6d69
Func_1d_6d6a:
	ld a, $06 ; $6d6a
	ldh [$ff96], a ; $6d6c
	ldh [rWBK], a ; $6d6e
	ld a, [hl+] ; $6d70
	or a, a ; $6d71
	ret z ; $6d72
	cp a, $de ; $6d73
	jr z, Label_1d_6d8f ; $6d75
	cp a, $df ; $6d77
	jr z, Label_1d_6d8f ; $6d79
	ld b, a ; $6d7b
	ld a, $03 ; $6d7c
	ldh [$ff96], a ; $6d7e
	ldh [rWBK], a ; $6d80
	ld a, b ; $6d82
	ld [de], a ; $6d83
	ld a, $02 ; $6d84
	ldh [$ff96], a ; $6d86
	ldh [rWBK], a ; $6d88
	xor a, a ; $6d8a
	ld [de], a ; $6d8b
	inc de ; $6d8c
	jr Func_1d_6d6a ; $6d8d
Label_1d_6d8f:
	call Func_1d_6dd5 ; $6d8f
	ld b, a ; $6d92
	ld a, $03 ; $6d93
	ldh [$ff96], a ; $6d95
	ldh [rWBK], a ; $6d97
	ld a, [de] ; $6d99
	cp a, $73 ; $6d9a
	jr z, Label_1d_6da4 ; $6d9c
	cp a, $8f ; $6d9e
	jr z, Label_1d_6da4 ; $6da0
	jr Label_1d_6dc5 ; $6da2
Label_1d_6da4:
	push bc ; $6da4
	ld a, b ; $6da5
	sub a, $7e ; $6da6
	ld b, a ; $6da8
	ld c, $0f ; $6da9
	ld a, [$cb00] ; $6dab
	or a, a ; $6dae
	jr z, Label_1d_6dc5 ; $6daf
	inc b ; $6db1
	inc b ; $6db2
	ld c, $0c ; $6db3
	ld a, b ; $6db5
	ld [de], a ; $6db6
	ld a, $02 ; $6db7
	ldh [$ff96], a ; $6db9
	ldh [rWBK], a ; $6dbb
	ld a, c ; $6dbd
	ld [de], a ; $6dbe
	pop bc ; $6dbf
	call Func_1d_6ddf ; $6dc0
	jr Func_1d_6d6a ; $6dc3
Label_1d_6dc5:
	ld a, b ; $6dc5
	ld [de], a ; $6dc6
	ld a, $02 ; $6dc7
	ldh [$ff96], a ; $6dc9
	ldh [rWBK], a ; $6dcb
	ld a, c ; $6dcd
	ld [de], a ; $6dce
	pop bc ; $6dcf
	call Func_1d_6ddf ; $6dd0
	jr Func_1d_6d6a ; $6dd3
Func_1d_6dd5:
	push bc ; $6dd5
	ld c, $20 ; $6dd6
Label_1d_6dd8:
	dec de ; $6dd8
	dec c ; $6dd9
	jr nz, Label_1d_6dd8 ; $6dda
	dec de ; $6ddc
	pop bc ; $6ddd
	ret ; $6dde
Func_1d_6ddf:
	ld a, $21 ; $6ddf
	add a, e ; $6de1
	ld e, a ; $6de2
	jr nc, Label_1d_6de6 ; $6de3
	inc d ; $6de5
Label_1d_6de6:
	ret ; $6de6
Func_1d_6de7:
	ld a, $06 ; $6de7
	ldh [$ff96], a ; $6de9
	ldh [rWBK], a ; $6deb
	ld a, [$cb00] ; $6ded
	or a, a ; $6df0
	jr nz, Label_1d_6dfb ; $6df1
	ld a, [$d161] ; $6df3
	ld de, $d091 ; $6df6
	jr Label_1d_6e01 ; $6df9
Label_1d_6dfb:
	ld a, [$d170] ; $6dfb
	ld de, $d1b1 ; $6dfe
Label_1d_6e01:
	call Func_1d_6e74 ; $6e01
	cp a, $64 ; $6e04
	jr nc, Label_1d_6e27 ; $6e06
	push de ; $6e08
	ld h, $00 ; $6e09
	ld l, a ; $6e0b
	ld a, $02 ; $6e0c
	ld de, $d08e ; $6e0e
	call Func_00_1a27 ; $6e11
	pop de ; $6e14
	ld hl, $d08e ; $6e15
	ld a, [hl] ; $6e18
	cp a, $20 ; $6e19
	jr z, Label_1d_6e20 ; $6e1b
	call Func_1d_6e51 ; $6e1d
Label_1d_6e20:
	inc de ; $6e20
	inc hl ; $6e21
	ld a, [hl] ; $6e22
	call Func_1d_6e51 ; $6e23
	ret ; $6e26
Label_1d_6e27:
	ld a, $03 ; $6e27
	ldh [$ff96], a ; $6e29
	ldh [rWBK], a ; $6e2b
	ld h, d ; $6e2d
	ld l, e ; $6e2e
	dec hl ; $6e2f
	dec hl ; $6e30
	ld a, $9c ; $6e31
	ld [hl+], a ; $6e33
	inc a ; $6e34
	ld [hl+], a ; $6e35
	inc a ; $6e36
	ld [hl+], a ; $6e37
	inc a ; $6e38
	ld [hl], a ; $6e39
	ld a, $1d ; $6e3a
	add a, l ; $6e3c
	ld l, a ; $6e3d
	jr nc, Label_1d_6e41 ; $6e3e
	inc h ; $6e40
Label_1d_6e41:
	ld a, $ac ; $6e41
	ld [hl+], a ; $6e43
	inc a ; $6e44
	ld [hl+], a ; $6e45
	inc a ; $6e46
	ld [hl+], a ; $6e47
	inc a ; $6e48
	ld [hl], a ; $6e49
	ld a, $06 ; $6e4a
	ldh [$ff96], a ; $6e4c
	ldh [rWBK], a ; $6e4e
	ret ; $6e50
Func_1d_6e51:
	sub a, $30 ; $6e51
	add a, $66 ; $6e53
	ld b, a ; $6e55
	ld a, $03 ; $6e56
	ldh [$ff96], a ; $6e58
	ldh [rWBK], a ; $6e5a
	ld a, b ; $6e5c
	ld [de], a ; $6e5d
	push de ; $6e5e
	ld a, $10 ; $6e5f
	add a, b ; $6e61
	ld b, a ; $6e62
	ld a, $20 ; $6e63
	add a, e ; $6e65
	ld e, a ; $6e66
	jr nc, Label_1d_6e6a ; $6e67
	inc d ; $6e69
Label_1d_6e6a:
	ld a, b ; $6e6a
	ld [de], a ; $6e6b
	pop de ; $6e6c
	ld a, $06 ; $6e6d
	ldh [$ff96], a ; $6e6f
	ldh [rWBK], a ; $6e71
	ret ; $6e73
Func_1d_6e74:
	push af ; $6e74
	push de ; $6e75
	ld a, $03 ; $6e76
	ldh [$ff96], a ; $6e78
	ldh [rWBK], a ; $6e7a
	ld h, d ; $6e7c
	ld l, e ; $6e7d
	dec hl ; $6e7e
	dec hl ; $6e7f
	ld a, $64 ; $6e80
	ld [hl+], a ; $6e82
	inc a ; $6e83
	ld [hl+], a ; $6e84
	ld a, $65 ; $6e85
	ld [hl+], a ; $6e87
	ld [hl], a ; $6e88
	ld a, $1d ; $6e89
	add a, l ; $6e8b
	ld l, a ; $6e8c
	jr nc, Label_1d_6e90 ; $6e8d
	inc h ; $6e8f
Label_1d_6e90:
	ld a, $74 ; $6e90
	ld [hl+], a ; $6e92
	inc a ; $6e93
	ld [hl+], a ; $6e94
	ld a, $51 ; $6e95
	ld [hl+], a ; $6e97
	ld [hl], a ; $6e98
	ld a, $06 ; $6e99
	ldh [$ff96], a ; $6e9b
	ldh [rWBK], a ; $6e9d
	pop de ; $6e9f
	pop af ; $6ea0
	ret ; $6ea1
Func_1d_6ea2:
	ld a, $06 ; $6ea2
	ldh [$ff96], a ; $6ea4
	ldh [rWBK], a ; $6ea6
	ld a, [$cb00] ; $6ea8
	or a, a ; $6eab
	jr nz, Label_1d_6ed7 ; $6eac
	ld a, [$d161] ; $6eae
	cp a, $64 ; $6eb1
	jr c, Label_1d_6ebe ; $6eb3
	xor a, a ; $6eb5
	ld [$d164], a ; $6eb6
	ld de, $d027 ; $6eb9
	jr Label_1d_6efe ; $6ebc
Label_1d_6ebe:
	ld hl, $d165 ; $6ebe
	ld a, [hl+] ; $6ec1
	ld d, [hl] ; $6ec2
	ld e, a ; $6ec3
	ld hl, $d162 ; $6ec4
	ld a, [hl+] ; $6ec7
	ld h, [hl] ; $6ec8
	ld l, a ; $6ec9
	ld b, $40 ; $6eca
	call Func_1d_59dc ; $6ecc
	ld [$d164], a ; $6ecf
	ld de, $d027 ; $6ed2
	jr Label_1d_6efe ; $6ed5
Label_1d_6ed7:
	ld a, [$d170] ; $6ed7
	cp a, $64 ; $6eda
	jr c, Label_1d_6ee7 ; $6edc
	xor a, a ; $6ede
	ld [$d173], a ; $6edf
	ld de, $d147 ; $6ee2
	jr Label_1d_6efe ; $6ee5
Label_1d_6ee7:
	ld hl, $d174 ; $6ee7
	ld a, [hl+] ; $6eea
	ld d, [hl] ; $6eeb
	ld e, a ; $6eec
	ld hl, $d171 ; $6eed
	ld a, [hl+] ; $6ef0
	ld h, [hl] ; $6ef1
	ld l, a ; $6ef2
	ld b, $40 ; $6ef3
	call Func_1d_59dc ; $6ef5
	ld [$d173], a ; $6ef8
	ld de, $d147 ; $6efb
Label_1d_6efe:
	ld b, a ; $6efe
	ld c, $08 ; $6eff
	ld a, $03 ; $6f01
	ldh [$ff96], a ; $6f03
	ldh [rWBK], a ; $6f05
Label_1d_6f07:
	ld a, b ; $6f07
	sub a, $08 ; $6f08
	jr c, Label_1d_6f1d ; $6f0a
	ld b, a ; $6f0c
	ld a, $08 ; $6f0d
	add a, $35 ; $6f0f
	ld l, a ; $6f11
	adc a, $6f ; $6f12
	sub a, l ; $6f14
	ld h, a ; $6f15
	ld a, [hl] ; $6f16
	ld [de], a ; $6f17
	dec c ; $6f18
	ret z ; $6f19
	inc de ; $6f1a
	jr Label_1d_6f07 ; $6f1b
Label_1d_6f1d:
	add a, $08 ; $6f1d
	add a, $35 ; $6f1f
	ld l, a ; $6f21
	adc a, $6f ; $6f22
	sub a, l ; $6f24
	ld h, a ; $6f25
	ld a, [hl] ; $6f26
	ld [de], a ; $6f27
	dec c ; $6f28
	ret z ; $6f29
	inc de ; $6f2a
Label_1d_6f2b:
	ld hl, $6f35 ; $6f2b
	ld a, [hl] ; $6f2e
	ld [de], a ; $6f2f
	inc de ; $6f30
	dec c ; $6f31
	ret z ; $6f32
	jr Label_1d_6f2b ; $6f33
	INCBIN "data/bank_01d/d_6f35.bin" ; $6f35, 9 bytes
Func_1d_6f3e:
	ld a, $06 ; $6f3e
	ldh [$ff96], a ; $6f40
	ldh [rWBK], a ; $6f42
	ld a, [$d0b6] ; $6f44
	or a, a ; $6f47
	jr z, Label_1d_6f51 ; $6f48
	xor a, a ; $6f4a
	ld [$d0b6], a ; $6f4b
	jp Label_1d_7453 ; $6f4e
Label_1d_6f51:
	ld a, $06 ; $6f51
	ldh [$ff96], a ; $6f53
	ldh [rWBK], a ; $6f55
	ld a, [$d185] ; $6f57
	and a, $08 ; $6f5a
	or a, a ; $6f5c
	jr z, Label_1d_6f6d ; $6f5d
	ld a, [$d183] ; $6f5f
	or a, a ; $6f62
	jr z, Label_1d_6f6d ; $6f63
	dec a ; $6f65
	ld [$d183], a ; $6f66
	xor a, a ; $6f69
	ld [$d185], a ; $6f6a
Label_1d_6f6d:
	ld a, [$d184] ; $6f6d
	or a, a ; $6f70
	jr z, Label_1d_6f77 ; $6f71
	dec a ; $6f73
	ld [$d184], a ; $6f74
Label_1d_6f77:
	call Func_1d_77a7 ; $6f77
	call Func_1d_734b ; $6f7a
	call Func_00_2631 ; $6f7d
	ldh a, [hPlayerInputFlags] ; $6f80
	bit 1, a ; $6f82
	jr z, Label_1d_6f92 ; $6f84
	push af ; $6f86
	ld a, $06 ; $6f87
	ldh [$ff96], a ; $6f89
	ldh [rWBK], a ; $6f8b
	xor a, a ; $6f8d
	ld [$d184], a ; $6f8e
	pop af ; $6f91
Label_1d_6f92:
	bit 5, a ; $6f92
	jp nz, Label_1d_7020 ; $6f94
	bit 4, a ; $6f97
	jp nz, Label_1d_7076 ; $6f99
	bit 0, a ; $6f9c
	jp nz, Label_1d_7076 ; $6f9e
	ld a, $06 ; $6fa1
	ldh [$ff96], a ; $6fa3
	ldh [rWBK], a ; $6fa5
	ld a, $a8 ; $6fa7
	ld [$d181], a ; $6fa9
	ld a, $08 ; $6fac
	ld [$d183], a ; $6fae
	xor a, a ; $6fb1
	ld [$d185], a ; $6fb2
	ld hl, $d17f ; $6fb5
	res 1, [hl] ; $6fb8
	ldh a, [$ff94] ; $6fba
	bit 6, a ; $6fbc
	jr nz, Label_1d_6fc7 ; $6fbe
	bit 7, a ; $6fc0
	jr nz, Label_1d_6ff3 ; $6fc2
	jp Func_1d_6f3e ; $6fc4
Label_1d_6fc7:
	ld a, $06 ; $6fc7
	ldh [$ff96], a ; $6fc9
	ldh [rWBK], a ; $6fcb
	ld a, [$cb00] ; $6fcd
	or a, a ; $6fd0
	jp z, Func_1d_6f3e ; $6fd1
	sound $5e ; $6fd4
	xor a, a ; $6fd6
	ld [$cb00], a ; $6fd7
	call Func_1d_7189 ; $6fda
	ld hl, $70e6 ; $6fdd
	call Func_00_1bcb ; $6fe0
	ld a, $01 ; $6fe3
	ld hl, $70cc ; $6fe5
	call Func_00_1b6a ; $6fe8
	ld hl, $d17f ; $6feb
	set 0, [hl] ; $6fee
	jp Func_1d_6f3e ; $6ff0
Label_1d_6ff3:
	ld a, $06 ; $6ff3
	ldh [$ff96], a ; $6ff5
	ldh [rWBK], a ; $6ff7
	ld a, [$cb00] ; $6ff9
	or a, a ; $6ffc
	jp nz, Func_1d_6f3e ; $6ffd
	sound $5e ; $7000
	ld a, $01 ; $7002
	ld [$cb00], a ; $7004
	call Func_1d_7189 ; $7007
	ld hl, $70cc ; $700a
	call Func_00_1bcb ; $700d
	ld a, $01 ; $7010
	ld hl, $70e6 ; $7012
	call Func_00_1b6a ; $7015
	ld hl, $d17f ; $7018
	set 0, [hl] ; $701b
	jp Func_1d_6f3e ; $701d
Label_1d_7020:
	ld a, $06 ; $7020
	ldh [$ff96], a ; $7022
	ldh [rWBK], a ; $7024
	ld a, [$d17f] ; $7026
	bit 0, a ; $7029
	jp nz, Func_1d_6f3e ; $702b
	ld hl, $d185 ; $702e
	inc [hl] ; $7031
	ld a, [$d184] ; $7032
	or a, a ; $7035
	jr nz, Label_1d_7070 ; $7036
	call Func_1d_72dd ; $7038
	or a, a ; $703b
	jr z, Label_1d_7063 ; $703c
	sound $62 ; $703e
	ld a, $06 ; $7040
	ldh [$ff96], a ; $7042
	ldh [rWBK], a ; $7044
	ld a, [$d183] ; $7046
	or a, a ; $7049
	jr nz, Label_1d_704f ; $704a
	call Func_1d_72dd ; $704c
Label_1d_704f:
	ld hl, $d17f ; $704f
	set 1, [hl] ; $7052
	ld a, [$d183] ; $7054
	ld [$d184], a ; $7057
	call Func_1d_7373 ; $705a
	call Func_1d_7102 ; $705d
	jp Func_1d_6f3e ; $7060
Label_1d_7063:
	ld hl, $d17f ; $7063
	res 1, [hl] ; $7066
	ld a, $a8 ; $7068
	ld [$d181], a ; $706a
	jp Func_1d_6f3e ; $706d
Label_1d_7070:
	call Func_1d_7102 ; $7070
	jp Func_1d_6f3e ; $7073
Label_1d_7076:
	ld a, $06 ; $7076
	ldh [$ff96], a ; $7078
	ldh [rWBK], a ; $707a
	ld a, [$d17f] ; $707c
	bit 0, a ; $707f
	jp nz, Func_1d_6f3e ; $7081
	ld hl, $d185 ; $7084
	inc [hl] ; $7087
	ld a, [$d184] ; $7088
	or a, a ; $708b
	jr nz, Label_1d_70c6 ; $708c
	call Func_1d_726d ; $708e
	or a, a ; $7091
	jr z, Label_1d_70b9 ; $7092
	sound $5f ; $7094
	ld a, $06 ; $7096
	ldh [$ff96], a ; $7098
	ldh [rWBK], a ; $709a
	ld a, [$d183] ; $709c
	or a, a ; $709f
	jr nz, Label_1d_70a5 ; $70a0
	call Func_1d_726d ; $70a2
Label_1d_70a5:
	ld hl, $d17f ; $70a5
	set 1, [hl] ; $70a8
	ld a, [$d183] ; $70aa
	ld [$d184], a ; $70ad
	call Func_1d_7373 ; $70b0
	call Func_1d_7133 ; $70b3
	jp Func_1d_6f3e ; $70b6
Label_1d_70b9:
	ld hl, $d17f ; $70b9
	res 1, [hl] ; $70bc
	ld a, $a8 ; $70be
	ld [$d181], a ; $70c0
	jp Label_1d_7453 ; $70c3
Label_1d_70c6:
	call Func_1d_7133 ; $70c6
	jp Func_1d_6f3e ; $70c9
	ld a, $06 ; $70cc
	ldh [$ff96], a ; $70ce
	ldh [rWBK], a ; $70d0
	ld a, [$d180] ; $70d2
	dec a ; $70d5
	ld [$d180], a ; $70d6
	ret nz ; $70d9
	ld hl, $d17f ; $70da
	res 0, [hl] ; $70dd
	ld hl, $70cc ; $70df
	call Func_00_1bcb ; $70e2
	ret ; $70e5
	ld a, $06 ; $70e6
	ldh [$ff96], a ; $70e8
	ldh [rWBK], a ; $70ea
	ld a, [$d180] ; $70ec
	inc a ; $70ef
	ld [$d180], a ; $70f0
	cp a, $18 ; $70f3
	ret nz ; $70f5
	ld hl, $d17f ; $70f6
	res 0, [hl] ; $70f9
	ld hl, $70e6 ; $70fb
	call Func_00_1bcb ; $70fe
	ret ; $7101
Func_1d_7102:
	call Func_1d_7168 ; $7102
	ld a, $06 ; $7105
	ldh [$ff96], a ; $7107
	ldh [rWBK], a ; $7109
	ld a, [$d181] ; $710b
	cp a, $a8 ; $710e
	jr z, Label_1d_711f ; $7110
	sub a, b ; $7112
	ld [$d181], a ; $7113
	cp a, $18 ; $7116
	ret nc ; $7118
	ld a, $a8 ; $7119
	ld [$d181], a ; $711b
	ret ; $711e
Label_1d_711f:
	ld a, [$cb00] ; $711f
	or a, a ; $7122
	jr nz, Label_1d_712a ; $7123
	ld a, [$d164] ; $7125
	jr Label_1d_712d ; $7128
Label_1d_712a:
	ld a, [$d173] ; $712a
Label_1d_712d:
	add a, $36 ; $712d
	ld [$d181], a ; $712f
	ret ; $7132
Func_1d_7133:
	call Func_1d_7168 ; $7133
	ld a, $06 ; $7136
	ldh [$ff96], a ; $7138
	ldh [rWBK], a ; $713a
	ld a, [$d181] ; $713c
	cp a, $a8 ; $713f
	jr z, Label_1d_7162 ; $7141
	add a, b ; $7143
	ld [$d181], a ; $7144
	ld b, a ; $7147
	ld a, [$cb00] ; $7148
	or a, a ; $714b
	jr nz, Label_1d_7153 ; $714c
	ld a, [$d164] ; $714e
	jr Label_1d_7156 ; $7151
Label_1d_7153:
	ld a, [$d173] ; $7153
Label_1d_7156:
	add a, $36 ; $7156
	ld c, a ; $7158
	ld a, b ; $7159
	cp a, c ; $715a
	ret c ; $715b
	ld a, $a8 ; $715c
	ld [$d181], a ; $715e
	ret ; $7161
Label_1d_7162:
	ld a, $18 ; $7162
	ld [$d181], a ; $7164
	ret ; $7167
Func_1d_7168:
	ld a, $06 ; $7168
	ldh [$ff96], a ; $716a
	ldh [rWBK], a ; $716c
	ld a, [$cb00] ; $716e
	or a, a ; $7171
	jr nz, Label_1d_7179 ; $7172
	ld a, [$d164] ; $7174
	jr Label_1d_717c ; $7177
Label_1d_7179:
	ld a, [$d173] ; $7179
Label_1d_717c:
	add a, $18 ; $717c
	srl a ; $717e
	srl a ; $7180
	srl a ; $7182
	srl a ; $7184
	inc a ; $7186
	ld b, a ; $7187
	ret ; $7188
Func_1d_7189:
	ld a, [wStoryModeMainCharacterOverworldSpriteColor] ; $7189
	ld de, $0101 ; $718c
	farcall FarPtr_1b_02 ; $718f
	ld a, [wStoryModePartnerCharacterOverworldSpriteColor] ; $7192
	ld de, $0201 ; $7195
	farcall FarPtr_1b_02 ; $7198
	ld a, $06 ; $719b
	ldh [$ff96], a ; $719d
	ldh [rWBK], a ; $719f
	ld a, [$d16b] ; $71a1
	ld [$c13a], a ; $71a4
	ld a, [$d16c] ; $71a7
	ld [$c13b], a ; $71aa
	ld a, [$d17a] ; $71ad
	ld [$c122], a ; $71b0
	ld a, [$d17b] ; $71b3
	ld [$c123], a ; $71b6
	ld a, [$cb00] ; $71b9
	or a, a ; $71bc
	jr nz, Label_1d_71e2 ; $71bd
	ld hl, $c110 ; $71bf
	call Func_1d_7205 ; $71c2
	ld hl, $c112 ; $71c5
	call Func_1d_7205 ; $71c8
	ld hl, $c114 ; $71cb
	call Func_1d_7205 ; $71ce
	ld hl, $c116 ; $71d1
	call Func_1d_7205 ; $71d4
	ld a, $08 ; $71d7
	ld [$c122], a ; $71d9
	ld a, $21 ; $71dc
	ld [$c123], a ; $71de
	ret ; $71e1
Label_1d_71e2:
	ld hl, $c108 ; $71e2
	call Func_1d_7205 ; $71e5
	ld hl, $c10a ; $71e8
	call Func_1d_7205 ; $71eb
	ld hl, $c10c ; $71ee
	call Func_1d_7205 ; $71f1
	ld hl, $c10e ; $71f4
	call Func_1d_7205 ; $71f7
	ld a, $08 ; $71fa
	ld [$c13a], a ; $71fc
	ld a, $21 ; $71ff
	ld [$c13b], a ; $7201
	ret ; $7204
Func_1d_7205:
	ld a, [hl+] ; $7205
	ld d, [hl] ; $7206
	ld e, a ; $7207
	call Func_1d_7210 ; $7208
	dec hl ; $720b
	ld a, e ; $720c
	ld [hl+], a ; $720d
	ld [hl], d ; $720e
	ret ; $720f
Func_1d_7210:
	push hl ; $7210
	ldh a, [$ff96] ; $7211
	push af ; $7213
	ld a, $01 ; $7214
	ldh [$ff96], a ; $7216
	ldh [rWBK], a ; $7218
	ld a, e ; $721a
	and a, $1f ; $721b
	ld [$d000], a ; $721d
	ld a, d ; $7220
	and a, $03 ; $7221
	rlca ; $7223
	rlca ; $7224
	ld [$d001], a ; $7225
	ld a, e ; $7228
	and a, $e0 ; $7229
	rlca ; $722b
	rlca ; $722c
	rlca ; $722d
	ld b, a ; $722e
	ld a, [$d001] ; $722f
	or a, b ; $7232
	ld [$d001], a ; $7233
	ld a, d ; $7236
	and a, $7c ; $7237
	rrca ; $7239
	rrca ; $723a
	ld [$0002], a ; $723b
	ld a, [$d000] ; $723e
	ld hl, $d001 ; $7241
	add a, [hl] ; $7244
	inc hl ; $7245
	add a, [hl] ; $7246
	srl a ; $7247
	and a, $1f ; $7249
	ld [$d003], a ; $724b
	ld e, a ; $724e
	rrca ; $724f
	rrca ; $7250
	rrca ; $7251
	and a, $e0 ; $7252
	or a, e ; $7254
	ld e, a ; $7255
	ld a, [$d003] ; $7256
	rrca ; $7259
	rrca ; $725a
	rrca ; $725b
	and a, $03 ; $725c
	ld d, a ; $725e
	ld a, [$d003] ; $725f
	rlca ; $7262
	rlca ; $7263
	or a, d ; $7264
	ld d, a ; $7265
	pop af ; $7266
	ldh [$ff96], a ; $7267
	ldh [rWBK], a ; $7269
	pop hl ; $726b
	ret ; $726c
Func_1d_726d:
	ld a, $06 ; $726d
	ldh [$ff96], a ; $726f
	ldh [rWBK], a ; $7271
	ld a, [$d14e] ; $7273
	ld d, a ; $7276
	ld a, [$d14f] ; $7277
	or a, d ; $727a
	ld a, $00 ; $727b
	ret z ; $727d
	ld hl, $d14e ; $727e
	ld a, [hl+] ; $7281
	ld d, [hl] ; $7282
	ld e, a ; $7283
	dec de ; $7284
	dec hl ; $7285
	ld a, e ; $7286
	ld [hl+], a ; $7287
	ld [hl], d ; $7288
	ld a, [$cb00] ; $7289
	or a, a ; $728c
	jr nz, Label_1d_72b6 ; $728d
	ld hl, $d167 ; $728f
	ld a, [hl+] ; $7292
	ld d, [hl] ; $7293
	ld e, a ; $7294
	inc de ; $7295
	dec hl ; $7296
	ld a, e ; $7297
	ld [hl+], a ; $7298
	ld [hl], d ; $7299
	ld hl, $d165 ; $729a
	ld a, [hl+] ; $729d
	ld d, [hl] ; $729e
	ld e, a ; $729f
	inc de ; $72a0
	dec hl ; $72a1
	ld a, e ; $72a2
	ld [hl+], a ; $72a3
	ld [hl], d ; $72a4
	ld hl, $d169 ; $72a5
	ld a, [hl+] ; $72a8
	ld d, [hl] ; $72a9
	ld e, a ; $72aa
	dec de ; $72ab
	dec hl ; $72ac
	ld a, e ; $72ad
	ld [hl+], a ; $72ae
	ld [hl], d ; $72af
	call Func_1d_737d ; $72b0
	ld a, $01 ; $72b3
	ret ; $72b5
Label_1d_72b6:
	ld hl, $d176 ; $72b6
	ld a, [hl+] ; $72b9
	ld d, [hl] ; $72ba
	ld e, a ; $72bb
	inc de ; $72bc
	dec hl ; $72bd
	ld a, e ; $72be
	ld [hl+], a ; $72bf
	ld [hl], d ; $72c0
	ld hl, $d174 ; $72c1
	ld a, [hl+] ; $72c4
	ld d, [hl] ; $72c5
	ld e, a ; $72c6
	inc de ; $72c7
	dec hl ; $72c8
	ld a, e ; $72c9
	ld [hl+], a ; $72ca
	ld [hl], d ; $72cb
	ld hl, $d178 ; $72cc
	ld a, [hl+] ; $72cf
	ld d, [hl] ; $72d0
	ld e, a ; $72d1
	dec de ; $72d2
	dec hl ; $72d3
	ld a, e ; $72d4
	ld [hl+], a ; $72d5
	ld [hl], d ; $72d6
	call Func_1d_737d ; $72d7
	ld a, $01 ; $72da
	ret ; $72dc
Func_1d_72dd:
	ld a, $06 ; $72dd
	ldh [$ff96], a ; $72df
	ldh [rWBK], a ; $72e1
	ld a, [$cb00] ; $72e3
	or a, a ; $72e6
	jr nz, Label_1d_7313 ; $72e7
	ld hl, $d167 ; $72e9
	ld a, [hl+] ; $72ec
	ld d, [hl] ; $72ed
	ld e, a ; $72ee
	ld a, d ; $72ef
	or a, e ; $72f0
	jr z, Label_1d_7349 ; $72f1
	dec de ; $72f3
	dec hl ; $72f4
	ld a, e ; $72f5
	ld [hl+], a ; $72f6
	ld [hl], d ; $72f7
	ld hl, $d165 ; $72f8
	ld a, [hl+] ; $72fb
	ld d, [hl] ; $72fc
	ld e, a ; $72fd
	dec de ; $72fe
	dec hl ; $72ff
	ld a, e ; $7300
	ld [hl+], a ; $7301
	ld [hl], d ; $7302
	ld hl, $d169 ; $7303
	ld a, [hl+] ; $7306
	ld d, [hl] ; $7307
	ld e, a ; $7308
	inc de ; $7309
	dec hl ; $730a
	ld a, e ; $730b
	ld [hl+], a ; $730c
	ld [hl], d ; $730d
	call Func_1d_73e7 ; $730e
	jr Label_1d_733b ; $7311
Label_1d_7313:
	ld hl, $d176 ; $7313
	ld a, [hl+] ; $7316
	ld d, [hl] ; $7317
	ld e, a ; $7318
	ld a, d ; $7319
	or a, e ; $731a
	jr z, Label_1d_7349 ; $731b
	dec de ; $731d
	dec hl ; $731e
	ld a, e ; $731f
	ld [hl+], a ; $7320
	ld [hl], d ; $7321
	ld hl, $d174 ; $7322
	ld a, [hl+] ; $7325
	ld d, [hl] ; $7326
	ld e, a ; $7327
	dec de ; $7328
	dec hl ; $7329
	ld a, e ; $732a
	ld [hl+], a ; $732b
	ld [hl], d ; $732c
	ld hl, $d178 ; $732d
	ld a, [hl+] ; $7330
	ld d, [hl] ; $7331
	ld e, a ; $7332
	inc de ; $7333
	dec hl ; $7334
	ld a, e ; $7335
	ld [hl+], a ; $7336
	ld [hl], d ; $7337
	call Func_1d_73e7 ; $7338
Label_1d_733b:
	ld hl, $d14e ; $733b
	ld a, [hl+] ; $733e
	ld d, [hl] ; $733f
	ld e, a ; $7340
	inc de ; $7341
	dec hl ; $7342
	ld a, e ; $7343
	ld [hl+], a ; $7344
	ld [hl], d ; $7345
	ld a, $01 ; $7346
	ret ; $7348
Label_1d_7349:
	xor a, a ; $7349
	ret ; $734a
Func_1d_734b:
	ld a, $03 ; $734b
	ldh [$ff96], a ; $734d
	ldh [rWBK], a ; $734f
	ld hl, $d020 ; $7351
	ld de, $9820 ; $7354
	ld c, $16 ; $7357
	call Func_00_0480 ; $7359
	ld hl, $d1a0 ; $735c
	ld de, $99a0 ; $735f
	ld c, $04 ; $7362
	call Func_00_0480 ; $7364
	ld hl, $d200 ; $7367
	ld de, $9a00 ; $736a
	ld c, $01 ; $736d
	call Func_00_0480 ; $736f
	ret ; $7372
Func_1d_7373:
	call Func_1d_6ace ; $7373
	call Func_1d_6de7 ; $7376
	call Func_1d_6ea2 ; $7379
	ret ; $737c
Func_1d_737d:
	ld a, $06 ; $737d
	ldh [$ff96], a ; $737f
	ldh [rWBK], a ; $7381
	ld a, [$cb00] ; $7383
	or a, a ; $7386
	jr nz, Label_1d_73b8 ; $7387
	ld hl, $d169 ; $7389
	ld a, [hl+] ; $738c
	ld d, [hl] ; $738d
	ld e, a ; $738e
	ld a, d ; $738f
	or a, e ; $7390
	ret nz ; $7391
	ld a, $ff ; $7392
	ld [$d186], a ; $7394
	ld a, [$d161] ; $7397
	inc a ; $739a
	ld [$d161], a ; $739b
	dec a ; $739e
	farcall FarPtr_02_30 ; $739f
	ld a, l ; $73a2
	ld [$d162], a ; $73a3
	ld [$d169], a ; $73a6
	ld a, h ; $73a9
	ld [$d163], a ; $73aa
	ld [$d16a], a ; $73ad
	xor a, a ; $73b0
	ld [$d165], a ; $73b1
	ld [$d166], a ; $73b4
	ret ; $73b7
Label_1d_73b8:
	ld hl, $d178 ; $73b8
	ld a, [hl+] ; $73bb
	ld d, [hl] ; $73bc
	ld e, a ; $73bd
	ld a, d ; $73be
	or a, e ; $73bf
	ret nz ; $73c0
	ld a, $ff ; $73c1
	ld [$d186], a ; $73c3
	ld a, [$d170] ; $73c6
	inc a ; $73c9
	ld [$d170], a ; $73ca
	dec a ; $73cd
	farcall FarPtr_02_30 ; $73ce
	ld a, l ; $73d1
	ld [$d171], a ; $73d2
	ld [$d178], a ; $73d5
	ld a, h ; $73d8
	ld [$d172], a ; $73d9
	ld [$d179], a ; $73dc
	xor a, a ; $73df
	ld [$d174], a ; $73e0
	ld [$d175], a ; $73e3
	ret ; $73e6
Func_1d_73e7:
	ld a, $06 ; $73e7
	ldh [$ff96], a ; $73e9
	ldh [rWBK], a ; $73eb
	ld a, [$cb00] ; $73ed
	or a, a ; $73f0
	jr nz, Label_1d_7423 ; $73f1
	ld hl, $d165 ; $73f3
	ld a, [hl+] ; $73f6
	ld d, [hl] ; $73f7
	ld e, a ; $73f8
	inc de ; $73f9
	ld a, d ; $73fa
	or a, e ; $73fb
	ret nz ; $73fc
	ld a, [$d161] ; $73fd
	dec a ; $7400
	ld [$d161], a ; $7401
	dec a ; $7404
	farcall FarPtr_02_30 ; $7405
	ld a, l ; $7408
	ld [$d162], a ; $7409
	ld a, h ; $740c
	ld [$d163], a ; $740d
	dec hl ; $7410
	ld a, l ; $7411
	ld [$d165], a ; $7412
	ld a, h ; $7415
	ld [$d166], a ; $7416
	ld a, $01 ; $7419
	ld [$d169], a ; $741b
	dec a ; $741e
	ld [$d16a], a ; $741f
	ret ; $7422
Label_1d_7423:
	ld hl, $d174 ; $7423
	ld a, [hl+] ; $7426
	ld d, [hl] ; $7427
	ld e, a ; $7428
	inc de ; $7429
	ld a, d ; $742a
	or a, e ; $742b
	ret nz ; $742c
	ld a, [$d170] ; $742d
	dec a ; $7430
	ld [$d170], a ; $7431
	dec a ; $7434
	farcall FarPtr_02_30 ; $7435
	ld a, l ; $7438
	ld [$d171], a ; $7439
	ld a, h ; $743c
	ld [$d172], a ; $743d
	dec hl ; $7440
	ld a, l ; $7441
	ld [$d174], a ; $7442
	ld a, h ; $7445
	ld [$d175], a ; $7446
	ld a, $01 ; $7449
	ld [$d178], a ; $744b
	dec a ; $744e
	ld [$d179], a ; $744f
	ret ; $7452
Label_1d_7453:
	ld a, $06 ; $7453
	ldh [$ff96], a ; $7455
	ldh [rWBK], a ; $7457
	ld hl, $d17f ; $7459
	set 2, [hl] ; $745c
	ld a, $06 ; $745e
	ldh [$ff96], a ; $7460
	ldh [rWBK], a ; $7462
	ld a, [$d16b] ; $7464
	ld [$c13a], a ; $7467
	ld a, [$d16c] ; $746a
	ld [$c13b], a ; $746d
	ld a, [$d17a] ; $7470
	ld [$c122], a ; $7473
	ld a, [$d17b] ; $7476
	ld [$c123], a ; $7479
	ld a, [wStoryModeMainCharacterOverworldSpriteColor] ; $747c
	ld de, $0101 ; $747f
	farcall FarPtr_1b_02 ; $7482
	ld a, [wStoryModePartnerCharacterOverworldSpriteColor] ; $7485
	ld de, $0201 ; $7488
	farcall FarPtr_1b_02 ; $748b
	ld hl, $ff9d ; $748e
	set 0, [hl] ; $7491
	sound $5f ; $7493
	farcall FarPtr_1c_08 ; $7495
	ld hl, $781d ; $7498
	ld bc, $d240 ; $749b
	call Func_1d_7610 ; $749e
	call Func_1d_7505 ; $74a1
	call Func_00_2725 ; $74a4
	ld [bc], a ; $74a7
	ld hl, $7814 ; $74a8
	ld bc, $d240 ; $74ab
	call Func_1d_7610 ; $74ae
	call Func_1d_7505 ; $74b1
	call Func_00_2725 ; $74b4
	ld [bc], a ; $74b7
	ld hl, $7807 ; $74b8
	ld bc, $d240 ; $74bb
	call Func_1d_7610 ; $74be
	call Func_1d_7505 ; $74c1
	call Func_00_2725 ; $74c4
	ld [bc], a ; $74c7
	ld hl, $77f6 ; $74c8
	ld bc, $d240 ; $74cb
	call Func_1d_7610 ; $74ce
	call Func_1d_7505 ; $74d1
	call Func_00_2725 ; $74d4
	ld [bc], a ; $74d7
	ld hl, $77e1 ; $74d8
	ld bc, $d240 ; $74db
	call Func_1d_7610 ; $74de
	call Func_1d_7505 ; $74e1
	call Func_00_2725 ; $74e4
	ld [bc], a ; $74e7
	ld hl, $77c8 ; $74e8
	ld bc, $d240 ; $74eb
	call Func_1d_7610 ; $74ee
	call Func_1d_7505 ; $74f1
	call Func_00_2725 ; $74f4
	inc c ; $74f7
	ld a, $06 ; $74f8
	ldh [$ff96], a ; $74fa
	ldh [rWBK], a ; $74fc
	ld a, $01 ; $74fe
	ld [$d182], a ; $7500
	jr Label_1d_7528 ; $7503
Func_1d_7505:
	ld a, $03 ; $7505
	ldh [$ff96], a ; $7507
	ldh [rWBK], a ; $7509
	ld hl, $d180 ; $750b
	ld de, $9980 ; $750e
	ld c, $0c ; $7511
	call Func_00_0480 ; $7513
	ld a, $02 ; $7516
	ldh [$ff96], a ; $7518
	ldh [rWBK], a ; $751a
	ld hl, $d180 ; $751c
	ld de, $b980 ; $751f
	ld c, $0c ; $7522
	call Func_00_0480 ; $7524
	ret ; $7527
Label_1d_7528:
	call Func_1d_7568 ; $7528
	call Func_1d_77a7 ; $752b
	call Func_00_2631 ; $752e
	ldh a, [$ff94] ; $7531
	bit 6, a ; $7533
	jr nz, Label_1d_757f ; $7535
	bit 7, a ; $7537
	jr nz, Label_1d_757f ; $7539
	bit 0, a ; $753b
	jr nz, Label_1d_758b ; $753d
	bit 1, a ; $753f
	jr nz, Label_1d_7594 ; $7541
	jr Label_1d_7528 ; $7543
Func_1d_7545:
	ld a, $03 ; $7545
	ldh [$ff96], a ; $7547
	ldh [rWBK], a ; $7549
	ld hl, $d180 ; $754b
	ld de, $9980 ; $754e
	ld c, $0c ; $7551
	call Func_00_0480 ; $7553
	ld a, $02 ; $7556
	ldh [$ff96], a ; $7558
	ldh [rWBK], a ; $755a
	ld hl, $d180 ; $755c
	ld de, $b980 ; $755f
	ld c, $0c ; $7562
	call Func_00_0480 ; $7564
	ret ; $7567
Func_1d_7568:
	ldh a, [$ff8c] ; $7568
	and a, $08 ; $756a
	ret z ; $756c
	ld bc, $0816 ; $756d
	ld de, $0c7f ; $7570
	ld a, [$d182] ; $7573
	or a, a ; $7576
	jr z, Label_1d_757b ; $7577
	ld e, $87 ; $7579
Label_1d_757b:
	call Func_00_1f51 ; $757b
	ret ; $757e
Label_1d_757f:
	sound $5e ; $757f
	ld a, [$d182] ; $7581
	xor a, $01 ; $7584
	ld [$d182], a ; $7586
	jr Label_1d_7528 ; $7589
Label_1d_758b:
	ld a, [$d182] ; $758b
	or a, a ; $758e
	jr nz, Label_1d_7594 ; $758f
	sound $5f ; $7591
	ret ; $7593
Label_1d_7594:
	sound $62 ; $7594
	farcall FarPtr_1c_0a ; $7596
	ld hl, $77e1 ; $7599
	ld bc, $d240 ; $759c
	call Func_1d_7610 ; $759f
	call Func_1d_7545 ; $75a2
	call Func_00_2725 ; $75a5
	ld [bc], a ; $75a8
	farcall FarPtr_1c_0a ; $75a9
	ld hl, $77f6 ; $75ac
	ld bc, $d240 ; $75af
	call Func_1d_7610 ; $75b2
	call Func_1d_7545 ; $75b5
	call Func_00_2725 ; $75b8
	ld [bc], a ; $75bb
	farcall FarPtr_1c_0a ; $75bc
	ld hl, $7807 ; $75bf
	ld bc, $d240 ; $75c2
	call Func_1d_7610 ; $75c5
	call Func_1d_7545 ; $75c8
	call Func_00_2725 ; $75cb
	ld [bc], a ; $75ce
	farcall FarPtr_1c_0a ; $75cf
	ld hl, $7814 ; $75d2
	ld bc, $d240 ; $75d5
	call Func_1d_7610 ; $75d8
	call Func_1d_7545 ; $75db
	call Func_00_2725 ; $75de
	ld [bc], a ; $75e1
	farcall FarPtr_1c_0a ; $75e2
	ld hl, $781d ; $75e5
	ld bc, $d240 ; $75e8
	call Func_1d_7610 ; $75eb
	call Func_1d_7545 ; $75ee
	call Func_00_2725 ; $75f1
	ld [bc], a ; $75f4
	farcall FarPtr_1c_0a ; $75f5
	call Func_1d_7545 ; $75f8
	call Func_00_2725 ; $75fb
	ld [bc], a ; $75fe
	ld a, $06 ; $75ff
	ldh [$ff96], a ; $7601
	ldh [rWBK], a ; $7603
	ld hl, $d17f ; $7605
	res 2, [hl] ; $7608
	call Func_1d_7189 ; $760a
	jp Func_1d_6f3e ; $760d
Func_1d_7610:
	ld a, [hl] ; $7610
	cp a, $ff ; $7611
	ret z ; $7613
	push hl ; $7614
	ld d, [hl] ; $7615
	inc hl ; $7616
	ld e, [hl] ; $7617
	push hl ; $7618
	ld hl, $d000 ; $7619
	add hl, de ; $761c
	ld d, h ; $761d
	ld e, l ; $761e
	pop hl ; $761f
	inc hl ; $7620
	push hl ; $7621
	ld a, [hl] ; $7622
	ld h, b ; $7623
	ld l, c ; $7624
	add a, l ; $7625
	ld l, a ; $7626
	jr nc, Label_1d_762a ; $7627
	inc h ; $7629
Label_1d_762a:
	ld a, $06 ; $762a
	ldh [$ff96], a ; $762c
	ldh [rWBK], a ; $762e
	ld a, l ; $7630
	ld [$d08e], a ; $7631
	ld a, h ; $7634
	ld [$d08f], a ; $7635
	pop hl ; $7638
	push bc ; $7639
	inc hl ; $763a
	ld c, [hl] ; $763b
	ld hl, $d08e ; $763c
	ld a, [hl+] ; $763f
	ld h, [hl] ; $7640
	ld l, a ; $7641
Label_1d_7642:
	ld a, $03 ; $7642
	ldh [$ff96], a ; $7644
	ldh [rWBK], a ; $7646
	ld a, [hl] ; $7648
	ld [de], a ; $7649
	ld a, $02 ; $764a
	ldh [$ff96], a ; $764c
	ldh [rWBK], a ; $764e
	ld a, [hl+] ; $7650
	ld [de], a ; $7651
	inc de ; $7652
	dec c ; $7653
	jr nz, Label_1d_7642 ; $7654
	pop bc ; $7656
	pop hl ; $7657
	inc hl ; $7658
	inc hl ; $7659
	inc hl ; $765a
	inc hl ; $765b
	jr Func_1d_7610 ; $765c
	ld a, $06 ; $765e
	ldh [$ff96], a ; $7660
	ldh [rWBK], a ; $7662
	ld a, [$d17f] ; $7664
	bit 0, a ; $7667
	ret nz ; $7669
	bit 2, a ; $766a
	ret nz ; $766c
	ld a, [$d0b6] ; $766d
	or a, a ; $7670
	ret nz ; $7671
	ld a, [$cb00] ; $7672
	or a, a ; $7675
	jr nz, Label_1d_76cb ; $7676
	ld a, $06 ; $7678
	ldh [$ff96], a ; $767a
	ldh [rWBK], a ; $767c
	ld a, [$d161] ; $767e
	cp a, $64 ; $7681
	ret nc ; $7683
	ld hl, $d169 ; $7684
	ld a, [hl+] ; $7687
	ld h, [hl] ; $7688
	ld l, a ; $7689
	ld a, $03 ; $768a
	ld de, $d08e ; $768c
	call Func_00_1a27 ; $768f
	ld a, [$d08e] ; $7692
	cp a, $20 ; $7695
	jr z, Label_1d_76a2 ; $7697
	call Func_1d_771e ; $7699
	ld de, $182f ; $769c
	call Func_00_1f51 ; $769f
Label_1d_76a2:
	ld a, [$d08f] ; $76a2
	cp a, $20 ; $76a5
	jr z, Label_1d_76b2 ; $76a7
	call Func_1d_771e ; $76a9
	ld de, $1f2f ; $76ac
	call Func_00_1f51 ; $76af
Label_1d_76b2:
	ld a, [$d090] ; $76b2
	call Func_1d_771e ; $76b5
	ld de, $262f ; $76b8
	call Func_00_1f51 ; $76bb
	ld hl, $7b59 ; $76be
	ld bc, $0e2c ; $76c1
	ld de, $142e ; $76c4
	call Func_00_1e9d ; $76c7
	ret ; $76ca
Label_1d_76cb:
	ld a, $06 ; $76cb
	ldh [$ff96], a ; $76cd
	ldh [rWBK], a ; $76cf
	ld a, [$d170] ; $76d1
	cp a, $64 ; $76d4
	ret nc ; $76d6
	ld hl, $d178 ; $76d7
	ld a, [hl+] ; $76da
	ld h, [hl] ; $76db
	ld l, a ; $76dc
	ld a, $03 ; $76dd
	ld de, $d08e ; $76df
	call Func_00_1a27 ; $76e2
	ld a, [$d08e] ; $76e5
	cp a, $20 ; $76e8
	jr z, Label_1d_76f5 ; $76ea
	call Func_1d_771e ; $76ec
	ld de, $1862 ; $76ef
	call Func_00_1f51 ; $76f2
Label_1d_76f5:
	ld a, [$d08f] ; $76f5
	cp a, $20 ; $76f8
	jr z, Label_1d_7705 ; $76fa
	call Func_1d_771e ; $76fc
	ld de, $1f62 ; $76ff
	call Func_00_1f51 ; $7702
Label_1d_7705:
	ld a, [$d090] ; $7705
	call Func_1d_771e ; $7708
	ld de, $2662 ; $770b
	call Func_00_1f51 ; $770e
	ld hl, $7c7d ; $7711
	ld bc, $0e44 ; $7714
	ld de, $1461 ; $7717
	call Func_00_1e9d ; $771a
	ret ; $771d
Func_1d_771e:
	sub a, $30 ; $771e
	rlca ; $7720
	add a, $18 ; $7721
	ld c, a ; $7723
	ld b, $0e ; $7724
	ret ; $7726
	ld a, $06 ; $7727
	ldh [$ff96], a ; $7729
	ldh [rWBK], a ; $772b
	ld a, [$d180] ; $772d
	add a, $46 ; $7730
	ld l, a ; $7732
	adc a, $77 ; $7733
	sub a, l ; $7735
	ld h, a ; $7736
	ld a, [hl] ; $7737
	inc a ; $7738
	ld e, a ; $7739
	ld d, $19 ; $773a
	ld hl, $7930 ; $773c
	ld bc, $0e00 ; $773f
	call Func_00_1e9d ; $7742
	ret ; $7745
	INCBIN "data/bank_01d/d_7746.bin" ; $7746, 26 bytes
	ld a, $06 ; $7760
	ldh [$ff96], a ; $7762
	ldh [rWBK], a ; $7764
	ld de, $3801 ; $7766
	ld a, [$d164] ; $7769
	add a, d ; $776c
	ld d, a ; $776d
	ld hl, $797a ; $776e
	ld bc, $0f0c ; $7771
	call Func_00_1e9d ; $7774
	ld de, $3849 ; $7777
	ld a, [$d173] ; $777a
	add a, d ; $777d
	ld d, a ; $777e
	ld hl, $797a ; $777f
	ld bc, $0f0c ; $7782
	call Func_00_1e9d ; $7785
	ret ; $7788
	ld e, $01 ; $7789
	ld a, [$cb00] ; $778b
	or a, a ; $778e
	jr z, Label_1d_7793 ; $778f
	ld e, $49 ; $7791
Label_1d_7793:
	ld a, $06 ; $7793
	ldh [$ff96], a ; $7795
	ldh [rWBK], a ; $7797
	ld a, [$d181] ; $7799
	ld d, a ; $779c
	ld hl, $79b4 ; $779d
	ld bc, $0f10 ; $77a0
	call Func_00_1e9d ; $77a3
	ret ; $77a6
Func_1d_77a7:
	ld a, $06 ; $77a7
	ldh [$ff96], a ; $77a9
	ldh [rWBK], a ; $77ab
	ld a, [$d186] ; $77ad
	or a, a ; $77b0
	ret z ; $77b1
	cp a, $ff ; $77b2
	jr z, Label_1d_77be ; $77b4
	dec a ; $77b6
	ld [$d186], a ; $77b7
	ret nz ; $77ba
	sound $0c ; $77bb
	ret ; $77bd
Label_1d_77be:
	ld a, $a0 ; $77be
	ld [$d186], a ; $77c0
	sound $00 ; $77c3
	sound $2f ; $77c5
	ret ; $77c7
	INCBIN "data/bank_01d/d_77c8.bin" ; $77c8, 1254 bytes
Func_1d_7cae:
	push af ; $7cae
	push bc ; $7caf
	push de ; $7cb0
	push hl ; $7cb1
	ld a, $06 ; $7cb2
	ldh [$ff96], a ; $7cb4
	ldh [rWBK], a ; $7cb6
	ld hl, $d152 ; $7cb8
	ld bc, $000f ; $7cbb
	call ClearBytes ; $7cbe
	pop hl ; $7cc1
	pop de ; $7cc2
	pop bc ; $7cc3
	pop af ; $7cc4
	ret ; $7cc5
Func_1d_7cc6:
	ld a, $06 ; $7cc6
	ldh [$ff96], a ; $7cc8
	ldh [rWBK], a ; $7cca
	ld a, b ; $7ccc
	rlca ; $7ccd
	add a, $d9 ; $7cce
	ld l, a ; $7cd0
	adc a, $7c ; $7cd1
	sub a, l ; $7cd3
	ld h, a ; $7cd4
	ld a, [hl+] ; $7cd5
	ld h, [hl] ; $7cd6
	ld l, a ; $7cd7
	jp hl ; $7cd8
	INCBIN "data/bank_01d/d_7cd9.bin" ; $7cd9, 43 bytes
	ld a, c ; $7d04
	ld [$d15f], a ; $7d05
	ld hl, $d158 ; $7d08
	ld a, e ; $7d0b
	ld [hl+], a ; $7d0c
	ld [hl], d ; $7d0d
	ret ; $7d0e
	INCBIN "data/bank_01d/d_7d0f.bin" ; $7d0f, 11 bytes
	ds 742, $ff ; $7d1a, fill
