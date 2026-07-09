INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $2c", ROMX[$4000], BANK[$2c]

	INCBIN "data/bank_02c/d_4000.bin" ; $4000, 6 bytes
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
	INCBIN "data/bank_02c/d_4016.bin" ; $4016, 13 bytes
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
	INCBIN "data/bank_02c/d_4042.bin" ; $4042, 31 bytes
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
	rst Rst18 ; $4084
	ld h, $08 ; $4085
	ret ; $4087
	INCBIN "data/bank_02c/d_4088.bin" ; $4088, 177 bytes
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
	INCBIN "data/bank_02c/d_4161.bin" ; $4161, 152 bytes
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
	INCBIN "data/bank_02c/d_4272.bin" ; $4272, 12385 bytes
	rst Rst18 ; $72d3
	ld a, [hl-] ; $72d4
	rlca ; $72d5
	push bc ; $72d6
	ld hl, $4e81 ; $72d7
	ld bc, $72e5 ; $72da
	call Func_2c_4250 ; $72dd
	pop bc ; $72e0
	call Func_2c_4139 ; $72e1
	ret ; $72e4
	INCBIN "data/bank_02c/d_72e5.bin" ; $72e5, 67 bytes
	push bc ; $7328
	ld hl, $6081 ; $7329
	ld bc, $7337 ; $732c
	call Func_2c_4250 ; $732f
	pop bc ; $7332
	call Func_2c_4139 ; $7333
	ret ; $7336
	INCBIN "data/bank_02c/d_7337.bin" ; $7337, 3273 bytes
