DataPtr_MachineCourtScoreboardColumnTiles:
	dw MachineCourtScoreboardColumnTiles ; $4000
DataPtr_MachineCourtPalettes:
	dw MachineCourtPalettes ; $4002
DataPtr_MachineCourtTilemap:
	dw MachineCourtTilemap ; $4004
DataPtr_MachineCourtAttrmap:
	dw MachineCourtAttrmap ; $4006
DataPtr_MachineCourtScoreboardColumnTilesAlias1:
	dw MachineCourtScoreboardColumnTiles ; $4008
DataPtr_MachineCourtScoreboardColumnAttrs:
	dw MachineCourtScoreboardColumnAttrs ; $400a
DataPtr_CenterCourtPalettes:
	dw CenterCourtPalettes ; $400c
DataPtr_MachineCourtTiles:
	dw MachineCourtTiles ; $400e
DataPtr_CenterCourtScoreboardColumnTiles:
	dw CenterCourtScoreboardColumnTiles ; $4010
DataPtr_CenterCourtPalettesAlias1:
	dw CenterCourtPalettes ; $4012
DataPtr_CenterCourtTilemap:
	dw CenterCourtTilemap ; $4014
DataPtr_CenterCourtAttrmap:
	dw CenterCourtAttrmap ; $4016
DataPtr_CenterCourtScoreboardColumnTilesAlias1:
	dw CenterCourtScoreboardColumnTiles ; $4018
DataPtr_CenterCourtScoreboardColumnAttrs:
	dw CenterCourtScoreboardColumnAttrs ; $401a
DataPtr_CompositionCourtPalettes:
	dw CompositionCourtPalettes ; $401c
DataPtr_CenterCourtTiles:
	dw CenterCourtTiles ; $401e
DataPtr_CompositionCourtScoreboardColumnTiles:
	dw CompositionCourtScoreboardColumnTiles ; $4020
DataPtr_CompositionCourtPalettesAlias1:
	dw CompositionCourtPalettes ; $4022
DataPtr_CompositionCourtTilemap:
	dw CompositionCourtTilemap ; $4024
DataPtr_CompositionCourtAttrmap:
	dw CompositionCourtAttrmap ; $4026
DataPtr_CompositionCourtScoreboardColumnTilesAlias1:
	dw CompositionCourtScoreboardColumnTiles ; $4028
DataPtr_CompositionCourtScoreboardColumnAttrs:
	dw CompositionCourtScoreboardColumnAttrs ; $402a
DataPtr_TropicsCourtPalettes:
	dw TropicsCourtPalettes ; $402c
DataPtr_CompositionCourtTiles:
	dw CompositionCourtTiles ; $402e
DataPtr_TropicsCourtScoreboardColumnTiles:
	dw TropicsCourtScoreboardColumnTiles ; $4030
DataPtr_TropicsCourtPalettesAlias1:
	dw TropicsCourtPalettes ; $4032
DataPtr_TropicsCourtTilemap:
	dw TropicsCourtTilemap ; $4034
DataPtr_TropicsCourtAttrmap:
	dw TropicsCourtAttrmap ; $4036
DataPtr_TropicsCourtScoreboardColumnTilesAlias1:
	dw TropicsCourtScoreboardColumnTiles ; $4038
DataPtr_TropicsCourtScoreboardColumnAttrs:
	dw TropicsCourtScoreboardColumnAttrs ; $403a
DataPtr_TropicsCourtSceneNoAnimTiles:
	dw TropicsCourtSceneNoAnimTiles ; $403c
DataPtr_TropicsCourtTiles:
	dw TropicsCourtTiles ; $403e
MachineCourtPalettes:
	INCLUDE "data/scenes/MachineCourtPalettes.asm" ; $4040, 64 bytes (palettes)
MachineCourtTiles:
	INCBIN "data/scenes/lz_MachineCourtTiles.bin" ; $4080, 2350 bytes
MachineCourtTilemap:
	INCBIN "data/scenes/lz_MachineCourtTilemap.bin" ; $49ae, 461 bytes
MachineCourtAttrmap:
	INCBIN "data/scenes/lz_MachineCourtAttrmap.bin" ; $4b7b, 158 bytes
MachineCourtScoreboardColumnTiles:
	INCLUDE "data/scenes/MachineCourtScoreboardColumnTiles.asm" ; $4c19, 40 bytes (scoreboard_columns)
MachineCourtScoreboardColumnAttrs:
	INCLUDE "data/scenes/MachineCourtScoreboardColumnAttrs.asm" ; $4c41, 40 bytes (scoreboard_columns)
CenterCourtPalettes:
	INCLUDE "data/scenes/CenterCourtPalettes.asm" ; $4c69, 64 bytes (palettes)
CenterCourtTiles:
	INCBIN "data/scenes/lz_CenterCourtTiles.bin" ; $4ca9, 3057 bytes
CenterCourtTilemap:
	INCBIN "data/scenes/lz_CenterCourtTilemap.bin" ; $589a, 596 bytes
CenterCourtAttrmap:
	INCBIN "data/scenes/lz_CenterCourtAttrmap.bin" ; $5aee, 269 bytes
CenterCourtScoreboardColumnTiles:
	INCLUDE "data/scenes/CenterCourtScoreboardColumnTiles.asm" ; $5bfb, 40 bytes (scoreboard_columns)
CenterCourtScoreboardColumnAttrs:
	INCLUDE "data/scenes/CenterCourtScoreboardColumnAttrs.asm" ; $5c23, 40 bytes (scoreboard_columns)
CompositionCourtPalettes:
	INCLUDE "data/scenes/CompositionCourtPalettes.asm" ; $5c4b, 64 bytes (palettes)
CompositionCourtTiles:
	INCBIN "data/scenes/lz_CompositionCourtTiles.bin" ; $5c8b, 2761 bytes
CompositionCourtTilemap:
	INCBIN "data/scenes/lz_CompositionCourtTilemap.bin" ; $6754, 547 bytes
CompositionCourtAttrmap:
	INCBIN "data/scenes/lz_CompositionCourtAttrmap.bin" ; $6977, 132 bytes
CompositionCourtScoreboardColumnTiles:
	INCLUDE "data/scenes/CompositionCourtScoreboardColumnTiles.asm" ; $69fb, 40 bytes (scoreboard_columns)
CompositionCourtScoreboardColumnAttrs:
	INCLUDE "data/scenes/CompositionCourtScoreboardColumnAttrs.asm" ; $6a23, 40 bytes (scoreboard_columns)
TropicsCourtPalettes:
	INCLUDE "data/scenes/TropicsCourtPalettes.asm" ; $6a4b, 64 bytes (palettes)
TropicsCourtTiles:
	INCBIN "data/scenes/lz_TropicsCourtTiles.bin" ; $6a8b, 3003 bytes
TropicsCourtTilemap:
	INCBIN "data/scenes/lz_TropicsCourtTilemap.bin" ; $7646, 708 bytes
TropicsCourtAttrmap:
	INCBIN "data/scenes/lz_TropicsCourtAttrmap.bin" ; $790a, 317 bytes
TropicsCourtScoreboardColumnTiles:
	INCLUDE "data/scenes/TropicsCourtScoreboardColumnTiles.asm" ; $7a47, 40 bytes (scoreboard_columns)
TropicsCourtScoreboardColumnAttrs:
	INCLUDE "data/scenes/TropicsCourtScoreboardColumnAttrs.asm" ; $7a6f, 40 bytes (scoreboard_columns)
TropicsCourtSceneNoAnimTiles:
	; $7a97, 1385 bytes fill to bank end (linker-padded)
