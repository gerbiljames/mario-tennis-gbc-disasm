INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $48", ROMX[$4000], BANK[$48]

	INCBIN "data/bank_048/d_4000.bin" ; $4000, 16384 bytes
