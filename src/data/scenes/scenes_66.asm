DataPtr_HardCourtGroundsSceneConfig:
	dw HardCourtGroundsSceneConfig ; $4000
DataPtr_HardCourtGroundsPalettes:
	dw HardCourtGroundsPalettes ; $4002
DataPtr_HardCourtGroundsTilemap:
	dw HardCourtGroundsTilemap ; $4004
DataPtr_HardCourtGroundsAttrmap:
	dw HardCourtGroundsAttrmap ; $4006
DataPtr_HardCourtGroundsCollisionMap:
	dw HardCourtGroundsCollisionMap ; $4008
DataPtr_HardCourtGroundsBehaviorMap:
	dw HardCourtGroundsBehaviorMap ; $400a
DataPtr_SpaResortSceneConfig:
	dw SpaResortSceneConfig ; $400c
DataPtr_HardCourtGroundsTiles:
	dw HardCourtGroundsTiles ; $400e
DataPtr_SpaResortSceneConfigAlias1:
	dw SpaResortSceneConfig ; $4010
DataPtr_SpaResortPalettes:
	dw SpaResortPalettes ; $4012
DataPtr_SpaResortTilemap:
	dw SpaResortTilemap ; $4014
DataPtr_SpaResortAttrmap:
	dw SpaResortAttrmap ; $4016
DataPtr_SpaResortCollisionMap:
	dw SpaResortCollisionMap ; $4018
DataPtr_SpaResortBehaviorMap:
	dw SpaResortBehaviorMap ; $401a
DataPtr_MainBuildingSceneConfig:
	dw MainBuildingSceneConfig ; $401c
DataPtr_SpaResortTiles:
	dw SpaResortTiles ; $401e
DataPtr_MainBuildingSceneConfigAlias1:
	dw MainBuildingSceneConfig ; $4020
DataPtr_MainBuildingPalettes:
	dw MainBuildingPalettes ; $4022
DataPtr_MainBuildingTilemap:
	dw MainBuildingTilemap ; $4024
DataPtr_MainBuildingAttrmap:
	dw MainBuildingAttrmap ; $4026
DataPtr_MainBuildingCollisionMap:
	dw MainBuildingCollisionMap ; $4028
DataPtr_MainBuildingBehaviorMap:
	dw MainBuildingBehaviorMap ; $402a
DataPtr_GardenPavilionSceneConfig:
	dw GardenPavilionSceneConfig ; $402c
DataPtr_MainBuildingTiles:
	dw MainBuildingTiles ; $402e
DataPtr_GardenPavilionSceneConfigAlias1:
	dw GardenPavilionSceneConfig ; $4030
DataPtr_GardenPavilionPalettes:
	dw GardenPavilionPalettes ; $4032
DataPtr_GardenPavilionTilemap:
	dw GardenPavilionTilemap ; $4034
DataPtr_GardenPavilionAttrmap:
	dw GardenPavilionAttrmap ; $4036
DataPtr_GardenPavilionCollisionMap:
	dw GardenPavilionCollisionMap ; $4038
DataPtr_GardenPavilionBehaviorMap:
	dw GardenPavilionBehaviorMap ; $403a
DataPtr_GardenPavilionSceneUnusedSlot:
	dw GardenPavilionSceneUnusedSlot ; $403c
DataPtr_GardenPavilionTiles:
	dw GardenPavilionTiles ; $403e
HardCourtGroundsSceneConfig:
	INCBIN "data/bank_066/HardCourtGroundsSceneConfig.bin" ; $4040, 42 bytes
HardCourtGroundsPalettes:
	INCLUDE "data/bank_066/HardCourtGroundsPalettes.asm" ; $406a, 64 bytes (palettes)
HardCourtGroundsTiles:
	INCBIN "data/bank_066/lz_HardCourtGroundsTiles.bin" ; $40aa, 1292 bytes
HardCourtGroundsTilemap:
	INCBIN "data/bank_066/lz_HardCourtGroundsTilemap.bin" ; $45b6, 1012 bytes
HardCourtGroundsAttrmap:
	INCBIN "data/bank_066/lz_HardCourtGroundsAttrmap.bin" ; $49aa, 760 bytes
HardCourtGroundsCollisionMap:
	INCBIN "data/bank_066/lz_HardCourtGroundsCollisionMap.bin" ; $4ca2, 101 bytes
HardCourtGroundsBehaviorMap:
	INCBIN "data/bank_066/lz_HardCourtGroundsBehaviorMap.bin" ; $4d07, 72 bytes
SpaResortSceneConfig:
	INCBIN "data/bank_066/SpaResortSceneConfig.bin" ; $4d4f, 42 bytes
SpaResortPalettes:
	INCLUDE "data/bank_066/SpaResortPalettes.asm" ; $4d79, 64 bytes (palettes)
SpaResortTiles:
	INCBIN "data/bank_066/lz_SpaResortTiles.bin" ; $4db9, 2034 bytes
SpaResortTilemap:
	INCBIN "data/bank_066/lz_SpaResortTilemap.bin" ; $55ab, 1086 bytes
SpaResortAttrmap:
	INCBIN "data/bank_066/lz_SpaResortAttrmap.bin" ; $59e9, 675 bytes
SpaResortCollisionMap:
	INCBIN "data/bank_066/lz_SpaResortCollisionMap.bin" ; $5c8c, 118 bytes
SpaResortBehaviorMap:
	INCBIN "data/bank_066/lz_SpaResortBehaviorMap.bin" ; $5d02, 128 bytes
MainBuildingSceneConfig:
	INCBIN "data/bank_066/MainBuildingSceneConfig.bin" ; $5d82, 9 bytes
MainBuildingPalettes:
	INCLUDE "data/bank_066/MainBuildingPalettes.asm" ; $5d8b, 64 bytes (palettes)
MainBuildingTiles:
	INCBIN "data/bank_066/lz_MainBuildingTiles.bin" ; $5dcb, 2301 bytes
MainBuildingTilemap:
	INCBIN "data/bank_066/lz_MainBuildingTilemap.bin" ; $66c8, 1096 bytes
MainBuildingAttrmap:
	INCBIN "data/bank_066/lz_MainBuildingAttrmap.bin" ; $6b10, 572 bytes
MainBuildingCollisionMap:
	INCBIN "data/bank_066/lz_MainBuildingCollisionMap.bin" ; $6d4c, 97 bytes
MainBuildingBehaviorMap:
	INCBIN "data/bank_066/lz_MainBuildingBehaviorMap.bin" ; $6dad, 75 bytes
GardenPavilionSceneConfig:
	INCBIN "data/bank_066/GardenPavilionSceneConfig.bin" ; $6df8, 42 bytes
GardenPavilionPalettes:
	INCLUDE "data/bank_066/GardenPavilionPalettes.asm" ; $6e22, 64 bytes (palettes)
GardenPavilionTiles:
	INCBIN "data/bank_066/lz_GardenPavilionTiles.bin" ; $6e62, 1916 bytes
GardenPavilionTilemap:
	INCBIN "data/bank_066/lz_GardenPavilionTilemap.bin" ; $75de, 971 bytes
GardenPavilionAttrmap:
	INCBIN "data/bank_066/lz_GardenPavilionAttrmap.bin" ; $79a9, 474 bytes
GardenPavilionCollisionMap:
	INCBIN "data/bank_066/lz_GardenPavilionCollisionMap.bin" ; $7b83, 95 bytes
GardenPavilionBehaviorMap:
	INCBIN "data/bank_066/lz_GardenPavilionBehaviorMap.bin" ; $7be2, 75 bytes
GardenPavilionSceneUnusedSlot:
	; $7c2d, 979 bytes fill to bank end (linker-padded)
