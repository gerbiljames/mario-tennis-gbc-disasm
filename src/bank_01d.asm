INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $1d", ROMX[$4000], BANK[$1d]

	INCBIN "data/bank_01d/d_4000.bin" ; $4000, 13020 bytes
	ret ; $72dc
	INCBIN "data/bank_01d/d_72dd.bin" ; $72dd, 3363 bytes
