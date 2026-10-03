SECTION "ROM Bank $38", ROMX[$4000], BANK[$38]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF DrawCornerBrackets_38_NAME EQUS "Unused_38_DrawCornerBrackets"

; <Label>_SIZE: decoded length of each tile block this bank copies whole through
; LoadCompressedTileBlock (each .inc is generated from its .bin by make)
	INCLUDE "data/bank_039/lz_CharGridGfx2.inc"
	INCLUDE "data/bank_039/lz_CharacterSelectGfx.inc"
	INCLUDE "data/bank_039/lz_DigitFontTiles.inc"
	INCLUDE "data/bank_039/lz_NameEntryGfx.inc"
	INCLUDE "data/bank_039/lz_SharedMenuGfx17.inc"
	INCLUDE "data/bank_039/lz_StatLabelTiles.inc"
	INCLUDE "data/bank_03d/lz_CharGridGfx1.inc"
	INCLUDE "data/bank_03d/lz_SharedMenuGfx72.inc"

INCLUDE "src/engine/menus/menu_38.asm"
INCLUDE "src/engine/menus/matchtype_38.asm"
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
