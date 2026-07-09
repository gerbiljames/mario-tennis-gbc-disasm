INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $37", ROMX[$4000], BANK[$37]

	INCBIN "data/bank_037/d_4000.bin" ; $4000, 16384 bytes
