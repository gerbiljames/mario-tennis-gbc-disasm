DrawMenuCursorCorners:
	push de ; $4040
	push bc ; $4041
	ld c, $00 ; $4042
	call ApplyCursorBobOffsetX ; $4044
	ld c, $00 ; $4047
	call ApplyArrowBobOffset ; $4049
	ld c, $00 ; $404c
	ld b, $08 ; $404e
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
	call ApplyCursorBobOffsetX ; $405d
	ld c, $00 ; $4060
	call ApplyArrowBobOffset ; $4062
	ld c, $00 ; $4065
	ld b, $28 ; $4067
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
	call ApplyCursorBobOffsetX ; $407a
	ld c, $01 ; $407d
	call ApplyArrowBobOffset ; $407f
	ld c, $00 ; $4082
	ld b, $68 ; $4084
	call QueueSprite ; $4086
	pop de ; $4089
	pop bc ; $408a
	pop de ; $408b
	ld a, e ; $408c
	add c ; $408d
	ld e, a ; $408e
	push de ; $408f
	ld c, $00 ; $4090
	call ApplyCursorBobOffsetX ; $4092
	ld c, $01 ; $4095
	call ApplyArrowBobOffset ; $4097
	ld c, $00 ; $409a
	ld b, $48 ; $409c
	call QueueSprite ; $409e
	pop de ; $40a1
	ret ; $40a2
ApplyCursorBobOffsetX:
	ldh a, [hVBlankCounter] ; $40a3
	and $0f ; $40a5
	ld hl, CursorBobOffsetTableX ; $40a7
	add l ; $40aa
	ld l, a ; $40ab
	jr nc, .readOffset ; $40ac
	inc h ; $40ae
.readOffset:
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
	add l ; $40d4
	ld l, a ; $40d5
	jr nc, .readOffset ; $40d6
	inc h ; $40d8
.readOffset:
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
; Instruction-identical to DrawCornerBrackets_38, DrawCornerBrackets_3b and DrawCornerBrackets_3e (one copy per bank); a change here belongs in every copy.
	twin draw_corner_brackets, 1b ; $40f7 DrawCornerBrackets_1b
; Instruction-identical to MoveMenuCursorGrid_17 (one copy per bank); a change here belongs in every copy.
	twin move_menu_cursor_grid_17, 1b ; $4132 MoveMenuCursorGrid_1b
; Instruction-identical to MoveMenuCursorGridFromLinkInput_17 (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin move_menu_cursor_grid_from_link_input_17, 1b ; $41b0 MoveMenuCursorGridFromLinkInput_1b
Unused_1b_MoveMenuCursorGridRemote:
	ld a, [wMenuCursorX] ; $422d
	ld d, a ; $4230
	ld a, [wMenuCursorY] ; $4231
	ld e, a ; $4234
	ldh a, [hLinkState] ; $4235
	cp LINKSTATE_SLAVE ; $4237
	jr z, .eq02 ; $4239
	cp LINKSTATE_MASTER ; $423b
	jr z, .eq01 ; $423d
	call LinkErrorReset ; $423f
.eq01:
	ldh a, [hLinkRemoteInputBuf] ; $4242
	jr .checkMenuCursorLockFlags ; $4244
.eq02:
	ldh a, [hLinkRemoteInput] ; $4246
.checkMenuCursorLockFlags:
	ld h, a ; $4248
	ld a, [wMenuCursorLockFlags] ; $4249
	and $01 ; $424c
	ld a, h ; $424e
	jr nz, .checkMenuCursorLockFlags2 ; $424f
	bit 4, a ; $4251
	jr z, .bit4Clear2 ; $4253
	ld a, [wMenuCursorX] ; $4255
	inc a ; $4258
	add a ; $4259
	jr nc, .noCarry9 ; $425a
	ld a, b ; $425c
	dec a ; $425d
	jr .store9 ; $425e
.noCarry9:
	rra ; $4260
	cp b ; $4261
	jr c, .store9 ; $4262
	xor a ; $4264
.store9:
	ld [wMenuCursorX], a ; $4265
	jr .checkMenuCursorX3 ; $4268
.bit4Clear2:
	bit 5, a ; $426a
	jr z, .bit5Clear3 ; $426c
	ld a, [wMenuCursorX] ; $426e
	dec a ; $4271
	add a ; $4272
	jr nc, .noCarry10 ; $4273
	ld a, b ; $4275
	dec a ; $4276
	jr .store10 ; $4277
.noCarry10:
	rra ; $4279
	cp b ; $427a
	jr c, .store10 ; $427b
	xor a ; $427d
.store10:
	ld [wMenuCursorX], a ; $427e
	jr .checkMenuCursorX3 ; $4281
.bit5Clear3:
	bit 6, a ; $4283
	jr z, .bit6Clear3 ; $4285
	ld a, [wMenuCursorY] ; $4287
	dec a ; $428a
	add a ; $428b
	jr nc, .noCarry11 ; $428c
	ld a, c ; $428e
	dec a ; $428f
	jr .store11 ; $4290
.noCarry11:
	rra ; $4292
	cp c ; $4293
	jr c, .store11 ; $4294
	xor a ; $4296
.store11:
	ld [wMenuCursorY], a ; $4297
	jr .checkMenuCursorX3 ; $429a
.bit6Clear3:
	bit 7, a ; $429c
	jr z, .checkMenuCursorLockFlags2 ; $429e
	ld a, [wMenuCursorY] ; $42a0
	inc a ; $42a3
	add a ; $42a4
	jr nc, .noCarry12 ; $42a5
	ld a, c ; $42a7
	dec a ; $42a8
	jr .store12 ; $42a9
.noCarry12:
	rra ; $42ab
	cp c ; $42ac
	jr c, .store12 ; $42ad
	xor a ; $42af
.store12:
	ld [wMenuCursorY], a ; $42b0
	jr .checkMenuCursorX3 ; $42b3
.checkMenuCursorLockFlags2:
	bit 0, a ; $42b5
	jr z, .bit0Clear ; $42b7
	sound SFX_MENU_SELECT ; $42b9
	ld a, [wMenuCursorLockFlags] ; $42bb
	ld b, a ; $42be
	and $01 ; $42bf
	jr nz, .checkMenuCursorX3 ; $42c1
	sound SFX_MENU_SELECT ; $42c3
	ld a, b ; $42c5
	or $01 ; $42c6
	ld [wMenuCursorLockFlags], a ; $42c8
	jr .checkMenuCursorX3 ; $42cb
.bit0Clear:
	bit 1, a ; $42cd
	jr z, .checkMenuCursorX3 ; $42cf
	sound SFX_MENU_CANCEL ; $42d1
	ld a, [wMenuCursorLockFlags] ; $42d3
	ld b, a ; $42d6
	and $03 ; $42d7
	ld a, b ; $42d9
	jr nz, .storeMenuCursorLockFlags ; $42da
	and $fa ; $42dc
	or $04 ; $42de
	jr .store13 ; $42e0
.storeMenuCursorLockFlags:
	and $fe ; $42e2
.store13:
	ld [wMenuCursorLockFlags], a ; $42e4
.checkMenuCursorX3:
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
	jr .checkMenuCursorLockFlags ; $430f
.asSlave:
	ldh a, [hLinkRemoteInputBuf] ; $4311
.checkMenuCursorLockFlags:
	ld h, a ; $4313
	ld a, [wMenuCursorLockFlags] ; $4314
	and $02 ; $4317
	ld a, h ; $4319
	jr nz, .checkMenuCursorLockFlags2 ; $431a
	bit 4, a ; $431c
	jr z, .bit4Clear ; $431e
	ld a, [wMenuCursor2X] ; $4320
	inc a ; $4323
	add a ; $4324
	jr nc, .noCarry ; $4325
	ld a, b ; $4327
	dec a ; $4328
	jr .store14 ; $4329
.noCarry:
	rra ; $432b
	cp b ; $432c
	jr c, .store14 ; $432d
	xor a ; $432f
.store14:
	ld [wMenuCursor2X], a ; $4330
	jr .checkMenuCursor2X ; $4333
.bit4Clear:
	bit 5, a ; $4335
	jr z, .bit5Clear ; $4337
	ld a, [wMenuCursor2X] ; $4339
	dec a ; $433c
	add a ; $433d
	jr nc, .noCarry2 ; $433e
	ld a, b ; $4340
	dec a ; $4341
	jr .store15 ; $4342
.noCarry2:
	rra ; $4344
	cp b ; $4345
	jr c, .store15 ; $4346
	xor a ; $4348
.store15:
	ld [wMenuCursor2X], a ; $4349
	jr .checkMenuCursor2X ; $434c
.bit5Clear:
	bit 6, a ; $434e
	jr z, .bit6Clear ; $4350
	ld a, [wMenuCursor2Y] ; $4352
	dec a ; $4355
	add a ; $4356
	jr nc, .noCarry3 ; $4357
	ld a, c ; $4359
	dec a ; $435a
	jr .store16 ; $435b
.noCarry3:
	rra ; $435d
	cp c ; $435e
	jr c, .store16 ; $435f
	xor a ; $4361
.store16:
	ld [wMenuCursor2Y], a ; $4362
	jr .checkMenuCursor2X ; $4365
.bit6Clear:
	bit 7, a ; $4367
	jr z, .checkMenuCursorLockFlags2 ; $4369
	ld a, [wMenuCursor2Y] ; $436b
	inc a ; $436e
	add a ; $436f
	jr nc, .noCarry4 ; $4370
	ld a, c ; $4372
	dec a ; $4373
	jr .store17 ; $4374
.noCarry4:
	rra ; $4376
	cp c ; $4377
	jr c, .store17 ; $4378
	xor a ; $437a
.store17:
	ld [wMenuCursor2Y], a ; $437b
	jr .checkMenuCursor2X ; $437e
.checkMenuCursorLockFlags2:
	bit 0, a ; $4380
	jr z, .bit0Clear ; $4382
	ld a, [wMenuCursorLockFlags] ; $4384
	ld b, a ; $4387
	and $02 ; $4388
	jr nz, .checkMenuCursor2X ; $438a
	sound SFX_MENU_SELECT ; $438c
	ld a, b ; $438e
	or $02 ; $438f
	ld [wMenuCursorLockFlags], a ; $4391
	jr .checkMenuCursor2X ; $4394
.bit0Clear:
	bit 1, a ; $4396
	jr z, .checkMenuCursor2X ; $4398
	sound SFX_MENU_CANCEL ; $439a
	ld a, [wMenuCursorLockFlags] ; $439c
	ld b, a ; $439f
	and $03 ; $43a0
	ld a, b ; $43a2
	jr nz, .storeMenuCursorLockFlags ; $43a3
	and $f5 ; $43a5
	or $08 ; $43a7
	jr .store18 ; $43a9
.storeMenuCursorLockFlags:
	and $fd ; $43ab
.store18:
	ld [wMenuCursorLockFlags], a ; $43ad
.checkMenuCursor2X:
	ld a, [wMenuCursor2X] ; $43b0
	cp d ; $43b3
	jr nz, .checkMenuCursorY ; $43b4
	ld a, [wMenuCursor2Y] ; $43b6
	cp e ; $43b9
	jr nz, .checkMenuCursorY ; $43ba
	xor a ; $43bc
	ret ; $43bd
.checkMenuCursorY:
	ld a, $01 ; $43be
	ret ; $43c0
; Instruction-identical to GetMenuCursorIndex_16, GetMenuCursorIndex_38, GetMenuCursorIndex_3b and GetMenuCursorIndex_3e (one copy per bank); a change here belongs in every copy.
	twin get_menu_cursor_index, 1b ; $43c1 GetMenuCursorIndex_1b
; Instruction-identical to GetMenuCursorIndexFromPtr_38 (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin get_menu_cursor_index_from_ptr, 1b ; $43d3 GetMenuCursorIndexFromPtr_1b
SetMenuCursorFromIndex:
	ld d, $00 ; $43e3
	ld a, c ; $43e5
.loop:
	cp b ; $43e6
	jr c, .store ; $43e7
	inc d ; $43e9
	sub b ; $43ea
	jr .loop ; $43eb
.store:
	ld [wMenuCursorX], a ; $43ed
	ld a, d ; $43f0
	ld [wMenuCursorY], a ; $43f1
	ret ; $43f4
Unused_1b_SetMenuCursorFromIndexToPtr:
	ld d, $00 ; $43f5
	ld a, c ; $43f7
.loopB:
	cp b ; $43f8
	jr c, .store2 ; $43f9
	inc d ; $43fb
	sub b ; $43fc
	jr .loopB ; $43fd
.store2:
	ld [hl+], a ; $43ff
	ld a, d ; $4400
	ld [hl], a ; $4401
	ret ; $4402
