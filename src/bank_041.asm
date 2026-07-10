INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $41", ROMX[$4000], BANK[$41]

	INCBIN "data/bank_041/d_4000.bin" ; $4000, 16384 bytes
