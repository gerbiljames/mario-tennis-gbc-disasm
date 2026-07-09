INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $69", ROMX[$4000], BANK[$69]

	INCBIN "data/bank_069/d_4000.bin" ; $4000, 16384 bytes
