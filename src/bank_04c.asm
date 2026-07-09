INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $4c", ROMX[$4000], BANK[$4c]

	INCBIN "data/bank_04c/d_4000.bin" ; $4000, 16384 bytes
