DataPtr_TennisDictionaryTiles:
	dw TennisDictionaryTiles ; $4000
DataPtr_TennisDictionaryListTiles:
	dw TennisDictionaryListTiles ; $4002
DataPtr_Unused_3a_FillerSlot_4004:
	dw NameEntryTilemap ; $4004
DataPtr_Unused_3a_FillerSlot_4006:
	dw NameEntryTilemap ; $4006
DataPtr_Unused_3a_FillerSlot_4008:
	dw NameEntryTilemap ; $4008
DataPtr_Unused_3a_FillerSlot_400a:
	dw NameEntryTilemap ; $400a
DataPtr_Unused_3a_FillerSlot_400c:
	dw NameEntryTilemap ; $400c
DataPtr_Unused_3a_FillerSlot_400e:
	dw NameEntryTilemap ; $400e
DataPtr_Unused_3a_FillerSlot_4010:
	dw NameEntryTilemap ; $4010
DataPtr_Unused_3a_FillerSlot_4012:
	dw NameEntryTilemap ; $4012
DataPtr_NameEntryTilemap:
	dw NameEntryTilemap ; $4014
DataPtr_NameEntryAttrmap:
	dw NameEntryAttrmap ; $4016
DataPtr_CharSelectAltTilemap:
	dw CharSelectAltTilemap ; $4018
DataPtr_CharSelectAltAttrmap:
	dw CharSelectAltAttrmap ; $401a
DataPtr_Unused_3a_FillerSlot_401c:
	dw NameEntryTilemap ; $401c
DataPtr_Unused_3a_FillerSlot_401e:
	dw NameEntryTilemap ; $401e
DataPtr_Unused_3a_FillerSlot_4020:
	dw NameEntryTilemap ; $4020
DataPtr_Unused_3a_FillerSlot_4022:
	dw NameEntryTilemap ; $4022
DataPtr_ExhibitionSetupTiles:
	dw ExhibitionSetupTiles ; $4024
DataPtr_ExhibitionSetupTilemap:
	dw ExhibitionSetupTilemap ; $4026
DataPtr_ExhibitionSetupAttrmap:
	dw ExhibitionSetupAttrmap ; $4028
DataPtr_ExhibitionSetupPalettes:
	dw ExhibitionSetupPalettes ; $402a
DataPtr_ExhibitionRecordsTiles:
	dw ExhibitionRecordsTiles ; $402c
DataPtr_ExhibitionRecordsTilemap:
	dw ExhibitionRecordsTilemap ; $402e
DataPtr_ExhibitionRecordsAttrmap:
	dw ExhibitionRecordsAttrmap ; $4030
DataPtr_ExhibitionRecordsPalettes:
	dw ExhibitionRecordsPalettes ; $4032
DataPtr_N64TournamentTiles:
	dw N64TournamentTiles ; $4034
DataPtr_N64TournamentTwoSetsTilemap:
	dw N64TournamentTwoSetsTilemap ; $4036
DataPtr_N64TournamentTwoSetsAttrmap:
	dw N64TournamentTwoSetsAttrmap ; $4038
DataPtr_N64TournamentPalettes:
	dw N64TournamentPalettes ; $403a
DataPtr_N64TournamentOneSetTilemap:
	dw N64TournamentOneSetTilemap ; $403c
DataPtr_N64TournamentOneSetAttrmap:
	dw N64TournamentOneSetAttrmap ; $403e
DataPtr_WarningScreenTiles:
	dw WarningScreenTiles ; $4040
DataPtr_WarningScreenTilemap:
	dw WarningScreenTilemap ; $4042
DataPtr_WarningScreenAttrmap:
	dw WarningScreenAttrmap ; $4044
DataPtr_WarningScreenPalettes:
	dw WarningScreenPalettes ; $4046
DataPtr_JapanesePlayModeTiles:
	dw JapanesePlayModeTiles ; $4048
DataPtr_JapanesePlayModeTilemap:
	dw JapanesePlayModeTilemap ; $404a
DataPtr_JapanesePlayModeAttrmap:
	dw JapanesePlayModeAttrmap ; $404c
DataPtr_JapanesePlayModePalettes:
	dw JapanesePlayModePalettes ; $404e
DataPtr_LinkErrorTiles:
	dw LinkErrorTiles ; $4050
DataPtr_LinkErrorTilemap:
	dw LinkErrorTilemap ; $4052
DataPtr_LinkErrorAttrmap:
	dw LinkErrorAttrmap ; $4054
DataPtr_LinkErrorPalettes:
	dw LinkErrorPalettes ; $4056
DataPtr_MushroomIconTiles:
	dw MushroomIconTiles ; $4058
TennisDictionaryTiles:
	INCBIN "data/gfx/lz_TennisDictionaryTiles.bin" ; $405a, 2621 bytes
TennisDictionaryListTiles:
	INCBIN "data/gfx/lz_TennisDictionaryListTiles.bin" ; $4a97, 2404 bytes
NameEntryTilemap:
	INCBIN "data/gfx/lz_NameEntryTilemap.bin" ; $53fb, 109 bytes
NameEntryAttrmap:
	INCBIN "data/gfx/lz_NameEntryAttrmap.bin" ; $5468, 112 bytes
CharSelectAltTilemap:
	INCBIN "data/gfx/lz_CharSelectAltTilemap.bin" ; $54d8, 109 bytes
CharSelectAltAttrmap:
	INCBIN "data/gfx/lz_CharSelectAltAttrmap.bin" ; $5545, 106 bytes
ExhibitionSetupTiles:
	INCBIN "data/gfx/lz_ExhibitionSetupTiles.bin" ; $55af, 1138 bytes
ExhibitionSetupTilemap:
	INCBIN "data/gfx/lz_ExhibitionSetupTilemap.bin" ; $5a21, 217 bytes
ExhibitionSetupAttrmap:
	INCBIN "data/gfx/lz_ExhibitionSetupAttrmap.bin" ; $5afa, 109 bytes
ExhibitionSetupPalettes:
	INCLUDE "data/gfx/ExhibitionSetupPalettes.asm" ; $5b67, 64 bytes (palettes)
ExhibitionRecordsTiles:
	INCBIN "data/gfx/lz_ExhibitionRecordsTiles.bin" ; $5ba7, 1698 bytes
ExhibitionRecordsTilemap:
	INCBIN "data/gfx/lz_ExhibitionRecordsTilemap.bin" ; $6249, 255 bytes
ExhibitionRecordsAttrmap:
	INCBIN "data/gfx/lz_ExhibitionRecordsAttrmap.bin" ; $6348, 119 bytes
ExhibitionRecordsPalettes:
	INCLUDE "data/gfx/ExhibitionRecordsPalettes.asm" ; $63bf, 64 bytes (palettes)
N64TournamentTiles:
	INCBIN "data/gfx/lz_N64TournamentTiles.bin" ; $63ff, 1650 bytes
N64TournamentTwoSetsTilemap:
	INCBIN "data/gfx/lz_N64TournamentTwoSetsTilemap.bin" ; $6a71, 268 bytes
N64TournamentTwoSetsAttrmap:
	INCBIN "data/gfx/lz_N64TournamentTwoSetsAttrmap.bin" ; $6b7d, 121 bytes
N64TournamentPalettes:
	INCLUDE "data/gfx/N64TournamentPalettes.asm" ; $6bf6, 64 bytes (palettes)
N64TournamentOneSetTilemap:
	INCBIN "data/gfx/lz_N64TournamentOneSetTilemap.bin" ; $6c36, 268 bytes
N64TournamentOneSetAttrmap:
	INCBIN "data/gfx/lz_N64TournamentOneSetAttrmap.bin" ; $6d42, 123 bytes
WarningScreenTiles:
	INCBIN "data/gfx/lz_WarningScreenTiles.bin" ; $6dbd, 631 bytes
WarningScreenTilemap:
	INCBIN "data/gfx/lz_WarningScreenTilemap.bin" ; $7034, 149 bytes
WarningScreenAttrmap:
	INCBIN "data/gfx/lz_WarningScreenAttrmap.bin" ; $70c9, 107 bytes
WarningScreenPalettes:
	INCLUDE "data/gfx/WarningScreenPalettes.asm" ; $7134, 64 bytes (palettes)
JapanesePlayModeTiles:
	INCBIN "data/gfx/lz_JapanesePlayModeTiles.bin" ; $7174, 1067 bytes
JapanesePlayModeTilemap:
	INCBIN "data/gfx/lz_JapanesePlayModeTilemap.bin" ; $759f, 166 bytes
JapanesePlayModeAttrmap:
	INCBIN "data/gfx/lz_JapanesePlayModeAttrmap.bin" ; $7645, 138 bytes
JapanesePlayModePalettes:
	INCLUDE "data/gfx/JapanesePlayModePalettes.asm" ; $76cf, 64 bytes (palettes)
LinkErrorTiles:
	INCBIN "data/gfx/lz_LinkErrorTiles.bin" ; $770f, 1376 bytes
LinkErrorTilemap:
	INCBIN "data/gfx/lz_LinkErrorTilemap.bin" ; $7c6f, 239 bytes
LinkErrorAttrmap:
	INCBIN "data/gfx/lz_LinkErrorAttrmap.bin" ; $7d5e, 92 bytes
LinkErrorPalettes:
	INCLUDE "data/gfx/LinkErrorPalettes.asm" ; $7dba, 64 bytes (palettes)
MushroomIconTiles:
	INCBIN "data/gfx/lz_MushroomIconTiles.bin" ; $7dfa, 227 bytes
	; $7edd, 291 bytes fill to bank end (linker-padded)
