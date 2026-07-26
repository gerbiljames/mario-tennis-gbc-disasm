SECTION "ROM Bank $53", ROMX[$4000], BANK[$53]

	dw BowserSpriteDesc ; $4000
BowserSpriteDesc:
	dw $0005 ; $4002
	dw $0003 ; $4004
	dw BowserSpriteFrames ; $4006 frame table
	dw BowserSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw BowserSpriteOam ; $400c per-slot OAM data
BowserSpriteFrames:
	dw BowserSpriteFrame00 ; $400e
	dw BowserSpriteFrame01 ; $4010
	dw BowserSpriteFrame02 ; $4012
	dw BowserSpriteFrame03 ; $4014
	dw BowserSpriteFrame04 ; $4016
	dw BowserSpriteFrame05 ; $4018
	dw BowserSpriteFrame06 ; $401a
	dw BowserSpriteFrame07 ; $401c
	dw BowserSpriteFrame08 ; $401e
	dw BowserSpriteFrame09 ; $4020
	dw BowserSpriteFrame10 ; $4022
	dw BowserSpriteFrame01 ; $4024
	dw BowserSpriteFrame02 ; $4026
	dw BowserSpriteFrame03 ; $4028
	dw BowserSpriteFrame11 ; $402a
	dw BowserSpriteFrame12 ; $402c
	dw BowserSpriteFrame01 ; $402e
	dw BowserSpriteFrame02 ; $4030
	dw BowserSpriteFrame03 ; $4032
	dw BowserSpriteFrame13 ; $4034
	dw BowserSpriteFrame14 ; $4036
	dw BowserSpriteFrame06 ; $4038
	dw BowserSpriteFrame07 ; $403a
	dw BowserSpriteFrame08 ; $403c
	dw BowserSpriteFrame15 ; $403e
	dw BowserSpriteFrame16 ; $4040
	dw BowserSpriteFrame16 ; $4042
	dw BowserSpriteFrame16 ; $4044
	dw BowserSpriteFrame17 ; $4046
	dw BowserSpriteFrame17 ; $4048
	dw BowserSpriteFrame18 ; $404a
	dw BowserSpriteFrame18 ; $404c
	dw BowserSpriteFrame18 ; $404e
	dw BowserSpriteFrame19 ; $4050
	dw BowserSpriteFrame19 ; $4052
	dw BowserSpriteFrame20 ; $4054
	dw BowserSpriteFrame20 ; $4056
	dw BowserSpriteFrame20 ; $4058
	dw BowserSpriteFrame21 ; $405a
	dw BowserSpriteFrame21 ; $405c
	dw BowserSpriteFrame22 ; $405e
	dw BowserSpriteFrame22 ; $4060
	dw BowserSpriteFrame22 ; $4062
	dw BowserSpriteFrame23 ; $4064
	dw BowserSpriteFrame23 ; $4066
	dw BowserSpriteFrame24 ; $4068
	dw BowserSpriteFrame24 ; $406a
	dw BowserSpriteFrame24 ; $406c
	dw BowserSpriteFrame25 ; $406e
	dw BowserSpriteFrame25 ; $4070
	dw BowserSpriteFrame26 ; $4072
	dw BowserSpriteFrame26 ; $4074
	dw BowserSpriteFrame26 ; $4076
	dw BowserSpriteFrame27 ; $4078
	dw BowserSpriteFrame27 ; $407a
	dw BowserSpriteFrame28 ; $407c
	dw BowserSpriteFrame28 ; $407e
	dw BowserSpriteFrame28 ; $4080
	dw BowserSpriteFrame29 ; $4082
	dw BowserSpriteFrame29 ; $4084
	dw BowserSpriteFrame30 ; $4086
	dw BowserSpriteFrame30 ; $4088
	dw BowserSpriteFrame30 ; $408a
	dw BowserSpriteFrame31 ; $408c
	dw BowserSpriteFrame31 ; $408e
	dw BowserSpriteFrame32 ; $4090
	dw BowserSpriteFrame32 ; $4092
	dw BowserSpriteFrame32 ; $4094
	dw BowserSpriteFrame33 ; $4096
	dw BowserSpriteFrame33 ; $4098
	dw BowserSpriteFrame34 ; $409a
	dw BowserSpriteFrame34 ; $409c
	dw BowserSpriteFrame34 ; $409e
	dw BowserSpriteFrame35 ; $40a0
	dw BowserSpriteFrame35 ; $40a2
	dw BowserSpriteFrame36 ; $40a4
	dw BowserSpriteFrame36 ; $40a6
	dw BowserSpriteFrame36 ; $40a8
	dw BowserSpriteFrame37 ; $40aa
	dw BowserSpriteFrame37 ; $40ac
	dw BowserSpriteFrame38 ; $40ae
	dw BowserSpriteFrame38 ; $40b0
	dw BowserSpriteFrame38 ; $40b2
	dw BowserSpriteFrame39 ; $40b4
	dw BowserSpriteFrame39 ; $40b6
	dw BowserSpriteFrame40 ; $40b8
	dw BowserSpriteFrame40 ; $40ba
	dw BowserSpriteFrame40 ; $40bc
	dw BowserSpriteFrame41 ; $40be
	dw BowserSpriteFrame41 ; $40c0
	dw BowserSpriteFrame42 ; $40c2
	dw BowserSpriteFrame42 ; $40c4
	dw BowserSpriteFrame42 ; $40c6
	dw BowserSpriteFrame42 ; $40c8
	dw BowserSpriteFrame42 ; $40ca
	dw BowserSpriteFrame43 ; $40cc
	dw BowserSpriteFrame43 ; $40ce
	dw BowserSpriteFrame43 ; $40d0
	dw BowserSpriteFrame43 ; $40d2
	dw BowserSpriteFrame43 ; $40d4
	dw BowserSpriteFrame44 ; $40d6
	dw BowserSpriteFrame44 ; $40d8
	dw BowserSpriteFrame44 ; $40da
	dw BowserSpriteFrame45 ; $40dc
	dw BowserSpriteFrame45 ; $40de
	dw BowserSpriteFrame46 ; $40e0
	dw BowserSpriteFrame46 ; $40e2
	dw BowserSpriteFrame46 ; $40e4
	dw BowserSpriteFrame47 ; $40e6
	dw BowserSpriteFrame47 ; $40e8
	dw BowserSpriteFrame48 ; $40ea
	dw BowserSpriteFrame48 ; $40ec
	dw BowserSpriteFrame48 ; $40ee
	dw BowserSpriteFrame49 ; $40f0
	dw BowserSpriteFrame49 ; $40f2
	dw BowserSpriteFrame50 ; $40f4
	dw BowserSpriteFrame50 ; $40f6
	dw BowserSpriteFrame50 ; $40f8
	dw BowserSpriteFrame50 ; $40fa
	dw BowserSpriteFrame50 ; $40fc
	dw BowserSpriteFrame51 ; $40fe
	dw BowserSpriteFrame51 ; $4100
	dw BowserSpriteFrame51 ; $4102
	dw BowserSpriteFrame51 ; $4104
	dw BowserSpriteFrame51 ; $4106
	dw BowserSpriteFrame52 ; $4108
	dw BowserSpriteFrame52 ; $410a
	dw BowserSpriteFrame52 ; $410c
	dw BowserSpriteFrame52 ; $410e
	dw BowserSpriteFrame52 ; $4110
	dw BowserSpriteFrame53 ; $4112
	dw BowserSpriteFrame53 ; $4114
	dw BowserSpriteFrame53 ; $4116
	dw BowserSpriteFrame53 ; $4118
	dw BowserSpriteFrame53 ; $411a
	dw BowserSpriteFrame54 ; $411c
	dw BowserSpriteFrame54 ; $411e
	dw BowserSpriteFrame54 ; $4120
	dw BowserSpriteFrame54 ; $4122
	dw BowserSpriteFrame54 ; $4124
	dw BowserSpriteFrame55 ; $4126
	dw BowserSpriteFrame55 ; $4128
	dw BowserSpriteFrame55 ; $412a
	dw BowserSpriteFrame55 ; $412c
	dw BowserSpriteFrame55 ; $412e
BowserSpriteFrame00:
	INCBIN "data/bank_053/d_4130.bin" ; $4130, 240 bytes
BowserSpriteFrame01:
	INCBIN "data/bank_053/d_4220.bin" ; $4220, 240 bytes
BowserSpriteFrame02:
	INCBIN "data/bank_053/d_4310.bin" ; $4310, 240 bytes
BowserSpriteFrame03:
	INCBIN "data/bank_053/d_4400.bin" ; $4400, 240 bytes
BowserSpriteFrame04:
	INCBIN "data/bank_053/d_44f0.bin" ; $44f0, 240 bytes
BowserSpriteFrame05:
	INCBIN "data/bank_053/d_45e0.bin" ; $45e0, 240 bytes
BowserSpriteFrame06:
	INCBIN "data/bank_053/d_46d0.bin" ; $46d0, 240 bytes
BowserSpriteFrame07:
	INCBIN "data/bank_053/d_47c0.bin" ; $47c0, 240 bytes
BowserSpriteFrame08:
	INCBIN "data/bank_053/d_48b0.bin" ; $48b0, 240 bytes
BowserSpriteFrame09:
	INCBIN "data/bank_053/d_49a0.bin" ; $49a0, 240 bytes
BowserSpriteFrame10:
	INCBIN "data/bank_053/d_4a90.bin" ; $4a90, 240 bytes
BowserSpriteFrame11:
	INCBIN "data/bank_053/d_4b80.bin" ; $4b80, 240 bytes
BowserSpriteFrame12:
	INCBIN "data/bank_053/d_4c70.bin" ; $4c70, 240 bytes
BowserSpriteFrame13:
	INCBIN "data/bank_053/d_4d60.bin" ; $4d60, 240 bytes
BowserSpriteFrame14:
	INCBIN "data/bank_053/d_4e50.bin" ; $4e50, 240 bytes
BowserSpriteFrame15:
	INCBIN "data/bank_053/d_4f40.bin" ; $4f40, 240 bytes
BowserSpriteFrame16:
	INCBIN "data/bank_053/d_5030.bin" ; $5030, 240 bytes
BowserSpriteFrame17:
	INCBIN "data/bank_053/d_5120.bin" ; $5120, 240 bytes
BowserSpriteFrame18:
	INCBIN "data/bank_053/d_5210.bin" ; $5210, 240 bytes
BowserSpriteFrame19:
	INCBIN "data/bank_053/d_5300.bin" ; $5300, 240 bytes
BowserSpriteFrame20:
	INCBIN "data/bank_053/d_53f0.bin" ; $53f0, 240 bytes
BowserSpriteFrame21:
	INCBIN "data/bank_053/d_54e0.bin" ; $54e0, 240 bytes
BowserSpriteFrame22:
	INCBIN "data/bank_053/d_55d0.bin" ; $55d0, 240 bytes
BowserSpriteFrame23:
	INCBIN "data/bank_053/d_56c0.bin" ; $56c0, 240 bytes
BowserSpriteFrame24:
	INCBIN "data/bank_053/d_57b0.bin" ; $57b0, 240 bytes
BowserSpriteFrame25:
	INCBIN "data/bank_053/d_58a0.bin" ; $58a0, 240 bytes
BowserSpriteFrame26:
	INCBIN "data/bank_053/d_5990.bin" ; $5990, 240 bytes
BowserSpriteFrame27:
	INCBIN "data/bank_053/d_5a80.bin" ; $5a80, 240 bytes
BowserSpriteFrame28:
	INCBIN "data/bank_053/d_5b70.bin" ; $5b70, 240 bytes
BowserSpriteFrame29:
	INCBIN "data/bank_053/d_5c60.bin" ; $5c60, 240 bytes
BowserSpriteFrame30:
	INCBIN "data/bank_053/d_5d50.bin" ; $5d50, 240 bytes
BowserSpriteFrame31:
	INCBIN "data/bank_053/d_5e40.bin" ; $5e40, 240 bytes
BowserSpriteFrame32:
	INCBIN "data/bank_053/d_5f30.bin" ; $5f30, 240 bytes
BowserSpriteFrame33:
	INCBIN "data/bank_053/d_6020.bin" ; $6020, 240 bytes
BowserSpriteFrame34:
	INCBIN "data/bank_053/d_6110.bin" ; $6110, 240 bytes
BowserSpriteFrame35:
	INCBIN "data/bank_053/d_6200.bin" ; $6200, 240 bytes
BowserSpriteFrame36:
	INCBIN "data/bank_053/d_62f0.bin" ; $62f0, 240 bytes
BowserSpriteFrame37:
	INCBIN "data/bank_053/d_63e0.bin" ; $63e0, 240 bytes
BowserSpriteFrame38:
	INCBIN "data/bank_053/d_64d0.bin" ; $64d0, 240 bytes
BowserSpriteFrame39:
	INCBIN "data/bank_053/d_65c0.bin" ; $65c0, 240 bytes
BowserSpriteFrame40:
	INCBIN "data/bank_053/d_66b0.bin" ; $66b0, 320 bytes
BowserSpriteFrame41:
	INCBIN "data/bank_053/d_67f0.bin" ; $67f0, 320 bytes
BowserSpriteFrame42:
	INCBIN "data/bank_053/d_6930.bin" ; $6930, 240 bytes
BowserSpriteFrame43:
	INCBIN "data/bank_053/d_6a20.bin" ; $6a20, 240 bytes
BowserSpriteFrame44:
	INCBIN "data/bank_053/d_6b10.bin" ; $6b10, 240 bytes
BowserSpriteFrame45:
	INCBIN "data/bank_053/d_6c00.bin" ; $6c00, 240 bytes
BowserSpriteFrame46:
	INCBIN "data/bank_053/d_6cf0.bin" ; $6cf0, 240 bytes
BowserSpriteFrame47:
	INCBIN "data/bank_053/d_6de0.bin" ; $6de0, 240 bytes
BowserSpriteFrame48:
	INCBIN "data/bank_053/d_6ed0.bin" ; $6ed0, 240 bytes
BowserSpriteFrame49:
	INCBIN "data/bank_053/d_6fc0.bin" ; $6fc0, 240 bytes
BowserSpriteFrame50:
	INCBIN "data/bank_053/d_70b0.bin" ; $70b0, 240 bytes
BowserSpriteFrame51:
	INCBIN "data/bank_053/d_71a0.bin" ; $71a0, 240 bytes
BowserSpriteFrame52:
	INCBIN "data/bank_053/d_7290.bin" ; $7290, 240 bytes
BowserSpriteFrame53:
	INCBIN "data/bank_053/d_7380.bin" ; $7380, 240 bytes
BowserSpriteFrame54:
	INCBIN "data/bank_053/d_7470.bin" ; $7470, 240 bytes
BowserSpriteFrame55:
	INCBIN "data/bank_053/d_7560.bin" ; $7560, 240 bytes
BowserSpriteFramesUnused:
	INCBIN "data/bank_053/d_7650.bin" ; $7650, 1680 bytes
BowserSpriteOam:
	INCBIN "data/bank_053/d_7ce0.bin" ; $7ce0, 580 bytes
BowserSpriteAnims:
	dw BowserSpriteAnim00 ; $7f24
	dw BowserSpriteAnim01 ; $7f26
	dw BowserSpriteAnim02 ; $7f28
	dw BowserSpriteAnim03 ; $7f2a
	dw BowserSpriteAnim04 ; $7f2c
	dw BowserSpriteAnim05 ; $7f2e
	dw BowserSpriteAnim06 ; $7f30
	dw BowserSpriteAnim07 ; $7f32
	dw BowserSpriteAnim08 ; $7f34
	dw BowserSpriteAnim09 ; $7f36
	dw BowserSpriteAnim10 ; $7f38
	dw BowserSpriteAnim11 ; $7f3a
	dw BowserSpriteAnim12 ; $7f3c
	dw BowserSpriteAnim13 ; $7f3e
	dw BowserSpriteAnim14 ; $7f40
	dw BowserSpriteAnim15 ; $7f42
	dw BowserSpriteAnim16 ; $7f44
	dw BowserSpriteAnim17 ; $7f46
	dw BowserSpriteAnim18 ; $7f48
BowserSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	db $00
	db $ff, $fd
BowserSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
BowserSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
BowserSpriteAnim03:
	; $7f5d, 18 bytes (sprite_anim)
	anim_flip $00
	anim_frame $18, $08
	anim_frame $19, $0c
	anim_frame $17, $24
	anim_flip $20
	anim_frame $18, $08
	anim_frame $19, $0c
	anim_frame $17, $24
	anim_loop $00
BowserSpriteAnim04:
	; $7f6f, 10 bytes (sprite_anim)
	anim_frame $1a, $06
	anim_frame $1b, $06
	anim_frame $1c, $06
	anim_frame $1b, $06
	anim_loop $00
BowserSpriteAnim05:
	; $7f79, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
BowserSpriteAnim06:
	; $7f7f, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
BowserSpriteAnim07:
	; $7f85, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
BowserSpriteAnim08:
	; $7f8b, 5 bytes (sprite_anim)
	db $15, $04, $16, $14, $fd
BowserSpriteAnim09:
	; $7f90, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
BowserSpriteAnim10:
	; $7f94, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
BowserSpriteAnim11:
	; $7f98, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
BowserSpriteAnim12:
	; $7f9c, 3 bytes (sprite_anim)
	db $15, $18, $fd
BowserSpriteAnim13:
	; $7f9f, 3 bytes (sprite_anim)
	db $05, $ff, $fd
BowserSpriteAnim14:
	; $7fa2, 3 bytes (sprite_anim)
	db $08, $ff, $fd
BowserSpriteAnim15:
	; $7fa5, 3 bytes (sprite_anim)
	db $0b, $ff, $fd
BowserSpriteAnim16:
	; $7fa8, 3 bytes (sprite_anim)
	db $0e, $ff, $fd
BowserSpriteAnim17:
	; $7fab, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
BowserSpriteAnim18:
	; $7fb7, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fbf, 65 bytes fill to bank end (linker-padded)
