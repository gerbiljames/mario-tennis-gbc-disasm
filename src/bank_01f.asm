INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $1f", ROMX[$4000], BANK[$1f]

	adc a, e ; $4000
	ld a, d ; $4001
	sub a, e ; $4002
	ld a, d ; $4003
	nop ; $4004
	nop ; $4005
	inc d ; $4006
	nop ; $4007
	ld c, a ; $4008
	nop ; $4009
	adc a, c ; $400a
	nop ; $400b
	rst Rst00 ; $400c
	nop ; $400d
	ld a, [$4800] ; $400e
	ld bc, $0197 ; $4011
	sub a, $01 ; $4014
	dec c ; $4016
	ld [bc], a ; $4017
	ld l, d ; $4018
	ld [bc], a ; $4019
	and a, d ; $401a
	ld [bc], a ; $401b
	ldh [rSC], a ; $401c
	inc d ; $401e
	inc bc ; $401f
	ld [hl-], a ; $4020
	inc bc ; $4021
	sub a, d ; $4022
	inc bc ; $4023
	cp a, a ; $4024
	inc bc ; $4025
	ld sp, hl ; $4026
	inc bc ; $4027
	dec a ; $4028
	inc b ; $4029
	ld [hl], a ; $402a
	inc b ; $402b
	adc a, h ; $402c
	inc b ; $402d
	or a, h ; $402e
	inc b ; $402f
	rst Rst20 ; $4030
	inc b ; $4031
	dec h ; $4032
	dec b ; $4033
	ld c, h ; $4034
	dec b ; $4035
	ld [hl], b ; $4036
	dec b ; $4037
	jp z, Label_00_2905 ; $4038
	ld b, $68 ; $403b
	ld b, $e6 ; $403d
	ld b, $3b ; $403f
	rlca ; $4041
	ld [hl], l ; $4042
	rlca ; $4043
	INCBIN "data/bank_01f/d_4044.bin" ; $4044, 16316 bytes
