SECTION "ROM Bank $22", ROMX[$4000], BANK[$22]

	farptr ShotBallPathTopspin ; $4000
BallTrajEntryPtr6_22:
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
BallTrajEntryPtr4_22:
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
SeekBallTrajEntry6_22:
	ld a, [wShotTrajRowMin] ; $401f
	ld d, a ; $4022
	ld a, [wShotTrajRowMax] ; $4023
	ld e, a ; $4026
.loop:
	push hl ; $4027
	ld a, [hl+] ; $4028
	ld h, [hl] ; $4029
	ld l, a ; $402a
	add hl, bc ; $402b
	pop hl ; $402c
	jr c, .done ; $402d
	ld a, d ; $402f
	cp a, e ; $4030
	jr nc, .done ; $4031
	inc d ; $4033
	ld a, $06 ; $4034
	add a, l ; $4036
	ld l, a ; $4037
	jr nc, .gotPtr ; $4038
	inc h ; $403a
.gotPtr:
	jr .loop ; $403b
.done:
	ret ; $403d
SeekBallTrajEntry4_22:
	ld a, [wShotTrajRowMin] ; $403e
	ld d, a ; $4041
	ld a, [wShotTrajRowMax] ; $4042
	ld e, a ; $4045
.loop:
	push hl ; $4046
	ld a, [hl+] ; $4047
	ld h, [hl] ; $4048
	ld l, a ; $4049
	add hl, bc ; $404a
	pop hl ; $404b
	jr c, .done ; $404c
	ld a, d ; $404e
	cp a, e ; $404f
	jr nc, .done ; $4050
	inc d ; $4052
	ld a, $04 ; $4053
	add a, l ; $4055
	ld l, a ; $4056
	jr nc, .gotPtr ; $4057
	inc h ; $4059
.gotPtr:
	jr .loop ; $405a
.done:
	ret ; $405c
SetBallVelocityFromEntry6_22:
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
	ld a, [wShotAimMirror] ; $406a
	and a, a ; $406d
	jr z, .zero ; $406e
	xor a, a ; $4070
	sub a, e ; $4071
	ld e, a ; $4072
	sbc a, a ; $4073
	sub a, d ; $4074
	ld d, a ; $4075
.zero:
	ld hl, wShotAimAngle ; $4076
	ld a, [hl+] ; $4079
	ld h, [hl] ; $407a
	ld l, a ; $407b
	add hl, de ; $407c
	ld e, l ; $407d
	ld d, h ; $407e
	pop hl ; $407f
	farcall SetBallVelocityPolar ; $4080
	ret ; $4083
SetBallVelocityFromEntry4_22:
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
	farcall SetBallVelocityPolar ; $4094
	ret ; $4097
	ld a, [hl+] ; $4098
	ld c, a ; $4099
	ld a, [hl+] ; $409a
	ld b, a ; $409b
	push hl ; $409c
	ld hl, $c476 ; $409d
	ld a, c ; $40a0
	ld [hl+], a ; $40a1
	ld [hl], b ; $40a2
	ld hl, wShotAimDeltaX ; $40a3
	ld a, [hl+] ; $40a6
	ld h, [hl] ; $40a7
	ld l, a ; $40a8
	bit 7, h ; $40a9
	jr z, .offset ; $40ab
	xor a, a ; $40ad
	sub a, l ; $40ae
	ld l, a ; $40af
	sbc a, a ; $40b0
	sub a, h ; $40b1
	ld h, a ; $40b2
.offset:
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
	ld a, [wShotAimMirror] ; $40c7
	and a, a ; $40ca
	jr z, .zero ; $40cb
	xor a, a ; $40cd
	sub a, e ; $40ce
	ld e, a ; $40cf
	sbc a, a ; $40d0
	sub a, d ; $40d1
	ld d, a ; $40d2
.zero:
	ld hl, wShotAimAngle ; $40d3
	ld a, [hl+] ; $40d6
	ld h, [hl] ; $40d7
	ld l, a ; $40d8
	add hl, de ; $40d9
	ld e, l ; $40da
	ld d, h ; $40db
	pop hl ; $40dc
	farcall SetBallVelocityPolar ; $40dd
	ld de, $fd40 ; $40e0
	ld a, [wCharCourtPos] ; $40e3
	and a, $02 ; $40e6
	jr z, .maskClear ; $40e8
	xor a, a ; $40ea
	sub a, e ; $40eb
	ld e, a ; $40ec
	sbc a, a ; $40ed
	sub a, d ; $40ee
	ld d, a ; $40ef
.maskClear:
	ld hl, wBallTargetDepth ; $40f0
	ld a, e ; $40f3
	ld [hl+], a ; $40f4
	ld [hl], d ; $40f5
	farcall PredictBallXAtDepth ; $40f6
	ld e, l ; $40f9
	ld d, h ; $40fa
	ld hl, wBallTargetX ; $40fb
	ld a, e ; $40fe
	ld [hl+], a ; $40ff
	ld [hl], d ; $4100
	ret ; $4101
ApplyBallTrajectory_22:
	xor a, a ; $4102
	sub a, c ; $4103
	ld c, a ; $4104
	sbc a, a ; $4105
	sub a, b ; $4106
	ld b, a ; $4107
	ld a, [wShotDistMin] ; $4108
	ld e, a ; $410b
	ld a, [wShotDistMin + 1] ; $410c
	ld d, a ; $410f
	call BallTrajEntryPtr6_22 ; $4110
	push hl ; $4113
	ld a, [hl+] ; $4114
	ld h, [hl] ; $4115
	ld l, a ; $4116
	add hl, bc ; $4117
	ld e, l ; $4118
	ld d, h ; $4119
	pop hl ; $411a
	jp c, .applyFallbackBallTrajectory ; $411b
	call SeekBallTrajEntry6_22 ; $411e
	push de ; $4121
	call SetBallVelocityFromEntry6_22 ; $4122
	pop de ; $4125
	ld h, d ; $4126
	ld l, $00 ; $4127
	sra h ; $4129
	rr l ; $412b
	sra h ; $412d
	rr l ; $412f
	call SetBallTargetFromAim_22 ; $4131
	ret ; $4134
	xor a, a ; $4135
	sub a, c ; $4136
	ld c, a ; $4137
	sbc a, a ; $4138
	sub a, b ; $4139
	ld b, a ; $413a
	ld a, [wShotDistMin] ; $413b
	ld e, a ; $413e
	ld a, [wShotDistMin + 1] ; $413f
	ld d, a ; $4142
	call BallTrajEntryPtr6_22 ; $4143
	call SeekBallTrajEntry6_22 ; $4146
	push de ; $4149
	call SetBallVelocityFromEntry6_22 ; $414a
	pop de ; $414d
	ld h, d ; $414e
	ld l, $00 ; $414f
	sra h ; $4151
	rr l ; $4153
	sra h ; $4155
	rr l ; $4157
	call SetBallTargetFromAim_22 ; $4159
	ret ; $415c
	push hl ; $415d
	ld hl, wShotAimAngle ; $415e
	ld a, [hl+] ; $4161
	ld b, [hl] ; $4162
	ld c, a ; $4163
	ld hl, wShotAimDeltaDepth ; $4164
	ld a, [hl+] ; $4167
	ld d, [hl] ; $4168
	ld e, a ; $4169
	ld hl, wShotAimDeltaX ; $416a
	ld a, [hl+] ; $416d
	ld h, [hl] ; $416e
	ld l, a ; $416f
	call VectorLengthFromAngle ; $4170
	ld e, l ; $4173
	ld d, h ; $4174
	ld hl, wShotDistMax ; $4175
	ld a, [hl+] ; $4178
	ld h, [hl] ; $4179
	ld l, a ; $417a
	ld a, l ; $417b
	sub a, e ; $417c
	ld l, a ; $417d
	ld a, h ; $417e
	sbc a, d ; $417f
	ld h, a ; $4180
	jr nc, .restore ; $4181
	ld hl, wShotDistMax ; $4183
	ld a, [hl+] ; $4186
	ld d, [hl] ; $4187
	ld e, a ; $4188
.restore:
	pop hl ; $4189
	push de ; $418a
	call BallTrajEntryPtr6_22 ; $418b
	call SetBallVelocityFromEntry6_22 ; $418e
	pop hl ; $4191
	call SetBallTargetFromAim_22 ; $4192
	ret ; $4195
	xor a, a ; $4196
	sub a, c ; $4197
	ld c, a ; $4198
	sbc a, a ; $4199
	sub a, b ; $419a
	ld b, a ; $419b
	ld a, [wShotDistMin] ; $419c
	ld e, a ; $419f
	ld a, [wShotDistMin + 1] ; $41a0
	ld d, a ; $41a3
	call BallTrajEntryPtr4_22 ; $41a4
	push hl ; $41a7
	ld a, [hl+] ; $41a8
	ld h, [hl] ; $41a9
	ld l, a ; $41aa
	add hl, bc ; $41ab
	ld e, l ; $41ac
	ld d, h ; $41ad
	pop hl ; $41ae
	jp c, .applyFallbackBallTrajectory ; $41af
	call SeekBallTrajEntry4_22 ; $41b2
	push de ; $41b5
	call SetBallVelocityFromEntry4_22 ; $41b6
	pop de ; $41b9
	ld h, d ; $41ba
	ld l, $00 ; $41bb
	sra h ; $41bd
	rr l ; $41bf
	sra h ; $41c1
	rr l ; $41c3
	call SetBallTargetFromAim_22 ; $41c5
	ret ; $41c8
	xor a, a ; $41c9
	sub a, c ; $41ca
	ld c, a ; $41cb
	sbc a, a ; $41cc
	sub a, b ; $41cd
	ld b, a ; $41ce
	ld a, [wShotDistMin] ; $41cf
	ld e, a ; $41d2
	ld a, [wShotDistMin + 1] ; $41d3
	ld d, a ; $41d6
	call BallTrajEntryPtr4_22 ; $41d7
	call SeekBallTrajEntry4_22 ; $41da
	push de ; $41dd
	call SetBallVelocityFromEntry4_22 ; $41de
	pop de ; $41e1
	ld h, d ; $41e2
	ld l, $00 ; $41e3
	sra h ; $41e5
	rr l ; $41e7
	sra h ; $41e9
	rr l ; $41eb
	call SetBallTargetFromAim_22 ; $41ed
	ret ; $41f0
.applyFallbackBallTrajectory:
	farcall ApplyFallbackBallTrajectory_24 ; $41f1
	ret ; $41f4
SetBallTargetFromAim_22:
	ld a, [wShotAimAngle] ; $41f5
	ld c, a ; $41f8
	ld a, [wShotAimAngle + 1] ; $41f9
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
	jr nc, .readEntry ; $4244
	inc h ; $4246
.readEntry:
	ld a, [hl+] ; $4247
	ld h, [hl] ; $4248
	ld l, a ; $4249
	add hl, de ; $424a
	ret ; $424b
LookupBallPosByHeight_22:
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
	jr nc, .read ; $4266
	inc h ; $4268
.read:
	ld a, [hl+] ; $4269
	ld h, [hl] ; $426a
	ld l, a ; $426b
	add hl, de ; $426c
	ret ; $426d
LookupBallPosByShotIndex_22:
	ld e, l ; $426e
	ld d, h ; $426f
	add a, a ; $4270
	ld l, c ; $4271
	ld h, b ; $4272
	add a, l ; $4273
	ld l, a ; $4274
	jr nc, .read ; $4275
	inc h ; $4277
.read:
	ld a, [hl+] ; $4278
	ld h, [hl] ; $4279
	ld l, a ; $427a
	add hl, de ; $427b
	ret ; $427c
BallPosData_22:
	INCBIN "data/bank_022/d_427d.bin" ; $427d, 15360 bytes
ShotBallPathTopspin:
	farcall ComputeShotPlacement ; $7e7d
	push bc ; $7e80
	ld hl, BallPosData_22 ; $7e81
	ld bc, BallPosHeightOffsets_22 ; $7e84
	call LookupBallPosByHeight_22 ; $7e87
	ld bc, BallPosBlockOffsets_22 ; $7e8a
	ld a, [wTopspinPlacementIndex] ; $7e8d
	call LookupBallPosByShotIndex_22 ; $7e90
	pop bc ; $7e93
	call ApplyBallTrajectory_22 ; $7e94
	ret ; $7e97
BallPosHeightOffsets_22:
	; $7e98, 64 bytes (records:2)
	dw $0000 ; record 0
	dw $0000 ; record 1
	dw $0000 ; record 2
	dw $0000 ; record 3
	dw $0000 ; record 4
	dw $0000 ; record 5
	dw $0f00 ; record 6
	dw $0f00 ; record 7
	dw $0f00 ; record 8
	dw $1e00 ; record 9
	dw $1e00 ; record 10
	dw $1e00 ; record 11
	dw $2d00 ; record 12
	dw $2d00 ; record 13
	dw $2d00 ; record 14
	dw $2d00 ; record 15
	dw $2d00 ; record 16
	dw $2d00 ; record 17
	dw $2d00 ; record 18
	dw $2d00 ; record 19
	dw $2d00 ; record 20
	dw $2d00 ; record 21
	dw $2d00 ; record 22
	dw $2d00 ; record 23
	dw $2d00 ; record 24
	dw $2d00 ; record 25
	dw $2d00 ; record 26
	dw $2d00 ; record 27
	dw $2d00 ; record 28
	dw $2d00 ; record 29
	dw $2d00 ; record 30
	dw $2d00 ; record 31
BallPosBlockOffsets_22:
	; $7ed8, 20 bytes (records:2)
	dw $0000 ; record 0
	dw $0180 ; record 1
	dw $0300 ; record 2
	dw $0480 ; record 3
	dw $0600 ; record 4
	dw $0780 ; record 5
	dw $0900 ; record 6
	dw $0a80 ; record 7
	dw $0c00 ; record 8
	dw $0d80 ; record 9
	; $7eec, 276 bytes fill to bank end (linker-padded)
