SECTION "ROM Bank $46", ROMX[$4000], BANK[$46]

	dw SammiSpriteDesc ; $4000
SammiSpriteDesc:
	dw $0003 ; $4002
	dw $0003 ; $4004
	dw SammiSpriteFrames ; $4006 frame table
	dw SammiSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw Data_46_7ce0 ; $400c per-slot OAM data
SammiSpriteFrames:
	dw SammiSpriteFrame00 ; $400e
	dw SammiSpriteFrame01 ; $4010
	dw SammiSpriteFrame02 ; $4012
	dw SammiSpriteFrame03 ; $4014
	dw SammiSpriteFrame04 ; $4016
	dw SammiSpriteFrame05 ; $4018
	dw SammiSpriteFrame06 ; $401a
	dw SammiSpriteFrame07 ; $401c
	dw SammiSpriteFrame08 ; $401e
	dw SammiSpriteFrame09 ; $4020
	dw SammiSpriteFrame10 ; $4022
	dw SammiSpriteFrame01 ; $4024
	dw SammiSpriteFrame02 ; $4026
	dw SammiSpriteFrame03 ; $4028
	dw SammiSpriteFrame11 ; $402a
	dw SammiSpriteFrame12 ; $402c
	dw SammiSpriteFrame01 ; $402e
	dw SammiSpriteFrame02 ; $4030
	dw SammiSpriteFrame03 ; $4032
	dw SammiSpriteFrame13 ; $4034
	dw SammiSpriteFrame14 ; $4036
	dw SammiSpriteFrame06 ; $4038
	dw SammiSpriteFrame07 ; $403a
	dw SammiSpriteFrame08 ; $403c
	dw SammiSpriteFrame15 ; $403e
	dw SammiSpriteFrame16 ; $4040
	dw SammiSpriteFrame16 ; $4042
	dw SammiSpriteFrame16 ; $4044
	dw SammiSpriteFrame17 ; $4046
	dw SammiSpriteFrame17 ; $4048
	dw SammiSpriteFrame18 ; $404a
	dw SammiSpriteFrame18 ; $404c
	dw SammiSpriteFrame18 ; $404e
	dw SammiSpriteFrame19 ; $4050
	dw SammiSpriteFrame19 ; $4052
	dw SammiSpriteFrame20 ; $4054
	dw SammiSpriteFrame20 ; $4056
	dw SammiSpriteFrame20 ; $4058
	dw SammiSpriteFrame21 ; $405a
	dw SammiSpriteFrame21 ; $405c
	dw SammiSpriteFrame22 ; $405e
	dw SammiSpriteFrame22 ; $4060
	dw SammiSpriteFrame22 ; $4062
	dw SammiSpriteFrame23 ; $4064
	dw SammiSpriteFrame23 ; $4066
	dw SammiSpriteFrame24 ; $4068
	dw SammiSpriteFrame24 ; $406a
	dw SammiSpriteFrame24 ; $406c
	dw SammiSpriteFrame25 ; $406e
	dw SammiSpriteFrame25 ; $4070
	dw SammiSpriteFrame26 ; $4072
	dw SammiSpriteFrame26 ; $4074
	dw SammiSpriteFrame26 ; $4076
	dw SammiSpriteFrame27 ; $4078
	dw SammiSpriteFrame27 ; $407a
	dw SammiSpriteFrame28 ; $407c
	dw SammiSpriteFrame28 ; $407e
	dw SammiSpriteFrame28 ; $4080
	dw SammiSpriteFrame29 ; $4082
	dw SammiSpriteFrame29 ; $4084
	dw SammiSpriteFrame30 ; $4086
	dw SammiSpriteFrame30 ; $4088
	dw SammiSpriteFrame30 ; $408a
	dw SammiSpriteFrame31 ; $408c
	dw SammiSpriteFrame31 ; $408e
	dw SammiSpriteFrame32 ; $4090
	dw SammiSpriteFrame32 ; $4092
	dw SammiSpriteFrame32 ; $4094
	dw SammiSpriteFrame33 ; $4096
	dw SammiSpriteFrame33 ; $4098
	dw SammiSpriteFrame34 ; $409a
	dw SammiSpriteFrame34 ; $409c
	dw SammiSpriteFrame34 ; $409e
	dw SammiSpriteFrame35 ; $40a0
	dw SammiSpriteFrame35 ; $40a2
	dw SammiSpriteFrame36 ; $40a4
	dw SammiSpriteFrame36 ; $40a6
	dw SammiSpriteFrame36 ; $40a8
	dw SammiSpriteFrame37 ; $40aa
	dw SammiSpriteFrame37 ; $40ac
	dw SammiSpriteFrame38 ; $40ae
	dw SammiSpriteFrame38 ; $40b0
	dw SammiSpriteFrame38 ; $40b2
	dw SammiSpriteFrame39 ; $40b4
	dw SammiSpriteFrame39 ; $40b6
	dw SammiSpriteFrame40 ; $40b8
	dw SammiSpriteFrame40 ; $40ba
	dw SammiSpriteFrame40 ; $40bc
	dw SammiSpriteFrame41 ; $40be
	dw SammiSpriteFrame41 ; $40c0
	dw SammiSpriteFrame42 ; $40c2
	dw SammiSpriteFrame42 ; $40c4
	dw SammiSpriteFrame42 ; $40c6
	dw SammiSpriteFrame42 ; $40c8
	dw SammiSpriteFrame42 ; $40ca
	dw SammiSpriteFrame43 ; $40cc
	dw SammiSpriteFrame43 ; $40ce
	dw SammiSpriteFrame43 ; $40d0
	dw SammiSpriteFrame43 ; $40d2
	dw SammiSpriteFrame43 ; $40d4
	dw SammiSpriteFrame44 ; $40d6
	dw SammiSpriteFrame44 ; $40d8
	dw SammiSpriteFrame44 ; $40da
	dw SammiSpriteFrame45 ; $40dc
	dw SammiSpriteFrame45 ; $40de
	dw SammiSpriteFrame46 ; $40e0
	dw SammiSpriteFrame46 ; $40e2
	dw SammiSpriteFrame46 ; $40e4
	dw SammiSpriteFrame47 ; $40e6
	dw SammiSpriteFrame47 ; $40e8
	dw SammiSpriteFrame48 ; $40ea
	dw SammiSpriteFrame48 ; $40ec
	dw SammiSpriteFrame48 ; $40ee
	dw SammiSpriteFrame49 ; $40f0
	dw SammiSpriteFrame49 ; $40f2
	dw SammiSpriteFrame50 ; $40f4
	dw SammiSpriteFrame50 ; $40f6
	dw SammiSpriteFrame50 ; $40f8
	dw SammiSpriteFrame50 ; $40fa
	dw SammiSpriteFrame50 ; $40fc
	dw SammiSpriteFrame51 ; $40fe
	dw SammiSpriteFrame51 ; $4100
	dw SammiSpriteFrame51 ; $4102
	dw SammiSpriteFrame51 ; $4104
	dw SammiSpriteFrame51 ; $4106
	dw SammiSpriteFrame52 ; $4108
	dw SammiSpriteFrame52 ; $410a
	dw SammiSpriteFrame52 ; $410c
	dw SammiSpriteFrame52 ; $410e
	dw SammiSpriteFrame52 ; $4110
	dw SammiSpriteFrame53 ; $4112
	dw SammiSpriteFrame53 ; $4114
	dw SammiSpriteFrame53 ; $4116
	dw SammiSpriteFrame53 ; $4118
	dw SammiSpriteFrame53 ; $411a
	dw SammiSpriteFrame54 ; $411c
	dw SammiSpriteFrame54 ; $411e
	dw SammiSpriteFrame54 ; $4120
	dw SammiSpriteFrame54 ; $4122
	dw SammiSpriteFrame54 ; $4124
	dw SammiSpriteFrame55 ; $4126
	dw SammiSpriteFrame55 ; $4128
	dw SammiSpriteFrame55 ; $412a
	dw SammiSpriteFrame55 ; $412c
	dw SammiSpriteFrame55 ; $412e
SammiSpriteFrame00:
	INCBIN "data/bank_046/d_4130.bin" ; $4130, 240 bytes
SammiSpriteFrame01:
	INCBIN "data/bank_046/d_4220.bin" ; $4220, 240 bytes
SammiSpriteFrame02:
	INCBIN "data/bank_046/d_4310.bin" ; $4310, 240 bytes
SammiSpriteFrame03:
	INCBIN "data/bank_046/d_4400.bin" ; $4400, 240 bytes
SammiSpriteFrame04:
	INCBIN "data/bank_046/d_44f0.bin" ; $44f0, 240 bytes
SammiSpriteFrame05:
	INCBIN "data/bank_046/d_45e0.bin" ; $45e0, 240 bytes
SammiSpriteFrame06:
	INCBIN "data/bank_046/d_46d0.bin" ; $46d0, 240 bytes
SammiSpriteFrame07:
	INCBIN "data/bank_046/d_47c0.bin" ; $47c0, 240 bytes
SammiSpriteFrame08:
	INCBIN "data/bank_046/d_48b0.bin" ; $48b0, 240 bytes
SammiSpriteFrame09:
	INCBIN "data/bank_046/d_49a0.bin" ; $49a0, 240 bytes
SammiSpriteFrame10:
	INCBIN "data/bank_046/d_4a90.bin" ; $4a90, 240 bytes
SammiSpriteFrame11:
	INCBIN "data/bank_046/d_4b80.bin" ; $4b80, 240 bytes
SammiSpriteFrame12:
	INCBIN "data/bank_046/d_4c70.bin" ; $4c70, 240 bytes
SammiSpriteFrame13:
	INCBIN "data/bank_046/d_4d60.bin" ; $4d60, 240 bytes
SammiSpriteFrame14:
	INCBIN "data/bank_046/d_4e50.bin" ; $4e50, 240 bytes
SammiSpriteFrame15:
	INCBIN "data/bank_046/d_4f40.bin" ; $4f40, 240 bytes
SammiSpriteFrame16:
	INCBIN "data/bank_046/d_5030.bin" ; $5030, 240 bytes
SammiSpriteFrame17:
	INCBIN "data/bank_046/d_5120.bin" ; $5120, 240 bytes
SammiSpriteFrame18:
	INCBIN "data/bank_046/d_5210.bin" ; $5210, 240 bytes
SammiSpriteFrame19:
	INCBIN "data/bank_046/d_5300.bin" ; $5300, 240 bytes
SammiSpriteFrame20:
	INCBIN "data/bank_046/d_53f0.bin" ; $53f0, 240 bytes
SammiSpriteFrame21:
	INCBIN "data/bank_046/d_54e0.bin" ; $54e0, 240 bytes
SammiSpriteFrame22:
	INCBIN "data/bank_046/d_55d0.bin" ; $55d0, 240 bytes
SammiSpriteFrame23:
	INCBIN "data/bank_046/d_56c0.bin" ; $56c0, 240 bytes
SammiSpriteFrame24:
	INCBIN "data/bank_046/d_57b0.bin" ; $57b0, 240 bytes
SammiSpriteFrame25:
	INCBIN "data/bank_046/d_58a0.bin" ; $58a0, 240 bytes
SammiSpriteFrame26:
	INCBIN "data/bank_046/d_5990.bin" ; $5990, 240 bytes
SammiSpriteFrame27:
	INCBIN "data/bank_046/d_5a80.bin" ; $5a80, 240 bytes
SammiSpriteFrame28:
	INCBIN "data/bank_046/d_5b70.bin" ; $5b70, 240 bytes
SammiSpriteFrame29:
	INCBIN "data/bank_046/d_5c60.bin" ; $5c60, 240 bytes
SammiSpriteFrame30:
	INCBIN "data/bank_046/d_5d50.bin" ; $5d50, 240 bytes
SammiSpriteFrame31:
	INCBIN "data/bank_046/d_5e40.bin" ; $5e40, 240 bytes
SammiSpriteFrame32:
	INCBIN "data/bank_046/d_5f30.bin" ; $5f30, 240 bytes
SammiSpriteFrame33:
	INCBIN "data/bank_046/d_6020.bin" ; $6020, 240 bytes
SammiSpriteFrame34:
	INCBIN "data/bank_046/d_6110.bin" ; $6110, 240 bytes
SammiSpriteFrame35:
	INCBIN "data/bank_046/d_6200.bin" ; $6200, 240 bytes
SammiSpriteFrame36:
	INCBIN "data/bank_046/d_62f0.bin" ; $62f0, 240 bytes
SammiSpriteFrame37:
	INCBIN "data/bank_046/d_63e0.bin" ; $63e0, 240 bytes
SammiSpriteFrame38:
	INCBIN "data/bank_046/d_64d0.bin" ; $64d0, 240 bytes
SammiSpriteFrame39:
	INCBIN "data/bank_046/d_65c0.bin" ; $65c0, 240 bytes
SammiSpriteFrame40:
	INCBIN "data/bank_046/d_66b0.bin" ; $66b0, 320 bytes
SammiSpriteFrame41:
	INCBIN "data/bank_046/d_67f0.bin" ; $67f0, 320 bytes
SammiSpriteFrame42:
	INCBIN "data/bank_046/d_6930.bin" ; $6930, 240 bytes
SammiSpriteFrame43:
	INCBIN "data/bank_046/d_6a20.bin" ; $6a20, 240 bytes
SammiSpriteFrame44:
	INCBIN "data/bank_046/d_6b10.bin" ; $6b10, 240 bytes
SammiSpriteFrame45:
	INCBIN "data/bank_046/d_6c00.bin" ; $6c00, 240 bytes
SammiSpriteFrame46:
	INCBIN "data/bank_046/d_6cf0.bin" ; $6cf0, 240 bytes
SammiSpriteFrame47:
	INCBIN "data/bank_046/d_6de0.bin" ; $6de0, 240 bytes
SammiSpriteFrame48:
	INCBIN "data/bank_046/d_6ed0.bin" ; $6ed0, 240 bytes
SammiSpriteFrame49:
	INCBIN "data/bank_046/d_6fc0.bin" ; $6fc0, 240 bytes
SammiSpriteFrame50:
	INCBIN "data/bank_046/d_70b0.bin" ; $70b0, 240 bytes
SammiSpriteFrame51:
	INCBIN "data/bank_046/d_71a0.bin" ; $71a0, 240 bytes
SammiSpriteFrame52:
	INCBIN "data/bank_046/d_7290.bin" ; $7290, 240 bytes
SammiSpriteFrame53:
	INCBIN "data/bank_046/d_7380.bin" ; $7380, 240 bytes
SammiSpriteFrame54:
	INCBIN "data/bank_046/d_7470.bin" ; $7470, 240 bytes
SammiSpriteFrame55:
	INCBIN "data/bank_046/d_7560.bin" ; $7560, 240 bytes
Data_46_7650:
	INCBIN "data/bank_046/d_7650.bin" ; $7650, 1680 bytes
Data_46_7ce0:
	INCBIN "data/bank_046/d_7ce0.bin" ; $7ce0, 580 bytes
SammiSpriteAnims:
	dw SammiSpriteAnim00 ; $7f24
	dw SammiSpriteAnim01 ; $7f26
	dw SammiSpriteAnim02 ; $7f28
	dw SammiSpriteAnim03 ; $7f2a
	dw SammiSpriteAnim04 ; $7f2c
	dw SammiSpriteAnim05 ; $7f2e
	dw SammiSpriteAnim06 ; $7f30
	dw SammiSpriteAnim07 ; $7f32
	dw SammiSpriteAnim08 ; $7f34
	dw SammiSpriteAnim09 ; $7f36
	dw SammiSpriteAnim10 ; $7f38
	dw SammiSpriteAnim11 ; $7f3a
	dw SammiSpriteAnim12 ; $7f3c
	dw SammiSpriteAnim13 ; $7f3e
	dw SammiSpriteAnim14 ; $7f40
	dw SammiSpriteAnim15 ; $7f42
	dw SammiSpriteAnim16 ; $7f44
	dw SammiSpriteAnim17 ; $7f46
	dw SammiSpriteAnim18 ; $7f48
SammiSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	db $00
	db $ff, $fd
SammiSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
SammiSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
SammiSpriteAnim03:
	; $7f5d, 10 bytes (sprite_anim)
	anim_frame $17, $0f
	anim_frame $18, $0f
	anim_frame $19, $0f
	anim_frame $18, $0f
	anim_loop $00
SammiSpriteAnim04:
	; $7f67, 8 bytes (sprite_anim)
	anim_frame $1a, $14
	anim_frame $1b, $0f
	anim_frame $1c, $0f
	anim_loop $02
SammiSpriteAnim05:
	; $7f6f, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
SammiSpriteAnim06:
	; $7f75, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
SammiSpriteAnim07:
	; $7f7b, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
SammiSpriteAnim08:
	; $7f81, 5 bytes (sprite_anim)
	db $15, $04, $16, $14, $fd
SammiSpriteAnim09:
	; $7f86, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
SammiSpriteAnim10:
	; $7f8a, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
SammiSpriteAnim11:
	; $7f8e, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
SammiSpriteAnim12:
	; $7f92, 3 bytes (sprite_anim)
	db $15, $18, $fd
SammiSpriteAnim13:
	; $7f95, 3 bytes (sprite_anim)
	db $05, $ff, $fd
SammiSpriteAnim14:
	; $7f98, 3 bytes (sprite_anim)
	db $08, $ff, $fd
SammiSpriteAnim15:
	; $7f9b, 3 bytes (sprite_anim)
	db $0b, $ff, $fd
SammiSpriteAnim16:
	; $7f9e, 3 bytes (sprite_anim)
	db $0e, $ff, $fd
SammiSpriteAnim17:
	; $7fa1, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
SammiSpriteAnim18:
	; $7fad, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fb5, 75 bytes fill to bank end (linker-padded)
