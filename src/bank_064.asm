SECTION "ROM Bank $64", ROMX[$4000], BANK[$64]

DataPtr_DormBedroomSceneConfig:
	dw DormBedroomSceneConfig ; $4000
DataPtr_DormBedroomPalettes:
	dw DormBedroomPalettes ; $4002
DataPtr_DormBedroomTilemap:
	dw DormBedroomTilemap ; $4004
DataPtr_DormBedroomAttrmap:
	dw DormBedroomAttrmap ; $4006
DataPtr_DormBedroomCollisionMap:
	dw DormBedroomCollisionMap ; $4008
DataPtr_DormBedroomBehaviorMap:
	dw DormBedroomBehaviorMap ; $400a
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
DataPtr_CountrysideCollisionMap:
	dw CountrysideCollisionMap ; $4018
DataPtr_CountrysideBehaviorMap:
	dw CountrysideBehaviorMap ; $401a
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
DataPtr_AcademyGroundsCollisionMap:
	dw AcademyGroundsCollisionMap ; $4028
DataPtr_AcademyGroundsBehaviorMap:
	dw AcademyGroundsBehaviorMap ; $402a
DataPtr_AcademyGroundsSceneUnusedSlot:
	dw AcademyGroundsSceneUnusedSlot ; $402c
DataPtr_AcademyGroundsTiles:
	dw AcademyGroundsTiles ; $402e
DormBedroomSceneConfig:
	INCBIN "data/bank_064/DormBedroomSceneConfig.bin" ; $4030, 42 bytes
DormBedroomPalettes:
	INCLUDE "data/bank_064/DormBedroomPalettes.asm" ; $405a, 64 bytes (palettes)
DormBedroomTiles:
	INCBIN "data/bank_064/lz_DormBedroomTiles.bin" ; $409a, 2307 bytes
DormBedroomTilemap:
	INCBIN "data/bank_064/lz_DormBedroomTilemap.bin" ; $499d, 706 bytes
DormBedroomAttrmap:
	INCBIN "data/bank_064/lz_DormBedroomAttrmap.bin" ; $4c5f, 511 bytes
DormBedroomCollisionMap:
	INCBIN "data/bank_064/lz_DormBedroomCollisionMap.bin" ; $4e5e, 118 bytes
DormBedroomBehaviorMap:
	INCBIN "data/bank_064/lz_DormBedroomBehaviorMap.bin" ; $4ed4, 72 bytes
CountrysideSceneConfig:
	INCBIN "data/bank_064/CountrysideSceneConfig.bin" ; $4f1c, 42 bytes
CountrysidePalettes:
	INCLUDE "data/bank_064/CountrysidePalettes.asm" ; $4f46, 64 bytes (palettes)
CountrysideTiles:
	INCBIN "data/bank_064/lz_CountrysideTiles.bin" ; $4f86, 3238 bytes
CountrysideTilemap:
	INCBIN "data/bank_064/lz_CountrysideTilemap.bin" ; $5c2c, 802 bytes
CountrysideAttrmap:
	INCBIN "data/bank_064/lz_CountrysideAttrmap.bin" ; $5f4e, 411 bytes
CountrysideCollisionMap:
	INCBIN "data/bank_064/lz_CountrysideCollisionMap.bin" ; $60e9, 80 bytes
CountrysideBehaviorMap:
	INCBIN "data/bank_064/lz_CountrysideBehaviorMap.bin" ; $6139, 90 bytes
AcademyGroundsSceneConfig:
	INCBIN "data/bank_064/AcademyGroundsSceneConfig.bin" ; $6193, 27 bytes
AcademyGroundsPalettes:
	INCLUDE "data/bank_064/AcademyGroundsPalettes.asm" ; $61ae, 64 bytes (palettes)
AcademyGroundsTiles:
	INCBIN "data/bank_064/lz_AcademyGroundsTiles.bin" ; $61ee, 3100 bytes
AcademyGroundsTilemap:
	INCBIN "data/bank_064/lz_AcademyGroundsTilemap.bin" ; $6e0a, 1429 bytes
AcademyGroundsAttrmap:
	INCBIN "data/bank_064/lz_AcademyGroundsAttrmap.bin" ; $739f, 679 bytes
AcademyGroundsCollisionMap:
	INCBIN "data/bank_064/lz_AcademyGroundsCollisionMap.bin" ; $7646, 147 bytes
AcademyGroundsBehaviorMap:
	INCBIN "data/bank_064/lz_AcademyGroundsBehaviorMap.bin" ; $76d9, 79 bytes
	; $7728, 8 bytes (fill)
	ds 8, $00
AcademyGroundsSceneUnusedSlot:
	INCBIN "data/bank_064/AcademyGroundsSceneUnusedSlot.bin" ; $7730, 2256 bytes
