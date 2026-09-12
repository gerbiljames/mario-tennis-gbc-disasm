SECTION "ROM Bank $17", ROMX[$4000], BANK[$17]

; decoded lengths of the tile blocks this bank copies whole through LoadCompressedTileBlock
	INCLUDE "data/bank_039/lz_SharedMenuGfx17.inc" ; DEF SharedMenuGfx17_SIZE EQU its decoded length, generated from the .bin by make

INCLUDE "src/engine/menus/slots_17.asm"
INCLUDE "src/engine/menus/menu_17.asm"
INCLUDE "src/engine/menus/briefing_17.asm"
INCLUDE "src/engine/menus/briefing2_17.asm"
INCLUDE "src/engine/menus/spin_17.asm"
INCLUDE "src/engine/menus/pole_17.asm"
INCLUDE "src/engine/menus/drill_17.asm"
INCLUDE "src/engine/menus/lob_17.asm"
INCLUDE "src/engine/menus/rules_17.asm"
