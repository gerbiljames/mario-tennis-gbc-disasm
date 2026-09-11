SECTION "ROM Bank $5f", ROMX[$4000], BANK[$5f]

DataPtr_ClubhouseSceneConfig:
	dw ClubhouseSceneConfig ; $4000
DataPtr_ClubhouseScenePalettes:
	dw ClubhouseScenePalettes ; $4002
DataPtr_ClubhouseSceneTilemap:
	dw ClubhouseSceneTilemap ; $4004
DataPtr_ClubhouseSceneAttrmap:
	dw ClubhouseSceneAttrmap ; $4006
DataPtr_ClubhouseSceneConfigAlias1:
	dw ClubhouseSceneConfig ; $4008
DataPtr_ClubhouseScoreboardColumnAttrs:
	dw ClubhouseScoreboardColumnAttrs ; $400a
DataPtr_CourtyardScenePalettes:
	dw CourtyardScenePalettes ; $400c
DataPtr_ClubhouseSceneTiles:
	dw ClubhouseSceneTiles ; $400e
DataPtr_CourtyardSceneConfig:
	dw CourtyardSceneConfig ; $4010
DataPtr_CourtyardScenePalettesAlias1:
	dw CourtyardScenePalettes ; $4012
DataPtr_CourtyardSceneTilemap:
	dw CourtyardSceneTilemap ; $4014
DataPtr_CourtyardSceneAttrmap:
	dw CourtyardSceneAttrmap ; $4016
DataPtr_CourtyardSceneConfigAlias1:
	dw CourtyardSceneConfig ; $4018
DataPtr_CourtyardScoreboardColumnAttrs:
	dw CourtyardScoreboardColumnAttrs ; $401a
DataPtr_CourtyardSceneUnusedSlot:
	dw CourtyardSceneUnusedSlot ; $401c
DataPtr_CourtyardSceneTiles:
	dw CourtyardSceneTiles ; $401e
ClubhouseScenePalettes:
	INCLUDE "data/bank_05f/ClubhouseScenePalettes.asm" ; $4020, 64 bytes (palettes)
ClubhouseSceneTiles:
	INCBIN "data/bank_05f/lz_ClubhouseSceneTiles.bin" ; $4060, 2037 bytes
ClubhouseSceneTilemap:
	INCBIN "data/bank_05f/lz_ClubhouseSceneTilemap.bin" ; $4855, 625 bytes
ClubhouseSceneAttrmap:
	INCBIN "data/bank_05f/lz_ClubhouseSceneAttrmap.bin" ; $4ac6, 333 bytes
ClubhouseSceneConfig:
	INCBIN "data/bank_05f/ClubhouseSceneConfig.bin" ; $4c13, 40 bytes
ClubhouseScoreboardColumnAttrs:
	INCBIN "data/bank_05f/ClubhouseScoreboardColumnAttrs.bin" ; $4c3b, 40 bytes
CourtyardScenePalettes:
	INCLUDE "data/bank_05f/CourtyardScenePalettes.asm" ; $4c63, 64 bytes (palettes)
CourtyardSceneTiles:
	INCBIN "data/bank_05f/lz_CourtyardSceneTiles.bin" ; $4ca3, 2384 bytes
CourtyardSceneTilemap:
	INCBIN "data/bank_05f/lz_CourtyardSceneTilemap.bin" ; $55f3, 491 bytes
CourtyardSceneAttrmap:
	INCBIN "data/bank_05f/lz_CourtyardSceneAttrmap.bin" ; $57de, 294 bytes
CourtyardSceneConfig:
	INCBIN "data/bank_05f/CourtyardSceneConfig.bin" ; $5904, 40 bytes
CourtyardScoreboardColumnAttrs:
	INCBIN "data/bank_05f/CourtyardScoreboardColumnAttrs.bin" ; $592c, 40 bytes
CourtyardSceneUnusedSlot:
	ds 9900, $ff ; $5954, fill
