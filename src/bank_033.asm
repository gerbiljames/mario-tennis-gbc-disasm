INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $33", ROMX[$4000], BANK[$33]

	INCBIN "data/bank_033/d_4000.bin" ; $4000, 16384 bytes
