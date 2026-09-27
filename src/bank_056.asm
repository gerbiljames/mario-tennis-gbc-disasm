SECTION "ROM Bank $56", ROMX[$4000], BANK[$56]

DataPtr_JoySpriteDesc:
	dw JoySpriteDesc ; $4000

INCLUDE "src/data/sprites/joy_56.asm"
