SECTION "ROM Bank $7d", ROMX[$4000], BANK[$7d]

SoundTable_7d:
	dw $0140 ; $4000
	dw Sfx25_Trk0 ; $4002
	dw $0060 ; $4004
	dw Sfx25_Trk1 ; $4006
	dw $0280 ; $4008
	dw Sfx25_Trk2 ; $400a
	dw $03a0 ; $400c
	dw Sfx25_Trk3 ; $400e
	dw $0140 ; $4010
	dw Sfx26_Trk0 ; $4012
	dw $0060 ; $4014
	dw Sfx26_Trk1 ; $4016
	dw $0280 ; $4018
	dw Sfx26_Trk2 ; $401a
	dw $03a0 ; $401c
	dw Sfx26_Trk3 ; $401e
	dw $0140 ; $4020
	dw Sfx27_Trk0 ; $4022
	dw $0060 ; $4024
	dw Sfx27_Trk1 ; $4026
	dw $0280 ; $4028
	dw Sfx27_Trk2 ; $402a
	dw $03a0 ; $402c
	dw Sfx27_Trk3 ; $402e
	dw $0140 ; $4030
	dw Sfx2a_Trk0 ; $4032
	dw $0060 ; $4034
	dw Sfx2a_Trk1 ; $4036
	dw $0280 ; $4038
	dw Sfx2a_Trk2 ; $403a
	dw $03a0 ; $403c
	dw Sfx2a_Trk3 ; $403e
	dw $0140 ; $4040
	dw Sfx2b_Trk0 ; $4042
	dw $0060 ; $4044
	dw Sfx2b_Trk1 ; $4046
	dw $0280 ; $4048
	dw Sfx2b_Trk2 ; $404a
	dw $03a0 ; $404c
	dw Sfx2b_Trk3 ; $404e
	dw $0140 ; $4050
	dw Sfx30_Trk0 ; $4052
	dw $0060 ; $4054
	dw Sfx30_Trk1 ; $4056
	dw $0280 ; $4058
	dw Sfx30_Trk2 ; $405a
	dw $03a0 ; $405c
	dw Sfx30_Trk3 ; $405e
	dw $0140 ; $4060
	dw Sfx32_Trk0 ; $4062
	dw $0060 ; $4064
	dw Sfx32_Trk1 ; $4066
	dw $0280 ; $4068
	dw Sfx32_Trk2 ; $406a
	dw $03a0 ; $406c
	dw Sfx32_Trk3 ; $406e
	dw $0000 ; $4070
	dw Music5a_Trk0 ; $4072
	dw $0000 ; $4074
	dw Music5c_Trk0 ; $4076
	dw $0000 ; $4078
	dw Music9c_Trk0 ; $407a
Sfx25_Trk0:
	INCBIN "data/bank_07d/d_407c.bin" ; $407c, 650 bytes
Sfx25_Trk1:
	INCBIN "data/bank_07d/d_4306.bin" ; $4306, 1102 bytes
Sfx25_Trk2:
	INCBIN "data/bank_07d/d_4754.bin" ; $4754, 302 bytes
Sfx25_Trk3:
	INCBIN "data/bank_07d/d_4882.bin" ; $4882, 1664 bytes
Sfx26_Trk0:
	INCBIN "data/bank_07d/d_4f02.bin" ; $4f02, 1434 bytes
Sfx26_Trk1:
	INCBIN "data/bank_07d/d_549c.bin" ; $549c, 1380 bytes
Sfx26_Trk2:
	INCBIN "data/bank_07d/d_5a00.bin" ; $5a00, 1714 bytes
Sfx26_Trk3:
	INCBIN "data/bank_07d/d_60b2.bin" ; $60b2, 1542 bytes
Sfx27_Trk0:
	INCBIN "data/bank_07d/d_66b8.bin" ; $66b8, 570 bytes
Sfx27_Trk1:
	INCBIN "data/bank_07d/d_68f2.bin" ; $68f2, 1610 bytes
Sfx27_Trk2:
	INCBIN "data/bank_07d/d_6f3c.bin" ; $6f3c, 1650 bytes
Sfx27_Trk3:
	INCBIN "data/bank_07d/d_75ae.bin" ; $75ae, 162 bytes
Sfx2a_Trk0:
	INCBIN "data/bank_07d/d_7650.bin" ; $7650, 272 bytes
Sfx2a_Trk1:
	INCBIN "data/bank_07d/d_7760.bin" ; $7760, 266 bytes
Sfx2a_Trk2:
	INCBIN "data/bank_07d/d_786a.bin" ; $786a, 20 bytes
Sfx2a_Trk3:
	INCBIN "data/bank_07d/d_787e.bin" ; $787e, 102 bytes
Sfx2b_Trk0:
	INCBIN "data/bank_07d/d_78e4.bin" ; $78e4, 164 bytes
Sfx2b_Trk1:
	INCBIN "data/bank_07d/d_7988.bin" ; $7988, 164 bytes
Sfx2b_Trk2:
	INCBIN "data/bank_07d/d_7a2c.bin" ; $7a2c, 224 bytes
Sfx2b_Trk3:
	INCBIN "data/bank_07d/d_7b0c.bin" ; $7b0c, 398 bytes
Sfx30_Trk0:
	INCBIN "data/bank_07d/d_7c9a.bin" ; $7c9a, 64 bytes
Sfx30_Trk1:
	INCBIN "data/bank_07d/d_7cda.bin" ; $7cda, 64 bytes
Sfx30_Trk2:
	INCBIN "data/bank_07d/d_7d1a.bin" ; $7d1a, 26 bytes
Sfx30_Trk3:
	INCBIN "data/bank_07d/d_7d34.bin" ; $7d34, 188 bytes
Sfx32_Trk0:
	INCBIN "data/bank_07d/d_7df0.bin" ; $7df0, 42 bytes
Sfx32_Trk1:
	INCBIN "data/bank_07d/d_7e1a.bin" ; $7e1a, 42 bytes
Sfx32_Trk2:
	INCBIN "data/bank_07d/d_7e44.bin" ; $7e44, 42 bytes
Sfx32_Trk3:
	INCBIN "data/bank_07d/d_7e6e.bin" ; $7e6e, 226 bytes
Music5a_Trk0:
	INCBIN "data/bank_07d/d_7f50.bin" ; $7f50, 76 bytes
Music5c_Trk0:
	INCBIN "data/bank_07d/d_7f9c.bin" ; $7f9c, 76 bytes
Music9c_Trk0:
	INCBIN "data/bank_07d/d_7fe8.bin" ; $7fe8, 10 bytes
	; $7ff2, 14 bytes fill to bank end (linker-padded)
