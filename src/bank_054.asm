INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $54", ROMX[$4000], BANK[$54]

	INCBIN "data/bank_054/d_4000.bin" ; $4000, 16384 bytes
