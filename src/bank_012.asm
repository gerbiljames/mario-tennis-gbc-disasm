INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $12", ROMX[$4000], BANK[$12]

	INCBIN "data/bank_012/d_4000.bin" ; $4000, 4534 bytes
	rst Rst18 ; $51b6
	ld [$c90a], sp ; $51b7
	ld a, $07 ; $51ba
	ld d, $03 ; $51bc
	rst Rst18 ; $51be
	inc [hl] ; $51bf
	ld a, [bc] ; $51c0
	ld a, $07 ; $51c1
	rst Rst18 ; $51c3
	ld [hl], $0a ; $51c4
	ld a, $07 ; $51c6
	rst Rst18 ; $51c8
	ld [$3e0a], sp ; $51c9
	rlca ; $51cc
	ld bc, $0300 ; $51cd
	ld de, $3700 ; $51d0
	rst Rst18 ; $51d3
	inc h ; $51d4
	ld a, [bc] ; $51d5
	ld a, $07 ; $51d6
	rst Rst18 ; $51d8
	jr nz, Label_12_51e5 ; $51d9
	ld a, $07 ; $51db
	ld b, $00 ; $51dd
	rst Rst18 ; $51df
	ld l, $0a ; $51e0
	rst Rst30 ; $51e2
	ldh [rTIMA], a ; $51e3
Label_12_51e5:
	jr z, Label_12_522c ; $51e5
	push af ; $51e7
	ld a, $14 ; $51e8
	rst Rst18 ; $51ea
	inc b ; $51eb
	ld a, [bc] ; $51ec
	pop af ; $51ed
	ld a, $02 ; $51ee
	rst Rst18 ; $51f0
	inc e ; $51f1
	ld a, [bc] ; $51f2
	ld a, $02 ; $51f3
	ld bc, $0700 ; $51f5
	ld de, $3900 ; $51f8
	rst Rst18 ; $51fb
	inc h ; $51fc
	ld a, [bc] ; $51fd
	ld a, $02 ; $51fe
	rst Rst18 ; $5200
	jr nz, Label_12_520d ; $5201
	ld a, $02 ; $5203
	ld b, a ; $5205
	ld a, $00 ; $5206
	rst Rst18 ; $5208
	ld [hl-], a ; $5209
	ld a, [bc] ; $520a
	push af ; $520b
	INCBIN "data/bank_012/d_520c.bin" ; $520c, 1 bytes
Label_12_520d:
	ld e, $df ; $520d
	inc b ; $520f
	ld a, [bc] ; $5210
	pop af ; $5211
	ld a, $00 ; $5212
	ld d, $03 ; $5214
	rst Rst18 ; $5216
	inc [hl] ; $5217
	ld a, [bc] ; $5218
	ld a, $02 ; $5219
	ld d, $03 ; $521b
	rst Rst18 ; $521d
	inc [hl] ; $521e
	ld a, [bc] ; $521f
	ld a, $02 ; $5220
	rst Rst18 ; $5222
	ld [hl], $0a ; $5223
	push af ; $5225
	ld a, $14 ; $5226
	rst Rst18 ; $5228
	inc b ; $5229
	ld a, [bc] ; $522a
	pop af ; $522b
Label_12_522c:
	ld a, $00 ; $522c
	ld bc, $0020 ; $522e
	rst Rst18 ; $5231
	jr Label_12_523e ; $5232
	INCBIN "data/bank_012/d_5234.bin" ; $5234, 10 bytes
Label_12_523e:
	ld a, [bc] ; $523e
	ld a, $00 ; $523f
	rst Rst18 ; $5241
	jr nz, Label_12_524e ; $5242
	ld a, $00 ; $5244
	ld bc, $0500 ; $5246
	ld de, $3100 ; $5249
	rst Rst18 ; $524c
	inc h ; $524d
Label_12_524e:
	ld a, [bc] ; $524e
	ld a, $00 ; $524f
	rst Rst18 ; $5251
	jr nz, Label_12_525e ; $5252
	ld a, $07 ; $5254
	ld b, $c0 ; $5256
	rst Rst18 ; $5258
	ld l, $0a ; $5259
	ld a, $07 ; $525b
	INCBIN "data/bank_012/d_525d.bin" ; $525d, 1 bytes
Label_12_525e:
	ld [bc], a ; $525e
	rst Rst18 ; $525f
	inc [hl] ; $5260
	ld a, [bc] ; $5261
	ld a, $00 ; $5262
	ld bc, $0c00 ; $5264
	ld de, $3100 ; $5267
	rst Rst18 ; $526a
	inc h ; $526b
	ld a, [bc] ; $526c
	jp Label_12_528d ; $526d
	INCBIN "data/bank_012/d_5270.bin" ; $5270, 29 bytes
Label_12_528d:
	ld c, $04 ; $528d
	call Func_00_1d20 ; $528f
	call Func_00_1da4 ; $5292
	ld a, $13 ; $5295
	ld [wStoryModeCurrentLocation], a ; $5297
	ld a, $0a ; $529a
	ld [$c295], a ; $529c
	ld a, $ff ; $529f
	ld [$c294], a ; $52a1
	ld [$c2a1], a ; $52a4
	ld a, [$c2b0] ; $52a7
	add a, $b9 ; $52aa
	ld l, a ; $52ac
	adc a, $52 ; $52ad
	sub a, l ; $52af
	ld h, a ; $52b0
	ld a, [hl] ; $52b1
	rst Rst18 ; $52b2
	nop ; $52b3
	dec bc ; $52b4
	rst Rst18 ; $52b5
	ld [bc], a ; $52b6
	ld a, [bc] ; $52b7
	ret ; $52b8
	INCBIN "data/bank_012/d_52b9.bin" ; $52b9, 4474 bytes
Func_12_6433:
	ld a, $0f ; $6433
	rst Rst18 ; $6435
	inc e ; $6436
	ld a, [bc] ; $6437
	ld a, $10 ; $6438
	rst Rst18 ; $643a
	inc e ; $643b
	ld a, [bc] ; $643c
	ld a, $0f ; $643d
	ld bc, $3900 ; $643f
	ld de, $1300 ; $6442
	rst Rst18 ; $6445
	ld [hl+], a ; $6446
	ld a, [bc] ; $6447
	ld a, $10 ; $6448
	ld bc, $3900 ; $644a
	ld de, $1900 ; $644d
	rst Rst18 ; $6450
	ld [hl+], a ; $6451
	ld a, [bc] ; $6452
	ld a, $0f ; $6453
	ld b, $80 ; $6455
	rst Rst18 ; $6457
	ld l, $0a ; $6458
	ld a, $10 ; $645a
	ld b, $80 ; $645c
	rst Rst18 ; $645e
	ld l, $0a ; $645f
	push af ; $6461
	ld a, $14 ; $6462
	rst Rst18 ; $6464
	inc b ; $6465
	ld a, [bc] ; $6466
	pop af ; $6467
	ret ; $6468
	INCBIN "data/bank_012/d_6469.bin" ; $6469, 55 bytes
Func_12_64a0:
	ld a, $0f ; $64a0
	ld bc, $3200 ; $64a2
	ld de, $1100 ; $64a5
	rst Rst18 ; $64a8
	inc h ; $64a9
	ld a, [bc] ; $64aa
	ld a, $10 ; $64ab
	ld bc, $3600 ; $64ad
	ld de, $1d00 ; $64b0
	rst Rst18 ; $64b3
	inc h ; $64b4
	ld a, [bc] ; $64b5
	ld a, $0f ; $64b6
	rst Rst18 ; $64b8
	jr nz, Label_12_64c5 ; $64b9
	ld a, $10 ; $64bb
	rst Rst18 ; $64bd
	jr nz, Label_12_64ca ; $64be
	ld a, $10 ; $64c0
	ld b, $c0 ; $64c2
	rst Rst18 ; $64c4
Label_12_64c5:
	ld l, $0a ; $64c5
	ldh a, [$ff95] ; $64c7
	ld b, a ; $64c9
Label_12_64ca:
	ld a, $0f ; $64ca
	ld de, $7b89 ; $64cc
	rst Rst18 ; $64cf
	ld a, [de] ; $64d0
	ld a, [bc] ; $64d1
	ldh a, [$ff95] ; $64d2
	ld b, a ; $64d4
	ld a, $10 ; $64d5
	ld de, $7bf0 ; $64d7
	rst Rst18 ; $64da
	ld a, [de] ; $64db
	ld a, [bc] ; $64dc
	ret ; $64dd
	INCBIN "data/bank_012/d_64de.bin" ; $64de, 358 bytes
	rst Rst18 ; $6644
	ld [hl], $0a ; $6645
	ldh a, [$ff95] ; $6647
	ld b, a ; $6649
	ld a, $07 ; $664a
	ld de, $78ab ; $664c
	rst Rst18 ; $664f
	ld a, [de] ; $6650
	ld a, [bc] ; $6651
	ldh a, [$ff95] ; $6652
	ld b, a ; $6654
	ld a, $06 ; $6655
	ld de, $78c2 ; $6657
	rst Rst18 ; $665a
	ld a, [de] ; $665b
	ld a, [bc] ; $665c
	ld a, $03 ; $665d
	ld b, $40 ; $665f
	rst Rst18 ; $6661
	ld l, $0a ; $6662
	ld a, $07 ; $6664
	rst Rst18 ; $6666
	ld e, $0a ; $6667
	ld a, $01 ; $6669
	rst Rst18 ; $666b
	inc e ; $666c
	ld a, [bc] ; $666d
	ld a, $00 ; $666e
	ld b, $00 ; $6670
	rst Rst18 ; $6672
	inc a ; $6673
	ld a, [bc] ; $6674
	rst Rst18 ; $6675
	ld a, $0a ; $6676
	ld hl, $107c ; $6678
	rst Rst18 ; $667b
	ld c, $0a ; $667c
	ld a, $06 ; $667e
	ld d, $03 ; $6680
	rst Rst18 ; $6682
	inc [hl] ; $6683
	ld a, [bc] ; $6684
	ld a, $06 ; $6685
	rst Rst18 ; $6687
	ld [hl], $0a ; $6688
	ld a, $06 ; $668a
	rst Rst18 ; $668c
	ld [$3e0a], sp ; $668d
	rlca ; $6690
	ld d, $03 ; $6691
	rst Rst18 ; $6693
	inc [hl] ; $6694
	ld a, [bc] ; $6695
	ld a, $07 ; $6696
	rst Rst18 ; $6698
	ld [hl], $0a ; $6699
	ld a, $07 ; $669b
	rst Rst18 ; $669d
	ld [$3e0a], sp ; $669e
	rlca ; $66a1
	ld b, $c0 ; $66a2
	rst Rst18 ; $66a4
	ld l, $0a ; $66a5
	ld a, $06 ; $66a7
	ld b, $c0 ; $66a9
	rst Rst18 ; $66ab
	ld l, $0a ; $66ac
	ret ; $66ae
	INCBIN "data/bank_012/d_66af.bin" ; $66af, 2220 bytes
	rst Rst18 ; $6f5b
	ld d, $0a ; $6f5c
	ld c, l ; $6f5e
	ld b, h ; $6f5f
	ld de, $d000 ; $6f60
	rst Rst18 ; $6f63
	jr nz, Label_12_6f6a ; $6f64
	rst Rst18 ; $6f66
	ld [bc], a ; $6f67
	ld a, [bc] ; $6f68
	ret ; $6f69
Label_12_6f6a:
	ld a, $02 ; $6f6a
	rst Rst18 ; $6f6c
	inc e ; $6f6d
	ld a, [bc] ; $6f6e
	ld a, $03 ; $6f6f
	ld b, $00 ; $6f71
	rst Rst18 ; $6f73
	ld l, $0a ; $6f74
	ld a, $07 ; $6f76
	ld bc, $3300 ; $6f78
	ld de, $1100 ; $6f7b
	rst Rst18 ; $6f7e
	ld [hl+], a ; $6f7f
	ld a, [bc] ; $6f80
	ld a, $07 ; $6f81
	ld b, $40 ; $6f83
	rst Rst18 ; $6f85
	ld l, $0a ; $6f86
	ld a, $06 ; $6f88
	ld bc, $3500 ; $6f8a
	ld de, $1300 ; $6f8d
	rst Rst18 ; $6f90
	ld [hl+], a ; $6f91
	ld a, [bc] ; $6f92
	ld a, $06 ; $6f93
	ld b, $40 ; $6f95
	rst Rst18 ; $6f97
	ld l, $0a ; $6f98
	ld a, $00 ; $6f9a
	ld bc, $3300 ; $6f9c
	ld de, $1b00 ; $6f9f
	rst Rst18 ; $6fa2
	ld [hl+], a ; $6fa3
	ld a, [bc] ; $6fa4
	ld a, $02 ; $6fa5
	ld bc, $3500 ; $6fa7
	ld de, $1b00 ; $6faa
	rst Rst18 ; $6fad
	ld [hl+], a ; $6fae
	ld a, [bc] ; $6faf
	ld a, $00 ; $6fb0
	ld b, $c0 ; $6fb2
	rst Rst18 ; $6fb4
	ld l, $0a ; $6fb5
	ld a, $02 ; $6fb7
	ld b, $c0 ; $6fb9
	rst Rst18 ; $6fbb
	ld l, $0a ; $6fbc
	call Func_12_77fd ; $6fbe
	ld hl, $1081 ; $6fc1
	rst Rst18 ; $6fc4
	ld c, $0a ; $6fc5
	push af ; $6fc7
	ld a, $28 ; $6fc8
	rst Rst18 ; $6fca
	inc b ; $6fcb
	ld a, [bc] ; $6fcc
	pop af ; $6fcd
	ld a, $07 ; $6fce
	ld d, $02 ; $6fd0
	rst Rst18 ; $6fd2
	inc [hl] ; $6fd3
	ld a, [bc] ; $6fd4
	ld a, $07 ; $6fd5
	rst Rst18 ; $6fd7
	ld [hl], $0a ; $6fd8
	push af ; $6fda
	ld a, $14 ; $6fdb
	rst Rst18 ; $6fdd
	inc b ; $6fde
	ld a, [bc] ; $6fdf
	pop af ; $6fe0
	ld a, $03 ; $6fe1
	ld de, $ff80 ; $6fe3
	rst Rst18 ; $6fe6
	ld b, d ; $6fe7
	ld a, [bc] ; $6fe8
	ld a, $03 ; $6fe9
	rst Rst18 ; $6feb
	ld b, h ; $6fec
	ld a, [bc] ; $6fed
	ld a, $03 ; $6fee
	ld de, $ff80 ; $6ff0
	rst Rst18 ; $6ff3
	ld b, d ; $6ff4
	ld a, [bc] ; $6ff5
	ld a, $03 ; $6ff6
	rst Rst18 ; $6ff8
	ld b, h ; $6ff9
	ld a, [bc] ; $6ffa
	ld a, $03 ; $6ffb
	rst Rst18 ; $6ffd
	ld [$f50a], sp ; $6ffe
	ld a, $3c ; $7001
	rst Rst18 ; $7003
	inc b ; $7004
	ld a, [bc] ; $7005
	pop af ; $7006
	ld a, $03 ; $7007
	ld bc, $2d00 ; $7009
	ld de, $1900 ; $700c
	rst Rst18 ; $700f
	inc h ; $7010
	ld a, [bc] ; $7011
	xor a, a ; $7012
	ld bc, $2d00 ; $7013
	ld de, $1b00 ; $7016
	rst Rst18 ; $7019
	ld a, [hl-] ; $701a
	ld a, [bc] ; $701b
	ld a, $00 ; $701c
	ld bc, $2d00 ; $701e
	ld de, $1b00 ; $7021
	rst Rst18 ; $7024
	inc h ; $7025
	ld a, [bc] ; $7026
	ld a, $02 ; $7027
	ld bc, $2d00 ; $7029
	ld de, $1d00 ; $702c
	rst Rst18 ; $702f
	inc h ; $7030
	ld a, [bc] ; $7031
	ldh a, [$ff95] ; $7032
	ld b, a ; $7034
	ld a, $07 ; $7035
	ld de, $7940 ; $7037
	rst Rst18 ; $703a
	ld a, [de] ; $703b
	ld a, [bc] ; $703c
	ldh a, [$ff95] ; $703d
	ld b, a ; $703f
	ld a, $06 ; $7040
	ld de, $7929 ; $7042
	rst Rst18 ; $7045
	ld a, [de] ; $7046
	ld a, [bc] ; $7047
	call Func_12_64a0 ; $7048
	ld a, $03 ; $704b
	ld b, $40 ; $704d
	rst Rst18 ; $704f
	ld l, $0a ; $7050
	ld a, $00 ; $7052
	ld b, $40 ; $7054
	rst Rst18 ; $7056
	ld l, $0a ; $7057
	ld a, $02 ; $7059
	ld b, $40 ; $705b
	rst Rst18 ; $705d
	ld l, $0a ; $705e
	ld a, $02 ; $7060
	rst Rst18 ; $7062
	ld d, $0a ; $7063
	ld c, l ; $7065
	ld b, h ; $7066
	ld de, $d000 ; $7067
	rst Rst18 ; $706a
	jr nz, Label_12_7071 ; $706b
	rst Rst18 ; $706d
	ld [bc], a ; $706e
	ld a, [bc] ; $706f
	ret ; $7070
Label_12_7071:
	ld a, $09 ; $7071
	ld bc, $1b00 ; $7073
	ld de, $0b00 ; $7076
	rst Rst18 ; $7079
	ld [hl+], a ; $707a
	ld a, [bc] ; $707b
	ld a, $08 ; $707c
	ld bc, $1b00 ; $707e
	ld de, $0d00 ; $7081
	rst Rst18 ; $7084
	ld [hl+], a ; $7085
	ld a, [bc] ; $7086
	ld a, $09 ; $7087
	ld b, $80 ; $7089
	rst Rst18 ; $708b
	ld l, $0a ; $708c
	ld a, $08 ; $708e
	ld b, $80 ; $7090
	rst Rst18 ; $7092
	ld l, $0a ; $7093
	ld a, $08 ; $7095
	rst Rst18 ; $7097
	inc e ; $7098
	ld a, [bc] ; $7099
	ld a, $08 ; $709a
	ld d, $01 ; $709c
	rst Rst18 ; $709e
	inc [hl] ; $709f
	ld a, [bc] ; $70a0
	ld a, $02 ; $70a1
	rst Rst18 ; $70a3
	inc e ; $70a4
	ld a, [bc] ; $70a5
	ld a, $03 ; $70a6
	ld bc, $2b00 ; $70a8
	ld de, $2700 ; $70ab
	rst Rst18 ; $70ae
	ld [hl+], a ; $70af
	ld a, [bc] ; $70b0
	ld a, $04 ; $70b1
	ld bc, $2500 ; $70b3
	ld de, $0f00 ; $70b6
	rst Rst18 ; $70b9
	ld [hl+], a ; $70ba
	ld a, [bc] ; $70bb
	ld a, $04 ; $70bc
	ld b, $40 ; $70be
	rst Rst18 ; $70c0
	ld l, $0a ; $70c1
	ld a, $04 ; $70c3
	rst Rst18 ; $70c5
	inc e ; $70c6
	ld a, [bc] ; $70c7
	ld a, $04 ; $70c8
	ld d, $01 ; $70ca
	rst Rst18 ; $70cc
	inc [hl] ; $70cd
	ld a, [bc] ; $70ce
	ld a, $05 ; $70cf
	ld bc, $2300 ; $70d1
	ld de, $1300 ; $70d4
	rst Rst18 ; $70d7
	ld [hl+], a ; $70d8
	ld a, [bc] ; $70d9
	ld a, $05 ; $70da
	ld b, $40 ; $70dc
	rst Rst18 ; $70de
	ld l, $0a ; $70df
	ld a, $05 ; $70e1
	rst Rst18 ; $70e3
	inc e ; $70e4
	ld a, [bc] ; $70e5
	ld a, $05 ; $70e6
	ld d, $01 ; $70e8
	rst Rst18 ; $70ea
	inc [hl] ; $70eb
	ld a, [bc] ; $70ec
	ld a, $00 ; $70ed
	ld bc, $2500 ; $70ef
	ld de, $1b00 ; $70f2
	rst Rst18 ; $70f5
	ld [hl+], a ; $70f6
	ld a, [bc] ; $70f7
	ld a, $00 ; $70f8
	ld b, $c0 ; $70fa
	rst Rst18 ; $70fc
	ld l, $0a ; $70fd
	ld a, $02 ; $70ff
	ld bc, $2300 ; $7101
	ld de, $1b00 ; $7104
	rst Rst18 ; $7107
	ld [hl+], a ; $7108
	ld a, [bc] ; $7109
	ld a, $02 ; $710a
	ld b, $c0 ; $710c
	rst Rst18 ; $710e
	ld l, $0a ; $710f
	ld bc, $0040 ; $7111
	rst Rst18 ; $7114
	jr c, Label_12_7121 ; $7115
	xor a, a ; $7117
	ld bc, $2400 ; $7118
	ld de, $1500 ; $711b
	rst Rst18 ; $711e
	ld a, [hl-] ; $711f
	ld a, [bc] ; $7120
Label_12_7121:
	rst Rst18 ; $7121
	ld a, $0a ; $7122
	ld a, $03 ; $7124
	ld b, $80 ; $7126
	rst Rst18 ; $7128
	ld l, $0a ; $7129
	rst Rst18 ; $712b
	ld a, $0a ; $712c
	ld c, $20 ; $712e
	call Func_00_1d2e ; $7130
	call Func_00_1da4 ; $7133
	ld hl, $1082 ; $7136
	rst Rst18 ; $7139
	ld c, $0a ; $713a
	ld a, $04 ; $713c
	ld bc, $2500 ; $713e
	ld de, $1300 ; $7141
	rst Rst18 ; $7144
	inc h ; $7145
	ld a, [bc] ; $7146
	ld a, $04 ; $7147
	rst Rst18 ; $7149
	jr nz, Label_12_7156 ; $714a
	ld a, $05 ; $714c
	ld b, a ; $714e
	ld a, $04 ; $714f
	rst Rst18 ; $7151
	ld [hl-], a ; $7152
	ld a, [bc] ; $7153
	ld a, $04 ; $7154
Label_12_7156:
	ld d, $02 ; $7156
	rst Rst18 ; $7158
	inc [hl] ; $7159
	ld a, [bc] ; $715a
	ld a, $04 ; $715b
	rst Rst18 ; $715d
	ld [$3e0a], sp ; $715e
	dec b ; $7161
	ld b, $40 ; $7162
	rst Rst18 ; $7164
	ld l, $0a ; $7165
	ld a, $05 ; $7167
	ld d, $04 ; $7169
	rst Rst18 ; $716b
	inc [hl] ; $716c
	ld a, [bc] ; $716d
	ld a, $05 ; $716e
	rst Rst18 ; $7170
	ld [hl], $0a ; $7171
	ld a, $05 ; $7173
	rst Rst18 ; $7175
	ld [$3e0a], sp ; $7176
	inc bc ; $7179
	ld d, $03 ; $717a
	rst Rst18 ; $717c
	inc [hl] ; $717d
	ld a, [bc] ; $717e
	ld a, $03 ; $717f
	rst Rst18 ; $7181
	ld [$3e0a], sp ; $7182
	inc b ; $7185
	ld d, $02 ; $7186
	rst Rst18 ; $7188
	inc [hl] ; $7189
	ld a, [bc] ; $718a
	ld a, $05 ; $718b
	ld d, $02 ; $718d
	rst Rst18 ; $718f
	inc [hl] ; $7190
	ld a, [bc] ; $7191
	ld a, $02 ; $7192
	ld d, $02 ; $7194
	rst Rst18 ; $7196
	inc [hl] ; $7197
	ld a, [bc] ; $7198
	ld a, $00 ; $7199
	ld d, $02 ; $719b
	rst Rst18 ; $719d
	inc [hl] ; $719e
	ld a, [bc] ; $719f
	ld a, $00 ; $71a0
	ld b, $40 ; $71a2
	rst Rst18 ; $71a4
	ld l, $0a ; $71a5
	ld a, $02 ; $71a7
	ld b, $40 ; $71a9
	rst Rst18 ; $71ab
	ld l, $0a ; $71ac
	ld a, $04 ; $71ae
	ld b, $40 ; $71b0
	rst Rst18 ; $71b2
	ld l, $0a ; $71b3
	ld bc, $0010 ; $71b5
	rst Rst18 ; $71b8
	jr c, Label_12_71c5 ; $71b9
	ld a, $03 ; $71bb
	ld bc, $0010 ; $71bd
	rst Rst18 ; $71c0
	jr Label_12_71cd ; $71c1
	INCBIN "data/bank_012/d_71c3.bin" ; $71c3, 2 bytes
Label_12_71c5:
	nop ; $71c5
	dec hl ; $71c6
	ld de, $2000 ; $71c7
	rst Rst18 ; $71ca
	ld a, [hl-] ; $71cb
	ld a, [bc] ; $71cc
Label_12_71cd:
	ld a, $03 ; $71cd
	ld bc, $2b00 ; $71cf
	ld de, $2000 ; $71d2
	rst Rst18 ; $71d5
	inc h ; $71d6
	ld a, [bc] ; $71d7
	ld a, $03 ; $71d8
	rst Rst18 ; $71da
	jr nz, Label_12_71e7 ; $71db
	rst Rst18 ; $71dd
	ld a, $0a ; $71de
	xor a, a ; $71e0
	ld bc, $2400 ; $71e1
	ld de, $1b00 ; $71e4
Label_12_71e7:
	rst Rst18 ; $71e7
	ld a, [hl-] ; $71e8
	ld a, [bc] ; $71e9
	ld a, $03 ; $71ea
	ld bc, $2500 ; $71ec
	ld de, $1f00 ; $71ef
	rst Rst18 ; $71f2
	inc h ; $71f3
	ld a, [bc] ; $71f4
	ld a, $03 ; $71f5
	rst Rst18 ; $71f7
	jr nz, Label_12_7204 ; $71f8
	ld a, $03 ; $71fa
	ld b, $c0 ; $71fc
	rst Rst18 ; $71fe
	ld l, $0a ; $71ff
	ld a, $03 ; $7201
	INCBIN "data/bank_012/d_7203.bin" ; $7203, 1 bytes
Label_12_7204:
	ld [bc], a ; $7204
	rst Rst18 ; $7205
	inc [hl] ; $7206
	ld a, [bc] ; $7207
	ld a, $03 ; $7208
	rst Rst18 ; $720a
	ld [hl], $0a ; $720b
	ld a, $03 ; $720d
	rst Rst18 ; $720f
	ld [$3e0a], sp ; $7210
	ld [bc], a ; $7213
	ld b, a ; $7214
	ld a, $00 ; $7215
	rst Rst18 ; $7217
	ld [hl-], a ; $7218
	ld a, [bc] ; $7219
	push af ; $721a
	ld a, $1e ; $721b
	rst Rst18 ; $721d
	inc b ; $721e
	ld a, [bc] ; $721f
	pop af ; $7220
	ld a, $00 ; $7221
	ld b, $40 ; $7223
	rst Rst18 ; $7225
	ld l, $0a ; $7226
	ld a, $02 ; $7228
	ld b, $40 ; $722a
	rst Rst18 ; $722c
	ld l, $0a ; $722d
	ld a, $02 ; $722f
	ld d, $03 ; $7231
	rst Rst18 ; $7233
	inc [hl] ; $7234
	ld a, [bc] ; $7235
	ld a, $00 ; $7236
	ld d, $03 ; $7238
	rst Rst18 ; $723a
	inc [hl] ; $723b
	ld a, [bc] ; $723c
	ld a, $00 ; $723d
	rst Rst18 ; $723f
	ld [hl], $0a ; $7240
	ld a, $03 ; $7242
	ld d, $03 ; $7244
	rst Rst18 ; $7246
	inc [hl] ; $7247
	ld a, [bc] ; $7248
	ld a, $03 ; $7249
	rst Rst18 ; $724b
	ld [hl], $0a ; $724c
	ld hl, $1087 ; $724e
	rst Rst18 ; $7251
	ld c, $0a ; $7252
	ld a, $03 ; $7254
	rst Rst18 ; $7256
	ld [$3e0a], sp ; $7257
	inc bc ; $725a
	ld bc, $2500 ; $725b
	ld de, $1d00 ; $725e
	rst Rst18 ; $7261
	inc h ; $7262
	ld a, [bc] ; $7263
	ld a, $03 ; $7264
	rst Rst18 ; $7266
	jr nz, Label_12_7273 ; $7267
	ld a, $03 ; $7269
	ld d, $02 ; $726b
	rst Rst18 ; $726d
	inc [hl] ; $726e
	ld a, [bc] ; $726f
	ld a, $03 ; $7270
	rst Rst18 ; $7272
Label_12_7273:
	ld [hl], $0a ; $7273
	push af ; $7275
	ld a, $1e ; $7276
	rst Rst18 ; $7278
	inc b ; $7279
	ld a, [bc] ; $727a
	pop af ; $727b
	ld a, $03 ; $727c
	ld d, $03 ; $727e
	rst Rst18 ; $7280
	inc [hl] ; $7281
	ld a, [bc] ; $7282
	ld a, $00 ; $7283
	ld d, $03 ; $7285
	rst Rst18 ; $7287
	inc [hl] ; $7288
	ld a, [bc] ; $7289
	ld a, $00 ; $728a
	rst Rst18 ; $728c
	ld [hl], $0a ; $728d
	ld a, $00 ; $728f
	rst Rst18 ; $7291
	ld [$3e0a], sp ; $7292
	inc bc ; $7295
	ld d, $02 ; $7296
	rst Rst18 ; $7298
	inc [hl] ; $7299
	ld a, [bc] ; $729a
	ld a, $03 ; $729b
	rst Rst18 ; $729d
	ld [hl], $0a ; $729e
	ld a, $03 ; $72a0
	rst Rst18 ; $72a2
	ld [$3e0a], sp ; $72a3
	inc bc ; $72a6
	ld d, $03 ; $72a7
	rst Rst18 ; $72a9
	inc [hl] ; $72aa
	ld a, [bc] ; $72ab
	ld a, $03 ; $72ac
	rst Rst18 ; $72ae
	ld [hl], $0a ; $72af
	ld a, $03 ; $72b1
	rst Rst18 ; $72b3
	ld [$3e0a], sp ; $72b4
	nop ; $72b7
	ld d, $03 ; $72b8
	rst Rst18 ; $72ba
	inc [hl] ; $72bb
	ld a, [bc] ; $72bc
	ld a, $00 ; $72bd
	rst Rst18 ; $72bf
	ld [hl], $0a ; $72c0
	ld a, $03 ; $72c2
	ld d, $03 ; $72c4
	rst Rst18 ; $72c6
	inc [hl] ; $72c7
	ld a, [bc] ; $72c8
	ld a, $03 ; $72c9
	rst Rst18 ; $72cb
	ld [hl], $0a ; $72cc
	ld a, $00 ; $72ce
	ld d, $02 ; $72d0
	rst Rst18 ; $72d2
	inc [hl] ; $72d3
	ld a, [bc] ; $72d4
	ld a, $00 ; $72d5
	rst Rst18 ; $72d7
	ld [hl], $0a ; $72d8
	ld a, $00 ; $72da
	ld b, $c0 ; $72dc
	rst Rst18 ; $72de
	ld l, $0a ; $72df
	ld a, $02 ; $72e1
	ld b, $c0 ; $72e3
	rst Rst18 ; $72e5
	ld l, $0a ; $72e6
	push af ; $72e8
	ld a, $28 ; $72e9
	rst Rst18 ; $72eb
	inc b ; $72ec
	ld a, [bc] ; $72ed
	pop af ; $72ee
	xor a, a ; $72ef
	ld bc, $2400 ; $72f0
	ld de, $1700 ; $72f3
	rst Rst18 ; $72f6
	ld a, [hl-] ; $72f7
	ld a, [bc] ; $72f8
	rst Rst18 ; $72f9
	ld a, $0a ; $72fa
	ld a, $05 ; $72fc
	ld d, $02 ; $72fe
	rst Rst18 ; $7300
	inc [hl] ; $7301
	ld a, [bc] ; $7302
	push af ; $7303
	ld a, $28 ; $7304
	rst Rst18 ; $7306
	inc b ; $7307
	ld a, [bc] ; $7308
	pop af ; $7309
	ld a, $05 ; $730a
	rst Rst18 ; $730c
	ld [$3e0a], sp ; $730d
	inc b ; $7310
	ld bc, $2500 ; $7311
	ld de, $1500 ; $7314
	rst Rst18 ; $7317
	inc h ; $7318
	ld a, [bc] ; $7319
	ld a, $04 ; $731a
	rst Rst18 ; $731c
	jr nz, Label_12_7329 ; $731d
	ld a, $04 ; $731f
	rst Rst18 ; $7321
	ld [$3e0a], sp ; $7322
	ld [bc], a ; $7325
	ld b, a ; $7326
	ld a, $00 ; $7327
Label_12_7329:
	rst Rst18 ; $7329
	ld [hl-], a ; $732a
	ld a, [bc] ; $732b
	push af ; $732c
	ld a, $0a ; $732d
	rst Rst18 ; $732f
	inc b ; $7330
	ld a, [bc] ; $7331
	pop af ; $7332
	ld a, $00 ; $7333
	ld d, $02 ; $7335
	rst Rst18 ; $7337
	inc [hl] ; $7338
	ld a, [bc] ; $7339
	ld a, $02 ; $733a
	ld d, $02 ; $733c
	rst Rst18 ; $733e
	inc [hl] ; $733f
	ld a, [bc] ; $7340
	ld a, $02 ; $7341
	rst Rst18 ; $7343
	ld [hl], $0a ; $7344
	ld a, $00 ; $7346
	ld b, $c0 ; $7348
	rst Rst18 ; $734a
	ld l, $0a ; $734b
	ld a, $02 ; $734d
	ld b, $c0 ; $734f
	rst Rst18 ; $7351
	ld l, $0a ; $7352
	ld a, $02 ; $7354
	ld d, $03 ; $7356
	rst Rst18 ; $7358
	inc [hl] ; $7359
	ld a, [bc] ; $735a
	ld a, $00 ; $735b
	ld d, $03 ; $735d
	rst Rst18 ; $735f
	inc [hl] ; $7360
	ld a, [bc] ; $7361
	ld a, $00 ; $7362
	rst Rst18 ; $7364
	ld [hl], $0a ; $7365
	push af ; $7367
	ld a, $0a ; $7368
	rst Rst18 ; $736a
	inc b ; $736b
	ld a, [bc] ; $736c
	pop af ; $736d
	ld a, $04 ; $736e
	ld d, $03 ; $7370
	rst Rst18 ; $7372
	inc [hl] ; $7373
	ld a, [bc] ; $7374
	ld a, $05 ; $7375
	ld d, $03 ; $7377
	rst Rst18 ; $7379
	inc [hl] ; $737a
	ld a, [bc] ; $737b
	ld a, $05 ; $737c
	rst Rst18 ; $737e
	ld [hl], $0a ; $737f
	ld a, $10 ; $7381
	ld [wStoryModeCurrentLocation], a ; $7383
	ld a, $01 ; $7386
	ld [$c295], a ; $7388
	ld a, $ff ; $738b
	ld [$c294], a ; $738d
	ld [$c2a1], a ; $7390
	ld a, $03 ; $7393
	ld d, $03 ; $7395
	rst Rst18 ; $7397
	inc [hl] ; $7398
	ld a, [bc] ; $7399
	ld a, $03 ; $739a
	rst Rst18 ; $739c
	ld [hl], $0a ; $739d
	push af ; $739f
	ld a, $1e ; $73a0
	rst Rst18 ; $73a2
	inc b ; $73a3
	ld a, [bc] ; $73a4
	pop af ; $73a5
	ld c, $08 ; $73a6
	call Func_00_1d20 ; $73a8
	call Func_00_1da4 ; $73ab
	rst Rst18 ; $73ae
	ld [bc], a ; $73af
	ld a, [bc] ; $73b0
	ret ; $73b1
	INCBIN "data/bank_012/d_73b2.bin" ; $73b2, 1099 bytes
Func_12_77fd:
	call Func_12_6433 ; $77fd
	ld bc, $0040 ; $7800
	rst Rst18 ; $7803
	jr c, Label_12_7810 ; $7804
	xor a, a ; $7806
	ld bc, $3500 ; $7807
	ld de, $1500 ; $780a
	rst Rst18 ; $780d
	ld a, [hl-] ; $780e
	ld a, [bc] ; $780f
Label_12_7810:
	rst Rst18 ; $7810
	ld a, $0a ; $7811
	ld a, $00 ; $7813
	ld b, $c0 ; $7815
	rst Rst18 ; $7817
	ld l, $0a ; $7818
	ld a, $03 ; $781a
	ld b, $00 ; $781c
	rst Rst18 ; $781e
	ld l, $0a ; $781f
	rst Rst18 ; $7821
	ld a, $0a ; $7822
	ld c, $20 ; $7824
	call Func_00_1d2e ; $7826
	call Func_00_1da4 ; $7829
	ret ; $782c
	INCBIN "data/bank_012/d_782d.bin" ; $782d, 2003 bytes
