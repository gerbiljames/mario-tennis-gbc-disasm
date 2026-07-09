INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $1a", ROMX[$4000], BANK[$1a]

	INCBIN "data/bank_01a/d_4000.bin" ; $4000, 3127 bytes
	ret ; $4c37
	INCBIN "data/bank_01a/d_4c38.bin" ; $4c38, 13256 bytes
