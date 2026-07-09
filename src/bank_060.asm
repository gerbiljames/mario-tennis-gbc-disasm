INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $60", ROMX[$4000], BANK[$60]

	INCBIN "data/bank_060/d_4000.bin" ; $4000, 16384 bytes
