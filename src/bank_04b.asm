SECTION "ROM Bank $4b", ROMX[$4000], BANK[$4b]

	dw BCozSpriteDesc ; $4000
BCozSpriteDesc:
	dw $0007 ; $4002
	dw $0003 ; $4004
	dw BCozSpriteFrames ; $4006 frame table
	dw BCozSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw BCozSpriteOam ; $400c per-slot OAM data
BCozSpriteFrames:
	dw BCozSpriteFrame00 ; $400e
	dw BCozSpriteFrame01 ; $4010
	dw BCozSpriteFrame02 ; $4012
	dw BCozSpriteFrame03 ; $4014
	dw BCozSpriteFrame04 ; $4016
	dw BCozSpriteFrame05 ; $4018
	dw BCozSpriteFrame06 ; $401a
	dw BCozSpriteFrame07 ; $401c
	dw BCozSpriteFrame08 ; $401e
	dw BCozSpriteFrame09 ; $4020
	dw BCozSpriteFrame10 ; $4022
	dw BCozSpriteFrame01 ; $4024
	dw BCozSpriteFrame02 ; $4026
	dw BCozSpriteFrame03 ; $4028
	dw BCozSpriteFrame11 ; $402a
	dw BCozSpriteFrame12 ; $402c
	dw BCozSpriteFrame01 ; $402e
	dw BCozSpriteFrame02 ; $4030
	dw BCozSpriteFrame03 ; $4032
	dw BCozSpriteFrame13 ; $4034
	dw BCozSpriteFrame14 ; $4036
	dw BCozSpriteFrame06 ; $4038
	dw BCozSpriteFrame07 ; $403a
	dw BCozSpriteFrame08 ; $403c
	dw BCozSpriteFrame15 ; $403e
	dw BCozSpriteFrame16 ; $4040
	dw BCozSpriteFrame16 ; $4042
	dw BCozSpriteFrame16 ; $4044
	dw BCozSpriteFrame17 ; $4046
	dw BCozSpriteFrame17 ; $4048
	dw BCozSpriteFrame18 ; $404a
	dw BCozSpriteFrame18 ; $404c
	dw BCozSpriteFrame18 ; $404e
	dw BCozSpriteFrame19 ; $4050
	dw BCozSpriteFrame19 ; $4052
	dw BCozSpriteFrame20 ; $4054
	dw BCozSpriteFrame20 ; $4056
	dw BCozSpriteFrame20 ; $4058
	dw BCozSpriteFrame21 ; $405a
	dw BCozSpriteFrame21 ; $405c
	dw BCozSpriteFrame22 ; $405e
	dw BCozSpriteFrame22 ; $4060
	dw BCozSpriteFrame22 ; $4062
	dw BCozSpriteFrame23 ; $4064
	dw BCozSpriteFrame23 ; $4066
	dw BCozSpriteFrame24 ; $4068
	dw BCozSpriteFrame24 ; $406a
	dw BCozSpriteFrame24 ; $406c
	dw BCozSpriteFrame25 ; $406e
	dw BCozSpriteFrame25 ; $4070
	dw BCozSpriteFrame26 ; $4072
	dw BCozSpriteFrame26 ; $4074
	dw BCozSpriteFrame26 ; $4076
	dw BCozSpriteFrame27 ; $4078
	dw BCozSpriteFrame27 ; $407a
	dw BCozSpriteFrame28 ; $407c
	dw BCozSpriteFrame28 ; $407e
	dw BCozSpriteFrame28 ; $4080
	dw BCozSpriteFrame29 ; $4082
	dw BCozSpriteFrame29 ; $4084
	dw BCozSpriteFrame30 ; $4086
	dw BCozSpriteFrame30 ; $4088
	dw BCozSpriteFrame30 ; $408a
	dw BCozSpriteFrame31 ; $408c
	dw BCozSpriteFrame31 ; $408e
	dw BCozSpriteFrame32 ; $4090
	dw BCozSpriteFrame32 ; $4092
	dw BCozSpriteFrame32 ; $4094
	dw BCozSpriteFrame33 ; $4096
	dw BCozSpriteFrame33 ; $4098
	dw BCozSpriteFrame34 ; $409a
	dw BCozSpriteFrame34 ; $409c
	dw BCozSpriteFrame34 ; $409e
	dw BCozSpriteFrame35 ; $40a0
	dw BCozSpriteFrame35 ; $40a2
	dw BCozSpriteFrame36 ; $40a4
	dw BCozSpriteFrame36 ; $40a6
	dw BCozSpriteFrame36 ; $40a8
	dw BCozSpriteFrame37 ; $40aa
	dw BCozSpriteFrame37 ; $40ac
	dw BCozSpriteFrame38 ; $40ae
	dw BCozSpriteFrame38 ; $40b0
	dw BCozSpriteFrame38 ; $40b2
	dw BCozSpriteFrame39 ; $40b4
	dw BCozSpriteFrame39 ; $40b6
	dw BCozSpriteFrame40 ; $40b8
	dw BCozSpriteFrame40 ; $40ba
	dw BCozSpriteFrame40 ; $40bc
	dw BCozSpriteFrame41 ; $40be
	dw BCozSpriteFrame41 ; $40c0
	dw BCozSpriteFrame42 ; $40c2
	dw BCozSpriteFrame42 ; $40c4
	dw BCozSpriteFrame42 ; $40c6
	dw BCozSpriteFrame42 ; $40c8
	dw BCozSpriteFrame42 ; $40ca
	dw BCozSpriteFrame43 ; $40cc
	dw BCozSpriteFrame43 ; $40ce
	dw BCozSpriteFrame43 ; $40d0
	dw BCozSpriteFrame43 ; $40d2
	dw BCozSpriteFrame43 ; $40d4
	dw BCozSpriteFrame44 ; $40d6
	dw BCozSpriteFrame44 ; $40d8
	dw BCozSpriteFrame44 ; $40da
	dw BCozSpriteFrame45 ; $40dc
	dw BCozSpriteFrame45 ; $40de
	dw BCozSpriteFrame46 ; $40e0
	dw BCozSpriteFrame46 ; $40e2
	dw BCozSpriteFrame46 ; $40e4
	dw BCozSpriteFrame47 ; $40e6
	dw BCozSpriteFrame47 ; $40e8
	dw BCozSpriteFrame48 ; $40ea
	dw BCozSpriteFrame48 ; $40ec
	dw BCozSpriteFrame48 ; $40ee
	dw BCozSpriteFrame49 ; $40f0
	dw BCozSpriteFrame49 ; $40f2
	dw BCozSpriteFrame50 ; $40f4
	dw BCozSpriteFrame50 ; $40f6
	dw BCozSpriteFrame50 ; $40f8
	dw BCozSpriteFrame50 ; $40fa
	dw BCozSpriteFrame50 ; $40fc
	dw BCozSpriteFrame51 ; $40fe
	dw BCozSpriteFrame51 ; $4100
	dw BCozSpriteFrame51 ; $4102
	dw BCozSpriteFrame51 ; $4104
	dw BCozSpriteFrame51 ; $4106
	dw BCozSpriteFrame52 ; $4108
	dw BCozSpriteFrame52 ; $410a
	dw BCozSpriteFrame52 ; $410c
	dw BCozSpriteFrame52 ; $410e
	dw BCozSpriteFrame52 ; $4110
	dw BCozSpriteFrame53 ; $4112
	dw BCozSpriteFrame53 ; $4114
	dw BCozSpriteFrame53 ; $4116
	dw BCozSpriteFrame53 ; $4118
	dw BCozSpriteFrame53 ; $411a
	dw BCozSpriteFrame54 ; $411c
	dw BCozSpriteFrame54 ; $411e
	dw BCozSpriteFrame54 ; $4120
	dw BCozSpriteFrame54 ; $4122
	dw BCozSpriteFrame54 ; $4124
	dw BCozSpriteFrame55 ; $4126
	dw BCozSpriteFrame55 ; $4128
	dw BCozSpriteFrame55 ; $412a
	dw BCozSpriteFrame55 ; $412c
	dw BCozSpriteFrame55 ; $412e
BCozSpriteFrame00:
	INCBIN "data/bank_04b/BCozSpriteFrame00.bin" ; $4130, 240 bytes
BCozSpriteFrame01:
	INCBIN "data/bank_04b/BCozSpriteFrame01.bin" ; $4220, 240 bytes
BCozSpriteFrame02:
	INCBIN "data/bank_04b/BCozSpriteFrame02.bin" ; $4310, 240 bytes
BCozSpriteFrame03:
	INCBIN "data/bank_04b/BCozSpriteFrame03.bin" ; $4400, 240 bytes
BCozSpriteFrame04:
	INCBIN "data/bank_04b/BCozSpriteFrame04.bin" ; $44f0, 240 bytes
BCozSpriteFrame05:
	INCBIN "data/bank_04b/BCozSpriteFrame05.bin" ; $45e0, 240 bytes
BCozSpriteFrame06:
	INCBIN "data/bank_04b/BCozSpriteFrame06.bin" ; $46d0, 240 bytes
BCozSpriteFrame07:
	INCBIN "data/bank_04b/BCozSpriteFrame07.bin" ; $47c0, 240 bytes
BCozSpriteFrame08:
	INCBIN "data/bank_04b/BCozSpriteFrame08.bin" ; $48b0, 240 bytes
BCozSpriteFrame09:
	INCBIN "data/bank_04b/BCozSpriteFrame09.bin" ; $49a0, 240 bytes
BCozSpriteFrame10:
	INCBIN "data/bank_04b/BCozSpriteFrame10.bin" ; $4a90, 240 bytes
BCozSpriteFrame11:
	INCBIN "data/bank_04b/BCozSpriteFrame11.bin" ; $4b80, 240 bytes
BCozSpriteFrame12:
	INCBIN "data/bank_04b/BCozSpriteFrame12.bin" ; $4c70, 240 bytes
BCozSpriteFrame13:
	INCBIN "data/bank_04b/BCozSpriteFrame13.bin" ; $4d60, 240 bytes
BCozSpriteFrame14:
	INCBIN "data/bank_04b/BCozSpriteFrame14.bin" ; $4e50, 240 bytes
BCozSpriteFrame15:
	INCBIN "data/bank_04b/BCozSpriteFrame15.bin" ; $4f40, 240 bytes
BCozSpriteFrame16:
	INCBIN "data/bank_04b/BCozSpriteFrame16.bin" ; $5030, 240 bytes
BCozSpriteFrame17:
	INCBIN "data/bank_04b/BCozSpriteFrame17.bin" ; $5120, 240 bytes
BCozSpriteFrame18:
	INCBIN "data/bank_04b/BCozSpriteFrame18.bin" ; $5210, 240 bytes
BCozSpriteFrame19:
	INCBIN "data/bank_04b/BCozSpriteFrame19.bin" ; $5300, 240 bytes
BCozSpriteFrame20:
	INCBIN "data/bank_04b/BCozSpriteFrame20.bin" ; $53f0, 240 bytes
BCozSpriteFrame21:
	INCBIN "data/bank_04b/BCozSpriteFrame21.bin" ; $54e0, 240 bytes
BCozSpriteFrame22:
	INCBIN "data/bank_04b/BCozSpriteFrame22.bin" ; $55d0, 240 bytes
BCozSpriteFrame23:
	INCBIN "data/bank_04b/BCozSpriteFrame23.bin" ; $56c0, 240 bytes
BCozSpriteFrame24:
	INCBIN "data/bank_04b/BCozSpriteFrame24.bin" ; $57b0, 240 bytes
BCozSpriteFrame25:
	INCBIN "data/bank_04b/BCozSpriteFrame25.bin" ; $58a0, 240 bytes
BCozSpriteFrame26:
	INCBIN "data/bank_04b/BCozSpriteFrame26.bin" ; $5990, 240 bytes
BCozSpriteFrame27:
	INCBIN "data/bank_04b/BCozSpriteFrame27.bin" ; $5a80, 240 bytes
BCozSpriteFrame28:
	INCBIN "data/bank_04b/BCozSpriteFrame28.bin" ; $5b70, 240 bytes
BCozSpriteFrame29:
	INCBIN "data/bank_04b/BCozSpriteFrame29.bin" ; $5c60, 240 bytes
BCozSpriteFrame30:
	INCBIN "data/bank_04b/BCozSpriteFrame30.bin" ; $5d50, 240 bytes
BCozSpriteFrame31:
	INCBIN "data/bank_04b/BCozSpriteFrame31.bin" ; $5e40, 240 bytes
BCozSpriteFrame32:
	INCBIN "data/bank_04b/BCozSpriteFrame32.bin" ; $5f30, 240 bytes
BCozSpriteFrame33:
	INCBIN "data/bank_04b/BCozSpriteFrame33.bin" ; $6020, 240 bytes
BCozSpriteFrame34:
	INCBIN "data/bank_04b/BCozSpriteFrame34.bin" ; $6110, 240 bytes
BCozSpriteFrame35:
	INCBIN "data/bank_04b/BCozSpriteFrame35.bin" ; $6200, 240 bytes
BCozSpriteFrame36:
	INCBIN "data/bank_04b/BCozSpriteFrame36.bin" ; $62f0, 240 bytes
BCozSpriteFrame37:
	INCBIN "data/bank_04b/BCozSpriteFrame37.bin" ; $63e0, 240 bytes
BCozSpriteFrame38:
	INCBIN "data/bank_04b/BCozSpriteFrame38.bin" ; $64d0, 240 bytes
BCozSpriteFrame39:
	INCBIN "data/bank_04b/BCozSpriteFrame39.bin" ; $65c0, 240 bytes
BCozSpriteFrame40:
	INCBIN "data/bank_04b/BCozSpriteFrame40.bin" ; $66b0, 320 bytes
BCozSpriteFrame41:
	INCBIN "data/bank_04b/BCozSpriteFrame41.bin" ; $67f0, 320 bytes
BCozSpriteFrame42:
	INCBIN "data/bank_04b/BCozSpriteFrame42.bin" ; $6930, 240 bytes
BCozSpriteFrame43:
	INCBIN "data/bank_04b/BCozSpriteFrame43.bin" ; $6a20, 240 bytes
BCozSpriteFrame44:
	INCBIN "data/bank_04b/BCozSpriteFrame44.bin" ; $6b10, 240 bytes
BCozSpriteFrame45:
	INCBIN "data/bank_04b/BCozSpriteFrame45.bin" ; $6c00, 240 bytes
BCozSpriteFrame46:
	INCBIN "data/bank_04b/BCozSpriteFrame46.bin" ; $6cf0, 240 bytes
BCozSpriteFrame47:
	INCBIN "data/bank_04b/BCozSpriteFrame47.bin" ; $6de0, 240 bytes
BCozSpriteFrame48:
	INCBIN "data/bank_04b/BCozSpriteFrame48.bin" ; $6ed0, 240 bytes
BCozSpriteFrame49:
	INCBIN "data/bank_04b/BCozSpriteFrame49.bin" ; $6fc0, 240 bytes
BCozSpriteFrame50:
	INCBIN "data/bank_04b/BCozSpriteFrame50.bin" ; $70b0, 240 bytes
BCozSpriteFrame51:
	INCBIN "data/bank_04b/BCozSpriteFrame51.bin" ; $71a0, 240 bytes
BCozSpriteFrame52:
	INCBIN "data/bank_04b/BCozSpriteFrame52.bin" ; $7290, 240 bytes
BCozSpriteFrame53:
	INCBIN "data/bank_04b/BCozSpriteFrame53.bin" ; $7380, 240 bytes
BCozSpriteFrame54:
	INCBIN "data/bank_04b/BCozSpriteFrame54.bin" ; $7470, 240 bytes
BCozSpriteFrame55:
	INCBIN "data/bank_04b/BCozSpriteFrame55.bin" ; $7560, 240 bytes
BCozSpriteFramesUnused:
	INCBIN "data/bank_04b/BCozSpriteFramesUnused.bin" ; $7650, 1680 bytes
BCozSpriteOam:
	INCBIN "data/bank_04b/BCozSpriteOam.bin" ; $7ce0, 580 bytes
BCozSpriteAnims:
	dw BCozSpriteAnim00 ; $7f24
	dw BCozSpriteAnim01 ; $7f26
	dw BCozSpriteAnim02 ; $7f28
	dw BCozSpriteAnim03 ; $7f2a
	dw BCozSpriteAnim04 ; $7f2c
	dw BCozSpriteAnim05 ; $7f2e
	dw BCozSpriteAnim06 ; $7f30
	dw BCozSpriteAnim07 ; $7f32
	dw BCozSpriteAnim08 ; $7f34
	dw BCozSpriteAnim09 ; $7f36
	dw BCozSpriteAnim10 ; $7f38
	dw BCozSpriteAnim11 ; $7f3a
	dw BCozSpriteAnim12 ; $7f3c
	dw BCozSpriteAnim13 ; $7f3e
	dw BCozSpriteAnim14 ; $7f40
	dw BCozSpriteAnim15 ; $7f42
	dw BCozSpriteAnim16 ; $7f44
	dw BCozSpriteAnim17 ; $7f46
	dw BCozSpriteAnim18 ; $7f48
BCozSpriteAnim00:
	; $7f4a, 3 bytes (sprite_anim)
	anim_frame $00, $ff
	anim_hold $fd
BCozSpriteAnim01:
	; $7f4d, 10 bytes (sprite_anim)
	anim_frame $02, $0c
	anim_frame $04, $06
	anim_frame $03, $0c
	anim_frame $04, $07
	anim_loop $00
BCozSpriteAnim02:
	; $7f57, 6 bytes (sprite_anim)
	anim_frame $00, $0a
	anim_frame $01, $0a
	anim_loop $00
BCozSpriteAnim03:
	; $7f5d, 34 bytes (sprite_anim)
	anim_flip $00
	anim_frame $17, $28
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_flip $20
	anim_frame $17, $28
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_frame $18, $0a
	anim_frame $19, $0a
	anim_loop $00
BCozSpriteAnim04:
	; $7f7f, 8 bytes (sprite_anim)
	anim_frame $1a, $28
	anim_frame $1b, $14
	anim_frame $1c, $64
	anim_loop $00
BCozSpriteAnim05:
	; $7f87, 6 bytes (sprite_anim)
	anim_frame $06, $04
	anim_frame $07, $17
	anim_set $01
BCozSpriteAnim06:
	; $7f8d, 6 bytes (sprite_anim)
	anim_frame $09, $04
	anim_frame $0a, $17
	anim_set $01
BCozSpriteAnim07:
	; $7f93, 6 bytes (sprite_anim)
	anim_frame $0c, $04
	anim_frame $0d, $14
	anim_set $01
BCozSpriteAnim08:
	; $7f99, 5 bytes (sprite_anim)
	anim_frame $15, $04
	anim_frame $16, $14
	anim_hold $fd
BCozSpriteAnim09:
	; $7f9e, 4 bytes (sprite_anim)
	anim_frame $06, $19
	anim_set $01
BCozSpriteAnim10:
	; $7fa2, 4 bytes (sprite_anim)
	anim_frame $09, $19
	anim_set $01
BCozSpriteAnim11:
	; $7fa6, 4 bytes (sprite_anim)
	anim_frame $0c, $19
	anim_set $01
BCozSpriteAnim12:
	; $7faa, 3 bytes (sprite_anim)
	anim_frame $15, $18
	anim_hold $fd
BCozSpriteAnim13:
	; $7fad, 3 bytes (sprite_anim)
	anim_frame $05, $ff
	anim_hold $fd
BCozSpriteAnim14:
	; $7fb0, 3 bytes (sprite_anim)
	anim_frame $08, $ff
	anim_hold $fd
BCozSpriteAnim15:
	; $7fb3, 3 bytes (sprite_anim)
	anim_frame $0b, $ff
	anim_hold $fd
BCozSpriteAnim16:
	; $7fb6, 3 bytes (sprite_anim)
	anim_frame $0e, $ff
	anim_hold $fd
BCozSpriteAnim17:
	; $7fb9, 12 bytes (sprite_anim)
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_frame $10, $07
	anim_frame $0f, $07
	anim_set $10
BCozSpriteAnim18:
	; $7fc5, 8 bytes (sprite_anim)
	anim_frame $11, $12
	anim_frame $12, $14
	anim_frame $13, $16
	anim_set $01
	; $7fcd, 51 bytes fill to bank end (linker-padded)
