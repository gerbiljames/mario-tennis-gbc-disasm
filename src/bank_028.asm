INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $28", ROMX[$4000], BANK[$28]

FarPtr_28_00:
	dw Func_28_5eb0 ; $4000
FarPtr_28_02:
	dw Func_28_5efb ; $4002
FarPtr_28_04:
	dw Func_28_6030 ; $4004
FarPtr_28_06:
	dw Func_28_6044 ; $4006
FarPtr_28_08:
	dw Func_28_6058 ; $4008
FarPtr_28_0a:
	dw Func_28_60c9 ; $400a
FarPtr_28_0c:
	dw Func_28_606c ; $400c
	INCBIN "data/bank_028/d_400e.bin" ; $400e, 7842 bytes
Func_28_5eb0:
	ld a, $01 ; $5eb0
	ldh [$ff96], a ; $5eb2
	ldh [rWBK], a ; $5eb4
	ld hl, $4ba0 ; $5eb6
	ld de, $0803 ; $5eb9
	call Func_00_05b0 ; $5ebc
	ld hl, $4be0 ; $5ebf
	ld de, $0002 ; $5ec2
	call Func_00_05b0 ; $5ec5
	ld hl, $4020 ; $5ec8
	ld de, $a400 ; $5ecb
	ld c, $40 ; $5ece
	call Func_00_0480 ; $5ed0
	ld hl, $45e0 ; $5ed3
	ld de, $d000 ; $5ed6
	call DecompressData ; $5ed9
	ld hl, $d000 ; $5edc
	ld de, $9000 ; $5edf
	ld c, $80 ; $5ee2
	call Func_00_0480 ; $5ee4
	ld hl, $d800 ; $5ee7
	ld de, $8800 ; $5eea
	ld c, $80 ; $5eed
	call Func_00_0480 ; $5eef
	ld a, [$c8f5] ; $5ef2
	cp a, $02 ; $5ef5
	call z, Func_28_5efb ; $5ef7
	ret ; $5efa
Func_28_5efb:
	ld a, [$c8f7] ; $5efb
	sub a, $12 ; $5efe
	jr c, Label_28_5f2a ; $5f00
	ld a, a ; $5f02
	rst Rst00 ; $5f03
	ld [hl], $5f ; $5f04
	ld [hl], $5f ; $5f06
	ld [hl], $5f ; $5f08
	ld [hl], $5f ; $5f0a
	ld a, [hl-] ; $5f0c
	ld e, a ; $5f0d
	ld a, [hl-] ; $5f0e
	ld e, a ; $5f0f
	ld a, [hl-] ; $5f10
	ld e, a ; $5f11
	ld a, [hl-] ; $5f12
	ld e, a ; $5f13
	ld [hl], $5f ; $5f14
	ld a, [hl-] ; $5f16
	ld e, a ; $5f17
	ld l, d ; $5f18
	ld e, a ; $5f19
	add a, d ; $5f1a
	ld e, a ; $5f1b
	ld a, [hl-] ; $5f1c
	ld e, a ; $5f1d
	ld e, e ; $5f1e
	ld e, a ; $5f1f
	inc c ; $5f20
	ld h, b ; $5f21
	jp hl ; $5f22
	INCBIN "data/bank_028/d_5f23.bin" ; $5f23, 7 bytes
Label_28_5f2a:
	ld hl, $4bf0 ; $5f2a
	ld de, $a200 ; $5f2d
	ld c, $20 ; $5f30
	call Func_00_0480 ; $5f32
	ret ; $5f35
	INCBIN "data/bank_028/d_5f36.bin" ; $5f36, 4 bytes
	ld hl, $5e30 ; $5f3a
	ld de, $0b01 ; $5f3d
	call Func_00_05b0 ; $5f40
	ld hl, $5e38 ; $5f43
	ld de, $0d03 ; $5f46
	call Func_00_05b0 ; $5f49
	ld hl, $4d30 ; $5f4c
	ld de, $a100 ; $5f4f
	ld c, $10 ; $5f52
	call Func_00_0480 ; $5f54
	call Func_28_6024 ; $5f57
	ret ; $5f5a
	INCBIN "data/bank_028/d_5f5b.bin" ; $5f5b, 39 bytes
	ld hl, $5e68 ; $5f82
	ld de, $0e02 ; $5f85
	call Func_00_05b0 ; $5f88
	ld hl, $5470 ; $5f8b
	ld de, $a3c0 ; $5f8e
	ld c, $02 ; $5f91
	call Func_00_0480 ; $5f93
	call Func_28_6024 ; $5f96
	ret ; $5f99
	INCBIN "data/bank_028/d_5f9a.bin" ; $5f9a, 138 bytes
Func_28_6024:
	ld hl, $5590 ; $6024
	ld de, $8080 ; $6027
	ld c, $14 ; $602a
	call Func_00_0480 ; $602c
	ret ; $602f
Func_28_6030:
	rrca ; $6030
	rrca ; $6031
	and a, $c0 ; $6032
	add a, $60 ; $6034
	ld l, a ; $6036
	adc a, $43 ; $6037
	sub a, l ; $6039
	ld h, a ; $603a
	ld de, $a740 ; $603b
	ld c, $04 ; $603e
	call Func_00_0480 ; $6040
	ret ; $6043
Func_28_6044:
	rrca ; $6044
	rrca ; $6045
	and a, $40 ; $6046
	add a, $60 ; $6048
	ld l, a ; $604a
	adc a, $44 ; $604b
	sub a, l ; $604d
	ld h, a ; $604e
	ld de, $a780 ; $604f
	ld c, $04 ; $6052
	call Func_00_0480 ; $6054
	ret ; $6057
Func_28_6058:
	rrca ; $6058
	rrca ; $6059
	and a, $40 ; $605a
	add a, $60 ; $605c
	ld l, a ; $605e
	adc a, $45 ; $605f
	sub a, l ; $6061
	ld h, a ; $6062
	ld de, $a7c0 ; $6063
	ld c, $04 ; $6066
	call Func_00_0480 ; $6068
	ret ; $606b
Func_28_606c:
	add a, a ; $606c
	add a, $80 ; $606d
	ld l, a ; $606f
	adc a, $60 ; $6070
	sub a, l ; $6072
	ld h, a ; $6073
	ld a, [hl+] ; $6074
	ld h, [hl] ; $6075
	ld l, a ; $6076
	ld de, $a300 ; $6077
	ld c, $0c ; $607a
	call Func_00_0480 ; $607c
	ret ; $607f
	INCBIN "data/bank_028/d_6080.bin" ; $6080, 73 bytes
Func_28_60c9:
	ld a, $01 ; $60c9
	ldh [$ff96], a ; $60cb
	ldh [rWBK], a ; $60cd
	ld hl, $6d1c ; $60cf
	ld de, $0902 ; $60d2
	call Func_00_05b0 ; $60d5
	ld hl, $6d54 ; $60d8
	ld de, $0002 ; $60db
	call Func_00_05b0 ; $60de
	ld hl, $6180 ; $60e1
	ld de, $d000 ; $60e4
	call DecompressData ; $60e7
	ld hl, $d000 ; $60ea
	ld de, $9000 ; $60ed
	ld c, $20 ; $60f0
	call Func_00_0480 ; $60f2
	push af ; $60f5
	ldh a, [rLCDC] ; $60f6
	bit 7, a ; $60f8
	jr z, Label_28_60ff ; $60fa
	call Func_00_2631 ; $60fc
Label_28_60ff:
	pop af ; $60ff
	ld hl, $d200 ; $6100
	ld de, $9200 ; $6103
	ld c, $20 ; $6106
	call Func_00_0480 ; $6108
	push af ; $610b
	ldh a, [rLCDC] ; $610c
	bit 7, a ; $610e
	jr z, Label_28_6115 ; $6110
	call Func_00_2631 ; $6112
Label_28_6115:
	pop af ; $6115
	ld hl, $d400 ; $6116
	ld de, $9400 ; $6119
	ld c, $20 ; $611c
	call Func_00_0480 ; $611e
	push af ; $6121
	ldh a, [rLCDC] ; $6122
	bit 7, a ; $6124
	jr z, Label_28_612b ; $6126
	call Func_00_2631 ; $6128
Label_28_612b:
	pop af ; $612b
	ld hl, $d600 ; $612c
	ld de, $9600 ; $612f
	ld c, $20 ; $6132
	call Func_00_0480 ; $6134
	push af ; $6137
	ldh a, [rLCDC] ; $6138
	bit 7, a ; $613a
	jr z, Label_28_6141 ; $613c
	call Func_00_2631 ; $613e
Label_28_6141:
	pop af ; $6141
	ld hl, $d800 ; $6142
	ld de, $8800 ; $6145
	ld c, $20 ; $6148
	ld hl, $da00 ; $614a
	ld de, $8a00 ; $614d
	ld c, $20 ; $6150
	ld hl, $dc00 ; $6152
	ld de, $8c00 ; $6155
	ld c, $20 ; $6158
	ld hl, $de00 ; $615a
	ld de, $8e00 ; $615d
	ld c, $20 ; $6160
	call Func_00_0480 ; $6162
	push af ; $6165
	ldh a, [rLCDC] ; $6166
	bit 7, a ; $6168
	jr z, Label_28_616f ; $616a
	call Func_00_2631 ; $616c
Label_28_616f:
	pop af ; $616f
	ret ; $6170
	INCBIN "data/bank_028/d_6171.bin" ; $6171, 7823 bytes
