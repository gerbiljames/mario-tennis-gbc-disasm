SECTION "ROM Bank $57", ROMX[$4000], BANK[$57]

	dw PamSpriteDesc ; $4000
PamSpriteDesc:
	dw $0007 ; $4002
	dw $0003 ; $4004
	dw PamSpriteFrames ; $4006 frame table
	dw PamSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw PamSpriteOam ; $400c per-slot OAM data
PamSpriteFrames:
	dw PamSpriteFrame00 ; $400e
	dw PamSpriteFrame01 ; $4010
	dw PamSpriteFrame02 ; $4012
	dw PamSpriteFrame03 ; $4014
	dw PamSpriteFrame04 ; $4016
	dw PamSpriteFrame05 ; $4018
	dw PamSpriteFrame06 ; $401a
	dw PamSpriteFrame07 ; $401c
	dw PamSpriteFrame08 ; $401e
	dw PamSpriteFrame09 ; $4020
	dw PamSpriteFrame10 ; $4022
	dw PamSpriteFrame01 ; $4024
	dw PamSpriteFrame02 ; $4026
	dw PamSpriteFrame03 ; $4028
	dw PamSpriteFrame11 ; $402a
	dw PamSpriteFrame12 ; $402c
	dw PamSpriteFrame01 ; $402e
	dw PamSpriteFrame02 ; $4030
	dw PamSpriteFrame03 ; $4032
	dw PamSpriteFrame13 ; $4034
	dw PamSpriteFrame14 ; $4036
	dw PamSpriteFrame06 ; $4038
	dw PamSpriteFrame07 ; $403a
	dw PamSpriteFrame08 ; $403c
	dw PamSpriteFrame15 ; $403e
	dw PamSpriteFrame16 ; $4040
	dw PamSpriteFrame16 ; $4042
	dw PamSpriteFrame16 ; $4044
	dw PamSpriteFrame17 ; $4046
	dw PamSpriteFrame17 ; $4048
	dw PamSpriteFrame18 ; $404a
	dw PamSpriteFrame18 ; $404c
	dw PamSpriteFrame18 ; $404e
	dw PamSpriteFrame19 ; $4050
	dw PamSpriteFrame19 ; $4052
	dw PamSpriteFrame20 ; $4054
	dw PamSpriteFrame20 ; $4056
	dw PamSpriteFrame20 ; $4058
	dw PamSpriteFrame21 ; $405a
	dw PamSpriteFrame21 ; $405c
	dw PamSpriteFrame22 ; $405e
	dw PamSpriteFrame22 ; $4060
	dw PamSpriteFrame22 ; $4062
	dw PamSpriteFrame23 ; $4064
	dw PamSpriteFrame23 ; $4066
	dw PamSpriteFrame24 ; $4068
	dw PamSpriteFrame24 ; $406a
	dw PamSpriteFrame24 ; $406c
	dw PamSpriteFrame25 ; $406e
	dw PamSpriteFrame25 ; $4070
	dw PamSpriteFrame26 ; $4072
	dw PamSpriteFrame26 ; $4074
	dw PamSpriteFrame26 ; $4076
	dw PamSpriteFrame27 ; $4078
	dw PamSpriteFrame27 ; $407a
	dw PamSpriteFrame28 ; $407c
	dw PamSpriteFrame28 ; $407e
	dw PamSpriteFrame28 ; $4080
	dw PamSpriteFrame29 ; $4082
	dw PamSpriteFrame29 ; $4084
	dw PamSpriteFrame30 ; $4086
	dw PamSpriteFrame30 ; $4088
	dw PamSpriteFrame30 ; $408a
	dw PamSpriteFrame31 ; $408c
	dw PamSpriteFrame31 ; $408e
	dw PamSpriteFrame32 ; $4090
	dw PamSpriteFrame32 ; $4092
	dw PamSpriteFrame32 ; $4094
	dw PamSpriteFrame33 ; $4096
	dw PamSpriteFrame33 ; $4098
	dw PamSpriteFrame34 ; $409a
	dw PamSpriteFrame34 ; $409c
	dw PamSpriteFrame34 ; $409e
	dw PamSpriteFrame35 ; $40a0
	dw PamSpriteFrame35 ; $40a2
	dw PamSpriteFrame36 ; $40a4
	dw PamSpriteFrame36 ; $40a6
	dw PamSpriteFrame36 ; $40a8
	dw PamSpriteFrame37 ; $40aa
	dw PamSpriteFrame37 ; $40ac
	dw PamSpriteFrame38 ; $40ae
	dw PamSpriteFrame38 ; $40b0
	dw PamSpriteFrame38 ; $40b2
	dw PamSpriteFrame39 ; $40b4
	dw PamSpriteFrame39 ; $40b6
	dw PamSpriteFrame40 ; $40b8
	dw PamSpriteFrame40 ; $40ba
	dw PamSpriteFrame40 ; $40bc
	dw PamSpriteFrame41 ; $40be
	dw PamSpriteFrame41 ; $40c0
	dw PamSpriteFrame42 ; $40c2
	dw PamSpriteFrame42 ; $40c4
	dw PamSpriteFrame42 ; $40c6
	dw PamSpriteFrame42 ; $40c8
	dw PamSpriteFrame42 ; $40ca
	dw PamSpriteFrame43 ; $40cc
	dw PamSpriteFrame43 ; $40ce
	dw PamSpriteFrame43 ; $40d0
	dw PamSpriteFrame43 ; $40d2
	dw PamSpriteFrame43 ; $40d4
	dw PamSpriteFrame44 ; $40d6
	dw PamSpriteFrame44 ; $40d8
	dw PamSpriteFrame44 ; $40da
	dw PamSpriteFrame45 ; $40dc
	dw PamSpriteFrame45 ; $40de
	dw PamSpriteFrame46 ; $40e0
	dw PamSpriteFrame46 ; $40e2
	dw PamSpriteFrame46 ; $40e4
	dw PamSpriteFrame47 ; $40e6
	dw PamSpriteFrame47 ; $40e8
	dw PamSpriteFrame48 ; $40ea
	dw PamSpriteFrame48 ; $40ec
	dw PamSpriteFrame48 ; $40ee
	dw PamSpriteFrame49 ; $40f0
	dw PamSpriteFrame49 ; $40f2
	dw PamSpriteFrame50 ; $40f4
	dw PamSpriteFrame50 ; $40f6
	dw PamSpriteFrame50 ; $40f8
	dw PamSpriteFrame50 ; $40fa
	dw PamSpriteFrame50 ; $40fc
	dw PamSpriteFrame51 ; $40fe
	dw PamSpriteFrame51 ; $4100
	dw PamSpriteFrame51 ; $4102
	dw PamSpriteFrame51 ; $4104
	dw PamSpriteFrame51 ; $4106
	dw PamSpriteFrame52 ; $4108
	dw PamSpriteFrame52 ; $410a
	dw PamSpriteFrame52 ; $410c
	dw PamSpriteFrame52 ; $410e
	dw PamSpriteFrame52 ; $4110
	dw PamSpriteFrame53 ; $4112
	dw PamSpriteFrame53 ; $4114
	dw PamSpriteFrame53 ; $4116
	dw PamSpriteFrame53 ; $4118
	dw PamSpriteFrame53 ; $411a
	dw PamSpriteFrame54 ; $411c
	dw PamSpriteFrame54 ; $411e
	dw PamSpriteFrame54 ; $4120
	dw PamSpriteFrame54 ; $4122
	dw PamSpriteFrame54 ; $4124
	dw PamSpriteFrame55 ; $4126
	dw PamSpriteFrame55 ; $4128
	dw PamSpriteFrame55 ; $412a
	dw PamSpriteFrame55 ; $412c
	dw PamSpriteFrame55 ; $412e
PamSpriteFrame00:
	INCBIN "data/bank_057/d_4130.bin" ; $4130, 240 bytes
PamSpriteFrame01:
	INCBIN "data/bank_057/d_4220.bin" ; $4220, 240 bytes
PamSpriteFrame02:
	INCBIN "data/bank_057/d_4310.bin" ; $4310, 240 bytes
PamSpriteFrame03:
	INCBIN "data/bank_057/d_4400.bin" ; $4400, 240 bytes
PamSpriteFrame04:
	INCBIN "data/bank_057/d_44f0.bin" ; $44f0, 240 bytes
PamSpriteFrame05:
	INCBIN "data/bank_057/d_45e0.bin" ; $45e0, 240 bytes
PamSpriteFrame06:
	INCBIN "data/bank_057/d_46d0.bin" ; $46d0, 240 bytes
PamSpriteFrame07:
	INCBIN "data/bank_057/d_47c0.bin" ; $47c0, 240 bytes
PamSpriteFrame08:
	INCBIN "data/bank_057/d_48b0.bin" ; $48b0, 240 bytes
PamSpriteFrame09:
	INCBIN "data/bank_057/d_49a0.bin" ; $49a0, 240 bytes
PamSpriteFrame10:
	INCBIN "data/bank_057/d_4a90.bin" ; $4a90, 240 bytes
PamSpriteFrame11:
	INCBIN "data/bank_057/d_4b80.bin" ; $4b80, 240 bytes
PamSpriteFrame12:
	INCBIN "data/bank_057/d_4c70.bin" ; $4c70, 240 bytes
PamSpriteFrame13:
	INCBIN "data/bank_057/d_4d60.bin" ; $4d60, 240 bytes
PamSpriteFrame14:
	INCBIN "data/bank_057/d_4e50.bin" ; $4e50, 240 bytes
PamSpriteFrame15:
	INCBIN "data/bank_057/d_4f40.bin" ; $4f40, 240 bytes
PamSpriteFrame16:
	INCBIN "data/bank_057/d_5030.bin" ; $5030, 240 bytes
PamSpriteFrame17:
	INCBIN "data/bank_057/d_5120.bin" ; $5120, 240 bytes
PamSpriteFrame18:
	INCBIN "data/bank_057/d_5210.bin" ; $5210, 240 bytes
PamSpriteFrame19:
	INCBIN "data/bank_057/d_5300.bin" ; $5300, 240 bytes
PamSpriteFrame20:
	INCBIN "data/bank_057/d_53f0.bin" ; $53f0, 240 bytes
PamSpriteFrame21:
	INCBIN "data/bank_057/d_54e0.bin" ; $54e0, 240 bytes
PamSpriteFrame22:
	INCBIN "data/bank_057/d_55d0.bin" ; $55d0, 240 bytes
PamSpriteFrame23:
	INCBIN "data/bank_057/d_56c0.bin" ; $56c0, 240 bytes
PamSpriteFrame24:
	INCBIN "data/bank_057/d_57b0.bin" ; $57b0, 240 bytes
PamSpriteFrame25:
	INCBIN "data/bank_057/d_58a0.bin" ; $58a0, 240 bytes
PamSpriteFrame26:
	INCBIN "data/bank_057/d_5990.bin" ; $5990, 240 bytes
PamSpriteFrame27:
	INCBIN "data/bank_057/d_5a80.bin" ; $5a80, 240 bytes
PamSpriteFrame28:
	INCBIN "data/bank_057/d_5b70.bin" ; $5b70, 240 bytes
PamSpriteFrame29:
	INCBIN "data/bank_057/d_5c60.bin" ; $5c60, 240 bytes
PamSpriteFrame30:
	INCBIN "data/bank_057/d_5d50.bin" ; $5d50, 240 bytes
PamSpriteFrame31:
	INCBIN "data/bank_057/d_5e40.bin" ; $5e40, 240 bytes
PamSpriteFrame32:
	INCBIN "data/bank_057/d_5f30.bin" ; $5f30, 240 bytes
PamSpriteFrame33:
	INCBIN "data/bank_057/d_6020.bin" ; $6020, 240 bytes
PamSpriteFrame34:
	INCBIN "data/bank_057/d_6110.bin" ; $6110, 240 bytes
PamSpriteFrame35:
	INCBIN "data/bank_057/d_6200.bin" ; $6200, 240 bytes
PamSpriteFrame36:
	INCBIN "data/bank_057/d_62f0.bin" ; $62f0, 240 bytes
PamSpriteFrame37:
	INCBIN "data/bank_057/d_63e0.bin" ; $63e0, 240 bytes
PamSpriteFrame38:
	INCBIN "data/bank_057/d_64d0.bin" ; $64d0, 240 bytes
PamSpriteFrame39:
	INCBIN "data/bank_057/d_65c0.bin" ; $65c0, 240 bytes
PamSpriteFrame40:
	INCBIN "data/bank_057/d_66b0.bin" ; $66b0, 320 bytes
PamSpriteFrame41:
	INCBIN "data/bank_057/d_67f0.bin" ; $67f0, 320 bytes
PamSpriteFrame42:
	INCBIN "data/bank_057/d_6930.bin" ; $6930, 240 bytes
PamSpriteFrame43:
	INCBIN "data/bank_057/d_6a20.bin" ; $6a20, 240 bytes
PamSpriteFrame44:
	INCBIN "data/bank_057/d_6b10.bin" ; $6b10, 240 bytes
PamSpriteFrame45:
	INCBIN "data/bank_057/d_6c00.bin" ; $6c00, 240 bytes
PamSpriteFrame46:
	INCBIN "data/bank_057/d_6cf0.bin" ; $6cf0, 240 bytes
PamSpriteFrame47:
	INCBIN "data/bank_057/d_6de0.bin" ; $6de0, 240 bytes
PamSpriteFrame48:
	INCBIN "data/bank_057/d_6ed0.bin" ; $6ed0, 240 bytes
PamSpriteFrame49:
	INCBIN "data/bank_057/d_6fc0.bin" ; $6fc0, 240 bytes
PamSpriteFrame50:
	INCBIN "data/bank_057/d_70b0.bin" ; $70b0, 240 bytes
PamSpriteFrame51:
	INCBIN "data/bank_057/d_71a0.bin" ; $71a0, 240 bytes
PamSpriteFrame52:
	INCBIN "data/bank_057/d_7290.bin" ; $7290, 240 bytes
PamSpriteFrame53:
	INCBIN "data/bank_057/d_7380.bin" ; $7380, 240 bytes
PamSpriteFrame54:
	INCBIN "data/bank_057/d_7470.bin" ; $7470, 240 bytes
PamSpriteFrame55:
	INCBIN "data/bank_057/d_7560.bin" ; $7560, 240 bytes
PamSpriteFramesUnused:
	INCBIN "data/bank_057/d_7650.bin" ; $7650, 1680 bytes
PamSpriteOam:
	INCBIN "data/bank_057/d_7ce0.bin" ; $7ce0, 580 bytes
PamSpriteAnims:
	dw PamSpriteAnim00 ; $7f24
	dw PamSpriteAnim01 ; $7f26
	dw PamSpriteAnim02 ; $7f28
	dw PamSpriteAnim03 ; $7f2a
	dw PamSpriteAnim04 ; $7f2c
	dw PamSpriteAnim05 ; $7f2e
	dw PamSpriteAnim06 ; $7f30
	dw PamSpriteAnim07 ; $7f32
	dw PamSpriteAnim08 ; $7f34
	dw PamSpriteAnim09 ; $7f36
	dw PamSpriteAnim10 ; $7f38
	dw PamSpriteAnim11 ; $7f3a
	dw PamSpriteAnim12 ; $7f3c
	dw PamSpriteAnim13 ; $7f3e
	dw PamSpriteAnim14 ; $7f40
	dw PamSpriteAnim15 ; $7f42
	dw PamSpriteAnim16 ; $7f44
	dw PamSpriteAnim17 ; $7f46
	dw PamSpriteAnim18 ; $7f48
PamSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	db $00
	db $ff, $fd
PamSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
PamSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
PamSpriteAnim03:
	; $7f5d, 22 bytes (sprite_anim)
	anim_flip $20
	anim_frame $17, $0a
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_frame $18, $0a
	anim_flip $00
	anim_frame $17, $0a
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_frame $18, $0a
	anim_loop $00
PamSpriteAnim04:
	; $7f73, 10 bytes (sprite_anim)
	anim_frame $1a, $0a
	anim_frame $1b, $0a
	anim_frame $1a, $0a
	anim_frame $1c, $0a
	anim_loop $00
PamSpriteAnim05:
	; $7f7d, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
PamSpriteAnim06:
	; $7f83, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
PamSpriteAnim07:
	; $7f89, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
PamSpriteAnim08:
	; $7f8f, 5 bytes (sprite_anim)
	db $15, $04, $16, $14, $fd
PamSpriteAnim09:
	; $7f94, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
PamSpriteAnim10:
	; $7f98, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
PamSpriteAnim11:
	; $7f9c, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
PamSpriteAnim12:
	; $7fa0, 3 bytes (sprite_anim)
	db $15, $18, $fd
PamSpriteAnim13:
	; $7fa3, 3 bytes (sprite_anim)
	db $05, $ff, $fd
PamSpriteAnim14:
	; $7fa6, 3 bytes (sprite_anim)
	db $08, $ff, $fd
PamSpriteAnim15:
	; $7fa9, 3 bytes (sprite_anim)
	db $0b, $ff, $fd
PamSpriteAnim16:
	; $7fac, 3 bytes (sprite_anim)
	db $0e, $ff, $fd
PamSpriteAnim17:
	; $7faf, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
PamSpriteAnim18:
	; $7fbb, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fc3, 61 bytes fill to bank end (linker-padded)
