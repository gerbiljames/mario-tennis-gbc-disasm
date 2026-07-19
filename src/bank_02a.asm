SECTION "ROM Bank $2a", ROMX[$4000], BANK[$2a]

FarPtr_ShotBallPathServeSlice:
	dw ShotBallPathServeSlice ; $4000
Func_2a_4002:
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
Func_2a_4012:
	push hl ; $4012
	ld l, e ; $4013
	ld h, d ; $4014
	add hl, hl ; $4015
	add hl, hl ; $4016
	ld l, h ; $4017
	ld h, $00 ; $4018
	add hl, hl ; $401a
	add hl, hl ; $401b
	pop de ; $401c
	add hl, de ; $401d
	ret ; $401e
Func_2a_401f:
	ld a, [$c48e] ; $401f
	ld d, a ; $4022
	ld a, [$c48f] ; $4023
	ld e, a ; $4026
Label_2a_4027:
	push hl ; $4027
	ld a, [hl+] ; $4028
	ld h, [hl] ; $4029
	ld l, a ; $402a
	add hl, bc ; $402b
	pop hl ; $402c
	jr c, Label_2a_403d ; $402d
	ld a, d ; $402f
	cp a, e ; $4030
	jr nc, Label_2a_403d ; $4031
	inc d ; $4033
	ld a, $06 ; $4034
	add a, l ; $4036
	ld l, a ; $4037
	jr nc, Label_2a_403b ; $4038
	inc h ; $403a
Label_2a_403b:
	jr Label_2a_4027 ; $403b
Label_2a_403d:
	ret ; $403d
Func_2a_403e:
	ld a, [$c48e] ; $403e
	ld d, a ; $4041
	ld a, [$c48f] ; $4042
	ld e, a ; $4045
Label_2a_4046:
	push hl ; $4046
	ld a, [hl+] ; $4047
	ld h, [hl] ; $4048
	ld l, a ; $4049
	add hl, bc ; $404a
	pop hl ; $404b
	jr c, Label_2a_405c ; $404c
	ld a, d ; $404e
	cp a, e ; $404f
	jr nc, Label_2a_405c ; $4050
	inc d ; $4052
	ld a, $04 ; $4053
	add a, l ; $4055
	ld l, a ; $4056
	jr nc, Label_2a_405a ; $4057
	inc h ; $4059
Label_2a_405a:
	jr Label_2a_4046 ; $405a
Label_2a_405c:
	ret ; $405c
Func_2a_405d:
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
	jr z, Label_2a_4076 ; $406e
	xor a, a ; $4070
	sub a, e ; $4071
	ld e, a ; $4072
	sbc a, a ; $4073
	sub a, d ; $4074
	ld d, a ; $4075
Label_2a_4076:
	ld hl, wShotAimAngle ; $4076
	ld a, [hl+] ; $4079
	ld h, [hl] ; $407a
	ld l, a ; $407b
	add hl, de ; $407c
	ld e, l ; $407d
	ld d, h ; $407e
	pop hl ; $407f
	farcall FarPtr_SetBallVelocityPolar ; $4080
	ret ; $4083
Func_2a_4084:
	ld a, [hl+] ; $4084
	ld c, a ; $4085
	ld a, [hl+] ; $4086
	ld b, a ; $4087
	push bc ; $4088
	ld a, [hl+] ; $4089
	ld c, a ; $408a
	ld a, [hl+] ; $408b
	ld b, a ; $408c
	ld hl, wShotAimAngle ; $408d
	ld a, [hl+] ; $4090
	ld d, [hl] ; $4091
	ld e, a ; $4092
	pop hl ; $4093
	farcall FarPtr_SetBallVelocityPolar ; $4094
	ret ; $4097
Func_2a_4098:
	ld a, [hl+] ; $4098
	ld c, a ; $4099
	ld a, [hl+] ; $409a
	ld b, a ; $409b
	push hl ; $409c
	ld hl, $c476 ; $409d
	ld a, c ; $40a0
	ld [hl+], a ; $40a1
	ld [hl], b ; $40a2
	ld hl, $c434 ; $40a3
	ld a, [hl+] ; $40a6
	ld h, [hl] ; $40a7
	ld l, a ; $40a8
	bit 7, h ; $40a9
	jr z, Label_2a_40b3 ; $40ab
	xor a, a ; $40ad
	sub a, l ; $40ae
	ld l, a ; $40af
	sbc a, a ; $40b0
	sub a, h ; $40b1
	ld h, a ; $40b2
Label_2a_40b3:
	add hl, hl ; $40b3
	ld a, b ; $40b4
	call MulHLByAFrac ; $40b5
	add hl, hl ; $40b8
	add hl, hl ; $40b9
	add hl, bc ; $40ba
	ld c, l ; $40bb
	ld b, h ; $40bc
	pop hl ; $40bd
	push bc ; $40be
	ld a, [hl+] ; $40bf
	ld c, a ; $40c0
	ld a, [hl+] ; $40c1
	ld b, a ; $40c2
	ld a, [hl+] ; $40c3
	ld e, a ; $40c4
	ld a, [hl+] ; $40c5
	ld d, a ; $40c6
	ld a, [$c4a7] ; $40c7
	and a, a ; $40ca
	jr z, Label_2a_40d3 ; $40cb
	xor a, a ; $40cd
	sub a, e ; $40ce
	ld e, a ; $40cf
	sbc a, a ; $40d0
	sub a, d ; $40d1
	ld d, a ; $40d2
Label_2a_40d3:
	ld hl, wShotAimAngle ; $40d3
	ld a, [hl+] ; $40d6
	ld h, [hl] ; $40d7
	ld l, a ; $40d8
	add hl, de ; $40d9
	ld e, l ; $40da
	ld d, h ; $40db
	pop hl ; $40dc
	farcall FarPtr_SetBallVelocityPolar ; $40dd
	ld de, $fd40 ; $40e0
	ld a, [$df0a] ; $40e3
	and a, $02 ; $40e6
	jr z, Label_2a_40f0 ; $40e8
	xor a, a ; $40ea
	sub a, e ; $40eb
	ld e, a ; $40ec
	sbc a, a ; $40ed
	sub a, d ; $40ee
	ld d, a ; $40ef
Label_2a_40f0:
	ld hl, wBallTargetDepth ; $40f0
	ld a, e ; $40f3
	ld [hl+], a ; $40f4
	ld [hl], d ; $40f5
	farcall FarPtr_PredictBallXAtDepth ; $40f6
	ld e, l ; $40f9
	ld d, h ; $40fa
	ld hl, wBallTargetX ; $40fb
	ld a, e ; $40fe
	ld [hl+], a ; $40ff
	ld [hl], d ; $4100
	ret ; $4101
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
	call Func_2a_4002 ; $4110
	push hl ; $4113
	ld a, [hl+] ; $4114
	ld h, [hl] ; $4115
	ld l, a ; $4116
	add hl, bc ; $4117
	ld e, l ; $4118
	ld d, h ; $4119
	pop hl ; $411a
	jp c, Label_2a_41f1 ; $411b
	call Func_2a_401f ; $411e
	push de ; $4121
	call Func_2a_405d ; $4122
	pop de ; $4125
	ld h, d ; $4126
	ld l, $00 ; $4127
	sra h ; $4129
	rr l ; $412b
	sra h ; $412d
	rr l ; $412f
	call Func_2a_41f5 ; $4131
	ret ; $4134
	xor a, a ; $4135
	sub a, c ; $4136
	ld c, a ; $4137
	sbc a, a ; $4138
	sub a, b ; $4139
	ld b, a ; $413a
	ld a, [$c48a] ; $413b
	ld e, a ; $413e
	ld a, [$c48b] ; $413f
	ld d, a ; $4142
	call Func_2a_4002 ; $4143
	call Func_2a_401f ; $4146
	push de ; $4149
	call Func_2a_405d ; $414a
	pop de ; $414d
	ld h, d ; $414e
	ld l, $00 ; $414f
	sra h ; $4151
	rr l ; $4153
	sra h ; $4155
	rr l ; $4157
	call Func_2a_41f5 ; $4159
	ret ; $415c
	push hl ; $415d
	ld hl, wShotAimAngle ; $415e
	ld a, [hl+] ; $4161
	ld b, [hl] ; $4162
	ld c, a ; $4163
	ld hl, $c436 ; $4164
	ld a, [hl+] ; $4167
	ld d, [hl] ; $4168
	ld e, a ; $4169
	ld hl, $c434 ; $416a
	ld a, [hl+] ; $416d
	ld h, [hl] ; $416e
	ld l, a ; $416f
	call VectorLengthFromAngle ; $4170
	ld e, l ; $4173
	ld d, h ; $4174
	ld hl, $c48c ; $4175
	ld a, [hl+] ; $4178
	ld h, [hl] ; $4179
	ld l, a ; $417a
	ld a, l ; $417b
	sub a, e ; $417c
	ld l, a ; $417d
	ld a, h ; $417e
	sbc a, d ; $417f
	ld h, a ; $4180
	jr nc, Label_2a_4189 ; $4181
	ld hl, $c48c ; $4183
	ld a, [hl+] ; $4186
	ld d, [hl] ; $4187
	ld e, a ; $4188
Label_2a_4189:
	pop hl ; $4189
	push de ; $418a
	call Func_2a_4002 ; $418b
	call Func_2a_405d ; $418e
	pop hl ; $4191
	call Func_2a_41f5 ; $4192
	ret ; $4195
	xor a, a ; $4196
	sub a, c ; $4197
	ld c, a ; $4198
	sbc a, a ; $4199
	sub a, b ; $419a
	ld b, a ; $419b
	ld a, [$c48a] ; $419c
	ld e, a ; $419f
	ld a, [$c48b] ; $41a0
	ld d, a ; $41a3
	call Func_2a_4012 ; $41a4
	push hl ; $41a7
	ld a, [hl+] ; $41a8
	ld h, [hl] ; $41a9
	ld l, a ; $41aa
	add hl, bc ; $41ab
	ld e, l ; $41ac
	ld d, h ; $41ad
	pop hl ; $41ae
	jp c, Label_2a_41f1 ; $41af
	call Func_2a_403e ; $41b2
	push de ; $41b5
	call Func_2a_4084 ; $41b6
	pop de ; $41b9
	ld h, d ; $41ba
	ld l, $00 ; $41bb
	sra h ; $41bd
	rr l ; $41bf
	sra h ; $41c1
	rr l ; $41c3
	call Func_2a_41f5 ; $41c5
	ret ; $41c8
	xor a, a ; $41c9
	sub a, c ; $41ca
	ld c, a ; $41cb
	sbc a, a ; $41cc
	sub a, b ; $41cd
	ld b, a ; $41ce
	ld a, [$c48a] ; $41cf
	ld e, a ; $41d2
	ld a, [$c48b] ; $41d3
	ld d, a ; $41d6
	call Func_2a_4012 ; $41d7
	call Func_2a_403e ; $41da
	push de ; $41dd
	call Func_2a_4084 ; $41de
	pop de ; $41e1
	ld h, d ; $41e2
	ld l, $00 ; $41e3
	sra h ; $41e5
	rr l ; $41e7
	sra h ; $41e9
	rr l ; $41eb
	call Func_2a_41f5 ; $41ed
	ret ; $41f0
Label_2a_41f1:
	farcall FarPtr_24_04 ; $41f1
	ret ; $41f4
Func_2a_41f5:
	ld a, [wShotAimAngle] ; $41f5
	ld c, a ; $41f8
	ld a, [$c43b] ; $41f9
	ld b, a ; $41fc
	call MulSinCos ; $41fd
	ld c, l ; $4200
	ld b, h ; $4201
	ld hl, wBallX ; $4202
	ld a, [hl+] ; $4205
	ld h, [hl] ; $4206
	ld l, a ; $4207
	add hl, bc ; $4208
	ld c, l ; $4209
	ld b, h ; $420a
	ld hl, wBallTargetX ; $420b
	ld a, c ; $420e
	ld [hl+], a ; $420f
	ld [hl], b ; $4210
	ld hl, wBallDepth ; $4211
	ld a, [hl+] ; $4214
	ld h, [hl] ; $4215
	ld l, a ; $4216
	add hl, de ; $4217
	ld e, l ; $4218
	ld d, h ; $4219
	ld hl, wBallTargetDepth ; $421a
	ld a, e ; $421d
	ld [hl+], a ; $421e
	ld [hl], d ; $421f
	ret ; $4220
	push hl ; $4221
	push bc ; $4222
	ld hl, wShotAimAngle ; $4223
	ld a, [hl+] ; $4226
	ld b, [hl] ; $4227
	ld c, a ; $4228
	ld hl, wBallDepth ; $4229
	ld a, [hl+] ; $422c
	ld d, [hl] ; $422d
	ld e, a ; $422e
	ld hl, wBallX ; $422f
	ld a, [hl+] ; $4232
	ld h, [hl] ; $4233
	ld l, a ; $4234
	call VectorLengthFromAngle ; $4235
	add hl, hl ; $4238
	ld a, h ; $4239
	and a, $1f ; $423a
	ld [$c472], a ; $423c
	add a, a ; $423f
	pop hl ; $4240
	pop de ; $4241
	add a, l ; $4242
	ld l, a ; $4243
	jr nc, Label_2a_4247 ; $4244
	inc h ; $4246
Label_2a_4247:
	ld a, [hl+] ; $4247
	ld h, [hl] ; $4248
	ld l, a ; $4249
	add hl, de ; $424a
	ret ; $424b
Func_2a_424c:
	ld e, l ; $424c
	ld d, h ; $424d
	ld hl, wBallHeight ; $424e
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
	jr nc, Label_2a_4269 ; $4266
	inc h ; $4268
Label_2a_4269:
	ld a, [hl+] ; $4269
	ld h, [hl] ; $426a
	ld l, a ; $426b
	add hl, de ; $426c
	ret ; $426d
Func_2a_426e:
	ld e, l ; $426e
	ld d, h ; $426f
	add a, a ; $4270
	ld l, c ; $4271
	ld h, b ; $4272
	add a, l ; $4273
	ld l, a ; $4274
	jr nc, Label_2a_4278 ; $4275
	inc h ; $4277
Label_2a_4278:
	ld a, [hl+] ; $4278
	ld h, [hl] ; $4279
	ld l, a ; $427a
	add hl, de ; $427b
	ret ; $427c
BallPosData_2a:
	INCBIN "data/bank_02a/d_427d.bin" ; $427d, 7200 bytes
ShotBallPathServeSlice:
	farcall FarPtr_ComputeShotPlacement ; $5e9d
	ld hl, BallPosData_2a ; $5ea0
	ld bc, BallPosBlockOffsets_2a ; $5ea3
	ld a, [$df6f] ; $5ea6
	call Func_2a_426e ; $5ea9
	ld bc, BallPosSubOffsets_2a ; $5eac
	ld a, [$df6c] ; $5eaf
	call Func_2a_426e ; $5eb2
	ld bc, BallPosHeightOffsets_2a ; $5eb5
	call Func_2a_424c ; $5eb8
	call Func_2a_4098 ; $5ebb
	ret ; $5ebe
BallPosBlockOffsets_2a:
	; $5ebf, 20 bytes (records:2)
	dw $0000 ; record 0
	dw $02d0 ; record 1
	dw $05a0 ; record 2
	dw $0870 ; record 3
	dw $0b40 ; record 4
	dw $0e10 ; record 5
	dw $10e0 ; record 6
	dw $13b0 ; record 7
	dw $1680 ; record 8
	dw $1950 ; record 9
BallPosSubOffsets_2a:
	; $5ed3, 20 bytes (records:2)
	dw $0000 ; record 0
	dw $0048 ; record 1
	dw $0090 ; record 2
	dw $00d8 ; record 3
	dw $0120 ; record 4
	dw $0168 ; record 5
	dw $01b0 ; record 6
	dw $01f8 ; record 7
	dw $0240 ; record 8
	dw $0288 ; record 9
BallPosHeightOffsets_2a:
	; $5ee7, 64 bytes (records:2)
	dw $0000 ; record 0
	dw $0000 ; record 1
	dw $0000 ; record 2
	dw $0000 ; record 3
	dw $0000 ; record 4
	dw $0000 ; record 5
	dw $0000 ; record 6
	dw $0000 ; record 7
	dw $0000 ; record 8
	dw $0000 ; record 9
	dw $0000 ; record 10
	dw $0000 ; record 11
	dw $0006 ; record 12
	dw $000c ; record 13
	dw $0012 ; record 14
	dw $0018 ; record 15
	dw $001e ; record 16
	dw $0024 ; record 17
	dw $002a ; record 18
	dw $0030 ; record 19
	dw $0036 ; record 20
	dw $003c ; record 21
	dw $0042 ; record 22
	dw $0042 ; record 23
	dw $0042 ; record 24
	dw $0042 ; record 25
	dw $0042 ; record 26
	dw $0042 ; record 27
	dw $0042 ; record 28
	dw $0042 ; record 29
	dw $0042 ; record 30
	dw $0042 ; record 31
	ds 8409, $ff ; $5f27, fill
