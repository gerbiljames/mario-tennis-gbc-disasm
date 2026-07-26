SECTION "ROM Bank $3a", ROMX[$4000], BANK[$3a]

DataPtr_TennisDictionaryTiles:
	dw TennisDictionaryTiles ; $4000
DataPtr_TennisDictionaryListTiles:
	dw TennisDictionaryListTiles ; $4002
DataPtr_NameEntryTilemap:
	dw NameEntryTilemap ; $4004
DataPtr_NameEntryTilemapAlias1:
	dw NameEntryTilemap ; $4006
DataPtr_NameEntryTilemapAlias2:
	dw NameEntryTilemap ; $4008
DataPtr_NameEntryTilemapAlias3:
	dw NameEntryTilemap ; $400a
DataPtr_NameEntryTilemapAlias4:
	dw NameEntryTilemap ; $400c
DataPtr_NameEntryTilemapAlias5:
	dw NameEntryTilemap ; $400e
DataPtr_NameEntryTilemapAlias6:
	dw NameEntryTilemap ; $4010
DataPtr_NameEntryTilemapAlias7:
	dw NameEntryTilemap ; $4012
DataPtr_NameEntryTilemapAlias8:
	dw NameEntryTilemap ; $4014
DataPtr_NameEntryAttrmap:
	dw NameEntryAttrmap ; $4016
DataPtr_CharSelectAltTilemap:
	dw CharSelectAltTilemap ; $4018
DataPtr_CharSelectAltAttrmap:
	dw CharSelectAltAttrmap ; $401a
DataPtr_NameEntryTilemapAlias9:
	dw NameEntryTilemap ; $401c
DataPtr_NameEntryTilemapAlias10:
	dw NameEntryTilemap ; $401e
DataPtr_NameEntryTilemapAlias11:
	dw NameEntryTilemap ; $4020
DataPtr_NameEntryTilemapAlias12:
	dw NameEntryTilemap ; $4022
DataPtr_ExhibitionSetupTiles:
	dw ExhibitionSetupTiles ; $4024
DataPtr_ExhibitionSetupTilemap:
	dw ExhibitionSetupTilemap ; $4026
DataPtr_ExhibitionSetupAttrmap:
	dw ExhibitionSetupAttrmap ; $4028
DataPtr_ExhibitionSetupPalettes:
	dw ExhibitionSetupPalettes ; $402a
DataPtr_ExhibitionMenuTiles:
	dw ExhibitionMenuTiles ; $402c
DataPtr_ExhibitionMenuTilemap:
	dw ExhibitionMenuTilemap ; $402e
DataPtr_ExhibitionMenuAttrmap:
	dw ExhibitionMenuAttrmap ; $4030
DataPtr_ExhibitionMenuPalettes:
	dw ExhibitionMenuPalettes ; $4032
DataPtr_N64TournamentTiles:
	dw N64TournamentTiles ; $4034
DataPtr_N64TournamentTilemap:
	dw N64TournamentTilemap ; $4036
DataPtr_N64TournamentAttrmap:
	dw N64TournamentAttrmap ; $4038
DataPtr_N64TournamentPalettes:
	dw N64TournamentPalettes ; $403a
DataPtr_N64TournamentTilemap2:
	dw N64TournamentTilemap2 ; $403c
DataPtr_N64TournamentAttrmap2:
	dw N64TournamentAttrmap2 ; $403e
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
DataPtr_LinkErrorLabelTiles:
	dw LinkErrorLabelTiles ; $4058
TennisDictionaryTiles:
	INCBIN "data/bank_03a/lz_405a.bin" ; $405a, 2621 bytes
TennisDictionaryListTiles:
	INCBIN "data/bank_03a/lz_4a97.bin" ; $4a97, 2404 bytes
NameEntryTilemap:
	INCBIN "data/bank_03a/lz_53fb.bin" ; $53fb, 109 bytes
NameEntryAttrmap:
	INCBIN "data/bank_03a/lz_5468.bin" ; $5468, 112 bytes
CharSelectAltTilemap:
	INCBIN "data/bank_03a/lz_54d8.bin" ; $54d8, 109 bytes
CharSelectAltAttrmap:
	INCBIN "data/bank_03a/lz_5545.bin" ; $5545, 106 bytes
ExhibitionSetupTiles:
	INCBIN "data/bank_03a/lz_55af.bin" ; $55af, 1138 bytes
ExhibitionSetupTilemap:
	INCBIN "data/bank_03a/lz_5a21.bin" ; $5a21, 217 bytes
ExhibitionSetupAttrmap:
	INCBIN "data/bank_03a/lz_5afa.bin" ; $5afa, 109 bytes
ExhibitionSetupPalettes:
	INCLUDE "data/bank_03a/palettes_5b67.asm" ; $5b67, 64 bytes (palettes)
ExhibitionMenuTiles:
	INCBIN "data/bank_03a/lz_5ba7.bin" ; $5ba7, 1698 bytes
ExhibitionMenuTilemap:
	INCBIN "data/bank_03a/lz_6249.bin" ; $6249, 255 bytes
ExhibitionMenuAttrmap:
	INCBIN "data/bank_03a/lz_6348.bin" ; $6348, 119 bytes
ExhibitionMenuPalettes:
	INCLUDE "data/bank_03a/palettes_63bf.asm" ; $63bf, 64 bytes (palettes)
N64TournamentTiles:
	INCBIN "data/bank_03a/lz_63ff.bin" ; $63ff, 1650 bytes
N64TournamentTilemap:
	INCBIN "data/bank_03a/lz_6a71.bin" ; $6a71, 268 bytes
N64TournamentAttrmap:
	INCBIN "data/bank_03a/lz_6b7d.bin" ; $6b7d, 121 bytes
N64TournamentPalettes:
	INCLUDE "data/bank_03a/palettes_6bf6.asm" ; $6bf6, 64 bytes (palettes)
N64TournamentTilemap2:
	INCBIN "data/bank_03a/lz_6c36.bin" ; $6c36, 268 bytes
N64TournamentAttrmap2:
	INCBIN "data/bank_03a/lz_6d42.bin" ; $6d42, 123 bytes
WarningScreenTiles:
	INCBIN "data/bank_03a/lz_6dbd.bin" ; $6dbd, 631 bytes
WarningScreenTilemap:
	INCBIN "data/bank_03a/lz_7034.bin" ; $7034, 149 bytes
WarningScreenAttrmap:
	INCBIN "data/bank_03a/lz_70c9.bin" ; $70c9, 107 bytes
WarningScreenPalettes:
	INCLUDE "data/bank_03a/palettes_7134.asm" ; $7134, 64 bytes (palettes)
JapanesePlayModeTiles:
	INCBIN "data/bank_03a/lz_7174.bin" ; $7174, 1067 bytes
JapanesePlayModeTilemap:
	INCBIN "data/bank_03a/lz_759f.bin" ; $759f, 166 bytes
JapanesePlayModeAttrmap:
	INCBIN "data/bank_03a/lz_7645.bin" ; $7645, 138 bytes
JapanesePlayModePalettes:
	INCLUDE "data/bank_03a/palettes_76cf.asm" ; $76cf, 64 bytes (palettes)
LinkErrorTiles:
	INCBIN "data/bank_03a/lz_770f.bin" ; $770f, 1376 bytes
LinkErrorTilemap:
	INCBIN "data/bank_03a/lz_7c6f.bin" ; $7c6f, 239 bytes
LinkErrorAttrmap:
	INCBIN "data/bank_03a/lz_7d5e.bin" ; $7d5e, 92 bytes
LinkErrorPalettes:
	INCLUDE "data/bank_03a/palettes_7dba.asm" ; $7dba, 64 bytes (palettes)
LinkErrorLabelTiles:
	INCBIN "data/bank_03a/lz_7dfa.bin" ; $7dfa, 227 bytes
	; $7edd, 291 bytes fill to bank end (linker-padded)
