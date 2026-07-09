INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $4a", ROMX[$4000], BANK[$4a]

	INCBIN "data/bank_04a/d_4000.bin" ; $4000, 16384 bytes
