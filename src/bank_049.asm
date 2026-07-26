SECTION "ROM Bank $49", ROMX[$4000], BANK[$49]

	dw EldenSpriteDesc ; $4000
EldenSpriteDesc:
	dw $0005 ; $4002
	dw $0003 ; $4004
	dw EldenSpriteFrames ; $4006 frame table
	dw EldenSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw EldenSpriteOam ; $400c per-slot OAM data
EldenSpriteFrames:
	dw EldenSpriteFrame00 ; $400e
	dw EldenSpriteFrame01 ; $4010
	dw EldenSpriteFrame02 ; $4012
	dw EldenSpriteFrame03 ; $4014
	dw EldenSpriteFrame04 ; $4016
	dw EldenSpriteFrame05 ; $4018
	dw EldenSpriteFrame06 ; $401a
	dw EldenSpriteFrame07 ; $401c
	dw EldenSpriteFrame08 ; $401e
	dw EldenSpriteFrame09 ; $4020
	dw EldenSpriteFrame10 ; $4022
	dw EldenSpriteFrame01 ; $4024
	dw EldenSpriteFrame02 ; $4026
	dw EldenSpriteFrame03 ; $4028
	dw EldenSpriteFrame11 ; $402a
	dw EldenSpriteFrame12 ; $402c
	dw EldenSpriteFrame01 ; $402e
	dw EldenSpriteFrame02 ; $4030
	dw EldenSpriteFrame03 ; $4032
	dw EldenSpriteFrame13 ; $4034
	dw EldenSpriteFrame14 ; $4036
	dw EldenSpriteFrame06 ; $4038
	dw EldenSpriteFrame07 ; $403a
	dw EldenSpriteFrame08 ; $403c
	dw EldenSpriteFrame15 ; $403e
	dw EldenSpriteFrame16 ; $4040
	dw EldenSpriteFrame16 ; $4042
	dw EldenSpriteFrame16 ; $4044
	dw EldenSpriteFrame17 ; $4046
	dw EldenSpriteFrame17 ; $4048
	dw EldenSpriteFrame18 ; $404a
	dw EldenSpriteFrame18 ; $404c
	dw EldenSpriteFrame18 ; $404e
	dw EldenSpriteFrame19 ; $4050
	dw EldenSpriteFrame19 ; $4052
	dw EldenSpriteFrame20 ; $4054
	dw EldenSpriteFrame20 ; $4056
	dw EldenSpriteFrame20 ; $4058
	dw EldenSpriteFrame21 ; $405a
	dw EldenSpriteFrame21 ; $405c
	dw EldenSpriteFrame22 ; $405e
	dw EldenSpriteFrame22 ; $4060
	dw EldenSpriteFrame22 ; $4062
	dw EldenSpriteFrame23 ; $4064
	dw EldenSpriteFrame23 ; $4066
	dw EldenSpriteFrame24 ; $4068
	dw EldenSpriteFrame24 ; $406a
	dw EldenSpriteFrame24 ; $406c
	dw EldenSpriteFrame25 ; $406e
	dw EldenSpriteFrame25 ; $4070
	dw EldenSpriteFrame26 ; $4072
	dw EldenSpriteFrame26 ; $4074
	dw EldenSpriteFrame26 ; $4076
	dw EldenSpriteFrame27 ; $4078
	dw EldenSpriteFrame27 ; $407a
	dw EldenSpriteFrame28 ; $407c
	dw EldenSpriteFrame28 ; $407e
	dw EldenSpriteFrame28 ; $4080
	dw EldenSpriteFrame29 ; $4082
	dw EldenSpriteFrame29 ; $4084
	dw EldenSpriteFrame30 ; $4086
	dw EldenSpriteFrame30 ; $4088
	dw EldenSpriteFrame30 ; $408a
	dw EldenSpriteFrame31 ; $408c
	dw EldenSpriteFrame31 ; $408e
	dw EldenSpriteFrame32 ; $4090
	dw EldenSpriteFrame32 ; $4092
	dw EldenSpriteFrame32 ; $4094
	dw EldenSpriteFrame33 ; $4096
	dw EldenSpriteFrame33 ; $4098
	dw EldenSpriteFrame34 ; $409a
	dw EldenSpriteFrame34 ; $409c
	dw EldenSpriteFrame34 ; $409e
	dw EldenSpriteFrame35 ; $40a0
	dw EldenSpriteFrame35 ; $40a2
	dw EldenSpriteFrame36 ; $40a4
	dw EldenSpriteFrame36 ; $40a6
	dw EldenSpriteFrame36 ; $40a8
	dw EldenSpriteFrame37 ; $40aa
	dw EldenSpriteFrame37 ; $40ac
	dw EldenSpriteFrame38 ; $40ae
	dw EldenSpriteFrame38 ; $40b0
	dw EldenSpriteFrame38 ; $40b2
	dw EldenSpriteFrame39 ; $40b4
	dw EldenSpriteFrame39 ; $40b6
	dw EldenSpriteFrame40 ; $40b8
	dw EldenSpriteFrame40 ; $40ba
	dw EldenSpriteFrame40 ; $40bc
	dw EldenSpriteFrame41 ; $40be
	dw EldenSpriteFrame41 ; $40c0
	dw EldenSpriteFrame42 ; $40c2
	dw EldenSpriteFrame42 ; $40c4
	dw EldenSpriteFrame42 ; $40c6
	dw EldenSpriteFrame42 ; $40c8
	dw EldenSpriteFrame42 ; $40ca
	dw EldenSpriteFrame43 ; $40cc
	dw EldenSpriteFrame43 ; $40ce
	dw EldenSpriteFrame43 ; $40d0
	dw EldenSpriteFrame43 ; $40d2
	dw EldenSpriteFrame43 ; $40d4
	dw EldenSpriteFrame44 ; $40d6
	dw EldenSpriteFrame44 ; $40d8
	dw EldenSpriteFrame44 ; $40da
	dw EldenSpriteFrame45 ; $40dc
	dw EldenSpriteFrame45 ; $40de
	dw EldenSpriteFrame46 ; $40e0
	dw EldenSpriteFrame46 ; $40e2
	dw EldenSpriteFrame46 ; $40e4
	dw EldenSpriteFrame47 ; $40e6
	dw EldenSpriteFrame47 ; $40e8
	dw EldenSpriteFrame48 ; $40ea
	dw EldenSpriteFrame48 ; $40ec
	dw EldenSpriteFrame48 ; $40ee
	dw EldenSpriteFrame49 ; $40f0
	dw EldenSpriteFrame49 ; $40f2
	dw EldenSpriteFrame50 ; $40f4
	dw EldenSpriteFrame50 ; $40f6
	dw EldenSpriteFrame50 ; $40f8
	dw EldenSpriteFrame50 ; $40fa
	dw EldenSpriteFrame50 ; $40fc
	dw EldenSpriteFrame51 ; $40fe
	dw EldenSpriteFrame51 ; $4100
	dw EldenSpriteFrame51 ; $4102
	dw EldenSpriteFrame51 ; $4104
	dw EldenSpriteFrame51 ; $4106
	dw EldenSpriteFrame52 ; $4108
	dw EldenSpriteFrame52 ; $410a
	dw EldenSpriteFrame52 ; $410c
	dw EldenSpriteFrame52 ; $410e
	dw EldenSpriteFrame52 ; $4110
	dw EldenSpriteFrame53 ; $4112
	dw EldenSpriteFrame53 ; $4114
	dw EldenSpriteFrame53 ; $4116
	dw EldenSpriteFrame53 ; $4118
	dw EldenSpriteFrame53 ; $411a
	dw EldenSpriteFrame54 ; $411c
	dw EldenSpriteFrame54 ; $411e
	dw EldenSpriteFrame54 ; $4120
	dw EldenSpriteFrame54 ; $4122
	dw EldenSpriteFrame54 ; $4124
	dw EldenSpriteFrame55 ; $4126
	dw EldenSpriteFrame55 ; $4128
	dw EldenSpriteFrame55 ; $412a
	dw EldenSpriteFrame55 ; $412c
	dw EldenSpriteFrame55 ; $412e
EldenSpriteFrame00:
	INCBIN "data/bank_049/d_4130.bin" ; $4130, 240 bytes
EldenSpriteFrame01:
	INCBIN "data/bank_049/d_4220.bin" ; $4220, 240 bytes
EldenSpriteFrame02:
	INCBIN "data/bank_049/d_4310.bin" ; $4310, 240 bytes
EldenSpriteFrame03:
	INCBIN "data/bank_049/d_4400.bin" ; $4400, 240 bytes
EldenSpriteFrame04:
	INCBIN "data/bank_049/d_44f0.bin" ; $44f0, 240 bytes
EldenSpriteFrame05:
	INCBIN "data/bank_049/d_45e0.bin" ; $45e0, 240 bytes
EldenSpriteFrame06:
	INCBIN "data/bank_049/d_46d0.bin" ; $46d0, 240 bytes
EldenSpriteFrame07:
	INCBIN "data/bank_049/d_47c0.bin" ; $47c0, 240 bytes
EldenSpriteFrame08:
	INCBIN "data/bank_049/d_48b0.bin" ; $48b0, 240 bytes
EldenSpriteFrame09:
	INCBIN "data/bank_049/d_49a0.bin" ; $49a0, 240 bytes
EldenSpriteFrame10:
	INCBIN "data/bank_049/d_4a90.bin" ; $4a90, 240 bytes
EldenSpriteFrame11:
	INCBIN "data/bank_049/d_4b80.bin" ; $4b80, 240 bytes
EldenSpriteFrame12:
	INCBIN "data/bank_049/d_4c70.bin" ; $4c70, 240 bytes
EldenSpriteFrame13:
	INCBIN "data/bank_049/d_4d60.bin" ; $4d60, 240 bytes
EldenSpriteFrame14:
	INCBIN "data/bank_049/d_4e50.bin" ; $4e50, 240 bytes
EldenSpriteFrame15:
	INCBIN "data/bank_049/d_4f40.bin" ; $4f40, 240 bytes
EldenSpriteFrame16:
	INCBIN "data/bank_049/d_5030.bin" ; $5030, 240 bytes
EldenSpriteFrame17:
	INCBIN "data/bank_049/d_5120.bin" ; $5120, 240 bytes
EldenSpriteFrame18:
	INCBIN "data/bank_049/d_5210.bin" ; $5210, 240 bytes
EldenSpriteFrame19:
	INCBIN "data/bank_049/d_5300.bin" ; $5300, 240 bytes
EldenSpriteFrame20:
	INCBIN "data/bank_049/d_53f0.bin" ; $53f0, 240 bytes
EldenSpriteFrame21:
	INCBIN "data/bank_049/d_54e0.bin" ; $54e0, 240 bytes
EldenSpriteFrame22:
	INCBIN "data/bank_049/d_55d0.bin" ; $55d0, 240 bytes
EldenSpriteFrame23:
	INCBIN "data/bank_049/d_56c0.bin" ; $56c0, 240 bytes
EldenSpriteFrame24:
	INCBIN "data/bank_049/d_57b0.bin" ; $57b0, 240 bytes
EldenSpriteFrame25:
	INCBIN "data/bank_049/d_58a0.bin" ; $58a0, 240 bytes
EldenSpriteFrame26:
	INCBIN "data/bank_049/d_5990.bin" ; $5990, 240 bytes
EldenSpriteFrame27:
	INCBIN "data/bank_049/d_5a80.bin" ; $5a80, 240 bytes
EldenSpriteFrame28:
	INCBIN "data/bank_049/d_5b70.bin" ; $5b70, 240 bytes
EldenSpriteFrame29:
	INCBIN "data/bank_049/d_5c60.bin" ; $5c60, 240 bytes
EldenSpriteFrame30:
	INCBIN "data/bank_049/d_5d50.bin" ; $5d50, 240 bytes
EldenSpriteFrame31:
	INCBIN "data/bank_049/d_5e40.bin" ; $5e40, 240 bytes
EldenSpriteFrame32:
	INCBIN "data/bank_049/d_5f30.bin" ; $5f30, 240 bytes
EldenSpriteFrame33:
	INCBIN "data/bank_049/d_6020.bin" ; $6020, 240 bytes
EldenSpriteFrame34:
	INCBIN "data/bank_049/d_6110.bin" ; $6110, 240 bytes
EldenSpriteFrame35:
	INCBIN "data/bank_049/d_6200.bin" ; $6200, 240 bytes
EldenSpriteFrame36:
	INCBIN "data/bank_049/d_62f0.bin" ; $62f0, 240 bytes
EldenSpriteFrame37:
	INCBIN "data/bank_049/d_63e0.bin" ; $63e0, 240 bytes
EldenSpriteFrame38:
	INCBIN "data/bank_049/d_64d0.bin" ; $64d0, 240 bytes
EldenSpriteFrame39:
	INCBIN "data/bank_049/d_65c0.bin" ; $65c0, 240 bytes
EldenSpriteFrame40:
	INCBIN "data/bank_049/d_66b0.bin" ; $66b0, 320 bytes
EldenSpriteFrame41:
	INCBIN "data/bank_049/d_67f0.bin" ; $67f0, 320 bytes
EldenSpriteFrame42:
	INCBIN "data/bank_049/d_6930.bin" ; $6930, 240 bytes
EldenSpriteFrame43:
	INCBIN "data/bank_049/d_6a20.bin" ; $6a20, 240 bytes
EldenSpriteFrame44:
	INCBIN "data/bank_049/d_6b10.bin" ; $6b10, 240 bytes
EldenSpriteFrame45:
	INCBIN "data/bank_049/d_6c00.bin" ; $6c00, 240 bytes
EldenSpriteFrame46:
	INCBIN "data/bank_049/d_6cf0.bin" ; $6cf0, 240 bytes
EldenSpriteFrame47:
	INCBIN "data/bank_049/d_6de0.bin" ; $6de0, 240 bytes
EldenSpriteFrame48:
	INCBIN "data/bank_049/d_6ed0.bin" ; $6ed0, 240 bytes
EldenSpriteFrame49:
	INCBIN "data/bank_049/d_6fc0.bin" ; $6fc0, 240 bytes
EldenSpriteFrame50:
	INCBIN "data/bank_049/d_70b0.bin" ; $70b0, 240 bytes
EldenSpriteFrame51:
	INCBIN "data/bank_049/d_71a0.bin" ; $71a0, 240 bytes
EldenSpriteFrame52:
	INCBIN "data/bank_049/d_7290.bin" ; $7290, 240 bytes
EldenSpriteFrame53:
	INCBIN "data/bank_049/d_7380.bin" ; $7380, 240 bytes
EldenSpriteFrame54:
	INCBIN "data/bank_049/d_7470.bin" ; $7470, 240 bytes
EldenSpriteFrame55:
	INCBIN "data/bank_049/d_7560.bin" ; $7560, 240 bytes
EldenSpriteFramesUnused:
	INCBIN "data/bank_049/d_7650.bin" ; $7650, 1680 bytes
EldenSpriteOam:
	INCBIN "data/bank_049/d_7ce0.bin" ; $7ce0, 580 bytes
EldenSpriteAnims:
	dw EldenSpriteAnim00 ; $7f24
	dw EldenSpriteAnim01 ; $7f26
	dw EldenSpriteAnim02 ; $7f28
	dw EldenSpriteAnim03 ; $7f2a
	dw EldenSpriteAnim04 ; $7f2c
	dw EldenSpriteAnim05 ; $7f2e
	dw EldenSpriteAnim06 ; $7f30
	dw EldenSpriteAnim07 ; $7f32
	dw EldenSpriteAnim08 ; $7f34
	dw EldenSpriteAnim09 ; $7f36
	dw EldenSpriteAnim10 ; $7f38
	dw EldenSpriteAnim11 ; $7f3a
	dw EldenSpriteAnim12 ; $7f3c
	dw EldenSpriteAnim13 ; $7f3e
	dw EldenSpriteAnim14 ; $7f40
	dw EldenSpriteAnim15 ; $7f42
	dw EldenSpriteAnim16 ; $7f44
	dw EldenSpriteAnim17 ; $7f46
	dw EldenSpriteAnim18 ; $7f48
EldenSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	db $00
	db $ff, $fd
EldenSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
EldenSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
EldenSpriteAnim03:
	; $7f5d, 10 bytes (sprite_anim)
	anim_frame $17, $0f
	anim_frame $19, $0f
	anim_frame $18, $0f
	anim_frame $19, $0f
	anim_loop $00
EldenSpriteAnim04:
	; $7f67, 8 bytes (sprite_anim)
	anim_frame $1a, $1e
	anim_frame $1b, $0f
	anim_frame $1c, $0f
	anim_loop $02
EldenSpriteAnim05:
	; $7f6f, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
EldenSpriteAnim06:
	; $7f75, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
EldenSpriteAnim07:
	; $7f7b, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
EldenSpriteAnim08:
	; $7f81, 5 bytes (sprite_anim)
	db $15, $04, $16, $14, $fd
EldenSpriteAnim09:
	; $7f86, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
EldenSpriteAnim10:
	; $7f8a, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
EldenSpriteAnim11:
	; $7f8e, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
EldenSpriteAnim12:
	; $7f92, 3 bytes (sprite_anim)
	db $15, $18, $fd
EldenSpriteAnim13:
	; $7f95, 3 bytes (sprite_anim)
	db $05, $ff, $fd
EldenSpriteAnim14:
	; $7f98, 3 bytes (sprite_anim)
	db $08, $ff, $fd
EldenSpriteAnim15:
	; $7f9b, 3 bytes (sprite_anim)
	db $0b, $ff, $fd
EldenSpriteAnim16:
	; $7f9e, 3 bytes (sprite_anim)
	db $0e, $ff, $fd
EldenSpriteAnim17:
	; $7fa1, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
EldenSpriteAnim18:
	; $7fad, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fb5, 75 bytes fill to bank end (linker-padded)
