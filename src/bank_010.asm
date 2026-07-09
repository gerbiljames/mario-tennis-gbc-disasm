INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $10", ROMX[$4000], BANK[$10]

	INCBIN "data/bank_010/d_4000.bin" ; $4000, 1030 bytes
	rst Rst18 ; $4406
	ld e, d ; $4407
	ld a, [bc] ; $4408
	ret ; $4409
	INCBIN "data/bank_010/d_440a.bin" ; $440a, 38 bytes
	rst Rst18 ; $4430
	ld e, d ; $4431
	ld a, [bc] ; $4432
	ret ; $4433
	INCBIN "data/bank_010/d_4434.bin" ; $4434, 2289 bytes
	rst Rst18 ; $4d25
	jr nz, Label_10_4d32 ; $4d26
	ld a, $07 ; $4d28
	ld bc, $0100 ; $4d2a
	ld de, $0100 ; $4d2d
	rst Rst18 ; $4d30
	inc h ; $4d31
Label_10_4d32:
	ld a, [bc] ; $4d32
	ld a, $07 ; $4d33
	rst Rst18 ; $4d35
	jr nz, Label_10_4d42 ; $4d36
	ld a, $0b ; $4d38
	ld bc, $0100 ; $4d3a
	ld de, $0100 ; $4d3d
	rst Rst18 ; $4d40
	inc h ; $4d41
Label_10_4d42:
	ld a, [bc] ; $4d42
	ld a, $0b ; $4d43
	rst Rst18 ; $4d45
	jr nz, Label_10_4d52 ; $4d46
	ld a, $10 ; $4d48
	ld bc, $0100 ; $4d4a
	ld de, $0100 ; $4d4d
	rst Rst18 ; $4d50
	inc h ; $4d51
Label_10_4d52:
	ld a, [bc] ; $4d52
	ld a, $10 ; $4d53
	rst Rst18 ; $4d55
	jr nz, $4d62 ; $4d56
	ld hl, $c2d0 ; $4d58
	ld de, $c296 ; $4d5b
	ld bc, $0005 ; $4d5e
	call CopyMemoryBC ; $4d61
	ld a, $ff ; $4d64
	ld [$c295], a ; $4d66
	ld [$c294], a ; $4d69
	ld [$c2a1], a ; $4d6c
	ret ; $4d6f
	INCBIN "data/bank_010/d_4d70.bin" ; $4d70, 329 bytes
	ld a, $00 ; $4eb9
	ld bc, $3f00 ; $4ebb
	ld de, $3f00 ; $4ebe
	rst Rst18 ; $4ec1
	ld [hl+], a ; $4ec2
	ld a, [bc] ; $4ec3
	call Func_10_4f0d ; $4ec4
	rst Rst18 ; $4ec7
	ld b, d ; $4ec8
	ld [bc], a ; $4ec9
	call Func_00_2f86 ; $4eca
	ret ; $4ecd
Func_10_4ece:
	ld hl, $4f08 ; $4ece
	ld a, [$cb10] ; $4ed1
	add a, l ; $4ed4
	ld l, a ; $4ed5
	jr nc, Label_10_4ed9 ; $4ed6
	inc h ; $4ed8
Label_10_4ed9:
	ld a, [hl] ; $4ed9
	ld [wMatchTypeNumberOfSets], a ; $4eda
	ld hl, $4f0b ; $4edd
	ld a, [$cb0f] ; $4ee0
	add a, l ; $4ee3
	ld l, a ; $4ee4
	jr nc, Label_10_4ee8 ; $4ee5
	inc h ; $4ee7
Label_10_4ee8:
	ld a, [hl] ; $4ee8
	ld [wMatchTypeNumberOfGames], a ; $4ee9
	ld a, [$cb0e] ; $4eec
	ld [$c8f2], a ; $4eef
	or a, a ; $4ef2
	jr z, Label_10_4eff ; $4ef3
	ld a, $04 ; $4ef5
	ld [$c8f3], a ; $4ef7
	rst Rst20 ; $4efa
	ldh [rTIMA], a ; $4efb
	jr Label_10_4f07 ; $4efd
Label_10_4eff:
	ld a, $02 ; $4eff
	ld [$c8f3], a ; $4f01
	rst Rst28 ; $4f04
	ldh [rTIMA], a ; $4f05
Label_10_4f07:
	ret ; $4f07
	INCBIN "data/bank_010/d_4f08.bin" ; $4f08, 5 bytes
Func_10_4f0d:
	call Func_00_1b38 ; $4f0d
	rst Rst08 ; $4f10
	nop ; $4f11
	call Func_00_2f32 ; $4f12
	ld a, [$c295] ; $4f15
	cp a, $0a ; $4f18
	jr nz, Label_10_4f3c ; $4f1a
	call Func_00_1b38 ; $4f1c
	rst Rst08 ; $4f1f
	nop ; $4f20
	call Func_00_2f32 ; $4f21
	xor a, a ; $4f24
	ld [$cb71], a ; $4f25
Label_10_4f28:
	rst Rst18 ; $4f28
	ld [de], a ; $4f29
	ld l, e ; $4f2a
	rst Rst18 ; $4f2b
	inc d ; $4f2c
	ld l, e ; $4f2d
	rst Rst18 ; $4f2e
	nop ; $4f2f
	ld l, e ; $4f30
Label_10_4f31:
	rst Rst18 ; $4f31
	ld [bc], a ; $4f32
	ld l, e ; $4f33
	cp a, $ff ; $4f34
	jr z, Label_10_4f28 ; $4f36
	cp a, $01 ; $4f38
	jr z, Label_10_4f28 ; $4f3a
Label_10_4f3c:
	rst Rst18 ; $4f3c
	nop ; $4f3d
	INCBIN "data/bank_010/d_4f3e.bin" ; $4f3e, 1 bytes
	xor a, a ; $4f3f
	ld [$cb1b], a ; $4f40
	ld [$cb1c], a ; $4f43
	ld [$cb1d], a ; $4f46
	ld [$cb1e], a ; $4f49
	ld [$cb0e], a ; $4f4c
	ld [$cb0f], a ; $4f4f
	ld [$cb10], a ; $4f52
	call EnableLCD ; $4f55
	ld c, $7f ; $4f58
	call Func_00_1d20 ; $4f5a
	call Func_00_1da4 ; $4f5d
	call DisableLCDSafely ; $4f60
	ld a, $01 ; $4f63
	ld [$cb11], a ; $4f65
Label_10_4f68:
	call DisableLCDSafely ; $4f68
	rst Rst18 ; $4f6b
	ld a, [bc] ; $4f6c
	INCBIN "data/bank_010/d_4f6d.bin" ; $4f6d, 1 bytes
	rst Rst18 ; $4f6e
	ld [hl+], a ; $4f6f
	add hl, sp ; $4f70
	call EnableLCD ; $4f71
	ld c, $10 ; $4f74
	call Func_00_1d2e ; $4f76
	call Func_00_1da4 ; $4f79
Label_10_4f7c:
	xor a, a ; $4f7c
	ld [$cb22], a ; $4f7d
	ld [$cb1c], a ; $4f80
	ld [$cb1d], a ; $4f83
	ld [$cb1e], a ; $4f86
	ld [$cb0e], a ; $4f89
	ld [$cb0f], a ; $4f8c
	ld [$cb10], a ; $4f8f
	ld [$cb0b], a ; $4f92
	ldh [$ff8b], a ; $4f95
	ldh [$ff8a], a ; $4f97
	ld [$c320], a ; $4f99
	ld [$c321], a ; $4f9c
	ld [$c322], a ; $4f9f
	ld [$c323], a ; $4fa2
	ld a, $03 ; $4fa5
	ld [$cb0c], a ; $4fa7
	call Func_00_2f32 ; $4faa
	call Func_00_28b9 ; $4fad
	rst Rst18 ; $4fb0
	inc c ; $4fb1
	dec sp ; $4fb2
	cp a, $ff ; $4fb3
	jp z, Label_10_4f31 ; $4fb5
	ld e, a ; $4fb8
	ld hl, $4fc6 ; $4fb9
	add a, a ; $4fbc
	add a, l ; $4fbd
	ld l, a ; $4fbe
	jr nc, Label_10_4fc2 ; $4fbf
	inc h ; $4fc1
Label_10_4fc2:
	ld a, [hl+] ; $4fc2
	ld h, [hl] ; $4fc3
	ld l, a ; $4fc4
	jp hl ; $4fc5
	INCBIN "data/bank_010/d_4fc6.bin" ; $4fc6, 312 bytes
	ld a, $03 ; $50fe
	ld [$c36c], a ; $5100
	rst Rst18 ; $5103
	inc h ; $5104
	inc bc ; $5105
	bit 7, a ; $5106
	jr nz, Label_10_5137 ; $5108
	ld a, [$c8a5] ; $510a
	or a, a ; $510d
	jr z, Label_10_5137 ; $510e
	ld c, $00 ; $5110
	rst Rst18 ; $5112
	nop ; $5113
	INCBIN "data/bank_010/d_5114.bin" ; $5114, 1 bytes
	or a, a ; $5115
	jr z, Label_10_5124 ; $5116
	cp a, $ff ; $5118
	jp z, Label_10_4f68 ; $511a
	ld a, [$c8a7] ; $511d
	or a, a ; $5120
	jp nz, Label_10_51db ; $5121
Label_10_5124:
	call DisableLCDSafely ; $5124
	rst Rst18 ; $5127
	ld [hl+], a ; $5128
	add hl, sp ; $5129
	call EnableLCD ; $512a
	push af ; $512d
	ld c, $10 ; $512e
	call Func_00_1d2e ; $5130
	call Func_00_1da4 ; $5133
	pop af ; $5136
Label_10_5137:
	xor a, a ; $5137
	ld [$c8a8], a ; $5138
	ld a, $03 ; $513b
	ld [$c36c], a ; $513d
	rst Rst18 ; $5140
	ld [bc], a ; $5141
	ld [bc], a ; $5142
	rst Rst18 ; $5143
	nop ; $5144
	INCBIN "data/bank_010/d_5145.bin" ; $5145, 1 bytes
	rst Rst18 ; $5146
	ld h, $03 ; $5147
Label_10_5149:
	rst Rst18 ; $5149
	ld c, $3b ; $514a
	cp a, $ff ; $514c
	jp z, Label_10_4f7c ; $514e
	ld c, $10 ; $5151
	call Func_00_1d20 ; $5153
	call Func_00_1da4 ; $5156
Label_10_5159:
	ld a, [$cb0e] ; $5159
	ld b, a ; $515c
	rst Rst18 ; $515d
	INCBIN "data/bank_010/d_515e.bin" ; $515e, 2 bytes
	call Func_10_56fc ; $5160
	push af ; $5163
	call Func_00_1b38 ; $5164
	call DisableLCDSafely ; $5167
	rst Rst18 ; $516a
	ld a, [bc] ; $516b
	INCBIN "data/bank_010/d_516c.bin" ; $516c, 1 bytes
	rst Rst18 ; $516d
	ld [hl+], a ; $516e
	add hl, sp ; $516f
	xor a, a ; $5170
	ld [$cb53], a ; $5171
	ld [$cb54], a ; $5174
	rst Rst18 ; $5177
	ld [hl+], a ; $5178
	INCBIN "data/bank_010/d_5179.bin" ; $5179, 1 bytes
	rst Rst18 ; $517a
	jr nz, Label_10_51bb ; $517b
	pop af ; $517d
	cp a, $ff ; $517e
	jr nz, Label_10_5191 ; $5180
	call EnableLCD ; $5182
	ld c, $10 ; $5185
	call Func_00_1d2e ; $5187
	ld a, $00 ; $518a
	ld [$cb11], a ; $518c
	jr Label_10_5149 ; $518f
Label_10_5191:
	ld a, $01 ; $5191
	ld [$cb11], a ; $5193
	rst Rst18 ; $5196
	inc h ; $5197
	INCBIN "data/bank_010/d_5198.bin" ; $5198, 1 bytes
	ld a, [$cb54] ; $5199
	or a, a ; $519c
	jr z, Label_10_51b6 ; $519d
	call EnableLCD ; $519f
	ld c, $10 ; $51a2
	call Func_00_1d2e ; $51a4
	rst Rst18 ; $51a7
	inc e ; $51a8
	ld a, $fe ; $51a9
	rst Rst38 ; $51ab
	jr nz, Label_10_51cd ; $51ac
	ld a, $00 ; $51ae
	ld [$cb11], a ; $51b0
	jp z, Label_10_5159 ; $51b3
Label_10_51b6:
	call EnableLCD ; $51b6
	ld c, $10 ; $51b9
Label_10_51bb:
	call Func_00_1d2e ; $51bb
	rst Rst18 ; $51be
	jr Label_10_51ff ; $51bf
	cp a, $ff ; $51c1
	jr nz, Label_10_51cd ; $51c3
	ld a, $00 ; $51c5
	ld [$cb11], a ; $51c7
	jp z, Label_10_5159 ; $51ca
Label_10_51cd:
	ld d, a ; $51cd
	ld a, $04 ; $51ce
	ldh [$ff96], a ; $51d0
	ldh [rWBK], a ; $51d2
	ld a, d ; $51d4
	ld [wCurrentlyUsedCourt], a ; $51d5
	call Func_10_4ece ; $51d8
Label_10_51db:
	ld a, $03 ; $51db
	ld [$c36c], a ; $51dd
	xor a, a ; $51e0
	ld [$c8a5], a ; $51e1
	rst Rst18 ; $51e4
	ld h, $03 ; $51e5
	ld a, $04 ; $51e7
	ld [wGameMode], a ; $51e9
	rst Rst18 ; $51ec
	inc b ; $51ed
	INCBIN "data/bank_010/d_51ee.bin" ; $51ee, 1 bytes
	ld a, [$c8a5] ; $51ef
	or a, a ; $51f2
	jr z, Label_10_51fd ; $51f3
	ld a, $01 ; $51f5
	ld [$c8a8], a ; $51f7
	rst Rst18 ; $51fa
	ld h, $03 ; $51fb
Label_10_51fd:
	ld a, $01 ; $51fd
Label_10_51ff:
	ld [$cb11], a ; $51ff
	call DisableLCDSafely ; $5202
	rst Rst18 ; $5205
	ld a, [bc] ; $5206
	INCBIN "data/bank_010/d_5207.bin" ; $5207, 1 bytes
	rst Rst18 ; $5208
	ld [hl+], a ; $5209
	add hl, sp ; $520a
	call EnableLCD ; $520b
	ld c, $10 ; $520e
	call Func_00_1d2e ; $5210
	jp Label_10_4f7c ; $5213
Label_10_5216:
	xor a, a ; $5216
	ld [$c8a7], a ; $5217
	rst Rst18 ; $521a
	INCBIN "data/bank_010/d_521b.bin" ; $521b, 2 bytes
	cp a, $ff ; $521d
	jr nz, Label_10_5229 ; $521f
	ld a, $00 ; $5221
	ld [$cb11], a ; $5223
	jp Label_10_4f7c ; $5226
Label_10_5229:
	ld a, $03 ; $5229
	ld [$c36c], a ; $522b
	ld a, [$cb20] ; $522e
	ld c, a ; $5231
	rst Rst18 ; $5232
	jr z, Label_10_5250 ; $5233
	cp a, $ff ; $5235
	jr nz, Label_10_5241 ; $5237
	ld a, $00 ; $5239
	ld [$cb11], a ; $523b
	jp Label_10_5216 ; $523e
Label_10_5241:
	ld [wMinigameLevel], a ; $5241
	ld a, [$cb20] ; $5244
	ld b, a ; $5247
	add a, a ; $5248
	add a, b ; $5249
	ld c, a ; $524a
	ld a, [wMinigameLevel] ; $524b
	add a, c ; $524e
	rst Rst18 ; $524f
Label_10_5250:
	inc c ; $5250
	rla ; $5251
	cp a, $ff ; $5252
	jr nz, Label_10_526e ; $5254
	call DisableLCDSafely ; $5256
	rst Rst18 ; $5259
	ld a, [bc] ; $525a
	ld bc, $22df ; $525b
	add hl, sp ; $525e
	call EnableLCD ; $525f
	ld c, $10 ; $5262
	call Func_00_1d2e ; $5264
	ld a, $00 ; $5267
	ld [$cb11], a ; $5269
	jr Label_10_5229 ; $526c
Label_10_526e:
	ld a, [$cb20] ; $526e
	call Func_10_56e9 ; $5271
	rst Rst18 ; $5274
	nop ; $5275
	dec bc ; $5276
	ld a, $01 ; $5277
	ld [$cb11], a ; $5279
	call DisableLCDSafely ; $527c
	rst Rst18 ; $527f
	ld a, [bc] ; $5280
	INCBIN "data/bank_010/d_5281.bin" ; $5281, 1 bytes
	rst Rst18 ; $5282
	ld [hl+], a ; $5283
	add hl, sp ; $5284
	call EnableLCD ; $5285
	ld c, $10 ; $5288
	call Func_00_1d2e ; $528a
	call Func_00_1da4 ; $528d
	ld a, [$c4df] ; $5290
	or a, a ; $5293
	jr nz, Label_10_5229 ; $5294
	ld a, [wPointWinLoseFlag] ; $5296
	cp a, $01 ; $5299
	jr z, Label_10_5229 ; $529b
	jp Label_10_4f7c ; $529d
	INCBIN "data/bank_010/d_52a0.bin" ; $52a0, 49 bytes
Label_10_52d1:
	rst Rst18 ; $52d1
	ld [de], a ; $52d2
	dec sp ; $52d3
	cp a, $ff ; $52d4
	jp z, Label_10_4f7c ; $52d6
	cp a, $03 ; $52d9
	jp nc, Label_10_53d4 ; $52db
	ld [$c36c], a ; $52de
	rst Rst18 ; $52e1
	ld a, [de] ; $52e2
	inc bc ; $52e3
	rst Rst18 ; $52e4
	jr Label_10_5322 ; $52e5
	INCBIN "data/bank_010/d_52e7.bin" ; $52e7, 59 bytes
Label_10_5322:
	ld [$0e1e], sp ; $5322
	INCBIN "data/bank_010/d_5325.bin" ; $5325, 175 bytes
Label_10_53d4:
	cp a, $03 ; $53d4
	jr nz, Label_10_543d ; $53d6
Label_10_53d8:
	rst Rst18 ; $53d8
	ld a, [hl+] ; $53d9
	dec de ; $53da
	cp a, $ff ; $53db
	jr nz, Label_10_53e2 ; $53dd
	jp Label_10_52d1 ; $53df
Label_10_53e2:
	or a, a ; $53e2
	jr nz, Label_10_5411 ; $53e3
	ld c, $10 ; $53e5
	call Func_00_1d20 ; $53e7
	call Func_00_1da4 ; $53ea
	rst Rst18 ; $53ed
	jr nc, Label_10_542b ; $53ee
	ld c, $10 ; $53f0
	call Func_00_1d20 ; $53f2
	call Func_00_1da4 ; $53f5
	call DisableLCDSafely ; $53f8
	rst Rst18 ; $53fb
	ld a, [bc] ; $53fc
	INCBIN "data/bank_010/d_53fd.bin" ; $53fd, 1 bytes
	rst Rst18 ; $53fe
	ld [hl+], a ; $53ff
	add hl, sp ; $5400
	call EnableLCD ; $5401
	ld c, $10 ; $5404
	call Func_00_1d2e ; $5406
	ld a, $00 ; $5409
	ld [$cb11], a ; $540b
	jp Label_10_53d8 ; $540e
Label_10_5411:
	ld c, $10 ; $5411
	call Func_00_1d20 ; $5413
	call Func_00_1da4 ; $5416
	rst Rst18 ; $5419
	inc l ; $541a
	dec de ; $541b
	ld c, $10 ; $541c
	call Func_00_1d20 ; $541e
	call Func_00_1da4 ; $5421
	call DisableLCDSafely ; $5424
	rst Rst18 ; $5427
	ld a, [bc] ; $5428
	INCBIN "data/bank_010/d_5429.bin" ; $5429, 1 bytes
	rst Rst18 ; $542a
Label_10_542b:
	ld [hl+], a ; $542b
	add hl, sp ; $542c
	call EnableLCD ; $542d
	ld c, $10 ; $5430
	call Func_00_1d2e ; $5432
	ld a, $00 ; $5435
	ld [$cb11], a ; $5437
	jp Label_10_53d8 ; $543a
Label_10_543d:
	rst Rst18 ; $543d
	ld d, $3b ; $543e
	cp a, $ff ; $5440
	jp z, Label_10_52d1 ; $5442
	or a, a ; $5445
	jr nz, Label_10_546c ; $5446
	ld c, $10 ; $5448
	call Func_00_1d20 ; $544a
	call Func_00_1da4 ; $544d
	rst Rst18 ; $5450
	ld [$cd3b], sp ; $5451
	ld b, [hl] ; $5454
	inc bc ; $5455
	rst Rst18 ; $5456
	ld a, [bc] ; $5457
	ld bc, $22df ; $5458
	add hl, sp ; $545b
	call EnableLCD ; $545c
	ld c, $10 ; $545f
	call Func_00_1d2e ; $5461
	ld a, $00 ; $5464
	ld [$cb11], a ; $5466
	jp Label_10_53d4 ; $5469
Label_10_546c:
	cp a, $01 ; $546c
	jr nz, Label_10_5494 ; $546e
	ld c, $10 ; $5470
	call Func_00_1d20 ; $5472
	call Func_00_1da4 ; $5475
	rst Rst18 ; $5478
	inc b ; $5479
	dec sp ; $547a
	call DisableLCDSafely ; $547b
	rst Rst18 ; $547e
	ld a, [bc] ; $547f
	ld bc, $22df ; $5480
	add hl, sp ; $5483
	call EnableLCD ; $5484
	ld c, $10 ; $5487
	call Func_00_1d2e ; $5489
	ld a, $00 ; $548c
	ld [$cb11], a ; $548e
	jp Label_10_53d4 ; $5491
Label_10_5494:
	rst Rst18 ; $5494
	ld a, [bc] ; $5495
	dec sp ; $5496
	call DisableLCDSafely ; $5497
	rst Rst18 ; $549a
	ld a, [bc] ; $549b
	ld bc, $22df ; $549c
	add hl, sp ; $549f
	call EnableLCD ; $54a0
	ld c, $10 ; $54a3
	call Func_00_1d2e ; $54a5
	ld a, $00 ; $54a8
	ld [$cb11], a ; $54aa
	jp Label_10_53d4 ; $54ad
	ld c, $10 ; $54b0
	call Func_00_1d20 ; $54b2
	call Func_00_1da4 ; $54b5
	ld a, $06 ; $54b8
	rst Rst18 ; $54ba
	nop ; $54bb
	ccf ; $54bc
	call DisableLCDSafely ; $54bd
	rst Rst18 ; $54c0
	ld a, [bc] ; $54c1
	INCBIN "data/bank_010/d_54c2.bin" ; $54c2, 1 bytes
	rst Rst18 ; $54c3
	ld [hl+], a ; $54c4
	add hl, sp ; $54c5
	call EnableLCD ; $54c6
	ld c, $10 ; $54c9
	call Func_00_1d2e ; $54cb
	ld a, $00 ; $54ce
	ld [$cb11], a ; $54d0
	jp Label_10_4f7c ; $54d3
Label_10_54d6:
	rst Rst18 ; $54d6
	inc d ; $54d7
	dec sp ; $54d8
	cp a, $ff ; $54d9
	jp z, Label_10_4f7c ; $54db
	ld b, a ; $54de
	add a, a ; $54df
	ld hl, $54ec ; $54e0
	add a, l ; $54e3
	ld l, a ; $54e4
	jr nc, Label_10_54e8 ; $54e5
	inc h ; $54e7
Label_10_54e8:
	ld a, [hl+] ; $54e8
	ld h, [hl] ; $54e9
	ld l, a ; $54ea
	jp hl ; $54eb
	INCBIN "data/bank_010/d_54ec.bin" ; $54ec, 77 bytes
	ld c, $10 ; $5539
	call Func_00_1d20 ; $553b
	call Func_00_1da4 ; $553e
	ld b, $01 ; $5541
	rst Rst18 ; $5543
	ld b, $3e ; $5544
	or a, a ; $5546
	jr z, Label_10_554c ; $5547
	rst Rst18 ; $5549
	jr z, Label_10_554f ; $554a
Label_10_554c:
	call DisableLCDSafely ; $554c
Label_10_554f:
	rst Rst18 ; $554f
	ld a, [bc] ; $5550
	INCBIN "data/bank_010/d_5551.bin" ; $5551, 1 bytes
	rst Rst18 ; $5552
	ld [hl+], a ; $5553
	add hl, sp ; $5554
	call EnableLCD ; $5555
	ld c, $10 ; $5558
	call Func_00_1d2e ; $555a
	ld a, $00 ; $555d
	ld [$cb11], a ; $555f
	jp Label_10_54d6 ; $5562
	INCBIN "data/bank_010/d_5565.bin" ; $5565, 388 bytes
Func_10_56e9:
	ld hl, $56f3 ; $56e9
	add a, l ; $56ec
	ld l, a ; $56ed
	jr nc, Label_10_56f1 ; $56ee
	inc h ; $56f0
Label_10_56f1:
	ld a, [hl] ; $56f1
	ret ; $56f2
	INCBIN "data/bank_010/d_56f3.bin" ; $56f3, 9 bytes
Func_10_56fc:
	push af ; $56fc
	ldh a, [$ff96] ; $56fd
	push af ; $56ff
	ld a, $03 ; $5700
	ldh [$ff96], a ; $5702
	ldh [rWBK], a ; $5704
	ld hl, $d816 ; $5706
	ld de, $c8b5 ; $5709
	ld a, [hl+] ; $570c
	ld [de], a ; $570d
	inc de ; $570e
	ld a, [hl+] ; $570f
	ld [de], a ; $5710
	inc de ; $5711
	ld a, [hl+] ; $5712
	ld [de], a ; $5713
	inc de ; $5714
	ld a, [hl+] ; $5715
	ld [de], a ; $5716
	pop af ; $5717
	ldh [$ff96], a ; $5718
	ldh [rWBK], a ; $571a
	pop af ; $571c
	ret ; $571d
	INCBIN "data/bank_010/d_571e.bin" ; $571e, 2381 bytes
	ret ; $606b
	INCBIN "data/bank_010/d_606c.bin" ; $606c, 8084 bytes
