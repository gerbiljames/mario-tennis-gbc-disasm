SECTION "ROM Bank $39", ROMX[$4000], BANK[$39]

; decoded lengths of the tile blocks this bank copies whole through LoadCompressedTileBlock
	INCLUDE "data/bank_039/lz_NumberSpriteGfxWideGfx.inc" ; DEF NumberSpriteGfxWideGfx_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_039/lz_SharedMenuGfx17.inc" ; DEF SharedMenuGfx17_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_NumberSpriteGfx.inc" ; DEF NumberSpriteGfx_SIZE EQU its decoded length, generated from the .bin by make

INCLUDE "src/engine/menus/slots_39.asm"
INCLUDE "src/engine/menus/animated_39.asm"
INCLUDE "src/engine/menus/menu_39.asm"
INCLUDE "src/engine/menus/map_39.asm"
INCLUDE "src/engine/menus/menu2_39.asm"
