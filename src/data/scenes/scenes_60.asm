DataPtr_GrassCourtSceneConfig:
	dw GrassCourtSceneConfig ; $4000
DataPtr_GrassCourtPalettes:
	dw GrassCourtPalettes ; $4002
DataPtr_GrassCourtTilemap:
	dw GrassCourtTilemap ; $4004
DataPtr_GrassCourtAttrmap:
	dw GrassCourtAttrmap ; $4006
DataPtr_GrassCourtSceneConfigAlias1:
	dw GrassCourtSceneConfig ; $4008
DataPtr_GrassCourtScoreboardColumnAttrs:
	dw GrassCourtScoreboardColumnAttrs ; $400a
DataPtr_TrainingCourtPalettes:
	dw TrainingCourtPalettes ; $400c
DataPtr_GrassCourtTiles:
	dw GrassCourtTiles ; $400e
DataPtr_TrainingCourtSceneConfig:
	dw TrainingCourtSceneConfig ; $4010
DataPtr_TrainingCourtPalettesAlias1:
	dw TrainingCourtPalettes ; $4012
DataPtr_TrainingCourtTilemap:
	dw TrainingCourtTilemap ; $4014
DataPtr_TrainingCourtAttrmap:
	dw TrainingCourtAttrmap ; $4016
DataPtr_TrainingCourtSceneConfigAlias1:
	dw TrainingCourtSceneConfig ; $4018
DataPtr_TrainingCourtScoreboardColumnAttrs:
	dw TrainingCourtScoreboardColumnAttrs ; $401a
DataPtr_ClayCourtPalettes:
	dw ClayCourtPalettes ; $401c
DataPtr_TrainingCourtTiles:
	dw TrainingCourtTiles ; $401e
DataPtr_ClayCourtSceneConfig:
	dw ClayCourtSceneConfig ; $4020
DataPtr_ClayCourtPalettesAlias1:
	dw ClayCourtPalettes ; $4022
DataPtr_ClayCourtTilemap:
	dw ClayCourtTilemap ; $4024
DataPtr_ClayCourtAttrmap:
	dw ClayCourtAttrmap ; $4026
DataPtr_ClayCourtSceneConfigAlias1:
	dw ClayCourtSceneConfig ; $4028
DataPtr_ClayCourtScoreboardColumnAttrs:
	dw ClayCourtScoreboardColumnAttrs ; $402a
DataPtr_HardCourtPalettes:
	dw HardCourtPalettes ; $402c
DataPtr_ClayCourtTiles:
	dw ClayCourtTiles ; $402e
DataPtr_HardCourtSceneConfig:
	dw HardCourtSceneConfig ; $4030
DataPtr_HardCourtPalettesAlias1:
	dw HardCourtPalettes ; $4032
DataPtr_HardCourtTilemap:
	dw HardCourtTilemap ; $4034
DataPtr_HardCourtAttrmap:
	dw HardCourtAttrmap ; $4036
DataPtr_HardCourtSceneConfigAlias1:
	dw HardCourtSceneConfig ; $4038
DataPtr_HardCourtScoreboardColumnAttrs:
	dw HardCourtScoreboardColumnAttrs ; $403a
DataPtr_HardCourtSceneUnusedSlot:
	dw HardCourtSceneUnusedSlot ; $403c
DataPtr_HardCourtTiles:
	dw HardCourtTiles ; $403e
GrassCourtPalettes:
	INCLUDE "data/bank_060/GrassCourtPalettes.asm" ; $4040, 64 bytes (palettes)
GrassCourtTiles:
	INCBIN "data/bank_060/lz_GrassCourtTiles.bin" ; $4080, 3233 bytes
GrassCourtTilemap:
	INCBIN "data/bank_060/lz_GrassCourtTilemap.bin" ; $4d21, 604 bytes
GrassCourtAttrmap:
	INCBIN "data/bank_060/lz_GrassCourtAttrmap.bin" ; $4f7d, 268 bytes
GrassCourtSceneConfig:
	INCBIN "data/bank_060/GrassCourtSceneConfig.bin" ; $5089, 40 bytes
GrassCourtScoreboardColumnAttrs:
	INCBIN "data/bank_060/GrassCourtScoreboardColumnAttrs.bin" ; $50b1, 40 bytes
TrainingCourtPalettes:
	INCLUDE "data/bank_060/TrainingCourtPalettes.asm" ; $50d9, 64 bytes (palettes)
TrainingCourtTiles:
	INCBIN "data/bank_060/lz_TrainingCourtTiles.bin" ; $5119, 2352 bytes
TrainingCourtTilemap:
	INCBIN "data/bank_060/lz_TrainingCourtTilemap.bin" ; $5a49, 637 bytes
TrainingCourtAttrmap:
	INCBIN "data/bank_060/lz_TrainingCourtAttrmap.bin" ; $5cc6, 155 bytes
TrainingCourtSceneConfig:
	INCBIN "data/bank_060/TrainingCourtSceneConfig.bin" ; $5d61, 40 bytes
TrainingCourtScoreboardColumnAttrs:
	INCBIN "data/bank_060/TrainingCourtScoreboardColumnAttrs.bin" ; $5d89, 40 bytes
ClayCourtPalettes:
	INCLUDE "data/bank_060/ClayCourtPalettes.asm" ; $5db1, 64 bytes (palettes)
ClayCourtTiles:
	INCBIN "data/bank_060/lz_ClayCourtTiles.bin" ; $5df1, 2993 bytes
ClayCourtTilemap:
	INCBIN "data/bank_060/lz_ClayCourtTilemap.bin" ; $69a2, 582 bytes
ClayCourtAttrmap:
	INCBIN "data/bank_060/lz_ClayCourtAttrmap.bin" ; $6be8, 166 bytes
ClayCourtSceneConfig:
	INCBIN "data/bank_060/ClayCourtSceneConfig.bin" ; $6c8e, 40 bytes
ClayCourtScoreboardColumnAttrs:
	INCBIN "data/bank_060/ClayCourtScoreboardColumnAttrs.bin" ; $6cb6, 40 bytes
HardCourtPalettes:
	INCLUDE "data/bank_060/HardCourtPalettes.asm" ; $6cde, 64 bytes (palettes)
HardCourtTiles:
	INCBIN "data/bank_060/lz_HardCourtTiles.bin" ; $6d1e, 2994 bytes
HardCourtTilemap:
	INCBIN "data/bank_060/lz_HardCourtTilemap.bin" ; $78d0, 573 bytes
HardCourtAttrmap:
	INCBIN "data/bank_060/lz_HardCourtAttrmap.bin" ; $7b0d, 160 bytes
HardCourtSceneConfig:
	INCBIN "data/bank_060/HardCourtSceneConfig.bin" ; $7bad, 40 bytes
HardCourtScoreboardColumnAttrs:
	INCBIN "data/bank_060/HardCourtScoreboardColumnAttrs.bin" ; $7bd5, 40 bytes
HardCourtSceneUnusedSlot:
	; $7bfd, 1027 bytes fill to bank end (linker-padded)
