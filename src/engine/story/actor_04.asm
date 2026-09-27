ClearActorSlots:
	wram_bank WRAM_ACTORS ; $4032
	ld hl, wActors ; $4038
	ld c, $60 ; $403b
	call ClearMemory16 ; $403d
	ret ; $4040
InitActorEngine:
	call ClearActorSlots ; $4041
	ld a, $10 ; $4044
	ld hl, UpdateActors ; $4046
	call RegisterFrameTask ; $4049
	ld a, $01 ; $404c
	ld hl, DrawActors ; $404e
	call RegisterFrameTask ; $4051
	ret ; $4054
SpawnActor:
	push af ; $4055
	push de ; $4056
	push hl ; $4057
	wram_bank WRAM_ACTORS ; $4058
	ld hl, wActors ; $405e
	ld c, $18 ; $4061
.findSlot:
	inc hl ; $4063
	ld a, [hl-] ; $4064
	or a ; $4065
	jr z, .initSlot ; $4066
	ld de, $0040 ; $4068
	add hl, de ; $406b
	dec c ; $406c
	jr nz, .findSlot ; $406d
	ld bc, $0000 ; $406f
	pop hl ; $4072
	pop de ; $4073
	pop af ; $4074
	ret ; $4075
.initSlot:
	ld c, l ; $4076
	ld b, h ; $4077
	ld de, $9000 + VRAM_BANK1 ; $4078
	add hl, de ; $407b
	ld e, l ; $407c
	ld d, h ; $407d
	ld hl, $0026 ; $407e
	add hl, bc ; $4081
	ld a, e ; $4082
	ld [hl+], a ; $4083
	ld [hl], d ; $4084
	ld l, c ; $4085
	ld h, b ; $4086
	add hl, hl ; $4087
	add hl, hl ; $4088
	add hl, hl ; $4089
	add hl, hl ; $408a
	ld a, h ; $408b
	ld hl, $0036 ; $408c
	add hl, bc ; $408f
	ld [hl], a ; $4090
	ld hl, ACTORF_MODE ; $4091
	add hl, bc ; $4094
	ld [hl], $00 ; $4095
	ld hl, $0015 ; $4097
	add hl, bc ; $409a
	ld [hl], $10 ; $409b
	ld hl, $0006 ; $409d
	add hl, bc ; $40a0
	ld a, $20 ; $40a1
	ld [hl+], a ; $40a3
	ld a, $00 ; $40a4
	ld [hl+], a ; $40a6
	pop hl ; $40a7
	pop de ; $40a8
	pop af ; $40a9
	jr InitActorSlotFields ; $40aa
SetActorScript:
	inc b ; $40ac
	dec b ; $40ad
	ret z ; $40ae
InitActorSlotFields:
	push af ; $40af
	push bc ; $40b0
	push af ; $40b1
	wram_bank WRAM_ACTORS ; $40b2
	ld a, l ; $40b8
	ld [bc], a ; $40b9
	inc bc ; $40ba
	ld a, h ; $40bb
	ld [bc], a ; $40bc
	inc bc ; $40bd
	pop af ; $40be
	ld [bc], a ; $40bf
	inc bc ; $40c0
	xor a ; $40c1
	ld [bc], a ; $40c2
	pop bc ; $40c3
	pop af ; $40c4
	ret ; $40c5
SetActorPosition:
	inc b ; $40c6
	dec b ; $40c7
	ret z ; $40c8
	push af ; $40c9
	push de ; $40ca
	push hl ; $40cb
	wram_bank WRAM_ACTORS ; $40cc
	push hl ; $40d2
	ld hl, ACTORF_Y ; $40d3
	add hl, bc ; $40d6
	ld a, e ; $40d7
	ld [hl+], a ; $40d8
	ld [hl], d ; $40d9
	ld hl, ACTORF_TARGET_Y ; $40da
	add hl, bc ; $40dd
	ld a, e ; $40de
	ld [hl+], a ; $40df
	ld [hl], d ; $40e0
	pop de ; $40e1
	ld hl, ACTORF_X ; $40e2
	add hl, bc ; $40e5
	ld a, e ; $40e6
	ld [hl+], a ; $40e7
	ld [hl], d ; $40e8
	ld hl, ACTORF_TARGET_X ; $40e9
	add hl, bc ; $40ec
	ld a, e ; $40ed
	ld [hl+], a ; $40ee
	ld [hl], d ; $40ef
	pop hl ; $40f0
	pop de ; $40f1
	pop af ; $40f2
	ret ; $40f3
Unused_04_SetActorTarget:
	inc b ; $40f4
	dec b ; $40f5
	ret z ; $40f6
	push af ; $40f7
	push de ; $40f8
	push hl ; $40f9
	wram_bank WRAM_ACTORS ; $40fa
	push hl ; $4100
	ld hl, ACTORF_TARGET_Y ; $4101
	add hl, bc ; $4104
	ld a, e ; $4105
	ld [hl+], a ; $4106
	ld [hl], d ; $4107
	pop de ; $4108
	ld hl, ACTORF_TARGET_X ; $4109
	add hl, bc ; $410c
	ld a, e ; $410d
	ld [hl+], a ; $410e
	ld [hl], d ; $410f
	pop af ; $4110
	pop hl ; $4111
	pop de ; $4112
	ret ; $4113
Unused_04_SetActorTargetRelative:
	inc b ; $4114
	dec b ; $4115
	ret z ; $4116
	push af ; $4117
	push de ; $4118
	push hl ; $4119
	wram_bank WRAM_ACTORS ; $411a
	push hl ; $4120
	ld hl, ACTORF_Y ; $4121
	add hl, bc ; $4124
	ld a, [hl+] ; $4125
	ld h, [hl] ; $4126
	ld l, a ; $4127
	add hl, de ; $4128
	ld e, l ; $4129
	ld d, h ; $412a
	ld hl, ACTORF_TARGET_Y ; $412b
	add hl, bc ; $412e
	ld a, e ; $412f
	ld [hl+], a ; $4130
	ld [hl], d ; $4131
	pop de ; $4132
	ld hl, ACTORF_X ; $4133
	add hl, bc ; $4136
	ld a, [hl+] ; $4137
	ld h, [hl] ; $4138
	ld l, a ; $4139
	add hl, de ; $413a
	ld e, l ; $413b
	ld d, h ; $413c
	ld hl, ACTORF_TARGET_X ; $413d
	add hl, bc ; $4140
	ld a, e ; $4141
	ld [hl+], a ; $4142
	ld [hl], d ; $4143
	pop af ; $4144
	pop hl ; $4145
	pop de ; $4146
	ret ; $4147
SetActorMode:
	inc b ; $4148
	dec b ; $4149
	ret z ; $414a
	push af ; $414b
	push hl ; $414c
	wram_bank WRAM_ACTORS ; $414d
	ld hl, ACTORF_MODE ; $4153
	add hl, bc ; $4156
	ld [hl], d ; $4157
	pop hl ; $4158
	pop af ; $4159
	ret ; $415a
AttachActorControllerScript:
	inc b ; $415b
	dec b ; $415c
	ret z ; $415d
	push af ; $415e
	push de ; $415f
	push hl ; $4160
	ldh a, [hRomBank] ; $4161
	ld hl, ActorScript_PlayerControl ; $4163
	call SetActorScript ; $4166
	ld hl, ACTORF_FLAGS ; $4169
	add hl, bc ; $416c
	res ACTORFLAGB_SOLID, [hl] ; $416d
	res ACTORFLAGB_TALKABLE, [hl] ; $416f
	ld hl, ACTORF_STATUS ; $4171
	add hl, bc ; $4174
	set ACTORSTATUSB_FACING_LOCKED, [hl] ; $4175
	pop hl ; $4177
	pop de ; $4178
	pop af ; $4179
	ret ; $417a
AttachActorWaypointFollower:
	inc b ; $417b
	dec b ; $417c
	ret z ; $417d
	push af ; $417e
	push de ; $417f
	push hl ; $4180
	wram_bank WRAM_ACTORS ; $4181
	ld hl, $0016 ; $4187
	add hl, bc ; $418a
	ld a, e ; $418b
	ld [hl+], a ; $418c
	ld [hl], d ; $418d
	ldh a, [hRomBank] ; $418e
	ld hl, ActorScript_FollowWaypoints ; $4190
	call SetActorScript ; $4193
	ld hl, ACTORF_MODE ; $4196
	add hl, bc ; $4199
	ld [hl], $01 ; $419a
	ld hl, $0015 ; $419c
	add hl, bc ; $419f
	ld [hl], $40 ; $41a0
	pop hl ; $41a2
	pop de ; $41a3
	pop af ; $41a4
	ret ; $41a5
AttachActorStepMover:
	inc b ; $41a6
	dec b ; $41a7
	ret z ; $41a8
	push af ; $41a9
	push de ; $41aa
	push hl ; $41ab
	ld hl, $0016 ; $41ac
	add hl, bc ; $41af
	ld a, e ; $41b0
	ld [hl+], a ; $41b1
	ld [hl], d ; $41b2
	ldh a, [hRomBank] ; $41b3
	ld hl, ActorScript_StepToTarget ; $41b5
	call SetActorScript ; $41b8
	ld hl, ACTORF_FLAGS ; $41bb
	add hl, bc ; $41be
	res ACTORFLAGB_SOLID, [hl] ; $41bf
	ld hl, $0015 ; $41c1
	add hl, bc ; $41c4
	ld [hl], $40 ; $41c5
	ld hl, ACTORF_FLAGS ; $41c7
	add hl, bc ; $41ca
	res ACTORFLAGB_TALKABLE, [hl] ; $41cb
	pop hl ; $41cd
	pop de ; $41ce
	pop af ; $41cf
	ret ; $41d0
ActorScript_Idle:
	; $41d1, 1 bytes (actor_script)
	as_halt
ActorScript_PlayerControl:
	; $41d2, 6 bytes (actor_script)
	as_call UpdatePlayerControl
	as_jump ActorScript_PlayerControl
ActorScript_FollowWaypoints:
	; $41d8, 4 bytes (actor_script)
	as_follow_wp
	as_jump ActorScript_FollowWaypoints
ActorScript_StepToTarget:
	; $41dc, 6 bytes (actor_script)
	as_step
	as_wait $01
	as_jump ActorScript_StepToTarget
ActorScript_Deactivate:
	; $41e2, 5 bytes (actor_script)
	as_set_field ACTORF_MODE, $0000
	as_halt
UpdateActors:
	wram_bank WRAM_ACTORS ; $41e7
	ld hl, wActors ; $41ed
	ld c, $18 ; $41f0
.actorLoop:
	inc hl ; $41f2
	ld a, [hl-] ; $41f3
	or a ; $41f4
	jr z, .next ; $41f5
	push bc ; $41f7
	push hl ; $41f8
	ld a, l ; $41f9
	ldh [hActorPtr], a ; $41fa
	ld a, h ; $41fc
	ldh [hActorPtr + 1], a ; $41fd
	ld c, l ; $41ff
	ld b, h ; $4200
	call StepActorScript ; $4201
	call UpdateActorJumpPhysics ; $4204
	call AdvanceActorTowardTarget ; $4207
	call UpdateCameraIfActorIsCameraTarget ; $420a
	pop hl ; $420d
	pop bc ; $420e
.next:
	ld de, $0040 ; $420f
	add hl, de ; $4212
	dec c ; $4213
	jr nz, .actorLoop ; $4214
	ld hl, wActors + ACTORF_X ; $4216
	ld de, wStoryModePlayersXPosition ; $4219
	ld bc, $0004 ; $421c
	call CopyMemoryBC ; $421f
	ld a, [wActors + ACTORF_DRAWN_FACING] ; $4222
	ld [wStoryModePlayerFacing], a ; $4225
	ret ; $4228
StepActorScript:
	ld hl, ACTORF_FLAGS ; $4229
	add hl, bc ; $422c
	bit ACTORFLAGB_PAUSED, [hl] ; $422d
	ret nz ; $422f
	ld hl, ACTORF_WAIT ; $4230
	add hl, bc ; $4233
	ld a, [hl] ; $4234
	or a ; $4235
	jr z, .stepJump ; $4236
	dec [hl] ; $4238
	ret ; $4239
.stepJump:
	push bc ; $423a
	ld hl, ACTORF_SCRIPT ; $423b
	add hl, bc ; $423e
	ld a, [hl+] ; $423f
	ld e, a ; $4240
	ld a, [hl+] ; $4241
	ld d, a ; $4242
	ld a, [hl+] ; $4243
	ld [wActorScriptBank], a ; $4244
.applyGravity:
	push bc ; $4247
	ld a, [wActorScriptBank] ; $4248
	ld l, e ; $424b
	ld h, d ; $424c
	call FarReadByte ; $424d
	ld hl, ActorScriptOpcodeReturn ; $4250
	push hl ; $4253
	add a ; $4254
	ld_hl_indexed ActorScriptOpHandlers_04 ; $4255
	ld a, [hl+] ; $425c
	ld h, [hl] ; $425d
	ld l, a ; $425e
	jp hl ; $425f
ActorScriptOpcodeReturn:
	pop bc ; $4260
	ld hl, ACTORF_SCRIPT ; $4261
	add hl, bc ; $4264
	ld [hl], e ; $4265
	inc hl ; $4266
	ld [hl], d ; $4267
	inc hl ; $4268
	or a ; $4269
	jr nz, StepActorScript.applyGravity ; $426a
	pop bc ; $426c
	ret ; $426d
UpdateActorJumpPhysics:
	ld hl, $0012 ; $426e
	add hl, bc ; $4271
	ld a, [hl+] ; $4272
	ld d, [hl] ; $4273
	ld e, a ; $4274
	ld hl, $0010 ; $4275
	add hl, bc ; $4278
	ld a, [hl+] ; $4279
	ld h, [hl] ; $427a
	ld l, a ; $427b
	or h ; $427c
	or d ; $427d
	or e ; $427e
	jr z, .done ; $427f
	push hl ; $4281
	ld hl, $0010 ; $4282
	add hl, de ; $4285
	ld e, l ; $4286
	ld d, h ; $4287
	pop hl ; $4288
	add hl, de ; $4289
	bit 7, h ; $428a
	jr nz, .storeVelocity ; $428c
	xor a ; $428e
	ld hl, $0010 ; $428f
	add hl, bc ; $4292
	ld [hl+], a ; $4293
	ld [hl+], a ; $4294
	ld hl, $0012 ; $4295
	add hl, bc ; $4298
	ld [hl+], a ; $4299
	ld [hl+], a ; $429a
	jr .done ; $429b
.storeVelocity:
	push hl ; $429d
	ld hl, $0012 ; $429e
	add hl, bc ; $42a1
	ld a, e ; $42a2
	ld [hl+], a ; $42a3
	ld [hl], d ; $42a4
	pop de ; $42a5
	ld hl, $0010 ; $42a6
	add hl, bc ; $42a9
	ld a, e ; $42aa
	ld [hl+], a ; $42ab
	ld [hl], d ; $42ac
.done:
	ret ; $42ad
AdvanceActorTowardTarget:
	ld hl, ACTORF_FLAGS ; $42ae
	add hl, bc ; $42b1
	res 6, [hl] ; $42b2
	bit 1, [hl] ; $42b4
	ret nz ; $42b6
	bit 7, [hl] ; $42b7
	ret z ; $42b9
	push bc ; $42ba
	ld hl, ACTORF_TARGET_X ; $42bb
	add hl, bc ; $42be
	ld a, [hl+] ; $42bf
	ld d, [hl] ; $42c0
	ld e, a ; $42c1
	ld hl, ACTORF_X ; $42c2
	add hl, bc ; $42c5
	ld a, [hl+] ; $42c6
	ld h, [hl] ; $42c7
	ld l, a ; $42c8
	ld a, l ; $42c9
	sub e ; $42ca
	ld l, a ; $42cb
	ld a, h ; $42cc
	sbc d ; $42cd
	ld h, a ; $42ce
	push hl ; $42cf
	ld hl, ACTORF_TARGET_Y ; $42d0
	add hl, bc ; $42d3
	ld a, [hl+] ; $42d4
	ld d, [hl] ; $42d5
	ld e, a ; $42d6
	ld hl, ACTORF_Y ; $42d7
	add hl, bc ; $42da
	ld a, [hl+] ; $42db
	ld h, [hl] ; $42dc
	ld l, a ; $42dd
	ld a, l ; $42de
	sub e ; $42df
	ld l, a ; $42e0
	ld a, h ; $42e1
	sbc d ; $42e2
	ld h, a ; $42e3
	pop de ; $42e4
	push de ; $42e5
	push hl ; $42e6
	call AngleFromVectorCoarse ; $42e7
	add $80 ; $42ea
	push af ; $42ec
	ld hl, ACTORF_HEADING ; $42ed
	add hl, bc ; $42f0
	ld e, [hl] ; $42f1
	sub e ; $42f2
	ld d, a ; $42f3
	bit 7, a ; $42f4
	jr z, .absDeltaX ; $42f6
	cpl ; $42f8
	inc a ; $42f9
.absDeltaX:
	cp $60 ; $42fa
	jr c, .compareDeltas ; $42fc
	ld a, e ; $42fe
	add $80 ; $42ff
	ld e, a ; $4301
	ld a, d ; $4302
	add $80 ; $4303
	ld d, a ; $4305
	bit 7, a ; $4306
	jr z, .compareDeltas ; $4308
	cpl ; $430a
	inc a ; $430b
.compareDeltas:
	inc hl ; $430c
	cp [hl] ; $430d
	ld a, d ; $430e
	jr c, .stepAxis ; $430f
	ld a, [hl] ; $4311
	bit 7, d ; $4312
	jr z, .stepAxis ; $4314
	cpl ; $4316
	inc a ; $4317
.stepAxis:
	add e ; $4318
	dec hl ; $4319
	ld [hl], a ; $431a
	ld e, a ; $431b
	ld hl, $0006 ; $431c
	add hl, bc ; $431f
	ld a, [hl+] ; $4320
	ld h, [hl] ; $4321
	ld l, a ; $4322
	ld a, e ; $4323
	call VectorFromLengthAndAngleRaw ; $4324
	push hl ; $4327
	ld hl, hActorPtr ; $4328
	ld a, [hl+] ; $432b
	ld b, [hl] ; $432c
	ld c, a ; $432d
	ld hl, ACTORF_FLAGS ; $432e
	add hl, bc ; $4331
	bit 2, [hl] ; $4332
	pop hl ; $4334
	jr z, .arrived ; $4335
	push de ; $4337
	push hl ; $4338
	push de ; $4339
	ld e, l ; $433a
	ld d, h ; $433b
	ld hl, ACTORF_X ; $433c
	add hl, bc ; $433f
	ld a, [hl+] ; $4340
	ld h, [hl] ; $4341
	ld l, a ; $4342
	add hl, de ; $4343
	pop de ; $4344
	push hl ; $4345
	ld hl, ACTORF_Y ; $4346
	add hl, bc ; $4349
	ld a, [hl+] ; $434a
	ld h, [hl] ; $434b
	ld l, a ; $434c
	add hl, de ; $434d
	ld e, l ; $434e
	ld d, h ; $434f
	pop hl ; $4350
	call IsPointNearPlayer ; $4351
	pop hl ; $4354
	pop de ; $4355
	and a ; $4356
	jr z, .arrived ; $4357
	ld hl, ACTORF_FLAGS ; $4359
	add hl, bc ; $435c
	set 6, [hl] ; $435d
	pop af ; $435f
	pop hl ; $4360
	pop de ; $4361
	jp .done ; $4362
.arrived:
	ld bc, $0001 ; $4365
	pop af ; $4368
	add $20 ; $4369
	and $40 ; $436b
	jr z, .storeArrival ; $436d
	inc c ; $436f
.storeArrival:
	push hl ; $4370
	ld hl, hActorPtr ; $4371
	ld a, [hl+] ; $4374
	ld h, [hl] ; $4375
	add $0e ; $4376
	ld l, a ; $4378
	push hl ; $4379
	ld a, [hl+] ; $437a
	ld h, [hl] ; $437b
	ld l, a ; $437c
	add hl, de ; $437d
	pop de ; $437e
	ld a, l ; $437f
	ld [de], a ; $4380
	inc de ; $4381
	ld a, h ; $4382
	ld [de], a ; $4383
	push hl ; $4384
	ld hl, hActorPtr ; $4385
	ld a, [hl+] ; $4388
	ld h, [hl] ; $4389
	add $0a ; $438a
	ld l, a ; $438c
	ld a, [hl+] ; $438d
	ld d, [hl] ; $438e
	ld e, a ; $438f
	pop hl ; $4390
	ld a, l ; $4391
	sub e ; $4392
	ld l, a ; $4393
	ld a, h ; $4394
	sbc d ; $4395
	ld h, a ; $4396
	ld a, h ; $4397
	or l ; $4398
	jr nz, .stepTowardTarget ; $4399
	set 1, b ; $439b
.stepTowardTarget:
	pop de ; $439d
	ld a, h ; $439e
	pop hl ; $439f
	xor h ; $43a0
	bit 7, a ; $43a1
	jr z, .applyStep ; $43a3
	set 1, b ; $43a5
.applyStep:
	ld hl, hActorPtr ; $43a7
	ld a, [hl+] ; $43aa
	ld h, [hl] ; $43ab
	add $0c ; $43ac
	ld l, a ; $43ae
	push hl ; $43af
	ld a, [hl+] ; $43b0
	ld h, [hl] ; $43b1
	ld l, a ; $43b2
	add hl, de ; $43b3
	pop de ; $43b4
	ld a, l ; $43b5
	ld [de], a ; $43b6
	inc de ; $43b7
	ld a, h ; $43b8
	ld [de], a ; $43b9
	push hl ; $43ba
	ld hl, hActorPtr ; $43bb
	ld a, [hl+] ; $43be
	ld h, [hl] ; $43bf
	add $08 ; $43c0
	ld l, a ; $43c2
	ld a, [hl+] ; $43c3
	ld d, [hl] ; $43c4
	ld e, a ; $43c5
	pop hl ; $43c6
	ld a, l ; $43c7
	sub e ; $43c8
	ld l, a ; $43c9
	ld a, h ; $43ca
	sbc d ; $43cb
	ld h, a ; $43cc
	ld a, h ; $43cd
	or l ; $43ce
	jr nz, .clampToTarget ; $43cf
	set 0, b ; $43d1
.clampToTarget:
	ld a, h ; $43d3
	pop hl ; $43d4
	xor h ; $43d5
	bit 7, a ; $43d6
	jr z, .storePosition ; $43d8
	set 0, b ; $43da
.storePosition:
	ld a, b ; $43dc
	and c ; $43dd
	jr z, .done ; $43de
	ld hl, hActorPtr ; $43e0
	ld a, [hl+] ; $43e3
	ld b, [hl] ; $43e4
	ld c, a ; $43e5
	ld hl, ACTORF_FLAGS ; $43e6
	add hl, bc ; $43e9
	res ACTORFLAGB_MOVING, [hl] ; $43ea
	ld a, ACTORF_X ; $43ec
	add c ; $43ee
	ld e, a ; $43ef
	ld d, b ; $43f0
	ld hl, ACTORF_TARGET_X ; $43f1
	add hl, bc ; $43f4
	ld a, [hl+] ; $43f5
	ld [de], a ; $43f6
	inc de ; $43f7
	ld a, [hl+] ; $43f8
	ld [de], a ; $43f9
	inc de ; $43fa
	ld a, [hl+] ; $43fb
	ld [de], a ; $43fc
	inc de ; $43fd
	ld a, [hl+] ; $43fe
	ld [de], a ; $43ff
.done:
	pop bc ; $4400
	ret ; $4401
