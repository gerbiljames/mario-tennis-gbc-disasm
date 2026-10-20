Unused_1b_DrawMenuCursorCorners:
	push de ; $4040
	push bc ; $4041
	ld c, $00 ; $4042
	call Unused_1b_ApplyCursorBobOffsetX ; $4044
	ld c, $00 ; $4047
	call ApplyArrowBobOffset ; $4049
	sprite_tile_attr $00, OAM_BANK1 ; $404c
	call QueueSprite ; $4050
	pop bc ; $4053
	pop de ; $4054
	push de ; $4055
	push bc ; $4056
	ld a, b ; $4057
	add d ; $4058
	ld d, a ; $4059
	push de ; $405a
	ld c, $01 ; $405b
	call Unused_1b_ApplyCursorBobOffsetX ; $405d
	ld c, $00 ; $4060
	call ApplyArrowBobOffset ; $4062
	sprite_tile_attr $00, OAM_BANK1 | OAM_XFLIP ; $4065
	call QueueSprite ; $4069
	pop de ; $406c
	pop bc ; $406d
	pop de ; $406e
	push de ; $406f
	push bc ; $4070
	ld a, c ; $4071
	add e ; $4072
	ld e, a ; $4073
	ld a, b ; $4074
	add d ; $4075
	ld d, a ; $4076
	push de ; $4077
	ld c, $01 ; $4078
	call Unused_1b_ApplyCursorBobOffsetX ; $407a
	ld c, $01 ; $407d
	call ApplyArrowBobOffset ; $407f
	sprite_tile_attr $00, OAM_BANK1 | OAM_XFLIP | OAM_YFLIP ; $4082
	call QueueSprite ; $4086
	pop de ; $4089
	pop bc ; $408a
	pop de ; $408b
	ld a, e ; $408c
	add c ; $408d
	ld e, a ; $408e
	push de ; $408f
	ld c, $00 ; $4090
	call Unused_1b_ApplyCursorBobOffsetX ; $4092
	ld c, $01 ; $4095
	call ApplyArrowBobOffset ; $4097
	sprite_tile_attr $00, OAM_BANK1 | OAM_YFLIP ; $409a
	call QueueSprite ; $409e
	pop de ; $40a1
	ret ; $40a2
Unused_1b_ApplyCursorBobOffsetX:
	ldh a, [hVBlankCounter] ; $40a3
	and $0f ; $40a5
	ld hl, CursorBobOffsetTableX ; $40a7
	add_hl_a ; $40aa
	ld a, [hl] ; $40af
	ld b, a ; $40b0
	ld a, c ; $40b1
	or a ; $40b2
	jr z, .subtract ; $40b3
	ld a, b ; $40b5
	add d ; $40b6
	ld d, a ; $40b7
	ret ; $40b8
.subtract:
	ld a, d ; $40b9
	sub b ; $40ba
	ld d, a ; $40bb
	ret ; $40bc
CursorBobOffsetTableX:
	; $40bd, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
ApplyArrowBobOffset:
	ldh a, [hVBlankCounter] ; $40cd
	and $0f ; $40cf
	ld hl, ArrowBobOffsetTable_1b ; $40d1
	add_hl_a ; $40d4
	ld a, [hl] ; $40d9
	ld b, a ; $40da
	ld a, c ; $40db
	or a ; $40dc
	jr z, .subtract ; $40dd
	ld a, b ; $40df
	add e ; $40e0
	ld e, a ; $40e1
	ret ; $40e2
.subtract:
	ld a, e ; $40e3
	sub b ; $40e4
	ld e, a ; $40e5
	ret ; $40e6
ArrowBobOffsetTable_1b:
	; $40e7, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
	twin_in draw_corner_brackets, Unused_1b_DrawCornerBrackets, 1b ; $40f7 Unused_1b_DrawCornerBrackets
	twin_in move_menu_cursor_grid_17, MoveMenuCursorGrid_1b, 1b ; $4132 MoveMenuCursorGrid_1b
	twin_in move_menu_cursor_grid_from_link_input_17, Unused_1b_MoveMenuCursorGridFromLinkInput, 1b ; $41b0 Unused_1b_MoveMenuCursorGridFromLinkInput
Unused_1b_MoveMenuCursorGridRemote:
	ld a, [wMenuCursorX] ; $422d
	ld d, a ; $4230
	ld a, [wMenuCursorY] ; $4231
	ld e, a ; $4234
	ldh a, [hLinkState] ; $4235
	cp LINKSTATE_SLAVE ; $4237
	jr z, .asSlave ; $4239
	cp LINKSTATE_MASTER ; $423b
	jr z, .asMaster ; $423d
	call LinkErrorReset ; $423f
.asMaster:
	ldh a, [hLinkRemoteInputBuf] ; $4242
	jr .gotInput ; $4244
.asSlave:
	ldh a, [hLinkRemoteInput] ; $4246
.gotInput:
	ld h, a ; $4248
	ld a, [wMenuCursorLockFlags] ; $4249
	and $01 ; $424c
	ld a, h ; $424e
	jr nz, .checkA ; $424f
	bit PADB_RIGHT, a ; $4251
	jr z, .checkLeft ; $4253
	ld a, [wMenuCursorX] ; $4255
	inc a ; $4258
	add a ; $4259
	jr nc, .checkMaxRight ; $425a
	ld a, b ; $425c
	dec a ; $425d
	jr .storeRight ; $425e
.checkMaxRight:
	rra ; $4260
	cp b ; $4261
	jr c, .storeRight ; $4262
	xor a ; $4264
.storeRight:
	ld [wMenuCursorX], a ; $4265
	jr .checkMoved ; $4268
.checkLeft:
	bit PADB_LEFT, a ; $426a
	jr z, .checkUp ; $426c
	ld a, [wMenuCursorX] ; $426e
	dec a ; $4271
	add a ; $4272
	jr nc, .checkMaxLeft ; $4273
	ld a, b ; $4275
	dec a ; $4276
	jr .storeLeft ; $4277
.checkMaxLeft:
	rra ; $4279
	cp b ; $427a
	jr c, .storeLeft ; $427b
	xor a ; $427d
.storeLeft:
	ld [wMenuCursorX], a ; $427e
	jr .checkMoved ; $4281
.checkUp:
	bit PADB_UP, a ; $4283
	jr z, .checkDown ; $4285
	ld a, [wMenuCursorY] ; $4287
	dec a ; $428a
	add a ; $428b
	jr nc, .checkMaxUp ; $428c
	ld a, c ; $428e
	dec a ; $428f
	jr .storeUp ; $4290
.checkMaxUp:
	rra ; $4292
	cp c ; $4293
	jr c, .storeUp ; $4294
	xor a ; $4296
.storeUp:
	ld [wMenuCursorY], a ; $4297
	jr .checkMoved ; $429a
.checkDown:
	bit PADB_DOWN, a ; $429c
	jr z, .checkA ; $429e
	ld a, [wMenuCursorY] ; $42a0
	inc a ; $42a3
	add a ; $42a4
	jr nc, .checkMaxDown ; $42a5
	ld a, c ; $42a7
	dec a ; $42a8
	jr .storeDown ; $42a9
.checkMaxDown:
	rra ; $42ab
	cp c ; $42ac
	jr c, .storeDown ; $42ad
	xor a ; $42af
.storeDown:
	ld [wMenuCursorY], a ; $42b0
	jr .checkMoved ; $42b3
.checkA:
	bit PADB_A, a ; $42b5
	jr z, .checkB ; $42b7
	sound SFX_MENU_SELECT ; $42b9
	ld a, [wMenuCursorLockFlags] ; $42bb
	ld b, a ; $42be
	and $01 ; $42bf
	jr nz, .checkMoved ; $42c1
	sound SFX_MENU_SELECT ; $42c3
	ld a, b ; $42c5
	or $01 ; $42c6
	ld [wMenuCursorLockFlags], a ; $42c8
	jr .checkMoved ; $42cb
.checkB:
	bit PADB_B, a ; $42cd
	jr z, .checkMoved ; $42cf
	sound SFX_MENU_CANCEL ; $42d1
	ld a, [wMenuCursorLockFlags] ; $42d3
	ld b, a ; $42d6
	and $03 ; $42d7
	ld a, b ; $42d9
	jr nz, .unlock ; $42da
	and $fa ; $42dc
	or $04 ; $42de
	jr .storeLockFlags ; $42e0
.unlock:
	and $fe ; $42e2
.storeLockFlags:
	ld [wMenuCursorLockFlags], a ; $42e4
.checkMoved:
	ld a, [wMenuCursorX] ; $42e7
	cp d ; $42ea
	jr nz, .returnOne ; $42eb
	ld a, [wMenuCursorY] ; $42ed
	cp e ; $42f0
	jr nz, .returnOne ; $42f1
	xor a ; $42f3
	ret ; $42f4
.returnOne:
	ld a, $01 ; $42f5
	ret ; $42f7
Unused_1b_MoveMenuCursor2GridRemote:
	ld a, [wMenuCursor2X] ; $42f8
	ld d, a ; $42fb
	ld a, [wMenuCursor2Y] ; $42fc
	ld e, a ; $42ff
	ldh a, [hLinkState] ; $4300
	cp LINKSTATE_SLAVE ; $4302
	jr z, .asSlave ; $4304
	cp LINKSTATE_MASTER ; $4306
	jr z, .asMaster ; $4308
	call LinkErrorReset ; $430a
.asMaster:
	ldh a, [hLinkRemoteInput] ; $430d
	jr .gotInput ; $430f
.asSlave:
	ldh a, [hLinkRemoteInputBuf] ; $4311
.gotInput:
	ld h, a ; $4313
	ld a, [wMenuCursorLockFlags] ; $4314
	and $02 ; $4317
	ld a, h ; $4319
	jr nz, .checkA ; $431a
	bit PADB_RIGHT, a ; $431c
	jr z, .checkLeft ; $431e
	ld a, [wMenuCursor2X] ; $4320
	inc a ; $4323
	add a ; $4324
	jr nc, .checkMaxRight ; $4325
	ld a, b ; $4327
	dec a ; $4328
	jr .storeRight ; $4329
.checkMaxRight:
	rra ; $432b
	cp b ; $432c
	jr c, .storeRight ; $432d
	xor a ; $432f
.storeRight:
	ld [wMenuCursor2X], a ; $4330
	jr .checkMoved ; $4333
.checkLeft:
	bit PADB_LEFT, a ; $4335
	jr z, .checkUp ; $4337
	ld a, [wMenuCursor2X] ; $4339
	dec a ; $433c
	add a ; $433d
	jr nc, .checkMaxLeft ; $433e
	ld a, b ; $4340
	dec a ; $4341
	jr .storeLeft ; $4342
.checkMaxLeft:
	rra ; $4344
	cp b ; $4345
	jr c, .storeLeft ; $4346
	xor a ; $4348
.storeLeft:
	ld [wMenuCursor2X], a ; $4349
	jr .checkMoved ; $434c
.checkUp:
	bit PADB_UP, a ; $434e
	jr z, .checkDown ; $4350
	ld a, [wMenuCursor2Y] ; $4352
	dec a ; $4355
	add a ; $4356
	jr nc, .checkMaxUp ; $4357
	ld a, c ; $4359
	dec a ; $435a
	jr .storeUp ; $435b
.checkMaxUp:
	rra ; $435d
	cp c ; $435e
	jr c, .storeUp ; $435f
	xor a ; $4361
.storeUp:
	ld [wMenuCursor2Y], a ; $4362
	jr .checkMoved ; $4365
.checkDown:
	bit PADB_DOWN, a ; $4367
	jr z, .checkA ; $4369
	ld a, [wMenuCursor2Y] ; $436b
	inc a ; $436e
	add a ; $436f
	jr nc, .checkMaxDown ; $4370
	ld a, c ; $4372
	dec a ; $4373
	jr .storeDown ; $4374
.checkMaxDown:
	rra ; $4376
	cp c ; $4377
	jr c, .storeDown ; $4378
	xor a ; $437a
.storeDown:
	ld [wMenuCursor2Y], a ; $437b
	jr .checkMoved ; $437e
.checkA:
	bit PADB_A, a ; $4380
	jr z, .checkB ; $4382
	ld a, [wMenuCursorLockFlags] ; $4384
	ld b, a ; $4387
	and $02 ; $4388
	jr nz, .checkMoved ; $438a
	sound SFX_MENU_SELECT ; $438c
	ld a, b ; $438e
	or $02 ; $438f
	ld [wMenuCursorLockFlags], a ; $4391
	jr .checkMoved ; $4394
.checkB:
	bit PADB_B, a ; $4396
	jr z, .checkMoved ; $4398
	sound SFX_MENU_CANCEL ; $439a
	ld a, [wMenuCursorLockFlags] ; $439c
	ld b, a ; $439f
	and $03 ; $43a0
	ld a, b ; $43a2
	jr nz, .unlock ; $43a3
	and $f5 ; $43a5
	or $08 ; $43a7
	jr .storeLockFlags ; $43a9
.unlock:
	and $fd ; $43ab
.storeLockFlags:
	ld [wMenuCursorLockFlags], a ; $43ad
.checkMoved:
	ld a, [wMenuCursor2X] ; $43b0
	cp d ; $43b3
	jr nz, .returnOne ; $43b4
	ld a, [wMenuCursor2Y] ; $43b6
	cp e ; $43b9
	jr nz, .returnOne ; $43ba
	xor a ; $43bc
	ret ; $43bd
.returnOne:
	ld a, $01 ; $43be
	ret ; $43c0
	twin_in get_menu_cursor_index, GetMenuCursorIndex_1b, 1b ; $43c1 GetMenuCursorIndex_1b
	twin_in get_menu_cursor_index_from_ptr, Unused_1b_GetMenuCursorIndexFromPtr, 1b ; $43d3 Unused_1b_GetMenuCursorIndexFromPtr
SetMenuCursorFromIndex:
	ld d, $00 ; $43e3
	ld a, c ; $43e5
.loop:
	cp b ; $43e6
	jr c, .storeX ; $43e7
	inc d ; $43e9
	sub b ; $43ea
	jr .loop ; $43eb
.storeX:
	ld [wMenuCursorX], a ; $43ed
	ld a, d ; $43f0
	ld [wMenuCursorY], a ; $43f1
	ret ; $43f4
Unused_1b_SetMenuCursorFromIndexToPtr:
	ld d, $00 ; $43f5
	ld a, c ; $43f7
.loop:
	cp b ; $43f8
	jr c, .storeXY ; $43f9
	inc d ; $43fb
	sub b ; $43fc
	jr .loop ; $43fd
.storeXY:
	ld [hl+], a ; $43ff
	ld a, d ; $4400
	ld [hl], a ; $4401
	ret ; $4402
