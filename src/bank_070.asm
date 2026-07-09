INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $70", ROMX[$4000], BANK[$70]

	INCBIN "data/bank_070/d_4000.bin" ; $4000, 16384 bytes
