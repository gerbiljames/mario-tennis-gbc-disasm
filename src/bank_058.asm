SECTION "ROM Bank $58", ROMX[$4000], BANK[$58]

	dw BethSpriteDesc ; $4000
BethSpriteDesc:
	dw $0004 ; $4002
	dw $0003 ; $4004
	dw BethSpriteFrames ; $4006 frame table
	dw BethSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw Data_58_7ce0 ; $400c per-slot OAM data
BethSpriteFrames:
	dw BethSpriteFrame00 ; $400e
	dw BethSpriteFrame01 ; $4010
	dw BethSpriteFrame02 ; $4012
	dw BethSpriteFrame03 ; $4014
	dw BethSpriteFrame04 ; $4016
	dw BethSpriteFrame05 ; $4018
	dw BethSpriteFrame06 ; $401a
	dw BethSpriteFrame07 ; $401c
	dw BethSpriteFrame08 ; $401e
	dw BethSpriteFrame09 ; $4020
	dw BethSpriteFrame10 ; $4022
	dw BethSpriteFrame01 ; $4024
	dw BethSpriteFrame02 ; $4026
	dw BethSpriteFrame03 ; $4028
	dw BethSpriteFrame11 ; $402a
	dw BethSpriteFrame12 ; $402c
	dw BethSpriteFrame01 ; $402e
	dw BethSpriteFrame02 ; $4030
	dw BethSpriteFrame03 ; $4032
	dw BethSpriteFrame13 ; $4034
	dw BethSpriteFrame14 ; $4036
	dw BethSpriteFrame06 ; $4038
	dw BethSpriteFrame07 ; $403a
	dw BethSpriteFrame08 ; $403c
	dw BethSpriteFrame15 ; $403e
	dw BethSpriteFrame16 ; $4040
	dw BethSpriteFrame16 ; $4042
	dw BethSpriteFrame16 ; $4044
	dw BethSpriteFrame17 ; $4046
	dw BethSpriteFrame17 ; $4048
	dw BethSpriteFrame18 ; $404a
	dw BethSpriteFrame18 ; $404c
	dw BethSpriteFrame18 ; $404e
	dw BethSpriteFrame19 ; $4050
	dw BethSpriteFrame19 ; $4052
	dw BethSpriteFrame20 ; $4054
	dw BethSpriteFrame20 ; $4056
	dw BethSpriteFrame20 ; $4058
	dw BethSpriteFrame21 ; $405a
	dw BethSpriteFrame21 ; $405c
	dw BethSpriteFrame22 ; $405e
	dw BethSpriteFrame22 ; $4060
	dw BethSpriteFrame22 ; $4062
	dw BethSpriteFrame23 ; $4064
	dw BethSpriteFrame23 ; $4066
	dw BethSpriteFrame24 ; $4068
	dw BethSpriteFrame24 ; $406a
	dw BethSpriteFrame24 ; $406c
	dw BethSpriteFrame25 ; $406e
	dw BethSpriteFrame25 ; $4070
	dw BethSpriteFrame26 ; $4072
	dw BethSpriteFrame26 ; $4074
	dw BethSpriteFrame26 ; $4076
	dw BethSpriteFrame27 ; $4078
	dw BethSpriteFrame27 ; $407a
	dw BethSpriteFrame28 ; $407c
	dw BethSpriteFrame28 ; $407e
	dw BethSpriteFrame28 ; $4080
	dw BethSpriteFrame29 ; $4082
	dw BethSpriteFrame29 ; $4084
	dw BethSpriteFrame30 ; $4086
	dw BethSpriteFrame30 ; $4088
	dw BethSpriteFrame30 ; $408a
	dw BethSpriteFrame31 ; $408c
	dw BethSpriteFrame31 ; $408e
	dw BethSpriteFrame32 ; $4090
	dw BethSpriteFrame32 ; $4092
	dw BethSpriteFrame32 ; $4094
	dw BethSpriteFrame33 ; $4096
	dw BethSpriteFrame33 ; $4098
	dw BethSpriteFrame34 ; $409a
	dw BethSpriteFrame34 ; $409c
	dw BethSpriteFrame34 ; $409e
	dw BethSpriteFrame35 ; $40a0
	dw BethSpriteFrame35 ; $40a2
	dw BethSpriteFrame36 ; $40a4
	dw BethSpriteFrame36 ; $40a6
	dw BethSpriteFrame36 ; $40a8
	dw BethSpriteFrame37 ; $40aa
	dw BethSpriteFrame37 ; $40ac
	dw BethSpriteFrame38 ; $40ae
	dw BethSpriteFrame38 ; $40b0
	dw BethSpriteFrame38 ; $40b2
	dw BethSpriteFrame39 ; $40b4
	dw BethSpriteFrame39 ; $40b6
	dw BethSpriteFrame40 ; $40b8
	dw BethSpriteFrame40 ; $40ba
	dw BethSpriteFrame40 ; $40bc
	dw BethSpriteFrame41 ; $40be
	dw BethSpriteFrame41 ; $40c0
	dw BethSpriteFrame42 ; $40c2
	dw BethSpriteFrame42 ; $40c4
	dw BethSpriteFrame42 ; $40c6
	dw BethSpriteFrame42 ; $40c8
	dw BethSpriteFrame42 ; $40ca
	dw BethSpriteFrame43 ; $40cc
	dw BethSpriteFrame43 ; $40ce
	dw BethSpriteFrame43 ; $40d0
	dw BethSpriteFrame43 ; $40d2
	dw BethSpriteFrame43 ; $40d4
	dw BethSpriteFrame44 ; $40d6
	dw BethSpriteFrame44 ; $40d8
	dw BethSpriteFrame44 ; $40da
	dw BethSpriteFrame45 ; $40dc
	dw BethSpriteFrame45 ; $40de
	dw BethSpriteFrame46 ; $40e0
	dw BethSpriteFrame46 ; $40e2
	dw BethSpriteFrame46 ; $40e4
	dw BethSpriteFrame47 ; $40e6
	dw BethSpriteFrame47 ; $40e8
	dw BethSpriteFrame48 ; $40ea
	dw BethSpriteFrame48 ; $40ec
	dw BethSpriteFrame48 ; $40ee
	dw BethSpriteFrame49 ; $40f0
	dw BethSpriteFrame49 ; $40f2
	dw BethSpriteFrame50 ; $40f4
	dw BethSpriteFrame50 ; $40f6
	dw BethSpriteFrame50 ; $40f8
	dw BethSpriteFrame50 ; $40fa
	dw BethSpriteFrame50 ; $40fc
	dw BethSpriteFrame51 ; $40fe
	dw BethSpriteFrame51 ; $4100
	dw BethSpriteFrame51 ; $4102
	dw BethSpriteFrame51 ; $4104
	dw BethSpriteFrame51 ; $4106
	dw BethSpriteFrame52 ; $4108
	dw BethSpriteFrame52 ; $410a
	dw BethSpriteFrame52 ; $410c
	dw BethSpriteFrame52 ; $410e
	dw BethSpriteFrame52 ; $4110
	dw BethSpriteFrame53 ; $4112
	dw BethSpriteFrame53 ; $4114
	dw BethSpriteFrame53 ; $4116
	dw BethSpriteFrame53 ; $4118
	dw BethSpriteFrame53 ; $411a
	dw BethSpriteFrame54 ; $411c
	dw BethSpriteFrame54 ; $411e
	dw BethSpriteFrame54 ; $4120
	dw BethSpriteFrame54 ; $4122
	dw BethSpriteFrame54 ; $4124
	dw BethSpriteFrame55 ; $4126
	dw BethSpriteFrame55 ; $4128
	dw BethSpriteFrame55 ; $412a
	dw BethSpriteFrame55 ; $412c
	dw BethSpriteFrame55 ; $412e
BethSpriteFrame00:
	INCBIN "data/bank_058/d_4130.bin" ; $4130, 240 bytes
BethSpriteFrame01:
	INCBIN "data/bank_058/d_4220.bin" ; $4220, 240 bytes
BethSpriteFrame02:
	INCBIN "data/bank_058/d_4310.bin" ; $4310, 240 bytes
BethSpriteFrame03:
	INCBIN "data/bank_058/d_4400.bin" ; $4400, 240 bytes
BethSpriteFrame04:
	INCBIN "data/bank_058/d_44f0.bin" ; $44f0, 240 bytes
BethSpriteFrame05:
	INCBIN "data/bank_058/d_45e0.bin" ; $45e0, 240 bytes
BethSpriteFrame06:
	INCBIN "data/bank_058/d_46d0.bin" ; $46d0, 240 bytes
BethSpriteFrame07:
	INCBIN "data/bank_058/d_47c0.bin" ; $47c0, 240 bytes
BethSpriteFrame08:
	INCBIN "data/bank_058/d_48b0.bin" ; $48b0, 240 bytes
BethSpriteFrame09:
	INCBIN "data/bank_058/d_49a0.bin" ; $49a0, 240 bytes
BethSpriteFrame10:
	INCBIN "data/bank_058/d_4a90.bin" ; $4a90, 240 bytes
BethSpriteFrame11:
	INCBIN "data/bank_058/d_4b80.bin" ; $4b80, 240 bytes
BethSpriteFrame12:
	INCBIN "data/bank_058/d_4c70.bin" ; $4c70, 240 bytes
BethSpriteFrame13:
	INCBIN "data/bank_058/d_4d60.bin" ; $4d60, 240 bytes
BethSpriteFrame14:
	INCBIN "data/bank_058/d_4e50.bin" ; $4e50, 240 bytes
BethSpriteFrame15:
	INCBIN "data/bank_058/d_4f40.bin" ; $4f40, 240 bytes
BethSpriteFrame16:
	INCBIN "data/bank_058/d_5030.bin" ; $5030, 240 bytes
BethSpriteFrame17:
	INCBIN "data/bank_058/d_5120.bin" ; $5120, 240 bytes
BethSpriteFrame18:
	INCBIN "data/bank_058/d_5210.bin" ; $5210, 240 bytes
BethSpriteFrame19:
	INCBIN "data/bank_058/d_5300.bin" ; $5300, 240 bytes
BethSpriteFrame20:
	INCBIN "data/bank_058/d_53f0.bin" ; $53f0, 240 bytes
BethSpriteFrame21:
	INCBIN "data/bank_058/d_54e0.bin" ; $54e0, 240 bytes
BethSpriteFrame22:
	INCBIN "data/bank_058/d_55d0.bin" ; $55d0, 240 bytes
BethSpriteFrame23:
	INCBIN "data/bank_058/d_56c0.bin" ; $56c0, 240 bytes
BethSpriteFrame24:
	INCBIN "data/bank_058/d_57b0.bin" ; $57b0, 240 bytes
BethSpriteFrame25:
	INCBIN "data/bank_058/d_58a0.bin" ; $58a0, 240 bytes
BethSpriteFrame26:
	INCBIN "data/bank_058/d_5990.bin" ; $5990, 240 bytes
BethSpriteFrame27:
	INCBIN "data/bank_058/d_5a80.bin" ; $5a80, 240 bytes
BethSpriteFrame28:
	INCBIN "data/bank_058/d_5b70.bin" ; $5b70, 240 bytes
BethSpriteFrame29:
	INCBIN "data/bank_058/d_5c60.bin" ; $5c60, 240 bytes
BethSpriteFrame30:
	INCBIN "data/bank_058/d_5d50.bin" ; $5d50, 240 bytes
BethSpriteFrame31:
	INCBIN "data/bank_058/d_5e40.bin" ; $5e40, 240 bytes
BethSpriteFrame32:
	INCBIN "data/bank_058/d_5f30.bin" ; $5f30, 240 bytes
BethSpriteFrame33:
	INCBIN "data/bank_058/d_6020.bin" ; $6020, 240 bytes
BethSpriteFrame34:
	INCBIN "data/bank_058/d_6110.bin" ; $6110, 240 bytes
BethSpriteFrame35:
	INCBIN "data/bank_058/d_6200.bin" ; $6200, 240 bytes
BethSpriteFrame36:
	INCBIN "data/bank_058/d_62f0.bin" ; $62f0, 240 bytes
BethSpriteFrame37:
	INCBIN "data/bank_058/d_63e0.bin" ; $63e0, 240 bytes
BethSpriteFrame38:
	INCBIN "data/bank_058/d_64d0.bin" ; $64d0, 240 bytes
BethSpriteFrame39:
	INCBIN "data/bank_058/d_65c0.bin" ; $65c0, 240 bytes
BethSpriteFrame40:
	INCBIN "data/bank_058/d_66b0.bin" ; $66b0, 320 bytes
BethSpriteFrame41:
	INCBIN "data/bank_058/d_67f0.bin" ; $67f0, 320 bytes
BethSpriteFrame42:
	INCBIN "data/bank_058/d_6930.bin" ; $6930, 240 bytes
BethSpriteFrame43:
	INCBIN "data/bank_058/d_6a20.bin" ; $6a20, 240 bytes
BethSpriteFrame44:
	INCBIN "data/bank_058/d_6b10.bin" ; $6b10, 240 bytes
BethSpriteFrame45:
	INCBIN "data/bank_058/d_6c00.bin" ; $6c00, 240 bytes
BethSpriteFrame46:
	INCBIN "data/bank_058/d_6cf0.bin" ; $6cf0, 240 bytes
BethSpriteFrame47:
	INCBIN "data/bank_058/d_6de0.bin" ; $6de0, 240 bytes
BethSpriteFrame48:
	INCBIN "data/bank_058/d_6ed0.bin" ; $6ed0, 240 bytes
BethSpriteFrame49:
	INCBIN "data/bank_058/d_6fc0.bin" ; $6fc0, 240 bytes
BethSpriteFrame50:
	INCBIN "data/bank_058/d_70b0.bin" ; $70b0, 240 bytes
BethSpriteFrame51:
	INCBIN "data/bank_058/d_71a0.bin" ; $71a0, 240 bytes
BethSpriteFrame52:
	INCBIN "data/bank_058/d_7290.bin" ; $7290, 240 bytes
BethSpriteFrame53:
	INCBIN "data/bank_058/d_7380.bin" ; $7380, 240 bytes
BethSpriteFrame54:
	INCBIN "data/bank_058/d_7470.bin" ; $7470, 240 bytes
BethSpriteFrame55:
	INCBIN "data/bank_058/d_7560.bin" ; $7560, 240 bytes
Data_58_7650:
	INCBIN "data/bank_058/d_7650.bin" ; $7650, 1680 bytes
Data_58_7ce0:
	INCBIN "data/bank_058/d_7ce0.bin" ; $7ce0, 580 bytes
BethSpriteAnims:
	dw BethSpriteAnim00 ; $7f24
	dw BethSpriteAnim01 ; $7f26
	dw BethSpriteAnim02 ; $7f28
	dw BethSpriteAnim03 ; $7f2a
	dw BethSpriteAnim04 ; $7f2c
	dw BethSpriteAnim05 ; $7f2e
	dw BethSpriteAnim06 ; $7f30
	dw BethSpriteAnim07 ; $7f32
	dw BethSpriteAnim08 ; $7f34
	dw BethSpriteAnim09 ; $7f36
	dw BethSpriteAnim10 ; $7f38
	dw BethSpriteAnim11 ; $7f3a
	dw BethSpriteAnim12 ; $7f3c
	dw BethSpriteAnim13 ; $7f3e
	dw BethSpriteAnim14 ; $7f40
	dw BethSpriteAnim15 ; $7f42
	dw BethSpriteAnim16 ; $7f44
	dw BethSpriteAnim17 ; $7f46
	dw BethSpriteAnim18 ; $7f48
BethSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	db $00
	db $ff, $fd
BethSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
BethSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
BethSpriteAnim03:
	; $7f5d, 18 bytes (sprite_anim)
	anim_frame $17, $14
	anim_frame $18, $14
	anim_frame $19, $06
	anim_frame $18, $06
	anim_frame $19, $06
	anim_frame $18, $06
	anim_frame $19, $06
	anim_frame $18, $28
	anim_loop $00
BethSpriteAnim04:
	; $7f6f, 8 bytes (sprite_anim)
	anim_frame $1a, $28
	anim_frame $1b, $14
	anim_frame $1c, $14
	anim_loop $02
BethSpriteAnim05:
	; $7f77, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
BethSpriteAnim06:
	; $7f7d, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
BethSpriteAnim07:
	; $7f83, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
BethSpriteAnim08:
	; $7f89, 5 bytes (sprite_anim)
	db $15, $04, $16, $14, $fd
BethSpriteAnim09:
	; $7f8e, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
BethSpriteAnim10:
	; $7f92, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
BethSpriteAnim11:
	; $7f96, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
BethSpriteAnim12:
	; $7f9a, 3 bytes (sprite_anim)
	db $15, $18, $fd
BethSpriteAnim13:
	; $7f9d, 3 bytes (sprite_anim)
	db $05, $ff, $fd
BethSpriteAnim14:
	; $7fa0, 3 bytes (sprite_anim)
	db $08, $ff, $fd
BethSpriteAnim15:
	; $7fa3, 3 bytes (sprite_anim)
	db $0b, $ff, $fd
BethSpriteAnim16:
	; $7fa6, 3 bytes (sprite_anim)
	db $0e, $ff, $fd
BethSpriteAnim17:
	; $7fa9, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
BethSpriteAnim18:
	; $7fb5, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fbd, 67 bytes fill to bank end (linker-padded)
