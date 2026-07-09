INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $6d", ROMX[$4000], BANK[$6d]

	INCBIN "data/bank_06d/d_4000.bin" ; $4000, 16384 bytes
