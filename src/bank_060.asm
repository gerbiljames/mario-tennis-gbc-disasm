INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $60", ROMX[$4000], BANK[$60]

DataPtr_GrassCourtSceneConfig:
	dw GrassCourtSceneConfig ; $4000
DataPtr_GrassCourtPalettes:
	dw GrassCourtPalettes ; $4002
DataPtr_GrassCourtTilemap:
	dw GrassCourtTilemap ; $4004
DataPtr_GrassCourtAttrmap:
	dw GrassCourtAttrmap ; $4006
DataPtr_60_08:
	dw GrassCourtSceneConfig ; $4008
DataPtr_60_0a:
	dw Data_60_50b1 ; $400a
DataPtr_HardCourtPalettes:
	dw HardCourtPalettes ; $400c
DataPtr_GrassCourtTiles:
	dw GrassCourtTiles ; $400e
DataPtr_HardCourtSceneConfig:
	dw HardCourtSceneConfig ; $4010
DataPtr_60_12:
	dw HardCourtPalettes ; $4012
DataPtr_HardCourtTilemap:
	dw HardCourtTilemap ; $4014
DataPtr_HardCourtAttrmap:
	dw HardCourtAttrmap ; $4016
DataPtr_60_18:
	dw HardCourtSceneConfig ; $4018
DataPtr_60_1a:
	dw Data_60_5d89 ; $401a
DataPtr_ClayCourtPalettes:
	dw ClayCourtPalettes ; $401c
DataPtr_HardCourtTiles:
	dw HardCourtTiles ; $401e
DataPtr_ClayCourtSceneConfig:
	dw ClayCourtSceneConfig ; $4020
DataPtr_60_22:
	dw ClayCourtPalettes ; $4022
DataPtr_ClayCourtTilemap:
	dw ClayCourtTilemap ; $4024
DataPtr_ClayCourtAttrmap:
	dw ClayCourtAttrmap ; $4026
DataPtr_60_28:
	dw ClayCourtSceneConfig ; $4028
DataPtr_60_2a:
	dw Data_60_6cb6 ; $402a
DataPtr_CompositionCourtPalettes:
	dw CompositionCourtPalettes ; $402c
DataPtr_ClayCourtTiles:
	dw ClayCourtTiles ; $402e
DataPtr_CompositionCourtSceneConfig:
	dw CompositionCourtSceneConfig ; $4030
DataPtr_60_32:
	dw CompositionCourtPalettes ; $4032
DataPtr_CompositionCourtTilemap:
	dw CompositionCourtTilemap ; $4034
DataPtr_CompositionCourtAttrmap:
	dw CompositionCourtAttrmap ; $4036
DataPtr_60_38:
	dw CompositionCourtSceneConfig ; $4038
DataPtr_60_3a:
	dw Data_60_7bd5 ; $403a
DataPtr_60_3c:
	dw Data_60_7bfd ; $403c
DataPtr_CompositionCourtTiles:
	dw CompositionCourtTiles ; $403e
GrassCourtPalettes:
	INCBIN "data/bank_060/d_4040.bin" ; $4040, 64 bytes
GrassCourtTiles:
	INCBIN "data/bank_060/lz_4080.bin" ; $4080, 3233 bytes
GrassCourtTilemap:
	INCBIN "data/bank_060/lz_4d21.bin" ; $4d21, 604 bytes
GrassCourtAttrmap:
	INCBIN "data/bank_060/lz_4f7d.bin" ; $4f7d, 268 bytes
GrassCourtSceneConfig:
	INCBIN "data/bank_060/d_5089.bin" ; $5089, 40 bytes
Data_60_50b1:
	INCBIN "data/bank_060/d_50b1.bin" ; $50b1, 40 bytes
HardCourtPalettes:
	INCBIN "data/bank_060/d_50d9.bin" ; $50d9, 64 bytes
HardCourtTiles:
	INCBIN "data/bank_060/lz_5119.bin" ; $5119, 2352 bytes
HardCourtTilemap:
	INCBIN "data/bank_060/lz_5a49.bin" ; $5a49, 637 bytes
HardCourtAttrmap:
	INCBIN "data/bank_060/lz_5cc6.bin" ; $5cc6, 155 bytes
HardCourtSceneConfig:
	INCBIN "data/bank_060/d_5d61.bin" ; $5d61, 40 bytes
Data_60_5d89:
	INCBIN "data/bank_060/d_5d89.bin" ; $5d89, 40 bytes
ClayCourtPalettes:
	INCBIN "data/bank_060/d_5db1.bin" ; $5db1, 64 bytes
ClayCourtTiles:
	INCBIN "data/bank_060/lz_5df1.bin" ; $5df1, 2993 bytes
ClayCourtTilemap:
	INCBIN "data/bank_060/lz_69a2.bin" ; $69a2, 582 bytes
ClayCourtAttrmap:
	INCBIN "data/bank_060/lz_6be8.bin" ; $6be8, 166 bytes
ClayCourtSceneConfig:
	INCBIN "data/bank_060/d_6c8e.bin" ; $6c8e, 40 bytes
Data_60_6cb6:
	INCBIN "data/bank_060/d_6cb6.bin" ; $6cb6, 40 bytes
CompositionCourtPalettes:
	INCBIN "data/bank_060/d_6cde.bin" ; $6cde, 64 bytes
CompositionCourtTiles:
	INCBIN "data/bank_060/lz_6d1e.bin" ; $6d1e, 2994 bytes
CompositionCourtTilemap:
	INCBIN "data/bank_060/lz_78d0.bin" ; $78d0, 573 bytes
CompositionCourtAttrmap:
	INCBIN "data/bank_060/lz_7b0d.bin" ; $7b0d, 160 bytes
CompositionCourtSceneConfig:
	INCBIN "data/bank_060/d_7bad.bin" ; $7bad, 40 bytes
Data_60_7bd5:
	INCBIN "data/bank_060/d_7bd5.bin" ; $7bd5, 40 bytes
Data_60_7bfd:
	INCBIN "data/bank_060/d_7bfd.bin" ; $7bfd, 1027 bytes
