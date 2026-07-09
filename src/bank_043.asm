INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $43", ROMX[$4000], BANK[$43]

	INCBIN "data/bank_043/d_4000.bin" ; $4000, 16384 bytes
