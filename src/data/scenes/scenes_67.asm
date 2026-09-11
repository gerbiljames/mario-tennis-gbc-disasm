DataPtr_FountainCourtSceneConfig:
	dw FountainCourtSceneConfig ; $4000
DataPtr_FountainCourtPalettes:
	dw FountainCourtPalettes ; $4002
DataPtr_FountainCourtTilemap:
	dw FountainCourtTilemap ; $4004
DataPtr_FountainCourtAttrmap:
	dw FountainCourtAttrmap ; $4006
DataPtr_FountainCourtCollisionMap:
	dw FountainCourtCollisionMap ; $4008
DataPtr_FountainCourtBehaviorMap:
	dw FountainCourtBehaviorMap ; $400a
DataPtr_FountainCourtSceneUnusedSlot:
	dw FountainCourtSceneUnusedSlot ; $400c
DataPtr_FountainCourtTiles:
	dw FountainCourtTiles ; $400e
DataPtr_CafeCourtSceneConfig:
	dw CafeCourtSceneConfig ; $4010
DataPtr_CafeCourtPalettes:
	dw CafeCourtPalettes ; $4012
DataPtr_CafeCourtTilemap:
	dw CafeCourtTilemap ; $4014
DataPtr_CafeCourtAttrmap:
	dw CafeCourtAttrmap ; $4016
DataPtr_CafeCourtCollisionMap:
	dw CafeCourtCollisionMap ; $4018
DataPtr_CafeCourtBehaviorMap:
	dw CafeCourtBehaviorMap ; $401a
DataPtr_CourtComplexSceneConfig:
	dw CourtComplexSceneConfig ; $401c
DataPtr_CafeCourtTiles:
	dw CafeCourtTiles ; $401e
DataPtr_CourtComplexSceneConfigAlias1:
	dw CourtComplexSceneConfig ; $4020
DataPtr_CourtComplexPalettes:
	dw CourtComplexPalettes ; $4022
DataPtr_CourtComplexTilemap:
	dw CourtComplexTilemap ; $4024
DataPtr_CourtComplexAttrmap:
	dw CourtComplexAttrmap ; $4026
DataPtr_CourtComplexCollisionMap:
	dw CourtComplexCollisionMap ; $4028
DataPtr_CourtComplexBehaviorMap:
	dw CourtComplexBehaviorMap ; $402a
DataPtr_CourtComplexSceneUnusedSlot:
	dw CourtComplexSceneUnusedSlot ; $402c
DataPtr_CourtComplexTiles:
	dw CourtComplexTiles ; $402e
FountainCourtSceneConfig:
	INCBIN "data/bank_067/FountainCourtSceneConfig.bin" ; $4030, 27 bytes
FountainCourtPalettes:
	INCLUDE "data/bank_067/FountainCourtPalettes.asm" ; $404b, 64 bytes (palettes)
FountainCourtTiles:
	INCBIN "data/bank_067/lz_FountainCourtTiles.bin" ; $408b, 3052 bytes
FountainCourtTilemap:
	INCBIN "data/bank_067/lz_FountainCourtTilemap.bin" ; $4c77, 1101 bytes
FountainCourtAttrmap:
	INCBIN "data/bank_067/lz_FountainCourtAttrmap.bin" ; $50c4, 689 bytes
FountainCourtCollisionMap:
	INCBIN "data/bank_067/lz_FountainCourtCollisionMap.bin" ; $5375, 106 bytes
FountainCourtBehaviorMap:
	INCBIN "data/bank_067/lz_FountainCourtBehaviorMap.bin" ; $53df, 83 bytes
	; $5432, 14 bytes (fill)
	ds 14, $00
FountainCourtSceneUnusedSlot:
	INCBIN "data/bank_067/FountainCourtSceneUnusedSlot.bin" ; $5440, 1536 bytes
CafeCourtSceneConfig:
	INCBIN "data/bank_067/CafeCourtSceneConfig.bin" ; $5a40, 42 bytes
CafeCourtPalettes:
	INCLUDE "data/bank_067/CafeCourtPalettes.asm" ; $5a6a, 64 bytes (palettes)
CafeCourtTiles:
	INCBIN "data/bank_067/lz_CafeCourtTiles.bin" ; $5aaa, 2357 bytes
CafeCourtTilemap:
	INCBIN "data/bank_067/lz_CafeCourtTilemap.bin" ; $63df, 922 bytes
CafeCourtAttrmap:
	INCBIN "data/bank_067/lz_CafeCourtAttrmap.bin" ; $6779, 569 bytes
CafeCourtCollisionMap:
	INCBIN "data/bank_067/lz_CafeCourtCollisionMap.bin" ; $69b2, 103 bytes
CafeCourtBehaviorMap:
	INCBIN "data/bank_067/lz_CafeCourtBehaviorMap.bin" ; $6a19, 75 bytes
CourtComplexSceneConfig:
	INCBIN "data/bank_067/CourtComplexSceneConfig.bin" ; $6a64, 42 bytes
CourtComplexPalettes:
	INCLUDE "data/bank_067/CourtComplexPalettes.asm" ; $6a8e, 64 bytes (palettes)
CourtComplexTiles:
	INCBIN "data/bank_067/lz_CourtComplexTiles.bin" ; $6ace, 2316 bytes
CourtComplexTilemap:
	INCBIN "data/bank_067/lz_CourtComplexTilemap.bin" ; $73da, 1330 bytes
CourtComplexAttrmap:
	INCBIN "data/bank_067/lz_CourtComplexAttrmap.bin" ; $790c, 710 bytes
CourtComplexCollisionMap:
	INCBIN "data/bank_067/lz_CourtComplexCollisionMap.bin" ; $7bd2, 128 bytes
CourtComplexBehaviorMap:
	INCBIN "data/bank_067/lz_CourtComplexBehaviorMap.bin" ; $7c52, 76 bytes
CourtComplexSceneUnusedSlot:
	; $7c9e, 866 bytes fill to bank end (linker-padded)
