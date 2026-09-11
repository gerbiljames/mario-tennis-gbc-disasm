DataPtr_VictoryCutsceneTiles:
	dw VictoryCutsceneTiles ; $4000
DataPtr_VictoryCutscenePalettes:
	dw VictoryCutscenePalettes ; $4002
DataPtr_VictoryCutsceneTilemap:
	dw VictoryCutsceneTilemap ; $4004
DataPtr_VictoryCutsceneAttrmap:
	dw VictoryCutsceneAttrmap ; $4006
DataPtr_VictoryCutsceneTilemap2:
	dw VictoryCutsceneTilemap2 ; $4008
DataPtr_VictoryCutsceneAttrmap2:
	dw VictoryCutsceneAttrmap2 ; $400a
DataPtr_VictoryCutsceneTilemap3:
	dw VictoryCutsceneTilemap3 ; $400c
DataPtr_VictoryCutsceneAttrmap3:
	dw VictoryCutsceneAttrmap3 ; $400e
DataPtr_VictoryCutsceneTilemap4:
	dw VictoryCutsceneTilemap4 ; $4010
DataPtr_VictoryCutsceneAttrmap4:
	dw VictoryCutsceneAttrmap4 ; $4012
DataPtr_VictoryCutsceneTilemap5:
	dw VictoryCutsceneTilemap5 ; $4014
DataPtr_VictoryCutsceneAttrmap5:
	dw VictoryCutsceneAttrmap5 ; $4016
DataPtr_VictoryCutsceneTilemap6:
	dw VictoryCutsceneTilemap6 ; $4018
DataPtr_VictoryCutsceneAttrmap6:
	dw VictoryCutsceneAttrmap6 ; $401a
DataPtr_ShopCutsceneTiles:
	dw ShopCutsceneTiles ; $401c
DataPtr_ShopCutscenePalettes:
	dw ShopCutscenePalettes ; $401e
DataPtr_ShopCutsceneTilemap:
	dw ShopCutsceneTilemap ; $4020
DataPtr_ShopCutsceneAttrmap:
	dw ShopCutsceneAttrmap ; $4022
DataPtr_ShopCutsceneTilemap2:
	dw ShopCutsceneTilemap2 ; $4024
DataPtr_ShopCutsceneAttrmap2:
	dw ShopCutsceneAttrmap2 ; $4026
DataPtr_ShopCutsceneTilemap3:
	dw ShopCutsceneTilemap3 ; $4028
DataPtr_ShopCutsceneAttrmap3:
	dw ShopCutsceneAttrmap3 ; $402a
DataPtr_ShopCutsceneTilemap4:
	dw ShopCutsceneTilemap4 ; $402c
DataPtr_ShopCutsceneAttrmap4:
	dw ShopCutsceneAttrmap4 ; $402e
DataPtr_ShopCutsceneTilemap5:
	dw ShopCutsceneTilemap5 ; $4030
DataPtr_ShopCutsceneAttrmap5:
	dw ShopCutsceneAttrmap5 ; $4032
DataPtr_ShopCutsceneTilemap6:
	dw ShopCutsceneTilemap6 ; $4034
DataPtr_ShopCutsceneAttrmap6:
	dw ShopCutsceneAttrmap6 ; $4036
DataPtr_ChampionMedalTiles:
	dw ChampionMedalTiles ; $4038
DataPtr_ChampionMedalPalettes:
	dw ChampionMedalPalettes ; $403a
DataPtr_ChampionMedalTilemap:
	dw ChampionMedalTilemap ; $403c
DataPtr_ChampionMedalAttrmap:
	dw ChampionMedalAttrmap ; $403e
DataPtr_ChampionMedalTilemap2:
	dw ChampionMedalTilemap2 ; $4040
DataPtr_ChampionMedalAttrmap2:
	dw ChampionMedalAttrmap2 ; $4042
DataPtr_ChampionMedalTilemap3:
	dw ChampionMedalTilemap3 ; $4044
DataPtr_ChampionMedalAttrmap3:
	dw ChampionMedalAttrmap3 ; $4046
DataPtr_ChampionMedalTilemap4:
	dw ChampionMedalTilemap4 ; $4048
DataPtr_ChampionMedalAttrmap4:
	dw ChampionMedalAttrmap4 ; $404a
VictoryCutsceneTiles:
	INCBIN "data/bank_019/lz_VictoryCutsceneTiles.bin" ; $404c, 3118 bytes
VictoryCutscenePalettes:
	INCLUDE "data/bank_019/VictoryCutscenePalettes.asm" ; $4c7a, 64 bytes (palettes)
VictoryCutsceneTilemap:
	INCBIN "data/bank_019/lz_VictoryCutsceneTilemap.bin" ; $4cba, 265 bytes
VictoryCutsceneAttrmap:
	INCBIN "data/bank_019/lz_VictoryCutsceneAttrmap.bin" ; $4dc3, 99 bytes
VictoryCutsceneTilemap2:
	INCBIN "data/bank_019/lz_VictoryCutsceneTilemap2.bin" ; $4e26, 258 bytes
VictoryCutsceneAttrmap2:
	INCBIN "data/bank_019/lz_VictoryCutsceneAttrmap2.bin" ; $4f28, 123 bytes
VictoryCutsceneTilemap3:
	INCBIN "data/bank_019/lz_VictoryCutsceneTilemap3.bin" ; $4fa3, 271 bytes
VictoryCutsceneAttrmap3:
	INCBIN "data/bank_019/lz_VictoryCutsceneAttrmap3.bin" ; $50b2, 84 bytes
VictoryCutsceneTilemap4:
	INCBIN "data/bank_019/lz_VictoryCutsceneTilemap4.bin" ; $5106, 259 bytes
VictoryCutsceneAttrmap4:
	INCBIN "data/bank_019/lz_VictoryCutsceneAttrmap4.bin" ; $5209, 106 bytes
VictoryCutsceneTilemap5:
	INCBIN "data/bank_019/lz_VictoryCutsceneTilemap5.bin" ; $5273, 209 bytes
VictoryCutsceneAttrmap5:
	INCBIN "data/bank_019/lz_VictoryCutsceneAttrmap5.bin" ; $5344, 140 bytes
VictoryCutsceneTilemap6:
	INCBIN "data/bank_019/lz_VictoryCutsceneTilemap6.bin" ; $53d0, 221 bytes
VictoryCutsceneAttrmap6:
	INCBIN "data/bank_019/lz_VictoryCutsceneAttrmap6.bin" ; $54ad, 114 bytes
ShopCutsceneTiles:
	INCBIN "data/bank_019/lz_ShopCutsceneTiles.bin" ; $551f, 3077 bytes
ShopCutscenePalettes:
	INCLUDE "data/bank_019/ShopCutscenePalettes.asm" ; $6124, 64 bytes (palettes)
ShopCutsceneTilemap:
	INCBIN "data/bank_019/lz_ShopCutsceneTilemap.bin" ; $6164, 257 bytes
ShopCutsceneAttrmap:
	INCBIN "data/bank_019/lz_ShopCutsceneAttrmap.bin" ; $6265, 129 bytes
ShopCutsceneTilemap2:
	INCBIN "data/bank_019/lz_ShopCutsceneTilemap2.bin" ; $62e6, 250 bytes
ShopCutsceneAttrmap2:
	INCBIN "data/bank_019/lz_ShopCutsceneAttrmap2.bin" ; $63e0, 110 bytes
ShopCutsceneTilemap3:
	INCBIN "data/bank_019/lz_ShopCutsceneTilemap3.bin" ; $644e, 271 bytes
ShopCutsceneAttrmap3:
	INCBIN "data/bank_019/lz_ShopCutsceneAttrmap3.bin" ; $655d, 132 bytes
ShopCutsceneTilemap4:
	INCBIN "data/bank_019/lz_ShopCutsceneTilemap4.bin" ; $65e1, 264 bytes
ShopCutsceneAttrmap4:
	INCBIN "data/bank_019/lz_ShopCutsceneAttrmap4.bin" ; $66e9, 132 bytes
ShopCutsceneTilemap5:
	INCBIN "data/bank_019/lz_ShopCutsceneTilemap5.bin" ; $676d, 215 bytes
ShopCutsceneAttrmap5:
	INCBIN "data/bank_019/lz_ShopCutsceneAttrmap5.bin" ; $6844, 109 bytes
ShopCutsceneTilemap6:
	INCBIN "data/bank_019/lz_ShopCutsceneTilemap6.bin" ; $68b1, 226 bytes
ShopCutsceneAttrmap6:
	INCBIN "data/bank_019/lz_ShopCutsceneAttrmap6.bin" ; $6993, 125 bytes
ChampionMedalTiles:
	INCBIN "data/bank_019/lz_ChampionMedalTiles.bin" ; $6a10, 3355 bytes
ChampionMedalPalettes:
	INCLUDE "data/bank_019/ChampionMedalPalettes.asm" ; $772b, 64 bytes (palettes)
ChampionMedalTilemap:
	INCBIN "data/bank_019/lz_ChampionMedalTilemap.bin" ; $776b, 275 bytes
ChampionMedalAttrmap:
	INCBIN "data/bank_019/lz_ChampionMedalAttrmap.bin" ; $787e, 128 bytes
ChampionMedalTilemap2:
	INCBIN "data/bank_019/lz_ChampionMedalTilemap2.bin" ; $78fe, 275 bytes
ChampionMedalAttrmap2:
	INCBIN "data/bank_019/lz_ChampionMedalAttrmap2.bin" ; $7a11, 125 bytes
ChampionMedalTilemap3:
	INCBIN "data/bank_019/lz_ChampionMedalTilemap3.bin" ; $7a8e, 275 bytes
ChampionMedalAttrmap3:
	INCBIN "data/bank_019/lz_ChampionMedalAttrmap3.bin" ; $7ba1, 147 bytes
ChampionMedalTilemap4:
	INCBIN "data/bank_019/lz_ChampionMedalTilemap4.bin" ; $7c34, 275 bytes
ChampionMedalAttrmap4:
	INCBIN "data/bank_019/lz_ChampionMedalAttrmap4.bin" ; $7d47, 144 bytes
	; $7dd7, 553 bytes fill to bank end (linker-padded)
