SECTION "ROM Bank $47", ROMX[$4000], BANK[$47]

	dw SeanSpriteDesc ; $4000
SeanSpriteDesc:
	dw $0003 ; $4002
	dw $0003 ; $4004
	dw SeanSpriteFrames ; $4006 frame table
	dw SeanSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw SeanSpriteOam ; $400c per-slot OAM data
SeanSpriteFrames:
	dw SeanSpriteFrame00 ; $400e
	dw SeanSpriteFrame01 ; $4010
	dw SeanSpriteFrame02 ; $4012
	dw SeanSpriteFrame03 ; $4014
	dw SeanSpriteFrame04 ; $4016
	dw SeanSpriteFrame05 ; $4018
	dw SeanSpriteFrame06 ; $401a
	dw SeanSpriteFrame07 ; $401c
	dw SeanSpriteFrame08 ; $401e
	dw SeanSpriteFrame09 ; $4020
	dw SeanSpriteFrame10 ; $4022
	dw SeanSpriteFrame01 ; $4024
	dw SeanSpriteFrame02 ; $4026
	dw SeanSpriteFrame03 ; $4028
	dw SeanSpriteFrame11 ; $402a
	dw SeanSpriteFrame12 ; $402c
	dw SeanSpriteFrame01 ; $402e
	dw SeanSpriteFrame02 ; $4030
	dw SeanSpriteFrame03 ; $4032
	dw SeanSpriteFrame13 ; $4034
	dw SeanSpriteFrame14 ; $4036
	dw SeanSpriteFrame06 ; $4038
	dw SeanSpriteFrame07 ; $403a
	dw SeanSpriteFrame08 ; $403c
	dw SeanSpriteFrame15 ; $403e
	dw SeanSpriteFrame16 ; $4040
	dw SeanSpriteFrame16 ; $4042
	dw SeanSpriteFrame16 ; $4044
	dw SeanSpriteFrame17 ; $4046
	dw SeanSpriteFrame17 ; $4048
	dw SeanSpriteFrame18 ; $404a
	dw SeanSpriteFrame18 ; $404c
	dw SeanSpriteFrame18 ; $404e
	dw SeanSpriteFrame19 ; $4050
	dw SeanSpriteFrame19 ; $4052
	dw SeanSpriteFrame20 ; $4054
	dw SeanSpriteFrame20 ; $4056
	dw SeanSpriteFrame20 ; $4058
	dw SeanSpriteFrame21 ; $405a
	dw SeanSpriteFrame21 ; $405c
	dw SeanSpriteFrame22 ; $405e
	dw SeanSpriteFrame22 ; $4060
	dw SeanSpriteFrame22 ; $4062
	dw SeanSpriteFrame23 ; $4064
	dw SeanSpriteFrame23 ; $4066
	dw SeanSpriteFrame24 ; $4068
	dw SeanSpriteFrame24 ; $406a
	dw SeanSpriteFrame24 ; $406c
	dw SeanSpriteFrame25 ; $406e
	dw SeanSpriteFrame25 ; $4070
	dw SeanSpriteFrame26 ; $4072
	dw SeanSpriteFrame26 ; $4074
	dw SeanSpriteFrame26 ; $4076
	dw SeanSpriteFrame27 ; $4078
	dw SeanSpriteFrame27 ; $407a
	dw SeanSpriteFrame28 ; $407c
	dw SeanSpriteFrame28 ; $407e
	dw SeanSpriteFrame28 ; $4080
	dw SeanSpriteFrame29 ; $4082
	dw SeanSpriteFrame29 ; $4084
	dw SeanSpriteFrame30 ; $4086
	dw SeanSpriteFrame30 ; $4088
	dw SeanSpriteFrame30 ; $408a
	dw SeanSpriteFrame31 ; $408c
	dw SeanSpriteFrame31 ; $408e
	dw SeanSpriteFrame32 ; $4090
	dw SeanSpriteFrame32 ; $4092
	dw SeanSpriteFrame32 ; $4094
	dw SeanSpriteFrame33 ; $4096
	dw SeanSpriteFrame33 ; $4098
	dw SeanSpriteFrame34 ; $409a
	dw SeanSpriteFrame34 ; $409c
	dw SeanSpriteFrame34 ; $409e
	dw SeanSpriteFrame35 ; $40a0
	dw SeanSpriteFrame35 ; $40a2
	dw SeanSpriteFrame36 ; $40a4
	dw SeanSpriteFrame36 ; $40a6
	dw SeanSpriteFrame36 ; $40a8
	dw SeanSpriteFrame37 ; $40aa
	dw SeanSpriteFrame37 ; $40ac
	dw SeanSpriteFrame38 ; $40ae
	dw SeanSpriteFrame38 ; $40b0
	dw SeanSpriteFrame38 ; $40b2
	dw SeanSpriteFrame39 ; $40b4
	dw SeanSpriteFrame39 ; $40b6
	dw SeanSpriteFrame40 ; $40b8
	dw SeanSpriteFrame40 ; $40ba
	dw SeanSpriteFrame40 ; $40bc
	dw SeanSpriteFrame41 ; $40be
	dw SeanSpriteFrame41 ; $40c0
	dw SeanSpriteFrame42 ; $40c2
	dw SeanSpriteFrame42 ; $40c4
	dw SeanSpriteFrame42 ; $40c6
	dw SeanSpriteFrame42 ; $40c8
	dw SeanSpriteFrame42 ; $40ca
	dw SeanSpriteFrame43 ; $40cc
	dw SeanSpriteFrame43 ; $40ce
	dw SeanSpriteFrame43 ; $40d0
	dw SeanSpriteFrame43 ; $40d2
	dw SeanSpriteFrame43 ; $40d4
	dw SeanSpriteFrame44 ; $40d6
	dw SeanSpriteFrame44 ; $40d8
	dw SeanSpriteFrame44 ; $40da
	dw SeanSpriteFrame45 ; $40dc
	dw SeanSpriteFrame45 ; $40de
	dw SeanSpriteFrame46 ; $40e0
	dw SeanSpriteFrame46 ; $40e2
	dw SeanSpriteFrame46 ; $40e4
	dw SeanSpriteFrame47 ; $40e6
	dw SeanSpriteFrame47 ; $40e8
	dw SeanSpriteFrame48 ; $40ea
	dw SeanSpriteFrame48 ; $40ec
	dw SeanSpriteFrame48 ; $40ee
	dw SeanSpriteFrame49 ; $40f0
	dw SeanSpriteFrame49 ; $40f2
	dw SeanSpriteFrame50 ; $40f4
	dw SeanSpriteFrame50 ; $40f6
	dw SeanSpriteFrame50 ; $40f8
	dw SeanSpriteFrame50 ; $40fa
	dw SeanSpriteFrame50 ; $40fc
	dw SeanSpriteFrame51 ; $40fe
	dw SeanSpriteFrame51 ; $4100
	dw SeanSpriteFrame51 ; $4102
	dw SeanSpriteFrame51 ; $4104
	dw SeanSpriteFrame51 ; $4106
	dw SeanSpriteFrame52 ; $4108
	dw SeanSpriteFrame52 ; $410a
	dw SeanSpriteFrame52 ; $410c
	dw SeanSpriteFrame52 ; $410e
	dw SeanSpriteFrame52 ; $4110
	dw SeanSpriteFrame53 ; $4112
	dw SeanSpriteFrame53 ; $4114
	dw SeanSpriteFrame53 ; $4116
	dw SeanSpriteFrame53 ; $4118
	dw SeanSpriteFrame53 ; $411a
	dw SeanSpriteFrame54 ; $411c
	dw SeanSpriteFrame54 ; $411e
	dw SeanSpriteFrame54 ; $4120
	dw SeanSpriteFrame54 ; $4122
	dw SeanSpriteFrame54 ; $4124
	dw SeanSpriteFrame55 ; $4126
	dw SeanSpriteFrame55 ; $4128
	dw SeanSpriteFrame55 ; $412a
	dw SeanSpriteFrame55 ; $412c
	dw SeanSpriteFrame55 ; $412e
SeanSpriteFrame00:
	INCBIN "data/bank_047/d_4130.bin" ; $4130, 240 bytes
SeanSpriteFrame01:
	INCBIN "data/bank_047/d_4220.bin" ; $4220, 240 bytes
SeanSpriteFrame02:
	INCBIN "data/bank_047/d_4310.bin" ; $4310, 240 bytes
SeanSpriteFrame03:
	INCBIN "data/bank_047/d_4400.bin" ; $4400, 240 bytes
SeanSpriteFrame04:
	INCBIN "data/bank_047/d_44f0.bin" ; $44f0, 240 bytes
SeanSpriteFrame05:
	INCBIN "data/bank_047/d_45e0.bin" ; $45e0, 240 bytes
SeanSpriteFrame06:
	INCBIN "data/bank_047/d_46d0.bin" ; $46d0, 240 bytes
SeanSpriteFrame07:
	INCBIN "data/bank_047/d_47c0.bin" ; $47c0, 240 bytes
SeanSpriteFrame08:
	INCBIN "data/bank_047/d_48b0.bin" ; $48b0, 240 bytes
SeanSpriteFrame09:
	INCBIN "data/bank_047/d_49a0.bin" ; $49a0, 240 bytes
SeanSpriteFrame10:
	INCBIN "data/bank_047/d_4a90.bin" ; $4a90, 240 bytes
SeanSpriteFrame11:
	INCBIN "data/bank_047/d_4b80.bin" ; $4b80, 240 bytes
SeanSpriteFrame12:
	INCBIN "data/bank_047/d_4c70.bin" ; $4c70, 240 bytes
SeanSpriteFrame13:
	INCBIN "data/bank_047/d_4d60.bin" ; $4d60, 240 bytes
SeanSpriteFrame14:
	INCBIN "data/bank_047/d_4e50.bin" ; $4e50, 240 bytes
SeanSpriteFrame15:
	INCBIN "data/bank_047/d_4f40.bin" ; $4f40, 240 bytes
SeanSpriteFrame16:
	INCBIN "data/bank_047/d_5030.bin" ; $5030, 240 bytes
SeanSpriteFrame17:
	INCBIN "data/bank_047/d_5120.bin" ; $5120, 240 bytes
SeanSpriteFrame18:
	INCBIN "data/bank_047/d_5210.bin" ; $5210, 240 bytes
SeanSpriteFrame19:
	INCBIN "data/bank_047/d_5300.bin" ; $5300, 240 bytes
SeanSpriteFrame20:
	INCBIN "data/bank_047/d_53f0.bin" ; $53f0, 240 bytes
SeanSpriteFrame21:
	INCBIN "data/bank_047/d_54e0.bin" ; $54e0, 240 bytes
SeanSpriteFrame22:
	INCBIN "data/bank_047/d_55d0.bin" ; $55d0, 240 bytes
SeanSpriteFrame23:
	INCBIN "data/bank_047/d_56c0.bin" ; $56c0, 240 bytes
SeanSpriteFrame24:
	INCBIN "data/bank_047/d_57b0.bin" ; $57b0, 240 bytes
SeanSpriteFrame25:
	INCBIN "data/bank_047/d_58a0.bin" ; $58a0, 240 bytes
SeanSpriteFrame26:
	INCBIN "data/bank_047/d_5990.bin" ; $5990, 240 bytes
SeanSpriteFrame27:
	INCBIN "data/bank_047/d_5a80.bin" ; $5a80, 240 bytes
SeanSpriteFrame28:
	INCBIN "data/bank_047/d_5b70.bin" ; $5b70, 240 bytes
SeanSpriteFrame29:
	INCBIN "data/bank_047/d_5c60.bin" ; $5c60, 240 bytes
SeanSpriteFrame30:
	INCBIN "data/bank_047/d_5d50.bin" ; $5d50, 240 bytes
SeanSpriteFrame31:
	INCBIN "data/bank_047/d_5e40.bin" ; $5e40, 240 bytes
SeanSpriteFrame32:
	INCBIN "data/bank_047/d_5f30.bin" ; $5f30, 240 bytes
SeanSpriteFrame33:
	INCBIN "data/bank_047/d_6020.bin" ; $6020, 240 bytes
SeanSpriteFrame34:
	INCBIN "data/bank_047/d_6110.bin" ; $6110, 240 bytes
SeanSpriteFrame35:
	INCBIN "data/bank_047/d_6200.bin" ; $6200, 240 bytes
SeanSpriteFrame36:
	INCBIN "data/bank_047/d_62f0.bin" ; $62f0, 240 bytes
SeanSpriteFrame37:
	INCBIN "data/bank_047/d_63e0.bin" ; $63e0, 240 bytes
SeanSpriteFrame38:
	INCBIN "data/bank_047/d_64d0.bin" ; $64d0, 240 bytes
SeanSpriteFrame39:
	INCBIN "data/bank_047/d_65c0.bin" ; $65c0, 240 bytes
SeanSpriteFrame40:
	INCBIN "data/bank_047/d_66b0.bin" ; $66b0, 320 bytes
SeanSpriteFrame41:
	INCBIN "data/bank_047/d_67f0.bin" ; $67f0, 320 bytes
SeanSpriteFrame42:
	INCBIN "data/bank_047/d_6930.bin" ; $6930, 240 bytes
SeanSpriteFrame43:
	INCBIN "data/bank_047/d_6a20.bin" ; $6a20, 240 bytes
SeanSpriteFrame44:
	INCBIN "data/bank_047/d_6b10.bin" ; $6b10, 240 bytes
SeanSpriteFrame45:
	INCBIN "data/bank_047/d_6c00.bin" ; $6c00, 240 bytes
SeanSpriteFrame46:
	INCBIN "data/bank_047/d_6cf0.bin" ; $6cf0, 240 bytes
SeanSpriteFrame47:
	INCBIN "data/bank_047/d_6de0.bin" ; $6de0, 240 bytes
SeanSpriteFrame48:
	INCBIN "data/bank_047/d_6ed0.bin" ; $6ed0, 240 bytes
SeanSpriteFrame49:
	INCBIN "data/bank_047/d_6fc0.bin" ; $6fc0, 240 bytes
SeanSpriteFrame50:
	INCBIN "data/bank_047/d_70b0.bin" ; $70b0, 240 bytes
SeanSpriteFrame51:
	INCBIN "data/bank_047/d_71a0.bin" ; $71a0, 240 bytes
SeanSpriteFrame52:
	INCBIN "data/bank_047/d_7290.bin" ; $7290, 240 bytes
SeanSpriteFrame53:
	INCBIN "data/bank_047/d_7380.bin" ; $7380, 240 bytes
SeanSpriteFrame54:
	INCBIN "data/bank_047/d_7470.bin" ; $7470, 240 bytes
SeanSpriteFrame55:
	INCBIN "data/bank_047/d_7560.bin" ; $7560, 240 bytes
SeanSpriteFramesUnused:
	INCBIN "data/bank_047/d_7650.bin" ; $7650, 1680 bytes
SeanSpriteOam:
	INCBIN "data/bank_047/d_7ce0.bin" ; $7ce0, 580 bytes
SeanSpriteAnims:
	dw SeanSpriteAnim00 ; $7f24
	dw SeanSpriteAnim01 ; $7f26
	dw SeanSpriteAnim02 ; $7f28
	dw SeanSpriteAnim03 ; $7f2a
	dw SeanSpriteAnim04 ; $7f2c
	dw SeanSpriteAnim05 ; $7f2e
	dw SeanSpriteAnim06 ; $7f30
	dw SeanSpriteAnim07 ; $7f32
	dw SeanSpriteAnim08 ; $7f34
	dw SeanSpriteAnim09 ; $7f36
	dw SeanSpriteAnim10 ; $7f38
	dw SeanSpriteAnim11 ; $7f3a
	dw SeanSpriteAnim12 ; $7f3c
	dw SeanSpriteAnim13 ; $7f3e
	dw SeanSpriteAnim14 ; $7f40
	dw SeanSpriteAnim15 ; $7f42
	dw SeanSpriteAnim16 ; $7f44
	dw SeanSpriteAnim17 ; $7f46
	dw SeanSpriteAnim18 ; $7f48
SeanSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	db $00
	db $ff, $fd
SeanSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
SeanSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
SeanSpriteAnim03:
	; $7f5d, 10 bytes (sprite_anim)
	anim_frame $17, $0a
	anim_frame $18, $0a
	anim_frame $17, $0a
	anim_frame $19, $0a
	anim_loop $00
SeanSpriteAnim04:
	; $7f67, 8 bytes (sprite_anim)
	db $1a, $14, $1b, $14, $1c, $14, $fd, $00
SeanSpriteAnim05:
	; $7f6f, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
SeanSpriteAnim06:
	; $7f75, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
SeanSpriteAnim07:
	; $7f7b, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
SeanSpriteAnim08:
	; $7f81, 5 bytes (sprite_anim)
	db $15, $04, $16, $14, $fd
SeanSpriteAnim09:
	; $7f86, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
SeanSpriteAnim10:
	; $7f8a, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
SeanSpriteAnim11:
	; $7f8e, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
SeanSpriteAnim12:
	; $7f92, 3 bytes (sprite_anim)
	db $15, $18, $fd
SeanSpriteAnim13:
	; $7f95, 3 bytes (sprite_anim)
	db $05, $ff, $fd
SeanSpriteAnim14:
	; $7f98, 3 bytes (sprite_anim)
	db $08, $ff, $fd
SeanSpriteAnim15:
	; $7f9b, 3 bytes (sprite_anim)
	db $0b, $ff, $fd
SeanSpriteAnim16:
	; $7f9e, 3 bytes (sprite_anim)
	db $0e, $ff, $fd
SeanSpriteAnim17:
	; $7fa1, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
SeanSpriteAnim18:
	; $7fad, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fb5, 75 bytes fill to bank end (linker-padded)
