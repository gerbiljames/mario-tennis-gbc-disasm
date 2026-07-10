INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $22", ROMX[$4000], BANK[$22]

FarPtr_22_00:
	dw Func_22_7e7d ; $4000
Func_22_4002:
	push hl ; $4002
	ld l, e ; $4003
	ld h, d ; $4004
	add hl, hl ; $4005
	add hl, hl ; $4006
	ld l, h ; $4007
	ld h, $00 ; $4008
	ld e, l ; $400a
	ld d, h ; $400b
	add hl, hl ; $400c
	add hl, de ; $400d
	add hl, hl ; $400e
	pop de ; $400f
	add hl, de ; $4010
	ret ; $4011
	INCBIN "data/bank_022/d_4012.bin" ; $4012, 13 bytes
Func_22_401f:
	ld a, [$c48e] ; $401f
	ld d, a ; $4022
	ld a, [$c48f] ; $4023
	ld e, a ; $4026
Label_22_4027:
	push hl ; $4027
	ld a, [hl+] ; $4028
	ld h, [hl] ; $4029
	ld l, a ; $402a
	add hl, bc ; $402b
	pop hl ; $402c
	jr c, Label_22_403d ; $402d
	ld a, d ; $402f
	cp a, e ; $4030
	jr nc, Label_22_403d ; $4031
	inc d ; $4033
	ld a, $06 ; $4034
	add a, l ; $4036
	ld l, a ; $4037
	jr nc, Label_22_403b ; $4038
	inc h ; $403a
Label_22_403b:
	jr Label_22_4027 ; $403b
Label_22_403d:
	ret ; $403d
	INCBIN "data/bank_022/d_403e.bin" ; $403e, 31 bytes
Func_22_405d:
	ld a, [hl+] ; $405d
	ld c, a ; $405e
	ld a, [hl+] ; $405f
	ld b, a ; $4060
	push bc ; $4061
	ld a, [hl+] ; $4062
	ld c, a ; $4063
	ld a, [hl+] ; $4064
	ld b, a ; $4065
	ld a, [hl+] ; $4066
	ld e, a ; $4067
	ld a, [hl+] ; $4068
	ld d, a ; $4069
	ld a, [$c4a7] ; $406a
	and a, a ; $406d
	jr z, Label_22_4076 ; $406e
	xor a, a ; $4070
	sub a, e ; $4071
	ld e, a ; $4072
	sbc a, a ; $4073
	sub a, d ; $4074
	ld d, a ; $4075
Label_22_4076:
	ld hl, $c43a ; $4076
	ld a, [hl+] ; $4079
	ld h, [hl] ; $407a
	ld l, a ; $407b
	add hl, de ; $407c
	ld e, l ; $407d
	ld d, h ; $407e
	pop hl ; $407f
	farcall FarPtr_08_26 ; $4080
	ret ; $4083
	INCBIN "data/bank_022/d_4084.bin" ; $4084, 126 bytes
Func_22_4102:
	xor a, a ; $4102
	sub a, c ; $4103
	ld c, a ; $4104
	sbc a, a ; $4105
	sub a, b ; $4106
	ld b, a ; $4107
	ld a, [$c48a] ; $4108
	ld e, a ; $410b
	ld a, [$c48b] ; $410c
	ld d, a ; $410f
	call Func_22_4002 ; $4110
	push hl ; $4113
	ld a, [hl+] ; $4114
	ld h, [hl] ; $4115
	ld l, a ; $4116
	add hl, bc ; $4117
	ld e, l ; $4118
	ld d, h ; $4119
	pop hl ; $411a
	jp c, Label_22_41f1 ; $411b
	call Func_22_401f ; $411e
	push de ; $4121
	call Func_22_405d ; $4122
	pop de ; $4125
	ld h, d ; $4126
	ld l, $00 ; $4127
	sra h ; $4129
	rr l ; $412b
	sra h ; $412d
	rr l ; $412f
	call Func_22_41f5 ; $4131
	ret ; $4134
	INCBIN "data/bank_022/d_4135.bin" ; $4135, 188 bytes
Label_22_41f1:
	farcall FarPtr_24_04 ; $41f1
	ret ; $41f4
Func_22_41f5:
	ld a, [$c43a] ; $41f5
	ld c, a ; $41f8
	ld a, [$c43b] ; $41f9
	ld b, a ; $41fc
	call Func_00_1340 ; $41fd
	ld c, l ; $4200
	ld b, h ; $4201
	ld hl, $c402 ; $4202
	ld a, [hl+] ; $4205
	ld h, [hl] ; $4206
	ld l, a ; $4207
	add hl, bc ; $4208
	ld c, l ; $4209
	ld b, h ; $420a
	ld hl, $c450 ; $420b
	ld a, c ; $420e
	ld [hl+], a ; $420f
	ld [hl], b ; $4210
	ld hl, $c406 ; $4211
	ld a, [hl+] ; $4214
	ld h, [hl] ; $4215
	ld l, a ; $4216
	add hl, de ; $4217
	ld e, l ; $4218
	ld d, h ; $4219
	ld hl, $c452 ; $421a
	ld a, e ; $421d
	ld [hl+], a ; $421e
	ld [hl], d ; $421f
	ret ; $4220
	INCBIN "data/bank_022/d_4221.bin" ; $4221, 43 bytes
Func_22_424c:
	ld e, l ; $424c
	ld d, h ; $424d
	ld hl, $c40a ; $424e
	ld a, [hl+] ; $4251
	ld h, [hl] ; $4252
	ld l, a ; $4253
	xor a, a ; $4254
	sub a, l ; $4255
	ld l, a ; $4256
	sbc a, a ; $4257
	sub a, h ; $4258
	ld h, a ; $4259
	add hl, hl ; $425a
	add hl, hl ; $425b
	add hl, hl ; $425c
	add hl, hl ; $425d
	ld a, h ; $425e
	and a, $1f ; $425f
	add a, a ; $4261
	ld l, c ; $4262
	ld h, b ; $4263
	add a, l ; $4264
	ld l, a ; $4265
	jr nc, Label_22_4269 ; $4266
	inc h ; $4268
Label_22_4269:
	ld a, [hl+] ; $4269
	ld h, [hl] ; $426a
	ld l, a ; $426b
	add hl, de ; $426c
	ret ; $426d
Func_22_426e:
	ld e, l ; $426e
	ld d, h ; $426f
	add a, a ; $4270
	ld l, c ; $4271
	ld h, b ; $4272
	add a, l ; $4273
	ld l, a ; $4274
	jr nc, Label_22_4278 ; $4275
	inc h ; $4277
Label_22_4278:
	ld a, [hl+] ; $4278
	ld h, [hl] ; $4279
	ld l, a ; $427a
	add hl, de ; $427b
	ret ; $427c
	INCBIN "data/bank_022/d_427d.bin" ; $427d, 15360 bytes
Func_22_7e7d:
	farcall FarPtr_07_3a ; $7e7d
	push bc ; $7e80
	ld hl, $427d ; $7e81
	ld bc, $7e98 ; $7e84
	call Func_22_424c ; $7e87
	ld bc, $7ed8 ; $7e8a
	ld a, [$df6e] ; $7e8d
	call Func_22_426e ; $7e90
	pop bc ; $7e93
	call Func_22_4102 ; $7e94
	ret ; $7e97
	INCBIN "data/bank_022/d_7e98.bin" ; $7e98, 360 bytes
