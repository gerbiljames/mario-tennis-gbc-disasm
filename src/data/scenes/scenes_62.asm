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
DataPtr_WarehouseCourtPalettes:
	dw WarehouseCourtPalettes ; $401c
DataPtr_BowserCourtTiles:
	dw BowserCourtTiles ; $401e
DataPtr_WarehouseCourtSceneConfig:
	dw WarehouseCourtSceneConfig ; $4020
DataPtr_WarehouseCourtPalettesAlias1:
	dw WarehouseCourtPalettes ; $4022
DataPtr_WarehouseCourtTilemap:
	dw WarehouseCourtTilemap ; $4024
DataPtr_WarehouseCourtAttrmap:
	dw WarehouseCourtAttrmap ; $4026
DataPtr_WarehouseCourtSceneConfigAlias1:
	dw WarehouseCourtSceneConfig ; $4028
DataPtr_WarehouseCourtScoreboardColumnAttrs:
	dw WarehouseCourtScoreboardColumnAttrs ; $402a
DataPtr_CastleCourtPalettes:
	dw CastleCourtPalettes ; $402c
DataPtr_WarehouseCourtTiles:
	dw WarehouseCourtTiles ; $402e
DataPtr_CastleCourtSceneConfig:
	dw CastleCourtSceneConfig ; $4030
DataPtr_CastleCourtPalettesAlias1:
	dw CastleCourtPalettes ; $4032
DataPtr_CastleCourtTilemap:
	dw CastleCourtTilemap ; $4034
DataPtr_CastleCourtAttrmap:
	dw CastleCourtAttrmap ; $4036
DataPtr_CastleCourtSceneConfigAlias1:
	dw CastleCourtSceneConfig ; $4038
DataPtr_CastleCourtScoreboardColumnAttrs:
	dw CastleCourtScoreboardColumnAttrs ; $403a
DataPtr_CastleCourtSceneUnusedSlot:
	dw CastleCourtSceneUnusedSlot ; $403c
DataPtr_CastleCourtTiles:
	dw CastleCourtTiles ; $403e
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
WarehouseCourtPalettes:
	INCLUDE "data/bank_062/WarehouseCourtPalettes.asm" ; $5650, 64 bytes (palettes)
WarehouseCourtTiles:
	INCBIN "data/bank_062/lz_WarehouseCourtTiles.bin" ; $5690, 2412 bytes
WarehouseCourtTilemap:
	INCBIN "data/bank_062/lz_WarehouseCourtTilemap.bin" ; $5ffc, 723 bytes
WarehouseCourtAttrmap:
	INCBIN "data/bank_062/lz_WarehouseCourtAttrmap.bin" ; $62cf, 274 bytes
WarehouseCourtSceneConfig:
	INCBIN "data/bank_062/WarehouseCourtSceneConfig.bin" ; $63e1, 40 bytes
WarehouseCourtScoreboardColumnAttrs:
	INCBIN "data/bank_062/WarehouseCourtScoreboardColumnAttrs.bin" ; $6409, 40 bytes
CastleCourtPalettes:
	INCLUDE "data/bank_062/CastleCourtPalettes.asm" ; $6431, 64 bytes (palettes)
CastleCourtTiles:
	INCBIN "data/bank_062/lz_CastleCourtTiles.bin" ; $6471, 1874 bytes
CastleCourtTilemap:
	INCBIN "data/bank_062/lz_CastleCourtTilemap.bin" ; $6bc3, 562 bytes
CastleCourtAttrmap:
	INCBIN "data/bank_062/lz_CastleCourtAttrmap.bin" ; $6df5, 313 bytes
CastleCourtSceneConfig:
	INCBIN "data/bank_062/CastleCourtSceneConfig.bin" ; $6f2e, 40 bytes
CastleCourtScoreboardColumnAttrs:
	INCBIN "data/bank_062/CastleCourtScoreboardColumnAttrs.bin" ; $6f56, 40 bytes
CastleCourtSceneUnusedSlot:
	; $6f7e, 4226 bytes fill to bank end (linker-padded)
