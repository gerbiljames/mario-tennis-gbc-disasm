INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $72", ROMX[$4000], BANK[$72]

	INCBIN "data/bank_072/d_4000.bin" ; $4000, 16384 bytes
