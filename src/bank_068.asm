INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $68", ROMX[$4000], BANK[$68]

	INCBIN "data/bank_068/d_4000.bin" ; $4000, 16384 bytes
