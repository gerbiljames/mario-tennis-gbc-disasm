SECTION "ROM Bank $3e", ROMX[$4000], BANK[$3e]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF DrawAsciiDigitChar_3e_NAME EQUS "Unused_3e_DrawAsciiDigitChar"
DEF DrawCornerBrackets_3e_NAME EQUS "Unused_3e_DrawCornerBrackets"

; <Label>_SIZE: decoded length of each tile block this bank copies whole through
; LoadCompressedTileBlock (each .inc is generated from its .bin by make)
	INCLUDE "data/bank_039/lz_RacketShoesChoiceGfx0.inc"
	INCLUDE "data/bank_039/lz_RacketShoesChoiceGfx1.inc"
	INCLUDE "data/bank_039/lz_SharedMenuGfx17.inc"
	INCLUDE "data/bank_03c/lz_SharedMenuGfx27.inc"
	INCLUDE "data/bank_03c/lz_SharedMenuGfx35.inc"
	INCLUDE "data/bank_03c/lz_SharedMenuGfx36.inc"
	INCLUDE "data/bank_03c/lz_SharedMenuGfx37.inc"
	INCLUDE "data/bank_03c/lz_SharedMenuGfx38.inc"
	INCLUDE "data/bank_03c/lz_SharedMenuGfx39.inc"
	INCLUDE "data/bank_03c/lz_SharedMenuGfx40.inc"
	INCLUDE "data/bank_03c/lz_SharedMenuGfx41.inc"
	INCLUDE "data/bank_03d/lz_CourtSelectGfx0.inc"
	INCLUDE "data/bank_03d/lz_EraseDataConfirmGfx0.inc"
	INCLUDE "data/bank_03d/lz_EraseDataConfirmGfx1.inc"
	INCLUDE "data/bank_03d/lz_RacketShoesChoiceGfx2.inc"
	INCLUDE "data/bank_03d/lz_SharedMenuGfx63.inc"
	INCLUDE "data/bank_03d/lz_SharedMenuGfx65.inc"
	INCLUDE "data/bank_03d/lz_SharedMenuGfx99.inc"

INCLUDE "src/engine/menus/slots_3e.asm"
INCLUDE "src/engine/menus/selection_3e.asm"
INCLUDE "src/engine/menus/rules_3e.asm"
INCLUDE "src/engine/menus/linkrules_3e.asm"
INCLUDE "src/engine/menus/racket_3e.asm"
INCLUDE "src/engine/menus/choicetab_3e.asm"
INCLUDE "src/engine/menus/racket2_3e.asm"
INCLUDE "src/engine/menus/equip_3e.asm"
INCLUDE "src/engine/menus/courtselect_3e.asm"
INCLUDE "src/engine/menus/courtselect2_3e.asm"
