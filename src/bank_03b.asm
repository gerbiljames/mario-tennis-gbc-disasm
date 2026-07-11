INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $3b", ROMX[$4000], BANK[$3b]

FarPtr_3b_00:
	dw Func_3b_44a9 ; $4000
FarPtr_3b_02:
	dw Func_3b_44aa ; $4002
FarPtr_3b_04:
	dw Func_3b_44aa ; $4004
FarPtr_3b_06:
	dw Func_3b_4963 ; $4006
FarPtr_3b_08:
	dw Func_3b_4cfa ; $4008
FarPtr_3b_0a:
	dw Func_3b_5148 ; $400a
FarPtr_3b_0c:
	dw Func_3b_55d1 ; $400c
FarPtr_3b_0e:
	dw Func_3b_5cf3 ; $400e
FarPtr_3b_10:
	dw Func_3b_61f0 ; $4010
FarPtr_3b_12:
	dw Func_3b_67a1 ; $4012
FarPtr_3b_14:
	dw Func_3b_6c7f ; $4014
FarPtr_3b_16:
	dw Func_3b_71b0 ; $4016
FarPtr_3b_18:
	dw Func_3b_74bf ; $4018
FarPtr_3b_1a:
	dw Func_3b_5c2b ; $401a
FarPtr_3b_1c:
	dw Func_3b_775d ; $401c
FarPtr_3b_1e:
	dw Func_3b_72ec ; $401e
FarPtr_3b_20:
	dw Func_3b_731e ; $4020
FarPtr_3b_22:
	dw Func_3b_6e24 ; $4022
FarPtr_3b_24:
	dw Func_3b_6e56 ; $4024
FarPtr_3b_26:
	dw Func_3b_6e87 ; $4026
FarPtr_3b_28:
	dw Func_3b_48f2 ; $4028
FarPtr_3b_2a:
	dw Func_3b_48fa ; $402a
FarPtr_3b_2c:
	dw Func_3b_667f ; $402c
FarPtr_3b_2e:
	dw Func_3b_66b5 ; $402e
FarPtr_3b_30:
	dw Func_3b_79f9 ; $4030
FarPtr_3b_32:
	dw Func_3b_7d57 ; $4032
FarPtr_3b_34:
	dw Func_3b_4b33 ; $4034
FarPtr_3b_36:
	dw Func_3b_619b ; $4036
	INCBIN "data/bank_03b/d_4038.bin" ; $4038, 99 bytes
Func_3b_409b:
	ldh a, [$ff8c] ; $409b
	and a, $0f ; $409d
	ld hl, $40b5 ; $409f
	add a, l ; $40a2
	ld l, a ; $40a3
	jr nc, Label_3b_40a7 ; $40a4
	inc h ; $40a6
Label_3b_40a7:
	ld a, [hl] ; $40a7
	ld b, a ; $40a8
	ld a, c ; $40a9
	or a, a ; $40aa
	jr z, Label_3b_40b1 ; $40ab
	ld a, b ; $40ad
	add a, d ; $40ae
	ld d, a ; $40af
	ret ; $40b0
Label_3b_40b1:
	ld a, d ; $40b1
	sub a, b ; $40b2
	ld d, a ; $40b3
	ret ; $40b4
	INCBIN "data/bank_03b/d_40b5.bin" ; $40b5, 16 bytes
Func_3b_40c5:
	ldh a, [$ff8c] ; $40c5
	and a, $0f ; $40c7
	ld hl, $40df ; $40c9
	add a, l ; $40cc
	ld l, a ; $40cd
	jr nc, Label_3b_40d1 ; $40ce
	inc h ; $40d0
Label_3b_40d1:
	ld a, [hl] ; $40d1
	ld b, a ; $40d2
	ld a, c ; $40d3
	or a, a ; $40d4
	jr z, Label_3b_40db ; $40d5
	ld a, b ; $40d7
	add a, e ; $40d8
	ld e, a ; $40d9
	ret ; $40da
Label_3b_40db:
	ld a, e ; $40db
	sub a, b ; $40dc
	ld e, a ; $40dd
	ret ; $40de
	INCBIN "data/bank_03b/d_40df.bin" ; $40df, 75 bytes
Func_3b_412a:
	ld a, [$cb04] ; $412a
	ld d, a ; $412d
	ld a, [$cb05] ; $412e
	ld e, a ; $4131
	ld a, [$cb0d] ; $4132
	bit 4, a ; $4135
	jr z, Label_3b_414e ; $4137
	ld a, [$cb04] ; $4139
	inc a ; $413c
	add a, a ; $413d
	jr nc, Label_3b_4144 ; $413e
	ld a, b ; $4140
	dec a ; $4141
	jr Label_3b_4149 ; $4142
Label_3b_4144:
	rra ; $4144
	cp a, b ; $4145
	jr c, Label_3b_4149 ; $4146
	xor a, a ; $4148
Label_3b_4149:
	ld [$cb04], a ; $4149
	jr Label_3b_4197 ; $414c
Label_3b_414e:
	bit 5, a ; $414e
	jr z, Label_3b_4167 ; $4150
	ld a, [$cb04] ; $4152
	dec a ; $4155
	add a, a ; $4156
	jr nc, Label_3b_415d ; $4157
	ld a, b ; $4159
	dec a ; $415a
	jr Label_3b_4162 ; $415b
Label_3b_415d:
	rra ; $415d
	cp a, b ; $415e
	jr c, Label_3b_4162 ; $415f
	xor a, a ; $4161
Label_3b_4162:
	ld [$cb04], a ; $4162
	jr Label_3b_4197 ; $4165
Label_3b_4167:
	bit 6, a ; $4167
	jr z, Label_3b_4180 ; $4169
	ld a, [$cb05] ; $416b
	dec a ; $416e
	add a, a ; $416f
	jr nc, Label_3b_4176 ; $4170
	ld a, c ; $4172
	dec a ; $4173
	jr Label_3b_417b ; $4174
Label_3b_4176:
	rra ; $4176
	cp a, c ; $4177
	jr c, Label_3b_417b ; $4178
	xor a, a ; $417a
Label_3b_417b:
	ld [$cb05], a ; $417b
	jr Label_3b_4197 ; $417e
Label_3b_4180:
	bit 7, a ; $4180
	jr z, Label_3b_4197 ; $4182
	ld a, [$cb05] ; $4184
	inc a ; $4187
	add a, a ; $4188
	jr nc, Label_3b_418f ; $4189
	ld a, c ; $418b
	dec a ; $418c
	jr Label_3b_4194 ; $418d
Label_3b_418f:
	rra ; $418f
	cp a, c ; $4190
	jr c, Label_3b_4194 ; $4191
	xor a, a ; $4193
Label_3b_4194:
	ld [$cb05], a ; $4194
Label_3b_4197:
	ld a, [$cb04] ; $4197
	cp a, d ; $419a
	jr nz, Label_3b_41a5 ; $419b
	ld a, [$cb05] ; $419d
	cp a, e ; $41a0
	jr nz, Label_3b_41a5 ; $41a1
	xor a, a ; $41a3
	ret ; $41a4
Label_3b_41a5:
	ld a, $01 ; $41a5
	ret ; $41a7
	INCBIN "data/bank_03b/d_41a8.bin" ; $41a8, 529 bytes
Func_3b_43b9:
	ld a, [$cb05] ; $43b9
	ld b, a ; $43bc
	xor a, a ; $43bd
	inc b ; $43be
Label_3b_43bf:
	dec b ; $43bf
	jr z, Label_3b_43c5 ; $43c0
	add a, c ; $43c2
	jr Label_3b_43bf ; $43c3
Label_3b_43c5:
	ld b, a ; $43c5
	ld a, [$cb04] ; $43c6
	add a, b ; $43c9
	ret ; $43ca
	INCBIN "data/bank_03b/d_43cb.bin" ; $43cb, 16 bytes
Func_3b_43db:
	ld d, $00 ; $43db
	ld a, c ; $43dd
Label_3b_43de:
	cp a, b ; $43de
	jr c, Label_3b_43e5 ; $43df
	inc d ; $43e1
	sub a, b ; $43e2
	jr Label_3b_43de ; $43e3
Label_3b_43e5:
	ld [$cb04], a ; $43e5
	ld a, d ; $43e8
	ld [$cb05], a ; $43e9
	ret ; $43ec
	INCBIN "data/bank_03b/d_43ed.bin" ; $43ed, 59 bytes
	farcall FarPtr_39_04 ; $4428
	ret ; $442b
Func_3b_442c:
	push af ; $442c
	push bc ; $442d
Label_3b_442e:
	ld a, [hl] ; $442e
	cp a, $00 ; $442f
	jr z, Label_3b_4462 ; $4431
	ld [de], a ; $4433
	inc hl ; $4434
	ld a, [hl] ; $4435
	cp a, $de ; $4436
	jr z, Label_3b_443e ; $4438
	cp a, $df ; $443a
	jr nz, Label_3b_4453 ; $443c
Label_3b_443e:
	push hl ; $443e
	push bc ; $443f
	ld h, d ; $4440
	ld l, e ; $4441
	ld bc, $ffe0 ; $4442
	add hl, bc ; $4445
	ld b, a ; $4446
	ld a, [hl] ; $4447
	cp a, $03 ; $4448
	ld a, b ; $444a
	jr nz, Label_3b_444f ; $444b
	sub a, $d0 ; $444d
Label_3b_444f:
	ld [hl], a ; $444f
	pop bc ; $4450
	pop hl ; $4451
	inc hl ; $4452
Label_3b_4453:
	inc de ; $4453
	ld a, e ; $4454
	and a, $1f ; $4455
	jr nz, Label_3b_442e ; $4457
	push hl ; $4459
	ld h, d ; $445a
	ld l, e ; $445b
	add hl, de ; $445c
	ld d, h ; $445d
	ld e, l ; $445e
	pop hl ; $445f
	jr Label_3b_442e ; $4460
Label_3b_4462:
	pop bc ; $4462
	pop af ; $4463
	ret ; $4464
	INCBIN "data/bank_03b/d_4465.bin" ; $4465, 68 bytes
Func_3b_44a9:
	ret ; $44a9
Func_3b_44aa:
	sound $04 ; $44aa
	call DisableLCDSafely ; $44ac
	call Func_3b_45d4 ; $44af
	xor a, a ; $44b2
	ld [$cb0b], a ; $44b3
	ld a, $01 ; $44b6
	ld hl, $4428 ; $44b8
	call Func_00_1b6a ; $44bb
	ld a, $01 ; $44be
	ld hl, $4567 ; $44c0
	call Func_00_1b6a ; $44c3
	call EnableLCD ; $44c6
	ld c, $10 ; $44c9
	call Func_00_1d2e ; $44cb
	call Func_00_1da4 ; $44ce
	ld a, $03 ; $44d1
	ldh [$ff96], a ; $44d3
	ldh [rWBK], a ; $44d5
Label_3b_44d7:
	ldh a, [$ff91] ; $44d7
	ld [$cb0d], a ; $44d9
	call Func_3b_450d ; $44dc
	call Func_00_2631 ; $44df
	ld a, [$cb0d] ; $44e2
	bit 0, a ; $44e5
	jr nz, Label_3b_44ef ; $44e7
	bit 1, a ; $44e9
	jr nz, Label_3b_44fd ; $44eb
	jr Label_3b_44d7 ; $44ed
Label_3b_44ef:
	sound $5f ; $44ef
	ld c, $10 ; $44f1
	call Func_00_1d20 ; $44f3
	call Func_00_1da4 ; $44f6
	call Func_00_1b38 ; $44f9
	ret ; $44fc
Label_3b_44fd:
	sound $62 ; $44fd
	ld c, $10 ; $44ff
	call Func_00_1d20 ; $4501
	call Func_00_1da4 ; $4504
	call Func_00_1b38 ; $4507
	ld a, $ff ; $450a
	ret ; $450c
Func_3b_450d:
	ld a, [$cb0d] ; $450d
	bit 5, a ; $4510
	jr z, Label_3b_4525 ; $4512
	ld a, [$dc12] ; $4514
	or a, a ; $4517
	jr z, Label_3b_4566 ; $4518
	dec a ; $451a
	ld [$dc12], a ; $451b
	sound $5e ; $451e
	call Func_3b_462d ; $4520
	jr Label_3b_4566 ; $4523
Label_3b_4525:
	bit 4, a ; $4525
	jr z, Label_3b_453b ; $4527
	ld a, [$dc12] ; $4529
	cp a, $09 ; $452c
	jr z, Label_3b_4566 ; $452e
	inc a ; $4530
	ld [$dc12], a ; $4531
	sound $5e ; $4534
	call Func_3b_462d ; $4536
	jr Label_3b_4566 ; $4539
Label_3b_453b:
	bit 6, a ; $453b
	jr z, Label_3b_4550 ; $453d
	ld a, [$dc13] ; $453f
	or a, a ; $4542
	jr z, Label_3b_4566 ; $4543
	dec a ; $4545
	ld [$dc13], a ; $4546
	sound $5e ; $4549
	call Func_3b_462d ; $454b
	jr Label_3b_4566 ; $454e
Label_3b_4550:
	bit 7, a ; $4550
	jr z, Label_3b_4566 ; $4552
	ld a, [$dc13] ; $4554
	cp a, $0c ; $4557
	jr z, Label_3b_4566 ; $4559
	inc a ; $455b
	ld [$dc13], a ; $455c
	sound $5e ; $455f
	call Func_3b_462d ; $4561
	jr Label_3b_4566 ; $4564
Label_3b_4566:
	ret ; $4566
	INCBIN "data/bank_03b/d_4567.bin" ; $4567, 109 bytes
Func_3b_45d4:
	ld a, $03 ; $45d4
	ldh [$ff96], a ; $45d6
	ldh [rWBK], a ; $45d8
	xor a, a ; $45da
	ld [$dc13], a ; $45db
	ld [$dc12], a ; $45de
	ld c, $0c ; $45e1
	farcall FarPtr_39_00 ; $45e3
	ld de, $aac0 ; $45e6
	call Func_3b_48f2 ; $45e9
	ld de, $a000 ; $45ec
	farcall FarPtr_39_18 ; $45ef
	ld b, $08 ; $45f2
	ld c, $0f ; $45f4
	farcall FarPtr_39_0e ; $45f6
	ld a, $03 ; $45f9
	ldh [$ff96], a ; $45fb
	ldh [rWBK], a ; $45fd
	call Func_3b_493f ; $45ff
Label_3b_4602:
	jr nz, Label_3b_4602 ; $4602
	call Func_3b_4743 ; $4604
	call Func_3b_4783 ; $4607
	ld hl, $dc01 ; $460a
	ld bc, $d0e2 ; $460d
	call Func_3b_46c0 ; $4610
	ld hl, $dc01 ; $4613
	ld bc, $d0a4 ; $4616
	ld a, $07 ; $4619
	call Func_3b_46da ; $461b
	ld hl, $db00 ; $461e
	ld de, $d0e4 ; $4621
	ld a, $07 ; $4624
	call Func_3b_46ed ; $4626
	farcall FarPtr_39_02 ; $4629
	ret ; $462c
Func_3b_462d:
	ld a, $03 ; $462d
	ldh [$ff96], a ; $462f
	ldh [rWBK], a ; $4631
	ld a, [$dc12] ; $4633
	ld hl, $dc01 ; $4636
	add a, l ; $4639
	ld l, a ; $463a
	jr nc, Label_3b_463e ; $463b
	inc h ; $463d
Label_3b_463e:
	ld bc, $d0a4 ; $463e
	ld a, $07 ; $4641
	call Func_3b_46da ; $4643
	ld a, [$dc13] ; $4646
	ld hl, $dc01 ; $4649
	add a, l ; $464c
	ld l, a ; $464d
	jr nc, Label_3b_4651 ; $464e
	inc h ; $4650
Label_3b_4651:
	ld bc, $d0e2 ; $4651
	call Func_3b_46c0 ; $4654
	ld a, [$dc13] ; $4657
	ld hl, $db00 ; $465a
	ld de, $0010 ; $465d
Label_3b_4660:
	or a, a ; $4660
	jr z, Label_3b_4667 ; $4661
	add hl, de ; $4663
	dec a ; $4664
	jr Label_3b_4660 ; $4665
Label_3b_4667:
	ld a, [$dc12] ; $4667
	add a, l ; $466a
	ld l, a ; $466b
	jr nc, Label_3b_466f ; $466c
	inc h ; $466e
Label_3b_466f:
	ld de, $d0e4 ; $466f
	ld a, $07 ; $4672
	call Func_3b_46ed ; $4674
	ld hl, $d0a0 ; $4677
	ld de, $98a0 ; $467a
	ld c, $08 ; $467d
	call Func_00_0480 ; $467f
	ld hl, $d4a0 ; $4682
	ld de, $b8a0 ; $4685
	ld c, $08 ; $4688
	call Func_00_0480 ; $468a
	call Func_00_2631 ; $468d
	ld hl, $d120 ; $4690
	ld de, $9920 ; $4693
	ld c, $08 ; $4696
	call Func_00_0480 ; $4698
	ld hl, $d520 ; $469b
	ld de, $b920 ; $469e
	ld c, $08 ; $46a1
	call Func_00_0480 ; $46a3
	call Func_00_2631 ; $46a6
	ld hl, $d1a0 ; $46a9
	ld de, $99a0 ; $46ac
	ld c, $04 ; $46af
	call Func_00_0480 ; $46b1
	ld hl, $d5a0 ; $46b4
	ld de, $b9a0 ; $46b7
	ld c, $04 ; $46ba
	call Func_00_0480 ; $46bc
	ret ; $46bf
Func_3b_46c0:
	ld d, h ; $46c0
	ld e, l ; $46c1
	ld h, b ; $46c2
	ld l, c ; $46c3
	ld c, $00 ; $46c4
Label_3b_46c6:
	ld a, [de] ; $46c6
	inc de ; $46c7
	ld b, a ; $46c8
	call Func_3b_48fa ; $46c9
	push de ; $46cc
	ld de, $0040 ; $46cd
	add hl, de ; $46d0
	pop de ; $46d1
	ld a, c ; $46d2
	inc a ; $46d3
	ld c, a ; $46d4
	cp a, $04 ; $46d5
	jr nz, Label_3b_46c6 ; $46d7
	ret ; $46d9
Func_3b_46da:
	ld d, h ; $46da
	ld e, l ; $46db
	ld h, b ; $46dc
	ld l, c ; $46dd
	ld c, a ; $46de
Label_3b_46df:
	ld a, [de] ; $46df
	inc de ; $46e0
	ld b, a ; $46e1
	call Func_3b_48fa ; $46e2
	inc hl ; $46e5
	inc hl ; $46e6
	ld a, c ; $46e7
	dec a ; $46e8
	ld c, a ; $46e9
	jr nz, Label_3b_46df ; $46ea
	ret ; $46ec
Func_3b_46ed:
	push af ; $46ed
	ld c, $00 ; $46ee
Label_3b_46f0:
	pop af ; $46f0
	push af ; $46f1
	push bc ; $46f2
	push hl ; $46f3
	push de ; $46f4
	ld c, a ; $46f5
Label_3b_46f6:
	ld a, [hl+] ; $46f6
	ld b, a ; $46f7
	call Func_3b_4718 ; $46f8
	inc de ; $46fb
	inc de ; $46fc
	ld a, c ; $46fd
	dec a ; $46fe
	ld c, a ; $46ff
	jr nz, Label_3b_46f6 ; $4700
	pop de ; $4702
	ld hl, $0040 ; $4703
	add hl, de ; $4706
	ld d, h ; $4707
	ld e, l ; $4708
	pop hl ; $4709
	ld bc, $0010 ; $470a
	add hl, bc ; $470d
	pop bc ; $470e
	ld a, c ; $470f
	inc a ; $4710
	ld c, a ; $4711
	cp a, $04 ; $4712
	jr nz, Label_3b_46f0 ; $4714
	pop af ; $4716
	ret ; $4717
Func_3b_4718:
	push af ; $4718
	push bc ; $4719
	push de ; $471a
	push hl ; $471b
	ld hl, $4738 ; $471c
	ld a, b ; $471f
	add a, l ; $4720
	ld l, a ; $4721
	jr nc, Label_3b_4725 ; $4722
	inc h ; $4724
Label_3b_4725:
	ld a, [hl] ; $4725
	ld h, d ; $4726
	ld l, e ; $4727
	ld [hl+], a ; $4728
	inc a ; $4729
	ld [hl], a ; $472a
	inc a ; $472b
	ld de, $001f ; $472c
	add hl, de ; $472f
	ld [hl+], a ; $4730
	inc a ; $4731
	ld [hl], a ; $4732
	pop hl ; $4733
	pop de ; $4734
	pop bc ; $4735
	pop af ; $4736
	ret ; $4737
	INCBIN "data/bank_03b/d_4738.bin" ; $4738, 11 bytes
Func_3b_4743:
	ld a, $03 ; $4743
	ldh [$ff96], a ; $4745
	ldh [rWBK], a ; $4747
	ld hl, $4772 ; $4749
	ld de, $dc01 ; $474c
	ld bc, $0001 ; $474f
	call CopyMemoryFast ; $4752
	ld hl, $da58 ; $4755
	ld a, [hl] ; $4758
	ld b, a ; $4759
	and a, $01 ; $475a
	jr nz, Label_3b_4763 ; $475c
	ld a, $10 ; $475e
	ld [$dc0f], a ; $4760
Label_3b_4763:
	ld a, b ; $4763
	and a, $02 ; $4764
	jr nz, Label_3b_476d ; $4766
	ld a, $10 ; $4768
	ld [$dc10], a ; $476a
Label_3b_476d:
	call Func_3b_479a ; $476d
	ret ; $4770
	INCBIN "data/bank_03b/d_4771.bin" ; $4771, 18 bytes
Func_3b_4783:
	ld hl, $db00 ; $4783
	ld c, $00 ; $4786
Label_3b_4788:
	ld a, $01 ; $4788
	ld [hl], a ; $478a
	ld a, $11 ; $478b
	add a, l ; $478d
	ld l, a ; $478e
	jr nc, Label_3b_4792 ; $478f
	inc h ; $4791
Label_3b_4792:
	ld a, c ; $4792
	inc a ; $4793
	ld c, a ; $4794
	cp a, $10 ; $4795
	jr nz, Label_3b_4788 ; $4797
	ret ; $4799
Func_3b_479a:
	ld de, $db00 ; $479a
	ld b, $00 ; $479d
Label_3b_479f:
	push bc ; $479f
	ld hl, $47bc ; $47a0
	ld a, b ; $47a3
	add a, l ; $47a4
	ld l, a ; $47a5
	jr nc, Label_3b_47a9 ; $47a6
	inc h ; $47a8
Label_3b_47a9:
	ld b, [hl] ; $47a9
	call Func_3b_47cc ; $47aa
	pop bc ; $47ad
	ld hl, $0010 ; $47ae
	add hl, de ; $47b1
	ld d, h ; $47b2
	ld e, l ; $47b3
	ld a, b ; $47b4
	inc a ; $47b5
	ld b, a ; $47b6
	cp a, $10 ; $47b7
	jr nz, Label_3b_479f ; $47b9
	ret ; $47bb
	INCBIN "data/bank_03b/d_47bc.bin" ; $47bc, 16 bytes
Func_3b_47cc:
	push af ; $47cc
	push bc ; $47cd
	push de ; $47ce
	push hl ; $47cf
	push de ; $47d0
	ld hl, $d9d8 ; $47d1
	ld a, b ; $47d4
	add a, a ; $47d5
	add a, a ; $47d6
	add a, a ; $47d7
	add a, l ; $47d8
	ld l, a ; $47d9
	jr nc, Label_3b_47dd ; $47da
	inc h ; $47dc
Label_3b_47dd:
	ld d, h ; $47dd
	ld e, l ; $47de
	call Func_3b_4870 ; $47df
	pop de ; $47e2
	ld h, d ; $47e3
	ld l, e ; $47e4
	ld b, $00 ; $47e5
Label_3b_47e7:
	push bc ; $47e7
	push hl ; $47e8
	ld hl, $4808 ; $47e9
	ld a, b ; $47ec
	add a, l ; $47ed
	ld l, a ; $47ee
	jr nc, Label_3b_47f2 ; $47ef
	inc h ; $47f1
Label_3b_47f2:
	ld b, [hl] ; $47f2
	call Func_3b_4834 ; $47f3
	pop hl ; $47f6
	pop bc ; $47f7
	call Func_3b_4818 ; $47f8
	ld [hl+], a ; $47fb
	ld a, b ; $47fc
	inc a ; $47fd
	ld b, a ; $47fe
	cp a, $10 ; $47ff
	jr nz, Label_3b_47e7 ; $4801
	pop hl ; $4803
	pop de ; $4804
	pop bc ; $4805
	pop af ; $4806
	ret ; $4807
	INCBIN "data/bank_03b/d_4808.bin" ; $4808, 16 bytes
Func_3b_4818:
	push hl ; $4818
	ld hl, $4824 ; $4819
	add a, l ; $481c
	ld l, a ; $481d
	jr nc, Label_3b_4821 ; $481e
	inc h ; $4820
Label_3b_4821:
	ld a, [hl] ; $4821
	pop hl ; $4822
	ret ; $4823
	INCBIN "data/bank_03b/d_4824.bin" ; $4824, 16 bytes
Func_3b_4834:
	push hl ; $4834
	push de ; $4835
	push bc ; $4836
	ld a, b ; $4837
	and a, $0f ; $4838
	ld hl, $dc20 ; $483a
	add a, l ; $483d
	ld l, a ; $483e
	jr nc, Label_3b_4842 ; $483f
	inc h ; $4841
Label_3b_4842:
	ld c, [hl] ; $4842
	ld a, $10 ; $4843
	add a, l ; $4845
	ld l, a ; $4846
	jr nc, Label_3b_484a ; $4847
	inc h ; $4849
Label_3b_484a:
	ld a, [hl] ; $484a
	sla a ; $484b
	ld d, a ; $484d
	ld a, $10 ; $484e
	add a, l ; $4850
	ld l, a ; $4851
	jr nc, Label_3b_4855 ; $4852
	inc h ; $4854
Label_3b_4855:
	ld a, [hl] ; $4855
	sla a ; $4856
	sla a ; $4858
	ld e, a ; $485a
	ld a, $10 ; $485b
	add a, l ; $485d
	ld l, a ; $485e
	jr nc, Label_3b_4862 ; $485f
	inc h ; $4861
Label_3b_4862:
	ld a, [hl] ; $4862
	sla a ; $4863
	sla a ; $4865
	sla a ; $4867
	add a, e ; $4869
	add a, d ; $486a
	add a, c ; $486b
	pop bc ; $486c
	pop de ; $486d
	pop hl ; $486e
	ret ; $486f
Func_3b_4870:
	push af ; $4870
	push bc ; $4871
	push de ; $4872
	push hl ; $4873
	push de ; $4874
	ld hl, $dc20 ; $4875
	ld bc, $0004 ; $4878
	call ClearMemory16 ; $487b
	pop de ; $487e
	ld hl, $dc20 ; $487f
	ld c, $00 ; $4882
Label_3b_4884:
	ld a, [de] ; $4884
	inc de ; $4885
	ld b, a ; $4886
	call Func_3b_489d ; $4887
	ld a, $08 ; $488a
	add a, l ; $488c
	ld l, a ; $488d
	jr nc, Label_3b_4891 ; $488e
	inc h ; $4890
Label_3b_4891:
	ld a, c ; $4891
	inc a ; $4892
	ld c, a ; $4893
	cp a, $08 ; $4894
	jr nz, Label_3b_4884 ; $4896
	pop hl ; $4898
	pop de ; $4899
	pop bc ; $489a
	pop af ; $489b
	ret ; $489c
Func_3b_489d:
	push hl ; $489d
	push bc ; $489e
	ld a, $07 ; $489f
	add a, l ; $48a1
	ld l, a ; $48a2
	jr nc, Label_3b_48a6 ; $48a3
	inc h ; $48a5
Label_3b_48a6:
	ld c, $00 ; $48a6
Label_3b_48a8:
	ld a, b ; $48a8
	and a, $01 ; $48a9
	ld [hl-], a ; $48ab
	srl b ; $48ac
	ld a, c ; $48ae
	inc a ; $48af
	ld c, a ; $48b0
	cp a, $08 ; $48b1
	jr nz, Label_3b_48a8 ; $48b3
	pop bc ; $48b5
	pop hl ; $48b6
	ret ; $48b7
	INCBIN "data/bank_03b/d_48b8.bin" ; $48b8, 58 bytes
Func_3b_48f2:
	ld b, $16 ; $48f2
	ld c, $44 ; $48f4
	farcall FarPtr_39_10 ; $48f6
	ret ; $48f9
Func_3b_48fa:
	push af ; $48fa
	push bc ; $48fb
	push de ; $48fc
	push hl ; $48fd
	ld c, $ac ; $48fe
	ld a, b ; $4900
	add a, a ; $4901
	add a, a ; $4902
	add a, c ; $4903
	push hl ; $4904
	ld [hl+], a ; $4905
	inc a ; $4906
	ld [hl], a ; $4907
	inc a ; $4908
	ld de, $001f ; $4909
	add hl, de ; $490c
	ld [hl+], a ; $490d
	inc a ; $490e
	ld [hl], a ; $490f
	pop hl ; $4910
	ld de, $0400 ; $4911
	add hl, de ; $4914
	ld a, b ; $4915
	push hl ; $4916
	ld hl, $492e ; $4917
	add a, l ; $491a
	ld l, a ; $491b
	jr nc, Label_3b_491f ; $491c
	inc h ; $491e
Label_3b_491f:
	ld a, [hl] ; $491f
	pop hl ; $4920
	ld [hl+], a ; $4921
	ld [hl], a ; $4922
	ld de, $001f ; $4923
	add hl, de ; $4926
	ld [hl+], a ; $4927
	ld [hl], a ; $4928
	pop hl ; $4929
	pop de ; $492a
	pop bc ; $492b
	pop af ; $492c
	ret ; $492d
	INCBIN "data/bank_03b/d_492e.bin" ; $492e, 17 bytes
Func_3b_493f:
	push bc ; $493f
	ldh a, [$ff96] ; $4940
	push af ; $4942
	ld a, $03 ; $4943
	ldh [$ff96], a ; $4945
	ldh [rWBK], a ; $4947
	ld hl, $d900 ; $4949
	ld bc, $0020 ; $494c
	call ClearMemory16 ; $494f
	ld hl, $d900 ; $4952
	ld b, $0b ; $4955
	farcall FarPtr_03_06 ; $4957
	ld b, a ; $495a
	pop af ; $495b
	ldh [$ff96], a ; $495c
	ldh [rWBK], a ; $495e
	ld a, b ; $4960
	pop bc ; $4961
	ret ; $4962
Func_3b_4963:
	sound $04 ; $4963
	call DisableLCDSafely ; $4965
	call Func_3b_49e5 ; $4968
	ld a, $00 ; $496b
	ld [$cb0b], a ; $496d
	ld a, $01 ; $4970
	ld hl, $4428 ; $4972
	call Func_00_1b6a ; $4975
	xor a, a ; $4978
	ld [$d901], a ; $4979
	ld [$d900], a ; $497c
	call EnableLCD ; $497f
	ld c, $10 ; $4982
	call Func_00_1d2e ; $4984
	call Func_00_1da4 ; $4987
	ld a, $03 ; $498a
	ldh [$ff96], a ; $498c
	ldh [rWBK], a ; $498e
Label_3b_4990:
	ldh a, [$ff91] ; $4990
	ld [$cb0d], a ; $4992
	call Func_00_2631 ; $4995
	ld a, [$cb0d] ; $4998
	bit 0, a ; $499b
	jr nz, Label_3b_49bf ; $499d
	bit 1, a ; $499f
	jr nz, Label_3b_49d4 ; $49a1
	bit 5, a ; $49a3
	jr nz, Label_3b_49ad ; $49a5
	bit 4, a ; $49a7
	jr nz, Label_3b_49b6 ; $49a9
	jr Label_3b_4990 ; $49ab
Label_3b_49ad:
	ld a, [$d901] ; $49ad
	inc a ; $49b0
	ld [$d901], a ; $49b1
	jr Label_3b_4990 ; $49b4
Label_3b_49b6:
	ld a, [$d900] ; $49b6
	inc a ; $49b9
	ld [$d900], a ; $49ba
	jr Label_3b_4990 ; $49bd
Label_3b_49bf:
	bit 2, a ; $49bf
	jr z, Label_3b_49c6 ; $49c1
	call Func_3b_4b19 ; $49c3
Label_3b_49c6:
	sound $5f ; $49c6
	ld c, $10 ; $49c8
	call Func_00_1d20 ; $49ca
	call Func_00_1da4 ; $49cd
	call Func_00_1b38 ; $49d0
	ret ; $49d3
Label_3b_49d4:
	sound $62 ; $49d4
	ld c, $10 ; $49d6
	call Func_00_1d20 ; $49d8
	call Func_00_1da4 ; $49db
	call Func_00_1b38 ; $49de
	ld a, $ff ; $49e1
	ret ; $49e3
	INCBIN "data/bank_03b/d_49e4.bin" ; $49e4, 1 bytes
Func_3b_49e5:
	ld a, $03 ; $49e5
	ldh [$ff96], a ; $49e7
	ldh [rWBK], a ; $49e9
	call Func_3b_4c53 ; $49eb
	ld a, [$d819] ; $49ee
	or a, a ; $49f1
	jr nz, Label_3b_49fb ; $49f2
	ld c, $0e ; $49f4
	farcall FarPtr_39_00 ; $49f6
	jr Label_3b_4a00 ; $49f9
Label_3b_49fb:
	ld c, $0d ; $49fb
	farcall FarPtr_39_00 ; $49fd
Label_3b_4a00:
	ld a, $03 ; $4a00
	ldh [$ff96], a ; $4a02
	ldh [rWBK], a ; $4a04
	call Func_3b_4a71 ; $4a06
	ld a, [$d819] ; $4a09
	or a, a ; $4a0c
	jr nz, Label_3b_4a25 ; $4a0d
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4a0f
	ld c, a ; $4a12
	ld de, $d102 ; $4a13
	call Func_3b_4af1 ; $4a16
	ld a, [wStoryModePartnerCharacterOverworldSprite] ; $4a19
	ld c, a ; $4a1c
	ld de, $d142 ; $4a1d
	call Func_3b_4af1 ; $4a20
	jr Label_3b_4a6d ; $4a23
Label_3b_4a25:
	ld c, $00 ; $4a25
	ld de, $d0c2 ; $4a27
	call Func_3b_4af1 ; $4a2a
	ld c, $00 ; $4a2d
	ld de, $d1a2 ; $4a2f
	call Func_3b_4af1 ; $4a32
	ld c, $03 ; $4a35
	ld de, $d102 ; $4a37
	call Func_3b_4af1 ; $4a3a
	ld c, $03 ; $4a3d
	ld de, $d1e2 ; $4a3f
	call Func_3b_4af1 ; $4a42
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4a45
	ld c, a ; $4a48
	ld de, $d0c2 ; $4a49
	call Func_3b_4af1 ; $4a4c
	ld a, [wStoryModePartnerCharacterOverworldSprite] ; $4a4f
	ld c, a ; $4a52
	ld de, $d102 ; $4a53
	call Func_3b_4af1 ; $4a56
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4a59
	ld c, a ; $4a5c
	ld de, $d1a2 ; $4a5d
	call Func_3b_4af1 ; $4a60
	ld a, [wStoryModePartnerCharacterOverworldSprite] ; $4a63
	ld c, a ; $4a66
	ld de, $d1e2 ; $4a67
	call Func_3b_4af1 ; $4a6a
Label_3b_4a6d:
	farcall FarPtr_39_02 ; $4a6d
	ret ; $4a70
Func_3b_4a71:
	ld a, [$d819] ; $4a71
	or a, a ; $4a74
	jr nz, Label_3b_4a87 ; $4a75
	ld hl, $d800 ; $4a77
	ld de, $d105 ; $4a7a
	call Func_3b_4aa3 ; $4a7d
	ld de, $d145 ; $4a80
	call Func_3b_4aa3 ; $4a83
	ret ; $4a86
Label_3b_4a87:
	ld hl, $d800 ; $4a87
	ld de, $d0c5 ; $4a8a
	call Func_3b_4aa3 ; $4a8d
	ld de, $d105 ; $4a90
	call Func_3b_4aa3 ; $4a93
	ld de, $d1a5 ; $4a96
	call Func_3b_4aa3 ; $4a99
	ld de, $d1e5 ; $4a9c
	call Func_3b_4aa3 ; $4a9f
	ret ; $4aa2
Func_3b_4aa3:
	ld c, $00 ; $4aa3
Label_3b_4aa5:
	ld a, [hl+] ; $4aa5
	or a, a ; $4aa6
	jr z, Label_3b_4aac ; $4aa7
	call Func_3b_4ac9 ; $4aa9
Label_3b_4aac:
	inc de ; $4aac
	inc de ; $4aad
	ld a, c ; $4aae
	inc a ; $4aaf
	ld c, a ; $4ab0
	cp a, $03 ; $4ab1
	jr nz, Label_3b_4aa5 ; $4ab3
	inc de ; $4ab5
	ld c, $00 ; $4ab6
Label_3b_4ab8:
	ld a, [hl+] ; $4ab8
	or a, a ; $4ab9
	jr z, Label_3b_4abf ; $4aba
	call Func_3b_4ac9 ; $4abc
Label_3b_4abf:
	inc de ; $4abf
	inc de ; $4ac0
	ld a, c ; $4ac1
	inc a ; $4ac2
	ld c, a ; $4ac3
	cp a, $03 ; $4ac4
	jr nz, Label_3b_4ab8 ; $4ac6
	ret ; $4ac8
Func_3b_4ac9:
	push af ; $4ac9
	push bc ; $4aca
	push de ; $4acb
	push hl ; $4acc
	ld h, d ; $4acd
	ld l, e ; $4ace
	push hl ; $4acf
	ld a, $60 ; $4ad0
	ld [hl+], a ; $4ad2
	inc a ; $4ad3
	ld [hl], a ; $4ad4
	inc a ; $4ad5
	ld de, $001f ; $4ad6
	add hl, de ; $4ad9
	ld [hl+], a ; $4ada
	inc a ; $4adb
	ld [hl], a ; $4adc
	pop hl ; $4add
	ld de, $0400 ; $4ade
	add hl, de ; $4ae1
	ld a, $0a ; $4ae2
	ld [hl+], a ; $4ae4
	ld [hl], a ; $4ae5
	ld de, $001f ; $4ae6
	add hl, de ; $4ae9
	ld [hl+], a ; $4aea
	ld [hl], a ; $4aeb
	pop hl ; $4aec
	pop de ; $4aed
	pop bc ; $4aee
	pop af ; $4aef
	ret ; $4af0
Func_3b_4af1:
	ld hl, $d240 ; $4af1
	ld a, c ; $4af4
	add a, a ; $4af5
	add a, l ; $4af6
	ld l, a ; $4af7
	jr nc, Label_3b_4afb ; $4af8
	inc h ; $4afa
Label_3b_4afb:
	ld b, $02 ; $4afb
	ld c, $02 ; $4afd
	push hl ; $4aff
	push de ; $4b00
	farcall FarPtr_39_0a ; $4b01
	pop de ; $4b04
	pop hl ; $4b05
	ld bc, $0400 ; $4b06
	add hl, bc ; $4b09
	push hl ; $4b0a
	ld h, d ; $4b0b
	ld l, e ; $4b0c
	add hl, bc ; $4b0d
	ld d, h ; $4b0e
	ld e, l ; $4b0f
	pop hl ; $4b10
	ld b, $02 ; $4b11
	ld c, $02 ; $4b13
	farcall FarPtr_39_0a ; $4b15
	ret ; $4b18
Func_3b_4b19:
	sound $22 ; $4b19
	ld a, [$d900] ; $4b1b
	cp a, $0c ; $4b1e
	jp nz, Label_3b_4b2e ; $4b20
	ld a, [$d901] ; $4b23
	cp a, $22 ; $4b26
	jp nz, Label_3b_4b2e ; $4b28
	call Func_3b_4b33 ; $4b2b
Label_3b_4b2e:
	farcall FarPtr_03_48 ; $4b2e
	xor a, a ; $4b31
	ret ; $4b32
Func_3b_4b33:
	ld de, $0720 ; $4b33
	farcall FarPtr_03_1e ; $4b36
	ld de, $0740 ; $4b39
	farcall FarPtr_03_1e ; $4b3c
	ld de, $0760 ; $4b3f
	farcall FarPtr_03_1e ; $4b42
	ld de, $0780 ; $4b45
	farcall FarPtr_03_1e ; $4b48
	ld de, $07a0 ; $4b4b
	farcall FarPtr_03_1e ; $4b4e
	ld de, $0140 ; $4b51
	farcall FarPtr_03_1e ; $4b54
	ld de, $0160 ; $4b57
	farcall FarPtr_03_1e ; $4b5a
	ld de, $0180 ; $4b5d
	farcall FarPtr_03_1e ; $4b60
	ld de, $01a0 ; $4b63
	farcall FarPtr_03_1e ; $4b66
	ld de, $01c0 ; $4b69
	farcall FarPtr_03_1e ; $4b6c
	ld de, $01e0 ; $4b6f
	farcall FarPtr_03_1e ; $4b72
	ld de, $0280 ; $4b75
	farcall FarPtr_03_1e ; $4b78
	ld de, $02a0 ; $4b7b
	farcall FarPtr_03_1e ; $4b7e
	ld de, $02e0 ; $4b81
	farcall FarPtr_03_1e ; $4b84
	ld de, $0300 ; $4b87
	farcall FarPtr_03_1e ; $4b8a
	ld de, $0340 ; $4b8d
	farcall FarPtr_03_1e ; $4b90
	ld de, $0360 ; $4b93
	farcall FarPtr_03_1e ; $4b96
	ld de, $03a0 ; $4b99
	farcall FarPtr_03_1e ; $4b9c
	ld de, $03c0 ; $4b9f
	farcall FarPtr_03_1e ; $4ba2
	ld de, $0500 ; $4ba5
	farcall FarPtr_03_1e ; $4ba8
	ld de, $0520 ; $4bab
	farcall FarPtr_03_1e ; $4bae
	ld de, $0560 ; $4bb1
	farcall FarPtr_03_1e ; $4bb4
	ld de, $0580 ; $4bb7
	farcall FarPtr_03_1e ; $4bba
	ld de, $05c0 ; $4bbd
	farcall FarPtr_03_1e ; $4bc0
	ld de, $05e0 ; $4bc3
	farcall FarPtr_03_1e ; $4bc6
	ld de, $0620 ; $4bc9
	farcall FarPtr_03_1e ; $4bcc
	ld de, $0640 ; $4bcf
	farcall FarPtr_03_1e ; $4bd2
	ld de, $0680 ; $4bd5
	farcall FarPtr_03_1e ; $4bd8
	ld de, $06a0 ; $4bdb
	farcall FarPtr_03_1e ; $4bde
	ld a, [$c36c] ; $4be1
	push af ; $4be4
	ld c, $00 ; $4be5
Label_3b_4be7:
	push bc ; $4be7
	ld a, c ; $4be8
	ld [$c36c], a ; $4be9
	farcall FarPtr_03_1a ; $4bec
	cp a, $fe ; $4bef
	jr z, Label_3b_4c44 ; $4bf1
	ld de, $1400 ; $4bf3
	call SetGameFlag ; $4bf6
	ld de, $1420 ; $4bf9
	call SetGameFlag ; $4bfc
	ld de, $1440 ; $4bff
	call SetGameFlag ; $4c02
	ld de, $1460 ; $4c05
	call SetGameFlag ; $4c08
	ld de, $1480 ; $4c0b
	call SetGameFlag ; $4c0e
	ld de, $14a0 ; $4c11
	call SetGameFlag ; $4c14
	ld de, $14c0 ; $4c17
	call SetGameFlag ; $4c1a
	ld de, $14e0 ; $4c1d
	call SetGameFlag ; $4c20
	ld de, $1500 ; $4c23
	call SetGameFlag ; $4c26
	ld de, $1560 ; $4c29
	call SetGameFlag ; $4c2c
	ld de, $1580 ; $4c2f
	call SetGameFlag ; $4c32
	ld de, $1520 ; $4c35
	call SetGameFlag ; $4c38
	ld de, $1540 ; $4c3b
	call SetGameFlag ; $4c3e
	farcall FarPtr_03_48 ; $4c41
Label_3b_4c44:
	pop bc ; $4c44
	inc c ; $4c45
	ld a, c ; $4c46
	cp a, $03 ; $4c47
	jr nz, Label_3b_4be7 ; $4c49
	pop af ; $4c4b
	ld [$c36c], a ; $4c4c
	farcall FarPtr_03_46 ; $4c4f
	ret ; $4c52
Func_3b_4c53:
	ld a, $03 ; $4c53
	ldh [$ff96], a ; $4c55
	ldh [rWBK], a ; $4c57
	ld hl, $d800 ; $4c59
	ld bc, $0018 ; $4c5c
	call ClearBytes ; $4c5f
	ld de, $d800 ; $4c62
	ld a, [$c9b5] ; $4c65
	and a, $03 ; $4c68
	ld b, a ; $4c6a
	call Func_3b_4ed1 ; $4c6b
	ld de, $d803 ; $4c6e
	ld a, [$c9b5] ; $4c71
	swap a ; $4c74
	and a, $03 ; $4c76
	ld b, a ; $4c78
	call Func_3b_4ed1 ; $4c79
	ld de, $d80c ; $4c7c
	ld a, [$c9b5] ; $4c7f
	srl a ; $4c82
	srl a ; $4c84
	and a, $03 ; $4c86
	ld b, a ; $4c88
	call Func_3b_4ed1 ; $4c89
	ld de, $d80f ; $4c8c
	ld a, [$c9b5] ; $4c8f
	swap a ; $4c92
	srl a ; $4c94
	srl a ; $4c96
	and a, $03 ; $4c98
	ld b, a ; $4c9a
	call Func_3b_4ed1 ; $4c9b
	ld de, $d806 ; $4c9e
	ld a, [$c9b6] ; $4ca1
	and a, $03 ; $4ca4
	ld b, a ; $4ca6
	call Func_3b_4ed1 ; $4ca7
	ld de, $d809 ; $4caa
	ld a, [$c9b6] ; $4cad
	swap a ; $4cb0
	and a, $03 ; $4cb2
	ld b, a ; $4cb4
	call Func_3b_4ed1 ; $4cb5
	ld de, $d812 ; $4cb8
	ld a, [$c9b6] ; $4cbb
	srl a ; $4cbe
	srl a ; $4cc0
	and a, $03 ; $4cc2
	ld b, a ; $4cc4
	call Func_3b_4ed1 ; $4cc5
	ld de, $d815 ; $4cc8
	ld a, [$c9b6] ; $4ccb
	swap a ; $4cce
	srl a ; $4cd0
	srl a ; $4cd2
	and a, $03 ; $4cd4
	ld b, a ; $4cd6
	call Func_3b_4ed1 ; $4cd7
	ld a, [$d80c] ; $4cda
	or a, a ; $4cdd
	jr nz, Label_3b_4cf4 ; $4cde
	ld a, [$d80f] ; $4ce0
	or a, a ; $4ce3
	jr nz, Label_3b_4cf4 ; $4ce4
	ld a, [$d812] ; $4ce6
	or a, a ; $4ce9
	jr nz, Label_3b_4cf4 ; $4cea
	ld a, [$d815] ; $4cec
	or a, a ; $4cef
	jr nz, Label_3b_4cf4 ; $4cf0
	jr Label_3b_4cf9 ; $4cf2
Label_3b_4cf4:
	ld a, $01 ; $4cf4
	ld [$d819], a ; $4cf6
Label_3b_4cf9:
	ret ; $4cf9
Func_3b_4cfa:
	sound $04 ; $4cfa
	call DisableLCDSafely ; $4cfc
	call Func_3b_4dbd ; $4cff
	xor a, a ; $4d02
	ld [$cb0b], a ; $4d03
	ld a, $01 ; $4d06
	ld hl, $4428 ; $4d08
	call Func_00_1b6a ; $4d0b
	ld a, $01 ; $4d0e
	ld hl, $50d6 ; $4d10
	call Func_00_1b6a ; $4d13
	call EnableLCD ; $4d16
	ld c, $10 ; $4d19
	call Func_00_1d2e ; $4d1b
	call Func_00_1da4 ; $4d1e
	ld a, $03 ; $4d21
	ldh [$ff96], a ; $4d23
	ldh [rWBK], a ; $4d25
Label_3b_4d27:
	ldh a, [$ff91] ; $4d27
	ld [$cb0d], a ; $4d29
	call Func_3b_4d5d ; $4d2c
	call Func_00_2631 ; $4d2f
	ld a, [$cb0d] ; $4d32
	bit 0, a ; $4d35
	jr nz, Label_3b_4d3f ; $4d37
	bit 1, a ; $4d39
	jr nz, Label_3b_4d4d ; $4d3b
	jr Label_3b_4d27 ; $4d3d
Label_3b_4d3f:
	sound $5f ; $4d3f
	ld c, $10 ; $4d41
	call Func_00_1d20 ; $4d43
	call Func_00_1da4 ; $4d46
	call Func_00_1b38 ; $4d49
	ret ; $4d4c
Label_3b_4d4d:
	sound $62 ; $4d4d
	ld c, $10 ; $4d4f
	call Func_00_1d20 ; $4d51
	call Func_00_1da4 ; $4d54
	call Func_00_1b38 ; $4d57
	ld a, $ff ; $4d5a
	ret ; $4d5c
Func_3b_4d5d:
	ld a, [$cb0d] ; $4d5d
	bit 5, a ; $4d60
	jr z, Label_3b_4d75 ; $4d62
	ld a, [$d801] ; $4d64
	or a, a ; $4d67
	jr z, Label_3b_4dbc ; $4d68
	xor a, a ; $4d6a
	ld [$d801], a ; $4d6b
	sound $5e ; $4d6e
	call Func_3b_4f38 ; $4d70
	jr Label_3b_4dbc ; $4d73
Label_3b_4d75:
	bit 4, a ; $4d75
	jr z, Label_3b_4d91 ; $4d77
	ld a, [$d800] ; $4d79
	or a, a ; $4d7c
	jr z, Label_3b_4dbc ; $4d7d
	ld a, [$d801] ; $4d7f
	or a, a ; $4d82
	jr nz, Label_3b_4dbc ; $4d83
	ld a, $01 ; $4d85
	ld [$d801], a ; $4d87
	sound $5e ; $4d8a
	call Func_3b_4f38 ; $4d8c
	jr Label_3b_4dbc ; $4d8f
Label_3b_4d91:
	bit 6, a ; $4d91
	jr z, Label_3b_4da6 ; $4d93
	ld a, [$d802] ; $4d95
	or a, a ; $4d98
	jr z, Label_3b_4dbc ; $4d99
	dec a ; $4d9b
	ld [$d802], a ; $4d9c
	sound $5e ; $4d9f
	call Func_3b_4f38 ; $4da1
	jr Label_3b_4dbc ; $4da4
Label_3b_4da6:
	bit 7, a ; $4da6
	jr z, Label_3b_4dbc ; $4da8
	ld a, [$d802] ; $4daa
	cp a, $0b ; $4dad
	jr z, Label_3b_4dbc ; $4daf
	inc a ; $4db1
	ld [$d802], a ; $4db2
	sound $5e ; $4db5
	call Func_3b_4f38 ; $4db7
	jr Label_3b_4dbc ; $4dba
Label_3b_4dbc:
	ret ; $4dbc
Func_3b_4dbd:
	ld c, $0f ; $4dbd
	farcall FarPtr_39_00 ; $4dbf
	ld a, $03 ; $4dc2
	ldh [$ff96], a ; $4dc4
	ldh [rWBK], a ; $4dc6
	xor a, a ; $4dc8
	ld [$d800], a ; $4dc9
	ld a, $00 ; $4dcc
	ld [$d801], a ; $4dce
	ld a, $00 ; $4dd1
	ld [$d802], a ; $4dd3
	call Func_3b_4dff ; $4dd6
	ld a, $03 ; $4dd9
	ldh [$ff96], a ; $4ddb
	ldh [rWBK], a ; $4ddd
	ld de, $aac0 ; $4ddf
	call Func_3b_48f2 ; $4de2
	ld de, $a000 ; $4de5
	farcall FarPtr_39_18 ; $4de8
	ld b, $08 ; $4deb
	ld c, $0f ; $4ded
	farcall FarPtr_39_0e ; $4def
	call Func_3b_4f45 ; $4df2
	call Func_3b_4f81 ; $4df5
	call Func_3b_5000 ; $4df8
	farcall FarPtr_39_02 ; $4dfb
	ret ; $4dfe
Func_3b_4dff:
	ld a, $03 ; $4dff
	ldh [$ff96], a ; $4e01
	ldh [rWBK], a ; $4e03
	ld hl, $d800 ; $4e05
	ld bc, $0080 ; $4e08
	call ClearMemory16 ; $4e0b
	ld hl, $4e44 ; $4e0e
	ld de, $d810 ; $4e11
	ld bc, $0010 ; $4e14
	call CopyMemoryBC ; $4e17
	call Func_3b_493f ; $4e1a
	ld hl, $da58 ; $4e1d
	ld a, [hl] ; $4e20
	ld b, a ; $4e21
	and a, $01 ; $4e22
	jr nz, Label_3b_4e2b ; $4e24
	ld a, $10 ; $4e26
	ld [$d81e], a ; $4e28
Label_3b_4e2b:
	ld a, b ; $4e2b
	and a, $02 ; $4e2c
	jr nz, Label_3b_4e35 ; $4e2e
	ld a, $10 ; $4e30
	ld [$d81f], a ; $4e32
Label_3b_4e35:
	call Func_3b_4e54 ; $4e35
	call Func_3b_4ee3 ; $4e38
	or a, a ; $4e3b
	jr z, Label_3b_4e43 ; $4e3c
	ld a, $01 ; $4e3e
	ld [$d800], a ; $4e40
Label_3b_4e43:
	ret ; $4e43
	INCBIN "data/bank_03b/d_4e44.bin" ; $4e44, 16 bytes
Func_3b_4e54:
	ld de, $d830 ; $4e54
	ld hl, $d908 ; $4e57
	ld c, $00 ; $4e5a
Label_3b_4e5c:
	ld b, c ; $4e5c
	call Func_3b_4e74 ; $4e5d
	call Func_3b_4e97 ; $4e60
	push hl ; $4e63
	ld hl, $000c ; $4e64
	add hl, de ; $4e67
	ld d, h ; $4e68
	ld e, l ; $4e69
	pop hl ; $4e6a
	inc hl ; $4e6b
	ld a, c ; $4e6c
	inc a ; $4e6d
	ld c, a ; $4e6e
	cp a, $10 ; $4e6f
	jr nz, Label_3b_4e5c ; $4e71
	ret ; $4e73
Func_3b_4e74:
	ld a, b ; $4e74
	ld hl, $4e87 ; $4e75
	add a, l ; $4e78
	ld l, a ; $4e79
	jr nc, Label_3b_4e7d ; $4e7a
	inc h ; $4e7c
Label_3b_4e7d:
	ld a, [hl] ; $4e7d
	ld hl, $d908 ; $4e7e
	add a, l ; $4e81
	ld l, a ; $4e82
	jr nc, Label_3b_4e86 ; $4e83
	inc h ; $4e85
Label_3b_4e86:
	ret ; $4e86
	INCBIN "data/bank_03b/d_4e87.bin" ; $4e87, 16 bytes
Func_3b_4e97:
	push af ; $4e97
	push bc ; $4e98
	push de ; $4e99
	push hl ; $4e9a
	ld a, [hl] ; $4e9b
	and a, $03 ; $4e9c
	ld b, a ; $4e9e
	call Func_3b_4ed1 ; $4e9f
	inc de ; $4ea2
	inc de ; $4ea3
	inc de ; $4ea4
	ld a, [hl] ; $4ea5
	and a, $30 ; $4ea6
	swap a ; $4ea8
	ld b, a ; $4eaa
	call Func_3b_4ed1 ; $4eab
	inc de ; $4eae
	inc de ; $4eaf
	inc de ; $4eb0
	ld a, [hl] ; $4eb1
	and a, $0c ; $4eb2
	srl a ; $4eb4
	srl a ; $4eb6
	ld b, a ; $4eb8
	call Func_3b_4ed1 ; $4eb9
	inc de ; $4ebc
	inc de ; $4ebd
	inc de ; $4ebe
	ld a, [hl] ; $4ebf
	and a, $c0 ; $4ec0
	swap a ; $4ec2
	srl a ; $4ec4
	srl a ; $4ec6
	ld b, a ; $4ec8
	call Func_3b_4ed1 ; $4ec9
	pop hl ; $4ecc
	pop de ; $4ecd
	pop bc ; $4ece
	pop af ; $4ecf
	ret ; $4ed0
Func_3b_4ed1:
	push de ; $4ed1
	push bc ; $4ed2
Label_3b_4ed3:
	ld a, b ; $4ed3
	or a, a ; $4ed4
	jr z, Label_3b_4ee0 ; $4ed5
	ld a, $01 ; $4ed7
	ld [de], a ; $4ed9
	inc de ; $4eda
	ld a, b ; $4edb
	dec a ; $4edc
	ld b, a ; $4edd
	jr Label_3b_4ed3 ; $4ede
Label_3b_4ee0:
	pop bc ; $4ee0
	pop de ; $4ee1
	ret ; $4ee2
Func_3b_4ee3:
	ld hl, $d832 ; $4ee3
	ld c, $00 ; $4ee6
	ld de, $000c ; $4ee8
Label_3b_4eeb:
	ld a, [hl] ; $4eeb
	or a, a ; $4eec
	jr z, Label_3b_4f0b ; $4eed
	add hl, de ; $4eef
	ld a, c ; $4ef0
	inc a ; $4ef1
	ld c, a ; $4ef2
	cp a, $0e ; $4ef3
	jr nz, Label_3b_4eeb ; $4ef5
	ld hl, $d835 ; $4ef7
	ld c, $00 ; $4efa
	ld de, $000c ; $4efc
Label_3b_4eff:
	ld a, [hl] ; $4eff
	or a, a ; $4f00
	jr nz, Label_3b_4f33 ; $4f01
	add hl, de ; $4f03
	ld a, c ; $4f04
	inc a ; $4f05
	ld c, a ; $4f06
	cp a, $10 ; $4f07
	jr nz, Label_3b_4eff ; $4f09
Label_3b_4f0b:
	ld hl, $d835 ; $4f0b
	ld c, $00 ; $4f0e
	ld de, $000c ; $4f10
Label_3b_4f13:
	ld a, [hl] ; $4f13
	or a, a ; $4f14
	jr z, Label_3b_4f36 ; $4f15
	add hl, de ; $4f17
	ld a, c ; $4f18
	inc a ; $4f19
	ld c, a ; $4f1a
	cp a, $0e ; $4f1b
	jr nz, Label_3b_4f13 ; $4f1d
	ld hl, $d832 ; $4f1f
	ld c, $00 ; $4f22
	ld de, $000c ; $4f24
Label_3b_4f27:
	ld a, [hl] ; $4f27
	or a, a ; $4f28
	jr nz, Label_3b_4f33 ; $4f29
	add hl, de ; $4f2b
	ld a, c ; $4f2c
	inc a ; $4f2d
	ld c, a ; $4f2e
	cp a, $10 ; $4f2f
	jr nz, Label_3b_4f27 ; $4f31
Label_3b_4f33:
	ld a, $01 ; $4f33
	ret ; $4f35
Label_3b_4f36:
	xor a, a ; $4f36
	ret ; $4f37
Func_3b_4f38:
	call Func_3b_4f45 ; $4f38
	call Func_3b_4f81 ; $4f3b
	call Func_3b_5000 ; $4f3e
	call Func_3b_508d ; $4f41
	ret ; $4f44
Func_3b_4f45:
	push af ; $4f45
	push bc ; $4f46
	push de ; $4f47
	push hl ; $4f48
	ldh a, [$ff96] ; $4f49
	push af ; $4f4b
	ld a, $03 ; $4f4c
	ldh [$ff96], a ; $4f4e
	ldh [rWBK], a ; $4f50
	ld hl, $d810 ; $4f52
	ld a, [$d802] ; $4f55
	add a, l ; $4f58
	ld l, a ; $4f59
	jr nc, Label_3b_4f5d ; $4f5a
	inc h ; $4f5c
Label_3b_4f5d:
	ld d, h ; $4f5d
	ld e, l ; $4f5e
	ld c, $00 ; $4f5f
	ld hl, $d0e2 ; $4f61
Label_3b_4f64:
	ld a, [de] ; $4f64
	inc de ; $4f65
	ld b, a ; $4f66
	call Func_3b_48fa ; $4f67
	push de ; $4f6a
	ld de, $0040 ; $4f6b
	add hl, de ; $4f6e
	pop de ; $4f6f
	ld a, c ; $4f70
	inc a ; $4f71
	ld c, a ; $4f72
	cp a, $05 ; $4f73
	jr nz, Label_3b_4f64 ; $4f75
	pop af ; $4f77
	ldh [$ff96], a ; $4f78
	ldh [rWBK], a ; $4f7a
	pop hl ; $4f7c
	pop de ; $4f7d
	pop bc ; $4f7e
	pop af ; $4f7f
	ret ; $4f80
Func_3b_4f81:
	ldh a, [$ff96] ; $4f81
	push af ; $4f83
	ld a, $03 ; $4f84
	ldh [$ff96], a ; $4f86
	ldh [rWBK], a ; $4f88
	ld a, [$d801] ; $4f8a
	or a, a ; $4f8d
	jr nz, Label_3b_4fc6 ; $4f8e
	ld hl, $d240 ; $4f90
	ld de, $d0a5 ; $4f93
	ld b, $06 ; $4f96
	ld c, $02 ; $4f98
	farcall FarPtr_39_0a ; $4f9a
	ld hl, $d240 ; $4f9d
	ld de, $d0ac ; $4fa0
	ld b, $06 ; $4fa3
	ld c, $02 ; $4fa5
	farcall FarPtr_39_0a ; $4fa7
	ld hl, $d640 ; $4faa
	ld de, $d4a5 ; $4fad
	ld b, $06 ; $4fb0
	ld c, $02 ; $4fb2
	farcall FarPtr_39_0a ; $4fb4
	ld hl, $d640 ; $4fb7
	ld de, $d4ac ; $4fba
	ld b, $06 ; $4fbd
	ld c, $02 ; $4fbf
	farcall FarPtr_39_0a ; $4fc1
	jr Label_3b_4ffa ; $4fc4
Label_3b_4fc6:
	ld hl, $d246 ; $4fc6
	ld de, $d0a5 ; $4fc9
	ld b, $06 ; $4fcc
	ld c, $02 ; $4fce
	farcall FarPtr_39_0a ; $4fd0
	ld hl, $d246 ; $4fd3
	ld de, $d0ac ; $4fd6
	ld b, $06 ; $4fd9
	ld c, $02 ; $4fdb
	farcall FarPtr_39_0a ; $4fdd
	ld hl, $d646 ; $4fe0
	ld de, $d4a5 ; $4fe3
	ld b, $06 ; $4fe6
	ld c, $02 ; $4fe8
	farcall FarPtr_39_0a ; $4fea
	ld hl, $d646 ; $4fed
	ld de, $d4ac ; $4ff0
	ld b, $06 ; $4ff3
	ld c, $02 ; $4ff5
	farcall FarPtr_39_0a ; $4ff7
Label_3b_4ffa:
	pop af ; $4ffa
	ldh [$ff96], a ; $4ffb
	ldh [rWBK], a ; $4ffd
	ret ; $4fff
Func_3b_5000:
	ld a, $03 ; $5000
	ldh [$ff96], a ; $5002
	ldh [rWBK], a ; $5004
	ld a, [$d802] ; $5006
	add a, a ; $5009
	ld b, a ; $500a
	add a, a ; $500b
	add a, b ; $500c
	add a, a ; $500d
	ld hl, $d830 ; $500e
	add a, l ; $5011
	ld l, a ; $5012
	jr nc, Label_3b_5016 ; $5013
	inc h ; $5015
Label_3b_5016:
	ld a, [$d801] ; $5016
	or a, a ; $5019
	jr z, Label_3b_5023 ; $501a
	ld a, $06 ; $501c
	add a, l ; $501e
	ld l, a ; $501f
	jr nc, Label_3b_5023 ; $5020
	inc h ; $5022
Label_3b_5023:
	ld de, $d0e5 ; $5023
	ld c, $00 ; $5026
Label_3b_5028:
	call Func_3b_5042 ; $5028
	push hl ; $502b
	ld hl, $0040 ; $502c
	add hl, de ; $502f
	ld d, h ; $5030
	ld e, l ; $5031
	pop hl ; $5032
	ld a, $0c ; $5033
	add a, l ; $5035
	ld l, a ; $5036
	jr nc, Label_3b_503a ; $5037
	inc h ; $5039
Label_3b_503a:
	ld a, c ; $503a
	inc a ; $503b
	ld c, a ; $503c
	cp a, $05 ; $503d
	jr nz, Label_3b_5028 ; $503f
	ret ; $5041
Func_3b_5042:
	push af ; $5042
	push bc ; $5043
	push de ; $5044
	push hl ; $5045
	ld c, $00 ; $5046
Label_3b_5048:
	ld a, [hl+] ; $5048
	or a, a ; $5049
	jr z, Label_3b_5051 ; $504a
	call Func_3b_4ac9 ; $504c
	jr Label_3b_5054 ; $504f
Label_3b_5051:
	call Func_3b_507a ; $5051
Label_3b_5054:
	inc de ; $5054
	inc de ; $5055
	ld a, c ; $5056
	inc a ; $5057
	ld c, a ; $5058
	cp a, $03 ; $5059
	jr nz, Label_3b_5048 ; $505b
	inc de ; $505d
	ld c, $00 ; $505e
Label_3b_5060:
	ld a, [hl+] ; $5060
	or a, a ; $5061
	jr z, Label_3b_5069 ; $5062
	call Func_3b_4ac9 ; $5064
	jr Label_3b_506c ; $5067
Label_3b_5069:
	call Func_3b_507a ; $5069
Label_3b_506c:
	inc de ; $506c
	inc de ; $506d
	ld a, c ; $506e
	inc a ; $506f
	ld c, a ; $5070
	cp a, $03 ; $5071
	jr nz, Label_3b_5060 ; $5073
	pop hl ; $5075
	pop de ; $5076
	pop bc ; $5077
	pop af ; $5078
	ret ; $5079
Func_3b_507a:
	push af ; $507a
	push bc ; $507b
	push de ; $507c
	push hl ; $507d
	ld hl, $d24c ; $507e
	ld b, $02 ; $5081
	ld c, $02 ; $5083
	farcall FarPtr_39_0a ; $5085
	pop hl ; $5088
	pop de ; $5089
	pop bc ; $508a
	pop af ; $508b
	ret ; $508c
Func_3b_508d:
	ld hl, $d0a0 ; $508d
	ld de, $98a0 ; $5090
	ld c, $08 ; $5093
	call Func_00_0480 ; $5095
	ld hl, $d4a0 ; $5098
	ld de, $b8a0 ; $509b
	ld c, $08 ; $509e
	call Func_00_0480 ; $50a0
	call Func_00_2631 ; $50a3
	ld hl, $d120 ; $50a6
	ld de, $9920 ; $50a9
	ld c, $08 ; $50ac
	call Func_00_0480 ; $50ae
	ld hl, $d520 ; $50b1
	ld de, $b920 ; $50b4
	ld c, $08 ; $50b7
	call Func_00_0480 ; $50b9
	call Func_00_2631 ; $50bc
	ld hl, $d1a0 ; $50bf
	ld de, $99a0 ; $50c2
	ld c, $08 ; $50c5
	call Func_00_0480 ; $50c7
	ld hl, $d5a0 ; $50ca
	ld de, $b9a0 ; $50cd
	ld c, $08 ; $50d0
	call Func_00_0480 ; $50d2
	ret ; $50d5
	INCBIN "data/bank_03b/d_50d6.bin" ; $50d6, 114 bytes
Func_3b_5148:
	call DisableLCDSafely ; $5148
	sound $04 ; $514b
	call Func_3b_51b3 ; $514d
	xor a, a ; $5150
	ld [$cb0b], a ; $5151
	ld a, $01 ; $5154
	ld hl, $4428 ; $5156
	call Func_00_1b6a ; $5159
	ld a, $01 ; $515c
	ld hl, $5491 ; $515e
	call Func_00_1b6a ; $5161
	ld a, $01 ; $5164
	ld hl, $558f ; $5166
	call Func_00_1b6a ; $5169
	call EnableLCD ; $516c
	ld c, $10 ; $516f
	call Func_00_1d2e ; $5171
	call Func_00_1da4 ; $5174
	ld a, $03 ; $5177
	ldh [$ff96], a ; $5179
	ldh [rWBK], a ; $517b
Label_3b_517d:
	ldh a, [$ff91] ; $517d
	ld [$cb0d], a ; $517f
	call Func_3b_53c6 ; $5182
	call Func_00_2631 ; $5185
	ld a, [$cb0d] ; $5188
	bit 0, a ; $518b
	jr nz, Label_3b_5195 ; $518d
	bit 1, a ; $518f
	jr nz, Label_3b_51a3 ; $5191
	jr Label_3b_517d ; $5193
Label_3b_5195:
	sound $5f ; $5195
	ld c, $10 ; $5197
	call Func_00_1d20 ; $5199
	call Func_00_1da4 ; $519c
	call Func_00_1b38 ; $519f
	ret ; $51a2
Label_3b_51a3:
	sound $62 ; $51a3
	ld c, $10 ; $51a5
	call Func_00_1d20 ; $51a7
	call Func_00_1da4 ; $51aa
	call Func_00_1b38 ; $51ad
	ld a, $ff ; $51b0
	ret ; $51b2
Func_3b_51b3:
	xor a, a ; $51b3
	ld [$cb04], a ; $51b4
	ld [$cb05], a ; $51b7
	ld c, $12 ; $51ba
	farcall FarPtr_39_00 ; $51bc
	ld a, $03 ; $51bf
	ldh [$ff96], a ; $51c1
	ldh [rWBK], a ; $51c3
	call Func_3b_523e ; $51c5
	ld a, $03 ; $51c8
	ldh [$ff96], a ; $51ca
	ldh [rWBK], a ; $51cc
	ld de, $aac0 ; $51ce
	call Func_3b_48f2 ; $51d1
	ld de, $a000 ; $51d4
	farcall FarPtr_39_18 ; $51d7
	ld b, $08 ; $51da
	ld c, $0f ; $51dc
	farcall FarPtr_39_0e ; $51de
	ld de, $a100 ; $51e1
	ld b, $09 ; $51e4
	ld c, $00 ; $51e6
	farcall FarPtr_39_64 ; $51e8
	ld a, $09 ; $51eb
	ld [$cb6c], a ; $51ed
	ld a, $10 ; $51f0
	ld [$cb6b], a ; $51f2
	call Func_3b_5202 ; $51f5
	call Func_3b_5426 ; $51f8
	call Func_3b_54fe ; $51fb
	farcall FarPtr_39_02 ; $51fe
	ret ; $5201
Func_3b_5202:
	push af ; $5202
	push bc ; $5203
	push de ; $5204
	push hl ; $5205
	ldh a, [$ff96] ; $5206
	push af ; $5208
	ld a, $03 ; $5209
	ldh [$ff96], a ; $520b
	ldh [rWBK], a ; $520d
	ld hl, $dc40 ; $520f
	ld a, [$cb05] ; $5212
	add a, l ; $5215
	ld l, a ; $5216
	jr nc, Label_3b_521a ; $5217
	inc h ; $5219
Label_3b_521a:
	ld d, h ; $521a
	ld e, l ; $521b
	ld c, $00 ; $521c
	ld hl, $d0c2 ; $521e
Label_3b_5221:
	ld a, [de] ; $5221
	inc de ; $5222
	ld b, a ; $5223
	call Func_3b_48fa ; $5224
	push de ; $5227
	ld de, $0040 ; $5228
	add hl, de ; $522b
	pop de ; $522c
	ld a, c ; $522d
	inc a ; $522e
	ld c, a ; $522f
	cp a, $05 ; $5230
	jr nz, Label_3b_5221 ; $5232
	pop af ; $5234
	ldh [$ff96], a ; $5235
	ldh [rWBK], a ; $5237
	pop hl ; $5239
	pop de ; $523a
	pop bc ; $523b
	pop af ; $523c
	ret ; $523d
Func_3b_523e:
	ld a, $03 ; $523e
	ldh [$ff96], a ; $5240
	ldh [rWBK], a ; $5242
	call Func_3b_493f ; $5244
	ld hl, $5278 ; $5247
	ld de, $dc40 ; $524a
	ld bc, $0010 ; $524d
	call CopyMemoryBC ; $5250
	ld hl, $da58 ; $5253
	ld a, [hl] ; $5256
	ld b, a ; $5257
	and a, $01 ; $5258
	jr nz, Label_3b_5261 ; $525a
	ld a, $10 ; $525c
	ld [$dc4e], a ; $525e
Label_3b_5261:
	ld a, b ; $5261
	and a, $02 ; $5262
	jr nz, Label_3b_526b ; $5264
	ld a, $10 ; $5266
	ld [$dc4f], a ; $5268
Label_3b_526b:
	ld hl, $db00 ; $526b
	ld bc, $0140 ; $526e
	call ClearBytes ; $5271
	call Func_3b_5319 ; $5274
	ret ; $5277
	INCBIN "data/bank_03b/d_5278.bin" ; $5278, 161 bytes
Func_3b_5319:
	ld de, $db00 ; $5319
	ld c, $00 ; $531c
Label_3b_531e:
	ld hl, $5358 ; $531e
	ld a, c ; $5321
	add a, l ; $5322
	ld l, a ; $5323
	jr nc, Label_3b_5327 ; $5324
	inc h ; $5326
Label_3b_5327:
	ld b, [hl] ; $5327
	call Func_3b_538e ; $5328
	ld hl, $000c ; $532b
	add hl, de ; $532e
	ld d, h ; $532f
	ld e, l ; $5330
	ld a, c ; $5331
	inc a ; $5332
	ld c, a ; $5333
	cp a, $10 ; $5334
	jr nz, Label_3b_531e ; $5336
	ld de, $db04 ; $5338
	ld c, $00 ; $533b
Label_3b_533d:
	ld hl, $5358 ; $533d
	ld a, c ; $5340
	add a, l ; $5341
	ld l, a ; $5342
	jr nc, Label_3b_5346 ; $5343
	inc h ; $5345
Label_3b_5346:
	ld b, [hl] ; $5346
	call Func_3b_5368 ; $5347
	ld hl, $000c ; $534a
	add hl, de ; $534d
	ld d, h ; $534e
	ld e, l ; $534f
	ld a, c ; $5350
	inc a ; $5351
	ld c, a ; $5352
	cp a, $10 ; $5353
	jr nz, Label_3b_533d ; $5355
	ret ; $5357
	INCBIN "data/bank_03b/d_5358.bin" ; $5358, 16 bytes
Func_3b_5368:
	push af ; $5368
	push bc ; $5369
	push de ; $536a
	push hl ; $536b
	ld a, b ; $536c
	add a, a ; $536d
	add a, a ; $536e
	add a, a ; $536f
	ld hl, $d958 ; $5370
	add a, l ; $5373
	ld l, a ; $5374
	jr nc, Label_3b_5378 ; $5375
	inc h ; $5377
Label_3b_5378:
	ld c, $00 ; $5378
Label_3b_537a:
	ld a, [hl+] ; $537a
	ld b, a ; $537b
	ld a, [hl+] ; $537c
	ld [de], a ; $537d
	inc de ; $537e
	ld a, b ; $537f
	ld [de], a ; $5380
	inc de ; $5381
	ld a, c ; $5382
	inc a ; $5383
	ld c, a ; $5384
	cp a, $04 ; $5385
	jr nz, Label_3b_537a ; $5387
	pop hl ; $5389
	pop de ; $538a
	pop bc ; $538b
	pop af ; $538c
	ret ; $538d
Func_3b_538e:
	push af ; $538e
	push bc ; $538f
	push de ; $5390
	push hl ; $5391
	ld a, b ; $5392
	add a, a ; $5393
	add a, a ; $5394
	ld hl, $d918 ; $5395
	add a, l ; $5398
	ld l, a ; $5399
	jr nc, Label_3b_539d ; $539a
	inc h ; $539c
Label_3b_539d:
	ld c, $00 ; $539d
Label_3b_539f:
	ld b, [hl] ; $539f
	call Func_3b_53b2 ; $53a0
	ld [de], a ; $53a3
	inc de ; $53a4
	inc hl ; $53a5
	ld a, c ; $53a6
	inc a ; $53a7
	ld c, a ; $53a8
	cp a, $04 ; $53a9
	jr nz, Label_3b_539f ; $53ab
	pop hl ; $53ad
	pop de ; $53ae
	pop bc ; $53af
	pop af ; $53b0
	ret ; $53b1
Func_3b_53b2:
	push bc ; $53b2
	ld c, $00 ; $53b3
Label_3b_53b5:
	ld a, b ; $53b5
	and a, $01 ; $53b6
	jr z, Label_3b_53c3 ; $53b8
	srl b ; $53ba
	ld a, c ; $53bc
	inc a ; $53bd
	ld c, a ; $53be
	cp a, $06 ; $53bf
	jr nz, Label_3b_53b5 ; $53c1
Label_3b_53c3:
	ld a, c ; $53c3
	pop bc ; $53c4
	ret ; $53c5
Func_3b_53c6:
	ld a, [$cb0d] ; $53c6
	bit 4, a ; $53c9
	jr nz, Label_3b_53da ; $53cb
	bit 5, a ; $53cd
	jr nz, Label_3b_53ea ; $53cf
	bit 6, a ; $53d1
	jr nz, Label_3b_53f9 ; $53d3
	bit 7, a ; $53d5
	jr nz, Label_3b_5408 ; $53d7
	ret ; $53d9
Label_3b_53da:
	ld a, [$cb04] ; $53da
	cp a, $03 ; $53dd
	jr z, Label_3b_5416 ; $53df
	inc a ; $53e1
	ld [$cb04], a ; $53e2
	call Func_3b_5417 ; $53e5
	jr Label_3b_5416 ; $53e8
Label_3b_53ea:
	ld a, [$cb04] ; $53ea
	or a, a ; $53ed
	jr z, Label_3b_5416 ; $53ee
	dec a ; $53f0
	ld [$cb04], a ; $53f1
	call Func_3b_5417 ; $53f4
	jr Label_3b_5416 ; $53f7
Label_3b_53f9:
	ld a, [$cb05] ; $53f9
	or a, a ; $53fc
	jr z, Label_3b_5416 ; $53fd
	dec a ; $53ff
	ld [$cb05], a ; $5400
	call Func_3b_5417 ; $5403
	jr Label_3b_5416 ; $5406
Label_3b_5408:
	ld a, [$cb05] ; $5408
	cp a, $0b ; $540b
	jr z, Label_3b_5416 ; $540d
	inc a ; $540f
	ld [$cb05], a ; $5410
	call Func_3b_5417 ; $5413
Label_3b_5416:
	ret ; $5416
Func_3b_5417:
	sound $5e ; $5417
	call Func_3b_5202 ; $5419
	call Func_3b_54fe ; $541c
	call Func_3b_5426 ; $541f
	call Func_3b_5456 ; $5422
	ret ; $5425
Func_3b_5426:
	ldh a, [$ff96] ; $5426
	push af ; $5428
	ld a, $03 ; $5429
	ldh [$ff96], a ; $542b
	ldh [rWBK], a ; $542d
	ld a, [$cb04] ; $542f
	add a, a ; $5432
	ld hl, $544e ; $5433
	add a, l ; $5436
	ld l, a ; $5437
	jr nc, Label_3b_543b ; $5438
	inc h ; $543a
Label_3b_543b:
	ld a, [hl+] ; $543b
	ld h, [hl] ; $543c
	ld l, a ; $543d
	ld de, $d026 ; $543e
	ld b, $08 ; $5441
	ld c, $02 ; $5443
	farcall FarPtr_39_0a ; $5445
	pop af ; $5448
	ldh [$ff96], a ; $5449
	ldh [rWBK], a ; $544b
	ret ; $544d
	INCBIN "data/bank_03b/d_544e.bin" ; $544e, 8 bytes
Func_3b_5456:
	ld hl, $d020 ; $5456
	ld de, $9820 ; $5459
	ld c, $04 ; $545c
	call Func_00_0480 ; $545e
	ld hl, $d0c0 ; $5461
	ld de, $98c0 ; $5464
	ld c, $08 ; $5467
	call Func_00_0480 ; $5469
	ld hl, $d4c0 ; $546c
	ld de, $b8c0 ; $546f
	ld c, $08 ; $5472
	call Func_00_0480 ; $5474
	call Func_00_2631 ; $5477
	ld hl, $d140 ; $547a
	ld de, $9940 ; $547d
	ld c, $0c ; $5480
	call Func_00_0480 ; $5482
	ld hl, $d540 ; $5485
	ld de, $b940 ; $5488
	ld c, $0c ; $548b
	call Func_00_0480 ; $548d
	ret ; $5490
	INCBIN "data/bank_03b/d_5491.bin" ; $5491, 109 bytes
Func_3b_54fe:
	ld a, [$cb05] ; $54fe
	ld hl, $db00 ; $5501
	ld bc, $000c ; $5504
Label_3b_5507:
	or a, a ; $5507
	jr z, Label_3b_550e ; $5508
	add hl, bc ; $550a
	dec a ; $550b
	jr Label_3b_5507 ; $550c
Label_3b_550e:
	ld a, [$cb04] ; $550e
	add a, l ; $5511
	ld l, a ; $5512
	jr nc, Label_3b_5516 ; $5513
	inc h ; $5515
Label_3b_5516:
	ld b, $00 ; $5516
Label_3b_5518:
	ld a, [hl] ; $5518
	ld c, a ; $5519
	call Func_3b_5529 ; $551a
	ld de, $000c ; $551d
	add hl, de ; $5520
	ld a, b ; $5521
	inc a ; $5522
	ld b, a ; $5523
	cp a, $05 ; $5524
	jr nz, Label_3b_5518 ; $5526
	ret ; $5528
Func_3b_5529:
	push af ; $5529
	push bc ; $552a
	push de ; $552b
	push hl ; $552c
	ld a, b ; $552d
	add a, a ; $552e
	ld hl, $5564 ; $552f
	add a, l ; $5532
	ld l, a ; $5533
	jr nc, Label_3b_5537 ; $5534
	inc h ; $5536
Label_3b_5537:
	ld a, [hl+] ; $5537
	ld d, [hl] ; $5538
	ld e, a ; $5539
	ld b, c ; $553a
Label_3b_553b:
	ld a, b ; $553b
	or a, a ; $553c
	jr z, Label_3b_554b ; $553d
	ld h, b ; $553f
	ld b, $00 ; $5540
	call Func_3b_556e ; $5542
	inc de ; $5545
	inc de ; $5546
	ld b, h ; $5547
	dec b ; $5548
	jr Label_3b_553b ; $5549
Label_3b_554b:
	ld a, $05 ; $554b
	sub a, c ; $554d
	ld b, a ; $554e
Label_3b_554f:
	ld a, b ; $554f
	or a, a ; $5550
	jr z, Label_3b_555f ; $5551
	ld h, b ; $5553
	ld b, $01 ; $5554
	call Func_3b_556e ; $5556
	inc de ; $5559
	inc de ; $555a
	ld b, h ; $555b
	dec b ; $555c
	jr Label_3b_554f ; $555d
Label_3b_555f:
	pop hl ; $555f
	pop de ; $5560
	pop bc ; $5561
	pop af ; $5562
	ret ; $5563
	INCBIN "data/bank_03b/d_5564.bin" ; $5564, 10 bytes
Func_3b_556e:
	push af ; $556e
	push bc ; $556f
	push de ; $5570
	push hl ; $5571
	ld a, b ; $5572
	add a, a ; $5573
	ld hl, $558b ; $5574
	add a, l ; $5577
	ld l, a ; $5578
	jr nc, Label_3b_557c ; $5579
	inc h ; $557b
Label_3b_557c:
	ld a, [hl+] ; $557c
	ld h, [hl] ; $557d
	ld l, a ; $557e
	ld b, $02 ; $557f
	ld c, $02 ; $5581
	farcall FarPtr_39_0a ; $5583
	pop hl ; $5586
	pop de ; $5587
	pop bc ; $5588
	pop af ; $5589
	ret ; $558a
	INCBIN "data/bank_03b/d_558b.bin" ; $558b, 70 bytes
Func_3b_55d1:
	call Func_00_28b9 ; $55d1
	sound $03 ; $55d4
	ld hl, rIE ; $55d6
	res 2, [hl] ; $55d9
	call Func_3b_5aac ; $55db
	xor a, a ; $55de
	ld [$cb1a], a ; $55df
	call Func_3b_56c4 ; $55e2
	farcall FarPtr_39_24 ; $55e5
	ld b, $01 ; $55e8
	ld c, $01 ; $55ea
	farcall FarPtr_39_26 ; $55ec
	ld b, $03 ; $55ef
	ld a, [$cb1b] ; $55f1
	ld c, a ; $55f4
	call Func_3b_43db ; $55f5
	ld a, $00 ; $55f8
	ld [$cb16], a ; $55fa
	ld a, $01 ; $55fd
	ld [$cb18], a ; $55ff
	ld a, $03 ; $5602
	ldh [$ff96], a ; $5604
	ldh [rWBK], a ; $5606
	ld a, [$cb11] ; $5608
	ld b, a ; $560b
	call Func_3b_5800 ; $560c
	ld a, $7f ; $560f
	ld hl, $5863 ; $5611
	call Func_00_1b6a ; $5614
	call Func_3b_5968 ; $5617
	call Func_00_28f8 ; $561a
	farcall FarPtr_39_68 ; $561d
	ld a, $03 ; $5620
	ldh [$ff96], a ; $5622
	ldh [rWBK], a ; $5624
Label_3b_5626:
	call Func_00_2631 ; $5626
	farcall FarPtr_39_6a ; $5629
	ldh a, [$ff91] ; $562c
	ld [$cb0d], a ; $562e
	ld b, $03 ; $5631
	ld c, $03 ; $5633
	call Func_3b_412a ; $5635
	or a, a ; $5638
	jr nz, Label_3b_563d ; $5639
	jr Label_3b_5642 ; $563b
Label_3b_563d:
	sound $5e ; $563d
	call Func_3b_5968 ; $563f
Label_3b_5642:
	ld a, [$cb0d] ; $5642
	bit 0, a ; $5645
	jr nz, Label_3b_5655 ; $5647
	bit 1, a ; $5649
	jr nz, Label_3b_5696 ; $564b
	bit 2, a ; $564d
	jr nz, Label_3b_5653 ; $564f
	jr Label_3b_5626 ; $5651
Label_3b_5653:
	jr Label_3b_5626 ; $5653
Label_3b_5655:
	ld a, $01 ; $5655
	ld [$cb71], a ; $5657
	sound $5f ; $565a
	call Func_00_1b38 ; $565c
	ld hl, rIE ; $565f
	set 2, [hl] ; $5662
	ld b, $01 ; $5664
	call Func_3b_5832 ; $5666
	ld a, [$cb04] ; $5669
	cp a, $02 ; $566c
	jr nz, Label_3b_5685 ; $566e
	ld a, [$cb05] ; $5670
	cp a, $00 ; $5673
	jr nz, Label_3b_5685 ; $5675
	ld c, $03 ; $5677
	call Func_3b_43b9 ; $5679
	ld [$cb1b], a ; $567c
	call Func_3b_5c53 ; $567f
	jp c, Func_3b_55d1 ; $5682
Label_3b_5685:
	ld a, $01 ; $5685
	ld [$cb11], a ; $5687
	ld c, $03 ; $568a
	call Func_3b_43b9 ; $568c
	ld [$cb1b], a ; $568f
	call Func_3b_56b0 ; $5692
	ret ; $5695
Label_3b_5696:
	sound $62 ; $5696
	call Func_00_28f8 ; $5698
	call Func_00_1b38 ; $569b
	ld hl, rIE ; $569e
	set 2, [hl] ; $56a1
	ld b, $00 ; $56a3
	call Func_3b_5832 ; $56a5
	ld a, $00 ; $56a8
	ld [$cb11], a ; $56aa
	ld a, $ff ; $56ad
	ret ; $56af
Func_3b_56b0:
	ld hl, $56ba ; $56b0
	add a, l ; $56b3
	ld l, a ; $56b4
	jr nc, Label_3b_56b8 ; $56b5
	inc h ; $56b7
Label_3b_56b8:
	ld a, [hl] ; $56b8
	ret ; $56b9
	INCBIN "data/bank_03b/d_56ba.bin" ; $56ba, 10 bytes
Func_3b_56c4:
	ldh a, [$ff96] ; $56c4
	push af ; $56c6
	ld a, $01 ; $56c7
	ldh [$ff96], a ; $56c9
	ldh [rWBK], a ; $56cb
	ld c, $00 ; $56cd
Label_3b_56cf:
	ld a, c ; $56cf
	add a, a ; $56d0
	ld hl, $57e0 ; $56d1
	add a, l ; $56d4
	ld l, a ; $56d5
	jr nc, Label_3b_56d9 ; $56d6
	inc h ; $56d8
Label_3b_56d9:
	ld a, [hl+] ; $56d9
	ld h, [hl] ; $56da
	ld l, a ; $56db
	push af ; $56dc
	push bc ; $56dd
	push de ; $56de
	push hl ; $56df
	ld de, $d000 ; $56e0
	call DecompressDataFromBank ; $56e3
	pop hl ; $56e6
	pop de ; $56e7
	pop bc ; $56e8
	pop af ; $56e9
	ld hl, $57ec ; $56ea
	ld a, c ; $56ed
	add a, a ; $56ee
	add a, l ; $56ef
	ld l, a ; $56f0
	jr nc, Label_3b_56f4 ; $56f1
	inc h ; $56f3
Label_3b_56f4:
	ld a, [hl+] ; $56f4
	ld d, [hl] ; $56f5
	ld e, a ; $56f6
	ld hl, $d000 ; $56f7
	push af ; $56fa
	push bc ; $56fb
	push de ; $56fc
	push hl ; $56fd
	ld bc, $0010 ; $56fe
	call Func_00_0480 ; $5701
	pop hl ; $5704
	pop de ; $5705
	pop bc ; $5706
	pop af ; $5707
	ld a, c ; $5708
	inc a ; $5709
	ld c, a ; $570a
	call Func_00_2631 ; $570b
	ld a, c ; $570e
	cp a, $06 ; $570f
	jr nz, Label_3b_56cf ; $5711
	ld a, $03 ; $5713
	ldh [$ff96], a ; $5715
	ldh [rWBK], a ; $5717
	ld a, $00 ; $5719
	ld [$c36c], a ; $571b
	ld a, [$d300] ; $571e
	farcall FarPtr_1b_10 ; $5721
	ld de, $b680 ; $5724
	farcall FarPtr_1b_18 ; $5727
	call Func_00_2631 ; $572a
	ld a, $03 ; $572d
	ldh [$ff96], a ; $572f
	ldh [rWBK], a ; $5731
	ld a, $01 ; $5733
	ld [$c36c], a ; $5735
	ld a, [$d310] ; $5738
	farcall FarPtr_1b_10 ; $573b
	ld de, $b710 ; $573e
	farcall FarPtr_1b_18 ; $5741
	call Func_00_2631 ; $5744
	ld a, $03 ; $5747
	ldh [$ff96], a ; $5749
	ldh [rWBK], a ; $574b
	ld a, $02 ; $574d
	ld [$c36c], a ; $574f
	ld a, [$d320] ; $5752
	farcall FarPtr_1b_10 ; $5755
	ld de, $af00 ; $5758
	farcall FarPtr_1b_18 ; $575b
	call Func_00_2631 ; $575e
	ld b, $1c ; $5761
	ld c, $10 ; $5763
	ld de, $a000 ; $5765
	farcall FarPtr_39_10 ; $5768
	call Func_00_2631 ; $576b
	ld b, $1d ; $576e
	ld c, $10 ; $5770
	ld de, $a100 ; $5772
	farcall FarPtr_39_10 ; $5775
	call Func_00_2631 ; $5778
	ld b, $1e ; $577b
	ld c, $12 ; $577d
	ld de, $a200 ; $577f
	farcall FarPtr_39_10 ; $5782
	call Func_00_2631 ; $5785
	ld b, $1f ; $5788
	ld c, $10 ; $578a
	ld de, $a320 ; $578c
	farcall FarPtr_39_10 ; $578f
	call Func_00_2631 ; $5792
	ld b, $20 ; $5795
	ld c, $10 ; $5797
	ld de, $a420 ; $5799
	farcall FarPtr_39_10 ; $579c
	call Func_00_2631 ; $579f
	ld b, $21 ; $57a2
	ld c, $10 ; $57a4
	ld de, $a520 ; $57a6
	farcall FarPtr_39_10 ; $57a9
	call Func_00_2631 ; $57ac
	ld b, $22 ; $57af
	ld c, $10 ; $57b1
	ld de, $a620 ; $57b3
	farcall FarPtr_39_10 ; $57b6
	call Func_00_2631 ; $57b9
	ld b, $1b ; $57bc
	ld c, $04 ; $57be
	ld de, $a720 ; $57c0
	farcall FarPtr_39_10 ; $57c3
	ld b, $08 ; $57c6
	ld c, $10 ; $57c8
	farcall FarPtr_39_0e ; $57ca
	call Func_00_2631 ; $57cd
	ld b, $3e ; $57d0
	ld c, $14 ; $57d2
	ld de, $8000 ; $57d4
	farcall FarPtr_39_10 ; $57d7
	pop af ; $57da
	ldh [$ff96], a ; $57db
	ldh [rWBK], a ; $57dd
	ret ; $57df
	INCBIN "data/bank_03b/d_57e0.bin" ; $57e0, 32 bytes
Func_3b_5800:
	ld a, b ; $5800
	or a, a ; $5801
	jr z, Label_3b_581b ; $5802
	ld c, $00 ; $5804
Label_3b_5806:
	call Func_00_2631 ; $5806
	ld b, $00 ; $5809
	farcall FarPtr_39_20 ; $580b
	ld b, $00 ; $580e
	farcall FarPtr_39_1e ; $5810
	ld a, c ; $5813
	inc a ; $5814
	ld c, a ; $5815
	cp a, $10 ; $5816
	jr nz, Label_3b_5806 ; $5818
	ret ; $581a
Label_3b_581b:
	ld c, $09 ; $581b
Label_3b_581d:
	call Func_00_2631 ; $581d
	ld b, $01 ; $5820
	farcall FarPtr_39_20 ; $5822
	ld b, $00 ; $5825
	farcall FarPtr_39_1e ; $5827
	ld a, c ; $582a
	dec a ; $582b
	ld c, a ; $582c
	cp a, $ff ; $582d
	jr nz, Label_3b_581d ; $582f
	ret ; $5831
Func_3b_5832:
	ld a, b ; $5832
	or a, a ; $5833
	jr z, Label_3b_584d ; $5834
	ld c, $00 ; $5836
Label_3b_5838:
	call Func_00_2631 ; $5838
	ld b, $01 ; $583b
	farcall FarPtr_39_20 ; $583d
	ld b, $00 ; $5840
	farcall FarPtr_39_1e ; $5842
	ld a, c ; $5845
	inc a ; $5846
	ld c, a ; $5847
	cp a, $0c ; $5848
	jr nz, Label_3b_5838 ; $584a
	ret ; $584c
Label_3b_584d:
	ld c, $0f ; $584d
Label_3b_584f:
	call Func_00_2631 ; $584f
	ld b, $00 ; $5852
	farcall FarPtr_39_20 ; $5854
	ld b, $00 ; $5857
	farcall FarPtr_39_1e ; $5859
	ld a, c ; $585c
	dec a ; $585d
	ld c, a ; $585e
	or a, a ; $585f
	jr nz, Label_3b_584f ; $5860
	ret ; $5862
	farcall FarPtr_39_28 ; $5863
	ld c, $03 ; $5866
	call Func_3b_43b9 ; $5868
	push af ; $586b
	ld hl, $592d ; $586c
	add a, l ; $586f
	ld l, a ; $5870
	jr nc, Label_3b_5874 ; $5871
	inc h ; $5873
Label_3b_5874:
	ld c, [hl] ; $5874
	ld hl, $591b ; $5875
	pop af ; $5878
	add a, a ; $5879
	push af ; $587a
	add a, l ; $587b
	ld l, a ; $587c
	jr nc, Label_3b_5880 ; $587d
	inc h ; $587f
Label_3b_5880:
	ld a, [hl+] ; $5880
	ld d, [hl] ; $5881
	ld e, a ; $5882
	farcall FarPtr_39_16 ; $5883
	pop af ; $5886
	ld hl, $58ba ; $5887
	add a, l ; $588a
	ld l, a ; $588b
	jr nc, Label_3b_588f ; $588c
	inc h ; $588e
Label_3b_588f:
	ld a, [hl+] ; $588f
	ld h, [hl] ; $5890
	ld l, a ; $5891
	ld b, $08 ; $5892
	push de ; $5894
	call Func_00_1e9d ; $5895
	ld c, $03 ; $5898
	call Func_3b_43b9 ; $589a
	ld hl, $5936 ; $589d
	add a, l ; $58a0
	ld l, a ; $58a1
	jr nc, Label_3b_58a5 ; $58a2
	inc h ; $58a4
Label_3b_58a5:
	ld a, [hl] ; $58a5
	pop de ; $58a6
	ld hl, $17f8 ; $58a7
	add hl, de ; $58aa
	ld d, h ; $58ab
	ld e, l ; $58ac
	add a, d ; $58ad
	ld d, a ; $58ae
	ld hl, $5912 ; $58af
	ld b, $08 ; $58b2
	ld c, $72 ; $58b4
	call Func_00_1e9d ; $58b6
	ret ; $58b9
	INCBIN "data/bank_03b/d_58ba.bin" ; $58ba, 174 bytes
Func_3b_5968:
	ld a, $03 ; $5968
	ldh [$ff96], a ; $596a
	ldh [rWBK], a ; $596c
	ld b, $00 ; $596e
	ld c, $00 ; $5970
Label_3b_5972:
	call Func_3b_5a09 ; $5972
	ld a, b ; $5975
	inc a ; $5976
	ld b, a ; $5977
	cp a, $09 ; $5978
	jr nz, Label_3b_5972 ; $597a
	ld c, $03 ; $597c
	call Func_3b_43b9 ; $597e
	ld b, a ; $5981
	ld c, $01 ; $5982
	call Func_3b_5a09 ; $5984
	ld c, $03 ; $5987
	call Func_3b_43b9 ; $5989
	cp a, $06 ; $598c
	jr nc, Label_3b_59ae ; $598e
	cp a, $03 ; $5990
	jr c, Label_3b_59ae ; $5992
	sub a, $03 ; $5994
	add a, a ; $5996
	add a, a ; $5997
	add a, a ; $5998
	add a, a ; $5999
	ld bc, $d300 ; $599a
	add a, c ; $599d
	ld c, a ; $599e
	jr nc, Label_3b_59a2 ; $599f
	inc b ; $59a1
Label_3b_59a2:
	ld hl, $0001 ; $59a2
	add hl, bc ; $59a5
	ld a, [hl] ; $59a6
	ld d, $04 ; $59a7
	farcall FarPtr_18_02 ; $59a9
	jr Label_3b_59b1 ; $59ac
Label_3b_59ae:
	call Func_3b_5a57 ; $59ae
Label_3b_59b1:
	ld a, $03 ; $59b1
	ldh [$ff96], a ; $59b3
	ldh [rWBK], a ; $59b5
	ld de, $d1e0 ; $59b7
	ld b, $14 ; $59ba
	ld c, $01 ; $59bc
	ld h, $03 ; $59be
	farcall FarPtr_39_0c ; $59c0
	ld a, $02 ; $59c3
	ld [$d1e0], a ; $59c5
	ld a, $04 ; $59c8
	ld [$d1f3], a ; $59ca
	ld de, $d201 ; $59cd
	ld b, $12 ; $59d0
	ld c, $01 ; $59d2
	ld h, $20 ; $59d4
	farcall FarPtr_39_0c ; $59d6
	call Func_3b_5b3e ; $59d9
	ld hl, $d460 ; $59dc
	ld de, $b860 ; $59df
	ld c, $06 ; $59e2
	call Func_00_0480 ; $59e4
	ld hl, $d4e0 ; $59e7
	ld de, $b8e0 ; $59ea
	ld c, $06 ; $59ed
	call Func_00_0480 ; $59ef
	ld hl, $d560 ; $59f2
	ld de, $b960 ; $59f5
	ld c, $06 ; $59f8
	call Func_00_0480 ; $59fa
	ld hl, $d1e0 ; $59fd
	ld de, $99e0 ; $5a00
	ld c, $04 ; $5a03
	call Func_00_0480 ; $5a05
	ret ; $5a08
Func_3b_5a09:
	push af ; $5a09
	push bc ; $5a0a
	push de ; $5a0b
	push hl ; $5a0c
	ld d, c ; $5a0d
	ld e, b ; $5a0e
	ld a, b ; $5a0f
	cp a, $06 ; $5a10
	jr nc, Label_3b_5a1e ; $5a12
	cp a, $03 ; $5a14
	jr c, Label_3b_5a1e ; $5a16
	ld b, $03 ; $5a18
	ld c, $03 ; $5a1a
	jr Label_3b_5a22 ; $5a1c
Label_3b_5a1e:
	ld b, $05 ; $5a1e
	ld c, $03 ; $5a20
Label_3b_5a22:
	ld a, d ; $5a22
	or a, a ; $5a23
	jr z, Label_3b_5a2a ; $5a24
	ld h, $0c ; $5a26
	jr Label_3b_5a2c ; $5a28
Label_3b_5a2a:
	ld h, $0d ; $5a2a
Label_3b_5a2c:
	push hl ; $5a2c
	ld hl, $5a43 ; $5a2d
	ld a, e ; $5a30
	add a, a ; $5a31
	add a, l ; $5a32
	ld l, a ; $5a33
	jr nc, Label_3b_5a37 ; $5a34
	inc h ; $5a36
Label_3b_5a37:
	ld a, [hl+] ; $5a37
	ld d, [hl] ; $5a38
	ld e, a ; $5a39
	pop hl ; $5a3a
	farcall FarPtr_39_0c ; $5a3b
	pop hl ; $5a3e
	pop de ; $5a3f
	pop bc ; $5a40
	pop af ; $5a41
	ret ; $5a42
	INCBIN "data/bank_03b/d_5a43.bin" ; $5a43, 20 bytes
Func_3b_5a57:
	ld hl, $5a6a ; $5a57
	add a, a ; $5a5a
	add a, l ; $5a5b
	ld l, a ; $5a5c
	jr nc, Label_3b_5a60 ; $5a5d
	inc h ; $5a5f
Label_3b_5a60:
	ld a, [hl+] ; $5a60
	ld h, [hl] ; $5a61
	ld l, a ; $5a62
	ld de, $0401 ; $5a63
	call LoadPaletteShadow ; $5a66
	ret ; $5a69
	INCBIN "data/bank_03b/d_5a6a.bin" ; $5a6a, 66 bytes
Func_3b_5aac:
	ldh a, [$ff96] ; $5aac
	push af ; $5aae
	ld a, $03 ; $5aaf
	ldh [$ff96], a ; $5ab1
	ldh [rWBK], a ; $5ab3
	ld hl, $d300 ; $5ab5
	ld bc, $0003 ; $5ab8
	call ClearMemory16 ; $5abb
	ld bc, $d300 ; $5abe
	ld a, $80 ; $5ac1
Label_3b_5ac3:
	push af ; $5ac3
	push af ; $5ac4
	ld a, $02 ; $5ac5
	ldh [$ff96], a ; $5ac7
	ldh [rWBK], a ; $5ac9
	pop af ; $5acb
	farcall FarPtr_18_24 ; $5acc
	farcall FarPtr_18_26 ; $5acf
	ld hl, $0000 ; $5ad2
	add hl, bc ; $5ad5
	ld a, $02 ; $5ad6
	ldh [$ff96], a ; $5ad8
	ldh [rWBK], a ; $5ada
	ld a, [$d58b] ; $5adc
	push af ; $5adf
	ld a, $03 ; $5ae0
	ldh [$ff96], a ; $5ae2
	ldh [rWBK], a ; $5ae4
	pop af ; $5ae6
	cp a, $04 ; $5ae7
	jr c, Label_3b_5af8 ; $5ae9
	ld [hl], a ; $5aeb
	inc hl ; $5aec
	ld a, $03 ; $5aed
	ld [hl-], a ; $5aef
	ld hl, $0010 ; $5af0
	add hl, bc ; $5af3
	ld b, h ; $5af4
	ld c, l ; $5af5
	jr Label_3b_5b32 ; $5af6
Label_3b_5af8:
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $5af8
	ld [hl], a ; $5afb
	ld hl, $0001 ; $5afc
	add hl, bc ; $5aff
	ld a, [wStoryModeMainCharacterOverworldSpriteColor] ; $5b00
	ld [hl], a ; $5b03
	ld hl, $0002 ; $5b04
	add hl, bc ; $5b07
	ld a, [$c918] ; $5b08
	ld [hl], a ; $5b0b
	push bc ; $5b0c
	ld a, $03 ; $5b0d
	add a, c ; $5b0f
	ld e, a ; $5b10
	ld d, b ; $5b11
	ld hl, $c900 ; $5b12
	ld bc, $000b ; $5b15
	call CopyMemoryBC ; $5b18
	pop bc ; $5b1b
	ld hl, $000f ; $5b1c
	add hl, bc ; $5b1f
	ld a, [$c891] ; $5b20
	ld [hl], a ; $5b23
	ld hl, $000e ; $5b24
	add hl, bc ; $5b27
	ld a, [$c890] ; $5b28
	ld [hl], a ; $5b2b
	ld hl, $0010 ; $5b2c
	add hl, bc ; $5b2f
	ld b, h ; $5b30
	ld c, l ; $5b31
Label_3b_5b32:
	pop af ; $5b32
	inc a ; $5b33
	cp a, $83 ; $5b34
	jr nz, Label_3b_5ac3 ; $5b36
	pop af ; $5b38
	ldh [$ff96], a ; $5b39
	ldh [rWBK], a ; $5b3b
	ret ; $5b3d
Func_3b_5b3e:
	ldh a, [$ff96] ; $5b3e
	push af ; $5b40
	ld a, $03 ; $5b41
	ldh [$ff96], a ; $5b43
	ldh [rWBK], a ; $5b45
	ld c, $03 ; $5b47
	call Func_3b_43b9 ; $5b49
	ld b, a ; $5b4c
	cp a, $06 ; $5b4d
	jp nc, Label_3b_5bdd ; $5b4f
	cp a, $03 ; $5b52
	jp c, Label_3b_5bdd ; $5b54
	sub a, $03 ; $5b57
	add a, a ; $5b59
	add a, a ; $5b5a
	add a, a ; $5b5b
	add a, a ; $5b5c
	ld bc, $d300 ; $5b5d
	add a, c ; $5b60
	ld c, a ; $5b61
	jr nc, Label_3b_5b65 ; $5b62
	inc b ; $5b64
Label_3b_5b65:
	ld hl, $0000 ; $5b65
	add hl, bc ; $5b68
	ld a, [hl] ; $5b69
	cp a, $3f ; $5b6a
	jr z, Label_3b_5bd0 ; $5b6c
	ld hl, $0003 ; $5b6e
	add hl, bc ; $5b71
	ld de, $d201 ; $5b72
	call Func_3b_442c ; $5b75
	ld a, $4c ; $5b78
	ld [$d209], a ; $5b7a
	ld a, $56 ; $5b7d
	ld [$d20a], a ; $5b7f
	push af ; $5b82
	push bc ; $5b83
	push de ; $5b84
	push hl ; $5b85
	ld hl, $0002 ; $5b86
	add hl, bc ; $5b89
	ld a, [hl] ; $5b8a
	ld h, $00 ; $5b8b
	ld l, a ; $5b8d
	ld de, $d20c ; $5b8e
	ld bc, $d330 ; $5b91
	call Func_3b_5c2b ; $5b94
	pop hl ; $5b97
	pop de ; $5b98
	pop bc ; $5b99
	pop af ; $5b9a
	push af ; $5b9b
	push bc ; $5b9c
	push de ; $5b9d
	push hl ; $5b9e
	ld hl, $000f ; $5b9f
	add hl, bc ; $5ba2
	ld a, [hl] ; $5ba3
	ld h, $00 ; $5ba4
	ld l, a ; $5ba6
	ld de, $d20f ; $5ba7
	ld bc, $d330 ; $5baa
	call Func_3b_5c27 ; $5bad
	pop hl ; $5bb0
	pop de ; $5bb1
	pop bc ; $5bb2
	pop af ; $5bb3
	ld hl, $000e ; $5bb4
	add hl, bc ; $5bb7
	ld a, [hl] ; $5bb8
	ld h, $00 ; $5bb9
	ld l, a ; $5bbb
	ld de, $d212 ; $5bbc
	ld bc, $d330 ; $5bbf
	call Func_3b_5c27 ; $5bc2
	pop af ; $5bc5
	ldh [$ff96], a ; $5bc6
	ldh [rWBK], a ; $5bc8
	ld a, $3a ; $5bca
	ld [$d210], a ; $5bcc
	ret ; $5bcf
Label_3b_5bd0:
	ld hl, $007c ; $5bd0
	ld de, $d201 ; $5bd3
	ld c, $20 ; $5bd6
	farcall FarPtr_05_72 ; $5bd8
	jr Label_3b_5bfd ; $5bdb
Label_3b_5bdd:
	ld b, a ; $5bdd
	ld a, b ; $5bde
	add a, a ; $5bdf
	ld hl, $5c03 ; $5be0
	add a, l ; $5be3
	ld l, a ; $5be4
	jr nc, Label_3b_5be8 ; $5be5
	inc h ; $5be7
Label_3b_5be8:
	ld a, [hl+] ; $5be8
	ld d, [hl] ; $5be9
	ld e, a ; $5bea
	ld a, b ; $5beb
	ld hl, $5c15 ; $5bec
	add a, a ; $5bef
	add a, l ; $5bf0
	ld l, a ; $5bf1
	jr nc, Label_3b_5bf5 ; $5bf2
	inc h ; $5bf4
Label_3b_5bf5:
	ld a, [hl+] ; $5bf5
	ld h, [hl] ; $5bf6
	ld l, a ; $5bf7
	ld c, $20 ; $5bf8
	farcall FarPtr_05_72 ; $5bfa
Label_3b_5bfd:
	pop af ; $5bfd
	ldh [$ff96], a ; $5bfe
	ldh [rWBK], a ; $5c00
	ret ; $5c02
	INCBIN "data/bank_03b/d_5c03.bin" ; $5c03, 36 bytes
Func_3b_5c27:
	ld a, $02 ; $5c27
	jr Label_3b_5c2d ; $5c29
Func_3b_5c2b:
	ld a, $00 ; $5c2b
Label_3b_5c2d:
	push af ; $5c2d
	push bc ; $5c2e
	push de ; $5c2f
	push hl ; $5c30
	ld d, b ; $5c31
	ld e, c ; $5c32
	call Func_00_1972 ; $5c33
	pop hl ; $5c36
	pop de ; $5c37
	pop bc ; $5c38
	pop af ; $5c39
	ld h, b ; $5c3a
	ld l, c ; $5c3b
	ld c, $ff ; $5c3c
Label_3b_5c3e:
	inc c ; $5c3e
	ld a, [hl+] ; $5c3f
	or a, a ; $5c40
	jr nz, Label_3b_5c3e ; $5c41
	dec hl ; $5c43
	dec hl ; $5c44
Label_3b_5c45:
	ld a, [hl-] ; $5c45
	cp a, $20 ; $5c46
	jr nz, Label_3b_5c4c ; $5c48
	ld a, $30 ; $5c4a
Label_3b_5c4c:
	ld [de], a ; $5c4c
	dec de ; $5c4d
	dec c ; $5c4e
	jr nz, Label_3b_5c45 ; $5c4f
	ret ; $5c51
	INCBIN "data/bank_03b/d_5c52.bin" ; $5c52, 1 bytes
Func_3b_5c53:
	di ; $5c53
	xor a, a ; $5c54
	ldh [rIF], a ; $5c55
	ldh a, [rIE] ; $5c57
	and a, $09 ; $5c59
	ldh [rIE], a ; $5c5b
	ei ; $5c5d
	ld a, [$cb04] ; $5c5e
	cp a, $02 ; $5c61
	jr nz, Label_3b_5c6c ; $5c63
	ld a, [$cb05] ; $5c65
	cp a, $00 ; $5c68
	jr z, Label_3b_5c70 ; $5c6a
Label_3b_5c6c:
	scf ; $5c6c
	ccf ; $5c6d
	jr Label_3b_5ce0 ; $5c6e
Label_3b_5c70:
	di ; $5c70
	ldh a, [$ffc0] ; $5c71
	ei ; $5c73
	cp a, $c1 ; $5c74
	jr z, Label_3b_5cd7 ; $5c76
Label_3b_5c78:
	farcall FarPtr_3e_04 ; $5c78
	farcall FarPtr_07_00 ; $5c7b
	push af ; $5c7e
	jr nc, Label_3b_5cbb ; $5c7f
	or a, a ; $5c81
	jr nz, Label_3b_5c93 ; $5c82
	ldh a, [$ff96] ; $5c84
	push af ; $5c86
	ld c, $00 ; $5c87
	farcall FarPtr_3e_30 ; $5c89
	pop af ; $5c8c
	ldh [$ff96], a ; $5c8d
	ldh [rWBK], a ; $5c8f
	jr Label_3b_5ca0 ; $5c91
Label_3b_5c93:
	ldh a, [$ff96] ; $5c93
	push af ; $5c95
	ld c, $01 ; $5c96
	farcall FarPtr_3e_30 ; $5c98
	pop af ; $5c9b
	ldh [$ff96], a ; $5c9c
	ldh [rWBK], a ; $5c9e
Label_3b_5ca0:
	ld de, $01f4 ; $5ca0
Label_3b_5ca3:
	farcall FarPtr_3e_16 ; $5ca3
	farcall FarPtr_39_04 ; $5ca6
	call Func_00_2631 ; $5ca9
	ldh a, [$ff91] ; $5cac
	bit 0, a ; $5cae
	jr nz, Label_3b_5cbb ; $5cb0
	bit 1, a ; $5cb2
	jr nz, Label_3b_5cbb ; $5cb4
	dec de ; $5cb6
	ld a, d ; $5cb7
	or a, e ; $5cb8
	jr nz, Label_3b_5ca3 ; $5cb9
Label_3b_5cbb:
	ld c, $40 ; $5cbb
	call Func_00_1d20 ; $5cbd
	call Func_00_1da4 ; $5cc0
	call DisableLCDSafely ; $5cc3
	farcall FarPtr_39_22 ; $5cc6
	call EnableLCD ; $5cc9
	ld c, $40 ; $5ccc
	call Func_00_1d2e ; $5cce
	call Func_00_1da4 ; $5cd1
	pop af ; $5cd4
	jr Label_3b_5ce0 ; $5cd5
Label_3b_5cd7:
	call Func_00_2725 ; $5cd7
	ld b, $df ; $5cda
	nop ; $5cdc
	rlca ; $5cdd
	jr c, Label_3b_5c78 ; $5cde
Label_3b_5ce0:
	ret ; $5ce0
	INCBIN "data/bank_03b/d_5ce1.bin" ; $5ce1, 18 bytes
Func_3b_5cf3:
	ld hl, rIE ; $5cf3
	res 2, [hl] ; $5cf6
	sound $03 ; $5cf8
	call Func_3b_5dec ; $5cfa
	ld a, $03 ; $5cfd
	ldh [$ff96], a ; $5cff
	ldh [rWBK], a ; $5d01
	ld a, [$cb11] ; $5d03
	ld b, a ; $5d06
	call Func_3b_5ed9 ; $5d07
	farcall FarPtr_39_24 ; $5d0a
	ld b, $01 ; $5d0d
	ld c, $01 ; $5d0f
	farcall FarPtr_39_26 ; $5d11
	call Func_3b_5d80 ; $5d14
	ld a, $01 ; $5d17
	ld hl, $60d0 ; $5d19
	call Func_00_1b6a ; $5d1c
	call Func_3b_6164 ; $5d1f
	ld a, $03 ; $5d22
	ldh [$ff96], a ; $5d24
	ldh [rWBK], a ; $5d26
Label_3b_5d28:
	call Func_00_2631 ; $5d28
	ldh a, [$ff91] ; $5d2b
	ld [$cb0d], a ; $5d2d
	call Func_3b_5f3c ; $5d30
	ld b, $01 ; $5d33
	ld c, $03 ; $5d35
	call Func_3b_412a ; $5d37
	or a, a ; $5d3a
	jr z, Label_3b_5d42 ; $5d3b
	sound $5e ; $5d3d
	call Func_3b_6164 ; $5d3f
Label_3b_5d42:
	ld a, [$cb0d] ; $5d42
	bit 0, a ; $5d45
	jr nz, Label_3b_5d4f ; $5d47
	bit 1, a ; $5d49
	jr nz, Label_3b_5d69 ; $5d4b
	jr Label_3b_5d28 ; $5d4d
Label_3b_5d4f:
	sound $5f ; $5d4f
	ld hl, rIE ; $5d51
	set 2, [hl] ; $5d54
	call Func_00_1b38 ; $5d56
	ld b, $01 ; $5d59
	call Func_3b_5f0b ; $5d5b
	ld a, $01 ; $5d5e
	ld [$cb11], a ; $5d60
	ld c, $03 ; $5d63
	call Func_3b_43b9 ; $5d65
	ret ; $5d68
Label_3b_5d69:
	sound $62 ; $5d69
	ld hl, rIE ; $5d6b
	set 2, [hl] ; $5d6e
	call Func_00_1b38 ; $5d70
	ld b, $00 ; $5d73
	call Func_3b_5f0b ; $5d75
	ld a, $00 ; $5d78
	ld [$cb11], a ; $5d7a
	ld a, $ff ; $5d7d
	ret ; $5d7f
Func_3b_5d80:
	ld b, $01 ; $5d80
	ld c, $00 ; $5d82
	call Func_3b_43db ; $5d84
	ld a, [$cb0e] ; $5d87
	ld b, a ; $5d8a
	ld c, $01 ; $5d8b
	call Func_3b_6049 ; $5d8d
	ld b, $00 ; $5d90
	call Func_3b_609a ; $5d92
	ld a, [$cb0f] ; $5d95
	add a, $02 ; $5d98
	ld b, a ; $5d9a
	ld c, $01 ; $5d9b
	call Func_3b_6049 ; $5d9d
	ld b, $01 ; $5da0
	call Func_3b_609a ; $5da2
	ld a, [$cb10] ; $5da5
	add a, $04 ; $5da8
	ld b, a ; $5daa
	ld c, $01 ; $5dab
	call Func_3b_6049 ; $5dad
	ld b, $02 ; $5db0
	call Func_3b_609a ; $5db2
	ld hl, $5dd4 ; $5db5
	ld d, $04 ; $5db8
	ld e, $01 ; $5dba
	call LoadPaletteShadow ; $5dbc
	ld hl, $5ddc ; $5dbf
	ld d, $06 ; $5dc2
	ld e, $01 ; $5dc4
	call LoadPaletteShadow ; $5dc6
	ld hl, $5de4 ; $5dc9
	ld d, $07 ; $5dcc
	ld e, $01 ; $5dce
	call LoadPaletteShadow ; $5dd0
	ret ; $5dd3
	INCBIN "data/bank_03b/d_5dd4.bin" ; $5dd4, 24 bytes
Func_3b_5dec:
	ldh a, [$ff96] ; $5dec
	push af ; $5dee
	ld a, $01 ; $5def
	ldh [$ff96], a ; $5df1
	ldh [rWBK], a ; $5df3
	ld c, $00 ; $5df5
Label_3b_5df7:
	ld a, c ; $5df7
	add a, a ; $5df8
	ld hl, $5ebd ; $5df9
	add a, l ; $5dfc
	ld l, a ; $5dfd
	jr nc, Label_3b_5e01 ; $5dfe
	inc h ; $5e00
Label_3b_5e01:
	ld a, [hl+] ; $5e01
	ld h, [hl] ; $5e02
	ld l, a ; $5e03
	push af ; $5e04
	push bc ; $5e05
	push de ; $5e06
	push hl ; $5e07
	ld de, $d000 ; $5e08
	call DecompressDataFromBank ; $5e0b
	pop hl ; $5e0e
	pop de ; $5e0f
	pop bc ; $5e10
	pop af ; $5e11
	ld hl, $5ecb ; $5e12
	ld a, c ; $5e15
	add a, a ; $5e16
	add a, l ; $5e17
	ld l, a ; $5e18
	jr nc, Label_3b_5e1c ; $5e19
	inc h ; $5e1b
Label_3b_5e1c:
	ld a, [hl+] ; $5e1c
	ld d, [hl] ; $5e1d
	ld e, a ; $5e1e
	ld hl, $d000 ; $5e1f
	push af ; $5e22
	push bc ; $5e23
	push de ; $5e24
	push hl ; $5e25
	ld bc, $0010 ; $5e26
	call Func_00_0480 ; $5e29
	pop hl ; $5e2c
	pop de ; $5e2d
	pop bc ; $5e2e
	pop af ; $5e2f
	ld a, c ; $5e30
	inc a ; $5e31
	ld c, a ; $5e32
	call Func_00_2631 ; $5e33
	ld a, c ; $5e36
	cp a, $07 ; $5e37
	jr nz, Label_3b_5df7 ; $5e39
	ld b, $23 ; $5e3b
	ld c, $10 ; $5e3d
	ld de, $a000 ; $5e3f
	farcall FarPtr_39_10 ; $5e42
	call Func_00_2631 ; $5e45
	ld b, $24 ; $5e48
	ld c, $10 ; $5e4a
	ld de, $a100 ; $5e4c
	farcall FarPtr_39_10 ; $5e4f
	call Func_00_2631 ; $5e52
	ld b, $25 ; $5e55
	ld c, $10 ; $5e57
	ld de, $a200 ; $5e59
	farcall FarPtr_39_10 ; $5e5c
	call Func_00_2631 ; $5e5f
	ld b, $26 ; $5e62
	ld c, $10 ; $5e64
	ld de, $a300 ; $5e66
	farcall FarPtr_39_10 ; $5e69
	call Func_00_2631 ; $5e6c
	ld b, $27 ; $5e6f
	ld c, $10 ; $5e71
	ld de, $a400 ; $5e73
	farcall FarPtr_39_10 ; $5e76
	call Func_00_2631 ; $5e79
	ld b, $28 ; $5e7c
	ld c, $10 ; $5e7e
	ld de, $a500 ; $5e80
	farcall FarPtr_39_10 ; $5e83
	call Func_00_2631 ; $5e86
	ld b, $29 ; $5e89
	ld c, $10 ; $5e8b
	ld de, $a600 ; $5e8d
	farcall FarPtr_39_10 ; $5e90
	call Func_00_2631 ; $5e93
	ld b, $1b ; $5e96
	ld c, $04 ; $5e98
	ld de, $a700 ; $5e9a
	farcall FarPtr_39_10 ; $5e9d
	call Func_00_2631 ; $5ea0
	ld b, $3f ; $5ea3
	ld c, $14 ; $5ea5
	ld de, $8000 ; $5ea7
	farcall FarPtr_39_10 ; $5eaa
	call Func_00_2631 ; $5ead
	ld b, $08 ; $5eb0
	ld c, $10 ; $5eb2
	farcall FarPtr_39_0e ; $5eb4
	pop af ; $5eb7
	ldh [$ff96], a ; $5eb8
	ldh [rWBK], a ; $5eba
	ret ; $5ebc
	INCBIN "data/bank_03b/d_5ebd.bin" ; $5ebd, 28 bytes
Func_3b_5ed9:
	ld a, b ; $5ed9
	or a, a ; $5eda
	jr z, Label_3b_5ef4 ; $5edb
	ld c, $00 ; $5edd
Label_3b_5edf:
	call Func_00_2631 ; $5edf
	ld b, $02 ; $5ee2
	farcall FarPtr_39_20 ; $5ee4
	ld b, $00 ; $5ee7
	farcall FarPtr_39_1e ; $5ee9
	ld a, c ; $5eec
	inc a ; $5eed
	ld c, a ; $5eee
	cp a, $0e ; $5eef
	jr nz, Label_3b_5edf ; $5ef1
	ret ; $5ef3
Label_3b_5ef4:
	ld c, $0a ; $5ef4
Label_3b_5ef6:
	call Func_00_2631 ; $5ef6
	ld b, $03 ; $5ef9
	farcall FarPtr_39_20 ; $5efb
	ld b, $00 ; $5efe
	farcall FarPtr_39_1e ; $5f00
	ld a, c ; $5f03
	dec a ; $5f04
	ld c, a ; $5f05
	cp a, $ff ; $5f06
	jr nz, Label_3b_5ef6 ; $5f08
	ret ; $5f0a
Func_3b_5f0b:
	ld a, b ; $5f0b
	or a, a ; $5f0c
	jr z, Label_3b_5f26 ; $5f0d
	ld c, $00 ; $5f0f
Label_3b_5f11:
	call Func_00_2631 ; $5f11
	ld b, $03 ; $5f14
	farcall FarPtr_39_20 ; $5f16
	ld b, $00 ; $5f19
	farcall FarPtr_39_1e ; $5f1b
	ld a, c ; $5f1e
	inc a ; $5f1f
	ld c, a ; $5f20
	cp a, $0b ; $5f21
	jr nz, Label_3b_5f11 ; $5f23
	ret ; $5f25
Label_3b_5f26:
	ld c, $0d ; $5f26
Label_3b_5f28:
	call Func_00_2631 ; $5f28
	ld b, $02 ; $5f2b
	farcall FarPtr_39_20 ; $5f2d
	ld b, $00 ; $5f30
	farcall FarPtr_39_1e ; $5f32
	ld a, c ; $5f35
	dec a ; $5f36
	ld c, a ; $5f37
	or a, a ; $5f38
	jr nz, Label_3b_5f28 ; $5f39
	ret ; $5f3b
Func_3b_5f3c:
	ld a, [$cb0d] ; $5f3c
	bit 5, a ; $5f3f
	jr nz, Label_3b_5f48 ; $5f41
	bit 4, a ; $5f43
	jr nz, Label_3b_5f9f ; $5f45
	ret ; $5f47
Label_3b_5f48:
	sound $5e ; $5f48
	ld c, $01 ; $5f4a
	call Func_3b_43b9 ; $5f4c
	or a, a ; $5f4f
	jr nz, Label_3b_5f66 ; $5f50
	ld a, [$cb0e] ; $5f52
	xor a, $01 ; $5f55
	ld [$cb0e], a ; $5f57
	ld b, $00 ; $5f5a
	call Func_3b_609a ; $5f5c
	call Func_3b_5ff6 ; $5f5f
	call Func_3b_6164 ; $5f62
	ret ; $5f65
Label_3b_5f66:
	cp a, $01 ; $5f66
	jr nz, Label_3b_5f7e ; $5f68
	ld a, [$cb0f] ; $5f6a
	xor a, $01 ; $5f6d
	ld [$cb0f], a ; $5f6f
	ld b, $01 ; $5f72
	call Func_3b_609a ; $5f74
	call Func_3b_600e ; $5f77
	call Func_3b_6164 ; $5f7a
	ret ; $5f7d
Label_3b_5f7e:
	ld a, [$cb10] ; $5f7e
	dec a ; $5f81
	add a, a ; $5f82
	jr nc, Label_3b_5f8a ; $5f83
	ld a, $03 ; $5f85
	dec a ; $5f87
	jr Label_3b_5f90 ; $5f88
Label_3b_5f8a:
	rra ; $5f8a
	cp a, $03 ; $5f8b
	jr c, Label_3b_5f90 ; $5f8d
	xor a, a ; $5f8f
Label_3b_5f90:
	ld [$cb10], a ; $5f90
	ld b, $02 ; $5f93
	call Func_3b_609a ; $5f95
	call Func_3b_6028 ; $5f98
	call Func_3b_6164 ; $5f9b
	ret ; $5f9e
Label_3b_5f9f:
	sound $5e ; $5f9f
	ld c, $01 ; $5fa1
	call Func_3b_43b9 ; $5fa3
	or a, a ; $5fa6
	jr nz, Label_3b_5fbd ; $5fa7
	ld a, [$cb0e] ; $5fa9
	xor a, $01 ; $5fac
	ld [$cb0e], a ; $5fae
	ld b, $00 ; $5fb1
	call Func_3b_609a ; $5fb3
	call Func_3b_5ff6 ; $5fb6
	call Func_3b_6164 ; $5fb9
	ret ; $5fbc
Label_3b_5fbd:
	cp a, $01 ; $5fbd
	jr nz, Label_3b_5fd5 ; $5fbf
	ld a, [$cb0f] ; $5fc1
	xor a, $01 ; $5fc4
	ld [$cb0f], a ; $5fc6
	ld b, $01 ; $5fc9
	call Func_3b_609a ; $5fcb
	call Func_3b_600e ; $5fce
	call Func_3b_6164 ; $5fd1
	ret ; $5fd4
Label_3b_5fd5:
	ld a, [$cb10] ; $5fd5
	inc a ; $5fd8
	add a, a ; $5fd9
	jr nc, Label_3b_5fe1 ; $5fda
	ld a, $03 ; $5fdc
	dec a ; $5fde
	jr Label_3b_5fe7 ; $5fdf
Label_3b_5fe1:
	rra ; $5fe1
	cp a, $03 ; $5fe2
	jr c, Label_3b_5fe7 ; $5fe4
	xor a, a ; $5fe6
Label_3b_5fe7:
	ld [$cb10], a ; $5fe7
	ld b, $02 ; $5fea
	call Func_3b_609a ; $5fec
	call Func_3b_6028 ; $5fef
	call Func_3b_6164 ; $5ff2
	ret ; $5ff5
Func_3b_5ff6:
	ld b, $00 ; $5ff6
	ld c, $00 ; $5ff8
	call Func_3b_6049 ; $5ffa
	ld b, $01 ; $5ffd
	ld c, $00 ; $5fff
	call Func_3b_6049 ; $6001
	ld a, [$cb0e] ; $6004
	ld b, a ; $6007
	ld c, $01 ; $6008
	call Func_3b_6049 ; $600a
	ret ; $600d
Func_3b_600e:
	ld b, $02 ; $600e
	ld c, $00 ; $6010
	call Func_3b_6049 ; $6012
	ld b, $03 ; $6015
	ld c, $00 ; $6017
	call Func_3b_6049 ; $6019
	ld a, [$cb0f] ; $601c
	add a, $02 ; $601f
	ld b, a ; $6021
	ld c, $01 ; $6022
	call Func_3b_6049 ; $6024
	ret ; $6027
Func_3b_6028:
	ld b, $04 ; $6028
	ld c, $00 ; $602a
	call Func_3b_6049 ; $602c
	ld b, $05 ; $602f
	ld c, $00 ; $6031
	call Func_3b_6049 ; $6033
	ld b, $06 ; $6036
	ld c, $00 ; $6038
	call Func_3b_6049 ; $603a
	ld a, [$cb10] ; $603d
	add a, $04 ; $6040
	ld b, a ; $6042
	ld c, $01 ; $6043
	call Func_3b_6049 ; $6045
	ret ; $6048
Func_3b_6049:
	push af ; $6049
	push bc ; $604a
	push de ; $604b
	push hl ; $604c
	ldh a, [$ff96] ; $604d
	push af ; $604f
	ld a, $03 ; $6050
	ldh [$ff96], a ; $6052
	ldh [rWBK], a ; $6054
	ld hl, $6085 ; $6056
	ld a, b ; $6059
	add a, a ; $605a
	add a, l ; $605b
	ld l, a ; $605c
	jr nc, Label_3b_6060 ; $605d
	inc h ; $605f
Label_3b_6060:
	ld a, [hl+] ; $6060
	ld d, [hl] ; $6061
	ld e, a ; $6062
	ld h, $0d ; $6063
	ld a, c ; $6065
	or a, a ; $6066
	jr z, Label_3b_6074 ; $6067
	ld a, b ; $6069
	ld hl, $6093 ; $606a
	add a, l ; $606d
	ld l, a ; $606e
	jr nc, Label_3b_6072 ; $606f
	inc h ; $6071
Label_3b_6072:
	ld a, [hl] ; $6072
	ld h, a ; $6073
Label_3b_6074:
	ld b, $05 ; $6074
	ld c, $03 ; $6076
	farcall FarPtr_39_0c ; $6078
	pop af ; $607b
	ldh [$ff96], a ; $607c
	ldh [rWBK], a ; $607e
	pop hl ; $6080
	pop de ; $6081
	pop bc ; $6082
	pop af ; $6083
	ret ; $6084
	INCBIN "data/bank_03b/d_6085.bin" ; $6085, 21 bytes
Func_3b_609a:
	push af ; $609a
	push bc ; $609b
	push de ; $609c
	push hl ; $609d
	ld a, b ; $609e
	or a, a ; $609f
	jr nz, Label_3b_60af ; $60a0
	ld hl, $d460 ; $60a2
	ld de, $b860 ; $60a5
	ld c, $06 ; $60a8
	call Func_00_0480 ; $60aa
	jr Label_3b_60cb ; $60ad
Label_3b_60af:
	cp a, $01 ; $60af
	jr nz, Label_3b_60c0 ; $60b1
	ld hl, $d4e0 ; $60b3
	ld de, $b8e0 ; $60b6
	ld c, $06 ; $60b9
	call Func_00_0480 ; $60bb
	jr Label_3b_60cb ; $60be
Label_3b_60c0:
	ld hl, $d560 ; $60c0
	ld de, $b960 ; $60c3
	ld c, $06 ; $60c6
	call Func_00_0480 ; $60c8
Label_3b_60cb:
	pop hl ; $60cb
	pop de ; $60cc
	pop bc ; $60cd
	pop af ; $60ce
	ret ; $60cf
	farcall FarPtr_39_28 ; $60d0
	ld c, $01 ; $60d3
	call Func_3b_43b9 ; $60d5
	or a, a ; $60d8
	jr nz, Label_3b_60e0 ; $60d9
	ld a, [$cb0e] ; $60db
	jr Label_3b_60f0 ; $60de
Label_3b_60e0:
	cp a, $01 ; $60e0
	jr nz, Label_3b_60eb ; $60e2
	ld a, [$cb0f] ; $60e4
	add a, $02 ; $60e7
	jr Label_3b_60f0 ; $60e9
Label_3b_60eb:
	ld a, [$cb10] ; $60eb
	add a, $04 ; $60ee
Label_3b_60f0:
	push af ; $60f0
	ld hl, $615d ; $60f1
	add a, l ; $60f4
	ld l, a ; $60f5
	jr nc, Label_3b_60f9 ; $60f6
	inc h ; $60f8
Label_3b_60f9:
	ld c, [hl] ; $60f9
	pop af ; $60fa
	ld hl, $614f ; $60fb
	add a, a ; $60fe
	add a, l ; $60ff
	ld l, a ; $6100
	jr nc, Label_3b_6104 ; $6101
	inc h ; $6103
Label_3b_6104:
	ld a, [hl+] ; $6104
	ld d, [hl] ; $6105
	ld e, a ; $6106
	farcall FarPtr_39_16 ; $6107
	ld b, $08 ; $610a
	ld hl, $6125 ; $610c
	push de ; $610f
	call Func_00_1e9d ; $6110
	pop de ; $6113
	ld hl, $17f8 ; $6114
	add hl, de ; $6117
	ld d, h ; $6118
	ld e, l ; $6119
	ld hl, $6146 ; $611a
	ld b, $08 ; $611d
	ld c, $70 ; $611f
	call Func_00_1e9d ; $6121
	ret ; $6124
	INCBIN "data/bank_03b/d_6125.bin" ; $6125, 63 bytes
Func_3b_6164:
	ld a, $03 ; $6164
	ldh [$ff96], a ; $6166
	ldh [rWBK], a ; $6168
	ld de, $d1e0 ; $616a
	ld b, $14 ; $616d
	ld c, $01 ; $616f
	ld h, $03 ; $6171
	farcall FarPtr_39_0c ; $6173
	ld a, $02 ; $6176
	ld [$d1e0], a ; $6178
	ld a, $04 ; $617b
	ld [$d1f3], a ; $617d
	ld de, $d201 ; $6180
	ld b, $12 ; $6183
	ld c, $01 ; $6185
	ld h, $20 ; $6187
	farcall FarPtr_39_0c ; $6189
	call Func_3b_619b ; $618c
	ld hl, $d1e0 ; $618f
	ld de, $99e0 ; $6192
	ld c, $04 ; $6195
	call Func_00_0480 ; $6197
	ret ; $619a
Func_3b_619b:
	ld a, $03 ; $619b
	ldh [$ff96], a ; $619d
	ldh [rWBK], a ; $619f
	ld c, $01 ; $61a1
	call Func_3b_43b9 ; $61a3
	or a, a ; $61a6
	jr nz, Label_3b_61bd ; $61a7
	ld a, [$cb0e] ; $61a9
	ld hl, $0087 ; $61ac
	add a, l ; $61af
	ld l, a ; $61b0
	jr nc, Label_3b_61b4 ; $61b1
	inc h ; $61b3
Label_3b_61b4:
	ld de, $d201 ; $61b4
	ld c, $20 ; $61b7
	farcall FarPtr_05_72 ; $61b9
	ret ; $61bc
Label_3b_61bd:
	cp a, $01 ; $61bd
	jr nz, Label_3b_61d5 ; $61bf
	ld a, [$cb0f] ; $61c1
	ld hl, $0089 ; $61c4
	add a, l ; $61c7
	ld l, a ; $61c8
	jr nc, Label_3b_61cc ; $61c9
	inc h ; $61cb
Label_3b_61cc:
	ld de, $d201 ; $61cc
	ld c, $20 ; $61cf
	farcall FarPtr_05_72 ; $61d1
	ret ; $61d4
Label_3b_61d5:
	ld a, [$cb10] ; $61d5
	ld hl, $008b ; $61d8
	add a, l ; $61db
	ld l, a ; $61dc
	jr nc, Label_3b_61e0 ; $61dd
	inc h ; $61df
Label_3b_61e0:
	ld de, $d201 ; $61e0
	ld c, $20 ; $61e3
	farcall FarPtr_05_72 ; $61e5
	ret ; $61e8
	INCBIN "data/bank_03b/d_61e9.bin" ; $61e9, 7 bytes
Func_3b_61f0:
	ld hl, rIE ; $61f0
	res 2, [hl] ; $61f3
	sound $08 ; $61f5
	xor a, a ; $61f7
	ld [$cb70], a ; $61f8
	call Func_3b_667f ; $61fb
	call Func_3b_62ef ; $61fe
	ld a, $03 ; $6201
	ldh [$ff96], a ; $6203
	ldh [rWBK], a ; $6205
	call Func_3b_66f2 ; $6207
	or a, a ; $620a
	jr nz, Label_3b_6216 ; $620b
	ld a, [$cb11] ; $620d
	ld b, a ; $6210
	call Func_3b_6700 ; $6211
	jr Label_3b_621d ; $6214
Label_3b_6216:
	ld a, [$cb11] ; $6216
	ld b, a ; $6219
	call Func_3b_640a ; $621a
Label_3b_621d:
	farcall FarPtr_39_24 ; $621d
	ld b, $01 ; $6220
	ld c, $01 ; $6222
	farcall FarPtr_39_26 ; $6224
	ld a, [$cb20] ; $6227
	ld c, a ; $622a
	ld b, $03 ; $622b
	call Func_3b_43db ; $622d
	ld a, $01 ; $6230
	ld hl, $646d ; $6232
	call Func_00_1b6a ; $6235
	call Func_3b_6569 ; $6238
	call Func_3b_66f2 ; $623b
	or a, a ; $623e
	jr nz, Label_3b_6246 ; $623f
	call Func_3b_6763 ; $6241
	jr Label_3b_6249 ; $6244
Label_3b_6246:
	call Func_3b_65ec ; $6246
Label_3b_6249:
	ld a, $03 ; $6249
	ldh [$ff96], a ; $624b
	ldh [rWBK], a ; $624d
Label_3b_624f:
	ldh a, [$ff91] ; $624f
	ld [$cb0d], a ; $6251
	call Func_3b_66f2 ; $6254
	or a, a ; $6257
	jr nz, Label_3b_626a ; $6258
	farcall FarPtr_39_62 ; $625a
	or a, a ; $625d
	jr z, Label_3b_627c ; $625e
	sound $5e ; $6260
	call Func_3b_6569 ; $6262
	call Func_3b_6763 ; $6265
	jr Label_3b_627c ; $6268
Label_3b_626a:
	ld b, $03 ; $626a
	ld c, $03 ; $626c
	call Func_3b_412a ; $626e
	or a, a ; $6271
	jr z, Label_3b_627c ; $6272
	sound $5e ; $6274
	call Func_3b_6569 ; $6276
	call Func_3b_65ec ; $6279
Label_3b_627c:
	call Func_00_2631 ; $627c
	ld a, [$cb0d] ; $627f
	bit 0, a ; $6282
	jr nz, Label_3b_628c ; $6284
	bit 1, a ; $6286
	jr nz, Label_3b_62cb ; $6288
	jr Label_3b_624f ; $628a
Label_3b_628c:
	ld c, $03 ; $628c
	call Func_3b_43b9 ; $628e
	ld c, a ; $6291
	call Func_3b_66b5 ; $6292
	cp a, $15 ; $6295
	jr nz, Label_3b_629d ; $6297
	sound $61 ; $6299
	jr Label_3b_624f ; $629b
Label_3b_629d:
	sound $5f ; $629d
	call Func_00_1b38 ; $629f
	ld hl, rIE ; $62a2
	set 2, [hl] ; $62a5
	call Func_3b_66f2 ; $62a7
	or a, a ; $62aa
	jr nz, Label_3b_62b4 ; $62ab
	ld b, $01 ; $62ad
	call Func_3b_6732 ; $62af
	jr Label_3b_62b9 ; $62b2
Label_3b_62b4:
	ld b, $01 ; $62b4
	call Func_3b_643c ; $62b6
Label_3b_62b9:
	ld a, $01 ; $62b9
	ld [$cb11], a ; $62bb
	xor a, a ; $62be
	ld [$cb70], a ; $62bf
	ld c, $03 ; $62c2
	call Func_3b_43b9 ; $62c4
	ld [$cb20], a ; $62c7
	ret ; $62ca
Label_3b_62cb:
	sound $62 ; $62cb
	call Func_00_1b38 ; $62cd
	ld hl, rIE ; $62d0
	set 2, [hl] ; $62d3
	call Func_3b_66f2 ; $62d5
	or a, a ; $62d8
	jr nz, Label_3b_62e2 ; $62d9
	ld b, $00 ; $62db
	call Func_3b_6732 ; $62dd
	jr Label_3b_62e7 ; $62e0
Label_3b_62e2:
	ld b, $00 ; $62e2
	call Func_3b_643c ; $62e4
Label_3b_62e7:
	ld a, $00 ; $62e7
	ld [$cb11], a ; $62e9
	ld a, $ff ; $62ec
	ret ; $62ee
Func_3b_62ef:
	ldh a, [$ff96] ; $62ef
	push af ; $62f1
	ld a, $01 ; $62f2
	ldh [$ff96], a ; $62f4
	ldh [rWBK], a ; $62f6
	ld c, $00 ; $62f8
Label_3b_62fa:
	push bc ; $62fa
	call Func_3b_66b5 ; $62fb
	ld b, a ; $62fe
	ld de, $d000 ; $62ff
	farcall FarPtr_16_04 ; $6302
	pop bc ; $6305
	push bc ; $6306
	ld a, c ; $6307
	add a, a ; $6308
	ld hl, $63f6 ; $6309
	add a, l ; $630c
	ld l, a ; $630d
	jr nc, Label_3b_6311 ; $630e
	inc h ; $6310
Label_3b_6311:
	ld a, [hl+] ; $6311
	ld d, [hl] ; $6312
	ld e, a ; $6313
	ld hl, $d000 ; $6314
	ld c, $09 ; $6317
	call Func_00_0480 ; $6319
	pop bc ; $631c
	call Func_00_2631 ; $631d
	ld a, c ; $6320
	inc a ; $6321
	ld c, a ; $6322
	cp a, $09 ; $6323
	jr nz, Label_3b_62fa ; $6325
	ld b, $33 ; $6327
	ld c, $10 ; $6329
	ld de, $a000 ; $632b
	farcall FarPtr_39_10 ; $632e
	call Func_00_2631 ; $6331
	ld b, $34 ; $6334
	ld c, $10 ; $6336
	ld de, $a100 ; $6338
	farcall FarPtr_39_10 ; $633b
	call Func_00_2631 ; $633e
	ld b, $35 ; $6341
	ld c, $10 ; $6343
	ld de, $a200 ; $6345
	farcall FarPtr_39_10 ; $6348
	call Func_00_2631 ; $634b
	ld b, $36 ; $634e
	ld c, $10 ; $6350
	ld de, $a300 ; $6352
	farcall FarPtr_39_10 ; $6355
	call Func_00_2631 ; $6358
	ld b, $37 ; $635b
	ld c, $10 ; $635d
	ld de, $a400 ; $635f
	farcall FarPtr_39_10 ; $6362
	call Func_00_2631 ; $6365
	ld b, $38 ; $6368
	ld c, $10 ; $636a
	ld de, $a500 ; $636c
	farcall FarPtr_39_10 ; $636f
	call Func_00_2631 ; $6372
	ld hl, $6d7e ; $6375 -> DataPtr_6d_7e
	ld de, $d000 ; $6378
	call DecompressDataFromBank ; $637b
	ld hl, $d000 ; $637e
	ld de, $8200 ; $6381
	ld c, $10 ; $6384
	call Func_00_0480 ; $6386
	ld hl, $6d80 ; $6389 -> DataPtr_6d_80
	ld de, $d400 ; $638c
	call DecompressDataFromBank ; $638f
	ld hl, $d400 ; $6392
	ld de, $8300 ; $6395
	ld c, $10 ; $6398
	call Func_00_0480 ; $639a
	call Func_00_2631 ; $639d
	ld hl, $6d82 ; $63a0 -> DataPtr_6d_82
	ld de, $d000 ; $63a3
	call DecompressDataFromBank ; $63a6
	ld hl, $d000 ; $63a9
	ld de, $8400 ; $63ac
	ld c, $10 ; $63af
	call Func_00_0480 ; $63b1
	call Func_00_2631 ; $63b4
	ld b, $6f ; $63b7
	ld c, $12 ; $63b9
	ld de, $8500 ; $63bb
	farcall FarPtr_39_10 ; $63be
	call Func_00_2631 ; $63c1
	ld b, $47 ; $63c4
	ld c, $14 ; $63c6
	ld de, $8000 ; $63c8
	farcall FarPtr_39_10 ; $63cb
	call Func_00_2631 ; $63ce
	ld b, $1b ; $63d1
	ld c, $04 ; $63d3
	ld de, $a700 ; $63d5
	farcall FarPtr_39_10 ; $63d8
	ld b, $08 ; $63db
	ld c, $10 ; $63dd
	farcall FarPtr_39_0e ; $63df
	pop af ; $63e2
	ldh [$ff96], a ; $63e3
	ldh [rWBK], a ; $63e5
	ret ; $63e7
	INCBIN "data/bank_03b/d_63e8.bin" ; $63e8, 34 bytes
Func_3b_640a:
	ld a, b ; $640a
	or a, a ; $640b
	jr z, Label_3b_6425 ; $640c
	ld c, $00 ; $640e
Label_3b_6410:
	call Func_00_2631 ; $6410
	ld b, $04 ; $6413
	farcall FarPtr_39_20 ; $6415
	ld b, $00 ; $6418
	farcall FarPtr_39_1e ; $641a
	ld a, c ; $641d
	inc a ; $641e
	ld c, a ; $641f
	cp a, $0e ; $6420
	jr nz, Label_3b_6410 ; $6422
	ret ; $6424
Label_3b_6425:
	ld c, $0c ; $6425
Label_3b_6427:
	call Func_00_2631 ; $6427
	ld b, $05 ; $642a
	farcall FarPtr_39_20 ; $642c
	ld b, $00 ; $642f
	farcall FarPtr_39_1e ; $6431
	ld a, c ; $6434
	dec a ; $6435
	ld c, a ; $6436
	cp a, $ff ; $6437
	jr nz, Label_3b_6427 ; $6439
	ret ; $643b
Func_3b_643c:
	ld a, b ; $643c
	or a, a ; $643d
	jr z, Label_3b_6457 ; $643e
	ld c, $00 ; $6440
Label_3b_6442:
	call Func_00_2631 ; $6442
	ld b, $05 ; $6445
	farcall FarPtr_39_20 ; $6447
	ld b, $00 ; $644a
	farcall FarPtr_39_1e ; $644c
	ld a, c ; $644f
	inc a ; $6450
	ld c, a ; $6451
	cp a, $0b ; $6452
	jr nz, Label_3b_6442 ; $6454
	ret ; $6456
Label_3b_6457:
	ld c, $0d ; $6457
Label_3b_6459:
	call Func_00_2631 ; $6459
	ld b, $04 ; $645c
	farcall FarPtr_39_20 ; $645e
	ld b, $00 ; $6461
	farcall FarPtr_39_1e ; $6463
	ld a, c ; $6466
	dec a ; $6467
	ld c, a ; $6468
	or a, a ; $6469
	jr nz, Label_3b_6459 ; $646a
	ret ; $646c
	farcall FarPtr_39_28 ; $646d
	ld c, $03 ; $6470
	call Func_3b_43b9 ; $6472
	push af ; $6475
	ld hl, $651b ; $6476
	add a, l ; $6479
	ld l, a ; $647a
	jr nc, Label_3b_647e ; $647b
	inc h ; $647d
Label_3b_647e:
	ld c, [hl] ; $647e
	pop af ; $647f
	push af ; $6480
	call Func_3b_64b6 ; $6481
	add a, a ; $6484
	add a, l ; $6485
	ld l, a ; $6486
	jr nc, Label_3b_648a ; $6487
	inc h ; $6489
Label_3b_648a:
	ld a, [hl+] ; $648a
	ld d, [hl] ; $648b
	ld e, a ; $648c
	farcall FarPtr_39_16 ; $648d
	pop af ; $6490
	ld hl, $64f4 ; $6491
	add a, l ; $6494
	ld l, a ; $6495
	jr nc, Label_3b_6499 ; $6496
	inc h ; $6498
Label_3b_6499:
	ld b, [hl] ; $6499
	call Func_3b_654d ; $649a
	ld hl, $64ca ; $649d
	push de ; $64a0
	call Func_00_1e9d ; $64a1
	pop de ; $64a4
	ld hl, $17f8 ; $64a5
	add hl, de ; $64a8
	ld d, h ; $64a9
	ld e, l ; $64aa
	ld hl, $64eb ; $64ab
	ld b, $08 ; $64ae
	ld c, $70 ; $64b0
	call Func_00_1e9d ; $64b2
	ret ; $64b5
Func_3b_64b6:
	push de ; $64b6
	push bc ; $64b7
	push af ; $64b8
	call Func_3b_66f2 ; $64b9
	jr nz, Label_3b_64c3 ; $64bc
	ld hl, $650f ; $64be
	jr Label_3b_64c6 ; $64c1
Label_3b_64c3:
	ld hl, $64fd ; $64c3
Label_3b_64c6:
	pop af ; $64c6
	pop bc ; $64c7
	pop de ; $64c8
	ret ; $64c9
	INCBIN "data/bank_03b/d_64ca.bin" ; $64ca, 131 bytes
Func_3b_654d:
	push bc ; $654d
	push hl ; $654e
	push de ; $654f
	ld c, $03 ; $6550
	call Func_3b_43b9 ; $6552
	ld c, a ; $6555
	call Func_3b_66b5 ; $6556
	cp a, $15 ; $6559
	jr z, Label_3b_6561 ; $655b
	pop de ; $655d
	pop hl ; $655e
	pop bc ; $655f
	ret ; $6560
Label_3b_6561:
	ld c, $50 ; $6561
	ld b, $00 ; $6563
	pop de ; $6565
	pop hl ; $6566
	pop af ; $6567
	ret ; $6568
Func_3b_6569:
	ld a, $03 ; $6569
	ldh [$ff96], a ; $656b
	ldh [rWBK], a ; $656d
	ld de, $d1e0 ; $656f
	ld b, $14 ; $6572
	ld c, $01 ; $6574
	ld h, $03 ; $6576
	farcall FarPtr_39_0c ; $6578
	ld a, $02 ; $657b
	ld [$d1e0], a ; $657d
	ld a, $04 ; $6580
	ld [$d1f3], a ; $6582
	ld de, $d201 ; $6585
	ld b, $12 ; $6588
	ld c, $01 ; $658a
	ld h, $20 ; $658c
	farcall FarPtr_39_0c ; $658e
	call Func_3b_65a0 ; $6591
	ld hl, $d1e0 ; $6594
	ld de, $99e0 ; $6597
	ld c, $04 ; $659a
	call Func_00_0480 ; $659c
	ret ; $659f
Func_3b_65a0:
	ld a, $03 ; $65a0
	ldh [$ff96], a ; $65a2
	ldh [rWBK], a ; $65a4
	ld c, $03 ; $65a6
	call Func_3b_43b9 ; $65a8
	push af ; $65ab
	ld c, a ; $65ac
	call Func_3b_66b5 ; $65ad
	cp a, $15 ; $65b0
	jr nz, Label_3b_65bd ; $65b2
	pop af ; $65b4
	ld hl, $00bb ; $65b5
	ld de, $d201 ; $65b8
	jr Label_3b_65d4 ; $65bb
Label_3b_65bd:
	pop af ; $65bd
	ld b, a ; $65be
	add a, a ; $65bf
	ld hl, $65da ; $65c0
	add a, l ; $65c3
	ld l, a ; $65c4
	jr nc, Label_3b_65c8 ; $65c5
	inc h ; $65c7
Label_3b_65c8:
	ld a, [hl+] ; $65c8
	ld d, [hl] ; $65c9
	ld e, a ; $65ca
	ld a, b ; $65cb
	ld hl, $00b2 ; $65cc
	add a, l ; $65cf
	ld l, a ; $65d0
	jr nc, Label_3b_65d4 ; $65d1
	inc h ; $65d3
Label_3b_65d4:
	ld c, $20 ; $65d4
	farcall FarPtr_05_72 ; $65d6
	ret ; $65d9
	INCBIN "data/bank_03b/d_65da.bin" ; $65da, 18 bytes
Func_3b_65ec:
	ld a, $03 ; $65ec
	ldh [$ff96], a ; $65ee
	ldh [rWBK], a ; $65f0
	ld b, $00 ; $65f2
	ld c, $00 ; $65f4
Label_3b_65f6:
	call Func_3b_6635 ; $65f6
	ld a, b ; $65f9
	inc a ; $65fa
	ld b, a ; $65fb
	cp a, $09 ; $65fc
	jr nz, Label_3b_65f6 ; $65fe
	ld c, $03 ; $6600
	call Func_3b_43b9 ; $6602
	ld b, a ; $6605
	ld c, $01 ; $6606
	call Func_3b_6635 ; $6608
	ld c, $03 ; $660b
	call Func_3b_43b9 ; $660d
	call Func_3b_6672 ; $6610
	ld hl, $d460 ; $6613
	ld de, $b860 ; $6616
	ld c, $06 ; $6619
	call Func_00_0480 ; $661b
	ld hl, $d4e0 ; $661e
	ld de, $b8e0 ; $6621
	ld c, $06 ; $6624
	call Func_00_0480 ; $6626
	ld hl, $d560 ; $6629
	ld de, $b960 ; $662c
	ld c, $06 ; $662f
	call Func_00_0480 ; $6631
	ret ; $6634
Func_3b_6635:
	push af ; $6635
	push bc ; $6636
	push de ; $6637
	push hl ; $6638
	ld d, c ; $6639
	ld e, b ; $663a
	ld b, $03 ; $663b
	ld c, $03 ; $663d
	ld a, d ; $663f
	or a, a ; $6640
	jr z, Label_3b_6647 ; $6641
	ld h, $0c ; $6643
	jr Label_3b_6649 ; $6645
Label_3b_6647:
	ld h, $0d ; $6647
Label_3b_6649:
	push hl ; $6649
	ld hl, $6660 ; $664a
	ld a, e ; $664d
	add a, a ; $664e
	add a, l ; $664f
	ld l, a ; $6650
	jr nc, Label_3b_6654 ; $6651
	inc h ; $6653
Label_3b_6654:
	ld a, [hl+] ; $6654
	ld d, [hl] ; $6655
	ld e, a ; $6656
	pop hl ; $6657
	farcall FarPtr_39_0c ; $6658
	pop hl ; $665b
	pop de ; $665c
	pop bc ; $665d
	pop af ; $665e
	ret ; $665f
	INCBIN "data/bank_03b/d_6660.bin" ; $6660, 18 bytes
Func_3b_6672:
	ld c, a ; $6672
	call Func_3b_66de ; $6673
	farcall FarPtr_02_34 ; $6676
	ld d, $04 ; $6679
	farcall FarPtr_18_02 ; $667b
	ret ; $667e
Func_3b_667f:
	ld c, $00 ; $667f
	ld b, $00 ; $6681
Label_3b_6683:
	ld a, c ; $6683
	add a, a ; $6684
	ld hl, $66a9 ; $6685
	add a, l ; $6688
	ld l, a ; $6689
	jr nc, Label_3b_668d ; $668a
	inc h ; $668c
Label_3b_668d:
	ld a, [hl+] ; $668d
	ld d, [hl] ; $668e
	ld e, a ; $668f
	farcall FarPtr_03_1c ; $6690
	jr z, Label_3b_6699 ; $6693
	ld a, $01 ; $6695
	or a, b ; $6697
	ld b, a ; $6698
Label_3b_6699:
	ld a, c ; $6699
	inc a ; $669a
	ld c, a ; $669b
	cp a, $06 ; $669c
	jr z, Label_3b_66a4 ; $669e
	sla b ; $66a0
	jr Label_3b_6683 ; $66a2
Label_3b_66a4:
	ld a, b ; $66a4
	ld [$cb5d], a ; $66a5
	ret ; $66a8
	INCBIN "data/bank_03b/d_66a9.bin" ; $66a9, 12 bytes
Func_3b_66b5:
	call Func_3b_66de ; $66b5
	cp a, $17 ; $66b8
	ret z ; $66ba
	cp a, $19 ; $66bb
	ret z ; $66bd
	cp a, $18 ; $66be
	ret z ; $66c0
	ld d, a ; $66c1
	sub a, $1a ; $66c2
	ld hl, $66d8 ; $66c4
	add a, l ; $66c7
	ld l, a ; $66c8
	jr nc, Label_3b_66cc ; $66c9
	inc h ; $66cb
Label_3b_66cc:
	ld b, [hl] ; $66cc
	ld a, [$cb5d] ; $66cd
	and a, b ; $66d0
	jr nz, Label_3b_66d6 ; $66d1
	ld a, $15 ; $66d3
	ret ; $66d5
Label_3b_66d6:
	ld a, d ; $66d6
	ret ; $66d7
	INCBIN "data/bank_03b/d_66d8.bin" ; $66d8, 6 bytes
Func_3b_66de:
	ld hl, $66e9 ; $66de
	ld a, c ; $66e1
	add a, l ; $66e2
	ld l, a ; $66e3
	jr nc, Label_3b_66e7 ; $66e4
	inc h ; $66e6
Label_3b_66e7:
	ld a, [hl] ; $66e7
	ret ; $66e8
	INCBIN "data/bank_03b/d_66e9.bin" ; $66e9, 9 bytes
Func_3b_66f2:
	ld c, $06 ; $66f2
	call Func_3b_66b5 ; $66f4
	cp a, $15 ; $66f7
	jr nz, Label_3b_66fd ; $66f9
	xor a, a ; $66fb
	ret ; $66fc
Label_3b_66fd:
	ld a, $01 ; $66fd
	ret ; $66ff
Func_3b_6700:
	ld a, b ; $6700
	or a, a ; $6701
	jr z, Label_3b_671b ; $6702
	ld c, $00 ; $6704
Label_3b_6706:
	call Func_00_2631 ; $6706
	ld b, $16 ; $6709
	farcall FarPtr_39_20 ; $670b
	ld b, $02 ; $670e
	farcall FarPtr_39_1e ; $6710
	ld a, c ; $6713
	inc a ; $6714
	ld c, a ; $6715
	cp a, $0e ; $6716
	jr nz, Label_3b_6706 ; $6718
	ret ; $671a
Label_3b_671b:
	ld c, $0c ; $671b
Label_3b_671d:
	call Func_00_2631 ; $671d
	ld b, $17 ; $6720
	farcall FarPtr_39_20 ; $6722
	ld b, $02 ; $6725
	farcall FarPtr_39_1e ; $6727
	ld a, c ; $672a
	dec a ; $672b
	ld c, a ; $672c
	cp a, $ff ; $672d
	jr nz, Label_3b_671d ; $672f
	ret ; $6731
Func_3b_6732:
	ld a, b ; $6732
	or a, a ; $6733
	jr z, Label_3b_674d ; $6734
	ld c, $00 ; $6736
Label_3b_6738:
	call Func_00_2631 ; $6738
	ld b, $17 ; $673b
	farcall FarPtr_39_20 ; $673d
	ld b, $02 ; $6740
	farcall FarPtr_39_1e ; $6742
	ld a, c ; $6745
	inc a ; $6746
	ld c, a ; $6747
	cp a, $0b ; $6748
	jr nz, Label_3b_6738 ; $674a
	ret ; $674c
Label_3b_674d:
	ld c, $0d ; $674d
Label_3b_674f:
	call Func_00_2631 ; $674f
	ld b, $16 ; $6752
	farcall FarPtr_39_20 ; $6754
	ld b, $02 ; $6757
	farcall FarPtr_39_1e ; $6759
	ld a, c ; $675c
	dec a ; $675d
	ld c, a ; $675e
	or a, a ; $675f
	jr nz, Label_3b_674f ; $6760
	ret ; $6762
Func_3b_6763:
	ld a, $03 ; $6763
	ldh [$ff96], a ; $6765
	ldh [rWBK], a ; $6767
	ld b, $00 ; $6769
	ld c, $00 ; $676b
Label_3b_676d:
	farcall FarPtr_39_60 ; $676d
	ld a, b ; $6770
	inc a ; $6771
	ld b, a ; $6772
	cp a, $06 ; $6773
	jr nz, Label_3b_676d ; $6775
	ld c, $03 ; $6777
	call Func_3b_43b9 ; $6779
	ld b, a ; $677c
	ld c, $01 ; $677d
	farcall FarPtr_39_60 ; $677f
	ld c, $03 ; $6782
	call Func_3b_43b9 ; $6784
	call Func_3b_6672 ; $6787
	ld hl, $d480 ; $678a
	ld de, $b880 ; $678d
	ld c, $06 ; $6790
	call Func_00_0480 ; $6792
	ld hl, $d520 ; $6795
	ld de, $b920 ; $6798
	ld c, $06 ; $679b
	call Func_00_0480 ; $679d
	ret ; $67a0
Func_3b_67a1:
	sound $03 ; $67a1
	ld hl, rIE ; $67a3
	res 2, [hl] ; $67a6
	call Func_3b_5aac ; $67a8
	call Func_3b_686e ; $67ab
	farcall FarPtr_39_24 ; $67ae
	ld b, $01 ; $67b1
	ld c, $01 ; $67b3
	farcall FarPtr_39_26 ; $67b5
	call Func_3b_6c3d ; $67b8
	ld a, $03 ; $67bb
	ldh [$ff96], a ; $67bd
	ldh [rWBK], a ; $67bf
	ld a, [$cb11] ; $67c1
	ld b, a ; $67c4
	farcall FarPtr_3b_22 ; $67c5
	ld a, [$cb1c] ; $67c8
	ld c, a ; $67cb
	ld b, $03 ; $67cc
	call Func_3b_43db ; $67ce
	ld a, $01 ; $67d1
	ld hl, $69dc ; $67d3
	call Func_00_1b6a ; $67d6
	call Func_3b_6a7e ; $67d9
	ld a, $03 ; $67dc
	ldh [$ff96], a ; $67de
	ldh [rWBK], a ; $67e0
Label_3b_67e2:
	call Func_00_2631 ; $67e2
	ldh a, [$ff91] ; $67e5
	ld [$cb0d], a ; $67e7
	farcall FarPtr_3b_26 ; $67ea
	or a, a ; $67ed
	jr z, Label_3b_67f5 ; $67ee
	sound $5e ; $67f0
	call Func_3b_6a7e ; $67f2
Label_3b_67f5:
	ld a, [$cb0d] ; $67f5
	bit 0, a ; $67f8
	jr nz, Label_3b_6802 ; $67fa
	bit 1, a ; $67fc
	jr nz, Label_3b_6857 ; $67fe
	jr Label_3b_67e2 ; $6800
Label_3b_6802:
	ld c, $03 ; $6802
	call Func_3b_43b9 ; $6804
	cp a, $04 ; $6807
	jr nz, Label_3b_6815 ; $6809
	call Func_3b_6c5d ; $680b
	or a, a ; $680e
	jr nz, Label_3b_683a ; $680f
	sound $61 ; $6811
	jr Label_3b_67e2 ; $6813
Label_3b_6815:
	ld c, $03 ; $6815
	call Func_3b_43b9 ; $6817
	cp a, $03 ; $681a
	jp nc, Label_3b_683a ; $681c
	add a, a ; $681f
	add a, a ; $6820
	add a, a ; $6821
	add a, a ; $6822
	ld bc, $d300 ; $6823
	add a, c ; $6826
	ld c, a ; $6827
	jr nc, Label_3b_682b ; $6828
	inc b ; $682a
Label_3b_682b:
	ld hl, $0000 ; $682b
	add hl, bc ; $682e
	ld a, [hl] ; $682f
	cp a, $3f ; $6830
	jr z, Label_3b_6836 ; $6832
	jr Label_3b_683a ; $6834
Label_3b_6836:
	sound $61 ; $6836
	jr Label_3b_67e2 ; $6838
Label_3b_683a:
	sound $5f ; $683a
	call Func_00_1b38 ; $683c
	ld hl, rIE ; $683f
	set 2, [hl] ; $6842
	ld b, $01 ; $6844
	farcall FarPtr_3b_24 ; $6846
	ld a, $01 ; $6849
	ld [$cb11], a ; $684b
	ld c, $03 ; $684e
	call Func_3b_43b9 ; $6850
	ld [$cb1c], a ; $6853
	ret ; $6856
Label_3b_6857:
	sound $62 ; $6857
	call Func_00_1b38 ; $6859
	ld hl, rIE ; $685c
	set 2, [hl] ; $685f
	ld b, $00 ; $6861
	farcall FarPtr_3b_24 ; $6863
	ld a, $00 ; $6866
	ld [$cb11], a ; $6868
	ld a, $ff ; $686b
	ret ; $686d
Func_3b_686e:
	ldh a, [$ff96] ; $686e
	push af ; $6870
	ld a, $01 ; $6871
	ldh [$ff96], a ; $6873
	ldh [rWBK], a ; $6875
	ld hl, $3c14 ; $6877 -> DataPtr_3c_14
	ld de, $d000 ; $687a
	call DecompressDataFromBank ; $687d
	ld hl, $d000 ; $6880
	ld de, $a800 ; $6883
	ld bc, $0010 ; $6886
	call Func_00_0480 ; $6889
	call Func_00_2631 ; $688c
	ld hl, $3c20 ; $688f -> DataPtr_3c_20
	ld de, $d000 ; $6892
	call DecompressDataFromBank ; $6895
	ld hl, $d000 ; $6898
	ld de, $a900 ; $689b
	ld bc, $0010 ; $689e
	call Func_00_0480 ; $68a1
	call Func_00_2631 ; $68a4
	ld a, $03 ; $68a7
	ldh [$ff96], a ; $68a9
	ldh [rWBK], a ; $68ab
	ld a, $00 ; $68ad
	ld [$c36c], a ; $68af
	ld a, [$d300] ; $68b2
	farcall FarPtr_1b_10 ; $68b5
	ld de, $b680 ; $68b8
	farcall FarPtr_1b_18 ; $68bb
	call Func_00_2631 ; $68be
	ld a, $03 ; $68c1
	ldh [$ff96], a ; $68c3
	ldh [rWBK], a ; $68c5
	ld a, $01 ; $68c7
	ld [$c36c], a ; $68c9
	ld a, [$d310] ; $68cc
	farcall FarPtr_1b_10 ; $68cf
	ld de, $b710 ; $68d2
	farcall FarPtr_1b_18 ; $68d5
	call Func_00_2631 ; $68d8
	ld a, $03 ; $68db
	ldh [$ff96], a ; $68dd
	ldh [rWBK], a ; $68df
	ld a, $02 ; $68e1
	ld [$c36c], a ; $68e3
	ld a, [$d320] ; $68e6
	farcall FarPtr_1b_10 ; $68e9
	ld de, $af00 ; $68ec
	farcall FarPtr_1b_18 ; $68ef
	call Func_00_2631 ; $68f2
	ld b, $2a ; $68f5
	ld c, $10 ; $68f7
	ld de, $a000 ; $68f9
	farcall FarPtr_39_10 ; $68fc
	call Func_00_2631 ; $68ff
	ld b, $2b ; $6902
	ld c, $10 ; $6904
	ld de, $a100 ; $6906
	farcall FarPtr_39_10 ; $6909
	call Func_00_2631 ; $690c
	ld b, $2c ; $690f
	ld c, $10 ; $6911
	ld de, $a200 ; $6913
	farcall FarPtr_39_10 ; $6916
	call Func_00_2631 ; $6919
	ld b, $2d ; $691c
	ld c, $10 ; $691e
	ld de, $a300 ; $6920
	farcall FarPtr_39_10 ; $6923
	call Func_00_2631 ; $6926
	ld b, $76 ; $6929
	ld c, $10 ; $692b
	ld de, $a400 ; $692d
	farcall FarPtr_39_10 ; $6930
	call Func_00_2631 ; $6933
	ld b, $1b ; $6936
	ld c, $04 ; $6938
	ld de, $a700 ; $693a
	farcall FarPtr_39_10 ; $693d
	call Func_00_2631 ; $6940
	ld b, $42 ; $6943
	ld c, $14 ; $6945
	ld de, $8000 ; $6947
	farcall FarPtr_39_10 ; $694a
	call Func_00_2631 ; $694d
	ld b, $08 ; $6950
	ld c, $10 ; $6952
	farcall FarPtr_39_0e ; $6954
	pop af ; $6957
	ldh [$ff96], a ; $6958
	ldh [rWBK], a ; $695a
	ret ; $695c
	INCBIN "data/bank_03b/d_695d.bin" ; $695d, 127 bytes
	farcall FarPtr_39_28 ; $69dc
	ld c, $03 ; $69df
	call Func_3b_43b9 ; $69e1
	push af ; $69e4
	ld hl, $6a4f ; $69e5
	add a, l ; $69e8
	ld l, a ; $69e9
	jr nc, Label_3b_69ed ; $69ea
	inc h ; $69ec
Label_3b_69ed:
	ld c, [hl] ; $69ed
	pop af ; $69ee
	ld hl, $6a43 ; $69ef
	add a, a ; $69f2
	add a, l ; $69f3
	ld l, a ; $69f4
	jr nc, Label_3b_69f8 ; $69f5
	inc h ; $69f7
Label_3b_69f8:
	ld a, [hl+] ; $69f8
	ld d, [hl] ; $69f9
	ld e, a ; $69fa
	farcall FarPtr_39_16 ; $69fb
	ld b, $08 ; $69fe
	ld hl, $6a19 ; $6a00
	push de ; $6a03
	call Func_00_1e9d ; $6a04
	pop de ; $6a07
	ld hl, $17f8 ; $6a08
	add hl, de ; $6a0b
	ld d, h ; $6a0c
	ld e, l ; $6a0d
	ld hl, $6a3a ; $6a0e
	ld b, $08 ; $6a11
	ld c, $70 ; $6a13
	call Func_00_1e9d ; $6a15
	ret ; $6a18
	INCBIN "data/bank_03b/d_6a19.bin" ; $6a19, 101 bytes
Func_3b_6a7e:
	ld a, $03 ; $6a7e
	ldh [$ff96], a ; $6a80
	ldh [rWBK], a ; $6a82
	ld b, $00 ; $6a84
	ld c, $00 ; $6a86
Label_3b_6a88:
	call Func_3b_6b0e ; $6a88
	ld a, b ; $6a8b
	inc a ; $6a8c
	ld b, a ; $6a8d
	cp a, $05 ; $6a8e
	jr nz, Label_3b_6a88 ; $6a90
	ld c, $03 ; $6a92
	call Func_3b_43b9 ; $6a94
	ld b, a ; $6a97
	ld c, $01 ; $6a98
	call Func_3b_6b0e ; $6a9a
	ld c, $03 ; $6a9d
	call Func_3b_43b9 ; $6a9f
	cp a, $03 ; $6aa2
	jr nc, Label_3b_6abe ; $6aa4
	add a, a ; $6aa6
	add a, a ; $6aa7
	add a, a ; $6aa8
	add a, a ; $6aa9
	ld bc, $d300 ; $6aaa
	add a, c ; $6aad
	ld c, a ; $6aae
	jr nc, Label_3b_6ab2 ; $6aaf
	inc b ; $6ab1
Label_3b_6ab2:
	ld hl, $0001 ; $6ab2
	add hl, bc ; $6ab5
	ld a, [hl] ; $6ab6
	ld d, $04 ; $6ab7
	farcall FarPtr_18_02 ; $6ab9
	jr Label_3b_6ac1 ; $6abc
Label_3b_6abe:
	call Func_3b_6b4e ; $6abe
Label_3b_6ac1:
	ld a, $03 ; $6ac1
	ldh [$ff96], a ; $6ac3
	ldh [rWBK], a ; $6ac5
	ld de, $d1e0 ; $6ac7
	ld b, $14 ; $6aca
	ld c, $01 ; $6acc
	ld h, $03 ; $6ace
	farcall FarPtr_39_0c ; $6ad0
	ld a, $02 ; $6ad3
	ld [$d1e0], a ; $6ad5
	ld a, $04 ; $6ad8
	ld [$d1f3], a ; $6ada
	ld de, $d201 ; $6add
	ld b, $12 ; $6ae0
	ld c, $01 ; $6ae2
	ld h, $20 ; $6ae4
	farcall FarPtr_39_0c ; $6ae6
	call Func_3b_6b83 ; $6ae9
	ld hl, $d480 ; $6aec
	ld de, $b880 ; $6aef
	ld c, $06 ; $6af2
	call Func_00_0480 ; $6af4
	ld hl, $d520 ; $6af7
	ld de, $b920 ; $6afa
	ld c, $06 ; $6afd
	call Func_00_0480 ; $6aff
	ld hl, $d1e0 ; $6b02
	ld de, $99e0 ; $6b05
	ld c, $04 ; $6b08
	call Func_00_0480 ; $6b0a
	ret ; $6b0d
Func_3b_6b0e:
	push af ; $6b0e
	push bc ; $6b0f
	push de ; $6b10
	push hl ; $6b11
	ld d, c ; $6b12
	ld e, b ; $6b13
	ld a, b ; $6b14
	cp a, $03 ; $6b15
	jr nc, Label_3b_6b1f ; $6b17
	ld b, $03 ; $6b19
	ld c, $03 ; $6b1b
	jr Label_3b_6b23 ; $6b1d
Label_3b_6b1f:
	ld b, $05 ; $6b1f
	ld c, $03 ; $6b21
Label_3b_6b23:
	ld a, d ; $6b23
	or a, a ; $6b24
	jr z, Label_3b_6b2b ; $6b25
	ld h, $0c ; $6b27
	jr Label_3b_6b2d ; $6b29
Label_3b_6b2b:
	ld h, $0d ; $6b2b
Label_3b_6b2d:
	push hl ; $6b2d
	ld hl, $6b44 ; $6b2e
	ld a, e ; $6b31
	add a, a ; $6b32
	add a, l ; $6b33
	ld l, a ; $6b34
	jr nc, Label_3b_6b38 ; $6b35
	inc h ; $6b37
Label_3b_6b38:
	ld a, [hl+] ; $6b38
	ld d, [hl] ; $6b39
	ld e, a ; $6b3a
	pop hl ; $6b3b
	farcall FarPtr_39_0c ; $6b3c
	pop hl ; $6b3f
	pop de ; $6b40
	pop bc ; $6b41
	pop af ; $6b42
	ret ; $6b43
	INCBIN "data/bank_03b/d_6b44.bin" ; $6b44, 10 bytes
Func_3b_6b4e:
	ld hl, $6b61 ; $6b4e
	add a, a ; $6b51
	add a, l ; $6b52
	ld l, a ; $6b53
	jr nc, Label_3b_6b57 ; $6b54
	inc h ; $6b56
Label_3b_6b57:
	ld a, [hl+] ; $6b57
	ld h, [hl] ; $6b58
	ld l, a ; $6b59
	ld de, $0401 ; $6b5a
	call LoadPaletteShadow ; $6b5d
	ret ; $6b60
	INCBIN "data/bank_03b/d_6b61.bin" ; $6b61, 34 bytes
Func_3b_6b83:
	ldh a, [$ff96] ; $6b83
	push af ; $6b85
	ld a, $03 ; $6b86
	ldh [$ff96], a ; $6b88
	ldh [rWBK], a ; $6b8a
	ld c, $03 ; $6b8c
	call Func_3b_43b9 ; $6b8e
	ld b, a ; $6b91
	cp a, $03 ; $6b92
	jp nc, Label_3b_6c1b ; $6b94
	add a, a ; $6b97
	add a, a ; $6b98
	add a, a ; $6b99
	add a, a ; $6b9a
	ld bc, $d300 ; $6b9b
	add a, c ; $6b9e
	ld c, a ; $6b9f
	jr nc, Label_3b_6ba3 ; $6ba0
	inc b ; $6ba2
Label_3b_6ba3:
	ld hl, $0000 ; $6ba3
	add hl, bc ; $6ba6
	ld a, [hl] ; $6ba7
	cp a, $3f ; $6ba8
	jr z, Label_3b_6c0e ; $6baa
	ld hl, $0003 ; $6bac
	add hl, bc ; $6baf
	ld de, $d201 ; $6bb0
	call Func_3b_442c ; $6bb3
	ld a, $4c ; $6bb6
	ld [$d209], a ; $6bb8
	ld a, $56 ; $6bbb
	ld [$d20a], a ; $6bbd
	push af ; $6bc0
	push bc ; $6bc1
	push de ; $6bc2
	push hl ; $6bc3
	ld hl, $0002 ; $6bc4
	add hl, bc ; $6bc7
	ld a, [hl] ; $6bc8
	ld h, $00 ; $6bc9
	ld l, a ; $6bcb
	ld de, $d20c ; $6bcc
	ld bc, $d330 ; $6bcf
	call Func_3b_5c2b ; $6bd2
	pop hl ; $6bd5
	pop de ; $6bd6
	pop bc ; $6bd7
	pop af ; $6bd8
	push af ; $6bd9
	push bc ; $6bda
	push de ; $6bdb
	push hl ; $6bdc
	ld hl, $000f ; $6bdd
	add hl, bc ; $6be0
	ld a, [hl] ; $6be1
	ld h, $00 ; $6be2
	ld l, a ; $6be4
	ld de, $d20f ; $6be5
	ld bc, $d330 ; $6be8
	call Func_3b_5c27 ; $6beb
	pop hl ; $6bee
	pop de ; $6bef
	pop bc ; $6bf0
	pop af ; $6bf1
	ld hl, $000e ; $6bf2
	add hl, bc ; $6bf5
	ld a, [hl] ; $6bf6
	ld h, $00 ; $6bf7
	ld l, a ; $6bf9
	ld de, $d212 ; $6bfa
	ld bc, $d330 ; $6bfd
	call Func_3b_5c27 ; $6c00
	ld a, $3a ; $6c03
	ld [$d210], a ; $6c05
	pop af ; $6c08
	ldh [$ff96], a ; $6c09
	ldh [rWBK], a ; $6c0b
	ret ; $6c0d
Label_3b_6c0e:
	ld hl, $00c8 ; $6c0e
	ld de, $d201 ; $6c11
	ld c, $20 ; $6c14
	farcall FarPtr_05_72 ; $6c16
	jr Label_3b_6c37 ; $6c19
Label_3b_6c1b:
	cp a, $04 ; $6c1b
	jr nz, Label_3b_6c2c ; $6c1d
	ld hl, $00c7 ; $6c1f
	ld de, $d201 ; $6c22
	ld c, $20 ; $6c25
	farcall FarPtr_05_72 ; $6c27
	jr Label_3b_6c37 ; $6c2a
Label_3b_6c2c:
	ld hl, $00c9 ; $6c2c
	ld de, $d201 ; $6c2f
	ld c, $20 ; $6c32
	farcall FarPtr_05_72 ; $6c34
Label_3b_6c37:
	pop af ; $6c37
	ldh [$ff96], a ; $6c38
	ldh [rWBK], a ; $6c3a
	ret ; $6c3c
Func_3b_6c3d:
	ldh a, [$ff96] ; $6c3d
	push af ; $6c3f
	ld a, $02 ; $6c40
	ldh [$ff96], a ; $6c42
	ldh [rWBK], a ; $6c44
	ld hl, $d000 ; $6c46
	ld bc, $0020 ; $6c49
	call ClearMemory16 ; $6c4c
	ld hl, $d000 ; $6c4f
	ld b, $0b ; $6c52
	farcall FarPtr_03_06 ; $6c54
	pop af ; $6c57
	ldh [$ff96], a ; $6c58
	ldh [rWBK], a ; $6c5a
	ret ; $6c5c
Func_3b_6c5d:
	ldh a, [$ff96] ; $6c5d
	push af ; $6c5f
	ld a, $02 ; $6c60
	ldh [$ff96], a ; $6c62
	ldh [rWBK], a ; $6c64
	ld a, [$d000] ; $6c66
	ld b, a ; $6c69
	ld a, [$d001] ; $6c6a
	or a, b ; $6c6d
	jr z, Label_3b_6c78 ; $6c6e
	pop af ; $6c70
	ldh [$ff96], a ; $6c71
	ldh [rWBK], a ; $6c73
	ld a, $01 ; $6c75
	ret ; $6c77
Label_3b_6c78:
	pop af ; $6c78
	ldh [$ff96], a ; $6c79
	ldh [rWBK], a ; $6c7b
	xor a, a ; $6c7d
	ret ; $6c7e
Func_3b_6c7f:
	ld hl, rIE ; $6c7f
	res 2, [hl] ; $6c82
	sound $03 ; $6c84
	call Func_3b_5aac ; $6c86
	call Func_3b_6d31 ; $6c89
	ld a, $03 ; $6c8c
	ldh [$ff96], a ; $6c8e
	ldh [rWBK], a ; $6c90
	ld a, [$cb11] ; $6c92
	ld b, a ; $6c95
	call Func_3b_6e24 ; $6c96
	farcall FarPtr_39_24 ; $6c99
	ld b, $01 ; $6c9c
	ld c, $01 ; $6c9e
	farcall FarPtr_39_26 ; $6ca0
	ld c, $00 ; $6ca3
	ld b, $03 ; $6ca5
	call Func_3b_43db ; $6ca7
	ld a, $01 ; $6caa
	ld hl, $6f5b ; $6cac
	call Func_00_1b6a ; $6caf
	call Func_3b_6ffb ; $6cb2
	ld a, $03 ; $6cb5
	ldh [$ff96], a ; $6cb7
	ldh [rWBK], a ; $6cb9
Label_3b_6cbb:
	ldh a, [$ff91] ; $6cbb
	ld [$cb0d], a ; $6cbd
	call Func_3b_6e87 ; $6cc0
	or a, a ; $6cc3
	jr z, Label_3b_6ccb ; $6cc4
	sound $5e ; $6cc6
	call Func_3b_6ffb ; $6cc8
Label_3b_6ccb:
	call Func_00_2631 ; $6ccb
	ld a, [$cb0d] ; $6cce
	bit 0, a ; $6cd1
	jr nz, Label_3b_6cdb ; $6cd3
	bit 1, a ; $6cd5
	jr nz, Label_3b_6d1a ; $6cd7
	jr Label_3b_6cbb ; $6cd9
Label_3b_6cdb:
	ld c, $03 ; $6cdb
	call Func_3b_43b9 ; $6cdd
	cp a, $03 ; $6ce0
	jp nc, Label_3b_6d00 ; $6ce2
	add a, a ; $6ce5
	add a, a ; $6ce6
	add a, a ; $6ce7
	add a, a ; $6ce8
	ld bc, $d300 ; $6ce9
	add a, c ; $6cec
	ld c, a ; $6ced
	jr nc, Label_3b_6cf1 ; $6cee
	inc b ; $6cf0
Label_3b_6cf1:
	ld hl, $0000 ; $6cf1
	add hl, bc ; $6cf4
	ld a, [hl] ; $6cf5
	cp a, $3f ; $6cf6
	jr z, Label_3b_6cfc ; $6cf8
	jr Label_3b_6d00 ; $6cfa
Label_3b_6cfc:
	sound $62 ; $6cfc
	jr Label_3b_6cbb ; $6cfe
Label_3b_6d00:
	sound $5f ; $6d00
	call Func_00_1b38 ; $6d02
	ld hl, rIE ; $6d05
	set 2, [hl] ; $6d08
	ld b, $01 ; $6d0a
	call Func_3b_6e56 ; $6d0c
	ld a, $01 ; $6d0f
	ld [$cb11], a ; $6d11
	ld c, $03 ; $6d14
	call Func_3b_43b9 ; $6d16
	ret ; $6d19
Label_3b_6d1a:
	sound $62 ; $6d1a
	call Func_00_1b38 ; $6d1c
	ld hl, rIE ; $6d1f
	set 2, [hl] ; $6d22
	ld b, $00 ; $6d24
	call Func_3b_6e56 ; $6d26
	ld a, $00 ; $6d29
	ld [$cb11], a ; $6d2b
	ld a, $ff ; $6d2e
	ret ; $6d30
Func_3b_6d31:
	ldh a, [$ff96] ; $6d31
	push af ; $6d33
	ld a, $01 ; $6d34
	ldh [$ff96], a ; $6d36
	ldh [rWBK], a ; $6d38
	ld a, $03 ; $6d3a
	ldh [$ff96], a ; $6d3c
	ldh [rWBK], a ; $6d3e
	ld a, $00 ; $6d40
	ld [$c36c], a ; $6d42
	ld a, [$d300] ; $6d45
	farcall FarPtr_1b_10 ; $6d48
	ld de, $b680 ; $6d4b
	farcall FarPtr_1b_18 ; $6d4e
	call Func_00_2631 ; $6d51
	ld a, $03 ; $6d54
	ldh [$ff96], a ; $6d56
	ldh [rWBK], a ; $6d58
	ld a, $01 ; $6d5a
	ld [$c36c], a ; $6d5c
	ld a, [$d310] ; $6d5f
	farcall FarPtr_1b_10 ; $6d62
	ld de, $b710 ; $6d65
	farcall FarPtr_1b_18 ; $6d68
	call Func_00_2631 ; $6d6b
	ld a, $03 ; $6d6e
	ldh [$ff96], a ; $6d70
	ldh [rWBK], a ; $6d72
	ld a, $02 ; $6d74
	ld [$c36c], a ; $6d76
	ld a, [$d320] ; $6d79
	farcall FarPtr_1b_10 ; $6d7c
	ld de, $af00 ; $6d7f
	farcall FarPtr_1b_18 ; $6d82
	call Func_00_2631 ; $6d85
	ld a, $01 ; $6d88
	ldh [$ff96], a ; $6d8a
	ldh [rWBK], a ; $6d8c
	ld hl, $3d0e ; $6d8e -> DataPtr_3d_0e
	ld de, $d000 ; $6d91
	call DecompressDataFromBank ; $6d94
	ld hl, $d000 ; $6d97
	ld de, $a800 ; $6d9a
	ld c, $10 ; $6d9d
	call Func_00_0480 ; $6d9f
	call Func_00_2631 ; $6da2
	ld hl, $3d10 ; $6da5 -> DataPtr_3d_10
	ld de, $d000 ; $6da8
	call DecompressDataFromBank ; $6dab
	ld hl, $d000 ; $6dae
	ld de, $a900 ; $6db1
	ld c, $10 ; $6db4
	call Func_00_0480 ; $6db6
	call Func_00_2631 ; $6db9
	ld b, $2e ; $6dbc
	ld c, $10 ; $6dbe
	ld de, $a000 ; $6dc0
	farcall FarPtr_39_10 ; $6dc3
	call Func_00_2631 ; $6dc6
	ld b, $2f ; $6dc9
	ld c, $10 ; $6dcb
	ld de, $a100 ; $6dcd
	farcall FarPtr_39_10 ; $6dd0
	call Func_00_2631 ; $6dd3
	ld b, $30 ; $6dd6
	ld c, $10 ; $6dd8
	ld de, $a200 ; $6dda
	farcall FarPtr_39_10 ; $6ddd
	call Func_00_2631 ; $6de0
	ld b, $31 ; $6de3
	ld c, $10 ; $6de5
	ld de, $a300 ; $6de7
	farcall FarPtr_39_10 ; $6dea
	call Func_00_2631 ; $6ded
	ld b, $32 ; $6df0
	ld c, $10 ; $6df2
	ld de, $a400 ; $6df4
	farcall FarPtr_39_10 ; $6df7
	call Func_00_2631 ; $6dfa
	ld b, $1b ; $6dfd
	ld c, $04 ; $6dff
	ld de, $a700 ; $6e01
	farcall FarPtr_39_10 ; $6e04
	call Func_00_2631 ; $6e07
	ld b, $41 ; $6e0a
	ld c, $14 ; $6e0c
	ld de, $8000 ; $6e0e
	farcall FarPtr_39_10 ; $6e11
	call Func_00_2631 ; $6e14
	ld b, $08 ; $6e17
	ld c, $10 ; $6e19
	farcall FarPtr_39_0e ; $6e1b
	pop af ; $6e1e
	ldh [$ff96], a ; $6e1f
	ldh [rWBK], a ; $6e21
	ret ; $6e23
Func_3b_6e24:
	ld a, b ; $6e24
	or a, a ; $6e25
	jr z, Label_3b_6e3f ; $6e26
	ld c, $00 ; $6e28
Label_3b_6e2a:
	call Func_00_2631 ; $6e2a
	ld b, $08 ; $6e2d
	farcall FarPtr_39_20 ; $6e2f
	ld b, $02 ; $6e32
	farcall FarPtr_39_1e ; $6e34
	ld a, c ; $6e37
	inc a ; $6e38
	ld c, a ; $6e39
	cp a, $0f ; $6e3a
	jr nz, Label_3b_6e2a ; $6e3c
	ret ; $6e3e
Label_3b_6e3f:
	ld c, $0b ; $6e3f
Label_3b_6e41:
	call Func_00_2631 ; $6e41
	ld b, $09 ; $6e44
	farcall FarPtr_39_20 ; $6e46
	ld b, $02 ; $6e49
	farcall FarPtr_39_1e ; $6e4b
	ld a, c ; $6e4e
	dec a ; $6e4f
	ld c, a ; $6e50
	cp a, $ff ; $6e51
	jr nz, Label_3b_6e41 ; $6e53
	ret ; $6e55
Func_3b_6e56:
	ld a, b ; $6e56
	or a, a ; $6e57
	jr z, Label_3b_6e71 ; $6e58
	ld c, $00 ; $6e5a
Label_3b_6e5c:
	call Func_00_2631 ; $6e5c
	ld b, $09 ; $6e5f
	farcall FarPtr_39_20 ; $6e61
	ld b, $02 ; $6e64
	farcall FarPtr_39_1e ; $6e66
	ld a, c ; $6e69
	inc a ; $6e6a
	ld c, a ; $6e6b
	cp a, $0a ; $6e6c
	jr nz, Label_3b_6e5c ; $6e6e
	ret ; $6e70
Label_3b_6e71:
	ld c, $0e ; $6e71
Label_3b_6e73:
	call Func_00_2631 ; $6e73
	ld b, $08 ; $6e76
	farcall FarPtr_39_20 ; $6e78
	ld b, $02 ; $6e7b
	farcall FarPtr_39_1e ; $6e7d
	ld a, c ; $6e80
	dec a ; $6e81
	ld c, a ; $6e82
	or a, a ; $6e83
	jr nz, Label_3b_6e73 ; $6e84
	ret ; $6e86
Func_3b_6e87:
	ld a, [$cb05] ; $6e87
	or a, a ; $6e8a
	jr nz, Label_3b_6ef2 ; $6e8b
	ld a, [$cb0d] ; $6e8d
	bit 4, a ; $6e90
	jr nz, Label_3b_6ea4 ; $6e92
	bit 5, a ; $6e94
	jr nz, Label_3b_6ebe ; $6e96
	bit 6, a ; $6e98
	jr nz, Label_3b_6ed7 ; $6e9a
	bit 7, a ; $6e9c
	jr nz, Label_3b_6ed7 ; $6e9e
	xor a, a ; $6ea0
	jp Label_3b_6f55 ; $6ea1
Label_3b_6ea4:
	ld a, [$cb04] ; $6ea4
	inc a ; $6ea7
	add a, a ; $6ea8
	jr nc, Label_3b_6eb0 ; $6ea9
	ld a, $03 ; $6eab
	dec a ; $6ead
	jr Label_3b_6eb6 ; $6eae
Label_3b_6eb0:
	rra ; $6eb0
	cp a, $03 ; $6eb1
	jr c, Label_3b_6eb6 ; $6eb3
	xor a, a ; $6eb5
Label_3b_6eb6:
	ld [$cb04], a ; $6eb6
	ld a, $01 ; $6eb9
	jp Label_3b_6f55 ; $6ebb
Label_3b_6ebe:
	ld a, [$cb04] ; $6ebe
	dec a ; $6ec1
	add a, a ; $6ec2
	jr nc, Label_3b_6eca ; $6ec3
	ld a, $03 ; $6ec5
	dec a ; $6ec7
	jr Label_3b_6ed0 ; $6ec8
Label_3b_6eca:
	rra ; $6eca
	cp a, $03 ; $6ecb
	jr c, Label_3b_6ed0 ; $6ecd
	xor a, a ; $6ecf
Label_3b_6ed0:
	ld [$cb04], a ; $6ed0
	ld a, $01 ; $6ed3
	jr Label_3b_6f55 ; $6ed5
Label_3b_6ed7:
	ld a, [$cb04] ; $6ed7
	ld hl, $6f56 ; $6eda
	add a, l ; $6edd
	ld l, a ; $6ede
	jr nc, Label_3b_6ee2 ; $6edf
	inc h ; $6ee1
Label_3b_6ee2:
	ld a, [hl] ; $6ee2
	ld [$cb04], a ; $6ee3
	ld a, [$cb05] ; $6ee6
	xor a, $01 ; $6ee9
	ld [$cb05], a ; $6eeb
	ld a, $01 ; $6eee
	jr Label_3b_6f55 ; $6ef0
Label_3b_6ef2:
	ld a, [$cb0d] ; $6ef2
	bit 4, a ; $6ef5
	jr nz, Label_3b_6f08 ; $6ef7
	bit 5, a ; $6ef9
	jr nz, Label_3b_6f21 ; $6efb
	bit 6, a ; $6efd
	jr nz, Label_3b_6f3a ; $6eff
	bit 7, a ; $6f01
	jr nz, Label_3b_6f3a ; $6f03
	xor a, a ; $6f05
	jr Label_3b_6f55 ; $6f06
Label_3b_6f08:
	ld a, [$cb04] ; $6f08
	inc a ; $6f0b
	add a, a ; $6f0c
	jr nc, Label_3b_6f14 ; $6f0d
	ld a, $02 ; $6f0f
	dec a ; $6f11
	jr Label_3b_6f1a ; $6f12
Label_3b_6f14:
	rra ; $6f14
	cp a, $02 ; $6f15
	jr c, Label_3b_6f1a ; $6f17
	xor a, a ; $6f19
Label_3b_6f1a:
	ld [$cb04], a ; $6f1a
	ld a, $01 ; $6f1d
	jr Label_3b_6f55 ; $6f1f
Label_3b_6f21:
	ld a, [$cb04] ; $6f21
	dec a ; $6f24
	add a, a ; $6f25
	jr nc, Label_3b_6f2d ; $6f26
	ld a, $02 ; $6f28
	dec a ; $6f2a
	jr Label_3b_6f33 ; $6f2b
Label_3b_6f2d:
	rra ; $6f2d
	cp a, $02 ; $6f2e
	jr c, Label_3b_6f33 ; $6f30
	xor a, a ; $6f32
Label_3b_6f33:
	ld [$cb04], a ; $6f33
	ld a, $01 ; $6f36
	jr Label_3b_6f55 ; $6f38
Label_3b_6f3a:
	ld a, [$cb04] ; $6f3a
	ld hl, $6f59 ; $6f3d
	add a, l ; $6f40
	ld l, a ; $6f41
	jr nc, Label_3b_6f45 ; $6f42
	inc h ; $6f44
Label_3b_6f45:
	ld a, [hl] ; $6f45
	ld [$cb04], a ; $6f46
	ld a, [$cb05] ; $6f49
	xor a, $01 ; $6f4c
	ld [$cb05], a ; $6f4e
	ld a, $01 ; $6f51
	jr Label_3b_6f55 ; $6f53
Label_3b_6f55:
	ret ; $6f55
	INCBIN "data/bank_03b/d_6f56.bin" ; $6f56, 8 bytes
	ld c, $03 ; $6f5e
	call Func_3b_43b9 ; $6f60
	push af ; $6f63
	ld hl, $6fcc ; $6f64
	add a, l ; $6f67
	ld l, a ; $6f68
	jr nc, Label_3b_6f6c ; $6f69
	inc h ; $6f6b
Label_3b_6f6c:
	ld c, [hl] ; $6f6c
	pop af ; $6f6d
	ld hl, $6fc2 ; $6f6e
	add a, a ; $6f71
	add a, l ; $6f72
	ld l, a ; $6f73
	jr nc, Label_3b_6f77 ; $6f74
	inc h ; $6f76
Label_3b_6f77:
	ld a, [hl+] ; $6f77
	ld d, [hl] ; $6f78
	ld e, a ; $6f79
	farcall FarPtr_39_16 ; $6f7a
	ld b, $08 ; $6f7d
	ld hl, $6f98 ; $6f7f
	push de ; $6f82
	call Func_00_1e9d ; $6f83
	pop de ; $6f86
	ld hl, $17f8 ; $6f87
	add hl, de ; $6f8a
	ld d, h ; $6f8b
	ld e, l ; $6f8c
	ld hl, $6fb9 ; $6f8d
	ld b, $08 ; $6f90
	ld c, $70 ; $6f92
	call Func_00_1e9d ; $6f94
	ret ; $6f97
	INCBIN "data/bank_03b/d_6f98.bin" ; $6f98, 99 bytes
Func_3b_6ffb:
	ld a, $03 ; $6ffb
	ldh [$ff96], a ; $6ffd
	ldh [rWBK], a ; $6fff
	ld b, $00 ; $7001
	ld c, $00 ; $7003
Label_3b_7005:
	call Func_3b_708b ; $7005
	ld a, b ; $7008
	inc a ; $7009
	ld b, a ; $700a
	cp a, $05 ; $700b
	jr nz, Label_3b_7005 ; $700d
	ld c, $03 ; $700f
	call Func_3b_43b9 ; $7011
	ld b, a ; $7014
	ld c, $01 ; $7015
	call Func_3b_708b ; $7017
	ld c, $03 ; $701a
	call Func_3b_43b9 ; $701c
	cp a, $03 ; $701f
	jr nc, Label_3b_703b ; $7021
	add a, a ; $7023
	add a, a ; $7024
	add a, a ; $7025
	add a, a ; $7026
	ld bc, $d300 ; $7027
	add a, c ; $702a
	ld c, a ; $702b
	jr nc, Label_3b_702f ; $702c
	inc b ; $702e
Label_3b_702f:
	ld hl, $0001 ; $702f
	add hl, bc ; $7032
	ld a, [hl] ; $7033
	ld d, $04 ; $7034
	farcall FarPtr_18_02 ; $7036
	jr Label_3b_703e ; $7039
Label_3b_703b:
	call Func_3b_70cb ; $703b
Label_3b_703e:
	ld a, $03 ; $703e
	ldh [$ff96], a ; $7040
	ldh [rWBK], a ; $7042
	ld de, $d1e0 ; $7044
	ld b, $14 ; $7047
	ld c, $01 ; $7049
	ld h, $03 ; $704b
	farcall FarPtr_39_0c ; $704d
	ld a, $02 ; $7050
	ld [$d1e0], a ; $7052
	ld a, $04 ; $7055
	ld [$d1f3], a ; $7057
	ld de, $d201 ; $705a
	ld b, $12 ; $705d
	ld c, $01 ; $705f
	ld h, $20 ; $7061
	farcall FarPtr_39_0c ; $7063
	call Func_3b_7100 ; $7066
	ld hl, $d480 ; $7069
	ld de, $b880 ; $706c
	ld c, $06 ; $706f
	call Func_00_0480 ; $7071
	ld hl, $d520 ; $7074
	ld de, $b920 ; $7077
	ld c, $06 ; $707a
	call Func_00_0480 ; $707c
	ld hl, $d1e0 ; $707f
	ld de, $99e0 ; $7082
	ld c, $04 ; $7085
	call Func_00_0480 ; $7087
	ret ; $708a
Func_3b_708b:
	push af ; $708b
	push bc ; $708c
	push de ; $708d
	push hl ; $708e
	ld d, c ; $708f
	ld e, b ; $7090
	ld a, b ; $7091
	cp a, $03 ; $7092
	jr nc, Label_3b_709c ; $7094
	ld b, $03 ; $7096
	ld c, $03 ; $7098
	jr Label_3b_70a0 ; $709a
Label_3b_709c:
	ld b, $05 ; $709c
	ld c, $03 ; $709e
Label_3b_70a0:
	ld a, d ; $70a0
	or a, a ; $70a1
	jr z, Label_3b_70a8 ; $70a2
	ld h, $0c ; $70a4
	jr Label_3b_70aa ; $70a6
Label_3b_70a8:
	ld h, $0d ; $70a8
Label_3b_70aa:
	push hl ; $70aa
	ld hl, $70c1 ; $70ab
	ld a, e ; $70ae
	add a, a ; $70af
	add a, l ; $70b0
	ld l, a ; $70b1
	jr nc, Label_3b_70b5 ; $70b2
	inc h ; $70b4
Label_3b_70b5:
	ld a, [hl+] ; $70b5
	ld d, [hl] ; $70b6
	ld e, a ; $70b7
	pop hl ; $70b8
	farcall FarPtr_39_0c ; $70b9
	pop hl ; $70bc
	pop de ; $70bd
	pop bc ; $70be
	pop af ; $70bf
	ret ; $70c0
	INCBIN "data/bank_03b/d_70c1.bin" ; $70c1, 10 bytes
Func_3b_70cb:
	ld hl, $70de ; $70cb
	add a, a ; $70ce
	add a, l ; $70cf
	ld l, a ; $70d0
	jr nc, Label_3b_70d4 ; $70d1
	inc h ; $70d3
Label_3b_70d4:
	ld a, [hl+] ; $70d4
	ld h, [hl] ; $70d5
	ld l, a ; $70d6
	ld de, $0401 ; $70d7
	call LoadPaletteShadow ; $70da
	ret ; $70dd
	INCBIN "data/bank_03b/d_70de.bin" ; $70de, 34 bytes
Func_3b_7100:
	ldh a, [$ff96] ; $7100
	push af ; $7102
	ld a, $03 ; $7103
	ldh [$ff96], a ; $7105
	ldh [rWBK], a ; $7107
	ld c, $03 ; $7109
	call Func_3b_43b9 ; $710b
	ld b, a ; $710e
	cp a, $03 ; $710f
	jp nc, Label_3b_7198 ; $7111
	add a, a ; $7114
	add a, a ; $7115
	add a, a ; $7116
	add a, a ; $7117
	ld bc, $d300 ; $7118
	add a, c ; $711b
	ld c, a ; $711c
	jr nc, Label_3b_7120 ; $711d
	inc b ; $711f
Label_3b_7120:
	ld hl, $0000 ; $7120
	add hl, bc ; $7123
	ld a, [hl] ; $7124
	cp a, $3f ; $7125
	jr z, Label_3b_718b ; $7127
	ld hl, $0003 ; $7129
	add hl, bc ; $712c
	ld de, $d201 ; $712d
	call Func_3b_442c ; $7130
	ld a, $4c ; $7133
	ld [$d209], a ; $7135
	ld a, $56 ; $7138
	ld [$d20a], a ; $713a
	push af ; $713d
	push bc ; $713e
	push de ; $713f
	push hl ; $7140
	ld hl, $0002 ; $7141
	add hl, bc ; $7144
	ld a, [hl] ; $7145
	ld h, $00 ; $7146
	ld l, a ; $7148
	ld de, $d20c ; $7149
	ld bc, $d330 ; $714c
	call Func_3b_5c2b ; $714f
	pop hl ; $7152
	pop de ; $7153
	pop bc ; $7154
	pop af ; $7155
	push af ; $7156
	push bc ; $7157
	push de ; $7158
	push hl ; $7159
	ld hl, $000f ; $715a
	add hl, bc ; $715d
	ld a, [hl] ; $715e
	ld h, $00 ; $715f
	ld l, a ; $7161
	ld de, $d20f ; $7162
	ld bc, $d330 ; $7165
	call Func_3b_5c27 ; $7168
	pop hl ; $716b
	pop de ; $716c
	pop bc ; $716d
	pop af ; $716e
	ld hl, $000e ; $716f
	add hl, bc ; $7172
	ld a, [hl] ; $7173
	ld h, $00 ; $7174
	ld l, a ; $7176
	ld de, $d212 ; $7177
	ld bc, $d330 ; $717a
	call Func_3b_5c27 ; $717d
	ld a, $3a ; $7180
	ld [$d210], a ; $7182
	pop af ; $7185
	ldh [$ff96], a ; $7186
	ldh [rWBK], a ; $7188
	ret ; $718a
Label_3b_718b:
	ld hl, $00ce ; $718b
	ld de, $d201 ; $718e
	ld c, $20 ; $7191
	farcall FarPtr_05_72 ; $7193
	jr Label_3b_71aa ; $7196
Label_3b_7198:
	ld hl, $00cc ; $7198
	sub a, $03 ; $719b
	add a, l ; $719d
	ld l, a ; $719e
	jr nc, Label_3b_71a2 ; $719f
	inc h ; $71a1
Label_3b_71a2:
	ld de, $d201 ; $71a2
	ld c, $20 ; $71a5
	farcall FarPtr_05_72 ; $71a7
Label_3b_71aa:
	pop af ; $71aa
	ldh [$ff96], a ; $71ab
	ldh [rWBK], a ; $71ad
	ret ; $71af
Func_3b_71b0:
	sound $03 ; $71b0
	ld hl, rIE ; $71b2
	res 2, [hl] ; $71b5
	call Func_3b_7243 ; $71b7
	farcall FarPtr_39_24 ; $71ba
	ld b, $01 ; $71bd
	ld c, $01 ; $71bf
	farcall FarPtr_39_26 ; $71c1
	ld a, $03 ; $71c4
	ldh [$ff96], a ; $71c6
	ldh [rWBK], a ; $71c8
	ld a, [$cb11] ; $71ca
	ld b, a ; $71cd
	call Func_3b_72ec ; $71ce
	ld a, [$cb1e] ; $71d1
	ld c, a ; $71d4
	ld b, $03 ; $71d5
	call Func_3b_43db ; $71d7
	ld a, $01 ; $71da
	ld hl, $734f ; $71dc
	call Func_00_1b6a ; $71df
	call Func_3b_73bf ; $71e2
	ld a, $03 ; $71e5
	ldh [$ff96], a ; $71e7
	ldh [rWBK], a ; $71e9
Label_3b_71eb:
	call Func_00_2631 ; $71eb
	ldh a, [$ff91] ; $71ee
	ld [$cb0d], a ; $71f0
	ld b, $03 ; $71f3
	ld c, $01 ; $71f5
	call Func_3b_412a ; $71f7
	or a, a ; $71fa
	jr z, Label_3b_7202 ; $71fb
	sound $5e ; $71fd
	call Func_3b_73bf ; $71ff
Label_3b_7202:
	ld a, [$cb0d] ; $7202
	bit 0, a ; $7205
	jr nz, Label_3b_720f ; $7207
	bit 1, a ; $7209
	jr nz, Label_3b_722c ; $720b
	jr Label_3b_71eb ; $720d
Label_3b_720f:
	sound $5f ; $720f
	call Func_00_1b38 ; $7211
	ld hl, rIE ; $7214
	set 2, [hl] ; $7217
	ld b, $01 ; $7219
	call Func_3b_731e ; $721b
	ld a, $01 ; $721e
	ld [$cb11], a ; $7220
	ld c, $03 ; $7223
	call Func_3b_43b9 ; $7225
	ld [$cb1e], a ; $7228
	ret ; $722b
Label_3b_722c:
	sound $62 ; $722c
	call Func_00_1b38 ; $722e
	ld hl, rIE ; $7231
	set 2, [hl] ; $7234
	ld b, $00 ; $7236
	call Func_3b_731e ; $7238
	ld a, $00 ; $723b
	ld [$cb11], a ; $723d
	ld a, $ff ; $7240
	ret ; $7242
Func_3b_7243:
	ldh a, [$ff96] ; $7243
	push af ; $7245
	ld a, $01 ; $7246
	ldh [$ff96], a ; $7248
	ldh [rWBK], a ; $724a
	ld c, $00 ; $724c
Label_3b_724e:
	ld a, c ; $724e
	add a, a ; $724f
	ld hl, $72e0 ; $7250
	add a, l ; $7253
	ld l, a ; $7254
	jr nc, Label_3b_7258 ; $7255
	inc h ; $7257
Label_3b_7258:
	ld a, [hl+] ; $7258
	ld h, [hl] ; $7259
	ld l, a ; $725a
	push af ; $725b
	push bc ; $725c
	push de ; $725d
	push hl ; $725e
	ld de, $d000 ; $725f
	call DecompressDataFromBank ; $7262
	pop hl ; $7265
	pop de ; $7266
	pop bc ; $7267
	pop af ; $7268
	ld hl, $72e6 ; $7269
	ld a, c ; $726c
	add a, a ; $726d
	add a, l ; $726e
	ld l, a ; $726f
	jr nc, Label_3b_7273 ; $7270
	inc h ; $7272
Label_3b_7273:
	ld a, [hl+] ; $7273
	ld d, [hl] ; $7274
	ld e, a ; $7275
	ld hl, $d000 ; $7276
	push af ; $7279
	push bc ; $727a
	push de ; $727b
	push hl ; $727c
	ld bc, $0010 ; $727d
	call Func_00_0480 ; $7280
	pop hl ; $7283
	pop de ; $7284
	pop bc ; $7285
	pop af ; $7286
	ld a, c ; $7287
	inc a ; $7288
	ld c, a ; $7289
	call Func_00_2631 ; $728a
	ld a, c ; $728d
	cp a, $03 ; $728e
	jr nz, Label_3b_724e ; $7290
	ld b, $39 ; $7292
	ld c, $10 ; $7294
	ld de, $a000 ; $7296
	farcall FarPtr_39_10 ; $7299
	call Func_00_2631 ; $729c
	ld b, $1d ; $729f
	ld c, $10 ; $72a1
	ld de, $a100 ; $72a3
	farcall FarPtr_39_10 ; $72a6
	call Func_00_2631 ; $72a9
	ld b, $3a ; $72ac
	ld c, $10 ; $72ae
	ld de, $a200 ; $72b0
	farcall FarPtr_39_10 ; $72b3
	call Func_00_2631 ; $72b6
	ld b, $1b ; $72b9
	ld c, $04 ; $72bb
	ld de, $a700 ; $72bd
	farcall FarPtr_39_10 ; $72c0
	call Func_00_2631 ; $72c3
	ld b, $43 ; $72c6
	ld c, $14 ; $72c8
	ld de, $8000 ; $72ca
	farcall FarPtr_39_10 ; $72cd
	call Func_00_2631 ; $72d0
	ld b, $08 ; $72d3
	ld c, $10 ; $72d5
	farcall FarPtr_39_0e ; $72d7
	pop af ; $72da
	ldh [$ff96], a ; $72db
	ldh [rWBK], a ; $72dd
	ret ; $72df
	INCBIN "data/bank_03b/d_72e0.bin" ; $72e0, 12 bytes
Func_3b_72ec:
	ld a, b ; $72ec
	or a, a ; $72ed
	jr z, Label_3b_7307 ; $72ee
	ld c, $00 ; $72f0
Label_3b_72f2:
	call Func_00_2631 ; $72f2
	ld b, $0a ; $72f5
	farcall FarPtr_39_20 ; $72f7
	ld b, $03 ; $72fa
	farcall FarPtr_39_1e ; $72fc
	ld a, c ; $72ff
	inc a ; $7300
	ld c, a ; $7301
	cp a, $0d ; $7302
	jr nz, Label_3b_72f2 ; $7304
	ret ; $7306
Label_3b_7307:
	ld c, $0a ; $7307
Label_3b_7309:
	call Func_00_2631 ; $7309
	ld b, $0b ; $730c
	farcall FarPtr_39_20 ; $730e
	ld b, $03 ; $7311
	farcall FarPtr_39_1e ; $7313
	ld a, c ; $7316
	dec a ; $7317
	ld c, a ; $7318
	cp a, $ff ; $7319
	jr nz, Label_3b_7309 ; $731b
	ret ; $731d
Func_3b_731e:
	ld a, b ; $731e
	or a, a ; $731f
	jr z, Label_3b_7339 ; $7320
	ld c, $00 ; $7322
Label_3b_7324:
	call Func_00_2631 ; $7324
	ld b, $0b ; $7327
	farcall FarPtr_39_20 ; $7329
	ld b, $03 ; $732c
	farcall FarPtr_39_1e ; $732e
	ld a, c ; $7331
	inc a ; $7332
	ld c, a ; $7333
	cp a, $0b ; $7334
	jr nz, Label_3b_7324 ; $7336
	ret ; $7338
Label_3b_7339:
	ld c, $0c ; $7339
Label_3b_733b:
	call Func_00_2631 ; $733b
	ld b, $0a ; $733e
	farcall FarPtr_39_20 ; $7340
	ld b, $03 ; $7343
	farcall FarPtr_39_1e ; $7345
	ld a, c ; $7348
	dec a ; $7349
	ld c, a ; $734a
	or a, a ; $734b
	jr nz, Label_3b_733b ; $734c
	ret ; $734e
	INCBIN "data/bank_03b/d_734f.bin" ; $734f, 112 bytes
Func_3b_73bf:
	ld a, $03 ; $73bf
	ldh [$ff96], a ; $73c1
	ldh [rWBK], a ; $73c3
	ld b, $00 ; $73c5
	ld c, $00 ; $73c7
Label_3b_73c9:
	call Func_3b_7428 ; $73c9
	ld a, b ; $73cc
	inc a ; $73cd
	ld b, a ; $73ce
	cp a, $03 ; $73cf
	jr nz, Label_3b_73c9 ; $73d1
	ld c, $03 ; $73d3
	call Func_3b_43b9 ; $73d5
	ld b, a ; $73d8
	ld c, $01 ; $73d9
	call Func_3b_7428 ; $73db
	ld c, $03 ; $73de
	call Func_3b_43b9 ; $73e0
	call Func_3b_745d ; $73e3
	ld a, $03 ; $73e6
	ldh [$ff96], a ; $73e8
	ldh [rWBK], a ; $73ea
	ld de, $d1e0 ; $73ec
	ld b, $14 ; $73ef
	ld c, $01 ; $73f1
	ld h, $03 ; $73f3
	farcall FarPtr_39_0c ; $73f5
	ld a, $02 ; $73f8
	ld [$d1e0], a ; $73fa
	ld a, $04 ; $73fd
	ld [$d1f3], a ; $73ff
	ld de, $d201 ; $7402
	ld b, $12 ; $7405
	ld c, $01 ; $7407
	ld h, $20 ; $7409
	farcall FarPtr_39_0c ; $740b
	call Func_3b_749a ; $740e
	ld hl, $d4e0 ; $7411
	ld de, $b8e0 ; $7414
	ld c, $06 ; $7417
	call Func_00_0480 ; $7419
	ld hl, $d1e0 ; $741c
	ld de, $99e0 ; $741f
	ld c, $04 ; $7422
	call Func_00_0480 ; $7424
	ret ; $7427
Func_3b_7428:
	push af ; $7428
	push bc ; $7429
	push de ; $742a
	push hl ; $742b
	ld a, c ; $742c
	or a, a ; $742d
	jr z, Label_3b_7434 ; $742e
	ld h, $0c ; $7430
	jr Label_3b_7436 ; $7432
Label_3b_7434:
	ld h, $0d ; $7434
Label_3b_7436:
	push hl ; $7436
	ld hl, $7451 ; $7437
	ld a, b ; $743a
	add a, a ; $743b
	add a, l ; $743c
	ld l, a ; $743d
	jr nc, Label_3b_7441 ; $743e
	inc h ; $7440
Label_3b_7441:
	ld a, [hl+] ; $7441
	ld d, [hl] ; $7442
	ld e, a ; $7443
	pop hl ; $7444
	ld b, $05 ; $7445
	ld c, $03 ; $7447
	farcall FarPtr_39_0c ; $7449
	pop hl ; $744c
	pop de ; $744d
	pop bc ; $744e
	pop af ; $744f
	ret ; $7450
	INCBIN "data/bank_03b/d_7451.bin" ; $7451, 12 bytes
Func_3b_745d:
	ld hl, $7470 ; $745d
	add a, a ; $7460
	add a, l ; $7461
	ld l, a ; $7462
	jr nc, Label_3b_7466 ; $7463
	inc h ; $7465
Label_3b_7466:
	ld a, [hl+] ; $7466
	ld h, [hl] ; $7467
	ld l, a ; $7468
	ld de, $0401 ; $7469
	call LoadPaletteShadow ; $746c
	ret ; $746f
	INCBIN "data/bank_03b/d_7470.bin" ; $7470, 42 bytes
Func_3b_749a:
	ldh a, [$ff96] ; $749a
	push af ; $749c
	ld a, $03 ; $749d
	ldh [$ff96], a ; $749f
	ldh [rWBK], a ; $74a1
	ld c, $03 ; $74a3
	call Func_3b_43b9 ; $74a5
	ld b, a ; $74a8
	ld hl, $00cf ; $74a9
	add a, l ; $74ac
	ld l, a ; $74ad
	jr nc, Label_3b_74b1 ; $74ae
	inc h ; $74b0
Label_3b_74b1:
	ld de, $d201 ; $74b1
	ld c, $20 ; $74b4
	farcall FarPtr_05_72 ; $74b6
	pop af ; $74b9
	ldh [$ff96], a ; $74ba
	ldh [rWBK], a ; $74bc
	ret ; $74be
Func_3b_74bf:
	sound $03 ; $74bf
	ld hl, rIE ; $74c1
	res 2, [hl] ; $74c4
	call Func_3b_7552 ; $74c6
	ld a, $03 ; $74c9
	ldh [$ff96], a ; $74cb
	ldh [rWBK], a ; $74cd
	ld a, [$cb11] ; $74cf
	ld b, a ; $74d2
	farcall FarPtr_3e_2a ; $74d3
	farcall FarPtr_39_24 ; $74d6
	ld b, $01 ; $74d9
	ld c, $01 ; $74db
	farcall FarPtr_39_26 ; $74dd
	ld a, [$cb1d] ; $74e0
	ld c, a ; $74e3
	ld b, $02 ; $74e4
	call Func_3b_43db ; $74e6
	ld a, $01 ; $74e9
	ld hl, $76ea ; $74eb
	call Func_00_1b6a ; $74ee
	call Func_3b_760c ; $74f1
	ld a, $03 ; $74f4
	ldh [$ff96], a ; $74f6
	ldh [rWBK], a ; $74f8
Label_3b_74fa:
	call Func_00_2631 ; $74fa
	ldh a, [$ff91] ; $74fd
	ld [$cb0d], a ; $74ff
	ld b, $02 ; $7502
	ld c, $02 ; $7504
	call Func_3b_412a ; $7506
	or a, a ; $7509
	jr z, Label_3b_7511 ; $750a
	sound $5e ; $750c
	call Func_3b_760c ; $750e
Label_3b_7511:
	ld a, [$cb0d] ; $7511
	bit 0, a ; $7514
	jr nz, Label_3b_751e ; $7516
	bit 1, a ; $7518
	jr nz, Label_3b_753b ; $751a
	jr Label_3b_74fa ; $751c
Label_3b_751e:
	sound $5f ; $751e
	call Func_00_1b38 ; $7520
	ld hl, rIE ; $7523
	set 2, [hl] ; $7526
	ld b, $01 ; $7528
	farcall FarPtr_3e_2c ; $752a
	ld a, $01 ; $752d
	ld [$cb11], a ; $752f
	ld c, $02 ; $7532
	call Func_3b_43b9 ; $7534
	ld [$cb1d], a ; $7537
	ret ; $753a
Label_3b_753b:
	sound $62 ; $753b
	call Func_00_1b38 ; $753d
	ld hl, rIE ; $7540
	set 2, [hl] ; $7543
	ld b, $00 ; $7545
	farcall FarPtr_3e_2c ; $7547
	ld a, $00 ; $754a
	ld [$cb11], a ; $754c
	ld a, $ff ; $754f
	ret ; $7551
Func_3b_7552:
	ldh a, [$ff96] ; $7552
	push af ; $7554
	ld a, $01 ; $7555
	ldh [$ff96], a ; $7557
	ldh [rWBK], a ; $7559
	ld c, $00 ; $755b
Label_3b_755d:
	ld a, c ; $755d
	add a, a ; $755e
	ld hl, $75fc ; $755f
	add a, l ; $7562
	ld l, a ; $7563
	jr nc, Label_3b_7567 ; $7564
	inc h ; $7566
Label_3b_7567:
	ld a, [hl+] ; $7567
	ld h, [hl] ; $7568
	ld l, a ; $7569
	push af ; $756a
	push bc ; $756b
	push de ; $756c
	push hl ; $756d
	ld de, $d000 ; $756e
	call DecompressDataFromBank ; $7571
	pop hl ; $7574
	pop de ; $7575
	pop bc ; $7576
	pop af ; $7577
	ld hl, $7604 ; $7578
	ld a, c ; $757b
	add a, a ; $757c
	add a, l ; $757d
	ld l, a ; $757e
	jr nc, Label_3b_7582 ; $757f
	inc h ; $7581
Label_3b_7582:
	ld a, [hl+] ; $7582
	ld d, [hl] ; $7583
	ld e, a ; $7584
	ld hl, $d000 ; $7585
	push af ; $7588
	push bc ; $7589
	push de ; $758a
	push hl ; $758b
	ld bc, $0010 ; $758c
	call Func_00_0480 ; $758f
	pop hl ; $7592
	pop de ; $7593
	pop bc ; $7594
	pop af ; $7595
	ld a, c ; $7596
	inc a ; $7597
	ld c, a ; $7598
	call Func_00_2631 ; $7599
	ld a, c ; $759c
	cp a, $04 ; $759d
	jr nz, Label_3b_755d ; $759f
	ld b, $3b ; $75a1
	ld c, $10 ; $75a3
	ld de, $a000 ; $75a5
	farcall FarPtr_39_10 ; $75a8
	call Func_00_2631 ; $75ab
	ld b, $73 ; $75ae
	ld c, $10 ; $75b0
	ld de, $a100 ; $75b2
	farcall FarPtr_39_10 ; $75b5
	call Func_00_2631 ; $75b8
	ld b, $3c ; $75bb
	ld c, $10 ; $75bd
	ld de, $a200 ; $75bf
	farcall FarPtr_39_10 ; $75c2
	call Func_00_2631 ; $75c5
	ld b, $3d ; $75c8
	ld c, $10 ; $75ca
	ld de, $a300 ; $75cc
	farcall FarPtr_39_10 ; $75cf
	call Func_00_2631 ; $75d2
	ld b, $1b ; $75d5
	ld c, $04 ; $75d7
	ld de, $a700 ; $75d9
	farcall FarPtr_39_10 ; $75dc
	call Func_00_2631 ; $75df
	ld b, $44 ; $75e2
	ld c, $14 ; $75e4
	ld de, $8000 ; $75e6
	farcall FarPtr_39_10 ; $75e9
	call Func_00_2631 ; $75ec
	ld b, $08 ; $75ef
	ld c, $10 ; $75f1
	farcall FarPtr_39_0e ; $75f3
	pop af ; $75f6
	ldh [$ff96], a ; $75f7
	ldh [rWBK], a ; $75f9
	ret ; $75fb
	INCBIN "data/bank_03b/d_75fc.bin" ; $75fc, 16 bytes
Func_3b_760c:
	ld a, $03 ; $760c
	ldh [$ff96], a ; $760e
	ldh [rWBK], a ; $7610
	ld b, $00 ; $7612
	ld c, $00 ; $7614
Label_3b_7616:
	farcall FarPtr_3e_2e ; $7616
	ld a, b ; $7619
	inc a ; $761a
	ld b, a ; $761b
	cp a, $04 ; $761c
	jr nz, Label_3b_7616 ; $761e
	ld c, $02 ; $7620
	call Func_3b_43b9 ; $7622
	ld b, a ; $7625
	ld c, $01 ; $7626
	farcall FarPtr_3e_2e ; $7628
	ld c, $02 ; $762b
	call Func_3b_43b9 ; $762d
	call Func_3b_7680 ; $7630
	ld a, $03 ; $7633
	ldh [$ff96], a ; $7635
	ldh [rWBK], a ; $7637
	ld de, $d1e0 ; $7639
	ld b, $14 ; $763c
	ld c, $01 ; $763e
	ld h, $03 ; $7640
	farcall FarPtr_39_0c ; $7642
	ld a, $02 ; $7645
	ld [$d1e0], a ; $7647
	ld a, $04 ; $764a
	ld [$d1f3], a ; $764c
	ld de, $d201 ; $764f
	ld b, $12 ; $7652
	ld c, $01 ; $7654
	ld h, $20 ; $7656
	farcall FarPtr_39_0c ; $7658
	call Func_3b_76c5 ; $765b
	ld hl, $d480 ; $765e
	ld de, $b880 ; $7661
	ld c, $06 ; $7664
	call Func_00_0480 ; $7666
	ld hl, $d520 ; $7669
	ld de, $b920 ; $766c
	ld c, $06 ; $766f
	call Func_00_0480 ; $7671
	ld hl, $d1e0 ; $7674
	ld de, $99e0 ; $7677
	ld c, $04 ; $767a
	call Func_00_0480 ; $767c
	ret ; $767f
Func_3b_7680:
	ld hl, $7693 ; $7680
	add a, a ; $7683
	add a, l ; $7684
	ld l, a ; $7685
	jr nc, Label_3b_7689 ; $7686
	inc h ; $7688
Label_3b_7689:
	ld a, [hl+] ; $7689
	ld h, [hl] ; $768a
	ld l, a ; $768b
	ld de, $0401 ; $768c
	call LoadPaletteShadow ; $768f
	ret ; $7692
	INCBIN "data/bank_03b/d_7693.bin" ; $7693, 50 bytes
Func_3b_76c5:
	ldh a, [$ff96] ; $76c5
	push af ; $76c7
	ld a, $03 ; $76c8
	ldh [$ff96], a ; $76ca
	ldh [rWBK], a ; $76cc
	ld c, $02 ; $76ce
	call Func_3b_43b9 ; $76d0
	ld b, a ; $76d3
	ld hl, $00d2 ; $76d4
	add a, l ; $76d7
	ld l, a ; $76d8
	jr nc, Label_3b_76dc ; $76d9
	inc h ; $76db
Label_3b_76dc:
	ld de, $d201 ; $76dc
	ld c, $20 ; $76df
	farcall FarPtr_05_72 ; $76e1
	pop af ; $76e4
	ldh [$ff96], a ; $76e5
	ldh [rWBK], a ; $76e7
	ret ; $76e9
	INCBIN "data/bank_03b/d_76ea.bin" ; $76ea, 115 bytes
Func_3b_775d:
	ld a, $03 ; $775d
	ldh [$ff96], a ; $775f
	ldh [rWBK], a ; $7761
	ld a, b ; $7763
	ld [$d800], a ; $7764
	ld a, c ; $7767
	ld [$d801], a ; $7768
	call DisableLCDSafely ; $776b
	call Func_3b_77a7 ; $776e
	call EnableLCD ; $7771
	ld c, $10 ; $7774
	call Func_00_1d2e ; $7776
	call Func_00_1da4 ; $7779
	ld a, $01 ; $777c
	ld hl, $79d6 ; $777e
	call Func_00_1b6a ; $7781
	sound $78 ; $7784
	call Func_00_2725 ; $7786
	ld a, b ; $7789
Label_3b_778a:
	ldh a, [$ff91] ; $778a
	bit 0, a ; $778c
	jr nz, Label_3b_7799 ; $778e
	bit 1, a ; $7790
	jr nz, Label_3b_7799 ; $7792
	call Func_00_2631 ; $7794
	jr Label_3b_778a ; $7797
Label_3b_7799:
	sound $5f ; $7799
	call Func_00_1b38 ; $779b
	ld c, $10 ; $779e
	call Func_00_1d20 ; $77a0
	call Func_00_1da4 ; $77a3
	ret ; $77a6
Func_3b_77a7:
	ld a, [$d800] ; $77a7
	or a, a ; $77aa
	jr nz, Label_3b_77d2 ; $77ab
	ld c, $25 ; $77ad
	farcall FarPtr_39_00 ; $77af
	ld b, $69 ; $77b2
	ld c, $10 ; $77b4
	ld de, $9000 ; $77b6
	farcall FarPtr_39_10 ; $77b9
	ld a, $03 ; $77bc
	ldh [$ff96], a ; $77be
	ldh [rWBK], a ; $77c0
	call Func_3b_77f7 ; $77c2
	call Func_3b_7804 ; $77c5
	call Func_3b_786c ; $77c8
	call Func_3b_7945 ; $77cb
	farcall FarPtr_39_02 ; $77ce
	ret ; $77d1
Label_3b_77d2:
	ld c, $26 ; $77d2
	farcall FarPtr_39_00 ; $77d4
	ld b, $69 ; $77d7
	ld c, $10 ; $77d9
	ld de, $9000 ; $77db
	farcall FarPtr_39_10 ; $77de
	ld a, $03 ; $77e1
	ldh [$ff96], a ; $77e3
	ldh [rWBK], a ; $77e5
	call Func_3b_77f7 ; $77e7
	call Func_3b_7804 ; $77ea
	call Func_3b_78ec ; $77ed
	call Func_3b_7945 ; $77f0
	farcall FarPtr_39_02 ; $77f3
	ret ; $77f6
Func_3b_77f7:
	ld de, $d509 ; $77f7
	ld b, $07 ; $77fa
	ld c, $08 ; $77fc
	ld h, $00 ; $77fe
	farcall FarPtr_39_0c ; $7800
	ret ; $7803
Func_3b_7804:
	ld a, [$d800] ; $7804
	or a, a ; $7807
	jr nz, Label_3b_7847 ; $7808
	ld de, $d109 ; $780a
	ld b, $07 ; $780d
	ld c, $08 ; $780f
	ld h, $20 ; $7811
	farcall FarPtr_39_0c ; $7813
	ld de, $d109 ; $7816
	ld b, $07 ; $7819
	ld c, $01 ; $781b
	ld h, $03 ; $781d
	farcall FarPtr_39_0c ; $781f
	ld de, $d149 ; $7822
	ld b, $07 ; $7825
	ld c, $01 ; $7827
	ld h, $03 ; $7829
	farcall FarPtr_39_0c ; $782b
	ld de, $d189 ; $782e
	ld b, $07 ; $7831
	ld c, $01 ; $7833
	ld h, $03 ; $7835
	farcall FarPtr_39_0c ; $7837
	ld de, $d1c9 ; $783a
	ld b, $07 ; $783d
	ld c, $01 ; $783f
	ld h, $03 ; $7841
	farcall FarPtr_39_0c ; $7843
	ret ; $7846
Label_3b_7847:
	ld de, $d109 ; $7847
	ld b, $07 ; $784a
	ld c, $08 ; $784c
	ld h, $20 ; $784e
	farcall FarPtr_39_0c ; $7850
	ld de, $d109 ; $7853
	ld b, $07 ; $7856
	ld c, $01 ; $7858
	ld h, $03 ; $785a
	farcall FarPtr_39_0c ; $785c
	ld de, $d189 ; $785f
	ld b, $07 ; $7862
	ld c, $01 ; $7864
	ld h, $03 ; $7866
	farcall FarPtr_39_0c ; $7868
	ret ; $786b
Func_3b_786c:
	ld a, [$d801] ; $786c
	ld hl, $7889 ; $786f
	add a, a ; $7872
	add a, l ; $7873
	ld l, a ; $7874
	jr nc, Label_3b_7878 ; $7875
	inc h ; $7877
Label_3b_7878:
	ld a, [hl+] ; $7878
	ld h, [hl] ; $7879
	ld l, a ; $787a
	ld b, $00 ; $787b
Label_3b_787d:
	ld a, [hl+] ; $787d
	call Func_3b_78a3 ; $787e
	ld a, b ; $7881
	inc a ; $7882
	ld b, a ; $7883
	cp a, $04 ; $7884
	jr nz, Label_3b_787d ; $7886
	ret ; $7888
	INCBIN "data/bank_03b/d_7889.bin" ; $7889, 26 bytes
Func_3b_78a3:
	push af ; $78a3
	push bc ; $78a4
	push de ; $78a5
	push hl ; $78a6
	or a, a ; $78a7
	jr z, Label_3b_78cc ; $78a8
	ld hl, $004b ; $78aa
	dec a ; $78ad
	add a, l ; $78ae
	ld l, a ; $78af
	jr nc, Label_3b_78b3 ; $78b0
	inc h ; $78b2
Label_3b_78b3:
	push hl ; $78b3
	ld hl, $78e4 ; $78b4
	ld a, b ; $78b7
	add a, a ; $78b8
	add a, l ; $78b9
	ld l, a ; $78ba
	jr nc, Label_3b_78be ; $78bb
	inc h ; $78bd
Label_3b_78be:
	ld a, [hl+] ; $78be
	ld d, [hl] ; $78bf
	ld e, a ; $78c0
	pop hl ; $78c1
	ld c, $20 ; $78c2
	farcall FarPtr_05_72 ; $78c4
	pop hl ; $78c7
	pop de ; $78c8
	pop bc ; $78c9
	pop af ; $78ca
	ret ; $78cb
Label_3b_78cc:
	ld hl, $78e4 ; $78cc
	ld a, b ; $78cf
	add a, a ; $78d0
	add a, l ; $78d1
	ld l, a ; $78d2
	jr nc, Label_3b_78d6 ; $78d3
	inc h ; $78d5
Label_3b_78d6:
	ld a, [hl+] ; $78d6
	ld d, [hl] ; $78d7
	ld e, a ; $78d8
	ld hl, $c900 ; $78d9
	call Func_3b_442c ; $78dc
	pop hl ; $78df
	pop de ; $78e0
	pop bc ; $78e1
	pop af ; $78e2
	ret ; $78e3
	INCBIN "data/bank_03b/d_78e4.bin" ; $78e4, 8 bytes
Func_3b_78ec:
	ld a, [$d801] ; $78ec
	cp a, $01 ; $78ef
	jr nz, Label_3b_791c ; $78f1
	ld hl, $c900 ; $78f3
	ld de, $d129 ; $78f6
	call Func_3b_442c ; $78f9
	ld hl, $c940 ; $78fc
	ld de, $d169 ; $78ff
	call Func_3b_442c ; $7902
	ld hl, $004b ; $7905
	ld de, $d1a9 ; $7908
	ld c, $20 ; $790b
	farcall FarPtr_05_72 ; $790d
	ld hl, $004c ; $7910
	ld de, $d1e9 ; $7913
	ld c, $20 ; $7916
	farcall FarPtr_05_72 ; $7918
	ret ; $791b
Label_3b_791c:
	ld hl, $c900 ; $791c
	ld de, $d1a9 ; $791f
	call Func_3b_442c ; $7922
	ld hl, $c940 ; $7925
	ld de, $d1e9 ; $7928
	call Func_3b_442c ; $792b
	ld hl, $004b ; $792e
	ld de, $d129 ; $7931
	ld c, $20 ; $7934
	farcall FarPtr_05_72 ; $7936
	ld hl, $004c ; $7939
	ld de, $d169 ; $793c
	ld c, $20 ; $793f
	farcall FarPtr_05_72 ; $7941
	ret ; $7944
Func_3b_7945:
	ld a, [$d800] ; $7945
	or a, a ; $7948
	jr nz, Label_3b_7985 ; $7949
	ld a, [$d801] ; $794b
	ld hl, $79b6 ; $794e
	add a, a ; $7951
	add a, l ; $7952
	ld l, a ; $7953
	jr nc, Label_3b_7957 ; $7954
	inc h ; $7956
Label_3b_7957:
	ld a, [hl+] ; $7957
	ld d, [hl] ; $7958
	ld e, a ; $7959
	ld b, $07 ; $795a
	ld c, $02 ; $795c
	ld h, $05 ; $795e
	farcall FarPtr_39_0c ; $7960
	ld a, [$d801] ; $7963
	ld hl, $79c0 ; $7966
	add a, a ; $7969
	add a, l ; $796a
	ld l, a ; $796b
	jr nc, Label_3b_796f ; $796c
	inc h ; $796e
Label_3b_796f:
	ld a, [hl+] ; $796f
	ld d, [hl] ; $7970
	ld e, a ; $7971
	ld b, $02 ; $7972
	ld c, $02 ; $7974
	ld a, [$d801] ; $7976
	cp a, $04 ; $7979
	jr nz, Label_3b_797f ; $797b
	ld c, $01 ; $797d
Label_3b_797f:
	ld h, $0d ; $797f
	farcall FarPtr_39_0c ; $7981
	ret ; $7984
Label_3b_7985:
	ld a, [$d801] ; $7985
	ld hl, $79ca ; $7988
	add a, a ; $798b
	add a, l ; $798c
	ld l, a ; $798d
	jr nc, Label_3b_7991 ; $798e
	inc h ; $7990
Label_3b_7991:
	ld a, [hl+] ; $7991
	ld d, [hl] ; $7992
	ld e, a ; $7993
	ld b, $07 ; $7994
	ld c, $04 ; $7996
	ld h, $05 ; $7998
	farcall FarPtr_39_0c ; $799a
	ld a, [$d801] ; $799d
	ld hl, $79d0 ; $79a0
	add a, a ; $79a3
	add a, l ; $79a4
	ld l, a ; $79a5
	jr nc, Label_3b_79a9 ; $79a6
	inc h ; $79a8
Label_3b_79a9:
	ld a, [hl+] ; $79a9
	ld d, [hl] ; $79aa
	ld e, a ; $79ab
	ld b, $02 ; $79ac
	ld c, $03 ; $79ae
	ld h, $0d ; $79b0
	farcall FarPtr_39_0c ; $79b2
	ret ; $79b5
	INCBIN "data/bank_03b/d_79b6.bin" ; $79b6, 67 bytes
Func_3b_79f9:
	sound $04 ; $79f9
	call DisableLCDSafely ; $79fb
	call Func_3b_7b11 ; $79fe
	ld a, $01 ; $7a01
	ld [$cb0b], a ; $7a03
	ld a, $03 ; $7a06
	ld [$cb0c], a ; $7a08
	ld a, $01 ; $7a0b
	ld hl, $4428 ; $7a0d
	call Func_00_1b6a ; $7a10
	ld a, $01 ; $7a13
	ld hl, $7a6d ; $7a15
	call Func_00_1b6a ; $7a18
	call EnableLCD ; $7a1b
	ld c, $10 ; $7a1e
	call Func_00_1d2e ; $7a20
	call Func_00_1da4 ; $7a23
	ld a, $03 ; $7a26
	ldh [$ff96], a ; $7a28
	ldh [rWBK], a ; $7a2a
Label_3b_7a2c:
	call Func_00_2631 ; $7a2c
	ldh a, [$ff91] ; $7a2f
	ld [$cb0d], a ; $7a31
	call Func_3b_7e25 ; $7a34
	or a, a ; $7a37
	jr z, Label_3b_7a3f ; $7a38
	call Func_3b_7b4f ; $7a3a
	jr Label_3b_7a42 ; $7a3d
Label_3b_7a3f:
	call Func_3b_7bb5 ; $7a3f
Label_3b_7a42:
	ld a, [$cb0d] ; $7a42
	bit 0, a ; $7a45
	jr nz, Label_3b_7a4f ; $7a47
	bit 1, a ; $7a49
	jr nz, Label_3b_7a5d ; $7a4b
	jr Label_3b_7a2c ; $7a4d
Label_3b_7a4f:
	sound $5f ; $7a4f
	ld c, $10 ; $7a51
	call Func_00_1d20 ; $7a53
	call Func_00_1da4 ; $7a56
	call Func_00_1b38 ; $7a59
	ret ; $7a5c
Label_3b_7a5d:
	sound $62 ; $7a5d
	ld c, $10 ; $7a5f
	call Func_00_1d20 ; $7a61
	call Func_00_1da4 ; $7a64
	call Func_00_1b38 ; $7a67
	ld a, $ff ; $7a6a
	ret ; $7a6c
	ldh a, [$ff96] ; $7a6d
	push af ; $7a6f
	ld a, $03 ; $7a70
	ldh [$ff96], a ; $7a72
	ldh [rWBK], a ; $7a74
	call Func_3b_7e25 ; $7a76
	or a, a ; $7a79
	jr z, Label_3b_7adc ; $7a7a
	ld a, [$cb04] ; $7a7c
	cp a, $02 ; $7a7f
	jr z, Label_3b_7a94 ; $7a81
	ld de, $932f ; $7a83
	ld c, $01 ; $7a86
	call Func_3b_409b ; $7a88
	ld b, $08 ; $7a8b
	ld c, $00 ; $7a8d
	ld h, $00 ; $7a8f
	farcall FarPtr_39_1a ; $7a91
Label_3b_7a94:
	ld a, [$cb04] ; $7a94
	or a, a ; $7a97
	jr z, Label_3b_7aab ; $7a98
	ld de, $082f ; $7a9a
	ld c, $00 ; $7a9d
	call Func_3b_409b ; $7a9f
	ld b, $08 ; $7aa2
	ld c, $00 ; $7aa4
	ld h, $01 ; $7aa6
	farcall FarPtr_39_1a ; $7aa8
Label_3b_7aab:
	ld a, [$cb05] ; $7aab
	or a, a ; $7aae
	jr z, Label_3b_7ac2 ; $7aaf
	ld de, $0a20 ; $7ab1
	ld c, $01 ; $7ab4
	call Func_3b_40c5 ; $7ab6
	ld b, $08 ; $7ab9
	ld c, $00 ; $7abb
	ld h, $02 ; $7abd
	farcall FarPtr_39_1a ; $7abf
Label_3b_7ac2:
	ld a, [$cb05] ; $7ac2
	cp a, $05 ; $7ac5
	jr z, Label_3b_7ada ; $7ac7
	ld de, $0a78 ; $7ac9
	ld c, $00 ; $7acc
	call Func_3b_40c5 ; $7ace
	ld b, $08 ; $7ad1
	ld c, $00 ; $7ad3
	ld h, $03 ; $7ad5
	farcall FarPtr_39_1a ; $7ad7
Label_3b_7ada:
	jr Label_3b_7b0b ; $7ada
Label_3b_7adc:
	ld a, [$cb05] ; $7adc
	or a, a ; $7adf
	jr z, Label_3b_7af3 ; $7ae0
	ld de, $1a20 ; $7ae2
	ld c, $01 ; $7ae5
	call Func_3b_40c5 ; $7ae7
	ld b, $08 ; $7aea
	ld c, $00 ; $7aec
	ld h, $02 ; $7aee
	farcall FarPtr_39_1a ; $7af0
Label_3b_7af3:
	ld a, [$cb05] ; $7af3
	cp a, $01 ; $7af6
	jr z, Label_3b_7b0b ; $7af8
	ld de, $1a78 ; $7afa
	ld c, $00 ; $7afd
	call Func_3b_40c5 ; $7aff
	ld b, $08 ; $7b02
	ld c, $00 ; $7b04
	ld h, $03 ; $7b06
	farcall FarPtr_39_1a ; $7b08
Label_3b_7b0b:
	pop af ; $7b0b
	ldh [$ff96], a ; $7b0c
	ldh [rWBK], a ; $7b0e
	ret ; $7b10
Func_3b_7b11:
	ld a, $03 ; $7b11
	ldh [$ff96], a ; $7b13
	ldh [rWBK], a ; $7b15
	xor a, a ; $7b17
	ld [$dc13], a ; $7b18
	ld [$dc12], a ; $7b1b
	ld c, $0c ; $7b1e
	farcall FarPtr_39_00 ; $7b20
	ld de, $aac0 ; $7b23
	call Func_3b_48f2 ; $7b26
	ld de, $a000 ; $7b29
	farcall FarPtr_39_18 ; $7b2c
	ld b, $08 ; $7b2f
	ld c, $0f ; $7b31
	farcall FarPtr_39_0e ; $7b33
	ld a, $03 ; $7b36
	ldh [$ff96], a ; $7b38
	ldh [rWBK], a ; $7b3a
	call Func_3b_7cca ; $7b3c
	call Func_3b_7d1e ; $7b3f
	call Func_3b_7e43 ; $7b42
	call Func_3b_4783 ; $7b45
	call Func_3b_7bea ; $7b48
	farcall FarPtr_39_02 ; $7b4b
	ret ; $7b4e
Func_3b_7b4f:
	ld a, [$cb0d] ; $7b4f
	bit 5, a ; $7b52
	jr z, Label_3b_7b6a ; $7b54
	ld a, [$cb04] ; $7b56
	or a, a ; $7b59
	jr z, Label_3b_7bb4 ; $7b5a
	dec a ; $7b5c
	ld [$cb04], a ; $7b5d
	sound $5e ; $7b60
	call Func_3b_7bea ; $7b62
	call Func_3b_7c81 ; $7b65
	jr Label_3b_7bb4 ; $7b68
Label_3b_7b6a:
	bit 4, a ; $7b6a
	jr z, Label_3b_7b83 ; $7b6c
	ld a, [$cb04] ; $7b6e
	cp a, $02 ; $7b71
	jr z, Label_3b_7bb4 ; $7b73
	inc a ; $7b75
	ld [$cb04], a ; $7b76
	sound $5e ; $7b79
	call Func_3b_7bea ; $7b7b
	call Func_3b_7c81 ; $7b7e
	jr Label_3b_7bb4 ; $7b81
Label_3b_7b83:
	bit 6, a ; $7b83
	jr z, Label_3b_7b9b ; $7b85
	ld a, [$cb05] ; $7b87
	or a, a ; $7b8a
	jr z, Label_3b_7bb4 ; $7b8b
	dec a ; $7b8d
	ld [$cb05], a ; $7b8e
	sound $5e ; $7b91
	call Func_3b_7bea ; $7b93
	call Func_3b_7c81 ; $7b96
	jr Label_3b_7bb4 ; $7b99
Label_3b_7b9b:
	bit 7, a ; $7b9b
	jr z, Label_3b_7bb4 ; $7b9d
	ld a, [$cb05] ; $7b9f
	cp a, $05 ; $7ba2
	jr z, Label_3b_7bb4 ; $7ba4
	inc a ; $7ba6
	ld [$cb05], a ; $7ba7
	sound $5e ; $7baa
	call Func_3b_7bea ; $7bac
	call Func_3b_7c81 ; $7baf
	jr Label_3b_7bb4 ; $7bb2
Label_3b_7bb4:
	ret ; $7bb4
Func_3b_7bb5:
	ld a, [$cb0d] ; $7bb5
	bit 6, a ; $7bb8
	jr z, Label_3b_7bd0 ; $7bba
	ld a, [$cb05] ; $7bbc
	or a, a ; $7bbf
	jr z, Label_3b_7be9 ; $7bc0
	dec a ; $7bc2
	ld [$cb05], a ; $7bc3
	sound $5e ; $7bc6
	call Func_3b_7bea ; $7bc8
	call Func_3b_7c81 ; $7bcb
	jr Label_3b_7be9 ; $7bce
Label_3b_7bd0:
	bit 7, a ; $7bd0
	jr z, Label_3b_7be9 ; $7bd2
	ld a, [$cb05] ; $7bd4
	cp a, $01 ; $7bd7
	jr z, Label_3b_7be9 ; $7bd9
	inc a ; $7bdb
	ld [$cb05], a ; $7bdc
	sound $5e ; $7bdf
	call Func_3b_7bea ; $7be1
	call Func_3b_7c81 ; $7be4
	jr Label_3b_7be9 ; $7be7
Label_3b_7be9:
	ret ; $7be9
Func_3b_7bea:
	ld a, $03 ; $7bea
	ldh [$ff96], a ; $7bec
	ldh [rWBK], a ; $7bee
	call Func_3b_7e25 ; $7bf0
	or a, a ; $7bf3
	jr z, Label_3b_7c3c ; $7bf4
	ld bc, $d0a4 ; $7bf6
	ld a, [$cb04] ; $7bf9
	ld hl, $dc01 ; $7bfc
	add a, l ; $7bff
	ld l, a ; $7c00
	jr nc, Label_3b_7c04 ; $7c01
	inc h ; $7c03
Label_3b_7c04:
	ld a, $07 ; $7c04
	call Func_3b_46da ; $7c06
	ld a, [$cb05] ; $7c09
	ld hl, $dc01 ; $7c0c
	add a, l ; $7c0f
	ld l, a ; $7c10
	jr nc, Label_3b_7c14 ; $7c11
	inc h ; $7c13
Label_3b_7c14:
	ld bc, $d0e2 ; $7c14
	call Func_3b_46c0 ; $7c17
	ld a, [$cb05] ; $7c1a
	ld hl, $db00 ; $7c1d
	ld de, $0010 ; $7c20
Label_3b_7c23:
	or a, a ; $7c23
	jr z, Label_3b_7c2a ; $7c24
	add hl, de ; $7c26
	dec a ; $7c27
	jr Label_3b_7c23 ; $7c28
Label_3b_7c2a:
	ld a, [$cb04] ; $7c2a
	add a, l ; $7c2d
	ld l, a ; $7c2e
	jr nc, Label_3b_7c32 ; $7c2f
	inc h ; $7c31
Label_3b_7c32:
	ld de, $d0e4 ; $7c32
	ld a, $07 ; $7c35
	call Func_3b_46ed ; $7c37
	jr Label_3b_7c80 ; $7c3a
Label_3b_7c3c:
	ld bc, $d0a6 ; $7c3c
	ld a, [$cb04] ; $7c3f
	ld hl, $dc01 ; $7c42
	add a, l ; $7c45
	ld l, a ; $7c46
	jr nc, Label_3b_7c4a ; $7c47
	inc h ; $7c49
Label_3b_7c4a:
	ld a, $05 ; $7c4a
	call Func_3b_46da ; $7c4c
	ld a, [$cb05] ; $7c4f
	ld hl, $dc01 ; $7c52
	add a, l ; $7c55
	ld l, a ; $7c56
	jr nc, Label_3b_7c5a ; $7c57
	inc h ; $7c59
Label_3b_7c5a:
	ld bc, $d0e4 ; $7c5a
	call Func_3b_46c0 ; $7c5d
	ld a, [$cb05] ; $7c60
	ld hl, $db00 ; $7c63
	ld de, $0010 ; $7c66
Label_3b_7c69:
	or a, a ; $7c69
	jr z, Label_3b_7c70 ; $7c6a
	add hl, de ; $7c6c
	dec a ; $7c6d
	jr Label_3b_7c69 ; $7c6e
Label_3b_7c70:
	ld a, [$cb04] ; $7c70
	add a, l ; $7c73
	ld l, a ; $7c74
	jr nc, Label_3b_7c78 ; $7c75
	inc h ; $7c77
Label_3b_7c78:
	ld de, $d0e6 ; $7c78
	ld a, $05 ; $7c7b
	call Func_3b_46ed ; $7c7d
Label_3b_7c80:
	ret ; $7c80
Func_3b_7c81:
	ld hl, $d0a0 ; $7c81
	ld de, $98a0 ; $7c84
	ld c, $08 ; $7c87
	call Func_00_0480 ; $7c89
	ld hl, $d4a0 ; $7c8c
	ld de, $b8a0 ; $7c8f
	ld c, $08 ; $7c92
	call Func_00_0480 ; $7c94
	call Func_00_2631 ; $7c97
	ld hl, $d120 ; $7c9a
	ld de, $9920 ; $7c9d
	ld c, $08 ; $7ca0
	call Func_00_0480 ; $7ca2
	ld hl, $d520 ; $7ca5
	ld de, $b920 ; $7ca8
	ld c, $08 ; $7cab
	call Func_00_0480 ; $7cad
	call Func_00_2631 ; $7cb0
	ld hl, $d1a0 ; $7cb3
	ld de, $99a0 ; $7cb6
	ld c, $04 ; $7cb9
	call Func_00_0480 ; $7cbb
	ld hl, $d5a0 ; $7cbe
	ld de, $b9a0 ; $7cc1
	ld c, $04 ; $7cc4
	call Func_00_0480 ; $7cc6
	ret ; $7cc9
Func_3b_7cca:
	ld c, $00 ; $7cca
Label_3b_7ccc:
	ld hl, $7d03 ; $7ccc
	ld a, c ; $7ccf
	add a, a ; $7cd0
	add a, l ; $7cd1
	ld l, a ; $7cd2
	jr nc, Label_3b_7cd6 ; $7cd3
	inc h ; $7cd5
Label_3b_7cd6:
	ld a, [hl+] ; $7cd6
	ld d, [hl] ; $7cd7
	ld e, a ; $7cd8
	ld a, d ; $7cd9
	or a, e ; $7cda
	cp a, $ff ; $7cdb
	jr z, Label_3b_7ce8 ; $7cdd
	farcall FarPtr_03_1c ; $7cdf
	jr nz, Label_3b_7ce8 ; $7ce2
	ld b, $10 ; $7ce4
	jr Label_3b_7cf2 ; $7ce6
Label_3b_7ce8:
	ld hl, $7d15 ; $7ce8
	ld a, c ; $7ceb
	add a, l ; $7cec
	ld l, a ; $7ced
	jr nc, Label_3b_7cf1 ; $7cee
	inc h ; $7cf0
Label_3b_7cf1:
	ld b, [hl] ; $7cf1
Label_3b_7cf2:
	ld hl, $dc01 ; $7cf2
	ld a, c ; $7cf5
	add a, l ; $7cf6
	ld l, a ; $7cf7
	jr nc, Label_3b_7cfb ; $7cf8
	inc h ; $7cfa
Label_3b_7cfb:
	ld [hl], b ; $7cfb
	inc c ; $7cfc
	ld a, c ; $7cfd
	cp a, $09 ; $7cfe
	jr nz, Label_3b_7ccc ; $7d00
	ret ; $7d02
	INCBIN "data/bank_03b/d_7d03.bin" ; $7d03, 27 bytes
Func_3b_7d1e:
	ldh a, [$ff96] ; $7d1e
	push af ; $7d20
	ld a, $03 ; $7d21
	ldh [$ff96], a ; $7d23
	ldh [rWBK], a ; $7d25
	ld hl, $d900 ; $7d27
	farcall FarPtr_03_32 ; $7d2a
	ld hl, $d900 ; $7d2d
	ld de, $db00 ; $7d30
	ld c, $00 ; $7d33
Label_3b_7d35:
	push bc ; $7d35
	push hl ; $7d36
	push de ; $7d37
	ld bc, $0009 ; $7d38
	call CopyMemoryBC ; $7d3b
	pop de ; $7d3e
	ld hl, $0010 ; $7d3f
	add hl, de ; $7d42
	ld d, h ; $7d43
	ld e, l ; $7d44
	pop hl ; $7d45
	ld bc, $0009 ; $7d46
	add hl, bc ; $7d49
	pop bc ; $7d4a
	inc c ; $7d4b
	ld a, c ; $7d4c
	cp a, $09 ; $7d4d
	jr nz, Label_3b_7d35 ; $7d4f
	pop af ; $7d51
	ldh [$ff96], a ; $7d52
	ldh [rWBK], a ; $7d54
	ret ; $7d56
Func_3b_7d57:
	ldh a, [$ff96] ; $7d57
	push af ; $7d59
	ld a, $03 ; $7d5a
	ldh [$ff96], a ; $7d5c
	ldh [rWBK], a ; $7d5e
	ld a, [wMatchWinLoseFlag] ; $7d60
	cp a, $ff ; $7d63
	jr z, Label_3b_7dbd ; $7d65
	ld de, $002f ; $7d67
	call Func_00_24ef ; $7d6a
	jr nz, Label_3b_7dbd ; $7d6d
	ld a, [wPlayer1CurrentMainCharacter] ; $7d6f
	ld c, a ; $7d72
	farcall FarPtr_38_16 ; $7d73
	or a, a ; $7d76
	jr z, Label_3b_7dbd ; $7d77
	ld a, [wPlayer2CurrentMainCharacter] ; $7d79
	ld c, a ; $7d7c
	farcall FarPtr_38_16 ; $7d7d
	or a, a ; $7d80
	jr z, Label_3b_7dbd ; $7d81
	ld a, [wPlayer1CurrentMainCharacter] ; $7d83
	call Func_3b_7de1 ; $7d86
	ld d, a ; $7d89
	ld a, [wPlayer2CurrentMainCharacter] ; $7d8a
	call Func_3b_7de1 ; $7d8d
	ld e, a ; $7d90
	ld hl, $d900 ; $7d91
	farcall FarPtr_03_32 ; $7d94
	ld a, d ; $7d97
	add a, a ; $7d98
	add a, a ; $7d99
	add a, a ; $7d9a
	add a, d ; $7d9b
	add a, e ; $7d9c
	ld hl, $d900 ; $7d9d
	add a, l ; $7da0
	ld l, a ; $7da1
	jr nc, Label_3b_7da5 ; $7da2
	inc h ; $7da4
Label_3b_7da5:
	push hl ; $7da5
	ld d, [hl] ; $7da6
	ld a, [wExhibitionModeCPUMainCharacterDifficulty] ; $7da7
	call Func_3b_7dc4 ; $7daa
	pop hl ; $7dad
	cp a, d ; $7dae
	jr c, Label_3b_7dbd ; $7daf
	ld [hl], a ; $7db1
	call Func_3b_7df6 ; $7db2
	ld hl, $d900 ; $7db5
	farcall FarPtr_03_34 ; $7db8
Label_3b_7dbb:
	jr nz, Label_3b_7dbb ; $7dbb
Label_3b_7dbd:
	pop af ; $7dbd
	ldh [$ff96], a ; $7dbe
	ldh [rWBK], a ; $7dc0
	ret ; $7dc2
	INCBIN "data/bank_03b/d_7dc3.bin" ; $7dc3, 1 bytes
Func_3b_7dc4:
	ld b, a ; $7dc4
	ld hl, $7dd9 ; $7dc5
	ld a, [$c8a8] ; $7dc8
	or a, a ; $7dcb
	jr z, Label_3b_7dd1 ; $7dcc
	ld hl, $7ddd ; $7dce
Label_3b_7dd1:
	ld a, b ; $7dd1
	add a, l ; $7dd2
	ld l, a ; $7dd3
	jr nc, Label_3b_7dd7 ; $7dd4
	inc h ; $7dd6
Label_3b_7dd7:
	ld a, [hl] ; $7dd7
	ret ; $7dd8
	INCBIN "data/bank_03b/d_7dd9.bin" ; $7dd9, 8 bytes
Func_3b_7de1:
	sub a, $17 ; $7de1
	ld hl, $7ded ; $7de3
	add a, l ; $7de6
	ld l, a ; $7de7
	jr nc, Label_3b_7deb ; $7de8
	inc h ; $7dea
Label_3b_7deb:
	ld a, [hl] ; $7deb
	ret ; $7dec
	INCBIN "data/bank_03b/d_7ded.bin" ; $7ded, 9 bytes
Func_3b_7df6:
	ld c, $00 ; $7df6
Label_3b_7df8:
	ld hl, $d900 ; $7df8
	ld a, c ; $7dfb
	add a, a ; $7dfc
	add a, a ; $7dfd
	add a, a ; $7dfe
	add a, c ; $7dff
	add a, l ; $7e00
	ld l, a ; $7e01
	jr nc, Label_3b_7e05 ; $7e02
	inc h ; $7e04
Label_3b_7e05:
	ld b, $00 ; $7e05
Label_3b_7e07:
	ld a, c ; $7e07
	cp a, b ; $7e08
	jr z, Label_3b_7e0f ; $7e09
	ld a, [hl] ; $7e0b
	or a, a ; $7e0c
	jr z, Label_3b_7e1e ; $7e0d
Label_3b_7e0f:
	inc hl ; $7e0f
	inc b ; $7e10
	ld a, b ; $7e11
	cp a, $09 ; $7e12
	jr nz, Label_3b_7e07 ; $7e14
	ld de, $07a0 ; $7e16
	farcall FarPtr_03_1e ; $7e19
	jr Label_3b_7e24 ; $7e1c
Label_3b_7e1e:
	inc c ; $7e1e
	ld a, c ; $7e1f
	cp a, $09 ; $7e20
	jr nz, Label_3b_7df8 ; $7e22
Label_3b_7e24:
	ret ; $7e24
Func_3b_7e25:
	ldh a, [$ff96] ; $7e25
	push af ; $7e27
	push bc ; $7e28
	ld b, $10 ; $7e29
	ld a, [$dc07] ; $7e2b
	cp a, $10 ; $7e2e
	jr z, Label_3b_7e3b ; $7e30
	pop bc ; $7e32
	pop af ; $7e33
	ldh [$ff96], a ; $7e34
	ldh [rWBK], a ; $7e36
	ld a, $01 ; $7e38
	ret ; $7e3a
Label_3b_7e3b:
	pop bc ; $7e3b
	pop af ; $7e3c
	ldh [$ff96], a ; $7e3d
	ldh [rWBK], a ; $7e3f
	xor a, a ; $7e41
	ret ; $7e42
Func_3b_7e43:
	push af ; $7e43
	push bc ; $7e44
	push de ; $7e45
	push hl ; $7e46
	ldh a, [$ff96] ; $7e47
	push af ; $7e49
	ld a, $03 ; $7e4a
	ldh [$ff96], a ; $7e4c
	ldh [rWBK], a ; $7e4e
	call Func_3b_7e25 ; $7e50
	or a, a ; $7e53
	jr nz, Label_3b_7e5f ; $7e54
	call Func_3b_7e69 ; $7e56
	call Func_3b_7e84 ; $7e59
	call Func_3b_7e8b ; $7e5c
Label_3b_7e5f:
	pop af ; $7e5f
	ldh [$ff96], a ; $7e60
	ldh [rWBK], a ; $7e62
	pop hl ; $7e64
	pop de ; $7e65
	pop bc ; $7e66
	pop af ; $7e67
	ret ; $7e68
Func_3b_7e69:
	ld hl, $d241 ; $7e69
	ld de, $d081 ; $7e6c
	ld b, $12 ; $7e6f
	ld c, $0c ; $7e71
	farcall FarPtr_39_0a ; $7e73
	ld hl, $d641 ; $7e76
	ld de, $d481 ; $7e79
	ld b, $12 ; $7e7c
	ld c, $0c ; $7e7e
	farcall FarPtr_39_0a ; $7e80
	ret ; $7e83
Func_3b_7e84:
	ld a, [$dc06] ; $7e84
	ld [$dc05], a ; $7e87
	ret ; $7e8a
Func_3b_7e8b:
	ld hl, $db50 ; $7e8b
	ld de, $db40 ; $7e8e
	ld bc, $0010 ; $7e91
	call CopyMemoryBC ; $7e94
	ld hl, $db05 ; $7e97
	ld de, $db04 ; $7e9a
	ld c, $00 ; $7e9d
Label_3b_7e9f:
	ld a, [hl] ; $7e9f
	ld [de], a ; $7ea0
	push bc ; $7ea1
	ld bc, $0010 ; $7ea2
	add hl, bc ; $7ea5
	push hl ; $7ea6
	ld hl, $0010 ; $7ea7
	add hl, de ; $7eaa
	ld d, h ; $7eab
	ld e, l ; $7eac
	pop hl ; $7ead
	pop bc ; $7eae
	inc c ; $7eaf
	ld a, c ; $7eb0
	cp a, $06 ; $7eb1
	jr nz, Label_3b_7e9f ; $7eb3
	ret ; $7eb5
	ds 330, $ff ; $7eb6, fill
