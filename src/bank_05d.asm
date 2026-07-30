SECTION "ROM Bank $5d", ROMX[$4000], BANK[$5d]

	dw BabyMarioSpriteDesc ; $4000
BabyMarioSpriteDesc:
	dw $0006 ; $4002
	dw $0003 ; $4004
	dw BabyMarioSpriteFrames ; $4006 frame table
	dw BabyMarioSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw BabyMarioSpriteOam ; $400c per-slot OAM data
BabyMarioSpriteFrames:
	dw BabyMarioSpriteFrame00 ; $400e
	dw BabyMarioSpriteFrame01 ; $4010
	dw BabyMarioSpriteFrame02 ; $4012
	dw BabyMarioSpriteFrame03 ; $4014
	dw BabyMarioSpriteFrame04 ; $4016
	dw BabyMarioSpriteFrame05 ; $4018
	dw BabyMarioSpriteFrame06 ; $401a
	dw BabyMarioSpriteFrame07 ; $401c
	dw BabyMarioSpriteFrame08 ; $401e
	dw BabyMarioSpriteFrame09 ; $4020
	dw BabyMarioSpriteFrame10 ; $4022
	dw BabyMarioSpriteFrame01 ; $4024
	dw BabyMarioSpriteFrame02 ; $4026
	dw BabyMarioSpriteFrame03 ; $4028
	dw BabyMarioSpriteFrame11 ; $402a
	dw BabyMarioSpriteFrame12 ; $402c
	dw BabyMarioSpriteFrame01 ; $402e
	dw BabyMarioSpriteFrame02 ; $4030
	dw BabyMarioSpriteFrame03 ; $4032
	dw BabyMarioSpriteFrame13 ; $4034
	dw BabyMarioSpriteFrame14 ; $4036
	dw BabyMarioSpriteFrame06 ; $4038
	dw BabyMarioSpriteFrame07 ; $403a
	dw BabyMarioSpriteFrame08 ; $403c
	dw BabyMarioSpriteFrame15 ; $403e
	dw BabyMarioSpriteFrame16 ; $4040
	dw BabyMarioSpriteFrame16 ; $4042
	dw BabyMarioSpriteFrame16 ; $4044
	dw BabyMarioSpriteFrame17 ; $4046
	dw BabyMarioSpriteFrame17 ; $4048
	dw BabyMarioSpriteFrame18 ; $404a
	dw BabyMarioSpriteFrame18 ; $404c
	dw BabyMarioSpriteFrame18 ; $404e
	dw BabyMarioSpriteFrame19 ; $4050
	dw BabyMarioSpriteFrame19 ; $4052
	dw BabyMarioSpriteFrame20 ; $4054
	dw BabyMarioSpriteFrame20 ; $4056
	dw BabyMarioSpriteFrame20 ; $4058
	dw BabyMarioSpriteFrame21 ; $405a
	dw BabyMarioSpriteFrame21 ; $405c
	dw BabyMarioSpriteFrame22 ; $405e
	dw BabyMarioSpriteFrame22 ; $4060
	dw BabyMarioSpriteFrame22 ; $4062
	dw BabyMarioSpriteFrame23 ; $4064
	dw BabyMarioSpriteFrame23 ; $4066
	dw BabyMarioSpriteFrame24 ; $4068
	dw BabyMarioSpriteFrame24 ; $406a
	dw BabyMarioSpriteFrame24 ; $406c
	dw BabyMarioSpriteFrame25 ; $406e
	dw BabyMarioSpriteFrame25 ; $4070
	dw BabyMarioSpriteFrame26 ; $4072
	dw BabyMarioSpriteFrame26 ; $4074
	dw BabyMarioSpriteFrame26 ; $4076
	dw BabyMarioSpriteFrame27 ; $4078
	dw BabyMarioSpriteFrame27 ; $407a
	dw BabyMarioSpriteFrame28 ; $407c
	dw BabyMarioSpriteFrame28 ; $407e
	dw BabyMarioSpriteFrame28 ; $4080
	dw BabyMarioSpriteFrame29 ; $4082
	dw BabyMarioSpriteFrame29 ; $4084
	dw BabyMarioSpriteFrame30 ; $4086
	dw BabyMarioSpriteFrame30 ; $4088
	dw BabyMarioSpriteFrame30 ; $408a
	dw BabyMarioSpriteFrame31 ; $408c
	dw BabyMarioSpriteFrame31 ; $408e
	dw BabyMarioSpriteFrame32 ; $4090
	dw BabyMarioSpriteFrame32 ; $4092
	dw BabyMarioSpriteFrame32 ; $4094
	dw BabyMarioSpriteFrame33 ; $4096
	dw BabyMarioSpriteFrame33 ; $4098
	dw BabyMarioSpriteFrame34 ; $409a
	dw BabyMarioSpriteFrame34 ; $409c
	dw BabyMarioSpriteFrame34 ; $409e
	dw BabyMarioSpriteFrame35 ; $40a0
	dw BabyMarioSpriteFrame35 ; $40a2
	dw BabyMarioSpriteFrame36 ; $40a4
	dw BabyMarioSpriteFrame36 ; $40a6
	dw BabyMarioSpriteFrame36 ; $40a8
	dw BabyMarioSpriteFrame37 ; $40aa
	dw BabyMarioSpriteFrame37 ; $40ac
	dw BabyMarioSpriteFrame38 ; $40ae
	dw BabyMarioSpriteFrame38 ; $40b0
	dw BabyMarioSpriteFrame38 ; $40b2
	dw BabyMarioSpriteFrame39 ; $40b4
	dw BabyMarioSpriteFrame39 ; $40b6
	dw BabyMarioSpriteFrame40 ; $40b8
	dw BabyMarioSpriteFrame40 ; $40ba
	dw BabyMarioSpriteFrame40 ; $40bc
	dw BabyMarioSpriteFrame41 ; $40be
	dw BabyMarioSpriteFrame41 ; $40c0
	dw BabyMarioSpriteFrame42 ; $40c2
	dw BabyMarioSpriteFrame42 ; $40c4
	dw BabyMarioSpriteFrame42 ; $40c6
	dw BabyMarioSpriteFrame42 ; $40c8
	dw BabyMarioSpriteFrame42 ; $40ca
	dw BabyMarioSpriteFrame43 ; $40cc
	dw BabyMarioSpriteFrame43 ; $40ce
	dw BabyMarioSpriteFrame43 ; $40d0
	dw BabyMarioSpriteFrame43 ; $40d2
	dw BabyMarioSpriteFrame43 ; $40d4
	dw BabyMarioSpriteFrame44 ; $40d6
	dw BabyMarioSpriteFrame44 ; $40d8
	dw BabyMarioSpriteFrame44 ; $40da
	dw BabyMarioSpriteFrame45 ; $40dc
	dw BabyMarioSpriteFrame45 ; $40de
	dw BabyMarioSpriteFrame46 ; $40e0
	dw BabyMarioSpriteFrame46 ; $40e2
	dw BabyMarioSpriteFrame46 ; $40e4
	dw BabyMarioSpriteFrame47 ; $40e6
	dw BabyMarioSpriteFrame47 ; $40e8
	dw BabyMarioSpriteFrame48 ; $40ea
	dw BabyMarioSpriteFrame48 ; $40ec
	dw BabyMarioSpriteFrame48 ; $40ee
	dw BabyMarioSpriteFrame49 ; $40f0
	dw BabyMarioSpriteFrame49 ; $40f2
	dw BabyMarioSpriteFrame50 ; $40f4
	dw BabyMarioSpriteFrame50 ; $40f6
	dw BabyMarioSpriteFrame50 ; $40f8
	dw BabyMarioSpriteFrame50 ; $40fa
	dw BabyMarioSpriteFrame50 ; $40fc
	dw BabyMarioSpriteFrame51 ; $40fe
	dw BabyMarioSpriteFrame51 ; $4100
	dw BabyMarioSpriteFrame51 ; $4102
	dw BabyMarioSpriteFrame51 ; $4104
	dw BabyMarioSpriteFrame51 ; $4106
	dw BabyMarioSpriteFrame52 ; $4108
	dw BabyMarioSpriteFrame52 ; $410a
	dw BabyMarioSpriteFrame52 ; $410c
	dw BabyMarioSpriteFrame52 ; $410e
	dw BabyMarioSpriteFrame52 ; $4110
	dw BabyMarioSpriteFrame53 ; $4112
	dw BabyMarioSpriteFrame53 ; $4114
	dw BabyMarioSpriteFrame53 ; $4116
	dw BabyMarioSpriteFrame53 ; $4118
	dw BabyMarioSpriteFrame53 ; $411a
	dw BabyMarioSpriteFrame54 ; $411c
	dw BabyMarioSpriteFrame54 ; $411e
	dw BabyMarioSpriteFrame54 ; $4120
	dw BabyMarioSpriteFrame54 ; $4122
	dw BabyMarioSpriteFrame54 ; $4124
	dw BabyMarioSpriteFrame55 ; $4126
	dw BabyMarioSpriteFrame55 ; $4128
	dw BabyMarioSpriteFrame55 ; $412a
	dw BabyMarioSpriteFrame55 ; $412c
	dw BabyMarioSpriteFrame55 ; $412e
BabyMarioSpriteFrame00:
	INCBIN "data/bank_05d/d_4130.bin" ; $4130, 240 bytes
BabyMarioSpriteFrame01:
	INCBIN "data/bank_05d/d_4220.bin" ; $4220, 240 bytes
BabyMarioSpriteFrame02:
	INCBIN "data/bank_05d/d_4310.bin" ; $4310, 240 bytes
BabyMarioSpriteFrame03:
	INCBIN "data/bank_05d/d_4400.bin" ; $4400, 240 bytes
BabyMarioSpriteFrame04:
	INCBIN "data/bank_05d/d_44f0.bin" ; $44f0, 240 bytes
BabyMarioSpriteFrame05:
	INCBIN "data/bank_05d/d_45e0.bin" ; $45e0, 240 bytes
BabyMarioSpriteFrame06:
	INCBIN "data/bank_05d/d_46d0.bin" ; $46d0, 240 bytes
BabyMarioSpriteFrame07:
	INCBIN "data/bank_05d/d_47c0.bin" ; $47c0, 240 bytes
BabyMarioSpriteFrame08:
	INCBIN "data/bank_05d/d_48b0.bin" ; $48b0, 240 bytes
BabyMarioSpriteFrame09:
	INCBIN "data/bank_05d/d_49a0.bin" ; $49a0, 240 bytes
BabyMarioSpriteFrame10:
	INCBIN "data/bank_05d/d_4a90.bin" ; $4a90, 240 bytes
BabyMarioSpriteFrame11:
	INCBIN "data/bank_05d/d_4b80.bin" ; $4b80, 240 bytes
BabyMarioSpriteFrame12:
	INCBIN "data/bank_05d/d_4c70.bin" ; $4c70, 240 bytes
BabyMarioSpriteFrame13:
	INCBIN "data/bank_05d/d_4d60.bin" ; $4d60, 240 bytes
BabyMarioSpriteFrame14:
	INCBIN "data/bank_05d/d_4e50.bin" ; $4e50, 240 bytes
BabyMarioSpriteFrame15:
	INCBIN "data/bank_05d/d_4f40.bin" ; $4f40, 240 bytes
BabyMarioSpriteFrame16:
	INCBIN "data/bank_05d/d_5030.bin" ; $5030, 240 bytes
BabyMarioSpriteFrame17:
	INCBIN "data/bank_05d/d_5120.bin" ; $5120, 240 bytes
BabyMarioSpriteFrame18:
	INCBIN "data/bank_05d/d_5210.bin" ; $5210, 240 bytes
BabyMarioSpriteFrame19:
	INCBIN "data/bank_05d/d_5300.bin" ; $5300, 240 bytes
BabyMarioSpriteFrame20:
	INCBIN "data/bank_05d/d_53f0.bin" ; $53f0, 240 bytes
BabyMarioSpriteFrame21:
	INCBIN "data/bank_05d/d_54e0.bin" ; $54e0, 240 bytes
BabyMarioSpriteFrame22:
	INCBIN "data/bank_05d/d_55d0.bin" ; $55d0, 240 bytes
BabyMarioSpriteFrame23:
	INCBIN "data/bank_05d/d_56c0.bin" ; $56c0, 240 bytes
BabyMarioSpriteFrame24:
	INCBIN "data/bank_05d/d_57b0.bin" ; $57b0, 240 bytes
BabyMarioSpriteFrame25:
	INCBIN "data/bank_05d/d_58a0.bin" ; $58a0, 240 bytes
BabyMarioSpriteFrame26:
	INCBIN "data/bank_05d/d_5990.bin" ; $5990, 240 bytes
BabyMarioSpriteFrame27:
	INCBIN "data/bank_05d/d_5a80.bin" ; $5a80, 240 bytes
BabyMarioSpriteFrame28:
	INCBIN "data/bank_05d/d_5b70.bin" ; $5b70, 240 bytes
BabyMarioSpriteFrame29:
	INCBIN "data/bank_05d/d_5c60.bin" ; $5c60, 240 bytes
BabyMarioSpriteFrame30:
	INCBIN "data/bank_05d/d_5d50.bin" ; $5d50, 240 bytes
BabyMarioSpriteFrame31:
	INCBIN "data/bank_05d/d_5e40.bin" ; $5e40, 240 bytes
BabyMarioSpriteFrame32:
	INCBIN "data/bank_05d/d_5f30.bin" ; $5f30, 240 bytes
BabyMarioSpriteFrame33:
	INCBIN "data/bank_05d/d_6020.bin" ; $6020, 240 bytes
BabyMarioSpriteFrame34:
	INCBIN "data/bank_05d/d_6110.bin" ; $6110, 240 bytes
BabyMarioSpriteFrame35:
	INCBIN "data/bank_05d/d_6200.bin" ; $6200, 240 bytes
BabyMarioSpriteFrame36:
	INCBIN "data/bank_05d/d_62f0.bin" ; $62f0, 240 bytes
BabyMarioSpriteFrame37:
	INCBIN "data/bank_05d/d_63e0.bin" ; $63e0, 240 bytes
BabyMarioSpriteFrame38:
	INCBIN "data/bank_05d/d_64d0.bin" ; $64d0, 240 bytes
BabyMarioSpriteFrame39:
	INCBIN "data/bank_05d/d_65c0.bin" ; $65c0, 240 bytes
BabyMarioSpriteFrame40:
	INCBIN "data/bank_05d/d_66b0.bin" ; $66b0, 320 bytes
BabyMarioSpriteFrame41:
	INCBIN "data/bank_05d/d_67f0.bin" ; $67f0, 320 bytes
BabyMarioSpriteFrame42:
	INCBIN "data/bank_05d/d_6930.bin" ; $6930, 240 bytes
BabyMarioSpriteFrame43:
	INCBIN "data/bank_05d/d_6a20.bin" ; $6a20, 240 bytes
BabyMarioSpriteFrame44:
	INCBIN "data/bank_05d/d_6b10.bin" ; $6b10, 240 bytes
BabyMarioSpriteFrame45:
	INCBIN "data/bank_05d/d_6c00.bin" ; $6c00, 240 bytes
BabyMarioSpriteFrame46:
	INCBIN "data/bank_05d/d_6cf0.bin" ; $6cf0, 240 bytes
BabyMarioSpriteFrame47:
	INCBIN "data/bank_05d/d_6de0.bin" ; $6de0, 240 bytes
BabyMarioSpriteFrame48:
	INCBIN "data/bank_05d/d_6ed0.bin" ; $6ed0, 240 bytes
BabyMarioSpriteFrame49:
	INCBIN "data/bank_05d/d_6fc0.bin" ; $6fc0, 240 bytes
BabyMarioSpriteFrame50:
	INCBIN "data/bank_05d/d_70b0.bin" ; $70b0, 240 bytes
BabyMarioSpriteFrame51:
	INCBIN "data/bank_05d/d_71a0.bin" ; $71a0, 240 bytes
BabyMarioSpriteFrame52:
	INCBIN "data/bank_05d/d_7290.bin" ; $7290, 240 bytes
BabyMarioSpriteFrame53:
	INCBIN "data/bank_05d/d_7380.bin" ; $7380, 240 bytes
BabyMarioSpriteFrame54:
	INCBIN "data/bank_05d/d_7470.bin" ; $7470, 240 bytes
BabyMarioSpriteFrame55:
	INCBIN "data/bank_05d/d_7560.bin" ; $7560, 240 bytes
BabyMarioSpriteFramesUnused:
	INCBIN "data/bank_05d/d_7650.bin" ; $7650, 1680 bytes
BabyMarioSpriteOam:
	INCBIN "data/bank_05d/d_7ce0.bin" ; $7ce0, 580 bytes
BabyMarioSpriteAnims:
	dw BabyMarioSpriteAnim00 ; $7f24
	dw BabyMarioSpriteAnim01 ; $7f26
	dw BabyMarioSpriteAnim02 ; $7f28
	dw BabyMarioSpriteAnim03 ; $7f2a
	dw BabyMarioSpriteAnim04 ; $7f2c
	dw BabyMarioSpriteAnim05 ; $7f2e
	dw BabyMarioSpriteAnim06 ; $7f30
	dw BabyMarioSpriteAnim07 ; $7f32
	dw BabyMarioSpriteAnim08 ; $7f34
	dw BabyMarioSpriteAnim09 ; $7f36
	dw BabyMarioSpriteAnim10 ; $7f38
	dw BabyMarioSpriteAnim11 ; $7f3a
	dw BabyMarioSpriteAnim12 ; $7f3c
	dw BabyMarioSpriteAnim13 ; $7f3e
	dw BabyMarioSpriteAnim14 ; $7f40
	dw BabyMarioSpriteAnim15 ; $7f42
	dw BabyMarioSpriteAnim16 ; $7f44
	dw BabyMarioSpriteAnim17 ; $7f46
	dw BabyMarioSpriteAnim18 ; $7f48
BabyMarioSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
BabyMarioSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
BabyMarioSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
BabyMarioSpriteAnim03:
	; $7f5d, 10 bytes (sprite_anim)
	anim_frame $17, $0a
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_frame $18, $0a
	anim_loop $00
BabyMarioSpriteAnim04:
	; $7f67, 8 bytes (sprite_anim)
	anim_frame $1a, $0a
	anim_frame $1b, $0a
	anim_frame $1c, $0a
	anim_loop $00
BabyMarioSpriteAnim05:
	; $7f6f, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
BabyMarioSpriteAnim06:
	; $7f75, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
BabyMarioSpriteAnim07:
	; $7f7b, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
BabyMarioSpriteAnim08:
	; $7f81, 5 bytes (sprite_anim)
	anim_frame $15, $04
	anim_frame $16, $14
	anim_hold $fd
BabyMarioSpriteAnim09:
	; $7f86, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
BabyMarioSpriteAnim10:
	; $7f8a, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
BabyMarioSpriteAnim11:
	; $7f8e, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
BabyMarioSpriteAnim12:
	; $7f92, 3 bytes (sprite_anim)
	anim_frame $15, $18
	anim_hold $fd
BabyMarioSpriteAnim13:
	; $7f95, 3 bytes (sprite_anim)
	anim_frame $05, $ff
	anim_hold $fd
BabyMarioSpriteAnim14:
	; $7f98, 3 bytes (sprite_anim)
	anim_frame $08, $ff
	anim_hold $fd
BabyMarioSpriteAnim15:
	; $7f9b, 3 bytes (sprite_anim)
	anim_frame $0b, $ff
	anim_hold $fd
BabyMarioSpriteAnim16:
	; $7f9e, 3 bytes (sprite_anim)
	anim_frame $0e, $ff
	anim_hold $fd
BabyMarioSpriteAnim17:
	; $7fa1, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
BabyMarioSpriteAnim18:
	; $7fad, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fb5, 75 bytes fill to bank end (linker-padded)
