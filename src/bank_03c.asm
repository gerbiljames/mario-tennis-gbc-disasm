INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $3c", ROMX[$4000], BANK[$3c]

	INCBIN "data/bank_03c/d_4000.bin" ; $4000, 16384 bytes
