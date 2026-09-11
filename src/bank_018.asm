SECTION "ROM Bank $18", ROMX[$4000], BANK[$18]

; decoded lengths of the tile blocks this bank copies whole through LoadCompressedTileBlock
	INCLUDE "data/bank_01b/lz_ObjectSceneAGfx0.inc" ; DEF ObjectSceneAGfx0_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_01b/lz_ObjectSceneAGfx1.inc" ; DEF ObjectSceneAGfx1_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_01b/lz_ObjectSceneAGfx2.inc" ; DEF ObjectSceneAGfx2_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_01b/lz_ObjectSceneBGfx0.inc" ; DEF ObjectSceneBGfx0_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_01b/lz_ObjectSceneBGfx1.inc" ; DEF ObjectSceneBGfx1_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_01b/lz_ObjectSceneBGfx2.inc" ; DEF ObjectSceneBGfx2_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_01b/lz_Screen0Gfx.inc" ; DEF Screen0Gfx_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_01b/lz_Screen1ObjGfx.inc" ; DEF Screen1ObjGfx_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_01b/lz_Screen2ObjGfx.inc" ; DEF Screen2ObjGfx_SIZE EQU its decoded length, generated from the .bin by make

INCLUDE "src/engine/menus/slots_18.asm"
INCLUDE "src/engine/menus/bobbing_18.asm"
INCLUDE "src/engine/menus/screen_18.asm"
INCLUDE "src/engine/menus/char_18.asm"
INCLUDE "src/engine/menus/screen2_18.asm"
INCLUDE "src/engine/menus/object_18.asm"
