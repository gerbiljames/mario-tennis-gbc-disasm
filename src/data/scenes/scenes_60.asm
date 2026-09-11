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
DataPtr_HardCourtPalettes:
	dw HardCourtPalettes ; $400c
DataPtr_GrassCourtTiles:
	dw GrassCourtTiles ; $400e
DataPtr_HardCourtSceneConfig:
	dw HardCourtSceneConfig ; $4010
DataPtr_HardCourtPalettesAlias1:
	dw HardCourtPalettes ; $4012
DataPtr_HardCourtTilemap:
	dw HardCourtTilemap ; $4014
DataPtr_HardCourtAttrmap:
	dw HardCourtAttrmap ; $4016
DataPtr_HardCourtSceneConfigAlias1:
	dw HardCourtSceneConfig ; $4018
DataPtr_HardCourtScoreboardColumnAttrs:
	dw HardCourtScoreboardColumnAttrs ; $401a
DataPtr_ClayCourtPalettes:
	dw ClayCourtPalettes ; $401c
DataPtr_HardCourtTiles:
	dw HardCourtTiles ; $401e
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
DataPtr_CompositionCourtPalettes:
	dw CompositionCourtPalettes ; $402c
DataPtr_ClayCourtTiles:
	dw ClayCourtTiles ; $402e
DataPtr_CompositionCourtSceneConfig:
	dw CompositionCourtSceneConfig ; $4030
DataPtr_CompositionCourtPalettesAlias1:
	dw CompositionCourtPalettes ; $4032
DataPtr_CompositionCourtTilemap:
	dw CompositionCourtTilemap ; $4034
DataPtr_CompositionCourtAttrmap:
	dw CompositionCourtAttrmap ; $4036
DataPtr_CompositionCourtSceneConfigAlias1:
	dw CompositionCourtSceneConfig ; $4038
DataPtr_CompositionCourtScoreboardColumnAttrs:
	dw CompositionCourtScoreboardColumnAttrs ; $403a
DataPtr_CompositionCourtSceneUnusedSlot:
	dw CompositionCourtSceneUnusedSlot ; $403c
DataPtr_CompositionCourtTiles:
	dw CompositionCourtTiles ; $403e
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
HardCourtPalettes:
	INCLUDE "data/bank_060/HardCourtPalettes.asm" ; $50d9, 64 bytes (palettes)
HardCourtTiles:
	INCBIN "data/bank_060/lz_HardCourtTiles.bin" ; $5119, 2352 bytes
HardCourtTilemap:
	INCBIN "data/bank_060/lz_HardCourtTilemap.bin" ; $5a49, 637 bytes
HardCourtAttrmap:
	INCBIN "data/bank_060/lz_HardCourtAttrmap.bin" ; $5cc6, 155 bytes
HardCourtSceneConfig:
	INCBIN "data/bank_060/HardCourtSceneConfig.bin" ; $5d61, 40 bytes
HardCourtScoreboardColumnAttrs:
	INCBIN "data/bank_060/HardCourtScoreboardColumnAttrs.bin" ; $5d89, 40 bytes
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
CompositionCourtPalettes:
	INCLUDE "data/bank_060/CompositionCourtPalettes.asm" ; $6cde, 64 bytes (palettes)
CompositionCourtTiles:
	INCBIN "data/bank_060/lz_CompositionCourtTiles.bin" ; $6d1e, 2994 bytes
CompositionCourtTilemap:
	INCBIN "data/bank_060/lz_CompositionCourtTilemap.bin" ; $78d0, 573 bytes
CompositionCourtAttrmap:
	INCBIN "data/bank_060/lz_CompositionCourtAttrmap.bin" ; $7b0d, 160 bytes
CompositionCourtSceneConfig:
	INCBIN "data/bank_060/CompositionCourtSceneConfig.bin" ; $7bad, 40 bytes
CompositionCourtScoreboardColumnAttrs:
	INCBIN "data/bank_060/CompositionCourtScoreboardColumnAttrs.bin" ; $7bd5, 40 bytes
CompositionCourtSceneUnusedSlot:
	; $7bfd, 1027 bytes fill to bank end (linker-padded)
