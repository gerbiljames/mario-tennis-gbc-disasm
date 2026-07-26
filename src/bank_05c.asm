SECTION "ROM Bank $5c", ROMX[$4000], BANK[$5c]

	dw DKSpriteDesc ; $4000
DKSpriteDesc:
	dw $0004 ; $4002
	dw $0003 ; $4004
	dw DKSpriteFrames ; $4006 frame table
	dw DKSpriteAnims ; $4008 animation scripts
	dw $0000 ; $400a
	dw Data_5c_7ce0 ; $400c per-slot OAM data
DKSpriteFrames:
	dw DKSpriteFrame00 ; $400e
	dw DKSpriteFrame01 ; $4010
	dw DKSpriteFrame02 ; $4012
	dw DKSpriteFrame03 ; $4014
	dw DKSpriteFrame04 ; $4016
	dw DKSpriteFrame05 ; $4018
	dw DKSpriteFrame06 ; $401a
	dw DKSpriteFrame07 ; $401c
	dw DKSpriteFrame08 ; $401e
	dw DKSpriteFrame09 ; $4020
	dw DKSpriteFrame10 ; $4022
	dw DKSpriteFrame01 ; $4024
	dw DKSpriteFrame02 ; $4026
	dw DKSpriteFrame03 ; $4028
	dw DKSpriteFrame11 ; $402a
	dw DKSpriteFrame12 ; $402c
	dw DKSpriteFrame01 ; $402e
	dw DKSpriteFrame02 ; $4030
	dw DKSpriteFrame03 ; $4032
	dw DKSpriteFrame13 ; $4034
	dw DKSpriteFrame14 ; $4036
	dw DKSpriteFrame06 ; $4038
	dw DKSpriteFrame07 ; $403a
	dw DKSpriteFrame08 ; $403c
	dw DKSpriteFrame15 ; $403e
	dw DKSpriteFrame16 ; $4040
	dw DKSpriteFrame16 ; $4042
	dw DKSpriteFrame16 ; $4044
	dw DKSpriteFrame17 ; $4046
	dw DKSpriteFrame17 ; $4048
	dw DKSpriteFrame18 ; $404a
	dw DKSpriteFrame18 ; $404c
	dw DKSpriteFrame18 ; $404e
	dw DKSpriteFrame19 ; $4050
	dw DKSpriteFrame19 ; $4052
	dw DKSpriteFrame20 ; $4054
	dw DKSpriteFrame20 ; $4056
	dw DKSpriteFrame20 ; $4058
	dw DKSpriteFrame21 ; $405a
	dw DKSpriteFrame21 ; $405c
	dw DKSpriteFrame22 ; $405e
	dw DKSpriteFrame22 ; $4060
	dw DKSpriteFrame22 ; $4062
	dw DKSpriteFrame23 ; $4064
	dw DKSpriteFrame23 ; $4066
	dw DKSpriteFrame24 ; $4068
	dw DKSpriteFrame24 ; $406a
	dw DKSpriteFrame24 ; $406c
	dw DKSpriteFrame25 ; $406e
	dw DKSpriteFrame25 ; $4070
	dw DKSpriteFrame26 ; $4072
	dw DKSpriteFrame26 ; $4074
	dw DKSpriteFrame26 ; $4076
	dw DKSpriteFrame27 ; $4078
	dw DKSpriteFrame27 ; $407a
	dw DKSpriteFrame28 ; $407c
	dw DKSpriteFrame28 ; $407e
	dw DKSpriteFrame28 ; $4080
	dw DKSpriteFrame29 ; $4082
	dw DKSpriteFrame29 ; $4084
	dw DKSpriteFrame30 ; $4086
	dw DKSpriteFrame30 ; $4088
	dw DKSpriteFrame30 ; $408a
	dw DKSpriteFrame31 ; $408c
	dw DKSpriteFrame31 ; $408e
	dw DKSpriteFrame32 ; $4090
	dw DKSpriteFrame32 ; $4092
	dw DKSpriteFrame32 ; $4094
	dw DKSpriteFrame33 ; $4096
	dw DKSpriteFrame33 ; $4098
	dw DKSpriteFrame34 ; $409a
	dw DKSpriteFrame34 ; $409c
	dw DKSpriteFrame34 ; $409e
	dw DKSpriteFrame35 ; $40a0
	dw DKSpriteFrame35 ; $40a2
	dw DKSpriteFrame36 ; $40a4
	dw DKSpriteFrame36 ; $40a6
	dw DKSpriteFrame36 ; $40a8
	dw DKSpriteFrame37 ; $40aa
	dw DKSpriteFrame37 ; $40ac
	dw DKSpriteFrame38 ; $40ae
	dw DKSpriteFrame38 ; $40b0
	dw DKSpriteFrame38 ; $40b2
	dw DKSpriteFrame39 ; $40b4
	dw DKSpriteFrame39 ; $40b6
	dw DKSpriteFrame40 ; $40b8
	dw DKSpriteFrame40 ; $40ba
	dw DKSpriteFrame40 ; $40bc
	dw DKSpriteFrame41 ; $40be
	dw DKSpriteFrame41 ; $40c0
	dw DKSpriteFrame42 ; $40c2
	dw DKSpriteFrame42 ; $40c4
	dw DKSpriteFrame42 ; $40c6
	dw DKSpriteFrame42 ; $40c8
	dw DKSpriteFrame42 ; $40ca
	dw DKSpriteFrame43 ; $40cc
	dw DKSpriteFrame43 ; $40ce
	dw DKSpriteFrame43 ; $40d0
	dw DKSpriteFrame43 ; $40d2
	dw DKSpriteFrame43 ; $40d4
	dw DKSpriteFrame44 ; $40d6
	dw DKSpriteFrame44 ; $40d8
	dw DKSpriteFrame44 ; $40da
	dw DKSpriteFrame45 ; $40dc
	dw DKSpriteFrame45 ; $40de
	dw DKSpriteFrame46 ; $40e0
	dw DKSpriteFrame46 ; $40e2
	dw DKSpriteFrame46 ; $40e4
	dw DKSpriteFrame47 ; $40e6
	dw DKSpriteFrame47 ; $40e8
	dw DKSpriteFrame48 ; $40ea
	dw DKSpriteFrame48 ; $40ec
	dw DKSpriteFrame48 ; $40ee
	dw DKSpriteFrame49 ; $40f0
	dw DKSpriteFrame49 ; $40f2
	dw DKSpriteFrame50 ; $40f4
	dw DKSpriteFrame50 ; $40f6
	dw DKSpriteFrame50 ; $40f8
	dw DKSpriteFrame50 ; $40fa
	dw DKSpriteFrame50 ; $40fc
	dw DKSpriteFrame51 ; $40fe
	dw DKSpriteFrame51 ; $4100
	dw DKSpriteFrame51 ; $4102
	dw DKSpriteFrame51 ; $4104
	dw DKSpriteFrame51 ; $4106
	dw DKSpriteFrame52 ; $4108
	dw DKSpriteFrame52 ; $410a
	dw DKSpriteFrame52 ; $410c
	dw DKSpriteFrame52 ; $410e
	dw DKSpriteFrame52 ; $4110
	dw DKSpriteFrame53 ; $4112
	dw DKSpriteFrame53 ; $4114
	dw DKSpriteFrame53 ; $4116
	dw DKSpriteFrame53 ; $4118
	dw DKSpriteFrame53 ; $411a
	dw DKSpriteFrame54 ; $411c
	dw DKSpriteFrame54 ; $411e
	dw DKSpriteFrame54 ; $4120
	dw DKSpriteFrame54 ; $4122
	dw DKSpriteFrame54 ; $4124
	dw DKSpriteFrame55 ; $4126
	dw DKSpriteFrame55 ; $4128
	dw DKSpriteFrame55 ; $412a
	dw DKSpriteFrame55 ; $412c
	dw DKSpriteFrame55 ; $412e
DKSpriteFrame00:
	INCBIN "data/bank_05c/d_4130.bin" ; $4130, 240 bytes
DKSpriteFrame01:
	INCBIN "data/bank_05c/d_4220.bin" ; $4220, 240 bytes
DKSpriteFrame02:
	INCBIN "data/bank_05c/d_4310.bin" ; $4310, 240 bytes
DKSpriteFrame03:
	INCBIN "data/bank_05c/d_4400.bin" ; $4400, 240 bytes
DKSpriteFrame04:
	INCBIN "data/bank_05c/d_44f0.bin" ; $44f0, 240 bytes
DKSpriteFrame05:
	INCBIN "data/bank_05c/d_45e0.bin" ; $45e0, 240 bytes
DKSpriteFrame06:
	INCBIN "data/bank_05c/d_46d0.bin" ; $46d0, 240 bytes
DKSpriteFrame07:
	INCBIN "data/bank_05c/d_47c0.bin" ; $47c0, 240 bytes
DKSpriteFrame08:
	INCBIN "data/bank_05c/d_48b0.bin" ; $48b0, 240 bytes
DKSpriteFrame09:
	INCBIN "data/bank_05c/d_49a0.bin" ; $49a0, 240 bytes
DKSpriteFrame10:
	INCBIN "data/bank_05c/d_4a90.bin" ; $4a90, 240 bytes
DKSpriteFrame11:
	INCBIN "data/bank_05c/d_4b80.bin" ; $4b80, 240 bytes
DKSpriteFrame12:
	INCBIN "data/bank_05c/d_4c70.bin" ; $4c70, 240 bytes
DKSpriteFrame13:
	INCBIN "data/bank_05c/d_4d60.bin" ; $4d60, 240 bytes
DKSpriteFrame14:
	INCBIN "data/bank_05c/d_4e50.bin" ; $4e50, 240 bytes
DKSpriteFrame15:
	INCBIN "data/bank_05c/d_4f40.bin" ; $4f40, 240 bytes
DKSpriteFrame16:
	INCBIN "data/bank_05c/d_5030.bin" ; $5030, 240 bytes
DKSpriteFrame17:
	INCBIN "data/bank_05c/d_5120.bin" ; $5120, 240 bytes
DKSpriteFrame18:
	INCBIN "data/bank_05c/d_5210.bin" ; $5210, 240 bytes
DKSpriteFrame19:
	INCBIN "data/bank_05c/d_5300.bin" ; $5300, 240 bytes
DKSpriteFrame20:
	INCBIN "data/bank_05c/d_53f0.bin" ; $53f0, 240 bytes
DKSpriteFrame21:
	INCBIN "data/bank_05c/d_54e0.bin" ; $54e0, 240 bytes
DKSpriteFrame22:
	INCBIN "data/bank_05c/d_55d0.bin" ; $55d0, 240 bytes
DKSpriteFrame23:
	INCBIN "data/bank_05c/d_56c0.bin" ; $56c0, 240 bytes
DKSpriteFrame24:
	INCBIN "data/bank_05c/d_57b0.bin" ; $57b0, 240 bytes
DKSpriteFrame25:
	INCBIN "data/bank_05c/d_58a0.bin" ; $58a0, 240 bytes
DKSpriteFrame26:
	INCBIN "data/bank_05c/d_5990.bin" ; $5990, 240 bytes
DKSpriteFrame27:
	INCBIN "data/bank_05c/d_5a80.bin" ; $5a80, 240 bytes
DKSpriteFrame28:
	INCBIN "data/bank_05c/d_5b70.bin" ; $5b70, 240 bytes
DKSpriteFrame29:
	INCBIN "data/bank_05c/d_5c60.bin" ; $5c60, 240 bytes
DKSpriteFrame30:
	INCBIN "data/bank_05c/d_5d50.bin" ; $5d50, 240 bytes
DKSpriteFrame31:
	INCBIN "data/bank_05c/d_5e40.bin" ; $5e40, 240 bytes
DKSpriteFrame32:
	INCBIN "data/bank_05c/d_5f30.bin" ; $5f30, 240 bytes
DKSpriteFrame33:
	INCBIN "data/bank_05c/d_6020.bin" ; $6020, 240 bytes
DKSpriteFrame34:
	INCBIN "data/bank_05c/d_6110.bin" ; $6110, 240 bytes
DKSpriteFrame35:
	INCBIN "data/bank_05c/d_6200.bin" ; $6200, 240 bytes
DKSpriteFrame36:
	INCBIN "data/bank_05c/d_62f0.bin" ; $62f0, 240 bytes
DKSpriteFrame37:
	INCBIN "data/bank_05c/d_63e0.bin" ; $63e0, 240 bytes
DKSpriteFrame38:
	INCBIN "data/bank_05c/d_64d0.bin" ; $64d0, 240 bytes
DKSpriteFrame39:
	INCBIN "data/bank_05c/d_65c0.bin" ; $65c0, 240 bytes
DKSpriteFrame40:
	INCBIN "data/bank_05c/d_66b0.bin" ; $66b0, 320 bytes
DKSpriteFrame41:
	INCBIN "data/bank_05c/d_67f0.bin" ; $67f0, 320 bytes
DKSpriteFrame42:
	INCBIN "data/bank_05c/d_6930.bin" ; $6930, 240 bytes
DKSpriteFrame43:
	INCBIN "data/bank_05c/d_6a20.bin" ; $6a20, 240 bytes
DKSpriteFrame44:
	INCBIN "data/bank_05c/d_6b10.bin" ; $6b10, 240 bytes
DKSpriteFrame45:
	INCBIN "data/bank_05c/d_6c00.bin" ; $6c00, 240 bytes
DKSpriteFrame46:
	INCBIN "data/bank_05c/d_6cf0.bin" ; $6cf0, 240 bytes
DKSpriteFrame47:
	INCBIN "data/bank_05c/d_6de0.bin" ; $6de0, 240 bytes
DKSpriteFrame48:
	INCBIN "data/bank_05c/d_6ed0.bin" ; $6ed0, 240 bytes
DKSpriteFrame49:
	INCBIN "data/bank_05c/d_6fc0.bin" ; $6fc0, 240 bytes
DKSpriteFrame50:
	INCBIN "data/bank_05c/d_70b0.bin" ; $70b0, 240 bytes
DKSpriteFrame51:
	INCBIN "data/bank_05c/d_71a0.bin" ; $71a0, 240 bytes
DKSpriteFrame52:
	INCBIN "data/bank_05c/d_7290.bin" ; $7290, 240 bytes
DKSpriteFrame53:
	INCBIN "data/bank_05c/d_7380.bin" ; $7380, 240 bytes
DKSpriteFrame54:
	INCBIN "data/bank_05c/d_7470.bin" ; $7470, 240 bytes
DKSpriteFrame55:
	INCBIN "data/bank_05c/d_7560.bin" ; $7560, 240 bytes
Data_5c_7650:
	INCBIN "data/bank_05c/d_7650.bin" ; $7650, 1680 bytes
Data_5c_7ce0:
	INCBIN "data/bank_05c/d_7ce0.bin" ; $7ce0, 580 bytes
DKSpriteAnims:
	dw DKSpriteAnim00 ; $7f24
	dw DKSpriteAnim01 ; $7f26
	dw DKSpriteAnim02 ; $7f28
	dw DKSpriteAnim03 ; $7f2a
	dw DKSpriteAnim04 ; $7f2c
	dw DKSpriteAnim05 ; $7f2e
	dw DKSpriteAnim06 ; $7f30
	dw DKSpriteAnim07 ; $7f32
	dw DKSpriteAnim08 ; $7f34
	dw DKSpriteAnim09 ; $7f36
	dw DKSpriteAnim10 ; $7f38
	dw DKSpriteAnim11 ; $7f3a
	dw DKSpriteAnim12 ; $7f3c
	dw DKSpriteAnim13 ; $7f3e
	dw DKSpriteAnim14 ; $7f40
	dw DKSpriteAnim15 ; $7f42
	dw DKSpriteAnim16 ; $7f44
	dw DKSpriteAnim17 ; $7f46
	dw DKSpriteAnim18 ; $7f48
DKSpriteAnim00:
	INCBIN "data/bank_05c/d_7f4a.bin" ; $7f4a, 3 bytes
DKSpriteAnim01:
	INCBIN "data/bank_05c/d_7f4d.bin" ; $7f4d, 10 bytes
DKSpriteAnim02:
	INCBIN "data/bank_05c/d_7f57.bin" ; $7f57, 6 bytes
DKSpriteAnim03:
	INCBIN "data/bank_05c/d_7f5d.bin" ; $7f5d, 38 bytes
DKSpriteAnim04:
	INCBIN "data/bank_05c/d_7f83.bin" ; $7f83, 22 bytes
DKSpriteAnim05:
	INCBIN "data/bank_05c/d_7f99.bin" ; $7f99, 6 bytes
DKSpriteAnim06:
	INCBIN "data/bank_05c/d_7f9f.bin" ; $7f9f, 6 bytes
DKSpriteAnim07:
	INCBIN "data/bank_05c/d_7fa5.bin" ; $7fa5, 6 bytes
DKSpriteAnim08:
	INCBIN "data/bank_05c/d_7fab.bin" ; $7fab, 5 bytes
DKSpriteAnim09:
	INCBIN "data/bank_05c/d_7fb0.bin" ; $7fb0, 4 bytes
DKSpriteAnim10:
	INCBIN "data/bank_05c/d_7fb4.bin" ; $7fb4, 4 bytes
DKSpriteAnim11:
	INCBIN "data/bank_05c/d_7fb8.bin" ; $7fb8, 4 bytes
DKSpriteAnim12:
	INCBIN "data/bank_05c/d_7fbc.bin" ; $7fbc, 3 bytes
DKSpriteAnim13:
	INCBIN "data/bank_05c/d_7fbf.bin" ; $7fbf, 3 bytes
DKSpriteAnim14:
	INCBIN "data/bank_05c/d_7fc2.bin" ; $7fc2, 3 bytes
DKSpriteAnim15:
	INCBIN "data/bank_05c/d_7fc5.bin" ; $7fc5, 3 bytes
DKSpriteAnim16:
	INCBIN "data/bank_05c/d_7fc8.bin" ; $7fc8, 3 bytes
DKSpriteAnim17:
	INCBIN "data/bank_05c/d_7fcb.bin" ; $7fcb, 12 bytes
DKSpriteAnim18:
	INCBIN "data/bank_05c/d_7fd7.bin" ; $7fd7, 8 bytes
	; $7fdf, 33 bytes fill to bank end (linker-padded)
