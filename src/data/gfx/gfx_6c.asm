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
DataPtr_CutsceneGfx0:
	dw CutsceneGfx0 ; $401c
DataPtr_CutsceneGfx1:
	dw CutsceneGfx1 ; $401e
DataPtr_CutsceneGfx2:
	dw CutsceneGfx2 ; $4020
DataPtr_CutsceneGfx3:
	dw CutsceneGfx3 ; $4022
DataPtr_CutsceneGfx4:
	dw CutsceneGfx4 ; $4024
DataPtr_CutsceneGfx5:
	dw CutsceneGfx5 ; $4026
DataPtr_CutsceneGfx6:
	dw CutsceneGfx6 ; $4028
DataPtr_IntroSwingTiles:
	dw IntroSwingTiles ; $402a
DataPtr_IntroSwingTilemap:
	dw IntroSwingTilemap ; $402c
DataPtr_IntroSwingAttrmap:
	dw IntroSwingAttrmap ; $402e
DataPtr_IntroSwingPalettes:
	dw IntroSwingPalettes ; $4030
DataPtr_IntroCloseupTiles:
	dw IntroCloseupTiles ; $4032
DataPtr_IntroCloseupTilemap:
	dw IntroCloseupTilemap ; $4034
DataPtr_IntroCloseupAttrmap:
	dw IntroCloseupAttrmap ; $4036
DataPtr_IntroCloseupPalettes:
	dw IntroCloseupPalettes ; $4038
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
DataPtr_IntroGfx0:
	dw IntroGfx0 ; $4052
DataPtr_IntroGfx1:
	dw IntroGfx1 ; $4054
DataPtr_IntroGfx2:
	dw IntroGfx2 ; $4056
DataPtr_IntroGfx3:
	dw IntroGfx3 ; $4058
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
DataPtr_AwardCeremonyTilemap6:
	dw AwardCeremonyTilemap6 ; $4068
DataPtr_AwardCeremonyAttrmap6:
	dw AwardCeremonyAttrmap6 ; $406a
CompanyLogosTiles:
	INCBIN "data/bank_06c/lz_CompanyLogosTiles.bin" ; $406c, 1804 bytes
CompanyLogosTilemap:
	INCBIN "data/bank_06c/lz_CompanyLogosTilemap.bin" ; $4778, 311 bytes
CompanyLogosAttrmap:
	INCBIN "data/bank_06c/lz_CompanyLogosAttrmap.bin" ; $48af, 87 bytes
CompanyLogosPalettes:
	INCLUDE "data/bank_06c/CompanyLogosPalettes.asm" ; $4906, 64 bytes (palettes)
IntroRalliesTiles:
	INCBIN "data/bank_06c/lz_IntroRalliesTiles.bin" ; $4946, 1813 bytes
IntroRalliesTilemap:
	INCBIN "data/bank_06c/lz_IntroRalliesTilemap.bin" ; $505b, 92 bytes
IntroRalliesAttrmap:
	INCBIN "data/bank_06c/lz_IntroRalliesAttrmap.bin" ; $50b7, 72 bytes
IntroRalliesTilemap2:
	INCBIN "data/bank_06c/lz_IntroRalliesTilemap2.bin" ; $50ff, 92 bytes
IntroRalliesAttrmap2:
	INCBIN "data/bank_06c/lz_IntroRalliesAttrmap2.bin" ; $515b, 75 bytes
IntroRalliesTilemap3:
	INCBIN "data/bank_06c/lz_IntroRalliesTilemap3.bin" ; $51a6, 110 bytes
IntroRalliesAttrmap3:
	INCBIN "data/bank_06c/lz_IntroRalliesAttrmap3.bin" ; $5214, 73 bytes
IntroRalliesTilemap4:
	INCBIN "data/bank_06c/lz_IntroRalliesTilemap4.bin" ; $525d, 321 bytes
IntroRalliesAttrmap4:
	INCBIN "data/bank_06c/lz_IntroRalliesAttrmap4.bin" ; $539e, 70 bytes
IntroRalliesPalettes:
	INCLUDE "data/bank_06c/IntroRalliesPalettes.asm" ; $53e4, 64 bytes (palettes)
CutsceneGfx0:
	INCBIN "data/bank_06c/lz_CutsceneGfx0.bin" ; $5424, 45 bytes
CutsceneGfx1:
	INCBIN "data/bank_06c/lz_CutsceneGfx1.bin" ; $5451, 151 bytes
CutsceneGfx2:
	INCBIN "data/bank_06c/lz_CutsceneGfx2.bin" ; $54e8, 222 bytes
CutsceneGfx3:
	INCBIN "data/bank_06c/lz_CutsceneGfx3.bin" ; $55c6, 48 bytes
CutsceneGfx4:
	INCBIN "data/bank_06c/lz_CutsceneGfx4.bin" ; $55f6, 259 bytes
CutsceneGfx5:
	INCBIN "data/bank_06c/lz_CutsceneGfx5.bin" ; $56f9, 232 bytes
CutsceneGfx6:
	INCBIN "data/bank_06c/lz_CutsceneGfx6.bin" ; $57e1, 16 bytes
IntroSwingTiles:
	INCBIN "data/bank_06c/lz_IntroSwingTiles.bin" ; $57f1, 1085 bytes
IntroSwingTilemap:
	INCBIN "data/bank_06c/lz_IntroSwingTilemap.bin" ; $5c2e, 225 bytes
IntroSwingAttrmap:
	INCBIN "data/bank_06c/lz_IntroSwingAttrmap.bin" ; $5d0f, 70 bytes
IntroSwingPalettes:
	INCLUDE "data/bank_06c/IntroSwingPalettes.asm" ; $5d55, 64 bytes (palettes)
IntroCloseupTiles:
	INCBIN "data/bank_06c/lz_IntroCloseupTiles.bin" ; $5d95, 1061 bytes
IntroCloseupTilemap:
	INCBIN "data/bank_06c/lz_IntroCloseupTilemap.bin" ; $61ba, 170 bytes
IntroCloseupAttrmap:
	INCBIN "data/bank_06c/lz_IntroCloseupAttrmap.bin" ; $6264, 74 bytes
IntroCloseupPalettes:
	INCLUDE "data/bank_06c/IntroCloseupPalettes.asm" ; $62ae, 64 bytes (palettes)
IntroWaveTiles:
	INCBIN "data/bank_06c/lz_IntroWaveTiles.bin" ; $62ee, 1266 bytes
IntroWaveTilemap:
	INCBIN "data/bank_06c/lz_IntroWaveTilemap.bin" ; $67e0, 226 bytes
IntroWaveAttrmap:
	INCBIN "data/bank_06c/lz_IntroWaveAttrmap.bin" ; $68c2, 72 bytes
IntroWavePalettes:
	INCLUDE "data/bank_06c/IntroWavePalettes.asm" ; $690a, 64 bytes (palettes)
IntroDiveTiles:
	INCBIN "data/bank_06c/lz_IntroDiveTiles.bin" ; $694a, 1188 bytes
IntroDiveTilemap:
	INCBIN "data/bank_06c/lz_IntroDiveTilemap.bin" ; $6dee, 189 bytes
IntroDiveAttrmap:
	INCBIN "data/bank_06c/lz_IntroDiveAttrmap.bin" ; $6eab, 72 bytes
IntroDivePalettes:
	INCLUDE "data/bank_06c/IntroDivePalettes.asm" ; $6ef3, 64 bytes (palettes)
IntroGirlSwingTiles:
	INCBIN "data/bank_06c/lz_IntroGirlSwingTiles.bin" ; $6f33, 1131 bytes
IntroGirlSwingTilemap:
	INCBIN "data/bank_06c/lz_IntroGirlSwingTilemap.bin" ; $739e, 181 bytes
IntroGirlSwingAttrmap:
	INCBIN "data/bank_06c/lz_IntroGirlSwingAttrmap.bin" ; $7453, 72 bytes
IntroGirlSwingPalettes:
	INCLUDE "data/bank_06c/IntroGirlSwingPalettes.asm" ; $749b, 64 bytes (palettes)
IntroGfx0:
	INCBIN "data/bank_06c/lz_IntroGfx0.bin" ; $74db, 204 bytes
IntroGfx1:
	INCBIN "data/bank_06c/lz_IntroGfx1.bin" ; $75a7, 209 bytes
IntroGfx2:
	INCBIN "data/bank_06c/lz_IntroGfx2.bin" ; $7678, 204 bytes
IntroGfx3:
	INCBIN "data/bank_06c/lz_IntroGfx3.bin" ; $7744, 196 bytes
IntroGfx4:
	INCBIN "data/bank_06c/lz_IntroGfx4.bin" ; $7808, 46 bytes
IntroGfx5:
	INCBIN "data/bank_06c/lz_IntroGfx5.bin" ; $7836, 55 bytes
IntroGfx6:
	INCBIN "data/bank_06c/lz_IntroGfx6.bin" ; $786d, 39 bytes
ChampionMedalTilemap5:
	INCBIN "data/bank_06c/lz_ChampionMedalTilemap5.bin" ; $7894, 265 bytes
ChampionMedalAttrmap5:
	INCBIN "data/bank_06c/lz_ChampionMedalAttrmap5.bin" ; $799d, 121 bytes
ChampionMedalTilemap6:
	INCBIN "data/bank_06c/lz_ChampionMedalTilemap6.bin" ; $7a16, 265 bytes
ChampionMedalAttrmap6:
	INCBIN "data/bank_06c/lz_ChampionMedalAttrmap6.bin" ; $7b1f, 115 bytes
AwardCeremonyTilemap6:
	INCBIN "data/bank_06c/lz_AwardCeremonyTilemap6.bin" ; $7b92, 278 bytes
AwardCeremonyAttrmap6:
	INCBIN "data/bank_06c/lz_AwardCeremonyAttrmap6.bin" ; $7ca8, 118 bytes
	; $7d1e, 738 bytes fill to bank end (linker-padded)
