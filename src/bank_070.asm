INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $70", ROMX[$4000], BANK[$70]

DataPtr_70_00:
	dw Data_70_400e ; $4000
DataPtr_70_02:
	dw Data_70_4cb1 ; $4002
DataPtr_70_04:
	dw Data_70_5951 ; $4004
DataPtr_70_06:
	dw Data_70_61d5 ; $4006
DataPtr_70_08:
	dw Data_70_6a55 ; $4008
	INCBIN "data/bank_070/d_400a.bin" ; $400a, 4 bytes
Data_70_400e:
	INCBIN "data/bank_070/d_400e.bin" ; $400e, 16 bytes
	INCBIN "data/bank_070/d_401e.bin" ; $401e, 3219 bytes
Data_70_4cb1:
	INCBIN "data/bank_070/d_4cb1.bin" ; $4cb1, 3232 bytes
Data_70_5951:
	INCBIN "data/bank_070/d_5951.bin" ; $5951, 16 bytes
	INCBIN "data/bank_070/d_5961.bin" ; $5961, 2164 bytes
Data_70_61d5:
	INCBIN "data/bank_070/d_61d5.bin" ; $61d5, 16 bytes
	INCBIN "data/bank_070/d_61e5.bin" ; $61e5, 2160 bytes
Data_70_6a55:
	INCBIN "data/bank_070/d_6a55.bin" ; $6a55, 5547 bytes
