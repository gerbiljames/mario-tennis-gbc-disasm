DataPtr_DormRoomSceneConfig:
	dw DormRoomSceneConfig ; $4000
DataPtr_DormRoomPalettes:
	dw DormRoomPalettes ; $4002
DataPtr_DormRoomTilemap:
	dw DormRoomTilemap ; $4004
DataPtr_DormRoomAttrmap:
	dw DormRoomAttrmap ; $4006
DataPtr_DormRoomCollisionMap:
	dw DormRoomCollisionMap ; $4008
DataPtr_DormRoomBehaviorMap:
	dw DormRoomBehaviorMap ; $400a
DataPtr_RestaurantPlazaSceneConfig:
	dw RestaurantPlazaSceneConfig ; $400c
DataPtr_DormRoomTiles:
	dw DormRoomTiles ; $400e
DataPtr_RestaurantPlazaSceneConfigAlias1:
	dw RestaurantPlazaSceneConfig ; $4010
DataPtr_RestaurantPlazaPalettes:
	dw RestaurantPlazaPalettes ; $4012
DataPtr_RestaurantPlazaTilemap:
	dw RestaurantPlazaTilemap ; $4014
DataPtr_RestaurantPlazaAttrmap:
	dw RestaurantPlazaAttrmap ; $4016
DataPtr_RestaurantPlazaCollisionMap:
	dw RestaurantPlazaCollisionMap ; $4018
DataPtr_RestaurantPlazaBehaviorMap:
	dw RestaurantPlazaBehaviorMap ; $401a
DataPtr_CourtyardSceneConfig:
	dw CourtyardSceneConfig ; $401c
DataPtr_RestaurantPlazaTiles:
	dw RestaurantPlazaTiles ; $401e
DataPtr_CourtyardSceneConfigAlias1:
	dw CourtyardSceneConfig ; $4020
DataPtr_CourtyardPalettes:
	dw CourtyardPalettes ; $4022
DataPtr_CourtyardTilemap:
	dw CourtyardTilemap ; $4024
DataPtr_CourtyardAttrmap:
	dw CourtyardAttrmap ; $4026
DataPtr_CourtyardCollisionMap:
	dw CourtyardCollisionMap ; $4028
DataPtr_CourtyardBehaviorMap:
	dw CourtyardBehaviorMap ; $402a
DataPtr_CourtyardSceneAnimTiles:
	dw CourtyardSceneAnimTiles ; $402c
DataPtr_CourtyardTiles:
	dw CourtyardTiles ; $402e
DormRoomSceneConfig:
	INCLUDE "data/scenes/DormRoomSceneConfig.asm" ; $4030, 42 bytes (scene_config)
DormRoomPalettes:
	INCLUDE "data/scenes/DormRoomPalettes.asm" ; $405a, 64 bytes (palettes)
DormRoomTiles:
	INCBIN "data/scenes/lz_DormRoomTiles.bin" ; $409a, 2307 bytes
DormRoomTilemap:
	INCBIN "data/scenes/lz_DormRoomTilemap.bin" ; $499d, 706 bytes
DormRoomAttrmap:
	INCBIN "data/scenes/lz_DormRoomAttrmap.bin" ; $4c5f, 511 bytes
DormRoomCollisionMap:
	INCBIN "data/scenes/lz_DormRoomCollisionMap.bin" ; $4e5e, 118 bytes
DormRoomBehaviorMap:
	INCBIN "data/scenes/lz_DormRoomBehaviorMap.bin" ; $4ed4, 72 bytes
RestaurantPlazaSceneConfig:
	INCLUDE "data/scenes/RestaurantPlazaSceneConfig.asm" ; $4f1c, 42 bytes (scene_config)
RestaurantPlazaPalettes:
	INCLUDE "data/scenes/RestaurantPlazaPalettes.asm" ; $4f46, 64 bytes (palettes)
RestaurantPlazaTiles:
	INCBIN "data/scenes/lz_RestaurantPlazaTiles.bin" ; $4f86, 3238 bytes
RestaurantPlazaTilemap:
	INCBIN "data/scenes/lz_RestaurantPlazaTilemap.bin" ; $5c2c, 802 bytes
RestaurantPlazaAttrmap:
	INCBIN "data/scenes/lz_RestaurantPlazaAttrmap.bin" ; $5f4e, 411 bytes
RestaurantPlazaCollisionMap:
	INCBIN "data/scenes/lz_RestaurantPlazaCollisionMap.bin" ; $60e9, 80 bytes
RestaurantPlazaBehaviorMap:
	INCBIN "data/scenes/lz_RestaurantPlazaBehaviorMap.bin" ; $6139, 90 bytes
CourtyardSceneConfig:
	INCLUDE "data/scenes/CourtyardSceneConfig.asm" ; $6193, 27 bytes (scene_config)
CourtyardPalettes:
	INCLUDE "data/scenes/CourtyardPalettes.asm" ; $61ae, 64 bytes (palettes)
CourtyardTiles:
	INCBIN "data/scenes/lz_CourtyardTiles.bin" ; $61ee, 3100 bytes
CourtyardTilemap:
	INCBIN "data/scenes/lz_CourtyardTilemap.bin" ; $6e0a, 1429 bytes
CourtyardAttrmap:
	INCBIN "data/scenes/lz_CourtyardAttrmap.bin" ; $739f, 679 bytes
CourtyardCollisionMap:
	INCBIN "data/scenes/lz_CourtyardCollisionMap.bin" ; $7646, 147 bytes
CourtyardBehaviorMap:
	INCBIN "data/scenes/lz_CourtyardBehaviorMap.bin" ; $76d9, 79 bytes
	; $7728, 8 bytes (fill)
	ds 8, $00
CourtyardSceneAnimTiles:
	INCBIN "data/scenes/CourtyardSceneAnimTiles.bin" ; $7730, 1536 bytes
	; $7d30, 720 bytes fill to bank end (linker-padded)
