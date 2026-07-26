SECTION "ROM Bank $38", ROMX[$4000], BANK[$38]

	farptr RunCharacterSelectScreen ; $4000
	farptr RunMatchTypeMenu ; $4002
	farptr RunLinkMatchSequence ; $4004
	farptr RunNameEntryScreen ; $4006
	farptr RunExhibitionCharSelectScreen ; $4008
	farptr UpdateMenuCursorFromLinkInput ; $400a
	farptr RunLinkCharSelectScreen ; $400c
	farptr RunMatchTypeMenuLink ; $400e
	farptr RunLinkMatchSequenceAlias1, RunLinkMatchSequence ; $4010
	farptr ApplySpriteBobOffsetX ; $4012
	farptr ApplySpriteBobOffsetY ; $4014
	farptr IsStarCharacter ; $4016
DrawSelectedOptionBox:
	push de ; $4018
	push bc ; $4019
	ld c, $00 ; $401a
	call ApplySpriteBobOffsetX ; $401c
	ld c, $00 ; $401f
	call ApplySpriteBobOffsetY ; $4021
	ld c, $00 ; $4024
	ld b, $08 ; $4026
	call QueueSprite ; $4028
	pop bc ; $402b
	pop de ; $402c
	push de ; $402d
	push bc ; $402e
	ld a, b ; $402f
	add a, d ; $4030
	ld d, a ; $4031
	push de ; $4032
	ld c, $01 ; $4033
	call ApplySpriteBobOffsetX ; $4035
	ld c, $00 ; $4038
	call ApplySpriteBobOffsetY ; $403a
	ld c, $00 ; $403d
	ld b, $28 ; $403f
	call QueueSprite ; $4041
	pop de ; $4044
	pop bc ; $4045
	pop de ; $4046
	push de ; $4047
	push bc ; $4048
	ld a, c ; $4049
	add a, e ; $404a
	ld e, a ; $404b
	ld a, b ; $404c
	add a, d ; $404d
	ld d, a ; $404e
	push de ; $404f
	ld c, $01 ; $4050
	call ApplySpriteBobOffsetX ; $4052
	ld c, $01 ; $4055
	call ApplySpriteBobOffsetY ; $4057
	ld c, $00 ; $405a
	ld b, $68 ; $405c
	call QueueSprite ; $405e
	pop de ; $4061
	pop bc ; $4062
	pop de ; $4063
	ld a, e ; $4064
	add a, c ; $4065
	ld e, a ; $4066
	push de ; $4067
	ld c, $00 ; $4068
	call ApplySpriteBobOffsetX ; $406a
	ld c, $01 ; $406d
	call ApplySpriteBobOffsetY ; $406f
	ld c, $00 ; $4072
	ld b, $48 ; $4074
	call QueueSprite ; $4076
	pop de ; $4079
	ret ; $407a
ApplySpriteBobOffsetX:
	ldh a, [hVBlankCounter] ; $407b
	and a, $0f ; $407d
	ld hl, Data_38_4095 ; $407f
	add a, l ; $4082
	ld l, a ; $4083
	jr nc, .readOffset ; $4084
	inc h ; $4086
.readOffset:
	ld a, [hl] ; $4087
	ld b, a ; $4088
	ld a, c ; $4089
	or a, a ; $408a
	jr z, .subtract ; $408b
	ld a, b ; $408d
	add a, d ; $408e
	ld d, a ; $408f
	ret ; $4090
.subtract:
	ld a, d ; $4091
	sub a, b ; $4092
	ld d, a ; $4093
	ret ; $4094
Data_38_4095:
	; $4095, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
ApplySpriteBobOffsetY:
	ldh a, [hVBlankCounter] ; $40a5
	and a, $0f ; $40a7
	ld hl, $40bf ; $40a9
	add a, l ; $40ac
	ld l, a ; $40ad
	jr nc, .readOffset ; $40ae
	inc h ; $40b0
.readOffset:
	ld a, [hl] ; $40b1
	ld b, a ; $40b2
	ld a, c ; $40b3
	or a, a ; $40b4
	jr z, .subtract ; $40b5
	ld a, b ; $40b7
	add a, e ; $40b8
	ld e, a ; $40b9
	ret ; $40ba
.subtract:
	ld a, e ; $40bb
	sub a, b ; $40bc
	ld e, a ; $40bd
	ret ; $40be
	nop ; $40bf
	nop ; $40c0
	nop ; $40c1
	ld bc, $0101 ; $40c2
	ld bc, $0101 ; $40c5
	ld bc, $0001 ; $40c8
	nop ; $40cb
	nop ; $40cc
	nop ; $40cd
	nop ; $40ce
DrawUnselectedOptionBox:
	push de ; $40cf
	push bc ; $40d0
	ld c, $00 ; $40d1
	ld b, $09 ; $40d3
	call QueueSprite ; $40d5
	pop bc ; $40d8
	pop de ; $40d9
	push de ; $40da
	push bc ; $40db
	ld a, b ; $40dc
	add a, d ; $40dd
	ld d, a ; $40de
	push de ; $40df
	ld c, $00 ; $40e0
	ld b, $29 ; $40e2
	call QueueSprite ; $40e4
	pop de ; $40e7
	pop bc ; $40e8
	pop de ; $40e9
	push de ; $40ea
	push bc ; $40eb
	ld a, c ; $40ec
	add a, e ; $40ed
	ld e, a ; $40ee
	ld a, b ; $40ef
	add a, d ; $40f0
	ld d, a ; $40f1
	push de ; $40f2
	ld c, $00 ; $40f3
	ld b, $69 ; $40f5
	call QueueSprite ; $40f7
	pop de ; $40fa
	pop bc ; $40fb
	pop de ; $40fc
	ld a, e ; $40fd
	add a, c ; $40fe
	ld e, a ; $40ff
	push de ; $4100
	ld c, $00 ; $4101
	ld b, $49 ; $4103
	call QueueSprite ; $4105
	pop de ; $4108
	ret ; $4109
MoveMenuCursorBox:
	ld a, [wMenuCursorX] ; $410a
	ld d, a ; $410d
	ld a, [wMenuCursorY] ; $410e
	ld e, a ; $4111
	ld a, [wMenuInputPressed] ; $4112
	bit PADB_RIGHT, a ; $4115
	jr z, .checkLeft ; $4117
	ld a, [wMenuCursorX] ; $4119
	inc a ; $411c
	add a, a ; $411d
	jr nc, .wrapRight ; $411e
	ld a, b ; $4120
	dec a ; $4121
	jr .storeRight ; $4122
.wrapRight:
	rra ; $4124
	cp a, b ; $4125
	jr c, .storeRight ; $4126
	xor a, a ; $4128
.storeRight:
	ld [wMenuCursorX], a ; $4129
	jr .compare ; $412c
.checkLeft:
	bit 5, a ; $412e
	jr z, .checkUp ; $4130
	ld a, [wMenuCursorX] ; $4132
	dec a ; $4135
	add a, a ; $4136
	jr nc, .wrapLeft ; $4137
	ld a, b ; $4139
	dec a ; $413a
	jr .storeLeft ; $413b
.wrapLeft:
	rra ; $413d
	cp a, b ; $413e
	jr c, .storeLeft ; $413f
	xor a, a ; $4141
.storeLeft:
	ld [wMenuCursorX], a ; $4142
	jr .compare ; $4145
.checkUp:
	bit 6, a ; $4147
	jr z, .checkDown ; $4149
	ld a, [wMenuCursorY] ; $414b
	dec a ; $414e
	add a, a ; $414f
	jr nc, .wrapUp ; $4150
	ld a, c ; $4152
	dec a ; $4153
	jr .storeUp ; $4154
.wrapUp:
	rra ; $4156
	cp a, c ; $4157
	jr c, .storeUp ; $4158
	xor a, a ; $415a
.storeUp:
	ld [wMenuCursorY], a ; $415b
	jr .compare ; $415e
.checkDown:
	bit 7, a ; $4160
	jr z, .compare ; $4162
	ld a, [wMenuCursorY] ; $4164
	inc a ; $4167
	add a, a ; $4168
	jr nc, .wrapDown ; $4169
	ld a, c ; $416b
	dec a ; $416c
	jr .storeDown ; $416d
.wrapDown:
	rra ; $416f
	cp a, c ; $4170
	jr c, .storeDown ; $4171
	xor a, a ; $4173
.storeDown:
	ld [wMenuCursorY], a ; $4174
.compare:
	ld a, [wMenuCursorX] ; $4177
	cp a, d ; $417a
	jr nz, .moved ; $417b
	ld a, [wMenuCursorY] ; $417d
	cp a, e ; $4180
	jr nz, .moved ; $4181
	xor a, a ; $4183
	ret ; $4184
.moved:
	ld a, $01 ; $4185
	ret ; $4187
MoveMenuCursorBoxLink:
	ld a, [wMenuCursorX] ; $4188
	ld d, a ; $418b
	ld a, [wMenuCursorY] ; $418c
	ld e, a ; $418f
	ldh a, [hLinkInput] ; $4190
	bit 4, a ; $4192
	jr z, .checkLeft ; $4194
	ld a, [wMenuCursorX] ; $4196
	inc a ; $4199
	add a, a ; $419a
	jr nc, .wrapRight ; $419b
	ld a, b ; $419d
	dec a ; $419e
	jr .storeRight ; $419f
.wrapRight:
	rra ; $41a1
	cp a, b ; $41a2
	jr c, .storeRight ; $41a3
	xor a, a ; $41a5
.storeRight:
	ld [wMenuCursorX], a ; $41a6
	jr .compare ; $41a9
.checkLeft:
	bit 5, a ; $41ab
	jr z, .checkUp ; $41ad
	ld a, [wMenuCursorX] ; $41af
	dec a ; $41b2
	add a, a ; $41b3
	jr nc, .wrapLeft ; $41b4
	ld a, b ; $41b6
	dec a ; $41b7
	jr .storeLeft ; $41b8
.wrapLeft:
	rra ; $41ba
	cp a, b ; $41bb
	jr c, .storeLeft ; $41bc
	xor a, a ; $41be
.storeLeft:
	ld [wMenuCursorX], a ; $41bf
	jr .compare ; $41c2
.checkUp:
	bit 6, a ; $41c4
	jr z, .checkDown ; $41c6
	ld a, [wMenuCursorY] ; $41c8
	dec a ; $41cb
	add a, a ; $41cc
	jr nc, .wrapUp ; $41cd
	ld a, c ; $41cf
	dec a ; $41d0
	jr .storeUp ; $41d1
.wrapUp:
	rra ; $41d3
	cp a, c ; $41d4
	jr c, .storeUp ; $41d5
	xor a, a ; $41d7
.storeUp:
	ld [wMenuCursorY], a ; $41d8
	jr .compare ; $41db
.checkDown:
	bit 7, a ; $41dd
	jr z, .compare ; $41df
	ld a, [wMenuCursorY] ; $41e1
	inc a ; $41e4
	add a, a ; $41e5
	jr nc, .wrapDown ; $41e6
	ld a, c ; $41e8
	dec a ; $41e9
	jr .storeDown ; $41ea
.wrapDown:
	rra ; $41ec
	cp a, c ; $41ed
	jr c, .storeDown ; $41ee
	xor a, a ; $41f0
.storeDown:
	ld [wMenuCursorY], a ; $41f1
.compare:
	ld a, [wMenuCursorX] ; $41f4
	cp a, d ; $41f7
	jr nz, .moved ; $41f8
	ld a, [wMenuCursorY] ; $41fa
	cp a, e ; $41fd
	jr nz, .moved ; $41fe
	xor a, a ; $4200
	ret ; $4201
.moved:
	ld a, $01 ; $4202
	ret ; $4204
MoveMenuCursorBoxRemote_38:
	ld a, [wMenuCursorX] ; $4205
	ld d, a ; $4208
	ld a, [wMenuCursorY] ; $4209
	ld e, a ; $420c
	ldh a, [hLinkState] ; $420d
	cp a, $02 ; $420f
	jr z, .asSlave ; $4211
	cp a, $01 ; $4213
	jr z, .asMaster ; $4215
	call LinkErrorReset ; $4217
.asMaster:
	ldh a, [hLinkRemoteInputBuf] ; $421a
	jr .haveInput ; $421c
.asSlave:
	ldh a, [hLinkRemoteInput] ; $421e
.haveInput:
	ld h, a ; $4220
	ld a, [wMenuCursorLockFlags] ; $4221
	and a, $01 ; $4224
	ld a, h ; $4226
	jr nz, .checkLock ; $4227
	bit 4, a ; $4229
	jr z, .checkLeft ; $422b
	ld a, [wMenuCursorX] ; $422d
	inc a ; $4230
	add a, a ; $4231
	jr nc, .wrapRight ; $4232
	ld a, b ; $4234
	dec a ; $4235
	jr .storeRight ; $4236
.wrapRight:
	rra ; $4238
	cp a, b ; $4239
	jr c, .storeRight ; $423a
	xor a, a ; $423c
.storeRight:
	ld [wMenuCursorX], a ; $423d
	jr .compare ; $4240
.checkLeft:
	bit 5, a ; $4242
	jr z, .checkUp ; $4244
	ld a, [wMenuCursorX] ; $4246
	dec a ; $4249
	add a, a ; $424a
	jr nc, .wrapLeft ; $424b
	ld a, b ; $424d
	dec a ; $424e
	jr .storeLeft ; $424f
.wrapLeft:
	rra ; $4251
	cp a, b ; $4252
	jr c, .storeLeft ; $4253
	xor a, a ; $4255
.storeLeft:
	ld [wMenuCursorX], a ; $4256
	jr .compare ; $4259
.checkUp:
	bit 6, a ; $425b
	jr z, .checkDown ; $425d
	ld a, [wMenuCursorY] ; $425f
	dec a ; $4262
	add a, a ; $4263
	jr nc, .wrapUp ; $4264
	ld a, c ; $4266
	dec a ; $4267
	jr .storeUp ; $4268
.wrapUp:
	rra ; $426a
	cp a, c ; $426b
	jr c, .storeUp ; $426c
	xor a, a ; $426e
.storeUp:
	ld [wMenuCursorY], a ; $426f
	jr .compare ; $4272
.checkDown:
	bit 7, a ; $4274
	jr z, .checkLock ; $4276
	ld a, [wMenuCursorY] ; $4278
	inc a ; $427b
	add a, a ; $427c
	jr nc, .wrapDown ; $427d
	ld a, c ; $427f
	dec a ; $4280
	jr .storeDown ; $4281
.wrapDown:
	rra ; $4283
	cp a, c ; $4284
	jr c, .storeDown ; $4285
	xor a, a ; $4287
.storeDown:
	ld [wMenuCursorY], a ; $4288
	jr .compare ; $428b
.checkLock:
	bit 0, a ; $428d
	jr z, .checkUnlock ; $428f
	sound $5f ; $4291
	ld a, [wMenuCursorLockFlags] ; $4293
	ld b, a ; $4296
	and a, $01 ; $4297
	jr nz, .compare ; $4299
	sound $5f ; $429b
	ld a, b ; $429d
	or a, $01 ; $429e
	ld [wMenuCursorLockFlags], a ; $42a0
	jr .compare ; $42a3
.checkUnlock:
	bit 1, a ; $42a5
	jr z, .compare ; $42a7
	sound $62 ; $42a9
	ld a, [wMenuCursorLockFlags] ; $42ab
	ld b, a ; $42ae
	and a, $03 ; $42af
	ld a, b ; $42b1
	jr nz, .clearLock ; $42b2
	and a, $fa ; $42b4
	or a, $04 ; $42b6
	jr .storeLock ; $42b8
.clearLock:
	and a, $fe ; $42ba
.storeLock:
	ld [wMenuCursorLockFlags], a ; $42bc
.compare:
	ld a, [wMenuCursorX] ; $42bf
	cp a, d ; $42c2
	jr nz, .moved ; $42c3
	ld a, [wMenuCursorY] ; $42c5
	cp a, e ; $42c8
	jr nz, .moved ; $42c9
	xor a, a ; $42cb
	ret ; $42cc
.moved:
	ld a, $01 ; $42cd
	ret ; $42cf
Data_38_42d0:
	; $42d0, 21 bytes (bytes:16)
	db $fa, $06, $cb, $57, $fa, $07, $cb, $5f, $f0, $c2, $fe, $02, $28, $0b, $fe, $01 ; 0x00
	db $28, $03, $cd, $4b, $28 ; 0x10
	ldh a, [hLinkRemoteInput] ; $42e5
	jr .haveInput2 ; $42e7
	ldh a, [hLinkRemoteInputBuf] ; $42e9
.haveInput2:
	ld h, a ; $42eb
	ld a, [wMenuCursorLockFlags] ; $42ec
	and a, $02 ; $42ef
	ld a, h ; $42f1
	jr nz, .checkLock2 ; $42f2
	bit 4, a ; $42f4
	jr z, .checkLeft2 ; $42f6
	ld a, [wMenuCursor2X] ; $42f8
	inc a ; $42fb
	add a, a ; $42fc
	jr nc, .wrapRight2 ; $42fd
	ld a, b ; $42ff
	dec a ; $4300
	jr .storeRight2 ; $4301
.wrapRight2:
	rra ; $4303
	cp a, b ; $4304
	jr c, .storeRight2 ; $4305
	xor a, a ; $4307
.storeRight2:
	ld [wMenuCursor2X], a ; $4308
	jr .compare2 ; $430b
.checkLeft2:
	bit 5, a ; $430d
	jr z, .checkUp2 ; $430f
	ld a, [wMenuCursor2X] ; $4311
	dec a ; $4314
	add a, a ; $4315
	jr nc, .wrapLeft2 ; $4316
	ld a, b ; $4318
	dec a ; $4319
	jr .storeLeft2 ; $431a
.wrapLeft2:
	rra ; $431c
	cp a, b ; $431d
	jr c, .storeLeft2 ; $431e
	xor a, a ; $4320
.storeLeft2:
	ld [wMenuCursor2X], a ; $4321
	jr .compare2 ; $4324
.checkUp2:
	bit 6, a ; $4326
	jr z, .checkDown2 ; $4328
	ld a, [wMenuCursor2Y] ; $432a
	dec a ; $432d
	add a, a ; $432e
	jr nc, .wrapUp2 ; $432f
	ld a, c ; $4331
	dec a ; $4332
	jr .storeUp2 ; $4333
.wrapUp2:
	rra ; $4335
	cp a, c ; $4336
	jr c, .storeUp2 ; $4337
	xor a, a ; $4339
.storeUp2:
	ld [wMenuCursor2Y], a ; $433a
	jr .compare2 ; $433d
.checkDown2:
	bit 7, a ; $433f
	jr z, .checkLock2 ; $4341
	ld a, [wMenuCursor2Y] ; $4343
	inc a ; $4346
	add a, a ; $4347
	jr nc, .wrapDown2 ; $4348
	ld a, c ; $434a
	dec a ; $434b
	jr .storeDown2 ; $434c
.wrapDown2:
	rra ; $434e
	cp a, c ; $434f
	jr c, .storeDown2 ; $4350
	xor a, a ; $4352
.storeDown2:
	ld [wMenuCursor2Y], a ; $4353
	jr .compare2 ; $4356
.checkLock2:
	bit 0, a ; $4358
	jr z, .checkUnlock2 ; $435a
	ld a, [wMenuCursorLockFlags] ; $435c
	ld b, a ; $435f
	and a, $02 ; $4360
	jr nz, .compare2 ; $4362
	sound $5f ; $4364
	ld a, b ; $4366
	or a, $02 ; $4367
	ld [wMenuCursorLockFlags], a ; $4369
	jr .compare2 ; $436c
.checkUnlock2:
	bit 1, a ; $436e
	jr z, .compare2 ; $4370
	sound $62 ; $4372
	ld a, [wMenuCursorLockFlags] ; $4374
	ld b, a ; $4377
	and a, $03 ; $4378
	ld a, b ; $437a
	jr nz, .clearLock2 ; $437b
	and a, $f5 ; $437d
	or a, $08 ; $437f
	jr .storeLock2 ; $4381
.clearLock2:
	and a, $fd ; $4383
.storeLock2:
	ld [wMenuCursorLockFlags], a ; $4385
.compare2:
	ld a, [wMenuCursor2X] ; $4388
	cp a, d ; $438b
	jr nz, .moved2 ; $438c
	ld a, [wMenuCursor2Y] ; $438e
	cp a, e ; $4391
	jr nz, .moved2 ; $4392
	xor a, a ; $4394
	ret ; $4395
.moved2:
	ld a, $01 ; $4396
	ret ; $4398
GetMenuCursorLinearIndex:
	ld a, [wMenuCursorY] ; $4399
	ld b, a ; $439c
	xor a, a ; $439d
	inc b ; $439e
.mulLoop:
	dec b ; $439f
	jr z, .addColumn ; $43a0
	add a, c ; $43a2
	jr .mulLoop ; $43a3
.addColumn:
	ld b, a ; $43a5
	ld a, [wMenuCursorX] ; $43a6
	add a, b ; $43a9
	ret ; $43aa
GetMenuCursorLinearIndexFromPtr:
	push bc ; $43ab
	ld a, [hl-] ; $43ac
	ld b, a ; $43ad
	xor a, a ; $43ae
	inc b ; $43af
.mulLoop:
	dec b ; $43b0
	jr z, .addColumn ; $43b1
	add a, c ; $43b3
	jr .mulLoop ; $43b4
.addColumn:
	ld b, a ; $43b6
	ld a, [hl] ; $43b7
	add a, b ; $43b8
	pop bc ; $43b9
	ret ; $43ba
SetMenuCursorFromLinearIndex:
	ld d, $00 ; $43bb
	ld a, c ; $43bd
.divLoop:
	cp a, b ; $43be
	jr c, .store ; $43bf
	inc d ; $43c1
	sub a, b ; $43c2
	jr .divLoop ; $43c3
.store:
	ld [wMenuCursorX], a ; $43c5
	ld a, d ; $43c8
	ld [wMenuCursorY], a ; $43c9
	ret ; $43cc
SetMenuCursorFromLinearIndexToPtr:
	ld d, $00 ; $43cd
	ld a, c ; $43cf
.divLoop:
	cp a, b ; $43d0
	jr c, Label_38_43d7 ; $43d1
	inc d ; $43d3
	sub a, b ; $43d4
	jr .divLoop ; $43d5
Label_38_43d7:
	ld [hl+], a ; $43d7
	ld a, d ; $43d8
	ld [hl], a ; $43d9
	ret ; $43da
Data_38_43db:
	; $43db, 12 bytes (bytes:12)
	db $f0, $96, $f5, $3e, $03, $e0, $96, $e0, $70, $af, $0e, $40 ; 0x00
Label_38_43e7:
	ld [hl+], a ; $43e7
	dec c ; $43e8
	jr nz, Label_38_43e7 ; $43e9
	pop af ; $43eb
	wram_bank ; $43ec
	ret ; $43f0
Data_38_43f1:
	; $43f1, 13 bytes (bytes:13)
	db $f0, $96, $f5, $3e, $03, $e0, $96, $e0, $70, $3e, $00, $0e, $40 ; 0x00
Label_38_43fe:
	ld [hl+], a ; $43fe
	dec c ; $43ff
	jr nz, Label_38_43fe ; $4400
	pop af ; $4402
	wram_bank ; $4403
	ret ; $4407
UpdateAnimatedTilesTask_38:
	farcall UpdateAnimatedTiles ; $4408
	ret ; $440b
CopyStringToTilemap:
	push af ; $440c
	push bc ; $440d
.charLoop:
	ld a, [hl] ; $440e
	cp a, $00 ; $440f
	jr z, .done ; $4411
	ld [de], a ; $4413
	inc hl ; $4414
	ld a, [hl] ; $4415
	cp a, $de ; $4416
	jr z, .markChar ; $4418
	cp a, $df ; $441a
	jr nz, .nextCell ; $441c
.markChar:
	push hl ; $441e
	push bc ; $441f
	ld h, d ; $4420
	ld l, e ; $4421
	ld bc, $ffe0 ; $4422
	add hl, bc ; $4425
	ld b, a ; $4426
	ld a, [hl] ; $4427
	cp a, $03 ; $4428
	ld a, b ; $442a
	jr nz, .writeMark ; $442b
	sub a, $d0 ; $442d
.writeMark:
	ld [hl], a ; $442f
	pop bc ; $4430
	pop hl ; $4431
	inc hl ; $4432
.nextCell:
	inc de ; $4433
	ld a, e ; $4434
	and a, $1f ; $4435
	jr nz, .charLoop ; $4437
	push hl ; $4439
	ld h, d ; $443a
	ld l, e ; $443b
	add hl, de ; $443c
	ld d, h ; $443d
	ld e, l ; $443e
	pop hl ; $443f
	jr .charLoop ; $4440
.done:
	pop bc ; $4442
	pop af ; $4443
	ret ; $4444
DrawDecimalNumber:
	push af ; $4445
	push bc ; $4446
	push hl ; $4447
	add sp, -10 ; $4448
	push bc ; $444a
	push de ; $444b
	ld c, l ; $444c
	ld b, h ; $444d
	ld hl, sp + 4 ; $444e
	ld e, l ; $4450
	ld d, h ; $4451
	ld l, c ; $4452
	ld h, b ; $4453
	ld c, e ; $4454
	ld b, d ; $4455
	call FormatDecimalNumber ; $4456
	ld l, c ; $4459
	ld h, b ; $445a
	pop de ; $445b
	pop bc ; $445c
	call CopyDecimalStringToTilemap ; $445d
	add sp, 10 ; $4460
	pop hl ; $4462
	pop bc ; $4463
	pop af ; $4464
	ret ; $4465
CopyDecimalStringToTilemap:
	ld a, [hl+] ; $4466
	and a, a ; $4467
	jr z, Label_38_446f ; $4468
	call WriteDecimalDigitTile ; $446a
	jr CopyDecimalStringToTilemap ; $446d
Label_38_446f:
	ret ; $446f
WriteDecimalDigitTile:
	push hl ; $4470
	ld hl, $d240 ; $4471
	sub a, $30 ; $4474
	jr c, Label_38_4486 ; $4476
	add a, $30 ; $4478
	ld b, a ; $447a
	wram_bank $03 ; $447b
	ld a, b ; $4481
	ld [de], a ; $4482
	inc de ; $4483
	pop hl ; $4484
	ret ; $4485
Label_38_4486:
	inc de ; $4486
	pop hl ; $4487
	ret ; $4488
RunMatchTypeMenu:
	call DisableLCDSafely ; $4489
	farcall LoadMenuFontGfx ; $448c
	call SetupMatchTypeMenuScreen ; $448f
	ld a, $01 ; $4492
	ld hl, DrawMatchTypeOptionBoxes ; $4494
	call RegisterFrameTask ; $4497
	ld a, $01 ; $449a
	ld hl, UpdateAnimatedTilesTask_38 ; $449c
	call RegisterFrameTask ; $449f
	call EnableLCD ; $44a2
	script_fade_in $10 ; $44a5
	call WaitFadeEnd ; $44aa
Label_38_44ad:
	ldh a, [hInputPressed] ; $44ad
	ld [wMenuInputPressed], a ; $44af
	call AdjustMatchTypeSetting ; $44b2
	ld b, $01 ; $44b5
	ld c, $03 ; $44b7
	call MoveMenuCursorBox ; $44b9
	or a, a ; $44bc
	jr z, Label_38_44c2 ; $44bd
	call RefreshMatchTypeLabelRow ; $44bf
Label_38_44c2:
	call AdvanceFrame ; $44c2
	ld a, [wMenuInputPressed] ; $44c5
	bit PADB_A, a ; $44c8
	jr nz, Label_38_44d2 ; $44ca
	bit 1, a ; $44cc
	jr nz, Label_38_44e1 ; $44ce
	jr Label_38_44ad ; $44d0
Label_38_44d2:
	sound $5f ; $44d2
	ld c, $10 ; $44d4
	call BeginFadeOut ; $44d6
	call WaitFadeEnd ; $44d9
	call ClearFrameTasks ; $44dc
	xor a, a ; $44df
	ret ; $44e0
Label_38_44e1:
	sound $62 ; $44e1
	ld c, $10 ; $44e3
	call BeginFadeOut ; $44e5
	call WaitFadeEnd ; $44e8
	call ClearFrameTasks ; $44eb
	ld a, $ff ; $44ee
	ret ; $44f0
RunMatchTypeMenuLink:
	xor a, a ; $44f1
	ldh [$ffd8], a ; $44f2
	call ResetSerialState ; $44f4
	call DisableLCDSafely ; $44f7
	call SetupMatchTypeMenuScreen ; $44fa
	ld a, $01 ; $44fd
	ld hl, DrawMatchTypeOptionBoxes ; $44ff
	call RegisterFrameTask ; $4502
	ld a, $01 ; $4505
	ld hl, UpdateAnimatedTilesTask_38 ; $4507
	call RegisterFrameTask ; $450a
	call EnableLCD ; $450d
	farcall ResyncLinkSession ; $4510
	script_fade_in $10 ; $4513
	push af ; $4518
	farcall RunLinkInputFrame ; $4519
	pop af ; $451c
	push af ; $451d
	farcall RunLinkInputFrame ; $451e
	pop af ; $4521
	push af ; $4522
	farcall RunLinkInputFrame ; $4523
	pop af ; $4526
	sound $14 ; $4527
Label_38_4529:
	ldh a, [hLinkInput] ; $4529
	ld [wMenuInputPressed], a ; $452b
	call AdjustMatchTypeSetting ; $452e
	ld b, $01 ; $4531
	ld c, $03 ; $4533
	call MoveMenuCursorBoxLink ; $4535
	or a, a ; $4538
	jr z, Label_38_453e ; $4539
	call RefreshMatchTypeLabelRow ; $453b
Label_38_453e:
	push af ; $453e
	farcall RunLinkInputFrame ; $453f
	pop af ; $4542
	ld a, [wMenuInputPressed] ; $4543
	bit PADB_A, a ; $4546
	jr nz, Label_38_4550 ; $4548
	bit 1, a ; $454a
	jr nz, Label_38_456e ; $454c
	jr Label_38_4529 ; $454e
Label_38_4550:
	sound $5f ; $4550
	push af ; $4552
	farcall SyncLinkFrame ; $4553
	pop af ; $4556
	xor a, a ; $4557
	ldh [$ffd8], a ; $4558
	call ResetSerialState ; $455a
	ld c, $10 ; $455d
	call BeginFadeOut ; $455f
	call WaitFadeEnd ; $4562
	sound $00 ; $4565
	sound $50 ; $4567
	call ClearFrameTasks ; $4569
	xor a, a ; $456c
	ret ; $456d
Label_38_456e:
	sound $62 ; $456e
	push af ; $4570
	farcall SyncLinkFrame ; $4571
	pop af ; $4574
	xor a, a ; $4575
	ldh [$ffd8], a ; $4576
	call ResetSerialState ; $4578
	ld c, $10 ; $457b
	call BeginFadeOut ; $457d
	call WaitFadeEnd ; $4580
	sound $00 ; $4583
	sound $50 ; $4585
	call ClearFrameTasks ; $4587
	ld a, $ff ; $458a
	ret ; $458c
DrawMatchTypeOptionBoxes:
	ld a, [wMatchFormatDoubles] ; $458d
	add a, a ; $4590
	ld hl, Data_38_45ff ; $4591
	add a, l ; $4594
	ld l, a ; $4595
	jr nc, Label_38_4599 ; $4596
	inc h ; $4598
Label_38_4599:
	ld a, [hl+] ; $4599
	ld d, [hl] ; $459a
	ld e, a ; $459b
	ld c, $01 ; $459c
	call GetMenuCursorLinearIndex ; $459e
	or a, a ; $45a1
	jr z, Label_38_45ac ; $45a2
	ld bc, $3010 ; $45a4
	call DrawUnselectedOptionBox ; $45a7
	jr Label_38_45b2 ; $45aa
Label_38_45ac:
	ld bc, $3010 ; $45ac
	call DrawSelectedOptionBox ; $45af
Label_38_45b2:
	ld a, [wMatchFormatGames] ; $45b2
	add a, a ; $45b5
	ld hl, Data_38_4603 ; $45b6
	add a, l ; $45b9
	ld l, a ; $45ba
	jr nc, Label_38_45be ; $45bb
	inc h ; $45bd
Label_38_45be:
	ld a, [hl+] ; $45be
	ld d, [hl] ; $45bf
	ld e, a ; $45c0
	ld c, $01 ; $45c1
	call GetMenuCursorLinearIndex ; $45c3
	cp a, $01 ; $45c6
	jr z, Label_38_45d2 ; $45c8
	ld bc, $3010 ; $45ca
	call DrawUnselectedOptionBox ; $45cd
	jr Label_38_45d8 ; $45d0
Label_38_45d2:
	ld bc, $3010 ; $45d2
	call DrawSelectedOptionBox ; $45d5
Label_38_45d8:
	ld a, [wMatchFormatSets] ; $45d8
	add a, a ; $45db
	ld hl, Data_38_4607 ; $45dc
	add a, l ; $45df
	ld l, a ; $45e0
	jr nc, Label_38_45e4 ; $45e1
	inc h ; $45e3
Label_38_45e4:
	ld a, [hl+] ; $45e4
	ld d, [hl] ; $45e5
	ld e, a ; $45e6
	ld c, $01 ; $45e7
	call GetMenuCursorLinearIndex ; $45e9
	cp a, $02 ; $45ec
	jr z, Label_38_45f8 ; $45ee
	ld bc, $3010 ; $45f0
	call DrawUnselectedOptionBox ; $45f3
	jr Label_38_45fe ; $45f6
Label_38_45f8:
	ld bc, $3010 ; $45f8
	call DrawSelectedOptionBox ; $45fb
Label_38_45fe:
	ret ; $45fe
Data_38_45ff:
	; $45ff, 4 bytes (bytes:4)
	db $18, $10, $18, $58 ; 0x00
Data_38_4603:
	; $4603, 4 bytes (bytes:4)
	db $38, $10, $38, $58 ; 0x00
Data_38_4607:
	; $4607, 8 bytes (bytes:8)
	db $58, $08, $58, $38, $58, $68, $c9, $c9 ; 0x00
SetupMatchTypeMenuScreen:
	ld b, $01 ; $460f
	ld a, [$cb1b] ; $4611
	ld c, a ; $4614
	call SetMenuCursorFromLinearIndex ; $4615
	ld c, $00 ; $4618
	farcall LoadScreenAssetRecord ; $461a
	farcall ResetTextWindowState ; $461d
	ld b, $11 ; $4620
	ld c, $10 ; $4622
	ld de, $9000 ; $4624
	farcall LoadCompressedTileBlock ; $4627
	wram_bank $05 ; $462a
	ld a, $03 ; $4630
	ld [wShadowTilemapBank], a ; $4632
	ld a, $00 ; $4635
	ld [wWindowTileAttr], a ; $4637
	ld d, $00 ; $463a
	ld e, $0f ; $463c
	ld b, $14 ; $463e
	ld c, $03 ; $4640
	farcall CreateWindowFromScreenRect ; $4642
	farcall DrawTextWindowFrame ; $4645
	farcall RedrawWindowRows ; $4648
	call DrawMatchTypeOptionLabel ; $464b
	farcall QueueWram3MapToVRAM ; $464e
	ld de, $a000 ; $4651
	farcall LoadFixedTileBlockAndPalette ; $4654
	ld b, $08 ; $4657
	ld c, $0d ; $4659
	farcall LoadIndexedPalette ; $465b
	ld b, $09 ; $465e
	ld c, $0e ; $4660
	farcall LoadIndexedPalette ; $4662
	ret ; $4665
RefreshMatchTypeLabelRow:
	sound $5e ; $4666
	wram_bank $03 ; $4668
	ld de, $d1e1 ; $466e
	ld b, $12 ; $4671
	ld c, $01 ; $4673
	ld h, $03 ; $4675
	farcall FillTilemapRect ; $4677
	ld de, $d201 ; $467a
	ld b, $12 ; $467d
	ld c, $01 ; $467f
	ld h, $20 ; $4681
	farcall FillTilemapRect ; $4683
	call DrawMatchTypeOptionLabel ; $4686
	ld hl, $d1e0 ; $4689
	ld de, $99e0 ; $468c
	ld c, $04 ; $468f
	call QueueVRAMCopy ; $4691
	ret ; $4694
Gfx_38_4695:
	INCBIN "data/bank_038/d_4695.bin" ; $4695, 141 bytes
DrawMatchTypeOptionLabel:
	wram_bank $03 ; $4722
	ld c, $01 ; $4728
	call GetMenuCursorLinearIndex ; $472a
	ld b, a ; $472d
	add a, a ; $472e
	ld hl, Data_38_4749 ; $472f
	add a, l ; $4732
	ld l, a ; $4733
	jr nc, Label_38_4737 ; $4734
	inc h ; $4736
Label_38_4737:
	ld a, [hl+] ; $4737
	ld d, [hl] ; $4738
	ld e, a ; $4739
	ld a, b ; $473a
	ld hl, $0084 ; $473b
	add a, l ; $473e
	ld l, a ; $473f
	jr nc, Label_38_4743 ; $4740
	inc h ; $4742
Label_38_4743:
	ld c, $20 ; $4743
	farcall RenderTextToBuffer64 ; $4745
	ret ; $4748
Data_38_4749:
	; $4749, 6 bytes (bytes:6)
	db $01, $d2, $02, $d2, $02, $d2 ; 0x00
AdjustMatchTypeSetting:
	ld a, [wMenuInputPressed] ; $474f
	bit PADB_LEFT, a ; $4752
	jr nz, .decrease ; $4754
	bit 4, a ; $4756
	jr nz, .increase ; $4758
	ret ; $475a
.decrease:
	sound $5e ; $475b
	ld c, $01 ; $475d
	call GetMenuCursorLinearIndex ; $475f
	or a, a ; $4762
	jr nz, .decGames ; $4763
	ld a, [wMatchFormatDoubles] ; $4765
	xor a, $01 ; $4768
	ld [wMatchFormatDoubles], a ; $476a
	ret ; $476d
.decGames:
	cp a, $01 ; $476e
	jr nz, .decSets ; $4770
	ld a, [wMatchFormatGames] ; $4772
	xor a, $01 ; $4775
	ld [wMatchFormatGames], a ; $4777
	ret ; $477a
.decSets:
	ld a, [wMatchFormatSets] ; $477b
	dec a ; $477e
	add a, a ; $477f
	jr nc, .decCheckMax ; $4780
	ld a, $03 ; $4782
	dec a ; $4784
	jr .storeDecSets ; $4785
.decCheckMax:
	rra ; $4787
	cp a, $03 ; $4788
	jr c, .storeDecSets ; $478a
	xor a, a ; $478c
.storeDecSets:
	ld [wMatchFormatSets], a ; $478d
	ret ; $4790
.increase:
	sound $5e ; $4791
	ld c, $01 ; $4793
	call GetMenuCursorLinearIndex ; $4795
	or a, a ; $4798
	jr nz, .incGames ; $4799
	ld a, [wMatchFormatDoubles] ; $479b
	xor a, $01 ; $479e
	ld [wMatchFormatDoubles], a ; $47a0
	ret ; $47a3
.incGames:
	cp a, $01 ; $47a4
	jr nz, .incSets ; $47a6
	ld a, [wMatchFormatGames] ; $47a8
	xor a, $01 ; $47ab
	ld [wMatchFormatGames], a ; $47ad
	ret ; $47b0
.incSets:
	ld a, [wMatchFormatSets] ; $47b1
	inc a ; $47b4
	add a, a ; $47b5
	jr nc, .incCheckMax ; $47b6
	ld a, $03 ; $47b8
	dec a ; $47ba
	jr .storeIncSets ; $47bb
.incCheckMax:
	rra ; $47bd
	cp a, $03 ; $47be
	jr c, .storeIncSets ; $47c0
	xor a, a ; $47c2
.storeIncSets:
	ld [wMatchFormatSets], a ; $47c3
	ret ; $47c6
RunCharacterSelectScreen:
	sound $03 ; $47c7
	wram_bank $02 ; $47c9
	ld a, b ; $47cf
	ld [wCharSelectIsPartner], a ; $47d0
	wram_bank $07 ; $47d3
	ld hl, wCharPosX ; $47d9
	ld c, $10 ; $47dc
	call ClearMemory16 ; $47de
	wram_bank $06 ; $47e1
	ld hl, wCharPosX ; $47e7
	ld c, $10 ; $47ea
	call ClearMemory16 ; $47ec
	wram_bank $05 ; $47ef
	ld hl, wCharPosX ; $47f5
	ld c, $10 ; $47f8
	call ClearMemory16 ; $47fa
	wram_bank $04 ; $47fd
	ld hl, wCharPosX ; $4803
	ld c, $10 ; $4806
	call ClearMemory16 ; $4808
	farcall ResetMatchState ; $480b
	call ClearFrameTasks ; $480e
	xor a, a ; $4811
	ld [$cb4f], a ; $4812
	ld [wCharSelectHandedness], a ; $4815
	ld [$cb51], a ; $4818
	call DisableLCDSafely ; $481b
	call ClearFrameTasks ; $481e
	call SetupCharacterSelectScreen ; $4821
	call DrawCharacterSelectChars ; $4824
	ld a, $01 ; $4827
	ld hl, UpdateAnimatedTilesTask_38 ; $4829
	call RegisterFrameTask ; $482c
	ld a, $01 ; $482f
	ld hl, DrawCharacterSelectChars ; $4831
	call RegisterFrameTask ; $4834
	ld a, $01 ; $4837
	ld hl, DrawCharacterSelectCursor ; $4839
	call RegisterFrameTask ; $483c
	call EnableLCD ; $483f
	script_fade_in $08 ; $4842
	call WaitFadeEnd ; $4847
	ld hl, rIE ; $484a
	res 2, [hl] ; $484d
	ld a, $01 ; $484f
	ld hl, TickMenuBgScrollTask_38 ; $4851
	call RegisterFrameTask ; $4854
.redraw:
	ldh a, [hInputPressed] ; $4857
	ld [wMenuInputPressed], a ; $4859
	ld b, $02 ; $485c
	ld c, $01 ; $485e
	call MoveMenuCursorBox ; $4860
	or a, a ; $4863
	jr z, .inputLoop ; $4864
	call RefreshCharacterSelectHighlight ; $4866
.inputLoop:
	call AdvanceFrame ; $4869
	ldh a, [hInputPressed] ; $486c
	bit PADB_A, a ; $486e
	jr nz, .confirm ; $4870
	bit 1, a ; $4872
	jr nz, .cancel ; $4874
	bit 3, a ; $4876
	jr nz, .viewStats ; $4878
	jr .redraw ; $487a
.confirm:
	sound $5f ; $487c
	ld c, $10 ; $487e
	call BeginFadeOut ; $4880
	call WaitFadeEnd ; $4883
	ld c, $02 ; $4886
	call GetMenuCursorLinearIndex ; $4888
	push af ; $488b
	wram_bank $02 ; $488c
	ld a, [wCharSelectHandedness] ; $4892
	ld b, a ; $4895
	ld a, [wCharSelectIsPartner] ; $4896
	add a, a ; $4899
	ld c, a ; $489a
	pop af ; $489b
	add a, c ; $489c
	push af ; $489d
	ld d, a ; $489e
	ld a, [wStoryCharacterSlot] ; $489f
	farcall InitPlayerRecordFromTemplate ; $48a2
	push af ; $48a5
	ld hl, wStoryModeNameOfMainCharacter ; $48a6
	ld a, [wStoryCharacterSlot] ; $48a9
	or a, a ; $48ac
	jr z, .finish ; $48ad
	ld l, $40 ; $48af
.finish:
	ld a, l ; $48b1
	add a, $0e ; $48b2
	ld l, a ; $48b4
	ld a, h ; $48b5
	adc a, $00 ; $48b6
	ld h, a ; $48b8
	pop af ; $48b9
	ld a, [wCharSelectHandedness] ; $48ba
	ld [hl], a ; $48bd
	pop af ; $48be
	push af ; $48bf
	call ClearFrameTasks ; $48c0
	ld hl, rIE ; $48c3
	set 2, [hl] ; $48c6
	call DisableLCDSafely ; $48c8
	farcall LoadMenuFontGfx ; $48cb
	call EnableLCD ; $48ce
	pop af ; $48d1
	ret ; $48d2
.cancel:
	sound $62 ; $48d3
	ld c, $10 ; $48d5
	call BeginFadeOut ; $48d7
	call WaitFadeEnd ; $48da
	call ClearFrameTasks ; $48dd
	ld hl, rIE ; $48e0
	set 2, [hl] ; $48e3
	call DisableLCDSafely ; $48e5
	farcall LoadMenuFontGfx ; $48e8
	call EnableLCD ; $48eb
	ld a, $ff ; $48ee
	ret ; $48f0
.viewStats:
	sound $5e ; $48f1
	ldh a, [hWramBank] ; $48f3
	push af ; $48f5
	wram_bank $02 ; $48f6
	ld a, [wCharSelectHandedness] ; $48fc
	xor a, $01 ; $48ff
	ld [wCharSelectHandedness], a ; $4901
	pop af ; $4904
	wram_bank ; $4905
	jp .redraw ; $4909
	ld c, $02 ; $490c
	call GetMenuCursorLinearIndex ; $490e
	add a, a ; $4911
	ld hl, Data_38_4924 ; $4912
	add a, l ; $4915
	ld l, a ; $4916
	jr nc, .done ; $4917
	inc h ; $4919
.done:
	ld a, [hl+] ; $491a
	ld d, [hl] ; $491b
	ld e, a ; $491c
	ld bc, $3018 ; $491d
	call DrawSelectedOptionBox ; $4920
	ret ; $4923
Data_38_4924:
	; $4924, 8 bytes (bytes:8)
	db $20, $08, $20, $68, $40, $08, $40, $68 ; 0x00
LoadCharSelectCharPalettes:
	ld b, $04 ; $492c
	ld c, $0b ; $492e
	farcall LoadIndexedPalette ; $4930
	ld b, $05 ; $4933
	ld c, $0b ; $4935
	farcall LoadIndexedPalette ; $4937
	ld b, $06 ; $493a
	ld c, $0b ; $493c
	farcall LoadIndexedPalette ; $493e
	ld b, $07 ; $4941
	ld c, $0b ; $4943
	farcall LoadIndexedPalette ; $4945
	ret ; $4948
LoadHighlightedCharPalette:
	ld c, $02 ; $4949
	call GetMenuCursorLinearIndex ; $494b
	ld b, a ; $494e
	ldh a, [hWramBank] ; $494f
	push af ; $4951
	wram_bank $02 ; $4952
	ld a, [wCharSelectIsPartner] ; $4958
	ld c, a ; $495b
	pop af ; $495c
	wram_bank ; $495d
	ld a, c ; $4961
	add a, a ; $4962
	add a, b ; $4963
	ld b, a ; $4964
	ld d, $04 ; $4965
	add a, d ; $4967
	ld d, a ; $4968
	ld a, b ; $4969
	farcall GetCharPaletteIndex ; $496a
	farcall LoadIndexedPalette_18 ; $496d
	ret ; $4970
Data_38_4971:
	; $4971, 4 bytes (bytes:4)
	db $03, $01, $02, $00 ; 0x00
SetupCharacterSelectScreen:
	xor a, a ; $4975
	ldh [hScrollX], a ; $4976
	ldh [hScrollY], a ; $4978
	wram_bank $02 ; $497a
	xor a, a ; $4980
	ld [$cb4f], a ; $4981
	ld [wCharSelectHandedness], a ; $4984
	ld [$cb51], a ; $4987
	ld [wCameraX], a ; $498a
	ld [wCameraX + 1], a ; $498d
	ld [wCameraY], a ; $4990
	ld [wCameraY + 1], a ; $4993
	ld a, $90 ; $4996
	ldh [rWY], a ; $4998
	call ClearSpriteQueue ; $499a
	ld a, $02 ; $499d
	ld [wOnCourtCharCount], a ; $499f
	farcall InitActorEngine ; $49a2
	ld b, $02 ; $49a5
	ld c, $00 ; $49a7
	call SetMenuCursorFromLinearIndex ; $49a9
	farcall LoadMenuFontGfx ; $49ac
	ld c, $05 ; $49af
	farcall LoadScreenAssetRecord ; $49b1
	call LoadCharSelectCharPalettes ; $49b4
	farcall ResetTextWindowState ; $49b7
	ld b, $11 ; $49ba
	ld c, $10 ; $49bc
	ld de, $9000 ; $49be
	farcall LoadCompressedTileBlock ; $49c1
	wram_bank $05 ; $49c4
	ld a, $03 ; $49ca
	ld [wShadowTilemapBank], a ; $49cc
	ld a, $00 ; $49cf
	ld [wWindowTileAttr], a ; $49d1
	ld d, $00 ; $49d4
	ld e, $0f ; $49d6
	ld b, $14 ; $49d8
	ld c, $03 ; $49da
	farcall CreateWindowFromScreenRect ; $49dc
	farcall DrawTextWindowFrame ; $49df
	farcall RedrawWindowRows ; $49e2
	ld d, $00 ; $49e5
	ld e, $02 ; $49e7
	ld b, $14 ; $49e9
	ld c, $03 ; $49eb
	farcall CreateWindowFromScreenRect ; $49ed
	farcall DrawTextWindowFrame ; $49f0
	farcall RedrawWindowRows ; $49f3
	farcall PrepareGlyphBuffer ; $49f6
	call InitCharacterSelectChars ; $49f9
	call ReloadSelectedCharGfx ; $49fc
	call LoadHighlightedCharPalette ; $49ff
	call SetCharSelectAnimations ; $4a02
	call DrawCharacterSelectPrompt ; $4a05
	farcall UploadGlyphBuffer ; $4a08
	ld a, $00 ; $4a0b
	farcall LoadCharMugshotToBuffer ; $4a0d
	ld de, $b200 ; $4a10
	farcall CopyMugshotBufferToVram ; $4a13
	ld a, $01 ; $4a16
	farcall LoadCharMugshotToBuffer ; $4a18
	ld de, $b300 ; $4a1b
	farcall CopyMugshotBufferToVram ; $4a1e
	wram_bank $02 ; $4a21
	ld a, [wCharSelectIsPartner] ; $4a27
	or a, a ; $4a2a
	jr z, Label_38_4a61 ; $4a2b
	ld a, $02 ; $4a2d
	farcall LoadCharMugshotToBuffer ; $4a2f
	ld de, $b200 ; $4a32
	farcall CopyMugshotBufferToVram ; $4a35
	ld a, $03 ; $4a38
	farcall LoadCharMugshotToBuffer ; $4a3a
	ld de, $b300 ; $4a3d
	farcall CopyMugshotBufferToVram ; $4a40
	wram_bank $03 ; $4a43
	ld b, $03 ; $4a49
	ld c, $03 ; $4a4b
	ld de, $d506 ; $4a4d
	ld h, $0e ; $4a50
	farcall FillTilemapRect ; $4a52
	ld b, $03 ; $4a55
	ld c, $03 ; $4a57
	ld de, $d50e ; $4a59
	ld h, $0f ; $4a5c
	farcall FillTilemapRect ; $4a5e
Label_38_4a61:
	ld b, $13 ; $4a61
	ld c, $04 ; $4a63
	ld de, $8000 ; $4a65
	farcall LoadCompressedTileBlock ; $4a68
	ld b, $08 ; $4a6b
	ld c, $0c ; $4a6d
	farcall LoadIndexedPalette ; $4a6f
	farcall QueueWram3MapToVRAM ; $4a72
	wram_bank $02 ; $4a75
	xor a, a ; $4a7b
	ld [$cb4f], a ; $4a7c
	ld [$cb51], a ; $4a7f
	ld [wCharSelectHandedness], a ; $4a82
	farcall InitMenuBgScroll ; $4a85
	ld b, $01 ; $4a88
	ld c, $01 ; $4a8a
	farcall LoadMenuSpritePalettePair ; $4a8c
	ld a, $10 ; $4a8f
	ld [$cb15], a ; $4a91
	ld [$cb16], a ; $4a94
	ld b, $48 ; $4a97
	ld c, $14 ; $4a99
	ld de, $8100 ; $4a9b
	farcall LoadCompressedTileBlock ; $4a9e
	call LoadCharSelectCharPalettes ; $4aa1
	call LoadHighlightedCharPalette ; $4aa4
	call SetCharSelectAnimations ; $4aa7
	call ReloadSelectedCharGfx ; $4aaa
	ret ; $4aad
RefreshCharacterSelectHighlight:
	sound $5e ; $4aae
	call LoadCharSelectCharPalettes ; $4ab0
	call LoadHighlightedCharPalette ; $4ab3
	call SetCharSelectAnimations ; $4ab6
	call ReloadSelectedCharGfx ; $4ab9
	ldh a, [hWramBank] ; $4abc
	push af ; $4abe
	wram_bank $02 ; $4abf
	xor a, a ; $4ac5
	ld [$cb51], a ; $4ac6
	pop af ; $4ac9
	wram_bank ; $4aca
	ret ; $4ace
DrawCharacterSelectPrompt:
	push af ; $4acf
	push bc ; $4ad0
	push de ; $4ad1
	push hl ; $4ad2
	ldh a, [hWramBank] ; $4ad3
	push af ; $4ad5
	wram_bank $02 ; $4ad6
	ld a, [wCharSelectIsPartner] ; $4adc
	or a, a ; $4adf
	jr nz, Label_38_4af5 ; $4ae0
	wram_bank $03 ; $4ae2
	ld hl, $0075 ; $4ae8
	ld de, $d061 ; $4aeb
	ld c, $12 ; $4aee
	farcall RenderProportionalTextAt ; $4af0
	jr Label_38_4b06 ; $4af3
Label_38_4af5:
	wram_bank $03 ; $4af5
	ld hl, $0077 ; $4afb
	ld de, $d062 ; $4afe
	ld c, $12 ; $4b01
	farcall RenderProportionalTextAt ; $4b03
Label_38_4b06:
	wram_bank $03 ; $4b06
	ld hl, $0076 ; $4b0c
	ld de, $d201 ; $4b0f
	ld c, $12 ; $4b12
	farcall RenderProportionalTextAt ; $4b14
	pop af ; $4b17
	wram_bank ; $4b18
	pop hl ; $4b1c
	pop de ; $4b1d
	pop bc ; $4b1e
	pop af ; $4b1f
	ret ; $4b20
InitCharacterSelectChars:
	wram_bank $07 ; $4b21
	ld hl, wCharPosX ; $4b27
	ld c, $10 ; $4b2a
	call ClearMemory16 ; $4b2c
	wram_bank $06 ; $4b2f
	ld hl, wCharPosX ; $4b35
	ld c, $10 ; $4b38
	call ClearMemory16 ; $4b3a
	wram_bank $05 ; $4b3d
	ld hl, wCharPosX ; $4b43
	ld c, $10 ; $4b46
	call ClearMemory16 ; $4b48
	wram_bank $04 ; $4b4b
	ld hl, wCharPosX ; $4b51
	ld c, $10 ; $4b54
	call ClearMemory16 ; $4b56
	ld a, $00 ; $4b59
	farcall GetCharPaletteIndex ; $4b5b
	ld e, a ; $4b5e
	ld d, $00 ; $4b5f
	wram_bank $04 ; $4b61
	ld a, $00 ; $4b67
	farcall InitChar ; $4b69
	ld a, $01 ; $4b6c
	farcall GetCharPaletteIndex ; $4b6e
	ld e, a ; $4b71
	ld d, $01 ; $4b72
	wram_bank $05 ; $4b74
	ld a, $01 ; $4b7a
	farcall InitChar ; $4b7c
	ld a, $02 ; $4b7f
	farcall GetCharPaletteIndex ; $4b81
	ld e, a ; $4b84
	ld d, $02 ; $4b85
	wram_bank $06 ; $4b87
	ld a, $02 ; $4b8d
	farcall InitChar ; $4b8f
	ld a, $03 ; $4b92
	farcall GetCharPaletteIndex ; $4b94
	ld e, a ; $4b97
	ld d, $03 ; $4b98
	wram_bank $07 ; $4b9a
	ld a, $03 ; $4ba0
	farcall InitChar ; $4ba2
	wram_bank $04 ; $4ba5
	ret ; $4bab
DrawCharacterSelectChars:
	wram_bank $04 ; $4bac
	ld hl, wCharPosX ; $4bb2
	call UpdateCharSelectCharSprite ; $4bb5
	ld a, $58 ; $4bb8
	ld [wCharSpriteSlot + 2], a ; $4bba
	ld a, $20 ; $4bbd
	ld [wCharSpriteSlot + 3], a ; $4bbf
	wram_bank $05 ; $4bc2
	ld hl, wCharPosX ; $4bc8
	call UpdateCharSelectCharSprite ; $4bcb
	ld a, $58 ; $4bce
	ld [wCharSpriteSlot + 2], a ; $4bd0
	ld a, $61 ; $4bd3
	ld [wCharSpriteSlot + 3], a ; $4bd5
	wram_bank $06 ; $4bd8
	ld hl, wCharPosX ; $4bde
	call UpdateCharSelectCharSprite ; $4be1
	ld a, $c8 ; $4be4
	ld [wCharSpriteSlot + 2], a ; $4be6
	ld a, $c8 ; $4be9
	ld [wCharSpriteSlot + 3], a ; $4beb
	wram_bank $07 ; $4bee
	ld hl, wCharPosX ; $4bf4
	call UpdateCharSelectCharSprite ; $4bf7
	ld a, $c8 ; $4bfa
	ld [wCharSpriteSlot + 2], a ; $4bfc
	ld a, $c8 ; $4bff
	ld [wCharSpriteSlot + 3], a ; $4c01
	wram_bank $04 ; $4c04
	ldh a, [hWramBank] ; $4c0a
	push af ; $4c0c
	wram_bank $02 ; $4c0d
	ld a, [wCharSelectIsPartner] ; $4c13
	ld b, a ; $4c16
	pop af ; $4c17
	wram_bank ; $4c18
	ld a, b ; $4c1c
	or a, a ; $4c1d
	jr z, Label_38_4c66 ; $4c1e
	wram_bank $04 ; $4c20
	ld a, $c8 ; $4c26
	ld [wCharSpriteSlot + 2], a ; $4c28
	ld a, $c8 ; $4c2b
	ld [wCharSpriteSlot + 3], a ; $4c2d
	wram_bank $05 ; $4c30
	ld a, $c8 ; $4c36
	ld [wCharSpriteSlot + 2], a ; $4c38
	ld a, $c8 ; $4c3b
	ld [wCharSpriteSlot + 3], a ; $4c3d
	wram_bank $06 ; $4c40
	ld a, $58 ; $4c46
	ld [wCharSpriteSlot + 2], a ; $4c48
	ld a, $20 ; $4c4b
	ld [wCharSpriteSlot + 3], a ; $4c4d
	wram_bank $07 ; $4c50
	ld a, $58 ; $4c56
	ld [wCharSpriteSlot + 2], a ; $4c58
	ld a, $61 ; $4c5b
	ld [wCharSpriteSlot + 3], a ; $4c5d
	wram_bank $04 ; $4c60
Label_38_4c66:
	ldh a, [hWramBank] ; $4c66
	push af ; $4c68
	wram_bank $02 ; $4c69
	ld a, [wCharSelectHandedness] ; $4c6f
	ld c, a ; $4c72
	pop af ; $4c73
	wram_bank ; $4c74
	ld a, c ; $4c78
	or a, a ; $4c79
	jr z, Label_38_4ca8 ; $4c7a
	wram_bank $04 ; $4c7c
	ld hl, wCharSpriteSlot + 1 ; $4c82
	set 5, [hl] ; $4c85
	wram_bank $05 ; $4c87
	ld hl, wCharSpriteSlot + 1 ; $4c8d
	set 5, [hl] ; $4c90
	wram_bank $06 ; $4c92
	ld hl, wCharSpriteSlot + 1 ; $4c98
	set 5, [hl] ; $4c9b
	wram_bank $07 ; $4c9d
	ld hl, wCharSpriteSlot + 1 ; $4ca3
	set 5, [hl] ; $4ca6
Label_38_4ca8:
	wram_bank $04 ; $4ca8
	ld hl, wCharSpriteSlot ; $4cae
	farcall DrawCharSprite ; $4cb1
	wram_bank $05 ; $4cb4
	ld hl, wCharSpriteSlot ; $4cba
	farcall DrawCharSprite ; $4cbd
	wram_bank $06 ; $4cc0
	ld hl, wCharSpriteSlot ; $4cc6
	farcall DrawCharSprite ; $4cc9
	wram_bank $07 ; $4ccc
	ld hl, wCharSpriteSlot ; $4cd2
	farcall DrawCharSprite ; $4cd5
	wram_bank $04 ; $4cd8
	call TickCharSelectIdleAnim ; $4cde
	ret ; $4ce1
UpdateCharSelectCharSprite:
	ld c, l ; $4ce2
	ld b, h ; $4ce3
	ld hl, $0022 ; $4ce4
	add hl, bc ; $4ce7
	ld a, [hl] ; $4ce8
	and a, a ; $4ce9
	ret z ; $4cea
	ld l, c ; $4ceb
	ld h, b ; $4cec
	push hl ; $4ced
	ld de, $df00 ; $4cee
	ld c, $08 ; $4cf1
	call CopyMemoryFast ; $4cf3
	farcall EaseCharFacing ; $4cf6
	farcall StepCharAnimation ; $4cf9
	ld d, $02 ; $4cfc
	ld a, d ; $4cfe
	ld [$df32], a ; $4cff
	push de ; $4d02
	farcall ReloadCharFacingTiles ; $4d03
	pop de ; $4d06
	farcall BuildCharSpriteSlots ; $4d07
	pop de ; $4d0a
	ld hl, $df00 ; $4d0b
	ld c, $06 ; $4d0e
	call CopyMemoryFast ; $4d10
	ret ; $4d13
SetCharSelectAnimations:
	wram_bank $04 ; $4d14
	ld d, $00 ; $4d1a
	farcall SetCharAnimation ; $4d1c
	wram_bank $05 ; $4d1f
	ld d, $00 ; $4d25
	farcall SetCharAnimation ; $4d27
	wram_bank $06 ; $4d2a
	ld d, $00 ; $4d30
	farcall SetCharAnimation ; $4d32
	wram_bank $07 ; $4d35
	ld d, $00 ; $4d3b
	farcall SetCharAnimation ; $4d3d
	call GetSelectedCharWramBank ; $4d40
	ld a, b ; $4d43
	wram_bank ; $4d44
	ld d, $05 ; $4d48
	farcall SetCharAnimation ; $4d4a
	wram_bank $04 ; $4d4d
	ldh a, [hWramBank] ; $4d53
	push af ; $4d55
	wram_bank $02 ; $4d56
	xor a, a ; $4d5c
	ld [$cb4f], a ; $4d5d
	pop af ; $4d60
	wram_bank ; $4d61
	ret ; $4d65
ReloadSelectedCharGfx:
	ld b, $0b ; $4d66
	ld c, $0b ; $4d68
	farcall LoadIndexedPalette ; $4d6a
	ld b, $0c ; $4d6d
	ld c, $0b ; $4d6f
	farcall LoadIndexedPalette ; $4d71
	ld b, $0d ; $4d74
	ld c, $0b ; $4d76
	farcall LoadIndexedPalette ; $4d78
	ld b, $0e ; $4d7b
	ld c, $0b ; $4d7d
	farcall LoadIndexedPalette ; $4d7f
	ld b, $0f ; $4d82
	ld c, $0b ; $4d84
	farcall LoadIndexedPalette ; $4d86
	call GetSelectedCharWramBank ; $4d89
	ld a, b ; $4d8c
	wram_bank ; $4d8d
	farcall ReloadCharFrameGfx ; $4d91
	wram_bank $04 ; $4d94
	ret ; $4d9a
TickCharSelectIdleAnim:
	call GetSelectedCharWramBank ; $4d9b
	ld a, b ; $4d9e
	wram_bank ; $4d9f
	ld bc, $df00 ; $4da3
	ld hl, $002e ; $4da6
	add hl, bc ; $4da9
	ld a, [hl] ; $4daa
	cp a, $01 ; $4dab
	jr nz, Label_38_4df9 ; $4dad
	ldh a, [hWramBank] ; $4daf
	push af ; $4db1
	wram_bank $02 ; $4db2
	ld a, [$cb4f] ; $4db8
	inc a ; $4dbb
	ld [$cb4f], a ; $4dbc
	ld d, a ; $4dbf
	pop af ; $4dc0
	wram_bank ; $4dc1
	ld a, d ; $4dc5
	and a, $1f ; $4dc6
	jr nz, Label_38_4df9 ; $4dc8
	ld d, $05 ; $4dca
	farcall SetCharAnimation ; $4dcc
	ldh a, [hWramBank] ; $4dcf
	push af ; $4dd1
	wram_bank $02 ; $4dd2
	ld a, [$cb51] ; $4dd8
	inc a ; $4ddb
	ld [$cb51], a ; $4ddc
	cp a, $0f ; $4ddf
	jr nz, Label_38_4df4 ; $4de1
	xor a, a ; $4de3
	ld [$cb51], a ; $4de4
	call GetSelectedCharWramBank ; $4de7
	ld a, b ; $4dea
	wram_bank ; $4deb
	ld d, $07 ; $4def
	farcall SetCharAnimation ; $4df1
Label_38_4df4:
	pop af ; $4df4
	wram_bank ; $4df5
Label_38_4df9:
	ret ; $4df9
GetSelectedCharWramBank:
	ld c, $02 ; $4dfa
	call GetMenuCursorLinearIndex ; $4dfc
	ld b, a ; $4dff
	ldh a, [hWramBank] ; $4e00
	push af ; $4e02
	wram_bank $02 ; $4e03
	ld a, [wCharSelectIsPartner] ; $4e09
	ld c, a ; $4e0c
	pop af ; $4e0d
	wram_bank ; $4e0e
	ld a, c ; $4e12
	add a, a ; $4e13
	add a, b ; $4e14
	ld hl, Data_38_4e1f ; $4e15
	add a, l ; $4e18
	ld l, a ; $4e19
	jr nc, .read ; $4e1a
	inc h ; $4e1c
.read:
	ld b, [hl] ; $4e1d
	ret ; $4e1e
Data_38_4e1f:
	; $4e1f, 4 bytes (bytes:4)
	db $04, $05, $06, $07 ; 0x00
DrawCharacterSelectCursor:
	ld c, $02 ; $4e23
	call GetMenuCursorLinearIndex ; $4e25
	add a, a ; $4e28
	ld hl, Data_38_4e4a ; $4e29
	add a, l ; $4e2c
	ld l, a ; $4e2d
	jr nc, Label_38_4e31 ; $4e2e
	inc h ; $4e30
Label_38_4e31:
	ld a, [hl+] ; $4e31
	ld d, [hl] ; $4e32
	ld e, a ; $4e33
	wram_bank $02 ; $4e34
	ld c, $00 ; $4e3a
	ld a, [wCharSelectHandedness] ; $4e3c
	or a, a ; $4e3f
	jr nz, Label_38_4e44 ; $4e40
	ld c, $02 ; $4e42
Label_38_4e44:
	ld b, $00 ; $4e44
	call QueueSprite ; $4e46
	ret ; $4e49
Data_38_4e4a:
	; $4e4a, 8 bytes (bytes:8)
	db $54, $2c, $54, $6d, $6d, $2c, $6d, $6d ; 0x00
TickMenuBgScrollTask_38:
	farcall TickMenuBgScroll ; $4e52
	ret ; $4e55
	ldh a, [hWramBank] ; $4e56
	push af ; $4e58
	wram_bank $03 ; $4e59
	pop af ; $4e5f
	wram_bank ; $4e60
	ret ; $4e64
RunExhibitionCharSelectScreen:
	sound $03 ; $4e65
	wram_bank $03 ; $4e67
	ld a, b ; $4e6d
	ld [$d813], a ; $4e6e
	ld a, $02 ; $4e71
	ld [$df00], a ; $4e73
	call DisableLCDSafely ; $4e76
	farcall LoadMenuFontGfx ; $4e79
	xor a, a ; $4e7c
	ld [$d81d], a ; $4e7d
	ld hl, $da00 ; $4e80
	ld bc, $0080 ; $4e83
	call ClearBytes ; $4e86
	call BuildCharUnlockFlags ; $4e89
	call SetupCharGridScreen ; $4e8c
	call EnableLCD ; $4e8f
	script_fade_in $10 ; $4e92
	call WaitFadeEnd ; $4e97
	ld hl, rIE ; $4e9a
	res 2, [hl] ; $4e9d
	ld a, $01 ; $4e9f
	ld hl, TickMenuBgScrollTask_38 ; $4ea1
	call RegisterFrameTask ; $4ea4
	call RefreshCharInfoPanel ; $4ea7
.frameLoop:
	call AdvanceFrame ; $4eaa
	ldh a, [hInputPressed] ; $4ead
	ld [wMenuInputPressed], a ; $4eaf
	wram_bank $03 ; $4eb2
	ld a, [$de00] ; $4eb8
	push de ; $4ebb
	push af ; $4ebc
	ld a, a ; $4ebd
	ld de, $0301 ; $4ebe
	call PrintDecimalByte ; $4ec1
	pop af ; $4ec4
	pop de ; $4ec5
	ld a, [$d824] ; $4ec6
	or a, a ; $4ec9
	jr z, .confirm ; $4eca
	call DrawCharGridCharSprites ; $4ecc
	call RunCpuDifficultySubmenu ; $4ecf
	ldh a, [hWramBank] ; $4ed2
	push af ; $4ed4
	jr .redraw ; $4ed5
.confirm:
	call HandleCharGridDpad ; $4ed7
	call HandleCharGridButtons ; $4eda
	xor a, a ; $4edd
	ld [wMenuInputPressed], a ; $4ede
	ldh [hInputPressed], a ; $4ee1
	ldh a, [hWramBank] ; $4ee3
	push af ; $4ee5
	wram_bank $03 ; $4ee6
	ld a, [$d814] ; $4eec
	cp a, $04 ; $4eef
	jr z, .cancel ; $4ef1
	call DrawCharGridCursorBox ; $4ef3
	call DrawCharGridCharSprites ; $4ef6
	call DrawCharGridScrollArrows ; $4ef9
	jr .redraw ; $4efc
.cancel:
	call DrawCharGridWaitBanner ; $4efe
.redraw:
	ld a, [$d815] ; $4f01
	ld b, a ; $4f04
	pop af ; $4f05
	wram_bank ; $4f06
	ld a, b ; $4f0a
	cp a, $01 ; $4f0b
	jr z, .finish ; $4f0d
	cp a, $02 ; $4f0f
	jr z, .done ; $4f11
	jr .frameLoop ; $4f13
.finish:
	ld c, $08 ; $4f15
	call BeginFadeOut ; $4f17
	call WaitFadeEnd ; $4f1a
	call ResolveSelectedCharIds ; $4f1d
	call InitMatchCharsFromSelection ; $4f20
	call ApplyStarFlagsToCharRecords ; $4f23
	call ApplyCpuDifficultyToCharRecords ; $4f26
	farcall InitDefaultMatchSettings ; $4f29
	call ClearFrameTasks ; $4f2c
	ld hl, rIE ; $4f2f
	set 2, [hl] ; $4f32
	xor a, a ; $4f34
	ret ; $4f35
.done:
	sound $62 ; $4f36
	ld c, $10 ; $4f38
	call BeginFadeOut ; $4f3a
	call WaitFadeEnd ; $4f3d
	call ClearFrameTasks ; $4f40
	ld hl, rIE ; $4f43
	set 2, [hl] ; $4f46
	ld a, $ff ; $4f48
	ret ; $4f4a
DrawCharGridCursorBox:
	ld c, $03 ; $4f4b
	call GetMenuCursorLinearIndex ; $4f4d
	add a, a ; $4f50
	ld hl, Data_38_4f63 ; $4f51
	add a, l ; $4f54
	ld l, a ; $4f55
	jr nc, Label_38_4f59 ; $4f56
	inc h ; $4f58
Label_38_4f59:
	ld a, [hl+] ; $4f59
	ld d, [hl] ; $4f5a
	ld e, a ; $4f5b
	ld bc, $1008 ; $4f5c
	call DrawSelectedOptionBox ; $4f5f
	ret ; $4f62
Data_38_4f63:
	; $4f63, 12 bytes (bytes:12)
	db $30, $09, $30, $21, $30, $39, $4a, $09, $4a, $21, $4a, $39 ; 0x00
SetupCharGridScreen:
	xor a, a ; $4f6f
	ldh [hScrollX], a ; $4f70
	ldh [hScrollY], a ; $4f72
	ld [wCameraX], a ; $4f74
	ld [wCameraX + 1], a ; $4f77
	ld [wCameraY], a ; $4f7a
	ld [wCameraY + 1], a ; $4f7d
	call BuildCreatedCharRecords ; $4f80
	ld b, $03 ; $4f83
	ld c, $00 ; $4f85
	call SetMenuCursorFromLinearIndex ; $4f87
	wram_bank $01 ; $4f8a
	ld hl, Lz_38_50a7 ; $4f90
	ld de, $d000 ; $4f93
	call DecompressData ; $4f96
	ld hl, $d000 ; $4f99
	ld de, $a100 ; $4f9c
	ld c, $08 ; $4f9f
	call QueueVRAMCopy ; $4fa1
	ld hl, Lz_38_50f1 ; $4fa4
	ld de, $0901 ; $4fa7
	call LoadPalettesMasterOnly ; $4faa
	wram_bank $01 ; $4fad
	ld hl, Lz_38_50f9 ; $4fb3
	ld de, $d000 ; $4fb6
	call DecompressData ; $4fb9
	ld hl, $d000 ; $4fbc
	ld de, $a200 ; $4fbf
	ld c, $10 ; $4fc2
	call QueueVRAMCopy ; $4fc4
	ld c, $01 ; $4fc7
	farcall LoadScreenAssetRecord ; $4fc9
	farcall ResetTextWindowState ; $4fcc
	wram_bank $05 ; $4fcf
	ld a, $03 ; $4fd5
	ld [wShadowTilemapBank], a ; $4fd7
	ld a, $00 ; $4fda
	ld [wWindowTileAttr], a ; $4fdc
	ld d, $00 ; $4fdf
	ld e, $02 ; $4fe1
	ld b, $14 ; $4fe3
	ld c, $03 ; $4fe5
	farcall CreateWindowFromScreenRect ; $4fe7
	farcall DrawTextWindowFrame ; $4fea
	farcall RedrawWindowRows ; $4fed
	ld d, $00 ; $4ff0
	ld e, $0c ; $4ff2
	ld b, $14 ; $4ff4
	ld c, $06 ; $4ff6
	farcall CreateWindowFromScreenRect ; $4ff8
	farcall DrawTextWindowFrame ; $4ffb
	farcall RedrawWindowRows ; $4ffe
	ld b, $11 ; $5001
	ld c, $10 ; $5003
	ld de, $9000 ; $5005
	farcall LoadCompressedTileBlock ; $5008
	ld b, $15 ; $500b
	ld c, $10 ; $500d
	ld de, $9100 ; $500f
	farcall LoadCompressedTileBlock ; $5012
	ld b, $75 ; $5015
	ld c, $14 ; $5017
	ld de, $a500 ; $5019
	farcall LoadCompressedTileBlock ; $501c
	ld b, $79 ; $501f
	ld c, $14 ; $5021
	ld de, $a640 ; $5023
	farcall LoadCompressedTileBlock ; $5026
	ld de, $8000 ; $5029
	call LoadAllCharPortraitTiles ; $502c
	ld de, $a800 ; $502f
	call LoadAllCharPortraitTiles ; $5032
	call InitCharGridState ; $5035
	call DrawCharGridSlotPrompt ; $5038
	call DrawCharGridSlotIcons ; $503b
	farcall QueueWram3MapToVRAM ; $503e
	ld de, $a000 ; $5041
	farcall LoadFixedTileBlockAndPalette ; $5044
	ld hl, Data_38_507f ; $5047
	ld de, $0b05 ; $504a
	call LoadPalettesMasterOnly ; $504d
	ld c, $0b ; $5050
	ld b, $0a ; $5052
	farcall LoadIndexedPalette ; $5054
	farcall InitMenuBgScroll ; $5057
	ld b, $01 ; $505a
	ld c, $01 ; $505c
	farcall LoadMenuSpritePalettePair ; $505e
	ld a, $30 ; $5061
	ld [$cb15], a ; $5063
	ld [$cb16], a ; $5066
	ld a, $09 ; $5069
	ld [$cb17], a ; $506b
	ld [$cb18], a ; $506e
	ld b, $64 ; $5071
	ld c, $14 ; $5073
	ld de, $a300 ; $5075
	farcall LoadCompressedTileBlock ; $5078
	farcall InitDefaultMatchSettings ; $507b
	ret ; $507e
Data_38_507f:
	; $507f, 40 bytes (bytes:16)
	db $5f, $01, $ff, $6b, $40, $1e, $00, $00, $5f, $01, $ff, $6b, $5c, $50, $00, $00 ; 0x00
	db $5f, $01, $ff, $6b, $df, $01, $00, $00, $5f, $01, $ff, $6b, $1f, $00, $00, $00 ; 0x10
	db $5f, $01, $ff, $6b, $4a, $7d, $00, $00 ; 0x20
Lz_38_50a7:
	INCBIN "data/bank_038/d_50a7.bin" ; $50a7, 74 bytes
Lz_38_50f1:
	INCBIN "data/bank_038/d_50f1.bin" ; $50f1, 8 bytes
Lz_38_50f9:
	INCBIN "data/bank_038/d_50f9.bin" ; $50f9, 156 bytes
HandleCharGridDpad:
	ldh a, [hWramBank] ; $5195
	push af ; $5197
	wram_bank $03 ; $5198
	ld a, [$d814] ; $519e
	cp a, $04 ; $51a1
	jr z, .done ; $51a3
	ld a, [wMenuInputPressed] ; $51a5
	ldh a, [hInputPressed] ; $51a8
	bit PADB_RIGHT, a ; $51aa
	jr nz, .scrollDown ; $51ac
	bit 5, a ; $51ae
	jr nz, .moveLeft ; $51b0
	bit 6, a ; $51b2
	jr nz, .moveRight ; $51b4
	bit 7, a ; $51b6
	jr nz, .moveDown ; $51b8
	jr .done ; $51ba
.scrollDown:
	ld a, [$de00] ; $51bc
	inc a ; $51bf
	ld [$de00], a ; $51c0
	ld a, $02 ; $51c3
	ld [$df00], a ; $51c5
	call MoveCharGridCursorRight ; $51c8
	xor a, a ; $51cb
	ld [wMenuInputPressed], a ; $51cc
	jp .done ; $51cf
.moveLeft:
	ld a, $02 ; $51d2
	ld [$df00], a ; $51d4
	call MoveCharGridCursorLeft ; $51d7
	jr .done ; $51da
.moveRight:
	ld a, $02 ; $51dc
	ld [$df00], a ; $51de
	call MoveCharGridCursorUp ; $51e1
	jr .done ; $51e4
.moveDown:
	ld a, $02 ; $51e6
	ld [$df00], a ; $51e8
	call MoveCharGridCursorDown ; $51eb
.done:
	pop af ; $51ee
	wram_bank ; $51ef
	ret ; $51f3
MoveCharGridCursorUp:
	ld a, [wMenuCursorY] ; $51f4
	or a, a ; $51f7
	jr z, .prevPage ; $51f8
	dec a ; $51fa
	ld [wMenuCursorY], a ; $51fb
	sound $5e ; $51fe
	jr .refresh ; $5200
.prevPage:
	ld a, [$d811] ; $5202
	or a, a ; $5205
	ret z ; $5206
	dec a ; $5207
	cp a, $02 ; $5208
	jr nz, .beep ; $520a
	ld a, $03 ; $520c
	jr .storePage ; $520e
.beep:
	sound $5e ; $5210
.storePage:
	ld [$d811], a ; $5212
	call BuildVisiblePageSpriteList ; $5215
.refresh:
	call RefreshCharInfoPanel ; $5218
	ret ; $521b
MoveCharGridCursorDown:
	ld a, [wMenuCursorY] ; $521c
	inc a ; $521f
	cp a, $02 ; $5220
	jr z, .nextPage ; $5222
	ld [wMenuCursorY], a ; $5224
	sound $5e ; $5227
	jr .refresh ; $5229
.nextPage:
	ld a, [$d811] ; $522b
	cp a, $02 ; $522e
	jr nc, .checkLastPage ; $5230
	cp a, $01 ; $5232
	ret z ; $5234
	ld a, [$d823] ; $5235
	cp a, $07 ; $5238
	jr c, .refresh ; $523a
	ld a, $01 ; $523c
	ld [$d811], a ; $523e
	jr .storePage ; $5241
.checkLastPage:
	inc a ; $5243
	ld e, a ; $5244
	ld a, [$d812] ; $5245
	dec a ; $5248
	ld b, a ; $5249
	ld a, e ; $524a
	cp a, b ; $524b
	jr nz, .storePage ; $524c
	ld a, b ; $524e
	dec a ; $524f
	jr .beep ; $5250
.storePage:
	sound $5e ; $5252
.beep:
	ld [$d811], a ; $5254
	call BuildVisiblePageSpriteList ; $5257
.refresh:
	call RefreshCharInfoPanel ; $525a
	ret ; $525d
MoveCharGridCursorRight:
	ld a, [wMenuCursorX] ; $525e
	inc a ; $5261
	cp a, $03 ; $5262
	jr nz, Label_38_527f ; $5264
	ld a, [$d811] ; $5266
	cp a, $02 ; $5269
	jr c, Label_38_5279 ; $526b
	ld a, [$d811] ; $526d
	ld [$d81b], a ; $5270
	xor a, a ; $5273
	ld [$d811], a ; $5274
	jr Label_38_527e ; $5277
Label_38_5279:
	ld a, $03 ; $5279
	ld [$d811], a ; $527b
Label_38_527e:
	xor a, a ; $527e
Label_38_527f:
	ld [wMenuCursorX], a ; $527f
	call BuildVisiblePageSpriteList ; $5282
	call RefreshCharInfoPanel ; $5285
	sound $5e ; $5288
	ret ; $528a
MoveCharGridCursorLeft:
	ld a, [wMenuCursorX] ; $528b
	dec a ; $528e
	cp a, $ff ; $528f
	jr nz, Label_38_52b0 ; $5291
	ld a, [$d811] ; $5293
	cp a, $02 ; $5296
	jr c, Label_38_52a6 ; $5298
	ld a, [$d811] ; $529a
	ld [$d81b], a ; $529d
	xor a, a ; $52a0
	ld [$d811], a ; $52a1
	jr Label_38_52ab ; $52a4
Label_38_52a6:
	ld a, $03 ; $52a6
	ld [$d811], a ; $52a8
Label_38_52ab:
	call BuildVisiblePageSpriteList ; $52ab
	ld a, $02 ; $52ae
Label_38_52b0:
	ld [wMenuCursorX], a ; $52b0
	call RefreshCharInfoPanel ; $52b3
	sound $5e ; $52b6
	ret ; $52b8
HandleCharGridButtons:
	ld a, [wMenuInputPressed] ; $52b9
	bit PADB_A, a ; $52bc
	jr nz, .confirm ; $52be
	bit 1, a ; $52c0
	jr nz, .cancel ; $52c2
	bit 3, a ; $52c4
	jr nz, .checkStar ; $52c6
	ret ; $52c8
.confirm:
	call ConfirmCharGridSelection ; $52c9
	ret ; $52cc
.cancel:
	call CancelCharGridSelection ; $52cd
	ret ; $52d0
.checkStar:
	call GetGridSlotFromCursor ; $52d1
	ld b, a ; $52d4
	ld hl, $da00 ; $52d5
	add a, a ; $52d8
	add a, a ; $52d9
	add a, l ; $52da
	ld l, a ; $52db
	jr nc, .readCharId ; $52dc
	inc h ; $52de
.readCharId:
	ld a, [hl] ; $52df
	ld c, a ; $52e0
	call IsStarCharacter ; $52e1
	or a, a ; $52e4
	jr z, .done ; $52e5
	sound $5e ; $52e7
	ld a, [$df00] ; $52e9
	cp a, $02 ; $52ec
	jr z, .starChar ; $52ee
	xor a, $01 ; $52f0
	ld [$df00], a ; $52f2
	call RefreshCharInfoPanel ; $52f5
	ret ; $52f8
.starChar:
	ld a, $01 ; $52f9
	ld [$df00], a ; $52fb
	call RefreshCharInfoPanel ; $52fe
.done:
	ret ; $5301
ConfirmCharGridSelection:
	ldh a, [hWramBank] ; $5302
	push af ; $5304
	wram_bank $03 ; $5305
	ld a, [$d814] ; $530b
	ld a, [$d811] ; $530e
	ld c, a ; $5311
	ld a, [wMenuCursorX] ; $5312
	ld d, a ; $5315
	ld a, [wMenuCursorY] ; $5316
	ld e, a ; $5319
	call TestAndSetGridEntryTaken ; $531a
	or a, a ; $531d
	jr nz, .emptyCell ; $531e
	call GetGridSlotFromCursor ; $5320
	ld b, a ; $5323
	ld hl, $da00 ; $5324
	add a, a ; $5327
	add a, a ; $5328
	add a, l ; $5329
	ld l, a ; $532a
	jr nc, .readEntry ; $532b
	inc h ; $532d
.readEntry:
	ld a, [hl] ; $532e
	cp a, $ff ; $532f
	jr z, .emptyCell ; $5331
	ld c, a ; $5333
	ld a, [$d814] ; $5334
	ld hl, $d816 ; $5337
	add a, l ; $533a
	ld l, a ; $533b
	jr nc, .markTaken ; $533c
	inc h ; $533e
.markTaken:
	ld [hl], b ; $533f
	ld a, c ; $5340
	ld c, a ; $5341
	call IsStarCharacter ; $5342
	or a, a ; $5345
	jr z, .drawPortrait ; $5346
	ld a, [$df00] ; $5348
	cp a, $01 ; $534b
	jr nz, .drawPortrait ; $534d
	ld a, [$d814] ; $534f
	ld hl, $d834 ; $5352
	add a, l ; $5355
	ld l, a ; $5356
	jr nc, .markStar ; $5357
	inc h ; $5359
.markStar:
	ld a, $01 ; $535a
	ld [hl], a ; $535c
.drawPortrait:
	call GetGridSlotFromCursor ; $535d
	ld b, a ; $5360
	call DrawPlayerSlotPortrait ; $5361
	sound $5f ; $5364
	jr .advanceSlot ; $5366
.emptyCell:
	sound $62 ; $5368
	pop af ; $536a
	wram_bank ; $536b
	ret ; $536f
.advanceSlot:
	call BuildVisiblePageSpriteList ; $5370
	call GetGridSlotFromCursor ; $5373
	ld b, a ; $5376
	ld hl, $da00 ; $5377
	add a, a ; $537a
	add a, a ; $537b
	add a, l ; $537c
	ld l, a ; $537d
	jr nc, .allSlotsFilled ; $537e
	inc h ; $5380
.allSlotsFilled:
	ld a, [hl] ; $5381
	ld c, a ; $5382
	call NeedsCpuDifficultyPrompt ; $5383
	or a, a ; $5386
	jr z, .refresh ; $5387
	ld a, $01 ; $5389
	ld [$d824], a ; $538b
	jr .done ; $538e
.refresh:
	call AdvanceToNextPlayerSlot ; $5390
	cp a, $ff ; $5393
	jr nz, .done ; $5395
	ld a, $01 ; $5397
	ld [$d815], a ; $5399
.done:
	call DrawCharGridSlotPrompt ; $539c
	ld hl, $d040 ; $539f
	ld de, $9840 ; $53a2
	ld c, $04 ; $53a5
	call QueueVRAMCopy ; $53a7
	pop af ; $53aa
	wram_bank ; $53ab
	ret ; $53af
CancelCharGridSelection:
	ldh a, [hWramBank] ; $53b0
	push af ; $53b2
	wram_bank $03 ; $53b3
	call RetreatToPreviousPlayerSlot ; $53b9
	cp a, $ff ; $53bc
	jr nz, .clearSlot ; $53be
	ld a, $02 ; $53c0
	ld [$d815], a ; $53c2
	pop af ; $53c5
	wram_bank ; $53c6
	ret ; $53ca
.clearSlot:
	sound $62 ; $53cb
	ld hl, $d816 ; $53cd
	ld a, [$d814] ; $53d0
	add a, l ; $53d3
	ld l, a ; $53d4
	jr nc, .clearTaken ; $53d5
	inc h ; $53d7
.clearTaken:
	ld a, [hl] ; $53d8
	ld b, $00 ; $53d9
	ld [hl], b ; $53db
	ld hl, $da00 ; $53dc
	add a, a ; $53df
	add a, a ; $53e0
	add a, l ; $53e1
	ld l, a ; $53e2
	jr nc, .clearRecord ; $53e3
	inc h ; $53e5
.clearRecord:
	inc hl ; $53e6
	inc hl ; $53e7
	xor a, a ; $53e8
	ld [hl], a ; $53e9
	wram_bank $03 ; $53ea
	ld hl, $d830 ; $53f0
	ld a, [$d814] ; $53f3
	add a, l ; $53f6
	ld l, a ; $53f7
	jr nc, .refresh ; $53f8
	inc h ; $53fa
.refresh:
	xor a, a ; $53fb
	ld [hl], a ; $53fc
	ld hl, $d834 ; $53fd
	ld a, [$d814] ; $5400
	add a, l ; $5403
	ld l, a ; $5404
	jr nc, .done ; $5405
	inc h ; $5407
.done:
	xor a, a ; $5408
	ld [hl], a ; $5409
	call ClearPlayerSlotPortrait ; $540a
	call BuildVisiblePageSpriteList ; $540d
	call DrawCharGridSlotPrompt ; $5410
	ld hl, $d040 ; $5413
	ld de, $9840 ; $5416
	ld c, $04 ; $5419
	call QueueVRAMCopy ; $541b
	pop af ; $541e
	wram_bank ; $541f
	ret ; $5423
DrawCharGridSlotPrompt:
	wram_bank $03 ; $5424
	ld a, [$d814] ; $542a
	cp a, $ff ; $542d
	ret z ; $542f
	wram_bank $03 ; $5430
	ld de, $d041 ; $5436
	ld b, $12 ; $5439
	ld c, $01 ; $543b
	ld h, $03 ; $543d
	farcall FillTilemapRect ; $543f
	ld de, $d061 ; $5442
	ld b, $12 ; $5445
	ld c, $01 ; $5447
	ld h, $20 ; $5449
	farcall FillTilemapRect ; $544b
	ld a, [$d824] ; $544e
	or a, a ; $5451
	jr z, .promptFromTable ; $5452
	ld hl, $0095 ; $5454
	ld de, $d061 ; $5457
	ld c, $20 ; $545a
	farcall RenderTextToBuffer64 ; $545c
	ret ; $545f
.promptFromTable:
	ld hl, Data_38_5490 ; $5460
	ld a, [$d813] ; $5463
	cp a, $03 ; $5466
	jr z, .readEntry ; $5468
	cp a, $05 ; $546a
	jr z, .readEntry ; $546c
	ld hl, Data_38_5486 ; $546e
.readEntry:
	ld a, [$d814] ; $5471
	add a, a ; $5474
	add a, l ; $5475
	ld l, a ; $5476
	jr nc, .draw ; $5477
	inc h ; $5479
.draw:
	ld a, [hl+] ; $547a
	ld h, [hl] ; $547b
	ld l, a ; $547c
	ld de, $d061 ; $547d
	ld c, $20 ; $5480
	farcall RenderTextToBuffer64 ; $5482
	ret ; $5485
Data_38_5486:
	; $5486, 10 bytes (bytes:10)
	db $8e, $00, $8f, $00, $90, $00, $91, $00, $92, $00 ; 0x00
Data_38_5490:
	; $5490, 10 bytes (bytes:10)
	db $8e, $00, $8e, $00, $8e, $00, $8f, $00, $92, $00 ; 0x00
DrawCharGridWaitBanner:
	ld c, $20 ; $549a
	ld b, $0f ; $549c
	ld de, $0840 ; $549e
	farcall ApplySpriteWaveOffset ; $54a1
	ld hl, SpriteTemplate_38_54ab ; $54a4
	call QueueSpriteTemplate ; $54a7
	ret ; $54aa
SpriteTemplate_38_54ab:
	; $54ab, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
DrawCharGridScrollArrows:
	ldh a, [hWramBank] ; $54cc
	push af ; $54ce
	wram_bank $03 ; $54cf
	ld a, [$d814] ; $54d5
	cp a, $04 ; $54d8
	jr z, .done ; $54da
	ld de, $0245 ; $54dc
	ld c, $01 ; $54df
	call ApplySpriteBobOffsetX ; $54e1
	ld c, $10 ; $54e4
	ld b, $0f ; $54e6
	call QueueSprite ; $54e8
	ld de, $5045 ; $54eb
	ld c, $00 ; $54ee
	call ApplySpriteBobOffsetX ; $54f0
	ld c, $12 ; $54f3
	ld b, $0f ; $54f5
	call QueueSprite ; $54f7
	ld a, [$d811] ; $54fa
	or a, a ; $54fd
	jr z, .checkUpArrow ; $54fe
	cp a, $03 ; $5500
	jr z, .checkUpArrow ; $5502
	ld de, $2a25 ; $5504
	ld c, $01 ; $5507
	call ApplySpriteBobOffsetY ; $5509
	ld c, $14 ; $550c
	ld b, $0f ; $550e
	call QueueSprite ; $5510
.checkUpArrow:
	ld a, [$d811] ; $5513
	cp a, $01 ; $5516
	jr z, .done ; $5518
	or a, a ; $551a
	jr nz, .drawDownArrow ; $551b
	ld a, [$d823] ; $551d
	cp a, $07 ; $5520
	jr c, .done ; $5522
.drawDownArrow:
	ld a, [$d811] ; $5524
	ld b, a ; $5527
	ld a, [$d812] ; $5528
	dec a ; $552b
	dec a ; $552c
	cp a, b ; $552d
	jr z, .done ; $552e
	ld de, $2a63 ; $5530
	ld c, $00 ; $5533
	call ApplySpriteBobOffsetY ; $5535
	ld c, $16 ; $5538
	ld b, $0f ; $553a
	call QueueSprite ; $553c
.done:
	pop af ; $553f
	wram_bank ; $5540
	ret ; $5544
DrawCharGridCharSprites:
	ldh a, [hWramBank] ; $5545
	push af ; $5547
	wram_bank $03 ; $5548
	ld hl, $d800 ; $554e
	ld c, $00 ; $5551
.slotLoop:
	push hl ; $5553
	ld a, c ; $5554
	add a, a ; $5555
	ld hl, Data_38_557d ; $5556
	add a, l ; $5559
	ld l, a ; $555a
	jr nc, .readOffset ; $555b
	inc h ; $555d
.readOffset:
	ld a, [hl+] ; $555e
	ld d, [hl] ; $555f
	ld e, a ; $5560
	pop hl ; $5561
	push bc ; $5562
	ld b, [hl] ; $5563
	inc hl ; $5564
	ld c, [hl] ; $5565
	inc hl ; $5566
	ld a, b ; $5567
	cp a, $ff ; $5568
	jr z, .nextSlot ; $556a
	call QueueCharGridCharSprite ; $556c
.nextSlot:
	pop bc ; $556f
	ld a, c ; $5570
	inc a ; $5571
	ld c, a ; $5572
	cp a, $06 ; $5573
	jr nz, .slotLoop ; $5575
	pop af ; $5577
	wram_bank ; $5578
	ret ; $557c
Data_38_557d:
	; $557d, 12 bytes (bytes:12)
	db $33, $0e, $33, $26, $33, $3e, $4e, $0e, $4e, $26, $4e, $3e ; 0x00
QueueCharGridCharSprite:
	push af ; $5589
	push bc ; $558a
	push de ; $558b
	push hl ; $558c
	ld h, b ; $558d
	ld a, $02 ; $558e
	add a, c ; $5590
	ld b, a ; $5591
	ld a, h ; $5592
	add a, a ; $5593
	add a, a ; $5594
	ld c, a ; $5595
	push de ; $5596
	call QueueSprite ; $5597
	pop de ; $559a
	ld a, $08 ; $559b
	add a, d ; $559d
	ld d, a ; $559e
	ld a, $02 ; $559f
	add a, c ; $55a1
	ld c, a ; $55a2
	call QueueSprite ; $55a3
	pop hl ; $55a6
	pop de ; $55a7
	pop bc ; $55a8
	pop af ; $55a9
	ret ; $55aa
ClearPlayerSlotPortrait:
	call GetPlayerSlotBoxAddress ; $55ab
	ld d, b ; $55ae
	ld e, c ; $55af
	ld b, $02 ; $55b0
	ld c, $02 ; $55b2
	ld h, $00 ; $55b4
	push de ; $55b6
	farcall FillTilemapRect ; $55b7
	pop de ; $55ba
	ld b, $02 ; $55bb
	ld c, $02 ; $55bd
	ld hl, $0400 ; $55bf
	add hl, de ; $55c2
	ld d, h ; $55c3
	ld e, l ; $55c4
	ld h, $08 ; $55c5
	farcall FillTilemapRect ; $55c7
	call GetPlayerSlotBoxAddress ; $55ca
	ld hl, $001e ; $55cd
	add hl, bc ; $55d0
	xor a, a ; $55d1
	ld [hl+], a ; $55d2
	ld [hl], a ; $55d3
	ld a, [$d814] ; $55d4
	cp a, $02 ; $55d7
	jr nc, .slot0 ; $55d9
	ld hl, $d0c0 ; $55db
	ld de, $98c0 ; $55de
	ld c, $04 ; $55e1
	call QueueVRAMCopy ; $55e3
	ld hl, $d4c0 ; $55e6
	ld de, $b8c0 ; $55e9
	ld c, $04 ; $55ec
	call QueueVRAMCopy ; $55ee
	jr .done ; $55f1
.slot0:
	ld hl, $d120 ; $55f3
	ld de, $9920 ; $55f6
	ld c, $04 ; $55f9
	call QueueVRAMCopy ; $55fb
	ld hl, $d520 ; $55fe
	ld de, $b920 ; $5601
	ld c, $04 ; $5604
	call QueueVRAMCopy ; $5606
.done:
	ret ; $5609
Data_38_560a:
	; $560a, 8 bytes (bytes:8)
	db $ce, $d0, $d0, $d0, $2e, $d1, $30, $d1 ; 0x00
DrawPlayerSlotPortrait:
	ld hl, $da00 ; $5612
	ld a, b ; $5615
	add a, a ; $5616
	add a, a ; $5617
	add a, l ; $5618
	ld l, a ; $5619
	jr nc, .gotSource ; $561a
	inc h ; $561c
.gotSource:
	ld b, h ; $561d
	ld c, l ; $561e
	ld hl, $0000 ; $561f
	add hl, bc ; $5622
	ld d, [hl] ; $5623
	ld hl, $0001 ; $5624
	add hl, bc ; $5627
	ld e, [hl] ; $5628
	call GetPlayerSlotBoxAddress ; $5629
	ld h, b ; $562c
	ld l, c ; $562d
	ld b, d ; $562e
	ld c, e ; $562f
	ld d, h ; $5630
	ld e, l ; $5631
	dec c ; $5632
	call WriteCharPortraitTiles ; $5633
	call DrawPlayerSlotStarMark ; $5636
	call DrawPlayerSlotDifficultyMark ; $5639
	ld a, [$d814] ; $563c
	cp a, $02 ; $563f
	jr nc, .slot0 ; $5641
	ld hl, $d0c0 ; $5643
	ld de, $98c0 ; $5646
	ld c, $04 ; $5649
	call QueueVRAMCopy ; $564b
	ld hl, $d4c0 ; $564e
	ld de, $b8c0 ; $5651
	ld c, $04 ; $5654
	call QueueVRAMCopy ; $5656
	jr .done ; $5659
.slot0:
	ld hl, $d120 ; $565b
	ld de, $9920 ; $565e
	ld c, $04 ; $5661
	call QueueVRAMCopy ; $5663
	ld hl, $d520 ; $5666
	ld de, $b920 ; $5669
	ld c, $04 ; $566c
	call QueueVRAMCopy ; $566e
.done:
	ret ; $5671
Data_38_5672:
	; $5672, 8 bytes (bytes:8)
	db $ce, $d0, $d0, $d0, $2e, $d1, $30, $d1 ; 0x00
DrawPlayerSlotStarMark:
	ld a, [$d814] ; $567a
	ld hl, $d834 ; $567d
	add a, l ; $5680
	ld l, a ; $5681
	jr nc, Label_38_5685 ; $5682
	inc h ; $5684
Label_38_5685:
	ld a, [hl] ; $5685
	or a, a ; $5686
	ret z ; $5687
	call GetPlayerSlotBoxAddress ; $5688
	ld hl, $001f ; $568b
	add hl, bc ; $568e
	ld a, $32 ; $568f
	ld [hl], a ; $5691
	ret ; $5692
DrawPlayerSlotDifficultyMark:
	ld hl, $d830 ; $5693
	ld a, [$d814] ; $5696
	add a, l ; $5699
	ld l, a ; $569a
	jr nc, Label_38_569e ; $569b
	inc h ; $569d
Label_38_569e:
	ld a, [hl] ; $569e
	ld c, $33 ; $569f
	add a, c ; $56a1
	push af ; $56a2
	call GetPlayerSlotBoxAddress ; $56a3
	ld hl, $001e ; $56a6
	add hl, bc ; $56a9
	pop af ; $56aa
	ld [hl], a ; $56ab
Label_38_56ac:
	ret ; $56ac
GetPlayerSlotBoxAddress:
	ld a, [$d813] ; $56ad
	add a, a ; $56b0
	ld hl, SubHandlers_38_56c9 ; $56b1
	add a, l ; $56b4
	ld l, a ; $56b5
	jr nc, .readTable ; $56b6
	inc h ; $56b8
.readTable:
	ld a, [hl+] ; $56b9
	ld h, [hl] ; $56ba
	ld l, a ; $56bb
	ld a, [$d814] ; $56bc
	add a, a ; $56bf
	add a, l ; $56c0
	ld l, a ; $56c1
	jr nc, .readEntry ; $56c2
	inc h ; $56c4
.readEntry:
	ld a, [hl+] ; $56c5
	ld b, [hl] ; $56c6
	ld c, a ; $56c7
	ret ; $56c8
SubHandlers_38_56c9:
	; $56c9, 1 bytes (records:2)
	db $d5
Label_38_56ca:
	ld d, [hl] ; $56ca
	rst Rst18 ; $56cb
	ld d, [hl] ; $56cc
	jp hl ; $56cd
Data_38_56ce:
	; $56ce, 7 bytes (bytes:7)
	db $56, $f3, $56, $fd, $56, $07, $57 ; 0x00
	ret nc ; $56d5
	ret nc ; $56d6
	nop ; $56d7
	nop ; $56d8
	jr nc, Label_38_56ac ; $56d9
	nop ; $56db
	nop ; $56dc
	nop ; $56dd
	nop ; $56de
	call $d1d0 ; $56df
	ret nc ; $56e2
	dec l ; $56e3
	pop de ; $56e4
	ld sp, $00d1 ; $56e5
	nop ; $56e8
	ret nc ; $56e9
	ret nc ; $56ea
	nop ; $56eb
	nop ; $56ec
	nop ; $56ed
	nop ; $56ee
	nop ; $56ef
	nop ; $56f0
	nop ; $56f1
	nop ; $56f2
	nop ; $56f3
	nop ; $56f4
	nop ; $56f5
	nop ; $56f6
	jr nc, Label_38_56ca ; $56f7
	nop ; $56f9
	nop ; $56fa
	nop ; $56fb
	nop ; $56fc
	call $d1d0 ; $56fd
	ret nc ; $5700
	nop ; $5701
	nop ; $5702
	nop ; $5703
	nop ; $5704
	nop ; $5705
	nop ; $5706
	nop ; $5707
	nop ; $5708
	nop ; $5709
	nop ; $570a
	dec l ; $570b
	pop de ; $570c
	ld sp, $00d1 ; $570d
	nop ; $5710
	ret ; $5711
WriteCharPortraitTiles:
	ld a, b ; $5712
	add a, a ; $5713
	add a, a ; $5714
	ld b, a ; $5715
	ld a, $80 ; $5716
	add a, b ; $5718
	ld b, a ; $5719
	ld a, c ; $571a
	add a, $03 ; $571b
	or a, $08 ; $571d
	ld c, a ; $571f
	push de ; $5720
	ld a, b ; $5721
	ld [de], a ; $5722
	inc b ; $5723
	inc b ; $5724
	inc de ; $5725
	ld a, b ; $5726
	ld [de], a ; $5727
	ld hl, $001f ; $5728
	add hl, de ; $572b
	ld d, h ; $572c
	ld e, l ; $572d
	dec b ; $572e
	ld a, b ; $572f
	ld [de], a ; $5730
	inc b ; $5731
	inc b ; $5732
	inc de ; $5733
	ld a, b ; $5734
	ld [de], a ; $5735
	pop de ; $5736
	ld hl, $0400 ; $5737
	add hl, de ; $573a
	ld d, h ; $573b
	ld e, l ; $573c
	ld h, c ; $573d
	ld b, $02 ; $573e
	ld c, $02 ; $5740
	farcall FillTilemapRect ; $5742
	ret ; $5745
LoadAllCharPortraitTiles:
	xor a, a ; $5746
Label_38_5747:
	push af ; $5747
	push bc ; $5748
	push de ; $5749
	push hl ; $574a
	farcall LoadOnCourtCharTilesA ; $574b
	pop hl ; $574e
	pop de ; $574f
	pop bc ; $5750
	pop af ; $5751
	ld hl, $0040 ; $5752
	add hl, de ; $5755
	ld d, h ; $5756
	ld e, l ; $5757
	inc a ; $5758
	cp a, $20 ; $5759
	jr nz, Label_38_5747 ; $575b
	ret ; $575d
RefreshCharInfoPanel:
	push af ; $575e
	push bc ; $575f
	push de ; $5760
	push hl ; $5761
	ldh a, [hWramBank] ; $5762
	push af ; $5764
	wram_bank $03 ; $5765
	ld de, $d181 ; $576b
	ld b, $12 ; $576e
	ld c, $01 ; $5770
	ld h, $03 ; $5772
	farcall FillTilemapRect ; $5774
	ld de, $d1a1 ; $5777
	ld b, $12 ; $577a
	ld c, $04 ; $577c
	ld h, $20 ; $577e
	farcall FillTilemapRect ; $5780
	ld a, [$d814] ; $5783
	cp a, $04 ; $5786
	jr nz, .haveSlot ; $5788
	jr .done ; $578a
.haveSlot:
	call GetGridSlotFromCursor ; $578c
	ld d, a ; $578f
	ld c, a ; $5790
	add a, a ; $5791
	add a, a ; $5792
	ld hl, $da00 ; $5793
	add a, l ; $5796
	ld l, a ; $5797
	jr nc, .readSlot ; $5798
	inc h ; $579a
.readSlot:
	ld a, [hl] ; $579b
	cp a, $04 ; $579c
	jr nc, .namedChar ; $579e
	inc hl ; $57a0
	inc hl ; $57a1
	inc hl ; $57a2
	ld a, [hl] ; $57a3
	ld c, a ; $57a4
	call DrawCreatedCharStats ; $57a5
	jr .done ; $57a8
.namedChar:
	cp a, $ff ; $57aa
	jr z, .done ; $57ac
	ld c, a ; $57ae
	push bc ; $57af
	call DrawCharNameAndType ; $57b0
	pop bc ; $57b3
	call DrawCharSelectSlotLabel ; $57b4
.done:
	ld hl, $d180 ; $57b7
	ld de, $9980 ; $57ba
	ld c, $0a ; $57bd
	call QueueVRAMCopy ; $57bf
	ld hl, $d600 ; $57c2
	ld de, $ba00 ; $57c5
	ld c, $02 ; $57c8
	call QueueVRAMCopy ; $57ca
	pop af ; $57cd
	wram_bank ; $57ce
	pop hl ; $57d2
	pop de ; $57d3
	pop bc ; $57d4
	pop af ; $57d5
	ret ; $57d6
Data_38_57d7:
	; $57d7, 6 bytes (bytes:6)
	db $00, $02, $04, $01, $03, $05 ; 0x00
DrawCreatedCharStats:
	push af ; $57dd
	push bc ; $57de
	push de ; $57df
	push hl ; $57e0
	ldh a, [hWramBank] ; $57e1
	push af ; $57e3
	wram_bank $03 ; $57e4
	ld a, c ; $57ea
	ld de, $0020 ; $57eb
	ld hl, $d900 ; $57ee
Label_38_57f1:
	or a, a ; $57f1
	jr z, Label_38_57f8 ; $57f2
	add hl, de ; $57f4
	dec a ; $57f5
	jr Label_38_57f1 ; $57f6
Label_38_57f8:
	ld b, h ; $57f8
	ld c, l ; $57f9
	ld a, [hl] ; $57fa
	cp a, $ff ; $57fb
	jp z, Label_38_58b7 ; $57fd
	push af ; $5800
	push bc ; $5801
	push de ; $5802
	push hl ; $5803
	ld hl, $0007 ; $5804
	add hl, bc ; $5807
	ld de, $d1a3 ; $5808
	call CopyStringToTilemap ; $580b
	pop hl ; $580e
	pop de ; $580f
	pop bc ; $5810
	pop af ; $5811
	ld a, $4c ; $5812
	ld [$d1ab], a ; $5814
	ld a, $56 ; $5817
	ld [$d1ac], a ; $5819
	ld hl, $0002 ; $581c
	add hl, bc ; $581f
	ld l, [hl] ; $5820
	ld h, $00 ; $5821
	ld de, $d1ae ; $5823
	ld a, $02 ; $5826
	call DrawDecimalNumber ; $5828
	ld a, $1d ; $582b
	ld [$d1e2], a ; $582d
	ld a, $1e ; $5830
	ld [$d1e3], a ; $5832
	ld a, $1f ; $5835
	ld [$d1e4], a ; $5837
	ld hl, $0003 ; $583a
	add hl, bc ; $583d
	ld l, [hl] ; $583e
	ld h, $00 ; $583f
	ld de, $d1e7 ; $5841
	ld a, $02 ; $5844
	call DrawDecimalNumber ; $5846
	ld hl, $0004 ; $5849
	add hl, bc ; $584c
	ld l, [hl] ; $584d
	ld h, $00 ; $584e
	ld de, $d1ef ; $5850
	ld a, $02 ; $5853
	call DrawDecimalNumber ; $5855
	ld a, $14 ; $5858
	ld [$d1ea], a ; $585a
	ld a, $15 ; $585d
	ld [$d1eb], a ; $585f
	ld a, $16 ; $5862
	ld [$d1ec], a ; $5864
	ld a, $17 ; $5867
	ld [$d1ed], a ; $5869
	ld a, $18 ; $586c
	ld [$d202], a ; $586e
	ld a, $19 ; $5871
	ld [$d203], a ; $5873
	ld a, $1a ; $5876
	ld [$d204], a ; $5878
	ld a, $1b ; $587b
	ld [$d205], a ; $587d
	ld a, $1c ; $5880
	ld [$d206], a ; $5882
	ld hl, $0005 ; $5885
	add hl, bc ; $5888
	ld l, [hl] ; $5889
	ld h, $00 ; $588a
	ld de, $d207 ; $588c
	ld a, $02 ; $588f
	call DrawDecimalNumber ; $5891
	ld a, $10 ; $5894
	ld [$d20a], a ; $5896
	ld a, $11 ; $5899
	ld [$d20b], a ; $589b
	ld a, $12 ; $589e
	ld [$d20c], a ; $58a0
	ld a, $13 ; $58a3
	ld [$d20d], a ; $58a5
	ld hl, $0006 ; $58a8
	add hl, bc ; $58ab
	ld l, [hl] ; $58ac
	ld h, $00 ; $58ad
	ld de, $d20f ; $58af
	ld a, $02 ; $58b2
	call DrawDecimalNumber ; $58b4
Label_38_58b7:
	ld de, $d601 ; $58b7
	ld h, $00 ; $58ba
	ld b, $12 ; $58bc
	ld c, $01 ; $58be
	farcall FillTilemapRect ; $58c0
	pop af ; $58c3
	wram_bank ; $58c4
	pop hl ; $58c8
	pop de ; $58c9
	pop bc ; $58ca
	pop af ; $58cb
	ret ; $58cc
DrawCharNameAndType:
	push bc ; $58cd
	ld a, c ; $58ce
	ld hl, $001b ; $58cf
	add a, l ; $58d2
	ld l, a ; $58d3
	jr nc, Label_38_58d7 ; $58d4
	inc h ; $58d6
Label_38_58d7:
	ld de, $d1a6 ; $58d7
	ld c, $20 ; $58da
	farcall RenderTextToBuffer64 ; $58dc
	pop bc ; $58df
	ld a, c ; $58e0
	ld hl, Data_38_58fb ; $58e1
	add a, l ; $58e4
	ld l, a ; $58e5
	jr nc, Label_38_58e9 ; $58e6
	inc h ; $58e8
Label_38_58e9:
	ld a, [hl] ; $58e9
	ld hl, $0099 ; $58ea
	add a, l ; $58ed
	ld l, a ; $58ee
	jr nc, Label_38_58f2 ; $58ef
	inc h ; $58f1
Label_38_58f2:
	ld de, $d1e3 ; $58f2
	ld c, $20 ; $58f5
	farcall RenderTextToBuffer64 ; $58f7
	ret ; $58fa
Data_38_58fb:
	; $58fb, 32 bytes (bytes:16)
	db $00, $00, $00, $00, $04, $01, $02, $02, $00, $04, $00, $03, $02, $02, $01, $04 ; 0x00
	db $02, $04, $00, $03, $05, $05, $05, $02, $00, $04, $02, $01, $04, $00, $00, $01 ; 0x10
DrawCharSelectSlotLabel:
	ld a, [$d811] ; $591b
	cp a, $02 ; $591e
	jr nc, Label_38_597e ; $5920
	ld a, [$df00] ; $5922
	or a, a ; $5925
	jr nz, Label_38_5944 ; $5926
	ld hl, $d340 ; $5928
	ld de, $d204 ; $592b
	ld b, $05 ; $592e
	ld c, $01 ; $5930
	farcall CopyTilemapRect ; $5932
	ld hl, $d34a ; $5935
	ld de, $d209 ; $5938
	ld b, $05 ; $593b
	ld c, $01 ; $593d
	farcall CopyTilemapRect ; $593f
	jr Label_38_597e ; $5942
Label_38_5944:
	cp a, $01 ; $5944
	jr nz, Label_38_5964 ; $5946
	ld hl, $d340 ; $5948
	ld de, $d204 ; $594b
	ld b, $05 ; $594e
	ld c, $01 ; $5950
	farcall CopyTilemapRect ; $5952
	ld hl, $d345 ; $5955
	ld de, $d209 ; $5958
	ld b, $05 ; $595b
	ld c, $01 ; $595d
	farcall CopyTilemapRect ; $595f
	jr Label_38_597e ; $5962
Label_38_5964:
	ld hl, $d340 ; $5964
	ld de, $d204 ; $5967
	ld b, $05 ; $596a
	ld c, $01 ; $596c
	farcall CopyTilemapRect ; $596e
	ld hl, $d34f ; $5971
	ld de, $d209 ; $5974
	ld b, $08 ; $5977
	ld c, $01 ; $5979
	farcall CopyTilemapRect ; $597b
Label_38_597e:
	ld de, $d601 ; $597e
	ld h, $08 ; $5981
	ld b, $12 ; $5983
	ld c, $01 ; $5985
	farcall FillTilemapRect ; $5987
	ret ; $598a
DrawCharGridSlotIcons:
	ldh a, [hWramBank] ; $598b
	push af ; $598d
	wram_bank $03 ; $598e
	ld a, [$d813] ; $5994
	add a, a ; $5997
	ld hl, SubHandlers_38_59ba ; $5998
	add a, l ; $599b
	ld l, a ; $599c
	jr nc, Label_38_59a0 ; $599d
	inc h ; $599f
Label_38_59a0:
	ld a, [hl+] ; $59a0
	ld h, [hl] ; $59a1
	ld l, a ; $59a2
Label_38_59a3:
	ld a, [hl] ; $59a3
	or a, a ; $59a4
	jr z, Label_38_59b4 ; $59a5
	ld c, a ; $59a7
	inc hl ; $59a8
	ld b, [hl] ; $59a9
	inc hl ; $59aa
	ld a, [hl+] ; $59ab
	ld d, [hl] ; $59ac
	ld e, a ; $59ad
	inc hl ; $59ae
	call WriteSlotIconTiles ; $59af
	jr Label_38_59a3 ; $59b2
Label_38_59b4:
	pop af ; $59b4
	wram_bank ; $59b5
	ret ; $59b9
SubHandlers_38_59ba:
	; $59ba, 12 bytes (records:2)
	dw $59c6 ; record 0
	dw $59cf ; record 1
	dw $59e0 ; record 2
	dw $59e0 ; record 3
	dw $59e9 ; record 4
	dw $59e9 ; record 5
	ld bc, wDebugTextBuffer ; $59c6
	ret nc ; $59c9
	ld [bc], a ; $59ca
	ld bc, $d12c ; $59cb
	nop ; $59ce
	ld bc, wStoryCharacterSlot ; $59cf
	ret nc ; $59d2
	inc bc ; $59d3
	ld bc, $d0cf ; $59d4
	ld [bc], a ; $59d7
	ld bc, $d12b ; $59d8
	inc b ; $59db
	ld bc, $d12f ; $59dc
	nop ; $59df
	ld bc, wDebugTextBuffer ; $59e0
	ret nc ; $59e3
	ld [bc], a ; $59e4
	nop ; $59e5
	inc l ; $59e6
	pop de ; $59e7
	nop ; $59e8
	ld bc, wStoryCharacterSlot ; $59e9
	ret nc ; $59ec
	inc bc ; $59ed
	ld bc, $d0cf ; $59ee
	ld [bc], a ; $59f1
	nop ; $59f2
	dec hl ; $59f3
	pop de ; $59f4
	inc b ; $59f5
	ld bc, $d12f ; $59f6
	nop ; $59f9
WriteSlotIconTiles:
	push af ; $59fa
	push bc ; $59fb
	push de ; $59fc
	push hl ; $59fd
	ldh a, [hWramBank] ; $59fe
	push af ; $5a00
	wram_bank $03 ; $5a01
	dec c ; $5a07
	ld a, $50 ; $5a08
	add a, c ; $5a0a
	ld [de], a ; $5a0b
	inc de ; $5a0c
	ld a, $54 ; $5a0d
	add a, b ; $5a0f
	ld [de], a ; $5a10
	pop af ; $5a11
	wram_bank ; $5a12
	pop hl ; $5a16
	pop de ; $5a17
	pop bc ; $5a18
	pop af ; $5a19
	ret ; $5a1a
InitCharGridState:
	ldh a, [hWramBank] ; $5a1b
	push af ; $5a1d
	wram_bank $03 ; $5a1e
	ld a, $00 ; $5a24
	ld [$d811], a ; $5a26
	xor a, a ; $5a29
	ld [$d815], a ; $5a2a
	ld [$d81d], a ; $5a2d
	ld [$d824], a ; $5a30
	ld [$d825], a ; $5a33
	ld [$d826], a ; $5a36
	ld a, $ff ; $5a39
	ld [$d816], a ; $5a3b
	ld [$d817], a ; $5a3e
	ld [$d818], a ; $5a41
	ld [$d819], a ; $5a44
	ld [$d81f], a ; $5a47
	ld [$d820], a ; $5a4a
	ld a, [$d813] ; $5a4d
	cp a, $03 ; $5a50
	jr z, Label_38_5a5c ; $5a52
	cp a, $05 ; $5a54
	jr z, Label_38_5a5c ; $5a56
	ld a, $00 ; $5a58
	jr Label_38_5a5e ; $5a5a
Label_38_5a5c:
	ld a, $02 ; $5a5c
Label_38_5a5e:
	ld [$d814], a ; $5a5e
	ld hl, $d840 ; $5a61
	call BuildCharGridFromUnlockFlags ; $5a64
	call FillCharGridPaletteIndices ; $5a67
	call AddCreatedCharsToCharGrid ; $5a6a
	call CompactRosterGridEntries ; $5a6d
	call CompactStarGridEntries ; $5a70
	call CountCharGridEntries ; $5a73
	call SetCharGridPageCount ; $5a76
	call BuildVisiblePageSpriteList ; $5a79
	pop af ; $5a7c
	wram_bank ; $5a7d
	ret ; $5a81
BuildCharUnlockFlags:
	ldh a, [hWramBank] ; $5a82
	push af ; $5a84
	wram_bank $03 ; $5a85
	ld hl, $d840 ; $5a8b
	ld bc, $0028 ; $5a8e
	call ClearBytes ; $5a91
	ld b, $00 ; $5a94
.flagLoop:
	ld a, b ; $5a96
	add a, a ; $5a97
	ld hl, Data_38_5b17 ; $5a98
	add a, l ; $5a9b
	ld l, a ; $5a9c
	jr nc, .readFlagId ; $5a9d
	inc h ; $5a9f
.readFlagId:
	ld a, [hl+] ; $5aa0
	ld d, [hl] ; $5aa1
	ld e, a ; $5aa2
	ld a, d ; $5aa3
	and a, e ; $5aa4
	cp a, $ff ; $5aa5
	jr z, .markUnlocked ; $5aa7
	farcall TestSaveFlag ; $5aa9
	jr nz, .markUnlocked ; $5aac
	jr .nextFlag ; $5aae
.markUnlocked:
	ld hl, $d840 ; $5ab0
	ld a, b ; $5ab3
	add a, l ; $5ab4
	ld l, a ; $5ab5
	jr nc, .storeUnlocked ; $5ab6
	inc h ; $5ab8
.storeUnlocked:
	ld a, $01 ; $5ab9
	ld [hl], a ; $5abb
.nextFlag:
	ld a, b ; $5abc
	inc a ; $5abd
	ld b, a ; $5abe
	cp a, $09 ; $5abf
	jr nz, .flagLoop ; $5ac1
	ld hl, $d84f ; $5ac3
	ld a, $01 ; $5ac6
	ld [hl+], a ; $5ac8
	ld [hl+], a ; $5ac9
	ld [hl+], a ; $5aca
	ld a, [wCurrentStorySlot] ; $5acb
	push af ; $5ace
	ld c, $00 ; $5acf
.slotLoop:
	ld a, c ; $5ad1
	ld [wCurrentStorySlot], a ; $5ad2
	farcall CheckStorySlot ; $5ad5
	push bc ; $5ad8
	ld hl, $d852 ; $5ad9
	ld b, $00 ; $5adc
.charLoop:
	ld a, b ; $5ade
	add a, a ; $5adf
	ld hl, Data_38_5b29 ; $5ae0
	add a, l ; $5ae3
	ld l, a ; $5ae4
	jr nc, .readCharId ; $5ae5
	inc h ; $5ae7
.readCharId:
	ld a, [hl+] ; $5ae8
	ld d, [hl] ; $5ae9
	ld e, a ; $5aea
	call TestGameFlag ; $5aeb
	jr nz, .markChar ; $5aee
	jr .nextSlot ; $5af0
.markChar:
	ld hl, $d852 ; $5af2
	ld a, b ; $5af5
	add a, l ; $5af6
	ld l, a ; $5af7
	jr nc, .nextChar ; $5af8
	inc h ; $5afa
.nextChar:
	ld a, $01 ; $5afb
	ld [hl], a ; $5afd
.nextSlot:
	ld a, b ; $5afe
	inc a ; $5aff
	ld b, a ; $5b00
	cp a, $0d ; $5b01
	jr nz, .charLoop ; $5b03
	pop bc ; $5b05
	ld a, c ; $5b06
	inc a ; $5b07
	ld c, a ; $5b08
	cp a, $03 ; $5b09
	jr nz, .slotLoop ; $5b0b
	pop af ; $5b0d
	ld [wCurrentStorySlot], a ; $5b0e
	pop af ; $5b11
	wram_bank ; $5b12
	ret ; $5b16
Data_38_5b17:
	; $5b17, 18 bytes (bytes:16)
	db $c0, $01, $ff, $ff, $e0, $01, $ff, $ff, $60, $01, $ff, $ff, $a0, $01, $40, $01 ; 0x00
	db $80, $01 ; 0x10
Data_38_5b29:
	; $5b29, 26 bytes (bytes:16)
	db $00, $14, $20, $14, $40, $14, $60, $14, $80, $14, $a0, $14, $c0, $14, $e0, $14 ; 0x00
	db $00, $15, $20, $15, $40, $15, $60, $15, $80, $15 ; 0x10
BuildCharGridFromUnlockFlags:
	ld a, $01 ; $5b43
	ld [$d81c], a ; $5b45
	ld de, $da00 ; $5b48
	ld c, $00 ; $5b4b
.flagLoop:
	ld a, [hl+] ; $5b4d
	or a, a ; $5b4e
	jr z, .storeEmpty ; $5b4f
	push hl ; $5b51
	ld hl, Data_38_5b93 ; $5b52
	ld a, c ; $5b55
	add a, l ; $5b56
	ld l, a ; $5b57
	jr nc, .storeCharId ; $5b58
	inc h ; $5b5a
.storeCharId:
	ld a, [hl] ; $5b5b
	ld [de], a ; $5b5c
	pop hl ; $5b5d
	jr .next ; $5b5e
.storeEmpty:
	ld a, $ff ; $5b60
	ld [de], a ; $5b62
.next:
	inc de ; $5b63
	inc de ; $5b64
	inc de ; $5b65
	inc de ; $5b66
	ld a, c ; $5b67
	inc a ; $5b68
	ld c, a ; $5b69
	cp a, $20 ; $5b6a
	jr nz, .flagLoop ; $5b6c
	ret ; $5b6e
Data_38_5b6f:
	; $5b6f, 36 bytes (bytes:16)
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $01 ; 0x00
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; 0x10
	db $00, $00, $00, $00 ; 0x20
Data_38_5b93:
	; $5b93, 36 bytes (bytes:16)
	db $1a, $17, $1f, $19, $1c, $18, $1e, $1b, $1d, $00, $00, $00, $00, $00, $00, $04 ; 0x00
	db $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10, $11, $12, $13, $ff ; 0x10
	db $ff, $ff, $ff, $c9 ; 0x20
FillCharGridPaletteIndices:
	ld hl, $da00 ; $5bb7
	ld c, $00 ; $5bba
	ld b, $00 ; $5bbc
Label_38_5bbe:
	ld a, [hl] ; $5bbe
	push bc ; $5bbf
	push hl ; $5bc0
	farcall GetCharPaletteIndex ; $5bc1
	pop hl ; $5bc4
	pop bc ; $5bc5
	inc hl ; $5bc6
	inc a ; $5bc7
	ld [hl], a ; $5bc8
	dec hl ; $5bc9
	ld a, $04 ; $5bca
	add a, l ; $5bcc
	ld l, a ; $5bcd
	jr nc, Label_38_5bd1 ; $5bce
	inc h ; $5bd0
Label_38_5bd1:
	ld a, c ; $5bd1
	inc a ; $5bd2
	ld c, a ; $5bd3
	cp a, $20 ; $5bd4
	jr nz, Label_38_5bbe ; $5bd6
	ret ; $5bd8
AddCreatedCharsToCharGrid:
	ldh a, [hWramBank] ; $5bd9
	push af ; $5bdb
	wram_bank $03 ; $5bdc
	ld c, $00 ; $5be2
	ld b, $00 ; $5be4
	ld hl, $d900 ; $5be6
Label_38_5be9:
	ld a, [hl] ; $5be9
	cp a, $ff ; $5bea
	jr z, Label_38_5c36 ; $5bec
	push hl ; $5bee
	ld hl, $da24 ; $5bef
	ld a, b ; $5bf2
	add a, a ; $5bf3
	add a, a ; $5bf4
	add a, l ; $5bf5
	ld l, a ; $5bf6
	jr nc, Label_38_5bfa ; $5bf7
	inc h ; $5bf9
Label_38_5bfa:
	ld d, h ; $5bfa
	ld e, l ; $5bfb
	pop hl ; $5bfc
	ld a, [hl+] ; $5bfd
	ld [de], a ; $5bfe
	inc de ; $5bff
	ld a, [hl] ; $5c00
	inc a ; $5c01
	ld [de], a ; $5c02
	inc de ; $5c03
	xor a, a ; $5c04
	ld [de], a ; $5c05
	inc de ; $5c06
	ld a, c ; $5c07
	add a, a ; $5c08
	ld [de], a ; $5c09
	dec hl ; $5c0a
	ld de, $0020 ; $5c0b
	add hl, de ; $5c0e
	push hl ; $5c0f
	ld hl, $da24 ; $5c10
	ld a, b ; $5c13
	add a, $03 ; $5c14
	add a, a ; $5c16
	add a, a ; $5c17
	add a, l ; $5c18
	ld l, a ; $5c19
	jr nc, Label_38_5c1d ; $5c1a
	inc h ; $5c1c
Label_38_5c1d:
	ld d, h ; $5c1d
	ld e, l ; $5c1e
	pop hl ; $5c1f
	ld a, [hl+] ; $5c20
	ld [de], a ; $5c21
	inc de ; $5c22
	ld a, [hl] ; $5c23
	inc a ; $5c24
	ld [de], a ; $5c25
	inc de ; $5c26
	xor a, a ; $5c27
	ld [de], a ; $5c28
	ld a, c ; $5c29
	add a, a ; $5c2a
	inc a ; $5c2b
	inc de ; $5c2c
	ld [de], a ; $5c2d
	dec hl ; $5c2e
	ld de, $0020 ; $5c2f
	add hl, de ; $5c32
	inc b ; $5c33
	jr Label_38_5c3a ; $5c34
Label_38_5c36:
	ld de, $0040 ; $5c36
	add hl, de ; $5c39
Label_38_5c3a:
	ld a, c ; $5c3a
	inc a ; $5c3b
	ld c, a ; $5c3c
	cp a, $03 ; $5c3d
	jr nz, Label_38_5be9 ; $5c3f
	pop af ; $5c41
	wram_bank ; $5c42
	ret ; $5c46
AdvanceToNextPlayerSlot:
	ld a, [$d813] ; $5c47
	ld hl, CharSelectSlotRingTable ; $5c4a
	add a, a ; $5c4d
	add a, l ; $5c4e
	ld l, a ; $5c4f
	jr nc, Label_38_5c53 ; $5c50
	inc h ; $5c52
Label_38_5c53:
	ld a, [hl+] ; $5c53
	ld h, [hl] ; $5c54
	ld l, a ; $5c55
	ld a, [$d814] ; $5c56
	ld b, a ; $5c59
Label_38_5c5a:
	ld a, [hl+] ; $5c5a
	cp a, b ; $5c5b
	jr nz, Label_38_5c5a ; $5c5c
	ld a, [hl] ; $5c5e
	ld [$d814], a ; $5c5f
	ret ; $5c62
RetreatToPreviousPlayerSlot:
	ld a, [$d813] ; $5c63
	ld hl, CharSelectSlotRingTable ; $5c66
	add a, a ; $5c69
	add a, l ; $5c6a
	ld l, a ; $5c6b
	jr nc, .readList ; $5c6c
	inc h ; $5c6e
.readList:
	ld a, [hl+] ; $5c6f
	ld h, [hl] ; $5c70
	ld l, a ; $5c71
	ld a, [$d814] ; $5c72
	ld b, a ; $5c75
.findCurrent:
	ld a, [hl+] ; $5c76
	cp a, b ; $5c77
	jr nz, .findCurrent ; $5c78
	dec hl ; $5c7a
	dec hl ; $5c7b
	ld a, [hl] ; $5c7c
	ld [$d814], a ; $5c7d
	cp a, $ff ; $5c80
	jr z, .done ; $5c82
	ld c, a ; $5c84
	ld a, b ; $5c85
	cp a, $04 ; $5c86
	jr z, .noPrevious ; $5c88
	ld a, c ; $5c8a
	ret ; $5c8b
.noPrevious:
	ld a, $fe ; $5c8c
.done:
	ret ; $5c8e
CharSelectSlotRingTable:
	; $5c8f, 12 bytes (records:2)
	dw CharSelectSlotRing0 ; record 0
	dw CharSelectSlotRing1 ; record 1
	dw CharSelectSlotRing2 ; record 2
	dw CharSelectSlotRing3 ; record 3
	dw CharSelectSlotRing4 ; record 4
	dw CharSelectSlotRing5 ; record 5
CharSelectSlotRing0:
	; $5c9b, 4 bytes (bytes:4)
	db $ff, $00, $02, $ff ; 0x00
CharSelectSlotRing1:
	; $5c9f, 6 bytes (bytes:6)
	db $ff, $00, $01, $02, $03, $ff ; 0x00
CharSelectSlotRing2:
	; $5ca5, 4 bytes (bytes:4)
	db $ff, $00, $04, $ff ; 0x00
CharSelectSlotRing3:
	; $5ca9, 4 bytes (bytes:4)
	db $ff, $02, $04, $ff ; 0x00
CharSelectSlotRing4:
	; $5cad, 5 bytes (bytes:5)
	db $ff, $00, $01, $04, $ff ; 0x00
CharSelectSlotRing5:
	; $5cb2, 5 bytes (bytes:5)
	db $ff, $02, $03, $04, $ff ; 0x00
GetGridSlotFromCursor:
	ldh a, [hWramBank] ; $5cb7
	push af ; $5cb9
	wram_bank $03 ; $5cba
	ld a, [wMenuCursorX] ; $5cc0
	ld d, a ; $5cc3
	ld a, [wMenuCursorY] ; $5cc4
	ld e, a ; $5cc7
	ld a, e ; $5cc8
	add a, a ; $5cc9
	add a, e ; $5cca
	ld e, a ; $5ccb
	ld a, d ; $5ccc
	add a, e ; $5ccd
	ld b, a ; $5cce
	ld a, [$d811] ; $5ccf
	ld c, a ; $5cd2
.addPageLoop:
	ld a, c ; $5cd3
	or a, a ; $5cd4
	jr z, .done ; $5cd5
	ld a, $03 ; $5cd7
	add a, b ; $5cd9
	ld b, a ; $5cda
	dec c ; $5cdb
	jr .addPageLoop ; $5cdc
.done:
	pop af ; $5cde
	wram_bank ; $5cdf
	ld a, b ; $5ce3
	ret ; $5ce4
BuildVisiblePageSpriteList:
	push af ; $5ce5
	push bc ; $5ce6
	push de ; $5ce7
	push hl ; $5ce8
	ldh a, [hWramBank] ; $5ce9
	push af ; $5ceb
	wram_bank $03 ; $5cec
	ld hl, $da00 ; $5cf2
	ld a, [$d811] ; $5cf5
	ld bc, $000c ; $5cf8
.seekPage:
	or a, a ; $5cfb
	jr z, .copyStart ; $5cfc
	add hl, bc ; $5cfe
	dec a ; $5cff
	jr .seekPage ; $5d00
.copyStart:
	ld c, $00 ; $5d02
	ld de, $d800 ; $5d04
.copyLoop:
	ld a, [hl+] ; $5d07
	ld [de], a ; $5d08
	inc de ; $5d09
	ld a, [hl+] ; $5d0a
	ld [de], a ; $5d0b
	ld a, [hl+] ; $5d0c
	or a, a ; $5d0d
	jr z, .nextSlot ; $5d0e
	xor a, a ; $5d10
	ld [de], a ; $5d11
.nextSlot:
	inc de ; $5d12
	inc hl ; $5d13
	ld a, c ; $5d14
	inc a ; $5d15
	ld c, a ; $5d16
	cp a, $06 ; $5d17
	jr nz, .copyLoop ; $5d19
	pop af ; $5d1b
	wram_bank ; $5d1c
	pop hl ; $5d20
	pop de ; $5d21
	pop bc ; $5d22
	pop af ; $5d23
	ret ; $5d24
	push bc ; $5d25
	push de ; $5d26
	push hl ; $5d27
	ldh a, [hWramBank] ; $5d28
	push af ; $5d2a
	wram_bank $03 ; $5d2b
	call GetGridEntryTakenPtr ; $5d31
	ld a, [hl] ; $5d34
	ld b, a ; $5d35
	xor a, a ; $5d36
	ld [hl], a ; $5d37
	pop af ; $5d38
	wram_bank ; $5d39
	ld a, b ; $5d3d
	pop hl ; $5d3e
	pop de ; $5d3f
	pop bc ; $5d40
	ret ; $5d41
TestAndSetGridEntryTaken:
	push bc ; $5d42
	push de ; $5d43
	push hl ; $5d44
	ldh a, [hWramBank] ; $5d45
	push af ; $5d47
	wram_bank $03 ; $5d48
	call GetGridEntryTakenPtr ; $5d4e
	ld a, [hl] ; $5d51
	ld b, a ; $5d52
	ld a, $01 ; $5d53
	ld [hl], a ; $5d55
	pop af ; $5d56
	wram_bank ; $5d57
	ld a, b ; $5d5b
	pop hl ; $5d5c
	pop de ; $5d5d
	pop bc ; $5d5e
	ret ; $5d5f
GetGridEntryTakenPtr:
	ld hl, $da00 ; $5d60
	ld a, c ; $5d63
	ld bc, $000c ; $5d64
.rowLoop:
	or a, a ; $5d67
	jr z, .addColumn ; $5d68
	add hl, bc ; $5d6a
	dec a ; $5d6b
	jr .rowLoop ; $5d6c
.addColumn:
	ld a, e ; $5d6e
	add a, a ; $5d6f
	add a, e ; $5d70
	ld e, a ; $5d71
	ld a, d ; $5d72
	add a, e ; $5d73
	add a, a ; $5d74
	add a, a ; $5d75
	add a, l ; $5d76
	ld l, a ; $5d77
	jr nc, .offsetTaken ; $5d78
	inc h ; $5d7a
.offsetTaken:
	ld a, $02 ; $5d7b
	add a, l ; $5d7d
	ld l, a ; $5d7e
	jr nc, .done ; $5d7f
	inc h ; $5d81
.done:
	ret ; $5d82
BuildCreatedCharRecords:
	push af ; $5d83
	push bc ; $5d84
	push de ; $5d85
	push hl ; $5d86
	ldh a, [hWramBank] ; $5d87
	push af ; $5d89
	wram_bank $03 ; $5d8a
	ld hl, $d900 ; $5d90
	ld bc, $00c0 ; $5d93
	call ClearBytes ; $5d96
	ld bc, $d900 ; $5d99
	ld a, $80 ; $5d9c
Label_38_5d9e:
	push af ; $5d9e
	farcall LoadCharacterRecordToBuffer ; $5d9f
	farcall CheckCharacterUnlocked ; $5da2
	ld hl, $0000 ; $5da5
	add hl, bc ; $5da8
	ld a, [$d58b] ; $5da9
	cp a, $04 ; $5dac
	jr c, Label_38_5dc9 ; $5dae
	ld a, $ff ; $5db0
	ld [hl], a ; $5db2
	ld hl, $0020 ; $5db3
	add hl, bc ; $5db6
	ld b, h ; $5db7
	ld c, l ; $5db8
	ld hl, $0000 ; $5db9
	add hl, bc ; $5dbc
	ld a, $ff ; $5dbd
	ld [hl], a ; $5dbf
	ld hl, $0020 ; $5dc0
	add hl, bc ; $5dc3
	ld b, h ; $5dc4
	ld c, l ; $5dc5
	jp Label_38_5e5d ; $5dc6
Label_38_5dc9:
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $5dc9
	ld [hl], a ; $5dcc
	ld hl, $0001 ; $5dcd
	add hl, bc ; $5dd0
	ld a, [wStoryModeMainCharacterOverworldSpriteColor] ; $5dd1
	ld [hl], a ; $5dd4
	ld hl, $0002 ; $5dd5
	add hl, bc ; $5dd8
	ld a, [$c918] ; $5dd9
	ld [hl], a ; $5ddc
	ld hl, $0003 ; $5ddd
	add hl, bc ; $5de0
	ld a, [$c938] ; $5de1
	ld [hl], a ; $5de4
	ld hl, $0004 ; $5de5
	add hl, bc ; $5de8
	ld a, [$c939] ; $5de9
	ld [hl], a ; $5dec
	ld hl, $0005 ; $5ded
	add hl, bc ; $5df0
	ld a, [$c93a] ; $5df1
	ld [hl], a ; $5df4
	ld hl, $0006 ; $5df5
	add hl, bc ; $5df8
	ld a, [$c93b] ; $5df9
	ld [hl], a ; $5dfc
	push bc ; $5dfd
	ld a, $07 ; $5dfe
	add a, c ; $5e00
	ld e, a ; $5e01
	ld d, b ; $5e02
	ld hl, wStoryModeNameOfMainCharacter ; $5e03
	ld bc, $000b ; $5e06
	call CopyMemoryBC ; $5e09
	pop bc ; $5e0c
	ld hl, $0020 ; $5e0d
	add hl, bc ; $5e10
	ld b, h ; $5e11
	ld c, l ; $5e12
	ld a, [wStoryModePartnerCharacterOverworldSprite] ; $5e13
	ld [hl], a ; $5e16
	ld hl, $0001 ; $5e17
	add hl, bc ; $5e1a
	ld a, [wStoryModePartnerCharacterOverworldSpriteColor] ; $5e1b
	ld [hl], a ; $5e1e
	ld hl, $0002 ; $5e1f
	add hl, bc ; $5e22
	ld a, [$c958] ; $5e23
	ld [hl], a ; $5e26
	ld hl, $0003 ; $5e27
	add hl, bc ; $5e2a
	ld a, [$c978] ; $5e2b
	ld [hl], a ; $5e2e
	ld hl, $0004 ; $5e2f
	add hl, bc ; $5e32
	ld a, [$c979] ; $5e33
	ld [hl], a ; $5e36
	ld hl, $0005 ; $5e37
	add hl, bc ; $5e3a
	ld a, [$c97a] ; $5e3b
	ld [hl], a ; $5e3e
	ld hl, $0006 ; $5e3f
	add hl, bc ; $5e42
	ld a, [$c97b] ; $5e43
	ld [hl], a ; $5e46
	push bc ; $5e47
	ld a, $07 ; $5e48
	add a, c ; $5e4a
	ld e, a ; $5e4b
	ld d, b ; $5e4c
	ld hl, wStoryModeNameOfPartnerCharacter ; $5e4d
	ld bc, $000b ; $5e50
	call CopyMemoryBC ; $5e53
	pop bc ; $5e56
	ld hl, $0020 ; $5e57
	add hl, bc ; $5e5a
	ld b, h ; $5e5b
	ld c, l ; $5e5c
Label_38_5e5d:
	pop af ; $5e5d
	inc a ; $5e5e
	cp a, $83 ; $5e5f
	jp nz, Label_38_5d9e ; $5e61
	pop af ; $5e64
	wram_bank ; $5e65
	pop hl ; $5e69
	pop de ; $5e6a
	pop bc ; $5e6b
	pop af ; $5e6c
	ret ; $5e6d
ResolveSelectedCharIds:
	ldh a, [hWramBank] ; $5e6e
	push af ; $5e70
	wram_bank $03 ; $5e71
	ld c, $00 ; $5e77
	ld hl, $d816 ; $5e79
.slotLoop:
	ld a, [hl] ; $5e7c
	cp a, $ff ; $5e7d
	jr z, .done ; $5e7f
	push hl ; $5e81
	ld hl, $da00 ; $5e82
	add a, a ; $5e85
	add a, a ; $5e86
	add a, l ; $5e87
	ld l, a ; $5e88
	jr nc, .readEntry ; $5e89
	inc h ; $5e8b
.readEntry:
	ld a, [hl] ; $5e8c
	cp a, $04 ; $5e8d
	jr nc, .nextSlot ; $5e8f
	inc hl ; $5e91
	inc hl ; $5e92
	inc hl ; $5e93
	ld a, [hl] ; $5e94
	or a, $80 ; $5e95
.nextSlot:
	pop hl ; $5e97
.done:
	ld [hl+], a ; $5e98
	ld a, c ; $5e99
	inc a ; $5e9a
	ld c, a ; $5e9b
	cp a, $04 ; $5e9c
	jr nz, .slotLoop ; $5e9e
	pop af ; $5ea0
	wram_bank ; $5ea1
	ret ; $5ea5
InitMatchCharsFromSelection:
	ldh a, [hWramBank] ; $5ea6
	push af ; $5ea8
	wram_bank $03 ; $5ea9
	call CacheStorySlotNames ; $5eaf
	ld a, [$d816] ; $5eb2
	cp a, $ff ; $5eb5
	jr z, .slot2 ; $5eb7
	cp a, $80 ; $5eb9
	jr c, .slot1Created ; $5ebb
	ld c, a ; $5ebd
	and a, $07 ; $5ebe
	srl a ; $5ec0
	ld b, a ; $5ec2
	ld a, c ; $5ec3
	call LoadCachedStorySlotName ; $5ec4
	and a, $81 ; $5ec7
	ld b, a ; $5ec9
	ld c, $00 ; $5eca
	farcall InitCa00RecordFromCharId ; $5ecc
	jr .slot2 ; $5ecf
.slot1Created:
	ld b, a ; $5ed1
	ld c, $00 ; $5ed2
	farcall InitCa00RecordFromCharId ; $5ed4
.slot2:
	ld a, [$d817] ; $5ed7
	cp a, $ff ; $5eda
	jr z, .slot3 ; $5edc
	cp a, $80 ; $5ede
	jr c, .slot2Created ; $5ee0
	ld c, a ; $5ee2
	and a, $07 ; $5ee3
	srl a ; $5ee5
	ld b, a ; $5ee7
	ld a, c ; $5ee8
	call LoadCachedStorySlotName ; $5ee9
	and a, $81 ; $5eec
	ld b, a ; $5eee
	ld c, $01 ; $5eef
	farcall InitCa00RecordFromCharId ; $5ef1
	jr .slot3 ; $5ef4
.slot2Created:
	ld b, a ; $5ef6
	ld c, $01 ; $5ef7
	farcall InitCa00RecordFromCharId ; $5ef9
.slot3:
	ld a, [$d818] ; $5efc
	cp a, $ff ; $5eff
	jr z, .slot4 ; $5f01
	cp a, $80 ; $5f03
	jr c, .slot3Created ; $5f05
	ld c, a ; $5f07
	and a, $07 ; $5f08
	srl a ; $5f0a
	ld b, a ; $5f0c
	ld a, c ; $5f0d
	call LoadCachedStorySlotName ; $5f0e
	and a, $81 ; $5f11
	ld b, a ; $5f13
	ld c, $02 ; $5f14
	farcall InitCa00RecordFromCharId ; $5f16
	jr .slot4 ; $5f19
.slot3Created:
	ld b, a ; $5f1b
	ld c, $02 ; $5f1c
	farcall InitCa00RecordFromCharId ; $5f1e
.slot4:
	ld a, [$d819] ; $5f21
	cp a, $ff ; $5f24
	jr z, .done ; $5f26
	cp a, $80 ; $5f28
	jr c, .slot4Created ; $5f2a
	ld c, a ; $5f2c
	and a, $07 ; $5f2d
	srl a ; $5f2f
	ld b, a ; $5f31
	ld a, c ; $5f32
	call LoadCachedStorySlotName ; $5f33
	and a, $81 ; $5f36
	ld b, a ; $5f38
	ld c, $03 ; $5f39
	farcall InitCa00RecordFromCharId ; $5f3b
	jr .done ; $5f3e
.slot4Created:
	ld b, a ; $5f40
	ld c, $03 ; $5f41
	farcall InitCa00RecordFromCharId ; $5f43
.done:
	pop af ; $5f46
	wram_bank ; $5f47
	ret ; $5f4b
ApplyCpuDifficultyToCharRecords:
	ldh a, [hWramBank] ; $5f4c
	push af ; $5f4e
	wram_bank $03 ; $5f4f
	ld a, [$d831] ; $5f55
	ld hl, SubHandlers_38_5feb ; $5f58
	add a, a ; $5f5b
	add a, l ; $5f5c
	ld l, a ; $5f5d
	jr nc, .readSlot1 ; $5f5e
	inc h ; $5f60
.readSlot1:
	ld a, [hl+] ; $5f61
	ld h, [hl] ; $5f62
	ld l, a ; $5f63
	ld a, [hl+] ; $5f64
	ld [$ca5b], a ; $5f65
	ld a, [hl+] ; $5f68
	ld [$ca5c], a ; $5f69
	ld a, [hl+] ; $5f6c
	ld [$ca5d], a ; $5f6d
	ld a, [hl+] ; $5f70
	ld [$ca5e], a ; $5f71
	ld a, [hl+] ; $5f74
	ld [wExhibitionModePlayerPartnerCharacterDifficulty], a ; $5f75
	ld a, [wPlayer1CurrentPartnerCharacter] ; $5f78
	call IsCreatedCharId ; $5f7b
	or a, a ; $5f7e
	jr nz, .slot2 ; $5f7f
	ld a, [hl+] ; $5f81
	ld [$ca58], a ; $5f82
.slot2:
	ld a, [$d832] ; $5f85
	ld hl, SubHandlers_38_5feb ; $5f88
	add a, a ; $5f8b
	add a, l ; $5f8c
	ld l, a ; $5f8d
	jr nc, .readSlot2 ; $5f8e
	inc h ; $5f90
.readSlot2:
	ld a, [hl+] ; $5f91
	ld h, [hl] ; $5f92
	ld l, a ; $5f93
	ld a, [hl+] ; $5f94
	ld [$ca9b], a ; $5f95
	ld a, [hl+] ; $5f98
	ld [$ca9c], a ; $5f99
	ld a, [hl+] ; $5f9c
	ld [$ca9d], a ; $5f9d
	ld a, [hl+] ; $5fa0
	ld [$ca9e], a ; $5fa1
	ld a, [hl+] ; $5fa4
	ld [wExhibitionModeCPUMainCharacterDifficulty], a ; $5fa5
	ld a, [wPlayer2CurrentMainCharacter] ; $5fa8
	call IsCreatedCharId ; $5fab
	or a, a ; $5fae
	jr nz, .slot3 ; $5faf
	ld a, [hl+] ; $5fb1
	ld [$ca98], a ; $5fb2
.slot3:
	ld a, [$d833] ; $5fb5
	ld hl, SubHandlers_38_5feb ; $5fb8
	add a, a ; $5fbb
	add a, l ; $5fbc
	ld l, a ; $5fbd
	jr nc, .readSlot3 ; $5fbe
	inc h ; $5fc0
.readSlot3:
	ld a, [hl+] ; $5fc1
	ld h, [hl] ; $5fc2
	ld l, a ; $5fc3
	ld a, [hl+] ; $5fc4
	ld [$cadb], a ; $5fc5
	ld a, [hl+] ; $5fc8
	ld [$cadc], a ; $5fc9
	ld a, [hl+] ; $5fcc
	ld [$cadd], a ; $5fcd
	ld a, [hl+] ; $5fd0
	ld [$cade], a ; $5fd1
	ld a, [hl+] ; $5fd4
	ld [wExhibitionModeCPUPartnerCharacterDifficulty], a ; $5fd5
	ld a, [wPlayer2CurrentPartnerCharacter] ; $5fd8
	call IsCreatedCharId ; $5fdb
	or a, a ; $5fde
	jr nz, .done ; $5fdf
	ld a, [hl+] ; $5fe1
	ld [$cad8], a ; $5fe2
.done:
	pop af ; $5fe5
	wram_bank ; $5fe6
	ret ; $5fea
SubHandlers_38_5feb:
	; $5feb, 10 bytes (records:2)
	dw $5ff5 ; record 0
	dw $5ffb ; record 1
	dw $6001 ; record 2
	dw $6007 ; record 3
	dw $600d ; record 4
	ld [bc], a ; $5ff5
	ld [bc], a ; $5ff6
	nop ; $5ff7
	and a, $03 ; $5ff8
	rlca ; $5ffa
	inc e ; $5ffb
	jr Label_38_600a ; $5ffc
Data_38_5ffe:
	; $5ffe, 3 bytes (bytes:3)
	db $3c, $00, $01 ; 0x00
	ld [de], a ; $6001
	rrca ; $6002
	add hl, bc ; $6003
	ld a, b ; $6004
	db $01 ; $6005
	db $03 ; $6006
	ld a, [bc] ; $6007
	add hl, bc ; $6008
	dec b ; $6009
Label_38_600a:
	cp a, [hl] ; $600a
	ld [bc], a ; $600b
	dec b ; $600c
	ld [bc], a ; $600d
	ld [bc], a ; $600e
	nop ; $600f
	and a, $03 ; $6010
	rlca ; $6012
IsCreatedCharId:
	cp a, $04 ; $6013
	jr nc, .no ; $6015
	ld a, $01 ; $6017
	ret ; $6019
.no:
	xor a, a ; $601a
	ret ; $601b
ApplyStarFlagsToCharRecords:
	ldh a, [hWramBank] ; $601c
	push af ; $601e
	wram_bank $03 ; $601f
	ld a, [$ca0e] ; $6025
	or a, a ; $6028
	jr nz, .slot2 ; $6029
	ld a, [$d834] ; $602b
	ld [$ca0e], a ; $602e
.slot2:
	ld a, [$ca4e] ; $6031
	or a, a ; $6034
	jr nz, .slot3 ; $6035
	ld a, [$d835] ; $6037
	ld [$ca4e], a ; $603a
.slot3:
	ld a, [$ca8e] ; $603d
	or a, a ; $6040
	jr nz, .slot4 ; $6041
	ld a, [$d836] ; $6043
	ld [$ca8e], a ; $6046
.slot4:
	ld a, [$cace] ; $6049
	or a, a ; $604c
	jr nz, .done ; $604d
	ld a, [$d837] ; $604f
	ld [$cace], a ; $6052
.done:
	pop af ; $6055
	wram_bank ; $6056
	ret ; $605a
CacheStorySlotNames:
	push af ; $605b
	push bc ; $605c
	push de ; $605d
	push hl ; $605e
	ldh a, [hWramBank] ; $605f
	push af ; $6061
	wram_bank $01 ; $6062
	ld a, $00 ; $6068
	ld [wCurrentStorySlot], a ; $606a
	farcall CheckStorySlot ; $606d
	ld hl, wStoryModeNameOfMainCharacter ; $6070
	ld de, $d000 ; $6073
	ld bc, $0008 ; $6076
	call CopyMemoryFast ; $6079
	ld a, $01 ; $607c
	ld [wCurrentStorySlot], a ; $607e
	farcall CheckStorySlot ; $6081
	ld hl, wStoryModeNameOfMainCharacter ; $6084
	ld de, $d100 ; $6087
	ld bc, $0008 ; $608a
	call CopyMemoryFast ; $608d
	ld a, $02 ; $6090
	ld [wCurrentStorySlot], a ; $6092
	farcall CheckStorySlot ; $6095
	ld hl, wStoryModeNameOfMainCharacter ; $6098
	ld de, $d200 ; $609b
	ld bc, $0008 ; $609e
	call CopyMemoryFast ; $60a1
	pop af ; $60a4
	wram_bank ; $60a5
	pop hl ; $60a9
	pop de ; $60aa
	pop bc ; $60ab
	pop af ; $60ac
	ld a, $03 ; $60ad
	ld [wCurrentStorySlot], a ; $60af
	farcall InitStoryModeState ; $60b2
	farcall InitDefaultMatchSettings ; $60b5
	ret ; $60b8
LoadCachedStorySlotName:
	push af ; $60b9
	push bc ; $60ba
	push de ; $60bb
	push hl ; $60bc
	ldh a, [hWramBank] ; $60bd
	push af ; $60bf
	wram_bank $01 ; $60c0
	ld a, b ; $60c6
	add a, a ; $60c7
	ld hl, Data_38_60e6 ; $60c8
	add a, l ; $60cb
	ld l, a ; $60cc
	jr nc, .readPtr ; $60cd
	inc h ; $60cf
.readPtr:
	ld a, [hl+] ; $60d0
	ld h, [hl] ; $60d1
	ld l, a ; $60d2
	ld de, wStoryModeNameOfMainCharacter ; $60d3
	ld bc, $0008 ; $60d6
	call CopyMemoryFast ; $60d9
	pop af ; $60dc
	wram_bank ; $60dd
	pop hl ; $60e1
	pop de ; $60e2
	pop bc ; $60e3
	pop af ; $60e4
	ret ; $60e5
Data_38_60e6:
	; $60e6, 6 bytes (bytes:6)
	db $00, $d0, $00, $d1, $00, $d2 ; 0x00
CompactRosterGridEntries:
	ld hl, $da24 ; $60ec
	ld c, $00 ; $60ef
.scanLoop:
	ld a, [hl] ; $60f1
	cp a, $ff ; $60f2
	jr nz, .next ; $60f4
	push hl ; $60f6
	ld a, $16 ; $60f7
	sub a, c ; $60f9
	ld b, a ; $60fa
.findNext:
	inc hl ; $60fb
	inc hl ; $60fc
	inc hl ; $60fd
	inc hl ; $60fe
	ld a, [hl] ; $60ff
	cp a, $04 ; $6100
	jr c, .nextSlot ; $6102
	ld a, [hl] ; $6104
	cp a, $ff ; $6105
	jr nz, .moveEntry ; $6107
.nextSlot:
	ld a, b ; $6109
	dec a ; $610a
	ld b, a ; $610b
	jr nz, .findNext ; $610c
.moveEntry:
	pop de ; $610e
	ld a, [hl] ; $610f
	ld [de], a ; $6110
	ld a, $ff ; $6111
	ld [hl], a ; $6113
	inc de ; $6114
	inc hl ; $6115
	ld a, [hl] ; $6116
	ld [de], a ; $6117
	xor a, a ; $6118
	ld [hl], a ; $6119
	inc de ; $611a
	inc hl ; $611b
	ld a, [hl] ; $611c
	ld [de], a ; $611d
	xor a, a ; $611e
	ld [hl], a ; $611f
	inc de ; $6120
	inc hl ; $6121
	ld a, [hl] ; $6122
	ld [de], a ; $6123
	xor a, a ; $6124
	ld [hl], a ; $6125
	inc de ; $6126
	inc hl ; $6127
	ld h, d ; $6128
	ld l, e ; $6129
	jr .done ; $612a
.next:
	inc hl ; $612c
	inc hl ; $612d
	inc hl ; $612e
	inc hl ; $612f
.done:
	ld a, c ; $6130
	inc a ; $6131
	ld c, a ; $6132
	cp a, $16 ; $6133
	jr nz, .scanLoop ; $6135
	ld a, $ff ; $6137
	ld [hl+], a ; $6139
	ld [hl+], a ; $613a
	ld [hl+], a ; $613b
	ld [hl+], a ; $613c
	ld [hl+], a ; $613d
	ld [hl+], a ; $613e
	ld [hl+], a ; $613f
	ld [hl+], a ; $6140
	ld [hl+], a ; $6141
	ld [hl+], a ; $6142
	ld [hl+], a ; $6143
	ld [hl+], a ; $6144
	ret ; $6145
CompactStarGridEntries:
	ld hl, $da00 ; $6146
	ld c, $00 ; $6149
.scanLoop:
	ld a, [hl] ; $614b
	cp a, $ff ; $614c
	jr nz, .next ; $614e
	push hl ; $6150
	ld a, $08 ; $6151
	sub a, c ; $6153
	ld b, a ; $6154
.findNext:
	inc hl ; $6155
	inc hl ; $6156
	inc hl ; $6157
	inc hl ; $6158
	ld a, [hl] ; $6159
	cp a, $04 ; $615a
	jr c, .nextSlot ; $615c
	ld a, [hl] ; $615e
	cp a, $ff ; $615f
	jr nz, .moveEntry ; $6161
.nextSlot:
	ld a, b ; $6163
	dec a ; $6164
	ld b, a ; $6165
	jr nz, .findNext ; $6166
.moveEntry:
	pop de ; $6168
	ld a, [hl] ; $6169
	ld [de], a ; $616a
	ld a, $ff ; $616b
	ld [hl], a ; $616d
	inc de ; $616e
	inc hl ; $616f
	ld a, [hl] ; $6170
	ld [de], a ; $6171
	xor a, a ; $6172
	ld [hl], a ; $6173
	inc de ; $6174
	inc hl ; $6175
	ld a, [hl] ; $6176
	ld [de], a ; $6177
	xor a, a ; $6178
	ld [hl], a ; $6179
	inc de ; $617a
	inc hl ; $617b
	ld a, [hl] ; $617c
	ld [de], a ; $617d
	xor a, a ; $617e
	ld [hl], a ; $617f
	inc de ; $6180
	inc hl ; $6181
	ld h, d ; $6182
	ld l, e ; $6183
	jr .done ; $6184
.next:
	inc hl ; $6186
	inc hl ; $6187
	inc hl ; $6188
	inc hl ; $6189
.done:
	ld a, c ; $618a
	inc a ; $618b
	ld c, a ; $618c
	cp a, $08 ; $618d
	jr nz, .scanLoop ; $618f
	ret ; $6191
CountCharGridEntries:
	ld hl, $da24 ; $6192
	ld c, $00 ; $6195
	ld b, $00 ; $6197
.countLoop:
	ld a, [hl] ; $6199
	cp a, $ff ; $619a
	jr z, .next ; $619c
	inc b ; $619e
.next:
	inc hl ; $619f
	inc hl ; $61a0
	inc hl ; $61a1
	inc hl ; $61a2
	ld a, c ; $61a3
	inc a ; $61a4
	ld c, a ; $61a5
	cp a, $16 ; $61a6
	jr nz, .countLoop ; $61a8
	ld a, b ; $61aa
	ld [$d81a], a ; $61ab
	ld hl, $da00 ; $61ae
	ld c, $00 ; $61b1
	ld b, $00 ; $61b3
.countPageLoop:
	ld a, [hl] ; $61b5
	cp a, $ff ; $61b6
	jr z, .nextPage ; $61b8
	inc b ; $61ba
.nextPage:
	inc hl ; $61bb
	inc hl ; $61bc
	inc hl ; $61bd
	inc hl ; $61be
	ld a, c ; $61bf
	inc a ; $61c0
	ld c, a ; $61c1
	cp a, $09 ; $61c2
	jr nz, .countPageLoop ; $61c4
	ld a, b ; $61c6
	ld [$d823], a ; $61c7
	ret ; $61ca
SetCharGridPageCount:
	ld a, [$d81a] ; $61cb
	ld hl, Data_38_61db ; $61ce
	add a, l ; $61d1
	ld l, a ; $61d2
	jr nc, Label_38_61d6 ; $61d3
	inc h ; $61d5
Label_38_61d6:
	ld a, [hl] ; $61d6
	ld [$d812], a ; $61d7
	ret ; $61da
Data_38_61db:
	; $61db, 28 bytes (bytes:16)
	db $05, $05, $05, $05, $05, $05, $05, $06, $06, $06, $07, $07, $07, $08, $08, $08 ; 0x00
	db $09, $09, $09, $0a, $0a, $0a, $0b, $0b, $0b, $0c, $0c, $0c ; 0x10
NeedsCpuDifficultyPrompt:
	call IsStarCharacter ; $61f7
	or a, a ; $61fa
	jr z, Label_38_6206 ; $61fb
	ld a, [$d814] ; $61fd
	or a, a ; $6200
	jr z, Label_38_6206 ; $6201
	ld a, $01 ; $6203
	ret ; $6205
Label_38_6206:
	xor a, a ; $6206
	ret ; $6207
IsStarCharacter:
	ld a, c ; $6208
	cp a, $17 ; $6209
	jr c, .notStar ; $620b
	cp a, $20 ; $620d
	jr nc, .notStar ; $620f
	ld a, $01 ; $6211
	ret ; $6213
.notStar:
	xor a, a ; $6214
	ret ; $6215
RunCpuDifficultySubmenu:
	ldh a, [hWramBank] ; $6216
	push af ; $6218
	wram_bank $03 ; $6219
	ld a, [$d825] ; $621f
	or a, a ; $6222
	jr nz, .inputLoop ; $6223
	call OpenCpuDifficultyPanel ; $6225
	call QueueCpuDifficultyPanelToVram ; $6228
	ld a, $01 ; $622b
	ld [$d825], a ; $622d
.inputLoop:
	call HandleCpuDifficultyInput ; $6230
	call DrawCpuDifficultyCursorBox ; $6233
	ld a, [wMenuInputPressed] ; $6236
	bit PADB_A, a ; $6239
	jr nz, .confirm ; $623b
	bit 1, a ; $623d
	jr nz, .cancel ; $623f
	jr .done ; $6241
.cancel:
	call CloseCpuDifficultyPanel ; $6243
	sound $62 ; $6246
	wram_bank $03 ; $6248
	ld hl, $d830 ; $624e
	ld a, [$d814] ; $6251
	add a, l ; $6254
	ld l, a ; $6255
	jr nc, .clearDifficulty ; $6256
	inc h ; $6258
.clearDifficulty:
	xor a, a ; $6259
	ld [hl], a ; $625a
	ld hl, $d834 ; $625b
	ld a, [$d814] ; $625e
	add a, l ; $6261
	ld l, a ; $6262
	jr nc, .clearTaken ; $6263
	inc h ; $6265
.clearTaken:
	xor a, a ; $6266
	ld [hl], a ; $6267
	ld hl, $d816 ; $6268
	ld a, [$d814] ; $626b
	add a, l ; $626e
	ld l, a ; $626f
	jr nc, .readSlotChar ; $6270
	inc h ; $6272
.readSlotChar:
	ld a, [hl] ; $6273
	ld b, $00 ; $6274
	ld [hl], b ; $6276
	ld hl, $da00 ; $6277
	add a, a ; $627a
	add a, a ; $627b
	add a, l ; $627c
	ld l, a ; $627d
	jr nc, .clearGridEntry ; $627e
	inc h ; $6280
.clearGridEntry:
	inc hl ; $6281
	inc hl ; $6282
	xor a, a ; $6283
	ld [hl], a ; $6284
	call ClearPlayerSlotPortrait ; $6285
	call BuildVisiblePageSpriteList ; $6288
	jr .advanceSlot ; $628b
.confirm:
	sound $5f ; $628d
	call CloseCpuDifficultyPanel ; $628f
	ld hl, $d830 ; $6292
	ld a, [$d814] ; $6295
	add a, l ; $6298
	ld l, a ; $6299
	jr nc, .storeDifficulty ; $629a
	inc h ; $629c
.storeDifficulty:
	ld a, [$d826] ; $629d
	inc a ; $62a0
	ld [hl], a ; $62a1
	call GetGridSlotFromCursor ; $62a2
	call DrawPlayerSlotPortrait ; $62a5
	call AdvanceToNextPlayerSlot ; $62a8
	cp a, $ff ; $62ab
	jr nz, .advanceSlot ; $62ad
	ld a, $01 ; $62af
	ld [$d815], a ; $62b1
.advanceSlot:
	call DrawCharGridSlotPrompt ; $62b4
	ld hl, $d040 ; $62b7
	ld de, $9840 ; $62ba
	ld c, $04 ; $62bd
	call QueueVRAMCopy ; $62bf
.done:
	pop af ; $62c2
	wram_bank ; $62c3
	ret ; $62c7
CloseCpuDifficultyPanel:
	xor a, a ; $62c8
	ld [$d825], a ; $62c9
	ld [$d824], a ; $62cc
	ld hl, $d2c0 ; $62cf
	ld de, $d1c0 ; $62d2
	ld b, $14 ; $62d5
	ld c, $04 ; $62d7
	farcall CopyTilemapRect ; $62d9
	ld hl, $d6c0 ; $62dc
	ld de, $d5c0 ; $62df
	ld b, $14 ; $62e2
	ld c, $04 ; $62e4
	farcall CopyTilemapRect ; $62e6
	ld de, $d5c1 ; $62e9
	ld b, $12 ; $62ec
	ld c, $03 ; $62ee
	ld h, $00 ; $62f0
	farcall FillTilemapRect ; $62f2
	call RefreshCharInfoPanel ; $62f5
	ld hl, $d220 ; $62f8
	ld de, $9a20 ; $62fb
	ld c, $02 ; $62fe
	call QueueVRAMCopy ; $6300
	ld hl, $d5c0 ; $6303
	ld de, $b9c0 ; $6306
	ld c, $08 ; $6309
	call QueueVRAMCopy ; $630b
	ret ; $630e
HandleCpuDifficultyInput:
	ld a, [wMenuInputPressed] ; $630f
	bit PADB_LEFT, a ; $6312
	jr nz, .decrease ; $6314
	bit 4, a ; $6316
	jr nz, .increase ; $6318
	ret ; $631a
.decrease:
	sound $5e ; $631b
	ld a, [$d826] ; $631d
	dec a ; $6320
	jr .wrap ; $6321
.increase:
	sound $5e ; $6323
	ld a, [$d826] ; $6325
	inc a ; $6328
.wrap:
	add a, a ; $6329
	jr nc, .checkMax ; $632a
	ld a, $04 ; $632c
	dec a ; $632e
	jr .store ; $632f
.checkMax:
	rra ; $6331
	cp a, $04 ; $6332
	jr c, .store ; $6334
	xor a, a ; $6336
.store:
	ld [$d826], a ; $6337
	ret ; $633a
DrawCpuDifficultyCursorBox:
	ld a, [$d826] ; $633b
	add a, a ; $633e
	ld hl, Data_38_635d ; $633f
	add a, l ; $6342
	ld l, a ; $6343
	jr nc, Label_38_6347 ; $6344
	inc h ; $6346
Label_38_6347:
	ld a, [hl+] ; $6347
	ld d, [hl] ; $6348
	ld e, a ; $6349
	ld a, [$d826] ; $634a
	add a, a ; $634d
	ld hl, Data_38_6365 ; $634e
	add a, l ; $6351
	ld l, a ; $6352
	jr nc, Label_38_6356 ; $6353
	inc h ; $6355
Label_38_6356:
	ld a, [hl+] ; $6356
	ld b, [hl] ; $6357
	ld c, a ; $6358
	call DrawSelectedOptionBox ; $6359
	ret ; $635c
Data_38_635d:
	; $635d, 8 bytes (bytes:8)
	db $80, $04, $80, $28, $80, $56, $80, $76 ; 0x00
Data_38_6365:
	; $6365, 8 bytes (bytes:8)
	db $04, $20, $04, $2a, $04, $1c, $04, $27 ; 0x00
OpenCpuDifficultyPanel:
	ldh a, [hWramBank] ; $636d
	push af ; $636f
	wram_bank $03 ; $6370
	ld hl, $d240 ; $6376
	ld de, $d1c0 ; $6379
	ld b, $14 ; $637c
	ld c, $04 ; $637e
	farcall CopyTilemapRect ; $6380
	ld hl, $d640 ; $6383
	ld de, $d5c0 ; $6386
	ld b, $14 ; $6389
	ld c, $04 ; $638b
	farcall CopyTilemapRect ; $638d
	pop af ; $6390
	wram_bank ; $6391
	ret ; $6395
QueueCpuDifficultyPanelToVram:
	ldh a, [hWramBank] ; $6396
	push af ; $6398
	wram_bank $03 ; $6399
	ld hl, $d1c0 ; $639f
	ld de, $99c0 ; $63a2
	ld c, $08 ; $63a5
	call QueueVRAMCopy ; $63a7
	ld hl, $d5c0 ; $63aa
	ld de, $b9c0 ; $63ad
	ld c, $08 ; $63b0
	call QueueVRAMCopy ; $63b2
	pop af ; $63b5
	wram_bank ; $63b6
	ret ; $63ba
	ret ; $63bb
	ret ; $63bc
RunLinkCharSelectScreen:
	xor a, a ; $63bd
	ldh [$ffd8], a ; $63be
	ldh [$ffe4], a ; $63c0
	ld [wMenuCursor2X], a ; $63c2
	ld [wMenuCursor2Y], a ; $63c5
	ldh [$ffe3], a ; $63c8
	call ResetSerialState ; $63ca
	call EnableTimerInterrupt ; $63cd
	sound $03 ; $63d0
	wram_bank $03 ; $63d2
	ld a, $02 ; $63d8
	ld [$df00], a ; $63da
	ld a, [wMatchIsDoubles] ; $63dd
	or a, a ; $63e0
	jr nz, .singles ; $63e1
	ldh a, [hLinkState] ; $63e3
	cp a, $01 ; $63e5
	jr nz, .slave4 ; $63e7
	ld a, $02 ; $63e9
	jr .storeMode ; $63eb
.slave4:
	ld a, $03 ; $63ed
	jr .storeMode ; $63ef
.singles:
	ldh a, [hLinkState] ; $63f1
	cp a, $01 ; $63f3
	jr nz, .slave2 ; $63f5
	ld a, $04 ; $63f7
	jr .storeMode ; $63f9
.slave2:
	ld a, $05 ; $63fb
.storeMode:
	ld [$d813], a ; $63fd
	call DisableLCDSafely ; $6400
	farcall LoadMenuFontGfx ; $6403
	xor a, a ; $6406
	ld [$d81d], a ; $6407
	ld a, $ff ; $640a
	ld [$d822], a ; $640c
	ld a, [wMatchIsDoubles] ; $640f
	ld b, a ; $6412
	ld a, [wMatchTypeNumberOfSets] ; $6413
	ld c, a ; $6416
	ld a, [wMatchTypeNumberOfGames] ; $6417
	push af ; $641a
	push bc ; $641b
	call SetupCharGridScreen ; $641c
	pop bc ; $641f
	pop af ; $6420
	ld [wMatchTypeNumberOfGames], a ; $6421
	ld a, b ; $6424
	ld [wMatchIsDoubles], a ; $6425
	ld a, c ; $6428
	ld [wMatchTypeNumberOfSets], a ; $6429
	call EnableLCD ; $642c
	farcall ResyncLinkSession ; $642f
	script_fade_in $10 ; $6432
	push af ; $6437
	farcall RunLinkCommandFrame ; $6438
	pop af ; $643b
	push af ; $643c
	farcall RunLinkCommandFrame ; $643d
	pop af ; $6440
	xor a, a ; $6441
	ldh [$ffe2], a ; $6442
	call InitCharGridState ; $6444
	xor a, a ; $6447
	ldh [$ffe4], a ; $6448
	ld [wMenuCursor2X], a ; $644a
	ld [wMenuCursor2Y], a ; $644d
	ldh [$ffe3], a ; $6450
	xor a, a ; $6452
	ldh [hLinkRemoteInputBuf], a ; $6453
	ldh [hLinkRemoteInput], a ; $6455
	ld [$d838], a ; $6457
	ld [$cb72], a ; $645a
	ld a, $01 ; $645d
	ld hl, TickMenuBgScrollTask_38 ; $645f
	call RegisterFrameTask ; $6462
	wram_bank $03 ; $6465
	call RefreshCharInfoPanel ; $646b
.frameLoop:
	push af ; $646e
	farcall RunLinkCommandFrame ; $646f
	pop af ; $6472
	ldh a, [hLinkRemoteInputBuf] ; $6473
	ld [wMenuInputPressed], a ; $6475
	ld a, [wMenuInputPressed] ; $6478
	xor a, $0f ; $647b
	jr nz, .afterStartup ; $647d
	call JumpSoftReset ; $647f
.afterStartup:
	call WaitLinkSelectStartupFrames ; $6482
	or a, a ; $6485
	jr z, .frameLoop ; $6486
	ld b, $03 ; $6488
	ld c, $02 ; $648a
	call HandleCharGridDpad ; $648c
	call HandleLinkGridButtons ; $648f
	call ProcessLinkSelectCommand ; $6492
	ldh a, [hWramBank] ; $6495
	push af ; $6497
	wram_bank $03 ; $6498
	call CheckLinkSelectionComplete ; $649e
	ld a, [$d814] ; $64a1
	cp a, $04 ; $64a4
	jr z, .waitBanner ; $64a6
	call DrawCharGridCursorBox ; $64a8
	call DrawCharGridCharSprites ; $64ab
	call DrawCharGridScrollArrows ; $64ae
	jr .refresh ; $64b1
.waitBanner:
	call DrawCharGridWaitBanner ; $64b3
.refresh:
	ld a, [$d815] ; $64b6
	ld b, a ; $64b9
	pop af ; $64ba
	wram_bank ; $64bb
	ld a, b ; $64bf
	cp a, $01 ; $64c0
	jr z, .checkDone ; $64c2
	cp a, $02 ; $64c4
	jr z, .done ; $64c6
	jp .frameLoop ; $64c8
.checkDone:
	call ClearFrameTasks ; $64cb
	call ProcessLinkSelectCommand ; $64ce
	sound $5f ; $64d1
	push af ; $64d3
	farcall SyncLinkFrame ; $64d4
	pop af ; $64d7
	xor a, a ; $64d8
	ldh [$ffd8], a ; $64d9
	call ResetSerialState ; $64db
	call EnableTimerInterrupt ; $64de
	call ResolveSelectedCharIds ; $64e1
	call InitLinkMatchCharsFromSelection ; $64e4
	call ApplyStarFlagsToCharRecords ; $64e7
	call ApplyCpuDifficultyToCharRecords ; $64ea
	ldh a, [hLinkState] ; $64ed
	cp a, $01 ; $64ef
	jr nz, .finish ; $64f1
	call WaitVBlank ; $64f3
.finish:
	ld c, $08 ; $64f6
	call BeginFadeOut ; $64f8
	call WaitFadeEnd ; $64fb
	ld hl, rIE ; $64fe
	set 2, [hl] ; $6501
	xor a, a ; $6503
	ret ; $6504
.done:
	call ClearFrameTasks ; $6505
	sound $62 ; $6508
	push af ; $650a
	farcall SyncLinkFrame ; $650b
	pop af ; $650e
	xor a, a ; $650f
	ldh [$ffd8], a ; $6510
	call ResetSerialState ; $6512
	ld c, $10 ; $6515
	call BeginFadeOut ; $6517
	call WaitFadeEnd ; $651a
	call ClearFrameTasks ; $651d
	ld hl, rIE ; $6520
	set 2, [hl] ; $6523
	ld a, $ff ; $6525
	ret ; $6527
ProcessLinkSelectCommand:
	ldh a, [hLinkRemoteInput] ; $6528
	cp a, $20 ; $652a
	jr nz, .cmd21 ; $652c
	call JumpSoftReset ; $652e
	jp .done ; $6531
.cmd21:
	cp a, $21 ; $6534
	jr nz, .cmd23 ; $6536
	ld a, [$d81d] ; $6538
	cp a, $02 ; $653b
	jp z, .done ; $653d
	ld a, [$d821] ; $6540
	cp a, $22 ; $6543
	jp z, .done ; $6545
	ld c, a ; $6548
	call ApplyRemoteCharSelection ; $6549
	jp .done ; $654c
.cmd23:
	cp a, $23 ; $654f
	jr nz, .cmd28 ; $6551
	call ApplyRemoteCharCancel ; $6553
	jp .done ; $6556
.cmd28:
	cp a, $28 ; $6559
	jr nz, .cmd29 ; $655b
	ld a, [$d81d] ; $655d
	cp a, $02 ; $6560
	jp z, .done ; $6562
	ld a, [$d821] ; $6565
	cp a, $22 ; $6568
	jp z, .done ; $656a
	ld a, [$d821] ; $656d
	ld c, a ; $6570
	call IsStarCharacter ; $6571
	or a, a ; $6574
	jr z, .applySelection ; $6575
	ld a, [$d813] ; $6577
	cp a, $03 ; $657a
	jr z, .markOwnSlot ; $657c
	cp a, $05 ; $657e
	jr z, .markOwnSlot ; $6580
	ld a, [$d81d] ; $6582
	ld hl, $d836 ; $6585
	add a, l ; $6588
	ld l, a ; $6589
	jr nc, .markSlotTaken ; $658a
	inc h ; $658c
.markSlotTaken:
	ld [hl], $01 ; $658d
	jr .applySelection ; $658f
.markOwnSlot:
	ld a, [$d81d] ; $6591
	ld hl, $d834 ; $6594
	add a, l ; $6597
	ld l, a ; $6598
	jr nc, .markOwnSlotTaken ; $6599
	inc h ; $659b
.markOwnSlotTaken:
	ld [hl], $01 ; $659c
.applySelection:
	ld a, [$d821] ; $659e
	ld c, a ; $65a1
	call ApplyRemoteCharSelection ; $65a2
	jr .done ; $65a5
.cmd29:
	cp a, $29 ; $65a7
	jr nz, .cmd24 ; $65a9
	jr .done ; $65ab
.cmd24:
	cp a, $24 ; $65ad
	jr nz, .cmd25 ; $65af
	ld c, $01 ; $65b1
	call StoreRemoteCpuDifficulty ; $65b3
	ld a, [$d820] ; $65b6
	ld c, a ; $65b9
	call DrawRemoteSlotPortrait ; $65ba
	xor a, a ; $65bd
	ld [$d838], a ; $65be
	jr .done ; $65c1
.cmd25:
	cp a, $25 ; $65c3
	jr nz, .cmd26 ; $65c5
	ld c, $02 ; $65c7
	call StoreRemoteCpuDifficulty ; $65c9
	ld a, [$d820] ; $65cc
	ld c, a ; $65cf
	call DrawRemoteSlotPortrait ; $65d0
	xor a, a ; $65d3
	ld [$d838], a ; $65d4
	jr .done ; $65d7
.cmd26:
	cp a, $26 ; $65d9
	jr nz, .cmd27 ; $65db
	ld c, $03 ; $65dd
	call StoreRemoteCpuDifficulty ; $65df
	ld a, [$d820] ; $65e2
	ld c, a ; $65e5
	call DrawRemoteSlotPortrait ; $65e6
	xor a, a ; $65e9
	ld [$d838], a ; $65ea
	jr .done ; $65ed
.cmd27:
	cp a, $27 ; $65ef
	jr nz, .unknownCmd ; $65f1
	ld c, $04 ; $65f3
	call StoreRemoteCpuDifficulty ; $65f5
	ld a, [$d820] ; $65f8
	ld c, a ; $65fb
	call DrawRemoteSlotPortrait ; $65fc
	xor a, a ; $65ff
	ld [$d838], a ; $6600
	jr .done ; $6603
.unknownCmd:
	ld [$d821], a ; $6605
.done:
	ret ; $6608
StoreRemoteCpuDifficulty:
	ld a, [$d813] ; $6609
	cp a, $03 ; $660c
	jr z, .slot0 ; $660e
	cp a, $05 ; $6610
	jr z, .slot0 ; $6612
	ld a, c ; $6614
	ld [$d833], a ; $6615
	ret ; $6618
.slot0:
	ld a, c ; $6619
	ld [$d831], a ; $661a
	ret ; $661d
ApplyRemoteCharSelection:
	ldh a, [hWramBank] ; $661e
	push af ; $6620
	wram_bank $03 ; $6621
	push bc ; $6627
	ld d, c ; $6628
	ld e, $01 ; $6629
	call SetGridEntryTakenByCharId ; $662b
	pop bc ; $662e
	cp a, $ff ; $662f
	jr z, .done ; $6631
	push bc ; $6633
	call DrawRemoteSlotPortrait ; $6634
	call BuildVisiblePageSpriteList ; $6637
	pop bc ; $663a
	ld a, [$d81d] ; $663b
	cp a, $00 ; $663e
	jr nz, .slot2 ; $6640
	ld a, c ; $6642
	ld [$d81f], a ; $6643
	jr .advanceSlot ; $6646
.slot2:
	ld a, c ; $6648
	ld [$d820], a ; $6649
.advanceSlot:
	call AdvanceRemotePlayerSlot ; $664c
.done:
	pop af ; $664f
	wram_bank ; $6650
	ret ; $6654
ApplyRemoteCharCancel:
	push bc ; $6655
	call RetreatRemotePlayerSlot ; $6656
	pop bc ; $6659
	cp a, $ff ; $665a
	jr z, Label_38_66c2 ; $665c
	ld a, [$d81d] ; $665e
	cp a, $00 ; $6661
	jr nz, Label_38_666b ; $6663
	ld a, [$d81f] ; $6665
	ld c, a ; $6668
	jr Label_38_666f ; $6669
Label_38_666b:
	ld a, [$d820] ; $666b
	ld c, a ; $666e
Label_38_666f:
	ld d, c ; $666f
	ld e, $00 ; $6670
	call SetGridEntryTakenByCharId ; $6672
	wram_bank $03 ; $6675
	ld a, [$d813] ; $667b
	cp a, $03 ; $667e
	jr z, Label_38_66a2 ; $6680
	cp a, $05 ; $6682
	jr z, Label_38_66a2 ; $6684
	ld a, [$d81d] ; $6686
	ld hl, $d832 ; $6689
	add a, l ; $668c
	ld l, a ; $668d
	jr nc, Label_38_6691 ; $668e
	inc h ; $6690
Label_38_6691:
	xor a, a ; $6691
	ld [hl], a ; $6692
	ld a, [$d81d] ; $6693
	ld hl, $d836 ; $6696
	add a, l ; $6699
	ld l, a ; $669a
	jr nc, Label_38_669e ; $669b
	inc h ; $669d
Label_38_669e:
	xor a, a ; $669e
	ld [hl], a ; $669f
	jr Label_38_66bc ; $66a0
Label_38_66a2:
	ld a, [$d81d] ; $66a2
	ld hl, $d830 ; $66a5
	add a, l ; $66a8
	ld l, a ; $66a9
	jr nc, Label_38_66ad ; $66aa
	inc h ; $66ac
Label_38_66ad:
	xor a, a ; $66ad
	ld [hl], a ; $66ae
	ld a, [$d81d] ; $66af
	ld hl, $d834 ; $66b2
	add a, l ; $66b5
	ld l, a ; $66b6
	jr nc, Label_38_66ba ; $66b7
	inc h ; $66b9
Label_38_66ba:
	xor a, a ; $66ba
	ld [hl], a ; $66bb
Label_38_66bc:
	call ClearRemoteSlotPortrait ; $66bc
	call BuildVisiblePageSpriteList ; $66bf
Label_38_66c2:
	ret ; $66c2
	ld a, [$d813] ; $66c3
	cp a, $03 ; $66c6
	jr z, Label_38_66dc ; $66c8
	cp a, $05 ; $66ca
	jr z, Label_38_66dc ; $66cc
	ld a, [$d81f] ; $66ce
	ld [$d818], a ; $66d1
	ld a, [$d820] ; $66d4
	ld [$d819], a ; $66d7
	jr Label_38_66e8 ; $66da
Label_38_66dc:
	ld a, [$d81f] ; $66dc
	ld [$d816], a ; $66df
	ld a, [$d820] ; $66e2
	ld [$d817], a ; $66e5
Label_38_66e8:
	ret ; $66e8
CheckLinkSelectionComplete:
	ldh a, [hWramBank] ; $66e9
	push af ; $66eb
	wram_bank $03 ; $66ec
	ld a, [$d814] ; $66f2
	cp a, $04 ; $66f5
	jr nz, Label_38_6705 ; $66f7
	ld a, [$d81d] ; $66f9
	cp a, $02 ; $66fc
	jr nz, Label_38_6705 ; $66fe
	ld a, $01 ; $6700
	ld [$d815], a ; $6702
Label_38_6705:
	ld a, [$d814] ; $6705
	cp a, $ff ; $6708
	jr z, Label_38_6715 ; $670a
	ld a, [$d81d] ; $670c
	cp a, $ff ; $670f
	jr z, Label_38_6715 ; $6711
	jr Label_38_671a ; $6713
Label_38_6715:
	ld a, $02 ; $6715
	ld [$d815], a ; $6717
Label_38_671a:
	pop af ; $671a
	wram_bank ; $671b
	ret ; $671f
HandleLinkGridButtons:
	ld a, [wMenuInputPressed] ; $6720
	and a, $f0 ; $6723
	ret nz ; $6725
	ld a, [wMenuInputPressed] ; $6726
	bit PADB_A, a ; $6729
	jr nz, .confirm ; $672b
	bit 1, a ; $672d
	jr nz, .cancel ; $672f
	bit 3, a ; $6731
	jr nz, .checkStar ; $6733
	ret ; $6735
.confirm:
	call ConfirmLinkGridSelection ; $6736
	ret ; $6739
.cancel:
	call CancelLinkGridSelection ; $673a
	ret ; $673d
.checkStar:
	call GetGridSlotFromCursor ; $673e
	ld b, a ; $6741
	ld hl, $da00 ; $6742
	add a, a ; $6745
	add a, a ; $6746
	add a, l ; $6747
	ld l, a ; $6748
	jr nc, .readCharId ; $6749
	inc h ; $674b
.readCharId:
	ld a, [hl] ; $674c
	ld c, a ; $674d
	call IsStarCharacter ; $674e
	or a, a ; $6751
	jr z, .done ; $6752
	sound $5e ; $6754
	ld a, [$df00] ; $6756
	cp a, $02 ; $6759
	jr z, .starChar ; $675b
	xor a, $01 ; $675d
	ld [$df00], a ; $675f
	call RefreshCharInfoPanel ; $6762
	ret ; $6765
.starChar:
	ld a, $01 ; $6766
	ld [$df00], a ; $6768
	call RefreshCharInfoPanel ; $676b
.done:
	ret ; $676e
ConfirmLinkGridSelection:
	ldh a, [hWramBank] ; $676f
	push af ; $6771
	wram_bank $03 ; $6772
	ld a, [$d814] ; $6778
	cp a, $04 ; $677b
	jr z, .allSlotsFilled ; $677d
	ldh a, [hLinkRemoteInput] ; $677f
	cp a, $21 ; $6781
	jr nz, .readEntry ; $6783
	ld a, $22 ; $6785
	ldh [hLinkRemoteInput], a ; $6787
	jr .allSlotsFilled ; $6789
.readEntry:
	ld a, [$d811] ; $678b
	ld c, a ; $678e
	ld a, [wMenuCursorX] ; $678f
	ld d, a ; $6792
	ld a, [wMenuCursorY] ; $6793
	ld e, a ; $6796
	call TestAndSetGridEntryTaken ; $6797
	or a, a ; $679a
	jr nz, .allSlotsFilled ; $679b
	sound $5f ; $679d
	call GetGridSlotFromCursor ; $679f
	ld b, a ; $67a2
	ld hl, $da00 ; $67a3
	add a, a ; $67a6
	add a, a ; $67a7
	add a, l ; $67a8
	ld l, a ; $67a9
	jr nc, .markStar ; $67aa
	inc h ; $67ac
.markStar:
	ld a, [hl] ; $67ad
	cp a, $ff ; $67ae
	jr z, .allSlotsFilled ; $67b0
	ld c, a ; $67b2
	call IsStarCharacter ; $67b3
	or a, a ; $67b6
	jr z, .emptyCell ; $67b7
	ld a, [$df00] ; $67b9
	cp a, $01 ; $67bc
	jr nz, .emptyCell ; $67be
	ld a, [$d814] ; $67c0
	ld hl, $d834 ; $67c3
	add a, l ; $67c6
	ld l, a ; $67c7
	jr nc, .drawPortrait ; $67c8
	inc h ; $67ca
.drawPortrait:
	ld a, $01 ; $67cb
	ld [hl], a ; $67cd
.emptyCell:
	ld a, [$d814] ; $67ce
	ld hl, $d816 ; $67d1
	add a, l ; $67d4
	ld l, a ; $67d5
	jr nc, .advanceSlot ; $67d6
	inc h ; $67d8
.advanceSlot:
	ld [hl], b ; $67d9
	call DrawPlayerSlotPortrait ; $67da
	jr .refresh ; $67dd
.allSlotsFilled:
	sound $62 ; $67df
	pop af ; $67e1
	wram_bank ; $67e2
	ret ; $67e6
.refresh:
	call BuildVisiblePageSpriteList ; $67e7
	call AdvanceToNextPlayerSlot ; $67ea
	cp a, $04 ; $67ed
	jr nz, .done ; $67ef
.done:
	call DrawCharGridSlotPrompt ; $67f1
	ld hl, $d040 ; $67f4
	ld de, $9840 ; $67f7
	ld c, $04 ; $67fa
	call QueueVRAMCopy ; $67fc
	pop af ; $67ff
	wram_bank ; $6800
	ret ; $6804
CancelLinkGridSelection:
	ldh a, [hWramBank] ; $6805
	push af ; $6807
	wram_bank $03 ; $6808
	call RetreatToPreviousPlayerSlot ; $680e
	cp a, $ff ; $6811
	jr nz, .clearSlot ; $6813
	pop af ; $6815
	wram_bank ; $6816
	ret ; $681a
.clearSlot:
	cp a, $fe ; $681b
	jr nz, .clearTaken ; $681d
	xor a, a ; $681f
	ld [wMenuCursorX], a ; $6820
	ld [wMenuCursorY], a ; $6823
	ld [wMenuCursor2X], a ; $6826
	ld [wMenuCursor2Y], a ; $6829
	ld [$d811], a ; $682c
	ldh [$ffe3], a ; $682f
	call RefreshCharInfoPanel ; $6831
.clearTaken:
	sound $62 ; $6834
	ld hl, $d816 ; $6836
	ld a, [$d814] ; $6839
	add a, l ; $683c
	ld l, a ; $683d
	jr nc, .clearRecord ; $683e
	inc h ; $6840
.clearRecord:
	ld a, [hl] ; $6841
	ld b, $00 ; $6842
	ld [hl], b ; $6844
	ld hl, $da00 ; $6845
	add a, a ; $6848
	add a, a ; $6849
	add a, l ; $684a
	ld l, a ; $684b
	jr nc, .refresh ; $684c
	inc h ; $684e
.refresh:
	inc hl ; $684f
	inc hl ; $6850
	xor a, a ; $6851
	ld [hl], a ; $6852
	wram_bank $03 ; $6853
	ld hl, $d830 ; $6859
	ld a, [$d814] ; $685c
	add a, l ; $685f
	ld l, a ; $6860
	jr nc, .redraw ; $6861
	inc h ; $6863
.redraw:
	xor a, a ; $6864
	ld [hl], a ; $6865
	ld hl, $d834 ; $6866
	ld a, [$d814] ; $6869
	add a, l ; $686c
	ld l, a ; $686d
	jr nc, .done ; $686e
	inc h ; $6870
.done:
	xor a, a ; $6871
	ld [hl], a ; $6872
	call ClearPlayerSlotPortrait ; $6873
	call BuildVisiblePageSpriteList ; $6876
	call DrawCharGridSlotPrompt ; $6879
	ld hl, $d040 ; $687c
	ld de, $9840 ; $687f
	ld c, $04 ; $6882
	call QueueVRAMCopy ; $6884
	pop af ; $6887
	wram_bank ; $6888
	ret ; $688c
DrawRemoteSlotPortrait:
	ldh a, [hWramBank] ; $688d
	push af ; $688f
	wram_bank $03 ; $6890
	ld a, c ; $6896
	push bc ; $6897
	farcall GetCharPaletteIndex ; $6898
	pop bc ; $689b
	ld d, a ; $689c
	ld e, c ; $689d
	call GetRemoteSlotBoxAddress ; $689e
	ld h, d ; $68a1
	ld l, e ; $68a2
	ld d, b ; $68a3
	ld e, c ; $68a4
	ld b, l ; $68a5
	ld c, h ; $68a6
	call WriteCharPortraitTiles ; $68a7
	call DrawRemoteSlotStarMark ; $68aa
	ld a, [$d813] ; $68ad
	cp a, $03 ; $68b0
	jr z, .slot0 ; $68b2
	cp a, $05 ; $68b4
	jr z, .slot0 ; $68b6
	ld hl, $d120 ; $68b8
	ld de, $9920 ; $68bb
	ld c, $04 ; $68be
	call QueueVRAMCopy ; $68c0
	ld hl, $d520 ; $68c3
	ld de, $b920 ; $68c6
	ld c, $04 ; $68c9
	call QueueVRAMCopy ; $68cb
	jr .done ; $68ce
.slot0:
	ld hl, $d0c0 ; $68d0
	ld de, $98c0 ; $68d3
	ld c, $04 ; $68d6
	call QueueVRAMCopy ; $68d8
	ld hl, $d4c0 ; $68db
	ld de, $b8c0 ; $68de
	ld c, $04 ; $68e1
	call QueueVRAMCopy ; $68e3
.done:
	pop af ; $68e6
	wram_bank ; $68e7
	ret ; $68eb
DrawRemoteSlotStarMark:
	ld a, [$d813] ; $68ec
	cp a, $03 ; $68ef
	jr z, .checkOwnSlot ; $68f1
	cp a, $05 ; $68f3
	jr z, .checkOwnSlot ; $68f5
	ld a, [$d81d] ; $68f7
	ld hl, $d836 ; $68fa
	add a, l ; $68fd
	ld l, a ; $68fe
	jr nc, .checkStar ; $68ff
	inc h ; $6901
.checkStar:
	ld a, [hl] ; $6902
	or a, a ; $6903
	ret z ; $6904
	jr .draw ; $6905
.checkOwnSlot:
	ld a, [$d81d] ; $6907
	ld hl, $d834 ; $690a
	add a, l ; $690d
	ld l, a ; $690e
	jr nc, .checkOwnStar ; $690f
	inc h ; $6911
.checkOwnStar:
	ld a, [hl] ; $6912
	or a, a ; $6913
	ret z ; $6914
.draw:
	call GetRemoteSlotBoxAddress ; $6915
	ld hl, $001f ; $6918
	add hl, bc ; $691b
	ld a, $32 ; $691c
	ld [hl], a ; $691e
	ret ; $691f
	ld a, [$d813] ; $6920
	cp a, $03 ; $6923
	jr z, .queueVram ; $6925
	cp a, $05 ; $6927
	jr z, .queueVram ; $6929
	ld a, [$d833] ; $692b
	ld c, $33 ; $692e
	add a, c ; $6930
	ld hl, $d14f ; $6931
	ld [hl], a ; $6934
	jr .done ; $6935
.queueVram:
	ld a, [$d831] ; $6937
	ld c, $33 ; $693a
	add a, c ; $693c
	ld hl, $d0ef ; $693d
	ld [hl], a ; $6940
.done:
	ret ; $6941
ClearRemoteSlotPortrait:
	call GetRemoteSlotBoxAddress ; $6942
	ld d, b ; $6945
	ld e, c ; $6946
	ld b, $02 ; $6947
	ld c, $02 ; $6949
	ld h, $00 ; $694b
	push de ; $694d
	farcall FillTilemapRect ; $694e
	pop de ; $6951
	ld b, $02 ; $6952
	ld c, $02 ; $6954
	ld hl, $0400 ; $6956
	add hl, de ; $6959
	ld d, h ; $695a
	ld e, l ; $695b
	ld h, $08 ; $695c
	farcall FillTilemapRect ; $695e
	call GetRemoteSlotBoxAddress ; $6961
	ld hl, $001e ; $6964
	add hl, bc ; $6967
	xor a, a ; $6968
	ld [hl+], a ; $6969
	ld [hl], a ; $696a
	ld a, [$d813] ; $696b
	cp a, $03 ; $696e
	jr z, Label_38_698e ; $6970
	cp a, $05 ; $6972
	jr z, Label_38_698e ; $6974
	ld hl, $d120 ; $6976
	ld de, $9920 ; $6979
	ld c, $04 ; $697c
	call QueueVRAMCopy ; $697e
	ld hl, $d520 ; $6981
	ld de, $b920 ; $6984
	ld c, $04 ; $6987
	call QueueVRAMCopy ; $6989
	jr Label_38_69a4 ; $698c
Label_38_698e:
	ld hl, $d0c0 ; $698e
	ld de, $98c0 ; $6991
	ld c, $04 ; $6994
	call QueueVRAMCopy ; $6996
	ld hl, $d4c0 ; $6999
	ld de, $b8c0 ; $699c
	ld c, $04 ; $699f
	call QueueVRAMCopy ; $69a1
Label_38_69a4:
	ret ; $69a4
GetRemoteSlotBoxAddress:
	ld a, [$d813] ; $69a5
	add a, a ; $69a8
	db $21 ; $69a9
.fromCallerPtr:
	pop bc ; $69aa
	ld l, c ; $69ab
	add a, l ; $69ac
	ld l, a ; $69ad
	jr nc, .readTable ; $69ae
	inc h ; $69b0
.readTable:
	ld a, [hl+] ; $69b1
	ld h, [hl] ; $69b2
	ld l, a ; $69b3
	ld a, [$d81d] ; $69b4
	add a, a ; $69b7
	add a, l ; $69b8
	ld l, a ; $69b9
	jr nc, Label_38_69bd ; $69ba
	inc h ; $69bc
Label_38_69bd:
	ld a, [hl+] ; $69bd
	ld b, [hl] ; $69be
	ld c, a ; $69bf
	ret ; $69c0
SubHandlers_38_69c1:
	; $69c1, 12 bytes (records:2)
	dw $69cd ; record 0
	dw $69cd ; record 1
	dw $69d7 ; record 2
	dw $69cd ; record 3
	dw $69e7 ; record 4
	dw $69dd ; record 5
	ret nc ; $69cd
	ret nc ; $69ce
	nop ; $69cf
	nop ; $69d0
	nop ; $69d1
	nop ; $69d2
	nop ; $69d3
	nop ; $69d4
	nop ; $69d5
	nop ; $69d6
	jr nc, GetRemoteSlotBoxAddress.fromCallerPtr ; $69d7
	nop ; $69d9
	nop ; $69da
	nop ; $69db
	nop ; $69dc
	call $d1d0 ; $69dd
	ret nc ; $69e0
	nop ; $69e1
	nop ; $69e2
	nop ; $69e3
	nop ; $69e4
	nop ; $69e5
	nop ; $69e6
	dec l ; $69e7
	pop de ; $69e8
	ld sp, $00d1 ; $69e9
	nop ; $69ec
AdvanceRemotePlayerSlot:
	ld a, [$d813] ; $69ed
	ld hl, $6a27 ; $69f0
	add a, a ; $69f3
	add a, l ; $69f4
	ld l, a ; $69f5
	jr nc, Label_38_69f9 ; $69f6
	inc h ; $69f8
Label_38_69f9:
	ld a, [hl+] ; $69f9
	ld h, [hl] ; $69fa
	ld l, a ; $69fb
	ld a, [$d81d] ; $69fc
	ld b, a ; $69ff
Label_38_6a00:
	ld a, [hl+] ; $6a00
	cp a, b ; $6a01
	jr nz, Label_38_6a00 ; $6a02
	ld a, [hl] ; $6a04
	ld [$d81d], a ; $6a05
	ret ; $6a08
RetreatRemotePlayerSlot:
	ld a, [$d813] ; $6a09
	ld hl, $6a27 ; $6a0c
	add a, a ; $6a0f
	add a, l ; $6a10
	ld l, a ; $6a11
	jr nc, Label_38_6a15 ; $6a12
	inc h ; $6a14
Label_38_6a15:
	ld a, [hl+] ; $6a15
	ld h, [hl] ; $6a16
	ld l, a ; $6a17
	ld a, [$d81d] ; $6a18
	ld b, a ; $6a1b
Label_38_6a1c:
	ld a, [hl+] ; $6a1c
	cp a, b ; $6a1d
	jr nz, Label_38_6a1c ; $6a1e
	dec hl ; $6a20
	dec hl ; $6a21
	ld a, [hl] ; $6a22
	ld [$d81d], a ; $6a23
	ret ; $6a26
	inc sp ; $6a27
	ld l, d ; $6a28
	inc sp ; $6a29
	ld l, d ; $6a2a
	inc sp ; $6a2b
	ld l, d ; $6a2c
	inc sp ; $6a2d
	ld l, d ; $6a2e
	scf ; $6a2f
	ld l, d ; $6a30
	scf ; $6a31
	ld l, d ; $6a32
	rst Rst38 ; $6a33
	nop ; $6a34
	ld [bc], a ; $6a35
	rst Rst38 ; $6a36
	rst Rst38 ; $6a37
	nop ; $6a38
	ld bc, rSC ; $6a39
	call GetGridSlotFromCursor ; $6a3c
	ld hl, $da00 ; $6a3f
	add a, a ; $6a42
	add a, a ; $6a43
	add a, l ; $6a44
	ld l, a ; $6a45
	jr nc, Label_38_6a49 ; $6a46
	inc h ; $6a48
Label_38_6a49:
	ld a, [hl] ; $6a49
	ret ; $6a4a
SetGridEntryTakenByCharId:
	ld a, d ; $6a4b
	cp a, $04 ; $6a4c
	jr nc, .search ; $6a4e
	xor a, a ; $6a50
	ret ; $6a51
.search:
	ld c, $00 ; $6a52
	ld hl, $da00 ; $6a54
.searchLoop:
	ld a, [hl] ; $6a57
	cp a, d ; $6a58
	jr z, .found ; $6a59
	inc hl ; $6a5b
	inc hl ; $6a5c
	inc hl ; $6a5d
	inc hl ; $6a5e
	ld a, c ; $6a5f
	inc a ; $6a60
	ld c, a ; $6a61
	cp a, $1f ; $6a62
	jr nz, .searchLoop ; $6a64
	ld a, $fe ; $6a66
	ret ; $6a68
.found:
	inc hl ; $6a69
	inc hl ; $6a6a
	ld a, e ; $6a6b
	or a, a ; $6a6c
	jr z, .clear ; $6a6d
	ld a, [hl] ; $6a6f
	or a, a ; $6a70
	jr nz, .done ; $6a71
	ld a, $01 ; $6a73
	ld [hl], a ; $6a75
	jr .store ; $6a76
.clear:
	ld [hl], e ; $6a78
.store:
	ld a, $01 ; $6a79
	ret ; $6a7b
.done:
	ld a, $ff ; $6a7c
	ret ; $6a7e
InitLinkMatchCharsFromSelection:
	ldh a, [hWramBank] ; $6a7f
	push af ; $6a81
	wram_bank $03 ; $6a82
	call CacheStorySlotNames ; $6a88
	ld a, [$d813] ; $6a8b
	cp a, $03 ; $6a8e
	jr z, .slot3Entry ; $6a90
	cp a, $05 ; $6a92
	jr z, .slot3Entry ; $6a94
	ld a, [$d816] ; $6a96
	cp a, $ff ; $6a99
	jr z, .slot2 ; $6a9b
	cp a, $80 ; $6a9d
	jr c, .slot1Created ; $6a9f
	ld c, a ; $6aa1
	and a, $07 ; $6aa2
	srl a ; $6aa4
	ld b, a ; $6aa6
	ld a, c ; $6aa7
	call LoadCachedStorySlotName ; $6aa8
	and a, $81 ; $6aab
	ld b, a ; $6aad
	ld c, $00 ; $6aae
	farcall InitCa00RecordFromCharId ; $6ab0
	jr .slot2 ; $6ab3
.slot1Created:
	ld b, a ; $6ab5
	ld c, $00 ; $6ab6
	farcall InitCa00RecordFromCharId ; $6ab8
.slot2:
	ld a, [$d817] ; $6abb
	cp a, $ff ; $6abe
	jr z, .slot3 ; $6ac0
	cp a, $80 ; $6ac2
	jr c, .slot2Created ; $6ac4
	ld c, a ; $6ac6
	and a, $07 ; $6ac7
	srl a ; $6ac9
	ld b, a ; $6acb
	ld a, c ; $6acc
	call LoadCachedStorySlotName ; $6acd
	and a, $81 ; $6ad0
	ld b, a ; $6ad2
	ld c, $01 ; $6ad3
	farcall InitCa00RecordFromCharId ; $6ad5
	jr .slot3 ; $6ad8
.slot2Created:
	ld b, a ; $6ada
	ld c, $01 ; $6adb
	farcall InitCa00RecordFromCharId ; $6add
.slot3:
	jr .applySettings ; $6ae0
.slot3Entry:
	ld a, [$d818] ; $6ae2
	cp a, $ff ; $6ae5
	jr z, .slot4 ; $6ae7
	cp a, $80 ; $6ae9
	jr c, .slot3Created ; $6aeb
	ld c, a ; $6aed
	and a, $07 ; $6aee
	srl a ; $6af0
	ld b, a ; $6af2
	ld a, c ; $6af3
	call LoadCachedStorySlotName ; $6af4
	and a, $81 ; $6af7
	ld b, a ; $6af9
	ld c, $02 ; $6afa
	farcall InitCa00RecordFromCharId ; $6afc
	jr .slot4 ; $6aff
.slot3Created:
	ld b, a ; $6b01
	ld c, $02 ; $6b02
	farcall InitCa00RecordFromCharId ; $6b04
.slot4:
	ld a, [$d819] ; $6b07
	cp a, $ff ; $6b0a
	jr z, .applySettings ; $6b0c
	cp a, $80 ; $6b0e
	jr c, .slot4Created ; $6b10
	ld c, a ; $6b12
	and a, $07 ; $6b13
	srl a ; $6b15
	ld b, a ; $6b17
	ld a, c ; $6b18
	call LoadCachedStorySlotName ; $6b19
	and a, $81 ; $6b1c
	ld b, a ; $6b1e
	ld c, $03 ; $6b1f
	farcall InitCa00RecordFromCharId ; $6b21
	jr .applySettings ; $6b24
.slot4Created:
	ld b, a ; $6b26
	ld c, $03 ; $6b27
	farcall InitCa00RecordFromCharId ; $6b29
.applySettings:
	pop af ; $6b2c
	wram_bank ; $6b2d
	ret ; $6b31
	ld a, [$d813] ; $6b32
	cp a, $03 ; $6b35
	ret z ; $6b37
	cp a, $02 ; $6b38
	ret z ; $6b3a
	xor a, a ; $6b3b
	ld [$d839], a ; $6b3c
	ld [$d826], a ; $6b3f
.doubles:
	push af ; $6b42
	farcall RunLinkInputFrame ; $6b43
	pop af ; $6b46
	ldh a, [hLinkRemoteInputBuf] ; $6b47
	ld [wMenuInputPressed], a ; $6b49
	ld a, [wMenuInputPressed] ; $6b4c
	xor a, $0f ; $6b4f
	jr nz, .done ; $6b51
	call JumpSoftReset ; $6b53
.done:
	push de ; $6b56
	push af ; $6b57
	ld a, [$d839] ; $6b58
	ld de, $0303 ; $6b5b
	call PrintDecimalByte ; $6b5e
	pop af ; $6b61
	pop de ; $6b62
	push de ; $6b63
	push af ; $6b64
	ld a, [$d826] ; $6b65
	ld de, $0304 ; $6b68
	call PrintDecimalByte ; $6b6b
	pop af ; $6b6e
	pop de ; $6b6f
	call RunLinkCpuDifficultySubmenu ; $6b70
	call HandleLinkCpuDifficultyInput ; $6b73
	jr .doubles ; $6b76
	ret ; $6b78
HandleLinkCpuDifficultyInput:
	ldh a, [hLinkRemoteInput] ; $6b79
	bit 5, a ; $6b7b
	jr nz, .decrease ; $6b7d
	bit 4, a ; $6b7f
	jr nz, .increase ; $6b81
	bit 0, a ; $6b83
	jr nz, .confirm ; $6b85
	bit 1, a ; $6b87
	jr nz, .cancel ; $6b89
	ret ; $6b8b
.decrease:
	ld a, [$d839] ; $6b8c
	dec a ; $6b8f
	add a, a ; $6b90
	jr nc, .decCheckMax ; $6b91
	ld a, $04 ; $6b93
	dec a ; $6b95
	jr .storeDecrease ; $6b96
.decCheckMax:
	rra ; $6b98
	cp a, $04 ; $6b99
	jr c, .storeDecrease ; $6b9b
	xor a, a ; $6b9d
.storeDecrease:
	ld [$d839], a ; $6b9e
	ret ; $6ba1
.increase:
	ld a, [$d839] ; $6ba2
	inc a ; $6ba5
	add a, a ; $6ba6
	jr nc, .incCheckMax ; $6ba7
	ld a, $04 ; $6ba9
	dec a ; $6bab
	jr .storeIncrease ; $6bac
.incCheckMax:
	rra ; $6bae
	cp a, $04 ; $6baf
	jr c, .storeIncrease ; $6bb1
	xor a, a ; $6bb3
.storeIncrease:
	ld [$d839], a ; $6bb4
	ret ; $6bb7
.confirm:
	call StubNop_38_6bc0 ; $6bb8
	ret ; $6bbb
.cancel:
	call StubNop_38_6bc1 ; $6bbc
	ret ; $6bbf
StubNop_38_6bc0:
	ret ; $6bc0
StubNop_38_6bc1:
	ret ; $6bc1
Data_38_6bc2:
	; $6bc2, 19 bytes (bytes:16)
	db $cd, $08, $62, $b7, $28, $0d, $fa, $14, $d8, $b7, $28, $07, $fe, $02, $28, $03 ; 0x00
	db $3e, $01, $c9 ; 0x10
	xor a, a ; $6bd5
	ret ; $6bd6
RunLinkCpuDifficultySubmenu:
	ldh a, [hWramBank] ; $6bd7
	push af ; $6bd9
	wram_bank $03 ; $6bda
	ld a, [$d825] ; $6be0
	or a, a ; $6be3
	jr nz, .inputLoop ; $6be4
	call OpenCpuDifficultyPanel ; $6be6
	call QueueCpuDifficultyPanelToVram ; $6be9
	ld a, $01 ; $6bec
	ld [$d825], a ; $6bee
.inputLoop:
	call HandleCpuDifficultyInput ; $6bf1
	call DrawCpuDifficultyCursorBox ; $6bf4
	ld a, [wMenuInputPressed] ; $6bf7
	bit PADB_A, a ; $6bfa
	jr nz, .confirm ; $6bfc
	bit 1, a ; $6bfe
	jr nz, .cancel ; $6c00
	jr .done ; $6c02
.cancel:
	call CloseCpuDifficultyPanel ; $6c04
	sound $62 ; $6c07
	wram_bank $03 ; $6c09
	call ClearPlayerSlotPortrait ; $6c0f
	call BuildVisiblePageSpriteList ; $6c12
	jr .storeDifficulty ; $6c15
.confirm:
	ld hl, $d830 ; $6c17
	ld a, [$d826] ; $6c1a
	call GetGridSlotFromCursor ; $6c1d
	call DrawPlayerSlotPortrait ; $6c20
.storeDifficulty:
	call DrawCharGridSlotPrompt ; $6c23
	ld hl, $d040 ; $6c26
	ld de, $9840 ; $6c29
	ld c, $04 ; $6c2c
	call QueueVRAMCopy ; $6c2e
.done:
	pop af ; $6c31
	wram_bank ; $6c32
	ret ; $6c36
GetGridSlotFromLinkCursor:
	ldh a, [hWramBank] ; $6c37
	push af ; $6c39
	wram_bank $03 ; $6c3a
	ld a, [wMenuCursor2X] ; $6c40
	ld d, a ; $6c43
	ld a, [wMenuCursor2Y] ; $6c44
	ld e, a ; $6c47
	ld a, e ; $6c48
	add a, a ; $6c49
	add a, e ; $6c4a
	ld e, a ; $6c4b
	ld a, d ; $6c4c
	add a, e ; $6c4d
	ld b, a ; $6c4e
	ldh a, [$ffe3] ; $6c4f
	ld c, a ; $6c51
Label_38_6c52:
	ld a, c ; $6c52
	or a, a ; $6c53
	jr z, Label_38_6c5d ; $6c54
	ld a, $03 ; $6c56
	add a, b ; $6c58
	ld b, a ; $6c59
	dec c ; $6c5a
	jr Label_38_6c52 ; $6c5b
Label_38_6c5d:
	pop af ; $6c5d
	wram_bank ; $6c5e
	ld a, b ; $6c62
	ret ; $6c63
GetLinkCursorSelectionCode:
	call GetGridSlotFromLinkCursor ; $6c64
	ld hl, $da00 ; $6c67
	add a, a ; $6c6a
	add a, a ; $6c6b
	add a, l ; $6c6c
	ld l, a ; $6c6d
	jr nc, .readEntry ; $6c6e
	inc h ; $6c70
.readEntry:
	ld a, [hl] ; $6c71
	cp a, $ff ; $6c72
	jr nz, .checkTaken ; $6c74
	ld a, $22 ; $6c76
	jr .done ; $6c78
.checkTaken:
	inc hl ; $6c7a
	inc hl ; $6c7b
	ld b, [hl] ; $6c7c
	dec hl ; $6c7d
	dec hl ; $6c7e
	ld c, a ; $6c7f
	ld a, b ; $6c80
	or a, a ; $6c81
	jr z, .useCode ; $6c82
	ld a, $22 ; $6c84
	jr .done ; $6c86
.useCode:
	ld a, c ; $6c88
.done:
	ret ; $6c89
UpdateMenuCursorFromLinkInput:
	ld b, a ; $6c8a
	ldh a, [hWramBank] ; $6c8b
	push af ; $6c8d
	wram_bank $03 ; $6c8e
	ld a, [wMenuCursor2X] ; $6c94
	ld d, a ; $6c97
	ld a, [wMenuCursor2Y] ; $6c98
	ld e, a ; $6c9b
	ld a, b ; $6c9c
	xor a, $0f ; $6c9d
	jr nz, .checkButtons ; $6c9f
	ld b, $20 ; $6ca1
	jr .storeCommand ; $6ca3
.checkButtons:
	ld a, b ; $6ca5
	and a, $f0 ; $6ca6
	ld a, b ; $6ca8
	jr nz, .checkRight ; $6ca9
	ld a, b ; $6cab
	bit 0, a ; $6cac
	jr z, .checkB ; $6cae
	ld a, [$df00] ; $6cb0
	cp a, $01 ; $6cb3
	jr nz, .sendSelect ; $6cb5
	ld b, $28 ; $6cb7
	jr .storeCommand ; $6cb9
.sendSelect:
	ld b, $21 ; $6cbb
	jr .storeCommand ; $6cbd
.checkB:
	bit 1, a ; $6cbf
	jr z, .checkRight ; $6cc1
	ld b, $23 ; $6cc3
	jr .storeCommand ; $6cc5
.checkRight:
	bit 4, a ; $6cc7
	jr z, .checkLeft ; $6cc9
	call MoveLinkCursorRight ; $6ccb
	jp .afterMove ; $6cce
.checkLeft:
	bit 5, a ; $6cd1
	jr z, .checkUp ; $6cd3
	call MoveLinkCursorLeft ; $6cd5
	jr .afterMove ; $6cd8
.checkUp:
	bit 6, a ; $6cda
	jr z, .checkDown ; $6cdc
	call MoveLinkCursorUp ; $6cde
	jr .afterMove ; $6ce1
.checkDown:
	bit 7, a ; $6ce3
	jr z, .afterMove ; $6ce5
	call MoveLinkCursorDown ; $6ce7
	jr .afterMove ; $6cea
.afterMove:
	call GetLinkCursorSelectionCode ; $6cec
	ld b, a ; $6cef
	ld a, [wMenuCursor2X] ; $6cf0
	cp a, d ; $6cf3
	jr nz, .moved ; $6cf4
	ld a, [wMenuCursor2Y] ; $6cf6
	cp a, e ; $6cf9
	jr nz, .moved ; $6cfa
.storeCommand:
	pop af ; $6cfc
	wram_bank ; $6cfd
	xor a, a ; $6d01
	ret ; $6d02
.moved:
	pop af ; $6d03
	wram_bank ; $6d04
	ld a, $01 ; $6d08
	ret ; $6d0a
MoveLinkCursorUp:
	ld a, [wMenuCursor2Y] ; $6d0b
	or a, a ; $6d0e
	jr z, Label_38_6d17 ; $6d0f
	dec a ; $6d11
	ld [wMenuCursor2Y], a ; $6d12
	jr Label_38_6d24 ; $6d15
Label_38_6d17:
	ldh a, [$ffe3] ; $6d17
	or a, a ; $6d19
	ret z ; $6d1a
	dec a ; $6d1b
	cp a, $02 ; $6d1c
	jr nz, Label_38_6d22 ; $6d1e
	ld a, $03 ; $6d20
Label_38_6d22:
	ldh [$ffe3], a ; $6d22
Label_38_6d24:
	ret ; $6d24
MoveLinkCursorDown:
	ld a, [wMenuCursor2Y] ; $6d25
	inc a ; $6d28
	cp a, $02 ; $6d29
	jr z, .wrapPage ; $6d2b
	ld [wMenuCursor2Y], a ; $6d2d
	jr .done ; $6d30
.wrapPage:
	ldh a, [$ffe3] ; $6d32
	cp a, $02 ; $6d34
	jr nc, .nextPage ; $6d36
	cp a, $01 ; $6d38
	ret z ; $6d3a
	ld a, [$d823] ; $6d3b
	cp a, $07 ; $6d3e
	jr c, .done ; $6d40
	ld a, $01 ; $6d42
	ldh [$ffe3], a ; $6d44
	jr .storeRow ; $6d46
.nextPage:
	inc a ; $6d48
	ld e, a ; $6d49
	ld a, [$d812] ; $6d4a
	dec a ; $6d4d
	ld b, a ; $6d4e
	ld a, e ; $6d4f
	cp a, b ; $6d50
	jr nz, .storeRow ; $6d51
	ld a, b ; $6d53
	dec a ; $6d54
.storeRow:
	ldh [$ffe3], a ; $6d55
.done:
	ret ; $6d57
MoveLinkCursorRight:
	ld a, [wMenuCursor2X] ; $6d58
	inc a ; $6d5b
	cp a, $03 ; $6d5c
	jr nz, Label_38_6d73 ; $6d5e
	ldh a, [$ffe3] ; $6d60
	or a, a ; $6d62
	jr z, Label_38_6d6e ; $6d63
	cp a, $01 ; $6d65
	jr z, Label_38_6d6e ; $6d67
	xor a, a ; $6d69
	ldh [$ffe3], a ; $6d6a
	jr Label_38_6d72 ; $6d6c
Label_38_6d6e:
	ld a, $03 ; $6d6e
	ldh [$ffe3], a ; $6d70
Label_38_6d72:
	xor a, a ; $6d72
Label_38_6d73:
	ld [wMenuCursor2X], a ; $6d73
	ret ; $6d76
MoveLinkCursorLeft:
	ld a, [wMenuCursor2X] ; $6d77
	dec a ; $6d7a
	cp a, $ff ; $6d7b
	jr nz, .store ; $6d7d
	ldh a, [$ffe3] ; $6d7f
	or a, a ; $6d81
	jr z, .wrapToLast ; $6d82
	cp a, $01 ; $6d84
	jr z, .wrapToLast ; $6d86
	xor a, a ; $6d88
	ldh [$ffe3], a ; $6d89
	jr .lastColumn ; $6d8b
.wrapToLast:
	ld a, $03 ; $6d8d
	ldh [$ffe3], a ; $6d8f
.lastColumn:
	ld a, $02 ; $6d91
.store:
	ld [wMenuCursor2X], a ; $6d93
	ret ; $6d96
RetreatLinkGridSelection:
	call RetreatToPreviousPlayerSlot ; $6d97
	cp a, $ff ; $6d9a
	jr nz, .clearSlot ; $6d9c
	ret ; $6d9e
.clearSlot:
	sound $62 ; $6d9f
	ld hl, $d816 ; $6da1
	ld a, [$d814] ; $6da4
	add a, l ; $6da7
	ld l, a ; $6da8
	jr nc, .clearTaken ; $6da9
	inc h ; $6dab
.clearTaken:
	ld a, [hl] ; $6dac
	ld b, $00 ; $6dad
	ld [hl], b ; $6daf
	ld hl, $da00 ; $6db0
	add a, a ; $6db3
	add a, a ; $6db4
	add a, l ; $6db5
	ld l, a ; $6db6
	jr nc, .clearRecord ; $6db7
	inc h ; $6db9
.clearRecord:
	inc hl ; $6dba
	inc hl ; $6dbb
	xor a, a ; $6dbc
	ld [hl], a ; $6dbd
	ld a, $02 ; $6dbe
	ld [$d822], a ; $6dc0
	ret ; $6dc3
	ld a, [$d814] ; $6dc4
	ld a, [$d811] ; $6dc7
	ld c, a ; $6dca
	ld a, [wMenuCursor2X] ; $6dcb
	ld d, a ; $6dce
	ld a, [wMenuCursor2Y] ; $6dcf
	ld e, a ; $6dd2
	call TestAndSetGridEntryTaken ; $6dd3
	or a, a ; $6dd6
	jr nz, .done ; $6dd7
	call GetGridSlotFromCursor ; $6dd9
	ld b, a ; $6ddc
	ld hl, $da00 ; $6ddd
	add a, a ; $6de0
	add a, a ; $6de1
	add a, l ; $6de2
	ld l, a ; $6de3
	jr nc, .refresh ; $6de4
	inc h ; $6de6
.refresh:
	ld a, [hl] ; $6de7
	cp a, $ff ; $6de8
	jr z, .done ; $6dea
	ld a, [$d814] ; $6dec
	ld hl, $d816 ; $6def
	add a, l ; $6df2
	ld l, a ; $6df3
	jr nc, .redraw ; $6df4
	inc h ; $6df6
.redraw:
	ld [hl], b ; $6df7
	ld a, $01 ; $6df8
	ld [$d822], a ; $6dfa
	jr .noSelection ; $6dfd
.done:
	xor a, a ; $6dff
	ret ; $6e00
.noSelection:
	ld a, $01 ; $6e01
	ret ; $6e03
WaitLinkSelectStartupFrames:
	ld a, [$cb72] ; $6e04
	cp a, $03 ; $6e07
	jr z, Label_38_6e11 ; $6e09
	inc a ; $6e0b
	ld [$cb72], a ; $6e0c
	xor a, a ; $6e0f
	ret ; $6e10
Label_38_6e11:
	ld a, $01 ; $6e11
	ret ; $6e13
RunNameEntryScreen:
	ld a, b ; $6e14
	ld [wStoryCharacterSlot], a ; $6e15
	wram_bank $02 ; $6e18
	ld a, c ; $6e1e
	ld [$d001], a ; $6e1f
	call DisableLCDSafely ; $6e22
	call ClearFrameTasks ; $6e25
	call SetupNameEntryScreen ; $6e28
	ld a, $01 ; $6e2b
	ld hl, UpdateAnimatedTilesTask_38 ; $6e2d
	call RegisterFrameTask ; $6e30
	ld a, $01 ; $6e33
	ld hl, DrawNameEntryCursor ; $6e35
	call RegisterFrameTask ; $6e38
	ld a, $01 ; $6e3b
	ld hl, DrawNameEntryUnderlineSprites ; $6e3d
	call RegisterFrameTask ; $6e40
	call EnableLCD ; $6e43
	script_fade_in $10 ; $6e46
	call WaitFadeEnd ; $6e4b
	ld hl, rIE ; $6e4e
	res 2, [hl] ; $6e51
	ld a, $01 ; $6e53
	ld hl, TickMenuBgScrollTask_38 ; $6e55
	call RegisterFrameTask ; $6e58
.redraw:
	ld a, [wMenuCursorX] ; $6e5b
	push de ; $6e5e
	push af ; $6e5f
	ld a, a ; $6e60
	ld de, $0303 ; $6e61
	call PrintDecimalByte ; $6e64
	pop af ; $6e67
	pop de ; $6e68
	ldh a, [hInputPressed] ; $6e69
	ld [wMenuInputPressed], a ; $6e6b
	ld b, $0f ; $6e6e
	ld c, $06 ; $6e70
	call MoveMenuCursorBox ; $6e72
	or a, a ; $6e75
	jr z, .inputLoop ; $6e76
	call HandleNameEntryCursorMove ; $6e78
.inputLoop:
	call AdvanceFrame ; $6e7b
	ld a, [wMenuInputPressed] ; $6e7e
	bit PADB_A, a ; $6e81
	jr nz, .pressA ; $6e83
	bit 1, a ; $6e85
	jr nz, .pressB ; $6e87
	bit 2, a ; $6e89
	jr nz, .beep ; $6e8b
	jr .redraw ; $6e8d
.pressA:
	ld a, [wMenuCursorY] ; $6e8f
	cp a, $05 ; $6e92
	jr z, .bottomRow ; $6e94
	call AppendCharToName ; $6e96
	jr .redraw ; $6e99
.bottomRow:
	call GetNameEntryBottomRowAction ; $6e9b
	or a, a ; $6e9e
	jr z, .beep ; $6e9f
	cp a, $01 ; $6ea1
	jr z, .backspace ; $6ea3
	jr .accept ; $6ea5
.beep:
	sound $5e ; $6ea7
.backspace:
	sound $62 ; $6ea9
	call DeleteLastNameChar ; $6eab
	jr .redraw ; $6eae
.pressB:
	sound $62 ; $6eb0
	ldh a, [hWramBank] ; $6eb2
	push af ; $6eb4
	wram_bank $03 ; $6eb5
	ld a, [$d800] ; $6ebb
	ld b, a ; $6ebe
	pop af ; $6ebf
	wram_bank ; $6ec0
	ld a, b ; $6ec4
	cp a, $00 ; $6ec5
	jr z, .cancel ; $6ec7
	call DeleteLastNameChar ; $6ec9
	jr .redraw ; $6ecc
.cancel:
	sound $62 ; $6ece
	ld c, $10 ; $6ed0
	call BeginFadeOut ; $6ed2
	call WaitFadeEnd ; $6ed5
	call ClearFrameTasks ; $6ed8
	ld hl, rIE ; $6edb
	set 2, [hl] ; $6ede
	ld a, $ff ; $6ee0
	ret ; $6ee2
.accept:
	ldh a, [hWramBank] ; $6ee3
	push af ; $6ee5
	wram_bank $03 ; $6ee6
	ld a, [$d800] ; $6eec
	ld b, a ; $6eef
	pop af ; $6ef0
	wram_bank ; $6ef1
	ld a, b ; $6ef5
	cp a, $00 ; $6ef6
	jr z, .storeName ; $6ef8
	wram_bank $03 ; $6efa
	call TrimTrailingSpacesFromName ; $6f00
	call GetActiveStoryNameBuffer ; $6f03
	ld d, b ; $6f06
	ld e, c ; $6f07
	ld hl, $d800 ; $6f08
	ld bc, $000b ; $6f0b
	call CopyMemoryBC ; $6f0e
	sound $5f ; $6f11
	ld c, $10 ; $6f13
	call BeginFadeOut ; $6f15
	call WaitFadeEnd ; $6f18
	call ClearFrameTasks ; $6f1b
	ld hl, rIE ; $6f1e
	set 2, [hl] ; $6f21
	ld a, $00 ; $6f23
	ret ; $6f25
.storeName:
	wram_bank $03 ; $6f26
	call GetActiveStoryNameBuffer ; $6f2c
	ld h, b ; $6f2f
	ld l, c ; $6f30
	ld de, $d800 ; $6f31
	ld bc, $000b ; $6f34
	call CopyMemoryBC ; $6f37
	call GetActiveStoryNameBuffer ; $6f3a
	ld d, b ; $6f3d
	ld e, c ; $6f3e
	ld hl, $d800 ; $6f3f
	ld bc, $000b ; $6f42
	call CopyMemoryBC ; $6f45
	call DrawEnteredName ; $6f48
	ld hl, $d0a0 ; $6f4b
	ld de, $98a0 ; $6f4e
	ld c, $04 ; $6f51
	call QueueVRAMCopy ; $6f53
	call AdvanceFrame ; $6f56
	sound $5f ; $6f59
	ld c, $10 ; $6f5b
	call BeginFadeOut ; $6f5d
	call WaitFadeEnd ; $6f60
	call ClearFrameTasks ; $6f63
	ld hl, rIE ; $6f66
	set 2, [hl] ; $6f69
	ld a, $00 ; $6f6b
	ret ; $6f6d
SetupNameEntryScreen:
	ld b, $12 ; $6f6e
	ld c, $02 ; $6f70
	ld de, $a100 ; $6f72
	farcall LoadCompressedTileBlock ; $6f75
	ld hl, $a000 ; $6f78
	ld de, $0801 ; $6f7b
	farcall LoadMenuHandCursorGfx ; $6f7e
	ld b, $0f ; $6f81
	ld c, $00 ; $6f83
	call SetMenuCursorFromLinearIndex ; $6f85
	ld c, $06 ; $6f88
	farcall LoadScreenAssetRecord ; $6f8a
	farcall ResetTextWindowState ; $6f8d
	ld b, $11 ; $6f90
	ld c, $10 ; $6f92
	ld de, $9000 ; $6f94
	farcall LoadCompressedTileBlock ; $6f97
	wram_bank $05 ; $6f9a
	ld a, $03 ; $6fa0
	ld [wShadowTilemapBank], a ; $6fa2
	ld a, $00 ; $6fa5
	ld [wWindowTileAttr], a ; $6fa7
	ld d, $00 ; $6faa
	ld e, $02 ; $6fac
	ld b, $14 ; $6fae
	ld c, $03 ; $6fb0
	farcall CreateWindowFromScreenRect ; $6fb2
	farcall DrawTextWindowFrame ; $6fb5
	farcall RedrawWindowRows ; $6fb8
	ld d, $00 ; $6fbb
	ld e, $08 ; $6fbd
	ld b, $14 ; $6fbf
	ld c, $09 ; $6fc1
	farcall CreateWindowFromScreenRect ; $6fc3
	farcall DrawTextWindowFrame ; $6fc6
	farcall RedrawWindowRows ; $6fc9
	ld d, $06 ; $6fcc
	ld e, $05 ; $6fce
	ld b, $09 ; $6fd0
	ld c, $03 ; $6fd2
	farcall CreateWindowFromScreenRect ; $6fd4
	farcall DrawTextWindowFrame ; $6fd7
	farcall RedrawWindowRows ; $6fda
	ld hl, NameEntryCharset_38 ; $6fdd
	call DrawNameEntryCharGrid ; $6fe0
	call DrawEnterNameLabel ; $6fe3
	ld b, $0a ; $6fe6
	ld c, $0c ; $6fe8
	farcall LoadIndexedPalette ; $6fea
	ldh a, [hWramBank] ; $6fed
	push af ; $6fef
	wram_bank $02 ; $6ff0
	ld a, [$d001] ; $6ff6
	farcall LoadCharMugshotToBuffer ; $6ff9
	ld de, $b200 ; $6ffc
	farcall CopyMugshotBufferToVram ; $6fff
	wram_bank $02 ; $7002
	call GetActiveStoryNameBuffer ; $7008
	ld hl, $000c ; $700b
	add hl, bc ; $700e
	ld a, [hl] ; $700f
	ld d, $04 ; $7010
	farcall LoadIndexedPalette_18 ; $7012
	pop af ; $7015
	wram_bank ; $7016
	farcall InitMenuBgScroll ; $701a
	ld b, $01 ; $701d
	ld c, $01 ; $701f
	farcall LoadMenuSpritePalettePair ; $7021
	ld a, $10 ; $7024
	ld [$cb15], a ; $7026
	ld [$cb16], a ; $7029
	ld b, $48 ; $702c
	ld c, $14 ; $702e
	ld de, $8100 ; $7030
	farcall LoadCompressedTileBlock ; $7033
	ldh a, [hWramBank] ; $7036
	push af ; $7038
	wram_bank $02 ; $7039
	xor a, a ; $703f
	ld [$d000], a ; $7040
	wram_bank $03 ; $7043
	call GetActiveStoryNameBuffer ; $7049
	ld h, b ; $704c
	ld l, c ; $704d
	ld de, $d800 ; $704e
	ld bc, $000b ; $7051
	call CopyMemoryBC ; $7054
	pop af ; $7057
	wram_bank ; $7058
	call DrawEnteredName ; $705c
	farcall QueueWram3MapToVRAM ; $705f
	ret ; $7062
Data_38_7063:
	; $7063, 15 bytes (bytes:15)
	db $01, $03, $02, $00, $3f, $3f, $3f, $3f, $3f, $3f, $3f, $3f, $3f, $3f, $00 ; 0x00
HandleNameEntryCursorMove:
	sound $5e ; $7072
	ld a, [wMenuCursorY] ; $7074
	cp a, $05 ; $7077
	jr nz, Label_38_708f ; $7079
	ldh a, [hInputPressed] ; $707b
	bit PADB_RIGHT, a ; $707d
	jr nz, Label_38_7087 ; $707f
	bit 5, a ; $7081
	jr nz, Label_38_708c ; $7083
	jr Label_38_708f ; $7085
Label_38_7087:
	call SnapNameEntryCursorRight ; $7087
	jr Label_38_708f ; $708a
Label_38_708c:
	call SnapNameEntryCursorLeft ; $708c
Label_38_708f:
	ret ; $708f
DrawNameEntryCursor:
	ld c, $0f ; $7090
	call GetMenuCursorLinearIndex ; $7092
	add a, a ; $7095
	ld hl, Data_38_70a5 ; $7096
	add a, l ; $7099
	ld l, a ; $709a
	jr nc, Label_38_709e ; $709b
	inc h ; $709d
Label_38_709e:
	ld a, [hl+] ; $709e
	ld d, [hl] ; $709f
	ld e, a ; $70a0
	call QueueNameEntryCursorSprites ; $70a1
	ret ; $70a4
Data_38_70a5:
	INCBIN "data/bank_038/d_70a5.bin" ; $70a5, 180 bytes
DrawEnterNameLabel:
	ldh a, [hWramBank] ; $7159
	push af ; $715b
	wram_bank $03 ; $715c
	ld hl, EnterNameText_38 ; $7162
	ld de, $d061 ; $7165
	call CopyStringToTilemap ; $7168
	pop af ; $716b
	wram_bank ; $716c
	ret ; $7170
EnterNameText_38:
	INCLUDE "data/bank_038/text_7171.asm" ; $7171, 11 bytes
DrawNameEntryCharGrid:
	ldh a, [hWramBank] ; $717c
	push af ; $717e
	wram_bank $03 ; $717f
	ld c, $05 ; $7185
	ld b, $03 ; $7187
	ld de, $d121 ; $7189
Label_38_718c:
	ld a, $20 ; $718c
	ld [de], a ; $718e
	inc de ; $718f
Label_38_7190:
	ld a, [hl+] ; $7190
	push hl ; $7191
	ld h, d ; $7192
	ld l, e ; $7193
	ld [hl+], a ; $7194
	ld d, h ; $7195
	ld e, l ; $7196
	pop hl ; $7197
	dec c ; $7198
	jr nz, Label_38_7190 ; $7199
	ld c, $05 ; $719b
	dec b ; $719d
	jr nz, Label_38_718c ; $719e
	ld a, [hl] ; $71a0
	or a, a ; $71a1
	jr z, Label_38_71b0 ; $71a2
	ld b, $03 ; $71a4
	push hl ; $71a6
	ld hl, $000e ; $71a7
	add hl, de ; $71aa
	ld d, h ; $71ab
	ld e, l ; $71ac
	pop hl ; $71ad
	jr Label_38_718c ; $71ae
Label_38_71b0:
	pop af ; $71b0
	wram_bank ; $71b1
	ret ; $71b5
NameEntryCharset_38:
	INCLUDE "data/bank_038/text_71b6.asm" ; $71b6, 106 bytes
GetNameEntryBottomRowAction:
	ld hl, Data_38_722d ; $7220
	ld a, [wMenuCursorX] ; $7223
	add a, l ; $7226
	ld l, a ; $7227
	jr nc, Label_38_722b ; $7228
	inc h ; $722a
Label_38_722b:
	ld a, [hl] ; $722b
	ret ; $722c
Data_38_722d:
	; $722d, 15 bytes (bytes:15)
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $02, $02, $02, $02, $02 ; 0x00
SnapNameEntryCursorRight:
	ld hl, Data_38_724c ; $723c
	ld a, [wMenuCursorX] ; $723f
	add a, l ; $7242
	ld l, a ; $7243
	jr nc, Label_38_7247 ; $7244
	inc h ; $7246
Label_38_7247:
	ld a, [hl] ; $7247
	ld [wMenuCursorX], a ; $7248
	ret ; $724b
Data_38_724c:
	; $724c, 15 bytes (bytes:15)
	db $07, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $07, $07, $07, $07 ; 0x00
SnapNameEntryCursorLeft:
	ld hl, Data_38_726b ; $725b
	ld a, [wMenuCursorX] ; $725e
	add a, l ; $7261
	ld l, a ; $7262
	jr nc, Label_38_7266 ; $7263
	inc h ; $7265
Label_38_7266:
	ld a, [hl] ; $7266
	ld [wMenuCursorX], a ; $7267
	ret ; $726a
Data_38_726b:
	; $726b, 15 bytes (bytes:15)
	db $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $07, $07, $07, $07, $07, $0a ; 0x00
QueueNameEntryCursorSprites:
	ld c, $00 ; $727a
	ld b, $08 ; $727c
	push de ; $727e
	call QueueSprite ; $727f
	pop de ; $7282
	ld a, $08 ; $7283
	add a, d ; $7285
	ld d, a ; $7286
	ld c, $02 ; $7287
	ld b, $08 ; $7289
	call QueueSprite ; $728b
	ret ; $728e
DrawEnteredName:
	ldh a, [hWramBank] ; $728f
	push af ; $7291
	wram_bank $03 ; $7292
	ld a, $20 ; $7298
	ld hl, $d0c7 ; $729a
	ld [hl+], a ; $729d
	ld [hl+], a ; $729e
	ld [hl+], a ; $729f
	ld [hl+], a ; $72a0
	ld [hl+], a ; $72a1
	ld [hl+], a ; $72a2
	ld [hl+], a ; $72a3
	ld hl, $d800 ; $72a4
	ld de, $d0c7 ; $72a7
	call CopyStringToTilemap ; $72aa
	pop af ; $72ad
	wram_bank ; $72ae
	ret ; $72b2
AppendCharToName:
	ldh a, [hWramBank] ; $72b3
	push af ; $72b5
	wram_bank $03 ; $72b6
	ld hl, $d800 ; $72bc
Label_38_72bf:
	ld a, [hl] ; $72bf
	cp a, $00 ; $72c0
	jr z, Label_38_72c7 ; $72c2
	inc hl ; $72c4
	jr Label_38_72bf ; $72c5
Label_38_72c7:
	push hl ; $72c7
	ld c, $0f ; $72c8
	call GetMenuCursorLinearIndex ; $72ca
	ld d, a ; $72cd
	ld hl, NameEntryCharset_38 ; $72ce
	wram_bank $02 ; $72d1
	ld a, [$d000] ; $72d7
	or a, a ; $72da
	jr z, Label_38_72e0 ; $72db
	ld hl, NameEntryCharset_38 ; $72dd
Label_38_72e0:
	ld a, d ; $72e0
	add a, l ; $72e1
	ld l, a ; $72e2
	jr nc, Label_38_72e6 ; $72e3
	inc h ; $72e5
Label_38_72e6:
	ld d, [hl] ; $72e6
	ld a, d ; $72e7
	cp a, $9e ; $72e8
	jr z, Label_38_72f2 ; $72ea
	cp a, $9f ; $72ec
	jr z, Label_38_72f2 ; $72ee
	jr Label_38_72f5 ; $72f0
Label_38_72f2:
	add a, $40 ; $72f2
	ld d, a ; $72f4
Label_38_72f5:
	pop hl ; $72f5
	wram_bank $03 ; $72f6
	call IsNameBufferFull ; $72fc
	or a, a ; $72ff
	jr z, Label_38_7311 ; $7300
	dec hl ; $7302
	ld a, [hl] ; $7303
	cp a, $de ; $7304
	jr z, Label_38_730e ; $7306
	cp a, $df ; $7308
	jr z, Label_38_730e ; $730a
	jr Label_38_7311 ; $730c
Label_38_730e:
	ld [hl], $00 ; $730e
	dec hl ; $7310
Label_38_7311:
	ld [hl], d ; $7311
	call DrawEnteredName ; $7312
	ld hl, $d0a0 ; $7315
	ld de, $98a0 ; $7318
	ld c, $04 ; $731b
	call QueueVRAMCopy ; $731d
	sound $5f ; $7320
	call GetEnteredNameLength ; $7322
	cp a, $07 ; $7325
	jr nz, Label_38_7333 ; $7327
	ld a, $05 ; $7329
	ld [wMenuCursorY], a ; $732b
	ld a, $0a ; $732e
	ld [wMenuCursorX], a ; $7330
Label_38_7333:
	pop af ; $7333
	wram_bank ; $7334
	ret ; $7338
	ld [hl], $00 ; $7339
	pop af ; $733b
	wram_bank ; $733c
	ret ; $7340
DeleteLastNameChar:
	ldh a, [hWramBank] ; $7341
	push af ; $7343
	call GetEnteredNameLength ; $7344
	and a, a ; $7347
	jr z, .done ; $7348
	wram_bank $03 ; $734a
	ld hl, $d800 ; $7350
.findEnd:
	ld a, [hl+] ; $7353
	cp a, $00 ; $7354
	jr nz, .findEnd ; $7356
	dec hl ; $7358
.deleteChar:
	dec hl ; $7359
	ld a, [hl] ; $735a
	ld [hl], $00 ; $735b
	cp a, $de ; $735d
	jr z, .deleteChar ; $735f
	cp a, $df ; $7361
	jr z, .deleteChar ; $7363
	call DrawEnteredName ; $7365
	ld hl, $d0a0 ; $7368
	ld de, $98a0 ; $736b
	ld c, $04 ; $736e
	call QueueVRAMCopy ; $7370
.done:
	pop af ; $7373
	wram_bank ; $7374
	ret ; $7378
IsNameBufferFull:
	call GetEnteredNameLength ; $7379
	cp a, $07 ; $737c
	jr c, Label_38_7383 ; $737e
	ld a, $ff ; $7380
	ret ; $7382
Label_38_7383:
	xor a, a ; $7383
	ret ; $7384
DrawNameEntryUnderlineSprites:
	ld c, $00 ; $7385
	ld de, $3c38 ; $7387
	call GetEnteredNameLength ; $738a
	ld b, a ; $738d
Label_38_738e:
	push bc ; $738e
	ld a, b ; $738f
	cp a, c ; $7390
	jr nz, Label_38_7399 ; $7391
	ldh a, [hVBlankCounter] ; $7393
	and a, $10 ; $7395
	jr z, Label_38_73a2 ; $7397
Label_38_7399:
	ld c, $10 ; $7399
	ld b, $0a ; $739b
	push de ; $739d
	call QueueSprite ; $739e
	pop de ; $73a1
Label_38_73a2:
	pop bc ; $73a2
	ld a, $08 ; $73a3
	add a, d ; $73a5
	ld d, a ; $73a6
	inc c ; $73a7
	ld a, c ; $73a8
	cp a, $07 ; $73a9
	jr nz, Label_38_738e ; $73ab
	ret ; $73ad
TrimTrailingSpacesFromName:
	ldh a, [hWramBank] ; $73ae
	push af ; $73b0
	wram_bank $03 ; $73b1
	ld hl, $d80a ; $73b7
.scanLoop:
	ld a, [hl] ; $73ba
	cp a, $20 ; $73bb
	jr nz, .checkEnd ; $73bd
	xor a, a ; $73bf
	ld [hl-], a ; $73c0
	jr .scanLoop ; $73c1
.checkEnd:
	or a, a ; $73c3
	jr nz, .done ; $73c4
	dec hl ; $73c6
	jr .scanLoop ; $73c7
.done:
	pop af ; $73c9
	wram_bank ; $73ca
	ret ; $73ce
GetEnteredNameLength:
	push bc ; $73cf
	push hl ; $73d0
	ldh a, [hWramBank] ; $73d1
	push af ; $73d3
	wram_bank $03 ; $73d4
	ld hl, $d800 ; $73da
	ld c, $00 ; $73dd
.charLoop:
	ld a, [hl+] ; $73df
	cp a, $00 ; $73e0
	jr z, .done ; $73e2
	cp a, $de ; $73e4
	jr z, .charLoop ; $73e6
	cp a, $df ; $73e8
	jr z, .charLoop ; $73ea
	inc c ; $73ec
	jr .charLoop ; $73ed
.done:
	ld a, c ; $73ef
	ld b, a ; $73f0
	pop af ; $73f1
	wram_bank ; $73f2
	ld a, b ; $73f6
	pop hl ; $73f7
	pop bc ; $73f8
	ret ; $73f9
GetActiveStoryNameBuffer:
	ld a, [wStoryCharacterSlot] ; $73fa
	or a, a ; $73fd
	jr nz, .partner ; $73fe
	ld bc, wStoryModeNameOfMainCharacter ; $7400
	ret ; $7403
.partner:
	ld bc, wStoryModeNameOfPartnerCharacter ; $7404
	ret ; $7407
RunLinkMatchSequence:
	push bc ; $7408
	push de ; $7409
	push hl ; $740a
Label_38_740b:
	farcall RunLinkMatchRulesMenu ; $740b
	cp a, $ff ; $740e
	jp z, Label_38_74da ; $7410
	ld c, $10 ; $7413
	call BeginFadeOut ; $7415
	call WaitFadeEnd ; $7418
Label_38_741b:
	ldh a, [hWramBank] ; $741b
	push af ; $741d
	wram_bank $03 ; $741e
	ld hl, $da00 ; $7424
	ld bc, $0080 ; $7427
	call ClearBytes ; $742a
	call BuildCharUnlockFlags ; $742d
	call PackUnlockFlagsForLink ; $7430
	call ExchangeLinkUnlockFlags ; $7433
	call MergeLinkUnlockFlags ; $7436
	call UnpackUnlockFlagsFromLink ; $7439
	pop af ; $743c
	wram_bank ; $743d
	call ApplyMatchTypeSettingsLink ; $7441
	farcall RunLinkCharSelectScreen ; $7444
	push af ; $7447
	ld a, $09 ; $7448
	ld [wGameMode], a ; $744a
	call StoreLinkMatchCharInfo ; $744d
	pop af ; $7450
	cp a, $ff ; $7451
	jr nz, Label_38_745f ; $7453
	farcall RestoreMenuScreenAndFadeIn ; $7455
	ld a, $00 ; $7458
	ld [wMenuSlideDirection], a ; $745a
	jr Label_38_740b ; $745d
Label_38_745f:
	farcall ComputeUnlockedCourtFlags ; $745f
	ld c, $00 ; $7462
	call ExchangeLinkCharSelection ; $7464
	call DisableLCDSafely ; $7467
	farcall LoadMenuFontGfx ; $746a
	farcall ResetScreenAndTextWindows ; $746d
	farcall LoadCourtSelectGraphics ; $7470
	call EnableLCD ; $7473
	script_fade_in $10 ; $7476
	xor a, a ; $747b
	ldh [$ffd8], a ; $747c
	call ResetSerialState ; $747e
	ld a, $01 ; $7481
	ld [wMenuSlideDirection], a ; $7483
	call ApplyMatchTypeSettingsLink ; $7486
	ld a, [wUnlockedCourtMask] ; $7489
	ld d, a ; $748c
	ld a, [wLinkPartnerCourtMask] ; $748d
	or a, d ; $7490
	jr nz, Label_38_749c ; $7491
	farcall RunLinkCourtSelect4Menu ; $7493
	cp a, $ff ; $7496
	jr z, Label_38_741b ; $7498
	jr Label_38_74a4 ; $749a
Label_38_749c:
	farcall RunLinkCourtSelect9Menu ; $749c
	cp a, $ff ; $749f
	jp z, Label_38_741b ; $74a1
Label_38_74a4:
	ld d, a ; $74a4
	ld a, d ; $74a5
	ld [wCurrentlyUsedCourt], a ; $74a6
	ld c, $10 ; $74a9
	call BeginFadeOut ; $74ab
	call WaitFadeEnd ; $74ae
	ld a, $01 ; $74b1
	ld [wMatchPlayerChar], a ; $74b3
	ld [wMatchOpponentChar], a ; $74b6
	ld a, [wMatchIsDoubles] ; $74b9
	or a, a ; $74bc
	jr z, Label_38_74c4 ; $74bd
	ld c, $40 ; $74bf
	call ExchangeLinkCharSelection ; $74c1
Label_38_74c4:
	call ClearFrameTasks ; $74c4
	xor a, a ; $74c7
	ldh [$ffd8], a ; $74c8
	call ResetSerialState ; $74ca
	call EnableTimerInterrupt ; $74cd
	ld a, $01 ; $74d0
	ld [$c33f], a ; $74d2
	farcall RunMatch ; $74d5
	ld a, $01 ; $74d8
Label_38_74da:
	push af ; $74da
	call InitSerialLink ; $74db
	pop af ; $74de
	pop hl ; $74df
	pop de ; $74e0
	pop bc ; $74e1
	ret ; $74e2
ApplyMatchTypeSettingsLink:
	ld hl, Data_38_751d ; $74e3
	ld a, [wMatchFormatSets] ; $74e6
	add a, l ; $74e9
	ld l, a ; $74ea
	jr nc, .readSets ; $74eb
	inc h ; $74ed
.readSets:
	ld a, [hl] ; $74ee
	ld [wMatchTypeNumberOfSets], a ; $74ef
	ld hl, Data_38_7520 ; $74f2
	ld a, [wMatchFormatGames] ; $74f5
	add a, l ; $74f8
	ld l, a ; $74f9
	jr nc, .readGames ; $74fa
	inc h ; $74fc
.readGames:
	ld a, [hl] ; $74fd
	ld [wMatchTypeNumberOfGames], a ; $74fe
	ld a, [wMatchFormatDoubles] ; $7501
	ld [wMatchIsDoubles], a ; $7504
	or a, a ; $7507
	jr z, .singles ; $7508
	ld a, $04 ; $750a
	ld [wOnCourtCharCount], a ; $750c
	set_flag FLAG_DOUBLES ; $750f
	jr .done ; $7512
.singles:
	ld a, $02 ; $7514
	ld [wOnCourtCharCount], a ; $7516
	clear_flag FLAG_DOUBLES ; $7519
.done:
	ret ; $751c
Data_38_751d:
	; $751d, 3 bytes (bytes:3)
	db $01, $03, $05 ; 0x00
Data_38_7520:
	; $7520, 2 bytes (bytes:2)
	db $02, $06 ; 0x00
ExchangeLinkCharSelection:
	push bc ; $7522
	call ClearFrameTasks ; $7523
	xor a, a ; $7526
	ldh [$ffd8], a ; $7527
	call ResetSerialState ; $7529
	sound $50 ; $752c
	sound $00 ; $752e
	farcall ResyncLinkSession ; $7530
	push af ; $7533
	farcall RunLinkInputFrame ; $7534
	pop af ; $7537
	push af ; $7538
	farcall RunLinkInputFrame ; $7539
	pop af ; $753c
	xor a, a ; $753d
	ldh [$ffd8], a ; $753e
	call ResetSerialState ; $7540
	ldh a, [hLinkState] ; $7543
	cp a, $01 ; $7545
	jr nz, .checkTag ; $7547
	call WaitVBlank ; $7549
.checkTag:
	pop bc ; $754c
	push bc ; $754d
	ld a, c ; $754e
	or a, a ; $754f
	jr z, .pickBuffers ; $7550
	cp a, $40 ; $7552
	jr z, .pickBuffers ; $7554
	call LinkErrorReset ; $7556
.pickBuffers:
	ldh a, [hLinkState] ; $7559
	cp a, $02 ; $755b
	jr z, .asSlave ; $755d
	cp a, $01 ; $755f
	jr z, .asMaster ; $7561
	call LinkErrorReset ; $7563
.asMaster:
	ld hl, wPlayer2CurrentMainCharacter ; $7566
	ld de, wPlayer1CurrentMainCharacter ; $7569
	jr .checkCancel ; $756c
.asSlave:
	ld hl, wPlayer1CurrentMainCharacter ; $756e
	ld de, wPlayer2CurrentMainCharacter ; $7571
.checkCancel:
	ld a, c ; $7574
	or a, a ; $7575
	jr nz, .sendSelection ; $7576
	dec hl ; $7578
	dec de ; $7579
	push af ; $757a
	push bc ; $757b
	push de ; $757c
	push hl ; $757d
	push de ; $757e
	push af ; $757f
	ld a, [wPlayer1CurrentMainCharacter] ; $7580
	ld de, $0a01 ; $7583
	call PrintHexByte ; $7586
	pop af ; $7589
	pop de ; $758a
	push de ; $758b
	push af ; $758c
	ld a, [wPlayer2CurrentMainCharacter] ; $758d
	ld de, $0a02 ; $7590
	call PrintHexByte ; $7593
	pop af ; $7596
	pop de ; $7597
	pop hl ; $7598
	pop de ; $7599
	pop bc ; $759a
	pop af ; $759b
	ld a, [wUnlockedCourtMask] ; $759c
	ld [de], a ; $759f
	ld b, $26 ; $75a0
	jr .storeCommand ; $75a2
.sendSelection:
	push af ; $75a4
	push bc ; $75a5
	push de ; $75a6
	push hl ; $75a7
	push de ; $75a8
	push af ; $75a9
	ld a, [wPlayer1CurrentPartnerCharacter] ; $75aa
	ld de, $0a03 ; $75ad
	call PrintHexByte ; $75b0
	pop af ; $75b3
	pop de ; $75b4
	push de ; $75b5
	push af ; $75b6
	ld a, [wPlayer2CurrentPartnerCharacter] ; $75b7
	ld de, $0a04 ; $75ba
	call PrintHexByte ; $75bd
	pop af ; $75c0
	pop de ; $75c1
	pop hl ; $75c2
	pop de ; $75c3
	pop bc ; $75c4
	pop af ; $75c5
	ld b, $25 ; $75c6
.storeCommand:
	ld a, c ; $75c8
	add a, l ; $75c9
	ld l, a ; $75ca
	jr nc, .writeSlot ; $75cb
	inc h ; $75cd
.writeSlot:
	ld a, c ; $75ce
	add a, e ; $75cf
	ld e, a ; $75d0
	jr nc, .send ; $75d1
	inc d ; $75d3
.send:
	push bc ; $75d4
	ld c, b ; $75d5
	farcall ExchangeLinkDataBlock ; $75d6
	pop bc ; $75d9
	ld a, b ; $75da
	cp a, $26 ; $75db
	jr nz, .done ; $75dd
	ldh a, [hLinkState] ; $75df
	cp a, $02 ; $75e1
	jr z, .replyOk ; $75e3
	cp a, $01 ; $75e5
	jr z, .checkReply ; $75e7
	call LinkErrorReset ; $75e9
.checkReply:
	ld a, [$ca8a] ; $75ec
	ld [wLinkPartnerCourtMask], a ; $75ef
	jr .retry ; $75f2
.replyOk:
	ld a, [$ca0a] ; $75f4
	ld [wLinkPartnerCourtMask], a ; $75f7
.retry:
	xor a, a ; $75fa
	ld [$ca0a], a ; $75fb
	ld [$ca8a], a ; $75fe
.done:
	pop bc ; $7601
	ret ; $7602
ExchangeLinkUnlockFlags:
	push af ; $7603
	push bc ; $7604
	push de ; $7605
	push hl ; $7606
	call ClearFrameTasks ; $7607
	xor a, a ; $760a
	ldh [$ffd8], a ; $760b
	call ResetSerialState ; $760d
	sound $50 ; $7610
	sound $00 ; $7612
	farcall ResyncLinkSession ; $7614
	push af ; $7617
	farcall RunLinkInputFrame ; $7618
	pop af ; $761b
	push af ; $761c
	farcall RunLinkInputFrame ; $761d
	pop af ; $7620
	xor a, a ; $7621
	ldh [$ffd8], a ; $7622
	call ResetSerialState ; $7624
	ldh a, [hLinkState] ; $7627
	cp a, $01 ; $7629
	jr nz, Label_38_7630 ; $762b
	call WaitVBlank ; $762d
Label_38_7630:
	ld hl, $cb55 ; $7630
	ld de, $cb59 ; $7633
	ld c, $04 ; $7636
	farcall ExchangeLinkDataBlock ; $7638
	xor a, a ; $763b
	ldh [$ffd8], a ; $763c
	call ResetSerialState ; $763e
	pop hl ; $7641
	pop de ; $7642
	pop bc ; $7643
	pop af ; $7644
	ret ; $7645
StoreLinkMatchCharInfo:
	push af ; $7646
	ldh a, [hWramBank] ; $7647
	push af ; $7649
	wram_bank $03 ; $764a
	ld hl, $d816 ; $7650
	ld de, $c8b5 ; $7653
	ld a, [hl+] ; $7656
	ld [de], a ; $7657
	inc de ; $7658
	ld a, [hl+] ; $7659
	ld [de], a ; $765a
	inc de ; $765b
	ld a, [hl+] ; $765c
	ld [de], a ; $765d
	inc de ; $765e
	ld a, [hl+] ; $765f
	ld [de], a ; $7660
	ldh a, [hLinkState] ; $7661
	ld [$c8b9], a ; $7663
	ld a, [$c8b7] ; $7666
	bit 7, a ; $7669
	jr z, Label_38_767f ; $766b
	and a, $07 ; $766d
	ld h, $00 ; $766f
	ld l, a ; $7671
	add hl, hl ; $7672
	add hl, hl ; $7673
	add hl, hl ; $7674
	add hl, hl ; $7675
	add hl, hl ; $7676
	ld de, $d902 ; $7677
	add hl, de ; $767a
	ld a, [hl] ; $767b
	ld [$c8ba], a ; $767c
Label_38_767f:
	pop af ; $767f
	wram_bank ; $7680
	pop af ; $7684
	ret ; $7685
PackUnlockFlagsForLink:
	ld hl, $cb59 ; $7686
	ld bc, $0004 ; $7689
	call ClearBytes ; $768c
	ld hl, $cb55 ; $768f
	ld bc, $0004 ; $7692
	call ClearBytes ; $7695
	ld c, $00 ; $7698
	ld b, $01 ; $769a
	ld hl, $d840 ; $769c
	ld d, $00 ; $769f
.charLoop:
	ld a, [hl+] ; $76a1
	or a, a ; $76a2
	jr z, .nextChar ; $76a3
	ld a, b ; $76a5
	or a, d ; $76a6
	ld d, a ; $76a7
.nextChar:
	sla b ; $76a8
	inc c ; $76aa
	ld a, c ; $76ab
	cp a, $08 ; $76ac
	jr nz, .charLoop ; $76ae
	ld hl, $cb59 ; $76b0
	ld [hl], d ; $76b3
	ld hl, $d848 ; $76b4
	ld a, [hl] ; $76b7
	or a, a ; $76b8
	jr z, .storeCharFlags ; $76b9
	ld a, $01 ; $76bb
.storeCharFlags:
	ld hl, $cb5a ; $76bd
	ld [hl], a ; $76c0
	ld c, $00 ; $76c1
	ld b, $01 ; $76c3
	ld hl, $d84f ; $76c5
	ld d, $00 ; $76c8
.courtLoop:
	ld a, [hl+] ; $76ca
	or a, a ; $76cb
	jr z, .nextCourt ; $76cc
	ld a, b ; $76ce
	or a, d ; $76cf
	ld d, a ; $76d0
.nextCourt:
	sla b ; $76d1
	inc c ; $76d3
	ld a, c ; $76d4
	cp a, $08 ; $76d5
	jr nz, .courtLoop ; $76d7
	ld hl, $cb5b ; $76d9
	ld [hl], d ; $76dc
	ld c, $00 ; $76dd
	ld b, $01 ; $76df
	ld hl, $d857 ; $76e1
	ld d, $00 ; $76e4
.itemLoop:
	ld a, [hl+] ; $76e6
	or a, a ; $76e7
	jr z, .nextItem ; $76e8
	ld a, b ; $76ea
	or a, d ; $76eb
	ld d, a ; $76ec
.nextItem:
	sla b ; $76ed
	inc c ; $76ef
	ld a, c ; $76f0
	cp a, $08 ; $76f1
	jr nz, .itemLoop ; $76f3
	ld hl, $cb5c ; $76f5
	ld [hl], d ; $76f8
	ret ; $76f9
UnpackUnlockFlagsFromLink:
	ld hl, $d840 ; $76fa
	ld bc, $0028 ; $76fd
	call ClearBytes ; $7700
	ld hl, $cb59 ; $7703
	ld b, $01 ; $7706
	ld c, $00 ; $7708
.charBitLoop:
	ld a, [hl] ; $770a
	and a, b ; $770b
	jr z, .nextCharBit ; $770c
	push hl ; $770e
	ld hl, $d840 ; $770f
	ld a, c ; $7712
	add a, l ; $7713
	ld l, a ; $7714
	jr nc, .markChar ; $7715
	inc h ; $7717
.markChar:
	ld a, $01 ; $7718
	ld [hl], a ; $771a
	pop hl ; $771b
.nextCharBit:
	sla b ; $771c
	inc c ; $771e
	ld a, c ; $771f
	cp a, $08 ; $7720
	jr nz, .charBitLoop ; $7722
	ld a, [$cb5a] ; $7724
	or a, a ; $7727
	jr z, .courtFlags ; $7728
	ld hl, $d848 ; $772a
	ld a, $01 ; $772d
	ld [hl], a ; $772f
.courtFlags:
	ld hl, $cb5b ; $7730
	ld b, $01 ; $7733
	ld c, $00 ; $7735
.courtBitLoop:
	ld a, [hl] ; $7737
	and a, b ; $7738
	jr z, .nextCourtBit ; $7739
	push hl ; $773b
	ld hl, $d84f ; $773c
	ld a, c ; $773f
	add a, l ; $7740
	ld l, a ; $7741
	jr nc, .markCourt ; $7742
	inc h ; $7744
.markCourt:
	ld a, $01 ; $7745
	ld [hl], a ; $7747
	pop hl ; $7748
.nextCourtBit:
	sla b ; $7749
	inc c ; $774b
	ld a, c ; $774c
	cp a, $08 ; $774d
	jr nz, .courtBitLoop ; $774f
	ld hl, $cb5c ; $7751
	ld b, $01 ; $7754
	ld c, $00 ; $7756
.itemFlags:
	ld a, [hl] ; $7758
	and a, b ; $7759
	jr z, .done ; $775a
	push hl ; $775c
	ld hl, $d857 ; $775d
	ld a, c ; $7760
	add a, l ; $7761
	ld l, a ; $7762
	jr nc, .markItem ; $7763
	inc h ; $7765
.markItem:
	ld a, $01 ; $7766
	ld [hl], a ; $7768
	pop hl ; $7769
.done:
	sla b ; $776a
	inc c ; $776c
	ld a, c ; $776d
	cp a, $08 ; $776e
	jr nz, .itemFlags ; $7770
	ret ; $7772
MergeLinkUnlockFlags:
	ld hl, $cb59 ; $7773
	ld de, $cb55 ; $7776
	ld c, $00 ; $7779
Label_38_777b:
	ld a, [hl] ; $777b
	ld b, a ; $777c
	ld a, [de] ; $777d
	inc de ; $777e
	or a, b ; $777f
	ld [hl+], a ; $7780
	inc c ; $7781
	ld a, c ; $7782
	cp a, $04 ; $7783
	jr nz, Label_38_777b ; $7785
	ret ; $7787
	; $7788, 2168 bytes fill to bank end (linker-padded)
