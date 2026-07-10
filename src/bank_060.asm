INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $60", ROMX[$4000], BANK[$60]

	adc a, c ; $4000
	ld d, b ; $4001
	ld b, b ; $4002
	ld b, b ; $4003
	ld hl, $7d4d ; $4004
	ld c, a ; $4007
	adc a, c ; $4008
	ld d, b ; $4009
	or a, c ; $400a
	ld d, b ; $400b
	reti ; $400c
	INCBIN "data/bank_060/d_400d.bin" ; $400d, 16371 bytes
