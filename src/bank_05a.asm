INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $5a", ROMX[$4000], BANK[$5a]

	INCBIN "data/bank_05a/d_4000.bin" ; $4000, 16384 bytes
