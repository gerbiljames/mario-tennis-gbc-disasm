SECTION "ROM Bank $3d", ROMX[$4000], BANK[$3d]

DataPtr_N64ItemLabelTiles0:
	dw N64ItemLabelTiles0 ; $4000
DataPtr_N64ItemLabelTiles1:
	dw N64ItemLabelTiles1 ; $4002
DataPtr_N64ItemLabelTiles2:
	dw N64ItemLabelTiles2 ; $4004
DataPtr_N64ItemLabelTiles3:
	dw N64ItemLabelTiles3 ; $4006
DataPtr_N64TransferItemGfx0:
	dw N64TransferItemGfx0 ; $4008
DataPtr_N64TransferItemGfx1:
	dw N64TransferItemGfx1 ; $400a
DataPtr_N64TransferItemGfx2:
	dw N64TransferItemGfx2 ; $400c
DataPtr_N64TransferLabelTiles0:
	dw N64TransferLabelTiles0 ; $400e
DataPtr_N64TransferLabelTiles1:
	dw N64TransferLabelTiles1 ; $4010
DataPtr_MainMenuGfx5:
	dw MainMenuGfx5 ; $4012
DataPtr_MainMenuGfx5Alias1:
	dw MainMenuGfx5 ; $4014
DataPtr_MainMenuGfx5Alias2:
	dw MainMenuGfx5 ; $4016
DataPtr_MainMenuGfx5Alias3:
	dw MainMenuGfx5 ; $4018
DataPtr_MainMenuGfx5Alias4:
	dw MainMenuGfx5 ; $401a
DataPtr_SharedMenuGfx63:
	dw SharedMenuGfx63 ; $401c
DataPtr_CourtSelectGfx0:
	dw CourtSelectGfx0 ; $401e
DataPtr_SharedMenuGfx65:
	dw SharedMenuGfx65 ; $4020
DataPtr_SavedDataSourceGfx4:
	dw SavedDataSourceGfx4 ; $4022
DataPtr_N64RecordTypeGfx2:
	dw N64RecordTypeGfx2 ; $4024
DataPtr_N64TransferItemGfx3:
	dw N64TransferItemGfx3 ; $4026
DataPtr_EraseDataConfirmGfx0:
	dw EraseDataConfirmGfx0 ; $4028
DataPtr_EraseDataConfirmGfx1:
	dw EraseDataConfirmGfx1 ; $402a
DataPtr_MinigameSelectGfx6:
	dw MinigameSelectGfx6 ; $402c
DataPtr_SharedMenuGfx72:
	dw SharedMenuGfx72 ; $402e
DataPtr_CharGridGfx1:
	dw CharGridGfx1 ; $4030
DataPtr_LinkingScreenTiles:
	dw LinkingScreenTiles ; $4032
DataPtr_LinkingScreenTilemap:
	dw LinkingScreenTilemap ; $4034
DataPtr_LinkingScreenAttrmap:
	dw LinkingScreenAttrmap ; $4036
DataPtr_LinkingScreenPalettes:
	dw LinkingScreenPalettes ; $4038
DataPtr_RingShotHudTiles:
	dw RingShotHudTiles ; $403a
DataPtr_RingShotHudTilemap:
	dw RingShotHudTilemap ; $403c
DataPtr_RingShotHudAttrmap:
	dw RingShotHudAttrmap ; $403e
DataPtr_RingShotHudPalettes:
	dw RingShotHudPalettes ; $4040
DataPtr_NumberSpriteGfx:
	dw NumberSpriteGfx ; $4042
DataPtr_MatchStatsTiles:
	dw MatchStatsTiles ; $4044
DataPtr_MatchStatsTilemap:
	dw MatchStatsTilemap ; $4046
DataPtr_MatchStatsAttrmap:
	dw MatchStatsAttrmap ; $4048
DataPtr_MatchStatsPalettes:
	dw MatchStatsPalettes ; $404a
DataPtr_MatchStatsTilemap2:
	dw MatchStatsTilemap2 ; $404c
DataPtr_MatchStatsAttrmap2:
	dw MatchStatsAttrmap2 ; $404e
DataPtr_MatchStatsTilemap3:
	dw MatchStatsTilemap3 ; $4050
DataPtr_MatchStatsAttrmap3:
	dw MatchStatsAttrmap3 ; $4052
DataPtr_MatchStatsLabelTiles0:
	dw MatchStatsLabelTiles0 ; $4054
DataPtr_MatchStatsLabelTiles1:
	dw MatchStatsLabelTiles1 ; $4056
DataPtr_RacketShoesChoiceGfx2:
	dw RacketShoesChoiceGfx2 ; $4058
DataPtr_EquipmentSelectTiles:
	dw EquipmentSelectTiles ; $405a
DataPtr_EquipmentSelectTilemap:
	dw EquipmentSelectTilemap ; $405c
DataPtr_EquipmentSelectAttrmap:
	dw EquipmentSelectAttrmap ; $405e
DataPtr_EquipmentSelectPalettes:
	dw EquipmentSelectPalettes ; $4060
DataPtr_SharedMenuGfx99:
	dw SharedMenuGfx99 ; $4062
DataPtr_TournamentBracketSinglesTilemap:
	dw TournamentBracketSinglesTilemap ; $4064
DataPtr_TournamentBracketSinglesAttrmap:
	dw TournamentBracketSinglesAttrmap ; $4066
DataPtr_TournamentBracketPalettes:
	dw TournamentBracketPalettes ; $4068
DataPtr_TournamentBracketDoublesTilemap:
	dw TournamentBracketDoublesTilemap ; $406a
DataPtr_TournamentBracketDoublesAttrmap:
	dw TournamentBracketDoublesAttrmap ; $406c
N64ItemLabelTiles0:
	INCBIN "data/bank_03d/lz_406e.bin" ; $406e, 257 bytes
N64ItemLabelTiles1:
	INCBIN "data/bank_03d/lz_416f.bin" ; $416f, 258 bytes
N64ItemLabelTiles2:
	INCBIN "data/bank_03d/lz_4271.bin" ; $4271, 256 bytes
N64ItemLabelTiles3:
	INCBIN "data/bank_03d/lz_4371.bin" ; $4371, 246 bytes
N64TransferItemGfx0:
	INCBIN "data/bank_03d/lz_4467.bin" ; $4467, 180 bytes
N64TransferItemGfx1:
	INCBIN "data/bank_03d/lz_451b.bin" ; $451b, 195 bytes
N64TransferItemGfx2:
	INCBIN "data/bank_03d/lz_45de.bin" ; $45de, 164 bytes
N64TransferLabelTiles0:
	INCBIN "data/bank_03d/lz_4682.bin" ; $4682, 218 bytes
N64TransferLabelTiles1:
	INCBIN "data/bank_03d/lz_475c.bin" ; $475c, 212 bytes
MainMenuGfx5:
	INCBIN "data/bank_03d/lz_4830.bin" ; $4830, 179 bytes
SharedMenuGfx63:
	INCBIN "data/bank_03d/lz_48e3.bin" ; $48e3, 187 bytes
CourtSelectGfx0:
	INCBIN "data/bank_03d/lz_499e.bin" ; $499e, 183 bytes
SharedMenuGfx65:
	INCBIN "data/bank_03d/lz_4a55.bin" ; $4a55, 167 bytes
SavedDataSourceGfx4:
	INCBIN "data/bank_03d/lz_4afc.bin" ; $4afc, 145 bytes
N64RecordTypeGfx2:
	INCBIN "data/bank_03d/lz_4b8d.bin" ; $4b8d, 176 bytes
N64TransferItemGfx3:
	INCBIN "data/bank_03d/lz_4c3d.bin" ; $4c3d, 144 bytes
EraseDataConfirmGfx0:
	INCBIN "data/bank_03d/lz_4ccd.bin" ; $4ccd, 202 bytes
EraseDataConfirmGfx1:
	INCBIN "data/bank_03d/lz_4d97.bin" ; $4d97, 163 bytes
MinigameSelectGfx6:
	INCBIN "data/bank_03d/lz_4e3a.bin" ; $4e3a, 186 bytes
SharedMenuGfx72:
	INCBIN "data/bank_03d/lz_4ef4.bin" ; $4ef4, 226 bytes
RacketShoesChoiceGfx2:
	INCBIN "data/bank_03d/lz_4fd6.bin" ; $4fd6, 157 bytes
CharGridGfx1:
	INCBIN "data/bank_03d/lz_5073.bin" ; $5073, 213 bytes
LinkingScreenTiles:
	INCBIN "data/bank_03d/lz_5148.bin" ; $5148, 1333 bytes
LinkingScreenTilemap:
	INCBIN "data/bank_03d/lz_567d.bin" ; $567d, 241 bytes
LinkingScreenAttrmap:
	INCBIN "data/bank_03d/lz_576e.bin" ; $576e, 115 bytes
LinkingScreenPalettes:
	INCLUDE "data/bank_03d/palettes_57e1.asm" ; $57e1, 64 bytes (palettes)
RingShotHudTiles:
	INCBIN "data/bank_03d/lz_5821.bin" ; $5821, 1216 bytes
RingShotHudTilemap:
	INCBIN "data/bank_03d/lz_5ce1.bin" ; $5ce1, 324 bytes
RingShotHudAttrmap:
	INCBIN "data/bank_03d/lz_5e25.bin" ; $5e25, 133 bytes
RingShotHudPalettes:
	INCLUDE "data/bank_03d/palettes_5eaa.asm" ; $5eaa, 64 bytes (palettes)
NumberSpriteGfx:
	INCBIN "data/bank_03d/lz_5eea.bin" ; $5eea, 175 bytes
MatchStatsTiles:
	INCBIN "data/bank_03d/lz_5f99.bin" ; $5f99, 2148 bytes
MatchStatsTilemap:
	INCBIN "data/bank_03d/lz_67fd.bin" ; $67fd, 361 bytes
MatchStatsAttrmap:
	INCBIN "data/bank_03d/lz_6966.bin" ; $6966, 98 bytes
MatchStatsPalettes:
	INCLUDE "data/bank_03d/palettes_69c8.asm" ; $69c8, 64 bytes (palettes)
MatchStatsTilemap3:
	INCBIN "data/bank_03d/lz_6a08.bin" ; $6a08, 289 bytes
MatchStatsAttrmap3:
	INCBIN "data/bank_03d/lz_6b29.bin" ; $6b29, 105 bytes
MatchStatsTilemap2:
	INCBIN "data/bank_03d/lz_6b92.bin" ; $6b92, 332 bytes
MatchStatsAttrmap2:
	INCBIN "data/bank_03d/lz_6cde.bin" ; $6cde, 91 bytes
MatchStatsLabelTiles0:
	INCBIN "data/bank_03d/lz_6d39.bin" ; $6d39, 245 bytes
MatchStatsLabelTiles1:
	INCBIN "data/bank_03d/lz_6e2e.bin" ; $6e2e, 250 bytes
EquipmentSelectTiles:
	INCBIN "data/bank_03d/lz_6f28.bin" ; $6f28, 2045 bytes
EquipmentSelectTilemap:
	INCBIN "data/bank_03d/lz_7725.bin" ; $7725, 161 bytes
EquipmentSelectAttrmap:
	INCBIN "data/bank_03d/lz_77c6.bin" ; $77c6, 106 bytes
EquipmentSelectPalettes:
	INCLUDE "data/bank_03d/palettes_7830.asm" ; $7830, 64 bytes (palettes)
SharedMenuGfx99:
	INCBIN "data/bank_03d/lz_7870.bin" ; $7870, 26 bytes
TournamentBracketSinglesTilemap:
	INCBIN "data/bank_03d/lz_788a.bin" ; $788a, 465 bytes
TournamentBracketSinglesAttrmap:
	INCBIN "data/bank_03d/lz_7a5b.bin" ; $7a5b, 115 bytes
TournamentBracketPalettes:
	INCLUDE "data/bank_03d/palettes_7ace.asm" ; $7ace, 64 bytes (palettes)
TournamentBracketDoublesTilemap:
	INCBIN "data/bank_03d/lz_7b0e.bin" ; $7b0e, 331 bytes
TournamentBracketDoublesAttrmap:
	INCBIN "data/bank_03d/lz_7c59.bin" ; $7c59, 102 bytes
	; $7cbf, 833 bytes fill to bank end (linker-padded)
