SECTION "ROM Bank $4f", ROMX[$4000], BANK[$4f]

DataPtr_BobSpriteDesc:
	dw BobSpriteDesc ; $4000

INCLUDE "src/data/sprites/bob_4f.asm"
