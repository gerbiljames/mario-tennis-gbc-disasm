INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $23", ROMX[$4000], BANK[$23]

	INCBIN "data/bank_023/d_4000.bin" ; $4000, 16384 bytes
