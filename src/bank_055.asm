SECTION "ROM Bank $55", ROMX[$4000], BANK[$55]

DataPtr_WarioSpriteDesc:
	dw WarioSpriteDesc ; $4000

INCLUDE "src/data/sprites/wario_55.asm"
