INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $7e", ROMX[$4000], BANK[$7e]

	INCBIN "data/bank_07e/d_4000.bin" ; $4000, 16384 bytes
