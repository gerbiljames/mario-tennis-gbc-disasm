INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $73", ROMX[$4000], BANK[$73]

	INCBIN "data/bank_073/d_4000.bin" ; $4000, 16384 bytes
