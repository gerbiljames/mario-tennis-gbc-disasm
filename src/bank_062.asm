INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $62", ROMX[$4000], BANK[$62]

	INCBIN "data/bank_062/d_4000.bin" ; $4000, 16384 bytes
