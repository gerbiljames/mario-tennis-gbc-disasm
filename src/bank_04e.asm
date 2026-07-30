SECTION "ROM Bank $4e", ROMX[$4000], BANK[$4e]

	dw CurtSpriteDesc ; $4000
CurtSpriteDesc:
	dw $0007 ; $4002
	dw $0003 ; $4004
	dw CurtSpriteFrames ; $4006 frame table
	dw CurtSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw CurtSpriteOam ; $400c per-slot OAM data
CurtSpriteFrames:
	dw CurtSpriteFrame00 ; $400e
	dw CurtSpriteFrame01 ; $4010
	dw CurtSpriteFrame02 ; $4012
	dw CurtSpriteFrame03 ; $4014
	dw CurtSpriteFrame04 ; $4016
	dw CurtSpriteFrame05 ; $4018
	dw CurtSpriteFrame06 ; $401a
	dw CurtSpriteFrame07 ; $401c
	dw CurtSpriteFrame08 ; $401e
	dw CurtSpriteFrame09 ; $4020
	dw CurtSpriteFrame10 ; $4022
	dw CurtSpriteFrame01 ; $4024
	dw CurtSpriteFrame02 ; $4026
	dw CurtSpriteFrame03 ; $4028
	dw CurtSpriteFrame11 ; $402a
	dw CurtSpriteFrame12 ; $402c
	dw CurtSpriteFrame01 ; $402e
	dw CurtSpriteFrame02 ; $4030
	dw CurtSpriteFrame03 ; $4032
	dw CurtSpriteFrame13 ; $4034
	dw CurtSpriteFrame14 ; $4036
	dw CurtSpriteFrame06 ; $4038
	dw CurtSpriteFrame07 ; $403a
	dw CurtSpriteFrame08 ; $403c
	dw CurtSpriteFrame15 ; $403e
	dw CurtSpriteFrame16 ; $4040
	dw CurtSpriteFrame16 ; $4042
	dw CurtSpriteFrame16 ; $4044
	dw CurtSpriteFrame17 ; $4046
	dw CurtSpriteFrame17 ; $4048
	dw CurtSpriteFrame18 ; $404a
	dw CurtSpriteFrame18 ; $404c
	dw CurtSpriteFrame18 ; $404e
	dw CurtSpriteFrame19 ; $4050
	dw CurtSpriteFrame19 ; $4052
	dw CurtSpriteFrame20 ; $4054
	dw CurtSpriteFrame20 ; $4056
	dw CurtSpriteFrame20 ; $4058
	dw CurtSpriteFrame21 ; $405a
	dw CurtSpriteFrame21 ; $405c
	dw CurtSpriteFrame22 ; $405e
	dw CurtSpriteFrame22 ; $4060
	dw CurtSpriteFrame22 ; $4062
	dw CurtSpriteFrame23 ; $4064
	dw CurtSpriteFrame23 ; $4066
	dw CurtSpriteFrame24 ; $4068
	dw CurtSpriteFrame24 ; $406a
	dw CurtSpriteFrame24 ; $406c
	dw CurtSpriteFrame25 ; $406e
	dw CurtSpriteFrame25 ; $4070
	dw CurtSpriteFrame26 ; $4072
	dw CurtSpriteFrame26 ; $4074
	dw CurtSpriteFrame26 ; $4076
	dw CurtSpriteFrame27 ; $4078
	dw CurtSpriteFrame27 ; $407a
	dw CurtSpriteFrame28 ; $407c
	dw CurtSpriteFrame28 ; $407e
	dw CurtSpriteFrame28 ; $4080
	dw CurtSpriteFrame29 ; $4082
	dw CurtSpriteFrame29 ; $4084
	dw CurtSpriteFrame30 ; $4086
	dw CurtSpriteFrame30 ; $4088
	dw CurtSpriteFrame30 ; $408a
	dw CurtSpriteFrame31 ; $408c
	dw CurtSpriteFrame31 ; $408e
	dw CurtSpriteFrame32 ; $4090
	dw CurtSpriteFrame32 ; $4092
	dw CurtSpriteFrame32 ; $4094
	dw CurtSpriteFrame33 ; $4096
	dw CurtSpriteFrame33 ; $4098
	dw CurtSpriteFrame34 ; $409a
	dw CurtSpriteFrame34 ; $409c
	dw CurtSpriteFrame34 ; $409e
	dw CurtSpriteFrame35 ; $40a0
	dw CurtSpriteFrame35 ; $40a2
	dw CurtSpriteFrame36 ; $40a4
	dw CurtSpriteFrame36 ; $40a6
	dw CurtSpriteFrame36 ; $40a8
	dw CurtSpriteFrame37 ; $40aa
	dw CurtSpriteFrame37 ; $40ac
	dw CurtSpriteFrame38 ; $40ae
	dw CurtSpriteFrame38 ; $40b0
	dw CurtSpriteFrame38 ; $40b2
	dw CurtSpriteFrame39 ; $40b4
	dw CurtSpriteFrame39 ; $40b6
	dw CurtSpriteFrame40 ; $40b8
	dw CurtSpriteFrame40 ; $40ba
	dw CurtSpriteFrame40 ; $40bc
	dw CurtSpriteFrame41 ; $40be
	dw CurtSpriteFrame41 ; $40c0
	dw CurtSpriteFrame42 ; $40c2
	dw CurtSpriteFrame42 ; $40c4
	dw CurtSpriteFrame42 ; $40c6
	dw CurtSpriteFrame42 ; $40c8
	dw CurtSpriteFrame42 ; $40ca
	dw CurtSpriteFrame43 ; $40cc
	dw CurtSpriteFrame43 ; $40ce
	dw CurtSpriteFrame43 ; $40d0
	dw CurtSpriteFrame43 ; $40d2
	dw CurtSpriteFrame43 ; $40d4
	dw CurtSpriteFrame44 ; $40d6
	dw CurtSpriteFrame44 ; $40d8
	dw CurtSpriteFrame44 ; $40da
	dw CurtSpriteFrame45 ; $40dc
	dw CurtSpriteFrame45 ; $40de
	dw CurtSpriteFrame46 ; $40e0
	dw CurtSpriteFrame46 ; $40e2
	dw CurtSpriteFrame46 ; $40e4
	dw CurtSpriteFrame47 ; $40e6
	dw CurtSpriteFrame47 ; $40e8
	dw CurtSpriteFrame48 ; $40ea
	dw CurtSpriteFrame48 ; $40ec
	dw CurtSpriteFrame48 ; $40ee
	dw CurtSpriteFrame49 ; $40f0
	dw CurtSpriteFrame49 ; $40f2
	dw CurtSpriteFrame50 ; $40f4
	dw CurtSpriteFrame50 ; $40f6
	dw CurtSpriteFrame50 ; $40f8
	dw CurtSpriteFrame50 ; $40fa
	dw CurtSpriteFrame50 ; $40fc
	dw CurtSpriteFrame51 ; $40fe
	dw CurtSpriteFrame51 ; $4100
	dw CurtSpriteFrame51 ; $4102
	dw CurtSpriteFrame51 ; $4104
	dw CurtSpriteFrame51 ; $4106
	dw CurtSpriteFrame52 ; $4108
	dw CurtSpriteFrame52 ; $410a
	dw CurtSpriteFrame52 ; $410c
	dw CurtSpriteFrame52 ; $410e
	dw CurtSpriteFrame52 ; $4110
	dw CurtSpriteFrame53 ; $4112
	dw CurtSpriteFrame53 ; $4114
	dw CurtSpriteFrame53 ; $4116
	dw CurtSpriteFrame53 ; $4118
	dw CurtSpriteFrame53 ; $411a
	dw CurtSpriteFrame54 ; $411c
	dw CurtSpriteFrame54 ; $411e
	dw CurtSpriteFrame54 ; $4120
	dw CurtSpriteFrame54 ; $4122
	dw CurtSpriteFrame54 ; $4124
	dw CurtSpriteFrame55 ; $4126
	dw CurtSpriteFrame55 ; $4128
	dw CurtSpriteFrame55 ; $412a
	dw CurtSpriteFrame55 ; $412c
	dw CurtSpriteFrame55 ; $412e
CurtSpriteFrame00:
	INCBIN "data/bank_04e/d_4130.bin" ; $4130, 240 bytes
CurtSpriteFrame01:
	INCBIN "data/bank_04e/d_4220.bin" ; $4220, 240 bytes
CurtSpriteFrame02:
	INCBIN "data/bank_04e/d_4310.bin" ; $4310, 240 bytes
CurtSpriteFrame03:
	INCBIN "data/bank_04e/d_4400.bin" ; $4400, 240 bytes
CurtSpriteFrame04:
	INCBIN "data/bank_04e/d_44f0.bin" ; $44f0, 240 bytes
CurtSpriteFrame05:
	INCBIN "data/bank_04e/d_45e0.bin" ; $45e0, 240 bytes
CurtSpriteFrame06:
	INCBIN "data/bank_04e/d_46d0.bin" ; $46d0, 240 bytes
CurtSpriteFrame07:
	INCBIN "data/bank_04e/d_47c0.bin" ; $47c0, 240 bytes
CurtSpriteFrame08:
	INCBIN "data/bank_04e/d_48b0.bin" ; $48b0, 240 bytes
CurtSpriteFrame09:
	INCBIN "data/bank_04e/d_49a0.bin" ; $49a0, 240 bytes
CurtSpriteFrame10:
	INCBIN "data/bank_04e/d_4a90.bin" ; $4a90, 240 bytes
CurtSpriteFrame11:
	INCBIN "data/bank_04e/d_4b80.bin" ; $4b80, 240 bytes
CurtSpriteFrame12:
	INCBIN "data/bank_04e/d_4c70.bin" ; $4c70, 240 bytes
CurtSpriteFrame13:
	INCBIN "data/bank_04e/d_4d60.bin" ; $4d60, 240 bytes
CurtSpriteFrame14:
	INCBIN "data/bank_04e/d_4e50.bin" ; $4e50, 240 bytes
CurtSpriteFrame15:
	INCBIN "data/bank_04e/d_4f40.bin" ; $4f40, 240 bytes
CurtSpriteFrame16:
	INCBIN "data/bank_04e/d_5030.bin" ; $5030, 240 bytes
CurtSpriteFrame17:
	INCBIN "data/bank_04e/d_5120.bin" ; $5120, 240 bytes
CurtSpriteFrame18:
	INCBIN "data/bank_04e/d_5210.bin" ; $5210, 240 bytes
CurtSpriteFrame19:
	INCBIN "data/bank_04e/d_5300.bin" ; $5300, 240 bytes
CurtSpriteFrame20:
	INCBIN "data/bank_04e/d_53f0.bin" ; $53f0, 240 bytes
CurtSpriteFrame21:
	INCBIN "data/bank_04e/d_54e0.bin" ; $54e0, 240 bytes
CurtSpriteFrame22:
	INCBIN "data/bank_04e/d_55d0.bin" ; $55d0, 240 bytes
CurtSpriteFrame23:
	INCBIN "data/bank_04e/d_56c0.bin" ; $56c0, 240 bytes
CurtSpriteFrame24:
	INCBIN "data/bank_04e/d_57b0.bin" ; $57b0, 240 bytes
CurtSpriteFrame25:
	INCBIN "data/bank_04e/d_58a0.bin" ; $58a0, 240 bytes
CurtSpriteFrame26:
	INCBIN "data/bank_04e/d_5990.bin" ; $5990, 240 bytes
CurtSpriteFrame27:
	INCBIN "data/bank_04e/d_5a80.bin" ; $5a80, 240 bytes
CurtSpriteFrame28:
	INCBIN "data/bank_04e/d_5b70.bin" ; $5b70, 240 bytes
CurtSpriteFrame29:
	INCBIN "data/bank_04e/d_5c60.bin" ; $5c60, 240 bytes
CurtSpriteFrame30:
	INCBIN "data/bank_04e/d_5d50.bin" ; $5d50, 240 bytes
CurtSpriteFrame31:
	INCBIN "data/bank_04e/d_5e40.bin" ; $5e40, 240 bytes
CurtSpriteFrame32:
	INCBIN "data/bank_04e/d_5f30.bin" ; $5f30, 240 bytes
CurtSpriteFrame33:
	INCBIN "data/bank_04e/d_6020.bin" ; $6020, 240 bytes
CurtSpriteFrame34:
	INCBIN "data/bank_04e/d_6110.bin" ; $6110, 240 bytes
CurtSpriteFrame35:
	INCBIN "data/bank_04e/d_6200.bin" ; $6200, 240 bytes
CurtSpriteFrame36:
	INCBIN "data/bank_04e/d_62f0.bin" ; $62f0, 240 bytes
CurtSpriteFrame37:
	INCBIN "data/bank_04e/d_63e0.bin" ; $63e0, 240 bytes
CurtSpriteFrame38:
	INCBIN "data/bank_04e/d_64d0.bin" ; $64d0, 240 bytes
CurtSpriteFrame39:
	INCBIN "data/bank_04e/d_65c0.bin" ; $65c0, 240 bytes
CurtSpriteFrame40:
	INCBIN "data/bank_04e/d_66b0.bin" ; $66b0, 320 bytes
CurtSpriteFrame41:
	INCBIN "data/bank_04e/d_67f0.bin" ; $67f0, 320 bytes
CurtSpriteFrame42:
	INCBIN "data/bank_04e/d_6930.bin" ; $6930, 240 bytes
CurtSpriteFrame43:
	INCBIN "data/bank_04e/d_6a20.bin" ; $6a20, 240 bytes
CurtSpriteFrame44:
	INCBIN "data/bank_04e/d_6b10.bin" ; $6b10, 240 bytes
CurtSpriteFrame45:
	INCBIN "data/bank_04e/d_6c00.bin" ; $6c00, 240 bytes
CurtSpriteFrame46:
	INCBIN "data/bank_04e/d_6cf0.bin" ; $6cf0, 240 bytes
CurtSpriteFrame47:
	INCBIN "data/bank_04e/d_6de0.bin" ; $6de0, 240 bytes
CurtSpriteFrame48:
	INCBIN "data/bank_04e/d_6ed0.bin" ; $6ed0, 240 bytes
CurtSpriteFrame49:
	INCBIN "data/bank_04e/d_6fc0.bin" ; $6fc0, 240 bytes
CurtSpriteFrame50:
	INCBIN "data/bank_04e/d_70b0.bin" ; $70b0, 240 bytes
CurtSpriteFrame51:
	INCBIN "data/bank_04e/d_71a0.bin" ; $71a0, 240 bytes
CurtSpriteFrame52:
	INCBIN "data/bank_04e/d_7290.bin" ; $7290, 240 bytes
CurtSpriteFrame53:
	INCBIN "data/bank_04e/d_7380.bin" ; $7380, 240 bytes
CurtSpriteFrame54:
	INCBIN "data/bank_04e/d_7470.bin" ; $7470, 240 bytes
CurtSpriteFrame55:
	INCBIN "data/bank_04e/d_7560.bin" ; $7560, 240 bytes
CurtSpriteFramesUnused:
	INCBIN "data/bank_04e/d_7650.bin" ; $7650, 1680 bytes
CurtSpriteOam:
	INCBIN "data/bank_04e/d_7ce0.bin" ; $7ce0, 580 bytes
CurtSpriteAnims:
	dw CurtSpriteAnim00 ; $7f24
	dw CurtSpriteAnim01 ; $7f26
	dw CurtSpriteAnim02 ; $7f28
	dw CurtSpriteAnim03 ; $7f2a
	dw CurtSpriteAnim04 ; $7f2c
	dw CurtSpriteAnim05 ; $7f2e
	dw CurtSpriteAnim06 ; $7f30
	dw CurtSpriteAnim07 ; $7f32
	dw CurtSpriteAnim08 ; $7f34
	dw CurtSpriteAnim09 ; $7f36
	dw CurtSpriteAnim10 ; $7f38
	dw CurtSpriteAnim11 ; $7f3a
	dw CurtSpriteAnim12 ; $7f3c
	dw CurtSpriteAnim13 ; $7f3e
	dw CurtSpriteAnim14 ; $7f40
	dw CurtSpriteAnim15 ; $7f42
	dw CurtSpriteAnim16 ; $7f44
	dw CurtSpriteAnim17 ; $7f46
	dw CurtSpriteAnim18 ; $7f48
CurtSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
CurtSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
CurtSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
CurtSpriteAnim03:
	; $7f5d, 8 bytes (sprite_anim)
	anim_frame $17, $0a
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_loop $00
CurtSpriteAnim04:
	; $7f65, 8 bytes (sprite_anim)
	anim_frame $1a, $19
	anim_frame $1b, $37
	anim_frame $1c, $0a
	anim_loop $00
CurtSpriteAnim05:
	; $7f6d, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
CurtSpriteAnim06:
	; $7f73, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
CurtSpriteAnim07:
	; $7f79, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
CurtSpriteAnim08:
	; $7f7f, 5 bytes (sprite_anim)
	anim_frame $15, $04
	anim_frame $16, $14
	anim_hold $fd
CurtSpriteAnim09:
	; $7f84, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
CurtSpriteAnim10:
	; $7f88, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
CurtSpriteAnim11:
	; $7f8c, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
CurtSpriteAnim12:
	; $7f90, 3 bytes (sprite_anim)
	anim_frame $15, $18
	anim_hold $fd
CurtSpriteAnim13:
	; $7f93, 3 bytes (sprite_anim)
	anim_frame $05, $ff
	anim_hold $fd
CurtSpriteAnim14:
	; $7f96, 3 bytes (sprite_anim)
	anim_frame $08, $ff
	anim_hold $fd
CurtSpriteAnim15:
	; $7f99, 3 bytes (sprite_anim)
	anim_frame $0b, $ff
	anim_hold $fd
CurtSpriteAnim16:
	; $7f9c, 3 bytes (sprite_anim)
	anim_frame $0e, $ff
	anim_hold $fd
CurtSpriteAnim17:
	; $7f9f, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
CurtSpriteAnim18:
	; $7fab, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fb3, 77 bytes fill to bank end (linker-padded)
