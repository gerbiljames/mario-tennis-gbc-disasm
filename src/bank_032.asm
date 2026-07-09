INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $32", ROMX[$4000], BANK[$32]

	INCBIN "data/bank_032/d_4000.bin" ; $4000, 16384 bytes
