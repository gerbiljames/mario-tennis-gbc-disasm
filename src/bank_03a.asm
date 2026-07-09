INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $3a", ROMX[$4000], BANK[$3a]

	INCBIN "data/bank_03a/d_4000.bin" ; $4000, 16384 bytes
