SECTION "ROM Bank $24", ROMX[$4000], BANK[$24]

	farptr ShotBallPathLob ; $4000
	farptr ShotBallPathDrop ; $4002
	farptr ApplyFallbackBallTrajectory_24 ; $4004
	farptr ShotBallPathNeutral ; $4006
	farptr ShotBallPathSmash ; $4008
	farptr StubNop_24 ; $400a
	farptr ShotBallPathReach ; $400c
BallTrajEntryPtr6_24:
	push hl ; $400e
	ld l, e ; $400f
	ld h, d ; $4010
	add hl, hl ; $4011
	add hl, hl ; $4012
	ld l, h ; $4013
	ld h, $00 ; $4014
	ld e, l ; $4016
	ld d, h ; $4017
	add hl, hl ; $4018
	add hl, de ; $4019
	add hl, hl ; $401a
	pop de ; $401b
	add hl, de ; $401c
	ret ; $401d
BallTrajEntryPtr4_24:
	push hl ; $401e
	ld l, e ; $401f
	ld h, d ; $4020
	add hl, hl ; $4021
	add hl, hl ; $4022
	ld l, h ; $4023
	ld h, $00 ; $4024
	add hl, hl ; $4026
	add hl, hl ; $4027
	pop de ; $4028
	add hl, de ; $4029
	ret ; $402a
SeekBallTrajEntry6_24:
	ld a, [wShotTrajRowMin] ; $402b
	ld d, a ; $402e
	ld a, [wShotTrajRowMax] ; $402f
	ld e, a ; $4032
.loop:
	push hl ; $4033
	ld a, [hl+] ; $4034
	ld h, [hl] ; $4035
	ld l, a ; $4036
	add hl, bc ; $4037
	pop hl ; $4038
	jr c, .done ; $4039
	ld a, d ; $403b
	cp e ; $403c
	jr nc, .done ; $403d
	inc d ; $403f
	ld a, $06 ; $4040
	add l ; $4042
	ld l, a ; $4043
	jr nc, .gotPtr ; $4044
	inc h ; $4046
.gotPtr:
	jr .loop ; $4047
.done:
	ret ; $4049
SeekBallTrajEntry4_24:
	ld a, [wShotTrajRowMin] ; $404a
	ld d, a ; $404d
	ld a, [wShotTrajRowMax] ; $404e
	ld e, a ; $4051
.loop:
	push hl ; $4052
	ld a, [hl+] ; $4053
	ld h, [hl] ; $4054
	ld l, a ; $4055
	add hl, bc ; $4056
	pop hl ; $4057
	jr c, .done ; $4058
	ld a, d ; $405a
	cp e ; $405b
	jr nc, .done ; $405c
	inc d ; $405e
	ld a, $04 ; $405f
	add l ; $4061
	ld l, a ; $4062
	jr nc, .gotPtr ; $4063
	inc h ; $4065
.gotPtr:
	jr .loop ; $4066
.done:
	ret ; $4068
SetBallVelocityFromEntry6_24:
	ld a, [hl+] ; $4069
	ld c, a ; $406a
	ld a, [hl+] ; $406b
	ld b, a ; $406c
	push bc ; $406d
	ld a, [hl+] ; $406e
	ld c, a ; $406f
	ld a, [hl+] ; $4070
	ld b, a ; $4071
	ld a, [hl+] ; $4072
	ld e, a ; $4073
	ld a, [hl+] ; $4074
	ld d, a ; $4075
	ld a, [wShotAimMirror] ; $4076
	and a ; $4079
	jr z, .zero ; $407a
	xor a ; $407c
	sub e ; $407d
	ld e, a ; $407e
	sbc a ; $407f
	sub d ; $4080
	ld d, a ; $4081
.zero:
	ld hl, wShotAimAngle ; $4082
	ld a, [hl+] ; $4085
	ld h, [hl] ; $4086
	ld l, a ; $4087
	add hl, de ; $4088
	ld e, l ; $4089
	ld d, h ; $408a
	pop hl ; $408b
	farcall SetBallVelocityPolar ; $408c
	ret ; $408f
SetBallVelocityFromEntry4_24:
	ld a, [hl+] ; $4090
	ld c, a ; $4091
	ld a, [hl+] ; $4092
	ld b, a ; $4093
	push bc ; $4094
	ld a, [hl+] ; $4095
	ld c, a ; $4096
	ld a, [hl+] ; $4097
	ld b, a ; $4098
	ld hl, wShotAimAngle ; $4099
	ld a, [hl+] ; $409c
	ld d, [hl] ; $409d
	ld e, a ; $409e
	pop hl ; $409f
	farcall SetBallVelocityPolar ; $40a0
	ret ; $40a3
SetBallTargetByPrediction_24:
	ld a, [hl+] ; $40a4
	ld c, a ; $40a5
	ld a, [hl+] ; $40a6
	ld b, a ; $40a7
	push hl ; $40a8
	ld hl, wShotPredictionEntry ; $40a9
	ld a, c ; $40ac
	ld [hl+], a ; $40ad
	ld [hl], b ; $40ae
	ld hl, wShotAimDeltaX ; $40af
	ld a, [hl+] ; $40b2
	ld h, [hl] ; $40b3
	ld l, a ; $40b4
	bit 7, h ; $40b5
	jr z, .offset ; $40b7
	xor a ; $40b9
	sub l ; $40ba
	ld l, a ; $40bb
	sbc a ; $40bc
	sub h ; $40bd
	ld h, a ; $40be
.offset:
	add hl, hl ; $40bf
	ld a, b ; $40c0
	call MulHLByAFrac ; $40c1
	add hl, hl ; $40c4
	add hl, hl ; $40c5
	add hl, bc ; $40c6
	ld c, l ; $40c7
	ld b, h ; $40c8
	pop hl ; $40c9
	push bc ; $40ca
	ld a, [hl+] ; $40cb
	ld c, a ; $40cc
	ld a, [hl+] ; $40cd
	ld b, a ; $40ce
	ld a, [hl+] ; $40cf
	ld e, a ; $40d0
	ld a, [hl+] ; $40d1
	ld d, a ; $40d2
	ld a, [wShotAimMirror] ; $40d3
	and a ; $40d6
	jr z, .zero ; $40d7
	xor a ; $40d9
	sub e ; $40da
	ld e, a ; $40db
	sbc a ; $40dc
	sub d ; $40dd
	ld d, a ; $40de
.zero:
	ld hl, wShotAimAngle ; $40df
	ld a, [hl+] ; $40e2
	ld h, [hl] ; $40e3
	ld l, a ; $40e4
	add hl, de ; $40e5
	ld e, l ; $40e6
	ld d, h ; $40e7
	pop hl ; $40e8
	farcall SetBallVelocityPolar ; $40e9
	ld de, $fd40 ; $40ec
	ld a, [wCharCourtPos] ; $40ef
	and $02 ; $40f2
	jr z, .maskClear ; $40f4
	xor a ; $40f6
	sub e ; $40f7
	ld e, a ; $40f8
	sbc a ; $40f9
	sub d ; $40fa
	ld d, a ; $40fb
.maskClear:
	ld hl, wBallTargetDepth ; $40fc
	ld a, e ; $40ff
	ld [hl+], a ; $4100
	ld [hl], d ; $4101
	farcall PredictBallXAtDepth ; $4102
	ld e, l ; $4105
	ld d, h ; $4106
	ld hl, wBallTargetX ; $4107
	ld a, e ; $410a
	ld [hl+], a ; $410b
	ld [hl], d ; $410c
	ret ; $410d
ApplyBallTrajectory6Capped_24:
	xor a ; $410e
	sub c ; $410f
	ld c, a ; $4110
	sbc a ; $4111
	sub b ; $4112
	ld b, a ; $4113
	ld a, [wShotDistMin] ; $4114
	ld e, a ; $4117
	ld a, [wShotDistMin + 1] ; $4118
	ld d, a ; $411b
	call BallTrajEntryPtr6_24 ; $411c
	push hl ; $411f
	ld a, [hl+] ; $4120
	ld h, [hl] ; $4121
	ld l, a ; $4122
	add hl, bc ; $4123
	ld e, l ; $4124
	ld d, h ; $4125
	pop hl ; $4126
	jp c, ApplyBallTrajectory4_24.applyFallbackBallTrajectory ; $4127
	call SeekBallTrajEntry6_24 ; $412a
	push de ; $412d
	call SetBallVelocityFromEntry6_24 ; $412e
	pop de ; $4131
	ld h, d ; $4132
	ld l, $00 ; $4133
	sra h ; $4135
	rr l ; $4137
	sra h ; $4139
	rr l ; $413b
	call SetBallTargetFromAim_24 ; $413d
	ret ; $4140
ApplyBallTrajectory6_24:
	xor a ; $4141
	sub c ; $4142
	ld c, a ; $4143
	sbc a ; $4144
	sub b ; $4145
	ld b, a ; $4146
	ld a, [wShotDistMin] ; $4147
	ld e, a ; $414a
	ld a, [wShotDistMin + 1] ; $414b
	ld d, a ; $414e
	call BallTrajEntryPtr6_24 ; $414f
	call SeekBallTrajEntry6_24 ; $4152
	push de ; $4155
	call SetBallVelocityFromEntry6_24 ; $4156
	pop de ; $4159
	ld h, d ; $415a
	ld l, $00 ; $415b
	sra h ; $415d
	rr l ; $415f
	sra h ; $4161
	rr l ; $4163
	call SetBallTargetFromAim_24 ; $4165
	ret ; $4168
ApplyBallTrajectoryCapped_24:
	push hl ; $4169
	ld hl, wShotAimAngle ; $416a
	ld a, [hl+] ; $416d
	ld b, [hl] ; $416e
	ld c, a ; $416f
	ld hl, wShotAimDeltaDepth ; $4170
	ld a, [hl+] ; $4173
	ld d, [hl] ; $4174
	ld e, a ; $4175
	ld hl, wShotAimDeltaX ; $4176
	ld a, [hl+] ; $4179
	ld h, [hl] ; $417a
	ld l, a ; $417b
	call VectorLengthFromAngle ; $417c
	ld e, l ; $417f
	ld d, h ; $4180
	ld hl, wShotDistMax ; $4181
	ld a, [hl+] ; $4184
	ld h, [hl] ; $4185
	ld l, a ; $4186
	ld a, l ; $4187
	sub e ; $4188
	ld l, a ; $4189
	ld a, h ; $418a
	sbc d ; $418b
	ld h, a ; $418c
	jr nc, .restore ; $418d
	ld hl, wShotDistMax ; $418f
	ld a, [hl+] ; $4192
	ld d, [hl] ; $4193
	ld e, a ; $4194
.restore:
	pop hl ; $4195
	push de ; $4196
	call BallTrajEntryPtr6_24 ; $4197
	call SetBallVelocityFromEntry6_24 ; $419a
	pop hl ; $419d
	call SetBallTargetFromAim_24 ; $419e
	ret ; $41a1
ApplyBallTrajectory_24:
	xor a ; $41a2
	sub c ; $41a3
	ld c, a ; $41a4
	sbc a ; $41a5
	sub b ; $41a6
	ld b, a ; $41a7
	ld a, [wShotDistMin] ; $41a8
	ld e, a ; $41ab
	ld a, [wShotDistMin + 1] ; $41ac
	ld d, a ; $41af
	call BallTrajEntryPtr4_24 ; $41b0
	push hl ; $41b3
	ld a, [hl+] ; $41b4
	ld h, [hl] ; $41b5
	ld l, a ; $41b6
	add hl, bc ; $41b7
	ld e, l ; $41b8
	ld d, h ; $41b9
	pop hl ; $41ba
	jp c, ApplyBallTrajectory4_24.applyFallbackBallTrajectory ; $41bb
	call SeekBallTrajEntry4_24 ; $41be
	push de ; $41c1
	call SetBallVelocityFromEntry4_24 ; $41c2
	pop de ; $41c5
	ld h, d ; $41c6
	ld l, $00 ; $41c7
	sra h ; $41c9
	rr l ; $41cb
	sra h ; $41cd
	rr l ; $41cf
	call SetBallTargetFromAim_24 ; $41d1
	ret ; $41d4
ApplyBallTrajectory4_24:
	xor a ; $41d5
	sub c ; $41d6
	ld c, a ; $41d7
	sbc a ; $41d8
	sub b ; $41d9
	ld b, a ; $41da
	ld a, [wShotDistMin] ; $41db
	ld e, a ; $41de
	ld a, [wShotDistMin + 1] ; $41df
	ld d, a ; $41e2
	call BallTrajEntryPtr4_24 ; $41e3
	call SeekBallTrajEntry4_24 ; $41e6
	push de ; $41e9
	call SetBallVelocityFromEntry4_24 ; $41ea
	pop de ; $41ed
	ld h, d ; $41ee
	ld l, $00 ; $41ef
	sra h ; $41f1
	rr l ; $41f3
	sra h ; $41f5
	rr l ; $41f7
	call SetBallTargetFromAim_24 ; $41f9
	ret ; $41fc
.applyFallbackBallTrajectory:
	farcall ApplyFallbackBallTrajectory_24 ; $41fd
	ret ; $4200
SetBallTargetFromAim_24:
	ld a, [wShotAimAngle] ; $4201
	ld c, a ; $4204
	ld a, [wShotAimAngle + 1] ; $4205
	ld b, a ; $4208
	call MulSinCos ; $4209
	ld c, l ; $420c
	ld b, h ; $420d
	ld hl, wBallX ; $420e
	ld a, [hl+] ; $4211
	ld h, [hl] ; $4212
	ld l, a ; $4213
	add hl, bc ; $4214
	ld c, l ; $4215
	ld b, h ; $4216
	ld hl, wBallTargetX ; $4217
	ld a, c ; $421a
	ld [hl+], a ; $421b
	ld [hl], b ; $421c
	ld hl, wBallDepth ; $421d
	ld a, [hl+] ; $4220
	ld h, [hl] ; $4221
	ld l, a ; $4222
	add hl, de ; $4223
	ld e, l ; $4224
	ld d, h ; $4225
	ld hl, wBallTargetDepth ; $4226
	ld a, e ; $4229
	ld [hl+], a ; $422a
	ld [hl], d ; $422b
	ret ; $422c
LookupBallPosByAim_24:
	push hl ; $422d
	push bc ; $422e
	ld hl, wShotAimAngle ; $422f
	ld a, [hl+] ; $4232
	ld b, [hl] ; $4233
	ld c, a ; $4234
	ld hl, wBallDepth ; $4235
	ld a, [hl+] ; $4238
	ld d, [hl] ; $4239
	ld e, a ; $423a
	ld hl, wBallX ; $423b
	ld a, [hl+] ; $423e
	ld h, [hl] ; $423f
	ld l, a ; $4240
	call VectorLengthFromAngle ; $4241
	add hl, hl ; $4244
	ld a, h ; $4245
	and $1f ; $4246
	ld [wShotAimRow], a ; $4248
	add a ; $424b
	pop hl ; $424c
	pop de ; $424d
	add l ; $424e
	ld l, a ; $424f
	jr nc, .read ; $4250
	inc h ; $4252
.read:
	ld a, [hl+] ; $4253
	ld h, [hl] ; $4254
	ld l, a ; $4255
	add hl, de ; $4256
	ret ; $4257
LookupBallPosByHeight_24:
	ld e, l ; $4258
	ld d, h ; $4259
	ld hl, wBallHeight ; $425a
	ld a, [hl+] ; $425d
	ld h, [hl] ; $425e
	ld l, a ; $425f
	xor a ; $4260
	sub l ; $4261
	ld l, a ; $4262
	sbc a ; $4263
	sub h ; $4264
	ld h, a ; $4265
	add hl, hl ; $4266
	add hl, hl ; $4267
	add hl, hl ; $4268
	add hl, hl ; $4269
	ld a, h ; $426a
	and $1f ; $426b
	add a ; $426d
	ld l, c ; $426e
	ld h, b ; $426f
	add l ; $4270
	ld l, a ; $4271
	jr nc, .read ; $4272
	inc h ; $4274
.read:
	ld a, [hl+] ; $4275
	ld h, [hl] ; $4276
	ld l, a ; $4277
	add hl, de ; $4278
	ret ; $4279
LookupBallPosByShotIndex_24:
	ld e, l ; $427a
	ld d, h ; $427b
	add a ; $427c
	ld l, c ; $427d
	ld h, b ; $427e
	add l ; $427f
	ld l, a ; $4280
	jr nc, .read ; $4281
	inc h ; $4283
.read:
	ld a, [hl+] ; $4284
	ld h, [hl] ; $4285
	ld l, a ; $4286
	add hl, de ; $4287
	ret ; $4288
BallPosDataLob_24:
	INCBIN "data/bank_024/BallPosDataLob_24.bin" ; $4289, 768 bytes
ShotBallPathLob:
	farcall ComputeShotPlacement ; $4589
	ld hl, BallPosDataLob_24 ; $458c
	ld bc, BallPosBlockOffsetsLob_24 ; $458f
	ld a, [wLobPlacementIndex] ; $4592
	call LookupBallPosByShotIndex_24 ; $4595
	call ApplyBallTrajectoryCapped_24 ; $4598
	ret ; $459b
BallPosBlockOffsetsLob_24:
	INCBIN "data/bank_024/BallPosBlockOffsetsLob_24.bin" ; $459c, 4 bytes
BallPosDataDrop_24:
	INCBIN "data/bank_024/BallPosDataDrop_24.bin" ; $45a0, 3072 bytes
ShotBallPathDrop:
	farcall ComputeShotPlacement ; $51a0
	ld hl, BallPosDataDrop_24 ; $51a3
	ld bc, BallPosAimOffsetsDrop_24 ; $51a6
	call LookupBallPosByAim_24 ; $51a9
	ld bc, BallPosBlockOffsetsDrop_24 ; $51ac
	ld a, [wDropPlacementIndex] ; $51af
	call LookupBallPosByShotIndex_24 ; $51b2
	call ApplyBallTrajectoryCapped_24 ; $51b5
	ret ; $51b8
BallPosAimOffsetsDrop_24:
	INCBIN "data/bank_024/BallPosAimOffsetsDrop_24.bin" ; $51b9, 64 bytes
BallPosBlockOffsetsDrop_24:
	INCBIN "data/bank_024/BallPosBlockOffsetsDrop_24.bin" ; $51f9, 4 bytes
BallPosDataFallback_24:
	INCBIN "data/bank_024/BallPosDataFallback_24.bin" ; $51fd, 1536 bytes
ApplyFallbackBallTrajectory_24:
	ld a, $01 ; $57fd
	ld [wFallbackTrajectoryFlag], a ; $57ff
	xor a ; $5802
	ld [wBallTrailColor], a ; $5803
	xor a ; $5806
	ld hl, wBallTopspin ; $5807
	ld [hl+], a ; $580a
	ld [hl+], a ; $580b
	ld [hl+], a ; $580c
	ld [hl+], a ; $580d
	ld a, d ; $580e
	srl a ; $580f
	ld bc, $0280 ; $5811
	cp $04 ; $5814
	jr c, .solve ; $5816
	ld a, $03 ; $5818
	ld bc, $0140 ; $581a
	jr z, .solve ; $581d
	ld a, $00 ; $581f
	ld bc, $00e0 ; $5821
.solve:
	push af ; $5824
	farcall ComputeShotTrajectory ; $5825
	pop af ; $5828
	add a ; $5829
	ld_hl_indexed BallPosFallbackOffsets_24 ; $582a
	ld a, [hl+] ; $5831
	ld d, [hl] ; $5832
	ld e, a ; $5833
	ld hl, BallPosDataFallback_24 ; $5834
	add hl, de ; $5837
	call ApplyBallTrajectoryCapped_24 ; $5838
	ret ; $583b
BallPosFallbackOffsets_24:
	INCBIN "data/bank_024/BallPosFallbackOffsets_24.bin" ; $583c, 8 bytes
BallPosDataNeutral_24:
	INCBIN "data/bank_024/BallPosDataNeutral_24.bin" ; $5844, 3584 bytes
ShotBallPathNeutral:
	farcall ComputeShotPlacement ; $6644
	push bc ; $6647
	ld hl, BallPosDataNeutral_24 ; $6648
	ld bc, BallPosHeightOffsetsNeutral_24 ; $664b
	call LookupBallPosByHeight_24 ; $664e
	pop bc ; $6651
	call ApplyBallTrajectory_24 ; $6652
	ret ; $6655
BallPosHeightOffsetsNeutral_24:
	; $6656, 64 bytes (records:2)
	dw $0000 ; record 0
	dw $0000 ; record 1
	dw $0000 ; record 2
	dw $0100 ; record 3
	dw $0200 ; record 4
	dw $0300 ; record 5
	dw $0400 ; record 6
	dw $0500 ; record 7
	dw $0600 ; record 8
	dw $0700 ; record 9
	dw $0800 ; record 10
	dw $0900 ; record 11
	dw $0a00 ; record 12
	dw $0b00 ; record 13
	dw $0c00 ; record 14
	dw $0d00 ; record 15
	dw $0d00 ; record 16
	dw $0d00 ; record 17
	dw $0d00 ; record 18
	dw $0d00 ; record 19
	dw $0d00 ; record 20
	dw $0d00 ; record 21
	dw $0d00 ; record 22
	dw $0d00 ; record 23
	dw $0d00 ; record 24
	dw $0d00 ; record 25
	dw $0d00 ; record 26
	dw $0d00 ; record 27
	dw $0d00 ; record 28
	dw $0d00 ; record 29
	dw $0d00 ; record 30
	dw $0d00 ; record 31
ShotBallPathSmash:
	farcall ComputeShotPlacement ; $6696
	push bc ; $6699
	ld hl, wShotDistMax ; $669a
	ld a, [hl+] ; $669d
	ld d, [hl] ; $669e
	ld e, a ; $669f
	ld hl, wBallDepth ; $66a0
	ld a, [hl+] ; $66a3
	ld h, [hl] ; $66a4
	ld l, a ; $66a5
	bit 7, h ; $66a6
	jr z, .offset ; $66a8
	xor a ; $66aa
	sub l ; $66ab
	ld l, a ; $66ac
	sbc a ; $66ad
	sub h ; $66ae
	ld h, a ; $66af
.offset:
	add hl, de ; $66b0
	ld e, l ; $66b1
	ld d, h ; $66b2
	ld hl, wBallHeight ; $66b3
	ld a, [hl+] ; $66b6
	ld h, [hl] ; $66b7
	ld l, a ; $66b8
	xor a ; $66b9
	sub l ; $66ba
	ld l, a ; $66bb
	sbc a ; $66bc
	sub h ; $66bd
	ld h, a ; $66be
	ld c, l ; $66bf
	ld b, h ; $66c0
	sra b ; $66c1
	rr c ; $66c3
	add hl, bc ; $66c5
	call AngleFromVector16 ; $66c6
	ld a, [wSmashServeSpeedIndex] ; $66c9
	add a ; $66cc
	ld_hl_indexed SmashVelocityBySpeed_24 ; $66cd
	ld a, [hl+] ; $66d4
	ld h, [hl] ; $66d5
	ld l, a ; $66d6
	add hl, bc ; $66d7
	ld c, l ; $66d8
	ld b, h ; $66d9
	ld hl, wShotAimAngle ; $66da
	ld a, [hl+] ; $66dd
	ld d, [hl] ; $66de
	ld e, a ; $66df
	pop hl ; $66e0
	farcall SetBallVelocityPolar ; $66e1
	ld hl, wShotDistMax ; $66e4
	ld a, [hl+] ; $66e7
	ld d, [hl] ; $66e8
	ld e, a ; $66e9
	ld hl, $ff00 ; $66ea
	add hl, de ; $66ed
	call SetBallTargetFromAim_24 ; $66ee
	ret ; $66f1
SmashVelocityBySpeed_24:
	; $66f2, 20 bytes (records:2)
	dw $fa60 ; record 0
	dw $faf0 ; record 1
	dw $fb80 ; record 2
	dw $fc10 ; record 3
	dw $fca0 ; record 4
	dw $fd30 ; record 5
	dw $fdc0 ; record 6
	dw $fe50 ; record 7
	dw $fee0 ; record 8
	dw $ff70 ; record 9
StubNop_24:
	ret ; $6706
BallPosDataReach_24:
	INCBIN "data/bank_024/BallPosDataReach_24.bin" ; $6707, 4096 bytes
ShotBallPathReach:
	farcall ComputeShotPlacement ; $7707
	push bc ; $770a
	ld hl, BallPosDataReach_24 ; $770b
	ld bc, BallPosHeightOffsetsReach_24 ; $770e
	call LookupBallPosByHeight_24 ; $7711
	pop bc ; $7714
	call ApplyBallTrajectory_24 ; $7715
	ret ; $7718
BallPosHeightOffsetsReach_24:
	INCBIN "data/bank_024/BallPosHeightOffsetsReach_24.bin" ; $7719, 64 bytes
	; $7759, 2215 bytes fill to bank end (linker-padded)
