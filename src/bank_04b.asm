INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $4b", ROMX[$4000], BANK[$4b]

	INCBIN "data/bank_04b/d_4000.bin" ; $4000, 16384 bytes
