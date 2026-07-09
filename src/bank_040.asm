INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $40", ROMX[$4000], BANK[$40]

	INCBIN "data/bank_040/d_4000.bin" ; $4000, 16384 bytes
