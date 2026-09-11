DataPtr_MachineCourtSceneConfig:
	dw MachineCourtSceneConfig ; $4000
DataPtr_MachineCourtPalettes:
	dw MachineCourtPalettes ; $4002
DataPtr_MachineCourtTilemap:
	dw MachineCourtTilemap ; $4004
DataPtr_MachineCourtAttrmap:
	dw MachineCourtAttrmap ; $4006
DataPtr_MachineCourtSceneConfigAlias1:
	dw MachineCourtSceneConfig ; $4008
DataPtr_MachineCourtScoreboardColumnAttrs:
	dw MachineCourtScoreboardColumnAttrs ; $400a
DataPtr_CenterCourtPalettes:
	dw CenterCourtPalettes ; $400c
DataPtr_MachineCourtTiles:
	dw MachineCourtTiles ; $400e
DataPtr_CenterCourtSceneConfig:
	dw CenterCourtSceneConfig ; $4010
DataPtr_CenterCourtPalettesAlias1:
	dw CenterCourtPalettes ; $4012
DataPtr_CenterCourtTilemap:
	dw CenterCourtTilemap ; $4014
DataPtr_CenterCourtAttrmap:
	dw CenterCourtAttrmap ; $4016
DataPtr_CenterCourtSceneConfigAlias1:
	dw CenterCourtSceneConfig ; $4018
DataPtr_CenterCourtScoreboardColumnAttrs:
	dw CenterCourtScoreboardColumnAttrs ; $401a
DataPtr_CompositionCourtPalettes:
	dw CompositionCourtPalettes ; $401c
DataPtr_CenterCourtTiles:
	dw CenterCourtTiles ; $401e
DataPtr_CompositionCourtSceneConfig:
	dw CompositionCourtSceneConfig ; $4020
DataPtr_CompositionCourtPalettesAlias1:
	dw CompositionCourtPalettes ; $4022
DataPtr_CompositionCourtTilemap:
	dw CompositionCourtTilemap ; $4024
DataPtr_CompositionCourtAttrmap:
	dw CompositionCourtAttrmap ; $4026
DataPtr_CompositionCourtSceneConfigAlias1:
	dw CompositionCourtSceneConfig ; $4028
DataPtr_CompositionCourtScoreboardColumnAttrs:
	dw CompositionCourtScoreboardColumnAttrs ; $402a
DataPtr_TropicsCourtPalettes:
	dw TropicsCourtPalettes ; $402c
DataPtr_CompositionCourtTiles:
	dw CompositionCourtTiles ; $402e
DataPtr_TropicsCourtSceneConfig:
	dw TropicsCourtSceneConfig ; $4030
DataPtr_TropicsCourtPalettesAlias1:
	dw TropicsCourtPalettes ; $4032
DataPtr_TropicsCourtTilemap:
	dw TropicsCourtTilemap ; $4034
DataPtr_TropicsCourtAttrmap:
	dw TropicsCourtAttrmap ; $4036
DataPtr_TropicsCourtSceneConfigAlias1:
	dw TropicsCourtSceneConfig ; $4038
DataPtr_TropicsCourtScoreboardColumnAttrs:
	dw TropicsCourtScoreboardColumnAttrs ; $403a
DataPtr_TropicsCourtSceneUnusedSlot:
	dw TropicsCourtSceneUnusedSlot ; $403c
DataPtr_TropicsCourtTiles:
	dw TropicsCourtTiles ; $403e
MachineCourtPalettes:
	INCLUDE "data/bank_061/MachineCourtPalettes.asm" ; $4040, 64 bytes (palettes)
MachineCourtTiles:
	INCBIN "data/bank_061/lz_MachineCourtTiles.bin" ; $4080, 2350 bytes
MachineCourtTilemap:
	INCBIN "data/bank_061/lz_MachineCourtTilemap.bin" ; $49ae, 461 bytes
MachineCourtAttrmap:
	INCBIN "data/bank_061/lz_MachineCourtAttrmap.bin" ; $4b7b, 158 bytes
MachineCourtSceneConfig:
	INCBIN "data/bank_061/MachineCourtSceneConfig.bin" ; $4c19, 40 bytes
MachineCourtScoreboardColumnAttrs:
	INCBIN "data/bank_061/MachineCourtScoreboardColumnAttrs.bin" ; $4c41, 40 bytes
CenterCourtPalettes:
	INCLUDE "data/bank_061/CenterCourtPalettes.asm" ; $4c69, 64 bytes (palettes)
CenterCourtTiles:
	INCBIN "data/bank_061/lz_CenterCourtTiles.bin" ; $4ca9, 3057 bytes
CenterCourtTilemap:
	INCBIN "data/bank_061/lz_CenterCourtTilemap.bin" ; $589a, 596 bytes
CenterCourtAttrmap:
	INCBIN "data/bank_061/lz_CenterCourtAttrmap.bin" ; $5aee, 269 bytes
CenterCourtSceneConfig:
	INCBIN "data/bank_061/CenterCourtSceneConfig.bin" ; $5bfb, 40 bytes
CenterCourtScoreboardColumnAttrs:
	INCBIN "data/bank_061/CenterCourtScoreboardColumnAttrs.bin" ; $5c23, 40 bytes
CompositionCourtPalettes:
	INCLUDE "data/bank_061/CompositionCourtPalettes.asm" ; $5c4b, 64 bytes (palettes)
CompositionCourtTiles:
	INCBIN "data/bank_061/lz_CompositionCourtTiles.bin" ; $5c8b, 2761 bytes
CompositionCourtTilemap:
	INCBIN "data/bank_061/lz_CompositionCourtTilemap.bin" ; $6754, 547 bytes
CompositionCourtAttrmap:
	INCBIN "data/bank_061/lz_CompositionCourtAttrmap.bin" ; $6977, 132 bytes
CompositionCourtSceneConfig:
	INCBIN "data/bank_061/CompositionCourtSceneConfig.bin" ; $69fb, 40 bytes
CompositionCourtScoreboardColumnAttrs:
	INCBIN "data/bank_061/CompositionCourtScoreboardColumnAttrs.bin" ; $6a23, 40 bytes
TropicsCourtPalettes:
	INCLUDE "data/bank_061/TropicsCourtPalettes.asm" ; $6a4b, 64 bytes (palettes)
TropicsCourtTiles:
	INCBIN "data/bank_061/lz_TropicsCourtTiles.bin" ; $6a8b, 3003 bytes
TropicsCourtTilemap:
	INCBIN "data/bank_061/lz_TropicsCourtTilemap.bin" ; $7646, 708 bytes
TropicsCourtAttrmap:
	INCBIN "data/bank_061/lz_TropicsCourtAttrmap.bin" ; $790a, 317 bytes
TropicsCourtSceneConfig:
	INCBIN "data/bank_061/TropicsCourtSceneConfig.bin" ; $7a47, 40 bytes
TropicsCourtScoreboardColumnAttrs:
	INCBIN "data/bank_061/TropicsCourtScoreboardColumnAttrs.bin" ; $7a6f, 40 bytes
TropicsCourtSceneUnusedSlot:
	; $7a97, 1385 bytes fill to bank end (linker-padded)
