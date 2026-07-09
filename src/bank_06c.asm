INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $6c", ROMX[$4000], BANK[$6c]

	INCBIN "data/bank_06c/d_4000.bin" ; $4000, 16384 bytes
