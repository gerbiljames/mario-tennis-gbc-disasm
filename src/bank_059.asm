SECTION "ROM Bank $59", ROMX[$4000], BANK[$59]

	dw FaySpriteDesc ; $4000
FaySpriteDesc:
	dw $0006 ; $4002
	dw $0003 ; $4004
	dw FaySpriteFrames ; $4006 frame table
	dw FaySpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw Data_59_7ce0 ; $400c per-slot OAM data
FaySpriteFrames:
	dw FaySpriteFrame00 ; $400e
	dw FaySpriteFrame01 ; $4010
	dw FaySpriteFrame02 ; $4012
	dw FaySpriteFrame03 ; $4014
	dw FaySpriteFrame04 ; $4016
	dw FaySpriteFrame05 ; $4018
	dw FaySpriteFrame06 ; $401a
	dw FaySpriteFrame07 ; $401c
	dw FaySpriteFrame08 ; $401e
	dw FaySpriteFrame09 ; $4020
	dw FaySpriteFrame10 ; $4022
	dw FaySpriteFrame01 ; $4024
	dw FaySpriteFrame02 ; $4026
	dw FaySpriteFrame03 ; $4028
	dw FaySpriteFrame11 ; $402a
	dw FaySpriteFrame12 ; $402c
	dw FaySpriteFrame01 ; $402e
	dw FaySpriteFrame02 ; $4030
	dw FaySpriteFrame03 ; $4032
	dw FaySpriteFrame13 ; $4034
	dw FaySpriteFrame14 ; $4036
	dw FaySpriteFrame06 ; $4038
	dw FaySpriteFrame07 ; $403a
	dw FaySpriteFrame08 ; $403c
	dw FaySpriteFrame15 ; $403e
	dw FaySpriteFrame16 ; $4040
	dw FaySpriteFrame16 ; $4042
	dw FaySpriteFrame16 ; $4044
	dw FaySpriteFrame17 ; $4046
	dw FaySpriteFrame17 ; $4048
	dw FaySpriteFrame18 ; $404a
	dw FaySpriteFrame18 ; $404c
	dw FaySpriteFrame18 ; $404e
	dw FaySpriteFrame19 ; $4050
	dw FaySpriteFrame19 ; $4052
	dw FaySpriteFrame20 ; $4054
	dw FaySpriteFrame20 ; $4056
	dw FaySpriteFrame20 ; $4058
	dw FaySpriteFrame21 ; $405a
	dw FaySpriteFrame21 ; $405c
	dw FaySpriteFrame22 ; $405e
	dw FaySpriteFrame22 ; $4060
	dw FaySpriteFrame22 ; $4062
	dw FaySpriteFrame23 ; $4064
	dw FaySpriteFrame23 ; $4066
	dw FaySpriteFrame24 ; $4068
	dw FaySpriteFrame24 ; $406a
	dw FaySpriteFrame24 ; $406c
	dw FaySpriteFrame25 ; $406e
	dw FaySpriteFrame25 ; $4070
	dw FaySpriteFrame26 ; $4072
	dw FaySpriteFrame26 ; $4074
	dw FaySpriteFrame26 ; $4076
	dw FaySpriteFrame27 ; $4078
	dw FaySpriteFrame27 ; $407a
	dw FaySpriteFrame28 ; $407c
	dw FaySpriteFrame28 ; $407e
	dw FaySpriteFrame28 ; $4080
	dw FaySpriteFrame29 ; $4082
	dw FaySpriteFrame29 ; $4084
	dw FaySpriteFrame30 ; $4086
	dw FaySpriteFrame30 ; $4088
	dw FaySpriteFrame30 ; $408a
	dw FaySpriteFrame31 ; $408c
	dw FaySpriteFrame31 ; $408e
	dw FaySpriteFrame32 ; $4090
	dw FaySpriteFrame32 ; $4092
	dw FaySpriteFrame32 ; $4094
	dw FaySpriteFrame33 ; $4096
	dw FaySpriteFrame33 ; $4098
	dw FaySpriteFrame34 ; $409a
	dw FaySpriteFrame34 ; $409c
	dw FaySpriteFrame34 ; $409e
	dw FaySpriteFrame35 ; $40a0
	dw FaySpriteFrame35 ; $40a2
	dw FaySpriteFrame36 ; $40a4
	dw FaySpriteFrame36 ; $40a6
	dw FaySpriteFrame36 ; $40a8
	dw FaySpriteFrame37 ; $40aa
	dw FaySpriteFrame37 ; $40ac
	dw FaySpriteFrame38 ; $40ae
	dw FaySpriteFrame38 ; $40b0
	dw FaySpriteFrame38 ; $40b2
	dw FaySpriteFrame39 ; $40b4
	dw FaySpriteFrame39 ; $40b6
	dw FaySpriteFrame40 ; $40b8
	dw FaySpriteFrame40 ; $40ba
	dw FaySpriteFrame40 ; $40bc
	dw FaySpriteFrame41 ; $40be
	dw FaySpriteFrame41 ; $40c0
	dw FaySpriteFrame42 ; $40c2
	dw FaySpriteFrame42 ; $40c4
	dw FaySpriteFrame42 ; $40c6
	dw FaySpriteFrame42 ; $40c8
	dw FaySpriteFrame42 ; $40ca
	dw FaySpriteFrame43 ; $40cc
	dw FaySpriteFrame43 ; $40ce
	dw FaySpriteFrame43 ; $40d0
	dw FaySpriteFrame43 ; $40d2
	dw FaySpriteFrame43 ; $40d4
	dw FaySpriteFrame44 ; $40d6
	dw FaySpriteFrame44 ; $40d8
	dw FaySpriteFrame44 ; $40da
	dw FaySpriteFrame45 ; $40dc
	dw FaySpriteFrame45 ; $40de
	dw FaySpriteFrame46 ; $40e0
	dw FaySpriteFrame46 ; $40e2
	dw FaySpriteFrame46 ; $40e4
	dw FaySpriteFrame47 ; $40e6
	dw FaySpriteFrame47 ; $40e8
	dw FaySpriteFrame48 ; $40ea
	dw FaySpriteFrame48 ; $40ec
	dw FaySpriteFrame48 ; $40ee
	dw FaySpriteFrame49 ; $40f0
	dw FaySpriteFrame49 ; $40f2
	dw FaySpriteFrame50 ; $40f4
	dw FaySpriteFrame50 ; $40f6
	dw FaySpriteFrame50 ; $40f8
	dw FaySpriteFrame50 ; $40fa
	dw FaySpriteFrame50 ; $40fc
	dw FaySpriteFrame51 ; $40fe
	dw FaySpriteFrame51 ; $4100
	dw FaySpriteFrame51 ; $4102
	dw FaySpriteFrame51 ; $4104
	dw FaySpriteFrame51 ; $4106
	dw FaySpriteFrame52 ; $4108
	dw FaySpriteFrame52 ; $410a
	dw FaySpriteFrame52 ; $410c
	dw FaySpriteFrame52 ; $410e
	dw FaySpriteFrame52 ; $4110
	dw FaySpriteFrame53 ; $4112
	dw FaySpriteFrame53 ; $4114
	dw FaySpriteFrame53 ; $4116
	dw FaySpriteFrame53 ; $4118
	dw FaySpriteFrame53 ; $411a
	dw FaySpriteFrame54 ; $411c
	dw FaySpriteFrame54 ; $411e
	dw FaySpriteFrame54 ; $4120
	dw FaySpriteFrame54 ; $4122
	dw FaySpriteFrame54 ; $4124
	dw FaySpriteFrame55 ; $4126
	dw FaySpriteFrame55 ; $4128
	dw FaySpriteFrame55 ; $412a
	dw FaySpriteFrame55 ; $412c
	dw FaySpriteFrame55 ; $412e
FaySpriteFrame00:
	INCBIN "data/bank_059/d_4130.bin" ; $4130, 240 bytes
FaySpriteFrame01:
	INCBIN "data/bank_059/d_4220.bin" ; $4220, 240 bytes
FaySpriteFrame02:
	INCBIN "data/bank_059/d_4310.bin" ; $4310, 240 bytes
FaySpriteFrame03:
	INCBIN "data/bank_059/d_4400.bin" ; $4400, 240 bytes
FaySpriteFrame04:
	INCBIN "data/bank_059/d_44f0.bin" ; $44f0, 240 bytes
FaySpriteFrame05:
	INCBIN "data/bank_059/d_45e0.bin" ; $45e0, 240 bytes
FaySpriteFrame06:
	INCBIN "data/bank_059/d_46d0.bin" ; $46d0, 240 bytes
FaySpriteFrame07:
	INCBIN "data/bank_059/d_47c0.bin" ; $47c0, 240 bytes
FaySpriteFrame08:
	INCBIN "data/bank_059/d_48b0.bin" ; $48b0, 240 bytes
FaySpriteFrame09:
	INCBIN "data/bank_059/d_49a0.bin" ; $49a0, 240 bytes
FaySpriteFrame10:
	INCBIN "data/bank_059/d_4a90.bin" ; $4a90, 240 bytes
FaySpriteFrame11:
	INCBIN "data/bank_059/d_4b80.bin" ; $4b80, 240 bytes
FaySpriteFrame12:
	INCBIN "data/bank_059/d_4c70.bin" ; $4c70, 240 bytes
FaySpriteFrame13:
	INCBIN "data/bank_059/d_4d60.bin" ; $4d60, 240 bytes
FaySpriteFrame14:
	INCBIN "data/bank_059/d_4e50.bin" ; $4e50, 240 bytes
FaySpriteFrame15:
	INCBIN "data/bank_059/d_4f40.bin" ; $4f40, 240 bytes
FaySpriteFrame16:
	INCBIN "data/bank_059/d_5030.bin" ; $5030, 240 bytes
FaySpriteFrame17:
	INCBIN "data/bank_059/d_5120.bin" ; $5120, 240 bytes
FaySpriteFrame18:
	INCBIN "data/bank_059/d_5210.bin" ; $5210, 240 bytes
FaySpriteFrame19:
	INCBIN "data/bank_059/d_5300.bin" ; $5300, 240 bytes
FaySpriteFrame20:
	INCBIN "data/bank_059/d_53f0.bin" ; $53f0, 240 bytes
FaySpriteFrame21:
	INCBIN "data/bank_059/d_54e0.bin" ; $54e0, 240 bytes
FaySpriteFrame22:
	INCBIN "data/bank_059/d_55d0.bin" ; $55d0, 240 bytes
FaySpriteFrame23:
	INCBIN "data/bank_059/d_56c0.bin" ; $56c0, 240 bytes
FaySpriteFrame24:
	INCBIN "data/bank_059/d_57b0.bin" ; $57b0, 240 bytes
FaySpriteFrame25:
	INCBIN "data/bank_059/d_58a0.bin" ; $58a0, 240 bytes
FaySpriteFrame26:
	INCBIN "data/bank_059/d_5990.bin" ; $5990, 240 bytes
FaySpriteFrame27:
	INCBIN "data/bank_059/d_5a80.bin" ; $5a80, 240 bytes
FaySpriteFrame28:
	INCBIN "data/bank_059/d_5b70.bin" ; $5b70, 240 bytes
FaySpriteFrame29:
	INCBIN "data/bank_059/d_5c60.bin" ; $5c60, 240 bytes
FaySpriteFrame30:
	INCBIN "data/bank_059/d_5d50.bin" ; $5d50, 240 bytes
FaySpriteFrame31:
	INCBIN "data/bank_059/d_5e40.bin" ; $5e40, 240 bytes
FaySpriteFrame32:
	INCBIN "data/bank_059/d_5f30.bin" ; $5f30, 240 bytes
FaySpriteFrame33:
	INCBIN "data/bank_059/d_6020.bin" ; $6020, 240 bytes
FaySpriteFrame34:
	INCBIN "data/bank_059/d_6110.bin" ; $6110, 240 bytes
FaySpriteFrame35:
	INCBIN "data/bank_059/d_6200.bin" ; $6200, 240 bytes
FaySpriteFrame36:
	INCBIN "data/bank_059/d_62f0.bin" ; $62f0, 240 bytes
FaySpriteFrame37:
	INCBIN "data/bank_059/d_63e0.bin" ; $63e0, 240 bytes
FaySpriteFrame38:
	INCBIN "data/bank_059/d_64d0.bin" ; $64d0, 240 bytes
FaySpriteFrame39:
	INCBIN "data/bank_059/d_65c0.bin" ; $65c0, 240 bytes
FaySpriteFrame40:
	INCBIN "data/bank_059/d_66b0.bin" ; $66b0, 320 bytes
FaySpriteFrame41:
	INCBIN "data/bank_059/d_67f0.bin" ; $67f0, 320 bytes
FaySpriteFrame42:
	INCBIN "data/bank_059/d_6930.bin" ; $6930, 240 bytes
FaySpriteFrame43:
	INCBIN "data/bank_059/d_6a20.bin" ; $6a20, 240 bytes
FaySpriteFrame44:
	INCBIN "data/bank_059/d_6b10.bin" ; $6b10, 240 bytes
FaySpriteFrame45:
	INCBIN "data/bank_059/d_6c00.bin" ; $6c00, 240 bytes
FaySpriteFrame46:
	INCBIN "data/bank_059/d_6cf0.bin" ; $6cf0, 240 bytes
FaySpriteFrame47:
	INCBIN "data/bank_059/d_6de0.bin" ; $6de0, 240 bytes
FaySpriteFrame48:
	INCBIN "data/bank_059/d_6ed0.bin" ; $6ed0, 240 bytes
FaySpriteFrame49:
	INCBIN "data/bank_059/d_6fc0.bin" ; $6fc0, 240 bytes
FaySpriteFrame50:
	INCBIN "data/bank_059/d_70b0.bin" ; $70b0, 240 bytes
FaySpriteFrame51:
	INCBIN "data/bank_059/d_71a0.bin" ; $71a0, 240 bytes
FaySpriteFrame52:
	INCBIN "data/bank_059/d_7290.bin" ; $7290, 240 bytes
FaySpriteFrame53:
	INCBIN "data/bank_059/d_7380.bin" ; $7380, 240 bytes
FaySpriteFrame54:
	INCBIN "data/bank_059/d_7470.bin" ; $7470, 240 bytes
FaySpriteFrame55:
	INCBIN "data/bank_059/d_7560.bin" ; $7560, 240 bytes
Data_59_7650:
	INCBIN "data/bank_059/d_7650.bin" ; $7650, 1680 bytes
Data_59_7ce0:
	INCBIN "data/bank_059/d_7ce0.bin" ; $7ce0, 580 bytes
FaySpriteAnims:
	dw FaySpriteAnim00 ; $7f24
	dw FaySpriteAnim01 ; $7f26
	dw FaySpriteAnim02 ; $7f28
	dw FaySpriteAnim03 ; $7f2a
	dw FaySpriteAnim04 ; $7f2c
	dw FaySpriteAnim05 ; $7f2e
	dw FaySpriteAnim06 ; $7f30
	dw FaySpriteAnim07 ; $7f32
	dw FaySpriteAnim08 ; $7f34
	dw FaySpriteAnim09 ; $7f36
	dw FaySpriteAnim10 ; $7f38
	dw FaySpriteAnim11 ; $7f3a
	dw FaySpriteAnim12 ; $7f3c
	dw FaySpriteAnim13 ; $7f3e
	dw FaySpriteAnim14 ; $7f40
	dw FaySpriteAnim15 ; $7f42
	dw FaySpriteAnim16 ; $7f44
	dw FaySpriteAnim17 ; $7f46
	dw FaySpriteAnim18 ; $7f48
FaySpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	db $00
	db $ff, $fd
FaySpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
FaySpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
FaySpriteAnim03:
	; $7f5d, 8 bytes (sprite_anim)
	anim_frame $17, $0f
	anim_frame $18, $0a
	anim_frame $19, $1e
	anim_loop $00
FaySpriteAnim04:
	; $7f65, 8 bytes (sprite_anim)
	anim_frame $1a, $1e
	anim_frame $1b, $0f
	anim_frame $1c, $0f
	anim_loop $02
FaySpriteAnim05:
	; $7f6d, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
FaySpriteAnim06:
	; $7f73, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
FaySpriteAnim07:
	; $7f79, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
FaySpriteAnim08:
	; $7f7f, 5 bytes (sprite_anim)
	db $15, $04, $16, $14, $fd
FaySpriteAnim09:
	; $7f84, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
FaySpriteAnim10:
	; $7f88, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
FaySpriteAnim11:
	; $7f8c, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
FaySpriteAnim12:
	; $7f90, 3 bytes (sprite_anim)
	db $15, $18, $fd
FaySpriteAnim13:
	; $7f93, 3 bytes (sprite_anim)
	db $05, $ff, $fd
FaySpriteAnim14:
	; $7f96, 3 bytes (sprite_anim)
	db $08, $ff, $fd
FaySpriteAnim15:
	; $7f99, 3 bytes (sprite_anim)
	db $0b, $ff, $fd
FaySpriteAnim16:
	; $7f9c, 3 bytes (sprite_anim)
	db $0e, $ff, $fd
FaySpriteAnim17:
	; $7f9f, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
FaySpriteAnim18:
	; $7fab, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fb3, 77 bytes fill to bank end (linker-padded)
