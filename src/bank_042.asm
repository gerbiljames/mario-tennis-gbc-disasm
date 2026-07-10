INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $42", ROMX[$4000], BANK[$42]

	INCBIN "data/bank_042/d_4000.bin" ; $4000, 16384 bytes
