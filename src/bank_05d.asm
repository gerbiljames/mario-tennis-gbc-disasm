INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $5d", ROMX[$4000], BANK[$5d]

	INCBIN "data/bank_05d/d_4000.bin" ; $4000, 16384 bytes
