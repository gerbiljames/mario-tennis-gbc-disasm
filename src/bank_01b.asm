SECTION "ROM Bank $1b", ROMX[$4000], BANK[$1b]

	farptr DecompressCharMugshot ; $4000
	farptr LoadIndexedPaletteThunk ; $4002
	farptr StubNop_1b_4e7f ; $4004
	farptr StubNop_1b_4e80 ; $4006
	farptr StubNop_1b_4e80Alias1, StubNop_1b_4e80 ; $4008
	farptr StubNop_1b_4e57 ; $400a
	farptr ResetMugshotPalettes_1b ; $400c
	farptr SetMugshotAttrs ; $400e
	farptr LoadCharMugshotToBuffer ; $4010
	farptr StubNop_1b_4e43 ; $4012
	farptr StubNop_1b_4e44 ; $4014
	farptr StubNop_1b_4e45 ; $4016
	farptr CopyMugshotBufferToVram ; $4018
	farptr ShowRankingBoard ; $401a
	farptr UpdateCharSelectSelection ; $401c
	farptr RunStoryDataConfirmMenu ; $401e
	farptr ShowNoN64DataFoundScreen ; $4020
	farptr RunNewGameSetup ; $4022
	farptr RunDebugSaveDataFlow ; $4024
	farptr RunMinigameFlagsDebugScreen ; $4026
	farptr RunMinigameLevelSelect ; $4028
	farptr RunSavedDataTypeSelect ; $402a
	farptr ShowMinigameDataScreen ; $402c
DataPtr_ObjectSceneAGfx0:
	dw ObjectSceneAGfx0 ; $402e
DataPtr_ObjectSceneAGfx1:
	dw ObjectSceneAGfx1 ; $4030
DataPtr_ObjectSceneAGfx2:
	dw ObjectSceneAGfx2 ; $4032
DataPtr_ObjectSceneBGfx0:
	dw ObjectSceneBGfx0 ; $4034
DataPtr_ObjectSceneBGfx1:
	dw ObjectSceneBGfx1 ; $4036
DataPtr_ObjectSceneBGfx2:
	dw ObjectSceneBGfx2 ; $4038
DataPtr_Screen0Gfx:
	dw Screen0Gfx ; $403a
DataPtr_Screen1ObjGfx:
	dw Screen1ObjGfx ; $403c
DataPtr_Screen2ObjGfx:
	dw Screen2ObjGfx ; $403e
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
DrawMenuCursorCornersAlt:
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
MoveMenuCursorGrid:
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
	ld a, [wMenuCursorX] ; $422d
	ld d, a ; $4230
	ld a, [wMenuCursorY] ; $4231
	ld e, a ; $4234
	ldh a, [hLinkState] ; $4235
	cp $02 ; $4237
	jr z, .eq02 ; $4239
	cp $01 ; $423b
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
	sound $5f ; $42b9
	ld a, [wMenuCursorLockFlags] ; $42bb
	ld b, a ; $42be
	and $01 ; $42bf
	jr nz, .checkMenuCursorX3 ; $42c1
	sound $5f ; $42c3
	ld a, b ; $42c5
	or $01 ; $42c6
	ld [wMenuCursorLockFlags], a ; $42c8
	jr .checkMenuCursorX3 ; $42cb
.bit0Clear:
	bit 1, a ; $42cd
	jr z, .checkMenuCursorX3 ; $42cf
	sound $62 ; $42d1
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
	cp $02 ; $4302
	jr z, .asSlave ; $4304
	cp $01 ; $4306
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
	sound $5f ; $438c
	ld a, b ; $438e
	or $02 ; $438f
	ld [wMenuCursorLockFlags], a ; $4391
	jr .checkMenuCursor2X ; $4394
.bit0Clear:
	bit 1, a ; $4396
	jr z, .checkMenuCursor2X ; $4398
	sound $62 ; $439a
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
GetMenuCursorIndex:
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
GetMenuCursorIndexFromPtr:
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
	ldh a, [hWramBank] ; $4403
	push af ; $4405
	wram_bank $03 ; $4406
	xor a ; $440c
	ld c, $40 ; $440d
.loop2:
	ld [hl+], a ; $440f
	dec c ; $4410
	jr nz, .loop2 ; $4411
	pop af ; $4413
	wram_bank ; $4414
	ret ; $4418
ClearWram3Row64Alt_1b:
	ldh a, [hWramBank] ; $4419
	push af ; $441b
	wram_bank $03 ; $441c
	ld a, $00 ; $4422
	ld c, $40 ; $4424
.loop3:
	ld [hl+], a ; $4426
	dec c ; $4427
	jr nz, .loop3 ; $4428
	pop af ; $442a
	wram_bank ; $442b
	ret ; $442f
UpdateAnimatedTilesTask:
	farcall UpdateAnimatedTiles ; $4430
	ret ; $4433
DrawNameWithDiacritics:
	push af ; $4434
	push bc ; $4435
.loop:
	ld a, [hl] ; $4436
	cp $00 ; $4437
	jr z, .restore ; $4439
	ld [de], a ; $443b
	inc hl ; $443c
	ld a, [hl] ; $443d
	cp $de ; $443e
	jr z, .eqde ; $4440
	cp $df ; $4442
	jr nz, .nedf ; $4444
.eqde:
	push hl ; $4446
	push bc ; $4447
	ld h, d ; $4448
	ld l, e ; $4449
	ld bc, $ffe0 ; $444a
	add hl, bc ; $444d
	ld b, a ; $444e
	ld a, [hl] ; $444f
	cp $03 ; $4450
	ld a, b ; $4452
	jr nz, .store ; $4453
	sub $d0 ; $4455
.store:
	ld [hl], a ; $4457
	pop bc ; $4458
	pop hl ; $4459
	inc hl ; $445a
.nedf:
	inc de ; $445b
	ld a, e ; $445c
	and $1f ; $445d
	jr nz, .loop ; $445f
	push hl ; $4461
	ld h, d ; $4462
	ld l, e ; $4463
	add hl, de ; $4464
	ld d, h ; $4465
	ld e, l ; $4466
	pop hl ; $4467
	jr .loop ; $4468
.restore:
	pop bc ; $446a
	pop af ; $446b
	ret ; $446c
	push af ; $446d
	push bc ; $446e
	push hl ; $446f
	add sp, -10 ; $4470
	push bc ; $4472
	push de ; $4473
	ld c, l ; $4474
	ld b, h ; $4475
	ld hl, sp + 4 ; $4476
	ld e, l ; $4478
	ld d, h ; $4479
	ld l, c ; $447a
	ld h, b ; $447b
	ld c, e ; $447c
	ld b, d ; $447d
	call FormatDecimalNumber ; $447e
	ld l, c ; $4481
	ld h, b ; $4482
	pop de ; $4483
	pop bc ; $4484
	call DrawAsciiDigitString ; $4485
	add sp, 10 ; $4488
	pop hl ; $448a
	pop bc ; $448b
	pop af ; $448c
	ret ; $448d
DrawAsciiDigitString:
	ld a, [hl+] ; $448e
	and a ; $448f
	jr z, .done ; $4490
	call DrawAsciiDigitChar ; $4492
	jr DrawAsciiDigitString ; $4495
.done:
	ret ; $4497
DrawAsciiDigitChar:
	push hl ; $4498
	ld hl, $d240 ; $4499
	sub $30 ; $449c
	jr c, .carry ; $449e
	add $30 ; $44a0
	ld b, a ; $44a2
	wram_bank $03 ; $44a3
	ld a, b ; $44a9
	ld [de], a ; $44aa
	inc de ; $44ab
	pop hl ; $44ac
	ret ; $44ad
.carry:
	inc de ; $44ae
	pop hl ; $44af
	ret ; $44b0
MugshotGfxAlex_1b:
	INCBIN "data/bank_01b/lz_44b1.bin" ; $44b1, 158 bytes
MugshotGfxNina_1b:
	INCBIN "data/bank_01b/lz_454f.bin" ; $454f, 163 bytes
MugshotGfxHarry_1b:
	INCBIN "data/bank_01b/lz_45f2.bin" ; $45f2, 146 bytes
MugshotGfxKate_1b:
	INCBIN "data/bank_01b/lz_4684.bin" ; $4684, 165 bytes
MugshotGfxMario_1b:
	INCBIN "data/bank_01b/lz_4729.bin" ; $4729, 162 bytes
MugshotGfxWaluigi_1b:
	INCBIN "data/bank_01b/lz_47cb.bin" ; $47cb, 158 bytes
MugshotGfxYoshi_1b:
	INCBIN "data/bank_01b/lz_4869.bin" ; $4869, 139 bytes
MugshotGfxBowser_1b:
	INCBIN "data/bank_01b/lz_48f4.bin" ; $48f4, 165 bytes
MugshotGfxWario_1b:
	INCBIN "data/bank_01b/lz_4999.bin" ; $4999, 162 bytes
MugshotGfxPeach_1b:
	INCBIN "data/bank_01b/lz_4a3b.bin" ; $4a3b, 153 bytes
MugshotGfxStorySlot1_1b:
	INCBIN "data/bank_01b/lz_4ad4.bin" ; $4ad4, 110 bytes
MugshotGfxStorySlot2_1b:
	INCBIN "data/bank_01b/lz_4b42.bin" ; $4b42, 147 bytes
MugshotGfxStorySlot3_1b:
	INCBIN "data/bank_01b/lz_4bd5.bin" ; $4bd5, 153 bytes
MugshotGfxUnknown_1b:
	INCBIN "data/bank_01b/lz_4c6e.bin" ; $4c6e, 126 bytes
CharMugshotGfxPointers_1b_4cec:
	; $4cec, 288 bytes (mugshot_ptr_table)
	dw MugshotGfxAlex_1b, .unused ; $00 Alex
	dw MugshotGfxNina_1b, .unused ; $01 Nina
	dw MugshotGfxHarry_1b, .unused ; $02 Harry
	dw MugshotGfxKate_1b, .unused ; $03 Kate
	dw MugshotGfxUnknown_1b, .unused ; $04 Allie
	dw MugshotGfxUnknown_1b, .unused ; $05 Joy
	dw MugshotGfxUnknown_1b, .unused ; $06 Brian
	dw MugshotGfxUnknown_1b, .unused ; $07 Pam
	dw MugshotGfxUnknown_1b, .unused ; $08 Bob
	dw MugshotGfxUnknown_1b, .unused ; $09 Beth
	dw MugshotGfxUnknown_1b, .unused ; $0a Fay
	dw MugshotGfxUnknown_1b, .unused ; $0b Curt
	dw MugshotGfxUnknown_1b, .unused ; $0c Mark
	dw MugshotGfxUnknown_1b, .unused ; $0d Sean
	dw MugshotGfxUnknown_1b, .unused ; $0e Sammi
	dw MugshotGfxUnknown_1b, .unused ; $0f Elden
	dw MugshotGfxUnknown_1b, .unused ; $10 Spike
	dw MugshotGfxUnknown_1b, .unused ; $11 Emily
	dw MugshotGfxUnknown_1b, .unused ; $12 B. Coz
	dw MugshotGfxUnknown_1b, .unused ; $13 A. Coz
	dw MugshotGfxUnknown_1b, .unused ; $14 Kevin
	dw MugshotGfxUnknown_1b, .unused ; $15 Not used
	dw MugshotGfxUnknown_1b, .unused ; $16 Not used
	dw MugshotGfxUnknown_1b, .unused ; $17 Luigi
	dw MugshotGfxUnknown_1b, .unused ; $18 DK
	dw MugshotGfxUnknown_1b, .unused ; $19 Baby M.
	dw MugshotGfxMario_1b, .unused ; $1a Mario
	dw MugshotGfxWaluigi_1b, .unused ; $1b Waluigi
	dw MugshotGfxYoshi_1b, .unused ; $1c Yoshi
	dw MugshotGfxBowser_1b, .unused ; $1d Bowser
	dw MugshotGfxWario_1b, .unused ; $1e Wario
	dw MugshotGfxPeach_1b, .unused ; $1f Peach
	dw MugshotGfxUnknown_1b, .unused ; $20 no character
	dw MugshotGfxUnknown_1b, .unused ; $21 no character
	dw MugshotGfxUnknown_1b, .unused ; $22 no character
	dw MugshotGfxUnknown_1b, .unused ; $23 no character
	dw MugshotGfxUnknown_1b, .unused ; $24 no character
	dw MugshotGfxUnknown_1b, .unused ; $25 no character
	dw MugshotGfxUnknown_1b, .unused ; $26 no character
	dw MugshotGfxUnknown_1b, .unused ; $27 no character
	dw MugshotGfxUnknown_1b, .unused ; $28 no character
	dw MugshotGfxUnknown_1b, .unused ; $29 no character
	dw MugshotGfxUnknown_1b, .unused ; $2a no character
	dw MugshotGfxUnknown_1b, .unused ; $2b no character
	dw MugshotGfxUnknown_1b, .unused ; $2c no character
	dw MugshotGfxUnknown_1b, .unused ; $2d no character
	dw MugshotGfxUnknown_1b, .unused ; $2e no character
	dw MugshotGfxUnknown_1b, .unused ; $2f no character
	dw MugshotGfxUnknown_1b, .unused ; $30 no character
	dw MugshotGfxUnknown_1b, .unused ; $31 no character
	dw MugshotGfxUnknown_1b, .unused ; $32 no character
	dw MugshotGfxUnknown_1b, .unused ; $33 no character
	dw MugshotGfxUnknown_1b, .unused ; $34 no character
	dw MugshotGfxUnknown_1b, .unused ; $35 no character
	dw MugshotGfxUnknown_1b, .unused ; $36 no character
	dw MugshotGfxUnknown_1b, .unused ; $37 no character
	dw MugshotGfxUnknown_1b, .unused ; $38 no character
	dw MugshotGfxUnknown_1b, .unused ; $39 no character
	dw MugshotGfxUnknown_1b, .unused ; $3a no character
	dw MugshotGfxUnknown_1b, .unused ; $3b no character
	dw MugshotGfxUnknown_1b, .unused ; $3c no character
	dw MugshotGfxUnknown_1b, .unused ; $3d no character
	dw MugshotGfxUnknown_1b, .unused ; $3e no character
	dw MugshotGfxUnknown_1b, .unused ; $3f story hero (remapped to $40 + save slot)
	dw MugshotGfxStorySlot1_1b, .unusedAlt ; $40 story hero, save slot 1
	dw MugshotGfxStorySlot2_1b, .unusedAlt ; $41 story hero, save slot 2
	dw MugshotGfxStorySlot3_1b, .unusedAlt ; $42 story hero, save slot 3
.unused:
	dw $6400, $00ff
.unusedAlt:
	dw $6400, $00ff
.trailer: ; unreferenced
	dw $d600, $d690, $d720, $0000, $0090, $0120
StubNop_1b_4e0c:
	ret ; $4e0c
ResetMugshotPalettes_1b:
	ld a, $ff ; $4e0d
	ld [$c780], a ; $4e0f
	ld d, $03 ; $4e12
	farcall LoadAllIndexedPalettes_18 ; $4e14
	ret ; $4e17
SetMugshotAttrs:
	push af ; $4e18
	push de ; $4e19
	push hl ; $4e1a
	and $07 ; $4e1b
	add $03 ; $4e1d
	or $08 ; $4e1f
	ld hl, $dc00 ; $4e21
	add hl, de ; $4e24
	ld de, $001d ; $4e25
	ld [hl+], a ; $4e28
	ld [hl+], a ; $4e29
	ld [hl+], a ; $4e2a
	add hl, de ; $4e2b
	ld [hl+], a ; $4e2c
	ld [hl+], a ; $4e2d
	ld [hl+], a ; $4e2e
	add hl, de ; $4e2f
	ld [hl+], a ; $4e30
	ld [hl+], a ; $4e31
	ld [hl+], a ; $4e32
	pop hl ; $4e33
	pop de ; $4e34
	pop af ; $4e35
	ret ; $4e36
LoadCharMugshotToBuffer:
	cp $40 ; $4e37
	ret nc ; $4e39
	push de ; $4e3a
	ld de, $d600 ; $4e3b
	call DecompressCharMugshot ; $4e3e
	pop de ; $4e41
	ret ; $4e42
StubNop_1b_4e43:
	ret ; $4e43
StubNop_1b_4e44:
	ret ; $4e44
StubNop_1b_4e45:
	ret ; $4e45
CopyMugshotBufferToVram:
	push af ; $4e46
	push bc ; $4e47
	push de ; $4e48
	push hl ; $4e49
	ld hl, $d600 ; $4e4a
	ld c, $09 ; $4e4d
	call QueueVRAMCopy ; $4e4f
	pop hl ; $4e52
	pop de ; $4e53
	pop bc ; $4e54
	pop af ; $4e55
	ret ; $4e56
StubNop_1b_4e57:
	ret ; $4e57
LoadIndexedPaletteThunk:
	farcall LoadIndexedPalette_18 ; $4e58
	ret ; $4e5b
DecompressCharMugshot:
	push af ; $4e5c
	push de ; $4e5d
	push hl ; $4e5e
	call StubNop_1b_4e0c ; $4e5f
	cp $3f ; $4e62
	jr nz, .gotIndex ; $4e64
	ld b, a ; $4e66
	ld a, [wCurrentStorySlot] ; $4e67
	add b ; $4e6a
	inc a ; $4e6b
.gotIndex:
	ld l, a ; $4e6c
	ld h, $00 ; $4e6d
	add hl, hl ; $4e6f
	add hl, hl ; $4e70
	ld bc, CharMugshotGfxPointers_1b_4cec ; $4e71
	add hl, bc ; $4e74
	ld a, [hl+] ; $4e75
	ld h, [hl] ; $4e76
	ld l, a ; $4e77
	call DecompressData ; $4e78
	pop hl ; $4e7b
	pop de ; $4e7c
	pop af ; $4e7d
	ret ; $4e7e
StubNop_1b_4e7f:
	ret ; $4e7f
StubNop_1b_4e80:
	ret ; $4e80
ShowRankingBoard:
	wram_bank $03 ; $4e81
	xor a ; $4e87
	ld [wRankingBoardSilent], a ; $4e88
	ld a, b ; $4e8b
	ld [wRankingBoardDoubles], a ; $4e8c
	ld a, c ; $4e8f
	ld [wRankingBoardPlayerRow], a ; $4e90
	ld a, d ; $4e93
	ld [wRankingBoardMode], a ; $4e94
	cp $03 ; $4e97
	jr nz, .checkFanfare ; $4e99
	xor a ; $4e9b
	ld [wRankingBoardMode], a ; $4e9c
	ld a, $01 ; $4e9f
	ld [wRankingBoardSilent], a ; $4ea1
.checkFanfare:
	ld a, [wRankingBoardMode] ; $4ea4
	cp $01 ; $4ea7
	jr nz, .checkSecondFanfare ; $4ea9
	sound $2b ; $4eab
	jr .draw ; $4ead
.checkSecondFanfare:
	cp $02 ; $4eaf
	jr nz, .draw ; $4eb1
	sound $2a ; $4eb3
.draw:
	call DisableLCDSafely ; $4eb5
	call BuildRankingBoardScreen ; $4eb8
	call EnableLCD ; $4ebb
	script_fade_in $04 ; $4ebe
	call WaitFadeEnd ; $4ec3
	wram_bank $03 ; $4ec6
	call DispatchRankingBoardAnim ; $4ecc
	call WaitFramesCmd ; $4ecf
	db $1e ; $4ed2 inline arg
	call WaitForAOrBPress ; $4ed3
	ld c, $20 ; $4ed6
	ld a, [wRankingBoardMode] ; $4ed8
	or a ; $4edb
	jr nz, .fadeOut ; $4edc
	ld a, [wRankingBoardSilent] ; $4ede
	or a ; $4ee1
	jr nz, .fadeOut ; $4ee2
	sound $7f ; $4ee4
	ld c, $02 ; $4ee6
.fadeOut:
	call BeginFadeOut ; $4ee8
	call WaitFadeEnd ; $4eeb
	call ClearFrameTasks ; $4eee
	ret ; $4ef1
BuildRankingBoardScreen:
	xor a ; $4ef2
	ldh [hScrollX], a ; $4ef3
	ldh [hScrollY], a ; $4ef5
	ld [wCameraX], a ; $4ef7
	ld [wCameraX + 1], a ; $4efa
	ld [wCameraY], a ; $4efd
	ld [wCameraY + 1], a ; $4f00
	farcall LoadMenuFontGfx ; $4f03
	farcall PrepareGlyphBuffer ; $4f06
	wram_bank $03 ; $4f09
	xor a ; $4f0f
	ld [wRankingBannerAnimFrame], a ; $4f10
	ld [wRankingAnimStateDone], a ; $4f13
	ld hl, wRankingMarkerSlots ; $4f16
	ld bc, $0053 ; $4f19
	call ClearBytes ; $4f1c
	call ClearRankingMarkerSlots ; $4f1f
	call LoadRankingMarkerCoords ; $4f22
	ld a, [wRankingBoardDoubles] ; $4f25
	or a ; $4f28
	jr z, .zero ; $4f29
	ld c, $2a ; $4f2b
	farcall LoadScreenAssetRecord ; $4f2d
	wram_bank $03 ; $4f30
	call DrawDoublesRankingNames ; $4f36
	call HighlightDoublesRankingRows ; $4f39
	jr .loadRankingBoardTiles ; $4f3c
.zero:
	ld c, $29 ; $4f3e
	farcall LoadScreenAssetRecord ; $4f40
	wram_bank $03 ; $4f43
	call DrawSinglesRankingNames ; $4f49
	call HighlightSinglesRankingRows ; $4f4c
.loadRankingBoardTiles:
	call LoadRankingBoardTiles ; $4f4f
	ld hl, RankingBoardScreenPalettes ; $4f52
	ld de, $0806 ; $4f55
	call LoadPaletteShadow ; $4f58
	ld a, $01 ; $4f5b
	ld hl, DrawRankingMarkersTask ; $4f5d
	call RegisterFrameTask ; $4f60
	ld a, [wRankingBoardMode] ; $4f63
	cp $02 ; $4f66
	jr nz, .queueWram3MapToVRAM ; $4f68
	ld a, $01 ; $4f6a
	ld hl, RankingCursorBobTask ; $4f6c
	call RegisterFrameTask ; $4f6f
.queueWram3MapToVRAM:
	farcall QueueWram3MapToVRAM ; $4f72
	ret ; $4f75
RankingBoardScreenPalettes:
	INCLUDE "data/bank_01b/palettes_4f76.asm" ; $4f76, 48 bytes (palettes)
LoadRankingBoardTiles:
	ldh a, [hWramBank] ; $4fa6
	push af ; $4fa8
	wram_bank $01 ; $4fa9
	ld hl, $3f30 ; $4faf -> DataPtr_BracketCharIcon00
	ld de, $d000 ; $4fb2
	call DecompressDataFromBank ; $4fb5
	ld hl, $d000 ; $4fb8
	ld de, $8000 + VRAM_BANK1 ; $4fbb
	ld c, $10 ; $4fbe
	call QueueVRAMCopy ; $4fc0
	ld hl, $3f32 ; $4fc3 -> DataPtr_BracketCharIcon01
	ld de, $d000 ; $4fc6
	call DecompressDataFromBank ; $4fc9
	ld hl, $d000 ; $4fcc
	ld de, $8100 + VRAM_BANK1 ; $4fcf
	ld c, $10 ; $4fd2
	call QueueVRAMCopy ; $4fd4
	ld hl, $3f34 ; $4fd7 -> DataPtr_BracketCharIcon02
	ld de, $d000 ; $4fda
	call DecompressDataFromBank ; $4fdd
	ld hl, $d000 ; $4fe0
	ld de, $8200 + VRAM_BANK1 ; $4fe3
	ld c, $10 ; $4fe6
	call QueueVRAMCopy ; $4fe8
	pop af ; $4feb
	wram_bank ; $4fec
	ret ; $4ff0
DispatchRankingBoardAnim:
	ld a, [wRankingBoardSilent] ; $4ff1
	or a ; $4ff4
	ret nz ; $4ff5
	ld a, [wRankingBoardMode] ; $4ff6
	cp $02 ; $4ff9
	ret z ; $4ffb
	ld a, [wRankingBoardDoubles] ; $4ffc
	or a ; $4fff
	jr nz, .nonZero2 ; $5000
	ld a, [wRankingBoardMode] ; $5002
	or a ; $5005
	jr nz, .nonZero ; $5006
	ld a, [wRankingBoardPlayerRow] ; $5008
	add a ; $500b
	ld hl, RankingBoardAnimHandlers2_1b ; $500c
	add l ; $500f
	ld l, a ; $5010
	jr nc, .read ; $5011
	inc h ; $5013
.read:
	ld a, [hl+] ; $5014
	ld h, [hl] ; $5015
	ld l, a ; $5016
	jp hl ; $5017
.nonZero:
	ld a, [wRankingBoardPlayerRow] ; $5018
	add a ; $501b
	ld hl, RankingBoardAnimHandlers1_1b ; $501c
	add l ; $501f
	ld l, a ; $5020
	jr nc, .readB ; $5021
	inc h ; $5023
.readB:
	ld a, [hl+] ; $5024
	ld h, [hl] ; $5025
	ld l, a ; $5026
	jp hl ; $5027
.nonZero2:
	ld a, [wRankingBoardMode] ; $5028
	or a ; $502b
	jr nz, .nonZero3 ; $502c
	ld a, [wRankingBoardPlayerRow] ; $502e
	add a ; $5031
	ld hl, RankingBoardAnimHandlers4_1b ; $5032
	add l ; $5035
	ld l, a ; $5036
	jr nc, .read2 ; $5037
	inc h ; $5039
.read2:
	ld a, [hl+] ; $503a
	ld h, [hl] ; $503b
	ld l, a ; $503c
	jp hl ; $503d
.nonZero3:
	ld a, [wRankingBoardPlayerRow] ; $503e
	add a ; $5041
	ld hl, RankingBoardAnimHandlers3_1b ; $5042
	add l ; $5045
	ld l, a ; $5046
	jr nc, .read3 ; $5047
	inc h ; $5049
.read3:
	ld a, [hl+] ; $504a
	ld h, [hl] ; $504b
	ld l, a ; $504c
	jp hl ; $504d
RankingBoardAnimNop_1b:
	ret ; $504e
RankingBoardAnimHandlers1_1b:
	; $504f, 10 bytes (records:2)
	dw RankingBoardAnimState_5077_1b ; record 0
	dw RankingBoardAnimState_5077_1b ; record 1
	dw RankingBoardAnimState_516f_1b ; record 2
	dw RankingBoardAnimState_5273_1b ; record 3
	dw RankingBoardAnimState_52eb_1b ; record 4
RankingBoardAnimHandlers2_1b:
	; $5059, 10 bytes (records:2)
	dw RankingBoardAnimState_52ff_1b ; record 0
	dw RankingBoardAnimState_52ff_1b ; record 1
	dw RankingBoardAnimState_5322_1b ; record 2
	dw RankingBoardAnimState_5349_1b ; record 3
	dw RankingBoardAnimState_5368_1b ; record 4
RankingBoardAnimHandlers3_1b:
	; $5063, 10 bytes (records:2)
	dw RankingBoardAnimState_5387_1b ; record 0
	dw RankingBoardAnimState_5387_1b ; record 1
	dw RankingBoardAnimState_53fa_1b ; record 2
	dw RankingBoardAnimState_546d_1b ; record 3
	dw RankingBoardAnimState_54a0_1b ; record 4
RankingBoardAnimHandlers4_1b:
	; $506d, 10 bytes (records:2)
	dw RankingBoardAnimState_54a3_1b ; record 0
	dw RankingBoardAnimState_54a3_1b ; record 1
	dw RankingBoardAnimState_54c2_1b ; record 2
	dw RankingBoardAnimState_54e5_1b ; record 3
	dw RankingBoardAnimState_5504_1b ; record 4
RankingBoardAnimState_5077_1b:
	ld a, $01 ; $5077
	ld hl, RankingBoardAnimTask_1b ; $5079
	call RegisterFrameTask ; $507c
	call WaitFramesCmd ; $507f
	db $8c ; $5082 inline arg
	sound $78 ; $5083
	ld c, $00 ; $5085
	call GetRankingMarkerSlot ; $5087
	ld de, RankingBoardAnimState_5077Table3 ; $508a
	call StartRankingMarkerAnim2 ; $508d
	ld c, $01 ; $5090
	call GetRankingMarkerSlot ; $5092
	ld de, RankingBoardAnimState_5077Table4 ; $5095
	call StartRankingMarkerAnim1 ; $5098
	ld b, $01 ; $509b
	call HighlightRankingRow ; $509d
	call PushRankingBoardTilemapRows ; $50a0
	call WaitFramesCmd ; $50a3
	db $1e ; $50a6 inline arg
	sound $80 ; $50a7
	ld c, $03 ; $50a9
	call GetRankingMarkerSlot ; $50ab
	ld de, RankingBoardAnimState_5077Table0 ; $50ae
	call StartRankingMarkerAnim0 ; $50b1
	ld c, $04 ; $50b4
	call GetRankingMarkerSlot ; $50b6
	ld de, RankingBoardAnimState_5077Table0 ; $50b9
	call StartRankingMarkerAnim1 ; $50bc
	call WaitFramesCmd ; $50bf
	db $5a ; $50c2 inline arg
	sound $78 ; $50c3
	ld c, $03 ; $50c5
	call GetRankingMarkerSlot ; $50c7
	ld de, RankingBoardAnimState_5077Table3 ; $50ca
	call StartRankingMarkerAnim2 ; $50cd
	ld c, $04 ; $50d0
	call GetRankingMarkerSlot ; $50d2
	ld de, RankingBoardAnimState_5077Table4 ; $50d5
	call StartRankingMarkerAnim1 ; $50d8
	ld b, $02 ; $50db
	call HighlightRankingRow ; $50dd
	call PushRankingBoardTilemapRows ; $50e0
	call WaitFramesCmd ; $50e3
	db $1e ; $50e6 inline arg
	sound $80 ; $50e7
	ld c, $06 ; $50e9
	call GetRankingMarkerSlot ; $50eb
	ld de, RankingBoardAnimState_5077Table2 ; $50ee
	call StartRankingMarkerAnim0 ; $50f1
	ld c, $07 ; $50f4
	call GetRankingMarkerSlot ; $50f6
	ld de, RankingBoardAnimState_5077Table2 ; $50f9
	call StartRankingMarkerAnim1 ; $50fc
	call WaitFramesCmd ; $50ff
	db $5a ; $5102 inline arg
	sound $78 ; $5103
	ld c, $06 ; $5105
	call GetRankingMarkerSlot ; $5107
	ld de, RankingBoardAnimState_5077Table3 ; $510a
	call StartRankingMarkerAnim2 ; $510d
	ld c, $07 ; $5110
	call GetRankingMarkerSlot ; $5112
	ld de, RankingBoardAnimState_5077Table1 ; $5115
	call StartRankingMarkerAnim1 ; $5118
	ld b, $03 ; $511b
	call HighlightRankingRow ; $511d
	call PushRankingBoardTilemapRows ; $5120
	call WaitFramesCmd ; $5123
	db $1e ; $5126 inline arg
	sound $80 ; $5127
	ld c, $09 ; $5129
	call GetRankingMarkerSlot ; $512b
	ld de, RankingBoardAnimState_5077Table2 ; $512e
	call StartRankingMarkerAnim0 ; $5131
	ld c, $0a ; $5134
	call GetRankingMarkerSlot ; $5136
	ld de, RankingBoardAnimState_5077Table2 ; $5139
	call StartRankingMarkerAnim1 ; $513c
	call WaitFramesCmd ; $513f
	db $5a ; $5142 inline arg
	sound $78 ; $5143
	ld c, $09 ; $5145
	call GetRankingMarkerSlot ; $5147
	ld de, RankingBoardAnimState_5077Table3 ; $514a
	call StartRankingMarkerAnim2 ; $514d
	ld c, $0a ; $5150
	call GetRankingMarkerSlot ; $5152
	ld de, RankingBoardAnimState_5077Table1 ; $5155
	call StartRankingMarkerAnim1 ; $5158
	ld b, $04 ; $515b
	call HighlightRankingRow ; $515d
	call PushRankingBoardTilemapRows ; $5160
	call WaitFramesCmd ; $5163
	db $1e ; $5166 inline arg
	ld a, $01 ; $5167
	ld [wRankingAnimStateDone], a ; $5169
	jp RankingBoardAnimNop_1b ; $516c
RankingBoardAnimState_516f_1b:
	ld a, $01 ; $516f
	ld hl, RankingBoardAnimTask_1b ; $5171
	call RegisterFrameTask ; $5174
	call WaitFramesCmd ; $5177
	db $8c ; $517a inline arg
	sound $78 ; $517b
	ld c, $00 ; $517d
	call GetRankingMarkerSlot ; $517f
	ld de, RankingBoardAnimState_516fTable0 ; $5182
	call StartRankingMarkerAnim2 ; $5185
	ld c, $02 ; $5188
	call GetRankingMarkerSlot ; $518a
	ld de, RankingBoardAnimState_516fTable3 ; $518d
	call StartRankingMarkerAnim1 ; $5190
	ld b, $05 ; $5193
	call HighlightRankingRow ; $5195
	call PushRankingBoardTilemapRows ; $5198
	call WaitFramesCmd ; $519b
	db $1e ; $519e inline arg
	sound $80 ; $519f
	ld c, $05 ; $51a1
	call GetRankingMarkerSlot ; $51a3
	ld de, RankingBoardAnimState_516fTable0 ; $51a6
	call StartRankingMarkerAnim1 ; $51a9
	call WaitFramesCmd ; $51ac
	db $04 ; $51af inline arg
	ld c, $03 ; $51b0
	call GetRankingMarkerSlot ; $51b2
	ld de, RankingBoardAnimState_516fTable2 ; $51b5
	call StartRankingMarkerAnim0 ; $51b8
	call WaitFramesCmd ; $51bb
	db $78 ; $51be inline arg
	sound $78 ; $51bf
	ld c, $05 ; $51c1
	call GetRankingMarkerSlot ; $51c3
	ld de, RankingBoardAnimState_516fTable3 ; $51c6
	call StartRankingMarkerAnim3 ; $51c9
	ld c, $03 ; $51cc
	call GetRankingMarkerSlot ; $51ce
	ld de, RankingBoardAnimState_516fTable5 ; $51d1
	call StartRankingMarkerAnim0 ; $51d4
	ld b, $06 ; $51d7
	call HighlightRankingRow ; $51d9
	call PushRankingBoardTilemapRows ; $51dc
	call WaitFramesCmd ; $51df
	db $1e ; $51e2 inline arg
	sound $80 ; $51e3
	ld c, $08 ; $51e5
	call GetRankingMarkerSlot ; $51e7
	ld de, RankingBoardAnimState_516fTable4 ; $51ea
	call StartRankingMarkerAnim1 ; $51ed
	call WaitFramesCmd ; $51f0
	db $04 ; $51f3 inline arg
	ld c, $06 ; $51f4
	call GetRankingMarkerSlot ; $51f6
	ld de, RankingBoardAnimState_516fTable5 ; $51f9
	call StartRankingMarkerAnim0 ; $51fc
	call WaitFramesCmd ; $51ff
	db $5a ; $5202 inline arg
	sound $78 ; $5203
	ld c, $08 ; $5205
	call GetRankingMarkerSlot ; $5207
	ld de, RankingBoardAnimState_516fTable3 ; $520a
	call StartRankingMarkerAnim3 ; $520d
	ld c, $06 ; $5210
	call GetRankingMarkerSlot ; $5212
	ld de, RankingBoardAnimState_516fTable2 ; $5215
	call StartRankingMarkerAnim0 ; $5218
	ld b, $07 ; $521b
	call HighlightRankingRow ; $521d
	call PushRankingBoardTilemapRows ; $5220
	call WaitFramesCmd ; $5223
	db $1e ; $5226 inline arg
	sound $80 ; $5227
	ld c, $0b ; $5229
	call GetRankingMarkerSlot ; $522b
	ld de, RankingBoardAnimState_516fTable4 ; $522e
	call StartRankingMarkerAnim1 ; $5231
	call WaitFramesCmd ; $5234
	db $04 ; $5237 inline arg
	ld c, $09 ; $5238
	call GetRankingMarkerSlot ; $523a
	ld de, RankingBoardAnimState_516fTable5 ; $523d
	call StartRankingMarkerAnim0 ; $5240
	call WaitFramesCmd ; $5243
	db $5a ; $5246 inline arg
	sound $78 ; $5247
	ld c, $0b ; $5249
	call GetRankingMarkerSlot ; $524b
	ld de, RankingBoardAnimState_516fTable1 ; $524e
	call StartRankingMarkerAnim1 ; $5251
	ld c, $09 ; $5254
	call GetRankingMarkerSlot ; $5256
	ld de, RankingBoardAnimState_516fTable0 ; $5259
	call StartRankingMarkerAnim2 ; $525c
	ld b, $08 ; $525f
	call HighlightRankingRow ; $5261
	call PushRankingBoardTilemapRows ; $5264
	call WaitFramesCmd ; $5267
	db $1e ; $526a inline arg
	ld a, $01 ; $526b
	ld [wRankingAnimStateDone], a ; $526d
	jp RankingBoardAnimNop_1b ; $5270
RankingBoardAnimState_5273_1b:
	ld a, $01 ; $5273
	ld hl, RankingBoardAnimTask_1b ; $5275
	call RegisterFrameTask ; $5278
	call WaitFramesCmd ; $527b
	db $8c ; $527e inline arg
	sound $78 ; $527f
	ld c, $00 ; $5281
	call GetRankingMarkerSlot ; $5283
	ld de, RankingBoardAnimState_5273Table0 ; $5286
	call StartRankingMarkerAnim2 ; $5289
	ld c, $05 ; $528c
	call GetRankingMarkerSlot ; $528e
	ld de, RankingBoardAnimState_516fTable5 ; $5291
	call StartRankingMarkerAnim0 ; $5294
	ld b, $09 ; $5297
	call HighlightRankingRow ; $5299
	call PushRankingBoardTilemapRows ; $529c
	call WaitFramesCmd ; $529f
	db $5a ; $52a2 inline arg
	sound $80 ; $52a3
	ld c, $08 ; $52a5
	call GetRankingMarkerSlot ; $52a7
	ld de, RankingBoardAnimState_516fTable5 ; $52aa
	call StartRankingMarkerAnim0 ; $52ad
	ld c, $09 ; $52b0
	call GetRankingMarkerSlot ; $52b2
	ld de, RankingBoardAnimState_516fTable5 ; $52b5
	call StartRankingMarkerAnim1 ; $52b8
	call WaitFramesCmd ; $52bb
	db $5a ; $52be inline arg
	sound $78 ; $52bf
	ld c, $08 ; $52c1
	call GetRankingMarkerSlot ; $52c3
	ld de, RankingBoardAnimState_5077Table1 ; $52c6
	call StartRankingMarkerAnim0 ; $52c9
	ld c, $09 ; $52cc
	call GetRankingMarkerSlot ; $52ce
	ld de, RankingBoardAnimState_5273Table1 ; $52d1
	call StartRankingMarkerAnim3 ; $52d4
	ld b, $0a ; $52d7
	call HighlightRankingRow ; $52d9
	call PushRankingBoardTilemapRows ; $52dc
	call WaitFramesCmd ; $52df
	db $1e ; $52e2 inline arg
	ld a, $01 ; $52e3
	ld [wRankingAnimStateDone], a ; $52e5
	jp RankingBoardAnimNop_1b ; $52e8
RankingBoardAnimState_52eb_1b:
	ld a, $01 ; $52eb
	ld hl, RankingBoardAnimTask_1b ; $52ed
	call RegisterFrameTask ; $52f0
	call WaitFramesCmd ; $52f3
	db $8c ; $52f6 inline arg
	ld a, $01 ; $52f7
	ld [wRankingAnimStateDone], a ; $52f9
	jp RankingBoardAnimNop_1b ; $52fc
RankingBoardAnimState_52ff_1b:
	call WaitFramesCmd ; $52ff
	db $14 ; $5302 inline arg
	sound $80 ; $5303
	ld c, $00 ; $5305
	call GetRankingMarkerSlot ; $5307
	ld de, RankingBoardAnimState_5077Table0 ; $530a
	call StartRankingMarkerAnim0 ; $530d
	ld c, $01 ; $5310
	call GetRankingMarkerSlot ; $5312
	ld de, RankingBoardAnimState_5077Table0 ; $5315
	call StartRankingMarkerAnim1 ; $5318
	call WaitFramesCmd ; $531b
	db $14 ; $531e inline arg
	jp RankingBoardAnimNop_1b ; $531f
RankingBoardAnimState_5322_1b:
	call WaitFramesCmd ; $5322
	db $0a ; $5325 inline arg
	sound $80 ; $5326
	ld c, $02 ; $5328
	call GetRankingMarkerSlot ; $532a
	ld de, RankingBoardAnimState_516fTable0 ; $532d
	call StartRankingMarkerAnim1 ; $5330
	call WaitFramesCmd ; $5333
	db $04 ; $5336 inline arg
	ld c, $00 ; $5337
	call GetRankingMarkerSlot ; $5339
	ld de, RankingBoardAnimState_516fTable2 ; $533c
	call StartRankingMarkerAnim0 ; $533f
	call WaitFramesCmd ; $5342
	db $14 ; $5345 inline arg
	jp RankingBoardAnimNop_1b ; $5346
RankingBoardAnimState_5349_1b:
	call WaitFramesCmd ; $5349
	db $14 ; $534c inline arg
	sound $80 ; $534d
	ld c, $00 ; $534f
	call GetRankingMarkerSlot ; $5351
	ld de, RankingBoardAnimState_5077Table0 ; $5354
	call StartRankingMarkerAnim0 ; $5357
	ld c, $05 ; $535a
	call GetRankingMarkerSlot ; $535c
	ld de, RankingBoardAnimState_5077Table0 ; $535f
	call StartRankingMarkerAnim1 ; $5362
	jp RankingBoardAnimNop_1b ; $5365
RankingBoardAnimState_5368_1b:
	call WaitFramesCmd ; $5368
	db $1e ; $536b inline arg
	sound $80 ; $536c
	ld c, $00 ; $536e
	call GetRankingMarkerSlot ; $5370
	ld de, RankingBoardAnimState_5368Table0 ; $5373
	call StartRankingMarkerAnim0 ; $5376
	ld c, $09 ; $5379
	call GetRankingMarkerSlot ; $537b
	ld de, RankingBoardAnimState_5368Table1 ; $537e
	call StartRankingMarkerAnim1 ; $5381
	jp RankingBoardAnimNop_1b ; $5384
RankingBoardAnimState_5387_1b:
	ld a, $01 ; $5387
	ld hl, RankingBoardAnimTask_1b ; $5389
	call RegisterFrameTask ; $538c
	call WaitFramesCmd ; $538f
	db $8c ; $5392 inline arg
	sound $78 ; $5393
	ld c, $00 ; $5395
	call GetRankingMarkerSlot ; $5397
	ld de, RankingBoardAnimState_5387Table1 ; $539a
	call StartRankingMarkerAnim2 ; $539d
	ld c, $01 ; $53a0
	call GetRankingMarkerSlot ; $53a2
	ld de, RankingBoardAnimState_516fTable5 ; $53a5
	call StartRankingMarkerAnim1 ; $53a8
	ld b, $01 ; $53ab
	call HighlightDoublesRankingRow ; $53ad
	call PushRankingBoardTilemapRows ; $53b0
	call WaitFramesCmd ; $53b3
	db $5a ; $53b6 inline arg
	sound $80 ; $53b7
	ld c, $03 ; $53b9
	call GetRankingMarkerSlot ; $53bb
	ld de, RankingBoardAnimState_516fTable5 ; $53be
	call StartRankingMarkerAnim0 ; $53c1
	ld c, $04 ; $53c4
	call GetRankingMarkerSlot ; $53c6
	ld de, RankingBoardAnimState_5077Table2 ; $53c9
	call StartRankingMarkerAnim1 ; $53cc
	call WaitFramesCmd ; $53cf
	db $5a ; $53d2 inline arg
	sound $78 ; $53d3
	ld c, $03 ; $53d5
	call GetRankingMarkerSlot ; $53d7
	ld de, RankingBoardAnimState_5387Table1 ; $53da
	call StartRankingMarkerAnim2 ; $53dd
	ld c, $04 ; $53e0
	call GetRankingMarkerSlot ; $53e2
	ld de, RankingBoardAnimState_5387Table0 ; $53e5
	call StartRankingMarkerAnim1 ; $53e8
	ld b, $02 ; $53eb
	call HighlightDoublesRankingRow ; $53ed
	call PushRankingBoardTilemapRows ; $53f0
	call WaitFramesCmd ; $53f3
	db $5a ; $53f6 inline arg
	jp RankingBoardAnimNop_1b ; $53f7
RankingBoardAnimState_53fa_1b:
	ld a, $01 ; $53fa
	ld hl, RankingBoardAnimTask_1b ; $53fc
	call RegisterFrameTask ; $53ff
	call WaitFramesCmd ; $5402
	db $8c ; $5405 inline arg
	sound $78 ; $5406
	ld c, $00 ; $5408
	call GetRankingMarkerSlot ; $540a
	ld de, RankingBoardAnimState_53faTable ; $540d
	call StartRankingMarkerAnim2 ; $5410
	ld c, $02 ; $5413
	call GetRankingMarkerSlot ; $5415
	ld de, RankingBoardAnimState_516fTable3 ; $5418
	call StartRankingMarkerAnim1 ; $541b
	ld b, $03 ; $541e
	call HighlightDoublesRankingRow ; $5420
	call PushRankingBoardTilemapRows ; $5423
	call WaitFramesCmd ; $5426
	db $5a ; $5429 inline arg
	sound $80 ; $542a
	ld c, $03 ; $542c
	call GetRankingMarkerSlot ; $542e
	ld de, RankingBoardAnimState_516fTable5 ; $5431
	call StartRankingMarkerAnim0 ; $5434
	ld c, $05 ; $5437
	call GetRankingMarkerSlot ; $5439
	ld de, RankingBoardAnimState_516fTable3 ; $543c
	call StartRankingMarkerAnim1 ; $543f
	call WaitFramesCmd ; $5442
	db $8c ; $5445 inline arg
	sound $78 ; $5446
	ld c, $03 ; $5448
	call GetRankingMarkerSlot ; $544a
	ld de, RankingBoardAnimState_53faTable ; $544d
	call StartRankingMarkerAnim2 ; $5450
	ld c, $05 ; $5453
	call GetRankingMarkerSlot ; $5455
	ld de, RankingBoardAnimState_516fTable0 ; $5458
	call StartRankingMarkerAnim1 ; $545b
	ld b, $04 ; $545e
	call HighlightDoublesRankingRow ; $5460
	call PushRankingBoardTilemapRows ; $5463
	call WaitFramesCmd ; $5466
	db $1e ; $5469 inline arg
	jp RankingBoardAnimNop_1b ; $546a
RankingBoardAnimState_546d_1b:
	ld a, $01 ; $546d
	ld hl, RankingBoardAnimTask_1b ; $546f
	call RegisterFrameTask ; $5472
	call WaitFramesCmd ; $5475
	db $8c ; $5478 inline arg
	sound $78 ; $5479
	ld c, $00 ; $547b
	call GetRankingMarkerSlot ; $547d
	ld de, RankingBoardAnimState_546dTable ; $5480
	call StartRankingMarkerAnim0 ; $5483
	ld c, $03 ; $5486
	call GetRankingMarkerSlot ; $5488
	ld de, RankingBoardAnimState_5077Table0 ; $548b
	call StartRankingMarkerAnim1 ; $548e
	ld b, $06 ; $5491
	call HighlightDoublesRankingRow ; $5493
	call PushRankingBoardTilemapRows ; $5496
	call WaitFramesCmd ; $5499
	db $1e ; $549c inline arg
	jp RankingBoardAnimNop_1b ; $549d
RankingBoardAnimState_54a0_1b:
	jp RankingBoardAnimNop_1b ; $54a0
RankingBoardAnimState_54a3_1b:
	call WaitFramesCmd ; $54a3
	db $1e ; $54a6 inline arg
	sound $80 ; $54a7
	ld c, $00 ; $54a9
	call GetRankingMarkerSlot ; $54ab
	ld de, RankingBoardAnimState_5077Table0 ; $54ae
	call StartRankingMarkerAnim0 ; $54b1
	ld c, $01 ; $54b4
	call GetRankingMarkerSlot ; $54b6
	ld de, RankingBoardAnimState_5077Table0 ; $54b9
	call StartRankingMarkerAnim1 ; $54bc
	jp RankingBoardAnimNop_1b ; $54bf
RankingBoardAnimState_54c2_1b:
	call WaitFramesCmd ; $54c2
	db $1e ; $54c5 inline arg
	sound $80 ; $54c6
	ld c, $02 ; $54c8
	call GetRankingMarkerSlot ; $54ca
	ld de, RankingBoardAnimState_516fTable0 ; $54cd
	call StartRankingMarkerAnim1 ; $54d0
	call WaitFramesCmd ; $54d3
	db $08 ; $54d6 inline arg
	ld c, $00 ; $54d7
	call GetRankingMarkerSlot ; $54d9
	ld de, RankingBoardAnimState_5077Table0 ; $54dc
	call StartRankingMarkerAnim0 ; $54df
	jp RankingBoardAnimNop_1b ; $54e2
RankingBoardAnimState_54e5_1b:
	call WaitFramesCmd ; $54e5
	db $1e ; $54e8 inline arg
	sound $80 ; $54e9
	ld c, $00 ; $54eb
	call GetRankingMarkerSlot ; $54ed
	ld de, RankingBoardAnimState_5077Table0 ; $54f0
	call StartRankingMarkerAnim0 ; $54f3
	ld c, $03 ; $54f6
	call GetRankingMarkerSlot ; $54f8
	ld de, RankingBoardAnimState_5077Table2 ; $54fb
	call StartRankingMarkerAnim1 ; $54fe
	jp RankingBoardAnimNop_1b ; $5501
RankingBoardAnimState_5504_1b:
	jp RankingBoardAnimNop_1b ; $5504
WaitForAOrBPress:
	call AdvanceFrame ; $5507
	ldh a, [hInputPressed] ; $550a
	and PADF_A | PADF_B ; $550c
	jr z, WaitForAOrBPress ; $550e
	ret ; $5510
DrawSinglesRankingNames:
	call InitRankingNameRender ; $5511
	wram_bank $03 ; $5514
	call ClearSinglesRankingNameRects ; $551a
	ld hl, wStoryModeNameOfMainCharacter ; $551d
	ld de, wShadowTilemap + 1 * TILEMAP_WIDTH + 1 ; $5520
	call RenderPlayerNameFitted ; $5523
	ld b, $01 ; $5526
.loop:
	call DrawSinglesRankingEntry ; $5528
	ld a, b ; $552b
	inc a ; $552c
	ld b, a ; $552d
	cp $0c ; $552e
	jr nz, .loop ; $5530
	farcall UploadGlyphBuffer ; $5532
	ret ; $5535
DrawSinglesRankingEntry:
	push af ; $5536
	push bc ; $5537
	push de ; $5538
	push hl ; $5539
	ld a, b ; $553a
	add a ; $553b
	ld hl, SinglesRankingEntryTable1 ; $553c
	add l ; $553f
	ld l, a ; $5540
	jr nc, .read ; $5541
	inc h ; $5543
.read:
	ld a, [hl+] ; $5544
	ld d, [hl] ; $5545
	ld e, a ; $5546
	ld a, b ; $5547
	add a ; $5548
	ld hl, SinglesRankingEntryTable ; $5549
	add l ; $554c
	ld l, a ; $554d
	jr nc, .readB ; $554e
	inc h ; $5550
.readB:
	ld a, [hl+] ; $5551
	ld h, [hl] ; $5552
	ld l, a ; $5553
	ld c, $05 ; $5554
	farcall RenderProportionalTextAt ; $5556
	pop hl ; $5559
	pop de ; $555a
	pop bc ; $555b
	pop af ; $555c
	ret ; $555d
SinglesRankingEntryTable:
	; $555e, 24 bytes (records:2)
	dw $0000 ; record 0
	dw $0029 ; record 1
	dw $002b ; record 2
	dw $002d ; record 3
	dw $004e ; record 4
	dw $002c ; record 5
	dw $004f ; record 6
	dw $0028 ; record 7
	dw $004b ; record 8
	dw $002e ; record 9
	dw $002a ; record 10
	dw $0027 ; record 11
SinglesRankingEntryTable1:
	; $5576, 24 bytes (ram_ptrs:3)
	dw wShadowTilemap + 1 * TILEMAP_WIDTH + 1 ; record 0
	dw wShadowTilemap + 4 * TILEMAP_WIDTH + 1 ; record 1
	dw wShadowTilemap + 7 * TILEMAP_WIDTH + 1 ; record 2
	dw wShadowTilemap + 10 * TILEMAP_WIDTH + 1 ; record 3
	dw wShadowTilemap + 13 * TILEMAP_WIDTH + 1 ; record 4
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; record 5
	dw wShadowTilemap + 1 * TILEMAP_WIDTH + 14 ; record 6
	dw wShadowTilemap + 4 * TILEMAP_WIDTH + 14 ; record 7
	dw wShadowTilemap + 7 * TILEMAP_WIDTH + 14 ; record 8
	dw wShadowTilemap + 10 * TILEMAP_WIDTH + 14 ; record 9
	dw wShadowTilemap + 13 * TILEMAP_WIDTH + 14 ; record 10
	dw wShadowTilemap + 16 * TILEMAP_WIDTH + 14 ; record 11
ClearSinglesRankingNameRects:
	push af ; $558e
	push bc ; $558f
	push de ; $5590
	push hl ; $5591
	ld b, $00 ; $5592
	ld de, wShadowAttrmap + 1 ; $5594
.loop:
	push bc ; $5597
	ld h, $00 ; $5598
	ld b, $05 ; $559a
	ld c, $02 ; $559c
	farcall FillTilemapRect ; $559e
	ld hl, $0060 ; $55a1
	add hl, de ; $55a4
	ld d, h ; $55a5
	ld e, l ; $55a6
	pop bc ; $55a7
	ld a, b ; $55a8
	inc a ; $55a9
	ld b, a ; $55aa
	cp $06 ; $55ab
	jr nz, .loop ; $55ad
	ld de, wShadowAttrmap + 14 ; $55af
	ld b, $00 ; $55b2
.loopB:
	push bc ; $55b4
	ld h, $01 ; $55b5
	ld b, $05 ; $55b7
	ld c, $02 ; $55b9
	farcall FillTilemapRect ; $55bb
	ld hl, $0060 ; $55be
	add hl, de ; $55c1
	ld d, h ; $55c2
	ld e, l ; $55c3
	pop bc ; $55c4
	ld a, b ; $55c5
	inc a ; $55c6
	ld b, a ; $55c7
	cp $06 ; $55c8
	jr nz, .loopB ; $55ca
	pop hl ; $55cc
	pop de ; $55cd
	pop bc ; $55ce
	pop af ; $55cf
	ret ; $55d0
DrawDoublesRankingNames:
	call InitRankingNameRender ; $55d1
	wram_bank $03 ; $55d4
	call ClearDoublesRankingNameRects ; $55da
	ld hl, wStoryModeNameOfMainCharacter ; $55dd
	ld de, wShadowTilemap + 2 * TILEMAP_WIDTH + 1 ; $55e0
	call RenderPlayerNameFitted ; $55e3
	ld hl, wStoryModeNameOfPartnerCharacter ; $55e6
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH + 1 ; $55e9
	call RenderPlayerNameFitted ; $55ec
	ld b, $02 ; $55ef
.loop:
	call DrawDoublesRankingEntry ; $55f1
	ld a, b ; $55f4
	inc a ; $55f5
	ld b, a ; $55f6
	cp $0c ; $55f7
	jr nz, .loop ; $55f9
	farcall UploadGlyphBuffer ; $55fb
	ret ; $55fe
DrawDoublesRankingEntry:
	push af ; $55ff
	push bc ; $5600
	push de ; $5601
	push hl ; $5602
	ld a, b ; $5603
	add a ; $5604
	ld hl, DoublesRankingEntryTable1 ; $5605
	add l ; $5608
	ld l, a ; $5609
	jr nc, .read ; $560a
	inc h ; $560c
.read:
	ld a, [hl+] ; $560d
	ld d, [hl] ; $560e
	ld e, a ; $560f
	ld a, b ; $5610
	add a ; $5611
	ld hl, DoublesRankingEntryTable ; $5612
	add l ; $5615
	ld l, a ; $5616
	jr nc, .readB ; $5617
	inc h ; $5619
.readB:
	ld a, [hl+] ; $561a
	ld h, [hl] ; $561b
	ld l, a ; $561c
	ld c, $05 ; $561d
	farcall RenderProportionalTextAt ; $561f
	pop hl ; $5622
	pop de ; $5623
	pop bc ; $5624
	pop af ; $5625
	ret ; $5626
DoublesRankingEntryTable:
	; $5627, 26 bytes (records:2)
	dw $0000 ; record 0
	dw $0000 ; record 1
	dw $0029 ; record 2
	dw $0028 ; record 3
	dw $002b ; record 4
	dw $002a ; record 5
	dw $002e ; record 6
	dw $002d ; record 7
	dw $004e ; record 8
	dw $0050 ; record 9
	dw $004b ; record 10
	dw $004c ; record 11
	dw $002b ; record 12
DoublesRankingEntryTable1:
	; $5641, 24 bytes (ram_ptrs:3)
	dw wShadowTilemap + 2 * TILEMAP_WIDTH + 1 ; record 0
	dw wShadowTilemap + 4 * TILEMAP_WIDTH + 1 ; record 1
	dw wShadowTilemap + 7 * TILEMAP_WIDTH + 1 ; record 2
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 1 ; record 3
	dw wShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; record 4
	dw wShadowTilemap + 14 * TILEMAP_WIDTH + 1 ; record 5
	dw wShadowTilemap + 2 * TILEMAP_WIDTH + 14 ; record 6
	dw wShadowTilemap + 4 * TILEMAP_WIDTH + 14 ; record 7
	dw wShadowTilemap + 7 * TILEMAP_WIDTH + 14 ; record 8
	dw wShadowTilemap + 9 * TILEMAP_WIDTH + 14 ; record 9
	dw wShadowTilemap + 12 * TILEMAP_WIDTH + 14 ; record 10
	dw wShadowTilemap + 14 * TILEMAP_WIDTH + 14 ; record 11
ClearDoublesRankingNameRects:
	push af ; $5659
	push bc ; $565a
	push de ; $565b
	push hl ; $565c
	ld b, $00 ; $565d
	ld de, wShadowAttrmap + 1 * TILEMAP_WIDTH + 1 ; $565f
.loop:
	push bc ; $5662
	ld h, $00 ; $5663
	ld b, $05 ; $5665
	ld c, $04 ; $5667
	farcall FillTilemapRect ; $5669
	ld hl, $00a0 ; $566c
	add hl, de ; $566f
	ld d, h ; $5670
	ld e, l ; $5671
	pop bc ; $5672
	ld a, b ; $5673
	inc a ; $5674
	ld b, a ; $5675
	cp $03 ; $5676
	jr nz, .loop ; $5678
	ld de, wShadowAttrmap + 1 * TILEMAP_WIDTH + 14 ; $567a
	ld b, $00 ; $567d
.loopB:
	push bc ; $567f
	ld h, $01 ; $5680
	ld b, $05 ; $5682
	ld c, $04 ; $5684
	farcall FillTilemapRect ; $5686
	ld hl, $00a0 ; $5689
	add hl, de ; $568c
	ld d, h ; $568d
	ld e, l ; $568e
	pop bc ; $568f
	ld a, b ; $5690
	inc a ; $5691
	ld b, a ; $5692
	cp $03 ; $5693
	jr nz, .loopB ; $5695
	pop hl ; $5697
	pop de ; $5698
	pop bc ; $5699
	pop af ; $569a
	ret ; $569b
InitRankingNameRender:
	farcall InitTextWindows ; $569c
	wram_bank $05 ; $569f
	ld a, $03 ; $56a5
	ld [wShadowTilemapBank], a ; $56a7
	ld a, $00 ; $56aa
	ld [wWindowTileAttr], a ; $56ac
	farcall PrepareGlyphBuffer ; $56af
	ret ; $56b2
RenderPlayerNameFitted:
	call GetStringLength ; $56b3
	cp $06 ; $56b6
	jr nc, .renderNameTwoRows ; $56b8
	call DrawNameWithDiacritics ; $56ba
	ret ; $56bd
.renderNameTwoRows:
	call RenderNameTwoRows ; $56be
	ret ; $56c1
GetStringLength:
	push hl ; $56c2
	push bc ; $56c3
	ld c, $ff ; $56c4
.loop:
	inc c ; $56c6
	ld a, [hl+] ; $56c7
	or a ; $56c8
	jr nz, .loop ; $56c9
	ld a, c ; $56cb
	pop bc ; $56cc
	pop hl ; $56cd
	ret ; $56ce
RenderNameTwoRows:
	push hl ; $56cf
	push de ; $56d0
	push hl ; $56d1
	ld hl, $ffe0 ; $56d2
	add hl, de ; $56d5
	ld d, h ; $56d6
	ld e, l ; $56d7
	pop hl ; $56d8
	call RenderNameTopRow ; $56d9
	pop de ; $56dc
	pop hl ; $56dd
	call RenderNameBottomRow ; $56de
	ret ; $56e1
RenderNameTopRow:
	push de ; $56e2
	ld de, $d860 ; $56e3
	ld bc, $0004 ; $56e6
	call CopyMemoryBC ; $56e9
	ld a, $2d ; $56ec
	ld [de], a ; $56ee
	inc de ; $56ef
	xor a ; $56f0
	ld [de], a ; $56f1
	pop de ; $56f2
	ld hl, $d860 ; $56f3
	call DrawNameWithDiacritics ; $56f6
	ret ; $56f9
RenderNameBottomRow:
	push de ; $56fa
	ld bc, $0004 ; $56fb
	add hl, bc ; $56fe
	ld de, $d860 ; $56ff
	ld bc, $0007 ; $5702
	call CopyMemoryBC ; $5705
	pop de ; $5708
	ld hl, $d860 ; $5709
	call DrawNameWithDiacritics ; $570c
	ret ; $570f
HighlightSinglesRankingRows:
	ld a, [wRankingBoardPlayerRow] ; $5710
	or a ; $5713
	ret z ; $5714
	cp $01 ; $5715
	ret z ; $5717
	cp $02 ; $5718
	jr nz, .compare ; $571a
	ld b, $01 ; $571c
	call HighlightRankingRow ; $571e
	ld b, $02 ; $5721
	call HighlightRankingRow ; $5723
	ld b, $03 ; $5726
	call HighlightRankingRow ; $5728
	ld b, $04 ; $572b
	call HighlightRankingRow ; $572d
	ret ; $5730
.compare:
	cp $03 ; $5731
	jr nz, .ne03 ; $5733
	ld b, $05 ; $5735
	call HighlightRankingRow ; $5737
	ld b, $06 ; $573a
	call HighlightRankingRow ; $573c
	ld b, $07 ; $573f
	call HighlightRankingRow ; $5741
	ld b, $08 ; $5744
	call HighlightRankingRow ; $5746
	ret ; $5749
.ne03:
	ld b, $0b ; $574a
	call HighlightRankingRow ; $574c
	ret ; $574f
HighlightRankingRow:
	ld a, b ; $5750
	or a ; $5751
	ret z ; $5752
	add a ; $5753
	ld hl, RankingRowDrawHandlers_1b ; $5754
	add l ; $5757
	ld l, a ; $5758
	jr nc, .jumpToHandler ; $5759
	inc h ; $575b
.jumpToHandler:
	ld a, [hl+] ; $575c
	ld h, [hl] ; $575d
	ld l, a ; $575e
	jp hl ; $575f
StubNop_1b_5760:
	ret ; $5760
RankingRowDrawHandlers_1b:
	dw DrawRankingRow0 ; $5761 jumptable
	dw DrawRankingRow0 ; $5763 jumptable
	dw DrawRankingRow2 ; $5765 jumptable
	dw DrawRankingRow3 ; $5767 jumptable
	dw DrawRankingRow4 ; $5769 jumptable
	dw DrawRankingRow5 ; $576b jumptable
	dw DrawRankingRow6 ; $576d jumptable
	dw DrawRankingRow7 ; $576f jumptable
	dw DrawRankingRow8 ; $5771 jumptable
	dw DrawRankingRow9 ; $5773 jumptable
	dw DrawRankingRow10 ; $5775 jumptable
	dw DrawRankingRow11 ; $5777 jumptable
DrawRankingRow0:
	ld hl, $d240 ; $5779
	ld de, $d026 ; $577c
	ld b, $05 ; $577f
	ld c, $02 ; $5781
	farcall CopyTilemapRect ; $5783
	jp StubNop_1b_5760 ; $5786
DrawRankingRow2:
	ld hl, $d280 ; $5789
	ld de, $d146 ; $578c
	ld b, $04 ; $578f
	ld c, $02 ; $5791
	farcall CopyTilemapRect ; $5793
	jp StubNop_1b_5760 ; $5796
DrawRankingRow3:
	ld hl, $d244 ; $5799
	ld de, $d02a ; $579c
	ld b, $04 ; $579f
	ld c, $02 ; $57a1
	farcall CopyTilemapRect ; $57a3
	jp StubNop_1b_5760 ; $57a6
DrawRankingRow4:
	ld hl, $d284 ; $57a9
	ld de, $d14a ; $57ac
	ld b, $04 ; $57af
	ld c, $02 ; $57b1
	farcall CopyTilemapRect ; $57b3
	jp StubNop_1b_5760 ; $57b6
DrawRankingRow5:
	ld hl, $d2c0 ; $57b9
	ld de, $d026 ; $57bc
	ld b, $04 ; $57bf
	ld c, $07 ; $57c1
	farcall CopyTilemapRect ; $57c3
	jp StubNop_1b_5760 ; $57c6
DrawRankingRow6:
	ld hl, $d2c8 ; $57c9
	ld de, $d146 ; $57cc
	ld b, $04 ; $57cf
	ld c, $07 ; $57d1
	farcall CopyTilemapRect ; $57d3
	jp StubNop_1b_5760 ; $57d6
DrawRankingRow7:
	ld hl, $d2c4 ; $57d9
	ld de, $d02a ; $57dc
	ld b, $04 ; $57df
	ld c, $07 ; $57e1
	farcall CopyTilemapRect ; $57e3
	jp StubNop_1b_5760 ; $57e6
DrawRankingRow8:
	ld hl, $d2cc ; $57e9
	ld de, $d14a ; $57ec
	ld b, $04 ; $57ef
	ld c, $07 ; $57f1
	farcall CopyTilemapRect ; $57f3
	jp StubNop_1b_5760 ; $57f6
DrawRankingRow9:
	ld hl, $d014 ; $57f9
	ld de, $d026 ; $57fc
	ld b, $04 ; $57ff
	ld c, $10 ; $5801
	farcall CopyTilemapRect ; $5803
	jp StubNop_1b_5760 ; $5806
DrawRankingRow10:
	ld hl, $d018 ; $5809
	ld de, $d02a ; $580c
	ld b, $04 ; $580f
	ld c, $10 ; $5811
	farcall CopyTilemapRect ; $5813
	jp StubNop_1b_5760 ; $5816
DrawRankingRow11:
	ld hl, $d014 ; $5819
	ld de, $d026 ; $581c
	ld b, $08 ; $581f
	ld c, $10 ; $5821
	farcall CopyTilemapRect ; $5823
	jp StubNop_1b_5760 ; $5826
HighlightDoublesRankingRows:
	ld a, [wRankingBoardPlayerRow] ; $5829
	or a ; $582c
	ret z ; $582d
	cp $01 ; $582e
	ret z ; $5830
	cp $02 ; $5831
	jr nz, .ne02 ; $5833
	ld b, $01 ; $5835
	call HighlightDoublesRankingRow ; $5837
	ld b, $02 ; $583a
	call HighlightDoublesRankingRow ; $583c
	ret ; $583f
.ne02:
	ld b, $05 ; $5840
	call HighlightDoublesRankingRow ; $5842
	ret ; $5845
HighlightDoublesRankingRow:
	ld a, b ; $5846
	or a ; $5847
	ret z ; $5848
	add a ; $5849
	ld hl, RankingMarkerHandlers_1b ; $584a
	add l ; $584d
	ld l, a ; $584e
	jr nc, .jumpToHandler ; $584f
	inc h ; $5851
.jumpToHandler:
	ld a, [hl+] ; $5852
	ld h, [hl] ; $5853
	ld l, a ; $5854
	jp hl ; $5855
StubNop_1b_5856:
	ret ; $5856
RankingMarkerHandlers_1b:
	dw DrawDoublesRankingMarker0 ; $5857 jumptable
	dw DrawDoublesRankingMarker0 ; $5859 jumptable
	dw DrawDoublesRankingMarker2 ; $585b jumptable
	dw DrawDoublesRankingMarker3 ; $585d jumptable
	dw DrawDoublesRankingMarker4 ; $585f jumptable
	dw DrawDoublesRankingMarker5 ; $5861 jumptable
	dw DrawDoublesRankingMarker6 ; $5863 jumptable
DrawDoublesRankingMarker0:
	ld hl, $d240 ; $5865
	ld de, $d066 ; $5868
	ld b, $04 ; $586b
	ld c, $04 ; $586d
	farcall CopyTilemapRect ; $586f
	jp StubNop_1b_5856 ; $5872
DrawDoublesRankingMarker2:
	ld hl, $d244 ; $5875
	ld de, $d06a ; $5878
	ld b, $04 ; $587b
	ld c, $04 ; $587d
	farcall CopyTilemapRect ; $587f
	jp StubNop_1b_5856 ; $5882
DrawDoublesRankingMarker3:
	ld hl, $d248 ; $5885
	ld de, $d066 ; $5888
	ld b, $04 ; $588b
	ld c, $07 ; $588d
	farcall CopyTilemapRect ; $588f
	jp StubNop_1b_5856 ; $5892
DrawDoublesRankingMarker4:
	ld hl, $d24c ; $5895
	ld de, $d06a ; $5898
	ld b, $04 ; $589b
	ld c, $07 ; $589d
	farcall CopyTilemapRect ; $589f
	jp StubNop_1b_5856 ; $58a2
DrawDoublesRankingMarker5:
	ld hl, $d248 ; $58a5
	ld de, $d066 ; $58a8
	ld b, $08 ; $58ab
	ld c, $07 ; $58ad
	farcall CopyTilemapRect ; $58af
	jp StubNop_1b_5856 ; $58b2
DrawDoublesRankingMarker6:
	ld hl, $d250 ; $58b5
	ld de, $d066 ; $58b8
	ld b, $08 ; $58bb
	ld c, $07 ; $58bd
	farcall CopyTilemapRect ; $58bf
	jp StubNop_1b_5856 ; $58c2
PushRankingBoardTilemapRows:
	ld hl, $d000 ; $58c5
	ld de, $9800 ; $58c8
	ld c, $10 ; $58cb
	call QueueVRAMCopy ; $58cd
	ld hl, $d400 ; $58d0
	ld de, $9800 + VRAM_BANK1 ; $58d3
	ld c, $10 ; $58d6
	call QueueVRAMCopy ; $58d8
	call AdvanceFrame ; $58db
	ld hl, $d100 ; $58de
	ld de, $9900 ; $58e1
	ld c, $10 ; $58e4
	call QueueVRAMCopy ; $58e6
	ld hl, $d500 ; $58e9
	ld de, $9900 + VRAM_BANK1 ; $58ec
	ld c, $10 ; $58ef
	call QueueVRAMCopy ; $58f1
	call AdvanceFrame ; $58f4
	ld hl, $d200 ; $58f7
	ld de, $9a00 ; $58fa
	ld c, $08 ; $58fd
	call QueueVRAMCopy ; $58ff
	ld hl, $d600 ; $5902
	ld de, $9a00 + VRAM_BANK1 ; $5905
	ld c, $08 ; $5908
	call QueueVRAMCopy ; $590a
	call AdvanceFrame ; $590d
	ret ; $5910
	ret ; $5911
RankingBoardAnimTask_1b:
	ld a, [wRankingBannerAnimFrame] ; $5912
	or a ; $5915
	jr nz, .nonZero ; $5916
	ld a, $a0 ; $5918
	ld [wRankingBannerX], a ; $591a
.nonZero:
	ld a, [wRankingBannerAnimFrame] ; $591d
	ld hl, RankingBoardAnimTaskTable ; $5920
	add l ; $5923
	ld l, a ; $5924
	jr nc, .read ; $5925
	inc h ; $5927
.read:
	ld b, [hl] ; $5928
	ld a, [wRankingBannerX] ; $5929
	add b ; $592c
	ld [wRankingBannerX], a ; $592d
	ld hl, SpriteTemplate_1b_595a ; $5930
	ld e, $40 ; $5933
	ld a, [wRankingBoardDoubles] ; $5935
	or a ; $5938
	jr z, .zero ; $5939
	ld e, $50 ; $593b
.zero:
	ld a, [wRankingBannerX] ; $593d
	ld d, a ; $5940
	ld c, $10 ; $5941
	ld b, $0c ; $5943
	call QueueSpriteTemplate ; $5945
	ld a, [wRankingBannerAnimFrame] ; $5948
	inc a ; $594b
	ld [wRankingBannerAnimFrame], a ; $594c
	cp $87 ; $594f
	jr nz, .done ; $5951
	ld hl, RankingBoardAnimTask_1b ; $5953
	call UnregisterFrameTask ; $5956
.done:
	ret ; $5959
SpriteTemplate_1b_595a:
	; $595a, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
RankingBoardAnimTaskTable:
	INCBIN "data/bank_01b/d_597b.bin" ; $597b, 137 bytes
RankingCursorBobTask:
	ld a, [wRankingBannerAnimFrame] ; $5a04
	or a ; $5a07
	jr nz, .nonZero ; $5a08
.nonZero:
	ld de, $3040 ; $5a0a
	ld a, [wRankingBoardDoubles] ; $5a0d
	or a ; $5a10
	jr z, .applySpriteBobOffset ; $5a11
	ld de, $3050 ; $5a13
.applySpriteBobOffset:
	farcall ApplySpriteBobOffset ; $5a16
	ld hl, SpriteTemplate_1b_5a24 ; $5a19
	ld c, $20 ; $5a1c
	ld b, $0d ; $5a1e
	call QueueSpriteTemplate ; $5a20
	ret ; $5a23
SpriteTemplate_1b_5a24:
	; $5a24, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
DrawRankingMarkersTask:
	ld c, $00 ; $5a45
.loop:
	call GetRankingMarkerSlot ; $5a47
	ld a, [hl+] ; $5a4a
	cp $ff ; $5a4b
	jr z, .eqff ; $5a4d
	ld b, a ; $5a4f
	ld a, [hl+] ; $5a50
	ld d, a ; $5a51
	ld a, [hl+] ; $5a52
	ld e, a ; $5a53
	call QueueRankingMarkerSprite ; $5a54
.eqff:
	ld a, c ; $5a57
	inc a ; $5a58
	ld c, a ; $5a59
	cp $0c ; $5a5a
	jr nz, .loop ; $5a5c
	ret ; $5a5e
QueueRankingMarkerSprite:
	push af ; $5a5f
	push bc ; $5a60
	ld a, b ; $5a61
	add a ; $5a62
	ld c, a ; $5a63
	ld a, b ; $5a64
	or $08 ; $5a65
	ld b, a ; $5a67
	call QueueSprite ; $5a68
	pop bc ; $5a6b
	pop af ; $5a6c
	ret ; $5a6d
StartRankingMarkerAnim0:
	ld b, h ; $5a6e
	ld c, l ; $5a6f
	ld hl, $d840 ; $5a70
	ld a, c ; $5a73
	ld [hl+], a ; $5a74
	ld [hl], b ; $5a75
	ld hl, $d848 ; $5a76
	ld a, e ; $5a79
	ld [hl+], a ; $5a7a
	ld [hl], d ; $5a7b
	xor a ; $5a7c
	ld [$d850], a ; $5a7d
	ld a, $01 ; $5a80
	ld hl, UpdateScriptedOffsetChannel0 ; $5a82
	call RegisterFrameTask ; $5a85
	ret ; $5a88
StartRankingMarkerAnim1:
	ld b, h ; $5a89
	ld c, l ; $5a8a
	ld hl, $d842 ; $5a8b
	ld a, c ; $5a8e
	ld [hl+], a ; $5a8f
	ld [hl], b ; $5a90
	ld hl, $d84a ; $5a91
	ld a, e ; $5a94
	ld [hl+], a ; $5a95
	ld [hl], d ; $5a96
	xor a ; $5a97
	ld [$d851], a ; $5a98
	ld a, $01 ; $5a9b
	ld hl, UpdateScriptedOffsetChannel1 ; $5a9d
	call RegisterFrameTask ; $5aa0
	ret ; $5aa3
StartRankingMarkerAnim2:
	ld b, h ; $5aa4
	ld c, l ; $5aa5
	ld hl, $d844 ; $5aa6
	ld a, c ; $5aa9
	ld [hl+], a ; $5aaa
	ld [hl], b ; $5aab
	ld hl, $d84c ; $5aac
	ld a, e ; $5aaf
	ld [hl+], a ; $5ab0
	ld [hl], d ; $5ab1
	xor a ; $5ab2
	ld [$d852], a ; $5ab3
	ld a, $01 ; $5ab6
	ld hl, UpdateScriptedOffsetChannel2 ; $5ab8
	call RegisterFrameTask ; $5abb
	ret ; $5abe
StartRankingMarkerAnim3:
	ld b, h ; $5abf
	ld c, l ; $5ac0
	ld hl, $d846 ; $5ac1
	ld a, c ; $5ac4
	ld [hl+], a ; $5ac5
	ld [hl], b ; $5ac6
	ld hl, $d84e ; $5ac7
	ld a, e ; $5aca
	ld [hl+], a ; $5acb
	ld [hl], d ; $5acc
	xor a ; $5acd
	ld [$d853], a ; $5ace
	ld a, $01 ; $5ad1
	ld hl, UpdateScriptedOffsetChannel3 ; $5ad3
	call RegisterFrameTask ; $5ad6
	ret ; $5ad9
UpdateScriptedOffsetChannel0:
	ld hl, $d848 ; $5ada
	ld a, [hl+] ; $5add
	ld d, [hl] ; $5ade
	ld e, a ; $5adf
	ld a, [$d850] ; $5ae0
	ld h, $00 ; $5ae3
	ld l, a ; $5ae5
	add hl, de ; $5ae6
	ld a, [hl] ; $5ae7
	cp $40 ; $5ae8
	jr z, .eq40 ; $5aea
	ld c, a ; $5aec
	ld hl, $d840 ; $5aed
	ld a, [hl+] ; $5af0
	ld h, [hl] ; $5af1
	ld l, a ; $5af2
	inc hl ; $5af3
	ld a, [hl] ; $5af4
	add c ; $5af5
	ld [hl], a ; $5af6
	jr .checkTextPageBreakRequest ; $5af7
.eq40:
	ld hl, UpdateScriptedOffsetChannel0 ; $5af9
	call UnregisterFrameTask ; $5afc
	ret ; $5aff
.checkTextPageBreakRequest:
	ld a, [$d850] ; $5b00
	inc a ; $5b03
	ld [$d850], a ; $5b04
	ret ; $5b07
UpdateScriptedOffsetChannel1:
	ld hl, $d84a ; $5b08
	ld a, [hl+] ; $5b0b
	ld d, [hl] ; $5b0c
	ld e, a ; $5b0d
	ld a, [$d851] ; $5b0e
	ld h, $00 ; $5b11
	ld l, a ; $5b13
	add hl, de ; $5b14
	ld a, [hl] ; $5b15
	cp $40 ; $5b16
	jr z, .eq40 ; $5b18
	ld c, a ; $5b1a
	ld hl, $d842 ; $5b1b
	ld a, [hl+] ; $5b1e
	ld h, [hl] ; $5b1f
	ld l, a ; $5b20
	inc hl ; $5b21
	ld a, [hl] ; $5b22
	add c ; $5b23
	ld [hl], a ; $5b24
	jr .step2 ; $5b25
.eq40:
	ld hl, UpdateScriptedOffsetChannel1 ; $5b27
	call UnregisterFrameTask ; $5b2a
	ret ; $5b2d
.step2:
	ld a, [$d851] ; $5b2e
	inc a ; $5b31
	ld [$d851], a ; $5b32
	ret ; $5b35
UpdateScriptedOffsetChannel2:
	ld hl, $d84c ; $5b36
	ld a, [hl+] ; $5b39
	ld d, [hl] ; $5b3a
	ld e, a ; $5b3b
	ld a, [$d852] ; $5b3c
	ld h, $00 ; $5b3f
	ld l, a ; $5b41
	add hl, de ; $5b42
	ld a, [hl] ; $5b43
	cp $40 ; $5b44
	jr z, .eq40 ; $5b46
	ld c, a ; $5b48
	ld hl, $d844 ; $5b49
	ld a, [hl+] ; $5b4c
	ld h, [hl] ; $5b4d
	ld l, a ; $5b4e
	inc hl ; $5b4f
	inc hl ; $5b50
	ld a, [hl] ; $5b51
	add c ; $5b52
	ld [hl], a ; $5b53
	jr .step2 ; $5b54
.eq40:
	ld hl, UpdateScriptedOffsetChannel2 ; $5b56
	call UnregisterFrameTask ; $5b59
	ret ; $5b5c
.step2:
	ld a, [$d852] ; $5b5d
	inc a ; $5b60
	ld [$d852], a ; $5b61
	ret ; $5b64
UpdateScriptedOffsetChannel3:
	ld hl, $d84e ; $5b65
	ld a, [hl+] ; $5b68
	ld d, [hl] ; $5b69
	ld e, a ; $5b6a
	ld a, [$d853] ; $5b6b
	ld h, $00 ; $5b6e
	ld l, a ; $5b70
	add hl, de ; $5b71
	ld a, [hl] ; $5b72
	cp $40 ; $5b73
	jr z, .eq40 ; $5b75
	ld c, a ; $5b77
	ld hl, $d846 ; $5b78
	ld a, [hl+] ; $5b7b
	ld h, [hl] ; $5b7c
	ld l, a ; $5b7d
	inc hl ; $5b7e
	inc hl ; $5b7f
	ld a, [hl] ; $5b80
	add c ; $5b81
	ld [hl], a ; $5b82
	jr .step2 ; $5b83
.eq40:
	ld hl, UpdateScriptedOffsetChannel3 ; $5b85
	call UnregisterFrameTask ; $5b88
	ret ; $5b8b
.step2:
	ld a, [$d853] ; $5b8c
	inc a ; $5b8f
	ld [$d853], a ; $5b90
	ret ; $5b93
RankingBoardAnimState_5077Table0:
	; $5b94, 1 bytes (bytes:1)
	db $01 ; 0x00
RankingBoardAnimState_5077Table1:
	; $5b95, 3 bytes (bytes:3)
	db $01, $01, $01 ; 0x00
RankingBoardAnimState_546dTable:
	; $5b98, 5 bytes (bytes:5)
	db $01, $01, $01, $01, $40 ; 0x00
RankingBoardAnimState_5077Table2:
	; $5b9d, 8 bytes (bytes:8)
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $40 ; 0x00
RankingBoardAnimState_5077Table3:
	; $5ba5, 13 bytes (bytes:13)
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $40 ; 0x00
RankingBoardAnimState_5077Table4:
	; $5bb2, 9 bytes (bytes:9)
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $40 ; 0x00
RankingBoardAnimState_516fTable0:
	; $5bbb, 1 bytes (bytes:1)
	db $01 ; 0x00
RankingBoardAnimState_516fTable1:
	; $5bbc, 7 bytes (bytes:7)
	db $01, $01, $01, $01, $01, $01, $01 ; 0x00
RankingBoardAnimState_516fTable2:
	; $5bc3, 2 bytes (bytes:2)
	db $01, $01 ; 0x00
RankingBoardAnimState_5387Table0:
	; $5bc5, 7 bytes (bytes:7)
	db $01, $01, $01, $01, $01, $01, $40 ; 0x00
RankingBoardAnimState_516fTable3:
	ds 1, $ff ; $5bcc, fill
RankingBoardAnimState_516fTable4:
	ds 7, $ff ; $5bcd, fill
RankingBoardAnimState_516fTable5:
	; $5bd4, 9 bytes (bytes:9)
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $40 ; 0x00
RankingBoardAnimState_5368Table0:
	; $5bdd, 5 bytes (bytes:5)
	db $01, $01, $01, $01, $40 ; 0x00
RankingBoardAnimState_5368Table1:
	; $5be2, 5 bytes (bytes:5)
	db $ff, $ff, $ff, $ff, $40 ; 0x00
RankingBoardAnimState_5273Table0:
	; $5be7, 8 bytes (bytes:8)
	db $01, $01, $01, $01, $01, $01, $01, $01 ; 0x00
RankingBoardAnimState_53faTable:
	; $5bef, 8 bytes (bytes:8)
	db $01, $01, $01, $01, $01, $01, $01, $01 ; 0x00
RankingBoardAnimState_5387Table1:
	; $5bf7, 21 bytes (bytes:16)
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; 0x00
	db $01, $01, $01, $01, $40 ; 0x10
RankingBoardAnimState_5273Table1:
	; $5c0c, 37 bytes (bytes:16)
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x00
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x10
	db $ff, $ff, $ff, $ff, $40 ; 0x20
ClearRankingMarkerSlots:
	ld hl, wRankingMarkerSlots ; $5c31
	ld bc, $0030 ; $5c34
	call ClearBytes ; $5c37
	ret ; $5c3a
LoadRankingMarkerCoords:
	ld a, [wRankingBoardDoubles] ; $5c3b
	or a ; $5c3e
	jr nz, .nonZero ; $5c3f
	ld hl, RankingMarkerCoordsTable ; $5c41
	ld a, [wRankingBoardMode] ; $5c44
	or a ; $5c47
	jr z, .zero ; $5c48
	ld hl, RankingMarkerCoordsTable0 ; $5c4a
.zero:
	ld a, [wRankingBoardPlayerRow] ; $5c4d
	add a ; $5c50
	add l ; $5c51
	ld l, a ; $5c52
	jr nc, .read ; $5c53
	inc h ; $5c55
.read:
	ld a, [hl+] ; $5c56
	ld h, [hl] ; $5c57
	ld l, a ; $5c58
	push hl ; $5c59
	call GetRankingMarkerSlot ; $5c5a
	ld d, h ; $5c5d
	ld e, l ; $5c5e
	pop hl ; $5c5f
	ld bc, $0030 ; $5c60
	call CopyMemoryBC ; $5c63
	ret ; $5c66
.nonZero:
	ld hl, $5e21 ; $5c67
	ld a, [wRankingBoardMode] ; $5c6a
	or a ; $5c6d
	jr z, .zero2 ; $5c6e
	ld hl, RankingMarkerCoordsTable1 ; $5c70
.zero2:
	ld a, [wRankingBoardPlayerRow] ; $5c73
	add a ; $5c76
	add l ; $5c77
	ld l, a ; $5c78
	jr nc, .readB ; $5c79
	inc h ; $5c7b
.readB:
	ld a, [hl+] ; $5c7c
	ld h, [hl] ; $5c7d
	ld l, a ; $5c7e
	push hl ; $5c7f
	call GetRankingMarkerSlot ; $5c80
	ld d, h ; $5c83
	ld e, l ; $5c84
	pop hl ; $5c85
	ld bc, $0030 ; $5c86
	call CopyMemoryBC ; $5c89
	ret ; $5c8c
RankingMarkerCoordsTable:
	; $5c8d, 10 bytes (records:2)
	dw RankingMarkerCoordSet0 ; record 0
	dw RankingMarkerCoordSet0 ; record 1
	dw RankingMarkerCoordSet1 ; record 2
	dw RankingMarkerCoordSet2 ; record 3
	dw RankingMarkerCoordSet3 ; record 4
RankingMarkerCoordSet0:
	INCBIN "data/bank_01b/d_5c97.bin" ; $5c97, 48 bytes
RankingMarkerCoordSet1:
	INCBIN "data/bank_01b/d_5cc7.bin" ; $5cc7, 48 bytes
RankingMarkerCoordSet2:
	INCBIN "data/bank_01b/d_5cf7.bin" ; $5cf7, 48 bytes
RankingMarkerCoordSet3:
	INCBIN "data/bank_01b/d_5d27.bin" ; $5d27, 48 bytes
RankingMarkerCoordsTable0:
	INCBIN "data/bank_01b/d_5d57.bin" ; $5d57, 354 bytes
RankingMarkerCoordsTable1:
	INCBIN "data/bank_01b/d_5eb9.bin" ; $5eb9, 152 bytes
GetRankingMarkerSlot:
	push af ; $5f51
	ld a, c ; $5f52
	add a ; $5f53
	add a ; $5f54
	ld hl, wRankingMarkerSlots ; $5f55
	add l ; $5f58
	ld l, a ; $5f59
	jr nc, .done ; $5f5a
	inc h ; $5f5c
.done:
	pop af ; $5f5d
	ret ; $5f5e
	push af ; $5f5f
	ld a, b ; $5f60
	ld [hl+], a ; $5f61
	ld a, d ; $5f62
	ld [hl+], a ; $5f63
	ld a, e ; $5f64
	ld [hl+], a ; $5f65
	inc hl ; $5f66
	pop af ; $5f67
	ret ; $5f68
	push hl ; $5f69
	push af ; $5f6a
	inc hl ; $5f6b
	ld a, [hl] ; $5f6c
	add b ; $5f6d
	ld [hl], a ; $5f6e
	pop af ; $5f6f
	pop hl ; $5f70
	ret ; $5f71
	push hl ; $5f72
	push af ; $5f73
	inc hl ; $5f74
	inc hl ; $5f75
	ld a, [hl] ; $5f76
	add b ; $5f77
	ld [hl], a ; $5f78
	pop af ; $5f79
	pop hl ; $5f7a
	ret ; $5f7b
CharSelectNavGridTable:
	; $5f7c, 32 bytes (bytes:16)
	db $ff, $ff, $ff, $ff, $ff, $ff, $fe, $fd, $ff, $00, $01, $02, $03, $ff, $fe, $fd ; 0x00
	db $ff, $ff, $ff, $ff, $ff, $ff, $fe, $fd, $ff, $ff, $ff, $ff, $ff, $ff, $fe, $fd ; 0x10
CharSelectRosterTable:
	; $5f9c, 38 bytes (bytes:16)
	db $00, $00, $00, $b5, $30, $20, $c4, $00, $01, $00, $00, $b6, $30, $38, $c7, $00 ; 0x00
	db $02, $00, $00, $b7, $30, $50, $ca, $00, $03, $00, $00, $a8, $30, $68, $cd, $00 ; 0x10
	db $ff, $00, $00, $b0, $18, $20 ; 0x20
	ld h, h ; $5fc2
	nop ; $5fc3
FindCharSelectRosterEntry:
	ld hl, wCharSelectRoster ; $5fc4
	farcall FindRosterEntry ; $5fc7
	ret ; $5fca
GetCharSelectRosterField:
	push hl ; $5fcb
	call FindCharSelectRosterEntry ; $5fcc
	ld a, [hl+] ; $5fcf
	ld d, [hl] ; $5fd0
	ld e, a ; $5fd1
	pop hl ; $5fd2
	ret ; $5fd3
LoadCharSelectNavGrid:
	ld hl, CharSelectNavGridTable ; $5fd4
	ld de, $c7a0 ; $5fd7
	ld bc, $0020 ; $5fda
	call CopyMemoryBC ; $5fdd
	ret ; $5fe0
LoadCharSelectRosterTable:
	ld hl, CharSelectRosterTable ; $5fe1
	ld de, wCharSelectRoster ; $5fe4
	ld bc, $0080 ; $5fe7
	call CopyMemoryBC ; $5fea
	ret ; $5fed
LoadCharSelectScreenGfx:
	ld hl, CharSelectNavGridTable ; $5fee
	ld de, $d000 ; $5ff1
	call DecompressData ; $5ff4
	ld hl, $d000 ; $5ff7
	ld de, $9000 + VRAM_BANK1 ; $5ffa
	ld c, $80 ; $5ffd
	call QueueVRAMCopy ; $5fff
	ld hl, $d800 ; $6002
	ld de, $8800 + VRAM_BANK1 ; $6005
	ld c, $80 ; $6008
	call QueueVRAMCopy ; $600a
	ld hl, CharSelectNavGridTable ; $600d
	ld de, $dc00 ; $6010
	call DecompressData ; $6013
	ld hl, CharSelectNavGridTable ; $6016
	ld de, $d800 ; $6019
	call DecompressData ; $601c
	ld hl, CharSelectNavGridTable ; $601f
	ld de, $0008 ; $6022
	call LoadPaletteShadow ; $6025
	ret ; $6028
StartCharSelectCursorTask:
	farcall LoadCharSelectCursorGfx ; $6029
	ld a, $0a ; $602c
	ld hl, UpdateCharSelectCursorTask ; $602e
	call RegisterFrameTask ; $6031
	ret ; $6034
UpdateCharSelectCursorTask:
	ld a, [wCharSelectChar] ; $6035
	ld de, $0004 ; $6038
	call GetCharSelectRosterField ; $603b
	ld a, [wCharSelectChar] ; $603e
	farcall DrawCharSelectCursor ; $6041
	ret ; $6044
DrawCharSelectPrompt:
	ld hl, $d000 ; $6045
	ld de, $9000 ; $6048
	ld c, $10 ; $604b
	call QueueVRAMCopy ; $604d
	ld hl, $d9e0 ; $6050
	ld de, $dde0 ; $6053
	ld bc, $1403 ; $6056
	farcall DrawBox ; $6059
	ld hl, $0470 ; $605c
	ld a, [wStoryCharacterSlot] ; $605f
	or a ; $6062
	jr z, .zero ; $6063
	ld hl, $047b ; $6065
.zero:
	ld de, $da01 ; $6068
	farcall RenderProportionalTextAt32 ; $606b
	ret ; $606e
DrawCharSelectMugshots:
	farcall ResetMugshotPalettes_1b ; $606f
	ld hl, wCharSelectRoster ; $6072
.loop:
	ld a, [hl] ; $6075
	farcall LoadCharacterRecordToBuffer ; $6076
	farcall CheckCharacterUnlocked ; $6079
	jr z, .step ; $607c
	ld a, [$d58b] ; $607e
	farcall LoadCharMugshotToBuffer ; $6081
	ld a, [hl] ; $6084
	ld de, $0002 ; $6085
	call GetCharSelectRosterField ; $6088
	farcall CopyMugshotBufferToVram ; $608b
	ld a, [hl] ; $608e
	ld de, $0006 ; $608f
	call GetCharSelectRosterField ; $6092
	ld a, [$d58b] ; $6095
	add a ; $6098
	add $c1 ; $6099
	ld c, a ; $609b
	adc $c7 ; $609c
	sub c ; $609e
	ld b, a ; $609f
	ld a, [bc] ; $60a0
	farcall SetMugshotAttrs ; $60a1
.step:
	ld a, $08 ; $60a4
	add l ; $60a6
	ld l, a ; $60a7
	jr nc, .read ; $60a8
	inc h ; $60aa
.read:
	ld a, [hl] ; $60ab
	cp $ff ; $60ac
	jr nz, .loop ; $60ae
	ld a, [wCharSelectChar] ; $60b0
	farcall LoadCharacterRecordToBuffer ; $60b3
	ld a, [$d58b] ; $60b6
	farcall StubNop_1b_4e43 ; $60b9
	ret ; $60bc
	and $01 ; $60bd
	ld [wTargetZoneX2], a ; $60bf
	call ClearFrameTasks ; $60c2
	call AdvanceFrame ; $60c5
	push de ; $60c8
	call LoadCharSelectNavGrid ; $60c9
	call LoadCharSelectRosterTable ; $60cc
	pop de ; $60cf
	ld a, d ; $60d0
	ld [wCharSelectCol], a ; $60d1
	ld a, e ; $60d4
	ld [wCharSelectRow], a ; $60d5
	farcall UpdateCharSelectSelection ; $60d8
	ld a, [wCharSelectChar] ; $60db
	ld [wCharSelectPrevChar], a ; $60de
	ld c, $20 ; $60e1
	call BeginFadeOut ; $60e3
	call WaitFadeEnd ; $60e6
	call DisableLCDSafely ; $60e9
	call LoadCharSelectScreenGfx ; $60ec
	call DrawCharSelectMugshots ; $60ef
	call DrawCharSelectPrompt ; $60f2
	ld hl, $dc00 ; $60f5
	ld de, $9800 + VRAM_BANK1 ; $60f8
	ld c, $24 ; $60fb
	call QueueVRAMCopy ; $60fd
	ld hl, $d800 ; $6100
	ld de, $9800 ; $6103
	ld c, $24 ; $6106
	call QueueVRAMCopy ; $6108
	call EnableLCD ; $610b
	script_fade_in $20 ; $610e
	call WaitFadeEnd ; $6113
	call StartCharSelectCursorTask ; $6116
.loopB:
	wram_bank $01 ; $6119
	ldh a, [hInputRisingEdge] ; $611f
	and PADF_START ; $6121
	jr z, .checkInputRisingEdge ; $6123
	ld a, [wTargetZoneX2] ; $6125
	ld b, a ; $6128
	ld a, [wCharSelectChar] ; $6129
	farcall InitPlayerRecordForCharacter ; $612c
	sound $5f ; $612f
	ld a, $fe ; $6131
	jr .step4 ; $6133
.checkInputRisingEdge:
	ldh a, [hInputRisingEdge] ; $6135
	and PADF_A ; $6137
	jr z, .checkInputRisingEdge2 ; $6139
	ld a, [wTargetZoneX2] ; $613b
	ld b, a ; $613e
	ld a, [wCharSelectChar] ; $613f
	farcall InitPlayerRecordForCharacter ; $6142
	sound $5f ; $6145
	ld a, [wCharSelectChar] ; $6147
	jr .step4 ; $614a
.checkInputRisingEdge2:
	ldh a, [hInputRisingEdge] ; $614c
	and PADF_B ; $614e
	jr z, .moveCharSelectCursor ; $6150
	sound $62 ; $6152
	ld a, $ff ; $6154
	jr .step4 ; $6156
.moveCharSelectCursor:
	call MoveCharSelectCursor ; $6158
	call UpdateCharSelectSelection ; $615b
	ld a, [wCharSelectChar] ; $615e
	farcall LoadCharacterRecordToBuffer ; $6161
	call AdvanceFrame ; $6164
	jr .loopB ; $6167
.step4:
	ld hl, wCharSelectCol ; $6169
	ld d, [hl] ; $616c
	ld hl, wCharSelectRow ; $616d
	ld e, [hl] ; $6170
	ret ; $6171
UpdateCharSelectSelection:
	ld a, [wCharSelectChar] ; $6172
	ld [wCharSelectPrevChar], a ; $6175
	ld a, [wCharSelectRow] ; $6178
	add a ; $617b
	add a ; $617c
	add a ; $617d
	ld hl, wCharSelectCol ; $617e
	add [hl] ; $6181
	add $a0 ; $6182
	ld l, a ; $6184
	adc $c7 ; $6185
	sub l ; $6187
	ld h, a ; $6188
	ld a, [hl] ; $6189
	cp $ff ; $618a
.storeCharSelectChar:
	jr z, .storeCharSelectChar ; $618c
	ld [wCharSelectChar], a ; $618e
	ret ; $6191
MoveCharSelectCursor:
	ldh a, [hInputPressed] ; $6192
	ld b, a ; $6194
	and $f0 ; $6195
	jr z, .done ; $6197
	sound $5e ; $6199
	ld a, [wCharSelectCol] ; $619b
	ld d, a ; $619e
	ld a, [wCharSelectRow] ; $619f
	ld e, a ; $61a2
.loop:
	ld hl, $c7a0 ; $61a3
	farcall MoveGridCursor ; $61a6
	farcall LoadCharacterRecordToBuffer ; $61a9
	farcall CheckCharacterUnlocked ; $61ac
	jr z, .loop ; $61af
	ld a, d ; $61b1
	ld [wCharSelectCol], a ; $61b2
	ld a, e ; $61b5
	ld [wCharSelectRow], a ; $61b6
.done:
	ret ; $61b9
RunNewGameSetup:
	sound $03 ; $61ba
	farcall InitStoryModeState ; $61bc
	ld a, $00 ; $61bf
	farcall RollStoryRandomByte ; $61c1
	wram_bank $01 ; $61c4
	ld a, $01 ; $61ca
	ld [wCharSelectCursorCol], a ; $61cc
	ld a, $01 ; $61cf
	ld [wCharSelectCursorRow], a ; $61d1
	ld hl, wNewGameRosterFields ; $61d4
	xor a ; $61d7
.loop:
	push af ; $61d8
	farcall LoadCharacterRecordToBuffer ; $61d9
	ld a, [wCharRecordBuffer + 14] ; $61dc
	ld [hl+], a ; $61df
	ld a, [wCharRecordBuffer + 12] ; $61e0
	ld [hl+], a ; $61e3
	pop af ; $61e4
	inc a ; $61e5
	cp $04 ; $61e6
	jr nz, .loop ; $61e8
	ld a, [wStoryCharacterSlot] ; $61ea
	push af ; $61ed
	xor a ; $61ee
	ld [wStoryCharacterSlot], a ; $61ef
.loopB:
	ld a, [wCharSelectCursorCol] ; $61f2
	ld d, a ; $61f5
	ld a, [wCharSelectCursorRow] ; $61f6
	ld e, a ; $61f9
	ld b, $00 ; $61fa
	farcall RunCharacterSelectScreen ; $61fc
	ld hl, wCharSelectCursorCol ; $61ff
	ld [hl], d ; $6202
	ld hl, wCharSelectCursorRow ; $6203
	ld [hl], e ; $6206
	cp $ff ; $6207
	jr nz, .compare ; $6209
	pop af ; $620b
	ld [wStoryCharacterSlot], a ; $620c
	ld a, $ff ; $620f
	jp .beginFadeOut ; $6211
.compare:
	cp $fe ; $6214
	jr nz, .loop2 ; $6216
	jr .loopB ; $6218
.loop2:
	ld a, $01 ; $621a
	farcall RollStoryRandomByte ; $621c
	ld a, $00 ; $621f
	farcall PromptCharDataConfirm ; $6221
	and a ; $6224
	jr nz, .loopB ; $6225
	ld a, $02 ; $6227
	farcall RollStoryRandomByte ; $6229
.loop3:
	xor a ; $622c
	ld [wStoryCharacterSlot], a ; $622d
	push af ; $6230
	ld hl, wStoryModeNameOfMainCharacter ; $6231
	ld a, [wStoryCharacterSlot] ; $6234
	or a ; $6237
	jr z, .zero ; $6238
	ld l, $40 ; $623a
.zero:
	ld a, l ; $623c
	add $0b ; $623d
	ld l, a ; $623f
	ld a, h ; $6240
	adc $00 ; $6241
	ld h, a ; $6243
	pop af ; $6244
	ld c, [hl] ; $6245
	ld b, $00 ; $6246
	farcall RunNameEntryScreen ; $6248
	and a ; $624b
	jr nz, .loop2 ; $624c
	pop af ; $624e
	ld [wStoryCharacterSlot], a ; $624f
	ld a, [wStoryCharacterSlot] ; $6252
	push af ; $6255
	ld a, $01 ; $6256
	ld [wStoryCharacterSlot], a ; $6258
	ld de, SAVEFLAG_OPENING_SEEN ; $625b
	farcall TestSaveFlag ; $625e
	jr nz, .loop4 ; $6261
	push af ; $6263
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $6264
	inc a ; $6267
	inc a ; $6268
	ld d, a ; $6269
	ld a, [wStoryCharacterSlot] ; $626a
	farcall InitPlayerRecordFromTemplate ; $626d
	push af ; $6270
	ld hl, wStoryModeNameOfMainCharacter ; $6271
	ld a, [wStoryCharacterSlot] ; $6274
	or a ; $6277
	jr z, .zero2 ; $6278
	ld l, $40 ; $627a
.zero2:
	ld a, l ; $627c
	add $0b ; $627d
	ld l, a ; $627f
	ld a, h ; $6280
	adc $00 ; $6281
	ld h, a ; $6283
	pop af ; $6284
	ld c, [hl] ; $6285
	ld b, $01 ; $6286
	farcall RunNameEntryScreen ; $6288
	ld b, a ; $628b
	pop af ; $628c
	ld a, b ; $628d
	and a ; $628e
	jr nz, .loop3 ; $628f
	jr .restore ; $6291
.loop4:
	ld a, [wCharSelectCursorCol] ; $6293
	ld d, a ; $6296
	ld a, [wCharSelectCursorRow] ; $6297
	ld e, a ; $629a
	ld b, $01 ; $629b
	farcall RunCharacterSelectScreen ; $629d
	ld hl, wCharSelectCursorCol ; $62a0
	ld [hl], d ; $62a3
	ld hl, wCharSelectCursorRow ; $62a4
	ld [hl], e ; $62a7
	cp $ff ; $62a8
	jr nz, .compare2 ; $62aa
	pop af ; $62ac
	ld [wStoryCharacterSlot], a ; $62ad
	jp RunNewGameSetup ; $62b0
.compare2:
	cp $fe ; $62b3
	jr nz, .loop5 ; $62b5
	jr .loop4 ; $62b7
.loop5:
	ld a, $01 ; $62b9
	farcall PromptCharDataConfirm ; $62bb
	and a ; $62be
	jr nz, .loop4 ; $62bf
	push af ; $62c1
	ld hl, wStoryModeNameOfMainCharacter ; $62c2
	ld a, [wStoryCharacterSlot] ; $62c5
	or a ; $62c8
	jr z, .zero3 ; $62c9
	ld l, $40 ; $62cb
.zero3:
	ld a, l ; $62cd
	add $0b ; $62ce
	ld l, a ; $62d0
	ld a, h ; $62d1
	adc $00 ; $62d2
	ld h, a ; $62d4
	pop af ; $62d5
	ld c, [hl] ; $62d6
	ld b, $01 ; $62d7
	farcall RunNameEntryScreen ; $62d9
	and a ; $62dc
	jr nz, .loop5 ; $62dd
.restore:
	pop af ; $62df
	ld [wStoryCharacterSlot], a ; $62e0
	ld hl, wStoryModeNameOfMainCharacter ; $62e3
	ld de, wStorySlotData ; $62e6
	ld c, $08 ; $62e9
	call CopyMemoryFast ; $62eb
	xor a ; $62ee
.beginFadeOut:
	ld c, $20 ; $62ef
	call BeginFadeOut ; $62f1
	call WaitFadeEnd ; $62f4
	ret ; $62f7
RunDebugSaveDataFlow:
	sound $03 ; $62f8
	ld a, $01 ; $62fa
	cp $ff ; $62fc
	jr z, RunDebugSaveDataFlow ; $62fe
	or a ; $6300
	jr z, .loop ; $6301
	bit 7, a ; $6303
	jr z, RunDebugSaveDataFlow ; $6305
	and $3f ; $6307
	ld [wCurrentStorySlot], a ; $6309
	ld hl, wStorySlotData ; $630c
	ld b, a ; $630f
	ld [wCurrentStorySlot], a ; $6310
	farcall CheckStorySlot ; $6313
	or a ; $6316
	jp z, .clearFrameTasks ; $6317
	call RunNewGameSetup ; $631a
	cp $ff ; $631d
	jp z, RunDebugSaveDataFlow ; $631f
	ld a, $01 ; $6322
	farcall EraseStorySlotSaveData ; $6324
	farcall SaveStorySlotWithTimer ; $6327
	jp .loop2 ; $632a
.loop:
	sound $03 ; $632d
	call RunDebugSaveDataMenu ; $632f
	cp $ff ; $6332
	jr z, RunDebugSaveDataFlow ; $6334
	cp $01 ; $6336
	jp z, .eq01 ; $6338
	cp $ff ; $633b
	jr z, .loop ; $633d
	or a ; $633f
	jr nz, .nonZero ; $6340
	or a ; $6342
	jr nz, .loop ; $6343
	farcall ReinitSaveRamPreservingBlock6 ; $6345
	ld b, $01 ; $6348
	jr .loop ; $634a
.nonZero:
	and $3f ; $634c
	ld b, a ; $634e
	ld hl, wPlayer1MainName ; $634f
	ld [wCurrentStorySlot], a ; $6352
	farcall CheckStorySlot ; $6355
	or a ; $6358
	jr z, .zero ; $6359
	sound $62 ; $635b
	jr .loop ; $635d
.zero:
	push bc ; $635f
	call StubNop_1b_69d6 ; $6360
	pop bc ; $6363
	or a ; $6364
	jr nz, .loop ; $6365
	wram_bank $03 ; $6367
	ld hl, wPlayer1MainName ; $636d
	ld de, wShadowAttrmap + 8 * TILEMAP_WIDTH ; $6370
	ld c, $0b ; $6373
.loopB:
	ld a, [hl+] ; $6375
	push hl ; $6376
	ld h, d ; $6377
	ld l, e ; $6378
	ld [hl+], a ; $6379
	ld d, h ; $637a
	ld e, l ; $637b
	pop hl ; $637c
	dec c ; $637d
	jr nz, .loopB ; $637e
	ld a, b ; $6380
	ld [wCurrentStorySlot], a ; $6381
	ld a, $00 ; $6384
	farcall EraseStorySlotSaveData ; $6386
	ld b, $01 ; $6389
	jp .loop ; $638b
.eq01:
	ld a, $00 ; $638e
	ld [wUnlockDebugSelection], a ; $6390
	farcall RunMinigameFlagsDebugScreen ; $6393
	jp .loop ; $6396
.clearFrameTasks:
	call ClearFrameTasks ; $6399
	farcall ValidateN64TransferRecord ; $639c
	or a ; $639f
	jr z, .showNoN64DataFoundScreen ; $63a0
	ld hl, wPendingExpStory ; $63a2
	ld a, [hl+] ; $63a5
	ld d, [hl] ; $63a6
	ld e, a ; $63a7
	or d ; $63a8
	jr z, .step4 ; $63a9
	ldh a, [hWramBank] ; $63ab
	push af ; $63ad
	wram_bank $06 ; $63ae
	xor a ; $63b4
	ld [$d000], a ; $63b5
	pop af ; $63b8
	wram_bank ; $63b9
	ld h, $01 ; $63bd
	ld l, $00 ; $63bf
	ld a, $01 ; $63c1
	farcall ShowExpGainScreen ; $63c3
	ld c, $00 ; $63c6
	farcall CharDataScreen_Show ; $63c8
.step4:
	ld hl, wPendingExpTrophy ; $63cb
	ld a, [hl+] ; $63ce
	ld d, [hl] ; $63cf
	ld e, a ; $63d0
	or d ; $63d1
	jr z, .step5 ; $63d2
	ldh a, [hWramBank] ; $63d4
	push af ; $63d6
	wram_bank $06 ; $63d7
	xor a ; $63dd
	ld [$d000], a ; $63de
	pop af ; $63e1
	wram_bank ; $63e2
	ld h, $01 ; $63e6
	ld l, $01 ; $63e8
	ld a, $01 ; $63ea
	farcall ShowExpGainScreen ; $63ec
	ld c, $01 ; $63ef
	farcall CharDataScreen_Show ; $63f1
.step5:
	xor a ; $63f4
	ld hl, wPendingExpStory ; $63f5
	ld [hl+], a ; $63f8
	ld [hl+], a ; $63f9
	ld [hl+], a ; $63fa
	ld [hl+], a ; $63fb
	ld [hl+], a ; $63fc
	inc hl ; $63fd
	inc hl ; $63fe
	ld [hl+], a ; $63ff
	farcall SaveStorySlotWithTimer ; $6400
	jr .loop2 ; $6403
.showNoN64DataFoundScreen:
	farcall ShowNoN64DataFoundScreen ; $6405
.loop2:
	call RunLevelUpStatusTrophiesMenu ; $6408
	cp $ff ; $640b
	jp z, RunDebugSaveDataFlow ; $640d
	cp $01 ; $6410
	jr z, .showCharDataScreen ; $6412
	cp $02 ; $6414
	jr z, .showTrophiesPlaceholderScreen ; $6416
	push af ; $6418
	push bc ; $6419
	push de ; $641a
	push hl ; $641b
	farcall ClearDrillResultBuffer ; $641c
	ld b, $00 ; $641f
	ld c, $00 ; $6421
	ld de, $0040 ; $6423
	farcall RecordDrillResult ; $6426
	ld b, $04 ; $6429
	ld c, $01 ; $642b
	ld de, $0077 ; $642d
	farcall RecordDrillResult ; $6430
	ld c, $01 ; $6433
	farcall ShowMatchResultsScreen ; $6435
	farcall RunExpDistributionFlow ; $6438
	pop hl ; $643b
	pop de ; $643c
	pop bc ; $643d
	pop af ; $643e
	set_flag FLAG_CHAR_DATA_START_EXITS ; $643f
	ld c, $00 ; $6442
	farcall CharDataScreen_Show ; $6444
	clear_flag FLAG_CHAR_DATA_START_EXITS ; $6447
	set_flag FLAG_CHAR_DATA_START_EXITS ; $644a
	ld c, $01 ; $644d
	farcall CharDataScreen_Show ; $644f
	clear_flag FLAG_CHAR_DATA_START_EXITS ; $6452
	farcall SaveStorySlotWithTimer ; $6455
	jr .loop2 ; $6458
.showCharDataScreen:
	farcall ShowCharDataScreen ; $645a
	jp .loop2 ; $645d
.showTrophiesPlaceholderScreen:
	call ShowTrophiesPlaceholderScreen ; $6460
	jp .loop2 ; $6463
	ret ; $6466
RunLevelUpStatusTrophiesMenu:
	push bc ; $6467
	push de ; $6468
	push hl ; $6469
	ldh a, [hWramBank] ; $646a
	push af ; $646c
	call ClearFrameTasks ; $646d
	call DisableLCDSafely ; $6470
	farcall LoadMenuFontGfx ; $6473
	call DisableLCDSafely ; $6476
	farcall ResetTextWindowState ; $6479
	call ClearScreenMaps ; $647c
	wram_bank $05 ; $647f
	ld d, $02 ; $6485
	ld e, $02 ; $6487
	ld hl, Text_31_124 ; $6489
	farcall CreateMenuWindowFromText ; $648c
	farcall RestoreShadowTilemap ; $648f
	farcall RenderMenuWindowText ; $6492
	script_fade_in $20 ; $6495
	call WaitFadeEnd ; $649a
	farcall RunMenuSelection ; $649d
	ld b, a ; $64a0
	ld c, $20 ; $64a1
	call BeginFadeOut ; $64a3
	call WaitFadeEnd ; $64a6
	ld a, [wMenuWindowId] ; $64a9
	farcall CloseWindow ; $64ac
	pop af ; $64af
	wram_bank ; $64b0
	ld a, b ; $64b4
	pop hl ; $64b5
	pop de ; $64b6
	pop bc ; $64b7
	ret ; $64b8
RunDebugSaveDataMenu:
	push bc ; $64b9
	push de ; $64ba
	push hl ; $64bb
	ldh a, [hWramBank] ; $64bc
	push af ; $64be
	call ClearFrameTasks ; $64bf
	call DisableLCDSafely ; $64c2
	farcall LoadMenuFontGfx ; $64c5
	call EnableLCD ; $64c8
	farcall ResetTextWindowState ; $64cb
	call ClearScreenMaps ; $64ce
	call ReadUnlockFlagsSaveBlock ; $64d1
	wram_bank $06 ; $64d4
	ld hl, $d400 ; $64da
	ld a, [hl+] ; $64dd
	ld d, [hl] ; $64de
	ld e, a ; $64df
	ld hl, $047d ; $64e0
	or d ; $64e3
	jr nz, .createMenuWindowFromText ; $64e4
	inc hl ; $64e6
.createMenuWindowFromText:
	wram_bank $05 ; $64e7
	ld d, $02 ; $64ed
	ld e, $02 ; $64ef
	farcall CreateMenuWindowFromText ; $64f1
	farcall RestoreShadowTilemap ; $64f4
	farcall RenderMenuWindowText ; $64f7
	script_fade_in $20 ; $64fa
	call WaitFadeEnd ; $64ff
	farcall RunMenuSelection ; $6502
	ld b, a ; $6505
	ld c, $20 ; $6506
	call BeginFadeOut ; $6508
	call WaitFadeEnd ; $650b
	ld a, [wMenuWindowId] ; $650e
	farcall CloseWindow ; $6511
	pop af ; $6514
	wram_bank ; $6515
	ld a, b ; $6519
	pop hl ; $651a
	pop de ; $651b
	pop bc ; $651c
	ret ; $651d
ClearScreenMaps:
	call DisableLCDSafely ; $651e
	wram_bank $02 ; $6521
	ld a, $00 ; $6527
	ld hl, $d000 ; $6529
	ld bc, $0500 ; $652c
	call FillBytesWithValue ; $652f
	wram_bank $03 ; $6532
	ld a, $20 ; $6538
	ld hl, wShadowTilemap ; $653a
	ld bc, $0500 ; $653d
	call FillBytesWithValue ; $6540
	wram_bank $03 ; $6543
	ld hl, wShadowTilemap ; $6549
	ld de, $9800 ; $654c
	ld c, $24 ; $654f
	call QueueVRAMCopy ; $6551
	wram_bank $02 ; $6554
	ld hl, $d000 ; $655a
	ld de, $9800 + VRAM_BANK1 ; $655d
	ld c, $24 ; $6560
	call QueueVRAMCopy ; $6562
	call EnableLCD ; $6565
	ret ; $6568
FillBytesWithValue:
	ld e, a ; $6569
.loop:
	ld [hl], e ; $656a
	inc hl ; $656b
	dec bc ; $656c
	ld a, c ; $656d
	or b ; $656e
	jr nz, .loop ; $656f
	ret ; $6571
UnlockDebugNavGridTable:
	; $6572, 32 bytes (bytes:16)
	db $1a, $1b, $1c, $1d, $1e, $fe, $fd, $ff, $1f, $12, $13, $14, $15, $fe, $fd, $ff ; 0x00
	db $ff, $ff, $ff, $ff, $ff, $fe, $fd, $ff, $ff, $ff, $ff, $ff, $ff, $fe, $fd, $ff ; 0x10
UnlockDebugRosterTable:
	; $6592, 88 bytes (bytes:8)
	db $1a, $00, $00, $b6, $20, $18, $83, $00 ; 0x00
	db $1b, $00, $00, $b7, $20, $30, $86, $00 ; 0x08
	db $1c, $00, $00, $a8, $20, $48, $89, $00 ; 0x10
	db $1d, $00, $00, $a9, $20, $60, $8c, $00 ; 0x18
	db $1e, $00, $00, $aa, $20, $78, $8f, $00 ; 0x20
	db $1f, $00, $00, $ab, $38, $18, $e3, $00 ; 0x28
	db $12, $00, $00, $ac, $38, $30, $e6, $00 ; 0x30
	db $13, $00, $00, $ad, $38, $48, $e9, $00 ; 0x38
	db $14, $00, $00, $ae, $38, $60, $ec, $00 ; 0x40
	db $15, $00, $00, $af, $38, $78, $ef, $00 ; 0x48
	db $ff, $00, $00, $b0, $18, $20, $64, $00 ; 0x50
FindUnlockDebugRosterEntry:
	ld hl, wCharSelectRoster ; $65ea
	farcall FindRosterEntry ; $65ed
	ret ; $65f0
GetUnlockDebugRosterField:
	push hl ; $65f1
	call FindUnlockDebugRosterEntry ; $65f2
	ld a, [hl+] ; $65f5
	ld d, [hl] ; $65f6
	ld e, a ; $65f7
	pop hl ; $65f8
	ret ; $65f9
LoadUnlockDebugNavGrid:
	ld hl, UnlockDebugNavGridTable ; $65fa
	ld de, $c7a0 ; $65fd
	ld bc, $0020 ; $6600
	call CopyMemoryBC ; $6603
	ret ; $6606
	db $0b ; $6607
	db $0c ; $6608
LoadUnlockDebugRosterTable:
	ld hl, UnlockDebugRosterTable ; $6609
	ld de, wCharSelectRoster ; $660c
	ld bc, $0080 ; $660f
	call CopyMemoryBC ; $6612
	ret ; $6615
	db $08 ; $6616
	db $09 ; $6617
LoadUnlockDebugScreenGfx:
	ld hl, $d000 ; $6618
	ld de, $9000 + VRAM_BANK1 ; $661b
	ld c, $80 ; $661e
	call QueueVRAMCopy ; $6620
	ld hl, $d800 ; $6623
	ld de, $8800 + VRAM_BANK1 ; $6626
	ld c, $80 ; $6629
	call QueueVRAMCopy ; $662b
	ld hl, UnlockDebugNavGridTable ; $662e
	ld de, $dc00 ; $6631
	call DecompressData ; $6634
	ld hl, UnlockDebugNavGridTable ; $6637
	ld de, $d800 ; $663a
	call DecompressData ; $663d
	ld hl, UnlockDebugNavGridTable ; $6640
	ld de, $0008 ; $6643
	call LoadPaletteShadow ; $6646
	ret ; $6649
; Decompresses UnlockDebugNavGridTable to $d000, uploads it to $8500 and loads
; its palette. The leading `ret` means it never runs -- this is debug-screen
; artwork, so the screen presumably renders without it.
LoadUnlockDebugNavGridGfx:
	ret ; $664a
	ld hl, UnlockDebugNavGridTable ; $664b
	ld de, $d000 ; $664e
	call DecompressData ; $6651
	ld hl, $d000 ; $6654
	ld de, $8500 ; $6657
	ld c, $28 ; $665a
	call QueueVRAMCopy ; $665c
	ld hl, UnlockDebugNavGridTable ; $665f
	ld de, $0801 ; $6662
	call LoadPaletteShadow ; $6665
	ld a, $0a ; $6668
	ld hl, UpdateBobbingDecorSprite ; $666a
	call RegisterFrameTask ; $666d
	ret ; $6670
UpdateBobbingDecorSprite:
	ld de, $2cfa ; $6671
	farcall ApplySpriteBobOffset_18 ; $6674
	ld hl, UnlockDebugNavGridTable ; $6677
	ld bc, $0050 ; $667a
	call QueueSpriteTemplate ; $667d
	ret ; $6680
StartUnlockDebugCursorTask:
	farcall LoadCharSelectCursorGfx ; $6681
	ld a, $0a ; $6684
	ld hl, UpdateUnlockDebugCursorTask ; $6686
	call RegisterFrameTask ; $6689
	ret ; $668c
UpdateUnlockDebugCursorTask:
	ld a, [wCharSelectChar] ; $668d
	ld de, $0004 ; $6690
	call GetUnlockDebugRosterField ; $6693
	ld a, [wCharSelectChar] ; $6696
	farcall DrawCharSelectCursor ; $6699
	ret ; $669c
UpdateUnlockDebugSelectedMugshot:
	ld a, [wCharSelectChar] ; $669d
	push af ; $66a0
	ld de, $0006 ; $66a1
	call GetUnlockDebugRosterField ; $66a4
	pop af ; $66a7
	ld b, a ; $66a8
	push bc ; $66a9
	farcall CheckUnlockFlag ; $66aa
	pop bc ; $66ad
	ld a, b ; $66ae
	jr z, .registerFrameTask2 ; $66af
	farcall LoadCharacterRecordToBuffer ; $66b1
	jr .registerFrameTask ; $66b4
.registerFrameTask2:
	ld a, $20 ; $66b6
	ld [wCharRecordBuffer + 11], a ; $66b8
.registerFrameTask:
	ld a, $0a ; $66bb
	ld hl, UpdateUnlockDebugStatOnChange ; $66bd
	call RegisterFrameTask ; $66c0
	ret ; $66c3
UpdateUnlockDebugStatOnChange:
	ld hl, wCharSelectChar ; $66c4
	ld a, [wCharSelectPrevChar] ; $66c7
	cp [hl] ; $66ca
	jr z, .done ; $66cb
	ld a, [wCharSelectChar] ; $66cd
	ld de, $0006 ; $66d0
	call GetUnlockDebugRosterField ; $66d3
.done:
	ret ; $66d6
DrawUnlockDebugMugshots:
	farcall ResetMugshotPalettes_1b ; $66d7
	ld hl, wCharSelectRoster ; $66da
.loop:
	ld a, [hl] ; $66dd
	farcall LoadCharacterRecordToBuffer ; $66de
	farcall CheckUnlockFlag ; $66e1
	jr z, .step ; $66e4
	ld a, [wCharRecordBuffer + 11] ; $66e6
	farcall LoadCharMugshotToBuffer ; $66e9
	ld a, [hl] ; $66ec
	ld de, $0002 ; $66ed
	call GetUnlockDebugRosterField ; $66f0
	farcall CopyMugshotBufferToVram ; $66f3
	ld a, [hl] ; $66f6
	ld de, $0006 ; $66f7
	call GetUnlockDebugRosterField ; $66fa
	ld a, [wCharRecordBuffer + 12] ; $66fd
	farcall SetMugshotAttrs ; $6700
.step:
	ld a, $08 ; $6703
	add l ; $6705
	ld l, a ; $6706
	jr nc, .read ; $6707
	inc h ; $6709
.read:
	ld a, [hl] ; $670a
	cp $ff ; $670b
	jr nz, .loop ; $670d
	ld a, [wCharSelectChar] ; $670f
	farcall LoadCharacterRecordToBuffer ; $6712
	ld a, [wCharRecordBuffer + 11] ; $6715
	farcall StubNop_1b_4e43 ; $6718
	ret ; $671b
RunMinigameFlagsDebugScreen:
	wram_bank $01 ; $671c
	call ClearFrameTasks ; $6722
	call LoadUnlockDebugNavGrid ; $6725
	call LoadUnlockDebugRosterTable ; $6728
	ld hl, wUnlockDebugSelection ; $672b
	call UpdateUnlockDebugSelection ; $672e
	ld a, [wCharSelectChar] ; $6731
	ld [wCharSelectPrevChar], a ; $6734
	call ReadUnlockFlagsSaveBlock ; $6737
	ld c, $20 ; $673a
	call BeginFadeOut ; $673c
	call WaitFadeEnd ; $673f
	call DisableLCDSafely ; $6742
	call LoadUnlockDebugNavGridGfx ; $6745
	call StartUnlockDebugCursorTask ; $6748
	call LoadUnlockDebugScreenGfx ; $674b
	call DrawUnlockDebugMugshots ; $674e
	call UpdateUnlockDebugSelectedMugshot ; $6751
	ld hl, $dc00 ; $6754
	ld de, $9800 + VRAM_BANK1 ; $6757
	ld c, $24 ; $675a
	call QueueVRAMCopy ; $675c
	ld hl, $d800 ; $675f
	ld de, $9800 ; $6762
	ld c, $24 ; $6765
	call QueueVRAMCopy ; $6767
	call LoadUnlockDebugCursorGfx ; $676a
	call EnableLCD ; $676d
	script_fade_in $20 ; $6770
	call WaitFadeEnd ; $6775
.loop:
	wram_bank $01 ; $6778
	ldh a, [hInputRisingEdge] ; $677e
	and PADF_A ; $6780
	jr z, .checkInputRisingEdge ; $6782
	ld a, [wCharSelectChar] ; $6784
	ld b, a ; $6787
	push bc ; $6788
	farcall CheckUnlockFlag ; $6789
	pop bc ; $678c
	ld a, b ; $678d
	jr z, .playSfx ; $678e
	jr .playSfx2 ; $6790
.playSfx:
	sound $62 ; $6792
	jr .loop ; $6794
.playSfx2:
	sound $5f ; $6796
	ld hl, wUnlockDebugSelection ; $6798
	jr .beginFadeOut ; $679b
.checkInputRisingEdge:
	ldh a, [hInputRisingEdge] ; $679d
	and PADF_B ; $679f
	jr z, .checkInputRisingEdge2 ; $67a1
	sound $62 ; $67a3
	ld hl, wUnlockDebugSelection ; $67a5
	ld a, $00 ; $67a8
	ld [hl], a ; $67aa
	ld a, $ff ; $67ab
	jr .beginFadeOut ; $67ad
.checkInputRisingEdge2:
	ldh a, [hInputRisingEdge] ; $67af
	and PADF_START ; $67b1
	jr z, .moveUnlockDebugCursor ; $67b3
	call ToggleSelectedUnlockFlag ; $67b5
.moveUnlockDebugCursor:
	call MoveUnlockDebugCursor ; $67b8
	call UpdateUnlockDebugSelection ; $67bb
	ld a, [wCharSelectChar] ; $67be
	call AdvanceFrame ; $67c1
	jr .loop ; $67c4
.beginFadeOut:
	ld c, $08 ; $67c6
	call BeginFadeOut ; $67c8
	call WaitFadeEnd ; $67cb
	call WriteUnlockFlagsSaveBlock ; $67ce
	call AdvanceFrame ; $67d1
	call AdvanceFrame ; $67d4
	ret ; $67d7
UpdateUnlockDebugSelection:
	ld a, [wCharSelectChar] ; $67d8
	ld [wCharSelectPrevChar], a ; $67db
	ld a, [wCharSelectRow] ; $67de
	add a ; $67e1
	add a ; $67e2
	add a ; $67e3
	ld hl, wCharSelectCol ; $67e4
	add [hl] ; $67e7
	add $a0 ; $67e8
	ld l, a ; $67ea
	adc $c7 ; $67eb
	sub l ; $67ed
	ld h, a ; $67ee
	ld a, [hl] ; $67ef
	ld [wCharSelectChar], a ; $67f0
	ret ; $67f3
MoveUnlockDebugCursor:
	ldh a, [hInputPressed] ; $67f4
	ld b, a ; $67f6
	and $f0 ; $67f7
	jr z, .done ; $67f9
	sound $5e ; $67fb
	ld a, [wCharSelectCol] ; $67fd
	ld d, a ; $6800
	ld a, [wCharSelectRow] ; $6801
	ld e, a ; $6804
	ld hl, $c7a0 ; $6805
	call StepUnlockDebugCursor ; $6808
	ld b, a ; $680b
	push bc ; $680c
	farcall CheckUnlockFlag ; $680d
	pop bc ; $6810
	ld a, b ; $6811
	jr z, .storeCharSelectCol2 ; $6812
	farcall LoadCharacterRecordToBuffer ; $6814
	jr .storeCharSelectCol ; $6817
.storeCharSelectCol2:
	ld a, $20 ; $6819
	ld [wCharRecordBuffer + 11], a ; $681b
.storeCharSelectCol:
	ld a, d ; $681e
	ld [wCharSelectCol], a ; $681f
	ld a, e ; $6822
	ld [wCharSelectRow], a ; $6823
.done:
	ret ; $6826
StepUnlockDebugCursor:
	bit 5, b ; $6827
	jr z, .bit5Clear ; $6829
	dec d ; $682b
	jr .wrapX ; $682c
.bit5Clear:
	bit 4, b ; $682e
	jr z, .bit4Clear ; $6830
	inc d ; $6832
	jr .wrapX ; $6833
.bit4Clear:
	bit 6, b ; $6835
	jr z, .bit6Clear ; $6837
	dec e ; $6839
	jr .wrapX ; $683a
.bit6Clear:
	bit 7, b ; $683c
	jr z, .wrapX ; $683e
	inc e ; $6840
.wrapX:
	ld a, d ; $6841
	add a ; $6842
	jr nc, .noCarry ; $6843
	ld a, $05 ; $6845
	dec a ; $6847
	jr .storeX ; $6848
.noCarry:
	rra ; $684a
	cp $05 ; $684b
	jr c, .storeX ; $684d
	xor a ; $684f
.storeX:
	ld d, a ; $6850
	ld a, e ; $6851
	add a ; $6852
	jr nc, .noCarry2 ; $6853
	ld a, $02 ; $6855
	dec a ; $6857
	jr .storeY ; $6858
.noCarry2:
	rra ; $685a
	cp $02 ; $685b
	jr c, .storeY ; $685d
	xor a ; $685f
.storeY:
	ld e, a ; $6860
	ld a, e ; $6861
	add a ; $6862
	add a ; $6863
	add a ; $6864
	add d ; $6865
	push hl ; $6866
	add l ; $6867
	ld l, a ; $6868
	jr nc, .read ; $6869
	inc h ; $686b
.read:
	ld a, [hl] ; $686c
	pop hl ; $686d
	ret ; $686e
ReadUnlockFlagsSaveBlock:
	push bc ; $686f
	ldh a, [hWramBank] ; $6870
	push af ; $6872
	wram_bank $06 ; $6873
	ld hl, $d400 ; $6879
	ld b, $0b ; $687c
	farcall ReadSaveBlock ; $687e
	ld b, a ; $6881
	pop af ; $6882
	wram_bank ; $6883
	ld a, b ; $6887
	pop bc ; $6888
	ret ; $6889
WriteUnlockFlagsSaveBlock:
	ldh a, [hWramBank] ; $688a
	push af ; $688c
	wram_bank $06 ; $688d
	ld hl, $d400 ; $6893
	ld de, $0000 ; $6896
	ld b, $0b ; $6899
	farcall WriteSaveBlock ; $689b
	pop af ; $689e
	wram_bank ; $689f
	ret ; $68a3
ToggleSelectedUnlockFlag:
	ldh a, [hWramBank] ; $68a4
	push af ; $68a6
	wram_bank $06 ; $68a7
	ld hl, $d400 ; $68ad
	ld a, [wCharSelectChar] ; $68b0
	cp $1a ; $68b3
	jr c, .playSfx ; $68b5
	cp $20 ; $68b7
	jr nc, .playSfx ; $68b9
	sub $18 ; $68bb
	add l ; $68bd
	ld l, a ; $68be
	jr nc, .read ; $68bf
	inc h ; $68c1
.read:
	ld a, [hl] ; $68c2
	xor $01 ; $68c3
	ld [hl], a ; $68c5
	sound $5f ; $68c6
	pop af ; $68c8
	wram_bank ; $68c9
	ret ; $68cd
.playSfx:
	sound $62 ; $68ce
	pop af ; $68d0
	wram_bank ; $68d1
	ret ; $68d5
LoadUnlockDebugCursorGfx:
	ldh a, [hWramBank] ; $68d6
	push af ; $68d8
	wram_bank $01 ; $68d9
	ld hl, UnlockDebugCursorGfx ; $68df
	ld de, $d000 ; $68e2
	call DecompressData ; $68e5
	ld hl, $d000 ; $68e8
	ld de, $8500 ; $68eb
	ld c, $02 ; $68ee
	call QueueVRAMCopy ; $68f0
	pop af ; $68f3
	wram_bank ; $68f4
	ld hl, Palette_1b_6930 ; $68f8
	ld de, $0801 ; $68fb
	call LoadPaletteShadow ; $68fe
	ld a, $01 ; $6901
	ld hl, DrawUnlockDebugFlagSprites ; $6903
	call RegisterFrameTask ; $6906
	ret ; $6909
UnlockDebugCursorGfx:
	INCBIN "data/bank_01b/d_690a.bin" ; $690a, 38 bytes
Palette_1b_6930:
	INCLUDE "data/bank_01b/palettes_6930.asm" ; $6930, 8 bytes (palettes)
DrawUnlockDebugFlagSprites:
	ldh a, [hWramBank] ; $6938
	push af ; $693a
	wram_bank $06 ; $693b
	ld hl, $d402 ; $6941
	xor a ; $6944
.loop:
	push af ; $6945
	add a ; $6946
	bit 0, [hl] ; $6947
	inc hl ; $6949
	jr z, .restore ; $694a
	push hl ; $694c
	ld hl, UnlockDebugFlagSprites ; $694d
	add l ; $6950
	ld l, a ; $6951
	jr nc, .read ; $6952
	inc h ; $6954
.read:
	ld d, [hl] ; $6955
	inc hl ; $6956
	ld e, [hl] ; $6957
	pop hl ; $6958
	call QueueBobbingFlagSprite ; $6959
.restore:
	pop af ; $695c
	inc a ; $695d
	cp $06 ; $695e
	jr c, .loop ; $6960
	pop af ; $6962
	wram_bank ; $6963
	ret ; $6967
UnlockDebugFlagSprites:
	; $6968, 12 bytes (bytes:12)
	db $24, $28, $3c, $28, $54, $28, $6c, $28, $84, $28, $24, $40 ; 0x00
QueueBobbingFlagSprite:
	push hl ; $6974
	farcall ApplySpriteBobOffset_18 ; $6975
	ld c, $50 ; $6978
	ld b, $00 ; $697a
	call QueueSprite ; $697c
	pop hl ; $697f
	ret ; $6980
	ret ; $6981
RunStoryDataConfirmMenu:
	wram_bank $01 ; $6982
	ld c, $20 ; $6988
	call BeginFadeOut ; $698a
	call WaitFadeEnd ; $698d
	call DisableLCDSafely ; $6990
	xor a ; $6993
	ld [wMinigameHighScoreMode], a ; $6994
	ld [wStoryDataPromptFlag], a ; $6997
	farcall ForceFlushBgMapToVram ; $699a
	call EnableLCD ; $699d
	script_fade_in $20 ; $69a0
	call WaitFadeEnd ; $69a5
	wram_bank $07 ; $69a8
	xor a ; $69ae
	ld [wStubbedPromptTaskState], a ; $69af
	ld a, $0c ; $69b2
	ld [wStubbedPromptTaskState + 1], a ; $69b4
	ld a, $01 ; $69b7
	ld hl, StubNop_1b_69d6 ; $69b9
	call RegisterFrameTask ; $69bc
	ld b, $01 ; $69bf
	farcall RunTwoOptionSelectB ; $69c1
	push af ; $69c4
	ld hl, StubNop_1b_69d6 ; $69c5
	call UnregisterFrameTask ; $69c8
	pop af ; $69cb
	ret ; $69cc
Data_1b_69cd:
	; $69cd, 9 bytes (bytes:9)
	db $c9, $ff, $36, $ff, $36, $ff, $36, $ff, $36 ; 0x00
StubNop_1b_69d6:
	ret ; $69d6
	ret ; $69d7
	ret ; $69d8
	ld hl, wMinigameHighScoreMode ; $69d9
	ld [hl], $01 ; $69dc
	wram_bank $01 ; $69de
	ld c, $20 ; $69e4
	call BeginFadeOut ; $69e6
	call WaitFadeEnd ; $69e9
	call DisableLCDSafely ; $69ec
	farcall InitConfirmScreen ; $69ef
	call StubNop_1b_6aad ; $69f2
	farcall ForceFlushBgMapToVram ; $69f5
	call EnableLCD ; $69f8
	script_fade_in $20 ; $69fb
	call WaitFadeEnd ; $6a00
.loop:
	and a ; $6a03
	jr nz, .loop ; $6a04
	ld b, $00 ; $6a06
	farcall StubNop_18_5379 ; $6a08
	call AdvanceFrame ; $6a0b
	ret ; $6a0e
	ld hl, wPlayer1MainName ; $6a0f
	farcall PushTextArgString ; $6a12
	ld de, $d9c1 ; $6a15
	call CopyMainCharNameWithDiacritics ; $6a18
	ld hl, $046a ; $6a1b
	farcall RenderProportionalTextAt32 ; $6a1e
	farcall DrawYesNoLabels ; $6a21
	ret ; $6a24
	ld hl, $046d ; $6a25
	ld de, $d9c1 ; $6a28
	farcall RenderProportionalTextAt32 ; $6a2b
	farcall DrawYesNoLabels ; $6a2e
	ret ; $6a31
	ld hl, $046b ; $6a32
	ld de, $d9c1 ; $6a35
	farcall RenderProportionalTextAt32 ; $6a38
	farcall DrawYesNoLabels ; $6a3b
	ret ; $6a3e
	ld hl, $0471 ; $6a3f
	ld de, $d9c1 ; $6a42
	farcall RenderProportionalTextAt32 ; $6a45
	farcall DrawYesNoLabels ; $6a48
	ret ; $6a4b
	ld hl, $0162 ; $6a4c
	ld de, $d9c1 ; $6a4f
	farcall RenderProportionalTextAt32 ; $6a52
	ld hl, $0162 ; $6a55
	ld de, $da01 ; $6a58
	farcall RenderProportionalTextAt32 ; $6a5b
	ret ; $6a5e
	ld a, [wGameTimer + 3] ; $6a5f
	ld h, $00 ; $6a62
	ld l, a ; $6a64
	ld a, $02 ; $6a65
	ld de, $da05 ; $6a67
	farcall DrawDecimalNumberToTilemap ; $6a6a
	ld a, [wGameTimer + 2] ; $6a6d
	add $64 ; $6a70
	ld h, $00 ; $6a72
	ld l, a ; $6a74
	ld a, $03 ; $6a75
	ld de, $da07 ; $6a77
	farcall DrawDecimalNumberToTilemap ; $6a7a
	ld a, [wGameTimer + 1] ; $6a7d
	add $64 ; $6a80
	ld h, $00 ; $6a82
	ld l, a ; $6a84
	ld a, $03 ; $6a85
	ld de, $da0a ; $6a87
	farcall DrawDecimalNumberToTilemap ; $6a8a
	ld a, $3a ; $6a8d
	ld de, $da07 ; $6a8f
	farcall WriteTilemapByteAdvance ; $6a92
	ld a, $3a ; $6a95
	ld de, $da0a ; $6a97
	farcall WriteTilemapByteAdvance ; $6a9a
	call QueueStoryInfoRowToVram ; $6a9d
	ret ; $6aa0
QueueStoryInfoRowToVram:
	ld hl, $da00 ; $6aa1
	ld de, $9a00 ; $6aa4
	ld c, $01 ; $6aa7
	call QueueVRAMCopy ; $6aa9
	ret ; $6aac
StubNop_1b_6aad:
	ret ; $6aad
CopyMainCharNameWithDiacritics:
	push de ; $6aae
	ld hl, wStoryModeNameOfMainCharacter ; $6aaf
	pop de ; $6ab2
.loop:
	ld a, [hl+] ; $6ab3
	and a ; $6ab4
	jr z, .done ; $6ab5
	cp $de ; $6ab7
	jr z, .eqde ; $6ab9
	cp $df ; $6abb
	jr z, .eqdf ; $6abd
	ld b, a ; $6abf
	ld a, b ; $6ac0
	ld [de], a ; $6ac1
	inc de ; $6ac2
	jr .loop ; $6ac3
.eqde:
	push de ; $6ac5
	push hl ; $6ac6
	ld hl, $ffdf ; $6ac7
	add hl, de ; $6aca
	ld [hl], $0e ; $6acb
	pop hl ; $6acd
	pop de ; $6ace
	jr .loop ; $6acf
.eqdf:
	push de ; $6ad1
	push hl ; $6ad2
	ld hl, $ffdf ; $6ad3
	add hl, de ; $6ad6
	ld [hl], $0f ; $6ad7
	pop hl ; $6ad9
	pop de ; $6ada
	jr .loop ; $6adb
.done:
	ret ; $6add
ShowNoN64DataFoundScreen:
	wram_bank $01 ; $6ade
	ld c, $20 ; $6ae4
	call BeginFadeOut ; $6ae6
	call WaitFadeEnd ; $6ae9
	call DisableLCDSafely ; $6aec
	ld a, $20 ; $6aef
	ld hl, $d862 ; $6af1
	call FillTilemapRow17 ; $6af4
	ld hl, $d882 ; $6af7
	call FillTilemapRow17 ; $6afa
	ld hl, $d8a2 ; $6afd
	call FillTilemapRow17 ; $6b00
	ld hl, $d8c2 ; $6b03
	call FillTilemapRow17 ; $6b06
	ld hl, $d8e2 ; $6b09
	call FillTilemapRow17 ; $6b0c
	ld a, $00 ; $6b0f
	ld hl, $dc62 ; $6b11
	call FillTilemapRow17 ; $6b14
	ld hl, $dc82 ; $6b17
	call FillTilemapRow17 ; $6b1a
	ld hl, $dca2 ; $6b1d
	call FillTilemapRow17 ; $6b20
	ld hl, $dcc2 ; $6b23
	call FillTilemapRow17 ; $6b26
	ld hl, $dce2 ; $6b29
	call FillTilemapRow17 ; $6b2c
	ld hl, $047b ; $6b2f
	ld de, $d883 ; $6b32
	farcall RenderProportionalTextAt32 ; $6b35
	ld hl, $047c ; $6b38
	ld de, $d8c3 ; $6b3b
	farcall RenderProportionalTextAt32 ; $6b3e
	farcall ForceFlushBgMapToVram ; $6b41
	call EnableLCD ; $6b44
	script_fade_in $20 ; $6b47
	call WaitFadeEnd ; $6b4c
.loop:
	ldh a, [hInputRisingEdge] ; $6b4f
	and PADF_A | PADF_B ; $6b51
	jr nz, .playSfx ; $6b53
	call AdvanceFrame ; $6b55
	jr .loop ; $6b58
.playSfx:
	sound $5f ; $6b5a
	ret ; $6b5c
FillTilemapRow17:
	ld [hl+], a ; $6b5d
	ld [hl+], a ; $6b5e
	ld [hl+], a ; $6b5f
	ld [hl+], a ; $6b60
	ld [hl+], a ; $6b61
	ld [hl+], a ; $6b62
	ld [hl+], a ; $6b63
	ld [hl+], a ; $6b64
	ld [hl+], a ; $6b65
	ld [hl+], a ; $6b66
	ld [hl+], a ; $6b67
	ld [hl+], a ; $6b68
	ld [hl+], a ; $6b69
	ld [hl+], a ; $6b6a
	ld [hl+], a ; $6b6b
	ld [hl+], a ; $6b6c
	ld [hl+], a ; $6b6d
	ret ; $6b6e
ShowTrophiesPlaceholderScreen:
	wram_bank $01 ; $6b6f
	ld c, $20 ; $6b75
	call BeginFadeOut ; $6b77
	call WaitFadeEnd ; $6b7a
	call DisableLCDSafely ; $6b7d
	farcall ForceFlushBgMapToVram ; $6b80
	call EnableLCD ; $6b83
	script_fade_in $20 ; $6b86
	call WaitFadeEnd ; $6b8b
.loop:
	ldh a, [hInputRisingEdge] ; $6b8e
	and PADF_A | PADF_B ; $6b90
	jr nz, .playSfx ; $6b92
	call AdvanceFrame ; $6b94
	jr .loop ; $6b97
.playSfx:
	sound $5f ; $6b99
	ret ; $6b9b
RunMinigameLevelSelect:
	ldh a, [hWramBank] ; $6b9c
	push af ; $6b9e
	wram_bank $02 ; $6b9f
	ld a, c ; $6ba5
	ld [$d000], a ; $6ba6
	xor a ; $6ba9
	ld [$d001], a ; $6baa
	call CountClearedMinigameLevels ; $6bad
	call LoadMinigameLevelSelectGfx ; $6bb0
	ld a, [$d001] ; $6bb3
	cp $02 ; $6bb6
	jr z, .runMinigameLevelSelect3 ; $6bb8
	call RunMinigameLevelSelect2 ; $6bba
	jr .step ; $6bbd
.runMinigameLevelSelect3:
	call RunMinigameLevelSelect3 ; $6bbf
.step:
	wram_bank $02 ; $6bc2
	ld a, [$d003] ; $6bc8
	ld c, a ; $6bcb
	pop af ; $6bcc
	wram_bank ; $6bcd
	ld a, c ; $6bd1
	ret ; $6bd2
CountClearedMinigameLevels:
	ld c, $00 ; $6bd3
	ld a, [$d000] ; $6bd5
	add a ; $6bd8
	ld hl, ClearedMinigameLevelsTable ; $6bd9
	add l ; $6bdc
	ld l, a ; $6bdd
	jr nc, .read ; $6bde
	inc h ; $6be0
.read:
	ld a, [hl+] ; $6be1
	ld h, [hl] ; $6be2
	ld l, a ; $6be3
	push hl ; $6be4
	ld a, [hl+] ; $6be5
	ld d, [hl] ; $6be6
	ld e, a ; $6be7
	farcall TestSaveFlag ; $6be8
	pop hl ; $6beb
	jr z, .next ; $6bec
	inc c ; $6bee
.next:
	inc hl ; $6bef
	inc hl ; $6bf0
	ld a, [hl+] ; $6bf1
	ld d, [hl] ; $6bf2
	ld e, a ; $6bf3
	farcall TestSaveFlag ; $6bf4
	jr z, .countDone ; $6bf7
	inc c ; $6bf9
.countDone:
	ld a, c ; $6bfa
	ld [$d001], a ; $6bfb
	ld a, [$d001] ; $6bfe
	ld hl, CountClearedMinigameLevelsTable ; $6c01
	add l ; $6c04
	ld l, a ; $6c05
	jr nc, .readB ; $6c06
	inc h ; $6c08
.readB:
	ld a, [hl] ; $6c09
	ld [$d002], a ; $6c0a
	ret ; $6c0d
CountClearedMinigameLevelsTable:
	; $6c0e, 3 bytes (bytes:3)
	db $02, $02, $03 ; 0x00
ClearedMinigameLevelsTable:
	; $6c11, 18 bytes (records:2)
	dw MinigameLevelRow0 ; record 0
	dw MinigameLevelRow1 ; record 1
	dw MinigameLevelRow2 ; record 2
	dw MinigameLevelRow3 ; record 3
	dw MinigameLevelRow4 ; record 4
	dw MinigameLevelRow5 ; record 5
	dw MinigameLevelRow6 ; record 6
	dw MinigameLevelRow7 ; record 7
	dw MinigameLevelRow8 ; record 8
MinigameLevelRow0:
	INCBIN "data/bank_01b/d_6c23.bin" ; $6c23, 6 bytes
MinigameLevelRow1:
	INCBIN "data/bank_01b/d_6c29.bin" ; $6c29, 6 bytes
MinigameLevelRow2:
	INCBIN "data/bank_01b/d_6c2f.bin" ; $6c2f, 6 bytes
MinigameLevelRow3:
	INCBIN "data/bank_01b/d_6c35.bin" ; $6c35, 6 bytes
MinigameLevelRow4:
	INCBIN "data/bank_01b/d_6c3b.bin" ; $6c3b, 6 bytes
MinigameLevelRow5:
	INCBIN "data/bank_01b/d_6c41.bin" ; $6c41, 6 bytes
MinigameLevelRow6:
	INCBIN "data/bank_01b/d_6c47.bin" ; $6c47, 6 bytes
MinigameLevelRow7:
	INCBIN "data/bank_01b/d_6c4d.bin" ; $6c4d, 6 bytes
MinigameLevelRow8:
	INCBIN "data/bank_01b/d_6c53.bin" ; $6c53, 6 bytes
LoadMinigameLevelSelectGfx:
	ldh a, [hWramBank] ; $6c59
	push af ; $6c5b
	wram_bank $01 ; $6c5c
	ld c, $00 ; $6c62
.loop:
	ld a, c ; $6c64
	add a ; $6c65
	ld hl, MinigameLevelSelectGfxTable ; $6c66
	add l ; $6c69
	ld l, a ; $6c6a
	jr nc, .read ; $6c6b
	inc h ; $6c6d
.read:
	ld a, [hl+] ; $6c6e
	ld h, [hl] ; $6c6f
	ld l, a ; $6c70
	push af ; $6c71
	push bc ; $6c72
	push de ; $6c73
	push hl ; $6c74
	ld de, $d000 ; $6c75
	call DecompressDataFromBank ; $6c78
	pop hl ; $6c7b
	pop de ; $6c7c
	pop bc ; $6c7d
	pop af ; $6c7e
	ld hl, MinigameLevelSelectTable ; $6c7f
	ld a, c ; $6c82
	add a ; $6c83
	add l ; $6c84
	ld l, a ; $6c85
	jr nc, .readB ; $6c86
	inc h ; $6c88
.readB:
	ld a, [hl+] ; $6c89
	ld d, [hl] ; $6c8a
	ld e, a ; $6c8b
	ld hl, $d000 ; $6c8c
	push af ; $6c8f
	push bc ; $6c90
	push de ; $6c91
	push hl ; $6c92
	ld bc, $0010 ; $6c93
	call QueueVRAMCopy ; $6c96
	pop hl ; $6c99
	pop de ; $6c9a
	pop bc ; $6c9b
	pop af ; $6c9c
	ld a, c ; $6c9d
	inc a ; $6c9e
	ld c, a ; $6c9f
	call AdvanceFrame ; $6ca0
	ldh a, [hWramBank] ; $6ca3
	push af ; $6ca5
	wram_bank $02 ; $6ca6
	ld a, [$d001] ; $6cac
	ld b, a ; $6caf
	pop af ; $6cb0
	wram_bank ; $6cb1
	ld a, b ; $6cb5
	or a ; $6cb6
	jr z, .zero ; $6cb7
	ld a, c ; $6cb9
	cp $03 ; $6cba
	jr nz, .loop ; $6cbc
	jr .loadCompressedTileBlock2 ; $6cbe
.zero:
	ld a, c ; $6cc0
	cp $04 ; $6cc1
	jr nz, .loop ; $6cc3
.loadCompressedTileBlock2:
	ld b, $70 ; $6cc5
	ld c, $10 ; $6cc7
	ld de, $8000 + VRAM_BANK1 ; $6cc9
	farcall LoadCompressedTileBlock ; $6ccc
	call AdvanceFrame ; $6ccf
	ldh a, [hWramBank] ; $6cd2
	push af ; $6cd4
	wram_bank $02 ; $6cd5
	ld a, [$d001] ; $6cdb
	ld b, a ; $6cde
	pop af ; $6cdf
	wram_bank ; $6ce0
	ld a, b ; $6ce4
	or a ; $6ce5
	jr z, .zero2 ; $6ce6
	ld b, $71 ; $6ce8
	jr .loadCompressedTileBlock ; $6cea
.zero2:
	ld b, $6f ; $6cec
.loadCompressedTileBlock:
	ld c, $10 ; $6cee
	ld de, $8100 + VRAM_BANK1 ; $6cf0
	farcall LoadCompressedTileBlock ; $6cf3
	call AdvanceFrame ; $6cf6
	ld b, $72 ; $6cf9
	ld c, $10 ; $6cfb
	ld de, $8200 + VRAM_BANK1 ; $6cfd
	farcall LoadCompressedTileBlock ; $6d00
	call AdvanceFrame ; $6d03
	ld b, $1b ; $6d06
	ld c, $04 ; $6d08
	ld de, $8700 + VRAM_BANK1 ; $6d0a
	farcall LoadCompressedTileBlock ; $6d0d
	call AdvanceFrame ; $6d10
	ld b, $77 ; $6d13
	ld c, $14 ; $6d15
	ld de, $8000 ; $6d17
	farcall LoadCompressedTileBlock ; $6d1a
	call AdvanceFrame ; $6d1d
	ld b, $08 ; $6d20
	ld c, $10 ; $6d22
	farcall LoadIndexedPalette ; $6d24
	pop af ; $6d27
	wram_bank ; $6d28
	ret ; $6d2c
MinigameLevelSelectGfxTable:
	; $6d2d, 8 bytes (records:2)
	dw Label_1b_6d8a ; record 0
	dw Label_1b_6d8c ; record 1
	dw Label_1b_6d8e ; record 2
	dw MinigameLevelSelectGfxTable0 ; record 3
MinigameLevelSelectTable:
	; $6d35, 8 bytes (records:2)
	dw $a800 ; record 0
	dw $a900 ; record 1
	dw $aa00 ; record 2
	dw $a900 ; record 3
DrawMinigameLevelDescription:
	ldh a, [hWramBank] ; $6d3d
	push af ; $6d3f
	wram_bank $02 ; $6d40
	ld a, [$d001] ; $6d46
	or a ; $6d49
	jr nz, .getMenuCursorIndex ; $6d4a
	ld c, $03 ; $6d4c
	call GetMenuCursorIndex ; $6d4e
	cp $01 ; $6d51
	jr nz, .getMenuCursorIndex ; $6d53
	wram_bank $03 ; $6d55
	ld hl, $00c5 ; $6d5b
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $6d5e
	jr .renderTextToBuffer64 ; $6d61
.getMenuCursorIndex:
	wram_bank $03 ; $6d63
	ld c, $03 ; $6d69
	call GetMenuCursorIndex ; $6d6b
	ld b, a ; $6d6e
	ld hl, MinigameLevelDescriptionTable ; $6d6f
	add a ; $6d72
	add l ; $6d73
	ld l, a ; $6d74
	jr nc, .read ; $6d75
	inc h ; $6d77
.read:
	ld a, [hl+] ; $6d78
	ld d, [hl] ; $6d79
	ld e, a ; $6d7a
	ld a, b ; $6d7b
	ld hl, $00c2 ; $6d7c
	add l ; $6d7f
	ld l, a ; $6d80
	jr nc, .renderTextToBuffer64 ; $6d81
	inc h ; $6d83
.renderTextToBuffer64:
	ld c, $20 ; $6d84
	farcall RenderTextToBuffer64 ; $6d86
	pop af ; $6d89
Label_1b_6d8a:
	ldh [hWramBank], a ; $6d8a
Label_1b_6d8c:
	ldh [rWBK], a ; $6d8c
Label_1b_6d8e:
	ret ; $6d8e
MinigameLevelDescriptionTable:
	; $6d8f, 1 bytes (bytes:6)
	db $01 ; 0x00
MinigameLevelSelectGfxTable0:
	; $6d90, 5 bytes (bytes:6)
	db $d2, $01, $d2, $01, $d2 ; 0x00
LoadMinigameLevelSelectPalette:
	ld hl, MinigameLevelSelectPalettePtrs ; $6d95
	add a ; $6d98
	add l ; $6d99
	ld l, a ; $6d9a
	jr nc, .read ; $6d9b
	inc h ; $6d9d
.read:
	ld a, [hl+] ; $6d9e
	ld h, [hl] ; $6d9f
	ld l, a ; $6da0
	ld de, $0401 ; $6da1
	call LoadPaletteShadow ; $6da4
	ret ; $6da7
MinigameLevelSelectPalettePtrs:
	; $6da8, 6 bytes (records:2)
	dw MinigameLevelSelectPalette0 ; record 0
	dw MinigameLevelSelectPalette2 ; record 1
	dw MinigameLevelSelectPalette1 ; record 2
MinigameLevelSelectPalette0:
	; $6dae, 8 bytes (bytes:8)
	db $34, $53, $ff, $6b, $40, $02, $00, $00 ; 0x00
MinigameLevelSelectPalette1:
	; $6db6, 8 bytes (bytes:8)
	db $b7, $5e, $ff, $6b, $93, $7c, $00, $00 ; 0x00
MinigameLevelSelectPalette2:
	; $6dbe, 8 bytes (bytes:8)
	db $99, $52, $ff, $6b, $1f, $14, $00, $00 ; 0x00
FlushLevelSelectTextRows:
	ldh a, [hWramBank] ; $6dc6
	push af ; $6dc8
	wram_bank $03 ; $6dc9
	ld hl, wShadowAttrmap + 7 * TILEMAP_WIDTH ; $6dcf
	ld de, $98e0 + VRAM_BANK1 ; $6dd2
	ld c, $06 ; $6dd5
	call QueueVRAMCopy ; $6dd7
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $6dda
	ld de, $99e0 ; $6ddd
	ld c, $04 ; $6de0
	call QueueVRAMCopy ; $6de2
	pop af ; $6de5
	wram_bank ; $6de6
	ret ; $6dea
ClearMinigameLevelDescriptionRow:
	ldh a, [hWramBank] ; $6deb
	push af ; $6ded
	wram_bank $03 ; $6dee
	ld de, wShadowTilemap + 15 * TILEMAP_WIDTH ; $6df4
	ld b, $14 ; $6df7
	ld c, $01 ; $6df9
	ld h, $03 ; $6dfb
	farcall FillTilemapRect ; $6dfd
	ld a, $02 ; $6e00
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH], a ; $6e02
	ld a, $04 ; $6e05
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 19], a ; $6e07
	ld de, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $6e0a
	ld b, $12 ; $6e0d
	ld c, $01 ; $6e0f
	ld h, $20 ; $6e11
	farcall FillTilemapRect ; $6e13
	pop af ; $6e16
	wram_bank ; $6e17
	ret ; $6e1b
GetMinigameLevelColumnCount:
	push af ; $6e1c
	ldh a, [hWramBank] ; $6e1d
	push af ; $6e1f
	wram_bank $02 ; $6e20
	ld a, [$d002] ; $6e26
	ld b, a ; $6e29
	pop af ; $6e2a
	wram_bank ; $6e2b
	pop af ; $6e2f
	ret ; $6e30
RunMinigameLevelSelect2:
	call ResumeBGM ; $6e31
	sound $08 ; $6e34
	ld hl, rIE ; $6e36
	res 2, [hl] ; $6e39
	wram_bank $03 ; $6e3b
	ld a, [wMenuSlideDirection] ; $6e41
	ld b, a ; $6e44
	farcall OpenChoiceTabPanel ; $6e45
	farcall InitMenuBgScroll ; $6e48
	ld b, $01 ; $6e4b
	ld c, $01 ; $6e4d
	farcall LoadMenuSpritePalettePair ; $6e4f
	wram_bank $02 ; $6e52
	ld a, [$d001] ; $6e58
	ld c, a ; $6e5b
	ld b, $02 ; $6e5c
	call SetMenuCursorFromIndex ; $6e5e
	wram_bank $03 ; $6e61
	ld a, $01 ; $6e67
	ld hl, DrawMinigameLevelSelect2Cursor ; $6e69
	call RegisterFrameTask ; $6e6c
	call RedrawMinigameLevelSelect2 ; $6e6f
	wram_bank $03 ; $6e72
.loop:
	call AdvanceFrame ; $6e78
	ldh a, [hInputPressed] ; $6e7b
	ld [wMenuInputPressed], a ; $6e7d
	call GetMinigameLevelColumnCount ; $6e80
	ld c, $01 ; $6e83
	call MoveMenuCursorGrid ; $6e85
	or a ; $6e88
	jr z, .checkMenuInputPressed ; $6e89
	sound $5e ; $6e8b
	call RedrawMinigameLevelSelect2 ; $6e8d
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $6e90
	bit PADB_A, a ; $6e93
	jr nz, .getMenuCursorIndex ; $6e95
	bit 1, a ; $6e97
	jr nz, .playSfx2 ; $6e99
	jr .loop ; $6e9b
.getMenuCursorIndex:
	ld c, $03 ; $6e9d
	call GetMenuCursorIndex ; $6e9f
	or a ; $6ea2
	jr z, .playSfx ; $6ea3
	wram_bank $02 ; $6ea5
	ld a, [$d001] ; $6eab
	or a ; $6eae
	jr nz, .playSfx ; $6eaf
	sound $61 ; $6eb1
	jr .loop ; $6eb3
.playSfx:
	sound $5f ; $6eb5
	call ClearFrameTasks ; $6eb7
	ld hl, rIE ; $6eba
	set 2, [hl] ; $6ebd
	wram_bank $03 ; $6ebf
	ld b, $01 ; $6ec5
	farcall CloseChoiceTabPanel ; $6ec7
	ld a, $01 ; $6eca
	ld [wMenuSlideDirection], a ; $6ecc
	wram_bank $02 ; $6ecf
	ld c, $03 ; $6ed5
	call GetMenuCursorIndex ; $6ed7
	ld [$d003], a ; $6eda
	ret ; $6edd
.playSfx2:
	sound $62 ; $6ede
	call ClearFrameTasks ; $6ee0
	ld hl, rIE ; $6ee3
	set 2, [hl] ; $6ee6
	wram_bank $03 ; $6ee8
	ld b, $00 ; $6eee
	farcall CloseChoiceTabPanel ; $6ef0
	ld a, $00 ; $6ef3
	ld [wMenuSlideDirection], a ; $6ef5
	wram_bank $02 ; $6ef8
	ld a, $ff ; $6efe
	ld [$d003], a ; $6f00
	ret ; $6f03
RedrawMinigameLevelSelect2:
	wram_bank $03 ; $6f04
	ld b, $00 ; $6f0a
	ld c, $00 ; $6f0c
.loop:
	call SetSelectPanelAttrRect ; $6f0e
	ld a, b ; $6f11
	inc a ; $6f12
	ld b, a ; $6f13
	cp $02 ; $6f14
	jr nz, .loop ; $6f16
	ld c, $02 ; $6f18
	call GetMenuCursorIndex ; $6f1a
	ld b, a ; $6f1d
	ld c, $01 ; $6f1e
	call SetSelectPanelAttrRect ; $6f20
	ld c, $03 ; $6f23
	call GetMenuCursorIndex ; $6f25
	call LoadMinigameLevelSelectPalette ; $6f28
	call ClearMinigameLevelDescriptionRow ; $6f2b
	call DrawMinigameLevelDescription ; $6f2e
	call FlushLevelSelectTextRows ; $6f31
	ret ; $6f34
SetSelectPanelAttrRect:
	push af ; $6f35
	push bc ; $6f36
	push de ; $6f37
	push hl ; $6f38
	ld a, c ; $6f39
	or a ; $6f3a
	jr z, .inactiveAttr ; $6f3b
	ld h, $0c ; $6f3d
	jr .lookup ; $6f3f
.inactiveAttr:
	ld h, $0d ; $6f41
.lookup:
	push hl ; $6f43
	ld hl, SelectPanelAttrRectTable ; $6f44
	ld a, b ; $6f47
	add a ; $6f48
	add l ; $6f49
	ld l, a ; $6f4a
	jr nc, .readAddr ; $6f4b
	inc h ; $6f4d
.readAddr:
	ld a, [hl+] ; $6f4e
	ld d, [hl] ; $6f4f
	ld e, a ; $6f50
	pop hl ; $6f51
	ld b, $05 ; $6f52
	ld c, $03 ; $6f54
	farcall FillTilemapRect ; $6f56
	pop hl ; $6f59
	pop de ; $6f5a
	pop bc ; $6f5b
	pop af ; $6f5c
	ret ; $6f5d
SelectPanelAttrRectTable:
	; $6f5e, 4 bytes (bytes:4)
	db $e3, $d4, $ec, $d4 ; 0x00
DrawMinigameLevelSelect2Cursor:
	farcall TickMenuBgScroll ; $6f62
	ld c, $03 ; $6f65
	call GetMenuCursorIndex ; $6f67
	push af ; $6f6a
	ld hl, MinigameLevelSelect2CursorTable1 ; $6f6b
	add l ; $6f6e
	ld l, a ; $6f6f
	jr nc, .read ; $6f70
	inc h ; $6f72
.read:
	ld c, [hl] ; $6f73
	pop af ; $6f74
	ld hl, MinigameLevelSelect2CursorTable0 ; $6f75
	add a ; $6f78
	add l ; $6f79
	ld l, a ; $6f7a
	jr nc, .readB ; $6f7b
	inc h ; $6f7d
.readB:
	ld a, [hl+] ; $6f7e
	ld d, [hl] ; $6f7f
	ld e, a ; $6f80
	farcall ApplySpriteBobOffset ; $6f81
	ld b, $08 ; $6f84
	ld hl, SpriteTemplate_1b_6f9f ; $6f86
	push de ; $6f89
	call QueueSpriteTemplate ; $6f8a
	pop de ; $6f8d
	ld hl, $17f8 ; $6f8e
	add hl, de ; $6f91
	ld d, h ; $6f92
	ld e, l ; $6f93
	ld hl, SpriteTemplate_1b_6fc0 ; $6f94
	ld b, $08 ; $6f97
	ld c, $70 ; $6f99
	call QueueSpriteTemplate ; $6f9b
	ret ; $6f9e
SpriteTemplate_1b_6f9f:
	; $6f9f, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
SpriteTemplate_1b_6fc0:
	; $6fc0, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
MinigameLevelSelect2CursorTable0:
	; $6fc9, 6 bytes (bytes:6)
	db $50, $0c, $50, $54, $50, $5c ; 0x00
MinigameLevelSelect2CursorTable1:
	; $6fcf, 3 bytes (bytes:3)
	db $00, $10, $20 ; 0x00
RunMinigameLevelSelect3:
	call ResumeBGM ; $6fd2
	sound $08 ; $6fd5
	ld hl, rIE ; $6fd7
	res 2, [hl] ; $6fda
	wram_bank $03 ; $6fdc
	ld a, [wMenuSlideDirection] ; $6fe2
	ld b, a ; $6fe5
	farcall N64RecordTypeSlideIn ; $6fe6
	farcall InitMenuBgScroll ; $6fe9
	ld b, $01 ; $6fec
	ld c, $01 ; $6fee
	farcall LoadMenuSpritePalettePair ; $6ff0
	wram_bank $02 ; $6ff3
	ld a, [$d001] ; $6ff9
	ld c, a ; $6ffc
	ld b, $03 ; $6ffd
	call SetMenuCursorFromIndex ; $6fff
	wram_bank $03 ; $7002
	ld a, $01 ; $7008
	ld hl, DrawMinigameLevelSelect3Cursor ; $700a
	call RegisterFrameTask ; $700d
	call RedrawMinigameLevelSelect3 ; $7010
	wram_bank $03 ; $7013
.loop:
	call AdvanceFrame ; $7019
	ldh a, [hInputPressed] ; $701c
	ld [wMenuInputPressed], a ; $701e
	call GetMinigameLevelColumnCount ; $7021
	ld c, $01 ; $7024
	call MoveMenuCursorGrid ; $7026
	or a ; $7029
	jr z, .checkMenuInputPressed ; $702a
	sound $5e ; $702c
	call RedrawMinigameLevelSelect3 ; $702e
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $7031
	bit PADB_A, a ; $7034
	jr nz, .playSfx ; $7036
	bit 1, a ; $7038
	jr nz, .playSfx2 ; $703a
	jr .loop ; $703c
.playSfx:
	sound $5f ; $703e
	call ClearFrameTasks ; $7040
	ld hl, rIE ; $7043
	set 2, [hl] ; $7046
	wram_bank $03 ; $7048
	ld b, $01 ; $704e
	farcall N64RecordTypeSlideOut ; $7050
	ld a, $01 ; $7053
	ld [wMenuSlideDirection], a ; $7055
	wram_bank $02 ; $7058
	ld c, $03 ; $705e
	call GetMenuCursorIndex ; $7060
	ld [$d003], a ; $7063
	ret ; $7066
.playSfx2:
	sound $62 ; $7067
	call ClearFrameTasks ; $7069
	ld hl, rIE ; $706c
	set 2, [hl] ; $706f
	wram_bank $03 ; $7071
	ld b, $00 ; $7077
	farcall N64RecordTypeSlideOut ; $7079
	ld a, $00 ; $707c
	ld [wMenuSlideDirection], a ; $707e
	wram_bank $02 ; $7081
	ld a, $ff ; $7087
	ld [$d003], a ; $7089
	ret ; $708c
RedrawMinigameLevelSelect3:
	wram_bank $03 ; $708d
	ld b, $00 ; $7093
	ld c, $00 ; $7095
.loop:
	call SetSelectPanelAttrRect3 ; $7097
	ld a, b ; $709a
	inc a ; $709b
	ld b, a ; $709c
	cp $03 ; $709d
	jr nz, .loop ; $709f
	ld c, $02 ; $70a1
	call GetMenuCursorIndex ; $70a3
	ld b, a ; $70a6
	ld c, $01 ; $70a7
	call SetSelectPanelAttrRect3 ; $70a9
	ld c, $03 ; $70ac
	call GetMenuCursorIndex ; $70ae
	call LoadMinigameLevelSelectPalette ; $70b1
	call ClearMinigameLevelDescriptionRow ; $70b4
	call DrawMinigameLevelDescription ; $70b7
	call FlushLevelSelectTextRows ; $70ba
	ret ; $70bd
SetSelectPanelAttrRect3:
	push af ; $70be
	push bc ; $70bf
	push de ; $70c0
	push hl ; $70c1
	ld a, c ; $70c2
	or a ; $70c3
	jr z, .zero ; $70c4
	ld h, $0c ; $70c6
	jr .step2 ; $70c8
.zero:
	ld h, $0d ; $70ca
.step2:
	push hl ; $70cc
	ld hl, SelectPanelAttrRect3Table ; $70cd
	ld a, b ; $70d0
	add a ; $70d1
	add l ; $70d2
	ld l, a ; $70d3
	jr nc, .read ; $70d4
	inc h ; $70d6
.read:
	ld a, [hl+] ; $70d7
	ld d, [hl] ; $70d8
	ld e, a ; $70d9
	pop hl ; $70da
	ld b, $05 ; $70db
	ld c, $03 ; $70dd
	farcall FillTilemapRect ; $70df
	pop hl ; $70e2
	pop de ; $70e3
	pop bc ; $70e4
	pop af ; $70e5
	ret ; $70e6
SelectPanelAttrRect3Table:
	; $70e7, 6 bytes (bytes:6)
	db $e1, $d4, $e7, $d4, $ed, $d4 ; 0x00
DrawMinigameLevelSelect3Cursor:
	farcall TickMenuBgScroll ; $70ed
	ld c, $03 ; $70f0
	call GetMenuCursorIndex ; $70f2
	push af ; $70f5
	ld hl, MinigameLevelSelect3CursorTable1 ; $70f6
	add l ; $70f9
	ld l, a ; $70fa
	jr nc, .read ; $70fb
	inc h ; $70fd
.read:
	ld c, [hl] ; $70fe
	pop af ; $70ff
	ld hl, MinigameLevelSelect3CursorTable0 ; $7100
	add a ; $7103
	add l ; $7104
	ld l, a ; $7105
	jr nc, .readB ; $7106
	inc h ; $7108
.readB:
	ld a, [hl+] ; $7109
	ld d, [hl] ; $710a
	ld e, a ; $710b
	farcall ApplySpriteBobOffset ; $710c
	ld b, $08 ; $710f
	ld hl, SpriteTemplate_1b_712a ; $7111
	push de ; $7114
	call QueueSpriteTemplate ; $7115
	pop de ; $7118
	ld hl, $17f8 ; $7119
	add hl, de ; $711c
	ld d, h ; $711d
	ld e, l ; $711e
	ld hl, SpriteTemplate_1b_714b ; $711f
	ld b, $08 ; $7122
	ld c, $70 ; $7124
	call QueueSpriteTemplate ; $7126
	ret ; $7129
SpriteTemplate_1b_712a:
	; $712a, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
SpriteTemplate_1b_714b:
	; $714b, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
MinigameLevelSelect3CursorTable0:
	; $7154, 6 bytes (bytes:6)
	db $50, $fc, $50, $2c, $50, $5c ; 0x00
MinigameLevelSelect3CursorTable1:
	; $715a, 3 bytes (bytes:3)
	db $00, $10, $20 ; 0x00
RunSavedDataTypeSelect:
	sound $03 ; $715d
	ld hl, rIE ; $715f
	res 2, [hl] ; $7162
	call LoadSavedDataTypeSelectGfx ; $7164
	wram_bank $03 ; $7167
	ld a, [wMenuSlideDirection] ; $716d
	ld b, a ; $7170
	farcall OpenChoiceTabPanel ; $7171
	farcall InitMenuBgScroll ; $7174
	ld b, $01 ; $7177
	ld c, $01 ; $7179
	farcall LoadMenuSpritePalettePair ; $717b
	ld a, [wSavedDataTypeTabIndex] ; $717e
	ld c, a ; $7181
	ld b, $02 ; $7182
	call SetMenuCursorFromIndex ; $7184
	ld a, $01 ; $7187
	ld hl, TickMenuBgScrollTask_1b ; $7189
	call RegisterFrameTask ; $718c
	ld a, $01 ; $718f
	ld hl, DrawSavedDataTypeSelectCursor ; $7191
	call RegisterFrameTask ; $7194
	call RedrawSavedDataTypeSelect ; $7197
	wram_bank $03 ; $719a
.loop:
	call AdvanceFrame ; $71a0
	ldh a, [hInputPressed] ; $71a3
	ld [wMenuInputPressed], a ; $71a5
	ld b, $02 ; $71a8
	ld c, $01 ; $71aa
	call MoveMenuCursorGrid ; $71ac
	or a ; $71af
	jr z, .checkMenuInputPressed ; $71b0
	sound $5e ; $71b2
	call RedrawSavedDataTypeSelect ; $71b4
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $71b7
	bit PADB_A, a ; $71ba
	jr nz, .playSfx ; $71bc
	bit 1, a ; $71be
	jr nz, .playSfx2 ; $71c0
	jr .loop ; $71c2
.playSfx:
	sound $5f ; $71c4
	call ClearFrameTasks ; $71c6
	ld hl, rIE ; $71c9
	set 2, [hl] ; $71cc
	wram_bank $03 ; $71ce
	ld b, $01 ; $71d4
	farcall CloseChoiceTabPanel ; $71d6
	ld a, $01 ; $71d9
	ld [wMenuSlideDirection], a ; $71db
	ld c, $02 ; $71de
	call GetMenuCursorIndex ; $71e0
	ld [wSavedDataTypeTabIndex], a ; $71e3
	ret ; $71e6
.playSfx2:
	sound $62 ; $71e7
	call ClearFrameTasks ; $71e9
	ld hl, rIE ; $71ec
	set 2, [hl] ; $71ef
	wram_bank $03 ; $71f1
	ld b, $00 ; $71f7
	farcall CloseChoiceTabPanel ; $71f9
	ld a, $00 ; $71fc
	ld [wMenuSlideDirection], a ; $71fe
	wram_bank $02 ; $7201
	ld a, $ff ; $7207
	ret ; $7209
LoadSavedDataTypeSelectGfx:
	ldh a, [hWramBank] ; $720a
	push af ; $720c
	wram_bank $01 ; $720d
	ld c, $00 ; $7213
.loop:
	ld a, c ; $7215
	add a ; $7216
	ld hl, SavedDataTypeSelectGfx0 ; $7217
	add l ; $721a
	ld l, a ; $721b
	jr nc, .read ; $721c
	inc h ; $721e
.read:
	ld a, [hl+] ; $721f
	ld h, [hl] ; $7220
	ld l, a ; $7221
	push af ; $7222
	push bc ; $7223
	push de ; $7224
	push hl ; $7225
	ld de, $d000 ; $7226
	call DecompressDataFromBank ; $7229
	pop hl ; $722c
	pop de ; $722d
	pop bc ; $722e
	pop af ; $722f
	ld hl, SavedDataTypeSelectGfx1 ; $7230
	ld a, c ; $7233
	add a ; $7234
	add l ; $7235
	ld l, a ; $7236
	jr nc, .readB ; $7237
	inc h ; $7239
.readB:
	ld a, [hl+] ; $723a
	ld d, [hl] ; $723b
	ld e, a ; $723c
	ld hl, $d000 ; $723d
	push af ; $7240
	push bc ; $7241
	push de ; $7242
	push hl ; $7243
	ld bc, $0010 ; $7244
	call QueueVRAMCopy ; $7247
	pop hl ; $724a
	pop de ; $724b
	pop bc ; $724c
	pop af ; $724d
	ld a, c ; $724e
	inc a ; $724f
	ld c, a ; $7250
	call AdvanceFrame ; $7251
	ld a, c ; $7254
	cp $02 ; $7255
	jr nz, .loop ; $7257
	ld b, $1d ; $7259
	ld c, $10 ; $725b
	ld de, $8000 + VRAM_BANK1 ; $725d
	farcall LoadCompressedTileBlock ; $7260
	call AdvanceFrame ; $7263
	ld b, $1e ; $7266
	ld c, $12 ; $7268
	ld de, $8100 + VRAM_BANK1 ; $726a
	farcall LoadCompressedTileBlock ; $726d
	call AdvanceFrame ; $7270
	ld b, $1b ; $7273
	ld c, $04 ; $7275
	ld de, $8700 + VRAM_BANK1 ; $7277
	farcall LoadCompressedTileBlock ; $727a
	call AdvanceFrame ; $727d
	ld b, $78 ; $7280
	ld c, $14 ; $7282
	ld de, $8000 ; $7284
	farcall LoadCompressedTileBlock ; $7287
	call AdvanceFrame ; $728a
	ld b, $08 ; $728d
	ld c, $10 ; $728f
	farcall LoadIndexedPalette ; $7291
	pop af ; $7294
	wram_bank ; $7295
	ret ; $7299
SavedDataTypeSelectGfx0:
	; $729a, 4 bytes (bytes:4)
	db $7a, $3c, $58, $3a ; 0x00
SavedDataTypeSelectGfx1:
	; $729e, 6 bytes (bytes:6)
	db $00, $a8, $00, $a9, $00, $aa ; 0x00
TickMenuBgScrollTask_1b:
	farcall TickMenuBgScroll ; $72a4
	ret ; $72a7
DrawSavedDataTypeSelectCursor:
	ld c, $02 ; $72a8
	call GetMenuCursorIndex ; $72aa
	or a ; $72ad
	jr nz, .drawSavedDataCursorOption1 ; $72ae
	call DrawSavedDataCursorOption0 ; $72b0
	ret ; $72b3
.drawSavedDataCursorOption1:
	call DrawSavedDataCursorOption1 ; $72b4
	ret ; $72b7
DrawSavedDataCursorOption0:
	ld c, $00 ; $72b8
	ld b, $08 ; $72ba
	ld de, $0c50 ; $72bc
	farcall ApplySpriteBobOffset ; $72bf
	ld hl, SpriteTemplate_1b_72fa ; $72c2
	call QueueSpriteTemplate ; $72c5
	ld b, $08 ; $72c8
	ld c, $70 ; $72ca
	ld de, $2448 ; $72cc
	farcall ApplySpriteBobOffset ; $72cf
	ld hl, SpriteTemplate_1b_7340 ; $72d2
	call QueueSpriteTemplate ; $72d5
	ret ; $72d8
DrawSavedDataCursorOption1:
	ld c, $10 ; $72d9
	ld b, $08 ; $72db
	ld de, $5050 ; $72dd
	farcall ApplySpriteBobOffset ; $72e0
	ld hl, SpriteTemplate_1b_731b ; $72e3
	call QueueSpriteTemplate ; $72e6
	ld b, $08 ; $72e9
	ld c, $70 ; $72eb
	ld de, $6c48 ; $72ed
	farcall ApplySpriteBobOffset ; $72f0
	ld hl, SpriteTemplate_1b_7340 ; $72f3
	call QueueSpriteTemplate ; $72f6
	ret ; $72f9
SpriteTemplate_1b_72fa:
	; $72fa, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
SpriteTemplate_1b_731b:
	; $731b, 37 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite $10, $48, $10, $00
	oam_sprite_end
SpriteTemplate_1b_7340:
	; $7340, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
Data_1b_7349:
	; $7349, 9 bytes (bytes:9)
	db $50, $0c, $50, $54, $50, $5c, $00, $10, $20 ; 0x00
RedrawSavedDataTypeSelect:
	wram_bank $03 ; $7352
	ld b, $00 ; $7358
	ld c, $00 ; $735a
.loop:
	call SetSelectPanelAttrRect ; $735c
	ld a, b ; $735f
	inc a ; $7360
	ld b, a ; $7361
	cp $02 ; $7362
	jr nz, .loop ; $7364
	ld c, $02 ; $7366
	call GetMenuCursorIndex ; $7368
	ld b, a ; $736b
	ld c, $01 ; $736c
	call SetSelectPanelAttrRect ; $736e
	ld c, $03 ; $7371
	call GetMenuCursorIndex ; $7373
	call LoadSavedDataTypePalette ; $7376
	call ClearMinigameLevelDescriptionRow ; $7379
	call DrawSavedDataTypeDescription ; $737c
	call FlushLevelSelectTextRows ; $737f
	ret ; $7382
DrawSavedDataTypeDescription:
	ldh a, [hWramBank] ; $7383
	push af ; $7385
	wram_bank $03 ; $7386
	ld c, $03 ; $738c
	call GetMenuCursorIndex ; $738e
	ld b, a ; $7391
	ld hl, SavedDataTypeDescriptionTable ; $7392
	add a ; $7395
	add l ; $7396
	ld l, a ; $7397
	jr nc, .read ; $7398
	inc h ; $739a
.read:
	ld a, [hl+] ; $739b
	ld d, [hl] ; $739c
	ld e, a ; $739d
	ld a, b ; $739e
	ld hl, $00ca ; $739f
	add l ; $73a2
	ld l, a ; $73a3
	jr nc, .renderTextToBuffer64 ; $73a4
	inc h ; $73a6
.renderTextToBuffer64:
	ld c, $20 ; $73a7
	farcall RenderTextToBuffer64 ; $73a9
	pop af ; $73ac
	wram_bank ; $73ad
	ret ; $73b1
SavedDataTypeDescriptionTable:
	; $73b2, 4 bytes (bytes:4)
	db $01, $d2, $01, $d2 ; 0x00
LoadSavedDataTypePalette:
	ld hl, SavedDataTypePalettePtrs ; $73b6
	add a ; $73b9
	add l ; $73ba
	ld l, a ; $73bb
	jr nc, .read ; $73bc
	inc h ; $73be
.read:
	ld a, [hl+] ; $73bf
	ld h, [hl] ; $73c0
	ld l, a ; $73c1
	ld de, $0401 ; $73c2
	call LoadPaletteShadow ; $73c5
	ret ; $73c8
SavedDataTypePalettePtrs:
	; $73c9, 4 bytes (records:2)
	dw SavedDataTypePalette0 ; record 0
	dw SavedDataTypePalette1 ; record 1
SavedDataTypePalette0:
	; $73cd, 8 bytes (bytes:8)
	db $34, $53, $ff, $6b, $40, $02, $00, $00 ; 0x00
SavedDataTypePalette1:
	; $73d5, 8 bytes (bytes:8)
	db $bf, $02, $ff, $6b, $1b, $18, $00, $00 ; 0x00
ShowMinigameDataScreen:
	sound $04 ; $73dd
	call DisableLCDSafely ; $73df
	call BuildMinigameDataScreen ; $73e2
	ld a, $01 ; $73e5
	ld [wAnimatedTileSet], a ; $73e7
	ld a, $01 ; $73ea
	ld hl, UpdateAnimatedTilesTask ; $73ec
	call RegisterFrameTask ; $73ef
	ld a, $01 ; $73f2
	ld hl, DrawMinigameDataScrollArrows ; $73f4
	call RegisterFrameTask ; $73f7
	ld a, $01 ; $73fa
	ld hl, DrawMinigameHighScoreNumbers ; $73fc
	call RegisterFrameTask ; $73ff
	call EnableLCD ; $7402
	script_fade_in $10 ; $7405
	call WaitFadeEnd ; $740a
	wram_bank $03 ; $740d
.loop:
	ldh a, [hInputPressed] ; $7413
	ld [wMenuInputPressed], a ; $7415
	call ScrollMinigameDataList ; $7418
	call AdvanceFrame ; $741b
	ld a, [wMenuInputPressed] ; $741e
	bit PADB_A, a ; $7421
	jr nz, .playSfx ; $7423
	bit 1, a ; $7425
	jr nz, .playSfx2 ; $7427
	jr .loop ; $7429
.playSfx:
	sound $5f ; $742b
	ld c, $10 ; $742d
	call BeginFadeOut ; $742f
	call WaitFadeEnd ; $7432
	call ClearFrameTasks ; $7435
	ret ; $7438
.playSfx2:
	sound $62 ; $7439
	ld c, $10 ; $743b
	call BeginFadeOut ; $743d
	call WaitFadeEnd ; $7440
	call ClearFrameTasks ; $7443
	ld a, $ff ; $7446
	ret ; $7448
BuildMinigameDataScreen:
	ld c, $2b ; $7449
	farcall LoadScreenAssetRecord ; $744b
	xor a ; $744e
	ld [wMenuCursorX], a ; $744f
	ld [wMenuCursorY], a ; $7452
	wram_bank $03 ; $7455
	call LoadMinigameDataState ; $745b
	ld de, $8ac0 + VRAM_BANK1 ; $745e
	farcall LoadChartWindowTiles ; $7461
	ld de, $8000 + VRAM_BANK1 ; $7464
	farcall LoadMenuArrowSpriteTiles ; $7467
	ld b, $08 ; $746a
	ld c, $0f ; $746c
	farcall LoadIndexedPalette ; $746e
	ld de, $8100 + VRAM_BANK1 ; $7471
	ld b, $09 ; $7474
	ld c, $00 ; $7476
	farcall InitNumberSpriteGfx ; $7478
	ld a, $09 ; $747b
	ld [wDigitSpriteAttr], a ; $747d
	ld a, $10 ; $7480
	ld [wDigitSpriteTileBase], a ; $7482
	call CheckMinigameDataScrollable ; $7485
	or a ; $7488
	jr nz, .drawMinigameDataMugshotsScrolled ; $7489
	call DrawMinigameDataMugshotsStatic ; $748b
	jr .drawMinigameDataMarks ; $748e
.drawMinigameDataMugshotsScrolled:
	call DrawMinigameDataMugshotsScrolled ; $7490
.drawMinigameDataMarks:
	call DrawMinigameDataMarks ; $7493
	call DrawStarLegendMark ; $7496
	farcall QueueWram3MapToVRAM ; $7499
	ret ; $749c
ScrollMinigameDataList:
	call CheckMinigameDataScrollable ; $749d
	or a ; $74a0
	ret z ; $74a1
	ld a, [wMenuInputPressed] ; $74a2
	bit PADB_DOWN, a ; $74a5
	jr nz, .checkMenuCursorY ; $74a7
	bit 6, a ; $74a9
	jr nz, .checkMenuCursorY2 ; $74ab
	ret ; $74ad
.checkMenuCursorY:
	ld a, [wMenuCursorY] ; $74ae
	inc a ; $74b1
	cp $05 ; $74b2
	ret z ; $74b4
	ld [wMenuCursorY], a ; $74b5
	jr .playSfx ; $74b8
.checkMenuCursorY2:
	ld a, [wMenuCursorY] ; $74ba
	dec a ; $74bd
	cp $ff ; $74be
	ret z ; $74c0
	ld [wMenuCursorY], a ; $74c1
.playSfx:
	sound $5e ; $74c4
	call RedrawMinigameDataRows ; $74c6
	ret ; $74c9
LoadMinigameDataState:
	farcall BuildMarioCastUnlockMask ; $74ca
	call LoadMinigameClearFlags ; $74cd
	call LoadMinigameStarFlags ; $74d0
	call LoadMinigameHighScores ; $74d3
	call CheckMinigameDataScrollable ; $74d6
	jr nz, .done ; $74d9
	call CompactMinigameDataRows ; $74db
.done:
	ret ; $74de
LoadMinigameClearFlags:
	ld hl, $d809 ; $74df
	ld bc, $0009 ; $74e2
	call ClearBytes ; $74e5
	ld c, $00 ; $74e8
	ld hl, $d809 ; $74ea
.loop:
	ld a, c ; $74ed
	add a ; $74ee
	push hl ; $74ef
	ld hl, MinigameClearFlagsTable ; $74f0
	add l ; $74f3
	ld l, a ; $74f4
	jr nc, .read ; $74f5
	inc h ; $74f7
.read:
	ld a, [hl+] ; $74f8
	ld d, [hl] ; $74f9
	ld e, a ; $74fa
	pop hl ; $74fb
	farcall TestSaveFlag ; $74fc
	jr z, .next ; $74ff
	ld a, $01 ; $7501
	ld [hl], a ; $7503
.next:
	inc hl ; $7504
	ld a, c ; $7505
	inc a ; $7506
	ld c, a ; $7507
	cp $09 ; $7508
	jr nz, .loop ; $750a
	ret ; $750c
MinigameClearFlagsTable:
	; $750d, 18 bytes (records:2)
	dw $0280 ; record 0
	dw $02e0 ; record 1
	dw $0340 ; record 2
	dw $03a0 ; record 3
	dw $0500 ; record 4
	dw $0560 ; record 5
	dw $05c0 ; record 6
	dw $0620 ; record 7
	dw $0680 ; record 8
LoadMinigameStarFlags:
	ld hl, $d812 ; $751f
	ld bc, $0009 ; $7522
	call ClearBytes ; $7525
	ld c, $00 ; $7528
	ld hl, $d812 ; $752a
.loop:
	ld a, c ; $752d
	add a ; $752e
	push hl ; $752f
	ld hl, MinigameStarFlagsTable ; $7530
	add l ; $7533
	ld l, a ; $7534
	jr nc, .read ; $7535
	inc h ; $7537
.read:
	ld a, [hl+] ; $7538
	ld d, [hl] ; $7539
	ld e, a ; $753a
	pop hl ; $753b
	farcall TestSaveFlag ; $753c
	jr z, .next ; $753f
	ld a, $01 ; $7541
	ld [hl], a ; $7543
.next:
	inc hl ; $7544
	ld a, c ; $7545
	inc a ; $7546
	ld c, a ; $7547
	cp $09 ; $7548
	jr nz, .loop ; $754a
	ret ; $754c
MinigameStarFlagsTable:
	; $754d, 19 bytes (records:2)
	dw $02a0 ; record 0
	dw $0300 ; record 1
	dw $0360 ; record 2
	dw $03c0 ; record 3
	dw $0520 ; record 4
	dw $0580 ; record 5
	dw $05e0 ; record 6
	dw $0640 ; record 7
	dw $06a0 ; record 8
	db $c9
LoadMinigameHighScores:
	ldh a, [hWramBank] ; $7560
	push af ; $7562
	ld hl, $d81b ; $7563
	ld bc, $0012 ; $7566
	call ClearBytes ; $7569
	ld de, SAVEFLAG_CLEARED_TWO_ON_ONE_3 ; $756c
	farcall TestSaveFlag ; $756f
	jr z, .readMinigameRecord ; $7572
	ld a, $01 ; $7574
	ld hl, $d82b ; $7576
	ld [hl+], a ; $7579
	ld [hl], a ; $757a
.readMinigameRecord:
	ld c, $00 ; $757b
.loop:
	ld a, c ; $757d
	inc a ; $757e
	inc a ; $757f
	farcall ReadMinigameRecord ; $7580
	wram_bank $07 ; $7583
	ld hl, wMinigameRecordValue ; $7589
	ld a, [hl+] ; $758c
	ld d, [hl] ; $758d
	ld e, a ; $758e
	wram_bank $03 ; $758f
	ld hl, $d81b ; $7595
	ld a, c ; $7598
	add a ; $7599
	add l ; $759a
	ld l, a ; $759b
	jr nc, .gotPtr ; $759c
	inc h ; $759e
.gotPtr:
	ld a, e ; $759f
	ld [hl+], a ; $75a0
	ld [hl], d ; $75a1
	inc c ; $75a2
	ld a, c ; $75a3
	cp $08 ; $75a4
	jr nz, .loop ; $75a6
	pop af ; $75a8
	wram_bank ; $75a9
	ret ; $75ad
RedrawMinigameDataRows:
	call DrawMinigameDataMugshotsScrolled ; $75ae
	call DrawMinigameDataMarks ; $75b1
	call FlushMinigameDataRowsToVram ; $75b4
	ret ; $75b7
FlushMinigameDataRowsToVram:
	ld hl, wShadowTilemap + 6 * TILEMAP_WIDTH ; $75b8
	ld de, $98c0 ; $75bb
	ld c, $08 ; $75be
	call QueueVRAMCopy ; $75c0
	ld hl, wShadowAttrmap + 6 * TILEMAP_WIDTH ; $75c3
	ld de, $98c0 + VRAM_BANK1 ; $75c6
	ld c, $08 ; $75c9
	call QueueVRAMCopy ; $75cb
	call AdvanceFrame ; $75ce
	ld hl, wShadowTilemap + 10 * TILEMAP_WIDTH ; $75d1
	ld de, $9940 ; $75d4
	ld c, $08 ; $75d7
	call QueueVRAMCopy ; $75d9
	ld hl, wShadowAttrmap + 10 * TILEMAP_WIDTH ; $75dc
	ld de, $9940 + VRAM_BANK1 ; $75df
	ld c, $08 ; $75e2
	call QueueVRAMCopy ; $75e4
	call AdvanceFrame ; $75e7
	ld hl, wShadowTilemap + 14 * TILEMAP_WIDTH ; $75ea
	ld de, $99c0 ; $75ed
	ld c, $04 ; $75f0
	call QueueVRAMCopy ; $75f2
	ld hl, wShadowAttrmap + 14 * TILEMAP_WIDTH ; $75f5
	ld de, $99c0 + VRAM_BANK1 ; $75f8
	ld c, $04 ; $75fb
	call QueueVRAMCopy ; $75fd
	call AdvanceFrame ; $7600
	ret ; $7603
DrawMinigameDataMugshotsScrolled:
	ldh a, [hWramBank] ; $7604
	push af ; $7606
	wram_bank $03 ; $7607
	ld a, [wMenuCursorY] ; $760d
	ld c, a ; $7610
	ld b, $00 ; $7611
.loop:
	push bc ; $7613
	farcall GetUnlockedMarioCastCharAtGridSlot ; $7614
	pop bc ; $7617
	cp $15 ; $7618
	jr nz, .ne15 ; $761a
	push bc ; $761c
	ld c, $09 ; $761d
	jr .drawMinigameDataMugshot ; $761f
.ne15:
	push bc ; $7621
.drawMinigameDataMugshot:
	call DrawMinigameDataMugshot ; $7622
	pop bc ; $7625
	inc c ; $7626
	ld a, b ; $7627
	inc a ; $7628
	ld b, a ; $7629
	cp $05 ; $762a
	jr nz, .loop ; $762c
	pop af ; $762e
	wram_bank ; $762f
	ret ; $7633
DrawMinigameDataMugshotsStatic:
	ldh a, [hWramBank] ; $7634
	push af ; $7636
	wram_bank $03 ; $7637
	ld c, $00 ; $763d
	ld b, $00 ; $763f
.loop:
	push bc ; $7641
	farcall GetUnlockedMarioCastCharAtGridSlot ; $7642
	pop bc ; $7645
	cp $15 ; $7646
	jr nz, .ne15 ; $7648
	push bc ; $764a
	ld c, $09 ; $764b
	jr .drawMinigameDataMugshot ; $764d
.ne15:
	push bc ; $764f
.drawMinigameDataMugshot:
	call DrawMinigameDataMugshot ; $7650
	pop bc ; $7653
	inc c ; $7654
	ld a, b ; $7655
	inc a ; $7656
	ld b, a ; $7657
	cp $04 ; $7658
	jr nz, .loop ; $765a
	ld c, $05 ; $765c
	ld b, $04 ; $765e
	call DrawMinigameDataMugshot ; $7660
	pop af ; $7663
	wram_bank ; $7664
	ret ; $7668
DrawMinigameDataMugshot:
	push af ; $7669
	push bc ; $766a
	push de ; $766b
	push hl ; $766c
	ldh a, [hWramBank] ; $766d
	push af ; $766f
	wram_bank $03 ; $7670
	call MapMinigameRowToMugshotSlot ; $7676
	call GetMinigameRowTilemapDest ; $7679
	ld b, c ; $767c
	farcall DrawChartCharIcon ; $767d
	pop af ; $7680
	wram_bank ; $7681
	pop hl ; $7685
	pop de ; $7686
	pop bc ; $7687
	pop af ; $7688
	ret ; $7689
MapMinigameRowToMugshotSlot:
	push hl ; $768a
	ld hl, MapMinigameRowToMugshotSlotTable ; $768b
	ld a, c ; $768e
	add l ; $768f
	ld l, a ; $7690
	jr nc, .read ; $7691
	inc h ; $7693
.read:
	ld c, [hl] ; $7694
	pop hl ; $7695
	ret ; $7696
MapMinigameRowToMugshotSlotTable:
	; $7697, 10 bytes (bytes:10)
	db $00, $01, $02, $03, $04, $05, $07, $08, $0c, $10 ; 0x00
GetMinigameRowTilemapDest:
	ld hl, MinigameRowTilemapDestTable ; $76a1
	ld a, b ; $76a4
	add a ; $76a5
	add l ; $76a6
	ld l, a ; $76a7
	jr nc, .read ; $76a8
	inc h ; $76aa
.read:
	ld a, [hl+] ; $76ab
	ld h, [hl] ; $76ac
	ld l, a ; $76ad
	ret ; $76ae
MinigameRowTilemapDestTable:
	; $76af, 10 bytes (bytes:10)
	db $c3, $d0, $03, $d1, $43, $d1, $83, $d1, $c3, $d1 ; 0x00
DrawMinigameDataScrollArrows:
	call CheckMinigameDataScrollable ; $76b9
	or a ; $76bc
	ret z ; $76bd
	ld a, [wMenuCursorY] ; $76be
	or a ; $76c1
	jr z, .checkMenuCursorY ; $76c2
	ld de, $1128 ; $76c4
	ld c, $01 ; $76c7
	call ApplyArrowBobOffset ; $76c9
	ld b, $08 ; $76cc
	ld c, $00 ; $76ce
	ld h, $02 ; $76d0
	farcall QueueStackedSpritePair ; $76d2
.checkMenuCursorY:
	ld a, [wMenuCursorY] ; $76d5
	cp $04 ; $76d8
	jr z, .done ; $76da
	ld de, $1184 ; $76dc
	ld c, $00 ; $76df
	call ApplyArrowBobOffset ; $76e1
	ld b, $08 ; $76e4
	ld c, $00 ; $76e6
	ld h, $03 ; $76e8
	farcall QueueStackedSpritePair ; $76ea
.done:
	ret ; $76ed
DrawMinigameDataMarks:
	call ClearMinigameMarkColumns ; $76ee
	call DrawMinigameClearMarks ; $76f1
	call DrawMinigameStarMarks ; $76f4
	call DrawMinigameSpecialMark ; $76f7
	ret ; $76fa
DrawMinigameClearMarks:
	ld hl, $d809 ; $76fb
	ld a, [wMenuCursorY] ; $76fe
	add l ; $7701
	ld l, a ; $7702
	jr nc, .gotPtr ; $7703
	inc h ; $7705
.gotPtr:
	ld c, $00 ; $7706
.loop:
	ld b, $00 ; $7708
	ld a, [hl+] ; $770a
	or a ; $770b
	jr z, .zero ; $770c
	call DrawMinigameMarkTile ; $770e
.zero:
	ld a, c ; $7711
	inc a ; $7712
	ld c, a ; $7713
	cp $05 ; $7714
	jr nz, .loop ; $7716
	ret ; $7718
DrawMinigameStarMarks:
	ld hl, $d812 ; $7719
	ld a, [wMenuCursorY] ; $771c
	add l ; $771f
	ld l, a ; $7720
	jr nc, .gotPtr ; $7721
	inc h ; $7723
.gotPtr:
	ld c, $00 ; $7724
.loop:
	ld b, $01 ; $7726
	ld a, [hl+] ; $7728
	or a ; $7729
	jr z, .zero ; $772a
	call DrawMinigameMarkTile ; $772c
.zero:
	ld a, c ; $772f
	inc a ; $7730
	ld c, a ; $7731
	cp $05 ; $7732
	jr nz, .loop ; $7734
	ret ; $7736
DrawMinigameSpecialMark:
	ld a, [wMenuCursorY] ; $7737
	cp $04 ; $773a
	ret nz ; $773c
	ld hl, $d82b ; $773d
	ld a, [hl+] ; $7740
	ld b, [hl] ; $7741
	or b ; $7742
	ret z ; $7743
	ld b, $02 ; $7744
	ld c, $04 ; $7746
	call DrawMinigameMarkTile ; $7748
	ret ; $774b
DrawMinigameMarkTile:
	push af ; $774c
	push bc ; $774d
	push de ; $774e
	push hl ; $774f
	ld hl, MinigameMarkTileTable ; $7750
	ld a, b ; $7753
	add a ; $7754
	add l ; $7755
	ld l, a ; $7756
	jr nc, .read ; $7757
	inc h ; $7759
.read:
	ld a, [hl+] ; $775a
	ld h, [hl] ; $775b
	ld l, a ; $775c
	ld a, c ; $775d
	add a ; $775e
	add l ; $775f
	ld l, a ; $7760
	jr nc, .readB ; $7761
	inc h ; $7763
.readB:
	ld a, [hl+] ; $7764
	ld d, [hl] ; $7765
	ld e, a ; $7766
	push de ; $7767
	ld hl, wShadowTilemap + 2 * TILEMAP_WIDTH + 21 ; $7768
	ld b, $02 ; $776b
	ld c, $02 ; $776d
	farcall CopyTilemapRect ; $776f
	pop de ; $7772
	ld hl, $0400 ; $7773
	add hl, de ; $7776
	ld d, h ; $7777
	ld e, l ; $7778
	ld hl, wShadowAttrmap + 2 * TILEMAP_WIDTH + 21 ; $7779
	ld b, $02 ; $777c
	ld c, $02 ; $777e
	farcall CopyTilemapRect ; $7780
	pop hl ; $7783
	pop de ; $7784
	pop bc ; $7785
	pop af ; $7786
	ret ; $7787
MinigameMarkTileTable:
	; $7788, 6 bytes (records:2)
	dw MinigameStarRow0 ; record 0
	dw MinigameStarRow1 ; record 1
	dw MinigameStarRow2 ; record 2
MinigameStarRow0:
	INCBIN "data/bank_01b/d_778e.bin" ; $778e, 10 bytes
MinigameStarRow1:
	INCBIN "data/bank_01b/d_7798.bin" ; $7798, 10 bytes
MinigameStarRow2:
	INCBIN "data/bank_01b/d_77a2.bin" ; $77a2, 10 bytes
ClearMinigameMarkColumns:
	ld hl, wShadowTilemap + 4 * TILEMAP_WIDTH + 21 ; $77ac
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH + 6 ; $77af
	ld b, $02 ; $77b2
	ld c, $0a ; $77b4
	farcall CopyTilemapRect ; $77b6
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH + 21 ; $77b9
	ld de, wShadowAttrmap + 6 * TILEMAP_WIDTH + 6 ; $77bc
	ld b, $02 ; $77bf
	ld c, $0a ; $77c1
	farcall CopyTilemapRect ; $77c3
	ld hl, wShadowTilemap + 4 * TILEMAP_WIDTH + 21 ; $77c6
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH + 10 ; $77c9
	ld b, $02 ; $77cc
	ld c, $0a ; $77ce
	farcall CopyTilemapRect ; $77d0
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH + 21 ; $77d3
	ld de, wShadowAttrmap + 6 * TILEMAP_WIDTH + 10 ; $77d6
	ld b, $02 ; $77d9
	ld c, $0a ; $77db
	farcall CopyTilemapRect ; $77dd
	ld hl, wShadowTilemap + 4 * TILEMAP_WIDTH + 21 ; $77e0
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH + 14 ; $77e3
	ld b, $02 ; $77e6
	ld c, $0a ; $77e8
	farcall CopyTilemapRect ; $77ea
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH + 21 ; $77ed
	ld de, wShadowAttrmap + 6 * TILEMAP_WIDTH + 14 ; $77f0
	ld b, $02 ; $77f3
	ld c, $0a ; $77f5
	farcall CopyTilemapRect ; $77f7
	ret ; $77fa
DrawStarLegendMark:
	ld hl, $d812 ; $77fb
	ld c, $00 ; $77fe
.loop:
	ld a, [hl+] ; $7800
	or a ; $7801
	jr nz, .nonZero ; $7802
	ld a, c ; $7804
	inc a ; $7805
	ld c, a ; $7806
	cp $09 ; $7807
	jr nz, .loop ; $7809
	ret ; $780b
.nonZero:
	ld hl, wShadowTilemap + 22 ; $780c
	ld de, wShadowTilemap + 4 * TILEMAP_WIDTH + 14 ; $780f
	ld b, $02 ; $7812
	ld c, $02 ; $7814
	farcall CopyTilemapRect ; $7816
	ld hl, wShadowAttrmap + 22 ; $7819
	ld de, wShadowAttrmap + 4 * TILEMAP_WIDTH + 14 ; $781c
	ld b, $02 ; $781f
	ld c, $02 ; $7821
	farcall CopyTilemapRect ; $7823
	ret ; $7826
DrawMinigameHighScoreNumbers:
	ldh a, [hWramBank] ; $7827
	push af ; $7829
	wram_bank $03 ; $782a
	ld a, [wMenuCursorY] ; $7830
	ld c, a ; $7833
	ld b, $00 ; $7834
.loop:
	call DrawMinigameHighScoreNumber ; $7836
	inc c ; $7839
	ld a, b ; $783a
	inc b ; $783b
	ld a, b ; $783c
	cp $05 ; $783d
	jr nz, .loop ; $783f
	pop af ; $7841
	wram_bank ; $7842
	ret ; $7846
DrawMinigameHighScoreNumber:
	ld a, c ; $7847
	cp $08 ; $7848
	ret z ; $784a
	ld a, b ; $784b
	add a ; $784c
	ld hl, MinigameHighScoreNumberTable ; $784d
	add l ; $7850
	ld l, a ; $7851
	jr nc, .read ; $7852
	inc h ; $7854
.read:
	ld a, [hl+] ; $7855
	ld d, [hl] ; $7856
	ld e, a ; $7857
	ld a, c ; $7858
	ld hl, $d812 ; $7859
	add l ; $785c
	ld l, a ; $785d
	jr nc, .readB ; $785e
	inc h ; $7860
.readB:
	ld a, [hl] ; $7861
	or a ; $7862
	ret z ; $7863
	ld a, c ; $7864
	add a ; $7865
	ld hl, $d81b ; $7866
	add l ; $7869
	ld l, a ; $786a
	jr nc, .read2 ; $786b
	inc h ; $786d
.read2:
	ld a, [hl+] ; $786e
	ld h, [hl] ; $786f
	ld l, a ; $7870
	farcall DrawDecimalNumberSprites_39 ; $7871
	ret ; $7874
MinigameHighScoreNumberTable:
	; $7875, 10 bytes (bytes:10)
	db $35, $84, $45, $84, $55, $84, $65, $84, $75, $84 ; 0x00
CheckMinigameDataScrollable:
	push bc ; $787f
	push de ; $7880
	push hl ; $7881
	ld c, $04 ; $7882
	farcall GetUnlockedMarioCastCharAtGridSlot ; $7884
	cp $15 ; $7887
	jr nz, .scrollable ; $7889
	pop hl ; $788b
	pop de ; $788c
	pop bc ; $788d
	xor a ; $788e
	ret ; $788f
.scrollable:
	pop hl ; $7890
	pop de ; $7891
	pop bc ; $7892
	ld a, $01 ; $7893
	ret ; $7895
CompactMinigameDataRows:
	ldh a, [hWramBank] ; $7896
	push af ; $7898
	wram_bank $03 ; $7899
	ld a, [$d80e] ; $789f
	ld [$d80d], a ; $78a2
	ld a, [$d817] ; $78a5
	ld [$d816], a ; $78a8
	ld a, [$d825] ; $78ab
	ld [$d823], a ; $78ae
	ld a, [$d826] ; $78b1
	ld [$d824], a ; $78b4
	pop af ; $78b7
	wram_bank ; $78b8
	ret ; $78bc
ObjectSceneAGfx0:
	INCBIN "data/bank_01b/lz_78bd.bin" ; $78bd, 179 bytes
ObjectSceneAGfx1:
	INCBIN "data/bank_01b/lz_7970.bin" ; $7970, 80 bytes
ObjectSceneAGfx2:
	INCBIN "data/bank_01b/lz_79c0.bin" ; $79c0, 184 bytes
ObjectSceneBGfx0:
	INCBIN "data/bank_01b/lz_7a78.bin" ; $7a78, 61 bytes
ObjectSceneBGfx1:
	INCBIN "data/bank_01b/lz_7ab5.bin" ; $7ab5, 65 bytes
ObjectSceneBGfx2:
	INCBIN "data/bank_01b/lz_7af6.bin" ; $7af6, 65 bytes
Screen0Gfx:
	INCBIN "data/bank_01b/lz_7b37.bin" ; $7b37, 503 bytes
Screen1ObjGfx:
	INCBIN "data/bank_01b/lz_7d2e.bin" ; $7d2e, 321 bytes
Screen2ObjGfx:
	INCBIN "data/bank_01b/lz_7e6f.bin" ; $7e6f, 323 bytes
	; $7fb2, 78 bytes fill to bank end (linker-padded)
