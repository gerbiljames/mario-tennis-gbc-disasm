SECTION "ROM Bank $5b", ROMX[$4000], BANK[$5b]

DataPtr_LuigiSpriteDesc:
	dw LuigiSpriteDesc ; $4000

INCLUDE "src/data/sprites/luigi_5b.asm"
