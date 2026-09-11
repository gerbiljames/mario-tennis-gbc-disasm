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
; Instruction-identical to ApplySpriteWobbleX_17 (one copy per bank); a change here belongs in every copy.
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
; Instruction-identical to ApplySpriteWobbleY_17 (one copy per bank); a change here belongs in every copy.
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
; Instruction-identical to MoveMenuCursorGridFromLinkInput_38 and MoveMenuCursorGridFromLinkInput_3e (one copy per bank); a change here belongs in every copy.
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
; Instruction-identical to MoveMenuCursorGridRemote_38 and MoveMenuCursorGridRemote_3e (one copy per bank); a change here belongs in every copy.
MoveMenuCursorGridRemote_16:
	ld a, [wMenuCursorX] ; $41f3
	ld d, a ; $41f6
	ld a, [wMenuCursorY] ; $41f7
	ld e, a ; $41fa
	ldh a, [hLinkState] ; $41fb
	cp LINKSTATE_SLAVE ; $41fd
	jr z, .asSlave ; $41ff
	cp LINKSTATE_MASTER ; $4201
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
; Instruction-identical to MoveMenuCursor2GridRemote_3e (one copy per bank); a change here belongs in every copy.
MoveMenuCursor2GridRemote_16:
	ld a, [wMenuCursor2X] ; $42be
	ld d, a ; $42c1
	ld a, [wMenuCursor2Y] ; $42c2
	ld e, a ; $42c5
	ldh a, [hLinkState] ; $42c6
	cp LINKSTATE_SLAVE ; $42c8
	jr z, .asSlave ; $42ca
	cp LINKSTATE_MASTER ; $42cc
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
; Instruction-identical to GetMenuCursorIndex_1b, GetMenuCursorIndex_38, GetMenuCursorIndex_3b and GetMenuCursorIndex_3e (one copy per bank); a change here belongs in every copy.
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
