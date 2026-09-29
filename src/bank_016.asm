SECTION "ROM Bank $16", ROMX[$4000], BANK[$16]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF ApplySpriteWobbleX_16_NAME EQUS "Unused_16_ApplySpriteWobbleX"
DEF ApplySpriteWobbleY_16_NAME EQUS "Unused_16_ApplySpriteWobbleY"
DEF DrawAsciiDigitChar_16_NAME EQUS "Unused_16_DrawAsciiDigitChar"

; decoded lengths of the tile blocks this bank copies whole through LoadCompressedTileBlock
	INCLUDE "data/bank_018/lz_MatchWinLoseGfx.inc" ; DEF MatchWinLoseGfx_SIZE EQU its decoded length, generated from the .bin by make

INCLUDE "src/engine/menus/menu_16.asm"
INCLUDE "src/engine/menus/diagram_16.asm"
INCLUDE "src/engine/menus/result_16.asm"
INCLUDE "src/engine/menus/match_16.asm"
INCLUDE "src/engine/menus/winlose_16.asm"
