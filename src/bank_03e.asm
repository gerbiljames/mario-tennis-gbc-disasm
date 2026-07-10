INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $3e", ROMX[$4000], BANK[$3e]

	INCBIN "data/bank_03e/d_4000.bin" ; $4000, 4 bytes
FarPtr_3e_04:
	dw Func_3e_49e6 ; $4004
FarPtr_3e_06:
	dw Func_3e_4c12 ; $4006
FarPtr_3e_08:
	dw Func_3e_4ea0 ; $4008
FarPtr_3e_0a:
	dw Func_3e_5192 ; $400a
FarPtr_3e_0c:
	dw Func_3e_54bd ; $400c
FarPtr_3e_0e:
	dw Func_3e_5645 ; $400e
FarPtr_3e_10:
	dw Func_3e_5388 ; $4010
FarPtr_3e_12:
	dw Func_3e_4aa7 ; $4012
	INCBIN "data/bank_03e/d_4014.bin" ; $4014, 2 bytes
FarPtr_3e_16:
	dw Func_3e_4a54 ; $4016
FarPtr_3e_18:
	dw Func_3e_5b99 ; $4018
	INCBIN "data/bank_03e/d_401a.bin" ; $401a, 2 bytes
FarPtr_3e_1c:
	dw Func_3e_6518 ; $401c
	INCBIN "data/bank_03e/d_401e.bin" ; $401e, 2 bytes
FarPtr_3e_20:
	dw Func_3e_5d11 ; $4020
FarPtr_3e_22:
	dw Func_3e_69a0 ; $4022
FarPtr_3e_24:
	dw Func_3e_69d4 ; $4024
FarPtr_3e_26:
	dw Func_3e_5092 ; $4026
FarPtr_3e_28:
	dw Func_3e_50c4 ; $4028
FarPtr_3e_2a:
	dw Func_3e_5e2a ; $402a
FarPtr_3e_2c:
	dw Func_3e_5e62 ; $402c
FarPtr_3e_2e:
	dw Func_3e_5fad ; $402e
FarPtr_3e_30:
	dw Func_3e_4ba3 ; $4030
	INCBIN "data/bank_03e/d_4032.bin" ; $4032, 264 bytes
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
Func_3e_49e6:
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
	farcall FarPtr_39_00 ; $4a16
	farcall FarPtr_05_76 ; $4a19
	ld b, $11 ; $4a1c
	ld c, $10 ; $4a1e
	ld de, $9000 ; $4a20
	farcall FarPtr_39_10 ; $4a23
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
	farcall FarPtr_05_78 ; $4a3e
	farcall FarPtr_05_7c ; $4a41
	farcall FarPtr_05_7e ; $4a44
	ld a, $03 ; $4a47
	ldh [$ff96], a ; $4a49
	ldh [rWBK], a ; $4a4b
	farcall FarPtr_05_8c ; $4a4d
	farcall FarPtr_39_02 ; $4a50
	ret ; $4a53
Func_3e_4a54:
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
	INCBIN "data/bank_03e/d_4a77.bin" ; $4a77, 48 bytes
Func_3e_4aa7:
	call Func_00_28b9 ; $4aa7
	call DisableLCDSafely ; $4aaa
	call Func_00_1b38 ; $4aad
	call Func_00_1e3d ; $4ab0
	xor a, a ; $4ab3
	ldh [$ff8b], a ; $4ab4
	ldh [$ff8a], a ; $4ab6
	call Func_3e_4ade ; $4ab8
	xor a, a ; $4abb
	ld [$cb0b], a ; $4abc
	ld a, $05 ; $4abf
	ld [$cb0c], a ; $4ac1
	call EnableLCD ; $4ac4
	ld c, $08 ; $4ac7
	call Func_00_1d2e ; $4ac9
	call Func_00_1da4 ; $4acc
Label_3e_4acf:
	call Func_00_2631 ; $4acf
	call Func_3e_4b37 ; $4ad2
	ldh a, [$ff94] ; $4ad5
	or a, a ; $4ad7
	jr z, Label_3e_4acf ; $4ad8
	call Func_00_1b38 ; $4ada
	ret ; $4add
Func_3e_4ade:
	ld c, $22 ; $4ade
	farcall FarPtr_39_00 ; $4ae0
	farcall FarPtr_05_76 ; $4ae3
	ld b, $11 ; $4ae6
	ld c, $10 ; $4ae8
	ld de, $9000 ; $4aea
	farcall FarPtr_39_10 ; $4aed
	ld a, $05 ; $4af0
	ldh [$ff96], a ; $4af2
	ldh [rWBK], a ; $4af4
	ld a, $03 ; $4af6
	ld [$c3b3], a ; $4af8
	ld a, $00 ; $4afb
	ld [$c3b6], a ; $4afd
	ld d, $00 ; $4b00
	ld e, $0d ; $4b02
	ld b, $14 ; $4b04
	ld c, $05 ; $4b06
	farcall FarPtr_05_78 ; $4b08
	farcall FarPtr_05_7c ; $4b0b
	farcall FarPtr_05_7e ; $4b0e
	farcall FarPtr_05_8c ; $4b11
	ld a, $03 ; $4b14
	ldh [$ff96], a ; $4b16
	ldh [rWBK], a ; $4b18
	ld hl, $012b ; $4b1a
	ld de, $d1c1 ; $4b1d
	ld c, $12 ; $4b20
	farcall FarPtr_05_1c ; $4b22
	ld hl, $012c ; $4b25
	ld de, $d201 ; $4b28
	ld c, $12 ; $4b2b
	farcall FarPtr_05_1c ; $4b2d
	farcall FarPtr_05_90 ; $4b30
	farcall FarPtr_39_02 ; $4b33
	ret ; $4b36
Func_3e_4b37:
	ldh a, [$ff96] ; $4b37
	push af ; $4b39
	ld a, $03 ; $4b3a
	ldh [$ff96], a ; $4b3c
	ldh [rWBK], a ; $4b3e
	ld hl, $4b83 ; $4b40
	ld de, $d800 ; $4b43
	ld bc, $0008 ; $4b46
	call CopyMemoryBC ; $4b49
	ldh a, [$ff8c] ; $4b4c
	and a, $3c ; $4b4e
	srl a ; $4b50
	srl a ; $4b52
	add a, a ; $4b54
	jr nc, Label_3e_4b5c ; $4b55
	ld a, $0c ; $4b57
	dec a ; $4b59
	jr Label_3e_4b62 ; $4b5a
Label_3e_4b5c:
	rra ; $4b5c
	cp a, $0c ; $4b5d
	jr c, Label_3e_4b62 ; $4b5f
	xor a, a ; $4b61
Label_3e_4b62:
	add a, a ; $4b62
	ld hl, $4b8b ; $4b63
	add a, l ; $4b66
	ld l, a ; $4b67
	jr nc, Label_3e_4b6b ; $4b68
	inc h ; $4b6a
Label_3e_4b6b:
	ld a, [hl+] ; $4b6b
	ld d, [hl] ; $4b6c
	ld e, a ; $4b6d
	ld hl, $d802 ; $4b6e
	ld [hl], e ; $4b71
	inc hl ; $4b72
	ld [hl], d ; $4b73
	ld hl, $d800 ; $4b74
	ld de, $0301 ; $4b77
	call Func_00_05b0 ; $4b7a
	pop af ; $4b7d
	ldh [$ff96], a ; $4b7e
	ldh [rWBK], a ; $4b80
	ret ; $4b82
	INCBIN "data/bank_03e/d_4b83.bin" ; $4b83, 32 bytes
Func_3e_4ba3:
	push bc ; $4ba3
	ld a, $03 ; $4ba4
	ldh [$ff96], a ; $4ba6
	ldh [rWBK], a ; $4ba8
	call Func_3e_4bed ; $4baa
	farcall FarPtr_05_8c ; $4bad
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
	farcall FarPtr_05_1c ; $4bc9
	jr Label_3e_4be6 ; $4bcc
Label_3e_4bce:
	ld hl, $012a ; $4bce
	ld de, $d181 ; $4bd1
	ld c, $12 ; $4bd4
	farcall FarPtr_05_1c ; $4bd6
	jr Label_3e_4be6 ; $4bd9
Label_3e_4bdb:
	ld hl, $0128 ; $4bdb
	ld de, $d181 ; $4bde
	ld c, $12 ; $4be1
	farcall FarPtr_05_1c ; $4be3
Label_3e_4be6:
	farcall FarPtr_05_90 ; $4be6
	call Func_3e_4c06 ; $4be9
	ret ; $4bec
Func_3e_4bed:
	ld de, $d161 ; $4bed
	ld b, $12 ; $4bf0
	ld c, $01 ; $4bf2
	ld h, $03 ; $4bf4
	farcall FarPtr_39_0c ; $4bf6
	ld de, $d181 ; $4bf9
	ld b, $12 ; $4bfc
	ld c, $05 ; $4bfe
	ld h, $20 ; $4c00
	farcall FarPtr_39_0c ; $4c02
	ret ; $4c05
Func_3e_4c06:
	ld hl, $d160 ; $4c06
	ld de, $9960 ; $4c09
	ld c, $0c ; $4c0c
	call Func_00_0480 ; $4c0e
	ret ; $4c11
Func_3e_4c12:
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
	farcall FarPtr_18_06 ; $4cbc
	ld a, $0a ; $4cbf
	ld [$cb6c], a ; $4cc1
	ld a, $10 ; $4cc4
	ld [$cb6b], a ; $4cc6
	ld c, $10 ; $4cc9
	farcall FarPtr_39_00 ; $4ccb
	ld a, $03 ; $4cce
	ldh [$ff96], a ; $4cd0
	ldh [rWBK], a ; $4cd2
	ld de, $d4a3 ; $4cd4
	ld b, $0e ; $4cd7
	ld c, $06 ; $4cd9
	ld h, $00 ; $4cdb
	farcall FarPtr_39_0c ; $4cdd
	ld de, $d0a3 ; $4ce0
	ld b, $0e ; $4ce3
	ld c, $06 ; $4ce5
	ld h, $20 ; $4ce7
	farcall FarPtr_39_0c ; $4ce9
	farcall FarPtr_05_76 ; $4cec
	ld b, $11 ; $4cef
	ld c, $10 ; $4cf1
	ld de, $9000 ; $4cf3
	farcall FarPtr_39_10 ; $4cf6
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
	farcall FarPtr_05_78 ; $4d11
	farcall FarPtr_05_7c ; $4d14
	farcall FarPtr_05_7e ; $4d17
	ld d, $0f ; $4d1a
	ld e, $0d ; $4d1c
	ld b, $05 ; $4d1e
	ld c, $05 ; $4d20
	farcall FarPtr_05_78 ; $4d22
	farcall FarPtr_05_7c ; $4d25
	farcall FarPtr_05_7e ; $4d28
	farcall FarPtr_39_24 ; $4d2b
	ld b, $01 ; $4d2e
	ld c, $01 ; $4d30
	farcall FarPtr_39_26 ; $4d32
	farcall FarPtr_05_8c ; $4d35
	ld a, $03 ; $4d38
	ldh [$ff96], a ; $4d3a
	ldh [rWBK], a ; $4d3c
	ld a, [$d800] ; $4d3e
	cp a, $02 ; $4d41
	jr nz, Label_3e_4d7e ; $4d43
	ld hl, $00dd ; $4d45
	ld de, $d0c3 ; $4d48
	ld c, $0e ; $4d4b
	farcall FarPtr_05_1c ; $4d4d
	ld hl, $00de ; $4d50
	ld de, $d103 ; $4d53
	ld c, $0e ; $4d56
	farcall FarPtr_05_1c ; $4d58
	ld hl, $00df ; $4d5b
	ld de, $d1c2 ; $4d5e
	ld c, $0e ; $4d61
	farcall FarPtr_05_1c ; $4d63
	ld hl, $00dc ; $4d66
	ld de, $d202 ; $4d69
	ld c, $0e ; $4d6c
	farcall FarPtr_05_1c ; $4d6e
	ld b, $41 ; $4d71
	ld c, $14 ; $4d73
	ld de, $8000 ; $4d75
	farcall FarPtr_39_10 ; $4d78
	jp Label_3e_4def ; $4d7b
Label_3e_4d7e:
	or a, a ; $4d7e
	jr z, Label_3e_4db9 ; $4d7f
	ld hl, $00d8 ; $4d81
	ld de, $d0c3 ; $4d84
	ld c, $0e ; $4d87
	farcall FarPtr_05_1c ; $4d89
	ld hl, $00d9 ; $4d8c
	ld de, $d103 ; $4d8f
	ld c, $0e ; $4d92
	farcall FarPtr_05_1c ; $4d94
	ld hl, $00db ; $4d97
	ld de, $d1c2 ; $4d9a
	ld c, $0e ; $4d9d
	farcall FarPtr_05_1c ; $4d9f
	ld hl, $00dc ; $4da2
	ld de, $d202 ; $4da5
	ld c, $0e ; $4da8
	farcall FarPtr_05_1c ; $4daa
	ld b, $45 ; $4dad
	ld c, $14 ; $4daf
	ld de, $8000 ; $4db1
	farcall FarPtr_39_10 ; $4db4
	jr Label_3e_4def ; $4db7
Label_3e_4db9:
	ld hl, $00d6 ; $4db9
	ld de, $d0c3 ; $4dbc
	ld c, $0e ; $4dbf
	farcall FarPtr_05_1c ; $4dc1
	ld hl, $00d7 ; $4dc4
	ld de, $d103 ; $4dc7
	ld c, $0e ; $4dca
	farcall FarPtr_05_1c ; $4dcc
	ld hl, $00da ; $4dcf
	ld de, $d1c2 ; $4dd2
	ld c, $0e ; $4dd5
	farcall FarPtr_05_1c ; $4dd7
	ld hl, $00dc ; $4dda
	ld de, $d202 ; $4ddd
	ld c, $0e ; $4de0
	farcall FarPtr_05_1c ; $4de2
	ld b, $46 ; $4de5
	ld c, $14 ; $4de7
	ld de, $8000 ; $4de9
	farcall FarPtr_39_10 ; $4dec
Label_3e_4def:
	ld hl, $007a ; $4def
	ld de, $d1d0 ; $4df2
	ld c, $04 ; $4df5
	farcall FarPtr_05_1c ; $4df7
	ld hl, $007b ; $4dfa
	ld de, $d210 ; $4dfd
	ld c, $04 ; $4e00
	farcall FarPtr_05_1c ; $4e02
	farcall FarPtr_05_90 ; $4e05
	farcall FarPtr_39_02 ; $4e08
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
	farcall FarPtr_39_28 ; $4e30
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
	INCBIN "data/bank_03e/d_4e80.bin" ; $4e80, 32 bytes
Func_3e_4ea0:
	rst Rst08 ; $4ea0
	inc bc ; $4ea1
	ld hl, rIE ; $4ea2
	res 2, [hl] ; $4ea5
	call Func_3e_4f33 ; $4ea7
	ld a, $03 ; $4eaa
	ldh [$ff96], a ; $4eac
	ldh [rWBK], a ; $4eae
	ld a, [$cb11] ; $4eb0
	ld b, a ; $4eb3
	call Func_3e_5092 ; $4eb4
	farcall FarPtr_39_24 ; $4eb7
	ld b, $01 ; $4eba
	ld c, $01 ; $4ebc
	farcall FarPtr_39_26 ; $4ebe
	ld a, [$cb24] ; $4ec1
	ld c, a ; $4ec4
	ld b, $02 ; $4ec5
	call Func_3e_43eb ; $4ec7
	ld a, $01 ; $4eca
	ld hl, $50f5 ; $4ecc
	call Func_00_1b6a ; $4ecf
	call Func_3e_4fcf ; $4ed2
	ld a, $03 ; $4ed5
	ldh [$ff96], a ; $4ed7
	ldh [rWBK], a ; $4ed9
Label_3e_4edb:
	call Func_00_2631 ; $4edb
	ldh a, [$ff91] ; $4ede
	ld [$cb0d], a ; $4ee0
	ld b, $02 ; $4ee3
	ld c, $01 ; $4ee5
	call Func_3e_413a ; $4ee7
	or a, a ; $4eea
	jr z, Label_3e_4ef2 ; $4eeb
	rst Rst08 ; $4eed
	ld e, [hl] ; $4eee
	call Func_3e_4fcf ; $4eef
Label_3e_4ef2:
	ld a, [$cb0d] ; $4ef2
	bit 0, a ; $4ef5
	jr nz, Label_3e_4eff ; $4ef7
	bit 1, a ; $4ef9
	jr nz, Label_3e_4f1c ; $4efb
	jr Label_3e_4edb ; $4efd
Label_3e_4eff:
	rst Rst08 ; $4eff
	ld e, a ; $4f00
	call Func_00_1b38 ; $4f01
	ld hl, rIE ; $4f04
	set 2, [hl] ; $4f07
	ld b, $01 ; $4f09
	call Func_3e_50c4 ; $4f0b
	ld a, $01 ; $4f0e
	ld [$cb11], a ; $4f10
	ld c, $02 ; $4f13
	call Func_3e_43c9 ; $4f15
	ld [$cb24], a ; $4f18
	ret ; $4f1b
Label_3e_4f1c:
	rst Rst08 ; $4f1c
	ld h, d ; $4f1d
	call Func_00_1b38 ; $4f1e
	ld hl, rIE ; $4f21
	set 2, [hl] ; $4f24
	ld b, $00 ; $4f26
	call Func_3e_50c4 ; $4f28
	ld a, $00 ; $4f2b
	ld [$cb11], a ; $4f2d
	ld a, $ff ; $4f30
	ret ; $4f32
Func_3e_4f33:
	ldh a, [$ff96] ; $4f33
	push af ; $4f35
	ld a, $01 ; $4f36
	ldh [$ff96], a ; $4f38
	ldh [rWBK], a ; $4f3a
	ld c, $00 ; $4f3c
Label_3e_4f3e:
	ld a, c ; $4f3e
	add a, a ; $4f3f
	ld hl, $4fc3 ; $4f40
	add a, l ; $4f43
	ld l, a ; $4f44
	jr nc, Label_3e_4f48 ; $4f45
	inc h ; $4f47
Label_3e_4f48:
	ld a, [hl+] ; $4f48
	ld h, [hl] ; $4f49
	ld l, a ; $4f4a
	push af ; $4f4b
	push bc ; $4f4c
	push de ; $4f4d
	push hl ; $4f4e
	ld de, $d000 ; $4f4f
	call DecompressDataFromBank ; $4f52
	pop hl ; $4f55
	pop de ; $4f56
	pop bc ; $4f57
	pop af ; $4f58
	ld hl, $4fc9 ; $4f59
	ld a, c ; $4f5c
	add a, a ; $4f5d
	add a, l ; $4f5e
	ld l, a ; $4f5f
	jr nc, Label_3e_4f63 ; $4f60
	inc h ; $4f62
Label_3e_4f63:
	ld a, [hl+] ; $4f63
	ld d, [hl] ; $4f64
	ld e, a ; $4f65
	ld hl, $d000 ; $4f66
	push af ; $4f69
	push bc ; $4f6a
	push de ; $4f6b
	push hl ; $4f6c
	ld bc, $0010 ; $4f6d
	call Func_00_0480 ; $4f70
	pop hl ; $4f73
	pop de ; $4f74
	pop bc ; $4f75
	pop af ; $4f76
	ld a, c ; $4f77
	inc a ; $4f78
	ld c, a ; $4f79
	call Func_00_2631 ; $4f7a
	ld a, c ; $4f7d
	cp a, $02 ; $4f7e
	jr nz, Label_3e_4f3e ; $4f80
	ld b, $4a ; $4f82
	ld c, $10 ; $4f84
	ld de, $a000 ; $4f86
	farcall FarPtr_39_10 ; $4f89
	call Func_00_2631 ; $4f8c
	ld b, $4b ; $4f8f
	ld c, $10 ; $4f91
	ld de, $a100 ; $4f93
	farcall FarPtr_39_10 ; $4f96
	call Func_00_2631 ; $4f99
	ld b, $1b ; $4f9c
	ld c, $04 ; $4f9e
	ld de, $a700 ; $4fa0
	farcall FarPtr_39_10 ; $4fa3
	call Func_00_2631 ; $4fa6
	ld b, $4c ; $4fa9
	ld c, $14 ; $4fab
	ld de, $8000 ; $4fad
	farcall FarPtr_39_10 ; $4fb0
	call Func_00_2631 ; $4fb3
	ld b, $08 ; $4fb6
	ld c, $10 ; $4fb8
	farcall FarPtr_39_0e ; $4fba
	pop af ; $4fbd
	ldh [$ff96], a ; $4fbe
	ldh [rWBK], a ; $4fc0
	ret ; $4fc2
	INCBIN "data/bank_03e/d_4fc3.bin" ; $4fc3, 12 bytes
Func_3e_4fcf:
	ld a, $03 ; $4fcf
	ldh [$ff96], a ; $4fd1
	ldh [rWBK], a ; $4fd3
	ld b, $00 ; $4fd5
	ld c, $00 ; $4fd7
Label_3e_4fd9:
	call Func_3e_5165 ; $4fd9
	ld a, b ; $4fdc
	inc a ; $4fdd
	ld b, a ; $4fde
	cp a, $03 ; $4fdf
	jr nz, Label_3e_4fd9 ; $4fe1
	ld c, $02 ; $4fe3
	call Func_3e_43c9 ; $4fe5
	ld b, a ; $4fe8
	ld c, $01 ; $4fe9
	call Func_3e_5165 ; $4feb
	ld c, $02 ; $4fee
	call Func_3e_43c9 ; $4ff0
	call Func_3e_5038 ; $4ff3
	ld a, $03 ; $4ff6
	ldh [$ff96], a ; $4ff8
	ldh [rWBK], a ; $4ffa
	ld de, $d1e0 ; $4ffc
	ld b, $14 ; $4fff
	ld c, $01 ; $5001
	ld h, $03 ; $5003
	farcall FarPtr_39_0c ; $5005
	ld a, $02 ; $5008
	ld [$d1e0], a ; $500a
	ld a, $04 ; $500d
	ld [$d1f3], a ; $500f
	ld de, $d201 ; $5012
	ld b, $12 ; $5015
	ld c, $01 ; $5017
	ld h, $20 ; $5019
	farcall FarPtr_39_0c ; $501b
	call Func_3e_506d ; $501e
	ld hl, $d4e0 ; $5021
	ld de, $b8e0 ; $5024
	ld c, $06 ; $5027
	call Func_00_0480 ; $5029
	ld hl, $d1e0 ; $502c
	ld de, $99e0 ; $502f
	ld c, $04 ; $5032
	call Func_00_0480 ; $5034
	ret ; $5037
Func_3e_5038:
	ld hl, $504b ; $5038
	add a, a ; $503b
	add a, l ; $503c
	ld l, a ; $503d
	jr nc, Label_3e_5041 ; $503e
	inc h ; $5040
Label_3e_5041:
	ld a, [hl+] ; $5041
	ld h, [hl] ; $5042
	ld l, a ; $5043
	ld de, $0401 ; $5044
	call Func_00_05b0 ; $5047
	ret ; $504a
	INCBIN "data/bank_03e/d_504b.bin" ; $504b, 34 bytes
Func_3e_506d:
	ldh a, [$ff96] ; $506d
	push af ; $506f
	ld a, $03 ; $5070
	ldh [$ff96], a ; $5072
	ldh [rWBK], a ; $5074
	ld c, $02 ; $5076
	call Func_3e_43c9 ; $5078
	ld b, a ; $507b
	ld hl, $00e0 ; $507c
	add a, l ; $507f
	ld l, a ; $5080
	jr nc, Label_3e_5084 ; $5081
	inc h ; $5083
Label_3e_5084:
	ld de, $d201 ; $5084
	ld c, $20 ; $5087
	farcall FarPtr_05_72 ; $5089
	pop af ; $508c
	ldh [$ff96], a ; $508d
	ldh [rWBK], a ; $508f
	ret ; $5091
Func_3e_5092:
	ld a, b ; $5092
	or a, a ; $5093
	jr z, Label_3e_50ad ; $5094
	ld c, $00 ; $5096
Label_3e_5098:
	call Func_00_2631 ; $5098
	ld b, $10 ; $509b
	farcall FarPtr_39_20 ; $509d
	ld b, $03 ; $50a0
	farcall FarPtr_39_1e ; $50a2
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
	farcall FarPtr_39_20 ; $50b4
	ld b, $03 ; $50b7
	farcall FarPtr_39_1e ; $50b9
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
	farcall FarPtr_39_20 ; $50cf
	ld b, $03 ; $50d2
	farcall FarPtr_39_1e ; $50d4
	ld a, c ; $50d7
	inc a ; $50d8
	ld c, a ; $50d9
	cp a, $0a ; $50da
	jr nz, Label_3e_50ca ; $50dc
	ret ; $50de
Label_3e_50df:
	ld c, $0c ; $50df
Label_3e_50e1:
	call Func_00_2631 ; $50e1
	ld b, $10 ; $50e4
	farcall FarPtr_39_20 ; $50e6
	ld b, $03 ; $50e9
	farcall FarPtr_39_1e ; $50eb
	ld a, c ; $50ee
	dec a ; $50ef
	ld c, a ; $50f0
	or a, a ; $50f1
	jr nz, Label_3e_50e1 ; $50f2
	ret ; $50f4
	farcall FarPtr_39_28 ; $50f5
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
	add a, a ; $510b
	add a, l ; $510c
	ld l, a ; $510d
	jr nc, Label_3e_5111 ; $510e
	inc h ; $5110
Label_3e_5111:
	ld a, [hl+] ; $5111
	ld d, [hl] ; $5112
	ld e, a ; $5113
	farcall FarPtr_39_16 ; $5114
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
	farcall FarPtr_39_0c ; $5186
	pop hl ; $5189
	pop de ; $518a
	pop bc ; $518b
	pop af ; $518c
	ret ; $518d
	INCBIN "data/bank_03e/d_518e.bin" ; $518e, 4 bytes
Func_3e_5192:
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
	farcall FarPtr_39_24 ; $51a9
	ld b, $01 ; $51ac
	ld c, $01 ; $51ae
	farcall FarPtr_39_26 ; $51b0
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
	farcall FarPtr_39_10 ; $527f
	call Func_00_2631 ; $5282
	ld b, $24 ; $5285
	ld c, $10 ; $5287
	ld de, $a100 ; $5289
	farcall FarPtr_39_10 ; $528c
	call Func_00_2631 ; $528f
	ld b, $1b ; $5292
	ld c, $04 ; $5294
	ld de, $a700 ; $5296
	farcall FarPtr_39_10 ; $5299
	call Func_00_2631 ; $529c
	call Func_00_2631 ; $529f
	ld b, $08 ; $52a2
	ld c, $10 ; $52a4
	farcall FarPtr_39_0e ; $52a6
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
	farcall FarPtr_39_0c ; $52ed
	ld a, $02 ; $52f0
	ld [$d1e0], a ; $52f2
	ld a, $04 ; $52f5
	ld [$d1f3], a ; $52f7
	ld de, $d201 ; $52fa
	ld b, $12 ; $52fd
	ld c, $01 ; $52ff
	ld h, $20 ; $5301
	farcall FarPtr_39_0c ; $5303
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
	farcall FarPtr_05_72 ; $537b
	pop af ; $537e
	ldh [$ff96], a ; $537f
	ldh [rWBK], a ; $5381
	ret ; $5383
	INCBIN "data/bank_03e/d_5384.bin" ; $5384, 4 bytes
Func_3e_5388:
	call Func_00_1b38 ; $5388
	ld c, $10 ; $538b
	call Func_00_1d20 ; $538d
	call Func_00_1da4 ; $5390
	call Func_00_2631 ; $5393
	call Func_00_2631 ; $5396
	call DisableLCDSafely ; $5399
	farcall FarPtr_01_0a ; $539c
	xor a, a ; $539f
	ldh [$ff8b], a ; $53a0
	ldh [$ff8a], a ; $53a2
	call Func_3e_53cf ; $53a4
	call EnableLCD ; $53a7
	ld c, $10 ; $53aa
	call Func_00_1d2e ; $53ac
	call Func_00_1da4 ; $53af
Label_3e_53b2:
	ldh a, [$ff91] ; $53b2
	bit 0, a ; $53b4
	jr nz, Label_3e_53c1 ; $53b6
	bit 1, a ; $53b8
	jr nz, Label_3e_53c1 ; $53ba
	call Func_00_2631 ; $53bc
	jr Label_3e_53b2 ; $53bf
Label_3e_53c1:
	rst Rst08 ; $53c1
	ld e, a ; $53c2
	call Func_00_1b38 ; $53c3
	ld c, $10 ; $53c6
	call Func_00_1d20 ; $53c8
	call Func_00_1da4 ; $53cb
	ret ; $53ce
Func_3e_53cf:
	call Func_3e_53f1 ; $53cf
	farcall FarPtr_05_8c ; $53d2
	ld a, $03 ; $53d5
	ldh [$ff96], a ; $53d7
	ldh [rWBK], a ; $53d9
	ld hl, $d800 ; $53db
	ld bc, $0003 ; $53de
	call ClearMemory16 ; $53e1
	call Func_3e_5458 ; $53e4
	call Func_3e_5486 ; $53e7
	farcall FarPtr_05_90 ; $53ea
	farcall FarPtr_39_02 ; $53ed
	ret ; $53f0
Func_3e_53f1:
	ld c, $21 ; $53f1
	farcall FarPtr_39_00 ; $53f3
	farcall FarPtr_05_76 ; $53f6
	ld b, $11 ; $53f9
	ld c, $10 ; $53fb
	ld de, $9000 ; $53fd
	farcall FarPtr_39_10 ; $5400
	ld a, $05 ; $5403
	ldh [$ff96], a ; $5405
	ldh [rWBK], a ; $5407
	ld a, $03 ; $5409
	ld [$c3b3], a ; $540b
	ld a, $00 ; $540e
	ld [$c3b6], a ; $5410
	ld d, $00 ; $5413
	ld e, $00 ; $5415
	ld b, $14 ; $5417
	ld c, $09 ; $5419
	farcall FarPtr_05_78 ; $541b
	farcall FarPtr_05_7c ; $541e
	farcall FarPtr_05_7e ; $5421
	ld d, $00 ; $5424
	ld e, $09 ; $5426
	ld b, $14 ; $5428
	ld c, $09 ; $542a
	farcall FarPtr_05_78 ; $542c
	farcall FarPtr_05_7c ; $542f
	farcall FarPtr_05_7e ; $5432
	call Func_3e_5439 ; $5435
	ret ; $5438
Func_3e_5439:
	ld a, $03 ; $5439
	ldh [$ff96], a ; $543b
	ldh [rWBK], a ; $543d
	ld de, $d581 ; $543f
	ld b, $12 ; $5442
	ld c, $05 ; $5444
	ld h, $08 ; $5446
	farcall FarPtr_39_0c ; $5448
	ld de, $d461 ; $544b
	ld b, $12 ; $544e
	ld c, $05 ; $5450
	ld h, $08 ; $5452
	farcall FarPtr_39_0c ; $5454
	ret ; $5457
Func_3e_5458:
	ld a, $00 ; $5458
	ld [$d813], a ; $545a
	call Func_3e_575a ; $545d
	call Func_3e_5725 ; $5460
	ld a, $01 ; $5463
	ld [$d814], a ; $5465
	ld a, [$d811] ; $5468
	ld [$cb04], a ; $546b
	call Func_3e_595f ; $546e
	ld c, a ; $5471
	ld de, $d025 ; $5472
	call Func_3e_557a ; $5475
	call Func_3e_595f ; $5478
	ld c, a ; $547b
	ld de, $d028 ; $547c
	call Func_3e_59be ; $547f
	call Func_3e_596e ; $5482
	ret ; $5485
Func_3e_5486:
	ld hl, $d800 ; $5486
	ld bc, $0003 ; $5489
	call ClearMemory16 ; $548c
	ld a, $01 ; $548f
	ld [$d813], a ; $5491
	call Func_3e_57a8 ; $5494
	call Func_3e_5725 ; $5497
	ld a, $02 ; $549a
	ld [$d814], a ; $549c
	ld a, [$d811] ; $549f
	ld [$cb04], a ; $54a2
	call Func_3e_595f ; $54a5
	ld c, a ; $54a8
	ld de, $d145 ; $54a9
	call Func_3e_557a ; $54ac
	call Func_3e_595f ; $54af
	ld c, a ; $54b2
	ld de, $d148 ; $54b3
	call Func_3e_59b8 ; $54b6
	call Func_3e_596e ; $54b9
	ret ; $54bc
Func_3e_54bd:
	call DisableLCDSafely ; $54bd
	call Func_3e_550d ; $54c0
	ld a, $01 ; $54c3
	ld hl, $59cd ; $54c5
	call Func_00_1b6a ; $54c8
	ld a, $01 ; $54cb
	ld hl, $59eb ; $54cd
	call Func_00_1b6a ; $54d0
	call EnableLCD ; $54d3
	ld c, $10 ; $54d6
	call Func_00_1d2e ; $54d8
	call Func_00_1da4 ; $54db
Label_3e_54de:
	call Func_3e_55af ; $54de
	ld a, [$d812] ; $54e1
	or a, a ; $54e4
	jr z, Label_3e_54ef ; $54e5
	inc a ; $54e7
	ld [$d812], a ; $54e8
	cp a, $14 ; $54eb
	jr nc, Label_3e_54f4 ; $54ed
Label_3e_54ef:
	call Func_00_2631 ; $54ef
	jr Label_3e_54de ; $54f2
Label_3e_54f4:
	push af ; $54f4
	ld c, $10 ; $54f5
	call Func_00_1d20 ; $54f7
	call Func_00_1da4 ; $54fa
	call Func_00_1b38 ; $54fd
	pop af ; $5500
	cp a, $45 ; $5501
	jr nz, Label_3e_5508 ; $5503
	ld a, $ff ; $5505
	ret ; $5507
Label_3e_5508:
	farcall FarPtr_02_10 ; $5508
	xor a, a ; $550b
	ret ; $550c
Func_3e_550d:
	ld c, $21 ; $550d
	farcall FarPtr_39_00 ; $550f
	farcall FarPtr_05_8c ; $5512
	call Func_3e_57f4 ; $5515
	ld c, $00 ; $5518
	ld b, $07 ; $551a
	call Func_3e_43eb ; $551c
	ld a, $03 ; $551f
	ldh [$ff96], a ; $5521
	ldh [rWBK], a ; $5523
	ld hl, $d800 ; $5525
	ld bc, $0002 ; $5528
	call ClearMemory16 ; $552b
	ld a, $00 ; $552e
	ld [$d813], a ; $5530
	ld a, $00 ; $5533
	ld [$d814], a ; $5535
	call Func_3e_575a ; $5538
	call Func_3e_5725 ; $553b
	call Func_3e_5563 ; $553e
	call Func_3e_5624 ; $5541
	ld b, $63 ; $5544
	ld c, $02 ; $5546
	ld de, $a200 ; $5548
	farcall FarPtr_39_10 ; $554b
	ld hl, $555b ; $554e
	ld de, $0901 ; $5551
	call Func_00_05b0 ; $5554
	farcall FarPtr_39_02 ; $5557
	ret ; $555a
	INCBIN "data/bank_03e/d_555b.bin" ; $555b, 8 bytes
Func_3e_5563:
	ld hl, $d800 ; $5563
	ld a, [$d810] ; $5566
	ld b, a ; $5569
	ld de, $d027 ; $556a
Label_3e_556d:
	ld a, [hl+] ; $556d
	ld c, a ; $556e
	call Func_3e_557a ; $556f
	inc de ; $5572
	inc de ; $5573
	ld a, b ; $5574
	dec a ; $5575
	ld b, a ; $5576
	jr nz, Label_3e_556d ; $5577
	ret ; $5579
Func_3e_557a:
	push af ; $557a
	push bc ; $557b
	push de ; $557c
	push hl ; $557d
	ld hl, $d240 ; $557e
	ld a, [$d813] ; $5581
	or a, a ; $5584
	jr z, Label_3e_558a ; $5585
	ld hl, $d280 ; $5587
Label_3e_558a:
	ld a, c ; $558a
	add a, a ; $558b
	add a, l ; $558c
	ld l, a ; $558d
	jr nc, Label_3e_5591 ; $558e
	inc h ; $5590
Label_3e_5591:
	ld b, $02 ; $5591
	ld c, $02 ; $5593
	farcall FarPtr_39_0a ; $5595
	ld bc, $0400 ; $5598
	add hl, bc ; $559b
	push hl ; $559c
	ld h, d ; $559d
	ld l, e ; $559e
	add hl, bc ; $559f
	ld d, h ; $55a0
	ld e, l ; $55a1
	pop hl ; $55a2
	ld b, $02 ; $55a3
	ld c, $02 ; $55a5
	farcall FarPtr_39_0a ; $55a7
	pop hl ; $55aa
	pop de ; $55ab
	pop bc ; $55ac
	pop af ; $55ad
	ret ; $55ae
Func_3e_55af:
	ldh a, [$ff91] ; $55af
	ld [$cb0d], a ; $55b1
	bit 0, a ; $55b4
	jr nz, Label_3e_55be ; $55b6
	bit 1, a ; $55b8
	jr nz, Label_3e_55f9 ; $55ba
	jr Label_3e_5601 ; $55bc
Label_3e_55be:
	ld a, [$d812] ; $55be
	or a, a ; $55c1
	jr nz, Label_3e_5601 ; $55c2
	rst Rst08 ; $55c4
	ld h, b ; $55c5
	ld a, $01 ; $55c6
	ld [$d812], a ; $55c8
	ld a, [$d810] ; $55cb
	ld c, a ; $55ce
	call Func_3e_43c9 ; $55cf
	ld [$d811], a ; $55d2
	call Func_3e_595f ; $55d5
	ld b, a ; $55d8
	ld a, [$d813] ; $55d9
	cp a, $00 ; $55dc
	ld a, b ; $55de
	jr z, Label_3e_55ee ; $55df
	swap a ; $55e1
	ld b, a ; $55e3
	ld a, [wEquippedRacket] ; $55e4
	and a, $0f ; $55e7
	or a, b ; $55e9
	ld [wEquippedRacket], a ; $55ea
	ret ; $55ed
Label_3e_55ee:
	ld b, a ; $55ee
	ld a, [wEquippedRacket] ; $55ef
	and a, $f0 ; $55f2
	or a, b ; $55f4
	ld [wEquippedRacket], a ; $55f5
	ret ; $55f8
Label_3e_55f9:
	rst Rst08 ; $55f9
	ld h, d ; $55fa
	ld a, $44 ; $55fb
	ld [$d812], a ; $55fd
	ret ; $5600
Label_3e_5601:
	ld a, [$d810] ; $5601
	ld b, a ; $5604
	ld c, $01 ; $5605
	call Func_3e_413a ; $5607
	or a, a ; $560a
	jr z, Label_3e_5623 ; $560b
	rst Rst08 ; $560d
	ld e, [hl] ; $560e
	call Func_3e_5854 ; $560f
	ld a, [$d813] ; $5612
	or a, a ; $5615
	jr z, Label_3e_561d ; $5616
	call Func_3e_5704 ; $5618
	jr Label_3e_5620 ; $561b
Label_3e_561d:
	call Func_3e_5624 ; $561d
Label_3e_5620:
	call Func_3e_5899 ; $5620
Label_3e_5623:
	ret ; $5623
Func_3e_5624:
	farcall FarPtr_05_8c ; $5624
	call Func_3e_5981 ; $5627
	call Func_3e_594a ; $562a
	ld c, a ; $562d
	ld de, $d0a5 ; $562e
	push bc ; $5631
	call Func_3e_557a ; $5632
	pop bc ; $5635
	push bc ; $5636
	call Func_3e_59a4 ; $5637
	pop bc ; $563a
	ld de, $d0a8 ; $563b
	call Func_3e_59be ; $563e
	farcall FarPtr_05_90 ; $5641
	ret ; $5644
Func_3e_5645:
	call DisableLCDSafely ; $5645
	call Func_3e_5696 ; $5648
	ld a, $01 ; $564b
	ld hl, $59cd ; $564d
	call Func_00_1b6a ; $5650
	ld a, $01 ; $5653
	ld hl, $59eb ; $5655
	call Func_00_1b6a ; $5658
	call EnableLCD ; $565b
	ld c, $10 ; $565e
	call Func_00_1d2e ; $5660
	call Func_00_1da4 ; $5663
Label_3e_5666:
	call Func_3e_55af ; $5666
	ld a, [$d812] ; $5669
	or a, a ; $566c
	jr z, Label_3e_5677 ; $566d
	inc a ; $566f
	ld [$d812], a ; $5670
	cp a, $14 ; $5673
	jr nc, Label_3e_567c ; $5675
Label_3e_5677:
	call Func_00_2631 ; $5677
	jr Label_3e_5666 ; $567a
Label_3e_567c:
	push af ; $567c
	ld c, $10 ; $567d
	call Func_00_1d20 ; $567f
	call Func_00_1da4 ; $5682
	call Func_00_1b38 ; $5685
	pop af ; $5688
	cp a, $45 ; $5689
	jr nz, Label_3e_5690 ; $568b
	ld a, $ff ; $568d
	ret ; $568f
Label_3e_5690:
	farcall FarPtr_02_10 ; $5690
	xor a, a ; $5693
	ret ; $5694
	INCBIN "data/bank_03e/d_5695.bin" ; $5695, 1 bytes
Func_3e_5696:
	ld c, $21 ; $5696
	farcall FarPtr_39_00 ; $5698
	farcall FarPtr_05_8c ; $569b
	call Func_3e_57f4 ; $569e
	ld a, $03 ; $56a1
	ldh [$ff96], a ; $56a3
	ldh [rWBK], a ; $56a5
	ld hl, $d340 ; $56a7
	ld de, $d000 ; $56aa
	ld b, $14 ; $56ad
	ld c, $04 ; $56af
	farcall FarPtr_39_0a ; $56b1
	ld hl, $d740 ; $56b4
	ld de, $d400 ; $56b7
	ld b, $14 ; $56ba
	ld c, $04 ; $56bc
	farcall FarPtr_39_0a ; $56be
	ld c, $00 ; $56c1
	ld b, $07 ; $56c3
	call Func_3e_43eb ; $56c5
	ld a, $03 ; $56c8
	ldh [$ff96], a ; $56ca
	ldh [rWBK], a ; $56cc
	ld hl, $d800 ; $56ce
	ld bc, $0002 ; $56d1
	call ClearMemory16 ; $56d4
	ld a, $01 ; $56d7
	ld [$d813], a ; $56d9
	ld a, $00 ; $56dc
	ld [$d814], a ; $56de
	call Func_3e_57a8 ; $56e1
	call Func_3e_5725 ; $56e4
	call Func_3e_5563 ; $56e7
	call Func_3e_5704 ; $56ea
	ld b, $63 ; $56ed
	ld c, $02 ; $56ef
	ld de, $a200 ; $56f1
	farcall FarPtr_39_10 ; $56f4
	ld hl, $555b ; $56f7
	ld de, $0901 ; $56fa
	call Func_00_05b0 ; $56fd
	farcall FarPtr_39_02 ; $5700
	ret ; $5703
Func_3e_5704:
	farcall FarPtr_05_8c ; $5704
	call Func_3e_5981 ; $5707
	call Func_3e_594a ; $570a
	ld c, a ; $570d
	ld de, $d0a5 ; $570e
	push bc ; $5711
	call Func_3e_557a ; $5712
	pop bc ; $5715
	push bc ; $5716
	call Func_3e_599e ; $5717
	pop bc ; $571a
	ld de, $d0a8 ; $571b
	call Func_3e_59b8 ; $571e
	farcall FarPtr_05_90 ; $5721
	ret ; $5724
Func_3e_5725:
	xor a, a ; $5725
	ld [$d811], a ; $5726
	ld [$d810], a ; $5729
	ld hl, $d800 ; $572c
	ld bc, $0008 ; $572f
	call ClearBytes ; $5732
	ld hl, $d808 ; $5735
	ld de, $d800 ; $5738
	ld c, $00 ; $573b
	ld b, $00 ; $573d
Label_3e_573f:
	ld a, [hl+] ; $573f
	or a, a ; $5740
	jr z, Label_3e_574f ; $5741
	cp a, $01 ; $5743
	jr z, Label_3e_574b ; $5745
	ld a, b ; $5747
	ld [$d811], a ; $5748
Label_3e_574b:
	ld a, c ; $574b
	ld [de], a ; $574c
	inc de ; $574d
	inc b ; $574e
Label_3e_574f:
	inc c ; $574f
	ld a, c ; $5750
	cp a, $08 ; $5751
	jr nz, Label_3e_573f ; $5753
	ld a, b ; $5755
	ld [$d810], a ; $5756
	ret ; $5759
Func_3e_575a:
	ld hl, $d808 ; $575a
	ld bc, $0008 ; $575d
	call ClearBytes ; $5760
	ld hl, $d808 ; $5763
	ld a, $01 ; $5766
	ld [hl+], a ; $5768
	ld c, $00 ; $5769
Label_3e_576b:
	ld a, c ; $576b
	push hl ; $576c
	ld hl, $57a2 ; $576d
	add a, l ; $5770
	ld l, a ; $5771
	jr nc, Label_3e_5775 ; $5772
	inc h ; $5774
Label_3e_5775:
	ld d, $00 ; $5775
	ld e, [hl] ; $5777
	pop hl ; $5778
	call Func_00_24ef ; $5779
	jr z, Label_3e_5781 ; $577c
	ld a, $01 ; $577e
	ld [hl], a ; $5780
Label_3e_5781:
	inc hl ; $5781
	ld a, c ; $5782
	inc a ; $5783
	ld c, a ; $5784
	cp a, $06 ; $5785
	jr nz, Label_3e_576b ; $5787
	ld a, [wEquippedRacket] ; $5789
	and a, $0f ; $578c
	ld hl, $d808 ; $578e
	add a, l ; $5791
	ld l, a ; $5792
	jr nc, Label_3e_5796 ; $5793
	inc h ; $5795
Label_3e_5796:
	ld a, $02 ; $5796
	ld [hl], a ; $5798
	ret ; $5799
	INCBIN "data/bank_03e/d_579a.bin" ; $579a, 14 bytes
Func_3e_57a8:
	ld hl, $d808 ; $57a8
	ld bc, $0008 ; $57ab
	call ClearBytes ; $57ae
	ld hl, $d808 ; $57b1
	ld a, $01 ; $57b4
	ld [hl+], a ; $57b6
	ld c, $00 ; $57b7
Label_3e_57b9:
	ld a, c ; $57b9
	push hl ; $57ba
	ld hl, $57f2 ; $57bb
	add a, l ; $57be
	ld l, a ; $57bf
	jr nc, Label_3e_57c3 ; $57c0
	inc h ; $57c2
Label_3e_57c3:
	ld d, $00 ; $57c3
	ld e, [hl] ; $57c5
	pop hl ; $57c6
	call Func_00_24ef ; $57c7
	jr z, Label_3e_57cf ; $57ca
	ld a, $01 ; $57cc
	ld [hl], a ; $57ce
Label_3e_57cf:
	inc hl ; $57cf
	ld a, c ; $57d0
	inc a ; $57d1
	ld c, a ; $57d2
	cp a, $02 ; $57d3
	jr nz, Label_3e_57b9 ; $57d5
	ld a, [wEquippedRacket] ; $57d7
	and a, $f0 ; $57da
	swap a ; $57dc
	ld hl, $d808 ; $57de
	add a, l ; $57e1
	ld l, a ; $57e2
	jr nc, Label_3e_57e6 ; $57e3
	inc h ; $57e5
Label_3e_57e6:
	ld a, $02 ; $57e6
	ld [hl], a ; $57e8
	ret ; $57e9
	INCBIN "data/bank_03e/d_57ea.bin" ; $57ea, 10 bytes
Func_3e_57f4:
	farcall FarPtr_05_76 ; $57f4
	ld b, $11 ; $57f7
	ld c, $10 ; $57f9
	ld de, $9000 ; $57fb
	farcall FarPtr_39_10 ; $57fe
	ld a, $05 ; $5801
	ldh [$ff96], a ; $5803
	ldh [rWBK], a ; $5805
	call Func_3e_5838 ; $5807
	call Func_3e_5814 ; $580a
	ld de, $a000 ; $580d
	farcall FarPtr_39_06 ; $5810
	ret ; $5813
Func_3e_5814:
	ld d, $00 ; $5814
	ld e, $04 ; $5816
	ld b, $14 ; $5818
	ld c, $09 ; $581a
	farcall FarPtr_05_78 ; $581c
	farcall FarPtr_05_7c ; $581f
	farcall FarPtr_05_7e ; $5822
	ld a, $03 ; $5825
	ldh [$ff96], a ; $5827
	ldh [rWBK], a ; $5829
	ld de, $d4e1 ; $582b
	ld b, $12 ; $582e
	ld c, $05 ; $5830
	ld h, $08 ; $5832
	farcall FarPtr_39_0c ; $5834
	ret ; $5837
Func_3e_5838:
	ld a, $03 ; $5838
	ld [$c3b3], a ; $583a
	ld a, $00 ; $583d
	ld [$c3b6], a ; $583f
	ld d, $00 ; $5842
	ld e, $0d ; $5844
	ld b, $14 ; $5846
	ld c, $05 ; $5848
	farcall FarPtr_05_78 ; $584a
	farcall FarPtr_05_7c ; $584d
	farcall FarPtr_05_7e ; $5850
	ret ; $5853
Func_3e_5854:
	ld de, $d1a0 ; $5854
	ld b, $14 ; $5857
	ld c, $01 ; $5859
	ld h, $03 ; $585b
	farcall FarPtr_39_0c ; $585d
	ld a, $02 ; $5860
	ld [$d1a0], a ; $5862
	ld a, $04 ; $5865
	ld [$d1b3], a ; $5867
	ld de, $d1c1 ; $586a
	ld b, $12 ; $586d
	ld c, $03 ; $586f
	ld h, $20 ; $5871
	farcall FarPtr_39_0c ; $5873
	ld de, $d080 ; $5876
	ld b, $14 ; $5879
	ld c, $01 ; $587b
	ld h, $03 ; $587d
	farcall FarPtr_39_0c ; $587f
	ld a, $02 ; $5882
	ld [$d080], a ; $5884
	ld a, $04 ; $5887
	ld [$d093], a ; $5889
	ld de, $d0a1 ; $588c
	ld b, $12 ; $588f
	ld c, $07 ; $5891
	ld h, $20 ; $5893
	farcall FarPtr_39_0c ; $5895
	ret ; $5898
Func_3e_5899:
	ld hl, $d080 ; $5899
	ld de, $9880 ; $589c
	ld c, $10 ; $589f
	call Func_00_0480 ; $58a1
	ld hl, $d1a0 ; $58a4
	ld de, $99a0 ; $58a7
	ld c, $08 ; $58aa
	call Func_00_0480 ; $58ac
	ld hl, $d4a0 ; $58af
	ld de, $b8a0 ; $58b2
	ld c, $04 ; $58b5
	call Func_00_0480 ; $58b7
	ret ; $58ba
	INCBIN "data/bank_03e/d_58bb.bin" ; $58bb, 143 bytes
Func_3e_594a:
	push bc ; $594a
	push hl ; $594b
	ld a, [$d810] ; $594c
	ld c, a ; $594f
	call Func_3e_43c9 ; $5950
	ld hl, $d800 ; $5953
	add a, l ; $5956
	ld l, a ; $5957
	jr nc, Label_3e_595b ; $5958
	inc h ; $595a
Label_3e_595b:
	ld a, [hl] ; $595b
	pop hl ; $595c
	pop bc ; $595d
	ret ; $595e
Func_3e_595f:
	push hl ; $595f
	ld a, [$d811] ; $5960
	ld hl, $d800 ; $5963
	add a, l ; $5966
	ld l, a ; $5967
	jr nc, Label_3e_596b ; $5968
	inc h ; $596a
Label_3e_596b:
	ld a, [hl] ; $596b
	pop hl ; $596c
	ret ; $596d
Func_3e_596e:
	push af ; $596e
	push bc ; $596f
	push de ; $5970
	push hl ; $5971
	ldh a, [$ff96] ; $5972
	push af ; $5974
	ld a, $03 ; $5975
	ldh [$ff96], a ; $5977
	ldh [rWBK], a ; $5979
	call Func_3e_595f ; $597b
	jp Label_3e_5991 ; $597e
Func_3e_5981:
	push af ; $5981
	push bc ; $5982
	push de ; $5983
	push hl ; $5984
	ldh a, [$ff96] ; $5985
	push af ; $5987
	ld a, $03 ; $5988
	ldh [$ff96], a ; $598a
	ldh [rWBK], a ; $598c
	call Func_3e_594a ; $598e
Label_3e_5991:
	call Func_3e_5a15 ; $5991
	pop af ; $5994
	ldh [$ff96], a ; $5995
	ldh [rWBK], a ; $5997
	pop hl ; $5999
	pop de ; $599a
	pop bc ; $599b
	pop af ; $599c
	ret ; $599d
Func_3e_599e:
	ld hl, $00f7 ; $599e
	jp Label_3e_59a7 ; $59a1
Func_3e_59a4:
	ld hl, $00ed ; $59a4
Label_3e_59a7:
	ld a, c ; $59a7
	add a, l ; $59a8
	ld l, a ; $59a9
	jr nc, Label_3e_59ad ; $59aa
	inc h ; $59ac
Label_3e_59ad:
	ld de, $d1c1 ; $59ad
	ld c, $12 ; $59b0
	push hl ; $59b2
	farcall FarPtr_05_1c ; $59b3
	pop hl ; $59b6
	ret ; $59b7
Func_3e_59b8:
	ld hl, $00f4 ; $59b8
	jp Label_3e_59c1 ; $59bb
Func_3e_59be:
	ld hl, $00e5 ; $59be
Label_3e_59c1:
	ld a, c ; $59c1
	add a, l ; $59c2
	ld l, a ; $59c3
	jr nc, Label_3e_59c7 ; $59c4
	inc h ; $59c6
Label_3e_59c7:
	ld c, $12 ; $59c7
	farcall FarPtr_05_1c ; $59c9
	ret ; $59cc
	INCBIN "data/bank_03e/d_59cd.bin" ; $59cd, 72 bytes
Func_3e_5a15:
	ld b, a ; $5a15
	call Func_3e_5a44 ; $5a16
	ld b, $00 ; $5a19
Label_3e_5a1b:
	ld d, [hl] ; $5a1b
	inc hl ; $5a1c
	ld c, [hl] ; $5a1d
	inc hl ; $5a1e
	call Func_3e_5a2d ; $5a1f
	cp a, $ff ; $5a22
	jr z, Label_3e_5a2c ; $5a24
	inc b ; $5a26
	ld a, b ; $5a27
	cp a, $06 ; $5a28
	jr nz, Label_3e_5a1b ; $5a2a
Label_3e_5a2c:
	ret ; $5a2c
Func_3e_5a2d:
	push hl ; $5a2d
	push bc ; $5a2e
	ld a, d ; $5a2f
	cp a, $ff ; $5a30
	jr z, Label_3e_5a41 ; $5a32
	cp a, $fe ; $5a34
	jr z, Label_3e_5a41 ; $5a36
	call Func_3e_5aca ; $5a38
	ld d, c ; $5a3b
	call Func_3e_5b16 ; $5a3c
	ld a, $fe ; $5a3f
Label_3e_5a41:
	pop bc ; $5a41
	pop hl ; $5a42
	ret ; $5a43
Func_3e_5a44:
	push af ; $5a44
	push bc ; $5a45
	ld hl, $5a5f ; $5a46
	ld a, [$d813] ; $5a49
	or a, a ; $5a4c
	jr z, Label_3e_5a52 ; $5a4d
	ld hl, $5a6d ; $5a4f
Label_3e_5a52:
	ld a, b ; $5a52
	add a, a ; $5a53
	add a, l ; $5a54
	ld l, a ; $5a55
	jr nc, Label_3e_5a59 ; $5a56
	inc h ; $5a58
Label_3e_5a59:
	ld a, [hl+] ; $5a59
	ld h, [hl] ; $5a5a
	ld l, a ; $5a5b
	pop bc ; $5a5c
	pop af ; $5a5d
	ret ; $5a5e
	INCBIN "data/bank_03e/d_5a5f.bin" ; $5a5f, 107 bytes
Func_3e_5aca:
	push af ; $5aca
	push bc ; $5acb
	push de ; $5acc
	push hl ; $5acd
	ld e, $00 ; $5ace
	call Func_3e_5b3e ; $5ad0
	call Func_3e_5ae2 ; $5ad3
	call Func_3e_5afc ; $5ad6
	ld c, a ; $5ad9
	farcall FarPtr_39_7c ; $5ada
	pop hl ; $5add
	pop de ; $5ade
	pop bc ; $5adf
	pop af ; $5ae0
	ret ; $5ae1
Func_3e_5ae2:
	push hl ; $5ae2
	ld a, d ; $5ae3
	ld hl, $5aef ; $5ae4
	add a, l ; $5ae7
	ld l, a ; $5ae8
	jr nc, Label_3e_5aec ; $5ae9
	inc h ; $5aeb
Label_3e_5aec:
	ld b, [hl] ; $5aec
	pop hl ; $5aed
	ret ; $5aee
	INCBIN "data/bank_03e/d_5aef.bin" ; $5aef, 13 bytes
Func_3e_5afc:
	push hl ; $5afc
	ld a, d ; $5afd
	ld hl, $5b09 ; $5afe
	add a, l ; $5b01
	ld l, a ; $5b02
	jr nc, Label_3e_5b06 ; $5b03
	inc h ; $5b05
Label_3e_5b06:
	ld a, [hl] ; $5b06
	pop hl ; $5b07
	ret ; $5b08
	INCBIN "data/bank_03e/d_5b09.bin" ; $5b09, 13 bytes
Func_3e_5b16:
	push af ; $5b16
	push bc ; $5b17
	push de ; $5b18
	push hl ; $5b19
	ld a, d ; $5b1a
	cp a, $fe ; $5b1b
	jr z, Label_3e_5b27 ; $5b1d
	ld e, $01 ; $5b1f
	call Func_3e_5b3e ; $5b21
	call Func_3e_5b2c ; $5b24
Label_3e_5b27:
	pop hl ; $5b27
	pop de ; $5b28
	pop bc ; $5b29
	pop af ; $5b2a
	ret ; $5b2b
Func_3e_5b2c:
	ld a, d ; $5b2c
	cp a, $80 ; $5b2d
	ld a, $d0 ; $5b2f
	jr c, Label_3e_5b35 ; $5b31
	ld a, $d1 ; $5b33
Label_3e_5b35:
	ld [hl+], a ; $5b35
	ld a, d ; $5b36
	and a, $07 ; $5b37
	ld b, $d2 ; $5b39
	add a, b ; $5b3b
	ld [hl], a ; $5b3c
	ret ; $5b3d
Func_3e_5b3e:
	ld a, [$d814] ; $5b3e
	add a, a ; $5b41
	ld hl, $5b63 ; $5b42
	add a, l ; $5b45
	ld l, a ; $5b46
	jr nc, Label_3e_5b4a ; $5b47
	inc h ; $5b49
Label_3e_5b4a:
	ld a, [hl+] ; $5b4a
	ld h, [hl] ; $5b4b
	ld l, a ; $5b4c
	ld a, b ; $5b4d
	add a, a ; $5b4e
	add a, l ; $5b4f
	ld l, a ; $5b50
	jr nc, Label_3e_5b54 ; $5b51
	inc h ; $5b53
Label_3e_5b54:
	ld a, [hl+] ; $5b54
	ld h, [hl] ; $5b55
	ld l, a ; $5b56
	ld a, e ; $5b57
	or a, a ; $5b58
	jr z, Label_3e_5b62 ; $5b59
	ld a, $06 ; $5b5b
	add a, l ; $5b5d
	ld l, a ; $5b5e
	jr nc, Label_3e_5b62 ; $5b5f
	inc h ; $5b61
Label_3e_5b62:
	ret ; $5b62
	INCBIN "data/bank_03e/d_5b63.bin" ; $5b63, 54 bytes
Func_3e_5b99:
	rst Rst08 ; $5b99
	inc bc ; $5b9a
	call Func_00_1b38 ; $5b9b
	ld hl, rIE ; $5b9e
	res 2, [hl] ; $5ba1
	farcall FarPtr_39_24 ; $5ba3
	ld b, $01 ; $5ba6
	ld c, $01 ; $5ba8
	farcall FarPtr_39_26 ; $5baa
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
Func_3e_5d11:
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
	farcall FarPtr_39_10 ; $5d73
	ld b, $66 ; $5d76
	ld c, $12 ; $5d78
	ld de, $a100 ; $5d7a
	farcall FarPtr_39_10 ; $5d7d
	ld b, $67 ; $5d80
	ld c, $12 ; $5d82
	ld de, $a200 ; $5d84
	farcall FarPtr_39_10 ; $5d87
	ld b, $68 ; $5d8a
	ld c, $14 ; $5d8c
	ld de, $a300 ; $5d8e
	farcall FarPtr_39_10 ; $5d91
	ld b, $6a ; $5d94
	ld c, $12 ; $5d96
	ld de, $a420 ; $5d98
	farcall FarPtr_39_10 ; $5d9b
	ld b, $6b ; $5d9e
	ld c, $12 ; $5da0
	ld de, $a520 ; $5da2
	farcall FarPtr_39_10 ; $5da5
	ld b, $6c ; $5da8
	ld c, $12 ; $5daa
	ld de, $a620 ; $5dac
	farcall FarPtr_39_10 ; $5daf
	ld b, $6d ; $5db2
	ld c, $12 ; $5db4
	ld de, $8200 ; $5db6
	farcall FarPtr_39_10 ; $5db9
	ld b, $6e ; $5dbc
	ld c, $12 ; $5dbe
	ld de, $8300 ; $5dc0
	farcall FarPtr_39_10 ; $5dc3
	ld b, $6f ; $5dc6
	ld c, $12 ; $5dc8
	ld de, $8400 ; $5dca
	farcall FarPtr_39_10 ; $5dcd
	ld b, $1b ; $5dd0
	ld c, $04 ; $5dd2
	ld de, $a720 ; $5dd4
	farcall FarPtr_39_10 ; $5dd7
	ld b, $40 ; $5dda
	ld c, $14 ; $5ddc
	ld de, $8000 ; $5dde
	farcall FarPtr_39_10 ; $5de1
	ld b, $08 ; $5de4
	ld c, $10 ; $5de6
	farcall FarPtr_39_0e ; $5de8
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
	farcall FarPtr_39_20 ; $5e35
	ld b, $02 ; $5e38
	farcall FarPtr_39_1e ; $5e3a
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
	farcall FarPtr_39_20 ; $5e4f
	ld b, $02 ; $5e52
	farcall FarPtr_39_1e ; $5e54
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
	farcall FarPtr_39_20 ; $5e6d
	ld b, $02 ; $5e70
	farcall FarPtr_39_1e ; $5e72
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
	farcall FarPtr_39_20 ; $5e84
	ld b, $02 ; $5e87
	farcall FarPtr_39_1e ; $5e89
	ld a, c ; $5e8c
	dec a ; $5e8d
	ld c, a ; $5e8e
	or a, a ; $5e8f
	jr nz, Label_3e_5e7f ; $5e90
	ret ; $5e92
	farcall FarPtr_39_28 ; $5e93
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
	farcall FarPtr_39_16 ; $5eb3
	ld b, [hl] ; $5eb6
	pop af ; $5eb7
	add a, a ; $5eb8
	ld hl, $5eea ; $5eb9
	add a, l ; $5ebc
	ld l, a ; $5ebd
	jr nc, Label_3e_5ec1 ; $5ebe
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
	farcall FarPtr_39_0c ; $5fce
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
	farcall FarPtr_39_7c ; $6140
	ld hl, $d200 ; $6143
	ld c, $04 ; $6146
	farcall FarPtr_39_7c ; $6148
	ld hl, $d220 ; $614b
	ld c, $04 ; $614e
	farcall FarPtr_39_7c ; $6150
	ret ; $6153
Func_3e_6154:
	ld b, $40 ; $6154
	ld hl, $d209 ; $6156
	ld c, $05 ; $6159
	farcall FarPtr_39_7c ; $615b
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
	farcall FarPtr_39_7c ; $64c2
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
	farcall FarPtr_39_7c ; $64eb
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
	farcall FarPtr_01_0a ; $650c
	farcall FarPtr_39_22 ; $650f
	pop af ; $6512
	ldh [$ff96], a ; $6513
	ldh [rWBK], a ; $6515
	ret ; $6517
Func_3e_6518:
	ld a, [$cb54] ; $6518
	ld b, a ; $651b
	call Func_3e_695a ; $651c
	rst Rst08 ; $651f
	inc bc ; $6520
	call Func_00_1b38 ; $6521
	ld hl, rIE ; $6524
	res 2, [hl] ; $6527
	farcall FarPtr_39_24 ; $6529
	ld b, $01 ; $652c
	ld c, $01 ; $652e
	farcall FarPtr_39_26 ; $6530
	call Func_3e_610b ; $6533
	ld a, $03 ; $6536
	ldh [$ff96], a ; $6538
	ldh [rWBK], a ; $653a
	ld a, [$cb11] ; $653c
	ld b, a ; $653f
	call Func_3e_66ab ; $6540
	xor a, a ; $6543
	ld c, a ; $6544
	ld b, $03 ; $6545
	call Func_3e_43eb ; $6547
	ld a, $01 ; $654a
	ld hl, $6714 ; $654c
	call Func_00_1b6a ; $654f
	call Func_3e_6824 ; $6552
	ld a, $03 ; $6555
	ldh [$ff96], a ; $6557
	ldh [rWBK], a ; $6559
Label_3e_655b:
	call Func_00_2631 ; $655b
	ldh a, [$ff91] ; $655e
	ld [$cb0d], a ; $6560
	ld b, $03 ; $6563
	ld c, $03 ; $6565
	call Func_3e_413a ; $6567
	or a, a ; $656a
	jr z, Label_3e_6572 ; $656b
	rst Rst08 ; $656d
	ld e, [hl] ; $656e
	call Func_3e_6824 ; $656f
Label_3e_6572:
	ld a, [$cb0d] ; $6572
	bit 0, a ; $6575
	jr nz, Label_3e_657f ; $6577
	bit 1, a ; $6579
	jr nz, Label_3e_65b2 ; $657b
	jr Label_3e_655b ; $657d
Label_3e_657f:
	ld c, $03 ; $657f
	call Func_3e_43c9 ; $6581
	ld b, a ; $6584
	call Func_3e_697b ; $6585
	or a, a ; $6588
	jr nz, Label_3e_658f ; $6589
	rst Rst08 ; $658b
	ld h, c ; $658c
	jr Label_3e_655b ; $658d
Label_3e_658f:
	rst Rst08 ; $658f
	ld h, b ; $6590
	call Func_00_1b38 ; $6591
	ld hl, rIE ; $6594
	set 2, [hl] ; $6597
	ld b, $01 ; $6599
	call Func_3e_66e3 ; $659b
	ld a, $01 ; $659e
	ld [$cb11], a ; $65a0
	ld c, $03 ; $65a3
	call Func_3e_43c9 ; $65a5
	push af ; $65a8
	ld c, a ; $65a9
	call Func_3e_60dd ; $65aa
	pop af ; $65ad
	call Func_3e_5cfe ; $65ae
	ret ; $65b1
Label_3e_65b2:
	rst Rst08 ; $65b2
	ld h, d ; $65b3
	call Func_00_1b38 ; $65b4
	ld hl, rIE ; $65b7
	set 2, [hl] ; $65ba
	ld b, $00 ; $65bc
	call Func_3e_66e3 ; $65be
	ld a, $00 ; $65c1
	ld [$cb11], a ; $65c3
	ld a, $ff ; $65c6
	ret ; $65c8
	INCBIN "data/bank_03e/d_65c9.bin" ; $65c9, 226 bytes
Func_3e_66ab:
	ld a, b ; $66ab
	or a, a ; $66ac
	jr z, Label_3e_66c9 ; $66ad
	ld c, $00 ; $66af
Label_3e_66b1:
	call Func_00_2631 ; $66b1
	ld b, $14 ; $66b4
	farcall FarPtr_39_20 ; $66b6
	ld b, $00 ; $66b9
	farcall FarPtr_39_1e ; $66bb
	ld a, c ; $66be
	inc a ; $66bf
	ld c, a ; $66c0
	cp a, $0f ; $66c1
	jr nz, Label_3e_66b1 ; $66c3
	call Func_00_2631 ; $66c5
	ret ; $66c8
Label_3e_66c9:
	ld c, $09 ; $66c9
Label_3e_66cb:
	call Func_00_2631 ; $66cb
	ld b, $15 ; $66ce
	farcall FarPtr_39_20 ; $66d0
	ld b, $00 ; $66d3
	farcall FarPtr_39_1e ; $66d5
	ld a, c ; $66d8
	dec a ; $66d9
	ld c, a ; $66da
	cp a, $ff ; $66db
	jr nz, Label_3e_66cb ; $66dd
	call Func_00_2631 ; $66df
	ret ; $66e2
Func_3e_66e3:
	ld a, b ; $66e3
	or a, a ; $66e4
	jr z, Label_3e_66fe ; $66e5
	ld c, $00 ; $66e7
Label_3e_66e9:
	call Func_00_2631 ; $66e9
	ld b, $15 ; $66ec
	farcall FarPtr_39_20 ; $66ee
	ld b, $00 ; $66f1
	farcall FarPtr_39_1e ; $66f3
	ld a, c ; $66f6
	inc a ; $66f7
	ld c, a ; $66f8
	cp a, $0b ; $66f9
	jr nz, Label_3e_66e9 ; $66fb
	ret ; $66fd
Label_3e_66fe:
	ld c, $0e ; $66fe
Label_3e_6700:
	call Func_00_2631 ; $6700
	ld b, $14 ; $6703
	farcall FarPtr_39_20 ; $6705
	ld b, $00 ; $6708
	farcall FarPtr_39_1e ; $670a
	ld a, c ; $670d
	dec a ; $670e
	ld c, a ; $670f
	or a, a ; $6710
	jr nz, Label_3e_6700 ; $6711
	ret ; $6713
	INCBIN "data/bank_03e/d_6714.bin" ; $6714, 272 bytes
Func_3e_6824:
	ld a, $03 ; $6824
	ldh [$ff96], a ; $6826
	ldh [rWBK], a ; $6828
	ld b, $00 ; $682a
	ld c, $00 ; $682c
Label_3e_682e:
	call Func_3e_688b ; $682e
	ld a, b ; $6831
	inc a ; $6832
	ld b, a ; $6833
	cp a, $09 ; $6834
	jr nz, Label_3e_682e ; $6836
	ld c, $03 ; $6838
	call Func_3e_43c9 ; $683a
	ld b, a ; $683d
	ld c, $01 ; $683e
	call Func_3e_688b ; $6840
	ld c, $03 ; $6843
	call Func_3e_43c9 ; $6845
	call Func_3e_68c6 ; $6848
	ld c, $03 ; $684b
	call Func_3e_43c9 ; $684d
	ld d, a ; $6850
	ld b, a ; $6851
	call Func_3e_697b ; $6852
	or a, a ; $6855
	ld b, $ff ; $6856
	jr z, Label_3e_685b ; $6858
	ld b, d ; $685a
Label_3e_685b:
	call Func_3e_648f ; $685b
	ld hl, $d460 ; $685e
	ld de, $b860 ; $6861
	ld c, $06 ; $6864
	call Func_00_0480 ; $6866
	ld hl, $d4e0 ; $6869
	ld de, $b8e0 ; $686c
	ld c, $06 ; $686f
	call Func_00_0480 ; $6871
	ld hl, $d560 ; $6874
	ld de, $b960 ; $6877
	ld c, $06 ; $687a
	call Func_00_0480 ; $687c
	ld hl, $d200 ; $687f
	ld de, $9a00 ; $6882
	ld c, $02 ; $6885
	call Func_00_0480 ; $6887
	ret ; $688a
Func_3e_688b:
	push af ; $688b
	push bc ; $688c
	push de ; $688d
	push hl ; $688e
	ld a, c ; $688f
	or a, a ; $6890
	jr z, Label_3e_6897 ; $6891
	ld h, $0c ; $6893
	jr Label_3e_6899 ; $6895
Label_3e_6897:
	ld h, $0d ; $6897
Label_3e_6899:
	push hl ; $6899
	ld hl, $68b4 ; $689a
	ld a, b ; $689d
	add a, a ; $689e
	add a, l ; $689f
	ld l, a ; $68a0
	jr nc, Label_3e_68a4 ; $68a1
	inc h ; $68a3
Label_3e_68a4:
	ld a, [hl+] ; $68a4
	ld d, [hl] ; $68a5
	ld e, a ; $68a6
	pop hl ; $68a7
	ld b, $05 ; $68a8
	ld c, $03 ; $68aa
	farcall FarPtr_39_0c ; $68ac
	pop hl ; $68af
	pop de ; $68b0
	pop bc ; $68b1
	pop af ; $68b2
	ret ; $68b3
	INCBIN "data/bank_03e/d_68b4.bin" ; $68b4, 18 bytes
Func_3e_68c6:
	ld hl, $68d9 ; $68c6
	add a, a ; $68c9
	add a, l ; $68ca
	ld l, a ; $68cb
	jr nc, Label_3e_68cf ; $68cc
	inc h ; $68ce
Label_3e_68cf:
	ld a, [hl+] ; $68cf
	ld h, [hl] ; $68d0
	ld l, a ; $68d1
	ld de, $0401 ; $68d2
	call Func_00_05b0 ; $68d5
	ret ; $68d8
	INCBIN "data/bank_03e/d_68d9.bin" ; $68d9, 129 bytes
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
Func_3e_69a0:
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
	farcall FarPtr_03_1c ; $69b1
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
Func_3e_69d4:
	ret ; $69d4
	INCBIN "data/bank_03e/d_69d5.bin" ; $69d5, 5675 bytes
