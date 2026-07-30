SECTION "ROM Bank $69", ROMX[$4000], BANK[$69]

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
	INCBIN "data/bank_069/d_4030.bin" ; $4030, 42 bytes
TrainingHallPalettes:
	INCLUDE "data/bank_069/palettes_405a.asm" ; $405a, 64 bytes (palettes)
TrainingHallTiles:
	INCBIN "data/bank_069/lz_409a.bin" ; $409a, 3011 bytes
TrainingHallTilemap:
	INCBIN "data/bank_069/lz_4c5d.bin" ; $4c5d, 1214 bytes
TrainingHallAttrmap:
	INCBIN "data/bank_069/lz_511b.bin" ; $511b, 759 bytes
TrainingHallCollisionMap:
	INCBIN "data/bank_069/lz_5412.bin" ; $5412, 129 bytes
TrainingHallBehaviorMap:
	INCBIN "data/bank_069/lz_5493.bin" ; $5493, 129 bytes
CenterCourtHallSceneConfig:
	INCBIN "data/bank_069/d_5514.bin" ; $5514, 42 bytes
CenterCourtHallPalettes:
	INCLUDE "data/bank_069/palettes_553e.asm" ; $553e, 64 bytes (palettes)
CenterCourtHallTiles:
	INCBIN "data/bank_069/lz_557e.bin" ; $557e, 2082 bytes
CenterCourtHallTilemap:
	INCBIN "data/bank_069/lz_5da0.bin" ; $5da0, 991 bytes
CenterCourtHallAttrmap:
	INCBIN "data/bank_069/lz_617f.bin" ; $617f, 751 bytes
CenterCourtHallCollisionMap:
	INCBIN "data/bank_069/lz_646e.bin" ; $646e, 125 bytes
CenterCourtHallBehaviorMap:
	INCBIN "data/bank_069/lz_64eb.bin" ; $64eb, 87 bytes
ClubroomInteriorSceneConfig:
	INCBIN "data/bank_069/d_6542.bin" ; $6542, 27 bytes
ClubroomInteriorPalettes:
	INCLUDE "data/bank_069/palettes_655d.asm" ; $655d, 64 bytes (palettes)
ClubroomInteriorTiles:
	INCBIN "data/bank_069/lz_659d.bin" ; $659d, 2486 bytes
ClubroomInteriorTilemap:
	INCBIN "data/bank_069/lz_6f53.bin" ; $6f53, 999 bytes
ClubroomInteriorAttrmap:
	INCBIN "data/bank_069/lz_733a.bin" ; $733a, 647 bytes
ClubroomInteriorCollisionMap:
	INCBIN "data/bank_069/lz_75c1.bin" ; $75c1, 84 bytes
ClubroomInteriorBehaviorMap:
	INCBIN "data/bank_069/lz_7615.bin" ; $7615, 75 bytes
ClubroomInteriorSceneUnusedSlot:
	INCBIN "data/bank_069/d_7660.bin" ; $7660, 2464 bytes
