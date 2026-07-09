INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $61", ROMX[$4000], BANK[$61]

	INCBIN "data/bank_061/d_4000.bin" ; $4000, 16384 bytes
