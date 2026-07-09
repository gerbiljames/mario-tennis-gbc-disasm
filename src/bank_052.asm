INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $52", ROMX[$4000], BANK[$52]

	INCBIN "data/bank_052/d_4000.bin" ; $4000, 16384 bytes
