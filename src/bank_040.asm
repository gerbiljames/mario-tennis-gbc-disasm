SECTION "ROM Bank $40", ROMX[$4000], BANK[$40]

DataPtr_AlexSpriteDesc:
	dw AlexSpriteDesc ; $4000

INCLUDE "src/data/sprites/alex_40.asm"
