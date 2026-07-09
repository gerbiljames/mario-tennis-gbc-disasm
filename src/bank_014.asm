INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $14", ROMX[$4000], BANK[$14]

	INCBIN "data/bank_014/d_4000.bin" ; $4000, 16384 bytes
