; Instruction-identical to ApplySpriteWobbleX_16 (one copy per bank); a change here belongs in every copy.
ApplySpriteWobbleX_17:
	ldh a, [hVBlankCounter] ; $4079
	and $0f ; $407b
	ld hl, SpriteWobbleXTable ; $407d
	add l ; $4080
	ld l, a ; $4081
	jr nc, .readOffset ; $4082
	inc h ; $4084
.readOffset:
	ld a, [hl] ; $4085
	ld b, a ; $4086
	ld a, c ; $4087
	or a ; $4088
	jr z, .subtract ; $4089
	ld a, b ; $408b
	add d ; $408c
	ld d, a ; $408d
	ret ; $408e
.subtract:
	ld a, d ; $408f
	sub b ; $4090
	ld d, a ; $4091
	ret ; $4092
SpriteWobbleXTable:
	; $4093, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
; Instruction-identical to ApplySpriteWobbleY_16 (one copy per bank); a change here belongs in every copy.
ApplySpriteWobbleY_17:
	ldh a, [hVBlankCounter] ; $40a3
	and $0f ; $40a5
	ld hl, SpriteWobbleYTable_17 ; $40a7
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
	add e ; $40b6
	ld e, a ; $40b7
	ret ; $40b8
.subtract:
	ld a, e ; $40b9
	sub b ; $40ba
	ld e, a ; $40bb
	ret ; $40bc
SpriteWobbleYTable_17:
	; $40bd, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
	push de ; $40cd
	push bc ; $40ce
	ld c, $00 ; $40cf
	ld b, $09 ; $40d1
	call QueueSprite ; $40d3
	pop bc ; $40d6
	pop de ; $40d7
	push de ; $40d8
	push bc ; $40d9
	ld a, b ; $40da
	add d ; $40db
	ld d, a ; $40dc
	push de ; $40dd
	ld c, $00 ; $40de
	ld b, $29 ; $40e0
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
	ld c, $00 ; $40f1
	ld b, $69 ; $40f3
	call QueueSprite ; $40f5
	pop de ; $40f8
	pop bc ; $40f9
	pop de ; $40fa
	ld a, e ; $40fb
	add c ; $40fc
	ld e, a ; $40fd
	push de ; $40fe
	ld c, $00 ; $40ff
	ld b, $49 ; $4101
	call QueueSprite ; $4103
	pop de ; $4106
	ret ; $4107
; Instruction-identical to MoveMenuCursorGrid_1b (one copy per bank); a change here belongs in every copy.
MoveMenuCursorGrid_17:
	ld a, [wMenuCursorX] ; $4108
	ld d, a ; $410b
	ld a, [wMenuCursorY] ; $410c
	ld e, a ; $410f
	ld a, [wMenuInputPressed] ; $4110
	bit PADB_RIGHT, a ; $4113
	jr z, .checkMenuCursorX4 ; $4115
	ld a, [wMenuCursorX] ; $4117
	inc a ; $411a
	add a ; $411b
	jr nc, .noCarry ; $411c
	ld a, b ; $411e
	dec a ; $411f
	jr .store ; $4120
.noCarry:
	rra ; $4122
	cp b ; $4123
	jr c, .store ; $4124
	xor a ; $4126
.store:
	ld [wMenuCursorX], a ; $4127
	jr .checkMenuCursorX ; $412a
.checkMenuCursorX4:
	bit 5, a ; $412c
	jr z, .bit5Clear ; $412e
	ld a, [wMenuCursorX] ; $4130
	dec a ; $4133
	add a ; $4134
	jr nc, .noCarry2 ; $4135
	ld a, b ; $4137
	dec a ; $4138
	jr .store2 ; $4139
.noCarry2:
	rra ; $413b
	cp b ; $413c
	jr c, .store2 ; $413d
	xor a ; $413f
.store2:
	ld [wMenuCursorX], a ; $4140
	jr .checkMenuCursorX ; $4143
.bit5Clear:
	bit 6, a ; $4145
	jr z, .bit6Clear ; $4147
	ld a, [wMenuCursorY] ; $4149
	dec a ; $414c
	add a ; $414d
	jr nc, .noCarry3 ; $414e
	ld a, c ; $4150
	dec a ; $4151
	jr .store3 ; $4152
.noCarry3:
	rra ; $4154
	cp c ; $4155
	jr c, .store3 ; $4156
	xor a ; $4158
.store3:
	ld [wMenuCursorY], a ; $4159
	jr .checkMenuCursorX ; $415c
.bit6Clear:
	bit 7, a ; $415e
	jr z, .checkMenuCursorX ; $4160
	ld a, [wMenuCursorY] ; $4162
	inc a ; $4165
	add a ; $4166
	jr nc, .noCarry4 ; $4167
	ld a, c ; $4169
	dec a ; $416a
	jr .store4 ; $416b
.noCarry4:
	rra ; $416d
	cp c ; $416e
	jr c, .store4 ; $416f
	xor a ; $4171
.store4:
	ld [wMenuCursorY], a ; $4172
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $4175
	cp d ; $4178
	jr nz, .checkMenuCursorX5 ; $4179
	ld a, [wMenuCursorY] ; $417b
	cp e ; $417e
	jr nz, .checkMenuCursorX5 ; $417f
	xor a ; $4181
	ret ; $4182
.checkMenuCursorX5:
	ld a, $01 ; $4183
	ret ; $4185
; Instruction-identical to MoveMenuCursorGridFromLinkInput_1b (one copy per bank); a change here belongs in every copy.
MoveMenuCursorGridFromLinkInput_17:
	ld a, [wMenuCursorX] ; $4186
	ld d, a ; $4189
	ld a, [wMenuCursorY] ; $418a
	ld e, a ; $418d
	ldh a, [hLinkInput] ; $418e
	bit 4, a ; $4190
	jr z, .bit4Clear ; $4192
	ld a, [wMenuCursorX] ; $4194
	inc a ; $4197
	add a ; $4198
	jr nc, .noCarry5 ; $4199
	ld a, b ; $419b
	dec a ; $419c
	jr .store5 ; $419d
.noCarry5:
	rra ; $419f
	cp b ; $41a0
	jr c, .store5 ; $41a1
	xor a ; $41a3
.store5:
	ld [wMenuCursorX], a ; $41a4
	jr .checkMenuCursorX2 ; $41a7
.bit4Clear:
	bit 5, a ; $41a9
	jr z, .bit5Clear2 ; $41ab
	ld a, [wMenuCursorX] ; $41ad
	dec a ; $41b0
	add a ; $41b1
	jr nc, .noCarry6 ; $41b2
	ld a, b ; $41b4
	dec a ; $41b5
	jr .store6 ; $41b6
.noCarry6:
	rra ; $41b8
	cp b ; $41b9
	jr c, .store6 ; $41ba
	xor a ; $41bc
.store6:
	ld [wMenuCursorX], a ; $41bd
	jr .checkMenuCursorX2 ; $41c0
.bit5Clear2:
	bit 6, a ; $41c2
	jr z, .bit6Clear2 ; $41c4
	ld a, [wMenuCursorY] ; $41c6
	dec a ; $41c9
	add a ; $41ca
	jr nc, .noCarry7 ; $41cb
	ld a, c ; $41cd
	dec a ; $41ce
	jr .store7 ; $41cf
.noCarry7:
	rra ; $41d1
	cp c ; $41d2
	jr c, .store7 ; $41d3
	xor a ; $41d5
.store7:
	ld [wMenuCursorY], a ; $41d6
	jr .checkMenuCursorX2 ; $41d9
.bit6Clear2:
	bit 7, a ; $41db
	jr z, .checkMenuCursorX2 ; $41dd
	ld a, [wMenuCursorY] ; $41df
	inc a ; $41e2
	add a ; $41e3
	jr nc, .noCarry8 ; $41e4
	ld a, c ; $41e6
	dec a ; $41e7
	jr .store8 ; $41e8
.noCarry8:
	rra ; $41ea
	cp c ; $41eb
	jr c, .store8 ; $41ec
	xor a ; $41ee
.store8:
	ld [wMenuCursorY], a ; $41ef
.checkMenuCursorX2:
	ld a, [wMenuCursorX] ; $41f2
	cp d ; $41f5
	jr nz, .checkMenuCursorX6 ; $41f6
	ld a, [wMenuCursorY] ; $41f8
	cp e ; $41fb
	jr nz, .checkMenuCursorX6 ; $41fc
	xor a ; $41fe
	ret ; $41ff
.checkMenuCursorX6:
	ld a, $01 ; $4200
	ret ; $4202
MoveMenuCursorGridRemote_17:
	ld a, [wMenuCursorX] ; $4203
	ld d, a ; $4206
	ld a, [wMenuCursorY] ; $4207
	ld e, a ; $420a
	ldh a, [hLinkState] ; $420b
	cp LINKSTATE_SLAVE ; $420d
	jr z, .eq02 ; $420f
	cp LINKSTATE_MASTER ; $4211
	jr z, .eq01 ; $4213
	call LinkErrorReset ; $4215
.eq01:
	ldh a, [hLinkRemoteInputBuf] ; $4218
	jr .checkMenuCursorLockFlags ; $421a
.eq02:
	ldh a, [hLinkRemoteInput] ; $421c
.checkMenuCursorLockFlags:
	ld h, a ; $421e
	ld a, [wMenuCursorLockFlags] ; $421f
	and $01 ; $4222
	ld a, h ; $4224
	jr nz, .checkMenuCursorLockFlags4 ; $4225
	bit 4, a ; $4227
	jr z, .bit4Clear2 ; $4229
	ld a, [wMenuCursorX] ; $422b
	inc a ; $422e
	add a ; $422f
	jr nc, .noCarry9 ; $4230
	ld a, b ; $4232
	dec a ; $4233
	jr .store9 ; $4234
.noCarry9:
	rra ; $4236
	cp b ; $4237
	jr c, .store9 ; $4238
	xor a ; $423a
.store9:
	ld [wMenuCursorX], a ; $423b
	jr .checkMenuCursorX3 ; $423e
.bit4Clear2:
	bit 5, a ; $4240
	jr z, .bit5Clear3 ; $4242
	ld a, [wMenuCursorX] ; $4244
	dec a ; $4247
	add a ; $4248
	jr nc, .noCarry10 ; $4249
	ld a, b ; $424b
	dec a ; $424c
	jr .store10 ; $424d
.noCarry10:
	rra ; $424f
	cp b ; $4250
	jr c, .store10 ; $4251
	xor a ; $4253
.store10:
	ld [wMenuCursorX], a ; $4254
	jr .checkMenuCursorX3 ; $4257
.bit5Clear3:
	bit 6, a ; $4259
	jr z, .bit6Clear3 ; $425b
	ld a, [wMenuCursorY] ; $425d
	dec a ; $4260
	add a ; $4261
	jr nc, .noCarry11 ; $4262
	ld a, c ; $4264
	dec a ; $4265
	jr .store11 ; $4266
.noCarry11:
	rra ; $4268
	cp c ; $4269
	jr c, .store11 ; $426a
	xor a ; $426c
.store11:
	ld [wMenuCursorY], a ; $426d
	jr .checkMenuCursorX3 ; $4270
.bit6Clear3:
	bit 7, a ; $4272
	jr z, .checkMenuCursorLockFlags4 ; $4274
	ld a, [wMenuCursorY] ; $4276
	inc a ; $4279
	add a ; $427a
	jr nc, .noCarry12 ; $427b
	ld a, c ; $427d
	dec a ; $427e
	jr .store12 ; $427f
.noCarry12:
	rra ; $4281
	cp c ; $4282
	jr c, .store12 ; $4283
	xor a ; $4285
.store12:
	ld [wMenuCursorY], a ; $4286
	jr .checkMenuCursorX3 ; $4289
.checkMenuCursorLockFlags4:
	bit 0, a ; $428b
	jr z, .bit0Clear ; $428d
	sound SFX_MENU_SELECT ; $428f
	ld a, [wMenuCursorLockFlags] ; $4291
	ld b, a ; $4294
	and $01 ; $4295
	jr nz, .checkMenuCursorX3 ; $4297
	sound SFX_MENU_SELECT ; $4299
	ld a, b ; $429b
	or $01 ; $429c
	ld [wMenuCursorLockFlags], a ; $429e
	jr .checkMenuCursorX3 ; $42a1
.bit0Clear:
	bit 1, a ; $42a3
	jr z, .checkMenuCursorX3 ; $42a5
	sound SFX_MENU_CANCEL ; $42a7
	ld a, [wMenuCursorLockFlags] ; $42a9
	ld b, a ; $42ac
	and $03 ; $42ad
	ld a, b ; $42af
	jr nz, .storeMenuCursorLockFlags ; $42b0
	and $fa ; $42b2
	or $04 ; $42b4
	jr .store13 ; $42b6
.storeMenuCursorLockFlags:
	and $fe ; $42b8
.store13:
	ld [wMenuCursorLockFlags], a ; $42ba
.checkMenuCursorX3:
	ld a, [wMenuCursorX] ; $42bd
	cp d ; $42c0
	jr nz, .checkMenuCursor2X2 ; $42c1
	ld a, [wMenuCursorY] ; $42c3
	cp e ; $42c6
	jr nz, .checkMenuCursor2X2 ; $42c7
	xor a ; $42c9
	ret ; $42ca
.checkMenuCursor2X2:
	ld a, $01 ; $42cb
	ret ; $42cd
MoveMenuCursor2GridRemote_17:
	ld a, [wMenuCursor2X] ; $42ce
	ld d, a ; $42d1
	ld a, [wMenuCursor2Y] ; $42d2
	ld e, a ; $42d5
	ldh a, [hLinkState] ; $42d6
	cp LINKSTATE_SLAVE ; $42d8
	jr z, .eq022 ; $42da
	cp LINKSTATE_MASTER ; $42dc
	jr z, .eq012 ; $42de
	call LinkErrorReset ; $42e0
.eq012:
	ldh a, [hLinkRemoteInput] ; $42e3
	jr .checkMenuCursorLockFlags2 ; $42e5
.eq022:
	ldh a, [hLinkRemoteInputBuf] ; $42e7
.checkMenuCursorLockFlags2:
	ld h, a ; $42e9
	ld a, [wMenuCursorLockFlags] ; $42ea
	and $02 ; $42ed
	ld a, h ; $42ef
	jr nz, .checkMenuCursorLockFlags3 ; $42f0
	bit 4, a ; $42f2
	jr z, .bit4Clear3 ; $42f4
	ld a, [wMenuCursor2X] ; $42f6
	inc a ; $42f9
	add a ; $42fa
	jr nc, .noCarry13 ; $42fb
	ld a, b ; $42fd
	dec a ; $42fe
	jr .store14 ; $42ff
.noCarry13:
	rra ; $4301
	cp b ; $4302
	jr c, .store14 ; $4303
	xor a ; $4305
.store14:
	ld [wMenuCursor2X], a ; $4306
	jr .checkMenuCursor2X ; $4309
.bit4Clear3:
	bit 5, a ; $430b
	jr z, .bit5Clear4 ; $430d
	ld a, [wMenuCursor2X] ; $430f
	dec a ; $4312
	add a ; $4313
	jr nc, .noCarry14 ; $4314
	ld a, b ; $4316
	dec a ; $4317
	jr .store15 ; $4318
.noCarry14:
	rra ; $431a
	cp b ; $431b
	jr c, .store15 ; $431c
	xor a ; $431e
.store15:
	ld [wMenuCursor2X], a ; $431f
	jr .checkMenuCursor2X ; $4322
.bit5Clear4:
	bit 6, a ; $4324
	jr z, .bit6Clear4 ; $4326
	ld a, [wMenuCursor2Y] ; $4328
	dec a ; $432b
	add a ; $432c
	jr nc, .noCarry15 ; $432d
	ld a, c ; $432f
	dec a ; $4330
	jr .store16 ; $4331
.noCarry15:
	rra ; $4333
	cp c ; $4334
	jr c, .store16 ; $4335
	xor a ; $4337
.store16:
	ld [wMenuCursor2Y], a ; $4338
	jr .checkMenuCursor2X ; $433b
.bit6Clear4:
	bit 7, a ; $433d
	jr z, .checkMenuCursorLockFlags3 ; $433f
	ld a, [wMenuCursor2Y] ; $4341
	inc a ; $4344
	add a ; $4345
	jr nc, .noCarry16 ; $4346
	ld a, c ; $4348
	dec a ; $4349
	jr .store17 ; $434a
.noCarry16:
	rra ; $434c
	cp c ; $434d
	jr c, .store17 ; $434e
	xor a ; $4350
.store17:
	ld [wMenuCursor2Y], a ; $4351
	jr .checkMenuCursor2X ; $4354
.checkMenuCursorLockFlags3:
	bit 0, a ; $4356
	jr z, .bit0Clear2 ; $4358
	ld a, [wMenuCursorLockFlags] ; $435a
	ld b, a ; $435d
	and $02 ; $435e
	jr nz, .checkMenuCursor2X ; $4360
	sound SFX_MENU_SELECT ; $4362
	ld a, b ; $4364
	or $02 ; $4365
	ld [wMenuCursorLockFlags], a ; $4367
	jr .checkMenuCursor2X ; $436a
.bit0Clear2:
	bit 1, a ; $436c
	jr z, .checkMenuCursor2X ; $436e
	sound SFX_MENU_CANCEL ; $4370
	ld a, [wMenuCursorLockFlags] ; $4372
	ld b, a ; $4375
	and $03 ; $4376
	ld a, b ; $4378
	jr nz, .storeMenuCursorLockFlags2 ; $4379
	and $f5 ; $437b
	or $08 ; $437d
	jr .store18 ; $437f
.storeMenuCursorLockFlags2:
	and $fd ; $4381
.store18:
	ld [wMenuCursorLockFlags], a ; $4383
.checkMenuCursor2X:
	ld a, [wMenuCursor2X] ; $4386
	cp d ; $4389
	jr nz, .checkMenuCursorY ; $438a
	ld a, [wMenuCursor2Y] ; $438c
	cp e ; $438f
	jr nz, .checkMenuCursorY ; $4390
	xor a ; $4392
	ret ; $4393
.checkMenuCursorY:
	ld a, $01 ; $4394
	ret ; $4396
GetMenuCursorLinearIndex_17:
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
GetMenuCursorLinearIndexFromPtr_17:
	push bc ; $43a9
	ld a, [hl-] ; $43aa
	ld b, a ; $43ab
	xor a ; $43ac
	inc b ; $43ad
.loopB:
	dec b ; $43ae
	jr z, .countDone2 ; $43af
	add c ; $43b1
	jr .loopB ; $43b2
.countDone2:
	ld b, a ; $43b4
	ld a, [hl] ; $43b5
	add b ; $43b6
	pop bc ; $43b7
	ret ; $43b8
; Divides the linear index in c by the row width in b: remainder ->
; wMenuCursorX, quotient -> wMenuCursorY. Twin of
; WriteGridPosFromLinearIndex_17, which writes through hl instead.
;
; No proven caller: the two-instruction prologue was never executed in
; any trace, so only the loop from $43bc was proven and these 3 bytes
; read as data until they were seeded as code.
SetMenuCursorFromLinearIndex_17:
	ld d, $00 ; $43b9
	ld a, c ; $43bb
.loop2:
	cp b ; $43bc
	jr c, .store19 ; $43bd
	inc d ; $43bf
	sub b ; $43c0
	jr .loop2 ; $43c1
.store19:
	ld [wMenuCursorX], a ; $43c3
	ld a, d ; $43c6
	ld [wMenuCursorY], a ; $43c7
	ret ; $43ca
