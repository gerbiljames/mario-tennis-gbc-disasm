SECTION "ROM Bank $2c", ROMX[$4000], BANK[$2c]

	farptr ProjectShotPlacement0 ; $4000
	farptr ProjectShotPlacement1 ; $4002
	farptr ProjectShotPlacement2 ; $4004
BallTrajEntryPtr6_2c:
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
BallTrajEntryPtr4_2c:
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
SeekBallTrajEntry6_2c:
	ld a, [wShotTrajRowMin] ; $4023
	ld d, a ; $4026
	ld a, [wShotTrajRowMax] ; $4027
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
SeekBallTrajEntry4_2c:
	ld a, [wShotTrajRowMin] ; $4042
	ld d, a ; $4045
	ld a, [wShotTrajRowMax] ; $4046
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
SetBallVelocityFromEntry6_2c:
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
	ld a, [wShotAimMirror] ; $406e
	and a, a ; $4071
	jr z, Label_2c_407a ; $4072
	xor a, a ; $4074
	sub a, e ; $4075
	ld e, a ; $4076
	sbc a, a ; $4077
	sub a, d ; $4078
	ld d, a ; $4079
Label_2c_407a:
	ld hl, wShotAimAngle ; $407a
	ld a, [hl+] ; $407d
	ld h, [hl] ; $407e
	ld l, a ; $407f
	add hl, de ; $4080
	ld e, l ; $4081
	ld d, h ; $4082
	pop hl ; $4083
	farcall SetBallVelocityPolar ; $4084
	ret ; $4087
SetBallVelocityFromEntry4_2c:
	ld a, [hl+] ; $4088
	ld c, a ; $4089
	ld a, [hl+] ; $408a
	ld b, a ; $408b
	push bc ; $408c
	ld a, [hl+] ; $408d
	ld c, a ; $408e
	ld a, [hl+] ; $408f
	ld b, a ; $4090
	ld hl, wShotAimAngle ; $4091
	ld a, [hl+] ; $4094
	ld d, [hl] ; $4095
	ld e, a ; $4096
	pop hl ; $4097
	farcall SetBallVelocityPolar ; $4098
	ret ; $409b
	ld a, [hl+] ; $409c
	ld c, a ; $409d
	ld a, [hl+] ; $409e
	ld b, a ; $409f
	push hl ; $40a0
	ld hl, $c476 ; $40a1
	ld a, c ; $40a4
	ld [hl+], a ; $40a5
	ld [hl], b ; $40a6
	ld hl, wShotAimDeltaX ; $40a7
	ld a, [hl+] ; $40aa
	ld h, [hl] ; $40ab
	ld l, a ; $40ac
	bit 7, h ; $40ad
	jr z, Label_2c_40b7 ; $40af
	xor a, a ; $40b1
	sub a, l ; $40b2
	ld l, a ; $40b3
	sbc a, a ; $40b4
	sub a, h ; $40b5
	ld h, a ; $40b6
Label_2c_40b7:
	add hl, hl ; $40b7
	ld a, b ; $40b8
	call MulHLByAFrac ; $40b9
	add hl, hl ; $40bc
	add hl, hl ; $40bd
	add hl, bc ; $40be
	ld c, l ; $40bf
	ld b, h ; $40c0
	pop hl ; $40c1
	push bc ; $40c2
	ld a, [hl+] ; $40c3
	ld c, a ; $40c4
	ld a, [hl+] ; $40c5
	ld b, a ; $40c6
	ld a, [hl+] ; $40c7
	ld e, a ; $40c8
	ld a, [hl+] ; $40c9
	ld d, a ; $40ca
	ld a, [wShotAimMirror] ; $40cb
	and a, a ; $40ce
	jr z, Label_2c_40d7 ; $40cf
	xor a, a ; $40d1
	sub a, e ; $40d2
	ld e, a ; $40d3
	sbc a, a ; $40d4
	sub a, d ; $40d5
	ld d, a ; $40d6
Label_2c_40d7:
	ld hl, wShotAimAngle ; $40d7
	ld a, [hl+] ; $40da
	ld h, [hl] ; $40db
	ld l, a ; $40dc
	add hl, de ; $40dd
	ld e, l ; $40de
	ld d, h ; $40df
	pop hl ; $40e0
	farcall SetBallVelocityPolar ; $40e1
	ld de, $fd40 ; $40e4
	ld a, [$df0a] ; $40e7
	and a, $02 ; $40ea
	jr z, Label_2c_40f4 ; $40ec
	xor a, a ; $40ee
	sub a, e ; $40ef
	ld e, a ; $40f0
	sbc a, a ; $40f1
	sub a, d ; $40f2
	ld d, a ; $40f3
Label_2c_40f4:
	ld hl, wBallTargetDepth ; $40f4
	ld a, e ; $40f7
	ld [hl+], a ; $40f8
	ld [hl], d ; $40f9
	farcall PredictBallXAtDepth ; $40fa
	ld e, l ; $40fd
	ld d, h ; $40fe
	ld hl, wBallTargetX ; $40ff
	ld a, e ; $4102
	ld [hl+], a ; $4103
	ld [hl], d ; $4104
	ret ; $4105
	INCBIN "data/bank_02c/d_4106.bin" ; $4106, 51 bytes
ApplyBallTrajectory6_2c:
	xor a, a ; $4139
	sub a, c ; $413a
	ld c, a ; $413b
	sbc a, a ; $413c
	sub a, b ; $413d
	ld b, a ; $413e
	ld a, [wShotDistMin] ; $413f
	ld e, a ; $4142
	ld a, [wShotDistMin + 1] ; $4143
	ld d, a ; $4146
	call BallTrajEntryPtr6_2c ; $4147
	call SeekBallTrajEntry6_2c ; $414a
	push de ; $414d
	call SetBallVelocityFromEntry6_2c ; $414e
	pop de ; $4151
	ld h, d ; $4152
	ld l, $00 ; $4153
	sra h ; $4155
	rr l ; $4157
	sra h ; $4159
	rr l ; $415b
	call SetBallTargetFromAim_2c ; $415d
	ret ; $4160
	push hl ; $4161
	ld hl, wShotAimAngle ; $4162
	ld a, [hl+] ; $4165
	ld b, [hl] ; $4166
	ld c, a ; $4167
	ld hl, wShotAimDeltaDepth ; $4168
	ld a, [hl+] ; $416b
	ld d, [hl] ; $416c
	ld e, a ; $416d
	ld hl, wShotAimDeltaX ; $416e
	ld a, [hl+] ; $4171
	ld h, [hl] ; $4172
	ld l, a ; $4173
	call VectorLengthFromAngle ; $4174
	ld e, l ; $4177
	ld d, h ; $4178
	ld hl, wShotDistMax ; $4179
	ld a, [hl+] ; $417c
	ld h, [hl] ; $417d
	ld l, a ; $417e
	ld a, l ; $417f
	sub a, e ; $4180
	ld l, a ; $4181
	ld a, h ; $4182
	sbc a, d ; $4183
	ld h, a ; $4184
	jr nc, Label_2c_418d ; $4185
	ld hl, wShotDistMax ; $4187
	ld a, [hl+] ; $418a
	ld d, [hl] ; $418b
	ld e, a ; $418c
Label_2c_418d:
	pop hl ; $418d
	push de ; $418e
	call BallTrajEntryPtr6_2c ; $418f
	call SetBallVelocityFromEntry6_2c ; $4192
	pop hl ; $4195
	call SetBallTargetFromAim_2c ; $4196
	ret ; $4199
	INCBIN "data/bank_02c/d_419a.bin" ; $419a, 51 bytes
ApplyBallTrajectory4_2c:
	xor a, a ; $41cd
	sub a, c ; $41ce
	ld c, a ; $41cf
	sbc a, a ; $41d0
	sub a, b ; $41d1
	ld b, a ; $41d2
	ld a, [wShotDistMin] ; $41d3
	ld e, a ; $41d6
	ld a, [wShotDistMin + 1] ; $41d7
	ld d, a ; $41da
	call BallTrajEntryPtr4_2c ; $41db
	call SeekBallTrajEntry4_2c ; $41de
	push de ; $41e1
	call SetBallVelocityFromEntry4_2c ; $41e2
	pop de ; $41e5
	ld h, d ; $41e6
	ld l, $00 ; $41e7
	sra h ; $41e9
	rr l ; $41eb
	sra h ; $41ed
	rr l ; $41ef
	call SetBallTargetFromAim_2c ; $41f1
	ret ; $41f4
	farcall ApplyFallbackBallTrajectory_24 ; $41f5
	ret ; $41f8
SetBallTargetFromAim_2c:
	ld a, [wShotAimAngle] ; $41f9
	ld c, a ; $41fc
	ld a, [wShotAimAngle + 1] ; $41fd
	ld b, a ; $4200
	call MulSinCos ; $4201
	ld c, l ; $4204
	ld b, h ; $4205
	ld hl, wBallX ; $4206
	ld a, [hl+] ; $4209
	ld h, [hl] ; $420a
	ld l, a ; $420b
	add hl, bc ; $420c
	ld c, l ; $420d
	ld b, h ; $420e
	ld hl, wBallTargetX ; $420f
	ld a, c ; $4212
	ld [hl+], a ; $4213
	ld [hl], b ; $4214
	ld hl, wBallDepth ; $4215
	ld a, [hl+] ; $4218
	ld h, [hl] ; $4219
	ld l, a ; $421a
	add hl, de ; $421b
	ld e, l ; $421c
	ld d, h ; $421d
	ld hl, wBallTargetDepth ; $421e
	ld a, e ; $4221
	ld [hl+], a ; $4222
	ld [hl], d ; $4223
	ret ; $4224
	push hl ; $4225
	push bc ; $4226
	ld hl, wShotAimAngle ; $4227
	ld a, [hl+] ; $422a
	ld b, [hl] ; $422b
	ld c, a ; $422c
	ld hl, wBallDepth ; $422d
	ld a, [hl+] ; $4230
	ld d, [hl] ; $4231
	ld e, a ; $4232
	ld hl, wBallX ; $4233
	ld a, [hl+] ; $4236
	ld h, [hl] ; $4237
	ld l, a ; $4238
	call VectorLengthFromAngle ; $4239
	add hl, hl ; $423c
	ld a, h ; $423d
	and a, $1f ; $423e
	ld [$c472], a ; $4240
	add a, a ; $4243
	pop hl ; $4244
	pop de ; $4245
	add a, l ; $4246
	ld l, a ; $4247
	jr nc, Label_2c_424b ; $4248
	inc h ; $424a
Label_2c_424b:
	ld a, [hl+] ; $424b
	ld h, [hl] ; $424c
	ld l, a ; $424d
	add hl, de ; $424e
	ret ; $424f
LookupBallPosByHeight_2c:
	ld e, l ; $4250
	ld d, h ; $4251
	ld hl, wBallHeight ; $4252
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
	ld e, l ; $4272
	ld d, h ; $4273
	add a, a ; $4274
	ld l, c ; $4275
	ld h, b ; $4276
	add a, l ; $4277
	ld l, a ; $4278
	jr nc, Label_2c_427c ; $4279
	inc h ; $427b
Label_2c_427c:
	ld a, [hl+] ; $427c
	ld h, [hl] ; $427d
	ld l, a ; $427e
	add hl, de ; $427f
	ret ; $4280
ShotPlacementData0_2c:
	INCBIN "data/bank_02c/d_4281.bin" ; $4281, 3072 bytes
ShotPlacementData1_2c:
	INCBIN "data/bank_02c/d_4e81.bin" ; $4e81, 4608 bytes
ShotPlacementData2_2c:
	INCBIN "data/bank_02c/d_6081.bin" ; $6081, 4608 bytes
ProjectShotPlacement0:
	farcall ComputeShotPlacement ; $7281
	push bc ; $7284
	ld hl, ShotPlacementData0_2c ; $7285
	ld bc, ShotPlacementOffsets0_2c ; $7288
	call LookupBallPosByHeight_2c ; $728b
	pop bc ; $728e
	call ApplyBallTrajectory4_2c ; $728f
	ret ; $7292
ShotPlacementOffsets0_2c:
	; $7293, 64 bytes (records:2)
	dw $0000 ; record 0
	dw $0000 ; record 1
	dw $0000 ; record 2
	dw $0000 ; record 3
	dw $0000 ; record 4
	dw $0000 ; record 5
	dw $0000 ; record 6
	dw $0100 ; record 7
	dw $0200 ; record 8
	dw $0300 ; record 9
	dw $0400 ; record 10
	dw $0500 ; record 11
	dw $0600 ; record 12
	dw $0700 ; record 13
	dw $0800 ; record 14
	dw $0900 ; record 15
	dw $0a00 ; record 16
	dw $0b00 ; record 17
	dw $0b00 ; record 18
	dw $0b00 ; record 19
	dw $0b00 ; record 20
	dw $0b00 ; record 21
	dw $0b00 ; record 22
	dw $0b00 ; record 23
	dw $0b00 ; record 24
	dw $0b00 ; record 25
	dw $0b00 ; record 26
	dw $0b00 ; record 27
	dw $0b00 ; record 28
	dw $0b00 ; record 29
	dw $0b00 ; record 30
	dw $0b00 ; record 31
ProjectShotPlacement1:
	farcall ComputeShotPlacement ; $72d3
	push bc ; $72d6
	ld hl, ShotPlacementData1_2c ; $72d7
	ld bc, ShotPlacementOffsets1_2c ; $72da
	call LookupBallPosByHeight_2c ; $72dd
	pop bc ; $72e0
	call ApplyBallTrajectory6_2c ; $72e1
	ret ; $72e4
ShotPlacementOffsets1_2c:
	; $72e5, 64 bytes (records:2)
	dw $0000 ; record 0
	dw $0000 ; record 1
	dw $0000 ; record 2
	dw $0000 ; record 3
	dw $0000 ; record 4
	dw $0000 ; record 5
	dw $0000 ; record 6
	dw $0180 ; record 7
	dw $0300 ; record 8
	dw $0480 ; record 9
	dw $0600 ; record 10
	dw $0780 ; record 11
	dw $0900 ; record 12
	dw $0a80 ; record 13
	dw $0c00 ; record 14
	dw $0d80 ; record 15
	dw $0f00 ; record 16
	dw $1080 ; record 17
	dw $1080 ; record 18
	dw $1080 ; record 19
	dw $1080 ; record 20
	dw $1080 ; record 21
	dw $1080 ; record 22
	dw $1080 ; record 23
	dw $1080 ; record 24
	dw $1080 ; record 25
	dw $1080 ; record 26
	dw $1080 ; record 27
	dw $1080 ; record 28
	dw $1080 ; record 29
	dw $1080 ; record 30
	dw $1080 ; record 31
ProjectShotPlacement2:
	farcall ComputeShotPlacement ; $7325
	push bc ; $7328
	ld hl, ShotPlacementData2_2c ; $7329
	ld bc, ShotPlacementOffsets2_2c ; $732c
	call LookupBallPosByHeight_2c ; $732f
	pop bc ; $7332
	call ApplyBallTrajectory6_2c ; $7333
	ret ; $7336
ShotPlacementOffsets2_2c:
	; $7337, 64 bytes (records:2)
	dw $0000 ; record 0
	dw $0000 ; record 1
	dw $0000 ; record 2
	dw $0000 ; record 3
	dw $0000 ; record 4
	dw $0000 ; record 5
	dw $0000 ; record 6
	dw $0180 ; record 7
	dw $0300 ; record 8
	dw $0480 ; record 9
	dw $0600 ; record 10
	dw $0780 ; record 11
	dw $0900 ; record 12
	dw $0a80 ; record 13
	dw $0c00 ; record 14
	dw $0d80 ; record 15
	dw $0f00 ; record 16
	dw $1080 ; record 17
	dw $1080 ; record 18
	dw $1080 ; record 19
	dw $1080 ; record 20
	dw $1080 ; record 21
	dw $1080 ; record 22
	dw $1080 ; record 23
	dw $1080 ; record 24
	dw $1080 ; record 25
	dw $1080 ; record 26
	dw $1080 ; record 27
	dw $1080 ; record 28
	dw $1080 ; record 29
	dw $1080 ; record 30
	dw $1080 ; record 31
	ds 3209, $ff ; $7377, fill
