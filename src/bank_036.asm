INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $36", ROMX[$4000], BANK[$36]

	INCBIN "data/bank_036/d_4000.bin" ; $4000, 16384 bytes
