INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $78", ROMX[$4000], BANK[$78]

SoundTable_78:
	dw $0140 ; $4000
	dw Data_78_4088 ; $4002
	dw $0060 ; $4004
	dw Data_78_4178 ; $4006
	dw $0280 ; $4008
	dw Data_78_426a ; $400a
	dw $03a0 ; $400c
	dw Data_78_43ce ; $400e
	dw $0140 ; $4010
	dw Data_78_4906 ; $4012
	dw $0060 ; $4014
	dw Data_78_4944 ; $4016
	dw $0280 ; $4018
	dw Data_78_4992 ; $401a
	dw $03a0 ; $401c
	dw Data_78_4a40 ; $401e
	dw $0140 ; $4020
	dw Data_78_4c86 ; $4022
	dw $0060 ; $4024
	dw Data_78_4e6c ; $4026
	dw $0280 ; $4028
	dw Data_78_502c ; $402a
	dw $03a0 ; $402c
	dw Data_78_549a ; $402e
	dw $0140 ; $4030
	dw Data_78_57da ; $4032
	dw $0060 ; $4034
	dw Data_78_59ec ; $4036
	dw $0280 ; $4038
	dw Data_78_5bfe ; $403a
	dw $03a0 ; $403c
	dw Data_78_5d08 ; $403e
	dw $0140 ; $4040
	dw Data_78_6040 ; $4042
	dw $0060 ; $4044
	dw Data_78_61f4 ; $4046
	dw $0280 ; $4048
	dw Data_78_6320 ; $404a
	dw $03a0 ; $404c
	dw Data_78_6482 ; $404e
	dw $0140 ; $4050
	dw Data_78_67e4 ; $4052
	dw $0060 ; $4054
	dw Data_78_6a54 ; $4056
	dw $0280 ; $4058
	dw Data_78_6c96 ; $405a
	dw $03a0 ; $405c
	dw Data_78_7192 ; $405e
	dw $0140 ; $4060
	dw Data_78_7696 ; $4062
	dw $0060 ; $4064
	dw Data_78_7818 ; $4066
	dw $0280 ; $4068
	dw Data_78_7ae0 ; $406a
	dw $03a0 ; $406c
	dw Data_78_7da4 ; $406e
	dw $0140 ; $4070
	dw Data_78_7f2c ; $4072
	dw $0060 ; $4074
	dw Data_78_7f66 ; $4076
	dw $0280 ; $4078
	dw Data_78_7f9e ; $407a
	dw $0300 ; $407c
	dw Data_78_7fb6 ; $407e
	dw $0300 ; $4080
	dw Data_78_7fcc ; $4082
	dw $0000 ; $4084
	dw Data_78_7fe6 ; $4086
Data_78_4088:
	INCBIN "data/bank_078/d_4088.bin" ; $4088, 240 bytes
Data_78_4178:
	INCBIN "data/bank_078/d_4178.bin" ; $4178, 242 bytes
Data_78_426a:
	INCBIN "data/bank_078/d_426a.bin" ; $426a, 356 bytes
Data_78_43ce:
	INCBIN "data/bank_078/d_43ce.bin" ; $43ce, 1336 bytes
Data_78_4906:
	INCBIN "data/bank_078/d_4906.bin" ; $4906, 62 bytes
Data_78_4944:
	INCBIN "data/bank_078/d_4944.bin" ; $4944, 78 bytes
Data_78_4992:
	INCBIN "data/bank_078/d_4992.bin" ; $4992, 174 bytes
Data_78_4a40:
	INCBIN "data/bank_078/d_4a40.bin" ; $4a40, 582 bytes
Data_78_4c86:
	INCBIN "data/bank_078/d_4c86.bin" ; $4c86, 486 bytes
Data_78_4e6c:
	INCBIN "data/bank_078/d_4e6c.bin" ; $4e6c, 448 bytes
Data_78_502c:
	INCBIN "data/bank_078/d_502c.bin" ; $502c, 1134 bytes
Data_78_549a:
	INCBIN "data/bank_078/d_549a.bin" ; $549a, 832 bytes
Data_78_57da:
	INCBIN "data/bank_078/d_57da.bin" ; $57da, 530 bytes
Data_78_59ec:
	INCBIN "data/bank_078/d_59ec.bin" ; $59ec, 530 bytes
Data_78_5bfe:
	INCBIN "data/bank_078/d_5bfe.bin" ; $5bfe, 266 bytes
Data_78_5d08:
	INCBIN "data/bank_078/d_5d08.bin" ; $5d08, 824 bytes
Data_78_6040:
	INCBIN "data/bank_078/d_6040.bin" ; $6040, 436 bytes
Data_78_61f4:
	INCBIN "data/bank_078/d_61f4.bin" ; $61f4, 300 bytes
Data_78_6320:
	INCBIN "data/bank_078/d_6320.bin" ; $6320, 354 bytes
Data_78_6482:
	INCBIN "data/bank_078/d_6482.bin" ; $6482, 866 bytes
Data_78_67e4:
	INCBIN "data/bank_078/d_67e4.bin" ; $67e4, 624 bytes
Data_78_6a54:
	INCBIN "data/bank_078/d_6a54.bin" ; $6a54, 578 bytes
Data_78_6c96:
	INCBIN "data/bank_078/d_6c96.bin" ; $6c96, 1276 bytes
Data_78_7192:
	INCBIN "data/bank_078/d_7192.bin" ; $7192, 1284 bytes
Data_78_7696:
	INCBIN "data/bank_078/d_7696.bin" ; $7696, 386 bytes
Data_78_7818:
	INCBIN "data/bank_078/d_7818.bin" ; $7818, 712 bytes
Data_78_7ae0:
	INCBIN "data/bank_078/d_7ae0.bin" ; $7ae0, 708 bytes
Data_78_7da4:
	INCBIN "data/bank_078/d_7da4.bin" ; $7da4, 392 bytes
Data_78_7f2c:
	INCBIN "data/bank_078/d_7f2c.bin" ; $7f2c, 58 bytes
Data_78_7f66:
	INCBIN "data/bank_078/d_7f66.bin" ; $7f66, 56 bytes
Data_78_7f9e:
	INCBIN "data/bank_078/d_7f9e.bin" ; $7f9e, 24 bytes
Data_78_7fb6:
	INCBIN "data/bank_078/d_7fb6.bin" ; $7fb6, 22 bytes
Data_78_7fcc:
	INCBIN "data/bank_078/d_7fcc.bin" ; $7fcc, 26 bytes
Data_78_7fe6:
	INCBIN "data/bank_078/d_7fe6.bin" ; $7fe6, 10 bytes
	INCBIN "data/bank_078/d_7ff0.bin" ; $7ff0, 16 bytes
