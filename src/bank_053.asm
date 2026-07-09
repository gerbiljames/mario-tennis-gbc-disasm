INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $53", ROMX[$4000], BANK[$53]

	INCBIN "data/bank_053/d_4000.bin" ; $4000, 16384 bytes
