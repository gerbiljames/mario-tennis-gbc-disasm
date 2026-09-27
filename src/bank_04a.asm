SECTION "ROM Bank $4a", ROMX[$4000], BANK[$4a]

DataPtr_ACozSpriteDesc:
	dw ACozSpriteDesc ; $4000

INCLUDE "src/data/sprites/coz_4a.asm"
