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
	INCBIN "data/bank_060/d_400d.bin" ; $400d, 1 bytes
DataPtr_60_0e:
	dw Lz_60_4080 ; $400e
	INCBIN "data/bank_060/d_4010.bin" ; $4010, 112 bytes
Lz_60_4080:
	INCBIN "data/bank_060/lz_4080.bin" ; $4080, 3233 bytes
	INCBIN "data/bank_060/d_4d21.bin" ; $4d21, 13023 bytes
