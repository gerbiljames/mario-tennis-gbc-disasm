INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $4e", ROMX[$4000], BANK[$4e]

DataPtr_4e_00:
	dw Data_4e_4002 ; $4000
Data_4e_4002:
	INCBIN "data/bank_04e/d_4002.bin" ; $4002, 16 bytes
	INCBIN "data/bank_04e/d_4012.bin" ; $4012, 16289 bytes
	ds 77, $ff ; $7fb3, fill
