INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $74", ROMX[$4000], BANK[$74]

	INCBIN "data/bank_074/d_4000.bin" ; $4000, 16384 bytes
