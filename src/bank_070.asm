INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $70", ROMX[$4000], BANK[$70]

DataPtr_70_00:
	dw Data_70_400e ; $4000
	INCBIN "data/bank_070/d_4002.bin" ; $4002, 12 bytes
Data_70_400e:
	INCBIN "data/bank_070/d_400e.bin" ; $400e, 16 bytes
	INCBIN "data/bank_070/d_401e.bin" ; $401e, 16354 bytes
