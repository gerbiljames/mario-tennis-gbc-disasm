DataPtr_WallPracticeCourtSceneConfig:
	dw WallPracticeCourtSceneConfig ; $4000
DataPtr_WallPracticeCourtPalettes:
	dw WallPracticeCourtPalettes ; $4002
DataPtr_WallPracticeCourtTilemap:
	dw WallPracticeCourtTilemap ; $4004
DataPtr_WallPracticeCourtAttrmap:
	dw WallPracticeCourtAttrmap ; $4006
DataPtr_WallPracticeCourtSceneConfigAlias1:
	dw WallPracticeCourtSceneConfig ; $4008
DataPtr_WallPracticeCourtScoreboardColumnAttrs:
	dw WallPracticeCourtScoreboardColumnAttrs ; $400a
DataPtr_JungleCourtPalettes:
	dw JungleCourtPalettes ; $400c
DataPtr_WallPracticeCourtTiles:
	dw WallPracticeCourtTiles ; $400e
DataPtr_JungleCourtSceneConfig:
	dw JungleCourtSceneConfig ; $4010
DataPtr_JungleCourtPalettesAlias1:
	dw JungleCourtPalettes ; $4012
DataPtr_JungleCourtTilemap:
	dw JungleCourtTilemap ; $4014
DataPtr_JungleCourtAttrmap:
	dw JungleCourtAttrmap ; $4016
DataPtr_JungleCourtSceneConfigAlias1:
	dw JungleCourtSceneConfig ; $4018
DataPtr_JungleCourtScoreboardColumnAttrs:
	dw JungleCourtScoreboardColumnAttrs ; $401a
DataPtr_StarPatternBgSceneConfig:
	dw StarPatternBgSceneConfig ; $401c
DataPtr_JungleCourtTiles:
	dw JungleCourtTiles ; $401e
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
WallPracticeCourtPalettes:
	INCLUDE "data/bank_063/WallPracticeCourtPalettes.asm" ; $4040, 64 bytes (palettes)
WallPracticeCourtTiles:
	INCBIN "data/bank_063/lz_WallPracticeCourtTiles.bin" ; $4080, 2042 bytes
WallPracticeCourtTilemap:
	INCBIN "data/bank_063/lz_WallPracticeCourtTilemap.bin" ; $487a, 635 bytes
WallPracticeCourtAttrmap:
	INCBIN "data/bank_063/lz_WallPracticeCourtAttrmap.bin" ; $4af5, 185 bytes
WallPracticeCourtSceneConfig:
	INCBIN "data/bank_063/WallPracticeCourtSceneConfig.bin" ; $4bae, 40 bytes
WallPracticeCourtScoreboardColumnAttrs:
	INCBIN "data/bank_063/WallPracticeCourtScoreboardColumnAttrs.bin" ; $4bd6, 40 bytes
JungleCourtPalettes:
	INCLUDE "data/bank_063/JungleCourtPalettes.asm" ; $4bfe, 64 bytes (palettes)
JungleCourtTiles:
	INCBIN "data/bank_063/lz_JungleCourtTiles.bin" ; $4c3e, 3291 bytes
JungleCourtTilemap:
	INCBIN "data/bank_063/lz_JungleCourtTilemap.bin" ; $5919, 713 bytes
JungleCourtAttrmap:
	INCBIN "data/bank_063/lz_JungleCourtAttrmap.bin" ; $5be2, 323 bytes
JungleCourtSceneConfig:
	INCBIN "data/bank_063/JungleCourtSceneConfig.bin" ; $5d25, 40 bytes
JungleCourtScoreboardColumnAttrs:
	INCBIN "data/bank_063/JungleCourtScoreboardColumnAttrs.bin" ; $5d4d, 40 bytes
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
