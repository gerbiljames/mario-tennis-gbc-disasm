INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $78", ROMX[$4000], BANK[$78]

	INCBIN "data/bank_078/d_4000.bin" ; $4000, 16384 bytes
