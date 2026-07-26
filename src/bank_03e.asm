SECTION "ROM Bank $3e", ROMX[$4000], BANK[$3e]

	farptr RunLinkMatchRulesMenu ; $4000
	farptr RestoreMenuScreenAndFadeIn ; $4002
	farptr ShowLinkMessageScreen ; $4004
	farptr RunEraseDataConfirmMenu ; $4006
	farptr RunRacketShoesChoiceMenu ; $4008
	farptr RunPlayAlonePartnerMenu ; $400a
	farptr RunRacketSelectScreen ; $400c
	farptr RunShoesSelectScreen ; $400e
	farptr ShowEquipmentStatusScreen ; $4010
	farptr ShowLinkErrorScreen ; $4012
	farptr UpdateAnimatedTiles_3e ; $4014
	farptr AnimateLinkStatusPalette ; $4016
	farptr RunCourtSelect4Menu ; $4018
	farptr RunLinkCourtSelect4Menu ; $401a
	farptr RunCourtSelect9Menu ; $401c
	farptr RunLinkCourtSelect9Menu ; $401e
	farptr LoadCourtSelectGraphics ; $4020
	farptr ComputeUnlockedCourtFlags ; $4022
	farptr StubNop_3e ; $4024
	farptr OpenChoiceTabPanel ; $4026
	farptr CloseChoiceTabPanel ; $4028
	farptr OpenCourtSelect4Panel ; $402a
	farptr CloseCourtSelect4Panel ; $402c
	farptr SetCourtSelect4TabAttrRect ; $402e
	farptr ShowLinkStatusMessage ; $4030
DataPtr_AwardCeremonyTiles:
	dw AwardCeremonyTiles ; $4032
DataPtr_AwardCeremonyTilesAlias1:
	dw AwardCeremonyTiles ; $4034
DataPtr_AwardCeremonyTilesAlias2:
	dw AwardCeremonyTiles ; $4036
DataPtr_AwardCeremonyTilesAlias3:
	dw AwardCeremonyTiles ; $4038
DataPtr_AwardCeremonyTilesAlias4:
	dw AwardCeremonyTiles ; $403a
DataPtr_AwardCeremonyPalettes:
	dw AwardCeremonyPalettes ; $403c
DataPtr_AwardCeremonyTilemap5:
	dw AwardCeremonyTilemap5 ; $403e
DataPtr_AwardCeremonyAttrmap5:
	dw AwardCeremonyAttrmap5 ; $4040
DataPtr_3e_42:
	dw Lz_3e_75e8 ; $4042
DataPtr_3e_44:
	dw Lz_3e_769b ; $4044
DataPtr_3e_46:
	dw Lz_3e_7752 ; $4046
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
	add a, d ; $4060
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
	add a, e ; $407a
	ld e, a ; $407b
	ld a, b ; $407c
	add a, d ; $407d
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
	add a, c ; $4095
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
	and a, $0f ; $40ad
	ld hl, SelectionBoxWobbleXTable_3e ; $40af
	add a, l ; $40b2
	ld l, a ; $40b3
	jr nc, Label_3e_40b7 ; $40b4
	inc h ; $40b6
Label_3e_40b7:
	ld a, [hl] ; $40b7
	ld b, a ; $40b8
	ld a, c ; $40b9
	or a, a ; $40ba
	jr z, Label_3e_40c1 ; $40bb
	ld a, b ; $40bd
	add a, d ; $40be
	ld d, a ; $40bf
	ret ; $40c0
Label_3e_40c1:
	ld a, d ; $40c1
	sub a, b ; $40c2
	ld d, a ; $40c3
	ret ; $40c4
SelectionBoxWobbleXTable_3e:
	; $40c5, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x00
ApplySelectionBoxWobbleY:
	ldh a, [hVBlankCounter] ; $40d5
	and a, $0f ; $40d7
	ld hl, SelectionBoxWobbleYTable_3e ; $40d9
	add a, l ; $40dc
	ld l, a ; $40dd
	jr nc, Label_3e_40e1 ; $40de
	inc h ; $40e0
Label_3e_40e1:
	ld a, [hl] ; $40e1
	ld b, a ; $40e2
	ld a, c ; $40e3
	or a, a ; $40e4
	jr z, Label_3e_40eb ; $40e5
	ld a, b ; $40e7
	add a, e ; $40e8
	ld e, a ; $40e9
	ret ; $40ea
Label_3e_40eb:
	ld a, e ; $40eb
	sub a, b ; $40ec
	ld e, a ; $40ed
	ret ; $40ee
SelectionBoxWobbleYTable_3e:
	INCBIN "data/bank_03e/d_40ef.bin" ; $40ef, 75 bytes
MoveMenuCursorGrid_3e:
	ld a, [wMenuCursorX] ; $413a
	ld d, a ; $413d
	ld a, [wMenuCursorY] ; $413e
	ld e, a ; $4141
	ld a, [wMenuInputPressed] ; $4142
	bit PADB_RIGHT, a ; $4145
	jr z, Label_3e_415e ; $4147
	ld a, [wMenuCursorX] ; $4149
	inc a ; $414c
	add a, a ; $414d
	jr nc, Label_3e_4154 ; $414e
	ld a, b ; $4150
	dec a ; $4151
	jr Label_3e_4159 ; $4152
Label_3e_4154:
	rra ; $4154
	cp a, b ; $4155
	jr c, Label_3e_4159 ; $4156
	xor a, a ; $4158
Label_3e_4159:
	ld [wMenuCursorX], a ; $4159
	jr Label_3e_41a7 ; $415c
Label_3e_415e:
	bit 5, a ; $415e
	jr z, Label_3e_4177 ; $4160
	ld a, [wMenuCursorX] ; $4162
	dec a ; $4165
	add a, a ; $4166
	jr nc, Label_3e_416d ; $4167
	ld a, b ; $4169
	dec a ; $416a
	jr Label_3e_4172 ; $416b
Label_3e_416d:
	rra ; $416d
	cp a, b ; $416e
	jr c, Label_3e_4172 ; $416f
	xor a, a ; $4171
Label_3e_4172:
	ld [wMenuCursorX], a ; $4172
	jr Label_3e_41a7 ; $4175
Label_3e_4177:
	bit 6, a ; $4177
	jr z, Label_3e_4190 ; $4179
	ld a, [wMenuCursorY] ; $417b
	dec a ; $417e
	add a, a ; $417f
	jr nc, Label_3e_4186 ; $4180
	ld a, c ; $4182
	dec a ; $4183
	jr Label_3e_418b ; $4184
Label_3e_4186:
	rra ; $4186
	cp a, c ; $4187
	jr c, Label_3e_418b ; $4188
	xor a, a ; $418a
Label_3e_418b:
	ld [wMenuCursorY], a ; $418b
	jr Label_3e_41a7 ; $418e
Label_3e_4190:
	bit 7, a ; $4190
	jr z, Label_3e_41a7 ; $4192
	ld a, [wMenuCursorY] ; $4194
	inc a ; $4197
	add a, a ; $4198
	jr nc, Label_3e_419f ; $4199
	ld a, c ; $419b
	dec a ; $419c
	jr Label_3e_41a4 ; $419d
Label_3e_419f:
	rra ; $419f
	cp a, c ; $41a0
	jr c, Label_3e_41a4 ; $41a1
	xor a, a ; $41a3
Label_3e_41a4:
	ld [wMenuCursorY], a ; $41a4
Label_3e_41a7:
	ld a, [wMenuCursorX] ; $41a7
	cp a, d ; $41aa
	jr nz, Label_3e_41b5 ; $41ab
	ld a, [wMenuCursorY] ; $41ad
	cp a, e ; $41b0
	jr nz, Label_3e_41b5 ; $41b1
	xor a, a ; $41b3
	ret ; $41b4
Label_3e_41b5:
	ld a, $01 ; $41b5
	ret ; $41b7
	ld a, [wMenuCursorX] ; $41b8
	ld d, a ; $41bb
	ld a, [wMenuCursorY] ; $41bc
	ld e, a ; $41bf
	ldh a, [hLinkInput] ; $41c0
	bit 4, a ; $41c2
	jr z, Label_3e_41db ; $41c4
	ld a, [wMenuCursorX] ; $41c6
	inc a ; $41c9
	add a, a ; $41ca
	jr nc, Label_3e_41d1 ; $41cb
	ld a, b ; $41cd
	dec a ; $41ce
	jr Label_3e_41d6 ; $41cf
Label_3e_41d1:
	rra ; $41d1
	cp a, b ; $41d2
	jr c, Label_3e_41d6 ; $41d3
	xor a, a ; $41d5
Label_3e_41d6:
	ld [wMenuCursorX], a ; $41d6
	jr Label_3e_4224 ; $41d9
Label_3e_41db:
	bit 5, a ; $41db
	jr z, Label_3e_41f4 ; $41dd
	ld a, [wMenuCursorX] ; $41df
	dec a ; $41e2
	add a, a ; $41e3
	jr nc, Label_3e_41ea ; $41e4
	ld a, b ; $41e6
	dec a ; $41e7
	jr Label_3e_41ef ; $41e8
Label_3e_41ea:
	rra ; $41ea
	cp a, b ; $41eb
	jr c, Label_3e_41ef ; $41ec
	xor a, a ; $41ee
Label_3e_41ef:
	ld [wMenuCursorX], a ; $41ef
	jr Label_3e_4224 ; $41f2
Label_3e_41f4:
	bit 6, a ; $41f4
	jr z, Label_3e_420d ; $41f6
	ld a, [wMenuCursorY] ; $41f8
	dec a ; $41fb
	add a, a ; $41fc
	jr nc, Label_3e_4203 ; $41fd
	ld a, c ; $41ff
	dec a ; $4200
	jr Label_3e_4208 ; $4201
Label_3e_4203:
	rra ; $4203
	cp a, c ; $4204
	jr c, Label_3e_4208 ; $4205
	xor a, a ; $4207
Label_3e_4208:
	ld [wMenuCursorY], a ; $4208
	jr Label_3e_4224 ; $420b
Label_3e_420d:
	bit 7, a ; $420d
	jr z, Label_3e_4224 ; $420f
	ld a, [wMenuCursorY] ; $4211
	inc a ; $4214
	add a, a ; $4215
	jr nc, Label_3e_421c ; $4216
	ld a, c ; $4218
	dec a ; $4219
	jr Label_3e_4221 ; $421a
Label_3e_421c:
	rra ; $421c
	cp a, c ; $421d
	jr c, Label_3e_4221 ; $421e
	xor a, a ; $4220
Label_3e_4221:
	ld [wMenuCursorY], a ; $4221
Label_3e_4224:
	ld a, [wMenuCursorX] ; $4224
	cp a, d ; $4227
	jr nz, Label_3e_4232 ; $4228
	ld a, [wMenuCursorY] ; $422a
	cp a, e ; $422d
	jr nz, Label_3e_4232 ; $422e
	xor a, a ; $4230
	ret ; $4231
Label_3e_4232:
	ld a, $01 ; $4232
	ret ; $4234
	ld a, [wMenuCursorX] ; $4235
	ld d, a ; $4238
	ld a, [wMenuCursorY] ; $4239
	ld e, a ; $423c
	ldh a, [hLinkState] ; $423d
	cp a, $02 ; $423f
	jr z, Label_3e_424e ; $4241
	cp a, $01 ; $4243
	jr z, Label_3e_424a ; $4245
	call LinkErrorReset ; $4247
Label_3e_424a:
	ldh a, [hLinkRemoteInputBuf] ; $424a
	jr Label_3e_4250 ; $424c
Label_3e_424e:
	ldh a, [hLinkRemoteInput] ; $424e
Label_3e_4250:
	ld h, a ; $4250
	ld a, [wMenuCursorLockFlags] ; $4251
	and a, $01 ; $4254
	ld a, h ; $4256
	jr nz, Label_3e_42bd ; $4257
	bit 4, a ; $4259
	jr z, Label_3e_4272 ; $425b
	ld a, [wMenuCursorX] ; $425d
	inc a ; $4260
	add a, a ; $4261
	jr nc, Label_3e_4268 ; $4262
	ld a, b ; $4264
	dec a ; $4265
	jr Label_3e_426d ; $4266
Label_3e_4268:
	rra ; $4268
	cp a, b ; $4269
	jr c, Label_3e_426d ; $426a
	xor a, a ; $426c
Label_3e_426d:
	ld [wMenuCursorX], a ; $426d
	jr Label_3e_42ef ; $4270
Label_3e_4272:
	bit 5, a ; $4272
	jr z, Label_3e_428b ; $4274
	ld a, [wMenuCursorX] ; $4276
	dec a ; $4279
	add a, a ; $427a
	jr nc, Label_3e_4281 ; $427b
	ld a, b ; $427d
	dec a ; $427e
	jr Label_3e_4286 ; $427f
Label_3e_4281:
	rra ; $4281
	cp a, b ; $4282
	jr c, Label_3e_4286 ; $4283
	xor a, a ; $4285
Label_3e_4286:
	ld [wMenuCursorX], a ; $4286
	jr Label_3e_42ef ; $4289
Label_3e_428b:
	bit 6, a ; $428b
	jr z, Label_3e_42a4 ; $428d
	ld a, [wMenuCursorY] ; $428f
	dec a ; $4292
	add a, a ; $4293
	jr nc, Label_3e_429a ; $4294
	ld a, c ; $4296
	dec a ; $4297
	jr Label_3e_429f ; $4298
Label_3e_429a:
	rra ; $429a
	cp a, c ; $429b
	jr c, Label_3e_429f ; $429c
	xor a, a ; $429e
Label_3e_429f:
	ld [wMenuCursorY], a ; $429f
	jr Label_3e_42ef ; $42a2
Label_3e_42a4:
	bit 7, a ; $42a4
	jr z, Label_3e_42bd ; $42a6
	ld a, [wMenuCursorY] ; $42a8
	inc a ; $42ab
	add a, a ; $42ac
	jr nc, Label_3e_42b3 ; $42ad
	ld a, c ; $42af
	dec a ; $42b0
	jr Label_3e_42b8 ; $42b1
Label_3e_42b3:
	rra ; $42b3
	cp a, c ; $42b4
	jr c, Label_3e_42b8 ; $42b5
	xor a, a ; $42b7
Label_3e_42b8:
	ld [wMenuCursorY], a ; $42b8
	jr Label_3e_42ef ; $42bb
Label_3e_42bd:
	bit 0, a ; $42bd
	jr z, Label_3e_42d5 ; $42bf
	sound $5f ; $42c1
	ld a, [wMenuCursorLockFlags] ; $42c3
	ld b, a ; $42c6
	and a, $01 ; $42c7
	jr nz, Label_3e_42ef ; $42c9
	sound $5f ; $42cb
	ld a, b ; $42cd
	or a, $01 ; $42ce
	ld [wMenuCursorLockFlags], a ; $42d0
	jr Label_3e_42ef ; $42d3
Label_3e_42d5:
	bit 1, a ; $42d5
	jr z, Label_3e_42ef ; $42d7
	sound $62 ; $42d9
	ld a, [wMenuCursorLockFlags] ; $42db
	ld b, a ; $42de
	and a, $03 ; $42df
	ld a, b ; $42e1
	jr nz, Label_3e_42ea ; $42e2
	and a, $fa ; $42e4
	or a, $04 ; $42e6
	jr Label_3e_42ec ; $42e8
Label_3e_42ea:
	and a, $fe ; $42ea
Label_3e_42ec:
	ld [wMenuCursorLockFlags], a ; $42ec
Label_3e_42ef:
	ld a, [wMenuCursorX] ; $42ef
	cp a, d ; $42f2
	jr nz, Label_3e_42fd ; $42f3
	ld a, [wMenuCursorY] ; $42f5
	cp a, e ; $42f8
	jr nz, Label_3e_42fd ; $42f9
	xor a, a ; $42fb
	ret ; $42fc
Label_3e_42fd:
	ld a, $01 ; $42fd
	ret ; $42ff
	ld a, [wMenuCursor2X] ; $4300
	ld d, a ; $4303
	ld a, [wMenuCursor2Y] ; $4304
	ld e, a ; $4307
	ldh a, [hLinkState] ; $4308
	cp a, $02 ; $430a
	jr z, Label_3e_4319 ; $430c
	cp a, $01 ; $430e
	jr z, Label_3e_4315 ; $4310
	call LinkErrorReset ; $4312
Label_3e_4315:
	ldh a, [hLinkRemoteInput] ; $4315
	jr Label_3e_431b ; $4317
Label_3e_4319:
	ldh a, [hLinkRemoteInputBuf] ; $4319
Label_3e_431b:
	ld h, a ; $431b
	ld a, [wMenuCursorLockFlags] ; $431c
	and a, $02 ; $431f
	ld a, h ; $4321
	jr nz, Label_3e_4388 ; $4322
	bit 4, a ; $4324
	jr z, Label_3e_433d ; $4326
	ld a, [wMenuCursor2X] ; $4328
	inc a ; $432b
	add a, a ; $432c
	jr nc, Label_3e_4333 ; $432d
	ld a, b ; $432f
	dec a ; $4330
	jr Label_3e_4338 ; $4331
Label_3e_4333:
	rra ; $4333
	cp a, b ; $4334
	jr c, Label_3e_4338 ; $4335
	xor a, a ; $4337
Label_3e_4338:
	ld [wMenuCursor2X], a ; $4338
	jr Label_3e_43b8 ; $433b
Label_3e_433d:
	bit 5, a ; $433d
	jr z, Label_3e_4356 ; $433f
	ld a, [wMenuCursor2X] ; $4341
	dec a ; $4344
	add a, a ; $4345
	jr nc, Label_3e_434c ; $4346
	ld a, b ; $4348
	dec a ; $4349
	jr Label_3e_4351 ; $434a
Label_3e_434c:
	rra ; $434c
	cp a, b ; $434d
	jr c, Label_3e_4351 ; $434e
	xor a, a ; $4350
Label_3e_4351:
	ld [wMenuCursor2X], a ; $4351
	jr Label_3e_43b8 ; $4354
Label_3e_4356:
	bit 6, a ; $4356
	jr z, Label_3e_436f ; $4358
	ld a, [wMenuCursor2Y] ; $435a
	dec a ; $435d
	add a, a ; $435e
	jr nc, Label_3e_4365 ; $435f
	ld a, c ; $4361
	dec a ; $4362
	jr Label_3e_436a ; $4363
Label_3e_4365:
	rra ; $4365
	cp a, c ; $4366
	jr c, Label_3e_436a ; $4367
	xor a, a ; $4369
Label_3e_436a:
	ld [wMenuCursor2Y], a ; $436a
	jr Label_3e_43b8 ; $436d
Label_3e_436f:
	bit 7, a ; $436f
	jr z, Label_3e_4388 ; $4371
	ld a, [wMenuCursor2Y] ; $4373
	inc a ; $4376
	add a, a ; $4377
	jr nc, Label_3e_437e ; $4378
	ld a, c ; $437a
	dec a ; $437b
	jr Label_3e_4383 ; $437c
Label_3e_437e:
	rra ; $437e
	cp a, c ; $437f
	jr c, Label_3e_4383 ; $4380
	xor a, a ; $4382
Label_3e_4383:
	ld [wMenuCursor2Y], a ; $4383
	jr Label_3e_43b8 ; $4386
Label_3e_4388:
	bit 0, a ; $4388
	jr z, Label_3e_439e ; $438a
	ld a, [wMenuCursorLockFlags] ; $438c
	ld b, a ; $438f
	and a, $02 ; $4390
	jr nz, Label_3e_43b8 ; $4392
	sound $5f ; $4394
	ld a, b ; $4396
	or a, $02 ; $4397
	ld [wMenuCursorLockFlags], a ; $4399
	jr Label_3e_43b8 ; $439c
Label_3e_439e:
	bit 1, a ; $439e
	jr z, Label_3e_43b8 ; $43a0
	sound $62 ; $43a2
	ld a, [wMenuCursorLockFlags] ; $43a4
	ld b, a ; $43a7
	and a, $03 ; $43a8
	ld a, b ; $43aa
	jr nz, Label_3e_43b3 ; $43ab
	and a, $f5 ; $43ad
	or a, $08 ; $43af
	jr Label_3e_43b5 ; $43b1
Label_3e_43b3:
	and a, $fd ; $43b3
Label_3e_43b5:
	ld [wMenuCursorLockFlags], a ; $43b5
Label_3e_43b8:
	ld a, [wMenuCursor2X] ; $43b8
	cp a, d ; $43bb
	jr nz, Label_3e_43c6 ; $43bc
	ld a, [wMenuCursor2Y] ; $43be
	cp a, e ; $43c1
	jr nz, Label_3e_43c6 ; $43c2
	xor a, a ; $43c4
	ret ; $43c5
Label_3e_43c6:
	ld a, $01 ; $43c6
	ret ; $43c8
GetMenuCursorIndex_3e:
	ld a, [wMenuCursorY] ; $43c9
	ld b, a ; $43cc
	xor a, a ; $43cd
	inc b ; $43ce
.mulLoop:
	dec b ; $43cf
	jr z, .addColumn ; $43d0
	add a, c ; $43d2
	jr .mulLoop ; $43d3
.addColumn:
	ld b, a ; $43d5
	ld a, [wMenuCursorX] ; $43d6
	add a, b ; $43d9
	ret ; $43da
GetCellIndexFromCursorPtr_3e:
	push bc ; $43db
	ld a, [hl-] ; $43dc
	ld b, a ; $43dd
	xor a, a ; $43de
	inc b ; $43df
Label_3e_43e0:
	dec b ; $43e0
	jr z, Label_3e_43e6 ; $43e1
	add a, c ; $43e3
	jr Label_3e_43e0 ; $43e4
Label_3e_43e6:
	ld b, a ; $43e6
	ld a, [hl] ; $43e7
	add a, b ; $43e8
	pop bc ; $43e9
	ret ; $43ea
SetMenuCursorFromIndex_3e:
	ld d, $00 ; $43eb
	ld a, c ; $43ed
.divLoop:
	cp a, b ; $43ee
	jr c, .store ; $43ef
	inc d ; $43f1
	sub a, b ; $43f2
	jr .divLoop ; $43f3
.store:
	ld [wMenuCursorX], a ; $43f5
	ld a, d ; $43f8
	ld [wMenuCursorY], a ; $43f9
	ret ; $43fc
SetMenuCursorFromIndexToPtr:
	ld d, $00 ; $43fd
	ld a, c ; $43ff
.divLoop:
	cp a, b ; $4400
	jr c, .store ; $4401
	inc d ; $4403
	sub a, b ; $4404
	jr .divLoop ; $4405
.store:
	ld [hl+], a ; $4407
	ld a, d ; $4408
	ld [hl], a ; $4409
	ret ; $440a
ClearWram3Row64_3e:
	ldh a, [hWramBank] ; $440b
	push af ; $440d
	wram_bank $03 ; $440e
	xor a, a ; $4414
	ld c, $40 ; $4415
Label_3e_4417:
	ld [hl+], a ; $4417
	dec c ; $4418
	jr nz, Label_3e_4417 ; $4419
	pop af ; $441b
	wram_bank ; $441c
	ret ; $4420
ClearWram3Row64Alt_3e:
	ldh a, [hWramBank] ; $4421
	push af ; $4423
	wram_bank $03 ; $4424
	ld a, $00 ; $442a
	ld c, $40 ; $442c
Label_3e_442e:
	ld [hl+], a ; $442e
	dec c ; $442f
	jr nz, Label_3e_442e ; $4430
	pop af ; $4432
	wram_bank ; $4433
	ret ; $4437
UpdateAnimatedTiles_3e:
	farcall UpdateAnimatedTiles ; $4438
	ret ; $443b
	push af ; $443c
	push bc ; $443d
Label_3e_443e:
	ld a, [hl] ; $443e
	cp a, $00 ; $443f
	jr z, Label_3e_4472 ; $4441
	ld [de], a ; $4443
	inc hl ; $4444
	ld a, [hl] ; $4445
	cp a, $de ; $4446
	jr z, Label_3e_444e ; $4448
	cp a, $df ; $444a
	jr nz, Label_3e_4463 ; $444c
Label_3e_444e:
	push hl ; $444e
	push bc ; $444f
	ld h, d ; $4450
	ld l, e ; $4451
	ld bc, $ffe0 ; $4452
	add hl, bc ; $4455
	ld b, a ; $4456
	ld a, [hl] ; $4457
	cp a, $03 ; $4458
	ld a, b ; $445a
	jr nz, Label_3e_445f ; $445b
	sub a, $d0 ; $445d
Label_3e_445f:
	ld [hl], a ; $445f
	pop bc ; $4460
	pop hl ; $4461
	inc hl ; $4462
Label_3e_4463:
	inc de ; $4463
	ld a, e ; $4464
	and a, $1f ; $4465
	jr nz, Label_3e_443e ; $4467
	push hl ; $4469
	ld h, d ; $446a
	ld l, e ; $446b
	add hl, de ; $446c
	ld d, h ; $446d
	ld e, l ; $446e
	pop hl ; $446f
	jr Label_3e_443e ; $4470
Label_3e_4472:
	pop bc ; $4472
	pop af ; $4473
	ret ; $4474
	push af ; $4475
	push bc ; $4476
	push hl ; $4477
	add sp, -10 ; $4478
	push bc ; $447a
	push de ; $447b
	ld c, l ; $447c
	ld b, h ; $447d
	ld hl, sp + 4 ; $447e
	ld e, l ; $4480
	ld d, h ; $4481
	ld l, c ; $4482
	ld h, b ; $4483
	ld c, e ; $4484
	ld b, d ; $4485
	call FormatDecimalNumber ; $4486
	ld l, c ; $4489
	ld h, b ; $448a
	pop de ; $448b
	pop bc ; $448c
	call DrawAsciiDigitString_3e ; $448d
	add sp, 10 ; $4490
	pop hl ; $4492
	pop bc ; $4493
	pop af ; $4494
	ret ; $4495
DrawAsciiDigitString_3e:
	ld a, [hl+] ; $4496
	and a, a ; $4497
	jr z, Label_3e_449f ; $4498
	call DrawAsciiDigitChar_3e ; $449a
	jr DrawAsciiDigitString_3e ; $449d
Label_3e_449f:
	ret ; $449f
DrawAsciiDigitChar_3e:
	push hl ; $44a0
	ld hl, $d240 ; $44a1
	sub a, $30 ; $44a4
	jr c, Label_3e_44b6 ; $44a6
	add a, $30 ; $44a8
	ld b, a ; $44aa
	wram_bank $03 ; $44ab
	ld a, b ; $44b1
	ld [de], a ; $44b2
	inc de ; $44b3
	pop hl ; $44b4
	ret ; $44b5
Label_3e_44b6:
	inc de ; $44b6
	pop hl ; $44b7
	ret ; $44b8
RestoreMenuScreenAndFadeIn:
	call DisableLCDSafely ; $44b9
	farcall LoadMenuFontGfx ; $44bc
	farcall ResetScreenAndTextWindows ; $44bf
	call EnableLCD ; $44c2
	script_fade_in $10 ; $44c5
	ret ; $44ca
RunLinkMatchRulesMenu:
	call EnableTimerInterrupt ; $44cb
	sound $03 ; $44ce
	xor a, a ; $44d0
	ld [wMatchFormatDoubles], a ; $44d1
	ld [wMatchFormatGames], a ; $44d4
	ld [wMatchFormatSets], a ; $44d7
	xor a, a ; $44da
	ldh [$ffd8], a ; $44db
	call ResetSerialState ; $44dd
	call LoadMatchRulesMenuGraphics ; $44e0
	wram_bank $03 ; $44e3
	ld a, [wMenuSlideDirection] ; $44e9
	ld b, a ; $44ec
	call OpenMatchRulesPanel ; $44ed
	farcall InitMenuBgScroll ; $44f0
	ld b, $01 ; $44f3
	ld c, $01 ; $44f5
	farcall LoadMenuSpritePalettePair ; $44f7
	call DrawMatchRulesInitialState ; $44fa
	ld a, $01 ; $44fd
	ld hl, MatchRulesCursorSpriteTask ; $44ff
	call RegisterFrameTask ; $4502
	call DrawMatchRulesCaption ; $4505
	farcall ResyncLinkSessionWithTimer ; $4508
	push af ; $450b
	farcall RunLinkInputFrame ; $450c
	pop af ; $450f
	push af ; $4510
	farcall RunLinkInputFrame ; $4511
	pop af ; $4514
	push af ; $4515
	farcall RunLinkInputFrame ; $4516
	pop af ; $4519
	ld hl, rIE ; $451a
	res 2, [hl] ; $451d
	wram_bank $03 ; $451f
Label_3e_4525:
	farcall TickMenuBgScroll ; $4525
	ldh a, [hLinkInput] ; $4528
	ld [wMenuInputPressed], a ; $452a
	call HandleMatchRulesToggleInput ; $452d
	ld b, $01 ; $4530
	ld c, $03 ; $4532
	call MoveMenuCursorGrid_3e ; $4534
	or a, a ; $4537
	jr z, Label_3e_453f ; $4538
	sound $5e ; $453a
	call DrawMatchRulesCaption ; $453c
Label_3e_453f:
	push af ; $453f
	farcall RunLinkInputFrame ; $4540
	pop af ; $4543
	ld a, [wMenuInputPressed] ; $4544
	bit PADB_A, a ; $4547
	jr nz, Label_3e_4551 ; $4549
	bit 1, a ; $454b
	jr nz, Label_3e_4579 ; $454d
	jr Label_3e_4525 ; $454f
Label_3e_4551:
	sound $5f ; $4551
	push af ; $4553
	farcall SyncLinkFrame ; $4554
	pop af ; $4557
	xor a, a ; $4558
	ldh [$ffd8], a ; $4559
	call ResetSerialState ; $455b
	call EnableTimerInterrupt ; $455e
	call ClearFrameTasks ; $4561
	ld b, $01 ; $4564
	call CloseMatchRulesPanel ; $4566
	ld a, $01 ; $4569
	ld [wMenuSlideDirection], a ; $456b
	ld c, $03 ; $456e
	call GetMenuCursorIndex_3e ; $4570
	ld hl, rIE ; $4573
	set 2, [hl] ; $4576
	ret ; $4578
Label_3e_4579:
	sound $62 ; $4579
	push af ; $457b
	farcall SyncLinkFrame ; $457c
	pop af ; $457f
	xor a, a ; $4580
	ldh [$ffd8], a ; $4581
	call ResetSerialState ; $4583
	call ClearFrameTasks ; $4586
	ld b, $00 ; $4589
	call CloseMatchRulesPanel ; $458b
	ld a, $00 ; $458e
	ld [wMenuSlideDirection], a ; $4590
	ld hl, rIE ; $4593
	set 2, [hl] ; $4596
	ld a, $ff ; $4598
	ret ; $459a
DrawMatchRulesInitialState:
	ld b, $01 ; $459b
	ld c, $00 ; $459d
	call SetMenuCursorFromIndex_3e ; $459f
	ld a, [wMatchFormatDoubles] ; $45a2
	ld b, a ; $45a5
	ld c, $01 ; $45a6
	call SetMatchRuleOptionAttrRect ; $45a8
	ld b, $00 ; $45ab
	call FlushMatchRuleRowAttrs ; $45ad
	ld a, [wMatchFormatGames] ; $45b0
	add a, $02 ; $45b3
	ld b, a ; $45b5
	ld c, $01 ; $45b6
	call SetMatchRuleOptionAttrRect ; $45b8
	ld b, $01 ; $45bb
	call FlushMatchRuleRowAttrs ; $45bd
	ld a, [wMatchFormatSets] ; $45c0
	add a, $04 ; $45c3
	ld b, a ; $45c5
	ld c, $01 ; $45c6
	call SetMatchRuleOptionAttrRect ; $45c8
	ld b, $02 ; $45cb
	call FlushMatchRuleRowAttrs ; $45cd
	ld hl, $45ef ; $45d0
	ld d, $04 ; $45d3
	ld e, $01 ; $45d5
	call LoadPaletteShadow ; $45d7
	ld hl, $45f7 ; $45da
	ld d, $06 ; $45dd
	ld e, $01 ; $45df
	call LoadPaletteShadow ; $45e1
	ld hl, $45ff ; $45e4
	ld d, $07 ; $45e7
	ld e, $01 ; $45e9
	call LoadPaletteShadow ; $45eb
	ret ; $45ee
	; $45ef, 24 bytes (bytes:8)
	db $df, $02, $ff, $7f, $a0, $01, $00, $00 ; 0x00
	db $df, $02, $ff, $7f, $1f, $01, $00, $00 ; 0x08
	db $1f, $03, $ff, $7f, $40, $51, $00, $00 ; 0x10
LoadMatchRulesMenuGraphics:
	ldh a, [hWramBank] ; $4607
	push af ; $4609
	wram_bank $01 ; $460a
	ld c, $00 ; $4610
Label_3e_4612:
	ld a, c ; $4612
	add a, a ; $4613
	ld hl, $46d8 ; $4614
	add a, l ; $4617
	ld l, a ; $4618
	jr nc, Label_3e_461c ; $4619
	inc h ; $461b
Label_3e_461c:
	ld a, [hl+] ; $461c
	ld h, [hl] ; $461d
	ld l, a ; $461e
	push af ; $461f
	push bc ; $4620
	push de ; $4621
	push hl ; $4622
	ld de, $d000 ; $4623
	call DecompressDataFromBank ; $4626
	pop hl ; $4629
	pop de ; $462a
	pop bc ; $462b
	pop af ; $462c
	ld hl, $46e6 ; $462d
	ld a, c ; $4630
	add a, a ; $4631
	add a, l ; $4632
	ld l, a ; $4633
	jr nc, Label_3e_4637 ; $4634
	inc h ; $4636
Label_3e_4637:
	ld a, [hl+] ; $4637
	ld d, [hl] ; $4638
	ld e, a ; $4639
	ld hl, $d000 ; $463a
	push af ; $463d
	push bc ; $463e
	push de ; $463f
	push hl ; $4640
	ld bc, $0010 ; $4641
	call QueueVRAMCopy ; $4644
	pop hl ; $4647
	pop de ; $4648
	pop bc ; $4649
	pop af ; $464a
	ld a, c ; $464b
	inc a ; $464c
	ld c, a ; $464d
	call AdvanceFrame ; $464e
	ld a, c ; $4651
	cp a, $07 ; $4652
	jr nz, Label_3e_4612 ; $4654
	ld b, $23 ; $4656
	ld c, $10 ; $4658
	ld de, $a000 ; $465a
	farcall LoadCompressedTileBlock ; $465d
	call AdvanceFrame ; $4660
	ld b, $24 ; $4663
	ld c, $10 ; $4665
	ld de, $a100 ; $4667
	farcall LoadCompressedTileBlock ; $466a
	call AdvanceFrame ; $466d
	ld b, $25 ; $4670
	ld c, $10 ; $4672
	ld de, $a200 ; $4674
	farcall LoadCompressedTileBlock ; $4677
	call AdvanceFrame ; $467a
	ld b, $26 ; $467d
	ld c, $10 ; $467f
	ld de, $a300 ; $4681
	farcall LoadCompressedTileBlock ; $4684
	call AdvanceFrame ; $4687
	ld b, $27 ; $468a
	ld c, $10 ; $468c
	ld de, $a400 ; $468e
	farcall LoadCompressedTileBlock ; $4691
	call AdvanceFrame ; $4694
	ld b, $28 ; $4697
	ld c, $10 ; $4699
	ld de, $a500 ; $469b
	farcall LoadCompressedTileBlock ; $469e
	call AdvanceFrame ; $46a1
	ld b, $29 ; $46a4
	ld c, $10 ; $46a6
	ld de, $a600 ; $46a8
	farcall LoadCompressedTileBlock ; $46ab
	call AdvanceFrame ; $46ae
	ld b, $1b ; $46b1
	ld c, $04 ; $46b3
	ld de, $a700 ; $46b5
	farcall LoadCompressedTileBlock ; $46b8
	call AdvanceFrame ; $46bb
	ld b, $3f ; $46be
	ld c, $14 ; $46c0
	ld de, $8000 ; $46c2
	farcall LoadCompressedTileBlock ; $46c5
	call AdvanceFrame ; $46c8
	ld b, $08 ; $46cb
	ld c, $10 ; $46cd
	farcall LoadIndexedPalette ; $46cf
	pop af ; $46d2
	wram_bank ; $46d3
	ret ; $46d7
	; $46d8, 28 bytes (records:2)
	dw $3c62 ; record 0
	dw $3c64 ; record 1
	dw $3c66 ; record 2
	dw $3c68 ; record 3
	dw $3c6a ; record 4
	dw $3c6c ; record 5
	dw $3c6e ; record 6
	dw $a800 ; record 7
	dw $a900 ; record 8
	dw $aa00 ; record 9
	dw $ab00 ; record 10
	dw $ac00 ; record 11
	dw $ad00 ; record 12
	dw $ae00 ; record 13
OpenMatchRulesPanel:
	ld a, b ; $46f4
	or a, a ; $46f5
	jr z, Label_3e_4712 ; $46f6
	ld c, $00 ; $46f8
Label_3e_46fa:
	call AdvanceFrame ; $46fa
	ld b, $02 ; $46fd
	farcall RestoreMenuBgAndDrawPanel ; $46ff
	ld b, $00 ; $4702
	farcall FlushWram3MapRows ; $4704
	ld a, c ; $4707
	inc a ; $4708
	ld c, a ; $4709
	cp a, $0e ; $470a
	jr nz, Label_3e_46fa ; $470c
	call AdvanceFrame ; $470e
	ret ; $4711
Label_3e_4712:
	ld c, $0a ; $4712
Label_3e_4714:
	call AdvanceFrame ; $4714
	ld b, $03 ; $4717
	farcall RestoreMenuBgAndDrawPanel ; $4719
	ld b, $00 ; $471c
	farcall FlushWram3MapRows ; $471e
	ld a, c ; $4721
	dec a ; $4722
	ld c, a ; $4723
	cp a, $ff ; $4724
	jr nz, Label_3e_4714 ; $4726
	call AdvanceFrame ; $4728
	ret ; $472b
CloseMatchRulesPanel:
	ld a, b ; $472c
	or a, a ; $472d
	jr z, Label_3e_4747 ; $472e
	ld c, $00 ; $4730
Label_3e_4732:
	call AdvanceFrame ; $4732
	ld b, $03 ; $4735
	farcall RestoreMenuBgAndDrawPanel ; $4737
	ld b, $00 ; $473a
	farcall FlushWram3MapRows ; $473c
	ld a, c ; $473f
	inc a ; $4740
	ld c, a ; $4741
	cp a, $0b ; $4742
	jr nz, Label_3e_4732 ; $4744
	ret ; $4746
Label_3e_4747:
	ld c, $0d ; $4747
Label_3e_4749:
	call AdvanceFrame ; $4749
	ld b, $02 ; $474c
	farcall RestoreMenuBgAndDrawPanel ; $474e
	ld b, $00 ; $4751
	farcall FlushWram3MapRows ; $4753
	ld a, c ; $4756
	dec a ; $4757
	ld c, a ; $4758
	or a, a ; $4759
	jr nz, Label_3e_4749 ; $475a
	ret ; $475c
HandleMatchRulesToggleInput:
	ld a, [wMenuInputPressed] ; $475d
	bit PADB_LEFT, a ; $4760
	jr nz, Label_3e_4769 ; $4762
	bit 4, a ; $4764
	jr nz, Label_3e_47c0 ; $4766
	ret ; $4768
Label_3e_4769:
	sound $5e ; $4769
	ld c, $01 ; $476b
	call GetMenuCursorIndex_3e ; $476d
	or a, a ; $4770
	jr nz, Label_3e_4787 ; $4771
	ld a, [wMatchFormatDoubles] ; $4773
	xor a, $01 ; $4776
	ld [wMatchFormatDoubles], a ; $4778
	call DrawSinglesDoublesRow ; $477b
	call DrawMatchRulesCaption ; $477e
	ld b, $00 ; $4781
	call FlushMatchRuleRowAttrs ; $4783
	ret ; $4786
Label_3e_4787:
	cp a, $01 ; $4787
	jr nz, Label_3e_479f ; $4789
	ld a, [wMatchFormatGames] ; $478b
	xor a, $01 ; $478e
	ld [wMatchFormatGames], a ; $4790
	call DrawGameCountRow ; $4793
	call DrawMatchRulesCaption ; $4796
	ld b, $01 ; $4799
	call FlushMatchRuleRowAttrs ; $479b
	ret ; $479e
Label_3e_479f:
	ld a, [wMatchFormatSets] ; $479f
	dec a ; $47a2
	add a, a ; $47a3
	jr nc, Label_3e_47ab ; $47a4
	ld a, $03 ; $47a6
	dec a ; $47a8
	jr Label_3e_47b1 ; $47a9
Label_3e_47ab:
	rra ; $47ab
	cp a, $03 ; $47ac
	jr c, Label_3e_47b1 ; $47ae
	xor a, a ; $47b0
Label_3e_47b1:
	ld [wMatchFormatSets], a ; $47b1
	call DrawSetCountRow ; $47b4
	call DrawMatchRulesCaption ; $47b7
	ld b, $02 ; $47ba
	call FlushMatchRuleRowAttrs ; $47bc
	ret ; $47bf
Label_3e_47c0:
	sound $5e ; $47c0
	ld c, $01 ; $47c2
	call GetMenuCursorIndex_3e ; $47c4
	or a, a ; $47c7
	jr nz, Label_3e_47de ; $47c8
	ld a, [wMatchFormatDoubles] ; $47ca
	xor a, $01 ; $47cd
	ld [wMatchFormatDoubles], a ; $47cf
	call DrawSinglesDoublesRow ; $47d2
	call DrawMatchRulesCaption ; $47d5
	ld b, $00 ; $47d8
	call FlushMatchRuleRowAttrs ; $47da
	ret ; $47dd
Label_3e_47de:
	cp a, $01 ; $47de
	jr nz, Label_3e_47f6 ; $47e0
	ld a, [wMatchFormatGames] ; $47e2
	xor a, $01 ; $47e5
	ld [wMatchFormatGames], a ; $47e7
	call DrawGameCountRow ; $47ea
	call DrawMatchRulesCaption ; $47ed
	ld b, $01 ; $47f0
	call FlushMatchRuleRowAttrs ; $47f2
	ret ; $47f5
Label_3e_47f6:
	ld a, [wMatchFormatSets] ; $47f6
	inc a ; $47f9
	add a, a ; $47fa
	jr nc, Label_3e_4802 ; $47fb
	ld a, $03 ; $47fd
	dec a ; $47ff
	jr Label_3e_4808 ; $4800
Label_3e_4802:
	rra ; $4802
	cp a, $03 ; $4803
	jr c, Label_3e_4808 ; $4805
	xor a, a ; $4807
Label_3e_4808:
	ld [wMatchFormatSets], a ; $4808
	call DrawSetCountRow ; $480b
	call DrawMatchRulesCaption ; $480e
	ld b, $02 ; $4811
	call FlushMatchRuleRowAttrs ; $4813
	ret ; $4816
DrawSinglesDoublesRow:
	ld b, $00 ; $4817
	ld c, $00 ; $4819
	call SetMatchRuleOptionAttrRect ; $481b
	ld b, $01 ; $481e
	ld c, $00 ; $4820
	call SetMatchRuleOptionAttrRect ; $4822
	ld a, [wMatchFormatDoubles] ; $4825
	ld b, a ; $4828
	ld c, $01 ; $4829
	call SetMatchRuleOptionAttrRect ; $482b
	ret ; $482e
DrawGameCountRow:
	ld b, $02 ; $482f
	ld c, $00 ; $4831
	call SetMatchRuleOptionAttrRect ; $4833
	ld b, $03 ; $4836
	ld c, $00 ; $4838
	call SetMatchRuleOptionAttrRect ; $483a
	ld a, [wMatchFormatGames] ; $483d
	add a, $02 ; $4840
	ld b, a ; $4842
	ld c, $01 ; $4843
	call SetMatchRuleOptionAttrRect ; $4845
	ret ; $4848
DrawSetCountRow:
	ld b, $04 ; $4849
	ld c, $00 ; $484b
	call SetMatchRuleOptionAttrRect ; $484d
	ld b, $05 ; $4850
	ld c, $00 ; $4852
	call SetMatchRuleOptionAttrRect ; $4854
	ld b, $06 ; $4857
	ld c, $00 ; $4859
	call SetMatchRuleOptionAttrRect ; $485b
	ld a, [wMatchFormatSets] ; $485e
	add a, $04 ; $4861
	ld b, a ; $4863
	ld c, $01 ; $4864
	call SetMatchRuleOptionAttrRect ; $4866
	ret ; $4869
SetMatchRuleOptionAttrRect:
	push af ; $486a
	push bc ; $486b
	push de ; $486c
	push hl ; $486d
	ldh a, [hWramBank] ; $486e
	push af ; $4870
	wram_bank $03 ; $4871
	ld hl, MatchRuleOptionAttrAddrs_3e ; $4877
	ld a, b ; $487a
	add a, a ; $487b
	add a, l ; $487c
	ld l, a ; $487d
	jr nc, .readAddr ; $487e
	inc h ; $4880
.readAddr:
	ld a, [hl+] ; $4881
	ld d, [hl] ; $4882
	ld e, a ; $4883
	ld h, $0d ; $4884
	ld a, c ; $4886
	or a, a ; $4887
	jr z, .fill ; $4888
	ld a, b ; $488a
	ld hl, MatchRuleOptionAttrWidths_3e ; $488b
	add a, l ; $488e
	ld l, a ; $488f
	jr nc, .readWidth ; $4890
	inc h ; $4892
.readWidth:
	ld a, [hl] ; $4893
	ld h, a ; $4894
.fill:
	ld b, $05 ; $4895
	ld c, $03 ; $4897
	farcall FillTilemapRect ; $4899
	pop af ; $489c
	wram_bank ; $489d
	pop hl ; $48a1
	pop de ; $48a2
	pop bc ; $48a3
	pop af ; $48a4
	ret ; $48a5
MatchRuleOptionAttrAddrs_3e:
	; $48a6, 14 bytes (bytes:14)
	db $63, $d4, $6c, $d4, $e3, $d4, $ec, $d4, $61, $d5, $67, $d5, $6d, $d5 ; 0x00
MatchRuleOptionAttrWidths_3e:
	; $48b4, 7 bytes (bytes:7)
	db $0c, $0c, $0e, $0e, $0f, $0f, $0f ; 0x00
FlushMatchRuleRowAttrs:
	push af ; $48bb
	push bc ; $48bc
	push de ; $48bd
	push hl ; $48be
	ld a, b ; $48bf
	or a, a ; $48c0
	jr nz, .row1 ; $48c1
	ld hl, $d460 ; $48c3
	ld de, $b860 ; $48c6
	ld c, $06 ; $48c9
	call QueueVRAMCopy ; $48cb
	jr .done ; $48ce
.row1:
	cp a, $01 ; $48d0
	jr nz, .row2 ; $48d2
	ld hl, $d4e0 ; $48d4
	ld de, $b8e0 ; $48d7
	ld c, $06 ; $48da
	call QueueVRAMCopy ; $48dc
	jr .done ; $48df
.row2:
	ld hl, $d560 ; $48e1
	ld de, $b960 ; $48e4
	ld c, $06 ; $48e7
	call QueueVRAMCopy ; $48e9
.done:
	pop hl ; $48ec
	pop de ; $48ed
	pop bc ; $48ee
	pop af ; $48ef
	ret ; $48f0
MatchRulesCursorSpriteTask:
	ld c, $01 ; $48f1
	call GetMenuCursorIndex_3e ; $48f3
	or a, a ; $48f6
	jr nz, Label_3e_48fe ; $48f7
	ld a, [wMatchFormatDoubles] ; $48f9
	jr Label_3e_490e ; $48fc
Label_3e_48fe:
	cp a, $01 ; $48fe
	jr nz, Label_3e_4909 ; $4900
	ld a, [wMatchFormatGames] ; $4902
	add a, $02 ; $4905
	jr Label_3e_490e ; $4907
Label_3e_4909:
	ld a, [wMatchFormatSets] ; $4909
	add a, $04 ; $490c
Label_3e_490e:
	push af ; $490e
	ld hl, MatchRulesCursorTiles_3e ; $490f
	add a, l ; $4912
	ld l, a ; $4913
	jr nc, Label_3e_4917 ; $4914
	inc h ; $4916
Label_3e_4917:
	ld c, [hl] ; $4917
	pop af ; $4918
	ld hl, MatchRulesCursorPositions_3e ; $4919
	add a, a ; $491c
	add a, l ; $491d
	ld l, a ; $491e
	jr nc, Label_3e_4922 ; $491f
	inc h ; $4921
Label_3e_4922:
	ld a, [hl+] ; $4922
	ld d, [hl] ; $4923
	ld e, a ; $4924
	farcall ApplySpriteBobOffset ; $4925
	ld b, $08 ; $4928
	ld hl, SpriteTemplate_3e_4943 ; $492a
	push de ; $492d
	call QueueSpriteTemplate ; $492e
	pop de ; $4931
	ld hl, $17f8 ; $4932
	add hl, de ; $4935
	ld d, h ; $4936
	ld e, l ; $4937
	ld hl, SpriteTemplate_3e_4964 ; $4938
	ld b, $08 ; $493b
	ld c, $70 ; $493d
	call QueueSpriteTemplate ; $493f
	ret ; $4942
SpriteTemplate_3e_4943:
	; $4943, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
SpriteTemplate_3e_4964:
	; $4964, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
MatchRulesCursorPositions_3e:
	; $496d, 14 bytes (bytes:14)
	db $2d, $0a, $2d, $54, $4f, $0c, $4f, $54, $6a, $00, $6a, $2c, $6a, $5d ; 0x00
MatchRulesCursorTiles_3e:
	; $497b, 7 bytes (bytes:7)
	db $00, $10, $20, $30, $40, $50, $60 ; 0x00
DrawMatchRulesCaption:
	wram_bank $03 ; $4982
	ld de, $d1e0 ; $4988
	ld b, $14 ; $498b
	ld c, $01 ; $498d
	ld h, $03 ; $498f
	farcall FillTilemapRect ; $4991
	ld a, $02 ; $4994
	ld [$d1e0], a ; $4996
	ld a, $04 ; $4999
	ld [$d1f3], a ; $499b
	ld de, $d201 ; $499e
	ld b, $12 ; $49a1
	ld c, $01 ; $49a3
	ld h, $20 ; $49a5
	farcall FillTilemapRect ; $49a7
	farcall RenderMatchFormatOptionText ; $49aa
	ld hl, $d1e0 ; $49ad
	ld de, $99e0 ; $49b0
	ld c, $04 ; $49b3
	call QueueVRAMCopy ; $49b5
	ret ; $49b8
DrawMatchRulesCaptionText:
	wram_bank $03 ; $49b9
	ld c, $01 ; $49bf
	call GetMenuCursorIndex_3e ; $49c1
	ld b, a ; $49c4
	add a, a ; $49c5
	ld hl, MatchRulesCaptionDests_3e ; $49c6
	add a, l ; $49c9
	ld l, a ; $49ca
	jr nc, Label_3e_49ce ; $49cb
	inc h ; $49cd
Label_3e_49ce:
	ld a, [hl+] ; $49ce
	ld d, [hl] ; $49cf
	ld e, a ; $49d0
	ld a, b ; $49d1
	ld hl, $0084 ; $49d2
	add a, l ; $49d5
	ld l, a ; $49d6
	jr nc, Label_3e_49da ; $49d7
	inc h ; $49d9
Label_3e_49da:
	ld c, $20 ; $49da
	farcall RenderTextToBuffer64 ; $49dc
	ret ; $49df
MatchRulesCaptionDests_3e:
	; $49e0, 6 bytes (bytes:6)
	db $01, $d2, $01, $d2, $01, $d2 ; 0x00
ShowLinkMessageScreen:
	push af ; $49e6
	push bc ; $49e7
	push de ; $49e8
	push hl ; $49e9
	ldh a, [hWramBank] ; $49ea
	push af ; $49ec
	call DisableLCDSafely ; $49ed
	call ClearFrameTasks ; $49f0
	call LoadLinkMessageScreen ; $49f3
	xor a, a ; $49f6
	ld [wAnimatedTileSet], a ; $49f7
	ld a, $03 ; $49fa
	ld [wAnimatedTilePeriod], a ; $49fc
	call EnableLCD ; $49ff
	script_fade_in $08 ; $4a02
	call WaitFadeEnd ; $4a07
	pop af ; $4a0a
	wram_bank ; $4a0b
	pop hl ; $4a0f
	pop de ; $4a10
	pop bc ; $4a11
	pop af ; $4a12
	ret ; $4a13
LoadLinkMessageScreen:
	ld c, $11 ; $4a14
	farcall LoadScreenAssetRecord ; $4a16
	farcall ResetTextWindowState ; $4a19
	ld b, $11 ; $4a1c
	ld c, $10 ; $4a1e
	ld de, $9000 ; $4a20
	farcall LoadCompressedTileBlock ; $4a23
	wram_bank $05 ; $4a26
	ld a, $03 ; $4a2c
	ld [wShadowTilemapBank], a ; $4a2e
	ld a, $00 ; $4a31
	ld [wWindowTileAttr], a ; $4a33
	ld d, $00 ; $4a36
	ld e, $0b ; $4a38
	ld b, $14 ; $4a3a
	ld c, $07 ; $4a3c
	farcall CreateWindowFromScreenRect ; $4a3e
	farcall DrawTextWindowFrame ; $4a41
	farcall RedrawWindowRows ; $4a44
	wram_bank $03 ; $4a47
	farcall PrepareGlyphBuffer ; $4a4d
	farcall QueueWram3MapToVRAM ; $4a50
	ret ; $4a53
AnimateLinkStatusPalette:
	push af ; $4a54
	push bc ; $4a55
	push de ; $4a56
	push hl ; $4a57
	ldh a, [hVBlankCounter] ; $4a58
	and a, $1c ; $4a5a
	srl a ; $4a5c
	srl a ; $4a5e
	ld hl, $4a77 ; $4a60
	add a, a ; $4a63
	add a, l ; $4a64
	ld l, a ; $4a65
	jr nc, Label_3e_4a69 ; $4a66
	inc h ; $4a68
Label_3e_4a69:
	ld a, [hl+] ; $4a69
	ld h, [hl] ; $4a6a
	ld l, a ; $4a6b
	ld de, $0501 ; $4a6c
	call LoadPaletteShadow ; $4a6f
	pop hl ; $4a72
	pop de ; $4a73
	pop bc ; $4a74
	pop af ; $4a75
	ret ; $4a76
	; $4a77, 16 bytes (records:2)
	dw $4a87 ; record 0
	dw $4a87 ; record 1
	dw $4a8f ; record 2
	dw $4a8f ; record 3
	dw $4a97 ; record 4
	dw $4a97 ; record 5
	dw $4a9f ; record 6
	dw $4a9f ; record 7
	; $4a87, 32 bytes (bytes:8)
	db $bf, $01, $ff, $0b, $67, $1f, $c8, $6c ; 0x00
	db $bf, $01, $ff, $7f, $67, $1f, $c8, $6c ; 0x08
	db $bf, $01, $ff, $0b, $ff, $7f, $c8, $6c ; 0x10
	db $bf, $01, $ff, $0b, $67, $1f, $ff, $7f ; 0x18
ShowLinkErrorScreen:
	call InitSerialLink ; $4aa7
	call DisableLCDSafely ; $4aaa
	call ClearFrameTasks ; $4aad
	call ClearBothSpriteBuffers ; $4ab0
	xor a, a ; $4ab3
	ldh [hScrollX], a ; $4ab4
	ldh [hScrollY], a ; $4ab6
	call LoadLinkErrorScreen ; $4ab8
	xor a, a ; $4abb
	ld [wAnimatedTileSet], a ; $4abc
	ld a, $05 ; $4abf
	ld [wAnimatedTilePeriod], a ; $4ac1
	call EnableLCD ; $4ac4
	script_fade_in $08 ; $4ac7
	call WaitFadeEnd ; $4acc
Label_3e_4acf:
	call AdvanceFrame ; $4acf
	call AnimateLinkErrorPalette ; $4ad2
	ldh a, [hInputRisingEdge] ; $4ad5
	or a, a ; $4ad7
	jr z, Label_3e_4acf ; $4ad8
	call ClearFrameTasks ; $4ada
	ret ; $4add
LoadLinkErrorScreen:
	ld c, $22 ; $4ade
	farcall LoadScreenAssetRecord ; $4ae0
	farcall ResetTextWindowState ; $4ae3
	ld b, $11 ; $4ae6
	ld c, $10 ; $4ae8
	ld de, $9000 ; $4aea
	farcall LoadCompressedTileBlock ; $4aed
	wram_bank $05 ; $4af0
	ld a, $03 ; $4af6
	ld [wShadowTilemapBank], a ; $4af8
	ld a, $00 ; $4afb
	ld [wWindowTileAttr], a ; $4afd
	ld d, $00 ; $4b00
	ld e, $0d ; $4b02
	ld b, $14 ; $4b04
	ld c, $05 ; $4b06
	farcall CreateWindowFromScreenRect ; $4b08
	farcall DrawTextWindowFrame ; $4b0b
	farcall RedrawWindowRows ; $4b0e
	farcall PrepareGlyphBuffer ; $4b11
	wram_bank $03 ; $4b14
	ld hl, $012b ; $4b1a
	ld de, $d1c1 ; $4b1d
	ld c, $12 ; $4b20
	farcall RenderProportionalTextAt ; $4b22
	ld hl, $012c ; $4b25
	ld de, $d201 ; $4b28
	ld c, $12 ; $4b2b
	farcall RenderProportionalTextAt ; $4b2d
	farcall UploadGlyphBuffer ; $4b30
	farcall QueueWram3MapToVRAM ; $4b33
	ret ; $4b36
AnimateLinkErrorPalette:
	ldh a, [hWramBank] ; $4b37
	push af ; $4b39
	wram_bank $03 ; $4b3a
	ld hl, LinkErrorPalette_3e ; $4b40
	ld de, $d800 ; $4b43
	ld bc, $0008 ; $4b46
	call CopyMemoryBC ; $4b49
	ldh a, [hVBlankCounter] ; $4b4c
	and a, $3c ; $4b4e
	srl a ; $4b50
	srl a ; $4b52
	add a, a ; $4b54
	jr nc, Label_3e_4b5c ; $4b55
	ld a, $0c ; $4b57
	dec a ; $4b59
	jr Label_3e_4b62 ; $4b5a
Label_3e_4b5c:
	rra ; $4b5c
	cp a, $0c ; $4b5d
	jr c, Label_3e_4b62 ; $4b5f
	xor a, a ; $4b61
Label_3e_4b62:
	add a, a ; $4b62
	ld hl, LinkErrorFlashColors_3e ; $4b63
	add a, l ; $4b66
	ld l, a ; $4b67
	jr nc, Label_3e_4b6b ; $4b68
	inc h ; $4b6a
Label_3e_4b6b:
	ld a, [hl+] ; $4b6b
	ld d, [hl] ; $4b6c
	ld e, a ; $4b6d
	ld hl, $d802 ; $4b6e
	ld [hl], e ; $4b71
	inc hl ; $4b72
	ld [hl], d ; $4b73
	ld hl, $d800 ; $4b74
	ld de, $0301 ; $4b77
	call LoadPaletteShadow ; $4b7a
	pop af ; $4b7d
	wram_bank ; $4b7e
	ret ; $4b82
LinkErrorPalette_3e:
	; $4b83, 8 bytes (bytes:8)
	db $9f, $33, $1f, $00, $07, $50, $00, $00 ; 0x00
LinkErrorFlashColors_3e:
	; $4b8b, 24 bytes (bytes:16)
	db $1f, $00, $df, $00, $ff, $01, $bf, $02, $7f, $03, $ff, $03, $ff, $03, $9f, $03 ; 0x00
	db $bf, $02, $ff, $01, $df, $00, $1f, $00 ; 0x10
ShowLinkStatusMessage:
	push bc ; $4ba3
	wram_bank $03 ; $4ba4
	call ClearLinkMessageWindow ; $4baa
	farcall PrepareGlyphBuffer ; $4bad
	wram_bank $03 ; $4bb0
	pop bc ; $4bb6
	ld a, c ; $4bb7
	or a, a ; $4bb8
	jr z, Label_3e_4bc1 ; $4bb9
	cp a, $01 ; $4bbb
	jr z, Label_3e_4bce ; $4bbd
	jr Label_3e_4bdb ; $4bbf
Label_3e_4bc1:
	ld hl, $0129 ; $4bc1
	ld de, $d181 ; $4bc4
	ld c, $12 ; $4bc7
	farcall RenderProportionalTextAt ; $4bc9
	jr Label_3e_4be6 ; $4bcc
Label_3e_4bce:
	ld hl, $012a ; $4bce
	ld de, $d181 ; $4bd1
	ld c, $12 ; $4bd4
	farcall RenderProportionalTextAt ; $4bd6
	jr Label_3e_4be6 ; $4bd9
Label_3e_4bdb:
	ld hl, $0128 ; $4bdb
	ld de, $d181 ; $4bde
	ld c, $12 ; $4be1
	farcall RenderProportionalTextAt ; $4be3
Label_3e_4be6:
	farcall UploadGlyphBuffer ; $4be6
	call FlushLinkMessageRows ; $4be9
	ret ; $4bec
ClearLinkMessageWindow:
	ld de, $d161 ; $4bed
	ld b, $12 ; $4bf0
	ld c, $01 ; $4bf2
	ld h, $03 ; $4bf4
	farcall FillTilemapRect ; $4bf6
	ld de, $d181 ; $4bf9
	ld b, $12 ; $4bfc
	ld c, $05 ; $4bfe
	ld h, $20 ; $4c00
	farcall FillTilemapRect ; $4c02
	ret ; $4c05
FlushLinkMessageRows:
	ld hl, $d160 ; $4c06
	ld de, $9960 ; $4c09
	ld c, $0c ; $4c0c
	call QueueVRAMCopy ; $4c0e
	ret ; $4c11
RunEraseDataConfirmMenu:
	ld hl, rIE ; $4c12
	res 2, [hl] ; $4c15
	wram_bank $03 ; $4c17
	ld a, b ; $4c1d
	ld [$d800], a ; $4c1e
	call DisableLCDSafely ; $4c21
	call ClearFrameTasks ; $4c24
	call LoadEraseDataConfirmScreen ; $4c27
	xor a, a ; $4c2a
	ld [wAnimatedTileSet], a ; $4c2b
	ld a, $01 ; $4c2e
	ld hl, UpdateAnimatedTiles_3e ; $4c30
	call RegisterFrameTask ; $4c33
	ld a, $01 ; $4c36
	ld hl, EraseConfirmCursorSpriteTask ; $4c38
	call RegisterFrameTask ; $4c3b
	call AnimateEraseConfirmPalette ; $4c3e
	call EnableLCD ; $4c41
	script_fade_in $08 ; $4c44
	call WaitFadeEnd ; $4c49
	ld a, $01 ; $4c4c
	ld hl, AnimateEraseConfirmPalette ; $4c4e
	call RegisterFrameTask ; $4c51
	wram_bank $03 ; $4c54
Label_3e_4c5a:
	call AdvanceFrame ; $4c5a
	ldh a, [hInputPressed] ; $4c5d
	ld [wMenuInputPressed], a ; $4c5f
	bit PADB_A, a ; $4c62
	jr nz, Label_3e_4c80 ; $4c64
	bit 1, a ; $4c66
	jr nz, Label_3e_4c9b ; $4c68
	bit 6, a ; $4c6a
	jr nz, Label_3e_4c74 ; $4c6c
	bit 7, a ; $4c6e
	jr nz, Label_3e_4c74 ; $4c70
	jr Label_3e_4c5a ; $4c72
Label_3e_4c74:
	ld a, [wMenuCursorY] ; $4c74
	xor a, $01 ; $4c77
	ld [wMenuCursorY], a ; $4c79
	sound $5e ; $4c7c
	jr Label_3e_4c5a ; $4c7e
Label_3e_4c80:
	ld a, [wMenuCursorY] ; $4c80
	or a, a ; $4c83
	jr nz, Label_3e_4c9b ; $4c84
	sound $60 ; $4c86
	ld hl, rIE ; $4c88
	set 2, [hl] ; $4c8b
	call ClearFrameTasks ; $4c8d
	ld c, $10 ; $4c90
	call BeginFadeOut ; $4c92
	call WaitFadeEnd ; $4c95
	ld a, $01 ; $4c98
	ret ; $4c9a
Label_3e_4c9b:
	sound $62 ; $4c9b
	ld hl, rIE ; $4c9d
	set 2, [hl] ; $4ca0
	call ClearFrameTasks ; $4ca2
	ld c, $10 ; $4ca5
	call BeginFadeOut ; $4ca7
	call WaitFadeEnd ; $4caa
	xor a, a ; $4cad
	ret ; $4cae
LoadEraseDataConfirmScreen:
	ld c, $01 ; $4caf
	ld b, $01 ; $4cb1
	call SetMenuCursorFromIndex_3e ; $4cb3
	ld hl, $a000 ; $4cb6
	ld de, $0801 ; $4cb9
	farcall LoadMenuHandCursorGfx ; $4cbc
	ld a, $0a ; $4cbf
	ld [$cb6c], a ; $4cc1
	ld a, $10 ; $4cc4
	ld [$cb6b], a ; $4cc6
	ld c, $10 ; $4cc9
	farcall LoadScreenAssetRecord ; $4ccb
	wram_bank $03 ; $4cce
	ld de, $d4a3 ; $4cd4
	ld b, $0e ; $4cd7
	ld c, $06 ; $4cd9
	ld h, $00 ; $4cdb
	farcall FillTilemapRect ; $4cdd
	ld de, $d0a3 ; $4ce0
	ld b, $0e ; $4ce3
	ld c, $06 ; $4ce5
	ld h, $20 ; $4ce7
	farcall FillTilemapRect ; $4ce9
	farcall ResetTextWindowState ; $4cec
	ld b, $11 ; $4cef
	ld c, $10 ; $4cf1
	ld de, $9000 ; $4cf3
	farcall LoadCompressedTileBlock ; $4cf6
	wram_bank $05 ; $4cf9
	ld a, $03 ; $4cff
	ld [wShadowTilemapBank], a ; $4d01
	ld a, $00 ; $4d04
	ld [wWindowTileAttr], a ; $4d06
	ld d, $00 ; $4d09
	ld e, $0d ; $4d0b
	ld b, $0f ; $4d0d
	ld c, $05 ; $4d0f
	farcall CreateWindowFromScreenRect ; $4d11
	farcall DrawTextWindowFrame ; $4d14
	farcall RedrawWindowRows ; $4d17
	ld d, $0f ; $4d1a
	ld e, $0d ; $4d1c
	ld b, $05 ; $4d1e
	ld c, $05 ; $4d20
	farcall CreateWindowFromScreenRect ; $4d22
	farcall DrawTextWindowFrame ; $4d25
	farcall RedrawWindowRows ; $4d28
	farcall InitMenuBgScroll ; $4d2b
	ld b, $01 ; $4d2e
	ld c, $01 ; $4d30
	farcall LoadMenuSpritePalettePair ; $4d32
	farcall PrepareGlyphBuffer ; $4d35
	wram_bank $03 ; $4d38
	ld a, [$d800] ; $4d3e
	cp a, $02 ; $4d41
	jr nz, Label_3e_4d7e ; $4d43
	ld hl, $00dd ; $4d45
	ld de, $d0c3 ; $4d48
	ld c, $0e ; $4d4b
	farcall RenderProportionalTextAt ; $4d4d
	ld hl, $00de ; $4d50
	ld de, $d103 ; $4d53
	ld c, $0e ; $4d56
	farcall RenderProportionalTextAt ; $4d58
	ld hl, $00df ; $4d5b
	ld de, $d1c2 ; $4d5e
	ld c, $0e ; $4d61
	farcall RenderProportionalTextAt ; $4d63
	ld hl, $00dc ; $4d66
	ld de, $d202 ; $4d69
	ld c, $0e ; $4d6c
	farcall RenderProportionalTextAt ; $4d6e
	ld b, $41 ; $4d71
	ld c, $14 ; $4d73
	ld de, $8000 ; $4d75
	farcall LoadCompressedTileBlock ; $4d78
	jp Label_3e_4def ; $4d7b
Label_3e_4d7e:
	or a, a ; $4d7e
	jr z, Label_3e_4db9 ; $4d7f
	ld hl, $00d8 ; $4d81
	ld de, $d0c3 ; $4d84
	ld c, $0e ; $4d87
	farcall RenderProportionalTextAt ; $4d89
	ld hl, $00d9 ; $4d8c
	ld de, $d103 ; $4d8f
	ld c, $0e ; $4d92
	farcall RenderProportionalTextAt ; $4d94
	ld hl, $00db ; $4d97
	ld de, $d1c2 ; $4d9a
	ld c, $0e ; $4d9d
	farcall RenderProportionalTextAt ; $4d9f
	ld hl, $00dc ; $4da2
	ld de, $d202 ; $4da5
	ld c, $0e ; $4da8
	farcall RenderProportionalTextAt ; $4daa
	ld b, $45 ; $4dad
	ld c, $14 ; $4daf
	ld de, $8000 ; $4db1
	farcall LoadCompressedTileBlock ; $4db4
	jr Label_3e_4def ; $4db7
Label_3e_4db9:
	ld hl, $00d6 ; $4db9
	ld de, $d0c3 ; $4dbc
	ld c, $0e ; $4dbf
	farcall RenderProportionalTextAt ; $4dc1
	ld hl, $00d7 ; $4dc4
	ld de, $d103 ; $4dc7
	ld c, $0e ; $4dca
	farcall RenderProportionalTextAt ; $4dcc
	ld hl, $00da ; $4dcf
	ld de, $d1c2 ; $4dd2
	ld c, $0e ; $4dd5
	farcall RenderProportionalTextAt ; $4dd7
	ld hl, $00dc ; $4dda
	ld de, $d202 ; $4ddd
	ld c, $0e ; $4de0
	farcall RenderProportionalTextAt ; $4de2
	ld b, $46 ; $4de5
	ld c, $14 ; $4de7
	ld de, $8000 ; $4de9
	farcall LoadCompressedTileBlock ; $4dec
Label_3e_4def:
	ld hl, $007a ; $4def
	ld de, $d1d0 ; $4df2
	ld c, $04 ; $4df5
	farcall RenderProportionalTextAt ; $4df7
	ld hl, $007b ; $4dfa
	ld de, $d210 ; $4dfd
	ld c, $04 ; $4e00
	farcall RenderProportionalTextAt ; $4e02
	farcall UploadGlyphBuffer ; $4e05
	farcall QueueWram3MapToVRAM ; $4e08
	ret ; $4e0b
EraseConfirmCursorSpriteTask:
	ld de, $7376 ; $4e0c
	ld a, [wMenuCursorY] ; $4e0f
	or a, a ; $4e12
	jr z, Label_3e_4e18 ; $4e13
	ld de, $7386 ; $4e15
Label_3e_4e18:
	call QueueEraseConfirmCursorSprites ; $4e18
	ret ; $4e1b
QueueEraseConfirmCursorSprites:
	ld c, $00 ; $4e1c
	ld b, $08 ; $4e1e
	push de ; $4e20
	call QueueSprite ; $4e21
	pop de ; $4e24
	ld a, $08 ; $4e25
	add a, d ; $4e27
	ld d, a ; $4e28
	ld c, $02 ; $4e29
	ld b, $08 ; $4e2b
	call QueueSprite ; $4e2d
	farcall TickMenuBgScroll ; $4e30
	ret ; $4e33
AnimateEraseConfirmPalette:
	ldh a, [hWramBank] ; $4e34
	push af ; $4e36
	wram_bank $03 ; $4e37
	ld hl, EraseConfirmPalette_3e ; $4e3d
	ld de, $d810 ; $4e40
	ld bc, $0008 ; $4e43
	call CopyMemoryBC ; $4e46
	ldh a, [hVBlankCounter] ; $4e49
	and a, $3c ; $4e4b
	srl a ; $4e4d
	srl a ; $4e4f
	add a, a ; $4e51
	jr nc, Label_3e_4e59 ; $4e52
	ld a, $0c ; $4e54
	dec a ; $4e56
	jr Label_3e_4e5f ; $4e57
Label_3e_4e59:
	rra ; $4e59
	cp a, $0c ; $4e5a
	jr c, Label_3e_4e5f ; $4e5c
	xor a, a ; $4e5e
Label_3e_4e5f:
	add a, a ; $4e5f
	ld hl, EraseConfirmFlashColors_3e ; $4e60
	add a, l ; $4e63
	ld l, a ; $4e64
	jr nc, Label_3e_4e68 ; $4e65
	inc h ; $4e67
Label_3e_4e68:
	ld a, [hl+] ; $4e68
	ld d, [hl] ; $4e69
	ld e, a ; $4e6a
	ld hl, $d814 ; $4e6b
	ld [hl], e ; $4e6e
	inc hl ; $4e6f
	ld [hl], d ; $4e70
	ld hl, $d810 ; $4e71
	ld de, $0401 ; $4e74
	call LoadPaletteShadow ; $4e77
	pop af ; $4e7a
	wram_bank ; $4e7b
	ret ; $4e7f
EraseConfirmPalette_3e:
	; $4e80, 8 bytes (bytes:8)
	db $48, $00, $13, $3e, $ff, $7f, $bf, $01 ; 0x00
EraseConfirmFlashColors_3e:
	; $4e88, 24 bytes (bytes:16)
	db $1f, $00, $df, $00, $ff, $01, $bf, $02, $7f, $03, $ff, $03, $ff, $03, $9f, $03 ; 0x00
	db $bf, $02, $ff, $01, $df, $00, $1f, $00 ; 0x10
RunRacketShoesChoiceMenu:
	sound $03 ; $4ea0
	ld hl, rIE ; $4ea2
	res 2, [hl] ; $4ea5
	call LoadRacketShoesChoiceGraphics ; $4ea7
	wram_bank $03 ; $4eaa
	ld a, [wMenuSlideDirection] ; $4eb0
	ld b, a ; $4eb3
	call OpenChoiceTabPanel ; $4eb4
	farcall InitMenuBgScroll ; $4eb7
	ld b, $01 ; $4eba
	ld c, $01 ; $4ebc
	farcall LoadMenuSpritePalettePair ; $4ebe
	ld a, [$cb24] ; $4ec1
	ld c, a ; $4ec4
	ld b, $02 ; $4ec5
	call SetMenuCursorFromIndex_3e ; $4ec7
	ld a, $01 ; $4eca
	ld hl, ChoiceTabCursorSpriteTask ; $4ecc
	call RegisterFrameTask ; $4ecf
	call RedrawRacketShoesChoiceMenu ; $4ed2
	wram_bank $03 ; $4ed5
Label_3e_4edb:
	call AdvanceFrame ; $4edb
	ldh a, [hInputPressed] ; $4ede
	ld [wMenuInputPressed], a ; $4ee0
	ld b, $02 ; $4ee3
	ld c, $01 ; $4ee5
	call MoveMenuCursorGrid_3e ; $4ee7
	or a, a ; $4eea
	jr z, Label_3e_4ef2 ; $4eeb
	sound $5e ; $4eed
	call RedrawRacketShoesChoiceMenu ; $4eef
Label_3e_4ef2:
	ld a, [wMenuInputPressed] ; $4ef2
	bit PADB_A, a ; $4ef5
	jr nz, Label_3e_4eff ; $4ef7
	bit 1, a ; $4ef9
	jr nz, Label_3e_4f1c ; $4efb
	jr Label_3e_4edb ; $4efd
Label_3e_4eff:
	sound $5f ; $4eff
	call ClearFrameTasks ; $4f01
	ld hl, rIE ; $4f04
	set 2, [hl] ; $4f07
	ld b, $01 ; $4f09
	call CloseChoiceTabPanel ; $4f0b
	ld a, $01 ; $4f0e
	ld [wMenuSlideDirection], a ; $4f10
	ld c, $02 ; $4f13
	call GetMenuCursorIndex_3e ; $4f15
	ld [$cb24], a ; $4f18
	ret ; $4f1b
Label_3e_4f1c:
	sound $62 ; $4f1c
	call ClearFrameTasks ; $4f1e
	ld hl, rIE ; $4f21
	set 2, [hl] ; $4f24
	ld b, $00 ; $4f26
	call CloseChoiceTabPanel ; $4f28
	ld a, $00 ; $4f2b
	ld [wMenuSlideDirection], a ; $4f2d
	ld a, $ff ; $4f30
	ret ; $4f32
LoadRacketShoesChoiceGraphics:
	ldh a, [hWramBank] ; $4f33
	push af ; $4f35
	wram_bank $01 ; $4f36
	ld c, $00 ; $4f3c
Label_3e_4f3e:
	ld a, c ; $4f3e
	add a, a ; $4f3f
	ld hl, RacketShoesChoiceGfxParams_3e ; $4f40
	add a, l ; $4f43
	ld l, a ; $4f44
	jr nc, Label_3e_4f48 ; $4f45
	inc h ; $4f47
Label_3e_4f48:
	ld a, [hl+] ; $4f48
	ld h, [hl] ; $4f49
	ld l, a ; $4f4a
	push af ; $4f4b
	push bc ; $4f4c
	push de ; $4f4d
	push hl ; $4f4e
	ld de, $d000 ; $4f4f
	call DecompressDataFromBank ; $4f52
	pop hl ; $4f55
	pop de ; $4f56
	pop bc ; $4f57
	pop af ; $4f58
	ld hl, RacketShoesChoiceGfxDests_3e ; $4f59
	ld a, c ; $4f5c
	add a, a ; $4f5d
	add a, l ; $4f5e
	ld l, a ; $4f5f
	jr nc, Label_3e_4f63 ; $4f60
	inc h ; $4f62
Label_3e_4f63:
	ld a, [hl+] ; $4f63
	ld d, [hl] ; $4f64
	ld e, a ; $4f65
	ld hl, $d000 ; $4f66
	push af ; $4f69
	push bc ; $4f6a
	push de ; $4f6b
	push hl ; $4f6c
	ld bc, $0010 ; $4f6d
	call QueueVRAMCopy ; $4f70
	pop hl ; $4f73
	pop de ; $4f74
	pop bc ; $4f75
	pop af ; $4f76
	ld a, c ; $4f77
	inc a ; $4f78
	ld c, a ; $4f79
	call AdvanceFrame ; $4f7a
	ld a, c ; $4f7d
	cp a, $02 ; $4f7e
	jr nz, Label_3e_4f3e ; $4f80
	ld b, $4a ; $4f82
	ld c, $10 ; $4f84
	ld de, $a000 ; $4f86
	farcall LoadCompressedTileBlock ; $4f89
	call AdvanceFrame ; $4f8c
	ld b, $4b ; $4f8f
	ld c, $10 ; $4f91
	ld de, $a100 ; $4f93
	farcall LoadCompressedTileBlock ; $4f96
	call AdvanceFrame ; $4f99
	ld b, $1b ; $4f9c
	ld c, $04 ; $4f9e
	ld de, $a700 ; $4fa0
	farcall LoadCompressedTileBlock ; $4fa3
	call AdvanceFrame ; $4fa6
	ld b, $4c ; $4fa9
	ld c, $14 ; $4fab
	ld de, $8000 ; $4fad
	farcall LoadCompressedTileBlock ; $4fb0
	call AdvanceFrame ; $4fb3
	ld b, $08 ; $4fb6
	ld c, $10 ; $4fb8
	farcall LoadIndexedPalette ; $4fba
	pop af ; $4fbd
	wram_bank ; $4fbe
	ret ; $4fc2
RacketShoesChoiceGfxParams_3e:
	; $4fc3, 6 bytes (bytes:6)
	db $54, $3d, $56, $3d, $04, $3d ; 0x00
RacketShoesChoiceGfxDests_3e:
	; $4fc9, 6 bytes (bytes:6)
	db $00, $a8, $00, $a9, $00, $aa ; 0x00
RedrawRacketShoesChoiceMenu:
	wram_bank $03 ; $4fcf
	ld b, $00 ; $4fd5
	ld c, $00 ; $4fd7
Label_3e_4fd9:
	call SetChoiceTabAttrRect ; $4fd9
	ld a, b ; $4fdc
	inc a ; $4fdd
	ld b, a ; $4fde
	cp a, $03 ; $4fdf
	jr nz, Label_3e_4fd9 ; $4fe1
	ld c, $02 ; $4fe3
	call GetMenuCursorIndex_3e ; $4fe5
	ld b, a ; $4fe8
	ld c, $01 ; $4fe9
	call SetChoiceTabAttrRect ; $4feb
	ld c, $02 ; $4fee
	call GetMenuCursorIndex_3e ; $4ff0
	call SetRacketShoesChoicePalette ; $4ff3
	wram_bank $03 ; $4ff6
	ld de, $d1e0 ; $4ffc
	ld b, $14 ; $4fff
	ld c, $01 ; $5001
	ld h, $03 ; $5003
	farcall FillTilemapRect ; $5005
	ld a, $02 ; $5008
	ld [$d1e0], a ; $500a
	ld a, $04 ; $500d
	ld [$d1f3], a ; $500f
	ld de, $d201 ; $5012
	ld b, $12 ; $5015
	ld c, $01 ; $5017
	ld h, $20 ; $5019
	farcall FillTilemapRect ; $501b
	call DrawRacketShoesChoiceCaption ; $501e
	ld hl, $d4e0 ; $5021
	ld de, $b8e0 ; $5024
	ld c, $06 ; $5027
	call QueueVRAMCopy ; $5029
	ld hl, $d1e0 ; $502c
	ld de, $99e0 ; $502f
	ld c, $04 ; $5032
	call QueueVRAMCopy ; $5034
	ret ; $5037
SetRacketShoesChoicePalette:
	ld hl, $504b ; $5038
	add a, a ; $503b
	add a, l ; $503c
	ld l, a ; $503d
	jr nc, Label_3e_5041 ; $503e
	inc h ; $5040
Label_3e_5041:
	ld a, [hl+] ; $5041
	ld h, [hl] ; $5042
	ld l, a ; $5043
	ld de, $0401 ; $5044
	call LoadPaletteShadow ; $5047
	ret ; $504a
	; $504b, 18 bytes (records:2)
	dw $505d ; record 0
	dw $5065 ; record 1
	dw $505d ; record 2
	dw $505d ; record 3
	dw $505d ; record 4
	dw $505d ; record 5
	dw $505d ; record 6
	dw $505d ; record 7
	dw $505d ; record 8
	; $505d, 16 bytes (bytes:8)
	db $df, $02, $ff, $7f, $a0, $01, $00, $00 ; 0x00
	db $0a, $03, $ff, $7f, $40, $51, $00, $00 ; 0x08
DrawRacketShoesChoiceCaption:
	ldh a, [hWramBank] ; $506d
	push af ; $506f
	wram_bank $03 ; $5070
	ld c, $02 ; $5076
	call GetMenuCursorIndex_3e ; $5078
	ld b, a ; $507b
	ld hl, $00e0 ; $507c
	add a, l ; $507f
	ld l, a ; $5080
	jr nc, Label_3e_5084 ; $5081
	inc h ; $5083
Label_3e_5084:
	ld de, $d201 ; $5084
	ld c, $20 ; $5087
	farcall RenderTextToBuffer64 ; $5089
	pop af ; $508c
	wram_bank ; $508d
	ret ; $5091
OpenChoiceTabPanel:
	ld a, b ; $5092
	or a, a ; $5093
	jr z, Label_3e_50ad ; $5094
	ld c, $00 ; $5096
Label_3e_5098:
	call AdvanceFrame ; $5098
	ld b, $10 ; $509b
	farcall RestoreMenuBgAndDrawPanel ; $509d
	ld b, $03 ; $50a0
	farcall FlushWram3MapRows ; $50a2
	ld a, c ; $50a5
	inc a ; $50a6
	ld c, a ; $50a7
	cp a, $0c ; $50a8
	jr nz, Label_3e_5098 ; $50aa
	ret ; $50ac
Label_3e_50ad:
	ld c, $08 ; $50ad
Label_3e_50af:
	call AdvanceFrame ; $50af
	ld b, $11 ; $50b2
	farcall RestoreMenuBgAndDrawPanel ; $50b4
	ld b, $03 ; $50b7
	farcall FlushWram3MapRows ; $50b9
	ld a, c ; $50bc
	dec a ; $50bd
	ld c, a ; $50be
	cp a, $ff ; $50bf
	jr nz, Label_3e_50af ; $50c1
	ret ; $50c3
CloseChoiceTabPanel:
	ld a, b ; $50c4
	or a, a ; $50c5
	jr z, Label_3e_50df ; $50c6
	ld c, $00 ; $50c8
Label_3e_50ca:
	call AdvanceFrame ; $50ca
	ld b, $11 ; $50cd
	farcall RestoreMenuBgAndDrawPanel ; $50cf
	ld b, $03 ; $50d2
	farcall FlushWram3MapRows ; $50d4
	ld a, c ; $50d7
	inc a ; $50d8
	ld c, a ; $50d9
	cp a, $0a ; $50da
	jr nz, Label_3e_50ca ; $50dc
	ret ; $50de
Label_3e_50df:
	ld c, $0c ; $50df
Label_3e_50e1:
	call AdvanceFrame ; $50e1
	ld b, $10 ; $50e4
	farcall RestoreMenuBgAndDrawPanel ; $50e6
	ld b, $03 ; $50e9
	farcall FlushWram3MapRows ; $50eb
	ld a, c ; $50ee
	dec a ; $50ef
	ld c, a ; $50f0
	or a, a ; $50f1
	jr nz, Label_3e_50e1 ; $50f2
	ret ; $50f4
ChoiceTabCursorSpriteTask:
	farcall TickMenuBgScroll ; $50f5
	ld c, $02 ; $50f8
	call GetMenuCursorIndex_3e ; $50fa
	push af ; $50fd
	ld hl, ChoiceTabCursorTiles_3e ; $50fe
	add a, l ; $5101
	ld l, a ; $5102
	jr nc, Label_3e_5106 ; $5103
	inc h ; $5105
Label_3e_5106:
	ld c, [hl] ; $5106
	pop af ; $5107
	ld hl, ChoiceTabCursorPositions_3e ; $5108
	add a, a ; $510b
	add a, l ; $510c
	ld l, a ; $510d
	jr nc, Label_3e_5111 ; $510e
	inc h ; $5110
Label_3e_5111:
	ld a, [hl+] ; $5111
	ld d, [hl] ; $5112
	ld e, a ; $5113
	farcall ApplySpriteBobOffset ; $5114
	ld b, $08 ; $5117
	ld hl, SpriteTemplate_3e_5132 ; $5119
	push de ; $511c
	call QueueSpriteTemplate ; $511d
	pop de ; $5120
	ld hl, $17f8 ; $5121
	add hl, de ; $5124
	ld d, h ; $5125
	ld e, l ; $5126
	ld hl, SpriteTemplate_3e_5153 ; $5127
	ld b, $08 ; $512a
	ld c, $70 ; $512c
	call QueueSpriteTemplate ; $512e
	ret ; $5131
SpriteTemplate_3e_5132:
	; $5132, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
SpriteTemplate_3e_5153:
	; $5153, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
ChoiceTabCursorPositions_3e:
	; $515c, 6 bytes (bytes:6)
	db $50, $0c, $50, $54, $50, $5c ; 0x00
ChoiceTabCursorTiles_3e:
	; $5162, 3 bytes (bytes:3)
	db $00, $10, $20 ; 0x00
SetChoiceTabAttrRect:
	push af ; $5165
	push bc ; $5166
	push de ; $5167
	push hl ; $5168
	ld a, c ; $5169
	or a, a ; $516a
	jr z, Label_3e_5171 ; $516b
	ld h, $0c ; $516d
	jr Label_3e_5173 ; $516f
Label_3e_5171:
	ld h, $0d ; $5171
Label_3e_5173:
	push hl ; $5173
	ld hl, ChoiceTabAttrAddrs_3e ; $5174
	ld a, b ; $5177
	add a, a ; $5178
	add a, l ; $5179
	ld l, a ; $517a
	jr nc, Label_3e_517e ; $517b
	inc h ; $517d
Label_3e_517e:
	ld a, [hl+] ; $517e
	ld d, [hl] ; $517f
	ld e, a ; $5180
	pop hl ; $5181
	ld b, $05 ; $5182
	ld c, $03 ; $5184
	farcall FillTilemapRect ; $5186
	pop hl ; $5189
	pop de ; $518a
	pop bc ; $518b
	pop af ; $518c
	ret ; $518d
ChoiceTabAttrAddrs_3e:
	; $518e, 4 bytes (bytes:4)
	db $e3, $d4, $ec, $d4 ; 0x00
RunPlayAlonePartnerMenu:
	sound $03 ; $5192
	ld hl, rIE ; $5194
	res 2, [hl] ; $5197
	call LoadPlayAlonePartnerGraphics ; $5199
	wram_bank $03 ; $519c
	ld a, [wMenuSlideDirection] ; $51a2
	ld b, a ; $51a5
	call OpenChoiceTabPanel ; $51a6
	farcall InitMenuBgScroll ; $51a9
	ld b, $01 ; $51ac
	ld c, $01 ; $51ae
	farcall LoadMenuSpritePalettePair ; $51b0
	xor a, a ; $51b3
	ld c, a ; $51b4
	ld b, $02 ; $51b5
	call SetMenuCursorFromIndex_3e ; $51b7
	ld a, $01 ; $51ba
	ld hl, ChoiceTabCursorSpriteTask ; $51bc
	call RegisterFrameTask ; $51bf
	call RedrawPlayAlonePartnerMenu ; $51c2
	wram_bank $03 ; $51c5
Label_3e_51cb:
	call AdvanceFrame ; $51cb
	ldh a, [hInputPressed] ; $51ce
	ld [wMenuInputPressed], a ; $51d0
	ld b, $02 ; $51d3
	ld c, $01 ; $51d5
	call MoveMenuCursorGrid_3e ; $51d7
	or a, a ; $51da
	jr z, Label_3e_51e2 ; $51db
	sound $5e ; $51dd
	call RedrawPlayAlonePartnerMenu ; $51df
Label_3e_51e2:
	ld a, [wMenuInputPressed] ; $51e2
	bit PADB_A, a ; $51e5
	jr nz, Label_3e_51ef ; $51e7
	bit 1, a ; $51e9
	jr nz, Label_3e_5212 ; $51eb
	jr Label_3e_51cb ; $51ed
Label_3e_51ef:
	sound $5f ; $51ef
	call ClearFrameTasks ; $51f1
	ld hl, rIE ; $51f4
	set 2, [hl] ; $51f7
	ld b, $01 ; $51f9
	call CloseChoiceTabPanel ; $51fb
	ld a, $01 ; $51fe
	ld [wMenuSlideDirection], a ; $5200
	ld c, $02 ; $5203
	call GetMenuCursorIndex_3e ; $5205
	clear_flag FLAG_DOUBLES ; $5208
	or a, a ; $520b
	jr z, Label_3e_5211 ; $520c
	set_flag FLAG_DOUBLES ; $520e
Label_3e_5211:
	ret ; $5211
Label_3e_5212:
	sound $62 ; $5212
	call ClearFrameTasks ; $5214
	ld hl, rIE ; $5217
	set 2, [hl] ; $521a
	ld b, $00 ; $521c
	call CloseChoiceTabPanel ; $521e
	ld a, $00 ; $5221
	ld [wMenuSlideDirection], a ; $5223
	ld a, $ff ; $5226
	ret ; $5228
LoadPlayAlonePartnerGraphics:
	ldh a, [hWramBank] ; $5229
	push af ; $522b
	wram_bank $01 ; $522c
	ld c, $00 ; $5232
Label_3e_5234:
	ld a, c ; $5234
	add a, a ; $5235
	ld hl, PlayAlonePartnerGfxParams_3e ; $5236
	add a, l ; $5239
	ld l, a ; $523a
	jr nc, Label_3e_523e ; $523b
	inc h ; $523d
Label_3e_523e:
	ld a, [hl+] ; $523e
	ld h, [hl] ; $523f
	ld l, a ; $5240
	push af ; $5241
	push bc ; $5242
	push de ; $5243
	push hl ; $5244
	ld de, $d000 ; $5245
	call DecompressDataFromBank ; $5248
	pop hl ; $524b
	pop de ; $524c
	pop bc ; $524d
	pop af ; $524e
	ld hl, PlayAlonePartnerGfxDests_3e ; $524f
	ld a, c ; $5252
	add a, a ; $5253
	add a, l ; $5254
	ld l, a ; $5255
	jr nc, Label_3e_5259 ; $5256
	inc h ; $5258
Label_3e_5259:
	ld a, [hl+] ; $5259
	ld d, [hl] ; $525a
	ld e, a ; $525b
	ld hl, $d000 ; $525c
	push af ; $525f
	push bc ; $5260
	push de ; $5261
	push hl ; $5262
	ld bc, $0010 ; $5263
	call QueueVRAMCopy ; $5266
	pop hl ; $5269
	pop de ; $526a
	pop bc ; $526b
	pop af ; $526c
	ld a, c ; $526d
	inc a ; $526e
	ld c, a ; $526f
	call AdvanceFrame ; $5270
	ld a, c ; $5273
	cp a, $02 ; $5274
	jr nz, Label_3e_5234 ; $5276
	ld b, $23 ; $5278
	ld c, $10 ; $527a
	ld de, $a000 ; $527c
	farcall LoadCompressedTileBlock ; $527f
	call AdvanceFrame ; $5282
	ld b, $24 ; $5285
	ld c, $10 ; $5287
	ld de, $a100 ; $5289
	farcall LoadCompressedTileBlock ; $528c
	call AdvanceFrame ; $528f
	ld b, $1b ; $5292
	ld c, $04 ; $5294
	ld de, $a700 ; $5296
	farcall LoadCompressedTileBlock ; $5299
	call AdvanceFrame ; $529c
	call AdvanceFrame ; $529f
	ld b, $08 ; $52a2
	ld c, $10 ; $52a4
	farcall LoadIndexedPalette ; $52a6
	pop af ; $52a9
	wram_bank ; $52aa
	ret ; $52ae
PlayAlonePartnerGfxParams_3e:
	; $52af, 4 bytes (bytes:4)
	db $62, $3c, $64, $3c ; 0x00
PlayAlonePartnerGfxDests_3e:
	; $52b3, 4 bytes (bytes:4)
	db $00, $a8, $00, $a9 ; 0x00
RedrawPlayAlonePartnerMenu:
	wram_bank $03 ; $52b7
	ld b, $00 ; $52bd
	ld c, $00 ; $52bf
Label_3e_52c1:
	call SetChoiceTabAttrRect ; $52c1
	ld a, b ; $52c4
	inc a ; $52c5
	ld b, a ; $52c6
	cp a, $03 ; $52c7
	jr nz, Label_3e_52c1 ; $52c9
	ld c, $02 ; $52cb
	call GetMenuCursorIndex_3e ; $52cd
	ld b, a ; $52d0
	ld c, $01 ; $52d1
	call SetChoiceTabAttrRect ; $52d3
	ld c, $02 ; $52d6
	call GetMenuCursorIndex_3e ; $52d8
	call SetPlayAlonePartnerPalette ; $52db
	wram_bank $03 ; $52de
	ld de, $d1e0 ; $52e4
	ld b, $14 ; $52e7
	ld c, $01 ; $52e9
	ld h, $03 ; $52eb
	farcall FillTilemapRect ; $52ed
	ld a, $02 ; $52f0
	ld [$d1e0], a ; $52f2
	ld a, $04 ; $52f5
	ld [$d1f3], a ; $52f7
	ld de, $d201 ; $52fa
	ld b, $12 ; $52fd
	ld c, $01 ; $52ff
	ld h, $20 ; $5301
	farcall FillTilemapRect ; $5303
	call DrawPlayAlonePartnerCaption ; $5306
	ld hl, $d4e0 ; $5309
	ld de, $b8e0 ; $530c
	ld c, $06 ; $530f
	call QueueVRAMCopy ; $5311
	ld hl, $d1e0 ; $5314
	ld de, $99e0 ; $5317
	ld c, $04 ; $531a
	call QueueVRAMCopy ; $531c
	ret ; $531f
SetPlayAlonePartnerPalette:
	ld hl, $5333 ; $5320
	add a, a ; $5323
	add a, l ; $5324
	ld l, a ; $5325
	jr nc, Label_3e_5329 ; $5326
	inc h ; $5328
Label_3e_5329:
	ld a, [hl+] ; $5329
	ld h, [hl] ; $532a
	ld l, a ; $532b
	ld de, $0401 ; $532c
	call LoadPaletteShadow ; $532f
	ret ; $5332
	; $5333, 18 bytes (records:2)
	dw $5345 ; record 0
	dw $5345 ; record 1
	dw $5345 ; record 2
	dw $5345 ; record 3
	dw $5345 ; record 4
	dw $5345 ; record 5
	dw $5345 ; record 6
	dw $5345 ; record 7
	dw $5345 ; record 8
	; $5345, 16 bytes (bytes:8)
	db $df, $02, $ff, $7f, $a0, $01, $00, $00 ; 0x00
	db $0a, $03, $ff, $7f, $40, $51, $00, $00 ; 0x08
DrawPlayAlonePartnerCaption:
	ldh a, [hWramBank] ; $5355
	push af ; $5357
	wram_bank $03 ; $5358
	ld c, $02 ; $535e
	call GetMenuCursorIndex_3e ; $5360
	ld b, a ; $5363
	ld hl, PlayAlonePartnerCaptionDests_3e ; $5364
	add a, a ; $5367
	add a, l ; $5368
	ld l, a ; $5369
	jr nc, Label_3e_536d ; $536a
	inc h ; $536c
Label_3e_536d:
	ld a, [hl+] ; $536d
	ld d, [hl] ; $536e
	ld e, a ; $536f
	ld a, b ; $5370
	ld hl, $00e2 ; $5371
	add a, l ; $5374
	ld l, a ; $5375
	jr nc, Label_3e_5379 ; $5376
	inc h ; $5378
Label_3e_5379:
	ld c, $20 ; $5379
	farcall RenderTextToBuffer64 ; $537b
	pop af ; $537e
	wram_bank ; $537f
	ret ; $5383
PlayAlonePartnerCaptionDests_3e:
	; $5384, 4 bytes (bytes:4)
	db $01, $d2, $01, $d2 ; 0x00
ShowEquipmentStatusScreen:
	call ClearFrameTasks ; $5388
	ld c, $10 ; $538b
	call BeginFadeOut ; $538d
	call WaitFadeEnd ; $5390
	call AdvanceFrame ; $5393
	call AdvanceFrame ; $5396
	call DisableLCDSafely ; $5399
	farcall LoadMenuFontGfx ; $539c
	xor a, a ; $539f
	ldh [hScrollX], a ; $53a0
	ldh [hScrollY], a ; $53a2
	call DrawEquipmentStatusScreen ; $53a4
	call EnableLCD ; $53a7
	script_fade_in $10 ; $53aa
	call WaitFadeEnd ; $53af
Label_3e_53b2:
	ldh a, [hInputPressed] ; $53b2
	bit PADB_A, a ; $53b4
	jr nz, Label_3e_53c1 ; $53b6
	bit 1, a ; $53b8
	jr nz, Label_3e_53c1 ; $53ba
	call AdvanceFrame ; $53bc
	jr Label_3e_53b2 ; $53bf
Label_3e_53c1:
	sound $5f ; $53c1
	call ClearFrameTasks ; $53c3
	ld c, $10 ; $53c6
	call BeginFadeOut ; $53c8
	call WaitFadeEnd ; $53cb
	ret ; $53ce
DrawEquipmentStatusScreen:
	call LoadEquipmentStatusWindows ; $53cf
	farcall PrepareGlyphBuffer ; $53d2
	wram_bank $03 ; $53d5
	ld hl, $d800 ; $53db
	ld bc, $0003 ; $53de
	call ClearMemory16 ; $53e1
	call DrawEquippedRacketPanel ; $53e4
	call DrawEquippedShoesPanel ; $53e7
	farcall UploadGlyphBuffer ; $53ea
	farcall QueueWram3MapToVRAM ; $53ed
	ret ; $53f0
LoadEquipmentStatusWindows:
	ld c, $21 ; $53f1
	farcall LoadScreenAssetRecord ; $53f3
	farcall ResetTextWindowState ; $53f6
	ld b, $11 ; $53f9
	ld c, $10 ; $53fb
	ld de, $9000 ; $53fd
	farcall LoadCompressedTileBlock ; $5400
	wram_bank $05 ; $5403
	ld a, $03 ; $5409
	ld [wShadowTilemapBank], a ; $540b
	ld a, $00 ; $540e
	ld [wWindowTileAttr], a ; $5410
	ld d, $00 ; $5413
	ld e, $00 ; $5415
	ld b, $14 ; $5417
	ld c, $09 ; $5419
	farcall CreateWindowFromScreenRect ; $541b
	farcall DrawTextWindowFrame ; $541e
	farcall RedrawWindowRows ; $5421
	ld d, $00 ; $5424
	ld e, $09 ; $5426
	ld b, $14 ; $5428
	ld c, $09 ; $542a
	farcall CreateWindowFromScreenRect ; $542c
	farcall DrawTextWindowFrame ; $542f
	farcall RedrawWindowRows ; $5432
	call SetEquipmentStatusAttrRects ; $5435
	ret ; $5438
SetEquipmentStatusAttrRects:
	wram_bank $03 ; $5439
	ld de, $d581 ; $543f
	ld b, $12 ; $5442
	ld c, $05 ; $5444
	ld h, $08 ; $5446
	farcall FillTilemapRect ; $5448
	ld de, $d461 ; $544b
	ld b, $12 ; $544e
	ld c, $05 ; $5450
	ld h, $08 ; $5452
	farcall FillTilemapRect ; $5454
	ret ; $5457
DrawEquippedRacketPanel:
	ld a, $00 ; $5458
	ld [$d813], a ; $545a
	call MarkOwnedRackets ; $545d
	call BuildOwnedItemList ; $5460
	ld a, $01 ; $5463
	ld [$d814], a ; $5465
	ld a, [$d811] ; $5468
	ld [wMenuCursorX], a ; $546b
	call GetEquippedItemId ; $546e
	ld c, a ; $5471
	ld de, $d025 ; $5472
	call DrawItemIcon2x2 ; $5475
	call GetEquippedItemId ; $5478
	ld c, a ; $547b
	ld de, $d028 ; $547c
	call RenderRacketNameText ; $547f
	call DrawEquippedItemStatMods ; $5482
	ret ; $5485
DrawEquippedShoesPanel:
	ld hl, $d800 ; $5486
	ld bc, $0003 ; $5489
	call ClearMemory16 ; $548c
	ld a, $01 ; $548f
	ld [$d813], a ; $5491
	call MarkOwnedShoes ; $5494
	call BuildOwnedItemList ; $5497
	ld a, $02 ; $549a
	ld [$d814], a ; $549c
	ld a, [$d811] ; $549f
	ld [wMenuCursorX], a ; $54a2
	call GetEquippedItemId ; $54a5
	ld c, a ; $54a8
	ld de, $d145 ; $54a9
	call DrawItemIcon2x2 ; $54ac
	call GetEquippedItemId ; $54af
	ld c, a ; $54b2
	ld de, $d148 ; $54b3
	call RenderShoesNameText ; $54b6
	call DrawEquippedItemStatMods ; $54b9
	ret ; $54bc
RunRacketSelectScreen:
	call DisableLCDSafely ; $54bd
	call LoadRacketSelectScreen ; $54c0
	ld a, $01 ; $54c3
	ld hl, EquipListCursorSpriteTask ; $54c5
	call RegisterFrameTask ; $54c8
	ld a, $01 ; $54cb
	ld hl, EquippedItemMarkerSpriteTask ; $54cd
	call RegisterFrameTask ; $54d0
	call EnableLCD ; $54d3
	script_fade_in $10 ; $54d6
	call WaitFadeEnd ; $54db
Label_3e_54de:
	call HandleEquipSelectInput ; $54de
	ld a, [$d812] ; $54e1
	or a, a ; $54e4
	jr z, Label_3e_54ef ; $54e5
	inc a ; $54e7
	ld [$d812], a ; $54e8
	cp a, $14 ; $54eb
	jr nc, Label_3e_54f4 ; $54ed
Label_3e_54ef:
	call AdvanceFrame ; $54ef
	jr Label_3e_54de ; $54f2
Label_3e_54f4:
	push af ; $54f4
	ld c, $10 ; $54f5
	call BeginFadeOut ; $54f7
	call WaitFadeEnd ; $54fa
	call ClearFrameTasks ; $54fd
	pop af ; $5500
	cp a, $45 ; $5501
	jr nz, Label_3e_5508 ; $5503
	ld a, $ff ; $5505
	ret ; $5507
Label_3e_5508:
	farcall RefreshMainCharacterStats ; $5508
	xor a, a ; $550b
	ret ; $550c
LoadRacketSelectScreen:
	ld c, $21 ; $550d
	farcall LoadScreenAssetRecord ; $550f
	farcall PrepareGlyphBuffer ; $5512
	call LoadEquipSelectCommon ; $5515
	ld c, $00 ; $5518
	ld b, $07 ; $551a
	call SetMenuCursorFromIndex_3e ; $551c
	wram_bank $03 ; $551f
	ld hl, $d800 ; $5525
	ld bc, $0002 ; $5528
	call ClearMemory16 ; $552b
	ld a, $00 ; $552e
	ld [$d813], a ; $5530
	ld a, $00 ; $5533
	ld [$d814], a ; $5535
	call MarkOwnedRackets ; $5538
	call BuildOwnedItemList ; $553b
	call DrawOwnedItemIcons ; $553e
	call DrawRacketInfoPanel ; $5541
	ld b, $63 ; $5544
	ld c, $02 ; $5546
	ld de, $a200 ; $5548
	farcall LoadCompressedTileBlock ; $554b
	ld hl, Palette_3e_555b ; $554e
	ld de, $0901 ; $5551
	call LoadPaletteShadow ; $5554
	farcall QueueWram3MapToVRAM ; $5557
	ret ; $555a
Palette_3e_555b:
	; $555b, 8 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $01df, $1bbf, $0298, $0421 ; pal 0: #ff7300 #ffee31 #c5a400 #080808
DrawOwnedItemIcons:
	ld hl, $d800 ; $5563
	ld a, [$d810] ; $5566
	ld b, a ; $5569
	ld de, $d027 ; $556a
Label_3e_556d:
	ld a, [hl+] ; $556d
	ld c, a ; $556e
	call DrawItemIcon2x2 ; $556f
	inc de ; $5572
	inc de ; $5573
	ld a, b ; $5574
	dec a ; $5575
	ld b, a ; $5576
	jr nz, Label_3e_556d ; $5577
	ret ; $5579
DrawItemIcon2x2:
	push af ; $557a
	push bc ; $557b
	push de ; $557c
	push hl ; $557d
	ld hl, $d240 ; $557e
	ld a, [$d813] ; $5581
	or a, a ; $5584
	jr z, Label_3e_558a ; $5585
	ld hl, $d280 ; $5587
Label_3e_558a:
	ld a, c ; $558a
	add a, a ; $558b
	add a, l ; $558c
	ld l, a ; $558d
	jr nc, Label_3e_5591 ; $558e
	inc h ; $5590
Label_3e_5591:
	ld b, $02 ; $5591
	ld c, $02 ; $5593
	farcall CopyTilemapRect ; $5595
	ld bc, $0400 ; $5598
	add hl, bc ; $559b
	push hl ; $559c
	ld h, d ; $559d
	ld l, e ; $559e
	add hl, bc ; $559f
	ld d, h ; $55a0
	ld e, l ; $55a1
	pop hl ; $55a2
	ld b, $02 ; $55a3
	ld c, $02 ; $55a5
	farcall CopyTilemapRect ; $55a7
	pop hl ; $55aa
	pop de ; $55ab
	pop bc ; $55ac
	pop af ; $55ad
	ret ; $55ae
HandleEquipSelectInput:
	ldh a, [hInputPressed] ; $55af
	ld [wMenuInputPressed], a ; $55b1
	bit PADB_A, a ; $55b4
	jr nz, Label_3e_55be ; $55b6
	bit 1, a ; $55b8
	jr nz, Label_3e_55f9 ; $55ba
	jr Label_3e_5601 ; $55bc
Label_3e_55be:
	ld a, [$d812] ; $55be
	or a, a ; $55c1
	jr nz, Label_3e_5601 ; $55c2
	sound $60 ; $55c4
	ld a, $01 ; $55c6
	ld [$d812], a ; $55c8
	ld a, [$d810] ; $55cb
	ld c, a ; $55ce
	call GetMenuCursorIndex_3e ; $55cf
	ld [$d811], a ; $55d2
	call GetEquippedItemId ; $55d5
	ld b, a ; $55d8
	ld a, [$d813] ; $55d9
	cp a, $00 ; $55dc
	ld a, b ; $55de
	jr z, Label_3e_55ee ; $55df
	swap a ; $55e1
	ld b, a ; $55e3
	ld a, [wEquippedRacket] ; $55e4
	and a, $0f ; $55e7
	or a, b ; $55e9
	ld [wEquippedRacket], a ; $55ea
	ret ; $55ed
Label_3e_55ee:
	ld b, a ; $55ee
	ld a, [wEquippedRacket] ; $55ef
	and a, $f0 ; $55f2
	or a, b ; $55f4
	ld [wEquippedRacket], a ; $55f5
	ret ; $55f8
Label_3e_55f9:
	sound $62 ; $55f9
	ld a, $44 ; $55fb
	ld [$d812], a ; $55fd
	ret ; $5600
Label_3e_5601:
	ld a, [$d810] ; $5601
	ld b, a ; $5604
	ld c, $01 ; $5605
	call MoveMenuCursorGrid_3e ; $5607
	or a, a ; $560a
	jr z, Label_3e_5623 ; $560b
	sound $5e ; $560d
	call ClearEquipSelectTextRows ; $560f
	ld a, [$d813] ; $5612
	or a, a ; $5615
	jr z, Label_3e_561d ; $5616
	call DrawShoesInfoPanel ; $5618
	jr Label_3e_5620 ; $561b
Label_3e_561d:
	call DrawRacketInfoPanel ; $561d
Label_3e_5620:
	call FlushEquipSelectTextRows ; $5620
Label_3e_5623:
	ret ; $5623
DrawRacketInfoPanel:
	farcall PrepareGlyphBuffer ; $5624
	call DrawHoveredItemStatMods ; $5627
	call GetHoveredItemId ; $562a
	ld c, a ; $562d
	ld de, $d0a5 ; $562e
	push bc ; $5631
	call DrawItemIcon2x2 ; $5632
	pop bc ; $5635
	push bc ; $5636
	call RenderRacketDescText ; $5637
	pop bc ; $563a
	ld de, $d0a8 ; $563b
	call RenderRacketNameText ; $563e
	farcall UploadGlyphBuffer ; $5641
	ret ; $5644
RunShoesSelectScreen:
	call DisableLCDSafely ; $5645
	call LoadShoesSelectScreen ; $5648
	ld a, $01 ; $564b
	ld hl, EquipListCursorSpriteTask ; $564d
	call RegisterFrameTask ; $5650
	ld a, $01 ; $5653
	ld hl, EquippedItemMarkerSpriteTask ; $5655
	call RegisterFrameTask ; $5658
	call EnableLCD ; $565b
	script_fade_in $10 ; $565e
	call WaitFadeEnd ; $5663
Label_3e_5666:
	call HandleEquipSelectInput ; $5666
	ld a, [$d812] ; $5669
	or a, a ; $566c
	jr z, Label_3e_5677 ; $566d
	inc a ; $566f
	ld [$d812], a ; $5670
	cp a, $14 ; $5673
	jr nc, Label_3e_567c ; $5675
Label_3e_5677:
	call AdvanceFrame ; $5677
	jr Label_3e_5666 ; $567a
Label_3e_567c:
	push af ; $567c
	ld c, $10 ; $567d
	call BeginFadeOut ; $567f
	call WaitFadeEnd ; $5682
	call ClearFrameTasks ; $5685
	pop af ; $5688
	cp a, $45 ; $5689
	jr nz, Label_3e_5690 ; $568b
	ld a, $ff ; $568d
	ret ; $568f
Label_3e_5690:
	farcall RefreshMainCharacterStats ; $5690
	xor a, a ; $5693
	ret ; $5694
	ret ; $5695
LoadShoesSelectScreen:
	ld c, $21 ; $5696
	farcall LoadScreenAssetRecord ; $5698
	farcall PrepareGlyphBuffer ; $569b
	call LoadEquipSelectCommon ; $569e
	wram_bank $03 ; $56a1
	ld hl, $d340 ; $56a7
	ld de, $d000 ; $56aa
	ld b, $14 ; $56ad
	ld c, $04 ; $56af
	farcall CopyTilemapRect ; $56b1
	ld hl, $d740 ; $56b4
	ld de, $d400 ; $56b7
	ld b, $14 ; $56ba
	ld c, $04 ; $56bc
	farcall CopyTilemapRect ; $56be
	ld c, $00 ; $56c1
	ld b, $07 ; $56c3
	call SetMenuCursorFromIndex_3e ; $56c5
	wram_bank $03 ; $56c8
	ld hl, $d800 ; $56ce
	ld bc, $0002 ; $56d1
	call ClearMemory16 ; $56d4
	ld a, $01 ; $56d7
	ld [$d813], a ; $56d9
	ld a, $00 ; $56dc
	ld [$d814], a ; $56de
	call MarkOwnedShoes ; $56e1
	call BuildOwnedItemList ; $56e4
	call DrawOwnedItemIcons ; $56e7
	call DrawShoesInfoPanel ; $56ea
	ld b, $63 ; $56ed
	ld c, $02 ; $56ef
	ld de, $a200 ; $56f1
	farcall LoadCompressedTileBlock ; $56f4
	ld hl, Palette_3e_555b ; $56f7
	ld de, $0901 ; $56fa
	call LoadPaletteShadow ; $56fd
	farcall QueueWram3MapToVRAM ; $5700
	ret ; $5703
DrawShoesInfoPanel:
	farcall PrepareGlyphBuffer ; $5704
	call DrawHoveredItemStatMods ; $5707
	call GetHoveredItemId ; $570a
	ld c, a ; $570d
	ld de, $d0a5 ; $570e
	push bc ; $5711
	call DrawItemIcon2x2 ; $5712
	pop bc ; $5715
	push bc ; $5716
	call RenderShoesDescText ; $5717
	pop bc ; $571a
	ld de, $d0a8 ; $571b
	call RenderShoesNameText ; $571e
	farcall UploadGlyphBuffer ; $5721
	ret ; $5724
BuildOwnedItemList:
	xor a, a ; $5725
	ld [$d811], a ; $5726
	ld [$d810], a ; $5729
	ld hl, $d800 ; $572c
	ld bc, $0008 ; $572f
	call ClearBytes ; $5732
	ld hl, $d808 ; $5735
	ld de, $d800 ; $5738
	ld c, $00 ; $573b
	ld b, $00 ; $573d
Label_3e_573f:
	ld a, [hl+] ; $573f
	or a, a ; $5740
	jr z, Label_3e_574f ; $5741
	cp a, $01 ; $5743
	jr z, Label_3e_574b ; $5745
	ld a, b ; $5747
	ld [$d811], a ; $5748
Label_3e_574b:
	ld a, c ; $574b
	ld [de], a ; $574c
	inc de ; $574d
	inc b ; $574e
Label_3e_574f:
	inc c ; $574f
	ld a, c ; $5750
	cp a, $08 ; $5751
	jr nz, Label_3e_573f ; $5753
	ld a, b ; $5755
	ld [$d810], a ; $5756
	ret ; $5759
MarkOwnedRackets:
	ld hl, $d808 ; $575a
	ld bc, $0008 ; $575d
	call ClearBytes ; $5760
	ld hl, $d808 ; $5763
	ld a, $01 ; $5766
	ld [hl+], a ; $5768
	ld c, $00 ; $5769
Label_3e_576b:
	ld a, c ; $576b
	push hl ; $576c
	ld hl, RacketItemTiles_3e ; $576d
	add a, l ; $5770
	ld l, a ; $5771
	jr nc, Label_3e_5775 ; $5772
	inc h ; $5774
Label_3e_5775:
	ld d, $00 ; $5775
	ld e, [hl] ; $5777
	pop hl ; $5778
	call TestGameFlagByNumber ; $5779
	jr z, Label_3e_5781 ; $577c
	ld a, $01 ; $577e
	ld [hl], a ; $5780
Label_3e_5781:
	inc hl ; $5781
	ld a, c ; $5782
	inc a ; $5783
	ld c, a ; $5784
	cp a, $06 ; $5785
	jr nz, Label_3e_576b ; $5787
	ld a, [wEquippedRacket] ; $5789
	and a, $0f ; $578c
	ld hl, $d808 ; $578e
	add a, l ; $5791
	ld l, a ; $5792
	jr nc, Label_3e_5796 ; $5793
	inc h ; $5795
Label_3e_5796:
	ld a, $02 ; $5796
	ld [hl], a ; $5798
	ret ; $5799
Unused_3e_579a:
	; $579a, 8 bytes (bytes:8)
	db $01, $00, $00, $00, $00, $00, $00, $00 ; 0x00
RacketItemTiles_3e:
	; $57a2, 6 bytes (bytes:6)
	db $61, $62, $63, $65, $64, $66 ; 0x00
MarkOwnedShoes:
	ld hl, $d808 ; $57a8
	ld bc, $0008 ; $57ab
	call ClearBytes ; $57ae
	ld hl, $d808 ; $57b1
	ld a, $01 ; $57b4
	ld [hl+], a ; $57b6
	ld c, $00 ; $57b7
Label_3e_57b9:
	ld a, c ; $57b9
	push hl ; $57ba
	ld hl, ShoeItemTiles_3e ; $57bb
	add a, l ; $57be
	ld l, a ; $57bf
	jr nc, Label_3e_57c3 ; $57c0
	inc h ; $57c2
Label_3e_57c3:
	ld d, $00 ; $57c3
	ld e, [hl] ; $57c5
	pop hl ; $57c6
	call TestGameFlagByNumber ; $57c7
	jr z, Label_3e_57cf ; $57ca
	ld a, $01 ; $57cc
	ld [hl], a ; $57ce
Label_3e_57cf:
	inc hl ; $57cf
	ld a, c ; $57d0
	inc a ; $57d1
	ld c, a ; $57d2
	cp a, $02 ; $57d3
	jr nz, Label_3e_57b9 ; $57d5
	ld a, [wEquippedRacket] ; $57d7
	and a, $f0 ; $57da
	swap a ; $57dc
	ld hl, $d808 ; $57de
	add a, l ; $57e1
	ld l, a ; $57e2
	jr nc, Label_3e_57e6 ; $57e3
	inc h ; $57e5
Label_3e_57e6:
	ld a, $02 ; $57e6
	ld [hl], a ; $57e8
	ret ; $57e9
Unused_3e_57ea:
	; $57ea, 8 bytes (bytes:8)
	db $01, $00, $00, $00, $00, $00, $00, $00 ; 0x00
ShoeItemTiles_3e:
	; $57f2, 2 bytes (bytes:2)
	db $67, $68 ; 0x00
LoadEquipSelectCommon:
	farcall ResetTextWindowState ; $57f4
	ld b, $11 ; $57f7
	ld c, $10 ; $57f9
	ld de, $9000 ; $57fb
	farcall LoadCompressedTileBlock ; $57fe
	wram_bank $05 ; $5801
	call CreateEquipCaptionWindow ; $5807
	call CreateEquipListWindow ; $580a
	ld de, $a000 ; $580d
	farcall LoadFixedTileBlockAndPalette ; $5810
	ret ; $5813
CreateEquipListWindow:
	ld d, $00 ; $5814
	ld e, $04 ; $5816
	ld b, $14 ; $5818
	ld c, $09 ; $581a
	farcall CreateWindowFromScreenRect ; $581c
	farcall DrawTextWindowFrame ; $581f
	farcall RedrawWindowRows ; $5822
	wram_bank $03 ; $5825
	ld de, $d4e1 ; $582b
	ld b, $12 ; $582e
	ld c, $05 ; $5830
	ld h, $08 ; $5832
	farcall FillTilemapRect ; $5834
	ret ; $5837
CreateEquipCaptionWindow:
	ld a, $03 ; $5838
	ld [wShadowTilemapBank], a ; $583a
	ld a, $00 ; $583d
	ld [wWindowTileAttr], a ; $583f
	ld d, $00 ; $5842
	ld e, $0d ; $5844
	ld b, $14 ; $5846
	ld c, $05 ; $5848
	farcall CreateWindowFromScreenRect ; $584a
	farcall DrawTextWindowFrame ; $584d
	farcall RedrawWindowRows ; $5850
	ret ; $5853
ClearEquipSelectTextRows:
	ld de, $d1a0 ; $5854
	ld b, $14 ; $5857
	ld c, $01 ; $5859
	ld h, $03 ; $585b
	farcall FillTilemapRect ; $585d
	ld a, $02 ; $5860
	ld [$d1a0], a ; $5862
	ld a, $04 ; $5865
	ld [$d1b3], a ; $5867
	ld de, $d1c1 ; $586a
	ld b, $12 ; $586d
	ld c, $03 ; $586f
	ld h, $20 ; $5871
	farcall FillTilemapRect ; $5873
	ld de, $d080 ; $5876
	ld b, $14 ; $5879
	ld c, $01 ; $587b
	ld h, $03 ; $587d
	farcall FillTilemapRect ; $587f
	ld a, $02 ; $5882
	ld [$d080], a ; $5884
	ld a, $04 ; $5887
	ld [$d093], a ; $5889
	ld de, $d0a1 ; $588c
	ld b, $12 ; $588f
	ld c, $07 ; $5891
	ld h, $20 ; $5893
	farcall FillTilemapRect ; $5895
	ret ; $5898
FlushEquipSelectTextRows:
	ld hl, $d080 ; $5899
	ld de, $9880 ; $589c
	ld c, $10 ; $589f
	call QueueVRAMCopy ; $58a1
	ld hl, $d1a0 ; $58a4
	ld de, $99a0 ; $58a7
	ld c, $08 ; $58aa
	call QueueVRAMCopy ; $58ac
	ld hl, $d4a0 ; $58af
	ld de, $b8a0 ; $58b2
	ld c, $04 ; $58b5
	call QueueVRAMCopy ; $58b7
	ret ; $58ba
	push af ; $58bb
	push bc ; $58bc
	ld hl, EquipSelectTextRowPtrs_3e ; $58bd
	ld a, [$d813] ; $58c0
	or a, a ; $58c3
	jr z, Label_3e_58c9 ; $58c4
	ld hl, EquipSelectTextRows_3e ; $58c6
Label_3e_58c9:
	ld a, b ; $58c9
	add a, a ; $58ca
	add a, l ; $58cb
	ld l, a ; $58cc
	jr nc, Label_3e_58d0 ; $58cd
	inc h ; $58cf
Label_3e_58d0:
	ld a, [hl+] ; $58d0
	ld h, [hl] ; $58d1
	ld l, a ; $58d2
	pop bc ; $58d3
	pop af ; $58d4
	ret ; $58d5
EquipSelectTextRowPtrs_3e:
	; $58d6, 14 bytes (bytes:14)
	db $ea, $58, $f2, $58, $fe, $58, $0a, $59, $22, $59, $16, $59, $2c, $59 ; 0x00
EquipSelectTextRows_3e:
	INCBIN "data/bank_03e/d_58e4.bin" ; $58e4, 102 bytes
GetHoveredItemId:
	push bc ; $594a
	push hl ; $594b
	ld a, [$d810] ; $594c
	ld c, a ; $594f
	call GetMenuCursorIndex_3e ; $5950
	ld hl, $d800 ; $5953
	add a, l ; $5956
	ld l, a ; $5957
	jr nc, Label_3e_595b ; $5958
	inc h ; $595a
Label_3e_595b:
	ld a, [hl] ; $595b
	pop hl ; $595c
	pop bc ; $595d
	ret ; $595e
GetEquippedItemId:
	push hl ; $595f
	ld a, [$d811] ; $5960
	ld hl, $d800 ; $5963
	add a, l ; $5966
	ld l, a ; $5967
	jr nc, Label_3e_596b ; $5968
	inc h ; $596a
Label_3e_596b:
	ld a, [hl] ; $596b
	pop hl ; $596c
	ret ; $596d
DrawEquippedItemStatMods:
	push af ; $596e
	push bc ; $596f
	push de ; $5970
	push hl ; $5971
	ldh a, [hWramBank] ; $5972
	push af ; $5974
	wram_bank $03 ; $5975
	call GetEquippedItemId ; $597b
	jp Label_3e_5991 ; $597e
DrawHoveredItemStatMods:
	push af ; $5981
	push bc ; $5982
	push de ; $5983
	push hl ; $5984
	ldh a, [hWramBank] ; $5985
	push af ; $5987
	wram_bank $03 ; $5988
	call GetHoveredItemId ; $598e
Label_3e_5991:
	call DrawItemStatModList ; $5991
	pop af ; $5994
	wram_bank ; $5995
	pop hl ; $5999
	pop de ; $599a
	pop bc ; $599b
	pop af ; $599c
	ret ; $599d
RenderShoesDescText:
	ld hl, $00f7 ; $599e
	jp Label_3e_59a7 ; $59a1
RenderRacketDescText:
	ld hl, $00ed ; $59a4
Label_3e_59a7:
	ld a, c ; $59a7
	add a, l ; $59a8
	ld l, a ; $59a9
	jr nc, Label_3e_59ad ; $59aa
	inc h ; $59ac
Label_3e_59ad:
	ld de, $d1c1 ; $59ad
	ld c, $12 ; $59b0
	push hl ; $59b2
	farcall RenderProportionalTextAt ; $59b3
	pop hl ; $59b6
	ret ; $59b7
RenderShoesNameText:
	ld hl, $00f4 ; $59b8
	jp Label_3e_59c1 ; $59bb
RenderRacketNameText:
	ld hl, $00e5 ; $59be
Label_3e_59c1:
	ld a, c ; $59c1
	add a, l ; $59c2
	ld l, a ; $59c3
	jr nc, Label_3e_59c7 ; $59c4
	inc h ; $59c6
Label_3e_59c7:
	ld c, $12 ; $59c7
	farcall RenderProportionalTextAt ; $59c9
	ret ; $59cc
EquipListCursorSpriteTask:
	ld c, $07 ; $59cd
	call GetMenuCursorIndex_3e ; $59cf
	ld hl, EquipListCursorYPositions_3e ; $59d2
	add a, l ; $59d5
	ld l, a ; $59d6
	jr nc, Label_3e_59da ; $59d7
	inc h ; $59d9
Label_3e_59da:
	ld d, [hl] ; $59da
	ld e, $06 ; $59db
	ld b, $10 ; $59dd
	ld c, $0e ; $59df
	call DrawSelectionBoxCorners ; $59e1
	ret ; $59e4
EquipListCursorYPositions_3e:
	; $59e5, 6 bytes (bytes:6)
	db $38, $48, $58, $68, $78, $88 ; 0x00
EquippedItemMarkerSpriteTask:
	ldh a, [hWramBank] ; $59eb
	push af ; $59ed
	wram_bank $03 ; $59ee
	ld a, [$d811] ; $59f4
	ld hl, EquippedMarkerYPositions_3e ; $59f7
	add a, l ; $59fa
	ld l, a ; $59fb
	jr nc, Label_3e_59ff ; $59fc
	inc h ; $59fe
Label_3e_59ff:
	ld d, [hl] ; $59ff
	ld e, $18 ; $5a00
	ld b, $09 ; $5a02
	ld c, $20 ; $5a04
	call QueueSprite ; $5a06
	pop af ; $5a09
	wram_bank ; $5a0a
	ret ; $5a0e
EquippedMarkerYPositions_3e:
	; $5a0f, 6 bytes (bytes:6)
	db $41, $51, $61, $71, $81, $91 ; 0x00
DrawItemStatModList:
	ld b, a ; $5a15
	call GetItemStatModListPtr ; $5a16
	ld b, $00 ; $5a19
Label_3e_5a1b:
	ld d, [hl] ; $5a1b
	inc hl ; $5a1c
	ld c, [hl] ; $5a1d
	inc hl ; $5a1e
	call DrawStatModEntry ; $5a1f
	cp a, $ff ; $5a22
	jr z, Label_3e_5a2c ; $5a24
	inc b ; $5a26
	ld a, b ; $5a27
	cp a, $06 ; $5a28
	jr nz, Label_3e_5a1b ; $5a2a
Label_3e_5a2c:
	ret ; $5a2c
DrawStatModEntry:
	push hl ; $5a2d
	push bc ; $5a2e
	ld a, d ; $5a2f
	cp a, $ff ; $5a30
	jr z, Label_3e_5a41 ; $5a32
	cp a, $fe ; $5a34
	jr z, Label_3e_5a41 ; $5a36
	call DrawStatModLabel ; $5a38
	ld d, c ; $5a3b
	call DrawStatModValue ; $5a3c
	ld a, $fe ; $5a3f
Label_3e_5a41:
	pop bc ; $5a41
	pop hl ; $5a42
	ret ; $5a43
GetItemStatModListPtr:
	push af ; $5a44
	push bc ; $5a45
	ld hl, $5a5f ; $5a46
	ld a, [$d813] ; $5a49
	or a, a ; $5a4c
	jr z, Label_3e_5a52 ; $5a4d
	ld hl, $5a6d ; $5a4f
Label_3e_5a52:
	ld a, b ; $5a52
	add a, a ; $5a53
	add a, l ; $5a54
	ld l, a ; $5a55
	jr nc, Label_3e_5a59 ; $5a56
	inc h ; $5a58
Label_3e_5a59:
	ld a, [hl+] ; $5a59
	ld h, [hl] ; $5a5a
	ld l, a ; $5a5b
	pop bc ; $5a5c
	pop af ; $5a5d
	ret ; $5a5e
	; $5a5f, 20 bytes (records:2)
	dw $5a73 ; record 0
	dw $5a7a ; record 1
	dw $5a85 ; record 2
	dw $5a90 ; record 3
	dw $5aa6 ; record 4
	dw $5a9b ; record 5
	dw $5aaf ; record 6
	dw $5a73 ; record 7
	dw $5ab6 ; record 8
	dw $5ac1 ; record 9
	; $5a73, 87 bytes (bytes:8)
	db $fe, $fe, $fe, $fe, $0a, $fe, $ff, $00 ; 0x00
	db $81, $01, $81, $03, $82, $04, $02, $05 ; 0x08
	db $01, $ff, $00, $02, $01, $01, $03, $01 ; 0x10
	db $04, $82, $05, $82, $ff, $00, $82, $01 ; 0x18
	db $82, $02, $82, $fe, $fe, $0b, $fe, $ff ; 0x20
	db $00, $81, $01, $81, $02, $03, $04, $01 ; 0x28
	db $05, $01, $ff, $00, $02, $01, $02, $02 ; 0x30
	db $81, $04, $81, $ff, $00, $82, $03, $03 ; 0x38
	db $01, $82, $ff, $07, $82, $0c, $82, $08 ; 0x40
	db $82, $09, $82, $0b, $fe, $ff, $07, $02 ; 0x48
	db $0c, $02, $08, $82, $09, $82, $ff ; 0x50
DrawStatModLabel:
	push af ; $5aca
	push bc ; $5acb
	push de ; $5acc
	push hl ; $5acd
	ld e, $00 ; $5ace
	call GetStatModRowAddr ; $5ad0
	call GetStatModLabelTile ; $5ad3
	call GetStatModLabelLen ; $5ad6
	ld c, a ; $5ad9
	farcall FillIncrementingBytes ; $5ada
	pop hl ; $5add
	pop de ; $5ade
	pop bc ; $5adf
	pop af ; $5ae0
	ret ; $5ae1
GetStatModLabelTile:
	push hl ; $5ae2
	ld a, d ; $5ae3
	ld hl, StatModLabelTiles_3e ; $5ae4
	add a, l ; $5ae7
	ld l, a ; $5ae8
	jr nc, Label_3e_5aec ; $5ae9
	inc h ; $5aeb
Label_3e_5aec:
	ld b, [hl] ; $5aec
	pop hl ; $5aed
	ret ; $5aee
StatModLabelTiles_3e:
	; $5aef, 13 bytes (bytes:13)
	db $70, $75, $7a, $7f, $84, $d6, $89, $8e, $93, $99, $a2, $b3, $c5 ; 0x00
GetStatModLabelLen:
	push hl ; $5afc
	ld a, d ; $5afd
	ld hl, StatModLabelLengths_3e ; $5afe
	add a, l ; $5b01
	ld l, a ; $5b02
	jr nc, Label_3e_5b06 ; $5b03
	inc h ; $5b05
Label_3e_5b06:
	ld a, [hl] ; $5b06
	pop hl ; $5b07
	ret ; $5b08
StatModLabelLengths_3e:
	; $5b09, 13 bytes (bytes:13)
	db $05, $05, $05, $05, $05, $05, $05, $05, $06, $04, $11, $12, $04 ; 0x00
DrawStatModValue:
	push af ; $5b16
	push bc ; $5b17
	push de ; $5b18
	push hl ; $5b19
	ld a, d ; $5b1a
	cp a, $fe ; $5b1b
	jr z, Label_3e_5b27 ; $5b1d
	ld e, $01 ; $5b1f
	call GetStatModRowAddr ; $5b21
	call WriteStatModValueTiles ; $5b24
Label_3e_5b27:
	pop hl ; $5b27
	pop de ; $5b28
	pop bc ; $5b29
	pop af ; $5b2a
	ret ; $5b2b
WriteStatModValueTiles:
	ld a, d ; $5b2c
	cp a, $80 ; $5b2d
	ld a, $d0 ; $5b2f
	jr c, Label_3e_5b35 ; $5b31
	ld a, $d1 ; $5b33
Label_3e_5b35:
	ld [hl+], a ; $5b35
	ld a, d ; $5b36
	and a, $07 ; $5b37
	ld b, $d2 ; $5b39
	add a, b ; $5b3b
	ld [hl], a ; $5b3c
	ret ; $5b3d
GetStatModRowAddr:
	ld a, [$d814] ; $5b3e
	add a, a ; $5b41
	ld hl, $5b63 ; $5b42
	add a, l ; $5b45
	ld l, a ; $5b46
	jr nc, Label_3e_5b4a ; $5b47
	inc h ; $5b49
Label_3e_5b4a:
	ld a, [hl+] ; $5b4a
	ld h, [hl] ; $5b4b
	ld l, a ; $5b4c
	ld a, b ; $5b4d
	add a, a ; $5b4e
	add a, l ; $5b4f
	ld l, a ; $5b50
	jr nc, Label_3e_5b54 ; $5b51
	inc h ; $5b53
Label_3e_5b54:
	ld a, [hl+] ; $5b54
	ld h, [hl] ; $5b55
	ld l, a ; $5b56
	ld a, e ; $5b57
	or a, a ; $5b58
	jr z, Label_3e_5b62 ; $5b59
	ld a, $06 ; $5b5b
	add a, l ; $5b5d
	ld l, a ; $5b5e
	jr nc, Label_3e_5b62 ; $5b5f
	inc h ; $5b61
Label_3e_5b62:
	ret ; $5b62
	; $5b63, 6 bytes (records:2)
	dw $5b69 ; record 0
	dw $5b79 ; record 1
	dw $5b89 ; record 2
	; $5b69, 48 bytes (bytes:8)
	db $e1, $d0, $eb, $d0, $21, $d1, $2b, $d1 ; 0x00
	db $61, $d1, $6b, $d1, $00, $00, $00, $00 ; 0x08
	db $61, $d0, $6b, $d0, $a1, $d0, $ab, $d0 ; 0x10
	db $e1, $d0, $eb, $d0, $00, $00, $00, $00 ; 0x18
	db $81, $d1, $8b, $d1, $c1, $d1, $cb, $d1 ; 0x20
	db $01, $d2, $0b, $d2, $00, $00, $00, $00 ; 0x28
RunCourtSelect4Menu:
	sound $03 ; $5b99
	call ClearFrameTasks ; $5b9b
	ld hl, rIE ; $5b9e
	res 2, [hl] ; $5ba1
	farcall InitMenuBgScroll ; $5ba3
	ld b, $01 ; $5ba6
	ld c, $01 ; $5ba8
	farcall LoadMenuSpritePalettePair ; $5baa
	call LoadCourtSelectHeader ; $5bad
	wram_bank $03 ; $5bb0
	ld a, [wMenuSlideDirection] ; $5bb6
	ld b, a ; $5bb9
	call OpenCourtSelect4Panel ; $5bba
	ld a, [$cb1e] ; $5bbd
	ld c, a ; $5bc0
	ld b, $02 ; $5bc1
	call SetMenuCursorFromIndex_3e ; $5bc3
	ld a, $01 ; $5bc6
	ld hl, CourtSelect4CursorSpriteTask ; $5bc8
	call RegisterFrameTask ; $5bcb
	call RedrawCourtSelect4Menu ; $5bce
	wram_bank $03 ; $5bd1
Label_3e_5bd7:
	call AdvanceFrame ; $5bd7
	ldh a, [hInputPressed] ; $5bda
	ld [wMenuInputPressed], a ; $5bdc
	ld b, $02 ; $5bdf
	ld c, $02 ; $5be1
	call MoveMenuCursorGrid_3e ; $5be3
	or a, a ; $5be6
	jr z, Label_3e_5bee ; $5be7
	sound $5e ; $5be9
	call RedrawCourtSelect4Menu ; $5beb
Label_3e_5bee:
	ld a, [wMenuInputPressed] ; $5bee
	bit PADB_A, a ; $5bf1
	jr nz, Label_3e_5bfb ; $5bf3
	bit 1, a ; $5bf5
	jr nz, Label_3e_5c1e ; $5bf7
	jr Label_3e_5bd7 ; $5bf9
Label_3e_5bfb:
	sound $60 ; $5bfb
	call ClearFrameTasks ; $5bfd
	ld hl, rIE ; $5c00
	set 2, [hl] ; $5c03
	ld b, $01 ; $5c05
	call CloseCourtSelect4Panel ; $5c07
	ld a, $01 ; $5c0a
	ld [wMenuSlideDirection], a ; $5c0c
	ld c, $02 ; $5c0f
	call GetMenuCursorIndex_3e ; $5c11
	push af ; $5c14
	ld c, a ; $5c15
	call SetCourtSelectBGM ; $5c16
	pop af ; $5c19
	call CourtSelectIndexToCourtId ; $5c1a
	ret ; $5c1d
Label_3e_5c1e:
	sound $62 ; $5c1e
	call ClearFrameTasks ; $5c20
	ld hl, rIE ; $5c23
	set 2, [hl] ; $5c26
	ld b, $00 ; $5c28
	call CloseCourtSelect4Panel ; $5c2a
	ld a, $00 ; $5c2d
	ld [wMenuSlideDirection], a ; $5c2f
	call FadeOutAndResetMenuScreen ; $5c32
	ld a, $ff ; $5c35
	ret ; $5c37
RunLinkCourtSelect4Menu:
	xor a, a ; $5c38
	ldh [$ffd8], a ; $5c39
	call ResetSerialState ; $5c3b
	call ClearFrameTasks ; $5c3e
	call EnableTimerInterrupt ; $5c41
	sound $03 ; $5c44
	farcall InitMenuBgScroll ; $5c46
	ld b, $01 ; $5c49
	ld c, $01 ; $5c4b
	farcall LoadMenuSpritePalettePair ; $5c4d
	call LoadCourtSelectHeader ; $5c50
	wram_bank $03 ; $5c53
	ld a, [wMenuSlideDirection] ; $5c59
	ld b, a ; $5c5c
	call OpenCourtSelect4Panel ; $5c5d
	ld a, [$cb1e] ; $5c60
	ld c, a ; $5c63
	ld b, $02 ; $5c64
	call SetMenuCursorFromIndex_3e ; $5c66
	ld a, $01 ; $5c69
	ld hl, CourtSelect4CursorSpriteTask ; $5c6b
	call RegisterFrameTask ; $5c6e
	call RedrawCourtSelect4Menu ; $5c71
	farcall ResyncLinkSessionWithTimer ; $5c74
	push af ; $5c77
	farcall RunLinkInputFrame ; $5c78
	pop af ; $5c7b
	push af ; $5c7c
	farcall RunLinkInputFrame ; $5c7d
	pop af ; $5c80
	push af ; $5c81
	farcall RunLinkInputFrame ; $5c82
	pop af ; $5c85
	wram_bank $03 ; $5c86
Label_3e_5c8c:
	push af ; $5c8c
	farcall RunLinkInputFrame ; $5c8d
	pop af ; $5c90
	ldh a, [hLinkInput] ; $5c91
	ld [wMenuInputPressed], a ; $5c93
	ld b, $02 ; $5c96
	ld c, $02 ; $5c98
	call MoveMenuCursorGrid_3e ; $5c9a
	or a, a ; $5c9d
	jr z, Label_3e_5ca5 ; $5c9e
	sound $5e ; $5ca0
	call RedrawCourtSelect4Menu ; $5ca2
Label_3e_5ca5:
	ld a, [wMenuInputPressed] ; $5ca5
	bit PADB_A, a ; $5ca8
	jr nz, Label_3e_5cb2 ; $5caa
	bit 1, a ; $5cac
	jr nz, Label_3e_5cd9 ; $5cae
	jr Label_3e_5c8c ; $5cb0
Label_3e_5cb2:
	sound $60 ; $5cb2
	push af ; $5cb4
	farcall SyncLinkFrame ; $5cb5
	pop af ; $5cb8
	call ClearFrameTasks ; $5cb9
	xor a, a ; $5cbc
	ldh [$ffd8], a ; $5cbd
	call ResetSerialState ; $5cbf
	call EnableTimerInterrupt ; $5cc2
	ld a, $01 ; $5cc5
	ld [wMenuSlideDirection], a ; $5cc7
	ld c, $02 ; $5cca
	call GetMenuCursorIndex_3e ; $5ccc
	push af ; $5ccf
	ld c, a ; $5cd0
	call SetCourtSelectBGMLink ; $5cd1
	pop af ; $5cd4
	call CourtSelectIndexToCourtId ; $5cd5
	ret ; $5cd8
Label_3e_5cd9:
	sound $62 ; $5cd9
	push af ; $5cdb
	farcall SyncLinkFrame ; $5cdc
	pop af ; $5cdf
	xor a, a ; $5ce0
	ldh [$ffd8], a ; $5ce1
	call ResetSerialState ; $5ce3
	call ClearFrameTasks ; $5ce6
	ld b, $00 ; $5ce9
	call CloseCourtSelect4Panel ; $5ceb
	ld a, $00 ; $5cee
	ld [wMenuSlideDirection], a ; $5cf0
	ld c, $10 ; $5cf3
	call BeginFadeOut ; $5cf5
	call WaitFadeEnd ; $5cf8
	ld a, $ff ; $5cfb
	ret ; $5cfd
CourtSelectIndexToCourtId:
	ld hl, CourtSelectCourtIds_3e ; $5cfe
	add a, l ; $5d01
	ld l, a ; $5d02
	jr nc, Label_3e_5d06 ; $5d03
	inc h ; $5d05
Label_3e_5d06:
	ld a, [hl] ; $5d06
	ret ; $5d07
CourtSelectCourtIds_3e:
	; $5d08, 9 bytes (bytes:9)
	db $00, $01, $02, $03, $04, $05, $06, $07, $08 ; 0x00
LoadCourtSelectGraphics:
	ldh a, [hWramBank] ; $5d11
	push af ; $5d13
	ld a, [wUnlockedCourtMask] ; $5d14
	ld b, a ; $5d17
	ld a, [wLinkPartnerCourtMask] ; $5d18
	or a, b ; $5d1b
	ld b, a ; $5d1c
	call StoreCourtUnlockBits ; $5d1d
	wram_bank $01 ; $5d20
	ld c, $00 ; $5d26
Label_3e_5d28:
	ld a, c ; $5d28
	add a, a ; $5d29
	ld hl, $5df1 ; $5d2a
	add a, l ; $5d2d
	ld l, a ; $5d2e
	jr nc, Label_3e_5d32 ; $5d2f
	inc h ; $5d31
Label_3e_5d32:
	ld a, [hl+] ; $5d32
	ld h, [hl] ; $5d33
	ld l, a ; $5d34
	push af ; $5d35
	push bc ; $5d36
	push de ; $5d37
	push hl ; $5d38
	call GetCourtThumbnailPtr ; $5d39
	ld de, $d000 ; $5d3c
	call DecompressDataFromBank ; $5d3f
	pop hl ; $5d42
	pop de ; $5d43
	pop bc ; $5d44
	pop af ; $5d45
	ld hl, $5e05 ; $5d46
	ld a, c ; $5d49
	add a, a ; $5d4a
	add a, l ; $5d4b
	ld l, a ; $5d4c
	jr nc, Label_3e_5d50 ; $5d4d
	inc h ; $5d4f
Label_3e_5d50:
	ld a, [hl+] ; $5d50
	ld d, [hl] ; $5d51
	ld e, a ; $5d52
	ld hl, $d000 ; $5d53
	push af ; $5d56
	push bc ; $5d57
	push de ; $5d58
	push hl ; $5d59
	ld bc, $0010 ; $5d5a
	call QueueVRAMCopy ; $5d5d
	pop hl ; $5d60
	pop de ; $5d61
	pop bc ; $5d62
	pop af ; $5d63
	ld a, c ; $5d64
	inc a ; $5d65
	ld c, a ; $5d66
	ld a, c ; $5d67
	cp a, $09 ; $5d68
	jr nz, Label_3e_5d28 ; $5d6a
	ld b, $65 ; $5d6c
	ld c, $12 ; $5d6e
	ld de, $a000 ; $5d70
	farcall LoadCompressedTileBlock ; $5d73
	ld b, $66 ; $5d76
	ld c, $12 ; $5d78
	ld de, $a100 ; $5d7a
	farcall LoadCompressedTileBlock ; $5d7d
	ld b, $67 ; $5d80
	ld c, $12 ; $5d82
	ld de, $a200 ; $5d84
	farcall LoadCompressedTileBlock ; $5d87
	ld b, $68 ; $5d8a
	ld c, $14 ; $5d8c
	ld de, $a300 ; $5d8e
	farcall LoadCompressedTileBlock ; $5d91
	ld b, $6a ; $5d94
	ld c, $12 ; $5d96
	ld de, $a420 ; $5d98
	farcall LoadCompressedTileBlock ; $5d9b
	ld b, $6b ; $5d9e
	ld c, $12 ; $5da0
	ld de, $a520 ; $5da2
	farcall LoadCompressedTileBlock ; $5da5
	ld b, $6c ; $5da8
	ld c, $12 ; $5daa
	ld de, $a620 ; $5dac
	farcall LoadCompressedTileBlock ; $5daf
	ld b, $6d ; $5db2
	ld c, $12 ; $5db4
	ld de, $8200 ; $5db6
	farcall LoadCompressedTileBlock ; $5db9
	ld b, $6e ; $5dbc
	ld c, $12 ; $5dbe
	ld de, $8300 ; $5dc0
	farcall LoadCompressedTileBlock ; $5dc3
	ld b, $6f ; $5dc6
	ld c, $12 ; $5dc8
	ld de, $8400 ; $5dca
	farcall LoadCompressedTileBlock ; $5dcd
	ld b, $1b ; $5dd0
	ld c, $04 ; $5dd2
	ld de, $a720 ; $5dd4
	farcall LoadCompressedTileBlock ; $5dd7
	ld b, $40 ; $5dda
	ld c, $14 ; $5ddc
	ld de, $8000 ; $5dde
	farcall LoadCompressedTileBlock ; $5de1
	ld b, $08 ; $5de4
	ld c, $10 ; $5de6
	farcall LoadIndexedPalette ; $5de8
	pop af ; $5deb
	wram_bank ; $5dec
	ret ; $5df0
	; $5df1, 38 bytes (records:2)
	dw $3f02 ; record 0
	dw $3f04 ; record 1
	dw $3f06 ; record 2
	dw $3f08 ; record 3
	dw $3f0a ; record 4
	dw $3f0c ; record 5
	dw $3f0e ; record 6
	dw $3f10 ; record 7
	dw $3f12 ; record 8
	dw $3f14 ; record 9
	dw $a800 ; record 10
	dw $a900 ; record 11
	dw $aa00 ; record 12
	dw $ab00 ; record 13
	dw $ac00 ; record 14
	dw $ad00 ; record 15
	dw $ae00 ; record 16
	dw $af00 ; record 17
	dw $b700 ; record 18
GetCourtThumbnailPtr:
	push af ; $5e17
	push bc ; $5e18
	push de ; $5e19
	ld b, c ; $5e1a
	push hl ; $5e1b
	call IsCourtUnlocked ; $5e1c
	or a, a ; $5e1f
	pop hl ; $5e20
	jr nz, Label_3e_5e26 ; $5e21
	ld hl, $3f14 ; $5e23
Label_3e_5e26:
	pop de ; $5e26
	pop bc ; $5e27
	pop af ; $5e28
	ret ; $5e29
OpenCourtSelect4Panel:
	ld a, b ; $5e2a
	or a, a ; $5e2b
	jr z, Label_3e_5e48 ; $5e2c
	ld c, $00 ; $5e2e
Label_3e_5e30:
	call AdvanceFrame ; $5e30
	ld b, $12 ; $5e33
	farcall RestoreMenuBgAndDrawPanel ; $5e35
	ld b, $02 ; $5e38
	farcall FlushWram3MapRows ; $5e3a
	ld a, c ; $5e3d
	inc a ; $5e3e
	ld c, a ; $5e3f
	cp a, $0d ; $5e40
	jr nz, Label_3e_5e30 ; $5e42
	call AdvanceFrame ; $5e44
	ret ; $5e47
Label_3e_5e48:
	ld c, $0a ; $5e48
Label_3e_5e4a:
	call AdvanceFrame ; $5e4a
	ld b, $13 ; $5e4d
	farcall RestoreMenuBgAndDrawPanel ; $5e4f
	ld b, $02 ; $5e52
	farcall FlushWram3MapRows ; $5e54
	ld a, c ; $5e57
	dec a ; $5e58
	ld c, a ; $5e59
	cp a, $ff ; $5e5a
	jr nz, Label_3e_5e4a ; $5e5c
	call AdvanceFrame ; $5e5e
	ret ; $5e61
CloseCourtSelect4Panel:
	ld a, b ; $5e62
	or a, a ; $5e63
	jr z, Label_3e_5e7d ; $5e64
	ld c, $00 ; $5e66
Label_3e_5e68:
	call AdvanceFrame ; $5e68
	ld b, $13 ; $5e6b
	farcall RestoreMenuBgAndDrawPanel ; $5e6d
	ld b, $02 ; $5e70
	farcall FlushWram3MapRows ; $5e72
	ld a, c ; $5e75
	inc a ; $5e76
	ld c, a ; $5e77
	cp a, $0b ; $5e78
	jr nz, Label_3e_5e68 ; $5e7a
	ret ; $5e7c
Label_3e_5e7d:
	ld c, $0c ; $5e7d
Label_3e_5e7f:
	call AdvanceFrame ; $5e7f
	ld b, $12 ; $5e82
	farcall RestoreMenuBgAndDrawPanel ; $5e84
	ld b, $02 ; $5e87
	farcall FlushWram3MapRows ; $5e89
	ld a, c ; $5e8c
	dec a ; $5e8d
	ld c, a ; $5e8e
	or a, a ; $5e8f
	jr nz, Label_3e_5e7f ; $5e90
	ret ; $5e92
CourtSelect4CursorSpriteTask:
	farcall TickMenuBgScroll ; $5e93
	ld c, $02 ; $5e96
	call GetMenuCursorIndex_3e ; $5e98
	push af ; $5e9b
	ld hl, CourtSelect4CursorTiles_3e ; $5e9c
	add a, l ; $5e9f
	ld l, a ; $5ea0
	jr nc, Label_3e_5ea4 ; $5ea1
	inc h ; $5ea3
Label_3e_5ea4:
	ld c, [hl] ; $5ea4
	pop af ; $5ea5
	push af ; $5ea6
	ld hl, CourtSelect4CursorPositions_3e ; $5ea7
	add a, a ; $5eaa
	add a, l ; $5eab
	ld l, a ; $5eac
	jr nc, Label_3e_5eb0 ; $5ead
	inc h ; $5eaf
Label_3e_5eb0:
	ld a, [hl+] ; $5eb0
	ld d, [hl] ; $5eb1
	ld e, a ; $5eb2
	farcall ApplySpriteBobOffset ; $5eb3
	ld b, [hl] ; $5eb6
	pop af ; $5eb7
	add a, a ; $5eb8
	ld hl, $5eea ; $5eb9
	add a, l ; $5ebc
	ld l, a ; $5ebd
	jr nc, Label_3e_5ec1 ; $5ebe
	inc h ; $5ec0
Label_3e_5ec1:
	ld a, [hl+] ; $5ec1
	ld h, [hl] ; $5ec2
	ld l, a ; $5ec3
	ld b, $08 ; $5ec4
	push de ; $5ec6
	call QueueSpriteTemplate ; $5ec7
	pop de ; $5eca
	ld c, $02 ; $5ecb
	call GetMenuCursorIndex_3e ; $5ecd
	ld hl, CourtSelect4LabelYOffsets_3e ; $5ed0
	add a, l ; $5ed3
	ld l, a ; $5ed4
	jr nc, Label_3e_5ed8 ; $5ed5
	inc h ; $5ed7
Label_3e_5ed8:
	ld a, [hl] ; $5ed8
	ld h, a ; $5ed9
	ld l, $f8 ; $5eda
	add hl, de ; $5edc
	ld d, h ; $5edd
	ld e, l ; $5ede
	ld hl, SpriteTemplate_3e_5f38 ; $5edf
	ld b, $08 ; $5ee2
	ld c, $72 ; $5ee4
	call QueueSpriteTemplate ; $5ee6
	ret ; $5ee9
	; $5eea, 8 bytes (records:2)
	dw $5ef2 ; record 0
	dw $5ef2 ; record 1
	dw $5ef2 ; record 2
	dw $5f13 ; record 3
	; $5ef2, 70 bytes (bytes:8)
	db $10, $08, $00, $00, $10, $10, $02, $00 ; 0x00
	db $10, $18, $04, $00, $10, $20, $06, $00 ; 0x08
	db $10, $28, $08, $00, $10, $30, $0a, $00 ; 0x10
	db $10, $38, $0c, $00, $10, $40, $0e, $00 ; 0x18
	db $80, $10, $08, $00, $00, $10, $10, $02 ; 0x20
	db $00, $10, $18, $04, $00, $10, $20, $06 ; 0x28
	db $00, $10, $28, $08, $00, $10, $30, $0a ; 0x30
	db $00, $10, $38, $0c, $00, $10, $40, $0e ; 0x38
	db $00, $10, $48, $10, $00, $80 ; 0x40
SpriteTemplate_3e_5f38:
	; $5f38, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
CourtSelect4CursorPositions_3e:
	; $5f41, 8 bytes (bytes:8)
	db $38, $14, $38, $4c, $60, $14, $60, $48 ; 0x00
CourtSelect4CursorTiles_3e:
	; $5f49, 4 bytes (bytes:4)
	db $00, $10, $20, $30 ; 0x00
CourtSelect4LabelYOffsets_3e:
	; $5f4d, 4 bytes (bytes:4)
	db $17, $17, $17, $1b ; 0x00
RedrawCourtSelect4Menu:
	wram_bank $03 ; $5f51
	ld b, $00 ; $5f57
	ld c, $00 ; $5f59
Label_3e_5f5b:
	call SetCourtSelect4TabAttrRect ; $5f5b
	ld a, b ; $5f5e
	inc a ; $5f5f
	ld b, a ; $5f60
	cp a, $04 ; $5f61
	jr nz, Label_3e_5f5b ; $5f63
	ld c, $02 ; $5f65
	call GetMenuCursorIndex_3e ; $5f67
	ld b, a ; $5f6a
	ld c, $01 ; $5f6b
	call SetCourtSelect4TabAttrRect ; $5f6d
	ld c, $02 ; $5f70
	call GetMenuCursorIndex_3e ; $5f72
	call SetCourtSelect4Palette ; $5f75
	ld c, $02 ; $5f78
	call GetMenuCursorIndex_3e ; $5f7a
	ld d, a ; $5f7d
	ld b, a ; $5f7e
	call IsCourtUnlocked ; $5f7f
	or a, a ; $5f82
	ld b, $ff ; $5f83
	jr z, Label_3e_5f88 ; $5f85
	ld b, d ; $5f87
Label_3e_5f88:
	call DrawCourtNameTiles ; $5f88
	ld hl, $d480 ; $5f8b
	ld de, $b880 ; $5f8e
	ld c, $06 ; $5f91
	call QueueVRAMCopy ; $5f93
	ld hl, $d520 ; $5f96
	ld de, $b920 ; $5f99
	ld c, $06 ; $5f9c
	call QueueVRAMCopy ; $5f9e
	ld hl, $d200 ; $5fa1
	ld de, $9a00 ; $5fa4
	ld c, $02 ; $5fa7
	call QueueVRAMCopy ; $5fa9
	ret ; $5fac
SetCourtSelect4TabAttrRect:
	push af ; $5fad
	push bc ; $5fae
	push de ; $5faf
	push hl ; $5fb0
	ld a, c ; $5fb1
	or a, a ; $5fb2
	jr z, Label_3e_5fb9 ; $5fb3
	ld h, $0c ; $5fb5
	jr Label_3e_5fbb ; $5fb7
Label_3e_5fb9:
	ld h, $0d ; $5fb9
Label_3e_5fbb:
	push hl ; $5fbb
	ld hl, CourtSelect4TabAttrAddrs_3e ; $5fbc
	ld a, b ; $5fbf
	add a, a ; $5fc0
	add a, l ; $5fc1
	ld l, a ; $5fc2
	jr nc, Label_3e_5fc6 ; $5fc3
	inc h ; $5fc5
Label_3e_5fc6:
	ld a, [hl+] ; $5fc6
	ld d, [hl] ; $5fc7
	ld e, a ; $5fc8
	pop hl ; $5fc9
	ld b, $05 ; $5fca
	ld c, $03 ; $5fcc
	farcall FillTilemapRect ; $5fce
	pop hl ; $5fd1
	pop de ; $5fd2
	pop bc ; $5fd3
	pop af ; $5fd4
	ret ; $5fd5
CourtSelect4TabAttrAddrs_3e:
	; $5fd6, 8 bytes (bytes:8)
	db $84, $d4, $8b, $d4, $24, $d5, $2b, $d5 ; 0x00
SetCourtSelect4Palette:
	ld hl, $5ff1 ; $5fde
	add a, a ; $5fe1
	add a, l ; $5fe2
	ld l, a ; $5fe3
	jr nc, Label_3e_5fe7 ; $5fe4
	inc h ; $5fe6
Label_3e_5fe7:
	ld a, [hl+] ; $5fe7
	ld h, [hl] ; $5fe8
	ld l, a ; $5fe9
	ld de, $0401 ; $5fea
	call LoadPaletteShadow ; $5fed
	ret ; $5ff0
	; $5ff1, 18 bytes (records:2)
	dw $6003 ; record 0
	dw $600b ; record 1
	dw $6013 ; record 2
	dw $601b ; record 3
	dw $6003 ; record 4
	dw $6003 ; record 5
	dw $6003 ; record 6
	dw $6003 ; record 7
	dw $6003 ; record 8
	; $6003, 218 bytes (bytes:8)
	db $40, $7d, $ff, $7f, $a0, $3c, $00, $00 ; 0x00
	db $1f, $00, $ff, $7f, $12, $00, $00, $00 ; 0x08
	db $e0, $01, $ff, $7f, $40, $01, $00, $00 ; 0x10
	db $12, $48, $ff, $7f, $08, $00, $00, $00 ; 0x18
	db $f0, $96, $f5, $3e, $03, $e0, $96, $e0 ; 0x20
	db $70, $0e, $02, $cd, $c9, $43, $4f, $c5 ; 0x28
	db $cd, $45, $60, $c1, $c5, $cd, $6f, $60 ; 0x30
	db $c1, $cd, $93, $60, $f1, $e0, $96, $e0 ; 0x38
	db $70, $c9, $21, $ca, $60, $79, $85, $6f ; 0x40
	db $30, $01, $24, $7e, $21, $00, $d2, $85 ; 0x48
	db $6f, $30, $01, $24, $54, $5d, $21, $d3 ; 0x50
	db $60, $01, $05, $00, $cd, $db, $03, $21 ; 0x58
	db $d8, $60, $11, $01, $d2, $01, $05, $00 ; 0x60
	db $cd, $db, $03, $c9, $79, $21, $8a, $60 ; 0x68
	db $85, $6f, $30, $01, $24, $7e, $21, $a9 ; 0x70
	db $00, $85, $6f, $30, $01, $24, $11, $06 ; 0x78
	db $d2, $0e, $20, $df, $72, $05, $c9, $01 ; 0x80
	db $00, $02, $03, $02, $01, $03, $02, $00 ; 0x88
	db $21, $ca, $60, $79, $85, $6f, $30, $01 ; 0x90
	db $24, $7e, $c6, $05, $21, $00, $d2, $85 ; 0x98
	db $6f, $30, $01, $24, $54, $5d, $21, $c1 ; 0xa0
	db $60, $79, $85, $6f, $30, $01, $24, $7e ; 0xa8
	db $21, $a9, $00, $85, $6f, $30, $01, $24 ; 0xb0
	db $0e, $20, $df, $72, $05, $c9, $06, $04 ; 0xb8
	db $04, $05, $06, $05, $04, $07, $06, $0a ; 0xc0
	db $0a, $0a, $0a, $0a, $0a, $0a, $09, $0a ; 0xc8
	db $15, $16, $17, $18, $19, $10, $11, $12 ; 0xd0
	db $13, $14 ; 0xd8
SetCourtSelectBGM:
	ld a, c ; $60dd
	ld hl, CourtSelectBgmIds_3e ; $60de
	add a, l ; $60e1
	ld l, a ; $60e2
	jr nc, Label_3e_60e6 ; $60e3
	inc h ; $60e5
Label_3e_60e6:
	ld a, [hl] ; $60e6
	ld [wMatchBGM], a ; $60e7
	ret ; $60ea
CourtSelectBgmIds_3e:
	; $60eb, 9 bytes (bytes:9)
	db $06, $06, $06, $06, $11, $12, $13, $16, $14 ; 0x00
SetCourtSelectBGMLink:
	ld a, c ; $60f4
	ld hl, CourtSelectBgmIdsLink_3e ; $60f5
	add a, l ; $60f8
	ld l, a ; $60f9
	jr nc, Label_3e_60fd ; $60fa
	inc h ; $60fc
Label_3e_60fd:
	ld a, [hl] ; $60fd
	ld [wMatchBGM], a ; $60fe
	ret ; $6101
CourtSelectBgmIdsLink_3e:
	; $6102, 9 bytes (bytes:9)
	db $07, $07, $07, $07, $11, $12, $13, $16, $14 ; 0x00
LoadCourtSelectHeader:
	call LoadCourtSelectTitleGfx ; $610b
	call DrawCourtSelectTitleRow ; $610e
	call FlushCourtSelectTitleRow ; $6111
	call AdvanceFrame ; $6114
	ret ; $6117
DrawCourtSelectTitleRow:
	ldh a, [hWramBank] ; $6118
	push af ; $611a
	wram_bank $03 ; $611b
	ld a, $12 ; $6121
	ld hl, $d201 ; $6123
	ld c, $20 ; $6126
Label_3e_6128:
	ld [hl], c ; $6128
	inc hl ; $6129
	dec a ; $612a
	jr nz, Label_3e_6128 ; $612b
	call DrawCourtSelectTitleLeft ; $612d
	call DrawCourtSelectTitleRight ; $6130
	pop af ; $6133
	wram_bank ; $6134
	ret ; $6138
DrawCourtSelectTitleLeft:
	ld b, $30 ; $6139
	ld hl, $d1e0 ; $613b
	ld c, $04 ; $613e
	farcall FillIncrementingBytes ; $6140
	ld hl, $d200 ; $6143
	ld c, $04 ; $6146
	farcall FillIncrementingBytes ; $6148
	ld hl, $d220 ; $614b
	ld c, $04 ; $614e
	farcall FillIncrementingBytes ; $6150
	ret ; $6153
DrawCourtSelectTitleRight:
	ld b, $40 ; $6154
	ld hl, $d209 ; $6156
	ld c, $05 ; $6159
	farcall FillIncrementingBytes ; $615b
	ret ; $615e
FlushCourtSelectTitleRow:
	ldh a, [hWramBank] ; $615f
	push af ; $6161
	wram_bank $03 ; $6162
	ld hl, $d1e0 ; $6168
	ld de, $99e0 ; $616b
	ld bc, $0006 ; $616e
	call QueueVRAMCopy ; $6171
	pop af ; $6174
	wram_bank ; $6175
	ret ; $6179
LoadCourtSelectTitleGfx:
	ldh a, [hWramBank] ; $617a
	push af ; $617c
	wram_bank $01 ; $617d
	call LoadCourtSelectTitleTiles ; $6183
	call LoadCourtSelectTitleTiles2 ; $6186
	call LoadCourtSelectPanelTiles ; $6189
	pop af ; $618c
	wram_bank ; $618d
	ret ; $6191
LoadCourtSelectTitleTiles:
	ld hl, Lz_3e_61d4 ; $6192
	ld de, $d000 ; $6195
	call DecompressData ; $6198
	ld hl, $d000 ; $619b
	ld de, $9300 ; $619e
	ld bc, $000c ; $61a1
	call QueueVRAMCopy ; $61a4
	ret ; $61a7
LoadCourtSelectTitleTiles2:
	ld hl, Lz_3e_6273 ; $61a8
	ld de, $d100 ; $61ab
	call DecompressData ; $61ae
	ld hl, $d100 ; $61b1
	ld de, $9400 ; $61b4
	ld bc, $0005 ; $61b7
	call QueueVRAMCopy ; $61ba
	ret ; $61bd
LoadCourtSelectPanelTiles:
	ld hl, Lz_3e_62c6 ; $61be
	ld de, $d200 ; $61c1
	call DecompressData ; $61c4
	ld hl, $d200 ; $61c7
	ld de, $8800 ; $61ca
	ld bc, $0037 ; $61cd
	call QueueVRAMCopy ; $61d0
	ret ; $61d3
Lz_3e_61d4:
	INCBIN "data/bank_03e/d_61d4.bin" ; $61d4, 159 bytes
Lz_3e_6273:
	INCBIN "data/bank_03e/d_6273.bin" ; $6273, 83 bytes
Lz_3e_62c6:
	INCBIN "data/bank_03e/d_62c6.bin" ; $62c6, 457 bytes
DrawCourtNameTiles:
	ldh a, [hWramBank] ; $648f
	push af ; $6491
	wram_bank $03 ; $6492
	push bc ; $6498
	call DrawCourtNameLeft ; $6499
	pop bc ; $649c
	call DrawCourtNameRight ; $649d
	pop af ; $64a0
	wram_bank ; $64a1
	ret ; $64a5
DrawCourtNameLeft:
	ld a, b ; $64a6
	cp a, $ff ; $64a7
	jr nz, Label_3e_64af ; $64a9
	ld b, $ac ; $64ab
	jr Label_3e_64bd ; $64ad
Label_3e_64af:
	ld hl, CourtNameLeftIndices_3e ; $64af
	ld a, b ; $64b2
	add a, l ; $64b3
	ld l, a ; $64b4
	jr nc, Label_3e_64b8 ; $64b5
	inc h ; $64b7
Label_3e_64b8:
	ld a, [hl] ; $64b8
	ld b, $80 ; $64b9
	add a, b ; $64bb
	ld b, a ; $64bc
Label_3e_64bd:
	ld hl, $d204 ; $64bd
	ld c, $05 ; $64c0
	farcall FillIncrementingBytes ; $64c2
	ret ; $64c5
CourtNameLeftIndices_3e:
	; $64c6, 9 bytes (bytes:9)
	db $0b, $00, $16, $21, $16, $0b, $21, $16, $00 ; 0x00
DrawCourtNameRight:
	ld a, b ; $64cf
	cp a, $ff ; $64d0
	jr nz, Label_3e_64d8 ; $64d2
	ld b, $b1 ; $64d4
	jr Label_3e_64e6 ; $64d6
Label_3e_64d8:
	ld hl, CourtNameRightIndices_3e ; $64d8
	ld a, b ; $64db
	add a, l ; $64dc
	ld l, a ; $64dd
	jr nc, Label_3e_64e1 ; $64de
	inc h ; $64e0
Label_3e_64e1:
	ld a, [hl] ; $64e1
	ld b, $80 ; $64e2
	add a, b ; $64e4
	ld b, a ; $64e5
Label_3e_64e6:
	ld hl, $d20e ; $64e6
	ld c, $06 ; $64e9
	farcall FillIncrementingBytes ; $64eb
	ret ; $64ee
CourtNameRightIndices_3e:
	; $64ef, 9 bytes (bytes:9)
	db $1b, $05, $05, $10, $1b, $10, $05, $26, $1b ; 0x00
FadeOutAndResetMenuScreen:
	ldh a, [hWramBank] ; $64f8
	push af ; $64fa
	wram_bank $03 ; $64fb
	ld c, $10 ; $6501
	call BeginFadeOut ; $6503
	call WaitFadeEnd ; $6506
	call DisableLCDSafely ; $6509
	farcall LoadMenuFontGfx ; $650c
	farcall ResetScreenAndTextWindows ; $650f
	pop af ; $6512
	wram_bank ; $6513
	ret ; $6517
RunCourtSelect9Menu:
	ld a, [wUnlockedCourtMask] ; $6518
	ld b, a ; $651b
	call StoreCourtUnlockBits ; $651c
	sound $03 ; $651f
	call ClearFrameTasks ; $6521
	ld hl, rIE ; $6524
	res 2, [hl] ; $6527
	farcall InitMenuBgScroll ; $6529
	ld b, $01 ; $652c
	ld c, $01 ; $652e
	farcall LoadMenuSpritePalettePair ; $6530
	call LoadCourtSelectHeader ; $6533
	wram_bank $03 ; $6536
	ld a, [wMenuSlideDirection] ; $653c
	ld b, a ; $653f
	call OpenCourtSelect9Panel ; $6540
	xor a, a ; $6543
	ld c, a ; $6544
	ld b, $03 ; $6545
	call SetMenuCursorFromIndex_3e ; $6547
	ld a, $01 ; $654a
	ld hl, CourtSelect9CursorSpriteTask ; $654c
	call RegisterFrameTask ; $654f
	call RedrawCourtSelect9Menu ; $6552
	wram_bank $03 ; $6555
Label_3e_655b:
	call AdvanceFrame ; $655b
	ldh a, [hInputPressed] ; $655e
	ld [wMenuInputPressed], a ; $6560
	ld b, $03 ; $6563
	ld c, $03 ; $6565
	call MoveMenuCursorGrid_3e ; $6567
	or a, a ; $656a
	jr z, Label_3e_6572 ; $656b
	sound $5e ; $656d
	call RedrawCourtSelect9Menu ; $656f
Label_3e_6572:
	ld a, [wMenuInputPressed] ; $6572
	bit PADB_A, a ; $6575
	jr nz, Label_3e_657f ; $6577
	bit 1, a ; $6579
	jr nz, Label_3e_65b2 ; $657b
	jr Label_3e_655b ; $657d
Label_3e_657f:
	ld c, $03 ; $657f
	call GetMenuCursorIndex_3e ; $6581
	ld b, a ; $6584
	call IsCourtUnlocked ; $6585
	or a, a ; $6588
	jr nz, Label_3e_658f ; $6589
	sound $61 ; $658b
	jr Label_3e_655b ; $658d
Label_3e_658f:
	sound $60 ; $658f
	call ClearFrameTasks ; $6591
	ld hl, rIE ; $6594
	set 2, [hl] ; $6597
	ld b, $01 ; $6599
	call CloseCourtSelect9Panel ; $659b
	ld a, $01 ; $659e
	ld [wMenuSlideDirection], a ; $65a0
	ld c, $03 ; $65a3
	call GetMenuCursorIndex_3e ; $65a5
	push af ; $65a8
	ld c, a ; $65a9
	call SetCourtSelectBGM ; $65aa
	pop af ; $65ad
	call CourtSelectIndexToCourtId ; $65ae
	ret ; $65b1
Label_3e_65b2:
	sound $62 ; $65b2
	call ClearFrameTasks ; $65b4
	ld hl, rIE ; $65b7
	set 2, [hl] ; $65ba
	ld b, $00 ; $65bc
	call CloseCourtSelect9Panel ; $65be
	ld a, $00 ; $65c1
	ld [wMenuSlideDirection], a ; $65c3
	ld a, $ff ; $65c6
	ret ; $65c8
RunLinkCourtSelect9Menu:
	xor a, a ; $65c9
	ldh [$ffd8], a ; $65ca
	call ResetSerialState ; $65cc
	call ClearFrameTasks ; $65cf
	call EnableTimerInterrupt ; $65d2
	sound $03 ; $65d5
	ld a, [wUnlockedCourtMask] ; $65d7
	ld b, a ; $65da
	ld a, [wLinkPartnerCourtMask] ; $65db
	or a, b ; $65de
	ld b, a ; $65df
	call StoreCourtUnlockBits ; $65e0
	farcall InitMenuBgScroll ; $65e3
	ld b, $01 ; $65e6
	ld c, $01 ; $65e8
	farcall LoadMenuSpritePalettePair ; $65ea
	call LoadCourtSelectHeader ; $65ed
	wram_bank $03 ; $65f0
	ld a, [wMenuSlideDirection] ; $65f6
	ld b, a ; $65f9
	call OpenCourtSelect9Panel ; $65fa
	ld a, [$cb1e] ; $65fd
	ld c, a ; $6600
	ld b, $03 ; $6601
	call SetMenuCursorFromIndex_3e ; $6603
	ld a, $01 ; $6606
	ld hl, CourtSelect9CursorSpriteTask ; $6608
	call RegisterFrameTask ; $660b
	call RedrawCourtSelect9Menu ; $660e
	farcall ResyncLinkSessionWithTimer ; $6611
	push af ; $6614
	farcall RunLinkInputFrame ; $6615
	pop af ; $6618
	push af ; $6619
	farcall RunLinkInputFrame ; $661a
	pop af ; $661d
	push af ; $661e
	farcall RunLinkInputFrame ; $661f
	pop af ; $6622
	wram_bank $03 ; $6623
Label_3e_6629:
	ldh a, [hLinkInput] ; $6629
	ld [wMenuInputPressed], a ; $662b
	push af ; $662e
	farcall RunLinkInputFrame ; $662f
	pop af ; $6632
	ld b, $03 ; $6633
	ld c, $03 ; $6635
	call MoveMenuCursorGrid_3e ; $6637
	or a, a ; $663a
	jr z, Label_3e_6642 ; $663b
	sound $5e ; $663d
	call RedrawCourtSelect9Menu ; $663f
Label_3e_6642:
	ld a, [wMenuInputPressed] ; $6642
	bit PADB_A, a ; $6645
	jr nz, Label_3e_664f ; $6647
	bit 1, a ; $6649
	jr nz, Label_3e_6686 ; $664b
	jr Label_3e_6629 ; $664d
Label_3e_664f:
	ld c, $03 ; $664f
	call GetMenuCursorIndex_3e ; $6651
	ld b, a ; $6654
	call IsCourtUnlocked ; $6655
	or a, a ; $6658
	jr nz, Label_3e_665f ; $6659
	sound $61 ; $665b
	jr Label_3e_6629 ; $665d
Label_3e_665f:
	sound $60 ; $665f
	push af ; $6661
	farcall SyncLinkFrame ; $6662
	pop af ; $6665
	call ClearFrameTasks ; $6666
	xor a, a ; $6669
	ldh [$ffd8], a ; $666a
	call ResetSerialState ; $666c
	call EnableTimerInterrupt ; $666f
	ld a, $01 ; $6672
	ld [wMenuSlideDirection], a ; $6674
	ld c, $03 ; $6677
	call GetMenuCursorIndex_3e ; $6679
	push af ; $667c
	ld c, a ; $667d
	call SetCourtSelectBGMLink ; $667e
	pop af ; $6681
	call CourtSelectIndexToCourtId ; $6682
	ret ; $6685
Label_3e_6686:
	sound $62 ; $6686
	push af ; $6688
	farcall SyncLinkFrame ; $6689
	pop af ; $668c
	xor a, a ; $668d
	ldh [$ffd8], a ; $668e
	call ResetSerialState ; $6690
	call ClearFrameTasks ; $6693
	ld b, $00 ; $6696
	call CloseCourtSelect9Panel ; $6698
	ld a, $00 ; $669b
	ld [wMenuSlideDirection], a ; $669d
	ld c, $10 ; $66a0
	call BeginFadeOut ; $66a2
	call WaitFadeEnd ; $66a5
	ld a, $ff ; $66a8
	ret ; $66aa
OpenCourtSelect9Panel:
	ld a, b ; $66ab
	or a, a ; $66ac
	jr z, Label_3e_66c9 ; $66ad
	ld c, $00 ; $66af
Label_3e_66b1:
	call AdvanceFrame ; $66b1
	ld b, $14 ; $66b4
	farcall RestoreMenuBgAndDrawPanel ; $66b6
	ld b, $00 ; $66b9
	farcall FlushWram3MapRows ; $66bb
	ld a, c ; $66be
	inc a ; $66bf
	ld c, a ; $66c0
	cp a, $0f ; $66c1
	jr nz, Label_3e_66b1 ; $66c3
	call AdvanceFrame ; $66c5
	ret ; $66c8
Label_3e_66c9:
	ld c, $09 ; $66c9
Label_3e_66cb:
	call AdvanceFrame ; $66cb
	ld b, $15 ; $66ce
	farcall RestoreMenuBgAndDrawPanel ; $66d0
	ld b, $00 ; $66d3
	farcall FlushWram3MapRows ; $66d5
	ld a, c ; $66d8
	dec a ; $66d9
	ld c, a ; $66da
	cp a, $ff ; $66db
	jr nz, Label_3e_66cb ; $66dd
	call AdvanceFrame ; $66df
	ret ; $66e2
CloseCourtSelect9Panel:
	ld a, b ; $66e3
	or a, a ; $66e4
	jr z, Label_3e_66fe ; $66e5
	ld c, $00 ; $66e7
Label_3e_66e9:
	call AdvanceFrame ; $66e9
	ld b, $15 ; $66ec
	farcall RestoreMenuBgAndDrawPanel ; $66ee
	ld b, $00 ; $66f1
	farcall FlushWram3MapRows ; $66f3
	ld a, c ; $66f6
	inc a ; $66f7
	ld c, a ; $66f8
	cp a, $0b ; $66f9
	jr nz, Label_3e_66e9 ; $66fb
	ret ; $66fd
Label_3e_66fe:
	ld c, $0e ; $66fe
Label_3e_6700:
	call AdvanceFrame ; $6700
	ld b, $14 ; $6703
	farcall RestoreMenuBgAndDrawPanel ; $6705
	ld b, $00 ; $6708
	farcall FlushWram3MapRows ; $670a
	ld a, c ; $670d
	dec a ; $670e
	ld c, a ; $670f
	or a, a ; $6710
	jr nz, Label_3e_6700 ; $6711
	ret ; $6713
CourtSelect9CursorSpriteTask:
	farcall TickMenuBgScroll ; $6714
	ld c, $03 ; $6717
	call GetMenuCursorIndex_3e ; $6719
	push af ; $671c
	ld hl, CourtSelect9CursorTiles_3e ; $671d
	add a, l ; $6720
	ld l, a ; $6721
	jr nc, Label_3e_6725 ; $6722
	inc h ; $6724
Label_3e_6725:
	ld c, [hl] ; $6725
	pop af ; $6726
	push af ; $6727
	ld hl, CourtSelect9CursorPositions_3e ; $6728
	add a, a ; $672b
	add a, l ; $672c
	ld l, a ; $672d
	jr nc, Label_3e_6731 ; $672e
	inc h ; $6730
Label_3e_6731:
	ld a, [hl+] ; $6731
	ld d, [hl] ; $6732
	ld e, a ; $6733
	farcall ApplySpriteBobOffset ; $6734
	push bc ; $6737
	ld c, $03 ; $6738
	call GetMenuCursorIndex_3e ; $673a
	ld hl, CourtSelect9CursorAttrs_3e ; $673d
	add a, l ; $6740
	ld l, a ; $6741
	jr nc, Label_3e_6745 ; $6742
	inc h ; $6744
Label_3e_6745:
	pop bc ; $6745
	ld b, [hl] ; $6746
	pop af ; $6747
	add a, a ; $6748
	ld hl, CourtSelect9CursorTemplatePtrs_3e ; $6749
	add a, l ; $674c
	ld l, a ; $674d
	jr nc, Label_3e_6751 ; $674e
	inc h ; $6750
Label_3e_6751:
	ld a, [hl+] ; $6751
	ld h, [hl] ; $6752
	ld l, a ; $6753
	push de ; $6754
	call AdjustCursorForLockedCourt ; $6755
	call QueueSpriteTemplate ; $6758
	pop de ; $675b
	ld c, $03 ; $675c
	call GetMenuCursorIndex_3e ; $675e
	ld hl, CourtSelect9LabelYOffsets_3e ; $6761
	add a, l ; $6764
	ld l, a ; $6765
	jr nc, Label_3e_6769 ; $6766
	inc h ; $6768
Label_3e_6769:
	ld a, [hl] ; $6769
	ld h, a ; $676a
	ld l, $f8 ; $676b
	add hl, de ; $676d
	ld d, h ; $676e
	ld e, l ; $676f
	ld hl, SpriteTemplate_3e_67d3 ; $6770
	ld b, $08 ; $6773
	ld c, $72 ; $6775
	call QueueSpriteTemplate ; $6777
	ret ; $677a
CourtSelect9CursorTemplatePtrs_3e:
	INCBIN "data/bank_03e/d_677b.bin" ; $677b, 88 bytes
SpriteTemplate_3e_67d3:
	; $67d3, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
CourtSelect9CursorPositions_3e:
	; $67dc, 18 bytes (bytes:16)
	db $30, $fc, $30, $2c, $30, $5c, $50, $fe, $50, $2c, $50, $5c, $6c, $fc, $6c, $2c ; 0x00
	db $6c, $5c ; 0x10
CourtSelect9CursorTiles_3e:
	; $67ee, 10 bytes (bytes:10)
	db $00, $10, $20, $30, $42, $52, $62, $20, $30, $00 ; 0x00
CourtSelect9CursorAttrs_3e:
	; $67f8, 10 bytes (bytes:10)
	db $08, $08, $08, $08, $08, $08, $08, $00, $00, $00 ; 0x00
CourtSelect9LabelYOffsets_3e:
	; $6802, 10 bytes (bytes:10)
	db $17, $17, $17, $1b, $17, $17, $17, $17, $17, $17 ; 0x00
AdjustCursorForLockedCourt:
	push bc ; $680c
	push hl ; $680d
	ld c, $03 ; $680e
	call GetMenuCursorIndex_3e ; $6810
	ld b, a ; $6813
	call IsCourtUnlocked ; $6814
	or a, a ; $6817
	jr z, Label_3e_681d ; $6818
	pop hl ; $681a
	pop bc ; $681b
	ret ; $681c
Label_3e_681d:
	ld c, $40 ; $681d
	ld b, $00 ; $681f
	pop hl ; $6821
	pop af ; $6822
	ret ; $6823
RedrawCourtSelect9Menu:
	wram_bank $03 ; $6824
	ld b, $00 ; $682a
	ld c, $00 ; $682c
Label_3e_682e:
	call SetCourtSelect9TabAttrRect ; $682e
	ld a, b ; $6831
	inc a ; $6832
	ld b, a ; $6833
	cp a, $09 ; $6834
	jr nz, Label_3e_682e ; $6836
	ld c, $03 ; $6838
	call GetMenuCursorIndex_3e ; $683a
	ld b, a ; $683d
	ld c, $01 ; $683e
	call SetCourtSelect9TabAttrRect ; $6840
	ld c, $03 ; $6843
	call GetMenuCursorIndex_3e ; $6845
	call SetCourtSelect9Palette ; $6848
	ld c, $03 ; $684b
	call GetMenuCursorIndex_3e ; $684d
	ld d, a ; $6850
	ld b, a ; $6851
	call IsCourtUnlocked ; $6852
	or a, a ; $6855
	ld b, $ff ; $6856
	jr z, Label_3e_685b ; $6858
	ld b, d ; $685a
Label_3e_685b:
	call DrawCourtNameTiles ; $685b
	ld hl, $d460 ; $685e
	ld de, $b860 ; $6861
	ld c, $06 ; $6864
	call QueueVRAMCopy ; $6866
	ld hl, $d4e0 ; $6869
	ld de, $b8e0 ; $686c
	ld c, $06 ; $686f
	call QueueVRAMCopy ; $6871
	ld hl, $d560 ; $6874
	ld de, $b960 ; $6877
	ld c, $06 ; $687a
	call QueueVRAMCopy ; $687c
	ld hl, $d200 ; $687f
	ld de, $9a00 ; $6882
	ld c, $02 ; $6885
	call QueueVRAMCopy ; $6887
	ret ; $688a
SetCourtSelect9TabAttrRect:
	push af ; $688b
	push bc ; $688c
	push de ; $688d
	push hl ; $688e
	ld a, c ; $688f
	or a, a ; $6890
	jr z, Label_3e_6897 ; $6891
	ld h, $0c ; $6893
	jr Label_3e_6899 ; $6895
Label_3e_6897:
	ld h, $0d ; $6897
Label_3e_6899:
	push hl ; $6899
	ld hl, CourtSelect9TabAttrAddrs_3e ; $689a
	ld a, b ; $689d
	add a, a ; $689e
	add a, l ; $689f
	ld l, a ; $68a0
	jr nc, Label_3e_68a4 ; $68a1
	inc h ; $68a3
Label_3e_68a4:
	ld a, [hl+] ; $68a4
	ld d, [hl] ; $68a5
	ld e, a ; $68a6
	pop hl ; $68a7
	ld b, $05 ; $68a8
	ld c, $03 ; $68aa
	farcall FillTilemapRect ; $68ac
	pop hl ; $68af
	pop de ; $68b0
	pop bc ; $68b1
	pop af ; $68b2
	ret ; $68b3
CourtSelect9TabAttrAddrs_3e:
	; $68b4, 18 bytes (bytes:16)
	db $61, $d4, $67, $d4, $6d, $d4, $e1, $d4, $e7, $d4, $ed, $d4, $61, $d5, $67, $d5 ; 0x00
	db $6d, $d5 ; 0x10
SetCourtSelect9Palette:
	ld hl, $68d9 ; $68c6
	add a, a ; $68c9
	add a, l ; $68ca
	ld l, a ; $68cb
	jr nc, Label_3e_68cf ; $68cc
	inc h ; $68ce
Label_3e_68cf:
	ld a, [hl+] ; $68cf
	ld h, [hl] ; $68d0
	ld l, a ; $68d1
	ld de, $0401 ; $68d2
	call LoadPaletteShadow ; $68d5
	ret ; $68d8
	; $68d9, 18 bytes (records:2)
	dw $68eb ; record 0
	dw $68f3 ; record 1
	dw $68fb ; record 2
	dw $6903 ; record 3
	dw $691b ; record 4
	dw $6913 ; record 5
	dw $690b ; record 6
	dw $6923 ; record 7
	dw $692b ; record 8
	; $68eb, 111 bytes (bytes:8)
	db $40, $7d, $ff, $7f, $a0, $3c, $00, $00 ; 0x00
	db $1f, $00, $ff, $7f, $12, $00, $00, $00 ; 0x08
	db $e0, $01, $ff, $7f, $40, $01, $00, $00 ; 0x10
	db $12, $48, $ff, $7f, $08, $00, $00, $00 ; 0x18
	db $5e, $79, $ff, $6b, $40, $01, $00, $00 ; 0x20
	db $c0, $2e, $ff, $6b, $12, $00, $00, $00 ; 0x28
	db $1f, $01, $ff, $6b, $40, $01, $00, $00 ; 0x30
	db $e0, $03, $ff, $6b, $40, $01, $00, $00 ; 0x38
	db $1f, $01, $ff, $6b, $8f, $00, $00, $00 ; 0x40
	db $f0, $96, $f5, $3e, $03, $e0, $96, $e0 ; 0x48
	db $70, $0e, $03, $cd, $c9, $43, $47, $57 ; 0x50
	db $7a, $4f, $c5, $cd, $45, $60, $c1, $c5 ; 0x58
	db $cd, $6f, $60, $c1, $cd, $93, $60, $18 ; 0x60
	db $00, $f1, $e0, $96, $e0, $70, $c9 ; 0x68
StoreCourtUnlockBits:
	ldh a, [hWramBank] ; $695a
	push af ; $695c
	wram_bank $02 ; $695d
	ld c, $00 ; $6963
	ld hl, $d000 ; $6965
Label_3e_6968:
	ld a, b ; $6968
	and a, $01 ; $6969
	ld [hl+], a ; $696b
	srl b ; $696c
	ld a, c ; $696e
	inc a ; $696f
	ld c, a ; $6970
	cp a, $05 ; $6971
	jr nz, Label_3e_6968 ; $6973
	pop af ; $6975
	wram_bank ; $6976
	ret ; $697a
IsCourtUnlocked:
	ld a, b ; $697b
	cp a, $04 ; $697c
	jr nc, Label_3e_6983 ; $697e
	ld a, $01 ; $6980
	ret ; $6982
Label_3e_6983:
	ldh a, [hWramBank] ; $6983
	push af ; $6985
	wram_bank $02 ; $6986
	ld a, b ; $698c
	sub a, $04 ; $698d
	ld hl, $d000 ; $698f
	add a, l ; $6992
	ld l, a ; $6993
	jr nc, Label_3e_6997 ; $6994
	inc h ; $6996
Label_3e_6997:
	ld a, [hl] ; $6997
	ld b, a ; $6998
	pop af ; $6999
	wram_bank ; $699a
	ld a, b ; $699e
	ret ; $699f
ComputeUnlockedCourtFlags:
	ld c, $00 ; $69a0
	ld b, $00 ; $69a2
Label_3e_69a4:
	ld a, c ; $69a4
	add a, a ; $69a5
	ld hl, CourtUnlockFlagIds_3e ; $69a6
	add a, l ; $69a9
	ld l, a ; $69aa
	jr nc, Label_3e_69ae ; $69ab
	inc h ; $69ad
Label_3e_69ae:
	ld a, [hl+] ; $69ae
	ld d, [hl] ; $69af
	ld e, a ; $69b0
	farcall TestSaveFlag ; $69b1
	jr z, Label_3e_69ba ; $69b4
	ld a, $01 ; $69b6
	or a, b ; $69b8
	ld b, a ; $69b9
Label_3e_69ba:
	ld a, c ; $69ba
	inc a ; $69bb
	ld c, a ; $69bc
	cp a, $05 ; $69bd
	jr z, Label_3e_69c5 ; $69bf
	sla b ; $69c1
	jr Label_3e_69a4 ; $69c3
Label_3e_69c5:
	ld a, b ; $69c5
	ld [wUnlockedCourtMask], a ; $69c6
	ret ; $69c9
CourtUnlockFlagIds_3e:
	; $69ca, 10 bytes (flag_ids)
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; 0
	flag_id FLAG_WON_ISLAND_OPEN_SINGLES_FINAL ; 1
	flag_id FLAG_WON_DREAM_MATCH_SINGLES ; 2
	dw $0740 ; 3: flag $07, 2
	dw $0720 ; 4: flag $07, 1
StubNop_3e:
	ret ; $69d4
AwardCeremonyTiles:
	INCBIN "data/bank_03e/lz_69d5.bin" ; $69d5, 2641 bytes
AwardCeremonyPalettes:
	; $7426, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $3230, $294a, $294a, $294a ; pal 0: #838b62 #525252 #525252 #525252
	dw $0003, $261f, $1913, $1412 ; pal 1: #180000 #ff834a #9c4131 #940029
	dw $0000, $001f, $7e93, $69cc ; pal 2: #000000 #ff0000 #9ca4ff #6273d5
	dw $6bff, $001f, $021f, $0000 ; pal 3: #ffffd5 #ff0000 #ff8300 #000000
	dw $7e93, $69cc, $021f, $0000 ; pal 4: #9ca4ff #6273d5 #ff8300 #000000
	dw $7e93, $6bff, $021f, $0000 ; pal 5: #9ca4ff #ffffd5 #ff8300 #000000
	dw $7e93, $6bff, $001f, $0000 ; pal 6: #9ca4ff #ffffd5 #ff0000 #000000
	dw $7e93, $6bff, $505c, $0000 ; pal 7: #9ca4ff #ffffd5 #e610a4 #000000
AwardCeremonyTilemap5:
	INCBIN "data/bank_03e/lz_7466.bin" ; $7466, 279 bytes
AwardCeremonyAttrmap5:
	INCBIN "data/bank_03e/lz_757d.bin" ; $757d, 107 bytes
Lz_3e_75e8:
	INCBIN "data/bank_03e/lz_75e8.bin" ; $75e8, 179 bytes
Lz_3e_769b:
	INCBIN "data/bank_03e/lz_769b.bin" ; $769b, 183 bytes
Lz_3e_7752:
	INCBIN "data/bank_03e/lz_7752.bin" ; $7752, 179 bytes
	; $7805, 2043 bytes fill to bank end (linker-padded)
