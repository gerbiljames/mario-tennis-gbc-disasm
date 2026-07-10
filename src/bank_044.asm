INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $44", ROMX[$4000], BANK[$44]

	INCBIN "data/bank_044/d_4000.bin" ; $4000, 16384 bytes
