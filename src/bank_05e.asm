INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $5e", ROMX[$4000], BANK[$5e]

	INCBIN "data/bank_05e/d_4000.bin" ; $4000, 16384 bytes
