INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $55", ROMX[$4000], BANK[$55]

	INCBIN "data/bank_055/d_4000.bin" ; $4000, 16384 bytes
