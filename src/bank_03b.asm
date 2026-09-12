SECTION "ROM Bank $3b", ROMX[$4000], BANK[$3b]

; decoded lengths of the tile blocks this bank copies whole through LoadCompressedTileBlock
	INCLUDE "data/bank_03c/lz_EraseSavedDataGfx0.inc" ; DEF EraseSavedDataGfx0_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_EraseSavedDataGfx1.inc" ; DEF EraseSavedDataGfx1_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_EraseSavedDataGfx2.inc" ; DEF EraseSavedDataGfx2_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_EraseSavedDataGfx3.inc" ; DEF EraseSavedDataGfx3_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_EraseSavedDataGfx4.inc" ; DEF EraseSavedDataGfx4_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_MainMenuGfx0.inc" ; DEF MainMenuGfx0_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_MainMenuGfx1.inc" ; DEF MainMenuGfx1_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_MainMenuGfx2.inc" ; DEF MainMenuGfx2_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_MainMenuGfx3.inc" ; DEF MainMenuGfx3_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_MainMenuGfx4.inc" ; DEF MainMenuGfx4_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_MinigameSelectGfx0.inc" ; DEF MinigameSelectGfx0_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_MinigameSelectGfx1.inc" ; DEF MinigameSelectGfx1_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_MinigameSelectGfx2.inc" ; DEF MinigameSelectGfx2_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_MinigameSelectGfx3.inc" ; DEF MinigameSelectGfx3_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_MinigameSelectGfx4.inc" ; DEF MinigameSelectGfx4_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_MinigameSelectGfx5.inc" ; DEF MinigameSelectGfx5_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_N64RecordTypeGfx0.inc" ; DEF N64RecordTypeGfx0_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_N64RecordTypeGfx1.inc" ; DEF N64RecordTypeGfx1_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SavedDataSourceGfx0.inc" ; DEF SavedDataSourceGfx0_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SavedDataSourceGfx1.inc" ; DEF SavedDataSourceGfx1_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SavedDataSourceGfx2.inc" ; DEF SavedDataSourceGfx2_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SavedDataSourceGfx3.inc" ; DEF SavedDataSourceGfx3_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx27.inc" ; DEF SharedMenuGfx27_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx29.inc" ; DEF SharedMenuGfx29_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx30.inc" ; DEF SharedMenuGfx30_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx35.inc" ; DEF SharedMenuGfx35_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx36.inc" ; DEF SharedMenuGfx36_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx37.inc" ; DEF SharedMenuGfx37_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx38.inc" ; DEF SharedMenuGfx38_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx39.inc" ; DEF SharedMenuGfx39_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx40.inc" ; DEF SharedMenuGfx40_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx41.inc" ; DEF SharedMenuGfx41_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_MainMenuGfx5.inc" ; DEF MainMenuGfx5_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_MinigameSelectGfx6.inc" ; DEF MinigameSelectGfx6_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_N64RecordTypeGfx2.inc" ; DEF N64RecordTypeGfx2_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_N64TransferItemGfx0.inc" ; DEF N64TransferItemGfx0_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_N64TransferItemGfx1.inc" ; DEF N64TransferItemGfx1_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_N64TransferItemGfx2.inc" ; DEF N64TransferItemGfx2_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_N64TransferItemGfx3.inc" ; DEF N64TransferItemGfx3_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_SavedDataSourceGfx4.inc" ; DEF SavedDataSourceGfx4_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_SharedMenuGfx63.inc" ; DEF SharedMenuGfx63_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_SharedMenuGfx65.inc" ; DEF SharedMenuGfx65_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03e/lz_N64TransferItemGfx4.inc" ; DEF N64TransferItemGfx4_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03e/lz_SavedDataSourceGfx5.inc" ; DEF SavedDataSourceGfx5_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03f/lz_TournamentBracketGfx.inc" ; DEF TournamentBracketGfx_SIZE EQU its decoded length, generated from the .bin by make

INCLUDE "src/engine/menus/slots_3b.asm"
INCLUDE "src/engine/menus/menu_3b.asm"
INCLUDE "src/engine/menus/n64_3b.asm"
INCLUDE "src/engine/menus/n64exhib_3b.asm"
INCLUDE "src/engine/menus/n64trophies_3b.asm"
INCLUDE "src/engine/menus/n64tnmt_3b.asm"
INCLUDE "src/engine/menus/ring_3b.asm"
INCLUDE "src/engine/menus/menu2_3b.asm"
INCLUDE "src/engine/menus/saveslots_3b.asm"
INCLUDE "src/engine/menus/minigame_3b.asm"
INCLUDE "src/engine/menus/saved_3b.asm"
INCLUDE "src/engine/menus/erase_3b.asm"
INCLUDE "src/engine/menus/n64transfer_3b.asm"
INCLUDE "src/engine/menus/bracket_3b.asm"
INCLUDE "src/engine/menus/victory_3b.asm"
