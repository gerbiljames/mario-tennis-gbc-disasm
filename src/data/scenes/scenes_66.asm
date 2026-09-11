DataPtr_JuniorClassCourtSceneConfig:
	dw JuniorClassCourtSceneConfig ; $4000
DataPtr_JuniorClassCourtPalettes:
	dw JuniorClassCourtPalettes ; $4002
DataPtr_JuniorClassCourtTilemap:
	dw JuniorClassCourtTilemap ; $4004
DataPtr_JuniorClassCourtAttrmap:
	dw JuniorClassCourtAttrmap ; $4006
DataPtr_JuniorClassCourtCollisionMap:
	dw JuniorClassCourtCollisionMap ; $4008
DataPtr_JuniorClassCourtBehaviorMap:
	dw JuniorClassCourtBehaviorMap ; $400a
DataPtr_RestaurantSceneConfig:
	dw RestaurantSceneConfig ; $400c
DataPtr_JuniorClassCourtTiles:
	dw JuniorClassCourtTiles ; $400e
DataPtr_RestaurantSceneConfigAlias1:
	dw RestaurantSceneConfig ; $4010
DataPtr_RestaurantPalettes:
	dw RestaurantPalettes ; $4012
DataPtr_RestaurantTilemap:
	dw RestaurantTilemap ; $4014
DataPtr_RestaurantAttrmap:
	dw RestaurantAttrmap ; $4016
DataPtr_RestaurantCollisionMap:
	dw RestaurantCollisionMap ; $4018
DataPtr_RestaurantBehaviorMap:
	dw RestaurantBehaviorMap ; $401a
DataPtr_AcademyEntranceSceneConfig:
	dw AcademyEntranceSceneConfig ; $401c
DataPtr_RestaurantTiles:
	dw RestaurantTiles ; $401e
DataPtr_AcademyEntranceSceneConfigAlias1:
	dw AcademyEntranceSceneConfig ; $4020
DataPtr_AcademyEntrancePalettes:
	dw AcademyEntrancePalettes ; $4022
DataPtr_AcademyEntranceTilemap:
	dw AcademyEntranceTilemap ; $4024
DataPtr_AcademyEntranceAttrmap:
	dw AcademyEntranceAttrmap ; $4026
DataPtr_AcademyEntranceCollisionMap:
	dw AcademyEntranceCollisionMap ; $4028
DataPtr_AcademyEntranceBehaviorMap:
	dw AcademyEntranceBehaviorMap ; $402a
DataPtr_DormEntranceSceneConfig:
	dw DormEntranceSceneConfig ; $402c
DataPtr_AcademyEntranceTiles:
	dw AcademyEntranceTiles ; $402e
DataPtr_DormEntranceSceneConfigAlias1:
	dw DormEntranceSceneConfig ; $4030
DataPtr_DormEntrancePalettes:
	dw DormEntrancePalettes ; $4032
DataPtr_DormEntranceTilemap:
	dw DormEntranceTilemap ; $4034
DataPtr_DormEntranceAttrmap:
	dw DormEntranceAttrmap ; $4036
DataPtr_DormEntranceCollisionMap:
	dw DormEntranceCollisionMap ; $4038
DataPtr_DormEntranceBehaviorMap:
	dw DormEntranceBehaviorMap ; $403a
DataPtr_DormEntranceSceneUnusedSlot:
	dw DormEntranceSceneUnusedSlot ; $403c
DataPtr_DormEntranceTiles:
	dw DormEntranceTiles ; $403e
JuniorClassCourtSceneConfig:
	INCBIN "data/bank_066/JuniorClassCourtSceneConfig.bin" ; $4040, 42 bytes
JuniorClassCourtPalettes:
	INCLUDE "data/bank_066/JuniorClassCourtPalettes.asm" ; $406a, 64 bytes (palettes)
JuniorClassCourtTiles:
	INCBIN "data/bank_066/lz_JuniorClassCourtTiles.bin" ; $40aa, 1292 bytes
JuniorClassCourtTilemap:
	INCBIN "data/bank_066/lz_JuniorClassCourtTilemap.bin" ; $45b6, 1012 bytes
JuniorClassCourtAttrmap:
	INCBIN "data/bank_066/lz_JuniorClassCourtAttrmap.bin" ; $49aa, 760 bytes
JuniorClassCourtCollisionMap:
	INCBIN "data/bank_066/lz_JuniorClassCourtCollisionMap.bin" ; $4ca2, 101 bytes
JuniorClassCourtBehaviorMap:
	INCBIN "data/bank_066/lz_JuniorClassCourtBehaviorMap.bin" ; $4d07, 72 bytes
RestaurantSceneConfig:
	INCBIN "data/bank_066/RestaurantSceneConfig.bin" ; $4d4f, 42 bytes
RestaurantPalettes:
	INCLUDE "data/bank_066/RestaurantPalettes.asm" ; $4d79, 64 bytes (palettes)
RestaurantTiles:
	INCBIN "data/bank_066/lz_RestaurantTiles.bin" ; $4db9, 2034 bytes
RestaurantTilemap:
	INCBIN "data/bank_066/lz_RestaurantTilemap.bin" ; $55ab, 1086 bytes
RestaurantAttrmap:
	INCBIN "data/bank_066/lz_RestaurantAttrmap.bin" ; $59e9, 675 bytes
RestaurantCollisionMap:
	INCBIN "data/bank_066/lz_RestaurantCollisionMap.bin" ; $5c8c, 118 bytes
RestaurantBehaviorMap:
	INCBIN "data/bank_066/lz_RestaurantBehaviorMap.bin" ; $5d02, 128 bytes
AcademyEntranceSceneConfig:
	INCBIN "data/bank_066/AcademyEntranceSceneConfig.bin" ; $5d82, 9 bytes
AcademyEntrancePalettes:
	INCLUDE "data/bank_066/AcademyEntrancePalettes.asm" ; $5d8b, 64 bytes (palettes)
AcademyEntranceTiles:
	INCBIN "data/bank_066/lz_AcademyEntranceTiles.bin" ; $5dcb, 2301 bytes
AcademyEntranceTilemap:
	INCBIN "data/bank_066/lz_AcademyEntranceTilemap.bin" ; $66c8, 1096 bytes
AcademyEntranceAttrmap:
	INCBIN "data/bank_066/lz_AcademyEntranceAttrmap.bin" ; $6b10, 572 bytes
AcademyEntranceCollisionMap:
	INCBIN "data/bank_066/lz_AcademyEntranceCollisionMap.bin" ; $6d4c, 97 bytes
AcademyEntranceBehaviorMap:
	INCBIN "data/bank_066/lz_AcademyEntranceBehaviorMap.bin" ; $6dad, 75 bytes
DormEntranceSceneConfig:
	INCBIN "data/bank_066/DormEntranceSceneConfig.bin" ; $6df8, 42 bytes
DormEntrancePalettes:
	INCLUDE "data/bank_066/DormEntrancePalettes.asm" ; $6e22, 64 bytes (palettes)
DormEntranceTiles:
	INCBIN "data/bank_066/lz_DormEntranceTiles.bin" ; $6e62, 1916 bytes
DormEntranceTilemap:
	INCBIN "data/bank_066/lz_DormEntranceTilemap.bin" ; $75de, 971 bytes
DormEntranceAttrmap:
	INCBIN "data/bank_066/lz_DormEntranceAttrmap.bin" ; $79a9, 474 bytes
DormEntranceCollisionMap:
	INCBIN "data/bank_066/lz_DormEntranceCollisionMap.bin" ; $7b83, 95 bytes
DormEntranceBehaviorMap:
	INCBIN "data/bank_066/lz_DormEntranceBehaviorMap.bin" ; $7be2, 75 bytes
DormEntranceSceneUnusedSlot:
	; $7c2d, 979 bytes fill to bank end (linker-padded)
