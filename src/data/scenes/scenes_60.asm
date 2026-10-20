DataPtr_GrassCourtScoreboardColumnTiles:
	dw GrassCourtScoreboardColumnTiles ; $4000
DataPtr_GrassCourtPalettes:
	dw GrassCourtPalettes ; $4002
DataPtr_GrassCourtTilemap:
	dw GrassCourtTilemap ; $4004
DataPtr_GrassCourtAttrmap:
	dw GrassCourtAttrmap ; $4006
DataPtr_GrassCourtScoreboardColumnTilesAlias1:
	dw GrassCourtScoreboardColumnTiles ; $4008
DataPtr_GrassCourtScoreboardColumnAttrs:
	dw GrassCourtScoreboardColumnAttrs ; $400a
DataPtr_TrainingCourtPalettes:
	dw TrainingCourtPalettes ; $400c
DataPtr_GrassCourtTiles:
	dw GrassCourtTiles ; $400e
DataPtr_TrainingCourtScoreboardColumnTiles:
	dw TrainingCourtScoreboardColumnTiles ; $4010
DataPtr_TrainingCourtPalettesAlias1:
	dw TrainingCourtPalettes ; $4012
DataPtr_TrainingCourtTilemap:
	dw TrainingCourtTilemap ; $4014
DataPtr_TrainingCourtAttrmap:
	dw TrainingCourtAttrmap ; $4016
DataPtr_TrainingCourtScoreboardColumnTilesAlias1:
	dw TrainingCourtScoreboardColumnTiles ; $4018
DataPtr_TrainingCourtScoreboardColumnAttrs:
	dw TrainingCourtScoreboardColumnAttrs ; $401a
DataPtr_ClayCourtPalettes:
	dw ClayCourtPalettes ; $401c
DataPtr_TrainingCourtTiles:
	dw TrainingCourtTiles ; $401e
DataPtr_ClayCourtScoreboardColumnTiles:
	dw ClayCourtScoreboardColumnTiles ; $4020
DataPtr_ClayCourtPalettesAlias1:
	dw ClayCourtPalettes ; $4022
DataPtr_ClayCourtTilemap:
	dw ClayCourtTilemap ; $4024
DataPtr_ClayCourtAttrmap:
	dw ClayCourtAttrmap ; $4026
DataPtr_ClayCourtScoreboardColumnTilesAlias1:
	dw ClayCourtScoreboardColumnTiles ; $4028
DataPtr_ClayCourtScoreboardColumnAttrs:
	dw ClayCourtScoreboardColumnAttrs ; $402a
DataPtr_HardCourtPalettes:
	dw HardCourtPalettes ; $402c
DataPtr_ClayCourtTiles:
	dw ClayCourtTiles ; $402e
DataPtr_HardCourtScoreboardColumnTiles:
	dw HardCourtScoreboardColumnTiles ; $4030
DataPtr_HardCourtPalettesAlias1:
	dw HardCourtPalettes ; $4032
DataPtr_HardCourtTilemap:
	dw HardCourtTilemap ; $4034
DataPtr_HardCourtAttrmap:
	dw HardCourtAttrmap ; $4036
DataPtr_HardCourtScoreboardColumnTilesAlias1:
	dw HardCourtScoreboardColumnTiles ; $4038
DataPtr_HardCourtScoreboardColumnAttrs:
	dw HardCourtScoreboardColumnAttrs ; $403a
DataPtr_HardCourtSceneUnusedSlot:
	dw HardCourtSceneUnusedSlot ; $403c
DataPtr_HardCourtTiles:
	dw HardCourtTiles ; $403e
GrassCourtPalettes:
	INCLUDE "data/scenes/GrassCourtPalettes.asm" ; $4040, 64 bytes (palettes)
GrassCourtTiles:
	INCBIN "data/scenes/lz_GrassCourtTiles.bin" ; $4080, 3233 bytes
GrassCourtTilemap:
	INCBIN "data/scenes/lz_GrassCourtTilemap.bin" ; $4d21, 604 bytes
GrassCourtAttrmap:
	INCBIN "data/scenes/lz_GrassCourtAttrmap.bin" ; $4f7d, 268 bytes
GrassCourtScoreboardColumnTiles:
	INCLUDE "data/scenes/GrassCourtScoreboardColumnTiles.asm" ; $5089, 40 bytes (scoreboard_columns)
GrassCourtScoreboardColumnAttrs:
	INCLUDE "data/scenes/GrassCourtScoreboardColumnAttrs.asm" ; $50b1, 40 bytes (scoreboard_columns)
TrainingCourtPalettes:
	INCLUDE "data/scenes/TrainingCourtPalettes.asm" ; $50d9, 64 bytes (palettes)
TrainingCourtTiles:
	INCBIN "data/scenes/lz_TrainingCourtTiles.bin" ; $5119, 2352 bytes
TrainingCourtTilemap:
	INCBIN "data/scenes/lz_TrainingCourtTilemap.bin" ; $5a49, 637 bytes
TrainingCourtAttrmap:
	INCBIN "data/scenes/lz_TrainingCourtAttrmap.bin" ; $5cc6, 155 bytes
TrainingCourtScoreboardColumnTiles:
	INCLUDE "data/scenes/TrainingCourtScoreboardColumnTiles.asm" ; $5d61, 40 bytes (scoreboard_columns)
TrainingCourtScoreboardColumnAttrs:
	INCLUDE "data/scenes/TrainingCourtScoreboardColumnAttrs.asm" ; $5d89, 40 bytes (scoreboard_columns)
ClayCourtPalettes:
	INCLUDE "data/scenes/ClayCourtPalettes.asm" ; $5db1, 64 bytes (palettes)
ClayCourtTiles:
	INCBIN "data/scenes/lz_ClayCourtTiles.bin" ; $5df1, 2993 bytes
ClayCourtTilemap:
	INCBIN "data/scenes/lz_ClayCourtTilemap.bin" ; $69a2, 582 bytes
ClayCourtAttrmap:
	INCBIN "data/scenes/lz_ClayCourtAttrmap.bin" ; $6be8, 166 bytes
ClayCourtScoreboardColumnTiles:
	INCLUDE "data/scenes/ClayCourtScoreboardColumnTiles.asm" ; $6c8e, 40 bytes (scoreboard_columns)
ClayCourtScoreboardColumnAttrs:
	INCLUDE "data/scenes/ClayCourtScoreboardColumnAttrs.asm" ; $6cb6, 40 bytes (scoreboard_columns)
HardCourtPalettes:
	INCLUDE "data/scenes/HardCourtPalettes.asm" ; $6cde, 64 bytes (palettes)
HardCourtTiles:
	INCBIN "data/scenes/lz_HardCourtTiles.bin" ; $6d1e, 2994 bytes
HardCourtTilemap:
	INCBIN "data/scenes/lz_HardCourtTilemap.bin" ; $78d0, 573 bytes
HardCourtAttrmap:
	INCBIN "data/scenes/lz_HardCourtAttrmap.bin" ; $7b0d, 160 bytes
HardCourtScoreboardColumnTiles:
	INCLUDE "data/scenes/HardCourtScoreboardColumnTiles.asm" ; $7bad, 40 bytes (scoreboard_columns)
HardCourtScoreboardColumnAttrs:
	INCLUDE "data/scenes/HardCourtScoreboardColumnAttrs.asm" ; $7bd5, 40 bytes (scoreboard_columns)
HardCourtSceneUnusedSlot:
	; $7bfd, 1027 bytes fill to bank end (linker-padded)
