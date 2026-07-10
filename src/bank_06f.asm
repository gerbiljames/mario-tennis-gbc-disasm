INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $6f", ROMX[$4000], BANK[$6f]

	INCBIN "data/bank_06f/d_4000.bin" ; $4000, 13457 bytes
	ds 2927, $ff ; $7491, fill
