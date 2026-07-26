SECTION "ROM Bank $4a", ROMX[$4000], BANK[$4a]

	dw ACozSpriteDesc ; $4000
ACozSpriteDesc:
	dw $0007 ; $4002
	dw $0003 ; $4004
	dw ACozSpriteFrames ; $4006 frame table
	dw ACozSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw Data_4a_7ce0 ; $400c per-slot OAM data
ACozSpriteFrames:
	dw ACozSpriteFrame00 ; $400e
	dw ACozSpriteFrame01 ; $4010
	dw ACozSpriteFrame02 ; $4012
	dw ACozSpriteFrame03 ; $4014
	dw ACozSpriteFrame04 ; $4016
	dw ACozSpriteFrame05 ; $4018
	dw ACozSpriteFrame06 ; $401a
	dw ACozSpriteFrame07 ; $401c
	dw ACozSpriteFrame08 ; $401e
	dw ACozSpriteFrame09 ; $4020
	dw ACozSpriteFrame10 ; $4022
	dw ACozSpriteFrame01 ; $4024
	dw ACozSpriteFrame02 ; $4026
	dw ACozSpriteFrame03 ; $4028
	dw ACozSpriteFrame11 ; $402a
	dw ACozSpriteFrame12 ; $402c
	dw ACozSpriteFrame01 ; $402e
	dw ACozSpriteFrame02 ; $4030
	dw ACozSpriteFrame03 ; $4032
	dw ACozSpriteFrame13 ; $4034
	dw ACozSpriteFrame14 ; $4036
	dw ACozSpriteFrame06 ; $4038
	dw ACozSpriteFrame07 ; $403a
	dw ACozSpriteFrame08 ; $403c
	dw ACozSpriteFrame15 ; $403e
	dw ACozSpriteFrame16 ; $4040
	dw ACozSpriteFrame16 ; $4042
	dw ACozSpriteFrame16 ; $4044
	dw ACozSpriteFrame17 ; $4046
	dw ACozSpriteFrame17 ; $4048
	dw ACozSpriteFrame18 ; $404a
	dw ACozSpriteFrame18 ; $404c
	dw ACozSpriteFrame18 ; $404e
	dw ACozSpriteFrame19 ; $4050
	dw ACozSpriteFrame19 ; $4052
	dw ACozSpriteFrame20 ; $4054
	dw ACozSpriteFrame20 ; $4056
	dw ACozSpriteFrame20 ; $4058
	dw ACozSpriteFrame21 ; $405a
	dw ACozSpriteFrame21 ; $405c
	dw ACozSpriteFrame22 ; $405e
	dw ACozSpriteFrame22 ; $4060
	dw ACozSpriteFrame22 ; $4062
	dw ACozSpriteFrame23 ; $4064
	dw ACozSpriteFrame23 ; $4066
	dw ACozSpriteFrame24 ; $4068
	dw ACozSpriteFrame24 ; $406a
	dw ACozSpriteFrame24 ; $406c
	dw ACozSpriteFrame25 ; $406e
	dw ACozSpriteFrame25 ; $4070
	dw ACozSpriteFrame26 ; $4072
	dw ACozSpriteFrame26 ; $4074
	dw ACozSpriteFrame26 ; $4076
	dw ACozSpriteFrame27 ; $4078
	dw ACozSpriteFrame27 ; $407a
	dw ACozSpriteFrame28 ; $407c
	dw ACozSpriteFrame28 ; $407e
	dw ACozSpriteFrame28 ; $4080
	dw ACozSpriteFrame29 ; $4082
	dw ACozSpriteFrame29 ; $4084
	dw ACozSpriteFrame30 ; $4086
	dw ACozSpriteFrame30 ; $4088
	dw ACozSpriteFrame30 ; $408a
	dw ACozSpriteFrame31 ; $408c
	dw ACozSpriteFrame31 ; $408e
	dw ACozSpriteFrame32 ; $4090
	dw ACozSpriteFrame32 ; $4092
	dw ACozSpriteFrame32 ; $4094
	dw ACozSpriteFrame33 ; $4096
	dw ACozSpriteFrame33 ; $4098
	dw ACozSpriteFrame34 ; $409a
	dw ACozSpriteFrame34 ; $409c
	dw ACozSpriteFrame34 ; $409e
	dw ACozSpriteFrame35 ; $40a0
	dw ACozSpriteFrame35 ; $40a2
	dw ACozSpriteFrame36 ; $40a4
	dw ACozSpriteFrame36 ; $40a6
	dw ACozSpriteFrame36 ; $40a8
	dw ACozSpriteFrame37 ; $40aa
	dw ACozSpriteFrame37 ; $40ac
	dw ACozSpriteFrame38 ; $40ae
	dw ACozSpriteFrame38 ; $40b0
	dw ACozSpriteFrame38 ; $40b2
	dw ACozSpriteFrame39 ; $40b4
	dw ACozSpriteFrame39 ; $40b6
	dw ACozSpriteFrame40 ; $40b8
	dw ACozSpriteFrame40 ; $40ba
	dw ACozSpriteFrame40 ; $40bc
	dw ACozSpriteFrame41 ; $40be
	dw ACozSpriteFrame41 ; $40c0
	dw ACozSpriteFrame42 ; $40c2
	dw ACozSpriteFrame42 ; $40c4
	dw ACozSpriteFrame42 ; $40c6
	dw ACozSpriteFrame42 ; $40c8
	dw ACozSpriteFrame42 ; $40ca
	dw ACozSpriteFrame43 ; $40cc
	dw ACozSpriteFrame43 ; $40ce
	dw ACozSpriteFrame43 ; $40d0
	dw ACozSpriteFrame43 ; $40d2
	dw ACozSpriteFrame43 ; $40d4
	dw ACozSpriteFrame44 ; $40d6
	dw ACozSpriteFrame44 ; $40d8
	dw ACozSpriteFrame44 ; $40da
	dw ACozSpriteFrame45 ; $40dc
	dw ACozSpriteFrame45 ; $40de
	dw ACozSpriteFrame46 ; $40e0
	dw ACozSpriteFrame46 ; $40e2
	dw ACozSpriteFrame46 ; $40e4
	dw ACozSpriteFrame47 ; $40e6
	dw ACozSpriteFrame47 ; $40e8
	dw ACozSpriteFrame48 ; $40ea
	dw ACozSpriteFrame48 ; $40ec
	dw ACozSpriteFrame48 ; $40ee
	dw ACozSpriteFrame49 ; $40f0
	dw ACozSpriteFrame49 ; $40f2
	dw ACozSpriteFrame50 ; $40f4
	dw ACozSpriteFrame50 ; $40f6
	dw ACozSpriteFrame50 ; $40f8
	dw ACozSpriteFrame50 ; $40fa
	dw ACozSpriteFrame50 ; $40fc
	dw ACozSpriteFrame51 ; $40fe
	dw ACozSpriteFrame51 ; $4100
	dw ACozSpriteFrame51 ; $4102
	dw ACozSpriteFrame51 ; $4104
	dw ACozSpriteFrame51 ; $4106
	dw ACozSpriteFrame52 ; $4108
	dw ACozSpriteFrame52 ; $410a
	dw ACozSpriteFrame52 ; $410c
	dw ACozSpriteFrame52 ; $410e
	dw ACozSpriteFrame52 ; $4110
	dw ACozSpriteFrame53 ; $4112
	dw ACozSpriteFrame53 ; $4114
	dw ACozSpriteFrame53 ; $4116
	dw ACozSpriteFrame53 ; $4118
	dw ACozSpriteFrame53 ; $411a
	dw ACozSpriteFrame54 ; $411c
	dw ACozSpriteFrame54 ; $411e
	dw ACozSpriteFrame54 ; $4120
	dw ACozSpriteFrame54 ; $4122
	dw ACozSpriteFrame54 ; $4124
	dw ACozSpriteFrame55 ; $4126
	dw ACozSpriteFrame55 ; $4128
	dw ACozSpriteFrame55 ; $412a
	dw ACozSpriteFrame55 ; $412c
	dw ACozSpriteFrame55 ; $412e
ACozSpriteFrame00:
	INCBIN "data/bank_04a/d_4130.bin" ; $4130, 240 bytes
ACozSpriteFrame01:
	INCBIN "data/bank_04a/d_4220.bin" ; $4220, 240 bytes
ACozSpriteFrame02:
	INCBIN "data/bank_04a/d_4310.bin" ; $4310, 240 bytes
ACozSpriteFrame03:
	INCBIN "data/bank_04a/d_4400.bin" ; $4400, 240 bytes
ACozSpriteFrame04:
	INCBIN "data/bank_04a/d_44f0.bin" ; $44f0, 240 bytes
ACozSpriteFrame05:
	INCBIN "data/bank_04a/d_45e0.bin" ; $45e0, 240 bytes
ACozSpriteFrame06:
	INCBIN "data/bank_04a/d_46d0.bin" ; $46d0, 240 bytes
ACozSpriteFrame07:
	INCBIN "data/bank_04a/d_47c0.bin" ; $47c0, 240 bytes
ACozSpriteFrame08:
	INCBIN "data/bank_04a/d_48b0.bin" ; $48b0, 240 bytes
ACozSpriteFrame09:
	INCBIN "data/bank_04a/d_49a0.bin" ; $49a0, 240 bytes
ACozSpriteFrame10:
	INCBIN "data/bank_04a/d_4a90.bin" ; $4a90, 240 bytes
ACozSpriteFrame11:
	INCBIN "data/bank_04a/d_4b80.bin" ; $4b80, 240 bytes
ACozSpriteFrame12:
	INCBIN "data/bank_04a/d_4c70.bin" ; $4c70, 240 bytes
ACozSpriteFrame13:
	INCBIN "data/bank_04a/d_4d60.bin" ; $4d60, 240 bytes
ACozSpriteFrame14:
	INCBIN "data/bank_04a/d_4e50.bin" ; $4e50, 240 bytes
ACozSpriteFrame15:
	INCBIN "data/bank_04a/d_4f40.bin" ; $4f40, 240 bytes
ACozSpriteFrame16:
	INCBIN "data/bank_04a/d_5030.bin" ; $5030, 240 bytes
ACozSpriteFrame17:
	INCBIN "data/bank_04a/d_5120.bin" ; $5120, 240 bytes
ACozSpriteFrame18:
	INCBIN "data/bank_04a/d_5210.bin" ; $5210, 240 bytes
ACozSpriteFrame19:
	INCBIN "data/bank_04a/d_5300.bin" ; $5300, 240 bytes
ACozSpriteFrame20:
	INCBIN "data/bank_04a/d_53f0.bin" ; $53f0, 240 bytes
ACozSpriteFrame21:
	INCBIN "data/bank_04a/d_54e0.bin" ; $54e0, 240 bytes
ACozSpriteFrame22:
	INCBIN "data/bank_04a/d_55d0.bin" ; $55d0, 240 bytes
ACozSpriteFrame23:
	INCBIN "data/bank_04a/d_56c0.bin" ; $56c0, 240 bytes
ACozSpriteFrame24:
	INCBIN "data/bank_04a/d_57b0.bin" ; $57b0, 240 bytes
ACozSpriteFrame25:
	INCBIN "data/bank_04a/d_58a0.bin" ; $58a0, 240 bytes
ACozSpriteFrame26:
	INCBIN "data/bank_04a/d_5990.bin" ; $5990, 240 bytes
ACozSpriteFrame27:
	INCBIN "data/bank_04a/d_5a80.bin" ; $5a80, 240 bytes
ACozSpriteFrame28:
	INCBIN "data/bank_04a/d_5b70.bin" ; $5b70, 240 bytes
ACozSpriteFrame29:
	INCBIN "data/bank_04a/d_5c60.bin" ; $5c60, 240 bytes
ACozSpriteFrame30:
	INCBIN "data/bank_04a/d_5d50.bin" ; $5d50, 240 bytes
ACozSpriteFrame31:
	INCBIN "data/bank_04a/d_5e40.bin" ; $5e40, 240 bytes
ACozSpriteFrame32:
	INCBIN "data/bank_04a/d_5f30.bin" ; $5f30, 240 bytes
ACozSpriteFrame33:
	INCBIN "data/bank_04a/d_6020.bin" ; $6020, 240 bytes
ACozSpriteFrame34:
	INCBIN "data/bank_04a/d_6110.bin" ; $6110, 240 bytes
ACozSpriteFrame35:
	INCBIN "data/bank_04a/d_6200.bin" ; $6200, 240 bytes
ACozSpriteFrame36:
	INCBIN "data/bank_04a/d_62f0.bin" ; $62f0, 240 bytes
ACozSpriteFrame37:
	INCBIN "data/bank_04a/d_63e0.bin" ; $63e0, 240 bytes
ACozSpriteFrame38:
	INCBIN "data/bank_04a/d_64d0.bin" ; $64d0, 240 bytes
ACozSpriteFrame39:
	INCBIN "data/bank_04a/d_65c0.bin" ; $65c0, 240 bytes
ACozSpriteFrame40:
	INCBIN "data/bank_04a/d_66b0.bin" ; $66b0, 320 bytes
ACozSpriteFrame41:
	INCBIN "data/bank_04a/d_67f0.bin" ; $67f0, 320 bytes
ACozSpriteFrame42:
	INCBIN "data/bank_04a/d_6930.bin" ; $6930, 240 bytes
ACozSpriteFrame43:
	INCBIN "data/bank_04a/d_6a20.bin" ; $6a20, 240 bytes
ACozSpriteFrame44:
	INCBIN "data/bank_04a/d_6b10.bin" ; $6b10, 240 bytes
ACozSpriteFrame45:
	INCBIN "data/bank_04a/d_6c00.bin" ; $6c00, 240 bytes
ACozSpriteFrame46:
	INCBIN "data/bank_04a/d_6cf0.bin" ; $6cf0, 240 bytes
ACozSpriteFrame47:
	INCBIN "data/bank_04a/d_6de0.bin" ; $6de0, 240 bytes
ACozSpriteFrame48:
	INCBIN "data/bank_04a/d_6ed0.bin" ; $6ed0, 240 bytes
ACozSpriteFrame49:
	INCBIN "data/bank_04a/d_6fc0.bin" ; $6fc0, 240 bytes
ACozSpriteFrame50:
	INCBIN "data/bank_04a/d_70b0.bin" ; $70b0, 240 bytes
ACozSpriteFrame51:
	INCBIN "data/bank_04a/d_71a0.bin" ; $71a0, 240 bytes
ACozSpriteFrame52:
	INCBIN "data/bank_04a/d_7290.bin" ; $7290, 240 bytes
ACozSpriteFrame53:
	INCBIN "data/bank_04a/d_7380.bin" ; $7380, 240 bytes
ACozSpriteFrame54:
	INCBIN "data/bank_04a/d_7470.bin" ; $7470, 240 bytes
ACozSpriteFrame55:
	INCBIN "data/bank_04a/d_7560.bin" ; $7560, 240 bytes
Data_4a_7650:
	INCBIN "data/bank_04a/d_7650.bin" ; $7650, 1680 bytes
Data_4a_7ce0:
	INCBIN "data/bank_04a/d_7ce0.bin" ; $7ce0, 580 bytes
ACozSpriteAnims:
	dw ACozSpriteAnim00 ; $7f24
	dw ACozSpriteAnim01 ; $7f26
	dw ACozSpriteAnim02 ; $7f28
	dw ACozSpriteAnim03 ; $7f2a
	dw ACozSpriteAnim04 ; $7f2c
	dw ACozSpriteAnim05 ; $7f2e
	dw ACozSpriteAnim06 ; $7f30
	dw ACozSpriteAnim07 ; $7f32
	dw ACozSpriteAnim08 ; $7f34
	dw ACozSpriteAnim09 ; $7f36
	dw ACozSpriteAnim10 ; $7f38
	dw ACozSpriteAnim11 ; $7f3a
	dw ACozSpriteAnim12 ; $7f3c
	dw ACozSpriteAnim13 ; $7f3e
	dw ACozSpriteAnim14 ; $7f40
	dw ACozSpriteAnim15 ; $7f42
	dw ACozSpriteAnim16 ; $7f44
	dw ACozSpriteAnim17 ; $7f46
	dw ACozSpriteAnim18 ; $7f48
ACozSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	db $00
	db $ff, $fd
ACozSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
ACozSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
ACozSpriteAnim03:
	; $7f5d, 8 bytes (sprite_anim)
	anim_frame $17, $28
	anim_frame $18, $1e
	anim_frame $19, $3c
	anim_loop $00
ACozSpriteAnim04:
	; $7f65, 12 bytes (sprite_anim)
	anim_frame $1a, $28
	anim_frame $1b, $14
	anim_frame $1c, $06
	anim_frame $1b, $06
	anim_frame $1c, $06
	anim_loop $02
ACozSpriteAnim05:
	; $7f71, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
ACozSpriteAnim06:
	; $7f77, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
ACozSpriteAnim07:
	; $7f7d, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
ACozSpriteAnim08:
	; $7f83, 5 bytes (sprite_anim)
	db $15, $04, $16, $14, $fd
ACozSpriteAnim09:
	; $7f88, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
ACozSpriteAnim10:
	; $7f8c, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
ACozSpriteAnim11:
	; $7f90, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
ACozSpriteAnim12:
	; $7f94, 3 bytes (sprite_anim)
	db $15, $18, $fd
ACozSpriteAnim13:
	; $7f97, 3 bytes (sprite_anim)
	db $05, $ff, $fd
ACozSpriteAnim14:
	; $7f9a, 3 bytes (sprite_anim)
	db $08, $ff, $fd
ACozSpriteAnim15:
	; $7f9d, 3 bytes (sprite_anim)
	db $0b, $ff, $fd
ACozSpriteAnim16:
	; $7fa0, 3 bytes (sprite_anim)
	db $0e, $ff, $fd
ACozSpriteAnim17:
	; $7fa3, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
ACozSpriteAnim18:
	; $7faf, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fb7, 73 bytes fill to bank end (linker-padded)
