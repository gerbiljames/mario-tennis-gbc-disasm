SECTION "ROM Bank $3e", ROMX[$4000], BANK[$3e]

; The name of each shared-template copy in this bank, for the templates
; that call one another (src/twins): a copy nothing reaches is Unused_<bank>_...
DEF DrawAsciiDigitChar_3e_NAME EQUS "Unused_3e_DrawAsciiDigitChar"
DEF DrawCornerBrackets_3e_NAME EQUS "Unused_3e_DrawCornerBrackets"

; decoded lengths of the tile blocks this bank copies whole through LoadCompressedTileBlock
	INCLUDE "data/bank_039/lz_RacketShoesChoiceGfx0.inc" ; DEF RacketShoesChoiceGfx0_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_039/lz_RacketShoesChoiceGfx1.inc" ; DEF RacketShoesChoiceGfx1_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_039/lz_SharedMenuGfx17.inc" ; DEF SharedMenuGfx17_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx27.inc" ; DEF SharedMenuGfx27_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx35.inc" ; DEF SharedMenuGfx35_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx36.inc" ; DEF SharedMenuGfx36_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx37.inc" ; DEF SharedMenuGfx37_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx38.inc" ; DEF SharedMenuGfx38_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx39.inc" ; DEF SharedMenuGfx39_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx40.inc" ; DEF SharedMenuGfx40_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03c/lz_SharedMenuGfx41.inc" ; DEF SharedMenuGfx41_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_CourtSelectGfx0.inc" ; DEF CourtSelectGfx0_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_EraseDataConfirmGfx0.inc" ; DEF EraseDataConfirmGfx0_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_EraseDataConfirmGfx1.inc" ; DEF EraseDataConfirmGfx1_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_RacketShoesChoiceGfx2.inc" ; DEF RacketShoesChoiceGfx2_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_SharedMenuGfx63.inc" ; DEF SharedMenuGfx63_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_SharedMenuGfx65.inc" ; DEF SharedMenuGfx65_SIZE EQU its decoded length, generated from the .bin by make
	INCLUDE "data/bank_03d/lz_SharedMenuGfx99.inc" ; DEF SharedMenuGfx99_SIZE EQU its decoded length, generated from the .bin by make

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
