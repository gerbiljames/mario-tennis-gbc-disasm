INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $75", ROMX[$4000], BANK[$75]

	INCBIN "data/bank_075/d_4000.bin" ; $4000, 16384 bytes
