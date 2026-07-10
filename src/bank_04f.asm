INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $4f", ROMX[$4000], BANK[$4f]

DataPtr_4f_00:
	dw Data_4f_4002 ; $4000
Data_4f_4002:
	INCBIN "data/bank_04f/d_4002.bin" ; $4002, 16 bytes
	INCBIN "data/bank_04f/d_4012.bin" ; $4012, 16366 bytes
