SECTION "ROM Bank $3b", ROMX[$4000], BANK[$3b]

	farptr StubNop_3b_44a9 ; $4000
	farptr RunN64ExhibData ; $4002
	farptr RunN64ExhibDataAlias1, RunN64ExhibData ; $4004
	farptr RunTrophiesScreen ; $4006
	farptr RunN64TnmtData ; $4008
	farptr RunN64RingShotData ; $400a
	farptr RunMainMenu ; $400c
	farptr RunMatchFormatSelect ; $400e
	farptr RunMinigameSelect ; $4010
	farptr RunSavedDataSourceSelect ; $4012
	farptr RunEraseSavedDataSelect ; $4014
	farptr RunN64RecordTypeSelect ; $4016
	farptr RunN64TransferItemSelect ; $4018
	farptr PrintNumberRightAligned ; $401a
	farptr ShowTournamentBracket ; $401c
	farptr N64RecordTypeSlideIn ; $401e
	farptr N64RecordTypeSlideOut ; $4020
	farptr SavedDataPickerSlideIn ; $4022
	farptr SavedDataPickerSlideOut ; $4024
	farptr MoveSavedDataPickerCursor ; $4026
	farptr LoadChartWindowTiles ; $4028
	farptr DrawChartCharIcon ; $402a
	farptr BuildStarCharUnlockMask ; $402c
	farptr GetUnlockedStarCharAtGridSlot ; $402e
	farptr RunStarCharExhibResults ; $4030
	farptr RecordExhibitionVictory ; $4032
	farptr ApplyUnlockEverythingCheat ; $4034
	farptr RenderMatchFormatOptionText ; $4036
QueueBouncingCursorCorners:
	push de ; $4038
	push bc ; $4039
	ld c, $00 ; $403a
	call ApplyCursorBounceX ; $403c
	ld c, $00 ; $403f
	call ApplyCursorBounceY ; $4041
	ld c, $00 ; $4044
	ld b, $08 ; $4046
	call QueueSprite ; $4048
	pop bc ; $404b
	pop de ; $404c
	push de ; $404d
	push bc ; $404e
	ld a, b ; $404f
	add a, d ; $4050
	ld d, a ; $4051
	push de ; $4052
	ld c, $01 ; $4053
	call ApplyCursorBounceX ; $4055
	ld c, $00 ; $4058
	call ApplyCursorBounceY ; $405a
	ld c, $00 ; $405d
	ld b, $28 ; $405f
	call QueueSprite ; $4061
	pop de ; $4064
	pop bc ; $4065
	pop de ; $4066
	push de ; $4067
	push bc ; $4068
	ld a, c ; $4069
	add a, e ; $406a
	ld e, a ; $406b
	ld a, b ; $406c
	add a, d ; $406d
	ld d, a ; $406e
	push de ; $406f
	ld c, $01 ; $4070
	call ApplyCursorBounceX ; $4072
	ld c, $01 ; $4075
	call ApplyCursorBounceY ; $4077
	ld c, $00 ; $407a
	ld b, $68 ; $407c
	call QueueSprite ; $407e
	pop de ; $4081
	pop bc ; $4082
	pop de ; $4083
	ld a, e ; $4084
	add a, c ; $4085
	ld e, a ; $4086
	push de ; $4087
	ld c, $00 ; $4088
	call ApplyCursorBounceX ; $408a
	ld c, $01 ; $408d
	call ApplyCursorBounceY ; $408f
	ld c, $00 ; $4092
	ld b, $48 ; $4094
	call QueueSprite ; $4096
	pop de ; $4099
	ret ; $409a
ApplyCursorBounceX:
	ldh a, [hVBlankCounter] ; $409b
	and a, $0f ; $409d
	ld hl, $40b5 ; $409f
	add a, l ; $40a2
	ld l, a ; $40a3
	jr nc, .readOffset ; $40a4
	inc h ; $40a6
.readOffset:
	ld a, [hl] ; $40a7
	ld b, a ; $40a8
	ld a, c ; $40a9
	or a, a ; $40aa
	jr z, .subtract ; $40ab
	ld a, b ; $40ad
	add a, d ; $40ae
	ld d, a ; $40af
	ret ; $40b0
.subtract:
	ld a, d ; $40b1
	sub a, b ; $40b2
	ld d, a ; $40b3
	ret ; $40b4
	; $40b5, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
ApplyCursorBounceY:
	ldh a, [hVBlankCounter] ; $40c5
	and a, $0f ; $40c7
	ld hl, $40df ; $40c9
	add a, l ; $40cc
	ld l, a ; $40cd
	jr nc, .readOffset ; $40ce
	inc h ; $40d0
.readOffset:
	ld a, [hl] ; $40d1
	ld b, a ; $40d2
	ld a, c ; $40d3
	or a, a ; $40d4
	jr z, .subtract ; $40d5
	ld a, b ; $40d7
	add a, e ; $40d8
	ld e, a ; $40d9
	ret ; $40da
.subtract:
	ld a, e ; $40db
	sub a, b ; $40dc
	ld e, a ; $40dd
	ret ; $40de
	; $40df, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
QueueCursorCornersStatic:
	push de ; $40ef
	push bc ; $40f0
	ld c, $00 ; $40f1
	ld b, $09 ; $40f3
	call QueueSprite ; $40f5
	pop bc ; $40f8
	pop de ; $40f9
	push de ; $40fa
	push bc ; $40fb
	ld a, b ; $40fc
	add a, d ; $40fd
	ld d, a ; $40fe
	push de ; $40ff
	ld c, $00 ; $4100
	ld b, $29 ; $4102
	call QueueSprite ; $4104
	pop de ; $4107
	pop bc ; $4108
	pop de ; $4109
	push de ; $410a
	push bc ; $410b
	ld a, c ; $410c
	add a, e ; $410d
	ld e, a ; $410e
	ld a, b ; $410f
	add a, d ; $4110
	ld d, a ; $4111
	push de ; $4112
	ld c, $00 ; $4113
	ld b, $69 ; $4115
	call QueueSprite ; $4117
	pop de ; $411a
	pop bc ; $411b
	pop de ; $411c
	ld a, e ; $411d
	add a, c ; $411e
	ld e, a ; $411f
	push de ; $4120
	ld c, $00 ; $4121
	ld b, $49 ; $4123
	call QueueSprite ; $4125
	pop de ; $4128
	ret ; $4129
MoveMenuCursor:
	ld a, [wMenuCursorX] ; $412a
	ld d, a ; $412d
	ld a, [wMenuCursorY] ; $412e
	ld e, a ; $4131
	ld a, [wMenuInputPressed] ; $4132
	bit PADB_RIGHT, a ; $4135
	jr z, .checkLeft ; $4137
	ld a, [wMenuCursorX] ; $4139
	inc a ; $413c
	add a, a ; $413d
	jr nc, .wrapRight ; $413e
	ld a, b ; $4140
	dec a ; $4141
	jr .storeRight ; $4142
.wrapRight:
	rra ; $4144
	cp a, b ; $4145
	jr c, .storeRight ; $4146
	xor a, a ; $4148
.storeRight:
	ld [wMenuCursorX], a ; $4149
	jr .compare ; $414c
.checkLeft:
	bit 5, a ; $414e
	jr z, .checkUp ; $4150
	ld a, [wMenuCursorX] ; $4152
	dec a ; $4155
	add a, a ; $4156
	jr nc, .wrapLeft ; $4157
	ld a, b ; $4159
	dec a ; $415a
	jr .storeLeft ; $415b
.wrapLeft:
	rra ; $415d
	cp a, b ; $415e
	jr c, .storeLeft ; $415f
	xor a, a ; $4161
.storeLeft:
	ld [wMenuCursorX], a ; $4162
	jr .compare ; $4165
.checkUp:
	bit 6, a ; $4167
	jr z, .checkDown ; $4169
	ld a, [wMenuCursorY] ; $416b
	dec a ; $416e
	add a, a ; $416f
	jr nc, .wrapUp ; $4170
	ld a, c ; $4172
	dec a ; $4173
	jr .storeUp ; $4174
.wrapUp:
	rra ; $4176
	cp a, c ; $4177
	jr c, .storeUp ; $4178
	xor a, a ; $417a
.storeUp:
	ld [wMenuCursorY], a ; $417b
	jr .compare ; $417e
.checkDown:
	bit 7, a ; $4180
	jr z, .compare ; $4182
	ld a, [wMenuCursorY] ; $4184
	inc a ; $4187
	add a, a ; $4188
	jr nc, .wrapDown ; $4189
	ld a, c ; $418b
	dec a ; $418c
	jr .storeDown ; $418d
.wrapDown:
	rra ; $418f
	cp a, c ; $4190
	jr c, .storeDown ; $4191
	xor a, a ; $4193
.storeDown:
	ld [wMenuCursorY], a ; $4194
.compare:
	ld a, [wMenuCursorX] ; $4197
	cp a, d ; $419a
	jr nz, .moved ; $419b
	ld a, [wMenuCursorY] ; $419d
	cp a, e ; $41a0
	jr nz, .moved ; $41a1
	xor a, a ; $41a3
	ret ; $41a4
.moved:
	ld a, $01 ; $41a5
	ret ; $41a7
MoveMenuCursorRepeat:
	ld a, [wMenuCursorX] ; $41a8
	ld d, a ; $41ab
	ld a, [wMenuCursorY] ; $41ac
	ld e, a ; $41af
	ldh a, [hLinkInput] ; $41b0
	bit 4, a ; $41b2
	jr z, .bit4Clear ; $41b4
	ld a, [wMenuCursorX] ; $41b6
	inc a ; $41b9
	add a, a ; $41ba
	jr nc, .noCarry ; $41bb
	ld a, b ; $41bd
	dec a ; $41be
	jr .store ; $41bf
.noCarry:
	rra ; $41c1
	cp a, b ; $41c2
	jr c, .store ; $41c3
	xor a, a ; $41c5
.store:
	ld [wMenuCursorX], a ; $41c6
	jr .checkMenuCursorX ; $41c9
.bit4Clear:
	bit 5, a ; $41cb
	jr z, .bit5Clear ; $41cd
	ld a, [wMenuCursorX] ; $41cf
	dec a ; $41d2
	add a, a ; $41d3
	jr nc, .noCarry2 ; $41d4
	ld a, b ; $41d6
	dec a ; $41d7
	jr .store2 ; $41d8
.noCarry2:
	rra ; $41da
	cp a, b ; $41db
	jr c, .store2 ; $41dc
	xor a, a ; $41de
.store2:
	ld [wMenuCursorX], a ; $41df
	jr .checkMenuCursorX ; $41e2
.bit5Clear:
	bit 6, a ; $41e4
	jr z, .bit6Clear ; $41e6
	ld a, [wMenuCursorY] ; $41e8
	dec a ; $41eb
	add a, a ; $41ec
	jr nc, .noCarry3 ; $41ed
	ld a, c ; $41ef
	dec a ; $41f0
	jr .store3 ; $41f1
.noCarry3:
	rra ; $41f3
	cp a, c ; $41f4
	jr c, .store3 ; $41f5
	xor a, a ; $41f7
.store3:
	ld [wMenuCursorY], a ; $41f8
	jr .checkMenuCursorX ; $41fb
.bit6Clear:
	bit 7, a ; $41fd
	jr z, .checkMenuCursorX ; $41ff
	ld a, [wMenuCursorY] ; $4201
	inc a ; $4204
	add a, a ; $4205
	jr nc, .noCarry4 ; $4206
	ld a, c ; $4208
	dec a ; $4209
	jr .store4 ; $420a
.noCarry4:
	rra ; $420c
	cp a, c ; $420d
	jr c, .store4 ; $420e
	xor a, a ; $4210
.store4:
	ld [wMenuCursorY], a ; $4211
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $4214
	cp a, d ; $4217
	jr nz, .checkMenuCursorX2 ; $4218
	ld a, [wMenuCursorY] ; $421a
	cp a, e ; $421d
	jr nz, .checkMenuCursorX2 ; $421e
	xor a, a ; $4220
	ret ; $4221
.checkMenuCursorX2:
	ld a, $01 ; $4222
	ret ; $4224
MoveMenuCursorLinkLocal:
	ld a, [wMenuCursorX] ; $4225
	ld d, a ; $4228
	ld a, [wMenuCursorY] ; $4229
	ld e, a ; $422c
	ldh a, [hLinkState] ; $422d
	cp a, $02 ; $422f
	jr z, .eq02 ; $4231
	cp a, $01 ; $4233
	jr z, .eq01 ; $4235
	call LinkErrorReset ; $4237
.eq01:
	ldh a, [hLinkRemoteInputBuf] ; $423a
	jr .checkMenuCursorLockFlags ; $423c
.eq02:
	ldh a, [hLinkRemoteInput] ; $423e
.checkMenuCursorLockFlags:
	ld h, a ; $4240
	ld a, [wMenuCursorLockFlags] ; $4241
	and a, $01 ; $4244
	ld a, h ; $4246
	jr nz, .checkMenuCursorLockFlags2 ; $4247
	bit 4, a ; $4249
	jr z, .bit4Clear ; $424b
	ld a, [wMenuCursorX] ; $424d
	inc a ; $4250
	add a, a ; $4251
	jr nc, .noCarry ; $4252
	ld a, b ; $4254
	dec a ; $4255
	jr .store ; $4256
.noCarry:
	rra ; $4258
	cp a, b ; $4259
	jr c, .store ; $425a
	xor a, a ; $425c
.store:
	ld [wMenuCursorX], a ; $425d
	jr .checkMenuCursorX ; $4260
.bit4Clear:
	bit 5, a ; $4262
	jr z, .bit5Clear ; $4264
	ld a, [wMenuCursorX] ; $4266
	dec a ; $4269
	add a, a ; $426a
	jr nc, .noCarry2 ; $426b
	ld a, b ; $426d
	dec a ; $426e
	jr .store2 ; $426f
.noCarry2:
	rra ; $4271
	cp a, b ; $4272
	jr c, .store2 ; $4273
	xor a, a ; $4275
.store2:
	ld [wMenuCursorX], a ; $4276
	jr .checkMenuCursorX ; $4279
.bit5Clear:
	bit 6, a ; $427b
	jr z, .bit6Clear ; $427d
	ld a, [wMenuCursorY] ; $427f
	dec a ; $4282
	add a, a ; $4283
	jr nc, .noCarry3 ; $4284
	ld a, c ; $4286
	dec a ; $4287
	jr .store3 ; $4288
.noCarry3:
	rra ; $428a
	cp a, c ; $428b
	jr c, .store3 ; $428c
	xor a, a ; $428e
.store3:
	ld [wMenuCursorY], a ; $428f
	jr .checkMenuCursorX ; $4292
.bit6Clear:
	bit 7, a ; $4294
	jr z, .checkMenuCursorLockFlags2 ; $4296
	ld a, [wMenuCursorY] ; $4298
	inc a ; $429b
	add a, a ; $429c
	jr nc, .noCarry4 ; $429d
	ld a, c ; $429f
	dec a ; $42a0
	jr .store4 ; $42a1
.noCarry4:
	rra ; $42a3
	cp a, c ; $42a4
	jr c, .store4 ; $42a5
	xor a, a ; $42a7
.store4:
	ld [wMenuCursorY], a ; $42a8
	jr .checkMenuCursorX ; $42ab
.checkMenuCursorLockFlags2:
	bit 0, a ; $42ad
	jr z, .bit0Clear ; $42af
	sound $5f ; $42b1
	ld a, [wMenuCursorLockFlags] ; $42b3
	ld b, a ; $42b6
	and a, $01 ; $42b7
	jr nz, .checkMenuCursorX ; $42b9
	sound $5f ; $42bb
	ld a, b ; $42bd
	or a, $01 ; $42be
	ld [wMenuCursorLockFlags], a ; $42c0
	jr .checkMenuCursorX ; $42c3
.bit0Clear:
	bit 1, a ; $42c5
	jr z, .checkMenuCursorX ; $42c7
	sound $62 ; $42c9
	ld a, [wMenuCursorLockFlags] ; $42cb
	ld b, a ; $42ce
	and a, $03 ; $42cf
	ld a, b ; $42d1
	jr nz, .storeMenuCursorLockFlags ; $42d2
	and a, $fa ; $42d4
	or a, $04 ; $42d6
	jr .store5 ; $42d8
.storeMenuCursorLockFlags:
	and a, $fe ; $42da
.store5:
	ld [wMenuCursorLockFlags], a ; $42dc
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $42df
	cp a, d ; $42e2
	jr nz, .checkMenuCursor2X ; $42e3
	ld a, [wMenuCursorY] ; $42e5
	cp a, e ; $42e8
	jr nz, .checkMenuCursor2X ; $42e9
	xor a, a ; $42eb
	ret ; $42ec
.checkMenuCursor2X:
	ld a, $01 ; $42ed
	ret ; $42ef
MoveMenuCursorLinkRemote:
	ld a, [wMenuCursor2X] ; $42f0
	ld d, a ; $42f3
	ld a, [wMenuCursor2Y] ; $42f4
	ld e, a ; $42f7
	ldh a, [hLinkState] ; $42f8
	cp a, $02 ; $42fa
	jr z, .eq02 ; $42fc
	cp a, $01 ; $42fe
	jr z, .eq01 ; $4300
	call LinkErrorReset ; $4302
.eq01:
	ldh a, [hLinkRemoteInput] ; $4305
	jr .checkMenuCursorLockFlags ; $4307
.eq02:
	ldh a, [hLinkRemoteInputBuf] ; $4309
.checkMenuCursorLockFlags:
	ld h, a ; $430b
	ld a, [wMenuCursorLockFlags] ; $430c
	and a, $02 ; $430f
	ld a, h ; $4311
	jr nz, .checkMenuCursorLockFlags2 ; $4312
	bit 4, a ; $4314
	jr z, .bit4Clear ; $4316
	ld a, [wMenuCursor2X] ; $4318
	inc a ; $431b
	add a, a ; $431c
	jr nc, .noCarry ; $431d
	ld a, b ; $431f
	dec a ; $4320
	jr .store ; $4321
.noCarry:
	rra ; $4323
	cp a, b ; $4324
	jr c, .store ; $4325
	xor a, a ; $4327
.store:
	ld [wMenuCursor2X], a ; $4328
	jr .checkMenuCursor2X ; $432b
.bit4Clear:
	bit 5, a ; $432d
	jr z, .bit5Clear ; $432f
	ld a, [wMenuCursor2X] ; $4331
	dec a ; $4334
	add a, a ; $4335
	jr nc, .noCarry2 ; $4336
	ld a, b ; $4338
	dec a ; $4339
	jr .store2 ; $433a
.noCarry2:
	rra ; $433c
	cp a, b ; $433d
	jr c, .store2 ; $433e
	xor a, a ; $4340
.store2:
	ld [wMenuCursor2X], a ; $4341
	jr .checkMenuCursor2X ; $4344
.bit5Clear:
	bit 6, a ; $4346
	jr z, .bit6Clear ; $4348
	ld a, [wMenuCursor2Y] ; $434a
	dec a ; $434d
	add a, a ; $434e
	jr nc, .noCarry3 ; $434f
	ld a, c ; $4351
	dec a ; $4352
	jr .store3 ; $4353
.noCarry3:
	rra ; $4355
	cp a, c ; $4356
	jr c, .store3 ; $4357
	xor a, a ; $4359
.store3:
	ld [wMenuCursor2Y], a ; $435a
	jr .checkMenuCursor2X ; $435d
.bit6Clear:
	bit 7, a ; $435f
	jr z, .checkMenuCursorLockFlags2 ; $4361
	ld a, [wMenuCursor2Y] ; $4363
	inc a ; $4366
	add a, a ; $4367
	jr nc, .noCarry4 ; $4368
	ld a, c ; $436a
	dec a ; $436b
	jr .store4 ; $436c
.noCarry4:
	rra ; $436e
	cp a, c ; $436f
	jr c, .store4 ; $4370
	xor a, a ; $4372
.store4:
	ld [wMenuCursor2Y], a ; $4373
	jr .checkMenuCursor2X ; $4376
.checkMenuCursorLockFlags2:
	bit 0, a ; $4378
	jr z, .bit0Clear ; $437a
	ld a, [wMenuCursorLockFlags] ; $437c
	ld b, a ; $437f
	and a, $02 ; $4380
	jr nz, .checkMenuCursor2X ; $4382
	sound $5f ; $4384
	ld a, b ; $4386
	or a, $02 ; $4387
	ld [wMenuCursorLockFlags], a ; $4389
	jr .checkMenuCursor2X ; $438c
.bit0Clear:
	bit 1, a ; $438e
	jr z, .checkMenuCursor2X ; $4390
	sound $62 ; $4392
	ld a, [wMenuCursorLockFlags] ; $4394
	ld b, a ; $4397
	and a, $03 ; $4398
	ld a, b ; $439a
	jr nz, .storeMenuCursorLockFlags ; $439b
	and a, $f5 ; $439d
	or a, $08 ; $439f
	jr .store5 ; $43a1
.storeMenuCursorLockFlags:
	and a, $fd ; $43a3
.store5:
	ld [wMenuCursorLockFlags], a ; $43a5
.checkMenuCursor2X:
	ld a, [wMenuCursor2X] ; $43a8
	cp a, d ; $43ab
	jr nz, .checkMenuCursorY ; $43ac
	ld a, [wMenuCursor2Y] ; $43ae
	cp a, e ; $43b1
	jr nz, .checkMenuCursorY ; $43b2
	xor a, a ; $43b4
	ret ; $43b5
.checkMenuCursorY:
	ld a, $01 ; $43b6
	ret ; $43b8
GetMenuCursorCellIndex:
	ld a, [wMenuCursorY] ; $43b9
	ld b, a ; $43bc
	xor a, a ; $43bd
	inc b ; $43be
.mulLoop:
	dec b ; $43bf
	jr z, .addColumn ; $43c0
	add a, c ; $43c2
	jr .mulLoop ; $43c3
.addColumn:
	ld b, a ; $43c5
	ld a, [wMenuCursorX] ; $43c6
	add a, b ; $43c9
	ret ; $43ca
GetCellIndexFromCursorPtr:
	push bc ; $43cb
	ld a, [hl-] ; $43cc
	ld b, a ; $43cd
	xor a, a ; $43ce
	inc b ; $43cf
.loop:
	dec b ; $43d0
	jr z, .countDone ; $43d1
	add a, c ; $43d3
	jr .loop ; $43d4
.countDone:
	ld b, a ; $43d6
	ld a, [hl] ; $43d7
	add a, b ; $43d8
	pop bc ; $43d9
	ret ; $43da
SetMenuCursorFromCellIndex:
	ld d, $00 ; $43db
	ld a, c ; $43dd
.divLoop:
	cp a, b ; $43de
	jr c, .store ; $43df
	inc d ; $43e1
	sub a, b ; $43e2
	jr .divLoop ; $43e3
.store:
	ld [wMenuCursorX], a ; $43e5
	ld a, d ; $43e8
	ld [wMenuCursorY], a ; $43e9
	ret ; $43ec
StoreCellIndexToCursorPtr:
	ld d, $00 ; $43ed
	ld a, c ; $43ef
.loop:
	cp a, b ; $43f0
	jr c, .store ; $43f1
	inc d ; $43f3
	sub a, b ; $43f4
	jr .loop ; $43f5
.store:
	ld [hl+], a ; $43f7
	ld a, d ; $43f8
	ld [hl], a ; $43f9
	ret ; $43fa
ClearWram3Row64:
	ldh a, [hWramBank] ; $43fb
	push af ; $43fd
	wram_bank $03 ; $43fe
	xor a, a ; $4404
	ld c, $40 ; $4405
.loop:
	ld [hl+], a ; $4407
	dec c ; $4408
	jr nz, .loop ; $4409
	pop af ; $440b
	wram_bank ; $440c
	ret ; $4410
	ldh a, [hWramBank] ; $4411
	push af ; $4413
	wram_bank $03 ; $4414
	ld a, $00 ; $441a
	ld c, $40 ; $441c
.loopB:
	ld [hl+], a ; $441e
	dec c ; $441f
	jr nz, .loopB ; $4420
	pop af ; $4422
	wram_bank ; $4423
	ret ; $4427
UpdateAnimatedTilesTask_3b:
	farcall UpdateAnimatedTiles ; $4428
	ret ; $442b
DrawNameWithDiacritics_3b:
	push af ; $442c
	push bc ; $442d
.charLoop:
	ld a, [hl] ; $442e
	cp a, $00 ; $442f
	jr z, .done ; $4431
	ld [de], a ; $4433
	inc hl ; $4434
	ld a, [hl] ; $4435
	cp a, $de ; $4436
	jr z, .markChar ; $4438
	cp a, $df ; $443a
	jr nz, .nextCell ; $443c
.markChar:
	push hl ; $443e
	push bc ; $443f
	ld h, d ; $4440
	ld l, e ; $4441
	ld bc, $ffe0 ; $4442
	add hl, bc ; $4445
	ld b, a ; $4446
	ld a, [hl] ; $4447
	cp a, $03 ; $4448
	ld a, b ; $444a
	jr nz, .writeMark ; $444b
	sub a, $d0 ; $444d
.writeMark:
	ld [hl], a ; $444f
	pop bc ; $4450
	pop hl ; $4451
	inc hl ; $4452
.nextCell:
	inc de ; $4453
	ld a, e ; $4454
	and a, $1f ; $4455
	jr nz, .charLoop ; $4457
	push hl ; $4459
	ld h, d ; $445a
	ld l, e ; $445b
	add hl, de ; $445c
	ld d, h ; $445d
	ld e, l ; $445e
	pop hl ; $445f
	jr .charLoop ; $4460
.done:
	pop bc ; $4462
	pop af ; $4463
	ret ; $4464
PrintNumberString_3b:
	push af ; $4465
	push bc ; $4466
	push hl ; $4467
	add sp, -10 ; $4468
	push bc ; $446a
	push de ; $446b
	ld c, l ; $446c
	ld b, h ; $446d
	ld hl, sp + 4 ; $446e
	ld e, l ; $4470
	ld d, h ; $4471
	ld l, c ; $4472
	ld h, b ; $4473
	ld c, e ; $4474
	ld b, d ; $4475
	call FormatDecimalNumber ; $4476
	ld l, c ; $4479
	ld h, b ; $447a
	pop de ; $447b
	pop bc ; $447c
	call DrawAsciiDigitString_3b ; $447d
	add sp, 10 ; $4480
	pop hl ; $4482
	pop bc ; $4483
	pop af ; $4484
	ret ; $4485
DrawAsciiDigitString_3b:
	ld a, [hl+] ; $4486
	and a, a ; $4487
	jr z, .done ; $4488
	call DrawAsciiDigitChar_3b ; $448a
	jr DrawAsciiDigitString_3b ; $448d
.done:
	ret ; $448f
DrawAsciiDigitChar_3b:
	push hl ; $4490
	ld hl, $d240 ; $4491
	sub a, $30 ; $4494
	jr c, .carry ; $4496
	add a, $30 ; $4498
	ld b, a ; $449a
	wram_bank $03 ; $449b
	ld a, b ; $44a1
	ld [de], a ; $44a2
	inc de ; $44a3
	pop hl ; $44a4
	ret ; $44a5
.carry:
	inc de ; $44a6
	pop hl ; $44a7
	ret ; $44a8
StubNop_3b_44a9:
	ret ; $44a9
RunN64ExhibData:
	sound $04 ; $44aa
	call DisableLCDSafely ; $44ac
	call BuildN64ExhibDataScreen ; $44af
	xor a, a ; $44b2
	ld [wAnimatedTileSet], a ; $44b3
	ld a, $01 ; $44b6
	ld hl, UpdateAnimatedTilesTask_3b ; $44b8
	call RegisterFrameTask ; $44bb
	ld a, $01 ; $44be
	ld hl, N64ExhibScrollArrowsTask ; $44c0
	call RegisterFrameTask ; $44c3
	call EnableLCD ; $44c6
	script_fade_in $10 ; $44c9
	call WaitFadeEnd ; $44ce
	wram_bank $03 ; $44d1
.loop:
	ldh a, [hInputPressed] ; $44d7
	ld [wMenuInputPressed], a ; $44d9
	call ScrollN64ExhibDataCursor ; $44dc
	call AdvanceFrame ; $44df
	ld a, [wMenuInputPressed] ; $44e2
	bit PADB_A, a ; $44e5
	jr nz, .playSfx ; $44e7
	bit 1, a ; $44e9
	jr nz, .playSfx2 ; $44eb
	jr .loop ; $44ed
.playSfx:
	sound $5f ; $44ef
	ld c, $10 ; $44f1
	call BeginFadeOut ; $44f3
	call WaitFadeEnd ; $44f6
	call ClearFrameTasks ; $44f9
	ret ; $44fc
.playSfx2:
	sound $62 ; $44fd
	ld c, $10 ; $44ff
	call BeginFadeOut ; $4501
	call WaitFadeEnd ; $4504
	call ClearFrameTasks ; $4507
	ld a, $ff ; $450a
	ret ; $450c
ScrollN64ExhibDataCursor:
	ld a, [wMenuInputPressed] ; $450d
	bit PADB_LEFT, a ; $4510
	jr z, .step ; $4512
	ld a, [$dc12] ; $4514
	or a, a ; $4517
	jr z, .done ; $4518
	dec a ; $451a
	ld [$dc12], a ; $451b
	sound $5e ; $451e
	call RedrawN64ExhibDataWindow ; $4520
	jr .done ; $4523
.step:
	bit 4, a ; $4525
	jr z, .bit4Clear ; $4527
	ld a, [$dc12] ; $4529
	cp a, $09 ; $452c
	jr z, .done ; $452e
	inc a ; $4530
	ld [$dc12], a ; $4531
	sound $5e ; $4534
	call RedrawN64ExhibDataWindow ; $4536
	jr .done ; $4539
.bit4Clear:
	bit 6, a ; $453b
	jr z, .bit6Clear ; $453d
	ld a, [$dc13] ; $453f
	or a, a ; $4542
	jr z, .done ; $4543
	dec a ; $4545
	ld [$dc13], a ; $4546
	sound $5e ; $4549
	call RedrawN64ExhibDataWindow ; $454b
	jr .done ; $454e
.bit6Clear:
	bit 7, a ; $4550
	jr z, .done ; $4552
	ld a, [$dc13] ; $4554
	cp a, $0c ; $4557
	jr z, .done ; $4559
	inc a ; $455b
	ld [$dc13], a ; $455c
	sound $5e ; $455f
	call RedrawN64ExhibDataWindow ; $4561
	jr .done ; $4564
.done:
	ret ; $4566
N64ExhibScrollArrowsTask:
	ldh a, [hWramBank] ; $4567
	push af ; $4569
	wram_bank $03 ; $456a
	ld a, [$dc12] ; $4570
	cp a, $09 ; $4573
	jr z, .eq09 ; $4575
	ld de, $932f ; $4577
	ld c, $01 ; $457a
	call ApplyCursorBounceX ; $457c
	ld b, $08 ; $457f
	ld c, $00 ; $4581
	ld h, $00 ; $4583
	farcall QueueStackedSpritePair ; $4585
.eq09:
	ld a, [$dc12] ; $4588
	or a, a ; $458b
	jr z, .zero ; $458c
	ld de, $082f ; $458e
	ld c, $00 ; $4591
	call ApplyCursorBounceX ; $4593
	ld b, $08 ; $4596
	ld c, $00 ; $4598
	ld h, $01 ; $459a
	farcall QueueStackedSpritePair ; $459c
.zero:
	ld a, [$dc13] ; $459f
	or a, a ; $45a2
	jr z, .zero2 ; $45a3
	ld de, $0a20 ; $45a5
	ld c, $01 ; $45a8
	call ApplyCursorBounceY ; $45aa
	ld b, $08 ; $45ad
	ld c, $00 ; $45af
	ld h, $02 ; $45b1
	farcall QueueStackedSpritePair ; $45b3
.zero2:
	ld a, [$dc13] ; $45b6
	cp a, $0c ; $45b9
	jr z, .restore ; $45bb
	ld de, $0a78 ; $45bd
	ld c, $00 ; $45c0
	call ApplyCursorBounceY ; $45c2
	ld b, $08 ; $45c5
	ld c, $00 ; $45c7
	ld h, $03 ; $45c9
	farcall QueueStackedSpritePair ; $45cb
.restore:
	pop af ; $45ce
	wram_bank ; $45cf
	ret ; $45d3
BuildN64ExhibDataScreen:
	wram_bank $03 ; $45d4
	xor a, a ; $45da
	ld [$dc13], a ; $45db
	ld [$dc12], a ; $45de
	ld c, $0c ; $45e1
	farcall LoadScreenAssetRecord ; $45e3
	ld de, $aac0 ; $45e6
	call LoadChartWindowTiles ; $45e9
	ld de, $a000 ; $45ec
	farcall LoadMenuArrowSpriteTiles ; $45ef
	ld b, $08 ; $45f2
	ld c, $0f ; $45f4
	farcall LoadIndexedPalette ; $45f6
	wram_bank $03 ; $45f9
	call ReadN64RecordsSaveBlock ; $45ff
.buildN64ExhibColumnList:
	jr nz, .buildN64ExhibColumnList ; $4602
	call BuildN64ExhibColumnList ; $4604
	call InitChartRowFlags ; $4607
	ld hl, $dc01 ; $460a
	ld bc, $d0e2 ; $460d
	call DrawChartIconColumn ; $4610
	ld hl, $dc01 ; $4613
	ld bc, $d0a4 ; $4616
	ld a, $07 ; $4619
	call DrawChartIconRow ; $461b
	ld hl, $db00 ; $461e
	ld de, $d0e4 ; $4621
	ld a, $07 ; $4624
	call DrawChartCellRows ; $4626
	farcall QueueWram3MapToVRAM ; $4629
	ret ; $462c
RedrawN64ExhibDataWindow:
	wram_bank $03 ; $462d
	ld a, [$dc12] ; $4633
	ld hl, $dc01 ; $4636
	add a, l ; $4639
	ld l, a ; $463a
	jr nc, .drawRow ; $463b
	inc h ; $463d
.drawRow:
	ld bc, $d0a4 ; $463e
	ld a, $07 ; $4641
	call DrawChartIconRow ; $4643
	ld a, [$dc13] ; $4646
	ld hl, $dc01 ; $4649
	add a, l ; $464c
	ld l, a ; $464d
	jr nc, .drawColumn ; $464e
	inc h ; $4650
.drawColumn:
	ld bc, $d0e2 ; $4651
	call DrawChartIconColumn ; $4654
	ld a, [$dc13] ; $4657
	ld hl, $db00 ; $465a
	ld de, $0010 ; $465d
.rowSeekLoop:
	or a, a ; $4660
	jr z, .rowFound ; $4661
	add hl, de ; $4663
	dec a ; $4664
	jr .rowSeekLoop ; $4665
.rowFound:
	ld a, [$dc12] ; $4667
	add a, l ; $466a
	ld l, a ; $466b
	jr nc, .drawCells ; $466c
	inc h ; $466e
.drawCells:
	ld de, $d0e4 ; $466f
	ld a, $07 ; $4672
	call DrawChartCellRows ; $4674
	ld hl, $d0a0 ; $4677
	ld de, $98a0 ; $467a
	ld c, $08 ; $467d
	call QueueVRAMCopy ; $467f
	ld hl, $d4a0 ; $4682
	ld de, $b8a0 ; $4685
	ld c, $08 ; $4688
	call QueueVRAMCopy ; $468a
	call AdvanceFrame ; $468d
	ld hl, $d120 ; $4690
	ld de, $9920 ; $4693
	ld c, $08 ; $4696
	call QueueVRAMCopy ; $4698
	ld hl, $d520 ; $469b
	ld de, $b920 ; $469e
	ld c, $08 ; $46a1
	call QueueVRAMCopy ; $46a3
	call AdvanceFrame ; $46a6
	ld hl, $d1a0 ; $46a9
	ld de, $99a0 ; $46ac
	ld c, $04 ; $46af
	call QueueVRAMCopy ; $46b1
	ld hl, $d5a0 ; $46b4
	ld de, $b9a0 ; $46b7
	ld c, $04 ; $46ba
	call QueueVRAMCopy ; $46bc
	ret ; $46bf
DrawChartIconColumn:
	ld d, h ; $46c0
	ld e, l ; $46c1
	ld h, b ; $46c2
	ld l, c ; $46c3
	ld c, $00 ; $46c4
.iconLoop:
	ld a, [de] ; $46c6
	inc de ; $46c7
	ld b, a ; $46c8
	call DrawChartCharIcon ; $46c9
	push de ; $46cc
	ld de, $0040 ; $46cd
	add hl, de ; $46d0
	pop de ; $46d1
	ld a, c ; $46d2
	inc a ; $46d3
	ld c, a ; $46d4
	cp a, $04 ; $46d5
	jr nz, .iconLoop ; $46d7
	ret ; $46d9
DrawChartIconRow:
	ld d, h ; $46da
	ld e, l ; $46db
	ld h, b ; $46dc
	ld l, c ; $46dd
	ld c, a ; $46de
.iconLoop:
	ld a, [de] ; $46df
	inc de ; $46e0
	ld b, a ; $46e1
	call DrawChartCharIcon ; $46e2
	inc hl ; $46e5
	inc hl ; $46e6
	ld a, c ; $46e7
	dec a ; $46e8
	ld c, a ; $46e9
	jr nz, .iconLoop ; $46ea
	ret ; $46ec
DrawChartCellRows:
	push af ; $46ed
	ld c, $00 ; $46ee
.rowLoop:
	pop af ; $46f0
	push af ; $46f1
	push bc ; $46f2
	push hl ; $46f3
	push de ; $46f4
	ld c, a ; $46f5
.cellLoop:
	ld a, [hl+] ; $46f6
	ld b, a ; $46f7
	call DrawChartCellMark ; $46f8
	inc de ; $46fb
	inc de ; $46fc
	ld a, c ; $46fd
	dec a ; $46fe
	ld c, a ; $46ff
	jr nz, .cellLoop ; $4700
	pop de ; $4702
	ld hl, $0040 ; $4703
	add hl, de ; $4706
	ld d, h ; $4707
	ld e, l ; $4708
	pop hl ; $4709
	ld bc, $0010 ; $470a
	add hl, bc ; $470d
	pop bc ; $470e
	ld a, c ; $470f
	inc a ; $4710
	ld c, a ; $4711
	cp a, $04 ; $4712
	jr nz, .rowLoop ; $4714
	pop af ; $4716
	ret ; $4717
DrawChartCellMark:
	push af ; $4718
	push bc ; $4719
	push de ; $471a
	push hl ; $471b
	ld hl, $4738 ; $471c
	ld a, b ; $471f
	add a, l ; $4720
	ld l, a ; $4721
	jr nc, .read ; $4722
	inc h ; $4724
.read:
	ld a, [hl] ; $4725
	ld h, d ; $4726
	ld l, e ; $4727
	ld [hl+], a ; $4728
	inc a ; $4729
	ld [hl], a ; $472a
	inc a ; $472b
	ld de, $001f ; $472c
	add hl, de ; $472f
	ld [hl+], a ; $4730
	inc a ; $4731
	ld [hl], a ; $4732
	pop hl ; $4733
	pop de ; $4734
	pop bc ; $4735
	pop af ; $4736
	ret ; $4737
	; $4738, 11 bytes (bytes:8)
	db $a4, $9c, $94, $98, $78, $7c, $88, $8c ; 0x00
	db $68, $6c, $a8 ; 0x08
BuildN64ExhibColumnList:
	wram_bank $03 ; $4743
	ld hl, $4772 ; $4749
	ld de, $dc01 ; $474c
	ld bc, $0001 ; $474f
	call CopyMemoryFast ; $4752
	ld hl, $da58 ; $4755
	ld a, [hl] ; $4758
	ld b, a ; $4759
	and a, $01 ; $475a
	jr nz, .maskSet ; $475c
	ld a, $10 ; $475e
	ld [$dc0f], a ; $4760
.maskSet:
	ld a, b ; $4763
	and a, $02 ; $4764
	jr nz, .buildN64ExhibResultsGrid ; $4766
	ld a, $10 ; $4768
	ld [$dc10], a ; $476a
.buildN64ExhibResultsGrid:
	call BuildN64ExhibResultsGrid ; $476d
	ret ; $4770
	ret ; $4771
	; $4772, 17 bytes (bytes:8)
	db $00, $01, $02, $03, $04, $05, $06, $07 ; 0x00
	db $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x08
	db $10 ; 0x10
InitChartRowFlags:
	ld hl, $db00 ; $4783
	ld c, $00 ; $4786
.loop:
	ld a, $01 ; $4788
	ld [hl], a ; $478a
	ld a, $11 ; $478b
	add a, l ; $478d
	ld l, a ; $478e
	jr nc, .gotPtr ; $478f
	inc h ; $4791
.gotPtr:
	ld a, c ; $4792
	inc a ; $4793
	ld c, a ; $4794
	cp a, $10 ; $4795
	jr nz, .loop ; $4797
	ret ; $4799
BuildN64ExhibResultsGrid:
	ld de, $db00 ; $479a
	ld b, $00 ; $479d
.loop:
	push bc ; $479f
	ld hl, $47bc ; $47a0
	ld a, b ; $47a3
	add a, l ; $47a4
	ld l, a ; $47a5
	jr nc, .read ; $47a6
	inc h ; $47a8
.read:
	ld b, [hl] ; $47a9
	call DecodeN64ExhibResultsRow ; $47aa
	pop bc ; $47ad
	ld hl, $0010 ; $47ae
	add hl, de ; $47b1
	ld d, h ; $47b2
	ld e, l ; $47b3
	ld a, b ; $47b4
	inc a ; $47b5
	ld b, a ; $47b6
	cp a, $10 ; $47b7
	jr nz, .loop ; $47b9
	ret ; $47bb
	; $47bc, 16 bytes (bytes:16)
	db $02, $0a, $01, $06, $00, $05, $0f, $09, $08, $0b, $07, $0c, $03, $04, $0e, $0d ; 0x00
DecodeN64ExhibResultsRow:
	push af ; $47cc
	push bc ; $47cd
	push de ; $47ce
	push hl ; $47cf
	push de ; $47d0
	ld hl, $d9d8 ; $47d1
	ld a, b ; $47d4
	add a, a ; $47d5
	add a, a ; $47d6
	add a, a ; $47d7
	add a, l ; $47d8
	ld l, a ; $47d9
	jr nc, .expandRowBytesToBits ; $47da
	inc h ; $47dc
.expandRowBytesToBits:
	ld d, h ; $47dd
	ld e, l ; $47de
	call ExpandRowBytesToBits ; $47df
	pop de ; $47e2
	ld h, d ; $47e3
	ld l, e ; $47e4
	ld b, $00 ; $47e5
.loop:
	push bc ; $47e7
	push hl ; $47e8
	ld hl, $4808 ; $47e9
	ld a, b ; $47ec
	add a, l ; $47ed
	ld l, a ; $47ee
	jr nc, .read ; $47ef
	inc h ; $47f1
.read:
	ld b, [hl] ; $47f2
	call CombineExhibCellBits ; $47f3
	pop hl ; $47f6
	pop bc ; $47f7
	call MapExhibCellValueToGlyph ; $47f8
	ld [hl+], a ; $47fb
	ld a, b ; $47fc
	inc a ; $47fd
	ld b, a ; $47fe
	cp a, $10 ; $47ff
	jr nz, .loop ; $4801
	pop hl ; $4803
	pop de ; $4804
	pop bc ; $4805
	pop af ; $4806
	ret ; $4807
	; $4808, 16 bytes (bytes:16)
	db $0d, $05, $0e, $09, $0f, $0a, $00, $06, $07, $04, $08, $03, $0c, $0b, $01, $02 ; 0x00
MapExhibCellValueToGlyph:
	push hl ; $4818
	ld hl, $4824 ; $4819
	add a, l ; $481c
	ld l, a ; $481d
	jr nc, .read ; $481e
	inc h ; $4820
.read:
	ld a, [hl] ; $4821
	pop hl ; $4822
	ret ; $4823
	; $4824, 16 bytes (bytes:8)
	db $00, $03, $05, $07, $09, $0a, $09, $09 ; 0x00
	db $00, $02, $04, $06, $08, $08, $08, $08 ; 0x08
CombineExhibCellBits:
	push hl ; $4834
	push de ; $4835
	push bc ; $4836
	ld a, b ; $4837
	and a, $0f ; $4838
	ld hl, $dc20 ; $483a
	add a, l ; $483d
	ld l, a ; $483e
	jr nc, .read ; $483f
	inc h ; $4841
.read:
	ld c, [hl] ; $4842
	ld a, $10 ; $4843
	add a, l ; $4845
	ld l, a ; $4846
	jr nc, .readB ; $4847
	inc h ; $4849
.readB:
	ld a, [hl] ; $484a
	sla a ; $484b
	ld d, a ; $484d
	ld a, $10 ; $484e
	add a, l ; $4850
	ld l, a ; $4851
	jr nc, .read2 ; $4852
	inc h ; $4854
.read2:
	ld a, [hl] ; $4855
	sla a ; $4856
	sla a ; $4858
	ld e, a ; $485a
	ld a, $10 ; $485b
	add a, l ; $485d
	ld l, a ; $485e
	jr nc, .read3 ; $485f
	inc h ; $4861
.read3:
	ld a, [hl] ; $4862
	sla a ; $4863
	sla a ; $4865
	sla a ; $4867
	add a, e ; $4869
	add a, d ; $486a
	add a, c ; $486b
	pop bc ; $486c
	pop de ; $486d
	pop hl ; $486e
	ret ; $486f
ExpandRowBytesToBits:
	push af ; $4870
	push bc ; $4871
	push de ; $4872
	push hl ; $4873
	push de ; $4874
	ld hl, $dc20 ; $4875
	ld bc, $0004 ; $4878
	call ClearMemory16 ; $487b
	pop de ; $487e
	ld hl, $dc20 ; $487f
	ld c, $00 ; $4882
.loop:
	ld a, [de] ; $4884
	inc de ; $4885
	ld b, a ; $4886
	call ExpandByteToBitArray ; $4887
	ld a, $08 ; $488a
	add a, l ; $488c
	ld l, a ; $488d
	jr nc, .gotPtr ; $488e
	inc h ; $4890
.gotPtr:
	ld a, c ; $4891
	inc a ; $4892
	ld c, a ; $4893
	cp a, $08 ; $4894
	jr nz, .loop ; $4896
	pop hl ; $4898
	pop de ; $4899
	pop bc ; $489a
	pop af ; $489b
	ret ; $489c
ExpandByteToBitArray:
	push hl ; $489d
	push bc ; $489e
	ld a, $07 ; $489f
	add a, l ; $48a1
	ld l, a ; $48a2
	jr nc, .gotPtr ; $48a3
	inc h ; $48a5
.gotPtr:
	ld c, $00 ; $48a6
.loop:
	ld a, b ; $48a8
	and a, $01 ; $48a9
	ld [hl-], a ; $48ab
	srl b ; $48ac
	ld a, c ; $48ae
	inc a ; $48af
	ld c, a ; $48b0
	cp a, $08 ; $48b1
	jr nz, .loop ; $48b3
	pop bc ; $48b5
	pop hl ; $48b6
	ret ; $48b7
	wram_bank $03 ; $48b8
	ld hl, $d9d8 ; $48be
	ld c, $00 ; $48c1
.loopB:
	ld a, $2c ; $48c3
	ld a, $ff ; $48c5
	ld [hl+], a ; $48c7
	ld a, $61 ; $48c8
	ld a, $ff ; $48ca
	ld [hl+], a ; $48cc
	ld a, $28 ; $48cd
	ld a, $77 ; $48cf
	ld [hl+], a ; $48d1
	ld a, $01 ; $48d2
	ld a, $77 ; $48d4
	ld [hl+], a ; $48d6
	ld a, $04 ; $48d7
	ld a, $33 ; $48d9
	ld [hl+], a ; $48db
	ld a, $01 ; $48dc
	ld a, $33 ; $48de
	ld [hl+], a ; $48e0
	ld a, $08 ; $48e1
	ld a, $11 ; $48e3
	ld [hl+], a ; $48e5
	ld a, $01 ; $48e6
	ld a, $11 ; $48e8
	ld [hl+], a ; $48ea
	inc c ; $48eb
	ld a, c ; $48ec
	cp a, $08 ; $48ed
	jr nz, .loopB ; $48ef
	ret ; $48f1
LoadChartWindowTiles:
	ld b, $16 ; $48f2
	ld c, $44 ; $48f4
	farcall LoadCompressedTileBlock ; $48f6
	ret ; $48f9
DrawChartCharIcon:
	push af ; $48fa
	push bc ; $48fb
	push de ; $48fc
	push hl ; $48fd
	ld c, $ac ; $48fe
	ld a, b ; $4900
	add a, a ; $4901
	add a, a ; $4902
	add a, c ; $4903
	push hl ; $4904
	ld [hl+], a ; $4905
	inc a ; $4906
	ld [hl], a ; $4907
	inc a ; $4908
	ld de, $001f ; $4909
	add hl, de ; $490c
	ld [hl+], a ; $490d
	inc a ; $490e
	ld [hl], a ; $490f
	pop hl ; $4910
	ld de, $0400 ; $4911
	add hl, de ; $4914
	ld a, b ; $4915
	push hl ; $4916
	ld hl, $492e ; $4917
	add a, l ; $491a
	ld l, a ; $491b
	jr nc, .readTile ; $491c
	inc h ; $491e
.readTile:
	ld a, [hl] ; $491f
	pop hl ; $4920
	ld [hl+], a ; $4921
	ld [hl], a ; $4922
	ld de, $001f ; $4923
	add hl, de ; $4926
	ld [hl+], a ; $4927
	ld [hl], a ; $4928
	pop hl ; $4929
	pop de ; $492a
	pop bc ; $492b
	pop af ; $492c
	ret ; $492d
	; $492e, 17 bytes (bytes:8)
	db $0e, $0b, $0d, $0e, $0b, $0c, $0d, $0d ; 0x00
	db $0f, $0c, $0e, $0c, $0d, $0e, $0c, $0e ; 0x08
	db $0e ; 0x10
ReadN64RecordsSaveBlock:
	push bc ; $493f
	ldh a, [hWramBank] ; $4940
	push af ; $4942
	wram_bank $03 ; $4943
	ld hl, $d900 ; $4949
	ld bc, $0020 ; $494c
	call ClearMemory16 ; $494f
	ld hl, $d900 ; $4952
	ld b, $0b ; $4955
	farcall ReadSaveBlock ; $4957
	ld b, a ; $495a
	pop af ; $495b
	wram_bank ; $495c
	ld a, b ; $4960
	pop bc ; $4961
	ret ; $4962
RunTrophiesScreen:
	sound $04 ; $4963
	call DisableLCDSafely ; $4965
	call BuildTrophiesScreen ; $4968
	ld a, $00 ; $496b
	ld [wAnimatedTileSet], a ; $496d
	ld a, $01 ; $4970
	ld hl, UpdateAnimatedTilesTask_3b ; $4972
	call RegisterFrameTask ; $4975
	xor a, a ; $4978
	ld [$d901], a ; $4979
	ld [$d900], a ; $497c
	call EnableLCD ; $497f
	script_fade_in $10 ; $4982
	call WaitFadeEnd ; $4987
	wram_bank $03 ; $498a
.loop:
	ldh a, [hInputPressed] ; $4990
	ld [wMenuInputPressed], a ; $4992
	call AdvanceFrame ; $4995
	ld a, [wMenuInputPressed] ; $4998
	bit PADB_A, a ; $499b
	jr nz, .checkTrophiesCheatCode ; $499d
	bit 1, a ; $499f
	jr nz, .playSfx2 ; $49a1
	bit 5, a ; $49a3
	jr nz, .bit5Set ; $49a5
	bit 4, a ; $49a7
	jr nz, .bit4Set ; $49a9
	jr .loop ; $49ab
.bit5Set:
	ld a, [$d901] ; $49ad
	inc a ; $49b0
	ld [$d901], a ; $49b1
	jr .loop ; $49b4
.bit4Set:
	ld a, [$d900] ; $49b6
	inc a ; $49b9
	ld [$d900], a ; $49ba
	jr .loop ; $49bd
.checkTrophiesCheatCode:
	bit 2, a ; $49bf
	jr z, .playSfx ; $49c1
	call CheckTrophiesCheatCode ; $49c3
.playSfx:
	sound $5f ; $49c6
	ld c, $10 ; $49c8
	call BeginFadeOut ; $49ca
	call WaitFadeEnd ; $49cd
	call ClearFrameTasks ; $49d0
	ret ; $49d3
.playSfx2:
	sound $62 ; $49d4
	ld c, $10 ; $49d6
	call BeginFadeOut ; $49d8
	call WaitFadeEnd ; $49db
	call ClearFrameTasks ; $49de
	ld a, $ff ; $49e1
	ret ; $49e3
	ret ; $49e4
BuildTrophiesScreen:
	wram_bank $03 ; $49e5
	call DecodeTrophyCounts ; $49eb
	ld a, [$d819] ; $49ee
	or a, a ; $49f1
	jr nz, .nonZero ; $49f2
	ld c, $0e ; $49f4
	farcall LoadScreenAssetRecord ; $49f6
	jr .drawTrophiesWonRows ; $49f9
.nonZero:
	ld c, $0d ; $49fb
	farcall LoadScreenAssetRecord ; $49fd
.drawTrophiesWonRows:
	wram_bank $03 ; $4a00
	call DrawTrophiesWonRows ; $4a06
	ld a, [$d819] ; $4a09
	or a, a ; $4a0c
	jr nz, .nonZero2 ; $4a0d
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4a0f
	ld c, a ; $4a12
	ld de, $d102 ; $4a13
	call DrawTrophiesCharSprite ; $4a16
	ld a, [wStoryModePartnerCharacterOverworldSprite] ; $4a19
	ld c, a ; $4a1c
	ld de, $d142 ; $4a1d
	call DrawTrophiesCharSprite ; $4a20
	jr .queueWram3MapToVRAM ; $4a23
.nonZero2:
	ld c, $00 ; $4a25
	ld de, $d0c2 ; $4a27
	call DrawTrophiesCharSprite ; $4a2a
	ld c, $00 ; $4a2d
	ld de, $d1a2 ; $4a2f
	call DrawTrophiesCharSprite ; $4a32
	ld c, $03 ; $4a35
	ld de, $d102 ; $4a37
	call DrawTrophiesCharSprite ; $4a3a
	ld c, $03 ; $4a3d
	ld de, $d1e2 ; $4a3f
	call DrawTrophiesCharSprite ; $4a42
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4a45
	ld c, a ; $4a48
	ld de, $d0c2 ; $4a49
	call DrawTrophiesCharSprite ; $4a4c
	ld a, [wStoryModePartnerCharacterOverworldSprite] ; $4a4f
	ld c, a ; $4a52
	ld de, $d102 ; $4a53
	call DrawTrophiesCharSprite ; $4a56
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4a59
	ld c, a ; $4a5c
	ld de, $d1a2 ; $4a5d
	call DrawTrophiesCharSprite ; $4a60
	ld a, [wStoryModePartnerCharacterOverworldSprite] ; $4a63
	ld c, a ; $4a66
	ld de, $d1e2 ; $4a67
	call DrawTrophiesCharSprite ; $4a6a
.queueWram3MapToVRAM:
	farcall QueueWram3MapToVRAM ; $4a6d
	ret ; $4a70
DrawTrophiesWonRows:
	ld a, [$d819] ; $4a71
	or a, a ; $4a74
	jr nz, .nonZero ; $4a75
	ld hl, $d800 ; $4a77
	ld de, $d105 ; $4a7a
	call DrawTrophyRowPair ; $4a7d
	ld de, $d145 ; $4a80
	call DrawTrophyRowPair ; $4a83
	ret ; $4a86
.nonZero:
	ld hl, $d800 ; $4a87
	ld de, $d0c5 ; $4a8a
	call DrawTrophyRowPair ; $4a8d
	ld de, $d105 ; $4a90
	call DrawTrophyRowPair ; $4a93
	ld de, $d1a5 ; $4a96
	call DrawTrophyRowPair ; $4a99
	ld de, $d1e5 ; $4a9c
	call DrawTrophyRowPair ; $4a9f
	ret ; $4aa2
DrawTrophyRowPair:
	ld c, $00 ; $4aa3
.row1Loop:
	ld a, [hl+] ; $4aa5
	or a, a ; $4aa6
	jr z, .row1Next ; $4aa7
	call DrawWonTrophyIcon ; $4aa9
.row1Next:
	inc de ; $4aac
	inc de ; $4aad
	ld a, c ; $4aae
	inc a ; $4aaf
	ld c, a ; $4ab0
	cp a, $03 ; $4ab1
	jr nz, .row1Loop ; $4ab3
	inc de ; $4ab5
	ld c, $00 ; $4ab6
.row2Loop:
	ld a, [hl+] ; $4ab8
	or a, a ; $4ab9
	jr z, .row2Next ; $4aba
	call DrawWonTrophyIcon ; $4abc
.row2Next:
	inc de ; $4abf
	inc de ; $4ac0
	ld a, c ; $4ac1
	inc a ; $4ac2
	ld c, a ; $4ac3
	cp a, $03 ; $4ac4
	jr nz, .row2Loop ; $4ac6
	ret ; $4ac8
DrawWonTrophyIcon:
	push af ; $4ac9
	push bc ; $4aca
	push de ; $4acb
	push hl ; $4acc
	ld h, d ; $4acd
	ld l, e ; $4ace
	push hl ; $4acf
	ld a, $60 ; $4ad0
	ld [hl+], a ; $4ad2
	inc a ; $4ad3
	ld [hl], a ; $4ad4
	inc a ; $4ad5
	ld de, $001f ; $4ad6
	add hl, de ; $4ad9
	ld [hl+], a ; $4ada
	inc a ; $4adb
	ld [hl], a ; $4adc
	pop hl ; $4add
	ld de, $0400 ; $4ade
	add hl, de ; $4ae1
	ld a, $0a ; $4ae2
	ld [hl+], a ; $4ae4
	ld [hl], a ; $4ae5
	ld de, $001f ; $4ae6
	add hl, de ; $4ae9
	ld [hl+], a ; $4aea
	ld [hl], a ; $4aeb
	pop hl ; $4aec
	pop de ; $4aed
	pop bc ; $4aee
	pop af ; $4aef
	ret ; $4af0
DrawTrophiesCharSprite:
	ld hl, $d240 ; $4af1
	ld a, c ; $4af4
	add a, a ; $4af5
	add a, l ; $4af6
	ld l, a ; $4af7
	jr nc, .copyRect ; $4af8
	inc h ; $4afa
.copyRect:
	ld b, $02 ; $4afb
	ld c, $02 ; $4afd
	push hl ; $4aff
	push de ; $4b00
	farcall CopyTilemapRect ; $4b01
	pop de ; $4b04
	pop hl ; $4b05
	ld bc, $0400 ; $4b06
	add hl, bc ; $4b09
	push hl ; $4b0a
	ld h, d ; $4b0b
	ld l, e ; $4b0c
	add hl, bc ; $4b0d
	ld d, h ; $4b0e
	ld e, l ; $4b0f
	pop hl ; $4b10
	ld b, $02 ; $4b11
	ld c, $02 ; $4b13
	farcall CopyTilemapRect ; $4b15
	ret ; $4b18
CheckTrophiesCheatCode:
	sound $22 ; $4b19
	ld a, [$d900] ; $4b1b
	cp a, $0c ; $4b1e
	jp nz, .saveStorySlot ; $4b20
	ld a, [$d901] ; $4b23
	cp a, $22 ; $4b26
	jp nz, .saveStorySlot ; $4b28
	call ApplyUnlockEverythingCheat ; $4b2b
.saveStorySlot:
	farcall SaveStorySlot ; $4b2e
	xor a, a ; $4b31
	ret ; $4b32
ApplyUnlockEverythingCheat:
	ld de, SAVEFLAG_COURT_STAR ; $4b33
	farcall SetSaveFlag ; $4b36
	ld de, SAVEFLAG_COURT_CASTLE ; $4b39
	farcall SetSaveFlag ; $4b3c
	ld de, SAVEFLAG_COURT_TROPICS ; $4b3f
	farcall SetSaveFlag ; $4b42
	ld de, SAVEFLAG_COURT_JUNGLE ; $4b45
	farcall SetSaveFlag ; $4b48
	ld de, SAVEFLAG_COURT_WAREHOUSE ; $4b4b
	farcall SetSaveFlag ; $4b4e
	ld de, SAVEFLAG_UNLOCKED_FAY ; $4b51
	farcall SetSaveFlag ; $4b54
	ld de, SAVEFLAG_UNLOCKED_CURT ; $4b57
	farcall SetSaveFlag ; $4b5a
	ld de, SAVEFLAG_UNLOCKED_MARK ; $4b5d
	farcall SetSaveFlag ; $4b60
	ld de, SAVEFLAG_UNLOCKED_SEAN ; $4b63
	farcall SetSaveFlag ; $4b66
	ld de, SAVEFLAG_UNLOCKED_SAMMI ; $4b69
	farcall SetSaveFlag ; $4b6c
	ld de, SAVEFLAG_UNLOCKED_ELDEN ; $4b6f
	farcall SetSaveFlag ; $4b72
	ld de, SAVEFLAG_CLEARED_BOO_BLAST_1 ; $4b75
	farcall SetSaveFlag ; $4b78
	ld de, SAVEFLAG_CLEARED_BOO_BLAST_2 ; $4b7b
	farcall SetSaveFlag ; $4b7e
	ld de, SAVEFLAG_CLEARED_SHOOTING_STAR_1 ; $4b81
	farcall SetSaveFlag ; $4b84
	ld de, SAVEFLAG_CLEARED_SHOOTING_STAR_2 ; $4b87
	farcall SetSaveFlag ; $4b8a
	ld de, SAVEFLAG_CLEARED_PERFECT_SHOT_1 ; $4b8d
	farcall SetSaveFlag ; $4b90
	ld de, SAVEFLAG_CLEARED_PERFECT_SHOT_2 ; $4b93
	farcall SetSaveFlag ; $4b96
	ld de, SAVEFLAG_CLEARED_TARGET_SHOT_1 ; $4b99
	farcall SetSaveFlag ; $4b9c
	ld de, SAVEFLAG_CLEARED_TARGET_SHOT_2 ; $4b9f
	farcall SetSaveFlag ; $4ba2
	ld de, SAVEFLAG_CLEARED_FRUIT_FANTASY_1 ; $4ba5
	farcall SetSaveFlag ; $4ba8
	ld de, SAVEFLAG_CLEARED_FRUIT_FANTASY_2 ; $4bab
	farcall SetSaveFlag ; $4bae
	ld de, SAVEFLAG_CLEARED_BANANA_BUNCH_1 ; $4bb1
	farcall SetSaveFlag ; $4bb4
	ld de, SAVEFLAG_CLEARED_BANANA_BUNCH_2 ; $4bb7
	farcall SetSaveFlag ; $4bba
	ld de, SAVEFLAG_CLEARED_TREASURE_BOX_1 ; $4bbd
	farcall SetSaveFlag ; $4bc0
	ld de, SAVEFLAG_CLEARED_TREASURE_BOX_2 ; $4bc3
	farcall SetSaveFlag ; $4bc6
	ld de, SAVEFLAG_CLEARED_MEDALLION_MATCH_1 ; $4bc9
	farcall SetSaveFlag ; $4bcc
	ld de, SAVEFLAG_CLEARED_MEDALLION_MATCH_2 ; $4bcf
	farcall SetSaveFlag ; $4bd2
	ld de, SAVEFLAG_CLEARED_TWO_ON_ONE_1 ; $4bd5
	farcall SetSaveFlag ; $4bd8
	ld de, SAVEFLAG_CLEARED_TWO_ON_ONE_2 ; $4bdb
	farcall SetSaveFlag ; $4bde
	ld a, [wCurrentStorySlot] ; $4be1
	push af ; $4be4
	ld c, $00 ; $4be5
.loop:
	push bc ; $4be7
	ld a, c ; $4be8
	ld [wCurrentStorySlot], a ; $4be9
	farcall CheckStorySlot ; $4bec
	cp a, $fe ; $4bef
	jr z, .restore ; $4bf1
	ld de, $1400 ; $4bf3
	call SetGameFlag ; $4bf6
	ld de, $1420 ; $4bf9
	call SetGameFlag ; $4bfc
	ld de, $1440 ; $4bff
	call SetGameFlag ; $4c02
	ld de, $1460 ; $4c05
	call SetGameFlag ; $4c08
	ld de, $1480 ; $4c0b
	call SetGameFlag ; $4c0e
	ld de, $14a0 ; $4c11
	call SetGameFlag ; $4c14
	ld de, $14c0 ; $4c17
	call SetGameFlag ; $4c1a
	ld de, $14e0 ; $4c1d
	call SetGameFlag ; $4c20
	ld de, $1500 ; $4c23
	call SetGameFlag ; $4c26
	ld de, $1560 ; $4c29
	call SetGameFlag ; $4c2c
	ld de, $1580 ; $4c2f
	call SetGameFlag ; $4c32
	ld de, $1520 ; $4c35
	call SetGameFlag ; $4c38
	ld de, $1540 ; $4c3b
	call SetGameFlag ; $4c3e
	farcall SaveStorySlot ; $4c41
.restore:
	pop bc ; $4c44
	inc c ; $4c45
	ld a, c ; $4c46
	cp a, $03 ; $4c47
	jr nz, .loop ; $4c49
	pop af ; $4c4b
	ld [wCurrentStorySlot], a ; $4c4c
	farcall SetAllUnlockablesInSaveBlock ; $4c4f
	ret ; $4c52
DecodeTrophyCounts:
	wram_bank $03 ; $4c53
	ld hl, $d800 ; $4c59
	ld bc, $0018 ; $4c5c
	call ClearBytes ; $4c5f
	ld de, $d800 ; $4c62
	ld a, [$c9b5] ; $4c65
	and a, $03 ; $4c68
	ld b, a ; $4c6a
	call FillTrophyCountCells ; $4c6b
	ld de, $d803 ; $4c6e
	ld a, [$c9b5] ; $4c71
	swap a ; $4c74
	and a, $03 ; $4c76
	ld b, a ; $4c78
	call FillTrophyCountCells ; $4c79
	ld de, $d80c ; $4c7c
	ld a, [$c9b5] ; $4c7f
	srl a ; $4c82
	srl a ; $4c84
	and a, $03 ; $4c86
	ld b, a ; $4c88
	call FillTrophyCountCells ; $4c89
	ld de, $d80f ; $4c8c
	ld a, [$c9b5] ; $4c8f
	swap a ; $4c92
	srl a ; $4c94
	srl a ; $4c96
	and a, $03 ; $4c98
	ld b, a ; $4c9a
	call FillTrophyCountCells ; $4c9b
	ld de, $d806 ; $4c9e
	ld a, [$c9b6] ; $4ca1
	and a, $03 ; $4ca4
	ld b, a ; $4ca6
	call FillTrophyCountCells ; $4ca7
	ld de, $d809 ; $4caa
	ld a, [$c9b6] ; $4cad
	swap a ; $4cb0
	and a, $03 ; $4cb2
	ld b, a ; $4cb4
	call FillTrophyCountCells ; $4cb5
	ld de, $d812 ; $4cb8
	ld a, [$c9b6] ; $4cbb
	srl a ; $4cbe
	srl a ; $4cc0
	and a, $03 ; $4cc2
	ld b, a ; $4cc4
	call FillTrophyCountCells ; $4cc5
	ld de, $d815 ; $4cc8
	ld a, [$c9b6] ; $4ccb
	swap a ; $4cce
	srl a ; $4cd0
	srl a ; $4cd2
	and a, $03 ; $4cd4
	ld b, a ; $4cd6
	call FillTrophyCountCells ; $4cd7
	ld a, [$d80c] ; $4cda
	or a, a ; $4cdd
	jr nz, .step ; $4cde
	ld a, [$d80f] ; $4ce0
	or a, a ; $4ce3
	jr nz, .step ; $4ce4
	ld a, [$d812] ; $4ce6
	or a, a ; $4ce9
	jr nz, .step ; $4cea
	ld a, [$d815] ; $4cec
	or a, a ; $4cef
	jr nz, .step ; $4cf0
	jr .done ; $4cf2
.step:
	ld a, $01 ; $4cf4
	ld [$d819], a ; $4cf6
.done:
	ret ; $4cf9
RunN64TnmtData:
	sound $04 ; $4cfa
	call DisableLCDSafely ; $4cfc
	call BuildN64TnmtDataScreen ; $4cff
	xor a, a ; $4d02
	ld [wAnimatedTileSet], a ; $4d03
	ld a, $01 ; $4d06
	ld hl, UpdateAnimatedTilesTask_3b ; $4d08
	call RegisterFrameTask ; $4d0b
	ld a, $01 ; $4d0e
	ld hl, N64TnmtScrollArrowsTask ; $4d10
	call RegisterFrameTask ; $4d13
	call EnableLCD ; $4d16
	script_fade_in $10 ; $4d19
	call WaitFadeEnd ; $4d1e
	wram_bank $03 ; $4d21
.loop:
	ldh a, [hInputPressed] ; $4d27
	ld [wMenuInputPressed], a ; $4d29
	call ScrollN64TnmtDataCursor ; $4d2c
	call AdvanceFrame ; $4d2f
	ld a, [wMenuInputPressed] ; $4d32
	bit PADB_A, a ; $4d35
	jr nz, .playSfx ; $4d37
	bit 1, a ; $4d39
	jr nz, .playSfx2 ; $4d3b
	jr .loop ; $4d3d
.playSfx:
	sound $5f ; $4d3f
	ld c, $10 ; $4d41
	call BeginFadeOut ; $4d43
	call WaitFadeEnd ; $4d46
	call ClearFrameTasks ; $4d49
	ret ; $4d4c
.playSfx2:
	sound $62 ; $4d4d
	ld c, $10 ; $4d4f
	call BeginFadeOut ; $4d51
	call WaitFadeEnd ; $4d54
	call ClearFrameTasks ; $4d57
	ld a, $ff ; $4d5a
	ret ; $4d5c
ScrollN64TnmtDataCursor:
	ld a, [wMenuInputPressed] ; $4d5d
	bit PADB_LEFT, a ; $4d60
	jr z, .step ; $4d62
	ld a, [$d801] ; $4d64
	or a, a ; $4d67
	jr z, .done ; $4d68
	xor a, a ; $4d6a
	ld [$d801], a ; $4d6b
	sound $5e ; $4d6e
	call RedrawN64TnmtDataWindow ; $4d70
	jr .done ; $4d73
.step:
	bit 4, a ; $4d75
	jr z, .bit4Clear ; $4d77
	ld a, [$d800] ; $4d79
	or a, a ; $4d7c
	jr z, .done ; $4d7d
	ld a, [$d801] ; $4d7f
	or a, a ; $4d82
	jr nz, .done ; $4d83
	ld a, $01 ; $4d85
	ld [$d801], a ; $4d87
	sound $5e ; $4d8a
	call RedrawN64TnmtDataWindow ; $4d8c
	jr .done ; $4d8f
.bit4Clear:
	bit 6, a ; $4d91
	jr z, .bit6Clear ; $4d93
	ld a, [$d802] ; $4d95
	or a, a ; $4d98
	jr z, .done ; $4d99
	dec a ; $4d9b
	ld [$d802], a ; $4d9c
	sound $5e ; $4d9f
	call RedrawN64TnmtDataWindow ; $4da1
	jr .done ; $4da4
.bit6Clear:
	bit 7, a ; $4da6
	jr z, .done ; $4da8
	ld a, [$d802] ; $4daa
	cp a, $0b ; $4dad
	jr z, .done ; $4daf
	inc a ; $4db1
	ld [$d802], a ; $4db2
	sound $5e ; $4db5
	call RedrawN64TnmtDataWindow ; $4db7
	jr .done ; $4dba
.done:
	ret ; $4dbc
BuildN64TnmtDataScreen:
	ld c, $0f ; $4dbd
	farcall LoadScreenAssetRecord ; $4dbf
	wram_bank $03 ; $4dc2
	xor a, a ; $4dc8
	ld [$d800], a ; $4dc9
	ld a, $00 ; $4dcc
	ld [$d801], a ; $4dce
	ld a, $00 ; $4dd1
	ld [$d802], a ; $4dd3
	call LoadN64TnmtDataRecords ; $4dd6
	wram_bank $03 ; $4dd9
	ld de, $aac0 ; $4ddf
	call LoadChartWindowTiles ; $4de2
	ld de, $a000 ; $4de5
	farcall LoadMenuArrowSpriteTiles ; $4de8
	ld b, $08 ; $4deb
	ld c, $0f ; $4ded
	farcall LoadIndexedPalette ; $4def
	call DrawN64TnmtRowIcons ; $4df2
	call DrawN64TnmtPageLabels ; $4df5
	call DrawN64TnmtTrophyRows ; $4df8
	farcall QueueWram3MapToVRAM ; $4dfb
	ret ; $4dfe
LoadN64TnmtDataRecords:
	wram_bank $03 ; $4dff
	ld hl, $d800 ; $4e05
	ld bc, $0080 ; $4e08
	call ClearMemory16 ; $4e0b
	ld hl, $4e44 ; $4e0e
	ld de, $d810 ; $4e11
	ld bc, $0010 ; $4e14
	call CopyMemoryBC ; $4e17
	call ReadN64RecordsSaveBlock ; $4e1a
	ld hl, $da58 ; $4e1d
	ld a, [hl] ; $4e20
	ld b, a ; $4e21
	and a, $01 ; $4e22
	jr nz, .maskSet ; $4e24
	ld a, $10 ; $4e26
	ld [$d81e], a ; $4e28
.maskSet:
	ld a, b ; $4e2b
	and a, $02 ; $4e2c
	jr nz, .buildN64TnmtTrophyGrid ; $4e2e
	ld a, $10 ; $4e30
	ld [$d81f], a ; $4e32
.buildN64TnmtTrophyGrid:
	call BuildN64TnmtTrophyGrid ; $4e35
	call CheckN64TnmtSecondPage ; $4e38
	or a, a ; $4e3b
	jr z, .done ; $4e3c
	ld a, $01 ; $4e3e
	ld [$d800], a ; $4e40
.done:
	ret ; $4e43
	; $4e44, 16 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x00
BuildN64TnmtTrophyGrid:
	ld de, $d830 ; $4e54
	ld hl, $d908 ; $4e57
	ld c, $00 ; $4e5a
.loop:
	ld b, c ; $4e5c
	call GetN64CharTrophyRowPtr ; $4e5d
	call DecodeN64CharTrophyCounts ; $4e60
	push hl ; $4e63
	ld hl, $000c ; $4e64
	add hl, de ; $4e67
	ld d, h ; $4e68
	ld e, l ; $4e69
	pop hl ; $4e6a
	inc hl ; $4e6b
	ld a, c ; $4e6c
	inc a ; $4e6d
	ld c, a ; $4e6e
	cp a, $10 ; $4e6f
	jr nz, .loop ; $4e71
	ret ; $4e73
GetN64CharTrophyRowPtr:
	ld a, b ; $4e74
	ld hl, $4e87 ; $4e75
	add a, l ; $4e78
	ld l, a ; $4e79
	jr nc, .read ; $4e7a
	inc h ; $4e7c
.read:
	ld a, [hl] ; $4e7d
	ld hl, $d908 ; $4e7e
	add a, l ; $4e81
	ld l, a ; $4e82
	jr nc, .done ; $4e83
	inc h ; $4e85
.done:
	ret ; $4e86
	; $4e87, 16 bytes (bytes:16)
	db $02, $0a, $01, $06, $00, $05, $0f, $09, $08, $0b, $07, $0c, $03, $04, $0e, $0d ; 0x00
DecodeN64CharTrophyCounts:
	push af ; $4e97
	push bc ; $4e98
	push de ; $4e99
	push hl ; $4e9a
	ld a, [hl] ; $4e9b
	and a, $03 ; $4e9c
	ld b, a ; $4e9e
	call FillTrophyCountCells ; $4e9f
	inc de ; $4ea2
	inc de ; $4ea3
	inc de ; $4ea4
	ld a, [hl] ; $4ea5
	and a, $30 ; $4ea6
	swap a ; $4ea8
	ld b, a ; $4eaa
	call FillTrophyCountCells ; $4eab
	inc de ; $4eae
	inc de ; $4eaf
	inc de ; $4eb0
	ld a, [hl] ; $4eb1
	and a, $0c ; $4eb2
	srl a ; $4eb4
	srl a ; $4eb6
	ld b, a ; $4eb8
	call FillTrophyCountCells ; $4eb9
	inc de ; $4ebc
	inc de ; $4ebd
	inc de ; $4ebe
	ld a, [hl] ; $4ebf
	and a, $c0 ; $4ec0
	swap a ; $4ec2
	srl a ; $4ec4
	srl a ; $4ec6
	ld b, a ; $4ec8
	call FillTrophyCountCells ; $4ec9
	pop hl ; $4ecc
	pop de ; $4ecd
	pop bc ; $4ece
	pop af ; $4ecf
	ret ; $4ed0
FillTrophyCountCells:
	push de ; $4ed1
	push bc ; $4ed2
.cellLoop:
	ld a, b ; $4ed3
	or a, a ; $4ed4
	jr z, .done ; $4ed5
	ld a, $01 ; $4ed7
	ld [de], a ; $4ed9
	inc de ; $4eda
	ld a, b ; $4edb
	dec a ; $4edc
	ld b, a ; $4edd
	jr .cellLoop ; $4ede
.done:
	pop bc ; $4ee0
	pop de ; $4ee1
	ret ; $4ee2
CheckN64TnmtSecondPage:
	ld hl, $d832 ; $4ee3
	ld c, $00 ; $4ee6
	ld de, $000c ; $4ee8
.loop:
	ld a, [hl] ; $4eeb
	or a, a ; $4eec
	jr z, .zero ; $4eed
	add hl, de ; $4eef
	ld a, c ; $4ef0
	inc a ; $4ef1
	ld c, a ; $4ef2
	cp a, $0e ; $4ef3
	jr nz, .loop ; $4ef5
	ld hl, $d835 ; $4ef7
	ld c, $00 ; $4efa
	ld de, $000c ; $4efc
.loopB:
	ld a, [hl] ; $4eff
	or a, a ; $4f00
	jr nz, .returnOne ; $4f01
	add hl, de ; $4f03
	ld a, c ; $4f04
	inc a ; $4f05
	ld c, a ; $4f06
	cp a, $10 ; $4f07
	jr nz, .loopB ; $4f09
.zero:
	ld hl, $d835 ; $4f0b
	ld c, $00 ; $4f0e
	ld de, $000c ; $4f10
.loop2:
	ld a, [hl] ; $4f13
	or a, a ; $4f14
	jr z, .zero2 ; $4f15
	add hl, de ; $4f17
	ld a, c ; $4f18
	inc a ; $4f19
	ld c, a ; $4f1a
	cp a, $0e ; $4f1b
	jr nz, .loop2 ; $4f1d
	ld hl, $d832 ; $4f1f
	ld c, $00 ; $4f22
	ld de, $000c ; $4f24
.loop3:
	ld a, [hl] ; $4f27
	or a, a ; $4f28
	jr nz, .returnOne ; $4f29
	add hl, de ; $4f2b
	ld a, c ; $4f2c
	inc a ; $4f2d
	ld c, a ; $4f2e
	cp a, $10 ; $4f2f
	jr nz, .loop3 ; $4f31
.returnOne:
	ld a, $01 ; $4f33
	ret ; $4f35
.zero2:
	xor a, a ; $4f36
	ret ; $4f37
RedrawN64TnmtDataWindow:
	call DrawN64TnmtRowIcons ; $4f38
	call DrawN64TnmtPageLabels ; $4f3b
	call DrawN64TnmtTrophyRows ; $4f3e
	call FlushN64TnmtWindowToVram ; $4f41
	ret ; $4f44
DrawN64TnmtRowIcons:
	push af ; $4f45
	push bc ; $4f46
	push de ; $4f47
	push hl ; $4f48
	ldh a, [hWramBank] ; $4f49
	push af ; $4f4b
	wram_bank $03 ; $4f4c
	ld hl, $d810 ; $4f52
	ld a, [$d802] ; $4f55
	add a, l ; $4f58
	ld l, a ; $4f59
	jr nc, .gotPtr ; $4f5a
	inc h ; $4f5c
.gotPtr:
	ld d, h ; $4f5d
	ld e, l ; $4f5e
	ld c, $00 ; $4f5f
	ld hl, $d0e2 ; $4f61
.loop:
	ld a, [de] ; $4f64
	inc de ; $4f65
	ld b, a ; $4f66
	call DrawChartCharIcon ; $4f67
	push de ; $4f6a
	ld de, $0040 ; $4f6b
	add hl, de ; $4f6e
	pop de ; $4f6f
	ld a, c ; $4f70
	inc a ; $4f71
	ld c, a ; $4f72
	cp a, $05 ; $4f73
	jr nz, .loop ; $4f75
	pop af ; $4f77
	wram_bank ; $4f78
	pop hl ; $4f7c
	pop de ; $4f7d
	pop bc ; $4f7e
	pop af ; $4f7f
	ret ; $4f80
DrawN64TnmtPageLabels:
	ldh a, [hWramBank] ; $4f81
	push af ; $4f83
	wram_bank $03 ; $4f84
	ld a, [$d801] ; $4f8a
	or a, a ; $4f8d
	jr nz, .nonZero ; $4f8e
	ld hl, $d240 ; $4f90
	ld de, $d0a5 ; $4f93
	ld b, $06 ; $4f96
	ld c, $02 ; $4f98
	farcall CopyTilemapRect ; $4f9a
	ld hl, $d240 ; $4f9d
	ld de, $d0ac ; $4fa0
	ld b, $06 ; $4fa3
	ld c, $02 ; $4fa5
	farcall CopyTilemapRect ; $4fa7
	ld hl, $d640 ; $4faa
	ld de, $d4a5 ; $4fad
	ld b, $06 ; $4fb0
	ld c, $02 ; $4fb2
	farcall CopyTilemapRect ; $4fb4
	ld hl, $d640 ; $4fb7
	ld de, $d4ac ; $4fba
	ld b, $06 ; $4fbd
	ld c, $02 ; $4fbf
	farcall CopyTilemapRect ; $4fc1
	jr .restore ; $4fc4
.nonZero:
	ld hl, $d246 ; $4fc6
	ld de, $d0a5 ; $4fc9
	ld b, $06 ; $4fcc
	ld c, $02 ; $4fce
	farcall CopyTilemapRect ; $4fd0
	ld hl, $d246 ; $4fd3
	ld de, $d0ac ; $4fd6
	ld b, $06 ; $4fd9
	ld c, $02 ; $4fdb
	farcall CopyTilemapRect ; $4fdd
	ld hl, $d646 ; $4fe0
	ld de, $d4a5 ; $4fe3
	ld b, $06 ; $4fe6
	ld c, $02 ; $4fe8
	farcall CopyTilemapRect ; $4fea
	ld hl, $d646 ; $4fed
	ld de, $d4ac ; $4ff0
	ld b, $06 ; $4ff3
	ld c, $02 ; $4ff5
	farcall CopyTilemapRect ; $4ff7
.restore:
	pop af ; $4ffa
	wram_bank ; $4ffb
	ret ; $4fff
DrawN64TnmtTrophyRows:
	wram_bank $03 ; $5000
	ld a, [$d802] ; $5006
	add a, a ; $5009
	ld b, a ; $500a
	add a, a ; $500b
	add a, b ; $500c
	add a, a ; $500d
	ld hl, $d830 ; $500e
	add a, l ; $5011
	ld l, a ; $5012
	jr nc, .gotPtr ; $5013
	inc h ; $5015
.gotPtr:
	ld a, [$d801] ; $5016
	or a, a ; $5019
	jr z, .drawN64TnmtTrophyRow ; $501a
	ld a, $06 ; $501c
	add a, l ; $501e
	ld l, a ; $501f
	jr nc, .drawN64TnmtTrophyRow ; $5020
	inc h ; $5022
.drawN64TnmtTrophyRow:
	ld de, $d0e5 ; $5023
	ld c, $00 ; $5026
.loop:
	call DrawN64TnmtTrophyRow ; $5028
	push hl ; $502b
	ld hl, $0040 ; $502c
	add hl, de ; $502f
	ld d, h ; $5030
	ld e, l ; $5031
	pop hl ; $5032
	ld a, $0c ; $5033
	add a, l ; $5035
	ld l, a ; $5036
	jr nc, .gotPtr2 ; $5037
	inc h ; $5039
.gotPtr2:
	ld a, c ; $503a
	inc a ; $503b
	ld c, a ; $503c
	cp a, $05 ; $503d
	jr nz, .loop ; $503f
	ret ; $5041
DrawN64TnmtTrophyRow:
	push af ; $5042
	push bc ; $5043
	push de ; $5044
	push hl ; $5045
	ld c, $00 ; $5046
.loop:
	ld a, [hl+] ; $5048
	or a, a ; $5049
	jr z, .drawEmptyTrophyCell ; $504a
	call DrawWonTrophyIcon ; $504c
	jr .next ; $504f
.drawEmptyTrophyCell:
	call DrawEmptyTrophyCell ; $5051
.next:
	inc de ; $5054
	inc de ; $5055
	ld a, c ; $5056
	inc a ; $5057
	ld c, a ; $5058
	cp a, $03 ; $5059
	jr nz, .loop ; $505b
	inc de ; $505d
	ld c, $00 ; $505e
.loopB:
	ld a, [hl+] ; $5060
	or a, a ; $5061
	jr z, .drawEmptyTrophyCell2 ; $5062
	call DrawWonTrophyIcon ; $5064
	jr .next2 ; $5067
.drawEmptyTrophyCell2:
	call DrawEmptyTrophyCell ; $5069
.next2:
	inc de ; $506c
	inc de ; $506d
	ld a, c ; $506e
	inc a ; $506f
	ld c, a ; $5070
	cp a, $03 ; $5071
	jr nz, .loopB ; $5073
	pop hl ; $5075
	pop de ; $5076
	pop bc ; $5077
	pop af ; $5078
	ret ; $5079
DrawEmptyTrophyCell:
	push af ; $507a
	push bc ; $507b
	push de ; $507c
	push hl ; $507d
	ld hl, $d24c ; $507e
	ld b, $02 ; $5081
	ld c, $02 ; $5083
	farcall CopyTilemapRect ; $5085
	pop hl ; $5088
	pop de ; $5089
	pop bc ; $508a
	pop af ; $508b
	ret ; $508c
FlushN64TnmtWindowToVram:
	ld hl, $d0a0 ; $508d
	ld de, $98a0 ; $5090
	ld c, $08 ; $5093
	call QueueVRAMCopy ; $5095
	ld hl, $d4a0 ; $5098
	ld de, $b8a0 ; $509b
	ld c, $08 ; $509e
	call QueueVRAMCopy ; $50a0
	call AdvanceFrame ; $50a3
	ld hl, $d120 ; $50a6
	ld de, $9920 ; $50a9
	ld c, $08 ; $50ac
	call QueueVRAMCopy ; $50ae
	ld hl, $d520 ; $50b1
	ld de, $b920 ; $50b4
	ld c, $08 ; $50b7
	call QueueVRAMCopy ; $50b9
	call AdvanceFrame ; $50bc
	ld hl, $d1a0 ; $50bf
	ld de, $99a0 ; $50c2
	ld c, $08 ; $50c5
	call QueueVRAMCopy ; $50c7
	ld hl, $d5a0 ; $50ca
	ld de, $b9a0 ; $50cd
	ld c, $08 ; $50d0
	call QueueVRAMCopy ; $50d2
	ret ; $50d5
N64TnmtScrollArrowsTask:
	ldh a, [hWramBank] ; $50d6
	push af ; $50d8
	wram_bank $03 ; $50d9
	ld a, [$d800] ; $50df
	or a, a ; $50e2
	jr z, .applyCursorBounceX ; $50e3
	ld a, [$d801] ; $50e5
	or a, a ; $50e8
	jr nz, .applyCursorBounceX ; $50e9
	ld de, $932f ; $50eb
	ld c, $01 ; $50ee
	call ApplyCursorBounceX ; $50f0
	ld b, $08 ; $50f3
	ld c, $00 ; $50f5
	ld h, $00 ; $50f7
	farcall QueueStackedSpritePair ; $50f9
.applyCursorBounceX:
	ld a, [$d801] ; $50fc
	or a, a ; $50ff
	jr z, .zero ; $5100
	ld de, $202f ; $5102
	ld c, $00 ; $5105
	call ApplyCursorBounceX ; $5107
	ld b, $08 ; $510a
	ld c, $00 ; $510c
	ld h, $01 ; $510e
	farcall QueueStackedSpritePair ; $5110
.zero:
	ld a, [$d802] ; $5113
	or a, a ; $5116
	jr z, .zero2 ; $5117
	ld de, $0c32 ; $5119
	ld c, $01 ; $511c
	call ApplyCursorBounceY ; $511e
	ld b, $08 ; $5121
	ld c, $00 ; $5123
	ld h, $02 ; $5125
	farcall QueueStackedSpritePair ; $5127
.zero2:
	ld a, [$d802] ; $512a
	cp a, $0b ; $512d
	jr z, .restore ; $512f
	ld de, $0c88 ; $5131
	ld c, $00 ; $5134
	call ApplyCursorBounceY ; $5136
	ld b, $08 ; $5139
	ld c, $00 ; $513b
	ld h, $03 ; $513d
	farcall QueueStackedSpritePair ; $513f
.restore:
	pop af ; $5142
	wram_bank ; $5143
	ret ; $5147
RunN64RingShotData:
	call DisableLCDSafely ; $5148
	sound $04 ; $514b
	call BuildN64RingShotScreen ; $514d
	xor a, a ; $5150
	ld [wAnimatedTileSet], a ; $5151
	ld a, $01 ; $5154
	ld hl, UpdateAnimatedTilesTask_3b ; $5156
	call RegisterFrameTask ; $5159
	ld a, $01 ; $515c
	ld hl, RingShotScrollArrowsTask ; $515e
	call RegisterFrameTask ; $5161
	ld a, $01 ; $5164
	ld hl, RingShotScoreDrawTask ; $5166
	call RegisterFrameTask ; $5169
	call EnableLCD ; $516c
	script_fade_in $10 ; $516f
	call WaitFadeEnd ; $5174
	wram_bank $03 ; $5177
.loop:
	ldh a, [hInputPressed] ; $517d
	ld [wMenuInputPressed], a ; $517f
	call ScrollRingShotCursor ; $5182
	call AdvanceFrame ; $5185
	ld a, [wMenuInputPressed] ; $5188
	bit PADB_A, a ; $518b
	jr nz, .playSfx ; $518d
	bit 1, a ; $518f
	jr nz, .playSfx2 ; $5191
	jr .loop ; $5193
.playSfx:
	sound $5f ; $5195
	ld c, $10 ; $5197
	call BeginFadeOut ; $5199
	call WaitFadeEnd ; $519c
	call ClearFrameTasks ; $519f
	ret ; $51a2
.playSfx2:
	sound $62 ; $51a3
	ld c, $10 ; $51a5
	call BeginFadeOut ; $51a7
	call WaitFadeEnd ; $51aa
	call ClearFrameTasks ; $51ad
	ld a, $ff ; $51b0
	ret ; $51b2
BuildN64RingShotScreen:
	xor a, a ; $51b3
	ld [wMenuCursorX], a ; $51b4
	ld [wMenuCursorY], a ; $51b7
	ld c, $12 ; $51ba
	farcall LoadScreenAssetRecord ; $51bc
	wram_bank $03 ; $51bf
	call LoadN64RingShotRecords ; $51c5
	wram_bank $03 ; $51c8
	ld de, $aac0 ; $51ce
	call LoadChartWindowTiles ; $51d1
	ld de, $a000 ; $51d4
	farcall LoadMenuArrowSpriteTiles ; $51d7
	ld b, $08 ; $51da
	ld c, $0f ; $51dc
	farcall LoadIndexedPalette ; $51de
	ld de, $a100 ; $51e1
	ld b, $09 ; $51e4
	ld c, $00 ; $51e6
	farcall InitNumberSpriteGfx ; $51e8
	ld a, $09 ; $51eb
	ld [$cb6c], a ; $51ed
	ld a, $10 ; $51f0
	ld [$cb6b], a ; $51f2
	call DrawRingShotRowIcons ; $51f5
	call DrawRingShotModeTab ; $51f8
	call DrawRingShotClearMarks ; $51fb
	farcall QueueWram3MapToVRAM ; $51fe
	ret ; $5201
DrawRingShotRowIcons:
	push af ; $5202
	push bc ; $5203
	push de ; $5204
	push hl ; $5205
	ldh a, [hWramBank] ; $5206
	push af ; $5208
	wram_bank $03 ; $5209
	ld hl, $dc40 ; $520f
	ld a, [wMenuCursorY] ; $5212
	add a, l ; $5215
	ld l, a ; $5216
	jr nc, .gotPtr ; $5217
	inc h ; $5219
.gotPtr:
	ld d, h ; $521a
	ld e, l ; $521b
	ld c, $00 ; $521c
	ld hl, $d0c2 ; $521e
.loop:
	ld a, [de] ; $5221
	inc de ; $5222
	ld b, a ; $5223
	call DrawChartCharIcon ; $5224
	push de ; $5227
	ld de, $0040 ; $5228
	add hl, de ; $522b
	pop de ; $522c
	ld a, c ; $522d
	inc a ; $522e
	ld c, a ; $522f
	cp a, $05 ; $5230
	jr nz, .loop ; $5232
	pop af ; $5234
	wram_bank ; $5235
	pop hl ; $5239
	pop de ; $523a
	pop bc ; $523b
	pop af ; $523c
	ret ; $523d
LoadN64RingShotRecords:
	wram_bank $03 ; $523e
	call ReadN64RecordsSaveBlock ; $5244
	ld hl, $5278 ; $5247
	ld de, $dc40 ; $524a
	ld bc, $0010 ; $524d
	call CopyMemoryBC ; $5250
	ld hl, $da58 ; $5253
	ld a, [hl] ; $5256
	ld b, a ; $5257
	and a, $01 ; $5258
	jr nz, .maskSet ; $525a
	ld a, $10 ; $525c
	ld [$dc4e], a ; $525e
.maskSet:
	ld a, b ; $5261
	and a, $02 ; $5262
	jr nz, .maskSet2 ; $5264
	ld a, $10 ; $5266
	ld [$dc4f], a ; $5268
.maskSet2:
	ld hl, $db00 ; $526b
	ld bc, $0140 ; $526e
	call ClearBytes ; $5271
	call BuildRingShotResultsGrid ; $5274
	ret ; $5277
	; $5278, 16 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x00
SeedDefaultRingShotRecords:
	ld hl, $52e9 ; $5288
	ld de, $d918 ; $528b
	ld bc, $0010 ; $528e
	call CopyMemoryBC ; $5291
	ld hl, $52e9 ; $5294
	ld de, $d928 ; $5297
	ld bc, $0010 ; $529a
	call CopyMemoryBC ; $529d
	ld hl, $52e9 ; $52a0
	ld de, $d938 ; $52a3
	ld bc, $0010 ; $52a6
	call CopyMemoryBC ; $52a9
	ld hl, $52e9 ; $52ac
	ld de, $d948 ; $52af
	ld bc, $0010 ; $52b2
	call CopyMemoryBC ; $52b5
	ld hl, $52f9 ; $52b8
	ld de, $d958 ; $52bb
	ld bc, $0020 ; $52be
	call CopyMemoryBC ; $52c1
	ld hl, $52f9 ; $52c4
	ld de, $d978 ; $52c7
	ld bc, $0020 ; $52ca
	call CopyMemoryBC ; $52cd
	ld hl, $52f9 ; $52d0
	ld de, $d998 ; $52d3
	ld bc, $0020 ; $52d6
	call CopyMemoryBC ; $52d9
	ld hl, $52f9 ; $52dc
	ld de, $d9b8 ; $52df
	ld bc, $0020 ; $52e2
	call CopyMemoryBC ; $52e5
	ret ; $52e8
	; $52e9, 48 bytes (bytes:16)
	db $1f, $03, $0f, $01, $00, $01, $0f, $1f, $07, $05, $03, $0f, $1f, $03, $07, $03 ; 0x00
	db $00, $33, $00, $44, $00, $55, $00, $66, $00, $11, $00, $28, $00, $22, $01, $ff ; 0x10
	db $00, $02, $00, $00, $01, $43, $01, $00, $00, $01, $00, $21, $00, $12, $00, $12 ; 0x20
BuildRingShotResultsGrid:
	ld de, $db00 ; $5319
	ld c, $00 ; $531c
.loop:
	ld hl, $5358 ; $531e
	ld a, c ; $5321
	add a, l ; $5322
	ld l, a ; $5323
	jr nc, .read ; $5324
	inc h ; $5326
.read:
	ld b, [hl] ; $5327
	call DecodeRingShotCharClears ; $5328
	ld hl, $000c ; $532b
	add hl, de ; $532e
	ld d, h ; $532f
	ld e, l ; $5330
	ld a, c ; $5331
	inc a ; $5332
	ld c, a ; $5333
	cp a, $10 ; $5334
	jr nz, .loop ; $5336
	ld de, $db04 ; $5338
	ld c, $00 ; $533b
.loopB:
	ld hl, $5358 ; $533d
	ld a, c ; $5340
	add a, l ; $5341
	ld l, a ; $5342
	jr nc, .readB ; $5343
	inc h ; $5345
.readB:
	ld b, [hl] ; $5346
	call CopyRingShotCharScores ; $5347
	ld hl, $000c ; $534a
	add hl, de ; $534d
	ld d, h ; $534e
	ld e, l ; $534f
	ld a, c ; $5350
	inc a ; $5351
	ld c, a ; $5352
	cp a, $10 ; $5353
	jr nz, .loopB ; $5355
	ret ; $5357
	; $5358, 16 bytes (bytes:16)
	db $02, $0a, $01, $06, $00, $05, $0f, $09, $08, $0b, $07, $0c, $03, $04, $0e, $0d ; 0x00
CopyRingShotCharScores:
	push af ; $5368
	push bc ; $5369
	push de ; $536a
	push hl ; $536b
	ld a, b ; $536c
	add a, a ; $536d
	add a, a ; $536e
	add a, a ; $536f
	ld hl, $d958 ; $5370
	add a, l ; $5373
	ld l, a ; $5374
	jr nc, .gotPtr ; $5375
	inc h ; $5377
.gotPtr:
	ld c, $00 ; $5378
.loop:
	ld a, [hl+] ; $537a
	ld b, a ; $537b
	ld a, [hl+] ; $537c
	ld [de], a ; $537d
	inc de ; $537e
	ld a, b ; $537f
	ld [de], a ; $5380
	inc de ; $5381
	ld a, c ; $5382
	inc a ; $5383
	ld c, a ; $5384
	cp a, $04 ; $5385
	jr nz, .loop ; $5387
	pop hl ; $5389
	pop de ; $538a
	pop bc ; $538b
	pop af ; $538c
	ret ; $538d
DecodeRingShotCharClears:
	push af ; $538e
	push bc ; $538f
	push de ; $5390
	push hl ; $5391
	ld a, b ; $5392
	add a, a ; $5393
	add a, a ; $5394
	ld hl, $d918 ; $5395
	add a, l ; $5398
	ld l, a ; $5399
	jr nc, .gotPtr ; $539a
	inc h ; $539c
.gotPtr:
	ld c, $00 ; $539d
.loop:
	ld b, [hl] ; $539f
	call CountConsecutiveSetBits ; $53a0
	ld [de], a ; $53a3
	inc de ; $53a4
	inc hl ; $53a5
	ld a, c ; $53a6
	inc a ; $53a7
	ld c, a ; $53a8
	cp a, $04 ; $53a9
	jr nz, .loop ; $53ab
	pop hl ; $53ad
	pop de ; $53ae
	pop bc ; $53af
	pop af ; $53b0
	ret ; $53b1
CountConsecutiveSetBits:
	push bc ; $53b2
	ld c, $00 ; $53b3
.loop:
	ld a, b ; $53b5
	and a, $01 ; $53b6
	jr z, .maskClear ; $53b8
	srl b ; $53ba
	ld a, c ; $53bc
	inc a ; $53bd
	ld c, a ; $53be
	cp a, $06 ; $53bf
	jr nz, .loop ; $53c1
.maskClear:
	ld a, c ; $53c3
	pop bc ; $53c4
	ret ; $53c5
ScrollRingShotCursor:
	ld a, [wMenuInputPressed] ; $53c6
	bit PADB_RIGHT, a ; $53c9
	jr nz, .checkMenuCursorX ; $53cb
	bit 5, a ; $53cd
	jr nz, .checkMenuCursorX2 ; $53cf
	bit 6, a ; $53d1
	jr nz, .checkMenuCursorY ; $53d3
	bit 7, a ; $53d5
	jr nz, .checkMenuCursorY2 ; $53d7
	ret ; $53d9
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $53da
	cp a, $03 ; $53dd
	jr z, .done ; $53df
	inc a ; $53e1
	ld [wMenuCursorX], a ; $53e2
	call RedrawRingShotWindow ; $53e5
	jr .done ; $53e8
.checkMenuCursorX2:
	ld a, [wMenuCursorX] ; $53ea
	or a, a ; $53ed
	jr z, .done ; $53ee
	dec a ; $53f0
	ld [wMenuCursorX], a ; $53f1
	call RedrawRingShotWindow ; $53f4
	jr .done ; $53f7
.checkMenuCursorY:
	ld a, [wMenuCursorY] ; $53f9
	or a, a ; $53fc
	jr z, .done ; $53fd
	dec a ; $53ff
	ld [wMenuCursorY], a ; $5400
	call RedrawRingShotWindow ; $5403
	jr .done ; $5406
.checkMenuCursorY2:
	ld a, [wMenuCursorY] ; $5408
	cp a, $0b ; $540b
	jr z, .done ; $540d
	inc a ; $540f
	ld [wMenuCursorY], a ; $5410
	call RedrawRingShotWindow ; $5413
.done:
	ret ; $5416
RedrawRingShotWindow:
	sound $5e ; $5417
	call DrawRingShotRowIcons ; $5419
	call DrawRingShotClearMarks ; $541c
	call DrawRingShotModeTab ; $541f
	call FlushRingShotWindowToVram ; $5422
	ret ; $5425
DrawRingShotModeTab:
	ldh a, [hWramBank] ; $5426
	push af ; $5428
	wram_bank $03 ; $5429
	ld a, [wMenuCursorX] ; $542f
	add a, a ; $5432
	ld hl, $544e ; $5433
	add a, l ; $5436
	ld l, a ; $5437
	jr nc, .read ; $5438
	inc h ; $543a
.read:
	ld a, [hl+] ; $543b
	ld h, [hl] ; $543c
	ld l, a ; $543d
	ld de, $d026 ; $543e
	ld b, $08 ; $5441
	ld c, $02 ; $5443
	farcall CopyTilemapRect ; $5445
	pop af ; $5448
	wram_bank ; $5449
	ret ; $544d
	; $544e, 8 bytes (records:2)
	dw $d055 ; record 0
	dw $d095 ; record 1
	dw $d0d5 ; record 2
	dw $d015 ; record 3
FlushRingShotWindowToVram:
	ld hl, $d020 ; $5456
	ld de, $9820 ; $5459
	ld c, $04 ; $545c
	call QueueVRAMCopy ; $545e
	ld hl, $d0c0 ; $5461
	ld de, $98c0 ; $5464
	ld c, $08 ; $5467
	call QueueVRAMCopy ; $5469
	ld hl, $d4c0 ; $546c
	ld de, $b8c0 ; $546f
	ld c, $08 ; $5472
	call QueueVRAMCopy ; $5474
	call AdvanceFrame ; $5477
	ld hl, $d140 ; $547a
	ld de, $9940 ; $547d
	ld c, $0c ; $5480
	call QueueVRAMCopy ; $5482
	ld hl, $d540 ; $5485
	ld de, $b940 ; $5488
	ld c, $0c ; $548b
	call QueueVRAMCopy ; $548d
	ret ; $5490
RingShotScrollArrowsTask:
	ldh a, [hWramBank] ; $5491
	push af ; $5493
	wram_bank $03 ; $5494
	ld a, [wMenuCursorX] ; $549a
	cp a, $03 ; $549d
	jr z, .checkMenuCursorX ; $549f
	ld de, $7812 ; $54a1
	ld c, $01 ; $54a4
	call ApplyCursorBounceX ; $54a6
	ld b, $08 ; $54a9
	ld c, $00 ; $54ab
	ld h, $00 ; $54ad
	farcall QueueStackedSpritePair ; $54af
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $54b2
	or a, a ; $54b5
	jr z, .checkMenuCursorY ; $54b6
	ld de, $2312 ; $54b8
	ld c, $00 ; $54bb
	call ApplyCursorBounceX ; $54bd
	ld b, $08 ; $54c0
	ld c, $00 ; $54c2
	ld h, $01 ; $54c4
	farcall QueueStackedSpritePair ; $54c6
.checkMenuCursorY:
	ld a, [wMenuCursorY] ; $54c9
	or a, a ; $54cc
	jr z, .checkMenuCursorY2 ; $54cd
	ld de, $0c26 ; $54cf
	ld c, $01 ; $54d2
	call ApplyCursorBounceY ; $54d4
	ld b, $08 ; $54d7
	ld c, $00 ; $54d9
	ld h, $02 ; $54db
	farcall QueueStackedSpritePair ; $54dd
.checkMenuCursorY2:
	ld a, [wMenuCursorY] ; $54e0
	cp a, $0b ; $54e3
	jr z, .restore ; $54e5
	ld de, $0c82 ; $54e7
	ld c, $00 ; $54ea
	call ApplyCursorBounceY ; $54ec
	ld b, $08 ; $54ef
	ld c, $00 ; $54f1
	ld h, $03 ; $54f3
	farcall QueueStackedSpritePair ; $54f5
.restore:
	pop af ; $54f8
	wram_bank ; $54f9
	ret ; $54fd
DrawRingShotClearMarks:
	ld a, [wMenuCursorY] ; $54fe
	ld hl, $db00 ; $5501
	ld bc, $000c ; $5504
.loop:
	or a, a ; $5507
	jr z, .checkMenuCursorX ; $5508
	add hl, bc ; $550a
	dec a ; $550b
	jr .loop ; $550c
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $550e
	add a, l ; $5511
	ld l, a ; $5512
	jr nc, .gotPtr ; $5513
	inc h ; $5515
.gotPtr:
	ld b, $00 ; $5516
.loopB:
	ld a, [hl] ; $5518
	ld c, a ; $5519
	call DrawRingShotClearMarkRow ; $551a
	ld de, $000c ; $551d
	add hl, de ; $5520
	ld a, b ; $5521
	inc a ; $5522
	ld b, a ; $5523
	cp a, $05 ; $5524
	jr nz, .loopB ; $5526
	ret ; $5528
DrawRingShotClearMarkRow:
	push af ; $5529
	push bc ; $552a
	push de ; $552b
	push hl ; $552c
	ld a, b ; $552d
	add a, a ; $552e
	ld hl, $5564 ; $552f
	add a, l ; $5532
	ld l, a ; $5533
	jr nc, .read ; $5534
	inc h ; $5536
.read:
	ld a, [hl+] ; $5537
	ld d, [hl] ; $5538
	ld e, a ; $5539
	ld b, c ; $553a
.loop:
	ld a, b ; $553b
	or a, a ; $553c
	jr z, .zero ; $553d
	ld h, b ; $553f
	ld b, $00 ; $5540
	call DrawRingShotMarkCell ; $5542
	inc de ; $5545
	inc de ; $5546
	ld b, h ; $5547
	dec b ; $5548
	jr .loop ; $5549
.zero:
	ld a, $05 ; $554b
	sub a, c ; $554d
	ld b, a ; $554e
.loopB:
	ld a, b ; $554f
	or a, a ; $5550
	jr z, .restore ; $5551
	ld h, b ; $5553
	ld b, $01 ; $5554
	call DrawRingShotMarkCell ; $5556
	inc de ; $5559
	inc de ; $555a
	ld b, h ; $555b
	dec b ; $555c
	jr .loopB ; $555d
.restore:
	pop hl ; $555f
	pop de ; $5560
	pop bc ; $5561
	pop af ; $5562
	ret ; $5563
	; $5564, 10 bytes (records:2)
	dw $d0c4 ; record 0
	dw $d104 ; record 1
	dw $d144 ; record 2
	dw $d184 ; record 3
	dw $d1c4 ; record 4
DrawRingShotMarkCell:
	push af ; $556e
	push bc ; $556f
	push de ; $5570
	push hl ; $5571
	ld a, b ; $5572
	add a, a ; $5573
	ld hl, $558b ; $5574
	add a, l ; $5577
	ld l, a ; $5578
	jr nc, .read ; $5579
	inc h ; $557b
.read:
	ld a, [hl+] ; $557c
	ld h, [hl] ; $557d
	ld l, a ; $557e
	ld b, $02 ; $557f
	ld c, $02 ; $5581
	farcall CopyTilemapRect ; $5583
	pop hl ; $5586
	pop de ; $5587
	pop bc ; $5588
	pop af ; $5589
	ret ; $558a
	; $558b, 4 bytes (records:2)
	dw $d115 ; record 0
	dw $d117 ; record 1
RingShotScoreDrawTask:
	ld a, [wMenuCursorY] ; $558f
	ld hl, $db00 ; $5592
	ld bc, $000c ; $5595
.loop:
	or a, a ; $5598
	jr z, .zero ; $5599
	add hl, bc ; $559b
	dec a ; $559c
	jr .loop ; $559d
.zero:
	ld a, $04 ; $559f
	add a, l ; $55a1
	ld l, a ; $55a2
	jr nc, .checkMenuCursorX ; $55a3
	inc h ; $55a5
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $55a6
	add a, a ; $55a9
	add a, l ; $55aa
	ld l, a ; $55ab
	jr nc, .gotPtr ; $55ac
	inc h ; $55ae
.gotPtr:
	ld de, $8a35 ; $55af
	ld c, $00 ; $55b2
.loopB:
	push hl ; $55b4
	ld a, [hl+] ; $55b5
	ld h, [hl] ; $55b6
	ld l, a ; $55b7
	farcall DrawDecimalNumberSprites_39 ; $55b8
	ld hl, $0010 ; $55bb
	add hl, de ; $55be
	ld d, h ; $55bf
	ld e, l ; $55c0
	pop hl ; $55c1
	ld a, $0c ; $55c2
	add a, l ; $55c4
	ld l, a ; $55c5
	jr nc, .gotPtr2 ; $55c6
	inc h ; $55c8
.gotPtr2:
	ld a, c ; $55c9
	inc a ; $55ca
	ld c, a ; $55cb
	cp a, $05 ; $55cc
	jr nz, .loopB ; $55ce
	ret ; $55d0
RunMainMenu:
	call InitSerialLink ; $55d1
	sound $03 ; $55d4
	ld hl, rIE ; $55d6
	res 2, [hl] ; $55d9
	call BuildSaveSlotSummaries ; $55db
	xor a, a ; $55de
	ld [$cb1a], a ; $55df
	call LoadMainMenuGfx ; $55e2
	farcall InitMenuBgScroll ; $55e5
	ld b, $01 ; $55e8
	ld c, $01 ; $55ea
	farcall LoadMenuSpritePalettePair ; $55ec
	ld b, $03 ; $55ef
	ld a, [$cb1b] ; $55f1
	ld c, a ; $55f4
	call SetMenuCursorFromCellIndex ; $55f5
	ld a, $00 ; $55f8
	ld [$cb16], a ; $55fa
	ld a, $01 ; $55fd
	ld [$cb18], a ; $55ff
	wram_bank $03 ; $5602
	ld a, [wMenuSlideDirection] ; $5608
	ld b, a ; $560b
	call MainMenuSlideIn ; $560c
	ld a, $7f ; $560f
	ld hl, MainMenuCursorSpriteTask ; $5611
	call RegisterFrameTask ; $5614
	call DrawMainMenuSelection ; $5617
	call ResetSerialState ; $561a
	farcall ResetCheatCodeBuffer ; $561d
	wram_bank $03 ; $5620
.loop:
	call AdvanceFrame ; $5626
	farcall UpdateCheatCodeEntry ; $5629
	ldh a, [hInputPressed] ; $562c
	ld [wMenuInputPressed], a ; $562e
	ld b, $03 ; $5631
	ld c, $03 ; $5633
	call MoveMenuCursor ; $5635
	or a, a ; $5638
	jr nz, .playSfx ; $5639
	jr .checkMenuInputPressed ; $563b
.playSfx:
	sound $5e ; $563d
	call DrawMainMenuSelection ; $563f
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $5642
	bit PADB_A, a ; $5645
	jr nz, .clearFrameTasks ; $5647
	bit 1, a ; $5649
	jr nz, .playSfx2 ; $564b
	bit 2, a ; $564d
	jr nz, .bit2Set ; $564f
	jr .loop ; $5651
.bit2Set:
	jr .loop ; $5653
.clearFrameTasks:
	ld a, $01 ; $5655
	ld [$cb71], a ; $5657
	sound $5f ; $565a
	call ClearFrameTasks ; $565c
	ld hl, rIE ; $565f
	set 2, [hl] ; $5662
	ld b, $01 ; $5664
	call MainMenuSlideOut ; $5666
	ld a, [wMenuCursorX] ; $5669
	cp a, $02 ; $566c
	jr nz, .storeMenuSlideDirection ; $566e
	ld a, [wMenuCursorY] ; $5670
	cp a, $00 ; $5673
	jr nz, .storeMenuSlideDirection ; $5675
	ld c, $03 ; $5677
	call GetMenuCursorCellIndex ; $5679
	ld [$cb1b], a ; $567c
	call TryMainMenuLinkHandshake ; $567f
	jp c, RunMainMenu ; $5682
.storeMenuSlideDirection:
	ld a, $01 ; $5685
	ld [wMenuSlideDirection], a ; $5687
	ld c, $03 ; $568a
	call GetMenuCursorCellIndex ; $568c
	ld [$cb1b], a ; $568f
	call MapMainMenuCursorToItemId ; $5692
	ret ; $5695
.playSfx2:
	sound $62 ; $5696
	call ResetSerialState ; $5698
	call ClearFrameTasks ; $569b
	ld hl, rIE ; $569e
	set 2, [hl] ; $56a1
	ld b, $00 ; $56a3
	call MainMenuSlideOut ; $56a5
	ld a, $00 ; $56a8
	ld [wMenuSlideDirection], a ; $56aa
	ld a, $ff ; $56ad
	ret ; $56af
MapMainMenuCursorToItemId:
	ld hl, $56ba ; $56b0
	add a, l ; $56b3
	ld l, a ; $56b4
	jr nc, .read ; $56b5
	inc h ; $56b7
.read:
	ld a, [hl] ; $56b8
	ret ; $56b9
	; $56ba, 9 bytes (bytes:3)
	db $03, $04, $05 ; 0x00
	db $00, $01, $02 ; 0x03
	db $06, $07, $08 ; 0x06
	ret ; $56c3
LoadMainMenuGfx:
	ldh a, [hWramBank] ; $56c4
	push af ; $56c6
	wram_bank $01 ; $56c7
	ld c, $00 ; $56cd
.loop:
	ld a, c ; $56cf
	add a, a ; $56d0
	ld hl, $57e0 ; $56d1
	add a, l ; $56d4
	ld l, a ; $56d5
	jr nc, .read ; $56d6
	inc h ; $56d8
.read:
	ld a, [hl+] ; $56d9
	ld h, [hl] ; $56da
	ld l, a ; $56db
	push af ; $56dc
	push bc ; $56dd
	push de ; $56de
	push hl ; $56df
	ld de, $d000 ; $56e0
	call DecompressDataFromBank ; $56e3
	pop hl ; $56e6
	pop de ; $56e7
	pop bc ; $56e8
	pop af ; $56e9
	ld hl, $57ec ; $56ea
	ld a, c ; $56ed
	add a, a ; $56ee
	add a, l ; $56ef
	ld l, a ; $56f0
	jr nc, .readB ; $56f1
	inc h ; $56f3
.readB:
	ld a, [hl+] ; $56f4
	ld d, [hl] ; $56f5
	ld e, a ; $56f6
	ld hl, $d000 ; $56f7
	push af ; $56fa
	push bc ; $56fb
	push de ; $56fc
	push hl ; $56fd
	ld bc, $0010 ; $56fe
	call QueueVRAMCopy ; $5701
	pop hl ; $5704
	pop de ; $5705
	pop bc ; $5706
	pop af ; $5707
	ld a, c ; $5708
	inc a ; $5709
	ld c, a ; $570a
	call AdvanceFrame ; $570b
	ld a, c ; $570e
	cp a, $06 ; $570f
	jr nz, .loop ; $5711
	wram_bank $03 ; $5713
	ld a, $00 ; $5719
	ld [wCurrentStorySlot], a ; $571b
	ld a, [$d300] ; $571e
	farcall LoadCharMugshotToBuffer ; $5721
	ld de, $b680 ; $5724
	farcall CopyMugshotBufferToVram ; $5727
	call AdvanceFrame ; $572a
	wram_bank $03 ; $572d
	ld a, $01 ; $5733
	ld [wCurrentStorySlot], a ; $5735
	ld a, [$d310] ; $5738
	farcall LoadCharMugshotToBuffer ; $573b
	ld de, $b710 ; $573e
	farcall CopyMugshotBufferToVram ; $5741
	call AdvanceFrame ; $5744
	wram_bank $03 ; $5747
	ld a, $02 ; $574d
	ld [wCurrentStorySlot], a ; $574f
	ld a, [$d320] ; $5752
	farcall LoadCharMugshotToBuffer ; $5755
	ld de, $af00 ; $5758
	farcall CopyMugshotBufferToVram ; $575b
	call AdvanceFrame ; $575e
	ld b, $1c ; $5761
	ld c, $10 ; $5763
	ld de, $a000 ; $5765
	farcall LoadCompressedTileBlock ; $5768
	call AdvanceFrame ; $576b
	ld b, $1d ; $576e
	ld c, $10 ; $5770
	ld de, $a100 ; $5772
	farcall LoadCompressedTileBlock ; $5775
	call AdvanceFrame ; $5778
	ld b, $1e ; $577b
	ld c, $12 ; $577d
	ld de, $a200 ; $577f
	farcall LoadCompressedTileBlock ; $5782
	call AdvanceFrame ; $5785
	ld b, $1f ; $5788
	ld c, $10 ; $578a
	ld de, $a320 ; $578c
	farcall LoadCompressedTileBlock ; $578f
	call AdvanceFrame ; $5792
	ld b, $20 ; $5795
	ld c, $10 ; $5797
	ld de, $a420 ; $5799
	farcall LoadCompressedTileBlock ; $579c
	call AdvanceFrame ; $579f
	ld b, $21 ; $57a2
	ld c, $10 ; $57a4
	ld de, $a520 ; $57a6
	farcall LoadCompressedTileBlock ; $57a9
	call AdvanceFrame ; $57ac
	ld b, $22 ; $57af
	ld c, $10 ; $57b1
	ld de, $a620 ; $57b3
	farcall LoadCompressedTileBlock ; $57b6
	call AdvanceFrame ; $57b9
	ld b, $1b ; $57bc
	ld c, $04 ; $57be
	ld de, $a720 ; $57c0
	farcall LoadCompressedTileBlock ; $57c3
	ld b, $08 ; $57c6
	ld c, $10 ; $57c8
	farcall LoadIndexedPalette ; $57ca
	call AdvanceFrame ; $57cd
	ld b, $3e ; $57d0
	ld c, $14 ; $57d2
	ld de, $8000 ; $57d4
	farcall LoadCompressedTileBlock ; $57d7
	pop af ; $57da
	wram_bank ; $57db
	ret ; $57df
	; $57e0, 32 bytes (bytes:2)
	db $12, $3c ; 0x00
	db $14, $3c ; 0x02
	db $16, $3c ; 0x04
	db $18, $3c ; 0x06
	db $1a, $3c ; 0x08
	db $1c, $3c ; 0x0a
	db $00, $a8 ; 0x0c
	db $00, $a9 ; 0x0e
	db $00, $aa ; 0x10
	db $00, $ab ; 0x12
	db $00, $ac ; 0x14
	db $00, $ad ; 0x16
	db $00, $00 ; 0x18
	db $8f, $01 ; 0x1a
	db $1f, $03 ; 0x1c
	db $1f, $03 ; 0x1e
MainMenuSlideIn:
	ld a, b ; $5800
	or a, a ; $5801
	jr z, .zero ; $5802
	ld c, $00 ; $5804
.loop:
	call AdvanceFrame ; $5806
	ld b, $00 ; $5809
	farcall RestoreMenuBgAndDrawPanel ; $580b
	ld b, $00 ; $580e
	farcall FlushWram3MapRows ; $5810
	ld a, c ; $5813
	inc a ; $5814
	ld c, a ; $5815
	cp a, $10 ; $5816
	jr nz, .loop ; $5818
	ret ; $581a
.zero:
	ld c, $09 ; $581b
.loopB:
	call AdvanceFrame ; $581d
	ld b, $01 ; $5820
	farcall RestoreMenuBgAndDrawPanel ; $5822
	ld b, $00 ; $5825
	farcall FlushWram3MapRows ; $5827
	ld a, c ; $582a
	dec a ; $582b
	ld c, a ; $582c
	cp a, $ff ; $582d
	jr nz, .loopB ; $582f
	ret ; $5831
MainMenuSlideOut:
	ld a, b ; $5832
	or a, a ; $5833
	jr z, .zero ; $5834
	ld c, $00 ; $5836
.loop:
	call AdvanceFrame ; $5838
	ld b, $01 ; $583b
	farcall RestoreMenuBgAndDrawPanel ; $583d
	ld b, $00 ; $5840
	farcall FlushWram3MapRows ; $5842
	ld a, c ; $5845
	inc a ; $5846
	ld c, a ; $5847
	cp a, $0c ; $5848
	jr nz, .loop ; $584a
	ret ; $584c
.zero:
	ld c, $0f ; $584d
.loopB:
	call AdvanceFrame ; $584f
	ld b, $00 ; $5852
	farcall RestoreMenuBgAndDrawPanel ; $5854
	ld b, $00 ; $5857
	farcall FlushWram3MapRows ; $5859
	ld a, c ; $585c
	dec a ; $585d
	ld c, a ; $585e
	or a, a ; $585f
	jr nz, .loopB ; $5860
	ret ; $5862
MainMenuCursorSpriteTask:
	farcall TickMenuBgScroll ; $5863
	ld c, $03 ; $5866
	call GetMenuCursorCellIndex ; $5868
	push af ; $586b
	ld hl, MainMenuCursorSpriteTaskTable1 ; $586c
	add a, l ; $586f
	ld l, a ; $5870
	jr nc, .read ; $5871
	inc h ; $5873
.read:
	ld c, [hl] ; $5874
	ld hl, MainMenuCursorSpriteTaskTable0 ; $5875
	pop af ; $5878
	add a, a ; $5879
	push af ; $587a
	add a, l ; $587b
	ld l, a ; $587c
	jr nc, .readB ; $587d
	inc h ; $587f
.readB:
	ld a, [hl+] ; $5880
	ld d, [hl] ; $5881
	ld e, a ; $5882
	farcall ApplySpriteBobOffset ; $5883
	pop af ; $5886
	ld hl, $58ba ; $5887
	add a, l ; $588a
	ld l, a ; $588b
	jr nc, .read2 ; $588c
	inc h ; $588e
.read2:
	ld a, [hl+] ; $588f
	ld h, [hl] ; $5890
	ld l, a ; $5891
	ld b, $08 ; $5892
	push de ; $5894
	call QueueSpriteTemplate ; $5895
	ld c, $03 ; $5898
	call GetMenuCursorCellIndex ; $589a
	ld hl, MainMenuCursorSpriteTaskTable2 ; $589d
	add a, l ; $58a0
	ld l, a ; $58a1
	jr nc, .read3 ; $58a2
	inc h ; $58a4
.read3:
	ld a, [hl] ; $58a5
	pop de ; $58a6
	ld hl, $17f8 ; $58a7
	add hl, de ; $58aa
	ld d, h ; $58ab
	ld e, l ; $58ac
	add a, d ; $58ad
	ld d, a ; $58ae
	ld hl, SpriteTemplate_3b_5912 ; $58af
	ld b, $08 ; $58b2
	ld c, $72 ; $58b4
	call QueueSpriteTemplate ; $58b6
	ret ; $58b9
	; $58ba, 18 bytes (records:2)
	dw $58cc ; record 0
	dw $58ed ; record 1
	dw $58cc ; record 2
	dw $58cc ; record 3
	dw $58cc ; record 4
	dw $58cc ; record 5
	dw $58cc ; record 6
	dw $58cc ; record 7
	dw $58cc ; record 8
	; $58cc, 70 bytes (bytes:4)
	db $10, $08, $00, $00 ; 0x00
	db $10, $10, $02, $00 ; 0x04
	db $10, $18, $04, $00 ; 0x08
	db $10, $20, $06, $00 ; 0x0c
	db $10, $28, $08, $00 ; 0x10
	db $10, $30, $0a, $00 ; 0x14
	db $10, $38, $0c, $00 ; 0x18
	db $10, $40, $0e, $00 ; 0x1c
	db $80, $10, $08, $00 ; 0x20
	db $00, $10, $10, $02 ; 0x24
	db $00, $10, $18, $04 ; 0x28
	db $00, $10, $20, $06 ; 0x2c
	db $00, $10, $28, $08 ; 0x30
	db $00, $10, $30, $0a ; 0x34
	db $00, $10, $38, $0c ; 0x38
	db $00, $10, $40, $0e ; 0x3c
	db $00, $10, $48, $10 ; 0x40
	db $00, $80 ; 0x44
SpriteTemplate_3b_5912:
	; $5912, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
MainMenuCursorSpriteTaskTable0:
	; $591b, 18 bytes (bytes:16)
	db $2e, $fc, $2e, $26, $2e, $5c, $52, $fe, $52, $2c, $52, $5e, $68, $fc, $68, $2c ; 0x00
	db $68, $5e ; 0x10
MainMenuCursorSpriteTaskTable1:
	; $592d, 9 bytes (bytes:9)
	db $10, $20, $32, $00, $00, $00, $42, $52, $62 ; 0x00
MainMenuCursorSpriteTaskTable2:
	; $5936, 50 bytes (bytes:16)
	db $00, $04, $00, $00, $00, $00, $00, $00, $00, $10, $08, $00, $00, $10, $10, $02 ; 0x00
	db $00, $10, $18, $04, $00, $10, $20, $06, $00, $10, $28, $08, $00, $10, $30, $0a ; 0x10
	db $00, $10, $38, $0c, $00, $10, $40, $0e, $00, $10, $48, $10, $00, $10, $50, $12 ; 0x20
	db $00, $80 ; 0x30
DrawMainMenuSelection:
	wram_bank $03 ; $5968
	ld b, $00 ; $596e
	ld c, $00 ; $5970
.loop:
	call FillMainMenuCellHighlight ; $5972
	ld a, b ; $5975
	inc a ; $5976
	ld b, a ; $5977
	cp a, $09 ; $5978
	jr nz, .loop ; $597a
	ld c, $03 ; $597c
	call GetMenuCursorCellIndex ; $597e
	ld b, a ; $5981
	ld c, $01 ; $5982
	call FillMainMenuCellHighlight ; $5984
	ld c, $03 ; $5987
	call GetMenuCursorCellIndex ; $5989
	cp a, $06 ; $598c
	jr nc, .loadMainMenuItemPalette ; $598e
	cp a, $03 ; $5990
	jr c, .loadMainMenuItemPalette ; $5992
	sub a, $03 ; $5994
	add a, a ; $5996
	add a, a ; $5997
	add a, a ; $5998
	add a, a ; $5999
	ld bc, $d300 ; $599a
	add a, c ; $599d
	ld c, a ; $599e
	jr nc, .gotPtr ; $599f
	inc b ; $59a1
.gotPtr:
	ld hl, $0001 ; $59a2
	add hl, bc ; $59a5
	ld a, [hl] ; $59a6
	ld d, $04 ; $59a7
	farcall LoadIndexedPalette_18 ; $59a9
	jr .fillTilemapRect ; $59ac
.loadMainMenuItemPalette:
	call LoadMainMenuItemPalette ; $59ae
.fillTilemapRect:
	wram_bank $03 ; $59b1
	ld de, $d1e0 ; $59b7
	ld b, $14 ; $59ba
	ld c, $01 ; $59bc
	ld h, $03 ; $59be
	farcall FillTilemapRect ; $59c0
	ld a, $02 ; $59c3
	ld [$d1e0], a ; $59c5
	ld a, $04 ; $59c8
	ld [$d1f3], a ; $59ca
	ld de, $d201 ; $59cd
	ld b, $12 ; $59d0
	ld c, $01 ; $59d2
	ld h, $20 ; $59d4
	farcall FillTilemapRect ; $59d6
	call DrawMainMenuCaption ; $59d9
	ld hl, $d460 ; $59dc
	ld de, $b860 ; $59df
	ld c, $06 ; $59e2
	call QueueVRAMCopy ; $59e4
	ld hl, $d4e0 ; $59e7
	ld de, $b8e0 ; $59ea
	ld c, $06 ; $59ed
	call QueueVRAMCopy ; $59ef
	ld hl, $d560 ; $59f2
	ld de, $b960 ; $59f5
	ld c, $06 ; $59f8
	call QueueVRAMCopy ; $59fa
	ld hl, $d1e0 ; $59fd
	ld de, $99e0 ; $5a00
	ld c, $04 ; $5a03
	call QueueVRAMCopy ; $5a05
	ret ; $5a08
FillMainMenuCellHighlight:
	push af ; $5a09
	push bc ; $5a0a
	push de ; $5a0b
	push hl ; $5a0c
	ld d, c ; $5a0d
	ld e, b ; $5a0e
	ld a, b ; $5a0f
	cp a, $06 ; $5a10
	jr nc, .step ; $5a12
	cp a, $03 ; $5a14
	jr c, .step ; $5a16
	ld b, $03 ; $5a18
	ld c, $03 ; $5a1a
	jr .step2 ; $5a1c
.step:
	ld b, $05 ; $5a1e
	ld c, $03 ; $5a20
.step2:
	ld a, d ; $5a22
	or a, a ; $5a23
	jr z, .zero ; $5a24
	ld h, $0c ; $5a26
	jr .step4 ; $5a28
.zero:
	ld h, $0d ; $5a2a
.step4:
	push hl ; $5a2c
	ld hl, $5a43 ; $5a2d
	ld a, e ; $5a30
	add a, a ; $5a31
	add a, l ; $5a32
	ld l, a ; $5a33
	jr nc, .read ; $5a34
	inc h ; $5a36
.read:
	ld a, [hl+] ; $5a37
	ld d, [hl] ; $5a38
	ld e, a ; $5a39
	pop hl ; $5a3a
	farcall FillTilemapRect ; $5a3b
	pop hl ; $5a3e
	pop de ; $5a3f
	pop bc ; $5a40
	pop af ; $5a41
	ret ; $5a42
	; $5a43, 20 bytes (records:2)
	dw $d461 ; record 0
	dw $d467 ; record 1
	dw $d46d ; record 2
	dw $d4e2 ; record 3
	dw $d4e8 ; record 4
	dw $d4ee ; record 5
	dw $d561 ; record 6
	dw $d567 ; record 7
	dw $d56d ; record 8
	dw $d507 ; record 9
LoadMainMenuItemPalette:
	ld hl, $5a6a ; $5a57
	add a, a ; $5a5a
	add a, l ; $5a5b
	ld l, a ; $5a5c
	jr nc, .read ; $5a5d
	inc h ; $5a5f
.read:
	ld a, [hl+] ; $5a60
	ld h, [hl] ; $5a61
	ld l, a ; $5a62
	ld de, $0401 ; $5a63
	call LoadPaletteShadow ; $5a66
	ret ; $5a69
	; $5a6a, 18 bytes (records:2)
	dw $5a7c ; record 0
	dw $5a8c ; record 1
	dw $5a94 ; record 2
	dw $5a7c ; record 3
	dw $5a7c ; record 4
	dw $5a7c ; record 5
	dw $5a9c ; record 6
	dw $5a84 ; record 7
	dw $5aa4 ; record 8
	; $5a7c, 48 bytes (bytes:8)
	db $9f, $3e, $ff, $6b, $0a, $50, $00, $00 ; 0x00
	db $cc, $3a, $ff, $6b, $40, $65, $00, $00 ; 0x08
	db $9f, $5a, $ff, $6b, $1f, $00, $00, $00 ; 0x10
	db $32, $1b, $ff, $6b, $e0, $15, $00, $00 ; 0x18
	db $5f, $1a, $ff, $6b, $7c, $00, $00, $00 ; 0x20
	db $96, $59, $ff, $6b, $12, $14, $00, $00 ; 0x28
BuildSaveSlotSummaries:
	ldh a, [hWramBank] ; $5aac
	push af ; $5aae
	wram_bank $03 ; $5aaf
	ld hl, $d300 ; $5ab5
	ld bc, $0003 ; $5ab8
	call ClearMemory16 ; $5abb
	ld bc, $d300 ; $5abe
	ld a, $80 ; $5ac1
.loop:
	push af ; $5ac3
	push af ; $5ac4
	wram_bank $02 ; $5ac5
	pop af ; $5acb
	farcall LoadCharacterRecordToBuffer ; $5acc
	farcall CheckCharacterUnlocked ; $5acf
	ld hl, $0000 ; $5ad2
	add hl, bc ; $5ad5
	wram_bank $02 ; $5ad6
	ld a, [$d58b] ; $5adc
	push af ; $5adf
	wram_bank $03 ; $5ae0
	pop af ; $5ae6
	cp a, $04 ; $5ae7
	jr c, .checkStoryModeMainCharacterOverworldSprite ; $5ae9
	ld [hl], a ; $5aeb
	inc hl ; $5aec
	ld a, $03 ; $5aed
	ld [hl-], a ; $5aef
	ld hl, $0010 ; $5af0
	add hl, bc ; $5af3
	ld b, h ; $5af4
	ld c, l ; $5af5
	jr .restore ; $5af6
.checkStoryModeMainCharacterOverworldSprite:
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $5af8
	ld [hl], a ; $5afb
	ld hl, $0001 ; $5afc
	add hl, bc ; $5aff
	ld a, [wStoryModeMainCharacterOverworldSpriteColor] ; $5b00
	ld [hl], a ; $5b03
	ld hl, $0002 ; $5b04
	add hl, bc ; $5b07
	ld a, [$c918] ; $5b08
	ld [hl], a ; $5b0b
	push bc ; $5b0c
	ld a, $03 ; $5b0d
	add a, c ; $5b0f
	ld e, a ; $5b10
	ld d, b ; $5b11
	ld hl, wStoryModeNameOfMainCharacter ; $5b12
	ld bc, $000b ; $5b15
	call CopyMemoryBC ; $5b18
	pop bc ; $5b1b
	ld hl, $000f ; $5b1c
	add hl, bc ; $5b1f
	ld a, [$c891] ; $5b20
	ld [hl], a ; $5b23
	ld hl, $000e ; $5b24
	add hl, bc ; $5b27
	ld a, [$c890] ; $5b28
	ld [hl], a ; $5b2b
	ld hl, $0010 ; $5b2c
	add hl, bc ; $5b2f
	ld b, h ; $5b30
	ld c, l ; $5b31
.restore:
	pop af ; $5b32
	inc a ; $5b33
	cp a, $83 ; $5b34
	jr nz, .loop ; $5b36
	pop af ; $5b38
	wram_bank ; $5b39
	ret ; $5b3d
DrawMainMenuCaption:
	ldh a, [hWramBank] ; $5b3e
	push af ; $5b40
	wram_bank $03 ; $5b41
	ld c, $03 ; $5b47
	call GetMenuCursorCellIndex ; $5b49
	ld b, a ; $5b4c
	cp a, $06 ; $5b4d
	jp nc, .step3 ; $5b4f
	cp a, $03 ; $5b52
	jp c, .step3 ; $5b54
	sub a, $03 ; $5b57
	add a, a ; $5b59
	add a, a ; $5b5a
	add a, a ; $5b5b
	add a, a ; $5b5c
	ld bc, $d300 ; $5b5d
	add a, c ; $5b60
	ld c, a ; $5b61
	jr nc, .gotPtr ; $5b62
	inc b ; $5b64
.gotPtr:
	ld hl, $0000 ; $5b65
	add hl, bc ; $5b68
	ld a, [hl] ; $5b69
	cp a, $3f ; $5b6a
	jr z, .eq3f ; $5b6c
	ld hl, $0003 ; $5b6e
	add hl, bc ; $5b71
	ld de, $d201 ; $5b72
	call DrawNameWithDiacritics_3b ; $5b75
	ld a, $4c ; $5b78
	ld [$d209], a ; $5b7a
	ld a, $56 ; $5b7d
	ld [$d20a], a ; $5b7f
	push af ; $5b82
	push bc ; $5b83
	push de ; $5b84
	push hl ; $5b85
	ld hl, $0002 ; $5b86
	add hl, bc ; $5b89
	ld a, [hl] ; $5b8a
	ld h, $00 ; $5b8b
	ld l, a ; $5b8d
	ld de, $d20c ; $5b8e
	ld bc, $d330 ; $5b91
	call PrintNumberRightAligned ; $5b94
	pop hl ; $5b97
	pop de ; $5b98
	pop bc ; $5b99
	pop af ; $5b9a
	push af ; $5b9b
	push bc ; $5b9c
	push de ; $5b9d
	push hl ; $5b9e
	ld hl, $000f ; $5b9f
	add hl, bc ; $5ba2
	ld a, [hl] ; $5ba3
	ld h, $00 ; $5ba4
	ld l, a ; $5ba6
	ld de, $d20f ; $5ba7
	ld bc, $d330 ; $5baa
	call Print2DigitNumberRightAligned ; $5bad
	pop hl ; $5bb0
	pop de ; $5bb1
	pop bc ; $5bb2
	pop af ; $5bb3
	ld hl, $000e ; $5bb4
	add hl, bc ; $5bb7
	ld a, [hl] ; $5bb8
	ld h, $00 ; $5bb9
	ld l, a ; $5bbb
	ld de, $d212 ; $5bbc
	ld bc, $d330 ; $5bbf
	call Print2DigitNumberRightAligned ; $5bc2
	pop af ; $5bc5
	wram_bank ; $5bc6
	ld a, $3a ; $5bca
	ld [$d210], a ; $5bcc
	ret ; $5bcf
.eq3f:
	ld hl, $007c ; $5bd0
	ld de, $d201 ; $5bd3
	ld c, $20 ; $5bd6
	farcall RenderTextToBuffer64 ; $5bd8
	jr .restore ; $5bdb
.step3:
	ld b, a ; $5bdd
	ld a, b ; $5bde
	add a, a ; $5bdf
	ld hl, $5c03 ; $5be0
	add a, l ; $5be3
	ld l, a ; $5be4
	jr nc, .read ; $5be5
	inc h ; $5be7
.read:
	ld a, [hl+] ; $5be8
	ld d, [hl] ; $5be9
	ld e, a ; $5bea
	ld a, b ; $5beb
	ld hl, $5c15 ; $5bec
	add a, a ; $5bef
	add a, l ; $5bf0
	ld l, a ; $5bf1
	jr nc, .readB ; $5bf2
	inc h ; $5bf4
.readB:
	ld a, [hl+] ; $5bf5
	ld h, [hl] ; $5bf6
	ld l, a ; $5bf7
	ld c, $20 ; $5bf8
	farcall RenderTextToBuffer64 ; $5bfa
.restore:
	pop af ; $5bfd
	wram_bank ; $5bfe
	ret ; $5c02
	; $5c03, 36 bytes (records:2)
	dw $d201 ; record 0
	dw $d201 ; record 1
	dw $d201 ; record 2
	dw $d201 ; record 3
	dw $d201 ; record 4
	dw $d201 ; record 5
	dw $d201 ; record 6
	dw $d201 ; record 7
	dw $d201 ; record 8
	dw $007d ; record 9
	dw $007e ; record 10
	dw $007f ; record 11
	dw $007c ; record 12
	dw $007c ; record 13
	dw $007c ; record 14
	dw $0080 ; record 15
	dw $0081 ; record 16
	dw $0082 ; record 17
Print2DigitNumberRightAligned:
	ld a, $02 ; $5c27
	jr PrintNumberRightAligned.format ; $5c29
PrintNumberRightAligned:
	ld a, $00 ; $5c2b
.format:
	push af ; $5c2d
	push bc ; $5c2e
	push de ; $5c2f
	push hl ; $5c30
	ld d, b ; $5c31
	ld e, c ; $5c32
	call FormatDecimalNumber ; $5c33
	pop hl ; $5c36
	pop de ; $5c37
	pop bc ; $5c38
	pop af ; $5c39
	ld h, b ; $5c3a
	ld l, c ; $5c3b
	ld c, $ff ; $5c3c
.lenLoop:
	inc c ; $5c3e
	ld a, [hl+] ; $5c3f
	or a, a ; $5c40
	jr nz, .lenLoop ; $5c41
	dec hl ; $5c43
	dec hl ; $5c44
.copyLoop:
	ld a, [hl-] ; $5c45
	cp a, $20 ; $5c46
	jr nz, .store ; $5c48
	ld a, $30 ; $5c4a
.store:
	ld [de], a ; $5c4c
	dec de ; $5c4d
	dec c ; $5c4e
	jr nz, .copyLoop ; $5c4f
	ret ; $5c51
	ret ; $5c52
TryMainMenuLinkHandshake:
	di ; $5c53
	xor a, a ; $5c54
	ldh [rIF], a ; $5c55
	ldh a, [rIE] ; $5c57
	and a, $09 ; $5c59
	ldh [rIE], a ; $5c5b
	ei ; $5c5d
	ld a, [wMenuCursorX] ; $5c5e
	cp a, $02 ; $5c61
	jr nz, .ne02 ; $5c63
	ld a, [wMenuCursorY] ; $5c65
	cp a, $00 ; $5c68
	jr z, .eq00 ; $5c6a
.ne02:
	scf ; $5c6c
	ccf ; $5c6d
	jr .done ; $5c6e
.eq00:
	di ; $5c70
	ldh a, [hLinkRxByte] ; $5c71
	ei ; $5c73
	cp a, $c1 ; $5c74
	jr z, .waitFramesCmd ; $5c76
.loop:
	farcall ShowLinkMessageScreen ; $5c78
	farcall TryEstablishLink ; $5c7b
	push af ; $5c7e
	jr nc, .beginFadeOut ; $5c7f
	or a, a ; $5c81
	jr nz, .nonZero ; $5c82
	ldh a, [hWramBank] ; $5c84
	push af ; $5c86
	ld c, $00 ; $5c87
	farcall ShowLinkStatusMessage ; $5c89
	pop af ; $5c8c
	wram_bank ; $5c8d
	jr .animateLinkStatusPalette ; $5c91
.nonZero:
	ldh a, [hWramBank] ; $5c93
	push af ; $5c95
	ld c, $01 ; $5c96
	farcall ShowLinkStatusMessage ; $5c98
	pop af ; $5c9b
	wram_bank ; $5c9c
.animateLinkStatusPalette:
	ld de, $01f4 ; $5ca0
.loopB:
	farcall AnimateLinkStatusPalette ; $5ca3
	farcall UpdateAnimatedTiles ; $5ca6
	call AdvanceFrame ; $5ca9
	ldh a, [hInputPressed] ; $5cac
	bit PADB_A, a ; $5cae
	jr nz, .beginFadeOut ; $5cb0
	bit 1, a ; $5cb2
	jr nz, .beginFadeOut ; $5cb4
	dec de ; $5cb6
	ld a, d ; $5cb7
	or a, e ; $5cb8
	jr nz, .loopB ; $5cb9
.beginFadeOut:
	ld c, $40 ; $5cbb
	call BeginFadeOut ; $5cbd
	call WaitFadeEnd ; $5cc0
	call DisableLCDSafely ; $5cc3
	farcall ResetScreenAndTextWindows ; $5cc6
	call EnableLCD ; $5cc9
	script_fade_in $40 ; $5ccc
	call WaitFadeEnd ; $5cd1
	pop af ; $5cd4
	jr .done ; $5cd5
.waitFramesCmd:
	call WaitFramesCmd ; $5cd7
	db $06 ; $5cda inline arg
	farcall TryEstablishLink ; $5cdb
	jr c, .loop ; $5cde
.done:
	ret ; $5ce0
RestoreScreenAfterLinkAttempt:
	call DisableLCDSafely ; $5ce1
	farcall LoadMenuFontGfx ; $5ce4
	farcall ResetScreenAndTextWindows ; $5ce7
	call EnableLCD ; $5cea
	script_fade_in $10 ; $5ced
	ret ; $5cf2
RunMatchFormatSelect:
	ld hl, rIE ; $5cf3
	res 2, [hl] ; $5cf6
	sound $03 ; $5cf8
	call LoadMatchFormatGfx ; $5cfa
	wram_bank $03 ; $5cfd
	ld a, [wMenuSlideDirection] ; $5d03
	ld b, a ; $5d06
	call MatchFormatSlideIn ; $5d07
	farcall InitMenuBgScroll ; $5d0a
	ld b, $01 ; $5d0d
	ld c, $01 ; $5d0f
	farcall LoadMenuSpritePalettePair ; $5d11
	call InitMatchFormatOptions ; $5d14
	ld a, $01 ; $5d17
	ld hl, MatchFormatCursorSpriteTask ; $5d19
	call RegisterFrameTask ; $5d1c
	call DrawMatchFormatCaption ; $5d1f
	wram_bank $03 ; $5d22
.loop:
	call AdvanceFrame ; $5d28
	ldh a, [hInputPressed] ; $5d2b
	ld [wMenuInputPressed], a ; $5d2d
	call HandleMatchFormatInput ; $5d30
	ld b, $01 ; $5d33
	ld c, $03 ; $5d35
	call MoveMenuCursor ; $5d37
	or a, a ; $5d3a
	jr z, .checkMenuInputPressed ; $5d3b
	sound $5e ; $5d3d
	call DrawMatchFormatCaption ; $5d3f
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $5d42
	bit PADB_A, a ; $5d45
	jr nz, .playSfx ; $5d47
	bit 1, a ; $5d49
	jr nz, .playSfx2 ; $5d4b
	jr .loop ; $5d4d
.playSfx:
	sound $5f ; $5d4f
	ld hl, rIE ; $5d51
	set 2, [hl] ; $5d54
	call ClearFrameTasks ; $5d56
	ld b, $01 ; $5d59
	call MatchFormatSlideOut ; $5d5b
	ld a, $01 ; $5d5e
	ld [wMenuSlideDirection], a ; $5d60
	ld c, $03 ; $5d63
	call GetMenuCursorCellIndex ; $5d65
	ret ; $5d68
.playSfx2:
	sound $62 ; $5d69
	ld hl, rIE ; $5d6b
	set 2, [hl] ; $5d6e
	call ClearFrameTasks ; $5d70
	ld b, $00 ; $5d73
	call MatchFormatSlideOut ; $5d75
	ld a, $00 ; $5d78
	ld [wMenuSlideDirection], a ; $5d7a
	ld a, $ff ; $5d7d
	ret ; $5d7f
InitMatchFormatOptions:
	ld b, $01 ; $5d80
	ld c, $00 ; $5d82
	call SetMenuCursorFromCellIndex ; $5d84
	ld a, [wMatchFormatDoubles] ; $5d87
	ld b, a ; $5d8a
	ld c, $01 ; $5d8b
	call FillMatchFormatOptionCell ; $5d8d
	ld b, $00 ; $5d90
	call FlushMatchFormatRowToVram ; $5d92
	ld a, [wMatchFormatGames] ; $5d95
	add a, $02 ; $5d98
	ld b, a ; $5d9a
	ld c, $01 ; $5d9b
	call FillMatchFormatOptionCell ; $5d9d
	ld b, $01 ; $5da0
	call FlushMatchFormatRowToVram ; $5da2
	ld a, [wMatchFormatSets] ; $5da5
	add a, $04 ; $5da8
	ld b, a ; $5daa
	ld c, $01 ; $5dab
	call FillMatchFormatOptionCell ; $5dad
	ld b, $02 ; $5db0
	call FlushMatchFormatRowToVram ; $5db2
	ld hl, $5dd4 ; $5db5
	ld d, $04 ; $5db8
	ld e, $01 ; $5dba
	call LoadPaletteShadow ; $5dbc
	ld hl, $5ddc ; $5dbf
	ld d, $06 ; $5dc2
	ld e, $01 ; $5dc4
	call LoadPaletteShadow ; $5dc6
	ld hl, $5de4 ; $5dc9
	ld d, $07 ; $5dcc
	ld e, $01 ; $5dce
	call LoadPaletteShadow ; $5dd0
	ret ; $5dd3
	; $5dd4, 24 bytes (bytes:8)
	db $df, $02, $ff, $7f, $a0, $01, $00, $00 ; 0x00
	db $df, $02, $ff, $7f, $1f, $01, $00, $00 ; 0x08
	db $1f, $03, $ff, $7f, $40, $51, $00, $00 ; 0x10
LoadMatchFormatGfx:
	ldh a, [hWramBank] ; $5dec
	push af ; $5dee
	wram_bank $01 ; $5def
	ld c, $00 ; $5df5
.loop:
	ld a, c ; $5df7
	add a, a ; $5df8
	ld hl, $5ebd ; $5df9
	add a, l ; $5dfc
	ld l, a ; $5dfd
	jr nc, .read ; $5dfe
	inc h ; $5e00
.read:
	ld a, [hl+] ; $5e01
	ld h, [hl] ; $5e02
	ld l, a ; $5e03
	push af ; $5e04
	push bc ; $5e05
	push de ; $5e06
	push hl ; $5e07
	ld de, $d000 ; $5e08
	call DecompressDataFromBank ; $5e0b
	pop hl ; $5e0e
	pop de ; $5e0f
	pop bc ; $5e10
	pop af ; $5e11
	ld hl, $5ecb ; $5e12
	ld a, c ; $5e15
	add a, a ; $5e16
	add a, l ; $5e17
	ld l, a ; $5e18
	jr nc, .readB ; $5e19
	inc h ; $5e1b
.readB:
	ld a, [hl+] ; $5e1c
	ld d, [hl] ; $5e1d
	ld e, a ; $5e1e
	ld hl, $d000 ; $5e1f
	push af ; $5e22
	push bc ; $5e23
	push de ; $5e24
	push hl ; $5e25
	ld bc, $0010 ; $5e26
	call QueueVRAMCopy ; $5e29
	pop hl ; $5e2c
	pop de ; $5e2d
	pop bc ; $5e2e
	pop af ; $5e2f
	ld a, c ; $5e30
	inc a ; $5e31
	ld c, a ; $5e32
	call AdvanceFrame ; $5e33
	ld a, c ; $5e36
	cp a, $07 ; $5e37
	jr nz, .loop ; $5e39
	ld b, $23 ; $5e3b
	ld c, $10 ; $5e3d
	ld de, $a000 ; $5e3f
	farcall LoadCompressedTileBlock ; $5e42
	call AdvanceFrame ; $5e45
	ld b, $24 ; $5e48
	ld c, $10 ; $5e4a
	ld de, $a100 ; $5e4c
	farcall LoadCompressedTileBlock ; $5e4f
	call AdvanceFrame ; $5e52
	ld b, $25 ; $5e55
	ld c, $10 ; $5e57
	ld de, $a200 ; $5e59
	farcall LoadCompressedTileBlock ; $5e5c
	call AdvanceFrame ; $5e5f
	ld b, $26 ; $5e62
	ld c, $10 ; $5e64
	ld de, $a300 ; $5e66
	farcall LoadCompressedTileBlock ; $5e69
	call AdvanceFrame ; $5e6c
	ld b, $27 ; $5e6f
	ld c, $10 ; $5e71
	ld de, $a400 ; $5e73
	farcall LoadCompressedTileBlock ; $5e76
	call AdvanceFrame ; $5e79
	ld b, $28 ; $5e7c
	ld c, $10 ; $5e7e
	ld de, $a500 ; $5e80
	farcall LoadCompressedTileBlock ; $5e83
	call AdvanceFrame ; $5e86
	ld b, $29 ; $5e89
	ld c, $10 ; $5e8b
	ld de, $a600 ; $5e8d
	farcall LoadCompressedTileBlock ; $5e90
	call AdvanceFrame ; $5e93
	ld b, $1b ; $5e96
	ld c, $04 ; $5e98
	ld de, $a700 ; $5e9a
	farcall LoadCompressedTileBlock ; $5e9d
	call AdvanceFrame ; $5ea0
	ld b, $3f ; $5ea3
	ld c, $14 ; $5ea5
	ld de, $8000 ; $5ea7
	farcall LoadCompressedTileBlock ; $5eaa
	call AdvanceFrame ; $5ead
	ld b, $08 ; $5eb0
	ld c, $10 ; $5eb2
	farcall LoadIndexedPalette ; $5eb4
	pop af ; $5eb7
	wram_bank ; $5eb8
	ret ; $5ebc
	; $5ebd, 28 bytes (bytes:2)
	db $62, $3c ; 0x00
	db $64, $3c ; 0x02
	db $66, $3c ; 0x04
	db $68, $3c ; 0x06
	db $6a, $3c ; 0x08
	db $6c, $3c ; 0x0a
	db $6e, $3c ; 0x0c
	db $00, $a8 ; 0x0e
	db $00, $a9 ; 0x10
	db $00, $aa ; 0x12
	db $00, $ab ; 0x14
	db $00, $ac ; 0x16
	db $00, $ad ; 0x18
	db $00, $ae ; 0x1a
MatchFormatSlideIn:
	ld a, b ; $5ed9
	or a, a ; $5eda
	jr z, .zero ; $5edb
	ld c, $00 ; $5edd
.loop:
	call AdvanceFrame ; $5edf
	ld b, $02 ; $5ee2
	farcall RestoreMenuBgAndDrawPanel ; $5ee4
	ld b, $00 ; $5ee7
	farcall FlushWram3MapRows ; $5ee9
	ld a, c ; $5eec
	inc a ; $5eed
	ld c, a ; $5eee
	cp a, $0e ; $5eef
	jr nz, .loop ; $5ef1
	ret ; $5ef3
.zero:
	ld c, $0a ; $5ef4
.loopB:
	call AdvanceFrame ; $5ef6
	ld b, $03 ; $5ef9
	farcall RestoreMenuBgAndDrawPanel ; $5efb
	ld b, $00 ; $5efe
	farcall FlushWram3MapRows ; $5f00
	ld a, c ; $5f03
	dec a ; $5f04
	ld c, a ; $5f05
	cp a, $ff ; $5f06
	jr nz, .loopB ; $5f08
	ret ; $5f0a
MatchFormatSlideOut:
	ld a, b ; $5f0b
	or a, a ; $5f0c
	jr z, .zero ; $5f0d
	ld c, $00 ; $5f0f
.loop:
	call AdvanceFrame ; $5f11
	ld b, $03 ; $5f14
	farcall RestoreMenuBgAndDrawPanel ; $5f16
	ld b, $00 ; $5f19
	farcall FlushWram3MapRows ; $5f1b
	ld a, c ; $5f1e
	inc a ; $5f1f
	ld c, a ; $5f20
	cp a, $0b ; $5f21
	jr nz, .loop ; $5f23
	ret ; $5f25
.zero:
	ld c, $0d ; $5f26
.loopB:
	call AdvanceFrame ; $5f28
	ld b, $02 ; $5f2b
	farcall RestoreMenuBgAndDrawPanel ; $5f2d
	ld b, $00 ; $5f30
	farcall FlushWram3MapRows ; $5f32
	ld a, c ; $5f35
	dec a ; $5f36
	ld c, a ; $5f37
	or a, a ; $5f38
	jr nz, .loopB ; $5f39
	ret ; $5f3b
HandleMatchFormatInput:
	ld a, [wMenuInputPressed] ; $5f3c
	bit PADB_LEFT, a ; $5f3f
	jr nz, .playSfx ; $5f41
	bit 4, a ; $5f43
	jr nz, .playSfx2 ; $5f45
	ret ; $5f47
.playSfx:
	sound $5e ; $5f48
	ld c, $01 ; $5f4a
	call GetMenuCursorCellIndex ; $5f4c
	or a, a ; $5f4f
	jr nz, .compare ; $5f50
	ld a, [wMatchFormatDoubles] ; $5f52
	xor a, $01 ; $5f55
	ld [wMatchFormatDoubles], a ; $5f57
	ld b, $00 ; $5f5a
	call FlushMatchFormatRowToVram ; $5f5c
	call RedrawMatchFormatModeRow ; $5f5f
	call DrawMatchFormatCaption ; $5f62
	ret ; $5f65
.compare:
	cp a, $01 ; $5f66
	jr nz, .checkMatchFormatSets ; $5f68
	ld a, [wMatchFormatGames] ; $5f6a
	xor a, $01 ; $5f6d
	ld [wMatchFormatGames], a ; $5f6f
	ld b, $01 ; $5f72
	call FlushMatchFormatRowToVram ; $5f74
	call RedrawMatchFormatGamesRow ; $5f77
	call DrawMatchFormatCaption ; $5f7a
	ret ; $5f7d
.checkMatchFormatSets:
	ld a, [wMatchFormatSets] ; $5f7e
	dec a ; $5f81
	add a, a ; $5f82
	jr nc, .noCarry ; $5f83
	ld a, $03 ; $5f85
	dec a ; $5f87
	jr .store ; $5f88
.noCarry:
	rra ; $5f8a
	cp a, $03 ; $5f8b
	jr c, .store ; $5f8d
	xor a, a ; $5f8f
.store:
	ld [wMatchFormatSets], a ; $5f90
	ld b, $02 ; $5f93
	call FlushMatchFormatRowToVram ; $5f95
	call RedrawMatchFormatSetsRow ; $5f98
	call DrawMatchFormatCaption ; $5f9b
	ret ; $5f9e
.playSfx2:
	sound $5e ; $5f9f
	ld c, $01 ; $5fa1
	call GetMenuCursorCellIndex ; $5fa3
	or a, a ; $5fa6
	jr nz, .compare2 ; $5fa7
	ld a, [wMatchFormatDoubles] ; $5fa9
	xor a, $01 ; $5fac
	ld [wMatchFormatDoubles], a ; $5fae
	ld b, $00 ; $5fb1
	call FlushMatchFormatRowToVram ; $5fb3
	call RedrawMatchFormatModeRow ; $5fb6
	call DrawMatchFormatCaption ; $5fb9
	ret ; $5fbc
.compare2:
	cp a, $01 ; $5fbd
	jr nz, .checkMatchFormatSets2 ; $5fbf
	ld a, [wMatchFormatGames] ; $5fc1
	xor a, $01 ; $5fc4
	ld [wMatchFormatGames], a ; $5fc6
	ld b, $01 ; $5fc9
	call FlushMatchFormatRowToVram ; $5fcb
	call RedrawMatchFormatGamesRow ; $5fce
	call DrawMatchFormatCaption ; $5fd1
	ret ; $5fd4
.checkMatchFormatSets2:
	ld a, [wMatchFormatSets] ; $5fd5
	inc a ; $5fd8
	add a, a ; $5fd9
	jr nc, .noCarry2 ; $5fda
	ld a, $03 ; $5fdc
	dec a ; $5fde
	jr .store2 ; $5fdf
.noCarry2:
	rra ; $5fe1
	cp a, $03 ; $5fe2
	jr c, .store2 ; $5fe4
	xor a, a ; $5fe6
.store2:
	ld [wMatchFormatSets], a ; $5fe7
	ld b, $02 ; $5fea
	call FlushMatchFormatRowToVram ; $5fec
	call RedrawMatchFormatSetsRow ; $5fef
	call DrawMatchFormatCaption ; $5ff2
	ret ; $5ff5
RedrawMatchFormatModeRow:
	ld b, $00 ; $5ff6
	ld c, $00 ; $5ff8
	call FillMatchFormatOptionCell ; $5ffa
	ld b, $01 ; $5ffd
	ld c, $00 ; $5fff
	call FillMatchFormatOptionCell ; $6001
	ld a, [wMatchFormatDoubles] ; $6004
	ld b, a ; $6007
	ld c, $01 ; $6008
	call FillMatchFormatOptionCell ; $600a
	ret ; $600d
RedrawMatchFormatGamesRow:
	ld b, $02 ; $600e
	ld c, $00 ; $6010
	call FillMatchFormatOptionCell ; $6012
	ld b, $03 ; $6015
	ld c, $00 ; $6017
	call FillMatchFormatOptionCell ; $6019
	ld a, [wMatchFormatGames] ; $601c
	add a, $02 ; $601f
	ld b, a ; $6021
	ld c, $01 ; $6022
	call FillMatchFormatOptionCell ; $6024
	ret ; $6027
RedrawMatchFormatSetsRow:
	ld b, $04 ; $6028
	ld c, $00 ; $602a
	call FillMatchFormatOptionCell ; $602c
	ld b, $05 ; $602f
	ld c, $00 ; $6031
	call FillMatchFormatOptionCell ; $6033
	ld b, $06 ; $6036
	ld c, $00 ; $6038
	call FillMatchFormatOptionCell ; $603a
	ld a, [wMatchFormatSets] ; $603d
	add a, $04 ; $6040
	ld b, a ; $6042
	ld c, $01 ; $6043
	call FillMatchFormatOptionCell ; $6045
	ret ; $6048
FillMatchFormatOptionCell:
	push af ; $6049
	push bc ; $604a
	push de ; $604b
	push hl ; $604c
	ldh a, [hWramBank] ; $604d
	push af ; $604f
	wram_bank $03 ; $6050
	ld hl, $6085 ; $6056
	ld a, b ; $6059
	add a, a ; $605a
	add a, l ; $605b
	ld l, a ; $605c
	jr nc, .readAddr ; $605d
	inc h ; $605f
.readAddr:
	ld a, [hl+] ; $6060
	ld d, [hl] ; $6061
	ld e, a ; $6062
	ld h, $0d ; $6063
	ld a, c ; $6065
	or a, a ; $6066
	jr z, .fill ; $6067
	ld a, b ; $6069
	ld hl, $6093 ; $606a
	add a, l ; $606d
	ld l, a ; $606e
	jr nc, .readWidth ; $606f
	inc h ; $6071
.readWidth:
	ld a, [hl] ; $6072
	ld h, a ; $6073
.fill:
	ld b, $05 ; $6074
	ld c, $03 ; $6076
	farcall FillTilemapRect ; $6078
	pop af ; $607b
	wram_bank ; $607c
	pop hl ; $6080
	pop de ; $6081
	pop bc ; $6082
	pop af ; $6083
	ret ; $6084
	; $6085, 14 bytes (records:2)
	dw $d463 ; record 0
	dw $d46c ; record 1
	dw $d4e3 ; record 2
	dw $d4ec ; record 3
	dw $d561 ; record 4
	dw $d567 ; record 5
	dw $d56d ; record 6
	; $6093, 7 bytes (bytes:8)
	db $0c, $0c, $0e, $0e, $0f, $0f, $0f ; 0x00
FlushMatchFormatRowToVram:
	push af ; $609a
	push bc ; $609b
	push de ; $609c
	push hl ; $609d
	ld a, b ; $609e
	or a, a ; $609f
	jr nz, .row1 ; $60a0
	ld hl, $d460 ; $60a2
	ld de, $b860 ; $60a5
	ld c, $06 ; $60a8
	call QueueVRAMCopy ; $60aa
	jr .done ; $60ad
.row1:
	cp a, $01 ; $60af
	jr nz, .row2 ; $60b1
	ld hl, $d4e0 ; $60b3
	ld de, $b8e0 ; $60b6
	ld c, $06 ; $60b9
	call QueueVRAMCopy ; $60bb
	jr .done ; $60be
.row2:
	ld hl, $d560 ; $60c0
	ld de, $b960 ; $60c3
	ld c, $06 ; $60c6
	call QueueVRAMCopy ; $60c8
.done:
	pop hl ; $60cb
	pop de ; $60cc
	pop bc ; $60cd
	pop af ; $60ce
	ret ; $60cf
MatchFormatCursorSpriteTask:
	farcall TickMenuBgScroll ; $60d0
	ld c, $01 ; $60d3
	call GetMenuCursorCellIndex ; $60d5
	or a, a ; $60d8
	jr nz, .compare ; $60d9
	ld a, [wMatchFormatDoubles] ; $60db
	jr .step ; $60de
.compare:
	cp a, $01 ; $60e0
	jr nz, .checkMatchFormatSets ; $60e2
	ld a, [wMatchFormatGames] ; $60e4
	add a, $02 ; $60e7
	jr .step ; $60e9
.checkMatchFormatSets:
	ld a, [wMatchFormatSets] ; $60eb
	add a, $04 ; $60ee
.step:
	push af ; $60f0
	ld hl, MatchFormatCursorSpriteTaskTable1 ; $60f1
	add a, l ; $60f4
	ld l, a ; $60f5
	jr nc, .read ; $60f6
	inc h ; $60f8
.read:
	ld c, [hl] ; $60f9
	pop af ; $60fa
	ld hl, MatchFormatCursorSpriteTaskTable0 ; $60fb
	add a, a ; $60fe
	add a, l ; $60ff
	ld l, a ; $6100
	jr nc, .readB ; $6101
	inc h ; $6103
.readB:
	ld a, [hl+] ; $6104
	ld d, [hl] ; $6105
	ld e, a ; $6106
	farcall ApplySpriteBobOffset ; $6107
	ld b, $08 ; $610a
	ld hl, SpriteTemplate_3b_6125 ; $610c
	push de ; $610f
	call QueueSpriteTemplate ; $6110
	pop de ; $6113
	ld hl, $17f8 ; $6114
	add hl, de ; $6117
	ld d, h ; $6118
	ld e, l ; $6119
	ld hl, SpriteTemplate_3b_6146 ; $611a
	ld b, $08 ; $611d
	ld c, $70 ; $611f
	call QueueSpriteTemplate ; $6121
	ret ; $6124
SpriteTemplate_3b_6125:
	; $6125, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
SpriteTemplate_3b_6146:
	; $6146, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
MatchFormatCursorSpriteTaskTable0:
	; $614f, 14 bytes (bytes:14)
	db $2d, $0a, $2d, $54, $4f, $0c, $4f, $54, $6a, $00, $6a, $2c, $6a, $5d ; 0x00
MatchFormatCursorSpriteTaskTable1:
	; $615d, 7 bytes (bytes:7)
	db $00, $10, $20, $30, $40, $50, $60 ; 0x00
DrawMatchFormatCaption:
	wram_bank $03 ; $6164
	ld de, $d1e0 ; $616a
	ld b, $14 ; $616d
	ld c, $01 ; $616f
	ld h, $03 ; $6171
	farcall FillTilemapRect ; $6173
	ld a, $02 ; $6176
	ld [$d1e0], a ; $6178
	ld a, $04 ; $617b
	ld [$d1f3], a ; $617d
	ld de, $d201 ; $6180
	ld b, $12 ; $6183
	ld c, $01 ; $6185
	ld h, $20 ; $6187
	farcall FillTilemapRect ; $6189
	call RenderMatchFormatOptionText ; $618c
	ld hl, $d1e0 ; $618f
	ld de, $99e0 ; $6192
	ld c, $04 ; $6195
	call QueueVRAMCopy ; $6197
	ret ; $619a
RenderMatchFormatOptionText:
	wram_bank $03 ; $619b
	ld c, $01 ; $61a1
	call GetMenuCursorCellIndex ; $61a3
	or a, a ; $61a6
	jr nz, .compare ; $61a7
	ld a, [wMatchFormatDoubles] ; $61a9
	ld hl, $0087 ; $61ac
	add a, l ; $61af
	ld l, a ; $61b0
	jr nc, .renderTextToBuffer64 ; $61b1
	inc h ; $61b3
.renderTextToBuffer64:
	ld de, $d201 ; $61b4
	ld c, $20 ; $61b7
	farcall RenderTextToBuffer64 ; $61b9
	ret ; $61bc
.compare:
	cp a, $01 ; $61bd
	jr nz, .checkMatchFormatSets ; $61bf
	ld a, [wMatchFormatGames] ; $61c1
	ld hl, $0089 ; $61c4
	add a, l ; $61c7
	ld l, a ; $61c8
	jr nc, .renderTextToBuffer642 ; $61c9
	inc h ; $61cb
.renderTextToBuffer642:
	ld de, $d201 ; $61cc
	ld c, $20 ; $61cf
	farcall RenderTextToBuffer64 ; $61d1
	ret ; $61d4
.checkMatchFormatSets:
	ld a, [wMatchFormatSets] ; $61d5
	ld hl, $008b ; $61d8
	add a, l ; $61db
	ld l, a ; $61dc
	jr nc, .renderTextToBuffer643 ; $61dd
	inc h ; $61df
.renderTextToBuffer643:
	ld de, $d201 ; $61e0
	ld c, $20 ; $61e3
	farcall RenderTextToBuffer64 ; $61e5
	ret ; $61e8
	ret ; $61e9
	; $61ea, 6 bytes (records:2)
	dw $d201 ; record 0
	dw $d201 ; record 1
	dw $d201 ; record 2
RunMinigameSelect:
	ld hl, rIE ; $61f0
	res 2, [hl] ; $61f3
	sound $08 ; $61f5
	xor a, a ; $61f7
	ld [$cb70], a ; $61f8
	call BuildStarCharUnlockMask ; $61fb
	call LoadMinigameSelectGfx ; $61fe
	wram_bank $03 ; $6201
	call CheckMinigameGridExpanded ; $6207
	or a, a ; $620a
	jr nz, .checkMenuSlideDirection ; $620b
	ld a, [wMenuSlideDirection] ; $620d
	ld b, a ; $6210
	call MinigameSelectSlideIn6 ; $6211
	jr .initMenuBgScroll ; $6214
.checkMenuSlideDirection:
	ld a, [wMenuSlideDirection] ; $6216
	ld b, a ; $6219
	call MinigameSelectSlideIn9 ; $621a
.initMenuBgScroll:
	farcall InitMenuBgScroll ; $621d
	ld b, $01 ; $6220
	ld c, $01 ; $6222
	farcall LoadMenuSpritePalettePair ; $6224
	ld a, [$cb20] ; $6227
	ld c, a ; $622a
	ld b, $03 ; $622b
	call SetMenuCursorFromCellIndex ; $622d
	ld a, $01 ; $6230
	ld hl, MinigameSelectCursorSpriteTask ; $6232
	call RegisterFrameTask ; $6235
	call DrawMinigameSelectCaption ; $6238
	call CheckMinigameGridExpanded ; $623b
	or a, a ; $623e
	jr nz, .drawMinigameSelectGrid9 ; $623f
	call DrawMinigameSelectGrid6 ; $6241
	jr .storeMenuInputPressed ; $6244
.drawMinigameSelectGrid9:
	call DrawMinigameSelectGrid9 ; $6246
.storeMenuInputPressed:
	wram_bank $03 ; $6249
.loop:
	ldh a, [hInputPressed] ; $624f
	ld [wMenuInputPressed], a ; $6251
	call CheckMinigameGridExpanded ; $6254
	or a, a ; $6257
	jr nz, .nonZero ; $6258
	farcall MoveMinigameGridCursor ; $625a
	or a, a ; $625d
	jr z, .advanceFrame ; $625e
	sound $5e ; $6260
	call DrawMinigameSelectCaption ; $6262
	call DrawMinigameSelectGrid6 ; $6265
	jr .advanceFrame ; $6268
.nonZero:
	ld b, $03 ; $626a
	ld c, $03 ; $626c
	call MoveMenuCursor ; $626e
	or a, a ; $6271
	jr z, .advanceFrame ; $6272
	sound $5e ; $6274
	call DrawMinigameSelectCaption ; $6276
	call DrawMinigameSelectGrid9 ; $6279
.advanceFrame:
	call AdvanceFrame ; $627c
	ld a, [wMenuInputPressed] ; $627f
	bit PADB_A, a ; $6282
	jr nz, .getMenuCursorCellIndex ; $6284
	bit 1, a ; $6286
	jr nz, .playSfx2 ; $6288
	jr .loop ; $628a
.getMenuCursorCellIndex:
	ld c, $03 ; $628c
	call GetMenuCursorCellIndex ; $628e
	ld c, a ; $6291
	call GetUnlockedStarCharAtGridSlot ; $6292
	cp a, $15 ; $6295
	jr nz, .playSfx ; $6297
	sound $61 ; $6299
	jr .loop ; $629b
.playSfx:
	sound $5f ; $629d
	call ClearFrameTasks ; $629f
	ld hl, rIE ; $62a2
	set 2, [hl] ; $62a5
	call CheckMinigameGridExpanded ; $62a7
	or a, a ; $62aa
	jr nz, .nonZero2 ; $62ab
	ld b, $01 ; $62ad
	call MinigameSelectSlideOut6 ; $62af
	jr .storeMenuSlideDirection ; $62b2
.nonZero2:
	ld b, $01 ; $62b4
	call MinigameSelectSlideOut9 ; $62b6
.storeMenuSlideDirection:
	ld a, $01 ; $62b9
	ld [wMenuSlideDirection], a ; $62bb
	xor a, a ; $62be
	ld [$cb70], a ; $62bf
	ld c, $03 ; $62c2
	call GetMenuCursorCellIndex ; $62c4
	ld [$cb20], a ; $62c7
	ret ; $62ca
.playSfx2:
	sound $62 ; $62cb
	call ClearFrameTasks ; $62cd
	ld hl, rIE ; $62d0
	set 2, [hl] ; $62d3
	call CheckMinigameGridExpanded ; $62d5
	or a, a ; $62d8
	jr nz, .nonZero3 ; $62d9
	ld b, $00 ; $62db
	call MinigameSelectSlideOut6 ; $62dd
	jr .storeMenuSlideDirection2 ; $62e0
.nonZero3:
	ld b, $00 ; $62e2
	call MinigameSelectSlideOut9 ; $62e4
.storeMenuSlideDirection2:
	ld a, $00 ; $62e7
	ld [wMenuSlideDirection], a ; $62e9
	ld a, $ff ; $62ec
	ret ; $62ee
LoadMinigameSelectGfx:
	ldh a, [hWramBank] ; $62ef
	push af ; $62f1
	wram_bank $01 ; $62f2
	ld c, $00 ; $62f8
.loop:
	push bc ; $62fa
	call GetUnlockedStarCharAtGridSlot ; $62fb
	ld b, a ; $62fe
	ld de, $d000 ; $62ff
	farcall DecompressCharacterPortrait ; $6302
	pop bc ; $6305
	push bc ; $6306
	ld a, c ; $6307
	add a, a ; $6308
	ld hl, $63f6 ; $6309
	add a, l ; $630c
	ld l, a ; $630d
	jr nc, .read ; $630e
	inc h ; $6310
.read:
	ld a, [hl+] ; $6311
	ld d, [hl] ; $6312
	ld e, a ; $6313
	ld hl, $d000 ; $6314
	ld c, $09 ; $6317
	call QueueVRAMCopy ; $6319
	pop bc ; $631c
	call AdvanceFrame ; $631d
	ld a, c ; $6320
	inc a ; $6321
	ld c, a ; $6322
	cp a, $09 ; $6323
	jr nz, .loop ; $6325
	ld b, $33 ; $6327
	ld c, $10 ; $6329
	ld de, $a000 ; $632b
	farcall LoadCompressedTileBlock ; $632e
	call AdvanceFrame ; $6331
	ld b, $34 ; $6334
	ld c, $10 ; $6336
	ld de, $a100 ; $6338
	farcall LoadCompressedTileBlock ; $633b
	call AdvanceFrame ; $633e
	ld b, $35 ; $6341
	ld c, $10 ; $6343
	ld de, $a200 ; $6345
	farcall LoadCompressedTileBlock ; $6348
	call AdvanceFrame ; $634b
	ld b, $36 ; $634e
	ld c, $10 ; $6350
	ld de, $a300 ; $6352
	farcall LoadCompressedTileBlock ; $6355
	call AdvanceFrame ; $6358
	ld b, $37 ; $635b
	ld c, $10 ; $635d
	ld de, $a400 ; $635f
	farcall LoadCompressedTileBlock ; $6362
	call AdvanceFrame ; $6365
	ld b, $38 ; $6368
	ld c, $10 ; $636a
	ld de, $a500 ; $636c
	farcall LoadCompressedTileBlock ; $636f
	call AdvanceFrame ; $6372
	ld hl, $6d7e ; $6375 -> DataPtr_MinigameSelectIconGfx0
	ld de, $d000 ; $6378
	call DecompressDataFromBank ; $637b
	ld hl, $d000 ; $637e
	ld de, $8200 ; $6381
	ld c, $10 ; $6384
	call QueueVRAMCopy ; $6386
	ld hl, $6d80 ; $6389 -> DataPtr_MinigameSelectIconGfx1
	ld de, $d400 ; $638c
	call DecompressDataFromBank ; $638f
	ld hl, $d400 ; $6392
	ld de, $8300 ; $6395
	ld c, $10 ; $6398
	call QueueVRAMCopy ; $639a
	call AdvanceFrame ; $639d
	ld hl, $6d82 ; $63a0 -> DataPtr_MinigameSelectIconGfx2
	ld de, $d000 ; $63a3
	call DecompressDataFromBank ; $63a6
	ld hl, $d000 ; $63a9
	ld de, $8400 ; $63ac
	ld c, $10 ; $63af
	call QueueVRAMCopy ; $63b1
	call AdvanceFrame ; $63b4
	ld b, $6f ; $63b7
	ld c, $12 ; $63b9
	ld de, $8500 ; $63bb
	farcall LoadCompressedTileBlock ; $63be
	call AdvanceFrame ; $63c1
	ld b, $47 ; $63c4
	ld c, $14 ; $63c6
	ld de, $8000 ; $63c8
	farcall LoadCompressedTileBlock ; $63cb
	call AdvanceFrame ; $63ce
	ld b, $1b ; $63d1
	ld c, $04 ; $63d3
	ld de, $a700 ; $63d5
	farcall LoadCompressedTileBlock ; $63d8
	ld b, $08 ; $63db
	ld c, $10 ; $63dd
	farcall LoadIndexedPalette ; $63df
	pop af ; $63e2
	wram_bank ; $63e3
	ret ; $63e7
	; $63e8, 34 bytes (bytes:2)
	db $62, $3c ; 0x00
	db $64, $3c ; 0x02
	db $66, $3c ; 0x04
	db $68, $3c ; 0x06
	db $6a, $3c ; 0x08
	db $6c, $3c ; 0x0a
	db $6e, $3c ; 0x0c
	db $80, $b6 ; 0x0e
	db $10, $b7 ; 0x10
	db $00, $af ; 0x12
	db $00, $a8 ; 0x14
	db $00, $a9 ; 0x16
	db $00, $aa ; 0x18
	db $00, $ab ; 0x1a
	db $00, $ac ; 0x1c
	db $00, $ad ; 0x1e
	db $00, $ae ; 0x20
MinigameSelectSlideIn9:
	ld a, b ; $640a
	or a, a ; $640b
	jr z, .zero ; $640c
	ld c, $00 ; $640e
.loop:
	call AdvanceFrame ; $6410
	ld b, $04 ; $6413
	farcall RestoreMenuBgAndDrawPanel ; $6415
	ld b, $00 ; $6418
	farcall FlushWram3MapRows ; $641a
	ld a, c ; $641d
	inc a ; $641e
	ld c, a ; $641f
	cp a, $0e ; $6420
	jr nz, .loop ; $6422
	ret ; $6424
.zero:
	ld c, $0c ; $6425
.loopB:
	call AdvanceFrame ; $6427
	ld b, $05 ; $642a
	farcall RestoreMenuBgAndDrawPanel ; $642c
	ld b, $00 ; $642f
	farcall FlushWram3MapRows ; $6431
	ld a, c ; $6434
	dec a ; $6435
	ld c, a ; $6436
	cp a, $ff ; $6437
	jr nz, .loopB ; $6439
	ret ; $643b
MinigameSelectSlideOut9:
	ld a, b ; $643c
	or a, a ; $643d
	jr z, .zero ; $643e
	ld c, $00 ; $6440
.loop:
	call AdvanceFrame ; $6442
	ld b, $05 ; $6445
	farcall RestoreMenuBgAndDrawPanel ; $6447
	ld b, $00 ; $644a
	farcall FlushWram3MapRows ; $644c
	ld a, c ; $644f
	inc a ; $6450
	ld c, a ; $6451
	cp a, $0b ; $6452
	jr nz, .loop ; $6454
	ret ; $6456
.zero:
	ld c, $0d ; $6457
.loopB:
	call AdvanceFrame ; $6459
	ld b, $04 ; $645c
	farcall RestoreMenuBgAndDrawPanel ; $645e
	ld b, $00 ; $6461
	farcall FlushWram3MapRows ; $6463
	ld a, c ; $6466
	dec a ; $6467
	ld c, a ; $6468
	or a, a ; $6469
	jr nz, .loopB ; $646a
	ret ; $646c
MinigameSelectCursorSpriteTask:
	farcall TickMenuBgScroll ; $646d
	ld c, $03 ; $6470
	call GetMenuCursorCellIndex ; $6472
	push af ; $6475
	ld hl, MinigameSelectCursorSpriteTaskTable1 ; $6476
	add a, l ; $6479
	ld l, a ; $647a
	jr nc, .read ; $647b
	inc h ; $647d
.read:
	ld c, [hl] ; $647e
	pop af ; $647f
	push af ; $6480
	call GetMinigameCursorPosTable ; $6481
	add a, a ; $6484
	add a, l ; $6485
	ld l, a ; $6486
	jr nc, .readB ; $6487
	inc h ; $6489
.readB:
	ld a, [hl+] ; $648a
	ld d, [hl] ; $648b
	ld e, a ; $648c
	farcall ApplySpriteBobOffset ; $648d
	pop af ; $6490
	ld hl, MinigameSelectCursorSpriteTaskTable0 ; $6491
	add a, l ; $6494
	ld l, a ; $6495
	jr nc, .read2 ; $6496
	inc h ; $6498
.read2:
	ld b, [hl] ; $6499
	call OverrideMinigameCursorIfLocked ; $649a
	ld hl, SpriteTemplate_3b_64ca ; $649d
	push de ; $64a0
	call QueueSpriteTemplate ; $64a1
	pop de ; $64a4
	ld hl, $17f8 ; $64a5
	add hl, de ; $64a8
	ld d, h ; $64a9
	ld e, l ; $64aa
	ld hl, SpriteTemplate_3b_64eb ; $64ab
	ld b, $08 ; $64ae
	ld c, $70 ; $64b0
	call QueueSpriteTemplate ; $64b2
	ret ; $64b5
GetMinigameCursorPosTable:
	push de ; $64b6
	push bc ; $64b7
	push af ; $64b8
	call CheckMinigameGridExpanded ; $64b9
	jr nz, .altTable ; $64bc
	ld hl, MinigameCursorPosTable1 ; $64be
	jr .done ; $64c1
.altTable:
	ld hl, MinigameCursorPosTable0 ; $64c3
.done:
	pop af ; $64c6
	pop bc ; $64c7
	pop de ; $64c8
	ret ; $64c9
SpriteTemplate_3b_64ca:
	; $64ca, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
SpriteTemplate_3b_64eb:
	; $64eb, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
MinigameSelectCursorSpriteTaskTable0:
	; $64f4, 9 bytes (bytes:9)
	db $08, $00, $08, $00, $08, $00, $08, $08, $08 ; 0x00
MinigameCursorPosTable0:
	; $64fd, 18 bytes (bytes:16)
	db $30, $fc, $30, $2c, $30, $5c, $50, $fc, $50, $2c, $50, $5e, $6c, $fc, $6c, $2c ; 0x00
	db $6c, $5e ; 0x10
MinigameCursorPosTable1:
	; $650f, 12 bytes (bytes:12)
	db $38, $fc, $38, $2c, $38, $5c, $60, $14, $60, $44, $60, $44 ; 0x00
MinigameSelectCursorSpriteTaskTable1:
	; $651b, 50 bytes (bytes:16)
	db $00, $30, $50, $40, $20, $20, $40, $10, $30, $10, $08, $00, $00, $10, $10, $02 ; 0x00
	db $00, $10, $18, $04, $00, $10, $20, $06, $00, $10, $28, $08, $00, $10, $30, $0a ; 0x10
	db $00, $10, $38, $0c, $00, $10, $40, $0e, $00, $10, $48, $10, $00, $10, $50, $12 ; 0x20
	db $00, $80 ; 0x30
OverrideMinigameCursorIfLocked:
	push bc ; $654d
	push hl ; $654e
	push de ; $654f
	ld c, $03 ; $6550
	call GetMenuCursorCellIndex ; $6552
	ld c, a ; $6555
	call GetUnlockedStarCharAtGridSlot ; $6556
	cp a, $15 ; $6559
	jr z, .eq15 ; $655b
	pop de ; $655d
	pop hl ; $655e
	pop bc ; $655f
	ret ; $6560
.eq15:
	ld c, $50 ; $6561
	ld b, $00 ; $6563
	pop de ; $6565
	pop hl ; $6566
	pop af ; $6567
	ret ; $6568
DrawMinigameSelectCaption:
	wram_bank $03 ; $6569
	ld de, $d1e0 ; $656f
	ld b, $14 ; $6572
	ld c, $01 ; $6574
	ld h, $03 ; $6576
	farcall FillTilemapRect ; $6578
	ld a, $02 ; $657b
	ld [$d1e0], a ; $657d
	ld a, $04 ; $6580
	ld [$d1f3], a ; $6582
	ld de, $d201 ; $6585
	ld b, $12 ; $6588
	ld c, $01 ; $658a
	ld h, $20 ; $658c
	farcall FillTilemapRect ; $658e
	call RenderMinigameNameText ; $6591
	ld hl, $d1e0 ; $6594
	ld de, $99e0 ; $6597
	ld c, $04 ; $659a
	call QueueVRAMCopy ; $659c
	ret ; $659f
RenderMinigameNameText:
	wram_bank $03 ; $65a0
	ld c, $03 ; $65a6
	call GetMenuCursorCellIndex ; $65a8
	push af ; $65ab
	ld c, a ; $65ac
	call GetUnlockedStarCharAtGridSlot ; $65ad
	cp a, $15 ; $65b0
	jr nz, .restore ; $65b2
	pop af ; $65b4
	ld hl, $00bb ; $65b5
	ld de, $d201 ; $65b8
	jr .renderTextToBuffer64 ; $65bb
.restore:
	pop af ; $65bd
	ld b, a ; $65be
	add a, a ; $65bf
	ld hl, $65da ; $65c0
	add a, l ; $65c3
	ld l, a ; $65c4
	jr nc, .read ; $65c5
	inc h ; $65c7
.read:
	ld a, [hl+] ; $65c8
	ld d, [hl] ; $65c9
	ld e, a ; $65ca
	ld a, b ; $65cb
	ld hl, $00b2 ; $65cc
	add a, l ; $65cf
	ld l, a ; $65d0
	jr nc, .renderTextToBuffer64 ; $65d1
	inc h ; $65d3
.renderTextToBuffer64:
	ld c, $20 ; $65d4
	farcall RenderTextToBuffer64 ; $65d6
	ret ; $65d9
	; $65da, 18 bytes (records:2)
	dw $d201 ; record 0
	dw $d201 ; record 1
	dw $d201 ; record 2
	dw $d201 ; record 3
	dw $d201 ; record 4
	dw $d201 ; record 5
	dw $d201 ; record 6
	dw $d201 ; record 7
	dw $d201 ; record 8
DrawMinigameSelectGrid9:
	wram_bank $03 ; $65ec
	ld b, $00 ; $65f2
	ld c, $00 ; $65f4
.loop:
	call FillMinigameSelectCell ; $65f6
	ld a, b ; $65f9
	inc a ; $65fa
	ld b, a ; $65fb
	cp a, $09 ; $65fc
	jr nz, .loop ; $65fe
	ld c, $03 ; $6600
	call GetMenuCursorCellIndex ; $6602
	ld b, a ; $6605
	ld c, $01 ; $6606
	call FillMinigameSelectCell ; $6608
	ld c, $03 ; $660b
	call GetMenuCursorCellIndex ; $660d
	call LoadMinigameCharPalette ; $6610
	ld hl, $d460 ; $6613
	ld de, $b860 ; $6616
	ld c, $06 ; $6619
	call QueueVRAMCopy ; $661b
	ld hl, $d4e0 ; $661e
	ld de, $b8e0 ; $6621
	ld c, $06 ; $6624
	call QueueVRAMCopy ; $6626
	ld hl, $d560 ; $6629
	ld de, $b960 ; $662c
	ld c, $06 ; $662f
	call QueueVRAMCopy ; $6631
	ret ; $6634
FillMinigameSelectCell:
	push af ; $6635
	push bc ; $6636
	push de ; $6637
	push hl ; $6638
	ld d, c ; $6639
	ld e, b ; $663a
	ld b, $03 ; $663b
	ld c, $03 ; $663d
	ld a, d ; $663f
	or a, a ; $6640
	jr z, .zero ; $6641
	ld h, $0c ; $6643
	jr .step2 ; $6645
.zero:
	ld h, $0d ; $6647
.step2:
	push hl ; $6649
	ld hl, $6660 ; $664a
	ld a, e ; $664d
	add a, a ; $664e
	add a, l ; $664f
	ld l, a ; $6650
	jr nc, .read ; $6651
	inc h ; $6653
.read:
	ld a, [hl+] ; $6654
	ld d, [hl] ; $6655
	ld e, a ; $6656
	pop hl ; $6657
	farcall FillTilemapRect ; $6658
	pop hl ; $665b
	pop de ; $665c
	pop bc ; $665d
	pop af ; $665e
	ret ; $665f
	; $6660, 18 bytes (records:2)
	dw $d462 ; record 0
	dw $d468 ; record 1
	dw $d46e ; record 2
	dw $d4e2 ; record 3
	dw $d4e8 ; record 4
	dw $d4ee ; record 5
	dw $d562 ; record 6
	dw $d568 ; record 7
	dw $d56e ; record 8
LoadMinigameCharPalette:
	ld c, a ; $6672
	call GetStarCharAtGridSlot ; $6673
	farcall GetCharPaletteIndex ; $6676
	ld d, $04 ; $6679
	farcall LoadIndexedPalette_18 ; $667b
	ret ; $667e
BuildStarCharUnlockMask:
	ld c, $00 ; $667f
	ld b, $00 ; $6681
.loop:
	ld a, c ; $6683
	add a, a ; $6684
	ld hl, $66a9 ; $6685
	add a, l ; $6688
	ld l, a ; $6689
	jr nc, .read ; $668a
	inc h ; $668c
.read:
	ld a, [hl+] ; $668d
	ld d, [hl] ; $668e
	ld e, a ; $668f
	farcall TestSaveFlag ; $6690
	jr z, .countDone ; $6693
	ld a, $01 ; $6695
	or a, b ; $6697
	ld b, a ; $6698
.countDone:
	ld a, c ; $6699
	inc a ; $669a
	ld c, a ; $669b
	cp a, $06 ; $669c
	jr z, .eq06 ; $669e
	sla b ; $66a0
	jr .loop ; $66a2
.eq06:
	ld a, b ; $66a4
	ld [$cb5d], a ; $66a5
	ret ; $66a8
	; $66a9, 12 bytes (records:2)
	dw $01e0 ; record 0
	dw $01a0 ; record 1
	dw $0180 ; record 2
	dw $0160 ; record 3
	dw $0140 ; record 4
	dw $01c0 ; record 5
GetUnlockedStarCharAtGridSlot:
	call GetStarCharAtGridSlot ; $66b5
	cp a, $17 ; $66b8
	ret z ; $66ba
	cp a, $19 ; $66bb
	ret z ; $66bd
	cp a, $18 ; $66be
	ret z ; $66c0
	ld d, a ; $66c1
	sub a, $1a ; $66c2
	ld hl, $66d8 ; $66c4
	add a, l ; $66c7
	ld l, a ; $66c8
	jr nc, .readMask ; $66c9
	inc h ; $66cb
.readMask:
	ld b, [hl] ; $66cc
	ld a, [$cb5d] ; $66cd
	and a, b ; $66d0
	jr nz, .unlocked ; $66d1
	ld a, $15 ; $66d3
	ret ; $66d5
.unlocked:
	ld a, d ; $66d6
	ret ; $66d7
	; $66d8, 6 bytes (bytes:8)
	db $01, $02, $04, $08, $10, $20 ; 0x00
GetStarCharAtGridSlot:
	ld hl, $66e9 ; $66de
	ld a, c ; $66e1
	add a, l ; $66e2
	ld l, a ; $66e3
	jr nc, .read ; $66e4
	inc h ; $66e6
.read:
	ld a, [hl] ; $66e7
	ret ; $66e8
	; $66e9, 9 bytes (bytes:3)
	db $1a, $17, $1f ; 0x00
	db $19, $1c, $18 ; 0x03
	db $1e, $1b, $1d ; 0x06
CheckMinigameGridExpanded:
	ld c, $06 ; $66f2
	call GetUnlockedStarCharAtGridSlot ; $66f4
	cp a, $15 ; $66f7
	jr nz, .expanded ; $66f9
	xor a, a ; $66fb
	ret ; $66fc
.expanded:
	ld a, $01 ; $66fd
	ret ; $66ff
MinigameSelectSlideIn6:
	ld a, b ; $6700
	or a, a ; $6701
	jr z, .zero ; $6702
	ld c, $00 ; $6704
.loop:
	call AdvanceFrame ; $6706
	ld b, $16 ; $6709
	farcall RestoreMenuBgAndDrawPanel ; $670b
	ld b, $02 ; $670e
	farcall FlushWram3MapRows ; $6710
	ld a, c ; $6713
	inc a ; $6714
	ld c, a ; $6715
	cp a, $0e ; $6716
	jr nz, .loop ; $6718
	ret ; $671a
.zero:
	ld c, $0c ; $671b
.loopB:
	call AdvanceFrame ; $671d
	ld b, $17 ; $6720
	farcall RestoreMenuBgAndDrawPanel ; $6722
	ld b, $02 ; $6725
	farcall FlushWram3MapRows ; $6727
	ld a, c ; $672a
	dec a ; $672b
	ld c, a ; $672c
	cp a, $ff ; $672d
	jr nz, .loopB ; $672f
	ret ; $6731
MinigameSelectSlideOut6:
	ld a, b ; $6732
	or a, a ; $6733
	jr z, .zero ; $6734
	ld c, $00 ; $6736
.loop:
	call AdvanceFrame ; $6738
	ld b, $17 ; $673b
	farcall RestoreMenuBgAndDrawPanel ; $673d
	ld b, $02 ; $6740
	farcall FlushWram3MapRows ; $6742
	ld a, c ; $6745
	inc a ; $6746
	ld c, a ; $6747
	cp a, $0b ; $6748
	jr nz, .loop ; $674a
	ret ; $674c
.zero:
	ld c, $0d ; $674d
.loopB:
	call AdvanceFrame ; $674f
	ld b, $16 ; $6752
	farcall RestoreMenuBgAndDrawPanel ; $6754
	ld b, $02 ; $6757
	farcall FlushWram3MapRows ; $6759
	ld a, c ; $675c
	dec a ; $675d
	ld c, a ; $675e
	or a, a ; $675f
	jr nz, .loopB ; $6760
	ret ; $6762
DrawMinigameSelectGrid6:
	wram_bank $03 ; $6763
	ld b, $00 ; $6769
	ld c, $00 ; $676b
.loop:
	farcall FillMenuGridCellTile ; $676d
	ld a, b ; $6770
	inc a ; $6771
	ld b, a ; $6772
	cp a, $06 ; $6773
	jr nz, .loop ; $6775
	ld c, $03 ; $6777
	call GetMenuCursorCellIndex ; $6779
	ld b, a ; $677c
	ld c, $01 ; $677d
	farcall FillMenuGridCellTile ; $677f
	ld c, $03 ; $6782
	call GetMenuCursorCellIndex ; $6784
	call LoadMinigameCharPalette ; $6787
	ld hl, $d480 ; $678a
	ld de, $b880 ; $678d
	ld c, $06 ; $6790
	call QueueVRAMCopy ; $6792
	ld hl, $d520 ; $6795
	ld de, $b920 ; $6798
	ld c, $06 ; $679b
	call QueueVRAMCopy ; $679d
	ret ; $67a0
RunSavedDataSourceSelect:
	sound $03 ; $67a1
	ld hl, rIE ; $67a3
	res 2, [hl] ; $67a6
	call BuildSaveSlotSummaries ; $67a8
	call LoadSavedDataSourceGfx ; $67ab
	farcall InitMenuBgScroll ; $67ae
	ld b, $01 ; $67b1
	ld c, $01 ; $67b3
	farcall LoadMenuSpritePalettePair ; $67b5
	call LoadN64RecordsToWram2 ; $67b8
	wram_bank $03 ; $67bb
	ld a, [wMenuSlideDirection] ; $67c1
	ld b, a ; $67c4
	farcall SavedDataPickerSlideIn ; $67c5
	ld a, [$cb1c] ; $67c8
	ld c, a ; $67cb
	ld b, $03 ; $67cc
	call SetMenuCursorFromCellIndex ; $67ce
	ld a, $01 ; $67d1
	ld hl, SavedDataSourceCursorSpriteTask ; $67d3
	call RegisterFrameTask ; $67d6
	call DrawSavedDataSourceGrid ; $67d9
	wram_bank $03 ; $67dc
.loop:
	call AdvanceFrame ; $67e2
	ldh a, [hInputPressed] ; $67e5
	ld [wMenuInputPressed], a ; $67e7
	farcall MoveSavedDataPickerCursor ; $67ea
	or a, a ; $67ed
	jr z, .checkMenuInputPressed ; $67ee
	sound $5e ; $67f0
	call DrawSavedDataSourceGrid ; $67f2
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $67f5
	bit PADB_A, a ; $67f8
	jr nz, .getMenuCursorCellIndex ; $67fa
	bit 1, a ; $67fc
	jr nz, .playSfx3 ; $67fe
	jr .loop ; $6800
.getMenuCursorCellIndex:
	ld c, $03 ; $6802
	call GetMenuCursorCellIndex ; $6804
	cp a, $04 ; $6807
	jr nz, .ne04 ; $6809
	call CheckN64DataPresent ; $680b
	or a, a ; $680e
	jr nz, .playSfx2 ; $680f
	sound $61 ; $6811
	jr .loop ; $6813
.ne04:
	ld c, $03 ; $6815
	call GetMenuCursorCellIndex ; $6817
	cp a, $03 ; $681a
	jp nc, .playSfx2 ; $681c
	add a, a ; $681f
	add a, a ; $6820
	add a, a ; $6821
	add a, a ; $6822
	ld bc, $d300 ; $6823
	add a, c ; $6826
	ld c, a ; $6827
	jr nc, .gotPtr ; $6828
	inc b ; $682a
.gotPtr:
	ld hl, $0000 ; $682b
	add hl, bc ; $682e
	ld a, [hl] ; $682f
	cp a, $3f ; $6830
	jr z, .playSfx ; $6832
	jr .playSfx2 ; $6834
.playSfx:
	sound $61 ; $6836
	jr .loop ; $6838
.playSfx2:
	sound $5f ; $683a
	call ClearFrameTasks ; $683c
	ld hl, rIE ; $683f
	set 2, [hl] ; $6842
	ld b, $01 ; $6844
	farcall SavedDataPickerSlideOut ; $6846
	ld a, $01 ; $6849
	ld [wMenuSlideDirection], a ; $684b
	ld c, $03 ; $684e
	call GetMenuCursorCellIndex ; $6850
	ld [$cb1c], a ; $6853
	ret ; $6856
.playSfx3:
	sound $62 ; $6857
	call ClearFrameTasks ; $6859
	ld hl, rIE ; $685c
	set 2, [hl] ; $685f
	ld b, $00 ; $6861
	farcall SavedDataPickerSlideOut ; $6863
	ld a, $00 ; $6866
	ld [wMenuSlideDirection], a ; $6868
	ld a, $ff ; $686b
	ret ; $686d
LoadSavedDataSourceGfx:
	ldh a, [hWramBank] ; $686e
	push af ; $6870
	wram_bank $01 ; $6871
	ld hl, $3c14 ; $6877 -> DataPtr_ModeSelectLabelTiles1
	ld de, $d000 ; $687a
	call DecompressDataFromBank ; $687d
	ld hl, $d000 ; $6880
	ld de, $a800 ; $6883
	ld bc, $0010 ; $6886
	call QueueVRAMCopy ; $6889
	call AdvanceFrame ; $688c
	ld hl, $3c20 ; $688f -> DataPtr_3c_20
	ld de, $d000 ; $6892
	call DecompressDataFromBank ; $6895
	ld hl, $d000 ; $6898
	ld de, $a900 ; $689b
	ld bc, $0010 ; $689e
	call QueueVRAMCopy ; $68a1
	call AdvanceFrame ; $68a4
	wram_bank $03 ; $68a7
	ld a, $00 ; $68ad
	ld [wCurrentStorySlot], a ; $68af
	ld a, [$d300] ; $68b2
	farcall LoadCharMugshotToBuffer ; $68b5
	ld de, $b680 ; $68b8
	farcall CopyMugshotBufferToVram ; $68bb
	call AdvanceFrame ; $68be
	wram_bank $03 ; $68c1
	ld a, $01 ; $68c7
	ld [wCurrentStorySlot], a ; $68c9
	ld a, [$d310] ; $68cc
	farcall LoadCharMugshotToBuffer ; $68cf
	ld de, $b710 ; $68d2
	farcall CopyMugshotBufferToVram ; $68d5
	call AdvanceFrame ; $68d8
	wram_bank $03 ; $68db
	ld a, $02 ; $68e1
	ld [wCurrentStorySlot], a ; $68e3
	ld a, [$d320] ; $68e6
	farcall LoadCharMugshotToBuffer ; $68e9
	ld de, $af00 ; $68ec
	farcall CopyMugshotBufferToVram ; $68ef
	call AdvanceFrame ; $68f2
	ld b, $2a ; $68f5
	ld c, $10 ; $68f7
	ld de, $a000 ; $68f9
	farcall LoadCompressedTileBlock ; $68fc
	call AdvanceFrame ; $68ff
	ld b, $2b ; $6902
	ld c, $10 ; $6904
	ld de, $a100 ; $6906
	farcall LoadCompressedTileBlock ; $6909
	call AdvanceFrame ; $690c
	ld b, $2c ; $690f
	ld c, $10 ; $6911
	ld de, $a200 ; $6913
	farcall LoadCompressedTileBlock ; $6916
	call AdvanceFrame ; $6919
	ld b, $2d ; $691c
	ld c, $10 ; $691e
	ld de, $a300 ; $6920
	farcall LoadCompressedTileBlock ; $6923
	call AdvanceFrame ; $6926
	ld b, $76 ; $6929
	ld c, $10 ; $692b
	ld de, $a400 ; $692d
	farcall LoadCompressedTileBlock ; $6930
	call AdvanceFrame ; $6933
	ld b, $1b ; $6936
	ld c, $04 ; $6938
	ld de, $a700 ; $693a
	farcall LoadCompressedTileBlock ; $693d
	call AdvanceFrame ; $6940
	ld b, $42 ; $6943
	ld c, $14 ; $6945
	ld de, $8000 ; $6947
	farcall LoadCompressedTileBlock ; $694a
	call AdvanceFrame ; $694d
	ld b, $08 ; $6950
	ld c, $10 ; $6952
	farcall LoadIndexedPalette ; $6954
	pop af ; $6957
	wram_bank ; $6958
	ret ; $695c
	; $695d, 27 bytes (bytes:2)
	db $62, $3c ; 0x00
	db $64, $3c ; 0x02
	db $66, $3c ; 0x04
	db $68, $3c ; 0x06
	db $6a, $3c ; 0x08
	db $6c, $3c ; 0x0a
	db $6e, $3c ; 0x0c
	db $00, $a8 ; 0x0e
	db $00, $a9 ; 0x10
	db $00, $aa ; 0x12
	db $00, $ab ; 0x14
	db $00, $ac ; 0x16
	db $00, $ad ; 0x18
	db $00 ; 0x1a
	xor a, [hl] ; $6978
	ld a, b ; $6979
	or a, a ; $697a
	jr z, .zero ; $697b
	ld c, $00 ; $697d
.loop:
	call AdvanceFrame ; $697f
	ld b, $06 ; $6982
	farcall RestoreMenuBgAndDrawPanel ; $6984
	ld b, $02 ; $6987
	farcall FlushWram3MapRows ; $6989
	ld a, c ; $698c
	inc a ; $698d
	ld c, a ; $698e
	cp a, $0c ; $698f
	jr nz, .loop ; $6991
	ret ; $6993
.zero:
	ld c, $0a ; $6994
.loopB:
	call AdvanceFrame ; $6996
	ld b, $07 ; $6999
	farcall RestoreMenuBgAndDrawPanel ; $699b
	ld b, $02 ; $699e
	farcall FlushWram3MapRows ; $69a0
	ld a, c ; $69a3
	dec a ; $69a4
	ld c, a ; $69a5
	cp a, $ff ; $69a6
	jr nz, .loopB ; $69a8
	ret ; $69aa
	ld a, b ; $69ab
	or a, a ; $69ac
	jr z, .zero2 ; $69ad
	ld c, $00 ; $69af
.loop2:
	call AdvanceFrame ; $69b1
	ld b, $07 ; $69b4
	farcall RestoreMenuBgAndDrawPanel ; $69b6
	ld b, $02 ; $69b9
	farcall FlushWram3MapRows ; $69bb
	ld a, c ; $69be
	inc a ; $69bf
	ld c, a ; $69c0
	cp a, $0d ; $69c1
	jr nz, .loop2 ; $69c3
	ret ; $69c5
.zero2:
	ld c, $0c ; $69c6
.loop3:
	call AdvanceFrame ; $69c8
	ld b, $06 ; $69cb
	farcall RestoreMenuBgAndDrawPanel ; $69cd
	ld b, $02 ; $69d0
	farcall FlushWram3MapRows ; $69d2
	ld a, c ; $69d5
	dec a ; $69d6
	ld c, a ; $69d7
	or a, a ; $69d8
	jr nz, .loop3 ; $69d9
	ret ; $69db
SavedDataSourceCursorSpriteTask:
	farcall TickMenuBgScroll ; $69dc
	ld c, $03 ; $69df
	call GetMenuCursorCellIndex ; $69e1
	push af ; $69e4
	ld hl, SavedDataSourceCursorSpriteTaskTable1 ; $69e5
	add a, l ; $69e8
	ld l, a ; $69e9
	jr nc, .read ; $69ea
	inc h ; $69ec
.read:
	ld c, [hl] ; $69ed
	pop af ; $69ee
	ld hl, SavedDataSourceCursorSpriteTaskTable0 ; $69ef
	add a, a ; $69f2
	add a, l ; $69f3
	ld l, a ; $69f4
	jr nc, .readB ; $69f5
	inc h ; $69f7
.readB:
	ld a, [hl+] ; $69f8
	ld d, [hl] ; $69f9
	ld e, a ; $69fa
	farcall ApplySpriteBobOffset ; $69fb
	ld b, $08 ; $69fe
	ld hl, SpriteTemplate_3b_6a19 ; $6a00
	push de ; $6a03
	call QueueSpriteTemplate ; $6a04
	pop de ; $6a07
	ld hl, $17f8 ; $6a08
	add hl, de ; $6a0b
	ld d, h ; $6a0c
	ld e, l ; $6a0d
	ld hl, SpriteTemplate_3b_6a3a ; $6a0e
	ld b, $08 ; $6a11
	ld c, $70 ; $6a13
	call QueueSpriteTemplate ; $6a15
	ret ; $6a18
SpriteTemplate_3b_6a19:
	; $6a19, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
SpriteTemplate_3b_6a3a:
	; $6a3a, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
SavedDataSourceCursorSpriteTaskTable0:
	; $6a43, 12 bytes (bytes:12)
	db $38, $fc, $38, $2c, $38, $5c, $60, $0c, $60, $4d, $60, $3e ; 0x00
SavedDataSourceCursorSpriteTaskTable1:
	; $6a4f, 47 bytes (bytes:16)
	db $00, $10, $20, $40, $30, $40, $10, $08, $00, $00, $10, $10, $02, $00, $10, $18 ; 0x00
	db $04, $00, $10, $20, $06, $00, $10, $28, $08, $00, $10, $30, $0a, $00, $10, $38 ; 0x10
	db $0c, $00, $10, $40, $0e, $00, $10, $48, $10, $00, $10, $50, $12, $00, $80 ; 0x20
DrawSavedDataSourceGrid:
	wram_bank $03 ; $6a7e
	ld b, $00 ; $6a84
	ld c, $00 ; $6a86
.loop:
	call FillSavedDataSourceCell ; $6a88
	ld a, b ; $6a8b
	inc a ; $6a8c
	ld b, a ; $6a8d
	cp a, $05 ; $6a8e
	jr nz, .loop ; $6a90
	ld c, $03 ; $6a92
	call GetMenuCursorCellIndex ; $6a94
	ld b, a ; $6a97
	ld c, $01 ; $6a98
	call FillSavedDataSourceCell ; $6a9a
	ld c, $03 ; $6a9d
	call GetMenuCursorCellIndex ; $6a9f
	cp a, $03 ; $6aa2
	jr nc, .loadSavedDataSourceCellPalette ; $6aa4
	add a, a ; $6aa6
	add a, a ; $6aa7
	add a, a ; $6aa8
	add a, a ; $6aa9
	ld bc, $d300 ; $6aaa
	add a, c ; $6aad
	ld c, a ; $6aae
	jr nc, .gotPtr ; $6aaf
	inc b ; $6ab1
.gotPtr:
	ld hl, $0001 ; $6ab2
	add hl, bc ; $6ab5
	ld a, [hl] ; $6ab6
	ld d, $04 ; $6ab7
	farcall LoadIndexedPalette_18 ; $6ab9
	jr .fillTilemapRect ; $6abc
.loadSavedDataSourceCellPalette:
	call LoadSavedDataSourceCellPalette ; $6abe
.fillTilemapRect:
	wram_bank $03 ; $6ac1
	ld de, $d1e0 ; $6ac7
	ld b, $14 ; $6aca
	ld c, $01 ; $6acc
	ld h, $03 ; $6ace
	farcall FillTilemapRect ; $6ad0
	ld a, $02 ; $6ad3
	ld [$d1e0], a ; $6ad5
	ld a, $04 ; $6ad8
	ld [$d1f3], a ; $6ada
	ld de, $d201 ; $6add
	ld b, $12 ; $6ae0
	ld c, $01 ; $6ae2
	ld h, $20 ; $6ae4
	farcall FillTilemapRect ; $6ae6
	call DrawSavedDataSourceCaption ; $6ae9
	ld hl, $d480 ; $6aec
	ld de, $b880 ; $6aef
	ld c, $06 ; $6af2
	call QueueVRAMCopy ; $6af4
	ld hl, $d520 ; $6af7
	ld de, $b920 ; $6afa
	ld c, $06 ; $6afd
	call QueueVRAMCopy ; $6aff
	ld hl, $d1e0 ; $6b02
	ld de, $99e0 ; $6b05
	ld c, $04 ; $6b08
	call QueueVRAMCopy ; $6b0a
	ret ; $6b0d
FillSavedDataSourceCell:
	push af ; $6b0e
	push bc ; $6b0f
	push de ; $6b10
	push hl ; $6b11
	ld d, c ; $6b12
	ld e, b ; $6b13
	ld a, b ; $6b14
	cp a, $03 ; $6b15
	jr nc, .ge03 ; $6b17
	ld b, $03 ; $6b19
	ld c, $03 ; $6b1b
	jr .step2 ; $6b1d
.ge03:
	ld b, $05 ; $6b1f
	ld c, $03 ; $6b21
.step2:
	ld a, d ; $6b23
	or a, a ; $6b24
	jr z, .zero ; $6b25
	ld h, $0c ; $6b27
	jr .step4 ; $6b29
.zero:
	ld h, $0d ; $6b2b
.step4:
	push hl ; $6b2d
	ld hl, $6b44 ; $6b2e
	ld a, e ; $6b31
	add a, a ; $6b32
	add a, l ; $6b33
	ld l, a ; $6b34
	jr nc, .read ; $6b35
	inc h ; $6b37
.read:
	ld a, [hl+] ; $6b38
	ld d, [hl] ; $6b39
	ld e, a ; $6b3a
	pop hl ; $6b3b
	farcall FillTilemapRect ; $6b3c
	pop hl ; $6b3f
	pop de ; $6b40
	pop bc ; $6b41
	pop af ; $6b42
	ret ; $6b43
	; $6b44, 10 bytes (records:2)
	dw $d482 ; record 0
	dw $d488 ; record 1
	dw $d48e ; record 2
	dw $d523 ; record 3
	dw $d52b ; record 4
LoadSavedDataSourceCellPalette:
	ld hl, $6b61 ; $6b4e
	add a, a ; $6b51
	add a, l ; $6b52
	ld l, a ; $6b53
	jr nc, .read ; $6b54
	inc h ; $6b56
.read:
	ld a, [hl+] ; $6b57
	ld h, [hl] ; $6b58
	ld l, a ; $6b59
	ld de, $0401 ; $6b5a
	call LoadPaletteShadow ; $6b5d
	ret ; $6b60
	; $6b61, 18 bytes (records:2)
	dw $6b73 ; record 0
	dw $6b73 ; record 1
	dw $6b73 ; record 2
	dw $6b7b ; record 3
	dw $6b73 ; record 4
	dw $6b73 ; record 5
	dw $6b73 ; record 6
	dw $6b73 ; record 7
	dw $6b73 ; record 8
	; $6b73, 16 bytes (bytes:8)
	db $88, $7a, $ff, $6b, $00, $7d, $00, $00 ; 0x00
	db $9f, $5a, $ff, $6b, $1f, $00, $00, $00 ; 0x08
DrawSavedDataSourceCaption:
	ldh a, [hWramBank] ; $6b83
	push af ; $6b85
	wram_bank $03 ; $6b86
	ld c, $03 ; $6b8c
	call GetMenuCursorCellIndex ; $6b8e
	ld b, a ; $6b91
	cp a, $03 ; $6b92
	jp nc, .compare ; $6b94
	add a, a ; $6b97
	add a, a ; $6b98
	add a, a ; $6b99
	add a, a ; $6b9a
	ld bc, $d300 ; $6b9b
	add a, c ; $6b9e
	ld c, a ; $6b9f
	jr nc, .gotPtr ; $6ba0
	inc b ; $6ba2
.gotPtr:
	ld hl, $0000 ; $6ba3
	add hl, bc ; $6ba6
	ld a, [hl] ; $6ba7
	cp a, $3f ; $6ba8
	jr z, .eq3f ; $6baa
	ld hl, $0003 ; $6bac
	add hl, bc ; $6baf
	ld de, $d201 ; $6bb0
	call DrawNameWithDiacritics_3b ; $6bb3
	ld a, $4c ; $6bb6
	ld [$d209], a ; $6bb8
	ld a, $56 ; $6bbb
	ld [$d20a], a ; $6bbd
	push af ; $6bc0
	push bc ; $6bc1
	push de ; $6bc2
	push hl ; $6bc3
	ld hl, $0002 ; $6bc4
	add hl, bc ; $6bc7
	ld a, [hl] ; $6bc8
	ld h, $00 ; $6bc9
	ld l, a ; $6bcb
	ld de, $d20c ; $6bcc
	ld bc, $d330 ; $6bcf
	call PrintNumberRightAligned ; $6bd2
	pop hl ; $6bd5
	pop de ; $6bd6
	pop bc ; $6bd7
	pop af ; $6bd8
	push af ; $6bd9
	push bc ; $6bda
	push de ; $6bdb
	push hl ; $6bdc
	ld hl, $000f ; $6bdd
	add hl, bc ; $6be0
	ld a, [hl] ; $6be1
	ld h, $00 ; $6be2
	ld l, a ; $6be4
	ld de, $d20f ; $6be5
	ld bc, $d330 ; $6be8
	call Print2DigitNumberRightAligned ; $6beb
	pop hl ; $6bee
	pop de ; $6bef
	pop bc ; $6bf0
	pop af ; $6bf1
	ld hl, $000e ; $6bf2
	add hl, bc ; $6bf5
	ld a, [hl] ; $6bf6
	ld h, $00 ; $6bf7
	ld l, a ; $6bf9
	ld de, $d212 ; $6bfa
	ld bc, $d330 ; $6bfd
	call Print2DigitNumberRightAligned ; $6c00
	ld a, $3a ; $6c03
	ld [$d210], a ; $6c05
	pop af ; $6c08
	wram_bank ; $6c09
	ret ; $6c0d
.eq3f:
	ld hl, $00c8 ; $6c0e
	ld de, $d201 ; $6c11
	ld c, $20 ; $6c14
	farcall RenderTextToBuffer64 ; $6c16
	jr .restore ; $6c19
.compare:
	cp a, $04 ; $6c1b
	jr nz, .ne04 ; $6c1d
	ld hl, $00c7 ; $6c1f
	ld de, $d201 ; $6c22
	ld c, $20 ; $6c25
	farcall RenderTextToBuffer64 ; $6c27
	jr .restore ; $6c2a
.ne04:
	ld hl, $00c9 ; $6c2c
	ld de, $d201 ; $6c2f
	ld c, $20 ; $6c32
	farcall RenderTextToBuffer64 ; $6c34
.restore:
	pop af ; $6c37
	wram_bank ; $6c38
	ret ; $6c3c
LoadN64RecordsToWram2:
	ldh a, [hWramBank] ; $6c3d
	push af ; $6c3f
	wram_bank $02 ; $6c40
	ld hl, $d000 ; $6c46
	ld bc, $0020 ; $6c49
	call ClearMemory16 ; $6c4c
	ld hl, $d000 ; $6c4f
	ld b, $0b ; $6c52
	farcall ReadSaveBlock ; $6c54
	pop af ; $6c57
	wram_bank ; $6c58
	ret ; $6c5c
CheckN64DataPresent:
	ldh a, [hWramBank] ; $6c5d
	push af ; $6c5f
	wram_bank $02 ; $6c60
	ld a, [$d000] ; $6c66
	ld b, a ; $6c69
	ld a, [$d001] ; $6c6a
	or a, b ; $6c6d
	jr z, .restore ; $6c6e
	pop af ; $6c70
	wram_bank ; $6c71
	ld a, $01 ; $6c75
	ret ; $6c77
.restore:
	pop af ; $6c78
	wram_bank ; $6c79
	xor a, a ; $6c7d
	ret ; $6c7e
RunEraseSavedDataSelect:
	ld hl, rIE ; $6c7f
	res 2, [hl] ; $6c82
	sound $03 ; $6c84
	call BuildSaveSlotSummaries ; $6c86
	call LoadEraseSavedDataGfx ; $6c89
	wram_bank $03 ; $6c8c
	ld a, [wMenuSlideDirection] ; $6c92
	ld b, a ; $6c95
	call SavedDataPickerSlideIn ; $6c96
	farcall InitMenuBgScroll ; $6c99
	ld b, $01 ; $6c9c
	ld c, $01 ; $6c9e
	farcall LoadMenuSpritePalettePair ; $6ca0
	ld c, $00 ; $6ca3
	ld b, $03 ; $6ca5
	call SetMenuCursorFromCellIndex ; $6ca7
	ld a, $01 ; $6caa
	ld hl, EraseSavedDataCursorSpriteTask ; $6cac
	call RegisterFrameTask ; $6caf
	call DrawEraseSavedDataGrid ; $6cb2
	wram_bank $03 ; $6cb5
.loop:
	ldh a, [hInputPressed] ; $6cbb
	ld [wMenuInputPressed], a ; $6cbd
	call MoveSavedDataPickerCursor ; $6cc0
	or a, a ; $6cc3
	jr z, .advanceFrame ; $6cc4
	sound $5e ; $6cc6
	call DrawEraseSavedDataGrid ; $6cc8
.advanceFrame:
	call AdvanceFrame ; $6ccb
	ld a, [wMenuInputPressed] ; $6cce
	bit PADB_A, a ; $6cd1
	jr nz, .getMenuCursorCellIndex ; $6cd3
	bit 1, a ; $6cd5
	jr nz, .playSfx3 ; $6cd7
	jr .loop ; $6cd9
.getMenuCursorCellIndex:
	ld c, $03 ; $6cdb
	call GetMenuCursorCellIndex ; $6cdd
	cp a, $03 ; $6ce0
	jp nc, .playSfx2 ; $6ce2
	add a, a ; $6ce5
	add a, a ; $6ce6
	add a, a ; $6ce7
	add a, a ; $6ce8
	ld bc, $d300 ; $6ce9
	add a, c ; $6cec
	ld c, a ; $6ced
	jr nc, .gotPtr ; $6cee
	inc b ; $6cf0
.gotPtr:
	ld hl, $0000 ; $6cf1
	add hl, bc ; $6cf4
	ld a, [hl] ; $6cf5
	cp a, $3f ; $6cf6
	jr z, .playSfx ; $6cf8
	jr .playSfx2 ; $6cfa
.playSfx:
	sound $62 ; $6cfc
	jr .loop ; $6cfe
.playSfx2:
	sound $5f ; $6d00
	call ClearFrameTasks ; $6d02
	ld hl, rIE ; $6d05
	set 2, [hl] ; $6d08
	ld b, $01 ; $6d0a
	call SavedDataPickerSlideOut ; $6d0c
	ld a, $01 ; $6d0f
	ld [wMenuSlideDirection], a ; $6d11
	ld c, $03 ; $6d14
	call GetMenuCursorCellIndex ; $6d16
	ret ; $6d19
.playSfx3:
	sound $62 ; $6d1a
	call ClearFrameTasks ; $6d1c
	ld hl, rIE ; $6d1f
	set 2, [hl] ; $6d22
	ld b, $00 ; $6d24
	call SavedDataPickerSlideOut ; $6d26
	ld a, $00 ; $6d29
	ld [wMenuSlideDirection], a ; $6d2b
	ld a, $ff ; $6d2e
	ret ; $6d30
LoadEraseSavedDataGfx:
	ldh a, [hWramBank] ; $6d31
	push af ; $6d33
	wram_bank $01 ; $6d34
	wram_bank $03 ; $6d3a
	ld a, $00 ; $6d40
	ld [wCurrentStorySlot], a ; $6d42
	ld a, [$d300] ; $6d45
	farcall LoadCharMugshotToBuffer ; $6d48
	ld de, $b680 ; $6d4b
	farcall CopyMugshotBufferToVram ; $6d4e
	call AdvanceFrame ; $6d51
	wram_bank $03 ; $6d54
	ld a, $01 ; $6d5a
	ld [wCurrentStorySlot], a ; $6d5c
	ld a, [$d310] ; $6d5f
	farcall LoadCharMugshotToBuffer ; $6d62
	ld de, $b710 ; $6d65
	farcall CopyMugshotBufferToVram ; $6d68
	call AdvanceFrame ; $6d6b
	wram_bank $03 ; $6d6e
	ld a, $02 ; $6d74
	ld [wCurrentStorySlot], a ; $6d76
	ld a, [$d320] ; $6d79
	farcall LoadCharMugshotToBuffer ; $6d7c
	ld de, $af00 ; $6d7f
	farcall CopyMugshotBufferToVram ; $6d82
	call AdvanceFrame ; $6d85
	wram_bank $01 ; $6d88
	ld hl, $3d0e ; $6d8e -> DataPtr_3d_0e
	ld de, $d000 ; $6d91
	call DecompressDataFromBank ; $6d94
	ld hl, $d000 ; $6d97
	ld de, $a800 ; $6d9a
	ld c, $10 ; $6d9d
	call QueueVRAMCopy ; $6d9f
	call AdvanceFrame ; $6da2
	ld hl, $3d10 ; $6da5 -> DataPtr_3d_10
	ld de, $d000 ; $6da8
	call DecompressDataFromBank ; $6dab
	ld hl, $d000 ; $6dae
	ld de, $a900 ; $6db1
	ld c, $10 ; $6db4
	call QueueVRAMCopy ; $6db6
	call AdvanceFrame ; $6db9
	ld b, $2e ; $6dbc
	ld c, $10 ; $6dbe
	ld de, $a000 ; $6dc0
	farcall LoadCompressedTileBlock ; $6dc3
	call AdvanceFrame ; $6dc6
	ld b, $2f ; $6dc9
	ld c, $10 ; $6dcb
	ld de, $a100 ; $6dcd
	farcall LoadCompressedTileBlock ; $6dd0
	call AdvanceFrame ; $6dd3
	ld b, $30 ; $6dd6
	ld c, $10 ; $6dd8
	ld de, $a200 ; $6dda
	farcall LoadCompressedTileBlock ; $6ddd
	call AdvanceFrame ; $6de0
	ld b, $31 ; $6de3
	ld c, $10 ; $6de5
	ld de, $a300 ; $6de7
	farcall LoadCompressedTileBlock ; $6dea
	call AdvanceFrame ; $6ded
	ld b, $32 ; $6df0
	ld c, $10 ; $6df2
	ld de, $a400 ; $6df4
	farcall LoadCompressedTileBlock ; $6df7
	call AdvanceFrame ; $6dfa
	ld b, $1b ; $6dfd
	ld c, $04 ; $6dff
	ld de, $a700 ; $6e01
	farcall LoadCompressedTileBlock ; $6e04
	call AdvanceFrame ; $6e07
	ld b, $41 ; $6e0a
	ld c, $14 ; $6e0c
	ld de, $8000 ; $6e0e
	farcall LoadCompressedTileBlock ; $6e11
	call AdvanceFrame ; $6e14
	ld b, $08 ; $6e17
	ld c, $10 ; $6e19
	farcall LoadIndexedPalette ; $6e1b
	pop af ; $6e1e
	wram_bank ; $6e1f
	ret ; $6e23
SavedDataPickerSlideIn:
	ld a, b ; $6e24
	or a, a ; $6e25
	jr z, .zero ; $6e26
	ld c, $00 ; $6e28
.loop:
	call AdvanceFrame ; $6e2a
	ld b, $08 ; $6e2d
	farcall RestoreMenuBgAndDrawPanel ; $6e2f
	ld b, $02 ; $6e32
	farcall FlushWram3MapRows ; $6e34
	ld a, c ; $6e37
	inc a ; $6e38
	ld c, a ; $6e39
	cp a, $0f ; $6e3a
	jr nz, .loop ; $6e3c
	ret ; $6e3e
.zero:
	ld c, $0b ; $6e3f
.loopB:
	call AdvanceFrame ; $6e41
	ld b, $09 ; $6e44
	farcall RestoreMenuBgAndDrawPanel ; $6e46
	ld b, $02 ; $6e49
	farcall FlushWram3MapRows ; $6e4b
	ld a, c ; $6e4e
	dec a ; $6e4f
	ld c, a ; $6e50
	cp a, $ff ; $6e51
	jr nz, .loopB ; $6e53
	ret ; $6e55
SavedDataPickerSlideOut:
	ld a, b ; $6e56
	or a, a ; $6e57
	jr z, .slideIn ; $6e58
	ld c, $00 ; $6e5a
.outLoop:
	call AdvanceFrame ; $6e5c
	ld b, $09 ; $6e5f
	farcall RestoreMenuBgAndDrawPanel ; $6e61
	ld b, $02 ; $6e64
	farcall FlushWram3MapRows ; $6e66
	ld a, c ; $6e69
	inc a ; $6e6a
	ld c, a ; $6e6b
	cp a, $0a ; $6e6c
	jr nz, .outLoop ; $6e6e
	ret ; $6e70
.slideIn:
	ld c, $0e ; $6e71
.inLoop:
	call AdvanceFrame ; $6e73
	ld b, $08 ; $6e76
	farcall RestoreMenuBgAndDrawPanel ; $6e78
	ld b, $02 ; $6e7b
	farcall FlushWram3MapRows ; $6e7d
	ld a, c ; $6e80
	dec a ; $6e81
	ld c, a ; $6e82
	or a, a ; $6e83
	jr nz, .inLoop ; $6e84
	ret ; $6e86
MoveSavedDataPickerCursor:
	ld a, [wMenuCursorY] ; $6e87
	or a, a ; $6e8a
	jr nz, .checkMenuInputPressed ; $6e8b
	ld a, [wMenuInputPressed] ; $6e8d
	bit PADB_RIGHT, a ; $6e90
	jr nz, .checkMenuCursorX ; $6e92
	bit 5, a ; $6e94
	jr nz, .checkMenuCursorX2 ; $6e96
	bit 6, a ; $6e98
	jr nz, .checkMenuCursorX3 ; $6e9a
	bit 7, a ; $6e9c
	jr nz, .checkMenuCursorX3 ; $6e9e
	xor a, a ; $6ea0
	jp .done ; $6ea1
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $6ea4
	inc a ; $6ea7
	add a, a ; $6ea8
	jr nc, .noCarry ; $6ea9
	ld a, $03 ; $6eab
	dec a ; $6ead
	jr .store ; $6eae
.noCarry:
	rra ; $6eb0
	cp a, $03 ; $6eb1
	jr c, .store ; $6eb3
	xor a, a ; $6eb5
.store:
	ld [wMenuCursorX], a ; $6eb6
	ld a, $01 ; $6eb9
	jp .done ; $6ebb
.checkMenuCursorX2:
	ld a, [wMenuCursorX] ; $6ebe
	dec a ; $6ec1
	add a, a ; $6ec2
	jr nc, .noCarry2 ; $6ec3
	ld a, $03 ; $6ec5
	dec a ; $6ec7
	jr .store2 ; $6ec8
.noCarry2:
	rra ; $6eca
	cp a, $03 ; $6ecb
	jr c, .store2 ; $6ecd
	xor a, a ; $6ecf
.store2:
	ld [wMenuCursorX], a ; $6ed0
	ld a, $01 ; $6ed3
	jr .done ; $6ed5
.checkMenuCursorX3:
	ld a, [wMenuCursorX] ; $6ed7
	ld hl, $6f56 ; $6eda
	add a, l ; $6edd
	ld l, a ; $6ede
	jr nc, .read ; $6edf
	inc h ; $6ee1
.read:
	ld a, [hl] ; $6ee2
	ld [wMenuCursorX], a ; $6ee3
	ld a, [wMenuCursorY] ; $6ee6
	xor a, $01 ; $6ee9
	ld [wMenuCursorY], a ; $6eeb
	ld a, $01 ; $6eee
	jr .done ; $6ef0
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $6ef2
	bit PADB_RIGHT, a ; $6ef5
	jr nz, .checkMenuCursorX4 ; $6ef7
	bit 5, a ; $6ef9
	jr nz, .checkMenuCursorX5 ; $6efb
	bit 6, a ; $6efd
	jr nz, .checkMenuCursorX6 ; $6eff
	bit 7, a ; $6f01
	jr nz, .checkMenuCursorX6 ; $6f03
	xor a, a ; $6f05
	jr .done ; $6f06
.checkMenuCursorX4:
	ld a, [wMenuCursorX] ; $6f08
	inc a ; $6f0b
	add a, a ; $6f0c
	jr nc, .noCarry3 ; $6f0d
	ld a, $02 ; $6f0f
	dec a ; $6f11
	jr .store3 ; $6f12
.noCarry3:
	rra ; $6f14
	cp a, $02 ; $6f15
	jr c, .store3 ; $6f17
	xor a, a ; $6f19
.store3:
	ld [wMenuCursorX], a ; $6f1a
	ld a, $01 ; $6f1d
	jr .done ; $6f1f
.checkMenuCursorX5:
	ld a, [wMenuCursorX] ; $6f21
	dec a ; $6f24
	add a, a ; $6f25
	jr nc, .noCarry4 ; $6f26
	ld a, $02 ; $6f28
	dec a ; $6f2a
	jr .store4 ; $6f2b
.noCarry4:
	rra ; $6f2d
	cp a, $02 ; $6f2e
	jr c, .store4 ; $6f30
	xor a, a ; $6f32
.store4:
	ld [wMenuCursorX], a ; $6f33
	ld a, $01 ; $6f36
	jr .done ; $6f38
.checkMenuCursorX6:
	ld a, [wMenuCursorX] ; $6f3a
	ld hl, $6f59 ; $6f3d
	add a, l ; $6f40
	ld l, a ; $6f41
	jr nc, .readB ; $6f42
	inc h ; $6f44
.readB:
	ld a, [hl] ; $6f45
	ld [wMenuCursorX], a ; $6f46
	ld a, [wMenuCursorY] ; $6f49
	xor a, $01 ; $6f4c
	ld [wMenuCursorY], a ; $6f4e
	ld a, $01 ; $6f51
	jr .done ; $6f53
.done:
	ret ; $6f55
	; $6f56, 5 bytes (bytes:8)
	db $00, $01, $01, $00, $02 ; 0x00
EraseSavedDataCursorSpriteTask:
	farcall TickMenuBgScroll ; $6f5b
	ld c, $03 ; $6f5e
	call GetMenuCursorCellIndex ; $6f60
	push af ; $6f63
	ld hl, EraseSavedDataCursorSpriteTaskTable1 ; $6f64
	add a, l ; $6f67
	ld l, a ; $6f68
	jr nc, .read ; $6f69
	inc h ; $6f6b
.read:
	ld c, [hl] ; $6f6c
	pop af ; $6f6d
	ld hl, EraseSavedDataCursorSpriteTaskTable0 ; $6f6e
	add a, a ; $6f71
	add a, l ; $6f72
	ld l, a ; $6f73
	jr nc, .readB ; $6f74
	inc h ; $6f76
.readB:
	ld a, [hl+] ; $6f77
	ld d, [hl] ; $6f78
	ld e, a ; $6f79
	farcall ApplySpriteBobOffset ; $6f7a
	ld b, $08 ; $6f7d
	ld hl, SpriteTemplate_3b_6f98 ; $6f7f
	push de ; $6f82
	call QueueSpriteTemplate ; $6f83
	pop de ; $6f86
	ld hl, $17f8 ; $6f87
	add hl, de ; $6f8a
	ld d, h ; $6f8b
	ld e, l ; $6f8c
	ld hl, SpriteTemplate_3b_6fb9 ; $6f8d
	ld b, $08 ; $6f90
	ld c, $70 ; $6f92
	call QueueSpriteTemplate ; $6f94
	ret ; $6f97
SpriteTemplate_3b_6f98:
	; $6f98, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
SpriteTemplate_3b_6fb9:
	; $6fb9, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
EraseSavedDataCursorSpriteTaskTable0:
	; $6fc2, 10 bytes (bytes:10)
	db $3a, $fe, $3a, $2c, $3a, $5c, $60, $0c, $60, $4c ; 0x00
EraseSavedDataCursorSpriteTaskTable1:
	; $6fcc, 47 bytes (bytes:16)
	db $00, $10, $20, $30, $40, $30, $10, $08, $00, $00, $10, $10, $02, $00, $10, $18 ; 0x00
	db $04, $00, $10, $20, $06, $00, $10, $28, $08, $00, $10, $30, $0a, $00, $10, $38 ; 0x10
	db $0c, $00, $10, $40, $0e, $00, $10, $48, $10, $00, $10, $50, $12, $00, $80 ; 0x20
DrawEraseSavedDataGrid:
	wram_bank $03 ; $6ffb
	ld b, $00 ; $7001
	ld c, $00 ; $7003
.loop:
	call FillEraseSavedDataCell ; $7005
	ld a, b ; $7008
	inc a ; $7009
	ld b, a ; $700a
	cp a, $05 ; $700b
	jr nz, .loop ; $700d
	ld c, $03 ; $700f
	call GetMenuCursorCellIndex ; $7011
	ld b, a ; $7014
	ld c, $01 ; $7015
	call FillEraseSavedDataCell ; $7017
	ld c, $03 ; $701a
	call GetMenuCursorCellIndex ; $701c
	cp a, $03 ; $701f
	jr nc, .loadEraseSavedDataCellPalette ; $7021
	add a, a ; $7023
	add a, a ; $7024
	add a, a ; $7025
	add a, a ; $7026
	ld bc, $d300 ; $7027
	add a, c ; $702a
	ld c, a ; $702b
	jr nc, .gotPtr ; $702c
	inc b ; $702e
.gotPtr:
	ld hl, $0001 ; $702f
	add hl, bc ; $7032
	ld a, [hl] ; $7033
	ld d, $04 ; $7034
	farcall LoadIndexedPalette_18 ; $7036
	jr .fillTilemapRect ; $7039
.loadEraseSavedDataCellPalette:
	call LoadEraseSavedDataCellPalette ; $703b
.fillTilemapRect:
	wram_bank $03 ; $703e
	ld de, $d1e0 ; $7044
	ld b, $14 ; $7047
	ld c, $01 ; $7049
	ld h, $03 ; $704b
	farcall FillTilemapRect ; $704d
	ld a, $02 ; $7050
	ld [$d1e0], a ; $7052
	ld a, $04 ; $7055
	ld [$d1f3], a ; $7057
	ld de, $d201 ; $705a
	ld b, $12 ; $705d
	ld c, $01 ; $705f
	ld h, $20 ; $7061
	farcall FillTilemapRect ; $7063
	call DrawEraseSavedDataCaption ; $7066
	ld hl, $d480 ; $7069
	ld de, $b880 ; $706c
	ld c, $06 ; $706f
	call QueueVRAMCopy ; $7071
	ld hl, $d520 ; $7074
	ld de, $b920 ; $7077
	ld c, $06 ; $707a
	call QueueVRAMCopy ; $707c
	ld hl, $d1e0 ; $707f
	ld de, $99e0 ; $7082
	ld c, $04 ; $7085
	call QueueVRAMCopy ; $7087
	ret ; $708a
FillEraseSavedDataCell:
	push af ; $708b
	push bc ; $708c
	push de ; $708d
	push hl ; $708e
	ld d, c ; $708f
	ld e, b ; $7090
	ld a, b ; $7091
	cp a, $03 ; $7092
	jr nc, .ge03 ; $7094
	ld b, $03 ; $7096
	ld c, $03 ; $7098
	jr .step2 ; $709a
.ge03:
	ld b, $05 ; $709c
	ld c, $03 ; $709e
.step2:
	ld a, d ; $70a0
	or a, a ; $70a1
	jr z, .zero ; $70a2
	ld h, $0c ; $70a4
	jr .step4 ; $70a6
.zero:
	ld h, $0d ; $70a8
.step4:
	push hl ; $70aa
	ld hl, $70c1 ; $70ab
	ld a, e ; $70ae
	add a, a ; $70af
	add a, l ; $70b0
	ld l, a ; $70b1
	jr nc, .read ; $70b2
	inc h ; $70b4
.read:
	ld a, [hl+] ; $70b5
	ld d, [hl] ; $70b6
	ld e, a ; $70b7
	pop hl ; $70b8
	farcall FillTilemapRect ; $70b9
	pop hl ; $70bc
	pop de ; $70bd
	pop bc ; $70be
	pop af ; $70bf
	ret ; $70c0
	; $70c1, 10 bytes (records:2)
	dw $d482 ; record 0
	dw $d488 ; record 1
	dw $d48e ; record 2
	dw $d523 ; record 3
	dw $d52b ; record 4
LoadEraseSavedDataCellPalette:
	ld hl, $70de ; $70cb
	add a, a ; $70ce
	add a, l ; $70cf
	ld l, a ; $70d0
	jr nc, .read ; $70d1
	inc h ; $70d3
.read:
	ld a, [hl+] ; $70d4
	ld h, [hl] ; $70d5
	ld l, a ; $70d6
	ld de, $0401 ; $70d7
	call LoadPaletteShadow ; $70da
	ret ; $70dd
	; $70de, 18 bytes (records:2)
	dw $70f0 ; record 0
	dw $70f0 ; record 1
	dw $70f0 ; record 2
	dw $70f8 ; record 3
	dw $70f0 ; record 4
	dw $70f0 ; record 5
	dw $70f0 ; record 6
	dw $70f0 ; record 7
	dw $70f0 ; record 8
	; $70f0, 16 bytes (bytes:8)
	db $9f, $5a, $ff, $6b, $1f, $00, $00, $00 ; 0x00
	db $cc, $3a, $ff, $6b, $40, $65, $00, $00 ; 0x08
DrawEraseSavedDataCaption:
	ldh a, [hWramBank] ; $7100
	push af ; $7102
	wram_bank $03 ; $7103
	ld c, $03 ; $7109
	call GetMenuCursorCellIndex ; $710b
	ld b, a ; $710e
	cp a, $03 ; $710f
	jp nc, .ge03 ; $7111
	add a, a ; $7114
	add a, a ; $7115
	add a, a ; $7116
	add a, a ; $7117
	ld bc, $d300 ; $7118
	add a, c ; $711b
	ld c, a ; $711c
	jr nc, .gotPtr ; $711d
	inc b ; $711f
.gotPtr:
	ld hl, $0000 ; $7120
	add hl, bc ; $7123
	ld a, [hl] ; $7124
	cp a, $3f ; $7125
	jr z, .eq3f ; $7127
	ld hl, $0003 ; $7129
	add hl, bc ; $712c
	ld de, $d201 ; $712d
	call DrawNameWithDiacritics_3b ; $7130
	ld a, $4c ; $7133
	ld [$d209], a ; $7135
	ld a, $56 ; $7138
	ld [$d20a], a ; $713a
	push af ; $713d
	push bc ; $713e
	push de ; $713f
	push hl ; $7140
	ld hl, $0002 ; $7141
	add hl, bc ; $7144
	ld a, [hl] ; $7145
	ld h, $00 ; $7146
	ld l, a ; $7148
	ld de, $d20c ; $7149
	ld bc, $d330 ; $714c
	call PrintNumberRightAligned ; $714f
	pop hl ; $7152
	pop de ; $7153
	pop bc ; $7154
	pop af ; $7155
	push af ; $7156
	push bc ; $7157
	push de ; $7158
	push hl ; $7159
	ld hl, $000f ; $715a
	add hl, bc ; $715d
	ld a, [hl] ; $715e
	ld h, $00 ; $715f
	ld l, a ; $7161
	ld de, $d20f ; $7162
	ld bc, $d330 ; $7165
	call Print2DigitNumberRightAligned ; $7168
	pop hl ; $716b
	pop de ; $716c
	pop bc ; $716d
	pop af ; $716e
	ld hl, $000e ; $716f
	add hl, bc ; $7172
	ld a, [hl] ; $7173
	ld h, $00 ; $7174
	ld l, a ; $7176
	ld de, $d212 ; $7177
	ld bc, $d330 ; $717a
	call Print2DigitNumberRightAligned ; $717d
	ld a, $3a ; $7180
	ld [$d210], a ; $7182
	pop af ; $7185
	wram_bank ; $7186
	ret ; $718a
.eq3f:
	ld hl, $00ce ; $718b
	ld de, $d201 ; $718e
	ld c, $20 ; $7191
	farcall RenderTextToBuffer64 ; $7193
	jr .restore ; $7196
.ge03:
	ld hl, $00cc ; $7198
	sub a, $03 ; $719b
	add a, l ; $719d
	ld l, a ; $719e
	jr nc, .renderTextToBuffer64 ; $719f
	inc h ; $71a1
.renderTextToBuffer64:
	ld de, $d201 ; $71a2
	ld c, $20 ; $71a5
	farcall RenderTextToBuffer64 ; $71a7
.restore:
	pop af ; $71aa
	wram_bank ; $71ab
	ret ; $71af
RunN64RecordTypeSelect:
	sound $03 ; $71b0
	ld hl, rIE ; $71b2
	res 2, [hl] ; $71b5
	call LoadN64RecordTypeGfx ; $71b7
	farcall InitMenuBgScroll ; $71ba
	ld b, $01 ; $71bd
	ld c, $01 ; $71bf
	farcall LoadMenuSpritePalettePair ; $71c1
	wram_bank $03 ; $71c4
	ld a, [wMenuSlideDirection] ; $71ca
	ld b, a ; $71cd
	call N64RecordTypeSlideIn ; $71ce
	ld a, [$cb1e] ; $71d1
	ld c, a ; $71d4
	ld b, $03 ; $71d5
	call SetMenuCursorFromCellIndex ; $71d7
	ld a, $01 ; $71da
	ld hl, N64RecordTypeCursorSpriteTask ; $71dc
	call RegisterFrameTask ; $71df
	call DrawN64RecordTypeGrid ; $71e2
	wram_bank $03 ; $71e5
.loop:
	call AdvanceFrame ; $71eb
	ldh a, [hInputPressed] ; $71ee
	ld [wMenuInputPressed], a ; $71f0
	ld b, $03 ; $71f3
	ld c, $01 ; $71f5
	call MoveMenuCursor ; $71f7
	or a, a ; $71fa
	jr z, .checkMenuInputPressed ; $71fb
	sound $5e ; $71fd
	call DrawN64RecordTypeGrid ; $71ff
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $7202
	bit PADB_A, a ; $7205
	jr nz, .playSfx ; $7207
	bit 1, a ; $7209
	jr nz, .playSfx2 ; $720b
	jr .loop ; $720d
.playSfx:
	sound $5f ; $720f
	call ClearFrameTasks ; $7211
	ld hl, rIE ; $7214
	set 2, [hl] ; $7217
	ld b, $01 ; $7219
	call N64RecordTypeSlideOut ; $721b
	ld a, $01 ; $721e
	ld [wMenuSlideDirection], a ; $7220
	ld c, $03 ; $7223
	call GetMenuCursorCellIndex ; $7225
	ld [$cb1e], a ; $7228
	ret ; $722b
.playSfx2:
	sound $62 ; $722c
	call ClearFrameTasks ; $722e
	ld hl, rIE ; $7231
	set 2, [hl] ; $7234
	ld b, $00 ; $7236
	call N64RecordTypeSlideOut ; $7238
	ld a, $00 ; $723b
	ld [wMenuSlideDirection], a ; $723d
	ld a, $ff ; $7240
	ret ; $7242
LoadN64RecordTypeGfx:
	ldh a, [hWramBank] ; $7243
	push af ; $7245
	wram_bank $01 ; $7246
	ld c, $00 ; $724c
.loop:
	ld a, c ; $724e
	add a, a ; $724f
	ld hl, $72e0 ; $7250
	add a, l ; $7253
	ld l, a ; $7254
	jr nc, .read ; $7255
	inc h ; $7257
.read:
	ld a, [hl+] ; $7258
	ld h, [hl] ; $7259
	ld l, a ; $725a
	push af ; $725b
	push bc ; $725c
	push de ; $725d
	push hl ; $725e
	ld de, $d000 ; $725f
	call DecompressDataFromBank ; $7262
	pop hl ; $7265
	pop de ; $7266
	pop bc ; $7267
	pop af ; $7268
	ld hl, $72e6 ; $7269
	ld a, c ; $726c
	add a, a ; $726d
	add a, l ; $726e
	ld l, a ; $726f
	jr nc, .readB ; $7270
	inc h ; $7272
.readB:
	ld a, [hl+] ; $7273
	ld d, [hl] ; $7274
	ld e, a ; $7275
	ld hl, $d000 ; $7276
	push af ; $7279
	push bc ; $727a
	push de ; $727b
	push hl ; $727c
	ld bc, $0010 ; $727d
	call QueueVRAMCopy ; $7280
	pop hl ; $7283
	pop de ; $7284
	pop bc ; $7285
	pop af ; $7286
	ld a, c ; $7287
	inc a ; $7288
	ld c, a ; $7289
	call AdvanceFrame ; $728a
	ld a, c ; $728d
	cp a, $03 ; $728e
	jr nz, .loop ; $7290
	ld b, $39 ; $7292
	ld c, $10 ; $7294
	ld de, $a000 ; $7296
	farcall LoadCompressedTileBlock ; $7299
	call AdvanceFrame ; $729c
	ld b, $1d ; $729f
	ld c, $10 ; $72a1
	ld de, $a100 ; $72a3
	farcall LoadCompressedTileBlock ; $72a6
	call AdvanceFrame ; $72a9
	ld b, $3a ; $72ac
	ld c, $10 ; $72ae
	ld de, $a200 ; $72b0
	farcall LoadCompressedTileBlock ; $72b3
	call AdvanceFrame ; $72b6
	ld b, $1b ; $72b9
	ld c, $04 ; $72bb
	ld de, $a700 ; $72bd
	farcall LoadCompressedTileBlock ; $72c0
	call AdvanceFrame ; $72c3
	ld b, $43 ; $72c6
	ld c, $14 ; $72c8
	ld de, $8000 ; $72ca
	farcall LoadCompressedTileBlock ; $72cd
	call AdvanceFrame ; $72d0
	ld b, $08 ; $72d3
	ld c, $10 ; $72d5
	farcall LoadIndexedPalette ; $72d7
	pop af ; $72da
	wram_bank ; $72db
	ret ; $72df
	; $72e0, 12 bytes (bytes:2)
	db $78, $3c ; 0x00
	db $7a, $3c ; 0x02
	db $7c, $3c ; 0x04
	db $00, $a8 ; 0x06
	db $00, $a9 ; 0x08
	db $00, $aa ; 0x0a
N64RecordTypeSlideIn:
	ld a, b ; $72ec
	or a, a ; $72ed
	jr z, .zero ; $72ee
	ld c, $00 ; $72f0
.loop:
	call AdvanceFrame ; $72f2
	ld b, $0a ; $72f5
	farcall RestoreMenuBgAndDrawPanel ; $72f7
	ld b, $03 ; $72fa
	farcall FlushWram3MapRows ; $72fc
	ld a, c ; $72ff
	inc a ; $7300
	ld c, a ; $7301
	cp a, $0d ; $7302
	jr nz, .loop ; $7304
	ret ; $7306
.zero:
	ld c, $0a ; $7307
.loopB:
	call AdvanceFrame ; $7309
	ld b, $0b ; $730c
	farcall RestoreMenuBgAndDrawPanel ; $730e
	ld b, $03 ; $7311
	farcall FlushWram3MapRows ; $7313
	ld a, c ; $7316
	dec a ; $7317
	ld c, a ; $7318
	cp a, $ff ; $7319
	jr nz, .loopB ; $731b
	ret ; $731d
N64RecordTypeSlideOut:
	ld a, b ; $731e
	or a, a ; $731f
	jr z, .slideIn ; $7320
	ld c, $00 ; $7322
.outLoop:
	call AdvanceFrame ; $7324
	ld b, $0b ; $7327
	farcall RestoreMenuBgAndDrawPanel ; $7329
	ld b, $03 ; $732c
	farcall FlushWram3MapRows ; $732e
	ld a, c ; $7331
	inc a ; $7332
	ld c, a ; $7333
	cp a, $0b ; $7334
	jr nz, .outLoop ; $7336
	ret ; $7338
.slideIn:
	ld c, $0c ; $7339
.inLoop:
	call AdvanceFrame ; $733b
	ld b, $0a ; $733e
	farcall RestoreMenuBgAndDrawPanel ; $7340
	ld b, $03 ; $7343
	farcall FlushWram3MapRows ; $7345
	ld a, c ; $7348
	dec a ; $7349
	ld c, a ; $734a
	or a, a ; $734b
	jr nz, .inLoop ; $734c
	ret ; $734e
N64RecordTypeCursorSpriteTask:
	farcall TickMenuBgScroll ; $734f
	ld c, $03 ; $7352
	call GetMenuCursorCellIndex ; $7354
	push af ; $7357
	ld hl, N64RecordTypeCursorSpriteTaskTable1 ; $7358
	add a, l ; $735b
	ld l, a ; $735c
	jr nc, .read ; $735d
	inc h ; $735f
.read:
	ld c, [hl] ; $7360
	pop af ; $7361
	ld hl, N64RecordTypeCursorSpriteTaskTable0 ; $7362
	add a, a ; $7365
	add a, l ; $7366
	ld l, a ; $7367
	jr nc, .readB ; $7368
	inc h ; $736a
.readB:
	ld a, [hl+] ; $736b
	ld d, [hl] ; $736c
	ld e, a ; $736d
	farcall ApplySpriteBobOffset ; $736e
	ld b, $08 ; $7371
	ld hl, SpriteTemplate_3b_738c ; $7373
	push de ; $7376
	call QueueSpriteTemplate ; $7377
	pop de ; $737a
	ld hl, $17f8 ; $737b
	add hl, de ; $737e
	ld d, h ; $737f
	ld e, l ; $7380
	ld hl, SpriteTemplate_3b_73ad ; $7381
	ld b, $08 ; $7384
	ld c, $70 ; $7386
	call QueueSpriteTemplate ; $7388
	ret ; $738b
SpriteTemplate_3b_738c:
	; $738c, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
SpriteTemplate_3b_73ad:
	; $73ad, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
N64RecordTypeCursorSpriteTaskTable0:
	; $73b6, 6 bytes (bytes:6)
	db $50, $fc, $50, $2c, $50, $5c ; 0x00
N64RecordTypeCursorSpriteTaskTable1:
	; $73bc, 3 bytes (bytes:3)
	db $00, $10, $20 ; 0x00
DrawN64RecordTypeGrid:
	wram_bank $03 ; $73bf
	ld b, $00 ; $73c5
	ld c, $00 ; $73c7
.loop:
	call FillN64RecordTypeCell ; $73c9
	ld a, b ; $73cc
	inc a ; $73cd
	ld b, a ; $73ce
	cp a, $03 ; $73cf
	jr nz, .loop ; $73d1
	ld c, $03 ; $73d3
	call GetMenuCursorCellIndex ; $73d5
	ld b, a ; $73d8
	ld c, $01 ; $73d9
	call FillN64RecordTypeCell ; $73db
	ld c, $03 ; $73de
	call GetMenuCursorCellIndex ; $73e0
	call LoadN64RecordTypeCellPalette ; $73e3
	wram_bank $03 ; $73e6
	ld de, $d1e0 ; $73ec
	ld b, $14 ; $73ef
	ld c, $01 ; $73f1
	ld h, $03 ; $73f3
	farcall FillTilemapRect ; $73f5
	ld a, $02 ; $73f8
	ld [$d1e0], a ; $73fa
	ld a, $04 ; $73fd
	ld [$d1f3], a ; $73ff
	ld de, $d201 ; $7402
	ld b, $12 ; $7405
	ld c, $01 ; $7407
	ld h, $20 ; $7409
	farcall FillTilemapRect ; $740b
	call DrawN64RecordTypeCaption ; $740e
	ld hl, $d4e0 ; $7411
	ld de, $b8e0 ; $7414
	ld c, $06 ; $7417
	call QueueVRAMCopy ; $7419
	ld hl, $d1e0 ; $741c
	ld de, $99e0 ; $741f
	ld c, $04 ; $7422
	call QueueVRAMCopy ; $7424
	ret ; $7427
FillN64RecordTypeCell:
	push af ; $7428
	push bc ; $7429
	push de ; $742a
	push hl ; $742b
	ld a, c ; $742c
	or a, a ; $742d
	jr z, .zero ; $742e
	ld h, $0c ; $7430
	jr .step2 ; $7432
.zero:
	ld h, $0d ; $7434
.step2:
	push hl ; $7436
	ld hl, $7451 ; $7437
	ld a, b ; $743a
	add a, a ; $743b
	add a, l ; $743c
	ld l, a ; $743d
	jr nc, .read ; $743e
	inc h ; $7440
.read:
	ld a, [hl+] ; $7441
	ld d, [hl] ; $7442
	ld e, a ; $7443
	pop hl ; $7444
	ld b, $05 ; $7445
	ld c, $03 ; $7447
	farcall FillTilemapRect ; $7449
	pop hl ; $744c
	pop de ; $744d
	pop bc ; $744e
	pop af ; $744f
	ret ; $7450
	; $7451, 12 bytes (records:2)
	dw $d4e1 ; record 0
	dw $d4e7 ; record 1
	dw $d4ed ; record 2
	dw $d561 ; record 3
	dw $d567 ; record 4
	dw $d56d ; record 5
LoadN64RecordTypeCellPalette:
	ld hl, $7470 ; $745d
	add a, a ; $7460
	add a, l ; $7461
	ld l, a ; $7462
	jr nc, .read ; $7463
	inc h ; $7465
.read:
	ld a, [hl+] ; $7466
	ld h, [hl] ; $7467
	ld l, a ; $7468
	ld de, $0401 ; $7469
	call LoadPaletteShadow ; $746c
	ret ; $746f
	; $7470, 18 bytes (records:2)
	dw $7482 ; record 0
	dw $7492 ; record 1
	dw $748a ; record 2
	dw $7482 ; record 3
	dw $7482 ; record 4
	dw $7482 ; record 5
	dw $7482 ; record 6
	dw $7482 ; record 7
	dw $7482 ; record 8
	; $7482, 24 bytes (bytes:8)
	db $9f, $3e, $ff, $6b, $4a, $50, $00, $00 ; 0x00
	db $cc, $3a, $ff, $6b, $40, $65, $00, $00 ; 0x08
	db $32, $1b, $ff, $6b, $e0, $15, $00, $00 ; 0x10
DrawN64RecordTypeCaption:
	ldh a, [hWramBank] ; $749a
	push af ; $749c
	wram_bank $03 ; $749d
	ld c, $03 ; $74a3
	call GetMenuCursorCellIndex ; $74a5
	ld b, a ; $74a8
	ld hl, $00cf ; $74a9
	add a, l ; $74ac
	ld l, a ; $74ad
	jr nc, .renderTextToBuffer64 ; $74ae
	inc h ; $74b0
.renderTextToBuffer64:
	ld de, $d201 ; $74b1
	ld c, $20 ; $74b4
	farcall RenderTextToBuffer64 ; $74b6
	pop af ; $74b9
	wram_bank ; $74ba
	ret ; $74be
RunN64TransferItemSelect:
	sound $03 ; $74bf
	ld hl, rIE ; $74c1
	res 2, [hl] ; $74c4
	call LoadN64TransferItemGfx ; $74c6
	wram_bank $03 ; $74c9
	ld a, [wMenuSlideDirection] ; $74cf
	ld b, a ; $74d2
	farcall OpenCourtSelect4Panel ; $74d3
	farcall InitMenuBgScroll ; $74d6
	ld b, $01 ; $74d9
	ld c, $01 ; $74db
	farcall LoadMenuSpritePalettePair ; $74dd
	ld a, [$cb1d] ; $74e0
	ld c, a ; $74e3
	ld b, $02 ; $74e4
	call SetMenuCursorFromCellIndex ; $74e6
	ld a, $01 ; $74e9
	ld hl, N64TransferItemCursorSpriteTask ; $74eb
	call RegisterFrameTask ; $74ee
	call DrawN64TransferItemGrid ; $74f1
	wram_bank $03 ; $74f4
.loop:
	call AdvanceFrame ; $74fa
	ldh a, [hInputPressed] ; $74fd
	ld [wMenuInputPressed], a ; $74ff
	ld b, $02 ; $7502
	ld c, $02 ; $7504
	call MoveMenuCursor ; $7506
	or a, a ; $7509
	jr z, .checkMenuInputPressed ; $750a
	sound $5e ; $750c
	call DrawN64TransferItemGrid ; $750e
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $7511
	bit PADB_A, a ; $7514
	jr nz, .playSfx ; $7516
	bit 1, a ; $7518
	jr nz, .playSfx2 ; $751a
	jr .loop ; $751c
.playSfx:
	sound $5f ; $751e
	call ClearFrameTasks ; $7520
	ld hl, rIE ; $7523
	set 2, [hl] ; $7526
	ld b, $01 ; $7528
	farcall CloseCourtSelect4Panel ; $752a
	ld a, $01 ; $752d
	ld [wMenuSlideDirection], a ; $752f
	ld c, $02 ; $7532
	call GetMenuCursorCellIndex ; $7534
	ld [$cb1d], a ; $7537
	ret ; $753a
.playSfx2:
	sound $62 ; $753b
	call ClearFrameTasks ; $753d
	ld hl, rIE ; $7540
	set 2, [hl] ; $7543
	ld b, $00 ; $7545
	farcall CloseCourtSelect4Panel ; $7547
	ld a, $00 ; $754a
	ld [wMenuSlideDirection], a ; $754c
	ld a, $ff ; $754f
	ret ; $7551
LoadN64TransferItemGfx:
	ldh a, [hWramBank] ; $7552
	push af ; $7554
	wram_bank $01 ; $7555
	ld c, $00 ; $755b
.loop:
	ld a, c ; $755d
	add a, a ; $755e
	ld hl, $75fc ; $755f
	add a, l ; $7562
	ld l, a ; $7563
	jr nc, .read ; $7564
	inc h ; $7566
.read:
	ld a, [hl+] ; $7567
	ld h, [hl] ; $7568
	ld l, a ; $7569
	push af ; $756a
	push bc ; $756b
	push de ; $756c
	push hl ; $756d
	ld de, $d000 ; $756e
	call DecompressDataFromBank ; $7571
	pop hl ; $7574
	pop de ; $7575
	pop bc ; $7576
	pop af ; $7577
	ld hl, $7604 ; $7578
	ld a, c ; $757b
	add a, a ; $757c
	add a, l ; $757d
	ld l, a ; $757e
	jr nc, .readB ; $757f
	inc h ; $7581
.readB:
	ld a, [hl+] ; $7582
	ld d, [hl] ; $7583
	ld e, a ; $7584
	ld hl, $d000 ; $7585
	push af ; $7588
	push bc ; $7589
	push de ; $758a
	push hl ; $758b
	ld bc, $0010 ; $758c
	call QueueVRAMCopy ; $758f
	pop hl ; $7592
	pop de ; $7593
	pop bc ; $7594
	pop af ; $7595
	ld a, c ; $7596
	inc a ; $7597
	ld c, a ; $7598
	call AdvanceFrame ; $7599
	ld a, c ; $759c
	cp a, $04 ; $759d
	jr nz, .loop ; $759f
	ld b, $3b ; $75a1
	ld c, $10 ; $75a3
	ld de, $a000 ; $75a5
	farcall LoadCompressedTileBlock ; $75a8
	call AdvanceFrame ; $75ab
	ld b, $73 ; $75ae
	ld c, $10 ; $75b0
	ld de, $a100 ; $75b2
	farcall LoadCompressedTileBlock ; $75b5
	call AdvanceFrame ; $75b8
	ld b, $3c ; $75bb
	ld c, $10 ; $75bd
	ld de, $a200 ; $75bf
	farcall LoadCompressedTileBlock ; $75c2
	call AdvanceFrame ; $75c5
	ld b, $3d ; $75c8
	ld c, $10 ; $75ca
	ld de, $a300 ; $75cc
	farcall LoadCompressedTileBlock ; $75cf
	call AdvanceFrame ; $75d2
	ld b, $1b ; $75d5
	ld c, $04 ; $75d7
	ld de, $a700 ; $75d9
	farcall LoadCompressedTileBlock ; $75dc
	call AdvanceFrame ; $75df
	ld b, $44 ; $75e2
	ld c, $14 ; $75e4
	ld de, $8000 ; $75e6
	farcall LoadCompressedTileBlock ; $75e9
	call AdvanceFrame ; $75ec
	ld b, $08 ; $75ef
	ld c, $10 ; $75f1
	farcall LoadIndexedPalette ; $75f3
	pop af ; $75f6
	wram_bank ; $75f7
	ret ; $75fb
	; $75fc, 16 bytes (bytes:2)
	db $02, $3d ; 0x00
	db $06, $3d ; 0x02
	db $00, $3d ; 0x04
	db $04, $3d ; 0x06
	db $00, $a8 ; 0x08
	db $00, $a9 ; 0x0a
	db $00, $aa ; 0x0c
	db $00, $ab ; 0x0e
DrawN64TransferItemGrid:
	wram_bank $03 ; $760c
	ld b, $00 ; $7612
	ld c, $00 ; $7614
.loop:
	farcall SetCourtSelect4TabAttrRect ; $7616
	ld a, b ; $7619
	inc a ; $761a
	ld b, a ; $761b
	cp a, $04 ; $761c
	jr nz, .loop ; $761e
	ld c, $02 ; $7620
	call GetMenuCursorCellIndex ; $7622
	ld b, a ; $7625
	ld c, $01 ; $7626
	farcall SetCourtSelect4TabAttrRect ; $7628
	ld c, $02 ; $762b
	call GetMenuCursorCellIndex ; $762d
	call LoadN64TransferItemCellPalette ; $7630
	wram_bank $03 ; $7633
	ld de, $d1e0 ; $7639
	ld b, $14 ; $763c
	ld c, $01 ; $763e
	ld h, $03 ; $7640
	farcall FillTilemapRect ; $7642
	ld a, $02 ; $7645
	ld [$d1e0], a ; $7647
	ld a, $04 ; $764a
	ld [$d1f3], a ; $764c
	ld de, $d201 ; $764f
	ld b, $12 ; $7652
	ld c, $01 ; $7654
	ld h, $20 ; $7656
	farcall FillTilemapRect ; $7658
	call DrawN64TransferItemCaption ; $765b
	ld hl, $d480 ; $765e
	ld de, $b880 ; $7661
	ld c, $06 ; $7664
	call QueueVRAMCopy ; $7666
	ld hl, $d520 ; $7669
	ld de, $b920 ; $766c
	ld c, $06 ; $766f
	call QueueVRAMCopy ; $7671
	ld hl, $d1e0 ; $7674
	ld de, $99e0 ; $7677
	ld c, $04 ; $767a
	call QueueVRAMCopy ; $767c
	ret ; $767f
LoadN64TransferItemCellPalette:
	ld hl, $7693 ; $7680
	add a, a ; $7683
	add a, l ; $7684
	ld l, a ; $7685
	jr nc, .read ; $7686
	inc h ; $7688
.read:
	ld a, [hl+] ; $7689
	ld h, [hl] ; $768a
	ld l, a ; $768b
	ld de, $0401 ; $768c
	call LoadPaletteShadow ; $768f
	ret ; $7692
	; $7693, 18 bytes (records:2)
	dw $76a5 ; record 0
	dw $76bd ; record 1
	dw $76ad ; record 2
	dw $76b5 ; record 3
	dw $76b5 ; record 4
	dw $76a5 ; record 5
	dw $76a5 ; record 6
	dw $76a5 ; record 7
	dw $76a5 ; record 8
	; $76a5, 32 bytes (bytes:8)
	db $9f, $5a, $ff, $6b, $1f, $00, $00, $00 ; 0x00
	db $cc, $3a, $ff, $6b, $40, $65, $00, $00 ; 0x08
	db $ff, $29, $ff, $6b, $4a, $50, $00, $00 ; 0x10
	db $bf, $02, $ff, $6b, $57, $05, $00, $00 ; 0x18
DrawN64TransferItemCaption:
	ldh a, [hWramBank] ; $76c5
	push af ; $76c7
	wram_bank $03 ; $76c8
	ld c, $02 ; $76ce
	call GetMenuCursorCellIndex ; $76d0
	ld b, a ; $76d3
	ld hl, $00d2 ; $76d4
	add a, l ; $76d7
	ld l, a ; $76d8
	jr nc, .renderTextToBuffer64 ; $76d9
	inc h ; $76db
.renderTextToBuffer64:
	ld de, $d201 ; $76dc
	ld c, $20 ; $76df
	farcall RenderTextToBuffer64 ; $76e1
	pop af ; $76e4
	wram_bank ; $76e5
	ret ; $76e9
N64TransferItemCursorSpriteTask:
	farcall TickMenuBgScroll ; $76ea
	ld c, $02 ; $76ed
	call GetMenuCursorCellIndex ; $76ef
	push af ; $76f2
	ld hl, N64TransferItemCursorSpriteTaskTable1 ; $76f3
	add a, l ; $76f6
	ld l, a ; $76f7
	jr nc, .read ; $76f8
	inc h ; $76fa
.read:
	ld c, [hl] ; $76fb
	pop af ; $76fc
	ld hl, N64TransferItemCursorSpriteTaskTable0 ; $76fd
	add a, a ; $7700
	add a, l ; $7701
	ld l, a ; $7702
	jr nc, .readB ; $7703
	inc h ; $7705
.readB:
	ld a, [hl+] ; $7706
	ld d, [hl] ; $7707
	ld e, a ; $7708
	farcall ApplySpriteBobOffset ; $7709
	ld b, $08 ; $770c
	ld hl, SpriteTemplate_3b_7727 ; $770e
	push de ; $7711
	call QueueSpriteTemplate ; $7712
	pop de ; $7715
	ld hl, $17f8 ; $7716
	add hl, de ; $7719
	ld d, h ; $771a
	ld e, l ; $771b
	ld hl, SpriteTemplate_3b_7748 ; $771c
	ld b, $08 ; $771f
	ld c, $70 ; $7721
	call QueueSpriteTemplate ; $7723
	ret ; $7726
SpriteTemplate_3b_7727:
	; $7727, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
SpriteTemplate_3b_7748:
	; $7748, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
N64TransferItemCursorSpriteTaskTable0:
	; $7751, 8 bytes (bytes:8)
	db $38, $14, $38, $4c, $60, $14, $60, $4a ; 0x00
N64TransferItemCursorSpriteTaskTable1:
	; $7759, 4 bytes (bytes:4)
	db $00, $10, $20, $30 ; 0x00
ShowTournamentBracket:
	wram_bank $03 ; $775d
	ld a, b ; $7763
	ld [$d800], a ; $7764
	ld a, c ; $7767
	ld [$d801], a ; $7768
	call DisableLCDSafely ; $776b
	call BuildTournamentBracketScreen ; $776e
	call EnableLCD ; $7771
	script_fade_in $10 ; $7774
	call WaitFadeEnd ; $7779
	ld a, $01 ; $777c
	ld hl, BracketHighlightBlinkTask ; $777e
	call RegisterFrameTask ; $7781
	sound $78 ; $7784
	call WaitFramesCmd ; $7786
	db $78 ; $7789 inline arg
.loop:
	ldh a, [hInputPressed] ; $778a
	bit PADB_A, a ; $778c
	jr nz, .playSfx ; $778e
	bit 1, a ; $7790
	jr nz, .playSfx ; $7792
	call AdvanceFrame ; $7794
	jr .loop ; $7797
.playSfx:
	sound $5f ; $7799
	call ClearFrameTasks ; $779b
	ld c, $10 ; $779e
	call BeginFadeOut ; $77a0
	call WaitFadeEnd ; $77a3
	ret ; $77a6
BuildTournamentBracketScreen:
	ld a, [$d800] ; $77a7
	or a, a ; $77aa
	jr nz, .nonZero ; $77ab
	ld c, $25 ; $77ad
	farcall LoadScreenAssetRecord ; $77af
	ld b, $69 ; $77b2
	ld c, $10 ; $77b4
	ld de, $9000 ; $77b6
	farcall LoadCompressedTileBlock ; $77b9
	wram_bank $03 ; $77bc
	call ClearTournamentBracketAttrs ; $77c2
	call DrawTournamentBracketNameBoxes ; $77c5
	call WriteBracketSinglesNames ; $77c8
	call HighlightBracketPlayerRow ; $77cb
	farcall QueueWram3MapToVRAM ; $77ce
	ret ; $77d1
.nonZero:
	ld c, $26 ; $77d2
	farcall LoadScreenAssetRecord ; $77d4
	ld b, $69 ; $77d7
	ld c, $10 ; $77d9
	ld de, $9000 ; $77db
	farcall LoadCompressedTileBlock ; $77de
	wram_bank $03 ; $77e1
	call ClearTournamentBracketAttrs ; $77e7
	call DrawTournamentBracketNameBoxes ; $77ea
	call WriteBracketDoublesNames ; $77ed
	call HighlightBracketPlayerRow ; $77f0
	farcall QueueWram3MapToVRAM ; $77f3
	ret ; $77f6
ClearTournamentBracketAttrs:
	ld de, $d509 ; $77f7
	ld b, $07 ; $77fa
	ld c, $08 ; $77fc
	ld h, $00 ; $77fe
	farcall FillTilemapRect ; $7800
	ret ; $7803
DrawTournamentBracketNameBoxes:
	ld a, [$d800] ; $7804
	or a, a ; $7807
	jr nz, .nonZero ; $7808
	ld de, $d109 ; $780a
	ld b, $07 ; $780d
	ld c, $08 ; $780f
	ld h, $20 ; $7811
	farcall FillTilemapRect ; $7813
	ld de, $d109 ; $7816
	ld b, $07 ; $7819
	ld c, $01 ; $781b
	ld h, $03 ; $781d
	farcall FillTilemapRect ; $781f
	ld de, $d149 ; $7822
	ld b, $07 ; $7825
	ld c, $01 ; $7827
	ld h, $03 ; $7829
	farcall FillTilemapRect ; $782b
	ld de, $d189 ; $782e
	ld b, $07 ; $7831
	ld c, $01 ; $7833
	ld h, $03 ; $7835
	farcall FillTilemapRect ; $7837
	ld de, $d1c9 ; $783a
	ld b, $07 ; $783d
	ld c, $01 ; $783f
	ld h, $03 ; $7841
	farcall FillTilemapRect ; $7843
	ret ; $7846
.nonZero:
	ld de, $d109 ; $7847
	ld b, $07 ; $784a
	ld c, $08 ; $784c
	ld h, $20 ; $784e
	farcall FillTilemapRect ; $7850
	ld de, $d109 ; $7853
	ld b, $07 ; $7856
	ld c, $01 ; $7858
	ld h, $03 ; $785a
	farcall FillTilemapRect ; $785c
	ld de, $d189 ; $785f
	ld b, $07 ; $7862
	ld c, $01 ; $7864
	ld h, $03 ; $7866
	farcall FillTilemapRect ; $7868
	ret ; $786b
WriteBracketSinglesNames:
	ld a, [$d801] ; $786c
	ld hl, $7889 ; $786f
	add a, a ; $7872
	add a, l ; $7873
	ld l, a ; $7874
	jr nc, .read ; $7875
	inc h ; $7877
.read:
	ld a, [hl+] ; $7878
	ld h, [hl] ; $7879
	ld l, a ; $787a
	ld b, $00 ; $787b
.loop:
	ld a, [hl+] ; $787d
	call WriteBracketEntrantName ; $787e
	ld a, b ; $7881
	inc a ; $7882
	ld b, a ; $7883
	cp a, $04 ; $7884
	jr nz, .loop ; $7886
	ret ; $7888
	; $7889, 10 bytes (records:2)
	dw $7893 ; record 0
	dw $7893 ; record 1
	dw $7897 ; record 2
	dw $789b ; record 3
	dw $789f ; record 4
	; $7893, 16 bytes (bytes:4)
	db $00, $01, $02, $03 ; 0x00
	db $01, $00, $02, $03 ; 0x04
	db $01, $02, $00, $03 ; 0x08
	db $01, $02, $03, $00 ; 0x0c
WriteBracketEntrantName:
	push af ; $78a3
	push bc ; $78a4
	push de ; $78a5
	push hl ; $78a6
	or a, a ; $78a7
	jr z, .zero ; $78a8
	ld hl, $004b ; $78aa
	dec a ; $78ad
	add a, l ; $78ae
	ld l, a ; $78af
	jr nc, .gotPtr ; $78b0
	inc h ; $78b2
.gotPtr:
	push hl ; $78b3
	ld hl, $78e4 ; $78b4
	ld a, b ; $78b7
	add a, a ; $78b8
	add a, l ; $78b9
	ld l, a ; $78ba
	jr nc, .read ; $78bb
	inc h ; $78bd
.read:
	ld a, [hl+] ; $78be
	ld d, [hl] ; $78bf
	ld e, a ; $78c0
	pop hl ; $78c1
	ld c, $20 ; $78c2
	farcall RenderTextToBuffer64 ; $78c4
	pop hl ; $78c7
	pop de ; $78c8
	pop bc ; $78c9
	pop af ; $78ca
	ret ; $78cb
.zero:
	ld hl, $78e4 ; $78cc
	ld a, b ; $78cf
	add a, a ; $78d0
	add a, l ; $78d1
	ld l, a ; $78d2
	jr nc, .readB ; $78d3
	inc h ; $78d5
.readB:
	ld a, [hl+] ; $78d6
	ld d, [hl] ; $78d7
	ld e, a ; $78d8
	ld hl, wStoryModeNameOfMainCharacter ; $78d9
	call DrawNameWithDiacritics_3b ; $78dc
	pop hl ; $78df
	pop de ; $78e0
	pop bc ; $78e1
	pop af ; $78e2
	ret ; $78e3
	; $78e4, 8 bytes (records:2)
	dw $d129 ; record 0
	dw $d169 ; record 1
	dw $d1a9 ; record 2
	dw $d1e9 ; record 3
WriteBracketDoublesNames:
	ld a, [$d801] ; $78ec
	cp a, $01 ; $78ef
	jr nz, .ne01 ; $78f1
	ld hl, wStoryModeNameOfMainCharacter ; $78f3
	ld de, $d129 ; $78f6
	call DrawNameWithDiacritics_3b ; $78f9
	ld hl, wStoryModeNameOfPartnerCharacter ; $78fc
	ld de, $d169 ; $78ff
	call DrawNameWithDiacritics_3b ; $7902
	ld hl, $004b ; $7905
	ld de, $d1a9 ; $7908
	ld c, $20 ; $790b
	farcall RenderTextToBuffer64 ; $790d
	ld hl, $004c ; $7910
	ld de, $d1e9 ; $7913
	ld c, $20 ; $7916
	farcall RenderTextToBuffer64 ; $7918
	ret ; $791b
.ne01:
	ld hl, wStoryModeNameOfMainCharacter ; $791c
	ld de, $d1a9 ; $791f
	call DrawNameWithDiacritics_3b ; $7922
	ld hl, wStoryModeNameOfPartnerCharacter ; $7925
	ld de, $d1e9 ; $7928
	call DrawNameWithDiacritics_3b ; $792b
	ld hl, $004b ; $792e
	ld de, $d129 ; $7931
	ld c, $20 ; $7934
	farcall RenderTextToBuffer64 ; $7936
	ld hl, $004c ; $7939
	ld de, $d169 ; $793c
	ld c, $20 ; $793f
	farcall RenderTextToBuffer64 ; $7941
	ret ; $7944
HighlightBracketPlayerRow:
	ld a, [$d800] ; $7945
	or a, a ; $7948
	jr nz, .nonZero ; $7949
	ld a, [$d801] ; $794b
	ld hl, $79b6 ; $794e
	add a, a ; $7951
	add a, l ; $7952
	ld l, a ; $7953
	jr nc, .read ; $7954
	inc h ; $7956
.read:
	ld a, [hl+] ; $7957
	ld d, [hl] ; $7958
	ld e, a ; $7959
	ld b, $07 ; $795a
	ld c, $02 ; $795c
	ld h, $05 ; $795e
	farcall FillTilemapRect ; $7960
	ld a, [$d801] ; $7963
	ld hl, $79c0 ; $7966
	add a, a ; $7969
	add a, l ; $796a
	ld l, a ; $796b
	jr nc, .readB ; $796c
	inc h ; $796e
.readB:
	ld a, [hl+] ; $796f
	ld d, [hl] ; $7970
	ld e, a ; $7971
	ld b, $02 ; $7972
	ld c, $02 ; $7974
	ld a, [$d801] ; $7976
	cp a, $04 ; $7979
	jr nz, .ne04 ; $797b
	ld c, $01 ; $797d
.ne04:
	ld h, $0d ; $797f
	farcall FillTilemapRect ; $7981
	ret ; $7984
.nonZero:
	ld a, [$d801] ; $7985
	ld hl, $79ca ; $7988
	add a, a ; $798b
	add a, l ; $798c
	ld l, a ; $798d
	jr nc, .read2 ; $798e
	inc h ; $7990
.read2:
	ld a, [hl+] ; $7991
	ld d, [hl] ; $7992
	ld e, a ; $7993
	ld b, $07 ; $7994
	ld c, $04 ; $7996
	ld h, $05 ; $7998
	farcall FillTilemapRect ; $799a
	ld a, [$d801] ; $799d
	ld hl, $79d0 ; $79a0
	add a, a ; $79a3
	add a, l ; $79a4
	ld l, a ; $79a5
	jr nc, .read3 ; $79a6
	inc h ; $79a8
.read3:
	ld a, [hl+] ; $79a9
	ld d, [hl] ; $79aa
	ld e, a ; $79ab
	ld b, $02 ; $79ac
	ld c, $03 ; $79ae
	ld h, $0d ; $79b0
	farcall FillTilemapRect ; $79b2
	ret ; $79b5
	; $79b6, 32 bytes (records:2)
	dw $0000 ; record 0
	dw $d509 ; record 1
	dw $d549 ; record 2
	dw $d589 ; record 3
	dw $d5c9 ; record 4
	dw $0000 ; record 5
	dw $d525 ; record 6
	dw $d565 ; record 7
	dw $d5a5 ; record 8
	dw $d5e5 ; record 9
	dw $0000 ; record 10
	dw $d509 ; record 11
	dw $d589 ; record 12
	dw $0000 ; record 13
	dw $d525 ; record 14
	dw $d5a5 ; record 15
BracketHighlightBlinkTask:
	ld hl, $79e9 ; $79d6
	ldh a, [hVBlankCounter] ; $79d9
	and a, $10 ; $79db
	jr z, .maskClear ; $79dd
	ld hl, $79f1 ; $79df
.maskClear:
	ld de, $0501 ; $79e2
	call LoadPalettesImmediate ; $79e5
	ret ; $79e8
	; $79e9, 16 bytes (bytes:8)
	db $f9, $67, $00, $00, $1f, $3e, $ff, $33 ; 0x00
	db $f9, $67, $00, $00, $98, $00, $1f, $03 ; 0x08
RunStarCharExhibResults:
	sound $04 ; $79f9
	call DisableLCDSafely ; $79fb
	call BuildStarCharExhibScreen ; $79fe
	ld a, $01 ; $7a01
	ld [wAnimatedTileSet], a ; $7a03
	ld a, $03 ; $7a06
	ld [wAnimatedTilePeriod], a ; $7a08
	ld a, $01 ; $7a0b
	ld hl, UpdateAnimatedTilesTask_3b ; $7a0d
	call RegisterFrameTask ; $7a10
	ld a, $01 ; $7a13
	ld hl, StarChartScrollArrowsTask ; $7a15
	call RegisterFrameTask ; $7a18
	call EnableLCD ; $7a1b
	script_fade_in $10 ; $7a1e
	call WaitFadeEnd ; $7a23
	wram_bank $03 ; $7a26
.loop:
	call AdvanceFrame ; $7a2c
	ldh a, [hInputPressed] ; $7a2f
	ld [wMenuInputPressed], a ; $7a31
	call CheckStarChartExpanded ; $7a34
	or a, a ; $7a37
	jr z, .scrollStarChartCursorSmall ; $7a38
	call ScrollStarChartCursorFull ; $7a3a
	jr .checkMenuInputPressed ; $7a3d
.scrollStarChartCursorSmall:
	call ScrollStarChartCursorSmall ; $7a3f
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $7a42
	bit PADB_A, a ; $7a45
	jr nz, .playSfx ; $7a47
	bit 1, a ; $7a49
	jr nz, .playSfx2 ; $7a4b
	jr .loop ; $7a4d
.playSfx:
	sound $5f ; $7a4f
	ld c, $10 ; $7a51
	call BeginFadeOut ; $7a53
	call WaitFadeEnd ; $7a56
	call ClearFrameTasks ; $7a59
	ret ; $7a5c
.playSfx2:
	sound $62 ; $7a5d
	ld c, $10 ; $7a5f
	call BeginFadeOut ; $7a61
	call WaitFadeEnd ; $7a64
	call ClearFrameTasks ; $7a67
	ld a, $ff ; $7a6a
	ret ; $7a6c
StarChartScrollArrowsTask:
	ldh a, [hWramBank] ; $7a6d
	push af ; $7a6f
	wram_bank $03 ; $7a70
	call CheckStarChartExpanded ; $7a76
	or a, a ; $7a79
	jr z, .checkMenuCursorY3 ; $7a7a
	ld a, [wMenuCursorX] ; $7a7c
	cp a, $02 ; $7a7f
	jr z, .checkMenuCursorX ; $7a81
	ld de, $932f ; $7a83
	ld c, $01 ; $7a86
	call ApplyCursorBounceX ; $7a88
	ld b, $08 ; $7a8b
	ld c, $00 ; $7a8d
	ld h, $00 ; $7a8f
	farcall QueueStackedSpritePair ; $7a91
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $7a94
	or a, a ; $7a97
	jr z, .checkMenuCursorY ; $7a98
	ld de, $082f ; $7a9a
	ld c, $00 ; $7a9d
	call ApplyCursorBounceX ; $7a9f
	ld b, $08 ; $7aa2
	ld c, $00 ; $7aa4
	ld h, $01 ; $7aa6
	farcall QueueStackedSpritePair ; $7aa8
.checkMenuCursorY:
	ld a, [wMenuCursorY] ; $7aab
	or a, a ; $7aae
	jr z, .checkMenuCursorY2 ; $7aaf
	ld de, $0a20 ; $7ab1
	ld c, $01 ; $7ab4
	call ApplyCursorBounceY ; $7ab6
	ld b, $08 ; $7ab9
	ld c, $00 ; $7abb
	ld h, $02 ; $7abd
	farcall QueueStackedSpritePair ; $7abf
.checkMenuCursorY2:
	ld a, [wMenuCursorY] ; $7ac2
	cp a, $05 ; $7ac5
	jr z, .eq05 ; $7ac7
	ld de, $0a78 ; $7ac9
	ld c, $00 ; $7acc
	call ApplyCursorBounceY ; $7ace
	ld b, $08 ; $7ad1
	ld c, $00 ; $7ad3
	ld h, $03 ; $7ad5
	farcall QueueStackedSpritePair ; $7ad7
.eq05:
	jr .restore ; $7ada
.checkMenuCursorY3:
	ld a, [wMenuCursorY] ; $7adc
	or a, a ; $7adf
	jr z, .checkMenuCursorY4 ; $7ae0
	ld de, $1a20 ; $7ae2
	ld c, $01 ; $7ae5
	call ApplyCursorBounceY ; $7ae7
	ld b, $08 ; $7aea
	ld c, $00 ; $7aec
	ld h, $02 ; $7aee
	farcall QueueStackedSpritePair ; $7af0
.checkMenuCursorY4:
	ld a, [wMenuCursorY] ; $7af3
	cp a, $01 ; $7af6
	jr z, .restore ; $7af8
	ld de, $1a78 ; $7afa
	ld c, $00 ; $7afd
	call ApplyCursorBounceY ; $7aff
	ld b, $08 ; $7b02
	ld c, $00 ; $7b04
	ld h, $03 ; $7b06
	farcall QueueStackedSpritePair ; $7b08
.restore:
	pop af ; $7b0b
	wram_bank ; $7b0c
	ret ; $7b10
BuildStarCharExhibScreen:
	wram_bank $03 ; $7b11
	xor a, a ; $7b17
	ld [$dc13], a ; $7b18
	ld [$dc12], a ; $7b1b
	ld c, $0c ; $7b1e
	farcall LoadScreenAssetRecord ; $7b20
	ld de, $aac0 ; $7b23
	call LoadChartWindowTiles ; $7b26
	ld de, $a000 ; $7b29
	farcall LoadMenuArrowSpriteTiles ; $7b2c
	ld b, $08 ; $7b2f
	ld c, $0f ; $7b31
	farcall LoadIndexedPalette ; $7b33
	wram_bank $03 ; $7b36
	call BuildStarChartColumnList ; $7b3c
	call LoadStarCharExhibGrid ; $7b3f
	call ApplyStarChartReducedLayout ; $7b42
	call InitChartRowFlags ; $7b45
	call RedrawStarChartWindow ; $7b48
	farcall QueueWram3MapToVRAM ; $7b4b
	ret ; $7b4e
ScrollStarChartCursorFull:
	ld a, [wMenuInputPressed] ; $7b4f
	bit PADB_LEFT, a ; $7b52
	jr z, .checkMenuCursorX ; $7b54
	ld a, [wMenuCursorX] ; $7b56
	or a, a ; $7b59
	jr z, .done ; $7b5a
	dec a ; $7b5c
	ld [wMenuCursorX], a ; $7b5d
	sound $5e ; $7b60
	call RedrawStarChartWindow ; $7b62
	call FlushStarChartWindowToVram ; $7b65
	jr .done ; $7b68
.checkMenuCursorX:
	bit 4, a ; $7b6a
	jr z, .bit4Clear ; $7b6c
	ld a, [wMenuCursorX] ; $7b6e
	cp a, $02 ; $7b71
	jr z, .done ; $7b73
	inc a ; $7b75
	ld [wMenuCursorX], a ; $7b76
	sound $5e ; $7b79
	call RedrawStarChartWindow ; $7b7b
	call FlushStarChartWindowToVram ; $7b7e
	jr .done ; $7b81
.bit4Clear:
	bit 6, a ; $7b83
	jr z, .bit6Clear ; $7b85
	ld a, [wMenuCursorY] ; $7b87
	or a, a ; $7b8a
	jr z, .done ; $7b8b
	dec a ; $7b8d
	ld [wMenuCursorY], a ; $7b8e
	sound $5e ; $7b91
	call RedrawStarChartWindow ; $7b93
	call FlushStarChartWindowToVram ; $7b96
	jr .done ; $7b99
.bit6Clear:
	bit 7, a ; $7b9b
	jr z, .done ; $7b9d
	ld a, [wMenuCursorY] ; $7b9f
	cp a, $05 ; $7ba2
	jr z, .done ; $7ba4
	inc a ; $7ba6
	ld [wMenuCursorY], a ; $7ba7
	sound $5e ; $7baa
	call RedrawStarChartWindow ; $7bac
	call FlushStarChartWindowToVram ; $7baf
	jr .done ; $7bb2
.done:
	ret ; $7bb4
ScrollStarChartCursorSmall:
	ld a, [wMenuInputPressed] ; $7bb5
	bit PADB_UP, a ; $7bb8
	jr z, .checkMenuCursorY ; $7bba
	ld a, [wMenuCursorY] ; $7bbc
	or a, a ; $7bbf
	jr z, .done ; $7bc0
	dec a ; $7bc2
	ld [wMenuCursorY], a ; $7bc3
	sound $5e ; $7bc6
	call RedrawStarChartWindow ; $7bc8
	call FlushStarChartWindowToVram ; $7bcb
	jr .done ; $7bce
.checkMenuCursorY:
	bit 7, a ; $7bd0
	jr z, .done ; $7bd2
	ld a, [wMenuCursorY] ; $7bd4
	cp a, $01 ; $7bd7
	jr z, .done ; $7bd9
	inc a ; $7bdb
	ld [wMenuCursorY], a ; $7bdc
	sound $5e ; $7bdf
	call RedrawStarChartWindow ; $7be1
	call FlushStarChartWindowToVram ; $7be4
	jr .done ; $7be7
.done:
	ret ; $7be9
RedrawStarChartWindow:
	wram_bank $03 ; $7bea
	call CheckStarChartExpanded ; $7bf0
	or a, a ; $7bf3
	jr z, .compact ; $7bf4
	ld bc, $d0a4 ; $7bf6
	ld a, [wMenuCursorX] ; $7bf9
	ld hl, $dc01 ; $7bfc
	add a, l ; $7bff
	ld l, a ; $7c00
	jr nc, .wideRow ; $7c01
	inc h ; $7c03
.wideRow:
	ld a, $07 ; $7c04
	call DrawChartIconRow ; $7c06
	ld a, [wMenuCursorY] ; $7c09
	ld hl, $dc01 ; $7c0c
	add a, l ; $7c0f
	ld l, a ; $7c10
	jr nc, .wideColumn ; $7c11
	inc h ; $7c13
.wideColumn:
	ld bc, $d0e2 ; $7c14
	call DrawChartIconColumn ; $7c17
	ld a, [wMenuCursorY] ; $7c1a
	ld hl, $db00 ; $7c1d
	ld de, $0010 ; $7c20
.wideRowLoop:
	or a, a ; $7c23
	jr z, .wideRowFound ; $7c24
	add hl, de ; $7c26
	dec a ; $7c27
	jr .wideRowLoop ; $7c28
.wideRowFound:
	ld a, [wMenuCursorX] ; $7c2a
	add a, l ; $7c2d
	ld l, a ; $7c2e
	jr nc, .wideCells ; $7c2f
	inc h ; $7c31
.wideCells:
	ld de, $d0e4 ; $7c32
	ld a, $07 ; $7c35
	call DrawChartCellRows ; $7c37
	jr .done ; $7c3a
.compact:
	ld bc, $d0a6 ; $7c3c
	ld a, [wMenuCursorX] ; $7c3f
	ld hl, $dc01 ; $7c42
	add a, l ; $7c45
	ld l, a ; $7c46
	jr nc, .compactRow ; $7c47
	inc h ; $7c49
.compactRow:
	ld a, $05 ; $7c4a
	call DrawChartIconRow ; $7c4c
	ld a, [wMenuCursorY] ; $7c4f
	ld hl, $dc01 ; $7c52
	add a, l ; $7c55
	ld l, a ; $7c56
	jr nc, .compactColumn ; $7c57
	inc h ; $7c59
.compactColumn:
	ld bc, $d0e4 ; $7c5a
	call DrawChartIconColumn ; $7c5d
	ld a, [wMenuCursorY] ; $7c60
	ld hl, $db00 ; $7c63
	ld de, $0010 ; $7c66
.compactRowLoop:
	or a, a ; $7c69
	jr z, .compactRowFound ; $7c6a
	add hl, de ; $7c6c
	dec a ; $7c6d
	jr .compactRowLoop ; $7c6e
.compactRowFound:
	ld a, [wMenuCursorX] ; $7c70
	add a, l ; $7c73
	ld l, a ; $7c74
	jr nc, .compactCells ; $7c75
	inc h ; $7c77
.compactCells:
	ld de, $d0e6 ; $7c78
	ld a, $05 ; $7c7b
	call DrawChartCellRows ; $7c7d
.done:
	ret ; $7c80
FlushStarChartWindowToVram:
	ld hl, $d0a0 ; $7c81
	ld de, $98a0 ; $7c84
	ld c, $08 ; $7c87
	call QueueVRAMCopy ; $7c89
	ld hl, $d4a0 ; $7c8c
	ld de, $b8a0 ; $7c8f
	ld c, $08 ; $7c92
	call QueueVRAMCopy ; $7c94
	call AdvanceFrame ; $7c97
	ld hl, $d120 ; $7c9a
	ld de, $9920 ; $7c9d
	ld c, $08 ; $7ca0
	call QueueVRAMCopy ; $7ca2
	ld hl, $d520 ; $7ca5
	ld de, $b920 ; $7ca8
	ld c, $08 ; $7cab
	call QueueVRAMCopy ; $7cad
	call AdvanceFrame ; $7cb0
	ld hl, $d1a0 ; $7cb3
	ld de, $99a0 ; $7cb6
	ld c, $04 ; $7cb9
	call QueueVRAMCopy ; $7cbb
	ld hl, $d5a0 ; $7cbe
	ld de, $b9a0 ; $7cc1
	ld c, $04 ; $7cc4
	call QueueVRAMCopy ; $7cc6
	ret ; $7cc9
BuildStarChartColumnList:
	ld c, $00 ; $7cca
.loop:
	ld hl, $7d03 ; $7ccc
	ld a, c ; $7ccf
	add a, a ; $7cd0
	add a, l ; $7cd1
	ld l, a ; $7cd2
	jr nc, .read ; $7cd3
	inc h ; $7cd5
.read:
	ld a, [hl+] ; $7cd6
	ld d, [hl] ; $7cd7
	ld e, a ; $7cd8
	ld a, d ; $7cd9
	or a, e ; $7cda
	cp a, $ff ; $7cdb
	jr z, .step ; $7cdd
	farcall TestSaveFlag ; $7cdf
	jr nz, .step ; $7ce2
	ld b, $10 ; $7ce4
	jr .step2 ; $7ce6
.step:
	ld hl, $7d15 ; $7ce8
	ld a, c ; $7ceb
	add a, l ; $7cec
	ld l, a ; $7ced
	jr nc, .readB ; $7cee
	inc h ; $7cf0
.readB:
	ld b, [hl] ; $7cf1
.step2:
	ld hl, $dc01 ; $7cf2
	ld a, c ; $7cf5
	add a, l ; $7cf6
	ld l, a ; $7cf7
	jr nc, .store ; $7cf8
	inc h ; $7cfa
.store:
	ld [hl], b ; $7cfb
	inc c ; $7cfc
	ld a, c ; $7cfd
	cp a, $09 ; $7cfe
	jr nz, .loop ; $7d00
	ret ; $7d02
	; $7d03, 18 bytes (records:2)
	dw $01c0 ; record 0
	dw $ffff ; record 1
	dw $01e0 ; record 2
	dw $ffff ; record 3
	dw $0160 ; record 4
	dw $ffff ; record 5
	dw $01a0 ; record 6
	dw $0140 ; record 7
	dw $0180 ; record 8
	; $7d15, 9 bytes (bytes:3)
	db $00, $01, $02 ; 0x00
	db $03, $04, $05 ; 0x03
	db $07, $08, $0c ; 0x06
LoadStarCharExhibGrid:
	ldh a, [hWramBank] ; $7d1e
	push af ; $7d20
	wram_bank $03 ; $7d21
	ld hl, $d900 ; $7d27
	farcall ReadStarVictoryGrid ; $7d2a
	ld hl, $d900 ; $7d2d
	ld de, $db00 ; $7d30
	ld c, $00 ; $7d33
.loop:
	push bc ; $7d35
	push hl ; $7d36
	push de ; $7d37
	ld bc, $0009 ; $7d38
	call CopyMemoryBC ; $7d3b
	pop de ; $7d3e
	ld hl, $0010 ; $7d3f
	add hl, de ; $7d42
	ld d, h ; $7d43
	ld e, l ; $7d44
	pop hl ; $7d45
	ld bc, $0009 ; $7d46
	add hl, bc ; $7d49
	pop bc ; $7d4a
	inc c ; $7d4b
	ld a, c ; $7d4c
	cp a, $09 ; $7d4d
	jr nz, .loop ; $7d4f
	pop af ; $7d51
	wram_bank ; $7d52
	ret ; $7d56
RecordExhibitionVictory:
	ldh a, [hWramBank] ; $7d57
	push af ; $7d59
	wram_bank $03 ; $7d5a
	ld a, [wMatchWinLoseFlag] ; $7d60
	cp a, $ff ; $7d63
	jr z, .restore ; $7d65
	ld de, $002f ; $7d67
	call TestGameFlagByNumber ; $7d6a
	jr nz, .restore ; $7d6d
	ld a, [wPlayer1CurrentMainCharacter] ; $7d6f
	ld c, a ; $7d72
	farcall IsStarCharacter ; $7d73
	or a, a ; $7d76
	jr z, .restore ; $7d77
	ld a, [wPlayer2CurrentMainCharacter] ; $7d79
	ld c, a ; $7d7c
	farcall IsStarCharacter ; $7d7d
	or a, a ; $7d80
	jr z, .restore ; $7d81
	ld a, [wPlayer1CurrentMainCharacter] ; $7d83
	call GetStarCharIndex ; $7d86
	ld d, a ; $7d89
	ld a, [wPlayer2CurrentMainCharacter] ; $7d8a
	call GetStarCharIndex ; $7d8d
	ld e, a ; $7d90
	ld hl, $d900 ; $7d91
	farcall ReadStarVictoryGrid ; $7d94
	ld a, d ; $7d97
	add a, a ; $7d98
	add a, a ; $7d99
	add a, a ; $7d9a
	add a, d ; $7d9b
	add a, e ; $7d9c
	ld hl, $d900 ; $7d9d
	add a, l ; $7da0
	ld l, a ; $7da1
	jr nc, .checkExhibitionModeCPUMainCharacterDifficulty ; $7da2
	inc h ; $7da4
.checkExhibitionModeCPUMainCharacterDifficulty:
	push hl ; $7da5
	ld d, [hl] ; $7da6
	ld a, [wExhibitionModeCPUMainCharacterDifficulty] ; $7da7
	call GetVictoryScore ; $7daa
	pop hl ; $7dad
	cp a, d ; $7dae
	jr c, .restore ; $7daf
	ld [hl], a ; $7db1
	call UpdateStarUnlocks ; $7db2
	ld hl, $d900 ; $7db5
	farcall WriteStarVictoryGrid ; $7db8
.step2:
	jr nz, .step2 ; $7dbb
.restore:
	pop af ; $7dbd
	wram_bank ; $7dbe
	ret ; $7dc2
	ret ; $7dc3
GetVictoryScore:
	ld b, a ; $7dc4
	ld hl, VictoryScoreTable ; $7dc5
	ld a, [$c8a8] ; $7dc8
	or a, a ; $7dcb
	jr z, .zero ; $7dcc
	ld hl, $7ddd ; $7dce
.zero:
	ld a, b ; $7dd1
	add a, l ; $7dd2
	ld l, a ; $7dd3
	jr nc, .read ; $7dd4
	inc h ; $7dd6
.read:
	ld a, [hl] ; $7dd7
	ret ; $7dd8
VictoryScoreTable:
	; $7dd9, 8 bytes (bytes:4)
	db $03, $05, $07, $09 ; 0x00
	db $02, $04, $06, $08 ; 0x04
GetStarCharIndex:
	sub a, $17 ; $7de1
	ld hl, StarCharOrderTable ; $7de3
	add a, l ; $7de6
	ld l, a ; $7de7
	jr nc, .read ; $7de8
	inc h ; $7dea
.read:
	ld a, [hl] ; $7deb
	ret ; $7dec
StarCharOrderTable:
	; $7ded, 9 bytes (bytes:3)
	db $01, $05, $03 ; 0x00
	db $00, $07, $04 ; 0x03
	db $08, $06, $02 ; 0x06
UpdateStarUnlocks:
	ld c, $00 ; $7df6
.loop:
	ld hl, $d900 ; $7df8
	ld a, c ; $7dfb
	add a, a ; $7dfc
	add a, a ; $7dfd
	add a, a ; $7dfe
	add a, c ; $7dff
	add a, l ; $7e00
	ld l, a ; $7e01
	jr nc, .gotPtr ; $7e02
	inc h ; $7e04
.gotPtr:
	ld b, $00 ; $7e05
.loopB:
	ld a, c ; $7e07
	cp a, b ; $7e08
	jr z, .countDone ; $7e09
	ld a, [hl] ; $7e0b
	or a, a ; $7e0c
	jr z, .zero ; $7e0d
.countDone:
	inc hl ; $7e0f
	inc b ; $7e10
	ld a, b ; $7e11
	cp a, $09 ; $7e12
	jr nz, .loopB ; $7e14
	ld de, SAVEFLAG_COURT_WAREHOUSE ; $7e16
	farcall SetSaveFlag ; $7e19
	jr .done ; $7e1c
.zero:
	inc c ; $7e1e
	ld a, c ; $7e1f
	cp a, $09 ; $7e20
	jr nz, .loop ; $7e22
.done:
	ret ; $7e24
CheckStarChartExpanded:
	ldh a, [hWramBank] ; $7e25
	push af ; $7e27
	push bc ; $7e28
	ld b, $10 ; $7e29
	ld a, [$dc07] ; $7e2b
	cp a, $10 ; $7e2e
	jr z, .notExpanded ; $7e30
	pop bc ; $7e32
	pop af ; $7e33
	wram_bank ; $7e34
	ld a, $01 ; $7e38
	ret ; $7e3a
.notExpanded:
	pop bc ; $7e3b
	pop af ; $7e3c
	wram_bank ; $7e3d
	xor a, a ; $7e41
	ret ; $7e42
ApplyStarChartReducedLayout:
	push af ; $7e43
	push bc ; $7e44
	push de ; $7e45
	push hl ; $7e46
	ldh a, [hWramBank] ; $7e47
	push af ; $7e49
	wram_bank $03 ; $7e4a
	call CheckStarChartExpanded ; $7e50
	or a, a ; $7e53
	jr nz, .restore ; $7e54
	call CopyStarChartReducedTilemap ; $7e56
	call FixupStarChartHeaderRow ; $7e59
	call CompactStarChartRows ; $7e5c
.restore:
	pop af ; $7e5f
	wram_bank ; $7e60
	pop hl ; $7e64
	pop de ; $7e65
	pop bc ; $7e66
	pop af ; $7e67
	ret ; $7e68
CopyStarChartReducedTilemap:
	ld hl, $d241 ; $7e69
	ld de, $d081 ; $7e6c
	ld b, $12 ; $7e6f
	ld c, $0c ; $7e71
	farcall CopyTilemapRect ; $7e73
	ld hl, $d641 ; $7e76
	ld de, $d481 ; $7e79
	ld b, $12 ; $7e7c
	ld c, $0c ; $7e7e
	farcall CopyTilemapRect ; $7e80
	ret ; $7e83
FixupStarChartHeaderRow:
	ld a, [$dc06] ; $7e84
	ld [$dc05], a ; $7e87
	ret ; $7e8a
CompactStarChartRows:
	ld hl, $db50 ; $7e8b
	ld de, $db40 ; $7e8e
	ld bc, $0010 ; $7e91
	call CopyMemoryBC ; $7e94
	ld hl, $db05 ; $7e97
	ld de, $db04 ; $7e9a
	ld c, $00 ; $7e9d
.loop:
	ld a, [hl] ; $7e9f
	ld [de], a ; $7ea0
	push bc ; $7ea1
	ld bc, $0010 ; $7ea2
	add hl, bc ; $7ea5
	push hl ; $7ea6
	ld hl, $0010 ; $7ea7
	add hl, de ; $7eaa
	ld d, h ; $7eab
	ld e, l ; $7eac
	pop hl ; $7ead
	pop bc ; $7eae
	inc c ; $7eaf
	ld a, c ; $7eb0
	cp a, $06 ; $7eb1
	jr nz, .loop ; $7eb3
	ret ; $7eb5
	; $7eb6, 330 bytes fill to bank end (linker-padded)
