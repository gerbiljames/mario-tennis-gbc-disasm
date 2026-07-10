INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $46", ROMX[$4000], BANK[$46]

	INCBIN "data/bank_046/d_4000.bin" ; $4000, 16384 bytes
