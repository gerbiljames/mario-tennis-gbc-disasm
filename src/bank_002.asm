INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $02", ROMX[$4000], BANK[$02]

	INCBIN "data/bank_002/d_4000.bin" ; $4000, 102 bytes
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
	rst Rst18 ; $410b
	ld c, [hl] ; $410c
	dec b ; $410d
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
	rst Rst18 ; $4244
	nop ; $4245
	INCBIN "data/bank_002/d_4246.bin" ; $4246, 1 bytes
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
	rst Rst18 ; $4281
	ld a, [de] ; $4282
	inc bc ; $4283
	cp a, $fe ; $4284
	jr z, Label_02_4291 ; $4286
	ld hl, $c880 ; $4288
	ld de, $d400 ; $428b
	call Func_02_42c9 ; $428e
Label_02_4291:
	ld a, $01 ; $4291
	ld [$c36c], a ; $4293
	rst Rst18 ; $4296
	ld a, [de] ; $4297
	inc bc ; $4298
	cp a, $fe ; $4299
	jr z, Label_02_42a6 ; $429b
	ld hl, $c880 ; $429d
	ld de, $d404 ; $42a0
	call Func_02_42c9 ; $42a3
Label_02_42a6:
	ld a, $02 ; $42a6
	ld [$c36c], a ; $42a8
	rst Rst18 ; $42ab
	ld a, [de] ; $42ac
	inc bc ; $42ad
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
	INCBIN "data/bank_002/d_42d6.bin" ; $42d6, 205 bytes
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
	rst Rst18 ; $43d7
	ld c, [hl] ; $43d8
	dec b ; $43d9
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
	INCBIN "data/bank_002/d_441b.bin" ; $441b, 121 bytes
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
	INCBIN "data/bank_002/d_46eb.bin" ; $46eb, 1389 bytes
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
	rst Rst18 ; $4cc4
	jr nz, $4cca ; $4cc5
	ret ; $4cc7
Label_02_4cc8:
	rst Rst18 ; $4cc8
	ld e, $03 ; $4cc9
	ret ; $4ccb
	INCBIN "data/bank_002/d_4ccc.bin" ; $4ccc, 8 bytes
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
	rst Rst18 ; $4ce2
	inc e ; $4ce3
	inc bc ; $4ce4
	jr z, Label_02_4cea ; $4ce5
	ld a, $01 ; $4ce7
	ret ; $4ce9
Label_02_4cea:
	ld a, $00 ; $4cea
	ret ; $4cec
	INCBIN "data/bank_002/d_4ced.bin" ; $4ced, 22 bytes
	ret ; $4d03
	INCBIN "data/bank_002/d_4d04.bin" ; $4d04, 12 bytes
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
	rst Rst18 ; $4d1e
	inc e ; $4d1f
	inc bc ; $4d20
	jr z, Label_02_4d26 ; $4d21
	ld a, $01 ; $4d23
	ret ; $4d25
Label_02_4d26:
	ld a, $00 ; $4d26
	ret ; $4d28
	INCBIN "data/bank_002/d_4d29.bin" ; $4d29, 1310 bytes
Func_02_5247:
	push de ; $5247
	ld hl, $c800 ; $5248
	ld b, a ; $524b
	ld c, a ; $524c
	push bc ; $524d
	ld [$c36c], a ; $524e
	rst Rst18 ; $5251
	ld a, [de] ; $5252
	inc bc ; $5253
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
