SECTION "ROM Bank $5f", ROMX[$4000], BANK[$5f]

DataPtr_Data_5f_4c13:
	dw Data_5f_4c13 ; $4000
DataPtr_5f_02:
	dw Data_5f_4020 ; $4002
DataPtr_ClubhouseSceneTilemap:
	dw ClubhouseSceneTilemap ; $4004
DataPtr_5f_06:
	dw Lz_5f_4ac6 ; $4006
DataPtr_Data_5f_4c13Alias1:
	dw Data_5f_4c13 ; $4008
DataPtr_5f_0a:
	dw Data_5f_4c3b ; $400a
DataPtr_Data_5f_4c63:
	dw Data_5f_4c63 ; $400c
DataPtr_ClubhouseSceneTiles:
	dw ClubhouseSceneTiles ; $400e
DataPtr_Data_5f_5904:
	dw Data_5f_5904 ; $4010
DataPtr_Data_5f_4c63Alias1:
	dw Data_5f_4c63 ; $4012
DataPtr_CourtyardSceneTilemap:
	dw CourtyardSceneTilemap ; $4014
DataPtr_5f_16:
	dw Lz_5f_57de ; $4016
DataPtr_Data_5f_5904Alias1:
	dw Data_5f_5904 ; $4018
DataPtr_5f_1a:
	dw Data_5f_592c ; $401a
DataPtr_5f_1c:
	dw Data_5f_5954 ; $401c
DataPtr_CourtyardSceneTiles:
	dw CourtyardSceneTiles ; $401e
Data_5f_4020:
	INCBIN "data/bank_05f/d_4020.bin" ; $4020, 64 bytes
ClubhouseSceneTiles:
	INCBIN "data/bank_05f/lz_4060.bin" ; $4060, 2037 bytes
ClubhouseSceneTilemap:
	INCBIN "data/bank_05f/lz_4855.bin" ; $4855, 625 bytes
Lz_5f_4ac6:
	INCBIN "data/bank_05f/lz_4ac6.bin" ; $4ac6, 333 bytes
Data_5f_4c13:
	INCBIN "data/bank_05f/d_4c13.bin" ; $4c13, 40 bytes
Data_5f_4c3b:
	INCBIN "data/bank_05f/d_4c3b.bin" ; $4c3b, 40 bytes
Data_5f_4c63:
	INCBIN "data/bank_05f/d_4c63.bin" ; $4c63, 64 bytes
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
	ds 9900, $ff ; $5954, fill
