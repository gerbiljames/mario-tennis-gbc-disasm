DataPtr_CompanyLogosTiles:
	dw CompanyLogosTiles ; $4000
DataPtr_CompanyLogosTilemap:
	dw CompanyLogosTilemap ; $4002
DataPtr_CompanyLogosAttrmap:
	dw CompanyLogosAttrmap ; $4004
DataPtr_CompanyLogosPalettes:
	dw CompanyLogosPalettes ; $4006
DataPtr_IntroRalliesTiles:
	dw IntroRalliesTiles ; $4008
DataPtr_IntroRalliesTilemap:
	dw IntroRalliesTilemap ; $400a
DataPtr_IntroRalliesAttrmap:
	dw IntroRalliesAttrmap ; $400c
DataPtr_IntroRalliesTilemap2:
	dw IntroRalliesTilemap2 ; $400e
DataPtr_IntroRalliesAttrmap2:
	dw IntroRalliesAttrmap2 ; $4010
DataPtr_IntroRalliesTilemap3:
	dw IntroRalliesTilemap3 ; $4012
DataPtr_IntroRalliesAttrmap3:
	dw IntroRalliesAttrmap3 ; $4014
DataPtr_IntroRalliesTilemap4:
	dw IntroRalliesTilemap4 ; $4016
DataPtr_IntroRalliesAttrmap4:
	dw IntroRalliesAttrmap4 ; $4018
DataPtr_IntroRalliesPalettes:
	dw IntroRalliesPalettes ; $401a
DataPtr_IntroRalliesAlexGfx0:
	dw IntroRalliesAlexGfx0 ; $401c
DataPtr_IntroRalliesAlexGfx1:
	dw IntroRalliesAlexGfx1 ; $401e
DataPtr_IntroRalliesAlexGfx2:
	dw IntroRalliesAlexGfx2 ; $4020
DataPtr_IntroRalliesNinaGfx0:
	dw IntroRalliesNinaGfx0 ; $4022
DataPtr_IntroRalliesNinaGfx1:
	dw IntroRalliesNinaGfx1 ; $4024
DataPtr_IntroRalliesNinaGfx2:
	dw IntroRalliesNinaGfx2 ; $4026
DataPtr_IntroRalliesNinaGfx3:
	dw IntroRalliesNinaGfx3 ; $4028
DataPtr_IntroAlexSwingTiles:
	dw IntroAlexSwingTiles ; $402a
DataPtr_IntroAlexSwingTilemap:
	dw IntroAlexSwingTilemap ; $402c
DataPtr_IntroAlexSwingAttrmap:
	dw IntroAlexSwingAttrmap ; $402e
DataPtr_IntroAlexSwingPalettes:
	dw IntroAlexSwingPalettes ; $4030
DataPtr_IntroNinaSwingTiles:
	dw IntroNinaSwingTiles ; $4032
DataPtr_IntroNinaSwingTilemap:
	dw IntroNinaSwingTilemap ; $4034
DataPtr_IntroNinaSwingAttrmap:
	dw IntroNinaSwingAttrmap ; $4036
DataPtr_IntroNinaSwingPalettes:
	dw IntroNinaSwingPalettes ; $4038
DataPtr_IntroWaveTiles:
	dw IntroWaveTiles ; $403a
DataPtr_IntroWaveTilemap:
	dw IntroWaveTilemap ; $403c
DataPtr_IntroWaveAttrmap:
	dw IntroWaveAttrmap ; $403e
DataPtr_IntroWavePalettes:
	dw IntroWavePalettes ; $4040
DataPtr_IntroDiveTiles:
	dw IntroDiveTiles ; $4042
DataPtr_IntroDiveTilemap:
	dw IntroDiveTilemap ; $4044
DataPtr_IntroDiveAttrmap:
	dw IntroDiveAttrmap ; $4046
DataPtr_IntroDivePalettes:
	dw IntroDivePalettes ; $4048
DataPtr_IntroGirlSwingTiles:
	dw IntroGirlSwingTiles ; $404a
DataPtr_IntroGirlSwingTilemap:
	dw IntroGirlSwingTilemap ; $404c
DataPtr_IntroGirlSwingAttrmap:
	dw IntroGirlSwingAttrmap ; $404e
DataPtr_IntroGirlSwingPalettes:
	dw IntroGirlSwingPalettes ; $4050
DataPtr_IntroSpinningBallFrame0:
	dw IntroSpinningBallFrame0 ; $4052
DataPtr_IntroSpinningBallFrame1:
	dw IntroSpinningBallFrame1 ; $4054
DataPtr_IntroSpinningBallFrame2:
	dw IntroSpinningBallFrame2 ; $4056
DataPtr_IntroSpinningBallFrame3:
	dw IntroSpinningBallFrame3 ; $4058
DataPtr_IntroGfx4:
	dw IntroGfx4 ; $405a
DataPtr_IntroGfx5:
	dw IntroGfx5 ; $405c
DataPtr_IntroGfx6:
	dw IntroGfx6 ; $405e
DataPtr_ChampionMedalTilemap5:
	dw ChampionMedalTilemap5 ; $4060
DataPtr_ChampionMedalAttrmap5:
	dw ChampionMedalAttrmap5 ; $4062
DataPtr_ChampionMedalTilemap6:
	dw ChampionMedalTilemap6 ; $4064
DataPtr_ChampionMedalAttrmap6:
	dw ChampionMedalAttrmap6 ; $4066
DataPtr_DreamMatchEpilogueTilemap6:
	dw DreamMatchEpilogueTilemap6 ; $4068
DataPtr_DreamMatchEpilogueAttrmap6:
	dw DreamMatchEpilogueAttrmap6 ; $406a
CompanyLogosTiles:
	INCBIN "data/gfx/lz_CompanyLogosTiles.bin" ; $406c, 1804 bytes
CompanyLogosTilemap:
	INCBIN "data/gfx/lz_CompanyLogosTilemap.bin" ; $4778, 311 bytes
CompanyLogosAttrmap:
	INCBIN "data/gfx/lz_CompanyLogosAttrmap.bin" ; $48af, 87 bytes
CompanyLogosPalettes:
	INCLUDE "data/gfx/CompanyLogosPalettes.asm" ; $4906, 64 bytes (palettes)
IntroRalliesTiles:
	INCBIN "data/gfx/lz_IntroRalliesTiles.bin" ; $4946, 1813 bytes
IntroRalliesTilemap:
	INCBIN "data/gfx/lz_IntroRalliesTilemap.bin" ; $505b, 92 bytes
IntroRalliesAttrmap:
	INCBIN "data/gfx/lz_IntroRalliesAttrmap.bin" ; $50b7, 72 bytes
IntroRalliesTilemap2:
	INCBIN "data/gfx/lz_IntroRalliesTilemap2.bin" ; $50ff, 92 bytes
IntroRalliesAttrmap2:
	INCBIN "data/gfx/lz_IntroRalliesAttrmap2.bin" ; $515b, 75 bytes
IntroRalliesTilemap3:
	INCBIN "data/gfx/lz_IntroRalliesTilemap3.bin" ; $51a6, 110 bytes
IntroRalliesAttrmap3:
	INCBIN "data/gfx/lz_IntroRalliesAttrmap3.bin" ; $5214, 73 bytes
IntroRalliesTilemap4:
	INCBIN "data/gfx/lz_IntroRalliesTilemap4.bin" ; $525d, 321 bytes
IntroRalliesAttrmap4:
	INCBIN "data/gfx/lz_IntroRalliesAttrmap4.bin" ; $539e, 70 bytes
IntroRalliesPalettes:
	INCLUDE "data/gfx/IntroRalliesPalettes.asm" ; $53e4, 64 bytes (palettes)
IntroRalliesAlexGfx0:
	INCBIN "data/gfx/lz_IntroRalliesAlexGfx0.bin" ; $5424, 45 bytes
IntroRalliesAlexGfx1:
	INCBIN "data/gfx/lz_IntroRalliesAlexGfx1.bin" ; $5451, 151 bytes
IntroRalliesAlexGfx2:
	INCBIN "data/gfx/lz_IntroRalliesAlexGfx2.bin" ; $54e8, 222 bytes
IntroRalliesNinaGfx0:
	INCBIN "data/gfx/lz_IntroRalliesNinaGfx0.bin" ; $55c6, 48 bytes
IntroRalliesNinaGfx1:
	INCBIN "data/gfx/lz_IntroRalliesNinaGfx1.bin" ; $55f6, 259 bytes
IntroRalliesNinaGfx2:
	INCBIN "data/gfx/lz_IntroRalliesNinaGfx2.bin" ; $56f9, 232 bytes
IntroRalliesNinaGfx3:
	INCBIN "data/gfx/lz_IntroRalliesNinaGfx3.bin" ; $57e1, 16 bytes
IntroAlexSwingTiles:
	INCBIN "data/gfx/lz_IntroAlexSwingTiles.bin" ; $57f1, 1085 bytes
IntroAlexSwingTilemap:
	INCBIN "data/gfx/lz_IntroAlexSwingTilemap.bin" ; $5c2e, 225 bytes
IntroAlexSwingAttrmap:
	INCBIN "data/gfx/lz_IntroAlexSwingAttrmap.bin" ; $5d0f, 70 bytes
IntroAlexSwingPalettes:
	INCLUDE "data/gfx/IntroAlexSwingPalettes.asm" ; $5d55, 64 bytes (palettes)
IntroNinaSwingTiles:
	INCBIN "data/gfx/lz_IntroNinaSwingTiles.bin" ; $5d95, 1061 bytes
IntroNinaSwingTilemap:
	INCBIN "data/gfx/lz_IntroNinaSwingTilemap.bin" ; $61ba, 170 bytes
IntroNinaSwingAttrmap:
	INCBIN "data/gfx/lz_IntroNinaSwingAttrmap.bin" ; $6264, 74 bytes
IntroNinaSwingPalettes:
	INCLUDE "data/gfx/IntroNinaSwingPalettes.asm" ; $62ae, 64 bytes (palettes)
IntroWaveTiles:
	INCBIN "data/gfx/lz_IntroWaveTiles.bin" ; $62ee, 1266 bytes
IntroWaveTilemap:
	INCBIN "data/gfx/lz_IntroWaveTilemap.bin" ; $67e0, 226 bytes
IntroWaveAttrmap:
	INCBIN "data/gfx/lz_IntroWaveAttrmap.bin" ; $68c2, 72 bytes
IntroWavePalettes:
	INCLUDE "data/gfx/IntroWavePalettes.asm" ; $690a, 64 bytes (palettes)
IntroDiveTiles:
	INCBIN "data/gfx/lz_IntroDiveTiles.bin" ; $694a, 1188 bytes
IntroDiveTilemap:
	INCBIN "data/gfx/lz_IntroDiveTilemap.bin" ; $6dee, 189 bytes
IntroDiveAttrmap:
	INCBIN "data/gfx/lz_IntroDiveAttrmap.bin" ; $6eab, 72 bytes
IntroDivePalettes:
	INCLUDE "data/gfx/IntroDivePalettes.asm" ; $6ef3, 64 bytes (palettes)
IntroGirlSwingTiles:
	INCBIN "data/gfx/lz_IntroGirlSwingTiles.bin" ; $6f33, 1131 bytes
IntroGirlSwingTilemap:
	INCBIN "data/gfx/lz_IntroGirlSwingTilemap.bin" ; $739e, 181 bytes
IntroGirlSwingAttrmap:
	INCBIN "data/gfx/lz_IntroGirlSwingAttrmap.bin" ; $7453, 72 bytes
IntroGirlSwingPalettes:
	INCLUDE "data/gfx/IntroGirlSwingPalettes.asm" ; $749b, 64 bytes (palettes)
IntroSpinningBallFrame0:
	INCBIN "data/gfx/lz_IntroSpinningBallFrame0.bin" ; $74db, 204 bytes
IntroSpinningBallFrame1:
	INCBIN "data/gfx/lz_IntroSpinningBallFrame1.bin" ; $75a7, 209 bytes
IntroSpinningBallFrame2:
	INCBIN "data/gfx/lz_IntroSpinningBallFrame2.bin" ; $7678, 204 bytes
IntroSpinningBallFrame3:
	INCBIN "data/gfx/lz_IntroSpinningBallFrame3.bin" ; $7744, 196 bytes
IntroGfx4:
	INCBIN "data/gfx/lz_IntroGfx4.bin" ; $7808, 46 bytes
IntroGfx5:
	INCBIN "data/gfx/lz_IntroGfx5.bin" ; $7836, 55 bytes
IntroGfx6:
	INCBIN "data/gfx/lz_IntroGfx6.bin" ; $786d, 39 bytes
ChampionMedalTilemap5:
	INCBIN "data/gfx/lz_ChampionMedalTilemap5.bin" ; $7894, 265 bytes
ChampionMedalAttrmap5:
	INCBIN "data/gfx/lz_ChampionMedalAttrmap5.bin" ; $799d, 121 bytes
ChampionMedalTilemap6:
	INCBIN "data/gfx/lz_ChampionMedalTilemap6.bin" ; $7a16, 265 bytes
ChampionMedalAttrmap6:
	INCBIN "data/gfx/lz_ChampionMedalAttrmap6.bin" ; $7b1f, 115 bytes
DreamMatchEpilogueTilemap6:
	INCBIN "data/gfx/lz_DreamMatchEpilogueTilemap6.bin" ; $7b92, 278 bytes
DreamMatchEpilogueAttrmap6:
	INCBIN "data/gfx/lz_DreamMatchEpilogueAttrmap6.bin" ; $7ca8, 118 bytes
	; $7d1e, 738 bytes fill to bank end (linker-padded)
