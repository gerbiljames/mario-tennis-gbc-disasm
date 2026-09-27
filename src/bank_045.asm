SECTION "ROM Bank $45", ROMX[$4000], BANK[$45]

DataPtr_MarkSpriteDesc:
	dw MarkSpriteDesc ; $4000

INCLUDE "src/data/sprites/sprite_45.asm"
