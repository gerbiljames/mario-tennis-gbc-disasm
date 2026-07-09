INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $7d", ROMX[$4000], BANK[$7d]

	INCBIN "data/bank_07d/d_4000.bin" ; $4000, 16384 bytes
