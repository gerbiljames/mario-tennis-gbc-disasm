SECTION "ROM Bank $17", ROMX[$4000], BANK[$17]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ApplySpriteWobbleX_17_NAME EQUS "Unused_17_ApplySpriteWobbleX"
DEF ApplySpriteWobbleY_17_NAME EQUS "ApplySpriteWobbleY_17"
DEF DrawAsciiDigitChar_17_NAME EQUS "Unused_17_DrawAsciiDigitChar"

; <Label>_SIZE: decoded length of each tile block this bank copies whole through
; LoadCompressedTileBlock (each .inc is generated from its .bin by make)
	INCLUDE "data/bank_039/lz_SharedMenuGfx17.inc"

INCLUDE "src/engine/menus/slots_17.asm"
INCLUDE "src/engine/menus/menu_17.asm"
INCLUDE "src/engine/menus/briefing_17.asm"
INCLUDE "src/engine/menus/briefing2_17.asm"
INCLUDE "src/engine/menus/spin_17.asm"
INCLUDE "src/engine/menus/pole_17.asm"
INCLUDE "src/engine/menus/drill_17.asm"
INCLUDE "src/engine/menus/lob_17.asm"
INCLUDE "src/engine/menus/rules_17.asm"
