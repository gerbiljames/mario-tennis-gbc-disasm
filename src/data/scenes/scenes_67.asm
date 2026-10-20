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
DataPtr_TournamentCourtyardSceneAnimTiles:
	dw TournamentCourtyardSceneAnimTiles ; $400c
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
DataPtr_TrainingCourtMapSceneNoAnimTiles:
	dw TrainingCourtMapSceneNoAnimTiles ; $402c
DataPtr_TrainingCourtMapTiles:
	dw TrainingCourtMapTiles ; $402e
TournamentCourtyardSceneConfig:
	INCLUDE "data/scenes/TournamentCourtyardSceneConfig.asm" ; $4030, 27 bytes (scene_config)
TournamentCourtyardPalettes:
	INCLUDE "data/scenes/TournamentCourtyardPalettes.asm" ; $404b, 64 bytes (palettes)
TournamentCourtyardTiles:
	INCBIN "data/scenes/lz_TournamentCourtyardTiles.bin" ; $408b, 3052 bytes
TournamentCourtyardTilemap:
	INCBIN "data/scenes/lz_TournamentCourtyardTilemap.bin" ; $4c77, 1101 bytes
TournamentCourtyardAttrmap:
	INCBIN "data/scenes/lz_TournamentCourtyardAttrmap.bin" ; $50c4, 689 bytes
TournamentCourtyardCollisionMap:
	INCBIN "data/scenes/lz_TournamentCourtyardCollisionMap.bin" ; $5375, 106 bytes
TournamentCourtyardBehaviorMap:
	INCBIN "data/scenes/lz_TournamentCourtyardBehaviorMap.bin" ; $53df, 83 bytes
	; $5432, 14 bytes (fill)
	ds 14, $00
TournamentCourtyardSceneAnimTiles:
	INCBIN "data/scenes/TournamentCourtyardSceneAnimTiles.bin" ; $5440, 1536 bytes
Court1SceneConfig:
	INCLUDE "data/scenes/Court1SceneConfig.asm" ; $5a40, 42 bytes (scene_config)
Court1Palettes:
	INCLUDE "data/scenes/Court1Palettes.asm" ; $5a6a, 64 bytes (palettes)
Court1Tiles:
	INCBIN "data/scenes/lz_Court1Tiles.bin" ; $5aaa, 2357 bytes
Court1Tilemap:
	INCBIN "data/scenes/lz_Court1Tilemap.bin" ; $63df, 922 bytes
Court1Attrmap:
	INCBIN "data/scenes/lz_Court1Attrmap.bin" ; $6779, 569 bytes
Court1CollisionMap:
	INCBIN "data/scenes/lz_Court1CollisionMap.bin" ; $69b2, 103 bytes
Court1BehaviorMap:
	INCBIN "data/scenes/lz_Court1BehaviorMap.bin" ; $6a19, 75 bytes
TrainingCourtMapSceneConfig:
	INCLUDE "data/scenes/TrainingCourtMapSceneConfig.asm" ; $6a64, 42 bytes (scene_config)
TrainingCourtMapPalettes:
	INCLUDE "data/scenes/TrainingCourtMapPalettes.asm" ; $6a8e, 64 bytes (palettes)
TrainingCourtMapTiles:
	INCBIN "data/scenes/lz_TrainingCourtMapTiles.bin" ; $6ace, 2316 bytes
TrainingCourtMapTilemap:
	INCBIN "data/scenes/lz_TrainingCourtMapTilemap.bin" ; $73da, 1330 bytes
TrainingCourtMapAttrmap:
	INCBIN "data/scenes/lz_TrainingCourtMapAttrmap.bin" ; $790c, 710 bytes
TrainingCourtMapCollisionMap:
	INCBIN "data/scenes/lz_TrainingCourtMapCollisionMap.bin" ; $7bd2, 128 bytes
TrainingCourtMapBehaviorMap:
	INCBIN "data/scenes/lz_TrainingCourtMapBehaviorMap.bin" ; $7c52, 76 bytes
TrainingCourtMapSceneNoAnimTiles:
	; $7c9e, 866 bytes fill to bank end (linker-padded)
