SECTION "ROM Bank $5a", ROMX[$4000], BANK[$5a]

	dw BallMachineSpriteDesc ; $4000
BallMachineSpriteDesc:
	dw $0005 ; $4002
	dw $0003 ; $4004
	dw BallMachineSpriteFrames ; $4006 frame table
	dw BallMachineSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw BallMachineSpriteOam ; $400c per-slot OAM data
BallMachineSpriteFrames:
	dw BallMachineSpriteFrame00 ; $400e
	dw BallMachineSpriteFrame01 ; $4010
	dw BallMachineSpriteFrame02 ; $4012
	dw BallMachineSpriteFrame03 ; $4014
	dw BallMachineSpriteFrame04 ; $4016
	dw BallMachineSpriteFrame05 ; $4018
	dw BallMachineSpriteFrame06 ; $401a
	dw BallMachineSpriteFrame07 ; $401c
	dw BallMachineSpriteFrame08 ; $401e
	dw BallMachineSpriteFrame09 ; $4020
	dw BallMachineSpriteFrame10 ; $4022
	dw BallMachineSpriteFrame01 ; $4024
	dw BallMachineSpriteFrame02 ; $4026
	dw BallMachineSpriteFrame03 ; $4028
	dw BallMachineSpriteFrame11 ; $402a
	dw BallMachineSpriteFrame12 ; $402c
	dw BallMachineSpriteFrame01 ; $402e
	dw BallMachineSpriteFrame02 ; $4030
	dw BallMachineSpriteFrame03 ; $4032
	dw BallMachineSpriteFrame13 ; $4034
	dw BallMachineSpriteFrame14 ; $4036
	dw BallMachineSpriteFrame06 ; $4038
	dw BallMachineSpriteFrame07 ; $403a
	dw BallMachineSpriteFrame08 ; $403c
	dw BallMachineSpriteFrame15 ; $403e
	dw BallMachineSpriteFrame16 ; $4040
	dw BallMachineSpriteFrame16 ; $4042
	dw BallMachineSpriteFrame16 ; $4044
	dw BallMachineSpriteFrame17 ; $4046
	dw BallMachineSpriteFrame17 ; $4048
	dw BallMachineSpriteFrame18 ; $404a
	dw BallMachineSpriteFrame18 ; $404c
	dw BallMachineSpriteFrame18 ; $404e
	dw BallMachineSpriteFrame19 ; $4050
	dw BallMachineSpriteFrame19 ; $4052
	dw BallMachineSpriteFrame20 ; $4054
	dw BallMachineSpriteFrame20 ; $4056
	dw BallMachineSpriteFrame20 ; $4058
	dw BallMachineSpriteFrame21 ; $405a
	dw BallMachineSpriteFrame21 ; $405c
	dw BallMachineSpriteFrame22 ; $405e
	dw BallMachineSpriteFrame22 ; $4060
	dw BallMachineSpriteFrame22 ; $4062
	dw BallMachineSpriteFrame23 ; $4064
	dw BallMachineSpriteFrame23 ; $4066
	dw BallMachineSpriteFrame24 ; $4068
	dw BallMachineSpriteFrame24 ; $406a
	dw BallMachineSpriteFrame24 ; $406c
	dw BallMachineSpriteFrame25 ; $406e
	dw BallMachineSpriteFrame25 ; $4070
	dw BallMachineSpriteFrame26 ; $4072
	dw BallMachineSpriteFrame26 ; $4074
	dw BallMachineSpriteFrame26 ; $4076
	dw BallMachineSpriteFrame27 ; $4078
	dw BallMachineSpriteFrame27 ; $407a
	dw BallMachineSpriteFrame28 ; $407c
	dw BallMachineSpriteFrame28 ; $407e
	dw BallMachineSpriteFrame28 ; $4080
	dw BallMachineSpriteFrame29 ; $4082
	dw BallMachineSpriteFrame29 ; $4084
	dw BallMachineSpriteFrame30 ; $4086
	dw BallMachineSpriteFrame30 ; $4088
	dw BallMachineSpriteFrame30 ; $408a
	dw BallMachineSpriteFrame31 ; $408c
	dw BallMachineSpriteFrame31 ; $408e
	dw BallMachineSpriteFrame32 ; $4090
	dw BallMachineSpriteFrame32 ; $4092
	dw BallMachineSpriteFrame32 ; $4094
	dw BallMachineSpriteFrame33 ; $4096
	dw BallMachineSpriteFrame33 ; $4098
	dw BallMachineSpriteFrame34 ; $409a
	dw BallMachineSpriteFrame34 ; $409c
	dw BallMachineSpriteFrame34 ; $409e
	dw BallMachineSpriteFrame35 ; $40a0
	dw BallMachineSpriteFrame35 ; $40a2
	dw BallMachineSpriteFrame36 ; $40a4
	dw BallMachineSpriteFrame36 ; $40a6
	dw BallMachineSpriteFrame36 ; $40a8
	dw BallMachineSpriteFrame37 ; $40aa
	dw BallMachineSpriteFrame37 ; $40ac
	dw BallMachineSpriteFrame38 ; $40ae
	dw BallMachineSpriteFrame38 ; $40b0
	dw BallMachineSpriteFrame38 ; $40b2
	dw BallMachineSpriteFrame39 ; $40b4
	dw BallMachineSpriteFrame39 ; $40b6
	dw BallMachineSpriteFrame40 ; $40b8
	dw BallMachineSpriteFrame40 ; $40ba
	dw BallMachineSpriteFrame40 ; $40bc
	dw BallMachineSpriteFrame41 ; $40be
	dw BallMachineSpriteFrame41 ; $40c0
	dw BallMachineSpriteFrame42 ; $40c2
	dw BallMachineSpriteFrame42 ; $40c4
	dw BallMachineSpriteFrame42 ; $40c6
	dw BallMachineSpriteFrame42 ; $40c8
	dw BallMachineSpriteFrame42 ; $40ca
	dw BallMachineSpriteFrame43 ; $40cc
	dw BallMachineSpriteFrame43 ; $40ce
	dw BallMachineSpriteFrame43 ; $40d0
	dw BallMachineSpriteFrame43 ; $40d2
	dw BallMachineSpriteFrame43 ; $40d4
	dw BallMachineSpriteFrame44 ; $40d6
	dw BallMachineSpriteFrame44 ; $40d8
	dw BallMachineSpriteFrame44 ; $40da
	dw BallMachineSpriteFrame45 ; $40dc
	dw BallMachineSpriteFrame45 ; $40de
	dw BallMachineSpriteFrame46 ; $40e0
	dw BallMachineSpriteFrame46 ; $40e2
	dw BallMachineSpriteFrame46 ; $40e4
	dw BallMachineSpriteFrame47 ; $40e6
	dw BallMachineSpriteFrame47 ; $40e8
	dw BallMachineSpriteFrame48 ; $40ea
	dw BallMachineSpriteFrame48 ; $40ec
	dw BallMachineSpriteFrame48 ; $40ee
	dw BallMachineSpriteFrame49 ; $40f0
	dw BallMachineSpriteFrame49 ; $40f2
	dw BallMachineSpriteFrame50 ; $40f4
	dw BallMachineSpriteFrame50 ; $40f6
	dw BallMachineSpriteFrame50 ; $40f8
	dw BallMachineSpriteFrame50 ; $40fa
	dw BallMachineSpriteFrame50 ; $40fc
	dw BallMachineSpriteFrame51 ; $40fe
	dw BallMachineSpriteFrame51 ; $4100
	dw BallMachineSpriteFrame51 ; $4102
	dw BallMachineSpriteFrame51 ; $4104
	dw BallMachineSpriteFrame51 ; $4106
	dw BallMachineSpriteFrame52 ; $4108
	dw BallMachineSpriteFrame52 ; $410a
	dw BallMachineSpriteFrame52 ; $410c
	dw BallMachineSpriteFrame52 ; $410e
	dw BallMachineSpriteFrame52 ; $4110
	dw BallMachineSpriteFrame53 ; $4112
	dw BallMachineSpriteFrame53 ; $4114
	dw BallMachineSpriteFrame53 ; $4116
	dw BallMachineSpriteFrame53 ; $4118
	dw BallMachineSpriteFrame53 ; $411a
	dw BallMachineSpriteFrame54 ; $411c
	dw BallMachineSpriteFrame54 ; $411e
	dw BallMachineSpriteFrame54 ; $4120
	dw BallMachineSpriteFrame54 ; $4122
	dw BallMachineSpriteFrame54 ; $4124
	dw BallMachineSpriteFrame55 ; $4126
	dw BallMachineSpriteFrame55 ; $4128
	dw BallMachineSpriteFrame55 ; $412a
	dw BallMachineSpriteFrame55 ; $412c
	dw BallMachineSpriteFrame55 ; $412e
BallMachineSpriteFrame00:
	INCBIN "data/bank_05a/d_4130.bin" ; $4130, 240 bytes
BallMachineSpriteFrame01:
	INCBIN "data/bank_05a/d_4220.bin" ; $4220, 240 bytes
BallMachineSpriteFrame02:
	INCBIN "data/bank_05a/d_4310.bin" ; $4310, 240 bytes
BallMachineSpriteFrame03:
	INCBIN "data/bank_05a/d_4400.bin" ; $4400, 240 bytes
BallMachineSpriteFrame04:
	INCBIN "data/bank_05a/d_44f0.bin" ; $44f0, 240 bytes
BallMachineSpriteFrame05:
	INCBIN "data/bank_05a/d_45e0.bin" ; $45e0, 240 bytes
BallMachineSpriteFrame06:
	INCBIN "data/bank_05a/d_46d0.bin" ; $46d0, 240 bytes
BallMachineSpriteFrame07:
	INCBIN "data/bank_05a/d_47c0.bin" ; $47c0, 240 bytes
BallMachineSpriteFrame08:
	INCBIN "data/bank_05a/d_48b0.bin" ; $48b0, 240 bytes
BallMachineSpriteFrame09:
	INCBIN "data/bank_05a/d_49a0.bin" ; $49a0, 240 bytes
BallMachineSpriteFrame10:
	INCBIN "data/bank_05a/d_4a90.bin" ; $4a90, 240 bytes
BallMachineSpriteFrame11:
	INCBIN "data/bank_05a/d_4b80.bin" ; $4b80, 240 bytes
BallMachineSpriteFrame12:
	INCBIN "data/bank_05a/d_4c70.bin" ; $4c70, 240 bytes
BallMachineSpriteFrame13:
	INCBIN "data/bank_05a/d_4d60.bin" ; $4d60, 240 bytes
BallMachineSpriteFrame14:
	INCBIN "data/bank_05a/d_4e50.bin" ; $4e50, 240 bytes
BallMachineSpriteFrame15:
	INCBIN "data/bank_05a/d_4f40.bin" ; $4f40, 240 bytes
BallMachineSpriteFrame16:
	INCBIN "data/bank_05a/d_5030.bin" ; $5030, 240 bytes
BallMachineSpriteFrame17:
	INCBIN "data/bank_05a/d_5120.bin" ; $5120, 240 bytes
BallMachineSpriteFrame18:
	INCBIN "data/bank_05a/d_5210.bin" ; $5210, 240 bytes
BallMachineSpriteFrame19:
	INCBIN "data/bank_05a/d_5300.bin" ; $5300, 240 bytes
BallMachineSpriteFrame20:
	INCBIN "data/bank_05a/d_53f0.bin" ; $53f0, 240 bytes
BallMachineSpriteFrame21:
	INCBIN "data/bank_05a/d_54e0.bin" ; $54e0, 240 bytes
BallMachineSpriteFrame22:
	INCBIN "data/bank_05a/d_55d0.bin" ; $55d0, 240 bytes
BallMachineSpriteFrame23:
	INCBIN "data/bank_05a/d_56c0.bin" ; $56c0, 240 bytes
BallMachineSpriteFrame24:
	INCBIN "data/bank_05a/d_57b0.bin" ; $57b0, 240 bytes
BallMachineSpriteFrame25:
	INCBIN "data/bank_05a/d_58a0.bin" ; $58a0, 240 bytes
BallMachineSpriteFrame26:
	INCBIN "data/bank_05a/d_5990.bin" ; $5990, 240 bytes
BallMachineSpriteFrame27:
	INCBIN "data/bank_05a/d_5a80.bin" ; $5a80, 240 bytes
BallMachineSpriteFrame28:
	INCBIN "data/bank_05a/d_5b70.bin" ; $5b70, 240 bytes
BallMachineSpriteFrame29:
	INCBIN "data/bank_05a/d_5c60.bin" ; $5c60, 240 bytes
BallMachineSpriteFrame30:
	INCBIN "data/bank_05a/d_5d50.bin" ; $5d50, 240 bytes
BallMachineSpriteFrame31:
	INCBIN "data/bank_05a/d_5e40.bin" ; $5e40, 240 bytes
BallMachineSpriteFrame32:
	INCBIN "data/bank_05a/d_5f30.bin" ; $5f30, 240 bytes
BallMachineSpriteFrame33:
	INCBIN "data/bank_05a/d_6020.bin" ; $6020, 240 bytes
BallMachineSpriteFrame34:
	INCBIN "data/bank_05a/d_6110.bin" ; $6110, 240 bytes
BallMachineSpriteFrame35:
	INCBIN "data/bank_05a/d_6200.bin" ; $6200, 240 bytes
BallMachineSpriteFrame36:
	INCBIN "data/bank_05a/d_62f0.bin" ; $62f0, 240 bytes
BallMachineSpriteFrame37:
	INCBIN "data/bank_05a/d_63e0.bin" ; $63e0, 240 bytes
BallMachineSpriteFrame38:
	INCBIN "data/bank_05a/d_64d0.bin" ; $64d0, 240 bytes
BallMachineSpriteFrame39:
	INCBIN "data/bank_05a/d_65c0.bin" ; $65c0, 240 bytes
BallMachineSpriteFrame40:
	INCBIN "data/bank_05a/d_66b0.bin" ; $66b0, 320 bytes
BallMachineSpriteFrame41:
	INCBIN "data/bank_05a/d_67f0.bin" ; $67f0, 320 bytes
BallMachineSpriteFrame42:
	INCBIN "data/bank_05a/d_6930.bin" ; $6930, 240 bytes
BallMachineSpriteFrame43:
	INCBIN "data/bank_05a/d_6a20.bin" ; $6a20, 240 bytes
BallMachineSpriteFrame44:
	INCBIN "data/bank_05a/d_6b10.bin" ; $6b10, 240 bytes
BallMachineSpriteFrame45:
	INCBIN "data/bank_05a/d_6c00.bin" ; $6c00, 240 bytes
BallMachineSpriteFrame46:
	INCBIN "data/bank_05a/d_6cf0.bin" ; $6cf0, 240 bytes
BallMachineSpriteFrame47:
	INCBIN "data/bank_05a/d_6de0.bin" ; $6de0, 240 bytes
BallMachineSpriteFrame48:
	INCBIN "data/bank_05a/d_6ed0.bin" ; $6ed0, 240 bytes
BallMachineSpriteFrame49:
	INCBIN "data/bank_05a/d_6fc0.bin" ; $6fc0, 240 bytes
BallMachineSpriteFrame50:
	INCBIN "data/bank_05a/d_70b0.bin" ; $70b0, 240 bytes
BallMachineSpriteFrame51:
	INCBIN "data/bank_05a/d_71a0.bin" ; $71a0, 240 bytes
BallMachineSpriteFrame52:
	INCBIN "data/bank_05a/d_7290.bin" ; $7290, 240 bytes
BallMachineSpriteFrame53:
	INCBIN "data/bank_05a/d_7380.bin" ; $7380, 240 bytes
BallMachineSpriteFrame54:
	INCBIN "data/bank_05a/d_7470.bin" ; $7470, 240 bytes
BallMachineSpriteFrame55:
	INCBIN "data/bank_05a/d_7560.bin" ; $7560, 240 bytes
BallMachineSpriteFramesUnused:
	INCBIN "data/bank_05a/d_7650.bin" ; $7650, 1680 bytes
BallMachineSpriteOam:
	INCBIN "data/bank_05a/d_7ce0.bin" ; $7ce0, 580 bytes
BallMachineSpriteAnims:
	dw BallMachineSpriteAnim00 ; $7f24
	dw BallMachineSpriteAnim01 ; $7f26
	dw BallMachineSpriteAnim02 ; $7f28
	dw BallMachineSpriteAnim03 ; $7f2a
	dw BallMachineSpriteAnim04 ; $7f2c
	dw BallMachineSpriteAnim05 ; $7f2e
	dw BallMachineSpriteAnim06 ; $7f30
	dw BallMachineSpriteAnim07 ; $7f32
	dw BallMachineSpriteAnim08 ; $7f34
	dw BallMachineSpriteAnim09 ; $7f36
	dw BallMachineSpriteAnim10 ; $7f38
	dw BallMachineSpriteAnim11 ; $7f3a
	dw BallMachineSpriteAnim12 ; $7f3c
	dw BallMachineSpriteAnim13 ; $7f3e
	dw BallMachineSpriteAnim14 ; $7f40
	dw BallMachineSpriteAnim15 ; $7f42
	dw BallMachineSpriteAnim16 ; $7f44
	dw BallMachineSpriteAnim17 ; $7f46
	dw BallMachineSpriteAnim18 ; $7f48
BallMachineSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
BallMachineSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $05
	anim_frame $03, $05
	anim_frame $04, $05
	anim_frame $03, $05
	anim_loop $00
BallMachineSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
BallMachineSpriteAnim03:
	; $7f5d, 2 bytes (sprite_anim)
	anim_set $01
BallMachineSpriteAnim04:
	; $7f5f, 2 bytes (sprite_anim)
	anim_set $01
BallMachineSpriteAnim05:
	; $7f61, 8 bytes (sprite_anim)
	anim_frame $05, $0a
	anim_frame $06, $05
	anim_frame $07, $0f
	anim_set $01
BallMachineSpriteAnim06:
	; $7f69, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
BallMachineSpriteAnim07:
	; $7f6f, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
BallMachineSpriteAnim08:
	; $7f75, 5 bytes (sprite_anim)
	anim_frame $15, $04
	anim_frame $16, $14
	anim_hold $fd
BallMachineSpriteAnim09:
	; $7f7a, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
BallMachineSpriteAnim10:
	; $7f7e, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
BallMachineSpriteAnim11:
	; $7f82, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
BallMachineSpriteAnim12:
	; $7f86, 3 bytes (sprite_anim)
	anim_frame $15, $18
	anim_hold $fd
BallMachineSpriteAnim13:
	; $7f89, 3 bytes (sprite_anim)
	anim_frame $05, $ff
	anim_hold $fd
BallMachineSpriteAnim14:
	; $7f8c, 3 bytes (sprite_anim)
	anim_frame $08, $ff
	anim_hold $fd
BallMachineSpriteAnim15:
	; $7f8f, 3 bytes (sprite_anim)
	anim_frame $0b, $ff
	anim_hold $fd
BallMachineSpriteAnim16:
	; $7f92, 3 bytes (sprite_anim)
	anim_frame $0e, $ff
	anim_hold $fd
BallMachineSpriteAnim17:
	; $7f95, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
BallMachineSpriteAnim18:
	; $7fa1, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fa9, 87 bytes fill to bank end (linker-padded)
