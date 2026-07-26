SECTION "ROM Bank $3c", ROMX[$4000], BANK[$3c]

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
DataPtr_ModeSelectLabelTiles0:
	dw ModeSelectLabelTiles0 ; $4012
DataPtr_ModeSelectLabelTiles1:
	dw ModeSelectLabelTiles1 ; $4014
DataPtr_ModeSelectLabelTiles2:
	dw ModeSelectLabelTiles2 ; $4016
DataPtr_ModeSelectLabelTiles3:
	dw ModeSelectLabelTiles3 ; $4018
DataPtr_ModeSelectLabelTiles4:
	dw ModeSelectLabelTiles4 ; $401a
DataPtr_ModeSelectLabelTiles5:
	dw ModeSelectLabelTiles5 ; $401c
DataPtr_ModeSelectLabelTiles6:
	dw ModeSelectLabelTiles6 ; $401e
DataPtr_ModeSelectLabelTiles7:
	dw ModeSelectLabelTiles7 ; $4020
DataPtr_SharedMenuGfx27:
	dw SharedMenuGfx27 ; $4022
DataPtr_MainMenuGfx0:
	dw MainMenuGfx0 ; $4024
DataPtr_SharedMenuGfx29:
	dw SharedMenuGfx29 ; $4026
DataPtr_SharedMenuGfx30:
	dw SharedMenuGfx30 ; $4028
DataPtr_MainMenuGfx1:
	dw MainMenuGfx1 ; $402a
DataPtr_MainMenuGfx2:
	dw MainMenuGfx2 ; $402c
DataPtr_MainMenuGfx3:
	dw MainMenuGfx3 ; $402e
DataPtr_MainMenuGfx4:
	dw MainMenuGfx4 ; $4030
DataPtr_SharedMenuGfx35:
	dw SharedMenuGfx35 ; $4032
DataPtr_SharedMenuGfx36:
	dw SharedMenuGfx36 ; $4034
DataPtr_SharedMenuGfx37:
	dw SharedMenuGfx37 ; $4036
DataPtr_SharedMenuGfx38:
	dw SharedMenuGfx38 ; $4038
DataPtr_SharedMenuGfx39:
	dw SharedMenuGfx39 ; $403a
DataPtr_SharedMenuGfx40:
	dw SharedMenuGfx40 ; $403c
DataPtr_SharedMenuGfx41:
	dw SharedMenuGfx41 ; $403e
DataPtr_SavedDataSourceGfx0:
	dw SavedDataSourceGfx0 ; $4040
DataPtr_SavedDataSourceGfx1:
	dw SavedDataSourceGfx1 ; $4042
DataPtr_SavedDataSourceGfx2:
	dw SavedDataSourceGfx2 ; $4044
DataPtr_SavedDataSourceGfx3:
	dw SavedDataSourceGfx3 ; $4046
DataPtr_EraseSavedDataGfx0:
	dw EraseSavedDataGfx0 ; $4048
DataPtr_EraseSavedDataGfx1:
	dw EraseSavedDataGfx1 ; $404a
DataPtr_EraseSavedDataGfx2:
	dw EraseSavedDataGfx2 ; $404c
DataPtr_EraseSavedDataGfx3:
	dw EraseSavedDataGfx3 ; $404e
DataPtr_EraseSavedDataGfx4:
	dw EraseSavedDataGfx4 ; $4050
DataPtr_MinigameSelectGfx0:
	dw MinigameSelectGfx0 ; $4052
DataPtr_MinigameSelectGfx1:
	dw MinigameSelectGfx1 ; $4054
DataPtr_MinigameSelectGfx2:
	dw MinigameSelectGfx2 ; $4056
DataPtr_MinigameSelectGfx3:
	dw MinigameSelectGfx3 ; $4058
DataPtr_MinigameSelectGfx4:
	dw MinigameSelectGfx4 ; $405a
DataPtr_MinigameSelectGfx5:
	dw MinigameSelectGfx5 ; $405c
DataPtr_N64RecordTypeGfx0:
	dw N64RecordTypeGfx0 ; $405e
DataPtr_N64RecordTypeGfx1:
	dw N64RecordTypeGfx1 ; $4060
DataPtr_N64RecordTypeLabelTiles0:
	dw N64RecordTypeLabelTiles0 ; $4062
DataPtr_N64RecordTypeLabelTiles1:
	dw N64RecordTypeLabelTiles1 ; $4064
DataPtr_GamesLabelTiles:
	dw GamesLabelTiles ; $4066
DataPtr_GamesLabelTiles2:
	dw GamesLabelTiles2 ; $4068
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
DataPtr_CharacterSelectLabelTiles0:
	dw CharacterSelectLabelTiles0 ; $4078
DataPtr_CharacterSelectLabelTiles1:
	dw CharacterSelectLabelTiles1 ; $407a
DataPtr_CharacterSelectLabelTiles2:
	dw CharacterSelectLabelTiles2 ; $407c
ModeSelectTiles:
	INCBIN "data/bank_03c/lz_407e.bin" ; $407e, 1283 bytes
ModeSelectTilemap:
	INCBIN "data/bank_03c/lz_4581.bin" ; $4581, 268 bytes
ModeSelectAttrmap:
	INCBIN "data/bank_03c/lz_468d.bin" ; $468d, 132 bytes
ModeSelectPalettes:
	INCLUDE "data/bank_03c/palettes_4711.asm" ; $4711, 64 bytes (palettes)
StadiumTiles:
	INCBIN "data/bank_03c/lz_4751.bin" ; $4751, 2465 bytes
StadiumTilemap:
	INCBIN "data/bank_03c/lz_50f2.bin" ; $50f2, 500 bytes
StadiumAttrmap:
	INCBIN "data/bank_03c/lz_52e6.bin" ; $52e6, 107 bytes
StadiumPalettes:
	INCLUDE "data/bank_03c/palettes_5351.asm" ; $5351, 64 bytes (palettes)
ModeSelectIconGfx:
	INCBIN "data/bank_03c/lz_5391.bin" ; $5391, 71 bytes
ModeSelectLabelTiles0:
	INCBIN "data/bank_03c/lz_53d8.bin" ; $53d8, 228 bytes
ModeSelectLabelTiles1:
	INCBIN "data/bank_03c/lz_54bc.bin" ; $54bc, 248 bytes
ModeSelectLabelTiles2:
	INCBIN "data/bank_03c/lz_55b4.bin" ; $55b4, 235 bytes
ModeSelectLabelTiles3:
	INCBIN "data/bank_03c/lz_569f.bin" ; $569f, 243 bytes
ModeSelectLabelTiles4:
	INCBIN "data/bank_03c/lz_5792.bin" ; $5792, 231 bytes
ModeSelectLabelTiles5:
	INCBIN "data/bank_03c/lz_5879.bin" ; $5879, 238 bytes
ModeSelectLabelTiles6:
	INCBIN "data/bank_03c/lz_5967.bin" ; $5967, 51 bytes
ModeSelectLabelTiles7:
	INCBIN "data/bank_03c/lz_599a.bin" ; $599a, 268 bytes
SharedMenuGfx27:
	INCBIN "data/bank_03c/lz_5aa6.bin" ; $5aa6, 29 bytes
MainMenuGfx0:
	INCBIN "data/bank_03c/lz_5ac3.bin" ; $5ac3, 169 bytes
SharedMenuGfx29:
	INCBIN "data/bank_03c/lz_5b6c.bin" ; $5b6c, 159 bytes
SharedMenuGfx30:
	INCBIN "data/bank_03c/lz_5c0b.bin" ; $5c0b, 196 bytes
MainMenuGfx1:
	INCBIN "data/bank_03c/lz_5ccf.bin" ; $5ccf, 194 bytes
MainMenuGfx2:
	INCBIN "data/bank_03c/lz_5d91.bin" ; $5d91, 168 bytes
MainMenuGfx3:
	INCBIN "data/bank_03c/lz_5e39.bin" ; $5e39, 198 bytes
MainMenuGfx4:
	INCBIN "data/bank_03c/lz_5eff.bin" ; $5eff, 195 bytes
SharedMenuGfx35:
	INCBIN "data/bank_03c/lz_5fc2.bin" ; $5fc2, 168 bytes
SharedMenuGfx36:
	INCBIN "data/bank_03c/lz_606a.bin" ; $606a, 153 bytes
SharedMenuGfx37:
	INCBIN "data/bank_03c/lz_6103.bin" ; $6103, 165 bytes
SharedMenuGfx38:
	INCBIN "data/bank_03c/lz_61a8.bin" ; $61a8, 164 bytes
SharedMenuGfx39:
	INCBIN "data/bank_03c/lz_624c.bin" ; $624c, 141 bytes
SharedMenuGfx40:
	INCBIN "data/bank_03c/lz_62d9.bin" ; $62d9, 182 bytes
SharedMenuGfx41:
	INCBIN "data/bank_03c/lz_638f.bin" ; $638f, 177 bytes
SavedDataSourceGfx0:
	INCBIN "data/bank_03c/lz_6440.bin" ; $6440, 143 bytes
SavedDataSourceGfx1:
	INCBIN "data/bank_03c/lz_64cf.bin" ; $64cf, 156 bytes
SavedDataSourceGfx2:
	INCBIN "data/bank_03c/lz_656b.bin" ; $656b, 157 bytes
SavedDataSourceGfx3:
	INCBIN "data/bank_03c/lz_6608.bin" ; $6608, 176 bytes
EraseSavedDataGfx0:
	INCBIN "data/bank_03c/lz_66b8.bin" ; $66b8, 174 bytes
EraseSavedDataGfx1:
	INCBIN "data/bank_03c/lz_6766.bin" ; $6766, 178 bytes
EraseSavedDataGfx2:
	INCBIN "data/bank_03c/lz_6818.bin" ; $6818, 176 bytes
EraseSavedDataGfx3:
	INCBIN "data/bank_03c/lz_68c8.bin" ; $68c8, 189 bytes
EraseSavedDataGfx4:
	INCBIN "data/bank_03c/lz_6985.bin" ; $6985, 181 bytes
MinigameSelectGfx0:
	INCBIN "data/bank_03c/lz_6a3a.bin" ; $6a3a, 124 bytes
MinigameSelectGfx1:
	INCBIN "data/bank_03c/lz_6ab6.bin" ; $6ab6, 138 bytes
MinigameSelectGfx2:
	INCBIN "data/bank_03c/lz_6b40.bin" ; $6b40, 132 bytes
MinigameSelectGfx3:
	INCBIN "data/bank_03c/lz_6bc4.bin" ; $6bc4, 141 bytes
MinigameSelectGfx4:
	INCBIN "data/bank_03c/lz_6c51.bin" ; $6c51, 124 bytes
MinigameSelectGfx5:
	INCBIN "data/bank_03c/lz_6ccd.bin" ; $6ccd, 143 bytes
N64RecordTypeGfx0:
	INCBIN "data/bank_03c/lz_6d5c.bin" ; $6d5c, 177 bytes
N64RecordTypeGfx1:
	INCBIN "data/bank_03c/lz_6e0d.bin" ; $6e0d, 172 bytes
N64RecordTypeLabelTiles0:
	INCBIN "data/bank_03c/lz_6eb9.bin" ; $6eb9, 175 bytes
N64RecordTypeLabelTiles1:
	INCBIN "data/bank_03c/lz_6f68.bin" ; $6f68, 233 bytes
GamesLabelTiles:
	INCBIN "data/bank_03c/lz_7051.bin" ; $7051, 178 bytes
GamesLabelTiles2:
	INCBIN "data/bank_03c/lz_7103.bin" ; $7103, 170 bytes
OneSetLabelTiles:
	INCBIN "data/bank_03c/lz_71ad.bin" ; $71ad, 189 bytes
ThreeSetsLabelTiles:
	INCBIN "data/bank_03c/lz_726a.bin" ; $726a, 218 bytes
FiveSetsLabelTiles:
	INCBIN "data/bank_03c/lz_7344.bin" ; $7344, 215 bytes
CharacterSelectTiles:
	INCBIN "data/bank_03c/lz_741b.bin" ; $741b, 453 bytes
CharacterSelectTilemap:
	INCBIN "data/bank_03c/lz_75e0.bin" ; $75e0, 140 bytes
CharacterSelectAttrmap:
	INCBIN "data/bank_03c/lz_766c.bin" ; $766c, 89 bytes
CharacterSelectPalettes:
	INCLUDE "data/bank_03c/palettes_76c5.asm" ; $76c5, 64 bytes (palettes)
CharacterSelectLabelTiles0:
	INCBIN "data/bank_03c/lz_7705.bin" ; $7705, 231 bytes
CharacterSelectLabelTiles1:
	INCBIN "data/bank_03c/lz_77ec.bin" ; $77ec, 227 bytes
CharacterSelectLabelTiles2:
	INCBIN "data/bank_03c/lz_78cf.bin" ; $78cf, 253 bytes
	; $79cc, 1588 bytes fill to bank end (linker-padded)
