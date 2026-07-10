INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $67", ROMX[$4000], BANK[$67]

	INCBIN "data/bank_067/d_4000.bin" ; $4000, 16384 bytes
