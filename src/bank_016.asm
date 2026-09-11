SECTION "ROM Bank $16", ROMX[$4000], BANK[$16]

; decoded lengths of the tile blocks this bank copies whole through LoadCompressedTileBlock
	INCLUDE "data/bank_018/lz_MatchWinLoseGfx.inc" ; DEF MatchWinLoseGfx_SIZE EQU its decoded length, generated from the .bin by make

INCLUDE "src/engine/menus/menu_16.asm"
INCLUDE "src/engine/menus/diagram_16.asm"
INCLUDE "src/engine/menus/result_16.asm"
INCLUDE "src/engine/menus/match_16.asm"
INCLUDE "src/engine/menus/portrait_16.asm"
