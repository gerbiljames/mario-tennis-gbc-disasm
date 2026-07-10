INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $58", ROMX[$4000], BANK[$58]

	INCBIN "data/bank_058/d_4000.bin" ; $4000, 16317 bytes
	ds 67, $ff ; $7fbd, fill
