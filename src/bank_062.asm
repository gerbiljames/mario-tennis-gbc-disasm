SECTION "ROM Bank $62", ROMX[$4000], BANK[$62]

DataPtr_StarCourtSceneConfig:
	dw StarCourtSceneConfig ; $4000
DataPtr_StarCourtPalettes:
	dw StarCourtPalettes ; $4002
DataPtr_StarCourtTilemap:
	dw StarCourtTilemap ; $4004
DataPtr_StarCourtAttrmap:
	dw StarCourtAttrmap ; $4006
DataPtr_StarCourtSceneConfigAlias1:
	dw StarCourtSceneConfig ; $4008
DataPtr_StarCourtScoreboardColumnAttrs:
	dw StarCourtScoreboardColumnAttrs ; $400a
DataPtr_BowserCourtPalettes:
	dw BowserCourtPalettes ; $400c
DataPtr_StarCourtTiles:
	dw StarCourtTiles ; $400e
DataPtr_BowserCourtSceneConfig:
	dw BowserCourtSceneConfig ; $4010
DataPtr_BowserCourtPalettesAlias1:
	dw BowserCourtPalettes ; $4012
DataPtr_BowserCourtTilemap:
	dw BowserCourtTilemap ; $4014
DataPtr_BowserCourtAttrmap:
	dw BowserCourtAttrmap ; $4016
DataPtr_BowserCourtSceneConfigAlias1:
	dw BowserCourtSceneConfig ; $4018
DataPtr_BowserCourtScoreboardColumnAttrs:
	dw BowserCourtScoreboardColumnAttrs ; $401a
DataPtr_WarioCourtPalettes:
	dw WarioCourtPalettes ; $401c
DataPtr_BowserCourtTiles:
	dw BowserCourtTiles ; $401e
DataPtr_WarioCourtSceneConfig:
	dw WarioCourtSceneConfig ; $4020
DataPtr_WarioCourtPalettesAlias1:
	dw WarioCourtPalettes ; $4022
DataPtr_WarioCourtTilemap:
	dw WarioCourtTilemap ; $4024
DataPtr_WarioCourtAttrmap:
	dw WarioCourtAttrmap ; $4026
DataPtr_WarioCourtSceneConfigAlias1:
	dw WarioCourtSceneConfig ; $4028
DataPtr_WarioCourtScoreboardColumnAttrs:
	dw WarioCourtScoreboardColumnAttrs ; $402a
DataPtr_PeachCourtPalettes:
	dw PeachCourtPalettes ; $402c
DataPtr_WarioCourtTiles:
	dw WarioCourtTiles ; $402e
DataPtr_PeachCourtSceneConfig:
	dw PeachCourtSceneConfig ; $4030
DataPtr_PeachCourtPalettesAlias1:
	dw PeachCourtPalettes ; $4032
DataPtr_PeachCourtTilemap:
	dw PeachCourtTilemap ; $4034
DataPtr_PeachCourtAttrmap:
	dw PeachCourtAttrmap ; $4036
DataPtr_PeachCourtSceneConfigAlias1:
	dw PeachCourtSceneConfig ; $4038
DataPtr_PeachCourtScoreboardColumnAttrs:
	dw PeachCourtScoreboardColumnAttrs ; $403a
DataPtr_PeachCourtSceneUnusedSlot:
	dw PeachCourtSceneUnusedSlot ; $403c
DataPtr_PeachCourtTiles:
	dw PeachCourtTiles ; $403e
StarCourtPalettes:
	INCLUDE "data/bank_062/StarCourtPalettes.asm" ; $4040, 64 bytes (palettes)
StarCourtTiles:
	INCBIN "data/bank_062/lz_StarCourtTiles.bin" ; $4080, 1990 bytes
StarCourtTilemap:
	INCBIN "data/bank_062/lz_StarCourtTilemap.bin" ; $4846, 508 bytes
StarCourtAttrmap:
	INCBIN "data/bank_062/lz_StarCourtAttrmap.bin" ; $4a42, 209 bytes
StarCourtSceneConfig:
	INCBIN "data/bank_062/StarCourtSceneConfig.bin" ; $4b13, 40 bytes
StarCourtScoreboardColumnAttrs:
	INCBIN "data/bank_062/StarCourtScoreboardColumnAttrs.bin" ; $4b3b, 40 bytes
BowserCourtPalettes:
	INCLUDE "data/bank_062/BowserCourtPalettes.asm" ; $4b63, 64 bytes (palettes)
BowserCourtTiles:
	INCBIN "data/bank_062/lz_BowserCourtTiles.bin" ; $4ba3, 1770 bytes
BowserCourtTilemap:
	INCBIN "data/bank_062/lz_BowserCourtTilemap.bin" ; $528d, 598 bytes
BowserCourtAttrmap:
	INCBIN "data/bank_062/lz_BowserCourtAttrmap.bin" ; $54e3, 285 bytes
BowserCourtSceneConfig:
	INCBIN "data/bank_062/BowserCourtSceneConfig.bin" ; $5600, 40 bytes
BowserCourtScoreboardColumnAttrs:
	INCBIN "data/bank_062/BowserCourtScoreboardColumnAttrs.bin" ; $5628, 40 bytes
WarioCourtPalettes:
	INCLUDE "data/bank_062/WarioCourtPalettes.asm" ; $5650, 64 bytes (palettes)
WarioCourtTiles:
	INCBIN "data/bank_062/lz_WarioCourtTiles.bin" ; $5690, 2412 bytes
WarioCourtTilemap:
	INCBIN "data/bank_062/lz_WarioCourtTilemap.bin" ; $5ffc, 723 bytes
WarioCourtAttrmap:
	INCBIN "data/bank_062/lz_WarioCourtAttrmap.bin" ; $62cf, 274 bytes
WarioCourtSceneConfig:
	INCBIN "data/bank_062/WarioCourtSceneConfig.bin" ; $63e1, 40 bytes
WarioCourtScoreboardColumnAttrs:
	INCBIN "data/bank_062/WarioCourtScoreboardColumnAttrs.bin" ; $6409, 40 bytes
PeachCourtPalettes:
	INCLUDE "data/bank_062/PeachCourtPalettes.asm" ; $6431, 64 bytes (palettes)
PeachCourtTiles:
	INCBIN "data/bank_062/lz_PeachCourtTiles.bin" ; $6471, 1874 bytes
PeachCourtTilemap:
	INCBIN "data/bank_062/lz_PeachCourtTilemap.bin" ; $6bc3, 562 bytes
PeachCourtAttrmap:
	INCBIN "data/bank_062/lz_PeachCourtAttrmap.bin" ; $6df5, 313 bytes
PeachCourtSceneConfig:
	INCBIN "data/bank_062/PeachCourtSceneConfig.bin" ; $6f2e, 40 bytes
PeachCourtScoreboardColumnAttrs:
	INCBIN "data/bank_062/PeachCourtScoreboardColumnAttrs.bin" ; $6f56, 40 bytes
PeachCourtSceneUnusedSlot:
	; $6f7e, 4226 bytes fill to bank end (linker-padded)
