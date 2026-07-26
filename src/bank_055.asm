SECTION "ROM Bank $55", ROMX[$4000], BANK[$55]

	dw WarioSpriteDesc ; $4000
WarioSpriteDesc:
	dw $0005 ; $4002
	dw $0003 ; $4004
	dw WarioSpriteFrames ; $4006 frame table
	dw WarioSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw Data_55_7ce0 ; $400c per-slot OAM data
WarioSpriteFrames:
	dw WarioSpriteFrame00 ; $400e
	dw WarioSpriteFrame01 ; $4010
	dw WarioSpriteFrame02 ; $4012
	dw WarioSpriteFrame03 ; $4014
	dw WarioSpriteFrame04 ; $4016
	dw WarioSpriteFrame05 ; $4018
	dw WarioSpriteFrame06 ; $401a
	dw WarioSpriteFrame07 ; $401c
	dw WarioSpriteFrame08 ; $401e
	dw WarioSpriteFrame09 ; $4020
	dw WarioSpriteFrame10 ; $4022
	dw WarioSpriteFrame01 ; $4024
	dw WarioSpriteFrame02 ; $4026
	dw WarioSpriteFrame03 ; $4028
	dw WarioSpriteFrame11 ; $402a
	dw WarioSpriteFrame12 ; $402c
	dw WarioSpriteFrame01 ; $402e
	dw WarioSpriteFrame02 ; $4030
	dw WarioSpriteFrame03 ; $4032
	dw WarioSpriteFrame13 ; $4034
	dw WarioSpriteFrame14 ; $4036
	dw WarioSpriteFrame06 ; $4038
	dw WarioSpriteFrame07 ; $403a
	dw WarioSpriteFrame08 ; $403c
	dw WarioSpriteFrame15 ; $403e
	dw WarioSpriteFrame16 ; $4040
	dw WarioSpriteFrame16 ; $4042
	dw WarioSpriteFrame16 ; $4044
	dw WarioSpriteFrame17 ; $4046
	dw WarioSpriteFrame17 ; $4048
	dw WarioSpriteFrame18 ; $404a
	dw WarioSpriteFrame18 ; $404c
	dw WarioSpriteFrame18 ; $404e
	dw WarioSpriteFrame19 ; $4050
	dw WarioSpriteFrame19 ; $4052
	dw WarioSpriteFrame20 ; $4054
	dw WarioSpriteFrame20 ; $4056
	dw WarioSpriteFrame20 ; $4058
	dw WarioSpriteFrame21 ; $405a
	dw WarioSpriteFrame21 ; $405c
	dw WarioSpriteFrame22 ; $405e
	dw WarioSpriteFrame22 ; $4060
	dw WarioSpriteFrame22 ; $4062
	dw WarioSpriteFrame23 ; $4064
	dw WarioSpriteFrame23 ; $4066
	dw WarioSpriteFrame24 ; $4068
	dw WarioSpriteFrame24 ; $406a
	dw WarioSpriteFrame24 ; $406c
	dw WarioSpriteFrame25 ; $406e
	dw WarioSpriteFrame25 ; $4070
	dw WarioSpriteFrame26 ; $4072
	dw WarioSpriteFrame26 ; $4074
	dw WarioSpriteFrame26 ; $4076
	dw WarioSpriteFrame27 ; $4078
	dw WarioSpriteFrame27 ; $407a
	dw WarioSpriteFrame28 ; $407c
	dw WarioSpriteFrame28 ; $407e
	dw WarioSpriteFrame28 ; $4080
	dw WarioSpriteFrame29 ; $4082
	dw WarioSpriteFrame29 ; $4084
	dw WarioSpriteFrame30 ; $4086
	dw WarioSpriteFrame30 ; $4088
	dw WarioSpriteFrame30 ; $408a
	dw WarioSpriteFrame31 ; $408c
	dw WarioSpriteFrame31 ; $408e
	dw WarioSpriteFrame32 ; $4090
	dw WarioSpriteFrame32 ; $4092
	dw WarioSpriteFrame32 ; $4094
	dw WarioSpriteFrame33 ; $4096
	dw WarioSpriteFrame33 ; $4098
	dw WarioSpriteFrame34 ; $409a
	dw WarioSpriteFrame34 ; $409c
	dw WarioSpriteFrame34 ; $409e
	dw WarioSpriteFrame35 ; $40a0
	dw WarioSpriteFrame35 ; $40a2
	dw WarioSpriteFrame36 ; $40a4
	dw WarioSpriteFrame36 ; $40a6
	dw WarioSpriteFrame36 ; $40a8
	dw WarioSpriteFrame37 ; $40aa
	dw WarioSpriteFrame37 ; $40ac
	dw WarioSpriteFrame38 ; $40ae
	dw WarioSpriteFrame38 ; $40b0
	dw WarioSpriteFrame38 ; $40b2
	dw WarioSpriteFrame39 ; $40b4
	dw WarioSpriteFrame39 ; $40b6
	dw WarioSpriteFrame40 ; $40b8
	dw WarioSpriteFrame40 ; $40ba
	dw WarioSpriteFrame40 ; $40bc
	dw WarioSpriteFrame41 ; $40be
	dw WarioSpriteFrame41 ; $40c0
	dw WarioSpriteFrame42 ; $40c2
	dw WarioSpriteFrame42 ; $40c4
	dw WarioSpriteFrame42 ; $40c6
	dw WarioSpriteFrame42 ; $40c8
	dw WarioSpriteFrame42 ; $40ca
	dw WarioSpriteFrame43 ; $40cc
	dw WarioSpriteFrame43 ; $40ce
	dw WarioSpriteFrame43 ; $40d0
	dw WarioSpriteFrame43 ; $40d2
	dw WarioSpriteFrame43 ; $40d4
	dw WarioSpriteFrame44 ; $40d6
	dw WarioSpriteFrame44 ; $40d8
	dw WarioSpriteFrame44 ; $40da
	dw WarioSpriteFrame45 ; $40dc
	dw WarioSpriteFrame45 ; $40de
	dw WarioSpriteFrame46 ; $40e0
	dw WarioSpriteFrame46 ; $40e2
	dw WarioSpriteFrame46 ; $40e4
	dw WarioSpriteFrame47 ; $40e6
	dw WarioSpriteFrame47 ; $40e8
	dw WarioSpriteFrame48 ; $40ea
	dw WarioSpriteFrame48 ; $40ec
	dw WarioSpriteFrame48 ; $40ee
	dw WarioSpriteFrame49 ; $40f0
	dw WarioSpriteFrame49 ; $40f2
	dw WarioSpriteFrame50 ; $40f4
	dw WarioSpriteFrame50 ; $40f6
	dw WarioSpriteFrame50 ; $40f8
	dw WarioSpriteFrame50 ; $40fa
	dw WarioSpriteFrame50 ; $40fc
	dw WarioSpriteFrame51 ; $40fe
	dw WarioSpriteFrame51 ; $4100
	dw WarioSpriteFrame51 ; $4102
	dw WarioSpriteFrame51 ; $4104
	dw WarioSpriteFrame51 ; $4106
	dw WarioSpriteFrame52 ; $4108
	dw WarioSpriteFrame52 ; $410a
	dw WarioSpriteFrame52 ; $410c
	dw WarioSpriteFrame52 ; $410e
	dw WarioSpriteFrame52 ; $4110
	dw WarioSpriteFrame53 ; $4112
	dw WarioSpriteFrame53 ; $4114
	dw WarioSpriteFrame53 ; $4116
	dw WarioSpriteFrame53 ; $4118
	dw WarioSpriteFrame53 ; $411a
	dw WarioSpriteFrame54 ; $411c
	dw WarioSpriteFrame54 ; $411e
	dw WarioSpriteFrame54 ; $4120
	dw WarioSpriteFrame54 ; $4122
	dw WarioSpriteFrame54 ; $4124
	dw WarioSpriteFrame55 ; $4126
	dw WarioSpriteFrame55 ; $4128
	dw WarioSpriteFrame55 ; $412a
	dw WarioSpriteFrame55 ; $412c
	dw WarioSpriteFrame55 ; $412e
WarioSpriteFrame00:
	INCBIN "data/bank_055/d_4130.bin" ; $4130, 240 bytes
WarioSpriteFrame01:
	INCBIN "data/bank_055/d_4220.bin" ; $4220, 240 bytes
WarioSpriteFrame02:
	INCBIN "data/bank_055/d_4310.bin" ; $4310, 240 bytes
WarioSpriteFrame03:
	INCBIN "data/bank_055/d_4400.bin" ; $4400, 240 bytes
WarioSpriteFrame04:
	INCBIN "data/bank_055/d_44f0.bin" ; $44f0, 240 bytes
WarioSpriteFrame05:
	INCBIN "data/bank_055/d_45e0.bin" ; $45e0, 240 bytes
WarioSpriteFrame06:
	INCBIN "data/bank_055/d_46d0.bin" ; $46d0, 240 bytes
WarioSpriteFrame07:
	INCBIN "data/bank_055/d_47c0.bin" ; $47c0, 240 bytes
WarioSpriteFrame08:
	INCBIN "data/bank_055/d_48b0.bin" ; $48b0, 240 bytes
WarioSpriteFrame09:
	INCBIN "data/bank_055/d_49a0.bin" ; $49a0, 240 bytes
WarioSpriteFrame10:
	INCBIN "data/bank_055/d_4a90.bin" ; $4a90, 240 bytes
WarioSpriteFrame11:
	INCBIN "data/bank_055/d_4b80.bin" ; $4b80, 240 bytes
WarioSpriteFrame12:
	INCBIN "data/bank_055/d_4c70.bin" ; $4c70, 240 bytes
WarioSpriteFrame13:
	INCBIN "data/bank_055/d_4d60.bin" ; $4d60, 240 bytes
WarioSpriteFrame14:
	INCBIN "data/bank_055/d_4e50.bin" ; $4e50, 240 bytes
WarioSpriteFrame15:
	INCBIN "data/bank_055/d_4f40.bin" ; $4f40, 240 bytes
WarioSpriteFrame16:
	INCBIN "data/bank_055/d_5030.bin" ; $5030, 240 bytes
WarioSpriteFrame17:
	INCBIN "data/bank_055/d_5120.bin" ; $5120, 240 bytes
WarioSpriteFrame18:
	INCBIN "data/bank_055/d_5210.bin" ; $5210, 240 bytes
WarioSpriteFrame19:
	INCBIN "data/bank_055/d_5300.bin" ; $5300, 240 bytes
WarioSpriteFrame20:
	INCBIN "data/bank_055/d_53f0.bin" ; $53f0, 240 bytes
WarioSpriteFrame21:
	INCBIN "data/bank_055/d_54e0.bin" ; $54e0, 240 bytes
WarioSpriteFrame22:
	INCBIN "data/bank_055/d_55d0.bin" ; $55d0, 240 bytes
WarioSpriteFrame23:
	INCBIN "data/bank_055/d_56c0.bin" ; $56c0, 240 bytes
WarioSpriteFrame24:
	INCBIN "data/bank_055/d_57b0.bin" ; $57b0, 240 bytes
WarioSpriteFrame25:
	INCBIN "data/bank_055/d_58a0.bin" ; $58a0, 240 bytes
WarioSpriteFrame26:
	INCBIN "data/bank_055/d_5990.bin" ; $5990, 240 bytes
WarioSpriteFrame27:
	INCBIN "data/bank_055/d_5a80.bin" ; $5a80, 240 bytes
WarioSpriteFrame28:
	INCBIN "data/bank_055/d_5b70.bin" ; $5b70, 240 bytes
WarioSpriteFrame29:
	INCBIN "data/bank_055/d_5c60.bin" ; $5c60, 240 bytes
WarioSpriteFrame30:
	INCBIN "data/bank_055/d_5d50.bin" ; $5d50, 240 bytes
WarioSpriteFrame31:
	INCBIN "data/bank_055/d_5e40.bin" ; $5e40, 240 bytes
WarioSpriteFrame32:
	INCBIN "data/bank_055/d_5f30.bin" ; $5f30, 240 bytes
WarioSpriteFrame33:
	INCBIN "data/bank_055/d_6020.bin" ; $6020, 240 bytes
WarioSpriteFrame34:
	INCBIN "data/bank_055/d_6110.bin" ; $6110, 240 bytes
WarioSpriteFrame35:
	INCBIN "data/bank_055/d_6200.bin" ; $6200, 240 bytes
WarioSpriteFrame36:
	INCBIN "data/bank_055/d_62f0.bin" ; $62f0, 240 bytes
WarioSpriteFrame37:
	INCBIN "data/bank_055/d_63e0.bin" ; $63e0, 240 bytes
WarioSpriteFrame38:
	INCBIN "data/bank_055/d_64d0.bin" ; $64d0, 240 bytes
WarioSpriteFrame39:
	INCBIN "data/bank_055/d_65c0.bin" ; $65c0, 240 bytes
WarioSpriteFrame40:
	INCBIN "data/bank_055/d_66b0.bin" ; $66b0, 320 bytes
WarioSpriteFrame41:
	INCBIN "data/bank_055/d_67f0.bin" ; $67f0, 320 bytes
WarioSpriteFrame42:
	INCBIN "data/bank_055/d_6930.bin" ; $6930, 240 bytes
WarioSpriteFrame43:
	INCBIN "data/bank_055/d_6a20.bin" ; $6a20, 240 bytes
WarioSpriteFrame44:
	INCBIN "data/bank_055/d_6b10.bin" ; $6b10, 240 bytes
WarioSpriteFrame45:
	INCBIN "data/bank_055/d_6c00.bin" ; $6c00, 240 bytes
WarioSpriteFrame46:
	INCBIN "data/bank_055/d_6cf0.bin" ; $6cf0, 240 bytes
WarioSpriteFrame47:
	INCBIN "data/bank_055/d_6de0.bin" ; $6de0, 240 bytes
WarioSpriteFrame48:
	INCBIN "data/bank_055/d_6ed0.bin" ; $6ed0, 240 bytes
WarioSpriteFrame49:
	INCBIN "data/bank_055/d_6fc0.bin" ; $6fc0, 240 bytes
WarioSpriteFrame50:
	INCBIN "data/bank_055/d_70b0.bin" ; $70b0, 240 bytes
WarioSpriteFrame51:
	INCBIN "data/bank_055/d_71a0.bin" ; $71a0, 240 bytes
WarioSpriteFrame52:
	INCBIN "data/bank_055/d_7290.bin" ; $7290, 240 bytes
WarioSpriteFrame53:
	INCBIN "data/bank_055/d_7380.bin" ; $7380, 240 bytes
WarioSpriteFrame54:
	INCBIN "data/bank_055/d_7470.bin" ; $7470, 240 bytes
WarioSpriteFrame55:
	INCBIN "data/bank_055/d_7560.bin" ; $7560, 240 bytes
Data_55_7650:
	INCBIN "data/bank_055/d_7650.bin" ; $7650, 1680 bytes
Data_55_7ce0:
	INCBIN "data/bank_055/d_7ce0.bin" ; $7ce0, 580 bytes
WarioSpriteAnims:
	dw WarioSpriteAnim00 ; $7f24
	dw WarioSpriteAnim01 ; $7f26
	dw WarioSpriteAnim02 ; $7f28
	dw WarioSpriteAnim03 ; $7f2a
	dw WarioSpriteAnim04 ; $7f2c
	dw WarioSpriteAnim05 ; $7f2e
	dw WarioSpriteAnim06 ; $7f30
	dw WarioSpriteAnim07 ; $7f32
	dw WarioSpriteAnim08 ; $7f34
	dw WarioSpriteAnim09 ; $7f36
	dw WarioSpriteAnim10 ; $7f38
	dw WarioSpriteAnim11 ; $7f3a
	dw WarioSpriteAnim12 ; $7f3c
	dw WarioSpriteAnim13 ; $7f3e
	dw WarioSpriteAnim14 ; $7f40
	dw WarioSpriteAnim15 ; $7f42
	dw WarioSpriteAnim16 ; $7f44
	dw WarioSpriteAnim17 ; $7f46
	dw WarioSpriteAnim18 ; $7f48
WarioSpriteAnim00:
	INCBIN "data/bank_055/d_7f4a.bin" ; $7f4a, 3 bytes
WarioSpriteAnim01:
	INCBIN "data/bank_055/d_7f4d.bin" ; $7f4d, 10 bytes
WarioSpriteAnim02:
	INCBIN "data/bank_055/d_7f57.bin" ; $7f57, 6 bytes
WarioSpriteAnim03:
	INCBIN "data/bank_055/d_7f5d.bin" ; $7f5d, 8 bytes
WarioSpriteAnim04:
	INCBIN "data/bank_055/d_7f65.bin" ; $7f65, 8 bytes
WarioSpriteAnim05:
	INCBIN "data/bank_055/d_7f6d.bin" ; $7f6d, 6 bytes
WarioSpriteAnim06:
	INCBIN "data/bank_055/d_7f73.bin" ; $7f73, 6 bytes
WarioSpriteAnim07:
	INCBIN "data/bank_055/d_7f79.bin" ; $7f79, 6 bytes
WarioSpriteAnim08:
	INCBIN "data/bank_055/d_7f7f.bin" ; $7f7f, 5 bytes
WarioSpriteAnim09:
	INCBIN "data/bank_055/d_7f84.bin" ; $7f84, 4 bytes
WarioSpriteAnim10:
	INCBIN "data/bank_055/d_7f88.bin" ; $7f88, 4 bytes
WarioSpriteAnim11:
	INCBIN "data/bank_055/d_7f8c.bin" ; $7f8c, 4 bytes
WarioSpriteAnim12:
	INCBIN "data/bank_055/d_7f90.bin" ; $7f90, 3 bytes
WarioSpriteAnim13:
	INCBIN "data/bank_055/d_7f93.bin" ; $7f93, 3 bytes
WarioSpriteAnim14:
	INCBIN "data/bank_055/d_7f96.bin" ; $7f96, 3 bytes
WarioSpriteAnim15:
	INCBIN "data/bank_055/d_7f99.bin" ; $7f99, 3 bytes
WarioSpriteAnim16:
	INCBIN "data/bank_055/d_7f9c.bin" ; $7f9c, 3 bytes
WarioSpriteAnim17:
	INCBIN "data/bank_055/d_7f9f.bin" ; $7f9f, 12 bytes
WarioSpriteAnim18:
	INCBIN "data/bank_055/d_7fab.bin" ; $7fab, 8 bytes
	; $7fb3, 77 bytes fill to bank end (linker-padded)
