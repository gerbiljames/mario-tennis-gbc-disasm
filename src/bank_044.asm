SECTION "ROM Bank $44", ROMX[$4000], BANK[$44]

	dw EmilySpriteDesc ; $4000
EmilySpriteDesc:
	dw $0005 ; $4002
	dw $0003 ; $4004
	dw EmilySpriteFrames ; $4006 frame table
	dw EmilySpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw Data_44_7ce0 ; $400c per-slot OAM data
EmilySpriteFrames:
	dw EmilySpriteFrame00 ; $400e
	dw EmilySpriteFrame01 ; $4010
	dw EmilySpriteFrame02 ; $4012
	dw EmilySpriteFrame03 ; $4014
	dw EmilySpriteFrame04 ; $4016
	dw EmilySpriteFrame05 ; $4018
	dw EmilySpriteFrame06 ; $401a
	dw EmilySpriteFrame07 ; $401c
	dw EmilySpriteFrame08 ; $401e
	dw EmilySpriteFrame09 ; $4020
	dw EmilySpriteFrame10 ; $4022
	dw EmilySpriteFrame01 ; $4024
	dw EmilySpriteFrame02 ; $4026
	dw EmilySpriteFrame03 ; $4028
	dw EmilySpriteFrame11 ; $402a
	dw EmilySpriteFrame12 ; $402c
	dw EmilySpriteFrame01 ; $402e
	dw EmilySpriteFrame02 ; $4030
	dw EmilySpriteFrame03 ; $4032
	dw EmilySpriteFrame13 ; $4034
	dw EmilySpriteFrame14 ; $4036
	dw EmilySpriteFrame06 ; $4038
	dw EmilySpriteFrame07 ; $403a
	dw EmilySpriteFrame08 ; $403c
	dw EmilySpriteFrame15 ; $403e
	dw EmilySpriteFrame16 ; $4040
	dw EmilySpriteFrame16 ; $4042
	dw EmilySpriteFrame16 ; $4044
	dw EmilySpriteFrame17 ; $4046
	dw EmilySpriteFrame17 ; $4048
	dw EmilySpriteFrame18 ; $404a
	dw EmilySpriteFrame18 ; $404c
	dw EmilySpriteFrame18 ; $404e
	dw EmilySpriteFrame19 ; $4050
	dw EmilySpriteFrame19 ; $4052
	dw EmilySpriteFrame20 ; $4054
	dw EmilySpriteFrame20 ; $4056
	dw EmilySpriteFrame20 ; $4058
	dw EmilySpriteFrame21 ; $405a
	dw EmilySpriteFrame21 ; $405c
	dw EmilySpriteFrame22 ; $405e
	dw EmilySpriteFrame22 ; $4060
	dw EmilySpriteFrame22 ; $4062
	dw EmilySpriteFrame23 ; $4064
	dw EmilySpriteFrame23 ; $4066
	dw EmilySpriteFrame24 ; $4068
	dw EmilySpriteFrame24 ; $406a
	dw EmilySpriteFrame24 ; $406c
	dw EmilySpriteFrame25 ; $406e
	dw EmilySpriteFrame25 ; $4070
	dw EmilySpriteFrame26 ; $4072
	dw EmilySpriteFrame26 ; $4074
	dw EmilySpriteFrame26 ; $4076
	dw EmilySpriteFrame27 ; $4078
	dw EmilySpriteFrame27 ; $407a
	dw EmilySpriteFrame28 ; $407c
	dw EmilySpriteFrame28 ; $407e
	dw EmilySpriteFrame28 ; $4080
	dw EmilySpriteFrame29 ; $4082
	dw EmilySpriteFrame29 ; $4084
	dw EmilySpriteFrame30 ; $4086
	dw EmilySpriteFrame30 ; $4088
	dw EmilySpriteFrame30 ; $408a
	dw EmilySpriteFrame31 ; $408c
	dw EmilySpriteFrame31 ; $408e
	dw EmilySpriteFrame32 ; $4090
	dw EmilySpriteFrame32 ; $4092
	dw EmilySpriteFrame32 ; $4094
	dw EmilySpriteFrame33 ; $4096
	dw EmilySpriteFrame33 ; $4098
	dw EmilySpriteFrame34 ; $409a
	dw EmilySpriteFrame34 ; $409c
	dw EmilySpriteFrame34 ; $409e
	dw EmilySpriteFrame35 ; $40a0
	dw EmilySpriteFrame35 ; $40a2
	dw EmilySpriteFrame36 ; $40a4
	dw EmilySpriteFrame36 ; $40a6
	dw EmilySpriteFrame36 ; $40a8
	dw EmilySpriteFrame37 ; $40aa
	dw EmilySpriteFrame37 ; $40ac
	dw EmilySpriteFrame38 ; $40ae
	dw EmilySpriteFrame38 ; $40b0
	dw EmilySpriteFrame38 ; $40b2
	dw EmilySpriteFrame39 ; $40b4
	dw EmilySpriteFrame39 ; $40b6
	dw EmilySpriteFrame40 ; $40b8
	dw EmilySpriteFrame40 ; $40ba
	dw EmilySpriteFrame40 ; $40bc
	dw EmilySpriteFrame41 ; $40be
	dw EmilySpriteFrame41 ; $40c0
	dw EmilySpriteFrame42 ; $40c2
	dw EmilySpriteFrame42 ; $40c4
	dw EmilySpriteFrame42 ; $40c6
	dw EmilySpriteFrame42 ; $40c8
	dw EmilySpriteFrame42 ; $40ca
	dw EmilySpriteFrame43 ; $40cc
	dw EmilySpriteFrame43 ; $40ce
	dw EmilySpriteFrame43 ; $40d0
	dw EmilySpriteFrame43 ; $40d2
	dw EmilySpriteFrame43 ; $40d4
	dw EmilySpriteFrame44 ; $40d6
	dw EmilySpriteFrame44 ; $40d8
	dw EmilySpriteFrame44 ; $40da
	dw EmilySpriteFrame45 ; $40dc
	dw EmilySpriteFrame45 ; $40de
	dw EmilySpriteFrame46 ; $40e0
	dw EmilySpriteFrame46 ; $40e2
	dw EmilySpriteFrame46 ; $40e4
	dw EmilySpriteFrame47 ; $40e6
	dw EmilySpriteFrame47 ; $40e8
	dw EmilySpriteFrame48 ; $40ea
	dw EmilySpriteFrame48 ; $40ec
	dw EmilySpriteFrame48 ; $40ee
	dw EmilySpriteFrame49 ; $40f0
	dw EmilySpriteFrame49 ; $40f2
	dw EmilySpriteFrame50 ; $40f4
	dw EmilySpriteFrame50 ; $40f6
	dw EmilySpriteFrame50 ; $40f8
	dw EmilySpriteFrame50 ; $40fa
	dw EmilySpriteFrame50 ; $40fc
	dw EmilySpriteFrame51 ; $40fe
	dw EmilySpriteFrame51 ; $4100
	dw EmilySpriteFrame51 ; $4102
	dw EmilySpriteFrame51 ; $4104
	dw EmilySpriteFrame51 ; $4106
	dw EmilySpriteFrame52 ; $4108
	dw EmilySpriteFrame52 ; $410a
	dw EmilySpriteFrame52 ; $410c
	dw EmilySpriteFrame52 ; $410e
	dw EmilySpriteFrame52 ; $4110
	dw EmilySpriteFrame53 ; $4112
	dw EmilySpriteFrame53 ; $4114
	dw EmilySpriteFrame53 ; $4116
	dw EmilySpriteFrame53 ; $4118
	dw EmilySpriteFrame53 ; $411a
	dw EmilySpriteFrame54 ; $411c
	dw EmilySpriteFrame54 ; $411e
	dw EmilySpriteFrame54 ; $4120
	dw EmilySpriteFrame54 ; $4122
	dw EmilySpriteFrame54 ; $4124
	dw EmilySpriteFrame55 ; $4126
	dw EmilySpriteFrame55 ; $4128
	dw EmilySpriteFrame55 ; $412a
	dw EmilySpriteFrame55 ; $412c
	dw EmilySpriteFrame55 ; $412e
EmilySpriteFrame00:
	INCBIN "data/bank_044/d_4130.bin" ; $4130, 240 bytes
EmilySpriteFrame01:
	INCBIN "data/bank_044/d_4220.bin" ; $4220, 240 bytes
EmilySpriteFrame02:
	INCBIN "data/bank_044/d_4310.bin" ; $4310, 240 bytes
EmilySpriteFrame03:
	INCBIN "data/bank_044/d_4400.bin" ; $4400, 240 bytes
EmilySpriteFrame04:
	INCBIN "data/bank_044/d_44f0.bin" ; $44f0, 240 bytes
EmilySpriteFrame05:
	INCBIN "data/bank_044/d_45e0.bin" ; $45e0, 240 bytes
EmilySpriteFrame06:
	INCBIN "data/bank_044/d_46d0.bin" ; $46d0, 240 bytes
EmilySpriteFrame07:
	INCBIN "data/bank_044/d_47c0.bin" ; $47c0, 240 bytes
EmilySpriteFrame08:
	INCBIN "data/bank_044/d_48b0.bin" ; $48b0, 240 bytes
EmilySpriteFrame09:
	INCBIN "data/bank_044/d_49a0.bin" ; $49a0, 240 bytes
EmilySpriteFrame10:
	INCBIN "data/bank_044/d_4a90.bin" ; $4a90, 240 bytes
EmilySpriteFrame11:
	INCBIN "data/bank_044/d_4b80.bin" ; $4b80, 240 bytes
EmilySpriteFrame12:
	INCBIN "data/bank_044/d_4c70.bin" ; $4c70, 240 bytes
EmilySpriteFrame13:
	INCBIN "data/bank_044/d_4d60.bin" ; $4d60, 240 bytes
EmilySpriteFrame14:
	INCBIN "data/bank_044/d_4e50.bin" ; $4e50, 240 bytes
EmilySpriteFrame15:
	INCBIN "data/bank_044/d_4f40.bin" ; $4f40, 240 bytes
EmilySpriteFrame16:
	INCBIN "data/bank_044/d_5030.bin" ; $5030, 240 bytes
EmilySpriteFrame17:
	INCBIN "data/bank_044/d_5120.bin" ; $5120, 240 bytes
EmilySpriteFrame18:
	INCBIN "data/bank_044/d_5210.bin" ; $5210, 240 bytes
EmilySpriteFrame19:
	INCBIN "data/bank_044/d_5300.bin" ; $5300, 240 bytes
EmilySpriteFrame20:
	INCBIN "data/bank_044/d_53f0.bin" ; $53f0, 240 bytes
EmilySpriteFrame21:
	INCBIN "data/bank_044/d_54e0.bin" ; $54e0, 240 bytes
EmilySpriteFrame22:
	INCBIN "data/bank_044/d_55d0.bin" ; $55d0, 240 bytes
EmilySpriteFrame23:
	INCBIN "data/bank_044/d_56c0.bin" ; $56c0, 240 bytes
EmilySpriteFrame24:
	INCBIN "data/bank_044/d_57b0.bin" ; $57b0, 240 bytes
EmilySpriteFrame25:
	INCBIN "data/bank_044/d_58a0.bin" ; $58a0, 240 bytes
EmilySpriteFrame26:
	INCBIN "data/bank_044/d_5990.bin" ; $5990, 240 bytes
EmilySpriteFrame27:
	INCBIN "data/bank_044/d_5a80.bin" ; $5a80, 240 bytes
EmilySpriteFrame28:
	INCBIN "data/bank_044/d_5b70.bin" ; $5b70, 240 bytes
EmilySpriteFrame29:
	INCBIN "data/bank_044/d_5c60.bin" ; $5c60, 240 bytes
EmilySpriteFrame30:
	INCBIN "data/bank_044/d_5d50.bin" ; $5d50, 240 bytes
EmilySpriteFrame31:
	INCBIN "data/bank_044/d_5e40.bin" ; $5e40, 240 bytes
EmilySpriteFrame32:
	INCBIN "data/bank_044/d_5f30.bin" ; $5f30, 240 bytes
EmilySpriteFrame33:
	INCBIN "data/bank_044/d_6020.bin" ; $6020, 240 bytes
EmilySpriteFrame34:
	INCBIN "data/bank_044/d_6110.bin" ; $6110, 240 bytes
EmilySpriteFrame35:
	INCBIN "data/bank_044/d_6200.bin" ; $6200, 240 bytes
EmilySpriteFrame36:
	INCBIN "data/bank_044/d_62f0.bin" ; $62f0, 240 bytes
EmilySpriteFrame37:
	INCBIN "data/bank_044/d_63e0.bin" ; $63e0, 240 bytes
EmilySpriteFrame38:
	INCBIN "data/bank_044/d_64d0.bin" ; $64d0, 240 bytes
EmilySpriteFrame39:
	INCBIN "data/bank_044/d_65c0.bin" ; $65c0, 240 bytes
EmilySpriteFrame40:
	INCBIN "data/bank_044/d_66b0.bin" ; $66b0, 320 bytes
EmilySpriteFrame41:
	INCBIN "data/bank_044/d_67f0.bin" ; $67f0, 320 bytes
EmilySpriteFrame42:
	INCBIN "data/bank_044/d_6930.bin" ; $6930, 240 bytes
EmilySpriteFrame43:
	INCBIN "data/bank_044/d_6a20.bin" ; $6a20, 240 bytes
EmilySpriteFrame44:
	INCBIN "data/bank_044/d_6b10.bin" ; $6b10, 240 bytes
EmilySpriteFrame45:
	INCBIN "data/bank_044/d_6c00.bin" ; $6c00, 240 bytes
EmilySpriteFrame46:
	INCBIN "data/bank_044/d_6cf0.bin" ; $6cf0, 240 bytes
EmilySpriteFrame47:
	INCBIN "data/bank_044/d_6de0.bin" ; $6de0, 240 bytes
EmilySpriteFrame48:
	INCBIN "data/bank_044/d_6ed0.bin" ; $6ed0, 240 bytes
EmilySpriteFrame49:
	INCBIN "data/bank_044/d_6fc0.bin" ; $6fc0, 240 bytes
EmilySpriteFrame50:
	INCBIN "data/bank_044/d_70b0.bin" ; $70b0, 240 bytes
EmilySpriteFrame51:
	INCBIN "data/bank_044/d_71a0.bin" ; $71a0, 240 bytes
EmilySpriteFrame52:
	INCBIN "data/bank_044/d_7290.bin" ; $7290, 240 bytes
EmilySpriteFrame53:
	INCBIN "data/bank_044/d_7380.bin" ; $7380, 240 bytes
EmilySpriteFrame54:
	INCBIN "data/bank_044/d_7470.bin" ; $7470, 240 bytes
EmilySpriteFrame55:
	INCBIN "data/bank_044/d_7560.bin" ; $7560, 240 bytes
Data_44_7650:
	INCBIN "data/bank_044/d_7650.bin" ; $7650, 1680 bytes
Data_44_7ce0:
	INCBIN "data/bank_044/d_7ce0.bin" ; $7ce0, 580 bytes
EmilySpriteAnims:
	dw EmilySpriteAnim00 ; $7f24
	dw EmilySpriteAnim01 ; $7f26
	dw EmilySpriteAnim02 ; $7f28
	dw EmilySpriteAnim03 ; $7f2a
	dw EmilySpriteAnim04 ; $7f2c
	dw EmilySpriteAnim05 ; $7f2e
	dw EmilySpriteAnim06 ; $7f30
	dw EmilySpriteAnim07 ; $7f32
	dw EmilySpriteAnim08 ; $7f34
	dw EmilySpriteAnim09 ; $7f36
	dw EmilySpriteAnim10 ; $7f38
	dw EmilySpriteAnim11 ; $7f3a
	dw EmilySpriteAnim12 ; $7f3c
	dw EmilySpriteAnim13 ; $7f3e
	dw EmilySpriteAnim14 ; $7f40
	dw EmilySpriteAnim15 ; $7f42
	dw EmilySpriteAnim16 ; $7f44
	dw EmilySpriteAnim17 ; $7f46
	dw EmilySpriteAnim18 ; $7f48
EmilySpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	db $00
	db $ff, $fd
EmilySpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
EmilySpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
EmilySpriteAnim03:
	; $7f5d, 8 bytes (sprite_anim)
	anim_frame $17, $0f
	anim_frame $18, $0f
	anim_frame $19, $0f
	anim_loop $00
EmilySpriteAnim04:
	; $7f65, 10 bytes (sprite_anim)
	anim_frame $1a, $0f
	anim_frame $1c, $0f
	anim_frame $1b, $0f
	anim_frame $1c, $0f
	anim_loop $00
EmilySpriteAnim05:
	; $7f6f, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
EmilySpriteAnim06:
	; $7f75, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
EmilySpriteAnim07:
	; $7f7b, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
EmilySpriteAnim08:
	; $7f81, 5 bytes (sprite_anim)
	db $15, $04, $16, $14, $fd
EmilySpriteAnim09:
	; $7f86, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
EmilySpriteAnim10:
	; $7f8a, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
EmilySpriteAnim11:
	; $7f8e, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
EmilySpriteAnim12:
	; $7f92, 3 bytes (sprite_anim)
	db $15, $18, $fd
EmilySpriteAnim13:
	; $7f95, 3 bytes (sprite_anim)
	db $05, $ff, $fd
EmilySpriteAnim14:
	; $7f98, 3 bytes (sprite_anim)
	db $08, $ff, $fd
EmilySpriteAnim15:
	; $7f9b, 3 bytes (sprite_anim)
	db $0b, $ff, $fd
EmilySpriteAnim16:
	; $7f9e, 3 bytes (sprite_anim)
	db $0e, $ff, $fd
EmilySpriteAnim17:
	; $7fa1, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
EmilySpriteAnim18:
	; $7fad, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fb5, 75 bytes fill to bank end (linker-padded)
