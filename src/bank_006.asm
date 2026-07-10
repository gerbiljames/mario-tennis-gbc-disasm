INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $06", ROMX[$4000], BANK[$06]

	INCBIN "data/bank_006/d_4000.bin" ; $4000, 14 bytes
	ldh a, [$ff96] ; $400e
	push af ; $4010
	rst Rst18 ; $4011
	ld a, $08 ; $4012
	call Func_06_4915 ; $4014
	rst Rst18 ; $4017
	ld a, $08 ; $4018
	call Func_06_5c8a ; $401a
	ld hl, $5280 ; $401d
	ld de, $8640 ; $4020
	ld c, $04 ; $4023
	call Func_00_0480 ; $4025
	rst Rst18 ; $4028
	ld a, $08 ; $4029
	ld a, $02 ; $402b
	ldh [$ff96], a ; $402d
	ldh [rWBK], a ; $402f
	ld b, $00 ; $4031
	call Func_06_49a7 ; $4033
	ld a, $0a ; $4036
	ld hl, $506a ; $4038
	call Func_00_1b6a ; $403b
	ld a, $0a ; $403e
	ld hl, $69c8 ; $4040
	call Func_00_1b6a ; $4043
Label_06_4046:
	xor a, a ; $4046
	ld [$c4e0], a ; $4047
	ld a, $0e ; $404a
	ld [$c4e6], a ; $404c
	call Func_06_4485 ; $404f
	ld a, [$c4e0] ; $4052
	cp a, $ff ; $4055
	jr z, Label_06_4046 ; $4057
	ld hl, $506a ; $4059
	call Func_00_1bcb ; $405c
	ld hl, $69c8 ; $405f
	call Func_00_1bcb ; $4062
	call Func_06_45aa ; $4065
	call Func_06_45f8 ; $4068
	rst Rst18 ; $406b
	ld a, $08 ; $406c
	pop af ; $406e
	ldh [$ff96], a ; $406f
	ldh [rWBK], a ; $4071
	ret ; $4073
	ldh a, [$ff96] ; $4074
	push af ; $4076
	ldh a, [$ffdd] ; $4077
	push af ; $4079
	rst Rst18 ; $407a
	ld a, $08 ; $407b
	rst Rst18 ; $407d
	ld a, $08 ; $407e
	rst Rst08 ; $4080
	ld h, e ; $4081
	xor a, a ; $4082
	ld [$c4e0], a ; $4083
	ld a, $02 ; $4086
	ldh [$ffdd], a ; $4088
	call Func_06_4915 ; $408a
	rst Rst18 ; $408d
	ld a, $08 ; $408e
	call Func_06_5c8a ; $4090
	ld hl, $5280 ; $4093
	ld de, $8640 ; $4096
	ld c, $04 ; $4099
	call Func_00_0480 ; $409b
	rst Rst18 ; $409e
	ld a, $08 ; $409f
	ld a, $02 ; $40a1
	ldh [$ff96], a ; $40a3
	ldh [rWBK], a ; $40a5
Label_06_40a7:
	ld b, $00 ; $40a7
	call Func_06_49a7 ; $40a9
	ld a, $0a ; $40ac
	ld hl, $506a ; $40ae
	call Func_00_1b6a ; $40b1
	ld a, $0a ; $40b4
	ld hl, $69c8 ; $40b6
	call Func_00_1b6a ; $40b9
	ld b, $00 ; $40bc
	ld a, [$c4c8] ; $40be
	and a, a ; $40c1
	jr z, Label_06_40c6 ; $40c2
	ld b, $01 ; $40c4
Label_06_40c6:
	ld a, b ; $40c6
	ld [$c4e6], a ; $40c7
	call Func_06_46e7 ; $40ca
	ld a, [$c4e0] ; $40cd
	cp a, $ff ; $40d0
	jr z, Label_06_40ef ; $40d2
	push af ; $40d4
	ld hl, $40e5 ; $40d5
	push hl ; $40d8
	ld a, [$c4e0] ; $40d9
	rst Rst00 ; $40dc
	INCBIN "data/bank_006/d_40dd.bin" ; $40dd, 8 bytes
	pop af ; $40e5
	ld [$c4e0], a ; $40e6
	ld a, [$c4c3] ; $40e9
	and a, a ; $40ec
	jr z, Label_06_40a7 ; $40ed
Label_06_40ef:
	ld hl, $506a ; $40ef
	call Func_00_1bcb ; $40f2
	ld hl, $69c8 ; $40f5
	call Func_00_1bcb ; $40f8
	call Func_06_45aa ; $40fb
	call Func_06_45f8 ; $40fe
	rst Rst18 ; $4101
	ld a, $08 ; $4102
	rst Rst18 ; $4104
	ld a, $08 ; $4105
	pop af ; $4107
	ldh [$ffdd], a ; $4108
	pop af ; $410a
	ldh [$ff96], a ; $410b
	ldh [rWBK], a ; $410d
	ret ; $410f
	INCBIN "data/bank_006/d_4110.bin" ; $4110, 624 bytes
	ld hl, $506a ; $4380
	call Func_00_1bcb ; $4383
	call Func_06_45aa ; $4386
	ld de, $0002 ; $4389
	ld bc, $130e ; $438c
	call Func_06_4564 ; $438f
	rst Rst18 ; $4392
	adc a, h ; $4393
	dec b ; $4394
	ld de, $0103 ; $4395
	ld hl, $0157 ; $4398
	call Func_06_4574 ; $439b
	ld de, $060a ; $439e
	ld hl, $0158 ; $43a1
	call Func_06_4574 ; $43a4
	ld de, $010c ; $43a7
	ld hl, $0159 ; $43aa
	call Func_06_4574 ; $43ad
	rst Rst18 ; $43b0
	sub a, b ; $43b1
	dec b ; $43b2
	call Func_06_45f8 ; $43b3
	rst Rst18 ; $43b6
	ld a, $08 ; $43b7
Label_06_43b9:
	rst Rst18 ; $43b9
	ld a, [hl-] ; $43ba
	INCBIN "data/bank_006/d_43bb.bin" ; $43bb, 1 bytes
	and a, $03 ; $43bc
	jr nz, Label_06_43e8 ; $43be
	rst Rst18 ; $43c0
	ld a, [hl-] ; $43c1
	INCBIN "data/bank_006/d_43c2.bin" ; $43c2, 1 bytes
	and a, $40 ; $43c3
	jr z, Label_06_43e3 ; $43c5
	ldh a, [$ff9e] ; $43c7
	and a, a ; $43c9
	jr z, Label_06_43e3 ; $43ca
	ldh a, [$ff96] ; $43cc
	push af ; $43ce
	ld a, $04 ; $43cf
	ldh [$ff96], a ; $43d1
	ldh [rWBK], a ; $43d3
	ld hl, $df1e ; $43d5
	ld a, [hl] ; $43d8
	xor a, $01 ; $43d9
	ld [hl], a ; $43db
	pop af ; $43dc
	ldh [$ff96], a ; $43dd
	ldh [rWBK], a ; $43df
	jr Label_06_43e8 ; $43e1
Label_06_43e3:
	rst Rst18 ; $43e3
	ld a, $08 ; $43e4
	jr Label_06_43b9 ; $43e6
Label_06_43e8:
	call Func_06_45aa ; $43e8
	rst Rst08 ; $43eb
	ld h, d ; $43ec
	ret ; $43ed
	call Func_06_45c1 ; $43ee
	ld a, [$c4c8] ; $43f1
	and a, a ; $43f4
	jr nz, Label_06_443a ; $43f5
	xor a, a ; $43f7
	ld [$c4e0], a ; $43f8
Label_06_43fb:
	ld a, $02 ; $43fb
	ld [$c4e6], a ; $43fd
	call Func_06_46e7 ; $4400
	ld a, [$c4e0] ; $4403
	cp a, $ff ; $4406
	jr z, Label_06_441d ; $4408
	push af ; $440a
	ld hl, $4417 ; $440b
	push hl ; $440e
	ld a, [$c4e0] ; $440f
	rst Rst00 ; $4412
	ld e, $44 ; $4413
	ld a, [hl-] ; $4415
	ld b, h ; $4416
	pop af ; $4417
	ld [$c4e0], a ; $4418
	jr Label_06_43fb ; $441b
Label_06_441d:
	ret ; $441d
	ld a, [$c4dd] ; $441e
	ld [$c4e0], a ; $4421
	ld a, $03 ; $4424
	ld [$c4e6], a ; $4426
	call Func_06_46e7 ; $4429
	ld a, [$c4e0] ; $442c
	cp a, $ff ; $442f
	jr z, Label_06_4439 ; $4431
	ld [$c4dd], a ; $4433
	rst Rst18 ; $4436
	inc a ; $4437
	ld [bc], a ; $4438
Label_06_4439:
	ret ; $4439
Label_06_443a:
	ldh a, [hMusic] ; $443a
	and a, $01 ; $443c
	ld [$c4e0], a ; $443e
	ld a, $04 ; $4441
	ld [$c4e6], a ; $4443
	call Func_06_46e7 ; $4446
	ld a, [$c4e0] ; $4449
	cp a, $ff ; $444c
	jr z, Label_06_4461 ; $444e
	call Func_00_2f86 ; $4450
	ld a, [wGameMode] ; $4453
	cp a, $09 ; $4456
	jr z, Label_06_4461 ; $4458
	ldh a, [hMusic] ; $445a
	and a, $01 ; $445c
	rst Rst18 ; $445e
	ld b, b ; $445f
	ld [bc], a ; $4460
Label_06_4461:
	ret ; $4461
	call Func_06_45c1 ; $4462
	ld a, [wGameMode] ; $4465
	add a, $f3 ; $4468
	ld l, a ; $446a
	adc a, $44 ; $446b
	sub a, l ; $446d
	ld h, a ; $446e
	ld a, [hl] ; $446f
	ld [$c4e6], a ; $4470
	ld a, [$c7bb] ; $4473
	and a, a ; $4476
	jr z, Label_06_447e ; $4477
	ld a, $08 ; $4479
	ld [$c4e6], a ; $447b
Label_06_447e:
	call Func_06_4820 ; $447e
	dec a ; $4481
	ld [$c4e0], a ; $4482
Func_06_4485:
	call Func_06_46e7 ; $4485
	ld a, [$c4e0] ; $4488
	cp a, $ff ; $448b
	ret z ; $448d
	call Func_06_480a ; $448e
	sub a, $0a ; $4491
	ld a, a ; $4493
	rst Rst00 ; $4494
	or a, c ; $4495
	ld b, h ; $4496
	or a, d ; $4497
	ld b, h ; $4498
	push hl ; $4499
	ld b, h ; $449a
	call nc, $c344 ; $449b
	ld b, h ; $449e
	jp $c344 ; $449f
	INCBIN "data/bank_006/d_44a2.bin" ; $44a2, 33 bytes
	ld a, $01 ; $44c3
	ld [$c4de], a ; $44c5
	ld [$c4c7], a ; $44c8
	ld a, $ff ; $44cb
	ld [$c4c3], a ; $44cd
	ld [$c492], a ; $44d0
	ret ; $44d3
	INCBIN "data/bank_006/d_44d4.bin" ; $44d4, 17 bytes
	ld a, $01 ; $44e5
	ld [$c4c7], a ; $44e7
	ld a, $ff ; $44ea
	ld [$c4c3], a ; $44ec
	ld [$c492], a ; $44ef
	ret ; $44f2
	INCBIN "data/bank_006/d_44f3.bin" ; $44f3, 11 bytes
	push af ; $44fe
	push bc ; $44ff
	push de ; $4500
	push hl ; $4501
	ldh a, [$ff96] ; $4502
	push af ; $4504
	ld a, $02 ; $4505
	ldh [$ff96], a ; $4507
	ldh [rWBK], a ; $4509
	ld a, $01 ; $450b
	ld [$c4c0], a ; $450d
	rst Rst18 ; $4510
	ld a, $08 ; $4511
	push bc ; $4513
	push de ; $4514
	push hl ; $4515
	push bc ; $4516
	push de ; $4517
	call Func_06_462e ; $4518
	ld c, e ; $451b
	ld b, d ; $451c
	pop de ; $451d
	call Func_06_4624 ; $451e
	pop hl ; $4521
	call Func_00_2b5c ; $4522
	pop hl ; $4525
	pop de ; $4526
	pop bc ; $4527
	rst Rst18 ; $4528
	adc a, h ; $4529
	dec b ; $452a
	push hl ; $452b
	inc d ; $452c
	inc e ; $452d
	call Func_06_4624 ; $452e
	ld c, b ; $4531
	dec c ; $4532
	dec c ; $4533
	pop hl ; $4534
	rst Rst18 ; $4535
	inc e ; $4536
	dec b ; $4537
	rst Rst18 ; $4538
	sub a, b ; $4539
	dec b ; $453a
	call Func_06_45f8 ; $453b
	ld a, $1e ; $453e
	rst Rst18 ; $4540
	ld b, b ; $4541
	INCBIN "data/bank_006/d_4542.bin" ; $4542, 1 bytes
Label_06_4543:
	rst Rst18 ; $4543
	ld a, $08 ; $4544
	rst Rst18 ; $4546
	ld a, [hl-] ; $4547
	INCBIN "data/bank_006/d_4548.bin" ; $4548, 1 bytes
	and a, $0f ; $4549
	jr z, Label_06_4543 ; $454b
	call Func_06_45aa ; $454d
	call Func_06_45f8 ; $4550
	rst Rst18 ; $4553
	ld a, $08 ; $4554
	xor a, a ; $4556
	ld [$c4c0], a ; $4557
	pop af ; $455a
	ldh [$ff96], a ; $455b
	ldh [rWBK], a ; $455d
	pop hl ; $455f
	pop de ; $4560
	pop bc ; $4561
	pop af ; $4562
	ret ; $4563
Func_06_4564:
	push bc ; $4564
	push de ; $4565
	call Func_06_462e ; $4566
	ld c, e ; $4569
	ld b, d ; $456a
	pop de ; $456b
	call Func_06_4624 ; $456c
	pop hl ; $456f
	call Func_00_2b63 ; $4570
	ret ; $4573
Func_06_4574:
	push de ; $4574
	push hl ; $4575
	push hl ; $4576
	call Func_06_4624 ; $4577
	pop hl ; $457a
	call Func_00_2a9e ; $457b
	pop hl ; $457e
	pop de ; $457f
	inc hl ; $4580
	inc e ; $4581
	inc e ; $4582
	ret ; $4583
Func_06_4584:
	push hl ; $4584
	push de ; $4585
	call Func_06_462e ; $4586
	ld c, e ; $4589
	ld b, d ; $458a
	pop de ; $458b
	push de ; $458c
	call Func_06_4624 ; $458d
	ld hl, $1303 ; $4590
	ld a, $01 ; $4593
	ld [$c3b2], a ; $4595
	call Func_00_2b68 ; $4598
	pop de ; $459b
	ld hl, $0101 ; $459c
	add hl, de ; $459f
	ld e, l ; $45a0
	ld d, h ; $45a1
	call Func_06_4624 ; $45a2
	pop hl ; $45a5
	call Func_00_2a9e ; $45a6
	ret ; $45a9
Func_06_45aa:
	ld hl, $d800 ; $45aa
	ld de, $d000 ; $45ad
	ld c, $40 ; $45b0
	call CopyMemoryFast ; $45b2
	ld hl, $dc00 ; $45b5
	ld de, $d400 ; $45b8
	ld c, $40 ; $45bb
	call CopyMemoryFast ; $45bd
	ret ; $45c0
Func_06_45c1:
	ld e, $0a ; $45c1
	call Func_06_464b ; $45c3
	ld c, l ; $45c6
	ld b, h ; $45c7
	push bc ; $45c8
	ld hl, $d000 ; $45c9
	add hl, bc ; $45cc
	ld e, l ; $45cd
	ld d, h ; $45ce
	ld hl, $d800 ; $45cf
	add hl, bc ; $45d2
	ld c, $0e ; $45d3
	call CopyMemoryFast ; $45d5
	pop bc ; $45d8
	ld hl, $d400 ; $45d9
	add hl, bc ; $45dc
	ld e, l ; $45dd
	ld d, h ; $45de
	ld hl, $dc00 ; $45df
	add hl, bc ; $45e2
	ld c, $0e ; $45e3
	call CopyMemoryFast ; $45e5
	ret ; $45e8
Func_06_45e9:
	ld a, [hl] ; $45e9
	and a, $7f ; $45ea
	ld [hl+], a ; $45ec
	dec bc ; $45ed
	ld a, b ; $45ee
	or a, c ; $45ef
	jr nz, Func_06_45e9 ; $45f0
	ret ; $45f2
	INCBIN "data/bank_006/d_45f3.bin" ; $45f3, 5 bytes
Func_06_45f8:
	xor a, a ; $45f8
	ld [$c4e2], a ; $45f9
	ld e, $00 ; $45fc
	call Func_06_464b ; $45fe
	ld c, l ; $4601
	ld b, h ; $4602
	push bc ; $4603
	ld hl, $9800 ; $4604
	add hl, bc ; $4607
	ld e, l ; $4608
	ld d, h ; $4609
	ld hl, $d000 ; $460a
	add hl, bc ; $460d
	ld c, $22 ; $460e
	call Func_00_0480 ; $4610
	pop bc ; $4613
	ld hl, $b800 ; $4614
	add hl, bc ; $4617
	ld e, l ; $4618
	ld d, h ; $4619
	ld hl, $d400 ; $461a
	add hl, bc ; $461d
	ld c, $22 ; $461e
	call Func_00_0480 ; $4620
	ret ; $4623
Func_06_4624:
	call Func_06_4638 ; $4624
	ld de, $d000 ; $4627
	add hl, de ; $462a
	ld e, l ; $462b
	ld d, h ; $462c
	ret ; $462d
Func_06_462e:
	call Func_06_4638 ; $462e
	ld de, $d400 ; $4631
	add hl, de ; $4634
	ld e, l ; $4635
	ld d, h ; $4636
	ret ; $4637
Func_06_4638:
	call Func_06_464b ; $4638
	ldh a, [$ff8b] ; $463b
	add a, $07 ; $463d
	rrca ; $463f
	rrca ; $4640
	rrca ; $4641
	add a, d ; $4642
	and a, $1f ; $4643
	add a, l ; $4645
	ld l, a ; $4646
	jr nc, Label_06_464a ; $4647
	inc h ; $4649
Label_06_464a:
	ret ; $464a
Func_06_464b:
	ldh a, [$ff8a] ; $464b
	add a, $07 ; $464d
	rrca ; $464f
	rrca ; $4650
	rrca ; $4651
	add a, e ; $4652
	and a, $1f ; $4653
	ld l, a ; $4655
	ld h, $00 ; $4656
	add hl, hl ; $4658
	add hl, hl ; $4659
	add hl, hl ; $465a
	add hl, hl ; $465b
	add hl, hl ; $465c
	ret ; $465d
Func_06_465e:
	ldh a, [$ff8b] ; $465e
	cpl ; $4660
	inc a ; $4661
	and a, $07 ; $4662
	add a, d ; $4664
	ld d, a ; $4665
	ldh a, [$ff8a] ; $4666
	cpl ; $4668
	inc a ; $4669
	and a, $07 ; $466a
	add a, e ; $466c
	ld e, a ; $466d
	ret ; $466e
	INCBIN "data/bank_006/d_466f.bin" ; $466f, 120 bytes
Func_06_46e7:
	call Func_06_4820 ; $46e7
	ld [$c4e7], a ; $46ea
	call Func_06_482f ; $46ed
	ld e, $0c ; $46f0
	call Func_06_464b ; $46f2
	ld de, $d400 ; $46f5
	add hl, de ; $46f8
	ld bc, $0040 ; $46f9
	call Func_06_45e9 ; $46fc
	jr Label_06_4733 ; $46ff
Label_06_4701:
	rst Rst18 ; $4701
	ld a, [hl-] ; $4702
	INCBIN "data/bank_006/d_4703.bin" ; $4703, 1 bytes
	and a, $0a ; $4704
	jr z, Label_06_4711 ; $4706
	rst Rst08 ; $4708
	ld h, d ; $4709
	ld a, $ff ; $470a
	ld [$c4e0], a ; $470c
	jr Label_06_4776 ; $470f
Label_06_4711:
	rst Rst18 ; $4711
	ld a, [hl-] ; $4712
	INCBIN "data/bank_006/d_4713.bin" ; $4713, 1 bytes
	and a, $01 ; $4714
	jr z, Label_06_471c ; $4716
	rst Rst08 ; $4718
	ld e, a ; $4719
	jr Label_06_4776 ; $471a
Label_06_471c:
	rst Rst18 ; $471c
	inc a ; $471d
	INCBIN "data/bank_006/d_471e.bin" ; $471e, 1 bytes
	and a, $30 ; $471f
	jr z, Label_06_476e ; $4721
	ld b, a ; $4723
	ld a, [$c4e7] ; $4724
	ld c, a ; $4727
	ld a, [$c4e0] ; $4728
	call Func_00_2c0d ; $472b
	ld [$c4e0], a ; $472e
	rst Rst08 ; $4731
	ld e, [hl] ; $4732
Label_06_4733:
	rst Rst18 ; $4733
	adc a, h ; $4734
	dec b ; $4735
	ld hl, $c3b7 ; $4736
	ld de, $2000 ; $4739
	ld a, e ; $473c
	ld [hl+], a ; $473d
	ld [hl], d ; $473e
	ld a, $40 ; $473f
	ld hl, $c3ba ; $4741
	ld [hl+], a ; $4744
	ld [hl+], a ; $4745
	ld [hl+], a ; $4746
	ld a, [$c4e0] ; $4747
	call Func_06_480a ; $474a
	push af ; $474d
	call Func_06_5219 ; $474e
	pop af ; $4751
	add a, $3f ; $4752
	ld l, a ; $4754
	adc a, $01 ; $4755
	sub a, l ; $4757
	ld h, a ; $4758
	ld de, $000e ; $4759
	call Func_06_4584 ; $475c
	call Func_06_477a ; $475f
	rst Rst18 ; $4762
	sub a, b ; $4763
	dec b ; $4764
	rst Rst18 ; $4765
	ld a, $08 ; $4766
	call Func_06_45f8 ; $4768
	rst Rst18 ; $476b
	ld a, $08 ; $476c
Label_06_476e:
	call Func_06_4873 ; $476e
	rst Rst18 ; $4771
	ld a, $08 ; $4772
	jr Label_06_4701 ; $4774
Label_06_4776:
	rst Rst18 ; $4776
	ld a, $08 ; $4777
	ret ; $4779
Func_06_477a:
	ld a, [$c494] ; $477a
	rst Rst00 ; $477d
	adc a, [hl] ; $477e
	ld b, a ; $477f
	adc a, [hl] ; $4780
	ld b, a ; $4781
	adc a, [hl] ; $4782
	ld b, a ; $4783
	and a, c ; $4784
	ld b, a ; $4785
	and a, c ; $4786
	ld b, a ; $4787
	and a, c ; $4788
	ld b, a ; $4789
	or a, h ; $478a
	ld b, a ; $478b
	rst Rst18 ; $478c
	ld b, a ; $478d
	ld hl, $c4e3 ; $478e
	ld a, [hl+] ; $4791
	ld b, [hl] ; $4792
	ld c, a ; $4793
	ld hl, $0701 ; $4794
	add hl, bc ; $4797
	ld e, l ; $4798
	ld d, h ; $4799
	ld hl, $015a ; $479a
	call Func_06_4574 ; $479d
	ret ; $47a0
	ld hl, $c4e3 ; $47a1
	ld a, [hl+] ; $47a4
	ld b, [hl] ; $47a5
	ld c, a ; $47a6
	ld hl, $0e01 ; $47a7
	add hl, bc ; $47aa
	ld e, l ; $47ab
	ld d, h ; $47ac
	ld hl, $015b ; $47ad
	call Func_06_4574 ; $47b0
	ret ; $47b3
	ld hl, $c4e3 ; $47b4
	ld a, [hl+] ; $47b7
	ld b, [hl] ; $47b8
	ld c, a ; $47b9
	ld hl, $0502 ; $47ba
	add hl, bc ; $47bd
	ld e, l ; $47be
	ld d, h ; $47bf
	ld hl, $015c ; $47c0
	call Func_06_4574 ; $47c3
	ld hl, $0304 ; $47c6
	add hl, bc ; $47c9
	ld e, l ; $47ca
	ld d, h ; $47cb
	ld hl, $015d ; $47cc
	call Func_06_4574 ; $47cf
	ld hl, $0505 ; $47d2
	add hl, bc ; $47d5
	ld e, l ; $47d6
	ld d, h ; $47d7
	ld hl, $015c ; $47d8
	call Func_06_4574 ; $47db
	ret ; $47de
	INCBIN "data/bank_006/d_47df.bin" ; $47df, 43 bytes
Func_06_480a:
	ld b, a ; $480a
	ld a, [$c4e6] ; $480b
	add a, a ; $480e
	add a, a ; $480f
	add a, a ; $4810
	add a, $6f ; $4811
	ld l, a ; $4813
	adc a, $46 ; $4814
	sub a, l ; $4816
	ld h, a ; $4817
	ld a, b ; $4818
	add a, l ; $4819
	ld l, a ; $481a
	jr nc, Label_06_481e ; $481b
	inc h ; $481d
Label_06_481e:
	ld a, [hl] ; $481e
	ret ; $481f
Func_06_4820:
	ld a, [$c4e6] ; $4820
	add a, a ; $4823
	add a, a ; $4824
	add a, a ; $4825
	add a, $73 ; $4826
	ld l, a ; $4828
	adc a, $46 ; $4829
	sub a, l ; $482b
	ld h, a ; $482c
	ld a, [hl] ; $482d
	ret ; $482e
Func_06_482f:
	ld a, [$c4e7] ; $482f
	add a, a ; $4832
	add a, $57 ; $4833
	ld l, a ; $4835
	adc a, $48 ; $4836
	sub a, l ; $4838
	ld h, a ; $4839
	ld a, [hl+] ; $483a
	ld h, [hl] ; $483b
	ld l, a ; $483c
	ld a, [$c4e7] ; $483d
	ld c, a ; $4840
	ld b, $00 ; $4841
Label_06_4843:
	ld a, [hl+] ; $4843
	ld e, a ; $4844
	ld a, [hl+] ; $4845
	ld d, a ; $4846
	push bc ; $4847
	push hl ; $4848
	ld a, b ; $4849
	call Func_06_480a ; $484a
	call Func_06_6802 ; $484d
	pop hl ; $4850
	pop bc ; $4851
	inc b ; $4852
	dec c ; $4853
	jr nz, Label_06_4843 ; $4854
	ret ; $4856
	INCBIN "data/bank_006/d_4857.bin" ; $4857, 28 bytes
Func_06_4873:
	ld a, [$c4e7] ; $4873
	add a, a ; $4876
	add a, $91 ; $4877
	ld l, a ; $4879
	adc a, $48 ; $487a
	sub a, l ; $487c
	ld h, a ; $487d
	ld a, [hl+] ; $487e
	ld h, [hl] ; $487f
	ld l, a ; $4880
	ld a, [$c4e0] ; $4881
	add a, a ; $4884
	add a, l ; $4885
	ld l, a ; $4886
	jr nc, Label_06_488a ; $4887
	inc h ; $4889
Label_06_488a:
	ld a, [hl+] ; $488a
	ld d, [hl] ; $488b
	ld e, a ; $488c
	call Func_06_69b7 ; $488d
	ret ; $4890
	INCBIN "data/bank_006/d_4891.bin" ; $4891, 28 bytes
	ldh a, [$ff96] ; $48ad
	push af ; $48af
	rst Rst18 ; $48b0
	ld a, $08 ; $48b1
	call Func_06_4915 ; $48b3
	rst Rst18 ; $48b6
	ld a, $08 ; $48b7
	ld a, $05 ; $48b9
	ld [$c4e3], a ; $48bb
	call Func_06_5c8a ; $48be
	ld b, $01 ; $48c1
	call Func_06_49a7 ; $48c3
	rst Rst18 ; $48c6
	adc a, h ; $48c7
	dec b ; $48c8
	call Func_06_477a ; $48c9
	rst Rst18 ; $48cc
	sub a, b ; $48cd
	dec b ; $48ce
	ld a, $0a ; $48cf
	ld hl, $506a ; $48d1
	call Func_00_1b6a ; $48d4
	ld a, $0a ; $48d7
	ld hl, $69c8 ; $48d9
	call Func_00_1b6a ; $48dc
	rst Rst18 ; $48df
	ld a, $08 ; $48e0
	call Func_06_45f8 ; $48e2
	rst Rst18 ; $48e5
	ld a, $08 ; $48e6
	ld a, $02 ; $48e8
	ldh [$ff96], a ; $48ea
	ldh [rWBK], a ; $48ec
Label_06_48ee:
	rst Rst18 ; $48ee
	ld a, [hl-] ; $48ef
	INCBIN "data/bank_006/d_48f0.bin" ; $48f0, 1 bytes
	and a, $0f ; $48f1
	jr nz, Label_06_48fa ; $48f3
	rst Rst18 ; $48f5
	ld a, $08 ; $48f6
	jr Label_06_48ee ; $48f8
Label_06_48fa:
	ld hl, $506a ; $48fa
	call Func_00_1bcb ; $48fd
	ld hl, $69c8 ; $4900
	call Func_00_1bcb ; $4903
	call Func_06_45aa ; $4906
	call Func_06_45f8 ; $4909
	rst Rst18 ; $490c
	ld a, $08 ; $490d
	pop af ; $490f
	ldh [$ff96], a ; $4910
	ldh [rWBK], a ; $4912
	ret ; $4914
Func_06_4915:
	ld a, $00 ; $4915
	ld [$c4e4], a ; $4917
	ld a, $02 ; $491a
	ld [$c4e3], a ; $491c
	ld a, [$c494] ; $491f
	cp a, $06 ; $4922
	jr nz, Label_06_492b ; $4924
	ld a, $02 ; $4926
	ld [$c4e4], a ; $4928
Label_06_492b:
	ld a, [$c494] ; $492b
	cp a, $07 ; $492e
	jr nz, Label_06_4937 ; $4930
	ld a, $02 ; $4932
	ld [$c4e4], a ; $4934
Label_06_4937:
	ld a, [$c4cf] ; $4937
	rst Rst00 ; $493a
	ld e, [hl] ; $493b
	ld c, c ; $493c
	ld d, l ; $493d
	ld c, c ; $493e
	ld c, h ; $493f
	ld c, c ; $4940
	ld b, e ; $4941
	ld c, c ; $4942
	ld a, $06 ; $4943
	ldh [$ff96], a ; $4945
	ldh [rWBK], a ; $4947
	rst Rst18 ; $4949
	ld e, $08 ; $494a
	ld a, $07 ; $494c
	ldh [$ff96], a ; $494e
	ldh [rWBK], a ; $4950
	rst Rst18 ; $4952
	ld e, $08 ; $4953
	ld a, $05 ; $4955
	ldh [$ff96], a ; $4957
	ldh [rWBK], a ; $4959
	rst Rst18 ; $495b
	ld e, $08 ; $495c
	ld a, $04 ; $495e
	ldh [$ff96], a ; $4960
	ldh [rWBK], a ; $4962
	rst Rst18 ; $4964
	ld e, $08 ; $4965
	rst Rst18 ; $4967
	ld a, $08 ; $4968
	ld a, [$c8f5] ; $496a
	cp a, $02 ; $496d
	jr z, Label_06_49a0 ; $496f
	ld a, [wPlayer1GamesWon] ; $4971
	ld b, $01 ; $4974
	ld de, $8700 ; $4976
	rst Rst18 ; $4979
	jr z, Label_06_4985 ; $497a
	ld a, [wPlayer1SetsWon] ; $497c
	ld b, $01 ; $497f
	ld de, $8680 ; $4981
	rst Rst18 ; $4984
Label_06_4985:
	jr z, Label_06_4990 ; $4985
	ld a, [wPlayer2GamesWon] ; $4987
	ld b, $01 ; $498a
	ld de, $8740 ; $498c
	rst Rst18 ; $498f
Label_06_4990:
	jr z, Label_06_499b ; $4990
	ld a, [wPlayer2SetsWon] ; $4992
	ld b, $01 ; $4995
	ld de, $86c0 ; $4997
	rst Rst18 ; $499a
Label_06_499b:
	jr z, Label_06_49a6 ; $499b
	rst Rst18 ; $499d
	ld a, $08 ; $499e
Label_06_49a0:
	ld a, $02 ; $49a0
	ldh [$ff96], a ; $49a2
	ldh [rWBK], a ; $49a4
Label_06_49a6:
	ret ; $49a6
Func_06_49a7:
	push bc ; $49a7
	ld hl, $c4e3 ; $49a8
	ld a, [hl+] ; $49ab
	ld d, [hl] ; $49ac
	ld e, a ; $49ad
	ld a, [$c494] ; $49ae
	add a, a ; $49b1
	add a, $35 ; $49b2
	ld l, a ; $49b4
	adc a, $50 ; $49b5
	sub a, l ; $49b7
	ld h, a ; $49b8
	ld a, [hl+] ; $49b9
	ld h, [hl] ; $49ba
	ld l, a ; $49bb
	call Func_06_5045 ; $49bc
	pop bc ; $49bf
	ld a, [$c494] ; $49c0
	rst Rst00 ; $49c3
	xor a, [hl] ; $49c4
	inc bc ; $49c5
	xor a, [hl] ; $49c6
	inc bc ; $49c7
	xor a, [hl] ; $49c8
	inc bc ; $49c9
	INCBIN "data/bank_006/d_49ca.bin" ; $49ca, 26 bytes
	ld de, $0502 ; $49e4
	ld c, $04 ; $49e7
	call Func_06_4a53 ; $49e9
	ld a, [$c2fc] ; $49ec
	ld c, a ; $49ef
	call Func_06_4a13 ; $49f0
	ret ; $49f3
	INCBIN "data/bank_006/d_49f4.bin" ; $49f4, 31 bytes
Func_06_4a13:
	ld hl, $c4e3 ; $4a13
	ld a, [hl+] ; $4a16
	ld h, [hl] ; $4a17
	ld l, a ; $4a18
	add hl, de ; $4a19
	ld e, l ; $4a1a
	ld d, h ; $4a1b
Label_06_4a1c:
	push bc ; $4a1c
	push de ; $4a1d
	ld hl, $4a2f ; $4a1e
	push hl ; $4a21
	ld a, c ; $4a22
	and a, $03 ; $4a23
	ld a, a ; $4a25
	rst Rst00 ; $4a26
	xor a, [hl] ; $4a27
	inc bc ; $4a28
	ld l, [hl] ; $4a29
	ld c, d ; $4a2a
	ld [hl], l ; $4a2b
	ld c, d ; $4a2c
	ld [hl], l ; $4a2d
	ld c, d ; $4a2e
	pop de ; $4a2f
	pop bc ; $4a30
	inc d ; $4a31
	inc d ; $4a32
	srl c ; $4a33
	srl c ; $4a35
	jr nz, Label_06_4a1c ; $4a37
	ret ; $4a39
	INCBIN "data/bank_006/d_4a3a.bin" ; $4a3a, 25 bytes
Func_06_4a53:
	inc b ; $4a53
	dec b ; $4a54
	ret z ; $4a55
	push de ; $4a56
	ld hl, $c4e3 ; $4a57
	ld a, [hl+] ; $4a5a
	ld h, [hl] ; $4a5b
	ld l, a ; $4a5c
	add hl, de ; $4a5d
	ld e, l ; $4a5e
	ld d, h ; $4a5f
Label_06_4a60:
	push bc ; $4a60
	push de ; $4a61
	call Func_06_4a7c ; $4a62
	pop de ; $4a65
	pop bc ; $4a66
	inc d ; $4a67
	inc d ; $4a68
	dec c ; $4a69
	jr nz, Label_06_4a60 ; $4a6a
	pop de ; $4a6c
	ret ; $4a6d
	ld hl, $4a9b ; $4a6e
	call Func_06_5045 ; $4a71
	ret ; $4a74
	ld hl, $4aa1 ; $4a75
	call Func_06_5045 ; $4a78
	ret ; $4a7b
Func_06_4a7c:
	ld hl, $4aa7 ; $4a7c
	call Func_06_5045 ; $4a7f
	ret ; $4a82
	INCBIN "data/bank_006/d_4a83.bin" ; $4a83, 1474 bytes
Func_06_5045:
	push de ; $5045
	push hl ; $5046
	push hl ; $5047
	call Func_06_4624 ; $5048
	pop hl ; $504b
	ld a, [hl+] ; $504c
	ld c, a ; $504d
	ld a, [hl+] ; $504e
	ld b, a ; $504f
	ld a, [hl+] ; $5050
	ld h, [hl] ; $5051
	ld l, a ; $5052
	call Func_00_2b46 ; $5053
	pop hl ; $5056
	pop de ; $5057
	push hl ; $5058
	call Func_06_462e ; $5059
	pop hl ; $505c
	ld a, [hl+] ; $505d
	ld c, a ; $505e
	ld a, [hl+] ; $505f
	ld b, a ; $5060
	inc hl ; $5061
	inc hl ; $5062
	ld a, [hl+] ; $5063
	ld h, [hl] ; $5064
	ld l, a ; $5065
	call Func_00_2b46 ; $5066
	ret ; $5069
	ld a, [$c4e4] ; $506a
	ld h, a ; $506d
	ld a, [$c4e3] ; $506e
	ld l, a ; $5071
	add hl, hl ; $5072
	add hl, hl ; $5073
	add hl, hl ; $5074
	ld e, l ; $5075
	ld d, h ; $5076
	push de ; $5077
	call Func_06_465e ; $5078
	ld a, [$c494] ; $507b
	add a, a ; $507e
	add a, $9c ; $507f
	ld l, a ; $5081
	adc a, $50 ; $5082
	sub a, l ; $5084
	ld h, a ; $5085
	ld a, [hl+] ; $5086
	ld h, [hl] ; $5087
	ld l, a ; $5088
	ld bc, $0000 ; $5089
	call Func_00_1e9d ; $508c
	pop de ; $508f
	ld a, [$c494] ; $5090
	cp a, $06 ; $5093
	jr z, Label_06_50ac ; $5095
	cp a, $07 ; $5097
	jr z, Label_06_50ac ; $5099
	ret ; $509b
	INCBIN "data/bank_006/d_509c.bin" ; $509c, 16 bytes
Label_06_50ac:
	ld hl, $4c0c ; $50ac
	add hl, de ; $50af
	ld e, l ; $50b0
	ld d, h ; $50b1
	push de ; $50b2
	call Func_06_465e ; $50b3
	ld hl, $c47c ; $50b6
	ld a, [hl+] ; $50b9
	ld h, [hl] ; $50ba
	ld l, a ; $50bb
	ld b, $01 ; $50bc
	ld a, $04 ; $50be
	rst Rst18 ; $50c0
	sbc a, h ; $50c1
	ld a, [bc] ; $50c2
	pop de ; $50c3
	ld a, e ; $50c4
	add a, $18 ; $50c5
	ld e, a ; $50c7
	call Func_06_465e ; $50c8
	ld a, [$c7bc] ; $50cb
	and a, a ; $50ce
	ld hl, $c4ec ; $50cf
	jr nz, Label_06_50d7 ; $50d2
	ld hl, $c47e ; $50d4
Label_06_50d7:
	ld a, [hl+] ; $50d7
	ld h, [hl] ; $50d8
	ld l, a ; $50d9
	ld b, $02 ; $50da
	ld a, $04 ; $50dc
	rst Rst18 ; $50de
	sbc a, h ; $50df
	ld a, [bc] ; $50e0
	ret ; $50e1
	INCBIN "data/bank_006/d_50e2.bin" ; $50e2, 311 bytes
Func_06_5219:
	add a, a ; $5219
	add a, $44 ; $521a
	ld l, a ; $521c
	adc a, $52 ; $521d
	sub a, l ; $521f
	ld h, a ; $5220
	ld a, [hl+] ; $5221
	ld h, [hl] ; $5222
	ld l, a ; $5223
	ld de, $d000 ; $5224
	ldh a, [$ff96] ; $5227
	push af ; $5229
	ld a, $01 ; $522a
	ldh [$ff96], a ; $522c
	ldh [rWBK], a ; $522e
	call DecompressData ; $5230
	ld hl, $d000 ; $5233
	ld de, $8400 ; $5236
	ld c, $10 ; $5239
	call Func_00_0480 ; $523b
	pop af ; $523e
	ldh [$ff96], a ; $523f
	ldh [rWBK], a ; $5241
	ret ; $5243
	INCBIN "data/bank_006/d_5244.bin" ; $5244, 2630 bytes
Func_06_5c8a:
	ld a, [wGameMode] ; $5c8a
	cp a, $05 ; $5c8d
	jr z, Label_06_5c9b ; $5c8f
	add a, a ; $5c91
	add a, $c9 ; $5c92
	ld l, a ; $5c94
	adc a, $5c ; $5c95
	sub a, l ; $5c97
	ld h, a ; $5c98
	jr Label_06_5ca6 ; $5c99
Label_06_5c9b:
	ld a, [$c8f7] ; $5c9b
	add a, a ; $5c9e
	add a, $df ; $5c9f
	ld l, a ; $5ca1
	adc a, $5c ; $5ca2
	sub a, l ; $5ca4
	ld h, a ; $5ca5
Label_06_5ca6:
	ldh a, [$ff96] ; $5ca6
	push af ; $5ca8
	ld a, $01 ; $5ca9
	ldh [$ff96], a ; $5cab
	ldh [rWBK], a ; $5cad
	ld a, [hl+] ; $5caf
	ld h, [hl] ; $5cb0
	ld l, a ; $5cb1
	ld de, $d000 ; $5cb2
	call DecompressData ; $5cb5
	ld hl, $d000 ; $5cb8
	ld de, $8500 ; $5cbb
	ld c, $14 ; $5cbe
	call Func_00_0480 ; $5cc0
	pop af ; $5cc3
	ldh [$ff96], a ; $5cc4
	ldh [rWBK], a ; $5cc6
	ret ; $5cc8
	INCBIN "data/bank_006/d_5cc9.bin" ; $5cc9, 2873 bytes
Func_06_6802:
	push af ; $6802
	push de ; $6803
	add a, a ; $6804
	add a, a ; $6805
	add a, $35 ; $6806
	ld l, a ; $6808
	adc a, $68 ; $6809
	sub a, l ; $680b
	ld h, a ; $680c
	ld a, [hl+] ; $680d
	ld h, [hl] ; $680e
	ld l, a ; $680f
	push hl ; $6810
	call Func_06_4624 ; $6811
	pop hl ; $6814
	ld bc, $0302 ; $6815
	call Func_00_2b46 ; $6818
	pop de ; $681b
	pop af ; $681c
	add a, a ; $681d
	add a, a ; $681e
	add a, $37 ; $681f
	ld l, a ; $6821
	adc a, $68 ; $6822
	sub a, l ; $6824
	ld h, a ; $6825
	ld a, [hl+] ; $6826
	ld h, [hl] ; $6827
	ld l, a ; $6828
	push hl ; $6829
	call Func_06_462e ; $682a
	pop hl ; $682d
	ld bc, $0302 ; $682e
	call Func_00_2b46 ; $6831
	ret ; $6834
	INCBIN "data/bank_006/d_6835.bin" ; $6835, 386 bytes
Func_06_69b7:
	ld a, d ; $69b7
	add a, $fc ; $69b8
	ld d, a ; $69ba
	call Func_06_465e ; $69bb
	ld hl, $69e7 ; $69be
	ld bc, $0000 ; $69c1
	call Func_00_1e9d ; $69c4
	ret ; $69c7
	ld h, $05 ; $69c8
	ld a, [$c4e3] ; $69ca
	ld l, a ; $69cd
	add hl, hl ; $69ce
	add hl, hl ; $69cf
	add hl, hl ; $69d0
	ld de, $fcf0 ; $69d1
	add hl, de ; $69d4
	ld e, l ; $69d5
	ld d, h ; $69d6
	rst Rst18 ; $69d7
	ld d, $18 ; $69d8
	call Func_06_465e ; $69da
	ld hl, $6a10 ; $69dd
	ld bc, $0000 ; $69e0
	call Func_00_1e9d ; $69e3
	ret ; $69e6
	INCBIN "data/bank_006/d_69e7.bin" ; $69e7, 809 bytes
Func_06_6d10:
	call Func_06_6d8a ; $6d10
	ld [$c4e7], a ; $6d13
	call Func_06_6d99 ; $6d16
	jr Label_06_6d4d ; $6d19
Label_06_6d1b:
	rst Rst18 ; $6d1b
	ld a, [hl-] ; $6d1c
	INCBIN "data/bank_006/d_6d1d.bin" ; $6d1d, 1 bytes
	and a, $0a ; $6d1e
	jr z, Label_06_6d2b ; $6d20
	rst Rst08 ; $6d22
	ld h, d ; $6d23
	ld a, $ff ; $6d24
	ld [$c4e0], a ; $6d26
	jr Label_06_6d70 ; $6d29
Label_06_6d2b:
	rst Rst18 ; $6d2b
	ld a, [hl-] ; $6d2c
	INCBIN "data/bank_006/d_6d2d.bin" ; $6d2d, 1 bytes
	and a, $01 ; $6d2e
	jr z, Label_06_6d36 ; $6d30
	rst Rst08 ; $6d32
	ld e, a ; $6d33
	jr Label_06_6d70 ; $6d34
Label_06_6d36:
	rst Rst18 ; $6d36
	inc a ; $6d37
	INCBIN "data/bank_006/d_6d38.bin" ; $6d38, 1 bytes
	and a, $30 ; $6d39
	jr z, Label_06_6d68 ; $6d3b
	ld b, a ; $6d3d
	ld a, [$c4e7] ; $6d3e
	ld c, a ; $6d41
	ld a, [$c4e0] ; $6d42
	call Func_00_2c0d ; $6d45
	ld [$c4e0], a ; $6d48
	rst Rst08 ; $6d4b
	ld e, [hl] ; $6d4c
Label_06_6d4d:
	ld a, [$c4e0] ; $6d4d
	call Func_06_6d74 ; $6d50
	push af ; $6d53
	call Func_06_7283 ; $6d54
	pop af ; $6d57
	add a, $62 ; $6d58
	ld l, a ; $6d5a
	adc a, $01 ; $6d5b
	sub a, l ; $6d5d
	ld h, a ; $6d5e
	ld de, $000e ; $6d5f
	call Func_06_724f ; $6d62
	call Func_06_7237 ; $6d65
Label_06_6d68:
	call Func_06_6ddd ; $6d68
	call Func_00_2631 ; $6d6b
	jr Label_06_6d1b ; $6d6e
Label_06_6d70:
	call Func_00_2631 ; $6d70
	ret ; $6d73
Func_06_6d74:
	ld b, a ; $6d74
	ld a, [$c4e6] ; $6d75
	add a, a ; $6d78
	add a, a ; $6d79
	add a, a ; $6d7a
	add a, $e0 ; $6d7b
	ld l, a ; $6d7d
	adc a, $6c ; $6d7e
	sub a, l ; $6d80
	ld h, a ; $6d81
	ld a, b ; $6d82
	add a, l ; $6d83
	ld l, a ; $6d84
	jr nc, Label_06_6d88 ; $6d85
	inc h ; $6d87
Label_06_6d88:
	ld a, [hl] ; $6d88
	ret ; $6d89
Func_06_6d8a:
	ld a, [$c4e6] ; $6d8a
	add a, a ; $6d8d
	add a, a ; $6d8e
	add a, a ; $6d8f
	add a, $e4 ; $6d90
	ld l, a ; $6d92
	adc a, $6c ; $6d93
	sub a, l ; $6d95
	ld h, a ; $6d96
	ld a, [hl] ; $6d97
	ret ; $6d98
Func_06_6d99:
	ld a, [$c4e7] ; $6d99
	add a, a ; $6d9c
	add a, $c1 ; $6d9d
	ld l, a ; $6d9f
	adc a, $6d ; $6da0
	sub a, l ; $6da2
	ld h, a ; $6da3
	ld a, [hl+] ; $6da4
	ld h, [hl] ; $6da5
	ld l, a ; $6da6
	ld a, [$c4e7] ; $6da7
	ld c, a ; $6daa
	ld b, $00 ; $6dab
Label_06_6dad:
	ld a, [hl+] ; $6dad
	ld e, a ; $6dae
	ld a, [hl+] ; $6daf
	ld d, a ; $6db0
	push bc ; $6db1
	push hl ; $6db2
	ld a, b ; $6db3
	call Func_06_6d74 ; $6db4
	call Func_06_77a6 ; $6db7
	pop hl ; $6dba
	pop bc ; $6dbb
	inc b ; $6dbc
	dec c ; $6dbd
	jr nz, Label_06_6dad ; $6dbe
	ret ; $6dc0
	INCBIN "data/bank_006/d_6dc1.bin" ; $6dc1, 28 bytes
Func_06_6ddd:
	ld a, [$c4e7] ; $6ddd
	add a, a ; $6de0
	add a, $fb ; $6de1
	ld l, a ; $6de3
	adc a, $6d ; $6de4
	sub a, l ; $6de6
	ld h, a ; $6de7
	ld a, [hl+] ; $6de8
	ld h, [hl] ; $6de9
	ld l, a ; $6dea
	ld a, [$c4e0] ; $6deb
	add a, a ; $6dee
	add a, l ; $6def
	ld l, a ; $6df0
	jr nc, Label_06_6df4 ; $6df1
	inc h ; $6df3
Label_06_6df4:
	ld a, [hl+] ; $6df4
	ld d, [hl] ; $6df5
	ld e, a ; $6df6
	call Func_06_72ce ; $6df7
	ret ; $6dfa
	INCBIN "data/bank_006/d_6dfb.bin" ; $6dfb, 28 bytes
	ldh a, [$ff96] ; $6e17
	push af ; $6e19
	rst Rst18 ; $6e1a
	ld a, h ; $6e1b
	ld a, [bc] ; $6e1c
	ldh a, [$ffdd] ; $6e1d
	push af ; $6e1f
	call Func_00_2631 ; $6e20
	rst Rst08 ; $6e23
	ld h, e ; $6e24
	xor a, a ; $6e25
	ld [$c4e0], a ; $6e26
	ld a, $02 ; $6e29
	ldh [$ffdd], a ; $6e2b
	rst Rst18 ; $6e2d
	nop ; $6e2e
	dec b ; $6e2f
	ld a, $81 ; $6e30
	ld [$c3b6], a ; $6e32
	rst Rst20 ; $6e35
	add a, b ; $6e36
	ld [bc], a ; $6e37
	rst Rst18 ; $6e38
	ld a, [bc] ; $6e39
	INCBIN "data/bank_006/d_6e3a.bin" ; $6e3a, 1 bytes
	call Func_06_7245 ; $6e3b
	ld d, $00 ; $6e3e
	ld e, $0e ; $6e40
	ld b, $13 ; $6e42
	ld c, $03 ; $6e44
	rst Rst18 ; $6e46
	ld a, b ; $6e47
	dec b ; $6e48
	call Func_00_2631 ; $6e49
	ld a, $05 ; $6e4c
	ldh [$ff96], a ; $6e4e
	ldh [rWBK], a ; $6e50
Label_06_6e52:
	ld hl, $5280 ; $6e52
	ld de, $8640 ; $6e55
	ld c, $04 ; $6e58
	call Func_00_0480 ; $6e5a
	ld a, $00 ; $6e5d
	ld [$c4e6], a ; $6e5f
	call Func_06_6d10 ; $6e62
	ld a, [$c4e0] ; $6e65
	cp a, $ff ; $6e68
	jr z, Label_06_6e94 ; $6e6a
	push af ; $6e6c
	ld hl, $6e7d ; $6e6d
	push hl ; $6e70
	ld a, [$c4e0] ; $6e71
	rst Rst00 ; $6e74
	ld b, d ; $6e75
	ld l, a ; $6e76
	and a, b ; $6e77
	ld l, a ; $6e78
	cp a, h ; $6e79
	ld l, a ; $6e7a
	cpl ; $6e7b
	ld [hl], b ; $6e7c
	ld b, a ; $6e7d
	pop af ; $6e7e
	ld [$c4e0], a ; $6e7f
	cp a, $02 ; $6e82
	jr c, Label_06_6eb2 ; $6e84
	cp a, $03 ; $6e86
	jr nz, Label_06_6e8e ; $6e88
	ld a, b ; $6e8a
	or a, a ; $6e8b
	jr nz, Label_06_6eb2 ; $6e8c
Label_06_6e8e:
	ld a, [$c4c3] ; $6e8e
	and a, a ; $6e91
	jr z, Label_06_6e52 ; $6e92
Label_06_6e94:
	call Func_06_7241 ; $6e94
	call Func_06_7237 ; $6e97
	call Func_00_2631 ; $6e9a
	rst Rst28 ; $6e9d
	add a, b ; $6e9e
	ld [bc], a ; $6e9f
	rst Rst18 ; $6ea0
	inc d ; $6ea1
	INCBIN "data/bank_006/d_6ea2.bin" ; $6ea2, 1 bytes
	pop af ; $6ea3
	ldh [$ffdd], a ; $6ea4
	rst Rst18 ; $6ea6
	nop ; $6ea7
	dec b ; $6ea8
	rst Rst18 ; $6ea9
	ld a, d ; $6eaa
	ld a, [bc] ; $6eab
	pop af ; $6eac
	ldh [$ff96], a ; $6ead
	ldh [rWBK], a ; $6eaf
	ret ; $6eb1
Label_06_6eb2:
	ld a, b ; $6eb2
	cp a, $ff ; $6eb3
	jp z, Label_06_6e52 ; $6eb5
	pop af ; $6eb8
	ldh [$ffdd], a ; $6eb9
	rst Rst28 ; $6ebb
	add a, b ; $6ebc
	ld [bc], a ; $6ebd
	rst Rst18 ; $6ebe
	ld a, d ; $6ebf
	ld a, [bc] ; $6ec0
	pop af ; $6ec1
	ldh [$ff96], a ; $6ec2
	ldh [rWBK], a ; $6ec4
	ret ; $6ec6
	INCBIN "data/bank_006/d_6ec7.bin" ; $6ec7, 123 bytes
	call Func_06_7245 ; $6f42
	xor a, a ; $6f45
	ld [$c4e0], a ; $6f46
	ld a, $01 ; $6f49
	ld [$c4e6], a ; $6f4b
	call Func_06_6d10 ; $6f4e
	ld a, [$c4e0] ; $6f51
	cp a, $ff ; $6f54
	jr z, Label_06_6f60 ; $6f56
	ld a, [$c4e0] ; $6f58
	rst Rst00 ; $6f5b
	ld h, [hl] ; $6f5c
	ld l, a ; $6f5d
	add a, h ; $6f5e
	ld l, a ; $6f5f
Label_06_6f60:
	call Func_06_7245 ; $6f60
	ld a, $ff ; $6f63
	ret ; $6f65
	ld hl, $c2d0 ; $6f66
	ld de, $c296 ; $6f69
	ld bc, $0005 ; $6f6c
	call CopyMemoryBC ; $6f6f
	ld a, $ff ; $6f72
	ld [$c295], a ; $6f74
	ld [$c294], a ; $6f77
	ld [$c2a1], a ; $6f7a
	ld a, $01 ; $6f7d
	rst Rst18 ; $6f7f
	nop ; $6f80
	dec e ; $6f81
	xor a, a ; $6f82
	ret ; $6f83
	INCBIN "data/bank_006/d_6f84.bin" ; $6f84, 28 bytes
	ld hl, $c2d0 ; $6fa0
	ld de, $c296 ; $6fa3
	ld bc, $0005 ; $6fa6
	call CopyMemoryBC ; $6fa9
	ld a, $ff ; $6fac
	ld [$c295], a ; $6fae
	ld [$c294], a ; $6fb1
	ld [$c2a1], a ; $6fb4
	rst Rst18 ; $6fb7
	INCBIN "data/bank_006/d_6fb8.bin" ; $6fb8, 2 bytes
	xor a, a ; $6fba
	ret ; $6fbb
	call Func_06_7245 ; $6fbc
	ld a, [$c4c8] ; $6fbf
	and a, a ; $6fc2
	xor a, a ; $6fc3
	ld [$c4e0], a ; $6fc4
Label_06_6fc7:
	ld a, $02 ; $6fc7
	ld [$c4e6], a ; $6fc9
	call Func_06_6d10 ; $6fcc
	ld a, [$c4e0] ; $6fcf
	cp a, $ff ; $6fd2
	jr z, Label_06_6fe9 ; $6fd4
	push af ; $6fd6
	ld hl, $6fe3 ; $6fd7
	push hl ; $6fda
	ld a, [$c4e0] ; $6fdb
	rst Rst00 ; $6fde
	rst Rst30 ; $6fdf
	ld l, a ; $6fe0
	inc de ; $6fe1
	ld [hl], b ; $6fe2
	pop af ; $6fe3
	ld [$c4e0], a ; $6fe4
	jr Label_06_6fc7 ; $6fe7
Label_06_6fe9:
	ret ; $6fe9
	INCBIN "data/bank_006/d_6fea.bin" ; $6fea, 13 bytes
	ld a, [wMessageSpeed] ; $6ff7
	ld b, a ; $6ffa
	ld a, $02 ; $6ffb
	sub a, b ; $6ffd
	ld [$c4e0], a ; $6ffe
	call Func_06_70b4 ; $7001
	ld a, [$c4e0] ; $7004
	cp a, $ff ; $7007
	jr z, Label_06_7012 ; $7009
	ld b, a ; $700b
	ld a, $02 ; $700c
	sub a, b ; $700e
	ld [wMessageSpeed], a ; $700f
Label_06_7012:
	ret ; $7012
	ldh a, [hMusic] ; $7013
	and a, $01 ; $7015
	ld [$c4e0], a ; $7017
	call Func_06_70bc ; $701a
	ld a, [$c4e0] ; $701d
	cp a, $ff ; $7020
	jr z, Label_06_702e ; $7022
	call Func_00_2f86 ; $7024
	ldh a, [hMusic] ; $7027
	and a, $01 ; $7029
	rst Rst18 ; $702b
	ld b, b ; $702c
	ld [bc], a ; $702d
Label_06_702e:
	ret ; $702e
	INCBIN "data/bank_006/d_702f.bin" ; $702f, 133 bytes
Func_06_70b4:
	ld a, $06 ; $70b4
	ld [$c4e1], a ; $70b6
	jp Label_06_717a ; $70b9
Func_06_70bc:
	ld a, $09 ; $70bc
	ld [$c4e1], a ; $70be
	jp Label_06_70cc ; $70c1
	INCBIN "data/bank_006/d_70c4.bin" ; $70c4, 8 bytes
Label_06_70cc:
	ld a, [$c4e1] ; $70cc
	ld de, $050a ; $70cf
	call Func_06_77a6 ; $70d2
	ld a, [$c4e1] ; $70d5
	inc a ; $70d8
	ld de, $0b0a ; $70d9
	call Func_06_77a6 ; $70dc
	ld a, [$c4e1] ; $70df
	cp a, $0b ; $70e2
	jr z, Label_06_70f8 ; $70e4
	ld hl, $c4e0 ; $70e6
	add a, [hl] ; $70e9
	ld hl, $0162 ; $70ea
	add a, l ; $70ed
	ld l, a ; $70ee
	jr nc, Label_06_70f2 ; $70ef
	inc h ; $70f1
Label_06_70f2:
	ld de, $000e ; $70f2
	call Func_06_724f ; $70f5
Label_06_70f8:
	call Func_06_7237 ; $70f8
	ld a, [$c4e0] ; $70fb
	ld hl, $c4e1 ; $70fe
	add a, [hl] ; $7101
	call Func_06_7283 ; $7102
Label_06_7105:
	rst Rst18 ; $7105
	ld a, [hl-] ; $7106
	INCBIN "data/bank_006/d_7107.bin" ; $7107, 1 bytes
	and a, $02 ; $7108
	jr z, Label_06_7115 ; $710a
	rst Rst08 ; $710c
	ld h, d ; $710d
	ld a, $ff ; $710e
	ld [$c4e0], a ; $7110
	jr Label_06_7172 ; $7113
Label_06_7115:
	rst Rst18 ; $7115
	ld a, [hl-] ; $7116
	INCBIN "data/bank_006/d_7117.bin" ; $7117, 1 bytes
	and a, $01 ; $7118
	jr z, Label_06_7120 ; $711a
	rst Rst08 ; $711c
	ld e, a ; $711d
	jr Label_06_7172 ; $711e
Label_06_7120:
	rst Rst18 ; $7120
	inc a ; $7121
	INCBIN "data/bank_006/d_7122.bin" ; $7122, 1 bytes
	and a, $30 ; $7123
	jr z, Label_06_715b ; $7125
	ld b, a ; $7127
	ld c, $02 ; $7128
	ld a, [$c4e0] ; $712a
	call Func_00_2c0d ; $712d
	ld [$c4e0], a ; $7130
	rst Rst08 ; $7133
	ld e, [hl] ; $7134
	ld a, [$c4e1] ; $7135
	cp a, $0b ; $7138
	jr z, Label_06_7151 ; $713a
	ld hl, $c4e0 ; $713c
	add a, [hl] ; $713f
	ld hl, $0162 ; $7140
	add a, l ; $7143
	ld l, a ; $7144
	jr nc, Label_06_7148 ; $7145
	inc h ; $7147
Label_06_7148:
	ld de, $000e ; $7148
	call Func_06_724f ; $714b
	call Func_06_7237 ; $714e
Label_06_7151:
	ld a, [$c4e0] ; $7151
	ld hl, $c4e1 ; $7154
	add a, [hl] ; $7157
	call Func_06_7283 ; $7158
Label_06_715b:
	ld a, [$c4e0] ; $715b
	add a, a ; $715e
	add a, $76 ; $715f
	ld l, a ; $7161
	adc a, $71 ; $7162
	sub a, l ; $7164
	ld h, a ; $7165
	ld a, [hl+] ; $7166
	ld d, [hl] ; $7167
	ld e, a ; $7168
	call Func_06_72ce ; $7169
	call Func_00_2631 ; $716c
	jp Label_06_7105 ; $716f
Label_06_7172:
	call Func_00_2631 ; $7172
	ret ; $7175
	INCBIN "data/bank_006/d_7176.bin" ; $7176, 4 bytes
Label_06_717a:
	call Func_06_7245 ; $717a
	ld a, [$c4e1] ; $717d
	ld de, $030a ; $7180
	call Func_06_77a6 ; $7183
	ld a, [$c4e1] ; $7186
	inc a ; $7189
	ld de, $080a ; $718a
	call Func_06_77a6 ; $718d
	ld a, [$c4e1] ; $7190
	inc a ; $7193
	inc a ; $7194
	ld de, $0d0a ; $7195
	call Func_06_77a6 ; $7198
	ld a, [$c4e1] ; $719b
	cp a, $06 ; $719e
	ld hl, $c4e0 ; $71a0
	add a, [hl] ; $71a3
	ld hl, $0162 ; $71a4
	add a, l ; $71a7
	ld l, a ; $71a8
	jr nc, Label_06_71ac ; $71a9
	inc h ; $71ab
Label_06_71ac:
	ld de, $000e ; $71ac
	call Func_06_724f ; $71af
	call Func_06_7237 ; $71b2
	ld a, [$c4e0] ; $71b5
	ld hl, $c4e1 ; $71b8
	add a, [hl] ; $71bb
	call Func_06_7283 ; $71bc
Label_06_71bf:
	rst Rst18 ; $71bf
	ld a, [hl-] ; $71c0
	INCBIN "data/bank_006/d_71c1.bin" ; $71c1, 1 bytes
	and a, $02 ; $71c2
	jr z, Label_06_71cf ; $71c4
	rst Rst08 ; $71c6
	ld h, d ; $71c7
	ld a, $ff ; $71c8
	ld [$c4e0], a ; $71ca
	jr Label_06_722a ; $71cd
Label_06_71cf:
	rst Rst18 ; $71cf
	ld a, [hl-] ; $71d0
	INCBIN "data/bank_006/d_71d1.bin" ; $71d1, 1 bytes
	and a, $01 ; $71d2
	jr z, Label_06_71da ; $71d4
	rst Rst08 ; $71d6
	ld e, a ; $71d7
	jr Label_06_722a ; $71d8
Label_06_71da:
	rst Rst18 ; $71da
	inc a ; $71db
	INCBIN "data/bank_006/d_71dc.bin" ; $71dc, 1 bytes
	and a, $30 ; $71dd
	jr z, Label_06_7213 ; $71df
	ld b, a ; $71e1
	ld c, $03 ; $71e2
	ld a, [$c4e0] ; $71e4
	call Func_00_2c0d ; $71e7
	ld [$c4e0], a ; $71ea
	rst Rst08 ; $71ed
	ld e, [hl] ; $71ee
	ld a, [$c4e1] ; $71ef
	cp a, $06 ; $71f2
	ld hl, $c4e0 ; $71f4
	add a, [hl] ; $71f7
	ld hl, $0162 ; $71f8
	add a, l ; $71fb
	ld l, a ; $71fc
	jr nc, Label_06_7200 ; $71fd
	inc h ; $71ff
Label_06_7200:
	ld de, $000e ; $7200
	call Func_06_724f ; $7203
	call Func_06_7237 ; $7206
	ld a, [$c4e0] ; $7209
	ld hl, $c4e1 ; $720c
	add a, [hl] ; $720f
	call Func_06_7283 ; $7210
Label_06_7213:
	ld a, [$c4e0] ; $7213
	add a, a ; $7216
	add a, $31 ; $7217
	ld l, a ; $7219
	adc a, $72 ; $721a
	sub a, l ; $721c
	ld h, a ; $721d
	ld a, [hl+] ; $721e
	ld d, [hl] ; $721f
	ld e, a ; $7220
	call Func_06_72ce ; $7221
	call Func_00_2631 ; $7224
	jp Label_06_71bf ; $7227
Label_06_722a:
	call Func_06_7245 ; $722a
	call Func_00_2631 ; $722d
	ret ; $7230
	INCBIN "data/bank_006/d_7231.bin" ; $7231, 6 bytes
Func_06_7237:
	ld a, $05 ; $7237
	ldh [$ff96], a ; $7239
	ldh [rWBK], a ; $723b
	rst Rst18 ; $723d
	add a, h ; $723e
	dec b ; $723f
	ret ; $7240
Func_06_7241:
	rst Rst18 ; $7241
	jr $7249 ; $7242
	ret ; $7244
Func_06_7245:
	rst Rst18 ; $7245
	jr Label_06_724d ; $7246
	call Func_06_726a ; $7248
	rst Rst18 ; $724b
	add a, h ; $724c
Label_06_724d:
	dec b ; $724d
	ret ; $724e
Func_06_724f:
	push hl ; $724f
	rst Rst18 ; $7250
	adc a, h ; $7251
	dec b ; $7252
	xor a, a ; $7253
	rst Rst18 ; $7254
	ld a, h ; $7255
	dec b ; $7256
	ld hl, $0101 ; $7257
	add hl, de ; $725a
	ld e, l ; $725b
	ld d, h ; $725c
	call Func_06_4624 ; $725d
	pop hl ; $7260
	ld c, $11 ; $7261
	rst Rst18 ; $7263
	inc e ; $7264
	dec b ; $7265
	rst Rst18 ; $7266
	sub a, b ; $7267
	dec b ; $7268
	ret ; $7269
Func_06_726a:
	ld a, $05 ; $726a
	ldh [$ff96], a ; $726c
	ldh [rWBK], a ; $726e
	ld hl, $c3b4 ; $7270
	ld a, [hl+] ; $7273
	ld h, [hl] ; $7274
	ld l, a ; $7275
	ld bc, $0400 ; $7276
	add hl, bc ; $7279
Label_06_727a:
	res 7, [hl] ; $727a
	inc hl ; $727c
	dec bc ; $727d
	ld a, b ; $727e
	or a, c ; $727f
	jr nz, Label_06_727a ; $7280
	ret ; $7282
Func_06_7283:
	add a, a ; $7283
	add a, $ae ; $7284
	ld l, a ; $7286
	adc a, $72 ; $7287
	sub a, l ; $7289
	ld h, a ; $728a
	ld a, [hl+] ; $728b
	ld h, [hl] ; $728c
	ld l, a ; $728d
	ld de, $d000 ; $728e
	ldh a, [$ff96] ; $7291
	push af ; $7293
	ld a, $01 ; $7294
	ldh [$ff96], a ; $7296
	ldh [rWBK], a ; $7298
	call DecompressData ; $729a
	ld hl, $d000 ; $729d
	ld de, $8700 ; $72a0
	ld c, $10 ; $72a3
	call Func_00_0480 ; $72a5
	pop af ; $72a8
	ldh [$ff96], a ; $72a9
	ldh [rWBK], a ; $72ab
	ret ; $72ad
	INCBIN "data/bank_006/d_72ae.bin" ; $72ae, 32 bytes
Func_06_72ce:
	ld a, d ; $72ce
	add a, $fc ; $72cf
	ld d, a ; $72d1
	call Func_06_465e ; $72d2
	ld hl, $72df ; $72d5
	ld bc, $0000 ; $72d8
	call Func_00_1e9d ; $72db
	ret ; $72de
	INCBIN "data/bank_006/d_72df.bin" ; $72df, 1223 bytes
Func_06_77a6:
	push de ; $77a6
	add a, a ; $77a7
	add a, $cb ; $77a8
	ld l, a ; $77aa
	adc a, $77 ; $77ab
	sub a, l ; $77ad
	ld h, a ; $77ae
	ld a, [hl+] ; $77af
	ld h, [hl] ; $77b0
	ld l, a ; $77b1
	push hl ; $77b2
	call Func_06_4624 ; $77b3
	pop hl ; $77b6
	ld bc, $0302 ; $77b7
	call Func_06_7882 ; $77ba
	pop de ; $77bd
	call Func_06_462e ; $77be
	ld hl, $6955 ; $77c1
	ld bc, $0302 ; $77c4
	call Func_06_78ab ; $77c7
	ret ; $77ca
	INCBIN "data/bank_006/d_77cb.bin" ; $77cb, 183 bytes
Func_06_7882:
	push bc ; $7882
	push de ; $7883
Label_06_7884:
	ld a, [hl+] ; $7884
	and a, a ; $7885
	ld [de], a ; $7886
	inc de ; $7887
	push hl ; $7888
	ld a, e ; $7889
	and a, $1f ; $788a
	jr nz, Label_06_7896 ; $788c
	ld h, d ; $788e
	ld l, e ; $788f
	ld de, $ffe0 ; $7890
	add hl, de ; $7893
	ld d, h ; $7894
	ld e, l ; $7895
Label_06_7896:
	pop hl ; $7896
	dec b ; $7897
	jr nz, Label_06_7884 ; $7898
	pop de ; $789a
	pop bc ; $789b
	ld a, $20 ; $789c
	add a, e ; $789e
	ld e, a ; $789f
	jr nc, Label_06_78a3 ; $78a0
	inc d ; $78a2
Label_06_78a3:
	ld a, d ; $78a3
	and a, $f3 ; $78a4
	ld d, a ; $78a6
	dec c ; $78a7
	jr nz, Func_06_7882 ; $78a8
	ret ; $78aa
Func_06_78ab:
	push bc ; $78ab
	push de ; $78ac
Label_06_78ad:
	ld a, [hl+] ; $78ad
	and a, a ; $78ae
	ld [de], a ; $78af
	inc de ; $78b0
	push hl ; $78b1
	ld a, e ; $78b2
	and a, $1f ; $78b3
	jr nz, Label_06_78bf ; $78b5
	ld h, d ; $78b7
	ld l, e ; $78b8
	ld de, $ffe0 ; $78b9
	add hl, de ; $78bc
	ld d, h ; $78bd
	ld e, l ; $78be
Label_06_78bf:
	pop hl ; $78bf
	dec b ; $78c0
	jr nz, Label_06_78ad ; $78c1
	pop de ; $78c3
	pop bc ; $78c4
	ld a, $20 ; $78c5
	add a, e ; $78c7
	ld e, a ; $78c8
	jr nc, Label_06_78cc ; $78c9
	inc d ; $78cb
Label_06_78cc:
	ld a, d ; $78cc
	cp a, $d8 ; $78cd
	jr c, Label_06_78d3 ; $78cf
	ld d, $d4 ; $78d1
Label_06_78d3:
	dec c ; $78d3
	jr nz, Func_06_78ab ; $78d4
	ret ; $78d6
	INCBIN "data/bank_006/d_78d7.bin" ; $78d7, 1833 bytes
