SECTION "ROM Bank $4b", ROMX[$4000], BANK[$4b]

DataPtr_BCozSpriteDesc:
	dw BCozSpriteDesc ; $4000

INCLUDE "src/data/sprites/coz_4b.asm"
