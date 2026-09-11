SECTION "ROM Bank $38", ROMX[$4000], BANK[$38]

; decoded lengths of the tile blocks this bank copies whole through LoadCompressedTileBlock
	INCLUDE "data/bank_039/lz_CharGridGfx2.inc" ; DEF CharGridGfx2_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_039/lz_CharacterSelectGfx.inc" ; DEF CharacterSelectGfx_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_039/lz_DigitFontTiles.inc" ; DEF DigitFontTiles_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_039/lz_NameEntryGfx.inc" ; DEF NameEntryGfx_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_039/lz_SharedMenuGfx17.inc" ; DEF SharedMenuGfx17_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_039/lz_StatLabelTiles.inc" ; DEF StatLabelTiles_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_CharGridGfx1.inc" ; DEF CharGridGfx1_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_SharedMenuGfx72.inc" ; DEF SharedMenuGfx72_SIZE EQU its decoded length, generated from the .bin by make

INCLUDE "src/engine/menus/menu_38.asm"
INCLUDE "src/engine/menus/match_38.asm"
INCLUDE "src/engine/menus/character_38.asm"
INCLUDE "src/engine/menus/char_38.asm"
INCLUDE "src/engine/menus/player_38.asm"
INCLUDE "src/engine/menus/char2_38.asm"
INCLUDE "src/engine/menus/char3_38.asm"
INCLUDE "src/engine/menus/cpu_38.asm"
INCLUDE "src/engine/menus/cpu2_38.asm"
INCLUDE "src/engine/menus/remote_38.asm"
INCLUDE "src/engine/menus/link_38.asm"
INCLUDE "src/engine/menus/name_38.asm"
INCLUDE "src/engine/menus/link2_38.asm"
