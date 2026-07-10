INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $01", ROMX[$4000], BANK[$01]

	INCBIN "data/bank_001/d_4000.bin" ; $4000, 24 bytes
	call Func_00_28b9 ; $4018
	push de ; $401b
	ld de, $07e0 ; $401c
	rst Rst18 ; $401f
	jr nz, $4025 ; $4020
	pop de ; $4022
	call DisableLCDSafely ; $4023
	ld a, $01 ; $4026
	ldh [$ff96], a ; $4028
	ldh [rWBK], a ; $402a
	ld hl, $d000 ; $402c
	ld c, $00 ; $402f
	call ClearMemory16 ; $4031
	ld a, $02 ; $4034
	ldh [$ff96], a ; $4036
	ldh [rWBK], a ; $4038
	ld hl, $d000 ; $403a
	ld c, $00 ; $403d
	call ClearMemory16 ; $403f
	ld a, $03 ; $4042
	ldh [$ff96], a ; $4044
	ldh [rWBK], a ; $4046
	ld hl, $d000 ; $4048
	ld c, $00 ; $404b
	call ClearMemory16 ; $404d
	ld a, $04 ; $4050
	ldh [$ff96], a ; $4052
	ldh [rWBK], a ; $4054
	ld hl, $d000 ; $4056
	ld c, $00 ; $4059
	call ClearMemory16 ; $405b
	ld a, $05 ; $405e
	ldh [$ff96], a ; $4060
	ldh [rWBK], a ; $4062
	ld hl, $d000 ; $4064
	ld c, $00 ; $4067
	call ClearMemory16 ; $4069
	ld a, $06 ; $406c
	ldh [$ff96], a ; $406e
	ldh [rWBK], a ; $4070
	ld hl, $d000 ; $4072
	ld c, $00 ; $4075
	call ClearMemory16 ; $4077
	ld hl, $c000 ; $407a
	ld c, $0a ; $407d
	call ClearMemory16 ; $407f
	call Func_00_188b ; $4082
	call Func_01_50e2 ; $4085
	call Func_01_5188 ; $4088
	rst Rst18 ; $408b
	ld [bc], a ; $408c
	inc bc ; $408d
	rst Rst18 ; $408e
	ld [de], a ; $408f
	inc bc ; $4090
	rst Rst18 ; $4091
	ld l, $03 ; $4092
	rst Rst18 ; $4094
	jr nc, Label_01_409a ; $4095
	rst Rst18 ; $4097
	ld [bc], a ; $4098
	ld [bc], a ; $4099
Label_01_409a:
	rst Rst18 ; $409a
	nop ; $409b
	INCBIN "data/bank_001/d_409c.bin" ; $409c, 1 bytes
	call EnableLCD ; $409d
	ld c, $7f ; $40a0
	call Func_00_1d2e ; $40a2
Label_01_40a5:
	ld hl, $c280 ; $40a5
	ld [hl], $00 ; $40a8
	ld hl, $c295 ; $40aa
	ld [hl], $0a ; $40ad
	rst Rst18 ; $40af
	ld e, h ; $40b0
	ld a, [bc] ; $40b1
Label_01_40b2:
	ld hl, $0153 ; $40b2
	ld de, $0511 ; $40b5
	call Func_00_1906 ; $40b8
	ld a, $03 ; $40bb
	ldh [$ff9e], a ; $40bd
Label_01_40bf:
	ldh a, [$ff91] ; $40bf
	bit 0, a ; $40c1
	jr z, Label_01_40cf ; $40c3
	push de ; $40c5
	ld de, $07e0 ; $40c6
	rst Rst18 ; $40c9
	ld e, $03 ; $40ca
	pop de ; $40cc
	jr Label_01_40d8 ; $40cd
Label_01_40cf:
	bit 3, a ; $40cf
	jr nz, Label_01_40d8 ; $40d1
	call Func_00_2631 ; $40d3
	jr Label_01_40bf ; $40d6
Label_01_40d8:
	ld a, $00 ; $40d8
	ldh [$ff9e], a ; $40da
	ld hl, $c280 ; $40dc
	ld [hl], $00 ; $40df
	ld hl, $c295 ; $40e1
	ld [hl], $0a ; $40e4
	rst Rst18 ; $40e6
	ld e, h ; $40e7
	ld a, [bc] ; $40e8
	jp Label_01_40b2 ; $40e9
	INCBIN "data/bank_001/d_40ec.bin" ; $40ec, 13 bytes
Label_01_40f9:
	ldh a, [$ff91] ; $40f9
	bit 3, a ; $40fb
	jr z, Label_01_4113 ; $40fd
	ld a, $01 ; $40ff
	ldh [$ff9e], a ; $4101
	ld hl, $c280 ; $4103
	ld [hl], $00 ; $4106
	ld hl, $c295 ; $4108
	ld [hl], $0a ; $410b
	rst Rst18 ; $410d
	ld e, h ; $410e
	ld a, [bc] ; $410f
	jp Label_01_40a5 ; $4110
Label_01_4113:
	bit 2, a ; $4113
	jr z, Label_01_411a ; $4115
	rst Rst18 ; $4117
	ld d, $01 ; $4118
Label_01_411a:
	bit 0, a ; $411a
	jr z, Label_01_4127 ; $411c
	ld a, $01 ; $411e
	ldh [$ff9e], a ; $4120
Label_01_4122:
	rst Rst18 ; $4122
	ld b, [hl] ; $4123
	rlca ; $4124
	jr Label_01_4122 ; $4125
Label_01_4127:
	bit 1, a ; $4127
	jr z, Label_01_4138 ; $4129
	ld a, $01 ; $412b
	ldh [$ff9e], a ; $412d
	rst Rst18 ; $412f
	nop ; $4130
	dec sp ; $4131
	rst Rst18 ; $4132
	inc b ; $4133
	ld [$2fc3], sp ; $4134
	ld b, c ; $4137
Label_01_4138:
	bit 6, a ; $4138
	jp z, Label_01_41c2 ; $413a
	ld a, $01 ; $413d
	ldh [$ff9e], a ; $413f
	ld a, $00 ; $4141
	ld [$c36c], a ; $4143
	rst Rst18 ; $4146
	ld a, [de] ; $4147
	inc bc ; $4148
	ld b, $00 ; $4149
	ld c, $04 ; $414b
	rst Rst18 ; $414d
	inc e ; $414e
	dec sp ; $414f
	ld b, $01 ; $4150
	ld c, $02 ; $4152
	rst Rst18 ; $4154
	inc e ; $4155
	dec sp ; $4156
	ld a, $01 ; $4157
	ld [wCurrentMinigameStoryMatch], a ; $4159
	ld a, $11 ; $415c
	ld [$c8f7], a ; $415e
	ld a, $01 ; $4161
	ld [wMatchWinLoseFlag], a ; $4163
	ld a, $00 ; $4166
	ld [$c36c], a ; $4168
	rst Rst18 ; $416b
	ld a, [de] ; $416c
	inc bc ; $416d
	ld a, $17 ; $416e
	ld [wPlayer1CurrentMainCharacter], a ; $4170
	ld a, $18 ; $4173
	ld [wPlayer1CurrentPartnerCharacter], a ; $4175
	ld a, $19 ; $4178
	ld [wPlayer2CurrentMainCharacter], a ; $417a
	ld a, $1a ; $417d
	ld [wPlayer2CurrentPartnerCharacter], a ; $417f
	ld a, $03 ; $4182
	ld [$cb0c], a ; $4184
	ld de, $002f ; $4187
	call Func_00_2509 ; $418a
	ld a, $00 ; $418d
	ld [$c8f7], a ; $418f
Label_01_4192:
	rst Rst18 ; $4192
	nop ; $4193
	ld d, $fa ; $4194
	rst Rst30 ; $4196
	ret z ; $4197
	inc a ; $4198
	ld [$c8f7], a ; $4199
	jr Label_01_4192 ; $419c
	INCBIN "data/bank_001/d_419e.bin" ; $419e, 36 bytes
Label_01_41c2:
	bit 7, a ; $41c2
	jr z, Label_01_41db ; $41c4
	ld a, $01 ; $41c6
	ldh [$ff9e], a ; $41c8
	ld a, $00 ; $41ca
	ldh [$ff9e], a ; $41cc
Label_01_41ce:
	rst Rst18 ; $41ce
	nop ; $41cf
	ld l, e ; $41d0
	rst Rst18 ; $41d1
	ld [bc], a ; $41d2
	ld l, e ; $41d3
	jr Label_01_41ce ; $41d4
	INCBIN "data/bank_001/d_41d6.bin" ; $41d6, 5 bytes
Label_01_41db:
	bit 4, a ; $41db
	jr z, Label_01_41f5 ; $41dd
	ld a, $01 ; $41df
	ldh [$ff9e], a ; $41e1
	ld hl, $c280 ; $41e3
	ld [hl], $03 ; $41e6
	ld hl, $c295 ; $41e8
	ld [hl], $0a ; $41eb
	ld a, $00 ; $41ed
	ld [wStoryModeMainCharacterOverworldSprite], a ; $41ef
	rst Rst18 ; $41f2
	ld e, h ; $41f3
	ld a, [bc] ; $41f4
Label_01_41f5:
	bit 5, a ; $41f5
	jr z, Label_01_4209 ; $41f7
	ld a, $01 ; $41f9
	ldh [$ff9e], a ; $41fb
	rst Rst18 ; $41fd
	ld [$3e1a], sp ; $41fe
	nop ; $4201
	ldh [$ff9e], a ; $4202
Label_01_4204:
	call Func_00_2631 ; $4204
	jr Label_01_4204 ; $4207
Label_01_4209:
	call Func_00_2631 ; $4209
	jp Label_01_40f9 ; $420c
	INCBIN "data/bank_001/d_420f.bin" ; $420f, 3649 bytes
Func_01_5050:
	push af ; $5050
	push bc ; $5051
	push de ; $5052
	push hl ; $5053
	ld hl, $5010 ; $5054
	ld de, $0001 ; $5057
	call Func_00_05b0 ; $505a
	pop hl ; $505d
	pop de ; $505e
	pop bc ; $505f
	pop af ; $5060
	ret ; $5061
Func_01_5062:
	push af ; $5062
	push bc ; $5063
	push de ; $5064
	push hl ; $5065
	ld hl, $4210 ; $5066
	ld de, $9000 ; $5069
	ld c, $10 ; $506c
	call Func_00_0480 ; $506e
	pop hl ; $5071
	pop de ; $5072
	pop bc ; $5073
	pop af ; $5074
	ret ; $5075
Func_01_5076:
	push af ; $5076
	push bc ; $5077
	push de ; $5078
	push hl ; $5079
	ld hl, $4410 ; $507a
	ld de, $9200 ; $507d
	ld c, $60 ; $5080
	call Func_00_0480 ; $5082
	ld hl, $4a10 ; $5085
	ld de, $8800 ; $5088
	ld c, $60 ; $508b
	call Func_00_0480 ; $508d
	pop hl ; $5090
	pop de ; $5091
	pop bc ; $5092
	pop af ; $5093
	ret ; $5094
Func_01_5095:
	push af ; $5095
	push bc ; $5096
	push de ; $5097
	push hl ; $5098
	ld hl, $4410 ; $5099
	ld de, $9200 ; $509c
	ld c, $20 ; $509f
	call Func_00_0480 ; $50a1
	call Func_00_2631 ; $50a4
	ld hl, $4610 ; $50a7
	ld de, $9400 ; $50aa
	ld c, $20 ; $50ad
	call Func_00_0480 ; $50af
	call Func_00_2631 ; $50b2
	ld hl, $4810 ; $50b5
	ld de, $9600 ; $50b8
	ld c, $20 ; $50bb
	call Func_00_0480 ; $50bd
	call Func_00_2631 ; $50c0
	ld hl, $5010 ; $50c3
	ld de, $8e00 ; $50c6
	ld c, $20 ; $50c9
	call Func_00_0480 ; $50cb
	call Func_00_2631 ; $50ce
	pop hl ; $50d1
	pop de ; $50d2
	pop bc ; $50d3
	pop af ; $50d4
	ret ; $50d5
	INCBIN "data/bank_001/d_50d6.bin" ; $50d6, 11 bytes
	ret ; $50e1
Func_01_50e2:
	call Func_01_5050 ; $50e2
	call Func_01_5062 ; $50e5
	call Func_01_5076 ; $50e8
	ret ; $50eb
	call Func_01_5050 ; $50ec
	call Func_01_5062 ; $50ef
	call Func_01_5095 ; $50f2
	ret ; $50f5
	INCBIN "data/bank_001/d_50f6.bin" ; $50f6, 146 bytes
Func_01_5188:
	push af ; $5188
	push bc ; $5189
	push de ; $518a
	push hl ; $518b
	ld hl, $87c8 ; $518c
	ld de, $0b05 ; $518f
	call Func_00_05b0 ; $5192
	pop hl ; $5195
	pop de ; $5196
	pop bc ; $5197
	pop af ; $5198
	ret ; $5199
	ld a, b ; $519a
	add a, a ; $519b
	add a, a ; $519c
	add a, a ; $519d
	add a, $f6 ; $519e
	ld l, a ; $51a0
	adc a, $50 ; $51a1
	sub a, l ; $51a3
	ld h, a ; $51a4
	ld e, $01 ; $51a5
	call Func_00_05b0 ; $51a7
	ret ; $51aa
	INCBIN "data/bank_001/d_51ab.bin" ; $51ab, 11861 bytes
