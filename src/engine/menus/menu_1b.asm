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
DrawCornerBrackets_1b:
	push de ; $40f7
	push bc ; $40f8
	ld c, $00 ; $40f9
	ld b, $09 ; $40fb
	call QueueSprite ; $40fd
	pop bc ; $4100
	pop de ; $4101
	push de ; $4102
	push bc ; $4103
	ld a, b ; $4104
	add d ; $4105
	ld d, a ; $4106
	push de ; $4107
	ld c, $00 ; $4108
	ld b, $29 ; $410a
	call QueueSprite ; $410c
	pop de ; $410f
	pop bc ; $4110
	pop de ; $4111
	push de ; $4112
	push bc ; $4113
	ld a, c ; $4114
	add e ; $4115
	ld e, a ; $4116
	ld a, b ; $4117
	add d ; $4118
	ld d, a ; $4119
	push de ; $411a
	ld c, $00 ; $411b
	ld b, $69 ; $411d
	call QueueSprite ; $411f
	pop de ; $4122
	pop bc ; $4123
	pop de ; $4124
	ld a, e ; $4125
	add c ; $4126
	ld e, a ; $4127
	push de ; $4128
	ld c, $00 ; $4129
	ld b, $49 ; $412b
	call QueueSprite ; $412d
	pop de ; $4130
	ret ; $4131
; Instruction-identical to MoveMenuCursorGrid_17 (one copy per bank); a change here belongs in every copy.
MoveMenuCursorGrid_1b:
	ld a, [wMenuCursorX] ; $4132
	ld d, a ; $4135
	ld a, [wMenuCursorY] ; $4136
	ld e, a ; $4139
	ld a, [wMenuInputPressed] ; $413a
	bit PADB_RIGHT, a ; $413d
	jr z, .checkMenuCursorX4 ; $413f
	ld a, [wMenuCursorX] ; $4141
	inc a ; $4144
	add a ; $4145
	jr nc, .noCarry ; $4146
	ld a, b ; $4148
	dec a ; $4149
	jr .store ; $414a
.noCarry:
	rra ; $414c
	cp b ; $414d
	jr c, .store ; $414e
	xor a ; $4150
.store:
	ld [wMenuCursorX], a ; $4151
	jr .checkMenuCursorX ; $4154
.checkMenuCursorX4:
	bit 5, a ; $4156
	jr z, .bit5Clear ; $4158
	ld a, [wMenuCursorX] ; $415a
	dec a ; $415d
	add a ; $415e
	jr nc, .noCarry2 ; $415f
	ld a, b ; $4161
	dec a ; $4162
	jr .store2 ; $4163
.noCarry2:
	rra ; $4165
	cp b ; $4166
	jr c, .store2 ; $4167
	xor a ; $4169
.store2:
	ld [wMenuCursorX], a ; $416a
	jr .checkMenuCursorX ; $416d
.bit5Clear:
	bit 6, a ; $416f
	jr z, .bit6Clear ; $4171
	ld a, [wMenuCursorY] ; $4173
	dec a ; $4176
	add a ; $4177
	jr nc, .noCarry3 ; $4178
	ld a, c ; $417a
	dec a ; $417b
	jr .store3 ; $417c
.noCarry3:
	rra ; $417e
	cp c ; $417f
	jr c, .store3 ; $4180
	xor a ; $4182
.store3:
	ld [wMenuCursorY], a ; $4183
	jr .checkMenuCursorX ; $4186
.bit6Clear:
	bit 7, a ; $4188
	jr z, .checkMenuCursorX ; $418a
	ld a, [wMenuCursorY] ; $418c
	inc a ; $418f
	add a ; $4190
	jr nc, .noCarry4 ; $4191
	ld a, c ; $4193
	dec a ; $4194
	jr .store4 ; $4195
.noCarry4:
	rra ; $4197
	cp c ; $4198
	jr c, .store4 ; $4199
	xor a ; $419b
.store4:
	ld [wMenuCursorY], a ; $419c
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $419f
	cp d ; $41a2
	jr nz, .checkMenuCursorX5 ; $41a3
	ld a, [wMenuCursorY] ; $41a5
	cp e ; $41a8
	jr nz, .checkMenuCursorX5 ; $41a9
	xor a ; $41ab
	ret ; $41ac
.checkMenuCursorX5:
	ld a, $01 ; $41ad
	ret ; $41af
; Instruction-identical to MoveMenuCursorGridFromLinkInput_17 (one copy per bank); a change here belongs in every copy.
MoveMenuCursorGridFromLinkInput_1b:
	ld a, [wMenuCursorX] ; $41b0
	ld d, a ; $41b3
	ld a, [wMenuCursorY] ; $41b4
	ld e, a ; $41b7
	ldh a, [hLinkInput] ; $41b8
	bit 4, a ; $41ba
	jr z, .bit4Clear ; $41bc
	ld a, [wMenuCursorX] ; $41be
	inc a ; $41c1
	add a ; $41c2
	jr nc, .noCarry5 ; $41c3
	ld a, b ; $41c5
	dec a ; $41c6
	jr .store5 ; $41c7
.noCarry5:
	rra ; $41c9
	cp b ; $41ca
	jr c, .store5 ; $41cb
	xor a ; $41cd
.store5:
	ld [wMenuCursorX], a ; $41ce
	jr .checkMenuCursorX2 ; $41d1
.bit4Clear:
	bit 5, a ; $41d3
	jr z, .bit5Clear2 ; $41d5
	ld a, [wMenuCursorX] ; $41d7
	dec a ; $41da
	add a ; $41db
	jr nc, .noCarry6 ; $41dc
	ld a, b ; $41de
	dec a ; $41df
	jr .store6 ; $41e0
.noCarry6:
	rra ; $41e2
	cp b ; $41e3
	jr c, .store6 ; $41e4
	xor a ; $41e6
.store6:
	ld [wMenuCursorX], a ; $41e7
	jr .checkMenuCursorX2 ; $41ea
.bit5Clear2:
	bit 6, a ; $41ec
	jr z, .bit6Clear2 ; $41ee
	ld a, [wMenuCursorY] ; $41f0
	dec a ; $41f3
	add a ; $41f4
	jr nc, .noCarry7 ; $41f5
	ld a, c ; $41f7
	dec a ; $41f8
	jr .store7 ; $41f9
.noCarry7:
	rra ; $41fb
	cp c ; $41fc
	jr c, .store7 ; $41fd
	xor a ; $41ff
.store7:
	ld [wMenuCursorY], a ; $4200
	jr .checkMenuCursorX2 ; $4203
.bit6Clear2:
	bit 7, a ; $4205
	jr z, .checkMenuCursorX2 ; $4207
	ld a, [wMenuCursorY] ; $4209
	inc a ; $420c
	add a ; $420d
	jr nc, .noCarry8 ; $420e
	ld a, c ; $4210
	dec a ; $4211
	jr .store8 ; $4212
.noCarry8:
	rra ; $4214
	cp c ; $4215
	jr c, .store8 ; $4216
	xor a ; $4218
.store8:
	ld [wMenuCursorY], a ; $4219
.checkMenuCursorX2:
	ld a, [wMenuCursorX] ; $421c
	cp d ; $421f
	jr nz, .checkMenuCursorX6 ; $4220
	ld a, [wMenuCursorY] ; $4222
	cp e ; $4225
	jr nz, .checkMenuCursorX6 ; $4226
	xor a ; $4228
	ret ; $4229
.checkMenuCursorX6:
	ld a, $01 ; $422a
	ret ; $422c
MoveMenuCursorGridRemote_1b:
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
MoveMenuCursor2GridRemote_1b:
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
GetMenuCursorIndex_1b:
	ld a, [wMenuCursorY] ; $43c1
	ld b, a ; $43c4
	xor a ; $43c5
	inc b ; $43c6
.mulLoop:
	dec b ; $43c7
	jr z, .addColumn ; $43c8
	add c ; $43ca
	jr .mulLoop ; $43cb
.addColumn:
	ld b, a ; $43cd
	ld a, [wMenuCursorX] ; $43ce
	add b ; $43d1
	ret ; $43d2
; Instruction-identical to GetMenuCursorIndexFromPtr_38 (one copy per bank); a change here belongs in every copy.
GetMenuCursorIndexFromPtr_1b:
	push bc ; $43d3
	ld a, [hl-] ; $43d4
	ld b, a ; $43d5
	xor a ; $43d6
	inc b ; $43d7
.mulLoop:
	dec b ; $43d8
	jr z, .addColumn ; $43d9
	add c ; $43db
	jr .mulLoop ; $43dc
.addColumn:
	ld b, a ; $43de
	ld a, [hl] ; $43df
	add b ; $43e0
	pop bc ; $43e1
	ret ; $43e2
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
SetMenuCursorFromIndexToPtr_1b:
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
