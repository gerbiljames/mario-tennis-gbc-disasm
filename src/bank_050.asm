SECTION "ROM Bank $50", ROMX[$4000], BANK[$50]

	dw MarioSpriteDesc ; $4000
MarioSpriteDesc:
	dw $0006 ; $4002
	dw $0003 ; $4004
	dw MarioSpriteFrames ; $4006 frame table
	dw MarioSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw Data_50_7ce0 ; $400c per-slot OAM data
MarioSpriteFrames:
	dw MarioSpriteFrame00 ; $400e
	dw MarioSpriteFrame01 ; $4010
	dw MarioSpriteFrame02 ; $4012
	dw MarioSpriteFrame03 ; $4014
	dw MarioSpriteFrame04 ; $4016
	dw MarioSpriteFrame05 ; $4018
	dw MarioSpriteFrame06 ; $401a
	dw MarioSpriteFrame07 ; $401c
	dw MarioSpriteFrame08 ; $401e
	dw MarioSpriteFrame09 ; $4020
	dw MarioSpriteFrame10 ; $4022
	dw MarioSpriteFrame01 ; $4024
	dw MarioSpriteFrame02 ; $4026
	dw MarioSpriteFrame03 ; $4028
	dw MarioSpriteFrame11 ; $402a
	dw MarioSpriteFrame12 ; $402c
	dw MarioSpriteFrame01 ; $402e
	dw MarioSpriteFrame02 ; $4030
	dw MarioSpriteFrame03 ; $4032
	dw MarioSpriteFrame13 ; $4034
	dw MarioSpriteFrame14 ; $4036
	dw MarioSpriteFrame06 ; $4038
	dw MarioSpriteFrame07 ; $403a
	dw MarioSpriteFrame08 ; $403c
	dw MarioSpriteFrame15 ; $403e
	dw MarioSpriteFrame16 ; $4040
	dw MarioSpriteFrame16 ; $4042
	dw MarioSpriteFrame16 ; $4044
	dw MarioSpriteFrame17 ; $4046
	dw MarioSpriteFrame17 ; $4048
	dw MarioSpriteFrame18 ; $404a
	dw MarioSpriteFrame18 ; $404c
	dw MarioSpriteFrame18 ; $404e
	dw MarioSpriteFrame19 ; $4050
	dw MarioSpriteFrame19 ; $4052
	dw MarioSpriteFrame20 ; $4054
	dw MarioSpriteFrame20 ; $4056
	dw MarioSpriteFrame20 ; $4058
	dw MarioSpriteFrame21 ; $405a
	dw MarioSpriteFrame21 ; $405c
	dw MarioSpriteFrame22 ; $405e
	dw MarioSpriteFrame22 ; $4060
	dw MarioSpriteFrame22 ; $4062
	dw MarioSpriteFrame23 ; $4064
	dw MarioSpriteFrame23 ; $4066
	dw MarioSpriteFrame24 ; $4068
	dw MarioSpriteFrame24 ; $406a
	dw MarioSpriteFrame24 ; $406c
	dw MarioSpriteFrame25 ; $406e
	dw MarioSpriteFrame25 ; $4070
	dw MarioSpriteFrame26 ; $4072
	dw MarioSpriteFrame26 ; $4074
	dw MarioSpriteFrame26 ; $4076
	dw MarioSpriteFrame27 ; $4078
	dw MarioSpriteFrame27 ; $407a
	dw MarioSpriteFrame28 ; $407c
	dw MarioSpriteFrame28 ; $407e
	dw MarioSpriteFrame28 ; $4080
	dw MarioSpriteFrame29 ; $4082
	dw MarioSpriteFrame29 ; $4084
	dw MarioSpriteFrame30 ; $4086
	dw MarioSpriteFrame30 ; $4088
	dw MarioSpriteFrame30 ; $408a
	dw MarioSpriteFrame31 ; $408c
	dw MarioSpriteFrame31 ; $408e
	dw MarioSpriteFrame32 ; $4090
	dw MarioSpriteFrame32 ; $4092
	dw MarioSpriteFrame32 ; $4094
	dw MarioSpriteFrame33 ; $4096
	dw MarioSpriteFrame33 ; $4098
	dw MarioSpriteFrame34 ; $409a
	dw MarioSpriteFrame34 ; $409c
	dw MarioSpriteFrame34 ; $409e
	dw MarioSpriteFrame35 ; $40a0
	dw MarioSpriteFrame35 ; $40a2
	dw MarioSpriteFrame36 ; $40a4
	dw MarioSpriteFrame36 ; $40a6
	dw MarioSpriteFrame36 ; $40a8
	dw MarioSpriteFrame37 ; $40aa
	dw MarioSpriteFrame37 ; $40ac
	dw MarioSpriteFrame38 ; $40ae
	dw MarioSpriteFrame38 ; $40b0
	dw MarioSpriteFrame38 ; $40b2
	dw MarioSpriteFrame39 ; $40b4
	dw MarioSpriteFrame39 ; $40b6
	dw MarioSpriteFrame40 ; $40b8
	dw MarioSpriteFrame40 ; $40ba
	dw MarioSpriteFrame40 ; $40bc
	dw MarioSpriteFrame41 ; $40be
	dw MarioSpriteFrame41 ; $40c0
	dw MarioSpriteFrame42 ; $40c2
	dw MarioSpriteFrame42 ; $40c4
	dw MarioSpriteFrame42 ; $40c6
	dw MarioSpriteFrame42 ; $40c8
	dw MarioSpriteFrame42 ; $40ca
	dw MarioSpriteFrame43 ; $40cc
	dw MarioSpriteFrame43 ; $40ce
	dw MarioSpriteFrame43 ; $40d0
	dw MarioSpriteFrame43 ; $40d2
	dw MarioSpriteFrame43 ; $40d4
	dw MarioSpriteFrame44 ; $40d6
	dw MarioSpriteFrame44 ; $40d8
	dw MarioSpriteFrame44 ; $40da
	dw MarioSpriteFrame45 ; $40dc
	dw MarioSpriteFrame45 ; $40de
	dw MarioSpriteFrame46 ; $40e0
	dw MarioSpriteFrame46 ; $40e2
	dw MarioSpriteFrame46 ; $40e4
	dw MarioSpriteFrame47 ; $40e6
	dw MarioSpriteFrame47 ; $40e8
	dw MarioSpriteFrame48 ; $40ea
	dw MarioSpriteFrame48 ; $40ec
	dw MarioSpriteFrame48 ; $40ee
	dw MarioSpriteFrame49 ; $40f0
	dw MarioSpriteFrame49 ; $40f2
	dw MarioSpriteFrame50 ; $40f4
	dw MarioSpriteFrame50 ; $40f6
	dw MarioSpriteFrame50 ; $40f8
	dw MarioSpriteFrame50 ; $40fa
	dw MarioSpriteFrame50 ; $40fc
	dw MarioSpriteFrame51 ; $40fe
	dw MarioSpriteFrame51 ; $4100
	dw MarioSpriteFrame51 ; $4102
	dw MarioSpriteFrame51 ; $4104
	dw MarioSpriteFrame51 ; $4106
	dw MarioSpriteFrame52 ; $4108
	dw MarioSpriteFrame52 ; $410a
	dw MarioSpriteFrame52 ; $410c
	dw MarioSpriteFrame52 ; $410e
	dw MarioSpriteFrame52 ; $4110
	dw MarioSpriteFrame53 ; $4112
	dw MarioSpriteFrame53 ; $4114
	dw MarioSpriteFrame53 ; $4116
	dw MarioSpriteFrame53 ; $4118
	dw MarioSpriteFrame53 ; $411a
	dw MarioSpriteFrame54 ; $411c
	dw MarioSpriteFrame54 ; $411e
	dw MarioSpriteFrame54 ; $4120
	dw MarioSpriteFrame54 ; $4122
	dw MarioSpriteFrame54 ; $4124
	dw MarioSpriteFrame55 ; $4126
	dw MarioSpriteFrame55 ; $4128
	dw MarioSpriteFrame55 ; $412a
	dw MarioSpriteFrame55 ; $412c
	dw MarioSpriteFrame55 ; $412e
MarioSpriteFrame00:
	INCBIN "data/bank_050/d_4130.bin" ; $4130, 240 bytes
MarioSpriteFrame01:
	INCBIN "data/bank_050/d_4220.bin" ; $4220, 240 bytes
MarioSpriteFrame02:
	INCBIN "data/bank_050/d_4310.bin" ; $4310, 240 bytes
MarioSpriteFrame03:
	INCBIN "data/bank_050/d_4400.bin" ; $4400, 240 bytes
MarioSpriteFrame04:
	INCBIN "data/bank_050/d_44f0.bin" ; $44f0, 240 bytes
MarioSpriteFrame05:
	INCBIN "data/bank_050/d_45e0.bin" ; $45e0, 240 bytes
MarioSpriteFrame06:
	INCBIN "data/bank_050/d_46d0.bin" ; $46d0, 240 bytes
MarioSpriteFrame07:
	INCBIN "data/bank_050/d_47c0.bin" ; $47c0, 240 bytes
MarioSpriteFrame08:
	INCBIN "data/bank_050/d_48b0.bin" ; $48b0, 240 bytes
MarioSpriteFrame09:
	INCBIN "data/bank_050/d_49a0.bin" ; $49a0, 240 bytes
MarioSpriteFrame10:
	INCBIN "data/bank_050/d_4a90.bin" ; $4a90, 240 bytes
MarioSpriteFrame11:
	INCBIN "data/bank_050/d_4b80.bin" ; $4b80, 240 bytes
MarioSpriteFrame12:
	INCBIN "data/bank_050/d_4c70.bin" ; $4c70, 240 bytes
MarioSpriteFrame13:
	INCBIN "data/bank_050/d_4d60.bin" ; $4d60, 240 bytes
MarioSpriteFrame14:
	INCBIN "data/bank_050/d_4e50.bin" ; $4e50, 240 bytes
MarioSpriteFrame15:
	INCBIN "data/bank_050/d_4f40.bin" ; $4f40, 240 bytes
MarioSpriteFrame16:
	INCBIN "data/bank_050/d_5030.bin" ; $5030, 240 bytes
MarioSpriteFrame17:
	INCBIN "data/bank_050/d_5120.bin" ; $5120, 240 bytes
MarioSpriteFrame18:
	INCBIN "data/bank_050/d_5210.bin" ; $5210, 240 bytes
MarioSpriteFrame19:
	INCBIN "data/bank_050/d_5300.bin" ; $5300, 240 bytes
MarioSpriteFrame20:
	INCBIN "data/bank_050/d_53f0.bin" ; $53f0, 240 bytes
MarioSpriteFrame21:
	INCBIN "data/bank_050/d_54e0.bin" ; $54e0, 240 bytes
MarioSpriteFrame22:
	INCBIN "data/bank_050/d_55d0.bin" ; $55d0, 240 bytes
MarioSpriteFrame23:
	INCBIN "data/bank_050/d_56c0.bin" ; $56c0, 240 bytes
MarioSpriteFrame24:
	INCBIN "data/bank_050/d_57b0.bin" ; $57b0, 240 bytes
MarioSpriteFrame25:
	INCBIN "data/bank_050/d_58a0.bin" ; $58a0, 240 bytes
MarioSpriteFrame26:
	INCBIN "data/bank_050/d_5990.bin" ; $5990, 240 bytes
MarioSpriteFrame27:
	INCBIN "data/bank_050/d_5a80.bin" ; $5a80, 240 bytes
MarioSpriteFrame28:
	INCBIN "data/bank_050/d_5b70.bin" ; $5b70, 240 bytes
MarioSpriteFrame29:
	INCBIN "data/bank_050/d_5c60.bin" ; $5c60, 240 bytes
MarioSpriteFrame30:
	INCBIN "data/bank_050/d_5d50.bin" ; $5d50, 240 bytes
MarioSpriteFrame31:
	INCBIN "data/bank_050/d_5e40.bin" ; $5e40, 240 bytes
MarioSpriteFrame32:
	INCBIN "data/bank_050/d_5f30.bin" ; $5f30, 240 bytes
MarioSpriteFrame33:
	INCBIN "data/bank_050/d_6020.bin" ; $6020, 240 bytes
MarioSpriteFrame34:
	INCBIN "data/bank_050/d_6110.bin" ; $6110, 240 bytes
MarioSpriteFrame35:
	INCBIN "data/bank_050/d_6200.bin" ; $6200, 240 bytes
MarioSpriteFrame36:
	INCBIN "data/bank_050/d_62f0.bin" ; $62f0, 240 bytes
MarioSpriteFrame37:
	INCBIN "data/bank_050/d_63e0.bin" ; $63e0, 240 bytes
MarioSpriteFrame38:
	INCBIN "data/bank_050/d_64d0.bin" ; $64d0, 240 bytes
MarioSpriteFrame39:
	INCBIN "data/bank_050/d_65c0.bin" ; $65c0, 240 bytes
MarioSpriteFrame40:
	INCBIN "data/bank_050/d_66b0.bin" ; $66b0, 320 bytes
MarioSpriteFrame41:
	INCBIN "data/bank_050/d_67f0.bin" ; $67f0, 320 bytes
MarioSpriteFrame42:
	INCBIN "data/bank_050/d_6930.bin" ; $6930, 240 bytes
MarioSpriteFrame43:
	INCBIN "data/bank_050/d_6a20.bin" ; $6a20, 240 bytes
MarioSpriteFrame44:
	INCBIN "data/bank_050/d_6b10.bin" ; $6b10, 240 bytes
MarioSpriteFrame45:
	INCBIN "data/bank_050/d_6c00.bin" ; $6c00, 240 bytes
MarioSpriteFrame46:
	INCBIN "data/bank_050/d_6cf0.bin" ; $6cf0, 240 bytes
MarioSpriteFrame47:
	INCBIN "data/bank_050/d_6de0.bin" ; $6de0, 240 bytes
MarioSpriteFrame48:
	INCBIN "data/bank_050/d_6ed0.bin" ; $6ed0, 240 bytes
MarioSpriteFrame49:
	INCBIN "data/bank_050/d_6fc0.bin" ; $6fc0, 240 bytes
MarioSpriteFrame50:
	INCBIN "data/bank_050/d_70b0.bin" ; $70b0, 240 bytes
MarioSpriteFrame51:
	INCBIN "data/bank_050/d_71a0.bin" ; $71a0, 240 bytes
MarioSpriteFrame52:
	INCBIN "data/bank_050/d_7290.bin" ; $7290, 240 bytes
MarioSpriteFrame53:
	INCBIN "data/bank_050/d_7380.bin" ; $7380, 240 bytes
MarioSpriteFrame54:
	INCBIN "data/bank_050/d_7470.bin" ; $7470, 240 bytes
MarioSpriteFrame55:
	INCBIN "data/bank_050/d_7560.bin" ; $7560, 240 bytes
Data_50_7650:
	INCBIN "data/bank_050/d_7650.bin" ; $7650, 1680 bytes
Data_50_7ce0:
	INCBIN "data/bank_050/d_7ce0.bin" ; $7ce0, 580 bytes
MarioSpriteAnims:
	dw MarioSpriteAnim00 ; $7f24
	dw MarioSpriteAnim01 ; $7f26
	dw MarioSpriteAnim02 ; $7f28
	dw MarioSpriteAnim03 ; $7f2a
	dw MarioSpriteAnim04 ; $7f2c
	dw MarioSpriteAnim05 ; $7f2e
	dw MarioSpriteAnim06 ; $7f30
	dw MarioSpriteAnim07 ; $7f32
	dw MarioSpriteAnim08 ; $7f34
	dw MarioSpriteAnim09 ; $7f36
	dw MarioSpriteAnim10 ; $7f38
	dw MarioSpriteAnim11 ; $7f3a
	dw MarioSpriteAnim12 ; $7f3c
	dw MarioSpriteAnim13 ; $7f3e
	dw MarioSpriteAnim14 ; $7f40
	dw MarioSpriteAnim15 ; $7f42
	dw MarioSpriteAnim16 ; $7f44
	dw MarioSpriteAnim17 ; $7f46
	dw MarioSpriteAnim18 ; $7f48
MarioSpriteAnim00:
	INCBIN "data/bank_050/d_7f4a.bin" ; $7f4a, 3 bytes
MarioSpriteAnim01:
	INCBIN "data/bank_050/d_7f4d.bin" ; $7f4d, 10 bytes
MarioSpriteAnim02:
	INCBIN "data/bank_050/d_7f57.bin" ; $7f57, 6 bytes
MarioSpriteAnim03:
	INCBIN "data/bank_050/d_7f5d.bin" ; $7f5d, 30 bytes
MarioSpriteAnim04:
	INCBIN "data/bank_050/d_7f7b.bin" ; $7f7b, 8 bytes
MarioSpriteAnim05:
	INCBIN "data/bank_050/d_7f83.bin" ; $7f83, 6 bytes
MarioSpriteAnim06:
	INCBIN "data/bank_050/d_7f89.bin" ; $7f89, 6 bytes
MarioSpriteAnim07:
	INCBIN "data/bank_050/d_7f8f.bin" ; $7f8f, 6 bytes
MarioSpriteAnim08:
	INCBIN "data/bank_050/d_7f95.bin" ; $7f95, 5 bytes
MarioSpriteAnim09:
	INCBIN "data/bank_050/d_7f9a.bin" ; $7f9a, 4 bytes
MarioSpriteAnim10:
	INCBIN "data/bank_050/d_7f9e.bin" ; $7f9e, 4 bytes
MarioSpriteAnim11:
	INCBIN "data/bank_050/d_7fa2.bin" ; $7fa2, 4 bytes
MarioSpriteAnim12:
	INCBIN "data/bank_050/d_7fa6.bin" ; $7fa6, 3 bytes
MarioSpriteAnim13:
	INCBIN "data/bank_050/d_7fa9.bin" ; $7fa9, 3 bytes
MarioSpriteAnim14:
	INCBIN "data/bank_050/d_7fac.bin" ; $7fac, 3 bytes
MarioSpriteAnim15:
	INCBIN "data/bank_050/d_7faf.bin" ; $7faf, 3 bytes
MarioSpriteAnim16:
	INCBIN "data/bank_050/d_7fb2.bin" ; $7fb2, 3 bytes
MarioSpriteAnim17:
	INCBIN "data/bank_050/d_7fb5.bin" ; $7fb5, 12 bytes
MarioSpriteAnim18:
	INCBIN "data/bank_050/d_7fc1.bin" ; $7fc1, 8 bytes
	; $7fc9, 55 bytes fill to bank end (linker-padded)
