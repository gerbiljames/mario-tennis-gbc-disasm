SECTION "ROM Bank $64", ROMX[$4000], BANK[$64]

DataPtr_DormBedroomSceneConfig:
	dw DormBedroomSceneConfig ; $4000
DataPtr_DormBedroomPalettes:
	dw DormBedroomPalettes ; $4002
DataPtr_DormBedroomTilemap:
	dw DormBedroomTilemap ; $4004
DataPtr_DormBedroomAttrmap:
	dw DormBedroomAttrmap ; $4006
DataPtr_DormBedroomAuxTilemap:
	dw DormBedroomAuxTilemap ; $4008
DataPtr_DormBedroomAuxAttrmap:
	dw DormBedroomAuxAttrmap ; $400a
DataPtr_CountrysideSceneConfig:
	dw CountrysideSceneConfig ; $400c
DataPtr_DormBedroomTiles:
	dw DormBedroomTiles ; $400e
DataPtr_CountrysideSceneConfigAlias1:
	dw CountrysideSceneConfig ; $4010
DataPtr_CountrysidePalettes:
	dw CountrysidePalettes ; $4012
DataPtr_CountrysideTilemap:
	dw CountrysideTilemap ; $4014
DataPtr_CountrysideAttrmap:
	dw CountrysideAttrmap ; $4016
DataPtr_CountrysideAuxTilemap:
	dw CountrysideAuxTilemap ; $4018
DataPtr_CountrysideAuxAttrmap:
	dw CountrysideAuxAttrmap ; $401a
DataPtr_AcademyGroundsSceneConfig:
	dw AcademyGroundsSceneConfig ; $401c
DataPtr_CountrysideTiles:
	dw CountrysideTiles ; $401e
DataPtr_AcademyGroundsSceneConfigAlias1:
	dw AcademyGroundsSceneConfig ; $4020
DataPtr_AcademyGroundsPalettes:
	dw AcademyGroundsPalettes ; $4022
DataPtr_AcademyGroundsTilemap:
	dw AcademyGroundsTilemap ; $4024
DataPtr_AcademyGroundsAttrmap:
	dw AcademyGroundsAttrmap ; $4026
DataPtr_AcademyGroundsAuxTilemap:
	dw AcademyGroundsAuxTilemap ; $4028
DataPtr_AcademyGroundsAuxAttrmap:
	dw AcademyGroundsAuxAttrmap ; $402a
DataPtr_AcademyGroundsSceneUnusedSlot:
	dw AcademyGroundsSceneUnusedSlot ; $402c
DataPtr_AcademyGroundsTiles:
	dw AcademyGroundsTiles ; $402e
DormBedroomSceneConfig:
	INCBIN "data/bank_064/d_4030.bin" ; $4030, 42 bytes
DormBedroomPalettes:
	INCLUDE "data/bank_064/palettes_405a.asm" ; $405a, 64 bytes (palettes)
DormBedroomTiles:
	INCBIN "data/bank_064/lz_409a.bin" ; $409a, 2307 bytes
DormBedroomTilemap:
	INCBIN "data/bank_064/lz_499d.bin" ; $499d, 706 bytes
DormBedroomAttrmap:
	INCBIN "data/bank_064/lz_4c5f.bin" ; $4c5f, 511 bytes
DormBedroomAuxTilemap:
	INCBIN "data/bank_064/lz_4e5e.bin" ; $4e5e, 118 bytes
DormBedroomAuxAttrmap:
	INCBIN "data/bank_064/lz_4ed4.bin" ; $4ed4, 72 bytes
CountrysideSceneConfig:
	INCBIN "data/bank_064/d_4f1c.bin" ; $4f1c, 42 bytes
CountrysidePalettes:
	INCLUDE "data/bank_064/palettes_4f46.asm" ; $4f46, 64 bytes (palettes)
CountrysideTiles:
	INCBIN "data/bank_064/lz_4f86.bin" ; $4f86, 3238 bytes
CountrysideTilemap:
	INCBIN "data/bank_064/lz_5c2c.bin" ; $5c2c, 802 bytes
CountrysideAttrmap:
	INCBIN "data/bank_064/lz_5f4e.bin" ; $5f4e, 411 bytes
CountrysideAuxTilemap:
	INCBIN "data/bank_064/lz_60e9.bin" ; $60e9, 80 bytes
CountrysideAuxAttrmap:
	INCBIN "data/bank_064/lz_6139.bin" ; $6139, 90 bytes
AcademyGroundsSceneConfig:
	INCBIN "data/bank_064/d_6193.bin" ; $6193, 27 bytes
AcademyGroundsPalettes:
	INCLUDE "data/bank_064/palettes_61ae.asm" ; $61ae, 64 bytes (palettes)
AcademyGroundsTiles:
	INCBIN "data/bank_064/lz_61ee.bin" ; $61ee, 3100 bytes
AcademyGroundsTilemap:
	INCBIN "data/bank_064/lz_6e0a.bin" ; $6e0a, 1429 bytes
AcademyGroundsAttrmap:
	INCBIN "data/bank_064/lz_739f.bin" ; $739f, 679 bytes
AcademyGroundsAuxTilemap:
	INCBIN "data/bank_064/lz_7646.bin" ; $7646, 147 bytes
AcademyGroundsAuxAttrmap:
	INCBIN "data/bank_064/lz_76d9.bin" ; $76d9, 79 bytes
	; $7728, 8 bytes (fill)
	ds 8, $00
AcademyGroundsSceneUnusedSlot:
	INCBIN "data/bank_064/d_7730.bin" ; $7730, 2256 bytes
