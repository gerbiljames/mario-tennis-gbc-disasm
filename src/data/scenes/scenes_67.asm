DataPtr_TournamentCourtyardSceneConfig:
	dw TournamentCourtyardSceneConfig ; $4000
DataPtr_TournamentCourtyardPalettes:
	dw TournamentCourtyardPalettes ; $4002
DataPtr_TournamentCourtyardTilemap:
	dw TournamentCourtyardTilemap ; $4004
DataPtr_TournamentCourtyardAttrmap:
	dw TournamentCourtyardAttrmap ; $4006
DataPtr_TournamentCourtyardCollisionMap:
	dw TournamentCourtyardCollisionMap ; $4008
DataPtr_TournamentCourtyardBehaviorMap:
	dw TournamentCourtyardBehaviorMap ; $400a
DataPtr_TournamentCourtyardSceneUnusedSlot:
	dw TournamentCourtyardSceneUnusedSlot ; $400c
DataPtr_TournamentCourtyardTiles:
	dw TournamentCourtyardTiles ; $400e
DataPtr_Court1SceneConfig:
	dw Court1SceneConfig ; $4010
DataPtr_Court1Palettes:
	dw Court1Palettes ; $4012
DataPtr_Court1Tilemap:
	dw Court1Tilemap ; $4014
DataPtr_Court1Attrmap:
	dw Court1Attrmap ; $4016
DataPtr_Court1CollisionMap:
	dw Court1CollisionMap ; $4018
DataPtr_Court1BehaviorMap:
	dw Court1BehaviorMap ; $401a
DataPtr_TrainingCourtMapSceneConfig:
	dw TrainingCourtMapSceneConfig ; $401c
DataPtr_Court1Tiles:
	dw Court1Tiles ; $401e
DataPtr_TrainingCourtMapSceneConfigAlias1:
	dw TrainingCourtMapSceneConfig ; $4020
DataPtr_TrainingCourtMapPalettes:
	dw TrainingCourtMapPalettes ; $4022
DataPtr_TrainingCourtMapTilemap:
	dw TrainingCourtMapTilemap ; $4024
DataPtr_TrainingCourtMapAttrmap:
	dw TrainingCourtMapAttrmap ; $4026
DataPtr_TrainingCourtMapCollisionMap:
	dw TrainingCourtMapCollisionMap ; $4028
DataPtr_TrainingCourtMapBehaviorMap:
	dw TrainingCourtMapBehaviorMap ; $402a
DataPtr_TrainingCourtMapSceneUnusedSlot:
	dw TrainingCourtMapSceneUnusedSlot ; $402c
DataPtr_TrainingCourtMapTiles:
	dw TrainingCourtMapTiles ; $402e
TournamentCourtyardSceneConfig:
	INCBIN "data/bank_067/TournamentCourtyardSceneConfig.bin" ; $4030, 27 bytes
TournamentCourtyardPalettes:
	INCLUDE "data/bank_067/TournamentCourtyardPalettes.asm" ; $404b, 64 bytes (palettes)
TournamentCourtyardTiles:
	INCBIN "data/bank_067/lz_TournamentCourtyardTiles.bin" ; $408b, 3052 bytes
TournamentCourtyardTilemap:
	INCBIN "data/bank_067/lz_TournamentCourtyardTilemap.bin" ; $4c77, 1101 bytes
TournamentCourtyardAttrmap:
	INCBIN "data/bank_067/lz_TournamentCourtyardAttrmap.bin" ; $50c4, 689 bytes
TournamentCourtyardCollisionMap:
	INCBIN "data/bank_067/lz_TournamentCourtyardCollisionMap.bin" ; $5375, 106 bytes
TournamentCourtyardBehaviorMap:
	INCBIN "data/bank_067/lz_TournamentCourtyardBehaviorMap.bin" ; $53df, 83 bytes
	; $5432, 14 bytes (fill)
	ds 14, $00
TournamentCourtyardSceneUnusedSlot:
	INCBIN "data/bank_067/TournamentCourtyardSceneUnusedSlot.bin" ; $5440, 1536 bytes
Court1SceneConfig:
	INCBIN "data/bank_067/Court1SceneConfig.bin" ; $5a40, 42 bytes
Court1Palettes:
	INCLUDE "data/bank_067/Court1Palettes.asm" ; $5a6a, 64 bytes (palettes)
Court1Tiles:
	INCBIN "data/bank_067/lz_Court1Tiles.bin" ; $5aaa, 2357 bytes
Court1Tilemap:
	INCBIN "data/bank_067/lz_Court1Tilemap.bin" ; $63df, 922 bytes
Court1Attrmap:
	INCBIN "data/bank_067/lz_Court1Attrmap.bin" ; $6779, 569 bytes
Court1CollisionMap:
	INCBIN "data/bank_067/lz_Court1CollisionMap.bin" ; $69b2, 103 bytes
Court1BehaviorMap:
	INCBIN "data/bank_067/lz_Court1BehaviorMap.bin" ; $6a19, 75 bytes
TrainingCourtMapSceneConfig:
	INCBIN "data/bank_067/TrainingCourtMapSceneConfig.bin" ; $6a64, 42 bytes
TrainingCourtMapPalettes:
	INCLUDE "data/bank_067/TrainingCourtMapPalettes.asm" ; $6a8e, 64 bytes (palettes)
TrainingCourtMapTiles:
	INCBIN "data/bank_067/lz_TrainingCourtMapTiles.bin" ; $6ace, 2316 bytes
TrainingCourtMapTilemap:
	INCBIN "data/bank_067/lz_TrainingCourtMapTilemap.bin" ; $73da, 1330 bytes
TrainingCourtMapAttrmap:
	INCBIN "data/bank_067/lz_TrainingCourtMapAttrmap.bin" ; $790c, 710 bytes
TrainingCourtMapCollisionMap:
	INCBIN "data/bank_067/lz_TrainingCourtMapCollisionMap.bin" ; $7bd2, 128 bytes
TrainingCourtMapBehaviorMap:
	INCBIN "data/bank_067/lz_TrainingCourtMapBehaviorMap.bin" ; $7c52, 76 bytes
TrainingCourtMapSceneUnusedSlot:
	; $7c9e, 866 bytes fill to bank end (linker-padded)
