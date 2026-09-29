	farptr RunCharacterSelectScreen ; $4000
	farptr Unused_38_RunMatchTypeMenu ; $4002
	farptr RunLinkMatchSequence ; $4004
	farptr RunNameEntryScreen ; $4006
	farptr RunExhibitionCharSelectScreen ; $4008
	farptr UpdateMenuCursorFromLinkInput ; $400a
	farptr RunLinkCharSelectScreen ; $400c
	farptr Unused_38_RunMatchTypeMenuLink ; $400e
	farptr RunLinkMatchSequenceAlias1, RunLinkMatchSequence ; $4010
	farptr ApplySpriteBobOffsetX ; $4012
	farptr ApplySpriteBobOffsetY ; $4014
	farptr IsMarioCastCharacter ; $4016
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
	add d ; $4030
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
	add e ; $404a
	ld e, a ; $404b
	ld a, b ; $404c
	add d ; $404d
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
	add c ; $4065
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
	and $0f ; $407d
	ld hl, SpriteBobOffsetXTable ; $407f
	add l ; $4082
	ld l, a ; $4083
	jr nc, .readOffset ; $4084
	inc h ; $4086
.readOffset:
	ld a, [hl] ; $4087
	ld b, a ; $4088
	ld a, c ; $4089
	or a ; $408a
	jr z, .subtract ; $408b
	ld a, b ; $408d
	add d ; $408e
	ld d, a ; $408f
	ret ; $4090
.subtract:
	ld a, d ; $4091
	sub b ; $4092
	ld d, a ; $4093
	ret ; $4094
SpriteBobOffsetXTable:
	; $4095, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
ApplySpriteBobOffsetY:
	ldh a, [hVBlankCounter] ; $40a5
	and $0f ; $40a7
	ld hl, SpriteBobOffsetYTable_38 ; $40a9
	add l ; $40ac
	ld l, a ; $40ad
	jr nc, .readOffset ; $40ae
	inc h ; $40b0
.readOffset:
	ld a, [hl] ; $40b1
	ld b, a ; $40b2
	ld a, c ; $40b3
	or a ; $40b4
	jr z, .subtract ; $40b5
	ld a, b ; $40b7
	add e ; $40b8
	ld e, a ; $40b9
	ret ; $40ba
.subtract:
	ld a, e ; $40bb
	sub b ; $40bc
	ld e, a ; $40bd
	ret ; $40be
SpriteBobOffsetYTable_38:
	; $40bf, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
; Instruction-identical to DrawCornerBrackets_1b, DrawCornerBrackets_3b and DrawCornerBrackets_3e (one copy per bank); a change here belongs in every copy.
	twin draw_corner_brackets, 38 ; $40cf DrawCornerBrackets_38
; Instruction-identical to MoveMenuCursorGrid_3b and MoveMenuCursorGrid_3e (one copy per bank); a change here belongs in every copy.
	twin move_menu_cursor_grid, 38 ; $410a MoveMenuCursorGrid_38
; Instruction-identical to Unused_16_MoveMenuCursorGridFromLinkInput and Unused_3e_MoveMenuCursorGridFromLinkInput (one copy per bank); a change here belongs in every copy.
	twin_in move_menu_cursor_grid_from_link_input, Unused_38_MoveMenuCursorGridFromLinkInput, 38 ; $4188 Unused_38_MoveMenuCursorGridFromLinkInput
; Instruction-identical to Unused_16_MoveMenuCursorGridRemote and Unused_3e_MoveMenuCursorGridRemote (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in move_menu_cursor_grid_remote, Unused_38_MoveMenuCursorGridRemote, 38 ; $4205 Unused_38_MoveMenuCursorGridRemote
Unused_38_MoveMenuCursor2GridRemote:
	ld a, [wMenuCursor2X] ; $42d0
	ld d, a ; $42d3
	ld a, [wMenuCursor2Y] ; $42d4
	ld e, a ; $42d7
	ldh a, [hLinkState] ; $42d8
	cp LINKSTATE_SLAVE ; $42da
	jr z, .asSlave ; $42dc
	cp LINKSTATE_MASTER ; $42de
	jr z, .asMaster ; $42e0
	call LinkErrorReset ; $42e2
.asMaster:
	ldh a, [hLinkRemoteInput] ; $42e5
	jr .haveInput2 ; $42e7
.asSlave:
	ldh a, [hLinkRemoteInputBuf] ; $42e9
.haveInput2:
	ld h, a ; $42eb
	ld a, [wMenuCursorLockFlags] ; $42ec
	and $02 ; $42ef
	ld a, h ; $42f1
	jr nz, .checkLock2 ; $42f2
	bit 4, a ; $42f4
	jr z, .checkLeft2 ; $42f6
	ld a, [wMenuCursor2X] ; $42f8
	inc a ; $42fb
	add a ; $42fc
	jr nc, .wrapRight2 ; $42fd
	ld a, b ; $42ff
	dec a ; $4300
	jr .storeRight2 ; $4301
.wrapRight2:
	rra ; $4303
	cp b ; $4304
	jr c, .storeRight2 ; $4305
	xor a ; $4307
.storeRight2:
	ld [wMenuCursor2X], a ; $4308
	jr .compare2 ; $430b
.checkLeft2:
	bit 5, a ; $430d
	jr z, .checkUp2 ; $430f
	ld a, [wMenuCursor2X] ; $4311
	dec a ; $4314
	add a ; $4315
	jr nc, .wrapLeft2 ; $4316
	ld a, b ; $4318
	dec a ; $4319
	jr .storeLeft2 ; $431a
.wrapLeft2:
	rra ; $431c
	cp b ; $431d
	jr c, .storeLeft2 ; $431e
	xor a ; $4320
.storeLeft2:
	ld [wMenuCursor2X], a ; $4321
	jr .compare2 ; $4324
.checkUp2:
	bit 6, a ; $4326
	jr z, .checkDown2 ; $4328
	ld a, [wMenuCursor2Y] ; $432a
	dec a ; $432d
	add a ; $432e
	jr nc, .wrapUp2 ; $432f
	ld a, c ; $4331
	dec a ; $4332
	jr .storeUp2 ; $4333
.wrapUp2:
	rra ; $4335
	cp c ; $4336
	jr c, .storeUp2 ; $4337
	xor a ; $4339
.storeUp2:
	ld [wMenuCursor2Y], a ; $433a
	jr .compare2 ; $433d
.checkDown2:
	bit 7, a ; $433f
	jr z, .checkLock2 ; $4341
	ld a, [wMenuCursor2Y] ; $4343
	inc a ; $4346
	add a ; $4347
	jr nc, .wrapDown2 ; $4348
	ld a, c ; $434a
	dec a ; $434b
	jr .storeDown2 ; $434c
.wrapDown2:
	rra ; $434e
	cp c ; $434f
	jr c, .storeDown2 ; $4350
	xor a ; $4352
.storeDown2:
	ld [wMenuCursor2Y], a ; $4353
	jr .compare2 ; $4356
.checkLock2:
	bit 0, a ; $4358
	jr z, .checkUnlock2 ; $435a
	ld a, [wMenuCursorLockFlags] ; $435c
	ld b, a ; $435f
	and $02 ; $4360
	jr nz, .compare2 ; $4362
	sound SFX_MENU_SELECT ; $4364
	ld a, b ; $4366
	or $02 ; $4367
	ld [wMenuCursorLockFlags], a ; $4369
	jr .compare2 ; $436c
.checkUnlock2:
	bit 1, a ; $436e
	jr z, .compare2 ; $4370
	sound SFX_MENU_CANCEL ; $4372
	ld a, [wMenuCursorLockFlags] ; $4374
	ld b, a ; $4377
	and $03 ; $4378
	ld a, b ; $437a
	jr nz, .clearLock2 ; $437b
	and $f5 ; $437d
	or $08 ; $437f
	jr .storeLock2 ; $4381
.clearLock2:
	and $fd ; $4383
.storeLock2:
	ld [wMenuCursorLockFlags], a ; $4385
.compare2:
	ld a, [wMenuCursor2X] ; $4388
	cp d ; $438b
	jr nz, .moved2 ; $438c
	ld a, [wMenuCursor2Y] ; $438e
	cp e ; $4391
	jr nz, .moved2 ; $4392
	xor a ; $4394
	ret ; $4395
.moved2:
	ld a, $01 ; $4396
	ret ; $4398
; Instruction-identical to Unused_16_GetMenuCursorIndex, GetMenuCursorIndex_1b, GetMenuCursorIndex_3b and GetMenuCursorIndex_3e (one copy per bank); a change here belongs in every copy.
	twin_in get_menu_cursor_index, GetMenuCursorIndex_38, 38 ; $4399 GetMenuCursorIndex_38
; Instruction-identical to Unused_1b_GetMenuCursorIndexFromPtr (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in get_menu_cursor_index_from_ptr, Unused_38_GetMenuCursorIndexFromPtr, 38 ; $43ab Unused_38_GetMenuCursorIndexFromPtr
; Instruction-identical to Unused_16_SetMenuCursorFromIndex, SetMenuCursorFromIndex_3b and SetMenuCursorFromIndex_3e (one copy per bank); a change here belongs in every copy.
	twin_in set_menu_cursor_from_index, SetMenuCursorFromIndex_38, 38 ; $43bb SetMenuCursorFromIndex_38
; Instruction-identical to Unused_16_SetMenuCursorFromIndexToPtr and Unused_3e_SetMenuCursorFromIndexToPtr (one copy per bank); a change here belongs in every copy.
; Nothing calls this copy.
	twin_in set_menu_cursor_from_index_to_ptr, Unused_38_SetMenuCursorFromIndexToPtr, 38 ; $43cd Unused_38_SetMenuCursorFromIndexToPtr
