INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $59", ROMX[$4000], BANK[$59]

	INCBIN "data/bank_059/d_4000.bin" ; $4000, 16384 bytes
