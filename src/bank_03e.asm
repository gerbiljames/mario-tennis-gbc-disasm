INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $3e", ROMX[$4000], BANK[$3e]

	INCBIN "data/bank_03e/d_4000.bin" ; $4000, 314 bytes
Func_3e_413a:
	ld a, [$cb04] ; $413a
	ld d, a ; $413d
	ld a, [$cb05] ; $413e
	ld e, a ; $4141
	ld a, [$cb0d] ; $4142
	bit 4, a ; $4145
	jr z, Label_3e_415e ; $4147
	ld a, [$cb04] ; $4149
	inc a ; $414c
	add a, a ; $414d
	jr nc, Label_3e_4154 ; $414e
	ld a, b ; $4150
	dec a ; $4151
	jr Label_3e_4159 ; $4152
Label_3e_4154:
	rra ; $4154
	cp a, b ; $4155
	jr c, Label_3e_4159 ; $4156
	xor a, a ; $4158
Label_3e_4159:
	ld [$cb04], a ; $4159
	jr Label_3e_41a7 ; $415c
Label_3e_415e:
	bit 5, a ; $415e
	jr z, Label_3e_4177 ; $4160
	ld a, [$cb04] ; $4162
	dec a ; $4165
	add a, a ; $4166
	jr nc, Label_3e_416d ; $4167
	ld a, b ; $4169
	dec a ; $416a
	jr Label_3e_4172 ; $416b
Label_3e_416d:
	rra ; $416d
	cp a, b ; $416e
	jr c, Label_3e_4172 ; $416f
	xor a, a ; $4171
Label_3e_4172:
	ld [$cb04], a ; $4172
	jr Label_3e_41a7 ; $4175
Label_3e_4177:
	bit 6, a ; $4177
	jr z, Label_3e_4190 ; $4179
	ld a, [$cb05] ; $417b
	dec a ; $417e
	add a, a ; $417f
	jr nc, Label_3e_4186 ; $4180
	ld a, c ; $4182
	dec a ; $4183
	jr Label_3e_418b ; $4184
Label_3e_4186:
	rra ; $4186
	cp a, c ; $4187
	jr c, Label_3e_418b ; $4188
	xor a, a ; $418a
Label_3e_418b:
	ld [$cb05], a ; $418b
	jr Label_3e_41a7 ; $418e
Label_3e_4190:
	bit 7, a ; $4190
	jr z, Label_3e_41a7 ; $4192
	ld a, [$cb05] ; $4194
	inc a ; $4197
	add a, a ; $4198
	jr nc, Label_3e_419f ; $4199
	ld a, c ; $419b
	dec a ; $419c
	jr Label_3e_41a4 ; $419d
Label_3e_419f:
	rra ; $419f
	cp a, c ; $41a0
	jr c, Label_3e_41a4 ; $41a1
	xor a, a ; $41a3
Label_3e_41a4:
	ld [$cb05], a ; $41a4
Label_3e_41a7:
	ld a, [$cb04] ; $41a7
	cp a, d ; $41aa
	jr nz, Label_3e_41b5 ; $41ab
	ld a, [$cb05] ; $41ad
	cp a, e ; $41b0
	jr nz, Label_3e_41b5 ; $41b1
	xor a, a ; $41b3
	ret ; $41b4
Label_3e_41b5:
	ld a, $01 ; $41b5
	ret ; $41b7
	INCBIN "data/bank_03e/d_41b8.bin" ; $41b8, 529 bytes
Func_3e_43c9:
	ld a, [$cb05] ; $43c9
	ld b, a ; $43cc
	xor a, a ; $43cd
	inc b ; $43ce
Label_3e_43cf:
	dec b ; $43cf
	jr z, Label_3e_43d5 ; $43d0
	add a, c ; $43d2
	jr Label_3e_43cf ; $43d3
Label_3e_43d5:
	ld b, a ; $43d5
	ld a, [$cb04] ; $43d6
	add a, b ; $43d9
	ret ; $43da
	INCBIN "data/bank_03e/d_43db.bin" ; $43db, 16 bytes
Func_3e_43eb:
	ld d, $00 ; $43eb
	ld a, c ; $43ed
Label_3e_43ee:
	cp a, b ; $43ee
	jr c, Label_3e_43f5 ; $43ef
	inc d ; $43f1
	sub a, b ; $43f2
	jr Label_3e_43ee ; $43f3
Label_3e_43f5:
	ld [$cb04], a ; $43f5
	ld a, d ; $43f8
	ld [$cb05], a ; $43f9
	ret ; $43fc
	INCBIN "data/bank_03e/d_43fd.bin" ; $43fd, 62 bytes
	ret ; $443b
	INCBIN "data/bank_03e/d_443c.bin" ; $443c, 1450 bytes
	push af ; $49e6
	push bc ; $49e7
	push de ; $49e8
	push hl ; $49e9
	ldh a, [$ff96] ; $49ea
	push af ; $49ec
	call DisableLCDSafely ; $49ed
	call Func_00_1b38 ; $49f0
	call Func_3e_4a14 ; $49f3
	xor a, a ; $49f6
	ld [$cb0b], a ; $49f7
	ld a, $03 ; $49fa
	ld [$cb0c], a ; $49fc
	call EnableLCD ; $49ff
	ld c, $08 ; $4a02
	call Func_00_1d2e ; $4a04
	call Func_00_1da4 ; $4a07
	pop af ; $4a0a
	ldh [$ff96], a ; $4a0b
	ldh [rWBK], a ; $4a0d
	pop hl ; $4a0f
	pop de ; $4a10
	pop bc ; $4a11
	pop af ; $4a12
	ret ; $4a13
Func_3e_4a14:
	ld c, $11 ; $4a14
	rst Rst18 ; $4a16
	nop ; $4a17
	add hl, sp ; $4a18
	rst Rst18 ; $4a19
	halt ; $4a1a
	dec b ; $4a1b
	ld b, $11 ; $4a1c
	ld c, $10 ; $4a1e
	ld de, $9000 ; $4a20
	rst Rst18 ; $4a23
	INCBIN "data/bank_03e/d_4a24.bin" ; $4a24, 2 bytes
	ld a, $05 ; $4a26
	ldh [$ff96], a ; $4a28
	ldh [rWBK], a ; $4a2a
	ld a, $03 ; $4a2c
	ld [$c3b3], a ; $4a2e
	ld a, $00 ; $4a31
	ld [$c3b6], a ; $4a33
	ld d, $00 ; $4a36
	ld e, $0b ; $4a38
	ld b, $14 ; $4a3a
	ld c, $07 ; $4a3c
	rst Rst18 ; $4a3e
	ld a, b ; $4a3f
	dec b ; $4a40
	rst Rst18 ; $4a41
	ld a, h ; $4a42
	dec b ; $4a43
	rst Rst18 ; $4a44
	ld a, [hl] ; $4a45
	dec b ; $4a46
	ld a, $03 ; $4a47
	ldh [$ff96], a ; $4a49
	ldh [rWBK], a ; $4a4b
	rst Rst18 ; $4a4d
	adc a, h ; $4a4e
	dec b ; $4a4f
	rst Rst18 ; $4a50
	ld [bc], a ; $4a51
	add hl, sp ; $4a52
	ret ; $4a53
	push af ; $4a54
	push bc ; $4a55
	push de ; $4a56
	push hl ; $4a57
	ldh a, [$ff8c] ; $4a58
	and a, $1c ; $4a5a
	srl a ; $4a5c
	srl a ; $4a5e
	ld hl, $4a77 ; $4a60
	add a, a ; $4a63
	add a, l ; $4a64
	ld l, a ; $4a65
	jr nc, Label_3e_4a69 ; $4a66
	inc h ; $4a68
Label_3e_4a69:
	ld a, [hl+] ; $4a69
	ld h, [hl] ; $4a6a
	ld l, a ; $4a6b
	ld de, $0501 ; $4a6c
	call Func_00_05b0 ; $4a6f
	pop hl ; $4a72
	pop de ; $4a73
	pop bc ; $4a74
	pop af ; $4a75
	ret ; $4a76
	INCBIN "data/bank_03e/d_4a77.bin" ; $4a77, 300 bytes
	push bc ; $4ba3
	ld a, $03 ; $4ba4
	ldh [$ff96], a ; $4ba6
	ldh [rWBK], a ; $4ba8
	call Func_3e_4bed ; $4baa
	rst Rst18 ; $4bad
	adc a, h ; $4bae
	dec b ; $4baf
	ld a, $03 ; $4bb0
	ldh [$ff96], a ; $4bb2
	ldh [rWBK], a ; $4bb4
	pop bc ; $4bb6
	ld a, c ; $4bb7
	or a, a ; $4bb8
	jr z, Label_3e_4bc1 ; $4bb9
	cp a, $01 ; $4bbb
	jr z, Label_3e_4bce ; $4bbd
	jr Label_3e_4bdb ; $4bbf
Label_3e_4bc1:
	ld hl, $0129 ; $4bc1
	ld de, $d181 ; $4bc4
	ld c, $12 ; $4bc7
	rst Rst18 ; $4bc9
	inc e ; $4bca
	dec b ; $4bcb
	jr Label_3e_4be6 ; $4bcc
Label_3e_4bce:
	ld hl, $012a ; $4bce
	ld de, $d181 ; $4bd1
	ld c, $12 ; $4bd4
	rst Rst18 ; $4bd6
	inc e ; $4bd7
	dec b ; $4bd8
	jr Label_3e_4be6 ; $4bd9
Label_3e_4bdb:
	ld hl, $0128 ; $4bdb
	ld de, $d181 ; $4bde
	ld c, $12 ; $4be1
	rst Rst18 ; $4be3
	inc e ; $4be4
	dec b ; $4be5
Label_3e_4be6:
	rst Rst18 ; $4be6
	sub a, b ; $4be7
	dec b ; $4be8
	call Func_3e_4c06 ; $4be9
	ret ; $4bec
Func_3e_4bed:
	ld de, $d161 ; $4bed
	ld b, $12 ; $4bf0
	ld c, $01 ; $4bf2
	ld h, $03 ; $4bf4
	rst Rst18 ; $4bf6
	inc c ; $4bf7
	add hl, sp ; $4bf8
	ld de, $d181 ; $4bf9
	ld b, $12 ; $4bfc
	ld c, $05 ; $4bfe
	ld h, $20 ; $4c00
	rst Rst18 ; $4c02
	inc c ; $4c03
	add hl, sp ; $4c04
	ret ; $4c05
Func_3e_4c06:
	ld hl, $d160 ; $4c06
	ld de, $9960 ; $4c09
	ld c, $0c ; $4c0c
	call Func_00_0480 ; $4c0e
	ret ; $4c11
	ld hl, rIE ; $4c12
	res 2, [hl] ; $4c15
	ld a, $03 ; $4c17
	ldh [$ff96], a ; $4c19
	ldh [rWBK], a ; $4c1b
	ld a, b ; $4c1d
	ld [$d800], a ; $4c1e
	call DisableLCDSafely ; $4c21
	call Func_00_1b38 ; $4c24
	call Func_3e_4caf ; $4c27
	xor a, a ; $4c2a
	ld [$cb0b], a ; $4c2b
	ld a, $01 ; $4c2e
	ld hl, $4438 ; $4c30
	call Func_00_1b6a ; $4c33
	ld a, $01 ; $4c36
	ld hl, $4e0c ; $4c38
	call Func_00_1b6a ; $4c3b
	call Func_3e_4e34 ; $4c3e
	call EnableLCD ; $4c41
	ld c, $08 ; $4c44
	call Func_00_1d2e ; $4c46
	call Func_00_1da4 ; $4c49
	ld a, $01 ; $4c4c
	ld hl, $4e34 ; $4c4e
	call Func_00_1b6a ; $4c51
	ld a, $03 ; $4c54
	ldh [$ff96], a ; $4c56
	ldh [rWBK], a ; $4c58
Label_3e_4c5a:
	call Func_00_2631 ; $4c5a
	ldh a, [$ff91] ; $4c5d
	ld [$cb0d], a ; $4c5f
	bit 0, a ; $4c62
	jr nz, Label_3e_4c80 ; $4c64
	bit 1, a ; $4c66
	jr nz, Label_3e_4c9b ; $4c68
	bit 6, a ; $4c6a
	jr nz, Label_3e_4c74 ; $4c6c
	bit 7, a ; $4c6e
	jr nz, Label_3e_4c74 ; $4c70
	jr Label_3e_4c5a ; $4c72
Label_3e_4c74:
	ld a, [$cb05] ; $4c74
	xor a, $01 ; $4c77
	ld [$cb05], a ; $4c79
	rst Rst08 ; $4c7c
	ld e, [hl] ; $4c7d
	jr Label_3e_4c5a ; $4c7e
Label_3e_4c80:
	ld a, [$cb05] ; $4c80
	or a, a ; $4c83
	jr nz, Label_3e_4c9b ; $4c84
	rst Rst08 ; $4c86
	ld h, b ; $4c87
	ld hl, rIE ; $4c88
	set 2, [hl] ; $4c8b
	call Func_00_1b38 ; $4c8d
	ld c, $10 ; $4c90
	call Func_00_1d20 ; $4c92
	call Func_00_1da4 ; $4c95
	ld a, $01 ; $4c98
	ret ; $4c9a
Label_3e_4c9b:
	rst Rst08 ; $4c9b
	ld h, d ; $4c9c
	ld hl, rIE ; $4c9d
	set 2, [hl] ; $4ca0
	call Func_00_1b38 ; $4ca2
	ld c, $10 ; $4ca5
	call Func_00_1d20 ; $4ca7
	call Func_00_1da4 ; $4caa
	xor a, a ; $4cad
	ret ; $4cae
Func_3e_4caf:
	ld c, $01 ; $4caf
	ld b, $01 ; $4cb1
	call Func_3e_43eb ; $4cb3
	ld hl, $a000 ; $4cb6
	ld de, $0801 ; $4cb9
	rst Rst18 ; $4cbc
	ld b, $18 ; $4cbd
	ld a, $0a ; $4cbf
	ld [$cb6c], a ; $4cc1
	ld a, $10 ; $4cc4
	ld [$cb6b], a ; $4cc6
	ld c, $10 ; $4cc9
	rst Rst18 ; $4ccb
	nop ; $4ccc
	add hl, sp ; $4ccd
	ld a, $03 ; $4cce
	ldh [$ff96], a ; $4cd0
	ldh [rWBK], a ; $4cd2
	ld de, $d4a3 ; $4cd4
	ld b, $0e ; $4cd7
	ld c, $06 ; $4cd9
	ld h, $00 ; $4cdb
	rst Rst18 ; $4cdd
	inc c ; $4cde
	add hl, sp ; $4cdf
	ld de, $d0a3 ; $4ce0
	ld b, $0e ; $4ce3
	ld c, $06 ; $4ce5
	ld h, $20 ; $4ce7
	rst Rst18 ; $4ce9
	inc c ; $4cea
	add hl, sp ; $4ceb
	rst Rst18 ; $4cec
	halt ; $4ced
	dec b ; $4cee
	ld b, $11 ; $4cef
	ld c, $10 ; $4cf1
	ld de, $9000 ; $4cf3
	rst Rst18 ; $4cf6
	INCBIN "data/bank_03e/d_4cf7.bin" ; $4cf7, 2 bytes
	ld a, $05 ; $4cf9
	ldh [$ff96], a ; $4cfb
	ldh [rWBK], a ; $4cfd
	ld a, $03 ; $4cff
	ld [$c3b3], a ; $4d01
	ld a, $00 ; $4d04
	ld [$c3b6], a ; $4d06
	ld d, $00 ; $4d09
	ld e, $0d ; $4d0b
	ld b, $0f ; $4d0d
	ld c, $05 ; $4d0f
	rst Rst18 ; $4d11
	ld a, b ; $4d12
	dec b ; $4d13
	rst Rst18 ; $4d14
	ld a, h ; $4d15
	dec b ; $4d16
	rst Rst18 ; $4d17
	ld a, [hl] ; $4d18
	dec b ; $4d19
	ld d, $0f ; $4d1a
	ld e, $0d ; $4d1c
	ld b, $05 ; $4d1e
	ld c, $05 ; $4d20
	rst Rst18 ; $4d22
	ld a, b ; $4d23
	dec b ; $4d24
	rst Rst18 ; $4d25
	ld a, h ; $4d26
	dec b ; $4d27
	rst Rst18 ; $4d28
	ld a, [hl] ; $4d29
	dec b ; $4d2a
	rst Rst18 ; $4d2b
	inc h ; $4d2c
	add hl, sp ; $4d2d
	ld b, $01 ; $4d2e
	ld c, $01 ; $4d30
	rst Rst18 ; $4d32
	ld h, $39 ; $4d33
	rst Rst18 ; $4d35
	adc a, h ; $4d36
	dec b ; $4d37
	ld a, $03 ; $4d38
	ldh [$ff96], a ; $4d3a
	ldh [rWBK], a ; $4d3c
	ld a, [$d800] ; $4d3e
	cp a, $02 ; $4d41
	jr nz, Label_3e_4d7e ; $4d43
	ld hl, $00dd ; $4d45
	ld de, $d0c3 ; $4d48
	ld c, $0e ; $4d4b
	rst Rst18 ; $4d4d
	inc e ; $4d4e
	dec b ; $4d4f
	ld hl, $00de ; $4d50
	ld de, $d103 ; $4d53
	ld c, $0e ; $4d56
	rst Rst18 ; $4d58
	inc e ; $4d59
	dec b ; $4d5a
	ld hl, $00df ; $4d5b
	ld de, $d1c2 ; $4d5e
	ld c, $0e ; $4d61
	rst Rst18 ; $4d63
	inc e ; $4d64
	dec b ; $4d65
	ld hl, $00dc ; $4d66
	ld de, $d202 ; $4d69
	ld c, $0e ; $4d6c
	rst Rst18 ; $4d6e
	inc e ; $4d6f
	dec b ; $4d70
	ld b, $41 ; $4d71
	ld c, $14 ; $4d73
	ld de, $8000 ; $4d75
	rst Rst18 ; $4d78
	INCBIN "data/bank_03e/d_4d79.bin" ; $4d79, 5 bytes
Label_3e_4d7e:
	or a, a ; $4d7e
	jr z, Label_3e_4db9 ; $4d7f
	ld hl, $00d8 ; $4d81
	ld de, $d0c3 ; $4d84
	ld c, $0e ; $4d87
	rst Rst18 ; $4d89
	inc e ; $4d8a
	dec b ; $4d8b
	ld hl, $00d9 ; $4d8c
	ld de, $d103 ; $4d8f
	ld c, $0e ; $4d92
	rst Rst18 ; $4d94
	inc e ; $4d95
	dec b ; $4d96
	ld hl, $00db ; $4d97
	ld de, $d1c2 ; $4d9a
	ld c, $0e ; $4d9d
	rst Rst18 ; $4d9f
	inc e ; $4da0
	dec b ; $4da1
	ld hl, $00dc ; $4da2
	ld de, $d202 ; $4da5
	ld c, $0e ; $4da8
	rst Rst18 ; $4daa
	inc e ; $4dab
	dec b ; $4dac
	ld b, $45 ; $4dad
	ld c, $14 ; $4daf
	ld de, $8000 ; $4db1
	rst Rst18 ; $4db4
	INCBIN "data/bank_03e/d_4db5.bin" ; $4db5, 2 bytes
	jr Label_3e_4def ; $4db7
Label_3e_4db9:
	ld hl, $00d6 ; $4db9
	ld de, $d0c3 ; $4dbc
	ld c, $0e ; $4dbf
	rst Rst18 ; $4dc1
	inc e ; $4dc2
	dec b ; $4dc3
	ld hl, $00d7 ; $4dc4
	ld de, $d103 ; $4dc7
	ld c, $0e ; $4dca
	rst Rst18 ; $4dcc
	inc e ; $4dcd
	dec b ; $4dce
	ld hl, $00da ; $4dcf
	ld de, $d1c2 ; $4dd2
	ld c, $0e ; $4dd5
	rst Rst18 ; $4dd7
	inc e ; $4dd8
	dec b ; $4dd9
	ld hl, $00dc ; $4dda
	ld de, $d202 ; $4ddd
	ld c, $0e ; $4de0
	rst Rst18 ; $4de2
	inc e ; $4de3
	dec b ; $4de4
	ld b, $46 ; $4de5
	ld c, $14 ; $4de7
	ld de, $8000 ; $4de9
	rst Rst18 ; $4dec
	INCBIN "data/bank_03e/d_4ded.bin" ; $4ded, 2 bytes
Label_3e_4def:
	ld hl, $007a ; $4def
	ld de, $d1d0 ; $4df2
	ld c, $04 ; $4df5
	rst Rst18 ; $4df7
	inc e ; $4df8
	dec b ; $4df9
	ld hl, $007b ; $4dfa
	ld de, $d210 ; $4dfd
	ld c, $04 ; $4e00
	rst Rst18 ; $4e02
	inc e ; $4e03
	dec b ; $4e04
	rst Rst18 ; $4e05
	sub a, b ; $4e06
	dec b ; $4e07
	rst Rst18 ; $4e08
	ld [bc], a ; $4e09
	add hl, sp ; $4e0a
	ret ; $4e0b
	ld de, $7376 ; $4e0c
	ld a, [$cb05] ; $4e0f
	or a, a ; $4e12
	jr z, Label_3e_4e18 ; $4e13
	ld de, $7386 ; $4e15
Label_3e_4e18:
	call Func_3e_4e1c ; $4e18
	ret ; $4e1b
Func_3e_4e1c:
	ld c, $00 ; $4e1c
	ld b, $08 ; $4e1e
	push de ; $4e20
	call Func_00_1f51 ; $4e21
	pop de ; $4e24
	ld a, $08 ; $4e25
	add a, d ; $4e27
	ld d, a ; $4e28
	ld c, $02 ; $4e29
	ld b, $08 ; $4e2b
	call Func_00_1f51 ; $4e2d
	rst Rst18 ; $4e30
	jr z, $4e6c ; $4e31
	ret ; $4e33
Func_3e_4e34:
	ldh a, [$ff96] ; $4e34
	push af ; $4e36
	ld a, $03 ; $4e37
	ldh [$ff96], a ; $4e39
	ldh [rWBK], a ; $4e3b
	ld hl, $4e80 ; $4e3d
	ld de, $d810 ; $4e40
	ld bc, $0008 ; $4e43
	call CopyMemoryBC ; $4e46
	ldh a, [$ff8c] ; $4e49
	and a, $3c ; $4e4b
	srl a ; $4e4d
	srl a ; $4e4f
	add a, a ; $4e51
	jr nc, Label_3e_4e59 ; $4e52
	ld a, $0c ; $4e54
	dec a ; $4e56
	jr Label_3e_4e5f ; $4e57
Label_3e_4e59:
	rra ; $4e59
	cp a, $0c ; $4e5a
	jr c, Label_3e_4e5f ; $4e5c
	xor a, a ; $4e5e
Label_3e_4e5f:
	add a, a ; $4e5f
	ld hl, $4e88 ; $4e60
	add a, l ; $4e63
	ld l, a ; $4e64
	jr nc, Label_3e_4e68 ; $4e65
	inc h ; $4e67
Label_3e_4e68:
	ld a, [hl+] ; $4e68
	ld d, [hl] ; $4e69
	ld e, a ; $4e6a
	ld hl, $d814 ; $4e6b
	ld [hl], e ; $4e6e
	inc hl ; $4e6f
	ld [hl], d ; $4e70
	ld hl, $d810 ; $4e71
	ld de, $0401 ; $4e74
	call Func_00_05b0 ; $4e77
	pop af ; $4e7a
	ldh [$ff96], a ; $4e7b
	ldh [rWBK], a ; $4e7d
	ret ; $4e7f
	INCBIN "data/bank_03e/d_4e80.bin" ; $4e80, 530 bytes
Func_3e_5092:
	ld a, b ; $5092
	or a, a ; $5093
	jr z, Label_3e_50ad ; $5094
	ld c, $00 ; $5096
Label_3e_5098:
	call Func_00_2631 ; $5098
	ld b, $10 ; $509b
	rst Rst18 ; $509d
	jr nz, Label_3e_50d9 ; $509e
	ld b, $03 ; $50a0
	rst Rst18 ; $50a2
	ld e, $39 ; $50a3
	ld a, c ; $50a5
	inc a ; $50a6
	ld c, a ; $50a7
	cp a, $0c ; $50a8
	jr nz, Label_3e_5098 ; $50aa
	ret ; $50ac
Label_3e_50ad:
	ld c, $08 ; $50ad
Label_3e_50af:
	call Func_00_2631 ; $50af
	ld b, $11 ; $50b2
	rst Rst18 ; $50b4
	jr nz, Label_3e_50f0 ; $50b5
	ld b, $03 ; $50b7
	rst Rst18 ; $50b9
	ld e, $39 ; $50ba
	ld a, c ; $50bc
	dec a ; $50bd
	ld c, a ; $50be
	cp a, $ff ; $50bf
	jr nz, Label_3e_50af ; $50c1
	ret ; $50c3
Func_3e_50c4:
	ld a, b ; $50c4
	or a, a ; $50c5
	jr z, Label_3e_50df ; $50c6
	ld c, $00 ; $50c8
Label_3e_50ca:
	call Func_00_2631 ; $50ca
	ld b, $11 ; $50cd
	rst Rst18 ; $50cf
	jr nz, Label_3e_510b ; $50d0
	ld b, $03 ; $50d2
	rst Rst18 ; $50d4
	ld e, $39 ; $50d5
	ld a, c ; $50d7
	inc a ; $50d8
Label_3e_50d9:
	ld c, a ; $50d9
	cp a, $0a ; $50da
	jr nz, Label_3e_50ca ; $50dc
	ret ; $50de
Label_3e_50df:
	ld c, $0c ; $50df
Label_3e_50e1:
	call Func_00_2631 ; $50e1
	ld b, $10 ; $50e4
	rst Rst18 ; $50e6
	jr nz, $5122 ; $50e7
	ld b, $03 ; $50e9
	rst Rst18 ; $50eb
	ld e, $39 ; $50ec
	ld a, c ; $50ee
	dec a ; $50ef
Label_3e_50f0:
	ld c, a ; $50f0
	or a, a ; $50f1
	jr nz, Label_3e_50e1 ; $50f2
	ret ; $50f4
	rst Rst18 ; $50f5
	jr z, Label_3e_5131 ; $50f6
	ld c, $02 ; $50f8
	call Func_3e_43c9 ; $50fa
	push af ; $50fd
	ld hl, $5162 ; $50fe
	add a, l ; $5101
	ld l, a ; $5102
	jr nc, Label_3e_5106 ; $5103
	inc h ; $5105
Label_3e_5106:
	ld c, [hl] ; $5106
	pop af ; $5107
	ld hl, $515c ; $5108
Label_3e_510b:
	add a, a ; $510b
	add a, l ; $510c
	ld l, a ; $510d
	jr nc, Label_3e_5111 ; $510e
	inc h ; $5110
Label_3e_5111:
	ld a, [hl+] ; $5111
	ld d, [hl] ; $5112
	ld e, a ; $5113
	rst Rst18 ; $5114
	ld d, $39 ; $5115
	ld b, $08 ; $5117
	ld hl, $5132 ; $5119
	push de ; $511c
	call Func_00_1e9d ; $511d
	pop de ; $5120
	ld hl, $17f8 ; $5121
	add hl, de ; $5124
	ld d, h ; $5125
	ld e, l ; $5126
	ld hl, $5153 ; $5127
	ld b, $08 ; $512a
	ld c, $70 ; $512c
	call Func_00_1e9d ; $512e
Label_3e_5131:
	ret ; $5131
	INCBIN "data/bank_03e/d_5132.bin" ; $5132, 51 bytes
Func_3e_5165:
	push af ; $5165
	push bc ; $5166
	push de ; $5167
	push hl ; $5168
	ld a, c ; $5169
	or a, a ; $516a
	jr z, Label_3e_5171 ; $516b
	ld h, $0c ; $516d
	jr Label_3e_5173 ; $516f
Label_3e_5171:
	ld h, $0d ; $5171
Label_3e_5173:
	push hl ; $5173
	ld hl, $518e ; $5174
	ld a, b ; $5177
	add a, a ; $5178
	add a, l ; $5179
	ld l, a ; $517a
	jr nc, Label_3e_517e ; $517b
	inc h ; $517d
Label_3e_517e:
	ld a, [hl+] ; $517e
	ld d, [hl] ; $517f
	ld e, a ; $5180
	pop hl ; $5181
	ld b, $05 ; $5182
	ld c, $03 ; $5184
	rst Rst18 ; $5186
	inc c ; $5187
	add hl, sp ; $5188
	pop hl ; $5189
	pop de ; $518a
	pop bc ; $518b
	pop af ; $518c
	ret ; $518d
	INCBIN "data/bank_03e/d_518e.bin" ; $518e, 4 bytes
	rst Rst08 ; $5192
	inc bc ; $5193
	ld hl, rIE ; $5194
	res 2, [hl] ; $5197
	call Func_3e_5229 ; $5199
	ld a, $03 ; $519c
	ldh [$ff96], a ; $519e
	ldh [rWBK], a ; $51a0
	ld a, [$cb11] ; $51a2
	ld b, a ; $51a5
	call Func_3e_5092 ; $51a6
	rst Rst18 ; $51a9
	inc h ; $51aa
	add hl, sp ; $51ab
	ld b, $01 ; $51ac
	ld c, $01 ; $51ae
	rst Rst18 ; $51b0
	ld h, $39 ; $51b1
	xor a, a ; $51b3
	ld c, a ; $51b4
	ld b, $02 ; $51b5
	call Func_3e_43eb ; $51b7
	ld a, $01 ; $51ba
	ld hl, $50f5 ; $51bc
	call Func_00_1b6a ; $51bf
	call Func_3e_52b7 ; $51c2
	ld a, $03 ; $51c5
	ldh [$ff96], a ; $51c7
	ldh [rWBK], a ; $51c9
Label_3e_51cb:
	call Func_00_2631 ; $51cb
	ldh a, [$ff91] ; $51ce
	ld [$cb0d], a ; $51d0
	ld b, $02 ; $51d3
	ld c, $01 ; $51d5
	call Func_3e_413a ; $51d7
	or a, a ; $51da
	jr z, Label_3e_51e2 ; $51db
	rst Rst08 ; $51dd
	ld e, [hl] ; $51de
	call Func_3e_52b7 ; $51df
Label_3e_51e2:
	ld a, [$cb0d] ; $51e2
	bit 0, a ; $51e5
	jr nz, Label_3e_51ef ; $51e7
	bit 1, a ; $51e9
	jr nz, Label_3e_5212 ; $51eb
	jr Label_3e_51cb ; $51ed
Label_3e_51ef:
	rst Rst08 ; $51ef
	ld e, a ; $51f0
	call Func_00_1b38 ; $51f1
	ld hl, rIE ; $51f4
	set 2, [hl] ; $51f7
	ld b, $01 ; $51f9
	call Func_3e_50c4 ; $51fb
	ld a, $01 ; $51fe
	ld [$cb11], a ; $5200
	ld c, $02 ; $5203
	call Func_3e_43c9 ; $5205
	rst Rst28 ; $5208
	ldh [rTIMA], a ; $5209
	or a, a ; $520b
	jr z, Label_3e_5211 ; $520c
	rst Rst20 ; $520e
	ldh [rTIMA], a ; $520f
Label_3e_5211:
	ret ; $5211
Label_3e_5212:
	rst Rst08 ; $5212
	ld h, d ; $5213
	call Func_00_1b38 ; $5214
	ld hl, rIE ; $5217
	set 2, [hl] ; $521a
	ld b, $00 ; $521c
	call Func_3e_50c4 ; $521e
	ld a, $00 ; $5221
	ld [$cb11], a ; $5223
	ld a, $ff ; $5226
	ret ; $5228
Func_3e_5229:
	ldh a, [$ff96] ; $5229
	push af ; $522b
	ld a, $01 ; $522c
	ldh [$ff96], a ; $522e
	ldh [rWBK], a ; $5230
	ld c, $00 ; $5232
Label_3e_5234:
	ld a, c ; $5234
	add a, a ; $5235
	ld hl, $52af ; $5236
	add a, l ; $5239
	ld l, a ; $523a
	jr nc, Label_3e_523e ; $523b
	inc h ; $523d
Label_3e_523e:
	ld a, [hl+] ; $523e
	ld h, [hl] ; $523f
	ld l, a ; $5240
	push af ; $5241
	push bc ; $5242
	push de ; $5243
	push hl ; $5244
	ld de, $d000 ; $5245
	call DecompressDataFromBank ; $5248
	pop hl ; $524b
	pop de ; $524c
	pop bc ; $524d
	pop af ; $524e
	ld hl, $52b3 ; $524f
	ld a, c ; $5252
	add a, a ; $5253
	add a, l ; $5254
	ld l, a ; $5255
	jr nc, Label_3e_5259 ; $5256
	inc h ; $5258
Label_3e_5259:
	ld a, [hl+] ; $5259
	ld d, [hl] ; $525a
	ld e, a ; $525b
	ld hl, $d000 ; $525c
	push af ; $525f
	push bc ; $5260
	push de ; $5261
	push hl ; $5262
	ld bc, $0010 ; $5263
	call Func_00_0480 ; $5266
	pop hl ; $5269
	pop de ; $526a
	pop bc ; $526b
	pop af ; $526c
	ld a, c ; $526d
	inc a ; $526e
	ld c, a ; $526f
	call Func_00_2631 ; $5270
	ld a, c ; $5273
	cp a, $02 ; $5274
	jr nz, Label_3e_5234 ; $5276
	ld b, $23 ; $5278
	ld c, $10 ; $527a
	ld de, $a000 ; $527c
	rst Rst18 ; $527f
	INCBIN "data/bank_03e/d_5280.bin" ; $5280, 2 bytes
	call Func_00_2631 ; $5282
	ld b, $24 ; $5285
	ld c, $10 ; $5287
	ld de, $a100 ; $5289
	rst Rst18 ; $528c
	INCBIN "data/bank_03e/d_528d.bin" ; $528d, 2 bytes
	call Func_00_2631 ; $528f
	ld b, $1b ; $5292
	ld c, $04 ; $5294
	ld de, $a700 ; $5296
	rst Rst18 ; $5299
	INCBIN "data/bank_03e/d_529a.bin" ; $529a, 2 bytes
	call Func_00_2631 ; $529c
	call Func_00_2631 ; $529f
	ld b, $08 ; $52a2
	ld c, $10 ; $52a4
	rst Rst18 ; $52a6
	ld c, $39 ; $52a7
	pop af ; $52a9
	ldh [$ff96], a ; $52aa
	ldh [rWBK], a ; $52ac
	ret ; $52ae
	INCBIN "data/bank_03e/d_52af.bin" ; $52af, 8 bytes
Func_3e_52b7:
	ld a, $03 ; $52b7
	ldh [$ff96], a ; $52b9
	ldh [rWBK], a ; $52bb
	ld b, $00 ; $52bd
	ld c, $00 ; $52bf
Label_3e_52c1:
	call Func_3e_5165 ; $52c1
	ld a, b ; $52c4
	inc a ; $52c5
	ld b, a ; $52c6
	cp a, $03 ; $52c7
	jr nz, Label_3e_52c1 ; $52c9
	ld c, $02 ; $52cb
	call Func_3e_43c9 ; $52cd
	ld b, a ; $52d0
	ld c, $01 ; $52d1
	call Func_3e_5165 ; $52d3
	ld c, $02 ; $52d6
	call Func_3e_43c9 ; $52d8
	call Func_3e_5320 ; $52db
	ld a, $03 ; $52de
	ldh [$ff96], a ; $52e0
	ldh [rWBK], a ; $52e2
	ld de, $d1e0 ; $52e4
	ld b, $14 ; $52e7
	ld c, $01 ; $52e9
	ld h, $03 ; $52eb
	rst Rst18 ; $52ed
	inc c ; $52ee
	add hl, sp ; $52ef
	ld a, $02 ; $52f0
	ld [$d1e0], a ; $52f2
	ld a, $04 ; $52f5
	ld [$d1f3], a ; $52f7
	ld de, $d201 ; $52fa
	ld b, $12 ; $52fd
	ld c, $01 ; $52ff
	ld h, $20 ; $5301
	rst Rst18 ; $5303
	inc c ; $5304
	add hl, sp ; $5305
	call Func_3e_5355 ; $5306
	ld hl, $d4e0 ; $5309
	ld de, $b8e0 ; $530c
	ld c, $06 ; $530f
	call Func_00_0480 ; $5311
	ld hl, $d1e0 ; $5314
	ld de, $99e0 ; $5317
	ld c, $04 ; $531a
	call Func_00_0480 ; $531c
	ret ; $531f
Func_3e_5320:
	ld hl, $5333 ; $5320
	add a, a ; $5323
	add a, l ; $5324
	ld l, a ; $5325
	jr nc, Label_3e_5329 ; $5326
	inc h ; $5328
Label_3e_5329:
	ld a, [hl+] ; $5329
	ld h, [hl] ; $532a
	ld l, a ; $532b
	ld de, $0401 ; $532c
	call Func_00_05b0 ; $532f
	ret ; $5332
	INCBIN "data/bank_03e/d_5333.bin" ; $5333, 34 bytes
Func_3e_5355:
	ldh a, [$ff96] ; $5355
	push af ; $5357
	ld a, $03 ; $5358
	ldh [$ff96], a ; $535a
	ldh [rWBK], a ; $535c
	ld c, $02 ; $535e
	call Func_3e_43c9 ; $5360
	ld b, a ; $5363
	ld hl, $5384 ; $5364
	add a, a ; $5367
	add a, l ; $5368
	ld l, a ; $5369
	jr nc, Label_3e_536d ; $536a
	inc h ; $536c
Label_3e_536d:
	ld a, [hl+] ; $536d
	ld d, [hl] ; $536e
	ld e, a ; $536f
	ld a, b ; $5370
	ld hl, $00e2 ; $5371
	add a, l ; $5374
	ld l, a ; $5375
	jr nc, Label_3e_5379 ; $5376
	inc h ; $5378
Label_3e_5379:
	ld c, $20 ; $5379
	rst Rst18 ; $537b
	ld [hl], d ; $537c
	dec b ; $537d
	pop af ; $537e
	ldh [$ff96], a ; $537f
	ldh [rWBK], a ; $5381
	ret ; $5383
	INCBIN "data/bank_03e/d_5384.bin" ; $5384, 2069 bytes
	rst Rst08 ; $5b99
	inc bc ; $5b9a
	call Func_00_1b38 ; $5b9b
	ld hl, rIE ; $5b9e
	res 2, [hl] ; $5ba1
	rst Rst18 ; $5ba3
	inc h ; $5ba4
	add hl, sp ; $5ba5
	ld b, $01 ; $5ba6
	ld c, $01 ; $5ba8
	rst Rst18 ; $5baa
	ld h, $39 ; $5bab
	call Func_3e_610b ; $5bad
	ld a, $03 ; $5bb0
	ldh [$ff96], a ; $5bb2
	ldh [rWBK], a ; $5bb4
	ld a, [$cb11] ; $5bb6
	ld b, a ; $5bb9
	call Func_3e_5e2a ; $5bba
	ld a, [$cb1e] ; $5bbd
	ld c, a ; $5bc0
	ld b, $02 ; $5bc1
	call Func_3e_43eb ; $5bc3
	ld a, $01 ; $5bc6
	ld hl, $5e93 ; $5bc8
	call Func_00_1b6a ; $5bcb
	call Func_3e_5f51 ; $5bce
	ld a, $03 ; $5bd1
	ldh [$ff96], a ; $5bd3
	ldh [rWBK], a ; $5bd5
Label_3e_5bd7:
	call Func_00_2631 ; $5bd7
	ldh a, [$ff91] ; $5bda
	ld [$cb0d], a ; $5bdc
	ld b, $02 ; $5bdf
	ld c, $02 ; $5be1
	call Func_3e_413a ; $5be3
	or a, a ; $5be6
	jr z, Label_3e_5bee ; $5be7
	rst Rst08 ; $5be9
	ld e, [hl] ; $5bea
	call Func_3e_5f51 ; $5beb
Label_3e_5bee:
	ld a, [$cb0d] ; $5bee
	bit 0, a ; $5bf1
	jr nz, Label_3e_5bfb ; $5bf3
	bit 1, a ; $5bf5
	jr nz, Label_3e_5c1e ; $5bf7
	jr Label_3e_5bd7 ; $5bf9
Label_3e_5bfb:
	rst Rst08 ; $5bfb
	ld h, b ; $5bfc
	call Func_00_1b38 ; $5bfd
	ld hl, rIE ; $5c00
	set 2, [hl] ; $5c03
	ld b, $01 ; $5c05
	call Func_3e_5e62 ; $5c07
	ld a, $01 ; $5c0a
	ld [$cb11], a ; $5c0c
	ld c, $02 ; $5c0f
	call Func_3e_43c9 ; $5c11
	push af ; $5c14
	ld c, a ; $5c15
	call Func_3e_60dd ; $5c16
	pop af ; $5c19
	call Func_3e_5cfe ; $5c1a
	ret ; $5c1d
Label_3e_5c1e:
	rst Rst08 ; $5c1e
	ld h, d ; $5c1f
	call Func_00_1b38 ; $5c20
	ld hl, rIE ; $5c23
	set 2, [hl] ; $5c26
	ld b, $00 ; $5c28
	call Func_3e_5e62 ; $5c2a
	ld a, $00 ; $5c2d
	ld [$cb11], a ; $5c2f
	call Func_3e_64f8 ; $5c32
	ld a, $ff ; $5c35
	ret ; $5c37
	INCBIN "data/bank_03e/d_5c38.bin" ; $5c38, 198 bytes
Func_3e_5cfe:
	ld hl, $5d08 ; $5cfe
	add a, l ; $5d01
	ld l, a ; $5d02
	jr nc, Label_3e_5d06 ; $5d03
	inc h ; $5d05
Label_3e_5d06:
	ld a, [hl] ; $5d06
	ret ; $5d07
	INCBIN "data/bank_03e/d_5d08.bin" ; $5d08, 9 bytes
	ldh a, [$ff96] ; $5d11
	push af ; $5d13
	ld a, [$cb54] ; $5d14
	ld b, a ; $5d17
	ld a, [$cb53] ; $5d18
	or a, b ; $5d1b
	ld b, a ; $5d1c
	call Func_3e_695a ; $5d1d
	ld a, $01 ; $5d20
	ldh [$ff96], a ; $5d22
	ldh [rWBK], a ; $5d24
	ld c, $00 ; $5d26
Label_3e_5d28:
	ld a, c ; $5d28
	add a, a ; $5d29
	ld hl, $5df1 ; $5d2a
	add a, l ; $5d2d
	ld l, a ; $5d2e
	jr nc, Label_3e_5d32 ; $5d2f
	inc h ; $5d31
Label_3e_5d32:
	ld a, [hl+] ; $5d32
	ld h, [hl] ; $5d33
	ld l, a ; $5d34
	push af ; $5d35
	push bc ; $5d36
	push de ; $5d37
	push hl ; $5d38
	call Func_3e_5e17 ; $5d39
	ld de, $d000 ; $5d3c
	call DecompressDataFromBank ; $5d3f
	pop hl ; $5d42
	pop de ; $5d43
	pop bc ; $5d44
	pop af ; $5d45
	ld hl, $5e05 ; $5d46
	ld a, c ; $5d49
	add a, a ; $5d4a
	add a, l ; $5d4b
	ld l, a ; $5d4c
	jr nc, Label_3e_5d50 ; $5d4d
	inc h ; $5d4f
Label_3e_5d50:
	ld a, [hl+] ; $5d50
	ld d, [hl] ; $5d51
	ld e, a ; $5d52
	ld hl, $d000 ; $5d53
	push af ; $5d56
	push bc ; $5d57
	push de ; $5d58
	push hl ; $5d59
	ld bc, $0010 ; $5d5a
	call Func_00_0480 ; $5d5d
	pop hl ; $5d60
	pop de ; $5d61
	pop bc ; $5d62
	pop af ; $5d63
	ld a, c ; $5d64
	inc a ; $5d65
	ld c, a ; $5d66
	ld a, c ; $5d67
	cp a, $09 ; $5d68
	jr nz, Label_3e_5d28 ; $5d6a
	ld b, $65 ; $5d6c
	ld c, $12 ; $5d6e
	ld de, $a000 ; $5d70
	rst Rst18 ; $5d73
	INCBIN "data/bank_03e/d_5d74.bin" ; $5d74, 2 bytes
	ld b, $66 ; $5d76
	ld c, $12 ; $5d78
	ld de, $a100 ; $5d7a
	rst Rst18 ; $5d7d
	INCBIN "data/bank_03e/d_5d7e.bin" ; $5d7e, 2 bytes
	ld b, $67 ; $5d80
	ld c, $12 ; $5d82
	ld de, $a200 ; $5d84
	rst Rst18 ; $5d87
	INCBIN "data/bank_03e/d_5d88.bin" ; $5d88, 2 bytes
	ld b, $68 ; $5d8a
	ld c, $14 ; $5d8c
	ld de, $a300 ; $5d8e
	rst Rst18 ; $5d91
	INCBIN "data/bank_03e/d_5d92.bin" ; $5d92, 2 bytes
	ld b, $6a ; $5d94
	ld c, $12 ; $5d96
	ld de, $a420 ; $5d98
	rst Rst18 ; $5d9b
	INCBIN "data/bank_03e/d_5d9c.bin" ; $5d9c, 2 bytes
	ld b, $6b ; $5d9e
	ld c, $12 ; $5da0
	ld de, $a520 ; $5da2
	rst Rst18 ; $5da5
	INCBIN "data/bank_03e/d_5da6.bin" ; $5da6, 2 bytes
	ld b, $6c ; $5da8
	ld c, $12 ; $5daa
	ld de, $a620 ; $5dac
	rst Rst18 ; $5daf
	INCBIN "data/bank_03e/d_5db0.bin" ; $5db0, 2 bytes
	ld b, $6d ; $5db2
	ld c, $12 ; $5db4
	ld de, $8200 ; $5db6
	rst Rst18 ; $5db9
	INCBIN "data/bank_03e/d_5dba.bin" ; $5dba, 2 bytes
	ld b, $6e ; $5dbc
	ld c, $12 ; $5dbe
	ld de, $8300 ; $5dc0
	rst Rst18 ; $5dc3
	INCBIN "data/bank_03e/d_5dc4.bin" ; $5dc4, 2 bytes
	ld b, $6f ; $5dc6
	ld c, $12 ; $5dc8
	ld de, $8400 ; $5dca
	rst Rst18 ; $5dcd
	INCBIN "data/bank_03e/d_5dce.bin" ; $5dce, 2 bytes
	ld b, $1b ; $5dd0
	ld c, $04 ; $5dd2
	ld de, $a720 ; $5dd4
	rst Rst18 ; $5dd7
	INCBIN "data/bank_03e/d_5dd8.bin" ; $5dd8, 2 bytes
	ld b, $40 ; $5dda
	ld c, $14 ; $5ddc
	ld de, $8000 ; $5dde
	rst Rst18 ; $5de1
	INCBIN "data/bank_03e/d_5de2.bin" ; $5de2, 2 bytes
	ld b, $08 ; $5de4
	ld c, $10 ; $5de6
	rst Rst18 ; $5de8
	ld c, $39 ; $5de9
	pop af ; $5deb
	ldh [$ff96], a ; $5dec
	ldh [rWBK], a ; $5dee
	ret ; $5df0
	INCBIN "data/bank_03e/d_5df1.bin" ; $5df1, 38 bytes
Func_3e_5e17:
	push af ; $5e17
	push bc ; $5e18
	push de ; $5e19
	ld b, c ; $5e1a
	push hl ; $5e1b
	call Func_3e_697b ; $5e1c
	or a, a ; $5e1f
	pop hl ; $5e20
	jr nz, Label_3e_5e26 ; $5e21
	ld hl, $3f14 ; $5e23
Label_3e_5e26:
	pop de ; $5e26
	pop bc ; $5e27
	pop af ; $5e28
	ret ; $5e29
Func_3e_5e2a:
	ld a, b ; $5e2a
	or a, a ; $5e2b
	jr z, Label_3e_5e48 ; $5e2c
	ld c, $00 ; $5e2e
Label_3e_5e30:
	call Func_00_2631 ; $5e30
	ld b, $12 ; $5e33
	rst Rst18 ; $5e35
	jr nz, $5e71 ; $5e36
	ld b, $02 ; $5e38
	rst Rst18 ; $5e3a
	ld e, $39 ; $5e3b
	ld a, c ; $5e3d
	inc a ; $5e3e
	ld c, a ; $5e3f
	cp a, $0d ; $5e40
	jr nz, Label_3e_5e30 ; $5e42
	call Func_00_2631 ; $5e44
	ret ; $5e47
Label_3e_5e48:
	ld c, $0a ; $5e48
Label_3e_5e4a:
	call Func_00_2631 ; $5e4a
	ld b, $13 ; $5e4d
	rst Rst18 ; $5e4f
	jr nz, $5e8b ; $5e50
	ld b, $02 ; $5e52
	rst Rst18 ; $5e54
	ld e, $39 ; $5e55
	ld a, c ; $5e57
	dec a ; $5e58
	ld c, a ; $5e59
	cp a, $ff ; $5e5a
	jr nz, Label_3e_5e4a ; $5e5c
	call Func_00_2631 ; $5e5e
	ret ; $5e61
Func_3e_5e62:
	ld a, b ; $5e62
	or a, a ; $5e63
	jr z, Label_3e_5e7d ; $5e64
	ld c, $00 ; $5e66
Label_3e_5e68:
	call Func_00_2631 ; $5e68
	ld b, $13 ; $5e6b
	rst Rst18 ; $5e6d
	jr nz, $5ea9 ; $5e6e
	ld b, $02 ; $5e70
	rst Rst18 ; $5e72
	ld e, $39 ; $5e73
	ld a, c ; $5e75
	inc a ; $5e76
	ld c, a ; $5e77
	cp a, $0b ; $5e78
	jr nz, Label_3e_5e68 ; $5e7a
	ret ; $5e7c
Label_3e_5e7d:
	ld c, $0c ; $5e7d
Label_3e_5e7f:
	call Func_00_2631 ; $5e7f
	ld b, $12 ; $5e82
	rst Rst18 ; $5e84
	jr nz, Label_3e_5ec0 ; $5e85
	ld b, $02 ; $5e87
	rst Rst18 ; $5e89
	ld e, $39 ; $5e8a
	ld a, c ; $5e8c
	dec a ; $5e8d
	ld c, a ; $5e8e
	or a, a ; $5e8f
	jr nz, Label_3e_5e7f ; $5e90
	ret ; $5e92
	rst Rst18 ; $5e93
	jr z, $5ecf ; $5e94
	ld c, $02 ; $5e96
	call Func_3e_43c9 ; $5e98
	push af ; $5e9b
	ld hl, $5f49 ; $5e9c
	add a, l ; $5e9f
	ld l, a ; $5ea0
	jr nc, Label_3e_5ea4 ; $5ea1
	inc h ; $5ea3
Label_3e_5ea4:
	ld c, [hl] ; $5ea4
	pop af ; $5ea5
	push af ; $5ea6
	ld hl, $5f41 ; $5ea7
	add a, a ; $5eaa
	add a, l ; $5eab
	ld l, a ; $5eac
	jr nc, Label_3e_5eb0 ; $5ead
	inc h ; $5eaf
Label_3e_5eb0:
	ld a, [hl+] ; $5eb0
	ld d, [hl] ; $5eb1
	ld e, a ; $5eb2
	rst Rst18 ; $5eb3
	ld d, $39 ; $5eb4
	ld b, [hl] ; $5eb6
	pop af ; $5eb7
	add a, a ; $5eb8
	ld hl, $5eea ; $5eb9
	add a, l ; $5ebc
	ld l, a ; $5ebd
	jr nc, Label_3e_5ec1 ; $5ebe
Label_3e_5ec0:
	inc h ; $5ec0
Label_3e_5ec1:
	ld a, [hl+] ; $5ec1
	ld h, [hl] ; $5ec2
	ld l, a ; $5ec3
	ld b, $08 ; $5ec4
	push de ; $5ec6
	call Func_00_1e9d ; $5ec7
	pop de ; $5eca
	ld c, $02 ; $5ecb
	call Func_3e_43c9 ; $5ecd
	ld hl, $5f4d ; $5ed0
	add a, l ; $5ed3
	ld l, a ; $5ed4
	jr nc, Label_3e_5ed8 ; $5ed5
	inc h ; $5ed7
Label_3e_5ed8:
	ld a, [hl] ; $5ed8
	ld h, a ; $5ed9
	ld l, $f8 ; $5eda
	add hl, de ; $5edc
	ld d, h ; $5edd
	ld e, l ; $5ede
	ld hl, $5f38 ; $5edf
	ld b, $08 ; $5ee2
	ld c, $72 ; $5ee4
	call Func_00_1e9d ; $5ee6
	ret ; $5ee9
	INCBIN "data/bank_03e/d_5eea.bin" ; $5eea, 103 bytes
Func_3e_5f51:
	ld a, $03 ; $5f51
	ldh [$ff96], a ; $5f53
	ldh [rWBK], a ; $5f55
	ld b, $00 ; $5f57
	ld c, $00 ; $5f59
Label_3e_5f5b:
	call Func_3e_5fad ; $5f5b
	ld a, b ; $5f5e
	inc a ; $5f5f
	ld b, a ; $5f60
	cp a, $04 ; $5f61
	jr nz, Label_3e_5f5b ; $5f63
	ld c, $02 ; $5f65
	call Func_3e_43c9 ; $5f67
	ld b, a ; $5f6a
	ld c, $01 ; $5f6b
	call Func_3e_5fad ; $5f6d
	ld c, $02 ; $5f70
	call Func_3e_43c9 ; $5f72
	call Func_3e_5fde ; $5f75
	ld c, $02 ; $5f78
	call Func_3e_43c9 ; $5f7a
	ld d, a ; $5f7d
	ld b, a ; $5f7e
	call Func_3e_697b ; $5f7f
	or a, a ; $5f82
	ld b, $ff ; $5f83
	jr z, Label_3e_5f88 ; $5f85
	ld b, d ; $5f87
Label_3e_5f88:
	call Func_3e_648f ; $5f88
	ld hl, $d480 ; $5f8b
	ld de, $b880 ; $5f8e
	ld c, $06 ; $5f91
	call Func_00_0480 ; $5f93
	ld hl, $d520 ; $5f96
	ld de, $b920 ; $5f99
	ld c, $06 ; $5f9c
	call Func_00_0480 ; $5f9e
	ld hl, $d200 ; $5fa1
	ld de, $9a00 ; $5fa4
	ld c, $02 ; $5fa7
	call Func_00_0480 ; $5fa9
	ret ; $5fac
Func_3e_5fad:
	push af ; $5fad
	push bc ; $5fae
	push de ; $5faf
	push hl ; $5fb0
	ld a, c ; $5fb1
	or a, a ; $5fb2
	jr z, Label_3e_5fb9 ; $5fb3
	ld h, $0c ; $5fb5
	jr Label_3e_5fbb ; $5fb7
Label_3e_5fb9:
	ld h, $0d ; $5fb9
Label_3e_5fbb:
	push hl ; $5fbb
	ld hl, $5fd6 ; $5fbc
	ld a, b ; $5fbf
	add a, a ; $5fc0
	add a, l ; $5fc1
	ld l, a ; $5fc2
	jr nc, Label_3e_5fc6 ; $5fc3
	inc h ; $5fc5
Label_3e_5fc6:
	ld a, [hl+] ; $5fc6
	ld d, [hl] ; $5fc7
	ld e, a ; $5fc8
	pop hl ; $5fc9
	ld b, $05 ; $5fca
	ld c, $03 ; $5fcc
	rst Rst18 ; $5fce
	inc c ; $5fcf
	add hl, sp ; $5fd0
	pop hl ; $5fd1
	pop de ; $5fd2
	pop bc ; $5fd3
	pop af ; $5fd4
	ret ; $5fd5
	INCBIN "data/bank_03e/d_5fd6.bin" ; $5fd6, 8 bytes
Func_3e_5fde:
	ld hl, $5ff1 ; $5fde
	add a, a ; $5fe1
	add a, l ; $5fe2
	ld l, a ; $5fe3
	jr nc, Label_3e_5fe7 ; $5fe4
	inc h ; $5fe6
Label_3e_5fe7:
	ld a, [hl+] ; $5fe7
	ld h, [hl] ; $5fe8
	ld l, a ; $5fe9
	ld de, $0401 ; $5fea
	call Func_00_05b0 ; $5fed
	ret ; $5ff0
	INCBIN "data/bank_03e/d_5ff1.bin" ; $5ff1, 236 bytes
Func_3e_60dd:
	ld a, c ; $60dd
	ld hl, $60eb ; $60de
	add a, l ; $60e1
	ld l, a ; $60e2
	jr nc, Label_3e_60e6 ; $60e3
	inc h ; $60e5
Label_3e_60e6:
	ld a, [hl] ; $60e6
	ld [$c8f8], a ; $60e7
	ret ; $60ea
	INCBIN "data/bank_03e/d_60eb.bin" ; $60eb, 32 bytes
Func_3e_610b:
	call Func_3e_617a ; $610b
	call Func_3e_6118 ; $610e
	call Func_3e_615f ; $6111
	call Func_00_2631 ; $6114
	ret ; $6117
Func_3e_6118:
	ldh a, [$ff96] ; $6118
	push af ; $611a
	ld a, $03 ; $611b
	ldh [$ff96], a ; $611d
	ldh [rWBK], a ; $611f
	ld a, $12 ; $6121
	ld hl, $d201 ; $6123
	ld c, $20 ; $6126
Label_3e_6128:
	ld [hl], c ; $6128
	inc hl ; $6129
	dec a ; $612a
	jr nz, Label_3e_6128 ; $612b
	call Func_3e_6139 ; $612d
	call Func_3e_6154 ; $6130
	pop af ; $6133
	ldh [$ff96], a ; $6134
	ldh [rWBK], a ; $6136
	ret ; $6138
Func_3e_6139:
	ld b, $30 ; $6139
	ld hl, $d1e0 ; $613b
	ld c, $04 ; $613e
	rst Rst18 ; $6140
	ld a, h ; $6141
	add hl, sp ; $6142
	ld hl, $d200 ; $6143
	ld c, $04 ; $6146
	rst Rst18 ; $6148
	ld a, h ; $6149
	add hl, sp ; $614a
	ld hl, $d220 ; $614b
	ld c, $04 ; $614e
	rst Rst18 ; $6150
	ld a, h ; $6151
	add hl, sp ; $6152
	ret ; $6153
Func_3e_6154:
	ld b, $40 ; $6154
	ld hl, $d209 ; $6156
	ld c, $05 ; $6159
	rst Rst18 ; $615b
	ld a, h ; $615c
	add hl, sp ; $615d
	ret ; $615e
Func_3e_615f:
	ldh a, [$ff96] ; $615f
	push af ; $6161
	ld a, $03 ; $6162
	ldh [$ff96], a ; $6164
	ldh [rWBK], a ; $6166
	ld hl, $d1e0 ; $6168
	ld de, $99e0 ; $616b
	ld bc, $0006 ; $616e
	call Func_00_0480 ; $6171
	pop af ; $6174
	ldh [$ff96], a ; $6175
	ldh [rWBK], a ; $6177
	ret ; $6179
Func_3e_617a:
	ldh a, [$ff96] ; $617a
	push af ; $617c
	ld a, $01 ; $617d
	ldh [$ff96], a ; $617f
	ldh [rWBK], a ; $6181
	call Func_3e_6192 ; $6183
	call Func_3e_61a8 ; $6186
	call Func_3e_61be ; $6189
	pop af ; $618c
	ldh [$ff96], a ; $618d
	ldh [rWBK], a ; $618f
	ret ; $6191
Func_3e_6192:
	ld hl, $61d4 ; $6192
	ld de, $d000 ; $6195
	call DecompressData ; $6198
	ld hl, $d000 ; $619b
	ld de, $9300 ; $619e
	ld bc, $000c ; $61a1
	call Func_00_0480 ; $61a4
	ret ; $61a7
Func_3e_61a8:
	ld hl, $6273 ; $61a8
	ld de, $d100 ; $61ab
	call DecompressData ; $61ae
	ld hl, $d100 ; $61b1
	ld de, $9400 ; $61b4
	ld bc, $0005 ; $61b7
	call Func_00_0480 ; $61ba
	ret ; $61bd
Func_3e_61be:
	ld hl, $62c6 ; $61be
	ld de, $d200 ; $61c1
	call DecompressData ; $61c4
	ld hl, $d200 ; $61c7
	ld de, $8800 ; $61ca
	ld bc, $0037 ; $61cd
	call Func_00_0480 ; $61d0
	ret ; $61d3
	INCBIN "data/bank_03e/d_61d4.bin" ; $61d4, 699 bytes
Func_3e_648f:
	ldh a, [$ff96] ; $648f
	push af ; $6491
	ld a, $03 ; $6492
	ldh [$ff96], a ; $6494
	ldh [rWBK], a ; $6496
	push bc ; $6498
	call Func_3e_64a6 ; $6499
	pop bc ; $649c
	call Func_3e_64cf ; $649d
	pop af ; $64a0
	ldh [$ff96], a ; $64a1
	ldh [rWBK], a ; $64a3
	ret ; $64a5
Func_3e_64a6:
	ld a, b ; $64a6
	cp a, $ff ; $64a7
	jr nz, Label_3e_64af ; $64a9
	ld b, $ac ; $64ab
	jr Label_3e_64bd ; $64ad
Label_3e_64af:
	ld hl, $64c6 ; $64af
	ld a, b ; $64b2
	add a, l ; $64b3
	ld l, a ; $64b4
	jr nc, Label_3e_64b8 ; $64b5
	inc h ; $64b7
Label_3e_64b8:
	ld a, [hl] ; $64b8
	ld b, $80 ; $64b9
	add a, b ; $64bb
	ld b, a ; $64bc
Label_3e_64bd:
	ld hl, $d204 ; $64bd
	ld c, $05 ; $64c0
	rst Rst18 ; $64c2
	ld a, h ; $64c3
	add hl, sp ; $64c4
	ret ; $64c5
	INCBIN "data/bank_03e/d_64c6.bin" ; $64c6, 9 bytes
Func_3e_64cf:
	ld a, b ; $64cf
	cp a, $ff ; $64d0
	jr nz, Label_3e_64d8 ; $64d2
	ld b, $b1 ; $64d4
	jr Label_3e_64e6 ; $64d6
Label_3e_64d8:
	ld hl, $64ef ; $64d8
	ld a, b ; $64db
	add a, l ; $64dc
	ld l, a ; $64dd
	jr nc, Label_3e_64e1 ; $64de
	inc h ; $64e0
Label_3e_64e1:
	ld a, [hl] ; $64e1
	ld b, $80 ; $64e2
	add a, b ; $64e4
	ld b, a ; $64e5
Label_3e_64e6:
	ld hl, $d20e ; $64e6
	ld c, $06 ; $64e9
	rst Rst18 ; $64eb
	ld a, h ; $64ec
	add hl, sp ; $64ed
	ret ; $64ee
	INCBIN "data/bank_03e/d_64ef.bin" ; $64ef, 9 bytes
Func_3e_64f8:
	ldh a, [$ff96] ; $64f8
	push af ; $64fa
	ld a, $03 ; $64fb
	ldh [$ff96], a ; $64fd
	ldh [rWBK], a ; $64ff
	ld c, $10 ; $6501
	call Func_00_1d20 ; $6503
	call Func_00_1da4 ; $6506
	call DisableLCDSafely ; $6509
	rst Rst18 ; $650c
	ld a, [bc] ; $650d
	ld bc, $22df ; $650e
	add hl, sp ; $6511
	pop af ; $6512
	ldh [$ff96], a ; $6513
	ldh [rWBK], a ; $6515
	ret ; $6517
	INCBIN "data/bank_03e/d_6518.bin" ; $6518, 1090 bytes
Func_3e_695a:
	ldh a, [$ff96] ; $695a
	push af ; $695c
	ld a, $02 ; $695d
	ldh [$ff96], a ; $695f
	ldh [rWBK], a ; $6961
	ld c, $00 ; $6963
	ld hl, $d000 ; $6965
Label_3e_6968:
	ld a, b ; $6968
	and a, $01 ; $6969
	ld [hl+], a ; $696b
	srl b ; $696c
	ld a, c ; $696e
	inc a ; $696f
	ld c, a ; $6970
	cp a, $05 ; $6971
	jr nz, Label_3e_6968 ; $6973
	pop af ; $6975
	ldh [$ff96], a ; $6976
	ldh [rWBK], a ; $6978
	ret ; $697a
Func_3e_697b:
	ld a, b ; $697b
	cp a, $04 ; $697c
	jr nc, Label_3e_6983 ; $697e
	ld a, $01 ; $6980
	ret ; $6982
Label_3e_6983:
	ldh a, [$ff96] ; $6983
	push af ; $6985
	ld a, $02 ; $6986
	ldh [$ff96], a ; $6988
	ldh [rWBK], a ; $698a
	ld a, b ; $698c
	sub a, $04 ; $698d
	ld hl, $d000 ; $698f
	add a, l ; $6992
	ld l, a ; $6993
	jr nc, Label_3e_6997 ; $6994
	inc h ; $6996
Label_3e_6997:
	ld a, [hl] ; $6997
	ld b, a ; $6998
	pop af ; $6999
	ldh [$ff96], a ; $699a
	ldh [rWBK], a ; $699c
	ld a, b ; $699e
	ret ; $699f
	ld c, $00 ; $69a0
	ld b, $00 ; $69a2
Label_3e_69a4:
	ld a, c ; $69a4
	add a, a ; $69a5
	ld hl, $69ca ; $69a6
	add a, l ; $69a9
	ld l, a ; $69aa
	jr nc, Label_3e_69ae ; $69ab
	inc h ; $69ad
Label_3e_69ae:
	ld a, [hl+] ; $69ae
	ld d, [hl] ; $69af
	ld e, a ; $69b0
	rst Rst18 ; $69b1
	inc e ; $69b2
	inc bc ; $69b3
	jr z, Label_3e_69ba ; $69b4
	ld a, $01 ; $69b6
	or a, b ; $69b8
	ld b, a ; $69b9
Label_3e_69ba:
	ld a, c ; $69ba
	inc a ; $69bb
	ld c, a ; $69bc
	cp a, $05 ; $69bd
	jr z, Label_3e_69c5 ; $69bf
	sla b ; $69c1
	jr Label_3e_69a4 ; $69c3
Label_3e_69c5:
	ld a, b ; $69c5
	ld [$cb54], a ; $69c6
	ret ; $69c9
	INCBIN "data/bank_03e/d_69ca.bin" ; $69ca, 10 bytes
	ret ; $69d4
	INCBIN "data/bank_03e/d_69d5.bin" ; $69d5, 5675 bytes
