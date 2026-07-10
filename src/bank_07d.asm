INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $7d", ROMX[$4000], BANK[$7d]

SoundTable_7d:
	dw $0140 ; $4000
	dw Data_7d_407c ; $4002
	dw $0060 ; $4004
	dw Data_7d_4306 ; $4006
	dw $0280 ; $4008
	dw Data_7d_4754 ; $400a
	dw $03a0 ; $400c
	dw Data_7d_4882 ; $400e
	dw $0140 ; $4010
	dw Data_7d_4f02 ; $4012
	dw $0060 ; $4014
	dw Data_7d_549c ; $4016
	dw $0280 ; $4018
	dw Data_7d_5a00 ; $401a
	dw $03a0 ; $401c
	dw Data_7d_60b2 ; $401e
	dw $0140 ; $4020
	dw Data_7d_66b8 ; $4022
	dw $0060 ; $4024
	dw Data_7d_68f2 ; $4026
	dw $0280 ; $4028
	dw Data_7d_6f3c ; $402a
	dw $03a0 ; $402c
	dw Data_7d_75ae ; $402e
	dw $0140 ; $4030
	dw Data_7d_7650 ; $4032
	dw $0060 ; $4034
	dw Data_7d_7760 ; $4036
	dw $0280 ; $4038
	dw Data_7d_786a ; $403a
	dw $03a0 ; $403c
	dw Data_7d_787e ; $403e
	dw $0140 ; $4040
	dw Data_7d_78e4 ; $4042
	dw $0060 ; $4044
	dw Data_7d_7988 ; $4046
	dw $0280 ; $4048
	dw Data_7d_7a2c ; $404a
	dw $03a0 ; $404c
	dw Data_7d_7b0c ; $404e
	dw $0140 ; $4050
	dw Data_7d_7c9a ; $4052
	dw $0060 ; $4054
	dw Data_7d_7cda ; $4056
	dw $0280 ; $4058
	dw Data_7d_7d1a ; $405a
	dw $03a0 ; $405c
	dw Data_7d_7d34 ; $405e
	dw $0140 ; $4060
	dw Data_7d_7df0 ; $4062
	dw $0060 ; $4064
	dw Data_7d_7e1a ; $4066
	dw $0280 ; $4068
	dw Data_7d_7e44 ; $406a
	dw $03a0 ; $406c
	dw Data_7d_7e6e ; $406e
	dw $0000 ; $4070
	dw Data_7d_7f50 ; $4072
	dw $0000 ; $4074
	dw Data_7d_7f9c ; $4076
	dw $0000 ; $4078
	dw Data_7d_7fe8 ; $407a
Data_7d_407c:
	INCBIN "data/bank_07d/d_407c.bin" ; $407c, 650 bytes
Data_7d_4306:
	INCBIN "data/bank_07d/d_4306.bin" ; $4306, 1102 bytes
Data_7d_4754:
	INCBIN "data/bank_07d/d_4754.bin" ; $4754, 302 bytes
Data_7d_4882:
	INCBIN "data/bank_07d/d_4882.bin" ; $4882, 1664 bytes
Data_7d_4f02:
	INCBIN "data/bank_07d/d_4f02.bin" ; $4f02, 1434 bytes
Data_7d_549c:
	INCBIN "data/bank_07d/d_549c.bin" ; $549c, 1380 bytes
Data_7d_5a00:
	INCBIN "data/bank_07d/d_5a00.bin" ; $5a00, 1714 bytes
Data_7d_60b2:
	INCBIN "data/bank_07d/d_60b2.bin" ; $60b2, 1542 bytes
Data_7d_66b8:
	INCBIN "data/bank_07d/d_66b8.bin" ; $66b8, 570 bytes
Data_7d_68f2:
	INCBIN "data/bank_07d/d_68f2.bin" ; $68f2, 1610 bytes
Data_7d_6f3c:
	INCBIN "data/bank_07d/d_6f3c.bin" ; $6f3c, 1650 bytes
Data_7d_75ae:
	INCBIN "data/bank_07d/d_75ae.bin" ; $75ae, 162 bytes
Data_7d_7650:
	INCBIN "data/bank_07d/d_7650.bin" ; $7650, 272 bytes
Data_7d_7760:
	INCBIN "data/bank_07d/d_7760.bin" ; $7760, 266 bytes
Data_7d_786a:
	INCBIN "data/bank_07d/d_786a.bin" ; $786a, 20 bytes
Data_7d_787e:
	INCBIN "data/bank_07d/d_787e.bin" ; $787e, 102 bytes
Data_7d_78e4:
	INCBIN "data/bank_07d/d_78e4.bin" ; $78e4, 164 bytes
Data_7d_7988:
	INCBIN "data/bank_07d/d_7988.bin" ; $7988, 164 bytes
Data_7d_7a2c:
	INCBIN "data/bank_07d/d_7a2c.bin" ; $7a2c, 224 bytes
Data_7d_7b0c:
	INCBIN "data/bank_07d/d_7b0c.bin" ; $7b0c, 398 bytes
Data_7d_7c9a:
	INCBIN "data/bank_07d/d_7c9a.bin" ; $7c9a, 64 bytes
Data_7d_7cda:
	INCBIN "data/bank_07d/d_7cda.bin" ; $7cda, 64 bytes
Data_7d_7d1a:
	INCBIN "data/bank_07d/d_7d1a.bin" ; $7d1a, 26 bytes
Data_7d_7d34:
	INCBIN "data/bank_07d/d_7d34.bin" ; $7d34, 188 bytes
Data_7d_7df0:
	INCBIN "data/bank_07d/d_7df0.bin" ; $7df0, 42 bytes
Data_7d_7e1a:
	INCBIN "data/bank_07d/d_7e1a.bin" ; $7e1a, 42 bytes
Data_7d_7e44:
	INCBIN "data/bank_07d/d_7e44.bin" ; $7e44, 42 bytes
Data_7d_7e6e:
	INCBIN "data/bank_07d/d_7e6e.bin" ; $7e6e, 226 bytes
Data_7d_7f50:
	INCBIN "data/bank_07d/d_7f50.bin" ; $7f50, 76 bytes
Data_7d_7f9c:
	INCBIN "data/bank_07d/d_7f9c.bin" ; $7f9c, 76 bytes
Data_7d_7fe8:
	INCBIN "data/bank_07d/d_7fe8.bin" ; $7fe8, 10 bytes
	INCBIN "data/bank_07d/d_7ff2.bin" ; $7ff2, 14 bytes
