Unused_3b_QueueBouncingCursorCorners:
	push de ; $4038
	push bc ; $4039
	ld c, $00 ; $403a
	call ApplyCursorBounceX ; $403c
	ld c, $00 ; $403f
	call ApplyCursorBounceY ; $4041
	sprite_tile_attr $00, OAM_BANK1 ; $4044
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
	sprite_tile_attr $00, OAM_BANK1 | OAM_XFLIP ; $405d
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
	sprite_tile_attr $00, OAM_BANK1 | OAM_XFLIP | OAM_YFLIP ; $407a
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
	sprite_tile_attr $00, OAM_BANK1 | OAM_YFLIP ; $4092
	call QueueSprite ; $4096
	pop de ; $4099
	ret ; $409a
ApplyCursorBounceX:
	ldh a, [hVBlankCounter] ; $409b
	and $0f ; $409d
	ld hl, CursorBounceXTable ; $409f
	add_hl_a ; $40a2
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
	add_hl_a ; $40cc
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
	twin_in draw_corner_brackets, Unused_3b_DrawCornerBrackets, 3b ; $40ef Unused_3b_DrawCornerBrackets
	twin move_menu_cursor_grid, 3b ; $412a MoveMenuCursorGrid_3b
Unused_3b_MoveMenuCursorRepeat:
	ld a, [wMenuCursorX] ; $41a8
	ld d, a ; $41ab
	ld a, [wMenuCursorY] ; $41ac
	ld e, a ; $41af
	ldh a, [hLinkInput] ; $41b0
	bit PADB_RIGHT, a ; $41b2
	jr z, .checkLeft ; $41b4
	ld a, [wMenuCursorX] ; $41b6
	inc a ; $41b9
	add a ; $41ba
	jr nc, .checkMaxRight ; $41bb
	ld a, b ; $41bd
	dec a ; $41be
	jr .storeRight ; $41bf
.checkMaxRight:
	rra ; $41c1
	cp b ; $41c2
	jr c, .storeRight ; $41c3
	xor a ; $41c5
.storeRight:
	ld [wMenuCursorX], a ; $41c6
	jr .checkMoved ; $41c9
.checkLeft:
	bit PADB_LEFT, a ; $41cb
	jr z, .checkUp ; $41cd
	ld a, [wMenuCursorX] ; $41cf
	dec a ; $41d2
	add a ; $41d3
	jr nc, .checkMaxLeft ; $41d4
	ld a, b ; $41d6
	dec a ; $41d7
	jr .storeLeft ; $41d8
.checkMaxLeft:
	rra ; $41da
	cp b ; $41db
	jr c, .storeLeft ; $41dc
	xor a ; $41de
.storeLeft:
	ld [wMenuCursorX], a ; $41df
	jr .checkMoved ; $41e2
.checkUp:
	bit PADB_UP, a ; $41e4
	jr z, .checkDown ; $41e6
	ld a, [wMenuCursorY] ; $41e8
	dec a ; $41eb
	add a ; $41ec
	jr nc, .checkMaxUp ; $41ed
	ld a, c ; $41ef
	dec a ; $41f0
	jr .storeUp ; $41f1
.checkMaxUp:
	rra ; $41f3
	cp c ; $41f4
	jr c, .storeUp ; $41f5
	xor a ; $41f7
.storeUp:
	ld [wMenuCursorY], a ; $41f8
	jr .checkMoved ; $41fb
.checkDown:
	bit PADB_DOWN, a ; $41fd
	jr z, .checkMoved ; $41ff
	ld a, [wMenuCursorY] ; $4201
	inc a ; $4204
	add a ; $4205
	jr nc, .checkMaxDown ; $4206
	ld a, c ; $4208
	dec a ; $4209
	jr .storeDown ; $420a
.checkMaxDown:
	rra ; $420c
	cp c ; $420d
	jr c, .storeDown ; $420e
	xor a ; $4210
.storeDown:
	ld [wMenuCursorY], a ; $4211
.checkMoved:
	ld a, [wMenuCursorX] ; $4214
	cp d ; $4217
	jr nz, .moved ; $4218
	ld a, [wMenuCursorY] ; $421a
	cp e ; $421d
	jr nz, .moved ; $421e
	xor a ; $4220
	ret ; $4221
.moved:
	ld a, $01 ; $4222
	ret ; $4224
Unused_3b_MoveMenuCursorLinkLocal:
	ld a, [wMenuCursorX] ; $4225
	ld d, a ; $4228
	ld a, [wMenuCursorY] ; $4229
	ld e, a ; $422c
	ldh a, [hLinkState] ; $422d
	cp LINKSTATE_SLAVE ; $422f
	jr z, .asSlave ; $4231
	cp LINKSTATE_MASTER ; $4233
	jr z, .asMaster ; $4235
	call LinkErrorReset ; $4237
.asMaster:
	ldh a, [hLinkRemoteInputBuf] ; $423a
	jr .gotInput ; $423c
.asSlave:
	ldh a, [hLinkRemoteInput] ; $423e
.gotInput:
	ld h, a ; $4240
	ld a, [wMenuCursorLockFlags] ; $4241
	and $01 ; $4244
	ld a, h ; $4246
	jr nz, .checkA ; $4247
	bit PADB_RIGHT, a ; $4249
	jr z, .checkLeft ; $424b
	ld a, [wMenuCursorX] ; $424d
	inc a ; $4250
	add a ; $4251
	jr nc, .checkMaxRight ; $4252
	ld a, b ; $4254
	dec a ; $4255
	jr .storeRight ; $4256
.checkMaxRight:
	rra ; $4258
	cp b ; $4259
	jr c, .storeRight ; $425a
	xor a ; $425c
.storeRight:
	ld [wMenuCursorX], a ; $425d
	jr .checkMoved ; $4260
.checkLeft:
	bit PADB_LEFT, a ; $4262
	jr z, .checkUp ; $4264
	ld a, [wMenuCursorX] ; $4266
	dec a ; $4269
	add a ; $426a
	jr nc, .checkMaxLeft ; $426b
	ld a, b ; $426d
	dec a ; $426e
	jr .storeLeft ; $426f
.checkMaxLeft:
	rra ; $4271
	cp b ; $4272
	jr c, .storeLeft ; $4273
	xor a ; $4275
.storeLeft:
	ld [wMenuCursorX], a ; $4276
	jr .checkMoved ; $4279
.checkUp:
	bit PADB_UP, a ; $427b
	jr z, .checkDown ; $427d
	ld a, [wMenuCursorY] ; $427f
	dec a ; $4282
	add a ; $4283
	jr nc, .checkMaxUp ; $4284
	ld a, c ; $4286
	dec a ; $4287
	jr .storeUp ; $4288
.checkMaxUp:
	rra ; $428a
	cp c ; $428b
	jr c, .storeUp ; $428c
	xor a ; $428e
.storeUp:
	ld [wMenuCursorY], a ; $428f
	jr .checkMoved ; $4292
.checkDown:
	bit PADB_DOWN, a ; $4294
	jr z, .checkA ; $4296
	ld a, [wMenuCursorY] ; $4298
	inc a ; $429b
	add a ; $429c
	jr nc, .checkMaxDown ; $429d
	ld a, c ; $429f
	dec a ; $42a0
	jr .storeDown ; $42a1
.checkMaxDown:
	rra ; $42a3
	cp c ; $42a4
	jr c, .storeDown ; $42a5
	xor a ; $42a7
.storeDown:
	ld [wMenuCursorY], a ; $42a8
	jr .checkMoved ; $42ab
.checkA:
	bit PADB_A, a ; $42ad
	jr z, .checkB ; $42af
	sound SFX_MENU_SELECT ; $42b1
	ld a, [wMenuCursorLockFlags] ; $42b3
	ld b, a ; $42b6
	and $01 ; $42b7
	jr nz, .checkMoved ; $42b9
	sound SFX_MENU_SELECT ; $42bb
	ld a, b ; $42bd
	or $01 ; $42be
	ld [wMenuCursorLockFlags], a ; $42c0
	jr .checkMoved ; $42c3
.checkB:
	bit PADB_B, a ; $42c5
	jr z, .checkMoved ; $42c7
	sound SFX_MENU_CANCEL ; $42c9
	ld a, [wMenuCursorLockFlags] ; $42cb
	ld b, a ; $42ce
	and $03 ; $42cf
	ld a, b ; $42d1
	jr nz, .unlock ; $42d2
	and $fa ; $42d4
	or $04 ; $42d6
	jr .storeLockFlags ; $42d8
.unlock:
	and $fe ; $42da
.storeLockFlags:
	ld [wMenuCursorLockFlags], a ; $42dc
.checkMoved:
	ld a, [wMenuCursorX] ; $42df
	cp d ; $42e2
	jr nz, .returnOne ; $42e3
	ld a, [wMenuCursorY] ; $42e5
	cp e ; $42e8
	jr nz, .returnOne ; $42e9
	xor a ; $42eb
	ret ; $42ec
.returnOne:
	ld a, $01 ; $42ed
	ret ; $42ef
Unused_3b_MoveMenuCursorLinkRemote:
	ld a, [wMenuCursor2X] ; $42f0
	ld d, a ; $42f3
	ld a, [wMenuCursor2Y] ; $42f4
	ld e, a ; $42f7
	ldh a, [hLinkState] ; $42f8
	cp LINKSTATE_SLAVE ; $42fa
	jr z, .asSlave ; $42fc
	cp LINKSTATE_MASTER ; $42fe
	jr z, .asMaster ; $4300
	call LinkErrorReset ; $4302
.asMaster:
	ldh a, [hLinkRemoteInput] ; $4305
	jr .gotInput ; $4307
.asSlave:
	ldh a, [hLinkRemoteInputBuf] ; $4309
.gotInput:
	ld h, a ; $430b
	ld a, [wMenuCursorLockFlags] ; $430c
	and $02 ; $430f
	ld a, h ; $4311
	jr nz, .checkA ; $4312
	bit PADB_RIGHT, a ; $4314
	jr z, .checkLeft ; $4316
	ld a, [wMenuCursor2X] ; $4318
	inc a ; $431b
	add a ; $431c
	jr nc, .checkMaxRight ; $431d
	ld a, b ; $431f
	dec a ; $4320
	jr .storeRight ; $4321
.checkMaxRight:
	rra ; $4323
	cp b ; $4324
	jr c, .storeRight ; $4325
	xor a ; $4327
.storeRight:
	ld [wMenuCursor2X], a ; $4328
	jr .checkMoved ; $432b
.checkLeft:
	bit PADB_LEFT, a ; $432d
	jr z, .checkUp ; $432f
	ld a, [wMenuCursor2X] ; $4331
	dec a ; $4334
	add a ; $4335
	jr nc, .checkMaxLeft ; $4336
	ld a, b ; $4338
	dec a ; $4339
	jr .storeLeft ; $433a
.checkMaxLeft:
	rra ; $433c
	cp b ; $433d
	jr c, .storeLeft ; $433e
	xor a ; $4340
.storeLeft:
	ld [wMenuCursor2X], a ; $4341
	jr .checkMoved ; $4344
.checkUp:
	bit PADB_UP, a ; $4346
	jr z, .checkDown ; $4348
	ld a, [wMenuCursor2Y] ; $434a
	dec a ; $434d
	add a ; $434e
	jr nc, .checkMaxUp ; $434f
	ld a, c ; $4351
	dec a ; $4352
	jr .storeUp ; $4353
.checkMaxUp:
	rra ; $4355
	cp c ; $4356
	jr c, .storeUp ; $4357
	xor a ; $4359
.storeUp:
	ld [wMenuCursor2Y], a ; $435a
	jr .checkMoved ; $435d
.checkDown:
	bit PADB_DOWN, a ; $435f
	jr z, .checkA ; $4361
	ld a, [wMenuCursor2Y] ; $4363
	inc a ; $4366
	add a ; $4367
	jr nc, .checkMaxDown ; $4368
	ld a, c ; $436a
	dec a ; $436b
	jr .storeDown ; $436c
.checkMaxDown:
	rra ; $436e
	cp c ; $436f
	jr c, .storeDown ; $4370
	xor a ; $4372
.storeDown:
	ld [wMenuCursor2Y], a ; $4373
	jr .checkMoved ; $4376
.checkA:
	bit PADB_A, a ; $4378
	jr z, .checkB ; $437a
	ld a, [wMenuCursorLockFlags] ; $437c
	ld b, a ; $437f
	and $02 ; $4380
	jr nz, .checkMoved ; $4382
	sound SFX_MENU_SELECT ; $4384
	ld a, b ; $4386
	or $02 ; $4387
	ld [wMenuCursorLockFlags], a ; $4389
	jr .checkMoved ; $438c
.checkB:
	bit PADB_B, a ; $438e
	jr z, .checkMoved ; $4390
	sound SFX_MENU_CANCEL ; $4392
	ld a, [wMenuCursorLockFlags] ; $4394
	ld b, a ; $4397
	and $03 ; $4398
	ld a, b ; $439a
	jr nz, .unlock ; $439b
	and $f5 ; $439d
	or $08 ; $439f
	jr .storeLockFlags ; $43a1
.unlock:
	and $fd ; $43a3
.storeLockFlags:
	ld [wMenuCursorLockFlags], a ; $43a5
.checkMoved:
	ld a, [wMenuCursor2X] ; $43a8
	cp d ; $43ab
	jr nz, .returnOne ; $43ac
	ld a, [wMenuCursor2Y] ; $43ae
	cp e ; $43b1
	jr nz, .returnOne ; $43b2
	xor a ; $43b4
	ret ; $43b5
.returnOne:
	ld a, $01 ; $43b6
	ret ; $43b8
	twin_in get_menu_cursor_index, GetMenuCursorIndex_3b, 3b ; $43b9 GetMenuCursorIndex_3b
