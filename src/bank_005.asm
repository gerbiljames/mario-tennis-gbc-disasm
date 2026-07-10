INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $05", ROMX[$4000], BANK[$05]

FarPtr_05_00:
	dw Func_05_4096 ; $4000
	INCBIN "data/bank_005/d_4002.bin" ; $4002, 4 bytes
FarPtr_05_06:
	dw Func_05_4688 ; $4006
FarPtr_05_08:
	dw Func_05_46b0 ; $4008
FarPtr_05_0a:
	dw Func_05_5a93 ; $400a
	INCBIN "data/bank_005/d_400c.bin" ; $400c, 2 bytes
FarPtr_05_0e:
	dw Func_05_55d5 ; $400e
	INCBIN "data/bank_005/d_4010.bin" ; $4010, 8 bytes
FarPtr_05_18:
	dw Func_05_436f ; $4018
	INCBIN "data/bank_005/d_401a.bin" ; $401a, 2 bytes
FarPtr_05_1c:
	dw Func_05_5db3 ; $401c
FarPtr_05_1e:
	dw Func_05_5c18 ; $401e
	INCBIN "data/bank_005/d_4020.bin" ; $4020, 6 bytes
FarPtr_05_26:
	dw Func_05_5bfc ; $4026
	INCBIN "data/bank_005/d_4028.bin" ; $4028, 10 bytes
FarPtr_05_32:
	dw Func_05_55e6 ; $4032
FarPtr_05_34:
	dw Func_05_581f ; $4034
FarPtr_05_36:
	dw Func_05_58f0 ; $4036
	INCBIN "data/bank_005/d_4038.bin" ; $4038, 4 bytes
FarPtr_05_3c:
	dw Func_05_477f ; $403c
FarPtr_05_3e:
	dw Func_05_4944 ; $403e
	INCBIN "data/bank_005/d_4040.bin" ; $4040, 4 bytes
FarPtr_05_44:
	dw Func_05_5d2b ; $4044
FarPtr_05_46:
	dw Func_05_50f7 ; $4046
FarPtr_05_48:
	dw Func_05_5147 ; $4048
	INCBIN "data/bank_005/d_404a.bin" ; $404a, 4 bytes
FarPtr_05_4e:
	dw Func_05_409a ; $404e
	INCBIN "data/bank_005/d_4050.bin" ; $4050, 2 bytes
FarPtr_05_52:
	dw Func_05_66a0 ; $4052
	INCBIN "data/bank_005/d_4054.bin" ; $4054, 4 bytes
FarPtr_05_58:
	dw Func_05_4122 ; $4058
	INCBIN "data/bank_005/d_405a.bin" ; $405a, 2 bytes
FarPtr_05_5c:
	dw Func_05_617a ; $405c
	INCBIN "data/bank_005/d_405e.bin" ; $405e, 2 bytes
FarPtr_05_60:
	dw Func_05_61a2 ; $4060
	INCBIN "data/bank_005/d_4062.bin" ; $4062, 2 bytes
FarPtr_05_64:
	dw Func_05_62bc ; $4064
FarPtr_05_66:
	dw Func_05_62d8 ; $4066
	INCBIN "data/bank_005/d_4068.bin" ; $4068, 2 bytes
FarPtr_05_6a:
	dw Func_05_43a8 ; $406a
	INCBIN "data/bank_005/d_406c.bin" ; $406c, 6 bytes
FarPtr_05_72:
	dw Func_05_5f52 ; $4072
	INCBIN "data/bank_005/d_4074.bin" ; $4074, 2 bytes
FarPtr_05_76:
	dw Func_05_6e09 ; $4076
FarPtr_05_78:
	dw Func_05_6e45 ; $4078
FarPtr_05_7a:
	dw Func_05_72bd ; $407a
FarPtr_05_7c:
	dw Func_05_6f70 ; $407c
FarPtr_05_7e:
	dw Func_05_7205 ; $407e
FarPtr_05_80:
	dw Func_05_7232 ; $4080
FarPtr_05_82:
	dw Func_05_7223 ; $4082
FarPtr_05_84:
	dw Func_05_72d2 ; $4084
FarPtr_05_86:
	dw Func_05_6eea ; $4086
	INCBIN "data/bank_005/d_4088.bin" ; $4088, 4 bytes
FarPtr_05_8c:
	dw Func_05_72dc ; $408c
FarPtr_05_8e:
	dw Func_05_730d ; $408e
FarPtr_05_90:
	dw Func_05_7792 ; $4090
	INCBIN "data/bank_005/d_4092.bin" ; $4092, 4 bytes
Func_05_4096:
	call Func_05_6e09 ; $4096
	ret ; $4099
Func_05_409a:
	push af ; $409a
	push bc ; $409b
	push de ; $409c
	push hl ; $409d
	ldh a, [$ff96] ; $409e
	push af ; $40a0
	ld a, $05 ; $40a1
	ldh [$ff96], a ; $40a3
	ldh [rWBK], a ; $40a5
	call Func_05_5ca8 ; $40a7
	ld hl, $d880 ; $40aa
Label_05_40ad:
	ld a, [hl+] ; $40ad
	ld [de], a ; $40ae
	inc de ; $40af
	cp a, $00 ; $40b0
	jr nz, Label_05_40ad ; $40b2
	pop af ; $40b4
	ldh [$ff96], a ; $40b5
	ldh [rWBK], a ; $40b7
	pop hl ; $40b9
	pop de ; $40ba
	pop bc ; $40bb
	pop af ; $40bc
	ret ; $40bd
	INCBIN "data/bank_005/d_40be.bin" ; $40be, 61 bytes
Func_05_40fb:
	push af ; $40fb
	push de ; $40fc
	push bc ; $40fd
	push af ; $40fe
	ld a, $05 ; $40ff
	ldh [$ff96], a ; $4101
	ldh [rWBK], a ; $4103
	pop af ; $4105
	call Func_05_4122 ; $4106
	or a, a ; $4109
	jr z, Label_05_410d ; $410a
	ld [de], a ; $410c
Label_05_410d:
	pop bc ; $410d
	pop de ; $410e
	pop af ; $410f
	ret ; $4110
	INCBIN "data/bank_005/d_4111.bin" ; $4111, 17 bytes
Func_05_4122:
	push af ; $4122
	push bc ; $4123
	push hl ; $4124
	ld a, d ; $4125
	and a, $1f ; $4126
	ld d, a ; $4128
	ld a, e ; $4129
	and a, $1f ; $412a
	ld e, a ; $412c
	ld bc, $0020 ; $412d
	ld hl, $c3b4 ; $4130
	ld a, [hl+] ; $4133
	ld h, [hl] ; $4134
	ld l, a ; $4135
	ld a, e ; $4136
	or a, a ; $4137
	jr z, Label_05_413e ; $4138
Label_05_413a:
	add hl, bc ; $413a
	dec a ; $413b
	jr nz, Label_05_413a ; $413c
Label_05_413e:
	ld c, d ; $413e
	add hl, bc ; $413f
	ld d, h ; $4140
	ld e, l ; $4141
	pop hl ; $4142
	pop bc ; $4143
	pop af ; $4144
	ret ; $4145
	INCBIN "data/bank_005/d_4146.bin" ; $4146, 419 bytes
Func_05_42e9:
	call Func_05_7214 ; $42e9
	ret ; $42ec
Func_05_42ed:
	call Func_05_7205 ; $42ed
	ret ; $42f0
Func_05_42f1:
	rst Rst30 ; $42f1
	ld h, b ; $42f2
	inc bc ; $42f3
	ret nz ; $42f4
	push af ; $42f5
	push bc ; $42f6
	ld a, [$d824] ; $42f7
	call Func_05_42e9 ; $42fa
	pop bc ; $42fd
	pop af ; $42fe
	ret ; $42ff
Func_05_4300:
	call Func_05_6eea ; $4300
	ld a, [hl+] ; $4303
	add a, d ; $4304
	and a, $1f ; $4305
	ld d, a ; $4307
	ld a, [hl] ; $4308
	add a, e ; $4309
	and a, $1f ; $430a
	ld l, a ; $430c
	ld h, $00 ; $430d
	add hl, hl ; $430f
	add hl, hl ; $4310
	add hl, hl ; $4311
	add hl, hl ; $4312
	add hl, hl ; $4313
	ld a, d ; $4314
	add a, l ; $4315
	ld l, a ; $4316
	jr nc, Label_05_431a ; $4317
	inc h ; $4319
Label_05_431a:
	ld d, h ; $431a
	ld e, l ; $431b
	ret ; $431c
Func_05_431d:
	push af ; $431d
	push bc ; $431e
	push de ; $431f
	push hl ; $4320
	call Func_05_4300 ; $4321
	ld hl, $c3b4 ; $4324
	ld a, [hl+] ; $4327
	ld h, [hl] ; $4328
	ld l, a ; $4329
	ldh a, [$ff96] ; $432a
	push af ; $432c
	ld a, [$c3b3] ; $432d
	ld a, a ; $4330
	ldh [$ff96], a ; $4331
	ldh [rWBK], a ; $4333
	add hl, de ; $4335
	ld [hl], c ; $4336
	ld de, $0400 ; $4337
	add hl, de ; $433a
	ld [hl], b ; $433b
	pop af ; $433c
	ldh [$ff96], a ; $433d
	ldh [rWBK], a ; $433f
	pop hl ; $4341
	pop de ; $4342
	pop bc ; $4343
	pop af ; $4344
	ret ; $4345
	INCBIN "data/bank_005/d_4346.bin" ; $4346, 41 bytes
Func_05_436f:
	push af ; $436f
	push bc ; $4370
	push de ; $4371
	push hl ; $4372
	ldh a, [$ff96] ; $4373
	push af ; $4375
	call Func_05_4383 ; $4376
	pop af ; $4379
	ldh [$ff96], a ; $437a
	ldh [rWBK], a ; $437c
	pop hl ; $437e
	pop de ; $437f
	pop bc ; $4380
	pop af ; $4381
	ret ; $4382
Func_05_4383:
	ld a, [$c323] ; $4383
	and a, $3f ; $4386
	ld c, $04 ; $4388
Label_05_438a:
	ld b, $05 ; $438a
Label_05_438c:
	push af ; $438c
	push bc ; $438d
	call Func_05_43d2 ; $438e
	pop bc ; $4391
	pop af ; $4392
	inc a ; $4393
	and a, $3f ; $4394
	dec b ; $4396
	jr nz, Label_05_438c ; $4397
	push af ; $4399
	ldh a, [rLCDC] ; $439a
	bit 7, a ; $439c
	jr z, Label_05_43a3 ; $439e
	call Func_00_2631 ; $43a0
Label_05_43a3:
	pop af ; $43a3
	dec c ; $43a4
	jr nz, Label_05_438a ; $43a5
	ret ; $43a7
Func_05_43a8:
	push af ; $43a8
	push bc ; $43a9
	push de ; $43aa
	push hl ; $43ab
	call Func_05_6eea ; $43ac
	inc hl ; $43af
	ld b, [hl] ; $43b0
	inc hl ; $43b1
	inc hl ; $43b2
	ld c, [hl] ; $43b3
	ld a, [$c323] ; $43b4
	cp a, b ; $43b7
	jr c, Label_05_43c0 ; $43b8
	jr z, Label_05_43c0 ; $43ba
	ld a, $20 ; $43bc
	add a, b ; $43be
	ld b, a ; $43bf
Label_05_43c0:
	ld a, b ; $43c0
Label_05_43c1:
	push af ; $43c1
	push bc ; $43c2
	ld a, b ; $43c3
	call Func_05_43d2 ; $43c4
	pop bc ; $43c7
	pop af ; $43c8
	inc b ; $43c9
	dec c ; $43ca
	jr nz, Label_05_43c1 ; $43cb
	pop hl ; $43cd
	pop de ; $43ce
	pop bc ; $43cf
	pop af ; $43d0
	ret ; $43d1
Func_05_43d2:
	and a, $3f ; $43d2
	ld e, a ; $43d4
	ld hl, $d000 ; $43d5
	ld a, $06 ; $43d8
	ld bc, $0040 ; $43da
	ld d, e ; $43dd
Label_05_43de:
	rr d ; $43de
	jr nc, Label_05_43e3 ; $43e0
	add hl, bc ; $43e2
Label_05_43e3:
	sla c ; $43e3
	rl b ; $43e5
	dec a ; $43e7
	jr nz, Label_05_43de ; $43e8
	ld a, [$c321] ; $43ea
	and a, $3f ; $43ed
	ld d, a ; $43ef
	ld c, d ; $43f0
	ld b, $00 ; $43f1
	add hl, bc ; $43f3
	ld b, h ; $43f4
	ld c, l ; $43f5
	push bc ; $43f6
	ld a, $03 ; $43f7
	ldh [$ff96], a ; $43f9
	ldh [rWBK], a ; $43fb
	ld hl, $c6a0 ; $43fd
	ld a, c ; $4400
	and a, $1f ; $4401
	add a, l ; $4403
	ld l, a ; $4404
	jr nc, Label_05_4408 ; $4405
	inc h ; $4407
Label_05_4408:
	ld d, $20 ; $4408
Label_05_440a:
	ld a, [bc] ; $440a
	ld [hl+], a ; $440b
	inc bc ; $440c
	ld a, c ; $440d
	and a, $1f ; $440e
	jr nz, Label_05_441f ; $4410
	ld hl, $c6a0 ; $4412
	ld a, c ; $4415
	and a, $3f ; $4416
	jr nz, Label_05_441f ; $4418
	dec bc ; $441a
	ld a, c ; $441b
	and a, $c0 ; $441c
	ld c, a ; $441e
Label_05_441f:
	dec d ; $441f
	jr nz, Label_05_440a ; $4420
	ld hl, $d000 ; $4422
	ld a, e ; $4425
	and a, $1f ; $4426
	ld d, a ; $4428
	ld a, $05 ; $4429
	ld bc, $0020 ; $442b
Label_05_442e:
	rr d ; $442e
	jr nc, Label_05_4433 ; $4430
	add hl, bc ; $4432
Label_05_4433:
	sla c ; $4433
	rl b ; $4435
	dec a ; $4437
	jr nz, Label_05_442e ; $4438
	push de ; $443a
	ld d, h ; $443b
	ld e, l ; $443c
	ld hl, $c6a0 ; $443d
	ld a, $05 ; $4440
	ldh [$ff96], a ; $4442
	ldh [rWBK], a ; $4444
	ld bc, $0002 ; $4446
	call CopyMemoryFast ; $4449
	pop de ; $444c
	pop bc ; $444d
	ld hl, $c6a0 ; $444e
	ld a, $02 ; $4451
	ldh [$ff96], a ; $4453
	ldh [rWBK], a ; $4455
	ld a, c ; $4457
	and a, $1f ; $4458
	add a, l ; $445a
	ld l, a ; $445b
	jr nc, Label_05_445f ; $445c
	inc h ; $445e
Label_05_445f:
	ld d, $20 ; $445f
Label_05_4461:
	ld a, [bc] ; $4461
	ld [hl+], a ; $4462
	inc bc ; $4463
	ld a, c ; $4464
	and a, $1f ; $4465
	jr nz, Label_05_4476 ; $4467
	ld hl, $c6a0 ; $4469
	ld a, c ; $446c
	and a, $3f ; $446d
	jr nz, Label_05_4476 ; $446f
	dec bc ; $4471
	ld a, c ; $4472
	and a, $c0 ; $4473
	ld c, a ; $4475
Label_05_4476:
	dec d ; $4476
	jr nz, Label_05_4461 ; $4477
	ld hl, $d400 ; $4479
	ld a, e ; $447c
	and a, $1f ; $447d
	ld d, a ; $447f
	ld a, $05 ; $4480
	ld bc, $0020 ; $4482
Label_05_4485:
	rr d ; $4485
	jr nc, Label_05_448a ; $4487
	add hl, bc ; $4489
Label_05_448a:
	sla c ; $448a
	rl b ; $448c
	dec a ; $448e
	jr nz, Label_05_4485 ; $448f
	ld d, h ; $4491
	ld e, l ; $4492
	ld hl, $c6a0 ; $4493
	ld a, $05 ; $4496
	ldh [$ff96], a ; $4498
	ldh [rWBK], a ; $449a
	ld bc, $0002 ; $449c
	call CopyMemoryFast ; $449f
	ret ; $44a2
	INCBIN "data/bank_005/d_44a3.bin" ; $44a3, 149 bytes
Func_05_4538:
	push hl ; $4538
	ld a, d ; $4539
	and a, $1f ; $453a
	ld [hl+], a ; $453c
	ld a, e ; $453d
	and a, $1f ; $453e
	ld [hl+], a ; $4540
	ld [hl], b ; $4541
	inc hl ; $4542
	ld [hl], c ; $4543
	pop hl ; $4544
	ret ; $4545
	INCBIN "data/bank_005/d_4546.bin" ; $4546, 261 bytes
Func_05_464b:
	push af ; $464b
	push hl ; $464c
	ldh a, [$ff8b] ; $464d
	add a, $07 ; $464f
	rrca ; $4651
	rrca ; $4652
	rrca ; $4653
	and a, $1f ; $4654
	ld d, a ; $4656
	ldh a, [$ff8a] ; $4657
	add a, $07 ; $4659
	rrca ; $465b
	rrca ; $465c
	rrca ; $465d
	and a, $1f ; $465e
	ld e, a ; $4660
	pop hl ; $4661
	pop af ; $4662
	ret ; $4663
	INCBIN "data/bank_005/d_4664.bin" ; $4664, 36 bytes
Func_05_4688:
	push hl ; $4688
	ld a, b ; $4689
	ld [$d827], a ; $468a
	ld a, c ; $468d
	ld [$d828], a ; $468e
	push de ; $4691
	call Func_05_6e45 ; $4692
	ld [$d824], a ; $4695
	pop de ; $4698
	push af ; $4699
	ld h, d ; $469a
	ld l, e ; $469b
	call Func_05_464b ; $469c
	ld a, h ; $469f
	add a, d ; $46a0
	and a, $1f ; $46a1
	ld [$d825], a ; $46a3
	ld a, l ; $46a6
	add a, e ; $46a7
	and a, $1f ; $46a8
	ld [$d826], a ; $46aa
	pop af ; $46ad
	pop hl ; $46ae
	ret ; $46af
Func_05_46b0:
	push bc ; $46b0
	push de ; $46b1
	push hl ; $46b2
	ld a, $05 ; $46b3
	ldh [$ff96], a ; $46b5
	ldh [rWBK], a ; $46b7
	call Func_05_5c18 ; $46b9
	push hl ; $46bc
	ld h, d ; $46bd
	ld l, e ; $46be
	call Func_05_464b ; $46bf
	ld a, h ; $46c2
	add a, d ; $46c3
	and a, $1f ; $46c4
	ld d, a ; $46c6
	ld a, l ; $46c7
	add a, e ; $46c8
	and a, $1f ; $46c9
	ld e, a ; $46cb
	pop hl ; $46cc
	call Func_05_5745 ; $46cd
	ld a, c ; $46d0
	dec a ; $46d1
	sra a ; $46d2
	ld [$d831], a ; $46d4
	ld a, b ; $46d7
	srl b ; $46d8
	srl b ; $46da
	srl b ; $46dc
	and a, $07 ; $46de
	jr z, Label_05_46e3 ; $46e0
	inc b ; $46e2
Label_05_46e3:
	inc b ; $46e3
	inc b ; $46e4
	inc b ; $46e5
	call Func_05_6e6d ; $46e6
	ld a, [$d820] ; $46e9
	cp a, $ff ; $46ec
	jp z, Label_05_4743 ; $46ee
	ld a, [$d820] ; $46f1
	ld b, a ; $46f4
	call Func_05_55d5 ; $46f5
	ld a, [$d820] ; $46f8
	ld b, $02 ; $46fb
	call Func_05_4767 ; $46fd
	ld a, [$d83e] ; $4700
	cp a, $ff ; $4703
	jr z, Label_05_4719 ; $4705
	ld hl, $d832 ; $4707
	sla a ; $470a
	ld c, a ; $470c
	ld b, $00 ; $470d
	add hl, bc ; $470f
	ld a, [$d830] ; $4710
	ld b, a ; $4713
	ld a, [hl] ; $4714
	and a, $f0 ; $4715
	or a, b ; $4717
	ld [hl], a ; $4718
Label_05_4719:
	ld a, [$d83e] ; $4719
	inc a ; $471c
	ld [$d83e], a ; $471d
	ld hl, $d832 ; $4720
	sla a ; $4723
	ld c, a ; $4725
	ld b, $00 ; $4726
	add hl, bc ; $4728
	ld a, [$d831] ; $4729
	sla a ; $472c
	sla a ; $472e
	sla a ; $4730
	sla a ; $4732
	ld [hl+], a ; $4734
	ld a, [$d820] ; $4735
	ld [$d82f], a ; $4738
	ld [hl], a ; $473b
	xor a, a ; $473c
	ld [$d830], a ; $473d
	ld a, [$d820] ; $4740
Label_05_4743:
	pop hl ; $4743
	pop de ; $4744
	pop bc ; $4745
	ret ; $4746
Func_05_4747:
	call Func_05_46b0 ; $4747
	push af ; $474a
	push bc ; $474b
	ld a, [$d820] ; $474c
	ld b, $03 ; $474f
	call Func_05_4767 ; $4751
	pop bc ; $4754
	pop af ; $4755
	ret ; $4756
Func_05_4757:
	push af ; $4757
	call Func_05_6eea ; $4758
	ld a, $04 ; $475b
	add a, l ; $475d
	ld l, a ; $475e
	jr nc, Label_05_4762 ; $475f
	inc h ; $4761
Label_05_4762:
	ld [hl], $ff ; $4762
	pop af ; $4764
	ret ; $4765
	INCBIN "data/bank_005/d_4766.bin" ; $4766, 1 bytes
Func_05_4767:
	call Func_05_6eea ; $4767
	ld a, $04 ; $476a
	add a, l ; $476c
	ld l, a ; $476d
	jr nc, Label_05_4771 ; $476e
	inc h ; $4770
Label_05_4771:
	ld [hl], b ; $4771
	ret ; $4772
Func_05_4773:
	call Func_05_6eea ; $4773
	ld a, $04 ; $4776
	add a, l ; $4778
	ld l, a ; $4779
	jr nc, Label_05_477d ; $477a
	inc h ; $477c
Label_05_477d:
	ld a, [hl] ; $477d
	ret ; $477e
Func_05_477f:
	push bc ; $477f
	push de ; $4780
	push hl ; $4781
	ldh a, [$ff96] ; $4782
	push af ; $4784
	ld a, $05 ; $4785
	ldh [$ff96], a ; $4787
	ldh [rWBK], a ; $4789
	xor a, a ; $478b
	ld [$d844], a ; $478c
	ld [$d845], a ; $478f
	ld a, $ff ; $4792
	ld hl, $d842 ; $4794
	ld [hl+], a ; $4797
	ld [hl], a ; $4798
	ld a, [$d82f] ; $4799
	call Func_05_6eea ; $479c
	ld d, [hl] ; $479f
	inc hl ; $47a0
	ld e, [hl] ; $47a1
	inc d ; $47a2
	inc e ; $47a3
	push af ; $47a4
	push bc ; $47a5
	push de ; $47a6
	push hl ; $47a7
	ld a, [$d830] ; $47a8
	sla a ; $47ab
	add a, e ; $47ad
	ld e, a ; $47ae
	call Func_05_4122 ; $47af
	xor a, a ; $47b2
	ld hl, $d841 ; $47b3
	ld [hl+], a ; $47b6
	ld [hl], e ; $47b7
	inc hl ; $47b8
	ld [hl], d ; $47b9
	ld a, $01 ; $47ba
	ld hl, $48f1 ; $47bc
	call Func_00_1b6a ; $47bf
	pop hl ; $47c2
	pop de ; $47c3
	pop bc ; $47c4
	pop af ; $47c5
	ld a, [$d830] ; $47c6
	ld b, a ; $47c9
Label_05_47ca:
	call Func_00_2631 ; $47ca
	ldh a, [$ff94] ; $47cd
	bit 0, a ; $47cf
	jr nz, Label_05_4840 ; $47d1
	ldh a, [$ff91] ; $47d3
	bit 6, a ; $47d5
	jr z, Label_05_47e5 ; $47d7
	dec b ; $47d9
	bit 7, b ; $47da
	jr z, Label_05_47f7 ; $47dc
	ld a, [$d831] ; $47de
	dec a ; $47e1
	ld b, a ; $47e2
	jr Label_05_47f7 ; $47e3
Label_05_47e5:
	ldh a, [$ff91] ; $47e5
	and a, $80 ; $47e7
	jp z, Label_05_486d ; $47e9
	ld a, [$d831] ; $47ec
	ld c, a ; $47ef
	inc b ; $47f0
	ld a, b ; $47f1
	cp a, c ; $47f2
	jr c, Label_05_47f7 ; $47f3
	ld b, $00 ; $47f5
Label_05_47f7:
	rst Rst08 ; $47f7
	ld e, [hl] ; $47f8
	push de ; $47f9
	xor a, a ; $47fa
	ld [$d841], a ; $47fb
	ld a, b ; $47fe
	sla a ; $47ff
	add a, e ; $4801
	ld e, a ; $4802
	ld a, $20 ; $4803
	call Func_05_40fb ; $4805
	push af ; $4808
	push bc ; $4809
	push de ; $480a
	push hl ; $480b
	ld hl, $d842 ; $480c
	ld a, [hl+] ; $480f
	ld h, [hl] ; $4810
	ld l, a ; $4811
	ld de, $3000 ; $4812
	add hl, de ; $4815
	ld de, $9800 ; $4816
	add hl, de ; $4819
	ld d, h ; $481a
	ld e, l ; $481b
	ld hl, $d844 ; $481c
	ld a, e ; $481f
	ld [hl+], a ; $4820
	ld a, d ; $4821
	ld [hl], a ; $4822
	pop hl ; $4823
	pop de ; $4824
	pop bc ; $4825
	pop af ; $4826
	pop de ; $4827
	push de ; $4828
	ld a, b ; $4829
	sla a ; $482a
	add a, e ; $482c
	ld e, a ; $482d
	push hl ; $482e
	call Func_05_4122 ; $482f
	ld hl, $d842 ; $4832
	ld [hl], e ; $4835
	inc hl ; $4836
	ld [hl], d ; $4837
	pop hl ; $4838
	pop de ; $4839
	ld a, b ; $483a
	ld [$d830], a ; $483b
	jr Label_05_486d ; $483e
Label_05_4840:
	ld a, b ; $4840
	ld [$d830], a ; $4841
	rst Rst08 ; $4844
	ld e, a ; $4845
	push af ; $4846
	push bc ; $4847
	push de ; $4848
	push hl ; $4849
	ld hl, $48f1 ; $484a
	call Func_00_1bcb ; $484d
	call Func_00_2631 ; $4850
	ld a, [$d830] ; $4853
	sla a ; $4856
	inc a ; $4858
	ld e, a ; $4859
	ld d, $01 ; $485a
	ld a, [$d82f] ; $485c
	ld c, $0d ; $485f
	ld b, $80 ; $4861
	call Func_05_431d ; $4863
	pop hl ; $4866
	pop de ; $4867
	pop bc ; $4868
	pop af ; $4869
	jp Label_05_48e6 ; $486a
Label_05_486d:
	ldh a, [$ff94] ; $486d
	and a, $08 ; $486f
	jp z, Label_05_487b ; $4871
	rst Rst08 ; $4874
	ld h, d ; $4875
	ld a, $ff ; $4876
	jp Label_05_48af ; $4878
Label_05_487b:
	ldh a, [$ff91] ; $487b
	and a, $02 ; $487d
	jp z, Label_05_4888 ; $487f
	rst Rst08 ; $4882
	ld h, d ; $4883
	ld a, $ff ; $4884
	jr Label_05_48af ; $4886
Label_05_4888:
	call Func_05_4773 ; $4888
	cp a, $03 ; $488b
	jp nz, Label_05_47ca ; $488d
	ld a, [$c32d] ; $4890
	dec a ; $4893
	srl a ; $4894
	srl a ; $4896
	jp z, Label_05_47ca ; $4898
	ldh a, [$ff91] ; $489b
	and a, $20 ; $489d
	jp z, Label_05_48a6 ; $489f
	ld a, $fe ; $48a2
	jr Label_05_48af ; $48a4
Label_05_48a6:
	ldh a, [$ff91] ; $48a6
	and a, $10 ; $48a8
	jp z, Label_05_47ca ; $48aa
	ld a, $fd ; $48ad
Label_05_48af:
	ld [$d830], a ; $48af
	push af ; $48b2
	push bc ; $48b3
	push de ; $48b4
	push hl ; $48b5
	ld hl, $48f1 ; $48b6
	call Func_00_1bcb ; $48b9
	call Func_00_2631 ; $48bc
	ld a, [$d83e] ; $48bf
	or a, a ; $48c2
	jr z, Label_05_48e2 ; $48c3
	dec a ; $48c5
	ld hl, $d832 ; $48c6
	sla a ; $48c9
	ld c, a ; $48cb
	ld b, $00 ; $48cc
	add hl, bc ; $48ce
	ld a, [hl+] ; $48cf
	and a, $0f ; $48d0
	sla a ; $48d2
	inc a ; $48d4
	ld e, a ; $48d5
	ld d, $01 ; $48d6
	ld a, [hl] ; $48d8
	and a, $0f ; $48d9
	ld c, $20 ; $48db
	ld b, $80 ; $48dd
	call Func_05_431d ; $48df
Label_05_48e2:
	pop hl ; $48e2
	pop de ; $48e3
	pop bc ; $48e4
	pop af ; $48e5
Label_05_48e6:
	ld b, a ; $48e6
	pop af ; $48e7
	ldh [$ff96], a ; $48e8
	ldh [rWBK], a ; $48ea
	ld a, b ; $48ec
	pop hl ; $48ed
	pop de ; $48ee
	pop bc ; $48ef
	ret ; $48f0
	push af ; $48f1
	push bc ; $48f2
	push de ; $48f3
	push hl ; $48f4
	ld a, $05 ; $48f5
	ldh [$ff96], a ; $48f7
	ldh [rWBK], a ; $48f9
	ld hl, $d841 ; $48fb
	ld a, [hl+] ; $48fe
	and a, $10 ; $48ff
	or a, a ; $4901
	jr z, Label_05_4908 ; $4902
	ld a, $20 ; $4904
	jr Label_05_490a ; $4906
Label_05_4908:
	ld a, $0d ; $4908
Label_05_490a:
	ld e, [hl] ; $490a
	inc hl ; $490b
	ld d, [hl] ; $490c
	ld h, d ; $490d
	ld l, e ; $490e
	ld de, $3000 ; $490f
	add hl, de ; $4912
	ld de, $9800 ; $4913
	add hl, de ; $4916
	ld d, h ; $4917
	ld e, l ; $4918
	ld l, a ; $4919
	ld h, $80 ; $491a
	push de ; $491c
	call Func_00_0507 ; $491d
	pop de ; $4920
	ld a, [$d841] ; $4921
	inc a ; $4924
	ld [$d841], a ; $4925
	ld a, [$d844] ; $4928
	or a, a ; $492b
	jr z, Label_05_493f ; $492c
	ld e, a ; $492e
	ld a, [$d845] ; $492f
	ld d, a ; $4932
	ld a, $20 ; $4933
	ld l, a ; $4935
	ld h, $80 ; $4936
	call Func_00_0507 ; $4938
	xor a, a ; $493b
	ld [$d844], a ; $493c
Label_05_493f:
	pop hl ; $493f
	pop de ; $4940
	pop bc ; $4941
	pop af ; $4942
	ret ; $4943
Func_05_4944:
	push bc ; $4944
	push de ; $4945
	push hl ; $4946
	ld b, a ; $4947
	ldh a, [$ff96] ; $4948
	push af ; $494a
	ld a, $05 ; $494b
	ldh [$ff96], a ; $494d
	ldh [rWBK], a ; $494f
	ld a, b ; $4951
	add sp, -3 ; $4952
	ld b, h ; $4954
	ld c, l ; $4955
	ld hl, sp + 0 ; $4956
	ld [hl], b ; $4958
	ld hl, sp + 1 ; $4959
	ld [hl], c ; $495b
	ld hl, sp + 2 ; $495c
	ld [hl], a ; $495e
	ld a, $05 ; $495f
	ldh [$ff96], a ; $4961
	ldh [rWBK], a ; $4963
	xor a, a ; $4965
	ld [$d846], a ; $4966
Label_05_4969:
	ld hl, sp + 0 ; $4969
	ld b, [hl] ; $496b
	ld hl, sp + 1 ; $496c
	ld c, [hl] ; $496e
	ld a, [$d846] ; $496f
	ld h, $00 ; $4972
	ld l, a ; $4974
	add hl, bc ; $4975
	ld d, $01 ; $4976
	ld e, $01 ; $4978
	call Func_05_4747 ; $497a
	farcall FarPtr_05_18 ; $497d
	call Func_05_7232 ; $4980
	call Func_05_477f ; $4983
	push af ; $4986
	ld a, [$d82f] ; $4987
	call Func_05_72bd ; $498a
	ld a, $ff ; $498d
	ld [$d82f], a ; $498f
	pop af ; $4992
	cp a, $7f ; $4993
	jr nc, Label_05_49a2 ; $4995
	ld b, a ; $4997
	ld a, [$d846] ; $4998
	sla a ; $499b
	sla a ; $499d
	add a, b ; $499f
	jr Label_05_49cc ; $49a0
Label_05_49a2:
	cp a, $ff ; $49a2
	jr z, Label_05_49cc ; $49a4
	cp a, $fe ; $49a6
	jr nz, Label_05_49bb ; $49a8
	ld a, [$d846] ; $49aa
	dec a ; $49ad
	cp a, $ff ; $49ae
	jr nz, Label_05_49b6 ; $49b0
	ld hl, sp + 2 ; $49b2
	ld a, [hl] ; $49b4
	dec a ; $49b5
Label_05_49b6:
	ld [$d846], a ; $49b6
	jr Label_05_4969 ; $49b9
Label_05_49bb:
	ld a, [$d846] ; $49bb
	inc a ; $49be
	ld hl, sp + 2 ; $49bf
	ld b, [hl] ; $49c1
	cp a, b ; $49c2
	jr c, Label_05_49c6 ; $49c3
	xor a, a ; $49c5
Label_05_49c6:
	ld [$d846], a ; $49c6
	jp Label_05_4969 ; $49c9
Label_05_49cc:
	ld [$d830], a ; $49cc
	add sp, 3 ; $49cf
	ld b, a ; $49d1
	pop af ; $49d2
	ldh [$ff96], a ; $49d3
	ldh [rWBK], a ; $49d5
	ld a, b ; $49d7
	pop hl ; $49d8
	pop de ; $49d9
	pop bc ; $49da
	ret ; $49db
	INCBIN "data/bank_005/d_49dc.bin" ; $49dc, 1065 bytes
	farcall FarPtr_1a_02 ; $4e05
	jr Label_05_4e0f ; $4e08
	INCBIN "data/bank_005/d_4e0a.bin" ; $4e0a, 5 bytes
Label_05_4e0f:
	ret ; $4e0f
	INCBIN "data/bank_005/d_4e10.bin" ; $4e10, 19 bytes
Func_05_4e23:
	push bc ; $4e23
	ld a, [$d84f] ; $4e24
	or a, a ; $4e27
	jr z, Label_05_4e3b ; $4e28
	ld bc, $3a00 ; $4e2a
	add hl, bc ; $4e2d
	ld b, h ; $4e2e
	ld c, l ; $4e2f
	ld hl, $d84e ; $4e30
	ld a, [hl+] ; $4e33
	ld h, [hl] ; $4e34
	ld l, a ; $4e35
	add hl, bc ; $4e36
	xor a, a ; $4e37
	ld [$d84f], a ; $4e38
Label_05_4e3b:
	ld a, [$d821] ; $4e3b
	or a, a ; $4e3e
	jr nz, Label_05_4e48 ; $4e3f
	xor a, a ; $4e41
	ld [$c3bb], a ; $4e42
	ld [$c3bc], a ; $4e45
Label_05_4e48:
	call Func_05_752d ; $4e48
	call Func_05_42f1 ; $4e4b
	ld a, d ; $4e4e
	and a, $1f ; $4e4f
	ld [$d82a], a ; $4e51
	ld a, e ; $4e54
	and a, $1f ; $4e55
	ld [$d82b], a ; $4e57
	call Func_05_4122 ; $4e5a
Label_05_4e5d:
	ld a, [$d850] ; $4e5d
	or a, a ; $4e60
	jr z, Label_05_4e6d ; $4e61
	ld a, l ; $4e63
	ld [$d84e], a ; $4e64
	ld a, h ; $4e67
	ld [$d84f], a ; $4e68
	pop bc ; $4e6b
	ret ; $4e6c
Label_05_4e6d:
	ld a, l ; $4e6d
	ld [$d869], a ; $4e6e
	ld a, h ; $4e71
	ld [$d86a], a ; $4e72
	ld a, [hl] ; $4e75
	inc hl ; $4e76
	ld b, a ; $4e77
	or a, a ; $4e78
	jr nz, Label_05_4e85 ; $4e79
	rst Rst30 ; $4e7b
	ld h, b ; $4e7c
	inc b ; $4e7d
	jr nz, Label_05_4e83 ; $4e7e
	call Func_05_77a3 ; $4e80
Label_05_4e83:
	pop bc ; $4e83
	ret ; $4e84
Label_05_4e85:
	cp a, $de ; $4e85
	jr z, Label_05_4e97 ; $4e87
	cp a, $df ; $4e89
	jr z, Label_05_4e9b ; $4e8b
	cp a, $0e ; $4e8d
	jr z, Label_05_4e9f ; $4e8f
	cp a, $20 ; $4e91
	jr nc, Label_05_4ead ; $4e93
	jr Label_05_4ea5 ; $4e95
Label_05_4e97:
	ld a, $1e ; $4e97
	jr Label_05_4ea5 ; $4e99
Label_05_4e9b:
	ld a, $1f ; $4e9b
	jr Label_05_4ea5 ; $4e9d
Label_05_4e9f:
	push af ; $4e9f
	ld a, [hl+] ; $4ea0
	ld [$c361], a ; $4ea1
	pop af ; $4ea4
Label_05_4ea5:
	call Func_05_546c ; $4ea5
	call Func_05_42f1 ; $4ea8
	jr Label_05_4e5d ; $4eab
Label_05_4ead:
	ld a, b ; $4ead
	call Func_05_5413 ; $4eae
	call Func_05_757e ; $4eb1
	call Func_05_7607 ; $4eb4
	call Func_05_579b ; $4eb7
	inc de ; $4eba
	ld a, e ; $4ebb
	and a, $1f ; $4ebc
	jp nz, Label_05_4e5d ; $4ebe
	push hl ; $4ec1
	push de ; $4ec2
	ld h, d ; $4ec3
	ld l, e ; $4ec4
	ld de, $ffe0 ; $4ec5
	add hl, de ; $4ec8
	ld d, h ; $4ec9
	ld e, l ; $4eca
	pop de ; $4ecb
	pop hl ; $4ecc
	jp Label_05_4e5d ; $4ecd
	call Func_05_757e ; $4ed0
	push af ; $4ed3
	ld a, [$d82b] ; $4ed4
	inc a ; $4ed7
	inc a ; $4ed8
	and a, $1f ; $4ed9
	ld [$d82b], a ; $4edb
	ld e, a ; $4ede
	ld a, [$d82a] ; $4edf
	ld d, a ; $4ee2
	call Func_05_4122 ; $4ee3
	pop af ; $4ee6
	ret ; $4ee7
	INCBIN "data/bank_005/d_4ee8.bin" ; $4ee8, 1 bytes
	push af ; $4ee9
	push bc ; $4eea
	push hl ; $4eeb
	ld hl, $cb76 ; $4eec
	ld a, [hl+] ; $4eef
	ld h, [hl] ; $4ef0
	ld l, a ; $4ef1
	ld a, $40 ; $4ef2
	add a, l ; $4ef4
	ld l, a ; $4ef5
	jr nc, Label_05_4ef9 ; $4ef6
	inc h ; $4ef8
Label_05_4ef9:
	ld b, h ; $4ef9
	ld c, l ; $4efa
	ld hl, $cb76 ; $4efb
	ld a, c ; $4efe
	ld [hl+], a ; $4eff
	ld [hl], b ; $4f00
	call Func_05_75db ; $4f01
	ldh a, [$ff96] ; $4f04
	push af ; $4f06
	ld a, $05 ; $4f07
	ldh [$ff96], a ; $4f09
	ldh [rWBK], a ; $4f0b
	ld hl, $d864 ; $4f0d
	ld a, [hl+] ; $4f10
	ld h, [hl] ; $4f11
	ld l, a ; $4f12
	ld a, [$c362] ; $4f13
	cpl ; $4f16
	inc a ; $4f17
	sla a ; $4f18
	add a, l ; $4f1a
	ld l, a ; $4f1b
	jr nc, Label_05_4f1f ; $4f1c
	inc h ; $4f1e
Label_05_4f1f:
	ld a, l ; $4f1f
	ld [$d864], a ; $4f20
	ld a, h ; $4f23
	ld [$d865], a ; $4f24
	ld d, h ; $4f27
	ld e, l ; $4f28
	pop af ; $4f29
	ldh [$ff96], a ; $4f2a
	ldh [rWBK], a ; $4f2c
	pop hl ; $4f2e
	pop bc ; $4f2f
	pop af ; $4f30
	ret ; $4f31
	INCBIN "data/bank_005/d_4f32.bin" ; $4f32, 29 bytes
	push af ; $4f4f
	push bc ; $4f50
	ld a, [$d829] ; $4f51
	or a, a ; $4f54
	jr nz, Label_05_4f63 ; $4f55
	ld a, $01 ; $4f57
	ld [$d829], a ; $4f59
	call Func_05_42f1 ; $4f5c
	xor a, a ; $4f5f
	ld [$d829], a ; $4f60
Label_05_4f63:
	ld b, $0f ; $4f63
Label_05_4f65:
	call Func_00_2631 ; $4f65
	ldh a, [$ff91] ; $4f68
	and a, $f3 ; $4f6a
	jr nz, Label_05_4f71 ; $4f6c
	dec b ; $4f6e
	jr nz, Label_05_4f65 ; $4f6f
Label_05_4f71:
	pop bc ; $4f71
	pop af ; $4f72
	ret ; $4f73
	push af ; $4f74
	push de ; $4f75
	ld a, $01 ; $4f76
	call Func_05_5413 ; $4f78
	call Func_05_4fbf ; $4f7b
	call Func_05_4122 ; $4f7e
	ld [de], a ; $4f81
	call Func_05_42f1 ; $4f82
	xor a, a ; $4f85
	ld hl, $d841 ; $4f86
	ld [hl+], a ; $4f89
	ld [hl], e ; $4f8a
	inc hl ; $4f8b
	ld [hl], d ; $4f8c
	push af ; $4f8d
	push bc ; $4f8e
	push de ; $4f8f
	push hl ; $4f90
	ld a, $01 ; $4f91
	ld hl, $4fe3 ; $4f93
	call Func_00_1b6a ; $4f96
	call Func_05_501d ; $4f99
	ld a, $10 ; $4f9c
	ld [$d841], a ; $4f9e
	call Func_00_2631 ; $4fa1
	ld hl, $4fe3 ; $4fa4
	call Func_00_1bcb ; $4fa7
	rst Rst20 ; $4faa
	jr nz, Label_05_4fb0 ; $4fab
	call Func_00_2631 ; $4fad
Label_05_4fb0:
	rst Rst28 ; $4fb0
	jr nz, Label_05_4fb6 ; $4fb1
	pop hl ; $4fb3
	pop de ; $4fb4
	pop bc ; $4fb5
Label_05_4fb6:
	pop af ; $4fb6
	ld a, $01 ; $4fb7
	ld [$d850], a ; $4fb9
	pop de ; $4fbc
	pop af ; $4fbd
	ret ; $4fbe
Func_05_4fbf:
	rst Rst30 ; $4fbf
	ld h, b ; $4fc0
	inc bc ; $4fc1
	jr z, Label_05_4fc9 ; $4fc2
	ld d, $0a ; $4fc4
	ld e, $11 ; $4fc6
	ret ; $4fc8
Label_05_4fc9:
	push af ; $4fc9
	push bc ; $4fca
	push hl ; $4fcb
	ld a, [$d824] ; $4fcc
	call Func_05_6eea ; $4fcf
	ld d, [hl] ; $4fd2
	inc hl ; $4fd3
	ld e, [hl] ; $4fd4
	inc hl ; $4fd5
	ld a, [hl+] ; $4fd6
	sra a ; $4fd7
	add a, d ; $4fd9
	ld d, a ; $4fda
	ld a, [hl+] ; $4fdb
	dec a ; $4fdc
	add a, e ; $4fdd
	ld e, a ; $4fde
	pop hl ; $4fdf
	pop bc ; $4fe0
	pop af ; $4fe1
	ret ; $4fe2
	push af ; $4fe3
	push bc ; $4fe4
	push de ; $4fe5
	push hl ; $4fe6
	ld a, $05 ; $4fe7
	ldh [$ff96], a ; $4fe9
	ldh [rWBK], a ; $4feb
	ld hl, $d841 ; $4fed
	ld a, [hl+] ; $4ff0
	and a, $10 ; $4ff1
	or a, a ; $4ff3
	jr z, Label_05_4ffa ; $4ff4
	ld a, $08 ; $4ff6
	jr Label_05_4ffc ; $4ff8
Label_05_4ffa:
	ld a, $01 ; $4ffa
Label_05_4ffc:
	ld e, [hl] ; $4ffc
	inc hl ; $4ffd
	ld d, [hl] ; $4ffe
	ld h, d ; $4fff
	ld l, e ; $5000
	ld de, $3000 ; $5001
	add hl, de ; $5004
	ld de, $9800 ; $5005
	add hl, de ; $5008
	ld d, h ; $5009
	ld e, l ; $500a
	ld l, a ; $500b
	ld h, $80 ; $500c
	call Func_00_0507 ; $500e
	ld a, [$d841] ; $5011
	inc a ; $5014
	ld [$d841], a ; $5015
	pop hl ; $5018
	pop de ; $5019
	pop bc ; $501a
	pop af ; $501b
	ret ; $501c
Func_05_501d:
	push af ; $501d
	push bc ; $501e
	ld a, [$d829] ; $501f
	or a, a ; $5022
	jr nz, Label_05_5031 ; $5023
	ld a, $01 ; $5025
	ld [$d829], a ; $5027
	call Func_05_42f1 ; $502a
	xor a, a ; $502d
	ld [$d829], a ; $502e
Label_05_5031:
	call Func_05_42f1 ; $5031
	rst Rst30 ; $5034
	ret nz ; $5035
	ld [bc], a ; $5036
	jr nz, Label_05_5061 ; $5037
	call Func_05_77a3 ; $5039
	ldh a, [hPlayerInputFlags] ; $503c
	and a, $f3 ; $503e
	jr z, Label_05_5050 ; $5040
	ld b, $1e ; $5042
Label_05_5044:
	call Func_00_2631 ; $5044
	ldh a, [hPlayerInputFlags] ; $5047
	and a, $f3 ; $5049
	jr z, Label_05_5050 ; $504b
	dec b ; $504d
	jr nz, Label_05_5044 ; $504e
Label_05_5050:
	rst Rst30 ; $5050
	ret nz ; $5051
	ld [bc], a ; $5052
	jr nz, Label_05_5061 ; $5053
	call Func_00_0a3a ; $5055
	call Func_00_2631 ; $5058
	ldh a, [$ff91] ; $505b
	and a, $f3 ; $505d
	jr z, Label_05_5050 ; $505f
Label_05_5061:
	pop bc ; $5061
	pop af ; $5062
	ret ; $5063
	INCBIN "data/bank_005/d_5064.bin" ; $5064, 147 bytes
Func_05_50f7:
	push af ; $50f7
	push bc ; $50f8
	push de ; $50f9
	push hl ; $50fa
	ld a, h ; $50fb
	and a, $f0 ; $50fc
	cp a, $d0 ; $50fe
	jr nz, Label_05_5114 ; $5100
	ld a, h ; $5102
	and a, $0f ; $5103
	ld b, a ; $5105
	ldh a, [$ff96] ; $5106
	sla a ; $5108
	sla a ; $510a
	sla a ; $510c
	sla a ; $510e
	or a, b ; $5110
	ld h, a ; $5111
	jr Label_05_5118 ; $5112
Label_05_5114:
	ld a, h ; $5114
	and a, $0f ; $5115
	ld h, a ; $5117
Label_05_5118:
	ldh a, [$ff96] ; $5118
	push af ; $511a
	ld a, $05 ; $511b
	ldh [$ff96], a ; $511d
	ldh [rWBK], a ; $511f
	ld d, h ; $5121
	ld e, l ; $5122
	ld a, [$d847] ; $5123
	cp a, $10 ; $5126
	jr z, Label_05_513d ; $5128
	ld b, $00 ; $512a
	ld c, a ; $512c
	sla c ; $512d
	inc a ; $512f
	ld [$d847], a ; $5130
	ld [$d84a], a ; $5133
	ld hl, $d8b0 ; $5136
	add hl, bc ; $5139
	ld [hl], e ; $513a
	inc hl ; $513b
	ld [hl], d ; $513c
Label_05_513d:
	pop af ; $513d
	ldh [$ff96], a ; $513e
	ldh [rWBK], a ; $5140
	pop hl ; $5142
	pop de ; $5143
	pop bc ; $5144
	pop af ; $5145
	ret ; $5146
Func_05_5147:
	push af ; $5147
	push bc ; $5148
	push de ; $5149
	push hl ; $514a
	ldh a, [$ff96] ; $514b
	push af ; $514d
	ld a, $05 ; $514e
	ldh [$ff96], a ; $5150
	ldh [rWBK], a ; $5152
	ld d, h ; $5154
	ld e, l ; $5155
	ld a, [$d848] ; $5156
	cp a, $10 ; $5159
	jr z, Label_05_5170 ; $515b
	ld b, $00 ; $515d
	ld c, a ; $515f
	sla c ; $5160
	inc a ; $5162
	ld [$d848], a ; $5163
	ld [$d84b], a ; $5166
	ld hl, $d8d0 ; $5169
	add hl, bc ; $516c
	ld [hl], e ; $516d
	inc hl ; $516e
	ld [hl], d ; $516f
Label_05_5170:
	pop af ; $5170
	ldh [$ff96], a ; $5171
	ldh [rWBK], a ; $5173
	pop hl ; $5175
	pop de ; $5176
	pop bc ; $5177
	pop af ; $5178
	ret ; $5179
	INCBIN "data/bank_005/d_517a.bin" ; $517a, 110 bytes
	push af ; $51e8
	push bc ; $51e9
	ld hl, $c900 ; $51ea
	call Func_05_54cf ; $51ed
	pop bc ; $51f0
	pop af ; $51f1
	ret ; $51f2
	push af ; $51f3
	push bc ; $51f4
	ld hl, $c940 ; $51f5
	call Func_05_54cf ; $51f8
	pop bc ; $51fb
	pop af ; $51fc
	ret ; $51fd
Func_05_51fe:
	push bc ; $51fe
	push hl ; $51ff
	ld a, $05 ; $5200
	ldh [$ff96], a ; $5202
	ldh [rWBK], a ; $5204
	ld a, [$d866] ; $5206
	ld b, $00 ; $5209
	ld c, a ; $520b
	inc a ; $520c
	ld [$d866], a ; $520d
	sla c ; $5210
	ld hl, $d8b0 ; $5212
	add hl, bc ; $5215
	ld a, [hl+] ; $5216
	ld h, [hl] ; $5217
	ld l, a ; $5218
	ld a, h ; $5219
	sra a ; $521a
	res 7, a ; $521c
	sra a ; $521e
	sra a ; $5220
	sra a ; $5222
	or a, a ; $5224
	jr z, Label_05_5235 ; $5225
	ld b, a ; $5227
	ld a, h ; $5228
	and a, $0f ; $5229
	or a, $d0 ; $522b
	ld h, a ; $522d
	ld a, b ; $522e
	ldh [$ff96], a ; $522f
	ldh [rWBK], a ; $5231
	jr Label_05_5241 ; $5233
Label_05_5235:
	ld b, a ; $5235
	ld a, h ; $5236
	and a, $0f ; $5237
	or a, $c0 ; $5239
	ld h, a ; $523b
	ld a, b ; $523c
	ldh [$ff96], a ; $523d
	ldh [rWBK], a ; $523f
Label_05_5241:
	push de ; $5241
	ld de, $c6c0 ; $5242
	ld bc, $0020 ; $5245
	call CopyMemoryBC ; $5248
	pop de ; $524b
	ld a, $05 ; $524c
	ldh [$ff96], a ; $524e
	ldh [rWBK], a ; $5250
	ld hl, $c6c0 ; $5252
	ld b, $00 ; $5255
Label_05_5257:
	ld a, [hl+] ; $5257
	or a, a ; $5258
	jr z, Label_05_5263 ; $5259
	call Func_05_7366 ; $525b
	ld a, c ; $525e
	add a, b ; $525f
	ld b, a ; $5260
	jr Label_05_5257 ; $5261
Label_05_5263:
	ld a, b ; $5263
	pop hl ; $5264
	pop bc ; $5265
	ret ; $5266
Func_05_5267:
	push bc ; $5267
	push hl ; $5268
	ld hl, $c900 ; $5269
	ld b, $00 ; $526c
Label_05_526e:
	ld a, [hl+] ; $526e
	cp a, $00 ; $526f
	jr z, Label_05_527b ; $5271
	call Func_05_7366 ; $5273
	ld a, c ; $5276
	add a, b ; $5277
	ld b, a ; $5278
	jr Label_05_526e ; $5279
Label_05_527b:
	ld a, b ; $527b
	pop hl ; $527c
	pop bc ; $527d
	ret ; $527e
Func_05_527f:
	push bc ; $527f
	push hl ; $5280
	ld hl, $c940 ; $5281
	ld b, $00 ; $5284
Label_05_5286:
	ld a, [hl+] ; $5286
	cp a, $00 ; $5287
	jr z, Label_05_5293 ; $5289
	call Func_05_7366 ; $528b
	ld a, c ; $528e
	add a, b ; $528f
	ld b, a ; $5290
	jr Label_05_5286 ; $5291
Label_05_5293:
	ld a, b ; $5293
	pop hl ; $5294
	pop bc ; $5295
	ret ; $5296
	INCBIN "data/bank_005/d_5297.bin" ; $5297, 1 bytes
Func_05_5298:
	push bc ; $5298
	push hl ; $5299
	ld a, [$d868] ; $529a
	ld b, $00 ; $529d
	ld c, a ; $529f
	inc a ; $52a0
	ld [$d868], a ; $52a1
	ld hl, $d8f0 ; $52a4
	add hl, bc ; $52a7
	ld a, [hl] ; $52a8
	ld l, a ; $52a9
	ld h, $00 ; $52aa
	ld b, h ; $52ac
	ld c, l ; $52ad
	ld hl, $0000 ; $52ae
	add hl, bc ; $52b1
	call Func_05_5ca8 ; $52b2
	ld hl, $d880 ; $52b5
	ld b, $00 ; $52b8
Label_05_52ba:
	ld a, [hl+] ; $52ba
	cp a, $00 ; $52bb
	jr z, Label_05_52ca ; $52bd
	cp a, $de ; $52bf
	jr z, Label_05_52ba ; $52c1
	cp a, $df ; $52c3
	jr z, Label_05_52ba ; $52c5
	inc b ; $52c7
	jr Label_05_52ba ; $52c8
Label_05_52ca:
	ld a, b ; $52ca
	pop hl ; $52cb
	pop bc ; $52cc
	ret ; $52cd
	INCBIN "data/bank_005/d_52ce.bin" ; $52ce, 55 bytes
Func_05_5305:
	push hl ; $5305
	push bc ; $5306
	push de ; $5307
	ld a, [$d867] ; $5308
	ld b, $00 ; $530b
	ld c, a ; $530d
	sla c ; $530e
	inc a ; $5310
	ld [$d867], a ; $5311
	ld hl, $d8d0 ; $5314
	add hl, bc ; $5317
	ld e, [hl] ; $5318
	inc hl ; $5319
	ld d, [hl] ; $531a
	ld h, d ; $531b
	ld l, e ; $531c
	ld bc, $d8f0 ; $531d
	ld de, $2710 ; $5320
	add hl, bc ; $5323
	ld a, $05 ; $5324
	bit 7, h ; $5326
	jr z, Label_05_536f ; $5328
	add hl, de ; $532a
Label_05_532b:
	add hl, bc ; $532b
	bit 7, h ; $532c
	jr z, Label_05_532b ; $532e
	add hl, de ; $5330
	ld bc, $fc18 ; $5331
	ld de, $03e8 ; $5334
	add hl, bc ; $5337
	ld a, $04 ; $5338
	bit 7, h ; $533a
	jr z, Label_05_536f ; $533c
	add hl, de ; $533e
Label_05_533f:
	add hl, bc ; $533f
	bit 7, h ; $5340
	jr z, Label_05_533f ; $5342
	add hl, de ; $5344
	ld bc, $ff9c ; $5345
	ld de, $0064 ; $5348
	add hl, bc ; $534b
	ld a, $03 ; $534c
	bit 7, h ; $534e
	jr z, Label_05_536f ; $5350
	add hl, de ; $5352
Label_05_5353:
	add hl, bc ; $5353
	bit 7, h ; $5354
	jr z, Label_05_5353 ; $5356
	add hl, de ; $5358
	ld bc, $fff6 ; $5359
	ld de, $000a ; $535c
	add hl, bc ; $535f
	ld a, $02 ; $5360
	bit 7, h ; $5362
	jr z, Label_05_536f ; $5364
	add hl, de ; $5366
Label_05_5367:
	add hl, bc ; $5367
	bit 7, h ; $5368
	jr z, Label_05_5367 ; $536a
	add hl, de ; $536c
	ld a, $01 ; $536d
Label_05_536f:
	ld b, $00 ; $536f
Label_05_5371:
	push af ; $5371
	push hl ; $5372
	dec a ; $5373
	add a, a ; $5374
	ld hl, $53a2 ; $5375
	add a, l ; $5378
	ld l, a ; $5379
	jr nc, Label_05_537d ; $537a
	inc h ; $537c
Label_05_537d:
	ld a, [hl+] ; $537d
	ld d, [hl] ; $537e
	ld e, a ; $537f
	pop hl ; $5380
	xor a, a ; $5381
Label_05_5382:
	ld a, l ; $5382
	sub a, e ; $5383
	ld l, a ; $5384
	ld a, h ; $5385
	sbc a, d ; $5386
	ld h, a ; $5387
	bit 7, h ; $5388
	jr nz, Label_05_538f ; $538a
	inc a ; $538c
	jr Label_05_5382 ; $538d
Label_05_538f:
	add hl, de ; $538f
	ld c, $30 ; $5390
	add a, c ; $5392
	call Func_05_7366 ; $5393
	ld a, c ; $5396
	add a, b ; $5397
	ld b, a ; $5398
	pop af ; $5399
	dec a ; $539a
	jr nz, Label_05_5371 ; $539b
	ld a, b ; $539d
	pop de ; $539e
	pop bc ; $539f
	pop hl ; $53a0
	ret ; $53a1
	INCBIN "data/bank_005/d_53a2.bin" ; $53a2, 40 bytes
	push af ; $53ca
	push bc ; $53cb
	ld a, [$c361] ; $53cc
	push de ; $53cf
	ld hl, $001b ; $53d0
	add a, l ; $53d3
	ld l, a ; $53d4
	jr nc, Label_05_53d8 ; $53d5
	inc h ; $53d7
Label_05_53d8:
	ld de, $c6c0 ; $53d8
	call Func_05_409a ; $53db
	pop de ; $53de
	ld hl, $c6c0 ; $53df
	call Func_05_54cf ; $53e2
	pop bc ; $53e5
	pop af ; $53e6
	ret ; $53e7
Func_05_53e8:
	push bc ; $53e8
	push de ; $53e9
	push hl ; $53ea
	ld a, [$c361] ; $53eb
	ld hl, $001b ; $53ee
	add a, l ; $53f1
	ld l, a ; $53f2
	jr nc, Label_05_53f6 ; $53f3
	inc h ; $53f5
Label_05_53f6:
	ld de, $c6c0 ; $53f6
	farcall FarPtr_05_4e ; $53f9
	ld hl, $c6c0 ; $53fc
	ld b, $00 ; $53ff
Label_05_5401:
	ld a, [hl+] ; $5401
	cp a, $00 ; $5402
	jr z, Label_05_540e ; $5404
	call Func_05_7366 ; $5406
	ld a, c ; $5409
	add a, b ; $540a
	ld b, a ; $540b
	jr Label_05_5401 ; $540c
Label_05_540e:
	ld a, b ; $540e
	pop hl ; $540f
	pop de ; $5410
	pop bc ; $5411
	ret ; $5412
Func_05_5413:
	push af ; $5413
	push hl ; $5414
	ld h, d ; $5415
	ld l, e ; $5416
	srl h ; $5417
	rr l ; $5419
	srl h ; $541b
	rr l ; $541d
	srl l ; $541f
	sra l ; $5421
	sra l ; $5423
	ld a, [$d82b] ; $5425
	cp a, l ; $5428
	jr z, Label_05_5433 ; $5429
	ld a, e ; $542b
	sub a, $20 ; $542c
	ld e, a ; $542e
	jr nc, Label_05_5433 ; $542f
	ld e, a ; $5431
	dec d ; $5432
Label_05_5433:
	ld a, d ; $5433
	and a, $03 ; $5434
	ld h, a ; $5436
	or a, $d0 ; $5437
	ld d, a ; $5439
	pop hl ; $543a
	pop af ; $543b
	ret ; $543c
	INCBIN "data/bank_005/d_543d.bin" ; $543d, 47 bytes
Func_05_546c:
	push hl ; $546c
	ld hl, $5488 ; $546d
	push hl ; $5470
	push af ; $5471
	push bc ; $5472
	push de ; $5473
	sla a ; $5474
	ld hl, $548f ; $5476
	ld c, a ; $5479
	ld b, $00 ; $547a
	add hl, bc ; $547c
	ld d, h ; $547d
	ld e, l ; $547e
	ld a, [de] ; $547f
	ld l, a ; $5480
	inc de ; $5481
	ld a, [de] ; $5482
	ld h, a ; $5483
	pop de ; $5484
	pop bc ; $5485
	pop af ; $5486
	jp hl ; $5487
	pop hl ; $5488
	ret ; $5489
	INCBIN "data/bank_005/d_548a.bin" ; $548a, 69 bytes
Func_05_54cf:
	push af ; $54cf
	ld a, [$d86a] ; $54d0
	cp a, $c6 ; $54d3
	jr nz, Label_05_54dd ; $54d5
	ld a, [$d869] ; $54d7
	or a, a ; $54da
	jr z, Label_05_54f3 ; $54db
Label_05_54dd:
	dec de ; $54dd
	ld a, [de] ; $54de
	inc de ; $54df
	cp a, $05 ; $54e0
	jr z, Label_05_54f3 ; $54e2
	ld a, e ; $54e4
	and a, $1f ; $54e5
	jr nz, Label_05_54f3 ; $54e7
	push hl ; $54e9
	ld h, d ; $54ea
	ld l, e ; $54eb
	ld de, $ffe0 ; $54ec
	add hl, de ; $54ef
	ld d, h ; $54f0
	ld e, l ; $54f1
	pop hl ; $54f2
Label_05_54f3:
	ld a, [hl] ; $54f3
	cp a, $00 ; $54f4
	jr z, Label_05_5553 ; $54f6
	rst Rst30 ; $54f8
	add a, b ; $54f9
	inc b ; $54fa
	jr nz, Label_05_5505 ; $54fb
	call Func_05_7681 ; $54fd
	call Func_05_7607 ; $5500
	jr Label_05_5511 ; $5503
Label_05_5505:
	call Func_05_5f0d ; $5505
	call Func_05_7681 ; $5508
	call Func_05_5f0d ; $550b
	call Func_05_7607 ; $550e
Label_05_5511:
	inc hl ; $5511
	ld a, [hl] ; $5512
	cp a, $de ; $5513
	jr z, Label_05_551b ; $5515
	cp a, $df ; $5517
	jr nz, Label_05_553e ; $5519
Label_05_551b:
	push hl ; $551b
	push bc ; $551c
	ld h, d ; $551d
	ld l, e ; $551e
	ld bc, $ffe0 ; $551f
	add hl, bc ; $5522
	push af ; $5523
	ld a, [$c3b5] ; $5524
	ld c, a ; $5527
	ld a, h ; $5528
	cp a, c ; $5529
	jr nc, Label_05_5530 ; $552a
	ld bc, $0400 ; $552c
	add hl, bc ; $552f
Label_05_5530:
	pop af ; $5530
	ld b, a ; $5531
	ld a, [hl] ; $5532
	cp a, $03 ; $5533
	ld a, b ; $5535
	jr nz, Label_05_553a ; $5536
	sub a, $d0 ; $5538
Label_05_553a:
	ld [hl], a ; $553a
	pop bc ; $553b
	pop hl ; $553c
	inc hl ; $553d
Label_05_553e:
	call Func_05_579b ; $553e
	inc de ; $5541
	ld a, e ; $5542
	and a, $1f ; $5543
	jr nz, Label_05_54f3 ; $5545
	push hl ; $5547
	ld h, d ; $5548
	ld l, e ; $5549
	ld de, $ffe0 ; $554a
	add hl, de ; $554d
	ld d, h ; $554e
	ld e, l ; $554f
	pop hl ; $5550
	jr Label_05_54f3 ; $5551
Label_05_5553:
	pop af ; $5553
	ret ; $5554
	INCBIN "data/bank_005/d_5555.bin" ; $5555, 128 bytes
Func_05_55d5:
	ld d, h ; $55d5
	ld e, l ; $55d6
	ld a, b ; $55d7
	call Func_05_6eea ; $55d8
	ld a, $06 ; $55db
	add a, l ; $55dd
	ld l, a ; $55de
	jr nc, Label_05_55e2 ; $55df
	inc h ; $55e1
Label_05_55e2:
	ld a, e ; $55e2
	ld [hl+], a ; $55e3
	ld [hl], d ; $55e4
	ret ; $55e5
Func_05_55e6:
	push af ; $55e6
	push bc ; $55e7
	xor a, a ; $55e8
	call Func_05_5d2b ; $55e9
	push hl ; $55ec
	ld a, [$d824] ; $55ed
	ld b, a ; $55f0
	call Func_05_55d5 ; $55f1
	pop hl ; $55f4
	pop bc ; $55f5
	pop af ; $55f6
	ret ; $55f7
Func_05_55f8:
	push af ; $55f8
	push bc ; $55f9
	push de ; $55fa
	push hl ; $55fb
	ld a, b ; $55fc
	call Func_05_6eea ; $55fd
	push hl ; $5600
	ld a, $06 ; $5601
	add a, l ; $5603
	ld l, a ; $5604
	jr nc, Label_05_5608 ; $5605
	inc h ; $5607
Label_05_5608:
	ld a, [hl+] ; $5608
	ld b, [hl] ; $5609
	ld c, a ; $560a
	pop de ; $560b
	ld a, b ; $560c
	and a, $3f ; $560d
	ld b, a ; $560f
	ld a, [$d850] ; $5610
	or a, a ; $5613
	jr z, Label_05_561a ; $5614
	xor a, a ; $5616
	ld [$d850], a ; $5617
Label_05_561a:
	ld a, b ; $561a
	cp a, $03 ; $561b
	ld a, $01 ; $561d
	ld [$d85f], a ; $561f
	jr z, Label_05_5643 ; $5622
	xor a, a ; $5624
	ld [$d85f], a ; $5625
	ld h, d ; $5628
	ld l, e ; $5629
	push hl ; $562a
	push hl ; $562b
	ld h, b ; $562c
	ld l, c ; $562d
	call Func_05_5c18 ; $562e
	pop hl ; $5631
	ld a, [hl+] ; $5632
	inc a ; $5633
	and a, $1f ; $5634
	ld d, a ; $5636
	ld a, [hl+] ; $5637
	inc a ; $5638
	and a, $1f ; $5639
	ld e, a ; $563b
	pop hl ; $563c
	ld hl, $c600 ; $563d
	call Func_05_4e23 ; $5640
Label_05_5643:
	pop hl ; $5643
	pop de ; $5644
	pop bc ; $5645
	pop af ; $5646
	ret ; $5647
Func_05_5648:
	push af ; $5648
	push bc ; $5649
	ld a, [$d824] ; $564a
	ld b, a ; $564d
	call Func_05_55f8 ; $564e
	pop bc ; $5651
	pop af ; $5652
	ret ; $5653
Func_05_5654:
	push af ; $5654
	push bc ; $5655
	push de ; $5656
	push hl ; $5657
	ld hl, $c600 ; $5658
	ld a, [$d84f] ; $565b
	or a, a ; $565e
	jr z, Label_05_5667 ; $565f
	ld hl, $d84e ; $5661
	ld a, [hl+] ; $5664
	ld h, [hl] ; $5665
	ld l, a ; $5666
Label_05_5667:
	xor a, a ; $5667
	ld b, a ; $5668
	ld d, a ; $5669
	ld e, a ; $566a
Label_05_566b:
	ld a, [hl+] ; $566b
	cp a, $00 ; $566c
	jp z, Label_05_56e0 ; $566e
	cp a, $02 ; $5671
	jp z, Label_05_56e0 ; $5673
	cp a, $01 ; $5676
	jr z, Label_05_567c ; $5678
	jr Label_05_5687 ; $567a
Label_05_567c:
	inc e ; $567c
	ld a, d ; $567d
	cp a, b ; $567e
	ld a, b ; $567f
	ld b, $00 ; $5680
	jr nc, Label_05_566b ; $5682
	ld d, a ; $5684
	jr Label_05_566b ; $5685
Label_05_5687:
	cp a, $08 ; $5687
	jr nz, Label_05_5692 ; $5689
	call Func_05_5298 ; $568b
	add a, b ; $568e
	ld b, a ; $568f
	jr Label_05_566b ; $5690
Label_05_5692:
	cp a, $09 ; $5692
	jr nz, Label_05_569d ; $5694
	call Func_05_5305 ; $5696
	add a, b ; $5699
	ld b, a ; $569a
	jr Label_05_566b ; $569b
Label_05_569d:
	cp a, $07 ; $569d
	jr nz, Label_05_56a8 ; $569f
	call Func_05_5267 ; $56a1
	add a, b ; $56a4
	ld b, a ; $56a5
	jr Label_05_566b ; $56a6
Label_05_56a8:
	cp a, $04 ; $56a8
	jr nz, Label_05_56b3 ; $56aa
	call Func_05_51fe ; $56ac
	add a, b ; $56af
	ld b, a ; $56b0
	jr Label_05_566b ; $56b1
Label_05_56b3:
	cp a, $0b ; $56b3
	jr nz, Label_05_56be ; $56b5
	call Func_05_527f ; $56b7
	add a, b ; $56ba
	ld b, a ; $56bb
	jr Label_05_566b ; $56bc
Label_05_56be:
	cp a, $0e ; $56be
	jr nz, Label_05_56cd ; $56c0
	ld a, [hl+] ; $56c2
	ld [$c361], a ; $56c3
	call Func_05_53e8 ; $56c6
	add a, b ; $56c9
	ld b, a ; $56ca
	jr Label_05_566b ; $56cb
Label_05_56cd:
	cp a, $20 ; $56cd
	jp c, Label_05_566b ; $56cf
	cp a, $7b ; $56d2
	jp nc, Label_05_566b ; $56d4
	call Func_05_7366 ; $56d7
	ld a, c ; $56da
	add a, b ; $56db
	ld b, a ; $56dc
	jp Label_05_566b ; $56dd
Label_05_56e0:
	inc e ; $56e0
	ld a, d ; $56e1
	cp a, b ; $56e2
	jr nc, Label_05_56e6 ; $56e3
	ld d, b ; $56e5
Label_05_56e6:
	ld a, d ; $56e6
	and a, $07 ; $56e7
	jr z, Label_05_56ed ; $56e9
	ld a, $01 ; $56eb
Label_05_56ed:
	srl d ; $56ed
	srl d ; $56ef
	srl d ; $56f1
	add a, d ; $56f3
	ld d, a ; $56f4
	ld a, d ; $56f5
	ld [$d854], a ; $56f6
	ld a, e ; $56f9
	ld [$d86f], a ; $56fa
	inc d ; $56fd
	inc d ; $56fe
	sla e ; $56ff
	inc e ; $5701
	push de ; $5702
	ld a, [$d824] ; $5703
	cp a, $ff ; $5706
	jr nz, Label_05_570b ; $5708
	xor a, a ; $570a
Label_05_570b:
	sla a ; $570b
	sla a ; $570d
	ld b, $00 ; $570f
	ld c, a ; $5711
	ld hl, $d800 ; $5712
	add hl, bc ; $5715
	ld c, [hl] ; $5716
	inc hl ; $5717
	ld b, [hl] ; $5718
	ld h, b ; $5719
	ld l, c ; $571a
	pop bc ; $571b
	ld a, [$d827] ; $571c
	sub a, b ; $571f
	srl a ; $5720
	ld d, a ; $5722
	ld a, [$d825] ; $5723
	add a, d ; $5726
	ld d, a ; $5727
	ld a, [$d828] ; $5728
	sub a, c ; $572b
	srl a ; $572c
	ld e, a ; $572e
	ld a, [$d826] ; $572f
	add a, e ; $5732
	ld e, a ; $5733
	ld a, [$d824] ; $5734
	call Func_05_6eea ; $5737
	call Func_05_4538 ; $573a
	ld [$d867], a ; $573d
	pop hl ; $5740
	pop de ; $5741
	pop bc ; $5742
	pop af ; $5743
	ret ; $5744
Func_05_5745:
	push af ; $5745
	push de ; $5746
	push hl ; $5747
	ld hl, $c600 ; $5748
	xor a, a ; $574b
	ld b, a ; $574c
	ld d, a ; $574d
	ld e, a ; $574e
Label_05_574f:
	ld a, [hl+] ; $574f
	cp a, $00 ; $5750
	jr z, Label_05_5789 ; $5752
	cp a, $01 ; $5754
	jr nz, Label_05_5763 ; $5756
	inc e ; $5758
	ld a, d ; $5759
	cp a, b ; $575a
	ld a, b ; $575b
	ld b, $00 ; $575c
	jr nc, Label_05_574f ; $575e
	ld d, a ; $5760
	jr Label_05_574f ; $5761
Label_05_5763:
	cp a, $08 ; $5763
	jr nz, Label_05_576e ; $5765
	call Func_05_5298 ; $5767
	add a, b ; $576a
	ld b, a ; $576b
	jr Label_05_574f ; $576c
Label_05_576e:
	cp a, $09 ; $576e
	jr nz, Label_05_5779 ; $5770
	call Func_05_5305 ; $5772
	add a, b ; $5775
	ld b, a ; $5776
	jr Label_05_574f ; $5777
Label_05_5779:
	cp a, $20 ; $5779
	jr c, Label_05_574f ; $577b
	cp a, $7b ; $577d
	jr nc, Label_05_574f ; $577f
	call Func_05_7366 ; $5781
	ld a, c ; $5784
	add a, b ; $5785
	ld b, a ; $5786
	jr Label_05_574f ; $5787
Label_05_5789:
	inc e ; $5789
	ld a, d ; $578a
	cp a, b ; $578b
	jr nc, Label_05_578f ; $578c
	ld d, b ; $578e
Label_05_578f:
	inc d ; $578f
	inc d ; $5790
	inc d ; $5791
	sla e ; $5792
	inc e ; $5794
	push de ; $5795
	pop bc ; $5796
	pop hl ; $5797
	pop de ; $5798
	pop af ; $5799
	ret ; $579a
Func_05_579b:
	push af ; $579b
	push bc ; $579c
	push de ; $579d
	push hl ; $579e
	ld c, a ; $579f
	ldh a, [$ff96] ; $57a0
	push af ; $57a2
	ld a, $05 ; $57a3
	ldh [$ff96], a ; $57a5
	ldh [rWBK], a ; $57a7
	ld a, [$d829] ; $57a9
	or a, a ; $57ac
	ld b, a ; $57ad
	jr z, Label_05_57dd ; $57ae
	ld a, c ; $57b0
	cp a, $20 ; $57b1
	jr nz, Label_05_57b9 ; $57b3
	ld b, $04 ; $57b5
	jr Label_05_57d1 ; $57b7
Label_05_57b9:
	ld a, [$d862] ; $57b9
	cp a, $08 ; $57bc
	jr z, Label_05_57d1 ; $57be
	push bc ; $57c0
	ld e, a ; $57c1
	sla e ; $57c2
	sla e ; $57c4
	ld d, $9a ; $57c6
	ld a, c ; $57c8
	and a, $03 ; $57c9
	add a, e ; $57cb
	add a, d ; $57cc
	call Func_00_3024 ; $57cd
	pop bc ; $57d0
Label_05_57d1:
	call Func_00_2631 ; $57d1
	ldh a, [hPlayerInputFlags] ; $57d4
	and a, $f3 ; $57d6
	jr nz, Label_05_57dd ; $57d8
	dec b ; $57da
	jr nz, Label_05_57d1 ; $57db
Label_05_57dd:
	pop af ; $57dd
	ldh [$ff96], a ; $57de
	ldh [rWBK], a ; $57e0
	pop hl ; $57e2
	pop de ; $57e3
	pop bc ; $57e4
	pop af ; $57e5
	ret ; $57e6
Func_05_57e7:
	push af ; $57e7
	ldh a, [$ff96] ; $57e8
	push af ; $57ea
	ld a, $05 ; $57eb
	ldh [$ff96], a ; $57ed
	ldh [rWBK], a ; $57ef
	ld a, [wMessageSpeed] ; $57f1
	bit 7, a ; $57f4
	jr z, Label_05_57fe ; $57f6
	xor a, a ; $57f8
	ld [$d829], a ; $57f9
	jr Label_05_5818 ; $57fc
Label_05_57fe:
	or a, a ; $57fe
	jr nz, Label_05_5808 ; $57ff
	ld a, $00 ; $5801
	ld [$d829], a ; $5803
	jr Label_05_5818 ; $5806
Label_05_5808:
	cp a, $01 ; $5808
	jr nz, Label_05_5813 ; $580a
	ld a, $02 ; $580c
	ld [$d829], a ; $580e
	jr Label_05_5818 ; $5811
Label_05_5813:
	ld a, $04 ; $5813
	ld [$d829], a ; $5815
Label_05_5818:
	pop af ; $5818
	ldh [$ff96], a ; $5819
	ldh [rWBK], a ; $581b
	pop af ; $581d
	ret ; $581e
Func_05_581f:
	push af ; $581f
	push bc ; $5820
	push de ; $5821
	ld b, a ; $5822
	ldh a, [$ff96] ; $5823
	push af ; $5825
	ld a, $05 ; $5826
	ldh [$ff96], a ; $5828
	ldh [rWBK], a ; $582a
	xor a, a ; $582c
	ld [$d847], a ; $582d
	ld [$d866], a ; $5830
	ld [$d848], a ; $5833
	ld [$d867], a ; $5836
	ld [$d849], a ; $5839
	ld [$d868], a ; $583c
	call Func_05_5d2b ; $583f
	ld a, b ; $5842
	cp a, $ff ; $5843
	jr nz, Label_05_5849 ; $5845
	ld a, $00 ; $5847
Label_05_5849:
	ld [$d851], a ; $5849
	call Func_05_57e7 ; $584c
	bit 7, a ; $584f
	ld b, $08 ; $5851
	jr nz, Label_05_5859 ; $5853
	call Func_05_608a ; $5855
	ld b, a ; $5858
Label_05_5859:
	ld a, b ; $5859
	ld [$d862], a ; $585a
	ld a, [$d824] ; $585d
	cp a, $ff ; $5860
	jr nz, Label_05_5888 ; $5862
	xor a, a ; $5864
	ld [$c3bb], a ; $5865
	ld [$c3bc], a ; $5868
	ldh a, [$ff96] ; $586b
	push af ; $586d
	ld a, $07 ; $586e
	ldh [$ff96], a ; $5870
	ldh [rWBK], a ; $5872
	call Func_05_73cb ; $5874
	call Func_05_742c ; $5877
	pop af ; $587a
	ldh [$ff96], a ; $587b
	ldh [rWBK], a ; $587d
	ld a, [$d851] ; $587f
	call Func_05_5aaf ; $5882
	call Func_05_436f ; $5885
Label_05_5888:
	xor a, a ; $5888
	ld [$c3bb], a ; $5889
	ld [$c3bc], a ; $588c
	ldh a, [$ff96] ; $588f
	push af ; $5891
	ld a, $07 ; $5892
	ldh [$ff96], a ; $5894
	ldh [rWBK], a ; $5896
	call Func_05_73cb ; $5898
	call Func_05_742c ; $589b
	pop af ; $589e
	ldh [$ff96], a ; $589f
	ldh [rWBK], a ; $58a1
	call Func_05_55e6 ; $58a3
	ld a, [$d824] ; $58a6
	rst Rst20 ; $58a9
	ld h, b ; $58aa
	inc b ; $58ab
	call Func_05_6f70 ; $58ac
	rst Rst28 ; $58af
	ld h, b ; $58b0
	inc b ; $58b1
	call Func_05_7214 ; $58b2
	call Func_05_5648 ; $58b5
	ld a, [$d850] ; $58b8
	or a, a ; $58bb
	jr z, Label_05_58c9 ; $58bc
	ld a, [$d824] ; $58be
	call Func_05_43a8 ; $58c1
	call Func_05_5654 ; $58c4
	jr Label_05_5888 ; $58c7
Label_05_58c9:
	ld a, [$d824] ; $58c9
	call Func_05_72bd ; $58cc
	ld a, $ff ; $58cf
	ld [$d824], a ; $58d1
	xor a, a ; $58d4
	ld [$d847], a ; $58d5
	ld [$d866], a ; $58d8
	ld [$d848], a ; $58db
	ld [$d867], a ; $58de
	ld [$d849], a ; $58e1
	ld [$d868], a ; $58e4
	pop af ; $58e7
	ldh [$ff96], a ; $58e8
	ldh [rWBK], a ; $58ea
	pop de ; $58ec
	pop bc ; $58ed
	pop af ; $58ee
	ret ; $58ef
Func_05_58f0:
	push af ; $58f0
	push bc ; $58f1
	push de ; $58f2
	ld b, a ; $58f3
	ldh a, [$ff96] ; $58f4
	push af ; $58f6
	ld a, $05 ; $58f7
	ldh [$ff96], a ; $58f9
	ldh [rWBK], a ; $58fb
	xor a, a ; $58fd
	ld [$d847], a ; $58fe
	ld [$d866], a ; $5901
	ld [$d848], a ; $5904
	ld [$d867], a ; $5907
	ld [$d849], a ; $590a
	ld [$d868], a ; $590d
	call Func_05_5d2b ; $5910
	ld a, b ; $5913
	cp a, $ff ; $5914
	jr nz, Label_05_591a ; $5916
	ld a, $00 ; $5918
Label_05_591a:
	ld [$d851], a ; $591a
	call Func_05_57e7 ; $591d
	bit 7, a ; $5920
	ld b, $08 ; $5922
	jr nz, Label_05_592a ; $5924
	call Func_05_608a ; $5926
	ld b, a ; $5929
Label_05_592a:
	ld a, b ; $592a
	ld [$d862], a ; $592b
	ld a, [$d824] ; $592e
	cp a, $ff ; $5931
	jr nz, Label_05_5956 ; $5933
	xor a, a ; $5935
	ld [$c3bb], a ; $5936
	ld [$c3bc], a ; $5939
	ldh a, [$ff96] ; $593c
	push af ; $593e
	ld a, $07 ; $593f
	ldh [$ff96], a ; $5941
	ldh [rWBK], a ; $5943
	call Func_05_73cb ; $5945
	call Func_05_742c ; $5948
	pop af ; $594b
	ldh [$ff96], a ; $594c
	ldh [rWBK], a ; $594e
	ld a, [$d851] ; $5950
	call Func_05_5aaf ; $5953
Label_05_5956:
	xor a, a ; $5956
	ld [$c3bb], a ; $5957
	ld [$c3bc], a ; $595a
	ldh a, [$ff96] ; $595d
	push af ; $595f
	ld a, $07 ; $5960
	ldh [$ff96], a ; $5962
	ldh [rWBK], a ; $5964
	call Func_05_73cb ; $5966
	call Func_05_742c ; $5969
	pop af ; $596c
	ldh [$ff96], a ; $596d
	ldh [rWBK], a ; $596f
	call Func_05_55e6 ; $5971
	call Func_05_436f ; $5974
	ld a, [$d824] ; $5977
	rst Rst20 ; $597a
	ld h, b ; $597b
	inc b ; $597c
	call Func_05_6f70 ; $597d
	rst Rst28 ; $5980
	ld h, b ; $5981
	inc b ; $5982
	call Func_05_7214 ; $5983
	call Func_05_5648 ; $5986
	ld a, [$d850] ; $5989
	or a, a ; $598c
	jr z, Label_05_5994 ; $598d
	call Func_05_5654 ; $598f
	jr Label_05_5956 ; $5992
Label_05_5994:
	xor a, a ; $5994
	ld [$d847], a ; $5995
	ld [$d866], a ; $5998
	ld [$d848], a ; $599b
	ld [$d867], a ; $599e
	ld [$d849], a ; $59a1
	ld [$d868], a ; $59a4
	pop af ; $59a7
	ldh [$ff96], a ; $59a8
	ldh [rWBK], a ; $59aa
	pop de ; $59ac
	pop bc ; $59ad
	pop af ; $59ae
	ret ; $59af
	INCBIN "data/bank_005/d_59b0.bin" ; $59b0, 227 bytes
Func_05_5a93:
	push af ; $5a93
	ldh a, [$ff96] ; $5a94
	push af ; $5a96
	ld a, $05 ; $5a97
	ldh [$ff96], a ; $5a99
	ldh [rWBK], a ; $5a9b
	ld a, [$d824] ; $5a9d
	call Func_05_72bd ; $5aa0
	ld a, $ff ; $5aa3
	ld [$d824], a ; $5aa5
	pop af ; $5aa8
	ldh [$ff96], a ; $5aa9
	ldh [rWBK], a ; $5aab
	pop af ; $5aad
	ret ; $5aae
Func_05_5aaf:
	push af ; $5aaf
	push bc ; $5ab0
	push de ; $5ab1
	push hl ; $5ab2
	push hl ; $5ab3
	ld b, a ; $5ab4
	ldh a, [$ff96] ; $5ab5
	push af ; $5ab7
	ld a, b ; $5ab8
	and a, $3f ; $5ab9
	ld e, a ; $5abb
	rl b ; $5abc
	jr nc, Label_05_5ac2 ; $5abe
	jr Label_05_5aee ; $5ac0
Label_05_5ac2:
	call Func_05_5ff2 ; $5ac2
	ld a, [$c323] ; $5ac5
	ld b, a ; $5ac8
	ld a, l ; $5ac9
	ldh [$ffea], a ; $5aca
	ld a, h ; $5acc
	ldh [$ffeb], a ; $5acd
	ld a, $04 ; $5acf
	ldh [$ff96], a ; $5ad1
	ldh [rWBK], a ; $5ad3
	ld hl, $ffea ; $5ad5
	ld a, [hl+] ; $5ad8
	ld h, [hl] ; $5ad9
	add a, $0e ; $5ada
	ld l, a ; $5adc
	inc hl ; $5add
	ld a, [hl] ; $5ade
	sub a, b ; $5adf
	cp a, $0a ; $5ae0
	jr c, Label_05_5aea ; $5ae2
	ld e, $00 ; $5ae4
	ld b, $00 ; $5ae6
	jr Label_05_5aee ; $5ae8
Label_05_5aea:
	ld e, $0a ; $5aea
	ld b, $01 ; $5aec
Label_05_5aee:
	ld a, $05 ; $5aee
	ldh [$ff96], a ; $5af0
	ldh [rWBK], a ; $5af2
	ld a, b ; $5af4
	ld [$d85c], a ; $5af5
	pop af ; $5af8
	ldh [$ff96], a ; $5af9
	ldh [rWBK], a ; $5afb
	ld b, $14 ; $5afd
	ld c, $07 ; $5aff
	ld d, $00 ; $5b01
	call Func_05_4688 ; $5b03
	pop hl ; $5b06
	call Func_05_5c18 ; $5b07
	call Func_05_5654 ; $5b0a
	xor a, a ; $5b0d
	ld [$d866], a ; $5b0e
	ld [$d868], a ; $5b11
	ld a, [$d824] ; $5b14
	call Func_05_6eea ; $5b17
	ld a, $05 ; $5b1a
	ldh [$ff96], a ; $5b1c
	ldh [rWBK], a ; $5b1e
	ld a, [$d825] ; $5b20
	add a, $08 ; $5b23
	and a, $1f ; $5b25
	ld d, a ; $5b27
	ld a, [$d826] ; $5b28
	add a, $02 ; $5b2b
	and a, $1f ; $5b2d
	ld e, a ; $5b2f
	ld b, $03 ; $5b30
	ld c, $03 ; $5b32
	ld a, $08 ; $5b34
	inc hl ; $5b36
	inc hl ; $5b37
	ld a, [hl] ; $5b38
	rr a ; $5b39
	jr c, Label_05_5b3e ; $5b3b
	inc b ; $5b3d
Label_05_5b3e:
	dec hl ; $5b3e
	dec hl ; $5b3f
	call Func_05_436f ; $5b40
	push af ; $5b43
	ld a, [$d820] ; $5b44
	call Func_05_6efa ; $5b47
	pop af ; $5b4a
Label_05_5b4b:
	push af ; $5b4b
	ld a, [$d820] ; $5b4c
	call Func_05_6eea ; $5b4f
	call Func_05_4538 ; $5b52
	ld a, [$d820] ; $5b55
	call Func_05_6f70 ; $5b58
	ld hl, $dc78 ; $5b5b
	ld a, [$d820] ; $5b5e
	call Func_05_7214 ; $5b61
	ld a, d ; $5b64
	cp a, [hl] ; $5b65
	jr z, Label_05_5b6c ; $5b66
	dec a ; $5b68
	and a, $1f ; $5b69
	ld d, a ; $5b6b
Label_05_5b6c:
	jr Label_05_5b75 ; $5b6c
	INCBIN "data/bank_005/d_5b6e.bin" ; $5b6e, 7 bytes
Label_05_5b75:
	inc hl ; $5b75
	dec e ; $5b76
	ld a, e ; $5b77
	sub a, [hl] ; $5b78
	bit 7, a ; $5b79
	jr z, Label_05_5b7f ; $5b7b
	ld a, [hl] ; $5b7d
	ld e, a ; $5b7e
Label_05_5b7f:
	inc hl ; $5b7f
	inc b ; $5b80
	inc b ; $5b81
	ld a, [hl] ; $5b82
	cp a, b ; $5b83
	jr nc, Label_05_5b87 ; $5b84
	ld b, a ; $5b86
Label_05_5b87:
	inc hl ; $5b87
	inc c ; $5b88
	ld a, [hl] ; $5b89
	cp a, c ; $5b8a
	jr nc, Label_05_5b8e ; $5b8b
	ld c, a ; $5b8d
Label_05_5b8e:
	dec hl ; $5b8e
	dec hl ; $5b8f
	dec hl ; $5b90
	pop af ; $5b91
	dec a ; $5b92
	jr nz, Label_05_5b4b ; $5b93
	ld a, [$d824] ; $5b95
	call Func_05_6f11 ; $5b98
	pop hl ; $5b9b
	pop de ; $5b9c
	pop bc ; $5b9d
	pop af ; $5b9e
	ret ; $5b9f
	INCBIN "data/bank_005/d_5ba0.bin" ; $5ba0, 92 bytes
Func_05_5bfc:
	push bc ; $5bfc
	ldh a, [$ff96] ; $5bfd
	push af ; $5bff
	ld a, $05 ; $5c00
	ldh [$ff96], a ; $5c02
	ldh [rWBK], a ; $5c04
	call Func_05_5c18 ; $5c06
	call Func_05_5654 ; $5c09
	ld a, [$d854] ; $5c0c
	ld b, a ; $5c0f
	pop af ; $5c10
	ldh [$ff96], a ; $5c11
	ldh [rWBK], a ; $5c13
	ld a, b ; $5c15
	pop bc ; $5c16
	ret ; $5c17
Func_05_5c18:
	push af ; $5c18
	push bc ; $5c19
	push de ; $5c1a
	push hl ; $5c1b
	bit 7, h ; $5c1c
	jr nz, Label_05_5c9c ; $5c1e
	ld d, h ; $5c20
	ld e, l ; $5c21
	ld b, d ; $5c22
	ld a, d ; $5c23
	and a, $03 ; $5c24
	ld d, a ; $5c26
	ld a, b ; $5c27
	srl a ; $5c28
	srl a ; $5c2a
	and a, $0f ; $5c2c
	ld hl, $5c3b ; $5c2e
	add a, a ; $5c31
	add a, l ; $5c32
	ld l, a ; $5c33
	jr nc, Label_05_5c37 ; $5c34
	inc h ; $5c36
Label_05_5c37:
	ld a, [hl+] ; $5c37
	ld h, [hl] ; $5c38
	ld l, a ; $5c39
	jp hl ; $5c3a
	INCBIN "data/bank_005/d_5c3b.bin" ; $5c3b, 32 bytes
	farcall FarPtr_30_00 ; $5c5b
	jr Label_05_5ca3 ; $5c5e
	farcall FarPtr_31_00 ; $5c60
	jr Label_05_5ca3 ; $5c63
	INCBIN "data/bank_005/d_5c65.bin" ; $5c65, 5 bytes
	farcall FarPtr_33_00 ; $5c6a
	jr Label_05_5ca3 ; $5c6d
	farcall FarPtr_34_00 ; $5c6f
	jr Label_05_5ca3 ; $5c72
	farcall FarPtr_35_00 ; $5c74
	jr Label_05_5ca3 ; $5c77
	farcall FarPtr_36_00 ; $5c79
	jr Label_05_5ca3 ; $5c7c
	farcall FarPtr_37_00 ; $5c7e
	jr Label_05_5ca3 ; $5c81
	farcall FarPtr_6e_00 ; $5c83
	jr Label_05_5ca3 ; $5c86
	INCBIN "data/bank_005/d_5c88.bin" ; $5c88, 5 bytes
	farcall FarPtr_25_00 ; $5c8d
	jr Label_05_5ca3 ; $5c90
	farcall FarPtr_26_00 ; $5c92
	jr Label_05_5ca3 ; $5c95
	INCBIN "data/bank_005/d_5c97.bin" ; $5c97, 5 bytes
Label_05_5c9c:
	ld a, h ; $5c9c
	and a, $03 ; $5c9d
	ld h, a ; $5c9f
	call Func_05_6d2b ; $5ca0
Label_05_5ca3:
	pop hl ; $5ca3
	pop de ; $5ca4
	pop bc ; $5ca5
	pop af ; $5ca6
	ret ; $5ca7
Func_05_5ca8:
	push af ; $5ca8
	push bc ; $5ca9
	push de ; $5caa
	push hl ; $5cab
	ld d, h ; $5cac
	ld e, l ; $5cad
	ld b, d ; $5cae
	ld a, d ; $5caf
	and a, $03 ; $5cb0
	ld d, a ; $5cb2
	ld a, b ; $5cb3
	srl a ; $5cb4
	srl a ; $5cb6
	and a, $0f ; $5cb8
	ld hl, $5cc7 ; $5cba
	add a, a ; $5cbd
	add a, l ; $5cbe
	ld l, a ; $5cbf
	jr nc, Label_05_5cc3 ; $5cc0
	inc h ; $5cc2
Label_05_5cc3:
	ld a, [hl+] ; $5cc3
	ld h, [hl] ; $5cc4
	ld l, a ; $5cc5
	jp hl ; $5cc6
	INCBIN "data/bank_005/d_5cc7.bin" ; $5cc7, 32 bytes
	farcall FarPtr_30_02 ; $5ce7
	jr Label_05_5d26 ; $5cea
	INCBIN "data/bank_005/d_5cec.bin" ; $5cec, 58 bytes
Label_05_5d26:
	pop hl ; $5d26
	pop de ; $5d27
	pop bc ; $5d28
	pop af ; $5d29
	ret ; $5d2a
Func_05_5d2b:
	bit 7, h ; $5d2b
	ret nz ; $5d2d
	push af ; $5d2e
	push bc ; $5d2f
	push de ; $5d30
	add sp, -2 ; $5d31
	push hl ; $5d33
	ld b, $00 ; $5d34
	ld c, a ; $5d36
	ld a, h ; $5d37
	ld e, h ; $5d38
	and a, $03 ; $5d39
	ld h, a ; $5d3b
	add hl, bc ; $5d3c
	ld b, h ; $5d3d
	ld c, l ; $5d3e
	ld a, e ; $5d3f
	and a, $3c ; $5d40
	ld e, a ; $5d42
	ld a, h ; $5d43
	or a, e ; $5d44
	ld d, a ; $5d45
	ld e, l ; $5d46
	ld hl, sp + 2 ; $5d47
	ld [hl], e ; $5d49
	inc hl ; $5d4a
	ld [hl], d ; $5d4b
	pop hl ; $5d4c
	ld a, h ; $5d4d
	and a, $3c ; $5d4e
	sra a ; $5d50
	ld e, a ; $5d52
	ld d, $00 ; $5d53
	ld hl, $5d99 ; $5d55
	add hl, de ; $5d58
	ld e, [hl] ; $5d59
	inc hl ; $5d5a
	ld d, [hl] ; $5d5b
	ld a, b ; $5d5c
	xor a, $ff ; $5d5d
	ld b, a ; $5d5f
	ld a, c ; $5d60
	xor a, $ff ; $5d61
	ld c, a ; $5d63
	inc bc ; $5d64
	ld h, d ; $5d65
	ld l, e ; $5d66
	add hl, bc ; $5d67
	push hl ; $5d68
	ld hl, sp + 2 ; $5d69
	ld c, [hl] ; $5d6b
	inc hl ; $5d6c
	ld b, [hl] ; $5d6d
	pop hl ; $5d6e
	ld a, l ; $5d6f
	or a, h ; $5d70
	jr z, Label_05_5d77 ; $5d71
	bit 7, h ; $5d73
	jr z, Label_05_5d91 ; $5d75
Label_05_5d77:
	ld a, b ; $5d77
	and a, $3c ; $5d78
	add a, $04 ; $5d7a
	ld d, a ; $5d7c
	ld a, b ; $5d7d
	and a, $c0 ; $5d7e
	or a, d ; $5d80
	ld b, a ; $5d81
	ld a, h ; $5d82
	xor a, $ff ; $5d83
	ld h, a ; $5d85
	ld a, l ; $5d86
	xor a, $ff ; $5d87
	ld l, a ; $5d89
	inc hl ; $5d8a
	ld a, h ; $5d8b
	and a, $03 ; $5d8c
	or a, b ; $5d8e
	ld b, a ; $5d8f
	ld c, l ; $5d90
Label_05_5d91:
	ld h, b ; $5d91
	ld l, c ; $5d92
	add sp, 2 ; $5d93
	pop de ; $5d95
	pop bc ; $5d96
	pop af ; $5d97
	ret ; $5d98
	INCBIN "data/bank_005/d_5d99.bin" ; $5d99, 26 bytes
Func_05_5db3:
	push af ; $5db3
	push bc ; $5db4
	push de ; $5db5
	push hl ; $5db6
	rst Rst20 ; $5db7
	add a, b ; $5db8
	inc b ; $5db9
	push bc ; $5dba
	push de ; $5dbb
	push hl ; $5dbc
	ld hl, $cb76 ; $5dbd
	ld a, e ; $5dc0
	ld [hl+], a ; $5dc1
	ld [hl], d ; $5dc2
	pop hl ; $5dc3
	call Func_05_771b ; $5dc4
	ldh a, [$ff96] ; $5dc7
	push af ; $5dc9
	ld a, $05 ; $5dca
	ldh [$ff96], a ; $5dcc
	ldh [rWBK], a ; $5dce
	xor a, a ; $5dd0
	call Func_05_5d2b ; $5dd1
	xor a, a ; $5dd4
	ld [$d847], a ; $5dd5
	ld [$d866], a ; $5dd8
	ld [$d848], a ; $5ddb
	ld [$d867], a ; $5dde
	ld [$d849], a ; $5de1
	ld [$d868], a ; $5de4
	ld a, [$c3b5] ; $5de7
	add a, $03 ; $5dea
	cp a, d ; $5dec
	jr nc, Label_05_5df3 ; $5ded
	ld a, d ; $5def
	sub a, $04 ; $5df0
	ld d, a ; $5df2
Label_05_5df3:
	ld a, e ; $5df3
	ld [$d864], a ; $5df4
	ld a, d ; $5df7
	ld [$d865], a ; $5df8
	ld c, $20 ; $5dfb
	ld b, $ff ; $5dfd
	ld a, c ; $5dff
	cpl ; $5e00
	inc a ; $5e01
	ld c, a ; $5e02
	ld [$c362], a ; $5e03
	call Func_05_5c18 ; $5e06
	ld hl, $c600 ; $5e09
	xor a, a ; $5e0c
	ld [$cb78], a ; $5e0d
	ld a, [$d820] ; $5e10
	ld b, a ; $5e13
	ld a, [$d82f] ; $5e14
	cp a, b ; $5e17
	jr z, Label_05_5e1f ; $5e18
	ld a, $01 ; $5e1a
	ld [$cb78], a ; $5e1c
Label_05_5e1f:
	pop af ; $5e1f
	ldh [$ff96], a ; $5e20
	ldh [rWBK], a ; $5e22
Label_05_5e24:
	ld a, [hl] ; $5e24
	cp a, $20 ; $5e25
	jr nc, Label_05_5e83 ; $5e27
	push hl ; $5e29
	push af ; $5e2a
	add a, a ; $5e2b
	ld hl, $5e39 ; $5e2c
	add a, l ; $5e2f
	ld l, a ; $5e30
	jr nc, Label_05_5e34 ; $5e31
	inc h ; $5e33
Label_05_5e34:
	ld a, [hl+] ; $5e34
	ld h, [hl] ; $5e35
	ld l, a ; $5e36
	pop af ; $5e37
	jp hl ; $5e38
	INCBIN "data/bank_005/d_5e39.bin" ; $5e39, 57 bytes
	pop hl ; $5e72
	ld a, $0d ; $5e73
	call Func_05_546c ; $5e75
	inc hl ; $5e78
	jr Label_05_5e24 ; $5e79
	INCBIN "data/bank_005/d_5e7b.bin" ; $5e7b, 8 bytes
Label_05_5e83:
	push af ; $5e83
	ld a, [$c3b3] ; $5e84
	ldh [$ff96], a ; $5e87
	ldh [rWBK], a ; $5e89
	pop af ; $5e8b
	call Func_05_5f0d ; $5e8c
	call Func_05_7681 ; $5e8f
	call Func_05_5f0d ; $5e92
	inc hl ; $5e95
	ld a, [hl] ; $5e96
	cp a, $de ; $5e97
	jr z, Label_05_5e9f ; $5e99
	cp a, $df ; $5e9b
	jr nz, Label_05_5ebc ; $5e9d
Label_05_5e9f:
	push hl ; $5e9f
	ld h, d ; $5ea0
	ld l, e ; $5ea1
	add hl, bc ; $5ea2
	ld b, a ; $5ea3
	ld a, [$c3b5] ; $5ea4
	dec a ; $5ea7
	cp a, h ; $5ea8
	jr c, Label_05_5eaf ; $5ea9
	ld a, h ; $5eab
	add a, $04 ; $5eac
	ld h, a ; $5eae
Label_05_5eaf:
	ld a, [hl] ; $5eaf
	cp a, $03 ; $5eb0
	ld a, b ; $5eb2
	ld b, $ff ; $5eb3
	jr nz, Label_05_5eb9 ; $5eb5
	sub a, $d0 ; $5eb7
Label_05_5eb9:
	ld [hl], a ; $5eb9
	pop hl ; $5eba
	inc hl ; $5ebb
Label_05_5ebc:
	inc de ; $5ebc
	ld a, e ; $5ebd
	and a, $1f ; $5ebe
	jp nz, Label_05_5e24 ; $5ec0
	push hl ; $5ec3
	ld h, d ; $5ec4
	ld l, e ; $5ec5
	add hl, bc ; $5ec6
	ld d, h ; $5ec7
	ld e, l ; $5ec8
	pop hl ; $5ec9
	jp Label_05_5e24 ; $5eca
	pop hl ; $5ecd
	ldh a, [$ff96] ; $5ece
	push af ; $5ed0
	ld a, $05 ; $5ed1
	ldh [$ff96], a ; $5ed3
	ldh [rWBK], a ; $5ed5
	xor a, a ; $5ed7
	ld [$c362], a ; $5ed8
	ld [$d847], a ; $5edb
	ld [$d866], a ; $5ede
	ld [$d848], a ; $5ee1
	ld [$d867], a ; $5ee4
	ld [$d849], a ; $5ee7
	ld [$d868], a ; $5eea
	pop af ; $5eed
	ldh [$ff96], a ; $5eee
	ldh [rWBK], a ; $5ef0
	ld hl, $c3b7 ; $5ef2
	ld a, [hl+] ; $5ef5
	ld h, [hl] ; $5ef6
	ld l, a ; $5ef7
	sla l ; $5ef8
	rl h ; $5efa
	ld a, h ; $5efc
	ld [$c3bb], a ; $5efd
	pop de ; $5f00
	pop bc ; $5f01
	call Func_05_7774 ; $5f02
	rst Rst28 ; $5f05
	add a, b ; $5f06
	inc b ; $5f07
	pop hl ; $5f08
	pop de ; $5f09
	pop bc ; $5f0a
	pop af ; $5f0b
	ret ; $5f0c
Func_05_5f0d:
	push af ; $5f0d
	push bc ; $5f0e
	push de ; $5f0f
	push hl ; $5f10
	ld a, [$cb78] ; $5f11
	or a, a ; $5f14
	jr z, Label_05_5f4d ; $5f15
	ld hl, $cb76 ; $5f17
	ld a, [hl+] ; $5f1a
	ld d, [hl] ; $5f1b
	ld e, a ; $5f1c
	ld a, [$c3bc] ; $5f1d
	ld b, a ; $5f20
	ld hl, $c3b7 ; $5f21
	ld a, [hl+] ; $5f24
	ld h, [hl] ; $5f25
	ld l, a ; $5f26
	sla l ; $5f27
	rl h ; $5f29
	ld a, h ; $5f2b
	ld c, a ; $5f2c
	sub a, b ; $5f2d
	ld h, e ; $5f2e
	add a, e ; $5f2f
	ld e, a ; $5f30
	jr nc, Label_05_5f34 ; $5f31
	inc d ; $5f33
Label_05_5f34:
	ld a, e ; $5f34
	and a, $20 ; $5f35
	ld l, a ; $5f37
	ld a, h ; $5f38
	and a, $20 ; $5f39
	xor a, l ; $5f3b
	jr z, Label_05_5f44 ; $5f3c
	ld hl, $ffe0 ; $5f3e
	add hl, de ; $5f41
	ld d, h ; $5f42
	ld e, l ; $5f43
Label_05_5f44:
	ld a, [de] ; $5f44
	cp a, $06 ; $5f45
	jr z, Label_05_5f4d ; $5f47
	ld a, c ; $5f49
	add a, $80 ; $5f4a
	ld [de], a ; $5f4c
Label_05_5f4d:
	pop hl ; $5f4d
	pop de ; $5f4e
	pop bc ; $5f4f
	pop af ; $5f50
	ret ; $5f51
Func_05_5f52:
	push af ; $5f52
	push bc ; $5f53
	push de ; $5f54
	push hl ; $5f55
	ldh a, [$ff96] ; $5f56
	push af ; $5f58
	ld a, $05 ; $5f59
	ldh [$ff96], a ; $5f5b
	ldh [rWBK], a ; $5f5d
	xor a, a ; $5f5f
	call Func_05_5d2b ; $5f60
	ld a, e ; $5f63
	ld [$d864], a ; $5f64
	ld a, d ; $5f67
	ld [$d865], a ; $5f68
	ld b, $ff ; $5f6b
	ld a, c ; $5f6d
	cpl ; $5f6e
	inc a ; $5f6f
	ld c, a ; $5f70
	ld [$c362], a ; $5f71
	call Func_05_5c18 ; $5f74
	ld hl, $c600 ; $5f77
	pop af ; $5f7a
	ldh [$ff96], a ; $5f7b
	ldh [rWBK], a ; $5f7d
Label_05_5f7f:
	ld a, [hl] ; $5f7f
	cp a, $20 ; $5f80
	jr nc, Label_05_5fbe ; $5f82
	push hl ; $5f84
	push af ; $5f85
	add a, a ; $5f86
	ld hl, $5f94 ; $5f87
	add a, l ; $5f8a
	ld l, a ; $5f8b
	jr nc, Label_05_5f8f ; $5f8c
	inc h ; $5f8e
Label_05_5f8f:
	ld a, [hl+] ; $5f8f
	ld h, [hl] ; $5f90
	ld l, a ; $5f91
	pop af ; $5f92
	jp hl ; $5f93
	INCBIN "data/bank_005/d_5f94.bin" ; $5f94, 42 bytes
Label_05_5fbe:
	ld [de], a ; $5fbe
	inc hl ; $5fbf
	ld a, [hl] ; $5fc0
	cp a, $de ; $5fc1
	jr z, Label_05_5fc9 ; $5fc3
	cp a, $df ; $5fc5
	jr nz, Label_05_5fdb ; $5fc7
Label_05_5fc9:
	push hl ; $5fc9
	ld h, d ; $5fca
	ld l, e ; $5fcb
	add hl, bc ; $5fcc
	ld b, a ; $5fcd
	ld a, [hl] ; $5fce
	cp a, $03 ; $5fcf
	ld a, b ; $5fd1
	ld b, $ff ; $5fd2
	jr nz, Label_05_5fd8 ; $5fd4
	sub a, $d0 ; $5fd6
Label_05_5fd8:
	ld [hl], a ; $5fd8
	pop hl ; $5fd9
	inc hl ; $5fda
Label_05_5fdb:
	inc de ; $5fdb
	ld a, e ; $5fdc
	and a, $3f ; $5fdd
	jp nz, Label_05_5f7f ; $5fdf
	push hl ; $5fe2
	ld h, d ; $5fe3
	ld l, e ; $5fe4
	add hl, bc ; $5fe5
	ld d, h ; $5fe6
	ld e, l ; $5fe7
	pop hl ; $5fe8
	jp Label_05_5f7f ; $5fe9
	pop hl ; $5fec
	pop hl ; $5fed
	pop de ; $5fee
	pop bc ; $5fef
	pop af ; $5ff0
	ret ; $5ff1
Func_05_5ff2:
	ld hl, $0000 ; $5ff2
	cp a, $ff ; $5ff5
	ret z ; $5ff7
	ld hl, $d000 ; $5ff8
	cp a, $18 ; $5ffb
	jr nc, Label_05_600d ; $5ffd
	push bc ; $5fff
	ld c, $00 ; $6000
	ld b, a ; $6002
	sra b ; $6003
	rr c ; $6005
	sra b ; $6007
	rr c ; $6009
	add hl, bc ; $600b
	pop bc ; $600c
Label_05_600d:
	ret ; $600d
	INCBIN "data/bank_005/d_600e.bin" ; $600e, 124 bytes
Func_05_608a:
	push bc ; $608a
	push de ; $608b
	push hl ; $608c
	call Func_05_5ff2 ; $608d
	ld a, h ; $6090
	ld b, $08 ; $6091
	or a, l ; $6093
	jr z, Label_05_60c6 ; $6094
	ldh a, [$ff96] ; $6096
	push af ; $6098
	ld a, $04 ; $6099
	ldh [$ff96], a ; $609b
	ldh [rWBK], a ; $609d
	ld a, l ; $609f
	ldh [$ffea], a ; $60a0
	ld a, h ; $60a2
	ldh [$ffeb], a ; $60a3
	ld hl, $ffea ; $60a5
	ld a, [hl+] ; $60a8
	ld h, [hl] ; $60a9
	add a, $21 ; $60aa
	ld l, a ; $60ac
	ld a, [hl] ; $60ad
	ld c, a ; $60ae
	sub a, $1e ; $60af
	bit 7, a ; $60b1
	ld b, $08 ; $60b3
	jr nz, Label_05_60c6 ; $60b5
	ld l, a ; $60b7
	ld h, $00 ; $60b8
	add hl, hl ; $60ba
	ld de, $60cb ; $60bb
	add hl, de ; $60be
	inc hl ; $60bf
	ld b, [hl] ; $60c0
	pop af ; $60c1
	ldh [$ff96], a ; $60c2
	ldh [rWBK], a ; $60c4
Label_05_60c6:
	ld a, b ; $60c6
	pop hl ; $60c7
	pop de ; $60c8
	pop bc ; $60c9
	ret ; $60ca
	INCBIN "data/bank_005/d_60cb.bin" ; $60cb, 175 bytes
Func_05_617a:
	call Func_05_4096 ; $617a
	call Func_05_436f ; $617d
	ret ; $6180
	INCBIN "data/bank_005/d_6181.bin" ; $6181, 33 bytes
Func_05_61a2:
	push af ; $61a2
	push bc ; $61a3
	push de ; $61a4
	push hl ; $61a5
	ld b, a ; $61a6
	ldh a, [$ff96] ; $61a7
	push af ; $61a9
	ld a, $05 ; $61aa
	ldh [$ff96], a ; $61ac
	ldh [rWBK], a ; $61ae
	ld a, [$d824] ; $61b0
	cp a, b ; $61b3
	jr nz, Label_05_61fa ; $61b4
	ld [$d821], a ; $61b6
Label_05_61b9:
	xor a, a ; $61b9
	ld [$c3bb], a ; $61ba
	ld [$c3bc], a ; $61bd
	ldh a, [$ff96] ; $61c0
	push af ; $61c2
	ld a, $07 ; $61c3
	ldh [$ff96], a ; $61c5
	ldh [rWBK], a ; $61c7
	call Func_05_73cb ; $61c9
	call Func_05_622e ; $61cc
	pop af ; $61cf
	ldh [$ff96], a ; $61d0
	ldh [rWBK], a ; $61d2
	ld a, [$d824] ; $61d4
	push af ; $61d7
	call Func_05_6eea ; $61d8
	ld bc, $0006 ; $61db
	add hl, bc ; $61de
	ld a, [hl+] ; $61df
	ld h, [hl] ; $61e0
	ld l, a ; $61e1
	call Func_05_5bfc ; $61e2
	pop af ; $61e5
	call Func_05_6f70 ; $61e6
	call Func_05_5648 ; $61e9
	ld a, [$d824] ; $61ec
	call Func_05_43a8 ; $61ef
	ld a, [$d850] ; $61f2
	or a, a ; $61f5
	jr nz, Label_05_61b9 ; $61f6
	jr Label_05_6224 ; $61f8
Label_05_61fa:
	ld a, b ; $61fa
	call Func_05_6eea ; $61fb
	ld b, h ; $61fe
	ld c, l ; $61ff
	ld d, [hl] ; $6200
	inc d ; $6201
	inc hl ; $6202
	ld e, [hl] ; $6203
	inc e ; $6204
	ld hl, $0004 ; $6205
	add hl, bc ; $6208
	ld a, [hl] ; $6209
	and a, $02 ; $620a
	jr z, Label_05_620f ; $620c
	inc d ; $620e
Label_05_620f:
	ld hl, $0006 ; $620f
	add hl, bc ; $6212
	ld a, [hl+] ; $6213
	ld h, [hl] ; $6214
	ld l, a ; $6215
	ld a, h ; $6216
	cp a, $ff ; $6217
	jr z, Label_05_6224 ; $6219
	call Func_05_5c18 ; $621b
	ld hl, $c600 ; $621e
	call Func_05_4e23 ; $6221
Label_05_6224:
	pop af ; $6224
	ldh [$ff96], a ; $6225
	ldh [rWBK], a ; $6227
	pop hl ; $6229
	pop de ; $622a
	pop bc ; $622b
	pop af ; $622c
	ret ; $622d
Func_05_622e:
	ldh a, [$ff96] ; $622e
	push af ; $6230
	ld a, $07 ; $6231
	ldh [$ff96], a ; $6233
	ldh [rWBK], a ; $6235
	ld hl, $d300 ; $6237
	ld de, $8800 ; $623a
	ld c, $1b ; $623d
	call Func_00_0480 ; $623f
	push af ; $6242
	ldh a, [rLCDC] ; $6243
	bit 7, a ; $6245
	jr z, Label_05_624c ; $6247
	call Func_00_2631 ; $6249
Label_05_624c:
	pop af ; $624c
	ld hl, $d4b0 ; $624d
	ld de, $89b0 ; $6250
	ld c, $1b ; $6253
	call Func_00_0480 ; $6255
	push af ; $6258
	ldh a, [rLCDC] ; $6259
	bit 7, a ; $625b
	jr z, Label_05_6262 ; $625d
	call Func_00_2631 ; $625f
Label_05_6262:
	pop af ; $6262
	pop af ; $6263
	ldh [$ff96], a ; $6264
	ldh [rWBK], a ; $6266
	ret ; $6268
	INCBIN "data/bank_005/d_6269.bin" ; $6269, 83 bytes
Func_05_62bc:
	push af ; $62bc
	push bc ; $62bd
	push de ; $62be
	push hl ; $62bf
	ld b, a ; $62c0
	ldh a, [$ff96] ; $62c1
	push af ; $62c3
	ld a, $05 ; $62c4
	ldh [$ff96], a ; $62c6
	ldh [rWBK], a ; $62c8
	ld a, b ; $62ca
	call Func_05_42ed ; $62cb
	pop af ; $62ce
	ldh [$ff96], a ; $62cf
	ldh [rWBK], a ; $62d1
	pop hl ; $62d3
	pop de ; $62d4
	pop bc ; $62d5
	pop af ; $62d6
	ret ; $62d7
Func_05_62d8:
	push af ; $62d8
	call Func_05_43a8 ; $62d9
	call Func_05_42ed ; $62dc
	call Func_05_4757 ; $62df
	call Func_05_6eba ; $62e2
	pop af ; $62e5
	ret ; $62e6
	INCBIN "data/bank_005/d_62e7.bin" ; $62e7, 953 bytes
Func_05_66a0:
	ldh a, [$ff9e] ; $66a0
	or a, a ; $66a2
	ret z ; $66a3
	push af ; $66a4
	push bc ; $66a5
	push de ; $66a6
	push hl ; $66a7
	ld hl, $0137 ; $66a8
	ld de, $0a01 ; $66ab
	call Func_05_46b0 ; $66ae
	ld [$c700], a ; $66b1
	farcall FarPtr_05_18 ; $66b4
	call Func_05_7232 ; $66b7
	ld a, [$c700] ; $66ba
	call Func_05_477f ; $66bd
	push af ; $66c0
	ld a, [$c700] ; $66c1
	call Func_05_72bd ; $66c4
	pop af ; $66c7
	cp a, $ff ; $66c8
	jr z, Label_05_66d9 ; $66ca
	ld hl, $66de ; $66cc
	add a, a ; $66cf
	add a, l ; $66d0
	ld l, a ; $66d1
	jr nc, Label_05_66d5 ; $66d2
	inc h ; $66d4
Label_05_66d5:
	ld a, [hl+] ; $66d5
	ld h, [hl] ; $66d6
	ld l, a ; $66d7
	jp hl ; $66d8
Label_05_66d9:
	pop hl ; $66d9
	pop de ; $66da
	pop bc ; $66db
	pop af ; $66dc
	ret ; $66dd
	INCBIN "data/bank_005/d_66de.bin" ; $66de, 1613 bytes
Func_05_6d2b:
	push af ; $6d2b
	ld a, $00 ; $6d2c
	call Func_05_6d3b ; $6d2e
	pop af ; $6d31
	ret ; $6d32
	INCBIN "data/bank_005/d_6d33.bin" ; $6d33, 8 bytes
Func_05_6d3b:
	push bc ; $6d3b
	push de ; $6d3c
	push hl ; $6d3d
	ld hl, $6d65 ; $6d3e
	sla e ; $6d41
	rl d ; $6d43
	add hl, de ; $6d45
	ld e, [hl] ; $6d46
	inc hl ; $6d47
	ld d, [hl] ; $6d48
	ld hl, $a800 ; $6d49
	add hl, de ; $6d4c
	or a, a ; $6d4d
	jr nz, Label_05_6d58 ; $6d4e
	ld de, $c600 ; $6d50
	ld bc, $0180 ; $6d53
	jr Label_05_6d5e ; $6d56
Label_05_6d58:
	ld de, $d880 ; $6d58
	ld bc, $0020 ; $6d5b
Label_05_6d5e:
	call CopyMemoryBC ; $6d5e
	pop hl ; $6d61
	pop de ; $6d62
	pop bc ; $6d63
	ret ; $6d64
	INCBIN "data/bank_005/d_6d65.bin" ; $6d65, 164 bytes
Func_05_6e09:
	push af ; $6e09
	push bc ; $6e0a
	push de ; $6e0b
	push hl ; $6e0c
	ld a, $05 ; $6e0d
	ldh [$ff96], a ; $6e0f
	ldh [rWBK], a ; $6e11
	ld hl, $d000 ; $6e13
	ld c, $80 ; $6e16
	call ClearMemory16 ; $6e18
	ld hl, $d800 ; $6e1b
	ld c, $80 ; $6e1e
	call ClearMemory16 ; $6e20
	ld de, $d000 ; $6e23
	ld hl, $c3b4 ; $6e26
	ld a, e ; $6e29
	ld [hl+], a ; $6e2a
	ld [hl], d ; $6e2b
	ld a, $05 ; $6e2c
	ld [$c3b3], a ; $6e2e
	ld a, $80 ; $6e31
	ld [$c3b6], a ; $6e33
	ld a, $ff ; $6e36
	ld [$d824], a ; $6e38
	ld a, $fe ; $6e3b
	ld [$d82f], a ; $6e3d
	pop hl ; $6e40
	pop de ; $6e41
	pop bc ; $6e42
	pop af ; $6e43
	ret ; $6e44
Func_05_6e45:
	push bc ; $6e45
	push de ; $6e46
	push hl ; $6e47
	call Func_05_72dc ; $6e48
	ld a, $05 ; $6e4b
	ldh [$ff96], a ; $6e4d
	ldh [rWBK], a ; $6e4f
	ld h, d ; $6e51
	ld l, e ; $6e52
	call Func_05_464b ; $6e53
	ld a, h ; $6e56
	add a, d ; $6e57
	ld d, a ; $6e58
	ld a, l ; $6e59
	add a, e ; $6e5a
	ld e, a ; $6e5b
	call Func_05_6e6d ; $6e5c
	ld a, [$d820] ; $6e5f
	cp a, $ff ; $6e62
	jr z, Label_05_6e69 ; $6e64
	ld a, [$d820] ; $6e66
Label_05_6e69:
	pop hl ; $6e69
	pop de ; $6e6a
	pop bc ; $6e6b
	ret ; $6e6c
Func_05_6e6d:
	push de ; $6e6d
	push bc ; $6e6e
	push hl ; $6e6f
	ld a, $05 ; $6e70
	ldh [$ff96], a ; $6e72
	ldh [rWBK], a ; $6e74
	call Func_05_6e96 ; $6e76
	cp a, $ff ; $6e79
	jr z, Label_05_6e92 ; $6e7b
	ld [$d820], a ; $6e7d
	add a, a ; $6e80
	add a, a ; $6e81
	add a, a ; $6e82
	ld hl, $dc00 ; $6e83
	add a, l ; $6e86
	ld l, a ; $6e87
	jr nc, Label_05_6e8b ; $6e88
	inc h ; $6e8a
Label_05_6e8b:
	ld [hl], d ; $6e8b
	inc hl ; $6e8c
	ld [hl], e ; $6e8d
	inc hl ; $6e8e
	ld [hl], b ; $6e8f
	inc hl ; $6e90
	ld [hl], c ; $6e91
Label_05_6e92:
	pop hl ; $6e92
	pop bc ; $6e93
	pop de ; $6e94
	ret ; $6e95
Func_05_6e96:
	push hl ; $6e96
	push bc ; $6e97
	push de ; $6e98
	ld b, $07 ; $6e99
	ld a, [$dc70] ; $6e9b
	ld c, $01 ; $6e9e
Label_05_6ea0:
	rrca ; $6ea0
	jr nc, Label_05_6eac ; $6ea1
	sla c ; $6ea3
	dec b ; $6ea5
	jr nz, Label_05_6ea0 ; $6ea6
	ld a, $ff ; $6ea8
	jr Label_05_6eb6 ; $6eaa
Label_05_6eac:
	ld a, [$dc70] ; $6eac
	or a, c ; $6eaf
	ld [$dc70], a ; $6eb0
	ld a, $07 ; $6eb3
	sub a, b ; $6eb5
Label_05_6eb6:
	pop de ; $6eb6
	pop bc ; $6eb7
	pop hl ; $6eb8
	ret ; $6eb9
Func_05_6eba:
	push bc ; $6eba
	push de ; $6ebb
	ld d, a ; $6ebc
	call Func_05_6eea ; $6ebd
	xor a, a ; $6ec0
	ld c, $08 ; $6ec1
Label_05_6ec3:
	ld [hl+], a ; $6ec3
	dec c ; $6ec4
	jr nz, Label_05_6ec3 ; $6ec5
	ld c, d ; $6ec7
	inc c ; $6ec8
	ld a, $01 ; $6ec9
Label_05_6ecb:
	dec c ; $6ecb
	jr z, Label_05_6ed2 ; $6ecc
	sla a ; $6ece
	jr Label_05_6ecb ; $6ed0
Label_05_6ed2:
	ld b, a ; $6ed2
	ld a, [$dc70] ; $6ed3
	and a, b ; $6ed6
	ld a, $ff ; $6ed7
	jr z, Label_05_6ee7 ; $6ed9
	ld a, b ; $6edb
	xor a, $ff ; $6edc
	ld b, a ; $6ede
	ld a, [$dc70] ; $6edf
	and a, b ; $6ee2
	ld [$dc70], a ; $6ee3
	ld a, d ; $6ee6
Label_05_6ee7:
	pop de ; $6ee7
	pop bc ; $6ee8
	ret ; $6ee9
Func_05_6eea:
	push af ; $6eea
	and a, $07 ; $6eeb
	add a, a ; $6eed
	add a, a ; $6eee
	add a, a ; $6eef
	ld hl, $dc00 ; $6ef0
	add a, l ; $6ef3
	ld l, a ; $6ef4
	jr nc, Label_05_6ef8 ; $6ef5
	inc h ; $6ef7
Label_05_6ef8:
	pop af ; $6ef8
	ret ; $6ef9
Func_05_6efa:
	push af ; $6efa
	push bc ; $6efb
	push de ; $6efc
	push hl ; $6efd
	call Func_05_6eea ; $6efe
	ld de, $dc78 ; $6f01
	ld c, $08 ; $6f04
Label_05_6f06:
	ld a, [hl+] ; $6f06
	ld [de], a ; $6f07
	inc de ; $6f08
	dec c ; $6f09
	jr nz, Label_05_6f06 ; $6f0a
	pop hl ; $6f0c
	pop de ; $6f0d
	pop bc ; $6f0e
	pop af ; $6f0f
	ret ; $6f10
Func_05_6f11:
	push af ; $6f11
	push bc ; $6f12
	push de ; $6f13
	push hl ; $6f14
	call Func_05_6eea ; $6f15
	ld d, h ; $6f18
	ld e, l ; $6f19
	ld hl, $dc78 ; $6f1a
	ld c, $08 ; $6f1d
Label_05_6f1f:
	ld a, [hl+] ; $6f1f
	ld [de], a ; $6f20
	inc de ; $6f21
	dec c ; $6f22
	jr nz, Label_05_6f1f ; $6f23
	pop hl ; $6f25
	pop de ; $6f26
	pop bc ; $6f27
	pop af ; $6f28
	ret ; $6f29
Func_05_6f2a:
	push af ; $6f2a
	ld a, l ; $6f2b
	and a, $1f ; $6f2c
	jr nz, Label_05_6f36 ; $6f2e
	push bc ; $6f30
	ld bc, $ffe0 ; $6f31
	add hl, bc ; $6f34
	pop bc ; $6f35
Label_05_6f36:
	pop af ; $6f36
	ret ; $6f37
Func_05_6f38:
	push af ; $6f38
	ldh a, [$ff96] ; $6f39
	push af ; $6f3b
	ld a, $05 ; $6f3c
	ldh [$ff96], a ; $6f3e
	ldh [rWBK], a ; $6f40
	ld a, [$c3b5] ; $6f42
	add a, $03 ; $6f45
	cp a, h ; $6f47
	jr nc, Label_05_6f4d ; $6f48
	sub a, $03 ; $6f4a
	ld h, a ; $6f4c
Label_05_6f4d:
	pop af ; $6f4d
	ldh [$ff96], a ; $6f4e
	ldh [rWBK], a ; $6f50
	pop af ; $6f52
	ret ; $6f53
Func_05_6f54:
	push af ; $6f54
	ldh a, [$ff96] ; $6f55
	push af ; $6f57
	ld a, $05 ; $6f58
	ldh [$ff96], a ; $6f5a
	ldh [rWBK], a ; $6f5c
	ld a, [$c3b5] ; $6f5e
	add a, $07 ; $6f61
	cp a, h ; $6f63
	jr nc, Label_05_6f69 ; $6f64
	sub a, $03 ; $6f66
	ld h, a ; $6f68
Label_05_6f69:
	pop af ; $6f69
	ldh [$ff96], a ; $6f6a
	ldh [rWBK], a ; $6f6c
	pop af ; $6f6e
	ret ; $6f6f
Func_05_6f70:
	push af ; $6f70
	push bc ; $6f71
	push de ; $6f72
	push hl ; $6f73
	ld b, a ; $6f74
	ldh a, [$ff96] ; $6f75
	push af ; $6f77
	ld a, b ; $6f78
	call Func_05_6eea ; $6f79
	ld d, [hl] ; $6f7c
	inc hl ; $6f7d
	ld e, [hl] ; $6f7e
	inc hl ; $6f7f
	ld b, [hl] ; $6f80
	inc hl ; $6f81
	ld c, [hl] ; $6f82
	inc hl ; $6f83
	ld a, [hl] ; $6f84
	cp a, $ff ; $6f85
	jp z, Label_05_707c ; $6f87
	ld l, e ; $6f8a
	ld h, $00 ; $6f8b
	add hl, hl ; $6f8d
	add hl, hl ; $6f8e
	add hl, hl ; $6f8f
	add hl, hl ; $6f90
	add hl, hl ; $6f91
	ld a, d ; $6f92
	add a, l ; $6f93
	ld l, a ; $6f94
	jr nc, Label_05_6f98 ; $6f95
	inc h ; $6f97
Label_05_6f98:
	ld d, h ; $6f98
	ld e, l ; $6f99
	ld hl, $c3b4 ; $6f9a
	ld a, [hl+] ; $6f9d
	ld h, [hl] ; $6f9e
	ld l, a ; $6f9f
	add hl, de ; $6fa0
	ld a, [$c3b5] ; $6fa1
	add a, $03 ; $6fa4
	cp a, h ; $6fa6
	jr nc, Label_05_6fad ; $6fa7
	ld a, h ; $6fa9
	sub a, $04 ; $6faa
	ld h, a ; $6fac
Label_05_6fad:
	ld e, b ; $6fad
	ld d, c ; $6fae
	ld a, [$c3b6] ; $6faf
	push af ; $6fb2
	push de ; $6fb3
	push hl ; $6fb4
	dec d ; $6fb5
	dec d ; $6fb6
	dec e ; $6fb7
	dec e ; $6fb8
	ld a, [$c3b3] ; $6fb9
	ld a, a ; $6fbc
	ldh [$ff96], a ; $6fbd
	ldh [rWBK], a ; $6fbf
	ld a, [$c3bb] ; $6fc1
	add a, $80 ; $6fc4
	ld [$cb75], a ; $6fc6
	push hl ; $6fc9
	ld [hl], $02 ; $6fca
	inc hl ; $6fcc
	call Func_05_6f2a ; $6fcd
	ld b, e ; $6fd0
	ld a, $03 ; $6fd1
Label_05_6fd3:
	ld [hl+], a ; $6fd3
	call Func_05_6f2a ; $6fd4
	dec b ; $6fd7
	jr nz, Label_05_6fd3 ; $6fd8
	ld [hl], $04 ; $6fda
	inc hl ; $6fdc
	call Func_05_6f2a ; $6fdd
	pop hl ; $6fe0
	ld a, $20 ; $6fe1
	add a, l ; $6fe3
	ld l, a ; $6fe4
	jr nc, Label_05_6fe8 ; $6fe5
	inc h ; $6fe7
Label_05_6fe8:
	call Func_05_6f38 ; $6fe8
Label_05_6feb:
	push hl ; $6feb
	ld [hl], $05 ; $6fec
	inc hl ; $6fee
	call Func_05_6f2a ; $6fef
	ld b, e ; $6ff2
	bit 0, d ; $6ff3
	jr z, Label_05_7011 ; $6ff5
	ld a, [$cb75] ; $6ff7
Label_05_6ffa:
	rst Rst30 ; $6ffa
	ld h, b ; $6ffb
	inc b ; $6ffc
	jr z, Label_05_7002 ; $6ffd
	ld [hl+], a ; $6fff
	jr Label_05_7005 ; $7000
Label_05_7002:
	ld [hl], $20 ; $7002
	inc hl ; $7004
Label_05_7005:
	call Func_05_6f2a ; $7005
	inc a ; $7008
	dec b ; $7009
	jr nz, Label_05_6ffa ; $700a
	ld [$cb75], a ; $700c
	jr Label_05_701a ; $700f
Label_05_7011:
	ld a, $20 ; $7011
Label_05_7013:
	ld [hl+], a ; $7013
	call Func_05_6f2a ; $7014
	dec b ; $7017
	jr nz, Label_05_7013 ; $7018
Label_05_701a:
	ld [hl], $06 ; $701a
	inc hl ; $701c
	call Func_05_6f2a ; $701d
	pop hl ; $7020
	ld a, $20 ; $7021
	add a, l ; $7023
	ld l, a ; $7024
	jr nc, Label_05_7028 ; $7025
	inc h ; $7027
Label_05_7028:
	call Func_05_6f38 ; $7028
	dec d ; $702b
	jr nz, Label_05_6feb ; $702c
	push hl ; $702e
	ld [hl], $07 ; $702f
	inc hl ; $7031
	call Func_05_6f2a ; $7032
	ld b, e ; $7035
	ld a, $08 ; $7036
Label_05_7038:
	ld [hl+], a ; $7038
	call Func_05_6f2a ; $7039
	dec b ; $703c
	jr nz, Label_05_7038 ; $703d
	ld [hl], $09 ; $703f
	inc hl ; $7041
	call Func_05_6f2a ; $7042
	pop hl ; $7045
	ld a, $20 ; $7046
	add a, l ; $7048
	ld l, a ; $7049
	jr nc, Label_05_704d ; $704a
	inc h ; $704c
Label_05_704d:
	call Func_05_6f38 ; $704d
	pop hl ; $7050
	ld bc, $0400 ; $7051
	add hl, bc ; $7054
	pop de ; $7055
	pop af ; $7056
	dec e ; $7057
	dec e ; $7058
	ld c, a ; $7059
Label_05_705a:
	push hl ; $705a
	ld [hl], c ; $705b
	inc hl ; $705c
	call Func_05_6f2a ; $705d
	ld b, e ; $7060
Label_05_7061:
	ld [hl], c ; $7061
	inc hl ; $7062
	call Func_05_6f2a ; $7063
	dec b ; $7066
	jr nz, Label_05_7061 ; $7067
	ld [hl], c ; $7069
	inc hl ; $706a
	call Func_05_6f2a ; $706b
	pop hl ; $706e
	ld a, $20 ; $706f
	add a, l ; $7071
	ld l, a ; $7072
	jr nc, Label_05_7076 ; $7073
	inc h ; $7075
Label_05_7076:
	call Func_05_6f54 ; $7076
	dec d ; $7079
	jr nz, Label_05_705a ; $707a
Label_05_707c:
	pop af ; $707c
	ldh [$ff96], a ; $707d
	ldh [rWBK], a ; $707f
	pop hl ; $7081
	pop de ; $7082
	pop bc ; $7083
	pop af ; $7084
	ret ; $7085
Func_05_7086:
	push af ; $7086
	push bc ; $7087
	push de ; $7088
	push hl ; $7089
	ld a, d ; $708a
	and a, $1f ; $708b
	ld d, a ; $708d
	call Func_05_70aa ; $708e
	pop hl ; $7091
	pop de ; $7092
	pop bc ; $7093
	pop af ; $7094
	ret ; $7095
Func_05_7096:
	push af ; $7096
	push bc ; $7097
	push de ; $7098
	push hl ; $7099
	call Func_05_6eea ; $709a
	inc hl ; $709d
	ld d, [hl] ; $709e
	inc hl ; $709f
	inc hl ; $70a0
	ld e, [hl] ; $70a1
	call Func_05_70aa ; $70a2
	pop hl ; $70a5
	pop de ; $70a6
	pop bc ; $70a7
	pop af ; $70a8
	ret ; $70a9
Func_05_70aa:
	ld hl, $dc40 ; $70aa
	ld c, $20 ; $70ad
	xor a, a ; $70af
Label_05_70b0:
	ld [hl+], a ; $70b0
	dec c ; $70b1
	jr nz, Label_05_70b0 ; $70b2
	ld hl, $dc40 ; $70b4
	ld a, d ; $70b7
	and a, $1f ; $70b8
	ld d, a ; $70ba
	add a, l ; $70bb
	ld l, a ; $70bc
	jr nc, Label_05_70c0 ; $70bd
	inc h ; $70bf
Label_05_70c0:
	ld a, $01 ; $70c0
Label_05_70c2:
	ld [hl+], a ; $70c2
	inc d ; $70c3
	bit 5, d ; $70c4
	jr z, Label_05_70cd ; $70c6
	res 5, d ; $70c8
	ld hl, $dc40 ; $70ca
Label_05_70cd:
	dec e ; $70cd
	jr nz, Label_05_70c2 ; $70ce
	ret ; $70d0
Func_05_70d1:
	push af ; $70d1
	push bc ; $70d2
	push de ; $70d3
	push hl ; $70d4
	call Func_05_6eea ; $70d5
	inc hl ; $70d8
	ld d, [hl] ; $70d9
	inc hl ; $70da
	inc hl ; $70db
	ld e, [hl] ; $70dc
	ld a, e ; $70dd
	cp a, $07 ; $70de
	jr nc, Label_05_70ef ; $70e0
	ld a, $07 ; $70e2
	sub a, e ; $70e4
	srl a ; $70e5
	ld e, a ; $70e7
	ld a, d ; $70e8
	sub a, e ; $70e9
	and a, $1f ; $70ea
	ld d, a ; $70ec
	ld e, $07 ; $70ed
Label_05_70ef:
	ld hl, $dc40 ; $70ef
	ld c, $20 ; $70f2
	xor a, a ; $70f4
Label_05_70f5:
	ld [hl+], a ; $70f5
	dec c ; $70f6
	jr nz, Label_05_70f5 ; $70f7
	ld hl, $dc40 ; $70f9
	ld a, d ; $70fc
	and a, $1f ; $70fd
	ld d, a ; $70ff
	add a, l ; $7100
	ld l, a ; $7101
	jr nc, Label_05_7105 ; $7102
	inc h ; $7104
Label_05_7105:
	ld a, $01 ; $7105
Label_05_7107:
	ld [hl+], a ; $7107
	inc d ; $7108
	bit 5, d ; $7109
	jr z, Label_05_7112 ; $710b
	res 5, d ; $710d
	ld hl, $dc40 ; $710f
Label_05_7112:
	dec e ; $7112
	jr nz, Label_05_7107 ; $7113
	pop hl ; $7115
	pop de ; $7116
	pop bc ; $7117
	pop af ; $7118
	ret ; $7119
Func_05_711a:
	push af ; $711a
	push bc ; $711b
	push de ; $711c
	push hl ; $711d
	call Func_05_71c4 ; $711e
	rst Rst20 ; $7121
	nop ; $7122
	inc bc ; $7123
	ld hl, $dc60 ; $7124
Label_05_7127:
	ld a, [hl] ; $7127
	cp a, $ff ; $7128
	jr z, Label_05_7140 ; $712a
	ld c, [hl] ; $712c
	inc hl ; $712d
	ld b, [hl] ; $712e
	inc hl ; $712f
	call Func_05_7176 ; $7130
	push af ; $7133
	ldh a, [rLCDC] ; $7134
	bit 7, a ; $7136
	jr z, Label_05_713d ; $7138
	call Func_00_2631 ; $713a
Label_05_713d:
	pop af ; $713d
	jr Label_05_7127 ; $713e
Label_05_7140:
	rst Rst28 ; $7140
	nop ; $7141
	inc bc ; $7142
	pop hl ; $7143
	pop de ; $7144
	pop bc ; $7145
	pop af ; $7146
	ret ; $7147
Func_05_7148:
	push af ; $7148
	push bc ; $7149
	push de ; $714a
	push hl ; $714b
	call Func_05_71c4 ; $714c
	rst Rst20 ; $714f
	nop ; $7150
	inc bc ; $7151
	ld hl, $dc60 ; $7152
Label_05_7155:
	ld a, [hl] ; $7155
	cp a, $ff ; $7156
	jr z, Label_05_7163 ; $7158
	ld c, [hl] ; $715a
	inc hl ; $715b
	ld b, [hl] ; $715c
	inc hl ; $715d
	call Func_05_7176 ; $715e
	jr Label_05_7155 ; $7161
Label_05_7163:
	rst Rst28 ; $7163
	nop ; $7164
	inc bc ; $7165
	push af ; $7166
	ldh a, [rLCDC] ; $7167
	bit 7, a ; $7169
	jr z, Label_05_7170 ; $716b
	call Func_00_2631 ; $716d
Label_05_7170:
	pop af ; $7170
	pop hl ; $7171
	pop de ; $7172
	pop bc ; $7173
	pop af ; $7174
	ret ; $7175
Func_05_7176:
	push af ; $7176
	push bc ; $7177
	push de ; $7178
	push hl ; $7179
	ld l, c ; $717a
	ld h, $00 ; $717b
	add hl, hl ; $717d
	add hl, hl ; $717e
	add hl, hl ; $717f
	add hl, hl ; $7180
	add hl, hl ; $7181
	ld d, h ; $7182
	ld e, l ; $7183
	ld hl, $c3b4 ; $7184
	ld a, [hl+] ; $7187
	ld h, [hl] ; $7188
	ld l, a ; $7189
	add hl, de ; $718a
	push hl ; $718b
	ld hl, $9800 ; $718c
	add hl, de ; $718f
	ld d, h ; $7190
	ld e, l ; $7191
	pop hl ; $7192
	ld c, b ; $7193
	sla c ; $7194
	ld a, [$c3b3] ; $7196
	ld b, a ; $7199
	ldh a, [$ff96] ; $719a
	push af ; $719c
	ld a, b ; $719d
	ldh [$ff96], a ; $719e
	ldh [rWBK], a ; $71a0
	push hl ; $71a2
	push de ; $71a3
	push bc ; $71a4
	call Func_00_0480 ; $71a5
	pop bc ; $71a8
	pop de ; $71a9
	ld hl, $2000 ; $71aa
	add hl, de ; $71ad
	ld d, h ; $71ae
	ld e, l ; $71af
	pop hl ; $71b0
	push de ; $71b1
	ld de, $0400 ; $71b2
	add hl, de ; $71b5
	pop de ; $71b6
	call Func_00_0480 ; $71b7
	pop af ; $71ba
	ldh [$ff96], a ; $71bb
	ldh [rWBK], a ; $71bd
	pop hl ; $71bf
	pop de ; $71c0
	pop bc ; $71c1
	pop af ; $71c2
	ret ; $71c3
Func_05_71c4:
	ld c, $00 ; $71c4
	ld hl, $dc40 ; $71c6
	ld de, $dc60 ; $71c9
Label_05_71cc:
	ld a, c ; $71cc
	cp a, $20 ; $71cd
	jr nc, Label_05_7200 ; $71cf
	ld a, [hl] ; $71d1
	or a, a ; $71d2
	jr nz, Label_05_71d9 ; $71d3
	inc hl ; $71d5
	inc c ; $71d6
	jr Label_05_71cc ; $71d7
Label_05_71d9:
	push hl ; $71d9
	ld h, d ; $71da
	ld l, e ; $71db
	ld [hl], c ; $71dc
	inc hl ; $71dd
	ld d, h ; $71de
	ld e, l ; $71df
	pop hl ; $71e0
	ld b, $00 ; $71e1
Label_05_71e3:
	ld a, c ; $71e3
	cp a, $20 ; $71e4
	jr nc, Label_05_71f6 ; $71e6
	ld a, [hl] ; $71e8
	or a, a ; $71e9
	jr z, Label_05_71f6 ; $71ea
	inc hl ; $71ec
	inc c ; $71ed
	inc b ; $71ee
	ld a, b ; $71ef
	cp a, $07 ; $71f0
	jr nc, Label_05_71f6 ; $71f2
	jr Label_05_71e3 ; $71f4
Label_05_71f6:
	push hl ; $71f6
	ld h, d ; $71f7
	ld l, e ; $71f8
	ld [hl], b ; $71f9
	inc hl ; $71fa
	ld d, h ; $71fb
	ld e, l ; $71fc
	pop hl ; $71fd
	jr Label_05_71cc ; $71fe
Label_05_7200:
	ld h, d ; $7200
	ld l, e ; $7201
	ld [hl], $ff ; $7202
	ret ; $7204
Func_05_7205:
	push af ; $7205
	push bc ; $7206
	push de ; $7207
	push hl ; $7208
	call Func_05_7096 ; $7209
	call Func_05_711a ; $720c
	pop hl ; $720f
	pop de ; $7210
	pop bc ; $7211
	pop af ; $7212
	ret ; $7213
Func_05_7214:
	push af ; $7214
	push bc ; $7215
	push de ; $7216
	push hl ; $7217
	call Func_05_70d1 ; $7218
	call Func_05_7148 ; $721b
	pop hl ; $721e
	pop de ; $721f
	pop bc ; $7220
	pop af ; $7221
	ret ; $7222
Func_05_7223:
	push af ; $7223
	push bc ; $7224
	push de ; $7225
	push hl ; $7226
	call Func_05_7086 ; $7227
	call Func_05_711a ; $722a
	pop hl ; $722d
	pop de ; $722e
	pop bc ; $722f
	pop af ; $7230
	ret ; $7231
Func_05_7232:
	push af ; $7232
	push bc ; $7233
	push de ; $7234
	push hl ; $7235
	ld a, [$d82f] ; $7236
	or a, a ; $7239
	jr nz, Label_05_723f ; $723a
	call Func_05_72dc ; $723c
Label_05_723f:
	rst Rst20 ; $723f
	ld h, b ; $7240
	inc b ; $7241
	ld a, [$d82f] ; $7242
	call Func_05_6f70 ; $7245
	rst Rst28 ; $7248
	ld h, b ; $7249
	inc b ; $724a
	farcall FarPtr_05_86 ; $724b
	ld b, h ; $724e
	ld c, l ; $724f
	ld d, [hl] ; $7250
	inc hl ; $7251
	ld e, [hl] ; $7252
	ld hl, $0006 ; $7253
	add hl, bc ; $7256
	ld a, [hl+] ; $7257
	ld h, [hl] ; $7258
	ld l, a ; $7259
	push hl ; $725a
	inc d ; $725b
	inc d ; $725c
	ld a, d ; $725d
	and a, $1f ; $725e
	ld d, a ; $7260
	inc e ; $7261
	ld a, e ; $7262
	and a, $1f ; $7263
	ld e, a ; $7265
	ld h, $00 ; $7266
	ld l, e ; $7268
	add hl, hl ; $7269
	add hl, hl ; $726a
	add hl, hl ; $726b
	add hl, hl ; $726c
	add hl, hl ; $726d
	ld a, d ; $726e
	add a, l ; $726f
	ld l, a ; $7270
	jr nc, Label_05_7274 ; $7271
	inc h ; $7273
Label_05_7274:
	ld d, h ; $7274
	ld e, l ; $7275
	ld hl, $c3b4 ; $7276
	ld a, [hl+] ; $7279
	ld h, [hl] ; $727a
	ld l, a ; $727b
	add hl, de ; $727c
	ld d, h ; $727d
	ld e, l ; $727e
	pop hl ; $727f
	ldh a, [$ff96] ; $7280
	push af ; $7282
	ld a, $05 ; $7283
	ldh [$ff96], a ; $7285
	ldh [rWBK], a ; $7287
	ld a, [$d82f] ; $7289
	ld c, a ; $728c
	ld a, [$c3b3] ; $728d
	ld a, a ; $7290
	ldh [$ff96], a ; $7291
	ldh [rWBK], a ; $7293
	push de ; $7295
	push hl ; $7296
	ld a, c ; $7297
	call Func_05_6eea ; $7298
	ld a, $02 ; $729b
	add a, l ; $729d
	ld l, a ; $729e
	jr nc, Label_05_72a2 ; $729f
	inc h ; $72a1
Label_05_72a2:
	ld c, [hl] ; $72a2
	dec c ; $72a3
	dec c ; $72a4
	pop hl ; $72a5
	pop de ; $72a6
	call Func_05_5db3 ; $72a7
	call Func_05_7792 ; $72aa
	pop af ; $72ad
	ldh [$ff96], a ; $72ae
	ldh [rWBK], a ; $72b0
	ld a, [$d82f] ; $72b2
	call Func_05_7205 ; $72b5
	pop hl ; $72b8
	pop de ; $72b9
	pop bc ; $72ba
	pop af ; $72bb
	ret ; $72bc
Func_05_72bd:
	push af ; $72bd
	push bc ; $72be
	push de ; $72bf
	push hl ; $72c0
	call Func_05_43a8 ; $72c1
	call Func_05_7205 ; $72c4
	call Func_05_4757 ; $72c7
	call Func_05_6eba ; $72ca
	pop hl ; $72cd
	pop de ; $72ce
	pop bc ; $72cf
	pop af ; $72d0
	ret ; $72d1
Func_05_72d2:
	push de ; $72d2
	ld d, $00 ; $72d3
	ld e, $20 ; $72d5
	call Func_05_7223 ; $72d7
	pop de ; $72da
	ret ; $72db
Func_05_72dc:
	push af ; $72dc
	push bc ; $72dd
	push de ; $72de
	push hl ; $72df
	ldh a, [$ff96] ; $72e0
	push af ; $72e2
	ld a, $05 ; $72e3
	ldh [$ff96], a ; $72e5
	ldh [rWBK], a ; $72e7
	ld a, [$d822] ; $72e9
	or a, a ; $72ec
	jr nz, Label_05_72fd ; $72ed
	ld a, $07 ; $72ef
	ldh [$ff96], a ; $72f1
	ldh [rWBK], a ; $72f3
	call Func_05_73cb ; $72f5
	call Func_05_730d ; $72f8
	jr Label_05_7303 ; $72fb
Label_05_72fd:
	ld a, [$c3bb] ; $72fd
	ld [$c3bc], a ; $7300
Label_05_7303:
	pop af ; $7303
	ldh [$ff96], a ; $7304
	ldh [rWBK], a ; $7306
	pop hl ; $7308
	pop de ; $7309
	pop bc ; $730a
	pop af ; $730b
	ret ; $730c
Func_05_730d:
	push af ; $730d
	push hl ; $730e
	xor a, a ; $730f
	ld hl, $c3b7 ; $7310
	ld [hl+], a ; $7313
	ld [hl+], a ; $7314
	ld [hl+], a ; $7315
	ld [hl+], a ; $7316
	ld [hl+], a ; $7317
	ld [hl+], a ; $7318
	ld [hl+], a ; $7319
	ld [hl+], a ; $731a
	ld [hl], a ; $731b
	ld [$cb75], a ; $731c
	pop hl ; $731f
	pop af ; $7320
	ret ; $7321
Func_05_7322:
	push af ; $7322
	push bc ; $7323
	push hl ; $7324
	sub a, $20 ; $7325
	push af ; $7327
	ld h, $00 ; $7328
	ld l, a ; $732a
	add hl, hl ; $732b
	add hl, hl ; $732c
	add hl, hl ; $732d
	add hl, hl ; $732e
	ld bc, $7920 ; $732f
	add hl, bc ; $7332
	push de ; $7333
	ld c, $10 ; $7334
Label_05_7336:
	ld a, [hl+] ; $7336
	call Func_05_737a ; $7337
	ld a, $08 ; $733a
	add a, e ; $733c
	ld e, a ; $733d
	jr nc, Label_05_7341 ; $733e
	inc d ; $7340
Label_05_7341:
	dec c ; $7341
	jr nz, Label_05_7336 ; $7342
	pop de ; $7344
	pop af ; $7345
	call Func_05_7370 ; $7346
	ld a, e ; $7349
	and a, $07 ; $734a
	add a, c ; $734c
	ld b, a ; $734d
	bit 3, a ; $734e
	jr z, Label_05_7359 ; $7350
	ld a, $80 ; $7352
	add a, e ; $7354
	ld e, a ; $7355
	jr nc, Label_05_7359 ; $7356
	inc d ; $7358
Label_05_7359:
	ld a, b ; $7359
	and a, $07 ; $735a
	ld b, a ; $735c
	ld a, e ; $735d
	and a, $f8 ; $735e
	or a, b ; $7360
	ld e, a ; $7361
	pop hl ; $7362
	pop bc ; $7363
	pop af ; $7364
	ret ; $7365
Func_05_7366:
	push af ; $7366
	push hl ; $7367
	sub a, $20 ; $7368
	call Func_05_7370 ; $736a
	pop hl ; $736d
	pop af ; $736e
	ret ; $736f
Func_05_7370:
	ld hl, $7f80 ; $7370
	add a, l ; $7373
	ld l, a ; $7374
	jr nc, Label_05_7378 ; $7375
	inc h ; $7377
Label_05_7378:
	ld c, [hl] ; $7378
	ret ; $7379
Func_05_737a:
	push bc ; $737a
	push de ; $737b
	push hl ; $737c
	ld b, a ; $737d
	ld a, e ; $737e
	and a, $07 ; $737f
	ld c, a ; $7381
	push de ; $7382
	ld de, rIE ; $7383
	push bc ; $7386
	or a, a ; $7387
	ld a, b ; $7388
	jr z, Label_05_7392 ; $7389
Label_05_738b:
	srl a ; $738b
	srl e ; $738d
	dec c ; $738f
	jr nz, Label_05_738b ; $7390
Label_05_7392:
	pop bc ; $7392
	ld h, a ; $7393
	ld a, $08 ; $7394
	sub a, c ; $7396
	ld c, a ; $7397
	or a, a ; $7398
	ld a, b ; $7399
	jr z, Label_05_73a3 ; $739a
Label_05_739c:
	sla a ; $739c
	sla d ; $739e
	dec c ; $73a0
	jr nz, Label_05_739c ; $73a1
Label_05_73a3:
	ld c, a ; $73a3
	ld b, h ; $73a4
	ld h, d ; $73a5
	ld l, e ; $73a6
	pop de ; $73a7
	push hl ; $73a8
	sra d ; $73a9
	rr e ; $73ab
	sra d ; $73ad
	rr e ; $73af
	sra d ; $73b1
	rr e ; $73b3
	ld hl, $d300 ; $73b5
	add hl, de ; $73b8
	pop de ; $73b9
	ld a, [hl] ; $73ba
	and a, d ; $73bb
	or a, b ; $73bc
	ld [hl+], a ; $73bd
	ld b, e ; $73be
	ld de, $000f ; $73bf
	add hl, de ; $73c2
	ld a, [hl] ; $73c3
	and a, b ; $73c4
	or a, c ; $73c5
	ld [hl], a ; $73c6
	pop hl ; $73c7
	pop de ; $73c8
	pop bc ; $73c9
	ret ; $73ca
Func_05_73cb:
	push af ; $73cb
	push bc ; $73cc
	push de ; $73cd
	push hl ; $73ce
	ld de, $d300 ; $73cf
	ld b, $80 ; $73d2
Label_05_73d4:
	ld hl, $7920 ; $73d4
	ld c, $01 ; $73d7
	call CopyMemoryFast ; $73d9
	dec b ; $73dc
	jr nz, Label_05_73d4 ; $73dd
	pop hl ; $73df
	pop de ; $73e0
	pop bc ; $73e1
	pop af ; $73e2
	ret ; $73e3
Func_05_73e4:
	push af ; $73e4
	push bc ; $73e5
	push de ; $73e6
	push hl ; $73e7
	ld a, $05 ; $73e8
	ldh [$ff96], a ; $73ea
	ldh [rWBK], a ; $73ec
	ld a, [$d821] ; $73ee
	farcall FarPtr_05_86 ; $73f1
	inc hl ; $73f4
	inc hl ; $73f5
	ld a, [hl+] ; $73f6
	dec a ; $73f7
	dec a ; $73f8
	ld b, [hl] ; $73f9
	dec b ; $73fa
	dec b ; $73fb
	sra b ; $73fc
	inc b ; $73fe
	ld l, b ; $73ff
	ld h, $00 ; $7400
	call Func_00_0926 ; $7402
	ld b, l ; $7405
	ld de, $d300 ; $7406
	ld a, [$c3bb] ; $7409
	ld l, a ; $740c
	ld h, $00 ; $740d
	add hl, hl ; $740f
	add hl, hl ; $7410
	add hl, hl ; $7411
	add hl, hl ; $7412
	add hl, de ; $7413
	ld d, h ; $7414
	ld e, l ; $7415
	ld a, $07 ; $7416
	ldh [$ff96], a ; $7418
	ldh [rWBK], a ; $741a
Label_05_741c:
	ld hl, $7920 ; $741c
	ld c, $01 ; $741f
	call CopyMemoryFast ; $7421
	dec b ; $7424
	jr nz, Label_05_741c ; $7425
	pop hl ; $7427
	pop de ; $7428
	pop bc ; $7429
	pop af ; $742a
	ret ; $742b
Func_05_742c:
	push af ; $742c
	push bc ; $742d
	push de ; $742e
	push hl ; $742f
	ldh a, [$ff96] ; $7430
	push af ; $7432
	rst Rst20 ; $7433
	nop ; $7434
	inc bc ; $7435
	push af ; $7436
	ldh a, [rLCDC] ; $7437
	bit 7, a ; $7439
	jr z, Label_05_7440 ; $743b
	call Func_00_2631 ; $743d
Label_05_7440:
	pop af ; $7440
	ld hl, $8c00 ; $7441
	ld a, $05 ; $7444
	ldh [$ff96], a ; $7446
	ldh [rWBK], a ; $7448
	ld a, [$c3b6] ; $744a
	bit 3, a ; $744d
	jr z, Label_05_7454 ; $744f
	ld hl, $ac00 ; $7451
Label_05_7454:
	push hl ; $7454
	ld de, rJOYP ; $7455
	add hl, de ; $7458
	push hl ; $7459
	add hl, de ; $745a
	push hl ; $745b
	add hl, de ; $745c
	push hl ; $745d
	add hl, de ; $745e
	ld d, h ; $745f
	ld e, l ; $7460
	ld a, $07 ; $7461
	ldh [$ff96], a ; $7463
	ldh [rWBK], a ; $7465
	ld hl, $d300 ; $7467
	ld c, $10 ; $746a
	call Func_00_0480 ; $746c
	push af ; $746f
	ldh a, [rLCDC] ; $7470
	bit 7, a ; $7472
	jr z, Label_05_7479 ; $7474
	call Func_00_2631 ; $7476
Label_05_7479:
	pop af ; $7479
	ld hl, $d400 ; $747a
	pop de ; $747d
	ld c, $10 ; $747e
	call Func_00_0480 ; $7480
	push af ; $7483
	ldh a, [rLCDC] ; $7484
	bit 7, a ; $7486
	jr z, Label_05_748d ; $7488
	call Func_00_2631 ; $748a
Label_05_748d:
	pop af ; $748d
	ld hl, $d500 ; $748e
	pop de ; $7491
	ld c, $10 ; $7492
	call Func_00_0480 ; $7494
	push af ; $7497
	ldh a, [rLCDC] ; $7498
	bit 7, a ; $749a
	jr z, Label_05_74a1 ; $749c
	call Func_00_2631 ; $749e
Label_05_74a1:
	pop af ; $74a1
	ld hl, $d600 ; $74a2
	pop de ; $74a5
	ld c, $10 ; $74a6
	call Func_00_0480 ; $74a8
	push af ; $74ab
	ldh a, [rLCDC] ; $74ac
	bit 7, a ; $74ae
	jr z, Label_05_74b5 ; $74b0
	call Func_00_2631 ; $74b2
Label_05_74b5:
	pop af ; $74b5
	ld c, $10 ; $74b6
	rst Rst30 ; $74b8
	ld b, b ; $74b9
	inc b ; $74ba
	jr z, Label_05_74bf ; $74bb
	ld c, $07 ; $74bd
Label_05_74bf:
	ld hl, $d700 ; $74bf
	pop de ; $74c2
	call Func_00_0480 ; $74c3
	push af ; $74c6
	ldh a, [rLCDC] ; $74c7
	bit 7, a ; $74c9
	jr z, Label_05_74d0 ; $74cb
	call Func_00_2631 ; $74cd
Label_05_74d0:
	pop af ; $74d0
	rst Rst28 ; $74d1
	nop ; $74d2
	inc bc ; $74d3
	pop af ; $74d4
	ldh [$ff96], a ; $74d5
	ldh [rWBK], a ; $74d7
	pop hl ; $74d9
	pop de ; $74da
	pop bc ; $74db
	pop af ; $74dc
	ret ; $74dd
	INCBIN "data/bank_005/d_74de.bin" ; $74de, 79 bytes
Func_05_752d:
	push af ; $752d
	push bc ; $752e
	push de ; $752f
	push hl ; $7530
	ldh a, [$ff96] ; $7531
	push af ; $7533
	ld a, $05 ; $7534
	ldh [$ff96], a ; $7536
	ldh [rWBK], a ; $7538
	ld de, $0000 ; $753a
	ld a, [$d821] ; $753d
	or a, a ; $7540
	jr z, Label_05_754d ; $7541
	ld a, [$c3bb] ; $7543
	ld d, a ; $7546
	ld e, $00 ; $7547
	sra d ; $7549
	rr e ; $754b
Label_05_754d:
	ld hl, $c3b7 ; $754d
	ld [hl], e ; $7550
	inc hl ; $7551
	ld [hl], d ; $7552
	ld a, [$d821] ; $7553
	farcall FarPtr_05_86 ; $7556
	inc hl ; $7559
	inc hl ; $755a
	ld a, [hl] ; $755b
	dec a ; $755c
	dec a ; $755d
	ld d, a ; $755e
	ld e, a ; $755f
	ld a, [$d821] ; $7560
	or a, a ; $7563
	jr z, Label_05_756b ; $7564
	ld a, [$c3bb] ; $7566
	add a, e ; $7569
	ld e, a ; $756a
Label_05_756b:
	ld hl, $c3b9 ; $756b
	ld [hl], d ; $756e
	inc hl ; $756f
	ld [hl], e ; $7570
	call Func_05_73e4 ; $7571
	pop af ; $7574
	ldh [$ff96], a ; $7575
	ldh [rWBK], a ; $7577
	pop hl ; $7579
	pop de ; $757a
	pop bc ; $757b
	pop af ; $757c
	ret ; $757d
Func_05_757e:
	push af ; $757e
	push bc ; $757f
	push de ; $7580
	push hl ; $7581
	ldh a, [$ff96] ; $7582
	push af ; $7584
	ld a, $05 ; $7585
	ldh [$ff96], a ; $7587
	ldh [rWBK], a ; $7589
	ld hl, $c3b9 ; $758b
	ld b, [hl] ; $758e
	inc hl ; $758f
	ld c, [hl] ; $7590
	ld hl, $c3b7 ; $7591
	ld a, [hl+] ; $7594
	ld d, [hl] ; $7595
	ld e, a ; $7596
	ld hl, $d869 ; $7597
	ld a, [hl+] ; $759a
	ld h, [hl] ; $759b
	ld l, a ; $759c
	ld a, [hl+] ; $759d
	cp a, $02 ; $759e
	jr z, Label_05_75c3 ; $75a0
	cp a, $03 ; $75a2
	jr z, Label_05_75c3 ; $75a4
	cp a, $01 ; $75a6
	jr nz, Label_05_75b8 ; $75a8
	ld e, $00 ; $75aa
	ld d, c ; $75ac
	sra d ; $75ad
	rr e ; $75af
	ld a, c ; $75b1
	add a, b ; $75b2
	ld [$c3ba], a ; $75b3
	jr Label_05_75c3 ; $75b6
Label_05_75b8:
	push af ; $75b8
	ld a, $07 ; $75b9
	ldh [$ff96], a ; $75bb
	ldh [rWBK], a ; $75bd
	pop af ; $75bf
	call Func_05_7322 ; $75c0
Label_05_75c3:
	ld hl, $c3b7 ; $75c3
	ld a, e ; $75c6
	ld [hl+], a ; $75c7
	ld [hl], d ; $75c8
	sla e ; $75c9
	rl d ; $75cb
	ld a, d ; $75cd
	ld [$c3bb], a ; $75ce
	pop af ; $75d1
	ldh [$ff96], a ; $75d2
	ldh [rWBK], a ; $75d4
	pop hl ; $75d6
	pop de ; $75d7
	pop bc ; $75d8
	pop af ; $75d9
	ret ; $75da
Func_05_75db:
	push af ; $75db
	push bc ; $75dc
	push de ; $75dd
	push hl ; $75de
	ld hl, $c3b9 ; $75df
	ld b, [hl] ; $75e2
	inc hl ; $75e3
	ld c, [hl] ; $75e4
	ld e, $00 ; $75e5
	ld d, c ; $75e7
	sra d ; $75e8
	rr e ; $75ea
	ld a, c ; $75ec
	add a, b ; $75ed
	ld [$c3ba], a ; $75ee
	ld hl, $c3b7 ; $75f1
	ld a, e ; $75f4
	ld [hl+], a ; $75f5
	ld [hl], d ; $75f6
	sla e ; $75f7
	rl d ; $75f9
	ld a, d ; $75fb
	ld [$c3bb], a ; $75fc
	ld [$c3bc], a ; $75ff
	pop hl ; $7602
	pop de ; $7603
	pop bc ; $7604
	pop af ; $7605
	ret ; $7606
Func_05_7607:
	push af ; $7607
	push bc ; $7608
	push de ; $7609
	push hl ; $760a
	ld a, [$d821] ; $760b
	ld b, a ; $760e
	ld a, [$d820] ; $760f
	cp a, b ; $7612
	jr nz, Label_05_762c ; $7613
	ld b, a ; $7615
	ld a, [$d824] ; $7616
	cp a, b ; $7619
	jr z, Label_05_7621 ; $761a
	pop hl ; $761c
	pop de ; $761d
	pop bc ; $761e
	pop af ; $761f
	ret ; $7620
Label_05_7621:
	ld a, [wMessageSpeed] ; $7621
	bit 7, a ; $7624
	jr nz, Label_05_762c ; $7626
	and a, $7f ; $7628
	jr nz, Label_05_7631 ; $762a
Label_05_762c:
	pop hl ; $762c
	pop de ; $762d
	pop bc ; $762e
	pop af ; $762f
	ret ; $7630
Label_05_7631:
	ldh a, [$ff96] ; $7631
	push af ; $7633
	ld a, $07 ; $7634
	ldh [$ff96], a ; $7636
	ldh [rWBK], a ; $7638
	ld a, [$c8a7] ; $763a
	or a, a ; $763d
	jr z, Label_05_7644 ; $763e
	ld b, $5f ; $7640
	jr Label_05_7646 ; $7642
Label_05_7644:
	ld b, $7f ; $7644
Label_05_7646:
	ld a, [$c3bb] ; $7646
	cp a, b ; $7649
	jr nc, Label_05_7677 ; $764a
	ld hl, $c3b7 ; $764c
	ld a, [hl+] ; $764f
	ld h, [hl] ; $7650
	ld l, a ; $7651
	rl l ; $7652
	ld l, h ; $7654
	rl l ; $7655
	ld h, $00 ; $7657
	rl h ; $7659
	ld a, h ; $765b
	or a, l ; $765c
	jr z, Label_05_7660 ; $765d
	dec hl ; $765f
Label_05_7660:
	add hl, hl ; $7660
	add hl, hl ; $7661
	add hl, hl ; $7662
	add hl, hl ; $7663
	ld d, h ; $7664
	ld e, l ; $7665
	ld bc, $d300 ; $7666
	add hl, bc ; $7669
	push hl ; $766a
	ld hl, $8800 ; $766b
	add hl, de ; $766e
	ld d, h ; $766f
	ld e, l ; $7670
	pop hl ; $7671
	ld c, $02 ; $7672
	call Func_00_0480 ; $7674
Label_05_7677:
	pop af ; $7677
	ldh [$ff96], a ; $7678
	ldh [rWBK], a ; $767a
	pop hl ; $767c
	pop de ; $767d
	pop bc ; $767e
	pop af ; $767f
	ret ; $7680
Func_05_7681:
	push af ; $7681
	push bc ; $7682
	push de ; $7683
	push hl ; $7684
	ldh a, [$ff96] ; $7685
	push af ; $7687
	push hl ; $7688
	ld hl, $c3b9 ; $7689
	ld b, [hl] ; $768c
	inc hl ; $768d
	ld c, [hl] ; $768e
	ld hl, $c3b7 ; $768f
	ld a, [hl+] ; $7692
	ld d, [hl] ; $7693
	ld e, a ; $7694
	pop hl ; $7695
	ld a, [hl+] ; $7696
	cp a, $02 ; $7697
	jr z, Label_05_76c1 ; $7699
	cp a, $03 ; $769b
	jr z, Label_05_76c1 ; $769d
	cp a, $01 ; $769f
	jr z, Label_05_76a5 ; $76a1
	jr Label_05_76b6 ; $76a3
Label_05_76a5:
	ld e, $00 ; $76a5
	ld d, c ; $76a7
	sra d ; $76a8
	rr e ; $76aa
	ld a, c ; $76ac
	add a, b ; $76ad
	ld [$c3ba], a ; $76ae
	ld [$c3bb], a ; $76b1
	jr Label_05_76c1 ; $76b4
Label_05_76b6:
	push af ; $76b6
	ld a, $07 ; $76b7
	ldh [$ff96], a ; $76b9
	ldh [rWBK], a ; $76bb
	pop af ; $76bd
	call Func_05_7322 ; $76be
Label_05_76c1:
	ld hl, $c3b7 ; $76c1
	ld a, e ; $76c4
	ld [hl+], a ; $76c5
	ld [hl], d ; $76c6
	pop af ; $76c7
	ldh [$ff96], a ; $76c8
	ldh [rWBK], a ; $76ca
	pop hl ; $76cc
	pop de ; $76cd
	pop bc ; $76ce
	pop af ; $76cf
	ret ; $76d0
	INCBIN "data/bank_005/d_76d1.bin" ; $76d1, 74 bytes
Func_05_771b:
	push af ; $771b
	push bc ; $771c
	push de ; $771d
	push hl ; $771e
	ldh a, [$ff96] ; $771f
	push af ; $7721
	ld a, $05 ; $7722
	ldh [$ff96], a ; $7724
	ldh [rWBK], a ; $7726
	xor a, a ; $7728
	ld hl, $c3b7 ; $7729
	ld [hl+], a ; $772c
	ld [hl+], a ; $772d
	ld [hl+], a ; $772e
	inc hl ; $772f
	inc hl ; $7730
	inc hl ; $7731
	ld [hl+], a ; $7732
	ld [hl+], a ; $7733
	ld [hl], a ; $7734
	ld [$cb75], a ; $7735
	ld a, [$c3ba] ; $7738
	ld d, a ; $773b
	ld e, c ; $773c
	ld a, [$d82f] ; $773d
	ld b, a ; $7740
	ld a, [$d820] ; $7741
	cp a, b ; $7744
	jr nz, Label_05_774f ; $7745
	rst Rst30 ; $7747
	and a, b ; $7748
	rra ; $7749
	jr nz, Label_05_774f ; $774a
	inc d ; $774c
	ld e, c ; $774d
	inc c ; $774e
Label_05_774f:
	ld b, e ; $774f
	ld e, $00 ; $7750
	ld hl, $c3bb ; $7752
	ld [hl], d ; $7755
	inc hl ; $7756
	ld [hl], d ; $7757
	sra d ; $7758
	rr e ; $775a
	ld hl, $c3b7 ; $775c
	ld [hl], e ; $775f
	inc hl ; $7760
	ld [hl], d ; $7761
	ld hl, $c3b9 ; $7762
	ld [hl], b ; $7765
	inc hl ; $7766
	ld a, [hl] ; $7767
	add a, c ; $7768
	ld [hl], a ; $7769
	pop af ; $776a
	ldh [$ff96], a ; $776b
	ldh [rWBK], a ; $776d
	pop hl ; $776f
	pop de ; $7770
	pop bc ; $7771
	pop af ; $7772
	ret ; $7773
Func_05_7774:
	push af ; $7774
	push bc ; $7775
	push hl ; $7776
	ld a, [$d820] ; $7777
	ld b, a ; $777a
	ld a, [$d82f] ; $777b
	cp a, b ; $777e
	jr z, Label_05_778e ; $777f
	ld hl, $c3bb ; $7781
	ld a, [hl+] ; $7784
	ld b, [hl] ; $7785
	ld c, a ; $7786
	sub a, b ; $7787
	inc hl ; $7788
	ld [hl+], a ; $7789
	ld [hl], b ; $778a
	dec hl ; $778b
	dec hl ; $778c
	ld [hl], c ; $778d
Label_05_778e:
	pop hl ; $778e
	pop bc ; $778f
	pop af ; $7790
	ret ; $7791
Func_05_7792:
	push af ; $7792
	ldh a, [rLCDC] ; $7793
	bit 7, a ; $7795
	jr z, Label_05_779e ; $7797
	call Func_05_77dd ; $7799
	jr Label_05_77a1 ; $779c
Label_05_779e:
	call Func_05_7866 ; $779e
Label_05_77a1:
	pop af ; $77a1
	ret ; $77a2
Func_05_77a3:
	push af ; $77a3
	push bc ; $77a4
	ld a, [$d821] ; $77a5
	ld b, a ; $77a8
	ld a, [$d824] ; $77a9
	cp a, b ; $77ac
	jr nz, Label_05_77ba ; $77ad
	ld a, [wMessageSpeed] ; $77af
	bit 7, a ; $77b2
	jr nz, Label_05_77ba ; $77b4
	and a, $7f ; $77b6
	jr nz, Label_05_77c8 ; $77b8
Label_05_77ba:
	ldh a, [rLCDC] ; $77ba
	bit 7, a ; $77bc
	jr z, Label_05_77c5 ; $77be
	call Func_05_77dd ; $77c0
	jr Label_05_77c8 ; $77c3
Label_05_77c5:
	call Func_05_7866 ; $77c5
Label_05_77c8:
	ld hl, $c3b9 ; $77c8
	ld b, [hl] ; $77cb
	inc hl ; $77cc
	ld c, [hl] ; $77cd
	ld a, [$c3bb] ; $77ce
	ld [$c3bc], a ; $77d1
	ld a, c ; $77d4
	add a, b ; $77d5
	ld [hl], a ; $77d6
	ld [$c3bb], a ; $77d7
	pop bc ; $77da
	pop af ; $77db
	ret ; $77dc
Func_05_77dd:
	push af ; $77dd
	push bc ; $77de
	push de ; $77df
	push hl ; $77e0
	ldh a, [$ff96] ; $77e1
	push af ; $77e3
	rst Rst20 ; $77e4
	nop ; $77e5
	inc bc ; $77e6
	ld a, $07 ; $77e7
	ldh [$ff96], a ; $77e9
	ldh [rWBK], a ; $77eb
	ld a, [$c8a7] ; $77ed
	or a, a ; $77f0
	jr z, Label_05_77f7 ; $77f1
	ld b, $60 ; $77f3
	jr Label_05_77f9 ; $77f5
Label_05_77f7:
	ld b, $80 ; $77f7
Label_05_77f9:
	ld a, [$c3bb] ; $77f9
	inc a ; $77fc
	cp a, b ; $77fd
	jr c, Label_05_7801 ; $77fe
	ld a, b ; $7800
Label_05_7801:
	ld b, $00 ; $7801
Label_05_7803:
	inc b ; $7803
	sub a, $12 ; $7804
	jr c, Label_05_780a ; $7806
	jr Label_05_7803 ; $7808
Label_05_780a:
	push bc ; $780a
	ld hl, $0000 ; $780b
	ld b, h ; $780e
	ld c, l ; $780f
	ld de, $8800 ; $7810
	add hl, de ; $7813
	ldh a, [$ff96] ; $7814
	push af ; $7816
	ld a, $05 ; $7817
	ldh [$ff96], a ; $7819
	ldh [rWBK], a ; $781b
	ld a, [$c3b6] ; $781d
	bit 3, a ; $7820
	jr z, Label_05_7828 ; $7822
	ld de, $2000 ; $7824
	add hl, de ; $7827
Label_05_7828:
	pop af ; $7828
	ldh [$ff96], a ; $7829
	ldh [rWBK], a ; $782b
	push hl ; $782d
	ld h, b ; $782e
	ld l, c ; $782f
	ld de, $d300 ; $7830
	add hl, de ; $7833
	pop de ; $7834
	pop bc ; $7835
	ld c, $12 ; $7836
Label_05_7838:
	push bc ; $7838
	push hl ; $7839
	push de ; $783a
	call Func_00_0480 ; $783b
	ld bc, $0120 ; $783e
	pop hl ; $7841
	add hl, bc ; $7842
	ld d, h ; $7843
	ld e, l ; $7844
	pop hl ; $7845
	add hl, bc ; $7846
	pop bc ; $7847
	ld a, [$c33f] ; $7848
	or a, a ; $784b
	jr nz, Label_05_7853 ; $784c
	call Func_00_2631 ; $784e
	jr Label_05_7856 ; $7851
Label_05_7853:
	farcall FarPtr_08_3e ; $7853
Label_05_7856:
	dec b ; $7856
	jr nz, Label_05_7838 ; $7857
	rst Rst28 ; $7859
	nop ; $785a
	inc bc ; $785b
	pop af ; $785c
	ldh [$ff96], a ; $785d
	ldh [rWBK], a ; $785f
	pop hl ; $7861
	pop de ; $7862
	pop bc ; $7863
	pop af ; $7864
	ret ; $7865
Func_05_7866:
	push af ; $7866
	push bc ; $7867
	push de ; $7868
	push hl ; $7869
	ldh a, [$ff96] ; $786a
	push af ; $786c
	ld a, [$c3bb] ; $786d
	inc a ; $7870
	ld b, a ; $7871
	ld a, $07 ; $7872
	ldh [$ff96], a ; $7874
	ldh [rWBK], a ; $7876
	ld a, b ; $7878
	ld b, $00 ; $7879
Label_05_787b:
	inc b ; $787b
	sub a, $20 ; $787c
	jr z, Label_05_7884 ; $787e
	jr c, Label_05_7884 ; $7880
	jr Label_05_787b ; $7882
Label_05_7884:
	ld hl, $d300 ; $7884
	ld de, $8800 ; $7887
	ld c, $20 ; $788a
Label_05_788c:
	push bc ; $788c
	push hl ; $788d
	push de ; $788e
	ld a, $00 ; $788f
	ldh [rVBK], a ; $7891
	call Func_00_18eb ; $7893
	ld bc, $0200 ; $7896
	pop hl ; $7899
	add hl, bc ; $789a
	ld d, h ; $789b
	ld e, l ; $789c
	pop hl ; $789d
	add hl, bc ; $789e
	pop bc ; $789f
	dec b ; $78a0
	jr nz, Label_05_788c ; $78a1
	pop af ; $78a3
	ldh [$ff96], a ; $78a4
	ldh [rWBK], a ; $78a6
	pop hl ; $78a8
	pop de ; $78a9
	pop bc ; $78aa
	pop af ; $78ab
	ret ; $78ac
	INCBIN "data/bank_005/d_78ad.bin" ; $78ad, 1875 bytes
