INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $3a", ROMX[$4000], BANK[$3a]

DataPtr_3a_00:
	dw Lz_3a_405a ; $4000
DataPtr_3a_02:
	dw Lz_3a_4a97 ; $4002
	INCBIN "data/bank_03a/d_4004.bin" ; $4004, 86 bytes
Lz_3a_405a:
	INCBIN "data/bank_03a/lz_405a.bin" ; $405a, 2620 bytes
	INCBIN "data/bank_03a/d_4a96.bin" ; $4a96, 1 bytes
Lz_3a_4a97:
	INCBIN "data/bank_03a/lz_4a97.bin" ; $4a97, 2403 bytes
	INCBIN "data/bank_03a/d_53fa.bin" ; $53fa, 11270 bytes
