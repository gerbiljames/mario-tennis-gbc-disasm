INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $76", ROMX[$4000], BANK[$76]

	INCBIN "data/bank_076/d_4000.bin" ; $4000, 16384 bytes
