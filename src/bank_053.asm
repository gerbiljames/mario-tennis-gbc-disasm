INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $53", ROMX[$4000], BANK[$53]

	dw SpriteDesc_53 ; $4000
SpriteDesc_53:
	dw $0005 ; $4002
	dw $0003 ; $4004
	dw SpriteFrames_53 ; $4006 frame table
	dw SpriteAnims_53 ; $4008 animation scripts
	dw $0000 ; $400a
	dw Data_53_7ce0 ; $400c per-slot OAM data
SpriteFrames_53:
	dw Data_53_4130 ; $400e
	dw Data_53_4220 ; $4010
	dw Data_53_4310 ; $4012
	dw Data_53_4400 ; $4014
	dw Data_53_44f0 ; $4016
	dw Data_53_45e0 ; $4018
	dw Data_53_46d0 ; $401a
	dw Data_53_47c0 ; $401c
	dw Data_53_48b0 ; $401e
	dw Data_53_49a0 ; $4020
	dw Data_53_4a90 ; $4022
	dw Data_53_4220 ; $4024
	dw Data_53_4310 ; $4026
	dw Data_53_4400 ; $4028
	dw Data_53_4b80 ; $402a
	dw Data_53_4c70 ; $402c
	dw Data_53_4220 ; $402e
	dw Data_53_4310 ; $4030
	dw Data_53_4400 ; $4032
	dw Data_53_4d60 ; $4034
	dw Data_53_4e50 ; $4036
	dw Data_53_46d0 ; $4038
	dw Data_53_47c0 ; $403a
	dw Data_53_48b0 ; $403c
	dw Data_53_4f40 ; $403e
	dw Data_53_5030 ; $4040
	dw Data_53_5030 ; $4042
	dw Data_53_5030 ; $4044
	dw Data_53_5120 ; $4046
	dw Data_53_5120 ; $4048
	dw Data_53_5210 ; $404a
	dw Data_53_5210 ; $404c
	dw Data_53_5210 ; $404e
	dw Data_53_5300 ; $4050
	dw Data_53_5300 ; $4052
	dw Data_53_53f0 ; $4054
	dw Data_53_53f0 ; $4056
	dw Data_53_53f0 ; $4058
	dw Data_53_54e0 ; $405a
	dw Data_53_54e0 ; $405c
	dw Data_53_55d0 ; $405e
	dw Data_53_55d0 ; $4060
	dw Data_53_55d0 ; $4062
	dw Data_53_56c0 ; $4064
	dw Data_53_56c0 ; $4066
	dw Data_53_57b0 ; $4068
	dw Data_53_57b0 ; $406a
	dw Data_53_57b0 ; $406c
	dw Data_53_58a0 ; $406e
	dw Data_53_58a0 ; $4070
	dw Data_53_5990 ; $4072
	dw Data_53_5990 ; $4074
	dw Data_53_5990 ; $4076
	dw Data_53_5a80 ; $4078
	dw Data_53_5a80 ; $407a
	dw Data_53_5b70 ; $407c
	dw Data_53_5b70 ; $407e
	dw Data_53_5b70 ; $4080
	dw Data_53_5c60 ; $4082
	dw Data_53_5c60 ; $4084
	dw Data_53_5d50 ; $4086
	dw Data_53_5d50 ; $4088
	dw Data_53_5d50 ; $408a
	dw Data_53_5e40 ; $408c
	dw Data_53_5e40 ; $408e
	dw Data_53_5f30 ; $4090
	dw Data_53_5f30 ; $4092
	dw Data_53_5f30 ; $4094
	dw Data_53_6020 ; $4096
	dw Data_53_6020 ; $4098
	dw Data_53_6110 ; $409a
	dw Data_53_6110 ; $409c
	dw Data_53_6110 ; $409e
	dw Data_53_6200 ; $40a0
	dw Data_53_6200 ; $40a2
	dw Data_53_62f0 ; $40a4
	dw Data_53_62f0 ; $40a6
	dw Data_53_62f0 ; $40a8
	dw Data_53_63e0 ; $40aa
	dw Data_53_63e0 ; $40ac
	dw Data_53_64d0 ; $40ae
	dw Data_53_64d0 ; $40b0
	dw Data_53_64d0 ; $40b2
	dw Data_53_65c0 ; $40b4
	dw Data_53_65c0 ; $40b6
	dw Data_53_66b0 ; $40b8
	dw Data_53_66b0 ; $40ba
	dw Data_53_66b0 ; $40bc
	dw Data_53_67f0 ; $40be
	dw Data_53_67f0 ; $40c0
	dw Data_53_6930 ; $40c2
	dw Data_53_6930 ; $40c4
	dw Data_53_6930 ; $40c6
	dw Data_53_6930 ; $40c8
	dw Data_53_6930 ; $40ca
	dw Data_53_6a20 ; $40cc
	dw Data_53_6a20 ; $40ce
	dw Data_53_6a20 ; $40d0
	dw Data_53_6a20 ; $40d2
	dw Data_53_6a20 ; $40d4
	dw Data_53_6b10 ; $40d6
	dw Data_53_6b10 ; $40d8
	dw Data_53_6b10 ; $40da
	dw Data_53_6c00 ; $40dc
	dw Data_53_6c00 ; $40de
	dw Data_53_6cf0 ; $40e0
	dw Data_53_6cf0 ; $40e2
	dw Data_53_6cf0 ; $40e4
	dw Data_53_6de0 ; $40e6
	dw Data_53_6de0 ; $40e8
	dw Data_53_6ed0 ; $40ea
	dw Data_53_6ed0 ; $40ec
	dw Data_53_6ed0 ; $40ee
	dw Data_53_6fc0 ; $40f0
	dw Data_53_6fc0 ; $40f2
	dw Data_53_70b0 ; $40f4
	dw Data_53_70b0 ; $40f6
	dw Data_53_70b0 ; $40f8
	dw Data_53_70b0 ; $40fa
	dw Data_53_70b0 ; $40fc
	dw Data_53_71a0 ; $40fe
	dw Data_53_71a0 ; $4100
	dw Data_53_71a0 ; $4102
	dw Data_53_71a0 ; $4104
	dw Data_53_71a0 ; $4106
	dw Data_53_7290 ; $4108
	dw Data_53_7290 ; $410a
	dw Data_53_7290 ; $410c
	dw Data_53_7290 ; $410e
	dw Data_53_7290 ; $4110
	dw Data_53_7380 ; $4112
	dw Data_53_7380 ; $4114
	dw Data_53_7380 ; $4116
	dw Data_53_7380 ; $4118
	dw Data_53_7380 ; $411a
	dw Data_53_7470 ; $411c
	dw Data_53_7470 ; $411e
	dw Data_53_7470 ; $4120
	dw Data_53_7470 ; $4122
	dw Data_53_7470 ; $4124
	dw Data_53_7560 ; $4126
	dw Data_53_7560 ; $4128
	dw Data_53_7560 ; $412a
	dw Data_53_7560 ; $412c
	dw Data_53_7560 ; $412e
Data_53_4130:
	INCBIN "data/bank_053/d_4130.bin" ; $4130, 240 bytes
Data_53_4220:
	INCBIN "data/bank_053/d_4220.bin" ; $4220, 240 bytes
Data_53_4310:
	INCBIN "data/bank_053/d_4310.bin" ; $4310, 240 bytes
Data_53_4400:
	INCBIN "data/bank_053/d_4400.bin" ; $4400, 240 bytes
Data_53_44f0:
	INCBIN "data/bank_053/d_44f0.bin" ; $44f0, 240 bytes
Data_53_45e0:
	INCBIN "data/bank_053/d_45e0.bin" ; $45e0, 240 bytes
Data_53_46d0:
	INCBIN "data/bank_053/d_46d0.bin" ; $46d0, 240 bytes
Data_53_47c0:
	INCBIN "data/bank_053/d_47c0.bin" ; $47c0, 240 bytes
Data_53_48b0:
	INCBIN "data/bank_053/d_48b0.bin" ; $48b0, 240 bytes
Data_53_49a0:
	INCBIN "data/bank_053/d_49a0.bin" ; $49a0, 240 bytes
Data_53_4a90:
	INCBIN "data/bank_053/d_4a90.bin" ; $4a90, 240 bytes
Data_53_4b80:
	INCBIN "data/bank_053/d_4b80.bin" ; $4b80, 240 bytes
Data_53_4c70:
	INCBIN "data/bank_053/d_4c70.bin" ; $4c70, 240 bytes
Data_53_4d60:
	INCBIN "data/bank_053/d_4d60.bin" ; $4d60, 240 bytes
Data_53_4e50:
	INCBIN "data/bank_053/d_4e50.bin" ; $4e50, 240 bytes
Data_53_4f40:
	INCBIN "data/bank_053/d_4f40.bin" ; $4f40, 240 bytes
Data_53_5030:
	INCBIN "data/bank_053/d_5030.bin" ; $5030, 240 bytes
Data_53_5120:
	INCBIN "data/bank_053/d_5120.bin" ; $5120, 240 bytes
Data_53_5210:
	INCBIN "data/bank_053/d_5210.bin" ; $5210, 240 bytes
Data_53_5300:
	INCBIN "data/bank_053/d_5300.bin" ; $5300, 240 bytes
Data_53_53f0:
	INCBIN "data/bank_053/d_53f0.bin" ; $53f0, 240 bytes
Data_53_54e0:
	INCBIN "data/bank_053/d_54e0.bin" ; $54e0, 240 bytes
Data_53_55d0:
	INCBIN "data/bank_053/d_55d0.bin" ; $55d0, 240 bytes
Data_53_56c0:
	INCBIN "data/bank_053/d_56c0.bin" ; $56c0, 240 bytes
Data_53_57b0:
	INCBIN "data/bank_053/d_57b0.bin" ; $57b0, 240 bytes
Data_53_58a0:
	INCBIN "data/bank_053/d_58a0.bin" ; $58a0, 240 bytes
Data_53_5990:
	INCBIN "data/bank_053/d_5990.bin" ; $5990, 240 bytes
Data_53_5a80:
	INCBIN "data/bank_053/d_5a80.bin" ; $5a80, 240 bytes
Data_53_5b70:
	INCBIN "data/bank_053/d_5b70.bin" ; $5b70, 240 bytes
Data_53_5c60:
	INCBIN "data/bank_053/d_5c60.bin" ; $5c60, 240 bytes
Data_53_5d50:
	INCBIN "data/bank_053/d_5d50.bin" ; $5d50, 240 bytes
Data_53_5e40:
	INCBIN "data/bank_053/d_5e40.bin" ; $5e40, 240 bytes
Data_53_5f30:
	INCBIN "data/bank_053/d_5f30.bin" ; $5f30, 240 bytes
Data_53_6020:
	INCBIN "data/bank_053/d_6020.bin" ; $6020, 240 bytes
Data_53_6110:
	INCBIN "data/bank_053/d_6110.bin" ; $6110, 240 bytes
Data_53_6200:
	INCBIN "data/bank_053/d_6200.bin" ; $6200, 240 bytes
Data_53_62f0:
	INCBIN "data/bank_053/d_62f0.bin" ; $62f0, 240 bytes
Data_53_63e0:
	INCBIN "data/bank_053/d_63e0.bin" ; $63e0, 240 bytes
Data_53_64d0:
	INCBIN "data/bank_053/d_64d0.bin" ; $64d0, 240 bytes
Data_53_65c0:
	INCBIN "data/bank_053/d_65c0.bin" ; $65c0, 240 bytes
Data_53_66b0:
	INCBIN "data/bank_053/d_66b0.bin" ; $66b0, 320 bytes
Data_53_67f0:
	INCBIN "data/bank_053/d_67f0.bin" ; $67f0, 320 bytes
Data_53_6930:
	INCBIN "data/bank_053/d_6930.bin" ; $6930, 240 bytes
Data_53_6a20:
	INCBIN "data/bank_053/d_6a20.bin" ; $6a20, 240 bytes
Data_53_6b10:
	INCBIN "data/bank_053/d_6b10.bin" ; $6b10, 240 bytes
Data_53_6c00:
	INCBIN "data/bank_053/d_6c00.bin" ; $6c00, 240 bytes
Data_53_6cf0:
	INCBIN "data/bank_053/d_6cf0.bin" ; $6cf0, 240 bytes
Data_53_6de0:
	INCBIN "data/bank_053/d_6de0.bin" ; $6de0, 240 bytes
Data_53_6ed0:
	INCBIN "data/bank_053/d_6ed0.bin" ; $6ed0, 240 bytes
Data_53_6fc0:
	INCBIN "data/bank_053/d_6fc0.bin" ; $6fc0, 240 bytes
Data_53_70b0:
	INCBIN "data/bank_053/d_70b0.bin" ; $70b0, 240 bytes
Data_53_71a0:
	INCBIN "data/bank_053/d_71a0.bin" ; $71a0, 240 bytes
Data_53_7290:
	INCBIN "data/bank_053/d_7290.bin" ; $7290, 240 bytes
Data_53_7380:
	INCBIN "data/bank_053/d_7380.bin" ; $7380, 240 bytes
Data_53_7470:
	INCBIN "data/bank_053/d_7470.bin" ; $7470, 240 bytes
Data_53_7560:
	INCBIN "data/bank_053/d_7560.bin" ; $7560, 240 bytes
Data_53_7650:
	INCBIN "data/bank_053/d_7650.bin" ; $7650, 1680 bytes
Data_53_7ce0:
	INCBIN "data/bank_053/d_7ce0.bin" ; $7ce0, 580 bytes
SpriteAnims_53:
	dw Data_53_7f4a ; $7f24
	dw Data_53_7f4d ; $7f26
	dw Data_53_7f57 ; $7f28
	dw Data_53_7f5d ; $7f2a
	dw Data_53_7f6f ; $7f2c
	dw Data_53_7f79 ; $7f2e
	dw Data_53_7f7f ; $7f30
	dw Data_53_7f85 ; $7f32
	dw Data_53_7f8b ; $7f34
	dw Data_53_7f90 ; $7f36
	dw Data_53_7f94 ; $7f38
	dw Data_53_7f98 ; $7f3a
	dw Data_53_7f9c ; $7f3c
	dw Data_53_7f9f ; $7f3e
	dw Data_53_7fa2 ; $7f40
	dw Data_53_7fa5 ; $7f42
	dw Data_53_7fa8 ; $7f44
	dw Data_53_7fab ; $7f46
	dw Data_53_7fb7 ; $7f48
Data_53_7f4a:
	INCBIN "data/bank_053/d_7f4a.bin" ; $7f4a, 3 bytes
Data_53_7f4d:
	INCBIN "data/bank_053/d_7f4d.bin" ; $7f4d, 10 bytes
Data_53_7f57:
	INCBIN "data/bank_053/d_7f57.bin" ; $7f57, 6 bytes
Data_53_7f5d:
	INCBIN "data/bank_053/d_7f5d.bin" ; $7f5d, 18 bytes
Data_53_7f6f:
	INCBIN "data/bank_053/d_7f6f.bin" ; $7f6f, 10 bytes
Data_53_7f79:
	INCBIN "data/bank_053/d_7f79.bin" ; $7f79, 6 bytes
Data_53_7f7f:
	INCBIN "data/bank_053/d_7f7f.bin" ; $7f7f, 6 bytes
Data_53_7f85:
	INCBIN "data/bank_053/d_7f85.bin" ; $7f85, 6 bytes
Data_53_7f8b:
	INCBIN "data/bank_053/d_7f8b.bin" ; $7f8b, 5 bytes
Data_53_7f90:
	INCBIN "data/bank_053/d_7f90.bin" ; $7f90, 4 bytes
Data_53_7f94:
	INCBIN "data/bank_053/d_7f94.bin" ; $7f94, 4 bytes
Data_53_7f98:
	INCBIN "data/bank_053/d_7f98.bin" ; $7f98, 4 bytes
Data_53_7f9c:
	INCBIN "data/bank_053/d_7f9c.bin" ; $7f9c, 3 bytes
Data_53_7f9f:
	INCBIN "data/bank_053/d_7f9f.bin" ; $7f9f, 3 bytes
Data_53_7fa2:
	INCBIN "data/bank_053/d_7fa2.bin" ; $7fa2, 3 bytes
Data_53_7fa5:
	INCBIN "data/bank_053/d_7fa5.bin" ; $7fa5, 3 bytes
Data_53_7fa8:
	INCBIN "data/bank_053/d_7fa8.bin" ; $7fa8, 3 bytes
Data_53_7fab:
	INCBIN "data/bank_053/d_7fab.bin" ; $7fab, 12 bytes
Data_53_7fb7:
	INCBIN "data/bank_053/d_7fb7.bin" ; $7fb7, 8 bytes
	ds 65, $ff ; $7fbf, fill
