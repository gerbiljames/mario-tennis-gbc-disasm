SECTION "ROM Bank $1b", ROMX[$4000], BANK[$1b]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF DrawAsciiDigitChar_1b_NAME EQUS "Unused_1b_DrawAsciiDigitChar"
DEF DrawCornerBrackets_1b_NAME EQUS "Unused_1b_DrawCornerBrackets"

; decoded lengths of the tile blocks this bank copies whole through LoadCompressedTileBlock
	INCLUDE "data/bank_03c/lz_SharedMenuGfx27.inc" ; DEF SharedMenuGfx27_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx29.inc" ; DEF SharedMenuGfx29_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx30.inc" ; DEF SharedMenuGfx30_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03f/lz_MinigameLevelSelectGfx2.inc" ; DEF MinigameLevelSelectGfx2_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03f/lz_SavedDataTypeSelectGfx.inc" ; DEF SavedDataTypeSelectGfx_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06d/lz_MinigameLevelSelectGfx0.inc" ; DEF MinigameLevelSelectGfx0_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06d/lz_MinigameLevelSelectGfx1.inc" ; DEF MinigameLevelSelectGfx1_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_06d/lz_SharedMenuGfx111.inc" ; DEF SharedMenuGfx111_SIZE EQU its decoded length, generated from the .bin by make

INCLUDE "src/engine/menus/slots_1b.asm"
INCLUDE "src/engine/menus/menu_1b.asm"
INCLUDE "src/engine/menus/ranking_1b.asm"
INCLUDE "src/engine/menus/ranking2_1b.asm"
INCLUDE "src/engine/menus/ranking3_1b.asm"
INCLUDE "src/engine/menus/char_1b.asm"
INCLUDE "src/engine/menus/debugmenu_1b.asm"
INCLUDE "src/engine/menus/minigame_1b.asm"
INCLUDE "src/engine/menus/minigame2_1b.asm"
INCLUDE "src/engine/menus/minigame3_1b.asm"
INCLUDE "src/engine/menus/minigame4_1b.asm"
