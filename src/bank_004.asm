SECTION "ROM Bank $04", ROMX[$4000], BANK[$04]

FarPtr_InitActorEngine:
	dw InitActorEngine ; $4000
FarPtr_SpawnActor:
	dw SpawnActor ; $4002
FarPtr_SetActorScript:
	dw SetActorScript ; $4004
FarPtr_SetActorPosition:
	dw SetActorPosition ; $4006
FarPtr_SetActorMode:
	dw SetActorMode ; $4008
FarPtr_SpawnActorsFromList:
	dw SpawnActorsFromList ; $400a
FarPtr_UpdateCameraToActor:
	dw UpdateCameraToActor ; $400c
FarPtr_04_0e:
	dw Func_04_4d2c ; $400e
FarPtr_ClearActorSlots:
	dw ClearActorSlots ; $4010
FarPtr_04_12:
	dw Func_04_4b68 ; $4012
FarPtr_EvalFlagCondition:
	dw EvalFlagCondition ; $4014
FarPtr_SetActorAnimationChecked:
	dw SetActorAnimationChecked ; $4016
FarPtr_SpawnMainCharacterActor:
	dw SpawnMainCharacterActor ; $4018
FarPtr_SpawnCompanionActor:
	dw SpawnCompanionActor ; $401a
FarPtr_AttachActorControllerScript:
	dw AttachActorControllerScript ; $401c
FarPtr_AttachActorWaypointFollower:
	dw AttachActorWaypointFollower ; $401e
FarPtr_AttachActorStepMover:
	dw AttachActorStepMover ; $4020
FarPtr_IsTerrainBlockedAtPoint:
	dw IsTerrainBlockedAtPoint ; $4022
FarPtr_FindActorAtPoint:
	dw FindActorAtPoint ; $4024
FarPtr_04_26:
	dw Func_04_54d7 ; $4026
FarPtr_WaitActorMoveDone:
	dw WaitActorMoveDone ; $4028
FarPtr_04_2a:
	dw Func_04_5726 ; $402a
FarPtr_LoadActorObjectDefIfValid:
	dw LoadActorObjectDefIfValid ; $402c
FarPtr_GetObjectDefCount:
	dw GetObjectDefCount ; $402e
FarPtr_LookupTileId_04:
	dw LookupTileId_04 ; $4030
ClearActorSlots:
	wram_bank $04 ; $4032
	ld hl, $d000 ; $4038
	ld c, $60 ; $403b
	call ClearMemory16 ; $403d
	ret ; $4040
InitActorEngine:
	call ClearActorSlots ; $4041
	ld a, $10 ; $4044
	ld hl, $41e7 ; $4046
	call RegisterFrameTask ; $4049
	ld a, $01 ; $404c
	ld hl, $4a82 ; $404e
	call RegisterFrameTask ; $4051
	ret ; $4054
SpawnActor:
	push af ; $4055
	push de ; $4056
	push hl ; $4057
	wram_bank $04 ; $4058
	ld hl, $d000 ; $405e
	ld c, $18 ; $4061
Label_04_4063:
	inc hl ; $4063
	ld a, [hl-] ; $4064
	or a, a ; $4065
	jr z, Label_04_4076 ; $4066
	ld de, $0040 ; $4068
	add hl, de ; $406b
	dec c ; $406c
	jr nz, Label_04_4063 ; $406d
	ld bc, $0000 ; $406f
	pop hl ; $4072
	pop de ; $4073
	pop af ; $4074
	ret ; $4075
Label_04_4076:
	ld c, l ; $4076
	ld b, h ; $4077
	ld de, $b000 ; $4078
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
	ld hl, $0020 ; $4091
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
	jr Label_04_40af ; $40aa
SetActorScript:
	inc b ; $40ac
	dec b ; $40ad
	ret z ; $40ae
Label_04_40af:
	push af ; $40af
	push bc ; $40b0
	push af ; $40b1
	wram_bank $04 ; $40b2
	ld a, l ; $40b8
	ld [bc], a ; $40b9
	inc bc ; $40ba
	ld a, h ; $40bb
	ld [bc], a ; $40bc
	inc bc ; $40bd
	pop af ; $40be
	ld [bc], a ; $40bf
	inc bc ; $40c0
	xor a, a ; $40c1
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
	wram_bank $04 ; $40cc
	push hl ; $40d2
	ld hl, $000e ; $40d3
	add hl, bc ; $40d6
	ld a, e ; $40d7
	ld [hl+], a ; $40d8
	ld [hl], d ; $40d9
	ld hl, $000a ; $40da
	add hl, bc ; $40dd
	ld a, e ; $40de
	ld [hl+], a ; $40df
	ld [hl], d ; $40e0
	pop de ; $40e1
	ld hl, $000c ; $40e2
	add hl, bc ; $40e5
	ld a, e ; $40e6
	ld [hl+], a ; $40e7
	ld [hl], d ; $40e8
	ld hl, $0008 ; $40e9
	add hl, bc ; $40ec
	ld a, e ; $40ed
	ld [hl+], a ; $40ee
	ld [hl], d ; $40ef
	pop hl ; $40f0
	pop de ; $40f1
	pop af ; $40f2
	ret ; $40f3
	INCBIN "data/bank_004/d_40f4.bin" ; $40f4, 84 bytes
SetActorMode:
	inc b ; $4148
	dec b ; $4149
	ret z ; $414a
	push af ; $414b
	push hl ; $414c
	wram_bank $04 ; $414d
	ld hl, $0020 ; $4153
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
	ld hl, $41d2 ; $4163
	call SetActorScript ; $4166
	ld hl, $0005 ; $4169
	add hl, bc ; $416c
	res 3, [hl] ; $416d
	res 4, [hl] ; $416f
	ld hl, $0030 ; $4171
	add hl, bc ; $4174
	set 0, [hl] ; $4175
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
	wram_bank $04 ; $4181
	ld hl, $0016 ; $4187
	add hl, bc ; $418a
	ld a, e ; $418b
	ld [hl+], a ; $418c
	ld [hl], d ; $418d
	ldh a, [hRomBank] ; $418e
	ld hl, $41d8 ; $4190
	call SetActorScript ; $4193
	ld hl, $0020 ; $4196
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
	ld hl, $41dc ; $41b5
	call SetActorScript ; $41b8
	ld hl, $0005 ; $41bb
	add hl, bc ; $41be
	res 3, [hl] ; $41bf
	ld hl, $0015 ; $41c1
	add hl, bc ; $41c4
	ld [hl], $40 ; $41c5
	ld hl, $0005 ; $41c7
	add hl, bc ; $41ca
	res 4, [hl] ; $41cb
	pop hl ; $41cd
	pop de ; $41ce
	pop af ; $41cf
	ret ; $41d0
FollowerActorScript_04:
	INCBIN "data/bank_004/d_41d1.bin" ; $41d1, 22 bytes
	wram_bank $04 ; $41e7
	ld hl, $d000 ; $41ed
	ld c, $18 ; $41f0
Label_04_41f2:
	inc hl ; $41f2
	ld a, [hl-] ; $41f3
	or a, a ; $41f4
	jr z, Label_04_420f ; $41f5
	push bc ; $41f7
	push hl ; $41f8
	ld a, l ; $41f9
	ldh [hActorPtr], a ; $41fa
	ld a, h ; $41fc
	ldh [$ffeb], a ; $41fd
	ld c, l ; $41ff
	ld b, h ; $4200
	call StepActorScript ; $4201
	call Func_04_426e ; $4204
	call Func_04_42ae ; $4207
	call Func_04_4402 ; $420a
	pop hl ; $420d
	pop bc ; $420e
Label_04_420f:
	ld de, $0040 ; $420f
	add hl, de ; $4212
	dec c ; $4213
	jr nz, Label_04_41f2 ; $4214
	ld hl, $d00c ; $4216
	ld de, wStoryModePlayersXPosition ; $4219
	ld bc, $0004 ; $421c
	call CopyMemoryBC ; $421f
	ld a, [$d032] ; $4222
	ld [$c2d4], a ; $4225
	ret ; $4228
StepActorScript:
	ld hl, $0005 ; $4229
	add hl, bc ; $422c
	bit 0, [hl] ; $422d
	ret nz ; $422f
	ld hl, $0003 ; $4230
	add hl, bc ; $4233
	ld a, [hl] ; $4234
	or a, a ; $4235
	jr z, Label_04_423a ; $4236
	dec [hl] ; $4238
	ret ; $4239
Label_04_423a:
	push bc ; $423a
	ld hl, $0000 ; $423b
	add hl, bc ; $423e
	ld a, [hl+] ; $423f
	ld e, a ; $4240
	ld a, [hl+] ; $4241
	ld d, a ; $4242
	ld a, [hl+] ; $4243
	ld [$daf7], a ; $4244
Label_04_4247:
	push bc ; $4247
	ld a, [$daf7] ; $4248
	ld l, e ; $424b
	ld h, d ; $424c
	call FarReadByte ; $424d
	ld hl, $4260 ; $4250
	push hl ; $4253
	add a, a ; $4254
	add a, $7d ; $4255
	ld l, a ; $4257
	adc a, $44 ; $4258
	sub a, l ; $425a
	ld h, a ; $425b
	ld a, [hl+] ; $425c
	ld h, [hl] ; $425d
	ld l, a ; $425e
	jp hl ; $425f
	pop bc ; $4260
	ld hl, $0000 ; $4261
	add hl, bc ; $4264
	ld [hl], e ; $4265
	inc hl ; $4266
	ld [hl], d ; $4267
	inc hl ; $4268
	or a, a ; $4269
	jr nz, Label_04_4247 ; $426a
	pop bc ; $426c
	ret ; $426d
Func_04_426e:
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
	or a, h ; $427c
	or a, d ; $427d
	or a, e ; $427e
	jr z, Label_04_42ad ; $427f
	push hl ; $4281
	ld hl, $0010 ; $4282
	add hl, de ; $4285
	ld e, l ; $4286
	ld d, h ; $4287
	pop hl ; $4288
	add hl, de ; $4289
	bit 7, h ; $428a
	jr nz, Label_04_429d ; $428c
	xor a, a ; $428e
	ld hl, $0010 ; $428f
	add hl, bc ; $4292
	ld [hl+], a ; $4293
	ld [hl+], a ; $4294
	ld hl, $0012 ; $4295
	add hl, bc ; $4298
	ld [hl+], a ; $4299
	ld [hl+], a ; $429a
	jr Label_04_42ad ; $429b
Label_04_429d:
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
Label_04_42ad:
	ret ; $42ad
Func_04_42ae:
	ld hl, $0005 ; $42ae
	add hl, bc ; $42b1
	res 6, [hl] ; $42b2
	bit 1, [hl] ; $42b4
	ret nz ; $42b6
	bit 7, [hl] ; $42b7
	ret z ; $42b9
	push bc ; $42ba
	ld hl, $0008 ; $42bb
	add hl, bc ; $42be
	ld a, [hl+] ; $42bf
	ld d, [hl] ; $42c0
	ld e, a ; $42c1
	ld hl, $000c ; $42c2
	add hl, bc ; $42c5
	ld a, [hl+] ; $42c6
	ld h, [hl] ; $42c7
	ld l, a ; $42c8
	ld a, l ; $42c9
	sub a, e ; $42ca
	ld l, a ; $42cb
	ld a, h ; $42cc
	sbc a, d ; $42cd
	ld h, a ; $42ce
	push hl ; $42cf
	ld hl, $000a ; $42d0
	add hl, bc ; $42d3
	ld a, [hl+] ; $42d4
	ld d, [hl] ; $42d5
	ld e, a ; $42d6
	ld hl, $000e ; $42d7
	add hl, bc ; $42da
	ld a, [hl+] ; $42db
	ld h, [hl] ; $42dc
	ld l, a ; $42dd
	ld a, l ; $42de
	sub a, e ; $42df
	ld l, a ; $42e0
	ld a, h ; $42e1
	sbc a, d ; $42e2
	ld h, a ; $42e3
	pop de ; $42e4
	push de ; $42e5
	push hl ; $42e6
	call AngleFromVectorCoarse ; $42e7
	add a, $80 ; $42ea
	push af ; $42ec
	ld hl, $0014 ; $42ed
	add hl, bc ; $42f0
	ld e, [hl] ; $42f1
	sub a, e ; $42f2
	ld d, a ; $42f3
	bit 7, a ; $42f4
	jr z, Label_04_42fa ; $42f6
	cpl ; $42f8
	inc a ; $42f9
Label_04_42fa:
	cp a, $60 ; $42fa
	jr c, Label_04_430c ; $42fc
	ld a, e ; $42fe
	add a, $80 ; $42ff
	ld e, a ; $4301
	ld a, d ; $4302
	add a, $80 ; $4303
	ld d, a ; $4305
	bit 7, a ; $4306
	jr z, Label_04_430c ; $4308
	cpl ; $430a
	inc a ; $430b
Label_04_430c:
	inc hl ; $430c
	cp a, [hl] ; $430d
	ld a, d ; $430e
	jr c, Label_04_4318 ; $430f
	ld a, [hl] ; $4311
	bit 7, d ; $4312
	jr z, Label_04_4318 ; $4314
	cpl ; $4316
	inc a ; $4317
Label_04_4318:
	add a, e ; $4318
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
	ld hl, $0005 ; $432e
	add hl, bc ; $4331
	bit 2, [hl] ; $4332
	pop hl ; $4334
	jr z, Label_04_4365 ; $4335
	push de ; $4337
	push hl ; $4338
	push de ; $4339
	ld e, l ; $433a
	ld d, h ; $433b
	ld hl, $000c ; $433c
	add hl, bc ; $433f
	ld a, [hl+] ; $4340
	ld h, [hl] ; $4341
	ld l, a ; $4342
	add hl, de ; $4343
	pop de ; $4344
	push hl ; $4345
	ld hl, $000e ; $4346
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
	and a, a ; $4356
	jr z, Label_04_4365 ; $4357
	ld hl, $0005 ; $4359
	add hl, bc ; $435c
	set 6, [hl] ; $435d
	pop af ; $435f
	pop hl ; $4360
	pop de ; $4361
	jp Label_04_4400 ; $4362
Label_04_4365:
	ld bc, $0001 ; $4365
	pop af ; $4368
	add a, $20 ; $4369
	and a, $40 ; $436b
	jr z, Label_04_4370 ; $436d
	inc c ; $436f
Label_04_4370:
	push hl ; $4370
	ld hl, hActorPtr ; $4371
	ld a, [hl+] ; $4374
	ld h, [hl] ; $4375
	add a, $0e ; $4376
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
	add a, $0a ; $438a
	ld l, a ; $438c
	ld a, [hl+] ; $438d
	ld d, [hl] ; $438e
	ld e, a ; $438f
	pop hl ; $4390
	ld a, l ; $4391
	sub a, e ; $4392
	ld l, a ; $4393
	ld a, h ; $4394
	sbc a, d ; $4395
	ld h, a ; $4396
	ld a, h ; $4397
	or a, l ; $4398
	jr nz, Label_04_439d ; $4399
	set 1, b ; $439b
Label_04_439d:
	pop de ; $439d
	ld a, h ; $439e
	pop hl ; $439f
	xor a, h ; $43a0
	bit 7, a ; $43a1
	jr z, Label_04_43a7 ; $43a3
	set 1, b ; $43a5
Label_04_43a7:
	ld hl, hActorPtr ; $43a7
	ld a, [hl+] ; $43aa
	ld h, [hl] ; $43ab
	add a, $0c ; $43ac
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
	add a, $08 ; $43c0
	ld l, a ; $43c2
	ld a, [hl+] ; $43c3
	ld d, [hl] ; $43c4
	ld e, a ; $43c5
	pop hl ; $43c6
	ld a, l ; $43c7
	sub a, e ; $43c8
	ld l, a ; $43c9
	ld a, h ; $43ca
	sbc a, d ; $43cb
	ld h, a ; $43cc
	ld a, h ; $43cd
	or a, l ; $43ce
	jr nz, Label_04_43d3 ; $43cf
	set 0, b ; $43d1
Label_04_43d3:
	ld a, h ; $43d3
	pop hl ; $43d4
	xor a, h ; $43d5
	bit 7, a ; $43d6
	jr z, Label_04_43dc ; $43d8
	set 0, b ; $43da
Label_04_43dc:
	ld a, b ; $43dc
	and a, c ; $43dd
	jr z, Label_04_4400 ; $43de
	ld hl, hActorPtr ; $43e0
	ld a, [hl+] ; $43e3
	ld b, [hl] ; $43e4
	ld c, a ; $43e5
	ld hl, $0005 ; $43e6
	add hl, bc ; $43e9
	res 7, [hl] ; $43ea
	ld a, $0c ; $43ec
	add a, c ; $43ee
	ld e, a ; $43ef
	ld d, b ; $43f0
	ld hl, $0008 ; $43f1
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
Label_04_4400:
	pop bc ; $4400
	ret ; $4401
Func_04_4402:
	ld hl, $0020 ; $4402
	add hl, bc ; $4405
	ld a, [hl] ; $4406
	cp a, $01 ; $4407
	ret nz ; $4409
UpdateCameraToActor:
	push af ; $440a
	push de ; $440b
	push hl ; $440c
	wram_bank $04 ; $440d
	ld hl, $000c ; $4413
	add hl, bc ; $4416
	ld a, [hl+] ; $4417
	ld h, [hl] ; $4418
	ld l, a ; $4419
	ld de, $f610 ; $441a
	add hl, de ; $441d
	ld a, [$c329] ; $441e
	ld d, a ; $4421
	ld a, h ; $4422
	sub a, d ; $4423
	bit 7, a ; $4424
	jr z, Label_04_442d ; $4426
	ld h, d ; $4428
	ld l, $00 ; $4429
	jr Label_04_443c ; $442b
Label_04_442d:
	ld a, [$c32b] ; $442d
	sub a, $14 ; $4430
	ld d, a ; $4432
	ld a, h ; $4433
	sub a, d ; $4434
	bit 7, a ; $4435
	jr nz, Label_04_443c ; $4437
	ld h, d ; $4439
	ld l, $00 ; $443a
Label_04_443c:
	ld a, l ; $443c
	and a, $e0 ; $443d
	ld [wCameraX], a ; $443f
	ld a, h ; $4442
	ld [$c321], a ; $4443
	ld hl, $000e ; $4446
	add hl, bc ; $4449
	ld a, [hl+] ; $444a
	ld h, [hl] ; $444b
	ld l, a ; $444c
	ld de, $f710 ; $444d
	add hl, de ; $4450
	ld a, [$c32a] ; $4451
	ld d, a ; $4454
	ld a, h ; $4455
	sub a, d ; $4456
	bit 7, a ; $4457
	jr z, Label_04_4460 ; $4459
	ld h, d ; $445b
	ld l, $00 ; $445c
	jr Label_04_446f ; $445e
Label_04_4460:
	ld a, [$c32c] ; $4460
	sub a, $12 ; $4463
	ld d, a ; $4465
	ld a, h ; $4466
	sub a, d ; $4467
	bit 7, a ; $4468
	jr nz, Label_04_446f ; $446a
	ld h, d ; $446c
	ld l, $00 ; $446d
Label_04_446f:
	ld a, l ; $446f
	and a, $e0 ; $4470
	ld [wCameraY], a ; $4472
	ld a, h ; $4475
	ld [$c323], a ; $4476
	pop hl ; $4479
	pop de ; $447a
	pop af ; $447b
	ret ; $447c
	INCBIN "data/bank_004/d_447d.bin" ; $447d, 44 bytes
	inc de ; $44a9
	push de ; $44aa
	ld l, e ; $44ab
	ld h, d ; $44ac
	ld a, [$daf7] ; $44ad
	call FarReadWord ; $44b0
	push bc ; $44b3
	ld hl, hActorPtr ; $44b4
	ld a, [hl+] ; $44b7
	ld b, [hl] ; $44b8
	ld c, a ; $44b9
	pop hl ; $44ba
	ld a, [$daf7] ; $44bb
	call CallHLInBankA ; $44be
	pop de ; $44c1
	and a, a ; $44c2
	jr z, Label_04_44cd ; $44c3
	inc b ; $44c5
	dec b ; $44c6
	jr z, Label_04_44cd ; $44c7
	dec de ; $44c9
	ld a, $00 ; $44ca
	ret ; $44cc
Label_04_44cd:
	inc de ; $44cd
	inc de ; $44ce
	ret ; $44cf
	inc de ; $44d0
	ld a, [$daf7] ; $44d1
	ld l, e ; $44d4
	ld h, d ; $44d5
	call FarReadWord ; $44d6
	add hl, bc ; $44d9
	ld e, l ; $44da
	ld d, h ; $44db
	ld a, $01 ; $44dc
	ret ; $44de
	inc de ; $44df
	ld a, [$daf7] ; $44e0
	ld l, e ; $44e3
	ld h, d ; $44e4
	call FarReadByte ; $44e5
	inc de ; $44e8
	jr Label_04_4500 ; $44e9
	INCBIN "data/bank_004/d_44eb.bin" ; $44eb, 21 bytes
Label_04_4500:
	push af ; $4500
	ld a, [$daf7] ; $4501
	ld l, e ; $4504
	ld h, d ; $4505
	call FarReadWord ; $4506
	pop af ; $4509
	ld e, l ; $450a
	ld d, h ; $450b
	inc de ; $450c
	inc de ; $450d
	push de ; $450e
	ld l, c ; $450f
	ld h, b ; $4510
	call VectorFromLengthAndAngle ; $4511
	push hl ; $4514
	ld hl, hActorPtr ; $4515
	ld a, [hl+] ; $4518
	ld h, [hl] ; $4519
	add a, $0e ; $451a
	ld l, a ; $451c
	ld a, [hl+] ; $451d
	ld h, [hl] ; $451e
	ld l, a ; $451f
	add hl, de ; $4520
	ld e, l ; $4521
	ld d, h ; $4522
	ld hl, hActorPtr ; $4523
	ld a, [hl+] ; $4526
	ld h, [hl] ; $4527
	add a, $0a ; $4528
	ld l, a ; $452a
	ld a, e ; $452b
	ld [hl+], a ; $452c
	ld [hl], d ; $452d
	pop de ; $452e
	ld hl, hActorPtr ; $452f
	ld a, [hl+] ; $4532
	ld h, [hl] ; $4533
	add a, $0c ; $4534
	ld l, a ; $4536
	ld a, [hl+] ; $4537
	ld h, [hl] ; $4538
	ld l, a ; $4539
	add hl, de ; $453a
	ld e, l ; $453b
	ld d, h ; $453c
	ld hl, hActorPtr ; $453d
	ld a, [hl+] ; $4540
	ld h, [hl] ; $4541
	add a, $08 ; $4542
	ld l, a ; $4544
	ld a, e ; $4545
	ld [hl+], a ; $4546
	ld [hl], d ; $4547
	pop de ; $4548
	ld hl, hActorPtr ; $4549
	ld a, [hl+] ; $454c
	ld h, [hl] ; $454d
	add a, $05 ; $454e
	ld l, a ; $4550
	set 7, [hl] ; $4551
	ld a, $01 ; $4553
	ret ; $4555
	INCBIN "data/bank_004/d_4556.bin" ; $4556, 37 bytes
	inc de ; $457b
	push de ; $457c
	ld hl, hActorPtr ; $457d
	ld a, [hl+] ; $4580
	ld h, [hl] ; $4581
	add a, $08 ; $4582
	ld l, a ; $4584
	ld e, l ; $4585
	ld d, h ; $4586
	pop hl ; $4587
	ld a, [$daf7] ; $4588
	ld bc, $0004 ; $458b
	call FarCopyBytes ; $458e
	ld e, l ; $4591
	ld d, h ; $4592
	ld hl, hActorPtr ; $4593
	ld a, [hl+] ; $4596
	ld h, [hl] ; $4597
	add a, $05 ; $4598
	ld l, a ; $459a
	set 7, [hl] ; $459b
	ld a, $01 ; $459d
	ret ; $459f
	inc de ; $45a0
	ld a, [$daf7] ; $45a1
	ld l, e ; $45a4
	ld h, d ; $45a5
	call FarReadWord ; $45a6
	ld e, l ; $45a9
	ld d, h ; $45aa
	inc de ; $45ab
	inc de ; $45ac
	ld hl, hActorPtr ; $45ad
	ld a, [hl+] ; $45b0
	ld h, [hl] ; $45b1
	add a, $0c ; $45b2
	ld l, a ; $45b4
	ld a, [hl+] ; $45b5
	ld h, [hl] ; $45b6
	ld l, a ; $45b7
	add hl, bc ; $45b8
	ld c, l ; $45b9
	ld b, h ; $45ba
	ld hl, hActorPtr ; $45bb
	ld a, [hl+] ; $45be
	ld h, [hl] ; $45bf
	add a, $08 ; $45c0
	ld l, a ; $45c2
	ld a, c ; $45c3
	ld [hl+], a ; $45c4
	ld [hl], b ; $45c5
	ld a, [$daf7] ; $45c6
	ld l, e ; $45c9
	ld h, d ; $45ca
	call FarReadWord ; $45cb
	ld e, l ; $45ce
	ld d, h ; $45cf
	inc de ; $45d0
	inc de ; $45d1
	ld hl, hActorPtr ; $45d2
	ld a, [hl+] ; $45d5
	ld h, [hl] ; $45d6
	add a, $0e ; $45d7
	ld l, a ; $45d9
	ld a, [hl+] ; $45da
	ld h, [hl] ; $45db
	ld l, a ; $45dc
	add hl, bc ; $45dd
	ld c, l ; $45de
	ld b, h ; $45df
	ld hl, hActorPtr ; $45e0
	ld a, [hl+] ; $45e3
	ld h, [hl] ; $45e4
	add a, $0a ; $45e5
	ld l, a ; $45e7
	ld a, c ; $45e8
	ld [hl+], a ; $45e9
	ld [hl], b ; $45ea
	ld hl, hActorPtr ; $45eb
	ld a, [hl+] ; $45ee
	ld h, [hl] ; $45ef
	add a, $05 ; $45f0
	ld l, a ; $45f2
	set 7, [hl] ; $45f3
	ld a, $01 ; $45f5
	ret ; $45f7
	ld hl, hActorPtr ; $45f8
	ld a, [hl+] ; $45fb
	ld h, [hl] ; $45fc
	add a, $05 ; $45fd
	ld l, a ; $45ff
	bit 7, [hl] ; $4600
	jr nz, Label_04_4608 ; $4602
	inc de ; $4604
	ld a, $01 ; $4605
	ret ; $4607
Label_04_4608:
	xor a, a ; $4608
	ret ; $4609
	xor a, a ; $460a
	ret ; $460b
	inc de ; $460c
	ld a, [$daf7] ; $460d
	ld l, e ; $4610
	ld h, d ; $4611
	call FarReadByte ; $4612
	dec a ; $4615
	ld b, a ; $4616
	ld hl, hActorPtr ; $4617
	ld a, [hl+] ; $461a
	ld h, [hl] ; $461b
	add a, $03 ; $461c
	ld l, a ; $461e
	ld [hl], b ; $461f
	inc de ; $4620
	xor a, a ; $4621
	ret ; $4622
	inc de ; $4623
	push de ; $4624
	ld hl, hActorPtr ; $4625
	ld a, [hl+] ; $4628
	ld b, [hl] ; $4629
	ld c, a ; $462a
	ld hl, $0016 ; $462b
	add hl, bc ; $462e
	ld a, [hl+] ; $462f
	ld d, [hl] ; $4630
	ld e, a ; $4631
	ld hl, $000c ; $4632
	add hl, de ; $4635
	ld a, $08 ; $4636
	add a, c ; $4638
	ld e, a ; $4639
	ld d, b ; $463a
	ld a, [hl+] ; $463b
	ld [de], a ; $463c
	inc de ; $463d
	ld a, [hl+] ; $463e
	ld [de], a ; $463f
	inc de ; $4640
	ld a, [hl+] ; $4641
	ld [de], a ; $4642
	inc de ; $4643
	ld a, [hl+] ; $4644
	ld [de], a ; $4645
	call IsActorAtTarget ; $4646
	jr z, Label_04_46ad ; $4649
	ld hl, $0009 ; $464b
	add hl, bc ; $464e
	ld a, [hl] ; $464f
	ld hl, $000d ; $4650
	add hl, bc ; $4653
	sub a, [hl] ; $4654
	bit 7, a ; $4655
	jr z, Label_04_465b ; $4657
	cpl ; $4659
	inc a ; $465a
Label_04_465b:
	call GetSquareOfByte ; $465b
	push hl ; $465e
	ld hl, $000b ; $465f
	add hl, bc ; $4662
	ld a, [hl] ; $4663
	ld hl, $000f ; $4664
	add hl, bc ; $4667
	sub a, [hl] ; $4668
	bit 7, a ; $4669
	jr z, Label_04_466f ; $466b
	cpl ; $466d
	inc a ; $466e
Label_04_466f:
	call GetSquareOfByte ; $466f
	pop de ; $4672
	add hl, de ; $4673
	ld a, h ; $4674
	or a, a ; $4675
	jr nz, Label_04_469d ; $4676
	ld a, l ; $4678
	cp a, $01 ; $4679
	jr nc, Label_04_4682 ; $467b
	ld de, $0010 ; $467d
	jr Label_04_46a0 ; $4680
Label_04_4682:
	cp a, $04 ; $4682
	jr nc, Label_04_468b ; $4684
	ld de, $0018 ; $4686
	jr Label_04_46a0 ; $4689
Label_04_468b:
	cp a, $09 ; $468b
	jr nc, Label_04_4694 ; $468d
	ld de, $0020 ; $468f
	jr Label_04_46a0 ; $4692
Label_04_4694:
	cp a, $10 ; $4694
	jr nc, Label_04_469d ; $4696
	ld de, $0040 ; $4698
	jr Label_04_46a0 ; $469b
Label_04_469d:
	ld de, $0080 ; $469d
Label_04_46a0:
	ld hl, $0006 ; $46a0
	add hl, bc ; $46a3
	ld a, e ; $46a4
	ld [hl+], a ; $46a5
	ld [hl], d ; $46a6
	ld hl, $0005 ; $46a7
	add hl, bc ; $46aa
	set 7, [hl] ; $46ab
Label_04_46ad:
	pop de ; $46ad
	xor a, a ; $46ae
	ret ; $46af
	inc de ; $46b0
	push de ; $46b1
	ld hl, hActorPtr ; $46b2
	ld a, [hl+] ; $46b5
	ld b, [hl] ; $46b6
	ld c, a ; $46b7
	ld hl, $0016 ; $46b8
	add hl, bc ; $46bb
	ld a, [hl+] ; $46bc
	ld h, [hl] ; $46bd
	add a, $0e ; $46be
	ld l, a ; $46c0
	ld a, [hl+] ; $46c1
	ld d, [hl] ; $46c2
	ld e, a ; $46c3
	ld c, d ; $46c4
	push de ; $46c5
	ld de, $fffd ; $46c6
	add hl, de ; $46c9
	ld a, [hl+] ; $46ca
	ld d, [hl] ; $46cb
	ld e, a ; $46cc
	ld b, d ; $46cd
	push de ; $46ce
	ld de, $0007 ; $46cf
	add hl, de ; $46d2
	ld a, [hl] ; $46d3
	push af ; $46d4
	ld de, $fff2 ; $46d5
	add hl, de ; $46d8
	ld a, [hl+] ; $46d9
	ld d, [hl] ; $46da
	ld e, a ; $46db
	push de ; $46dc
	ld e, c ; $46dd
	ld d, b ; $46de
	ld hl, hActorPtr ; $46df
	ld a, [hl+] ; $46e2
	ld b, [hl] ; $46e3
	ld c, a ; $46e4
	ld hl, $000d ; $46e5
	add hl, bc ; $46e8
	ld a, d ; $46e9
	sub a, [hl] ; $46ea
	bit 7, a ; $46eb
	jr z, Label_04_46f1 ; $46ed
	cpl ; $46ef
	inc a ; $46f0
Label_04_46f1:
	call GetSquareOfByte ; $46f1
	push hl ; $46f4
	ld hl, $000f ; $46f5
	add hl, bc ; $46f8
	ld a, e ; $46f9
	sub a, [hl] ; $46fa
	bit 7, a ; $46fb
	jr z, Label_04_4701 ; $46fd
	cpl ; $46ff
	inc a ; $4700
Label_04_4701:
	call GetSquareOfByte ; $4701
	pop de ; $4704
	add hl, de ; $4705
	ld a, l ; $4706
	cp a, $08 ; $4707
	jr nc, Label_04_4710 ; $4709
	add sp, 8 ; $470b
	pop de ; $470d
	xor a, a ; $470e
	ret ; $470f
Label_04_4710:
	pop de ; $4710
	ld hl, $0006 ; $4711
	add hl, bc ; $4714
	ld a, e ; $4715
	ld [hl+], a ; $4716
	ld [hl], d ; $4717
	pop af ; $4718
	add a, $80 ; $4719
	ld hl, $0200 ; $471b
	call VectorFromLengthAndAngle ; $471e
	pop bc ; $4721
	add hl, bc ; $4722
	ld c, l ; $4723
	ld b, h ; $4724
	pop hl ; $4725
	add hl, de ; $4726
	ld e, l ; $4727
	ld d, h ; $4728
	ld l, c ; $4729
	ld h, b ; $472a
	call IsTerrainBlockedAtPoint ; $472b
	and a, a ; $472e
	jr nz, Label_04_4757 ; $472f
	ld hl, hActorPtr ; $4731
	ld a, [hl+] ; $4734
	ld h, [hl] ; $4735
	add a, $08 ; $4736
	ld l, a ; $4738
	ld a, c ; $4739
	ld [hl+], a ; $473a
	ld a, b ; $473b
	ld [hl+], a ; $473c
	ld a, e ; $473d
	ld [hl+], a ; $473e
	ld [hl], d ; $473f
	ld hl, hActorPtr ; $4740
	ld a, [hl+] ; $4743
	ld b, [hl] ; $4744
	ld c, a ; $4745
	call IsActorAtTarget ; $4746
	jr z, Label_04_4757 ; $4749
	ld hl, hActorPtr ; $474b
	ld a, [hl+] ; $474e
	ld b, [hl] ; $474f
	ld c, a ; $4750
	ld hl, $0005 ; $4751
	add hl, bc ; $4754
	set 7, [hl] ; $4755
Label_04_4757:
	pop de ; $4757
	xor a, a ; $4758
	ret ; $4759
IsActorAtTarget:
	ld hl, $000c ; $475a
	add hl, bc ; $475d
	ld a, $08 ; $475e
	add a, c ; $4760
	ld e, a ; $4761
	ld d, b ; $4762
	ld a, [de] ; $4763
	cp a, [hl] ; $4764
	jr nz, Label_04_477b ; $4765
	inc hl ; $4767
	inc de ; $4768
	ld a, [de] ; $4769
	cp a, [hl] ; $476a
	jr nz, Label_04_477b ; $476b
	inc hl ; $476d
	inc de ; $476e
	ld a, [de] ; $476f
	cp a, [hl] ; $4770
	jr nz, Label_04_477b ; $4771
	inc hl ; $4773
	inc de ; $4774
	ld a, [de] ; $4775
	cp a, [hl] ; $4776
	jr nz, Label_04_477b ; $4777
	xor a, a ; $4779
	ret ; $477a
Label_04_477b:
	ld a, $01 ; $477b
	or a, a ; $477d
	ret ; $477e
	inc de ; $477f
	ld l, e ; $4780
	ld h, d ; $4781
	ld a, [$daf7] ; $4782
	call FarReadByte ; $4785
	inc de ; $4788
	push af ; $4789
	ld a, [$daf7] ; $478a
	ld l, e ; $478d
	ld h, d ; $478e
	call FarReadWord ; $478f
	inc de ; $4792
	inc de ; $4793
	pop af ; $4794
	push af ; $4795
	ld hl, hActorPtr ; $4796
	add a, [hl] ; $4799
	inc hl ; $479a
	ld h, [hl] ; $479b
	ld l, a ; $479c
	pop af ; $479d
	push hl ; $479e
	add a, $fd ; $479f
	ld l, a ; $47a1
	ld a, $47 ; $47a2
	adc a, $00 ; $47a4
	ld h, a ; $47a6
	ld a, [hl] ; $47a7
	pop hl ; $47a8
	cp a, $02 ; $47a9
	jr nz, Label_04_47b2 ; $47ab
	ld a, c ; $47ad
	ld [hl+], a ; $47ae
	ld [hl], b ; $47af
	jr Label_04_47b7 ; $47b0
Label_04_47b2:
	cp a, $01 ; $47b2
	jr nz, Label_04_47b7 ; $47b4
	ld [hl], c ; $47b6
Label_04_47b7:
	ld a, $01 ; $47b7
	ret ; $47b9
	inc de ; $47ba
	ld l, e ; $47bb
	ld h, d ; $47bc
	ld a, [$daf7] ; $47bd
	call FarReadByte ; $47c0
	inc de ; $47c3
	push af ; $47c4
	ld a, [$daf7] ; $47c5
	call FarReadWord ; $47c8
	inc de ; $47cb
	inc de ; $47cc
	pop af ; $47cd
	push af ; $47ce
	ld hl, hActorPtr ; $47cf
	add a, [hl] ; $47d2
	inc hl ; $47d3
	ld h, [hl] ; $47d4
	ld l, a ; $47d5
	pop af ; $47d6
	push hl ; $47d7
	add a, $fd ; $47d8
	ld l, a ; $47da
	ld a, $47 ; $47db
	adc a, $00 ; $47dd
	ld h, a ; $47df
	ld a, [hl] ; $47e0
	pop hl ; $47e1
	cp a, $02 ; $47e2
	jr nz, Label_04_47f3 ; $47e4
	push hl ; $47e6
	ld a, [hl+] ; $47e7
	ld h, [hl] ; $47e8
	ld l, a ; $47e9
	add hl, bc ; $47ea
	ld c, l ; $47eb
	ld b, h ; $47ec
	pop hl ; $47ed
	ld a, c ; $47ee
	ld [hl+], a ; $47ef
	ld [hl], b ; $47f0
	jr Label_04_47fa ; $47f1
Label_04_47f3:
	cp a, $01 ; $47f3
	jr nz, Label_04_47fa ; $47f5
	ld a, [hl] ; $47f7
	add a, c ; $47f8
	ld [hl], a ; $47f9
Label_04_47fa:
	ld a, $01 ; $47fa
	ret ; $47fc
	INCBIN "data/bank_004/d_47fd.bin" ; $47fd, 39 bytes
	inc de ; $4824
	ld a, [$daf7] ; $4825
	ld l, e ; $4828
	ld h, d ; $4829
	call FarReadByte ; $482a
	inc de ; $482d
	push de ; $482e
	ld d, a ; $482f
	ld hl, hActorPtr ; $4830
	ld a, [hl+] ; $4833
	ld b, [hl] ; $4834
	ld c, a ; $4835
	call SetActorAnimationChecked ; $4836
	pop de ; $4839
	ld a, $01 ; $483a
	ret ; $483c
	inc de ; $483d
	ld a, [$daf7] ; $483e
	ld l, e ; $4841
	ld h, d ; $4842
	call FarReadByte ; $4843
	inc de ; $4846
	ld b, a ; $4847
	call PlaySoundManaged ; $4848
	ld a, $01 ; $484b
	ret ; $484d
	ld hl, hActorPtr ; $484e
	ld a, [hl+] ; $4851
	ld h, [hl] ; $4852
	add a, $0d ; $4853
	ld l, a ; $4855
	ld b, [hl] ; $4856
	ld hl, hActorPtr ; $4857
	ld a, [hl+] ; $485a
	ld h, [hl] ; $485b
	add a, $0f ; $485c
	ld l, a ; $485e
	ld c, [hl] ; $485f
	ld hl, hActorPtr ; $4860
	ld a, [hl+] ; $4863
	ld h, [hl] ; $4864
	add a, $16 ; $4865
	ld l, a ; $4867
	ld a, c ; $4868
	ld [hl+], a ; $4869
	ld [hl], b ; $486a
	ld hl, hActorPtr ; $486b
	ld a, [hl+] ; $486e
	ld h, [hl] ; $486f
	add a, $06 ; $4870
	ld l, a ; $4872
	ld [hl], $08 ; $4873
	inc hl ; $4875
	ld [hl], $00 ; $4876
	ld hl, hActorPtr ; $4878
	ld a, [hl+] ; $487b
	ld h, [hl] ; $487c
	add a, $05 ; $487d
	ld l, a ; $487f
	set 2, [hl] ; $4880
	inc de ; $4882
	ld a, $00 ; $4883
	ret ; $4885
	ld hl, hActorPtr ; $4886
	ld a, [hl+] ; $4889
	ld h, [hl] ; $488a
	add a, $30 ; $488b
	ld l, a ; $488d
	bit 7, [hl] ; $488e
	jr z, Label_04_48bf ; $4890
	push de ; $4892
	inc de ; $4893
	ld a, [$daf7] ; $4894
	ld l, e ; $4897
	ld h, d ; $4898
	call FarReadWord ; $4899
	ld a, c ; $489c
	ld [$daf5], a ; $489d
	ld a, b ; $48a0
	ld [$daf6], a ; $48a1
	call Func_04_48c3 ; $48a4
	and a, a ; $48a7
	jr nz, Label_04_48be ; $48a8
	call Func_04_48c3 ; $48aa
	and a, a ; $48ad
	jr nz, Label_04_48be ; $48ae
	call Func_04_48c3 ; $48b0
	and a, a ; $48b3
	jr nz, Label_04_48be ; $48b4
	call Func_04_48c3 ; $48b6
	and a, a ; $48b9
	jr nz, Label_04_48be ; $48ba
	jr Label_04_48be ; $48bc
Label_04_48be:
	pop de ; $48be
Label_04_48bf:
	inc de ; $48bf
	inc de ; $48c0
	inc de ; $48c1
	ret ; $48c2
Func_04_48c3:
	push bc ; $48c3
	ld hl, hActorPtr ; $48c4
	ld a, [hl+] ; $48c7
	ld b, [hl] ; $48c8
	ld c, a ; $48c9
	call AdvanceRandomSeed ; $48ca
	ld a, l ; $48cd
	and a, $fc ; $48ce
	ld [$daf4], a ; $48d0
	ld hl, $0100 ; $48d3
	call ProjectPointFromActor ; $48d6
	push de ; $48d9
	push hl ; $48da
	ld e, d ; $48db
	ld d, h ; $48dc
	ld hl, $0016 ; $48dd
	add hl, bc ; $48e0
	ld a, [hl+] ; $48e1
	ld b, [hl] ; $48e2
	ld c, a ; $48e3
	ld a, [$daf5] ; $48e4
	ld h, a ; $48e7
	ld a, [$daf6] ; $48e8
	ld l, a ; $48eb
	call TestPointInBox ; $48ec
	pop hl ; $48ef
	pop de ; $48f0
	and a, a ; $48f1
	jr nz, Label_04_4946 ; $48f2
	push de ; $48f4
	push hl ; $48f5
	ld a, [$daf4] ; $48f6
	ld bc, $00e0 ; $48f9
	call Func_04_512f ; $48fc
	call IsTerrainBlockedAtPoint ; $48ff
	pop hl ; $4902
	pop de ; $4903
	and a, a ; $4904
	jr nz, Label_04_4946 ; $4905
	push de ; $4907
	push hl ; $4908
	ld a, [$daf4] ; $4909
	add a, $20 ; $490c
	ld bc, $00e0 ; $490e
	call Func_04_512f ; $4911
	call IsTerrainBlockedAtPoint ; $4914
	pop hl ; $4917
	pop de ; $4918
	and a, a ; $4919
	jr nz, Label_04_4946 ; $491a
	push de ; $491c
	push hl ; $491d
	ld a, [$daf4] ; $491e
	add a, $e0 ; $4921
	ld bc, $00e0 ; $4923
	call Func_04_512f ; $4926
	call IsTerrainBlockedAtPoint ; $4929
	pop hl ; $492c
	pop de ; $492d
	and a, a ; $492e
	jr nz, Label_04_4946 ; $492f
	push hl ; $4931
	ld hl, hActorPtr ; $4932
	ld a, [hl+] ; $4935
	ld b, [hl] ; $4936
	ld c, a ; $4937
	pop hl ; $4938
	call SetActorMoveTarget ; $4939
	ld hl, $0005 ; $493c
	add hl, bc ; $493f
	set 7, [hl] ; $4940
	ld a, $01 ; $4942
	jr Label_04_4947 ; $4944
Label_04_4946:
	xor a, a ; $4946
Label_04_4947:
	pop bc ; $4947
	ret ; $4948
	ld hl, hActorPtr ; $4949
	ld a, [hl+] ; $494c
	ld h, [hl] ; $494d
	add a, $05 ; $494e
	ld l, a ; $4950
	bit 7, [hl] ; $4951
	jr nz, Label_04_4962 ; $4953
	ld hl, hActorPtr ; $4955
	ld a, [hl+] ; $4958
	ld h, [hl] ; $4959
	add a, $03 ; $495a
	ld l, a ; $495c
	ld [hl], $28 ; $495d
	inc de ; $495f
	jr Label_04_4979 ; $4960
Label_04_4962:
	ld hl, hActorPtr ; $4962
	ld a, [hl+] ; $4965
	ld h, [hl] ; $4966
	add a, $05 ; $4967
	ld l, a ; $4969
	bit 6, [hl] ; $496a
	jr z, Label_04_4979 ; $496c
	ld hl, hActorPtr ; $496e
	ld a, [hl+] ; $4971
	ld h, [hl] ; $4972
	add a, $03 ; $4973
	ld l, a ; $4975
	ld [hl], $0a ; $4976
	inc de ; $4978
Label_04_4979:
	xor a, a ; $4979
	ret ; $497a
	inc de ; $497b
	push de ; $497c
	ld a, [$daf7] ; $497d
	ld l, e ; $4980
	ld h, d ; $4981
	call FarReadWord ; $4982
	push bc ; $4985
	inc hl ; $4986
	inc hl ; $4987
	ld a, [$daf7] ; $4988
	call FarReadWord ; $498b
	push bc ; $498e
	inc hl ; $498f
	inc hl ; $4990
	call FarReadByte ; $4991
	push af ; $4994
	push hl ; $4995
	ld hl, hActorPtr ; $4996
	ld a, [hl+] ; $4999
	ld b, [hl] ; $499a
	ld c, a ; $499b
	ld hl, $000c ; $499c
	add hl, bc ; $499f
	ld a, [hl+] ; $49a0
	ld h, [hl] ; $49a1
	ld l, a ; $49a2
	pop de ; $49a3
	push hl ; $49a4
	ld hl, $000e ; $49a5
	add hl, bc ; $49a8
	ld a, [hl+] ; $49a9
	ld h, [hl] ; $49aa
	ld l, a ; $49ab
	pop de ; $49ac
	call AngleFromVectorCoarse ; $49ad
	pop hl ; $49b0
	ld l, h ; $49b1
	ld h, $00 ; $49b2
	call VectorFromLengthAndAngleRaw ; $49b4
	pop bc ; $49b7
	add hl, bc ; $49b8
	ld c, l ; $49b9
	ld b, h ; $49ba
	pop hl ; $49bb
	add hl, de ; $49bc
	ld e, l ; $49bd
	ld d, h ; $49be
	ld hl, hActorPtr ; $49bf
	ld a, [hl+] ; $49c2
	ld h, [hl] ; $49c3
	add a, $08 ; $49c4
	ld l, a ; $49c6
	ld [hl], c ; $49c7
	inc hl ; $49c8
	ld [hl], b ; $49c9
	inc hl ; $49ca
	ld [hl], e ; $49cb
	inc hl ; $49cc
	ld [hl], d ; $49cd
	pop bc ; $49ce
	ld hl, $0005 ; $49cf
	add hl, bc ; $49d2
	ld c, l ; $49d3
	ld b, h ; $49d4
	ld hl, $0005 ; $49d5
	add hl, bc ; $49d8
	set 7, [hl] ; $49d9
	ld a, $01 ; $49db
	ret ; $49dd
	push bc ; $49de
	inc de ; $49df
	ld a, [$daf7] ; $49e0
	ld l, e ; $49e3
	ld h, d ; $49e4
	call FarReadByte ; $49e5
	inc de ; $49e8
	push af ; $49e9
	ld l, e ; $49ea
	ld h, d ; $49eb
	ld a, [$daf7] ; $49ec
	call FarReadByte ; $49ef
	inc de ; $49f2
	push af ; $49f3
	ld a, [$daf7] ; $49f4
	ld l, e ; $49f7
	ld h, d ; $49f8
	call FarReadByte ; $49f9
	inc de ; $49fc
	add a, $1f ; $49fd
	ld l, a ; $49ff
	adc a, $4a ; $4a00
	sub a, l ; $4a02
	ld h, a ; $4a03
	ld c, [hl] ; $4a04
	pop af ; $4a05
	ld hl, hActorPtr ; $4a06
	add a, [hl] ; $4a09
	inc hl ; $4a0a
	ld h, [hl] ; $4a0b
	ld l, a ; $4a0c
	pop af ; $4a0d
	cp a, $01 ; $4a0e
	jr z, Label_04_4a18 ; $4a10
	ld a, c ; $4a12
	xor a, $ff ; $4a13
	and a, [hl] ; $4a15
	jr Label_04_4a1a ; $4a16
Label_04_4a18:
	ld a, c ; $4a18
	or a, [hl] ; $4a19
Label_04_4a1a:
	ld [hl], a ; $4a1a
	pop bc ; $4a1b
	ld a, $01 ; $4a1c
	ret ; $4a1e
	INCBIN "data/bank_004/d_4a1f.bin" ; $4a1f, 8 bytes
ComputeSpriteScrollOffset:
	ld hl, wCameraX ; $4a27
	ld a, [hl+] ; $4a2a
	ld d, [hl] ; $4a2b
	ld e, a ; $4a2c
	ld a, [$c368] ; $4a2d
	ld l, a ; $4a30
	ld h, $00 ; $4a31
	bit 7, l ; $4a33
	jr z, Label_04_4a39 ; $4a35
	ld h, $ff ; $4a37
Label_04_4a39:
	add hl, hl ; $4a39
	add hl, hl ; $4a3a
	add hl, hl ; $4a3b
	add hl, hl ; $4a3c
	add hl, hl ; $4a3d
	add hl, de ; $4a3e
	xor a, a ; $4a3f
	sub a, l ; $4a40
	ld l, a ; $4a41
	sbc a, a ; $4a42
	sub a, h ; $4a43
	ld h, a ; $4a44
	ld c, l ; $4a45
	ld b, h ; $4a46
	ld hl, $dae0 ; $4a47
	ld a, c ; $4a4a
	ld [hl+], a ; $4a4b
	ld [hl], b ; $4a4c
	ld hl, wCameraY ; $4a4d
	ld a, [hl+] ; $4a50
	ld d, [hl] ; $4a51
	ld e, a ; $4a52
	test_flag $0d, 6 ; $4a53
	jr z, Label_04_4a61 ; $4a56
	ld hl, $cb02 ; $4a58
	ld a, [hl+] ; $4a5b
	ld h, [hl] ; $4a5c
	ld l, a ; $4a5d
	add hl, de ; $4a5e
	ld d, h ; $4a5f
	ld e, l ; $4a60
Label_04_4a61:
	ld a, [$c369] ; $4a61
	ld l, a ; $4a64
	ld h, $00 ; $4a65
	bit 7, l ; $4a67
	jr z, Label_04_4a6d ; $4a69
	ld h, $ff ; $4a6b
Label_04_4a6d:
	add hl, hl ; $4a6d
	add hl, hl ; $4a6e
	add hl, hl ; $4a6f
	add hl, hl ; $4a70
	add hl, hl ; $4a71
	add hl, de ; $4a72
	xor a, a ; $4a73
	sub a, l ; $4a74
	ld l, a ; $4a75
	sbc a, a ; $4a76
	sub a, h ; $4a77
	ld h, a ; $4a78
	ld c, l ; $4a79
	ld b, h ; $4a7a
	ld hl, $dae2 ; $4a7b
	ld a, c ; $4a7e
	ld [hl+], a ; $4a7f
	ld [hl], b ; $4a80
	ret ; $4a81
	test_flag $02, 4 ; $4a82
	ret nz ; $4a85
	wram_bank $04 ; $4a86
	call ComputeSpriteScrollOffset ; $4a8c
	ld bc, $d000 ; $4a8f
	ld e, $18 ; $4a92
Label_04_4a94:
	inc c ; $4a94
	ld a, [bc] ; $4a95
	dec c ; $4a96
	or a, a ; $4a97
	jr z, Label_04_4ab9 ; $4a98
	ld hl, $0031 ; $4a9a
	add hl, bc ; $4a9d
	ld a, [hl] ; $4a9e
	and a, a ; $4a9f
	jr z, Label_04_4aa5 ; $4aa0
	dec [hl] ; $4aa2
	jr Label_04_4ab9 ; $4aa3
Label_04_4aa5:
	push de ; $4aa5
	ld hl, $0022 ; $4aa6
	add hl, bc ; $4aa9
	ld a, [hl] ; $4aaa
	ld [$daf7], a ; $4aab
	ld hl, $0020 ; $4aae
	add hl, bc ; $4ab1
	ld a, [hl] ; $4ab2
	cp a, $02 ; $4ab3
	call z, Func_04_5526 ; $4ab5
	pop de ; $4ab8
Label_04_4ab9:
	ld hl, $0040 ; $4ab9
	add hl, bc ; $4abc
	ld c, l ; $4abd
	ld b, h ; $4abe
	dec e ; $4abf
	jr nz, Label_04_4a94 ; $4ac0
	ret ; $4ac2
LoadActorObjectDefIfValid:
	inc b ; $4ac3
	dec b ; $4ac4
	ret z ; $4ac5
LoadActorObjectDef:
	push af ; $4ac6
	push de ; $4ac7
	push hl ; $4ac8
	wram_bank $04 ; $4ac9
	ld hl, $0021 ; $4acf
	add hl, bc ; $4ad2
	ld [hl], d ; $4ad3
	ld a, d ; $4ad4
	add a, a ; $4ad5
	add a, $75 ; $4ad6
	ld l, a ; $4ad8
	adc a, $4f ; $4ad9
	sub a, l ; $4adb
	ld h, a ; $4adc
	ld a, [hl+] ; $4add
	ld h, [hl] ; $4ade
	ld l, a ; $4adf
	ld a, $22 ; $4ae0
	add a, c ; $4ae2
	ld e, a ; $4ae3
	ld d, b ; $4ae4
	ld a, h ; $4ae5
	ld [de], a ; $4ae6
	push bc ; $4ae7
	ld de, $dad0 ; $4ae8
	ld bc, $0010 ; $4aeb
	call CopyDataFromBank ; $4aee
	pop bc ; $4af1
	ld a, [$dad0] ; $4af2
	ld hl, $0037 ; $4af5
	add hl, bc ; $4af8
	ld [hl], a ; $4af9
	ld a, [$dad1] ; $4afa
	ld hl, $0035 ; $4afd
	add hl, bc ; $4b00
	ld [hl], a ; $4b01
	ld hl, $0024 ; $4b02
	add hl, bc ; $4b05
	ld a, [$dad4] ; $4b06
	ld [hl+], a ; $4b09
	ld a, [$dad5] ; $4b0a
	ld [hl+], a ; $4b0d
	ld hl, $0028 ; $4b0e
	add hl, bc ; $4b11
	ld a, [$dad6] ; $4b12
	ld [hl+], a ; $4b15
	ld a, [$dad7] ; $4b16
	ld [hl+], a ; $4b19
	ld hl, $0038 ; $4b1a
	add hl, bc ; $4b1d
	ld a, [$dada] ; $4b1e
	ld [hl+], a ; $4b21
	ld a, [$dadb] ; $4b22
	ld [hl+], a ; $4b25
	ld hl, $0037 ; $4b26
	add hl, bc ; $4b29
	ld a, [hl] ; $4b2a
	cp a, $63 ; $4b2b
	jr nz, Label_04_4b51 ; $4b2d
	ld [hl], $02 ; $4b2f
	push bc ; $4b31
	ld hl, $dad8 ; $4b32
	ld a, [hl+] ; $4b35
	ld h, [hl] ; $4b36
	ld l, a ; $4b37
	ld a, $22 ; $4b38
	add a, c ; $4b3a
	ld e, a ; $4b3b
	ld d, b ; $4b3c
	ld a, [de] ; $4b3d
	ld de, $dad0 ; $4b3e
	ld bc, $0008 ; $4b41
	call FarCopyBytes ; $4b44
	ld hl, $dad0 ; $4b47
	ld de, $0a01 ; $4b4a
	call LoadPalettesMasterOnly ; $4b4d
	pop bc ; $4b50
Label_04_4b51:
	ld hl, $0020 ; $4b51
	add hl, bc ; $4b54
	ld [hl], $02 ; $4b55
	ld hl, $0032 ; $4b57
	add hl, bc ; $4b5a
	ld a, $ff ; $4b5b
	ld [hl+], a ; $4b5d
	ld [hl+], a ; $4b5e
	ld d, $00 ; $4b5f
	call SetActorAnimation ; $4b61
	pop hl ; $4b64
	pop de ; $4b65
	pop af ; $4b66
	ret ; $4b67
Func_04_4b68:
	ld a, d ; $4b68
	ld [$df21], a ; $4b69
	add a, a ; $4b6c
	add a, $75 ; $4b6d
	ld l, a ; $4b6f
	adc a, $4f ; $4b70
	sub a, l ; $4b72
	ld h, a ; $4b73
	ld a, [hl+] ; $4b74
	ld h, [hl] ; $4b75
	ld l, a ; $4b76
	ld a, h ; $4b77
	ld [$df22], a ; $4b78
	ld de, $dad0 ; $4b7b
	ld bc, $0010 ; $4b7e
	call CopyDataFromBank ; $4b81
	ld a, [$dad0] ; $4b84
	ld [$df37], a ; $4b87
	ld [$df3a], a ; $4b8a
	ld hl, $df24 ; $4b8d
	ld a, [$dad4] ; $4b90
	ld [hl+], a ; $4b93
	ld a, [$dad5] ; $4b94
	ld [hl+], a ; $4b97
	ld hl, $df28 ; $4b98
	ld a, [$dad6] ; $4b9b
	ld [hl+], a ; $4b9e
	ld a, [$dad7] ; $4b9f
	ld [hl+], a ; $4ba2
	ld hl, $df38 ; $4ba3
	ld a, [$dada] ; $4ba6
	ld [hl+], a ; $4ba9
	ld a, [$dadb] ; $4baa
	ld [hl+], a ; $4bad
	ld hl, $df32 ; $4bae
	ld a, $ff ; $4bb1
	ld [hl+], a ; $4bb3
	ld [hl+], a ; $4bb4
	ld d, $01 ; $4bb5
	farcall FarPtr_SetCharAnimation ; $4bb7
	ret ; $4bba
SetActorAnimationChecked:
	inc b ; $4bbb
	dec b ; $4bbc
	ret z ; $4bbd
SetActorAnimation:
	push af ; $4bbe
	push de ; $4bbf
	push hl ; $4bc0
	wram_bank $04 ; $4bc1
	ld hl, $002e ; $4bc7
	add hl, bc ; $4bca
	ld a, [hl] ; $4bcb
	cp a, d ; $4bcc
	jr z, Label_04_4c07 ; $4bcd
	ld [hl], d ; $4bcf
	ld hl, $002f ; $4bd0
	add hl, bc ; $4bd3
	ld [hl], $00 ; $4bd4
	ld hl, $df37 ; $4bd6
	ld a, [hl] ; $4bd9
	and a, $0f ; $4bda
	ld [hl], a ; $4bdc
	push bc ; $4bdd
	ld hl, $0028 ; $4bde
	add hl, bc ; $4be1
	ld a, [hl+] ; $4be2
	ld h, [hl] ; $4be3
	ld l, a ; $4be4
	ld a, d ; $4be5
	add a, a ; $4be6
	add a, l ; $4be7
	ld l, a ; $4be8
	jr nc, Label_04_4bec ; $4be9
	inc h ; $4beb
Label_04_4bec:
	push hl ; $4bec
	ld hl, $0022 ; $4bed
	add hl, bc ; $4bf0
	ld a, [hl] ; $4bf1
	pop hl ; $4bf2
	call FarReadWord ; $4bf3
	ld e, c ; $4bf6
	ld d, b ; $4bf7
	pop bc ; $4bf8
	ld hl, $002a ; $4bf9
	add hl, bc ; $4bfc
	ld a, e ; $4bfd
	ld [hl+], a ; $4bfe
	ld [hl], d ; $4bff
	ld hl, $002c ; $4c00
	add hl, bc ; $4c03
	ld a, e ; $4c04
	ld [hl+], a ; $4c05
	ld [hl], d ; $4c06
Label_04_4c07:
	pop hl ; $4c07
	pop de ; $4c08
	pop af ; $4c09
	ret ; $4c0a
GetObjectDefCount:
	push bc ; $4c0b
	push hl ; $4c0c
	ld hl, $4f75 ; $4c0d
	ld c, $ff ; $4c10
Label_04_4c12:
	inc c ; $4c12
	ld a, [hl+] ; $4c13
	ld b, a ; $4c14
	ld a, [hl+] ; $4c15
	or a, b ; $4c16
	jr nz, Label_04_4c12 ; $4c17
	ld a, c ; $4c19
	pop hl ; $4c1a
	pop bc ; $4c1b
	ret ; $4c1c
LookupTileId_04:
	push hl ; $4c1d
	ld hl, TileIdLookup_04_4c29 ; $4c1e
	add a, l ; $4c21
	ld l, a ; $4c22
	jr nc, Label_04_4c26 ; $4c23
	inc h ; $4c25
Label_04_4c26:
	ld a, [hl] ; $4c26
	pop hl ; $4c27
	ret ; $4c28
TileIdLookup_04_4c29:
	; $4c29, 32 bytes (bytes:8)
	db $26, $27, $28, $29, $64, $69, $66, $6a ; 0x00
	db $68, $6b, $65, $67, $4a, $5e, $5d, $60 ; 0x08
	db $5f, $49, $62, $61, $4b, $4f, $4f, $6d ; 0x10
	db $6e, $6f, $2a, $2b, $2c, $2d, $48, $2e ; 0x18
EvalFlagCondition:
	ld a, e ; $4c49
	or a, d ; $4c4a
	ret z ; $4c4b
	bit 7, d ; $4c4c
	jr nz, Label_04_4c54 ; $4c4e
	call TestGameFlag ; $4c50
	ret ; $4c53
Label_04_4c54:
	res 7, d ; $4c54
	call TestGameFlag ; $4c56
	jr z, Label_04_4c5d ; $4c59
	xor a, a ; $4c5b
	ret ; $4c5c
Label_04_4c5d:
	xor a, a ; $4c5d
	inc a ; $4c5e
	ret ; $4c5f
SpawnActorFromTemplate:
	push af ; $4c60
	push de ; $4c61
	push hl ; $4c62
	ld b, a ; $4c63
	push de ; $4c64
	ld a, [hl+] ; $4c65
	ld e, a ; $4c66
	ld a, [hl+] ; $4c67
	ld d, a ; $4c68
	call EvalFlagCondition ; $4c69
	pop de ; $4c6c
	jr z, Label_04_4c79 ; $4c6d
	ldh a, [hRomBank] ; $4c6f
	ld hl, FollowerActorScript_04 ; $4c71
	call SpawnActor ; $4c74
	jr Label_04_4cf3 ; $4c77
Label_04_4c79:
	ld a, [hl+] ; $4c79
	ld e, a ; $4c7a
	ld a, [hl+] ; $4c7b
	ld d, a ; $4c7c
	ld a, b ; $4c7d
	push hl ; $4c7e
	ld l, e ; $4c7f
	ld h, d ; $4c80
	call SpawnActor ; $4c81
	pop hl ; $4c84
	inc b ; $4c85
	dec b ; $4c86
	jr z, Label_04_4cf3 ; $4c87
	ld a, $0c ; $4c89
	add a, c ; $4c8b
	ld e, a ; $4c8c
	ld d, b ; $4c8d
	ld a, [hl+] ; $4c8e
	ld [de], a ; $4c8f
	inc de ; $4c90
	ld a, [hl-] ; $4c91
	ld [de], a ; $4c92
	ld a, $08 ; $4c93
	add a, c ; $4c95
	ld e, a ; $4c96
	ld d, b ; $4c97
	ld a, [hl+] ; $4c98
	ld [de], a ; $4c99
	inc de ; $4c9a
	ld a, [hl+] ; $4c9b
	ld [de], a ; $4c9c
	ld a, $0e ; $4c9d
	add a, c ; $4c9f
	ld e, a ; $4ca0
	ld d, b ; $4ca1
	ld a, [hl+] ; $4ca2
	ld [de], a ; $4ca3
	inc de ; $4ca4
	ld a, [hl-] ; $4ca5
	ld [de], a ; $4ca6
	ld a, $0a ; $4ca7
	add a, c ; $4ca9
	ld e, a ; $4caa
	ld d, b ; $4cab
	ld a, [hl+] ; $4cac
	ld [de], a ; $4cad
	inc de ; $4cae
	ld a, [hl+] ; $4caf
	ld [de], a ; $4cb0
	ld a, $14 ; $4cb1
	add a, c ; $4cb3
	ld e, a ; $4cb4
	ld d, b ; $4cb5
	ld a, [hl+] ; $4cb6
	ld [de], a ; $4cb7
	inc hl ; $4cb8
	ld a, [hl+] ; $4cb9
	ld d, a ; $4cba
	call LoadActorObjectDef ; $4cbb
	ld a, [hl+] ; $4cbe
	ld d, a ; $4cbf
	call SetActorAnimation ; $4cc0
	ld a, [hl] ; $4cc3
	cp a, $00 ; $4cc4
	jr z, Label_04_4ccf ; $4cc6
	ld a, $37 ; $4cc8
	add a, c ; $4cca
	ld e, a ; $4ccb
	ld d, b ; $4ccc
	ld a, [hl] ; $4ccd
	ld [de], a ; $4cce
Label_04_4ccf:
	inc hl ; $4ccf
	inc hl ; $4cd0
	ld hl, $0005 ; $4cd1
	add hl, bc ; $4cd4
	set 3, [hl] ; $4cd5
	set 4, [hl] ; $4cd7
	ld l, c ; $4cd9
	ld h, b ; $4cda
	add hl, hl ; $4cdb
	add hl, hl ; $4cdc
	ld a, h ; $4cdd
	and a, $0f ; $4cde
	ld hl, $0031 ; $4ce0
	add hl, bc ; $4ce3
	ld [hl], a ; $4ce4
	ld hl, $0018 ; $4ce5
	add hl, bc ; $4ce8
	ld a, $01 ; $4ce9
	ld [hl], a ; $4ceb
	ld hl, $0019 ; $4cec
	add hl, bc ; $4cef
	ld a, $02 ; $4cf0
	ld [hl], a ; $4cf2
Label_04_4cf3:
	pop hl ; $4cf3
	pop de ; $4cf4
	pop af ; $4cf5
	ret ; $4cf6
SpawnActorsFromList:
	push af ; $4cf7
	push bc ; $4cf8
	push de ; $4cf9
	push hl ; $4cfa
	ld b, a ; $4cfb
	ldh a, [hWramBank] ; $4cfc
	push af ; $4cfe
	wram_bank $04 ; $4cff
	ld a, b ; $4d05
Label_04_4d06:
	push af ; $4d06
	ld de, $dac0 ; $4d07
	ld bc, $000e ; $4d0a
	call FarCopyBytes ; $4d0d
	ld a, [$dac9] ; $4d10
	inc a ; $4d13
	jr z, Label_04_4d21 ; $4d14
	pop af ; $4d16
	push hl ; $4d17
	ld hl, $dac0 ; $4d18
	call SpawnActorFromTemplate ; $4d1b
	pop hl ; $4d1e
	jr Label_04_4d06 ; $4d1f
Label_04_4d21:
	pop af ; $4d21
	pop af ; $4d22
	wram_bank ; $4d23
	pop hl ; $4d27
	pop de ; $4d28
	pop bc ; $4d29
	pop af ; $4d2a
	ret ; $4d2b
Func_04_4d2c:
	ldh a, [hRomBank] ; $4d2c
	ld hl, $4da5 ; $4d2e
	call SpawnActorFromTemplate ; $4d31
	call AttachActorControllerScript ; $4d34
	ldh a, [hRomBank] ; $4d37
	ld hl, FollowerActorScript_04 ; $4d39
	call SpawnActor ; $4d3c
	ld hl, $1700 ; $4d3f
	ld de, $1d00 ; $4d42
	call SetActorPosition ; $4d45
	ld de, $d000 ; $4d48
	call AttachActorWaypointFollower ; $4d4b
	ldh a, [hRomBank] ; $4d4e
	ld hl, $4e05 ; $4d50
	call SpawnActorFromTemplate ; $4d53
	ld de, $d000 ; $4d56
	call AttachActorStepMover ; $4d59
	ld hl, $4e1d ; $4d5c
	call SpawnActorsFromList ; $4d5f
	ret ; $4d62
	INCBIN "data/bank_004/d_4d63.bin" ; $4d63, 264 bytes
SpawnMainCharacterActor:
	push af ; $4e6b
	push bc ; $4e6c
	push de ; $4e6d
	push hl ; $4e6e
	wram_bank $04 ; $4e6f
	push hl ; $4e75
	push bc ; $4e76
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4e77
	and a, $03 ; $4e7a
	add a, a ; $4e7c
	add a, $5f ; $4e7d
	ld l, a ; $4e7f
	adc a, $4e ; $4e80
	sub a, l ; $4e82
	ld h, a ; $4e83
	ld a, [hl+] ; $4e84
	ld h, [hl] ; $4e85
	ld l, a ; $4e86
	ldh a, [hRomBank] ; $4e87
	call SpawnActorFromTemplate ; $4e89
	pop bc ; $4e8c
	ld a, c ; $4e8d
	ld [$d014], a ; $4e8e
	ld [$daea], a ; $4e91
	pop hl ; $4e94
	ld bc, $d000 ; $4e95
	call SetActorPosition ; $4e98
	push de ; $4e9b
	push hl ; $4e9c
	ldh a, [hRomBank] ; $4e9d
	ld de, FollowerActorScript_04 ; $4e9f
	call SpawnActor ; $4ea2
	ld a, $01 ; $4ea5
	call SetActorMode ; $4ea7
	ld de, $d000 ; $4eaa
	call AttachActorWaypointFollower ; $4ead
	pop hl ; $4eb0
	pop de ; $4eb1
	call SetActorPosition ; $4eb2
	ld hl, wStoryModeMainCharacterOverworldSpriteColor ; $4eb5
	ld a, [hl] ; $4eb8
	add a, $03 ; $4eb9
	ld bc, $d000 ; $4ebb
	ld hl, $0037 ; $4ebe
	add hl, bc ; $4ec1
	ld [hl], a ; $4ec2
	pop hl ; $4ec3
	pop de ; $4ec4
	pop bc ; $4ec5
	pop af ; $4ec6
	ret ; $4ec7
	INCBIN "data/bank_004/d_4ec8.bin" ; $4ec8, 72 bytes
SpawnCompanionActor:
	push af ; $4f10
	push bc ; $4f11
	push de ; $4f12
	push hl ; $4f13
	wram_bank $04 ; $4f14
	ld a, [$c94d] ; $4f1a
	or a, a ; $4f1d
	jr nz, Label_04_4f2c ; $4f1e
	ld hl, $4ec8 ; $4f20
	ld a, $02 ; $4f23
	test_flag $05, 7 ; $4f25
	jr nz, Label_04_4f3b ; $4f28
	jr Label_04_4f36 ; $4f2a
Label_04_4f2c:
	ld hl, $4ee0 ; $4f2c
	ld a, $03 ; $4f2f
	test_flag $05, 7 ; $4f31
	jr nz, Label_04_4f3b ; $4f34
Label_04_4f36:
	ld hl, $4ef8 ; $4f36
	ld a, $ff ; $4f39
Label_04_4f3b:
	ld [$cb5e], a ; $4f3b
	ldh a, [hRomBank] ; $4f3e
	call SpawnActorFromTemplate ; $4f40
	ld a, [$cb5e] ; $4f43
	cp a, $ff ; $4f46
	jr z, Label_04_4f70 ; $4f48
	ld de, $d000 ; $4f4a
	call AttachActorStepMover ; $4f4d
	ld de, $d000 ; $4f50
	ld hl, $0014 ; $4f53
	add hl, de ; $4f56
	ld a, [hl] ; $4f57
	ld hl, $0014 ; $4f58
	add hl, bc ; $4f5b
	ld [hl], a ; $4f5c
	ld hl, $000c ; $4f5d
	add hl, de ; $4f60
	push hl ; $4f61
	ld hl, $000e ; $4f62
	add hl, de ; $4f65
	ld a, [hl+] ; $4f66
	ld d, [hl] ; $4f67
	ld e, a ; $4f68
	pop hl ; $4f69
	ld a, [hl+] ; $4f6a
	ld h, [hl] ; $4f6b
	ld l, a ; $4f6c
	call SetActorPosition ; $4f6d
Label_04_4f70:
	pop hl ; $4f70
	pop de ; $4f71
	pop bc ; $4f72
	pop af ; $4f73
	ret ; $4f74
	INCBIN "data/bank_004/d_4f75.bin" ; $4f75, 236 bytes
SetActorMoveTarget:
	push hl ; $5061
	ld hl, $000a ; $5062
	add hl, bc ; $5065
	ld a, e ; $5066
	ld [hl+], a ; $5067
	ld [hl], d ; $5068
	pop de ; $5069
	ld hl, $0008 ; $506a
	add hl, bc ; $506d
	ld a, e ; $506e
	ld [hl+], a ; $506f
	ld [hl], d ; $5070
	ret ; $5071
ActorHeadingOffsetTable:
	INCBIN "data/bank_004/d_5072.bin" ; $5072, 96 bytes
GetPointAheadOfActorFixed:
	rrca ; $50d2
	rrca ; $50d3
	rrca ; $50d4
	and a, $1c ; $50d5
	ld d, a ; $50d7
	ld a, $40 ; $50d8
	jr Label_04_50ea ; $50da
GetPointAheadOfActorRanged:
	rrca ; $50dc
	rrca ; $50dd
	rrca ; $50de
	and a, $1c ; $50df
	ld d, a ; $50e1
	ld a, [$daef] ; $50e2
	add a, a ; $50e5
	add a, a ; $50e6
	add a, a ; $50e7
	add a, a ; $50e8
	add a, a ; $50e9
Label_04_50ea:
	add a, d ; $50ea
	add a, $72 ; $50eb
	ld l, a ; $50ed
	adc a, $50 ; $50ee
	sub a, l ; $50f0
	ld h, a ; $50f1
	ld a, [hl+] ; $50f2
	ld e, a ; $50f3
	ld a, [hl+] ; $50f4
	ld d, a ; $50f5
	push de ; $50f6
	ld a, [hl+] ; $50f7
	ld e, a ; $50f8
	ld a, [hl+] ; $50f9
	ld d, a ; $50fa
	ld hl, $000e ; $50fb
	add hl, bc ; $50fe
	ld a, [hl+] ; $50ff
	ld h, [hl] ; $5100
	ld l, a ; $5101
	add hl, de ; $5102
	ld e, l ; $5103
	ld d, h ; $5104
	pop hl ; $5105
	push de ; $5106
	ld e, l ; $5107
	ld d, h ; $5108
	ld hl, $000c ; $5109
	add hl, bc ; $510c
	ld a, [hl+] ; $510d
	ld h, [hl] ; $510e
	ld l, a ; $510f
	add hl, de ; $5110
	pop de ; $5111
	ret ; $5112
ProjectPointFromActor:
	call VectorFromLengthAndAngle ; $5113
	push hl ; $5116
	ld hl, $000e ; $5117
	add hl, bc ; $511a
	ld a, [hl+] ; $511b
	ld h, [hl] ; $511c
	ld l, a ; $511d
	add hl, de ; $511e
	ld e, l ; $511f
	ld d, h ; $5120
	pop hl ; $5121
	push de ; $5122
	ld e, l ; $5123
	ld d, h ; $5124
	ld hl, $000c ; $5125
	add hl, bc ; $5128
	ld a, [hl+] ; $5129
	ld h, [hl] ; $512a
	ld l, a ; $512b
	add hl, de ; $512c
	pop de ; $512d
	ret ; $512e
Func_04_512f:
	push de ; $512f
	push hl ; $5130
	ld l, c ; $5131
	ld h, b ; $5132
	call VectorFromLengthAndAngle ; $5133
	pop bc ; $5136
	add hl, bc ; $5137
	ld c, l ; $5138
	ld b, h ; $5139
	pop hl ; $513a
	add hl, de ; $513b
	ld e, l ; $513c
	ld d, h ; $513d
	ld l, c ; $513e
	ld h, b ; $513f
	ret ; $5140
CheckTileTriggerAtPoint:
	push af ; $5141
	push de ; $5142
	ld e, d ; $5143
	ld d, h ; $5144
	farcall FarPtr_ReadBehaviorMapCell ; $5145
	ld d, a ; $5148
	and a, $0f ; $5149
	cp a, $01 ; $514b
	jr z, Label_04_5156 ; $514d
	cp a, $03 ; $514f
	jr z, Label_04_5160 ; $5151
	xor a, a ; $5153
	jr Label_04_5168 ; $5154
Label_04_5156:
	ld a, d ; $5156
	swap a ; $5157
	and a, $0f ; $5159
	ld [wStoryModeTriggerScript], a ; $515b
	jr Label_04_5168 ; $515e
Label_04_5160:
	ld a, d ; $5160
	swap a ; $5161
	and a, $0f ; $5163
	ld [wStoryModeExitLocationRequest], a ; $5165
Label_04_5168:
	pop de ; $5168
	pop af ; $5169
	ret ; $516a
UpdatePlayerControl:
	wram_bank $04 ; $516b
	call BuildNearbyActorList ; $5171
	ld hl, hActorPtr ; $5174
	ld a, [hl+] ; $5177
	ld b, [hl] ; $5178
	ld c, a ; $5179
	ldh a, [hInputRisingEdge] ; $517a
	bit PADB_A, a ; $517c
	jr z, Label_04_5192 ; $517e
	ld hl, wStoryModeInteractRequest ; $5180
	ld [hl], $01 ; $5183
	ld hl, $000f ; $5185
	add hl, bc ; $5188
	ld d, [hl] ; $5189
	ld hl, $000d ; $518a
	add hl, bc ; $518d
	ld h, [hl] ; $518e
	call CheckTileTriggerAtPoint ; $518f
Label_04_5192:
	ldh a, [hInputRisingEdge] ; $5192
	bit PADB_START, a ; $5194
	jr z, Label_04_519d ; $5196
	ld hl, wStoryModeMenuRequest ; $5198
	ld [hl], $01 ; $519b
Label_04_519d:
	ldh a, [hPlayerInputFlags] ; $519d
	bit PADB_B, a ; $519f
	jr z, Label_04_51a6 ; $51a1
	set_flag $02, 1 ; $51a3
Label_04_51a6:
	ld d, $01 ; $51a6
	ldh a, [hPlayerInputFlags] ; $51a8
	and a, $f0 ; $51aa
	jr z, Label_04_51b0 ; $51ac
	ld d, $03 ; $51ae
Label_04_51b0:
	ld hl, $0018 ; $51b0
	add hl, bc ; $51b3
	ld [hl], d ; $51b4
	ld a, [$daec] ; $51b5
	ld [$daed], a ; $51b8
	xor a, a ; $51bb
	ld [$daec], a ; $51bc
	ldh a, [hPlayerInputFlags] ; $51bf
	and a, $f0 ; $51c1
	jr nz, Label_04_51cc ; $51c3
	xor a, a ; $51c5
	ld [$daee], a ; $51c6
	jp Label_04_52e7 ; $51c9
Label_04_51cc:
	ld hl, $532d ; $51cc
	swap a ; $51cf
	ld d, $00 ; $51d1
	ld e, a ; $51d3
	add hl, de ; $51d4
	ld a, [hl] ; $51d5
	cp a, $ff ; $51d6
	jr nz, Label_04_51dd ; $51d8
	jp Label_04_52e7 ; $51da
Label_04_51dd:
	push bc ; $51dd
	ld [$daea], a ; $51de
	ld hl, hActorPtr ; $51e1
	ld a, [hl+] ; $51e4
	ld b, [hl] ; $51e5
	ld c, a ; $51e6
	ld hl, $0034 ; $51e7
	add hl, bc ; $51ea
	ld a, [$daea] ; $51eb
	ld [hl], a ; $51ee
	ld hl, $0015 ; $51ef
	add hl, bc ; $51f2
	ld [hl], $40 ; $51f3
	test_flag $02, 1 ; $51f5
	jr z, Label_04_520b ; $51f8
	ld a, $01 ; $51fa
	ld [$daef], a ; $51fc
	ld de, $0040 ; $51ff
	ld hl, $0006 ; $5202
	add hl, bc ; $5205
	ld a, e ; $5206
	ld [hl+], a ; $5207
	ld [hl], d ; $5208
	jr Label_04_523f ; $5209
Label_04_520b:
	ld hl, $000d ; $520b
	add hl, bc ; $520e
	ld d, [hl] ; $520f
	ld hl, $000f ; $5210
	add hl, bc ; $5213
	ld e, [hl] ; $5214
	farcall FarPtr_ReadCollisionMapCell ; $5215
	ld a, $00 ; $5218
	and a, $0f ; $521a
	cp a, $0b ; $521c
	jr nz, Label_04_5231 ; $521e
	ld a, $02 ; $5220
	ld [$daef], a ; $5222
	ld de, $0010 ; $5225
	ld hl, $0006 ; $5228
	add hl, bc ; $522b
	ld a, e ; $522c
	ld [hl+], a ; $522d
	ld [hl], d ; $522e
	jr Label_04_523f ; $522f
Label_04_5231:
	xor a, a ; $5231
	ld [$daef], a ; $5232
	ld de, $0020 ; $5235
	ld hl, $0006 ; $5238
	add hl, bc ; $523b
	ld a, e ; $523c
	ld [hl+], a ; $523d
	ld [hl], d ; $523e
Label_04_523f:
	test_flag $02, 0 ; $523f
	ld d, $00 ; $5242
	jp nz, Label_04_52b5 ; $5244
	ld a, [$daea] ; $5247
	call GetPointAheadOfActorFixed ; $524a
	call IsPointBlocked ; $524d
	and a, a ; $5250
	jr nz, Label_04_52a3 ; $5251
	ld a, [$daea] ; $5253
	add a, $20 ; $5256
	call GetPointAheadOfActorRanged ; $5258
	call IsPointBlocked ; $525b
	and a, a ; $525e
	jr nz, Label_04_5283 ; $525f
	ld a, [$daea] ; $5261
	add a, $e0 ; $5264
	call GetPointAheadOfActorRanged ; $5266
	call IsPointBlocked ; $5269
	and a, a ; $526c
	ld d, $00 ; $526d
	jr z, Label_04_52b5 ; $526f
	ld a, [$daea] ; $5271
	add a, $40 ; $5274
	call GetPointAheadOfActorFixed ; $5276
	call IsPointBlocked ; $5279
	and a, a ; $527c
	ld d, $20 ; $527d
	jr z, Label_04_52b5 ; $527f
	jr Label_04_52ab ; $5281
Label_04_5283:
	ld a, [$daea] ; $5283
	add a, $e0 ; $5286
	call GetPointAheadOfActorRanged ; $5288
	call IsPointBlocked ; $528b
	and a, a ; $528e
	jr nz, Label_04_52a3 ; $528f
	ld a, [$daea] ; $5291
	add a, $c0 ; $5294
	call GetPointAheadOfActorFixed ; $5296
	call IsPointBlocked ; $5299
	and a, a ; $529c
	ld d, $e0 ; $529d
	jr z, Label_04_52b5 ; $529f
	jr Label_04_52ab ; $52a1
Label_04_52a3:
	ld [$daec], a ; $52a3
	ld hl, $c2a2 ; $52a6
	ld [hl], $01 ; $52a9
Label_04_52ab:
	ld hl, $0014 ; $52ab
	add hl, bc ; $52ae
	ld a, [$daea] ; $52af
	ld [hl], a ; $52b2
	jr Label_04_52d5 ; $52b3
Label_04_52b5:
	ld hl, $0006 ; $52b5
	add hl, bc ; $52b8
	ld a, [hl+] ; $52b9
	ld h, [hl] ; $52ba
	ld l, a ; $52bb
	ld a, [$daea] ; $52bc
	add a, d ; $52bf
	call ProjectPointFromActor ; $52c0
	call CheckTileTriggerAtPoint ; $52c3
	call SetActorMoveTarget ; $52c6
	ld hl, $0005 ; $52c9
	add hl, bc ; $52cc
	set 7, [hl] ; $52cd
	ld hl, $0018 ; $52cf
	add hl, bc ; $52d2
	ld [hl], $02 ; $52d3
Label_04_52d5:
	ld hl, $daee ; $52d5
	inc [hl] ; $52d8
	ld a, [$daec] ; $52d9
	and a, a ; $52dc
	jr nz, Label_04_52e1 ; $52dd
	ld [hl], $00 ; $52df
Label_04_52e1:
	clear_flag $02, 1 ; $52e1
	pop bc ; $52e4
	xor a, a ; $52e5
	ret ; $52e6
Label_04_52e7:
	push bc ; $52e7
	ld hl, hActorPtr ; $52e8
	ld a, [hl+] ; $52eb
	ld b, [hl] ; $52ec
	ld c, a ; $52ed
	ld hl, $000e ; $52ee
	add hl, bc ; $52f1
	ld a, [hl+] ; $52f2
	ld h, [hl] ; $52f3
	ld l, a ; $52f4
	ld de, $0010 ; $52f5
	add hl, de ; $52f8
	ld a, l ; $52f9
	and a, $e0 ; $52fa
	ld l, a ; $52fc
	push hl ; $52fd
	ld hl, $000e ; $52fe
	add hl, bc ; $5301
	pop de ; $5302
	ld [hl], e ; $5303
	inc hl ; $5304
	ld [hl], d ; $5305
	ld hl, $000c ; $5306
	add hl, bc ; $5309
	ld a, [hl+] ; $530a
	ld h, [hl] ; $530b
	ld l, a ; $530c
	ld de, $0010 ; $530d
	add hl, de ; $5310
	ld a, l ; $5311
	and a, $e0 ; $5312
	ld l, a ; $5314
	push hl ; $5315
	ld hl, $000c ; $5316
	add hl, bc ; $5319
	pop de ; $531a
	ld [hl], e ; $531b
	inc hl ; $531c
	ld [hl], d ; $531d
	ld hl, $0005 ; $531e
	add hl, bc ; $5321
	res 7, [hl] ; $5322
	ld hl, $0018 ; $5324
	add hl, bc ; $5327
	ld [hl], $01 ; $5328
	pop bc ; $532a
	xor a, a ; $532b
	ret ; $532c
	INCBIN "data/bank_004/d_532d.bin" ; $532d, 16 bytes
IsPointBlocked:
	call IsTerrainBlockedAtPoint ; $533d
	and a, a ; $5340
	jr nz, Label_04_5348 ; $5341
	call FindActorAtPoint ; $5343
	jr Label_04_534a ; $5346
Label_04_5348:
	or a, $80 ; $5348
Label_04_534a:
	ret ; $534a
IsTerrainBlockedAtPoint:
	push de ; $534b
	ld e, d ; $534c
	ld d, h ; $534d
	farcall FarPtr_ReadCollisionMapCell ; $534e
	and a, $0f ; $5351
	jr z, Label_04_535a ; $5353
	cp a, $0f ; $5355
	jr z, Label_04_535a ; $5357
	xor a, a ; $5359
Label_04_535a:
	pop de ; $535a
	ret ; $535b
TestPointInBox:
	ld a, b ; $535c
	dec a ; $535d
	sub a, h ; $535e
	cp a, d ; $535f
	jr nc, Label_04_5377 ; $5360
	ld a, b ; $5362
	dec a ; $5363
	add a, h ; $5364
	cp a, d ; $5365
	jr c, Label_04_5377 ; $5366
	ld a, c ; $5368
	dec a ; $5369
	sub a, l ; $536a
	cp a, e ; $536b
	jr nc, Label_04_5377 ; $536c
	ld a, c ; $536e
	dec a ; $536f
	add a, l ; $5370
	cp a, e ; $5371
	jr c, Label_04_5377 ; $5372
	xor a, a ; $5374
	jr Label_04_5379 ; $5375
Label_04_5377:
	ld a, $ff ; $5377
Label_04_5379:
	ret ; $5379
IsPointNearPlayer:
	push bc ; $537a
	push de ; $537b
	push hl ; $537c
	ld c, l ; $537d
	ld b, h ; $537e
	ld hl, $d00a ; $537f
	ld a, [hl+] ; $5382
	ld h, [hl] ; $5383
	ld l, a ; $5384
	ld a, l ; $5385
	sub a, e ; $5386
	ld l, a ; $5387
	ld a, h ; $5388
	sbc a, d ; $5389
	ld h, a ; $538a
	bit 7, h ; $538b
	jr z, Label_04_5395 ; $538d
	xor a, a ; $538f
	sub a, l ; $5390
	ld l, a ; $5391
	sbc a, a ; $5392
	sub a, h ; $5393
	ld h, a ; $5394
Label_04_5395:
	srl h ; $5395
	rr l ; $5397
	ld a, h ; $5399
	and a, a ; $539a
	jr nz, Label_04_53d2 ; $539b
	ld a, l ; $539d
	call GetSquareOfByte ; $539e
	ld e, l ; $53a1
	ld d, h ; $53a2
	ld hl, $d008 ; $53a3
	ld a, [hl+] ; $53a6
	ld h, [hl] ; $53a7
	ld l, a ; $53a8
	ld a, l ; $53a9
	sub a, c ; $53aa
	ld l, a ; $53ab
	ld a, h ; $53ac
	sbc a, b ; $53ad
	ld h, a ; $53ae
	bit 7, h ; $53af
	jr z, Label_04_53b9 ; $53b1
	xor a, a ; $53b3
	sub a, l ; $53b4
	ld l, a ; $53b5
	sbc a, a ; $53b6
	sub a, h ; $53b7
	ld h, a ; $53b8
Label_04_53b9:
	srl h ; $53b9
	rr l ; $53bb
	ld a, h ; $53bd
	and a, a ; $53be
	jr nz, Label_04_53d2 ; $53bf
	ld a, l ; $53c1
	call GetSquareOfByte ; $53c2
	add hl, de ; $53c5
	jr c, Label_04_53d2 ; $53c6
	ld de, $4000 ; $53c8
	add hl, de ; $53cb
	jr c, Label_04_53d2 ; $53cc
	ld a, $01 ; $53ce
	jr Label_04_53d3 ; $53d0
Label_04_53d2:
	xor a, a ; $53d2
Label_04_53d3:
	pop hl ; $53d3
	pop de ; $53d4
	pop bc ; $53d5
	ret ; $53d6
FindActorAtPoint:
	push bc ; $53d7
	push de ; $53d8
	push hl ; $53d9
	ld c, l ; $53da
	ld b, h ; $53db
	ld hl, $daf0 ; $53dc
	ld a, c ; $53df
	ld [hl+], a ; $53e0
	ld a, b ; $53e1
	ld [hl+], a ; $53e2
	ld a, e ; $53e3
	ld [hl+], a ; $53e4
	ld a, d ; $53e5
	ld [hl+], a ; $53e6
	ld hl, $da00 ; $53e7
Label_04_53ea:
	ld a, [hl+] ; $53ea
	ld c, a ; $53eb
	ld a, [hl+] ; $53ec
	ld b, a ; $53ed
	and a, a ; $53ee
	jr z, Label_04_5452 ; $53ef
	push hl ; $53f1
	ld hl, $daf2 ; $53f2
	ld a, [hl+] ; $53f5
	ld d, [hl] ; $53f6
	ld e, a ; $53f7
	ld hl, $000e ; $53f8
	add hl, bc ; $53fb
	ld a, [hl+] ; $53fc
	ld h, [hl] ; $53fd
	ld l, a ; $53fe
	ld a, l ; $53ff
	sub a, e ; $5400
	ld l, a ; $5401
	ld a, h ; $5402
	sbc a, d ; $5403
	ld h, a ; $5404
	bit 7, h ; $5405
	jr z, Label_04_540f ; $5407
	xor a, a ; $5409
	sub a, l ; $540a
	ld l, a ; $540b
	sbc a, a ; $540c
	sub a, h ; $540d
	ld h, a ; $540e
Label_04_540f:
	ld a, h ; $540f
	and a, a ; $5410
	jr nz, Label_04_544f ; $5411
	ld a, l ; $5413
	call GetSquareOfByte ; $5414
	push hl ; $5417
	ld hl, $daf0 ; $5418
	ld a, [hl+] ; $541b
	ld d, [hl] ; $541c
	ld e, a ; $541d
	ld hl, $000c ; $541e
	add hl, bc ; $5421
	ld a, [hl+] ; $5422
	ld h, [hl] ; $5423
	ld l, a ; $5424
	ld a, l ; $5425
	sub a, e ; $5426
	ld l, a ; $5427
	ld a, h ; $5428
	sbc a, d ; $5429
	ld h, a ; $542a
	bit 7, h ; $542b
	jr z, Label_04_5435 ; $542d
	xor a, a ; $542f
	sub a, l ; $5430
	ld l, a ; $5431
	sbc a, a ; $5432
	sub a, h ; $5433
	ld h, a ; $5434
Label_04_5435:
	pop de ; $5435
	ld a, h ; $5436
	and a, a ; $5437
	jr nz, Label_04_544f ; $5438
	ld a, l ; $543a
	call GetSquareOfByte ; $543b
	add hl, de ; $543e
	jr c, Label_04_544f ; $543f
	ld de, $1f00 ; $5441
	add hl, de ; $5444
	jr c, Label_04_544f ; $5445
	pop hl ; $5447
	ld l, c ; $5448
	ld h, b ; $5449
	call Func_04_5514 ; $544a
	jr Label_04_5452 ; $544d
Label_04_544f:
	pop hl ; $544f
	jr Label_04_53ea ; $5450
Label_04_5452:
	pop hl ; $5452
	pop de ; $5453
	pop bc ; $5454
	ret ; $5455
BuildNearbyActorList:
	push af ; $5456
	push bc ; $5457
	push de ; $5458
	push hl ; $5459
	ld hl, $da00 ; $545a
	ld bc, $d000 ; $545d
	ld a, $18 ; $5460
Label_04_5462:
	push af ; $5462
	push hl ; $5463
	inc c ; $5464
	ld a, [bc] ; $5465
	dec c ; $5466
	or a, a ; $5467
	jr z, Label_04_54c4 ; $5468
	ld hl, $0030 ; $546a
	add hl, bc ; $546d
	bit 7, [hl] ; $546e
	jr z, Label_04_54c4 ; $5470
	ld hl, $0005 ; $5472
	add hl, bc ; $5475
	bit 3, [hl] ; $5476
	jr z, Label_04_54c4 ; $5478
	ld hl, $d00e ; $547a
	ld a, [hl+] ; $547d
	ld d, [hl] ; $547e
	ld e, a ; $547f
	ld hl, $000e ; $5480
	add hl, bc ; $5483
	ld a, [hl+] ; $5484
	ld h, [hl] ; $5485
	ld l, a ; $5486
	ld a, l ; $5487
	sub a, e ; $5488
	ld l, a ; $5489
	ld a, h ; $548a
	sbc a, d ; $548b
	ld h, a ; $548c
	bit 7, h ; $548d
	jr z, Label_04_5497 ; $548f
	xor a, a ; $5491
	sub a, l ; $5492
	ld l, a ; $5493
	sbc a, a ; $5494
	sub a, h ; $5495
	ld h, a ; $5496
Label_04_5497:
	ld a, h ; $5497
	and a, $fe ; $5498
	jr nz, Label_04_54c4 ; $549a
	ld hl, $d00c ; $549c
	ld a, [hl+] ; $549f
	ld d, [hl] ; $54a0
	ld e, a ; $54a1
	ld hl, $000c ; $54a2
	add hl, bc ; $54a5
	ld a, [hl+] ; $54a6
	ld h, [hl] ; $54a7
	ld l, a ; $54a8
	ld a, l ; $54a9
	sub a, e ; $54aa
	ld l, a ; $54ab
	ld a, h ; $54ac
	sbc a, d ; $54ad
	ld h, a ; $54ae
	bit 7, h ; $54af
	jr z, Label_04_54b9 ; $54b1
	xor a, a ; $54b3
	sub a, l ; $54b4
	ld l, a ; $54b5
	sbc a, a ; $54b6
	sub a, h ; $54b7
	ld h, a ; $54b8
Label_04_54b9:
	ld a, h ; $54b9
	and a, $fe ; $54ba
	jr nz, Label_04_54c4 ; $54bc
	pop hl ; $54be
	ld a, c ; $54bf
	ld [hl+], a ; $54c0
	ld a, b ; $54c1
	ld [hl+], a ; $54c2
	push hl ; $54c3
Label_04_54c4:
	ld hl, $0040 ; $54c4
	add hl, bc ; $54c7
	ld c, l ; $54c8
	ld b, h ; $54c9
	pop hl ; $54ca
	pop af ; $54cb
	dec a ; $54cc
	jr nz, Label_04_5462 ; $54cd
	xor a, a ; $54cf
	ld [hl+], a ; $54d0
	ld [hl+], a ; $54d1
	pop hl ; $54d2
	pop de ; $54d3
	pop bc ; $54d4
	pop af ; $54d5
	ret ; $54d6
Func_04_54d7:
	push af ; $54d7
	push bc ; $54d8
	push de ; $54d9
	push hl ; $54da
	ld hl, $da00 ; $54db
	ld bc, $d000 ; $54de
	ld a, $18 ; $54e1
Label_04_54e3:
	push af ; $54e3
	push hl ; $54e4
	inc c ; $54e5
	ld a, [bc] ; $54e6
	dec c ; $54e7
	or a, a ; $54e8
	jr z, Label_04_5501 ; $54e9
	ld hl, $0030 ; $54eb
	add hl, bc ; $54ee
	bit 7, [hl] ; $54ef
	jr z, Label_04_5501 ; $54f1
	ld hl, $0005 ; $54f3
	add hl, bc ; $54f6
	bit 4, [hl] ; $54f7
	jr z, Label_04_5501 ; $54f9
	pop hl ; $54fb
	ld a, c ; $54fc
	ld [hl+], a ; $54fd
	ld a, b ; $54fe
	ld [hl+], a ; $54ff
	push hl ; $5500
Label_04_5501:
	ld hl, $0040 ; $5501
	add hl, bc ; $5504
	ld c, l ; $5505
	ld b, h ; $5506
	pop hl ; $5507
	pop af ; $5508
	dec a ; $5509
	jr nz, Label_04_54e3 ; $550a
	xor a, a ; $550c
	ld [hl+], a ; $550d
	ld [hl+], a ; $550e
	pop hl ; $550f
	pop de ; $5510
	pop bc ; $5511
	pop af ; $5512
	ret ; $5513
Func_04_5514:
	push de ; $5514
	push hl ; $5515
	ld a, $ff ; $5516
	inc h ; $5518
	dec h ; $5519
	jr z, Label_04_5523 ; $551a
	ld de, $3000 ; $551c
	add hl, de ; $551f
	add hl, hl ; $5520
	add hl, hl ; $5521
	ld a, h ; $5522
Label_04_5523:
	pop hl ; $5523
	pop de ; $5524
	ret ; $5525
Func_04_5526:
	call DrawActorSprite ; $5526
	ld hl, $0030 ; $5529
	add hl, bc ; $552c
	bit 7, [hl] ; $552d
	jr nz, Label_04_5538 ; $552f
	bit 3, [hl] ; $5531
	ret z ; $5533
	call AdvanceActorAnimation ; $5534
	ret ; $5537
Label_04_5538:
	call AdvanceActorAnimation ; $5538
	call Func_04_5673 ; $553b
	call Func_04_56c3 ; $553e
	ret ; $5541
DrawActorSprite:
	ld hl, $0030 ; $5542
	add hl, bc ; $5545
	res 7, [hl] ; $5546
	ld hl, $dae2 ; $5548
	ld a, [hl+] ; $554b
	ld d, [hl] ; $554c
	ld e, a ; $554d
	ld hl, $0010 ; $554e
	add hl, bc ; $5551
	ld a, [hl+] ; $5552
	ld h, [hl] ; $5553
	ld l, a ; $5554
	bit 7, h ; $5555
	jr z, Label_04_557b ; $5557
	xor a, a ; $5559
	sub a, l ; $555a
	ld l, a ; $555b
	sbc a, a ; $555c
	sub a, h ; $555d
	ld h, a ; $555e
	xor a, a ; $555f
	sub a, e ; $5560
	ld e, a ; $5561
	sbc a, a ; $5562
	sub a, d ; $5563
	ld d, a ; $5564
	srl h ; $5565
	rr l ; $5567
	add hl, de ; $5569
	ld e, l ; $556a
	ld d, h ; $556b
	ld hl, $000e ; $556c
	add hl, bc ; $556f
	ld a, [hl+] ; $5570
	ld h, [hl] ; $5571
	ld l, a ; $5572
	ld a, l ; $5573
	sub a, e ; $5574
	ld l, a ; $5575
	ld a, h ; $5576
	sbc a, d ; $5577
	ld h, a ; $5578
	jr Label_04_5583 ; $5579
Label_04_557b:
	ld hl, $000e ; $557b
	add hl, bc ; $557e
	ld a, [hl+] ; $557f
	ld h, [hl] ; $5580
	ld l, a ; $5581
	add hl, de ; $5582
Label_04_5583:
	ld de, $0090 ; $5583
	add hl, de ; $5586
	ld a, h ; $5587
	cp a, $14 ; $5588
	jr nc, Label_04_55c0 ; $558a
	add hl, hl ; $558c
	add hl, hl ; $558d
	add hl, hl ; $558e
	ld e, h ; $558f
	push de ; $5590
	ld hl, $dae0 ; $5591
	ld a, [hl+] ; $5594
	ld d, [hl] ; $5595
	ld e, a ; $5596
	ld hl, $000c ; $5597
	add hl, bc ; $559a
	ld a, [hl+] ; $559b
	ld h, [hl] ; $559c
	ld l, a ; $559d
	add hl, de ; $559e
	ld de, $0010 ; $559f
	add hl, de ; $55a2
	pop de ; $55a3
	ld a, h ; $55a4
	inc a ; $55a5
	cp a, $16 ; $55a6
	jr nc, Label_04_55c0 ; $55a8
	add hl, hl ; $55aa
	add hl, hl ; $55ab
	add hl, hl ; $55ac
	ld d, h ; $55ad
	push bc ; $55ae
	ld hl, $0036 ; $55af
	add hl, bc ; $55b2
	ld a, [hl+] ; $55b3
	ld b, [hl] ; $55b4
	ld c, a ; $55b5
	call QueueSprite16 ; $55b6
	pop bc ; $55b9
	ld hl, $0030 ; $55ba
	add hl, bc ; $55bd
	set 7, [hl] ; $55be
Label_04_55c0:
	ret ; $55c0
AdvanceActorAnimation:
	ld hl, $0030 ; $55c1
	add hl, bc ; $55c4
	bit 1, [hl] ; $55c5
	jr nz, Label_04_562b ; $55c7
	ld hl, $002f ; $55c9
	add hl, bc ; $55cc
	ld a, [hl] ; $55cd
	and a, a ; $55ce
	jr nz, Label_04_562b ; $55cf
Label_04_55d1:
	push bc ; $55d1
	ld hl, $0022 ; $55d2
	add hl, bc ; $55d5
	ld a, [hl] ; $55d6
	ld d, a ; $55d7
	ld hl, $002c ; $55d8
	add hl, bc ; $55db
	ld a, [hl+] ; $55dc
	ld h, [hl] ; $55dd
	ld l, a ; $55de
	ld a, d ; $55df
	call FarReadWord ; $55e0
	ld e, c ; $55e3
	ld d, b ; $55e4
	pop bc ; $55e5
	ld a, e ; $55e6
	cp a, $f0 ; $55e7
	jr c, Label_04_5616 ; $55e9
	cp a, $ff ; $55eb
	jr z, Label_04_55fb ; $55ed
	cp a, $fe ; $55ef
	jr z, Label_04_5611 ; $55f1
	ld hl, $002f ; $55f3
	add hl, bc ; $55f6
	ld [hl], $ff ; $55f7
	jr Label_04_562b ; $55f9
Label_04_55fb:
	ld hl, $002a ; $55fb
	add hl, bc ; $55fe
	ld a, [hl+] ; $55ff
	ld h, [hl] ; $5600
	ld l, a ; $5601
	ld e, d ; $5602
	ld d, $00 ; $5603
	add hl, de ; $5605
	ld e, l ; $5606
	ld d, h ; $5607
	ld hl, $002c ; $5608
	add hl, bc ; $560b
	ld a, e ; $560c
	ld [hl+], a ; $560d
	ld [hl], d ; $560e
	jr Label_04_55d1 ; $560f
Label_04_5611:
	call SetActorAnimation ; $5611
	jr Label_04_55d1 ; $5614
Label_04_5616:
	ld hl, $002f ; $5616
	add hl, bc ; $5619
	ld [hl], d ; $561a
	push de ; $561b
	ld hl, $002c ; $561c
	add hl, bc ; $561f
	ld a, [hl+] ; $5620
	ld d, [hl] ; $5621
	ld e, a ; $5622
	inc de ; $5623
	inc de ; $5624
	ld a, d ; $5625
	ld [hl-], a ; $5626
	ld [hl], e ; $5627
	pop de ; $5628
	jr Label_04_5630 ; $5629
Label_04_562b:
	ld hl, $0033 ; $562b
	add hl, bc ; $562e
	ld e, [hl] ; $562f
Label_04_5630:
	push bc ; $5630
	ld hl, $0005 ; $5631
	add hl, bc ; $5634
	bit 7, [hl] ; $5635
	jr z, Label_04_564c ; $5637
	ld hl, $0019 ; $5639
	add hl, bc ; $563c
	push hl ; $563d
	ld hl, $002f ; $563e
	add hl, bc ; $5641
	ld c, [hl] ; $5642
	pop hl ; $5643
	ld b, [hl] ; $5644
	ld a, c ; $5645
	sub a, b ; $5646
	jr nc, Label_04_565d ; $5647
	xor a, a ; $5649
	jr Label_04_565d ; $564a
Label_04_564c:
	ld hl, $0018 ; $564c
	add hl, bc ; $564f
	push hl ; $5650
	ld hl, $002f ; $5651
	add hl, bc ; $5654
	ld c, [hl] ; $5655
	pop hl ; $5656
	ld b, [hl] ; $5657
	ld a, c ; $5658
	sub a, b ; $5659
	jr nc, Label_04_565d ; $565a
	xor a, a ; $565c
Label_04_565d:
	pop bc ; $565d
	ld hl, $002f ; $565e
	add hl, bc ; $5661
	ld [hl], a ; $5662
	ld hl, $0033 ; $5663
	add hl, bc ; $5666
	ld a, [hl] ; $5667
	cp a, e ; $5668
	jr z, Label_04_5672 ; $5669
	ld [hl], e ; $566b
	ld hl, $0030 ; $566c
	add hl, bc ; $566f
	set 6, [hl] ; $5670
Label_04_5672:
	ret ; $5672
Func_04_5673:
	ld hl, $0030 ; $5673
	add hl, bc ; $5676
	bit 0, [hl] ; $5677
	jr nz, Label_04_5685 ; $5679
	ld hl, $0014 ; $567b
	add hl, bc ; $567e
	ld a, [hl] ; $567f
	ld hl, $0034 ; $5680
	add hl, bc ; $5683
	ld [hl], a ; $5684
Label_04_5685:
	ld d, $00 ; $5685
	ld hl, $0035 ; $5687
	add hl, bc ; $568a
	ld a, [hl] ; $568b
	cp a, $01 ; $568c
	jr z, Label_04_56a3 ; $568e
	ld hl, $0034 ; $5690
	add hl, bc ; $5693
	ld a, [hl] ; $5694
	add a, $08 ; $5695
	swap a ; $5697
	and a, $0f ; $5699
	add a, $b3 ; $569b
	ld l, a ; $569d
	adc a, $56 ; $569e
	sub a, l ; $56a0
	ld h, a ; $56a1
	ld d, [hl] ; $56a2
Label_04_56a3:
	ld hl, $0032 ; $56a3
	add hl, bc ; $56a6
	ld a, [hl] ; $56a7
	cp a, d ; $56a8
	jr z, Label_04_56b2 ; $56a9
	ld [hl], d ; $56ab
	ld hl, $0030 ; $56ac
	add hl, bc ; $56af
	set 6, [hl] ; $56b0
Label_04_56b2:
	ret ; $56b2
	INCBIN "data/bank_004/d_56b3.bin" ; $56b3, 16 bytes
Func_04_56c3:
	test_flag $0d, 7 ; $56c3
	ret nz ; $56c6
	ld hl, $0030 ; $56c7
	add hl, bc ; $56ca
	bit 6, [hl] ; $56cb
	ret z ; $56cd
	res 6, [hl] ; $56ce
	push bc ; $56d0
	ld hl, $0024 ; $56d1
	add hl, bc ; $56d4
	ld a, [hl+] ; $56d5
	ld h, [hl] ; $56d6
	ld l, a ; $56d7
	ld a, e ; $56d8
	add a, a ; $56d9
	add a, l ; $56da
	ld l, a ; $56db
	jr nc, Label_04_56df ; $56dc
	inc h ; $56de
Label_04_56df:
	ld a, [$daf7] ; $56df
	call FarReadWord ; $56e2
	ld l, c ; $56e5
	ld h, b ; $56e6
	ld a, d ; $56e7
	add a, l ; $56e8
	ld l, a ; $56e9
	jr nc, Label_04_56ed ; $56ea
	inc h ; $56ec
Label_04_56ed:
	pop bc ; $56ed
	push hl ; $56ee
	ld hl, $0026 ; $56ef
	add hl, bc ; $56f2
	ld a, [hl+] ; $56f3
	ld d, [hl] ; $56f4
	ld e, a ; $56f5
	pop hl ; $56f6
	push bc ; $56f7
	ld a, [$daf7] ; $56f8
	ld b, a ; $56fb
	ld c, $04 ; $56fc
	call QueueVRAMCopyFromBank ; $56fe
	pop bc ; $5701
	ret ; $5702
Func_04_5703:
	inc h ; $5703
	dec h ; $5704
	ret z ; $5705
	push bc ; $5706
	push de ; $5707
	push hl ; $5708
	wram_bank $04 ; $5709
	ld c, l ; $570f
	ld b, h ; $5710
	ld hl, $0012 ; $5711
	add hl, bc ; $5714
	ld a, [hl+] ; $5715
	ld d, [hl] ; $5716
	ld e, a ; $5717
	ld hl, $0010 ; $5718
	add hl, bc ; $571b
	ld a, [hl+] ; $571c
	ld h, [hl] ; $571d
	ld l, a ; $571e
	or a, h ; $571f
	or a, d ; $5720
	or a, e ; $5721
	pop hl ; $5722
	pop de ; $5723
	pop bc ; $5724
	ret ; $5725
Func_04_5726:
	push af ; $5726
	push bc ; $5727
	ld c, $b4 ; $5728
Label_04_572a:
	call Func_04_5703 ; $572a
	jr z, Label_04_5735 ; $572d
	call AdvanceFrame ; $572f
	dec c ; $5732
	jr nz, Label_04_572a ; $5733
Label_04_5735:
	pop bc ; $5735
	pop af ; $5736
	ret ; $5737
IsActorMoving:
	inc h ; $5738
	dec h ; $5739
	ret z ; $573a
	push hl ; $573b
	wram_bank $04 ; $573c
	ld a, $05 ; $5742
	add a, l ; $5744
	ld l, a ; $5745
	jr nc, Label_04_5749 ; $5746
	inc h ; $5748
Label_04_5749:
	bit 7, [hl] ; $5749
	jr z, Label_04_5751 ; $574b
	ld a, $01 ; $574d
	jr Label_04_5753 ; $574f
Label_04_5751:
	ld a, $00 ; $5751
Label_04_5753:
	pop hl ; $5753
	ret ; $5754
WaitActorMoveDone:
	push af ; $5755
	push bc ; $5756
	ld bc, $0258 ; $5757
Label_04_575a:
	call IsActorMoving ; $575a
	jr z, Label_04_5767 ; $575d
	call AdvanceFrame ; $575f
	dec bc ; $5762
	ld a, c ; $5763
	or a, b ; $5764
	jr nz, Label_04_575a ; $5765
Label_04_5767:
	pop bc ; $5767
	pop af ; $5768
	ret ; $5769
	ds 10390, $ff ; $576a, fill
