INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $51", ROMX[$4000], BANK[$51]

	INCBIN "data/bank_051/d_4000.bin" ; $4000, 16384 bytes
