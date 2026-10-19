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
	INCLUDE "data/scenes/JuniorClassCourtSceneConfig.asm" ; $4040, 42 bytes (scene_config)
JuniorClassCourtPalettes:
	INCLUDE "data/scenes/JuniorClassCourtPalettes.asm" ; $406a, 64 bytes (palettes)
JuniorClassCourtTiles:
	INCBIN "data/scenes/lz_JuniorClassCourtTiles.bin" ; $40aa, 1292 bytes
JuniorClassCourtTilemap:
	INCBIN "data/scenes/lz_JuniorClassCourtTilemap.bin" ; $45b6, 1012 bytes
JuniorClassCourtAttrmap:
	INCBIN "data/scenes/lz_JuniorClassCourtAttrmap.bin" ; $49aa, 760 bytes
JuniorClassCourtCollisionMap:
	INCBIN "data/scenes/lz_JuniorClassCourtCollisionMap.bin" ; $4ca2, 101 bytes
JuniorClassCourtBehaviorMap:
	INCBIN "data/scenes/lz_JuniorClassCourtBehaviorMap.bin" ; $4d07, 72 bytes
RestaurantSceneConfig:
	INCLUDE "data/scenes/RestaurantSceneConfig.asm" ; $4d4f, 42 bytes (scene_config)
RestaurantPalettes:
	INCLUDE "data/scenes/RestaurantPalettes.asm" ; $4d79, 64 bytes (palettes)
RestaurantTiles:
	INCBIN "data/scenes/lz_RestaurantTiles.bin" ; $4db9, 2034 bytes
RestaurantTilemap:
	INCBIN "data/scenes/lz_RestaurantTilemap.bin" ; $55ab, 1086 bytes
RestaurantAttrmap:
	INCBIN "data/scenes/lz_RestaurantAttrmap.bin" ; $59e9, 675 bytes
RestaurantCollisionMap:
	INCBIN "data/scenes/lz_RestaurantCollisionMap.bin" ; $5c8c, 118 bytes
RestaurantBehaviorMap:
	INCBIN "data/scenes/lz_RestaurantBehaviorMap.bin" ; $5d02, 128 bytes
AcademyEntranceSceneConfig:
	INCLUDE "data/scenes/AcademyEntranceSceneConfig.asm" ; $5d82, 9 bytes (scene_config)
AcademyEntrancePalettes:
	INCLUDE "data/scenes/AcademyEntrancePalettes.asm" ; $5d8b, 64 bytes (palettes)
AcademyEntranceTiles:
	INCBIN "data/scenes/lz_AcademyEntranceTiles.bin" ; $5dcb, 2301 bytes
AcademyEntranceTilemap:
	INCBIN "data/scenes/lz_AcademyEntranceTilemap.bin" ; $66c8, 1096 bytes
AcademyEntranceAttrmap:
	INCBIN "data/scenes/lz_AcademyEntranceAttrmap.bin" ; $6b10, 572 bytes
AcademyEntranceCollisionMap:
	INCBIN "data/scenes/lz_AcademyEntranceCollisionMap.bin" ; $6d4c, 97 bytes
AcademyEntranceBehaviorMap:
	INCBIN "data/scenes/lz_AcademyEntranceBehaviorMap.bin" ; $6dad, 75 bytes
DormEntranceSceneConfig:
	INCLUDE "data/scenes/DormEntranceSceneConfig.asm" ; $6df8, 42 bytes (scene_config)
DormEntrancePalettes:
	INCLUDE "data/scenes/DormEntrancePalettes.asm" ; $6e22, 64 bytes (palettes)
DormEntranceTiles:
	INCBIN "data/scenes/lz_DormEntranceTiles.bin" ; $6e62, 1916 bytes
DormEntranceTilemap:
	INCBIN "data/scenes/lz_DormEntranceTilemap.bin" ; $75de, 971 bytes
DormEntranceAttrmap:
	INCBIN "data/scenes/lz_DormEntranceAttrmap.bin" ; $79a9, 474 bytes
DormEntranceCollisionMap:
	INCBIN "data/scenes/lz_DormEntranceCollisionMap.bin" ; $7b83, 95 bytes
DormEntranceBehaviorMap:
	INCBIN "data/scenes/lz_DormEntranceBehaviorMap.bin" ; $7be2, 75 bytes
DormEntranceSceneUnusedSlot:
	; $7c2d, 979 bytes fill to bank end (linker-padded)
