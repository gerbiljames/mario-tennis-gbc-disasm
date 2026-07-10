INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $1f", ROMX[$4000], BANK[$1f]

	INCBIN "data/bank_01f/d_4000.bin" ; $4000, 16384 bytes
