	twin_in apply_sprite_wobble_x, Unused_17_ApplySpriteWobbleX, 17 ; $4079 Unused_17_ApplySpriteWobbleX
SpriteWobbleXTable_17:
	; $4093, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
	twin_in apply_sprite_wobble_y, ApplySpriteWobbleY_17, 17 ; $40a3 ApplySpriteWobbleY_17
SpriteWobbleYTable_17:
	; $40bd, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
Unused_17_DrawCornerBrackets:
	push de ; $40cd
	push bc ; $40ce
	sprite_tile_attr $00, OAM_BANK1 | 1 ; $40cf
	call QueueSprite ; $40d3
	pop bc ; $40d6
	pop de ; $40d7
	push de ; $40d8
	push bc ; $40d9
	ld a, b ; $40da
	add d ; $40db
	ld d, a ; $40dc
	push de ; $40dd
	sprite_tile_attr $00, OAM_BANK1 | OAM_XFLIP | 1 ; $40de
	call QueueSprite ; $40e2
	pop de ; $40e5
	pop bc ; $40e6
	pop de ; $40e7
	push de ; $40e8
	push bc ; $40e9
	ld a, c ; $40ea
	add e ; $40eb
	ld e, a ; $40ec
	ld a, b ; $40ed
	add d ; $40ee
	ld d, a ; $40ef
	push de ; $40f0
	sprite_tile_attr $00, OAM_BANK1 | OAM_XFLIP | OAM_YFLIP | 1 ; $40f1
	call QueueSprite ; $40f5
	pop de ; $40f8
	pop bc ; $40f9
	pop de ; $40fa
	ld a, e ; $40fb
	add c ; $40fc
	ld e, a ; $40fd
	push de ; $40fe
	sprite_tile_attr $00, OAM_BANK1 | OAM_YFLIP | 1 ; $40ff
	call QueueSprite ; $4103
	pop de ; $4106
	ret ; $4107
	twin_in move_menu_cursor_grid_17, Unused_17_MoveMenuCursorGrid, 17 ; $4108 Unused_17_MoveMenuCursorGrid
	twin_in move_menu_cursor_grid_from_link_input_17, Unused_17_MoveMenuCursorGridFromLinkInput, 17 ; $4186 Unused_17_MoveMenuCursorGridFromLinkInput
Unused_17_MoveMenuCursorGridRemote:
	ld a, [wMenuCursorX] ; $4203
	ld d, a ; $4206
	ld a, [wMenuCursorY] ; $4207
	ld e, a ; $420a
	ldh a, [hLinkState] ; $420b
	cp LINKSTATE_SLAVE ; $420d
	jr z, .asSlave ; $420f
	cp LINKSTATE_MASTER ; $4211
	jr z, .asMaster ; $4213
	call LinkErrorReset ; $4215
.asMaster:
	ldh a, [hLinkSentInput] ; $4218
	jr .gotInput ; $421a
.asSlave:
	ldh a, [hLinkRemoteInput] ; $421c
.gotInput:
	ld h, a ; $421e
	ld a, [wMenuCursorLockFlags] ; $421f
	and CURSORLOCKF_PRIMARY ; $4222
	ld a, h ; $4224
	jr nz, .checkA ; $4225
	bit PADB_RIGHT, a ; $4227
	jr z, .checkLeft ; $4229
	ld a, [wMenuCursorX] ; $422b
	inc a ; $422e
	add a ; $422f
	jr nc, .checkMaxRight ; $4230
	ld a, b ; $4232
	dec a ; $4233
	jr .storeRight ; $4234
.checkMaxRight:
	rra ; $4236
	cp b ; $4237
	jr c, .storeRight ; $4238
	xor a ; $423a
.storeRight:
	ld [wMenuCursorX], a ; $423b
	jr .checkMoved ; $423e
.checkLeft:
	bit PADB_LEFT, a ; $4240
	jr z, .checkUp ; $4242
	ld a, [wMenuCursorX] ; $4244
	dec a ; $4247
	add a ; $4248
	jr nc, .checkMaxLeft ; $4249
	ld a, b ; $424b
	dec a ; $424c
	jr .storeLeft ; $424d
.checkMaxLeft:
	rra ; $424f
	cp b ; $4250
	jr c, .storeLeft ; $4251
	xor a ; $4253
.storeLeft:
	ld [wMenuCursorX], a ; $4254
	jr .checkMoved ; $4257
.checkUp:
	bit PADB_UP, a ; $4259
	jr z, .checkDown ; $425b
	ld a, [wMenuCursorY] ; $425d
	dec a ; $4260
	add a ; $4261
	jr nc, .checkMaxUp ; $4262
	ld a, c ; $4264
	dec a ; $4265
	jr .storeUp ; $4266
.checkMaxUp:
	rra ; $4268
	cp c ; $4269
	jr c, .storeUp ; $426a
	xor a ; $426c
.storeUp:
	ld [wMenuCursorY], a ; $426d
	jr .checkMoved ; $4270
.checkDown:
	bit PADB_DOWN, a ; $4272
	jr z, .checkA ; $4274
	ld a, [wMenuCursorY] ; $4276
	inc a ; $4279
	add a ; $427a
	jr nc, .checkMaxDown ; $427b
	ld a, c ; $427d
	dec a ; $427e
	jr .storeDown ; $427f
.checkMaxDown:
	rra ; $4281
	cp c ; $4282
	jr c, .storeDown ; $4283
	xor a ; $4285
.storeDown:
	ld [wMenuCursorY], a ; $4286
	jr .checkMoved ; $4289
.checkA:
	bit PADB_A, a ; $428b
	jr z, .checkB ; $428d
	sound SFX_MENU_SELECT ; $428f
	ld a, [wMenuCursorLockFlags] ; $4291
	ld b, a ; $4294
	and CURSORLOCKF_PRIMARY ; $4295
	jr nz, .checkMoved ; $4297
	sound SFX_MENU_SELECT ; $4299
	ld a, b ; $429b
	or CURSORLOCKF_PRIMARY ; $429c
	ld [wMenuCursorLockFlags], a ; $429e
	jr .checkMoved ; $42a1
.checkB:
	bit PADB_B, a ; $42a3
	jr z, .checkMoved ; $42a5
	sound SFX_MENU_CANCEL ; $42a7
	ld a, [wMenuCursorLockFlags] ; $42a9
	ld b, a ; $42ac
	and CURSORLOCKF_PRIMARY | CURSORLOCKF_SECONDARY ; $42ad
	ld a, b ; $42af
	jr nz, .unlock ; $42b0
	and ~(CURSORLOCKF_PRIMARY | CURSORLOCKF_PRIMARY_CANCEL) ; $42b2
	or CURSORLOCKF_PRIMARY_CANCEL ; $42b4
	jr .storeLockFlags ; $42b6
.unlock:
	and ~CURSORLOCKF_PRIMARY ; $42b8
.storeLockFlags:
	ld [wMenuCursorLockFlags], a ; $42ba
.checkMoved:
	ld a, [wMenuCursorX] ; $42bd
	cp d ; $42c0
	jr nz, .returnOne ; $42c1
	ld a, [wMenuCursorY] ; $42c3
	cp e ; $42c6
	jr nz, .returnOne ; $42c7
	xor a ; $42c9
	ret ; $42ca
.returnOne:
	ld a, $01 ; $42cb
	ret ; $42cd
Unused_17_MoveMenuCursor2GridRemote:
	ld a, [wMenuCursor2X] ; $42ce
	ld d, a ; $42d1
	ld a, [wMenuCursor2Y] ; $42d2
	ld e, a ; $42d5
	ldh a, [hLinkState] ; $42d6
	cp LINKSTATE_SLAVE ; $42d8
	jr z, .asSlave ; $42da
	cp LINKSTATE_MASTER ; $42dc
	jr z, .asMaster ; $42de
	call LinkErrorReset ; $42e0
.asMaster:
	ldh a, [hLinkRemoteInput] ; $42e3
	jr .gotInput ; $42e5
.asSlave:
	ldh a, [hLinkSentInput] ; $42e7
.gotInput:
	ld h, a ; $42e9
	ld a, [wMenuCursorLockFlags] ; $42ea
	and CURSORLOCKF_SECONDARY ; $42ed
	ld a, h ; $42ef
	jr nz, .checkA ; $42f0
	bit PADB_RIGHT, a ; $42f2
	jr z, .checkLeft ; $42f4
	ld a, [wMenuCursor2X] ; $42f6
	inc a ; $42f9
	add a ; $42fa
	jr nc, .checkMaxRight ; $42fb
	ld a, b ; $42fd
	dec a ; $42fe
	jr .storeRight ; $42ff
.checkMaxRight:
	rra ; $4301
	cp b ; $4302
	jr c, .storeRight ; $4303
	xor a ; $4305
.storeRight:
	ld [wMenuCursor2X], a ; $4306
	jr .checkMoved ; $4309
.checkLeft:
	bit PADB_LEFT, a ; $430b
	jr z, .checkUp ; $430d
	ld a, [wMenuCursor2X] ; $430f
	dec a ; $4312
	add a ; $4313
	jr nc, .checkMaxLeft ; $4314
	ld a, b ; $4316
	dec a ; $4317
	jr .storeLeft ; $4318
.checkMaxLeft:
	rra ; $431a
	cp b ; $431b
	jr c, .storeLeft ; $431c
	xor a ; $431e
.storeLeft:
	ld [wMenuCursor2X], a ; $431f
	jr .checkMoved ; $4322
.checkUp:
	bit PADB_UP, a ; $4324
	jr z, .checkDown ; $4326
	ld a, [wMenuCursor2Y] ; $4328
	dec a ; $432b
	add a ; $432c
	jr nc, .checkMaxUp ; $432d
	ld a, c ; $432f
	dec a ; $4330
	jr .storeUp ; $4331
.checkMaxUp:
	rra ; $4333
	cp c ; $4334
	jr c, .storeUp ; $4335
	xor a ; $4337
.storeUp:
	ld [wMenuCursor2Y], a ; $4338
	jr .checkMoved ; $433b
.checkDown:
	bit PADB_DOWN, a ; $433d
	jr z, .checkA ; $433f
	ld a, [wMenuCursor2Y] ; $4341
	inc a ; $4344
	add a ; $4345
	jr nc, .checkMaxDown ; $4346
	ld a, c ; $4348
	dec a ; $4349
	jr .storeDown ; $434a
.checkMaxDown:
	rra ; $434c
	cp c ; $434d
	jr c, .storeDown ; $434e
	xor a ; $4350
.storeDown:
	ld [wMenuCursor2Y], a ; $4351
	jr .checkMoved ; $4354
.checkA:
	bit PADB_A, a ; $4356
	jr z, .checkB ; $4358
	ld a, [wMenuCursorLockFlags] ; $435a
	ld b, a ; $435d
	and CURSORLOCKF_SECONDARY ; $435e
	jr nz, .checkMoved ; $4360
	sound SFX_MENU_SELECT ; $4362
	ld a, b ; $4364
	or CURSORLOCKF_SECONDARY ; $4365
	ld [wMenuCursorLockFlags], a ; $4367
	jr .checkMoved ; $436a
.checkB:
	bit PADB_B, a ; $436c
	jr z, .checkMoved ; $436e
	sound SFX_MENU_CANCEL ; $4370
	ld a, [wMenuCursorLockFlags] ; $4372
	ld b, a ; $4375
	and CURSORLOCKF_PRIMARY | CURSORLOCKF_SECONDARY ; $4376
	ld a, b ; $4378
	jr nz, .unlock ; $4379
	and ~(CURSORLOCKF_SECONDARY | CURSORLOCKF_SECONDARY_CANCEL) ; $437b
	or CURSORLOCKF_SECONDARY_CANCEL ; $437d
	jr .storeLockFlags ; $437f
.unlock:
	and ~CURSORLOCKF_SECONDARY ; $4381
.storeLockFlags:
	ld [wMenuCursorLockFlags], a ; $4383
.checkMoved:
	ld a, [wMenuCursor2X] ; $4386
	cp d ; $4389
	jr nz, .returnOne ; $438a
	ld a, [wMenuCursor2Y] ; $438c
	cp e ; $438f
	jr nz, .returnOne ; $4390
	xor a ; $4392
	ret ; $4393
.returnOne:
	ld a, $01 ; $4394
	ret ; $4396
Unused_17_GetMenuCursorLinearIndex:
	ld a, [wMenuCursorY] ; $4397
	ld b, a ; $439a
	xor a ; $439b
	inc b ; $439c
.loop:
	dec b ; $439d
	jr z, .countDone ; $439e
	add c ; $43a0
	jr .loop ; $43a1
.countDone:
	ld b, a ; $43a3
	ld a, [wMenuCursorX] ; $43a4
	add b ; $43a7
	ret ; $43a8
Unused_17_GetMenuCursorLinearIndexFromPtr:
	push bc ; $43a9
	ld a, [hl-] ; $43aa
	ld b, a ; $43ab
	xor a ; $43ac
	inc b ; $43ad
.loop:
	dec b ; $43ae
	jr z, .countDone2 ; $43af
	add c ; $43b1
	jr .loop ; $43b2
.countDone2:
	ld b, a ; $43b4
	ld a, [hl] ; $43b5
	add b ; $43b6
	pop bc ; $43b7
	ret ; $43b8
; Divides the linear index in c by the row width in b: remainder ->
; wMenuCursorX, quotient -> wMenuCursorY. Twin of
; Unused_17_WriteGridPosFromLinearIndex, which writes through hl instead.
; Nothing calls it.
Unused_17_SetMenuCursorFromLinearIndex:
	ld d, $00 ; $43b9
	ld a, c ; $43bb
.divideLoop:
	cp b ; $43bc
	jr c, .storeX ; $43bd
	inc d ; $43bf
	sub b ; $43c0
	jr .divideLoop ; $43c1
.storeX:
	ld [wMenuCursorX], a ; $43c3
	ld a, d ; $43c6
	ld [wMenuCursorY], a ; $43c7
	ret ; $43ca
