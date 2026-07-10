INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $43", ROMX[$4000], BANK[$43]

	INCBIN "data/bank_043/d_4000.bin" ; $4000, 16307 bytes
	ds 77, $ff ; $7fb3, fill
