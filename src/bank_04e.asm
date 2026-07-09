INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $4e", ROMX[$4000], BANK[$4e]

	INCBIN "data/bank_04e/d_4000.bin" ; $4000, 16384 bytes
