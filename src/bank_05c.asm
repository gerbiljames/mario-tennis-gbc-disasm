INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $5c", ROMX[$4000], BANK[$5c]

	INCBIN "data/bank_05c/d_4000.bin" ; $4000, 16384 bytes
