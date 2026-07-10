INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $77", ROMX[$4000], BANK[$77]

	INCBIN "data/bank_077/d_4000.bin" ; $4000, 16384 bytes
