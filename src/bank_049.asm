SECTION "ROM Bank $49", ROMX[$4000], BANK[$49]

DataPtr_EldenSpriteDesc:
	dw EldenSpriteDesc ; $4000

INCLUDE "src/data/sprites/elden_49.asm"
