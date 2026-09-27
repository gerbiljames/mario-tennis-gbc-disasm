SECTION "ROM Bank $48", ROMX[$4000], BANK[$48]

DataPtr_SpikeSpriteDesc:
	dw SpikeSpriteDesc ; $4000

INCLUDE "src/data/sprites/spike_48.asm"
