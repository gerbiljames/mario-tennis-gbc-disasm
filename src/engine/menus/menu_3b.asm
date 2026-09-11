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
	add d ; $4050
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
	add e ; $406a
	ld e, a ; $406b
	ld a, b ; $406c
	add d ; $406d
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
	add c ; $4085
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
	and $0f ; $409d
	ld hl, CursorBounceXTable ; $409f
	add l ; $40a2
	ld l, a ; $40a3
	jr nc, .readOffset ; $40a4
	inc h ; $40a6
.readOffset:
	ld a, [hl] ; $40a7
	ld b, a ; $40a8
	ld a, c ; $40a9
	or a ; $40aa
	jr z, .subtract ; $40ab
	ld a, b ; $40ad
	add d ; $40ae
	ld d, a ; $40af
	ret ; $40b0
.subtract:
	ld a, d ; $40b1
	sub b ; $40b2
	ld d, a ; $40b3
	ret ; $40b4
CursorBounceXTable:
	; $40b5, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
ApplyCursorBounceY:
	ldh a, [hVBlankCounter] ; $40c5
	and $0f ; $40c7
	ld hl, CursorBounceYTable ; $40c9
	add l ; $40cc
	ld l, a ; $40cd
	jr nc, .readOffset ; $40ce
	inc h ; $40d0
.readOffset:
	ld a, [hl] ; $40d1
	ld b, a ; $40d2
	ld a, c ; $40d3
	or a ; $40d4
	jr z, .subtract ; $40d5
	ld a, b ; $40d7
	add e ; $40d8
	ld e, a ; $40d9
	ret ; $40da
.subtract:
	ld a, e ; $40db
	sub b ; $40dc
	ld e, a ; $40dd
	ret ; $40de
CursorBounceYTable:
	; $40df, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
; Instruction-identical to DrawCornerBrackets_1b, DrawCornerBrackets_38 and DrawCornerBrackets_3e (one copy per bank); a change here belongs in every copy.
DrawCornerBrackets_3b:
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
	add d ; $40fd
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
	add e ; $410d
	ld e, a ; $410e
	ld a, b ; $410f
	add d ; $4110
	ld d, a ; $4111
	push de ; $4112
	ld c, $00 ; $4113
	ld b, $69 ; $4115
	call QueueSprite ; $4117
	pop de ; $411a
	pop bc ; $411b
	pop de ; $411c
	ld a, e ; $411d
	add c ; $411e
	ld e, a ; $411f
	push de ; $4120
	ld c, $00 ; $4121
	ld b, $49 ; $4123
	call QueueSprite ; $4125
	pop de ; $4128
	ret ; $4129
; Instruction-identical to MoveMenuCursorGrid_38 and MoveMenuCursorGrid_3e (one copy per bank); a change here belongs in every copy.
MoveMenuCursorGrid_3b:
	ld a, [wMenuCursorX] ; $412a
	ld d, a ; $412d
	ld a, [wMenuCursorY] ; $412e
	ld e, a ; $4131
	ld a, [wMenuInputPressed] ; $4132
	bit PADB_RIGHT, a ; $4135
	jr z, .checkLeft ; $4137
	ld a, [wMenuCursorX] ; $4139
	inc a ; $413c
	add a ; $413d
	jr nc, .wrapRight ; $413e
	ld a, b ; $4140
	dec a ; $4141
	jr .storeRight ; $4142
.wrapRight:
	rra ; $4144
	cp b ; $4145
	jr c, .storeRight ; $4146
	xor a ; $4148
.storeRight:
	ld [wMenuCursorX], a ; $4149
	jr .compare ; $414c
.checkLeft:
	bit 5, a ; $414e
	jr z, .checkUp ; $4150
	ld a, [wMenuCursorX] ; $4152
	dec a ; $4155
	add a ; $4156
	jr nc, .wrapLeft ; $4157
	ld a, b ; $4159
	dec a ; $415a
	jr .storeLeft ; $415b
.wrapLeft:
	rra ; $415d
	cp b ; $415e
	jr c, .storeLeft ; $415f
	xor a ; $4161
.storeLeft:
	ld [wMenuCursorX], a ; $4162
	jr .compare ; $4165
.checkUp:
	bit 6, a ; $4167
	jr z, .checkDown ; $4169
	ld a, [wMenuCursorY] ; $416b
	dec a ; $416e
	add a ; $416f
	jr nc, .wrapUp ; $4170
	ld a, c ; $4172
	dec a ; $4173
	jr .storeUp ; $4174
.wrapUp:
	rra ; $4176
	cp c ; $4177
	jr c, .storeUp ; $4178
	xor a ; $417a
.storeUp:
	ld [wMenuCursorY], a ; $417b
	jr .compare ; $417e
.checkDown:
	bit 7, a ; $4180
	jr z, .compare ; $4182
	ld a, [wMenuCursorY] ; $4184
	inc a ; $4187
	add a ; $4188
	jr nc, .wrapDown ; $4189
	ld a, c ; $418b
	dec a ; $418c
	jr .storeDown ; $418d
.wrapDown:
	rra ; $418f
	cp c ; $4190
	jr c, .storeDown ; $4191
	xor a ; $4193
.storeDown:
	ld [wMenuCursorY], a ; $4194
.compare:
	ld a, [wMenuCursorX] ; $4197
	cp d ; $419a
	jr nz, .moved ; $419b
	ld a, [wMenuCursorY] ; $419d
	cp e ; $41a0
	jr nz, .moved ; $41a1
	xor a ; $41a3
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
	add a ; $41ba
	jr nc, .noCarry ; $41bb
	ld a, b ; $41bd
	dec a ; $41be
	jr .store ; $41bf
.noCarry:
	rra ; $41c1
	cp b ; $41c2
	jr c, .store ; $41c3
	xor a ; $41c5
.store:
	ld [wMenuCursorX], a ; $41c6
	jr .checkMenuCursorX ; $41c9
.bit4Clear:
	bit 5, a ; $41cb
	jr z, .bit5Clear ; $41cd
	ld a, [wMenuCursorX] ; $41cf
	dec a ; $41d2
	add a ; $41d3
	jr nc, .noCarry2 ; $41d4
	ld a, b ; $41d6
	dec a ; $41d7
	jr .store2 ; $41d8
.noCarry2:
	rra ; $41da
	cp b ; $41db
	jr c, .store2 ; $41dc
	xor a ; $41de
.store2:
	ld [wMenuCursorX], a ; $41df
	jr .checkMenuCursorX ; $41e2
.bit5Clear:
	bit 6, a ; $41e4
	jr z, .bit6Clear ; $41e6
	ld a, [wMenuCursorY] ; $41e8
	dec a ; $41eb
	add a ; $41ec
	jr nc, .noCarry3 ; $41ed
	ld a, c ; $41ef
	dec a ; $41f0
	jr .store3 ; $41f1
.noCarry3:
	rra ; $41f3
	cp c ; $41f4
	jr c, .store3 ; $41f5
	xor a ; $41f7
.store3:
	ld [wMenuCursorY], a ; $41f8
	jr .checkMenuCursorX ; $41fb
.bit6Clear:
	bit 7, a ; $41fd
	jr z, .checkMenuCursorX ; $41ff
	ld a, [wMenuCursorY] ; $4201
	inc a ; $4204
	add a ; $4205
	jr nc, .noCarry4 ; $4206
	ld a, c ; $4208
	dec a ; $4209
	jr .store4 ; $420a
.noCarry4:
	rra ; $420c
	cp c ; $420d
	jr c, .store4 ; $420e
	xor a ; $4210
.store4:
	ld [wMenuCursorY], a ; $4211
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $4214
	cp d ; $4217
	jr nz, .checkMenuCursorX2 ; $4218
	ld a, [wMenuCursorY] ; $421a
	cp e ; $421d
	jr nz, .checkMenuCursorX2 ; $421e
	xor a ; $4220
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
	cp LINKSTATE_SLAVE ; $422f
	jr z, .eq02 ; $4231
	cp LINKSTATE_MASTER ; $4233
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
	and $01 ; $4244
	ld a, h ; $4246
	jr nz, .checkMenuCursorLockFlags2 ; $4247
	bit 4, a ; $4249
	jr z, .bit4Clear ; $424b
	ld a, [wMenuCursorX] ; $424d
	inc a ; $4250
	add a ; $4251
	jr nc, .noCarry ; $4252
	ld a, b ; $4254
	dec a ; $4255
	jr .store ; $4256
.noCarry:
	rra ; $4258
	cp b ; $4259
	jr c, .store ; $425a
	xor a ; $425c
.store:
	ld [wMenuCursorX], a ; $425d
	jr .checkMenuCursorX ; $4260
.bit4Clear:
	bit 5, a ; $4262
	jr z, .bit5Clear ; $4264
	ld a, [wMenuCursorX] ; $4266
	dec a ; $4269
	add a ; $426a
	jr nc, .noCarry2 ; $426b
	ld a, b ; $426d
	dec a ; $426e
	jr .store2 ; $426f
.noCarry2:
	rra ; $4271
	cp b ; $4272
	jr c, .store2 ; $4273
	xor a ; $4275
.store2:
	ld [wMenuCursorX], a ; $4276
	jr .checkMenuCursorX ; $4279
.bit5Clear:
	bit 6, a ; $427b
	jr z, .bit6Clear ; $427d
	ld a, [wMenuCursorY] ; $427f
	dec a ; $4282
	add a ; $4283
	jr nc, .noCarry3 ; $4284
	ld a, c ; $4286
	dec a ; $4287
	jr .store3 ; $4288
.noCarry3:
	rra ; $428a
	cp c ; $428b
	jr c, .store3 ; $428c
	xor a ; $428e
.store3:
	ld [wMenuCursorY], a ; $428f
	jr .checkMenuCursorX ; $4292
.bit6Clear:
	bit 7, a ; $4294
	jr z, .checkMenuCursorLockFlags2 ; $4296
	ld a, [wMenuCursorY] ; $4298
	inc a ; $429b
	add a ; $429c
	jr nc, .noCarry4 ; $429d
	ld a, c ; $429f
	dec a ; $42a0
	jr .store4 ; $42a1
.noCarry4:
	rra ; $42a3
	cp c ; $42a4
	jr c, .store4 ; $42a5
	xor a ; $42a7
.store4:
	ld [wMenuCursorY], a ; $42a8
	jr .checkMenuCursorX ; $42ab
.checkMenuCursorLockFlags2:
	bit 0, a ; $42ad
	jr z, .bit0Clear ; $42af
	sound SFX_MENU_SELECT ; $42b1
	ld a, [wMenuCursorLockFlags] ; $42b3
	ld b, a ; $42b6
	and $01 ; $42b7
	jr nz, .checkMenuCursorX ; $42b9
	sound SFX_MENU_SELECT ; $42bb
	ld a, b ; $42bd
	or $01 ; $42be
	ld [wMenuCursorLockFlags], a ; $42c0
	jr .checkMenuCursorX ; $42c3
.bit0Clear:
	bit 1, a ; $42c5
	jr z, .checkMenuCursorX ; $42c7
	sound SFX_MENU_CANCEL ; $42c9
	ld a, [wMenuCursorLockFlags] ; $42cb
	ld b, a ; $42ce
	and $03 ; $42cf
	ld a, b ; $42d1
	jr nz, .storeMenuCursorLockFlags ; $42d2
	and $fa ; $42d4
	or $04 ; $42d6
	jr .store5 ; $42d8
.storeMenuCursorLockFlags:
	and $fe ; $42da
.store5:
	ld [wMenuCursorLockFlags], a ; $42dc
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $42df
	cp d ; $42e2
	jr nz, .checkMenuCursor2X ; $42e3
	ld a, [wMenuCursorY] ; $42e5
	cp e ; $42e8
	jr nz, .checkMenuCursor2X ; $42e9
	xor a ; $42eb
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
	cp LINKSTATE_SLAVE ; $42fa
	jr z, .eq02 ; $42fc
	cp LINKSTATE_MASTER ; $42fe
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
	and $02 ; $430f
	ld a, h ; $4311
	jr nz, .checkMenuCursorLockFlags2 ; $4312
	bit 4, a ; $4314
	jr z, .bit4Clear ; $4316
	ld a, [wMenuCursor2X] ; $4318
	inc a ; $431b
	add a ; $431c
	jr nc, .noCarry ; $431d
	ld a, b ; $431f
	dec a ; $4320
	jr .store ; $4321
.noCarry:
	rra ; $4323
	cp b ; $4324
	jr c, .store ; $4325
	xor a ; $4327
.store:
	ld [wMenuCursor2X], a ; $4328
	jr .checkMenuCursor2X ; $432b
.bit4Clear:
	bit 5, a ; $432d
	jr z, .bit5Clear ; $432f
	ld a, [wMenuCursor2X] ; $4331
	dec a ; $4334
	add a ; $4335
	jr nc, .noCarry2 ; $4336
	ld a, b ; $4338
	dec a ; $4339
	jr .store2 ; $433a
.noCarry2:
	rra ; $433c
	cp b ; $433d
	jr c, .store2 ; $433e
	xor a ; $4340
.store2:
	ld [wMenuCursor2X], a ; $4341
	jr .checkMenuCursor2X ; $4344
.bit5Clear:
	bit 6, a ; $4346
	jr z, .bit6Clear ; $4348
	ld a, [wMenuCursor2Y] ; $434a
	dec a ; $434d
	add a ; $434e
	jr nc, .noCarry3 ; $434f
	ld a, c ; $4351
	dec a ; $4352
	jr .store3 ; $4353
.noCarry3:
	rra ; $4355
	cp c ; $4356
	jr c, .store3 ; $4357
	xor a ; $4359
.store3:
	ld [wMenuCursor2Y], a ; $435a
	jr .checkMenuCursor2X ; $435d
.bit6Clear:
	bit 7, a ; $435f
	jr z, .checkMenuCursorLockFlags2 ; $4361
	ld a, [wMenuCursor2Y] ; $4363
	inc a ; $4366
	add a ; $4367
	jr nc, .noCarry4 ; $4368
	ld a, c ; $436a
	dec a ; $436b
	jr .store4 ; $436c
.noCarry4:
	rra ; $436e
	cp c ; $436f
	jr c, .store4 ; $4370
	xor a ; $4372
.store4:
	ld [wMenuCursor2Y], a ; $4373
	jr .checkMenuCursor2X ; $4376
.checkMenuCursorLockFlags2:
	bit 0, a ; $4378
	jr z, .bit0Clear ; $437a
	ld a, [wMenuCursorLockFlags] ; $437c
	ld b, a ; $437f
	and $02 ; $4380
	jr nz, .checkMenuCursor2X ; $4382
	sound SFX_MENU_SELECT ; $4384
	ld a, b ; $4386
	or $02 ; $4387
	ld [wMenuCursorLockFlags], a ; $4389
	jr .checkMenuCursor2X ; $438c
.bit0Clear:
	bit 1, a ; $438e
	jr z, .checkMenuCursor2X ; $4390
	sound SFX_MENU_CANCEL ; $4392
	ld a, [wMenuCursorLockFlags] ; $4394
	ld b, a ; $4397
	and $03 ; $4398
	ld a, b ; $439a
	jr nz, .storeMenuCursorLockFlags ; $439b
	and $f5 ; $439d
	or $08 ; $439f
	jr .store5 ; $43a1
.storeMenuCursorLockFlags:
	and $fd ; $43a3
.store5:
	ld [wMenuCursorLockFlags], a ; $43a5
.checkMenuCursor2X:
	ld a, [wMenuCursor2X] ; $43a8
	cp d ; $43ab
	jr nz, .checkMenuCursorY ; $43ac
	ld a, [wMenuCursor2Y] ; $43ae
	cp e ; $43b1
	jr nz, .checkMenuCursorY ; $43b2
	xor a ; $43b4
	ret ; $43b5
.checkMenuCursorY:
	ld a, $01 ; $43b6
	ret ; $43b8
; Instruction-identical to GetMenuCursorIndex_16, GetMenuCursorIndex_1b, GetMenuCursorIndex_38 and GetMenuCursorIndex_3e (one copy per bank); a change here belongs in every copy.
GetMenuCursorIndex_3b:
	ld a, [wMenuCursorY] ; $43b9
	ld b, a ; $43bc
	xor a ; $43bd
	inc b ; $43be
.mulLoop:
	dec b ; $43bf
	jr z, .addColumn ; $43c0
	add c ; $43c2
	jr .mulLoop ; $43c3
.addColumn:
	ld b, a ; $43c5
	ld a, [wMenuCursorX] ; $43c6
	add b ; $43c9
	ret ; $43ca
