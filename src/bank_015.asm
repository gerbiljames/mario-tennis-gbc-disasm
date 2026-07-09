INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $15", ROMX[$4000], BANK[$15]

	INCBIN "data/bank_015/d_4000.bin" ; $4000, 16384 bytes
