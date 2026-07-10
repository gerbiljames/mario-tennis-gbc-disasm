INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $2d", ROMX[$4000], BANK[$2d]

	INCBIN "data/bank_02d/d_4000.bin" ; $4000, 16384 bytes
