DataPtr_N64TournamentsIconTiles:
	dw N64TournamentsIconTiles ; $4000
DataPtr_CharacterDataIconTiles:
	dw CharacterDataIconTiles ; $4002
DataPtr_SetItemsIconTiles:
	dw SetItemsIconTiles ; $4004
DataPtr_ClearStatusIconTiles:
	dw ClearStatusIconTiles ; $4006
DataPtr_CharacterDataLabelGfx:
	dw CharacterDataLabelGfx ; $4008
DataPtr_N64TournamentsLabelGfx:
	dw N64TournamentsLabelGfx ; $400a
DataPtr_SetItemsLabelGfx:
	dw SetItemsLabelGfx ; $400c
DataPtr_Erase64IconTiles:
	dw Erase64IconTiles ; $400e
DataPtr_EraseAllIconTiles:
	dw EraseAllIconTiles ; $4010
DataPtr_MainMenuTitleGfx:
	dw MainMenuTitleGfx ; $4012
DataPtr_MainMenuTitleGfxAlias1:
	dw MainMenuTitleGfx ; $4014
DataPtr_MainMenuTitleGfxAlias2:
	dw MainMenuTitleGfx ; $4016
DataPtr_MainMenuTitleGfxAlias3:
	dw MainMenuTitleGfx ; $4018
DataPtr_MainMenuTitleGfxAlias4:
	dw MainMenuTitleGfx ; $401a
DataPtr_PlayMenuTitleGfx:
	dw PlayMenuTitleGfx ; $401c
DataPtr_CourtSelectGfx0:
	dw CourtSelectGfx0 ; $401e
DataPtr_SavedDataTitleGfx:
	dw SavedDataTitleGfx ; $4020
DataPtr_StatusTitleGfx:
	dw StatusTitleGfx ; $4022
DataPtr_N64DataTitleGfx:
	dw N64DataTitleGfx ; $4024
DataPtr_GbDataTitleGfx:
	dw GbDataTitleGfx ; $4026
DataPtr_EraseN64DataTitleGfx:
	dw EraseN64DataTitleGfx ; $4028
DataPtr_EraseAllTitleGfx:
	dw EraseAllTitleGfx ; $402a
DataPtr_MarioMiniGamesTitleGfx:
	dw MarioMiniGamesTitleGfx ; $402c
DataPtr_CreateACharacterTitleGfx:
	dw CreateACharacterTitleGfx ; $402e
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
DataPtr_RacketIconTiles:
	dw RacketIconTiles ; $4054
DataPtr_ShoesIconTiles:
	dw ShoesIconTiles ; $4056
DataPtr_SetItemsTitleGfx:
	dw SetItemsTitleGfx ; $4058
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
N64TournamentsIconTiles:
	INCBIN "data/gfx/lz_N64TournamentsIconTiles.bin" ; $406e, 257 bytes
CharacterDataIconTiles:
	INCBIN "data/gfx/lz_CharacterDataIconTiles.bin" ; $416f, 258 bytes
SetItemsIconTiles:
	INCBIN "data/gfx/lz_SetItemsIconTiles.bin" ; $4271, 256 bytes
ClearStatusIconTiles:
	INCBIN "data/gfx/lz_ClearStatusIconTiles.bin" ; $4371, 246 bytes
CharacterDataLabelGfx:
	INCBIN "data/gfx/lz_CharacterDataLabelGfx.bin" ; $4467, 180 bytes
N64TournamentsLabelGfx:
	INCBIN "data/gfx/lz_N64TournamentsLabelGfx.bin" ; $451b, 195 bytes
SetItemsLabelGfx:
	INCBIN "data/gfx/lz_SetItemsLabelGfx.bin" ; $45de, 164 bytes
Erase64IconTiles:
	INCBIN "data/gfx/lz_Erase64IconTiles.bin" ; $4682, 218 bytes
EraseAllIconTiles:
	INCBIN "data/gfx/lz_EraseAllIconTiles.bin" ; $475c, 212 bytes
MainMenuTitleGfx:
	INCBIN "data/gfx/lz_MainMenuTitleGfx.bin" ; $4830, 179 bytes
PlayMenuTitleGfx:
	INCBIN "data/gfx/lz_PlayMenuTitleGfx.bin" ; $48e3, 187 bytes
CourtSelectGfx0:
	INCBIN "data/gfx/lz_CourtSelectGfx0.bin" ; $499e, 183 bytes
SavedDataTitleGfx:
	INCBIN "data/gfx/lz_SavedDataTitleGfx.bin" ; $4a55, 167 bytes
StatusTitleGfx:
	INCBIN "data/gfx/lz_StatusTitleGfx.bin" ; $4afc, 145 bytes
N64DataTitleGfx:
	INCBIN "data/gfx/lz_N64DataTitleGfx.bin" ; $4b8d, 176 bytes
GbDataTitleGfx:
	INCBIN "data/gfx/lz_GbDataTitleGfx.bin" ; $4c3d, 144 bytes
EraseN64DataTitleGfx:
	INCBIN "data/gfx/lz_EraseN64DataTitleGfx.bin" ; $4ccd, 202 bytes
EraseAllTitleGfx:
	INCBIN "data/gfx/lz_EraseAllTitleGfx.bin" ; $4d97, 163 bytes
MarioMiniGamesTitleGfx:
	INCBIN "data/gfx/lz_MarioMiniGamesTitleGfx.bin" ; $4e3a, 186 bytes
CreateACharacterTitleGfx:
	INCBIN "data/gfx/lz_CreateACharacterTitleGfx.bin" ; $4ef4, 226 bytes
SetItemsTitleGfx:
	INCBIN "data/gfx/lz_SetItemsTitleGfx.bin" ; $4fd6, 157 bytes
CharGridGfx1:
	INCBIN "data/gfx/lz_CharGridGfx1.bin" ; $5073, 213 bytes
LinkingScreenTiles:
	INCBIN "data/gfx/lz_LinkingScreenTiles.bin" ; $5148, 1333 bytes
LinkingScreenTilemap:
	INCBIN "data/gfx/lz_LinkingScreenTilemap.bin" ; $567d, 241 bytes
LinkingScreenAttrmap:
	INCBIN "data/gfx/lz_LinkingScreenAttrmap.bin" ; $576e, 115 bytes
LinkingScreenPalettes:
	INCLUDE "data/gfx/LinkingScreenPalettes.asm" ; $57e1, 64 bytes (palettes)
RingShotHudTiles:
	INCBIN "data/gfx/lz_RingShotHudTiles.bin" ; $5821, 1216 bytes
RingShotHudTilemap:
	INCBIN "data/gfx/lz_RingShotHudTilemap.bin" ; $5ce1, 324 bytes
RingShotHudAttrmap:
	INCBIN "data/gfx/lz_RingShotHudAttrmap.bin" ; $5e25, 133 bytes
RingShotHudPalettes:
	INCLUDE "data/gfx/RingShotHudPalettes.asm" ; $5eaa, 64 bytes (palettes)
NumberSpriteGfx:
	INCBIN "data/gfx/lz_NumberSpriteGfx.bin" ; $5eea, 175 bytes
MatchStatsTiles:
	INCBIN "data/gfx/lz_MatchStatsTiles.bin" ; $5f99, 2148 bytes
MatchStatsTilemap:
	INCBIN "data/gfx/lz_MatchStatsTilemap.bin" ; $67fd, 361 bytes
MatchStatsAttrmap:
	INCBIN "data/gfx/lz_MatchStatsAttrmap.bin" ; $6966, 98 bytes
MatchStatsPalettes:
	INCLUDE "data/gfx/MatchStatsPalettes.asm" ; $69c8, 64 bytes (palettes)
MatchStatsTilemap3:
	INCBIN "data/gfx/lz_MatchStatsTilemap3.bin" ; $6a08, 289 bytes
MatchStatsAttrmap3:
	INCBIN "data/gfx/lz_MatchStatsAttrmap3.bin" ; $6b29, 105 bytes
MatchStatsTilemap2:
	INCBIN "data/gfx/lz_MatchStatsTilemap2.bin" ; $6b92, 332 bytes
MatchStatsAttrmap2:
	INCBIN "data/gfx/lz_MatchStatsAttrmap2.bin" ; $6cde, 91 bytes
RacketIconTiles:
	INCBIN "data/gfx/lz_RacketIconTiles.bin" ; $6d39, 245 bytes
ShoesIconTiles:
	INCBIN "data/gfx/lz_ShoesIconTiles.bin" ; $6e2e, 250 bytes
EquipmentSelectTiles:
	INCBIN "data/gfx/lz_EquipmentSelectTiles.bin" ; $6f28, 2045 bytes
EquipmentSelectTilemap:
	INCBIN "data/gfx/lz_EquipmentSelectTilemap.bin" ; $7725, 161 bytes
EquipmentSelectAttrmap:
	INCBIN "data/gfx/lz_EquipmentSelectAttrmap.bin" ; $77c6, 106 bytes
EquipmentSelectPalettes:
	INCLUDE "data/gfx/EquipmentSelectPalettes.asm" ; $7830, 64 bytes (palettes)
SharedMenuGfx99:
	INCBIN "data/gfx/lz_SharedMenuGfx99.bin" ; $7870, 26 bytes
TournamentBracketSinglesTilemap:
	INCBIN "data/gfx/lz_TournamentBracketSinglesTilemap.bin" ; $788a, 465 bytes
TournamentBracketSinglesAttrmap:
	INCBIN "data/gfx/lz_TournamentBracketSinglesAttrmap.bin" ; $7a5b, 115 bytes
TournamentBracketPalettes:
	INCLUDE "data/gfx/TournamentBracketPalettes.asm" ; $7ace, 64 bytes (palettes)
TournamentBracketDoublesTilemap:
	INCBIN "data/gfx/lz_TournamentBracketDoublesTilemap.bin" ; $7b0e, 331 bytes
TournamentBracketDoublesAttrmap:
	INCBIN "data/gfx/lz_TournamentBracketDoublesAttrmap.bin" ; $7c59, 102 bytes
	; $7cbf, 833 bytes fill to bank end (linker-padded)
