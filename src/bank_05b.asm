SECTION "ROM Bank $5b", ROMX[$4000], BANK[$5b]

	dw LuigiSpriteDesc ; $4000
LuigiSpriteDesc:
	dw $0003 ; $4002
	dw $0003 ; $4004
	dw LuigiSpriteFrames ; $4006 frame table
	dw LuigiSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw LuigiSpriteOam ; $400c per-slot OAM data
LuigiSpriteFrames:
	dw LuigiSpriteFrame00 ; $400e
	dw LuigiSpriteFrame01 ; $4010
	dw LuigiSpriteFrame02 ; $4012
	dw LuigiSpriteFrame03 ; $4014
	dw LuigiSpriteFrame04 ; $4016
	dw LuigiSpriteFrame05 ; $4018
	dw LuigiSpriteFrame06 ; $401a
	dw LuigiSpriteFrame07 ; $401c
	dw LuigiSpriteFrame08 ; $401e
	dw LuigiSpriteFrame09 ; $4020
	dw LuigiSpriteFrame10 ; $4022
	dw LuigiSpriteFrame01 ; $4024
	dw LuigiSpriteFrame02 ; $4026
	dw LuigiSpriteFrame03 ; $4028
	dw LuigiSpriteFrame11 ; $402a
	dw LuigiSpriteFrame12 ; $402c
	dw LuigiSpriteFrame01 ; $402e
	dw LuigiSpriteFrame02 ; $4030
	dw LuigiSpriteFrame03 ; $4032
	dw LuigiSpriteFrame13 ; $4034
	dw LuigiSpriteFrame14 ; $4036
	dw LuigiSpriteFrame06 ; $4038
	dw LuigiSpriteFrame07 ; $403a
	dw LuigiSpriteFrame08 ; $403c
	dw LuigiSpriteFrame15 ; $403e
	dw LuigiSpriteFrame16 ; $4040
	dw LuigiSpriteFrame16 ; $4042
	dw LuigiSpriteFrame16 ; $4044
	dw LuigiSpriteFrame17 ; $4046
	dw LuigiSpriteFrame17 ; $4048
	dw LuigiSpriteFrame18 ; $404a
	dw LuigiSpriteFrame18 ; $404c
	dw LuigiSpriteFrame18 ; $404e
	dw LuigiSpriteFrame19 ; $4050
	dw LuigiSpriteFrame19 ; $4052
	dw LuigiSpriteFrame20 ; $4054
	dw LuigiSpriteFrame20 ; $4056
	dw LuigiSpriteFrame20 ; $4058
	dw LuigiSpriteFrame21 ; $405a
	dw LuigiSpriteFrame21 ; $405c
	dw LuigiSpriteFrame22 ; $405e
	dw LuigiSpriteFrame22 ; $4060
	dw LuigiSpriteFrame22 ; $4062
	dw LuigiSpriteFrame23 ; $4064
	dw LuigiSpriteFrame23 ; $4066
	dw LuigiSpriteFrame24 ; $4068
	dw LuigiSpriteFrame24 ; $406a
	dw LuigiSpriteFrame24 ; $406c
	dw LuigiSpriteFrame25 ; $406e
	dw LuigiSpriteFrame25 ; $4070
	dw LuigiSpriteFrame26 ; $4072
	dw LuigiSpriteFrame26 ; $4074
	dw LuigiSpriteFrame26 ; $4076
	dw LuigiSpriteFrame27 ; $4078
	dw LuigiSpriteFrame27 ; $407a
	dw LuigiSpriteFrame28 ; $407c
	dw LuigiSpriteFrame28 ; $407e
	dw LuigiSpriteFrame28 ; $4080
	dw LuigiSpriteFrame29 ; $4082
	dw LuigiSpriteFrame29 ; $4084
	dw LuigiSpriteFrame30 ; $4086
	dw LuigiSpriteFrame30 ; $4088
	dw LuigiSpriteFrame30 ; $408a
	dw LuigiSpriteFrame31 ; $408c
	dw LuigiSpriteFrame31 ; $408e
	dw LuigiSpriteFrame32 ; $4090
	dw LuigiSpriteFrame32 ; $4092
	dw LuigiSpriteFrame32 ; $4094
	dw LuigiSpriteFrame33 ; $4096
	dw LuigiSpriteFrame33 ; $4098
	dw LuigiSpriteFrame34 ; $409a
	dw LuigiSpriteFrame34 ; $409c
	dw LuigiSpriteFrame34 ; $409e
	dw LuigiSpriteFrame35 ; $40a0
	dw LuigiSpriteFrame35 ; $40a2
	dw LuigiSpriteFrame36 ; $40a4
	dw LuigiSpriteFrame36 ; $40a6
	dw LuigiSpriteFrame36 ; $40a8
	dw LuigiSpriteFrame37 ; $40aa
	dw LuigiSpriteFrame37 ; $40ac
	dw LuigiSpriteFrame38 ; $40ae
	dw LuigiSpriteFrame38 ; $40b0
	dw LuigiSpriteFrame38 ; $40b2
	dw LuigiSpriteFrame39 ; $40b4
	dw LuigiSpriteFrame39 ; $40b6
	dw LuigiSpriteFrame40 ; $40b8
	dw LuigiSpriteFrame40 ; $40ba
	dw LuigiSpriteFrame40 ; $40bc
	dw LuigiSpriteFrame41 ; $40be
	dw LuigiSpriteFrame41 ; $40c0
	dw LuigiSpriteFrame42 ; $40c2
	dw LuigiSpriteFrame42 ; $40c4
	dw LuigiSpriteFrame42 ; $40c6
	dw LuigiSpriteFrame42 ; $40c8
	dw LuigiSpriteFrame42 ; $40ca
	dw LuigiSpriteFrame43 ; $40cc
	dw LuigiSpriteFrame43 ; $40ce
	dw LuigiSpriteFrame43 ; $40d0
	dw LuigiSpriteFrame43 ; $40d2
	dw LuigiSpriteFrame43 ; $40d4
	dw LuigiSpriteFrame44 ; $40d6
	dw LuigiSpriteFrame44 ; $40d8
	dw LuigiSpriteFrame44 ; $40da
	dw LuigiSpriteFrame45 ; $40dc
	dw LuigiSpriteFrame45 ; $40de
	dw LuigiSpriteFrame46 ; $40e0
	dw LuigiSpriteFrame46 ; $40e2
	dw LuigiSpriteFrame46 ; $40e4
	dw LuigiSpriteFrame47 ; $40e6
	dw LuigiSpriteFrame47 ; $40e8
	dw LuigiSpriteFrame48 ; $40ea
	dw LuigiSpriteFrame48 ; $40ec
	dw LuigiSpriteFrame48 ; $40ee
	dw LuigiSpriteFrame49 ; $40f0
	dw LuigiSpriteFrame49 ; $40f2
	dw LuigiSpriteFrame50 ; $40f4
	dw LuigiSpriteFrame50 ; $40f6
	dw LuigiSpriteFrame50 ; $40f8
	dw LuigiSpriteFrame50 ; $40fa
	dw LuigiSpriteFrame50 ; $40fc
	dw LuigiSpriteFrame51 ; $40fe
	dw LuigiSpriteFrame51 ; $4100
	dw LuigiSpriteFrame51 ; $4102
	dw LuigiSpriteFrame51 ; $4104
	dw LuigiSpriteFrame51 ; $4106
	dw LuigiSpriteFrame52 ; $4108
	dw LuigiSpriteFrame52 ; $410a
	dw LuigiSpriteFrame52 ; $410c
	dw LuigiSpriteFrame52 ; $410e
	dw LuigiSpriteFrame52 ; $4110
	dw LuigiSpriteFrame53 ; $4112
	dw LuigiSpriteFrame53 ; $4114
	dw LuigiSpriteFrame53 ; $4116
	dw LuigiSpriteFrame53 ; $4118
	dw LuigiSpriteFrame53 ; $411a
	dw LuigiSpriteFrame54 ; $411c
	dw LuigiSpriteFrame54 ; $411e
	dw LuigiSpriteFrame54 ; $4120
	dw LuigiSpriteFrame54 ; $4122
	dw LuigiSpriteFrame54 ; $4124
	dw LuigiSpriteFrame55 ; $4126
	dw LuigiSpriteFrame55 ; $4128
	dw LuigiSpriteFrame55 ; $412a
	dw LuigiSpriteFrame55 ; $412c
	dw LuigiSpriteFrame55 ; $412e
LuigiSpriteFrame00:
	INCBIN "data/bank_05b/LuigiSpriteFrame00.bin" ; $4130, 240 bytes
LuigiSpriteFrame01:
	INCBIN "data/bank_05b/LuigiSpriteFrame01.bin" ; $4220, 240 bytes
LuigiSpriteFrame02:
	INCBIN "data/bank_05b/LuigiSpriteFrame02.bin" ; $4310, 240 bytes
LuigiSpriteFrame03:
	INCBIN "data/bank_05b/LuigiSpriteFrame03.bin" ; $4400, 240 bytes
LuigiSpriteFrame04:
	INCBIN "data/bank_05b/LuigiSpriteFrame04.bin" ; $44f0, 240 bytes
LuigiSpriteFrame05:
	INCBIN "data/bank_05b/LuigiSpriteFrame05.bin" ; $45e0, 240 bytes
LuigiSpriteFrame06:
	INCBIN "data/bank_05b/LuigiSpriteFrame06.bin" ; $46d0, 240 bytes
LuigiSpriteFrame07:
	INCBIN "data/bank_05b/LuigiSpriteFrame07.bin" ; $47c0, 240 bytes
LuigiSpriteFrame08:
	INCBIN "data/bank_05b/LuigiSpriteFrame08.bin" ; $48b0, 240 bytes
LuigiSpriteFrame09:
	INCBIN "data/bank_05b/LuigiSpriteFrame09.bin" ; $49a0, 240 bytes
LuigiSpriteFrame10:
	INCBIN "data/bank_05b/LuigiSpriteFrame10.bin" ; $4a90, 240 bytes
LuigiSpriteFrame11:
	INCBIN "data/bank_05b/LuigiSpriteFrame11.bin" ; $4b80, 240 bytes
LuigiSpriteFrame12:
	INCBIN "data/bank_05b/LuigiSpriteFrame12.bin" ; $4c70, 240 bytes
LuigiSpriteFrame13:
	INCBIN "data/bank_05b/LuigiSpriteFrame13.bin" ; $4d60, 240 bytes
LuigiSpriteFrame14:
	INCBIN "data/bank_05b/LuigiSpriteFrame14.bin" ; $4e50, 240 bytes
LuigiSpriteFrame15:
	INCBIN "data/bank_05b/LuigiSpriteFrame15.bin" ; $4f40, 240 bytes
LuigiSpriteFrame16:
	INCBIN "data/bank_05b/LuigiSpriteFrame16.bin" ; $5030, 240 bytes
LuigiSpriteFrame17:
	INCBIN "data/bank_05b/LuigiSpriteFrame17.bin" ; $5120, 240 bytes
LuigiSpriteFrame18:
	INCBIN "data/bank_05b/LuigiSpriteFrame18.bin" ; $5210, 240 bytes
LuigiSpriteFrame19:
	INCBIN "data/bank_05b/LuigiSpriteFrame19.bin" ; $5300, 240 bytes
LuigiSpriteFrame20:
	INCBIN "data/bank_05b/LuigiSpriteFrame20.bin" ; $53f0, 240 bytes
LuigiSpriteFrame21:
	INCBIN "data/bank_05b/LuigiSpriteFrame21.bin" ; $54e0, 240 bytes
LuigiSpriteFrame22:
	INCBIN "data/bank_05b/LuigiSpriteFrame22.bin" ; $55d0, 240 bytes
LuigiSpriteFrame23:
	INCBIN "data/bank_05b/LuigiSpriteFrame23.bin" ; $56c0, 240 bytes
LuigiSpriteFrame24:
	INCBIN "data/bank_05b/LuigiSpriteFrame24.bin" ; $57b0, 240 bytes
LuigiSpriteFrame25:
	INCBIN "data/bank_05b/LuigiSpriteFrame25.bin" ; $58a0, 240 bytes
LuigiSpriteFrame26:
	INCBIN "data/bank_05b/LuigiSpriteFrame26.bin" ; $5990, 240 bytes
LuigiSpriteFrame27:
	INCBIN "data/bank_05b/LuigiSpriteFrame27.bin" ; $5a80, 240 bytes
LuigiSpriteFrame28:
	INCBIN "data/bank_05b/LuigiSpriteFrame28.bin" ; $5b70, 240 bytes
LuigiSpriteFrame29:
	INCBIN "data/bank_05b/LuigiSpriteFrame29.bin" ; $5c60, 240 bytes
LuigiSpriteFrame30:
	INCBIN "data/bank_05b/LuigiSpriteFrame30.bin" ; $5d50, 240 bytes
LuigiSpriteFrame31:
	INCBIN "data/bank_05b/LuigiSpriteFrame31.bin" ; $5e40, 240 bytes
LuigiSpriteFrame32:
	INCBIN "data/bank_05b/LuigiSpriteFrame32.bin" ; $5f30, 240 bytes
LuigiSpriteFrame33:
	INCBIN "data/bank_05b/LuigiSpriteFrame33.bin" ; $6020, 240 bytes
LuigiSpriteFrame34:
	INCBIN "data/bank_05b/LuigiSpriteFrame34.bin" ; $6110, 240 bytes
LuigiSpriteFrame35:
	INCBIN "data/bank_05b/LuigiSpriteFrame35.bin" ; $6200, 240 bytes
LuigiSpriteFrame36:
	INCBIN "data/bank_05b/LuigiSpriteFrame36.bin" ; $62f0, 240 bytes
LuigiSpriteFrame37:
	INCBIN "data/bank_05b/LuigiSpriteFrame37.bin" ; $63e0, 240 bytes
LuigiSpriteFrame38:
	INCBIN "data/bank_05b/LuigiSpriteFrame38.bin" ; $64d0, 240 bytes
LuigiSpriteFrame39:
	INCBIN "data/bank_05b/LuigiSpriteFrame39.bin" ; $65c0, 240 bytes
LuigiSpriteFrame40:
	INCBIN "data/bank_05b/LuigiSpriteFrame40.bin" ; $66b0, 320 bytes
LuigiSpriteFrame41:
	INCBIN "data/bank_05b/LuigiSpriteFrame41.bin" ; $67f0, 320 bytes
LuigiSpriteFrame42:
	INCBIN "data/bank_05b/LuigiSpriteFrame42.bin" ; $6930, 240 bytes
LuigiSpriteFrame43:
	INCBIN "data/bank_05b/LuigiSpriteFrame43.bin" ; $6a20, 240 bytes
LuigiSpriteFrame44:
	INCBIN "data/bank_05b/LuigiSpriteFrame44.bin" ; $6b10, 240 bytes
LuigiSpriteFrame45:
	INCBIN "data/bank_05b/LuigiSpriteFrame45.bin" ; $6c00, 240 bytes
LuigiSpriteFrame46:
	INCBIN "data/bank_05b/LuigiSpriteFrame46.bin" ; $6cf0, 240 bytes
LuigiSpriteFrame47:
	INCBIN "data/bank_05b/LuigiSpriteFrame47.bin" ; $6de0, 240 bytes
LuigiSpriteFrame48:
	INCBIN "data/bank_05b/LuigiSpriteFrame48.bin" ; $6ed0, 240 bytes
LuigiSpriteFrame49:
	INCBIN "data/bank_05b/LuigiSpriteFrame49.bin" ; $6fc0, 240 bytes
LuigiSpriteFrame50:
	INCBIN "data/bank_05b/LuigiSpriteFrame50.bin" ; $70b0, 240 bytes
LuigiSpriteFrame51:
	INCBIN "data/bank_05b/LuigiSpriteFrame51.bin" ; $71a0, 240 bytes
LuigiSpriteFrame52:
	INCBIN "data/bank_05b/LuigiSpriteFrame52.bin" ; $7290, 240 bytes
LuigiSpriteFrame53:
	INCBIN "data/bank_05b/LuigiSpriteFrame53.bin" ; $7380, 240 bytes
LuigiSpriteFrame54:
	INCBIN "data/bank_05b/LuigiSpriteFrame54.bin" ; $7470, 240 bytes
LuigiSpriteFrame55:
	INCBIN "data/bank_05b/LuigiSpriteFrame55.bin" ; $7560, 240 bytes
LuigiSpriteFramesUnused:
	INCBIN "data/bank_05b/LuigiSpriteFramesUnused.bin" ; $7650, 1680 bytes
LuigiSpriteOam:
	INCBIN "data/bank_05b/LuigiSpriteOam.bin" ; $7ce0, 580 bytes
LuigiSpriteAnims:
	dw LuigiSpriteAnim00 ; $7f24
	dw LuigiSpriteAnim01 ; $7f26
	dw LuigiSpriteAnim02 ; $7f28
	dw LuigiSpriteAnim03 ; $7f2a
	dw LuigiSpriteAnim04 ; $7f2c
	dw LuigiSpriteAnim05 ; $7f2e
	dw LuigiSpriteAnim06 ; $7f30
	dw LuigiSpriteAnim07 ; $7f32
	dw LuigiSpriteAnim08 ; $7f34
	dw LuigiSpriteAnim09 ; $7f36
	dw LuigiSpriteAnim10 ; $7f38
	dw LuigiSpriteAnim11 ; $7f3a
	dw LuigiSpriteAnim12 ; $7f3c
	dw LuigiSpriteAnim13 ; $7f3e
	dw LuigiSpriteAnim14 ; $7f40
	dw LuigiSpriteAnim15 ; $7f42
	dw LuigiSpriteAnim16 ; $7f44
	dw LuigiSpriteAnim17 ; $7f46
	dw LuigiSpriteAnim18 ; $7f48
LuigiSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
LuigiSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
LuigiSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
LuigiSpriteAnim03:
	; $7f5d, 12 bytes (sprite_anim)
	anim_frame $17, $0a
	anim_frame $18, $0a
	anim_frame $17, $0a
	anim_frame $18, $0a
	anim_frame $19, $19
	anim_loop $02
LuigiSpriteAnim04:
	; $7f69, 8 bytes (sprite_anim)
	anim_frame $1a, $14
	anim_frame $1b, $0f
	anim_frame $1c, $3c
	anim_loop $00
LuigiSpriteAnim05:
	; $7f71, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
LuigiSpriteAnim06:
	; $7f77, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
LuigiSpriteAnim07:
	; $7f7d, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
LuigiSpriteAnim08:
	; $7f83, 5 bytes (sprite_anim)
	anim_frame $15, $04
	anim_frame $16, $14
	anim_hold $fd
LuigiSpriteAnim09:
	; $7f88, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
LuigiSpriteAnim10:
	; $7f8c, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
LuigiSpriteAnim11:
	; $7f90, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
LuigiSpriteAnim12:
	; $7f94, 3 bytes (sprite_anim)
	anim_frame $15, $18
	anim_hold $fd
LuigiSpriteAnim13:
	; $7f97, 3 bytes (sprite_anim)
	anim_frame $05, $ff
	anim_hold $fd
LuigiSpriteAnim14:
	; $7f9a, 3 bytes (sprite_anim)
	anim_frame $08, $ff
	anim_hold $fd
LuigiSpriteAnim15:
	; $7f9d, 3 bytes (sprite_anim)
	anim_frame $0b, $ff
	anim_hold $fd
LuigiSpriteAnim16:
	; $7fa0, 3 bytes (sprite_anim)
	anim_frame $0e, $ff
	anim_hold $fd
LuigiSpriteAnim17:
	; $7fa3, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
LuigiSpriteAnim18:
	; $7faf, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fb7, 73 bytes fill to bank end (linker-padded)
