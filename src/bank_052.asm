SECTION "ROM Bank $52", ROMX[$4000], BANK[$52]

	dw YoshiSpriteDesc ; $4000
YoshiSpriteDesc:
	dw $0003 ; $4002
	dw $0003 ; $4004
	dw YoshiSpriteFrames ; $4006 frame table
	dw YoshiSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw YoshiSpriteOam ; $400c per-slot OAM data
YoshiSpriteFrames:
	dw YoshiSpriteFrame00 ; $400e
	dw YoshiSpriteFrame01 ; $4010
	dw YoshiSpriteFrame02 ; $4012
	dw YoshiSpriteFrame03 ; $4014
	dw YoshiSpriteFrame04 ; $4016
	dw YoshiSpriteFrame05 ; $4018
	dw YoshiSpriteFrame06 ; $401a
	dw YoshiSpriteFrame07 ; $401c
	dw YoshiSpriteFrame08 ; $401e
	dw YoshiSpriteFrame09 ; $4020
	dw YoshiSpriteFrame10 ; $4022
	dw YoshiSpriteFrame01 ; $4024
	dw YoshiSpriteFrame02 ; $4026
	dw YoshiSpriteFrame03 ; $4028
	dw YoshiSpriteFrame11 ; $402a
	dw YoshiSpriteFrame12 ; $402c
	dw YoshiSpriteFrame01 ; $402e
	dw YoshiSpriteFrame02 ; $4030
	dw YoshiSpriteFrame03 ; $4032
	dw YoshiSpriteFrame13 ; $4034
	dw YoshiSpriteFrame14 ; $4036
	dw YoshiSpriteFrame06 ; $4038
	dw YoshiSpriteFrame07 ; $403a
	dw YoshiSpriteFrame08 ; $403c
	dw YoshiSpriteFrame15 ; $403e
	dw YoshiSpriteFrame16 ; $4040
	dw YoshiSpriteFrame16 ; $4042
	dw YoshiSpriteFrame16 ; $4044
	dw YoshiSpriteFrame17 ; $4046
	dw YoshiSpriteFrame17 ; $4048
	dw YoshiSpriteFrame18 ; $404a
	dw YoshiSpriteFrame18 ; $404c
	dw YoshiSpriteFrame18 ; $404e
	dw YoshiSpriteFrame19 ; $4050
	dw YoshiSpriteFrame19 ; $4052
	dw YoshiSpriteFrame20 ; $4054
	dw YoshiSpriteFrame20 ; $4056
	dw YoshiSpriteFrame20 ; $4058
	dw YoshiSpriteFrame21 ; $405a
	dw YoshiSpriteFrame21 ; $405c
	dw YoshiSpriteFrame22 ; $405e
	dw YoshiSpriteFrame22 ; $4060
	dw YoshiSpriteFrame22 ; $4062
	dw YoshiSpriteFrame23 ; $4064
	dw YoshiSpriteFrame23 ; $4066
	dw YoshiSpriteFrame24 ; $4068
	dw YoshiSpriteFrame24 ; $406a
	dw YoshiSpriteFrame24 ; $406c
	dw YoshiSpriteFrame25 ; $406e
	dw YoshiSpriteFrame25 ; $4070
	dw YoshiSpriteFrame26 ; $4072
	dw YoshiSpriteFrame26 ; $4074
	dw YoshiSpriteFrame26 ; $4076
	dw YoshiSpriteFrame27 ; $4078
	dw YoshiSpriteFrame27 ; $407a
	dw YoshiSpriteFrame28 ; $407c
	dw YoshiSpriteFrame28 ; $407e
	dw YoshiSpriteFrame28 ; $4080
	dw YoshiSpriteFrame29 ; $4082
	dw YoshiSpriteFrame29 ; $4084
	dw YoshiSpriteFrame30 ; $4086
	dw YoshiSpriteFrame30 ; $4088
	dw YoshiSpriteFrame30 ; $408a
	dw YoshiSpriteFrame31 ; $408c
	dw YoshiSpriteFrame31 ; $408e
	dw YoshiSpriteFrame32 ; $4090
	dw YoshiSpriteFrame32 ; $4092
	dw YoshiSpriteFrame32 ; $4094
	dw YoshiSpriteFrame33 ; $4096
	dw YoshiSpriteFrame33 ; $4098
	dw YoshiSpriteFrame34 ; $409a
	dw YoshiSpriteFrame34 ; $409c
	dw YoshiSpriteFrame34 ; $409e
	dw YoshiSpriteFrame35 ; $40a0
	dw YoshiSpriteFrame35 ; $40a2
	dw YoshiSpriteFrame36 ; $40a4
	dw YoshiSpriteFrame36 ; $40a6
	dw YoshiSpriteFrame36 ; $40a8
	dw YoshiSpriteFrame37 ; $40aa
	dw YoshiSpriteFrame37 ; $40ac
	dw YoshiSpriteFrame38 ; $40ae
	dw YoshiSpriteFrame38 ; $40b0
	dw YoshiSpriteFrame38 ; $40b2
	dw YoshiSpriteFrame39 ; $40b4
	dw YoshiSpriteFrame39 ; $40b6
	dw YoshiSpriteFrame40 ; $40b8
	dw YoshiSpriteFrame40 ; $40ba
	dw YoshiSpriteFrame40 ; $40bc
	dw YoshiSpriteFrame41 ; $40be
	dw YoshiSpriteFrame41 ; $40c0
	dw YoshiSpriteFrame42 ; $40c2
	dw YoshiSpriteFrame42 ; $40c4
	dw YoshiSpriteFrame42 ; $40c6
	dw YoshiSpriteFrame42 ; $40c8
	dw YoshiSpriteFrame42 ; $40ca
	dw YoshiSpriteFrame43 ; $40cc
	dw YoshiSpriteFrame43 ; $40ce
	dw YoshiSpriteFrame43 ; $40d0
	dw YoshiSpriteFrame43 ; $40d2
	dw YoshiSpriteFrame43 ; $40d4
	dw YoshiSpriteFrame44 ; $40d6
	dw YoshiSpriteFrame44 ; $40d8
	dw YoshiSpriteFrame44 ; $40da
	dw YoshiSpriteFrame45 ; $40dc
	dw YoshiSpriteFrame45 ; $40de
	dw YoshiSpriteFrame46 ; $40e0
	dw YoshiSpriteFrame46 ; $40e2
	dw YoshiSpriteFrame46 ; $40e4
	dw YoshiSpriteFrame47 ; $40e6
	dw YoshiSpriteFrame47 ; $40e8
	dw YoshiSpriteFrame48 ; $40ea
	dw YoshiSpriteFrame48 ; $40ec
	dw YoshiSpriteFrame48 ; $40ee
	dw YoshiSpriteFrame49 ; $40f0
	dw YoshiSpriteFrame49 ; $40f2
	dw YoshiSpriteFrame50 ; $40f4
	dw YoshiSpriteFrame50 ; $40f6
	dw YoshiSpriteFrame50 ; $40f8
	dw YoshiSpriteFrame50 ; $40fa
	dw YoshiSpriteFrame50 ; $40fc
	dw YoshiSpriteFrame51 ; $40fe
	dw YoshiSpriteFrame51 ; $4100
	dw YoshiSpriteFrame51 ; $4102
	dw YoshiSpriteFrame51 ; $4104
	dw YoshiSpriteFrame51 ; $4106
	dw YoshiSpriteFrame52 ; $4108
	dw YoshiSpriteFrame52 ; $410a
	dw YoshiSpriteFrame52 ; $410c
	dw YoshiSpriteFrame52 ; $410e
	dw YoshiSpriteFrame52 ; $4110
	dw YoshiSpriteFrame53 ; $4112
	dw YoshiSpriteFrame53 ; $4114
	dw YoshiSpriteFrame53 ; $4116
	dw YoshiSpriteFrame53 ; $4118
	dw YoshiSpriteFrame53 ; $411a
	dw YoshiSpriteFrame54 ; $411c
	dw YoshiSpriteFrame54 ; $411e
	dw YoshiSpriteFrame54 ; $4120
	dw YoshiSpriteFrame54 ; $4122
	dw YoshiSpriteFrame54 ; $4124
	dw YoshiSpriteFrame55 ; $4126
	dw YoshiSpriteFrame55 ; $4128
	dw YoshiSpriteFrame55 ; $412a
	dw YoshiSpriteFrame55 ; $412c
	dw YoshiSpriteFrame55 ; $412e
YoshiSpriteFrame00:
	INCBIN "data/bank_052/d_4130.bin" ; $4130, 240 bytes
YoshiSpriteFrame01:
	INCBIN "data/bank_052/d_4220.bin" ; $4220, 240 bytes
YoshiSpriteFrame02:
	INCBIN "data/bank_052/d_4310.bin" ; $4310, 240 bytes
YoshiSpriteFrame03:
	INCBIN "data/bank_052/d_4400.bin" ; $4400, 240 bytes
YoshiSpriteFrame04:
	INCBIN "data/bank_052/d_44f0.bin" ; $44f0, 240 bytes
YoshiSpriteFrame05:
	INCBIN "data/bank_052/d_45e0.bin" ; $45e0, 240 bytes
YoshiSpriteFrame06:
	INCBIN "data/bank_052/d_46d0.bin" ; $46d0, 240 bytes
YoshiSpriteFrame07:
	INCBIN "data/bank_052/d_47c0.bin" ; $47c0, 240 bytes
YoshiSpriteFrame08:
	INCBIN "data/bank_052/d_48b0.bin" ; $48b0, 240 bytes
YoshiSpriteFrame09:
	INCBIN "data/bank_052/d_49a0.bin" ; $49a0, 240 bytes
YoshiSpriteFrame10:
	INCBIN "data/bank_052/d_4a90.bin" ; $4a90, 240 bytes
YoshiSpriteFrame11:
	INCBIN "data/bank_052/d_4b80.bin" ; $4b80, 240 bytes
YoshiSpriteFrame12:
	INCBIN "data/bank_052/d_4c70.bin" ; $4c70, 240 bytes
YoshiSpriteFrame13:
	INCBIN "data/bank_052/d_4d60.bin" ; $4d60, 240 bytes
YoshiSpriteFrame14:
	INCBIN "data/bank_052/d_4e50.bin" ; $4e50, 240 bytes
YoshiSpriteFrame15:
	INCBIN "data/bank_052/d_4f40.bin" ; $4f40, 240 bytes
YoshiSpriteFrame16:
	INCBIN "data/bank_052/d_5030.bin" ; $5030, 240 bytes
YoshiSpriteFrame17:
	INCBIN "data/bank_052/d_5120.bin" ; $5120, 240 bytes
YoshiSpriteFrame18:
	INCBIN "data/bank_052/d_5210.bin" ; $5210, 240 bytes
YoshiSpriteFrame19:
	INCBIN "data/bank_052/d_5300.bin" ; $5300, 240 bytes
YoshiSpriteFrame20:
	INCBIN "data/bank_052/d_53f0.bin" ; $53f0, 240 bytes
YoshiSpriteFrame21:
	INCBIN "data/bank_052/d_54e0.bin" ; $54e0, 240 bytes
YoshiSpriteFrame22:
	INCBIN "data/bank_052/d_55d0.bin" ; $55d0, 240 bytes
YoshiSpriteFrame23:
	INCBIN "data/bank_052/d_56c0.bin" ; $56c0, 240 bytes
YoshiSpriteFrame24:
	INCBIN "data/bank_052/d_57b0.bin" ; $57b0, 240 bytes
YoshiSpriteFrame25:
	INCBIN "data/bank_052/d_58a0.bin" ; $58a0, 240 bytes
YoshiSpriteFrame26:
	INCBIN "data/bank_052/d_5990.bin" ; $5990, 240 bytes
YoshiSpriteFrame27:
	INCBIN "data/bank_052/d_5a80.bin" ; $5a80, 240 bytes
YoshiSpriteFrame28:
	INCBIN "data/bank_052/d_5b70.bin" ; $5b70, 240 bytes
YoshiSpriteFrame29:
	INCBIN "data/bank_052/d_5c60.bin" ; $5c60, 240 bytes
YoshiSpriteFrame30:
	INCBIN "data/bank_052/d_5d50.bin" ; $5d50, 240 bytes
YoshiSpriteFrame31:
	INCBIN "data/bank_052/d_5e40.bin" ; $5e40, 240 bytes
YoshiSpriteFrame32:
	INCBIN "data/bank_052/d_5f30.bin" ; $5f30, 240 bytes
YoshiSpriteFrame33:
	INCBIN "data/bank_052/d_6020.bin" ; $6020, 240 bytes
YoshiSpriteFrame34:
	INCBIN "data/bank_052/d_6110.bin" ; $6110, 240 bytes
YoshiSpriteFrame35:
	INCBIN "data/bank_052/d_6200.bin" ; $6200, 240 bytes
YoshiSpriteFrame36:
	INCBIN "data/bank_052/d_62f0.bin" ; $62f0, 240 bytes
YoshiSpriteFrame37:
	INCBIN "data/bank_052/d_63e0.bin" ; $63e0, 240 bytes
YoshiSpriteFrame38:
	INCBIN "data/bank_052/d_64d0.bin" ; $64d0, 240 bytes
YoshiSpriteFrame39:
	INCBIN "data/bank_052/d_65c0.bin" ; $65c0, 240 bytes
YoshiSpriteFrame40:
	INCBIN "data/bank_052/d_66b0.bin" ; $66b0, 320 bytes
YoshiSpriteFrame41:
	INCBIN "data/bank_052/d_67f0.bin" ; $67f0, 320 bytes
YoshiSpriteFrame42:
	INCBIN "data/bank_052/d_6930.bin" ; $6930, 240 bytes
YoshiSpriteFrame43:
	INCBIN "data/bank_052/d_6a20.bin" ; $6a20, 240 bytes
YoshiSpriteFrame44:
	INCBIN "data/bank_052/d_6b10.bin" ; $6b10, 240 bytes
YoshiSpriteFrame45:
	INCBIN "data/bank_052/d_6c00.bin" ; $6c00, 240 bytes
YoshiSpriteFrame46:
	INCBIN "data/bank_052/d_6cf0.bin" ; $6cf0, 240 bytes
YoshiSpriteFrame47:
	INCBIN "data/bank_052/d_6de0.bin" ; $6de0, 240 bytes
YoshiSpriteFrame48:
	INCBIN "data/bank_052/d_6ed0.bin" ; $6ed0, 240 bytes
YoshiSpriteFrame49:
	INCBIN "data/bank_052/d_6fc0.bin" ; $6fc0, 240 bytes
YoshiSpriteFrame50:
	INCBIN "data/bank_052/d_70b0.bin" ; $70b0, 240 bytes
YoshiSpriteFrame51:
	INCBIN "data/bank_052/d_71a0.bin" ; $71a0, 240 bytes
YoshiSpriteFrame52:
	INCBIN "data/bank_052/d_7290.bin" ; $7290, 240 bytes
YoshiSpriteFrame53:
	INCBIN "data/bank_052/d_7380.bin" ; $7380, 240 bytes
YoshiSpriteFrame54:
	INCBIN "data/bank_052/d_7470.bin" ; $7470, 240 bytes
YoshiSpriteFrame55:
	INCBIN "data/bank_052/d_7560.bin" ; $7560, 240 bytes
YoshiSpriteFramesUnused:
	INCBIN "data/bank_052/d_7650.bin" ; $7650, 1680 bytes
YoshiSpriteOam:
	INCBIN "data/bank_052/d_7ce0.bin" ; $7ce0, 580 bytes
YoshiSpriteAnims:
	dw YoshiSpriteAnim00 ; $7f24
	dw YoshiSpriteAnim01 ; $7f26
	dw YoshiSpriteAnim02 ; $7f28
	dw YoshiSpriteAnim03 ; $7f2a
	dw YoshiSpriteAnim04 ; $7f2c
	dw YoshiSpriteAnim05 ; $7f2e
	dw YoshiSpriteAnim06 ; $7f30
	dw YoshiSpriteAnim07 ; $7f32
	dw YoshiSpriteAnim08 ; $7f34
	dw YoshiSpriteAnim09 ; $7f36
	dw YoshiSpriteAnim10 ; $7f38
	dw YoshiSpriteAnim11 ; $7f3a
	dw YoshiSpriteAnim12 ; $7f3c
	dw YoshiSpriteAnim13 ; $7f3e
	dw YoshiSpriteAnim14 ; $7f40
	dw YoshiSpriteAnim15 ; $7f42
	dw YoshiSpriteAnim16 ; $7f44
	dw YoshiSpriteAnim17 ; $7f46
	dw YoshiSpriteAnim18 ; $7f48
YoshiSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	db $00
	db $ff, $fd
YoshiSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
YoshiSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
YoshiSpriteAnim03:
	; $7f5d, 16 bytes (sprite_anim)
	anim_frame $17, $0a
	anim_frame $18, $0a
	anim_frame $19, $08
	anim_frame $18, $08
	anim_frame $19, $08
	anim_frame $19, $08
	anim_frame $18, $08
	anim_loop $00
YoshiSpriteAnim04:
	; $7f6d, 10 bytes (sprite_anim)
	anim_frame $1a, $28
	anim_frame $1b, $08
	anim_frame $1c, $14
	anim_frame $1b, $04
	anim_loop $00
YoshiSpriteAnim05:
	; $7f77, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
YoshiSpriteAnim06:
	; $7f7d, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
YoshiSpriteAnim07:
	; $7f83, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
YoshiSpriteAnim08:
	; $7f89, 5 bytes (sprite_anim)
	db $15, $04, $16, $14, $fd
YoshiSpriteAnim09:
	; $7f8e, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
YoshiSpriteAnim10:
	; $7f92, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
YoshiSpriteAnim11:
	; $7f96, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
YoshiSpriteAnim12:
	; $7f9a, 3 bytes (sprite_anim)
	db $15, $18, $fd
YoshiSpriteAnim13:
	; $7f9d, 3 bytes (sprite_anim)
	db $05, $ff, $fd
YoshiSpriteAnim14:
	; $7fa0, 3 bytes (sprite_anim)
	db $08, $ff, $fd
YoshiSpriteAnim15:
	; $7fa3, 3 bytes (sprite_anim)
	db $0b, $ff, $fd
YoshiSpriteAnim16:
	; $7fa6, 3 bytes (sprite_anim)
	db $0e, $ff, $fd
YoshiSpriteAnim17:
	; $7fa9, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
YoshiSpriteAnim18:
	; $7fb5, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fbd, 67 bytes fill to bank end (linker-padded)
