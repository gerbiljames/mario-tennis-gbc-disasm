INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $16", ROMX[$4000], BANK[$16]

	INCBIN "data/bank_016/d_4000.bin" ; $4000, 1014 bytes
	rst Rst18 ; $43f6
	inc b ; $43f7
	add hl, sp ; $43f8
	ret ; $43f9
	INCBIN "data/bank_016/d_43fa.bin" ; $43fa, 125 bytes
Label_16_4477:
	ld a, [$c4c3] ; $4477
	bit 7, a ; $447a
	ret nz ; $447c
	call DisableLCDSafely ; $447d
	call Func_00_1b38 ; $4480
	ld a, $03 ; $4483
	ldh [$ff96], a ; $4485
	ldh [rWBK], a ; $4487
	ld a, [wGameMode] ; $4489
	cp a, $04 ; $448c
	jr z, Label_16_4496 ; $448e
	cp a, $09 ; $4490
	jr z, Label_16_4496 ; $4492
	jr Label_16_449a ; $4494
Label_16_4496:
	ld a, $01 ; $4496
	jr Label_16_449b ; $4498
Label_16_449a:
	xor a, a ; $449a
Label_16_449b:
	ld [$d800], a ; $449b
	ld [$d801], a ; $449e
	ld a, [wMatchWinLoseFlag] ; $44a1
	ld [$cb73], a ; $44a4
	call Func_16_5c11 ; $44a7
	ld a, $ff ; $44aa
	ld a, [wMatchWinLoseFlag] ; $44ac
	cp a, $ff ; $44af
	jr z, Label_16_44b7 ; $44b1
	rst Rst08 ; $44b3
	add hl, bc ; $44b4
	jr Label_16_44b9 ; $44b5
Label_16_44b7:
	rst Rst08 ; $44b7
	ld a, [bc] ; $44b8
Label_16_44b9:
	call Func_16_4571 ; $44b9
	rst Rst18 ; $44bc
	inc b ; $44bd
	add hl, sp ; $44be
	ld a, $01 ; $44bf
	ld hl, $43f6 ; $44c1
	call Func_00_1b6a ; $44c4
	ld a, $01 ; $44c7
	ld hl, $4cb1 ; $44c9
	call Func_00_1b6a ; $44cc
	call EnableLCD ; $44cf
	ld c, $10 ; $44d2
	call Func_00_1d2e ; $44d4
	call Func_00_1da4 ; $44d7
	ld a, $08 ; $44da
	ldh [rSTAT], a ; $44dc
	ld hl, rIE ; $44de
	set 1, [hl] ; $44e1
	ld a, $48 ; $44e3
	ld [$cb02], a ; $44e5
	ld a, $57 ; $44e8
	ld [$cb03], a ; $44ea
	xor a, a ; $44ed
	ld [$cb01], a ; $44ee
	ld a, $01 ; $44f1
	ld hl, $4c9d ; $44f3
	call Func_00_1b6a ; $44f6
Label_16_44f9:
	call Func_00_2631 ; $44f9
	ld a, [$c8f7] ; $44fc
	push de ; $44ff
	push af ; $4500
	ld a, a ; $4501
	ld de, $0303 ; $4502
	call Func_00_1ae4 ; $4505
	pop af ; $4508
	pop de ; $4509
	ldh a, [$ff91] ; $450a
	ld [$cb0d], a ; $450c
	bit 0, a ; $450f
	jr nz, Label_16_451d ; $4511
	bit 1, a ; $4513
	jr nz, Label_16_451d ; $4515
	bit 4, a ; $4517
	jr nz, Label_16_453b ; $4519
	jr Label_16_44f9 ; $451b
Label_16_451d:
	rst Rst08 ; $451d
	ld e, a ; $451e
	call Func_00_1b38 ; $451f
	ld c, $40 ; $4522
	call Func_00_1d20 ; $4524
	call Func_00_1da4 ; $4527
	ld hl, rIE ; $452a
	res 1, [hl] ; $452d
	ld a, $03 ; $452f
	ld [$cb0c], a ; $4531
	ld a, [$cb73] ; $4534
	ld [wMatchWinLoseFlag], a ; $4537
	ret ; $453a
Label_16_453b:
	ld c, $40 ; $453b
	call Func_00_1d20 ; $453d
	call Func_00_1da4 ; $4540
	ld hl, rIE ; $4543
	res 1, [hl] ; $4546
	call Func_00_1b38 ; $4548
	call Func_16_5c35 ; $454b
	push af ; $454e
	ld a, [$cb73] ; $454f
	ld [wMatchWinLoseFlag], a ; $4552
	pop af ; $4555
	cp a, $ff ; $4556
	jp nz, Label_16_4477 ; $4558
	call Func_00_1b38 ; $455b
	ld c, $08 ; $455e
	call Func_00_1d20 ; $4560
	call Func_00_1da4 ; $4563
	ld hl, rIE ; $4566
	res 1, [hl] ; $4569
	ld a, $03 ; $456b
	ld [$cb0c], a ; $456d
	ret ; $4570
Func_16_4571:
	call Func_00_1b38 ; $4571
	xor a, a ; $4574
	ldh [$ff8b], a ; $4575
	ldh [$ff8a], a ; $4577
	call Func_16_490c ; $4579
	ld a, $03 ; $457c
	ldh [$ff96], a ; $457e
	ldh [rWBK], a ; $4580
	ld de, $d560 ; $4582
	ld b, $14 ; $4585
	ld c, $05 ; $4587
	ld h, $0a ; $4589
	rst Rst18 ; $458b
	inc c ; $458c
	add hl, sp ; $458d
	ld a, $00 ; $458e
	ld d, $04 ; $4590
	rst Rst18 ; $4592
	ld [bc], a ; $4593
	INCBIN "data/bank_016/d_4594.bin" ; $4594, 1 bytes
	ld a, $00 ; $4595
	ld d, $05 ; $4597
	rst Rst18 ; $4599
	ld [bc], a ; $459a
	INCBIN "data/bank_016/d_459b.bin" ; $459b, 1 bytes
	ld a, $00 ; $459c
	ld d, $06 ; $459e
	rst Rst18 ; $45a0
	ld [bc], a ; $45a1
	INCBIN "data/bank_016/d_45a2.bin" ; $45a2, 1 bytes
	ld a, $00 ; $45a3
	ld d, $07 ; $45a5
	rst Rst18 ; $45a7
	ld [bc], a ; $45a8
	INCBIN "data/bank_016/d_45a9.bin" ; $45a9, 1 bytes
	call Func_16_4a0f ; $45aa
	call Func_16_4a56 ; $45ad
	call Func_16_4dfe ; $45b0
	call Func_16_4963 ; $45b3
	ld c, $00 ; $45b6
	call Func_16_5fe7 ; $45b8
	ldh a, [$ff96] ; $45bb
	push af ; $45bd
	ld a, $01 ; $45be
	ldh [$ff96], a ; $45c0
	ldh [rWBK], a ; $45c2
	ld hl, $4608 ; $45c4
	ld de, $d000 ; $45c7
	call DecompressData ; $45ca
	ld hl, $d000 ; $45cd
	ld de, $a000 ; $45d0
	ld c, $20 ; $45d3
	call Func_00_0480 ; $45d5
	ld hl, $4784 ; $45d8
	ld de, $d000 ; $45db
	call DecompressData ; $45de
	ld hl, $d000 ; $45e1
	ld de, $a200 ; $45e4
	ld c, $20 ; $45e7
	call Func_00_0480 ; $45e9
	ld hl, $48f4 ; $45ec
	ld de, $0803 ; $45ef
	call Func_00_05b0 ; $45f2
	ld b, $09 ; $45f5
	ld c, $04 ; $45f7
	ld de, $a400 ; $45f9
	rst Rst18 ; $45fc
	INCBIN "data/bank_016/d_45fd.bin" ; $45fd, 2 bytes
	pop af ; $45ff
	ldh [$ff96], a ; $4600
	ldh [rWBK], a ; $4602
	rst Rst18 ; $4604
	ld [bc], a ; $4605
	add hl, sp ; $4606
	ret ; $4607
	INCBIN "data/bank_016/d_4608.bin" ; $4608, 772 bytes
Func_16_490c:
	ld a, [$d800] ; $490c
	or a, a ; $490f
	jr z, Label_16_4919 ; $4910
	ld c, $14 ; $4912
	rst Rst18 ; $4914
	nop ; $4915
	add hl, sp ; $4916
	jr Label_16_4920 ; $4917
Label_16_4919:
	ld c, $13 ; $4919
	rst Rst18 ; $491b
	nop ; $491c
	add hl, sp ; $491d
	jr Label_16_4920 ; $491e
Label_16_4920:
	ld de, $002f ; $4920
	call Func_00_24ef ; $4923
	jr nz, Label_16_4962 ; $4926
	ld a, $03 ; $4928
	ldh [$ff96], a ; $492a
	ldh [rWBK], a ; $492c
	ld hl, $d280 ; $492e
	ld de, $d08b ; $4931
	ld b, $09 ; $4934
	ld c, $05 ; $4936
	rst Rst18 ; $4938
	ld a, [bc] ; $4939
	add hl, sp ; $493a
	ld hl, $d680 ; $493b
	ld de, $d48b ; $493e
	ld b, $09 ; $4941
	ld c, $05 ; $4943
	rst Rst18 ; $4945
	ld a, [bc] ; $4946
	add hl, sp ; $4947
	ld hl, $d289 ; $4948
	ld de, $d161 ; $494b
	ld b, $08 ; $494e
	ld c, $05 ; $4950
	rst Rst18 ; $4952
	ld a, [bc] ; $4953
	add hl, sp ; $4954
	ld hl, $d689 ; $4955
	ld de, $d561 ; $4958
	ld b, $08 ; $495b
	ld c, $05 ; $495d
	rst Rst18 ; $495f
	ld a, [bc] ; $4960
	add hl, sp ; $4961
Label_16_4962:
	ret ; $4962
Func_16_4963:
	ld a, [$d801] ; $4963
	or a, a ; $4966
	jr nz, Label_16_49bc ; $4967
	ld de, $002f ; $4969
	call Func_00_24ef ; $496c
	jr z, Label_16_49a3 ; $496f
	ld de, $d48b ; $4971
	ld b, $04 ; $4974
	ld c, $04 ; $4976
	ld h, $0c ; $4978
	rst Rst18 ; $497a
	inc c ; $497b
	add hl, sp ; $497c
	ld de, $d48f ; $497d
	ld b, $04 ; $4980
	ld c, $04 ; $4982
	ld h, $0d ; $4984
	rst Rst18 ; $4986
	inc c ; $4987
	add hl, sp ; $4988
	ld de, $d582 ; $4989
	ld b, $03 ; $498c
	ld c, $03 ; $498e
	ld h, $0e ; $4990
	rst Rst18 ; $4992
	inc c ; $4993
	add hl, sp ; $4994
	ld de, $d585 ; $4995
	ld b, $03 ; $4998
	ld c, $03 ; $499a
	ld h, $0f ; $499c
	rst Rst18 ; $499e
	inc c ; $499f
	add hl, sp ; $49a0
	jr Label_16_49bb ; $49a1
Label_16_49a3:
	ld de, $d48d ; $49a3
	ld b, $04 ; $49a6
	ld c, $04 ; $49a8
	ld h, $0c ; $49aa
	rst Rst18 ; $49ac
	inc c ; $49ad
	add hl, sp ; $49ae
	ld de, $d583 ; $49af
	ld b, $03 ; $49b2
	ld c, $03 ; $49b4
	ld h, $0e ; $49b6
	rst Rst18 ; $49b8
	inc c ; $49b9
	add hl, sp ; $49ba
Label_16_49bb:
	ret ; $49bb
Label_16_49bc:
	ld de, $002f ; $49bc
	call Func_00_24ef ; $49bf
	jr z, Label_16_49f6 ; $49c2
	ld de, $d4ac ; $49c4
	ld b, $03 ; $49c7
	ld c, $03 ; $49c9
	ld h, $0c ; $49cb
	rst Rst18 ; $49cd
	inc c ; $49ce
	add hl, sp ; $49cf
	ld de, $d4af ; $49d0
	ld b, $03 ; $49d3
	ld c, $03 ; $49d5
	ld h, $0d ; $49d7
	rst Rst18 ; $49d9
	inc c ; $49da
	add hl, sp ; $49db
	ld de, $d582 ; $49dc
	ld b, $03 ; $49df
	ld c, $03 ; $49e1
	ld h, $0e ; $49e3
	rst Rst18 ; $49e5
	inc c ; $49e6
	add hl, sp ; $49e7
	ld de, $d585 ; $49e8
	ld b, $03 ; $49eb
	ld c, $03 ; $49ed
	ld h, $0f ; $49ef
	rst Rst18 ; $49f1
	inc c ; $49f2
	add hl, sp ; $49f3
	jr Label_16_4a0e ; $49f4
Label_16_49f6:
	ld de, $d4ad ; $49f6
	ld b, $03 ; $49f9
	ld c, $03 ; $49fb
	ld h, $0c ; $49fd
	rst Rst18 ; $49ff
	inc c ; $4a00
	add hl, sp ; $4a01
	ld de, $d583 ; $4a02
	ld b, $03 ; $4a05
	ld c, $03 ; $4a07
	ld h, $0e ; $4a09
	rst Rst18 ; $4a0b
	inc c ; $4a0c
	add hl, sp ; $4a0d
Label_16_4a0e:
	ret ; $4a0e
Func_16_4a0f:
	ld a, [wMatchWinLoseFlag] ; $4a0f
	cp a, $ff ; $4a12
	jr z, Label_16_4a2e ; $4a14
	ld a, $02 ; $4a16
	ld [$cb0b], a ; $4a18
	ld hl, $4a4e ; $4a1b
	ld de, $0101 ; $4a1e
	call Func_00_05b0 ; $4a21
	ld hl, $4a46 ; $4a24
	ld de, $0201 ; $4a27
	call Func_00_05b0 ; $4a2a
	ret ; $4a2d
Label_16_4a2e:
	ld a, $03 ; $4a2e
	ld [$cb0b], a ; $4a30
	ld hl, $4a4e ; $4a33
	ld de, $0201 ; $4a36
	call Func_00_05b0 ; $4a39
	ld hl, $4a46 ; $4a3c
	ld de, $0101 ; $4a3f
	call Func_00_05b0 ; $4a42
	ret ; $4a45
	INCBIN "data/bank_016/d_4a46.bin" ; $4a46, 16 bytes
Func_16_4a56:
	ld a, [wMatchWinLoseFlag] ; $4a56
	cp a, $ff ; $4a59
	jr nz, Label_16_4a6f ; $4a5b
	ld hl, $d240 ; $4a5d
	ld de, $d120 ; $4a60
	ld b, $20 ; $4a63
	ld c, $02 ; $4a65
	rst Rst18 ; $4a67
	ld a, [bc] ; $4a68
	add hl, sp ; $4a69
	ld a, $06 ; $4a6a
	ld [$cb0c], a ; $4a6c
Label_16_4a6f:
	ret ; $4a6f
	INCBIN "data/bank_016/d_4a70.bin" ; $4a70, 557 bytes
	ld a, [wMatchWinLoseFlag] ; $4c9d
	cp a, $ff ; $4ca0
	jr nz, Label_16_4ca9 ; $4ca2
	ldh a, [$ff8c] ; $4ca4
	and a, $01 ; $4ca6
	ret z ; $4ca8
Label_16_4ca9:
	ld a, [$cb01] ; $4ca9
	inc a ; $4cac
	ld [$cb01], a ; $4cad
	ret ; $4cb0
	ld a, [wMatchWinLoseFlag] ; $4cb1
	cp a, $ff ; $4cb4
	jr z, Label_16_4cd1 ; $4cb6
	ld de, $0824 ; $4cb8
	call Func_16_4cea ; $4cbb
	ld de, $502c ; $4cbe
	call Func_16_4d96 ; $4cc1
	ld de, $5060 ; $4cc4
	call Func_16_4d45 ; $4cc7
	ld de, $4e68 ; $4cca
	call Func_16_4dad ; $4ccd
	ret ; $4cd0
Label_16_4cd1:
	ld de, $5860 ; $4cd1
	call Func_16_4cea ; $4cd4
	ld de, $5068 ; $4cd7
	call Func_16_4dc7 ; $4cda
	ld de, $0024 ; $4cdd
	call Func_16_4d45 ; $4ce0
	ld de, $482c ; $4ce3
	call Func_16_4dba ; $4ce6
	ret ; $4ce9
Func_16_4cea:
	call Func_16_4dde ; $4cea
	ld b, a ; $4ced
	ld a, d ; $4cee
	sub a, b ; $4cef
	ld d, a ; $4cf0
	ld c, $00 ; $4cf1
	ld b, $08 ; $4cf3
	ldh a, [$ff8c] ; $4cf5
	and a, $10 ; $4cf7
	jr z, Label_16_4cfd ; $4cf9
	ld b, $0a ; $4cfb
Label_16_4cfd:
	ld hl, $4d04 ; $4cfd
	call Func_00_1e9d ; $4d00
	ret ; $4d03
	INCBIN "data/bank_016/d_4d04.bin" ; $4d04, 65 bytes
Func_16_4d45:
	call Func_16_4dde ; $4d45
	add a, d ; $4d48
	ld d, a ; $4d49
	ld c, $20 ; $4d4a
	ld b, $09 ; $4d4c
	ld hl, $4d55 ; $4d4e
	call Func_00_1e9d ; $4d51
	ret ; $4d54
	INCBIN "data/bank_016/d_4d55.bin" ; $4d55, 65 bytes
Func_16_4d96:
	call Func_16_4dde ; $4d96
	ld b, a ; $4d99
	ld a, d ; $4d9a
	sub a, b ; $4d9b
	ld d, a ; $4d9c
	ld c, $40 ; $4d9d
	ld b, $08 ; $4d9f
	ldh a, [$ff8c] ; $4da1
	and a, $10 ; $4da3
	jr z, Label_16_4da9 ; $4da5
	ld b, $0a ; $4da7
Label_16_4da9:
	call Func_00_1f51 ; $4da9
	ret ; $4dac
Func_16_4dad:
	call Func_16_4dde ; $4dad
	add a, d ; $4db0
	ld d, a ; $4db1
	ld c, $42 ; $4db2
	ld b, $09 ; $4db4
	call Func_00_1f51 ; $4db6
	ret ; $4db9
Func_16_4dba:
	call Func_16_4dde ; $4dba
	add a, d ; $4dbd
	ld d, a ; $4dbe
	ld c, $40 ; $4dbf
	ld b, $09 ; $4dc1
	call Func_00_1f51 ; $4dc3
	ret ; $4dc6
Func_16_4dc7:
	call Func_16_4dde ; $4dc7
	ld b, a ; $4dca
	ld a, d ; $4dcb
	sub a, b ; $4dcc
	ld d, a ; $4dcd
	ld c, $42 ; $4dce
	ld b, $08 ; $4dd0
	ldh a, [$ff8c] ; $4dd2
	and a, $10 ; $4dd4
	jr z, Label_16_4dda ; $4dd6
	ld b, $0a ; $4dd8
Label_16_4dda:
	call Func_00_1f51 ; $4dda
	ret ; $4ddd
Func_16_4dde:
	ldh a, [$ff8c] ; $4dde
	srl a ; $4de0
	and a, $0f ; $4de2
	ld hl, $4dee ; $4de4
	add a, l ; $4de7
	ld l, a ; $4de8
	jr nc, Label_16_4dec ; $4de9
	inc h ; $4deb
Label_16_4dec:
	ld a, [hl] ; $4dec
	ret ; $4ded
	INCBIN "data/bank_016/d_4dee.bin" ; $4dee, 16 bytes
Func_16_4dfe:
	ld de, $d400 ; $4dfe
	ld b, $14 ; $4e01
	ld c, $02 ; $4e03
	ld h, $0b ; $4e05
	rst Rst18 ; $4e07
	inc c ; $4e08
	add hl, sp ; $4e09
	ld de, $d600 ; $4e0a
	ld b, $14 ; $4e0d
	ld c, $02 ; $4e0f
	ld h, $0b ; $4e11
	rst Rst18 ; $4e13
	inc c ; $4e14
	add hl, sp ; $4e15
	ld de, $002f ; $4e16
	call Func_00_24ef ; $4e19
	jr nz, Label_16_4e29 ; $4e1c
	ld hl, $542e ; $4e1e
	ld de, $9000 ; $4e21
	call DecompressData ; $4e24
	jr Label_16_4e32 ; $4e27
Label_16_4e29:
	ld hl, $54bd ; $4e29
	ld de, $9000 ; $4e2c
	call DecompressData ; $4e2f
Label_16_4e32:
	ld a, [$d800] ; $4e32
	or a, a ; $4e35
	jr z, Label_16_4e54 ; $4e36
	ld hl, $5357 ; $4e38
	ld de, $8900 ; $4e3b
	call DecompressData ; $4e3e
	ld hl, $53c1 ; $4e41
	ld de, $8a40 ; $4e44
	call DecompressData ; $4e47
	ld hl, $5bf5 ; $4e4a
	ld de, $9140 ; $4e4d
	call DecompressData ; $4e50
	ret ; $4e53
Label_16_4e54:
	ld a, [$c8f7] ; $4e54
	call Func_16_4e8a ; $4e57
	add a, a ; $4e5a
	ld hl, $4e9d ; $4e5b
	add a, l ; $4e5e
	ld l, a ; $4e5f
	jr nc, Label_16_4e63 ; $4e60
	inc h ; $4e62
Label_16_4e63:
	ld a, [hl+] ; $4e63
	ld h, [hl] ; $4e64
	ld l, a ; $4e65
	push hl ; $4e66
	ld a, [hl+] ; $4e67
	ld h, [hl] ; $4e68
	ld l, a ; $4e69
	ld de, $8900 ; $4e6a
	call DecompressData ; $4e6d
	pop hl ; $4e70
	inc hl ; $4e71
	inc hl ; $4e72
	push hl ; $4e73
	ld a, [hl+] ; $4e74
	ld h, [hl] ; $4e75
	ld l, a ; $4e76
	ld de, $8a40 ; $4e77
	call DecompressData ; $4e7a
	pop hl ; $4e7d
	inc hl ; $4e7e
	inc hl ; $4e7f
	ld a, [hl+] ; $4e80
	ld h, [hl] ; $4e81
	ld l, a ; $4e82
	ld de, $9140 ; $4e83
	call DecompressData ; $4e86
	ret ; $4e89
Func_16_4e8a:
	push af ; $4e8a
	ld de, $002f ; $4e8b
	call Func_00_24ef ; $4e8e
	jr z, Label_16_4e9b ; $4e91
	cp a, $11 ; $4e93
	jr nz, Label_16_4e9b ; $4e95
	ld a, $10 ; $4e97
	pop hl ; $4e99
	ret ; $4e9a
Label_16_4e9b:
	pop af ; $4e9b
	ret ; $4e9c
	INCBIN "data/bank_016/d_4e9d.bin" ; $4e9d, 3444 bytes
Func_16_5c11:
	ld a, [wGameMode] ; $5c11
	cp a, $09 ; $5c14
	ret nz ; $5c16
	ld a, [$c8b9] ; $5c17
	cp a, $01 ; $5c1a
	jr nz, Label_16_5c1f ; $5c1c
	ret ; $5c1e
Label_16_5c1f:
	cp a, $02 ; $5c1f
	jr nz, Label_16_5c34 ; $5c21
	ld a, [wMatchWinLoseFlag] ; $5c23
	cp a, $ff ; $5c26
	jr z, Label_16_5c2e ; $5c28
	ld a, $ff ; $5c2a
	jr Label_16_5c30 ; $5c2c
Label_16_5c2e:
	ld a, $01 ; $5c2e
Label_16_5c30:
	ld [wMatchWinLoseFlag], a ; $5c30
	ret ; $5c33
Label_16_5c34:
	ret ; $5c34
Func_16_5c35:
	call DisableLCDSafely ; $5c35
	rst Rst18 ; $5c38
	ld a, [bc] ; $5c39
	ld bc, $033e ; $5c3a
	ldh [$ff96], a ; $5c3d
	ldh [rWBK], a ; $5c3f
	ld a, $01 ; $5c41
	ld [$d801], a ; $5c43
	call Func_16_5c8a ; $5c46
	call Func_16_4a0f ; $5c49
	ld a, $01 ; $5c4c
	ld hl, $43f6 ; $5c4e
	call Func_00_1b6a ; $5c51
	call EnableLCD ; $5c54
	ld c, $10 ; $5c57
	call Func_00_1d2e ; $5c59
	call Func_00_1da4 ; $5c5c
Label_16_5c5f:
	call Func_16_5fce ; $5c5f
	ldh a, [$ff91] ; $5c62
	bit 5, a ; $5c64
	jr nz, Label_16_5c75 ; $5c66
	bit 0, a ; $5c68
	jr nz, Label_16_5c7f ; $5c6a
	bit 1, a ; $5c6c
	jr nz, Label_16_5c7f ; $5c6e
	call Func_00_2631 ; $5c70
	jr Label_16_5c5f ; $5c73
Label_16_5c75:
	ld c, $40 ; $5c75
	call Func_00_1d20 ; $5c77
	call Func_00_1da4 ; $5c7a
	xor a, a ; $5c7d
	ret ; $5c7e
Label_16_5c7f:
	ld c, $20 ; $5c7f
	call Func_00_1d20 ; $5c81
	call Func_00_1da4 ; $5c84
	ld a, $ff ; $5c87
	ret ; $5c89
Func_16_5c8a:
	ld c, $23 ; $5c8a
	rst Rst18 ; $5c8c
	nop ; $5c8d
	add hl, sp ; $5c8e
	ld de, $a000 ; $5c8f
	ld c, $00 ; $5c92
	ld b, $08 ; $5c94
	rst Rst18 ; $5c96
	ld h, h ; $5c97
	add hl, sp ; $5c98
	ld a, $00 ; $5c99
	ld d, $04 ; $5c9b
	rst Rst18 ; $5c9d
	ld [bc], a ; $5c9e
	jr Label_16_5cdf ; $5c9f
	INCBIN "data/bank_016/d_5ca1.bin" ; $5ca1, 62 bytes
Label_16_5cdf:
	call Func_00_24ef ; $5cdf
	jr z, Label_16_5d16 ; $5ce2
	ld de, $d481 ; $5ce4
	ld b, $03 ; $5ce7
	ld c, $03 ; $5ce9
	ld h, $0c ; $5ceb
	rst Rst18 ; $5ced
	inc c ; $5cee
	add hl, sp ; $5cef
	ld de, $d484 ; $5cf0
	ld b, $03 ; $5cf3
	ld c, $03 ; $5cf5
	ld h, $0d ; $5cf7
	rst Rst18 ; $5cf9
	inc c ; $5cfa
	add hl, sp ; $5cfb
	ld de, $d48d ; $5cfc
	ld b, $03 ; $5cff
	ld c, $03 ; $5d01
	ld h, $0e ; $5d03
	rst Rst18 ; $5d05
	inc c ; $5d06
	add hl, sp ; $5d07
	ld de, $d490 ; $5d08
	ld b, $03 ; $5d0b
	ld c, $03 ; $5d0d
	ld h, $0f ; $5d0f
	rst Rst18 ; $5d11
	inc c ; $5d12
	add hl, sp ; $5d13
	jr Label_16_5d2e ; $5d14
Label_16_5d16:
	ld de, $d482 ; $5d16
	ld b, $03 ; $5d19
	ld c, $03 ; $5d1b
	ld h, $0c ; $5d1d
	rst Rst18 ; $5d1f
	inc c ; $5d20
	add hl, sp ; $5d21
	ld de, $d48e ; $5d22
	ld b, $03 ; $5d25
	ld c, $03 ; $5d27
	ld h, $0e ; $5d29
	rst Rst18 ; $5d2b
	inc c ; $5d2c
	add hl, sp ; $5d2d
Label_16_5d2e:
	ret ; $5d2e
	INCBIN "data/bank_016/d_5d2f.bin" ; $5d2f, 671 bytes
Func_16_5fce:
	ld a, [wPlayer1SetsWon] ; $5fce
	ld h, $00 ; $5fd1
	ld l, a ; $5fd3
	ld de, $1c48 ; $5fd4
	rst Rst18 ; $5fd7
	ld h, [hl] ; $5fd8
	add hl, sp ; $5fd9
	ld a, [wPlayer2SetsWon] ; $5fda
	ld h, $00 ; $5fdd
	ld l, a ; $5fdf
	ld de, $8448 ; $5fe0
	rst Rst18 ; $5fe3
	ld h, [hl] ; $5fe4
	add hl, sp ; $5fe5
	ret ; $5fe6
Func_16_5fe7:
	ld a, c ; $5fe7
	or a, a ; $5fe8
	jr nz, Label_16_5ff9 ; $5fe9
	ld a, [wGameMode] ; $5feb
	cp a, $09 ; $5fee
	jr nz, Label_16_5ff9 ; $5ff0
	ld a, [$c8b9] ; $5ff2
	cp a, $02 ; $5ff5
	jr z, Label_16_6036 ; $5ff7
Label_16_5ff9:
	ld a, [wPlayer1CurrentMainCharacter] ; $5ff9
	ld d, a ; $5ffc
	ld a, [$ca0c] ; $5ffd
	ld b, a ; $6000
	ld c, $00 ; $6001
	call Func_16_6073 ; $6003
	ld a, [wPlayer2CurrentMainCharacter] ; $6006
	ld d, a ; $6009
	ld a, [$ca8c] ; $600a
	ld b, a ; $600d
	ld c, $02 ; $600e
	call Func_16_6073 ; $6010
	ld de, $002f ; $6013
	call Func_00_24ef ; $6016
	jr z, Label_16_6035 ; $6019
	ld a, [wPlayer1CurrentPartnerCharacter] ; $601b
	ld d, a ; $601e
	ld a, [$ca4c] ; $601f
	ld b, a ; $6022
	ld c, $01 ; $6023
	call Func_16_6073 ; $6025
	ld a, [wPlayer2CurrentPartnerCharacter] ; $6028
	ld d, a ; $602b
	ld a, [$cacc] ; $602c
	ld b, a ; $602f
	ld c, $03 ; $6030
	call Func_16_6073 ; $6032
Label_16_6035:
	ret ; $6035
Label_16_6036:
	ld a, [wPlayer1CurrentMainCharacter] ; $6036
	ld d, a ; $6039
	ld a, [$ca0c] ; $603a
	ld b, a ; $603d
	ld c, $02 ; $603e
	call Func_16_6073 ; $6040
	ld a, [wPlayer2CurrentMainCharacter] ; $6043
	ld d, a ; $6046
	ld a, [$ca8c] ; $6047
	ld b, a ; $604a
	ld c, $00 ; $604b
	call Func_16_6073 ; $604d
	ld de, $002f ; $6050
	call Func_00_24ef ; $6053
	jr z, Label_16_6072 ; $6056
	ld a, [wPlayer1CurrentPartnerCharacter] ; $6058
	ld d, a ; $605b
	ld a, [$ca4c] ; $605c
	ld b, a ; $605f
	ld c, $03 ; $6060
	call Func_16_6073 ; $6062
	ld a, [wPlayer2CurrentPartnerCharacter] ; $6065
	ld d, a ; $6068
	ld a, [$cacc] ; $6069
	ld b, a ; $606c
	ld c, $01 ; $606d
	call Func_16_6073 ; $606f
Label_16_6072:
	ret ; $6072
Func_16_6073:
	push de ; $6073
	push bc ; $6074
	ld a, c ; $6075
	add a, $04 ; $6076
	ld d, a ; $6078
	ld a, b ; $6079
	rst Rst18 ; $607a
	ld [bc], a ; $607b
	INCBIN "data/bank_016/d_607c.bin" ; $607c, 1 bytes
	pop bc ; $607d
	pop de ; $607e
	ld b, d ; $607f
	ld a, c ; $6080
	add a, a ; $6081
	ld hl, $60b7 ; $6082
	add a, l ; $6085
	ld l, a ; $6086
	jr nc, Label_16_608a ; $6087
	inc h ; $6089
Label_16_608a:
	ld a, [hl+] ; $608a
	ld d, [hl] ; $608b
	ld e, a ; $608c
	push de ; $608d
	ld a, c ; $608e
	cp a, $02 ; $608f
	jr z, Label_16_6099 ; $6091
	cp a, $03 ; $6093
	jr z, Label_16_6099 ; $6095
	jr Label_16_609d ; $6097
Label_16_6099:
	ld c, $00 ; $6099
	jr Label_16_60b2 ; $609b
Label_16_609d:
	ld a, [$d801] ; $609d
	or a, a ; $60a0
	jr z, Label_16_60a7 ; $60a1
	ld c, $00 ; $60a3
	jr Label_16_60b2 ; $60a5
Label_16_60a7:
	ld c, $01 ; $60a7
	ld a, [wMatchWinLoseFlag] ; $60a9
	cp a, $ff ; $60ac
	jr nz, Label_16_60b2 ; $60ae
	ld c, $02 ; $60b0
Label_16_60b2:
	pop de ; $60b2
	call Func_16_60c0 ; $60b3
	ret ; $60b6
	INCBIN "data/bank_016/d_60b7.bin" ; $60b7, 9 bytes
Func_16_60c0:
	ld a, c ; $60c0
	or a, a ; $60c1
	jr z, Label_16_60c8 ; $60c2
	call Func_16_60d5 ; $60c4
	ret ; $60c7
Label_16_60c8:
	cp a, $20 ; $60c8
	jr c, Label_16_60d1 ; $60ca
	ld a, b ; $60cc
	rst Rst18 ; $60cd
	ld [hl], $02 ; $60ce
	ld b, a ; $60d0
Label_16_60d1:
	call Func_16_6955 ; $60d1
	ret ; $60d4
Func_16_60d5:
	ld a, b ; $60d5
	add a, a ; $60d6
	and a, $07 ; $60d7
	ld b, a ; $60d9
	ld a, c ; $60da
	cp a, $01 ; $60db
	ld a, b ; $60dd
	jr z, Label_16_60e1 ; $60de
	inc a ; $60e0
Label_16_60e1:
	ld hl, $60f1 ; $60e1
	add a, a ; $60e4
	add a, l ; $60e5
	ld l, a ; $60e6
	jr nc, Label_16_60ea ; $60e7
	inc h ; $60e9
Label_16_60ea:
	ld a, [hl+] ; $60ea
	ld h, [hl] ; $60eb
	ld l, a ; $60ec
	call DecompressData ; $60ed
	ret ; $60f0
	INCBIN "data/bank_016/d_60f1.bin" ; $60f1, 2148 bytes
Func_16_6955:
	ld a, b ; $6955
	and a, $1f ; $6956
	add a, a ; $6958
	ld hl, $6968 ; $6959
	add a, l ; $695c
	ld l, a ; $695d
	jr nc, Label_16_6961 ; $695e
	inc h ; $6960
Label_16_6961:
	ld a, [hl+] ; $6961
	ld h, [hl] ; $6962
	ld l, a ; $6963
	call DecompressData ; $6964
	ret ; $6967
	INCBIN "data/bank_016/d_6968.bin" ; $6968, 5784 bytes
