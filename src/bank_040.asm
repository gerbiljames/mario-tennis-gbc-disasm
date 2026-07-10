INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $40", ROMX[$4000], BANK[$40]

DataPtr_40_00:
	dw Data_40_4002 ; $4000
Data_40_4002:
	INCBIN "data/bank_040/d_4002.bin" ; $4002, 16 bytes
	INCBIN "data/bank_040/d_4012.bin" ; $4012, 16366 bytes
