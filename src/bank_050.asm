INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $50", ROMX[$4000], BANK[$50]

	INCBIN "data/bank_050/d_4000.bin" ; $4000, 16384 bytes
