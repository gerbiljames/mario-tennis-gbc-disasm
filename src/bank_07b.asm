INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $7b", ROMX[$4000], BANK[$7b]

	INCBIN "data/bank_07b/d_4000.bin" ; $4000, 16384 bytes
