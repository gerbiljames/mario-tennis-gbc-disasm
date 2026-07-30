SECTION "ROM Bank $48", ROMX[$4000], BANK[$48]

	dw SpikeSpriteDesc ; $4000
SpikeSpriteDesc:
	dw $0005 ; $4002
	dw $0003 ; $4004
	dw SpikeSpriteFrames ; $4006 frame table
	dw SpikeSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw SpikeSpriteOam ; $400c per-slot OAM data
SpikeSpriteFrames:
	dw SpikeSpriteFrame00 ; $400e
	dw SpikeSpriteFrame01 ; $4010
	dw SpikeSpriteFrame02 ; $4012
	dw SpikeSpriteFrame03 ; $4014
	dw SpikeSpriteFrame04 ; $4016
	dw SpikeSpriteFrame05 ; $4018
	dw SpikeSpriteFrame06 ; $401a
	dw SpikeSpriteFrame07 ; $401c
	dw SpikeSpriteFrame08 ; $401e
	dw SpikeSpriteFrame09 ; $4020
	dw SpikeSpriteFrame10 ; $4022
	dw SpikeSpriteFrame01 ; $4024
	dw SpikeSpriteFrame02 ; $4026
	dw SpikeSpriteFrame03 ; $4028
	dw SpikeSpriteFrame11 ; $402a
	dw SpikeSpriteFrame12 ; $402c
	dw SpikeSpriteFrame01 ; $402e
	dw SpikeSpriteFrame02 ; $4030
	dw SpikeSpriteFrame03 ; $4032
	dw SpikeSpriteFrame13 ; $4034
	dw SpikeSpriteFrame14 ; $4036
	dw SpikeSpriteFrame06 ; $4038
	dw SpikeSpriteFrame07 ; $403a
	dw SpikeSpriteFrame08 ; $403c
	dw SpikeSpriteFrame15 ; $403e
	dw SpikeSpriteFrame16 ; $4040
	dw SpikeSpriteFrame16 ; $4042
	dw SpikeSpriteFrame16 ; $4044
	dw SpikeSpriteFrame17 ; $4046
	dw SpikeSpriteFrame17 ; $4048
	dw SpikeSpriteFrame18 ; $404a
	dw SpikeSpriteFrame18 ; $404c
	dw SpikeSpriteFrame18 ; $404e
	dw SpikeSpriteFrame19 ; $4050
	dw SpikeSpriteFrame19 ; $4052
	dw SpikeSpriteFrame20 ; $4054
	dw SpikeSpriteFrame20 ; $4056
	dw SpikeSpriteFrame20 ; $4058
	dw SpikeSpriteFrame21 ; $405a
	dw SpikeSpriteFrame21 ; $405c
	dw SpikeSpriteFrame22 ; $405e
	dw SpikeSpriteFrame22 ; $4060
	dw SpikeSpriteFrame22 ; $4062
	dw SpikeSpriteFrame23 ; $4064
	dw SpikeSpriteFrame23 ; $4066
	dw SpikeSpriteFrame24 ; $4068
	dw SpikeSpriteFrame24 ; $406a
	dw SpikeSpriteFrame24 ; $406c
	dw SpikeSpriteFrame25 ; $406e
	dw SpikeSpriteFrame25 ; $4070
	dw SpikeSpriteFrame26 ; $4072
	dw SpikeSpriteFrame26 ; $4074
	dw SpikeSpriteFrame26 ; $4076
	dw SpikeSpriteFrame27 ; $4078
	dw SpikeSpriteFrame27 ; $407a
	dw SpikeSpriteFrame28 ; $407c
	dw SpikeSpriteFrame28 ; $407e
	dw SpikeSpriteFrame28 ; $4080
	dw SpikeSpriteFrame29 ; $4082
	dw SpikeSpriteFrame29 ; $4084
	dw SpikeSpriteFrame30 ; $4086
	dw SpikeSpriteFrame30 ; $4088
	dw SpikeSpriteFrame30 ; $408a
	dw SpikeSpriteFrame31 ; $408c
	dw SpikeSpriteFrame31 ; $408e
	dw SpikeSpriteFrame32 ; $4090
	dw SpikeSpriteFrame32 ; $4092
	dw SpikeSpriteFrame32 ; $4094
	dw SpikeSpriteFrame33 ; $4096
	dw SpikeSpriteFrame33 ; $4098
	dw SpikeSpriteFrame34 ; $409a
	dw SpikeSpriteFrame34 ; $409c
	dw SpikeSpriteFrame34 ; $409e
	dw SpikeSpriteFrame35 ; $40a0
	dw SpikeSpriteFrame35 ; $40a2
	dw SpikeSpriteFrame36 ; $40a4
	dw SpikeSpriteFrame36 ; $40a6
	dw SpikeSpriteFrame36 ; $40a8
	dw SpikeSpriteFrame37 ; $40aa
	dw SpikeSpriteFrame37 ; $40ac
	dw SpikeSpriteFrame38 ; $40ae
	dw SpikeSpriteFrame38 ; $40b0
	dw SpikeSpriteFrame38 ; $40b2
	dw SpikeSpriteFrame39 ; $40b4
	dw SpikeSpriteFrame39 ; $40b6
	dw SpikeSpriteFrame40 ; $40b8
	dw SpikeSpriteFrame40 ; $40ba
	dw SpikeSpriteFrame40 ; $40bc
	dw SpikeSpriteFrame41 ; $40be
	dw SpikeSpriteFrame41 ; $40c0
	dw SpikeSpriteFrame42 ; $40c2
	dw SpikeSpriteFrame42 ; $40c4
	dw SpikeSpriteFrame42 ; $40c6
	dw SpikeSpriteFrame42 ; $40c8
	dw SpikeSpriteFrame42 ; $40ca
	dw SpikeSpriteFrame43 ; $40cc
	dw SpikeSpriteFrame43 ; $40ce
	dw SpikeSpriteFrame43 ; $40d0
	dw SpikeSpriteFrame43 ; $40d2
	dw SpikeSpriteFrame43 ; $40d4
	dw SpikeSpriteFrame44 ; $40d6
	dw SpikeSpriteFrame44 ; $40d8
	dw SpikeSpriteFrame44 ; $40da
	dw SpikeSpriteFrame45 ; $40dc
	dw SpikeSpriteFrame45 ; $40de
	dw SpikeSpriteFrame46 ; $40e0
	dw SpikeSpriteFrame46 ; $40e2
	dw SpikeSpriteFrame46 ; $40e4
	dw SpikeSpriteFrame47 ; $40e6
	dw SpikeSpriteFrame47 ; $40e8
	dw SpikeSpriteFrame48 ; $40ea
	dw SpikeSpriteFrame48 ; $40ec
	dw SpikeSpriteFrame48 ; $40ee
	dw SpikeSpriteFrame49 ; $40f0
	dw SpikeSpriteFrame49 ; $40f2
	dw SpikeSpriteFrame50 ; $40f4
	dw SpikeSpriteFrame50 ; $40f6
	dw SpikeSpriteFrame50 ; $40f8
	dw SpikeSpriteFrame50 ; $40fa
	dw SpikeSpriteFrame50 ; $40fc
	dw SpikeSpriteFrame51 ; $40fe
	dw SpikeSpriteFrame51 ; $4100
	dw SpikeSpriteFrame51 ; $4102
	dw SpikeSpriteFrame51 ; $4104
	dw SpikeSpriteFrame51 ; $4106
	dw SpikeSpriteFrame52 ; $4108
	dw SpikeSpriteFrame52 ; $410a
	dw SpikeSpriteFrame52 ; $410c
	dw SpikeSpriteFrame52 ; $410e
	dw SpikeSpriteFrame52 ; $4110
	dw SpikeSpriteFrame53 ; $4112
	dw SpikeSpriteFrame53 ; $4114
	dw SpikeSpriteFrame53 ; $4116
	dw SpikeSpriteFrame53 ; $4118
	dw SpikeSpriteFrame53 ; $411a
	dw SpikeSpriteFrame54 ; $411c
	dw SpikeSpriteFrame54 ; $411e
	dw SpikeSpriteFrame54 ; $4120
	dw SpikeSpriteFrame54 ; $4122
	dw SpikeSpriteFrame54 ; $4124
	dw SpikeSpriteFrame55 ; $4126
	dw SpikeSpriteFrame55 ; $4128
	dw SpikeSpriteFrame55 ; $412a
	dw SpikeSpriteFrame55 ; $412c
	dw SpikeSpriteFrame55 ; $412e
SpikeSpriteFrame00:
	INCBIN "data/bank_048/d_4130.bin" ; $4130, 240 bytes
SpikeSpriteFrame01:
	INCBIN "data/bank_048/d_4220.bin" ; $4220, 240 bytes
SpikeSpriteFrame02:
	INCBIN "data/bank_048/d_4310.bin" ; $4310, 240 bytes
SpikeSpriteFrame03:
	INCBIN "data/bank_048/d_4400.bin" ; $4400, 240 bytes
SpikeSpriteFrame04:
	INCBIN "data/bank_048/d_44f0.bin" ; $44f0, 240 bytes
SpikeSpriteFrame05:
	INCBIN "data/bank_048/d_45e0.bin" ; $45e0, 240 bytes
SpikeSpriteFrame06:
	INCBIN "data/bank_048/d_46d0.bin" ; $46d0, 240 bytes
SpikeSpriteFrame07:
	INCBIN "data/bank_048/d_47c0.bin" ; $47c0, 240 bytes
SpikeSpriteFrame08:
	INCBIN "data/bank_048/d_48b0.bin" ; $48b0, 240 bytes
SpikeSpriteFrame09:
	INCBIN "data/bank_048/d_49a0.bin" ; $49a0, 240 bytes
SpikeSpriteFrame10:
	INCBIN "data/bank_048/d_4a90.bin" ; $4a90, 240 bytes
SpikeSpriteFrame11:
	INCBIN "data/bank_048/d_4b80.bin" ; $4b80, 240 bytes
SpikeSpriteFrame12:
	INCBIN "data/bank_048/d_4c70.bin" ; $4c70, 240 bytes
SpikeSpriteFrame13:
	INCBIN "data/bank_048/d_4d60.bin" ; $4d60, 240 bytes
SpikeSpriteFrame14:
	INCBIN "data/bank_048/d_4e50.bin" ; $4e50, 240 bytes
SpikeSpriteFrame15:
	INCBIN "data/bank_048/d_4f40.bin" ; $4f40, 240 bytes
SpikeSpriteFrame16:
	INCBIN "data/bank_048/d_5030.bin" ; $5030, 240 bytes
SpikeSpriteFrame17:
	INCBIN "data/bank_048/d_5120.bin" ; $5120, 240 bytes
SpikeSpriteFrame18:
	INCBIN "data/bank_048/d_5210.bin" ; $5210, 240 bytes
SpikeSpriteFrame19:
	INCBIN "data/bank_048/d_5300.bin" ; $5300, 240 bytes
SpikeSpriteFrame20:
	INCBIN "data/bank_048/d_53f0.bin" ; $53f0, 240 bytes
SpikeSpriteFrame21:
	INCBIN "data/bank_048/d_54e0.bin" ; $54e0, 240 bytes
SpikeSpriteFrame22:
	INCBIN "data/bank_048/d_55d0.bin" ; $55d0, 240 bytes
SpikeSpriteFrame23:
	INCBIN "data/bank_048/d_56c0.bin" ; $56c0, 240 bytes
SpikeSpriteFrame24:
	INCBIN "data/bank_048/d_57b0.bin" ; $57b0, 240 bytes
SpikeSpriteFrame25:
	INCBIN "data/bank_048/d_58a0.bin" ; $58a0, 240 bytes
SpikeSpriteFrame26:
	INCBIN "data/bank_048/d_5990.bin" ; $5990, 240 bytes
SpikeSpriteFrame27:
	INCBIN "data/bank_048/d_5a80.bin" ; $5a80, 240 bytes
SpikeSpriteFrame28:
	INCBIN "data/bank_048/d_5b70.bin" ; $5b70, 240 bytes
SpikeSpriteFrame29:
	INCBIN "data/bank_048/d_5c60.bin" ; $5c60, 240 bytes
SpikeSpriteFrame30:
	INCBIN "data/bank_048/d_5d50.bin" ; $5d50, 240 bytes
SpikeSpriteFrame31:
	INCBIN "data/bank_048/d_5e40.bin" ; $5e40, 240 bytes
SpikeSpriteFrame32:
	INCBIN "data/bank_048/d_5f30.bin" ; $5f30, 240 bytes
SpikeSpriteFrame33:
	INCBIN "data/bank_048/d_6020.bin" ; $6020, 240 bytes
SpikeSpriteFrame34:
	INCBIN "data/bank_048/d_6110.bin" ; $6110, 240 bytes
SpikeSpriteFrame35:
	INCBIN "data/bank_048/d_6200.bin" ; $6200, 240 bytes
SpikeSpriteFrame36:
	INCBIN "data/bank_048/d_62f0.bin" ; $62f0, 240 bytes
SpikeSpriteFrame37:
	INCBIN "data/bank_048/d_63e0.bin" ; $63e0, 240 bytes
SpikeSpriteFrame38:
	INCBIN "data/bank_048/d_64d0.bin" ; $64d0, 240 bytes
SpikeSpriteFrame39:
	INCBIN "data/bank_048/d_65c0.bin" ; $65c0, 240 bytes
SpikeSpriteFrame40:
	INCBIN "data/bank_048/d_66b0.bin" ; $66b0, 320 bytes
SpikeSpriteFrame41:
	INCBIN "data/bank_048/d_67f0.bin" ; $67f0, 320 bytes
SpikeSpriteFrame42:
	INCBIN "data/bank_048/d_6930.bin" ; $6930, 240 bytes
SpikeSpriteFrame43:
	INCBIN "data/bank_048/d_6a20.bin" ; $6a20, 240 bytes
SpikeSpriteFrame44:
	INCBIN "data/bank_048/d_6b10.bin" ; $6b10, 240 bytes
SpikeSpriteFrame45:
	INCBIN "data/bank_048/d_6c00.bin" ; $6c00, 240 bytes
SpikeSpriteFrame46:
	INCBIN "data/bank_048/d_6cf0.bin" ; $6cf0, 240 bytes
SpikeSpriteFrame47:
	INCBIN "data/bank_048/d_6de0.bin" ; $6de0, 240 bytes
SpikeSpriteFrame48:
	INCBIN "data/bank_048/d_6ed0.bin" ; $6ed0, 240 bytes
SpikeSpriteFrame49:
	INCBIN "data/bank_048/d_6fc0.bin" ; $6fc0, 240 bytes
SpikeSpriteFrame50:
	INCBIN "data/bank_048/d_70b0.bin" ; $70b0, 240 bytes
SpikeSpriteFrame51:
	INCBIN "data/bank_048/d_71a0.bin" ; $71a0, 240 bytes
SpikeSpriteFrame52:
	INCBIN "data/bank_048/d_7290.bin" ; $7290, 240 bytes
SpikeSpriteFrame53:
	INCBIN "data/bank_048/d_7380.bin" ; $7380, 240 bytes
SpikeSpriteFrame54:
	INCBIN "data/bank_048/d_7470.bin" ; $7470, 240 bytes
SpikeSpriteFrame55:
	INCBIN "data/bank_048/d_7560.bin" ; $7560, 240 bytes
SpikeSpriteFramesUnused:
	INCBIN "data/bank_048/d_7650.bin" ; $7650, 1680 bytes
SpikeSpriteOam:
	INCBIN "data/bank_048/d_7ce0.bin" ; $7ce0, 580 bytes
SpikeSpriteAnims:
	dw SpikeSpriteAnim00 ; $7f24
	dw SpikeSpriteAnim01 ; $7f26
	dw SpikeSpriteAnim02 ; $7f28
	dw SpikeSpriteAnim03 ; $7f2a
	dw SpikeSpriteAnim04 ; $7f2c
	dw SpikeSpriteAnim05 ; $7f2e
	dw SpikeSpriteAnim06 ; $7f30
	dw SpikeSpriteAnim07 ; $7f32
	dw SpikeSpriteAnim08 ; $7f34
	dw SpikeSpriteAnim09 ; $7f36
	dw SpikeSpriteAnim10 ; $7f38
	dw SpikeSpriteAnim11 ; $7f3a
	dw SpikeSpriteAnim12 ; $7f3c
	dw SpikeSpriteAnim13 ; $7f3e
	dw SpikeSpriteAnim14 ; $7f40
	dw SpikeSpriteAnim15 ; $7f42
	dw SpikeSpriteAnim16 ; $7f44
	dw SpikeSpriteAnim17 ; $7f46
	dw SpikeSpriteAnim18 ; $7f48
SpikeSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
SpikeSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
SpikeSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
SpikeSpriteAnim03:
	; $7f5d, 8 bytes (sprite_anim)
	anim_frame $17, $0a
	anim_frame $18, $0a
	anim_frame $19, $19
	anim_loop $00
SpikeSpriteAnim04:
	; $7f65, 8 bytes (sprite_anim)
	anim_frame $1a, $19
	anim_frame $1b, $14
	anim_frame $1c, $32
	anim_loop $00
SpikeSpriteAnim05:
	; $7f6d, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
SpikeSpriteAnim06:
	; $7f73, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
SpikeSpriteAnim07:
	; $7f79, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
SpikeSpriteAnim08:
	; $7f7f, 5 bytes (sprite_anim)
	anim_frame $15, $04
	anim_frame $16, $14
	anim_hold $fd
SpikeSpriteAnim09:
	; $7f84, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
SpikeSpriteAnim10:
	; $7f88, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
SpikeSpriteAnim11:
	; $7f8c, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
SpikeSpriteAnim12:
	; $7f90, 3 bytes (sprite_anim)
	anim_frame $15, $18
	anim_hold $fd
SpikeSpriteAnim13:
	; $7f93, 3 bytes (sprite_anim)
	anim_frame $05, $ff
	anim_hold $fd
SpikeSpriteAnim14:
	; $7f96, 3 bytes (sprite_anim)
	anim_frame $08, $ff
	anim_hold $fd
SpikeSpriteAnim15:
	; $7f99, 3 bytes (sprite_anim)
	anim_frame $0b, $ff
	anim_hold $fd
SpikeSpriteAnim16:
	; $7f9c, 3 bytes (sprite_anim)
	anim_frame $0e, $ff
	anim_hold $fd
SpikeSpriteAnim17:
	; $7f9f, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
SpikeSpriteAnim18:
	; $7fab, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fb3, 77 bytes fill to bank end (linker-padded)
