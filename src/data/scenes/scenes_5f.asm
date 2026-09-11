DataPtr_MinigameCourtSceneConfig:
	dw MinigameCourtSceneConfig ; $4000
DataPtr_MinigameCourtPalettes:
	dw MinigameCourtPalettes ; $4002
DataPtr_MinigameCourtTilemap:
	dw MinigameCourtTilemap ; $4004
DataPtr_MinigameCourtAttrmap:
	dw MinigameCourtAttrmap ; $4006
DataPtr_MinigameCourtSceneConfigAlias1:
	dw MinigameCourtSceneConfig ; $4008
DataPtr_MinigameCourtScoreboardColumnAttrs:
	dw MinigameCourtScoreboardColumnAttrs ; $400a
DataPtr_TargetShotCourtPalettes:
	dw TargetShotCourtPalettes ; $400c
DataPtr_MinigameCourtTiles:
	dw MinigameCourtTiles ; $400e
DataPtr_TargetShotCourtSceneConfig:
	dw TargetShotCourtSceneConfig ; $4010
DataPtr_TargetShotCourtPalettesAlias1:
	dw TargetShotCourtPalettes ; $4012
DataPtr_TargetShotCourtTilemap:
	dw TargetShotCourtTilemap ; $4014
DataPtr_TargetShotCourtAttrmap:
	dw TargetShotCourtAttrmap ; $4016
DataPtr_TargetShotCourtSceneConfigAlias1:
	dw TargetShotCourtSceneConfig ; $4018
DataPtr_TargetShotCourtScoreboardColumnAttrs:
	dw TargetShotCourtScoreboardColumnAttrs ; $401a
DataPtr_TargetShotCourtSceneUnusedSlot:
	dw TargetShotCourtSceneUnusedSlot ; $401c
DataPtr_TargetShotCourtTiles:
	dw TargetShotCourtTiles ; $401e
MinigameCourtPalettes:
	INCLUDE "data/bank_05f/MinigameCourtPalettes.asm" ; $4020, 64 bytes (palettes)
MinigameCourtTiles:
	INCBIN "data/bank_05f/lz_MinigameCourtTiles.bin" ; $4060, 2037 bytes
MinigameCourtTilemap:
	INCBIN "data/bank_05f/lz_MinigameCourtTilemap.bin" ; $4855, 625 bytes
MinigameCourtAttrmap:
	INCBIN "data/bank_05f/lz_MinigameCourtAttrmap.bin" ; $4ac6, 333 bytes
MinigameCourtSceneConfig:
	INCBIN "data/bank_05f/MinigameCourtSceneConfig.bin" ; $4c13, 40 bytes
MinigameCourtScoreboardColumnAttrs:
	INCBIN "data/bank_05f/MinigameCourtScoreboardColumnAttrs.bin" ; $4c3b, 40 bytes
TargetShotCourtPalettes:
	INCLUDE "data/bank_05f/TargetShotCourtPalettes.asm" ; $4c63, 64 bytes (palettes)
TargetShotCourtTiles:
	INCBIN "data/bank_05f/lz_TargetShotCourtTiles.bin" ; $4ca3, 2384 bytes
TargetShotCourtTilemap:
	INCBIN "data/bank_05f/lz_TargetShotCourtTilemap.bin" ; $55f3, 491 bytes
TargetShotCourtAttrmap:
	INCBIN "data/bank_05f/lz_TargetShotCourtAttrmap.bin" ; $57de, 294 bytes
TargetShotCourtSceneConfig:
	INCBIN "data/bank_05f/TargetShotCourtSceneConfig.bin" ; $5904, 40 bytes
TargetShotCourtScoreboardColumnAttrs:
	INCBIN "data/bank_05f/TargetShotCourtScoreboardColumnAttrs.bin" ; $592c, 40 bytes
TargetShotCourtSceneUnusedSlot:
	; $5954, 9900 bytes fill to bank end (linker-padded)
