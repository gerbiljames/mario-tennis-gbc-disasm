INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $39", ROMX[$4000], BANK[$39]

FarPtr_39_00:
	dw Func_39_407e ; $4000
FarPtr_39_02:
	dw Func_39_4325 ; $4002
FarPtr_39_04:
	dw Func_39_4342 ; $4004
FarPtr_39_06:
	dw Func_39_44d3 ; $4006
FarPtr_39_08:
	dw Func_39_451e ; $4008
FarPtr_39_0a:
	dw Func_39_4530 ; $400a
FarPtr_39_0c:
	dw Func_39_4558 ; $400c
FarPtr_39_0e:
	dw Func_39_457f ; $400e
FarPtr_39_10:
	dw Func_39_468b ; $4010
FarPtr_39_12:
	dw Func_39_4661 ; $4012
FarPtr_39_14:
	dw Func_39_4a75 ; $4014
FarPtr_39_16:
	dw Func_39_4ac4 ; $4016
FarPtr_39_18:
	dw Func_39_4a16 ; $4018
FarPtr_39_1a:
	dw Func_39_4a53 ; $401a
FarPtr_39_1c:
	dw Func_39_4c38 ; $401c
FarPtr_39_1e:
	dw Func_39_4cab ; $401e
FarPtr_39_20:
	dw Func_39_4deb ; $4020
FarPtr_39_22:
	dw Func_39_4bf3 ; $4022
FarPtr_39_24:
	dw Func_39_4b13 ; $4024
FarPtr_39_26:
	dw Func_39_4b3a ; $4026
FarPtr_39_28:
	dw Func_39_4b6d ; $4028
FarPtr_39_2a:
	dw Func_39_4be8 ; $402a
FarPtr_39_2c:
	dw Func_39_4325 ; $402c
FarPtr_39_2e:
	dw Func_39_4325 ; $402e
FarPtr_39_30:
	dw Func_39_4325 ; $4030
FarPtr_39_32:
	dw Func_39_4325 ; $4032
DataPtr_39_34:
	dw Lz_39_47ab ; $4034
DataPtr_39_36:
	dw Lz_39_47ab ; $4036
DataPtr_39_38:
	dw Lz_39_47ab ; $4038
DataPtr_39_3a:
	dw Lz_39_47ab ; $403a
DataPtr_39_3c:
	dw Lz_39_47ab ; $403c
DataPtr_39_3e:
	dw Lz_39_47ab ; $403e
DataPtr_39_40:
	dw Lz_39_47ab ; $4040
DataPtr_39_42:
	dw Lz_39_47ab ; $4042
DataPtr_39_44:
	dw Lz_39_47ab ; $4044
DataPtr_39_46:
	dw Lz_39_47ab ; $4046
DataPtr_39_48:
	dw Lz_39_47ab ; $4048
DataPtr_39_4a:
	dw Lz_39_47ab ; $404a
DataPtr_39_4c:
	dw Lz_39_47ab ; $404c
DataPtr_39_4e:
	dw Lz_39_47ab ; $404e
DataPtr_39_50:
	dw Lz_39_47ab ; $4050
DataPtr_39_52:
	dw Lz_39_47ab ; $4052
DataPtr_39_54:
	dw Lz_39_47ab ; $4054
DataPtr_39_56:
	dw Lz_39_47ab ; $4056
DataPtr_39_58:
	dw Lz_39_47fa ; $4058
DataPtr_39_5a:
	dw Lz_39_4809 ; $405a
DataPtr_39_5c:
	dw Lz_39_4833 ; $405c
DataPtr_39_5e:
	dw StatLabelTiles ; $405e
FarPtr_39_60:
	dw Func_39_6dc2 ; $4060
FarPtr_39_62:
	dw Func_39_6df9 ; $4062
FarPtr_39_64:
	dw Func_39_6ec0 ; $4064
FarPtr_39_66:
	dw Func_39_6f10 ; $4066
FarPtr_39_68:
	dw Func_39_6fe7 ; $4068
FarPtr_39_6a:
	dw Func_39_6f67 ; $406a
DataPtr_39_6c:
	dw Lz_39_7009 ; $406c
DataPtr_39_6e:
	dw Lz_39_70bb ; $406e
DataPtr_39_70:
	dw Lz_39_717d ; $4070
DataPtr_39_72:
	dw Lz_39_71b6 ; $4072
DataPtr_39_74:
	dw Lz_39_71e8 ; $4074
DataPtr_39_76:
	dw Lz_39_7223 ; $4076
DataPtr_39_78:
	dw Lz_39_725d ; $4078
DataPtr_39_7a:
	dw DigitFontTiles ; $407a
FarPtr_39_7c:
	dw Func_39_745a ; $407c
Func_39_407e:
	ld hl, $40f5 ; $407e
	ld b, $00 ; $4081
	sla c ; $4083
	rl b ; $4085
	sla c ; $4087
	rl b ; $4089
	sla c ; $408b
	rl b ; $408d
	add hl, bc ; $408f
	wram_bank $01 ; $4090
	push hl ; $4096
	ld a, [hl+] ; $4097
	ld h, [hl] ; $4098
	ld l, a ; $4099
	ld de, $d000 ; $409a
	call DecompressDataFromBank ; $409d
	ld hl, $d000 ; $40a0
	ld de, $b000 ; $40a3
	ld c, $80 ; $40a6
	call Func_00_0480 ; $40a8
	ld hl, $d800 ; $40ab
	ld de, $a800 ; $40ae
	ld c, $80 ; $40b1
	call Func_00_0480 ; $40b3
	pop hl ; $40b6
	inc hl ; $40b7
	inc hl ; $40b8
	push hl ; $40b9
	ld a, [hl+] ; $40ba
	ld h, [hl] ; $40bb
	ld l, a ; $40bc
	wram_bank $03 ; $40bd
	ld de, $d000 ; $40c3
	call DecompressDataFromBank ; $40c6
	pop hl ; $40c9
	inc hl ; $40ca
	inc hl ; $40cb
	push hl ; $40cc
	ld a, [hl+] ; $40cd
	ld h, [hl] ; $40ce
	ld l, a ; $40cf
	ld de, $d400 ; $40d0
	call DecompressDataFromBank ; $40d3
	pop hl ; $40d6
	inc hl ; $40d7
	inc hl ; $40d8
	ld a, [hl+] ; $40d9
	ld h, [hl] ; $40da
	ld l, a ; $40db
	wram_bank $01 ; $40dc
	ld de, $d000 ; $40e2
	ld bc, $0040 ; $40e5
	call CopyDataFromBank ; $40e8
	ld hl, $d000 ; $40eb
	ld de, $0008 ; $40ee
	call LoadPaletteShadow ; $40f1
	ret ; $40f4
	INCBIN "data/bank_039/d_40f5.bin" ; $40f5, 560 bytes
Func_39_4325:
	wram_bank $03 ; $4325
	ld hl, $d000 ; $432b
	ld de, $9800 ; $432e
	ld c, $40 ; $4331
	call Func_00_0480 ; $4333
	ld hl, $d400 ; $4336
	ld de, $b800 ; $4339
	ld c, $40 ; $433c
	call Func_00_0480 ; $433e
	ret ; $4341
Func_39_4342:
	push af ; $4342
	push bc ; $4343
	push de ; $4344
	push hl ; $4345
	ldh a, [hWramBank] ; $4346
	push af ; $4348
	ld a, [$cb0a] ; $4349
	inc a ; $434c
	ld c, a ; $434d
	ld a, [$cb0c] ; $434e
	ld b, a ; $4351
	ld a, c ; $4352
	add a, a ; $4353
	jr nc, Label_39_435a ; $4354
	ld a, b ; $4356
	dec a ; $4357
	jr Label_39_435f ; $4358
Label_39_435a:
	rra ; $435a
	cp a, b ; $435b
	jr c, Label_39_435f ; $435c
	xor a, a ; $435e
Label_39_435f:
	ld [$cb0a], a ; $435f
	or a, a ; $4362
	jp nz, Label_39_43f9 ; $4363
	wram_bank $02 ; $4366
	ld a, [$cb09] ; $436c
	inc a ; $436f
	ld [$cb09], a ; $4370
	and a, $0f ; $4373
	rlca ; $4375
	push af ; $4376
	ld a, [$cb0b] ; $4377
	and a, $03 ; $437a
	add a, a ; $437c
	ld hl, $4403 ; $437d
	add a, l ; $4380
	ld l, a ; $4381
	jr nc, Label_39_4385 ; $4382
	inc h ; $4384
Label_39_4385:
	ld a, [hl+] ; $4385
	ld h, [hl] ; $4386
	ld l, a ; $4387
	ld a, h ; $4388
	ld b, l ; $4389
	and a, b ; $438a
	cp a, $ff ; $438b
	jr z, Label_39_43bb ; $438d
	pop af ; $438f
	push af ; $4390
	add a, l ; $4391
	ld l, a ; $4392
	jr nc, Label_39_4396 ; $4393
	inc h ; $4395
Label_39_4396:
	ld a, [hl+] ; $4396
	ld h, [hl] ; $4397
	ld l, a ; $4398
	wram_bank $01 ; $4399
	ld de, $d000 ; $439f
	call DecompressDataFromBank ; $43a2
	ld hl, $d000 ; $43a5
	ld de, $b2e0 ; $43a8
	ld c, $02 ; $43ab
	call Func_00_0480 ; $43ad
	ld hl, $d020 ; $43b0
	ld de, $b3e0 ; $43b3
	ld c, $02 ; $43b6
	call Func_00_0480 ; $43b8
Label_39_43bb:
	ld a, [$cb0b] ; $43bb
	and a, $03 ; $43be
	add a, a ; $43c0
	ld hl, $440b ; $43c1
	add a, l ; $43c4
	ld l, a ; $43c5
	jr nc, Label_39_43c9 ; $43c6
	inc h ; $43c8
Label_39_43c9:
	ld a, [hl+] ; $43c9
	ld h, [hl] ; $43ca
	ld l, a ; $43cb
	pop af ; $43cc
	ld c, a ; $43cd
	ld a, h ; $43ce
	and a, l ; $43cf
	cp a, $ff ; $43d0
	jr z, Label_39_43f9 ; $43d2
	ld a, c ; $43d4
	add a, l ; $43d5
	ld l, a ; $43d6
	jr nc, Label_39_43da ; $43d7
	inc h ; $43d9
Label_39_43da:
	ld a, [hl+] ; $43da
	ld h, [hl] ; $43db
	ld l, a ; $43dc
	ld de, $d100 ; $43dd
	call DecompressDataFromBank ; $43e0
	ld hl, $d100 ; $43e3
	ld de, $b4e0 ; $43e6
	ld c, $02 ; $43e9
	call Func_00_0480 ; $43eb
	ld hl, $d120 ; $43ee
	ld de, $b5e0 ; $43f1
	ld c, $02 ; $43f4
	call Func_00_0480 ; $43f6
Label_39_43f9:
	pop af ; $43f9
	wram_bank ; $43fa
	pop hl ; $43fe
	pop de ; $43ff
	pop bc ; $4400
	pop af ; $4401
	ret ; $4402
	INCBIN "data/bank_039/d_4403.bin" ; $4403, 208 bytes
Func_39_44d3:
	push de ; $44d3
	wram_bank $01 ; $44d4
	ld hl, $44f6 ; $44da
	ld de, $d000 ; $44dd
	call DecompressData ; $44e0
	ld hl, $d000 ; $44e3
	pop de ; $44e6
	ld c, $04 ; $44e7
	call Func_00_0480 ; $44e9
	ld hl, $4516 ; $44ec
	ld de, $0801 ; $44ef
	call LoadPaletteShadow ; $44f2
	ret ; $44f5
	INCBIN "data/bank_039/d_44f6.bin" ; $44f6, 40 bytes
Func_39_451e:
	ld de, $0001 ; $451e
	ld hl, $4528 ; $4521
	call LoadPaletteShadow ; $4524
	ret ; $4527
	INCBIN "data/bank_039/d_4528.bin" ; $4528, 8 bytes
Func_39_4530:
	push af ; $4530
	push bc ; $4531
	push de ; $4532
	push hl ; $4533
Label_39_4534:
	push bc ; $4534
	push hl ; $4535
	push de ; $4536
Label_39_4537:
	ld a, [hl+] ; $4537
	push hl ; $4538
	ld h, d ; $4539
	ld l, e ; $453a
	ld [hl+], a ; $453b
	ld d, h ; $453c
	ld e, l ; $453d
	pop hl ; $453e
	dec b ; $453f
	jr nz, Label_39_4537 ; $4540
	pop de ; $4542
	pop hl ; $4543
	ld bc, $0020 ; $4544
	add hl, bc ; $4547
	push hl ; $4548
	ld h, d ; $4549
	ld l, e ; $454a
	add hl, bc ; $454b
	ld d, h ; $454c
	ld e, l ; $454d
	pop hl ; $454e
	pop bc ; $454f
	dec c ; $4550
	jr nz, Label_39_4534 ; $4551
	pop hl ; $4553
	pop de ; $4554
	pop bc ; $4555
	pop af ; $4556
	ret ; $4557
Func_39_4558:
	push af ; $4558
	push bc ; $4559
	push de ; $455a
	push hl ; $455b
Label_39_455c:
	push bc ; $455c
	push hl ; $455d
	push de ; $455e
Label_39_455f:
	ld a, h ; $455f
	push hl ; $4560
	ld h, d ; $4561
	ld l, e ; $4562
	ld [hl+], a ; $4563
	ld d, h ; $4564
	ld e, l ; $4565
	pop hl ; $4566
	dec b ; $4567
	jr nz, Label_39_455f ; $4568
	pop de ; $456a
	pop hl ; $456b
	ld bc, $0020 ; $456c
	push hl ; $456f
	ld h, d ; $4570
	ld l, e ; $4571
	add hl, bc ; $4572
	ld d, h ; $4573
	ld e, l ; $4574
	pop hl ; $4575
	pop bc ; $4576
	dec c ; $4577
	jr nz, Label_39_455c ; $4578
	pop hl ; $457a
	pop de ; $457b
	pop bc ; $457c
	pop af ; $457d
	ret ; $457e
Func_39_457f:
	ld e, c ; $457f
	ld d, $00 ; $4580
	sla e ; $4582
	rl d ; $4584
	sla e ; $4586
	rl d ; $4588
	sla e ; $458a
	rl d ; $458c
	ld hl, $4599 ; $458e
	add hl, de ; $4591
	ld d, b ; $4592
	ld e, $01 ; $4593
	call LoadPaletteShadow ; $4595
	ret ; $4598
	INCBIN "data/bank_039/d_4599.bin" ; $4599, 200 bytes
Func_39_4661:
	ld hl, $466b ; $4661
	ld de, $0904 ; $4664
	call LoadPaletteShadow ; $4667
	ret ; $466a
	INCBIN "data/bank_039/d_466b.bin" ; $466b, 32 bytes
Func_39_468b:
	ldh a, [hWramBank] ; $468b
	push af ; $468d
	ld a, b ; $468e
	add a, a ; $468f
	ld hl, $46b7 ; $4690
	add a, l ; $4693
	ld l, a ; $4694
	jr nc, Label_39_4698 ; $4695
	inc h ; $4697
Label_39_4698:
	ld a, [hl+] ; $4698
	ld h, [hl] ; $4699
	ld l, a ; $469a
	push de ; $469b
	push bc ; $469c
	wram_bank $01 ; $469d
	ld de, $d000 ; $46a3
	call DecompressDataFromBank ; $46a6
	pop bc ; $46a9
	pop de ; $46aa
	ld hl, $d000 ; $46ab
	call Func_00_0480 ; $46ae
	pop af ; $46b1
	wram_bank ; $46b2
	ret ; $46b6
	INCBIN "data/bank_039/d_46b7.bin" ; $46b7, 244 bytes
Lz_39_47ab:
	INCBIN "data/bank_039/lz_47ab.bin" ; $47ab, 79 bytes
Lz_39_47fa:
	INCBIN "data/bank_039/lz_47fa.bin" ; $47fa, 15 bytes
Lz_39_4809:
	INCBIN "data/bank_039/lz_4809.bin" ; $4809, 42 bytes
Lz_39_4833:
	INCBIN "data/bank_039/lz_4833.bin" ; $4833, 240 bytes
StatLabelTiles:
	INCBIN "data/bank_039/lz_4923.bin" ; $4923, 243 bytes
Func_39_4a16:
	ld c, $04 ; $4a16
	ld b, $17 ; $4a18
	push de ; $4a1a
	call Func_39_468b ; $4a1b
	pop hl ; $4a1e
	ld de, $0040 ; $4a1f
	add hl, de ; $4a22
	ld d, h ; $4a23
	ld e, l ; $4a24
	ld c, $04 ; $4a25
	ld b, $18 ; $4a27
	push de ; $4a29
	call Func_39_468b ; $4a2a
	pop hl ; $4a2d
	ld de, $0040 ; $4a2e
	add hl, de ; $4a31
	ld d, h ; $4a32
	ld e, l ; $4a33
	ld c, $04 ; $4a34
	ld b, $19 ; $4a36
	push de ; $4a38
	call Func_39_468b ; $4a39
	pop hl ; $4a3c
	ld de, $0040 ; $4a3d
	add hl, de ; $4a40
	ld d, h ; $4a41
	ld e, l ; $4a42
	ld c, $04 ; $4a43
	ld b, $1a ; $4a45
	push de ; $4a47
	call Func_39_468b ; $4a48
	pop hl ; $4a4b
	ld de, $0040 ; $4a4c
	add hl, de ; $4a4f
	ld d, h ; $4a50
	ld e, l ; $4a51
	ret ; $4a52
Func_39_4a53:
	push af ; $4a53
	push bc ; $4a54
	push de ; $4a55
	push hl ; $4a56
	ld a, h ; $4a57
	add a, a ; $4a58
	add a, a ; $4a59
	add a, c ; $4a5a
	ld c, a ; $4a5b
	push af ; $4a5c
	push bc ; $4a5d
	push de ; $4a5e
	push hl ; $4a5f
	call Func_00_1f51 ; $4a60
	pop hl ; $4a63
	pop de ; $4a64
	pop bc ; $4a65
	pop af ; $4a66
	ld a, $08 ; $4a67
	add a, d ; $4a69
	ld d, a ; $4a6a
	inc c ; $4a6b
	inc c ; $4a6c
	call Func_00_1f51 ; $4a6d
	pop hl ; $4a70
	pop de ; $4a71
	pop bc ; $4a72
	pop af ; $4a73
	ret ; $4a74
Func_39_4a75:
	ldh a, [$ff8c] ; $4a75
	and a, $3f ; $4a77
	add a, $84 ; $4a79
	ld l, a ; $4a7b
	adc a, $4a ; $4a7c
	sub a, l ; $4a7e
	ld h, a ; $4a7f
	ld a, [hl] ; $4a80
	add a, e ; $4a81
	ld e, a ; $4a82
	ret ; $4a83
	INCBIN "data/bank_039/d_4a84.bin" ; $4a84, 64 bytes
Func_39_4ac4:
	ldh a, [$ff8c] ; $4ac4
	and a, $3f ; $4ac6
	add a, $d3 ; $4ac8
	ld l, a ; $4aca
	adc a, $4a ; $4acb
	sub a, l ; $4acd
	ld h, a ; $4ace
	ld a, [hl] ; $4acf
	add a, e ; $4ad0
	ld e, a ; $4ad1
	ret ; $4ad2
	INCBIN "data/bank_039/d_4ad3.bin" ; $4ad3, 64 bytes
Func_39_4b13:
	ld a, $01 ; $4b13
	ld [$cb17], a ; $4b15
	ld a, $01 ; $4b18
	ld [$cb18], a ; $4b1a
	xor a, a ; $4b1d
	ld [$cb14], a ; $4b1e
	ld a, $40 ; $4b21
	ld [$cb12], a ; $4b23
	add a, $86 ; $4b26
	ld [$cb13], a ; $4b28
	ld a, $00 ; $4b2b
	ld [$cb15], a ; $4b2d
	ld a, $00 ; $4b30
	ld [$cb16], a ; $4b32
	xor a, a ; $4b35
	ld [$cb19], a ; $4b36
	ret ; $4b39
Func_39_4b3a:
	push bc ; $4b3a
	ld a, c ; $4b3b
	add a, $08 ; $4b3c
	ld d, a ; $4b3e
	ld e, $01 ; $4b3f
	ld hl, $4b65 ; $4b41
	call LoadPaletteShadow ; $4b44
	pop bc ; $4b47
	ld a, b ; $4b48
	add a, $08 ; $4b49
	ld d, a ; $4b4b
	ld e, $01 ; $4b4c
	ld hl, $4b65 ; $4b4e
	call LoadPaletteShadow ; $4b51
	ret ; $4b54
	INCBIN "data/bank_039/d_4b55.bin" ; $4b55, 24 bytes
Func_39_4b6d:
	ld a, [$cb12] ; $4b6d
	dec a ; $4b70
	cp a, $b0 ; $4b71
	jr nz, Label_39_4b77 ; $4b73
	ld a, $a0 ; $4b75
Label_39_4b77:
	ld [$cb12], a ; $4b77
	ld a, [$cb13] ; $4b7a
	dec a ; $4b7d
	cp a, $b0 ; $4b7e
	jr nz, Label_39_4b84 ; $4b80
	ld a, $a0 ; $4b82
Label_39_4b84:
	ld [$cb13], a ; $4b84
	ld a, [$cb19] ; $4b87
	or a, a ; $4b8a
	jr nz, Label_39_4ba4 ; $4b8b
	ld a, [$cb12] ; $4b8d
	ld d, a ; $4b90
	ld a, [$cb15] ; $4b91
	ld c, a ; $4b94
	ld a, [$cb17] ; $4b95
	ld b, a ; $4b98
	ld a, [$cb14] ; $4b99
	ld e, a ; $4b9c
	ld a, $01 ; $4b9d
	ld [$cb19], a ; $4b9f
	jr Label_39_4bb8 ; $4ba2
Label_39_4ba4:
	ld a, [$cb13] ; $4ba4
	ld d, a ; $4ba7
	ld a, [$cb16] ; $4ba8
	ld c, a ; $4bab
	ld a, [$cb18] ; $4bac
	ld b, a ; $4baf
	ld a, [$cb14] ; $4bb0
	ld e, a ; $4bb3
	xor a, a ; $4bb4
	ld [$cb19], a ; $4bb5
Label_39_4bb8:
	ld hl, $4bbf ; $4bb8
	call Func_00_1e9d ; $4bbb
	ret ; $4bbe
	INCBIN "data/bank_039/d_4bbf.bin" ; $4bbf, 41 bytes
Func_39_4be8:
	ld b, $11 ; $4be8
	ld c, $10 ; $4bea
	ld de, $9000 ; $4bec
	farcall FarPtr_39_10 ; $4bef
	ret ; $4bf2
Func_39_4bf3:
	ldh [$ff8b], a ; $4bf3
	ldh [$ff8a], a ; $4bf5
	ld [$c320], a ; $4bf7
	ld [$c321], a ; $4bfa
	ld [$c322], a ; $4bfd
	ld [$c323], a ; $4c00
	farcall FarPtr_39_1c ; $4c03
	farcall FarPtr_05_76 ; $4c06
	ld b, $11 ; $4c09
	ld c, $10 ; $4c0b
	ld de, $9000 ; $4c0d
	farcall FarPtr_39_10 ; $4c10
	wram_bank $05 ; $4c13
	ld a, $03 ; $4c19
	ld [$c3b3], a ; $4c1b
	ld a, $00 ; $4c1e
	ld [$c3b6], a ; $4c20
	ld d, $00 ; $4c23
	ld e, $0f ; $4c25
	ld b, $14 ; $4c27
	ld c, $03 ; $4c29
	farcall FarPtr_05_78 ; $4c2b
	farcall FarPtr_05_7c ; $4c2e
	farcall FarPtr_05_7e ; $4c31
	farcall FarPtr_39_02 ; $4c34
	ret ; $4c37
Func_39_4c38:
	ldh a, [hWramBank] ; $4c38
	push af ; $4c3a
	wram_bank $01 ; $4c3b
	ld hl, $3c08 ; $4c41 -> DataPtr_3c_08
	ld de, $d000 ; $4c44
	call DecompressDataFromBank ; $4c47
	ld hl, $d000 ; $4c4a
	ld de, $b000 ; $4c4d
	ld c, $80 ; $4c50
	call Func_00_0480 ; $4c52
	ld hl, $d800 ; $4c55
	ld de, $a800 ; $4c58
	ld c, $80 ; $4c5b
	call Func_00_0480 ; $4c5d
	wram_bank $03 ; $4c60
	ld hl, $3c0a ; $4c66 -> DataPtr_3c_0a
	ld de, $d000 ; $4c69
	call DecompressDataFromBank ; $4c6c
	ld hl, $3c0a ; $4c6f -> DataPtr_3c_0a
	ld de, $d800 ; $4c72
	call DecompressDataFromBank ; $4c75
	ld hl, $3c0c ; $4c78 -> DataPtr_3c_0c
	ld de, $d400 ; $4c7b
	call DecompressDataFromBank ; $4c7e
	ld hl, $3c0c ; $4c81 -> DataPtr_3c_0c
	ld de, $dc00 ; $4c84
	call DecompressDataFromBank ; $4c87
	wram_bank $01 ; $4c8a
	ld hl, $3c0e ; $4c90 -> DataPtr_3c_0e
	ld de, $d000 ; $4c93
	ld bc, $0040 ; $4c96
	call CopyDataFromBank ; $4c99
	ld hl, $d000 ; $4c9c
	ld de, $0008 ; $4c9f
	call LoadPaletteShadow ; $4ca2
	pop af ; $4ca5
	wram_bank ; $4ca6
	ret ; $4caa
Func_39_4cab:
	push af ; $4cab
	push bc ; $4cac
	push de ; $4cad
	push hl ; $4cae
	ldh a, [hWramBank] ; $4caf
	push af ; $4cb1
	wram_bank $03 ; $4cb2
	ld a, b ; $4cb8
	or a, a ; $4cb9
	jr nz, Label_39_4d1a ; $4cba
	ld c, $04 ; $4cbc
	ld hl, $d000 ; $4cbe
	ld de, $9800 ; $4cc1
	call Func_00_0480 ; $4cc4
	ld c, $04 ; $4cc7
	ld hl, $d400 ; $4cc9
	ld de, $b800 ; $4ccc
	call Func_00_0480 ; $4ccf
	ld c, $06 ; $4cd2
	ld hl, $d060 ; $4cd4
	ld de, $9860 ; $4cd7
	call Func_00_0480 ; $4cda
	ld c, $06 ; $4cdd
	ld hl, $d460 ; $4cdf
	ld de, $b860 ; $4ce2
	call Func_00_0480 ; $4ce5
	call Func_00_2631 ; $4ce8
	ld c, $06 ; $4ceb
	ld hl, $d0e0 ; $4ced
	ld de, $98e0 ; $4cf0
	call Func_00_0480 ; $4cf3
	ld c, $06 ; $4cf6
	ld hl, $d4e0 ; $4cf8
	ld de, $b8e0 ; $4cfb
	call Func_00_0480 ; $4cfe
	ld c, $06 ; $4d01
	ld hl, $d160 ; $4d03
	ld de, $9960 ; $4d06
	call Func_00_0480 ; $4d09
	ld c, $06 ; $4d0c
	ld hl, $d560 ; $4d0e
	ld de, $b960 ; $4d11
	call Func_00_0480 ; $4d14
	jp Label_39_4de1 ; $4d17
Label_39_4d1a:
	cp a, $01 ; $4d1a
	jr nz, Label_39_4d65 ; $4d1c
	ld c, $04 ; $4d1e
	ld hl, $d000 ; $4d20
	ld de, $9800 ; $4d23
	call Func_00_0480 ; $4d26
	ld c, $04 ; $4d29
	ld hl, $d400 ; $4d2b
	ld de, $b800 ; $4d2e
	call Func_00_0480 ; $4d31
	ld c, $06 ; $4d34
	ld hl, $d080 ; $4d36
	ld de, $9880 ; $4d39
	call Func_00_0480 ; $4d3c
	ld c, $06 ; $4d3f
	ld hl, $d480 ; $4d41
	ld de, $b880 ; $4d44
	call Func_00_0480 ; $4d47
	call Func_00_2631 ; $4d4a
	ld c, $06 ; $4d4d
	ld hl, $d140 ; $4d4f
	ld de, $9940 ; $4d52
	call Func_00_0480 ; $4d55
	ld c, $06 ; $4d58
	ld hl, $d540 ; $4d5a
	ld de, $b940 ; $4d5d
	call Func_00_0480 ; $4d60
	jr Label_39_4de1 ; $4d63
Label_39_4d65:
	cp a, $02 ; $4d65
	jr nz, Label_39_4db0 ; $4d67
	ld c, $04 ; $4d69
	ld hl, $d000 ; $4d6b
	ld de, $9800 ; $4d6e
	call Func_00_0480 ; $4d71
	ld c, $04 ; $4d74
	ld hl, $d400 ; $4d76
	ld de, $b800 ; $4d79
	call Func_00_0480 ; $4d7c
	ld c, $06 ; $4d7f
	ld hl, $d080 ; $4d81
	ld de, $9880 ; $4d84
	call Func_00_0480 ; $4d87
	ld c, $06 ; $4d8a
	ld hl, $d480 ; $4d8c
	ld de, $b880 ; $4d8f
	call Func_00_0480 ; $4d92
	call Func_00_2631 ; $4d95
	ld c, $06 ; $4d98
	ld hl, $d120 ; $4d9a
	ld de, $9920 ; $4d9d
	call Func_00_0480 ; $4da0
	ld c, $06 ; $4da3
	ld hl, $d520 ; $4da5
	ld de, $b920 ; $4da8
	call Func_00_0480 ; $4dab
	jr Label_39_4de1 ; $4dae
Label_39_4db0:
	ld c, $04 ; $4db0
	ld hl, $d000 ; $4db2
	ld de, $9800 ; $4db5
	call Func_00_0480 ; $4db8
	ld c, $04 ; $4dbb
	ld hl, $d400 ; $4dbd
	ld de, $b800 ; $4dc0
	call Func_00_0480 ; $4dc3
	call Func_00_2631 ; $4dc6
	ld c, $06 ; $4dc9
	ld hl, $d0e0 ; $4dcb
	ld de, $98e0 ; $4dce
	call Func_00_0480 ; $4dd1
	ld c, $06 ; $4dd4
	ld hl, $d4e0 ; $4dd6
	ld de, $b8e0 ; $4dd9
	call Func_00_0480 ; $4ddc
	jr Label_39_4de1 ; $4ddf
Label_39_4de1:
	pop af ; $4de1
	wram_bank ; $4de2
	pop hl ; $4de6
	pop de ; $4de7
	pop bc ; $4de8
	pop af ; $4de9
	ret ; $4dea
Func_39_4deb:
	push af ; $4deb
	push bc ; $4dec
	push de ; $4ded
	push hl ; $4dee
	push af ; $4def
	push bc ; $4df0
	push de ; $4df1
	push hl ; $4df2
	ld hl, $d800 ; $4df3
	ld de, $d000 ; $4df6
	ld b, $14 ; $4df9
	ld c, $10 ; $4dfb
	call Func_39_4530 ; $4dfd
	ld hl, $dc00 ; $4e00
	ld de, $d400 ; $4e03
	ld b, $14 ; $4e06
	ld c, $10 ; $4e08
	call Func_39_4530 ; $4e0a
	pop hl ; $4e0d
	pop de ; $4e0e
	pop bc ; $4e0f
	pop af ; $4e10
	ld a, b ; $4e11
	add a, a ; $4e12
	ld hl, $4e60 ; $4e13
	add a, l ; $4e16
	ld l, a ; $4e17
	jr nc, Label_39_4e1b ; $4e18
	inc h ; $4e1a
Label_39_4e1b:
	ld a, [hl+] ; $4e1b
	ld h, [hl] ; $4e1c
	ld l, a ; $4e1d
	ld a, c ; $4e1e
	add a, a ; $4e1f
	add a, l ; $4e20
	ld l, a ; $4e21
	jr nc, Label_39_4e25 ; $4e22
	inc h ; $4e24
Label_39_4e25:
	ld a, [hl+] ; $4e25
	ld h, [hl] ; $4e26
	ld l, a ; $4e27
Label_39_4e28:
	push hl ; $4e28
	ld a, [hl+] ; $4e29
	ld b, [hl] ; $4e2a
	ld c, a ; $4e2b
	push bc ; $4e2c
	inc hl ; $4e2d
	ld a, [hl+] ; $4e2e
	ld d, [hl] ; $4e2f
	ld e, a ; $4e30
	inc hl ; $4e31
	ld a, [hl+] ; $4e32
	or a, a ; $4e33
	jr z, Label_39_4e59 ; $4e34
	ld c, [hl] ; $4e36
	ld b, a ; $4e37
	pop hl ; $4e38
	push bc ; $4e39
	push hl ; $4e3a
	push de ; $4e3b
	call Func_39_4530 ; $4e3c
	pop de ; $4e3f
	ld hl, $0400 ; $4e40
	add hl, de ; $4e43
	ld d, h ; $4e44
	ld e, l ; $4e45
	pop hl ; $4e46
	ld bc, $0400 ; $4e47
	add hl, bc ; $4e4a
	pop bc ; $4e4b
	call Func_39_4530 ; $4e4c
	pop hl ; $4e4f
	ld a, $06 ; $4e50
	add a, l ; $4e52
	ld l, a ; $4e53
	jr nc, Label_39_4e57 ; $4e54
	inc h ; $4e56
Label_39_4e57:
	jr Label_39_4e28 ; $4e57
Label_39_4e59:
	pop hl ; $4e59
	pop hl ; $4e5a
	pop hl ; $4e5b
	pop de ; $4e5c
	pop bc ; $4e5d
	pop af ; $4e5e
	ret ; $4e5f
	INCBIN "data/bank_039/d_4e60.bin" ; $4e60, 8034 bytes
Func_39_6dc2:
	push af ; $6dc2
	push bc ; $6dc3
	push de ; $6dc4
	push hl ; $6dc5
	ld d, c ; $6dc6
	ld e, b ; $6dc7
	ld b, $03 ; $6dc8
	ld c, $03 ; $6dca
	ld a, d ; $6dcc
	or a, a ; $6dcd
	jr z, Label_39_6dd4 ; $6dce
	ld h, $0c ; $6dd0
	jr Label_39_6dd6 ; $6dd2
Label_39_6dd4:
	ld h, $0d ; $6dd4
Label_39_6dd6:
	push hl ; $6dd6
	ld hl, $6ded ; $6dd7
	ld a, e ; $6dda
	add a, a ; $6ddb
	add a, l ; $6ddc
	ld l, a ; $6ddd
	jr nc, Label_39_6de1 ; $6dde
	inc h ; $6de0
Label_39_6de1:
	ld a, [hl+] ; $6de1
	ld d, [hl] ; $6de2
	ld e, a ; $6de3
	pop hl ; $6de4
	farcall FarPtr_39_0c ; $6de5
	pop hl ; $6de8
	pop de ; $6de9
	pop bc ; $6dea
	pop af ; $6deb
	ret ; $6dec
	INCBIN "data/bank_039/d_6ded.bin" ; $6ded, 12 bytes
Func_39_6df9:
	ld a, [$cb05] ; $6df9
	or a, a ; $6dfc
	jr nz, Label_39_6e64 ; $6dfd
	ld a, [$cb0d] ; $6dff
	bit 4, a ; $6e02
	jr nz, Label_39_6e16 ; $6e04
	bit 5, a ; $6e06
	jr nz, Label_39_6e30 ; $6e08
	bit 6, a ; $6e0a
	jr nz, Label_39_6e49 ; $6e0c
	bit 7, a ; $6e0e
	jr nz, Label_39_6e49 ; $6e10
	xor a, a ; $6e12
	jp Label_39_6eb9 ; $6e13
Label_39_6e16:
	ld a, [$cb04] ; $6e16
	inc a ; $6e19
	add a, a ; $6e1a
	jr nc, Label_39_6e22 ; $6e1b
	ld a, $03 ; $6e1d
	dec a ; $6e1f
	jr Label_39_6e28 ; $6e20
Label_39_6e22:
	rra ; $6e22
	cp a, $03 ; $6e23
	jr c, Label_39_6e28 ; $6e25
	xor a, a ; $6e27
Label_39_6e28:
	ld [$cb04], a ; $6e28
	ld a, $01 ; $6e2b
	jp Label_39_6eb9 ; $6e2d
Label_39_6e30:
	ld a, [$cb04] ; $6e30
	dec a ; $6e33
	add a, a ; $6e34
	jr nc, Label_39_6e3c ; $6e35
	ld a, $03 ; $6e37
	dec a ; $6e39
	jr Label_39_6e42 ; $6e3a
Label_39_6e3c:
	rra ; $6e3c
	cp a, $03 ; $6e3d
	jr c, Label_39_6e42 ; $6e3f
	xor a, a ; $6e41
Label_39_6e42:
	ld [$cb04], a ; $6e42
	ld a, $01 ; $6e45
	jr Label_39_6eb9 ; $6e47
Label_39_6e49:
	ld a, [$cb04] ; $6e49
	ld hl, $6eba ; $6e4c
	add a, l ; $6e4f
	ld l, a ; $6e50
	jr nc, Label_39_6e54 ; $6e51
	inc h ; $6e53
Label_39_6e54:
	ld a, [hl] ; $6e54
	ld [$cb04], a ; $6e55
	ld a, [$cb05] ; $6e58
	xor a, $01 ; $6e5b
	ld [$cb05], a ; $6e5d
	ld a, $01 ; $6e60
	jr Label_39_6eb9 ; $6e62
Label_39_6e64:
	ld a, [$cb0d] ; $6e64
	bit 4, a ; $6e67
	jr nz, Label_39_6e7a ; $6e69
	bit 5, a ; $6e6b
	jr nz, Label_39_6e8c ; $6e6d
	bit 6, a ; $6e6f
	jr nz, Label_39_6e9e ; $6e71
	bit 7, a ; $6e73
	jr nz, Label_39_6e9e ; $6e75
	xor a, a ; $6e77
	jr Label_39_6eb9 ; $6e78
Label_39_6e7a:
	ld a, [$cb04] ; $6e7a
	or a, a ; $6e7d
	jr z, Label_39_6e83 ; $6e7e
	xor a, a ; $6e80
	jr Label_39_6e85 ; $6e81
Label_39_6e83:
	ld a, $02 ; $6e83
Label_39_6e85:
	ld [$cb04], a ; $6e85
	ld a, $01 ; $6e88
	jr Label_39_6eb9 ; $6e8a
Label_39_6e8c:
	ld a, [$cb04] ; $6e8c
	or a, a ; $6e8f
	jr z, Label_39_6e95 ; $6e90
	xor a, a ; $6e92
	jr Label_39_6e97 ; $6e93
Label_39_6e95:
	ld a, $02 ; $6e95
Label_39_6e97:
	ld [$cb04], a ; $6e97
	ld a, $01 ; $6e9a
	jr Label_39_6eb9 ; $6e9c
Label_39_6e9e:
	ld a, [$cb04] ; $6e9e
	ld hl, $6ebd ; $6ea1
	add a, l ; $6ea4
	ld l, a ; $6ea5
	jr nc, Label_39_6ea9 ; $6ea6
	inc h ; $6ea8
Label_39_6ea9:
	ld a, [hl] ; $6ea9
	ld [$cb04], a ; $6eaa
	ld a, [$cb05] ; $6ead
	xor a, $01 ; $6eb0
	ld [$cb05], a ; $6eb2
	ld a, $01 ; $6eb5
	jr Label_39_6eb9 ; $6eb7
Label_39_6eb9:
	ret ; $6eb9
	INCBIN "data/bank_039/d_6eba.bin" ; $6eba, 6 bytes
Func_39_6ec0:
	push af ; $6ec0
	push bc ; $6ec1
	push de ; $6ec2
	push hl ; $6ec3
	ld hl, $cb64 ; $6ec4
	ld bc, $0007 ; $6ec7
	call ClearBytes ; $6eca
	xor a, a ; $6ecd
	ld [$cb6b], a ; $6ece
	ld [$cb6c], a ; $6ed1
	pop hl ; $6ed4
	pop de ; $6ed5
	pop bc ; $6ed6
	pop af ; $6ed7
	ld a, $08 ; $6ed8
	ld [$cb6c], a ; $6eda
	ld a, $00 ; $6edd
	ld [$cb6b], a ; $6edf
	ld a, c ; $6ee2
	or a, a ; $6ee3
	jr nz, Label_39_6ef9 ; $6ee4
	push bc ; $6ee6
	ld b, $49 ; $6ee7
	ld c, $14 ; $6ee9
	farcall FarPtr_39_10 ; $6eeb
	pop bc ; $6eee
	ld hl, $6f08 ; $6eef
	ld d, b ; $6ef2
	ld e, $01 ; $6ef3
	call LoadPaletteShadow ; $6ef5
	ret ; $6ef8
Label_39_6ef9:
	push bc ; $6ef9
	ld b, $14 ; $6efa
	ld c, $18 ; $6efc
	farcall FarPtr_39_10 ; $6efe
	pop bc ; $6f01
	ld c, $0c ; $6f02
	farcall FarPtr_39_0e ; $6f04
	ret ; $6f07
	INCBIN "data/bank_039/d_6f08.bin" ; $6f08, 8 bytes
Func_39_6f10:
	push af ; $6f10
	push bc ; $6f11
	push de ; $6f12
	push hl ; $6f13
	ldh a, [hWramBank] ; $6f14
	push af ; $6f16
	wram_bank $02 ; $6f17
	push de ; $6f1d
	ld de, $cb64 ; $6f1e
	ld a, $00 ; $6f21
	call Func_00_1972 ; $6f23
	pop de ; $6f26
	ld b, $00 ; $6f27
	ld hl, $cb64 ; $6f29
Label_39_6f2c:
	ld a, [hl] ; $6f2c
	or a, a ; $6f2d
	jr z, Label_39_6f34 ; $6f2e
	inc b ; $6f30
	inc hl ; $6f31
	jr Label_39_6f2c ; $6f32
Label_39_6f34:
	dec hl ; $6f34
Label_39_6f35:
	ld a, [hl-] ; $6f35
	sub a, $30 ; $6f36
	ld c, a ; $6f38
	call Func_39_6f4f ; $6f39
	ld a, d ; $6f3c
	sub a, $08 ; $6f3d
	ld d, a ; $6f3f
	dec b ; $6f40
	jr z, Label_39_6f45 ; $6f41
	jr Label_39_6f35 ; $6f43
Label_39_6f45:
	pop af ; $6f45
	wram_bank ; $6f46
	pop hl ; $6f4a
	pop de ; $6f4b
	pop bc ; $6f4c
	pop af ; $6f4d
	ret ; $6f4e
Func_39_6f4f:
	push af ; $6f4f
	push bc ; $6f50
	push de ; $6f51
	push hl ; $6f52
	ld a, [$cb6b] ; $6f53
	ld b, a ; $6f56
	ld a, c ; $6f57
	add a, a ; $6f58
	add a, b ; $6f59
	ld c, a ; $6f5a
	ld a, [$cb6c] ; $6f5b
	ld b, a ; $6f5e
	call Func_00_1f51 ; $6f5f
	pop hl ; $6f62
	pop de ; $6f63
	pop bc ; $6f64
	pop af ; $6f65
	ret ; $6f66
Func_39_6f67:
	ldh a, [hWramBank] ; $6f67
	push af ; $6f69
	wram_bank $01 ; $6f6a
	ld a, [$cb71] ; $6f70
	or a, a ; $6f73
	jr nz, Label_39_6fc0 ; $6f74
	ldh a, [$ff94] ; $6f76
	bit 0, a ; $6f78
	jr z, Label_39_6fa5 ; $6f7a
	ld c, $00 ; $6f7c
Label_39_6f7e:
	ld hl, $d000 ; $6f7e
	ld a, c ; $6f81
	add a, l ; $6f82
	ld l, a ; $6f83
	jr nc, Label_39_6f87 ; $6f84
	inc h ; $6f86
Label_39_6f87:
	ld d, [hl] ; $6f87
	ld a, c ; $6f88
	ld hl, $6fc6 ; $6f89
	add a, l ; $6f8c
	ld l, a ; $6f8d
	jr nc, Label_39_6f91 ; $6f8e
	inc h ; $6f90
Label_39_6f91:
	ld a, [hl] ; $6f91
	cp a, d ; $6f92
	jr nz, Label_39_6fc0 ; $6f93
	inc c ; $6f95
	ld a, c ; $6f96
	cp a, $20 ; $6f97
	jr nz, Label_39_6f7e ; $6f99
	call Func_39_7003 ; $6f9b
	ld a, $01 ; $6f9e
	ld [$cb71], a ; $6fa0
	jr Label_39_6fc0 ; $6fa3
Label_39_6fa5:
	ldh a, [$ff94] ; $6fa5
	or a, a ; $6fa7
	jr z, Label_39_6fc0 ; $6fa8
	ld b, a ; $6faa
	ld a, [$cb1a] ; $6fab
	and a, $1f ; $6fae
	ld hl, $d000 ; $6fb0
	add a, l ; $6fb3
	ld l, a ; $6fb4
	jr nc, Label_39_6fb8 ; $6fb5
	inc h ; $6fb7
Label_39_6fb8:
	ld [hl], b ; $6fb8
	ld a, [$cb1a] ; $6fb9
	inc a ; $6fbc
	ld [$cb1a], a ; $6fbd
Label_39_6fc0:
	pop af ; $6fc0
	wram_bank ; $6fc1
	ret ; $6fc5
	INCBIN "data/bank_039/d_6fc6.bin" ; $6fc6, 33 bytes
Func_39_6fe7:
	ldh a, [hWramBank] ; $6fe7
	push af ; $6fe9
	wram_bank $01 ; $6fea
	xor a, a ; $6ff0
	ld [$cb1a], a ; $6ff1
	ld hl, $d000 ; $6ff4
	ld bc, $0020 ; $6ff7
	call ClearBytes ; $6ffa
	pop af ; $6ffd
	wram_bank ; $6ffe
	ret ; $7002
Func_39_7003:
	sound $65 ; $7003
	farcall FarPtr_3b_34 ; $7005
	ret ; $7008
Lz_39_7009:
	INCBIN "data/bank_039/lz_7009.bin" ; $7009, 178 bytes
Lz_39_70bb:
	INCBIN "data/bank_039/lz_70bb.bin" ; $70bb, 194 bytes
Lz_39_717d:
	INCBIN "data/bank_039/lz_717d.bin" ; $717d, 57 bytes
Lz_39_71b6:
	INCBIN "data/bank_039/lz_71b6.bin" ; $71b6, 50 bytes
Lz_39_71e8:
	INCBIN "data/bank_039/lz_71e8.bin" ; $71e8, 59 bytes
Lz_39_7223:
	INCBIN "data/bank_039/lz_7223.bin" ; $7223, 58 bytes
Lz_39_725d:
	INCBIN "data/bank_039/lz_725d.bin" ; $725d, 241 bytes
DigitFontTiles:
	INCBIN "data/bank_039/lz_734e.bin" ; $734e, 249 bytes
	INCBIN "data/bank_039/d_7447.bin" ; $7447, 19 bytes
Func_39_745a:
	ld a, b ; $745a
	ld [hl+], a ; $745b
	inc b ; $745c
	dec c ; $745d
	ld a, c ; $745e
	or a, a ; $745f
	jr nz, Func_39_745a ; $7460
	ret ; $7462
	ds 2973, $ff ; $7463, fill
