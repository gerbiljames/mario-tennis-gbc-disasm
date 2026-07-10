INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $14", ROMX[$4000], BANK[$14]

	ld [$3940], sp ; $4000
	ld c, d ; $4003
	xor a, h ; $4004
	ld c, a ; $4005
	ld hl, $4a52 ; $4006
	ld b, b ; $4009
	add a, [hl] ; $400a
	ld b, b ; $400b
	ld d, $40 ; $400c
	ld a, [$e640] ; $400e
	ld b, c ; $4011
	rst Rst20 ; $4012
	ld b, c ; $4013
	ld a, b ; $4014
	ld b, d ; $4015
	nop ; $4016
	nop ; $4017
	or a, c ; $4018
	ld a, b ; $4019
	nop ; $401a
	dec hl ; $401b
	nop ; $401c
	inc sp ; $401d
	nop ; $401e
	nop ; $401f
	dec a ; $4020
	ld bc, $0000 ; $4021
	nop ; $4024
	nop ; $4025
	or a, c ; $4026
	ld a, b ; $4027
	nop ; $4028
	dec hl ; $4029
	nop ; $402a
	ld sp, $0000 ; $402b
	dec a ; $402e
	ld bc, $0000 ; $402f
	nop ; $4032
	nop ; $4033
	or a, c ; $4034
	ld a, b ; $4035
	nop ; $4036
	dec l ; $4037
	nop ; $4038
	dec hl ; $4039
	add a, b ; $403a
	nop ; $403b
	ld a, $01 ; $403c
	nop ; $403e
	nop ; $403f
	nop ; $4040
	nop ; $4041
	nop ; $4042
	nop ; $4043
	nop ; $4044
	nop ; $4045
	nop ; $4046
	nop ; $4047
	nop ; $4048
	rst Rst38 ; $4049
	ld bc, $00c0 ; $404a
	dec hl ; $404d
	nop ; $404e
	add hl, sp ; $404f
	ld h, e ; $4050
	ld b, b ; $4051
	dec b ; $4052
	ret nz ; $4053
	nop ; $4054
	jr c, Label_14_4057 ; $4055
Label_14_4057:
	ld [hl], $00 ; $4057
	nop ; $4059
	rlca ; $405a
	ret nz ; $405b
	nop ; $405c
	jr c, Label_14_405f ; $405d
Label_14_405f:
	ld [hl], $00 ; $405f
	nop ; $4061
	rst Rst38 ; $4062
	ld a, [$c295] ; $4063
	cp a, $ff ; $4066
	jp z, Label_14_4085 ; $4068
	rst Rst28 ; $406b
	and a, b ; $406c
	rrca ; $406d
	rst Rst30 ; $406e
	ldh [rTIMA], a ; $406f
	jr z, Label_14_4085 ; $4071
	ld a, $02 ; $4073
	ld bc, $2b00 ; $4075
	ld de, $3b00 ; $4078
	rst Rst18 ; $407b
	ld [hl+], a ; $407c
	ld a, [bc] ; $407d
	ld a, $02 ; $407e
	ld b, $c0 ; $4080
	rst Rst18 ; $4082
	ld l, $0a ; $4083
Label_14_4085:
	ret ; $4085
	INCBIN "data/bank_014/d_4086.bin" ; $4086, 3535 bytes
	ret ; $4e55
	INCBIN "data/bank_014/d_4e56.bin" ; $4e56, 12714 bytes
