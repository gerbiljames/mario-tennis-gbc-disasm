SECTION "ROM Bank $42", ROMX[$4000], BANK[$42]

	dw KateSpriteDesc ; $4000
KateSpriteDesc:
	dw $0004 ; $4002
	dw $0003 ; $4004
	dw KateSpriteFrames ; $4006 frame table
	dw KateSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw KateSpriteOam ; $400c per-slot OAM data
KateSpriteFrames:
	dw KateSpriteFrame00 ; $400e
	dw KateSpriteFrame01 ; $4010
	dw KateSpriteFrame02 ; $4012
	dw KateSpriteFrame03 ; $4014
	dw KateSpriteFrame04 ; $4016
	dw KateSpriteFrame05 ; $4018
	dw KateSpriteFrame06 ; $401a
	dw KateSpriteFrame07 ; $401c
	dw KateSpriteFrame08 ; $401e
	dw KateSpriteFrame09 ; $4020
	dw KateSpriteFrame10 ; $4022
	dw KateSpriteFrame01 ; $4024
	dw KateSpriteFrame02 ; $4026
	dw KateSpriteFrame03 ; $4028
	dw KateSpriteFrame11 ; $402a
	dw KateSpriteFrame12 ; $402c
	dw KateSpriteFrame01 ; $402e
	dw KateSpriteFrame02 ; $4030
	dw KateSpriteFrame03 ; $4032
	dw KateSpriteFrame13 ; $4034
	dw KateSpriteFrame14 ; $4036
	dw KateSpriteFrame06 ; $4038
	dw KateSpriteFrame07 ; $403a
	dw KateSpriteFrame08 ; $403c
	dw KateSpriteFrame15 ; $403e
	dw KateSpriteFrame16 ; $4040
	dw KateSpriteFrame16 ; $4042
	dw KateSpriteFrame16 ; $4044
	dw KateSpriteFrame17 ; $4046
	dw KateSpriteFrame17 ; $4048
	dw KateSpriteFrame18 ; $404a
	dw KateSpriteFrame18 ; $404c
	dw KateSpriteFrame18 ; $404e
	dw KateSpriteFrame19 ; $4050
	dw KateSpriteFrame19 ; $4052
	dw KateSpriteFrame20 ; $4054
	dw KateSpriteFrame20 ; $4056
	dw KateSpriteFrame20 ; $4058
	dw KateSpriteFrame21 ; $405a
	dw KateSpriteFrame21 ; $405c
	dw KateSpriteFrame22 ; $405e
	dw KateSpriteFrame22 ; $4060
	dw KateSpriteFrame22 ; $4062
	dw KateSpriteFrame23 ; $4064
	dw KateSpriteFrame23 ; $4066
	dw KateSpriteFrame24 ; $4068
	dw KateSpriteFrame24 ; $406a
	dw KateSpriteFrame24 ; $406c
	dw KateSpriteFrame25 ; $406e
	dw KateSpriteFrame25 ; $4070
	dw KateSpriteFrame26 ; $4072
	dw KateSpriteFrame26 ; $4074
	dw KateSpriteFrame26 ; $4076
	dw KateSpriteFrame27 ; $4078
	dw KateSpriteFrame27 ; $407a
	dw KateSpriteFrame28 ; $407c
	dw KateSpriteFrame28 ; $407e
	dw KateSpriteFrame28 ; $4080
	dw KateSpriteFrame29 ; $4082
	dw KateSpriteFrame29 ; $4084
	dw KateSpriteFrame30 ; $4086
	dw KateSpriteFrame30 ; $4088
	dw KateSpriteFrame30 ; $408a
	dw KateSpriteFrame31 ; $408c
	dw KateSpriteFrame31 ; $408e
	dw KateSpriteFrame32 ; $4090
	dw KateSpriteFrame32 ; $4092
	dw KateSpriteFrame32 ; $4094
	dw KateSpriteFrame33 ; $4096
	dw KateSpriteFrame33 ; $4098
	dw KateSpriteFrame34 ; $409a
	dw KateSpriteFrame34 ; $409c
	dw KateSpriteFrame34 ; $409e
	dw KateSpriteFrame35 ; $40a0
	dw KateSpriteFrame35 ; $40a2
	dw KateSpriteFrame36 ; $40a4
	dw KateSpriteFrame36 ; $40a6
	dw KateSpriteFrame36 ; $40a8
	dw KateSpriteFrame37 ; $40aa
	dw KateSpriteFrame37 ; $40ac
	dw KateSpriteFrame38 ; $40ae
	dw KateSpriteFrame38 ; $40b0
	dw KateSpriteFrame38 ; $40b2
	dw KateSpriteFrame39 ; $40b4
	dw KateSpriteFrame39 ; $40b6
	dw KateSpriteFrame40 ; $40b8
	dw KateSpriteFrame40 ; $40ba
	dw KateSpriteFrame40 ; $40bc
	dw KateSpriteFrame41 ; $40be
	dw KateSpriteFrame41 ; $40c0
	dw KateSpriteFrame42 ; $40c2
	dw KateSpriteFrame42 ; $40c4
	dw KateSpriteFrame42 ; $40c6
	dw KateSpriteFrame42 ; $40c8
	dw KateSpriteFrame42 ; $40ca
	dw KateSpriteFrame43 ; $40cc
	dw KateSpriteFrame43 ; $40ce
	dw KateSpriteFrame43 ; $40d0
	dw KateSpriteFrame43 ; $40d2
	dw KateSpriteFrame43 ; $40d4
	dw KateSpriteFrame44 ; $40d6
	dw KateSpriteFrame44 ; $40d8
	dw KateSpriteFrame44 ; $40da
	dw KateSpriteFrame45 ; $40dc
	dw KateSpriteFrame45 ; $40de
	dw KateSpriteFrame46 ; $40e0
	dw KateSpriteFrame46 ; $40e2
	dw KateSpriteFrame46 ; $40e4
	dw KateSpriteFrame47 ; $40e6
	dw KateSpriteFrame47 ; $40e8
	dw KateSpriteFrame48 ; $40ea
	dw KateSpriteFrame48 ; $40ec
	dw KateSpriteFrame48 ; $40ee
	dw KateSpriteFrame49 ; $40f0
	dw KateSpriteFrame49 ; $40f2
	dw KateSpriteFrame50 ; $40f4
	dw KateSpriteFrame50 ; $40f6
	dw KateSpriteFrame50 ; $40f8
	dw KateSpriteFrame50 ; $40fa
	dw KateSpriteFrame50 ; $40fc
	dw KateSpriteFrame51 ; $40fe
	dw KateSpriteFrame51 ; $4100
	dw KateSpriteFrame51 ; $4102
	dw KateSpriteFrame51 ; $4104
	dw KateSpriteFrame51 ; $4106
	dw KateSpriteFrame52 ; $4108
	dw KateSpriteFrame52 ; $410a
	dw KateSpriteFrame52 ; $410c
	dw KateSpriteFrame52 ; $410e
	dw KateSpriteFrame52 ; $4110
	dw KateSpriteFrame53 ; $4112
	dw KateSpriteFrame53 ; $4114
	dw KateSpriteFrame53 ; $4116
	dw KateSpriteFrame53 ; $4118
	dw KateSpriteFrame53 ; $411a
	dw KateSpriteFrame54 ; $411c
	dw KateSpriteFrame54 ; $411e
	dw KateSpriteFrame54 ; $4120
	dw KateSpriteFrame54 ; $4122
	dw KateSpriteFrame54 ; $4124
	dw KateSpriteFrame55 ; $4126
	dw KateSpriteFrame55 ; $4128
	dw KateSpriteFrame55 ; $412a
	dw KateSpriteFrame55 ; $412c
	dw KateSpriteFrame55 ; $412e
KateSpriteFrame00:
	INCBIN "data/bank_042/d_4130.bin" ; $4130, 240 bytes
KateSpriteFrame01:
	INCBIN "data/bank_042/d_4220.bin" ; $4220, 240 bytes
KateSpriteFrame02:
	INCBIN "data/bank_042/d_4310.bin" ; $4310, 240 bytes
KateSpriteFrame03:
	INCBIN "data/bank_042/d_4400.bin" ; $4400, 240 bytes
KateSpriteFrame04:
	INCBIN "data/bank_042/d_44f0.bin" ; $44f0, 240 bytes
KateSpriteFrame05:
	INCBIN "data/bank_042/d_45e0.bin" ; $45e0, 240 bytes
KateSpriteFrame06:
	INCBIN "data/bank_042/d_46d0.bin" ; $46d0, 240 bytes
KateSpriteFrame07:
	INCBIN "data/bank_042/d_47c0.bin" ; $47c0, 240 bytes
KateSpriteFrame08:
	INCBIN "data/bank_042/d_48b0.bin" ; $48b0, 240 bytes
KateSpriteFrame09:
	INCBIN "data/bank_042/d_49a0.bin" ; $49a0, 240 bytes
KateSpriteFrame10:
	INCBIN "data/bank_042/d_4a90.bin" ; $4a90, 240 bytes
KateSpriteFrame11:
	INCBIN "data/bank_042/d_4b80.bin" ; $4b80, 240 bytes
KateSpriteFrame12:
	INCBIN "data/bank_042/d_4c70.bin" ; $4c70, 240 bytes
KateSpriteFrame13:
	INCBIN "data/bank_042/d_4d60.bin" ; $4d60, 240 bytes
KateSpriteFrame14:
	INCBIN "data/bank_042/d_4e50.bin" ; $4e50, 240 bytes
KateSpriteFrame15:
	INCBIN "data/bank_042/d_4f40.bin" ; $4f40, 240 bytes
KateSpriteFrame16:
	INCBIN "data/bank_042/d_5030.bin" ; $5030, 240 bytes
KateSpriteFrame17:
	INCBIN "data/bank_042/d_5120.bin" ; $5120, 240 bytes
KateSpriteFrame18:
	INCBIN "data/bank_042/d_5210.bin" ; $5210, 240 bytes
KateSpriteFrame19:
	INCBIN "data/bank_042/d_5300.bin" ; $5300, 240 bytes
KateSpriteFrame20:
	INCBIN "data/bank_042/d_53f0.bin" ; $53f0, 240 bytes
KateSpriteFrame21:
	INCBIN "data/bank_042/d_54e0.bin" ; $54e0, 240 bytes
KateSpriteFrame22:
	INCBIN "data/bank_042/d_55d0.bin" ; $55d0, 240 bytes
KateSpriteFrame23:
	INCBIN "data/bank_042/d_56c0.bin" ; $56c0, 240 bytes
KateSpriteFrame24:
	INCBIN "data/bank_042/d_57b0.bin" ; $57b0, 240 bytes
KateSpriteFrame25:
	INCBIN "data/bank_042/d_58a0.bin" ; $58a0, 240 bytes
KateSpriteFrame26:
	INCBIN "data/bank_042/d_5990.bin" ; $5990, 240 bytes
KateSpriteFrame27:
	INCBIN "data/bank_042/d_5a80.bin" ; $5a80, 240 bytes
KateSpriteFrame28:
	INCBIN "data/bank_042/d_5b70.bin" ; $5b70, 240 bytes
KateSpriteFrame29:
	INCBIN "data/bank_042/d_5c60.bin" ; $5c60, 240 bytes
KateSpriteFrame30:
	INCBIN "data/bank_042/d_5d50.bin" ; $5d50, 240 bytes
KateSpriteFrame31:
	INCBIN "data/bank_042/d_5e40.bin" ; $5e40, 240 bytes
KateSpriteFrame32:
	INCBIN "data/bank_042/d_5f30.bin" ; $5f30, 240 bytes
KateSpriteFrame33:
	INCBIN "data/bank_042/d_6020.bin" ; $6020, 240 bytes
KateSpriteFrame34:
	INCBIN "data/bank_042/d_6110.bin" ; $6110, 240 bytes
KateSpriteFrame35:
	INCBIN "data/bank_042/d_6200.bin" ; $6200, 240 bytes
KateSpriteFrame36:
	INCBIN "data/bank_042/d_62f0.bin" ; $62f0, 240 bytes
KateSpriteFrame37:
	INCBIN "data/bank_042/d_63e0.bin" ; $63e0, 240 bytes
KateSpriteFrame38:
	INCBIN "data/bank_042/d_64d0.bin" ; $64d0, 240 bytes
KateSpriteFrame39:
	INCBIN "data/bank_042/d_65c0.bin" ; $65c0, 240 bytes
KateSpriteFrame40:
	INCBIN "data/bank_042/d_66b0.bin" ; $66b0, 320 bytes
KateSpriteFrame41:
	INCBIN "data/bank_042/d_67f0.bin" ; $67f0, 320 bytes
KateSpriteFrame42:
	INCBIN "data/bank_042/d_6930.bin" ; $6930, 240 bytes
KateSpriteFrame43:
	INCBIN "data/bank_042/d_6a20.bin" ; $6a20, 240 bytes
KateSpriteFrame44:
	INCBIN "data/bank_042/d_6b10.bin" ; $6b10, 240 bytes
KateSpriteFrame45:
	INCBIN "data/bank_042/d_6c00.bin" ; $6c00, 240 bytes
KateSpriteFrame46:
	INCBIN "data/bank_042/d_6cf0.bin" ; $6cf0, 240 bytes
KateSpriteFrame47:
	INCBIN "data/bank_042/d_6de0.bin" ; $6de0, 240 bytes
KateSpriteFrame48:
	INCBIN "data/bank_042/d_6ed0.bin" ; $6ed0, 240 bytes
KateSpriteFrame49:
	INCBIN "data/bank_042/d_6fc0.bin" ; $6fc0, 240 bytes
KateSpriteFrame50:
	INCBIN "data/bank_042/d_70b0.bin" ; $70b0, 240 bytes
KateSpriteFrame51:
	INCBIN "data/bank_042/d_71a0.bin" ; $71a0, 240 bytes
KateSpriteFrame52:
	INCBIN "data/bank_042/d_7290.bin" ; $7290, 240 bytes
KateSpriteFrame53:
	INCBIN "data/bank_042/d_7380.bin" ; $7380, 240 bytes
KateSpriteFrame54:
	INCBIN "data/bank_042/d_7470.bin" ; $7470, 240 bytes
KateSpriteFrame55:
	INCBIN "data/bank_042/d_7560.bin" ; $7560, 240 bytes
KateSpriteFramesUnused:
	INCBIN "data/bank_042/d_7650.bin" ; $7650, 1680 bytes
KateSpriteOam:
	INCBIN "data/bank_042/d_7ce0.bin" ; $7ce0, 580 bytes
KateSpriteAnims:
	dw KateSpriteAnim00 ; $7f24
	dw KateSpriteAnim01 ; $7f26
	dw KateSpriteAnim02 ; $7f28
	dw KateSpriteAnim03 ; $7f2a
	dw KateSpriteAnim04 ; $7f2c
	dw KateSpriteAnim05 ; $7f2e
	dw KateSpriteAnim06 ; $7f30
	dw KateSpriteAnim07 ; $7f32
	dw KateSpriteAnim08 ; $7f34
	dw KateSpriteAnim09 ; $7f36
	dw KateSpriteAnim10 ; $7f38
	dw KateSpriteAnim11 ; $7f3a
	dw KateSpriteAnim12 ; $7f3c
	dw KateSpriteAnim13 ; $7f3e
	dw KateSpriteAnim14 ; $7f40
	dw KateSpriteAnim15 ; $7f42
	dw KateSpriteAnim16 ; $7f44
	dw KateSpriteAnim17 ; $7f46
	dw KateSpriteAnim18 ; $7f48
KateSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	db $00
	db $ff, $fd
KateSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
KateSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
KateSpriteAnim03:
	; $7f5d, 10 bytes (sprite_anim)
	anim_frame $17, $0f
	anim_frame $19, $0f
	anim_frame $18, $0f
	anim_frame $19, $0f
	anim_loop $00
KateSpriteAnim04:
	; $7f67, 8 bytes (sprite_anim)
	anim_frame $1a, $1e
	anim_frame $1b, $14
	anim_frame $1c, $14
	anim_loop $02
KateSpriteAnim05:
	; $7f6f, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
KateSpriteAnim06:
	; $7f75, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
KateSpriteAnim07:
	; $7f7b, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
KateSpriteAnim08:
	; $7f81, 5 bytes (sprite_anim)
	db $15, $04, $16, $14, $fd
KateSpriteAnim09:
	; $7f86, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
KateSpriteAnim10:
	; $7f8a, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
KateSpriteAnim11:
	; $7f8e, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
KateSpriteAnim12:
	; $7f92, 3 bytes (sprite_anim)
	db $15, $18, $fd
KateSpriteAnim13:
	; $7f95, 3 bytes (sprite_anim)
	db $05, $ff, $fd
KateSpriteAnim14:
	; $7f98, 3 bytes (sprite_anim)
	db $08, $ff, $fd
KateSpriteAnim15:
	; $7f9b, 3 bytes (sprite_anim)
	db $0b, $ff, $fd
KateSpriteAnim16:
	; $7f9e, 3 bytes (sprite_anim)
	db $0e, $ff, $fd
KateSpriteAnim17:
	; $7fa1, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
KateSpriteAnim18:
	; $7fad, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fb5, 75 bytes fill to bank end (linker-padded)
