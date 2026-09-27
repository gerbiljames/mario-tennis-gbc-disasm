SECTION "ROM Bank $4c", ROMX[$4000], BANK[$4c]

DataPtr_AllieSpriteDesc:
	dw AllieSpriteDesc ; $4000

INCLUDE "src/data/sprites/allie_4c.asm"
