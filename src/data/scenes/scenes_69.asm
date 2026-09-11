DataPtr_TrainingHallSceneConfig:
	dw TrainingHallSceneConfig ; $4000
DataPtr_TrainingHallPalettes:
	dw TrainingHallPalettes ; $4002
DataPtr_TrainingHallTilemap:
	dw TrainingHallTilemap ; $4004
DataPtr_TrainingHallAttrmap:
	dw TrainingHallAttrmap ; $4006
DataPtr_TrainingHallCollisionMap:
	dw TrainingHallCollisionMap ; $4008
DataPtr_TrainingHallBehaviorMap:
	dw TrainingHallBehaviorMap ; $400a
DataPtr_CenterCourtHallSceneConfig:
	dw CenterCourtHallSceneConfig ; $400c
DataPtr_TrainingHallTiles:
	dw TrainingHallTiles ; $400e
DataPtr_CenterCourtHallSceneConfigAlias1:
	dw CenterCourtHallSceneConfig ; $4010
DataPtr_CenterCourtHallPalettes:
	dw CenterCourtHallPalettes ; $4012
DataPtr_CenterCourtHallTilemap:
	dw CenterCourtHallTilemap ; $4014
DataPtr_CenterCourtHallAttrmap:
	dw CenterCourtHallAttrmap ; $4016
DataPtr_CenterCourtHallCollisionMap:
	dw CenterCourtHallCollisionMap ; $4018
DataPtr_CenterCourtHallBehaviorMap:
	dw CenterCourtHallBehaviorMap ; $401a
DataPtr_ClubroomInteriorSceneConfig:
	dw ClubroomInteriorSceneConfig ; $401c
DataPtr_CenterCourtHallTiles:
	dw CenterCourtHallTiles ; $401e
DataPtr_ClubroomInteriorSceneConfigAlias1:
	dw ClubroomInteriorSceneConfig ; $4020
DataPtr_ClubroomInteriorPalettes:
	dw ClubroomInteriorPalettes ; $4022
DataPtr_ClubroomInteriorTilemap:
	dw ClubroomInteriorTilemap ; $4024
DataPtr_ClubroomInteriorAttrmap:
	dw ClubroomInteriorAttrmap ; $4026
DataPtr_ClubroomInteriorCollisionMap:
	dw ClubroomInteriorCollisionMap ; $4028
DataPtr_ClubroomInteriorBehaviorMap:
	dw ClubroomInteriorBehaviorMap ; $402a
DataPtr_ClubroomInteriorSceneUnusedSlot:
	dw ClubroomInteriorSceneUnusedSlot ; $402c
DataPtr_ClubroomInteriorTiles:
	dw ClubroomInteriorTiles ; $402e
TrainingHallSceneConfig:
	INCBIN "data/bank_069/TrainingHallSceneConfig.bin" ; $4030, 42 bytes
TrainingHallPalettes:
	INCLUDE "data/bank_069/TrainingHallPalettes.asm" ; $405a, 64 bytes (palettes)
TrainingHallTiles:
	INCBIN "data/bank_069/lz_TrainingHallTiles.bin" ; $409a, 3011 bytes
TrainingHallTilemap:
	INCBIN "data/bank_069/lz_TrainingHallTilemap.bin" ; $4c5d, 1214 bytes
TrainingHallAttrmap:
	INCBIN "data/bank_069/lz_TrainingHallAttrmap.bin" ; $511b, 759 bytes
TrainingHallCollisionMap:
	INCBIN "data/bank_069/lz_TrainingHallCollisionMap.bin" ; $5412, 129 bytes
TrainingHallBehaviorMap:
	INCBIN "data/bank_069/lz_TrainingHallBehaviorMap.bin" ; $5493, 129 bytes
CenterCourtHallSceneConfig:
	INCBIN "data/bank_069/CenterCourtHallSceneConfig.bin" ; $5514, 42 bytes
CenterCourtHallPalettes:
	INCLUDE "data/bank_069/CenterCourtHallPalettes.asm" ; $553e, 64 bytes (palettes)
CenterCourtHallTiles:
	INCBIN "data/bank_069/lz_CenterCourtHallTiles.bin" ; $557e, 2082 bytes
CenterCourtHallTilemap:
	INCBIN "data/bank_069/lz_CenterCourtHallTilemap.bin" ; $5da0, 991 bytes
CenterCourtHallAttrmap:
	INCBIN "data/bank_069/lz_CenterCourtHallAttrmap.bin" ; $617f, 751 bytes
CenterCourtHallCollisionMap:
	INCBIN "data/bank_069/lz_CenterCourtHallCollisionMap.bin" ; $646e, 125 bytes
CenterCourtHallBehaviorMap:
	INCBIN "data/bank_069/lz_CenterCourtHallBehaviorMap.bin" ; $64eb, 87 bytes
ClubroomInteriorSceneConfig:
	INCBIN "data/bank_069/ClubroomInteriorSceneConfig.bin" ; $6542, 27 bytes
ClubroomInteriorPalettes:
	INCLUDE "data/bank_069/ClubroomInteriorPalettes.asm" ; $655d, 64 bytes (palettes)
ClubroomInteriorTiles:
	INCBIN "data/bank_069/lz_ClubroomInteriorTiles.bin" ; $659d, 2486 bytes
ClubroomInteriorTilemap:
	INCBIN "data/bank_069/lz_ClubroomInteriorTilemap.bin" ; $6f53, 999 bytes
ClubroomInteriorAttrmap:
	INCBIN "data/bank_069/lz_ClubroomInteriorAttrmap.bin" ; $733a, 647 bytes
ClubroomInteriorCollisionMap:
	INCBIN "data/bank_069/lz_ClubroomInteriorCollisionMap.bin" ; $75c1, 84 bytes
ClubroomInteriorBehaviorMap:
	INCBIN "data/bank_069/lz_ClubroomInteriorBehaviorMap.bin" ; $7615, 75 bytes
ClubroomInteriorSceneUnusedSlot:
	INCBIN "data/bank_069/ClubroomInteriorSceneUnusedSlot.bin" ; $7660, 2464 bytes
