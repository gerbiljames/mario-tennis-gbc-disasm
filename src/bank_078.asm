SECTION "ROM Bank $78", ROMX[$4000], BANK[$78]

SoundTable_78:
	dw $0140 ; $4000
	dw Sfx01_Trk0 ; $4002
	dw $0060 ; $4004
	dw Sfx01_Trk1 ; $4006
	dw $0280 ; $4008
	dw Sfx01_Trk2 ; $400a
	dw $03a0 ; $400c
	dw Sfx01_Trk3 ; $400e
	dw $0140 ; $4010
	dw Sfx02_Trk0 ; $4012
	dw $0060 ; $4014
	dw Sfx02_Trk1 ; $4016
	dw $0280 ; $4018
	dw Sfx02_Trk2 ; $401a
	dw $03a0 ; $401c
	dw Sfx02_Trk3 ; $401e
	dw $0140 ; $4020
	dw Sfx03_Trk0 ; $4022
	dw $0060 ; $4024
	dw Sfx03_Trk1 ; $4026
	dw $0280 ; $4028
	dw Sfx03_Trk2 ; $402a
	dw $03a0 ; $402c
	dw Sfx03_Trk3 ; $402e
	dw $0140 ; $4030
	dw Sfx04_Trk0 ; $4032
	dw $0060 ; $4034
	dw Sfx04_Trk1 ; $4036
	dw $0280 ; $4038
	dw Sfx04_Trk2 ; $403a
	dw $03a0 ; $403c
	dw Sfx04_Trk3 ; $403e
	dw $0140 ; $4040
	dw Sfx05_Trk0 ; $4042
	dw $0060 ; $4044
	dw Sfx05_Trk1 ; $4046
	dw $0280 ; $4048
	dw Sfx05_Trk2 ; $404a
	dw $03a0 ; $404c
	dw Sfx05_Trk3 ; $404e
	dw $0140 ; $4050
	dw Sfx06_Trk0 ; $4052
	dw $0060 ; $4054
	dw Sfx06_Trk1 ; $4056
	dw $0280 ; $4058
	dw Sfx06_Trk2 ; $405a
	dw $03a0 ; $405c
	dw Sfx06_Trk3 ; $405e
	dw $0140 ; $4060
	dw Sfx07_Trk0 ; $4062
	dw $0060 ; $4064
	dw Sfx07_Trk1 ; $4066
	dw $0280 ; $4068
	dw Sfx07_Trk2 ; $406a
	dw $03a0 ; $406c
	dw Sfx07_Trk3 ; $406e
	dw $0140 ; $4070
	dw Sfx0a_Trk0 ; $4072
	dw $0060 ; $4074
	dw Sfx0a_Trk1 ; $4076
	dw $0280 ; $4078
	dw Sfx0a_Trk2 ; $407a
	dw $0300 ; $407c
	dw Music51_Trk0 ; $407e
	dw $0300 ; $4080
	dw Music52_Trk0 ; $4082
	dw $0000 ; $4084
	dw Music9a_Trk0 ; $4086
Sfx01_Trk0:
	INCBIN "data/bank_078/d_4088.bin" ; $4088, 240 bytes
Sfx01_Trk1:
	INCBIN "data/bank_078/d_4178.bin" ; $4178, 242 bytes
Sfx01_Trk2:
	INCBIN "data/bank_078/d_426a.bin" ; $426a, 356 bytes
Sfx01_Trk3:
	INCBIN "data/bank_078/d_43ce.bin" ; $43ce, 1336 bytes
Sfx02_Trk0:
	INCBIN "data/bank_078/d_4906.bin" ; $4906, 62 bytes
Sfx02_Trk1:
	INCBIN "data/bank_078/d_4944.bin" ; $4944, 78 bytes
Sfx02_Trk2:
	INCBIN "data/bank_078/d_4992.bin" ; $4992, 174 bytes
Sfx02_Trk3:
	INCBIN "data/bank_078/d_4a40.bin" ; $4a40, 582 bytes
Sfx03_Trk0:
	INCBIN "data/bank_078/d_4c86.bin" ; $4c86, 486 bytes
Sfx03_Trk1:
	INCBIN "data/bank_078/d_4e6c.bin" ; $4e6c, 448 bytes
Sfx03_Trk2:
	INCBIN "data/bank_078/d_502c.bin" ; $502c, 1134 bytes
Sfx03_Trk3:
	INCBIN "data/bank_078/d_549a.bin" ; $549a, 832 bytes
Sfx04_Trk0:
	INCBIN "data/bank_078/d_57da.bin" ; $57da, 530 bytes
Sfx04_Trk1:
	INCBIN "data/bank_078/d_59ec.bin" ; $59ec, 530 bytes
Sfx04_Trk2:
	INCBIN "data/bank_078/d_5bfe.bin" ; $5bfe, 266 bytes
Sfx04_Trk3:
	INCBIN "data/bank_078/d_5d08.bin" ; $5d08, 824 bytes
Sfx05_Trk0:
	INCBIN "data/bank_078/d_6040.bin" ; $6040, 436 bytes
Sfx05_Trk1:
	INCBIN "data/bank_078/d_61f4.bin" ; $61f4, 300 bytes
Sfx05_Trk2:
	INCBIN "data/bank_078/d_6320.bin" ; $6320, 354 bytes
Sfx05_Trk3:
	INCBIN "data/bank_078/d_6482.bin" ; $6482, 866 bytes
Sfx06_Trk0:
	INCBIN "data/bank_078/d_67e4.bin" ; $67e4, 624 bytes
Sfx06_Trk1:
	INCBIN "data/bank_078/d_6a54.bin" ; $6a54, 578 bytes
Sfx06_Trk2:
	INCBIN "data/bank_078/d_6c96.bin" ; $6c96, 1276 bytes
Sfx06_Trk3:
	INCBIN "data/bank_078/d_7192.bin" ; $7192, 1284 bytes
Sfx07_Trk0:
	INCBIN "data/bank_078/d_7696.bin" ; $7696, 386 bytes
Sfx07_Trk1:
	INCBIN "data/bank_078/d_7818.bin" ; $7818, 712 bytes
Sfx07_Trk2:
	INCBIN "data/bank_078/d_7ae0.bin" ; $7ae0, 708 bytes
Sfx07_Trk3:
	INCBIN "data/bank_078/d_7da4.bin" ; $7da4, 392 bytes
Sfx0a_Trk0:
	INCBIN "data/bank_078/d_7f2c.bin" ; $7f2c, 58 bytes
Sfx0a_Trk1:
	INCBIN "data/bank_078/d_7f66.bin" ; $7f66, 56 bytes
Sfx0a_Trk2:
	INCBIN "data/bank_078/d_7f9e.bin" ; $7f9e, 24 bytes
Music51_Trk0:
	INCBIN "data/bank_078/d_7fb6.bin" ; $7fb6, 22 bytes
Music52_Trk0:
	INCBIN "data/bank_078/d_7fcc.bin" ; $7fcc, 26 bytes
Music9a_Trk0:
	INCBIN "data/bank_078/d_7fe6.bin" ; $7fe6, 10 bytes
	; $7ff0, 16 bytes fill to bank end (linker-padded)
