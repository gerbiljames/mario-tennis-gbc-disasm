INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $3a", ROMX[$4000], BANK[$3a]

DataPtr_3a_00:
	dw TennisDictionaryTiles ; $4000
DataPtr_3a_02:
	dw TennisDictionaryListTiles ; $4002
DataPtr_3a_04:
	dw Lz_3a_53fb ; $4004
	INCBIN "data/bank_03a/d_4006.bin" ; $4006, 16 bytes
DataPtr_3a_16:
	dw Lz_3a_5468 ; $4016
DataPtr_3a_18:
	dw Lz_3a_54d8 ; $4018
DataPtr_3a_1a:
	dw Lz_3a_5545 ; $401a
	INCBIN "data/bank_03a/d_401c.bin" ; $401c, 8 bytes
DataPtr_3a_24:
	dw Lz_3a_55af ; $4024
DataPtr_3a_26:
	dw Lz_3a_5a21 ; $4026
DataPtr_3a_28:
	dw Lz_3a_5afa ; $4028
DataPtr_3a_2a:
	dw Data_3a_5b67 ; $402a
	INCBIN "data/bank_03a/d_402c.bin" ; $402c, 46 bytes
TennisDictionaryTiles:
	INCBIN "data/bank_03a/lz_405a.bin" ; $405a, 2621 bytes
TennisDictionaryListTiles:
	INCBIN "data/bank_03a/lz_4a97.bin" ; $4a97, 2404 bytes
Lz_3a_53fb:
	INCBIN "data/bank_03a/lz_53fb.bin" ; $53fb, 109 bytes
Lz_3a_5468:
	INCBIN "data/bank_03a/lz_5468.bin" ; $5468, 112 bytes
Lz_3a_54d8:
	INCBIN "data/bank_03a/lz_54d8.bin" ; $54d8, 109 bytes
Lz_3a_5545:
	INCBIN "data/bank_03a/lz_5545.bin" ; $5545, 106 bytes
Lz_3a_55af:
	INCBIN "data/bank_03a/lz_55af.bin" ; $55af, 1138 bytes
Lz_3a_5a21:
	INCBIN "data/bank_03a/lz_5a21.bin" ; $5a21, 217 bytes
Lz_3a_5afa:
	INCBIN "data/bank_03a/lz_5afa.bin" ; $5afa, 109 bytes
Data_3a_5b67:
	INCBIN "data/bank_03a/d_5b67.bin" ; $5b67, 64 bytes
	INCBIN "data/bank_03a/d_5ba7.bin" ; $5ba7, 9305 bytes
