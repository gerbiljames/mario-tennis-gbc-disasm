INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $0a", ROMX[$4000], BANK[$0a]

	INCBIN "data/bank_00a/d_4000.bin" ; $4000, 208 bytes
	push af ; $40d0
	push bc ; $40d1
	push de ; $40d2
	push hl ; $40d3
	ldh a, [$ff96] ; $40d4
	push af ; $40d6
	ld a, $05 ; $40d7
	ldh [$ff96], a ; $40d9
	ldh [rWBK], a ; $40db
	pop af ; $40dd
	ldh [$ff96], a ; $40de
	ldh [rWBK], a ; $40e0
	ld a, $ff ; $40e2
	ld [$c363], a ; $40e4
	xor a, a ; $40e7
	ld [$c368], a ; $40e8
	ld [$c369], a ; $40eb
	ld a, $01 ; $40ee
	call Func_0a_4364 ; $40f0
	ldh a, [$ff9e] ; $40f3
	or a, a ; $40f5
	jr z, Label_0a_4100 ; $40f6
	ld a, $01 ; $40f8
	ld hl, $40a4 ; $40fa
	call Func_00_1b6a ; $40fd
Label_0a_4100:
	pop hl ; $4100
	pop de ; $4101
	pop bc ; $4102
	pop af ; $4103
	ret ; $4104
	INCBIN "data/bank_00a/d_4105.bin" ; $4105, 58 bytes
Func_0a_413f:
	push af ; $413f
	push bc ; $4140
	rst Rst30 ; $4141
	ret nz ; $4142
	ld [bc], a ; $4143
	jr z, Label_0a_4148 ; $4144
	ld a, $02 ; $4146
Label_0a_4148:
	or a, a ; $4148
	jr z, Label_0a_4151 ; $4149
	ld c, a ; $414b
	call Func_00_2740 ; $414c
	pop bc ; $414f
	pop af ; $4150
Label_0a_4151:
	ret ; $4151
	INCBIN "data/bank_00a/d_4152.bin" ; $4152, 448 bytes
Func_0a_4312:
	ld hl, $d000 ; $4312
	cp a, $18 ; $4315
	jr nc, Label_0a_4326 ; $4317
	ld h, a ; $4319
	xor a, a ; $431a
	srl h ; $431b
	rra ; $431d
	srl h ; $431e
	rra ; $4320
	ld l, a ; $4321
	ld a, $d0 ; $4322
	add a, h ; $4324
	ld h, a ; $4325
Label_0a_4326:
	ld a, $04 ; $4326
	ldh [$ff96], a ; $4328
	ldh [rWBK], a ; $432a
	push hl ; $432c
	ld a, $20 ; $432d
	add a, l ; $432f
	ld l, a ; $4330
	jr nc, Label_0a_4334 ; $4331
	inc h ; $4333
Label_0a_4334:
	ld a, [hl] ; $4334
	cp a, $00 ; $4335
	pop hl ; $4337
	inc h ; $4338
	dec h ; $4339
	ret ; $433a
	INCBIN "data/bank_00a/d_433b.bin" ; $433b, 41 bytes
Func_0a_4364:
	call Func_0a_4312 ; $4364
	ld c, l ; $4367
	ld b, h ; $4368
	ld hl, $4766 ; $4369
	ldh a, [$ff95] ; $436c
	rst Rst18 ; $436e
	inc b ; $436f
	inc b ; $4370
	ret ; $4371
	INCBIN "data/bank_00a/d_4372.bin" ; $4372, 64 bytes
	add sp, -4 ; $43b2
	ld hl, sp + 0 ; $43b4
	ld [hl], c ; $43b6
	inc hl ; $43b7
	ld [hl], b ; $43b8
	inc hl ; $43b9
	ld [hl], e ; $43ba
	inc hl ; $43bb
	ld [hl], d ; $43bc
	ld hl, sp + 0 ; $43bd
	ld c, l ; $43bf
	ld b, h ; $43c0
	call Func_0a_4312 ; $43c1
	jr z, Label_0a_43d5 ; $43c4
	ld a, l ; $43c6
	ldh [$ffea], a ; $43c7
	ld a, h ; $43c9
	ldh [$ffeb], a ; $43ca
	ld a, $04 ; $43cc
	ldh [$ff96], a ; $43ce
	ldh [rWBK], a ; $43d0
	call Func_0a_43d8 ; $43d2
Label_0a_43d5:
	add sp, 4 ; $43d5
	ret ; $43d7
Func_0a_43d8:
	push bc ; $43d8
	push af ; $43d9
	ld hl, $ffea ; $43da
	ld a, [hl+] ; $43dd
	ld h, [hl] ; $43de
	add a, $0c ; $43df
	ld l, a ; $43e1
	ld e, l ; $43e2
	ld d, h ; $43e3
	pop af ; $43e4
	ld l, c ; $43e5
	ld h, b ; $43e6
	ld bc, $0004 ; $43e7
	call CopyMemoryBC ; $43ea
	pop bc ; $43ed
	ld hl, $ffea ; $43ee
	ld a, [hl+] ; $43f1
	ld h, [hl] ; $43f2
	add a, $05 ; $43f3
	ld l, a ; $43f5
	res 7, [hl] ; $43f6
	ret ; $43f8
	INCBIN "data/bank_00a/d_43f9.bin" ; $43f9, 1177 bytes
Func_0a_4892:
	push af ; $4892
	push bc ; $4893
	push hl ; $4894
	ld bc, $0258 ; $4895
	ld hl, $d040 ; $4898
	ld a, l ; $489b
	ldh [$ffea], a ; $489c
	ld a, h ; $489e
	ldh [$ffeb], a ; $489f
	ld a, $04 ; $48a1
	ldh [$ff96], a ; $48a3
	ldh [rWBK], a ; $48a5
	ld a, $05 ; $48a7
	add a, l ; $48a9
	ld l, a ; $48aa
	jr nc, Label_0a_48ae ; $48ab
	inc h ; $48ad
Label_0a_48ae:
	ld a, $01 ; $48ae
	call Func_0a_413f ; $48b0
	bit 7, [hl] ; $48b3
	jr z, Label_0a_48bc ; $48b5
	dec bc ; $48b7
	ld a, c ; $48b8
	or a, b ; $48b9
	jr nz, Label_0a_48ae ; $48ba
Label_0a_48bc:
	pop hl ; $48bc
	pop bc ; $48bd
	pop af ; $48be
	ret ; $48bf
	INCBIN "data/bank_00a/d_48c0.bin" ; $48c0, 817 bytes
Label_0a_4bf1:
	ld a, [$df05] ; $4bf1
	rst Rst18 ; $4bf4
	ld a, h ; $4bf5
	dec b ; $4bf6
	ld hl, $10e8 ; $4bf7
	ld de, $d181 ; $4bfa
	rst Rst18 ; $4bfd
	inc e ; $4bfe
	dec b ; $4bff
	ld a, [$df05] ; $4c00
	rst Rst18 ; $4c03
	ld a, [hl] ; $4c04
	dec b ; $4c05
	ld hl, $10d7 ; $4c06
	ld d, $01 ; $4c09
	ld e, $00 ; $4c0b
	rst Rst18 ; $4c0d
	ld [$df05], sp ; $4c0e
	jr Label_0a_4c18 ; $4c11
	INCBIN "data/bank_00a/d_4c13.bin" ; $4c13, 5 bytes
Label_0a_4c18:
	dec b ; $4c18
	ld [$df00], a ; $4c19
	ld a, [$d82f] ; $4c1c
	rst Rst18 ; $4c1f
	ld a, d ; $4c20
	dec b ; $4c21
	ld a, [$df00] ; $4c22
	cp a, $ff ; $4c25
	jr nz, Label_0a_4c31 ; $4c27
	ld a, $08 ; $4c29
	ld [$df06], a ; $4c2b
	jp Label_0a_4d1e ; $4c2e
Label_0a_4c31:
	or a, a ; $4c31
	jp z, Label_0a_4c3d ; $4c32
	ld a, $01 ; $4c35
	ld [$df06], a ; $4c37
	jp Label_0a_4d1e ; $4c3a
Label_0a_4c3d:
	rst Rst30 ; $4c3d
	ldh [rTIMA], a ; $4c3e
	jr nz, Label_0a_4c45 ; $4c40
	xor a, a ; $4c42
	jr Label_0a_4c47 ; $4c43
Label_0a_4c45:
	ld a, $01 ; $4c45
Label_0a_4c47:
	ld [$df01], a ; $4c47
Label_0a_4c4a:
	ld a, [$df05] ; $4c4a
	rst Rst18 ; $4c4d
	ld a, h ; $4c4e
	dec b ; $4c4f
	ld hl, $10e4 ; $4c50
	ld de, $d181 ; $4c53
	rst Rst18 ; $4c56
	inc e ; $4c57
	dec b ; $4c58
	ld a, [$df05] ; $4c59
	rst Rst18 ; $4c5c
	ld a, [hl] ; $4c5d
	dec b ; $4c5e
	ld hl, $10d9 ; $4c5f
	ld d, $03 ; $4c62
	ld e, $00 ; $4c64
	rst Rst18 ; $4c66
	ld [$df05], sp ; $4c67
	jr Label_0a_4c71 ; $4c6a
	INCBIN "data/bank_00a/d_4c6c.bin" ; $4c6c, 5 bytes
Label_0a_4c71:
	dec b ; $4c71
	ld [$df02], a ; $4c72
	ld a, [$d82f] ; $4c75
	rst Rst18 ; $4c78
	ld a, d ; $4c79
	dec b ; $4c7a
	ld a, [$df02] ; $4c7b
	cp a, $ff ; $4c7e
	jp z, Label_0a_4bf1 ; $4c80
Label_0a_4c83:
	ld a, [$df05] ; $4c83
	rst Rst18 ; $4c86
	ld a, h ; $4c87
	dec b ; $4c88
	ld hl, $10e5 ; $4c89
	ld de, $d181 ; $4c8c
	rst Rst18 ; $4c8f
	inc e ; $4c90
	dec b ; $4c91
	ld a, [$df05] ; $4c92
	rst Rst18 ; $4c95
	ld a, [hl] ; $4c96
	dec b ; $4c97
	ld hl, $10da ; $4c98
	ld d, $05 ; $4c9b
	ld e, $00 ; $4c9d
	rst Rst18 ; $4c9f
	ld [$df05], sp ; $4ca0
	jr Label_0a_4caa ; $4ca3
	INCBIN "data/bank_00a/d_4ca5.bin" ; $4ca5, 5 bytes
Label_0a_4caa:
	dec b ; $4caa
	ld [$df03], a ; $4cab
	ld a, [$d82f] ; $4cae
	rst Rst18 ; $4cb1
	ld a, d ; $4cb2
	dec b ; $4cb3
	ld a, [$df03] ; $4cb4
	cp a, $ff ; $4cb7
	jp z, Label_0a_4c4a ; $4cb9
	ld a, [$df05] ; $4cbc
	rst Rst18 ; $4cbf
	ld a, h ; $4cc0
	dec b ; $4cc1
	ld hl, $10e6 ; $4cc2
	ld a, [$df02] ; $4cc5
	add a, l ; $4cc8
	ld l, a ; $4cc9
	jr nc, Label_0a_4ccd ; $4cca
	inc h ; $4ccc
Label_0a_4ccd:
	ld de, $d181 ; $4ccd
	rst Rst18 ; $4cd0
	inc e ; $4cd1
	dec b ; $4cd2
	ld a, [$df05] ; $4cd3
	rst Rst18 ; $4cd6
	ld a, [hl] ; $4cd7
	dec b ; $4cd8
	ld a, [$df01] ; $4cd9
	or a, a ; $4cdc
	jp nz, Label_0a_4ce5 ; $4cdd
	ld hl, $10db ; $4ce0
	jr Label_0a_4ce8 ; $4ce3
Label_0a_4ce5:
	ld hl, $10df ; $4ce5
Label_0a_4ce8:
	ld a, [$df02] ; $4ce8
	or a, a ; $4ceb
	jr z, Label_0a_4cf7 ; $4cec
	ld a, [$df03] ; $4cee
	inc a ; $4cf1
	add a, l ; $4cf2
	ld l, a ; $4cf3
	jr nc, Label_0a_4cf7 ; $4cf4
	inc h ; $4cf6
Label_0a_4cf7:
	ld d, $07 ; $4cf7
	ld e, $00 ; $4cf9
	rst Rst18 ; $4cfb
	ld [$df05], sp ; $4cfc
	jr Label_0a_4d06 ; $4cff
	INCBIN "data/bank_00a/d_4d01.bin" ; $4d01, 5 bytes
Label_0a_4d06:
	dec b ; $4d06
	ld [$df04], a ; $4d07
	ld a, [$d82f] ; $4d0a
	rst Rst18 ; $4d0d
	ld a, d ; $4d0e
	dec b ; $4d0f
	ld a, [$df04] ; $4d10
	cp a, $ff ; $4d13
	jp z, Label_0a_4c83 ; $4d15
	call Func_0a_4d80 ; $4d18
	call Func_0a_4eca ; $4d1b
Label_0a_4d1e:
	ld hl, $df06 ; $4d1e
	ld b, [hl] ; $4d21
	pop af ; $4d22
	ldh [$ff96], a ; $4d23
	ldh [rWBK], a ; $4d25
	ld a, b ; $4d27
	pop hl ; $4d28
	pop de ; $4d29
	pop bc ; $4d2a
	ret ; $4d2b
	INCBIN "data/bank_00a/d_4d2c.bin" ; $4d2c, 84 bytes
Func_0a_4d80:
	ld a, [$df00] ; $4d80
	or a, a ; $4d83
	ret nz ; $4d84
	rst Rst28 ; $4d85
	ldh [rTIMA], a ; $4d86
	ld a, [$df01] ; $4d88
	or a, a ; $4d8b
	jr z, Label_0a_4d91 ; $4d8c
	rst Rst20 ; $4d8e
	ldh [rTIMA], a ; $4d8f
Label_0a_4d91:
	call Func_0a_4da9 ; $4d91
	ld a, [$df01] ; $4d94
	or a, a ; $4d97
	jr nz, Label_0a_4d9f ; $4d98
Label_0a_4d9a:
	call Func_0a_4e0e ; $4d9a
	jr Label_0a_4da8 ; $4d9d
Label_0a_4d9f:
	ld a, [$df02] ; $4d9f
	or a, a ; $4da2
	jr z, Label_0a_4d9a ; $4da3
	call Func_0a_4e75 ; $4da5
Label_0a_4da8:
	ret ; $4da8
Func_0a_4da9:
	ld c, $1c ; $4da9
	ld de, $1800 ; $4dab
Label_0a_4dae:
	push de ; $4dae
	call Func_00_24d4 ; $4daf
	pop de ; $4db2
	ld hl, $0020 ; $4db3
	add hl, de ; $4db6
	ld d, h ; $4db7
	ld e, l ; $4db8
	dec c ; $4db9
	jr nz, Label_0a_4dae ; $4dba
	ld a, [$df03] ; $4dbc
	or a, a ; $4dbf
	ret z ; $4dc0
	ld hl, $4df2 ; $4dc1
Label_0a_4dc4:
	ld a, [hl+] ; $4dc4
	ld d, [hl] ; $4dc5
	ld e, a ; $4dc6
	inc hl ; $4dc7
	ld a, d ; $4dc8
	and a, d ; $4dc9
	cp a, $ff ; $4dca
	jr z, Label_0a_4dd3 ; $4dcc
	call Func_00_24ba ; $4dce
	jr Label_0a_4dc4 ; $4dd1
Label_0a_4dd3:
	ld a, [$df03] ; $4dd3
	cp a, $01 ; $4dd6
	ret z ; $4dd8
	ld hl, $4e00 ; $4dd9
Label_0a_4ddc:
	ld a, [hl+] ; $4ddc
	ld d, [hl] ; $4ddd
	ld e, a ; $4dde
	inc hl ; $4ddf
	ld a, d ; $4de0
	and a, d ; $4de1
	cp a, $ff ; $4de2
	jr z, Label_0a_4deb ; $4de4
	call Func_00_24ba ; $4de6
	jr Label_0a_4ddc ; $4de9
Label_0a_4deb:
	ret ; $4deb
	INCBIN "data/bank_00a/d_4dec.bin" ; $4dec, 34 bytes
Func_0a_4e0e:
	ld c, $09 ; $4e0e
	ld de, $0a00 ; $4e10
Label_0a_4e13:
	push de ; $4e13
	call Func_00_24d4 ; $4e14
	pop de ; $4e17
	ld hl, $0020 ; $4e18
	add hl, de ; $4e1b
	ld d, h ; $4e1c
	ld e, l ; $4e1d
	dec c ; $4e1e
	jr nz, Label_0a_4e13 ; $4e1f
	ld a, [$df02] ; $4e21
	or a, a ; $4e24
	jr z, Label_0a_4e2a ; $4e25
	ld a, [$df04] ; $4e27
Label_0a_4e2a:
	ld b, a ; $4e2a
	ld a, [$df03] ; $4e2b
	ld c, a ; $4e2e
	add a, a ; $4e2f
	add a, a ; $4e30
	add a, c ; $4e31
	ld c, a ; $4e32
	ld a, b ; $4e33
	add a, c ; $4e34
	ld c, a ; $4e35
	inc c ; $4e36
	ld hl, $4e4b ; $4e37
Label_0a_4e3a:
	ld a, [hl+] ; $4e3a
	ld d, [hl] ; $4e3b
	ld e, a ; $4e3c
	inc hl ; $4e3d
	dec c ; $4e3e
	jr z, Label_0a_4e4a ; $4e3f
	ld a, d ; $4e41
	or a, e ; $4e42
	jr z, Label_0a_4e3a ; $4e43
	call Func_00_24ba ; $4e45
	jr Label_0a_4e3a ; $4e48
Label_0a_4e4a:
	ret ; $4e4a
	INCBIN "data/bank_00a/d_4e4b.bin" ; $4e4b, 42 bytes
Func_0a_4e75:
	ld c, $09 ; $4e75
	ld de, $0a00 ; $4e77
Label_0a_4e7a:
	push de ; $4e7a
	call Func_00_24d4 ; $4e7b
	pop de ; $4e7e
	ld hl, $0020 ; $4e7f
	add hl, de ; $4e82
	ld d, h ; $4e83
	ld e, l ; $4e84
	dec c ; $4e85
	jr nz, Label_0a_4e7a ; $4e86
	ld a, [$df03] ; $4e88
	add a, a ; $4e8b
	add a, a ; $4e8c
	ld c, a ; $4e8d
	ld a, [$df04] ; $4e8e
	add a, c ; $4e91
	ld c, a ; $4e92
	inc c ; $4e93
	ld hl, $4ea8 ; $4e94
Label_0a_4e97:
	ld a, [hl+] ; $4e97
	ld d, [hl] ; $4e98
	ld e, a ; $4e99
	inc hl ; $4e9a
	dec c ; $4e9b
	jr z, Label_0a_4ea7 ; $4e9c
	ld a, d ; $4e9e
	or a, e ; $4e9f
	jr z, Label_0a_4e97 ; $4ea0
	call Func_00_24ba ; $4ea2
	jr Label_0a_4e97 ; $4ea5
Label_0a_4ea7:
	ret ; $4ea7
	INCBIN "data/bank_00a/d_4ea8.bin" ; $4ea8, 34 bytes
Func_0a_4eca:
	ld hl, $4eee ; $4eca
	ld a, [$df02] ; $4ecd
	ld b, a ; $4ed0
	or a, a ; $4ed1
	jr z, Label_0a_4ee0 ; $4ed2
	ld a, [$df03] ; $4ed4
	inc a ; $4ed7
	inc a ; $4ed8
	add a, a ; $4ed9
	ld b, a ; $4eda
	ld a, [$df01] ; $4edb
	jr Label_0a_4ee3 ; $4ede
Label_0a_4ee0:
	ld a, [$df04] ; $4ee0
Label_0a_4ee3:
	add a, b ; $4ee3
	add a, l ; $4ee4
	ld l, a ; $4ee5
	jr nc, Label_0a_4ee9 ; $4ee6
	inc h ; $4ee8
Label_0a_4ee9:
	ld a, [hl] ; $4ee9
	ld [$df06], a ; $4eea
	ret ; $4eed
	INCBIN "data/bank_00a/d_4eee.bin" ; $4eee, 14 bytes
	rst Rst30 ; $4efc
	nop ; $4efd
	inc b ; $4efe
	jr z, Label_0a_4f2b ; $4eff
	ld a, $04 ; $4f01
	ldh [$ff96], a ; $4f03
	ldh [rWBK], a ; $4f05
	ld hl, $c2d0 ; $4f07
	ld a, [hl+] ; $4f0a
	ld h, [hl] ; $4f0b
	ld l, a ; $4f0c
	push hl ; $4f0d
	push de ; $4f0e
	ld h, h ; $4f0f
	ld l, l ; $4f10
	ld de, $1000 ; $4f11
	call Func_00_1ace ; $4f14
	pop de ; $4f17
	pop hl ; $4f18
	ld hl, $c2d2 ; $4f19
	ld a, [hl+] ; $4f1c
	ld h, [hl] ; $4f1d
	ld l, a ; $4f1e
	push hl ; $4f1f
	push de ; $4f20
	ld h, h ; $4f21
	ld l, l ; $4f22
	ld de, $1001 ; $4f23
	call Func_00_1ace ; $4f26
	pop de ; $4f29
	pop hl ; $4f2a
Label_0a_4f2b:
	ret ; $4f2b
	xor a, a ; $4f2c
	ld [$cb5f], a ; $4f2d
Label_0a_4f30:
	call Func_00_1b38 ; $4f30
	ld a, $01 ; $4f33
	ld hl, $4efc ; $4f35
	call Func_00_1b6a ; $4f38
	call Func_0a_4f40 ; $4f3b
	jr Label_0a_4f30 ; $4f3e
Func_0a_4f40:
	push af ; $4f40
	push bc ; $4f41
	push de ; $4f42
	push hl ; $4f43
	ld c, $0c ; $4f44
	call Func_00_1d20 ; $4f46
	call Func_0a_50e4 ; $4f49
	call Func_0a_50f1 ; $4f4c
	call Func_0a_5114 ; $4f4f
	call Func_0a_516f ; $4f52
	ld a, $00 ; $4f55
	ld [wGameMode], a ; $4f57
	call Func_00_2631 ; $4f5a
	rst Rst30 ; $4f5d
	ret nz ; $4f5e
	dec c ; $4f5f
	jr nz, Label_0a_4f6f ; $4f60
	ld a, [$c284] ; $4f62
	cp a, $ff ; $4f65
	jr z, Label_0a_4f6f ; $4f67
	ld a, [$c284] ; $4f69
	call Func_00_3024 ; $4f6c
Label_0a_4f6f:
	rst Rst18 ; $4f6f
	halt ; $4f70
	dec b ; $4f71
	ld hl, $c28a ; $4f72
	ld a, [hl+] ; $4f75
	ld h, [hl] ; $4f76
	ld l, a ; $4f77
	ld a, [$c29b] ; $4f78
	call Func_0a_5466 ; $4f7b
	ld hl, $d000 ; $4f7e
	ld de, $0018 ; $4f81
	add hl, de ; $4f84
	ld [hl], $01 ; $4f85
	rst Rst20 ; $4f87
	add a, b ; $4f88
	ld [bc], a ; $4f89
	call Func_00_1da4 ; $4f8a
	rst Rst28 ; $4f8d
	add a, b ; $4f8e
	ld [bc], a ; $4f8f
	rst Rst18 ; $4f90
	ld l, b ; $4f91
	ld a, [bc] ; $4f92
	call DisableLCDSafely ; $4f93
	rst Rst18 ; $4f96
	halt ; $4f97
	dec b ; $4f98
	rst Rst18 ; $4f99
	ld l, d ; $4f9a
	ld a, [bc] ; $4f9b
	ld a, [$c281] ; $4f9c
	rst Rst18 ; $4f9f
	ld l, h ; $4fa0
	ld a, [bc] ; $4fa1
	ld a, $00 ; $4fa2
	rst Rst18 ; $4fa4
	halt ; $4fa5
	ld a, [bc] ; $4fa6
	rst Rst30 ; $4fa7
	ret nz ; $4fa8
	dec c ; $4fa9
	jr nz, Label_0a_4faf ; $4faa
	rst Rst18 ; $4fac
	ld a, [bc] ; $4fad
	INCBIN "data/bank_00a/d_4fae.bin" ; $4fae, 1 bytes
Label_0a_4faf:
	call EnableLCD ; $4faf
	ld a, [$c29c] ; $4fb2
	ld l, a ; $4fb5
	ld a, [$c29d] ; $4fb6
	ld h, a ; $4fb9
	ld a, h ; $4fba
	or a, l ; $4fbb
	jr z, Label_0a_4fc4 ; $4fbc
	ld a, [$c29b] ; $4fbe
	call Func_00_015e ; $4fc1
Label_0a_4fc4:
	call Func_0a_5495 ; $4fc4
	ld hl, $c2a1 ; $4fc7
	ld a, [hl] ; $4fca
	and a, a ; $4fcb
	jr z, Label_0a_4fd6 ; $4fcc
	ld [hl], $00 ; $4fce
	call Func_0a_560b ; $4fd0
	jp Label_0a_50df ; $4fd3
Label_0a_4fd6:
	ld c, $08 ; $4fd6
	call Func_00_1d2e ; $4fd8
	call Func_00_1da4 ; $4fdb
	ld a, [$c2d5] ; $4fde
	and a, a ; $4fe1
	jr z, Label_0a_4ff1 ; $4fe2
	ld a, [$c2d6] ; $4fe4
	ld l, a ; $4fe7
	ld a, [$c2d7] ; $4fe8
	ld h, a ; $4feb
	call Func_0a_52f5 ; $4fec
	jr Label_0a_4ff5 ; $4fef
Label_0a_4ff1:
	call Func_00_2725 ; $4ff1
	inc b ; $4ff4
Label_0a_4ff5:
	ld a, $04 ; $4ff5
	ldh [$ff96], a ; $4ff7
	ldh [rWBK], a ; $4ff9
	call Func_0a_5104 ; $4ffb
	and a, a ; $4ffe
	jp z, Label_0a_50ca ; $4fff
	ld bc, $d000 ; $5002
	ld hl, $4766 ; $5005
	ldh a, [$ff95] ; $5008
	rst Rst18 ; $500a
	inc b ; $500b
	inc b ; $500c
	ld hl, $d000 ; $500d
	ld de, $0018 ; $5010
	add hl, de ; $5013
	ld [hl], $01 ; $5014
	ld hl, $c2a0 ; $5016
	ld a, [hl] ; $5019
	and a, a ; $501a
	jr z, Label_0a_5022 ; $501b
	ld [hl], $00 ; $501d
	call Func_0a_55a5 ; $501f
Label_0a_5022:
	ld hl, $c2a1 ; $5022
	ld a, [hl] ; $5025
	and a, a ; $5026
	jr z, Label_0a_5031 ; $5027
	ld [hl], $00 ; $5029
	call Func_0a_560b ; $502b
	jp Label_0a_50df ; $502e
Label_0a_5031:
	ld hl, $c2a5 ; $5031
	ld a, [hl] ; $5034
	and a, a ; $5035
	jr z, Label_0a_5048 ; $5036
	ld [hl], $00 ; $5038
	call Func_0a_4892 ; $503a
	rst Rst30 ; $503d
	ret nz ; $503e
	dec b ; $503f
	jr nz, Label_0a_5048 ; $5040
	rst Rst18 ; $5042
	ld [$c306], sp ; $5043
	push af ; $5046
	ld c, a ; $5047
Label_0a_5048:
	xor a, a ; $5048
	ld [$c2a3], a ; $5049
	ld hl, $c2a2 ; $504c
	ld a, [hl] ; $504f
	and a, a ; $5050
	jr z, Label_0a_507e ; $5051
	ld [hl], $00 ; $5053
	ld a, $04 ; $5055
	ldh [$ff96], a ; $5057
	ldh [rWBK], a ; $5059
	ld a, [$daec] ; $505b
	and a, a ; $505e
	jr z, Label_0a_507e ; $505f
	ld hl, $daed ; $5061
	ld a, [$daec] ; $5064
	cp a, [hl] ; $5067
	jr nz, Label_0a_507e ; $5068
	ld hl, $daee ; $506a
	ld a, [hl] ; $506d
	cp a, $1e ; $506e
	jr c, Label_0a_507e ; $5070
	ld [hl], $00 ; $5072
	ld hl, $c2a3 ; $5074
	ld [hl], $ff ; $5077
	ld hl, $c2a4 ; $5079
	ld [hl], $01 ; $507c
Label_0a_507e:
	xor a, a ; $507e
	ld [$c2da], a ; $507f
	ld hl, $c2a4 ; $5082
	ld a, [hl] ; $5085
	and a, a ; $5086
	jr z, Label_0a_50c7 ; $5087
	ld [hl], $00 ; $5089
	call Func_0a_5227 ; $508b
	and a, a ; $508e
	jr z, Label_0a_509a ; $508f
	call Func_0a_54b5 ; $5091
	ld a, [$c2da] ; $5094
	and a, a ; $5097
	jr nz, Label_0a_50c7 ; $5098
Label_0a_509a:
	call Func_0a_5200 ; $509a
	and a, a ; $509d
	jr z, Label_0a_50a9 ; $509e
	call Func_0a_5574 ; $50a0
	ld a, [$c2da] ; $50a3
	and a, a ; $50a6
	jr nz, Label_0a_50c7 ; $50a7
Label_0a_50a9:
	call Func_0a_5369 ; $50a9
	and a, a ; $50ac
	jr z, Label_0a_50b4 ; $50ad
	call Func_0a_55dd ; $50af
	jr Label_0a_50c7 ; $50b2
Label_0a_50b4:
	ld a, [$c2a3] ; $50b4
	and a, a ; $50b7
	jr nz, Label_0a_50c7 ; $50b8
	ldh a, [$ff9e] ; $50ba
	and a, a ; $50bc
	jr z, Label_0a_50c7 ; $50bd
	call Func_0a_4892 ; $50bf
	rst Rst18 ; $50c2
	ld d, d ; $50c3
	dec b ; $50c4
	jr Label_0a_50c7 ; $50c5
Label_0a_50c7:
	jp Label_0a_4ff5 ; $50c7
Label_0a_50ca:
	call Func_00_1da4 ; $50ca
	ld bc, $d000 ; $50cd
	rst Rst18 ; $50d0
	inc e ; $50d1
	inc b ; $50d2
Label_0a_50d3:
	call Func_00_2631 ; $50d3
	call Func_0a_5104 ; $50d6
	and a, a ; $50d9
	jr z, Label_0a_50d3 ; $50da
	jp Label_0a_4ff5 ; $50dc
Label_0a_50df:
	pop hl ; $50df
	pop de ; $50e0
	pop bc ; $50e1
	pop af ; $50e2
	ret ; $50e3
Func_0a_50e4:
	push af ; $50e4
	push hl ; $50e5
	ld hl, $c9dc ; $50e6
	xor a, a ; $50e9
	ld [hl+], a ; $50ea
	ld [hl+], a ; $50eb
	ld [hl+], a ; $50ec
	ld [hl+], a ; $50ed
	pop hl ; $50ee
	pop af ; $50ef
	ret ; $50f0
Func_0a_50f1:
	push af ; $50f1
	push bc ; $50f2
	push de ; $50f3
	push hl ; $50f4
	ld hl, $c2a0 ; $50f5
	ld b, $06 ; $50f8
	xor a, a ; $50fa
Label_0a_50fb:
	ld [hl+], a ; $50fb
	dec b ; $50fc
	jr nz, Label_0a_50fb ; $50fd
	pop hl ; $50ff
	pop de ; $5100
	pop bc ; $5101
	pop af ; $5102
	ret ; $5103
Func_0a_5104:
	push bc ; $5104
	push hl ; $5105
	ld hl, $c2a0 ; $5106
	ld b, $06 ; $5109
	xor a, a ; $510b
Label_0a_510c:
	or a, [hl] ; $510c
	inc hl ; $510d
	dec b ; $510e
	jr nz, Label_0a_510c ; $510f
	pop hl ; $5111
	pop bc ; $5112
	ret ; $5113
Func_0a_5114:
	push af ; $5114
	push bc ; $5115
	push de ; $5116
	push hl ; $5117
	ld a, [wStoryModeCurrentLocation] ; $5118
	call Func_0a_574e ; $511b
	jr Label_0a_5120 ; $511e
Label_0a_5120:
	ld de, $c280 ; $5120
	ld bc, $0006 ; $5123
	call CopyMemoryBC ; $5126
	ld hl, $c282 ; $5129
	ld a, [hl+] ; $512c
	ld h, [hl] ; $512d
	ld l, a ; $512e
	ld a, h ; $512f
	ld [$c29b], a ; $5130
	ld hl, $c282 ; $5133
	ld a, [hl+] ; $5136
	ld h, [hl] ; $5137
	ld l, a ; $5138
	ld de, $c286 ; $5139
	ld bc, $000e ; $513c
	call CopyDataFromBank ; $513f
	ld a, [wStoryModeCurrentLocation] ; $5142
	add a, $79 ; $5145
	ld l, a ; $5147
	adc a, $01 ; $5148
	sub a, l ; $514a
	ld h, a ; $514b
	ld a, l ; $514c
	ld [$c2d6], a ; $514d
	ld a, h ; $5150
	ld [$c2d7], a ; $5151
	ld a, [$c295] ; $5154
	sub a, $ff ; $5157
	ld [$c2d5], a ; $5159
	pop hl ; $515c
	pop de ; $515d
	pop bc ; $515e
	pop af ; $515f
	ret ; $5160
	INCBIN "data/bank_00a/d_5161.bin" ; $5161, 14 bytes
Func_0a_516f:
	push af ; $516f
	push bc ; $5170
	push de ; $5171
	push hl ; $5172
	ld a, [$c295] ; $5173
	cp a, $ff ; $5176
	jr z, Label_0a_51ca ; $5178
	ld hl, $c295 ; $517a
	ld d, [hl] ; $517d
	ld hl, $c286 ; $517e
	ld a, [hl+] ; $5181
	ld h, [hl] ; $5182
	ld l, a ; $5183
Label_0a_5184:
	ld a, [$c29b] ; $5184
	call Func_00_0628 ; $5187
	cp a, $ff ; $518a
	jr z, Label_0a_519a ; $518c
	cp a, d ; $518e
	jr z, Label_0a_51a0 ; $518f
	ld a, $08 ; $5191
	add a, l ; $5193
	ld l, a ; $5194
	jr nc, Label_0a_5198 ; $5195
	inc h ; $5197
Label_0a_5198:
	jr Label_0a_5184 ; $5198
Label_0a_519a:
	ld hl, $c286 ; $519a
	ld a, [hl+] ; $519d
	ld h, [hl] ; $519e
	ld l, a ; $519f
Label_0a_51a0:
	ld a, [$c29b] ; $51a0
	ld de, $c2c0 ; $51a3
	ld bc, $0008 ; $51a6
	call Func_00_067a ; $51a9
	ld a, [$c2c1] ; $51ac
	ld [$c29a], a ; $51af
	ld hl, $c2c2 ; $51b2
	ld de, $c296 ; $51b5
	ld bc, $0004 ; $51b8
	call CopyMemoryBC ; $51bb
	ld a, [$c2c6] ; $51be
	ld [$c29c], a ; $51c1
	ld a, [$c2c7] ; $51c4
	ld [$c29d], a ; $51c7
Label_0a_51ca:
	pop hl ; $51ca
	pop de ; $51cb
	pop bc ; $51cc
	pop af ; $51cd
	ret ; $51ce
Func_0a_51cf:
	push af ; $51cf
	push bc ; $51d0
	ld b, a ; $51d1
	ld a, $04 ; $51d2
	ldh [$ff96], a ; $51d4
	ldh [rWBK], a ; $51d6
	ld a, b ; $51d8
	ld c, l ; $51d9
	ld b, h ; $51da
	ld hl, $0032 ; $51db
	add hl, bc ; $51de
	add a, [hl] ; $51df
	ld l, e ; $51e0
	ld h, d ; $51e1
	call Func_00_0ac5 ; $51e2
	push hl ; $51e5
	ld hl, $000e ; $51e6
	add hl, bc ; $51e9
	ld a, [hl+] ; $51ea
	ld h, [hl] ; $51eb
	ld l, a ; $51ec
	add hl, de ; $51ed
	ld e, l ; $51ee
	ld d, h ; $51ef
	pop hl ; $51f0
	push de ; $51f1
	ld e, l ; $51f2
	ld d, h ; $51f3
	ld hl, $000c ; $51f4
	add hl, bc ; $51f7
	ld a, [hl+] ; $51f8
	ld h, [hl] ; $51f9
	ld l, a ; $51fa
	add hl, de ; $51fb
	pop de ; $51fc
	pop bc ; $51fd
	pop af ; $51fe
	ret ; $51ff
Func_0a_5200:
	push bc ; $5200
	push de ; $5201
	push hl ; $5202
	ld hl, $d000 ; $5203
	ld de, $01c0 ; $5206
	ld a, $00 ; $5209
	call Func_0a_51cf ; $520b
	ld e, d ; $520e
	ld d, h ; $520f
	rst Rst18 ; $5210
	add a, [hl] ; $5211
	ld a, [bc] ; $5212
	ld d, a ; $5213
	ld e, $00 ; $5214
	and a, $0f ; $5216
	cp a, $08 ; $5218
	jr nz, Label_0a_5222 ; $521a
	ld a, d ; $521c
	swap a ; $521d
	and a, $0f ; $521f
	ld e, a ; $5221
Label_0a_5222:
	ld a, e ; $5222
	pop hl ; $5223
	pop de ; $5224
	pop bc ; $5225
	ret ; $5226
Func_0a_5227:
	push bc ; $5227
	push de ; $5228
	push hl ; $5229
	ld a, $04 ; $522a
	ldh [$ff96], a ; $522c
	ldh [rWBK], a ; $522e
	rst Rst18 ; $5230
	ld h, $04 ; $5231
	ld hl, $d000 ; $5233
	ld de, $01c0 ; $5236
	ld a, $00 ; $5239
	call Func_0a_51cf ; $523b
	push de ; $523e
	ld e, d ; $523f
	ld d, h ; $5240
	rst Rst18 ; $5241
	add a, [hl] ; $5242
	ld a, [bc] ; $5243
	and a, $0f ; $5244
	pop de ; $5246
	cp a, $0c ; $5247
	jr nz, Label_0a_5256 ; $5249
	ld hl, $d000 ; $524b
	ld de, $03c0 ; $524e
	ld a, $00 ; $5251
	call Func_0a_51cf ; $5253
Label_0a_5256:
	rst Rst18 ; $5256
	inc h ; $5257
	inc b ; $5258
	and a, a ; $5259
	jr nz, Label_0a_527b ; $525a
	ld hl, $d000 ; $525c
	ld de, $0180 ; $525f
	ld a, $f0 ; $5262
	call Func_0a_51cf ; $5264
	rst Rst18 ; $5267
	inc h ; $5268
	inc b ; $5269
	and a, a ; $526a
	jr nz, Label_0a_527b ; $526b
	ld hl, $d000 ; $526d
	ld de, $0180 ; $5270
	ld a, $10 ; $5273
	call Func_0a_51cf ; $5275
	rst Rst18 ; $5278
	inc h ; $5279
	inc b ; $527a
Label_0a_527b:
	pop hl ; $527b
	pop de ; $527c
	pop bc ; $527d
	ret ; $527e
	INCBIN "data/bank_00a/d_527f.bin" ; $527f, 118 bytes
Func_0a_52f5:
	push af ; $52f5
	push bc ; $52f6
	push de ; $52f7
	push hl ; $52f8
	ldh a, [$ff96] ; $52f9
	push af ; $52fb
	call Func_0a_4892 ; $52fc
	ld a, $05 ; $52ff
	ldh [$ff96], a ; $5301
	ldh [rWBK], a ; $5303
	ld a, [wMessageSpeed] ; $5305
	set 7, a ; $5308
	ld [wMessageSpeed], a ; $530a
	ld a, $83 ; $530d
	rst Rst18 ; $530f
	ld [hl], $05 ; $5310
	ld b, $50 ; $5312
Label_0a_5314:
	call Func_00_2631 ; $5314
	ldh a, [hPlayerInputFlags] ; $5317
	and a, a ; $5319
	jr nz, Label_0a_531f ; $531a
	dec b ; $531c
	jr nz, Label_0a_5314 ; $531d
Label_0a_531f:
	rst Rst18 ; $531f
	ld a, [bc] ; $5320
	dec b ; $5321
	ld a, $05 ; $5322
	ldh [$ff96], a ; $5324
	ldh [rWBK], a ; $5326
	ld hl, $c8a4 ; $5328
	res 7, [hl] ; $532b
	pop af ; $532d
	ldh [$ff96], a ; $532e
	ldh [rWBK], a ; $5330
	pop hl ; $5332
	pop de ; $5333
	pop bc ; $5334
	pop af ; $5335
	ret ; $5336
	ld hl, $5341 ; $5337
	ld de, $0b05 ; $533a
	call Func_00_05b0 ; $533d
	ret ; $5340
	INCBIN "data/bank_00a/d_5341.bin" ; $5341, 40 bytes
Func_0a_5369:
	push bc ; $5369
	push de ; $536a
	push hl ; $536b
	ld bc, $d000 ; $536c
	ld hl, $000d ; $536f
	add hl, bc ; $5372
	ld d, [hl] ; $5373
	ld hl, $000f ; $5374
	add hl, bc ; $5377
	ld e, [hl] ; $5378
	rst Rst18 ; $5379
	add a, [hl] ; $537a
	ld a, [bc] ; $537b
	ld e, a ; $537c
	ld d, $00 ; $537d
	and a, $0f ; $537f
	cp a, $01 ; $5381
	jr nz, Label_0a_539d ; $5383
	ld a, e ; $5385
	swap a ; $5386
	and a, $0f ; $5388
	ld d, a ; $538a
	ld hl, $c290 ; $538b
	ld a, [hl+] ; $538e
	ld h, [hl] ; $538f
	ld l, a ; $5390
	ld a, [$c29b] ; $5391
	call Func_0a_53e4 ; $5394
	ld a, h ; $5397
	or a, l ; $5398
	jr nz, Label_0a_539d ; $5399
	ld d, $00 ; $539b
Label_0a_539d:
	ld a, d ; $539d
	pop hl ; $539e
	pop de ; $539f
	pop bc ; $53a0
	ret ; $53a1
	INCBIN "data/bank_00a/d_53a2.bin" ; $53a2, 27 bytes
Func_0a_53bd:
	push bc ; $53bd
	push hl ; $53be
	ld a, $04 ; $53bf
	ldh [$ff96], a ; $53c1
	ldh [rWBK], a ; $53c3
	ld c, $01 ; $53c5
	ld a, b ; $53c7
	cp a, $ff ; $53c8
	jr z, Label_0a_53e0 ; $53ca
	ld a, [$daea] ; $53cc
	rlca ; $53cf
	rlca ; $53d0
	and a, $03 ; $53d1
	add a, $b9 ; $53d3
	ld l, a ; $53d5
	adc a, $53 ; $53d6
	sub a, l ; $53d8
	ld h, a ; $53d9
	ld a, [hl] ; $53da
	and a, b ; $53db
	jr nz, Label_0a_53e0 ; $53dc
	ld c, $00 ; $53de
Label_0a_53e0:
	ld a, c ; $53e0
	pop hl ; $53e1
	pop bc ; $53e2
	ret ; $53e3
Func_0a_53e4:
	push af ; $53e4
	push bc ; $53e5
	push de ; $53e6
Label_0a_53e7:
	ld a, [$c29b] ; $53e7
	call Func_00_063d ; $53ea
	ld a, c ; $53ed
	cp a, $ff ; $53ee
	jr z, Label_0a_5416 ; $53f0
	cp a, d ; $53f2
	jr nz, Label_0a_5410 ; $53f3
	call Func_0a_53bd ; $53f5
	and a, a ; $53f8
	jr z, Label_0a_5410 ; $53f9
	inc hl ; $53fb
	inc hl ; $53fc
	ld a, [$c29b] ; $53fd
	call Func_00_063d ; $5400
	dec hl ; $5403
	dec hl ; $5404
	push de ; $5405
	ld e, c ; $5406
	ld d, b ; $5407
	rst Rst18 ; $5408
	inc d ; $5409
	inc b ; $540a
	pop de ; $540b
	jr nz, Label_0a_5410 ; $540c
	jr Label_0a_5419 ; $540e
Label_0a_5410:
	ld bc, $0008 ; $5410
	add hl, bc ; $5413
	jr Label_0a_53e7 ; $5414
Label_0a_5416:
	ld hl, $0000 ; $5416
Label_0a_5419:
	pop de ; $5419
	pop bc ; $541a
	pop af ; $541b
	ret ; $541c
Func_0a_541d:
	push af ; $541d
	push bc ; $541e
	ld b, a ; $541f
	push de ; $5420
	push hl ; $5421
	ldh a, [$ff96] ; $5422
	push af ; $5424
	ld a, $01 ; $5425
	ld [$c2da], a ; $5427
	ld a, h ; $542a
	or a, l ; $542b
	jr z, Label_0a_545c ; $542c
	ld a, h ; $542e
	and a, $c0 ; $542f
	jr nz, Label_0a_543c ; $5431
	call Func_0a_4892 ; $5433
	ld a, b ; $5436
	rst Rst18 ; $5437
	inc [hl] ; $5438
	dec b ; $5439
	jr Label_0a_545c ; $543a
Label_0a_543c:
	rst Rst18 ; $543c
	nop ; $543d
	ld a, [bc] ; $543e
	push hl ; $543f
	ld a, $04 ; $5440
	ldh [$ff96], a ; $5442
	ldh [rWBK], a ; $5444
	ld hl, $d030 ; $5446
	res 0, [hl] ; $5449
	ld hl, $d014 ; $544b
	ld a, [$daea] ; $544e
	ld [hl], a ; $5451
	pop hl ; $5452
	ld a, [$c29b] ; $5453
	call Func_00_015e ; $5456
	rst Rst18 ; $5459
	ld [bc], a ; $545a
	ld a, [bc] ; $545b
Label_0a_545c:
	pop af ; $545c
	ldh [$ff96], a ; $545d
	ldh [rWBK], a ; $545f
	pop hl ; $5461
	pop de ; $5462
	pop bc ; $5463
	pop af ; $5464
	ret ; $5465
Func_0a_5466:
	push af ; $5466
	push bc ; $5467
	push de ; $5468
	push hl ; $5469
	push af ; $546a
	push hl ; $546b
	ld a, $04 ; $546c
	ldh [$ff96], a ; $546e
	ldh [rWBK], a ; $5470
	rst Rst18 ; $5472
	nop ; $5473
	inc b ; $5474
	ld hl, $c29a ; $5475
	ld c, [hl] ; $5478
	ld hl, $c298 ; $5479
	ld a, [hl+] ; $547c
	ld d, [hl] ; $547d
	ld e, a ; $547e
	ld hl, $c296 ; $547f
	ld a, [hl+] ; $5482
	ld h, [hl] ; $5483
	ld l, a ; $5484
	rst Rst18 ; $5485
	jr Label_0a_548c ; $5486
	pop hl ; $5488
	pop af ; $5489
	rst Rst18 ; $548a
	ld a, [de] ; $548b
Label_0a_548c:
	inc b ; $548c
	rst Rst18 ; $548d
	ld a, [bc] ; $548e
	inc b ; $548f
	pop hl ; $5490
	pop de ; $5491
	pop bc ; $5492
	pop af ; $5493
	ret ; $5494
Func_0a_5495:
	push af ; $5495
	push bc ; $5496
	push de ; $5497
	push hl ; $5498
	ldh a, [$ff96] ; $5499
	push af ; $549b
	ld a, $90 ; $549c
	ldh [rWY], a ; $549e
	ld hl, $c292 ; $54a0
	ld a, [hl+] ; $54a3
	ld h, [hl] ; $54a4
	ld l, a ; $54a5
	ld a, $00 ; $54a6
	call Func_0a_541d ; $54a8
	pop af ; $54ab
	ldh [$ff96], a ; $54ac
	ldh [rWBK], a ; $54ae
	pop hl ; $54b0
	pop de ; $54b1
	pop bc ; $54b2
	pop af ; $54b3
	ret ; $54b4
Func_0a_54b5:
	ld [$c2db], a ; $54b5
	cp a, $02 ; $54b8
	jp z, Label_0a_5573 ; $54ba
	push af ; $54bd
	push bc ; $54be
	push de ; $54bf
	push hl ; $54c0
	ld d, a ; $54c1
	ld hl, $c28c ; $54c2
	ld a, [hl+] ; $54c5
	ld h, [hl] ; $54c6
	ld l, a ; $54c7
	call Func_0a_53e4 ; $54c8
	ld a, h ; $54cb
	or a, l ; $54cc
	jp z, Label_0a_556e ; $54cd
	ld a, [$c29b] ; $54d0
	ld de, $c2c0 ; $54d3
	ld bc, $0008 ; $54d6
	call Func_00_067a ; $54d9
	ld hl, $c2c6 ; $54dc
	ld b, [hl] ; $54df
	ld a, $04 ; $54e0
	ldh [$ff96], a ; $54e2
	ldh [rWBK], a ; $54e4
	ld hl, $c2c0 ; $54e6
	ld a, [hl] ; $54e9
	call Func_0a_4312 ; $54ea
	ld e, l ; $54ed
	ld d, h ; $54ee
	ld hl, $0019 ; $54ef
	add hl, de ; $54f2
	ld a, [hl] ; $54f3
	ld [$c2d8], a ; $54f4
	ld a, $01 ; $54f7
	ld [hl], a ; $54f9
	ld a, b ; $54fa
	and a, $08 ; $54fb
	jr z, Label_0a_5514 ; $54fd
	ld hl, $002e ; $54ff
	add hl, de ; $5502
	ld a, [hl] ; $5503
	ld [$c2d9], a ; $5504
	ld a, $01 ; $5507
	push bc ; $5509
	push de ; $550a
	ld c, e ; $550b
	ld b, d ; $550c
	ld d, $01 ; $550d
	rst Rst18 ; $550f
	ld d, $04 ; $5510
	pop de ; $5512
	pop bc ; $5513
Label_0a_5514:
	ld a, b ; $5514
	and a, $10 ; $5515
	jr z, Label_0a_5521 ; $5517
	ld hl, $0005 ; $5519
	add hl, de ; $551c
	set 0, [hl] ; $551d
	set 1, [hl] ; $551f
Label_0a_5521:
	bit 0, b ; $5521
	jr z, Label_0a_5530 ; $5523
	ld hl, $0014 ; $5525
	add hl, de ; $5528
	ld c, [hl] ; $5529
	ld a, [$daea] ; $552a
	add a, $80 ; $552d
	ld [hl], a ; $552f
Label_0a_5530:
	push de ; $5530
	ld hl, $c2c4 ; $5531
	ld a, [hl+] ; $5534
	ld h, [hl] ; $5535
	ld l, a ; $5536
	ld a, [$c2c0] ; $5537
	call Func_0a_541d ; $553a
	pop de ; $553d
	bit 1, b ; $553e
	jr z, Label_0a_5547 ; $5540
	ld hl, $0014 ; $5542
	add hl, de ; $5545
	ld [hl], c ; $5546
Label_0a_5547:
	ld a, b ; $5547
	and a, $10 ; $5548
	jr z, Label_0a_5554 ; $554a
	ld hl, $0005 ; $554c
	add hl, de ; $554f
	res 0, [hl] ; $5550
	res 1, [hl] ; $5552
Label_0a_5554:
	ld a, b ; $5554
	and a, $08 ; $5555
	jr z, Label_0a_5566 ; $5557
	push bc ; $5559
	push de ; $555a
	ld c, e ; $555b
	ld b, d ; $555c
	ld a, [$c2d9] ; $555d
	ld d, a ; $5560
	rst Rst18 ; $5561
	ld d, $04 ; $5562
	pop de ; $5564
	pop bc ; $5565
Label_0a_5566:
	ld hl, $0019 ; $5566
	add hl, de ; $5569
	ld a, [$c2d8] ; $556a
	ld [hl], a ; $556d
Label_0a_556e:
	pop hl ; $556e
	pop de ; $556f
	pop bc ; $5570
	pop af ; $5571
	ret ; $5572
Label_0a_5573:
	ret ; $5573
Func_0a_5574:
	push af ; $5574
	push bc ; $5575
	push de ; $5576
	push hl ; $5577
	ld [$c2db], a ; $5578
	ld d, a ; $557b
	ld hl, $c28e ; $557c
	ld a, [hl+] ; $557f
	ld h, [hl] ; $5580
	ld l, a ; $5581
	call Func_0a_53e4 ; $5582
	ld a, h ; $5585
	or a, l ; $5586
	jr z, Label_0a_55a0 ; $5587
	ld a, [$c29b] ; $5589
	ld de, $c2c0 ; $558c
	ld bc, $0008 ; $558f
	call Func_00_067a ; $5592
	ld hl, $c2c4 ; $5595
	ld a, [hl+] ; $5598
	ld h, [hl] ; $5599
	ld l, a ; $559a
	ld a, $00 ; $559b
	call Func_0a_541d ; $559d
Label_0a_55a0:
	pop hl ; $55a0
	pop de ; $55a1
	pop bc ; $55a2
	pop af ; $55a3
	ret ; $55a4
Func_0a_55a5:
	push af ; $55a5
	push bc ; $55a6
	push de ; $55a7
	push hl ; $55a8
	ld [$c2db], a ; $55a9
	ld d, a ; $55ac
	ld hl, $c290 ; $55ad
	ld a, [hl+] ; $55b0
	ld h, [hl] ; $55b1
	ld l, a ; $55b2
	call Func_0a_53e4 ; $55b3
	ld a, h ; $55b6
	or a, l ; $55b7
	jr z, Label_0a_55d8 ; $55b8
	ld a, [$c29b] ; $55ba
	ld de, $c2c0 ; $55bd
	ld bc, $0008 ; $55c0
	call Func_00_067a ; $55c3
	ld a, [$c2c6] ; $55c6
	cp a, $01 ; $55c9
	jr z, Label_0a_55d8 ; $55cb
	ld hl, $c2c4 ; $55cd
	ld a, [hl+] ; $55d0
	ld h, [hl] ; $55d1
	ld l, a ; $55d2
	ld a, $00 ; $55d3
	call Func_0a_541d ; $55d5
Label_0a_55d8:
	pop hl ; $55d8
	pop de ; $55d9
	pop bc ; $55da
	pop af ; $55db
	ret ; $55dc
Func_0a_55dd:
	push af ; $55dd
	push bc ; $55de
	push de ; $55df
	push hl ; $55e0
	ld d, a ; $55e1
	ld hl, $c290 ; $55e2
	ld a, [hl+] ; $55e5
	ld h, [hl] ; $55e6
	ld l, a ; $55e7
	call Func_0a_53e4 ; $55e8
	ld a, h ; $55eb
	or a, l ; $55ec
	jr z, Label_0a_5606 ; $55ed
	ld a, [$c29b] ; $55ef
	ld de, $c2c0 ; $55f2
	ld bc, $0008 ; $55f5
	call Func_00_067a ; $55f8
	ld hl, $c2c4 ; $55fb
	ld a, [hl+] ; $55fe
	ld h, [hl] ; $55ff
	ld l, a ; $5600
	ld a, $00 ; $5601
	call Func_0a_541d ; $5603
Label_0a_5606:
	pop hl ; $5606
	pop de ; $5607
	pop bc ; $5608
	pop af ; $5609
	ret ; $560a
Func_0a_560b:
	push af ; $560b
	push bc ; $560c
	push de ; $560d
	push hl ; $560e
	ld [$c2db], a ; $560f
	ld d, a ; $5612
	ld hl, $c288 ; $5613
	ld a, [hl+] ; $5616
	ld h, [hl] ; $5617
	ld l, a ; $5618
	call Func_0a_53e4 ; $5619
	ld a, h ; $561c
	or a, l ; $561d
	jr z, Label_0a_5643 ; $561e
	ld a, [$c29b] ; $5620
	ld de, $c2c0 ; $5623
	ld bc, $0008 ; $5626
	call Func_00_067a ; $5629
	ld hl, $c2c4 ; $562c
	ld a, [hl+] ; $562f
	ld h, [hl] ; $5630
	ld l, a ; $5631
	ld a, $00 ; $5632
	call Func_0a_541d ; $5634
	ld a, [$c2c6] ; $5637
	ld [wStoryModeCurrentLocation], a ; $563a
	ld a, [$c2c7] ; $563d
	ld [$c295], a ; $5640
Label_0a_5643:
	xor a, a ; $5643
	ld a, a ; $5644
	ldh [$ff97], a ; $5645
	ld [$4000], a ; $5647
	pop hl ; $564a
	pop de ; $564b
	pop bc ; $564c
	pop af ; $564d
	ret ; $564e
	INCBIN "data/bank_00a/d_564f.bin" ; $564f, 255 bytes
Func_0a_574e:
	ld h, a ; $574e
	add a, a ; $574f
	add a, h ; $5750
	add a, a ; $5751
	add a, $4f ; $5752
	ld l, a ; $5754
	adc a, $56 ; $5755
	sub a, l ; $5757
	ld h, a ; $5758
	ret ; $5759
	INCBIN "data/bank_00a/d_575a.bin" ; $575a, 259 bytes
	push af ; $585d
	push bc ; $585e
	push de ; $585f
	push hl ; $5860
	ld [$c32e], a ; $5861
	ld h, $00 ; $5864
	ld l, a ; $5866
	add hl, hl ; $5867
	add hl, hl ; $5868
	add hl, hl ; $5869
	add hl, hl ; $586a
	ld de, $59d9 ; $586b
	add hl, de ; $586e
	ld a, [hl+] ; $586f
	ld c, a ; $5870
	ld a, [hl+] ; $5871
	ld b, a ; $5872
	push bc ; $5873
	ld a, [hl+] ; $5874
	ld c, a ; $5875
	ld a, [hl+] ; $5876
	ld b, a ; $5877
	push bc ; $5878
	ld a, [hl+] ; $5879
	ld c, a ; $587a
	ld a, [hl+] ; $587b
	ld b, a ; $587c
	push bc ; $587d
	ld a, [hl+] ; $587e
	ld c, a ; $587f
	ld a, [hl+] ; $5880
	ld b, a ; $5881
	push bc ; $5882
	ld a, [hl+] ; $5883
	ld c, a ; $5884
	ld a, [hl+] ; $5885
	ld b, a ; $5886
	push bc ; $5887
	ld a, [hl+] ; $5888
	ld c, a ; $5889
	ld a, [hl+] ; $588a
	ld b, a ; $588b
	push bc ; $588c
	ld a, [hl+] ; $588d
	ld c, a ; $588e
	ld a, [hl+] ; $588f
	ld b, a ; $5890
	push bc ; $5891
	ld a, $01 ; $5892
	ldh [$ff96], a ; $5894
	ldh [rWBK], a ; $5896
	ld a, [hl+] ; $5898
	ld h, [hl] ; $5899
	ld l, a ; $589a
	ld de, $d000 ; $589b
	call DecompressDataFromBank ; $589e
	ld hl, $d000 ; $58a1
	ld de, $b000 ; $58a4
	ld c, $80 ; $58a7
	call Func_00_0480 ; $58a9
	ld hl, $d800 ; $58ac
	ld de, $a800 ; $58af
	ld c, $80 ; $58b2
	call Func_00_0480 ; $58b4
	ld a, $06 ; $58b7
	ldh [$ff96], a ; $58b9
	ldh [rWBK], a ; $58bb
	pop hl ; $58bd
	ld de, $d800 ; $58be
	pop hl ; $58c1
	ld de, $d400 ; $58c2
	call DecompressDataFromBank ; $58c5
	pop hl ; $58c8
	ld de, $d000 ; $58c9
	call DecompressDataFromBank ; $58cc
	ld a, $02 ; $58cf
	ldh [$ff96], a ; $58d1
	ldh [rWBK], a ; $58d3
	pop hl ; $58d5
	ld de, $d000 ; $58d6
	call DecompressDataFromBank ; $58d9
	ld a, $03 ; $58dc
	ldh [$ff96], a ; $58de
	ldh [rWBK], a ; $58e0
	pop hl ; $58e2
	ld de, $d000 ; $58e3
	call DecompressDataFromBank ; $58e6
	ld a, $01 ; $58e9
	ldh [$ff96], a ; $58eb
	ldh [rWBK], a ; $58ed
	pop hl ; $58ef
	ld de, $d000 ; $58f0
	ld bc, $0040 ; $58f3
	call CopyDataFromBank ; $58f6
	ld hl, $d010 ; $58f9
	ld de, $0206 ; $58fc
	call Func_00_05b0 ; $58ff
	ld a, $06 ; $5902
	ldh [$ff96], a ; $5904
	ldh [rWBK], a ; $5906
	pop hl ; $5908
	ld de, $dc08 ; $5909
	ld bc, $0088 ; $590c
	call CopyDataFromBank ; $590f
	ld hl, $dc0a ; $5912
	ld a, [hl+] ; $5915
	ld [$c329], a ; $5916
	ld a, [hl+] ; $5919
	ld [$c32a], a ; $591a
	ld a, [hl+] ; $591d
	ld [$c32b], a ; $591e
	ld a, [hl+] ; $5921
	ld [$c32c], a ; $5922
	ld a, [$c32e] ; $5925
	call Func_0a_639b ; $5928
	pop hl ; $592b
	pop de ; $592c
	pop bc ; $592d
	pop af ; $592e
	ret ; $592f
	push af ; $5930
	push bc ; $5931
	push de ; $5932
	push hl ; $5933
	ld a, $25 ; $5934
	ld [$c32d], a ; $5936
	xor a, a ; $5939
	ldh [$ff8a], a ; $593a
	ldh [$ff8b], a ; $593c
	ldh [$ffb9], a ; $593e
	ldh [$ffb8], a ; $5940
	ld [$c320], a ; $5942
	ld [$c321], a ; $5945
	ld [$c322], a ; $5948
	ld [$c323], a ; $594b
	ld [$c324], a ; $594e
	ld [$c325], a ; $5951
	ld [$c329], a ; $5954
	ld [$c32a], a ; $5957
	ld a, $40 ; $595a
	ld [$c32b], a ; $595c
	ld [$c32c], a ; $595f
	ld a, $0f ; $5962
	ld hl, $5976 ; $5964
	call Func_00_1b6a ; $5967
	pop hl ; $596a
	pop de ; $596b
	pop bc ; $596c
	pop af ; $596d
	ret ; $596e
	INCBIN "data/bank_00a/d_596f.bin" ; $596f, 7 bytes
	ld a, [$c325] ; $5976
	ld h, a ; $5979
	ld a, [$c323] ; $597a
	sub a, h ; $597d
	jr z, Label_0a_5992 ; $597e
	bit 7, a ; $5980
	jr nz, Label_0a_598c ; $5982
	ld bc, $fb13 ; $5984
	call Func_00_222c ; $5987
	jr Label_0a_5992 ; $598a
Label_0a_598c:
	ld bc, $fb00 ; $598c
	call Func_00_222c ; $598f
Label_0a_5992:
	ld a, [$c324] ; $5992
	ld h, a ; $5995
	ld a, [$c321] ; $5996
	sub a, h ; $5999
	jr z, Label_0a_59ae ; $599a
	bit 7, a ; $599c
	jr nz, Label_0a_59a8 ; $599e
	ld bc, $15fa ; $59a0
	call Func_00_2299 ; $59a3
	jr Label_0a_59ae ; $59a6
Label_0a_59a8:
	ld bc, $00fa ; $59a8
	call Func_00_2299 ; $59ab
Label_0a_59ae:
	ld a, [$c322] ; $59ae
	ld l, a ; $59b1
	ld a, [$c323] ; $59b2
	ld h, a ; $59b5
	ld [$c325], a ; $59b6
	add hl, hl ; $59b9
	add hl, hl ; $59ba
	add hl, hl ; $59bb
	ld a, h ; $59bc
	ld hl, $c369 ; $59bd
	add a, [hl] ; $59c0
	ldh [$ff8a], a ; $59c1
	ld a, [$c320] ; $59c3
	ld l, a ; $59c6
	ld a, [$c321] ; $59c7
	ld h, a ; $59ca
	ld [$c324], a ; $59cb
	add hl, hl ; $59ce
	add hl, hl ; $59cf
	add hl, hl ; $59d0
	ld a, h ; $59d1
	ld hl, $c368 ; $59d2
	add a, [hl] ; $59d5
	ldh [$ff8b], a ; $59d6
	ret ; $59d8
	INCBIN "data/bank_00a/d_59d9.bin" ; $59d9, 592 bytes
	push af ; $5c29
	push bc ; $5c2a
	push de ; $5c2b
	push hl ; $5c2c
	or a, a ; $5c2d
	jr z, Label_0a_5c3b ; $5c2e
	ld a, [$c321] ; $5c30
	ld h, a ; $5c33
	ld a, [$c323] ; $5c34
	ld l, a ; $5c37
	jp Label_0a_5c40 ; $5c38
Label_0a_5c3b:
	call Func_0a_6235 ; $5c3b
	ld h, b ; $5c3e
	ld l, d ; $5c3f
Label_0a_5c40:
	push hl ; $5c40
	ld a, l ; $5c41
	and a, $1f ; $5c42
	ld l, a ; $5c44
	ld a, h ; $5c45
	and a, $1f ; $5c46
	ld h, $00 ; $5c48
	add hl, hl ; $5c4a
	add hl, hl ; $5c4b
	add hl, hl ; $5c4c
	add hl, hl ; $5c4d
	add hl, hl ; $5c4e
	add a, l ; $5c4f
	ld l, a ; $5c50
	ld de, $9800 ; $5c51
	add hl, de ; $5c54
	ld e, l ; $5c55
	ld d, h ; $5c56
	pop hl ; $5c57
	push de ; $5c58
	ld a, h ; $5c59
	ld h, $00 ; $5c5a
	add hl, hl ; $5c5c
	add hl, hl ; $5c5d
	add hl, hl ; $5c5e
	add hl, hl ; $5c5f
	add hl, hl ; $5c60
	add hl, hl ; $5c61
	add a, l ; $5c62
	ld l, a ; $5c63
	ld de, $d000 ; $5c64
	add hl, de ; $5c67
	pop de ; $5c68
	push hl ; $5c69
	push de ; $5c6a
	ld a, $02 ; $5c6b
	ldh [$ff96], a ; $5c6d
	ldh [rWBK], a ; $5c6f
	ld a, $01 ; $5c71
	ldh [rVBK], a ; $5c73
	ld b, $15 ; $5c75
Label_0a_5c77:
	ld c, $17 ; $5c77
	push de ; $5c79
	push hl ; $5c7a
Label_0a_5c7b:
	ld a, [hl+] ; $5c7b
	ld [de], a ; $5c7c
	inc de ; $5c7d
	ld a, l ; $5c7e
	and a, $3f ; $5c7f
	jr nz, Label_0a_5c8b ; $5c81
	push de ; $5c83
	ld de, $ffc0 ; $5c84
	add hl, de ; $5c87
	pop de ; $5c88
	jr Label_0a_5c90 ; $5c89
Label_0a_5c8b:
	ld a, e ; $5c8b
	and a, $1f ; $5c8c
	jr nz, Label_0a_5c98 ; $5c8e
Label_0a_5c90:
	push hl ; $5c90
	ld hl, $ffe0 ; $5c91
	add hl, de ; $5c94
	ld e, l ; $5c95
	ld d, h ; $5c96
	pop hl ; $5c97
Label_0a_5c98:
	dec c ; $5c98
	jr nz, Label_0a_5c7b ; $5c99
	pop hl ; $5c9b
	ld a, $40 ; $5c9c
	add a, l ; $5c9e
	ld l, a ; $5c9f
	jr nc, Label_0a_5ca9 ; $5ca0
	ld a, h ; $5ca2
	inc a ; $5ca3
	and a, $0f ; $5ca4
	or a, $d0 ; $5ca6
	ld h, a ; $5ca8
Label_0a_5ca9:
	pop de ; $5ca9
	ld a, $20 ; $5caa
	add a, e ; $5cac
	ld e, a ; $5cad
	jr nc, Label_0a_5cb5 ; $5cae
	ld a, d ; $5cb0
	inc a ; $5cb1
	res 2, a ; $5cb2
	ld d, a ; $5cb4
Label_0a_5cb5:
	dec b ; $5cb5
	jr nz, Label_0a_5c77 ; $5cb6
	pop de ; $5cb8
	pop hl ; $5cb9
	ld a, $03 ; $5cba
	ldh [$ff96], a ; $5cbc
	ldh [rWBK], a ; $5cbe
	xor a, a ; $5cc0
	ldh [rVBK], a ; $5cc1
	ld b, $15 ; $5cc3
Label_0a_5cc5:
	ld c, $17 ; $5cc5
	push de ; $5cc7
	push hl ; $5cc8
Label_0a_5cc9:
	ld a, [hl+] ; $5cc9
	ld [de], a ; $5cca
	inc de ; $5ccb
	ld a, l ; $5ccc
	and a, $3f ; $5ccd
	jr nz, Label_0a_5cd9 ; $5ccf
	push de ; $5cd1
	ld de, $ffc0 ; $5cd2
	add hl, de ; $5cd5
	pop de ; $5cd6
	jr Label_0a_5cde ; $5cd7
Label_0a_5cd9:
	ld a, e ; $5cd9
	and a, $1f ; $5cda
	jr nz, Label_0a_5ce6 ; $5cdc
Label_0a_5cde:
	push hl ; $5cde
	ld hl, $ffe0 ; $5cdf
	add hl, de ; $5ce2
	ld e, l ; $5ce3
	ld d, h ; $5ce4
	pop hl ; $5ce5
Label_0a_5ce6:
	dec c ; $5ce6
	jr nz, Label_0a_5cc9 ; $5ce7
	pop hl ; $5ce9
	ld a, $40 ; $5cea
	add a, l ; $5cec
	ld l, a ; $5ced
	jr nc, Label_0a_5cf7 ; $5cee
	ld a, h ; $5cf0
	inc a ; $5cf1
	and a, $0f ; $5cf2
	or a, $d0 ; $5cf4
	ld h, a ; $5cf6
Label_0a_5cf7:
	pop de ; $5cf7
	ld a, $20 ; $5cf8
	add a, e ; $5cfa
	ld e, a ; $5cfb
	jr nc, Label_0a_5d03 ; $5cfc
	ld a, d ; $5cfe
	inc a ; $5cff
	res 2, a ; $5d00
	ld d, a ; $5d02
Label_0a_5d03:
	dec b ; $5d03
	jr nz, Label_0a_5cc5 ; $5d04
	pop hl ; $5d06
	pop de ; $5d07
	pop bc ; $5d08
	pop af ; $5d09
	ret ; $5d0a
Func_0a_5d0b:
	push af ; $5d0b
	push bc ; $5d0c
	push de ; $5d0d
	ld b, a ; $5d0e
	ld a, [$c32e] ; $5d0f
	ld h, $00 ; $5d12
	ld l, a ; $5d14
	add hl, hl ; $5d15
	add hl, hl ; $5d16
	add hl, hl ; $5d17
	add hl, hl ; $5d18
	ld de, $59d9 ; $5d19
	add hl, de ; $5d1c
	ld e, b ; $5d1d
	sla e ; $5d1e
	ld d, $00 ; $5d20
	add hl, de ; $5d22
	ld a, [hl+] ; $5d23
	ld h, [hl] ; $5d24
	ld l, a ; $5d25
	pop de ; $5d26
	pop bc ; $5d27
	pop af ; $5d28
	ret ; $5d29
	INCBIN "data/bank_00a/d_5d2a.bin" ; $5d2a, 1291 bytes
Func_0a_6235:
	ld a, $04 ; $6235
	ldh [$ff96], a ; $6237
	ldh [rWBK], a ; $6239
	ld hl, $d00c ; $623b
	ld a, [hl+] ; $623e
	ld b, [hl] ; $623f
	ld c, a ; $6240
	inc hl ; $6241
	ld a, [hl+] ; $6242
	ld d, [hl] ; $6243
	ld e, a ; $6244
	push de ; $6245
	ld hl, $f610 ; $6246
	add hl, bc ; $6249
	ld a, [$c329] ; $624a
	ld d, a ; $624d
	ld a, h ; $624e
	sub a, d ; $624f
	bit 7, a ; $6250
	jr z, Label_0a_6259 ; $6252
	ld h, d ; $6254
	ld l, $00 ; $6255
	jr Label_0a_6268 ; $6257
Label_0a_6259:
	ld a, [$c32b] ; $6259
	sub a, $14 ; $625c
	ld d, a ; $625e
	ld a, h ; $625f
	sub a, d ; $6260
	bit 7, a ; $6261
	jr nz, Label_0a_6268 ; $6263
	ld h, d ; $6265
	ld l, $00 ; $6266
Label_0a_6268:
	ld b, h ; $6268
	ld c, l ; $6269
	pop de ; $626a
	ld hl, $f510 ; $626b
	add hl, de ; $626e
	ld a, [$c32a] ; $626f
	ld d, a ; $6272
	ld a, h ; $6273
	sub a, d ; $6274
	bit 7, a ; $6275
	jr z, Label_0a_627e ; $6277
	ld h, d ; $6279
	ld l, $00 ; $627a
	jr Label_0a_628d ; $627c
Label_0a_627e:
	ld a, [$c32c] ; $627e
	sub a, $12 ; $6281
	ld d, a ; $6283
	ld a, h ; $6284
	sub a, d ; $6285
	bit 7, a ; $6286
	jr nz, Label_0a_628d ; $6288
	ld h, d ; $628a
	ld l, $00 ; $628b
Label_0a_628d:
	ld d, h ; $628d
	ld e, l ; $628e
	ld hl, $c320 ; $628f
	ld a, c ; $6292
	ld [hl+], a ; $6293
	ld a, b ; $6294
	ld [hl+], a ; $6295
	ld a, e ; $6296
	ld [hl+], a ; $6297
	ld a, d ; $6298
	ld [hl], a ; $6299
	ret ; $629a
	INCBIN "data/bank_00a/d_629b.bin" ; $629b, 93 bytes
	push af ; $62f8
	push bc ; $62f9
	push de ; $62fa
	push hl ; $62fb
	ld [$c32e], a ; $62fc
	ld h, $00 ; $62ff
	ld l, a ; $6301
	add hl, hl ; $6302
	add hl, hl ; $6303
	add hl, hl ; $6304
	add hl, hl ; $6305
	ld de, $59d9 ; $6306
	add hl, de ; $6309
	inc hl ; $630a
	inc hl ; $630b
	ld a, [hl+] ; $630c
	ld c, a ; $630d
	ld a, [hl+] ; $630e
	ld b, a ; $630f
	push bc ; $6310
	ld a, [hl+] ; $6311
	ld c, a ; $6312
	ld a, [hl+] ; $6313
	ld b, a ; $6314
	push bc ; $6315
	ld a, [hl+] ; $6316
	ld c, a ; $6317
	ld a, [hl+] ; $6318
	ld b, a ; $6319
	push bc ; $631a
	ld a, [hl+] ; $631b
	ld c, a ; $631c
	ld a, [hl+] ; $631d
	ld b, a ; $631e
	push bc ; $631f
	ld a, [hl+] ; $6320
	ld c, a ; $6321
	ld a, [hl+] ; $6322
	ld b, a ; $6323
	push bc ; $6324
	inc hl ; $6325
	inc hl ; $6326
	ld a, $01 ; $6327
	ldh [$ff96], a ; $6329
	ldh [rWBK], a ; $632b
	ld a, [hl+] ; $632d
	ld h, [hl] ; $632e
	ld l, a ; $632f
	ld de, $d000 ; $6330
	call DecompressDataFromBank ; $6333
	ld hl, $d000 ; $6336
	ld de, $b000 ; $6339
	ld c, $80 ; $633c
	call Func_00_0480 ; $633e
	ld hl, $d800 ; $6341
	ld de, $a800 ; $6344
	ld c, $80 ; $6347
	call Func_00_0480 ; $6349
	ld a, $04 ; $634c
	ldh [$ff96], a ; $634e
	ldh [rWBK], a ; $6350
	pop hl ; $6352
	ld de, $dea8 ; $6353
	ld bc, $0028 ; $6356
	call CopyDataFromBank ; $6359
	pop hl ; $635c
	ld de, $de80 ; $635d
	ld bc, $0028 ; $6360
	call CopyDataFromBank ; $6363
	ld a, $02 ; $6366
	ldh [$ff96], a ; $6368
	ldh [rWBK], a ; $636a
	pop hl ; $636c
	ld de, $dc00 ; $636d
	call DecompressDataFromBank ; $6370
	pop hl ; $6373
	ld de, $d800 ; $6374
	call DecompressDataFromBank ; $6377
	pop hl ; $637a
	ld de, $d000 ; $637b
	ld bc, $0040 ; $637e
	call CopyDataFromBank ; $6381
	ld hl, $d010 ; $6384
	ld de, $0206 ; $6387
	call Func_00_05b0 ; $638a
	ld hl, $d028 ; $638d
	ld de, $0b01 ; $6390
	call Func_00_05b0 ; $6393
	pop hl ; $6396
	pop de ; $6397
	pop bc ; $6398
	pop af ; $6399
	ret ; $639a
Func_0a_639b:
	push af ; $639b
	push bc ; $639c
	push de ; $639d
	push hl ; $639e
	ldh a, [$ff96] ; $639f
	push af ; $63a1
	ld a, $05 ; $63a2
	ldh [$ff96], a ; $63a4
	ldh [rWBK], a ; $63a6
	ld a, $ff ; $63a8
	ld b, $01 ; $63aa
	ld hl, $c330 ; $63ac
	ld [hl+], a ; $63af
	ld [hl], b ; $63b0
	inc hl ; $63b1
	ld [hl+], a ; $63b2
	ld [hl], b ; $63b3
	inc hl ; $63b4
	ld [hl+], a ; $63b5
	ld [hl], b ; $63b6
	inc hl ; $63b7
	ld [hl+], a ; $63b8
	ld [hl], b ; $63b9
	inc hl ; $63ba
	ld [hl+], a ; $63bb
	ld [hl+], a ; $63bc
	ld [hl+], a ; $63bd
	ld [hl+], a ; $63be
	ld a, $00 ; $63bf
	call Func_0a_5d0b ; $63c1
	ld de, $da80 ; $63c4
	ld bc, $0088 ; $63c7
	call CopyDataFromBank ; $63ca
	ld hl, $da88 ; $63cd
	ld a, [hl] ; $63d0
	cp a, $fe ; $63d1
	jr nz, Label_0a_63d8 ; $63d3
	jp Label_0a_644c ; $63d5
Label_0a_63d8:
	add sp, -2 ; $63d8
	ld de, $c332 ; $63da
	push hl ; $63dd
	ld hl, sp + 2 ; $63de
	ld [hl], e ; $63e0
	inc hl ; $63e1
	ld [hl], d ; $63e2
	pop hl ; $63e3
	ld d, h ; $63e4
	ld e, l ; $63e5
	ld b, $ff ; $63e6
	ld c, $03 ; $63e8
	xor a, a ; $63ea
	ld hl, $c330 ; $63eb
	ld [hl], a ; $63ee
	ld hl, $c338 ; $63ef
	ld [hl], a ; $63f2
	inc hl ; $63f3
Label_0a_63f4:
	inc b ; $63f4
	ld a, [de] ; $63f5
	inc de ; $63f6
	cp a, $fe ; $63f7
	jr z, Label_0a_6430 ; $63f9
	cp a, $ff ; $63fb
	jr nz, Label_0a_63f4 ; $63fd
	inc b ; $63ff
	ld a, b ; $6400
	inc a ; $6401
	ld [hl], a ; $6402
	push de ; $6403
	push hl ; $6404
	ld hl, sp + 4 ; $6405
	ld e, [hl] ; $6407
	inc hl ; $6408
	ld d, [hl] ; $6409
	pop hl ; $640a
	ld [de], a ; $640b
	inc de ; $640c
	inc de ; $640d
	push hl ; $640e
	ld hl, sp + 4 ; $640f
	ld [hl], e ; $6411
	inc hl ; $6412
	ld [hl], d ; $6413
	pop hl ; $6414
	pop de ; $6415
	ld a, [de] ; $6416
	inc a ; $6417
	inc de ; $6418
	push hl ; $6419
	push de ; $641a
	ld d, a ; $641b
	ld a, $04 ; $641c
	sub a, c ; $641e
	ld hl, $c330 ; $641f
	ld e, a ; $6422
	ld a, d ; $6423
	ld d, $00 ; $6424
	add hl, de ; $6426
	add hl, de ; $6427
	inc hl ; $6428
	ld [hl], a ; $6429
	pop de ; $642a
	pop hl ; $642b
	inc hl ; $642c
	dec c ; $642d
	jr nz, Label_0a_63f4 ; $642e
Label_0a_6430:
	ld a, c ; $6430
	or a, a ; $6431
	jr z, Label_0a_6442 ; $6432
	ld a, $ff ; $6434
	dec hl ; $6436
	ld [hl], a ; $6437
	push hl ; $6438
	ld hl, sp + 2 ; $6439
	ld e, [hl] ; $643b
	inc hl ; $643c
	ld d, [hl] ; $643d
	pop hl ; $643e
	dec de ; $643f
	dec de ; $6440
	ld [de], a ; $6441
Label_0a_6442:
	ld a, $01 ; $6442
	ld hl, $6465 ; $6444
	call Func_00_1b6a ; $6447
	add sp, 2 ; $644a
Label_0a_644c:
	pop af ; $644c
	ldh [$ff96], a ; $644d
	ldh [rWBK], a ; $644f
	pop hl ; $6451
	pop de ; $6452
	pop bc ; $6453
	pop af ; $6454
	ret ; $6455
	INCBIN "data/bank_00a/d_6456.bin" ; $6456, 365 bytes
	ld a, [$c7be] ; $65c3
	and a, a ; $65c6
	ret z ; $65c7
	ld hl, $dc00 ; $65c8
	ld c, $0f ; $65cb
Label_0a_65cd:
	call Func_0a_65d8 ; $65cd
	ld de, $000e ; $65d0
	add hl, de ; $65d3
	dec c ; $65d4
	jr nz, Label_0a_65cd ; $65d5
	ret ; $65d7
Func_0a_65d8:
	bit 0, [hl] ; $65d8
	ret z ; $65da
	push af ; $65db
	push bc ; $65dc
	push de ; $65dd
	push hl ; $65de
	push hl ; $65df
	ld de, $dcf0 ; $65e0
	ld c, $01 ; $65e3
	call CopyMemoryFast ; $65e5
	ld hl, $dcf2 ; $65e8
	ld a, [hl] ; $65eb
	and a, a ; $65ec
	jr z, Label_0a_65f0 ; $65ed
	dec [hl] ; $65ef
Label_0a_65f0:
	call Func_0a_68b7 ; $65f0
	call Func_0a_661e ; $65f3
	ld a, [$c7a4] ; $65f6
	and a, a ; $65f9
	jr nz, Label_0a_6607 ; $65fa
	call Func_0a_66ae ; $65fc
	call Func_0a_672d ; $65ff
	call Func_0a_6717 ; $6602
	jr Label_0a_6610 ; $6605
Label_0a_6607:
	call Func_0a_6d6e ; $6607
	call Func_0a_6df4 ; $660a
	call Func_0a_6dde ; $660d
Label_0a_6610:
	pop de ; $6610
	ld hl, $dcf0 ; $6611
	ld c, $01 ; $6614
	call CopyMemoryFast ; $6616
	pop hl ; $6619
	pop de ; $661a
	pop bc ; $661b
	pop af ; $661c
	ret ; $661d
Func_0a_661e:
	ld hl, $dcf0 ; $661e
	bit 1, [hl] ; $6621
	ret z ; $6623
	ld hl, $dcf6 ; $6624
	ld a, [hl+] ; $6627
	ld d, [hl] ; $6628
	ld e, a ; $6629
	ld hl, $dcfa ; $662a
	ld a, [hl+] ; $662d
	ld h, [hl] ; $662e
	ld l, a ; $662f
	ld a, l ; $6630
	sub a, e ; $6631
	ld l, a ; $6632
	ld a, h ; $6633
	sbc a, d ; $6634
	ld h, a ; $6635
	ld a, h ; $6636
	or a, l ; $6637
	jr z, Label_0a_6650 ; $6638
	ld de, $0010 ; $663a
	bit 7, h ; $663d
	jr z, Label_0a_6647 ; $663f
	xor a, a ; $6641
	sub a, e ; $6642
	ld e, a ; $6643
	sbc a, a ; $6644
	sub a, d ; $6645
	ld d, a ; $6646
Label_0a_6647:
	ld hl, $dcf6 ; $6647
	ld a, [hl] ; $664a
	add a, e ; $664b
	ld [hl+], a ; $664c
	ld a, [hl] ; $664d
	adc a, d ; $664e
	ld [hl+], a ; $664f
Label_0a_6650:
	ld hl, $dcf8 ; $6650
	ld a, [hl+] ; $6653
	ld d, [hl] ; $6654
	ld e, a ; $6655
	ld hl, $dcfc ; $6656
	ld a, [hl+] ; $6659
	ld h, [hl] ; $665a
	ld l, a ; $665b
	ld a, l ; $665c
	sub a, e ; $665d
	ld l, a ; $665e
	ld a, h ; $665f
	sbc a, d ; $6660
	ld h, a ; $6661
	ld a, h ; $6662
	or a, l ; $6663
	jr z, Label_0a_667c ; $6664
	ld de, $0010 ; $6666
	bit 7, h ; $6669
	jr z, Label_0a_6673 ; $666b
	xor a, a ; $666d
	sub a, e ; $666e
	ld e, a ; $666f
	sbc a, a ; $6670
	sub a, d ; $6671
	ld d, a ; $6672
Label_0a_6673:
	ld hl, $dcf8 ; $6673
	ld a, [hl] ; $6676
	add a, e ; $6677
	ld [hl+], a ; $6678
	ld a, [hl] ; $6679
	adc a, d ; $667a
	ld [hl+], a ; $667b
Label_0a_667c:
	ld hl, $dcf6 ; $667c
	ld a, [hl+] ; $667f
	ld d, [hl] ; $6680
	ld e, a ; $6681
	ld hl, $dcfa ; $6682
	ld a, [hl+] ; $6685
	ld h, [hl] ; $6686
	ld l, a ; $6687
	ld a, l ; $6688
	sub a, e ; $6689
	ld l, a ; $668a
	ld a, h ; $668b
	sbc a, d ; $668c
	ld h, a ; $668d
	ld a, h ; $668e
	or a, l ; $668f
	jr nz, Label_0a_66ad ; $6690
	ld hl, $dcf8 ; $6692
	ld a, [hl+] ; $6695
	ld d, [hl] ; $6696
	ld e, a ; $6697
	ld hl, $dcfc ; $6698
	ld a, [hl+] ; $669b
	ld h, [hl] ; $669c
	ld l, a ; $669d
	ld a, l ; $669e
	sub a, e ; $669f
	ld l, a ; $66a0
	ld a, h ; $66a1
	sbc a, d ; $66a2
	ld h, a ; $66a3
	ld a, h ; $66a4
	or a, l ; $66a5
	jr nz, Label_0a_66ad ; $66a6
	ld hl, $dcf0 ; $66a8
	res 1, [hl] ; $66ab
Label_0a_66ad:
	ret ; $66ad
Func_0a_66ae:
	ld hl, $dcf8 ; $66ae
	ld a, [hl+] ; $66b1
	ld b, [hl] ; $66b2
	ld c, a ; $66b3
	ld hl, $dcf6 ; $66b4
	ld a, [hl+] ; $66b7
	ld h, [hl] ; $66b8
	ld l, a ; $66b9
	rst Rst18 ; $66ba
	ld b, [hl] ; $66bb
	ld [$424b], sp ; $66bc
	ld a, [$dcf2] ; $66bf
	and a, $0f ; $66c2
	jr z, Label_0a_66e1 ; $66c4
	add a, $fe ; $66c6
	ld l, a ; $66c8
	adc a, $66 ; $66c9
	sub a, l ; $66cb
	ld h, a ; $66cc
	ld a, [hl] ; $66cd
	ld h, $00 ; $66ce
	ld l, a ; $66d0
	ld a, [$dcf1] ; $66d1
	rrca ; $66d4
	rrca ; $66d5
	and a, $c0 ; $66d6
	call Func_00_0af8 ; $66d8
	ld a, c ; $66db
	add a, e ; $66dc
	ld e, a ; $66dd
	ld a, b ; $66de
	add a, l ; $66df
	ld d, a ; $66e0
Label_0a_66e1:
	ld a, [$dcf1] ; $66e1
	add a, a ; $66e4
	add a, $f6 ; $66e5
	ld l, a ; $66e7
	adc a, $66 ; $66e8
	sub a, l ; $66ea
	ld h, a ; $66eb
	ld a, [hl+] ; $66ec
	ld b, [hl] ; $66ed
	ld c, a ; $66ee
	ld hl, $670e ; $66ef
	call Func_00_1e9d ; $66f2
	ret ; $66f5
	INCBIN "data/bank_00a/d_66f6.bin" ; $66f6, 33 bytes
Func_0a_6717:
	ld hl, $dcf0 ; $6717
	bit 2, [hl] ; $671a
	ret z ; $671c
	res 2, [hl] ; $671d
	rst Rst08 ; $671f
	ld [hl], a ; $6720
	ld a, $20 ; $6721
	ld [$dcf2], a ; $6723
	ld a, [$dcf1] ; $6726
	call Func_0a_6774 ; $6729
	ret ; $672c
Func_0a_672d:
	ld a, [$c4b4] ; $672d
	and a, a ; $6730
	ret z ; $6731
	ld hl, $dd1e ; $6732
	ld a, [hl+] ; $6735
	ld d, [hl] ; $6736
	ld e, a ; $6737
	ld hl, $dcf6 ; $6738
	ld a, [hl+] ; $673b
	ld h, [hl] ; $673c
	ld l, a ; $673d
	ld a, l ; $673e
	sub a, e ; $673f
	ld l, a ; $6740
	ld a, h ; $6741
	sbc a, d ; $6742
	ld h, a ; $6743
	bit 7, h ; $6744
	jr z, Label_0a_6773 ; $6746
	ld de, $0200 ; $6748
	add hl, de ; $674b
	bit 7, h ; $674c
	jr nz, Label_0a_6773 ; $674e
	ld hl, $dd20 ; $6750
	ld a, [hl+] ; $6753
	ld d, [hl] ; $6754
	ld e, a ; $6755
	ld hl, $dcf8 ; $6756
	ld a, [hl+] ; $6759
	ld h, [hl] ; $675a
	ld l, a ; $675b
	ld a, l ; $675c
	sub a, e ; $675d
	ld l, a ; $675e
	ld a, h ; $675f
	sbc a, d ; $6760
	ld h, a ; $6761
	bit 7, h ; $6762
	jr z, Label_0a_6773 ; $6764
	ld de, $0200 ; $6766
	add hl, de ; $6769
	bit 7, h ; $676a
	jr nz, Label_0a_6773 ; $676c
	ld hl, $dcf0 ; $676e
	set 2, [hl] ; $6771
Label_0a_6773:
	ret ; $6773
Func_0a_6774:
	and a, $03 ; $6774
	ld a, a ; $6776
	rst Rst00 ; $6777
	add a, b ; $6778
	ld h, a ; $6779
	adc a, l ; $677a
	ld h, a ; $677b
	and a, l ; $677c
	ld h, a ; $677d
	or a, d ; $677e
	ld h, a ; $677f
	ld de, $0600 ; $6780
	ld hl, $c421 ; $6783
	ld a, [hl] ; $6786
	add a, e ; $6787
	ld [hl+], a ; $6788
	ld a, [hl] ; $6789
	adc a, d ; $678a
	ld [hl+], a ; $678b
	ret ; $678c
	INCBIN "data/bank_00a/d_678d.bin" ; $678d, 61 bytes
	push af ; $67ca
	push bc ; $67cb
	push hl ; $67cc
	add sp, -10 ; $67cd
	push bc ; $67cf
	push de ; $67d0
	ld c, l ; $67d1
	ld b, h ; $67d2
	ld hl, sp + 4 ; $67d3
	ld e, l ; $67d5
	ld d, h ; $67d6
	ld l, c ; $67d7
	ld h, b ; $67d8
	ld c, e ; $67d9
	ld b, d ; $67da
	call Func_00_1972 ; $67db
	ld l, c ; $67de
	ld h, b ; $67df
	pop de ; $67e0
	pop bc ; $67e1
	call Func_0a_67eb ; $67e2
	add sp, 10 ; $67e5
	pop hl ; $67e7
	pop bc ; $67e8
	pop af ; $67e9
	ret ; $67ea
Func_0a_67eb:
	ld a, [hl+] ; $67eb
	and a, a ; $67ec
	jr z, Label_0a_67f4 ; $67ed
	call Func_0a_67f5 ; $67ef
	jr Func_0a_67eb ; $67f2
Label_0a_67f4:
	ret ; $67f4
Func_0a_67f5:
	sub a, $30 ; $67f5
	jr c, Label_0a_6804 ; $67f7
	push de ; $67f9
	push hl ; $67fa
	add a, a ; $67fb
	add a, $08 ; $67fc
	ld c, a ; $67fe
	call Func_00_1f51 ; $67ff
	pop hl ; $6802
	pop de ; $6803
Label_0a_6804:
	ld a, d ; $6804
	add a, $08 ; $6805
	ld d, a ; $6807
	ret ; $6808
	INCBIN "data/bank_00a/d_6809.bin" ; $6809, 174 bytes
Func_0a_68b7:
	ld hl, $dcf3 ; $68b7
	ld a, [hl] ; $68ba
	and a, a ; $68bb
	jr z, Label_0a_68c0 ; $68bc
	dec [hl] ; $68be
	ret ; $68bf
Label_0a_68c0:
	ld hl, $dcf4 ; $68c0
	ld a, [hl+] ; $68c3
	ld d, [hl] ; $68c4
	ld e, a ; $68c5
	ld hl, $68d7 ; $68c6
	push hl ; $68c9
	ld a, [de] ; $68ca
	add a, a ; $68cb
	add a, $09 ; $68cc
	ld l, a ; $68ce
	adc a, $68 ; $68cf
	sub a, l ; $68d1
	ld h, a ; $68d2
	ld a, [hl+] ; $68d3
	ld h, [hl] ; $68d4
	ld l, a ; $68d5
	jp hl ; $68d6
	INCBIN "data/bank_00a/d_68d7.bin" ; $68d7, 1175 bytes
Func_0a_6d6e:
	ld hl, $dcf8 ; $6d6e
	ld a, [hl+] ; $6d71
	ld b, [hl] ; $6d72
	ld c, a ; $6d73
	ld hl, $dcf6 ; $6d74
	ld a, [hl+] ; $6d77
	ld h, [hl] ; $6d78
	ld l, a ; $6d79
	rst Rst18 ; $6d7a
	ld b, [hl] ; $6d7b
	ld [$424b], sp ; $6d7c
	ld a, [$dcf2] ; $6d7f
	and a, $0f ; $6d82
	jr z, Label_0a_6d90 ; $6d84
	add a, $ad ; $6d86
	ld l, a ; $6d88
	adc a, $6d ; $6d89
	sub a, l ; $6d8b
	ld h, a ; $6d8c
	ld a, [hl] ; $6d8d
	add a, d ; $6d8e
	ld d, a ; $6d8f
Label_0a_6d90:
	ld a, [$dcf1] ; $6d90
	add a, a ; $6d93
	add a, $a5 ; $6d94
	ld l, a ; $6d96
	adc a, $6d ; $6d97
	sub a, l ; $6d99
	ld h, a ; $6d9a
	ld a, [hl+] ; $6d9b
	ld b, [hl] ; $6d9c
	ld c, a ; $6d9d
	ld hl, $6dbd ; $6d9e
	call Func_00_1e9d ; $6da1
	ret ; $6da4
	INCBIN "data/bank_00a/d_6da5.bin" ; $6da5, 57 bytes
Func_0a_6dde:
	ld hl, $dcf0 ; $6dde
	bit 2, [hl] ; $6de1
	ret z ; $6de3
	res 2, [hl] ; $6de4
	rst Rst08 ; $6de6
	sub a, a ; $6de7
	ld a, $20 ; $6de8
	ld [$dcf2], a ; $6dea
	ld a, [$dcf1] ; $6ded
	ld [$c78d], a ; $6df0
	ret ; $6df3
Func_0a_6df4:
	ld a, [$c4b4] ; $6df4
	and a, a ; $6df7
	ret z ; $6df8
	ld a, $01 ; $6df9
	ld [$c78e], a ; $6dfb
	ld hl, $dd1e ; $6dfe
	ld a, [hl+] ; $6e01
	ld d, [hl] ; $6e02
	ld e, a ; $6e03
	ld hl, $dcf6 ; $6e04
	ld a, [hl+] ; $6e07
	ld h, [hl] ; $6e08
	ld l, a ; $6e09
	ld a, l ; $6e0a
	sub a, e ; $6e0b
	ld l, a ; $6e0c
	ld a, h ; $6e0d
	sbc a, d ; $6e0e
	ld h, a ; $6e0f
	bit 7, h ; $6e10
	jr z, Label_0a_6e3f ; $6e12
	ld de, $0400 ; $6e14
	add hl, de ; $6e17
	bit 7, h ; $6e18
	jr nz, Label_0a_6e3f ; $6e1a
	ld hl, $dd20 ; $6e1c
	ld a, [hl+] ; $6e1f
	ld d, [hl] ; $6e20
	ld e, a ; $6e21
	ld hl, $dcf8 ; $6e22
	ld a, [hl+] ; $6e25
	ld h, [hl] ; $6e26
	ld l, a ; $6e27
	ld a, l ; $6e28
	sub a, e ; $6e29
	ld l, a ; $6e2a
	ld a, h ; $6e2b
	sbc a, d ; $6e2c
	ld h, a ; $6e2d
	bit 7, h ; $6e2e
	jr z, Label_0a_6e3f ; $6e30
	ld de, $0400 ; $6e32
	add hl, de ; $6e35
	bit 7, h ; $6e36
	jr nz, Label_0a_6e3f ; $6e38
	ld hl, $dcf0 ; $6e3a
	set 2, [hl] ; $6e3d
Label_0a_6e3f:
	ret ; $6e3f
	INCBIN "data/bank_00a/d_6e40.bin" ; $6e40, 4544 bytes
