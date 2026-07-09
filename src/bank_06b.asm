INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $6b", ROMX[$4000], BANK[$6b]

	INCBIN "data/bank_06b/d_4000.bin" ; $4000, 42 bytes
	xor a, a ; $402a
	ld [$cb3f], a ; $402b
	ld [$cb40], a ; $402e
	ld [wIntroCutsceneCheck], a ; $4031
	ld [$cb42], a ; $4034
	ld [$cb43], a ; $4037
	ldh [$ff98], a ; $403a
	ld hl, rLCDC ; $403c
	res 3, [hl] ; $403f
	rst Rst08 ; $4041
	INCBIN "data/bank_06b/d_4042.bin" ; $4042, 1 bytes
	ld a, $01 ; $4043
	ld hl, $53f1 ; $4045
	call Func_00_1b6a ; $4048
	call Func_6b_406a ; $404b
	ld c, $7f ; $404e
	call Func_00_1d20 ; $4050
	call Func_00_1da4 ; $4053
	call Func_00_1b38 ; $4056
	ld hl, rIE ; $4059
	res 1, [hl] ; $405c
	xor a, a ; $405e
	ldh [$ff98], a ; $405f
	ld hl, rLCDC ; $4061
	res 3, [hl] ; $4064
	call Func_00_188b ; $4066
	ret ; $4069
Func_6b_406a:
	ld a, [$cb3f] ; $406a
	ld l, a ; $406d
	ld h, $00 ; $406e
	add hl, hl ; $4070
	ld de, $40bd ; $4071
	add hl, de ; $4074
	ld a, [hl+] ; $4075
	ld h, [hl] ; $4076
	ld l, a ; $4077
	ld a, [hl+] ; $4078
	ld h, [hl] ; $4079
	ld l, a ; $407a
	jp hl ; $407b
Label_6b_407c:
	ld a, [wIntroCutsceneCheck] ; $407c
	or a, a ; $407f
	jr nz, Label_6b_40bc ; $4080
	call Func_00_2631 ; $4082
	ld a, [$cb3f] ; $4085
	ld l, a ; $4088
	ld h, $00 ; $4089
	add hl, hl ; $408b
	ld de, $40bd ; $408c
	add hl, de ; $408f
	ld a, [hl+] ; $4090
	ld h, [hl] ; $4091
	ld l, a ; $4092
	inc hl ; $4093
	inc hl ; $4094
	ld a, [hl+] ; $4095
	ld h, [hl] ; $4096
	ld l, a ; $4097
	jp hl ; $4098
Label_6b_4099:
	ld a, [$cb3f] ; $4099
	ld l, a ; $409c
	ld h, $00 ; $409d
	add hl, hl ; $409f
	ld de, $40bd ; $40a0
	add hl, de ; $40a3
	ld a, [hl+] ; $40a4
	ld h, [hl] ; $40a5
	ld l, a ; $40a6
	inc hl ; $40a7
	inc hl ; $40a8
	inc hl ; $40a9
	inc hl ; $40aa
	ld a, [hl+] ; $40ab
	ld h, [hl] ; $40ac
	ld l, a ; $40ad
	jp hl ; $40ae
Label_6b_40af:
	ld a, [$cb3f] ; $40af
	inc a ; $40b2
	ld [$cb3f], a ; $40b3
	ld a, [wIntroCutsceneCheck] ; $40b6
	or a, a ; $40b9
	jr z, Func_6b_406a ; $40ba
Label_6b_40bc:
	ret ; $40bc
	INCBIN "data/bank_06b/d_40bd.bin" ; $40bd, 169 bytes
	ld a, $01 ; $4166
	ld [wIntroCutsceneCheck], a ; $4168
	jp Label_6b_407c ; $416b
	INCBIN "data/bank_06b/d_416e.bin" ; $416e, 3 bytes
	xor a, a ; $4171
	ld [$cb40], a ; $4172
	jp Label_6b_407c ; $4175
	xor a, a ; $4178
	ld [$cb40], a ; $4179
	jp Label_6b_40af ; $417c
	ld a, [$cb40] ; $417f
	inc a ; $4182
	ld [$cb40], a ; $4183
	cp a, $0a ; $4186
	jp z, Label_6b_4099 ; $4188
	jp Label_6b_407c ; $418b
	call Func_6b_54b9 ; $418e
	call Func_6b_6075 ; $4191
	xor a, a ; $4194
	ld [$c322], a ; $4195
	ld a, $24 ; $4198
	ld [$c323], a ; $419a
	xor a, a ; $419d
	ld [$cb40], a ; $419e
	ld [$cb4c], a ; $41a1
	ld [$cb44], a ; $41a4
	ld [$cb4d], a ; $41a7
	xor a, a ; $41aa
	ld [$c322], a ; $41ab
	ld a, $24 ; $41ae
	ld [$c323], a ; $41b0
	ld de, $015c ; $41b3
	ld hl, $cb48 ; $41b6
	ld a, e ; $41b9
	ld [hl+], a ; $41ba
	ld [hl], d ; $41bb
	ld de, $0120 ; $41bc
	ld hl, $cb4a ; $41bf
	ld a, e ; $41c2
	ld [hl+], a ; $41c3
	ld [hl], d ; $41c4
	call EnableLCD ; $41c5
	ld c, $20 ; $41c8
	call Func_00_1d2e ; $41ca
	call Func_00_1da4 ; $41cd
	jp Label_6b_407c ; $41d0
	ld c, $0a ; $41d3
	call Func_00_1d20 ; $41d5
	call Func_00_1da4 ; $41d8
	call Func_00_1b38 ; $41db
	ld a, $01 ; $41de
	ld hl, $53f1 ; $41e0
	call Func_00_1b6a ; $41e3
	xor a, a ; $41e6
	ldh [$ff8b], a ; $41e7
	ldh [$ff8a], a ; $41e9
	ld [$c320], a ; $41eb
	ld [$c321], a ; $41ee
	ld [$c322], a ; $41f1
	ld [$c323], a ; $41f4
	jp Label_6b_40af ; $41f7
	ld a, [$cb40] ; $41fa
	inc a ; $41fd
	ld [$cb40], a ; $41fe
	cp a, $80 ; $4201
	jp z, Label_6b_4099 ; $4203
	cp a, $64 ; $4206
	jr nc, Label_6b_420d ; $4208
	call Func_6b_6115 ; $420a
Label_6b_420d:
	call Func_6b_4d61 ; $420d
	call Func_6b_4c9e ; $4210
	call Func_6b_60d5 ; $4213
	call Func_6b_60f8 ; $4216
	call Func_6b_4e2d ; $4219
	jp Label_6b_407c ; $421c
	call DisableLCDSafely ; $421f
	xor a, a ; $4222
	ld [$cb42], a ; $4223
	ld [$cb40], a ; $4226
	ld a, $d0 ; $4229
	ld [$cb44], a ; $422b
	ld a, $28 ; $422e
	ld [$cb45], a ; $4230
	ld a, $30 ; $4233
	ld [$cb46], a ; $4235
	ld a, $28 ; $4238
	ld [$cb47], a ; $423a
	ld c, $16 ; $423d
	rst Rst18 ; $423f
	nop ; $4240
	add hl, sp ; $4241
	call Func_6b_520a ; $4242
	ldh a, [$ff96] ; $4245
	push af ; $4247
	ld a, $03 ; $4248
	ldh [$ff96], a ; $424a
	ldh [rWBK], a ; $424c
	ld h, $8a ; $424e
	ld de, $d560 ; $4250
	ld b, $20 ; $4253
	ld c, $01 ; $4255
	rst Rst18 ; $4257
	inc c ; $4258
	add hl, sp ; $4259
	pop af ; $425a
	ldh [$ff96], a ; $425b
	ldh [rWBK], a ; $425d
	rst Rst18 ; $425f
	ld [bc], a ; $4260
	add hl, sp ; $4261
	ld a, $01 ; $4262
	ldh [$ff96], a ; $4264
	ldh [rWBK], a ; $4266
	ld hl, $6c2a ; $4268
	ld de, $d000 ; $426b
	call DecompressDataFromBank ; $426e
	ld hl, $d000 ; $4271
	ld de, $9000 ; $4274
	ld c, $80 ; $4277
	call Func_00_0480 ; $4279
	ld hl, $d800 ; $427c
	ld de, $8800 ; $427f
	ld c, $80 ; $4282
	call Func_00_0480 ; $4284
	ld a, $03 ; $4287
	ldh [$ff96], a ; $4289
	ldh [rWBK], a ; $428b
	ld hl, $6c2c ; $428d
	ld de, $d800 ; $4290
	call DecompressDataFromBank ; $4293
	ld hl, $6c2e ; $4296
	ld de, $dc00 ; $4299
	call DecompressDataFromBank ; $429c
	ld a, $01 ; $429f
	ld hl, $526a ; $42a1
	call Func_00_1b6a ; $42a4
	call EnableLCD ; $42a7
	ld c, $40 ; $42aa
	call Func_00_1d2e ; $42ac
	jp Label_6b_407c ; $42af
	INCBIN "data/bank_06b/d_42b2.bin" ; $42b2, 64 bytes
	ld hl, $526a ; $42f2
	call Func_00_1bcb ; $42f5
	xor a, a ; $42f8
	ld [$cb40], a ; $42f9
	ld [$cb42], a ; $42fc
	ldh [$ff8b], a ; $42ff
	jp Label_6b_40af ; $4301
	ld a, [$cb42] ; $4304
	add a, $03 ; $4307
	ld [$cb42], a ; $4309
	ldh [$ff8b], a ; $430c
	ld a, [$cb40] ; $430e
	inc a ; $4311
	ld [$cb40], a ; $4312
	cp a, $69 ; $4315
	jr z, Label_6b_4323 ; $4317
	ld a, [$cb44] ; $4319
	inc a ; $431c
	ld [$cb44], a ; $431d
	jp Label_6b_407c ; $4320
Label_6b_4323:
	jp Label_6b_4099 ; $4323
	ldh a, [$ff96] ; $4326
	push af ; $4328
	ld a, $03 ; $4329
	ldh [$ff96], a ; $432b
	ldh [rWBK], a ; $432d
	ld hl, $d880 ; $432f
	ld de, $9880 ; $4332
	ld c, $0a ; $4335
	call Func_00_0480 ; $4337
	ld hl, $dc80 ; $433a
	ld de, $b880 ; $433d
	ld c, $0a ; $4340
	call Func_00_0480 ; $4342
	call Func_00_2631 ; $4345
	ld hl, $d920 ; $4348
	ld de, $9920 ; $434b
	ld c, $0a ; $434e
	call Func_00_0480 ; $4350
	ld hl, $dd20 ; $4353
	ld de, $b920 ; $4356
	ld c, $0a ; $4359
	call Func_00_0480 ; $435b
	pop af ; $435e
	ldh [$ff96], a ; $435f
	ldh [rWBK], a ; $4361
	ld hl, $436f ; $4363
	ld de, $0008 ; $4366
	call Func_00_05b5 ; $4369
	jp Label_6b_407c ; $436c
	INCBIN "data/bank_06b/d_436f.bin" ; $436f, 64 bytes
	ld c, $06 ; $43af
	call Func_00_1d20 ; $43b1
	call Func_00_1da4 ; $43b4
	xor a, a ; $43b7
	ld [$cb40], a ; $43b8
	jp Label_6b_40af ; $43bb
	ld a, [$cb40] ; $43be
	inc a ; $43c1
	ld [$cb40], a ; $43c2
	cp a, $1e ; $43c5
	jr z, Label_6b_43cc ; $43c7
	jp Label_6b_407c ; $43c9
Label_6b_43cc:
	jp Label_6b_4099 ; $43cc
	call DisableLCDSafely ; $43cf
	ld c, $17 ; $43d2
	rst Rst18 ; $43d4
	nop ; $43d5
	add hl, sp ; $43d6
	ldh a, [$ff96] ; $43d7
	push af ; $43d9
	ld a, $03 ; $43da
	ldh [$ff96], a ; $43dc
	ldh [rWBK], a ; $43de
	ld h, $8a ; $43e0
	ld de, $d560 ; $43e2
	ld b, $20 ; $43e5
	ld c, $01 ; $43e7
	rst Rst18 ; $43e9
	inc c ; $43ea
	add hl, sp ; $43eb
	pop af ; $43ec
	ldh [$ff96], a ; $43ed
	ldh [rWBK], a ; $43ef
	rst Rst18 ; $43f1
	ld [bc], a ; $43f2
	add hl, sp ; $43f3
	ld a, $01 ; $43f4
	ldh [$ff96], a ; $43f6
	ldh [rWBK], a ; $43f8
	ld hl, $6c32 ; $43fa
	ld de, $d000 ; $43fd
	call DecompressDataFromBank ; $4400
	ld hl, $d000 ; $4403
	ld de, $9000 ; $4406
	ld c, $80 ; $4409
	call Func_00_0480 ; $440b
	ld hl, $d800 ; $440e
	ld de, $8800 ; $4411
	ld c, $80 ; $4414
	call Func_00_0480 ; $4416
	ld a, $03 ; $4419
	ldh [$ff96], a ; $441b
	ldh [rWBK], a ; $441d
	ld hl, $6c34 ; $441f
	ld de, $d800 ; $4422
	call DecompressDataFromBank ; $4425
	ld hl, $6c36 ; $4428
	ld de, $dc00 ; $442b
	call DecompressDataFromBank ; $442e
	ld a, $01 ; $4431
	ld hl, $52f9 ; $4433
	call Func_00_1b6a ; $4436
	ld a, $a0 ; $4439
	ld [$cb46], a ; $443b
	ld a, $28 ; $443e
	ld [$cb47], a ; $4440
	xor a, a ; $4443
	ld [$cb43], a ; $4444
	call EnableLCD ; $4447
	ld c, $7f ; $444a
	call Func_00_1d2e ; $444c
	call Func_00_1da4 ; $444f
	jp Label_6b_407c ; $4452
	ld hl, $52f9 ; $4455
	call Func_00_1bcb ; $4458
	xor a, a ; $445b
	ld [$cb40], a ; $445c
	ld [$cb43], a ; $445f
	ldh [$ff8b], a ; $4462
	jp Label_6b_40af ; $4464
	ld a, [$cb40] ; $4467
	inc a ; $446a
	ld [$cb40], a ; $446b
	cp a, $7d ; $446e
	jp z, Label_6b_4099 ; $4470
	ld a, [$cb43] ; $4473
	sub a, $03 ; $4476
	ld [$cb43], a ; $4478
	ldh [$ff8b], a ; $447b
	ld a, [$cb46] ; $447d
	dec a ; $4480
	ld [$cb46], a ; $4481
	jp Label_6b_407c ; $4484
	ldh a, [$ff96] ; $4487
	push af ; $4489
	ld a, $03 ; $448a
	ldh [$ff96], a ; $448c
	ldh [rWBK], a ; $448e
	ld hl, $d880 ; $4490
	ld de, $9880 ; $4493
	ld c, $0a ; $4496
	call Func_00_0480 ; $4498
	ld hl, $dc80 ; $449b
	ld de, $b880 ; $449e
	ld c, $0a ; $44a1
	call Func_00_0480 ; $44a3
	call Func_00_2631 ; $44a6
	ld hl, $d920 ; $44a9
	ld de, $9920 ; $44ac
	ld c, $0a ; $44af
	call Func_00_0480 ; $44b1
	ld hl, $dd20 ; $44b4
	ld de, $b920 ; $44b7
	ld c, $0a ; $44ba
	call Func_00_0480 ; $44bc
	pop af ; $44bf
	ldh [$ff96], a ; $44c0
	ldh [rWBK], a ; $44c2
	ld hl, $44d0 ; $44c4
	ld de, $0008 ; $44c7
	call Func_00_05b5 ; $44ca
	jp Label_6b_407c ; $44cd
	INCBIN "data/bank_06b/d_44d0.bin" ; $44d0, 64 bytes
	ld c, $06 ; $4510
	call Func_00_1d20 ; $4512
	call Func_00_1da4 ; $4515
	xor a, a ; $4518
	ld [$cb40], a ; $4519
	jp Label_6b_40af ; $451c
	ld a, [$cb40] ; $451f
	inc a ; $4522
	ld [$cb40], a ; $4523
	cp a, $1e ; $4526
	jp z, Label_6b_4099 ; $4528
	jp Label_6b_407c ; $452b
	call DisableLCDSafely ; $452e
	ld c, $18 ; $4531
	rst Rst18 ; $4533
	nop ; $4534
	add hl, sp ; $4535
	ldh a, [$ff96] ; $4536
	push af ; $4538
	ld a, $03 ; $4539
	ldh [$ff96], a ; $453b
	ldh [rWBK], a ; $453d
	ld h, $8a ; $453f
	ld de, $d500 ; $4541
	ld b, $20 ; $4544
	ld c, $01 ; $4546
	rst Rst18 ; $4548
	inc c ; $4549
	add hl, sp ; $454a
	ld h, $8a ; $454b
	ld de, $d5c0 ; $454d
	ld b, $20 ; $4550
	ld c, $01 ; $4552
	rst Rst18 ; $4554
	inc c ; $4555
	add hl, sp ; $4556
	pop af ; $4557
	ldh [$ff96], a ; $4558
	ldh [rWBK], a ; $455a
	rst Rst18 ; $455c
	ld [bc], a ; $455d
	add hl, sp ; $455e
	ld c, $19 ; $455f
	rst Rst18 ; $4561
	nop ; $4562
	add hl, sp ; $4563
	ld a, $08 ; $4564
	ldh [rSTAT], a ; $4566
	ld hl, rIE ; $4568
	set 1, [hl] ; $456b
	ld a, $44 ; $456d
	ld [$cb02], a ; $456f
	ld a, $78 ; $4572
	ld [$cb03], a ; $4574
	xor a, a ; $4577
	ld [$cb01], a ; $4578
	ld a, $01 ; $457b
	ld hl, $53db ; $457d
	call Func_00_1b6a ; $4580
	ld a, $a0 ; $4583
	ld [$cb46], a ; $4585
	ld a, $40 ; $4588
	ld [$cb47], a ; $458a
	ld a, $c0 ; $458d
	ld [$cb44], a ; $458f
	ld a, $10 ; $4592
	ld [$cb45], a ; $4594
	ld a, $01 ; $4597
	ld hl, $526a ; $4599
	call Func_00_1b6a ; $459c
	ld a, $01 ; $459f
	ld hl, $52f9 ; $45a1
	call Func_00_1b6a ; $45a4
	call EnableLCD ; $45a7
	ld c, $10 ; $45aa
	call Func_00_1d2e ; $45ac
	call Func_00_1da4 ; $45af
	jp Label_6b_407c ; $45b2
	ld hl, rIE ; $45b5
	res 1, [hl] ; $45b8
	ldh a, [$ff96] ; $45ba
	push af ; $45bc
	ld a, $03 ; $45bd
	ldh [$ff96], a ; $45bf
	ldh [rWBK], a ; $45c1
	ld hl, $d060 ; $45c3
	ld de, $9860 ; $45c6
	ld c, $0c ; $45c9
	call Func_00_0480 ; $45cb
	ld hl, $d460 ; $45ce
	ld de, $b860 ; $45d1
	ld c, $0c ; $45d4
	call Func_00_0480 ; $45d6
	pop af ; $45d9
	ldh [$ff96], a ; $45da
	ldh [rWBK], a ; $45dc
	ld hl, $526a ; $45de
	call Func_00_1bcb ; $45e1
	ld hl, $53db ; $45e4
	call Func_00_1bcb ; $45e7
	xor a, a ; $45ea
	ldh [$ff8b], a ; $45eb
	call Func_00_2631 ; $45ed
	ldh a, [$ff96] ; $45f0
	push af ; $45f2
	ld a, $03 ; $45f3
	ldh [$ff96], a ; $45f5
	ldh [rWBK], a ; $45f7
	ld hl, $d120 ; $45f9
	ld de, $9920 ; $45fc
	ld c, $0c ; $45ff
	call Func_00_0480 ; $4601
	ld hl, $d520 ; $4604
	ld de, $b920 ; $4607
	ld c, $0c ; $460a
	call Func_00_0480 ; $460c
	pop af ; $460f
	ldh [$ff96], a ; $4610
	ldh [rWBK], a ; $4612
	ld hl, $52f9 ; $4614
	call Func_00_1bcb ; $4617
	call Func_00_2631 ; $461a
	jp Label_6b_40af ; $461d
	ld a, [$cb40] ; $4620
	inc a ; $4623
	ld [$cb40], a ; $4624
	cp a, $60 ; $4627
	jp z, Label_6b_4099 ; $4629
	ld a, [$cb44] ; $462c
	inc a ; $462f
	ld [$cb44], a ; $4630
	ld a, [$cb46] ; $4633
	dec a ; $4636
	ld [$cb46], a ; $4637
	jp Label_6b_407c ; $463a
	xor a, a ; $463d
	ld [$cb40], a ; $463e
	jp Label_6b_407c ; $4641
	ld c, $10 ; $4644
	call Func_00_1d20 ; $4646
	call Func_00_1da4 ; $4649
	jp Label_6b_40af ; $464c
	ld a, [$cb40] ; $464f
	inc a ; $4652
	ld [$cb40], a ; $4653
	cp a, $64 ; $4656
	jp z, Label_6b_4099 ; $4658
	jp Label_6b_407c ; $465b
	call Func_6b_617c ; $465e
	call Func_6b_73f2 ; $4661
	xor a, a ; $4664
	ld [$cb40], a ; $4665
	ld [$cb44], a ; $4668
	ld [$cb45], a ; $466b
	ld [$cb46], a ; $466e
	ld [$cb47], a ; $4671
	call EnableLCD ; $4674
	ld c, $08 ; $4677
	call Func_00_1d2e ; $4679
	call Func_00_1da4 ; $467c
	ld a, $01 ; $467f
	ld hl, $7083 ; $4681
	call Func_00_1b6a ; $4684
	jp Label_6b_407c ; $4687
	call Func_00_1b38 ; $468a
	ld a, $01 ; $468d
	ld hl, $53f1 ; $468f
	call Func_00_1b6a ; $4692
	xor a, a ; $4695
	ldh [$ff8b], a ; $4696
	ldh [$ff8a], a ; $4698
	ld [$c320], a ; $469a
	ld [$c321], a ; $469d
	ld [$c322], a ; $46a0
	ld [$c323], a ; $46a3
	jp Label_6b_40af ; $46a6
	ld a, [$c321] ; $46a9
	cp a, $40 ; $46ac
	jp nz, Label_6b_46c0 ; $46ae
	ld a, [$cb40] ; $46b1
	inc a ; $46b4
	ld [$cb40], a ; $46b5
	cp a, $29 ; $46b8
	jp z, Label_6b_4099 ; $46ba
	jp Label_6b_407c ; $46bd
Label_6b_46c0:
	ld a, [$cb40] ; $46c0
	cp a, $01 ; $46c3
	jr z, Label_6b_46ce ; $46c5
	inc a ; $46c7
	ld [$cb40], a ; $46c8
	jp Label_6b_407c ; $46cb
Label_6b_46ce:
	ld a, [$c321] ; $46ce
	ld h, a ; $46d1
	ld a, [$c320] ; $46d2
	ld l, a ; $46d5
	ld bc, $0020 ; $46d6
	add hl, bc ; $46d9
	ld a, h ; $46da
	ld [$c321], a ; $46db
	ld a, l ; $46de
	ld [$c320], a ; $46df
	jp Label_6b_407c ; $46e2
	xor a, a ; $46e5
	ldh [$ff8a], a ; $46e6
	ldh [$ff8b], a ; $46e8
	ld [$cb40], a ; $46ea
	ldh a, [$ff96] ; $46ed
	push af ; $46ef
	ld a, $05 ; $46f0
	ldh [$ff96], a ; $46f2
	ldh [rWBK], a ; $46f4
	ld hl, $475a ; $46f6
	ld de, $0008 ; $46f9
	call Func_00_05b0 ; $46fc
	ld hl, $d0c0 ; $46ff
	ld de, $98c0 ; $4702
	ld c, $10 ; $4705
	call Func_00_0480 ; $4707
	ld hl, $d4c0 ; $470a
	ld de, $b8c0 ; $470d
	ld c, $10 ; $4710
	call Func_00_0480 ; $4712
	call Func_00_2631 ; $4715
	ld hl, $d080 ; $4718
	ld de, $9880 ; $471b
	ld c, $04 ; $471e
	call Func_00_0480 ; $4720
	ld hl, $d480 ; $4723
	ld de, $b880 ; $4726
	ld c, $04 ; $4729
	call Func_00_0480 ; $472b
	call Func_00_2631 ; $472e
	pop af ; $4731
	ldh [$ff96], a ; $4732
	ldh [rWBK], a ; $4734
	jp Label_6b_407c ; $4736
	ld c, $10 ; $4739
	call Func_00_1d20 ; $473b
	call Func_00_1da4 ; $473e
	call DisableLCDSafely ; $4741
	xor a, a ; $4744
	ld [$cb40], a ; $4745
	jp Label_6b_40af ; $4748
	ld a, [$cb40] ; $474b
	inc a ; $474e
	ld [$cb40], a ; $474f
	cp a, $64 ; $4752
	jp z, Label_6b_4099 ; $4754
	jp Label_6b_407c ; $4757
	INCBIN "data/bank_06b/d_475a.bin" ; $475a, 64 bytes
	call DisableLCDSafely ; $479a
	ld c, $1c ; $479d
	rst Rst18 ; $479f
	nop ; $47a0
	add hl, sp ; $47a1
	rst Rst18 ; $47a2
	ld [bc], a ; $47a3
	add hl, sp ; $47a4
	xor a, a ; $47a5
	ld [$cb40], a ; $47a6
	ld a, $b0 ; $47a9
	ld [$cb42], a ; $47ab
	ld a, $01 ; $47ae
	ld hl, $7366 ; $47b0
	call Func_00_1b6a ; $47b3
	call EnableLCD ; $47b6
	ld c, $10 ; $47b9
	call Func_00_1d2e ; $47bb
	call Func_00_1da4 ; $47be
	jp Label_6b_407c ; $47c1
	ld c, $0a ; $47c4
	call Func_00_1d20 ; $47c6
	call Func_00_1da4 ; $47c9
	ld hl, $7366 ; $47cc
	call Func_00_1bcb ; $47cf
	xor a, a ; $47d2
	ldh [$ff8b], a ; $47d3
	jp Label_6b_40af ; $47d5
	ld a, [$cb40] ; $47d8
	inc a ; $47db
	ld [$cb40], a ; $47dc
	cp a, $2c ; $47df
	jp z, Label_6b_4099 ; $47e1
	jp Label_6b_407c ; $47e4
	call DisableLCDSafely ; $47e7
	ld c, $1d ; $47ea
	rst Rst18 ; $47ec
	nop ; $47ed
	add hl, sp ; $47ee
	rst Rst18 ; $47ef
	ld [bc], a ; $47f0
	add hl, sp ; $47f1
	ld a, $94 ; $47f2
	ld [$cb42], a ; $47f4
	ldh [$ff8b], a ; $47f7
	xor a, a ; $47f9
	ld [$cb40], a ; $47fa
	ld a, $01 ; $47fd
	ld hl, $7395 ; $47ff
	call Func_00_1b6a ; $4802
	call EnableLCD ; $4805
	ld c, $10 ; $4808
	call Func_00_1d2e ; $480a
	call Func_00_1da4 ; $480d
	jp Label_6b_407c ; $4810
	ld c, $0a ; $4813
	call Func_00_1d20 ; $4815
	call Func_00_1da4 ; $4818
	ld hl, $7395 ; $481b
	call Func_00_1bcb ; $481e
	xor a, a ; $4821
	ldh [$ff8b], a ; $4822
	jp Label_6b_40af ; $4824
	ld a, [$cb40] ; $4827
	inc a ; $482a
	ld [$cb40], a ; $482b
	cp a, $2b ; $482e
	jp z, Label_6b_4099 ; $4830
	jp Label_6b_407c ; $4833
	call DisableLCDSafely ; $4836
	ld c, $1e ; $4839
	rst Rst18 ; $483b
	nop ; $483c
	add hl, sp ; $483d
	rst Rst18 ; $483e
	ld [bc], a ; $483f
	add hl, sp ; $4840
	ld a, $a8 ; $4841
	ld [$cb42], a ; $4843
	ldh [$ff8b], a ; $4846
	xor a, a ; $4848
	ld [$cb40], a ; $4849
	ld a, $01 ; $484c
	ld hl, $73c4 ; $484e
	call Func_00_1b6a ; $4851
	call EnableLCD ; $4854
	ld c, $10 ; $4857
	call Func_00_1d2e ; $4859
	call Func_00_1da4 ; $485c
	jp Label_6b_407c ; $485f
	ld c, $0a ; $4862
	call Func_00_1d20 ; $4864
	call Func_00_1da4 ; $4867
	ld hl, $73c4 ; $486a
	call Func_00_1bcb ; $486d
	xor a, a ; $4870
	ldh [$ff8b], a ; $4871
	jp Label_6b_40af ; $4873
	ld a, [$cb40] ; $4876
	inc a ; $4879
	ld [$cb40], a ; $487a
	cp a, $2b ; $487d
	jp z, Label_6b_4099 ; $487f
	jp Label_6b_407c ; $4882
	INCBIN "data/bank_06b/d_4885.bin" ; $4885, 219 bytes
	call DisableLCDSafely ; $4960
	call Func_6b_53fc ; $4963
	call Func_6b_6075 ; $4966
	ld a, $02 ; $4969
	ldh [$ff98], a ; $496b
	ld hl, rLCDC ; $496d
	set 3, [hl] ; $4970
	ld a, $01 ; $4972
	ldh [$ff96], a ; $4974
	ldh [rWBK], a ; $4976
	ld hl, $6d12 ; $4978
	ld de, $d000 ; $497b
	call DecompressDataFromBank ; $497e
	ld hl, $d000 ; $4981
	ld de, $9000 ; $4984
	ld c, $80 ; $4987
	call Func_00_0480 ; $4989
	ld hl, $d800 ; $498c
	ld de, $8800 ; $498f
	ld c, $80 ; $4992
	call Func_00_0480 ; $4994
	ld hl, $6d14 ; $4997
	ld de, $d000 ; $499a
	call DecompressDataFromBank ; $499d
	ld hl, $6d16 ; $49a0
	ld de, $d400 ; $49a3
	call DecompressDataFromBank ; $49a6
	ld hl, $d000 ; $49a9
	ld de, $9c00 ; $49ac
	ld c, $40 ; $49af
	call Func_00_0480 ; $49b1
	ld hl, $d400 ; $49b4
	ld de, $bc00 ; $49b7
	ld c, $40 ; $49ba
	call Func_00_0480 ; $49bc
	ld hl, $4a58 ; $49bf
	ld de, $0008 ; $49c2
	call Func_00_05b0 ; $49c5
	ld a, $01 ; $49c8
	ldh [$ff96], a ; $49ca
	ldh [rWBK], a ; $49cc
	ld hl, $6d1a ; $49ce
	ld de, $d000 ; $49d1
	call DecompressDataFromBank ; $49d4
	ld hl, $d000 ; $49d7
	ld de, $b000 ; $49da
	ld c, $80 ; $49dd
	call Func_00_0480 ; $49df
	ld hl, $d800 ; $49e2
	ld de, $a800 ; $49e5
	ld c, $80 ; $49e8
	call Func_00_0480 ; $49ea
	ld a, $04 ; $49ed
	ldh [$ff96], a ; $49ef
	ldh [rWBK], a ; $49f1
	ld hl, $6d1c ; $49f3
	ld de, $d800 ; $49f6
	call DecompressDataFromBank ; $49f9
	ld hl, $6d1e ; $49fc
	ld de, $dc00 ; $49ff
	call DecompressDataFromBank ; $4a02
	ld a, $05 ; $4a05
	ldh [$ff96], a ; $4a07
	ldh [rWBK], a ; $4a09
	ld hl, $6d22 ; $4a0b
	ld de, $d000 ; $4a0e
	call DecompressDataFromBank ; $4a11
	ld hl, $6d24 ; $4a14
	ld de, $d400 ; $4a17
	call DecompressDataFromBank ; $4a1a
	ld a, $01 ; $4a1d
	ldh [$ff96], a ; $4a1f
	ldh [rWBK], a ; $4a21
	ld hl, $551d ; $4a23
	ld de, $d000 ; $4a26
	call DecompressData ; $4a29
	xor a, a ; $4a2c
	ldh [$ff8b], a ; $4a2d
	ldh [$ff8a], a ; $4a2f
	ld [$cb40], a ; $4a31
	call EnableLCD ; $4a34
	ld c, $08 ; $4a37
	call Func_00_1d2e ; $4a39
	call Func_00_1da4 ; $4a3c
	jp Label_6b_407c ; $4a3f
	ld a, [$cb40] ; $4a42
	inc a ; $4a45
	ld [$cb40], a ; $4a46
	cp a, $70 ; $4a49
	jp z, Label_6b_4099 ; $4a4b
	jp Label_6b_407c ; $4a4e
	xor a, a ; $4a51
	ld [$cb40], a ; $4a52
	jp Label_6b_40af ; $4a55
	INCBIN "data/bank_06b/d_4a58.bin" ; $4a58, 64 bytes
	ld a, $04 ; $4a98
	ldh [$ff96], a ; $4a9a
	ldh [rWBK], a ; $4a9c
	ld hl, $d8c0 ; $4a9e
	ld de, $9cc0 ; $4aa1
	ld c, $10 ; $4aa4
	call Func_00_0480 ; $4aa6
	ld hl, $dcc0 ; $4aa9
	ld de, $bcc0 ; $4aac
	ld c, $10 ; $4aaf
	call Func_00_0480 ; $4ab1
	call Func_00_2631 ; $4ab4
	ld hl, $d880 ; $4ab7
	ld de, $9c80 ; $4aba
	ld c, $04 ; $4abd
	call Func_00_0480 ; $4abf
	ld hl, $dc80 ; $4ac2
	ld de, $bc80 ; $4ac5
	ld c, $04 ; $4ac8
	call Func_00_0480 ; $4aca
	call Func_00_2631 ; $4acd
	ld hl, $4c00 ; $4ad0
	ld de, $0107 ; $4ad3
	call Func_00_05b0 ; $4ad6
	xor a, a ; $4ad9
	ld [$cb40], a ; $4ada
	jp Label_6b_407c ; $4add
	ld a, [$cb40] ; $4ae0
	inc a ; $4ae3
	ld [$cb40], a ; $4ae4
	cp a, $70 ; $4ae7
	jp z, Label_6b_4099 ; $4ae9
	jp Label_6b_407c ; $4aec
	jp Label_6b_40af ; $4aef
	ld hl, $756f ; $4af2
	ld de, $0008 ; $4af5
	call Func_00_05b0 ; $4af8
	ld a, $05 ; $4afb
	ldh [$ff96], a ; $4afd
	ldh [rWBK], a ; $4aff
	ld hl, $d260 ; $4b01
	ld de, $9e60 ; $4b04
	ld c, $10 ; $4b07
	call Func_00_0480 ; $4b09
	ld hl, $d660 ; $4b0c
	ld de, $be60 ; $4b0f
	ld c, $10 ; $4b12
	call Func_00_0480 ; $4b14
	call Func_00_2631 ; $4b17
	ld hl, $d160 ; $4b1a
	ld de, $9d60 ; $4b1d
	ld c, $10 ; $4b20
	call Func_00_0480 ; $4b22
	ld hl, $d560 ; $4b25
	ld de, $bd60 ; $4b28
	ld c, $10 ; $4b2b
	call Func_00_0480 ; $4b2d
	call Func_00_2631 ; $4b30
	ld a, $48 ; $4b33
	ld [$cb44], a ; $4b35
	ldh [$ff8a], a ; $4b38
	ld a, $08 ; $4b3a
	ld hl, $7569 ; $4b3c
	call Func_00_1b6a ; $4b3f
	ld hl, $d060 ; $4b42
	ld de, $9c60 ; $4b45
	ld c, $10 ; $4b48
	call Func_00_0480 ; $4b4a
	ld hl, $d460 ; $4b4d
	ld de, $bc60 ; $4b50
	ld c, $10 ; $4b53
	call Func_00_0480 ; $4b55
	call Func_00_2631 ; $4b58
	ld hl, $d000 ; $4b5b
	ld de, $9c00 ; $4b5e
	ld c, $08 ; $4b61
	call Func_00_0480 ; $4b63
	ld hl, $d400 ; $4b66
	ld de, $bc00 ; $4b69
	ld c, $08 ; $4b6c
	call Func_00_0480 ; $4b6e
	ld hl, $4c00 ; $4b71
	ld de, $0107 ; $4b74
	call Func_00_05b0 ; $4b77
	call Func_00_2631 ; $4b7a
	ld a, $01 ; $4b7d
	ldh [$ff96], a ; $4b7f
	ldh [rWBK], a ; $4b81
	ld hl, $d000 ; $4b83
	ld de, $9000 ; $4b86
	ld c, $20 ; $4b89
	call Func_00_0480 ; $4b8b
	call Func_00_2631 ; $4b8e
	ld hl, $d200 ; $4b91
	ld de, $9200 ; $4b94
	ld c, $20 ; $4b97
	call Func_00_0480 ; $4b99
	call Func_00_2631 ; $4b9c
	ld hl, $d400 ; $4b9f
	ld de, $9400 ; $4ba2
	ld c, $20 ; $4ba5
	call Func_00_0480 ; $4ba7
	call Func_00_2631 ; $4baa
	ld hl, $d600 ; $4bad
	ld de, $9600 ; $4bb0
	ld c, $20 ; $4bb3
	call Func_00_0480 ; $4bb5
	call Func_00_2631 ; $4bb8
	ld hl, $d800 ; $4bbb
	ld de, $8800 ; $4bbe
	ld c, $20 ; $4bc1
	call Func_00_0480 ; $4bc3
	call Func_00_2631 ; $4bc6
	xor a, a ; $4bc9
	ld [$cb40], a ; $4bca
	jp Label_6b_407c ; $4bcd
	ld a, [$cb44] ; $4bd0
	sub a, $04 ; $4bd3
	ld [$cb44], a ; $4bd5
	ldh [$ff8a], a ; $4bd8
	jp z, Label_6b_4099 ; $4bda
	ld a, [$cb40] ; $4bdd
	or a, a ; $4be0
	jr nz, Label_6b_4be3 ; $4be1
Label_6b_4be3:
	ld a, [$cb40] ; $4be3
	inc a ; $4be6
	ld [$cb40], a ; $4be7
	jp Label_6b_407c ; $4bea
	ld hl, $7569 ; $4bed
	call Func_00_1bcb ; $4bf0
	ld a, $03 ; $4bf3
	ldh [$ff96], a ; $4bf5
	ldh [rWBK], a ; $4bf7
	ld a, $00 ; $4bf9
	ldh [$ff98], a ; $4bfb
	jp Label_6b_40af ; $4bfd
	INCBIN "data/bank_06b/d_4c00.bin" ; $4c00, 56 bytes
	ld hl, $5d25 ; $4c38
	ld de, $0008 ; $4c3b
	call Func_00_05b0 ; $4c3e
	xor a, a ; $4c41
	ld [$cb40], a ; $4c42
	ld [$cb45], a ; $4c45
	xor a, a ; $4c48
	ld [$c322], a ; $4c49
	ld a, $24 ; $4c4c
	ld [$c323], a ; $4c4e
	ld a, $00 ; $4c51
	ld [$cb4d], a ; $4c53
	ld [$cb4c], a ; $4c56
	ld de, $015c ; $4c59
	ld hl, $cb48 ; $4c5c
	ld a, e ; $4c5f
	ld [hl+], a ; $4c60
	ld [hl], d ; $4c61
	ld de, $0120 ; $4c62
	ld hl, $cb4a ; $4c65
	ld a, e ; $4c68
	ld [hl+], a ; $4c69
	ld [hl], d ; $4c6a
	jp Label_6b_407c ; $4c6b
	ld c, $04 ; $4c6e
	call Func_00_1d20 ; $4c70
	call Func_00_1da4 ; $4c73
	jp Label_6b_40af ; $4c76
	ld a, [$cb40] ; $4c79
	inc a ; $4c7c
	ld [$cb40], a ; $4c7d
	cp a, $80 ; $4c80
	jp z, Label_6b_4099 ; $4c82
	cp a, $64 ; $4c85
	jr nc, Label_6b_4c8c ; $4c87
	call Func_6b_6115 ; $4c89
Label_6b_4c8c:
	call Func_6b_4d61 ; $4c8c
	call Func_6b_4c9e ; $4c8f
	call Func_6b_60d5 ; $4c92
	call Func_6b_60f8 ; $4c95
	call Func_6b_4e2d ; $4c98
	jp Label_6b_407c ; $4c9b
Func_6b_4c9e:
	ld a, [$cb40] ; $4c9e
	ld hl, $4cc1 ; $4ca1
	add a, l ; $4ca4
	ld l, a ; $4ca5
	jr nc, Label_6b_4ca9 ; $4ca6
	inc h ; $4ca8
Label_6b_4ca9:
	ld e, [hl] ; $4ca9
	ld hl, $cb4a ; $4caa
	ld a, [hl+] ; $4cad
	ld h, [hl] ; $4cae
	ld l, a ; $4caf
	ld d, $00 ; $4cb0
	ld a, l ; $4cb2
	sub a, e ; $4cb3
	ld l, a ; $4cb4
	ld a, h ; $4cb5
	sbc a, d ; $4cb6
	ld h, a ; $4cb7
	ld a, h ; $4cb8
	ld [$cb4b], a ; $4cb9
	ld a, l ; $4cbc
	ld [$cb4a], a ; $4cbd
	ret ; $4cc0
	INCBIN "data/bank_06b/d_4cc1.bin" ; $4cc1, 160 bytes
Func_6b_4d61:
	ld a, [$cb40] ; $4d61
	ld hl, $4d84 ; $4d64
	add a, l ; $4d67
	ld l, a ; $4d68
	jr nc, Label_6b_4d6c ; $4d69
	inc h ; $4d6b
Label_6b_4d6c:
	ld e, [hl] ; $4d6c
	ld hl, $cb48 ; $4d6d
	ld a, [hl+] ; $4d70
	ld h, [hl] ; $4d71
	ld l, a ; $4d72
	ld d, $00 ; $4d73
	ld a, l ; $4d75
	sub a, e ; $4d76
	ld l, a ; $4d77
	ld a, h ; $4d78
	sbc a, d ; $4d79
	ld h, a ; $4d7a
	ld a, h ; $4d7b
	ld [$cb49], a ; $4d7c
	ld a, l ; $4d7f
	ld [$cb48], a ; $4d80
	ret ; $4d83
	INCBIN "data/bank_06b/d_4d84.bin" ; $4d84, 169 bytes
Func_6b_4e2d:
	ld a, [$cb40] ; $4e2d
	cp a, $20 ; $4e30
	ret c ; $4e32
	ld a, [$cb40] ; $4e33
	sub a, $20 ; $4e36
	add a, a ; $4e38
	ld hl, $506d ; $4e39
	add a, l ; $4e3c
	ld l, a ; $4e3d
	jr nc, Label_6b_4e41 ; $4e3e
	inc h ; $4e40
Label_6b_4e41:
	ld a, [hl+] ; $4e41
	ld d, [hl] ; $4e42
	ld e, a ; $4e43
	call Func_6b_518d ; $4e44
	ld c, $40 ; $4e47
	ld b, $09 ; $4e49
	ld hl, $4e8e ; $4e4b
	call Func_00_1e9d ; $4e4e
	ld a, [$cb40] ; $4e51
	sub a, $20 ; $4e54
	add a, a ; $4e56
	ld hl, $4f95 ; $4e57
	add a, l ; $4e5a
	ld l, a ; $4e5b
	jr nc, Label_6b_4e5f ; $4e5c
	inc h ; $4e5e
Label_6b_4e5f:
	ld a, [hl+] ; $4e5f
	ld d, [hl] ; $4e60
	ld e, a ; $4e61
	call Func_6b_518d ; $4e62
	ld c, $44 ; $4e65
	ld b, $09 ; $4e67
	ld hl, $4e97 ; $4e69
	call Func_00_1e9d ; $4e6c
	ld a, [$cb40] ; $4e6f
	sub a, $20 ; $4e72
	add a, a ; $4e74
	ld hl, $4ea5 ; $4e75
	add a, l ; $4e78
	ld l, a ; $4e79
	jr nc, Label_6b_4e7d ; $4e7a
	inc h ; $4e7c
Label_6b_4e7d:
	ld a, [hl+] ; $4e7d
	ld d, [hl] ; $4e7e
	ld e, a ; $4e7f
	call Func_6b_518d ; $4e80
	ld c, $48 ; $4e83
	ld b, $09 ; $4e85
	ld hl, $4ea0 ; $4e87
	call Func_00_1e9d ; $4e8a
	ret ; $4e8d
	INCBIN "data/bank_06b/d_4e8e.bin" ; $4e8e, 767 bytes
Func_6b_518d:
	push bc ; $518d
	push hl ; $518e
	ld c, d ; $518f
	ld b, e ; $5190
	ld hl, $cb4a ; $5191
	ld a, [hl+] ; $5194
	ld d, [hl] ; $5195
	ld e, a ; $5196
	ld h, $00 ; $5197
	ld l, b ; $5199
	ld a, l ; $519a
	sub a, e ; $519b
	ld l, a ; $519c
	ld a, h ; $519d
	sbc a, d ; $519e
	ld h, a ; $519f
	ld e, l ; $51a0
	ld d, c ; $51a1
	pop hl ; $51a2
	pop bc ; $51a3
	ret ; $51a4
	INCBIN "data/bank_06b/d_51a5.bin" ; $51a5, 9 bytes
	call DisableLCDSafely ; $51ae
	ld c, $15 ; $51b1
	rst Rst18 ; $51b3
	nop ; $51b4
	add hl, sp ; $51b5
	rst Rst18 ; $51b6
	ld [bc], a ; $51b7
	add hl, sp ; $51b8
	xor a, a ; $51b9
	ldh [$ff8b], a ; $51ba
	ldh [$ff8a], a ; $51bc
	ld [$cb40], a ; $51be
	ld a, $d8 ; $51c1
	ldh [$ff8a], a ; $51c3
	rst Rst08 ; $51c5
	ld h, l ; $51c6
	call EnableLCD ; $51c7
	ld c, $20 ; $51ca
	call Func_00_1d2e ; $51cc
	call Func_00_1da4 ; $51cf
Label_6b_51d2:
	call Func_00_2631 ; $51d2
	ld a, [$cb40] ; $51d5
	inc a ; $51d8
	ld [$cb40], a ; $51d9
	cp a, $3c ; $51dc
	jr z, Label_6b_51e2 ; $51de
	jr Label_6b_51d2 ; $51e0
Label_6b_51e2:
	xor a, a ; $51e2
	ld [$cb40], a ; $51e3
	ret ; $51e6
	ld a, $40 ; $51e7
	ldh [$ff8a], a ; $51e9
Label_6b_51eb:
	call Func_00_2631 ; $51eb
	ld a, [$cb40] ; $51ee
	inc a ; $51f1
	ld [$cb40], a ; $51f2
	cp a, $3e ; $51f5
	jr z, Label_6b_51fb ; $51f7
	jr Label_6b_51eb ; $51f9
Label_6b_51fb:
	ld c, $10 ; $51fb
	call Func_00_1d20 ; $51fd
	call Func_00_1da4 ; $5200
	call DisableLCDSafely ; $5203
	xor a, a ; $5206
	ldh [$ff8a], a ; $5207
	ret ; $5209
Func_6b_520a:
	ld b, $4d ; $520a
	ld c, $06 ; $520c
	ld de, $a000 ; $520e
	rst Rst18 ; $5211
	INCBIN "data/bank_06b/d_5212.bin" ; $5212, 2 bytes
	ld b, $4e ; $5214
	ld c, $0a ; $5216
	ld de, $a060 ; $5218
	rst Rst18 ; $521b
	INCBIN "data/bank_06b/d_521c.bin" ; $521c, 2 bytes
	ld b, $4f ; $521e
	ld c, $10 ; $5220
	ld de, $a100 ; $5222
	rst Rst18 ; $5225
	INCBIN "data/bank_06b/d_5226.bin" ; $5226, 2 bytes
	ld b, $50 ; $5228
	ld c, $06 ; $522a
	ld de, $a200 ; $522c
	rst Rst18 ; $522f
	INCBIN "data/bank_06b/d_5230.bin" ; $5230, 2 bytes
	ld b, $51 ; $5232
	ld c, $12 ; $5234
	ld de, $a260 ; $5236
	rst Rst18 ; $5239
	INCBIN "data/bank_06b/d_523a.bin" ; $523a, 2 bytes
	ld b, $52 ; $523c
	ld c, $10 ; $523e
	ld de, $a380 ; $5240
	rst Rst18 ; $5243
	INCBIN "data/bank_06b/d_5244.bin" ; $5244, 2 bytes
	ld b, $53 ; $5246
	ld c, $02 ; $5248
	ld de, $a480 ; $524a
	rst Rst18 ; $524d
	INCBIN "data/bank_06b/d_524e.bin" ; $524e, 2 bytes
	ld hl, $525a ; $5250
	ld de, $0802 ; $5253
	call Func_00_05b0 ; $5256
	ret ; $5259
	INCBIN "data/bank_06b/d_525a.bin" ; $525a, 16 bytes
	ld hl, $52b6 ; $526a
	ld a, [$cb44] ; $526d
	ld d, $10 ; $5270
	add a, d ; $5272
	ld d, a ; $5273
	ld a, [$cb45] ; $5274
	ld e, a ; $5277
	call Func_6b_53b8 ; $5278
	ld c, $00 ; $527b
	ld b, $08 ; $527d
	call Func_00_1e9d ; $527f
	ld hl, $52c3 ; $5282
	ld a, [$cb44] ; $5285
	ld d, $08 ; $5288
	add a, d ; $528a
	ld d, a ; $528b
	ld a, [$cb45] ; $528c
	ld e, $10 ; $528f
	add a, e ; $5291
	ld e, a ; $5292
	call Func_6b_53b8 ; $5293
	ld c, $06 ; $5296
	ld b, $08 ; $5298
	call Func_00_1e9d ; $529a
	ld hl, $52d8 ; $529d
	ld a, [$cb44] ; $52a0
	ld d, a ; $52a3
	ld a, [$cb45] ; $52a4
	ld e, $20 ; $52a7
	add a, e ; $52a9
	ld e, a ; $52aa
	call Func_6b_53b8 ; $52ab
	ld c, $10 ; $52ae
	ld b, $08 ; $52b0
	call Func_00_1e9d ; $52b2
	ret ; $52b5
	INCBIN "data/bank_06b/d_52b6.bin" ; $52b6, 67 bytes
	ld hl, $5360 ; $52f9
	ld a, [$cb46] ; $52fc
	ld d, $18 ; $52ff
	add a, d ; $5301
	ld d, a ; $5302
	ld a, [$cb47] ; $5303
	ld e, a ; $5306
	call Func_6b_53b8 ; $5307
	ld c, $20 ; $530a
	ld b, $09 ; $530c
	call Func_00_1e9d ; $530e
	ld hl, $536d ; $5311
	ld a, [$cb46] ; $5314
	ld d, $08 ; $5317
	add a, d ; $5319
	ld d, a ; $531a
	ld a, [$cb47] ; $531b
	ld e, $10 ; $531e
	add a, e ; $5320
	ld e, a ; $5321
	call Func_6b_53b8 ; $5322
	ld c, $26 ; $5325
	ld b, $09 ; $5327
	call Func_00_1e9d ; $5329
	ld hl, $5392 ; $532c
	ld a, [$cb46] ; $532f
	ld d, a ; $5332
	ld a, [$cb47] ; $5333
	ld e, $20 ; $5336
	add a, e ; $5338
	ld e, a ; $5339
	call Func_6b_53b8 ; $533a
	ld c, $38 ; $533d
	ld b, $09 ; $533f
	call Func_00_1e9d ; $5341
	ld hl, $53b3 ; $5344
	ld a, [$cb46] ; $5347
	ld d, $48 ; $534a
	add a, d ; $534c
	ld d, a ; $534d
	ld a, [$cb47] ; $534e
	ld e, $20 ; $5351
	add a, e ; $5353
	ld e, a ; $5354
	call Func_6b_53b8 ; $5355
	ld c, $48 ; $5358
	ld b, $09 ; $535a
	call Func_00_1e9d ; $535c
	ret ; $535f
	INCBIN "data/bank_06b/d_5360.bin" ; $5360, 88 bytes
Func_6b_53b8:
	push hl ; $53b8
	ld a, [$cb40] ; $53b9
	and a, $0f ; $53bc
	ld hl, $53cb ; $53be
	add a, l ; $53c1
	ld l, a ; $53c2
	jr nc, Label_6b_53c6 ; $53c3
	inc h ; $53c5
Label_6b_53c6:
	ld a, [hl] ; $53c6
	add a, e ; $53c7
	ld e, a ; $53c8
	pop hl ; $53c9
	ret ; $53ca
	INCBIN "data/bank_06b/d_53cb.bin" ; $53cb, 16 bytes
	ld a, [$cb42] ; $53db
	add a, $03 ; $53de
	ld [$cb42], a ; $53e0
	ldh [$ff8b], a ; $53e3
	ld a, [$cb43] ; $53e5
	sub a, $03 ; $53e8
	ld [$cb43], a ; $53ea
	ld [$cb01], a ; $53ed
	ret ; $53f0
	ldh a, [$ff94] ; $53f1
	and a, $09 ; $53f3
	ret z ; $53f5
	ld a, $01 ; $53f6
	ld [wIntroCutsceneCheck], a ; $53f8
	ret ; $53fb
Func_6b_53fc:
	call DisableLCDSafely ; $53fc
	rst Rst18 ; $53ff
	ld l, d ; $5400
	ld a, [bc] ; $5401
	rst Rst18 ; $5402
	nop ; $5403
	dec b ; $5404
	ld a, $01 ; $5405
	ldh [$ff96], a ; $5407
	ldh [rWBK], a ; $5409
	ld hl, $551d ; $540b
	ld de, $d000 ; $540e
	call DecompressData ; $5411
	ld hl, $d000 ; $5414
	ld de, $9000 ; $5417
	ld c, $80 ; $541a
	call Func_00_0480 ; $541c
	ld hl, $d800 ; $541f
	ld de, $8800 ; $5422
	ld c, $80 ; $5425
	call Func_00_0480 ; $5427
	ld a, $02 ; $542a
	ldh [$ff96], a ; $542c
	ldh [rWBK], a ; $542e
	ld hl, $5d65 ; $5430
	ld de, $d000 ; $5433
	call DecompressData ; $5436
	ld a, $03 ; $5439
	ldh [$ff96], a ; $543b
	ldh [rWBK], a ; $543d
	ld hl, $5ea8 ; $543f
	ld de, $d000 ; $5442
	call DecompressData ; $5445
	xor a, a ; $5448
	ld [$c322], a ; $5449
	ld [$c320], a ; $544c
	ld a, $24 ; $544f
	ld [$c323], a ; $5451
	ld a, $01 ; $5454
	rst Rst18 ; $5456
	halt ; $5457
	ld a, [bc] ; $5458
	xor a, a ; $5459
	ld [$c323], a ; $545a
	ret ; $545d
	INCBIN "data/bank_06b/d_545e.bin" ; $545e, 91 bytes
Func_6b_54b9:
	call DisableLCDSafely ; $54b9
	rst Rst18 ; $54bc
	ld l, d ; $54bd
	ld a, [bc] ; $54be
	rst Rst18 ; $54bf
	nop ; $54c0
	dec b ; $54c1
	ld a, $01 ; $54c2
	ldh [$ff96], a ; $54c4
	ldh [rWBK], a ; $54c6
	ld hl, $551d ; $54c8
	ld de, $d000 ; $54cb
	call DecompressData ; $54ce
	ld hl, $d000 ; $54d1
	ld de, $9000 ; $54d4
	ld c, $80 ; $54d7
	call Func_00_0480 ; $54d9
	ld hl, $d800 ; $54dc
	ld de, $8800 ; $54df
	ld c, $80 ; $54e2
	call Func_00_0480 ; $54e4
	ld a, $02 ; $54e7
	ldh [$ff96], a ; $54e9
	ldh [rWBK], a ; $54eb
	ld hl, $5bd7 ; $54ed
	ld de, $d000 ; $54f0
	call DecompressData ; $54f3
	ld a, $03 ; $54f6
	ldh [$ff96], a ; $54f8
	ldh [rWBK], a ; $54fa
	ld hl, $59d7 ; $54fc
	ld de, $d000 ; $54ff
	call DecompressData ; $5502
	ld hl, $5d25 ; $5505
	ld de, $0008 ; $5508
	call Func_00_05b0 ; $550b
	xor a, a ; $550e
	ld [$c322], a ; $550f
	ld a, $24 ; $5512
	ld [$c323], a ; $5514
	ld a, $01 ; $5517
	rst Rst18 ; $5519
	halt ; $551a
	ld a, [bc] ; $551b
	ret ; $551c
	INCBIN "data/bank_06b/d_551d.bin" ; $551d, 2904 bytes
Func_6b_6075:
	ld b, $54 ; $6075
	ld c, $10 ; $6077
	ld de, $a000 ; $6079
	rst Rst18 ; $607c
	INCBIN "data/bank_06b/d_607d.bin" ; $607d, 2 bytes
	ld b, $55 ; $607f
	ld c, $10 ; $6081
	ld de, $a100 ; $6083
	rst Rst18 ; $6086
	INCBIN "data/bank_06b/d_6087.bin" ; $6087, 2 bytes
	ld b, $56 ; $6089
	ld c, $10 ; $608b
	ld de, $a200 ; $608d
	rst Rst18 ; $6090
	INCBIN "data/bank_06b/d_6091.bin" ; $6091, 2 bytes
	ld b, $57 ; $6093
	ld c, $10 ; $6095
	ld de, $a300 ; $6097
	rst Rst18 ; $609a
	INCBIN "data/bank_06b/d_609b.bin" ; $609b, 2 bytes
	ld b, $58 ; $609d
	ld c, $04 ; $609f
	ld de, $a400 ; $60a1
	rst Rst18 ; $60a4
	INCBIN "data/bank_06b/d_60a5.bin" ; $60a5, 2 bytes
	ld b, $59 ; $60a7
	ld c, $04 ; $60a9
	ld de, $a440 ; $60ab
	rst Rst18 ; $60ae
	INCBIN "data/bank_06b/d_60af.bin" ; $60af, 2 bytes
	ld b, $5a ; $60b1
	ld c, $04 ; $60b3
	ld de, $a480 ; $60b5
	rst Rst18 ; $60b8
	INCBIN "data/bank_06b/d_60b9.bin" ; $60b9, 2 bytes
	ld hl, $60c5 ; $60bb
	ld de, $0802 ; $60be
	call Func_00_05b0 ; $60c1
	ret ; $60c4
	INCBIN "data/bank_06b/d_60c5.bin" ; $60c5, 16 bytes
Func_6b_60d5:
	ld hl, $cb4a ; $60d5
	ld a, [hl+] ; $60d8
	ld d, [hl] ; $60d9
	ld e, a ; $60da
	sla e ; $60db
	rl d ; $60dd
	sla e ; $60df
	rl d ; $60e1
	sla e ; $60e3
	rl d ; $60e5
	sla e ; $60e7
	rl d ; $60e9
	sla e ; $60eb
	rl d ; $60ed
	ld a, e ; $60ef
	ld [$c322], a ; $60f0
	ld a, d ; $60f3
	ld [$c323], a ; $60f4
	ret ; $60f7
Func_6b_60f8:
	ld hl, $cb4a ; $60f8
	ld a, [hl+] ; $60fb
	ld d, [hl] ; $60fc
	ld e, a ; $60fd
	ld hl, $cb48 ; $60fe
	ld a, [hl+] ; $6101
	ld h, [hl] ; $6102
	ld l, a ; $6103
	ld a, l ; $6104
	sub a, e ; $6105
	ld l, a ; $6106
	ld a, h ; $6107
	sbc a, d ; $6108
	ld h, a ; $6109
	ld e, l ; $610a
	ld a, [$cb4c] ; $610b
	ld c, a ; $610e
	ld d, $40 ; $610f
	call Func_6b_6126 ; $6111
	ret ; $6114
Func_6b_6115:
	ld a, [$cb4d] ; $6115
	inc a ; $6118
	ld [$cb4d], a ; $6119
	and a, $30 ; $611c
	rrca ; $611e
	rrca ; $611f
	rrca ; $6120
	rrca ; $6121
	ld [$cb4c], a ; $6122
	ret ; $6125
Func_6b_6126:
	ld hl, $6139 ; $6126
	ld a, c ; $6129
	add a, l ; $612a
	ld l, a ; $612b
	jr nc, Label_6b_612f ; $612c
	inc h ; $612e
Label_6b_612f:
	ld c, [hl] ; $612f
	ld hl, $613d ; $6130
	ld b, $08 ; $6133
	call Func_00_1e9d ; $6135
	ret ; $6138
	INCBIN "data/bank_06b/d_6139.bin" ; $6139, 67 bytes
Func_6b_617c:
	call DisableLCDSafely ; $617c
	rst Rst18 ; $617f
	ld l, d ; $6180
	ld a, [bc] ; $6181
	rst Rst18 ; $6182
	nop ; $6183
	dec b ; $6184
	ld a, $01 ; $6185
	ldh [$ff96], a ; $6187
	ldh [rWBK], a ; $6189
	ld hl, $61e6 ; $618b
	ld de, $d000 ; $618e
	call DecompressData ; $6191
	ld hl, $d000 ; $6194
	ld de, $b000 ; $6197
	ld c, $80 ; $619a
	call Func_00_0480 ; $619c
	ld hl, $d800 ; $619f
	ld de, $a800 ; $61a2
	ld c, $80 ; $61a5
	call Func_00_0480 ; $61a7
	ld a, $02 ; $61aa
	ldh [$ff96], a ; $61ac
	ldh [rWBK], a ; $61ae
	ld hl, $6f0f ; $61b0
	ld de, $d000 ; $61b3
	call DecompressData ; $61b6
	ld a, $03 ; $61b9
	ldh [$ff96], a ; $61bb
	ldh [rWBK], a ; $61bd
	ld hl, $6cbc ; $61bf
	ld de, $d000 ; $61c2
	call DecompressData ; $61c5
	ld hl, $7043 ; $61c8
	ld de, $0008 ; $61cb
	call Func_00_05b0 ; $61ce
	ld a, $20 ; $61d1
	ld [$c321], a ; $61d3
	xor a, a ; $61d6
	ld [$c320], a ; $61d7
	ld [$c322], a ; $61da
	ld [$c323], a ; $61dd
	ld a, $01 ; $61e0
	rst Rst18 ; $61e2
	halt ; $61e3
	ld a, [bc] ; $61e4
	ret ; $61e5
	INCBIN "data/bank_06b/d_61e6.bin" ; $61e6, 3741 bytes
	ld a, [$cb44] ; $7083
	inc a ; $7086
	ld [$cb44], a ; $7087
	cp a, $5a ; $708a
	jr nz, Label_6b_7096 ; $708c
	ld a, $01 ; $708e
	ld hl, $731b ; $7090
	call Func_00_1b6a ; $7093
Label_6b_7096:
	cp a, $aa ; $7096
	jr nz, Label_6b_70a2 ; $7098
	ld a, $01 ; $709a
	ld hl, $72af ; $709c
	call Func_00_1b6a ; $709f
Label_6b_70a2:
	cp a, $01 ; $70a2
	jr nz, Label_6b_70ae ; $70a4
	ld a, $01 ; $70a6
	ld hl, $72dd ; $70a8
	call Func_00_1b6a ; $70ab
Label_6b_70ae:
	ret ; $70ae
	INCBIN "data/bank_06b/d_70af.bin" ; $70af, 512 bytes
	ldh a, [$ff8c] ; $72af
	and a, $03 ; $72b1
	cp a, $03 ; $72b3
	ret nz ; $72b5
	ld a, [$cb45] ; $72b6
	inc a ; $72b9
	ld [$cb45], a ; $72ba
	cp a, $10 ; $72bd
	jr nc, Label_6b_72d6 ; $72bf
	sla a ; $72c1
	sla a ; $72c3
	sla a ; $72c5
	ld hl, $70af ; $72c7
	add a, l ; $72ca
	ld l, a ; $72cb
	jr nc, Label_6b_72cf ; $72cc
	inc h ; $72ce
Label_6b_72cf:
	ld de, $0101 ; $72cf
	call Func_00_05b5 ; $72d2
	ret ; $72d5
Label_6b_72d6:
	ld hl, $72af ; $72d6
	call Func_00_1bcb ; $72d9
	ret ; $72dc
	ldh a, [$ff8c] ; $72dd
	and a, $03 ; $72df
	cp a, $03 ; $72e1
	ret nz ; $72e3
	ld a, [$cb46] ; $72e4
	inc a ; $72e7
	ld [$cb46], a ; $72e8
	cp a, $10 ; $72eb
	jr nc, Label_6b_7314 ; $72ed
	sla a ; $72ef
	sla a ; $72f1
	sla a ; $72f3
	push af ; $72f5
	ld hl, $712f ; $72f6
	add a, l ; $72f9
	ld l, a ; $72fa
	jr nc, Label_6b_72fe ; $72fb
	inc h ; $72fd
Label_6b_72fe:
	ld de, $0201 ; $72fe
	call Func_00_05b5 ; $7301
	pop af ; $7304
	ld hl, $71af ; $7305
	add a, l ; $7308
	ld l, a ; $7309
	jr nc, Label_6b_730d ; $730a
	inc h ; $730c
Label_6b_730d:
	ld de, $0301 ; $730d
	call Func_00_05b5 ; $7310
	ret ; $7313
Label_6b_7314:
	ld hl, $72dd ; $7314
	call Func_00_1bcb ; $7317
	ret ; $731a
	ldh a, [$ff8c] ; $731b
	and a, $03 ; $731d
	cp a, $03 ; $731f
	ret nz ; $7321
	ld a, [$cb47] ; $7322
	inc a ; $7325
	ld [$cb47], a ; $7326
	cp a, $10 ; $7329
	jr nc, Label_6b_7342 ; $732b
	sla a ; $732d
	sla a ; $732f
	sla a ; $7331
	ld hl, $722f ; $7333
	add a, l ; $7336
	ld l, a ; $7337
	jr nc, Label_6b_733b ; $7338
	inc h ; $733a
Label_6b_733b:
	ld de, $0404 ; $733b
	call Func_00_05b5 ; $733e
	ret ; $7341
Label_6b_7342:
	cp a, $20 ; $7342
	jr c, Label_6b_735f ; $7344
	ld b, a ; $7346
	ld a, $20 ; $7347
	sub a, b ; $7349
	sla a ; $734a
	sla a ; $734c
	sla a ; $734e
	ld hl, $722f ; $7350
	add a, l ; $7353
	ld l, a ; $7354
	jr nc, Label_6b_7358 ; $7355
	inc h ; $7357
Label_6b_7358:
	ld de, $0404 ; $7358
	call Func_00_05b5 ; $735b
	ret ; $735e
Label_6b_735f:
	ld hl, $731b ; $735f
	call Func_00_1bcb ; $7362
	ret ; $7365
	ld a, [$cb40] ; $7366
	cp a, $10 ; $7369
	jr nc, Label_6b_7380 ; $736b
	ld hl, $7381 ; $736d
	add a, l ; $7370
	ld l, a ; $7371
	jr nc, Label_6b_7375 ; $7372
	inc h ; $7374
Label_6b_7375:
	ld a, [hl] ; $7375
	ld b, a ; $7376
	ld a, [$cb42] ; $7377
	add a, b ; $737a
	ld [$cb42], a ; $737b
	ldh [$ff8b], a ; $737e
Label_6b_7380:
	ret ; $7380
	INCBIN "data/bank_06b/d_7381.bin" ; $7381, 20 bytes
	ld a, [$cb40] ; $7395
	cp a, $10 ; $7398
	jr nc, Label_6b_73af ; $739a
	ld hl, $73b0 ; $739c
	add a, l ; $739f
	ld l, a ; $73a0
	jr nc, Label_6b_73a4 ; $73a1
	inc h ; $73a3
Label_6b_73a4:
	ld a, [hl] ; $73a4
	ld b, a ; $73a5
	ld a, [$cb42] ; $73a6
	sub a, b ; $73a9
	ld [$cb42], a ; $73aa
	ldh [$ff8b], a ; $73ad
Label_6b_73af:
	ret ; $73af
	INCBIN "data/bank_06b/d_73b0.bin" ; $73b0, 20 bytes
	ld a, [$cb40] ; $73c4
	cp a, $10 ; $73c7
	jr nc, Label_6b_73de ; $73c9
	ld hl, $73df ; $73cb
	add a, l ; $73ce
	ld l, a ; $73cf
	jr nc, Label_6b_73d3 ; $73d0
	inc h ; $73d2
Label_6b_73d3:
	ld a, [hl] ; $73d3
	ld b, a ; $73d4
	ld a, [$cb42] ; $73d5
	sub a, b ; $73d8
	ld [$cb42], a ; $73d9
	ldh [$ff8b], a ; $73dc
Label_6b_73de:
	ret ; $73de
	INCBIN "data/bank_06b/d_73df.bin" ; $73df, 19 bytes
Func_6b_73f2:
	ldh a, [$ff96] ; $73f2
	push af ; $73f4
	ld a, $01 ; $73f5
	ldh [$ff96], a ; $73f7
	ldh [rWBK], a ; $73f9
	ld hl, $6d10 ; $73fb
	ld de, $d000 ; $73fe
	call DecompressDataFromBank ; $7401
	ld hl, $d000 ; $7404
	ld de, $9000 ; $7407
	ld c, $80 ; $740a
	call Func_00_0480 ; $740c
	ld hl, $d800 ; $740f
	ld de, $8800 ; $7412
	ld c, $80 ; $7415
	call Func_00_0480 ; $7417
	ld a, $05 ; $741a
	ldh [$ff96], a ; $741c
	ldh [rWBK], a ; $741e
	ld hl, $7438 ; $7420
	ld de, $d000 ; $7423
	call DecompressData ; $7426
	ld hl, $7515 ; $7429
	ld de, $d400 ; $742c
	call DecompressData ; $742f
	pop af ; $7432
	ldh [$ff96], a ; $7433
	ldh [rWBK], a ; $7435
	ret ; $7437
	INCBIN "data/bank_06b/d_7438.bin" ; $7438, 305 bytes
	ld a, [$cb44] ; $7569
	ldh [$ff8a], a ; $756c
	ret ; $756e
	INCBIN "data/bank_06b/d_756f.bin" ; $756f, 64 bytes
	call Func_00_1b38 ; $75af
	ld a, $03 ; $75b2
	ldh [$ff96], a ; $75b4
	ldh [rWBK], a ; $75b6
	xor a, a ; $75b8
	ldh [$ff8b], a ; $75b9
	ldh [$ff8a], a ; $75bb
	ld [$d800], a ; $75bd
	ld [$d801], a ; $75c0
	ld [$d802], a ; $75c3
	ld a, $98 ; $75c6
	ld [$d800], a ; $75c8
	ld c, $7f ; $75cb
	call Func_00_1d20 ; $75cd
	call Func_00_1da4 ; $75d0
	call DisableLCDSafely ; $75d3
	ld c, $7f ; $75d6
	call Func_00_1d20 ; $75d8
	call Func_00_1da4 ; $75db
	ld c, $1f ; $75de
	rst Rst18 ; $75e0
	nop ; $75e1
	add hl, sp ; $75e2
	rst Rst18 ; $75e3
	ld [bc], a ; $75e4
	add hl, sp ; $75e5
	ld c, $14 ; $75e6
	ld b, $5b ; $75e8
	ld de, $a000 ; $75ea
	rst Rst18 ; $75ed
	INCBIN "data/bank_06b/d_75ee.bin" ; $75ee, 2 bytes
	ld c, $14 ; $75f0
	ld b, $5c ; $75f2
	ld de, $a200 ; $75f4
	rst Rst18 ; $75f7
	INCBIN "data/bank_06b/d_75f8.bin" ; $75f8, 2 bytes
	ld c, $14 ; $75fa
	ld b, $5d ; $75fc
	ld de, $a400 ; $75fe
	rst Rst18 ; $7601
	INCBIN "data/bank_06b/d_7602.bin" ; $7602, 2 bytes
	ld c, $14 ; $7604
	ld b, $5e ; $7606
	ld de, $a600 ; $7608
	rst Rst18 ; $760b
	INCBIN "data/bank_06b/d_760c.bin" ; $760c, 2 bytes
	ld c, $14 ; $760e
	ld b, $5f ; $7610
	ld de, $8000 ; $7612
	rst Rst18 ; $7615
	INCBIN "data/bank_06b/d_7616.bin" ; $7616, 2 bytes
	ld c, $14 ; $7618
	ld b, $60 ; $761a
	ld de, $8200 ; $761c
	rst Rst18 ; $761f
	INCBIN "data/bank_06b/d_7620.bin" ; $7620, 2 bytes
	ld c, $14 ; $7622
	ld b, $61 ; $7624
	ld de, $8400 ; $7626
	rst Rst18 ; $7629
	INCBIN "data/bank_06b/d_762a.bin" ; $762a, 2 bytes
	ld c, $14 ; $762c
	ld b, $62 ; $762e
	ld de, $8600 ; $7630
	rst Rst18 ; $7633
	INCBIN "data/bank_06b/d_7634.bin" ; $7634, 2 bytes
	ld hl, $794f ; $7636
	ld de, $0801 ; $7639
	call Func_00_05b0 ; $763c
	ld a, $01 ; $763f
	ld hl, $76b6 ; $7641
	call Func_00_1b6a ; $7644
	rst Rst08 ; $7647
	ld [bc], a ; $7648
	call EnableLCD ; $7649
	ld c, $04 ; $764c
	call Func_00_1d2e ; $764e
	call Func_00_1da4 ; $7651
	ld a, $03 ; $7654
	ldh [$ff96], a ; $7656
	ldh [rWBK], a ; $7658
	ld a, $9f ; $765a
	ld [$d800], a ; $765c
Label_6b_765f:
	call Func_6b_771f ; $765f
	call Func_00_2631 ; $7662
	ldh a, [$ff94] ; $7665
	bit 0, a ; $7667
	jr nz, Label_6b_7680 ; $7669
	bit 3, a ; $766b
	jr nz, Label_6b_7680 ; $766d
	ldh a, [$ff8c] ; $766f
	and a, $07 ; $7671
	jr nz, Label_6b_765f ; $7673
	ld a, [$d800] ; $7675
	inc a ; $7678
	ld [$d800], a ; $7679
	jr z, Label_6b_76a6 ; $767c
	jr Label_6b_765f ; $767e
Label_6b_7680:
	rst Rst08 ; $7680
	nop ; $7681
	rst Rst08 ; $7682
	ld h, b ; $7683
	call Func_00_1b38 ; $7684
	ld c, $10 ; $7687
	call Func_00_1d20 ; $7689
	call Func_00_1da4 ; $768c
	xor a, a ; $768f
	ret ; $7690
	INCBIN "data/bank_06b/d_7691.bin" ; $7691, 21 bytes
Label_6b_76a6:
	rst Rst08 ; $76a6
	nop ; $76a7
	call Func_00_1b38 ; $76a8
	ld c, $08 ; $76ab
	call Func_00_1d20 ; $76ad
	call Func_00_1da4 ; $76b0
	ld a, $ff ; $76b3
	ret ; $76b5
	ldh a, [$ff96] ; $76b6
	push af ; $76b8
	ld a, $03 ; $76b9
	ldh [$ff96], a ; $76bb
	ldh [rWBK], a ; $76bd
	ld a, [$d801] ; $76bf
	ld hl, $76e6 ; $76c2
	add a, l ; $76c5
	ld l, a ; $76c6
	jr nc, Label_6b_76ca ; $76c7
	inc h ; $76c9
Label_6b_76ca:
	ld c, [hl] ; $76ca
	ld a, [$d801] ; $76cb
	ld hl, $76ee ; $76ce
	add a, l ; $76d1
	ld l, a ; $76d2
	jr nc, Label_6b_76d6 ; $76d3
	inc h ; $76d5
Label_6b_76d6:
	ld b, [hl] ; $76d6
	ld de, $2858 ; $76d7
	ld hl, $76f6 ; $76da
	call Func_00_1e9d ; $76dd
	pop af ; $76e0
	ldh [$ff96], a ; $76e1
	ldh [rWBK], a ; $76e3
	ret ; $76e5
	INCBIN "data/bank_06b/d_76e6.bin" ; $76e6, 57 bytes
Func_6b_771f:
	ld a, [$d802] ; $771f
	or a, a ; $7722
	jr z, Label_6b_7732 ; $7723
	inc a ; $7725
	ld [$d802], a ; $7726
	cp a, $10 ; $7729
	jr nz, Label_6b_774c ; $772b
	xor a, a ; $772d
	ld [$d802], a ; $772e
	ret ; $7731
Label_6b_7732:
	ldh a, [$ff8c] ; $7732
	and a, $07 ; $7734
	cp a, $07 ; $7736
	jr nz, Label_6b_774c ; $7738
	ld a, [$d801] ; $773a
	inc a ; $773d
	and a, $07 ; $773e
	ld [$d801], a ; $7740
	cp a, $07 ; $7743
	jr nz, Label_6b_774c ; $7745
	ld a, $01 ; $7747
	ld [$d802], a ; $7749
Label_6b_774c:
	ret ; $774c
	INCBIN "data/bank_06b/d_774d.bin" ; $774d, 2227 bytes
