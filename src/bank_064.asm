INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $64", ROMX[$4000], BANK[$64]

	INCBIN "data/bank_064/d_4000.bin" ; $4000, 16384 bytes
