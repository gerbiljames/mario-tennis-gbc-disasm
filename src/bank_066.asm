INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $66", ROMX[$4000], BANK[$66]

	INCBIN "data/bank_066/d_4000.bin" ; $4000, 16384 bytes
