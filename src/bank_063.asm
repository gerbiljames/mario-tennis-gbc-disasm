SECTION "ROM Bank $63", ROMX[$4000], BANK[$63]

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
DataPtr_DormInteriorSceneConfig:
	dw DormInteriorSceneConfig ; $402c
DataPtr_StarPatternBgTiles:
	dw StarPatternBgTiles ; $402e
DataPtr_DormInteriorSceneConfigAlias1:
	dw DormInteriorSceneConfig ; $4030
DataPtr_DormInteriorPalettes:
	dw DormInteriorPalettes ; $4032
DataPtr_DormInteriorTilemap:
	dw DormInteriorTilemap ; $4034
DataPtr_DormInteriorAttrmap:
	dw DormInteriorAttrmap ; $4036
DataPtr_DormInteriorCollisionMap:
	dw DormInteriorCollisionMap ; $4038
DataPtr_DormInteriorBehaviorMap:
	dw DormInteriorBehaviorMap ; $403a
DataPtr_DormInteriorSceneUnusedSlot:
	dw DormInteriorSceneUnusedSlot ; $403c
DataPtr_DormInteriorTiles:
	dw DormInteriorTiles ; $403e
IslandOpenCourtPalettes:
	INCLUDE "data/bank_063/palettes_4040.asm" ; $4040, 64 bytes (palettes)
IslandOpenCourtTiles:
	INCBIN "data/bank_063/lz_4080.bin" ; $4080, 2042 bytes
IslandOpenCourtTilemap:
	INCBIN "data/bank_063/lz_487a.bin" ; $487a, 635 bytes
IslandOpenCourtAttrmap:
	INCBIN "data/bank_063/lz_4af5.bin" ; $4af5, 185 bytes
IslandOpenCourtSceneConfig:
	INCBIN "data/bank_063/d_4bae.bin" ; $4bae, 40 bytes
IslandOpenCourtScoreboardColumnAttrs:
	INCBIN "data/bank_063/d_4bd6.bin" ; $4bd6, 40 bytes
DKCourtPalettes:
	INCLUDE "data/bank_063/palettes_4bfe.asm" ; $4bfe, 64 bytes (palettes)
DKCourtTiles:
	INCBIN "data/bank_063/lz_4c3e.bin" ; $4c3e, 3291 bytes
DKCourtTilemap:
	INCBIN "data/bank_063/lz_5919.bin" ; $5919, 713 bytes
DKCourtAttrmap:
	INCBIN "data/bank_063/lz_5be2.bin" ; $5be2, 323 bytes
DKCourtSceneConfig:
	INCBIN "data/bank_063/d_5d25.bin" ; $5d25, 40 bytes
DKCourtScoreboardColumnAttrs:
	INCBIN "data/bank_063/d_5d4d.bin" ; $5d4d, 40 bytes
StarPatternBgSceneConfig:
	INCBIN "data/bank_063/d_5d75.bin" ; $5d75, 42 bytes
StarPatternBgPalettes:
	INCLUDE "data/bank_063/palettes_5d9f.asm" ; $5d9f, 64 bytes (palettes)
StarPatternBgTiles:
	INCBIN "data/bank_063/lz_5ddf.bin" ; $5ddf, 685 bytes
StarPatternBgTilemap:
	INCBIN "data/bank_063/lz_608c.bin" ; $608c, 274 bytes
StarPatternBgAttrmap:
	INCBIN "data/bank_063/lz_619e.bin" ; $619e, 263 bytes
StarPatternBgCollisionMap:
	INCBIN "data/bank_063/lz_62a5.bin" ; $62a5, 70 bytes
StarPatternBgBehaviorMap:
	INCBIN "data/bank_063/lz_62eb.bin" ; $62eb, 70 bytes
DormInteriorSceneConfig:
	INCBIN "data/bank_063/d_6331.bin" ; $6331, 42 bytes
DormInteriorPalettes:
	INCLUDE "data/bank_063/palettes_635b.asm" ; $635b, 64 bytes (palettes)
DormInteriorTiles:
	INCBIN "data/bank_063/d_639b.bin" ; $639b, 3510 bytes
DormInteriorTilemap:
	INCBIN "data/bank_063/lz_7151.bin" ; $7151, 1470 bytes
DormInteriorAttrmap:
	INCBIN "data/bank_063/lz_770f.bin" ; $770f, 769 bytes
DormInteriorCollisionMap:
	INCBIN "data/bank_063/lz_7a10.bin" ; $7a10, 147 bytes
DormInteriorBehaviorMap:
	INCBIN "data/bank_063/lz_7aa3.bin" ; $7aa3, 94 bytes
DormInteriorSceneUnusedSlot:
	; $7b01, 1279 bytes fill to bank end (linker-padded)
