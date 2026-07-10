INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $2c", ROMX[$4000], BANK[$2c]

FarPtr_2c_00:
	dw Func_2c_7281 ; $4000
FarPtr_2c_02:
	dw Func_2c_72d3 ; $4002
FarPtr_2c_04:
	dw Func_2c_7325 ; $4004
Func_2c_4006:
	push hl ; $4006
	ld l, e ; $4007
	ld h, d ; $4008
	add hl, hl ; $4009
	add hl, hl ; $400a
	ld l, h ; $400b
	ld h, $00 ; $400c
	ld e, l ; $400e
	ld d, h ; $400f
	add hl, hl ; $4010
	add hl, de ; $4011
	add hl, hl ; $4012
	pop de ; $4013
	add hl, de ; $4014
	ret ; $4015
Func_2c_4016:
	push hl ; $4016
	ld l, e ; $4017
	ld h, d ; $4018
	add hl, hl ; $4019
	add hl, hl ; $401a
	ld l, h ; $401b
	ld h, $00 ; $401c
	add hl, hl ; $401e
	add hl, hl ; $401f
	pop de ; $4020
	add hl, de ; $4021
	ret ; $4022
Func_2c_4023:
	ld a, [$c48e] ; $4023
	ld d, a ; $4026
	ld a, [$c48f] ; $4027
	ld e, a ; $402a
Label_2c_402b:
	push hl ; $402b
	ld a, [hl+] ; $402c
	ld h, [hl] ; $402d
	ld l, a ; $402e
	add hl, bc ; $402f
	pop hl ; $4030
	jr c, Label_2c_4041 ; $4031
	ld a, d ; $4033
	cp a, e ; $4034
	jr nc, Label_2c_4041 ; $4035
	inc d ; $4037
	ld a, $06 ; $4038
	add a, l ; $403a
	ld l, a ; $403b
	jr nc, Label_2c_403f ; $403c
	inc h ; $403e
Label_2c_403f:
	jr Label_2c_402b ; $403f
Label_2c_4041:
	ret ; $4041
Func_2c_4042:
	ld a, [$c48e] ; $4042
	ld d, a ; $4045
	ld a, [$c48f] ; $4046
	ld e, a ; $4049
Label_2c_404a:
	push hl ; $404a
	ld a, [hl+] ; $404b
	ld h, [hl] ; $404c
	ld l, a ; $404d
	add hl, bc ; $404e
	pop hl ; $404f
	jr c, Label_2c_4060 ; $4050
	ld a, d ; $4052
	cp a, e ; $4053
	jr nc, Label_2c_4060 ; $4054
	inc d ; $4056
	ld a, $04 ; $4057
	add a, l ; $4059
	ld l, a ; $405a
	jr nc, Label_2c_405e ; $405b
	inc h ; $405d
Label_2c_405e:
	jr Label_2c_404a ; $405e
Label_2c_4060:
	ret ; $4060
Func_2c_4061:
	ld a, [hl+] ; $4061
	ld c, a ; $4062
	ld a, [hl+] ; $4063
	ld b, a ; $4064
	push bc ; $4065
	ld a, [hl+] ; $4066
	ld c, a ; $4067
	ld a, [hl+] ; $4068
	ld b, a ; $4069
	ld a, [hl+] ; $406a
	ld e, a ; $406b
	ld a, [hl+] ; $406c
	ld d, a ; $406d
	ld a, [$c4a7] ; $406e
	and a, a ; $4071
	jr z, Label_2c_407a ; $4072
	xor a, a ; $4074
	sub a, e ; $4075
	ld e, a ; $4076
	sbc a, a ; $4077
	sub a, d ; $4078
	ld d, a ; $4079
Label_2c_407a:
	ld hl, $c43a ; $407a
	ld a, [hl+] ; $407d
	ld h, [hl] ; $407e
	ld l, a ; $407f
	add hl, de ; $4080
	ld e, l ; $4081
	ld d, h ; $4082
	pop hl ; $4083
	farcall FarPtr_08_26 ; $4084
	ret ; $4087
Func_2c_4088:
	ld a, [hl+] ; $4088
	ld c, a ; $4089
	ld a, [hl+] ; $408a
	ld b, a ; $408b
	push bc ; $408c
	ld a, [hl+] ; $408d
	ld c, a ; $408e
	ld a, [hl+] ; $408f
	ld b, a ; $4090
	ld hl, $c43a ; $4091
	ld a, [hl+] ; $4094
	ld d, [hl] ; $4095
	ld e, a ; $4096
	pop hl ; $4097
	farcall FarPtr_08_26 ; $4098
	ret ; $409b
	INCBIN "data/bank_02c/d_409c.bin" ; $409c, 157 bytes
Func_2c_4139:
	xor a, a ; $4139
	sub a, c ; $413a
	ld c, a ; $413b
	sbc a, a ; $413c
	sub a, b ; $413d
	ld b, a ; $413e
	ld a, [$c48a] ; $413f
	ld e, a ; $4142
	ld a, [$c48b] ; $4143
	ld d, a ; $4146
	call Func_2c_4006 ; $4147
	call Func_2c_4023 ; $414a
	push de ; $414d
	call Func_2c_4061 ; $414e
	pop de ; $4151
	ld h, d ; $4152
	ld l, $00 ; $4153
	sra h ; $4155
	rr l ; $4157
	sra h ; $4159
	rr l ; $415b
	call Func_2c_41f9 ; $415d
	ret ; $4160
	INCBIN "data/bank_02c/d_4161.bin" ; $4161, 108 bytes
Func_2c_41cd:
	xor a, a ; $41cd
	sub a, c ; $41ce
	ld c, a ; $41cf
	sbc a, a ; $41d0
	sub a, b ; $41d1
	ld b, a ; $41d2
	ld a, [$c48a] ; $41d3
	ld e, a ; $41d6
	ld a, [$c48b] ; $41d7
	ld d, a ; $41da
	call Func_2c_4016 ; $41db
	call Func_2c_4042 ; $41de
	push de ; $41e1
	call Func_2c_4088 ; $41e2
	pop de ; $41e5
	ld h, d ; $41e6
	ld l, $00 ; $41e7
	sra h ; $41e9
	rr l ; $41eb
	sra h ; $41ed
	rr l ; $41ef
	call Func_2c_41f9 ; $41f1
	ret ; $41f4
	INCBIN "data/bank_02c/d_41f5.bin" ; $41f5, 4 bytes
Func_2c_41f9:
	ld a, [$c43a] ; $41f9
	ld c, a ; $41fc
	ld a, [$c43b] ; $41fd
	ld b, a ; $4200
	call Func_00_1340 ; $4201
	ld c, l ; $4204
	ld b, h ; $4205
	ld hl, $c402 ; $4206
	ld a, [hl+] ; $4209
	ld h, [hl] ; $420a
	ld l, a ; $420b
	add hl, bc ; $420c
	ld c, l ; $420d
	ld b, h ; $420e
	ld hl, $c450 ; $420f
	ld a, c ; $4212
	ld [hl+], a ; $4213
	ld [hl], b ; $4214
	ld hl, $c406 ; $4215
	ld a, [hl+] ; $4218
	ld h, [hl] ; $4219
	ld l, a ; $421a
	add hl, de ; $421b
	ld e, l ; $421c
	ld d, h ; $421d
	ld hl, $c452 ; $421e
	ld a, e ; $4221
	ld [hl+], a ; $4222
	ld [hl], d ; $4223
	ret ; $4224
	INCBIN "data/bank_02c/d_4225.bin" ; $4225, 43 bytes
Func_2c_4250:
	ld e, l ; $4250
	ld d, h ; $4251
	ld hl, $c40a ; $4252
	ld a, [hl+] ; $4255
	ld h, [hl] ; $4256
	ld l, a ; $4257
	xor a, a ; $4258
	sub a, l ; $4259
	ld l, a ; $425a
	sbc a, a ; $425b
	sub a, h ; $425c
	ld h, a ; $425d
	add hl, hl ; $425e
	add hl, hl ; $425f
	add hl, hl ; $4260
	add hl, hl ; $4261
	ld a, h ; $4262
	and a, $1f ; $4263
	add a, a ; $4265
	ld l, c ; $4266
	ld h, b ; $4267
	add a, l ; $4268
	ld l, a ; $4269
	jr nc, Label_2c_426d ; $426a
	inc h ; $426c
Label_2c_426d:
	ld a, [hl+] ; $426d
	ld h, [hl] ; $426e
	ld l, a ; $426f
	add hl, de ; $4270
	ret ; $4271
	INCBIN "data/bank_02c/d_4272.bin" ; $4272, 12303 bytes
Func_2c_7281:
	farcall FarPtr_07_3a ; $7281
	push bc ; $7284
	ld hl, $4281 ; $7285
	ld bc, $7293 ; $7288
	call Func_2c_4250 ; $728b
	pop bc ; $728e
	call Func_2c_41cd ; $728f
	ret ; $7292
	INCBIN "data/bank_02c/d_7293.bin" ; $7293, 64 bytes
Func_2c_72d3:
	farcall FarPtr_07_3a ; $72d3
	push bc ; $72d6
	ld hl, $4e81 ; $72d7
	ld bc, $72e5 ; $72da
	call Func_2c_4250 ; $72dd
	pop bc ; $72e0
	call Func_2c_4139 ; $72e1
	ret ; $72e4
	INCBIN "data/bank_02c/d_72e5.bin" ; $72e5, 64 bytes
Func_2c_7325:
	farcall FarPtr_07_3a ; $7325
	push bc ; $7328
	ld hl, $6081 ; $7329
	ld bc, $7337 ; $732c
	call Func_2c_4250 ; $732f
	pop bc ; $7332
	call Func_2c_4139 ; $7333
	ret ; $7336
	INCBIN "data/bank_02c/d_7337.bin" ; $7337, 3273 bytes
