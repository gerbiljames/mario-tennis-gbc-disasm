SECTION "ROM Bank $4f", ROMX[$4000], BANK[$4f]

	dw BobSpriteDesc ; $4000
BobSpriteDesc:
	dw $0005 ; $4002
	dw $0003 ; $4004
	dw BobSpriteFrames ; $4006 frame table
	dw BobSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw Data_4f_7ce0 ; $400c per-slot OAM data
BobSpriteFrames:
	dw BobSpriteFrame00 ; $400e
	dw BobSpriteFrame01 ; $4010
	dw BobSpriteFrame02 ; $4012
	dw BobSpriteFrame03 ; $4014
	dw BobSpriteFrame04 ; $4016
	dw BobSpriteFrame05 ; $4018
	dw BobSpriteFrame06 ; $401a
	dw BobSpriteFrame07 ; $401c
	dw BobSpriteFrame08 ; $401e
	dw BobSpriteFrame09 ; $4020
	dw BobSpriteFrame10 ; $4022
	dw BobSpriteFrame01 ; $4024
	dw BobSpriteFrame02 ; $4026
	dw BobSpriteFrame03 ; $4028
	dw BobSpriteFrame11 ; $402a
	dw BobSpriteFrame12 ; $402c
	dw BobSpriteFrame01 ; $402e
	dw BobSpriteFrame02 ; $4030
	dw BobSpriteFrame03 ; $4032
	dw BobSpriteFrame13 ; $4034
	dw BobSpriteFrame14 ; $4036
	dw BobSpriteFrame06 ; $4038
	dw BobSpriteFrame07 ; $403a
	dw BobSpriteFrame08 ; $403c
	dw BobSpriteFrame15 ; $403e
	dw BobSpriteFrame16 ; $4040
	dw BobSpriteFrame16 ; $4042
	dw BobSpriteFrame16 ; $4044
	dw BobSpriteFrame17 ; $4046
	dw BobSpriteFrame17 ; $4048
	dw BobSpriteFrame18 ; $404a
	dw BobSpriteFrame18 ; $404c
	dw BobSpriteFrame18 ; $404e
	dw BobSpriteFrame19 ; $4050
	dw BobSpriteFrame19 ; $4052
	dw BobSpriteFrame20 ; $4054
	dw BobSpriteFrame20 ; $4056
	dw BobSpriteFrame20 ; $4058
	dw BobSpriteFrame21 ; $405a
	dw BobSpriteFrame21 ; $405c
	dw BobSpriteFrame22 ; $405e
	dw BobSpriteFrame22 ; $4060
	dw BobSpriteFrame22 ; $4062
	dw BobSpriteFrame23 ; $4064
	dw BobSpriteFrame23 ; $4066
	dw BobSpriteFrame24 ; $4068
	dw BobSpriteFrame24 ; $406a
	dw BobSpriteFrame24 ; $406c
	dw BobSpriteFrame25 ; $406e
	dw BobSpriteFrame25 ; $4070
	dw BobSpriteFrame26 ; $4072
	dw BobSpriteFrame26 ; $4074
	dw BobSpriteFrame26 ; $4076
	dw BobSpriteFrame27 ; $4078
	dw BobSpriteFrame27 ; $407a
	dw BobSpriteFrame28 ; $407c
	dw BobSpriteFrame28 ; $407e
	dw BobSpriteFrame28 ; $4080
	dw BobSpriteFrame29 ; $4082
	dw BobSpriteFrame29 ; $4084
	dw BobSpriteFrame30 ; $4086
	dw BobSpriteFrame30 ; $4088
	dw BobSpriteFrame30 ; $408a
	dw BobSpriteFrame31 ; $408c
	dw BobSpriteFrame31 ; $408e
	dw BobSpriteFrame32 ; $4090
	dw BobSpriteFrame32 ; $4092
	dw BobSpriteFrame32 ; $4094
	dw BobSpriteFrame33 ; $4096
	dw BobSpriteFrame33 ; $4098
	dw BobSpriteFrame34 ; $409a
	dw BobSpriteFrame34 ; $409c
	dw BobSpriteFrame34 ; $409e
	dw BobSpriteFrame35 ; $40a0
	dw BobSpriteFrame35 ; $40a2
	dw BobSpriteFrame36 ; $40a4
	dw BobSpriteFrame36 ; $40a6
	dw BobSpriteFrame36 ; $40a8
	dw BobSpriteFrame37 ; $40aa
	dw BobSpriteFrame37 ; $40ac
	dw BobSpriteFrame38 ; $40ae
	dw BobSpriteFrame38 ; $40b0
	dw BobSpriteFrame38 ; $40b2
	dw BobSpriteFrame39 ; $40b4
	dw BobSpriteFrame39 ; $40b6
	dw BobSpriteFrame40 ; $40b8
	dw BobSpriteFrame40 ; $40ba
	dw BobSpriteFrame40 ; $40bc
	dw BobSpriteFrame41 ; $40be
	dw BobSpriteFrame41 ; $40c0
	dw BobSpriteFrame42 ; $40c2
	dw BobSpriteFrame42 ; $40c4
	dw BobSpriteFrame42 ; $40c6
	dw BobSpriteFrame42 ; $40c8
	dw BobSpriteFrame42 ; $40ca
	dw BobSpriteFrame43 ; $40cc
	dw BobSpriteFrame43 ; $40ce
	dw BobSpriteFrame43 ; $40d0
	dw BobSpriteFrame43 ; $40d2
	dw BobSpriteFrame43 ; $40d4
	dw BobSpriteFrame44 ; $40d6
	dw BobSpriteFrame44 ; $40d8
	dw BobSpriteFrame44 ; $40da
	dw BobSpriteFrame45 ; $40dc
	dw BobSpriteFrame45 ; $40de
	dw BobSpriteFrame46 ; $40e0
	dw BobSpriteFrame46 ; $40e2
	dw BobSpriteFrame46 ; $40e4
	dw BobSpriteFrame47 ; $40e6
	dw BobSpriteFrame47 ; $40e8
	dw BobSpriteFrame48 ; $40ea
	dw BobSpriteFrame48 ; $40ec
	dw BobSpriteFrame48 ; $40ee
	dw BobSpriteFrame49 ; $40f0
	dw BobSpriteFrame49 ; $40f2
	dw BobSpriteFrame50 ; $40f4
	dw BobSpriteFrame50 ; $40f6
	dw BobSpriteFrame50 ; $40f8
	dw BobSpriteFrame50 ; $40fa
	dw BobSpriteFrame50 ; $40fc
	dw BobSpriteFrame51 ; $40fe
	dw BobSpriteFrame51 ; $4100
	dw BobSpriteFrame51 ; $4102
	dw BobSpriteFrame51 ; $4104
	dw BobSpriteFrame51 ; $4106
	dw BobSpriteFrame52 ; $4108
	dw BobSpriteFrame52 ; $410a
	dw BobSpriteFrame52 ; $410c
	dw BobSpriteFrame52 ; $410e
	dw BobSpriteFrame52 ; $4110
	dw BobSpriteFrame53 ; $4112
	dw BobSpriteFrame53 ; $4114
	dw BobSpriteFrame53 ; $4116
	dw BobSpriteFrame53 ; $4118
	dw BobSpriteFrame53 ; $411a
	dw BobSpriteFrame54 ; $411c
	dw BobSpriteFrame54 ; $411e
	dw BobSpriteFrame54 ; $4120
	dw BobSpriteFrame54 ; $4122
	dw BobSpriteFrame54 ; $4124
	dw BobSpriteFrame55 ; $4126
	dw BobSpriteFrame55 ; $4128
	dw BobSpriteFrame55 ; $412a
	dw BobSpriteFrame55 ; $412c
	dw BobSpriteFrame55 ; $412e
BobSpriteFrame00:
	INCBIN "data/bank_04f/d_4130.bin" ; $4130, 240 bytes
BobSpriteFrame01:
	INCBIN "data/bank_04f/d_4220.bin" ; $4220, 240 bytes
BobSpriteFrame02:
	INCBIN "data/bank_04f/d_4310.bin" ; $4310, 240 bytes
BobSpriteFrame03:
	INCBIN "data/bank_04f/d_4400.bin" ; $4400, 240 bytes
BobSpriteFrame04:
	INCBIN "data/bank_04f/d_44f0.bin" ; $44f0, 240 bytes
BobSpriteFrame05:
	INCBIN "data/bank_04f/d_45e0.bin" ; $45e0, 240 bytes
BobSpriteFrame06:
	INCBIN "data/bank_04f/d_46d0.bin" ; $46d0, 240 bytes
BobSpriteFrame07:
	INCBIN "data/bank_04f/d_47c0.bin" ; $47c0, 240 bytes
BobSpriteFrame08:
	INCBIN "data/bank_04f/d_48b0.bin" ; $48b0, 240 bytes
BobSpriteFrame09:
	INCBIN "data/bank_04f/d_49a0.bin" ; $49a0, 240 bytes
BobSpriteFrame10:
	INCBIN "data/bank_04f/d_4a90.bin" ; $4a90, 240 bytes
BobSpriteFrame11:
	INCBIN "data/bank_04f/d_4b80.bin" ; $4b80, 240 bytes
BobSpriteFrame12:
	INCBIN "data/bank_04f/d_4c70.bin" ; $4c70, 240 bytes
BobSpriteFrame13:
	INCBIN "data/bank_04f/d_4d60.bin" ; $4d60, 240 bytes
BobSpriteFrame14:
	INCBIN "data/bank_04f/d_4e50.bin" ; $4e50, 240 bytes
BobSpriteFrame15:
	INCBIN "data/bank_04f/d_4f40.bin" ; $4f40, 240 bytes
BobSpriteFrame16:
	INCBIN "data/bank_04f/d_5030.bin" ; $5030, 240 bytes
BobSpriteFrame17:
	INCBIN "data/bank_04f/d_5120.bin" ; $5120, 240 bytes
BobSpriteFrame18:
	INCBIN "data/bank_04f/d_5210.bin" ; $5210, 240 bytes
BobSpriteFrame19:
	INCBIN "data/bank_04f/d_5300.bin" ; $5300, 240 bytes
BobSpriteFrame20:
	INCBIN "data/bank_04f/d_53f0.bin" ; $53f0, 240 bytes
BobSpriteFrame21:
	INCBIN "data/bank_04f/d_54e0.bin" ; $54e0, 240 bytes
BobSpriteFrame22:
	INCBIN "data/bank_04f/d_55d0.bin" ; $55d0, 240 bytes
BobSpriteFrame23:
	INCBIN "data/bank_04f/d_56c0.bin" ; $56c0, 240 bytes
BobSpriteFrame24:
	INCBIN "data/bank_04f/d_57b0.bin" ; $57b0, 240 bytes
BobSpriteFrame25:
	INCBIN "data/bank_04f/d_58a0.bin" ; $58a0, 240 bytes
BobSpriteFrame26:
	INCBIN "data/bank_04f/d_5990.bin" ; $5990, 240 bytes
BobSpriteFrame27:
	INCBIN "data/bank_04f/d_5a80.bin" ; $5a80, 240 bytes
BobSpriteFrame28:
	INCBIN "data/bank_04f/d_5b70.bin" ; $5b70, 240 bytes
BobSpriteFrame29:
	INCBIN "data/bank_04f/d_5c60.bin" ; $5c60, 240 bytes
BobSpriteFrame30:
	INCBIN "data/bank_04f/d_5d50.bin" ; $5d50, 240 bytes
BobSpriteFrame31:
	INCBIN "data/bank_04f/d_5e40.bin" ; $5e40, 240 bytes
BobSpriteFrame32:
	INCBIN "data/bank_04f/d_5f30.bin" ; $5f30, 240 bytes
BobSpriteFrame33:
	INCBIN "data/bank_04f/d_6020.bin" ; $6020, 240 bytes
BobSpriteFrame34:
	INCBIN "data/bank_04f/d_6110.bin" ; $6110, 240 bytes
BobSpriteFrame35:
	INCBIN "data/bank_04f/d_6200.bin" ; $6200, 240 bytes
BobSpriteFrame36:
	INCBIN "data/bank_04f/d_62f0.bin" ; $62f0, 240 bytes
BobSpriteFrame37:
	INCBIN "data/bank_04f/d_63e0.bin" ; $63e0, 240 bytes
BobSpriteFrame38:
	INCBIN "data/bank_04f/d_64d0.bin" ; $64d0, 240 bytes
BobSpriteFrame39:
	INCBIN "data/bank_04f/d_65c0.bin" ; $65c0, 240 bytes
BobSpriteFrame40:
	INCBIN "data/bank_04f/d_66b0.bin" ; $66b0, 320 bytes
BobSpriteFrame41:
	INCBIN "data/bank_04f/d_67f0.bin" ; $67f0, 320 bytes
BobSpriteFrame42:
	INCBIN "data/bank_04f/d_6930.bin" ; $6930, 240 bytes
BobSpriteFrame43:
	INCBIN "data/bank_04f/d_6a20.bin" ; $6a20, 240 bytes
BobSpriteFrame44:
	INCBIN "data/bank_04f/d_6b10.bin" ; $6b10, 240 bytes
BobSpriteFrame45:
	INCBIN "data/bank_04f/d_6c00.bin" ; $6c00, 240 bytes
BobSpriteFrame46:
	INCBIN "data/bank_04f/d_6cf0.bin" ; $6cf0, 240 bytes
BobSpriteFrame47:
	INCBIN "data/bank_04f/d_6de0.bin" ; $6de0, 240 bytes
BobSpriteFrame48:
	INCBIN "data/bank_04f/d_6ed0.bin" ; $6ed0, 240 bytes
BobSpriteFrame49:
	INCBIN "data/bank_04f/d_6fc0.bin" ; $6fc0, 240 bytes
BobSpriteFrame50:
	INCBIN "data/bank_04f/d_70b0.bin" ; $70b0, 240 bytes
BobSpriteFrame51:
	INCBIN "data/bank_04f/d_71a0.bin" ; $71a0, 240 bytes
BobSpriteFrame52:
	INCBIN "data/bank_04f/d_7290.bin" ; $7290, 240 bytes
BobSpriteFrame53:
	INCBIN "data/bank_04f/d_7380.bin" ; $7380, 240 bytes
BobSpriteFrame54:
	INCBIN "data/bank_04f/d_7470.bin" ; $7470, 240 bytes
BobSpriteFrame55:
	INCBIN "data/bank_04f/d_7560.bin" ; $7560, 240 bytes
Data_4f_7650:
	INCBIN "data/bank_04f/d_7650.bin" ; $7650, 1680 bytes
Data_4f_7ce0:
	INCBIN "data/bank_04f/d_7ce0.bin" ; $7ce0, 580 bytes
BobSpriteAnims:
	dw BobSpriteAnim00 ; $7f24
	dw BobSpriteAnim01 ; $7f26
	dw BobSpriteAnim02 ; $7f28
	dw BobSpriteAnim03 ; $7f2a
	dw BobSpriteAnim04 ; $7f2c
	dw BobSpriteAnim05 ; $7f2e
	dw BobSpriteAnim06 ; $7f30
	dw BobSpriteAnim07 ; $7f32
	dw BobSpriteAnim08 ; $7f34
	dw BobSpriteAnim09 ; $7f36
	dw BobSpriteAnim10 ; $7f38
	dw BobSpriteAnim11 ; $7f3a
	dw BobSpriteAnim12 ; $7f3c
	dw BobSpriteAnim13 ; $7f3e
	dw BobSpriteAnim14 ; $7f40
	dw BobSpriteAnim15 ; $7f42
	dw BobSpriteAnim16 ; $7f44
	dw BobSpriteAnim17 ; $7f46
	dw BobSpriteAnim18 ; $7f48
BobSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	db $00
	db $ff, $fd
BobSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
BobSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
BobSpriteAnim03:
	; $7f5d, 10 bytes (sprite_anim)
	anim_frame $17, $0f
	anim_frame $19, $0f
	anim_frame $18, $0f
	anim_frame $19, $0f
	anim_loop $00
BobSpriteAnim04:
	; $7f67, 10 bytes (sprite_anim)
	anim_frame $1a, $0a
	anim_frame $1c, $0a
	anim_frame $1b, $0a
	anim_frame $1c, $0a
	anim_loop $00
BobSpriteAnim05:
	; $7f71, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
BobSpriteAnim06:
	; $7f77, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
BobSpriteAnim07:
	; $7f7d, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
BobSpriteAnim08:
	; $7f83, 5 bytes (sprite_anim)
	db $15, $04, $16, $14, $fd
BobSpriteAnim09:
	; $7f88, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
BobSpriteAnim10:
	; $7f8c, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
BobSpriteAnim11:
	; $7f90, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
BobSpriteAnim12:
	; $7f94, 3 bytes (sprite_anim)
	db $15, $18, $fd
BobSpriteAnim13:
	; $7f97, 3 bytes (sprite_anim)
	db $05, $ff, $fd
BobSpriteAnim14:
	; $7f9a, 3 bytes (sprite_anim)
	db $08, $ff, $fd
BobSpriteAnim15:
	; $7f9d, 3 bytes (sprite_anim)
	db $0b, $ff, $fd
BobSpriteAnim16:
	; $7fa0, 3 bytes (sprite_anim)
	db $0e, $ff, $fd
BobSpriteAnim17:
	; $7fa3, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
BobSpriteAnim18:
	; $7faf, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fb7, 73 bytes fill to bank end (linker-padded)
