SECTION "ROM Bank $53", ROMX[$4000], BANK[$53]

DataPtr_BowserSpriteDesc:
	dw BowserSpriteDesc ; $4000

INCLUDE "src/data/sprites/bowser_53.asm"
