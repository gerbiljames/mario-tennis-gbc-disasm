INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $57", ROMX[$4000], BANK[$57]

	INCBIN "data/bank_057/d_4000.bin" ; $4000, 16384 bytes
