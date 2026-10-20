DataPtr_MinigameCourtScoreboardColumnTiles:
	dw MinigameCourtScoreboardColumnTiles ; $4000
DataPtr_MinigameCourtPalettes:
	dw MinigameCourtPalettes ; $4002
DataPtr_MinigameCourtTilemap:
	dw MinigameCourtTilemap ; $4004
DataPtr_MinigameCourtAttrmap:
	dw MinigameCourtAttrmap ; $4006
DataPtr_MinigameCourtScoreboardColumnTilesAlias1:
	dw MinigameCourtScoreboardColumnTiles ; $4008
DataPtr_MinigameCourtScoreboardColumnAttrs:
	dw MinigameCourtScoreboardColumnAttrs ; $400a
DataPtr_TargetShotCourtPalettes:
	dw TargetShotCourtPalettes ; $400c
DataPtr_MinigameCourtTiles:
	dw MinigameCourtTiles ; $400e
DataPtr_TargetShotCourtScoreboardColumnTiles:
	dw TargetShotCourtScoreboardColumnTiles ; $4010
DataPtr_TargetShotCourtPalettesAlias1:
	dw TargetShotCourtPalettes ; $4012
DataPtr_TargetShotCourtTilemap:
	dw TargetShotCourtTilemap ; $4014
DataPtr_TargetShotCourtAttrmap:
	dw TargetShotCourtAttrmap ; $4016
DataPtr_TargetShotCourtScoreboardColumnTilesAlias1:
	dw TargetShotCourtScoreboardColumnTiles ; $4018
DataPtr_TargetShotCourtScoreboardColumnAttrs:
	dw TargetShotCourtScoreboardColumnAttrs ; $401a
DataPtr_TargetShotCourtSceneNoAnimTiles:
	dw TargetShotCourtSceneNoAnimTiles ; $401c
DataPtr_TargetShotCourtTiles:
	dw TargetShotCourtTiles ; $401e
MinigameCourtPalettes:
	INCLUDE "data/scenes/MinigameCourtPalettes.asm" ; $4020, 64 bytes (palettes)
MinigameCourtTiles:
	INCBIN "data/scenes/lz_MinigameCourtTiles.bin" ; $4060, 2037 bytes
MinigameCourtTilemap:
	INCBIN "data/scenes/lz_MinigameCourtTilemap.bin" ; $4855, 625 bytes
MinigameCourtAttrmap:
	INCBIN "data/scenes/lz_MinigameCourtAttrmap.bin" ; $4ac6, 333 bytes
MinigameCourtScoreboardColumnTiles:
	INCLUDE "data/scenes/MinigameCourtScoreboardColumnTiles.asm" ; $4c13, 40 bytes (scoreboard_columns)
MinigameCourtScoreboardColumnAttrs:
	INCLUDE "data/scenes/MinigameCourtScoreboardColumnAttrs.asm" ; $4c3b, 40 bytes (scoreboard_columns)
TargetShotCourtPalettes:
	INCLUDE "data/scenes/TargetShotCourtPalettes.asm" ; $4c63, 64 bytes (palettes)
TargetShotCourtTiles:
	INCBIN "data/scenes/lz_TargetShotCourtTiles.bin" ; $4ca3, 2384 bytes
TargetShotCourtTilemap:
	INCBIN "data/scenes/lz_TargetShotCourtTilemap.bin" ; $55f3, 491 bytes
TargetShotCourtAttrmap:
	INCBIN "data/scenes/lz_TargetShotCourtAttrmap.bin" ; $57de, 294 bytes
TargetShotCourtScoreboardColumnTiles:
	INCLUDE "data/scenes/TargetShotCourtScoreboardColumnTiles.asm" ; $5904, 40 bytes (scoreboard_columns)
TargetShotCourtScoreboardColumnAttrs:
	INCLUDE "data/scenes/TargetShotCourtScoreboardColumnAttrs.asm" ; $592c, 40 bytes (scoreboard_columns)
TargetShotCourtSceneNoAnimTiles:
	; $5954, 9900 bytes fill to bank end (linker-padded)
