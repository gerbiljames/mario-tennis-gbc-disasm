DataPtr_Court2SceneConfig:
	dw Court2SceneConfig ; $4000
DataPtr_Court2Palettes:
	dw Court2Palettes ; $4002
DataPtr_Court2Tilemap:
	dw Court2Tilemap ; $4004
DataPtr_Court2Attrmap:
	dw Court2Attrmap ; $4006
DataPtr_Court2CollisionMap:
	dw Court2CollisionMap ; $4008
DataPtr_Court2BehaviorMap:
	dw Court2BehaviorMap ; $400a
DataPtr_CenterCourtMapSceneConfig:
	dw CenterCourtMapSceneConfig ; $400c
DataPtr_Court2Tiles:
	dw Court2Tiles ; $400e
DataPtr_CenterCourtMapSceneConfigAlias1:
	dw CenterCourtMapSceneConfig ; $4010
DataPtr_CenterCourtMapPalettes:
	dw CenterCourtMapPalettes ; $4012
DataPtr_CenterCourtMapTilemap:
	dw CenterCourtMapTilemap ; $4014
DataPtr_CenterCourtMapAttrmap:
	dw CenterCourtMapAttrmap ; $4016
DataPtr_CenterCourtMapCollisionMap:
	dw CenterCourtMapCollisionMap ; $4018
DataPtr_CenterCourtMapBehaviorMap:
	dw CenterCourtMapBehaviorMap ; $401a
DataPtr_PeachsCastleSceneConfig:
	dw PeachsCastleSceneConfig ; $401c
DataPtr_CenterCourtMapTiles:
	dw CenterCourtMapTiles ; $401e
DataPtr_PeachsCastleSceneConfigAlias1:
	dw PeachsCastleSceneConfig ; $4020
DataPtr_PeachsCastlePalettes:
	dw PeachsCastlePalettes ; $4022
DataPtr_PeachsCastleTilemap:
	dw PeachsCastleTilemap ; $4024
DataPtr_PeachsCastleAttrmap:
	dw PeachsCastleAttrmap ; $4026
DataPtr_PeachsCastleCollisionMap:
	dw PeachsCastleCollisionMap ; $4028
DataPtr_PeachsCastleBehaviorMap:
	dw PeachsCastleBehaviorMap ; $402a
DataPtr_PeachsCastleSceneUnusedSlot:
	dw PeachsCastleSceneUnusedSlot ; $402c
DataPtr_PeachsCastleTiles:
	dw PeachsCastleTiles ; $402e
Court2SceneConfig:
	INCBIN "data/bank_068/Court2SceneConfig.bin" ; $4030, 42 bytes
Court2Palettes:
	INCLUDE "data/bank_068/Court2Palettes.asm" ; $405a, 64 bytes (palettes)
Court2Tiles:
	INCBIN "data/bank_068/lz_Court2Tiles.bin" ; $409a, 3032 bytes
Court2Tilemap:
	INCBIN "data/bank_068/lz_Court2Tilemap.bin" ; $4c72, 1173 bytes
Court2Attrmap:
	INCBIN "data/bank_068/lz_Court2Attrmap.bin" ; $5107, 702 bytes
Court2CollisionMap:
	INCBIN "data/bank_068/lz_Court2CollisionMap.bin" ; $53c5, 108 bytes
Court2BehaviorMap:
	INCBIN "data/bank_068/lz_Court2BehaviorMap.bin" ; $5431, 74 bytes
CenterCourtMapSceneConfig:
	INCBIN "data/bank_068/CenterCourtMapSceneConfig.bin" ; $547b, 42 bytes
CenterCourtMapPalettes:
	INCLUDE "data/bank_068/CenterCourtMapPalettes.asm" ; $54a5, 64 bytes (palettes)
CenterCourtMapTiles:
	INCBIN "data/bank_068/lz_CenterCourtMapTiles.bin" ; $54e5, 2108 bytes
CenterCourtMapTilemap:
	INCBIN "data/bank_068/lz_CenterCourtMapTilemap.bin" ; $5d21, 1091 bytes
CenterCourtMapAttrmap:
	INCBIN "data/bank_068/lz_CenterCourtMapAttrmap.bin" ; $6164, 620 bytes
CenterCourtMapCollisionMap:
	INCBIN "data/bank_068/lz_CenterCourtMapCollisionMap.bin" ; $63d0, 101 bytes
CenterCourtMapBehaviorMap:
	INCBIN "data/bank_068/lz_CenterCourtMapBehaviorMap.bin" ; $6435, 75 bytes
PeachsCastleSceneConfig:
	INCBIN "data/bank_068/PeachsCastleSceneConfig.bin" ; $6480, 23 bytes
PeachsCastlePalettes:
	INCLUDE "data/bank_068/PeachsCastlePalettes.asm" ; $6497, 64 bytes (palettes)
PeachsCastleTiles:
	INCBIN "data/bank_068/lz_PeachsCastleTiles.bin" ; $64d7, 2325 bytes
PeachsCastleTilemap:
	INCBIN "data/bank_068/lz_PeachsCastleTilemap.bin" ; $6dec, 849 bytes
PeachsCastleAttrmap:
	INCBIN "data/bank_068/lz_PeachsCastleAttrmap.bin" ; $713d, 595 bytes
PeachsCastleCollisionMap:
	INCBIN "data/bank_068/lz_PeachsCastleCollisionMap.bin" ; $7390, 103 bytes
PeachsCastleBehaviorMap:
	INCBIN "data/bank_068/lz_PeachsCastleBehaviorMap.bin" ; $73f7, 74 bytes
	; $7441, 15 bytes (fill)
	ds 15, $00
PeachsCastleSceneUnusedSlot:
	INCBIN "data/bank_068/PeachsCastleSceneUnusedSlot.bin" ; $7450, 2992 bytes
