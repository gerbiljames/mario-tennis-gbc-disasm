INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $5a", ROMX[$4000], BANK[$5a]

DataPtr_5a_00:
	dw Data_5a_4002 ; $4000
Data_5a_4002:
	INCBIN "data/bank_05a/d_4002.bin" ; $4002, 16 bytes
	INCBIN "data/bank_05a/d_4012.bin" ; $4012, 16279 bytes
	ds 87, $ff ; $7fa9, fill
