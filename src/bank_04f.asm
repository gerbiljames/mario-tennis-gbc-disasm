INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $4f", ROMX[$4000], BANK[$4f]

	INCBIN "data/bank_04f/d_4000.bin" ; $4000, 16384 bytes
