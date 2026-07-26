SECTION "ROM Bank $45", ROMX[$4000], BANK[$45]

	dw MarkSpriteDesc ; $4000
MarkSpriteDesc:
	dw $0004 ; $4002
	dw $0003 ; $4004
	dw MarkSpriteFrames ; $4006 frame table
	dw MarkSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw Data_45_7ce0 ; $400c per-slot OAM data
MarkSpriteFrames:
	dw MarkSpriteFrame00 ; $400e
	dw MarkSpriteFrame01 ; $4010
	dw MarkSpriteFrame02 ; $4012
	dw MarkSpriteFrame03 ; $4014
	dw MarkSpriteFrame04 ; $4016
	dw MarkSpriteFrame05 ; $4018
	dw MarkSpriteFrame06 ; $401a
	dw MarkSpriteFrame07 ; $401c
	dw MarkSpriteFrame08 ; $401e
	dw MarkSpriteFrame09 ; $4020
	dw MarkSpriteFrame10 ; $4022
	dw MarkSpriteFrame01 ; $4024
	dw MarkSpriteFrame02 ; $4026
	dw MarkSpriteFrame03 ; $4028
	dw MarkSpriteFrame11 ; $402a
	dw MarkSpriteFrame12 ; $402c
	dw MarkSpriteFrame01 ; $402e
	dw MarkSpriteFrame02 ; $4030
	dw MarkSpriteFrame03 ; $4032
	dw MarkSpriteFrame13 ; $4034
	dw MarkSpriteFrame14 ; $4036
	dw MarkSpriteFrame06 ; $4038
	dw MarkSpriteFrame07 ; $403a
	dw MarkSpriteFrame08 ; $403c
	dw MarkSpriteFrame15 ; $403e
	dw MarkSpriteFrame16 ; $4040
	dw MarkSpriteFrame16 ; $4042
	dw MarkSpriteFrame16 ; $4044
	dw MarkSpriteFrame17 ; $4046
	dw MarkSpriteFrame17 ; $4048
	dw MarkSpriteFrame18 ; $404a
	dw MarkSpriteFrame18 ; $404c
	dw MarkSpriteFrame18 ; $404e
	dw MarkSpriteFrame19 ; $4050
	dw MarkSpriteFrame19 ; $4052
	dw MarkSpriteFrame20 ; $4054
	dw MarkSpriteFrame20 ; $4056
	dw MarkSpriteFrame20 ; $4058
	dw MarkSpriteFrame21 ; $405a
	dw MarkSpriteFrame21 ; $405c
	dw MarkSpriteFrame22 ; $405e
	dw MarkSpriteFrame22 ; $4060
	dw MarkSpriteFrame22 ; $4062
	dw MarkSpriteFrame23 ; $4064
	dw MarkSpriteFrame23 ; $4066
	dw MarkSpriteFrame24 ; $4068
	dw MarkSpriteFrame24 ; $406a
	dw MarkSpriteFrame24 ; $406c
	dw MarkSpriteFrame25 ; $406e
	dw MarkSpriteFrame25 ; $4070
	dw MarkSpriteFrame26 ; $4072
	dw MarkSpriteFrame26 ; $4074
	dw MarkSpriteFrame26 ; $4076
	dw MarkSpriteFrame27 ; $4078
	dw MarkSpriteFrame27 ; $407a
	dw MarkSpriteFrame28 ; $407c
	dw MarkSpriteFrame28 ; $407e
	dw MarkSpriteFrame28 ; $4080
	dw MarkSpriteFrame29 ; $4082
	dw MarkSpriteFrame29 ; $4084
	dw MarkSpriteFrame30 ; $4086
	dw MarkSpriteFrame30 ; $4088
	dw MarkSpriteFrame30 ; $408a
	dw MarkSpriteFrame31 ; $408c
	dw MarkSpriteFrame31 ; $408e
	dw MarkSpriteFrame32 ; $4090
	dw MarkSpriteFrame32 ; $4092
	dw MarkSpriteFrame32 ; $4094
	dw MarkSpriteFrame33 ; $4096
	dw MarkSpriteFrame33 ; $4098
	dw MarkSpriteFrame34 ; $409a
	dw MarkSpriteFrame34 ; $409c
	dw MarkSpriteFrame34 ; $409e
	dw MarkSpriteFrame35 ; $40a0
	dw MarkSpriteFrame35 ; $40a2
	dw MarkSpriteFrame36 ; $40a4
	dw MarkSpriteFrame36 ; $40a6
	dw MarkSpriteFrame36 ; $40a8
	dw MarkSpriteFrame37 ; $40aa
	dw MarkSpriteFrame37 ; $40ac
	dw MarkSpriteFrame38 ; $40ae
	dw MarkSpriteFrame38 ; $40b0
	dw MarkSpriteFrame38 ; $40b2
	dw MarkSpriteFrame39 ; $40b4
	dw MarkSpriteFrame39 ; $40b6
	dw MarkSpriteFrame40 ; $40b8
	dw MarkSpriteFrame40 ; $40ba
	dw MarkSpriteFrame40 ; $40bc
	dw MarkSpriteFrame41 ; $40be
	dw MarkSpriteFrame41 ; $40c0
	dw MarkSpriteFrame42 ; $40c2
	dw MarkSpriteFrame42 ; $40c4
	dw MarkSpriteFrame42 ; $40c6
	dw MarkSpriteFrame42 ; $40c8
	dw MarkSpriteFrame42 ; $40ca
	dw MarkSpriteFrame43 ; $40cc
	dw MarkSpriteFrame43 ; $40ce
	dw MarkSpriteFrame43 ; $40d0
	dw MarkSpriteFrame43 ; $40d2
	dw MarkSpriteFrame43 ; $40d4
	dw MarkSpriteFrame44 ; $40d6
	dw MarkSpriteFrame44 ; $40d8
	dw MarkSpriteFrame44 ; $40da
	dw MarkSpriteFrame45 ; $40dc
	dw MarkSpriteFrame45 ; $40de
	dw MarkSpriteFrame46 ; $40e0
	dw MarkSpriteFrame46 ; $40e2
	dw MarkSpriteFrame46 ; $40e4
	dw MarkSpriteFrame47 ; $40e6
	dw MarkSpriteFrame47 ; $40e8
	dw MarkSpriteFrame48 ; $40ea
	dw MarkSpriteFrame48 ; $40ec
	dw MarkSpriteFrame48 ; $40ee
	dw MarkSpriteFrame49 ; $40f0
	dw MarkSpriteFrame49 ; $40f2
	dw MarkSpriteFrame50 ; $40f4
	dw MarkSpriteFrame50 ; $40f6
	dw MarkSpriteFrame50 ; $40f8
	dw MarkSpriteFrame50 ; $40fa
	dw MarkSpriteFrame50 ; $40fc
	dw MarkSpriteFrame51 ; $40fe
	dw MarkSpriteFrame51 ; $4100
	dw MarkSpriteFrame51 ; $4102
	dw MarkSpriteFrame51 ; $4104
	dw MarkSpriteFrame51 ; $4106
	dw MarkSpriteFrame52 ; $4108
	dw MarkSpriteFrame52 ; $410a
	dw MarkSpriteFrame52 ; $410c
	dw MarkSpriteFrame52 ; $410e
	dw MarkSpriteFrame52 ; $4110
	dw MarkSpriteFrame53 ; $4112
	dw MarkSpriteFrame53 ; $4114
	dw MarkSpriteFrame53 ; $4116
	dw MarkSpriteFrame53 ; $4118
	dw MarkSpriteFrame53 ; $411a
	dw MarkSpriteFrame54 ; $411c
	dw MarkSpriteFrame54 ; $411e
	dw MarkSpriteFrame54 ; $4120
	dw MarkSpriteFrame54 ; $4122
	dw MarkSpriteFrame54 ; $4124
	dw MarkSpriteFrame55 ; $4126
	dw MarkSpriteFrame55 ; $4128
	dw MarkSpriteFrame55 ; $412a
	dw MarkSpriteFrame55 ; $412c
	dw MarkSpriteFrame55 ; $412e
MarkSpriteFrame00:
	INCBIN "data/bank_045/d_4130.bin" ; $4130, 240 bytes
MarkSpriteFrame01:
	INCBIN "data/bank_045/d_4220.bin" ; $4220, 240 bytes
MarkSpriteFrame02:
	INCBIN "data/bank_045/d_4310.bin" ; $4310, 240 bytes
MarkSpriteFrame03:
	INCBIN "data/bank_045/d_4400.bin" ; $4400, 240 bytes
MarkSpriteFrame04:
	INCBIN "data/bank_045/d_44f0.bin" ; $44f0, 240 bytes
MarkSpriteFrame05:
	INCBIN "data/bank_045/d_45e0.bin" ; $45e0, 240 bytes
MarkSpriteFrame06:
	INCBIN "data/bank_045/d_46d0.bin" ; $46d0, 240 bytes
MarkSpriteFrame07:
	INCBIN "data/bank_045/d_47c0.bin" ; $47c0, 240 bytes
MarkSpriteFrame08:
	INCBIN "data/bank_045/d_48b0.bin" ; $48b0, 240 bytes
MarkSpriteFrame09:
	INCBIN "data/bank_045/d_49a0.bin" ; $49a0, 240 bytes
MarkSpriteFrame10:
	INCBIN "data/bank_045/d_4a90.bin" ; $4a90, 240 bytes
MarkSpriteFrame11:
	INCBIN "data/bank_045/d_4b80.bin" ; $4b80, 240 bytes
MarkSpriteFrame12:
	INCBIN "data/bank_045/d_4c70.bin" ; $4c70, 240 bytes
MarkSpriteFrame13:
	INCBIN "data/bank_045/d_4d60.bin" ; $4d60, 240 bytes
MarkSpriteFrame14:
	INCBIN "data/bank_045/d_4e50.bin" ; $4e50, 240 bytes
MarkSpriteFrame15:
	INCBIN "data/bank_045/d_4f40.bin" ; $4f40, 240 bytes
MarkSpriteFrame16:
	INCBIN "data/bank_045/d_5030.bin" ; $5030, 240 bytes
MarkSpriteFrame17:
	INCBIN "data/bank_045/d_5120.bin" ; $5120, 240 bytes
MarkSpriteFrame18:
	INCBIN "data/bank_045/d_5210.bin" ; $5210, 240 bytes
MarkSpriteFrame19:
	INCBIN "data/bank_045/d_5300.bin" ; $5300, 240 bytes
MarkSpriteFrame20:
	INCBIN "data/bank_045/d_53f0.bin" ; $53f0, 240 bytes
MarkSpriteFrame21:
	INCBIN "data/bank_045/d_54e0.bin" ; $54e0, 240 bytes
MarkSpriteFrame22:
	INCBIN "data/bank_045/d_55d0.bin" ; $55d0, 240 bytes
MarkSpriteFrame23:
	INCBIN "data/bank_045/d_56c0.bin" ; $56c0, 240 bytes
MarkSpriteFrame24:
	INCBIN "data/bank_045/d_57b0.bin" ; $57b0, 240 bytes
MarkSpriteFrame25:
	INCBIN "data/bank_045/d_58a0.bin" ; $58a0, 240 bytes
MarkSpriteFrame26:
	INCBIN "data/bank_045/d_5990.bin" ; $5990, 240 bytes
MarkSpriteFrame27:
	INCBIN "data/bank_045/d_5a80.bin" ; $5a80, 240 bytes
MarkSpriteFrame28:
	INCBIN "data/bank_045/d_5b70.bin" ; $5b70, 240 bytes
MarkSpriteFrame29:
	INCBIN "data/bank_045/d_5c60.bin" ; $5c60, 240 bytes
MarkSpriteFrame30:
	INCBIN "data/bank_045/d_5d50.bin" ; $5d50, 240 bytes
MarkSpriteFrame31:
	INCBIN "data/bank_045/d_5e40.bin" ; $5e40, 240 bytes
MarkSpriteFrame32:
	INCBIN "data/bank_045/d_5f30.bin" ; $5f30, 240 bytes
MarkSpriteFrame33:
	INCBIN "data/bank_045/d_6020.bin" ; $6020, 240 bytes
MarkSpriteFrame34:
	INCBIN "data/bank_045/d_6110.bin" ; $6110, 240 bytes
MarkSpriteFrame35:
	INCBIN "data/bank_045/d_6200.bin" ; $6200, 240 bytes
MarkSpriteFrame36:
	INCBIN "data/bank_045/d_62f0.bin" ; $62f0, 240 bytes
MarkSpriteFrame37:
	INCBIN "data/bank_045/d_63e0.bin" ; $63e0, 240 bytes
MarkSpriteFrame38:
	INCBIN "data/bank_045/d_64d0.bin" ; $64d0, 240 bytes
MarkSpriteFrame39:
	INCBIN "data/bank_045/d_65c0.bin" ; $65c0, 240 bytes
MarkSpriteFrame40:
	INCBIN "data/bank_045/d_66b0.bin" ; $66b0, 320 bytes
MarkSpriteFrame41:
	INCBIN "data/bank_045/d_67f0.bin" ; $67f0, 320 bytes
MarkSpriteFrame42:
	INCBIN "data/bank_045/d_6930.bin" ; $6930, 240 bytes
MarkSpriteFrame43:
	INCBIN "data/bank_045/d_6a20.bin" ; $6a20, 240 bytes
MarkSpriteFrame44:
	INCBIN "data/bank_045/d_6b10.bin" ; $6b10, 240 bytes
MarkSpriteFrame45:
	INCBIN "data/bank_045/d_6c00.bin" ; $6c00, 240 bytes
MarkSpriteFrame46:
	INCBIN "data/bank_045/d_6cf0.bin" ; $6cf0, 240 bytes
MarkSpriteFrame47:
	INCBIN "data/bank_045/d_6de0.bin" ; $6de0, 240 bytes
MarkSpriteFrame48:
	INCBIN "data/bank_045/d_6ed0.bin" ; $6ed0, 240 bytes
MarkSpriteFrame49:
	INCBIN "data/bank_045/d_6fc0.bin" ; $6fc0, 240 bytes
MarkSpriteFrame50:
	INCBIN "data/bank_045/d_70b0.bin" ; $70b0, 240 bytes
MarkSpriteFrame51:
	INCBIN "data/bank_045/d_71a0.bin" ; $71a0, 240 bytes
MarkSpriteFrame52:
	INCBIN "data/bank_045/d_7290.bin" ; $7290, 240 bytes
MarkSpriteFrame53:
	INCBIN "data/bank_045/d_7380.bin" ; $7380, 240 bytes
MarkSpriteFrame54:
	INCBIN "data/bank_045/d_7470.bin" ; $7470, 240 bytes
MarkSpriteFrame55:
	INCBIN "data/bank_045/d_7560.bin" ; $7560, 240 bytes
Data_45_7650:
	INCBIN "data/bank_045/d_7650.bin" ; $7650, 1680 bytes
Data_45_7ce0:
	INCBIN "data/bank_045/d_7ce0.bin" ; $7ce0, 580 bytes
MarkSpriteAnims:
	dw MarkSpriteAnim00 ; $7f24
	dw MarkSpriteAnim01 ; $7f26
	dw MarkSpriteAnim02 ; $7f28
	dw MarkSpriteAnim03 ; $7f2a
	dw MarkSpriteAnim04 ; $7f2c
	dw MarkSpriteAnim05 ; $7f2e
	dw MarkSpriteAnim06 ; $7f30
	dw MarkSpriteAnim07 ; $7f32
	dw MarkSpriteAnim08 ; $7f34
	dw MarkSpriteAnim09 ; $7f36
	dw MarkSpriteAnim10 ; $7f38
	dw MarkSpriteAnim11 ; $7f3a
	dw MarkSpriteAnim12 ; $7f3c
	dw MarkSpriteAnim13 ; $7f3e
	dw MarkSpriteAnim14 ; $7f40
	dw MarkSpriteAnim15 ; $7f42
	dw MarkSpriteAnim16 ; $7f44
	dw MarkSpriteAnim17 ; $7f46
	dw MarkSpriteAnim18 ; $7f48
MarkSpriteAnim00:
	INCBIN "data/bank_045/d_7f4a.bin" ; $7f4a, 3 bytes
MarkSpriteAnim01:
	INCBIN "data/bank_045/d_7f4d.bin" ; $7f4d, 10 bytes
MarkSpriteAnim02:
	INCBIN "data/bank_045/d_7f57.bin" ; $7f57, 6 bytes
MarkSpriteAnim03:
	INCBIN "data/bank_045/d_7f5d.bin" ; $7f5d, 10 bytes
MarkSpriteAnim04:
	INCBIN "data/bank_045/d_7f67.bin" ; $7f67, 8 bytes
MarkSpriteAnim05:
	INCBIN "data/bank_045/d_7f6f.bin" ; $7f6f, 6 bytes
MarkSpriteAnim06:
	INCBIN "data/bank_045/d_7f75.bin" ; $7f75, 6 bytes
MarkSpriteAnim07:
	INCBIN "data/bank_045/d_7f7b.bin" ; $7f7b, 6 bytes
MarkSpriteAnim08:
	INCBIN "data/bank_045/d_7f81.bin" ; $7f81, 5 bytes
MarkSpriteAnim09:
	INCBIN "data/bank_045/d_7f86.bin" ; $7f86, 4 bytes
MarkSpriteAnim10:
	INCBIN "data/bank_045/d_7f8a.bin" ; $7f8a, 4 bytes
MarkSpriteAnim11:
	INCBIN "data/bank_045/d_7f8e.bin" ; $7f8e, 4 bytes
MarkSpriteAnim12:
	INCBIN "data/bank_045/d_7f92.bin" ; $7f92, 3 bytes
MarkSpriteAnim13:
	INCBIN "data/bank_045/d_7f95.bin" ; $7f95, 3 bytes
MarkSpriteAnim14:
	INCBIN "data/bank_045/d_7f98.bin" ; $7f98, 3 bytes
MarkSpriteAnim15:
	INCBIN "data/bank_045/d_7f9b.bin" ; $7f9b, 3 bytes
MarkSpriteAnim16:
	INCBIN "data/bank_045/d_7f9e.bin" ; $7f9e, 3 bytes
MarkSpriteAnim17:
	INCBIN "data/bank_045/d_7fa1.bin" ; $7fa1, 12 bytes
MarkSpriteAnim18:
	INCBIN "data/bank_045/d_7fad.bin" ; $7fad, 8 bytes
	; $7fb5, 75 bytes fill to bank end (linker-padded)
