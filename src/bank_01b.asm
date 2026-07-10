INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $1b", ROMX[$4000], BANK[$1b]

FarPtr_1b_00:
	dw Func_1b_4e5c ; $4000
FarPtr_1b_02:
	dw Func_1b_4e58 ; $4002
FarPtr_1b_04:
	dw Func_1b_4e7f ; $4004
FarPtr_1b_06:
	dw Func_1b_4e80 ; $4006
FarPtr_1b_08:
	dw Func_1b_4e80 ; $4008
FarPtr_1b_0a:
	dw Func_1b_4e57 ; $400a
FarPtr_1b_0c:
	dw Func_1b_4e0d ; $400c
FarPtr_1b_0e:
	dw Func_1b_4e18 ; $400e
FarPtr_1b_10:
	dw Func_1b_4e37 ; $4010
FarPtr_1b_12:
	dw Func_1b_4e43 ; $4012
FarPtr_1b_14:
	dw Func_1b_4e44 ; $4014
FarPtr_1b_16:
	dw Func_1b_4e45 ; $4016
FarPtr_1b_18:
	dw Func_1b_4e46 ; $4018
FarPtr_1b_1a:
	dw Func_1b_4e81 ; $401a
FarPtr_1b_1c:
	dw Func_1b_6172 ; $401c
FarPtr_1b_1e:
	dw Func_1b_6982 ; $401e
FarPtr_1b_20:
	dw Func_1b_6ade ; $4020
FarPtr_1b_22:
	dw Func_1b_61ba ; $4022
FarPtr_1b_24:
	dw Func_1b_62f8 ; $4024
FarPtr_1b_26:
	dw Func_1b_671c ; $4026
FarPtr_1b_28:
	dw Func_1b_6b9c ; $4028
FarPtr_1b_2a:
	dw Func_1b_715d ; $402a
FarPtr_1b_2c:
	dw Func_1b_73dd ; $402c
	INCBIN "data/bank_01b/d_402e.bin" ; $402e, 159 bytes
Func_1b_40cd:
	ldh a, [$ff8c] ; $40cd
	and a, $0f ; $40cf
	ld hl, $40e7 ; $40d1
	add a, l ; $40d4
	ld l, a ; $40d5
	jr nc, Label_1b_40d9 ; $40d6
	inc h ; $40d8
Label_1b_40d9:
	ld a, [hl] ; $40d9
	ld b, a ; $40da
	ld a, c ; $40db
	or a, a ; $40dc
	jr z, Label_1b_40e3 ; $40dd
	ld a, b ; $40df
	add a, e ; $40e0
	ld e, a ; $40e1
	ret ; $40e2
Label_1b_40e3:
	ld a, e ; $40e3
	sub a, b ; $40e4
	ld e, a ; $40e5
	ret ; $40e6
	INCBIN "data/bank_01b/d_40e7.bin" ; $40e7, 75 bytes
Func_1b_4132:
	ld a, [$cb04] ; $4132
	ld d, a ; $4135
	ld a, [$cb05] ; $4136
	ld e, a ; $4139
	ld a, [$cb0d] ; $413a
	bit 4, a ; $413d
	jr z, Label_1b_4156 ; $413f
	ld a, [$cb04] ; $4141
	inc a ; $4144
	add a, a ; $4145
	jr nc, Label_1b_414c ; $4146
	ld a, b ; $4148
	dec a ; $4149
	jr Label_1b_4151 ; $414a
Label_1b_414c:
	rra ; $414c
	cp a, b ; $414d
	jr c, Label_1b_4151 ; $414e
	xor a, a ; $4150
Label_1b_4151:
	ld [$cb04], a ; $4151
	jr Label_1b_419f ; $4154
Label_1b_4156:
	bit 5, a ; $4156
	jr z, Label_1b_416f ; $4158
	ld a, [$cb04] ; $415a
	dec a ; $415d
	add a, a ; $415e
	jr nc, Label_1b_4165 ; $415f
	ld a, b ; $4161
	dec a ; $4162
	jr Label_1b_416a ; $4163
Label_1b_4165:
	rra ; $4165
	cp a, b ; $4166
	jr c, Label_1b_416a ; $4167
	xor a, a ; $4169
Label_1b_416a:
	ld [$cb04], a ; $416a
	jr Label_1b_419f ; $416d
Label_1b_416f:
	bit 6, a ; $416f
	jr z, Label_1b_4188 ; $4171
	ld a, [$cb05] ; $4173
	dec a ; $4176
	add a, a ; $4177
	jr nc, Label_1b_417e ; $4178
	ld a, c ; $417a
	dec a ; $417b
	jr Label_1b_4183 ; $417c
Label_1b_417e:
	rra ; $417e
	cp a, c ; $417f
	jr c, Label_1b_4183 ; $4180
	xor a, a ; $4182
Label_1b_4183:
	ld [$cb05], a ; $4183
	jr Label_1b_419f ; $4186
Label_1b_4188:
	bit 7, a ; $4188
	jr z, Label_1b_419f ; $418a
	ld a, [$cb05] ; $418c
	inc a ; $418f
	add a, a ; $4190
	jr nc, Label_1b_4197 ; $4191
	ld a, c ; $4193
	dec a ; $4194
	jr Label_1b_419c ; $4195
Label_1b_4197:
	rra ; $4197
	cp a, c ; $4198
	jr c, Label_1b_419c ; $4199
	xor a, a ; $419b
Label_1b_419c:
	ld [$cb05], a ; $419c
Label_1b_419f:
	ld a, [$cb04] ; $419f
	cp a, d ; $41a2
	jr nz, Label_1b_41ad ; $41a3
	ld a, [$cb05] ; $41a5
	cp a, e ; $41a8
	jr nz, Label_1b_41ad ; $41a9
	xor a, a ; $41ab
	ret ; $41ac
Label_1b_41ad:
	ld a, $01 ; $41ad
	ret ; $41af
	INCBIN "data/bank_01b/d_41b0.bin" ; $41b0, 529 bytes
Func_1b_43c1:
	ld a, [$cb05] ; $43c1
	ld b, a ; $43c4
	xor a, a ; $43c5
	inc b ; $43c6
Label_1b_43c7:
	dec b ; $43c7
	jr z, Label_1b_43cd ; $43c8
	add a, c ; $43ca
	jr Label_1b_43c7 ; $43cb
Label_1b_43cd:
	ld b, a ; $43cd
	ld a, [$cb04] ; $43ce
	add a, b ; $43d1
	ret ; $43d2
	INCBIN "data/bank_01b/d_43d3.bin" ; $43d3, 16 bytes
Func_1b_43e3:
	ld d, $00 ; $43e3
	ld a, c ; $43e5
Label_1b_43e6:
	cp a, b ; $43e6
	jr c, Label_1b_43ed ; $43e7
	inc d ; $43e9
	sub a, b ; $43ea
	jr Label_1b_43e6 ; $43eb
Label_1b_43ed:
	ld [$cb04], a ; $43ed
	ld a, d ; $43f0
	ld [$cb05], a ; $43f1
	ret ; $43f4
	INCBIN "data/bank_01b/d_43f5.bin" ; $43f5, 13 bytes
	ret ; $4402
	INCBIN "data/bank_01b/d_4403.bin" ; $4403, 49 bytes
Func_1b_4434:
	push af ; $4434
	push bc ; $4435
Label_1b_4436:
	ld a, [hl] ; $4436
	cp a, $00 ; $4437
	jr z, Label_1b_446a ; $4439
	ld [de], a ; $443b
	inc hl ; $443c
	ld a, [hl] ; $443d
	cp a, $de ; $443e
	jr z, Label_1b_4446 ; $4440
	cp a, $df ; $4442
	jr nz, Label_1b_445b ; $4444
Label_1b_4446:
	push hl ; $4446
	push bc ; $4447
	ld h, d ; $4448
	ld l, e ; $4449
	ld bc, $ffe0 ; $444a
	add hl, bc ; $444d
	ld b, a ; $444e
	ld a, [hl] ; $444f
	cp a, $03 ; $4450
	ld a, b ; $4452
	jr nz, Label_1b_4457 ; $4453
	sub a, $d0 ; $4455
Label_1b_4457:
	ld [hl], a ; $4457
	pop bc ; $4458
	pop hl ; $4459
	inc hl ; $445a
Label_1b_445b:
	inc de ; $445b
	ld a, e ; $445c
	and a, $1f ; $445d
	jr nz, Label_1b_4436 ; $445f
	push hl ; $4461
	ld h, d ; $4462
	ld l, e ; $4463
	add hl, de ; $4464
	ld d, h ; $4465
	ld e, l ; $4466
	pop hl ; $4467
	jr Label_1b_4436 ; $4468
Label_1b_446a:
	pop bc ; $446a
	pop af ; $446b
	ret ; $446c
	INCBIN "data/bank_01b/d_446d.bin" ; $446d, 2463 bytes
Func_1b_4e0c:
	ret ; $4e0c
Func_1b_4e0d:
	ld a, $ff ; $4e0d
	ld [$c780], a ; $4e0f
	ld d, $03 ; $4e12
	farcall FarPtr_18_00 ; $4e14
	ret ; $4e17
Func_1b_4e18:
	push af ; $4e18
	push de ; $4e19
	push hl ; $4e1a
	and a, $07 ; $4e1b
	add a, $03 ; $4e1d
	or a, $08 ; $4e1f
	ld hl, $dc00 ; $4e21
	add hl, de ; $4e24
	ld de, $001d ; $4e25
	ld [hl+], a ; $4e28
	ld [hl+], a ; $4e29
	ld [hl+], a ; $4e2a
	add hl, de ; $4e2b
	ld [hl+], a ; $4e2c
	ld [hl+], a ; $4e2d
	ld [hl+], a ; $4e2e
	add hl, de ; $4e2f
	ld [hl+], a ; $4e30
	ld [hl+], a ; $4e31
	ld [hl+], a ; $4e32
	pop hl ; $4e33
	pop de ; $4e34
	pop af ; $4e35
	ret ; $4e36
Func_1b_4e37:
	cp a, $40 ; $4e37
	ret nc ; $4e39
	push de ; $4e3a
	ld de, $d600 ; $4e3b
	call Func_1b_4e5c ; $4e3e
	pop de ; $4e41
	ret ; $4e42
Func_1b_4e43:
	ret ; $4e43
Func_1b_4e44:
	ret ; $4e44
Func_1b_4e45:
	ret ; $4e45
Func_1b_4e46:
	push af ; $4e46
	push bc ; $4e47
	push de ; $4e48
	push hl ; $4e49
	ld hl, $d600 ; $4e4a
	ld c, $09 ; $4e4d
	call Func_00_0480 ; $4e4f
	pop hl ; $4e52
	pop de ; $4e53
	pop bc ; $4e54
	pop af ; $4e55
	ret ; $4e56
Func_1b_4e57:
	ret ; $4e57
Func_1b_4e58:
	farcall FarPtr_18_02 ; $4e58
	ret ; $4e5b
Func_1b_4e5c:
	push af ; $4e5c
	push de ; $4e5d
	push hl ; $4e5e
	call Func_1b_4e0c ; $4e5f
	cp a, $3f ; $4e62
	jr nz, Label_1b_4e6c ; $4e64
	ld b, a ; $4e66
	ld a, [$c36c] ; $4e67
	add a, b ; $4e6a
	inc a ; $4e6b
Label_1b_4e6c:
	ld l, a ; $4e6c
	ld h, $00 ; $4e6d
	add hl, hl ; $4e6f
	add hl, hl ; $4e70
	ld bc, $4cec ; $4e71
	add hl, bc ; $4e74
	ld a, [hl+] ; $4e75
	ld h, [hl] ; $4e76
	ld l, a ; $4e77
	call DecompressData ; $4e78
	pop hl ; $4e7b
	pop de ; $4e7c
	pop af ; $4e7d
	ret ; $4e7e
Func_1b_4e7f:
	ret ; $4e7f
Func_1b_4e80:
	ret ; $4e80
Func_1b_4e81:
	ld a, $03 ; $4e81
	ldh [$ff96], a ; $4e83
	ldh [rWBK], a ; $4e85
	xor a, a ; $4e87
	ld [$d85a], a ; $4e88
	ld a, b ; $4e8b
	ld [$d800], a ; $4e8c
	ld a, c ; $4e8f
	ld [$d801], a ; $4e90
	ld a, d ; $4e93
	ld [$d802], a ; $4e94
	cp a, $03 ; $4e97
	jr nz, Label_1b_4ea4 ; $4e99
	xor a, a ; $4e9b
	ld [$d802], a ; $4e9c
	ld a, $01 ; $4e9f
	ld [$d85a], a ; $4ea1
Label_1b_4ea4:
	ld a, [$d802] ; $4ea4
	cp a, $01 ; $4ea7
	jr nz, Label_1b_4eaf ; $4ea9
	sound $2b ; $4eab
	jr Label_1b_4eb5 ; $4ead
Label_1b_4eaf:
	cp a, $02 ; $4eaf
	jr nz, Label_1b_4eb5 ; $4eb1
	sound $2a ; $4eb3
Label_1b_4eb5:
	call DisableLCDSafely ; $4eb5
	call Func_1b_4ef2 ; $4eb8
	call EnableLCD ; $4ebb
	ld c, $04 ; $4ebe
	call Func_00_1d2e ; $4ec0
	call Func_00_1da4 ; $4ec3
	ld a, $03 ; $4ec6
	ldh [$ff96], a ; $4ec8
	ldh [rWBK], a ; $4eca
	call Func_1b_4ff1 ; $4ecc
	call Func_00_2725 ; $4ecf
	ld e, $cd ; $4ed2
	rlca ; $4ed4
	ld d, l ; $4ed5
	ld c, $20 ; $4ed6
	ld a, [$d802] ; $4ed8
	or a, a ; $4edb
	jr nz, Label_1b_4ee8 ; $4edc
	ld a, [$d85a] ; $4ede
	or a, a ; $4ee1
	jr nz, Label_1b_4ee8 ; $4ee2
	sound $7f ; $4ee4
	ld c, $02 ; $4ee6
Label_1b_4ee8:
	call Func_00_1d20 ; $4ee8
	call Func_00_1da4 ; $4eeb
	call Func_00_1b38 ; $4eee
	ret ; $4ef1
Func_1b_4ef2:
	xor a, a ; $4ef2
	ldh [$ff8b], a ; $4ef3
	ldh [$ff8a], a ; $4ef5
	ld [$c320], a ; $4ef7
	ld [$c321], a ; $4efa
	ld [$c322], a ; $4efd
	ld [$c323], a ; $4f00
	farcall FarPtr_01_0a ; $4f03
	farcall FarPtr_05_8c ; $4f06
	ld a, $03 ; $4f09
	ldh [$ff96], a ; $4f0b
	ldh [rWBK], a ; $4f0d
	xor a, a ; $4f0f
	ld [$d855], a ; $4f10
	ld [$d858], a ; $4f13
	ld hl, $d803 ; $4f16
	ld bc, $0053 ; $4f19
	call ClearBytes ; $4f1c
	call Func_1b_5c31 ; $4f1f
	call Func_1b_5c3b ; $4f22
	ld a, [$d800] ; $4f25
	or a, a ; $4f28
	jr z, Label_1b_4f3e ; $4f29
	ld c, $2a ; $4f2b
	farcall FarPtr_39_00 ; $4f2d
	ld a, $03 ; $4f30
	ldh [$ff96], a ; $4f32
	ldh [rWBK], a ; $4f34
	call Func_1b_55d1 ; $4f36
	call Func_1b_5829 ; $4f39
	jr Label_1b_4f4f ; $4f3c
Label_1b_4f3e:
	ld c, $29 ; $4f3e
	farcall FarPtr_39_00 ; $4f40
	ld a, $03 ; $4f43
	ldh [$ff96], a ; $4f45
	ldh [rWBK], a ; $4f47
	call Func_1b_5511 ; $4f49
	call Func_1b_5710 ; $4f4c
Label_1b_4f4f:
	call Func_1b_4fa6 ; $4f4f
	ld hl, $4f76 ; $4f52
	ld de, $0806 ; $4f55
	call Func_00_05b0 ; $4f58
	ld a, $01 ; $4f5b
	ld hl, $5a45 ; $4f5d
	call Func_00_1b6a ; $4f60
	ld a, [$d802] ; $4f63
	cp a, $02 ; $4f66
	jr nz, Label_1b_4f72 ; $4f68
	ld a, $01 ; $4f6a
	ld hl, $5a04 ; $4f6c
	call Func_00_1b6a ; $4f6f
Label_1b_4f72:
	farcall FarPtr_39_02 ; $4f72
	ret ; $4f75
	INCBIN "data/bank_01b/d_4f76.bin" ; $4f76, 48 bytes
Func_1b_4fa6:
	ldh a, [$ff96] ; $4fa6
	push af ; $4fa8
	ld a, $01 ; $4fa9
	ldh [$ff96], a ; $4fab
	ldh [rWBK], a ; $4fad
	ld hl, $3f30 ; $4faf -> DataPtr_3f_30
	ld de, $d000 ; $4fb2
	call DecompressDataFromBank ; $4fb5
	ld hl, $d000 ; $4fb8
	ld de, $a000 ; $4fbb
	ld c, $10 ; $4fbe
	call Func_00_0480 ; $4fc0
	ld hl, $3f32 ; $4fc3 -> DataPtr_3f_32
	ld de, $d000 ; $4fc6
	call DecompressDataFromBank ; $4fc9
	ld hl, $d000 ; $4fcc
	ld de, $a100 ; $4fcf
	ld c, $10 ; $4fd2
	call Func_00_0480 ; $4fd4
	ld hl, $3f34 ; $4fd7 -> DataPtr_3f_34
	ld de, $d000 ; $4fda
	call DecompressDataFromBank ; $4fdd
	ld hl, $d000 ; $4fe0
	ld de, $a200 ; $4fe3
	ld c, $10 ; $4fe6
	call Func_00_0480 ; $4fe8
	pop af ; $4feb
	ldh [$ff96], a ; $4fec
	ldh [rWBK], a ; $4fee
	ret ; $4ff0
Func_1b_4ff1:
	ld a, [$d85a] ; $4ff1
	or a, a ; $4ff4
	ret nz ; $4ff5
	ld a, [$d802] ; $4ff6
	cp a, $02 ; $4ff9
	ret z ; $4ffb
	ld a, [$d800] ; $4ffc
	or a, a ; $4fff
	jr nz, Label_1b_5028 ; $5000
	ld a, [$d802] ; $5002
	or a, a ; $5005
	jr nz, Label_1b_5018 ; $5006
	ld a, [$d801] ; $5008
	add a, a ; $500b
	ld hl, $5059 ; $500c
	add a, l ; $500f
	ld l, a ; $5010
	jr nc, Label_1b_5014 ; $5011
	inc h ; $5013
Label_1b_5014:
	ld a, [hl+] ; $5014
	ld h, [hl] ; $5015
	ld l, a ; $5016
	jp hl ; $5017
Label_1b_5018:
	ld a, [$d801] ; $5018
	add a, a ; $501b
	ld hl, $504f ; $501c
	add a, l ; $501f
	ld l, a ; $5020
	jr nc, Label_1b_5024 ; $5021
	inc h ; $5023
Label_1b_5024:
	ld a, [hl+] ; $5024
	ld h, [hl] ; $5025
	ld l, a ; $5026
	jp hl ; $5027
Label_1b_5028:
	ld a, [$d802] ; $5028
	or a, a ; $502b
	jr nz, Label_1b_503e ; $502c
	ld a, [$d801] ; $502e
	add a, a ; $5031
	ld hl, $506d ; $5032
	add a, l ; $5035
	ld l, a ; $5036
	jr nc, Label_1b_503a ; $5037
	inc h ; $5039
Label_1b_503a:
	ld a, [hl+] ; $503a
	ld h, [hl] ; $503b
	ld l, a ; $503c
	jp hl ; $503d
Label_1b_503e:
	ld a, [$d801] ; $503e
	add a, a ; $5041
	ld hl, $5063 ; $5042
	add a, l ; $5045
	ld l, a ; $5046
	jr nc, Label_1b_504a ; $5047
	inc h ; $5049
Label_1b_504a:
	ld a, [hl+] ; $504a
	ld h, [hl] ; $504b
	ld l, a ; $504c
	jp hl ; $504d
	INCBIN "data/bank_01b/d_504e.bin" ; $504e, 1219 bytes
Func_1b_5511:
	call Func_1b_569c ; $5511
	ld a, $03 ; $5514
	ldh [$ff96], a ; $5516
	ldh [rWBK], a ; $5518
	call Func_1b_558e ; $551a
	ld hl, $c900 ; $551d
	ld de, $d021 ; $5520
	call Func_1b_56b3 ; $5523
	ld b, $01 ; $5526
Label_1b_5528:
	call Func_1b_5536 ; $5528
	ld a, b ; $552b
	inc a ; $552c
	ld b, a ; $552d
	cp a, $0c ; $552e
	jr nz, Label_1b_5528 ; $5530
	farcall FarPtr_05_90 ; $5532
	ret ; $5535
Func_1b_5536:
	push af ; $5536
	push bc ; $5537
	push de ; $5538
	push hl ; $5539
	ld a, b ; $553a
	add a, a ; $553b
	ld hl, $5576 ; $553c
	add a, l ; $553f
	ld l, a ; $5540
	jr nc, Label_1b_5544 ; $5541
	inc h ; $5543
Label_1b_5544:
	ld a, [hl+] ; $5544
	ld d, [hl] ; $5545
	ld e, a ; $5546
	ld a, b ; $5547
	add a, a ; $5548
	ld hl, $555e ; $5549
	add a, l ; $554c
	ld l, a ; $554d
	jr nc, Label_1b_5551 ; $554e
	inc h ; $5550
Label_1b_5551:
	ld a, [hl+] ; $5551
	ld h, [hl] ; $5552
	ld l, a ; $5553
	ld c, $05 ; $5554
	farcall FarPtr_05_1c ; $5556
	pop hl ; $5559
	pop de ; $555a
	pop bc ; $555b
	pop af ; $555c
	ret ; $555d
	INCBIN "data/bank_01b/d_555e.bin" ; $555e, 48 bytes
Func_1b_558e:
	push af ; $558e
	push bc ; $558f
	push de ; $5590
	push hl ; $5591
	ld b, $00 ; $5592
	ld de, $d401 ; $5594
Label_1b_5597:
	push bc ; $5597
	ld h, $00 ; $5598
	ld b, $05 ; $559a
	ld c, $02 ; $559c
	farcall FarPtr_39_0c ; $559e
	ld hl, $0060 ; $55a1
	add hl, de ; $55a4
	ld d, h ; $55a5
	ld e, l ; $55a6
	pop bc ; $55a7
	ld a, b ; $55a8
	inc a ; $55a9
	ld b, a ; $55aa
	cp a, $06 ; $55ab
	jr nz, Label_1b_5597 ; $55ad
	ld de, $d40e ; $55af
	ld b, $00 ; $55b2
Label_1b_55b4:
	push bc ; $55b4
	ld h, $01 ; $55b5
	ld b, $05 ; $55b7
	ld c, $02 ; $55b9
	farcall FarPtr_39_0c ; $55bb
	ld hl, $0060 ; $55be
	add hl, de ; $55c1
	ld d, h ; $55c2
	ld e, l ; $55c3
	pop bc ; $55c4
	ld a, b ; $55c5
	inc a ; $55c6
	ld b, a ; $55c7
	cp a, $06 ; $55c8
	jr nz, Label_1b_55b4 ; $55ca
	pop hl ; $55cc
	pop de ; $55cd
	pop bc ; $55ce
	pop af ; $55cf
	ret ; $55d0
Func_1b_55d1:
	call Func_1b_569c ; $55d1
	ld a, $03 ; $55d4
	ldh [$ff96], a ; $55d6
	ldh [rWBK], a ; $55d8
	call Func_1b_5659 ; $55da
	ld hl, $c900 ; $55dd
	ld de, $d041 ; $55e0
	call Func_1b_56b3 ; $55e3
	ld hl, $c940 ; $55e6
	ld de, $d081 ; $55e9
	call Func_1b_56b3 ; $55ec
	ld b, $02 ; $55ef
Label_1b_55f1:
	call Func_1b_55ff ; $55f1
	ld a, b ; $55f4
	inc a ; $55f5
	ld b, a ; $55f6
	cp a, $0c ; $55f7
	jr nz, Label_1b_55f1 ; $55f9
	farcall FarPtr_05_90 ; $55fb
	ret ; $55fe
Func_1b_55ff:
	push af ; $55ff
	push bc ; $5600
	push de ; $5601
	push hl ; $5602
	ld a, b ; $5603
	add a, a ; $5604
	ld hl, $5641 ; $5605
	add a, l ; $5608
	ld l, a ; $5609
	jr nc, Label_1b_560d ; $560a
	inc h ; $560c
Label_1b_560d:
	ld a, [hl+] ; $560d
	ld d, [hl] ; $560e
	ld e, a ; $560f
	ld a, b ; $5610
	add a, a ; $5611
	ld hl, $5627 ; $5612
	add a, l ; $5615
	ld l, a ; $5616
	jr nc, Label_1b_561a ; $5617
	inc h ; $5619
Label_1b_561a:
	ld a, [hl+] ; $561a
	ld h, [hl] ; $561b
	ld l, a ; $561c
	ld c, $05 ; $561d
	farcall FarPtr_05_1c ; $561f
	pop hl ; $5622
	pop de ; $5623
	pop bc ; $5624
	pop af ; $5625
	ret ; $5626
	INCBIN "data/bank_01b/d_5627.bin" ; $5627, 50 bytes
Func_1b_5659:
	push af ; $5659
	push bc ; $565a
	push de ; $565b
	push hl ; $565c
	ld b, $00 ; $565d
	ld de, $d421 ; $565f
Label_1b_5662:
	push bc ; $5662
	ld h, $00 ; $5663
	ld b, $05 ; $5665
	ld c, $04 ; $5667
	farcall FarPtr_39_0c ; $5669
	ld hl, $00a0 ; $566c
	add hl, de ; $566f
	ld d, h ; $5670
	ld e, l ; $5671
	pop bc ; $5672
	ld a, b ; $5673
	inc a ; $5674
	ld b, a ; $5675
	cp a, $03 ; $5676
	jr nz, Label_1b_5662 ; $5678
	ld de, $d42e ; $567a
	ld b, $00 ; $567d
Label_1b_567f:
	push bc ; $567f
	ld h, $01 ; $5680
	ld b, $05 ; $5682
	ld c, $04 ; $5684
	farcall FarPtr_39_0c ; $5686
	ld hl, $00a0 ; $5689
	add hl, de ; $568c
	ld d, h ; $568d
	ld e, l ; $568e
	pop bc ; $568f
	ld a, b ; $5690
	inc a ; $5691
	ld b, a ; $5692
	cp a, $03 ; $5693
	jr nz, Label_1b_567f ; $5695
	pop hl ; $5697
	pop de ; $5698
	pop bc ; $5699
	pop af ; $569a
	ret ; $569b
Func_1b_569c:
	farcall FarPtr_05_00 ; $569c
	ld a, $05 ; $569f
	ldh [$ff96], a ; $56a1
	ldh [rWBK], a ; $56a3
	ld a, $03 ; $56a5
	ld [$c3b3], a ; $56a7
	ld a, $00 ; $56aa
	ld [$c3b6], a ; $56ac
	farcall FarPtr_05_8c ; $56af
	ret ; $56b2
Func_1b_56b3:
	call Func_1b_56c2 ; $56b3
	cp a, $06 ; $56b6
	jr nc, Label_1b_56be ; $56b8
	call Func_1b_4434 ; $56ba
	ret ; $56bd
Label_1b_56be:
	call Func_1b_56cf ; $56be
	ret ; $56c1
Func_1b_56c2:
	push hl ; $56c2
	push bc ; $56c3
	ld c, $ff ; $56c4
Label_1b_56c6:
	inc c ; $56c6
	ld a, [hl+] ; $56c7
	or a, a ; $56c8
	jr nz, Label_1b_56c6 ; $56c9
	ld a, c ; $56cb
	pop bc ; $56cc
	pop hl ; $56cd
	ret ; $56ce
Func_1b_56cf:
	push hl ; $56cf
	push de ; $56d0
	push hl ; $56d1
	ld hl, $ffe0 ; $56d2
	add hl, de ; $56d5
	ld d, h ; $56d6
	ld e, l ; $56d7
	pop hl ; $56d8
	call Func_1b_56e2 ; $56d9
	pop de ; $56dc
	pop hl ; $56dd
	call Func_1b_56fa ; $56de
	ret ; $56e1
Func_1b_56e2:
	push de ; $56e2
	ld de, $d860 ; $56e3
	ld bc, $0004 ; $56e6
	call CopyMemoryBC ; $56e9
	ld a, $2d ; $56ec
	ld [de], a ; $56ee
	inc de ; $56ef
	xor a, a ; $56f0
	ld [de], a ; $56f1
	pop de ; $56f2
	ld hl, $d860 ; $56f3
	call Func_1b_4434 ; $56f6
	ret ; $56f9
Func_1b_56fa:
	push de ; $56fa
	ld bc, $0004 ; $56fb
	add hl, bc ; $56fe
	ld de, $d860 ; $56ff
	ld bc, $0007 ; $5702
	call CopyMemoryBC ; $5705
	pop de ; $5708
	ld hl, $d860 ; $5709
	call Func_1b_4434 ; $570c
	ret ; $570f
Func_1b_5710:
	ld a, [$d801] ; $5710
	or a, a ; $5713
	ret z ; $5714
	cp a, $01 ; $5715
	ret z ; $5717
	cp a, $02 ; $5718
	jr nz, Label_1b_5731 ; $571a
	ld b, $01 ; $571c
	call Func_1b_5750 ; $571e
	ld b, $02 ; $5721
	call Func_1b_5750 ; $5723
	ld b, $03 ; $5726
	call Func_1b_5750 ; $5728
	ld b, $04 ; $572b
	call Func_1b_5750 ; $572d
	ret ; $5730
Label_1b_5731:
	cp a, $03 ; $5731
	jr nz, Label_1b_574a ; $5733
	ld b, $05 ; $5735
	call Func_1b_5750 ; $5737
	ld b, $06 ; $573a
	call Func_1b_5750 ; $573c
	ld b, $07 ; $573f
	call Func_1b_5750 ; $5741
	ld b, $08 ; $5744
	call Func_1b_5750 ; $5746
	ret ; $5749
Label_1b_574a:
	ld b, $0b ; $574a
	call Func_1b_5750 ; $574c
	ret ; $574f
Func_1b_5750:
	ld a, b ; $5750
	or a, a ; $5751
	ret z ; $5752
	add a, a ; $5753
	ld hl, $5761 ; $5754
	add a, l ; $5757
	ld l, a ; $5758
	jr nc, Label_1b_575c ; $5759
	inc h ; $575b
Label_1b_575c:
	ld a, [hl+] ; $575c
	ld h, [hl] ; $575d
	ld l, a ; $575e
	jp hl ; $575f
	INCBIN "data/bank_01b/d_5760.bin" ; $5760, 201 bytes
Func_1b_5829:
	ld a, [$d801] ; $5829
	or a, a ; $582c
	ret z ; $582d
	cp a, $01 ; $582e
	ret z ; $5830
	cp a, $02 ; $5831
	jr nz, Label_1b_5840 ; $5833
	ld b, $01 ; $5835
	call Func_1b_5846 ; $5837
	ld b, $02 ; $583a
	call Func_1b_5846 ; $583c
	ret ; $583f
Label_1b_5840:
	ld b, $05 ; $5840
	call Func_1b_5846 ; $5842
	ret ; $5845
Func_1b_5846:
	ld a, b ; $5846
	or a, a ; $5847
	ret z ; $5848
	add a, a ; $5849
	ld hl, $5857 ; $584a
	add a, l ; $584d
	ld l, a ; $584e
	jr nc, Label_1b_5852 ; $584f
	inc h ; $5851
Label_1b_5852:
	ld a, [hl+] ; $5852
	ld h, [hl] ; $5853
	ld l, a ; $5854
	jp hl ; $5855
	INCBIN "data/bank_01b/d_5856.bin" ; $5856, 987 bytes
Func_1b_5c31:
	ld hl, $d803 ; $5c31
	ld bc, $0030 ; $5c34
	call ClearBytes ; $5c37
	ret ; $5c3a
Func_1b_5c3b:
	ld a, [$d800] ; $5c3b
	or a, a ; $5c3e
	jr nz, Label_1b_5c67 ; $5c3f
	ld hl, $5c8d ; $5c41
	ld a, [$d802] ; $5c44
	or a, a ; $5c47
	jr z, Label_1b_5c4d ; $5c48
	ld hl, $5d57 ; $5c4a
Label_1b_5c4d:
	ld a, [$d801] ; $5c4d
	add a, a ; $5c50
	add a, l ; $5c51
	ld l, a ; $5c52
	jr nc, Label_1b_5c56 ; $5c53
	inc h ; $5c55
Label_1b_5c56:
	ld a, [hl+] ; $5c56
	ld h, [hl] ; $5c57
	ld l, a ; $5c58
	push hl ; $5c59
	call Func_1b_5f51 ; $5c5a
	ld d, h ; $5c5d
	ld e, l ; $5c5e
	pop hl ; $5c5f
	ld bc, $0030 ; $5c60
	call CopyMemoryBC ; $5c63
	ret ; $5c66
Label_1b_5c67:
	ld hl, $5e21 ; $5c67
	ld a, [$d802] ; $5c6a
	or a, a ; $5c6d
	jr z, Label_1b_5c73 ; $5c6e
	ld hl, $5eb9 ; $5c70
Label_1b_5c73:
	ld a, [$d801] ; $5c73
	add a, a ; $5c76
	add a, l ; $5c77
	ld l, a ; $5c78
	jr nc, Label_1b_5c7c ; $5c79
	inc h ; $5c7b
Label_1b_5c7c:
	ld a, [hl+] ; $5c7c
	ld h, [hl] ; $5c7d
	ld l, a ; $5c7e
	push hl ; $5c7f
	call Func_1b_5f51 ; $5c80
	ld d, h ; $5c83
	ld e, l ; $5c84
	pop hl ; $5c85
	ld bc, $0030 ; $5c86
	call CopyMemoryBC ; $5c89
	ret ; $5c8c
	INCBIN "data/bank_01b/d_5c8d.bin" ; $5c8d, 708 bytes
Func_1b_5f51:
	push af ; $5f51
	ld a, c ; $5f52
	add a, a ; $5f53
	add a, a ; $5f54
	ld hl, $d803 ; $5f55
	add a, l ; $5f58
	ld l, a ; $5f59
	jr nc, Label_1b_5f5d ; $5f5a
	inc h ; $5f5c
Label_1b_5f5d:
	pop af ; $5f5d
	ret ; $5f5e
	INCBIN "data/bank_01b/d_5f5f.bin" ; $5f5f, 531 bytes
Func_1b_6172:
	ld a, [$c781] ; $6172
	ld [$c782], a ; $6175
	ld a, [$c784] ; $6178
	add a, a ; $617b
	add a, a ; $617c
	add a, a ; $617d
	ld hl, $c783 ; $617e
	add a, [hl] ; $6181
	add a, $a0 ; $6182
	ld l, a ; $6184
	adc a, $c7 ; $6185
	sub a, l ; $6187
	ld h, a ; $6188
	ld a, [hl] ; $6189
	cp a, $ff ; $618a
Label_1b_618c:
	jr z, Label_1b_618c ; $618c
	ld [$c781], a ; $618e
	ret ; $6191
	INCBIN "data/bank_01b/d_6192.bin" ; $6192, 40 bytes
Func_1b_61ba:
	sound $03 ; $61ba
	farcall FarPtr_02_02 ; $61bc
	ld a, $00 ; $61bf
	farcall FarPtr_02_14 ; $61c1
	ld a, $01 ; $61c4
	ldh [$ff96], a ; $61c6
	ldh [rWBK], a ; $61c8
	ld a, $01 ; $61ca
	ld [$c7be], a ; $61cc
	ld a, $01 ; $61cf
	ld [$c7bf], a ; $61d1
	ld hl, $c7c0 ; $61d4
	xor a, a ; $61d7
Label_1b_61d8:
	push af ; $61d8
	farcall FarPtr_18_24 ; $61d9
	ld a, [$d58e] ; $61dc
	ld [hl+], a ; $61df
	ld a, [$d58c] ; $61e0
	ld [hl+], a ; $61e3
	pop af ; $61e4
	inc a ; $61e5
	cp a, $04 ; $61e6
	jr nz, Label_1b_61d8 ; $61e8
	ld a, [$cb00] ; $61ea
	push af ; $61ed
	xor a, a ; $61ee
	ld [$cb00], a ; $61ef
Label_1b_61f2:
	ld a, [$c7be] ; $61f2
	ld d, a ; $61f5
	ld a, [$c7bf] ; $61f6
	ld e, a ; $61f9
	ld b, $00 ; $61fa
	farcall FarPtr_38_00 ; $61fc
	ld hl, $c7be ; $61ff
	ld [hl], d ; $6202
	ld hl, $c7bf ; $6203
	ld [hl], e ; $6206
	cp a, $ff ; $6207
	jr nz, Label_1b_6214 ; $6209
	pop af ; $620b
	ld [$cb00], a ; $620c
	ld a, $ff ; $620f
	jp Label_1b_62ef ; $6211
Label_1b_6214:
	cp a, $fe ; $6214
	jr nz, Label_1b_621a ; $6216
	jr Label_1b_61f2 ; $6218
Label_1b_621a:
	ld a, $01 ; $621a
	farcall FarPtr_02_14 ; $621c
	ld a, $00 ; $621f
	farcall FarPtr_1d_02 ; $6221
	and a, a ; $6224
	jr nz, Label_1b_61f2 ; $6225
	ld a, $02 ; $6227
	farcall FarPtr_02_14 ; $6229
Label_1b_622c:
	xor a, a ; $622c
	ld [$cb00], a ; $622d
	push af ; $6230
	ld hl, $c900 ; $6231
	ld a, [$cb00] ; $6234
	or a, a ; $6237
	jr z, Label_1b_623c ; $6238
	ld l, $40 ; $623a
Label_1b_623c:
	ld a, l ; $623c
	add a, $0b ; $623d
	ld l, a ; $623f
	ld a, h ; $6240
	adc a, $00 ; $6241
	ld h, a ; $6243
	pop af ; $6244
	ld c, [hl] ; $6245
	ld b, $00 ; $6246
	farcall FarPtr_38_06 ; $6248
	and a, a ; $624b
	jr nz, Label_1b_621a ; $624c
	pop af ; $624e
	ld [$cb00], a ; $624f
	ld a, [$cb00] ; $6252
	push af ; $6255
	ld a, $01 ; $6256
	ld [$cb00], a ; $6258
	ld de, $0120 ; $625b
	farcall FarPtr_03_1c ; $625e
	jr nz, Label_1b_6293 ; $6261
	push af ; $6263
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $6264
	inc a ; $6267
	inc a ; $6268
	ld d, a ; $6269
	ld a, [$cb00] ; $626a
	farcall FarPtr_02_06 ; $626d
	push af ; $6270
	ld hl, $c900 ; $6271
	ld a, [$cb00] ; $6274
	or a, a ; $6277
	jr z, Label_1b_627c ; $6278
	ld l, $40 ; $627a
Label_1b_627c:
	ld a, l ; $627c
	add a, $0b ; $627d
	ld l, a ; $627f
	ld a, h ; $6280
	adc a, $00 ; $6281
	ld h, a ; $6283
	pop af ; $6284
	ld c, [hl] ; $6285
	ld b, $01 ; $6286
	farcall FarPtr_38_06 ; $6288
	ld b, a ; $628b
	pop af ; $628c
	ld a, b ; $628d
	and a, a ; $628e
	jr nz, Label_1b_622c ; $628f
	jr Label_1b_62df ; $6291
Label_1b_6293:
	ld a, [$c7be] ; $6293
	ld d, a ; $6296
	ld a, [$c7bf] ; $6297
	ld e, a ; $629a
	ld b, $01 ; $629b
	farcall FarPtr_38_00 ; $629d
	ld hl, $c7be ; $62a0
	ld [hl], d ; $62a3
	ld hl, $c7bf ; $62a4
	ld [hl], e ; $62a7
	cp a, $ff ; $62a8
	jr nz, Label_1b_62b3 ; $62aa
	pop af ; $62ac
	ld [$cb00], a ; $62ad
	jp Func_1b_61ba ; $62b0
Label_1b_62b3:
	cp a, $fe ; $62b3
	jr nz, Label_1b_62b9 ; $62b5
	jr Label_1b_6293 ; $62b7
Label_1b_62b9:
	ld a, $01 ; $62b9
	farcall FarPtr_1d_02 ; $62bb
	and a, a ; $62be
	jr nz, Label_1b_6293 ; $62bf
	push af ; $62c1
	ld hl, $c900 ; $62c2
	ld a, [$cb00] ; $62c5
	or a, a ; $62c8
	jr z, Label_1b_62cd ; $62c9
	ld l, $40 ; $62cb
Label_1b_62cd:
	ld a, l ; $62cd
	add a, $0b ; $62ce
	ld l, a ; $62d0
	ld a, h ; $62d1
	adc a, $00 ; $62d2
	ld h, a ; $62d4
	pop af ; $62d5
	ld c, [hl] ; $62d6
	ld b, $01 ; $62d7
	farcall FarPtr_38_06 ; $62d9
	and a, a ; $62dc
	jr nz, Label_1b_62b9 ; $62dd
Label_1b_62df:
	pop af ; $62df
	ld [$cb00], a ; $62e0
	ld hl, $c900 ; $62e3
	ld de, $c800 ; $62e6
	ld c, $08 ; $62e9
	call CopyMemoryFast ; $62eb
	xor a, a ; $62ee
Label_1b_62ef:
	ld c, $20 ; $62ef
	call Func_00_1d20 ; $62f1
	call Func_00_1da4 ; $62f4
	ret ; $62f7
Func_1b_62f8:
	sound $03 ; $62f8
	ld a, $01 ; $62fa
	cp a, $ff ; $62fc
	jr z, Func_1b_62f8 ; $62fe
	or a, a ; $6300
	jr z, Label_1b_632d ; $6301
	bit 7, a ; $6303
	jr z, Func_1b_62f8 ; $6305
	and a, $3f ; $6307
	ld [$c36c], a ; $6309
	ld hl, $c800 ; $630c
	ld b, a ; $630f
	ld [$c36c], a ; $6310
	farcall FarPtr_03_1a ; $6313
	or a, a ; $6316
	jp z, Label_1b_6399 ; $6317
	call Func_1b_61ba ; $631a
	cp a, $ff ; $631d
	jp z, Func_1b_62f8 ; $631f
	ld a, $01 ; $6322
	farcall FarPtr_03_16 ; $6324
	farcall FarPtr_03_18 ; $6327
	jp Label_1b_6408 ; $632a
Label_1b_632d:
	sound $03 ; $632d
	call Func_1b_64b9 ; $632f
	cp a, $ff ; $6332
	jr z, Func_1b_62f8 ; $6334
	cp a, $01 ; $6336
	jp z, Label_1b_638e ; $6338
	cp a, $ff ; $633b
	jr z, Label_1b_632d ; $633d
	or a, a ; $633f
	jr nz, Label_1b_634c ; $6340
	or a, a ; $6342
	jr nz, Label_1b_632d ; $6343
	farcall FarPtr_03_14 ; $6345
	ld b, $01 ; $6348
	jr Label_1b_632d ; $634a
Label_1b_634c:
	and a, $3f ; $634c
	ld b, a ; $634e
	ld hl, $ca00 ; $634f
	ld [$c36c], a ; $6352
	farcall FarPtr_03_1a ; $6355
	or a, a ; $6358
	jr z, Label_1b_635f ; $6359
	sound $62 ; $635b
	jr Label_1b_632d ; $635d
Label_1b_635f:
	push bc ; $635f
	call Func_1b_69d6 ; $6360
	pop bc ; $6363
	or a, a ; $6364
	jr nz, Label_1b_632d ; $6365
	ld a, $03 ; $6367
	ldh [$ff96], a ; $6369
	ldh [rWBK], a ; $636b
	ld hl, $ca00 ; $636d
	ld de, $d500 ; $6370
	ld c, $0b ; $6373
Label_1b_6375:
	ld a, [hl+] ; $6375
	push hl ; $6376
	ld h, d ; $6377
	ld l, e ; $6378
	ld [hl+], a ; $6379
	ld d, h ; $637a
	ld e, l ; $637b
	pop hl ; $637c
	dec c ; $637d
	jr nz, Label_1b_6375 ; $637e
	ld a, b ; $6380
	ld [$c36c], a ; $6381
	ld a, $00 ; $6384
	farcall FarPtr_03_16 ; $6386
	ld b, $01 ; $6389
	jp Label_1b_632d ; $638b
Label_1b_638e:
	ld a, $00 ; $638e
	ld [$cb1f], a ; $6390
	farcall FarPtr_1b_26 ; $6393
	jp Label_1b_632d ; $6396
Label_1b_6399:
	call Func_00_1b38 ; $6399
	farcall FarPtr_02_04 ; $639c
	or a, a ; $639f
	jr z, Label_1b_6405 ; $63a0
	ld hl, $c9b0 ; $63a2
	ld a, [hl+] ; $63a5
	ld d, [hl] ; $63a6
	ld e, a ; $63a7
	or a, d ; $63a8
	jr z, Label_1b_63cb ; $63a9
	ldh a, [$ff96] ; $63ab
	push af ; $63ad
	ld a, $06 ; $63ae
	ldh [$ff96], a ; $63b0
	ldh [rWBK], a ; $63b2
	xor a, a ; $63b4
	ld [$d000], a ; $63b5
	pop af ; $63b8
	ldh [$ff96], a ; $63b9
	ldh [rWBK], a ; $63bb
	ld h, $01 ; $63bd
	ld l, $00 ; $63bf
	ld a, $01 ; $63c1
	farcall FarPtr_1a_0a ; $63c3
	ld c, $00 ; $63c6
	farcall FarPtr_1c_00 ; $63c8
Label_1b_63cb:
	ld hl, $c9b2 ; $63cb
	ld a, [hl+] ; $63ce
	ld d, [hl] ; $63cf
	ld e, a ; $63d0
	or a, d ; $63d1
	jr z, Label_1b_63f4 ; $63d2
	ldh a, [$ff96] ; $63d4
	push af ; $63d6
	ld a, $06 ; $63d7
	ldh [$ff96], a ; $63d9
	ldh [rWBK], a ; $63db
	xor a, a ; $63dd
	ld [$d000], a ; $63de
	pop af ; $63e1
	ldh [$ff96], a ; $63e2
	ldh [rWBK], a ; $63e4
	ld h, $01 ; $63e6
	ld l, $01 ; $63e8
	ld a, $01 ; $63ea
	farcall FarPtr_1a_0a ; $63ec
	ld c, $01 ; $63ef
	farcall FarPtr_1c_00 ; $63f1
Label_1b_63f4:
	xor a, a ; $63f4
	ld hl, $c9b0 ; $63f5
	ld [hl+], a ; $63f8
	ld [hl+], a ; $63f9
	ld [hl+], a ; $63fa
	ld [hl+], a ; $63fb
	ld [hl+], a ; $63fc
	inc hl ; $63fd
	inc hl ; $63fe
	ld [hl+], a ; $63ff
	farcall FarPtr_03_18 ; $6400
	jr Label_1b_6408 ; $6403
Label_1b_6405:
	farcall FarPtr_1b_20 ; $6405
Label_1b_6408:
	call Func_1b_6467 ; $6408
	cp a, $ff ; $640b
	jp z, Func_1b_62f8 ; $640d
	cp a, $01 ; $6410
	jr z, Label_1b_645a ; $6412
	cp a, $02 ; $6414
	jr z, Label_1b_6460 ; $6416
	push af ; $6418
	push bc ; $6419
	push de ; $641a
	push hl ; $641b
	farcall FarPtr_1d_08 ; $641c
	ld b, $00 ; $641f
	ld c, $00 ; $6421
	ld de, $0040 ; $6423
	farcall FarPtr_1d_0a ; $6426
	ld b, $04 ; $6429
	ld c, $01 ; $642b
	ld de, $0077 ; $642d
	farcall FarPtr_1d_0a ; $6430
	ld c, $01 ; $6433
	farcall FarPtr_1e_00 ; $6435
	farcall FarPtr_1d_06 ; $6438
	pop hl ; $643b
	pop de ; $643c
	pop bc ; $643d
	pop af ; $643e
	set_flag $03, 4 ; $643f
	ld c, $00 ; $6442
	farcall FarPtr_1c_00 ; $6444
	clear_flag $03, 4 ; $6447
	set_flag $03, 4 ; $644a
	ld c, $01 ; $644d
	farcall FarPtr_1c_00 ; $644f
	clear_flag $03, 4 ; $6452
	farcall FarPtr_03_18 ; $6455
	jr Label_1b_6408 ; $6458
Label_1b_645a:
	farcall FarPtr_1d_00 ; $645a
	jp Label_1b_6408 ; $645d
Label_1b_6460:
	call Func_1b_6b6f ; $6460
	jp Label_1b_6408 ; $6463
	INCBIN "data/bank_01b/d_6466.bin" ; $6466, 1 bytes
Func_1b_6467:
	push bc ; $6467
	push de ; $6468
	push hl ; $6469
	ldh a, [$ff96] ; $646a
	push af ; $646c
	call Func_00_1b38 ; $646d
	call DisableLCDSafely ; $6470
	farcall FarPtr_01_0a ; $6473
	call DisableLCDSafely ; $6476
	farcall FarPtr_05_76 ; $6479
	call Func_1b_651e ; $647c
	ld a, $05 ; $647f
	ldh [$ff96], a ; $6481
	ldh [rWBK], a ; $6483
	ld d, $02 ; $6485
	ld e, $02 ; $6487
	ld hl, $047c ; $6489
	farcall FarPtr_05_08 ; $648c
	farcall FarPtr_05_18 ; $648f
	farcall FarPtr_05_80 ; $6492
	ld c, $20 ; $6495
	call Func_00_1d2e ; $6497
	call Func_00_1da4 ; $649a
	farcall FarPtr_05_3c ; $649d
	ld b, a ; $64a0
	ld c, $20 ; $64a1
	call Func_00_1d20 ; $64a3
	call Func_00_1da4 ; $64a6
	ld a, [$d82f] ; $64a9
	farcall FarPtr_05_7a ; $64ac
	pop af ; $64af
	ldh [$ff96], a ; $64b0
	ldh [rWBK], a ; $64b2
	ld a, b ; $64b4
	pop hl ; $64b5
	pop de ; $64b6
	pop bc ; $64b7
	ret ; $64b8
Func_1b_64b9:
	push bc ; $64b9
	push de ; $64ba
	push hl ; $64bb
	ldh a, [$ff96] ; $64bc
	push af ; $64be
	call Func_00_1b38 ; $64bf
	call DisableLCDSafely ; $64c2
	farcall FarPtr_01_0a ; $64c5
	call EnableLCD ; $64c8
	farcall FarPtr_05_76 ; $64cb
	call Func_1b_651e ; $64ce
	call Func_1b_686f ; $64d1
	ld a, $06 ; $64d4
	ldh [$ff96], a ; $64d6
	ldh [rWBK], a ; $64d8
	ld hl, $d400 ; $64da
	ld a, [hl+] ; $64dd
	ld d, [hl] ; $64de
	ld e, a ; $64df
	ld hl, $047d ; $64e0
	or a, d ; $64e3
	jr nz, Label_1b_64e7 ; $64e4
	inc hl ; $64e6
Label_1b_64e7:
	ld a, $05 ; $64e7
	ldh [$ff96], a ; $64e9
	ldh [rWBK], a ; $64eb
	ld d, $02 ; $64ed
	ld e, $02 ; $64ef
	farcall FarPtr_05_08 ; $64f1
	farcall FarPtr_05_18 ; $64f4
	farcall FarPtr_05_80 ; $64f7
	ld c, $20 ; $64fa
	call Func_00_1d2e ; $64fc
	call Func_00_1da4 ; $64ff
	farcall FarPtr_05_3c ; $6502
	ld b, a ; $6505
	ld c, $20 ; $6506
	call Func_00_1d20 ; $6508
	call Func_00_1da4 ; $650b
	ld a, [$d82f] ; $650e
	farcall FarPtr_05_7a ; $6511
	pop af ; $6514
	ldh [$ff96], a ; $6515
	ldh [rWBK], a ; $6517
	ld a, b ; $6519
	pop hl ; $651a
	pop de ; $651b
	pop bc ; $651c
	ret ; $651d
Func_1b_651e:
	call DisableLCDSafely ; $651e
	ld a, $02 ; $6521
	ldh [$ff96], a ; $6523
	ldh [rWBK], a ; $6525
	ld a, $00 ; $6527
	ld hl, $d000 ; $6529
	ld bc, $0500 ; $652c
	call Func_1b_6569 ; $652f
	ld a, $03 ; $6532
	ldh [$ff96], a ; $6534
	ldh [rWBK], a ; $6536
	ld a, $20 ; $6538
	ld hl, $d000 ; $653a
	ld bc, $0500 ; $653d
	call Func_1b_6569 ; $6540
	ld a, $03 ; $6543
	ldh [$ff96], a ; $6545
	ldh [rWBK], a ; $6547
	ld hl, $d000 ; $6549
	ld de, $9800 ; $654c
	ld c, $24 ; $654f
	call Func_00_0480 ; $6551
	ld a, $02 ; $6554
	ldh [$ff96], a ; $6556
	ldh [rWBK], a ; $6558
	ld hl, $d000 ; $655a
	ld de, $b800 ; $655d
	ld c, $24 ; $6560
	call Func_00_0480 ; $6562
	call EnableLCD ; $6565
	ret ; $6568
Func_1b_6569:
	ld e, a ; $6569
Label_1b_656a:
	ld [hl], e ; $656a
	inc hl ; $656b
	dec bc ; $656c
	ld a, c ; $656d
	or a, b ; $656e
	jr nz, Label_1b_656a ; $656f
	ret ; $6571
	INCBIN "data/bank_01b/d_6572.bin" ; $6572, 120 bytes
Func_1b_65ea:
	ld hl, $ce40 ; $65ea
	farcall FarPtr_18_1c ; $65ed
	ret ; $65f0
Func_1b_65f1:
	push hl ; $65f1
	call Func_1b_65ea ; $65f2
	ld a, [hl+] ; $65f5
	ld d, [hl] ; $65f6
	ld e, a ; $65f7
	pop hl ; $65f8
	ret ; $65f9
Func_1b_65fa:
	ld hl, $6572 ; $65fa
	ld de, $c7a0 ; $65fd
	ld bc, $0020 ; $6600
	call CopyMemoryBC ; $6603
	ret ; $6606
	INCBIN "data/bank_01b/d_6607.bin" ; $6607, 2 bytes
Func_1b_6609:
	ld hl, $6592 ; $6609
	ld de, $ce40 ; $660c
	ld bc, $0080 ; $660f
	call CopyMemoryBC ; $6612
	ret ; $6615
	INCBIN "data/bank_01b/d_6616.bin" ; $6616, 2 bytes
Func_1b_6618:
	ld hl, $d000 ; $6618
	ld de, $b000 ; $661b
	ld c, $80 ; $661e
	call Func_00_0480 ; $6620
	ld hl, $d800 ; $6623
	ld de, $a800 ; $6626
	ld c, $80 ; $6629
	call Func_00_0480 ; $662b
	ld hl, $6572 ; $662e
	ld de, $dc00 ; $6631
	call DecompressData ; $6634
	ld hl, $6572 ; $6637
	ld de, $d800 ; $663a
	call DecompressData ; $663d
	ld hl, $6572 ; $6640
	ld de, $0008 ; $6643
	call Func_00_05b0 ; $6646
	ret ; $6649
Func_1b_664a:
	ret ; $664a
	INCBIN "data/bank_01b/d_664b.bin" ; $664b, 54 bytes
Func_1b_6681:
	farcall FarPtr_18_20 ; $6681
	ld a, $0a ; $6684
	ld hl, $668d ; $6686
	call Func_00_1b6a ; $6689
	ret ; $668c
	INCBIN "data/bank_01b/d_668d.bin" ; $668d, 16 bytes
Func_1b_669d:
	ld a, [$c781] ; $669d
	push af ; $66a0
	ld de, $0006 ; $66a1
	call Func_1b_65f1 ; $66a4
	pop af ; $66a7
	ld b, a ; $66a8
	push bc ; $66a9
	farcall FarPtr_18_28 ; $66aa
	pop bc ; $66ad
	ld a, b ; $66ae
	jr z, Label_1b_66b6 ; $66af
	farcall FarPtr_18_24 ; $66b1
	jr Label_1b_66bb ; $66b4
Label_1b_66b6:
	ld a, $20 ; $66b6
	ld [$d58b], a ; $66b8
Label_1b_66bb:
	ld a, $0a ; $66bb
	ld hl, $66c4 ; $66bd
	call Func_00_1b6a ; $66c0
	ret ; $66c3
	INCBIN "data/bank_01b/d_66c4.bin" ; $66c4, 19 bytes
Func_1b_66d7:
	farcall FarPtr_1b_0c ; $66d7
	ld hl, $ce40 ; $66da
Label_1b_66dd:
	ld a, [hl] ; $66dd
	farcall FarPtr_18_24 ; $66de
	farcall FarPtr_18_28 ; $66e1
	jr z, Label_1b_6703 ; $66e4
	ld a, [$d58b] ; $66e6
	farcall FarPtr_1b_10 ; $66e9
	ld a, [hl] ; $66ec
	ld de, $0002 ; $66ed
	call Func_1b_65f1 ; $66f0
	farcall FarPtr_1b_18 ; $66f3
	ld a, [hl] ; $66f6
	ld de, $0006 ; $66f7
	call Func_1b_65f1 ; $66fa
	ld a, [$d58c] ; $66fd
	farcall FarPtr_1b_0e ; $6700
Label_1b_6703:
	ld a, $08 ; $6703
	add a, l ; $6705
	ld l, a ; $6706
	jr nc, Label_1b_670a ; $6707
	inc h ; $6709
Label_1b_670a:
	ld a, [hl] ; $670a
	cp a, $ff ; $670b
	jr nz, Label_1b_66dd ; $670d
	ld a, [$c781] ; $670f
	farcall FarPtr_18_24 ; $6712
	ld a, [$d58b] ; $6715
	farcall FarPtr_1b_12 ; $6718
	ret ; $671b
Func_1b_671c:
	ld a, $01 ; $671c
	ldh [$ff96], a ; $671e
	ldh [rWBK], a ; $6720
	call Func_00_1b38 ; $6722
	call Func_1b_65fa ; $6725
	call Func_1b_6609 ; $6728
	ld hl, $cb1f ; $672b
	call Func_1b_67d8 ; $672e
	ld a, [$c781] ; $6731
	ld [$c782], a ; $6734
	call Func_1b_686f ; $6737
	ld c, $20 ; $673a
	call Func_00_1d20 ; $673c
	call Func_00_1da4 ; $673f
	call DisableLCDSafely ; $6742
	call Func_1b_664a ; $6745
	call Func_1b_6681 ; $6748
	call Func_1b_6618 ; $674b
	call Func_1b_66d7 ; $674e
	call Func_1b_669d ; $6751
	ld hl, $dc00 ; $6754
	ld de, $b800 ; $6757
	ld c, $24 ; $675a
	call Func_00_0480 ; $675c
	ld hl, $d800 ; $675f
	ld de, $9800 ; $6762
	ld c, $24 ; $6765
	call Func_00_0480 ; $6767
	call Func_1b_68d6 ; $676a
	call EnableLCD ; $676d
	ld c, $20 ; $6770
	call Func_00_1d2e ; $6772
	call Func_00_1da4 ; $6775
Label_1b_6778:
	ld a, $01 ; $6778
	ldh [$ff96], a ; $677a
	ldh [rWBK], a ; $677c
	ldh a, [$ff94] ; $677e
	and a, $01 ; $6780
	jr z, Label_1b_679d ; $6782
	ld a, [$c781] ; $6784
	ld b, a ; $6787
	push bc ; $6788
	farcall FarPtr_18_28 ; $6789
	pop bc ; $678c
	ld a, b ; $678d
	jr z, Label_1b_6792 ; $678e
	jr Label_1b_6796 ; $6790
Label_1b_6792:
	sound $62 ; $6792
	jr Label_1b_6778 ; $6794
Label_1b_6796:
	sound $5f ; $6796
	ld hl, $cb1f ; $6798
	jr Label_1b_67c6 ; $679b
Label_1b_679d:
	ldh a, [$ff94] ; $679d
	and a, $02 ; $679f
	jr z, Label_1b_67af ; $67a1
	sound $62 ; $67a3
	ld hl, $cb1f ; $67a5
	ld a, $00 ; $67a8
	ld [hl], a ; $67aa
	ld a, $ff ; $67ab
	jr Label_1b_67c6 ; $67ad
Label_1b_67af:
	ldh a, [$ff94] ; $67af
	and a, $08 ; $67b1
	jr z, Label_1b_67b8 ; $67b3
	call Func_1b_68a4 ; $67b5
Label_1b_67b8:
	call Func_1b_67f4 ; $67b8
	call Func_1b_67d8 ; $67bb
	ld a, [$c781] ; $67be
	call Func_00_2631 ; $67c1
	jr Label_1b_6778 ; $67c4
Label_1b_67c6:
	ld c, $08 ; $67c6
	call Func_00_1d20 ; $67c8
	call Func_00_1da4 ; $67cb
	call Func_1b_688a ; $67ce
	call Func_00_2631 ; $67d1
	call Func_00_2631 ; $67d4
	ret ; $67d7
Func_1b_67d8:
	ld a, [$c781] ; $67d8
	ld [$c782], a ; $67db
	ld a, [$c784] ; $67de
	add a, a ; $67e1
	add a, a ; $67e2
	add a, a ; $67e3
	ld hl, $c783 ; $67e4
	add a, [hl] ; $67e7
	add a, $a0 ; $67e8
	ld l, a ; $67ea
	adc a, $c7 ; $67eb
	sub a, l ; $67ed
	ld h, a ; $67ee
	ld a, [hl] ; $67ef
	ld [$c781], a ; $67f0
	ret ; $67f3
Func_1b_67f4:
	ldh a, [$ff91] ; $67f4
	ld b, a ; $67f6
	and a, $f0 ; $67f7
	jr z, Label_1b_6826 ; $67f9
	sound $5e ; $67fb
	ld a, [$c783] ; $67fd
	ld d, a ; $6800
	ld a, [$c784] ; $6801
	ld e, a ; $6804
	ld hl, $c7a0 ; $6805
	call Func_1b_6827 ; $6808
	ld b, a ; $680b
	push bc ; $680c
	farcall FarPtr_18_28 ; $680d
	pop bc ; $6810
	ld a, b ; $6811
	jr z, Label_1b_6819 ; $6812
	farcall FarPtr_18_24 ; $6814
	jr Label_1b_681e ; $6817
Label_1b_6819:
	ld a, $20 ; $6819
	ld [$d58b], a ; $681b
Label_1b_681e:
	ld a, d ; $681e
	ld [$c783], a ; $681f
	ld a, e ; $6822
	ld [$c784], a ; $6823
Label_1b_6826:
	ret ; $6826
Func_1b_6827:
	bit 5, b ; $6827
	jr z, Label_1b_682e ; $6829
	dec d ; $682b
	jr Label_1b_6841 ; $682c
Label_1b_682e:
	bit 4, b ; $682e
	jr z, Label_1b_6835 ; $6830
	inc d ; $6832
	jr Label_1b_6841 ; $6833
Label_1b_6835:
	bit 6, b ; $6835
	jr z, Label_1b_683c ; $6837
	dec e ; $6839
	jr Label_1b_6841 ; $683a
Label_1b_683c:
	bit 7, b ; $683c
	jr z, Label_1b_6841 ; $683e
	inc e ; $6840
Label_1b_6841:
	ld a, d ; $6841
	add a, a ; $6842
	jr nc, Label_1b_684a ; $6843
	ld a, $05 ; $6845
	dec a ; $6847
	jr Label_1b_6850 ; $6848
Label_1b_684a:
	rra ; $684a
	cp a, $05 ; $684b
	jr c, Label_1b_6850 ; $684d
	xor a, a ; $684f
Label_1b_6850:
	ld d, a ; $6850
	ld a, e ; $6851
	add a, a ; $6852
	jr nc, Label_1b_685a ; $6853
	ld a, $02 ; $6855
	dec a ; $6857
	jr Label_1b_6860 ; $6858
Label_1b_685a:
	rra ; $685a
	cp a, $02 ; $685b
	jr c, Label_1b_6860 ; $685d
	xor a, a ; $685f
Label_1b_6860:
	ld e, a ; $6860
	ld a, e ; $6861
	add a, a ; $6862
	add a, a ; $6863
	add a, a ; $6864
	add a, d ; $6865
	push hl ; $6866
	add a, l ; $6867
	ld l, a ; $6868
	jr nc, Label_1b_686c ; $6869
	inc h ; $686b
Label_1b_686c:
	ld a, [hl] ; $686c
	pop hl ; $686d
	ret ; $686e
Func_1b_686f:
	push bc ; $686f
	ldh a, [$ff96] ; $6870
	push af ; $6872
	ld a, $06 ; $6873
	ldh [$ff96], a ; $6875
	ldh [rWBK], a ; $6877
	ld hl, $d400 ; $6879
	ld b, $0b ; $687c
	farcall FarPtr_03_06 ; $687e
	ld b, a ; $6881
	pop af ; $6882
	ldh [$ff96], a ; $6883
	ldh [rWBK], a ; $6885
	ld a, b ; $6887
	pop bc ; $6888
	ret ; $6889
Func_1b_688a:
	ldh a, [$ff96] ; $688a
	push af ; $688c
	ld a, $06 ; $688d
	ldh [$ff96], a ; $688f
	ldh [rWBK], a ; $6891
	ld hl, $d400 ; $6893
	ld de, $0000 ; $6896
	ld b, $0b ; $6899
	farcall FarPtr_03_04 ; $689b
	pop af ; $689e
	ldh [$ff96], a ; $689f
	ldh [rWBK], a ; $68a1
	ret ; $68a3
Func_1b_68a4:
	ldh a, [$ff96] ; $68a4
	push af ; $68a6
	ld a, $06 ; $68a7
	ldh [$ff96], a ; $68a9
	ldh [rWBK], a ; $68ab
	ld hl, $d400 ; $68ad
	ld a, [$c781] ; $68b0
	cp a, $1a ; $68b3
	jr c, Label_1b_68ce ; $68b5
	cp a, $20 ; $68b7
	jr nc, Label_1b_68ce ; $68b9
	sub a, $18 ; $68bb
	add a, l ; $68bd
	ld l, a ; $68be
	jr nc, Label_1b_68c2 ; $68bf
	inc h ; $68c1
Label_1b_68c2:
	ld a, [hl] ; $68c2
	xor a, $01 ; $68c3
	ld [hl], a ; $68c5
	sound $5f ; $68c6
	pop af ; $68c8
	ldh [$ff96], a ; $68c9
	ldh [rWBK], a ; $68cb
	ret ; $68cd
Label_1b_68ce:
	sound $62 ; $68ce
	pop af ; $68d0
	ldh [$ff96], a ; $68d1
	ldh [rWBK], a ; $68d3
	ret ; $68d5
Func_1b_68d6:
	ldh a, [$ff96] ; $68d6
	push af ; $68d8
	ld a, $01 ; $68d9
	ldh [$ff96], a ; $68db
	ldh [rWBK], a ; $68dd
	ld hl, $690a ; $68df
	ld de, $d000 ; $68e2
	call DecompressData ; $68e5
	ld hl, $d000 ; $68e8
	ld de, $8500 ; $68eb
	ld c, $02 ; $68ee
	call Func_00_0480 ; $68f0
	pop af ; $68f3
	ldh [$ff96], a ; $68f4
	ldh [rWBK], a ; $68f6
	ld hl, $6930 ; $68f8
	ld de, $0801 ; $68fb
	call Func_00_05b0 ; $68fe
	ld a, $01 ; $6901
	ld hl, $6938 ; $6903
	call Func_00_1b6a ; $6906
	ret ; $6909
	INCBIN "data/bank_01b/d_690a.bin" ; $690a, 120 bytes
Func_1b_6982:
	ld a, $01 ; $6982
	ldh [$ff96], a ; $6984
	ldh [rWBK], a ; $6986
	ld c, $20 ; $6988
	call Func_00_1d20 ; $698a
	call Func_00_1da4 ; $698d
	call DisableLCDSafely ; $6990
	xor a, a ; $6993
	ld [$c7bc], a ; $6994
	ld [$c7c8], a ; $6997
	farcall FarPtr_18_2e ; $699a
	call EnableLCD ; $699d
	ld c, $20 ; $69a0
	call Func_00_1d2e ; $69a2
	call Func_00_1da4 ; $69a5
	ld a, $07 ; $69a8
	ldh [$ff96], a ; $69aa
	ldh [rWBK], a ; $69ac
	xor a, a ; $69ae
	ld [$db26], a ; $69af
	ld a, $0c ; $69b2
	ld [$db27], a ; $69b4
	ld a, $01 ; $69b7
	ld hl, $69d6 ; $69b9
	call Func_00_1b6a ; $69bc
	ld b, $01 ; $69bf
	farcall FarPtr_18_34 ; $69c1
	push af ; $69c4
	ld hl, $69d6 ; $69c5
	call Func_00_1bcb ; $69c8
	pop af ; $69cb
	ret ; $69cc
	INCBIN "data/bank_01b/d_69cd.bin" ; $69cd, 9 bytes
Func_1b_69d6:
	ret ; $69d6
	INCBIN "data/bank_01b/d_69d7.bin" ; $69d7, 263 bytes
Func_1b_6ade:
	ld a, $01 ; $6ade
	ldh [$ff96], a ; $6ae0
	ldh [rWBK], a ; $6ae2
	ld c, $20 ; $6ae4
	call Func_00_1d20 ; $6ae6
	call Func_00_1da4 ; $6ae9
	call DisableLCDSafely ; $6aec
	ld a, $20 ; $6aef
	ld hl, $d862 ; $6af1
	call Func_1b_6b5d ; $6af4
	ld hl, $d882 ; $6af7
	call Func_1b_6b5d ; $6afa
	ld hl, $d8a2 ; $6afd
	call Func_1b_6b5d ; $6b00
	ld hl, $d8c2 ; $6b03
	call Func_1b_6b5d ; $6b06
	ld hl, $d8e2 ; $6b09
	call Func_1b_6b5d ; $6b0c
	ld a, $00 ; $6b0f
	ld hl, $dc62 ; $6b11
	call Func_1b_6b5d ; $6b14
	ld hl, $dc82 ; $6b17
	call Func_1b_6b5d ; $6b1a
	ld hl, $dca2 ; $6b1d
	call Func_1b_6b5d ; $6b20
	ld hl, $dcc2 ; $6b23
	call Func_1b_6b5d ; $6b26
	ld hl, $dce2 ; $6b29
	call Func_1b_6b5d ; $6b2c
	ld hl, $047b ; $6b2f
	ld de, $d883 ; $6b32
	farcall FarPtr_18_04 ; $6b35
	ld hl, $047c ; $6b38
	ld de, $d8c3 ; $6b3b
	farcall FarPtr_18_04 ; $6b3e
	farcall FarPtr_18_2e ; $6b41
	call EnableLCD ; $6b44
	ld c, $20 ; $6b47
	call Func_00_1d2e ; $6b49
	call Func_00_1da4 ; $6b4c
Label_1b_6b4f:
	ldh a, [$ff94] ; $6b4f
	and a, $03 ; $6b51
	jr nz, Label_1b_6b5a ; $6b53
	call Func_00_2631 ; $6b55
	jr Label_1b_6b4f ; $6b58
Label_1b_6b5a:
	sound $5f ; $6b5a
	ret ; $6b5c
Func_1b_6b5d:
	ld [hl+], a ; $6b5d
	ld [hl+], a ; $6b5e
	ld [hl+], a ; $6b5f
	ld [hl+], a ; $6b60
	ld [hl+], a ; $6b61
	ld [hl+], a ; $6b62
	ld [hl+], a ; $6b63
	ld [hl+], a ; $6b64
	ld [hl+], a ; $6b65
	ld [hl+], a ; $6b66
	ld [hl+], a ; $6b67
	ld [hl+], a ; $6b68
	ld [hl+], a ; $6b69
	ld [hl+], a ; $6b6a
	ld [hl+], a ; $6b6b
	ld [hl+], a ; $6b6c
	ld [hl+], a ; $6b6d
	ret ; $6b6e
Func_1b_6b6f:
	ld a, $01 ; $6b6f
	ldh [$ff96], a ; $6b71
	ldh [rWBK], a ; $6b73
	ld c, $20 ; $6b75
	call Func_00_1d20 ; $6b77
	call Func_00_1da4 ; $6b7a
	call DisableLCDSafely ; $6b7d
	farcall FarPtr_18_2e ; $6b80
	call EnableLCD ; $6b83
	ld c, $20 ; $6b86
	call Func_00_1d2e ; $6b88
	call Func_00_1da4 ; $6b8b
Label_1b_6b8e:
	ldh a, [$ff94] ; $6b8e
	and a, $03 ; $6b90
	jr nz, Label_1b_6b99 ; $6b92
	call Func_00_2631 ; $6b94
	jr Label_1b_6b8e ; $6b97
Label_1b_6b99:
	sound $5f ; $6b99
	ret ; $6b9b
Func_1b_6b9c:
	ldh a, [$ff96] ; $6b9c
	push af ; $6b9e
	ld a, $02 ; $6b9f
	ldh [$ff96], a ; $6ba1
	ldh [rWBK], a ; $6ba3
	ld a, c ; $6ba5
	ld [$d000], a ; $6ba6
	xor a, a ; $6ba9
	ld [$d001], a ; $6baa
	call Func_1b_6bd3 ; $6bad
	call Func_1b_6c59 ; $6bb0
	ld a, [$d001] ; $6bb3
	cp a, $02 ; $6bb6
	jr z, Label_1b_6bbf ; $6bb8
	call Func_1b_6e31 ; $6bba
	jr Label_1b_6bc2 ; $6bbd
Label_1b_6bbf:
	call Func_1b_6fd2 ; $6bbf
Label_1b_6bc2:
	ld a, $02 ; $6bc2
	ldh [$ff96], a ; $6bc4
	ldh [rWBK], a ; $6bc6
	ld a, [$d003] ; $6bc8
	ld c, a ; $6bcb
	pop af ; $6bcc
	ldh [$ff96], a ; $6bcd
	ldh [rWBK], a ; $6bcf
	ld a, c ; $6bd1
	ret ; $6bd2
Func_1b_6bd3:
	ld c, $00 ; $6bd3
	ld a, [$d000] ; $6bd5
	add a, a ; $6bd8
	ld hl, $6c11 ; $6bd9
	add a, l ; $6bdc
	ld l, a ; $6bdd
	jr nc, Label_1b_6be1 ; $6bde
	inc h ; $6be0
Label_1b_6be1:
	ld a, [hl+] ; $6be1
	ld h, [hl] ; $6be2
	ld l, a ; $6be3
	push hl ; $6be4
	ld a, [hl+] ; $6be5
	ld d, [hl] ; $6be6
	ld e, a ; $6be7
	farcall FarPtr_03_1c ; $6be8
	pop hl ; $6beb
	jr z, Label_1b_6bef ; $6bec
	inc c ; $6bee
Label_1b_6bef:
	inc hl ; $6bef
	inc hl ; $6bf0
	ld a, [hl+] ; $6bf1
	ld d, [hl] ; $6bf2
	ld e, a ; $6bf3
	farcall FarPtr_03_1c ; $6bf4
	jr z, Label_1b_6bfa ; $6bf7
	inc c ; $6bf9
Label_1b_6bfa:
	ld a, c ; $6bfa
	ld [$d001], a ; $6bfb
	ld a, [$d001] ; $6bfe
	ld hl, $6c0e ; $6c01
	add a, l ; $6c04
	ld l, a ; $6c05
	jr nc, Label_1b_6c09 ; $6c06
	inc h ; $6c08
Label_1b_6c09:
	ld a, [hl] ; $6c09
	ld [$d002], a ; $6c0a
	ret ; $6c0d
	INCBIN "data/bank_01b/d_6c0e.bin" ; $6c0e, 75 bytes
Func_1b_6c59:
	ldh a, [$ff96] ; $6c59
	push af ; $6c5b
	ld a, $01 ; $6c5c
	ldh [$ff96], a ; $6c5e
	ldh [rWBK], a ; $6c60
	ld c, $00 ; $6c62
Label_1b_6c64:
	ld a, c ; $6c64
	add a, a ; $6c65
	ld hl, $6d2d ; $6c66
	add a, l ; $6c69
	ld l, a ; $6c6a
	jr nc, Label_1b_6c6e ; $6c6b
	inc h ; $6c6d
Label_1b_6c6e:
	ld a, [hl+] ; $6c6e
	ld h, [hl] ; $6c6f
	ld l, a ; $6c70
	push af ; $6c71
	push bc ; $6c72
	push de ; $6c73
	push hl ; $6c74
	ld de, $d000 ; $6c75
	call DecompressDataFromBank ; $6c78
	pop hl ; $6c7b
	pop de ; $6c7c
	pop bc ; $6c7d
	pop af ; $6c7e
	ld hl, $6d35 ; $6c7f
	ld a, c ; $6c82
	add a, a ; $6c83
	add a, l ; $6c84
	ld l, a ; $6c85
	jr nc, Label_1b_6c89 ; $6c86
	inc h ; $6c88
Label_1b_6c89:
	ld a, [hl+] ; $6c89
	ld d, [hl] ; $6c8a
	ld e, a ; $6c8b
	ld hl, $d000 ; $6c8c
	push af ; $6c8f
	push bc ; $6c90
	push de ; $6c91
	push hl ; $6c92
	ld bc, $0010 ; $6c93
	call Func_00_0480 ; $6c96
	pop hl ; $6c99
	pop de ; $6c9a
	pop bc ; $6c9b
	pop af ; $6c9c
	ld a, c ; $6c9d
	inc a ; $6c9e
	ld c, a ; $6c9f
	call Func_00_2631 ; $6ca0
	ldh a, [$ff96] ; $6ca3
	push af ; $6ca5
	ld a, $02 ; $6ca6
	ldh [$ff96], a ; $6ca8
	ldh [rWBK], a ; $6caa
	ld a, [$d001] ; $6cac
	ld b, a ; $6caf
	pop af ; $6cb0
	ldh [$ff96], a ; $6cb1
	ldh [rWBK], a ; $6cb3
	ld a, b ; $6cb5
	or a, a ; $6cb6
	jr z, Label_1b_6cc0 ; $6cb7
	ld a, c ; $6cb9
	cp a, $03 ; $6cba
	jr nz, Label_1b_6c64 ; $6cbc
	jr Label_1b_6cc5 ; $6cbe
Label_1b_6cc0:
	ld a, c ; $6cc0
	cp a, $04 ; $6cc1
	jr nz, Label_1b_6c64 ; $6cc3
Label_1b_6cc5:
	ld b, $70 ; $6cc5
	ld c, $10 ; $6cc7
	ld de, $a000 ; $6cc9
	farcall FarPtr_39_10 ; $6ccc
	call Func_00_2631 ; $6ccf
	ldh a, [$ff96] ; $6cd2
	push af ; $6cd4
	ld a, $02 ; $6cd5
	ldh [$ff96], a ; $6cd7
	ldh [rWBK], a ; $6cd9
	ld a, [$d001] ; $6cdb
	ld b, a ; $6cde
	pop af ; $6cdf
	ldh [$ff96], a ; $6ce0
	ldh [rWBK], a ; $6ce2
	ld a, b ; $6ce4
	or a, a ; $6ce5
	jr z, Label_1b_6cec ; $6ce6
	ld b, $71 ; $6ce8
	jr Label_1b_6cee ; $6cea
Label_1b_6cec:
	ld b, $6f ; $6cec
Label_1b_6cee:
	ld c, $10 ; $6cee
	ld de, $a100 ; $6cf0
	farcall FarPtr_39_10 ; $6cf3
	call Func_00_2631 ; $6cf6
	ld b, $72 ; $6cf9
	ld c, $10 ; $6cfb
	ld de, $a200 ; $6cfd
	farcall FarPtr_39_10 ; $6d00
	call Func_00_2631 ; $6d03
	ld b, $1b ; $6d06
	ld c, $04 ; $6d08
	ld de, $a700 ; $6d0a
	farcall FarPtr_39_10 ; $6d0d
	call Func_00_2631 ; $6d10
	ld b, $77 ; $6d13
	ld c, $14 ; $6d15
	ld de, $8000 ; $6d17
	farcall FarPtr_39_10 ; $6d1a
	call Func_00_2631 ; $6d1d
	ld b, $08 ; $6d20
	ld c, $10 ; $6d22
	farcall FarPtr_39_0e ; $6d24
	pop af ; $6d27
	ldh [$ff96], a ; $6d28
	ldh [rWBK], a ; $6d2a
	ret ; $6d2c
	INCBIN "data/bank_01b/d_6d2d.bin" ; $6d2d, 16 bytes
Func_1b_6d3d:
	ldh a, [$ff96] ; $6d3d
	push af ; $6d3f
	ld a, $02 ; $6d40
	ldh [$ff96], a ; $6d42
	ldh [rWBK], a ; $6d44
	ld a, [$d001] ; $6d46
	or a, a ; $6d49
	jr nz, Label_1b_6d63 ; $6d4a
	ld c, $03 ; $6d4c
	call Func_1b_43c1 ; $6d4e
	cp a, $01 ; $6d51
	jr nz, Label_1b_6d63 ; $6d53
	ld a, $03 ; $6d55
	ldh [$ff96], a ; $6d57
	ldh [rWBK], a ; $6d59
	ld hl, $00c5 ; $6d5b
	ld de, $d201 ; $6d5e
	jr Label_1b_6d84 ; $6d61
Label_1b_6d63:
	ld a, $03 ; $6d63
	ldh [$ff96], a ; $6d65
	ldh [rWBK], a ; $6d67
	ld c, $03 ; $6d69
	call Func_1b_43c1 ; $6d6b
	ld b, a ; $6d6e
	ld hl, $6d8f ; $6d6f
	add a, a ; $6d72
	add a, l ; $6d73
	ld l, a ; $6d74
	jr nc, Label_1b_6d78 ; $6d75
	inc h ; $6d77
Label_1b_6d78:
	ld a, [hl+] ; $6d78
	ld d, [hl] ; $6d79
	ld e, a ; $6d7a
	ld a, b ; $6d7b
	ld hl, $00c2 ; $6d7c
	add a, l ; $6d7f
	ld l, a ; $6d80
	jr nc, Label_1b_6d84 ; $6d81
	inc h ; $6d83
Label_1b_6d84:
	ld c, $20 ; $6d84
	farcall FarPtr_05_72 ; $6d86
	pop af ; $6d89
	ldh [$ff96], a ; $6d8a
	ldh [rWBK], a ; $6d8c
	ret ; $6d8e
	INCBIN "data/bank_01b/d_6d8f.bin" ; $6d8f, 6 bytes
Func_1b_6d95:
	ld hl, $6da8 ; $6d95
	add a, a ; $6d98
	add a, l ; $6d99
	ld l, a ; $6d9a
	jr nc, Label_1b_6d9e ; $6d9b
	inc h ; $6d9d
Label_1b_6d9e:
	ld a, [hl+] ; $6d9e
	ld h, [hl] ; $6d9f
	ld l, a ; $6da0
	ld de, $0401 ; $6da1
	call Func_00_05b0 ; $6da4
	ret ; $6da7
	INCBIN "data/bank_01b/d_6da8.bin" ; $6da8, 30 bytes
Func_1b_6dc6:
	ldh a, [$ff96] ; $6dc6
	push af ; $6dc8
	ld a, $03 ; $6dc9
	ldh [$ff96], a ; $6dcb
	ldh [rWBK], a ; $6dcd
	ld hl, $d4e0 ; $6dcf
	ld de, $b8e0 ; $6dd2
	ld c, $06 ; $6dd5
	call Func_00_0480 ; $6dd7
	ld hl, $d1e0 ; $6dda
	ld de, $99e0 ; $6ddd
	ld c, $04 ; $6de0
	call Func_00_0480 ; $6de2
	pop af ; $6de5
	ldh [$ff96], a ; $6de6
	ldh [rWBK], a ; $6de8
	ret ; $6dea
Func_1b_6deb:
	ldh a, [$ff96] ; $6deb
	push af ; $6ded
	ld a, $03 ; $6dee
	ldh [$ff96], a ; $6df0
	ldh [rWBK], a ; $6df2
	ld de, $d1e0 ; $6df4
	ld b, $14 ; $6df7
	ld c, $01 ; $6df9
	ld h, $03 ; $6dfb
	farcall FarPtr_39_0c ; $6dfd
	ld a, $02 ; $6e00
	ld [$d1e0], a ; $6e02
	ld a, $04 ; $6e05
	ld [$d1f3], a ; $6e07
	ld de, $d201 ; $6e0a
	ld b, $12 ; $6e0d
	ld c, $01 ; $6e0f
	ld h, $20 ; $6e11
	farcall FarPtr_39_0c ; $6e13
	pop af ; $6e16
	ldh [$ff96], a ; $6e17
	ldh [rWBK], a ; $6e19
	ret ; $6e1b
Func_1b_6e1c:
	push af ; $6e1c
	ldh a, [$ff96] ; $6e1d
	push af ; $6e1f
	ld a, $02 ; $6e20
	ldh [$ff96], a ; $6e22
	ldh [rWBK], a ; $6e24
	ld a, [$d002] ; $6e26
	ld b, a ; $6e29
	pop af ; $6e2a
	ldh [$ff96], a ; $6e2b
	ldh [rWBK], a ; $6e2d
	pop af ; $6e2f
	ret ; $6e30
Func_1b_6e31:
	call Func_00_2f32 ; $6e31
	sound $08 ; $6e34
	ld hl, rIE ; $6e36
	res 2, [hl] ; $6e39
	ld a, $03 ; $6e3b
	ldh [$ff96], a ; $6e3d
	ldh [rWBK], a ; $6e3f
	ld a, [$cb11] ; $6e41
	ld b, a ; $6e44
	farcall FarPtr_3e_26 ; $6e45
	farcall FarPtr_39_24 ; $6e48
	ld b, $01 ; $6e4b
	ld c, $01 ; $6e4d
	farcall FarPtr_39_26 ; $6e4f
	ld a, $02 ; $6e52
	ldh [$ff96], a ; $6e54
	ldh [rWBK], a ; $6e56
	ld a, [$d001] ; $6e58
	ld c, a ; $6e5b
	ld b, $02 ; $6e5c
	call Func_1b_43e3 ; $6e5e
	ld a, $03 ; $6e61
	ldh [$ff96], a ; $6e63
	ldh [rWBK], a ; $6e65
	ld a, $01 ; $6e67
	ld hl, $6f62 ; $6e69
	call Func_00_1b6a ; $6e6c
	call Func_1b_6f04 ; $6e6f
	ld a, $03 ; $6e72
	ldh [$ff96], a ; $6e74
	ldh [rWBK], a ; $6e76
Label_1b_6e78:
	call Func_00_2631 ; $6e78
	ldh a, [$ff91] ; $6e7b
	ld [$cb0d], a ; $6e7d
	call Func_1b_6e1c ; $6e80
	ld c, $01 ; $6e83
	call Func_1b_4132 ; $6e85
	or a, a ; $6e88
	jr z, Label_1b_6e90 ; $6e89
	sound $5e ; $6e8b
	call Func_1b_6f04 ; $6e8d
Label_1b_6e90:
	ld a, [$cb0d] ; $6e90
	bit 0, a ; $6e93
	jr nz, Label_1b_6e9d ; $6e95
	bit 1, a ; $6e97
	jr nz, Label_1b_6ede ; $6e99
	jr Label_1b_6e78 ; $6e9b
Label_1b_6e9d:
	ld c, $03 ; $6e9d
	call Func_1b_43c1 ; $6e9f
	or a, a ; $6ea2
	jr z, Label_1b_6eb5 ; $6ea3
	ld a, $02 ; $6ea5
	ldh [$ff96], a ; $6ea7
	ldh [rWBK], a ; $6ea9
	ld a, [$d001] ; $6eab
	or a, a ; $6eae
	jr nz, Label_1b_6eb5 ; $6eaf
	sound $61 ; $6eb1
	jr Label_1b_6e78 ; $6eb3
Label_1b_6eb5:
	sound $5f ; $6eb5
	call Func_00_1b38 ; $6eb7
	ld hl, rIE ; $6eba
	set 2, [hl] ; $6ebd
	ld a, $03 ; $6ebf
	ldh [$ff96], a ; $6ec1
	ldh [rWBK], a ; $6ec3
	ld b, $01 ; $6ec5
	farcall FarPtr_3e_28 ; $6ec7
	ld a, $01 ; $6eca
	ld [$cb11], a ; $6ecc
	ld a, $02 ; $6ecf
	ldh [$ff96], a ; $6ed1
	ldh [rWBK], a ; $6ed3
	ld c, $03 ; $6ed5
	call Func_1b_43c1 ; $6ed7
	ld [$d003], a ; $6eda
	ret ; $6edd
Label_1b_6ede:
	sound $62 ; $6ede
	call Func_00_1b38 ; $6ee0
	ld hl, rIE ; $6ee3
	set 2, [hl] ; $6ee6
	ld a, $03 ; $6ee8
	ldh [$ff96], a ; $6eea
	ldh [rWBK], a ; $6eec
	ld b, $00 ; $6eee
	farcall FarPtr_3e_28 ; $6ef0
	ld a, $00 ; $6ef3
	ld [$cb11], a ; $6ef5
	ld a, $02 ; $6ef8
	ldh [$ff96], a ; $6efa
	ldh [rWBK], a ; $6efc
	ld a, $ff ; $6efe
	ld [$d003], a ; $6f00
	ret ; $6f03
Func_1b_6f04:
	ld a, $03 ; $6f04
	ldh [$ff96], a ; $6f06
	ldh [rWBK], a ; $6f08
	ld b, $00 ; $6f0a
	ld c, $00 ; $6f0c
Label_1b_6f0e:
	call Func_1b_6f35 ; $6f0e
	ld a, b ; $6f11
	inc a ; $6f12
	ld b, a ; $6f13
	cp a, $02 ; $6f14
	jr nz, Label_1b_6f0e ; $6f16
	ld c, $02 ; $6f18
	call Func_1b_43c1 ; $6f1a
	ld b, a ; $6f1d
	ld c, $01 ; $6f1e
	call Func_1b_6f35 ; $6f20
	ld c, $03 ; $6f23
	call Func_1b_43c1 ; $6f25
	call Func_1b_6d95 ; $6f28
	call Func_1b_6deb ; $6f2b
	call Func_1b_6d3d ; $6f2e
	call Func_1b_6dc6 ; $6f31
	ret ; $6f34
Func_1b_6f35:
	push af ; $6f35
	push bc ; $6f36
	push de ; $6f37
	push hl ; $6f38
	ld a, c ; $6f39
	or a, a ; $6f3a
	jr z, Label_1b_6f41 ; $6f3b
	ld h, $0c ; $6f3d
	jr Label_1b_6f43 ; $6f3f
Label_1b_6f41:
	ld h, $0d ; $6f41
Label_1b_6f43:
	push hl ; $6f43
	ld hl, $6f5e ; $6f44
	ld a, b ; $6f47
	add a, a ; $6f48
	add a, l ; $6f49
	ld l, a ; $6f4a
	jr nc, Label_1b_6f4e ; $6f4b
	inc h ; $6f4d
Label_1b_6f4e:
	ld a, [hl+] ; $6f4e
	ld d, [hl] ; $6f4f
	ld e, a ; $6f50
	pop hl ; $6f51
	ld b, $05 ; $6f52
	ld c, $03 ; $6f54
	farcall FarPtr_39_0c ; $6f56
	pop hl ; $6f59
	pop de ; $6f5a
	pop bc ; $6f5b
	pop af ; $6f5c
	ret ; $6f5d
	INCBIN "data/bank_01b/d_6f5e.bin" ; $6f5e, 4 bytes
	farcall FarPtr_39_28 ; $6f62
	ld c, $03 ; $6f65
	call Func_1b_43c1 ; $6f67
	push af ; $6f6a
	ld hl, $6fcf ; $6f6b
	add a, l ; $6f6e
	ld l, a ; $6f6f
	jr nc, Label_1b_6f73 ; $6f70
	inc h ; $6f72
Label_1b_6f73:
	ld c, [hl] ; $6f73
	pop af ; $6f74
	ld hl, $6fc9 ; $6f75
	add a, a ; $6f78
	add a, l ; $6f79
	ld l, a ; $6f7a
	jr nc, Label_1b_6f7e ; $6f7b
	inc h ; $6f7d
Label_1b_6f7e:
	ld a, [hl+] ; $6f7e
	ld d, [hl] ; $6f7f
	ld e, a ; $6f80
	farcall FarPtr_39_16 ; $6f81
	ld b, $08 ; $6f84
	ld hl, $6f9f ; $6f86
	push de ; $6f89
	call Func_00_1e9d ; $6f8a
	pop de ; $6f8d
	ld hl, $17f8 ; $6f8e
	add hl, de ; $6f91
	ld d, h ; $6f92
	ld e, l ; $6f93
	ld hl, $6fc0 ; $6f94
	ld b, $08 ; $6f97
	ld c, $70 ; $6f99
	call Func_00_1e9d ; $6f9b
	ret ; $6f9e
	INCBIN "data/bank_01b/d_6f9f.bin" ; $6f9f, 51 bytes
Func_1b_6fd2:
	call Func_00_2f32 ; $6fd2
	sound $08 ; $6fd5
	ld hl, rIE ; $6fd7
	res 2, [hl] ; $6fda
	ld a, $03 ; $6fdc
	ldh [$ff96], a ; $6fde
	ldh [rWBK], a ; $6fe0
	ld a, [$cb11] ; $6fe2
	ld b, a ; $6fe5
	farcall FarPtr_3b_1e ; $6fe6
	farcall FarPtr_39_24 ; $6fe9
	ld b, $01 ; $6fec
	ld c, $01 ; $6fee
	farcall FarPtr_39_26 ; $6ff0
	ld a, $02 ; $6ff3
	ldh [$ff96], a ; $6ff5
	ldh [rWBK], a ; $6ff7
	ld a, [$d001] ; $6ff9
	ld c, a ; $6ffc
	ld b, $03 ; $6ffd
	call Func_1b_43e3 ; $6fff
	ld a, $03 ; $7002
	ldh [$ff96], a ; $7004
	ldh [rWBK], a ; $7006
	ld a, $01 ; $7008
	ld hl, $70ed ; $700a
	call Func_00_1b6a ; $700d
	call Func_1b_708d ; $7010
	ld a, $03 ; $7013
	ldh [$ff96], a ; $7015
	ldh [rWBK], a ; $7017
Label_1b_7019:
	call Func_00_2631 ; $7019
	ldh a, [$ff91] ; $701c
	ld [$cb0d], a ; $701e
	call Func_1b_6e1c ; $7021
	ld c, $01 ; $7024
	call Func_1b_4132 ; $7026
	or a, a ; $7029
	jr z, Label_1b_7031 ; $702a
	sound $5e ; $702c
	call Func_1b_708d ; $702e
Label_1b_7031:
	ld a, [$cb0d] ; $7031
	bit 0, a ; $7034
	jr nz, Label_1b_703e ; $7036
	bit 1, a ; $7038
	jr nz, Label_1b_7067 ; $703a
	jr Label_1b_7019 ; $703c
Label_1b_703e:
	sound $5f ; $703e
	call Func_00_1b38 ; $7040
	ld hl, rIE ; $7043
	set 2, [hl] ; $7046
	ld a, $03 ; $7048
	ldh [$ff96], a ; $704a
	ldh [rWBK], a ; $704c
	ld b, $01 ; $704e
	farcall FarPtr_3b_20 ; $7050
	ld a, $01 ; $7053
	ld [$cb11], a ; $7055
	ld a, $02 ; $7058
	ldh [$ff96], a ; $705a
	ldh [rWBK], a ; $705c
	ld c, $03 ; $705e
	call Func_1b_43c1 ; $7060
	ld [$d003], a ; $7063
	ret ; $7066
Label_1b_7067:
	sound $62 ; $7067
	call Func_00_1b38 ; $7069
	ld hl, rIE ; $706c
	set 2, [hl] ; $706f
	ld a, $03 ; $7071
	ldh [$ff96], a ; $7073
	ldh [rWBK], a ; $7075
	ld b, $00 ; $7077
	farcall FarPtr_3b_20 ; $7079
	ld a, $00 ; $707c
	ld [$cb11], a ; $707e
	ld a, $02 ; $7081
	ldh [$ff96], a ; $7083
	ldh [rWBK], a ; $7085
	ld a, $ff ; $7087
	ld [$d003], a ; $7089
	ret ; $708c
Func_1b_708d:
	ld a, $03 ; $708d
	ldh [$ff96], a ; $708f
	ldh [rWBK], a ; $7091
	ld b, $00 ; $7093
	ld c, $00 ; $7095
Label_1b_7097:
	call Func_1b_70be ; $7097
	ld a, b ; $709a
	inc a ; $709b
	ld b, a ; $709c
	cp a, $03 ; $709d
	jr nz, Label_1b_7097 ; $709f
	ld c, $02 ; $70a1
	call Func_1b_43c1 ; $70a3
	ld b, a ; $70a6
	ld c, $01 ; $70a7
	call Func_1b_70be ; $70a9
	ld c, $03 ; $70ac
	call Func_1b_43c1 ; $70ae
	call Func_1b_6d95 ; $70b1
	call Func_1b_6deb ; $70b4
	call Func_1b_6d3d ; $70b7
	call Func_1b_6dc6 ; $70ba
	ret ; $70bd
Func_1b_70be:
	push af ; $70be
	push bc ; $70bf
	push de ; $70c0
	push hl ; $70c1
	ld a, c ; $70c2
	or a, a ; $70c3
	jr z, Label_1b_70ca ; $70c4
	ld h, $0c ; $70c6
	jr Label_1b_70cc ; $70c8
Label_1b_70ca:
	ld h, $0d ; $70ca
Label_1b_70cc:
	push hl ; $70cc
	ld hl, $70e7 ; $70cd
	ld a, b ; $70d0
	add a, a ; $70d1
	add a, l ; $70d2
	ld l, a ; $70d3
	jr nc, Label_1b_70d7 ; $70d4
	inc h ; $70d6
Label_1b_70d7:
	ld a, [hl+] ; $70d7
	ld d, [hl] ; $70d8
	ld e, a ; $70d9
	pop hl ; $70da
	ld b, $05 ; $70db
	ld c, $03 ; $70dd
	farcall FarPtr_39_0c ; $70df
	pop hl ; $70e2
	pop de ; $70e3
	pop bc ; $70e4
	pop af ; $70e5
	ret ; $70e6
	INCBIN "data/bank_01b/d_70e7.bin" ; $70e7, 118 bytes
Func_1b_715d:
	sound $03 ; $715d
	ld hl, rIE ; $715f
	res 2, [hl] ; $7162
	call Func_1b_720a ; $7164
	ld a, $03 ; $7167
	ldh [$ff96], a ; $7169
	ldh [rWBK], a ; $716b
	ld a, [$cb11] ; $716d
	ld b, a ; $7170
	farcall FarPtr_3e_26 ; $7171
	farcall FarPtr_39_24 ; $7174
	ld b, $01 ; $7177
	ld c, $01 ; $7179
	farcall FarPtr_39_26 ; $717b
	ld a, [$cb25] ; $717e
	ld c, a ; $7181
	ld b, $02 ; $7182
	call Func_1b_43e3 ; $7184
	ld a, $01 ; $7187
	ld hl, $72a4 ; $7189
	call Func_00_1b6a ; $718c
	ld a, $01 ; $718f
	ld hl, $72a8 ; $7191
	call Func_00_1b6a ; $7194
	call Func_1b_7352 ; $7197
	ld a, $03 ; $719a
	ldh [$ff96], a ; $719c
	ldh [rWBK], a ; $719e
Label_1b_71a0:
	call Func_00_2631 ; $71a0
	ldh a, [$ff91] ; $71a3
	ld [$cb0d], a ; $71a5
	ld b, $02 ; $71a8
	ld c, $01 ; $71aa
	call Func_1b_4132 ; $71ac
	or a, a ; $71af
	jr z, Label_1b_71b7 ; $71b0
	sound $5e ; $71b2
	call Func_1b_7352 ; $71b4
Label_1b_71b7:
	ld a, [$cb0d] ; $71b7
	bit 0, a ; $71ba
	jr nz, Label_1b_71c4 ; $71bc
	bit 1, a ; $71be
	jr nz, Label_1b_71e7 ; $71c0
	jr Label_1b_71a0 ; $71c2
Label_1b_71c4:
	sound $5f ; $71c4
	call Func_00_1b38 ; $71c6
	ld hl, rIE ; $71c9
	set 2, [hl] ; $71cc
	ld a, $03 ; $71ce
	ldh [$ff96], a ; $71d0
	ldh [rWBK], a ; $71d2
	ld b, $01 ; $71d4
	farcall FarPtr_3e_28 ; $71d6
	ld a, $01 ; $71d9
	ld [$cb11], a ; $71db
	ld c, $02 ; $71de
	call Func_1b_43c1 ; $71e0
	ld [$cb25], a ; $71e3
	ret ; $71e6
Label_1b_71e7:
	sound $62 ; $71e7
	call Func_00_1b38 ; $71e9
	ld hl, rIE ; $71ec
	set 2, [hl] ; $71ef
	ld a, $03 ; $71f1
	ldh [$ff96], a ; $71f3
	ldh [rWBK], a ; $71f5
	ld b, $00 ; $71f7
	farcall FarPtr_3e_28 ; $71f9
	ld a, $00 ; $71fc
	ld [$cb11], a ; $71fe
	ld a, $02 ; $7201
	ldh [$ff96], a ; $7203
	ldh [rWBK], a ; $7205
	ld a, $ff ; $7207
	ret ; $7209
Func_1b_720a:
	ldh a, [$ff96] ; $720a
	push af ; $720c
	ld a, $01 ; $720d
	ldh [$ff96], a ; $720f
	ldh [rWBK], a ; $7211
	ld c, $00 ; $7213
Label_1b_7215:
	ld a, c ; $7215
	add a, a ; $7216
	ld hl, $729a ; $7217
	add a, l ; $721a
	ld l, a ; $721b
	jr nc, Label_1b_721f ; $721c
	inc h ; $721e
Label_1b_721f:
	ld a, [hl+] ; $721f
	ld h, [hl] ; $7220
	ld l, a ; $7221
	push af ; $7222
	push bc ; $7223
	push de ; $7224
	push hl ; $7225
	ld de, $d000 ; $7226
	call DecompressDataFromBank ; $7229
	pop hl ; $722c
	pop de ; $722d
	pop bc ; $722e
	pop af ; $722f
	ld hl, $729e ; $7230
	ld a, c ; $7233
	add a, a ; $7234
	add a, l ; $7235
	ld l, a ; $7236
	jr nc, Label_1b_723a ; $7237
	inc h ; $7239
Label_1b_723a:
	ld a, [hl+] ; $723a
	ld d, [hl] ; $723b
	ld e, a ; $723c
	ld hl, $d000 ; $723d
	push af ; $7240
	push bc ; $7241
	push de ; $7242
	push hl ; $7243
	ld bc, $0010 ; $7244
	call Func_00_0480 ; $7247
	pop hl ; $724a
	pop de ; $724b
	pop bc ; $724c
	pop af ; $724d
	ld a, c ; $724e
	inc a ; $724f
	ld c, a ; $7250
	call Func_00_2631 ; $7251
	ld a, c ; $7254
	cp a, $02 ; $7255
	jr nz, Label_1b_7215 ; $7257
	ld b, $1d ; $7259
	ld c, $10 ; $725b
	ld de, $a000 ; $725d
	farcall FarPtr_39_10 ; $7260
	call Func_00_2631 ; $7263
	ld b, $1e ; $7266
	ld c, $12 ; $7268
	ld de, $a100 ; $726a
	farcall FarPtr_39_10 ; $726d
	call Func_00_2631 ; $7270
	ld b, $1b ; $7273
	ld c, $04 ; $7275
	ld de, $a700 ; $7277
	farcall FarPtr_39_10 ; $727a
	call Func_00_2631 ; $727d
	ld b, $78 ; $7280
	ld c, $14 ; $7282
	ld de, $8000 ; $7284
	farcall FarPtr_39_10 ; $7287
	call Func_00_2631 ; $728a
	ld b, $08 ; $728d
	ld c, $10 ; $728f
	farcall FarPtr_39_0e ; $7291
	pop af ; $7294
	ldh [$ff96], a ; $7295
	ldh [rWBK], a ; $7297
	ret ; $7299
	INCBIN "data/bank_01b/d_729a.bin" ; $729a, 13 bytes
	ret ; $72a7
	ld c, $02 ; $72a8
	call Func_1b_43c1 ; $72aa
	or a, a ; $72ad
	jr nz, Label_1b_72b4 ; $72ae
	call Func_1b_72b8 ; $72b0
	ret ; $72b3
Label_1b_72b4:
	call Func_1b_72d9 ; $72b4
	ret ; $72b7
Func_1b_72b8:
	ld c, $00 ; $72b8
	ld b, $08 ; $72ba
	ld de, $0c50 ; $72bc
	farcall FarPtr_39_16 ; $72bf
	ld hl, $72fa ; $72c2
	call Func_00_1e9d ; $72c5
	ld b, $08 ; $72c8
	ld c, $70 ; $72ca
	ld de, $2448 ; $72cc
	farcall FarPtr_39_16 ; $72cf
	ld hl, $7340 ; $72d2
	call Func_00_1e9d ; $72d5
	ret ; $72d8
Func_1b_72d9:
	ld c, $10 ; $72d9
	ld b, $08 ; $72db
	ld de, $5050 ; $72dd
	farcall FarPtr_39_16 ; $72e0
	ld hl, $731b ; $72e3
	call Func_00_1e9d ; $72e6
	ld b, $08 ; $72e9
	ld c, $70 ; $72eb
	ld de, $6c48 ; $72ed
	farcall FarPtr_39_16 ; $72f0
	ld hl, $7340 ; $72f3
	call Func_00_1e9d ; $72f6
	ret ; $72f9
	INCBIN "data/bank_01b/d_72fa.bin" ; $72fa, 88 bytes
Func_1b_7352:
	ld a, $03 ; $7352
	ldh [$ff96], a ; $7354
	ldh [rWBK], a ; $7356
	ld b, $00 ; $7358
	ld c, $00 ; $735a
Label_1b_735c:
	call Func_1b_6f35 ; $735c
	ld a, b ; $735f
	inc a ; $7360
	ld b, a ; $7361
	cp a, $02 ; $7362
	jr nz, Label_1b_735c ; $7364
	ld c, $02 ; $7366
	call Func_1b_43c1 ; $7368
	ld b, a ; $736b
	ld c, $01 ; $736c
	call Func_1b_6f35 ; $736e
	ld c, $03 ; $7371
	call Func_1b_43c1 ; $7373
	call Func_1b_73b6 ; $7376
	call Func_1b_6deb ; $7379
	call Func_1b_7383 ; $737c
	call Func_1b_6dc6 ; $737f
	ret ; $7382
Func_1b_7383:
	ldh a, [$ff96] ; $7383
	push af ; $7385
	ld a, $03 ; $7386
	ldh [$ff96], a ; $7388
	ldh [rWBK], a ; $738a
	ld c, $03 ; $738c
	call Func_1b_43c1 ; $738e
	ld b, a ; $7391
	ld hl, $73b2 ; $7392
	add a, a ; $7395
	add a, l ; $7396
	ld l, a ; $7397
	jr nc, Label_1b_739b ; $7398
	inc h ; $739a
Label_1b_739b:
	ld a, [hl+] ; $739b
	ld d, [hl] ; $739c
	ld e, a ; $739d
	ld a, b ; $739e
	ld hl, $00ca ; $739f
	add a, l ; $73a2
	ld l, a ; $73a3
	jr nc, Label_1b_73a7 ; $73a4
	inc h ; $73a6
Label_1b_73a7:
	ld c, $20 ; $73a7
	farcall FarPtr_05_72 ; $73a9
	pop af ; $73ac
	ldh [$ff96], a ; $73ad
	ldh [rWBK], a ; $73af
	ret ; $73b1
	INCBIN "data/bank_01b/d_73b2.bin" ; $73b2, 4 bytes
Func_1b_73b6:
	ld hl, $73c9 ; $73b6
	add a, a ; $73b9
	add a, l ; $73ba
	ld l, a ; $73bb
	jr nc, Label_1b_73bf ; $73bc
	inc h ; $73be
Label_1b_73bf:
	ld a, [hl+] ; $73bf
	ld h, [hl] ; $73c0
	ld l, a ; $73c1
	ld de, $0401 ; $73c2
	call Func_00_05b0 ; $73c5
	ret ; $73c8
	INCBIN "data/bank_01b/d_73c9.bin" ; $73c9, 20 bytes
Func_1b_73dd:
	sound $04 ; $73dd
	call DisableLCDSafely ; $73df
	call Func_1b_7449 ; $73e2
	ld a, $01 ; $73e5
	ld [$cb0b], a ; $73e7
	ld a, $01 ; $73ea
	ld hl, $4430 ; $73ec
	call Func_00_1b6a ; $73ef
	ld a, $01 ; $73f2
	ld hl, $76b9 ; $73f4
	call Func_00_1b6a ; $73f7
	ld a, $01 ; $73fa
	ld hl, $7827 ; $73fc
	call Func_00_1b6a ; $73ff
	call EnableLCD ; $7402
	ld c, $10 ; $7405
	call Func_00_1d2e ; $7407
	call Func_00_1da4 ; $740a
	ld a, $03 ; $740d
	ldh [$ff96], a ; $740f
	ldh [rWBK], a ; $7411
Label_1b_7413:
	ldh a, [$ff91] ; $7413
	ld [$cb0d], a ; $7415
	call Func_1b_749d ; $7418
	call Func_00_2631 ; $741b
	ld a, [$cb0d] ; $741e
	bit 0, a ; $7421
	jr nz, Label_1b_742b ; $7423
	bit 1, a ; $7425
	jr nz, Label_1b_7439 ; $7427
	jr Label_1b_7413 ; $7429
Label_1b_742b:
	sound $5f ; $742b
	ld c, $10 ; $742d
	call Func_00_1d20 ; $742f
	call Func_00_1da4 ; $7432
	call Func_00_1b38 ; $7435
	ret ; $7438
Label_1b_7439:
	sound $62 ; $7439
	ld c, $10 ; $743b
	call Func_00_1d20 ; $743d
	call Func_00_1da4 ; $7440
	call Func_00_1b38 ; $7443
	ld a, $ff ; $7446
	ret ; $7448
Func_1b_7449:
	ld c, $2b ; $7449
	farcall FarPtr_39_00 ; $744b
	xor a, a ; $744e
	ld [$cb04], a ; $744f
	ld [$cb05], a ; $7452
	ld a, $03 ; $7455
	ldh [$ff96], a ; $7457
	ldh [rWBK], a ; $7459
	call Func_1b_74ca ; $745b
	ld de, $aac0 ; $745e
	farcall FarPtr_3b_28 ; $7461
	ld de, $a000 ; $7464
	farcall FarPtr_39_18 ; $7467
	ld b, $08 ; $746a
	ld c, $0f ; $746c
	farcall FarPtr_39_0e ; $746e
	ld de, $a100 ; $7471
	ld b, $09 ; $7474
	ld c, $00 ; $7476
	farcall FarPtr_39_64 ; $7478
	ld a, $09 ; $747b
	ld [$cb6c], a ; $747d
	ld a, $10 ; $7480
	ld [$cb6b], a ; $7482
	call Func_1b_787f ; $7485
	or a, a ; $7488
	jr nz, Label_1b_7490 ; $7489
	call Func_1b_7634 ; $748b
	jr Label_1b_7493 ; $748e
Label_1b_7490:
	call Func_1b_7604 ; $7490
Label_1b_7493:
	call Func_1b_76ee ; $7493
	call Func_1b_77fb ; $7496
	farcall FarPtr_39_02 ; $7499
	ret ; $749c
Func_1b_749d:
	call Func_1b_787f ; $749d
	or a, a ; $74a0
	ret z ; $74a1
	ld a, [$cb0d] ; $74a2
	bit 7, a ; $74a5
	jr nz, Label_1b_74ae ; $74a7
	bit 6, a ; $74a9
	jr nz, Label_1b_74ba ; $74ab
	ret ; $74ad
Label_1b_74ae:
	ld a, [$cb05] ; $74ae
	inc a ; $74b1
	cp a, $05 ; $74b2
	ret z ; $74b4
	ld [$cb05], a ; $74b5
	jr Label_1b_74c4 ; $74b8
Label_1b_74ba:
	ld a, [$cb05] ; $74ba
	dec a ; $74bd
	cp a, $ff ; $74be
	ret z ; $74c0
	ld [$cb05], a ; $74c1
Label_1b_74c4:
	sound $5e ; $74c4
	call Func_1b_75ae ; $74c6
	ret ; $74c9
Func_1b_74ca:
	farcall FarPtr_3b_2c ; $74ca
	call Func_1b_74df ; $74cd
	call Func_1b_751f ; $74d0
	call Func_1b_7560 ; $74d3
	call Func_1b_787f ; $74d6
	jr nz, Label_1b_74de ; $74d9
	call Func_1b_7896 ; $74db
Label_1b_74de:
	ret ; $74de
Func_1b_74df:
	ld hl, $d809 ; $74df
	ld bc, $0009 ; $74e2
	call ClearBytes ; $74e5
	ld c, $00 ; $74e8
	ld hl, $d809 ; $74ea
Label_1b_74ed:
	ld a, c ; $74ed
	add a, a ; $74ee
	push hl ; $74ef
	ld hl, $750d ; $74f0
	add a, l ; $74f3
	ld l, a ; $74f4
	jr nc, Label_1b_74f8 ; $74f5
	inc h ; $74f7
Label_1b_74f8:
	ld a, [hl+] ; $74f8
	ld d, [hl] ; $74f9
	ld e, a ; $74fa
	pop hl ; $74fb
	farcall FarPtr_03_1c ; $74fc
	jr z, Label_1b_7504 ; $74ff
	ld a, $01 ; $7501
	ld [hl], a ; $7503
Label_1b_7504:
	inc hl ; $7504
	ld a, c ; $7505
	inc a ; $7506
	ld c, a ; $7507
	cp a, $09 ; $7508
	jr nz, Label_1b_74ed ; $750a
	ret ; $750c
	INCBIN "data/bank_01b/d_750d.bin" ; $750d, 18 bytes
Func_1b_751f:
	ld hl, $d812 ; $751f
	ld bc, $0009 ; $7522
	call ClearBytes ; $7525
	ld c, $00 ; $7528
	ld hl, $d812 ; $752a
Label_1b_752d:
	ld a, c ; $752d
	add a, a ; $752e
	push hl ; $752f
	ld hl, $754d ; $7530
	add a, l ; $7533
	ld l, a ; $7534
	jr nc, Label_1b_7538 ; $7535
	inc h ; $7537
Label_1b_7538:
	ld a, [hl+] ; $7538
	ld d, [hl] ; $7539
	ld e, a ; $753a
	pop hl ; $753b
	farcall FarPtr_03_1c ; $753c
	jr z, Label_1b_7544 ; $753f
	ld a, $01 ; $7541
	ld [hl], a ; $7543
Label_1b_7544:
	inc hl ; $7544
	ld a, c ; $7545
	inc a ; $7546
	ld c, a ; $7547
	cp a, $09 ; $7548
	jr nz, Label_1b_752d ; $754a
	ret ; $754c
	INCBIN "data/bank_01b/d_754d.bin" ; $754d, 19 bytes
Func_1b_7560:
	ldh a, [$ff96] ; $7560
	push af ; $7562
	ld hl, $d81b ; $7563
	ld bc, $0012 ; $7566
	call ClearBytes ; $7569
	ld de, $06c0 ; $756c
	farcall FarPtr_03_1c ; $756f
	jr z, Label_1b_757b ; $7572
	ld a, $01 ; $7574
	ld hl, $d82b ; $7576
	ld [hl+], a ; $7579
	ld [hl], a ; $757a
Label_1b_757b:
	ld c, $00 ; $757b
Label_1b_757d:
	ld a, c ; $757d
	inc a ; $757e
	inc a ; $757f
	farcall FarPtr_03_2c ; $7580
	ld a, $07 ; $7583
	ldh [$ff96], a ; $7585
	ldh [rWBK], a ; $7587
	ld hl, $de00 ; $7589
	ld a, [hl+] ; $758c
	ld d, [hl] ; $758d
	ld e, a ; $758e
	ld a, $03 ; $758f
	ldh [$ff96], a ; $7591
	ldh [rWBK], a ; $7593
	ld hl, $d81b ; $7595
	ld a, c ; $7598
	add a, a ; $7599
	add a, l ; $759a
	ld l, a ; $759b
	jr nc, Label_1b_759f ; $759c
	inc h ; $759e
Label_1b_759f:
	ld a, e ; $759f
	ld [hl+], a ; $75a0
	ld [hl], d ; $75a1
	inc c ; $75a2
	ld a, c ; $75a3
	cp a, $08 ; $75a4
	jr nz, Label_1b_757d ; $75a6
	pop af ; $75a8
	ldh [$ff96], a ; $75a9
	ldh [rWBK], a ; $75ab
	ret ; $75ad
Func_1b_75ae:
	call Func_1b_7604 ; $75ae
	call Func_1b_76ee ; $75b1
	call Func_1b_75b8 ; $75b4
	ret ; $75b7
Func_1b_75b8:
	ld hl, $d0c0 ; $75b8
	ld de, $98c0 ; $75bb
	ld c, $08 ; $75be
	call Func_00_0480 ; $75c0
	ld hl, $d4c0 ; $75c3
	ld de, $b8c0 ; $75c6
	ld c, $08 ; $75c9
	call Func_00_0480 ; $75cb
	call Func_00_2631 ; $75ce
	ld hl, $d140 ; $75d1
	ld de, $9940 ; $75d4
	ld c, $08 ; $75d7
	call Func_00_0480 ; $75d9
	ld hl, $d540 ; $75dc
	ld de, $b940 ; $75df
	ld c, $08 ; $75e2
	call Func_00_0480 ; $75e4
	call Func_00_2631 ; $75e7
	ld hl, $d1c0 ; $75ea
	ld de, $99c0 ; $75ed
	ld c, $04 ; $75f0
	call Func_00_0480 ; $75f2
	ld hl, $d5c0 ; $75f5
	ld de, $b9c0 ; $75f8
	ld c, $04 ; $75fb
	call Func_00_0480 ; $75fd
	call Func_00_2631 ; $7600
	ret ; $7603
Func_1b_7604:
	ldh a, [$ff96] ; $7604
	push af ; $7606
	ld a, $03 ; $7607
	ldh [$ff96], a ; $7609
	ldh [rWBK], a ; $760b
	ld a, [$cb05] ; $760d
	ld c, a ; $7610
	ld b, $00 ; $7611
Label_1b_7613:
	push bc ; $7613
	farcall FarPtr_3b_2e ; $7614
	pop bc ; $7617
	cp a, $15 ; $7618
	jr nz, Label_1b_7621 ; $761a
	push bc ; $761c
	ld c, $09 ; $761d
	jr Label_1b_7622 ; $761f
Label_1b_7621:
	push bc ; $7621
Label_1b_7622:
	call Func_1b_7669 ; $7622
	pop bc ; $7625
	inc c ; $7626
	ld a, b ; $7627
	inc a ; $7628
	ld b, a ; $7629
	cp a, $05 ; $762a
	jr nz, Label_1b_7613 ; $762c
	pop af ; $762e
	ldh [$ff96], a ; $762f
	ldh [rWBK], a ; $7631
	ret ; $7633
Func_1b_7634:
	ldh a, [$ff96] ; $7634
	push af ; $7636
	ld a, $03 ; $7637
	ldh [$ff96], a ; $7639
	ldh [rWBK], a ; $763b
	ld c, $00 ; $763d
	ld b, $00 ; $763f
Label_1b_7641:
	push bc ; $7641
	farcall FarPtr_3b_2e ; $7642
	pop bc ; $7645
	cp a, $15 ; $7646
	jr nz, Label_1b_764f ; $7648
	push bc ; $764a
	ld c, $09 ; $764b
	jr Label_1b_7650 ; $764d
Label_1b_764f:
	push bc ; $764f
Label_1b_7650:
	call Func_1b_7669 ; $7650
	pop bc ; $7653
	inc c ; $7654
	ld a, b ; $7655
	inc a ; $7656
	ld b, a ; $7657
	cp a, $04 ; $7658
	jr nz, Label_1b_7641 ; $765a
	ld c, $05 ; $765c
	ld b, $04 ; $765e
	call Func_1b_7669 ; $7660
	pop af ; $7663
	ldh [$ff96], a ; $7664
	ldh [rWBK], a ; $7666
	ret ; $7668
Func_1b_7669:
	push af ; $7669
	push bc ; $766a
	push de ; $766b
	push hl ; $766c
	ldh a, [$ff96] ; $766d
	push af ; $766f
	ld a, $03 ; $7670
	ldh [$ff96], a ; $7672
	ldh [rWBK], a ; $7674
	call Func_1b_768a ; $7676
	call Func_1b_76a1 ; $7679
	ld b, c ; $767c
	farcall FarPtr_3b_2a ; $767d
	pop af ; $7680
	ldh [$ff96], a ; $7681
	ldh [rWBK], a ; $7683
	pop hl ; $7685
	pop de ; $7686
	pop bc ; $7687
	pop af ; $7688
	ret ; $7689
Func_1b_768a:
	push hl ; $768a
	ld hl, $7697 ; $768b
	ld a, c ; $768e
	add a, l ; $768f
	ld l, a ; $7690
	jr nc, Label_1b_7694 ; $7691
	inc h ; $7693
Label_1b_7694:
	ld c, [hl] ; $7694
	pop hl ; $7695
	ret ; $7696
	INCBIN "data/bank_01b/d_7697.bin" ; $7697, 10 bytes
Func_1b_76a1:
	ld hl, $76af ; $76a1
	ld a, b ; $76a4
	add a, a ; $76a5
	add a, l ; $76a6
	ld l, a ; $76a7
	jr nc, Label_1b_76ab ; $76a8
	inc h ; $76aa
Label_1b_76ab:
	ld a, [hl+] ; $76ab
	ld h, [hl] ; $76ac
	ld l, a ; $76ad
	ret ; $76ae
	INCBIN "data/bank_01b/d_76af.bin" ; $76af, 10 bytes
	call Func_1b_787f ; $76b9
	or a, a ; $76bc
	ret z ; $76bd
	ld a, [$cb05] ; $76be
	or a, a ; $76c1
	jr z, Label_1b_76d5 ; $76c2
	ld de, $1128 ; $76c4
	ld c, $01 ; $76c7
	call Func_1b_40cd ; $76c9
	ld b, $08 ; $76cc
	ld c, $00 ; $76ce
	ld h, $02 ; $76d0
	farcall FarPtr_39_1a ; $76d2
Label_1b_76d5:
	ld a, [$cb05] ; $76d5
	cp a, $04 ; $76d8
	jr z, Label_1b_76ed ; $76da
	ld de, $1184 ; $76dc
	ld c, $00 ; $76df
	call Func_1b_40cd ; $76e1
	ld b, $08 ; $76e4
	ld c, $00 ; $76e6
	ld h, $03 ; $76e8
	farcall FarPtr_39_1a ; $76ea
Label_1b_76ed:
	ret ; $76ed
Func_1b_76ee:
	call Func_1b_77ac ; $76ee
	call Func_1b_76fb ; $76f1
	call Func_1b_7719 ; $76f4
	call Func_1b_7737 ; $76f7
	ret ; $76fa
Func_1b_76fb:
	ld hl, $d809 ; $76fb
	ld a, [$cb05] ; $76fe
	add a, l ; $7701
	ld l, a ; $7702
	jr nc, Label_1b_7706 ; $7703
	inc h ; $7705
Label_1b_7706:
	ld c, $00 ; $7706
Label_1b_7708:
	ld b, $00 ; $7708
	ld a, [hl+] ; $770a
	or a, a ; $770b
	jr z, Label_1b_7711 ; $770c
	call Func_1b_774c ; $770e
Label_1b_7711:
	ld a, c ; $7711
	inc a ; $7712
	ld c, a ; $7713
	cp a, $05 ; $7714
	jr nz, Label_1b_7708 ; $7716
	ret ; $7718
Func_1b_7719:
	ld hl, $d812 ; $7719
	ld a, [$cb05] ; $771c
	add a, l ; $771f
	ld l, a ; $7720
	jr nc, Label_1b_7724 ; $7721
	inc h ; $7723
Label_1b_7724:
	ld c, $00 ; $7724
Label_1b_7726:
	ld b, $01 ; $7726
	ld a, [hl+] ; $7728
	or a, a ; $7729
	jr z, Label_1b_772f ; $772a
	call Func_1b_774c ; $772c
Label_1b_772f:
	ld a, c ; $772f
	inc a ; $7730
	ld c, a ; $7731
	cp a, $05 ; $7732
	jr nz, Label_1b_7726 ; $7734
	ret ; $7736
Func_1b_7737:
	ld a, [$cb05] ; $7737
	cp a, $04 ; $773a
	ret nz ; $773c
	ld hl, $d82b ; $773d
	ld a, [hl+] ; $7740
	ld b, [hl] ; $7741
	or a, b ; $7742
	ret z ; $7743
	ld b, $02 ; $7744
	ld c, $04 ; $7746
	call Func_1b_774c ; $7748
	ret ; $774b
Func_1b_774c:
	push af ; $774c
	push bc ; $774d
	push de ; $774e
	push hl ; $774f
	ld hl, $7788 ; $7750
	ld a, b ; $7753
	add a, a ; $7754
	add a, l ; $7755
	ld l, a ; $7756
	jr nc, Label_1b_775a ; $7757
	inc h ; $7759
Label_1b_775a:
	ld a, [hl+] ; $775a
	ld h, [hl] ; $775b
	ld l, a ; $775c
	ld a, c ; $775d
	add a, a ; $775e
	add a, l ; $775f
	ld l, a ; $7760
	jr nc, Label_1b_7764 ; $7761
	inc h ; $7763
Label_1b_7764:
	ld a, [hl+] ; $7764
	ld d, [hl] ; $7765
	ld e, a ; $7766
	push de ; $7767
	ld hl, $d055 ; $7768
	ld b, $02 ; $776b
	ld c, $02 ; $776d
	farcall FarPtr_39_0a ; $776f
	pop de ; $7772
	ld hl, $0400 ; $7773
	add hl, de ; $7776
	ld d, h ; $7777
	ld e, l ; $7778
	ld hl, $d455 ; $7779
	ld b, $02 ; $777c
	ld c, $02 ; $777e
	farcall FarPtr_39_0a ; $7780
	pop hl ; $7783
	pop de ; $7784
	pop bc ; $7785
	pop af ; $7786
	ret ; $7787
	INCBIN "data/bank_01b/d_7788.bin" ; $7788, 36 bytes
Func_1b_77ac:
	ld hl, $d095 ; $77ac
	ld de, $d0c6 ; $77af
	ld b, $02 ; $77b2
	ld c, $0a ; $77b4
	farcall FarPtr_39_0a ; $77b6
	ld hl, $d495 ; $77b9
	ld de, $d4c6 ; $77bc
	ld b, $02 ; $77bf
	ld c, $0a ; $77c1
	farcall FarPtr_39_0a ; $77c3
	ld hl, $d095 ; $77c6
	ld de, $d0ca ; $77c9
	ld b, $02 ; $77cc
	ld c, $0a ; $77ce
	farcall FarPtr_39_0a ; $77d0
	ld hl, $d495 ; $77d3
	ld de, $d4ca ; $77d6
	ld b, $02 ; $77d9
	ld c, $0a ; $77db
	farcall FarPtr_39_0a ; $77dd
	ld hl, $d095 ; $77e0
	ld de, $d0ce ; $77e3
	ld b, $02 ; $77e6
	ld c, $0a ; $77e8
	farcall FarPtr_39_0a ; $77ea
	ld hl, $d495 ; $77ed
	ld de, $d4ce ; $77f0
	ld b, $02 ; $77f3
	ld c, $0a ; $77f5
	farcall FarPtr_39_0a ; $77f7
	ret ; $77fa
Func_1b_77fb:
	ld hl, $d812 ; $77fb
	ld c, $00 ; $77fe
Label_1b_7800:
	ld a, [hl+] ; $7800
	or a, a ; $7801
	jr nz, Label_1b_780c ; $7802
	ld a, c ; $7804
	inc a ; $7805
	ld c, a ; $7806
	cp a, $09 ; $7807
	jr nz, Label_1b_7800 ; $7809
	ret ; $780b
Label_1b_780c:
	ld hl, $d016 ; $780c
	ld de, $d08e ; $780f
	ld b, $02 ; $7812
	ld c, $02 ; $7814
	farcall FarPtr_39_0a ; $7816
	ld hl, $d416 ; $7819
	ld de, $d48e ; $781c
	ld b, $02 ; $781f
	ld c, $02 ; $7821
	farcall FarPtr_39_0a ; $7823
	ret ; $7826
	ldh a, [$ff96] ; $7827
	push af ; $7829
	ld a, $03 ; $782a
	ldh [$ff96], a ; $782c
	ldh [rWBK], a ; $782e
	ld a, [$cb05] ; $7830
	ld c, a ; $7833
	ld b, $00 ; $7834
Label_1b_7836:
	call Func_1b_7847 ; $7836
	inc c ; $7839
	ld a, b ; $783a
	inc b ; $783b
	ld a, b ; $783c
	cp a, $05 ; $783d
	jr nz, Label_1b_7836 ; $783f
	pop af ; $7841
	ldh [$ff96], a ; $7842
	ldh [rWBK], a ; $7844
	ret ; $7846
Func_1b_7847:
	ld a, c ; $7847
	cp a, $08 ; $7848
	ret z ; $784a
	ld a, b ; $784b
	add a, a ; $784c
	ld hl, $7875 ; $784d
	add a, l ; $7850
	ld l, a ; $7851
	jr nc, Label_1b_7855 ; $7852
	inc h ; $7854
Label_1b_7855:
	ld a, [hl+] ; $7855
	ld d, [hl] ; $7856
	ld e, a ; $7857
	ld a, c ; $7858
	ld hl, $d812 ; $7859
	add a, l ; $785c
	ld l, a ; $785d
	jr nc, Label_1b_7861 ; $785e
	inc h ; $7860
Label_1b_7861:
	ld a, [hl] ; $7861
	or a, a ; $7862
	ret z ; $7863
	ld a, c ; $7864
	add a, a ; $7865
	ld hl, $d81b ; $7866
	add a, l ; $7869
	ld l, a ; $786a
	jr nc, Label_1b_786e ; $786b
	inc h ; $786d
Label_1b_786e:
	ld a, [hl+] ; $786e
	ld h, [hl] ; $786f
	ld l, a ; $7870
	farcall FarPtr_39_66 ; $7871
	ret ; $7874
	INCBIN "data/bank_01b/d_7875.bin" ; $7875, 10 bytes
Func_1b_787f:
	push bc ; $787f
	push de ; $7880
	push hl ; $7881
	ld c, $04 ; $7882
	farcall FarPtr_3b_2e ; $7884
	cp a, $15 ; $7887
	jr nz, Label_1b_7890 ; $7889
	pop hl ; $788b
	pop de ; $788c
	pop bc ; $788d
	xor a, a ; $788e
	ret ; $788f
Label_1b_7890:
	pop hl ; $7890
	pop de ; $7891
	pop bc ; $7892
	ld a, $01 ; $7893
	ret ; $7895
Func_1b_7896:
	ldh a, [$ff96] ; $7896
	push af ; $7898
	ld a, $03 ; $7899
	ldh [$ff96], a ; $789b
	ldh [rWBK], a ; $789d
	ld a, [$d80e] ; $789f
	ld [$d80d], a ; $78a2
	ld a, [$d817] ; $78a5
	ld [$d816], a ; $78a8
	ld a, [$d825] ; $78ab
	ld [$d823], a ; $78ae
	ld a, [$d826] ; $78b1
	ld [$d824], a ; $78b4
	pop af ; $78b7
	ldh [$ff96], a ; $78b8
	ldh [rWBK], a ; $78ba
	ret ; $78bc
	INCBIN "data/bank_01b/d_78bd.bin" ; $78bd, 1781 bytes
	ds 78, $ff ; $7fb2, fill
