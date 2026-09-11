DataPtr_SeasideSceneConfig:
	dw SeasideSceneConfig ; $4000
DataPtr_SeasidePalettes:
	dw SeasidePalettes ; $4002
DataPtr_SeasideTilemap:
	dw SeasideTilemap ; $4004
DataPtr_SeasideAttrmap:
	dw SeasideAttrmap ; $4006
DataPtr_SeasideCollisionMap:
	dw SeasideCollisionMap ; $4008
DataPtr_SeasideBehaviorMap:
	dw SeasideBehaviorMap ; $400a
DataPtr_SeasideSceneUnusedSlot:
	dw SeasideSceneUnusedSlot ; $400c
DataPtr_SeasideTiles:
	dw SeasideTiles ; $400e
DataPtr_HedgeCourtSceneConfig:
	dw HedgeCourtSceneConfig ; $4010
DataPtr_HedgeCourtPalettes:
	dw HedgeCourtPalettes ; $4012
DataPtr_HedgeCourtTilemap:
	dw HedgeCourtTilemap ; $4014
DataPtr_HedgeCourtAttrmap:
	dw HedgeCourtAttrmap ; $4016
DataPtr_HedgeCourtCollisionMap:
	dw HedgeCourtCollisionMap ; $4018
DataPtr_HedgeCourtBehaviorMap:
	dw HedgeCourtBehaviorMap ; $401a
DataPtr_HedgeCourtSceneUnusedSlot:
	dw HedgeCourtSceneUnusedSlot ; $401c
DataPtr_HedgeCourtTiles:
	dw HedgeCourtTiles ; $401e
DataPtr_ClayCourtGroundsSceneConfig:
	dw ClayCourtGroundsSceneConfig ; $4020
DataPtr_ClayCourtGroundsPalettes:
	dw ClayCourtGroundsPalettes ; $4022
DataPtr_ClayCourtGroundsTilemap:
	dw ClayCourtGroundsTilemap ; $4024
DataPtr_ClayCourtGroundsAttrmap:
	dw ClayCourtGroundsAttrmap ; $4026
DataPtr_ClayCourtGroundsCollisionMap:
	dw ClayCourtGroundsCollisionMap ; $4028
DataPtr_ClayCourtGroundsBehaviorMap:
	dw ClayCourtGroundsBehaviorMap ; $402a
DataPtr_ClayCourtGroundsSceneUnusedSlot:
	dw ClayCourtGroundsSceneUnusedSlot ; $402c
DataPtr_ClayCourtGroundsTiles:
	dw ClayCourtGroundsTiles ; $402e
SeasideSceneConfig:
	INCBIN "data/bank_065/SeasideSceneConfig.bin" ; $4030, 27 bytes
SeasidePalettes:
	INCBIN "data/bank_065/SeasidePalettes.bin" ; $404b, 64 bytes
SeasideTiles:
	INCBIN "data/bank_065/lz_SeasideTiles.bin" ; $408b, 2987 bytes
SeasideTilemap:
	INCBIN "data/bank_065/lz_SeasideTilemap.bin" ; $4c36, 684 bytes
SeasideAttrmap:
	INCBIN "data/bank_065/lz_SeasideAttrmap.bin" ; $4ee2, 416 bytes
SeasideCollisionMap:
	INCBIN "data/bank_065/lz_SeasideCollisionMap.bin" ; $5082, 70 bytes
SeasideBehaviorMap:
	INCBIN "data/bank_065/lz_SeasideBehaviorMap.bin" ; $50c8, 73 bytes
	; $5111, 15 bytes (fill)
	ds 15, $00
SeasideSceneUnusedSlot:
	INCBIN "data/bank_065/SeasideSceneUnusedSlot.bin" ; $5120, 1536 bytes
HedgeCourtSceneConfig:
	INCBIN "data/bank_065/HedgeCourtSceneConfig.bin" ; $5720, 23 bytes
HedgeCourtPalettes:
	INCLUDE "data/bank_065/HedgeCourtPalettes.asm" ; $5737, 64 bytes (palettes)
HedgeCourtTiles:
	INCBIN "data/bank_065/lz_HedgeCourtTiles.bin" ; $5777, 1897 bytes
HedgeCourtTilemap:
	INCBIN "data/bank_065/lz_HedgeCourtTilemap.bin" ; $5ee0, 905 bytes
HedgeCourtAttrmap:
	INCBIN "data/bank_065/lz_HedgeCourtAttrmap.bin" ; $6269, 517 bytes
HedgeCourtCollisionMap:
	INCBIN "data/bank_065/lz_HedgeCourtCollisionMap.bin" ; $646e, 70 bytes
HedgeCourtBehaviorMap:
	INCBIN "data/bank_065/lz_HedgeCourtBehaviorMap.bin" ; $64b4, 70 bytes
	; $64fa, 6 bytes (fill)
	ds 6, $00
HedgeCourtSceneUnusedSlot:
	INCBIN "data/bank_065/HedgeCourtSceneUnusedSlot.bin" ; $6500, 1536 bytes
ClayCourtGroundsSceneConfig:
	INCBIN "data/bank_065/ClayCourtGroundsSceneConfig.bin" ; $6b00, 42 bytes
ClayCourtGroundsPalettes:
	INCLUDE "data/bank_065/ClayCourtGroundsPalettes.asm" ; $6b2a, 64 bytes (palettes)
ClayCourtGroundsTiles:
	INCBIN "data/bank_065/lz_ClayCourtGroundsTiles.bin" ; $6b6a, 2286 bytes
ClayCourtGroundsTilemap:
	INCBIN "data/bank_065/lz_ClayCourtGroundsTilemap.bin" ; $7458, 1178 bytes
ClayCourtGroundsAttrmap:
	INCBIN "data/bank_065/lz_ClayCourtGroundsAttrmap.bin" ; $78f2, 933 bytes
ClayCourtGroundsCollisionMap:
	INCBIN "data/bank_065/lz_ClayCourtGroundsCollisionMap.bin" ; $7c97, 110 bytes
ClayCourtGroundsBehaviorMap:
	INCBIN "data/bank_065/lz_ClayCourtGroundsBehaviorMap.bin" ; $7d05, 81 bytes
ClayCourtGroundsSceneUnusedSlot:
	; $7d56, 682 bytes fill to bank end (linker-padded)
