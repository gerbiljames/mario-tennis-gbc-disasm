INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $5f", ROMX[$4000], BANK[$5f]

DataPtr_5f_00:
	dw Data_5f_4c13 ; $4000
DataPtr_5f_02:
	dw Data_5f_4020 ; $4002
DataPtr_5f_04:
	dw Lz_5f_4855 ; $4004
DataPtr_5f_06:
	dw Lz_5f_4ac6 ; $4006
DataPtr_5f_08:
	dw Data_5f_4c13 ; $4008
	INCBIN "data/bank_05f/d_400a.bin" ; $400a, 4 bytes
DataPtr_5f_0e:
	dw Lz_5f_4060 ; $400e
DataPtr_5f_10:
	dw Data_5f_5904 ; $4010
	INCBIN "data/bank_05f/d_4012.bin" ; $4012, 2 bytes
DataPtr_5f_14:
	dw CourtyardSceneTilemap ; $4014
DataPtr_5f_16:
	dw Lz_5f_57de ; $4016
DataPtr_5f_18:
	dw Data_5f_5904 ; $4018
DataPtr_5f_1a:
	dw Data_5f_592c ; $401a
DataPtr_5f_1c:
	dw Data_5f_5954 ; $401c
DataPtr_5f_1e:
	dw CourtyardSceneTiles ; $401e
Data_5f_4020:
	INCBIN "data/bank_05f/d_4020.bin" ; $4020, 64 bytes
Lz_5f_4060:
	INCBIN "data/bank_05f/lz_4060.bin" ; $4060, 2037 bytes
Lz_5f_4855:
	INCBIN "data/bank_05f/lz_4855.bin" ; $4855, 625 bytes
Lz_5f_4ac6:
	INCBIN "data/bank_05f/lz_4ac6.bin" ; $4ac6, 333 bytes
Data_5f_4c13:
	INCBIN "data/bank_05f/d_4c13.bin" ; $4c13, 144 bytes
CourtyardSceneTiles:
	INCBIN "data/bank_05f/lz_4ca3.bin" ; $4ca3, 2384 bytes
CourtyardSceneTilemap:
	INCBIN "data/bank_05f/lz_55f3.bin" ; $55f3, 491 bytes
Lz_5f_57de:
	INCBIN "data/bank_05f/lz_57de.bin" ; $57de, 294 bytes
Data_5f_5904:
	INCBIN "data/bank_05f/d_5904.bin" ; $5904, 40 bytes
Data_5f_592c:
	INCBIN "data/bank_05f/d_592c.bin" ; $592c, 40 bytes
Data_5f_5954:
	INCBIN "data/bank_05f/d_5954.bin" ; $5954, 9900 bytes
