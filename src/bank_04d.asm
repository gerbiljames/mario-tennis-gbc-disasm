SECTION "ROM Bank $4d", ROMX[$4000], BANK[$4d]

	dw BrianSpriteDesc ; $4000
BrianSpriteDesc:
	dw $0003 ; $4002
	dw $0003 ; $4004
	dw BrianSpriteFrames ; $4006 frame table
	dw BrianSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw Data_4d_7ce0 ; $400c per-slot OAM data
BrianSpriteFrames:
	dw BrianSpriteFrame00 ; $400e
	dw BrianSpriteFrame01 ; $4010
	dw BrianSpriteFrame02 ; $4012
	dw BrianSpriteFrame03 ; $4014
	dw BrianSpriteFrame04 ; $4016
	dw BrianSpriteFrame05 ; $4018
	dw BrianSpriteFrame06 ; $401a
	dw BrianSpriteFrame07 ; $401c
	dw BrianSpriteFrame08 ; $401e
	dw BrianSpriteFrame09 ; $4020
	dw BrianSpriteFrame10 ; $4022
	dw BrianSpriteFrame01 ; $4024
	dw BrianSpriteFrame02 ; $4026
	dw BrianSpriteFrame03 ; $4028
	dw BrianSpriteFrame11 ; $402a
	dw BrianSpriteFrame12 ; $402c
	dw BrianSpriteFrame01 ; $402e
	dw BrianSpriteFrame02 ; $4030
	dw BrianSpriteFrame03 ; $4032
	dw BrianSpriteFrame13 ; $4034
	dw BrianSpriteFrame14 ; $4036
	dw BrianSpriteFrame06 ; $4038
	dw BrianSpriteFrame07 ; $403a
	dw BrianSpriteFrame08 ; $403c
	dw BrianSpriteFrame15 ; $403e
	dw BrianSpriteFrame16 ; $4040
	dw BrianSpriteFrame16 ; $4042
	dw BrianSpriteFrame16 ; $4044
	dw BrianSpriteFrame17 ; $4046
	dw BrianSpriteFrame17 ; $4048
	dw BrianSpriteFrame18 ; $404a
	dw BrianSpriteFrame18 ; $404c
	dw BrianSpriteFrame18 ; $404e
	dw BrianSpriteFrame19 ; $4050
	dw BrianSpriteFrame19 ; $4052
	dw BrianSpriteFrame20 ; $4054
	dw BrianSpriteFrame20 ; $4056
	dw BrianSpriteFrame20 ; $4058
	dw BrianSpriteFrame21 ; $405a
	dw BrianSpriteFrame21 ; $405c
	dw BrianSpriteFrame22 ; $405e
	dw BrianSpriteFrame22 ; $4060
	dw BrianSpriteFrame22 ; $4062
	dw BrianSpriteFrame23 ; $4064
	dw BrianSpriteFrame23 ; $4066
	dw BrianSpriteFrame24 ; $4068
	dw BrianSpriteFrame24 ; $406a
	dw BrianSpriteFrame24 ; $406c
	dw BrianSpriteFrame25 ; $406e
	dw BrianSpriteFrame25 ; $4070
	dw BrianSpriteFrame26 ; $4072
	dw BrianSpriteFrame26 ; $4074
	dw BrianSpriteFrame26 ; $4076
	dw BrianSpriteFrame27 ; $4078
	dw BrianSpriteFrame27 ; $407a
	dw BrianSpriteFrame28 ; $407c
	dw BrianSpriteFrame28 ; $407e
	dw BrianSpriteFrame28 ; $4080
	dw BrianSpriteFrame29 ; $4082
	dw BrianSpriteFrame29 ; $4084
	dw BrianSpriteFrame30 ; $4086
	dw BrianSpriteFrame30 ; $4088
	dw BrianSpriteFrame30 ; $408a
	dw BrianSpriteFrame31 ; $408c
	dw BrianSpriteFrame31 ; $408e
	dw BrianSpriteFrame32 ; $4090
	dw BrianSpriteFrame32 ; $4092
	dw BrianSpriteFrame32 ; $4094
	dw BrianSpriteFrame33 ; $4096
	dw BrianSpriteFrame33 ; $4098
	dw BrianSpriteFrame34 ; $409a
	dw BrianSpriteFrame34 ; $409c
	dw BrianSpriteFrame34 ; $409e
	dw BrianSpriteFrame35 ; $40a0
	dw BrianSpriteFrame35 ; $40a2
	dw BrianSpriteFrame36 ; $40a4
	dw BrianSpriteFrame36 ; $40a6
	dw BrianSpriteFrame36 ; $40a8
	dw BrianSpriteFrame37 ; $40aa
	dw BrianSpriteFrame37 ; $40ac
	dw BrianSpriteFrame38 ; $40ae
	dw BrianSpriteFrame38 ; $40b0
	dw BrianSpriteFrame38 ; $40b2
	dw BrianSpriteFrame39 ; $40b4
	dw BrianSpriteFrame39 ; $40b6
	dw BrianSpriteFrame40 ; $40b8
	dw BrianSpriteFrame40 ; $40ba
	dw BrianSpriteFrame40 ; $40bc
	dw BrianSpriteFrame41 ; $40be
	dw BrianSpriteFrame41 ; $40c0
	dw BrianSpriteFrame42 ; $40c2
	dw BrianSpriteFrame42 ; $40c4
	dw BrianSpriteFrame42 ; $40c6
	dw BrianSpriteFrame42 ; $40c8
	dw BrianSpriteFrame42 ; $40ca
	dw BrianSpriteFrame43 ; $40cc
	dw BrianSpriteFrame43 ; $40ce
	dw BrianSpriteFrame43 ; $40d0
	dw BrianSpriteFrame43 ; $40d2
	dw BrianSpriteFrame43 ; $40d4
	dw BrianSpriteFrame44 ; $40d6
	dw BrianSpriteFrame44 ; $40d8
	dw BrianSpriteFrame44 ; $40da
	dw BrianSpriteFrame45 ; $40dc
	dw BrianSpriteFrame45 ; $40de
	dw BrianSpriteFrame46 ; $40e0
	dw BrianSpriteFrame46 ; $40e2
	dw BrianSpriteFrame46 ; $40e4
	dw BrianSpriteFrame47 ; $40e6
	dw BrianSpriteFrame47 ; $40e8
	dw BrianSpriteFrame48 ; $40ea
	dw BrianSpriteFrame48 ; $40ec
	dw BrianSpriteFrame48 ; $40ee
	dw BrianSpriteFrame49 ; $40f0
	dw BrianSpriteFrame49 ; $40f2
	dw BrianSpriteFrame50 ; $40f4
	dw BrianSpriteFrame50 ; $40f6
	dw BrianSpriteFrame50 ; $40f8
	dw BrianSpriteFrame50 ; $40fa
	dw BrianSpriteFrame50 ; $40fc
	dw BrianSpriteFrame51 ; $40fe
	dw BrianSpriteFrame51 ; $4100
	dw BrianSpriteFrame51 ; $4102
	dw BrianSpriteFrame51 ; $4104
	dw BrianSpriteFrame51 ; $4106
	dw BrianSpriteFrame52 ; $4108
	dw BrianSpriteFrame52 ; $410a
	dw BrianSpriteFrame52 ; $410c
	dw BrianSpriteFrame52 ; $410e
	dw BrianSpriteFrame52 ; $4110
	dw BrianSpriteFrame53 ; $4112
	dw BrianSpriteFrame53 ; $4114
	dw BrianSpriteFrame53 ; $4116
	dw BrianSpriteFrame53 ; $4118
	dw BrianSpriteFrame53 ; $411a
	dw BrianSpriteFrame54 ; $411c
	dw BrianSpriteFrame54 ; $411e
	dw BrianSpriteFrame54 ; $4120
	dw BrianSpriteFrame54 ; $4122
	dw BrianSpriteFrame54 ; $4124
	dw BrianSpriteFrame55 ; $4126
	dw BrianSpriteFrame55 ; $4128
	dw BrianSpriteFrame55 ; $412a
	dw BrianSpriteFrame55 ; $412c
	dw BrianSpriteFrame55 ; $412e
BrianSpriteFrame00:
	INCBIN "data/bank_04d/d_4130.bin" ; $4130, 240 bytes
BrianSpriteFrame01:
	INCBIN "data/bank_04d/d_4220.bin" ; $4220, 240 bytes
BrianSpriteFrame02:
	INCBIN "data/bank_04d/d_4310.bin" ; $4310, 240 bytes
BrianSpriteFrame03:
	INCBIN "data/bank_04d/d_4400.bin" ; $4400, 240 bytes
BrianSpriteFrame04:
	INCBIN "data/bank_04d/d_44f0.bin" ; $44f0, 240 bytes
BrianSpriteFrame05:
	INCBIN "data/bank_04d/d_45e0.bin" ; $45e0, 240 bytes
BrianSpriteFrame06:
	INCBIN "data/bank_04d/d_46d0.bin" ; $46d0, 240 bytes
BrianSpriteFrame07:
	INCBIN "data/bank_04d/d_47c0.bin" ; $47c0, 240 bytes
BrianSpriteFrame08:
	INCBIN "data/bank_04d/d_48b0.bin" ; $48b0, 240 bytes
BrianSpriteFrame09:
	INCBIN "data/bank_04d/d_49a0.bin" ; $49a0, 240 bytes
BrianSpriteFrame10:
	INCBIN "data/bank_04d/d_4a90.bin" ; $4a90, 240 bytes
BrianSpriteFrame11:
	INCBIN "data/bank_04d/d_4b80.bin" ; $4b80, 240 bytes
BrianSpriteFrame12:
	INCBIN "data/bank_04d/d_4c70.bin" ; $4c70, 240 bytes
BrianSpriteFrame13:
	INCBIN "data/bank_04d/d_4d60.bin" ; $4d60, 240 bytes
BrianSpriteFrame14:
	INCBIN "data/bank_04d/d_4e50.bin" ; $4e50, 240 bytes
BrianSpriteFrame15:
	INCBIN "data/bank_04d/d_4f40.bin" ; $4f40, 240 bytes
BrianSpriteFrame16:
	INCBIN "data/bank_04d/d_5030.bin" ; $5030, 240 bytes
BrianSpriteFrame17:
	INCBIN "data/bank_04d/d_5120.bin" ; $5120, 240 bytes
BrianSpriteFrame18:
	INCBIN "data/bank_04d/d_5210.bin" ; $5210, 240 bytes
BrianSpriteFrame19:
	INCBIN "data/bank_04d/d_5300.bin" ; $5300, 240 bytes
BrianSpriteFrame20:
	INCBIN "data/bank_04d/d_53f0.bin" ; $53f0, 240 bytes
BrianSpriteFrame21:
	INCBIN "data/bank_04d/d_54e0.bin" ; $54e0, 240 bytes
BrianSpriteFrame22:
	INCBIN "data/bank_04d/d_55d0.bin" ; $55d0, 240 bytes
BrianSpriteFrame23:
	INCBIN "data/bank_04d/d_56c0.bin" ; $56c0, 240 bytes
BrianSpriteFrame24:
	INCBIN "data/bank_04d/d_57b0.bin" ; $57b0, 240 bytes
BrianSpriteFrame25:
	INCBIN "data/bank_04d/d_58a0.bin" ; $58a0, 240 bytes
BrianSpriteFrame26:
	INCBIN "data/bank_04d/d_5990.bin" ; $5990, 240 bytes
BrianSpriteFrame27:
	INCBIN "data/bank_04d/d_5a80.bin" ; $5a80, 240 bytes
BrianSpriteFrame28:
	INCBIN "data/bank_04d/d_5b70.bin" ; $5b70, 240 bytes
BrianSpriteFrame29:
	INCBIN "data/bank_04d/d_5c60.bin" ; $5c60, 240 bytes
BrianSpriteFrame30:
	INCBIN "data/bank_04d/d_5d50.bin" ; $5d50, 240 bytes
BrianSpriteFrame31:
	INCBIN "data/bank_04d/d_5e40.bin" ; $5e40, 240 bytes
BrianSpriteFrame32:
	INCBIN "data/bank_04d/d_5f30.bin" ; $5f30, 240 bytes
BrianSpriteFrame33:
	INCBIN "data/bank_04d/d_6020.bin" ; $6020, 240 bytes
BrianSpriteFrame34:
	INCBIN "data/bank_04d/d_6110.bin" ; $6110, 240 bytes
BrianSpriteFrame35:
	INCBIN "data/bank_04d/d_6200.bin" ; $6200, 240 bytes
BrianSpriteFrame36:
	INCBIN "data/bank_04d/d_62f0.bin" ; $62f0, 240 bytes
BrianSpriteFrame37:
	INCBIN "data/bank_04d/d_63e0.bin" ; $63e0, 240 bytes
BrianSpriteFrame38:
	INCBIN "data/bank_04d/d_64d0.bin" ; $64d0, 240 bytes
BrianSpriteFrame39:
	INCBIN "data/bank_04d/d_65c0.bin" ; $65c0, 240 bytes
BrianSpriteFrame40:
	INCBIN "data/bank_04d/d_66b0.bin" ; $66b0, 320 bytes
BrianSpriteFrame41:
	INCBIN "data/bank_04d/d_67f0.bin" ; $67f0, 320 bytes
BrianSpriteFrame42:
	INCBIN "data/bank_04d/d_6930.bin" ; $6930, 240 bytes
BrianSpriteFrame43:
	INCBIN "data/bank_04d/d_6a20.bin" ; $6a20, 240 bytes
BrianSpriteFrame44:
	INCBIN "data/bank_04d/d_6b10.bin" ; $6b10, 240 bytes
BrianSpriteFrame45:
	INCBIN "data/bank_04d/d_6c00.bin" ; $6c00, 240 bytes
BrianSpriteFrame46:
	INCBIN "data/bank_04d/d_6cf0.bin" ; $6cf0, 240 bytes
BrianSpriteFrame47:
	INCBIN "data/bank_04d/d_6de0.bin" ; $6de0, 240 bytes
BrianSpriteFrame48:
	INCBIN "data/bank_04d/d_6ed0.bin" ; $6ed0, 240 bytes
BrianSpriteFrame49:
	INCBIN "data/bank_04d/d_6fc0.bin" ; $6fc0, 240 bytes
BrianSpriteFrame50:
	INCBIN "data/bank_04d/d_70b0.bin" ; $70b0, 240 bytes
BrianSpriteFrame51:
	INCBIN "data/bank_04d/d_71a0.bin" ; $71a0, 240 bytes
BrianSpriteFrame52:
	INCBIN "data/bank_04d/d_7290.bin" ; $7290, 240 bytes
BrianSpriteFrame53:
	INCBIN "data/bank_04d/d_7380.bin" ; $7380, 240 bytes
BrianSpriteFrame54:
	INCBIN "data/bank_04d/d_7470.bin" ; $7470, 240 bytes
BrianSpriteFrame55:
	INCBIN "data/bank_04d/d_7560.bin" ; $7560, 240 bytes
Data_4d_7650:
	INCBIN "data/bank_04d/d_7650.bin" ; $7650, 1680 bytes
Data_4d_7ce0:
	INCBIN "data/bank_04d/d_7ce0.bin" ; $7ce0, 580 bytes
BrianSpriteAnims:
	dw BrianSpriteAnim00 ; $7f24
	dw BrianSpriteAnim01 ; $7f26
	dw BrianSpriteAnim02 ; $7f28
	dw BrianSpriteAnim03 ; $7f2a
	dw BrianSpriteAnim04 ; $7f2c
	dw BrianSpriteAnim05 ; $7f2e
	dw BrianSpriteAnim06 ; $7f30
	dw BrianSpriteAnim07 ; $7f32
	dw BrianSpriteAnim08 ; $7f34
	dw BrianSpriteAnim09 ; $7f36
	dw BrianSpriteAnim10 ; $7f38
	dw BrianSpriteAnim11 ; $7f3a
	dw BrianSpriteAnim12 ; $7f3c
	dw BrianSpriteAnim13 ; $7f3e
	dw BrianSpriteAnim14 ; $7f40
	dw BrianSpriteAnim15 ; $7f42
	dw BrianSpriteAnim16 ; $7f44
	dw BrianSpriteAnim17 ; $7f46
	dw BrianSpriteAnim18 ; $7f48
BrianSpriteAnim00:
	INCBIN "data/bank_04d/d_7f4a.bin" ; $7f4a, 3 bytes
BrianSpriteAnim01:
	INCBIN "data/bank_04d/d_7f4d.bin" ; $7f4d, 10 bytes
BrianSpriteAnim02:
	INCBIN "data/bank_04d/d_7f57.bin" ; $7f57, 6 bytes
BrianSpriteAnim03:
	INCBIN "data/bank_04d/d_7f5d.bin" ; $7f5d, 18 bytes
BrianSpriteAnim04:
	INCBIN "data/bank_04d/d_7f6f.bin" ; $7f6f, 8 bytes
BrianSpriteAnim05:
	INCBIN "data/bank_04d/d_7f77.bin" ; $7f77, 6 bytes
BrianSpriteAnim06:
	INCBIN "data/bank_04d/d_7f7d.bin" ; $7f7d, 6 bytes
BrianSpriteAnim07:
	INCBIN "data/bank_04d/d_7f83.bin" ; $7f83, 6 bytes
BrianSpriteAnim08:
	INCBIN "data/bank_04d/d_7f89.bin" ; $7f89, 5 bytes
BrianSpriteAnim09:
	INCBIN "data/bank_04d/d_7f8e.bin" ; $7f8e, 4 bytes
BrianSpriteAnim10:
	INCBIN "data/bank_04d/d_7f92.bin" ; $7f92, 4 bytes
BrianSpriteAnim11:
	INCBIN "data/bank_04d/d_7f96.bin" ; $7f96, 4 bytes
BrianSpriteAnim12:
	INCBIN "data/bank_04d/d_7f9a.bin" ; $7f9a, 3 bytes
BrianSpriteAnim13:
	INCBIN "data/bank_04d/d_7f9d.bin" ; $7f9d, 3 bytes
BrianSpriteAnim14:
	INCBIN "data/bank_04d/d_7fa0.bin" ; $7fa0, 3 bytes
BrianSpriteAnim15:
	INCBIN "data/bank_04d/d_7fa3.bin" ; $7fa3, 3 bytes
BrianSpriteAnim16:
	INCBIN "data/bank_04d/d_7fa6.bin" ; $7fa6, 3 bytes
BrianSpriteAnim17:
	INCBIN "data/bank_04d/d_7fa9.bin" ; $7fa9, 12 bytes
BrianSpriteAnim18:
	INCBIN "data/bank_04d/d_7fb5.bin" ; $7fb5, 8 bytes
	; $7fbd, 67 bytes fill to bank end (linker-padded)
