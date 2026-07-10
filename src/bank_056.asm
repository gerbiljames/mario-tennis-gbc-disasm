INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $56", ROMX[$4000], BANK[$56]

	INCBIN "data/bank_056/d_4000.bin" ; $4000, 16307 bytes
	ds 77, $ff ; $7fb3, fill
