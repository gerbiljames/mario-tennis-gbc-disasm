INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $5b", ROMX[$4000], BANK[$5b]

	INCBIN "data/bank_05b/d_4000.bin" ; $4000, 16384 bytes
