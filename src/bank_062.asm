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
DataPtr_StarCourtSceneConfigB:
	dw StarCourtSceneConfigB ; $400a
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
DataPtr_BowserCourtSceneConfigB:
	dw BowserCourtSceneConfigB ; $401a
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
DataPtr_WarioCourtSceneConfigB:
	dw WarioCourtSceneConfigB ; $402a
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
DataPtr_PeachCourtSceneConfigB:
	dw PeachCourtSceneConfigB ; $403a
DataPtr_PeachCourtSceneUnusedSlot:
	dw PeachCourtSceneUnusedSlot ; $403c
DataPtr_PeachCourtTiles:
	dw PeachCourtTiles ; $403e
StarCourtPalettes:
	INCLUDE "data/bank_062/palettes_4040.asm" ; $4040, 64 bytes (palettes)
StarCourtTiles:
	INCBIN "data/bank_062/lz_4080.bin" ; $4080, 1990 bytes
StarCourtTilemap:
	INCBIN "data/bank_062/lz_4846.bin" ; $4846, 508 bytes
StarCourtAttrmap:
	INCBIN "data/bank_062/lz_4a42.bin" ; $4a42, 209 bytes
StarCourtSceneConfig:
	INCBIN "data/bank_062/d_4b13.bin" ; $4b13, 40 bytes
StarCourtSceneConfigB:
	INCBIN "data/bank_062/d_4b3b.bin" ; $4b3b, 40 bytes
BowserCourtPalettes:
	INCLUDE "data/bank_062/palettes_4b63.asm" ; $4b63, 64 bytes (palettes)
BowserCourtTiles:
	INCBIN "data/bank_062/lz_4ba3.bin" ; $4ba3, 1770 bytes
BowserCourtTilemap:
	INCBIN "data/bank_062/lz_528d.bin" ; $528d, 598 bytes
BowserCourtAttrmap:
	INCBIN "data/bank_062/lz_54e3.bin" ; $54e3, 285 bytes
BowserCourtSceneConfig:
	INCBIN "data/bank_062/d_5600.bin" ; $5600, 40 bytes
BowserCourtSceneConfigB:
	INCBIN "data/bank_062/d_5628.bin" ; $5628, 40 bytes
WarioCourtPalettes:
	INCLUDE "data/bank_062/palettes_5650.asm" ; $5650, 64 bytes (palettes)
WarioCourtTiles:
	INCBIN "data/bank_062/lz_5690.bin" ; $5690, 2412 bytes
WarioCourtTilemap:
	INCBIN "data/bank_062/lz_5ffc.bin" ; $5ffc, 723 bytes
WarioCourtAttrmap:
	INCBIN "data/bank_062/lz_62cf.bin" ; $62cf, 274 bytes
WarioCourtSceneConfig:
	INCBIN "data/bank_062/d_63e1.bin" ; $63e1, 40 bytes
WarioCourtSceneConfigB:
	INCBIN "data/bank_062/d_6409.bin" ; $6409, 40 bytes
PeachCourtPalettes:
	INCLUDE "data/bank_062/palettes_6431.asm" ; $6431, 64 bytes (palettes)
PeachCourtTiles:
	INCBIN "data/bank_062/lz_6471.bin" ; $6471, 1874 bytes
PeachCourtTilemap:
	INCBIN "data/bank_062/lz_6bc3.bin" ; $6bc3, 562 bytes
PeachCourtAttrmap:
	INCBIN "data/bank_062/lz_6df5.bin" ; $6df5, 313 bytes
PeachCourtSceneConfig:
	INCBIN "data/bank_062/d_6f2e.bin" ; $6f2e, 40 bytes
PeachCourtSceneConfigB:
	INCBIN "data/bank_062/d_6f56.bin" ; $6f56, 40 bytes
PeachCourtSceneUnusedSlot:
	; $6f7e, 4226 bytes fill to bank end (linker-padded)
