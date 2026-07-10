INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $5d", ROMX[$4000], BANK[$5d]

DataPtr_5d_00:
	dw Data_5d_4002 ; $4000
Data_5d_4002:
	INCBIN "data/bank_05d/d_4002.bin" ; $4002, 16 bytes
	INCBIN "data/bank_05d/d_4012.bin" ; $4012, 16366 bytes
