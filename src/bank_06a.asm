INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $6a", ROMX[$4000], BANK[$6a]

	INCBIN "data/bank_06a/d_4000.bin" ; $4000, 8417 bytes
	ds 7967, $ff ; $60e1, fill
