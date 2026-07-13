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
DataPtr_IslandOpenCourtSceneConfigB:
	dw IslandOpenCourtSceneConfigB ; $400a
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
DataPtr_DKCourtSceneConfigB:
	dw DKCourtSceneConfigB ; $401a
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
DataPtr_StarPatternBgAuxTilemap:
	dw StarPatternBgAuxTilemap ; $4028
DataPtr_StarPatternBgAuxAttrmap:
	dw StarPatternBgAuxAttrmap ; $402a
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
DataPtr_DormInteriorAuxTilemap:
	dw DormInteriorAuxTilemap ; $4038
DataPtr_DormInteriorAuxAttrmap:
	dw DormInteriorAuxAttrmap ; $403a
DataPtr_63_3c:
	dw Data_63_7b01 ; $403c
DataPtr_DormInteriorTiles:
	dw DormInteriorTiles ; $403e
IslandOpenCourtPalettes:
	INCBIN "data/bank_063/d_4040.bin" ; $4040, 64 bytes
IslandOpenCourtTiles:
	INCBIN "data/bank_063/lz_4080.bin" ; $4080, 2042 bytes
IslandOpenCourtTilemap:
	INCBIN "data/bank_063/lz_487a.bin" ; $487a, 635 bytes
IslandOpenCourtAttrmap:
	INCBIN "data/bank_063/lz_4af5.bin" ; $4af5, 185 bytes
IslandOpenCourtSceneConfig:
	INCBIN "data/bank_063/d_4bae.bin" ; $4bae, 40 bytes
IslandOpenCourtSceneConfigB:
	INCBIN "data/bank_063/d_4bd6.bin" ; $4bd6, 40 bytes
DKCourtPalettes:
	INCBIN "data/bank_063/d_4bfe.bin" ; $4bfe, 64 bytes
DKCourtTiles:
	INCBIN "data/bank_063/lz_4c3e.bin" ; $4c3e, 3291 bytes
DKCourtTilemap:
	INCBIN "data/bank_063/lz_5919.bin" ; $5919, 713 bytes
DKCourtAttrmap:
	INCBIN "data/bank_063/lz_5be2.bin" ; $5be2, 323 bytes
DKCourtSceneConfig:
	INCBIN "data/bank_063/d_5d25.bin" ; $5d25, 40 bytes
DKCourtSceneConfigB:
	INCBIN "data/bank_063/d_5d4d.bin" ; $5d4d, 40 bytes
StarPatternBgSceneConfig:
	INCBIN "data/bank_063/d_5d75.bin" ; $5d75, 42 bytes
StarPatternBgPalettes:
	INCBIN "data/bank_063/d_5d9f.bin" ; $5d9f, 64 bytes
StarPatternBgTiles:
	INCBIN "data/bank_063/lz_5ddf.bin" ; $5ddf, 685 bytes
StarPatternBgTilemap:
	INCBIN "data/bank_063/lz_608c.bin" ; $608c, 274 bytes
StarPatternBgAttrmap:
	INCBIN "data/bank_063/lz_619e.bin" ; $619e, 263 bytes
StarPatternBgAuxTilemap:
	INCBIN "data/bank_063/lz_62a5.bin" ; $62a5, 70 bytes
StarPatternBgAuxAttrmap:
	INCBIN "data/bank_063/lz_62eb.bin" ; $62eb, 70 bytes
DormInteriorSceneConfig:
	INCBIN "data/bank_063/d_6331.bin" ; $6331, 42 bytes
DormInteriorPalettes:
	INCBIN "data/bank_063/d_635b.bin" ; $635b, 64 bytes
DormInteriorTiles:
	INCBIN "data/bank_063/d_639b.bin" ; $639b, 3510 bytes
DormInteriorTilemap:
	INCBIN "data/bank_063/d_7151.bin" ; $7151, 1470 bytes
DormInteriorAttrmap:
	INCBIN "data/bank_063/d_770f.bin" ; $770f, 769 bytes
DormInteriorAuxTilemap:
	INCBIN "data/bank_063/d_7a10.bin" ; $7a10, 147 bytes
DormInteriorAuxAttrmap:
	INCBIN "data/bank_063/d_7aa3.bin" ; $7aa3, 94 bytes
Data_63_7b01:
	INCBIN "data/bank_063/d_7b01.bin" ; $7b01, 1279 bytes
