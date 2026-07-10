INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $47", ROMX[$4000], BANK[$47]

	INCBIN "data/bank_047/d_4000.bin" ; $4000, 16309 bytes
	ds 75, $ff ; $7fb5, fill
