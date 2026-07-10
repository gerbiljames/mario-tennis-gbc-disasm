INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $71", ROMX[$4000], BANK[$71]

	INCBIN "data/bank_071/d_4000.bin" ; $4000, 16384 bytes
