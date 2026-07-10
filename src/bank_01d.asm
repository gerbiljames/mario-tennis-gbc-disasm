INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $1d", ROMX[$4000], BANK[$1d]

	INCBIN "data/bank_01d/d_4000.bin" ; $4000, 208 bytes
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
	INCBIN "data/bank_01d/d_411e.bin" ; $411e, 1682 bytes
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
	INCBIN "data/bank_01d/d_480e.bin" ; $480e, 936 bytes
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
	INCBIN "data/bank_01d/d_4c04.bin" ; $4c04, 649 bytes
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
	rst Rst18 ; $5015
	ld b, $1c ; $5016
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
	rst Rst18 ; $5098
	inc b ; $5099
	inc e ; $509a
	ret ; $509b
	INCBIN "data/bank_01d/d_509c.bin" ; $509c, 2503 bytes
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
	rst Rst18 ; $5a8f
	ld [de], a ; $5a90
	inc e ; $5a91
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
	rst Rst08 ; $5ab9
	ld e, [hl] ; $5aba
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
	rst Rst08 ; $5ad1
	ld e, a ; $5ad2
	jr Label_1d_5ae2 ; $5ad3
Label_1d_5ad5:
	ld a, $06 ; $5ad5
	ldh [$ff96], a ; $5ad7
	ldh [rWBK], a ; $5ad9
	ld a, $01 ; $5adb
	ld [$d025], a ; $5add
	rst Rst08 ; $5ae0
	ld h, d ; $5ae1
Label_1d_5ae2:
	ld c, $10 ; $5ae2
	call Func_00_1d20 ; $5ae4
	call Func_00_1da4 ; $5ae7
	rst Rst18 ; $5aea
	inc d ; $5aeb
	inc e ; $5aec
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
	rst Rst18 ; $5b1b
	ld [bc], a ; $5b1c
	inc e ; $5b1d
	rst Rst18 ; $5b1e
	INCBIN "data/bank_01d/d_5b1f.bin" ; $5b1f, 2 bytes
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
	rst Rst18 ; $5b3e
	ld [bc], a ; $5b3f
	dec de ; $5b40
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
	rst Rst18 ; $5b60
	nop ; $5b61
	dec de ; $5b62
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
	INCBIN "data/bank_01d/d_5be3.bin" ; $5be3, 40 bytes
Func_1d_5c0b:
	ld hl, $6310 ; $5c0b
	ld bc, $d580 ; $5c0e
	call Func_1d_4bb6 ; $5c11
	ret ; $5c14
	INCBIN "data/bank_01d/d_5c15.bin" ; $5c15, 5831 bytes
	ret ; $72dc
	INCBIN "data/bank_01d/d_72dd.bin" ; $72dd, 3363 bytes
