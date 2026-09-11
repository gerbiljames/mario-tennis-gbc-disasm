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
DataPtr_CourtyardSceneUnusedSlot:
	dw CourtyardSceneUnusedSlot ; $402c
DataPtr_CourtyardTiles:
	dw CourtyardTiles ; $402e
DormRoomSceneConfig:
	INCBIN "data/bank_064/DormRoomSceneConfig.bin" ; $4030, 42 bytes
DormRoomPalettes:
	INCLUDE "data/bank_064/DormRoomPalettes.asm" ; $405a, 64 bytes (palettes)
DormRoomTiles:
	INCBIN "data/bank_064/lz_DormRoomTiles.bin" ; $409a, 2307 bytes
DormRoomTilemap:
	INCBIN "data/bank_064/lz_DormRoomTilemap.bin" ; $499d, 706 bytes
DormRoomAttrmap:
	INCBIN "data/bank_064/lz_DormRoomAttrmap.bin" ; $4c5f, 511 bytes
DormRoomCollisionMap:
	INCBIN "data/bank_064/lz_DormRoomCollisionMap.bin" ; $4e5e, 118 bytes
DormRoomBehaviorMap:
	INCBIN "data/bank_064/lz_DormRoomBehaviorMap.bin" ; $4ed4, 72 bytes
RestaurantPlazaSceneConfig:
	INCBIN "data/bank_064/RestaurantPlazaSceneConfig.bin" ; $4f1c, 42 bytes
RestaurantPlazaPalettes:
	INCLUDE "data/bank_064/RestaurantPlazaPalettes.asm" ; $4f46, 64 bytes (palettes)
RestaurantPlazaTiles:
	INCBIN "data/bank_064/lz_RestaurantPlazaTiles.bin" ; $4f86, 3238 bytes
RestaurantPlazaTilemap:
	INCBIN "data/bank_064/lz_RestaurantPlazaTilemap.bin" ; $5c2c, 802 bytes
RestaurantPlazaAttrmap:
	INCBIN "data/bank_064/lz_RestaurantPlazaAttrmap.bin" ; $5f4e, 411 bytes
RestaurantPlazaCollisionMap:
	INCBIN "data/bank_064/lz_RestaurantPlazaCollisionMap.bin" ; $60e9, 80 bytes
RestaurantPlazaBehaviorMap:
	INCBIN "data/bank_064/lz_RestaurantPlazaBehaviorMap.bin" ; $6139, 90 bytes
CourtyardSceneConfig:
	INCBIN "data/bank_064/CourtyardSceneConfig.bin" ; $6193, 27 bytes
CourtyardPalettes:
	INCLUDE "data/bank_064/CourtyardPalettes.asm" ; $61ae, 64 bytes (palettes)
CourtyardTiles:
	INCBIN "data/bank_064/lz_CourtyardTiles.bin" ; $61ee, 3100 bytes
CourtyardTilemap:
	INCBIN "data/bank_064/lz_CourtyardTilemap.bin" ; $6e0a, 1429 bytes
CourtyardAttrmap:
	INCBIN "data/bank_064/lz_CourtyardAttrmap.bin" ; $739f, 679 bytes
CourtyardCollisionMap:
	INCBIN "data/bank_064/lz_CourtyardCollisionMap.bin" ; $7646, 147 bytes
CourtyardBehaviorMap:
	INCBIN "data/bank_064/lz_CourtyardBehaviorMap.bin" ; $76d9, 79 bytes
	; $7728, 8 bytes (fill)
	ds 8, $00
CourtyardSceneUnusedSlot:
	INCBIN "data/bank_064/CourtyardSceneUnusedSlot.bin" ; $7730, 2256 bytes
