INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $3c", ROMX[$4000], BANK[$3c]

DataPtr_3c_00:
	dw Lz_3c_407e ; $4000
DataPtr_3c_02:
	dw Lz_3c_4581 ; $4002
DataPtr_3c_04:
	dw Lz_3c_468d ; $4004
	INCBIN "data/bank_03c/d_4006.bin" ; $4006, 2 bytes
DataPtr_3c_08:
	dw Lz_3c_4751 ; $4008
DataPtr_3c_0a:
	dw Lz_3c_50f2 ; $400a
DataPtr_3c_0c:
	dw Lz_3c_52e6 ; $400c
DataPtr_3c_0e:
	dw Data_3c_5351 ; $400e
DataPtr_3c_10:
	dw Lz_3c_5391 ; $4010
DataPtr_3c_12:
	dw Lz_3c_53d8 ; $4012
DataPtr_3c_14:
	dw Lz_3c_54bc ; $4014
DataPtr_3c_16:
	dw Lz_3c_55b4 ; $4016
DataPtr_3c_18:
	dw Lz_3c_569f ; $4018
DataPtr_3c_1a:
	dw Lz_3c_5792 ; $401a
DataPtr_3c_1c:
	dw Lz_3c_5879 ; $401c
DataPtr_3c_1e:
	dw Lz_3c_5967 ; $401e
DataPtr_3c_20:
	dw Lz_3c_599a ; $4020
	INCBIN "data/bank_03c/d_4022.bin" ; $4022, 92 bytes
Lz_3c_407e:
	INCBIN "data/bank_03c/lz_407e.bin" ; $407e, 1283 bytes
Lz_3c_4581:
	INCBIN "data/bank_03c/lz_4581.bin" ; $4581, 268 bytes
Lz_3c_468d:
	INCBIN "data/bank_03c/lz_468d.bin" ; $468d, 132 bytes
	INCBIN "data/bank_03c/d_4711.bin" ; $4711, 64 bytes
Lz_3c_4751:
	INCBIN "data/bank_03c/lz_4751.bin" ; $4751, 2465 bytes
Lz_3c_50f2:
	INCBIN "data/bank_03c/lz_50f2.bin" ; $50f2, 500 bytes
Lz_3c_52e6:
	INCBIN "data/bank_03c/lz_52e6.bin" ; $52e6, 107 bytes
Data_3c_5351:
	INCBIN "data/bank_03c/d_5351.bin" ; $5351, 64 bytes
Lz_3c_5391:
	INCBIN "data/bank_03c/lz_5391.bin" ; $5391, 71 bytes
Lz_3c_53d8:
	INCBIN "data/bank_03c/lz_53d8.bin" ; $53d8, 228 bytes
Lz_3c_54bc:
	INCBIN "data/bank_03c/lz_54bc.bin" ; $54bc, 248 bytes
Lz_3c_55b4:
	INCBIN "data/bank_03c/lz_55b4.bin" ; $55b4, 235 bytes
Lz_3c_569f:
	INCBIN "data/bank_03c/lz_569f.bin" ; $569f, 243 bytes
Lz_3c_5792:
	INCBIN "data/bank_03c/lz_5792.bin" ; $5792, 231 bytes
Lz_3c_5879:
	INCBIN "data/bank_03c/lz_5879.bin" ; $5879, 238 bytes
Lz_3c_5967:
	INCBIN "data/bank_03c/lz_5967.bin" ; $5967, 51 bytes
Lz_3c_599a:
	INCBIN "data/bank_03c/lz_599a.bin" ; $599a, 268 bytes
	INCBIN "data/bank_03c/d_5aa6.bin" ; $5aa6, 9562 bytes
