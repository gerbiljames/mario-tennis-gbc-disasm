INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $0c", ROMX[$4000], BANK[$0c]

	INCBIN "data/bank_00c/d_4000.bin" ; $4000, 16004 bytes
	ds 380, $ff ; $7e84, fill
