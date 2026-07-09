INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $7f", ROMX[$4000], BANK[$7f]

	INCBIN "data/bank_07f/d_4000.bin" ; $4000, 16384 bytes
