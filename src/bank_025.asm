INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $25", ROMX[$4000], BANK[$25]

	INCBIN "data/bank_025/d_4000.bin" ; $4000, 16384 bytes
