DataPtr_StarCourtScoreboardColumnTiles:
	dw StarCourtScoreboardColumnTiles ; $4000
DataPtr_StarCourtPalettes:
	dw StarCourtPalettes ; $4002
DataPtr_StarCourtTilemap:
	dw StarCourtTilemap ; $4004
DataPtr_StarCourtAttrmap:
	dw StarCourtAttrmap ; $4006
DataPtr_StarCourtScoreboardColumnTilesAlias1:
	dw StarCourtScoreboardColumnTiles ; $4008
DataPtr_StarCourtScoreboardColumnAttrs:
	dw StarCourtScoreboardColumnAttrs ; $400a
DataPtr_BowserCourtPalettes:
	dw BowserCourtPalettes ; $400c
DataPtr_StarCourtTiles:
	dw StarCourtTiles ; $400e
DataPtr_BowserCourtScoreboardColumnTiles:
	dw BowserCourtScoreboardColumnTiles ; $4010
DataPtr_BowserCourtPalettesAlias1:
	dw BowserCourtPalettes ; $4012
DataPtr_BowserCourtTilemap:
	dw BowserCourtTilemap ; $4014
DataPtr_BowserCourtAttrmap:
	dw BowserCourtAttrmap ; $4016
DataPtr_BowserCourtScoreboardColumnTilesAlias1:
	dw BowserCourtScoreboardColumnTiles ; $4018
DataPtr_BowserCourtScoreboardColumnAttrs:
	dw BowserCourtScoreboardColumnAttrs ; $401a
DataPtr_WarehouseCourtPalettes:
	dw WarehouseCourtPalettes ; $401c
DataPtr_BowserCourtTiles:
	dw BowserCourtTiles ; $401e
DataPtr_WarehouseCourtScoreboardColumnTiles:
	dw WarehouseCourtScoreboardColumnTiles ; $4020
DataPtr_WarehouseCourtPalettesAlias1:
	dw WarehouseCourtPalettes ; $4022
DataPtr_WarehouseCourtTilemap:
	dw WarehouseCourtTilemap ; $4024
DataPtr_WarehouseCourtAttrmap:
	dw WarehouseCourtAttrmap ; $4026
DataPtr_WarehouseCourtScoreboardColumnTilesAlias1:
	dw WarehouseCourtScoreboardColumnTiles ; $4028
DataPtr_WarehouseCourtScoreboardColumnAttrs:
	dw WarehouseCourtScoreboardColumnAttrs ; $402a
DataPtr_CastleCourtPalettes:
	dw CastleCourtPalettes ; $402c
DataPtr_WarehouseCourtTiles:
	dw WarehouseCourtTiles ; $402e
DataPtr_CastleCourtScoreboardColumnTiles:
	dw CastleCourtScoreboardColumnTiles ; $4030
DataPtr_CastleCourtPalettesAlias1:
	dw CastleCourtPalettes ; $4032
DataPtr_CastleCourtTilemap:
	dw CastleCourtTilemap ; $4034
DataPtr_CastleCourtAttrmap:
	dw CastleCourtAttrmap ; $4036
DataPtr_CastleCourtScoreboardColumnTilesAlias1:
	dw CastleCourtScoreboardColumnTiles ; $4038
DataPtr_CastleCourtScoreboardColumnAttrs:
	dw CastleCourtScoreboardColumnAttrs ; $403a
DataPtr_CastleCourtSceneUnusedSlot:
	dw CastleCourtSceneUnusedSlot ; $403c
DataPtr_CastleCourtTiles:
	dw CastleCourtTiles ; $403e
StarCourtPalettes:
	INCLUDE "data/scenes/StarCourtPalettes.asm" ; $4040, 64 bytes (palettes)
StarCourtTiles:
	INCBIN "data/scenes/lz_StarCourtTiles.bin" ; $4080, 1990 bytes
StarCourtTilemap:
	INCBIN "data/scenes/lz_StarCourtTilemap.bin" ; $4846, 508 bytes
StarCourtAttrmap:
	INCBIN "data/scenes/lz_StarCourtAttrmap.bin" ; $4a42, 209 bytes
StarCourtScoreboardColumnTiles:
	INCLUDE "data/scenes/StarCourtScoreboardColumnTiles.asm" ; $4b13, 40 bytes (scoreboard_columns)
StarCourtScoreboardColumnAttrs:
	INCLUDE "data/scenes/StarCourtScoreboardColumnAttrs.asm" ; $4b3b, 40 bytes (scoreboard_columns)
BowserCourtPalettes:
	INCLUDE "data/scenes/BowserCourtPalettes.asm" ; $4b63, 64 bytes (palettes)
BowserCourtTiles:
	INCBIN "data/scenes/lz_BowserCourtTiles.bin" ; $4ba3, 1770 bytes
BowserCourtTilemap:
	INCBIN "data/scenes/lz_BowserCourtTilemap.bin" ; $528d, 598 bytes
BowserCourtAttrmap:
	INCBIN "data/scenes/lz_BowserCourtAttrmap.bin" ; $54e3, 285 bytes
BowserCourtScoreboardColumnTiles:
	INCLUDE "data/scenes/BowserCourtScoreboardColumnTiles.asm" ; $5600, 40 bytes (scoreboard_columns)
BowserCourtScoreboardColumnAttrs:
	INCLUDE "data/scenes/BowserCourtScoreboardColumnAttrs.asm" ; $5628, 40 bytes (scoreboard_columns)
WarehouseCourtPalettes:
	INCLUDE "data/scenes/WarehouseCourtPalettes.asm" ; $5650, 64 bytes (palettes)
WarehouseCourtTiles:
	INCBIN "data/scenes/lz_WarehouseCourtTiles.bin" ; $5690, 2412 bytes
WarehouseCourtTilemap:
	INCBIN "data/scenes/lz_WarehouseCourtTilemap.bin" ; $5ffc, 723 bytes
WarehouseCourtAttrmap:
	INCBIN "data/scenes/lz_WarehouseCourtAttrmap.bin" ; $62cf, 274 bytes
WarehouseCourtScoreboardColumnTiles:
	INCLUDE "data/scenes/WarehouseCourtScoreboardColumnTiles.asm" ; $63e1, 40 bytes (scoreboard_columns)
WarehouseCourtScoreboardColumnAttrs:
	INCLUDE "data/scenes/WarehouseCourtScoreboardColumnAttrs.asm" ; $6409, 40 bytes (scoreboard_columns)
CastleCourtPalettes:
	INCLUDE "data/scenes/CastleCourtPalettes.asm" ; $6431, 64 bytes (palettes)
CastleCourtTiles:
	INCBIN "data/scenes/lz_CastleCourtTiles.bin" ; $6471, 1874 bytes
CastleCourtTilemap:
	INCBIN "data/scenes/lz_CastleCourtTilemap.bin" ; $6bc3, 562 bytes
CastleCourtAttrmap:
	INCBIN "data/scenes/lz_CastleCourtAttrmap.bin" ; $6df5, 313 bytes
CastleCourtScoreboardColumnTiles:
	INCLUDE "data/scenes/CastleCourtScoreboardColumnTiles.asm" ; $6f2e, 40 bytes (scoreboard_columns)
CastleCourtScoreboardColumnAttrs:
	INCLUDE "data/scenes/CastleCourtScoreboardColumnAttrs.asm" ; $6f56, 40 bytes (scoreboard_columns)
CastleCourtSceneUnusedSlot:
	; $6f7e, 4226 bytes fill to bank end (linker-padded)
