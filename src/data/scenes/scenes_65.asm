DataPtr_IslandSkySceneConfig:
	dw IslandSkySceneConfig ; $4000
DataPtr_IslandSkyPalettes:
	dw IslandSkyPalettes ; $4002
DataPtr_IslandSkyTilemap:
	dw IslandSkyTilemap ; $4004
DataPtr_IslandSkyAttrmap:
	dw IslandSkyAttrmap ; $4006
DataPtr_IslandSkyCollisionMap:
	dw IslandSkyCollisionMap ; $4008
DataPtr_IslandSkyBehaviorMap:
	dw IslandSkyBehaviorMap ; $400a
DataPtr_IslandSkySceneUnusedSlot:
	dw IslandSkySceneUnusedSlot ; $400c
DataPtr_IslandSkyTiles:
	dw IslandSkyTiles ; $400e
DataPtr_SpecialCourtSceneConfig:
	dw SpecialCourtSceneConfig ; $4010
DataPtr_SpecialCourtPalettes:
	dw SpecialCourtPalettes ; $4012
DataPtr_SpecialCourtTilemap:
	dw SpecialCourtTilemap ; $4014
DataPtr_SpecialCourtAttrmap:
	dw SpecialCourtAttrmap ; $4016
DataPtr_SpecialCourtCollisionMap:
	dw SpecialCourtCollisionMap ; $4018
DataPtr_SpecialCourtBehaviorMap:
	dw SpecialCourtBehaviorMap ; $401a
DataPtr_SpecialCourtSceneUnusedSlot:
	dw SpecialCourtSceneUnusedSlot ; $401c
DataPtr_SpecialCourtTiles:
	dw SpecialCourtTiles ; $401e
DataPtr_SeniorClassCourtSceneConfig:
	dw SeniorClassCourtSceneConfig ; $4020
DataPtr_SeniorClassCourtPalettes:
	dw SeniorClassCourtPalettes ; $4022
DataPtr_SeniorClassCourtTilemap:
	dw SeniorClassCourtTilemap ; $4024
DataPtr_SeniorClassCourtAttrmap:
	dw SeniorClassCourtAttrmap ; $4026
DataPtr_SeniorClassCourtCollisionMap:
	dw SeniorClassCourtCollisionMap ; $4028
DataPtr_SeniorClassCourtBehaviorMap:
	dw SeniorClassCourtBehaviorMap ; $402a
DataPtr_SeniorClassCourtSceneUnusedSlot:
	dw SeniorClassCourtSceneUnusedSlot ; $402c
DataPtr_SeniorClassCourtTiles:
	dw SeniorClassCourtTiles ; $402e
IslandSkySceneConfig:
	INCBIN "data/bank_065/IslandSkySceneConfig.bin" ; $4030, 27 bytes
IslandSkyPalettes:
	INCBIN "data/bank_065/IslandSkyPalettes.bin" ; $404b, 64 bytes
IslandSkyTiles:
	INCBIN "data/bank_065/lz_IslandSkyTiles.bin" ; $408b, 2987 bytes
IslandSkyTilemap:
	INCBIN "data/bank_065/lz_IslandSkyTilemap.bin" ; $4c36, 684 bytes
IslandSkyAttrmap:
	INCBIN "data/bank_065/lz_IslandSkyAttrmap.bin" ; $4ee2, 416 bytes
IslandSkyCollisionMap:
	INCBIN "data/bank_065/lz_IslandSkyCollisionMap.bin" ; $5082, 70 bytes
IslandSkyBehaviorMap:
	INCBIN "data/bank_065/lz_IslandSkyBehaviorMap.bin" ; $50c8, 73 bytes
	; $5111, 15 bytes (fill)
	ds 15, $00
IslandSkySceneUnusedSlot:
	INCBIN "data/bank_065/IslandSkySceneUnusedSlot.bin" ; $5120, 1536 bytes
SpecialCourtSceneConfig:
	INCBIN "data/bank_065/SpecialCourtSceneConfig.bin" ; $5720, 23 bytes
SpecialCourtPalettes:
	INCLUDE "data/bank_065/SpecialCourtPalettes.asm" ; $5737, 64 bytes (palettes)
SpecialCourtTiles:
	INCBIN "data/bank_065/lz_SpecialCourtTiles.bin" ; $5777, 1897 bytes
SpecialCourtTilemap:
	INCBIN "data/bank_065/lz_SpecialCourtTilemap.bin" ; $5ee0, 905 bytes
SpecialCourtAttrmap:
	INCBIN "data/bank_065/lz_SpecialCourtAttrmap.bin" ; $6269, 517 bytes
SpecialCourtCollisionMap:
	INCBIN "data/bank_065/lz_SpecialCourtCollisionMap.bin" ; $646e, 70 bytes
SpecialCourtBehaviorMap:
	INCBIN "data/bank_065/lz_SpecialCourtBehaviorMap.bin" ; $64b4, 70 bytes
	; $64fa, 6 bytes (fill)
	ds 6, $00
SpecialCourtSceneUnusedSlot:
	INCBIN "data/bank_065/SpecialCourtSceneUnusedSlot.bin" ; $6500, 1536 bytes
SeniorClassCourtSceneConfig:
	INCBIN "data/bank_065/SeniorClassCourtSceneConfig.bin" ; $6b00, 42 bytes
SeniorClassCourtPalettes:
	INCLUDE "data/bank_065/SeniorClassCourtPalettes.asm" ; $6b2a, 64 bytes (palettes)
SeniorClassCourtTiles:
	INCBIN "data/bank_065/lz_SeniorClassCourtTiles.bin" ; $6b6a, 2286 bytes
SeniorClassCourtTilemap:
	INCBIN "data/bank_065/lz_SeniorClassCourtTilemap.bin" ; $7458, 1178 bytes
SeniorClassCourtAttrmap:
	INCBIN "data/bank_065/lz_SeniorClassCourtAttrmap.bin" ; $78f2, 933 bytes
SeniorClassCourtCollisionMap:
	INCBIN "data/bank_065/lz_SeniorClassCourtCollisionMap.bin" ; $7c97, 110 bytes
SeniorClassCourtBehaviorMap:
	INCBIN "data/bank_065/lz_SeniorClassCourtBehaviorMap.bin" ; $7d05, 81 bytes
SeniorClassCourtSceneUnusedSlot:
	; $7d56, 682 bytes fill to bank end (linker-padded)
