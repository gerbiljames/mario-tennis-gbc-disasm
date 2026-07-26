SECTION "ROM Bank $40", ROMX[$4000], BANK[$40]

	dw AlexSpriteDesc ; $4000
AlexSpriteDesc:
	dw $0006 ; $4002
	dw $0003 ; $4004
	dw AlexSpriteFrames ; $4006 frame table
	dw AlexSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw AlexSpriteOam ; $400c per-slot OAM data
AlexSpriteFrames:
	dw AlexSpriteFrame00 ; $400e
	dw AlexSpriteFrame01 ; $4010
	dw AlexSpriteFrame02 ; $4012
	dw AlexSpriteFrame03 ; $4014
	dw AlexSpriteFrame04 ; $4016
	dw AlexSpriteFrame05 ; $4018
	dw AlexSpriteFrame06 ; $401a
	dw AlexSpriteFrame07 ; $401c
	dw AlexSpriteFrame08 ; $401e
	dw AlexSpriteFrame09 ; $4020
	dw AlexSpriteFrame10 ; $4022
	dw AlexSpriteFrame01 ; $4024
	dw AlexSpriteFrame02 ; $4026
	dw AlexSpriteFrame03 ; $4028
	dw AlexSpriteFrame11 ; $402a
	dw AlexSpriteFrame12 ; $402c
	dw AlexSpriteFrame01 ; $402e
	dw AlexSpriteFrame02 ; $4030
	dw AlexSpriteFrame03 ; $4032
	dw AlexSpriteFrame13 ; $4034
	dw AlexSpriteFrame14 ; $4036
	dw AlexSpriteFrame06 ; $4038
	dw AlexSpriteFrame07 ; $403a
	dw AlexSpriteFrame08 ; $403c
	dw AlexSpriteFrame15 ; $403e
	dw AlexSpriteFrame16 ; $4040
	dw AlexSpriteFrame16 ; $4042
	dw AlexSpriteFrame16 ; $4044
	dw AlexSpriteFrame17 ; $4046
	dw AlexSpriteFrame17 ; $4048
	dw AlexSpriteFrame18 ; $404a
	dw AlexSpriteFrame18 ; $404c
	dw AlexSpriteFrame18 ; $404e
	dw AlexSpriteFrame19 ; $4050
	dw AlexSpriteFrame19 ; $4052
	dw AlexSpriteFrame20 ; $4054
	dw AlexSpriteFrame20 ; $4056
	dw AlexSpriteFrame20 ; $4058
	dw AlexSpriteFrame21 ; $405a
	dw AlexSpriteFrame21 ; $405c
	dw AlexSpriteFrame22 ; $405e
	dw AlexSpriteFrame22 ; $4060
	dw AlexSpriteFrame22 ; $4062
	dw AlexSpriteFrame23 ; $4064
	dw AlexSpriteFrame23 ; $4066
	dw AlexSpriteFrame24 ; $4068
	dw AlexSpriteFrame24 ; $406a
	dw AlexSpriteFrame24 ; $406c
	dw AlexSpriteFrame25 ; $406e
	dw AlexSpriteFrame25 ; $4070
	dw AlexSpriteFrame26 ; $4072
	dw AlexSpriteFrame26 ; $4074
	dw AlexSpriteFrame26 ; $4076
	dw AlexSpriteFrame27 ; $4078
	dw AlexSpriteFrame27 ; $407a
	dw AlexSpriteFrame28 ; $407c
	dw AlexSpriteFrame28 ; $407e
	dw AlexSpriteFrame28 ; $4080
	dw AlexSpriteFrame29 ; $4082
	dw AlexSpriteFrame29 ; $4084
	dw AlexSpriteFrame30 ; $4086
	dw AlexSpriteFrame30 ; $4088
	dw AlexSpriteFrame30 ; $408a
	dw AlexSpriteFrame31 ; $408c
	dw AlexSpriteFrame31 ; $408e
	dw AlexSpriteFrame32 ; $4090
	dw AlexSpriteFrame32 ; $4092
	dw AlexSpriteFrame32 ; $4094
	dw AlexSpriteFrame33 ; $4096
	dw AlexSpriteFrame33 ; $4098
	dw AlexSpriteFrame34 ; $409a
	dw AlexSpriteFrame34 ; $409c
	dw AlexSpriteFrame34 ; $409e
	dw AlexSpriteFrame35 ; $40a0
	dw AlexSpriteFrame35 ; $40a2
	dw AlexSpriteFrame36 ; $40a4
	dw AlexSpriteFrame36 ; $40a6
	dw AlexSpriteFrame36 ; $40a8
	dw AlexSpriteFrame37 ; $40aa
	dw AlexSpriteFrame37 ; $40ac
	dw AlexSpriteFrame38 ; $40ae
	dw AlexSpriteFrame38 ; $40b0
	dw AlexSpriteFrame38 ; $40b2
	dw AlexSpriteFrame39 ; $40b4
	dw AlexSpriteFrame39 ; $40b6
	dw AlexSpriteFrame40 ; $40b8
	dw AlexSpriteFrame40 ; $40ba
	dw AlexSpriteFrame40 ; $40bc
	dw AlexSpriteFrame41 ; $40be
	dw AlexSpriteFrame41 ; $40c0
	dw AlexSpriteFrame42 ; $40c2
	dw AlexSpriteFrame42 ; $40c4
	dw AlexSpriteFrame42 ; $40c6
	dw AlexSpriteFrame42 ; $40c8
	dw AlexSpriteFrame42 ; $40ca
	dw AlexSpriteFrame43 ; $40cc
	dw AlexSpriteFrame43 ; $40ce
	dw AlexSpriteFrame43 ; $40d0
	dw AlexSpriteFrame43 ; $40d2
	dw AlexSpriteFrame43 ; $40d4
	dw AlexSpriteFrame44 ; $40d6
	dw AlexSpriteFrame44 ; $40d8
	dw AlexSpriteFrame44 ; $40da
	dw AlexSpriteFrame45 ; $40dc
	dw AlexSpriteFrame45 ; $40de
	dw AlexSpriteFrame46 ; $40e0
	dw AlexSpriteFrame46 ; $40e2
	dw AlexSpriteFrame46 ; $40e4
	dw AlexSpriteFrame47 ; $40e6
	dw AlexSpriteFrame47 ; $40e8
	dw AlexSpriteFrame48 ; $40ea
	dw AlexSpriteFrame48 ; $40ec
	dw AlexSpriteFrame48 ; $40ee
	dw AlexSpriteFrame49 ; $40f0
	dw AlexSpriteFrame49 ; $40f2
	dw AlexSpriteFrame50 ; $40f4
	dw AlexSpriteFrame50 ; $40f6
	dw AlexSpriteFrame50 ; $40f8
	dw AlexSpriteFrame50 ; $40fa
	dw AlexSpriteFrame50 ; $40fc
	dw AlexSpriteFrame51 ; $40fe
	dw AlexSpriteFrame51 ; $4100
	dw AlexSpriteFrame51 ; $4102
	dw AlexSpriteFrame51 ; $4104
	dw AlexSpriteFrame51 ; $4106
	dw AlexSpriteFrame52 ; $4108
	dw AlexSpriteFrame52 ; $410a
	dw AlexSpriteFrame52 ; $410c
	dw AlexSpriteFrame52 ; $410e
	dw AlexSpriteFrame52 ; $4110
	dw AlexSpriteFrame53 ; $4112
	dw AlexSpriteFrame53 ; $4114
	dw AlexSpriteFrame53 ; $4116
	dw AlexSpriteFrame53 ; $4118
	dw AlexSpriteFrame53 ; $411a
	dw AlexSpriteFrame54 ; $411c
	dw AlexSpriteFrame54 ; $411e
	dw AlexSpriteFrame54 ; $4120
	dw AlexSpriteFrame54 ; $4122
	dw AlexSpriteFrame54 ; $4124
	dw AlexSpriteFrame55 ; $4126
	dw AlexSpriteFrame55 ; $4128
	dw AlexSpriteFrame55 ; $412a
	dw AlexSpriteFrame55 ; $412c
	dw AlexSpriteFrame55 ; $412e
AlexSpriteFrame00:
	INCBIN "data/bank_040/d_4130.bin" ; $4130, 240 bytes
AlexSpriteFrame01:
	INCBIN "data/bank_040/d_4220.bin" ; $4220, 240 bytes
AlexSpriteFrame02:
	INCBIN "data/bank_040/d_4310.bin" ; $4310, 240 bytes
AlexSpriteFrame03:
	INCBIN "data/bank_040/d_4400.bin" ; $4400, 240 bytes
AlexSpriteFrame04:
	INCBIN "data/bank_040/d_44f0.bin" ; $44f0, 240 bytes
AlexSpriteFrame05:
	INCBIN "data/bank_040/d_45e0.bin" ; $45e0, 240 bytes
AlexSpriteFrame06:
	INCBIN "data/bank_040/d_46d0.bin" ; $46d0, 240 bytes
AlexSpriteFrame07:
	INCBIN "data/bank_040/d_47c0.bin" ; $47c0, 240 bytes
AlexSpriteFrame08:
	INCBIN "data/bank_040/d_48b0.bin" ; $48b0, 240 bytes
AlexSpriteFrame09:
	INCBIN "data/bank_040/d_49a0.bin" ; $49a0, 240 bytes
AlexSpriteFrame10:
	INCBIN "data/bank_040/d_4a90.bin" ; $4a90, 240 bytes
AlexSpriteFrame11:
	INCBIN "data/bank_040/d_4b80.bin" ; $4b80, 240 bytes
AlexSpriteFrame12:
	INCBIN "data/bank_040/d_4c70.bin" ; $4c70, 240 bytes
AlexSpriteFrame13:
	INCBIN "data/bank_040/d_4d60.bin" ; $4d60, 240 bytes
AlexSpriteFrame14:
	INCBIN "data/bank_040/d_4e50.bin" ; $4e50, 240 bytes
AlexSpriteFrame15:
	INCBIN "data/bank_040/d_4f40.bin" ; $4f40, 240 bytes
AlexSpriteFrame16:
	INCBIN "data/bank_040/d_5030.bin" ; $5030, 240 bytes
AlexSpriteFrame17:
	INCBIN "data/bank_040/d_5120.bin" ; $5120, 240 bytes
AlexSpriteFrame18:
	INCBIN "data/bank_040/d_5210.bin" ; $5210, 240 bytes
AlexSpriteFrame19:
	INCBIN "data/bank_040/d_5300.bin" ; $5300, 240 bytes
AlexSpriteFrame20:
	INCBIN "data/bank_040/d_53f0.bin" ; $53f0, 240 bytes
AlexSpriteFrame21:
	INCBIN "data/bank_040/d_54e0.bin" ; $54e0, 240 bytes
AlexSpriteFrame22:
	INCBIN "data/bank_040/d_55d0.bin" ; $55d0, 240 bytes
AlexSpriteFrame23:
	INCBIN "data/bank_040/d_56c0.bin" ; $56c0, 240 bytes
AlexSpriteFrame24:
	INCBIN "data/bank_040/d_57b0.bin" ; $57b0, 240 bytes
AlexSpriteFrame25:
	INCBIN "data/bank_040/d_58a0.bin" ; $58a0, 240 bytes
AlexSpriteFrame26:
	INCBIN "data/bank_040/d_5990.bin" ; $5990, 240 bytes
AlexSpriteFrame27:
	INCBIN "data/bank_040/d_5a80.bin" ; $5a80, 240 bytes
AlexSpriteFrame28:
	INCBIN "data/bank_040/d_5b70.bin" ; $5b70, 240 bytes
AlexSpriteFrame29:
	INCBIN "data/bank_040/d_5c60.bin" ; $5c60, 240 bytes
AlexSpriteFrame30:
	INCBIN "data/bank_040/d_5d50.bin" ; $5d50, 240 bytes
AlexSpriteFrame31:
	INCBIN "data/bank_040/d_5e40.bin" ; $5e40, 240 bytes
AlexSpriteFrame32:
	INCBIN "data/bank_040/d_5f30.bin" ; $5f30, 240 bytes
AlexSpriteFrame33:
	INCBIN "data/bank_040/d_6020.bin" ; $6020, 240 bytes
AlexSpriteFrame34:
	INCBIN "data/bank_040/d_6110.bin" ; $6110, 240 bytes
AlexSpriteFrame35:
	INCBIN "data/bank_040/d_6200.bin" ; $6200, 240 bytes
AlexSpriteFrame36:
	INCBIN "data/bank_040/d_62f0.bin" ; $62f0, 240 bytes
AlexSpriteFrame37:
	INCBIN "data/bank_040/d_63e0.bin" ; $63e0, 240 bytes
AlexSpriteFrame38:
	INCBIN "data/bank_040/d_64d0.bin" ; $64d0, 240 bytes
AlexSpriteFrame39:
	INCBIN "data/bank_040/d_65c0.bin" ; $65c0, 240 bytes
AlexSpriteFrame40:
	INCBIN "data/bank_040/d_66b0.bin" ; $66b0, 320 bytes
AlexSpriteFrame41:
	INCBIN "data/bank_040/d_67f0.bin" ; $67f0, 320 bytes
AlexSpriteFrame42:
	INCBIN "data/bank_040/d_6930.bin" ; $6930, 240 bytes
AlexSpriteFrame43:
	INCBIN "data/bank_040/d_6a20.bin" ; $6a20, 240 bytes
AlexSpriteFrame44:
	INCBIN "data/bank_040/d_6b10.bin" ; $6b10, 240 bytes
AlexSpriteFrame45:
	INCBIN "data/bank_040/d_6c00.bin" ; $6c00, 240 bytes
AlexSpriteFrame46:
	INCBIN "data/bank_040/d_6cf0.bin" ; $6cf0, 240 bytes
AlexSpriteFrame47:
	INCBIN "data/bank_040/d_6de0.bin" ; $6de0, 240 bytes
AlexSpriteFrame48:
	INCBIN "data/bank_040/d_6ed0.bin" ; $6ed0, 240 bytes
AlexSpriteFrame49:
	INCBIN "data/bank_040/d_6fc0.bin" ; $6fc0, 240 bytes
AlexSpriteFrame50:
	INCBIN "data/bank_040/d_70b0.bin" ; $70b0, 240 bytes
AlexSpriteFrame51:
	INCBIN "data/bank_040/d_71a0.bin" ; $71a0, 240 bytes
AlexSpriteFrame52:
	INCBIN "data/bank_040/d_7290.bin" ; $7290, 240 bytes
AlexSpriteFrame53:
	INCBIN "data/bank_040/d_7380.bin" ; $7380, 240 bytes
AlexSpriteFrame54:
	INCBIN "data/bank_040/d_7470.bin" ; $7470, 240 bytes
AlexSpriteFrame55:
	INCBIN "data/bank_040/d_7560.bin" ; $7560, 240 bytes
AlexSpriteFramesUnused:
	INCBIN "data/bank_040/d_7650.bin" ; $7650, 1680 bytes
AlexSpriteOam:
	INCBIN "data/bank_040/d_7ce0.bin" ; $7ce0, 580 bytes
AlexSpriteAnims:
	dw AlexSpriteAnim00 ; $7f24
	dw AlexSpriteAnim01 ; $7f26
	dw AlexSpriteAnim02 ; $7f28
	dw AlexSpriteAnim03 ; $7f2a
	dw AlexSpriteAnim04 ; $7f2c
	dw AlexSpriteAnim05 ; $7f2e
	dw AlexSpriteAnim06 ; $7f30
	dw AlexSpriteAnim07 ; $7f32
	dw AlexSpriteAnim08 ; $7f34
	dw AlexSpriteAnim09 ; $7f36
	dw AlexSpriteAnim10 ; $7f38
	dw AlexSpriteAnim11 ; $7f3a
	dw AlexSpriteAnim12 ; $7f3c
	dw AlexSpriteAnim13 ; $7f3e
	dw AlexSpriteAnim14 ; $7f40
	dw AlexSpriteAnim15 ; $7f42
	dw AlexSpriteAnim16 ; $7f44
	dw AlexSpriteAnim17 ; $7f46
	dw AlexSpriteAnim18 ; $7f48
AlexSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	db $00
	db $ff, $fd
AlexSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
AlexSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
AlexSpriteAnim03:
	; $7f5d, 34 bytes (sprite_anim)
	anim_flip $20
	anim_frame $17, $14
	anim_frame $18, $0a
	anim_frame $19, $08
	anim_frame $18, $08
	anim_frame $19, $08
	anim_frame $19, $08
	anim_frame $18, $08
	anim_flip $00
	anim_frame $17, $14
	anim_frame $18, $0a
	anim_frame $19, $08
	anim_frame $18, $08
	anim_frame $19, $08
	anim_frame $19, $08
	anim_frame $18, $08
	anim_loop $00
AlexSpriteAnim04:
	; $7f7f, 10 bytes (sprite_anim)
	anim_frame $1a, $0a
	anim_frame $1b, $0a
	anim_frame $1c, $0a
	anim_frame $1b, $0a
	anim_loop $00
AlexSpriteAnim05:
	; $7f89, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
AlexSpriteAnim06:
	; $7f8f, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
AlexSpriteAnim07:
	; $7f95, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
AlexSpriteAnim08:
	; $7f9b, 5 bytes (sprite_anim)
	db $15, $04, $16, $14, $fd
AlexSpriteAnim09:
	; $7fa0, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
AlexSpriteAnim10:
	; $7fa4, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
AlexSpriteAnim11:
	; $7fa8, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
AlexSpriteAnim12:
	; $7fac, 3 bytes (sprite_anim)
	db $15, $18, $fd
AlexSpriteAnim13:
	; $7faf, 3 bytes (sprite_anim)
	db $05, $ff, $fd
AlexSpriteAnim14:
	; $7fb2, 3 bytes (sprite_anim)
	db $08, $ff, $fd
AlexSpriteAnim15:
	; $7fb5, 3 bytes (sprite_anim)
	db $0b, $ff, $fd
AlexSpriteAnim16:
	; $7fb8, 3 bytes (sprite_anim)
	db $0e, $ff, $fd
AlexSpriteAnim17:
	; $7fbb, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
AlexSpriteAnim18:
	; $7fc7, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fcf, 49 bytes fill to bank end (linker-padded)
