INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $1b", ROMX[$4000], BANK[$1b]

	INCBIN "data/bank_01b/d_4000.bin" ; $4000, 205 bytes
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
	INCBIN "data/bank_01b/d_4403.bin" ; $4403, 2569 bytes
Func_1b_4e0c:
	ret ; $4e0c
	INCBIN "data/bank_01b/d_4e0d.bin" ; $4e0d, 42 bytes
	cp a, $40 ; $4e37
	ret nc ; $4e39
	push de ; $4e3a
	ld de, $d600 ; $4e3b
	call Func_1b_4e5c ; $4e3e
	pop de ; $4e41
	ret ; $4e42
	INCBIN "data/bank_01b/d_4e43.bin" ; $4e43, 3 bytes
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
	INCBIN "data/bank_01b/d_4e57.bin" ; $4e57, 1 bytes
	rst Rst18 ; $4e58
	ld [bc], a ; $4e59
	INCBIN "data/bank_01b/d_4e5a.bin" ; $4e5a, 1 bytes
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
	INCBIN "data/bank_01b/d_4e7f.bin" ; $4e7f, 7453 bytes
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
	rst Rst18 ; $6be8
	inc e ; $6be9
	inc bc ; $6bea
	pop hl ; $6beb
	jr z, Label_1b_6bef ; $6bec
	inc c ; $6bee
Label_1b_6bef:
	inc hl ; $6bef
	inc hl ; $6bf0
	ld a, [hl+] ; $6bf1
	ld d, [hl] ; $6bf2
	ld e, a ; $6bf3
	rst Rst18 ; $6bf4
	inc e ; $6bf5
	inc bc ; $6bf6
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
	rst Rst18 ; $6ccc
	INCBIN "data/bank_01b/d_6ccd.bin" ; $6ccd, 2 bytes
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
	rst Rst18 ; $6cf3
	INCBIN "data/bank_01b/d_6cf4.bin" ; $6cf4, 2 bytes
	call Func_00_2631 ; $6cf6
	ld b, $72 ; $6cf9
	ld c, $10 ; $6cfb
	ld de, $a200 ; $6cfd
	rst Rst18 ; $6d00
	INCBIN "data/bank_01b/d_6d01.bin" ; $6d01, 2 bytes
	call Func_00_2631 ; $6d03
	ld b, $1b ; $6d06
	ld c, $04 ; $6d08
	ld de, $a700 ; $6d0a
	rst Rst18 ; $6d0d
	INCBIN "data/bank_01b/d_6d0e.bin" ; $6d0e, 2 bytes
	call Func_00_2631 ; $6d10
	ld b, $77 ; $6d13
	ld c, $14 ; $6d15
	ld de, $8000 ; $6d17
	rst Rst18 ; $6d1a
	INCBIN "data/bank_01b/d_6d1b.bin" ; $6d1b, 2 bytes
	call Func_00_2631 ; $6d1d
	ld b, $08 ; $6d20
	ld c, $10 ; $6d22
	rst Rst18 ; $6d24
	ld c, $39 ; $6d25
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
	rst Rst18 ; $6d86
	ld [hl], d ; $6d87
	dec b ; $6d88
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
	rst Rst18 ; $6dfd
	inc c ; $6dfe
	add hl, sp ; $6dff
	ld a, $02 ; $6e00
	ld [$d1e0], a ; $6e02
	ld a, $04 ; $6e05
	ld [$d1f3], a ; $6e07
	ld de, $d201 ; $6e0a
	ld b, $12 ; $6e0d
	ld c, $01 ; $6e0f
	ld h, $20 ; $6e11
	rst Rst18 ; $6e13
	inc c ; $6e14
	add hl, sp ; $6e15
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
	rst Rst08 ; $6e34
	INCBIN "data/bank_01b/d_6e35.bin" ; $6e35, 1 bytes
	ld hl, rIE ; $6e36
	res 2, [hl] ; $6e39
	ld a, $03 ; $6e3b
	ldh [$ff96], a ; $6e3d
	ldh [rWBK], a ; $6e3f
	ld a, [$cb11] ; $6e41
	ld b, a ; $6e44
	rst Rst18 ; $6e45
	ld h, $3e ; $6e46
	rst Rst18 ; $6e48
	inc h ; $6e49
	add hl, sp ; $6e4a
	ld b, $01 ; $6e4b
	ld c, $01 ; $6e4d
	rst Rst18 ; $6e4f
	ld h, $39 ; $6e50
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
	rst Rst08 ; $6e8b
	ld e, [hl] ; $6e8c
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
	rst Rst08 ; $6eb1
	ld h, c ; $6eb2
	jr Label_1b_6e78 ; $6eb3
Label_1b_6eb5:
	rst Rst08 ; $6eb5
	ld e, a ; $6eb6
	call Func_00_1b38 ; $6eb7
	ld hl, rIE ; $6eba
	set 2, [hl] ; $6ebd
	ld a, $03 ; $6ebf
	ldh [$ff96], a ; $6ec1
	ldh [rWBK], a ; $6ec3
	ld b, $01 ; $6ec5
	rst Rst18 ; $6ec7
	jr z, Label_1b_6f08 ; $6ec8
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
	rst Rst08 ; $6ede
	ld h, d ; $6edf
	call Func_00_1b38 ; $6ee0
	ld hl, rIE ; $6ee3
	set 2, [hl] ; $6ee6
	ld a, $03 ; $6ee8
	ldh [$ff96], a ; $6eea
	ldh [rWBK], a ; $6eec
	ld b, $00 ; $6eee
	rst Rst18 ; $6ef0
	jr z, Label_1b_6f31 ; $6ef1
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
Label_1b_6f08:
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
Label_1b_6f31:
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
	rst Rst18 ; $6f56
	inc c ; $6f57
	add hl, sp ; $6f58
	pop hl ; $6f59
	pop de ; $6f5a
	pop bc ; $6f5b
	pop af ; $6f5c
	ret ; $6f5d
	INCBIN "data/bank_01b/d_6f5e.bin" ; $6f5e, 4 bytes
	rst Rst18 ; $6f62
	jr z, Label_1b_6f9e ; $6f63
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
	rst Rst18 ; $6f81
	ld d, $39 ; $6f82
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
Label_1b_6f9e:
	ret ; $6f9e
	INCBIN "data/bank_01b/d_6f9f.bin" ; $6f9f, 51 bytes
Func_1b_6fd2:
	call Func_00_2f32 ; $6fd2
	rst Rst08 ; $6fd5
	ld [rAUD4ENV], sp ; $6fd6
	rst Rst38 ; $6fd9
	res 2, [hl] ; $6fda
	ld a, $03 ; $6fdc
	ldh [$ff96], a ; $6fde
	ldh [rWBK], a ; $6fe0
	ld a, [$cb11] ; $6fe2
	ld b, a ; $6fe5
	rst Rst18 ; $6fe6
	ld e, $3b ; $6fe7
	rst Rst18 ; $6fe9
	inc h ; $6fea
	add hl, sp ; $6feb
	ld b, $01 ; $6fec
	ld c, $01 ; $6fee
	rst Rst18 ; $6ff0
	ld h, $39 ; $6ff1
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
	rst Rst08 ; $702c
	ld e, [hl] ; $702d
	call Func_1b_708d ; $702e
Label_1b_7031:
	ld a, [$cb0d] ; $7031
	bit 0, a ; $7034
	jr nz, Label_1b_703e ; $7036
	bit 1, a ; $7038
	jr nz, Label_1b_7067 ; $703a
	jr Label_1b_7019 ; $703c
Label_1b_703e:
	rst Rst08 ; $703e
	ld e, a ; $703f
	call Func_00_1b38 ; $7040
	ld hl, rIE ; $7043
	set 2, [hl] ; $7046
	ld a, $03 ; $7048
	ldh [$ff96], a ; $704a
	ldh [rWBK], a ; $704c
	ld b, $01 ; $704e
	rst Rst18 ; $7050
	jr nz, $708e ; $7051
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
	rst Rst08 ; $7067
	ld h, d ; $7068
	call Func_00_1b38 ; $7069
	ld hl, rIE ; $706c
	set 2, [hl] ; $706f
	ld a, $03 ; $7071
	ldh [$ff96], a ; $7073
	ldh [rWBK], a ; $7075
	ld b, $00 ; $7077
	rst Rst18 ; $7079
	jr nz, Label_1b_70b7 ; $707a
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
Label_1b_70b7:
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
	rst Rst18 ; $70df
	inc c ; $70e0
	add hl, sp ; $70e1
	pop hl ; $70e2
	pop de ; $70e3
	pop bc ; $70e4
	pop af ; $70e5
	ret ; $70e6
	INCBIN "data/bank_01b/d_70e7.bin" ; $70e7, 118 bytes
	rst Rst08 ; $715d
	inc bc ; $715e
	ld hl, rIE ; $715f
	res 2, [hl] ; $7162
	call Func_1b_720a ; $7164
	ld a, $03 ; $7167
	ldh [$ff96], a ; $7169
	ldh [rWBK], a ; $716b
	ld a, [$cb11] ; $716d
	ld b, a ; $7170
	rst Rst18 ; $7171
	ld h, $3e ; $7172
	rst Rst18 ; $7174
	inc h ; $7175
	add hl, sp ; $7176
	ld b, $01 ; $7177
	ld c, $01 ; $7179
	rst Rst18 ; $717b
	ld h, $39 ; $717c
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
	rst Rst08 ; $71b2
	ld e, [hl] ; $71b3
	call Func_1b_7352 ; $71b4
Label_1b_71b7:
	ld a, [$cb0d] ; $71b7
	bit 0, a ; $71ba
	jr nz, Label_1b_71c4 ; $71bc
	bit 1, a ; $71be
	jr nz, Label_1b_71e7 ; $71c0
	jr Label_1b_71a0 ; $71c2
Label_1b_71c4:
	rst Rst08 ; $71c4
	ld e, a ; $71c5
	call Func_00_1b38 ; $71c6
	ld hl, rIE ; $71c9
	set 2, [hl] ; $71cc
	ld a, $03 ; $71ce
	ldh [$ff96], a ; $71d0
	ldh [rWBK], a ; $71d2
	ld b, $01 ; $71d4
	rst Rst18 ; $71d6
	jr z, Label_1b_7217 ; $71d7
	ld a, $01 ; $71d9
	ld [$cb11], a ; $71db
	ld c, $02 ; $71de
	call Func_1b_43c1 ; $71e0
	ld [$cb25], a ; $71e3
	ret ; $71e6
Label_1b_71e7:
	rst Rst08 ; $71e7
	ld h, d ; $71e8
	call Func_00_1b38 ; $71e9
	ld hl, rIE ; $71ec
	set 2, [hl] ; $71ef
	ld a, $03 ; $71f1
	ldh [$ff96], a ; $71f3
	ldh [rWBK], a ; $71f5
	ld b, $00 ; $71f7
	rst Rst18 ; $71f9
	jr z, Label_1b_723a ; $71fa
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
Label_1b_7217:
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
	rst Rst18 ; $7260
	INCBIN "data/bank_01b/d_7261.bin" ; $7261, 2 bytes
	call Func_00_2631 ; $7263
	ld b, $1e ; $7266
	ld c, $12 ; $7268
	ld de, $a100 ; $726a
	rst Rst18 ; $726d
	INCBIN "data/bank_01b/d_726e.bin" ; $726e, 2 bytes
	call Func_00_2631 ; $7270
	ld b, $1b ; $7273
	ld c, $04 ; $7275
	ld de, $a700 ; $7277
	rst Rst18 ; $727a
	INCBIN "data/bank_01b/d_727b.bin" ; $727b, 2 bytes
	call Func_00_2631 ; $727d
	ld b, $78 ; $7280
	ld c, $14 ; $7282
	ld de, $8000 ; $7284
	rst Rst18 ; $7287
	INCBIN "data/bank_01b/d_7288.bin" ; $7288, 2 bytes
	call Func_00_2631 ; $728a
	ld b, $08 ; $728d
	ld c, $10 ; $728f
	rst Rst18 ; $7291
	ld c, $39 ; $7292
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
	rst Rst18 ; $72bf
	ld d, $39 ; $72c0
	ld hl, $72fa ; $72c2
	call Func_00_1e9d ; $72c5
	ld b, $08 ; $72c8
	ld c, $70 ; $72ca
	ld de, $2448 ; $72cc
	rst Rst18 ; $72cf
	ld d, $39 ; $72d0
	ld hl, $7340 ; $72d2
	call Func_00_1e9d ; $72d5
	ret ; $72d8
Func_1b_72d9:
	ld c, $10 ; $72d9
	ld b, $08 ; $72db
	ld de, $5050 ; $72dd
	rst Rst18 ; $72e0
	ld d, $39 ; $72e1
	ld hl, $731b ; $72e3
	call Func_00_1e9d ; $72e6
	ld b, $08 ; $72e9
	ld c, $70 ; $72eb
	ld de, $6c48 ; $72ed
	rst Rst18 ; $72f0
	ld d, $39 ; $72f1
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
	rst Rst18 ; $73a9
	ld [hl], d ; $73aa
	dec b ; $73ab
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
	rst Rst08 ; $73dd
	inc b ; $73de
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
	rst Rst08 ; $742b
	ld e, a ; $742c
	ld c, $10 ; $742d
	call Func_00_1d20 ; $742f
	call Func_00_1da4 ; $7432
	call Func_00_1b38 ; $7435
	ret ; $7438
Label_1b_7439:
	rst Rst08 ; $7439
	ld h, d ; $743a
	ld c, $10 ; $743b
	call Func_00_1d20 ; $743d
	call Func_00_1da4 ; $7440
	call Func_00_1b38 ; $7443
	ld a, $ff ; $7446
	ret ; $7448
Func_1b_7449:
	ld c, $2b ; $7449
	rst Rst18 ; $744b
	nop ; $744c
	add hl, sp ; $744d
	xor a, a ; $744e
	ld [$cb04], a ; $744f
	ld [$cb05], a ; $7452
	ld a, $03 ; $7455
	ldh [$ff96], a ; $7457
	ldh [rWBK], a ; $7459
	call Func_1b_74ca ; $745b
	ld de, $aac0 ; $745e
	rst Rst18 ; $7461
	jr z, $749f ; $7462
	ld de, $a000 ; $7464
	rst Rst18 ; $7467
	jr $74a3 ; $7468
	ld b, $08 ; $746a
	ld c, $0f ; $746c
	rst Rst18 ; $746e
	ld c, $39 ; $746f
	ld de, $a100 ; $7471
	ld b, $09 ; $7474
	ld c, $00 ; $7476
	rst Rst18 ; $7478
	ld h, h ; $7479
	add hl, sp ; $747a
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
	rst Rst18 ; $7499
	ld [bc], a ; $749a
	add hl, sp ; $749b
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
	rst Rst08 ; $74c4
	ld e, [hl] ; $74c5
	call Func_1b_75ae ; $74c6
	ret ; $74c9
Func_1b_74ca:
	rst Rst18 ; $74ca
	inc l ; $74cb
	dec sp ; $74cc
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
	rst Rst18 ; $74fc
	inc e ; $74fd
	inc bc ; $74fe
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
	rst Rst18 ; $753c
	inc e ; $753d
	inc bc ; $753e
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
	rst Rst18 ; $756f
	inc e ; $7570
	inc bc ; $7571
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
	rst Rst18 ; $7580
	inc l ; $7581
	inc bc ; $7582
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
	rst Rst18 ; $7614
	ld l, $3b ; $7615
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
	rst Rst18 ; $7642
	ld l, $3b ; $7643
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
	rst Rst18 ; $767d
	ld a, [hl+] ; $767e
	dec sp ; $767f
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
	rst Rst18 ; $76d2
	ld a, [de] ; $76d3
	add hl, sp ; $76d4
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
	rst Rst18 ; $76ea
	ld a, [de] ; $76eb
	add hl, sp ; $76ec
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
	rst Rst18 ; $776f
	ld a, [bc] ; $7770
	add hl, sp ; $7771
	pop de ; $7772
	ld hl, $0400 ; $7773
	add hl, de ; $7776
	ld d, h ; $7777
	ld e, l ; $7778
	ld hl, $d455 ; $7779
	ld b, $02 ; $777c
	ld c, $02 ; $777e
	rst Rst18 ; $7780
	ld a, [bc] ; $7781
	add hl, sp ; $7782
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
	rst Rst18 ; $77b6
	ld a, [bc] ; $77b7
	add hl, sp ; $77b8
	ld hl, $d495 ; $77b9
	ld de, $d4c6 ; $77bc
	ld b, $02 ; $77bf
	ld c, $0a ; $77c1
	rst Rst18 ; $77c3
	ld a, [bc] ; $77c4
	add hl, sp ; $77c5
	ld hl, $d095 ; $77c6
	ld de, $d0ca ; $77c9
	ld b, $02 ; $77cc
	ld c, $0a ; $77ce
	rst Rst18 ; $77d0
	ld a, [bc] ; $77d1
	add hl, sp ; $77d2
	ld hl, $d495 ; $77d3
	ld de, $d4ca ; $77d6
	ld b, $02 ; $77d9
	ld c, $0a ; $77db
	rst Rst18 ; $77dd
	ld a, [bc] ; $77de
	add hl, sp ; $77df
	ld hl, $d095 ; $77e0
	ld de, $d0ce ; $77e3
	ld b, $02 ; $77e6
	ld c, $0a ; $77e8
	rst Rst18 ; $77ea
	ld a, [bc] ; $77eb
	add hl, sp ; $77ec
	ld hl, $d495 ; $77ed
	ld de, $d4ce ; $77f0
	ld b, $02 ; $77f3
	ld c, $0a ; $77f5
	rst Rst18 ; $77f7
	ld a, [bc] ; $77f8
	add hl, sp ; $77f9
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
	rst Rst18 ; $7816
	ld a, [bc] ; $7817
	add hl, sp ; $7818
	ld hl, $d416 ; $7819
	ld de, $d48e ; $781c
	ld b, $02 ; $781f
	ld c, $02 ; $7821
	rst Rst18 ; $7823
	ld a, [bc] ; $7824
	add hl, sp ; $7825
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
	rst Rst18 ; $7871
	ld h, [hl] ; $7872
	add hl, sp ; $7873
	ret ; $7874
	INCBIN "data/bank_01b/d_7875.bin" ; $7875, 10 bytes
Func_1b_787f:
	push bc ; $787f
	push de ; $7880
	push hl ; $7881
	ld c, $04 ; $7882
	rst Rst18 ; $7884
	ld l, $3b ; $7885
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
	INCBIN "data/bank_01b/d_78bd.bin" ; $78bd, 1859 bytes
