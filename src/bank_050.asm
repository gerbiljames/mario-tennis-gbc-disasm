SECTION "ROM Bank $50", ROMX[$4000], BANK[$50]

DataPtr_MarioSpriteDesc:
	dw MarioSpriteDesc ; $4000

INCLUDE "src/data/sprites/mario_50.asm"
