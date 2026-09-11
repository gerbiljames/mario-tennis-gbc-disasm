DrawSelectionBoxCorners:
	push de ; $4048
	push bc ; $4049
	ld c, $00 ; $404a
	call ApplySelectionBoxWobbleX ; $404c
	ld c, $00 ; $404f
	call ApplySelectionBoxWobbleY ; $4051
	ld c, $00 ; $4054
	ld b, $08 ; $4056
	call QueueSprite ; $4058
	pop bc ; $405b
	pop de ; $405c
	push de ; $405d
	push bc ; $405e
	ld a, b ; $405f
	add d ; $4060
	ld d, a ; $4061
	push de ; $4062
	ld c, $01 ; $4063
	call ApplySelectionBoxWobbleX ; $4065
	ld c, $00 ; $4068
	call ApplySelectionBoxWobbleY ; $406a
	ld c, $00 ; $406d
	ld b, $28 ; $406f
	call QueueSprite ; $4071
	pop de ; $4074
	pop bc ; $4075
	pop de ; $4076
	push de ; $4077
	push bc ; $4078
	ld a, c ; $4079
	add e ; $407a
	ld e, a ; $407b
	ld a, b ; $407c
	add d ; $407d
	ld d, a ; $407e
	push de ; $407f
	ld c, $01 ; $4080
	call ApplySelectionBoxWobbleX ; $4082
	ld c, $01 ; $4085
	call ApplySelectionBoxWobbleY ; $4087
	ld c, $00 ; $408a
	ld b, $68 ; $408c
	call QueueSprite ; $408e
	pop de ; $4091
	pop bc ; $4092
	pop de ; $4093
	ld a, e ; $4094
	add c ; $4095
	ld e, a ; $4096
	push de ; $4097
	ld c, $00 ; $4098
	call ApplySelectionBoxWobbleX ; $409a
	ld c, $01 ; $409d
	call ApplySelectionBoxWobbleY ; $409f
	ld c, $00 ; $40a2
	ld b, $48 ; $40a4
	call QueueSprite ; $40a6
	pop de ; $40a9
	ret ; $40aa
ApplySelectionBoxWobbleX:
	ldh a, [hVBlankCounter] ; $40ab
	and $0f ; $40ad
	ld hl, SelectionBoxWobbleXTable_3e ; $40af
	add l ; $40b2
	ld l, a ; $40b3
	jr nc, .readOffset ; $40b4
	inc h ; $40b6
.readOffset:
	ld a, [hl] ; $40b7
	ld b, a ; $40b8
	ld a, c ; $40b9
	or a ; $40ba
	jr z, .subtract ; $40bb
	ld a, b ; $40bd
	add d ; $40be
	ld d, a ; $40bf
	ret ; $40c0
.subtract:
	ld a, d ; $40c1
	sub b ; $40c2
	ld d, a ; $40c3
	ret ; $40c4
SelectionBoxWobbleXTable_3e:
	; $40c5, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
ApplySelectionBoxWobbleY:
	ldh a, [hVBlankCounter] ; $40d5
	and $0f ; $40d7
	ld hl, SelectionBoxWobbleYTable_3e ; $40d9
	add l ; $40dc
	ld l, a ; $40dd
	jr nc, .readOffset ; $40de
	inc h ; $40e0
.readOffset:
	ld a, [hl] ; $40e1
	ld b, a ; $40e2
	ld a, c ; $40e3
	or a ; $40e4
	jr z, .subtract ; $40e5
	ld a, b ; $40e7
	add e ; $40e8
	ld e, a ; $40e9
	ret ; $40ea
.subtract:
	ld a, e ; $40eb
	sub b ; $40ec
	ld e, a ; $40ed
	ret ; $40ee
SelectionBoxWobbleYTable_3e:
	INCBIN "data/bank_03e/SelectionBoxWobbleYTable_3e.bin" ; $40ef, 16 bytes
; Instruction-identical to DrawCornerBrackets_1b, DrawCornerBrackets_38 and DrawCornerBrackets_3b (one copy per bank); a change here belongs in every copy.
DrawCornerBrackets_3e:
	push de ; $40ff
	push bc ; $4100
	ld c, $00 ; $4101
	ld b, $09 ; $4103
	call QueueSprite ; $4105
	pop bc ; $4108
	pop de ; $4109
	push de ; $410a
	push bc ; $410b
	ld a, b ; $410c
	add d ; $410d
	ld d, a ; $410e
	push de ; $410f
	ld c, $00 ; $4110
	ld b, $29 ; $4112
	call QueueSprite ; $4114
	pop de ; $4117
	pop bc ; $4118
	pop de ; $4119
	push de ; $411a
	push bc ; $411b
	ld a, c ; $411c
	add e ; $411d
	ld e, a ; $411e
	ld a, b ; $411f
	add d ; $4120
	ld d, a ; $4121
	push de ; $4122
	ld c, $00 ; $4123
	ld b, $69 ; $4125
	call QueueSprite ; $4127
	pop de ; $412a
	pop bc ; $412b
	pop de ; $412c
	ld a, e ; $412d
	add c ; $412e
	ld e, a ; $412f
	push de ; $4130
	ld c, $00 ; $4131
	ld b, $49 ; $4133
	call QueueSprite ; $4135
	pop de ; $4138
	ret ; $4139
; Instruction-identical to MoveMenuCursorGrid_38 and MoveMenuCursorGrid_3b (one copy per bank); a change here belongs in every copy.
MoveMenuCursorGrid_3e:
	ld a, [wMenuCursorX] ; $413a
	ld d, a ; $413d
	ld a, [wMenuCursorY] ; $413e
	ld e, a ; $4141
	ld a, [wMenuInputPressed] ; $4142
	bit PADB_RIGHT, a ; $4145
	jr z, .checkLeft ; $4147
	ld a, [wMenuCursorX] ; $4149
	inc a ; $414c
	add a ; $414d
	jr nc, .wrapRight ; $414e
	ld a, b ; $4150
	dec a ; $4151
	jr .storeRight ; $4152
.wrapRight:
	rra ; $4154
	cp b ; $4155
	jr c, .storeRight ; $4156
	xor a ; $4158
.storeRight:
	ld [wMenuCursorX], a ; $4159
	jr .compare ; $415c
.checkLeft:
	bit 5, a ; $415e
	jr z, .checkUp ; $4160
	ld a, [wMenuCursorX] ; $4162
	dec a ; $4165
	add a ; $4166
	jr nc, .wrapLeft ; $4167
	ld a, b ; $4169
	dec a ; $416a
	jr .storeLeft ; $416b
.wrapLeft:
	rra ; $416d
	cp b ; $416e
	jr c, .storeLeft ; $416f
	xor a ; $4171
.storeLeft:
	ld [wMenuCursorX], a ; $4172
	jr .compare ; $4175
.checkUp:
	bit 6, a ; $4177
	jr z, .checkDown ; $4179
	ld a, [wMenuCursorY] ; $417b
	dec a ; $417e
	add a ; $417f
	jr nc, .wrapUp ; $4180
	ld a, c ; $4182
	dec a ; $4183
	jr .storeUp ; $4184
.wrapUp:
	rra ; $4186
	cp c ; $4187
	jr c, .storeUp ; $4188
	xor a ; $418a
.storeUp:
	ld [wMenuCursorY], a ; $418b
	jr .compare ; $418e
.checkDown:
	bit 7, a ; $4190
	jr z, .compare ; $4192
	ld a, [wMenuCursorY] ; $4194
	inc a ; $4197
	add a ; $4198
	jr nc, .wrapDown ; $4199
	ld a, c ; $419b
	dec a ; $419c
	jr .storeDown ; $419d
.wrapDown:
	rra ; $419f
	cp c ; $41a0
	jr c, .storeDown ; $41a1
	xor a ; $41a3
.storeDown:
	ld [wMenuCursorY], a ; $41a4
.compare:
	ld a, [wMenuCursorX] ; $41a7
	cp d ; $41aa
	jr nz, .moved ; $41ab
	ld a, [wMenuCursorY] ; $41ad
	cp e ; $41b0
	jr nz, .moved ; $41b1
	xor a ; $41b3
	ret ; $41b4
.moved:
	ld a, $01 ; $41b5
	ret ; $41b7
; Instruction-identical to MoveMenuCursorGridFromLinkInput_16 and MoveMenuCursorGridFromLinkInput_38 (one copy per bank); a change here belongs in every copy.
MoveMenuCursorGridFromLinkInput_3e:
	ld a, [wMenuCursorX] ; $41b8
	ld d, a ; $41bb
	ld a, [wMenuCursorY] ; $41bc
	ld e, a ; $41bf
	ldh a, [hLinkInput] ; $41c0
	bit 4, a ; $41c2
	jr z, .checkLeft ; $41c4
	ld a, [wMenuCursorX] ; $41c6
	inc a ; $41c9
	add a ; $41ca
	jr nc, .wrapRight ; $41cb
	ld a, b ; $41cd
	dec a ; $41ce
	jr .storeRight ; $41cf
.wrapRight:
	rra ; $41d1
	cp b ; $41d2
	jr c, .storeRight ; $41d3
	xor a ; $41d5
.storeRight:
	ld [wMenuCursorX], a ; $41d6
	jr .compare ; $41d9
.checkLeft:
	bit 5, a ; $41db
	jr z, .checkUp ; $41dd
	ld a, [wMenuCursorX] ; $41df
	dec a ; $41e2
	add a ; $41e3
	jr nc, .wrapLeft ; $41e4
	ld a, b ; $41e6
	dec a ; $41e7
	jr .storeLeft ; $41e8
.wrapLeft:
	rra ; $41ea
	cp b ; $41eb
	jr c, .storeLeft ; $41ec
	xor a ; $41ee
.storeLeft:
	ld [wMenuCursorX], a ; $41ef
	jr .compare ; $41f2
.checkUp:
	bit 6, a ; $41f4
	jr z, .checkDown ; $41f6
	ld a, [wMenuCursorY] ; $41f8
	dec a ; $41fb
	add a ; $41fc
	jr nc, .wrapUp ; $41fd
	ld a, c ; $41ff
	dec a ; $4200
	jr .storeUp ; $4201
.wrapUp:
	rra ; $4203
	cp c ; $4204
	jr c, .storeUp ; $4205
	xor a ; $4207
.storeUp:
	ld [wMenuCursorY], a ; $4208
	jr .compare ; $420b
.checkDown:
	bit 7, a ; $420d
	jr z, .compare ; $420f
	ld a, [wMenuCursorY] ; $4211
	inc a ; $4214
	add a ; $4215
	jr nc, .wrapDown ; $4216
	ld a, c ; $4218
	dec a ; $4219
	jr .storeDown ; $421a
.wrapDown:
	rra ; $421c
	cp c ; $421d
	jr c, .storeDown ; $421e
	xor a ; $4220
.storeDown:
	ld [wMenuCursorY], a ; $4221
.compare:
	ld a, [wMenuCursorX] ; $4224
	cp d ; $4227
	jr nz, .moved ; $4228
	ld a, [wMenuCursorY] ; $422a
	cp e ; $422d
	jr nz, .moved ; $422e
	xor a ; $4230
	ret ; $4231
.moved:
	ld a, $01 ; $4232
	ret ; $4234
; Instruction-identical to MoveMenuCursorGridRemote_16 and MoveMenuCursorGridRemote_38 (one copy per bank); a change here belongs in every copy.
MoveMenuCursorGridRemote_3e:
	ld a, [wMenuCursorX] ; $4235
	ld d, a ; $4238
	ld a, [wMenuCursorY] ; $4239
	ld e, a ; $423c
	ldh a, [hLinkState] ; $423d
	cp LINKSTATE_SLAVE ; $423f
	jr z, .asSlave ; $4241
	cp LINKSTATE_MASTER ; $4243
	jr z, .asMaster ; $4245
	call LinkErrorReset ; $4247
.asMaster:
	ldh a, [hLinkRemoteInputBuf] ; $424a
	jr .haveInput ; $424c
.asSlave:
	ldh a, [hLinkRemoteInput] ; $424e
.haveInput:
	ld h, a ; $4250
	ld a, [wMenuCursorLockFlags] ; $4251
	and $01 ; $4254
	ld a, h ; $4256
	jr nz, .checkLock ; $4257
	bit 4, a ; $4259
	jr z, .checkLeft ; $425b
	ld a, [wMenuCursorX] ; $425d
	inc a ; $4260
	add a ; $4261
	jr nc, .wrapRight ; $4262
	ld a, b ; $4264
	dec a ; $4265
	jr .storeRight ; $4266
.wrapRight:
	rra ; $4268
	cp b ; $4269
	jr c, .storeRight ; $426a
	xor a ; $426c
.storeRight:
	ld [wMenuCursorX], a ; $426d
	jr .compare ; $4270
.checkLeft:
	bit 5, a ; $4272
	jr z, .checkUp ; $4274
	ld a, [wMenuCursorX] ; $4276
	dec a ; $4279
	add a ; $427a
	jr nc, .wrapLeft ; $427b
	ld a, b ; $427d
	dec a ; $427e
	jr .storeLeft ; $427f
.wrapLeft:
	rra ; $4281
	cp b ; $4282
	jr c, .storeLeft ; $4283
	xor a ; $4285
.storeLeft:
	ld [wMenuCursorX], a ; $4286
	jr .compare ; $4289
.checkUp:
	bit 6, a ; $428b
	jr z, .checkDown ; $428d
	ld a, [wMenuCursorY] ; $428f
	dec a ; $4292
	add a ; $4293
	jr nc, .wrapUp ; $4294
	ld a, c ; $4296
	dec a ; $4297
	jr .storeUp ; $4298
.wrapUp:
	rra ; $429a
	cp c ; $429b
	jr c, .storeUp ; $429c
	xor a ; $429e
.storeUp:
	ld [wMenuCursorY], a ; $429f
	jr .compare ; $42a2
.checkDown:
	bit 7, a ; $42a4
	jr z, .checkLock ; $42a6
	ld a, [wMenuCursorY] ; $42a8
	inc a ; $42ab
	add a ; $42ac
	jr nc, .wrapDown ; $42ad
	ld a, c ; $42af
	dec a ; $42b0
	jr .storeDown ; $42b1
.wrapDown:
	rra ; $42b3
	cp c ; $42b4
	jr c, .storeDown ; $42b5
	xor a ; $42b7
.storeDown:
	ld [wMenuCursorY], a ; $42b8
	jr .compare ; $42bb
.checkLock:
	bit 0, a ; $42bd
	jr z, .checkUnlock ; $42bf
	sound SFX_MENU_SELECT ; $42c1
	ld a, [wMenuCursorLockFlags] ; $42c3
	ld b, a ; $42c6
	and $01 ; $42c7
	jr nz, .compare ; $42c9
	sound SFX_MENU_SELECT ; $42cb
	ld a, b ; $42cd
	or $01 ; $42ce
	ld [wMenuCursorLockFlags], a ; $42d0
	jr .compare ; $42d3
.checkUnlock:
	bit 1, a ; $42d5
	jr z, .compare ; $42d7
	sound SFX_MENU_CANCEL ; $42d9
	ld a, [wMenuCursorLockFlags] ; $42db
	ld b, a ; $42de
	and $03 ; $42df
	ld a, b ; $42e1
	jr nz, .clearLock ; $42e2
	and $fa ; $42e4
	or $04 ; $42e6
	jr .storeLock ; $42e8
.clearLock:
	and $fe ; $42ea
.storeLock:
	ld [wMenuCursorLockFlags], a ; $42ec
.compare:
	ld a, [wMenuCursorX] ; $42ef
	cp d ; $42f2
	jr nz, .moved ; $42f3
	ld a, [wMenuCursorY] ; $42f5
	cp e ; $42f8
	jr nz, .moved ; $42f9
	xor a ; $42fb
	ret ; $42fc
.moved:
	ld a, $01 ; $42fd
	ret ; $42ff
; Instruction-identical to MoveMenuCursor2GridRemote_16 (one copy per bank); a change here belongs in every copy.
MoveMenuCursor2GridRemote_3e:
	ld a, [wMenuCursor2X] ; $4300
	ld d, a ; $4303
	ld a, [wMenuCursor2Y] ; $4304
	ld e, a ; $4307
	ldh a, [hLinkState] ; $4308
	cp LINKSTATE_SLAVE ; $430a
	jr z, .asSlave ; $430c
	cp LINKSTATE_MASTER ; $430e
	jr z, .asMaster ; $4310
	call LinkErrorReset ; $4312
.asMaster:
	ldh a, [hLinkRemoteInput] ; $4315
	jr .haveInput ; $4317
.asSlave:
	ldh a, [hLinkRemoteInputBuf] ; $4319
.haveInput:
	ld h, a ; $431b
	ld a, [wMenuCursorLockFlags] ; $431c
	and $02 ; $431f
	ld a, h ; $4321
	jr nz, .checkLock ; $4322
	bit 4, a ; $4324
	jr z, .checkLeft ; $4326
	ld a, [wMenuCursor2X] ; $4328
	inc a ; $432b
	add a ; $432c
	jr nc, .wrapRight ; $432d
	ld a, b ; $432f
	dec a ; $4330
	jr .storeRight ; $4331
.wrapRight:
	rra ; $4333
	cp b ; $4334
	jr c, .storeRight ; $4335
	xor a ; $4337
.storeRight:
	ld [wMenuCursor2X], a ; $4338
	jr .compare ; $433b
.checkLeft:
	bit 5, a ; $433d
	jr z, .checkUp ; $433f
	ld a, [wMenuCursor2X] ; $4341
	dec a ; $4344
	add a ; $4345
	jr nc, .wrapLeft ; $4346
	ld a, b ; $4348
	dec a ; $4349
	jr .storeLeft ; $434a
.wrapLeft:
	rra ; $434c
	cp b ; $434d
	jr c, .storeLeft ; $434e
	xor a ; $4350
.storeLeft:
	ld [wMenuCursor2X], a ; $4351
	jr .compare ; $4354
.checkUp:
	bit 6, a ; $4356
	jr z, .checkDown ; $4358
	ld a, [wMenuCursor2Y] ; $435a
	dec a ; $435d
	add a ; $435e
	jr nc, .wrapUp ; $435f
	ld a, c ; $4361
	dec a ; $4362
	jr .storeUp ; $4363
.wrapUp:
	rra ; $4365
	cp c ; $4366
	jr c, .storeUp ; $4367
	xor a ; $4369
.storeUp:
	ld [wMenuCursor2Y], a ; $436a
	jr .compare ; $436d
.checkDown:
	bit 7, a ; $436f
	jr z, .checkLock ; $4371
	ld a, [wMenuCursor2Y] ; $4373
	inc a ; $4376
	add a ; $4377
	jr nc, .wrapDown ; $4378
	ld a, c ; $437a
	dec a ; $437b
	jr .storeDown ; $437c
.wrapDown:
	rra ; $437e
	cp c ; $437f
	jr c, .storeDown ; $4380
	xor a ; $4382
.storeDown:
	ld [wMenuCursor2Y], a ; $4383
	jr .compare ; $4386
.checkLock:
	bit 0, a ; $4388
	jr z, .checkUnlock ; $438a
	ld a, [wMenuCursorLockFlags] ; $438c
	ld b, a ; $438f
	and $02 ; $4390
	jr nz, .compare ; $4392
	sound SFX_MENU_SELECT ; $4394
	ld a, b ; $4396
	or $02 ; $4397
	ld [wMenuCursorLockFlags], a ; $4399
	jr .compare ; $439c
.checkUnlock:
	bit 1, a ; $439e
	jr z, .compare ; $43a0
	sound SFX_MENU_CANCEL ; $43a2
	ld a, [wMenuCursorLockFlags] ; $43a4
	ld b, a ; $43a7
	and $03 ; $43a8
	ld a, b ; $43aa
	jr nz, .clearLock ; $43ab
	and $f5 ; $43ad
	or $08 ; $43af
	jr .storeLock ; $43b1
.clearLock:
	and $fd ; $43b3
.storeLock:
	ld [wMenuCursorLockFlags], a ; $43b5
.compare:
	ld a, [wMenuCursor2X] ; $43b8
	cp d ; $43bb
	jr nz, .moved ; $43bc
	ld a, [wMenuCursor2Y] ; $43be
	cp e ; $43c1
	jr nz, .moved ; $43c2
	xor a ; $43c4
	ret ; $43c5
.moved:
	ld a, $01 ; $43c6
	ret ; $43c8
; Instruction-identical to GetMenuCursorIndex_16, GetMenuCursorIndex_1b, GetMenuCursorIndex_38 and GetMenuCursorIndex_3b (one copy per bank); a change here belongs in every copy.
GetMenuCursorIndex_3e:
	ld a, [wMenuCursorY] ; $43c9
	ld b, a ; $43cc
	xor a ; $43cd
	inc b ; $43ce
.mulLoop:
	dec b ; $43cf
	jr z, .addColumn ; $43d0
	add c ; $43d2
	jr .mulLoop ; $43d3
.addColumn:
	ld b, a ; $43d5
	ld a, [wMenuCursorX] ; $43d6
	add b ; $43d9
	ret ; $43da
