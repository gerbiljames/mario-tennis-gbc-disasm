SECTION "ROM Bank $18", ROMX[$4000], BANK[$18]

; <Label>_SIZE: decoded length of each tile block this bank copies whole through
; LoadCompressedTileBlock (each .inc is generated from its .bin by make)
	INCLUDE "data/bank_01b/lz_ObjectSceneAGfx0.inc"
	INCLUDE "data/bank_01b/lz_ObjectSceneAGfx1.inc"
	INCLUDE "data/bank_01b/lz_ObjectSceneAGfx2.inc"
	INCLUDE "data/bank_01b/lz_ObjectSceneBGfx0.inc"
	INCLUDE "data/bank_01b/lz_ObjectSceneBGfx1.inc"
	INCLUDE "data/bank_01b/lz_ObjectSceneBGfx2.inc"
	INCLUDE "data/bank_01b/lz_Screen0Gfx.inc"
	INCLUDE "data/bank_01b/lz_Screen1ObjGfx.inc"
	INCLUDE "data/bank_01b/lz_Screen2ObjGfx.inc"

INCLUDE "src/engine/menus/slots_18.asm"
INCLUDE "src/engine/menus/cursorbox_18.asm"
INCLUDE "src/engine/menus/prompts_18.asm"
INCLUDE "src/engine/menus/char_18.asm"
INCLUDE "src/engine/menus/sequences_18.asm"
INCLUDE "src/engine/menus/object_18.asm"
