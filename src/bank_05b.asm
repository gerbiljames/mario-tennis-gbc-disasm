INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $5b", ROMX[$4000], BANK[$5b]

DataPtr_5b_00:
	dw Data_5b_4002 ; $4000
Data_5b_4002:
	INCBIN "data/bank_05b/d_4002.bin" ; $4002, 16 bytes
	INCBIN "data/bank_05b/d_4012.bin" ; $4012, 16293 bytes
	ds 73, $ff ; $7fb7, fill
