INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $51", ROMX[$4000], BANK[$51]

	INCBIN "data/bank_051/d_4000.bin" ; $4000, 16309 bytes
	ds 75, $ff ; $7fb5, fill
