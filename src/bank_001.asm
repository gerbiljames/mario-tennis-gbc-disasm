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
	INCBIN "data/bank_001/d_40ec.bin" ; $40ec, 3940 bytes
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
	INCBIN "data/bank_001/d_5095.bin" ; $5095, 76 bytes
	ret ; $50e1
Func_01_50e2:
	call Func_01_5050 ; $50e2
	call Func_01_5062 ; $50e5
	call Func_01_5076 ; $50e8
	ret ; $50eb
	INCBIN "data/bank_001/d_50ec.bin" ; $50ec, 156 bytes
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
