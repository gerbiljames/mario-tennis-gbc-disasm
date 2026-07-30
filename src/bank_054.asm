SECTION "ROM Bank $54", ROMX[$4000], BANK[$54]

	dw PeachSpriteDesc ; $4000
PeachSpriteDesc:
	dw $0005 ; $4002
	dw $0003 ; $4004
	dw PeachSpriteFrames ; $4006 frame table
	dw PeachSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw PeachSpriteOam ; $400c per-slot OAM data
PeachSpriteFrames:
	dw PeachSpriteFrame00 ; $400e
	dw PeachSpriteFrame01 ; $4010
	dw PeachSpriteFrame02 ; $4012
	dw PeachSpriteFrame03 ; $4014
	dw PeachSpriteFrame04 ; $4016
	dw PeachSpriteFrame05 ; $4018
	dw PeachSpriteFrame06 ; $401a
	dw PeachSpriteFrame07 ; $401c
	dw PeachSpriteFrame08 ; $401e
	dw PeachSpriteFrame09 ; $4020
	dw PeachSpriteFrame10 ; $4022
	dw PeachSpriteFrame01 ; $4024
	dw PeachSpriteFrame02 ; $4026
	dw PeachSpriteFrame03 ; $4028
	dw PeachSpriteFrame11 ; $402a
	dw PeachSpriteFrame12 ; $402c
	dw PeachSpriteFrame01 ; $402e
	dw PeachSpriteFrame02 ; $4030
	dw PeachSpriteFrame03 ; $4032
	dw PeachSpriteFrame13 ; $4034
	dw PeachSpriteFrame14 ; $4036
	dw PeachSpriteFrame06 ; $4038
	dw PeachSpriteFrame07 ; $403a
	dw PeachSpriteFrame08 ; $403c
	dw PeachSpriteFrame15 ; $403e
	dw PeachSpriteFrame16 ; $4040
	dw PeachSpriteFrame16 ; $4042
	dw PeachSpriteFrame16 ; $4044
	dw PeachSpriteFrame17 ; $4046
	dw PeachSpriteFrame17 ; $4048
	dw PeachSpriteFrame18 ; $404a
	dw PeachSpriteFrame18 ; $404c
	dw PeachSpriteFrame18 ; $404e
	dw PeachSpriteFrame19 ; $4050
	dw PeachSpriteFrame19 ; $4052
	dw PeachSpriteFrame20 ; $4054
	dw PeachSpriteFrame20 ; $4056
	dw PeachSpriteFrame20 ; $4058
	dw PeachSpriteFrame21 ; $405a
	dw PeachSpriteFrame21 ; $405c
	dw PeachSpriteFrame22 ; $405e
	dw PeachSpriteFrame22 ; $4060
	dw PeachSpriteFrame22 ; $4062
	dw PeachSpriteFrame23 ; $4064
	dw PeachSpriteFrame23 ; $4066
	dw PeachSpriteFrame24 ; $4068
	dw PeachSpriteFrame24 ; $406a
	dw PeachSpriteFrame24 ; $406c
	dw PeachSpriteFrame25 ; $406e
	dw PeachSpriteFrame25 ; $4070
	dw PeachSpriteFrame26 ; $4072
	dw PeachSpriteFrame26 ; $4074
	dw PeachSpriteFrame26 ; $4076
	dw PeachSpriteFrame27 ; $4078
	dw PeachSpriteFrame27 ; $407a
	dw PeachSpriteFrame28 ; $407c
	dw PeachSpriteFrame28 ; $407e
	dw PeachSpriteFrame28 ; $4080
	dw PeachSpriteFrame29 ; $4082
	dw PeachSpriteFrame29 ; $4084
	dw PeachSpriteFrame30 ; $4086
	dw PeachSpriteFrame30 ; $4088
	dw PeachSpriteFrame30 ; $408a
	dw PeachSpriteFrame31 ; $408c
	dw PeachSpriteFrame31 ; $408e
	dw PeachSpriteFrame32 ; $4090
	dw PeachSpriteFrame32 ; $4092
	dw PeachSpriteFrame32 ; $4094
	dw PeachSpriteFrame33 ; $4096
	dw PeachSpriteFrame33 ; $4098
	dw PeachSpriteFrame34 ; $409a
	dw PeachSpriteFrame34 ; $409c
	dw PeachSpriteFrame34 ; $409e
	dw PeachSpriteFrame35 ; $40a0
	dw PeachSpriteFrame35 ; $40a2
	dw PeachSpriteFrame36 ; $40a4
	dw PeachSpriteFrame36 ; $40a6
	dw PeachSpriteFrame36 ; $40a8
	dw PeachSpriteFrame37 ; $40aa
	dw PeachSpriteFrame37 ; $40ac
	dw PeachSpriteFrame38 ; $40ae
	dw PeachSpriteFrame38 ; $40b0
	dw PeachSpriteFrame38 ; $40b2
	dw PeachSpriteFrame39 ; $40b4
	dw PeachSpriteFrame39 ; $40b6
	dw PeachSpriteFrame40 ; $40b8
	dw PeachSpriteFrame40 ; $40ba
	dw PeachSpriteFrame40 ; $40bc
	dw PeachSpriteFrame41 ; $40be
	dw PeachSpriteFrame41 ; $40c0
	dw PeachSpriteFrame42 ; $40c2
	dw PeachSpriteFrame42 ; $40c4
	dw PeachSpriteFrame42 ; $40c6
	dw PeachSpriteFrame42 ; $40c8
	dw PeachSpriteFrame42 ; $40ca
	dw PeachSpriteFrame43 ; $40cc
	dw PeachSpriteFrame43 ; $40ce
	dw PeachSpriteFrame43 ; $40d0
	dw PeachSpriteFrame43 ; $40d2
	dw PeachSpriteFrame43 ; $40d4
	dw PeachSpriteFrame44 ; $40d6
	dw PeachSpriteFrame44 ; $40d8
	dw PeachSpriteFrame44 ; $40da
	dw PeachSpriteFrame45 ; $40dc
	dw PeachSpriteFrame45 ; $40de
	dw PeachSpriteFrame46 ; $40e0
	dw PeachSpriteFrame46 ; $40e2
	dw PeachSpriteFrame46 ; $40e4
	dw PeachSpriteFrame47 ; $40e6
	dw PeachSpriteFrame47 ; $40e8
	dw PeachSpriteFrame48 ; $40ea
	dw PeachSpriteFrame48 ; $40ec
	dw PeachSpriteFrame48 ; $40ee
	dw PeachSpriteFrame49 ; $40f0
	dw PeachSpriteFrame49 ; $40f2
	dw PeachSpriteFrame50 ; $40f4
	dw PeachSpriteFrame50 ; $40f6
	dw PeachSpriteFrame50 ; $40f8
	dw PeachSpriteFrame50 ; $40fa
	dw PeachSpriteFrame50 ; $40fc
	dw PeachSpriteFrame51 ; $40fe
	dw PeachSpriteFrame51 ; $4100
	dw PeachSpriteFrame51 ; $4102
	dw PeachSpriteFrame51 ; $4104
	dw PeachSpriteFrame51 ; $4106
	dw PeachSpriteFrame52 ; $4108
	dw PeachSpriteFrame52 ; $410a
	dw PeachSpriteFrame52 ; $410c
	dw PeachSpriteFrame52 ; $410e
	dw PeachSpriteFrame52 ; $4110
	dw PeachSpriteFrame53 ; $4112
	dw PeachSpriteFrame53 ; $4114
	dw PeachSpriteFrame53 ; $4116
	dw PeachSpriteFrame53 ; $4118
	dw PeachSpriteFrame53 ; $411a
	dw PeachSpriteFrame54 ; $411c
	dw PeachSpriteFrame54 ; $411e
	dw PeachSpriteFrame54 ; $4120
	dw PeachSpriteFrame54 ; $4122
	dw PeachSpriteFrame54 ; $4124
	dw PeachSpriteFrame55 ; $4126
	dw PeachSpriteFrame55 ; $4128
	dw PeachSpriteFrame55 ; $412a
	dw PeachSpriteFrame55 ; $412c
	dw PeachSpriteFrame55 ; $412e
PeachSpriteFrame00:
	INCBIN "data/bank_054/d_4130.bin" ; $4130, 240 bytes
PeachSpriteFrame01:
	INCBIN "data/bank_054/d_4220.bin" ; $4220, 240 bytes
PeachSpriteFrame02:
	INCBIN "data/bank_054/d_4310.bin" ; $4310, 240 bytes
PeachSpriteFrame03:
	INCBIN "data/bank_054/d_4400.bin" ; $4400, 240 bytes
PeachSpriteFrame04:
	INCBIN "data/bank_054/d_44f0.bin" ; $44f0, 240 bytes
PeachSpriteFrame05:
	INCBIN "data/bank_054/d_45e0.bin" ; $45e0, 240 bytes
PeachSpriteFrame06:
	INCBIN "data/bank_054/d_46d0.bin" ; $46d0, 240 bytes
PeachSpriteFrame07:
	INCBIN "data/bank_054/d_47c0.bin" ; $47c0, 240 bytes
PeachSpriteFrame08:
	INCBIN "data/bank_054/d_48b0.bin" ; $48b0, 240 bytes
PeachSpriteFrame09:
	INCBIN "data/bank_054/d_49a0.bin" ; $49a0, 240 bytes
PeachSpriteFrame10:
	INCBIN "data/bank_054/d_4a90.bin" ; $4a90, 240 bytes
PeachSpriteFrame11:
	INCBIN "data/bank_054/d_4b80.bin" ; $4b80, 240 bytes
PeachSpriteFrame12:
	INCBIN "data/bank_054/d_4c70.bin" ; $4c70, 240 bytes
PeachSpriteFrame13:
	INCBIN "data/bank_054/d_4d60.bin" ; $4d60, 240 bytes
PeachSpriteFrame14:
	INCBIN "data/bank_054/d_4e50.bin" ; $4e50, 240 bytes
PeachSpriteFrame15:
	INCBIN "data/bank_054/d_4f40.bin" ; $4f40, 240 bytes
PeachSpriteFrame16:
	INCBIN "data/bank_054/d_5030.bin" ; $5030, 240 bytes
PeachSpriteFrame17:
	INCBIN "data/bank_054/d_5120.bin" ; $5120, 240 bytes
PeachSpriteFrame18:
	INCBIN "data/bank_054/d_5210.bin" ; $5210, 240 bytes
PeachSpriteFrame19:
	INCBIN "data/bank_054/d_5300.bin" ; $5300, 240 bytes
PeachSpriteFrame20:
	INCBIN "data/bank_054/d_53f0.bin" ; $53f0, 240 bytes
PeachSpriteFrame21:
	INCBIN "data/bank_054/d_54e0.bin" ; $54e0, 240 bytes
PeachSpriteFrame22:
	INCBIN "data/bank_054/d_55d0.bin" ; $55d0, 240 bytes
PeachSpriteFrame23:
	INCBIN "data/bank_054/d_56c0.bin" ; $56c0, 240 bytes
PeachSpriteFrame24:
	INCBIN "data/bank_054/d_57b0.bin" ; $57b0, 240 bytes
PeachSpriteFrame25:
	INCBIN "data/bank_054/d_58a0.bin" ; $58a0, 240 bytes
PeachSpriteFrame26:
	INCBIN "data/bank_054/d_5990.bin" ; $5990, 240 bytes
PeachSpriteFrame27:
	INCBIN "data/bank_054/d_5a80.bin" ; $5a80, 240 bytes
PeachSpriteFrame28:
	INCBIN "data/bank_054/d_5b70.bin" ; $5b70, 240 bytes
PeachSpriteFrame29:
	INCBIN "data/bank_054/d_5c60.bin" ; $5c60, 240 bytes
PeachSpriteFrame30:
	INCBIN "data/bank_054/d_5d50.bin" ; $5d50, 240 bytes
PeachSpriteFrame31:
	INCBIN "data/bank_054/d_5e40.bin" ; $5e40, 240 bytes
PeachSpriteFrame32:
	INCBIN "data/bank_054/d_5f30.bin" ; $5f30, 240 bytes
PeachSpriteFrame33:
	INCBIN "data/bank_054/d_6020.bin" ; $6020, 240 bytes
PeachSpriteFrame34:
	INCBIN "data/bank_054/d_6110.bin" ; $6110, 240 bytes
PeachSpriteFrame35:
	INCBIN "data/bank_054/d_6200.bin" ; $6200, 240 bytes
PeachSpriteFrame36:
	INCBIN "data/bank_054/d_62f0.bin" ; $62f0, 240 bytes
PeachSpriteFrame37:
	INCBIN "data/bank_054/d_63e0.bin" ; $63e0, 240 bytes
PeachSpriteFrame38:
	INCBIN "data/bank_054/d_64d0.bin" ; $64d0, 240 bytes
PeachSpriteFrame39:
	INCBIN "data/bank_054/d_65c0.bin" ; $65c0, 240 bytes
PeachSpriteFrame40:
	INCBIN "data/bank_054/d_66b0.bin" ; $66b0, 320 bytes
PeachSpriteFrame41:
	INCBIN "data/bank_054/d_67f0.bin" ; $67f0, 320 bytes
PeachSpriteFrame42:
	INCBIN "data/bank_054/d_6930.bin" ; $6930, 240 bytes
PeachSpriteFrame43:
	INCBIN "data/bank_054/d_6a20.bin" ; $6a20, 240 bytes
PeachSpriteFrame44:
	INCBIN "data/bank_054/d_6b10.bin" ; $6b10, 240 bytes
PeachSpriteFrame45:
	INCBIN "data/bank_054/d_6c00.bin" ; $6c00, 240 bytes
PeachSpriteFrame46:
	INCBIN "data/bank_054/d_6cf0.bin" ; $6cf0, 240 bytes
PeachSpriteFrame47:
	INCBIN "data/bank_054/d_6de0.bin" ; $6de0, 240 bytes
PeachSpriteFrame48:
	INCBIN "data/bank_054/d_6ed0.bin" ; $6ed0, 240 bytes
PeachSpriteFrame49:
	INCBIN "data/bank_054/d_6fc0.bin" ; $6fc0, 240 bytes
PeachSpriteFrame50:
	INCBIN "data/bank_054/d_70b0.bin" ; $70b0, 240 bytes
PeachSpriteFrame51:
	INCBIN "data/bank_054/d_71a0.bin" ; $71a0, 240 bytes
PeachSpriteFrame52:
	INCBIN "data/bank_054/d_7290.bin" ; $7290, 240 bytes
PeachSpriteFrame53:
	INCBIN "data/bank_054/d_7380.bin" ; $7380, 240 bytes
PeachSpriteFrame54:
	INCBIN "data/bank_054/d_7470.bin" ; $7470, 240 bytes
PeachSpriteFrame55:
	INCBIN "data/bank_054/d_7560.bin" ; $7560, 240 bytes
PeachSpriteFramesUnused:
	INCBIN "data/bank_054/d_7650.bin" ; $7650, 1680 bytes
PeachSpriteOam:
	INCBIN "data/bank_054/d_7ce0.bin" ; $7ce0, 580 bytes
PeachSpriteAnims:
	dw PeachSpriteAnim00 ; $7f24
	dw PeachSpriteAnim01 ; $7f26
	dw PeachSpriteAnim02 ; $7f28
	dw PeachSpriteAnim03 ; $7f2a
	dw PeachSpriteAnim04 ; $7f2c
	dw PeachSpriteAnim05 ; $7f2e
	dw PeachSpriteAnim06 ; $7f30
	dw PeachSpriteAnim07 ; $7f32
	dw PeachSpriteAnim08 ; $7f34
	dw PeachSpriteAnim09 ; $7f36
	dw PeachSpriteAnim10 ; $7f38
	dw PeachSpriteAnim11 ; $7f3a
	dw PeachSpriteAnim12 ; $7f3c
	dw PeachSpriteAnim13 ; $7f3e
	dw PeachSpriteAnim14 ; $7f40
	dw PeachSpriteAnim15 ; $7f42
	dw PeachSpriteAnim16 ; $7f44
	dw PeachSpriteAnim17 ; $7f46
	dw PeachSpriteAnim18 ; $7f48
PeachSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
PeachSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
PeachSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
PeachSpriteAnim03:
	; $7f5d, 38 bytes (sprite_anim)
	anim_flip $20
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_flip $00
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_loop $00
PeachSpriteAnim04:
	; $7f83, 18 bytes (sprite_anim)
	anim_frame $1a, $14
	anim_frame $1b, $14
	anim_flip $20
	anim_frame $1c, $0a
	anim_frame $1b, $0a
	anim_flip $00
	anim_frame $1c, $0a
	anim_frame $1b, $0a
	anim_loop $04
PeachSpriteAnim05:
	; $7f95, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
PeachSpriteAnim06:
	; $7f9b, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
PeachSpriteAnim07:
	; $7fa1, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
PeachSpriteAnim08:
	; $7fa7, 5 bytes (sprite_anim)
	anim_frame $15, $04
	anim_frame $16, $14
	anim_hold $fd
PeachSpriteAnim09:
	; $7fac, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
PeachSpriteAnim10:
	; $7fb0, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
PeachSpriteAnim11:
	; $7fb4, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
PeachSpriteAnim12:
	; $7fb8, 3 bytes (sprite_anim)
	anim_frame $15, $18
	anim_hold $fd
PeachSpriteAnim13:
	; $7fbb, 3 bytes (sprite_anim)
	anim_frame $05, $ff
	anim_hold $fd
PeachSpriteAnim14:
	; $7fbe, 3 bytes (sprite_anim)
	anim_frame $08, $ff
	anim_hold $fd
PeachSpriteAnim15:
	; $7fc1, 3 bytes (sprite_anim)
	anim_frame $0b, $ff
	anim_hold $fd
PeachSpriteAnim16:
	; $7fc4, 3 bytes (sprite_anim)
	anim_frame $0e, $ff
	anim_hold $fd
PeachSpriteAnim17:
	; $7fc7, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
PeachSpriteAnim18:
	; $7fd3, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fdb, 37 bytes fill to bank end (linker-padded)
