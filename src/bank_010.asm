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
	INCBIN "data/bank_010/d_4fc6.bin" ; $4fc6, 18 bytes
	ld a, e ; $4fd8
	cp a, $ff ; $4fd9
	jr z, Label_10_5041 ; $4fdb
	and a, $7f ; $4fdd
	ld [$c36c], a ; $4fdf
	rst Rst18 ; $4fe2
	ld a, [de] ; $4fe3
	inc bc ; $4fe4
	cp a, $fe ; $4fe5
	jr z, Label_10_5041 ; $4fe7
	rst Rst18 ; $4fe9
	ld b, $1e ; $4fea
	or a, a ; $4fec
	jr z, Label_10_5006 ; $4fed
	call DisableLCDSafely ; $4fef
	rst Rst18 ; $4ff2
	ld [hl+], a ; $4ff3
	add hl, sp ; $4ff4
	call EnableLCD ; $4ff5
	ld a, [$c8a5] ; $4ff8
	or a, a ; $4ffb
	jr nz, Label_10_5006 ; $4ffc
	ld c, $10 ; $4ffe
	call Func_00_1d2e ; $5000
	call Func_00_1da4 ; $5003
Label_10_5006:
	ld a, [$c8a5] ; $5006
	or a, a ; $5009
	jp z, Label_10_50a4 ; $500a
	ld c, $00 ; $500d
	rst Rst18 ; $500f
	nop ; $5010
	INCBIN "data/bank_010/d_5011.bin" ; $5011, 1 bytes
	push af ; $5012
	call Func_00_246d ; $5013
	pop af ; $5016
	or a, a ; $5017
	jp z, Label_10_5093 ; $5018
	cp a, $ff ; $501b
	jp z, Label_10_4f68 ; $501d
	xor a, a ; $5020
	ld [$c8a5], a ; $5021
	rst Rst18 ; $5024
	jr Label_10_502a ; $5025
	ld a, [$c8a7] ; $5027
Label_10_502a:
	or a, a ; $502a
	jr z, Label_10_5030 ; $502b
	jp Label_10_55b6 ; $502d
Label_10_5030:
	rst Rst18 ; $5030
	ld h, h ; $5031
	ld a, [bc] ; $5032
	ld b, $0a ; $5033
	ld c, $01 ; $5035
	rst Rst18 ; $5037
	ld h, d ; $5038
	ld a, [bc] ; $5039
	rst Rst18 ; $503a
	jr Label_10_5040 ; $503b
	rst Rst18 ; $503d
	ld [bc], a ; $503e
	ld a, [bc] ; $503f
Label_10_5040:
	ret ; $5040
Label_10_5041:
	ld a, $03 ; $5041
	ld [$cb0c], a ; $5043
	ld c, $10 ; $5046
	call Func_00_1d20 ; $5048
	call Func_00_1da4 ; $504b
	ld a, e ; $504e
	ld [$c36c], a ; $504f
	rst Rst18 ; $5052
	ld [hl+], a ; $5053
	dec de ; $5054
	cp a, $ff ; $5055
	jp nz, Label_10_5073 ; $5057
	ld a, $00 ; $505a
	ld [$cb11], a ; $505c
	call DisableLCDSafely ; $505f
	rst Rst18 ; $5062
	ld a, [bc] ; $5063
	INCBIN "data/bank_010/d_5064.bin" ; $5064, 1 bytes
	rst Rst18 ; $5065
	ld [hl+], a ; $5066
	add hl, sp ; $5067
	call EnableLCD ; $5068
	ld c, $10 ; $506b
	call Func_00_1d2e ; $506d
	jp Label_10_4f7c ; $5070
Label_10_5073:
	call Func_00_2488 ; $5073
	rst Rst18 ; $5076
	ld d, $02 ; $5077
	rst Rst18 ; $5079
	jr Label_10_507f ; $507a
	rst Rst30 ; $507c
	and a, b ; $507d
	ld [bc], a ; $507e
Label_10_507f:
	jr nz, Label_10_508a ; $507f
	ld a, $01 ; $5081
	ld [$c294], a ; $5083
	ld [$c2a1], a ; $5086
	ret ; $5089
Label_10_508a:
	ld a, $03 ; $508a
	ld [$c294], a ; $508c
	ld [$c2a1], a ; $508f
	ret ; $5092
Label_10_5093:
	call DisableLCDSafely ; $5093
	rst Rst18 ; $5096
	ld [hl+], a ; $5097
	add hl, sp ; $5098
	call EnableLCD ; $5099
	ld c, $10 ; $509c
	call Func_00_1d2e ; $509e
	call Func_00_1da4 ; $50a1
Label_10_50a4:
	xor a, a ; $50a4
	ld [$c8a5], a ; $50a5
	ld [$c8a7], a ; $50a8
	call Func_00_246d ; $50ab
	rst Rst18 ; $50ae
	jr Label_10_50b4 ; $50af
	call Func_10_5752 ; $50b1
Label_10_50b4:
	ld [$cb74], a ; $50b4
	cp a, $04 ; $50b7
	jr z, Label_10_50ca ; $50b9
	rst Rst18 ; $50bb
	ld a, [bc] ; $50bc
	INCBIN "data/bank_010/d_50bd.bin" ; $50bd, 1 bytes
	cp a, $ff ; $50be
	jr nz, Label_10_50ca ; $50c0
	ld a, $00 ; $50c2
	ld [$cb11], a ; $50c4
	jp Label_10_4f7c ; $50c7
Label_10_50ca:
	call Func_10_5752 ; $50ca
	ld [$cb74], a ; $50cd
	call Func_00_246d ; $50d0
	ld a, $00 ; $50d3
	ld [wGameMode], a ; $50d5
	rst Rst28 ; $50d8
	ldh [$ff09], a ; $50d9
	ld b, $0a ; $50db
	ld c, $01 ; $50dd
	rst Rst18 ; $50df
	ld h, d ; $50e0
	ld a, [bc] ; $50e1
	rst Rst18 ; $50e2
	jr Label_10_50e8 ; $50e3
	rst Rst30 ; $50e5
	and a, b ; $50e6
	ld [bc], a ; $50e7
Label_10_50e8:
	jr nz, Label_10_50f5 ; $50e8
	ld a, [$cb74] ; $50ea
	ld a, a ; $50ed
	ld [$c294], a ; $50ee
	ld [$c2a1], a ; $50f1
	ret ; $50f4
Label_10_50f5:
	ld a, $03 ; $50f5
	ld [$c294], a ; $50f7
	ld [$c2a1], a ; $50fa
	ret ; $50fd
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
	INCBIN "data/bank_010/d_5565.bin" ; $5565, 81 bytes
Label_10_55b6:
	rst Rst18 ; $55b6
	inc b ; $55b7
	ld [$a5fa], sp ; $55b8
	ret z ; $55bb
	or a, a ; $55bc
	jr z, Label_10_55d5 ; $55bd
	rst Rst18 ; $55bf
	jr Label_10_55c5 ; $55c0
	INCBIN "data/bank_010/d_55c2.bin" ; $55c2, 3 bytes
Label_10_55c5:
	add a, b ; $55c5
	jp nz, Label_00_013e ; $55c6
	ld [$c295], a ; $55c9
	ld a, $ff ; $55cc
	ld [$c294], a ; $55ce
	ld [$c2a1], a ; $55d1
	ret ; $55d4
Label_10_55d5:
	ld a, [wGameMode] ; $55d5
	cp a, $04 ; $55d8
	jr nz, Label_10_5604 ; $55da
	rst Rst28 ; $55dc
	ldh [$ff09], a ; $55dd
	xor a, a ; $55df
	ld [$c8a7], a ; $55e0
	ld b, $00 ; $55e3
	ld c, $01 ; $55e5
	rst Rst18 ; $55e7
	ld h, d ; $55e8
	ld a, [bc] ; $55e9
	rst Rst18 ; $55ea
	jr Label_10_55f0 ; $55eb
	INCBIN "data/bank_010/d_55ed.bin" ; $55ed, 3 bytes
Label_10_55f0:
	jr nz, Label_10_55fb ; $55f0
	ld a, $02 ; $55f2
	ld [$c294], a ; $55f4
	ld [$c2a1], a ; $55f7
	ret ; $55fa
Label_10_55fb:
	ld a, $03 ; $55fb
	ld [$c294], a ; $55fd
	ld [$c2a1], a ; $5600
	ret ; $5603
Label_10_5604:
	ld a, [$c8f7] ; $5604
	cp a, $14 ; $5607
	jr c, Label_10_561e ; $5609
	ld a, $1c ; $560b
	ld [wStoryModeCurrentLocation], a ; $560d
	ld a, $0a ; $5610
	ld [$c295], a ; $5612
	ld a, $ff ; $5615
	ld [$c294], a ; $5617
	ld [$c2a1], a ; $561a
	ret ; $561d
Label_10_561e:
	cp a, $0f ; $561e
	jr c, Label_10_564d ; $5620
	rst Rst30 ; $5622
	ldh [rTIMA], a ; $5623
	jr nz, Label_10_563a ; $5625
	ld a, $19 ; $5627
	ld [wStoryModeCurrentLocation], a ; $5629
	ld a, $0a ; $562c
	ld [$c295], a ; $562e
	ld a, $ff ; $5631
	ld [$c294], a ; $5633
	ld [$c2a1], a ; $5636
	ret ; $5639
Label_10_563a:
	ld a, $19 ; $563a
	ld [wStoryModeCurrentLocation], a ; $563c
	ld a, $0b ; $563f
	ld [$c295], a ; $5641
	ld a, $ff ; $5644
	ld [$c294], a ; $5646
	ld [$c2a1], a ; $5649
	ret ; $564c
Label_10_564d:
	cp a, $0a ; $564d
	jr c, Label_10_5664 ; $564f
	ld a, $07 ; $5651
	ld [wStoryModeCurrentLocation], a ; $5653
	ld a, $0d ; $5656
	ld [$c295], a ; $5658
	ld a, $ff ; $565b
	ld [$c294], a ; $565d
	ld [$c2a1], a ; $5660
	ret ; $5663
Label_10_5664:
	cp a, $05 ; $5664
	jr c, Label_10_5690 ; $5666
	jr z, Label_10_567d ; $5668
	ld a, $10 ; $566a
	ld [wStoryModeCurrentLocation], a ; $566c
	ld a, $0f ; $566f
	ld [$c295], a ; $5671
	ld a, $ff ; $5674
	ld [$c294], a ; $5676
	ld [$c2a1], a ; $5679
	ret ; $567c
Label_10_567d:
	ld a, $10 ; $567d
	ld [wStoryModeCurrentLocation], a ; $567f
	ld a, $09 ; $5682
	ld [$c295], a ; $5684
	ld a, $ff ; $5687
	ld [$c294], a ; $5689
	ld [$c2a1], a ; $568c
	ret ; $568f
Label_10_5690:
	rst Rst30 ; $5690
	ldh [rTIMA], a ; $5691
	jr nz, Label_10_56bf ; $5693
	cp a, $00 ; $5695
	jr z, Label_10_56ac ; $5697
	ld a, $0b ; $5699
	ld [wStoryModeCurrentLocation], a ; $569b
	ld a, $0f ; $569e
	ld [$c295], a ; $56a0
	ld a, $ff ; $56a3
	ld [$c294], a ; $56a5
	ld [$c2a1], a ; $56a8
	ret ; $56ab
Label_10_56ac:
	ld a, $0b ; $56ac
	ld [wStoryModeCurrentLocation], a ; $56ae
	ld a, $09 ; $56b1
	ld [$c295], a ; $56b3
	ld a, $ff ; $56b6
	ld [$c294], a ; $56b8
	ld [$c2a1], a ; $56bb
	ret ; $56be
Label_10_56bf:
	cp a, $00 ; $56bf
	jr z, Label_10_56d6 ; $56c1
	ld a, $0c ; $56c3
	ld [wStoryModeCurrentLocation], a ; $56c5
	ld a, $0f ; $56c8
	ld [$c295], a ; $56ca
	ld a, $ff ; $56cd
	ld [$c294], a ; $56cf
	ld [$c2a1], a ; $56d2
	ret ; $56d5
Label_10_56d6:
	ld a, $0c ; $56d6
	ld [wStoryModeCurrentLocation], a ; $56d8
	ld a, $09 ; $56db
	ld [$c295], a ; $56dd
	ld a, $ff ; $56e0
	ld [$c294], a ; $56e2
	ld [$c2a1], a ; $56e5
	ret ; $56e8
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
	INCBIN "data/bank_010/d_571e.bin" ; $571e, 52 bytes
Func_10_5752:
	rst Rst30 ; $5752
	ldh [rTIMA], a ; $5753
	jr nz, Label_10_5770 ; $5755
	rst Rst30 ; $5757
	add a, b ; $5758
	rlca ; $5759
	ld a, $02 ; $575a
	jr z, Label_10_5789 ; $575c
	rst Rst30 ; $575e
	nop ; $575f
	ld d, $3e ; $5760
	inc b ; $5762
	jr z, Label_10_5789 ; $5763
	rst Rst30 ; $5765
	ld b, b ; $5766
	ld d, $3e ; $5767
	dec b ; $5769
	jr z, Label_10_5789 ; $576a
	ld a, $02 ; $576c
	jr Label_10_5789 ; $576e
Label_10_5770:
	rst Rst30 ; $5770
	and a, b ; $5771
	ld b, $3e ; $5772
	ld [bc], a ; $5774
	jr z, Label_10_5789 ; $5775
	rst Rst30 ; $5777
	jr nz, Label_10_5790 ; $5778
	ld a, $04 ; $577a
	jr z, Label_10_5789 ; $577c
	rst Rst30 ; $577e
	ld h, b ; $577f
	ld d, $3e ; $5780
	dec b ; $5782
	jr z, Label_10_5789 ; $5783
	ld a, $02 ; $5785
	jr Label_10_5789 ; $5787
Label_10_5789:
	ret ; $5789
	INCBIN "data/bank_010/d_578a.bin" ; $578a, 6 bytes
Label_10_5790:
	ld a, a ; $5790
	jr nz, Label_10_57f3 ; $5791
	ld a, [$c8a5] ; $5793
	or a, a ; $5796
	jr z, Label_10_57f3 ; $5797
	ld a, [$c36c] ; $5799
	ld b, a ; $579c
	ld a, [$c8b5] ; $579d
	bit 7, a ; $57a0
	jr z, Label_10_57ab ; $57a2
	and a, $7f ; $57a4
	srl a ; $57a6
	cp a, b ; $57a8
	jr z, Label_10_57d7 ; $57a9
Label_10_57ab:
	ld a, [$c8b6] ; $57ab
	bit 7, a ; $57ae
	jr z, Label_10_57b9 ; $57b0
	and a, $7f ; $57b2
	srl a ; $57b4
	cp a, b ; $57b6
	jr z, Label_10_57d7 ; $57b7
Label_10_57b9:
	ld a, [$c8b7] ; $57b9
	bit 7, a ; $57bc
	jr z, Label_10_57c7 ; $57be
	and a, $7f ; $57c0
	srl a ; $57c2
	cp a, b ; $57c4
	jr z, Label_10_57d7 ; $57c5
Label_10_57c7:
	ld a, [$c8b8] ; $57c7
	bit 7, a ; $57ca
	jr z, Label_10_57d5 ; $57cc
	and a, $7f ; $57ce
	srl a ; $57d0
	cp a, b ; $57d2
	jr z, Label_10_57d7 ; $57d3
Label_10_57d5:
	jr Label_10_57f3 ; $57d5
Label_10_57d7:
	ld b, $02 ; $57d7
	rst Rst18 ; $57d9
	ld b, $3e ; $57da
	or a, a ; $57dc
	jr z, Label_10_57ee ; $57dd
	xor a, a ; $57df
	ld [$c8a5], a ; $57e0
	ld [$c8a7], a ; $57e3
	rst Rst18 ; $57e6
	ld h, $03 ; $57e7
	pop bc ; $57e9
	pop af ; $57ea
	ld a, $00 ; $57eb
	ret ; $57ed
Label_10_57ee:
	pop bc ; $57ee
	pop af ; $57ef
	ld a, $01 ; $57f0
	ret ; $57f2
Label_10_57f3:
	pop bc ; $57f3
	pop af ; $57f4
	ret ; $57f5
	INCBIN "data/bank_010/d_57f6.bin" ; $57f6, 929 bytes
	ld a, [$c295] ; $5b97
	cp a, $ff ; $5b9a
	jp z, Label_10_5bdc ; $5b9c
	rst Rst30 ; $5b9f
	ldh [rTIMA], a ; $5ba0
	jr z, Label_10_5bca ; $5ba2
	ld a, $02 ; $5ba4
	ld bc, $00ff ; $5ba6
	rst Rst18 ; $5ba9
	jr Label_10_5bb6 ; $5baa
	INCBIN "data/bank_010/d_5bac.bin" ; $5bac, 10 bytes
Label_10_5bb6:
	ld a, $02 ; $5bb6
	rst Rst18 ; $5bb8
	jr nz, Label_10_5bc5 ; $5bb9
	ld a, $02 ; $5bbb
	ld b, $c0 ; $5bbd
	rst Rst18 ; $5bbf
	ld l, $0a ; $5bc0
	ld a, $02 ; $5bc2
	INCBIN "data/bank_010/d_5bc4.bin" ; $5bc4, 1 bytes
Label_10_5bc5:
	stop ; $5bc5
	rst Rst18 ; $5bc7
	jr Label_10_5bd4 ; $5bc8
Label_10_5bca:
	ld a, $00 ; $5bca
	ld bc, $0010 ; $5bcc
	rst Rst18 ; $5bcf
	jr Label_10_5bdc ; $5bd0
	ld a, $00 ; $5bd2
Label_10_5bd4:
	ld b, $c0 ; $5bd4
	ld de, $0200 ; $5bd6
	rst Rst18 ; $5bd9
	ld a, [hl+] ; $5bda
	ld a, [bc] ; $5bdb
Label_10_5bdc:
	ret ; $5bdc
	INCBIN "data/bank_010/d_5bdd.bin" ; $5bdd, 17 bytes
	rst Rst28 ; $5bee
	ld h, b ; $5bef
	rrca ; $5bf0
	ret ; $5bf1
	INCBIN "data/bank_010/d_5bf2.bin" ; $5bf2, 768 bytes
	ld a, $00 ; $5ef2
	ld b, a ; $5ef4
	ld a, $0a ; $5ef5
	rst Rst18 ; $5ef7
	jr nc, Label_10_5f04 ; $5ef8
	ld a, [$c2b0] ; $5efa
	add a, a ; $5efd
	add a, $30 ; $5efe
	ld l, a ; $5f00
	adc a, $5f ; $5f01
	sub a, l ; $5f03
Label_10_5f04:
	ld h, a ; $5f04
	ld a, [hl+] ; $5f05
	ld h, [hl] ; $5f06
	ld l, a ; $5f07
	rst Rst18 ; $5f08
	ld c, $0a ; $5f09
	ld a, [$c2b0] ; $5f0b
	cp a, $06 ; $5f0e
	jr nc, Label_10_5f2a ; $5f10
	ld a, $0a ; $5f12
	rst Rst18 ; $5f14
	ld a, [bc] ; $5f15
	ld a, [bc] ; $5f16
	rst Rst18 ; $5f17
	ld [de], a ; $5f18
	ld a, [bc] ; $5f19
	rst Rst18 ; $5f1a
	inc c ; $5f1b
	ld a, [bc] ; $5f1c
	push af ; $5f1d
	ld a, $05 ; $5f1e
	rst Rst18 ; $5f20
	inc b ; $5f21
	ld a, [bc] ; $5f22
	pop af ; $5f23
	and a, a ; $5f24
	jr z, Label_10_5f2a ; $5f25
	rst Rst18 ; $5f27
	INCBIN "data/bank_010/d_5f28.bin" ; $5f28, 2 bytes
Label_10_5f2a:
	ld a, $0a ; $5f2a
	rst Rst18 ; $5f2c
	INCBIN "data/bank_010/d_5f2d.bin" ; $5f2d, 2 bytes
	ret ; $5f2f
	INCBIN "data/bank_010/d_5f30.bin" ; $5f30, 315 bytes
	ret ; $606b
	INCBIN "data/bank_010/d_606c.bin" ; $606c, 133 bytes
	call Func_10_7dbd ; $60f1
	ld a, [$c2b0] ; $60f4
	sra a ; $60f7
	ld [$c2b1], a ; $60f9
	call Func_10_611b ; $60fc
	call Func_10_6103 ; $60ff
	ret ; $6102
Func_10_6103:
	rst Rst30 ; $6103
	ld h, b ; $6104
	rrca ; $6105
	jr z, Label_10_611a ; $6106
	ld a, $08 ; $6108
	ld bc, $2140 ; $610a
	ld de, $0f00 ; $610d
	rst Rst18 ; $6110
	ld [hl+], a ; $6111
	ld a, [bc] ; $6112
	ld a, $08 ; $6113
	ld b, $00 ; $6115
	rst Rst18 ; $6117
	ld l, $0a ; $6118
Label_10_611a:
	ret ; $611a
Func_10_611b:
	call Func_10_612c ; $611b
	jr z, Label_10_612b ; $611e
	ld a, $12 ; $6120
	ld bc, $1b00 ; $6122
	ld de, $1100 ; $6125
	rst Rst18 ; $6128
	ld [hl+], a ; $6129
	ld a, [bc] ; $612a
Label_10_612b:
	ret ; $612b
Func_10_612c:
	ld a, [$c2b1] ; $612c
	add a, a ; $612f
	add a, $50 ; $6130
	ld l, a ; $6132
	adc a, $61 ; $6133
	sub a, l ; $6135
	ld h, a ; $6136
	ld a, [hl+] ; $6137
	ld d, [hl] ; $6138
	ld e, a ; $6139
	call Func_00_24ef ; $613a
	ret ; $613d
	INCBIN "data/bank_010/d_613e.bin" ; $613e, 3764 bytes
	rst Rst18 ; $6ff2
	ld [hl+], a ; $6ff3
	ld a, [bc] ; $6ff4
	ld a, $02 ; $6ff5
	ld bc, $2100 ; $6ff7
	ld de, $3400 ; $6ffa
	rst Rst18 ; $6ffd
	ld [hl+], a ; $6ffe
	ld a, [bc] ; $6fff
	ld a, $02 ; $7000
	ld b, $c0 ; $7002
	rst Rst18 ; $7004
	ld l, $0a ; $7005
	rst Rst30 ; $7007
	add a, b ; $7008
	rlca ; $7009
	jr nz, Label_10_7029 ; $700a
	ld a, $04 ; $700c
	ld bc, $3f00 ; $700e
	ld de, $3f00 ; $7011
	rst Rst18 ; $7014
	ld [hl+], a ; $7015
	ld a, [bc] ; $7016
	jr Label_10_7029 ; $7017
	INCBIN "data/bank_010/d_7019.bin" ; $7019, 16 bytes
Label_10_7029:
	ld a, $00 ; $7029
	ld b, $c0 ; $702b
	rst Rst18 ; $702d
	ld l, $0a ; $702e
	xor a, a ; $7030
	ld [$c2d5], a ; $7031
	ld c, $04 ; $7034
	call Func_00_1d2e ; $7036
	call Func_00_1da4 ; $7039
	push af ; $703c
	ld a, $3c ; $703d
	rst Rst18 ; $703f
	inc b ; $7040
	ld a, [bc] ; $7041
	pop af ; $7042
	ld hl, $01f2 ; $7043
	rst Rst18 ; $7046
	ld c, $0a ; $7047
	call Func_10_73ee ; $7049
	rst Rst30 ; $704c
	ldh [rTIMA], a ; $704d
	jp z, Label_10_7059 ; $704f
	ld a, $02 ; $7052
	ld d, $02 ; $7054
	rst Rst18 ; $7056
	inc [hl] ; $7057
	ld a, [bc] ; $7058
Label_10_7059:
	ld a, $00 ; $7059
	ld d, $02 ; $705b
	rst Rst18 ; $705d
	inc [hl] ; $705e
	ld a, [bc] ; $705f
	ld a, $00 ; $7060
	rst Rst18 ; $7062
	ld [hl], $0a ; $7063
	call Func_10_7405 ; $7065
	rst Rst18 ; $7068
	ld [de], a ; $7069
	ld a, [bc] ; $706a
	rst Rst18 ; $706b
	inc c ; $706c
	ld a, [bc] ; $706d
	push af ; $706e
	ld a, $05 ; $706f
	rst Rst18 ; $7071
	inc b ; $7072
	ld a, [bc] ; $7073
	pop af ; $7074
	and a, a ; $7075
	jr nz, Label_10_7089 ; $7076
	ld a, $00 ; $7078
	ld d, $03 ; $707a
	rst Rst18 ; $707c
	inc [hl] ; $707d
	ld a, [bc] ; $707e
	ld a, $00 ; $707f
	rst Rst18 ; $7081
	ld [hl], $0a ; $7082
	rst Rst18 ; $7084
	INCBIN "data/bank_010/d_7085.bin" ; $7085, 4 bytes
Label_10_7089:
	ld a, $00 ; $7089
	ld d, $04 ; $708b
	rst Rst18 ; $708d
	inc [hl] ; $708e
	ld a, [bc] ; $708f
	ld a, $00 ; $7090
	rst Rst18 ; $7092
	ld [hl], $0a ; $7093
	push af ; $7095
	ld a, $0a ; $7096
	rst Rst18 ; $7098
	inc b ; $7099
	ld a, [bc] ; $709a
	pop af ; $709b
	ld a, $03 ; $709c
	ld d, $03 ; $709e
	rst Rst18 ; $70a0
	inc [hl] ; $70a1
	ld a, [bc] ; $70a2
	ld a, $03 ; $70a3
	rst Rst18 ; $70a5
	ld [hl], $0a ; $70a6
	ld a, $03 ; $70a8
	rst Rst18 ; $70aa
	ld [$3e0a], sp ; $70ab
	inc bc ; $70ae
	ld b, $c0 ; $70af
	rst Rst18 ; $70b1
	ld l, $0a ; $70b2
	push af ; $70b4
	ld a, $50 ; $70b5
	rst Rst18 ; $70b7
	inc b ; $70b8
	ld a, [bc] ; $70b9
	pop af ; $70ba
	ld hl, $01f8 ; $70bb
	rst Rst18 ; $70be
	ld c, $0a ; $70bf
	call Func_10_73ee ; $70c1
	rst Rst30 ; $70c4
	ldh [rTIMA], a ; $70c5
	jp z, Label_10_7101 ; $70c7
	ld a, $06 ; $70ca
	ld bc, $2080 ; $70cc
	ld de, $3200 ; $70cf
	rst Rst18 ; $70d2
	ld [hl+], a ; $70d3
	ld a, [bc] ; $70d4
	ld a, $07 ; $70d5
	ld bc, $2280 ; $70d7
	ld de, $3200 ; $70da
	rst Rst18 ; $70dd
	ld [hl+], a ; $70de
	ld a, [bc] ; $70df
	rst Rst08 ; $70e0
	sub a, a ; $70e1
	push af ; $70e2
	ld a, $50 ; $70e3
	rst Rst18 ; $70e5
	inc b ; $70e6
	ld a, [bc] ; $70e7
	pop af ; $70e8
	ld a, $06 ; $70e9
	ld bc, $3f00 ; $70eb
	ld de, $3f00 ; $70ee
	rst Rst18 ; $70f1
	ld [hl+], a ; $70f2
	ld a, [bc] ; $70f3
	ld a, $07 ; $70f4
	ld bc, $3f00 ; $70f6
	ld de, $3f00 ; $70f9
	rst Rst18 ; $70fc
	ld [hl+], a ; $70fd
	ld a, [bc] ; $70fe
	jr Label_10_7120 ; $70ff
Label_10_7101:
	ld a, $06 ; $7101
	ld bc, $2180 ; $7103
	ld de, $3200 ; $7106
	rst Rst18 ; $7109
	ld [hl+], a ; $710a
	ld a, [bc] ; $710b
	rst Rst08 ; $710c
	sub a, a ; $710d
	push af ; $710e
	ld a, $50 ; $710f
	rst Rst18 ; $7111
	inc b ; $7112
	ld a, [bc] ; $7113
	pop af ; $7114
	ld a, $06 ; $7115
	ld bc, $3f00 ; $7117
	ld de, $3f00 ; $711a
	rst Rst18 ; $711d
	ld [hl+], a ; $711e
	ld a, [bc] ; $711f
Label_10_7120:
	ld a, $03 ; $7120
	ld b, $40 ; $7122
	rst Rst18 ; $7124
	ld l, $0a ; $7125
	push af ; $7127
	ld a, $01 ; $7128
	rst Rst18 ; $712a
	inc b ; $712b
	ld a, [bc] ; $712c
	pop af ; $712d
	call Func_10_73ee ; $712e
	push af ; $7131
	ld a, $1e ; $7132
	rst Rst18 ; $7134
	inc b ; $7135
	ld a, [bc] ; $7136
	pop af ; $7137
	ld a, $03 ; $7138
	ld d, $03 ; $713a
	rst Rst18 ; $713c
	inc [hl] ; $713d
	ld a, [bc] ; $713e
	ld a, $03 ; $713f
	rst Rst18 ; $7141
	ld [hl], $0a ; $7142
	ld a, $03 ; $7144
	rst Rst18 ; $7146
	ld [$3e0a], sp ; $7147
	inc bc ; $714a
	ld bc, $0010 ; $714b
	rst Rst18 ; $714e
	jr Label_10_715b ; $714f
	INCBIN "data/bank_010/d_7151.bin" ; $7151, 10 bytes
Label_10_715b:
	ld a, [bc] ; $715b
	ld a, $03 ; $715c
	rst Rst18 ; $715e
	jr nz, Label_10_716b ; $715f
	push af ; $7161
	ld a, $28 ; $7162
	rst Rst18 ; $7164
	inc b ; $7165
	ld a, [bc] ; $7166
	pop af ; $7167
	ld a, $03 ; $7168
	INCBIN "data/bank_010/d_716a.bin" ; $716a, 1 bytes
Label_10_716b:
	inc bc ; $716b
	rst Rst18 ; $716c
	inc [hl] ; $716d
	ld a, [bc] ; $716e
	ld a, $03 ; $716f
	rst Rst18 ; $7171
	ld [hl], $0a ; $7172
	ld a, $03 ; $7174
	ld d, $03 ; $7176
	rst Rst18 ; $7178
	inc [hl] ; $7179
	ld a, [bc] ; $717a
	ld a, $03 ; $717b
	rst Rst18 ; $717d
	ld [hl], $0a ; $717e
	ld a, $03 ; $7180
	ld bc, $2000 ; $7182
	ld de, $3000 ; $7185
	rst Rst18 ; $7188
	inc h ; $7189
	ld a, [bc] ; $718a
	ld a, $03 ; $718b
	rst Rst18 ; $718d
	jr nz, Label_10_719a ; $718e
	ld a, $03 ; $7190
	ld b, $40 ; $7192
	rst Rst18 ; $7194
	ld l, $0a ; $7195
	push af ; $7197
	ld a, $0a ; $7198
Label_10_719a:
	rst Rst18 ; $719a
	inc b ; $719b
	ld a, [bc] ; $719c
	pop af ; $719d
	ld a, $03 ; $719e
	rst Rst18 ; $71a0
	ld [$3e0a], sp ; $71a1
	nop ; $71a4
	ld d, $02 ; $71a5
	rst Rst18 ; $71a7
	inc [hl] ; $71a8
	ld a, [bc] ; $71a9
	ld a, $00 ; $71aa
	rst Rst18 ; $71ac
	ld [hl], $0a ; $71ad
	ld a, $03 ; $71af
	ld d, $03 ; $71b1
	rst Rst18 ; $71b3
	inc [hl] ; $71b4
	ld a, [bc] ; $71b5
	ld a, $03 ; $71b6
	rst Rst18 ; $71b8
	ld [hl], $0a ; $71b9
Label_10_71bb:
	ld a, $03 ; $71bb
	rst Rst18 ; $71bd
	ld a, [bc] ; $71be
	ld a, [bc] ; $71bf
	rst Rst18 ; $71c0
	ld [de], a ; $71c1
	ld a, [bc] ; $71c2
	rst Rst18 ; $71c3
	inc c ; $71c4
	ld a, [bc] ; $71c5
	push af ; $71c6
	ld a, $05 ; $71c7
	rst Rst18 ; $71c9
	inc b ; $71ca
	ld a, [bc] ; $71cb
	pop af ; $71cc
	and a, a ; $71cd
	jr z, Label_10_71f0 ; $71ce
	ld a, $00 ; $71d0
	ld d, $04 ; $71d2
	rst Rst18 ; $71d4
	inc [hl] ; $71d5
	ld a, [bc] ; $71d6
	ld a, $00 ; $71d7
	rst Rst18 ; $71d9
	ld [hl], $0a ; $71da
	ld a, $03 ; $71dc
	ld d, $02 ; $71de
	rst Rst18 ; $71e0
	inc [hl] ; $71e1
	ld a, [bc] ; $71e2
	ld a, $03 ; $71e3
	rst Rst18 ; $71e5
	ld [hl], $0a ; $71e6
	ld hl, $01ff ; $71e8
	rst Rst18 ; $71eb
	ld c, $0a ; $71ec
	jr Label_10_71bb ; $71ee
Label_10_71f0:
	rst Rst30 ; $71f0
	ldh [rTIMA], a ; $71f1
	jp z, Label_10_72a9 ; $71f3
	ld a, $00 ; $71f6
	ld d, $03 ; $71f8
	rst Rst18 ; $71fa
	inc [hl] ; $71fb
	ld a, [bc] ; $71fc
	ld a, $00 ; $71fd
	rst Rst18 ; $71ff
	ld [hl], $0a ; $7200
	ld a, $03 ; $7202
	ld d, $03 ; $7204
	rst Rst18 ; $7206
	inc [hl] ; $7207
	ld a, [bc] ; $7208
	ld a, $03 ; $7209
	rst Rst18 ; $720b
	ld [hl], $0a ; $720c
	ld hl, $0200 ; $720e
	rst Rst18 ; $7211
	ld c, $0a ; $7212
	ld a, $03 ; $7214
	rst Rst18 ; $7216
	ld [$3e0a], sp ; $7217
	nop ; $721a
	ld d, $03 ; $721b
	rst Rst18 ; $721d
	inc [hl] ; $721e
	ld a, [bc] ; $721f
	ld a, $02 ; $7220
	ld d, $03 ; $7222
	rst Rst18 ; $7224
	inc [hl] ; $7225
	ld a, [bc] ; $7226
	ld a, $02 ; $7227
	rst Rst18 ; $7229
	ld [hl], $0a ; $722a
	push af ; $722c
	ld a, $0a ; $722d
	rst Rst18 ; $722f
	inc b ; $7230
	ld a, [bc] ; $7231
	pop af ; $7232
	ld a, $02 ; $7233
	ld b, a ; $7235
	ld a, $00 ; $7236
	rst Rst18 ; $7238
	ld [hl-], a ; $7239
	ld a, [bc] ; $723a
	push af ; $723b
	ld a, $1e ; $723c
	rst Rst18 ; $723e
	inc b ; $723f
	ld a, [bc] ; $7240
	pop af ; $7241
	ld a, $00 ; $7242
	ld d, $03 ; $7244
	rst Rst18 ; $7246
	inc [hl] ; $7247
	ld a, [bc] ; $7248
	ld a, $02 ; $7249
	ld d, $03 ; $724b
	rst Rst18 ; $724d
	inc [hl] ; $724e
	ld a, [bc] ; $724f
	ld a, $02 ; $7250
	rst Rst18 ; $7252
	ld [hl], $0a ; $7253
	ld a, $02 ; $7255
	ld b, $40 ; $7257
	rst Rst18 ; $7259
	ld l, $0a ; $725a
	ld a, $00 ; $725c
	ld bc, $2100 ; $725e
	ld de, $3600 ; $7261
	rst Rst18 ; $7264
	inc h ; $7265
	ld a, [bc] ; $7266
	ld a, $00 ; $7267
	rst Rst18 ; $7269
	jr nz, Label_10_7276 ; $726a
	ld a, $00 ; $726c
	ld bc, $2100 ; $726e
	ld de, $3700 ; $7271
	rst Rst18 ; $7274
	inc h ; $7275
Label_10_7276:
	ld a, [bc] ; $7276
	ld a, $02 ; $7277
	ld bc, $2100 ; $7279
	ld de, $3500 ; $727c
	rst Rst18 ; $727f
	inc h ; $7280
	ld a, [bc] ; $7281
	ld a, $02 ; $7282
	rst Rst18 ; $7284
	jr nz, Label_10_7291 ; $7285
	call Func_10_7339 ; $7287
	ldh a, [$ff95] ; $728a
	ld b, a ; $728c
	ld a, $00 ; $728d
	INCBIN "data/bank_010/d_728f.bin" ; $728f, 2 bytes
Label_10_7291:
	ld [hl], h ; $7291
	rst Rst18 ; $7292
	ld a, [de] ; $7293
	ld a, [bc] ; $7294
	ldh a, [$ff95] ; $7295
	ld b, a ; $7297
	ld a, $02 ; $7298
	ld de, $741c ; $729a
	rst Rst18 ; $729d
	ld a, [de] ; $729e
	ld a, [bc] ; $729f
	push af ; $72a0
	ld a, $28 ; $72a1
	rst Rst18 ; $72a3
	inc b ; $72a4
	ld a, [bc] ; $72a5
	pop af ; $72a6
	jr Label_10_7314 ; $72a7
Label_10_72a9:
	ld a, $00 ; $72a9
	ld d, $03 ; $72ab
	rst Rst18 ; $72ad
	inc [hl] ; $72ae
	ld a, [bc] ; $72af
	ld a, $00 ; $72b0
	rst Rst18 ; $72b2
	ld [hl], $0a ; $72b3
	ld a, $03 ; $72b5
	ld d, $03 ; $72b7
	rst Rst18 ; $72b9
	inc [hl] ; $72ba
	ld a, [bc] ; $72bb
	ld a, $03 ; $72bc
	rst Rst18 ; $72be
	ld [hl], $0a ; $72bf
	ld hl, $0200 ; $72c1
	rst Rst18 ; $72c4
	ld c, $0a ; $72c5
	ld a, $03 ; $72c7
	rst Rst18 ; $72c9
	ld [$3e0a], sp ; $72ca
	nop ; $72cd
	ld d, $03 ; $72ce
	rst Rst18 ; $72d0
	inc [hl] ; $72d1
	ld a, [bc] ; $72d2
	ld a, $00 ; $72d3
	rst Rst18 ; $72d5
	ld [hl], $0a ; $72d6
	push af ; $72d8
	ld a, $1e ; $72d9
	rst Rst18 ; $72db
	inc b ; $72dc
	ld a, [bc] ; $72dd
	pop af ; $72de
	ld a, $00 ; $72df
	ld bc, $2100 ; $72e1
	ld de, $3400 ; $72e4
	rst Rst18 ; $72e7
	inc h ; $72e8
	ld a, [bc] ; $72e9
	ld a, $00 ; $72ea
	rst Rst18 ; $72ec
	jr nz, Label_10_72f9 ; $72ed
	ld a, $00 ; $72ef
	ld bc, $2100 ; $72f1
	ld de, $3700 ; $72f4
	rst Rst18 ; $72f7
	inc h ; $72f8
Label_10_72f9:
	ld a, [bc] ; $72f9
	ld a, $00 ; $72fa
	rst Rst18 ; $72fc
	jr nz, Label_10_7309 ; $72fd
	call Func_10_7339 ; $72ff
	ldh a, [$ff95] ; $7302
	ld b, a ; $7304
	ld a, $00 ; $7305
	INCBIN "data/bank_010/d_7307.bin" ; $7307, 2 bytes
Label_10_7309:
	ld [hl], h ; $7309
	rst Rst18 ; $730a
	ld a, [de] ; $730b
	ld a, [bc] ; $730c
	push af ; $730d
	ld a, $14 ; $730e
	rst Rst18 ; $7310
	inc b ; $7311
	ld a, [bc] ; $7312
	pop af ; $7313
Label_10_7314:
	call Func_10_736f ; $7314
	push af ; $7317
	ld a, $3c ; $7318
	rst Rst18 ; $731a
	inc b ; $731b
	ld a, [bc] ; $731c
	pop af ; $731d
	ld c, $02 ; $731e
	call Func_00_1d20 ; $7320
	call Func_00_1da4 ; $7323
	ld a, $14 ; $7326
	ld [wStoryModeCurrentLocation], a ; $7328
	ld a, $0c ; $732b
	ld [$c295], a ; $732d
	ld a, $ff ; $7330
	ld [$c294], a ; $7332
	ld [$c2a1], a ; $7335
	ret ; $7338
Func_10_7339:
	push af ; $7339
	ld a, $0a ; $733a
	rst Rst18 ; $733c
	inc b ; $733d
	ld a, [bc] ; $733e
	pop af ; $733f
	rst Rst08 ; $7340
	ld a, c ; $7341
	ld b, $07 ; $7342
	ld c, $38 ; $7344
	ld d, $20 ; $7346
	ld e, $38 ; $7348
	ld h, $02 ; $734a
	ld l, $02 ; $734c
	rst Rst18 ; $734e
	ld a, [hl] ; $734f
	ld a, [bc] ; $7350
	push af ; $7351
	ld a, $02 ; $7352
	rst Rst18 ; $7354
	inc b ; $7355
	ld a, [bc] ; $7356
	pop af ; $7357
	ld b, $0b ; $7358
	ld c, $38 ; $735a
	ld d, $20 ; $735c
	ld e, $38 ; $735e
	ld h, $02 ; $7360
	ld l, $02 ; $7362
	rst Rst18 ; $7364
	ld a, [hl] ; $7365
	ld a, [bc] ; $7366
	push af ; $7367
	ld a, $04 ; $7368
	rst Rst18 ; $736a
	inc b ; $736b
	ld a, [bc] ; $736c
	pop af ; $736d
	ret ; $736e
Func_10_736f:
	rst Rst08 ; $736f
	ld a, c ; $7370
	ld b, $07 ; $7371
	ld c, $38 ; $7373
	ld d, $20 ; $7375
	ld e, $38 ; $7377
	ld h, $02 ; $7379
	ld l, $02 ; $737b
	rst Rst18 ; $737d
	ld a, [hl] ; $737e
	ld a, [bc] ; $737f
	push af ; $7380
	ld a, $02 ; $7381
	rst Rst18 ; $7383
	inc b ; $7384
	ld a, [bc] ; $7385
	pop af ; $7386
	ld b, $03 ; $7387
	ld c, $38 ; $7389
	ld d, $20 ; $738b
	ld e, $38 ; $738d
	ld h, $02 ; $738f
	ld l, $02 ; $7391
	rst Rst18 ; $7393
	ld a, [hl] ; $7394
	ld a, [bc] ; $7395
	push af ; $7396
	ld a, $04 ; $7397
	rst Rst18 ; $7399
	inc b ; $739a
	ld a, [bc] ; $739b
	pop af ; $739c
	ret ; $739d
	INCBIN "data/bank_010/d_739e.bin" ; $739e, 80 bytes
Func_10_73ee:
	rst Rst30 ; $73ee
	ldh [rTIMA], a ; $73ef
	jr z, Label_10_73fc ; $73f1
	rst Rst18 ; $73f3
	INCBIN "data/bank_010/d_73f4.bin" ; $73f4, 8 bytes
Label_10_73fc:
	ld a, $03 ; $73fc
	rst Rst18 ; $73fe
	ld [$df0a], sp ; $73ff
	INCBIN "data/bank_010/d_7402.bin" ; $7402, 3 bytes
Func_10_7405:
	rst Rst30 ; $7405
	ldh [rTIMA], a ; $7406
	jr z, Label_10_7413 ; $7408
	rst Rst18 ; $740a
	INCBIN "data/bank_010/d_740b.bin" ; $740b, 8 bytes
Label_10_7413:
	ld a, $03 ; $7413
	rst Rst18 ; $7415
	ld a, [bc] ; $7416
	ld a, [bc] ; $7417
	rst Rst18 ; $7418
	INCBIN "data/bank_010/d_7419.bin" ; $7419, 766 bytes
	call Func_10_7dbd ; $7717
	ld a, [$c2b0] ; $771a
	sra a ; $771d
	cp a, $02 ; $771f
	jr nz, Label_10_772e ; $7721
	ldh a, [$ff95] ; $7723
	ld b, a ; $7725
	ld a, $03 ; $7726
	ld de, $7b8b ; $7728
	rst Rst18 ; $772b
	ld a, [de] ; $772c
	ld a, [bc] ; $772d
Label_10_772e:
	ld a, $01 ; $772e
	ld hl, $79d0 ; $7730
	call Func_00_1b6a ; $7733
	ld a, [$c295] ; $7736
	cp a, $0f ; $7739
	jr nz, Label_10_7740 ; $773b
	call Func_10_7741 ; $773d
Label_10_7740:
	ret ; $7740
Func_10_7741:
	ldh a, [$ff95] ; $7741
	ld hl, $7980 ; $7743
	rst Rst18 ; $7746
	ld b, $0a ; $7747
	rst Rst18 ; $7749
	nop ; $774a
	ld a, [bc] ; $774b
	ld a, $00 ; $774c
	ld bc, $2200 ; $774e
	ld de, $2580 ; $7751
	rst Rst18 ; $7754
	ld [hl+], a ; $7755
	ld a, [bc] ; $7756
	ld a, $03 ; $7757
	ld bc, $2200 ; $7759
	ld de, $2400 ; $775c
	rst Rst18 ; $775f
	ld [hl+], a ; $7760
	ld a, [bc] ; $7761
	ld c, $04 ; $7762
	call Func_00_1d2e ; $7764
	push af ; $7767
	ld a, $1e ; $7768
	rst Rst18 ; $776a
	inc b ; $776b
	ld a, [bc] ; $776c
	pop af ; $776d
	ld a, $03 ; $776e
	ld b, $c0 ; $7770
	rst Rst18 ; $7772
	ld l, $0a ; $7773
	push af ; $7775
	ld a, $0a ; $7776
	rst Rst18 ; $7778
	inc b ; $7779
	ld a, [bc] ; $777a
	pop af ; $777b
	ld a, $04 ; $777c
	ld d, $02 ; $777e
	rst Rst18 ; $7780
	inc [hl] ; $7781
	ld a, [bc] ; $7782
	push af ; $7783
	ld a, $1e ; $7784
	rst Rst18 ; $7786
	inc b ; $7787
	ld a, [bc] ; $7788
	pop af ; $7789
	ld a, $03 ; $778a
	ld bc, $2200 ; $778c
	ld de, $1700 ; $778f
	rst Rst18 ; $7792
	inc h ; $7793
	ld a, [bc] ; $7794
	xor a, a ; $7795
	ld bc, $2200 ; $7796
	ld de, $1700 ; $7799
	rst Rst18 ; $779c
	ld a, [hl-] ; $779d
	ld a, [bc] ; $779e
	push af ; $779f
	ld a, $0a ; $77a0
	rst Rst18 ; $77a2
	inc b ; $77a3
	ld a, [bc] ; $77a4
	pop af ; $77a5
	ld a, $00 ; $77a6
	ld bc, $2200 ; $77a8
	ld de, $1900 ; $77ab
	rst Rst18 ; $77ae
	inc h ; $77af
	ld a, [bc] ; $77b0
	ld a, $04 ; $77b1
	ld b, $00 ; $77b3
	rst Rst18 ; $77b5
	ld l, $0a ; $77b6
	rst Rst18 ; $77b8
	ld a, $0a ; $77b9
	ld hl, $01ae ; $77bb
	rst Rst18 ; $77be
	ld c, $0a ; $77bf
	ld a, $04 ; $77c1
	rst Rst18 ; $77c3
	INCBIN "data/bank_010/d_77c4.bin" ; $77c4, 2 bytes
	ld a, $03 ; $77c6
	rst Rst18 ; $77c8
	jr nz, $77d5 ; $77c9
	push af ; $77cb
	ld a, $0a ; $77cc
	rst Rst18 ; $77ce
	inc b ; $77cf
	ld a, [bc] ; $77d0
	pop af ; $77d1
	xor a, a ; $77d2
	ld bc, $1d00 ; $77d3
	ld de, $1900 ; $77d6
	rst Rst18 ; $77d9
	ld a, [hl-] ; $77da
	ld a, [bc] ; $77db
	ld a, $04 ; $77dc
	ld b, a ; $77de
	ld a, $03 ; $77df
	rst Rst18 ; $77e1
	jr nc, Label_10_77ee ; $77e2
	push af ; $77e4
	ld a, $1e ; $77e5
	rst Rst18 ; $77e7
	inc b ; $77e8
	ld a, [bc] ; $77e9
	pop af ; $77ea
	ld a, $04 ; $77eb
	ld b, a ; $77ed
Label_10_77ee:
	ld a, $00 ; $77ee
	rst Rst18 ; $77f0
	jr nc, Label_10_77fd ; $77f1
	push af ; $77f3
	ld a, $1e ; $77f4
	rst Rst18 ; $77f6
	inc b ; $77f7
	ld a, [bc] ; $77f8
	pop af ; $77f9
	rst Rst18 ; $77fa
	ld a, $0a ; $77fb
Label_10_77fd:
	ld a, $04 ; $77fd
	ld d, $03 ; $77ff
	rst Rst18 ; $7801
	inc [hl] ; $7802
	ld a, [bc] ; $7803
	ld a, $04 ; $7804
	rst Rst18 ; $7806
	ld [hl], $0a ; $7807
	ld a, $04 ; $7809
	rst Rst18 ; $780b
	INCBIN "data/bank_010/d_780c.bin" ; $780c, 2 bytes
	push af ; $780e
	ld a, $0a ; $780f
	rst Rst18 ; $7811
	inc b ; $7812
	ld a, [bc] ; $7813
	pop af ; $7814
	ld a, $03 ; $7815
	ld d, $03 ; $7817
	rst Rst18 ; $7819
	inc [hl] ; $781a
	ld a, [bc] ; $781b
	ld a, $03 ; $781c
	rst Rst18 ; $781e
	ld [hl], $0a ; $781f
	ld a, $03 ; $7821
	rst Rst18 ; $7823
	INCBIN "data/bank_010/d_7824.bin" ; $7824, 2 bytes
	ld a, $00 ; $7826
	ld b, a ; $7828
	ld a, $03 ; $7829
	rst Rst18 ; $782b
	jr nc, Label_10_7838 ; $782c
	push af ; $782e
	ld a, $32 ; $782f
	rst Rst18 ; $7831
	inc b ; $7832
	ld a, [bc] ; $7833
	pop af ; $7834
	ld a, $04 ; $7835
	ld b, a ; $7837
Label_10_7838:
	ld a, $03 ; $7838
	rst Rst18 ; $783a
	jr nc, Label_10_7847 ; $783b
	push af ; $783d
	ld a, $1e ; $783e
	rst Rst18 ; $7840
	inc b ; $7841
	ld a, [bc] ; $7842
	pop af ; $7843
	ld a, [$c90d] ; $7844
Label_10_7847:
	or a, a ; $7847
	jr z, Label_10_784d ; $7848
	rst Rst18 ; $784a
	INCBIN "data/bank_010/d_784b.bin" ; $784b, 2 bytes
Label_10_784d:
	ld a, $03 ; $784d
	rst Rst18 ; $784f
	INCBIN "data/bank_010/d_7850.bin" ; $7850, 2 bytes
	ld a, [$c90d] ; $7852
	or a, a ; $7855
	jr nz, Label_10_785b ; $7856
	rst Rst18 ; $7858
	INCBIN "data/bank_010/d_7859.bin" ; $7859, 2 bytes
Label_10_785b:
	push af ; $785b
	ld a, $0f ; $785c
	rst Rst18 ; $785e
	inc b ; $785f
	ld a, [bc] ; $7860
	pop af ; $7861
	ld a, $04 ; $7862
	ld d, $03 ; $7864
	rst Rst18 ; $7866
	inc [hl] ; $7867
	ld a, [bc] ; $7868
	ld a, $04 ; $7869
	rst Rst18 ; $786b
	ld [hl], $0a ; $786c
	ld a, $04 ; $786e
	rst Rst18 ; $7870
	INCBIN "data/bank_010/d_7871.bin" ; $7871, 2 bytes
	push af ; $7873
	ld a, $0f ; $7874
	rst Rst18 ; $7876
	inc b ; $7877
	ld a, [bc] ; $7878
	pop af ; $7879
	ld a, $00 ; $787a
	ld d, $03 ; $787c
	rst Rst18 ; $787e
	inc [hl] ; $787f
	ld a, [bc] ; $7880
	ld a, $00 ; $7881
	rst Rst18 ; $7883
	ld [hl], $0a ; $7884
	push af ; $7886
	ld a, $0f ; $7887
	rst Rst18 ; $7889
	inc b ; $788a
	ld a, [bc] ; $788b
	pop af ; $788c
	ld a, $04 ; $788d
	ld d, $03 ; $788f
	rst Rst18 ; $7891
	inc [hl] ; $7892
	ld a, [bc] ; $7893
	ld a, $04 ; $7894
	rst Rst18 ; $7896
	ld [hl], $0a ; $7897
	ld a, $04 ; $7899
	rst Rst18 ; $789b
	INCBIN "data/bank_010/d_789c.bin" ; $789c, 2 bytes
	push af ; $789e
	ld a, $0f ; $789f
	rst Rst18 ; $78a1
	inc b ; $78a2
	ld a, [bc] ; $78a3
	pop af ; $78a4
	ld a, $03 ; $78a5
	ld d, $02 ; $78a7
	rst Rst18 ; $78a9
	inc [hl] ; $78aa
	ld a, [bc] ; $78ab
	ld a, $03 ; $78ac
	rst Rst18 ; $78ae
	ld [hl], $0a ; $78af
	ld a, $03 ; $78b1
	rst Rst18 ; $78b3
	INCBIN "data/bank_010/d_78b4.bin" ; $78b4, 2 bytes
	ld a, $03 ; $78b6
	ld b, a ; $78b8
	ld a, $00 ; $78b9
	rst Rst18 ; $78bb
	jr nc, Label_10_78c8 ; $78bc
	ld a, $06 ; $78be
	ld bc, $2300 ; $78c0
	ld de, $1700 ; $78c3
	rst Rst18 ; $78c6
	ld [hl+], a ; $78c7
Label_10_78c8:
	ld a, [bc] ; $78c8
	rst Rst08 ; $78c9
	sbc a, b ; $78ca
	push af ; $78cb
	ld a, $3c ; $78cc
	rst Rst18 ; $78ce
	inc b ; $78cf
	ld a, [bc] ; $78d0
	pop af ; $78d1
	ld a, $06 ; $78d2
	ld bc, $3f00 ; $78d4
	ld de, $3f00 ; $78d7
	rst Rst18 ; $78da
	ld [hl+], a ; $78db
	ld a, [bc] ; $78dc
	ld a, $04 ; $78dd
	ld d, $03 ; $78df
	rst Rst18 ; $78e1
	inc [hl] ; $78e2
	ld a, [bc] ; $78e3
	ld a, $04 ; $78e4
	rst Rst18 ; $78e6
	ld [hl], $0a ; $78e7
	ld a, $04 ; $78e9
	rst Rst18 ; $78eb
	INCBIN "data/bank_010/d_78ec.bin" ; $78ec, 2 bytes
	ld a, $00 ; $78ee
	ld d, $02 ; $78f0
	rst Rst18 ; $78f2
	inc [hl] ; $78f3
	ld a, [bc] ; $78f4
	ld a, $00 ; $78f5
	rst Rst18 ; $78f7
	ld [hl], $0a ; $78f8
	push af ; $78fa
	ld a, $0a ; $78fb
	rst Rst18 ; $78fd
	inc b ; $78fe
	ld a, [bc] ; $78ff
	pop af ; $7900
	ld a, $04 ; $7901
	ld b, a ; $7903
	ld a, $00 ; $7904
	rst Rst18 ; $7906
	jr nc, Label_10_7913 ; $7907
	ld a, $00 ; $7909
	ld d, $03 ; $790b
	rst Rst18 ; $790d
	inc [hl] ; $790e
	ld a, [bc] ; $790f
	ld a, $00 ; $7910
	rst Rst18 ; $7912
Label_10_7913:
	ld [hl], $0a ; $7913
	push af ; $7915
	ld a, $0f ; $7916
	rst Rst18 ; $7918
	inc b ; $7919
	ld a, [bc] ; $791a
	pop af ; $791b
	ld a, $04 ; $791c
	ld b, a ; $791e
	ld a, $03 ; $791f
	rst Rst18 ; $7921
	ld [hl-], a ; $7922
	ld a, [bc] ; $7923
	ld a, $03 ; $7924
	ld d, $03 ; $7926
	rst Rst18 ; $7928
	inc [hl] ; $7929
	ld a, [bc] ; $792a
	ld a, $04 ; $792b
	ld d, $03 ; $792d
	rst Rst18 ; $792f
	inc [hl] ; $7930
	ld a, [bc] ; $7931
	ld a, $04 ; $7932
	rst Rst18 ; $7934
	ld [hl], $0a ; $7935
	xor a, a ; $7937
	ld bc, $2200 ; $7938
	ld de, $1700 ; $793b
	rst Rst18 ; $793e
	ld a, [hl-] ; $793f
	ld a, [bc] ; $7940
	push af ; $7941
	ld a, $28 ; $7942
	rst Rst18 ; $7944
	inc b ; $7945
	ld a, [bc] ; $7946
	pop af ; $7947
	ld a, $03 ; $7948
	ld bc, $2200 ; $794a
	ld de, $0300 ; $794d
	rst Rst18 ; $7950
	inc h ; $7951
	ld a, [bc] ; $7952
	push af ; $7953
	ld a, $0a ; $7954
	rst Rst18 ; $7956
	inc b ; $7957
	ld a, [bc] ; $7958
	pop af ; $7959
	xor a, a ; $795a
	ld bc, $2200 ; $795b
	ld de, $0300 ; $795e
	rst Rst18 ; $7961
	ld a, [hl-] ; $7962
	ld a, [bc] ; $7963
	ld a, $00 ; $7964
	ld bc, $2200 ; $7966
	ld de, $0300 ; $7969
	rst Rst18 ; $796c
	inc h ; $796d
	ld a, [bc] ; $796e
	ld a, $00 ; $796f
	rst Rst18 ; $7971
	jr nz, Label_10_797e ; $7972
	ld a, $0f ; $7974
	ld [$c294], a ; $7976
	ld [$c2a1], a ; $7979
	rst Rst18 ; $797c
	ld [bc], a ; $797d
Label_10_797e:
	ld a, [bc] ; $797e
	ret ; $797f
	INCBIN "data/bank_010/d_7980.bin" ; $7980, 80 bytes
	ld a, $00 ; $79d0
	call Func_10_79df ; $79d2
	rst Rst30 ; $79d5
	ldh [rTIMA], a ; $79d6
	ret z ; $79d8
	ld a, $02 ; $79d9
	call Func_10_79df ; $79db
	ret ; $79de
Func_10_79df:
	ld h, a ; $79df
	ld l, $00 ; $79e0
	push af ; $79e2
	ld a, $04 ; $79e3
	ldh [$ff96], a ; $79e5
	ldh [rWBK], a ; $79e7
	srl h ; $79e9
	rr l ; $79eb
	srl h ; $79ed
	rr l ; $79ef
	ld bc, $d000 ; $79f1
	add hl, bc ; $79f4
	ld b, h ; $79f5
	ld c, l ; $79f6
	ld hl, $000c ; $79f7
	add hl, bc ; $79fa
	ld a, [hl+] ; $79fb
	ld h, [hl] ; $79fc
	ld l, a ; $79fd
	ld de, $ffb0 ; $79fe
	add hl, de ; $7a01
	ld d, h ; $7a02
	ld hl, $000e ; $7a03
	add hl, bc ; $7a06
	ld a, [hl+] ; $7a07
	add a, $40 ; $7a08
	ld a, [hl] ; $7a0a
	adc a, $00 ; $7a0b
	ld e, a ; $7a0d
	dec e ; $7a0e
	pop af ; $7a0f
	or a, a ; $7a10
	jr z, Label_10_7a15 ; $7a11
	dec e ; $7a13
	dec e ; $7a14
Label_10_7a15:
	push de ; $7a15
	call Func_10_7ac8 ; $7a16
	pop de ; $7a19
	and a, $87 ; $7a1a
	cp a, $06 ; $7a1c
	jr nz, Label_10_7a2f ; $7a1e
	ld a, $04 ; $7a20
	ldh [$ff96], a ; $7a22
	ldh [rWBK], a ; $7a24
	ld hl, $0020 ; $7a26
	add hl, bc ; $7a29
	ld a, [hl] ; $7a2a
	xor a, $01 ; $7a2b
	ld [hl], a ; $7a2d
	ret ; $7a2e
Label_10_7a2f:
	inc d ; $7a2f
	call Func_10_7ac8 ; $7a30
	and a, $07 ; $7a33
	cp a, $06 ; $7a35
	jr nz, Label_10_7a48 ; $7a37
	ld a, $04 ; $7a39
	ldh [$ff96], a ; $7a3b
	ldh [rWBK], a ; $7a3d
	ld hl, $0020 ; $7a3f
	add hl, bc ; $7a42
	ld a, [hl] ; $7a43
	xor a, $01 ; $7a44
	ld [hl], a ; $7a46
	ret ; $7a47
Label_10_7a48:
	ld a, $04 ; $7a48
	ldh [$ff96], a ; $7a4a
	ldh [rWBK], a ; $7a4c
	ld hl, $0020 ; $7a4e
	add hl, bc ; $7a51
	ld a, $02 ; $7a52
	ld [hl], a ; $7a54
	ret ; $7a55
	INCBIN "data/bank_010/d_7a56.bin" ; $7a56, 114 bytes
Func_10_7ac8:
	ld a, $02 ; $7ac8
	ldh [$ff96], a ; $7aca
	ldh [rWBK], a ; $7acc
	ld h, e ; $7ace
	ld l, $00 ; $7acf
	srl h ; $7ad1
	rr l ; $7ad3
	srl h ; $7ad5
	rr l ; $7ad7
	ld a, d ; $7ad9
	add a, l ; $7ada
	ld l, a ; $7adb
	jr nc, Label_10_7adf ; $7adc
	inc h ; $7ade
Label_10_7adf:
	ld d, h ; $7adf
	ld e, l ; $7ae0
	ld l, c ; $7ae1
	ld h, b ; $7ae2
	add hl, de ; $7ae3
	ld a, [hl] ; $7ae4
	ret ; $7ae5
	INCBIN "data/bank_010/d_7ae6.bin" ; $7ae6, 133 bytes
	rst Rst18 ; $7b6b
	jr Label_10_7b78 ; $7b6c
	INCBIN "data/bank_010/d_7b6e.bin" ; $7b6e, 10 bytes
Label_10_7b78:
	ld b, $40 ; $7b78
	ld de, $0280 ; $7b7a
	rst Rst18 ; $7b7d
	ld a, [hl+] ; $7b7e
	ld a, [bc] ; $7b7f
	ld a, $02 ; $7b80
	ld b, $40 ; $7b82
	ld de, $0200 ; $7b84
	rst Rst18 ; $7b87
	ld a, [hl+] ; $7b88
	ld a, [bc] ; $7b89
	ret ; $7b8a
	INCBIN "data/bank_010/d_7b8b.bin" ; $7b8b, 110 bytes
	ret ; $7bf9
	INCBIN "data/bank_010/d_7bfa.bin" ; $7bfa, 451 bytes
Func_10_7dbd:
	rst Rst30 ; $7dbd
	ldh [rTIMA], a ; $7dbe
	jr nz, Label_10_7de4 ; $7dc0
	ld a, $00 ; $7dc2
	rst Rst30 ; $7dc4
	ld h, b ; $7dc5
	ld a, [bc] ; $7dc6
	jr z, Label_10_7de0 ; $7dc7
	ld a, $02 ; $7dc9
	rst Rst30 ; $7dcb
	ldh [$ff0a], a ; $7dcc
	jr z, Label_10_7de0 ; $7dce
	ld a, $04 ; $7dd0
	rst Rst30 ; $7dd2
	ret nz ; $7dd3
	dec d ; $7dd4
	jr z, Label_10_7de0 ; $7dd5
	ld a, $06 ; $7dd7
	rst Rst30 ; $7dd9
	nop ; $7dda
	ld d, $28 ; $7ddb
	ld [bc], a ; $7ddd
	ld a, $08 ; $7dde
Label_10_7de0:
	ld [$c2b0], a ; $7de0
	ret ; $7de3
Label_10_7de4:
	ld a, $01 ; $7de4
	rst Rst30 ; $7de6
	ld b, b ; $7de7
	ld [$f528], sp ; $7de8
	ld a, $03 ; $7deb
	rst Rst30 ; $7ded
	ret nz ; $7dee
	ld [$ee28], sp ; $7def
	ld a, $05 ; $7df2
	rst Rst30 ; $7df4
	ldh [$ff15], a ; $7df5
	jr z, Label_10_7de0 ; $7df7
	ld a, $07 ; $7df9
	rst Rst30 ; $7dfb
	jr nz, Label_10_7e14 ; $7dfc
	jr z, Label_10_7de0 ; $7dfe
	ld a, $09 ; $7e00
	jr Label_10_7de0 ; $7e02
	INCBIN "data/bank_010/d_7e04.bin" ; $7e04, 16 bytes
Label_10_7e14:
	dec b ; $7e14
	jr nz, Label_10_7e27 ; $7e15
	rst Rst30 ; $7e17
	ret nz ; $7e18
	dec d ; $7e19
	jr z, Label_10_7e23 ; $7e1a
	inc a ; $7e1c
	rst Rst30 ; $7e1d
	nop ; $7e1e
	ld d, $28 ; $7e1f
	INCBIN "data/bank_010/d_7e21.bin" ; $7e21, 2 bytes
Label_10_7e23:
	ld [$c2b0], a ; $7e23
	ret ; $7e26
Label_10_7e27:
	rst Rst30 ; $7e27
	ldh [$ff15], a ; $7e28
	jr z, Label_10_7e23 ; $7e2a
	inc a ; $7e2c
	rst Rst30 ; $7e2d
	jr nz, Label_10_7e46 ; $7e2e
	jr z, Label_10_7e23 ; $7e30
	inc a ; $7e32
	jr Label_10_7e23 ; $7e33
	INCBIN "data/bank_010/d_7e35.bin" ; $7e35, 17 bytes
Label_10_7e46:
	rst Rst38 ; $7e46
	rst Rst38 ; $7e47
	rst Rst38 ; $7e48
	rst Rst38 ; $7e49
	rst Rst38 ; $7e4a
	rst Rst38 ; $7e4b
	rst Rst38 ; $7e4c
	rst Rst38 ; $7e4d
	rst Rst38 ; $7e4e
	rst Rst38 ; $7e4f
	rst Rst38 ; $7e50
	rst Rst38 ; $7e51
	rst Rst38 ; $7e52
	rst Rst38 ; $7e53
	rst Rst38 ; $7e54
	rst Rst38 ; $7e55
	rst Rst38 ; $7e56
	rst Rst38 ; $7e57
	rst Rst38 ; $7e58
	rst Rst38 ; $7e59
	rst Rst38 ; $7e5a
	rst Rst38 ; $7e5b
	rst Rst38 ; $7e5c
	rst Rst38 ; $7e5d
	rst Rst38 ; $7e5e
	rst Rst38 ; $7e5f
	rst Rst38 ; $7e60
	rst Rst38 ; $7e61
	rst Rst38 ; $7e62
	rst Rst38 ; $7e63
	rst Rst38 ; $7e64
	rst Rst38 ; $7e65
	rst Rst38 ; $7e66
	rst Rst38 ; $7e67
	rst Rst38 ; $7e68
	rst Rst38 ; $7e69
	rst Rst38 ; $7e6a
	rst Rst38 ; $7e6b
	rst Rst38 ; $7e6c
	rst Rst38 ; $7e6d
	rst Rst38 ; $7e6e
	rst Rst38 ; $7e6f
	rst Rst38 ; $7e70
	rst Rst38 ; $7e71
	rst Rst38 ; $7e72
	rst Rst38 ; $7e73
	rst Rst38 ; $7e74
	rst Rst38 ; $7e75
	rst Rst38 ; $7e76
	rst Rst38 ; $7e77
	rst Rst38 ; $7e78
	rst Rst38 ; $7e79
	rst Rst38 ; $7e7a
	rst Rst38 ; $7e7b
	rst Rst38 ; $7e7c
	rst Rst38 ; $7e7d
	rst Rst38 ; $7e7e
	rst Rst38 ; $7e7f
	rst Rst38 ; $7e80
	rst Rst38 ; $7e81
	rst Rst38 ; $7e82
	rst Rst38 ; $7e83
	rst Rst38 ; $7e84
	rst Rst38 ; $7e85
	rst Rst38 ; $7e86
	rst Rst38 ; $7e87
	rst Rst38 ; $7e88
	rst Rst38 ; $7e89
	rst Rst38 ; $7e8a
	rst Rst38 ; $7e8b
	rst Rst38 ; $7e8c
	rst Rst38 ; $7e8d
	rst Rst38 ; $7e8e
	rst Rst38 ; $7e8f
	rst Rst38 ; $7e90
	rst Rst38 ; $7e91
	rst Rst38 ; $7e92
	rst Rst38 ; $7e93
	rst Rst38 ; $7e94
	rst Rst38 ; $7e95
	rst Rst38 ; $7e96
	rst Rst38 ; $7e97
	rst Rst38 ; $7e98
	rst Rst38 ; $7e99
	rst Rst38 ; $7e9a
	rst Rst38 ; $7e9b
	rst Rst38 ; $7e9c
	rst Rst38 ; $7e9d
	rst Rst38 ; $7e9e
	rst Rst38 ; $7e9f
	rst Rst38 ; $7ea0
	rst Rst38 ; $7ea1
	rst Rst38 ; $7ea2
	rst Rst38 ; $7ea3
	rst Rst38 ; $7ea4
	rst Rst38 ; $7ea5
	rst Rst38 ; $7ea6
	rst Rst38 ; $7ea7
	rst Rst38 ; $7ea8
	rst Rst38 ; $7ea9
	rst Rst38 ; $7eaa
	rst Rst38 ; $7eab
	rst Rst38 ; $7eac
	rst Rst38 ; $7ead
	rst Rst38 ; $7eae
	rst Rst38 ; $7eaf
	rst Rst38 ; $7eb0
	rst Rst38 ; $7eb1
	rst Rst38 ; $7eb2
	rst Rst38 ; $7eb3
	rst Rst38 ; $7eb4
	rst Rst38 ; $7eb5
	rst Rst38 ; $7eb6
	rst Rst38 ; $7eb7
	rst Rst38 ; $7eb8
	rst Rst38 ; $7eb9
	rst Rst38 ; $7eba
	rst Rst38 ; $7ebb
	rst Rst38 ; $7ebc
	rst Rst38 ; $7ebd
	rst Rst38 ; $7ebe
	rst Rst38 ; $7ebf
	rst Rst38 ; $7ec0
	rst Rst38 ; $7ec1
	rst Rst38 ; $7ec2
	rst Rst38 ; $7ec3
	rst Rst38 ; $7ec4
	rst Rst38 ; $7ec5
	rst Rst38 ; $7ec6
	rst Rst38 ; $7ec7
	rst Rst38 ; $7ec8
	rst Rst38 ; $7ec9
	rst Rst38 ; $7eca
	rst Rst38 ; $7ecb
	rst Rst38 ; $7ecc
	rst Rst38 ; $7ecd
	rst Rst38 ; $7ece
	rst Rst38 ; $7ecf
	rst Rst38 ; $7ed0
	rst Rst38 ; $7ed1
	rst Rst38 ; $7ed2
	rst Rst38 ; $7ed3
	rst Rst38 ; $7ed4
	rst Rst38 ; $7ed5
	rst Rst38 ; $7ed6
	rst Rst38 ; $7ed7
	rst Rst38 ; $7ed8
	rst Rst38 ; $7ed9
	rst Rst38 ; $7eda
	rst Rst38 ; $7edb
	rst Rst38 ; $7edc
	rst Rst38 ; $7edd
	rst Rst38 ; $7ede
	rst Rst38 ; $7edf
	rst Rst38 ; $7ee0
	rst Rst38 ; $7ee1
	rst Rst38 ; $7ee2
	rst Rst38 ; $7ee3
	rst Rst38 ; $7ee4
	rst Rst38 ; $7ee5
	rst Rst38 ; $7ee6
	rst Rst38 ; $7ee7
	rst Rst38 ; $7ee8
	rst Rst38 ; $7ee9
	rst Rst38 ; $7eea
	rst Rst38 ; $7eeb
	rst Rst38 ; $7eec
	rst Rst38 ; $7eed
	rst Rst38 ; $7eee
	rst Rst38 ; $7eef
	rst Rst38 ; $7ef0
	rst Rst38 ; $7ef1
	rst Rst38 ; $7ef2
	rst Rst38 ; $7ef3
	rst Rst38 ; $7ef4
	rst Rst38 ; $7ef5
	rst Rst38 ; $7ef6
	rst Rst38 ; $7ef7
	rst Rst38 ; $7ef8
	rst Rst38 ; $7ef9
	rst Rst38 ; $7efa
	rst Rst38 ; $7efb
	rst Rst38 ; $7efc
	rst Rst38 ; $7efd
	rst Rst38 ; $7efe
	rst Rst38 ; $7eff
	rst Rst38 ; $7f00
	rst Rst38 ; $7f01
	rst Rst38 ; $7f02
	rst Rst38 ; $7f03
	rst Rst38 ; $7f04
	rst Rst38 ; $7f05
	rst Rst38 ; $7f06
	rst Rst38 ; $7f07
	rst Rst38 ; $7f08
	rst Rst38 ; $7f09
	rst Rst38 ; $7f0a
	rst Rst38 ; $7f0b
	rst Rst38 ; $7f0c
	rst Rst38 ; $7f0d
	rst Rst38 ; $7f0e
	rst Rst38 ; $7f0f
	rst Rst38 ; $7f10
	rst Rst38 ; $7f11
	rst Rst38 ; $7f12
	rst Rst38 ; $7f13
	rst Rst38 ; $7f14
	rst Rst38 ; $7f15
	rst Rst38 ; $7f16
	rst Rst38 ; $7f17
	rst Rst38 ; $7f18
	rst Rst38 ; $7f19
	rst Rst38 ; $7f1a
	rst Rst38 ; $7f1b
	rst Rst38 ; $7f1c
	rst Rst38 ; $7f1d
	rst Rst38 ; $7f1e
	rst Rst38 ; $7f1f
	rst Rst38 ; $7f20
	rst Rst38 ; $7f21
	rst Rst38 ; $7f22
	rst Rst38 ; $7f23
	rst Rst38 ; $7f24
	rst Rst38 ; $7f25
	rst Rst38 ; $7f26
	rst Rst38 ; $7f27
	rst Rst38 ; $7f28
	rst Rst38 ; $7f29
	rst Rst38 ; $7f2a
	rst Rst38 ; $7f2b
	rst Rst38 ; $7f2c
	rst Rst38 ; $7f2d
	rst Rst38 ; $7f2e
	rst Rst38 ; $7f2f
	rst Rst38 ; $7f30
	rst Rst38 ; $7f31
	rst Rst38 ; $7f32
	rst Rst38 ; $7f33
	rst Rst38 ; $7f34
	rst Rst38 ; $7f35
	rst Rst38 ; $7f36
	rst Rst38 ; $7f37
	rst Rst38 ; $7f38
	rst Rst38 ; $7f39
	rst Rst38 ; $7f3a
	rst Rst38 ; $7f3b
	rst Rst38 ; $7f3c
	rst Rst38 ; $7f3d
	rst Rst38 ; $7f3e
	rst Rst38 ; $7f3f
	rst Rst38 ; $7f40
	rst Rst38 ; $7f41
	rst Rst38 ; $7f42
	rst Rst38 ; $7f43
	rst Rst38 ; $7f44
	rst Rst38 ; $7f45
	rst Rst38 ; $7f46
	rst Rst38 ; $7f47
	rst Rst38 ; $7f48
	rst Rst38 ; $7f49
	rst Rst38 ; $7f4a
	rst Rst38 ; $7f4b
	rst Rst38 ; $7f4c
	rst Rst38 ; $7f4d
	rst Rst38 ; $7f4e
	rst Rst38 ; $7f4f
	rst Rst38 ; $7f50
	rst Rst38 ; $7f51
	rst Rst38 ; $7f52
	rst Rst38 ; $7f53
	rst Rst38 ; $7f54
	rst Rst38 ; $7f55
	rst Rst38 ; $7f56
	rst Rst38 ; $7f57
	rst Rst38 ; $7f58
	rst Rst38 ; $7f59
	rst Rst38 ; $7f5a
	rst Rst38 ; $7f5b
	rst Rst38 ; $7f5c
	rst Rst38 ; $7f5d
	rst Rst38 ; $7f5e
	rst Rst38 ; $7f5f
	rst Rst38 ; $7f60
	rst Rst38 ; $7f61
	rst Rst38 ; $7f62
	rst Rst38 ; $7f63
	rst Rst38 ; $7f64
	rst Rst38 ; $7f65
	rst Rst38 ; $7f66
	rst Rst38 ; $7f67
	rst Rst38 ; $7f68
	rst Rst38 ; $7f69
	rst Rst38 ; $7f6a
	rst Rst38 ; $7f6b
	rst Rst38 ; $7f6c
	rst Rst38 ; $7f6d
	rst Rst38 ; $7f6e
	rst Rst38 ; $7f6f
	rst Rst38 ; $7f70
	rst Rst38 ; $7f71
	rst Rst38 ; $7f72
	rst Rst38 ; $7f73
	rst Rst38 ; $7f74
	rst Rst38 ; $7f75
	rst Rst38 ; $7f76
	rst Rst38 ; $7f77
	rst Rst38 ; $7f78
	rst Rst38 ; $7f79
	rst Rst38 ; $7f7a
	rst Rst38 ; $7f7b
	rst Rst38 ; $7f7c
	rst Rst38 ; $7f7d
	rst Rst38 ; $7f7e
	rst Rst38 ; $7f7f
	rst Rst38 ; $7f80
	rst Rst38 ; $7f81
	rst Rst38 ; $7f82
	rst Rst38 ; $7f83
	rst Rst38 ; $7f84
	rst Rst38 ; $7f85
	rst Rst38 ; $7f86
	rst Rst38 ; $7f87
	rst Rst38 ; $7f88
	rst Rst38 ; $7f89
	rst Rst38 ; $7f8a
	rst Rst38 ; $7f8b
	rst Rst38 ; $7f8c
	rst Rst38 ; $7f8d
	rst Rst38 ; $7f8e
	rst Rst38 ; $7f8f
	rst Rst38 ; $7f90
	rst Rst38 ; $7f91
	rst Rst38 ; $7f92
	rst Rst38 ; $7f93
	rst Rst38 ; $7f94
	rst Rst38 ; $7f95
	rst Rst38 ; $7f96
	rst Rst38 ; $7f97
	rst Rst38 ; $7f98
	rst Rst38 ; $7f99
	rst Rst38 ; $7f9a
	rst Rst38 ; $7f9b
	rst Rst38 ; $7f9c
	rst Rst38 ; $7f9d
	rst Rst38 ; $7f9e
	rst Rst38 ; $7f9f
	rst Rst38 ; $7fa0
	rst Rst38 ; $7fa1
	rst Rst38 ; $7fa2
	rst Rst38 ; $7fa3
	rst Rst38 ; $7fa4
	rst Rst38 ; $7fa5
	rst Rst38 ; $7fa6
	rst Rst38 ; $7fa7
	rst Rst38 ; $7fa8
	rst Rst38 ; $7fa9
	rst Rst38 ; $7faa
	rst Rst38 ; $7fab
	rst Rst38 ; $7fac
	rst Rst38 ; $7fad
	rst Rst38 ; $7fae
	rst Rst38 ; $7faf
	rst Rst38 ; $7fb0
	rst Rst38 ; $7fb1
	rst Rst38 ; $7fb2
	rst Rst38 ; $7fb3
	rst Rst38 ; $7fb4
	rst Rst38 ; $7fb5
	rst Rst38 ; $7fb6
	rst Rst38 ; $7fb7
	rst Rst38 ; $7fb8
	rst Rst38 ; $7fb9
	rst Rst38 ; $7fba
	rst Rst38 ; $7fbb
	rst Rst38 ; $7fbc
	rst Rst38 ; $7fbd
	rst Rst38 ; $7fbe
	rst Rst38 ; $7fbf
	rst Rst38 ; $7fc0
	rst Rst38 ; $7fc1
	rst Rst38 ; $7fc2
	rst Rst38 ; $7fc3
	rst Rst38 ; $7fc4
	rst Rst38 ; $7fc5
	rst Rst38 ; $7fc6
	rst Rst38 ; $7fc7
	rst Rst38 ; $7fc8
	rst Rst38 ; $7fc9
	rst Rst38 ; $7fca
	rst Rst38 ; $7fcb
	rst Rst38 ; $7fcc
	rst Rst38 ; $7fcd
	rst Rst38 ; $7fce
	rst Rst38 ; $7fcf
	rst Rst38 ; $7fd0
	rst Rst38 ; $7fd1
	rst Rst38 ; $7fd2
	rst Rst38 ; $7fd3
	rst Rst38 ; $7fd4
	rst Rst38 ; $7fd5
	rst Rst38 ; $7fd6
	rst Rst38 ; $7fd7
	rst Rst38 ; $7fd8
	rst Rst38 ; $7fd9
	rst Rst38 ; $7fda
	rst Rst38 ; $7fdb
	rst Rst38 ; $7fdc
	rst Rst38 ; $7fdd
	rst Rst38 ; $7fde
	rst Rst38 ; $7fdf
	rst Rst38 ; $7fe0
	rst Rst38 ; $7fe1
	rst Rst38 ; $7fe2
	rst Rst38 ; $7fe3
	rst Rst38 ; $7fe4
	rst Rst38 ; $7fe5
	rst Rst38 ; $7fe6
	rst Rst38 ; $7fe7
	rst Rst38 ; $7fe8
	rst Rst38 ; $7fe9
	rst Rst38 ; $7fea
	rst Rst38 ; $7feb
	rst Rst38 ; $7fec
	rst Rst38 ; $7fed
	rst Rst38 ; $7fee
	rst Rst38 ; $7fef
	rst Rst38 ; $7ff0
	rst Rst38 ; $7ff1
	rst Rst38 ; $7ff2
	rst Rst38 ; $7ff3
	rst Rst38 ; $7ff4
	rst Rst38 ; $7ff5
	rst Rst38 ; $7ff6
	rst Rst38 ; $7ff7
	rst Rst38 ; $7ff8
	rst Rst38 ; $7ff9
	rst Rst38 ; $7ffa
	rst Rst38 ; $7ffb
	rst Rst38 ; $7ffc
	rst Rst38 ; $7ffd
	rst Rst38 ; $7ffe
	rst Rst38 ; $7fff
