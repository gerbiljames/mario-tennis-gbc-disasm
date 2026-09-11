DataPtr_IslandOpenCourtSceneConfig:
	dw IslandOpenCourtSceneConfig ; $4000
DataPtr_IslandOpenCourtPalettes:
	dw IslandOpenCourtPalettes ; $4002
DataPtr_IslandOpenCourtTilemap:
	dw IslandOpenCourtTilemap ; $4004
DataPtr_IslandOpenCourtAttrmap:
	dw IslandOpenCourtAttrmap ; $4006
DataPtr_IslandOpenCourtSceneConfigAlias1:
	dw IslandOpenCourtSceneConfig ; $4008
DataPtr_IslandOpenCourtScoreboardColumnAttrs:
	dw IslandOpenCourtScoreboardColumnAttrs ; $400a
DataPtr_DKCourtPalettes:
	dw DKCourtPalettes ; $400c
DataPtr_IslandOpenCourtTiles:
	dw IslandOpenCourtTiles ; $400e
DataPtr_DKCourtSceneConfig:
	dw DKCourtSceneConfig ; $4010
DataPtr_DKCourtPalettesAlias1:
	dw DKCourtPalettes ; $4012
DataPtr_DKCourtTilemap:
	dw DKCourtTilemap ; $4014
DataPtr_DKCourtAttrmap:
	dw DKCourtAttrmap ; $4016
DataPtr_DKCourtSceneConfigAlias1:
	dw DKCourtSceneConfig ; $4018
DataPtr_DKCourtScoreboardColumnAttrs:
	dw DKCourtScoreboardColumnAttrs ; $401a
DataPtr_StarPatternBgSceneConfig:
	dw StarPatternBgSceneConfig ; $401c
DataPtr_DKCourtTiles:
	dw DKCourtTiles ; $401e
DataPtr_StarPatternBgSceneConfigAlias1:
	dw StarPatternBgSceneConfig ; $4020
DataPtr_StarPatternBgPalettes:
	dw StarPatternBgPalettes ; $4022
DataPtr_StarPatternBgTilemap:
	dw StarPatternBgTilemap ; $4024
DataPtr_StarPatternBgAttrmap:
	dw StarPatternBgAttrmap ; $4026
DataPtr_StarPatternBgCollisionMap:
	dw StarPatternBgCollisionMap ; $4028
DataPtr_StarPatternBgBehaviorMap:
	dw StarPatternBgBehaviorMap ; $402a
DataPtr_AcademyMainBldgSceneConfig:
	dw AcademyMainBldgSceneConfig ; $402c
DataPtr_StarPatternBgTiles:
	dw StarPatternBgTiles ; $402e
DataPtr_AcademyMainBldgSceneConfigAlias1:
	dw AcademyMainBldgSceneConfig ; $4030
DataPtr_AcademyMainBldgPalettes:
	dw AcademyMainBldgPalettes ; $4032
DataPtr_AcademyMainBldgTilemap:
	dw AcademyMainBldgTilemap ; $4034
DataPtr_AcademyMainBldgAttrmap:
	dw AcademyMainBldgAttrmap ; $4036
DataPtr_AcademyMainBldgCollisionMap:
	dw AcademyMainBldgCollisionMap ; $4038
DataPtr_AcademyMainBldgBehaviorMap:
	dw AcademyMainBldgBehaviorMap ; $403a
DataPtr_AcademyMainBldgSceneUnusedSlot:
	dw AcademyMainBldgSceneUnusedSlot ; $403c
DataPtr_AcademyMainBldgTiles:
	dw AcademyMainBldgTiles ; $403e
IslandOpenCourtPalettes:
	INCLUDE "data/bank_063/IslandOpenCourtPalettes.asm" ; $4040, 64 bytes (palettes)
IslandOpenCourtTiles:
	INCBIN "data/bank_063/lz_IslandOpenCourtTiles.bin" ; $4080, 2042 bytes
IslandOpenCourtTilemap:
	INCBIN "data/bank_063/lz_IslandOpenCourtTilemap.bin" ; $487a, 635 bytes
IslandOpenCourtAttrmap:
	INCBIN "data/bank_063/lz_IslandOpenCourtAttrmap.bin" ; $4af5, 185 bytes
IslandOpenCourtSceneConfig:
	INCBIN "data/bank_063/IslandOpenCourtSceneConfig.bin" ; $4bae, 40 bytes
IslandOpenCourtScoreboardColumnAttrs:
	INCBIN "data/bank_063/IslandOpenCourtScoreboardColumnAttrs.bin" ; $4bd6, 40 bytes
DKCourtPalettes:
	INCLUDE "data/bank_063/DKCourtPalettes.asm" ; $4bfe, 64 bytes (palettes)
DKCourtTiles:
	INCBIN "data/bank_063/lz_DKCourtTiles.bin" ; $4c3e, 3291 bytes
DKCourtTilemap:
	INCBIN "data/bank_063/lz_DKCourtTilemap.bin" ; $5919, 713 bytes
DKCourtAttrmap:
	INCBIN "data/bank_063/lz_DKCourtAttrmap.bin" ; $5be2, 323 bytes
DKCourtSceneConfig:
	INCBIN "data/bank_063/DKCourtSceneConfig.bin" ; $5d25, 40 bytes
DKCourtScoreboardColumnAttrs:
	INCBIN "data/bank_063/DKCourtScoreboardColumnAttrs.bin" ; $5d4d, 40 bytes
StarPatternBgSceneConfig:
	INCBIN "data/bank_063/StarPatternBgSceneConfig.bin" ; $5d75, 42 bytes
StarPatternBgPalettes:
	INCLUDE "data/bank_063/StarPatternBgPalettes.asm" ; $5d9f, 64 bytes (palettes)
StarPatternBgTiles:
	INCBIN "data/bank_063/lz_StarPatternBgTiles.bin" ; $5ddf, 685 bytes
StarPatternBgTilemap:
	INCBIN "data/bank_063/lz_StarPatternBgTilemap.bin" ; $608c, 274 bytes
StarPatternBgAttrmap:
	INCBIN "data/bank_063/lz_StarPatternBgAttrmap.bin" ; $619e, 263 bytes
StarPatternBgCollisionMap:
	INCBIN "data/bank_063/lz_StarPatternBgCollisionMap.bin" ; $62a5, 70 bytes
StarPatternBgBehaviorMap:
	INCBIN "data/bank_063/lz_StarPatternBgBehaviorMap.bin" ; $62eb, 70 bytes
AcademyMainBldgSceneConfig:
	INCBIN "data/bank_063/AcademyMainBldgSceneConfig.bin" ; $6331, 42 bytes
AcademyMainBldgPalettes:
	INCLUDE "data/bank_063/AcademyMainBldgPalettes.asm" ; $635b, 64 bytes (palettes)
AcademyMainBldgTiles:
	INCBIN "data/bank_063/lz_AcademyMainBldgTiles.bin" ; $639b, 3510 bytes
AcademyMainBldgTilemap:
	INCBIN "data/bank_063/lz_AcademyMainBldgTilemap.bin" ; $7151, 1470 bytes
AcademyMainBldgAttrmap:
	INCBIN "data/bank_063/lz_AcademyMainBldgAttrmap.bin" ; $770f, 769 bytes
AcademyMainBldgCollisionMap:
	INCBIN "data/bank_063/lz_AcademyMainBldgCollisionMap.bin" ; $7a10, 147 bytes
AcademyMainBldgBehaviorMap:
	INCBIN "data/bank_063/lz_AcademyMainBldgBehaviorMap.bin" ; $7aa3, 94 bytes
AcademyMainBldgSceneUnusedSlot:
	; $7b01, 1279 bytes fill to bank end (linker-padded)
