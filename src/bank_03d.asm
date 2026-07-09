INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $3d", ROMX[$4000], BANK[$3d]

	INCBIN "data/bank_03d/d_4000.bin" ; $4000, 16384 bytes
