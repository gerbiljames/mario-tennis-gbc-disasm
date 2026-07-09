INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $17", ROMX[$4000], BANK[$17]

	INCBIN "data/bank_017/d_4000.bin" ; $4000, 163 bytes
Func_17_40a3:
	ldh a, [$ff8c] ; $40a3
	and a, $0f ; $40a5
	ld hl, $40bd ; $40a7
	add a, l ; $40aa
	ld l, a ; $40ab
	jr nc, Label_17_40af ; $40ac
	inc h ; $40ae
Label_17_40af:
	ld a, [hl] ; $40af
	ld b, a ; $40b0
	ld a, c ; $40b1
	or a, a ; $40b2
	jr z, Label_17_40b9 ; $40b3
	ld a, b ; $40b5
	add a, e ; $40b6
	ld e, a ; $40b7
	ret ; $40b8
Label_17_40b9:
	ld a, e ; $40b9
	sub a, b ; $40ba
	ld e, a ; $40bb
	ret ; $40bc
	INCBIN "data/bank_017/d_40bd.bin" ; $40bd, 841 bytes
	rst Rst18 ; $4406
	inc b ; $4407
	add hl, sp ; $4408
	ret ; $4409
	INCBIN "data/bank_017/d_440a.bin" ; $440a, 11025 bytes
	push af ; $6f1b
	ld a, $03 ; $6f1c
	ldh [$ff96], a ; $6f1e
	ldh [rWBK], a ; $6f20
	pop af ; $6f22
	ld [$dc01], a ; $6f23
	ld a, [wMinigameLevel] ; $6f26
	ld [$dc06], a ; $6f29
	xor a, a ; $6f2c
	ld [$dc02], a ; $6f2d
	ld [$dc03], a ; $6f30
	ld [$dc04], a ; $6f33
	ld [$dc05], a ; $6f36
	ld [$dc00], a ; $6f39
	ld c, $20 ; $6f3c
	call Func_00_1d20 ; $6f3e
	call Func_00_1da4 ; $6f41
	call DisableLCDSafely ; $6f44
	call Func_17_7157 ; $6f47
	ld a, $01 ; $6f4a
	ld [$cb0b], a ; $6f4c
	ld a, $03 ; $6f4f
	ld [$cb0c], a ; $6f51
	ld a, $01 ; $6f54
	ld hl, $4406 ; $6f56
	call Func_00_1b6a ; $6f59
	call EnableLCD ; $6f5c
	ld c, $20 ; $6f5f
	call Func_00_1d2e ; $6f61
	call Func_00_1da4 ; $6f64
	ld a, $03 ; $6f67
	ldh [$ff96], a ; $6f69
	ldh [rWBK], a ; $6f6b
	ld a, $01 ; $6f6d
	ld hl, $7420 ; $6f6f
	call Func_00_1b6a ; $6f72
	ld a, $01 ; $6f75
	ld [$dc03], a ; $6f77
	xor a, a ; $6f7a
	ld [$dc04], a ; $6f7b
	call Func_17_6f91 ; $6f7e
	ld c, $20 ; $6f81
	call Func_00_1d20 ; $6f83
	call Func_00_1da4 ; $6f86
	call Func_00_1b38 ; $6f89
	ld a, [$dc02] ; $6f8c
	ret ; $6f8f
	INCBIN "data/bank_017/d_6f90.bin" ; $6f90, 1 bytes
Func_17_6f91:
	ldh a, [$ff96] ; $6f91
	push af ; $6f93
	ld a, $03 ; $6f94
	ldh [$ff96], a ; $6f96
	ldh [rWBK], a ; $6f98
	ld a, [$cb20] ; $6f9a
	inc a ; $6f9d
	inc a ; $6f9e
	rst Rst18 ; $6f9f
	inc l ; $6fa0
	inc bc ; $6fa1
	ld a, $07 ; $6fa2
	ldh [$ff96], a ; $6fa4
	ldh [rWBK], a ; $6fa6
	ld hl, $de00 ; $6fa8
	ld a, [hl+] ; $6fab
	ld h, [hl] ; $6fac
	ld l, a ; $6fad
	ld a, $03 ; $6fae
	ldh [$ff96], a ; $6fb0
	ldh [rWBK], a ; $6fb2
	rst Rst18 ; $6fb4
	ld c, b ; $6fb5
	dec b ; $6fb6
	ld a, [$cb20] ; $6fb7
	ld hl, $6fdb ; $6fba
	add a, a ; $6fbd
	add a, l ; $6fbe
	ld l, a ; $6fbf
	jr nc, Label_17_6fc3 ; $6fc0
	inc h ; $6fc2
Label_17_6fc3:
	ld a, [hl+] ; $6fc3
	ld d, [hl] ; $6fc4
	ld e, a ; $6fc5
	ld hl, $cb6e ; $6fc6
	ld a, e ; $6fc9
	ld [hl+], a ; $6fca
	ld [hl], d ; $6fcb
	ld hl, $6fed ; $6fcc
	ld a, [$dc01] ; $6fcf
	call Func_17_709b ; $6fd2
	pop af ; $6fd5
	ldh [$ff96], a ; $6fd6
	ldh [rWBK], a ; $6fd8
	ret ; $6fda
	INCBIN "data/bank_017/d_6fdb.bin" ; $6fdb, 192 bytes
Func_17_709b:
	add a, a ; $709b
	ld b, a ; $709c
	add a, a ; $709d
	add a, b ; $709e
	add a, l ; $709f
	ld l, a ; $70a0
	jr nc, Label_17_70a4 ; $70a1
	inc h ; $70a3
Label_17_70a4:
	ld a, [hl+] ; $70a4
	cp a, $ff ; $70a5
	jp z, Label_17_7150 ; $70a7
	push hl ; $70aa
	bit 7, a ; $70ab
	jr z, Label_17_70d3 ; $70ad
	push af ; $70af
	ld d, a ; $70b0
	ld a, $07 ; $70b1
	ldh [$ff96], a ; $70b3
	ldh [rWBK], a ; $70b5
	ld hl, $de00 ; $70b7
	ld a, [hl+] ; $70ba
	ld h, [hl] ; $70bb
	ld l, a ; $70bc
	ld a, $03 ; $70bd
	ldh [$ff96], a ; $70bf
	ldh [rWBK], a ; $70c1
	ld a, h ; $70c3
	cp a, $27 ; $70c4
	jr nz, Label_17_70d2 ; $70c6
	ld a, l ; $70c8
	cp a, $0f ; $70c9
	jr nz, Label_17_70d2 ; $70cb
	pop bc ; $70cd
	ld a, d ; $70ce
	inc a ; $70cf
	jr Label_17_70d3 ; $70d0
Label_17_70d2:
	pop af ; $70d2
Label_17_70d3:
	and a, $7f ; $70d3
	pop hl ; $70d5
	push hl ; $70d6
	push af ; $70d7
	ld a, [hl] ; $70d8
	cp a, $ff ; $70d9
	jr z, Label_17_70e5 ; $70db
	ld a, $01 ; $70dd
	ld hl, $755e ; $70df
	call Func_00_1b6a ; $70e2
Label_17_70e5:
	call Func_17_7202 ; $70e5
	ld hl, $cb6e ; $70e8
	ld a, [hl+] ; $70eb
	ld h, [hl] ; $70ec
	ld l, a ; $70ed
	pop af ; $70ee
	add a, l ; $70ef
	ld l, a ; $70f0
	jr nc, Label_17_70f4 ; $70f1
	inc h ; $70f3
Label_17_70f4:
	ld de, $d082 ; $70f4
	ld c, $20 ; $70f7
	rst Rst18 ; $70f9
	adc a, h ; $70fa
	dec b ; $70fb
	ld c, $10 ; $70fc
	rst Rst18 ; $70fe
	inc e ; $70ff
	dec b ; $7100
	rst Rst18 ; $7101
	sub a, b ; $7102
	dec b ; $7103
	call Func_17_724d ; $7104
Label_17_7107:
	call Func_00_2631 ; $7107
	ldh a, [$ff94] ; $710a
	bit 0, a ; $710c
	jr nz, Label_17_711e ; $710e
	bit 7, a ; $7110
	jr nz, Label_17_711e ; $7112
	bit 1, a ; $7114
	jr nz, Label_17_713c ; $7116
	bit 3, a ; $7118
	jr nz, Label_17_7153 ; $711a
	jr Label_17_7107 ; $711c
Label_17_711e:
	rst Rst08 ; $711e
	ld e, a ; $711f
	ld hl, $755e ; $7120
	call Func_00_1bcb ; $7123
	ld hl, $7570 ; $7126
	call Func_00_1bcb ; $7129
	ld a, $01 ; $712c
	ld [$dc03], a ; $712e
	ld [$dc05], a ; $7131
	xor a, a ; $7134
	ld [$dc04], a ; $7135
	pop hl ; $7138
	jp Label_17_70a4 ; $7139
Label_17_713c:
	rst Rst08 ; $713c
	ld h, d ; $713d
	ld hl, $755e ; $713e
	call Func_00_1bcb ; $7141
	ld hl, $7570 ; $7144
	call Func_00_1bcb ; $7147
	ld a, $ff ; $714a
	ld [$dc02], a ; $714c
	pop hl ; $714f
Label_17_7150:
	rst Rst08 ; $7150
	ld h, b ; $7151
	ret ; $7152
Label_17_7153:
	pop hl ; $7153
	rst Rst08 ; $7154
	ld h, b ; $7155
	ret ; $7156
Func_17_7157:
	call Func_17_7293 ; $7157
	rst Rst18 ; $715a
	ld a, [bc] ; $715b
	INCBIN "data/bank_017/d_715c.bin" ; $715c, 1 bytes
	ld c, $44 ; $715d
	rst Rst18 ; $715f
	nop ; $7160
	add hl, sp ; $7161
	ldh a, [$ff96] ; $7162
	push af ; $7164
	rst Rst18 ; $7165
	nop ; $7166
	dec b ; $7167
	ld a, $05 ; $7168
	ldh [$ff96], a ; $716a
	ldh [rWBK], a ; $716c
	ld a, $03 ; $716e
	ld [$c3b3], a ; $7170
	ld a, $00 ; $7173
	ld [$c3b6], a ; $7175
	pop af ; $7178
	ldh [$ff96], a ; $7179
	ldh [rWBK], a ; $717b
	rst Rst18 ; $717d
	adc a, h ; $717e
	dec b ; $717f
	call Func_17_71bd ; $7180
	ld hl, $7b39 ; $7183
	ld de, $0902 ; $7186
	call Func_00_05b5 ; $7189
	ld de, $a000 ; $718c
	rst Rst18 ; $718f
	jr Label_17_71cb ; $7190
	ld b, $08 ; $7192
	ld c, $0f ; $7194
	rst Rst18 ; $7196
	ld c, $39 ; $7197
	ld b, $11 ; $7199
	ld c, $10 ; $719b
	ld de, $9000 ; $719d
	rst Rst18 ; $71a0
	INCBIN "data/bank_017/d_71a1.bin" ; $71a1, 2 bytes
	ld a, $03 ; $71a3
	ld [$c3b3], a ; $71a5
	ld hl, $c3b4 ; $71a8
	ld de, $d000 ; $71ab
	ld a, e ; $71ae
	ld [hl+], a ; $71af
	ld [hl], d ; $71b0
	ld a, $01 ; $71b1
	ld hl, $74db ; $71b3
	call Func_00_1b6a ; $71b6
	rst Rst18 ; $71b9
	ld [bc], a ; $71ba
	add hl, sp ; $71bb
	ret ; $71bc
Func_17_71bd:
	ldh a, [$ff96] ; $71bd
	push af ; $71bf
	ld a, $03 ; $71c0
	ldh [$ff96], a ; $71c2
	ldh [rWBK], a ; $71c4
	ld de, $d462 ; $71c6
	ld b, $10 ; $71c9
Label_17_71cb:
	ld c, $0e ; $71cb
	ld h, $00 ; $71cd
	rst Rst18 ; $71cf
	inc c ; $71d0
	add hl, sp ; $71d1
	call Func_17_71db ; $71d2
	pop af ; $71d5
	ldh [$ff96], a ; $71d6
	ldh [rWBK], a ; $71d8
	ret ; $71da
Func_17_71db:
	ldh a, [$ff96] ; $71db
	push af ; $71dd
	ld a, $03 ; $71de
	ldh [$ff96], a ; $71e0
	ldh [rWBK], a ; $71e2
	ld de, $d062 ; $71e4
	ld b, $10 ; $71e7
	ld c, $01 ; $71e9
	ld h, $03 ; $71eb
	rst Rst18 ; $71ed
	inc c ; $71ee
	add hl, sp ; $71ef
	ld de, $d082 ; $71f0
	ld b, $10 ; $71f3
	ld c, $0d ; $71f5
	ld h, $20 ; $71f7
	rst Rst18 ; $71f9
	inc c ; $71fa
	add hl, sp ; $71fb
	pop af ; $71fc
	ldh [$ff96], a ; $71fd
	ldh [rWBK], a ; $71ff
	ret ; $7201
Func_17_7202:
	ldh a, [$ff96] ; $7202
	push af ; $7204
	ld a, $03 ; $7205
	ldh [$ff96], a ; $7207
	ldh [rWBK], a ; $7209
	ld de, $d062 ; $720b
	ld b, $10 ; $720e
	ld c, $01 ; $7210
	ld h, $03 ; $7212
	rst Rst18 ; $7214
	inc c ; $7215
	add hl, sp ; $7216
	ld de, $d082 ; $7217
	ld b, $10 ; $721a
	ld c, $0d ; $721c
	ld h, $20 ; $721e
	rst Rst18 ; $7220
	inc c ; $7221
	add hl, sp ; $7222
	ld a, [$dc05] ; $7223
	or a, a ; $7226
	jr nz, Label_17_723b ; $7227
	ld a, [$dc06] ; $7229
	add a, $03 ; $722c
	ld h, a ; $722e
	ld de, $d482 ; $722f
	ld b, $10 ; $7232
	ld c, $01 ; $7234
	rst Rst18 ; $7236
	inc c ; $7237
	add hl, sp ; $7238
	jr Label_17_7247 ; $7239
Label_17_723b:
	ld de, $d482 ; $723b
	ld b, $10 ; $723e
	ld c, $01 ; $7240
	ld h, $00 ; $7242
	rst Rst18 ; $7244
	inc c ; $7245
	add hl, sp ; $7246
Label_17_7247:
	pop af ; $7247
	ldh [$ff96], a ; $7248
	ldh [rWBK], a ; $724a
	ret ; $724c
Func_17_724d:
	ld a, [$dc05] ; $724d
	or a, a ; $7250
	jr nz, Label_17_7260 ; $7251
	ld hl, $d080 ; $7253
	ld de, $9880 ; $7256
	ld c, $0a ; $7259
	call Func_00_0480 ; $725b
	jr Label_17_726b ; $725e
Label_17_7260:
	ld hl, $d060 ; $7260
	ld de, $9860 ; $7263
	ld c, $0a ; $7266
	call Func_00_0480 ; $7268
Label_17_726b:
	ld hl, $d480 ; $726b
	ld de, $b880 ; $726e
	ld c, $02 ; $7271
	call Func_00_0480 ; $7273
	call Func_00_2631 ; $7276
	ld hl, $d100 ; $7279
	ld de, $9900 ; $727c
	ld c, $0a ; $727f
	call Func_00_0480 ; $7281
	call Func_00_2631 ; $7284
	ld hl, $d1a0 ; $7287
	ld de, $99a0 ; $728a
	ld c, $08 ; $728d
	call Func_00_0480 ; $728f
	ret ; $7292
Func_17_7293:
	ld a, $01 ; $7293
	ldh [$ff96], a ; $7295
	ldh [rWBK], a ; $7297
	ld hl, $793c ; $7299
	ld de, $d000 ; $729c
	call DecompressData ; $729f
	ld hl, $d000 ; $72a2
	ld de, $8000 ; $72a5
	ld bc, $0012 ; $72a8
	call Func_00_0480 ; $72ab
	ld hl, $d000 ; $72ae
	ld de, $8240 ; $72b1
	ld bc, $0012 ; $72b4
	call Func_00_0480 ; $72b7
	ld hl, $d000 ; $72ba
	ld de, $8480 ; $72bd
	ld bc, $0012 ; $72c0
	call Func_00_0480 ; $72c3
	ld hl, $d000 ; $72c6
	ld de, $a100 ; $72c9
	ld bc, $0012 ; $72cc
	call Func_00_0480 ; $72cf
	ld hl, $d000 ; $72d2
	ld de, $a340 ; $72d5
	ld bc, $0012 ; $72d8
	call Func_00_0480 ; $72db
	ld hl, $d000 ; $72de
	ld de, $a580 ; $72e1
	ld bc, $0012 ; $72e4
	call Func_00_0480 ; $72e7
	ld hl, $7a08 ; $72ea
	ld de, $d000 ; $72ed
	call DecompressData ; $72f0
	ld hl, $d000 ; $72f3
	ld de, $84a0 ; $72f6
	ld bc, $0002 ; $72f9
	call Func_00_0480 ; $72fc
	ld hl, $d000 ; $72ff
	ld de, $a120 ; $7302
	ld bc, $0002 ; $7305
	call Func_00_0480 ; $7308
	ld hl, $d000 ; $730b
	ld de, $a360 ; $730e
	ld bc, $0002 ; $7311
	call Func_00_0480 ; $7314
	ld hl, $d000 ; $7317
	ld de, $a5a0 ; $731a
	ld bc, $0002 ; $731d
	call Func_00_0480 ; $7320
	ld hl, $7a2f ; $7323
	ld de, $d000 ; $7326
	call DecompressData ; $7329
	ld hl, $d020 ; $732c
	ld de, $82c0 ; $732f
	ld bc, $0001 ; $7332
	call Func_00_0480 ; $7335
	ld hl, $d020 ; $7338
	ld de, $a180 ; $733b
	ld bc, $0001 ; $733e
	call Func_00_0480 ; $7341
	ld hl, $d000 ; $7344
	ld de, $a3c0 ; $7347
	ld bc, $0001 ; $734a
	call Func_00_0480 ; $734d
	ld hl, $d040 ; $7350
	ld de, $a600 ; $7353
	ld bc, $0001 ; $7356
	call Func_00_0480 ; $7359
	ld hl, $7a56 ; $735c
	ld de, $d000 ; $735f
	call DecompressData ; $7362
	ld hl, $d000 ; $7365
	ld de, $8120 ; $7368
	ld bc, $0012 ; $736b
	call Func_00_0480 ; $736e
	ld hl, $d000 ; $7371
	ld de, $8360 ; $7374
	ld bc, $0012 ; $7377
	call Func_00_0480 ; $737a
	ld hl, $d000 ; $737d
	ld de, $85a0 ; $7380
	ld bc, $0012 ; $7383
	call Func_00_0480 ; $7386
	ld hl, $d000 ; $7389
	ld de, $a220 ; $738c
	ld bc, $0012 ; $738f
	call Func_00_0480 ; $7392
	ld hl, $d000 ; $7395
	ld de, $a460 ; $7398
	ld bc, $0012 ; $739b
	call Func_00_0480 ; $739e
	ld hl, $d000 ; $73a1
	ld de, $a6a0 ; $73a4
	ld bc, $0012 ; $73a7
	call Func_00_0480 ; $73aa
	ld hl, $7af8 ; $73ad
	ld de, $d000 ; $73b0
	call DecompressData ; $73b3
	ld hl, $d000 ; $73b6
	ld de, $85c0 ; $73b9
	ld bc, $0002 ; $73bc
	call Func_00_0480 ; $73bf
	ld hl, $d000 ; $73c2
	ld de, $a240 ; $73c5
	ld bc, $0002 ; $73c8
	call Func_00_0480 ; $73cb
	ld hl, $d000 ; $73ce
	ld de, $a480 ; $73d1
	ld bc, $0002 ; $73d4
	call Func_00_0480 ; $73d7
	ld hl, $d000 ; $73da
	ld de, $a6c0 ; $73dd
	ld bc, $0002 ; $73e0
	call Func_00_0480 ; $73e3
	ld hl, $7b18 ; $73e6
	ld de, $d000 ; $73e9
	call DecompressData ; $73ec
	ld hl, $d020 ; $73ef
	ld de, $83e0 ; $73f2
	ld bc, $0001 ; $73f5
	call Func_00_0480 ; $73f8
	ld hl, $d020 ; $73fb
	ld de, $a2a0 ; $73fe
	ld bc, $0001 ; $7401
	call Func_00_0480 ; $7404
	ld hl, $d000 ; $7407
	ld de, $a4e0 ; $740a
	ld bc, $0001 ; $740d
	call Func_00_0480 ; $7410
	ld hl, $d040 ; $7413
	ld de, $a720 ; $7416
	ld bc, $0001 ; $7419
	call Func_00_0480 ; $741c
	ret ; $741f
	ldh a, [$ff96] ; $7420
	push af ; $7422
	ld a, $03 ; $7423
	ldh [$ff96], a ; $7425
	ldh [rWBK], a ; $7427
	ld a, [$dc04] ; $7429
	inc a ; $742c
	ld [$dc04], a ; $742d
	ld a, [$dc03] ; $7430
	or a, a ; $7433
	jr z, Label_17_744e ; $7434
	ldh a, [$ff8c] ; $7436
	srl a ; $7438
	srl a ; $743a
	srl a ; $743c
	and a, $3f ; $743e
	ld hl, $749f ; $7440
	add a, l ; $7443
	ld l, a ; $7444
	jr nc, Label_17_7448 ; $7445
	inc h ; $7447
Label_17_7448:
	ld a, [hl] ; $7448
	ld [$dc00], a ; $7449
	jr Label_17_7468 ; $744c
Label_17_744e:
	ldh a, [$ff8c] ; $744e
	srl a ; $7450
	srl a ; $7452
	srl a ; $7454
	srl a ; $7456
	and a, $1f ; $7458
	ld hl, $747f ; $745a
	add a, l ; $745d
	ld l, a ; $745e
	jr nc, Label_17_7462 ; $745f
	inc h ; $7461
Label_17_7462:
	ld a, [hl] ; $7462
	ld [$dc00], a ; $7463
	jr Label_17_7468 ; $7466
Label_17_7468:
	ld a, [$dc03] ; $7468
	or a, a ; $746b
	jr z, Label_17_7479 ; $746c
	ld a, [$dc04] ; $746e
	cp a, $ff ; $7471
	jr nz, Label_17_7479 ; $7473
	xor a, a ; $7475
	ld [$dc03], a ; $7476
Label_17_7479:
	pop af ; $7479
	ldh [$ff96], a ; $747a
	ldh [rWBK], a ; $747c
	ret ; $747e
	INCBIN "data/bank_017/d_747f.bin" ; $747f, 92 bytes
	ldh a, [$ff96] ; $74db
	push af ; $74dd
	ld a, $03 ; $74de
	ldh [$ff96], a ; $74e0
	ldh [rWBK], a ; $74e2
	ld a, [$dc00] ; $74e4
	ld hl, $754c ; $74e7
	add a, l ; $74ea
	ld l, a ; $74eb
	jr nc, Label_17_74ef ; $74ec
	inc h ; $74ee
Label_17_74ef:
	ld a, [hl] ; $74ef
	ld c, a ; $74f0
	push bc ; $74f1
	ld a, [$dc00] ; $74f2
	ld hl, $7552 ; $74f5
	add a, l ; $74f8
	ld l, a ; $74f9
	jr nc, Label_17_74fd ; $74fa
	inc h ; $74fc
Label_17_74fd:
	ld b, [hl] ; $74fd
	ld de, $7e68 ; $74fe
	ld hl, $7527 ; $7501
	call Func_00_1e9d ; $7504
	pop bc ; $7507
	ld a, $12 ; $7508
	add a, c ; $750a
	ld c, a ; $750b
	ld a, [$dc00] ; $750c
	ld hl, $7558 ; $750f
	add a, l ; $7512
	ld l, a ; $7513
	jr nc, Label_17_7517 ; $7514
	inc h ; $7516
Label_17_7517:
	ld b, [hl] ; $7517
	ld de, $7e68 ; $7518
	ld hl, $7527 ; $751b
	call Func_00_1e9d ; $751e
	pop af ; $7521
	ldh [$ff96], a ; $7522
	ldh [rWBK], a ; $7524
	ret ; $7526
	INCBIN "data/bank_017/d_7527.bin" ; $7527, 55 bytes
	ld de, $7888 ; $755e
	ld c, $00 ; $7561
	call Func_17_40a3 ; $7563
	ld b, $08 ; $7566
	ld c, $00 ; $7568
	ld h, $03 ; $756a
	rst Rst18 ; $756c
	ld a, [de] ; $756d
	add hl, sp ; $756e
	ret ; $756f
	INCBIN "data/bank_017/d_7570.bin" ; $7570, 2704 bytes
