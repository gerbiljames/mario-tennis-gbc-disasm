SECTION "ROM Bank $16", ROMX[$4000], BANK[$16]

	farptr RunMatchWinLoseScreen ; $4000
	farptr RunMatchStatsScreen ; $4002
	farptr DecompressCharacterPortrait ; $4004
	push de ; $4006
	push bc ; $4007
	ld c, $00 ; $4008
	call ApplySpriteWobbleX_16 ; $400a
	ld c, $00 ; $400d
	call ApplySpriteWobbleY_16 ; $400f
	ld c, $00 ; $4012
	ld b, $08 ; $4014
DrawWobblingCornerBrackets:
	call QueueSprite ; $4016
	pop bc ; $4019
	pop de ; $401a
	push de ; $401b
	push bc ; $401c
	ld a, b ; $401d
	add d ; $401e
	ld d, a ; $401f
	push de ; $4020
	ld c, $01 ; $4021
	call ApplySpriteWobbleX_16 ; $4023
	ld c, $00 ; $4026
	call ApplySpriteWobbleY_16 ; $4028
	ld c, $00 ; $402b
	ld b, $28 ; $402d
	call QueueSprite ; $402f
	pop de ; $4032
	pop bc ; $4033
	pop de ; $4034
	push de ; $4035
	push bc ; $4036
	ld a, c ; $4037
	add e ; $4038
	ld e, a ; $4039
	ld a, b ; $403a
	add d ; $403b
	ld d, a ; $403c
	push de ; $403d
	ld c, $01 ; $403e
	call ApplySpriteWobbleX_16 ; $4040
	ld c, $01 ; $4043
	call ApplySpriteWobbleY_16 ; $4045
	ld c, $00 ; $4048
	ld b, $68 ; $404a
	call QueueSprite ; $404c
	pop de ; $404f
	pop bc ; $4050
	pop de ; $4051
	ld a, e ; $4052
	add c ; $4053
	ld e, a ; $4054
	push de ; $4055
	ld c, $00 ; $4056
	call ApplySpriteWobbleX_16 ; $4058
	ld c, $01 ; $405b
	call ApplySpriteWobbleY_16 ; $405d
	ld c, $00 ; $4060
	ld b, $48 ; $4062
	call QueueSprite ; $4064
	pop de ; $4067
	ret ; $4068
ApplySpriteWobbleX_16:
	ldh a, [hVBlankCounter] ; $4069
	and $0f ; $406b
	ld hl, SpriteWobbleXTable_16 ; $406d
	add l ; $4070
	ld l, a ; $4071
	jr nc, .readOffset ; $4072
	inc h ; $4074
.readOffset:
	ld a, [hl] ; $4075
	ld b, a ; $4076
	ld a, c ; $4077
	or a ; $4078
	jr z, .subtract ; $4079
	ld a, b ; $407b
	add d ; $407c
	ld d, a ; $407d
	ret ; $407e
.subtract:
	ld a, d ; $407f
	sub b ; $4080
	ld d, a ; $4081
	ret ; $4082
SpriteWobbleXTable_16:
	; $4083, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
ApplySpriteWobbleY_16:
	ldh a, [hVBlankCounter] ; $4093
	and $0f ; $4095
	ld hl, SpriteWobbleYTable_16 ; $4097
	add l ; $409a
	ld l, a ; $409b
	jr nc, .readOffset ; $409c
	inc h ; $409e
.readOffset:
	ld a, [hl] ; $409f
	ld b, a ; $40a0
	ld a, c ; $40a1
	or a ; $40a2
	jr z, .subtract ; $40a3
	ld a, b ; $40a5
	add e ; $40a6
	ld e, a ; $40a7
	ret ; $40a8
.subtract:
	ld a, e ; $40a9
	sub b ; $40aa
	ld e, a ; $40ab
	ret ; $40ac
SpriteWobbleYTable_16:
	; $40ad, 32 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
	db $d5, $c5, $0e, $00, $06, $09, $cd, $51, $1f, $c1, $d1, $d5, $c5, $78, $82, $57 ; 0x10
DrawCornerBrackets_16:
	push de ; $40cd
	ld c, $00 ; $40ce
	ld b, $29 ; $40d0
	call QueueSprite ; $40d2
	pop de ; $40d5
	pop bc ; $40d6
	pop de ; $40d7
	push de ; $40d8
	push bc ; $40d9
	ld a, c ; $40da
	add e ; $40db
	ld e, a ; $40dc
	ld a, b ; $40dd
	add d ; $40de
	ld d, a ; $40df
	push de ; $40e0
	ld c, $00 ; $40e1
	ld b, $69 ; $40e3
	call QueueSprite ; $40e5
	pop de ; $40e8
	pop bc ; $40e9
	pop de ; $40ea
	ld a, e ; $40eb
	add c ; $40ec
	ld e, a ; $40ed
	push de ; $40ee
	ld c, $00 ; $40ef
	ld b, $49 ; $40f1
	call QueueSprite ; $40f3
	pop de ; $40f6
	ret ; $40f7
MoveMenuCursorGrid_16:
	ld a, [wMenuCursorX] ; $40f8
	ld d, a ; $40fb
	ld a, [wMenuCursorY] ; $40fc
	ld e, a ; $40ff
	ld a, [wMenuInputPressed] ; $4100
	bit 4, a ; $4103
	jr z, .checkLeft ; $4105
	ld a, [wMenuCursorX] ; $4107
	inc a ; $410a
	add a ; $410b
	jr nc, .wrapRight ; $410c
	ld a, b ; $410e
	dec a ; $410f
	jr .storeRight ; $4110
.wrapRight:
	rra ; $4112
	cp b ; $4113
	jr c, .storeRight ; $4114
	xor a ; $4116
.storeRight:
	ld [wMenuCursorX], a ; $4117
	jr .compare ; $411a
.checkLeft:
	bit 5, a ; $411c
	jr z, .checkUp ; $411e
	ld a, [wMenuCursorX] ; $4120
	dec a ; $4123
	add a ; $4124
	jr nc, .wrapLeft ; $4125
	ld a, b ; $4127
	dec a ; $4128
	jr .storeLeft ; $4129
.wrapLeft:
	rra ; $412b
	cp b ; $412c
	jr c, .storeLeft ; $412d
	xor a ; $412f
.storeLeft:
	ld [wMenuCursorX], a ; $4130
	jr .compare ; $4133
.checkUp:
	bit 6, a ; $4135
	jr z, .checkDown ; $4137
	ld a, [wMenuCursorY] ; $4139
	dec a ; $413c
	add a ; $413d
	jr nc, .wrapUp ; $413e
	ld a, c ; $4140
	dec a ; $4141
	jr .storeUp ; $4142
.wrapUp:
	rra ; $4144
	cp c ; $4145
	jr c, .storeUp ; $4146
	xor a ; $4148
.storeUp:
	ld [wMenuCursorY], a ; $4149
	jr .compare ; $414c
.checkDown:
	bit 7, a ; $414e
	jr z, .compare ; $4150
	ld a, [wMenuCursorY] ; $4152
	inc a ; $4155
	add a ; $4156
	jr nc, .wrapDown ; $4157
	ld a, c ; $4159
	dec a ; $415a
	jr .storeDown ; $415b
.wrapDown:
	rra ; $415d
	cp c ; $415e
	jr c, .storeDown ; $415f
	xor a ; $4161
.storeDown:
	ld [wMenuCursorY], a ; $4162
.compare:
	ld a, [wMenuCursorX] ; $4165
	cp d ; $4168
	jr nz, .moved ; $4169
	ld a, [wMenuCursorY] ; $416b
	cp e ; $416e
	jr nz, .moved ; $416f
	xor a ; $4171
	ret ; $4172
.moved:
	ld a, $01 ; $4173
	ret ; $4175
MoveMenuCursorGridFromLinkInput_16:
	ld a, [wMenuCursorX] ; $4176
	ld d, a ; $4179
	ld a, [wMenuCursorY] ; $417a
	ld e, a ; $417d
	ldh a, [hLinkInput] ; $417e
	bit 4, a ; $4180
	jr z, .checkLeft ; $4182
	ld a, [wMenuCursorX] ; $4184
	inc a ; $4187
	add a ; $4188
	jr nc, .wrapRight ; $4189
	ld a, b ; $418b
	dec a ; $418c
	jr .storeRight ; $418d
.wrapRight:
	rra ; $418f
	cp b ; $4190
	jr c, .storeRight ; $4191
	xor a ; $4193
.storeRight:
	ld [wMenuCursorX], a ; $4194
	jr .compare ; $4197
.checkLeft:
	bit 5, a ; $4199
	jr z, .checkUp ; $419b
	ld a, [wMenuCursorX] ; $419d
	dec a ; $41a0
	add a ; $41a1
	jr nc, .wrapLeft ; $41a2
	ld a, b ; $41a4
	dec a ; $41a5
	jr .storeLeft ; $41a6
.wrapLeft:
	rra ; $41a8
	cp b ; $41a9
	jr c, .storeLeft ; $41aa
	xor a ; $41ac
.storeLeft:
	ld [wMenuCursorX], a ; $41ad
	jr .compare ; $41b0
.checkUp:
	bit 6, a ; $41b2
	jr z, .checkDown ; $41b4
	ld a, [wMenuCursorY] ; $41b6
	dec a ; $41b9
	add a ; $41ba
	jr nc, .wrapUp ; $41bb
	ld a, c ; $41bd
	dec a ; $41be
	jr .storeUp ; $41bf
.wrapUp:
	rra ; $41c1
	cp c ; $41c2
	jr c, .storeUp ; $41c3
	xor a ; $41c5
.storeUp:
	ld [wMenuCursorY], a ; $41c6
	jr .compare ; $41c9
.checkDown:
	bit 7, a ; $41cb
	jr z, .compare ; $41cd
	ld a, [wMenuCursorY] ; $41cf
	inc a ; $41d2
	add a ; $41d3
	jr nc, .wrapDown ; $41d4
	ld a, c ; $41d6
	dec a ; $41d7
	jr .storeDown ; $41d8
.wrapDown:
	rra ; $41da
	cp c ; $41db
	jr c, .storeDown ; $41dc
	xor a ; $41de
.storeDown:
	ld [wMenuCursorY], a ; $41df
.compare:
	ld a, [wMenuCursorX] ; $41e2
	cp d ; $41e5
	jr nz, .moved ; $41e6
	ld a, [wMenuCursorY] ; $41e8
	cp e ; $41eb
	jr nz, .moved ; $41ec
	xor a ; $41ee
	ret ; $41ef
.moved:
	ld a, $01 ; $41f0
	ret ; $41f2
MoveMenuCursorGridRemote_16:
	ld a, [wMenuCursorX] ; $41f3
	ld d, a ; $41f6
	ld a, [wMenuCursorY] ; $41f7
	ld e, a ; $41fa
	ldh a, [hLinkState] ; $41fb
	cp $02 ; $41fd
	jr z, .asSlave ; $41ff
	cp $01 ; $4201
	jr z, .asMaster ; $4203
	call LinkErrorReset ; $4205
.asMaster:
	ldh a, [hLinkRemoteInputBuf] ; $4208
	jr .haveInput ; $420a
.asSlave:
	ldh a, [hLinkRemoteInput] ; $420c
.haveInput:
	ld h, a ; $420e
	ld a, [wMenuCursorLockFlags] ; $420f
	and $01 ; $4212
	ld a, h ; $4214
	jr nz, .checkLock ; $4215
	bit 4, a ; $4217
	jr z, .checkLeft ; $4219
	ld a, [wMenuCursorX] ; $421b
	inc a ; $421e
	add a ; $421f
	jr nc, .wrapRight ; $4220
	ld a, b ; $4222
	dec a ; $4223
	jr .storeRight ; $4224
.wrapRight:
	rra ; $4226
	cp b ; $4227
	jr c, .storeRight ; $4228
	xor a ; $422a
.storeRight:
	ld [wMenuCursorX], a ; $422b
	jr .compare ; $422e
.checkLeft:
	bit 5, a ; $4230
	jr z, .checkUp ; $4232
	ld a, [wMenuCursorX] ; $4234
	dec a ; $4237
	add a ; $4238
	jr nc, .wrapLeft ; $4239
	ld a, b ; $423b
	dec a ; $423c
	jr .storeLeft ; $423d
.wrapLeft:
	rra ; $423f
	cp b ; $4240
	jr c, .storeLeft ; $4241
	xor a ; $4243
.storeLeft:
	ld [wMenuCursorX], a ; $4244
	jr .compare ; $4247
.checkUp:
	bit 6, a ; $4249
	jr z, .checkDown ; $424b
	ld a, [wMenuCursorY] ; $424d
	dec a ; $4250
	add a ; $4251
	jr nc, .wrapUp ; $4252
	ld a, c ; $4254
	dec a ; $4255
	jr .storeUp ; $4256
.wrapUp:
	rra ; $4258
	cp c ; $4259
	jr c, .storeUp ; $425a
	xor a ; $425c
.storeUp:
	ld [wMenuCursorY], a ; $425d
	jr .compare ; $4260
.checkDown:
	bit 7, a ; $4262
	jr z, .checkLock ; $4264
	ld a, [wMenuCursorY] ; $4266
	inc a ; $4269
	add a ; $426a
	jr nc, .wrapDown ; $426b
	ld a, c ; $426d
	dec a ; $426e
	jr .storeDown ; $426f
.wrapDown:
	rra ; $4271
	cp c ; $4272
	jr c, .storeDown ; $4273
	xor a ; $4275
.storeDown:
	ld [wMenuCursorY], a ; $4276
	jr .compare ; $4279
.checkLock:
	bit 0, a ; $427b
	jr z, .checkUnlock ; $427d
	sound SFX_MENU_SELECT ; $427f
	ld a, [wMenuCursorLockFlags] ; $4281
	ld b, a ; $4284
	and $01 ; $4285
	jr nz, .compare ; $4287
	sound SFX_MENU_SELECT ; $4289
	ld a, b ; $428b
	or $01 ; $428c
	ld [wMenuCursorLockFlags], a ; $428e
	jr .compare ; $4291
.checkUnlock:
	bit 1, a ; $4293
	jr z, .compare ; $4295
	sound SFX_MENU_CANCEL ; $4297
	ld a, [wMenuCursorLockFlags] ; $4299
	ld b, a ; $429c
	and $03 ; $429d
	ld a, b ; $429f
	jr nz, .clearLock ; $42a0
	and $fa ; $42a2
	or $04 ; $42a4
	jr .storeLock ; $42a6
.clearLock:
	and $fe ; $42a8
.storeLock:
	ld [wMenuCursorLockFlags], a ; $42aa
.compare:
	ld a, [wMenuCursorX] ; $42ad
	cp d ; $42b0
	jr nz, .moved ; $42b1
	ld a, [wMenuCursorY] ; $42b3
	cp e ; $42b6
	jr nz, .moved ; $42b7
	xor a ; $42b9
	ret ; $42ba
.moved:
	ld a, $01 ; $42bb
	ret ; $42bd
MoveMenuCursor2GridRemote_16:
	ld a, [wMenuCursor2X] ; $42be
	ld d, a ; $42c1
	ld a, [wMenuCursor2Y] ; $42c2
	ld e, a ; $42c5
	ldh a, [hLinkState] ; $42c6
	cp $02 ; $42c8
	jr z, .asSlave ; $42ca
	cp $01 ; $42cc
	jr z, .asMaster ; $42ce
	call LinkErrorReset ; $42d0
.asMaster:
	ldh a, [hLinkRemoteInput] ; $42d3
	jr .haveInput ; $42d5
.asSlave:
	ldh a, [hLinkRemoteInputBuf] ; $42d7
.haveInput:
	ld h, a ; $42d9
	ld a, [wMenuCursorLockFlags] ; $42da
	and $02 ; $42dd
	ld a, h ; $42df
	jr nz, .checkLock ; $42e0
	bit 4, a ; $42e2
	jr z, .checkLeft ; $42e4
	ld a, [wMenuCursor2X] ; $42e6
	inc a ; $42e9
	add a ; $42ea
	jr nc, .wrapRight ; $42eb
	ld a, b ; $42ed
	dec a ; $42ee
	jr .storeRight ; $42ef
.wrapRight:
	rra ; $42f1
	cp b ; $42f2
	jr c, .storeRight ; $42f3
	xor a ; $42f5
.storeRight:
	ld [wMenuCursor2X], a ; $42f6
	jr .compare ; $42f9
.checkLeft:
	bit 5, a ; $42fb
	jr z, .checkUp ; $42fd
	ld a, [wMenuCursor2X] ; $42ff
	dec a ; $4302
	add a ; $4303
	jr nc, .wrapLeft ; $4304
	ld a, b ; $4306
	dec a ; $4307
	jr .storeLeft ; $4308
.wrapLeft:
	rra ; $430a
	cp b ; $430b
	jr c, .storeLeft ; $430c
	xor a ; $430e
.storeLeft:
	ld [wMenuCursor2X], a ; $430f
	jr .compare ; $4312
.checkUp:
	bit 6, a ; $4314
	jr z, .checkDown ; $4316
	ld a, [wMenuCursor2Y] ; $4318
	dec a ; $431b
	add a ; $431c
	jr nc, .wrapUp ; $431d
	ld a, c ; $431f
	dec a ; $4320
	jr .storeUp ; $4321
.wrapUp:
	rra ; $4323
	cp c ; $4324
	jr c, .storeUp ; $4325
	xor a ; $4327
.storeUp:
	ld [wMenuCursor2Y], a ; $4328
	jr .compare ; $432b
.checkDown:
	bit 7, a ; $432d
	jr z, .checkLock ; $432f
	ld a, [wMenuCursor2Y] ; $4331
	inc a ; $4334
	add a ; $4335
	jr nc, .wrapDown ; $4336
	ld a, c ; $4338
	dec a ; $4339
	jr .storeDown ; $433a
.wrapDown:
	rra ; $433c
	cp c ; $433d
	jr c, .storeDown ; $433e
	xor a ; $4340
.storeDown:
	ld [wMenuCursor2Y], a ; $4341
	jr .compare ; $4344
.checkLock:
	bit 0, a ; $4346
	jr z, .checkUnlock ; $4348
	ld a, [wMenuCursorLockFlags] ; $434a
	ld b, a ; $434d
	and $02 ; $434e
	jr nz, .compare ; $4350
	sound SFX_MENU_SELECT ; $4352
	ld a, b ; $4354
	or $02 ; $4355
	ld [wMenuCursorLockFlags], a ; $4357
	jr .compare ; $435a
.checkUnlock:
	bit 1, a ; $435c
	jr z, .compare ; $435e
	sound SFX_MENU_CANCEL ; $4360
	ld a, [wMenuCursorLockFlags] ; $4362
	ld b, a ; $4365
	and $03 ; $4366
	ld a, b ; $4368
	jr nz, .clearLock ; $4369
	and $f5 ; $436b
	or $08 ; $436d
	jr .storeLock ; $436f
.clearLock:
	and $fd ; $4371
.storeLock:
	ld [wMenuCursorLockFlags], a ; $4373
.compare:
	ld a, [wMenuCursor2X] ; $4376
	cp d ; $4379
	jr nz, .moved ; $437a
	ld a, [wMenuCursor2Y] ; $437c
	cp e ; $437f
	jr nz, .moved ; $4380
	xor a ; $4382
	ret ; $4383
.moved:
	ld a, $01 ; $4384
	ret ; $4386
GetMenuCursorIndex_16:
	ld a, [wMenuCursorY] ; $4387
	ld b, a ; $438a
	xor a ; $438b
	inc b ; $438c
.mulLoop:
	dec b ; $438d
	jr z, .addColumn ; $438e
	add c ; $4390
	jr .mulLoop ; $4391
.addColumn:
	ld b, a ; $4393
	ld a, [wMenuCursorX] ; $4394
	add b ; $4397
	ret ; $4398
GetCellIndexFromCursorPtr_16:
	push bc ; $4399
	ld a, [hl-] ; $439a
	ld b, a ; $439b
	xor a ; $439c
	inc b ; $439d
.loop:
	dec b ; $439e
	jr z, .countDone ; $439f
	add c ; $43a1
	jr .loop ; $43a2
.countDone:
	ld b, a ; $43a4
	ld a, [hl] ; $43a5
	add b ; $43a6
	pop bc ; $43a7
	ret ; $43a8
SetMenuCursorFromIndex_16:
	ld d, $00 ; $43a9
	ld a, c ; $43ab
.divLoop:
	cp b ; $43ac
	jr c, .store ; $43ad
	inc d ; $43af
	sub b ; $43b0
	jr .divLoop ; $43b1
.store:
	ld [wMenuCursorX], a ; $43b3
	ld a, d ; $43b6
	ld [wMenuCursorY], a ; $43b7
	ret ; $43ba
SetMenuCursorFromIndexToPtr_16:
	ld d, $00 ; $43bb
	ld a, c ; $43bd
.divLoop:
	cp b ; $43be
	jr c, .store ; $43bf
	inc d ; $43c1
	sub b ; $43c2
	jr .divLoop ; $43c3
.store:
	ld [hl+], a ; $43c5
	ld a, d ; $43c6
	ld [hl], a ; $43c7
	ret ; $43c8
ClearWram3Row64_16:
	push_wram_bank $03 ; $43c9
	xor a ; $43d2
	ld c, $40 ; $43d3
.loop:
	ld [hl+], a ; $43d5
	dec c ; $43d6
	jr nz, .loop ; $43d7
	pop_wram_bank ; $43d9
	ret ; $43de
ClearWram3Row64Alt_16:
	push_wram_bank $03 ; $43df
	ld a, $00 ; $43e8
	ld c, $40 ; $43ea
.loop:
	ld [hl+], a ; $43ec
	dec c ; $43ed
	jr nz, .loop ; $43ee
	pop_wram_bank ; $43f0
	ret ; $43f5
UpdateResultScreenAnimatedTilesTask:
	farcall UpdateAnimatedTiles ; $43f6
	ret ; $43f9
UnusedDrawCourtDiagramMarkers:
	push af ; $43fa
	push bc ; $43fb
.loop:
	ld a, [hl] ; $43fc
	cp $00 ; $43fd
	jr z, CourtDiagramBaseTask.restore ; $43ff
	ld [de], a ; $4401
	inc hl ; $4402
	ld a, [hl] ; $4403
	cp $de ; $4404
CourtDiagramBaseTask:
	jr z, .eqde ; $4406
	cp $df ; $4408
	jr nz, .nedf ; $440a
.eqde:
	push hl ; $440c
	push bc ; $440d
	ld h, d ; $440e
	ld l, e ; $440f
	ld bc, $ffe0 ; $4410
	add hl, bc ; $4413
	ld b, a ; $4414
	ld a, [hl] ; $4415
	cp $03 ; $4416
	ld a, b ; $4418
	jr nz, .store ; $4419
	sub $d0 ; $441b
.store:
	ld [hl], a ; $441d
	pop bc ; $441e
	pop hl ; $441f
	inc hl ; $4420
.nedf:
	inc de ; $4421
	ld a, e ; $4422
	and $1f ; $4423
	jr nz, UnusedDrawCourtDiagramMarkers.loop ; $4425
	push hl ; $4427
	ld h, d ; $4428
	ld l, e ; $4429
	add hl, de ; $442a
	ld d, h ; $442b
	ld e, l ; $442c
	pop hl ; $442d
	jr UnusedDrawCourtDiagramMarkers.loop ; $442e
.restore:
	pop bc ; $4430
	pop af ; $4431
	ret ; $4432
UnusedPrintDecimalNumber_16:
	push af ; $4433
	push bc ; $4434
	push hl ; $4435
	add sp, -10 ; $4436
	push bc ; $4438
	push de ; $4439
	ld c, l ; $443a
	ld b, h ; $443b
	ld hl, sp + 4 ; $443c
	ld e, l ; $443e
	ld d, h ; $443f
	ld l, c ; $4440
	ld h, b ; $4441
	ld c, e ; $4442
PrintDecimalNumber:
	ld b, d ; $4443
	call FormatDecimalNumber ; $4444
	ld l, c ; $4447
	ld h, b ; $4448
	pop de ; $4449
	pop bc ; $444a
	call PrintNumberString_16 ; $444b
	add sp, 10 ; $444e
	pop hl ; $4450
	pop bc ; $4451
	pop af ; $4452
	ret ; $4453
PrintNumberString_16:
	ld a, [hl+] ; $4454
	and a ; $4455
	jr z, .done ; $4456
	call PrintNumberStringChar_16 ; $4458
	jr PrintNumberString_16 ; $445b
.done:
	ret ; $445d
PrintNumberStringChar_16:
	push hl ; $445e
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH ; $445f
	sub $30 ; $4462
	jr c, .carry ; $4464
	add $30 ; $4466
	ld b, a ; $4468
	wram_bank $03 ; $4469
	ld a, b ; $446f
	ld [de], a ; $4470
	inc de ; $4471
	pop hl ; $4472
	ret ; $4473
.carry:
	inc de ; $4474
	pop hl ; $4475
	ret ; $4476
RunMatchWinLoseScreen:
	ld a, [wMatchAbortFlag] ; $4477
	bit MATCHABORTB_MATCH, a ; $447a
	ret nz ; $447c
	call DisableLCDSafely ; $447d
	call ClearFrameTasks ; $4480
	wram_bank $03 ; $4483
	ld a, [wGameMode] ; $4489
	cp GAMEMODE_EXHIBITION ; $448c
	jr z, .step ; $448e
	cp GAMEMODE_LINK_MATCH ; $4490
	jr z, .step ; $4492
	jr .checkMatchWinLoseFlag ; $4494
.step:
	ld a, $01 ; $4496
	jr .store ; $4498
.checkMatchWinLoseFlag:
	xor a ; $449a
.store:
	ld [wResultScreenWon], a ; $449b
	ld [wResultScreenMode], a ; $449e
	ld a, [wMatchWinLoseFlag] ; $44a1
	ld [wMatchWinLoseState], a ; $44a4
	call ApplyLinkRoleToWinLoseFlag ; $44a7
	ld a, $ff ; $44aa
	ld a, [wMatchWinLoseFlag] ; $44ac
	cp WINLOSE_LOSE ; $44af
	jr z, .playSfx ; $44b1
	sound BGM_WIN ; $44b3
	jr .initMatchWinLoseScreen ; $44b5
.playSfx:
	sound BGM_LOSE ; $44b7
.initMatchWinLoseScreen:
	call InitMatchWinLoseScreen ; $44b9
	farcall UpdateAnimatedTiles ; $44bc
	ld a, $01 ; $44bf
	ld hl, UpdateResultScreenAnimatedTilesTask ; $44c1
	call RegisterFrameTask ; $44c4
	ld a, $01 ; $44c7
	ld hl, QueueResultScreenSprites ; $44c9
	call RegisterFrameTask ; $44cc
	call EnableLCD ; $44cf
	script_fade_in $10 ; $44d2
	call WaitFadeEnd ; $44d7
	ld a, $08 ; $44da
	ldh [rSTAT], a ; $44dc
	ld hl, rIE ; $44de
	set 1, [hl] ; $44e1
	ld a, $48 ; $44e3
	ld [wRasterScrollStartLY], a ; $44e5
	ld a, $57 ; $44e8
	ld [wRasterScrollEndLY], a ; $44ea
	xor a ; $44ed
	ld [wRasterScrollX], a ; $44ee
	ld a, $01 ; $44f1
	ld hl, AdvanceResultScreenTimer ; $44f3
	call RegisterFrameTask ; $44f6
.loop:
	call AdvanceFrame ; $44f9
	ld a, [wCurrentMinigameStoryMatch + 1] ; $44fc
	push de ; $44ff
	push af ; $4500
	ld a, a ; $4501
	ld de, $0303 ; $4502
	call PrintDecimalByte ; $4505
	pop af ; $4508
	pop de ; $4509
	ldh a, [hInputPressed] ; $450a
	ld [wMenuInputPressed], a ; $450c
	bit PADB_A, a ; $450f
	jr nz, .playSfx2 ; $4511
	bit 1, a ; $4513
	jr nz, .playSfx2 ; $4515
	bit 4, a ; $4517
	jr nz, .bit4Set ; $4519
	jr .loop ; $451b
.playSfx2:
	sound SFX_MENU_SELECT ; $451d
	call ClearFrameTasks ; $451f
	ld c, $40 ; $4522
	call BeginFadeOut ; $4524
	call WaitFadeEnd ; $4527
	ld hl, rIE ; $452a
	res 1, [hl] ; $452d
	ld a, $03 ; $452f
	ld [wAnimatedTilePeriod], a ; $4531
	ld a, [wMatchWinLoseState] ; $4534
	ld [wMatchWinLoseFlag], a ; $4537
	ret ; $453a
.bit4Set:
	ld c, $40 ; $453b
	call BeginFadeOut ; $453d
	call WaitFadeEnd ; $4540
	ld hl, rIE ; $4543
	res 1, [hl] ; $4546
	call ClearFrameTasks ; $4548
	call RunMatchStatsScreen ; $454b
	push af ; $454e
	ld a, [wMatchWinLoseState] ; $454f
	ld [wMatchWinLoseFlag], a ; $4552
	pop af ; $4555
	cp $ff ; $4556
	jp nz, RunMatchWinLoseScreen ; $4558
	call ClearFrameTasks ; $455b
	ld c, $08 ; $455e
	call BeginFadeOut ; $4560
	call WaitFadeEnd ; $4563
	ld hl, rIE ; $4566
	res 1, [hl] ; $4569
	ld a, $03 ; $456b
	ld [wAnimatedTilePeriod], a ; $456d
	ret ; $4570
InitMatchWinLoseScreen:
	call ClearFrameTasks ; $4571
	xor a ; $4574
	ldh [hScrollX], a ; $4575
	ldh [hScrollY], a ; $4577
	call LoadWinLoseScreenAssets ; $4579
	wram_bank $03 ; $457c
	ld de, wShadowAttrmap + 11 * TILEMAP_WIDTH ; $4582
	ld b, $14 ; $4585
	ld c, $05 ; $4587
	ld h, $0a ; $4589
	farcall FillTilemapRect ; $458b
	ld a, $00 ; $458e
	ld d, $04 ; $4590
	farcall LoadIndexedPalette_18 ; $4592
	ld a, $00 ; $4595
	ld d, $05 ; $4597
	farcall LoadIndexedPalette_18 ; $4599
	ld a, $00 ; $459c
	ld d, $06 ; $459e
	farcall LoadIndexedPalette_18 ; $45a0
	ld a, $00 ; $45a3
	ld d, $07 ; $45a5
	farcall LoadIndexedPalette_18 ; $45a7
	call LoadMatchResultPalettes ; $45aa
	call AdjustResultTilemapForLoss ; $45ad
	call LoadResultScreenTileGraphics ; $45b0
	call SetWinLosePortraitPaletteAttrs ; $45b3
	ld c, $00 ; $45b6
	call LoadResultScreenPortraits ; $45b8
	push_wram_bank $01 ; $45bb
	ld hl, MatchWinLoseScreenGfx ; $45c4
	ld de, wDecompBuffer ; $45c7
	call DecompressData ; $45ca
	ld hl, wDecompBuffer ; $45cd
	ld de, $8000 + VRAM_BANK1 ; $45d0
	ld c, $20 ; $45d3
	call QueueVRAMCopy ; $45d5
	ld hl, MatchWinLoseScreenGfx1 ; $45d8
	ld de, wDecompBuffer ; $45db
	call DecompressData ; $45de
	ld hl, wDecompBuffer ; $45e1
	ld de, $8200 + VRAM_BANK1 ; $45e4
	ld c, $20 ; $45e7
	call QueueVRAMCopy ; $45e9
	ld hl, MatchWinLoseScreenPalettes ; $45ec
	lb de, $08, $03 ; $45ef palette index, count
	call LoadPaletteShadow ; $45f2
	ld b, $09 ; $45f5
	ld c, $04 ; $45f7
	ld de, $8400 + VRAM_BANK1 ; $45f9
	farcall LoadCompressedTileBlock ; $45fc
	pop_wram_bank ; $45ff
	farcall QueueWram3MapToVRAM ; $4604
	ret ; $4607
MatchWinLoseScreenGfx:
	INCBIN "data/bank_016/MatchWinLoseScreenGfx.bin" ; $4608, 110 bytes
DiagramHighlightPaletteTask:
	INCBIN "data/bank_016/DiagramHighlightPaletteTask.bin" ; $4676, 108 bytes
DiagramNearFigureSpriteTask:
	INCBIN "data/bank_016/DiagramNearFigureSpriteTask.bin" ; $46e2, 42 bytes
DiagramFarFigureSpriteTask:
	INCBIN "data/bank_016/DiagramFarFigureSpriteTask.bin" ; $470c, 42 bytes
DiagramMarkerSpriteTask:
	INCBIN "data/bank_016/DiagramMarkerSpriteTask.bin" ; $4736, 30 bytes
DiagramBallSpriteTask:
	INCBIN "data/bank_016/DiagramBallSpriteTask.bin" ; $4754, 48 bytes
MatchWinLoseScreenGfx1:
	INCBIN "data/bank_016/MatchWinLoseScreenGfx1.bin" ; $4784, 10 bytes
DiagramSwingFigureSpriteTask:
	INCBIN "data/bank_016/DiagramSwingFigureSpriteTask.bin" ; $478e, 97 bytes
DiagramPolePairSpriteTask:
	INCBIN "data/bank_016/DiagramPolePairSpriteTask.bin" ; $47ef, 135 bytes
DiagramSpotMarkerSpriteTask:
	INCBIN "data/bank_016/DiagramSpotMarkerSpriteTask.bin" ; $4876, 75 bytes
DiagramTargetBracketsSpriteTask:
	INCBIN "data/bank_016/DiagramTargetBracketsSpriteTask.bin" ; $48c1, 51 bytes
MatchWinLoseScreenPalettes:
	INCBIN "data/bank_016/MatchWinLoseScreenPalettes.bin" ; $48f4, 24 bytes
LoadWinLoseScreenAssets:
	ld a, [wResultScreenWon] ; $490c
	or a ; $490f
	jr z, .zero ; $4910
	ld c, $14 ; $4912
	farcall LoadScreenAssetRecord ; $4914
	jr .testGameFlagByNumber ; $4917
.zero:
	ld c, $13 ; $4919
	farcall LoadScreenAssetRecord ; $491b
	jr .testGameFlagByNumber ; $491e
.testGameFlagByNumber:
	ld de, FLAG_DOUBLES ; $4920
	call TestGameFlagByNumber ; $4923
	jr nz, .done ; $4926
	wram_bank $03 ; $4928
	ld hl, wShadowTilemap + 20 * TILEMAP_WIDTH ; $492e
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH + 11 ; $4931
	ld b, $09 ; $4934
	ld c, $05 ; $4936
	farcall CopyTilemapRect ; $4938
	ld hl, wShadowAttrmap + 20 * TILEMAP_WIDTH ; $493b
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 11 ; $493e
	ld b, $09 ; $4941
	ld c, $05 ; $4943
	farcall CopyTilemapRect ; $4945
	ld hl, wShadowTilemap + 20 * TILEMAP_WIDTH + 9 ; $4948
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 1 ; $494b
	ld b, $08 ; $494e
	ld c, $05 ; $4950
	farcall CopyTilemapRect ; $4952
	ld hl, wShadowAttrmap + 20 * TILEMAP_WIDTH + 9 ; $4955
	ld de, wShadowAttrmap + 11 * TILEMAP_WIDTH + 1 ; $4958
	ld b, $08 ; $495b
	ld c, $05 ; $495d
	farcall CopyTilemapRect ; $495f
.done:
	ret ; $4962
SetWinLosePortraitPaletteAttrs:
	ld a, [wResultScreenMode] ; $4963
	or a ; $4966
	jr nz, .nonZero ; $4967
	ld de, FLAG_DOUBLES ; $4969
	call TestGameFlagByNumber ; $496c
	jr z, .zero ; $496f
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 11 ; $4971
	ld b, $04 ; $4974
	ld c, $04 ; $4976
	ld h, $0c ; $4978
	farcall FillTilemapRect ; $497a
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 15 ; $497d
	ld b, $04 ; $4980
	ld c, $04 ; $4982
	ld h, $0d ; $4984
	farcall FillTilemapRect ; $4986
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 2 ; $4989
	ld b, $03 ; $498c
	ld c, $03 ; $498e
	ld h, $0e ; $4990
	farcall FillTilemapRect ; $4992
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 5 ; $4995
	ld b, $03 ; $4998
	ld c, $03 ; $499a
	ld h, $0f ; $499c
	farcall FillTilemapRect ; $499e
	jr .done ; $49a1
.zero:
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 13 ; $49a3
	ld b, $04 ; $49a6
	ld c, $04 ; $49a8
	ld h, $0c ; $49aa
	farcall FillTilemapRect ; $49ac
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 3 ; $49af
	ld b, $03 ; $49b2
	ld c, $03 ; $49b4
	ld h, $0e ; $49b6
	farcall FillTilemapRect ; $49b8
.done:
	ret ; $49bb
.nonZero:
	ld de, FLAG_DOUBLES ; $49bc
	call TestGameFlagByNumber ; $49bf
	jr z, .fillTilemapRect ; $49c2
	ld de, wShadowAttrmap + 5 * TILEMAP_WIDTH + 12 ; $49c4
	ld b, $03 ; $49c7
	ld c, $03 ; $49c9
	ld h, $0c ; $49cb
	farcall FillTilemapRect ; $49cd
	ld de, wShadowAttrmap + 5 * TILEMAP_WIDTH + 15 ; $49d0
	ld b, $03 ; $49d3
	ld c, $03 ; $49d5
	ld h, $0d ; $49d7
	farcall FillTilemapRect ; $49d9
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 2 ; $49dc
	ld b, $03 ; $49df
	ld c, $03 ; $49e1
	ld h, $0e ; $49e3
	farcall FillTilemapRect ; $49e5
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 5 ; $49e8
	ld b, $03 ; $49eb
	ld c, $03 ; $49ed
	ld h, $0f ; $49ef
	farcall FillTilemapRect ; $49f1
	jr .doneB ; $49f4
.fillTilemapRect:
	ld de, wShadowAttrmap + 5 * TILEMAP_WIDTH + 13 ; $49f6
	ld b, $03 ; $49f9
	ld c, $03 ; $49fb
	ld h, $0c ; $49fd
	farcall FillTilemapRect ; $49ff
	ld de, wShadowAttrmap + 12 * TILEMAP_WIDTH + 3 ; $4a02
	ld b, $03 ; $4a05
	ld c, $03 ; $4a07
	ld h, $0e ; $4a09
	farcall FillTilemapRect ; $4a0b
.doneB:
	ret ; $4a0e
LoadMatchResultPalettes:
	ld a, [wMatchWinLoseFlag] ; $4a0f
	cp WINLOSE_LOSE ; $4a12
	jr z, .eqff ; $4a14
	ld a, $02 ; $4a16
	ld [wAnimatedTileSet], a ; $4a18
	ld hl, MatchResultPalettes1 ; $4a1b
	lb de, $01, $01 ; $4a1e palette index, count
	call LoadPaletteShadow ; $4a21
	ld hl, MatchResultPalettes0 ; $4a24
	lb de, $02, $01 ; $4a27 palette index, count
	call LoadPaletteShadow ; $4a2a
	ret ; $4a2d
.eqff:
	ld a, $03 ; $4a2e
	ld [wAnimatedTileSet], a ; $4a30
	ld hl, MatchResultPalettes1 ; $4a33
	lb de, $02, $01 ; $4a36 palette index, count
	call LoadPaletteShadow ; $4a39
	ld hl, MatchResultPalettes0 ; $4a3c
	lb de, $01, $01 ; $4a3f palette index, count
	call LoadPaletteShadow ; $4a42
	ret ; $4a45
MatchResultPalettes0:
	INCLUDE "data/bank_016/MatchResultPalettes0.asm" ; $4a46, 8 bytes (palettes)
MatchResultPalettes1:
	INCLUDE "data/bank_016/MatchResultPalettes1.asm" ; $4a4e, 8 bytes (palettes)
AdjustResultTilemapForLoss:
	ld a, [wMatchWinLoseFlag] ; $4a56
	cp WINLOSE_LOSE ; $4a59
	jr nz, .done ; $4a5b
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH ; $4a5d
	ld de, wShadowTilemap + 9 * TILEMAP_WIDTH ; $4a60
	ld b, $20 ; $4a63
	ld c, $02 ; $4a65
	farcall CopyTilemapRect ; $4a67
	ld a, $06 ; $4a6a
	ld [wAnimatedTilePeriod], a ; $4a6c
.done:
	ret ; $4a6f
StubNop_16:
	ret ; $4a70
Unused_16_BuildMatchResultTilemap:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $4a71
	add a ; $4a74
	ld hl, MatchResultTilemapScripts_16 ; $4a75
	add l ; $4a78
	ld l, a ; $4a79
	jr nc, .read ; $4a7a
	inc h ; $4a7c
.read:
	ld a, [hl+] ; $4a7d
	ld h, [hl] ; $4a7e
	ld l, a ; $4a7f
.loop:
	ld a, [hl+] ; $4a80
	ld d, [hl] ; $4a81
	ld e, a ; $4a82
	ld a, d ; $4a83
	or e ; $4a84
	jr z, .checkCurrentMinigameStoryMatch ; $4a85
	inc hl ; $4a87
	ld a, [hl+] ; $4a88
	ld b, [hl] ; $4a89
	ld c, a ; $4a8a
	inc hl ; $4a8b
	ld a, [hl+] ; $4a8c
	push hl ; $4a8d
	ld h, b ; $4a8e
	ld l, c ; $4a8f
	ld b, a ; $4a90
	ld c, $02 ; $4a91
	farcall CopyTilemapRect ; $4a93
	pop hl ; $4a96
	jr .loop ; $4a97
.checkCurrentMinigameStoryMatch:
	ld a, [wCurrentMinigameStoryMatch] ; $4a99
	cp MATCHLIST_DOUBLES ; $4a9c
	jr nz, .ne01 ; $4a9e
	ld hl, $d3c7 ; $4aa0
	ld de, $d200 ; $4aa3
	ld b, $06 ; $4aa6
	ld c, $02 ; $4aa8
	farcall CopyTilemapRect ; $4aaa
	jr .done ; $4aad
.ne01:
	ld hl, $d3c0 ; $4aaf
	ld de, $d200 ; $4ab2
	ld b, $07 ; $4ab5
	ld c, $02 ; $4ab7
	farcall CopyTilemapRect ; $4ab9
.done:
	ret ; $4abc
MatchResultTilemapScripts_16:
	; $4abd, 480 bytes (tilemap_scripts)
	dw .script0 ; 0
	dw .script1 ; 1
	dw .script2 ; 2
	dw .script3 ; 3
	dw .script4 ; 4
	dw .script5 ; 5
	dw .script6 ; 6
	dw .script7 ; 7
	dw .script8 ; 8
	dw .script9 ; 9
	dw .script10 ; 10
	dw .script11 ; 11
	dw .script12 ; 12
	dw .script13 ; 13
	dw .script14 ; 14
	dw .script15 ; 15
	dw .script16 ; 16
	dw .script17 ; 17
	dw .script18 ; 18
	dw .script19 ; 19
.script0:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2ca, 9
	tilemap_copy $d20a, $d3cd, 9
	tilemap_copy_end
.script1:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2ca, 9
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d393, 4
	tilemap_copy_end
.script2:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2ca, 9
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38f, 4
	tilemap_copy_end
.script3:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2ca, 9
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38b, 4
	tilemap_copy_end
.script4:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2ca, 9
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d388, 3
	tilemap_copy_end
.script5:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2d3, 8
	tilemap_copy $d20a, $d3cd, 9
	tilemap_copy_end
.script6:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2d3, 8
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d393, 4
	tilemap_copy_end
.script7:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2d3, 8
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38f, 4
	tilemap_copy_end
.script8:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2d3, 8
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38b, 4
	tilemap_copy_end
.script9:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2d3, 8
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d388, 3
	tilemap_copy_end
.script10:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00a, $d300, 10
	tilemap_copy $d20a, $d3cd, 9
	tilemap_copy_end
.script11:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00a, $d300, 10
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d393, 4
	tilemap_copy_end
.script12:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00a, $d300, 10
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38f, 4
	tilemap_copy_end
.script13:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00a, $d300, 10
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38b, 4
	tilemap_copy_end
.script14:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00a, $d300, 10
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d388, 3
	tilemap_copy_end
.script15:
	tilemap_copy $d000, $d280, 20
	tilemap_copy $d20a, $d3cd, 9
	tilemap_copy_end
.script16:
	tilemap_copy $d000, $d280, 20
	tilemap_copy $d20a, $d340, 7
	tilemap_copy_end
.script17:
	tilemap_copy $d000, $d280, 20
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d20a, $d347, 8
	tilemap_copy_end
.script18:
	tilemap_copy $d000, $d280, 20
	tilemap_copy $d209, $d34f, 10
	tilemap_copy_end
.script19:
	tilemap_copy $d000, $d280, 20
	tilemap_copy $d20c, $d359, 7
	tilemap_copy_end
AdvanceResultScreenTimer:
	ld a, [wMatchWinLoseFlag] ; $4c9d
	cp WINLOSE_LOSE ; $4ca0
	jr nz, .neff ; $4ca2
	ldh a, [hVBlankCounter] ; $4ca4
	and $01 ; $4ca6
	ret z ; $4ca8
.neff:
	ld a, [wRasterScrollX] ; $4ca9
	inc a ; $4cac
	ld [wRasterScrollX], a ; $4cad
	ret ; $4cb0
QueueResultScreenSprites:
	ld a, [wMatchWinLoseFlag] ; $4cb1
	cp WINLOSE_LOSE ; $4cb4
	jr z, .eqff ; $4cb6
	ld de, $0824 ; $4cb8
	call QueueResultPortraitTop ; $4cbb
	ld de, $502c ; $4cbe
	call QueueWinnerMarkerForPlayer ; $4cc1
	ld de, $5060 ; $4cc4
	call QueueResultPortraitBottom ; $4cc7
	ld de, $4e68 ; $4cca
	call QueueLoserMarkerForOpponent ; $4ccd
	ret ; $4cd0
.eqff:
	ld de, $5860 ; $4cd1
	call QueueResultPortraitTop ; $4cd4
	ld de, $5068 ; $4cd7
	call QueueLoserMarkerForPlayer ; $4cda
	ld de, $0024 ; $4cdd
	call QueueResultPortraitBottom ; $4ce0
	ld de, $482c ; $4ce3
	call QueueWinnerMarkerForOpponent ; $4ce6
	ret ; $4ce9
QueueResultPortraitTop:
	call GetResultSpriteWobbleOffset ; $4cea
	ld b, a ; $4ced
	ld a, d ; $4cee
	sub b ; $4cef
	ld d, a ; $4cf0
	ld c, $00 ; $4cf1
	ld b, $08 ; $4cf3
	ldh a, [hVBlankCounter] ; $4cf5
	and $10 ; $4cf7
	jr z, .maskClear ; $4cf9
	ld b, $0a ; $4cfb
.maskClear:
	ld hl, ResultSpriteTemplateLeft_16 ; $4cfd
	call QueueSpriteTemplate ; $4d00
	ret ; $4d03
ResultSpriteTemplateLeft_16:
	; $4d04, 65 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite $10, $28, $10, $00
	oam_sprite $20, $28, $12, $00
	oam_sprite $10, $30, $14, $00
	oam_sprite $20, $30, $16, $00
	oam_sprite $10, $38, $18, $00
	oam_sprite $20, $38, $1a, $00
	oam_sprite $10, $40, $1c, $00
	oam_sprite $20, $40, $1e, $00
	oam_sprite_end
QueueResultPortraitBottom:
	call GetResultSpriteWobbleOffset ; $4d45
	add d ; $4d48
	ld d, a ; $4d49
	ld c, $20 ; $4d4a
	ld b, $09 ; $4d4c
	ld hl, ResultSpriteTemplateRight_16 ; $4d4e
	call QueueSpriteTemplate ; $4d51
	ret ; $4d54
ResultSpriteTemplateRight_16:
	; $4d55, 65 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite $10, $28, $10, $00
	oam_sprite $20, $28, $12, $00
	oam_sprite $10, $30, $14, $00
	oam_sprite $20, $30, $16, $00
	oam_sprite $10, $38, $18, $00
	oam_sprite $20, $38, $1a, $00
	oam_sprite $10, $40, $1c, $00
	oam_sprite $20, $40, $1e, $00
	oam_sprite_end
QueueWinnerMarkerForPlayer:
	call GetResultSpriteWobbleOffset ; $4d96
	ld b, a ; $4d99
	ld a, d ; $4d9a
	sub b ; $4d9b
	ld d, a ; $4d9c
	ld c, $40 ; $4d9d
	ld b, $08 ; $4d9f
	ldh a, [hVBlankCounter] ; $4da1
	and $10 ; $4da3
	jr z, .queueSprite ; $4da5
	ld b, $0a ; $4da7
.queueSprite:
	call QueueSprite ; $4da9
	ret ; $4dac
QueueLoserMarkerForOpponent:
	call GetResultSpriteWobbleOffset ; $4dad
	add d ; $4db0
	ld d, a ; $4db1
	ld c, $42 ; $4db2
	ld b, $09 ; $4db4
	call QueueSprite ; $4db6
	ret ; $4db9
QueueWinnerMarkerForOpponent:
	call GetResultSpriteWobbleOffset ; $4dba
	add d ; $4dbd
	ld d, a ; $4dbe
	ld c, $40 ; $4dbf
	ld b, $09 ; $4dc1
	call QueueSprite ; $4dc3
	ret ; $4dc6
QueueLoserMarkerForPlayer:
	call GetResultSpriteWobbleOffset ; $4dc7
	ld b, a ; $4dca
	ld a, d ; $4dcb
	sub b ; $4dcc
	ld d, a ; $4dcd
	ld c, $42 ; $4dce
	ld b, $08 ; $4dd0
	ldh a, [hVBlankCounter] ; $4dd2
	and $10 ; $4dd4
	jr z, .queueSprite ; $4dd6
	ld b, $0a ; $4dd8
.queueSprite:
	call QueueSprite ; $4dda
	ret ; $4ddd
GetResultSpriteWobbleOffset:
	ldh a, [hVBlankCounter] ; $4dde
	srl a ; $4de0
	and $0f ; $4de2
	ld hl, ResultSpriteWobbleOffsetTable ; $4de4
	add l ; $4de7
	ld l, a ; $4de8
	jr nc, .read ; $4de9
	inc h ; $4deb
.read:
	ld a, [hl] ; $4dec
	ret ; $4ded
ResultSpriteWobbleOffsetTable:
	; $4dee, 16 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $05, $06, $06, $06, $05, $04, $03, $02, $01, $00, $00 ; 0x00
LoadResultScreenTileGraphics:
	ld de, wShadowAttrmap ; $4dfe
	ld b, $14 ; $4e01
	ld c, $02 ; $4e03
	ld h, $0b ; $4e05
	farcall FillTilemapRect ; $4e07
	ld de, wShadowAttrmap + 16 * TILEMAP_WIDTH ; $4e0a
	ld b, $14 ; $4e0d
	ld c, $02 ; $4e0f
	ld h, $0b ; $4e11
	farcall FillTilemapRect ; $4e13
	ld de, FLAG_DOUBLES ; $4e16
	call TestGameFlagByNumber ; $4e19
	jr nz, .decompressData ; $4e1c
	ld hl, MatchResultTitleGfx ; $4e1e
	ld de, $9000 ; $4e21
	call DecompressData ; $4e24
	jr .loadMatchResultGfxSet ; $4e27
.decompressData:
	ld hl, MatchResultTitleGfxAlt ; $4e29
	ld de, $9000 ; $4e2c
	call DecompressData ; $4e2f
.loadMatchResultGfxSet:
	ld a, [wResultScreenWon] ; $4e32
	or a ; $4e35
	jr z, LoadMatchResultGfxSet ; $4e36
	ld hl, MatchResultGfxA2 ; $4e38
	ld de, $8900 ; $4e3b
	call DecompressData ; $4e3e
	ld hl, MatchResultGfxB4 ; $4e41
	ld de, $8a40 ; $4e44
	call DecompressData ; $4e47
	ld hl, MatchResultGfxC9 ; $4e4a
	ld de, $9140 ; $4e4d
	call DecompressData ; $4e50
	ret ; $4e53
LoadMatchResultGfxSet:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $4e54
	call RemapDoublesMatchGfxIndex ; $4e57
	add a ; $4e5a
	ld hl, GfxSetPointerTable_16 ; $4e5b
	add l ; $4e5e
	ld l, a ; $4e5f
	jr nc, .read ; $4e60
	inc h ; $4e62
.read:
	ld a, [hl+] ; $4e63
	ld h, [hl] ; $4e64
	ld l, a ; $4e65
	push hl ; $4e66
	ld a, [hl+] ; $4e67
	ld h, [hl] ; $4e68
	ld l, a ; $4e69
	ld de, $8900 ; $4e6a
	call DecompressData ; $4e6d
	pop hl ; $4e70
	inc hl ; $4e71
	inc hl ; $4e72
	push hl ; $4e73
	ld a, [hl+] ; $4e74
	ld h, [hl] ; $4e75
	ld l, a ; $4e76
	ld de, $8a40 ; $4e77
	call DecompressData ; $4e7a
	pop hl ; $4e7d
	inc hl ; $4e7e
	inc hl ; $4e7f
	ld a, [hl+] ; $4e80
	ld h, [hl] ; $4e81
	ld l, a ; $4e82
	ld de, $9140 ; $4e83
	call DecompressData ; $4e86
	ret ; $4e89
RemapDoublesMatchGfxIndex:
	push af ; $4e8a
	ld de, FLAG_DOUBLES ; $4e8b
	call TestGameFlagByNumber ; $4e8e
	jr z, .restore ; $4e91
	cp $11 ; $4e93
	jr nz, .restore ; $4e95
	ld a, $10 ; $4e97
	pop hl ; $4e99
	ret ; $4e9a
.restore:
	pop af ; $4e9b
	ret ; $4e9c
GfxSetPointerTable_16:
	; $4e9d, 176 bytes (gfx_ptr_table)
	dw .rec0 ; 0
	dw .rec1 ; 1
	dw .rec2 ; 2
	dw .rec3 ; 3
	dw .rec4 ; 4
	dw .rec5 ; 5
	dw .rec6 ; 6
	dw .rec7 ; 7
	dw .rec8 ; 8
	dw .rec9 ; 9
	dw .rec10 ; 10
	dw .rec11 ; 11
	dw .rec12 ; 12
	dw .rec13 ; 13
	dw .rec14 ; 14
	dw .rec15 ; 15
	dw .rec16 ; 16
	dw .rec17 ; 17
	dw .rec18 ; 18
	dw .rec19 ; 19
	dw .rec20 ; 20
	dw .rec20 ; 21
	dw .rec20 ; 22
	dw .rec20 ; 23
	dw .rec20 ; 24
.rec0:
	gfx_set MatchResultGfxA1, MatchResultGfxB3, MatchResultGfxC8
.rec1:
	gfx_set MatchResultGfxA1, MatchResultGfxB3, MatchResultGfxC7
.rec2:
	gfx_set MatchResultGfxA1, MatchResultGfxB3, MatchResultGfxC6
.rec3:
	gfx_set MatchResultGfxA1, MatchResultGfxB3, MatchResultGfxC5
.rec4:
	gfx_set MatchResultGfxA1, MatchResultGfxB3, MatchResultGfxC4
.rec5:
	gfx_set MatchResultGfxA1, MatchResultGfxB2, MatchResultGfxC8
.rec6:
	gfx_set MatchResultGfxA1, MatchResultGfxB2, MatchResultGfxC7
.rec7:
	gfx_set MatchResultGfxA1, MatchResultGfxB2, MatchResultGfxC6
.rec8:
	gfx_set MatchResultGfxA1, MatchResultGfxB2, MatchResultGfxC5
.rec9:
	gfx_set MatchResultGfxA1, MatchResultGfxB2, MatchResultGfxC4
.rec10:
	gfx_set MatchResultGfxA1, MatchResultGfxB1, MatchResultGfxC8
.rec11:
	gfx_set MatchResultGfxA1, MatchResultGfxB1, MatchResultGfxC7
.rec12:
	gfx_set MatchResultGfxA1, MatchResultGfxB1, MatchResultGfxC6
.rec13:
	gfx_set MatchResultGfxA1, MatchResultGfxB1, MatchResultGfxC5
.rec14:
	gfx_set MatchResultGfxA1, MatchResultGfxB1, MatchResultGfxC4
.rec15:
	gfx_set MatchResultGfxA0, MatchResultGfxB0, MatchResultGfxC8
.rec16:
	gfx_set MatchResultGfxA0, MatchResultGfxB0, MatchResultGfxC2
.rec17:
	gfx_set MatchResultGfxA0, MatchResultGfxB0, MatchResultGfxC3
.rec18:
	gfx_set MatchResultGfxA0, MatchResultGfxB0, MatchResultGfxC1
.rec19:
	gfx_set MatchResultGfxA0, MatchResultGfxB0, MatchResultGfxC0
.rec20:
	gfx_set MatchResultGfxA2, MatchResultGfxB4, MatchResultGfxC9
MatchResultGfxA0:
	INCBIN "data/bank_016/lz_MatchResultGfxA0.bin" ; $4f4d, 199 bytes
MatchResultGfxB0:
	INCBIN "data/bank_016/lz_MatchResultGfxB0.bin" ; $5014, 127 bytes
MatchResultGfxA1:
	INCBIN "data/bank_016/lz_MatchResultGfxA1.bin" ; $5093, 205 bytes
MatchResultGfxB1:
	INCBIN "data/bank_016/lz_MatchResultGfxB1.bin" ; $5160, 178 bytes
MatchResultGfxB2:
	INCBIN "data/bank_016/lz_MatchResultGfxB2.bin" ; $5212, 171 bytes
MatchResultGfxB3:
	INCBIN "data/bank_016/lz_MatchResultGfxB3.bin" ; $52bd, 154 bytes
MatchResultGfxA2:
	INCBIN "data/bank_016/lz_MatchResultGfxA2.bin" ; $5357, 106 bytes
MatchResultGfxB4:
	INCBIN "data/bank_016/lz_MatchResultGfxB4.bin" ; $53c1, 109 bytes
MatchResultTitleGfx:
	INCBIN "data/bank_016/lz_MatchResultTitleGfx.bin" ; $542e, 143 bytes
MatchResultTitleGfxAlt:
	INCBIN "data/bank_016/lz_MatchResultTitleGfxAlt.bin" ; $54bd, 132 bytes
MatchResultGfxC0:
	INCBIN "data/bank_016/lz_MatchResultGfxC0.bin" ; $5541, 93 bytes
MatchResultGfxC1:
	INCBIN "data/bank_016/lz_MatchResultGfxC1.bin" ; $559e, 164 bytes
MatchResultGfxC2:
	INCBIN "data/bank_016/lz_MatchResultGfxC2.bin" ; $5642, 176 bytes
MatchResultGfxC3:
	INCBIN "data/bank_016/lz_MatchResultGfxC3.bin" ; $56f2, 186 bytes
MatchResultGfxC4:
	INCBIN "data/bank_016/lz_MatchResultGfxC4.bin" ; $57ac, 161 bytes
MatchResultGfxC5:
	INCBIN "data/bank_016/lz_MatchResultGfxC5.bin" ; $584d, 173 bytes
MatchResultGfxC6:
	INCBIN "data/bank_016/lz_MatchResultGfxC6.bin" ; $58fa, 172 bytes
MatchResultGfxC7:
	INCBIN "data/bank_016/lz_MatchResultGfxC7.bin" ; $59a6, 169 bytes
MatchResultGfxC8:
	INCBIN "data/bank_016/lz_MatchResultGfxC8.bin" ; $5a4f, 192 bytes
MatchResultGfxCUnused:
	INCBIN "data/bank_016/lz_MatchResultGfxCUnused.bin" ; $5b0f, 230 bytes
MatchResultGfxC9:
	INCBIN "data/bank_016/lz_MatchResultGfxC9.bin" ; $5bf5, 28 bytes
ApplyLinkRoleToWinLoseFlag:
	ld a, [wGameMode] ; $5c11
	cp GAMEMODE_LINK_MATCH ; $5c14
	ret nz ; $5c16
	ld a, [wLinkMatchRole] ; $5c17
	cp $01 ; $5c1a
	jr nz, .compare ; $5c1c
	ret ; $5c1e
.compare:
	cp $02 ; $5c1f
	jr nz, .done ; $5c21
	ld a, [wMatchWinLoseFlag] ; $5c23
	cp WINLOSE_LOSE ; $5c26
	jr z, .eqff ; $5c28
	ld a, WINLOSE_LOSE ; $5c2a
	jr .store ; $5c2c
.eqff:
	ld a, WINLOSE_WIN ; $5c2e
.store:
	ld [wMatchWinLoseFlag], a ; $5c30
	ret ; $5c33
.done:
	ret ; $5c34
RunMatchStatsScreen:
	call DisableLCDSafely ; $5c35
	farcall LoadMenuFontGfx ; $5c38
	wram_bank $03 ; $5c3b
	ld a, $01 ; $5c41
	ld [wResultScreenMode], a ; $5c43
	call InitMatchStatsScreen ; $5c46
	call LoadMatchResultPalettes ; $5c49
	ld a, $01 ; $5c4c
	ld hl, UpdateResultScreenAnimatedTilesTask ; $5c4e
	call RegisterFrameTask ; $5c51
	call EnableLCD ; $5c54
	script_fade_in $10 ; $5c57
	call WaitFadeEnd ; $5c5c
.loop:
	call PrintMatchSetScores ; $5c5f
	ldh a, [hInputPressed] ; $5c62
	bit PADB_LEFT, a ; $5c64
	jr nz, .beginFadeOut ; $5c66
	bit 0, a ; $5c68
	jr nz, .beginFadeOut2 ; $5c6a
	bit 1, a ; $5c6c
	jr nz, .beginFadeOut2 ; $5c6e
	call AdvanceFrame ; $5c70
	jr .loop ; $5c73
.beginFadeOut:
	ld c, $40 ; $5c75
	call BeginFadeOut ; $5c77
	call WaitFadeEnd ; $5c7a
	xor a ; $5c7d
	ret ; $5c7e
.beginFadeOut2:
	ld c, $20 ; $5c7f
	call BeginFadeOut ; $5c81
	call WaitFadeEnd ; $5c84
	ld a, $ff ; $5c87
	ret ; $5c89
InitMatchStatsScreen:
	ld c, $23 ; $5c8a
	farcall LoadScreenAssetRecord ; $5c8c
	ld de, $8000 + VRAM_BANK1 ; $5c8f
	ld c, $00 ; $5c92
	ld b, $08 ; $5c94
	farcall InitNumberSpriteGfx ; $5c96
	ld a, $00 ; $5c99
	ld d, $04 ; $5c9b
	farcall LoadIndexedPalette_18 ; $5c9d
	ld a, $00 ; $5ca0
	ld d, $05 ; $5ca2
	farcall LoadIndexedPalette_18 ; $5ca4
	ld a, $00 ; $5ca7
	ld d, $06 ; $5ca9
	farcall LoadIndexedPalette_18 ; $5cab
	ld a, $00 ; $5cae
	ld d, $07 ; $5cb0
	farcall LoadIndexedPalette_18 ; $5cb2
	wram_bank $03 ; $5cb5
	call CopyMatchStatsHeaderRects ; $5cbb
	call LoadResultScreenTileGraphics ; $5cbe
	ld de, wShadowAttrmap + 16 * TILEMAP_WIDTH ; $5cc1
	ld b, $14 ; $5cc4
	ld c, $02 ; $5cc6
	ld h, $08 ; $5cc8
	farcall FillTilemapRect ; $5cca
	call SetMatchStatsPortraitPaletteAttrs ; $5ccd
	ld c, $01 ; $5cd0
	call LoadResultScreenPortraits ; $5cd2
	call PrintMatchStatistics ; $5cd5
	farcall QueueWram3MapToVRAM ; $5cd8
	ret ; $5cdb
SetMatchStatsPortraitPaletteAttrs:
	ld de, FLAG_DOUBLES ; $5cdc
	call TestGameFlagByNumber ; $5cdf
	jr z, .fillTilemapRect ; $5ce2
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 1 ; $5ce4
	ld b, $03 ; $5ce7
	ld c, $03 ; $5ce9
	ld h, $0c ; $5ceb
	farcall FillTilemapRect ; $5ced
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 4 ; $5cf0
	ld b, $03 ; $5cf3
	ld c, $03 ; $5cf5
	ld h, $0d ; $5cf7
	farcall FillTilemapRect ; $5cf9
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 13 ; $5cfc
	ld b, $03 ; $5cff
	ld c, $03 ; $5d01
	ld h, $0e ; $5d03
	farcall FillTilemapRect ; $5d05
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 16 ; $5d08
	ld b, $03 ; $5d0b
	ld c, $03 ; $5d0d
	ld h, $0f ; $5d0f
	farcall FillTilemapRect ; $5d11
	jr .done ; $5d14
.fillTilemapRect:
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 2 ; $5d16
	ld b, $03 ; $5d19
	ld c, $03 ; $5d1b
	ld h, $0c ; $5d1d
	farcall FillTilemapRect ; $5d1f
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 14 ; $5d22
	ld b, $03 ; $5d25
	ld c, $03 ; $5d27
	ld h, $0e ; $5d29
	farcall FillTilemapRect ; $5d2b
.done:
	ret ; $5d2e
PrintMatchStatistics:
	call ClearMatchStatsNumberArea ; $5d2f
	ld de, FLAG_DOUBLES ; $5d32
	call TestGameFlagByNumber ; $5d35
	jr z, .printSinglesMatchStats ; $5d38
	call PrintDoublesMatchStats ; $5d3a
	jr .done ; $5d3d
.printSinglesMatchStats:
	call PrintSinglesMatchStats ; $5d3f
.done:
	ret ; $5d42
PrintSinglesMatchStats:
	ld a, [wCharacter1ServiceAces] ; $5d43
	ld h, $00 ; $5d46
	ld l, a ; $5d48
	ld bc, wStatsPrintBuffer ; $5d49
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 3 ; $5d4c
	farcall PrintNumberRightAligned ; $5d4f
	ld a, [wCharacter1SmashAces] ; $5d52
	ld h, $00 ; $5d55
	ld l, a ; $5d57
	ld bc, wStatsPrintBuffer ; $5d58
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 3 ; $5d5b
	farcall PrintNumberRightAligned ; $5d5e
	ld a, [wCharacter1ReturnAces] ; $5d61
	ld h, $00 ; $5d64
	ld l, a ; $5d66
	ld bc, wStatsPrintBuffer ; $5d67
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 3 ; $5d6a
	farcall PrintNumberRightAligned ; $5d6d
	ld a, [wCharacter1LobShotWinners] ; $5d70
	ld h, $00 ; $5d73
	ld l, a ; $5d75
	ld bc, wStatsPrintBuffer ; $5d76
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 3 ; $5d79
	farcall PrintNumberRightAligned ; $5d7c
	ld a, [wCharacter1DropShotWinners] ; $5d7f
	ld h, $00 ; $5d82
	ld l, a ; $5d84
	ld bc, wStatsPrintBuffer ; $5d85
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 3 ; $5d88
	farcall PrintNumberRightAligned ; $5d8b
	ld a, [wCharacter1DoubleFaults] ; $5d8e
	ld h, $00 ; $5d91
	ld l, a ; $5d93
	ld bc, wStatsPrintBuffer ; $5d94
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 3 ; $5d97
	farcall PrintNumberRightAligned ; $5d9a
	ld a, [wCharacter2ServiceAces] ; $5d9d
	ld h, $00 ; $5da0
	ld l, a ; $5da2
	ld bc, wStatsPrintBuffer ; $5da3
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 16 ; $5da6
	farcall PrintNumberRightAligned ; $5da9
	ld a, [wCharacter2SmashAces] ; $5dac
	ld h, $00 ; $5daf
	ld l, a ; $5db1
	ld bc, wStatsPrintBuffer ; $5db2
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 16 ; $5db5
	farcall PrintNumberRightAligned ; $5db8
	ld a, [wCharacter2ReturnAces] ; $5dbb
	ld h, $00 ; $5dbe
	ld l, a ; $5dc0
	ld bc, wStatsPrintBuffer ; $5dc1
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 16 ; $5dc4
	farcall PrintNumberRightAligned ; $5dc7
	ld a, [wCharacter2LobShotWinners] ; $5dca
	ld h, $00 ; $5dcd
	ld l, a ; $5dcf
	ld bc, wStatsPrintBuffer ; $5dd0
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 16 ; $5dd3
	farcall PrintNumberRightAligned ; $5dd6
	ld a, [wCharacter2DropShotWinners] ; $5dd9
	ld h, $00 ; $5ddc
	ld l, a ; $5dde
	ld bc, wStatsPrintBuffer ; $5ddf
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 16 ; $5de2
	farcall PrintNumberRightAligned ; $5de5
	ld a, [wCharacter2DoubleFaults] ; $5de8
	ld h, $00 ; $5deb
	ld l, a ; $5ded
	ld bc, wStatsPrintBuffer ; $5dee
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 16 ; $5df1
	farcall PrintNumberRightAligned ; $5df4
	ret ; $5df7
PrintDoublesMatchStats:
	ld a, [wCharacter1ServiceAces] ; $5df8
	ld h, $00 ; $5dfb
	ld l, a ; $5dfd
	ld bc, wStatsPrintBuffer ; $5dfe
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 2 ; $5e01
	farcall PrintNumberRightAligned ; $5e04
	ld a, [wCharacter1SmashAces] ; $5e07
	ld h, $00 ; $5e0a
	ld l, a ; $5e0c
	ld bc, wStatsPrintBuffer ; $5e0d
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 2 ; $5e10
	farcall PrintNumberRightAligned ; $5e13
	ld a, [wCharacter1ReturnAces] ; $5e16
	ld h, $00 ; $5e19
	ld l, a ; $5e1b
	ld bc, wStatsPrintBuffer ; $5e1c
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 2 ; $5e1f
	farcall PrintNumberRightAligned ; $5e22
	ld a, [wCharacter1LobShotWinners] ; $5e25
	ld h, $00 ; $5e28
	ld l, a ; $5e2a
	ld bc, wStatsPrintBuffer ; $5e2b
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 2 ; $5e2e
	farcall PrintNumberRightAligned ; $5e31
	ld a, [wCharacter1DropShotWinners] ; $5e34
	ld h, $00 ; $5e37
	ld l, a ; $5e39
	ld bc, wStatsPrintBuffer ; $5e3a
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 2 ; $5e3d
	farcall PrintNumberRightAligned ; $5e40
	ld a, [wCharacter1DoubleFaults] ; $5e43
	ld h, $00 ; $5e46
	ld l, a ; $5e48
	ld bc, wStatsPrintBuffer ; $5e49
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 2 ; $5e4c
	farcall PrintNumberRightAligned ; $5e4f
	ld a, [wCharacter3ServiceAces] ; $5e52
	ld h, $00 ; $5e55
	ld l, a ; $5e57
	ld bc, wStatsPrintBuffer ; $5e58
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 5 ; $5e5b
	farcall PrintNumberRightAligned ; $5e5e
	ld a, [wCharacter3SmashAces] ; $5e61
	ld h, $00 ; $5e64
	ld l, a ; $5e66
	ld bc, wStatsPrintBuffer ; $5e67
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 5 ; $5e6a
	farcall PrintNumberRightAligned ; $5e6d
	ld a, [wCharacter3ReturnAces] ; $5e70
	ld h, $00 ; $5e73
	ld l, a ; $5e75
	ld bc, wStatsPrintBuffer ; $5e76
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 5 ; $5e79
	farcall PrintNumberRightAligned ; $5e7c
	ld a, [wCharacter3LobShotWinners] ; $5e7f
	ld h, $00 ; $5e82
	ld l, a ; $5e84
	ld bc, wStatsPrintBuffer ; $5e85
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 5 ; $5e88
	farcall PrintNumberRightAligned ; $5e8b
	ld a, [wCharacter3DropShotWinners] ; $5e8e
	ld h, $00 ; $5e91
	ld l, a ; $5e93
	ld bc, wStatsPrintBuffer ; $5e94
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 5 ; $5e97
	farcall PrintNumberRightAligned ; $5e9a
	ld a, [wCharacter3DoubleFaults] ; $5e9d
	ld h, $00 ; $5ea0
	ld l, a ; $5ea2
	ld bc, wStatsPrintBuffer ; $5ea3
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 5 ; $5ea6
	farcall PrintNumberRightAligned ; $5ea9
	ld a, [wCharacter2ServiceAces] ; $5eac
	ld h, $00 ; $5eaf
	ld l, a ; $5eb1
	ld bc, wStatsPrintBuffer ; $5eb2
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 15 ; $5eb5
	farcall PrintNumberRightAligned ; $5eb8
	ld a, [wCharacter2SmashAces] ; $5ebb
	ld h, $00 ; $5ebe
	ld l, a ; $5ec0
	ld bc, wStatsPrintBuffer ; $5ec1
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 15 ; $5ec4
	farcall PrintNumberRightAligned ; $5ec7
	ld a, [wCharacter2ReturnAces] ; $5eca
	ld h, $00 ; $5ecd
	ld l, a ; $5ecf
	ld bc, wStatsPrintBuffer ; $5ed0
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 15 ; $5ed3
	farcall PrintNumberRightAligned ; $5ed6
	ld a, [wCharacter2LobShotWinners] ; $5ed9
	ld h, $00 ; $5edc
	ld l, a ; $5ede
	ld bc, wStatsPrintBuffer ; $5edf
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 15 ; $5ee2
	farcall PrintNumberRightAligned ; $5ee5
	ld a, [wCharacter2DropShotWinners] ; $5ee8
	ld h, $00 ; $5eeb
	ld l, a ; $5eed
	ld bc, wStatsPrintBuffer ; $5eee
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 15 ; $5ef1
	farcall PrintNumberRightAligned ; $5ef4
	ld a, [wCharacter2DoubleFaults] ; $5ef7
	ld h, $00 ; $5efa
	ld l, a ; $5efc
	ld bc, wStatsPrintBuffer ; $5efd
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 15 ; $5f00
	farcall PrintNumberRightAligned ; $5f03
	ld a, [wCharacter4ServiceAces] ; $5f06
	ld h, $00 ; $5f09
	ld l, a ; $5f0b
	ld bc, wStatsPrintBuffer ; $5f0c
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 18 ; $5f0f
	farcall PrintNumberRightAligned ; $5f12
	ld a, [wCharacter4SmashAces] ; $5f15
	ld h, $00 ; $5f18
	ld l, a ; $5f1a
	ld bc, wStatsPrintBuffer ; $5f1b
	ld de, wShadowTilemap + 12 * TILEMAP_WIDTH + 18 ; $5f1e
	farcall PrintNumberRightAligned ; $5f21
	ld a, [wCharacter4ReturnAces] ; $5f24
	ld h, $00 ; $5f27
	ld l, a ; $5f29
	ld bc, wStatsPrintBuffer ; $5f2a
	ld de, wShadowTilemap + 13 * TILEMAP_WIDTH + 18 ; $5f2d
	farcall PrintNumberRightAligned ; $5f30
	ld a, [wPlayer4LobShotWinners] ; $5f33
	ld h, $00 ; $5f36
	ld l, a ; $5f38
	ld bc, wStatsPrintBuffer ; $5f39
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH + 18 ; $5f3c
	farcall PrintNumberRightAligned ; $5f3f
	ld a, [wCharacter4DropShotWinners] ; $5f42
	ld h, $00 ; $5f45
	ld l, a ; $5f47
	ld bc, wStatsPrintBuffer ; $5f48
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH + 18 ; $5f4b
	farcall PrintNumberRightAligned ; $5f4e
	ld a, [wCharacter4DoubleFaults] ; $5f51
	ld h, $00 ; $5f54
	ld l, a ; $5f56
	ld bc, wStatsPrintBuffer ; $5f57
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 18 ; $5f5a
	farcall PrintNumberRightAligned ; $5f5d
	ret ; $5f60
ClearMatchStatsNumberArea:
	ld de, wShadowAttrmap + 11 * TILEMAP_WIDTH + 1 ; $5f61
	ld b, $05 ; $5f64
	ld c, $06 ; $5f66
	ld h, $00 ; $5f68
	farcall FillTilemapRect ; $5f6a
	ld de, wShadowAttrmap + 11 * TILEMAP_WIDTH + 14 ; $5f6d
	ld b, $05 ; $5f70
	ld c, $06 ; $5f72
	ld h, $00 ; $5f74
	farcall FillTilemapRect ; $5f76
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 1 ; $5f79
	ld b, $05 ; $5f7c
	ld c, $06 ; $5f7e
	ld h, $20 ; $5f80
	farcall FillTilemapRect ; $5f82
	ld de, wShadowTilemap + 11 * TILEMAP_WIDTH + 14 ; $5f85
	ld b, $05 ; $5f88
	ld c, $06 ; $5f8a
	ld h, $20 ; $5f8c
	farcall FillTilemapRect ; $5f8e
	ret ; $5f91
CopyMatchStatsHeaderRects:
	ld de, FLAG_DOUBLES ; $5f92
	call TestGameFlagByNumber ; $5f95
	ret nz ; $5f98
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH ; $5f99
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH ; $5f9c
	ld b, $08 ; $5f9f
	ld c, $04 ; $5fa1
	farcall CopyTilemapRect ; $5fa3
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH + 12 ; $5fa6
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH + 12 ; $5fa9
	ld b, $08 ; $5fac
	ld c, $04 ; $5fae
	farcall CopyTilemapRect ; $5fb0
	ld hl, wShadowAttrmap + 18 * TILEMAP_WIDTH ; $5fb3
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH ; $5fb6
	ld b, $08 ; $5fb9
	ld c, $04 ; $5fbb
	farcall CopyTilemapRect ; $5fbd
	ld hl, wShadowAttrmap + 18 * TILEMAP_WIDTH + 12 ; $5fc0
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 12 ; $5fc3
	ld b, $08 ; $5fc6
	ld c, $04 ; $5fc8
	farcall CopyTilemapRect ; $5fca
	ret ; $5fcd
PrintMatchSetScores:
	ld a, [wPlayer1SetsWon] ; $5fce
	ld h, $00 ; $5fd1
	ld l, a ; $5fd3
	ld de, $1c48 ; $5fd4
	farcall DrawDecimalNumberSprites_39 ; $5fd7
	ld a, [wPlayer2SetsWon] ; $5fda
	ld h, $00 ; $5fdd
	ld l, a ; $5fdf
	ld de, $8448 ; $5fe0
	farcall DrawDecimalNumberSprites_39 ; $5fe3
	ret ; $5fe6
LoadResultScreenPortraits:
	ld a, c ; $5fe7
	or a ; $5fe8
	jr nz, .checkPlayer1CurrentMainCharacter ; $5fe9
	ld a, [wGameMode] ; $5feb
	cp GAMEMODE_LINK_MATCH ; $5fee
	jr nz, .checkPlayer1CurrentMainCharacter ; $5ff0
	ld a, [wLinkMatchRole] ; $5ff2
	cp $02 ; $5ff5
	jr z, .checkPlayer1CurrentMainCharacter2 ; $5ff7
.checkPlayer1CurrentMainCharacter:
	ld a, [wPlayer1CurrentMainCharacter] ; $5ff9
	ld d, a ; $5ffc
	ld a, [wPlayer1MainPalette] ; $5ffd
	ld b, a ; $6000
	ld c, $00 ; $6001
	call LoadResultPortraitSlot ; $6003
	ld a, [wPlayer2CurrentMainCharacter] ; $6006
	ld d, a ; $6009
	ld a, [wPlayer2MainPalette] ; $600a
	ld b, a ; $600d
	ld c, $02 ; $600e
	call LoadResultPortraitSlot ; $6010
	ld de, FLAG_DOUBLES ; $6013
	call TestGameFlagByNumber ; $6016
	jr z, .done ; $6019
	ld a, [wPlayer1CurrentPartnerCharacter] ; $601b
	ld d, a ; $601e
	ld a, [wPlayer1PartnerPalette] ; $601f
	ld b, a ; $6022
	ld c, $01 ; $6023
	call LoadResultPortraitSlot ; $6025
	ld a, [wPlayer2CurrentPartnerCharacter] ; $6028
	ld d, a ; $602b
	ld a, [wPlayer2PartnerPalette] ; $602c
	ld b, a ; $602f
	ld c, $03 ; $6030
	call LoadResultPortraitSlot ; $6032
.done:
	ret ; $6035
.checkPlayer1CurrentMainCharacter2:
	ld a, [wPlayer1CurrentMainCharacter] ; $6036
	ld d, a ; $6039
	ld a, [wPlayer1MainPalette] ; $603a
	ld b, a ; $603d
	ld c, $02 ; $603e
	call LoadResultPortraitSlot ; $6040
	ld a, [wPlayer2CurrentMainCharacter] ; $6043
	ld d, a ; $6046
	ld a, [wPlayer2MainPalette] ; $6047
	ld b, a ; $604a
	ld c, $00 ; $604b
	call LoadResultPortraitSlot ; $604d
	ld de, FLAG_DOUBLES ; $6050
	call TestGameFlagByNumber ; $6053
	jr z, .doneB ; $6056
	ld a, [wPlayer1CurrentPartnerCharacter] ; $6058
	ld d, a ; $605b
	ld a, [wPlayer1PartnerPalette] ; $605c
	ld b, a ; $605f
	ld c, $03 ; $6060
	call LoadResultPortraitSlot ; $6062
	ld a, [wPlayer2CurrentPartnerCharacter] ; $6065
	ld d, a ; $6068
	ld a, [wPlayer2PartnerPalette] ; $6069
	ld b, a ; $606c
	ld c, $01 ; $606d
	call LoadResultPortraitSlot ; $606f
.doneB:
	ret ; $6072
LoadResultPortraitSlot:
	push de ; $6073
	push bc ; $6074
	ld a, c ; $6075
	add $04 ; $6076
	ld d, a ; $6078
	ld a, b ; $6079
	farcall LoadIndexedPalette_18 ; $607a
	pop bc ; $607d
	pop de ; $607e
	ld b, d ; $607f
	ld a, c ; $6080
	add a ; $6081
	ld hl, ResultPortraitSlotTable ; $6082
	add l ; $6085
	ld l, a ; $6086
	jr nc, .readDest ; $6087
	inc h ; $6089
.readDest:
	ld a, [hl+] ; $608a
	ld d, [hl] ; $608b
	ld e, a ; $608c
	push de ; $608d
	ld a, c ; $608e
	cp $02 ; $608f
	jr z, .fixedVariant ; $6091
	cp $03 ; $6093
	jr z, .fixedVariant ; $6095
	jr .checkOutcome ; $6097
.fixedVariant:
	ld c, $00 ; $6099
	jr .decompress ; $609b
.checkOutcome:
	ld a, [wResultScreenMode] ; $609d
	or a ; $60a0
	jr z, .winner ; $60a1
	ld c, $00 ; $60a3
	jr .decompress ; $60a5
.winner:
	ld c, $01 ; $60a7
	ld a, [wMatchWinLoseFlag] ; $60a9
	cp WINLOSE_LOSE ; $60ac
	jr nz, .decompress ; $60ae
	ld c, $02 ; $60b0
.decompress:
	pop de ; $60b2
	call DecompressResultPortrait ; $60b3
	ret ; $60b6
ResultPortraitSlotTable:
	; $60b7, 9 bytes (records:2)
	dw $8c00 ; record 0
	dw $8d00 ; record 1
	dw $8e00 ; record 2
	dw $8f00 ; record 3
	db $c9
DecompressResultPortrait:
	ld a, c ; $60c0
	or a ; $60c1
	jr z, .compare ; $60c2
	call DecompressWinLosePortraitVariant ; $60c4
	ret ; $60c7
.compare:
	cp $20 ; $60c8
	jr c, .decompressCharacterPortrait ; $60ca
	ld a, b ; $60cc
	farcall RemapExtendedCharId ; $60cd
	ld b, a ; $60d0
.decompressCharacterPortrait:
	call DecompressCharacterPortrait ; $60d1
	ret ; $60d4
DecompressWinLosePortraitVariant:
	ld a, b ; $60d5
	add a ; $60d6
	and $07 ; $60d7
	ld b, a ; $60d9
	ld a, c ; $60da
	cp $01 ; $60db
	ld a, b ; $60dd
	jr z, .eq01 ; $60de
	inc a ; $60e0
.eq01:
	ld hl, WinLosePortraitVariantTable_16 ; $60e1
	add a ; $60e4
	add l ; $60e5
	ld l, a ; $60e6
	jr nc, .read ; $60e7
	inc h ; $60e9
.read:
	ld a, [hl+] ; $60ea
	ld h, [hl] ; $60eb
	ld l, a ; $60ec
	call DecompressData ; $60ed
	ret ; $60f0
WinLosePortraitVariantTable_16:
	; $60f1, 16 bytes (lz_ptr_table)
	dw WinLosePortrait0 ; 0
	dw WinLosePortrait1 ; 1
	dw WinLosePortrait2 ; 2
	dw WinLosePortrait3 ; 3
	dw WinLosePortrait4 ; 4
	dw WinLosePortrait5 ; 5
	dw WinLosePortrait6 ; 6
	dw WinLosePortrait7 ; 7
WinLosePortrait0:
	INCBIN "data/bank_016/lz_WinLosePortrait0.bin" ; $6101, 275 bytes
WinLosePortrait1:
	INCBIN "data/bank_016/lz_WinLosePortrait1.bin" ; $6214, 257 bytes
WinLosePortrait2:
	INCBIN "data/bank_016/lz_WinLosePortrait2.bin" ; $6315, 269 bytes
WinLosePortrait3:
	INCBIN "data/bank_016/lz_WinLosePortrait3.bin" ; $6422, 276 bytes
WinLosePortrait4:
	INCBIN "data/bank_016/lz_WinLosePortrait4.bin" ; $6536, 254 bytes
WinLosePortrait5:
	INCBIN "data/bank_016/lz_WinLosePortrait5.bin" ; $6634, 243 bytes
WinLosePortrait6:
	INCBIN "data/bank_016/lz_WinLosePortrait6.bin" ; $6727, 291 bytes
WinLosePortrait7:
	INCBIN "data/bank_016/lz_WinLosePortrait7.bin" ; $684a, 267 bytes
DecompressCharacterPortrait:
	ld a, b ; $6955
	and $1f ; $6956
	add a ; $6958
	ld hl, CharacterPortraitTable_16 ; $6959
	add l ; $695c
	ld l, a ; $695d
	jr nc, .read ; $695e
	inc h ; $6960
.read:
	ld a, [hl+] ; $6961
	ld h, [hl] ; $6962
	ld l, a ; $6963
	call DecompressData ; $6964
	ret ; $6967
CharacterPortraitTable_16:
	; $6968, 64 bytes (char_lz_ptr_table)
	dw PortraitGfxAlex_16 ; $00 Alex
	dw PortraitGfxNina_16 ; $01 Nina
	dw PortraitGfxHarry_16 ; $02 Harry
	dw PortraitGfxKate_16 ; $03 Kate
	dw PortraitGfxAllie_16 ; $04 Allie
	dw PortraitGfxJoy_16 ; $05 Joy
	dw PortraitGfxBrian_16 ; $06 Brian
	dw PortraitGfxPam_16 ; $07 Pam
	dw PortraitGfxBob_16 ; $08 Bob
	dw PortraitGfxBeth_16 ; $09 Beth
	dw PortraitGfxFay_16 ; $0a Fay
	dw PortraitGfxCurt_16 ; $0b Curt
	dw PortraitGfxMark_16 ; $0c Mark
	dw PortraitGfxSean_16 ; $0d Sean
	dw PortraitGfxSammi_16 ; $0e Sammi
	dw PortraitGfxElden_16 ; $0f Elden
	dw PortraitGfxSpike_16 ; $10 Spike
	dw PortraitGfxEmily_16 ; $11 Emily
	dw PortraitGfxBCoz_16 ; $12 B. Coz
	dw PortraitGfxACoz_16 ; $13 A. Coz
	dw PortraitGfxPlaceholder_16 ; $14 Kevin
	dw PortraitGfxPlaceholder_16 ; $15 Not used
	dw PortraitGfxPlaceholder_16 ; $16 Not used
	dw PortraitGfxLuigi_16 ; $17 Luigi
	dw PortraitGfxDK_16 ; $18 DK
	dw PortraitGfxBabyMario_16 ; $19 Baby M.
	dw PortraitGfxMario_16 ; $1a Mario
	dw PortraitGfxWaluigi_16 ; $1b Waluigi
	dw PortraitGfxYoshi_16 ; $1c Yoshi
	dw PortraitGfxBowser_16 ; $1d Bowser
	dw PortraitGfxWario_16 ; $1e Wario
	dw PortraitGfxPeach_16 ; $1f Peach
PortraitGfxAlex_16:
	INCBIN "data/bank_016/lz_PortraitGfxAlex_16.bin" ; $69a8, 158 bytes
PortraitGfxNina_16:
	INCBIN "data/bank_016/lz_PortraitGfxNina_16.bin" ; $6a46, 163 bytes
PortraitGfxHarry_16:
	INCBIN "data/bank_016/lz_PortraitGfxHarry_16.bin" ; $6ae9, 146 bytes
PortraitGfxKate_16:
	INCBIN "data/bank_016/lz_PortraitGfxKate_16.bin" ; $6b7b, 165 bytes
PortraitGfxAllie_16:
	INCBIN "data/bank_016/lz_PortraitGfxAllie_16.bin" ; $6c20, 134 bytes
PortraitGfxJoy_16:
	INCBIN "data/bank_016/lz_PortraitGfxJoy_16.bin" ; $6ca6, 148 bytes
PortraitGfxBrian_16:
	INCBIN "data/bank_016/lz_PortraitGfxBrian_16.bin" ; $6d3a, 144 bytes
PortraitGfxPam_16:
	INCBIN "data/bank_016/lz_PortraitGfxPam_16.bin" ; $6dca, 137 bytes
PortraitGfxBob_16:
	INCBIN "data/bank_016/lz_PortraitGfxBob_16.bin" ; $6e53, 141 bytes
PortraitGfxBeth_16:
	INCBIN "data/bank_016/lz_PortraitGfxBeth_16.bin" ; $6ee0, 147 bytes
PortraitGfxFay_16:
	INCBIN "data/bank_016/lz_PortraitGfxFay_16.bin" ; $6f73, 147 bytes
PortraitGfxCurt_16:
	INCBIN "data/bank_016/lz_PortraitGfxCurt_16.bin" ; $7006, 161 bytes
PortraitGfxMark_16:
	INCBIN "data/bank_016/lz_PortraitGfxMark_16.bin" ; $70a7, 161 bytes
PortraitGfxSean_16:
	INCBIN "data/bank_016/lz_PortraitGfxSean_16.bin" ; $7148, 157 bytes
PortraitGfxSammi_16:
	INCBIN "data/bank_016/lz_PortraitGfxSammi_16.bin" ; $71e5, 150 bytes
PortraitGfxElden_16:
	INCBIN "data/bank_016/lz_PortraitGfxElden_16.bin" ; $727b, 149 bytes
PortraitGfxSpike_16:
	INCBIN "data/bank_016/lz_PortraitGfxSpike_16.bin" ; $7310, 162 bytes
PortraitGfxEmily_16:
	INCBIN "data/bank_016/lz_PortraitGfxEmily_16.bin" ; $73b2, 151 bytes
PortraitGfxBCoz_16:
	INCBIN "data/bank_016/lz_PortraitGfxBCoz_16.bin" ; $7449, 147 bytes
PortraitGfxACoz_16:
	INCBIN "data/bank_016/lz_PortraitGfxACoz_16.bin" ; $74dc, 121 bytes
PortraitGfxPlaceholder_16:
	INCBIN "data/bank_016/lz_PortraitGfxPlaceholder_16.bin" ; $7555, 126 bytes
PortraitGfxLuigi_16:
	INCBIN "data/bank_016/lz_PortraitGfxLuigi_16.bin" ; $75d3, 154 bytes
PortraitGfxDK_16:
	INCBIN "data/bank_016/lz_PortraitGfxDK_16.bin" ; $766d, 156 bytes
PortraitGfxBabyMario_16:
	INCBIN "data/bank_016/lz_PortraitGfxBabyMario_16.bin" ; $7709, 155 bytes
PortraitGfxMario_16:
	INCBIN "data/bank_016/lz_PortraitGfxMario_16.bin" ; $77a4, 162 bytes
PortraitGfxWaluigi_16:
	INCBIN "data/bank_016/lz_PortraitGfxWaluigi_16.bin" ; $7846, 158 bytes
PortraitGfxYoshi_16:
	INCBIN "data/bank_016/lz_PortraitGfxYoshi_16.bin" ; $78e4, 139 bytes
PortraitGfxBowser_16:
	INCBIN "data/bank_016/lz_PortraitGfxBowser_16.bin" ; $796f, 165 bytes
PortraitGfxWario_16:
	INCBIN "data/bank_016/lz_PortraitGfxWario_16.bin" ; $7a14, 162 bytes
PortraitGfxPeach_16:
	INCBIN "data/bank_016/lz_PortraitGfxPeach_16.bin" ; $7ab6, 153 bytes
	; $7b4f, 1201 bytes fill to bank end (linker-padded)
