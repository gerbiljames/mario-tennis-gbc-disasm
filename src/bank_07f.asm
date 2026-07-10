INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $7f", ROMX[$4000], BANK[$7f]

	INCBIN "data/bank_07f/d_4000.bin" ; $4000, 1282 bytes
	ds 15102, $ff ; $4502, fill
