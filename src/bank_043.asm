SECTION "ROM Bank $43", ROMX[$4000], BANK[$43]

	dw HarrySpriteDesc ; $4000
HarrySpriteDesc:
	dw $0005 ; $4002
	dw $0003 ; $4004
	dw HarrySpriteFrames ; $4006 frame table
	dw HarrySpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw HarrySpriteOam ; $400c per-slot OAM data
HarrySpriteFrames:
	dw HarrySpriteFrame00 ; $400e
	dw HarrySpriteFrame01 ; $4010
	dw HarrySpriteFrame02 ; $4012
	dw HarrySpriteFrame03 ; $4014
	dw HarrySpriteFrame04 ; $4016
	dw HarrySpriteFrame05 ; $4018
	dw HarrySpriteFrame06 ; $401a
	dw HarrySpriteFrame07 ; $401c
	dw HarrySpriteFrame08 ; $401e
	dw HarrySpriteFrame09 ; $4020
	dw HarrySpriteFrame10 ; $4022
	dw HarrySpriteFrame01 ; $4024
	dw HarrySpriteFrame02 ; $4026
	dw HarrySpriteFrame03 ; $4028
	dw HarrySpriteFrame11 ; $402a
	dw HarrySpriteFrame12 ; $402c
	dw HarrySpriteFrame01 ; $402e
	dw HarrySpriteFrame02 ; $4030
	dw HarrySpriteFrame03 ; $4032
	dw HarrySpriteFrame13 ; $4034
	dw HarrySpriteFrame14 ; $4036
	dw HarrySpriteFrame06 ; $4038
	dw HarrySpriteFrame07 ; $403a
	dw HarrySpriteFrame08 ; $403c
	dw HarrySpriteFrame15 ; $403e
	dw HarrySpriteFrame16 ; $4040
	dw HarrySpriteFrame16 ; $4042
	dw HarrySpriteFrame16 ; $4044
	dw HarrySpriteFrame17 ; $4046
	dw HarrySpriteFrame17 ; $4048
	dw HarrySpriteFrame18 ; $404a
	dw HarrySpriteFrame18 ; $404c
	dw HarrySpriteFrame18 ; $404e
	dw HarrySpriteFrame19 ; $4050
	dw HarrySpriteFrame19 ; $4052
	dw HarrySpriteFrame20 ; $4054
	dw HarrySpriteFrame20 ; $4056
	dw HarrySpriteFrame20 ; $4058
	dw HarrySpriteFrame21 ; $405a
	dw HarrySpriteFrame21 ; $405c
	dw HarrySpriteFrame22 ; $405e
	dw HarrySpriteFrame22 ; $4060
	dw HarrySpriteFrame22 ; $4062
	dw HarrySpriteFrame23 ; $4064
	dw HarrySpriteFrame23 ; $4066
	dw HarrySpriteFrame24 ; $4068
	dw HarrySpriteFrame24 ; $406a
	dw HarrySpriteFrame24 ; $406c
	dw HarrySpriteFrame25 ; $406e
	dw HarrySpriteFrame25 ; $4070
	dw HarrySpriteFrame26 ; $4072
	dw HarrySpriteFrame26 ; $4074
	dw HarrySpriteFrame26 ; $4076
	dw HarrySpriteFrame27 ; $4078
	dw HarrySpriteFrame27 ; $407a
	dw HarrySpriteFrame28 ; $407c
	dw HarrySpriteFrame28 ; $407e
	dw HarrySpriteFrame28 ; $4080
	dw HarrySpriteFrame29 ; $4082
	dw HarrySpriteFrame29 ; $4084
	dw HarrySpriteFrame30 ; $4086
	dw HarrySpriteFrame30 ; $4088
	dw HarrySpriteFrame30 ; $408a
	dw HarrySpriteFrame31 ; $408c
	dw HarrySpriteFrame31 ; $408e
	dw HarrySpriteFrame32 ; $4090
	dw HarrySpriteFrame32 ; $4092
	dw HarrySpriteFrame32 ; $4094
	dw HarrySpriteFrame33 ; $4096
	dw HarrySpriteFrame33 ; $4098
	dw HarrySpriteFrame34 ; $409a
	dw HarrySpriteFrame34 ; $409c
	dw HarrySpriteFrame34 ; $409e
	dw HarrySpriteFrame35 ; $40a0
	dw HarrySpriteFrame35 ; $40a2
	dw HarrySpriteFrame36 ; $40a4
	dw HarrySpriteFrame36 ; $40a6
	dw HarrySpriteFrame36 ; $40a8
	dw HarrySpriteFrame37 ; $40aa
	dw HarrySpriteFrame37 ; $40ac
	dw HarrySpriteFrame38 ; $40ae
	dw HarrySpriteFrame38 ; $40b0
	dw HarrySpriteFrame38 ; $40b2
	dw HarrySpriteFrame39 ; $40b4
	dw HarrySpriteFrame39 ; $40b6
	dw HarrySpriteFrame40 ; $40b8
	dw HarrySpriteFrame40 ; $40ba
	dw HarrySpriteFrame40 ; $40bc
	dw HarrySpriteFrame41 ; $40be
	dw HarrySpriteFrame41 ; $40c0
	dw HarrySpriteFrame42 ; $40c2
	dw HarrySpriteFrame42 ; $40c4
	dw HarrySpriteFrame42 ; $40c6
	dw HarrySpriteFrame42 ; $40c8
	dw HarrySpriteFrame42 ; $40ca
	dw HarrySpriteFrame43 ; $40cc
	dw HarrySpriteFrame43 ; $40ce
	dw HarrySpriteFrame43 ; $40d0
	dw HarrySpriteFrame43 ; $40d2
	dw HarrySpriteFrame43 ; $40d4
	dw HarrySpriteFrame44 ; $40d6
	dw HarrySpriteFrame44 ; $40d8
	dw HarrySpriteFrame44 ; $40da
	dw HarrySpriteFrame45 ; $40dc
	dw HarrySpriteFrame45 ; $40de
	dw HarrySpriteFrame46 ; $40e0
	dw HarrySpriteFrame46 ; $40e2
	dw HarrySpriteFrame46 ; $40e4
	dw HarrySpriteFrame47 ; $40e6
	dw HarrySpriteFrame47 ; $40e8
	dw HarrySpriteFrame48 ; $40ea
	dw HarrySpriteFrame48 ; $40ec
	dw HarrySpriteFrame48 ; $40ee
	dw HarrySpriteFrame49 ; $40f0
	dw HarrySpriteFrame49 ; $40f2
	dw HarrySpriteFrame50 ; $40f4
	dw HarrySpriteFrame50 ; $40f6
	dw HarrySpriteFrame50 ; $40f8
	dw HarrySpriteFrame50 ; $40fa
	dw HarrySpriteFrame50 ; $40fc
	dw HarrySpriteFrame51 ; $40fe
	dw HarrySpriteFrame51 ; $4100
	dw HarrySpriteFrame51 ; $4102
	dw HarrySpriteFrame51 ; $4104
	dw HarrySpriteFrame51 ; $4106
	dw HarrySpriteFrame52 ; $4108
	dw HarrySpriteFrame52 ; $410a
	dw HarrySpriteFrame52 ; $410c
	dw HarrySpriteFrame52 ; $410e
	dw HarrySpriteFrame52 ; $4110
	dw HarrySpriteFrame53 ; $4112
	dw HarrySpriteFrame53 ; $4114
	dw HarrySpriteFrame53 ; $4116
	dw HarrySpriteFrame53 ; $4118
	dw HarrySpriteFrame53 ; $411a
	dw HarrySpriteFrame54 ; $411c
	dw HarrySpriteFrame54 ; $411e
	dw HarrySpriteFrame54 ; $4120
	dw HarrySpriteFrame54 ; $4122
	dw HarrySpriteFrame54 ; $4124
	dw HarrySpriteFrame55 ; $4126
	dw HarrySpriteFrame55 ; $4128
	dw HarrySpriteFrame55 ; $412a
	dw HarrySpriteFrame55 ; $412c
	dw HarrySpriteFrame55 ; $412e
HarrySpriteFrame00:
	INCBIN "data/bank_043/HarrySpriteFrame00.bin" ; $4130, 240 bytes
HarrySpriteFrame01:
	INCBIN "data/bank_043/HarrySpriteFrame01.bin" ; $4220, 240 bytes
HarrySpriteFrame02:
	INCBIN "data/bank_043/HarrySpriteFrame02.bin" ; $4310, 240 bytes
HarrySpriteFrame03:
	INCBIN "data/bank_043/HarrySpriteFrame03.bin" ; $4400, 240 bytes
HarrySpriteFrame04:
	INCBIN "data/bank_043/HarrySpriteFrame04.bin" ; $44f0, 240 bytes
HarrySpriteFrame05:
	INCBIN "data/bank_043/HarrySpriteFrame05.bin" ; $45e0, 240 bytes
HarrySpriteFrame06:
	INCBIN "data/bank_043/HarrySpriteFrame06.bin" ; $46d0, 240 bytes
HarrySpriteFrame07:
	INCBIN "data/bank_043/HarrySpriteFrame07.bin" ; $47c0, 240 bytes
HarrySpriteFrame08:
	INCBIN "data/bank_043/HarrySpriteFrame08.bin" ; $48b0, 240 bytes
HarrySpriteFrame09:
	INCBIN "data/bank_043/HarrySpriteFrame09.bin" ; $49a0, 240 bytes
HarrySpriteFrame10:
	INCBIN "data/bank_043/HarrySpriteFrame10.bin" ; $4a90, 240 bytes
HarrySpriteFrame11:
	INCBIN "data/bank_043/HarrySpriteFrame11.bin" ; $4b80, 240 bytes
HarrySpriteFrame12:
	INCBIN "data/bank_043/HarrySpriteFrame12.bin" ; $4c70, 240 bytes
HarrySpriteFrame13:
	INCBIN "data/bank_043/HarrySpriteFrame13.bin" ; $4d60, 240 bytes
HarrySpriteFrame14:
	INCBIN "data/bank_043/HarrySpriteFrame14.bin" ; $4e50, 240 bytes
HarrySpriteFrame15:
	INCBIN "data/bank_043/HarrySpriteFrame15.bin" ; $4f40, 240 bytes
HarrySpriteFrame16:
	INCBIN "data/bank_043/HarrySpriteFrame16.bin" ; $5030, 240 bytes
HarrySpriteFrame17:
	INCBIN "data/bank_043/HarrySpriteFrame17.bin" ; $5120, 240 bytes
HarrySpriteFrame18:
	INCBIN "data/bank_043/HarrySpriteFrame18.bin" ; $5210, 240 bytes
HarrySpriteFrame19:
	INCBIN "data/bank_043/HarrySpriteFrame19.bin" ; $5300, 240 bytes
HarrySpriteFrame20:
	INCBIN "data/bank_043/HarrySpriteFrame20.bin" ; $53f0, 240 bytes
HarrySpriteFrame21:
	INCBIN "data/bank_043/HarrySpriteFrame21.bin" ; $54e0, 240 bytes
HarrySpriteFrame22:
	INCBIN "data/bank_043/HarrySpriteFrame22.bin" ; $55d0, 240 bytes
HarrySpriteFrame23:
	INCBIN "data/bank_043/HarrySpriteFrame23.bin" ; $56c0, 240 bytes
HarrySpriteFrame24:
	INCBIN "data/bank_043/HarrySpriteFrame24.bin" ; $57b0, 240 bytes
HarrySpriteFrame25:
	INCBIN "data/bank_043/HarrySpriteFrame25.bin" ; $58a0, 240 bytes
HarrySpriteFrame26:
	INCBIN "data/bank_043/HarrySpriteFrame26.bin" ; $5990, 240 bytes
HarrySpriteFrame27:
	INCBIN "data/bank_043/HarrySpriteFrame27.bin" ; $5a80, 240 bytes
HarrySpriteFrame28:
	INCBIN "data/bank_043/HarrySpriteFrame28.bin" ; $5b70, 240 bytes
HarrySpriteFrame29:
	INCBIN "data/bank_043/HarrySpriteFrame29.bin" ; $5c60, 240 bytes
HarrySpriteFrame30:
	INCBIN "data/bank_043/HarrySpriteFrame30.bin" ; $5d50, 240 bytes
HarrySpriteFrame31:
	INCBIN "data/bank_043/HarrySpriteFrame31.bin" ; $5e40, 240 bytes
HarrySpriteFrame32:
	INCBIN "data/bank_043/HarrySpriteFrame32.bin" ; $5f30, 240 bytes
HarrySpriteFrame33:
	INCBIN "data/bank_043/HarrySpriteFrame33.bin" ; $6020, 240 bytes
HarrySpriteFrame34:
	INCBIN "data/bank_043/HarrySpriteFrame34.bin" ; $6110, 240 bytes
HarrySpriteFrame35:
	INCBIN "data/bank_043/HarrySpriteFrame35.bin" ; $6200, 240 bytes
HarrySpriteFrame36:
	INCBIN "data/bank_043/HarrySpriteFrame36.bin" ; $62f0, 240 bytes
HarrySpriteFrame37:
	INCBIN "data/bank_043/HarrySpriteFrame37.bin" ; $63e0, 240 bytes
HarrySpriteFrame38:
	INCBIN "data/bank_043/HarrySpriteFrame38.bin" ; $64d0, 240 bytes
HarrySpriteFrame39:
	INCBIN "data/bank_043/HarrySpriteFrame39.bin" ; $65c0, 240 bytes
HarrySpriteFrame40:
	INCBIN "data/bank_043/HarrySpriteFrame40.bin" ; $66b0, 320 bytes
HarrySpriteFrame41:
	INCBIN "data/bank_043/HarrySpriteFrame41.bin" ; $67f0, 320 bytes
HarrySpriteFrame42:
	INCBIN "data/bank_043/HarrySpriteFrame42.bin" ; $6930, 240 bytes
HarrySpriteFrame43:
	INCBIN "data/bank_043/HarrySpriteFrame43.bin" ; $6a20, 240 bytes
HarrySpriteFrame44:
	INCBIN "data/bank_043/HarrySpriteFrame44.bin" ; $6b10, 240 bytes
HarrySpriteFrame45:
	INCBIN "data/bank_043/HarrySpriteFrame45.bin" ; $6c00, 240 bytes
HarrySpriteFrame46:
	INCBIN "data/bank_043/HarrySpriteFrame46.bin" ; $6cf0, 240 bytes
HarrySpriteFrame47:
	INCBIN "data/bank_043/HarrySpriteFrame47.bin" ; $6de0, 240 bytes
HarrySpriteFrame48:
	INCBIN "data/bank_043/HarrySpriteFrame48.bin" ; $6ed0, 240 bytes
HarrySpriteFrame49:
	INCBIN "data/bank_043/HarrySpriteFrame49.bin" ; $6fc0, 240 bytes
HarrySpriteFrame50:
	INCBIN "data/bank_043/HarrySpriteFrame50.bin" ; $70b0, 240 bytes
HarrySpriteFrame51:
	INCBIN "data/bank_043/HarrySpriteFrame51.bin" ; $71a0, 240 bytes
HarrySpriteFrame52:
	INCBIN "data/bank_043/HarrySpriteFrame52.bin" ; $7290, 240 bytes
HarrySpriteFrame53:
	INCBIN "data/bank_043/HarrySpriteFrame53.bin" ; $7380, 240 bytes
HarrySpriteFrame54:
	INCBIN "data/bank_043/HarrySpriteFrame54.bin" ; $7470, 240 bytes
HarrySpriteFrame55:
	INCBIN "data/bank_043/HarrySpriteFrame55.bin" ; $7560, 240 bytes
HarrySpriteFramesUnused:
	INCBIN "data/bank_043/HarrySpriteFramesUnused.bin" ; $7650, 1680 bytes
HarrySpriteOam:
	INCBIN "data/bank_043/HarrySpriteOam.bin" ; $7ce0, 580 bytes
HarrySpriteAnims:
	dw HarrySpriteAnim00 ; $7f24
	dw HarrySpriteAnim01 ; $7f26
	dw HarrySpriteAnim02 ; $7f28
	dw HarrySpriteAnim03 ; $7f2a
	dw HarrySpriteAnim04 ; $7f2c
	dw HarrySpriteAnim05 ; $7f2e
	dw HarrySpriteAnim06 ; $7f30
	dw HarrySpriteAnim07 ; $7f32
	dw HarrySpriteAnim08 ; $7f34
	dw HarrySpriteAnim09 ; $7f36
	dw HarrySpriteAnim10 ; $7f38
	dw HarrySpriteAnim11 ; $7f3a
	dw HarrySpriteAnim12 ; $7f3c
	dw HarrySpriteAnim13 ; $7f3e
	dw HarrySpriteAnim14 ; $7f40
	dw HarrySpriteAnim15 ; $7f42
	dw HarrySpriteAnim16 ; $7f44
	dw HarrySpriteAnim17 ; $7f46
	dw HarrySpriteAnim18 ; $7f48
HarrySpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
HarrySpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
HarrySpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
HarrySpriteAnim03:
	; $7f5d, 8 bytes (sprite_anim)
	anim_frame $17, $0c
	anim_frame $18, $1e
	anim_frame $19, $0c
	anim_loop $00
HarrySpriteAnim04:
	; $7f65, 8 bytes (sprite_anim)
	anim_frame $1a, $08
	anim_frame $1b, $08
	anim_frame $1c, $08
	anim_loop $00
HarrySpriteAnim05:
	; $7f6d, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
HarrySpriteAnim06:
	; $7f73, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
HarrySpriteAnim07:
	; $7f79, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
HarrySpriteAnim08:
	; $7f7f, 5 bytes (sprite_anim)
	anim_frame $15, $04
	anim_frame $16, $14
	anim_hold $fd
HarrySpriteAnim09:
	; $7f84, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
HarrySpriteAnim10:
	; $7f88, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
HarrySpriteAnim11:
	; $7f8c, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
HarrySpriteAnim12:
	; $7f90, 3 bytes (sprite_anim)
	anim_frame $15, $18
	anim_hold $fd
HarrySpriteAnim13:
	; $7f93, 3 bytes (sprite_anim)
	anim_frame $05, $ff
	anim_hold $fd
HarrySpriteAnim14:
	; $7f96, 3 bytes (sprite_anim)
	anim_frame $08, $ff
	anim_hold $fd
HarrySpriteAnim15:
	; $7f99, 3 bytes (sprite_anim)
	anim_frame $0b, $ff
	anim_hold $fd
HarrySpriteAnim16:
	; $7f9c, 3 bytes (sprite_anim)
	anim_frame $0e, $ff
	anim_hold $fd
HarrySpriteAnim17:
	; $7f9f, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
HarrySpriteAnim18:
	; $7fab, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fb3, 77 bytes fill to bank end (linker-padded)
