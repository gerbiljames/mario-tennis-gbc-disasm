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
DataPtr_PracticeCourtPalettes:
	dw PracticeCourtPalettes ; $401c
DataPtr_CenterCourtTiles:
	dw CenterCourtTiles ; $401e
DataPtr_PracticeCourtSceneConfig:
	dw PracticeCourtSceneConfig ; $4020
DataPtr_PracticeCourtPalettesAlias1:
	dw PracticeCourtPalettes ; $4022
DataPtr_PracticeCourtTilemap:
	dw PracticeCourtTilemap ; $4024
DataPtr_PracticeCourtAttrmap:
	dw PracticeCourtAttrmap ; $4026
DataPtr_PracticeCourtSceneConfigAlias1:
	dw PracticeCourtSceneConfig ; $4028
DataPtr_PracticeCourtScoreboardColumnAttrs:
	dw PracticeCourtScoreboardColumnAttrs ; $402a
DataPtr_YoshiCourtPalettes:
	dw YoshiCourtPalettes ; $402c
DataPtr_PracticeCourtTiles:
	dw PracticeCourtTiles ; $402e
DataPtr_YoshiCourtSceneConfig:
	dw YoshiCourtSceneConfig ; $4030
DataPtr_YoshiCourtPalettesAlias1:
	dw YoshiCourtPalettes ; $4032
DataPtr_YoshiCourtTilemap:
	dw YoshiCourtTilemap ; $4034
DataPtr_YoshiCourtAttrmap:
	dw YoshiCourtAttrmap ; $4036
DataPtr_YoshiCourtSceneConfigAlias1:
	dw YoshiCourtSceneConfig ; $4038
DataPtr_YoshiCourtScoreboardColumnAttrs:
	dw YoshiCourtScoreboardColumnAttrs ; $403a
DataPtr_YoshiCourtSceneUnusedSlot:
	dw YoshiCourtSceneUnusedSlot ; $403c
DataPtr_YoshiCourtTiles:
	dw YoshiCourtTiles ; $403e
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
PracticeCourtPalettes:
	INCLUDE "data/bank_061/PracticeCourtPalettes.asm" ; $5c4b, 64 bytes (palettes)
PracticeCourtTiles:
	INCBIN "data/bank_061/lz_PracticeCourtTiles.bin" ; $5c8b, 2761 bytes
PracticeCourtTilemap:
	INCBIN "data/bank_061/lz_PracticeCourtTilemap.bin" ; $6754, 547 bytes
PracticeCourtAttrmap:
	INCBIN "data/bank_061/lz_PracticeCourtAttrmap.bin" ; $6977, 132 bytes
PracticeCourtSceneConfig:
	INCBIN "data/bank_061/PracticeCourtSceneConfig.bin" ; $69fb, 40 bytes
PracticeCourtScoreboardColumnAttrs:
	INCBIN "data/bank_061/PracticeCourtScoreboardColumnAttrs.bin" ; $6a23, 40 bytes
YoshiCourtPalettes:
	INCLUDE "data/bank_061/YoshiCourtPalettes.asm" ; $6a4b, 64 bytes (palettes)
YoshiCourtTiles:
	INCBIN "data/bank_061/lz_YoshiCourtTiles.bin" ; $6a8b, 3003 bytes
YoshiCourtTilemap:
	INCBIN "data/bank_061/lz_YoshiCourtTilemap.bin" ; $7646, 708 bytes
YoshiCourtAttrmap:
	INCBIN "data/bank_061/lz_YoshiCourtAttrmap.bin" ; $790a, 317 bytes
YoshiCourtSceneConfig:
	INCBIN "data/bank_061/YoshiCourtSceneConfig.bin" ; $7a47, 40 bytes
YoshiCourtScoreboardColumnAttrs:
	INCBIN "data/bank_061/YoshiCourtScoreboardColumnAttrs.bin" ; $7a6f, 40 bytes
YoshiCourtSceneUnusedSlot:
	; $7a97, 1385 bytes fill to bank end (linker-padded)
