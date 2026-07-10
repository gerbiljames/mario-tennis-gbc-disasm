INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $45", ROMX[$4000], BANK[$45]

	INCBIN "data/bank_045/d_4000.bin" ; $4000, 16309 bytes
	ds 75, $ff ; $7fb5, fill
