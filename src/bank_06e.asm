INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $6e", ROMX[$4000], BANK[$6e]

	INCBIN "data/bank_06e/d_4000.bin" ; $4000, 16384 bytes
