SECTION "ROM Bank $4d", ROMX[$4000], BANK[$4d]

DataPtr_BrianSpriteDesc:
	dw BrianSpriteDesc ; $4000

INCLUDE "src/data/sprites/brian_4d.asm"
