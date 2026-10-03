SECTION "ROM Bank $39", ROMX[$4000], BANK[$39]

; <Label>_SIZE: decoded length of each tile block this bank copies whole through
; LoadCompressedTileBlock (each .inc is generated from its .bin by make)
	INCLUDE "data/bank_039/lz_NumberSpriteGfxWideGfx.inc"
	INCLUDE "data/bank_039/lz_SharedMenuGfx17.inc"
	INCLUDE "data/bank_03d/lz_NumberSpriteGfx.inc"

INCLUDE "src/engine/menus/slots_39.asm"
INCLUDE "src/engine/menus/animated_39.asm"
INCLUDE "src/engine/menus/menu_39.asm"
INCLUDE "src/engine/menus/assets_39.asm"
INCLUDE "src/engine/menus/menu2_39.asm"
