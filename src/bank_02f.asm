INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $2f", ROMX[$4000], BANK[$2f]

ViewScaleTableA:
	INCBIN "data/bank_02f/d_4000.bin" ; $4000, 8192 bytes
ViewScaleTableB:
	INCBIN "data/bank_02f/d_6000.bin" ; $6000, 8192 bytes
