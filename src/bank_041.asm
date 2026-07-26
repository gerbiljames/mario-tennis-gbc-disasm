SECTION "ROM Bank $41", ROMX[$4000], BANK[$41]

	dw NinaSpriteDesc ; $4000
NinaSpriteDesc:
	dw $0005 ; $4002
	dw $0003 ; $4004
	dw NinaSpriteFrames ; $4006 frame table
	dw NinaSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw Data_41_7ce0 ; $400c per-slot OAM data
NinaSpriteFrames:
	dw NinaSpriteFrame00 ; $400e
	dw NinaSpriteFrame01 ; $4010
	dw NinaSpriteFrame02 ; $4012
	dw NinaSpriteFrame03 ; $4014
	dw NinaSpriteFrame04 ; $4016
	dw NinaSpriteFrame05 ; $4018
	dw NinaSpriteFrame06 ; $401a
	dw NinaSpriteFrame07 ; $401c
	dw NinaSpriteFrame08 ; $401e
	dw NinaSpriteFrame09 ; $4020
	dw NinaSpriteFrame10 ; $4022
	dw NinaSpriteFrame01 ; $4024
	dw NinaSpriteFrame02 ; $4026
	dw NinaSpriteFrame03 ; $4028
	dw NinaSpriteFrame11 ; $402a
	dw NinaSpriteFrame12 ; $402c
	dw NinaSpriteFrame01 ; $402e
	dw NinaSpriteFrame02 ; $4030
	dw NinaSpriteFrame03 ; $4032
	dw NinaSpriteFrame13 ; $4034
	dw NinaSpriteFrame14 ; $4036
	dw NinaSpriteFrame06 ; $4038
	dw NinaSpriteFrame07 ; $403a
	dw NinaSpriteFrame08 ; $403c
	dw NinaSpriteFrame15 ; $403e
	dw NinaSpriteFrame16 ; $4040
	dw NinaSpriteFrame16 ; $4042
	dw NinaSpriteFrame16 ; $4044
	dw NinaSpriteFrame17 ; $4046
	dw NinaSpriteFrame17 ; $4048
	dw NinaSpriteFrame18 ; $404a
	dw NinaSpriteFrame18 ; $404c
	dw NinaSpriteFrame18 ; $404e
	dw NinaSpriteFrame19 ; $4050
	dw NinaSpriteFrame19 ; $4052
	dw NinaSpriteFrame20 ; $4054
	dw NinaSpriteFrame20 ; $4056
	dw NinaSpriteFrame20 ; $4058
	dw NinaSpriteFrame21 ; $405a
	dw NinaSpriteFrame21 ; $405c
	dw NinaSpriteFrame22 ; $405e
	dw NinaSpriteFrame22 ; $4060
	dw NinaSpriteFrame22 ; $4062
	dw NinaSpriteFrame23 ; $4064
	dw NinaSpriteFrame23 ; $4066
	dw NinaSpriteFrame24 ; $4068
	dw NinaSpriteFrame24 ; $406a
	dw NinaSpriteFrame24 ; $406c
	dw NinaSpriteFrame25 ; $406e
	dw NinaSpriteFrame25 ; $4070
	dw NinaSpriteFrame26 ; $4072
	dw NinaSpriteFrame26 ; $4074
	dw NinaSpriteFrame26 ; $4076
	dw NinaSpriteFrame27 ; $4078
	dw NinaSpriteFrame27 ; $407a
	dw NinaSpriteFrame28 ; $407c
	dw NinaSpriteFrame28 ; $407e
	dw NinaSpriteFrame28 ; $4080
	dw NinaSpriteFrame29 ; $4082
	dw NinaSpriteFrame29 ; $4084
	dw NinaSpriteFrame30 ; $4086
	dw NinaSpriteFrame30 ; $4088
	dw NinaSpriteFrame30 ; $408a
	dw NinaSpriteFrame31 ; $408c
	dw NinaSpriteFrame31 ; $408e
	dw NinaSpriteFrame32 ; $4090
	dw NinaSpriteFrame32 ; $4092
	dw NinaSpriteFrame32 ; $4094
	dw NinaSpriteFrame33 ; $4096
	dw NinaSpriteFrame33 ; $4098
	dw NinaSpriteFrame34 ; $409a
	dw NinaSpriteFrame34 ; $409c
	dw NinaSpriteFrame34 ; $409e
	dw NinaSpriteFrame35 ; $40a0
	dw NinaSpriteFrame35 ; $40a2
	dw NinaSpriteFrame36 ; $40a4
	dw NinaSpriteFrame36 ; $40a6
	dw NinaSpriteFrame36 ; $40a8
	dw NinaSpriteFrame37 ; $40aa
	dw NinaSpriteFrame37 ; $40ac
	dw NinaSpriteFrame38 ; $40ae
	dw NinaSpriteFrame38 ; $40b0
	dw NinaSpriteFrame38 ; $40b2
	dw NinaSpriteFrame39 ; $40b4
	dw NinaSpriteFrame39 ; $40b6
	dw NinaSpriteFrame40 ; $40b8
	dw NinaSpriteFrame40 ; $40ba
	dw NinaSpriteFrame40 ; $40bc
	dw NinaSpriteFrame41 ; $40be
	dw NinaSpriteFrame41 ; $40c0
	dw NinaSpriteFrame42 ; $40c2
	dw NinaSpriteFrame42 ; $40c4
	dw NinaSpriteFrame42 ; $40c6
	dw NinaSpriteFrame42 ; $40c8
	dw NinaSpriteFrame42 ; $40ca
	dw NinaSpriteFrame43 ; $40cc
	dw NinaSpriteFrame43 ; $40ce
	dw NinaSpriteFrame43 ; $40d0
	dw NinaSpriteFrame43 ; $40d2
	dw NinaSpriteFrame43 ; $40d4
	dw NinaSpriteFrame44 ; $40d6
	dw NinaSpriteFrame44 ; $40d8
	dw NinaSpriteFrame44 ; $40da
	dw NinaSpriteFrame45 ; $40dc
	dw NinaSpriteFrame45 ; $40de
	dw NinaSpriteFrame46 ; $40e0
	dw NinaSpriteFrame46 ; $40e2
	dw NinaSpriteFrame46 ; $40e4
	dw NinaSpriteFrame47 ; $40e6
	dw NinaSpriteFrame47 ; $40e8
	dw NinaSpriteFrame48 ; $40ea
	dw NinaSpriteFrame48 ; $40ec
	dw NinaSpriteFrame48 ; $40ee
	dw NinaSpriteFrame49 ; $40f0
	dw NinaSpriteFrame49 ; $40f2
	dw NinaSpriteFrame50 ; $40f4
	dw NinaSpriteFrame50 ; $40f6
	dw NinaSpriteFrame50 ; $40f8
	dw NinaSpriteFrame50 ; $40fa
	dw NinaSpriteFrame50 ; $40fc
	dw NinaSpriteFrame51 ; $40fe
	dw NinaSpriteFrame51 ; $4100
	dw NinaSpriteFrame51 ; $4102
	dw NinaSpriteFrame51 ; $4104
	dw NinaSpriteFrame51 ; $4106
	dw NinaSpriteFrame52 ; $4108
	dw NinaSpriteFrame52 ; $410a
	dw NinaSpriteFrame52 ; $410c
	dw NinaSpriteFrame52 ; $410e
	dw NinaSpriteFrame52 ; $4110
	dw NinaSpriteFrame53 ; $4112
	dw NinaSpriteFrame53 ; $4114
	dw NinaSpriteFrame53 ; $4116
	dw NinaSpriteFrame53 ; $4118
	dw NinaSpriteFrame53 ; $411a
	dw NinaSpriteFrame54 ; $411c
	dw NinaSpriteFrame54 ; $411e
	dw NinaSpriteFrame54 ; $4120
	dw NinaSpriteFrame54 ; $4122
	dw NinaSpriteFrame54 ; $4124
	dw NinaSpriteFrame55 ; $4126
	dw NinaSpriteFrame55 ; $4128
	dw NinaSpriteFrame55 ; $412a
	dw NinaSpriteFrame55 ; $412c
	dw NinaSpriteFrame55 ; $412e
NinaSpriteFrame00:
	INCBIN "data/bank_041/d_4130.bin" ; $4130, 240 bytes
NinaSpriteFrame01:
	INCBIN "data/bank_041/d_4220.bin" ; $4220, 240 bytes
NinaSpriteFrame02:
	INCBIN "data/bank_041/d_4310.bin" ; $4310, 240 bytes
NinaSpriteFrame03:
	INCBIN "data/bank_041/d_4400.bin" ; $4400, 240 bytes
NinaSpriteFrame04:
	INCBIN "data/bank_041/d_44f0.bin" ; $44f0, 240 bytes
NinaSpriteFrame05:
	INCBIN "data/bank_041/d_45e0.bin" ; $45e0, 240 bytes
NinaSpriteFrame06:
	INCBIN "data/bank_041/d_46d0.bin" ; $46d0, 240 bytes
NinaSpriteFrame07:
	INCBIN "data/bank_041/d_47c0.bin" ; $47c0, 240 bytes
NinaSpriteFrame08:
	INCBIN "data/bank_041/d_48b0.bin" ; $48b0, 240 bytes
NinaSpriteFrame09:
	INCBIN "data/bank_041/d_49a0.bin" ; $49a0, 240 bytes
NinaSpriteFrame10:
	INCBIN "data/bank_041/d_4a90.bin" ; $4a90, 240 bytes
NinaSpriteFrame11:
	INCBIN "data/bank_041/d_4b80.bin" ; $4b80, 240 bytes
NinaSpriteFrame12:
	INCBIN "data/bank_041/d_4c70.bin" ; $4c70, 240 bytes
NinaSpriteFrame13:
	INCBIN "data/bank_041/d_4d60.bin" ; $4d60, 240 bytes
NinaSpriteFrame14:
	INCBIN "data/bank_041/d_4e50.bin" ; $4e50, 240 bytes
NinaSpriteFrame15:
	INCBIN "data/bank_041/d_4f40.bin" ; $4f40, 240 bytes
NinaSpriteFrame16:
	INCBIN "data/bank_041/d_5030.bin" ; $5030, 240 bytes
NinaSpriteFrame17:
	INCBIN "data/bank_041/d_5120.bin" ; $5120, 240 bytes
NinaSpriteFrame18:
	INCBIN "data/bank_041/d_5210.bin" ; $5210, 240 bytes
NinaSpriteFrame19:
	INCBIN "data/bank_041/d_5300.bin" ; $5300, 240 bytes
NinaSpriteFrame20:
	INCBIN "data/bank_041/d_53f0.bin" ; $53f0, 240 bytes
NinaSpriteFrame21:
	INCBIN "data/bank_041/d_54e0.bin" ; $54e0, 240 bytes
NinaSpriteFrame22:
	INCBIN "data/bank_041/d_55d0.bin" ; $55d0, 240 bytes
NinaSpriteFrame23:
	INCBIN "data/bank_041/d_56c0.bin" ; $56c0, 240 bytes
NinaSpriteFrame24:
	INCBIN "data/bank_041/d_57b0.bin" ; $57b0, 240 bytes
NinaSpriteFrame25:
	INCBIN "data/bank_041/d_58a0.bin" ; $58a0, 240 bytes
NinaSpriteFrame26:
	INCBIN "data/bank_041/d_5990.bin" ; $5990, 240 bytes
NinaSpriteFrame27:
	INCBIN "data/bank_041/d_5a80.bin" ; $5a80, 240 bytes
NinaSpriteFrame28:
	INCBIN "data/bank_041/d_5b70.bin" ; $5b70, 240 bytes
NinaSpriteFrame29:
	INCBIN "data/bank_041/d_5c60.bin" ; $5c60, 240 bytes
NinaSpriteFrame30:
	INCBIN "data/bank_041/d_5d50.bin" ; $5d50, 240 bytes
NinaSpriteFrame31:
	INCBIN "data/bank_041/d_5e40.bin" ; $5e40, 240 bytes
NinaSpriteFrame32:
	INCBIN "data/bank_041/d_5f30.bin" ; $5f30, 240 bytes
NinaSpriteFrame33:
	INCBIN "data/bank_041/d_6020.bin" ; $6020, 240 bytes
NinaSpriteFrame34:
	INCBIN "data/bank_041/d_6110.bin" ; $6110, 240 bytes
NinaSpriteFrame35:
	INCBIN "data/bank_041/d_6200.bin" ; $6200, 240 bytes
NinaSpriteFrame36:
	INCBIN "data/bank_041/d_62f0.bin" ; $62f0, 240 bytes
NinaSpriteFrame37:
	INCBIN "data/bank_041/d_63e0.bin" ; $63e0, 240 bytes
NinaSpriteFrame38:
	INCBIN "data/bank_041/d_64d0.bin" ; $64d0, 240 bytes
NinaSpriteFrame39:
	INCBIN "data/bank_041/d_65c0.bin" ; $65c0, 240 bytes
NinaSpriteFrame40:
	INCBIN "data/bank_041/d_66b0.bin" ; $66b0, 320 bytes
NinaSpriteFrame41:
	INCBIN "data/bank_041/d_67f0.bin" ; $67f0, 320 bytes
NinaSpriteFrame42:
	INCBIN "data/bank_041/d_6930.bin" ; $6930, 240 bytes
NinaSpriteFrame43:
	INCBIN "data/bank_041/d_6a20.bin" ; $6a20, 240 bytes
NinaSpriteFrame44:
	INCBIN "data/bank_041/d_6b10.bin" ; $6b10, 240 bytes
NinaSpriteFrame45:
	INCBIN "data/bank_041/d_6c00.bin" ; $6c00, 240 bytes
NinaSpriteFrame46:
	INCBIN "data/bank_041/d_6cf0.bin" ; $6cf0, 240 bytes
NinaSpriteFrame47:
	INCBIN "data/bank_041/d_6de0.bin" ; $6de0, 240 bytes
NinaSpriteFrame48:
	INCBIN "data/bank_041/d_6ed0.bin" ; $6ed0, 240 bytes
NinaSpriteFrame49:
	INCBIN "data/bank_041/d_6fc0.bin" ; $6fc0, 240 bytes
NinaSpriteFrame50:
	INCBIN "data/bank_041/d_70b0.bin" ; $70b0, 240 bytes
NinaSpriteFrame51:
	INCBIN "data/bank_041/d_71a0.bin" ; $71a0, 240 bytes
NinaSpriteFrame52:
	INCBIN "data/bank_041/d_7290.bin" ; $7290, 240 bytes
NinaSpriteFrame53:
	INCBIN "data/bank_041/d_7380.bin" ; $7380, 240 bytes
NinaSpriteFrame54:
	INCBIN "data/bank_041/d_7470.bin" ; $7470, 240 bytes
NinaSpriteFrame55:
	INCBIN "data/bank_041/d_7560.bin" ; $7560, 240 bytes
Data_41_7650:
	INCBIN "data/bank_041/d_7650.bin" ; $7650, 1680 bytes
Data_41_7ce0:
	INCBIN "data/bank_041/d_7ce0.bin" ; $7ce0, 580 bytes
NinaSpriteAnims:
	dw NinaSpriteAnim00 ; $7f24
	dw NinaSpriteAnim01 ; $7f26
	dw NinaSpriteAnim02 ; $7f28
	dw NinaSpriteAnim03 ; $7f2a
	dw NinaSpriteAnim04 ; $7f2c
	dw NinaSpriteAnim05 ; $7f2e
	dw NinaSpriteAnim06 ; $7f30
	dw NinaSpriteAnim07 ; $7f32
	dw NinaSpriteAnim08 ; $7f34
	dw NinaSpriteAnim09 ; $7f36
	dw NinaSpriteAnim10 ; $7f38
	dw NinaSpriteAnim11 ; $7f3a
	dw NinaSpriteAnim12 ; $7f3c
	dw NinaSpriteAnim13 ; $7f3e
	dw NinaSpriteAnim14 ; $7f40
	dw NinaSpriteAnim15 ; $7f42
	dw NinaSpriteAnim16 ; $7f44
	dw NinaSpriteAnim17 ; $7f46
	dw NinaSpriteAnim18 ; $7f48
NinaSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	db $00
	db $ff, $fd
NinaSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
NinaSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
NinaSpriteAnim03:
	; $7f5d, 8 bytes (sprite_anim)
	anim_frame $17, $0f
	anim_frame $18, $0f
	anim_frame $19, $0f
	anim_loop $02
NinaSpriteAnim04:
	; $7f65, 10 bytes (sprite_anim)
	anim_frame $1a, $0c
	anim_frame $1b, $0c
	anim_frame $1c, $0c
	anim_frame $1b, $0c
	anim_loop $00
NinaSpriteAnim05:
	; $7f6f, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
NinaSpriteAnim06:
	; $7f75, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
NinaSpriteAnim07:
	; $7f7b, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
NinaSpriteAnim08:
	; $7f81, 5 bytes (sprite_anim)
	db $15, $04, $16, $14, $fd
NinaSpriteAnim09:
	; $7f86, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
NinaSpriteAnim10:
	; $7f8a, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
NinaSpriteAnim11:
	; $7f8e, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
NinaSpriteAnim12:
	; $7f92, 3 bytes (sprite_anim)
	db $15, $18, $fd
NinaSpriteAnim13:
	; $7f95, 3 bytes (sprite_anim)
	db $05, $ff, $fd
NinaSpriteAnim14:
	; $7f98, 3 bytes (sprite_anim)
	db $08, $ff, $fd
NinaSpriteAnim15:
	; $7f9b, 3 bytes (sprite_anim)
	db $0b, $ff, $fd
NinaSpriteAnim16:
	; $7f9e, 3 bytes (sprite_anim)
	db $0e, $ff, $fd
NinaSpriteAnim17:
	; $7fa1, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
NinaSpriteAnim18:
	; $7fad, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fb5, 75 bytes fill to bank end (linker-padded)
