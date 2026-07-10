INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $5c", ROMX[$4000], BANK[$5c]

DataPtr_5c_00:
	dw Data_5c_4002 ; $4000
Data_5c_4002:
	INCBIN "data/bank_05c/d_4002.bin" ; $4002, 16 bytes
	INCBIN "data/bank_05c/d_4012.bin" ; $4012, 16366 bytes
