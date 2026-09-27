SECTION "ROM Bank $5a", ROMX[$4000], BANK[$5a]

DataPtr_BallMachineSpriteDesc:
	dw BallMachineSpriteDesc ; $4000

INCLUDE "src/data/sprites/ball_5a.asm"
