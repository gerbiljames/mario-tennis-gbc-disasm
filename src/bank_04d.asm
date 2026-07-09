INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $4d", ROMX[$4000], BANK[$4d]

	INCBIN "data/bank_04d/d_4000.bin" ; $4000, 16384 bytes
