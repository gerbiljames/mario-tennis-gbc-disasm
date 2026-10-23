DataPtr_VictoryCutsceneTiles:
	dw VictoryCutsceneTiles ; $4000
DataPtr_VictoryCutscenePalettes:
	dw VictoryCutscenePalettes ; $4002
DataPtr_VictoryCutsceneDoublesBoysTilemap:
	dw VictoryCutsceneDoublesBoysTilemap ; $4004
DataPtr_VictoryCutsceneDoublesBoysAttrmap:
	dw VictoryCutsceneDoublesBoysAttrmap ; $4006
DataPtr_VictoryCutsceneDoublesBoyGirlTilemap:
	dw VictoryCutsceneDoublesBoyGirlTilemap ; $4008
DataPtr_VictoryCutsceneDoublesBoyGirlAttrmap:
	dw VictoryCutsceneDoublesBoyGirlAttrmap ; $400a
DataPtr_VictoryCutsceneDoublesGirlBoyTilemap:
	dw VictoryCutsceneDoublesGirlBoyTilemap ; $400c
DataPtr_VictoryCutsceneDoublesGirlBoyAttrmap:
	dw VictoryCutsceneDoublesGirlBoyAttrmap ; $400e
DataPtr_VictoryCutsceneDoublesGirlsTilemap:
	dw VictoryCutsceneDoublesGirlsTilemap ; $4010
DataPtr_VictoryCutsceneDoublesGirlsAttrmap:
	dw VictoryCutsceneDoublesGirlsAttrmap ; $4012
DataPtr_VictoryCutsceneSinglesBoyTilemap:
	dw VictoryCutsceneSinglesBoyTilemap ; $4014
DataPtr_VictoryCutsceneSinglesBoyAttrmap:
	dw VictoryCutsceneSinglesBoyAttrmap ; $4016
DataPtr_VictoryCutsceneSinglesGirlTilemap:
	dw VictoryCutsceneSinglesGirlTilemap ; $4018
DataPtr_VictoryCutsceneSinglesGirlAttrmap:
	dw VictoryCutsceneSinglesGirlAttrmap ; $401a
DataPtr_AwardsCeremonyCutsceneTiles:
	dw AwardsCeremonyCutsceneTiles ; $401c
DataPtr_AwardsCeremonyCutscenePalettes:
	dw AwardsCeremonyCutscenePalettes ; $401e
DataPtr_AwardsCeremonyCutsceneDoublesBoysTilemap:
	dw AwardsCeremonyCutsceneDoublesBoysTilemap ; $4020
DataPtr_AwardsCeremonyCutsceneDoublesBoysAttrmap:
	dw AwardsCeremonyCutsceneDoublesBoysAttrmap ; $4022
DataPtr_AwardsCeremonyCutsceneDoublesBoyGirlTilemap:
	dw AwardsCeremonyCutsceneDoublesBoyGirlTilemap ; $4024
DataPtr_AwardsCeremonyCutsceneDoublesBoyGirlAttrmap:
	dw AwardsCeremonyCutsceneDoublesBoyGirlAttrmap ; $4026
DataPtr_AwardsCeremonyCutsceneDoublesGirlBoyTilemap:
	dw AwardsCeremonyCutsceneDoublesGirlBoyTilemap ; $4028
DataPtr_AwardsCeremonyCutsceneDoublesGirlBoyAttrmap:
	dw AwardsCeremonyCutsceneDoublesGirlBoyAttrmap ; $402a
DataPtr_AwardsCeremonyCutsceneDoublesGirlsTilemap:
	dw AwardsCeremonyCutsceneDoublesGirlsTilemap ; $402c
DataPtr_AwardsCeremonyCutsceneDoublesGirlsAttrmap:
	dw AwardsCeremonyCutsceneDoublesGirlsAttrmap ; $402e
DataPtr_AwardsCeremonyCutsceneSinglesBoyTilemap:
	dw AwardsCeremonyCutsceneSinglesBoyTilemap ; $4030
DataPtr_AwardsCeremonyCutsceneSinglesBoyAttrmap:
	dw AwardsCeremonyCutsceneSinglesBoyAttrmap ; $4032
DataPtr_AwardsCeremonyCutsceneSinglesGirlTilemap:
	dw AwardsCeremonyCutsceneSinglesGirlTilemap ; $4034
DataPtr_AwardsCeremonyCutsceneSinglesGirlAttrmap:
	dw AwardsCeremonyCutsceneSinglesGirlAttrmap ; $4036
DataPtr_ChampionMedalTiles:
	dw ChampionMedalTiles ; $4038
DataPtr_ChampionMedalPalettes:
	dw ChampionMedalPalettes ; $403a
DataPtr_ChampionMedalDoublesBoysTilemap:
	dw ChampionMedalDoublesBoysTilemap ; $403c
DataPtr_ChampionMedalDoublesBoysAttrmap:
	dw ChampionMedalDoublesBoysAttrmap ; $403e
DataPtr_ChampionMedalDoublesBoyGirlTilemap:
	dw ChampionMedalDoublesBoyGirlTilemap ; $4040
DataPtr_ChampionMedalDoublesBoyGirlAttrmap:
	dw ChampionMedalDoublesBoyGirlAttrmap ; $4042
DataPtr_ChampionMedalDoublesGirlBoyTilemap:
	dw ChampionMedalDoublesGirlBoyTilemap ; $4044
DataPtr_ChampionMedalDoublesGirlBoyAttrmap:
	dw ChampionMedalDoublesGirlBoyAttrmap ; $4046
DataPtr_ChampionMedalDoublesGirlsTilemap:
	dw ChampionMedalDoublesGirlsTilemap ; $4048
DataPtr_ChampionMedalDoublesGirlsAttrmap:
	dw ChampionMedalDoublesGirlsAttrmap ; $404a
VictoryCutsceneTiles:
	INCBIN "data/gfx/lz_VictoryCutsceneTiles.bin" ; $404c, 3118 bytes
VictoryCutscenePalettes:
	INCLUDE "data/gfx/VictoryCutscenePalettes.asm" ; $4c7a, 64 bytes (palettes)
VictoryCutsceneDoublesBoysTilemap:
	INCBIN "data/gfx/lz_VictoryCutsceneDoublesBoysTilemap.bin" ; $4cba, 265 bytes
VictoryCutsceneDoublesBoysAttrmap:
	INCBIN "data/gfx/lz_VictoryCutsceneDoublesBoysAttrmap.bin" ; $4dc3, 99 bytes
VictoryCutsceneDoublesBoyGirlTilemap:
	INCBIN "data/gfx/lz_VictoryCutsceneDoublesBoyGirlTilemap.bin" ; $4e26, 258 bytes
VictoryCutsceneDoublesBoyGirlAttrmap:
	INCBIN "data/gfx/lz_VictoryCutsceneDoublesBoyGirlAttrmap.bin" ; $4f28, 123 bytes
VictoryCutsceneDoublesGirlBoyTilemap:
	INCBIN "data/gfx/lz_VictoryCutsceneDoublesGirlBoyTilemap.bin" ; $4fa3, 271 bytes
VictoryCutsceneDoublesGirlBoyAttrmap:
	INCBIN "data/gfx/lz_VictoryCutsceneDoublesGirlBoyAttrmap.bin" ; $50b2, 84 bytes
VictoryCutsceneDoublesGirlsTilemap:
	INCBIN "data/gfx/lz_VictoryCutsceneDoublesGirlsTilemap.bin" ; $5106, 259 bytes
VictoryCutsceneDoublesGirlsAttrmap:
	INCBIN "data/gfx/lz_VictoryCutsceneDoublesGirlsAttrmap.bin" ; $5209, 106 bytes
VictoryCutsceneSinglesBoyTilemap:
	INCBIN "data/gfx/lz_VictoryCutsceneSinglesBoyTilemap.bin" ; $5273, 209 bytes
VictoryCutsceneSinglesBoyAttrmap:
	INCBIN "data/gfx/lz_VictoryCutsceneSinglesBoyAttrmap.bin" ; $5344, 140 bytes
VictoryCutsceneSinglesGirlTilemap:
	INCBIN "data/gfx/lz_VictoryCutsceneSinglesGirlTilemap.bin" ; $53d0, 221 bytes
VictoryCutsceneSinglesGirlAttrmap:
	INCBIN "data/gfx/lz_VictoryCutsceneSinglesGirlAttrmap.bin" ; $54ad, 114 bytes
AwardsCeremonyCutsceneTiles:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneTiles.bin" ; $551f, 3077 bytes
AwardsCeremonyCutscenePalettes:
	INCLUDE "data/gfx/AwardsCeremonyCutscenePalettes.asm" ; $6124, 64 bytes (palettes)
AwardsCeremonyCutsceneDoublesBoysTilemap:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneDoublesBoysTilemap.bin" ; $6164, 257 bytes
AwardsCeremonyCutsceneDoublesBoysAttrmap:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneDoublesBoysAttrmap.bin" ; $6265, 129 bytes
AwardsCeremonyCutsceneDoublesBoyGirlTilemap:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneDoublesBoyGirlTilemap.bin" ; $62e6, 250 bytes
AwardsCeremonyCutsceneDoublesBoyGirlAttrmap:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneDoublesBoyGirlAttrmap.bin" ; $63e0, 110 bytes
AwardsCeremonyCutsceneDoublesGirlBoyTilemap:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneDoublesGirlBoyTilemap.bin" ; $644e, 271 bytes
AwardsCeremonyCutsceneDoublesGirlBoyAttrmap:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneDoublesGirlBoyAttrmap.bin" ; $655d, 132 bytes
AwardsCeremonyCutsceneDoublesGirlsTilemap:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneDoublesGirlsTilemap.bin" ; $65e1, 264 bytes
AwardsCeremonyCutsceneDoublesGirlsAttrmap:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneDoublesGirlsAttrmap.bin" ; $66e9, 132 bytes
AwardsCeremonyCutsceneSinglesBoyTilemap:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneSinglesBoyTilemap.bin" ; $676d, 215 bytes
AwardsCeremonyCutsceneSinglesBoyAttrmap:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneSinglesBoyAttrmap.bin" ; $6844, 109 bytes
AwardsCeremonyCutsceneSinglesGirlTilemap:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneSinglesGirlTilemap.bin" ; $68b1, 226 bytes
AwardsCeremonyCutsceneSinglesGirlAttrmap:
	INCBIN "data/gfx/lz_AwardsCeremonyCutsceneSinglesGirlAttrmap.bin" ; $6993, 125 bytes
ChampionMedalTiles:
	INCBIN "data/gfx/lz_ChampionMedalTiles.bin" ; $6a10, 3355 bytes
ChampionMedalPalettes:
	INCLUDE "data/gfx/ChampionMedalPalettes.asm" ; $772b, 64 bytes (palettes)
ChampionMedalDoublesBoysTilemap:
	INCBIN "data/gfx/lz_ChampionMedalDoublesBoysTilemap.bin" ; $776b, 275 bytes
ChampionMedalDoublesBoysAttrmap:
	INCBIN "data/gfx/lz_ChampionMedalDoublesBoysAttrmap.bin" ; $787e, 128 bytes
ChampionMedalDoublesBoyGirlTilemap:
	INCBIN "data/gfx/lz_ChampionMedalDoublesBoyGirlTilemap.bin" ; $78fe, 275 bytes
ChampionMedalDoublesBoyGirlAttrmap:
	INCBIN "data/gfx/lz_ChampionMedalDoublesBoyGirlAttrmap.bin" ; $7a11, 125 bytes
ChampionMedalDoublesGirlBoyTilemap:
	INCBIN "data/gfx/lz_ChampionMedalDoublesGirlBoyTilemap.bin" ; $7a8e, 275 bytes
ChampionMedalDoublesGirlBoyAttrmap:
	INCBIN "data/gfx/lz_ChampionMedalDoublesGirlBoyAttrmap.bin" ; $7ba1, 147 bytes
ChampionMedalDoublesGirlsTilemap:
	INCBIN "data/gfx/lz_ChampionMedalDoublesGirlsTilemap.bin" ; $7c34, 275 bytes
ChampionMedalDoublesGirlsAttrmap:
	INCBIN "data/gfx/lz_ChampionMedalDoublesGirlsAttrmap.bin" ; $7d47, 144 bytes
	; $7dd7, 553 bytes fill to bank end (linker-padded)
