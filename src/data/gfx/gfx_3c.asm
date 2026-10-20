DataPtr_ModeSelectTiles:
	dw ModeSelectTiles ; $4000
DataPtr_ModeSelectTilemap:
	dw ModeSelectTilemap ; $4002
DataPtr_ModeSelectAttrmap:
	dw ModeSelectAttrmap ; $4004
DataPtr_ModeSelectPalettes:
	dw ModeSelectPalettes ; $4006
DataPtr_StadiumTiles:
	dw StadiumTiles ; $4008
DataPtr_StadiumTilemap:
	dw StadiumTilemap ; $400a
DataPtr_StadiumAttrmap:
	dw StadiumAttrmap ; $400c
DataPtr_StadiumPalettes:
	dw StadiumPalettes ; $400e
DataPtr_ModeSelectIconGfx:
	dw ModeSelectIconGfx ; $4010
DataPtr_ExhibitionModeIconTiles:
	dw ExhibitionModeIconTiles ; $4012
DataPtr_MarioFaceIconTiles:
	dw MarioFaceIconTiles ; $4014
DataPtr_LinkedPlayIconTiles:
	dw LinkedPlayIconTiles ; $4016
DataPtr_StatusIconTiles:
	dw StatusIconTiles ; $4018
DataPtr_DictionaryIconTiles:
	dw DictionaryIconTiles ; $401a
DataPtr_SavedDataIconTiles:
	dw SavedDataIconTiles ; $401c
DataPtr_EmptyBarTiles:
	dw EmptyBarTiles ; $401e
DataPtr_N64DataIconTiles:
	dw N64DataIconTiles ; $4020
DataPtr_SharedMenuGfx27:
	dw SharedMenuGfx27 ; $4022
DataPtr_MarioTourLabelGfx:
	dw MarioTourLabelGfx ; $4024
DataPtr_ExhibitionLabelGfx:
	dw ExhibitionLabelGfx ; $4026
DataPtr_MarioMiniGamesLabelGfx:
	dw MarioMiniGamesLabelGfx ; $4028
DataPtr_LinkedPlayLabelGfx:
	dw LinkedPlayLabelGfx ; $402a
DataPtr_StatusLabelGfx:
	dw StatusLabelGfx ; $402c
DataPtr_DictionaryLabelGfx:
	dw DictionaryLabelGfx ; $402e
DataPtr_SavedDataLabelGfx:
	dw SavedDataLabelGfx ; $4030
DataPtr_SinglesLabelGfx:
	dw SinglesLabelGfx ; $4032
DataPtr_DoublesLabelGfx:
	dw DoublesLabelGfx ; $4034
DataPtr_TwoGamesLabelGfx:
	dw TwoGamesLabelGfx ; $4036
DataPtr_SixGamesLabelGfx:
	dw SixGamesLabelGfx ; $4038
DataPtr_OneSetLabelGfx:
	dw OneSetLabelGfx ; $403a
DataPtr_ThreeSetsLabelGfx:
	dw ThreeSetsLabelGfx ; $403c
DataPtr_FiveSetsLabelGfx:
	dw FiveSetsLabelGfx ; $403e
DataPtr_File1LabelGfx:
	dw File1LabelGfx ; $4040
DataPtr_File2LabelGfx:
	dw File2LabelGfx ; $4042
DataPtr_File3LabelGfx:
	dw File3LabelGfx ; $4044
DataPtr_N64DataLabelGfx:
	dw N64DataLabelGfx ; $4046
DataPtr_EraseFile1LabelGfx:
	dw EraseFile1LabelGfx ; $4048
DataPtr_EraseFile2LabelGfx:
	dw EraseFile2LabelGfx ; $404a
DataPtr_EraseFile3LabelGfx:
	dw EraseFile3LabelGfx ; $404c
DataPtr_EraseN64DataLabelGfx:
	dw EraseN64DataLabelGfx ; $404e
DataPtr_EraseAllDataLabelGfx:
	dw EraseAllDataLabelGfx ; $4050
DataPtr_MarioNameGfx:
	dw MarioNameGfx ; $4052
DataPtr_WaluigiNameGfx:
	dw WaluigiNameGfx ; $4054
DataPtr_YoshiNameGfx:
	dw YoshiNameGfx ; $4056
DataPtr_BowserNameGfx:
	dw BowserNameGfx ; $4058
DataPtr_WarioNameGfx:
	dw WarioNameGfx ; $405a
DataPtr_PeachNameGfx:
	dw PeachNameGfx ; $405c
DataPtr_TournamentLabelGfx:
	dw TournamentLabelGfx ; $405e
DataPtr_RingShotLabelGfx:
	dw RingShotLabelGfx ; $4060
DataPtr_SinglesIconTiles:
	dw SinglesIconTiles ; $4062
DataPtr_DoublesIconTiles:
	dw DoublesIconTiles ; $4064
DataPtr_TwoGamesLabelTiles:
	dw TwoGamesLabelTiles ; $4066
DataPtr_SixGamesLabelTiles:
	dw SixGamesLabelTiles ; $4068
DataPtr_OneSetLabelTiles:
	dw OneSetLabelTiles ; $406a
DataPtr_ThreeSetsLabelTiles:
	dw ThreeSetsLabelTiles ; $406c
DataPtr_FiveSetsLabelTiles:
	dw FiveSetsLabelTiles ; $406e
DataPtr_CharacterSelectTiles:
	dw CharacterSelectTiles ; $4070
DataPtr_CharacterSelectTilemap:
	dw CharacterSelectTilemap ; $4072
DataPtr_CharacterSelectAttrmap:
	dw CharacterSelectAttrmap ; $4074
DataPtr_CharacterSelectPalettes:
	dw CharacterSelectPalettes ; $4076
DataPtr_TournamentIconTiles:
	dw TournamentIconTiles ; $4078
DataPtr_ExhibitionIconTiles:
	dw ExhibitionIconTiles ; $407a
DataPtr_RingShotIconTiles:
	dw RingShotIconTiles ; $407c
ModeSelectTiles:
	INCBIN "data/gfx/lz_ModeSelectTiles.bin" ; $407e, 1283 bytes
ModeSelectTilemap:
	INCBIN "data/gfx/lz_ModeSelectTilemap.bin" ; $4581, 268 bytes
ModeSelectAttrmap:
	INCBIN "data/gfx/lz_ModeSelectAttrmap.bin" ; $468d, 132 bytes
ModeSelectPalettes:
	INCLUDE "data/gfx/ModeSelectPalettes.asm" ; $4711, 64 bytes (palettes)
StadiumTiles:
	INCBIN "data/gfx/lz_StadiumTiles.bin" ; $4751, 2465 bytes
StadiumTilemap:
	INCBIN "data/gfx/lz_StadiumTilemap.bin" ; $50f2, 500 bytes
StadiumAttrmap:
	INCBIN "data/gfx/lz_StadiumAttrmap.bin" ; $52e6, 107 bytes
StadiumPalettes:
	INCLUDE "data/gfx/StadiumPalettes.asm" ; $5351, 64 bytes (palettes)
ModeSelectIconGfx:
	INCBIN "data/gfx/lz_ModeSelectIconGfx.bin" ; $5391, 71 bytes
ExhibitionModeIconTiles:
	INCBIN "data/gfx/lz_ExhibitionModeIconTiles.bin" ; $53d8, 228 bytes
MarioFaceIconTiles:
	INCBIN "data/gfx/lz_MarioFaceIconTiles.bin" ; $54bc, 248 bytes
LinkedPlayIconTiles:
	INCBIN "data/gfx/lz_LinkedPlayIconTiles.bin" ; $55b4, 235 bytes
StatusIconTiles:
	INCBIN "data/gfx/lz_StatusIconTiles.bin" ; $569f, 243 bytes
DictionaryIconTiles:
	INCBIN "data/gfx/lz_DictionaryIconTiles.bin" ; $5792, 231 bytes
SavedDataIconTiles:
	INCBIN "data/gfx/lz_SavedDataIconTiles.bin" ; $5879, 238 bytes
EmptyBarTiles:
	INCBIN "data/gfx/lz_EmptyBarTiles.bin" ; $5967, 51 bytes
N64DataIconTiles:
	INCBIN "data/gfx/lz_N64DataIconTiles.bin" ; $599a, 268 bytes
SharedMenuGfx27:
	INCBIN "data/gfx/lz_SharedMenuGfx27.bin" ; $5aa6, 29 bytes
MarioTourLabelGfx:
	INCBIN "data/gfx/lz_MarioTourLabelGfx.bin" ; $5ac3, 169 bytes
ExhibitionLabelGfx:
	INCBIN "data/gfx/lz_ExhibitionLabelGfx.bin" ; $5b6c, 159 bytes
MarioMiniGamesLabelGfx:
	INCBIN "data/gfx/lz_MarioMiniGamesLabelGfx.bin" ; $5c0b, 196 bytes
LinkedPlayLabelGfx:
	INCBIN "data/gfx/lz_LinkedPlayLabelGfx.bin" ; $5ccf, 194 bytes
StatusLabelGfx:
	INCBIN "data/gfx/lz_StatusLabelGfx.bin" ; $5d91, 168 bytes
DictionaryLabelGfx:
	INCBIN "data/gfx/lz_DictionaryLabelGfx.bin" ; $5e39, 198 bytes
SavedDataLabelGfx:
	INCBIN "data/gfx/lz_SavedDataLabelGfx.bin" ; $5eff, 195 bytes
SinglesLabelGfx:
	INCBIN "data/gfx/lz_SinglesLabelGfx.bin" ; $5fc2, 168 bytes
DoublesLabelGfx:
	INCBIN "data/gfx/lz_DoublesLabelGfx.bin" ; $606a, 153 bytes
TwoGamesLabelGfx:
	INCBIN "data/gfx/lz_TwoGamesLabelGfx.bin" ; $6103, 165 bytes
SixGamesLabelGfx:
	INCBIN "data/gfx/lz_SixGamesLabelGfx.bin" ; $61a8, 164 bytes
OneSetLabelGfx:
	INCBIN "data/gfx/lz_OneSetLabelGfx.bin" ; $624c, 141 bytes
ThreeSetsLabelGfx:
	INCBIN "data/gfx/lz_ThreeSetsLabelGfx.bin" ; $62d9, 182 bytes
FiveSetsLabelGfx:
	INCBIN "data/gfx/lz_FiveSetsLabelGfx.bin" ; $638f, 177 bytes
File1LabelGfx:
	INCBIN "data/gfx/lz_File1LabelGfx.bin" ; $6440, 143 bytes
File2LabelGfx:
	INCBIN "data/gfx/lz_File2LabelGfx.bin" ; $64cf, 156 bytes
File3LabelGfx:
	INCBIN "data/gfx/lz_File3LabelGfx.bin" ; $656b, 157 bytes
N64DataLabelGfx:
	INCBIN "data/gfx/lz_N64DataLabelGfx.bin" ; $6608, 176 bytes
EraseFile1LabelGfx:
	INCBIN "data/gfx/lz_EraseFile1LabelGfx.bin" ; $66b8, 174 bytes
EraseFile2LabelGfx:
	INCBIN "data/gfx/lz_EraseFile2LabelGfx.bin" ; $6766, 178 bytes
EraseFile3LabelGfx:
	INCBIN "data/gfx/lz_EraseFile3LabelGfx.bin" ; $6818, 176 bytes
EraseN64DataLabelGfx:
	INCBIN "data/gfx/lz_EraseN64DataLabelGfx.bin" ; $68c8, 189 bytes
EraseAllDataLabelGfx:
	INCBIN "data/gfx/lz_EraseAllDataLabelGfx.bin" ; $6985, 181 bytes
MarioNameGfx:
	INCBIN "data/gfx/lz_MarioNameGfx.bin" ; $6a3a, 124 bytes
WaluigiNameGfx:
	INCBIN "data/gfx/lz_WaluigiNameGfx.bin" ; $6ab6, 138 bytes
YoshiNameGfx:
	INCBIN "data/gfx/lz_YoshiNameGfx.bin" ; $6b40, 132 bytes
BowserNameGfx:
	INCBIN "data/gfx/lz_BowserNameGfx.bin" ; $6bc4, 141 bytes
WarioNameGfx:
	INCBIN "data/gfx/lz_WarioNameGfx.bin" ; $6c51, 124 bytes
PeachNameGfx:
	INCBIN "data/gfx/lz_PeachNameGfx.bin" ; $6ccd, 143 bytes
TournamentLabelGfx:
	INCBIN "data/gfx/lz_TournamentLabelGfx.bin" ; $6d5c, 177 bytes
RingShotLabelGfx:
	INCBIN "data/gfx/lz_RingShotLabelGfx.bin" ; $6e0d, 172 bytes
SinglesIconTiles:
	INCBIN "data/gfx/lz_SinglesIconTiles.bin" ; $6eb9, 175 bytes
DoublesIconTiles:
	INCBIN "data/gfx/lz_DoublesIconTiles.bin" ; $6f68, 233 bytes
TwoGamesLabelTiles:
	INCBIN "data/gfx/lz_TwoGamesLabelTiles.bin" ; $7051, 178 bytes
SixGamesLabelTiles:
	INCBIN "data/gfx/lz_SixGamesLabelTiles.bin" ; $7103, 170 bytes
OneSetLabelTiles:
	INCBIN "data/gfx/lz_OneSetLabelTiles.bin" ; $71ad, 189 bytes
ThreeSetsLabelTiles:
	INCBIN "data/gfx/lz_ThreeSetsLabelTiles.bin" ; $726a, 218 bytes
FiveSetsLabelTiles:
	INCBIN "data/gfx/lz_FiveSetsLabelTiles.bin" ; $7344, 215 bytes
CharacterSelectTiles:
	INCBIN "data/gfx/lz_CharacterSelectTiles.bin" ; $741b, 453 bytes
CharacterSelectTilemap:
	INCBIN "data/gfx/lz_CharacterSelectTilemap.bin" ; $75e0, 140 bytes
CharacterSelectAttrmap:
	INCBIN "data/gfx/lz_CharacterSelectAttrmap.bin" ; $766c, 89 bytes
CharacterSelectPalettes:
	INCLUDE "data/gfx/CharacterSelectPalettes.asm" ; $76c5, 64 bytes (palettes)
TournamentIconTiles:
	INCBIN "data/gfx/lz_TournamentIconTiles.bin" ; $7705, 231 bytes
ExhibitionIconTiles:
	INCBIN "data/gfx/lz_ExhibitionIconTiles.bin" ; $77ec, 227 bytes
RingShotIconTiles:
	INCBIN "data/gfx/lz_RingShotIconTiles.bin" ; $78cf, 253 bytes
	; $79cc, 1588 bytes fill to bank end (linker-padded)
