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
DataPtr_AwardsCeremonyCutsceneTiles:
	dw AwardsCeremonyCutsceneTiles ; $401c
DataPtr_AwardsCeremonyCutscenePalettes:
	dw AwardsCeremonyCutscenePalettes ; $401e
DataPtr_AwardsCeremonyCutsceneTilemap:
	dw AwardsCeremonyCutsceneTilemap ; $4020
DataPtr_AwardsCeremonyCutsceneAttrmap:
	dw AwardsCeremonyCutsceneAttrmap ; $4022
DataPtr_AwardsCeremonyCutsceneTilemap2:
	dw AwardsCeremonyCutsceneTilemap2 ; $4024
DataPtr_AwardsCeremonyCutsceneAttrmap2:
	dw AwardsCeremonyCutsceneAttrmap2 ; $4026
DataPtr_AwardsCeremonyCutsceneTilemap3:
	dw AwardsCeremonyCutsceneTilemap3 ; $4028
DataPtr_AwardsCeremonyCutsceneAttrmap3:
	dw AwardsCeremonyCutsceneAttrmap3 ; $402a
DataPtr_AwardsCeremonyCutsceneTilemap4:
	dw AwardsCeremonyCutsceneTilemap4 ; $402c
DataPtr_AwardsCeremonyCutsceneAttrmap4:
	dw AwardsCeremonyCutsceneAttrmap4 ; $402e
DataPtr_AwardsCeremonyCutsceneTilemap5:
	dw AwardsCeremonyCutsceneTilemap5 ; $4030
DataPtr_AwardsCeremonyCutsceneAttrmap5:
	dw AwardsCeremonyCutsceneAttrmap5 ; $4032
DataPtr_AwardsCeremonyCutsceneTilemap6:
	dw AwardsCeremonyCutsceneTilemap6 ; $4034
DataPtr_AwardsCeremonyCutsceneAttrmap6:
	dw AwardsCeremonyCutsceneAttrmap6 ; $4036
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
	INCBIN "data/gfx/lz_VictoryCutsceneTiles.bin" ; $404c, 3118 bytes
VictoryCutscenePalettes:
	INCLUDE "data/gfx/VictoryCutscenePalettes.asm" ; $4c7a, 64 bytes (palettes)
VictoryCutsceneTilemap:
	INCBIN "data/gfx/lz_VictoryCutsceneTilemap.bin" ; $4cba, 265 bytes
VictoryCutsceneAttrmap:
	INCBIN "data/gfx/lz_VictoryCutsceneAttrmap.bin" ; $4dc3, 99 bytes
VictoryCutsceneTilemap2:
	INCBIN "data/gfx/lz_VictoryCutsceneTilemap2.bin" ; $4e26, 258 bytes
VictoryCutsceneAttrmap2:
	INCBIN "data/gfx/lz_VictoryCutsceneAttrmap2.bin" ; $4f28, 123 bytes
VictoryCutsceneTilemap3:
	INCBIN "data/gfx/lz_VictoryCutsceneTilemap3.bin" ; $4fa3, 271 bytes
VictoryCutsceneAttrmap3:
	INCBIN "data/gfx/lz_VictoryCutsceneAttrmap3.bin" ; $50b2, 84 bytes
VictoryCutsceneTilemap4:
	INCBIN "data/gfx/lz_VictoryCutsceneTilemap4.bin" ; $5106, 259 bytes
VictoryCutsceneAttrmap4:
	INCBIN "data/gfx/lz_VictoryCutsceneAttrmap4.bin" ; $5209, 106 bytes
VictoryCutsceneTilemap5:
	INCBIN "data/gfx/lz_VictoryCutsceneTilemap5.bin" ; $5273, 209 bytes
VictoryCutsceneAttrmap5:
	INCBIN "data/gfx/lz_VictoryCutsceneAttrmap5.bin" ; $5344, 140 bytes
VictoryCutsceneTilemap6:
	INCBIN "data/gfx/lz_VictoryCutsceneTilemap6.bin" ; $53d0, 221 bytes
VictoryCutsceneAttrmap6:
	INCBIN "data/gfx/lz_VictoryCutsceneAttrmap6.bin" ; $54ad, 114 bytes
AwardsCeremonyCutsceneTiles:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneTiles.bin" ; $551f, 3077 bytes
AwardsCeremonyCutscenePalettes:
	INCLUDE "data/gfx/AwardsCeremonyCutscenePalettes.asm" ; $6124, 64 bytes (palettes)
AwardsCeremonyCutsceneTilemap:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneTilemap.bin" ; $6164, 257 bytes
AwardsCeremonyCutsceneAttrmap:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneAttrmap.bin" ; $6265, 129 bytes
AwardsCeremonyCutsceneTilemap2:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneTilemap2.bin" ; $62e6, 250 bytes
AwardsCeremonyCutsceneAttrmap2:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneAttrmap2.bin" ; $63e0, 110 bytes
AwardsCeremonyCutsceneTilemap3:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneTilemap3.bin" ; $644e, 271 bytes
AwardsCeremonyCutsceneAttrmap3:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneAttrmap3.bin" ; $655d, 132 bytes
AwardsCeremonyCutsceneTilemap4:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneTilemap4.bin" ; $65e1, 264 bytes
AwardsCeremonyCutsceneAttrmap4:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneAttrmap4.bin" ; $66e9, 132 bytes
AwardsCeremonyCutsceneTilemap5:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneTilemap5.bin" ; $676d, 215 bytes
AwardsCeremonyCutsceneAttrmap5:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneAttrmap5.bin" ; $6844, 109 bytes
AwardsCeremonyCutsceneTilemap6:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneTilemap6.bin" ; $68b1, 226 bytes
AwardsCeremonyCutsceneAttrmap6:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneAttrmap6.bin" ; $6993, 125 bytes
ChampionMedalTiles:
	INCBIN "data/gfx/lz_ChampionMedalTiles.bin" ; $6a10, 3355 bytes
ChampionMedalPalettes:
	INCLUDE "data/gfx/ChampionMedalPalettes.asm" ; $772b, 64 bytes (palettes)
ChampionMedalTilemap:
	INCBIN "data/gfx/lz_ChampionMedalTilemap.bin" ; $776b, 275 bytes
ChampionMedalAttrmap:
	INCBIN "data/gfx/lz_ChampionMedalAttrmap.bin" ; $787e, 128 bytes
ChampionMedalTilemap2:
	INCBIN "data/gfx/lz_ChampionMedalTilemap2.bin" ; $78fe, 275 bytes
ChampionMedalAttrmap2:
	INCBIN "data/gfx/lz_ChampionMedalAttrmap2.bin" ; $7a11, 125 bytes
ChampionMedalTilemap3:
	INCBIN "data/gfx/lz_ChampionMedalTilemap3.bin" ; $7a8e, 275 bytes
ChampionMedalAttrmap3:
	INCBIN "data/gfx/lz_ChampionMedalAttrmap3.bin" ; $7ba1, 147 bytes
ChampionMedalTilemap4:
	INCBIN "data/gfx/lz_ChampionMedalTilemap4.bin" ; $7c34, 275 bytes
ChampionMedalAttrmap4:
	INCBIN "data/gfx/lz_ChampionMedalAttrmap4.bin" ; $7d47, 144 bytes
	; $7dd7, 553 bytes fill to bank end (linker-padded)
