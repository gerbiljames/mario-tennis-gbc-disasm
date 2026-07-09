INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $63", ROMX[$4000], BANK[$63]

	INCBIN "data/bank_063/d_4000.bin" ; $4000, 16384 bytes
