SECTION "ROM Bank $17", ROMX[$4000], BANK[$17]

FarPtr_ShowCourtDiagramTestScreen:
	dw ShowCourtDiagramTestScreen ; $4000
DataPtr_CourtDiagramTiles:
	dw CourtDiagramTiles ; $4002
DataPtr_CourtDiagramTilemap:
	dw CourtDiagramTilemap ; $4004
DataPtr_CourtDiagramAttrmap:
	dw CourtDiagramAttrmap ; $4006
DataPtr_CourtDiagramPalettes:
	dw CourtDiagramPalettes ; $4008
FarPtr_ShowDrillBriefingScreen:
	dw ShowDrillBriefingScreen ; $400a
FarPtr_ShowRulesScreen:
	dw ShowRulesScreen ; $400c
DataPtr_RulesScreenTiles:
	dw RulesScreenTiles ; $400e
DataPtr_RulesScreenTilemap:
	dw RulesScreenTilemap ; $4010
DataPtr_RulesScreenAttrmap:
	dw RulesScreenAttrmap ; $4012
DataPtr_RulesScreenPalettes:
	dw RulesScreenPalettes ; $4014
	push de ; $4016
	push bc ; $4017
	ld c, $00 ; $4018
	call ApplySpriteWobbleX_17 ; $401a
	ld c, $00 ; $401d
	call ApplySpriteWobbleY_17 ; $401f
	ld c, $00 ; $4022
	ld b, $08 ; $4024
	call QueueSprite ; $4026
	pop bc ; $4029
	pop de ; $402a
	push de ; $402b
	push bc ; $402c
	ld a, b ; $402d
	add a, d ; $402e
	ld d, a ; $402f
	push de ; $4030
	ld c, $01 ; $4031
	call ApplySpriteWobbleX_17 ; $4033
	ld c, $00 ; $4036
	call ApplySpriteWobbleY_17 ; $4038
	ld c, $00 ; $403b
	ld b, $28 ; $403d
	call QueueSprite ; $403f
	pop de ; $4042
	pop bc ; $4043
	pop de ; $4044
	push de ; $4045
	push bc ; $4046
	ld a, c ; $4047
	add a, e ; $4048
	ld e, a ; $4049
	ld a, b ; $404a
	add a, d ; $404b
	ld d, a ; $404c
	push de ; $404d
	ld c, $01 ; $404e
	call ApplySpriteWobbleX_17 ; $4050
	ld c, $01 ; $4053
	call ApplySpriteWobbleY_17 ; $4055
	ld c, $00 ; $4058
	ld b, $68 ; $405a
	call QueueSprite ; $405c
	pop de ; $405f
	pop bc ; $4060
	pop de ; $4061
	ld a, e ; $4062
	add a, c ; $4063
	ld e, a ; $4064
	push de ; $4065
	ld c, $00 ; $4066
	call ApplySpriteWobbleX_17 ; $4068
	ld c, $01 ; $406b
	call ApplySpriteWobbleY_17 ; $406d
	ld c, $00 ; $4070
	ld b, $48 ; $4072
	call QueueSprite ; $4074
	pop de ; $4077
	ret ; $4078
ApplySpriteWobbleX_17:
	ldh a, [hVBlankCounter] ; $4079
	and a, $0f ; $407b
	ld hl, $4093 ; $407d
	add a, l ; $4080
	ld l, a ; $4081
	jr nc, Label_17_4085 ; $4082
	inc h ; $4084
Label_17_4085:
	ld a, [hl] ; $4085
	ld b, a ; $4086
	ld a, c ; $4087
	or a, a ; $4088
	jr z, Label_17_408f ; $4089
	ld a, b ; $408b
	add a, d ; $408c
	ld d, a ; $408d
	ret ; $408e
Label_17_408f:
	ld a, d ; $408f
	sub a, b ; $4090
	ld d, a ; $4091
	ret ; $4092
	INCBIN "data/bank_017/d_4093.bin" ; $4093, 16 bytes
ApplySpriteWobbleY_17:
	ldh a, [hVBlankCounter] ; $40a3
	and a, $0f ; $40a5
	ld hl, $40bd ; $40a7
	add a, l ; $40aa
	ld l, a ; $40ab
	jr nc, Label_17_40af ; $40ac
	inc h ; $40ae
Label_17_40af:
	ld a, [hl] ; $40af
	ld b, a ; $40b0
	ld a, c ; $40b1
	or a, a ; $40b2
	jr z, Label_17_40b9 ; $40b3
	ld a, b ; $40b5
	add a, e ; $40b6
	ld e, a ; $40b7
	ret ; $40b8
Label_17_40b9:
	ld a, e ; $40b9
	sub a, b ; $40ba
	ld e, a ; $40bb
	ret ; $40bc
	nop ; $40bd
	nop ; $40be
	nop ; $40bf
	ld bc, $0101 ; $40c0
	ld bc, $0101 ; $40c3
	ld bc, $0001 ; $40c6
	nop ; $40c9
	nop ; $40ca
	nop ; $40cb
	nop ; $40cc
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
	add a, d ; $40db
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
	add a, e ; $40eb
	ld e, a ; $40ec
	ld a, b ; $40ed
	add a, d ; $40ee
	ld d, a ; $40ef
	push de ; $40f0
	ld c, $00 ; $40f1
	ld b, $69 ; $40f3
	call QueueSprite ; $40f5
	pop de ; $40f8
	pop bc ; $40f9
	pop de ; $40fa
	ld a, e ; $40fb
	add a, c ; $40fc
	ld e, a ; $40fd
	push de ; $40fe
	ld c, $00 ; $40ff
	ld b, $49 ; $4101
	call QueueSprite ; $4103
	pop de ; $4106
	ret ; $4107
	ld a, [wMenuCursorX] ; $4108
	ld d, a ; $410b
	ld a, [wMenuCursorY] ; $410c
	ld e, a ; $410f
	ld a, [wMenuInputPressed] ; $4110
	bit 4, a ; $4113
	jr z, Label_17_412c ; $4115
	ld a, [wMenuCursorX] ; $4117
	inc a ; $411a
	add a, a ; $411b
	jr nc, Label_17_4122 ; $411c
	ld a, b ; $411e
	dec a ; $411f
	jr Label_17_4127 ; $4120
Label_17_4122:
	rra ; $4122
	cp a, b ; $4123
	jr c, Label_17_4127 ; $4124
	xor a, a ; $4126
Label_17_4127:
	ld [wMenuCursorX], a ; $4127
	jr Label_17_4175 ; $412a
Label_17_412c:
	bit 5, a ; $412c
	jr z, Label_17_4145 ; $412e
	ld a, [wMenuCursorX] ; $4130
	dec a ; $4133
	add a, a ; $4134
	jr nc, Label_17_413b ; $4135
	ld a, b ; $4137
	dec a ; $4138
	jr Label_17_4140 ; $4139
Label_17_413b:
	rra ; $413b
	cp a, b ; $413c
	jr c, Label_17_4140 ; $413d
	xor a, a ; $413f
Label_17_4140:
	ld [wMenuCursorX], a ; $4140
	jr Label_17_4175 ; $4143
Label_17_4145:
	bit 6, a ; $4145
	jr z, Label_17_415e ; $4147
	ld a, [wMenuCursorY] ; $4149
	dec a ; $414c
	add a, a ; $414d
	jr nc, Label_17_4154 ; $414e
	ld a, c ; $4150
	dec a ; $4151
	jr Label_17_4159 ; $4152
Label_17_4154:
	rra ; $4154
	cp a, c ; $4155
	jr c, Label_17_4159 ; $4156
	xor a, a ; $4158
Label_17_4159:
	ld [wMenuCursorY], a ; $4159
	jr Label_17_4175 ; $415c
Label_17_415e:
	bit 7, a ; $415e
	jr z, Label_17_4175 ; $4160
	ld a, [wMenuCursorY] ; $4162
	inc a ; $4165
	add a, a ; $4166
	jr nc, Label_17_416d ; $4167
	ld a, c ; $4169
	dec a ; $416a
	jr Label_17_4172 ; $416b
Label_17_416d:
	rra ; $416d
	cp a, c ; $416e
	jr c, Label_17_4172 ; $416f
	xor a, a ; $4171
Label_17_4172:
	ld [wMenuCursorY], a ; $4172
Label_17_4175:
	ld a, [wMenuCursorX] ; $4175
	cp a, d ; $4178
	jr nz, Label_17_4183 ; $4179
	ld a, [wMenuCursorY] ; $417b
	cp a, e ; $417e
	jr nz, Label_17_4183 ; $417f
	xor a, a ; $4181
	ret ; $4182
Label_17_4183:
	ld a, $01 ; $4183
	ret ; $4185
	ld a, [wMenuCursorX] ; $4186
	ld d, a ; $4189
	ld a, [wMenuCursorY] ; $418a
	ld e, a ; $418d
	ldh a, [$ffd3] ; $418e
	bit 4, a ; $4190
	jr z, Label_17_41a9 ; $4192
	ld a, [wMenuCursorX] ; $4194
	inc a ; $4197
	add a, a ; $4198
	jr nc, Label_17_419f ; $4199
	ld a, b ; $419b
	dec a ; $419c
	jr Label_17_41a4 ; $419d
Label_17_419f:
	rra ; $419f
	cp a, b ; $41a0
	jr c, Label_17_41a4 ; $41a1
	xor a, a ; $41a3
Label_17_41a4:
	ld [wMenuCursorX], a ; $41a4
	jr Label_17_41f2 ; $41a7
Label_17_41a9:
	bit 5, a ; $41a9
	jr z, Label_17_41c2 ; $41ab
	ld a, [wMenuCursorX] ; $41ad
	dec a ; $41b0
	add a, a ; $41b1
	jr nc, Label_17_41b8 ; $41b2
	ld a, b ; $41b4
	dec a ; $41b5
	jr Label_17_41bd ; $41b6
Label_17_41b8:
	rra ; $41b8
	cp a, b ; $41b9
	jr c, Label_17_41bd ; $41ba
	xor a, a ; $41bc
Label_17_41bd:
	ld [wMenuCursorX], a ; $41bd
	jr Label_17_41f2 ; $41c0
Label_17_41c2:
	bit 6, a ; $41c2
	jr z, Label_17_41db ; $41c4
	ld a, [wMenuCursorY] ; $41c6
	dec a ; $41c9
	add a, a ; $41ca
	jr nc, Label_17_41d1 ; $41cb
	ld a, c ; $41cd
	dec a ; $41ce
	jr Label_17_41d6 ; $41cf
Label_17_41d1:
	rra ; $41d1
	cp a, c ; $41d2
	jr c, Label_17_41d6 ; $41d3
	xor a, a ; $41d5
Label_17_41d6:
	ld [wMenuCursorY], a ; $41d6
	jr Label_17_41f2 ; $41d9
Label_17_41db:
	bit 7, a ; $41db
	jr z, Label_17_41f2 ; $41dd
	ld a, [wMenuCursorY] ; $41df
	inc a ; $41e2
	add a, a ; $41e3
	jr nc, Label_17_41ea ; $41e4
	ld a, c ; $41e6
	dec a ; $41e7
	jr Label_17_41ef ; $41e8
Label_17_41ea:
	rra ; $41ea
	cp a, c ; $41eb
	jr c, Label_17_41ef ; $41ec
	xor a, a ; $41ee
Label_17_41ef:
	ld [wMenuCursorY], a ; $41ef
Label_17_41f2:
	ld a, [wMenuCursorX] ; $41f2
	cp a, d ; $41f5
	jr nz, Label_17_4200 ; $41f6
	ld a, [wMenuCursorY] ; $41f8
	cp a, e ; $41fb
	jr nz, Label_17_4200 ; $41fc
	xor a, a ; $41fe
	ret ; $41ff
Label_17_4200:
	ld a, $01 ; $4200
	ret ; $4202
	ld a, [wMenuCursorX] ; $4203
	ld d, a ; $4206
	ld a, [wMenuCursorY] ; $4207
	ld e, a ; $420a
	ldh a, [$ffc2] ; $420b
	cp a, $02 ; $420d
	jr z, Label_17_421c ; $420f
	cp a, $01 ; $4211
	jr z, Label_17_4218 ; $4213
	call LinkErrorReset ; $4215
Label_17_4218:
	ldh a, [$ffd5] ; $4218
	jr Label_17_421e ; $421a
Label_17_421c:
	ldh a, [$ffd4] ; $421c
Label_17_421e:
	ld h, a ; $421e
	ld a, [$cb08] ; $421f
	and a, $01 ; $4222
	ld a, h ; $4224
	jr nz, Label_17_428b ; $4225
	bit 4, a ; $4227
	jr z, Label_17_4240 ; $4229
	ld a, [wMenuCursorX] ; $422b
	inc a ; $422e
	add a, a ; $422f
	jr nc, Label_17_4236 ; $4230
	ld a, b ; $4232
	dec a ; $4233
	jr Label_17_423b ; $4234
Label_17_4236:
	rra ; $4236
	cp a, b ; $4237
	jr c, Label_17_423b ; $4238
	xor a, a ; $423a
Label_17_423b:
	ld [wMenuCursorX], a ; $423b
	jr Label_17_42bd ; $423e
Label_17_4240:
	bit 5, a ; $4240
	jr z, Label_17_4259 ; $4242
	ld a, [wMenuCursorX] ; $4244
	dec a ; $4247
	add a, a ; $4248
	jr nc, Label_17_424f ; $4249
	ld a, b ; $424b
	dec a ; $424c
	jr Label_17_4254 ; $424d
Label_17_424f:
	rra ; $424f
	cp a, b ; $4250
	jr c, Label_17_4254 ; $4251
	xor a, a ; $4253
Label_17_4254:
	ld [wMenuCursorX], a ; $4254
	jr Label_17_42bd ; $4257
Label_17_4259:
	bit 6, a ; $4259
	jr z, Label_17_4272 ; $425b
	ld a, [wMenuCursorY] ; $425d
	dec a ; $4260
	add a, a ; $4261
	jr nc, Label_17_4268 ; $4262
	ld a, c ; $4264
	dec a ; $4265
	jr Label_17_426d ; $4266
Label_17_4268:
	rra ; $4268
	cp a, c ; $4269
	jr c, Label_17_426d ; $426a
	xor a, a ; $426c
Label_17_426d:
	ld [wMenuCursorY], a ; $426d
	jr Label_17_42bd ; $4270
Label_17_4272:
	bit 7, a ; $4272
	jr z, Label_17_428b ; $4274
	ld a, [wMenuCursorY] ; $4276
	inc a ; $4279
	add a, a ; $427a
	jr nc, Label_17_4281 ; $427b
	ld a, c ; $427d
	dec a ; $427e
	jr Label_17_4286 ; $427f
Label_17_4281:
	rra ; $4281
	cp a, c ; $4282
	jr c, Label_17_4286 ; $4283
	xor a, a ; $4285
Label_17_4286:
	ld [wMenuCursorY], a ; $4286
	jr Label_17_42bd ; $4289
Label_17_428b:
	bit 0, a ; $428b
	jr z, Label_17_42a3 ; $428d
	sound $5f ; $428f
	ld a, [$cb08] ; $4291
	ld b, a ; $4294
	and a, $01 ; $4295
	jr nz, Label_17_42bd ; $4297
	sound $5f ; $4299
	ld a, b ; $429b
	or a, $01 ; $429c
	ld [$cb08], a ; $429e
	jr Label_17_42bd ; $42a1
Label_17_42a3:
	bit 1, a ; $42a3
	jr z, Label_17_42bd ; $42a5
	sound $62 ; $42a7
	ld a, [$cb08] ; $42a9
	ld b, a ; $42ac
	and a, $03 ; $42ad
	ld a, b ; $42af
	jr nz, Label_17_42b8 ; $42b0
	and a, $fa ; $42b2
	or a, $04 ; $42b4
	jr Label_17_42ba ; $42b6
Label_17_42b8:
	and a, $fe ; $42b8
Label_17_42ba:
	ld [$cb08], a ; $42ba
Label_17_42bd:
	ld a, [wMenuCursorX] ; $42bd
	cp a, d ; $42c0
	jr nz, Label_17_42cb ; $42c1
	ld a, [wMenuCursorY] ; $42c3
	cp a, e ; $42c6
	jr nz, Label_17_42cb ; $42c7
	xor a, a ; $42c9
	ret ; $42ca
Label_17_42cb:
	ld a, $01 ; $42cb
	ret ; $42cd
	ld a, [$cb06] ; $42ce
	ld d, a ; $42d1
	ld a, [$cb07] ; $42d2
	ld e, a ; $42d5
	ldh a, [$ffc2] ; $42d6
	cp a, $02 ; $42d8
	jr z, Label_17_42e7 ; $42da
	cp a, $01 ; $42dc
	jr z, Label_17_42e3 ; $42de
	call LinkErrorReset ; $42e0
Label_17_42e3:
	ldh a, [$ffd4] ; $42e3
	jr Label_17_42e9 ; $42e5
Label_17_42e7:
	ldh a, [$ffd5] ; $42e7
Label_17_42e9:
	ld h, a ; $42e9
	ld a, [$cb08] ; $42ea
	and a, $02 ; $42ed
	ld a, h ; $42ef
	jr nz, Label_17_4356 ; $42f0
	bit 4, a ; $42f2
	jr z, Label_17_430b ; $42f4
	ld a, [$cb06] ; $42f6
	inc a ; $42f9
	add a, a ; $42fa
	jr nc, Label_17_4301 ; $42fb
	ld a, b ; $42fd
	dec a ; $42fe
	jr Label_17_4306 ; $42ff
Label_17_4301:
	rra ; $4301
	cp a, b ; $4302
	jr c, Label_17_4306 ; $4303
	xor a, a ; $4305
Label_17_4306:
	ld [$cb06], a ; $4306
	jr Label_17_4386 ; $4309
Label_17_430b:
	bit 5, a ; $430b
	jr z, Label_17_4324 ; $430d
	ld a, [$cb06] ; $430f
	dec a ; $4312
	add a, a ; $4313
	jr nc, Label_17_431a ; $4314
	ld a, b ; $4316
	dec a ; $4317
	jr Label_17_431f ; $4318
Label_17_431a:
	rra ; $431a
	cp a, b ; $431b
	jr c, Label_17_431f ; $431c
	xor a, a ; $431e
Label_17_431f:
	ld [$cb06], a ; $431f
	jr Label_17_4386 ; $4322
Label_17_4324:
	bit 6, a ; $4324
	jr z, Label_17_433d ; $4326
	ld a, [$cb07] ; $4328
	dec a ; $432b
	add a, a ; $432c
	jr nc, Label_17_4333 ; $432d
	ld a, c ; $432f
	dec a ; $4330
	jr Label_17_4338 ; $4331
Label_17_4333:
	rra ; $4333
	cp a, c ; $4334
	jr c, Label_17_4338 ; $4335
	xor a, a ; $4337
Label_17_4338:
	ld [$cb07], a ; $4338
	jr Label_17_4386 ; $433b
Label_17_433d:
	bit 7, a ; $433d
	jr z, Label_17_4356 ; $433f
	ld a, [$cb07] ; $4341
	inc a ; $4344
	add a, a ; $4345
	jr nc, Label_17_434c ; $4346
	ld a, c ; $4348
	dec a ; $4349
	jr Label_17_4351 ; $434a
Label_17_434c:
	rra ; $434c
	cp a, c ; $434d
	jr c, Label_17_4351 ; $434e
	xor a, a ; $4350
Label_17_4351:
	ld [$cb07], a ; $4351
	jr Label_17_4386 ; $4354
Label_17_4356:
	bit 0, a ; $4356
	jr z, Label_17_436c ; $4358
	ld a, [$cb08] ; $435a
	ld b, a ; $435d
	and a, $02 ; $435e
	jr nz, Label_17_4386 ; $4360
	sound $5f ; $4362
	ld a, b ; $4364
	or a, $02 ; $4365
	ld [$cb08], a ; $4367
	jr Label_17_4386 ; $436a
Label_17_436c:
	bit 1, a ; $436c
	jr z, Label_17_4386 ; $436e
	sound $62 ; $4370
	ld a, [$cb08] ; $4372
	ld b, a ; $4375
	and a, $03 ; $4376
	ld a, b ; $4378
	jr nz, Label_17_4381 ; $4379
	and a, $f5 ; $437b
	or a, $08 ; $437d
	jr Label_17_4383 ; $437f
Label_17_4381:
	and a, $fd ; $4381
Label_17_4383:
	ld [$cb08], a ; $4383
Label_17_4386:
	ld a, [$cb06] ; $4386
	cp a, d ; $4389
	jr nz, Label_17_4394 ; $438a
	ld a, [$cb07] ; $438c
	cp a, e ; $438f
	jr nz, Label_17_4394 ; $4390
	xor a, a ; $4392
	ret ; $4393
Label_17_4394:
	ld a, $01 ; $4394
	ret ; $4396
	ld a, [wMenuCursorY] ; $4397
	ld b, a ; $439a
	xor a, a ; $439b
	inc b ; $439c
Label_17_439d:
	dec b ; $439d
	jr z, Label_17_43a3 ; $439e
	add a, c ; $43a0
	jr Label_17_439d ; $43a1
Label_17_43a3:
	ld b, a ; $43a3
	ld a, [wMenuCursorX] ; $43a4
	add a, b ; $43a7
	ret ; $43a8
	push bc ; $43a9
	ld a, [hl-] ; $43aa
	ld b, a ; $43ab
	xor a, a ; $43ac
	inc b ; $43ad
Label_17_43ae:
	dec b ; $43ae
	jr z, Label_17_43b4 ; $43af
	add a, c ; $43b1
	jr Label_17_43ae ; $43b2
Label_17_43b4:
	ld b, a ; $43b4
	ld a, [hl] ; $43b5
	add a, b ; $43b6
	pop bc ; $43b7
	ret ; $43b8
	INCBIN "data/bank_017/d_43b9.bin" ; $43b9, 3 bytes
Label_17_43bc:
	cp a, b ; $43bc
	jr c, Label_17_43c3 ; $43bd
	inc d ; $43bf
	sub a, b ; $43c0
	jr Label_17_43bc ; $43c1
Label_17_43c3:
	ld [wMenuCursorX], a ; $43c3
	ld a, d ; $43c6
	ld [wMenuCursorY], a ; $43c7
	ret ; $43ca
	INCBIN "data/bank_017/d_43cb.bin" ; $43cb, 3 bytes
Label_17_43ce:
	cp a, b ; $43ce
	jr c, Label_17_43d5 ; $43cf
	inc d ; $43d1
	sub a, b ; $43d2
	jr Label_17_43ce ; $43d3
Label_17_43d5:
	ld [hl+], a ; $43d5
	ld a, d ; $43d6
	ld [hl], a ; $43d7
	ret ; $43d8
	ldh a, [hWramBank] ; $43d9
	push af ; $43db
	wram_bank $03 ; $43dc
	xor a, a ; $43e2
	ld c, $40 ; $43e3
Label_17_43e5:
	ld [hl+], a ; $43e5
	dec c ; $43e6
	jr nz, Label_17_43e5 ; $43e7
	pop af ; $43e9
	wram_bank ; $43ea
	ret ; $43ee
	ldh a, [hWramBank] ; $43ef
	push af ; $43f1
	wram_bank $03 ; $43f2
	ld a, $00 ; $43f8
	ld c, $40 ; $43fa
Label_17_43fc:
	ld [hl+], a ; $43fc
	dec c ; $43fd
	jr nz, Label_17_43fc ; $43fe
	pop af ; $4400
	wram_bank ; $4401
	ret ; $4405
	farcall FarPtr_39_04 ; $4406
	ret ; $4409
	push af ; $440a
	push bc ; $440b
Label_17_440c:
	ld a, [hl] ; $440c
	cp a, $00 ; $440d
	jr z, Label_17_4440 ; $440f
	ld [de], a ; $4411
	inc hl ; $4412
	ld a, [hl] ; $4413
	cp a, $de ; $4414
	jr z, Label_17_441c ; $4416
	cp a, $df ; $4418
	jr nz, Label_17_4431 ; $441a
Label_17_441c:
	push hl ; $441c
	push bc ; $441d
	ld h, d ; $441e
	ld l, e ; $441f
	ld bc, $ffe0 ; $4420
	add hl, bc ; $4423
	ld b, a ; $4424
	ld a, [hl] ; $4425
	cp a, $03 ; $4426
	ld a, b ; $4428
	jr nz, Label_17_442d ; $4429
	sub a, $d0 ; $442b
Label_17_442d:
	ld [hl], a ; $442d
	pop bc ; $442e
	pop hl ; $442f
	inc hl ; $4430
Label_17_4431:
	inc de ; $4431
	ld a, e ; $4432
	and a, $1f ; $4433
	jr nz, Label_17_440c ; $4435
	push hl ; $4437
	ld h, d ; $4438
	ld l, e ; $4439
	add hl, de ; $443a
	ld d, h ; $443b
	ld e, l ; $443c
	pop hl ; $443d
	jr Label_17_440c ; $443e
Label_17_4440:
	pop bc ; $4440
	pop af ; $4441
	ret ; $4442
	push af ; $4443
	push bc ; $4444
	push hl ; $4445
	add sp, -10 ; $4446
	push bc ; $4448
	push de ; $4449
	ld c, l ; $444a
	ld b, h ; $444b
	ld hl, sp + 4 ; $444c
	ld e, l ; $444e
	ld d, h ; $444f
	ld l, c ; $4450
	ld h, b ; $4451
	ld c, e ; $4452
	ld b, d ; $4453
	call FormatDecimalNumber ; $4454
	ld l, c ; $4457
	ld h, b ; $4458
	pop de ; $4459
	pop bc ; $445a
	call DrawAsciiDigitString_17 ; $445b
	add sp, 10 ; $445e
	pop hl ; $4460
	pop bc ; $4461
	pop af ; $4462
	ret ; $4463
DrawAsciiDigitString_17:
	ld a, [hl+] ; $4464
	and a, a ; $4465
	jr z, Label_17_446d ; $4466
	call DrawAsciiDigitChar_17 ; $4468
	jr DrawAsciiDigitString_17 ; $446b
Label_17_446d:
	ret ; $446d
DrawAsciiDigitChar_17:
	push hl ; $446e
	ld hl, $d240 ; $446f
	sub a, $30 ; $4472
	jr c, Label_17_4484 ; $4474
	add a, $30 ; $4476
	ld b, a ; $4478
	wram_bank $03 ; $4479
	ld a, b ; $447f
	ld [de], a ; $4480
	inc de ; $4481
	pop hl ; $4482
	ret ; $4483
Label_17_4484:
	inc de ; $4484
	pop hl ; $4485
	ret ; $4486
ShowDrillBriefingScreen:
	xor a, a ; $4487
	ldh [hBGColumnBlitPending], a ; $4488
	ldh [hBGRowBlitPending], a ; $448a
	ldh [hScrollY], a ; $448c
	ldh [hScrollX], a ; $448e
	ld [$c321], a ; $4490
	ld [$c323], a ; $4493
	call ClearFrameTasks ; $4496
	call DisableLCDSafely ; $4499
	call LoadCourtDiagramScreen ; $449c
	farcall FarPtr_PrepareGlyphBuffer ; $449f
	call EnableLCD ; $44a2
	xor a, a ; $44a5
	ld [$cb0b], a ; $44a6
	ld a, $01 ; $44a9
	ld hl, $4406 ; $44ab
	call RegisterFrameTask ; $44ae
	ld a, $03 ; $44b1
	ld [$cb0c], a ; $44b3
	ld c, $10 ; $44b6
	call BeginFadeIn ; $44b8
	call WaitFadeEnd ; $44bb
	ld a, [$c8f7] ; $44be
	cp a, $12 ; $44c1
	jr nc, Label_17_44e7 ; $44c3
	sub a, $03 ; $44c5
	cp a, $04 ; $44c7
	jr c, Label_17_44d3 ; $44c9
	sub a, $03 ; $44cb
	cp a, $06 ; $44cd
	jr c, Label_17_44d3 ; $44cf
	sub a, $03 ; $44d1
Label_17_44d3:
	ld a, a ; $44d3
	rst Rst00 ; $44d4
	dw DrillBriefing_ServeToTargets ; $44d5 jumptable
	dw DrillBriefing_SpinServe ; $44d7 jumptable
	dw DrillBriefing_ServeThroughPoles ; $44d9 jumptable
	dw DrillBriefing_ServeAndVolley ; $44db jumptable
	dw DrillBriefing_ServeAndSmash ; $44dd jumptable
	dw DrillBriefing_ServeAndSmash2 ; $44df jumptable
	dw DrillBriefing_ReturnToTarget ; $44e1 jumptable
	dw DrillBriefing_ReturnLob ; $44e3 jumptable
	dw DrillBriefing_ReturnDownLine ; $44e5 jumptable
Label_17_44e7:
	call ClearFrameTasks ; $44e7
	ret ; $44ea
ShowCourtDiagramTestScreen:
	call DisableLCDSafely ; $44eb
	call LoadCourtDiagramScreen ; $44ee
	call EnableLCD ; $44f1
	xor a, a ; $44f4
	ld [$cb0b], a ; $44f5
	ld a, $01 ; $44f8
	ld hl, $4406 ; $44fa
	call RegisterFrameTask ; $44fd
	ld a, $03 ; $4500
	ld [$cb0c], a ; $4502
	ld c, $10 ; $4505
	call BeginFadeIn ; $4507
	call WaitFadeEnd ; $450a
	ld a, $50 ; $450d
	ld [$d810], a ; $450f
	ld a, $40 ; $4512
	ld [$d811], a ; $4514
	ld a, $01 ; $4517
	ld hl, $46e2 ; $4519
	call RegisterFrameTask ; $451c
	ld a, $30 ; $451f
	ld [$d812], a ; $4521
	ld a, $20 ; $4524
	ld [$d813], a ; $4526
	ld a, $01 ; $4529
	ld hl, $470c ; $452b
	call RegisterFrameTask ; $452e
	ld a, $60 ; $4531
	ld [$d81e], a ; $4533
	ld a, $30 ; $4536
	ld [$d81f], a ; $4538
	ld a, $01 ; $453b
	ld hl, $4736 ; $453d
	call RegisterFrameTask ; $4540
	ld a, $01 ; $4543
	ld [$d82d], a ; $4545
	ld a, $60 ; $4548
	ld [$d81c], a ; $454a
	ld a, $40 ; $454d
	ld [$d81d], a ; $454f
	ld a, $01 ; $4552
	ld hl, $4754 ; $4554
	call RegisterFrameTask ; $4557
	ld hl, $00e4 ; $455a
	call DrawBriefingCaption ; $455d
	call WaitForInputBlinking ; $4560
	call ClearFrameTasks ; $4563
	ld a, $01 ; $4566
	ld hl, $4406 ; $4568
	call RegisterFrameTask ; $456b
	ld a, $09 ; $456e
	ld [$d822], a ; $4570
	ld a, $40 ; $4573
	ld [$d814], a ; $4575
	ld a, $32 ; $4578
	ld [$d815], a ; $457a
	ld a, $01 ; $457d
	ld hl, $478e ; $457f
	call RegisterFrameTask ; $4582
	ld a, $40 ; $4585
	ld [$d81a], a ; $4587
	ld a, $20 ; $458a
	ld [$d81b], a ; $458c
	ld a, $50 ; $458f
	ld [$d820], a ; $4591
	ld a, $20 ; $4594
	ld [$d821], a ; $4596
	ld a, $01 ; $4599
	ld hl, $47ef ; $459b
	call RegisterFrameTask ; $459e
	ld a, $01 ; $45a1
	ld [$d825], a ; $45a3
	ld a, $30 ; $45a6
	ld [$d823], a ; $45a8
	ld a, $20 ; $45ab
	ld [$d824], a ; $45ad
	ld a, $01 ; $45b0
	ld hl, $481c ; $45b2
	call RegisterFrameTask ; $45b5
	ld a, $01 ; $45b8
	ld [$d826], a ; $45ba
	ld a, $20 ; $45bd
	ld [$d816], a ; $45bf
	ld a, $40 ; $45c2
	ld [$d817], a ; $45c4
	ld a, $01 ; $45c7
	ld hl, $4843 ; $45c9
	call RegisterFrameTask ; $45cc
	ld a, $03 ; $45cf
	ld [$d827], a ; $45d1
	ld a, $10 ; $45d4
	ld [$d818], a ; $45d6
	ld a, $10 ; $45d9
	ld [$d819], a ; $45db
	ld a, $01 ; $45de
	ld hl, $4876 ; $45e0
	call RegisterFrameTask ; $45e3
	ld a, $18 ; $45e6
	ld [$d82a], a ; $45e8
	ld a, $08 ; $45eb
	ld [$d82b], a ; $45ed
	ld a, $20 ; $45f0
	ld [$d828], a ; $45f2
	ld a, $40 ; $45f5
	ld [$d829], a ; $45f7
	ld a, $01 ; $45fa
	ld hl, $48c1 ; $45fc
	call RegisterFrameTask ; $45ff
	ld hl, $0135 ; $4602
	call DrawBriefingCaption ; $4605
	ld b, $02 ; $4608
	call DrawDiagramTargetOverlay ; $460a
	ld a, $01 ; $460d
	ld hl, $4676 ; $460f
	call RegisterFrameTask ; $4612
	call WaitForInputBlinking ; $4615
	call ClearFrameTasks ; $4618
	ld a, $01 ; $461b
	ld hl, $4406 ; $461d
	call RegisterFrameTask ; $4620
	ld b, $00 ; $4623
	call DrawDiagramTargetOverlay ; $4625
	ld hl, $00e4 ; $4628
	call DrawBriefingCaption ; $462b
	ld a, $70 ; $462e
	ld [$d81c], a ; $4630
	ld a, $20 ; $4633
	ld [$d81d], a ; $4635
	ld a, $01 ; $4638
	ld hl, $4754 ; $463a
	call RegisterFrameTask ; $463d
	ld b, $05 ; $4640
	call DrawDiagramTargetOverlay ; $4642
	ld a, $01 ; $4645
	ld hl, $4676 ; $4647
	call RegisterFrameTask ; $464a
	call WaitForInputBlinking ; $464d
	call ClearFrameTasks ; $4650
	ret ; $4653
DrawBriefingCaption:
	call ClearBriefingCaptionTilemap ; $4654
	farcall FarPtr_PrepareGlyphBuffer ; $4657
	ld de, $d181 ; $465a
	ld c, $12 ; $465d
	farcall FarPtr_RenderProportionalTextAt ; $465f
	farcall FarPtr_UploadGlyphBuffer ; $4662
	call QueueCaptionRowToVRAM ; $4665
	call AdvanceFrame ; $4668
	ret ; $466b
DrawDiagramTargetOverlay:
	call RestoreDiagramServiceBoxes ; $466c
	call DrawDiagramTargetPatch ; $466f
	call QueueDiagramServiceBoxesToVRAM ; $4672
	ret ; $4675
	ldh a, [hWramBank] ; $4676
	push af ; $4678
	wram_bank $03 ; $4679
	ld hl, $4ed2 ; $467f
	ld de, $d830 ; $4682
	ld bc, $0008 ; $4685
	call CopyMemoryBC ; $4688
	ldh a, [hVBlankCounter] ; $468b
	and a, $3c ; $468d
	srl a ; $468f
	srl a ; $4691
	add a, a ; $4693
	jr nc, Label_17_469b ; $4694
	ld a, $0c ; $4696
	dec a ; $4698
	jr Label_17_46a1 ; $4699
Label_17_469b:
	rra ; $469b
	cp a, $0c ; $469c
	jr c, Label_17_46a1 ; $469e
	xor a, a ; $46a0
Label_17_46a1:
	add a, a ; $46a1
	ld hl, $46ca ; $46a2
	add a, l ; $46a5
	ld l, a ; $46a6
	jr nc, Label_17_46aa ; $46a7
	inc h ; $46a9
Label_17_46aa:
	ld a, [hl+] ; $46aa
	ld d, [hl] ; $46ab
	ld e, a ; $46ac
	ld hl, $d834 ; $46ad
	ld [hl], e ; $46b0
	inc hl ; $46b1
	ld [hl], d ; $46b2
	ld hl, $d830 ; $46b3
	ld de, $0201 ; $46b6
	call LoadPaletteShadow ; $46b9
	pop af ; $46bc
	wram_bank ; $46bd
	ret ; $46c1
	nop ; $46c2
	nop ; $46c3
	ld sp, hl ; $46c4
	ld h, a ; $46c5
	sbc a, b ; $46c6
	nop ; $46c7
	rra ; $46c8
	inc bc ; $46c9
	rra ; $46ca
	nop ; $46cb
	rst Rst18 ; $46cc
	nop ; $46cd
	rst Rst38 ; $46ce
	ld bc, $02bf ; $46cf
	ld a, a ; $46d2
	inc bc ; $46d3
	rst Rst38 ; $46d4
	inc bc ; $46d5
	rst Rst38 ; $46d6
	inc bc ; $46d7
	sbc a, a ; $46d8
	inc bc ; $46d9
	cp a, a ; $46da
	ld [bc], a ; $46db
	rst Rst38 ; $46dc
	ld bc, $00df ; $46dd
	rra ; $46e0
	nop ; $46e1
	ldh a, [hWramBank] ; $46e2
	push af ; $46e4
	wram_bank $03 ; $46e5
	ld a, [$d810] ; $46eb
	ld d, a ; $46ee
	ld a, [$d811] ; $46ef
	ld e, a ; $46f2
	ld hl, $4703 ; $46f3
	ld b, $08 ; $46f6
	ld c, $00 ; $46f8
	call QueueSpriteTemplate ; $46fa
	pop af ; $46fd
	wram_bank ; $46fe
	ret ; $4702
	INCBIN "data/bank_017/d_4703.bin" ; $4703, 9 bytes
	ldh a, [hWramBank] ; $470c
	push af ; $470e
	wram_bank $03 ; $470f
	ld a, [$d812] ; $4715
	ld d, a ; $4718
	ld a, [$d813] ; $4719
	ld e, a ; $471c
	ld hl, $472d ; $471d
	ld b, $08 ; $4720
	ld c, $04 ; $4722
	call QueueSpriteTemplate ; $4724
	pop af ; $4727
	wram_bank ; $4728
	ret ; $472c
	INCBIN "data/bank_017/d_472d.bin" ; $472d, 9 bytes
	ldh a, [hWramBank] ; $4736
	push af ; $4738
	wram_bank $03 ; $4739
	ld a, [$d81e] ; $473f
	ld d, a ; $4742
	ld a, [$d81f] ; $4743
	ld e, a ; $4746
	ld c, $6e ; $4747
	ld b, $09 ; $4749
	call QueueSprite ; $474b
	pop af ; $474e
	wram_bank ; $474f
	ret ; $4753
	ldh a, [hWramBank] ; $4754
	push af ; $4756
	wram_bank $03 ; $4757
	ld b, $09 ; $475d
	ld a, [$d82d] ; $475f
	cp a, $01 ; $4762
	jr z, Label_17_4768 ; $4764
	ld b, $29 ; $4766
Label_17_4768:
	ld a, [$d81c] ; $4768
	ld d, a ; $476b
	ldh a, [hVBlankCounter] ; $476c
	and a, $10 ; $476e
	jr z, Label_17_4773 ; $4770
	inc d ; $4772
Label_17_4773:
	ld a, [$d81d] ; $4773
	ld e, a ; $4776
	ld c, $60 ; $4777
	ld hl, $4785 ; $4779
	call QueueSpriteTemplate ; $477c
	pop af ; $477f
	wram_bank ; $4780
	ret ; $4784
	INCBIN "data/bank_017/d_4785.bin" ; $4785, 9 bytes
	ldh a, [hWramBank] ; $478e
	push af ; $4790
	wram_bank $03 ; $4791
	ld a, [$d822] ; $4797
	ld hl, $47c3 ; $479a
	add a, l ; $479d
	ld l, a ; $479e
	jr nc, Label_17_47a2 ; $479f
	inc h ; $47a1
Label_17_47a2:
	ld c, [hl] ; $47a2
	ld hl, $47e2 ; $47a3
	ld a, [$d822] ; $47a6
	cp a, $06 ; $47a9
	jr nc, Label_17_47b0 ; $47ab
	ld hl, $47cd ; $47ad
Label_17_47b0:
	ld a, [$d814] ; $47b0
	ld d, a ; $47b3
	ld a, [$d815] ; $47b4
	ld e, a ; $47b7
	ld b, $09 ; $47b8
	call QueueSpriteTemplate ; $47ba
	pop af ; $47bd
	wram_bank ; $47be
	ret ; $47c2
	INCBIN "data/bank_017/d_47c3.bin" ; $47c3, 89 bytes
	ldh a, [hWramBank] ; $481c
	push af ; $481e
	wram_bank $03 ; $481f
	ld c, $70 ; $4825
	ld b, $09 ; $4827
	ld a, [$d825] ; $4829
	cp a, $01 ; $482c
	jr z, Label_17_4832 ; $482e
	ld b, $49 ; $4830
Label_17_4832:
	ld a, [$d823] ; $4832
	ld d, a ; $4835
	ld a, [$d824] ; $4836
	ld e, a ; $4839
	call QueueSprite ; $483a
	pop af ; $483d
	wram_bank ; $483e
	ret ; $4842
	ldh a, [hWramBank] ; $4843
	push af ; $4845
	wram_bank $03 ; $4846
	ld c, $64 ; $484c
	ld b, $09 ; $484e
	ld a, [$d826] ; $4850
	cp a, $01 ; $4853
	jr z, Label_17_4859 ; $4855
	ld b, $29 ; $4857
Label_17_4859:
	ld a, [$d816] ; $4859
	ld d, a ; $485c
	ld a, [$d817] ; $485d
	ld e, a ; $4860
	ld hl, $486d ; $4861
	call QueueSpriteTemplate ; $4864
	pop af ; $4867
	wram_bank ; $4868
	ret ; $486c
	INCBIN "data/bank_017/d_486d.bin" ; $486d, 9 bytes
	ldh a, [hWramBank] ; $4876
	push af ; $4878
	wram_bank $03 ; $4879
	ld hl, $489e ; $487f
	ld a, [$d827] ; $4882
	add a, l ; $4885
	ld l, a ; $4886
	jr nc, Label_17_488a ; $4887
	inc h ; $4889
Label_17_488a:
	ld b, [hl] ; $488a
	ld c, $68 ; $488b
	ld a, [$d818] ; $488d
	ld d, a ; $4890
	ld a, [$d819] ; $4891
	ld e, a ; $4894
	call QueueSprite ; $4895
	pop af ; $4898
	wram_bank ; $4899
	ret ; $489d
	INCBIN "data/bank_017/d_489e.bin" ; $489e, 4 bytes
DrawBlinkingPrompt:
	ldh a, [hWramBank] ; $48a2
	push af ; $48a4
	wram_bank $03 ; $48a5
	ldh a, [hVBlankCounter] ; $48ab
	and a, $10 ; $48ad
	jr z, Label_17_48bb ; $48af
	ld c, $72 ; $48b1
	ld b, $09 ; $48b3
	ld de, $508c ; $48b5
	call QueueSprite ; $48b8
Label_17_48bb:
	pop af ; $48bb
	wram_bank ; $48bc
	ret ; $48c0
	ldh a, [hWramBank] ; $48c1
	push af ; $48c3
	wram_bank $03 ; $48c4
	ld a, [$d828] ; $48ca
	ld d, a ; $48cd
	ldh a, [hVBlankCounter] ; $48ce
	and a, $10 ; $48d0
	jr z, Label_17_48d5 ; $48d2
	inc d ; $48d4
Label_17_48d5:
	ld a, [$d829] ; $48d5
	ld e, a ; $48d8
	ldh a, [hVBlankCounter] ; $48d9
	and a, $10 ; $48db
	jr z, Label_17_48e0 ; $48dd
	inc e ; $48df
Label_17_48e0:
	ld c, $6c ; $48e0
	ld b, $0a ; $48e2
	call QueueSprite ; $48e4
	ld a, [$d82a] ; $48e7
	add a, $03 ; $48ea
	ld b, a ; $48ec
	ld a, [$d828] ; $48ed
	add a, b ; $48f0
	ld d, a ; $48f1
	ldh a, [hVBlankCounter] ; $48f2
	and a, $10 ; $48f4
	jr z, Label_17_48f9 ; $48f6
	dec d ; $48f8
Label_17_48f9:
	ld a, [$d829] ; $48f9
	ld e, a ; $48fc
	ldh a, [hVBlankCounter] ; $48fd
	and a, $10 ; $48ff
	jr z, Label_17_4904 ; $4901
	inc e ; $4903
Label_17_4904:
	ld c, $6c ; $4904
	ld b, $2a ; $4906
	call QueueSprite ; $4908
	ld a, [$d82a] ; $490b
	add a, $03 ; $490e
	ld b, a ; $4910
	ld a, [$d828] ; $4911
	add a, b ; $4914
	ld d, a ; $4915
	ldh a, [hVBlankCounter] ; $4916
	and a, $10 ; $4918
	jr z, Label_17_491d ; $491a
	dec d ; $491c
Label_17_491d:
	ld a, [$d82b] ; $491d
	sub a, $05 ; $4920
	ld b, a ; $4922
	ld a, [$d829] ; $4923
	add a, b ; $4926
	ld e, a ; $4927
	ldh a, [hVBlankCounter] ; $4928
	and a, $10 ; $492a
	jr z, Label_17_492f ; $492c
	dec e ; $492e
Label_17_492f:
	ld c, $6c ; $492f
	ld b, $6a ; $4931
	call QueueSprite ; $4933
	ld a, [$d828] ; $4936
	ld d, a ; $4939
	ldh a, [hVBlankCounter] ; $493a
	and a, $10 ; $493c
	jr z, Label_17_4941 ; $493e
	inc d ; $4940
Label_17_4941:
	ld a, [$d82b] ; $4941
	sub a, $05 ; $4944
	ld b, a ; $4946
	ld a, [$d829] ; $4947
	add a, b ; $494a
	ld e, a ; $494b
	ldh a, [hVBlankCounter] ; $494c
	and a, $10 ; $494e
	jr z, Label_17_4953 ; $4950
	dec e ; $4952
Label_17_4953:
	ld c, $6c ; $4953
	ld b, $4a ; $4955
	call QueueSprite ; $4957
	pop af ; $495a
	wram_bank ; $495b
	ret ; $495f
LoadCourtDiagramScreen:
	ld c, $24 ; $4960
	farcall FarPtr_LoadScreenAssetRecord ; $4962
	call InitCourtDiagramTextWindow ; $4965
	wram_bank $03 ; $4968
	call DecompressGraphicsList ; $496e
	call LoadCourtDiagramObjPalettes ; $4971
	farcall FarPtr_QueueWram3MapToVRAM ; $4974
	wram_bank $03 ; $4977
	ret ; $497d
WaitForInputBlinking:
	call AdvanceFrame ; $497e
	ldh a, [hInputRisingEdge] ; $4981
	and a, $03 ; $4983
	jr nz, Label_17_498c ; $4985
	call DrawBlinkingPrompt ; $4987
	jr WaitForInputBlinking ; $498a
Label_17_498c:
	ret ; $498c
AdvanceFrameCheckInput:
	call AdvanceFrame ; $498d
	ldh a, [hInputRisingEdge] ; $4990
	and a, $03 ; $4992
	jr nz, Label_17_499e ; $4994
	dec c ; $4996
	jr z, Label_17_499c ; $4997
	call DrawBlinkingPrompt ; $4999
Label_17_499c:
	ld a, $00 ; $499c
Label_17_499e:
	ret ; $499e
InitCourtDiagramTextWindow:
	farcall FarPtr_ResetTextWindowState ; $499f
	ld b, $11 ; $49a2
	ld c, $10 ; $49a4
	ld de, $9000 ; $49a6
	farcall FarPtr_39_10 ; $49a9
	wram_bank $05 ; $49ac
	ld a, $03 ; $49b2
	ld [$c3b3], a ; $49b4
	ld a, $00 ; $49b7
	ld [$c3b6], a ; $49b9
	ld d, $00 ; $49bc
	ld e, $0b ; $49be
	ld b, $14 ; $49c0
	ld c, $07 ; $49c2
	farcall FarPtr_CreateWindowFromScreenRect ; $49c4
	farcall FarPtr_DrawTextWindowFrame ; $49c7
	farcall FarPtr_RedrawWindowRows ; $49ca
	ret ; $49cd
ClearBriefingCaptionTilemap:
	push af ; $49ce
	push bc ; $49cf
	push de ; $49d0
	push hl ; $49d1
	ld de, $d160 ; $49d2
	ld b, $14 ; $49d5
	ld c, $01 ; $49d7
	ld h, $03 ; $49d9
	farcall FarPtr_FillTilemapRect ; $49db
	ld a, $02 ; $49de
	ld [$d160], a ; $49e0
	ld a, $04 ; $49e3
	ld [$d173], a ; $49e5
	ld de, $d181 ; $49e8
	ld b, $12 ; $49eb
	ld c, $05 ; $49ed
	ld h, $20 ; $49ef
	farcall FarPtr_FillTilemapRect ; $49f1
	pop hl ; $49f4
	pop de ; $49f5
	pop bc ; $49f6
	pop af ; $49f7
	ret ; $49f8
QueueCaptionRowToVRAM:
	ld hl, $d160 ; $49f9
	ld de, $9960 ; $49fc
	ld c, $0c ; $49ff
	call QueueVRAMCopy ; $4a01
	ret ; $4a04
	ret ; $4a05
	ld hl, $0135 ; $4a06
	ld de, $d1c1 ; $4a09
	farcall FarPtr_RenderProportionalTextAt ; $4a0c
	ld hl, $d1a0 ; $4a0f
	ld de, $99a0 ; $4a12
	ld c, $0c ; $4a15
	call QueueVRAMCopy ; $4a17
	ret ; $4a1a
	INCBIN "data/bank_017/d_4a1b.bin" ; $4a1b, 23 bytes
RestoreDiagramServiceBoxes:
	push af ; $4a32
	push bc ; $4a33
	push de ; $4a34
	push hl ; $4a35
	ld hl, $d246 ; $4a36
	ld de, $d067 ; $4a39
	ld c, $06 ; $4a3c
	ld b, $06 ; $4a3e
	farcall FarPtr_CopyTilemapRect ; $4a40
	pop hl ; $4a43
	pop de ; $4a44
	pop bc ; $4a45
	pop af ; $4a46
	ret ; $4a47
QueueDiagramServiceBoxesToVRAM:
	ld hl, $d060 ; $4a48
	ld de, $9860 ; $4a4b
	ld c, $0c ; $4a4e
	call QueueVRAMCopy ; $4a50
	ret ; $4a53
DrawDiagramTargetPatch:
	ld a, b ; $4a54
	or a, a ; $4a55
	ret z ; $4a56
	dec a ; $4a57
	add a, a ; $4a58
	ld c, a ; $4a59
	add a, a ; $4a5a
	add a, c ; $4a5b
	ld hl, $4a75 ; $4a5c
	add a, l ; $4a5f
	ld l, a ; $4a60
	jr nc, Label_17_4a64 ; $4a61
	inc h ; $4a63
Label_17_4a64:
	ld a, [hl+] ; $4a64
	ld b, [hl] ; $4a65
	ld c, a ; $4a66
	inc hl ; $4a67
	ld a, [hl+] ; $4a68
	ld d, [hl] ; $4a69
	ld e, a ; $4a6a
	inc hl ; $4a6b
	push bc ; $4a6c
	ld b, [hl] ; $4a6d
	inc hl ; $4a6e
	ld c, [hl] ; $4a6f
	pop hl ; $4a70
	farcall FarPtr_CopyTilemapRect ; $4a71
	ret ; $4a74
	ld b, e ; $4a75
	jp nc, $d08a ; $4a76
	inc bc ; $4a79
	ld [bc], a ; $4a7a
	add a, e ; $4a7b
	jp nc, $d0ca ; $4a7c
	inc bc ; $4a7f
	ld [bc], a ; $4a80
	add a, b ; $4a81
	jp nc, $d0c7 ; $4a82
	inc bc ; $4a85
	ld [bc], a ; $4a86
	ld b, b ; $4a87
	jp nc, $d087 ; $4a88
	inc bc ; $4a8b
	ld [bc], a ; $4a8c
	ret nz ; $4a8d
	jp nc, $d067 ; $4a8e
	ld b, $02 ; $4a91
	nop ; $4a93
	INCBIN "data/bank_017/d_4a94.bin" ; $4a94, 5 bytes
DecompressGraphicsList:
	ld hl, $4abb ; $4a99
Label_17_4a9c:
	ld a, [hl+] ; $4a9c
	ld b, [hl] ; $4a9d
	dec hl ; $4a9e
	or a, b ; $4a9f
	jr z, Label_17_4aba ; $4aa0
	push hl ; $4aa2
	push hl ; $4aa3
	inc hl ; $4aa4
	inc hl ; $4aa5
	ld a, [hl+] ; $4aa6
	ld d, [hl] ; $4aa7
	ld e, a ; $4aa8
	pop hl ; $4aa9
	ld a, [hl+] ; $4aaa
	ld h, [hl] ; $4aab
	ld l, a ; $4aac
	call DecompressData ; $4aad
	pop hl ; $4ab0
	ld a, $04 ; $4ab1
	add a, l ; $4ab3
	ld l, a ; $4ab4
	jr nc, Label_17_4ab8 ; $4ab5
	inc h ; $4ab7
Label_17_4ab8:
	jr Label_17_4a9c ; $4ab8
Label_17_4aba:
	ret ; $4aba
	; $4abb, 82 bytes (bytes:4)
	db $02, $4f, $00, $80 ; 0x00
	db $3d, $4f, $40, $80 ; 0x04
	db $7c, $4f, $80, $80 ; 0x08
	db $0b, $50, $20, $81 ; 0x0c
	db $9a, $50, $c0, $81 ; 0x10
	db $2d, $51, $60, $82 ; 0x14
	db $8f, $51, $c0, $82 ; 0x18
	db $f1, $51, $60, $83 ; 0x1c
	db $80, $52, $00, $84 ; 0x20
	db $0f, $53, $a0, $84 ; 0x24
	db $a0, $53, $40, $85 ; 0x28
	db $09, $54, $a0, $85 ; 0x2c
	db $6d, $54, $00, $86 ; 0x30
	db $b7, $54, $40, $86 ; 0x34
	db $d8, $54, $80, $86 ; 0x38
	db $ff, $54, $a0, $86 ; 0x3c
	db $11, $55, $c0, $86 ; 0x40
	db $23, $55, $e0, $86 ; 0x44
	db $36, $55, $00, $87 ; 0x48
	db $4e, $55, $20, $87 ; 0x4c
	db $00, $00 ; 0x50
LoadCourtDiagramObjPalettes:
	ld hl, $5567 ; $4b0d
	ld de, $0803 ; $4b10
	call LoadPaletteShadow ; $4b13
	ret ; $4b16
CourtDiagramTiles:
	INCBIN "data/bank_017/lz_4b17.bin" ; $4b17, 590 bytes
CourtDiagramTilemap:
	INCBIN "data/bank_017/lz_4d65.bin" ; $4d65, 221 bytes
CourtDiagramAttrmap:
	INCBIN "data/bank_017/lz_4e42.bin" ; $4e42, 128 bytes
CourtDiagramPalettes:
	; $4ec2, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $5ad6, $01bf, $0000, $7fff ; pal 0: #b4b4b4 #ff6a00 #000000 #ffffff
	dw $7e40, $3fc1, $7fe1, $7fe0 ; pal 1: #0094ff #08f67b #08ffff #00ffff
	dw $0e40, $01bf, $035f, $7fff ; pal 2: #009418 #ff6a00 #ffd500 #ffffff
	dw $0300, $0240, $0180, $0100 ; pal 3: #00c500 #009400 #006200 #004100
	dw $0000, $0000, $0000, $0000 ; pal 4: #000000 #000000 #000000 #000000
	dw $035f, $01bf, $0e40, $7fff ; pal 5: #ffd500 #ff6a00 #009418 #ffffff
	dw $0000, $0000, $0000, $0000 ; pal 6: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 7: #000000 #000000 #000000 #000000
	INCBIN "data/bank_017/d_4f02.bin" ; $4f02, 1661 bytes
DrillBriefing_ServeToTargets:
	ld a, $03 ; $557f
	ld [$d82e], a ; $5581
	call ServeToTargetsBriefing_AdvanceAnim ; $5584
	ld a, $01 ; $5587
	ld hl, $46e2 ; $5589
	call RegisterFrameTask ; $558c
	ld a, $01 ; $558f
	ld hl, $4736 ; $5591
	call RegisterFrameTask ; $5594
	ld a, $01 ; $5597
	ld hl, $4754 ; $5599
	call RegisterFrameTask ; $559c
	ld a, $01 ; $559f
	ld hl, $4876 ; $55a1
	call RegisterFrameTask ; $55a4
	ld a, $01 ; $55a7
	ld hl, $4676 ; $55a9
	call RegisterFrameTask ; $55ac
	ld hl, $1ab0 ; $55af
	call DrawBriefingCaption ; $55b2
	xor a, a ; $55b5
	ld [$d82c], a ; $55b6
	ld [$d82e], a ; $55b9
Label_17_55bc:
	call ServeToTargetsBriefing_TickAnim ; $55bc
	ld c, $00 ; $55bf
	call AdvanceFrameCheckInput ; $55c1
	and a, a ; $55c4
	jp z, Label_17_55bc ; $55c5
	call ClearFrameTasks ; $55c8
	ld a, $01 ; $55cb
	ld hl, $4406 ; $55cd
	call RegisterFrameTask ; $55d0
	ld a, $03 ; $55d3
	ld [$d82e], a ; $55d5
	call ServeToTargetsBriefing_AdvanceAnim ; $55d8
	ld a, $01 ; $55db
	ld hl, $46e2 ; $55dd
	call RegisterFrameTask ; $55e0
	ld a, $01 ; $55e3
	ld hl, $4754 ; $55e5
	call RegisterFrameTask ; $55e8
	ld a, $01 ; $55eb
	ld hl, $4676 ; $55ed
	call RegisterFrameTask ; $55f0
	ld a, $00 ; $55f3
	ld [$d82a], a ; $55f5
	ld a, $00 ; $55f8
	ld [$d82b], a ; $55fa
	ld a, $01 ; $55fd
	ld hl, $48c1 ; $55ff
	call RegisterFrameTask ; $5602
	ld hl, $1ab1 ; $5605
	call DrawBriefingCaption ; $5608
	xor a, a ; $560b
	ld [$d82c], a ; $560c
	ld [$d82e], a ; $560f
Label_17_5612:
	call ServeToTargetsBriefing_TickAnim ; $5612
	ld c, $00 ; $5615
	call AdvanceFrameCheckInput ; $5617
	and a, a ; $561a
	jp z, Label_17_5612 ; $561b
	call ClearFrameTasks ; $561e
	ld a, $01 ; $5621
	ld hl, $4406 ; $5623
	call RegisterFrameTask ; $5626
	ld a, $54 ; $5629
	ld [$d810], a ; $562b
	ld a, $44 ; $562e
	ld [$d811], a ; $5630
	ld a, $01 ; $5633
	ld hl, $46e2 ; $5635
	call RegisterFrameTask ; $5638
	ld a, $4e ; $563b
	ld [$d81e], a ; $563d
	ld a, $38 ; $5640
	ld [$d81f], a ; $5642
	ld a, $01 ; $5645
	ld hl, $4736 ; $5647
	call RegisterFrameTask ; $564a
	ld a, $00 ; $564d
	ld [$d82d], a ; $564f
	ld a, $3a ; $5652
	ld [$d81c], a ; $5654
	ld a, $24 ; $5657
	ld [$d81d], a ; $5659
	ld a, $01 ; $565c
	ld hl, $4754 ; $565e
	call RegisterFrameTask ; $5661
	ld a, $03 ; $5664
	ld [$d827], a ; $5666
	ld a, $52 ; $5669
	ld [$d818], a ; $566b
	ld a, $40 ; $566e
	ld [$d819], a ; $5670
	ld a, $01 ; $5673
	ld hl, $4876 ; $5675
	call RegisterFrameTask ; $5678
	ld b, $04 ; $567b
	call DrawDiagramTargetOverlay ; $567d
	ld a, $01 ; $5680
	ld hl, $4676 ; $5682
	call RegisterFrameTask ; $5685
	ld a, $00 ; $5688
	ld [$d82a], a ; $568a
	ld a, $00 ; $568d
	ld [$d82b], a ; $568f
	ld a, $40 ; $5692
	ld [$d828], a ; $5694
	ld a, $24 ; $5697
	ld [$d829], a ; $5699
	ld a, $01 ; $569c
	ld hl, $48c1 ; $569e
	call RegisterFrameTask ; $56a1
	ld hl, $1ab2 ; $56a4
	call DrawBriefingCaption ; $56a7
	call WaitForInputBlinking ; $56aa
	call ClearFrameTasks ; $56ad
	ld a, $01 ; $56b0
	ld hl, $4406 ; $56b2
	call RegisterFrameTask ; $56b5
	ld a, $03 ; $56b8
	ld [$d82e], a ; $56ba
	call ServeToTargetsBriefing_AdvanceAnim ; $56bd
	ld a, $01 ; $56c0
	ld hl, $46e2 ; $56c2
	call RegisterFrameTask ; $56c5
	ld a, $01 ; $56c8
	ld hl, $4736 ; $56ca
	call RegisterFrameTask ; $56cd
	ld a, $01 ; $56d0
	ld hl, $4876 ; $56d2
	call RegisterFrameTask ; $56d5
	ld a, $01 ; $56d8
	ld hl, $4676 ; $56da
	call RegisterFrameTask ; $56dd
	ld a, $00 ; $56e0
	ld [$d82a], a ; $56e2
	ld a, $00 ; $56e5
	ld [$d82b], a ; $56e7
	ld a, $01 ; $56ea
	ld hl, $48c1 ; $56ec
	call RegisterFrameTask ; $56ef
	ld hl, $1ab3 ; $56f2
	call DrawBriefingCaption ; $56f5
	xor a, a ; $56f8
	ld [$d82c], a ; $56f9
	ld [$d82e], a ; $56fc
Label_17_56ff:
	call ServeToTargetsBriefing_TickAnim ; $56ff
	ld c, $01 ; $5702
	call AdvanceFrameCheckInput ; $5704
	and a, a ; $5707
	jp z, Label_17_56ff ; $5708
	call ClearFrameTasks ; $570b
	ret ; $570e
ServeToTargetsBriefing_TickAnim:
	ld a, [$d82c] ; $570f
	inc a ; $5712
	ld [$d82c], a ; $5713
	cp a, $78 ; $5716
	jr nc, ServeToTargetsBriefing_AdvanceAnim ; $5718
	ret ; $571a
ServeToTargetsBriefing_AdvanceAnim:
	xor a, a ; $571b
	ld [$d82c], a ; $571c
	ld a, [$d82e] ; $571f
	inc a ; $5722
	and a, $03 ; $5723
	ld [$d82e], a ; $5725
	sla a ; $5728
	sla a ; $572a
	ld c, a ; $572c
	add a, $bb ; $572d
	ld l, a ; $572f
	adc a, $57 ; $5730
	sub a, l ; $5732
	ld h, a ; $5733
	ld a, [hl] ; $5734
	inc hl ; $5735
	inc hl ; $5736
	ld b, [hl] ; $5737
	ld a, a ; $5738
	ld [$d810], a ; $5739
	ld a, b ; $573c
	ld [$d811], a ; $573d
	ld a, c ; $5740
	add a, $07 ; $5741
	ld l, a ; $5743
	adc a, $58 ; $5744
	sub a, l ; $5746
	ld h, a ; $5747
	ld a, [hl] ; $5748
	inc hl ; $5749
	inc hl ; $574a
	ld b, [hl] ; $574b
	ld a, a ; $574c
	ld [$d828], a ; $574d
	ld a, b ; $5750
	ld [$d829], a ; $5751
	ld a, c ; $5754
	add a, $cb ; $5755
	ld l, a ; $5757
	adc a, $57 ; $5758
	sub a, l ; $575a
	ld h, a ; $575b
	ld a, [hl] ; $575c
	inc hl ; $575d
	inc hl ; $575e
	ld b, [hl] ; $575f
	ld a, a ; $5760
	ld [$d81e], a ; $5761
	ld a, b ; $5764
	ld [$d81f], a ; $5765
	ld a, [$d82e] ; $5768
	add a, $db ; $576b
	ld l, a ; $576d
	adc a, $57 ; $576e
	sub a, l ; $5770
	ld h, a ; $5771
	ld a, [hl] ; $5772
	ld [$d82d], a ; $5773
	ld a, c ; $5776
	add a, $df ; $5777
	ld l, a ; $5779
	adc a, $57 ; $577a
	sub a, l ; $577c
	ld h, a ; $577d
	ld a, [hl] ; $577e
	inc hl ; $577f
	inc hl ; $5780
	ld b, [hl] ; $5781
	ld a, a ; $5782
	ld [$d81c], a ; $5783
	ld a, b ; $5786
	ld [$d81d], a ; $5787
	ld a, [$d82e] ; $578a
	add a, $ef ; $578d
	ld l, a ; $578f
	adc a, $57 ; $5790
	sub a, l ; $5792
	ld h, a ; $5793
	ld a, [hl] ; $5794
	ld [$d827], a ; $5795
	ld a, c ; $5798
	add a, $f3 ; $5799
	ld l, a ; $579b
	adc a, $57 ; $579c
	sub a, l ; $579e
	ld h, a ; $579f
	ld a, [hl] ; $57a0
	inc hl ; $57a1
	inc hl ; $57a2
	ld b, [hl] ; $57a3
	ld a, a ; $57a4
	ld [$d818], a ; $57a5
	ld a, b ; $57a8
	ld [$d819], a ; $57a9
	ld a, [$d82e] ; $57ac
	add a, $03 ; $57af
	ld l, a ; $57b1
	adc a, $58 ; $57b2
	sub a, l ; $57b4
	ld h, a ; $57b5
	ld b, [hl] ; $57b6
	call DrawDiagramTargetOverlay ; $57b7
	ret ; $57ba
	; $57bb, 92 bytes (records:2)
	dw $0054 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0054 ; record 6
	dw $0003 ; record 7
	dw $004e ; record 8
	dw $0038 ; record 9
	dw $0056 ; record 10
	dw $0038 ; record 11
	dw $0056 ; record 12
	dw $0028 ; record 13
	dw $004e ; record 14
	dw $0028 ; record 15
	dw $0100 ; record 16
	dw $0001 ; record 17
	dw $003a ; record 18
	dw $0024 ; record 19
	dw $0064 ; record 20
	dw $0024 ; record 21
	dw $0064 ; record 22
	dw $0034 ; record 23
	dw $003a ; record 24
	dw $0034 ; record 25
	dw $0003 ; record 26
	dw $0201 ; record 27
	dw $0052 ; record 28
	dw $0040 ; record 29
	dw $004d ; record 30
	dw $0040 ; record 31
	dw $004d ; record 32
	dw $0016 ; record 33
	dw $0052 ; record 34
	dw $0016 ; record 35
	dw $0104 ; record 36
	dw $0302 ; record 37
	dw $0040 ; record 38
	dw $0024 ; record 39
	dw $005d ; record 40
	dw $0024 ; record 41
	dw $005d ; record 42
	dw $0039 ; record 43
	dw $0040 ; record 44
	dw $0039 ; record 45
DrillBriefing_SpinServe:
	ld a, $03 ; $5817
	ld [$d82e], a ; $5819
	call SpinServeBriefing_AdvanceAnim ; $581c
	ld a, $01 ; $581f
	ld hl, $46e2 ; $5821
	call RegisterFrameTask ; $5824
	ld a, $01 ; $5827
	ld hl, $4736 ; $5829
	call RegisterFrameTask ; $582c
	ld a, $01 ; $582f
	ld hl, $4754 ; $5831
	call RegisterFrameTask ; $5834
	ld a, $01 ; $5837
	ld hl, $4876 ; $5839
	call RegisterFrameTask ; $583c
	ld a, $01 ; $583f
	ld hl, $4676 ; $5841
	call RegisterFrameTask ; $5844
	ld hl, $1ab4 ; $5847
	call DrawBriefingCaption ; $584a
	xor a, a ; $584d
	ld [$d82c], a ; $584e
	ld [$d82e], a ; $5851
Label_17_5854:
	call SpinServeBriefing_TickAnim ; $5854
	ld c, $00 ; $5857
	call AdvanceFrameCheckInput ; $5859
	and a, a ; $585c
	jp z, Label_17_5854 ; $585d
	call ClearFrameTasks ; $5860
	ld a, $01 ; $5863
	ld hl, $4406 ; $5865
	call RegisterFrameTask ; $5868
	ld a, $03 ; $586b
	ld [$d82e], a ; $586d
	call SpinServeBriefing_AdvanceAnim ; $5870
	ld a, $01 ; $5873
	ld hl, $46e2 ; $5875
	call RegisterFrameTask ; $5878
	ld a, $01 ; $587b
	ld hl, $4754 ; $587d
	call RegisterFrameTask ; $5880
	ld a, $01 ; $5883
	ld hl, $4676 ; $5885
	call RegisterFrameTask ; $5888
	ld a, $00 ; $588b
	ld [$d82a], a ; $588d
	ld a, $00 ; $5890
	ld [$d82b], a ; $5892
	ld a, $01 ; $5895
	ld hl, $48c1 ; $5897
	call RegisterFrameTask ; $589a
	ld hl, $1ab5 ; $589d
	call DrawBriefingCaption ; $58a0
	xor a, a ; $58a3
	ld [$d82c], a ; $58a4
	ld [$d82e], a ; $58a7
Label_17_58aa:
	call SpinServeBriefing_TickAnim ; $58aa
	ld c, $00 ; $58ad
	call AdvanceFrameCheckInput ; $58af
	and a, a ; $58b2
	jp z, Label_17_58aa ; $58b3
	call ClearFrameTasks ; $58b6
	ld a, $01 ; $58b9
	ld hl, $4406 ; $58bb
	call RegisterFrameTask ; $58be
	ld a, $52 ; $58c1
	ld [$d810], a ; $58c3
	ld a, $44 ; $58c6
	ld [$d811], a ; $58c8
	ld a, $01 ; $58cb
	ld hl, $46e2 ; $58cd
	call RegisterFrameTask ; $58d0
	ld a, $4e ; $58d3
	ld [$d81e], a ; $58d5
	ld a, $38 ; $58d8
	ld [$d81f], a ; $58da
	ld a, $01 ; $58dd
	ld hl, $4736 ; $58df
	call RegisterFrameTask ; $58e2
	ld a, $00 ; $58e5
	ld [$d82d], a ; $58e7
	ld a, $3a ; $58ea
	ld [$d81c], a ; $58ec
	ld a, $24 ; $58ef
	ld [$d81d], a ; $58f1
	ld a, $01 ; $58f4
	ld hl, $4754 ; $58f6
	call RegisterFrameTask ; $58f9
	ld a, $03 ; $58fc
	ld [$d827], a ; $58fe
	ld a, $52 ; $5901
	ld [$d818], a ; $5903
	ld a, $40 ; $5906
	ld [$d819], a ; $5908
	ld a, $01 ; $590b
	ld hl, $4876 ; $590d
	call RegisterFrameTask ; $5910
	ld b, $04 ; $5913
	call DrawDiagramTargetOverlay ; $5915
	ld a, $01 ; $5918
	ld hl, $4676 ; $591a
	call RegisterFrameTask ; $591d
	ld a, $00 ; $5920
	ld [$d82a], a ; $5922
	ld a, $00 ; $5925
	ld [$d82b], a ; $5927
	ld a, $40 ; $592a
	ld [$d828], a ; $592c
	ld a, $24 ; $592f
	ld [$d829], a ; $5931
	ld a, $01 ; $5934
	ld hl, $48c1 ; $5936
	call RegisterFrameTask ; $5939
	ld hl, $1ab6 ; $593c
	call DrawBriefingCaption ; $593f
	call WaitForInputBlinking ; $5942
	call ClearFrameTasks ; $5945
	ld a, $01 ; $5948
	ld hl, $4406 ; $594a
	call RegisterFrameTask ; $594d
	ld a, $52 ; $5950
	ld [$d810], a ; $5952
	ld a, $44 ; $5955
	ld [$d811], a ; $5957
	ld a, $01 ; $595a
	ld hl, $46e2 ; $595c
	call RegisterFrameTask ; $595f
	ld a, $46 ; $5962
	ld [$d81e], a ; $5964
	ld a, $28 ; $5967
	ld [$d81f], a ; $5969
	ld a, $01 ; $596c
	ld hl, $4736 ; $596e
	call RegisterFrameTask ; $5971
	ld a, $03 ; $5974
	ld [$d827], a ; $5976
	ld a, $49 ; $5979
	ld [$d818], a ; $597b
	ld a, $2f ; $597e
	ld [$d819], a ; $5980
	ld a, $01 ; $5983
	ld hl, $4876 ; $5985
	call RegisterFrameTask ; $5988
	ld a, $01 ; $598b
	ld [$d826], a ; $598d
	ld a, $30 ; $5990
	ld [$d816], a ; $5992
	ld a, $22 ; $5995
	ld [$d817], a ; $5997
	ld a, $01 ; $599a
	ld hl, $4843 ; $599c
	call RegisterFrameTask ; $599f
	ld b, $04 ; $59a2
	call DrawDiagramTargetOverlay ; $59a4
	ld a, $01 ; $59a7
	ld hl, $4676 ; $59a9
	call RegisterFrameTask ; $59ac
	ld hl, $1ab7 ; $59af
	call DrawBriefingCaption ; $59b2
	call WaitForInputBlinking ; $59b5
	call ClearFrameTasks ; $59b8
	ld a, $01 ; $59bb
	ld hl, $4406 ; $59bd
	call RegisterFrameTask ; $59c0
	ld a, $00 ; $59c3
	ld [$d82e], a ; $59c5
	call SpinServeBriefing_AdvanceAnim2 ; $59c8
	ld a, $01 ; $59cb
	ld hl, $46e2 ; $59cd
	call RegisterFrameTask ; $59d0
	ld a, $01 ; $59d3
	ld hl, $4736 ; $59d5
	call RegisterFrameTask ; $59d8
	ld a, $01 ; $59db
	ld hl, $4876 ; $59dd
	call RegisterFrameTask ; $59e0
	ld a, $01 ; $59e3
	ld hl, $4843 ; $59e5
	call RegisterFrameTask ; $59e8
	ld a, $01 ; $59eb
	ld hl, $478e ; $59ed
	call RegisterFrameTask ; $59f0
	ld a, $01 ; $59f3
	ld hl, $4676 ; $59f5
	call RegisterFrameTask ; $59f8
	ld hl, $1ab8 ; $59fb
	ld a, [$c90e] ; $59fe
	and a, a ; $5a01
	jr z, Label_17_5a07 ; $5a02
	ld hl, $1ab9 ; $5a04
Label_17_5a07:
	call DrawBriefingCaption ; $5a07
	xor a, a ; $5a0a
	ld [$d82c], a ; $5a0b
	ld [$d82e], a ; $5a0e
Label_17_5a11:
	call SpinServeBriefing_TickAnim2 ; $5a11
	ld c, $00 ; $5a14
	call AdvanceFrameCheckInput ; $5a16
	and a, a ; $5a19
	jp z, Label_17_5a11 ; $5a1a
	call ClearFrameTasks ; $5a1d
	ld a, $01 ; $5a20
	ld hl, $4406 ; $5a22
	call RegisterFrameTask ; $5a25
	ld a, $03 ; $5a28
	ld [$d82e], a ; $5a2a
	call SpinServeBriefing_AdvanceAnim ; $5a2d
	ld a, $01 ; $5a30
	ld hl, $46e2 ; $5a32
	call RegisterFrameTask ; $5a35
	ld a, $01 ; $5a38
	ld hl, $4736 ; $5a3a
	call RegisterFrameTask ; $5a3d
	ld a, $01 ; $5a40
	ld hl, $4876 ; $5a42
	call RegisterFrameTask ; $5a45
	ld a, $01 ; $5a48
	ld hl, $4676 ; $5a4a
	call RegisterFrameTask ; $5a4d
	ld a, $01 ; $5a50
	ld hl, $48c1 ; $5a52
	call RegisterFrameTask ; $5a55
	ld hl, $1aba ; $5a58
	call DrawBriefingCaption ; $5a5b
	xor a, a ; $5a5e
	ld [$d82c], a ; $5a5f
	ld [$d82e], a ; $5a62
Label_17_5a65:
	call SpinServeBriefing_TickAnim ; $5a65
	ld c, $01 ; $5a68
	call AdvanceFrameCheckInput ; $5a6a
	and a, a ; $5a6d
	jp z, Label_17_5a65 ; $5a6e
	call ClearFrameTasks ; $5a71
	ret ; $5a74
SpinServeBriefing_TickAnim:
	ld a, [$d82c] ; $5a75
	inc a ; $5a78
	ld [$d82c], a ; $5a79
	cp a, $78 ; $5a7c
	jr nc, SpinServeBriefing_AdvanceAnim ; $5a7e
	ret ; $5a80
SpinServeBriefing_AdvanceAnim:
	xor a, a ; $5a81
	ld [$d82c], a ; $5a82
	ld a, [$d82e] ; $5a85
	inc a ; $5a88
	and a, $03 ; $5a89
	ld [$d82e], a ; $5a8b
	sla a ; $5a8e
	sla a ; $5a90
	ld c, a ; $5a92
	add a, $e5 ; $5a93
	ld l, a ; $5a95
	adc a, $5b ; $5a96
	sub a, l ; $5a98
	ld h, a ; $5a99
	ld a, [hl] ; $5a9a
	inc hl ; $5a9b
	inc hl ; $5a9c
	ld b, [hl] ; $5a9d
	ld a, a ; $5a9e
	ld [$d810], a ; $5a9f
	ld a, b ; $5aa2
	ld [$d811], a ; $5aa3
	ld a, c ; $5aa6
	add a, $31 ; $5aa7
	ld l, a ; $5aa9
	adc a, $5c ; $5aaa
	sub a, l ; $5aac
	ld h, a ; $5aad
	ld a, [hl] ; $5aae
	inc hl ; $5aaf
	inc hl ; $5ab0
	ld b, [hl] ; $5ab1
	ld a, a ; $5ab2
	ld [$d828], a ; $5ab3
	ld a, b ; $5ab6
	ld [$d829], a ; $5ab7
	ld a, c ; $5aba
	add a, $f5 ; $5abb
	ld l, a ; $5abd
	adc a, $5b ; $5abe
	sub a, l ; $5ac0
	ld h, a ; $5ac1
	ld a, [hl] ; $5ac2
	inc hl ; $5ac3
	inc hl ; $5ac4
	ld b, [hl] ; $5ac5
	ld a, a ; $5ac6
	ld [$d81e], a ; $5ac7
	ld a, b ; $5aca
	ld [$d81f], a ; $5acb
	ld a, [$d82e] ; $5ace
	add a, $05 ; $5ad1
	ld l, a ; $5ad3
	adc a, $5c ; $5ad4
	sub a, l ; $5ad6
	ld h, a ; $5ad7
	ld a, [hl] ; $5ad8
	ld [$d82d], a ; $5ad9
	ld a, c ; $5adc
	add a, $09 ; $5add
	ld l, a ; $5adf
	adc a, $5c ; $5ae0
	sub a, l ; $5ae2
	ld h, a ; $5ae3
	ld a, [hl] ; $5ae4
	inc hl ; $5ae5
	inc hl ; $5ae6
	ld b, [hl] ; $5ae7
	ld a, a ; $5ae8
	ld [$d81c], a ; $5ae9
	ld a, b ; $5aec
	ld [$d81d], a ; $5aed
	ld a, [$d82e] ; $5af0
	add a, $19 ; $5af3
	ld l, a ; $5af5
	adc a, $5c ; $5af6
	sub a, l ; $5af8
	ld h, a ; $5af9
	ld a, [hl] ; $5afa
	ld [$d827], a ; $5afb
	ld a, c ; $5afe
	add a, $1d ; $5aff
	ld l, a ; $5b01
	adc a, $5c ; $5b02
	sub a, l ; $5b04
	ld h, a ; $5b05
	ld a, [hl] ; $5b06
	inc hl ; $5b07
	inc hl ; $5b08
	ld b, [hl] ; $5b09
	ld a, a ; $5b0a
	ld [$d818], a ; $5b0b
	ld a, b ; $5b0e
	ld [$d819], a ; $5b0f
	ld a, [$d82e] ; $5b12
	add a, $2d ; $5b15
	ld l, a ; $5b17
	adc a, $5c ; $5b18
	sub a, l ; $5b1a
	ld h, a ; $5b1b
	ld b, [hl] ; $5b1c
	call DrawDiagramTargetOverlay ; $5b1d
	ret ; $5b20
SpinServeBriefing_TickAnim2:
	ld a, [$d82c] ; $5b21
	inc a ; $5b24
	ld [$d82c], a ; $5b25
	cp a, $78 ; $5b28
	jr nc, SpinServeBriefing_AdvanceAnim2 ; $5b2a
	ret ; $5b2c
SpinServeBriefing_AdvanceAnim2:
	xor a, a ; $5b2d
	ld [$d82c], a ; $5b2e
	ld a, [$d82e] ; $5b31
	xor a, $01 ; $5b34
	ld [$d82e], a ; $5b36
	sla a ; $5b39
	sla a ; $5b3b
	ld c, a ; $5b3d
	add a, $e5 ; $5b3e
	ld l, a ; $5b40
	adc a, $5b ; $5b41
	sub a, l ; $5b43
	ld h, a ; $5b44
	ld a, [hl] ; $5b45
	inc hl ; $5b46
	inc hl ; $5b47
	ld b, [hl] ; $5b48
	ld a, a ; $5b49
	ld [$d810], a ; $5b4a
	ld a, b ; $5b4d
	ld [$d811], a ; $5b4e
	ld a, c ; $5b51
	add a, $41 ; $5b52
	ld l, a ; $5b54
	adc a, $5c ; $5b55
	sub a, l ; $5b57
	ld h, a ; $5b58
	ld a, [hl] ; $5b59
	inc hl ; $5b5a
	inc hl ; $5b5b
	ld b, [hl] ; $5b5c
	ld a, a ; $5b5d
	ld [$d81e], a ; $5b5e
	ld a, b ; $5b61
	ld [$d81f], a ; $5b62
	ld a, [$d82e] ; $5b65
	add a, $19 ; $5b68
	ld l, a ; $5b6a
	adc a, $5c ; $5b6b
	sub a, l ; $5b6d
	ld h, a ; $5b6e
	ld a, [hl] ; $5b6f
	ld [$d827], a ; $5b70
	ld a, c ; $5b73
	add a, $49 ; $5b74
	ld l, a ; $5b76
	adc a, $5c ; $5b77
	sub a, l ; $5b79
	ld h, a ; $5b7a
	ld a, [hl] ; $5b7b
	inc hl ; $5b7c
	inc hl ; $5b7d
	ld b, [hl] ; $5b7e
	ld a, a ; $5b7f
	ld [$d818], a ; $5b80
	ld a, b ; $5b83
	ld [$d819], a ; $5b84
	ld a, [$d82e] ; $5b87
	add a, $51 ; $5b8a
	ld l, a ; $5b8c
	adc a, $5c ; $5b8d
	sub a, l ; $5b8f
	ld h, a ; $5b90
	ld a, [hl] ; $5b91
	ld [$d826], a ; $5b92
	ld a, c ; $5b95
	add a, $53 ; $5b96
	ld l, a ; $5b98
	adc a, $5c ; $5b99
	sub a, l ; $5b9b
	ld h, a ; $5b9c
	ld a, [hl] ; $5b9d
	inc hl ; $5b9e
	inc hl ; $5b9f
	ld b, [hl] ; $5ba0
	ld a, a ; $5ba1
	ld [$d816], a ; $5ba2
	ld a, b ; $5ba5
	ld [$d817], a ; $5ba6
	ld b, $00 ; $5ba9
	ld a, [$c90e] ; $5bab
	and a, a ; $5bae
	jr z, Label_17_5bb3 ; $5baf
	ld b, $02 ; $5bb1
Label_17_5bb3:
	ld a, [$d82e] ; $5bb3
	add a, b ; $5bb6
	add a, $5b ; $5bb7
	ld l, a ; $5bb9
	adc a, $5c ; $5bba
	sub a, l ; $5bbc
	ld h, a ; $5bbd
	ld a, [hl] ; $5bbe
	ld [$d822], a ; $5bbf
	ld a, c ; $5bc2
	add a, $5f ; $5bc3
	ld l, a ; $5bc5
	adc a, $5c ; $5bc6
	sub a, l ; $5bc8
	ld h, a ; $5bc9
	ld a, [hl] ; $5bca
	inc hl ; $5bcb
	inc hl ; $5bcc
	ld b, [hl] ; $5bcd
	ld a, a ; $5bce
	ld [$d814], a ; $5bcf
	ld a, b ; $5bd2
	ld [$d815], a ; $5bd3
	ld a, [$d82e] ; $5bd6
	add a, $2d ; $5bd9
	ld l, a ; $5bdb
	adc a, $5c ; $5bdc
	sub a, l ; $5bde
	ld h, a ; $5bdf
	ld b, [hl] ; $5be0
	call DrawDiagramTargetOverlay ; $5be1
	ret ; $5be4
	; $5be5, 130 bytes (records:2)
	dw $0052 ; record 0
	dw $0044 ; record 1
	dw $003d ; record 2
	dw $0044 ; record 3
	dw $003d ; record 4
	dw $0000 ; record 5
	dw $0052 ; record 6
	dw $0000 ; record 7
	dw $004e ; record 8
	dw $0038 ; record 9
	dw $0056 ; record 10
	dw $0038 ; record 11
	dw $0056 ; record 12
	dw $0028 ; record 13
	dw $004e ; record 14
	dw $0028 ; record 15
	dw $0100 ; record 16
	dw $0001 ; record 17
	dw $003a ; record 18
	dw $0024 ; record 19
	dw $0064 ; record 20
	dw $0024 ; record 21
	dw $0064 ; record 22
	dw $0034 ; record 23
	dw $003a ; record 24
	dw $0034 ; record 25
	dw $0003 ; record 26
	dw $0201 ; record 27
	dw $0052 ; record 28
	dw $0040 ; record 29
	dw $004d ; record 30
	dw $0040 ; record 31
	dw $004d ; record 32
	dw $0016 ; record 33
	dw $0052 ; record 34
	dw $0016 ; record 35
	dw $0104 ; record 36
	dw $0302 ; record 37
	dw $0040 ; record 38
	dw $0024 ; record 39
	dw $005d ; record 40
	dw $0024 ; record 41
	dw $005d ; record 42
	dw $0039 ; record 43
	dw $0040 ; record 44
	dw $0039 ; record 45
	dw $0046 ; record 46
	dw $0028 ; record 47
	dw $005e ; record 48
	dw $0028 ; record 49
	dw $0049 ; record 50
	dw $002f ; record 51
	dw $0056 ; record 52
	dw $002f ; record 53
	dw $0001 ; record 54
	dw $0030 ; record 55
	dw $0022 ; record 56
	dw $006f ; record 57
	dw $0022 ; record 58
	dw $0609 ; record 59
	dw $0708 ; record 60
	dw $0061 ; record 61
	dw $0044 ; record 62
	dw $0026 ; record 63
	dw $0044 ; record 64
DrillBriefing_ServeThroughPoles:
	ld a, $03 ; $5c67
	ld [$d82e], a ; $5c69
	call PoleServeBriefing_AdvanceAnim ; $5c6c
	ld a, $01 ; $5c6f
	ld hl, $46e2 ; $5c71
	call RegisterFrameTask ; $5c74
	ld a, $01 ; $5c77
	ld hl, $4736 ; $5c79
	call RegisterFrameTask ; $5c7c
	ld a, $01 ; $5c7f
	ld hl, $4754 ; $5c81
	call RegisterFrameTask ; $5c84
	ld a, $01 ; $5c87
	ld hl, $4876 ; $5c89
	call RegisterFrameTask ; $5c8c
	ld a, $01 ; $5c8f
	ld hl, $4676 ; $5c91
	call RegisterFrameTask ; $5c94
	ld hl, $1abb ; $5c97
	call DrawBriefingCaption ; $5c9a
	xor a, a ; $5c9d
	ld [$d82c], a ; $5c9e
	ld [$d82e], a ; $5ca1
Label_17_5ca4:
	call PoleServeBriefing_TickAnim ; $5ca4
	ld c, $00 ; $5ca7
	call AdvanceFrameCheckInput ; $5ca9
	and a, a ; $5cac
	jp z, Label_17_5ca4 ; $5cad
	call ClearFrameTasks ; $5cb0
	ld a, $01 ; $5cb3
	ld hl, $4406 ; $5cb5
	call RegisterFrameTask ; $5cb8
	ld a, $03 ; $5cbb
	ld [$d82e], a ; $5cbd
	call PoleServeBriefing_AdvanceAnim2 ; $5cc0
	ld a, $01 ; $5cc3
	ld hl, $46e2 ; $5cc5
	call RegisterFrameTask ; $5cc8
	ld a, $01 ; $5ccb
	ld hl, $4754 ; $5ccd
	call RegisterFrameTask ; $5cd0
	ld a, $01 ; $5cd3
	ld hl, $4676 ; $5cd5
	call RegisterFrameTask ; $5cd8
	ld a, $00 ; $5cdb
	ld [$d82a], a ; $5cdd
	ld a, $00 ; $5ce0
	ld [$d82b], a ; $5ce2
	ld a, $01 ; $5ce5
	ld hl, $48c1 ; $5ce7
	call RegisterFrameTask ; $5cea
	ld hl, $1abc ; $5ced
	call DrawBriefingCaption ; $5cf0
	xor a, a ; $5cf3
	ld [$d82c], a ; $5cf4
	ld [$d82e], a ; $5cf7
Label_17_5cfa:
	call PoleServeBriefing_TickAnim2 ; $5cfa
	ld a, [$d82e] ; $5cfd
	sla a ; $5d00
	sla a ; $5d02
	add a, $06 ; $5d04
	ld l, a ; $5d06
	adc a, $5f ; $5d07
	sub a, l ; $5d09
	ld h, a ; $5d0a
	ld a, [hl] ; $5d0b
	inc hl ; $5d0c
	inc hl ; $5d0d
	ld b, [hl] ; $5d0e
	ld a, a ; $5d0f
	ld [$d810], a ; $5d10
	ld a, b ; $5d13
	ld [$d811], a ; $5d14
	ld c, $00 ; $5d17
	call AdvanceFrameCheckInput ; $5d19
	and a, a ; $5d1c
	jp z, Label_17_5cfa ; $5d1d
	call ClearFrameTasks ; $5d20
	ld a, $01 ; $5d23
	ld hl, $4406 ; $5d25
	call RegisterFrameTask ; $5d28
	ld a, $03 ; $5d2b
	ld [$d82e], a ; $5d2d
	call PoleServeBriefing_AdvanceAnim2 ; $5d30
	ld a, $01 ; $5d33
	ld hl, $46e2 ; $5d35
	call RegisterFrameTask ; $5d38
	ld a, $00 ; $5d3b
	ld [$d82d], a ; $5d3d
	ld a, $4b ; $5d40
	ld [$d81c], a ; $5d42
	ld a, $36 ; $5d45
	ld [$d81d], a ; $5d47
	ld a, $01 ; $5d4a
	ld hl, $4754 ; $5d4c
	call RegisterFrameTask ; $5d4f
	ld a, $01 ; $5d52
	ld hl, $47ef ; $5d54
	call RegisterFrameTask ; $5d57
	ld a, $01 ; $5d5a
	ld hl, $4676 ; $5d5c
	call RegisterFrameTask ; $5d5f
	ld a, $00 ; $5d62
	ld [$d82a], a ; $5d64
	ld a, $00 ; $5d67
	ld [$d82b], a ; $5d69
	ld a, $01 ; $5d6c
	ld hl, $48c1 ; $5d6e
	call RegisterFrameTask ; $5d71
	ld hl, $1abd ; $5d74
	call DrawBriefingCaption ; $5d77
	call WaitForInputBlinking ; $5d7a
	call ClearFrameTasks ; $5d7d
	ld a, $01 ; $5d80
	ld hl, $4406 ; $5d82
	call RegisterFrameTask ; $5d85
	ld a, $03 ; $5d88
	ld [$d82e], a ; $5d8a
	call PoleServeBriefing_AdvanceAnim2 ; $5d8d
	ld a, $01 ; $5d90
	ld hl, $46e2 ; $5d92
	call RegisterFrameTask ; $5d95
	ld a, $01 ; $5d98
	ld hl, $47ef ; $5d9a
	call RegisterFrameTask ; $5d9d
	ld a, $01 ; $5da0
	ld hl, $4676 ; $5da2
	call RegisterFrameTask ; $5da5
	ld a, $00 ; $5da8
	ld [$d82a], a ; $5daa
	ld a, $00 ; $5dad
	ld [$d82b], a ; $5daf
	ld a, $01 ; $5db2
	ld hl, $48c1 ; $5db4
	call RegisterFrameTask ; $5db7
	ld hl, $1abe ; $5dba
	call DrawBriefingCaption ; $5dbd
Label_17_5dc0:
	call PoleServeBriefing_TickAnim2 ; $5dc0
	ld c, $01 ; $5dc3
	call AdvanceFrameCheckInput ; $5dc5
	and a, a ; $5dc8
	jp z, Label_17_5dc0 ; $5dc9
	call ClearFrameTasks ; $5dcc
	ret ; $5dcf
PoleServeBriefing_TickAnim:
	ld a, [$d82c] ; $5dd0
	inc a ; $5dd3
	ld [$d82c], a ; $5dd4
	cp a, $78 ; $5dd7
	jr nc, PoleServeBriefing_AdvanceAnim ; $5dd9
	ret ; $5ddb
PoleServeBriefing_AdvanceAnim:
	xor a, a ; $5ddc
	ld [$d82c], a ; $5ddd
	ld a, [$d82e] ; $5de0
	inc a ; $5de3
	and a, $03 ; $5de4
	ld [$d82e], a ; $5de6
	sla a ; $5de9
	sla a ; $5deb
	ld c, a ; $5ded
	add a, $06 ; $5dee
	ld l, a ; $5df0
	adc a, $5f ; $5df1
	sub a, l ; $5df3
	ld h, a ; $5df4
	ld a, [hl] ; $5df5
	inc hl ; $5df6
	inc hl ; $5df7
	ld b, [hl] ; $5df8
	ld a, a ; $5df9
	ld [$d810], a ; $5dfa
	ld a, b ; $5dfd
	ld [$d811], a ; $5dfe
	ld a, c ; $5e01
	add a, $26 ; $5e02
	ld l, a ; $5e04
	adc a, $5f ; $5e05
	sub a, l ; $5e07
	ld h, a ; $5e08
	ld a, [hl] ; $5e09
	inc hl ; $5e0a
	inc hl ; $5e0b
	ld b, [hl] ; $5e0c
	ld a, a ; $5e0d
	ld [$d81e], a ; $5e0e
	ld a, b ; $5e11
	ld [$d81f], a ; $5e12
	ld a, [$d82e] ; $5e15
	add a, $36 ; $5e18
	ld l, a ; $5e1a
	adc a, $5f ; $5e1b
	sub a, l ; $5e1d
	ld h, a ; $5e1e
	ld a, [hl] ; $5e1f
	ld [$d82d], a ; $5e20
	ld a, c ; $5e23
	add a, $3a ; $5e24
	ld l, a ; $5e26
	adc a, $5f ; $5e27
	sub a, l ; $5e29
	ld h, a ; $5e2a
	ld a, [hl] ; $5e2b
	inc hl ; $5e2c
	inc hl ; $5e2d
	ld b, [hl] ; $5e2e
	ld a, a ; $5e2f
	ld [$d81c], a ; $5e30
	ld a, b ; $5e33
	ld [$d81d], a ; $5e34
	ld a, [$d82e] ; $5e37
	add a, $5a ; $5e3a
	ld l, a ; $5e3c
	adc a, $5f ; $5e3d
	sub a, l ; $5e3f
	ld h, a ; $5e40
	ld a, [hl] ; $5e41
	ld [$d827], a ; $5e42
	ld a, c ; $5e45
	add a, $5e ; $5e46
	ld l, a ; $5e48
	adc a, $5f ; $5e49
	sub a, l ; $5e4b
	ld h, a ; $5e4c
	ld a, [hl] ; $5e4d
	inc hl ; $5e4e
	inc hl ; $5e4f
	ld b, [hl] ; $5e50
	ld a, a ; $5e51
	ld [$d818], a ; $5e52
	ld a, b ; $5e55
	ld [$d819], a ; $5e56
	ld a, [$d82e] ; $5e59
	add a, $6e ; $5e5c
	ld l, a ; $5e5e
	adc a, $5f ; $5e5f
	sub a, l ; $5e61
	ld h, a ; $5e62
	ld b, [hl] ; $5e63
	call DrawDiagramTargetOverlay ; $5e64
	ret ; $5e67
PoleServeBriefing_TickAnim2:
	ld a, [$d82c] ; $5e68
	inc a ; $5e6b
	ld [$d82c], a ; $5e6c
	cp a, $78 ; $5e6f
	jr nc, PoleServeBriefing_AdvanceAnim2 ; $5e71
	ret ; $5e73
PoleServeBriefing_AdvanceAnim2:
	xor a, a ; $5e74
	ld [$d82c], a ; $5e75
	ld a, [$d82e] ; $5e78
	inc a ; $5e7b
	and a, $03 ; $5e7c
	ld [$d82e], a ; $5e7e
	sla a ; $5e81
	sla a ; $5e83
	ld c, a ; $5e85
	add a, $16 ; $5e86
	ld l, a ; $5e88
	adc a, $5f ; $5e89
	sub a, l ; $5e8b
	ld h, a ; $5e8c
	ld a, [hl] ; $5e8d
	inc hl ; $5e8e
	inc hl ; $5e8f
	ld b, [hl] ; $5e90
	ld a, a ; $5e91
	ld [$d810], a ; $5e92
	ld a, b ; $5e95
	ld [$d811], a ; $5e96
	ld a, c ; $5e99
	add a, $72 ; $5e9a
	ld l, a ; $5e9c
	adc a, $5f ; $5e9d
	sub a, l ; $5e9f
	ld h, a ; $5ea0
	ld a, [hl] ; $5ea1
	inc hl ; $5ea2
	inc hl ; $5ea3
	ld b, [hl] ; $5ea4
	ld a, a ; $5ea5
	ld [$d828], a ; $5ea6
	ld a, b ; $5ea9
	ld [$d829], a ; $5eaa
	ld a, c ; $5ead
	add a, $82 ; $5eae
	ld l, a ; $5eb0
	adc a, $5f ; $5eb1
	sub a, l ; $5eb3
	ld h, a ; $5eb4
	ld a, [hl] ; $5eb5
	inc hl ; $5eb6
	inc hl ; $5eb7
	ld b, [hl] ; $5eb8
	ld a, a ; $5eb9
	ld [$d81a], a ; $5eba
	ld a, b ; $5ebd
	ld [$d81b], a ; $5ebe
	ld a, c ; $5ec1
	add a, $82 ; $5ec2
	ld l, a ; $5ec4
	adc a, $5f ; $5ec5
	sub a, l ; $5ec7
	ld h, a ; $5ec8
	ld a, [hl] ; $5ec9
	add a, $08 ; $5eca
	ld [$d820], a ; $5ecc
	ld a, [$d81b] ; $5ecf
	ld [$d821], a ; $5ed2
	ld a, [$d82e] ; $5ed5
	add a, $36 ; $5ed8
	ld l, a ; $5eda
	adc a, $5f ; $5edb
	sub a, l ; $5edd
	ld h, a ; $5ede
	ld a, [hl] ; $5edf
	ld [$d82d], a ; $5ee0
	ld a, c ; $5ee3
	add a, $4a ; $5ee4
	ld l, a ; $5ee6
	adc a, $5f ; $5ee7
	sub a, l ; $5ee9
	ld h, a ; $5eea
	ld a, [hl] ; $5eeb
	inc hl ; $5eec
	inc hl ; $5eed
	ld b, [hl] ; $5eee
	ld a, a ; $5eef
	ld [$d81c], a ; $5ef0
	ld a, b ; $5ef3
	ld [$d81d], a ; $5ef4
	ld a, [$d82e] ; $5ef7
	add a, $6e ; $5efa
	ld l, a ; $5efc
	adc a, $5f ; $5efd
	sub a, l ; $5eff
	ld h, a ; $5f00
	ld b, [hl] ; $5f01
	call DrawDiagramTargetOverlay ; $5f02
	ret ; $5f05
	; $5f06, 140 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
	dw $004f ; record 8
	dw $0044 ; record 9
	dw $0040 ; record 10
	dw $0044 ; record 11
	dw $0040 ; record 12
	dw $0003 ; record 13
	dw $004f ; record 14
	dw $0003 ; record 15
	dw $004e ; record 16
	dw $0038 ; record 17
	dw $0056 ; record 18
	dw $0038 ; record 19
	dw $0056 ; record 20
	dw $0028 ; record 21
	dw $004e ; record 22
	dw $0028 ; record 23
	dw $0100 ; record 24
	dw $0001 ; record 25
	dw $003a ; record 26
	dw $0024 ; record 27
	dw $0064 ; record 28
	dw $0024 ; record 29
	dw $0064 ; record 30
	dw $0034 ; record 31
	dw $003a ; record 32
	dw $0034 ; record 33
	dw $0042 ; record 34
	dw $0020 ; record 35
	dw $005d ; record 36
	dw $0020 ; record 37
	dw $005d ; record 38
	dw $0038 ; record 39
	dw $0042 ; record 40
	dw $0038 ; record 41
	dw $0003 ; record 42
	dw $0201 ; record 43
	dw $0052 ; record 44
	dw $0040 ; record 45
	dw $004d ; record 46
	dw $0040 ; record 47
	dw $004d ; record 48
	dw $0016 ; record 49
	dw $0052 ; record 50
	dw $0016 ; record 51
	dw $0104 ; record 52
	dw $0302 ; record 53
	dw $0048 ; record 54
	dw $0024 ; record 55
	dw $0055 ; record 56
	dw $0024 ; record 57
	dw $0055 ; record 58
	dw $0039 ; record 59
	dw $0048 ; record 60
	dw $0039 ; record 61
	dw $0050 ; record 62
	dw $0036 ; record 63
	dw $0048 ; record 64
	dw $0036 ; record 65
	dw $0048 ; record 66
	dw $0021 ; record 67
	dw $0050 ; record 68
	dw $0021 ; record 69
DrillBriefing_ServeAndVolley:
	ld a, $52 ; $5f92
	ld [$d810], a ; $5f94
	ld a, $44 ; $5f97
	ld [$d811], a ; $5f99
	ld a, $01 ; $5f9c
	ld hl, $46e2 ; $5f9e
	call RegisterFrameTask ; $5fa1
	ld a, $34 ; $5fa4
	ld [$d812], a ; $5fa6
	ld a, $06 ; $5fa9
	ld [$d813], a ; $5fab
	ld a, $01 ; $5fae
	ld hl, $470c ; $5fb0
	call RegisterFrameTask ; $5fb3
	ld a, $4e ; $5fb6
	ld [$d81e], a ; $5fb8
	ld a, $38 ; $5fbb
	ld [$d81f], a ; $5fbd
	ld a, $01 ; $5fc0
	ld hl, $4736 ; $5fc2
	call RegisterFrameTask ; $5fc5
	ld a, $00 ; $5fc8
	ld [$d82d], a ; $5fca
	ld a, $3a ; $5fcd
	ld [$d81c], a ; $5fcf
	ld a, $3c ; $5fd2
	ld [$d81d], a ; $5fd4
	ld a, $01 ; $5fd7
	ld hl, $4754 ; $5fd9
	call RegisterFrameTask ; $5fdc
	ld a, $03 ; $5fdf
	ld [$d827], a ; $5fe1
	ld a, $52 ; $5fe4
	ld [$d818], a ; $5fe6
	ld a, $40 ; $5fe9
	ld [$d819], a ; $5feb
	ld a, $01 ; $5fee
	ld hl, $4876 ; $5ff0
	call RegisterFrameTask ; $5ff3
	ld b, $06 ; $5ff6
	call DrawDiagramTargetOverlay ; $5ff8
	ld a, $01 ; $5ffb
	ld hl, $4676 ; $5ffd
	call RegisterFrameTask ; $6000
	ld hl, $1abf ; $6003
	call DrawBriefingCaption ; $6006
	call WaitForInputBlinking ; $6009
	call ClearFrameTasks ; $600c
	ld a, $01 ; $600f
	ld hl, $4406 ; $6011
	call RegisterFrameTask ; $6014
	call DrawDiagramTargetOverlay ; $6017
	ld a, $03 ; $601a
	ld [$d82e], a ; $601c
	call ServeAndVolleyBriefing_AdvanceAnim ; $601f
	ld a, $01 ; $6022
	ld hl, $46e2 ; $6024
	call RegisterFrameTask ; $6027
	ld a, $01 ; $602a
	ld hl, $470c ; $602c
	call RegisterFrameTask ; $602f
	ld a, $01 ; $6032
	ld hl, $4736 ; $6034
	call RegisterFrameTask ; $6037
	ld a, $01 ; $603a
	ld hl, $4754 ; $603c
	call RegisterFrameTask ; $603f
	ld a, $01 ; $6042
	ld hl, $4876 ; $6044
	call RegisterFrameTask ; $6047
	ld a, $01 ; $604a
	ld hl, $481c ; $604c
	call RegisterFrameTask ; $604f
	ld a, $0d ; $6052
	ld [$d82a], a ; $6054
	ld a, $0f ; $6057
	ld [$d82b], a ; $6059
	ld a, $01 ; $605c
	ld hl, $48c1 ; $605e
	call RegisterFrameTask ; $6061
	ld hl, $1ac0 ; $6064
	call DrawBriefingCaption ; $6067
	call WaitForInputBlinking ; $606a
	call ClearFrameTasks ; $606d
	ld a, $01 ; $6070
	ld hl, $4406 ; $6072
	call RegisterFrameTask ; $6075
	ld a, $03 ; $6078
	ld [$d82e], a ; $607a
	call ServeAndVolleyBriefing_AdvanceAnim ; $607d
	ld a, $01 ; $6080
	ld hl, $46e2 ; $6082
	call RegisterFrameTask ; $6085
	ld a, $01 ; $6088
	ld hl, $470c ; $608a
	call RegisterFrameTask ; $608d
	ld a, $01 ; $6090
	ld hl, $4736 ; $6092
	call RegisterFrameTask ; $6095
	ld a, $01 ; $6098
	ld hl, $4754 ; $609a
	call RegisterFrameTask ; $609d
	ld a, $01 ; $60a0
	ld hl, $4876 ; $60a2
	call RegisterFrameTask ; $60a5
	ld a, $01 ; $60a8
	ld hl, $481c ; $60aa
	call RegisterFrameTask ; $60ad
	ld a, $0d ; $60b0
	ld [$d82a], a ; $60b2
	ld a, $0f ; $60b5
	ld [$d82b], a ; $60b7
	ld a, $01 ; $60ba
	ld hl, $48c1 ; $60bc
	call RegisterFrameTask ; $60bf
	ld hl, $1ac1 ; $60c2
	call DrawBriefingCaption ; $60c5
	xor a, a ; $60c8
	ld [$d82c], a ; $60c9
	ld [$d82e], a ; $60cc
Label_17_60cf:
	call ServeAndVolleyBriefing_TickAnim ; $60cf
	ld c, $01 ; $60d2
	call AdvanceFrameCheckInput ; $60d4
	and a, a ; $60d7
	jp z, Label_17_60cf ; $60d8
	call ClearFrameTasks ; $60db
	ret ; $60de
ServeAndVolleyBriefing_TickAnim:
	ld a, [$d82c] ; $60df
	inc a ; $60e2
	ld [$d82c], a ; $60e3
	cp a, $78 ; $60e6
	jp nc, ServeAndVolleyBriefing_AdvanceAnim ; $60e8
	ret ; $60eb
ServeAndVolleyBriefing_AdvanceAnim:
	xor a, a ; $60ec
	ld [$d82c], a ; $60ed
	ld a, [$d82e] ; $60f0
	inc a ; $60f3
	and a, $03 ; $60f4
	ld [$d82e], a ; $60f6
	sla a ; $60f9
	sla a ; $60fb
	ld c, a ; $60fd
	add a, $b4 ; $60fe
	ld l, a ; $6100
	adc a, $61 ; $6101
	sub a, l ; $6103
	ld h, a ; $6104
	ld a, [hl] ; $6105
	inc hl ; $6106
	inc hl ; $6107
	ld b, [hl] ; $6108
	ld a, a ; $6109
	ld [$d810], a ; $610a
	ld a, b ; $610d
	ld [$d811], a ; $610e
	ld a, c ; $6111
	add a, $c4 ; $6112
	ld l, a ; $6114
	adc a, $61 ; $6115
	sub a, l ; $6117
	ld h, a ; $6118
	ld a, [hl] ; $6119
	inc hl ; $611a
	inc hl ; $611b
	ld b, [hl] ; $611c
	ld a, a ; $611d
	ld [$d812], a ; $611e
	ld a, b ; $6121
	ld [$d813], a ; $6122
	ld a, c ; $6125
	add a, $20 ; $6126
	ld l, a ; $6128
	adc a, $62 ; $6129
	sub a, l ; $612b
	ld h, a ; $612c
	ld a, [hl] ; $612d
	inc hl ; $612e
	inc hl ; $612f
	ld b, [hl] ; $6130
	ld a, a ; $6131
	ld [$d828], a ; $6132
	ld a, b ; $6135
	ld [$d829], a ; $6136
	ld a, c ; $6139
	add a, $d4 ; $613a
	ld l, a ; $613c
	adc a, $61 ; $613d
	sub a, l ; $613f
	ld h, a ; $6140
	ld a, [hl] ; $6141
	inc hl ; $6142
	inc hl ; $6143
	ld b, [hl] ; $6144
	ld a, a ; $6145
	ld [$d81e], a ; $6146
	ld a, b ; $6149
	ld [$d81f], a ; $614a
	ld a, [$d82e] ; $614d
	add a, $e4 ; $6150
	ld l, a ; $6152
	adc a, $61 ; $6153
	sub a, l ; $6155
	ld h, a ; $6156
	ld a, [hl] ; $6157
	ld [$d82d], a ; $6158
	ld a, c ; $615b
	add a, $e8 ; $615c
	ld l, a ; $615e
	adc a, $61 ; $615f
	sub a, l ; $6161
	ld h, a ; $6162
	ld a, [hl] ; $6163
	inc hl ; $6164
	inc hl ; $6165
	ld b, [hl] ; $6166
	ld a, a ; $6167
	ld [$d81c], a ; $6168
	ld a, b ; $616b
	ld [$d81d], a ; $616c
	ld a, [$d82e] ; $616f
	add a, $f8 ; $6172
	ld l, a ; $6174
	adc a, $61 ; $6175
	sub a, l ; $6177
	ld h, a ; $6178
	ld a, [hl] ; $6179
	ld [$d827], a ; $617a
	ld a, c ; $617d
	add a, $fc ; $617e
	ld l, a ; $6180
	adc a, $61 ; $6181
	sub a, l ; $6183
	ld h, a ; $6184
	ld a, [hl] ; $6185
	inc hl ; $6186
	inc hl ; $6187
	ld b, [hl] ; $6188
	ld a, a ; $6189
	ld [$d818], a ; $618a
	ld a, b ; $618d
	ld [$d819], a ; $618e
	ld a, [$d82e] ; $6191
	add a, $0c ; $6194
	ld l, a ; $6196
	adc a, $62 ; $6197
	sub a, l ; $6199
	ld h, a ; $619a
	ld a, [hl] ; $619b
	ld [$d825], a ; $619c
	ld a, c ; $619f
	add a, $10 ; $61a0
	ld l, a ; $61a2
	adc a, $62 ; $61a3
	sub a, l ; $61a5
	ld h, a ; $61a6
	ld a, [hl] ; $61a7
	inc hl ; $61a8
	inc hl ; $61a9
	ld b, [hl] ; $61aa
	ld a, a ; $61ab
	ld [$d823], a ; $61ac
	ld a, b ; $61af
	ld [$d824], a ; $61b0
	ret ; $61b3
	; $61b4, 124 bytes (records:2)
	dw $0052 ; record 0
	dw $0030 ; record 1
	dw $003c ; record 2
	dw $0030 ; record 3
	dw $003c ; record 4
	dw $0018 ; record 5
	dw $0052 ; record 6
	dw $0018 ; record 7
	dw $0034 ; record 8
	dw $0006 ; record 9
	dw $005a ; record 10
	dw $0006 ; record 11
	dw $005a ; record 12
	dw $0048 ; record 13
	dw $0034 ; record 14
	dw $0048 ; record 15
	dw $005d ; record 16
	dw $001c ; record 17
	dw $0047 ; record 18
	dw $001c ; record 19
	dw $0047 ; record 20
	dw $0046 ; record 21
	dw $005d ; record 22
	dw $0046 ; record 23
	dw $0001 ; record 24
	dw $0100 ; record 25
	dw $0064 ; record 26
	dw $0014 ; record 27
	dw $003a ; record 28
	dw $0014 ; record 29
	dw $003a ; record 30
	dw $0044 ; record 31
	dw $0064 ; record 32
	dw $0044 ; record 33
	dw $0201 ; record 34
	dw $0003 ; record 35
	dw $0046 ; record 36
	dw $0016 ; record 37
	dw $005a ; record 38
	dw $0016 ; record 39
	dw $005a ; record 40
	dw $0040 ; record 41
	dw $0046 ; record 42
	dw $0040 ; record 43
	dw $0000 ; record 44
	dw $0101 ; record 45
	dw $005b ; record 46
	dw $0021 ; record 47
	dw $0045 ; record 48
	dw $0021 ; record 49
	dw $0045 ; record 50
	dw $0037 ; record 51
	dw $005b ; record 52
	dw $0037 ; record 53
	dw $0052 ; record 54
	dw $0012 ; record 55
	dw $003e ; record 56
	dw $0012 ; record 57
	dw $003e ; record 58
	dw $003c ; record 59
	dw $0052 ; record 60
	dw $003c ; record 61
DrillBriefing_ServeAndSmash:
	ld a, $55 ; $6230
	ld [$d810], a ; $6232
	ld a, $44 ; $6235
	ld [$d811], a ; $6237
	ld a, $01 ; $623a
	ld hl, $46e2 ; $623c
	call RegisterFrameTask ; $623f
	ld a, $34 ; $6242
	ld [$d812], a ; $6244
	ld a, $06 ; $6247
	ld [$d813], a ; $6249
	ld a, $01 ; $624c
	ld hl, $470c ; $624e
	call RegisterFrameTask ; $6251
	ld a, $4e ; $6254
	ld [$d81e], a ; $6256
	ld a, $38 ; $6259
	ld [$d81f], a ; $625b
	ld a, $01 ; $625e
	ld hl, $4736 ; $6260
	call RegisterFrameTask ; $6263
	ld a, $00 ; $6266
	ld [$d82d], a ; $6268
	ld a, $3a ; $626b
	ld [$d81c], a ; $626d
	ld a, $20 ; $6270
	ld [$d81d], a ; $6272
	ld a, $01 ; $6275
	ld hl, $4754 ; $6277
	call RegisterFrameTask ; $627a
	ld a, $03 ; $627d
	ld [$d827], a ; $627f
	ld a, $52 ; $6282
	ld [$d818], a ; $6284
	ld a, $40 ; $6287
	ld [$d819], a ; $6289
	ld a, $01 ; $628c
	ld hl, $4876 ; $628e
	call RegisterFrameTask ; $6291
	ld a, $0d ; $6294
	ld [$d82a], a ; $6296
	ld a, $00 ; $6299
	ld [$d82b], a ; $629b
	ld a, $3e ; $629e
	ld [$d828], a ; $62a0
	ld a, $22 ; $62a3
	ld [$d829], a ; $62a5
	ld a, $01 ; $62a8
	ld hl, $48c1 ; $62aa
	call RegisterFrameTask ; $62ad
	ld hl, $1ac2 ; $62b0
	call DrawBriefingCaption ; $62b3
	call WaitForInputBlinking ; $62b6
	call ClearFrameTasks ; $62b9
	ld a, $01 ; $62bc
	ld hl, $4406 ; $62be
	call RegisterFrameTask ; $62c1
	ld a, $55 ; $62c4
	ld [$d810], a ; $62c6
	ld a, $44 ; $62c9
	ld [$d811], a ; $62cb
	ld a, $01 ; $62ce
	ld hl, $46e2 ; $62d0
	call RegisterFrameTask ; $62d3
	ld a, $34 ; $62d6
	ld [$d812], a ; $62d8
	ld a, $06 ; $62db
	ld [$d813], a ; $62dd
	ld a, $01 ; $62e0
	ld hl, $470c ; $62e2
	call RegisterFrameTask ; $62e5
	ld a, $00 ; $62e8
	ld [$d82d], a ; $62ea
	ld a, $3a ; $62ed
	ld [$d81c], a ; $62ef
	ld a, $3c ; $62f2
	ld [$d81d], a ; $62f4
	ld a, $01 ; $62f7
	ld hl, $4754 ; $62f9
	call RegisterFrameTask ; $62fc
	ld b, $06 ; $62ff
	call DrawDiagramTargetOverlay ; $6301
	ld a, $01 ; $6304
	ld hl, $4676 ; $6306
	call RegisterFrameTask ; $6309
	ld hl, $1ac3 ; $630c
	call DrawBriefingCaption ; $630f
	call WaitForInputBlinking ; $6312
	call ClearFrameTasks ; $6315
	ld a, $01 ; $6318
	ld hl, $4406 ; $631a
	call RegisterFrameTask ; $631d
	call DrawDiagramTargetOverlay ; $6320
	ld a, $52 ; $6323
	ld [$d810], a ; $6325
	ld a, $30 ; $6328
	ld [$d811], a ; $632a
	ld a, $01 ; $632d
	ld hl, $46e2 ; $632f
	call RegisterFrameTask ; $6332
	ld a, $34 ; $6335
	ld [$d812], a ; $6337
	ld a, $06 ; $633a
	ld [$d813], a ; $633c
	ld a, $01 ; $633f
	ld hl, $470c ; $6341
	call RegisterFrameTask ; $6344
	ld a, $5d ; $6347
	ld [$d81e], a ; $6349
	ld a, $1b ; $634c
	ld [$d81f], a ; $634e
	ld a, $01 ; $6351
	ld hl, $4736 ; $6353
	call RegisterFrameTask ; $6356
	ld a, $01 ; $6359
	ld [$d827], a ; $635b
	ld a, $46 ; $635e
	ld [$d818], a ; $6360
	ld a, $16 ; $6363
	ld [$d819], a ; $6365
	ld a, $01 ; $6368
	ld hl, $4876 ; $636a
	call RegisterFrameTask ; $636d
	ld a, $00 ; $6370
	ld [$d825], a ; $6372
	ld a, $5b ; $6375
	ld [$d823], a ; $6377
	ld a, $21 ; $637a
	ld [$d824], a ; $637c
	ld a, $01 ; $637f
	ld hl, $481c ; $6381
	call RegisterFrameTask ; $6384
	ld a, $04 ; $6387
	ld [$d822], a ; $6389
	ld a, $2d ; $638c
	ld [$d814], a ; $638e
	ld a, $30 ; $6391
	ld [$d815], a ; $6393
	ld a, $01 ; $6396
	ld hl, $478e ; $6398
	call RegisterFrameTask ; $639b
	ld hl, $1ac4 ; $639e
	call DrawBriefingCaption ; $63a1
	call WaitForInputBlinking ; $63a4
	call ClearFrameTasks ; $63a7
	ld a, $01 ; $63aa
	ld hl, $4406 ; $63ac
	call RegisterFrameTask ; $63af
	ld a, $55 ; $63b2
	ld [$d810], a ; $63b4
	ld a, $44 ; $63b7
	ld [$d811], a ; $63b9
	ld a, $01 ; $63bc
	ld hl, $46e2 ; $63be
	call RegisterFrameTask ; $63c1
	ld a, $34 ; $63c4
	ld [$d812], a ; $63c6
	ld a, $06 ; $63c9
	ld [$d813], a ; $63cb
	ld a, $01 ; $63ce
	ld hl, $470c ; $63d0
	call RegisterFrameTask ; $63d3
	ld a, $50 ; $63d6
	ld [$d81e], a ; $63d8
	ld a, $37 ; $63db
	ld [$d81f], a ; $63dd
	ld a, $01 ; $63e0
	ld hl, $4736 ; $63e2
	call RegisterFrameTask ; $63e5
	ld a, $03 ; $63e8
	ld [$d827], a ; $63ea
	ld a, $54 ; $63ed
	ld [$d818], a ; $63ef
	ld a, $3d ; $63f2
	ld [$d819], a ; $63f4
	ld a, $01 ; $63f7
	ld hl, $4876 ; $63f9
	call RegisterFrameTask ; $63fc
	ld a, $0d ; $63ff
	ld [$d82a], a ; $6401
	ld a, $00 ; $6404
	ld [$d82b], a ; $6406
	ld a, $3e ; $6409
	ld [$d828], a ; $640b
	ld a, $22 ; $640e
	ld [$d829], a ; $6410
	ld a, $01 ; $6413
	ld hl, $48c1 ; $6415
	call RegisterFrameTask ; $6418
	ld hl, $1ac5 ; $641b
	call DrawBriefingCaption ; $641e
Label_17_6421:
	ld a, [$d82c] ; $6421
	inc a ; $6424
	ld [$d82c], a ; $6425
	cp a, $78 ; $6428
	jp c, Label_17_64b0 ; $642a
	xor a, a ; $642d
	ld [$d82c], a ; $642e
	ld a, [$d82e] ; $6431
	inc a ; $6434
	and a, $03 ; $6435
	ld [$d82e], a ; $6437
	sla a ; $643a
	sla a ; $643c
	ld c, a ; $643e
	add a, $bd ; $643f
	ld l, a ; $6441
	adc a, $64 ; $6442
	sub a, l ; $6444
	ld h, a ; $6445
	ld a, [hl] ; $6446
	inc hl ; $6447
	inc hl ; $6448
	ld b, [hl] ; $6449
	ld a, a ; $644a
	ld [$d810], a ; $644b
	ld a, b ; $644e
	ld [$d811], a ; $644f
	ld a, c ; $6452
	add a, $cd ; $6453
	ld l, a ; $6455
	adc a, $64 ; $6456
	sub a, l ; $6458
	ld h, a ; $6459
	ld a, [hl] ; $645a
	inc hl ; $645b
	inc hl ; $645c
	ld b, [hl] ; $645d
	ld a, a ; $645e
	ld [$d812], a ; $645f
	ld a, b ; $6462
	ld [$d813], a ; $6463
	ld a, c ; $6466
	add a, $29 ; $6467
	ld l, a ; $6469
	adc a, $65 ; $646a
	sub a, l ; $646c
	ld h, a ; $646d
	ld a, [hl] ; $646e
	inc hl ; $646f
	inc hl ; $6470
	ld b, [hl] ; $6471
	ld a, a ; $6472
	ld [$d828], a ; $6473
	ld a, b ; $6476
	ld [$d829], a ; $6477
	ld a, c ; $647a
	add a, $dd ; $647b
	ld l, a ; $647d
	adc a, $64 ; $647e
	sub a, l ; $6480
	ld h, a ; $6481
	ld a, [hl] ; $6482
	inc hl ; $6483
	inc hl ; $6484
	ld b, [hl] ; $6485
	ld a, a ; $6486
	ld [$d81e], a ; $6487
	ld a, b ; $648a
	ld [$d81f], a ; $648b
	ld a, [$d82e] ; $648e
	add a, $01 ; $6491
	ld l, a ; $6493
	adc a, $65 ; $6494
	sub a, l ; $6496
	ld h, a ; $6497
	ld a, [hl] ; $6498
	ld [$d827], a ; $6499
	ld a, c ; $649c
	add a, $05 ; $649d
	ld l, a ; $649f
	adc a, $65 ; $64a0
	sub a, l ; $64a2
	ld h, a ; $64a3
	ld a, [hl] ; $64a4
	inc hl ; $64a5
	inc hl ; $64a6
	ld b, [hl] ; $64a7
	ld a, a ; $64a8
	ld [$d818], a ; $64a9
	ld a, b ; $64ac
	ld [$d819], a ; $64ad
Label_17_64b0:
	ld c, $01 ; $64b0
	call AdvanceFrameCheckInput ; $64b2
	and a, a ; $64b5
	jp z, Label_17_6421 ; $64b6
	call ClearFrameTasks ; $64b9
	ret ; $64bc
	; $64bd, 124 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
	dw $0034 ; record 8
	dw $0006 ; record 9
	dw $005a ; record 10
	dw $0006 ; record 11
	dw $005a ; record 12
	dw $0046 ; record 13
	dw $0034 ; record 14
	dw $0046 ; record 15
	dw $0050 ; record 16
	dw $0037 ; record 17
	dw $0054 ; record 18
	dw $0037 ; record 19
	dw $0054 ; record 20
	dw $0028 ; record 21
	dw $0050 ; record 22
	dw $0028 ; record 23
	dw $0001 ; record 24
	dw $0100 ; record 25
	dw $0064 ; record 26
	dw $0014 ; record 27
	dw $003a ; record 28
	dw $0014 ; record 29
	dw $003a ; record 30
	dw $0044 ; record 31
	dw $0064 ; record 32
	dw $0044 ; record 33
	dw $0003 ; record 34
	dw $0201 ; record 35
	dw $0054 ; record 36
	dw $003d ; record 37
	dw $004c ; record 38
	dw $003d ; record 39
	dw $004c ; record 40
	dw $0016 ; record 41
	dw $0054 ; record 42
	dw $0016 ; record 43
	dw $0000 ; record 44
	dw $0101 ; record 45
	dw $005b ; record 46
	dw $0021 ; record 47
	dw $0045 ; record 48
	dw $0021 ; record 49
	dw $0045 ; record 50
	dw $0037 ; record 51
	dw $005b ; record 52
	dw $0037 ; record 53
	dw $003e ; record 54
	dw $0022 ; record 55
	dw $0052 ; record 56
	dw $0022 ; record 57
	dw $0052 ; record 58
	dw $003c ; record 59
	dw $003e ; record 60
	dw $003c ; record 61
DrillBriefing_ServeAndSmash2:
	ld a, $55 ; $6539
	ld [$d810], a ; $653b
	ld a, $44 ; $653e
	ld [$d811], a ; $6540
	ld a, $01 ; $6543
	ld hl, $46e2 ; $6545
	call RegisterFrameTask ; $6548
	ld a, $34 ; $654b
	ld [$d812], a ; $654d
	ld a, $06 ; $6550
	ld [$d813], a ; $6552
	ld a, $01 ; $6555
	ld hl, $470c ; $6557
	call RegisterFrameTask ; $655a
	ld a, $4e ; $655d
	ld [$d81e], a ; $655f
	ld a, $38 ; $6562
	ld [$d81f], a ; $6564
	ld a, $01 ; $6567
	ld hl, $4736 ; $6569
	call RegisterFrameTask ; $656c
	ld a, $00 ; $656f
	ld [$d82d], a ; $6571
	ld a, $3a ; $6574
	ld [$d81c], a ; $6576
	ld a, $20 ; $6579
	ld [$d81d], a ; $657b
	ld a, $01 ; $657e
	ld hl, $4754 ; $6580
	call RegisterFrameTask ; $6583
	ld a, $03 ; $6586
	ld [$d827], a ; $6588
	ld a, $52 ; $658b
	ld [$d818], a ; $658d
	ld a, $40 ; $6590
	ld [$d819], a ; $6592
	ld a, $01 ; $6595
	ld hl, $4876 ; $6597
	call RegisterFrameTask ; $659a
	ld a, $0d ; $659d
	ld [$d82a], a ; $659f
	ld a, $00 ; $65a2
	ld [$d82b], a ; $65a4
	ld a, $3e ; $65a7
	ld [$d828], a ; $65a9
	ld a, $22 ; $65ac
	ld [$d829], a ; $65ae
	ld a, $01 ; $65b1
	ld hl, $48c1 ; $65b3
	call RegisterFrameTask ; $65b6
	ld hl, $1ac6 ; $65b9
	call DrawBriefingCaption ; $65bc
	call WaitForInputBlinking ; $65bf
	call ClearFrameTasks ; $65c2
	ld a, $01 ; $65c5
	ld hl, $4406 ; $65c7
	call RegisterFrameTask ; $65ca
	ld a, $55 ; $65cd
	ld [$d810], a ; $65cf
	ld a, $44 ; $65d2
	ld [$d811], a ; $65d4
	ld a, $01 ; $65d7
	ld hl, $46e2 ; $65d9
	call RegisterFrameTask ; $65dc
	ld a, $34 ; $65df
	ld [$d812], a ; $65e1
	ld a, $06 ; $65e4
	ld [$d813], a ; $65e6
	ld a, $01 ; $65e9
	ld hl, $470c ; $65eb
	call RegisterFrameTask ; $65ee
	ld a, $00 ; $65f1
	ld [$d82d], a ; $65f3
	ld a, $3a ; $65f6
	ld [$d81c], a ; $65f8
	ld a, $3c ; $65fb
	ld [$d81d], a ; $65fd
	ld a, $01 ; $6600
	ld hl, $4754 ; $6602
	call RegisterFrameTask ; $6605
	ld b, $06 ; $6608
	call DrawDiagramTargetOverlay ; $660a
	ld a, $01 ; $660d
	ld hl, $4676 ; $660f
	call RegisterFrameTask ; $6612
	ld hl, $1ac7 ; $6615
	call DrawBriefingCaption ; $6618
	call WaitForInputBlinking ; $661b
	call ClearFrameTasks ; $661e
	ld a, $01 ; $6621
	ld hl, $4406 ; $6623
	call RegisterFrameTask ; $6626
	call DrawDiagramTargetOverlay ; $6629
	ld a, $52 ; $662c
	ld [$d810], a ; $662e
	ld a, $30 ; $6631
	ld [$d811], a ; $6633
	ld a, $01 ; $6636
	ld hl, $46e2 ; $6638
	call RegisterFrameTask ; $663b
	ld a, $34 ; $663e
	ld [$d812], a ; $6640
	ld a, $06 ; $6643
	ld [$d813], a ; $6645
	ld a, $01 ; $6648
	ld hl, $470c ; $664a
	call RegisterFrameTask ; $664d
	ld a, $5d ; $6650
	ld [$d81e], a ; $6652
	ld a, $1b ; $6655
	ld [$d81f], a ; $6657
	ld a, $01 ; $665a
	ld hl, $4736 ; $665c
	call RegisterFrameTask ; $665f
	ld a, $01 ; $6662
	ld [$d827], a ; $6664
	ld a, $46 ; $6667
	ld [$d818], a ; $6669
	ld a, $16 ; $666c
	ld [$d819], a ; $666e
	ld a, $01 ; $6671
	ld hl, $4876 ; $6673
	call RegisterFrameTask ; $6676
	ld a, $00 ; $6679
	ld [$d825], a ; $667b
	ld a, $5b ; $667e
	ld [$d823], a ; $6680
	ld a, $21 ; $6683
	ld [$d824], a ; $6685
	ld a, $01 ; $6688
	ld hl, $481c ; $668a
	call RegisterFrameTask ; $668d
	ld a, $05 ; $6690
	ld [$d822], a ; $6692
	ld a, $2d ; $6695
	ld [$d814], a ; $6697
	ld a, $30 ; $669a
	ld [$d815], a ; $669c
	ld a, $01 ; $669f
	ld hl, $478e ; $66a1
	call RegisterFrameTask ; $66a4
	ld hl, $1ac8 ; $66a7
	call DrawBriefingCaption ; $66aa
	call WaitForInputBlinking ; $66ad
	call ClearFrameTasks ; $66b0
	ld a, $01 ; $66b3
	ld hl, $4406 ; $66b5
	call RegisterFrameTask ; $66b8
	ld a, $55 ; $66bb
	ld [$d810], a ; $66bd
	ld a, $44 ; $66c0
	ld [$d811], a ; $66c2
	ld a, $01 ; $66c5
	ld hl, $46e2 ; $66c7
	call RegisterFrameTask ; $66ca
	ld a, $34 ; $66cd
	ld [$d812], a ; $66cf
	ld a, $06 ; $66d2
	ld [$d813], a ; $66d4
	ld a, $01 ; $66d7
	ld hl, $470c ; $66d9
	call RegisterFrameTask ; $66dc
	ld a, $50 ; $66df
	ld [$d81e], a ; $66e1
	ld a, $37 ; $66e4
	ld [$d81f], a ; $66e6
	ld a, $01 ; $66e9
	ld hl, $4736 ; $66eb
	call RegisterFrameTask ; $66ee
	ld a, $03 ; $66f1
	ld [$d827], a ; $66f3
	ld a, $54 ; $66f6
	ld [$d818], a ; $66f8
	ld a, $3d ; $66fb
	ld [$d819], a ; $66fd
	ld a, $01 ; $6700
	ld hl, $4876 ; $6702
	call RegisterFrameTask ; $6705
	ld a, $0d ; $6708
	ld [$d82a], a ; $670a
	ld a, $00 ; $670d
	ld [$d82b], a ; $670f
	ld a, $3e ; $6712
	ld [$d828], a ; $6714
	ld a, $22 ; $6717
	ld [$d829], a ; $6719
	ld a, $01 ; $671c
	ld hl, $48c1 ; $671e
	call RegisterFrameTask ; $6721
	ld hl, $1ac9 ; $6724
	call DrawBriefingCaption ; $6727
Label_17_672a:
	ld a, [$d82c] ; $672a
	inc a ; $672d
	ld [$d82c], a ; $672e
	cp a, $78 ; $6731
	jp c, Label_17_67b9 ; $6733
	xor a, a ; $6736
	ld [$d82c], a ; $6737
	ld a, [$d82e] ; $673a
	inc a ; $673d
	and a, $03 ; $673e
	ld [$d82e], a ; $6740
	sla a ; $6743
	sla a ; $6745
	ld c, a ; $6747
	add a, $c6 ; $6748
	ld l, a ; $674a
	adc a, $67 ; $674b
	sub a, l ; $674d
	ld h, a ; $674e
	ld a, [hl] ; $674f
	inc hl ; $6750
	inc hl ; $6751
	ld b, [hl] ; $6752
	ld a, a ; $6753
	ld [$d810], a ; $6754
	ld a, b ; $6757
	ld [$d811], a ; $6758
	ld a, c ; $675b
	add a, $d6 ; $675c
	ld l, a ; $675e
	adc a, $67 ; $675f
	sub a, l ; $6761
	ld h, a ; $6762
	ld a, [hl] ; $6763
	inc hl ; $6764
	inc hl ; $6765
	ld b, [hl] ; $6766
	ld a, a ; $6767
	ld [$d812], a ; $6768
	ld a, b ; $676b
	ld [$d813], a ; $676c
	ld a, c ; $676f
	add a, $32 ; $6770
	ld l, a ; $6772
	adc a, $68 ; $6773
	sub a, l ; $6775
	ld h, a ; $6776
	ld a, [hl] ; $6777
	inc hl ; $6778
	inc hl ; $6779
	ld b, [hl] ; $677a
	ld a, a ; $677b
	ld [$d828], a ; $677c
	ld a, b ; $677f
	ld [$d829], a ; $6780
	ld a, c ; $6783
	add a, $e6 ; $6784
	ld l, a ; $6786
	adc a, $67 ; $6787
	sub a, l ; $6789
	ld h, a ; $678a
	ld a, [hl] ; $678b
	inc hl ; $678c
	inc hl ; $678d
	ld b, [hl] ; $678e
	ld a, a ; $678f
	ld [$d81e], a ; $6790
	ld a, b ; $6793
	ld [$d81f], a ; $6794
	ld a, [$d82e] ; $6797
	add a, $0a ; $679a
	ld l, a ; $679c
	adc a, $68 ; $679d
	sub a, l ; $679f
	ld h, a ; $67a0
	ld a, [hl] ; $67a1
	ld [$d827], a ; $67a2
	ld a, c ; $67a5
	add a, $0e ; $67a6
	ld l, a ; $67a8
	adc a, $68 ; $67a9
	sub a, l ; $67ab
	ld h, a ; $67ac
	ld a, [hl] ; $67ad
	inc hl ; $67ae
	inc hl ; $67af
	ld b, [hl] ; $67b0
	ld a, a ; $67b1
	ld [$d818], a ; $67b2
	ld a, b ; $67b5
	ld [$d819], a ; $67b6
Label_17_67b9:
	ld c, $01 ; $67b9
	call AdvanceFrameCheckInput ; $67bb
	and a, a ; $67be
	jp z, Label_17_672a ; $67bf
	call ClearFrameTasks ; $67c2
	ret ; $67c5
	; $67c6, 124 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
	dw $0034 ; record 8
	dw $0006 ; record 9
	dw $005a ; record 10
	dw $0006 ; record 11
	dw $005a ; record 12
	dw $0046 ; record 13
	dw $0034 ; record 14
	dw $0046 ; record 15
	dw $0050 ; record 16
	dw $0037 ; record 17
	dw $0054 ; record 18
	dw $0037 ; record 19
	dw $0054 ; record 20
	dw $0028 ; record 21
	dw $0050 ; record 22
	dw $0028 ; record 23
	dw $0001 ; record 24
	dw $0100 ; record 25
	dw $0064 ; record 26
	dw $0014 ; record 27
	dw $003a ; record 28
	dw $0014 ; record 29
	dw $003a ; record 30
	dw $0044 ; record 31
	dw $0064 ; record 32
	dw $0044 ; record 33
	dw $0003 ; record 34
	dw $0201 ; record 35
	dw $0054 ; record 36
	dw $003d ; record 37
	dw $004c ; record 38
	dw $003d ; record 39
	dw $004c ; record 40
	dw $0016 ; record 41
	dw $0054 ; record 42
	dw $0016 ; record 43
	dw $0000 ; record 44
	dw $0101 ; record 45
	dw $005b ; record 46
	dw $0021 ; record 47
	dw $0045 ; record 48
	dw $0021 ; record 49
	dw $0045 ; record 50
	dw $0037 ; record 51
	dw $005b ; record 52
	dw $0037 ; record 53
	dw $003e ; record 54
	dw $0022 ; record 55
	dw $0052 ; record 56
	dw $0022 ; record 57
	dw $0052 ; record 58
	dw $003c ; record 59
	dw $003e ; record 60
	dw $003c ; record 61
DrillBriefing_ReturnToTarget:
	ld a, $55 ; $6842
	ld [$d810], a ; $6844
	ld a, $44 ; $6847
	ld [$d811], a ; $6849
	ld a, $01 ; $684c
	ld hl, $46e2 ; $684e
	call RegisterFrameTask ; $6851
	ld a, $3a ; $6854
	ld [$d812], a ; $6856
	ld a, $03 ; $6859
	ld [$d813], a ; $685b
	ld a, $01 ; $685e
	ld hl, $470c ; $6860
	call RegisterFrameTask ; $6863
	ld a, $54 ; $6866
	ld [$d81e], a ; $6868
	ld a, $28 ; $686b
	ld [$d81f], a ; $686d
	ld a, $01 ; $6870
	ld hl, $4736 ; $6872
	call RegisterFrameTask ; $6875
	ld a, $01 ; $6878
	ld [$d827], a ; $687a
	ld a, $4c ; $687d
	ld [$d818], a ; $687f
	ld a, $16 ; $6882
	ld [$d819], a ; $6884
	ld a, $01 ; $6887
	ld hl, $4876 ; $6889
	call RegisterFrameTask ; $688c
	ld hl, $1c03 ; $688f
	call DrawBriefingCaption ; $6892
	call WaitForInputBlinking ; $6895
	call ClearFrameTasks ; $6898
	ld a, $01 ; $689b
	ld hl, $4406 ; $689d
	call RegisterFrameTask ; $68a0
	ld a, $03 ; $68a3
	ld [$d82e], a ; $68a5
	call ReturnToTargetBriefing_AdvanceAnim ; $68a8
	ld a, $01 ; $68ab
	ld hl, $46e2 ; $68ad
	call RegisterFrameTask ; $68b0
	ld a, $01 ; $68b3
	ld hl, $470c ; $68b5
	call RegisterFrameTask ; $68b8
	ld a, $01 ; $68bb
	ld hl, $4736 ; $68bd
	call RegisterFrameTask ; $68c0
	ld a, $01 ; $68c3
	ld hl, $4754 ; $68c5
	call RegisterFrameTask ; $68c8
	ld a, $01 ; $68cb
	ld hl, $4876 ; $68cd
	call RegisterFrameTask ; $68d0
	ld a, $0d ; $68d3
	ld [$d82a], a ; $68d5
	ld a, $09 ; $68d8
	ld [$d82b], a ; $68da
	ld a, $01 ; $68dd
	ld hl, $48c1 ; $68df
	call RegisterFrameTask ; $68e2
	ld hl, $1c04 ; $68e5
	call DrawBriefingCaption ; $68e8
	call WaitForInputBlinking ; $68eb
	call ClearFrameTasks ; $68ee
	ld a, $01 ; $68f1
	ld hl, $4406 ; $68f3
	call RegisterFrameTask ; $68f6
	ld a, $03 ; $68f9
	ld [$d82e], a ; $68fb
	call ReturnToTargetBriefing_AdvanceAnim ; $68fe
	ld a, $01 ; $6901
	ld hl, $46e2 ; $6903
	call RegisterFrameTask ; $6906
	ld a, $01 ; $6909
	ld hl, $470c ; $690b
	call RegisterFrameTask ; $690e
	ld a, $01 ; $6911
	ld hl, $4736 ; $6913
	call RegisterFrameTask ; $6916
	ld a, $01 ; $6919
	ld hl, $4754 ; $691b
	call RegisterFrameTask ; $691e
	ld a, $01 ; $6921
	ld hl, $4876 ; $6923
	call RegisterFrameTask ; $6926
	ld a, $0d ; $6929
	ld [$d82a], a ; $692b
	ld a, $09 ; $692e
	ld [$d82b], a ; $6930
	ld a, $01 ; $6933
	ld hl, $48c1 ; $6935
	call RegisterFrameTask ; $6938
	ld hl, $1c05 ; $693b
	call DrawBriefingCaption ; $693e
	xor a, a ; $6941
	ld [$d82c], a ; $6942
	ld [$d82e], a ; $6945
Label_17_6948:
	call ReturnToTargetBriefing_TickAnim ; $6948
	ld c, $01 ; $694b
	call AdvanceFrameCheckInput ; $694d
	and a, a ; $6950
	jp z, Label_17_6948 ; $6951
	call ClearFrameTasks ; $6954
	ret ; $6957
ReturnToTargetBriefing_TickAnim:
	ld a, [$d82c] ; $6958
	inc a ; $695b
	ld [$d82c], a ; $695c
	cp a, $78 ; $695f
	jp nc, ReturnToTargetBriefing_AdvanceAnim ; $6961
	ret ; $6964
ReturnToTargetBriefing_AdvanceAnim:
	xor a, a ; $6965
	ld [$d82c], a ; $6966
	ld a, [$d82e] ; $6969
	inc a ; $696c
	and a, $03 ; $696d
	ld [$d82e], a ; $696f
	sla a ; $6972
	sla a ; $6974
	ld c, a ; $6976
	add a, $0b ; $6977
	ld l, a ; $6979
	adc a, $6a ; $697a
	sub a, l ; $697c
	ld h, a ; $697d
	ld a, [hl] ; $697e
	inc hl ; $697f
	inc hl ; $6980
	ld b, [hl] ; $6981
	ld a, a ; $6982
	ld [$d810], a ; $6983
	ld a, b ; $6986
	ld [$d811], a ; $6987
	ld a, c ; $698a
	add a, $1b ; $698b
	ld l, a ; $698d
	adc a, $6a ; $698e
	sub a, l ; $6990
	ld h, a ; $6991
	ld a, [hl] ; $6992
	inc hl ; $6993
	inc hl ; $6994
	ld b, [hl] ; $6995
	ld a, a ; $6996
	ld [$d812], a ; $6997
	ld a, b ; $699a
	ld [$d813], a ; $699b
	ld a, c ; $699e
	add a, $63 ; $699f
	ld l, a ; $69a1
	adc a, $6a ; $69a2
	sub a, l ; $69a4
	ld h, a ; $69a5
	ld a, [hl] ; $69a6
	inc hl ; $69a7
	inc hl ; $69a8
	ld b, [hl] ; $69a9
	ld a, a ; $69aa
	ld [$d828], a ; $69ab
	ld a, b ; $69ae
	ld [$d829], a ; $69af
	ld a, c ; $69b2
	add a, $2b ; $69b3
	ld l, a ; $69b5
	adc a, $6a ; $69b6
	sub a, l ; $69b8
	ld h, a ; $69b9
	ld a, [hl] ; $69ba
	inc hl ; $69bb
	inc hl ; $69bc
	ld b, [hl] ; $69bd
	ld a, a ; $69be
	ld [$d81e], a ; $69bf
	ld a, b ; $69c2
	ld [$d81f], a ; $69c3
	ld a, [$d82e] ; $69c6
	add a, $3b ; $69c9
	ld l, a ; $69cb
	adc a, $6a ; $69cc
	sub a, l ; $69ce
	ld h, a ; $69cf
	ld a, [hl] ; $69d0
	ld [$d82d], a ; $69d1
	ld a, c ; $69d4
	add a, $3f ; $69d5
	ld l, a ; $69d7
	adc a, $6a ; $69d8
	sub a, l ; $69da
	ld h, a ; $69db
	ld a, [hl] ; $69dc
	inc hl ; $69dd
	inc hl ; $69de
	ld b, [hl] ; $69df
	ld a, a ; $69e0
	ld [$d81c], a ; $69e1
	ld a, b ; $69e4
	ld [$d81d], a ; $69e5
	ld a, [$d82e] ; $69e8
	add a, $4f ; $69eb
	ld l, a ; $69ed
	adc a, $6a ; $69ee
	sub a, l ; $69f0
	ld h, a ; $69f1
	ld a, [hl] ; $69f2
	ld [$d827], a ; $69f3
	ld a, c ; $69f6
	add a, $53 ; $69f7
	ld l, a ; $69f9
	adc a, $6a ; $69fa
	sub a, l ; $69fc
	ld h, a ; $69fd
	ld a, [hl] ; $69fe
	inc hl ; $69ff
	inc hl ; $6a00
	ld b, [hl] ; $6a01
	ld a, a ; $6a02
	ld [$d818], a ; $6a03
	ld a, b ; $6a06
	ld [$d819], a ; $6a07
	ret ; $6a0a
	; $6a0b, 104 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
	dw $003a ; record 8
	dw $0003 ; record 9
	dw $0055 ; record 10
	dw $0003 ; record 11
	dw $0055 ; record 12
	dw $0044 ; record 13
	dw $003a ; record 14
	dw $0044 ; record 15
	dw $0050 ; record 16
	dw $0037 ; record 17
	dw $0054 ; record 18
	dw $0037 ; record 19
	dw $0054 ; record 20
	dw $0028 ; record 21
	dw $0050 ; record 22
	dw $0028 ; record 23
	dw $0100 ; record 24
	dw $0001 ; record 25
	dw $003a ; record 26
	dw $0014 ; record 27
	dw $0064 ; record 28
	dw $0014 ; record 29
	dw $0064 ; record 30
	dw $0044 ; record 31
	dw $003a ; record 32
	dw $0044 ; record 33
	dw $0003 ; record 34
	dw $0201 ; record 35
	dw $0054 ; record 36
	dw $003d ; record 37
	dw $004c ; record 38
	dw $003d ; record 39
	dw $004c ; record 40
	dw $0016 ; record 41
	dw $0054 ; record 42
	dw $0016 ; record 43
	dw $003e ; record 44
	dw $0012 ; record 45
	dw $0052 ; record 46
	dw $0012 ; record 47
	dw $0052 ; record 48
	dw $0042 ; record 49
	dw $003e ; record 50
	dw $0042 ; record 51
DrillBriefing_ReturnLob:
	ld a, $55 ; $6a73
	ld [$d810], a ; $6a75
	ld a, $44 ; $6a78
	ld [$d811], a ; $6a7a
	ld a, $01 ; $6a7d
	ld hl, $46e2 ; $6a7f
	call RegisterFrameTask ; $6a82
	ld a, $3a ; $6a85
	ld [$d812], a ; $6a87
	ld a, $03 ; $6a8a
	ld [$d813], a ; $6a8c
	ld a, $01 ; $6a8f
	ld hl, $470c ; $6a91
	call RegisterFrameTask ; $6a94
	ld a, $56 ; $6a97
	ld [$d81e], a ; $6a99
	ld a, $28 ; $6a9c
	ld [$d81f], a ; $6a9e
	ld a, $01 ; $6aa1
	ld hl, $4736 ; $6aa3
	call RegisterFrameTask ; $6aa6
	ld a, $01 ; $6aa9
	ld [$d827], a ; $6aab
	ld a, $4c ; $6aae
	ld [$d818], a ; $6ab0
	ld a, $16 ; $6ab3
	ld [$d819], a ; $6ab5
	ld a, $01 ; $6ab8
	ld hl, $4876 ; $6aba
	call RegisterFrameTask ; $6abd
	ld hl, $1c06 ; $6ac0
	call DrawBriefingCaption ; $6ac3
	call WaitForInputBlinking ; $6ac6
	call ClearFrameTasks ; $6ac9
	ld a, $01 ; $6acc
	ld hl, $4406 ; $6ace
	call RegisterFrameTask ; $6ad1
	ld a, $03 ; $6ad4
	ld [$d82e], a ; $6ad6
	call ReturnLobBriefing_AdvanceAnim ; $6ad9
	ld a, $01 ; $6adc
	ld hl, $46e2 ; $6ade
	call RegisterFrameTask ; $6ae1
	ld a, $01 ; $6ae4
	ld hl, $470c ; $6ae6
	call RegisterFrameTask ; $6ae9
	ld a, $01 ; $6aec
	ld hl, $4736 ; $6aee
	call RegisterFrameTask ; $6af1
	ld a, $01 ; $6af4
	ld hl, $4754 ; $6af6
	call RegisterFrameTask ; $6af9
	ld a, $01 ; $6afc
	ld hl, $4876 ; $6afe
	call RegisterFrameTask ; $6b01
	ld a, $01 ; $6b04
	ld hl, $478e ; $6b06
	call RegisterFrameTask ; $6b09
	ld a, $0d ; $6b0c
	ld [$d82a], a ; $6b0e
	ld a, $09 ; $6b11
	ld [$d82b], a ; $6b13
	ld a, $01 ; $6b16
	ld hl, $48c1 ; $6b18
	call RegisterFrameTask ; $6b1b
	ld hl, $1c07 ; $6b1e
	call DrawBriefingCaption ; $6b21
	call WaitForInputBlinking ; $6b24
	call ClearFrameTasks ; $6b27
	ld a, $01 ; $6b2a
	ld hl, $4406 ; $6b2c
	call RegisterFrameTask ; $6b2f
	ld a, $03 ; $6b32
	ld [$d82e], a ; $6b34
	call ReturnLobBriefing_AdvanceAnim ; $6b37
	ld a, $01 ; $6b3a
	ld hl, $46e2 ; $6b3c
	call RegisterFrameTask ; $6b3f
	ld a, $01 ; $6b42
	ld hl, $470c ; $6b44
	call RegisterFrameTask ; $6b47
	ld a, $01 ; $6b4a
	ld hl, $4736 ; $6b4c
	call RegisterFrameTask ; $6b4f
	ld a, $01 ; $6b52
	ld hl, $4754 ; $6b54
	call RegisterFrameTask ; $6b57
	ld a, $01 ; $6b5a
	ld hl, $4876 ; $6b5c
	call RegisterFrameTask ; $6b5f
	ld a, $01 ; $6b62
	ld hl, $478e ; $6b64
	call RegisterFrameTask ; $6b67
	ld a, $0d ; $6b6a
	ld [$d82a], a ; $6b6c
	ld a, $09 ; $6b6f
	ld [$d82b], a ; $6b71
	ld a, $01 ; $6b74
	ld hl, $48c1 ; $6b76
	call RegisterFrameTask ; $6b79
	ld hl, $1c08 ; $6b7c
	call DrawBriefingCaption ; $6b7f
	xor a, a ; $6b82
	ld [$d82c], a ; $6b83
	ld [$d82e], a ; $6b86
Label_17_6b89:
	call ReturnLobBriefing_TickAnim ; $6b89
	ld c, $01 ; $6b8c
	call AdvanceFrameCheckInput ; $6b8e
	and a, a ; $6b91
	jp z, Label_17_6b89 ; $6b92
	call ClearFrameTasks ; $6b95
	ret ; $6b98
ReturnLobBriefing_TickAnim:
	ld a, [$d82c] ; $6b99
	inc a ; $6b9c
	ld [$d82c], a ; $6b9d
	cp a, $78 ; $6ba0
	jp nc, ReturnLobBriefing_AdvanceAnim ; $6ba2
	ret ; $6ba5
ReturnLobBriefing_AdvanceAnim:
	xor a, a ; $6ba6
	ld [$d82c], a ; $6ba7
	ld a, [$d82e] ; $6baa
	inc a ; $6bad
	and a, $03 ; $6bae
	ld [$d82e], a ; $6bb0
	sla a ; $6bb3
	sla a ; $6bb5
	ld c, a ; $6bb7
	add a, $6e ; $6bb8
	ld l, a ; $6bba
	adc a, $6c ; $6bbb
	sub a, l ; $6bbd
	ld h, a ; $6bbe
	ld a, [hl] ; $6bbf
	inc hl ; $6bc0
	inc hl ; $6bc1
	ld b, [hl] ; $6bc2
	ld a, a ; $6bc3
	ld [$d810], a ; $6bc4
	ld a, b ; $6bc7
	ld [$d811], a ; $6bc8
	ld a, c ; $6bcb
	add a, $7e ; $6bcc
	ld l, a ; $6bce
	adc a, $6c ; $6bcf
	sub a, l ; $6bd1
	ld h, a ; $6bd2
	ld a, [hl] ; $6bd3
	inc hl ; $6bd4
	inc hl ; $6bd5
	ld b, [hl] ; $6bd6
	ld a, a ; $6bd7
	ld [$d812], a ; $6bd8
	ld a, b ; $6bdb
	ld [$d813], a ; $6bdc
	ld a, c ; $6bdf
	add a, $c6 ; $6be0
	ld l, a ; $6be2
	adc a, $6c ; $6be3
	sub a, l ; $6be5
	ld h, a ; $6be6
	ld a, [hl] ; $6be7
	inc hl ; $6be8
	inc hl ; $6be9
	ld b, [hl] ; $6bea
	ld a, a ; $6beb
	ld [$d828], a ; $6bec
	ld a, b ; $6bef
	ld [$d829], a ; $6bf0
	ld a, c ; $6bf3
	add a, $8e ; $6bf4
	ld l, a ; $6bf6
	adc a, $6c ; $6bf7
	sub a, l ; $6bf9
	ld h, a ; $6bfa
	ld a, [hl] ; $6bfb
	inc hl ; $6bfc
	inc hl ; $6bfd
	ld b, [hl] ; $6bfe
	ld a, a ; $6bff
	ld [$d81e], a ; $6c00
	ld a, b ; $6c03
	ld [$d81f], a ; $6c04
	ld a, [$d82e] ; $6c07
	add a, $9e ; $6c0a
	ld l, a ; $6c0c
	adc a, $6c ; $6c0d
	sub a, l ; $6c0f
	ld h, a ; $6c10
	ld a, [hl] ; $6c11
	ld [$d82d], a ; $6c12
	ld a, c ; $6c15
	add a, $a2 ; $6c16
	ld l, a ; $6c18
	adc a, $6c ; $6c19
	sub a, l ; $6c1b
	ld h, a ; $6c1c
	ld a, [hl] ; $6c1d
	inc hl ; $6c1e
	inc hl ; $6c1f
	ld b, [hl] ; $6c20
	ld a, a ; $6c21
	ld [$d81c], a ; $6c22
	ld a, b ; $6c25
	ld [$d81d], a ; $6c26
	ld a, [$d82e] ; $6c29
	add a, $b2 ; $6c2c
	ld l, a ; $6c2e
	adc a, $6c ; $6c2f
	sub a, l ; $6c31
	ld h, a ; $6c32
	ld a, [hl] ; $6c33
	ld [$d827], a ; $6c34
	ld a, c ; $6c37
	add a, $b6 ; $6c38
	ld l, a ; $6c3a
	adc a, $6c ; $6c3b
	sub a, l ; $6c3d
	ld h, a ; $6c3e
	ld a, [hl] ; $6c3f
	inc hl ; $6c40
	inc hl ; $6c41
	ld b, [hl] ; $6c42
	ld a, a ; $6c43
	ld [$d818], a ; $6c44
	ld a, b ; $6c47
	ld [$d819], a ; $6c48
	ld a, [$d82e] ; $6c4b
	add a, $d6 ; $6c4e
	ld l, a ; $6c50
	adc a, $6c ; $6c51
	sub a, l ; $6c53
	ld h, a ; $6c54
	ld a, [hl] ; $6c55
	ld [$d822], a ; $6c56
	ld a, c ; $6c59
	add a, $da ; $6c5a
	ld l, a ; $6c5c
	adc a, $6c ; $6c5d
	sub a, l ; $6c5f
	ld h, a ; $6c60
	ld a, [hl] ; $6c61
	inc hl ; $6c62
	inc hl ; $6c63
	ld b, [hl] ; $6c64
	ld a, a ; $6c65
	ld [$d814], a ; $6c66
	ld a, b ; $6c69
	ld [$d815], a ; $6c6a
	ret ; $6c6d
	; $6c6e, 124 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
	dw $003a ; record 8
	dw $0003 ; record 9
	dw $0055 ; record 10
	dw $0003 ; record 11
	dw $0055 ; record 12
	dw $0044 ; record 13
	dw $003a ; record 14
	dw $0044 ; record 15
	dw $0050 ; record 16
	dw $0037 ; record 17
	dw $0054 ; record 18
	dw $0037 ; record 19
	dw $0054 ; record 20
	dw $0028 ; record 21
	dw $0050 ; record 22
	dw $0028 ; record 23
	dw $0100 ; record 24
	dw $0001 ; record 25
	dw $003a ; record 26
	dw $0014 ; record 27
	dw $0064 ; record 28
	dw $0014 ; record 29
	dw $0064 ; record 30
	dw $0044 ; record 31
	dw $003a ; record 32
	dw $0044 ; record 33
	dw $0003 ; record 34
	dw $0201 ; record 35
	dw $0054 ; record 36
	dw $003d ; record 37
	dw $004c ; record 38
	dw $003d ; record 39
	dw $004c ; record 40
	dw $0016 ; record 41
	dw $0054 ; record 42
	dw $0016 ; record 43
	dw $003e ; record 44
	dw $0012 ; record 45
	dw $0052 ; record 46
	dw $0012 ; record 47
	dw $0052 ; record 48
	dw $0042 ; record 49
	dw $003e ; record 50
	dw $0042 ; record 51
	dw $0003 ; record 52
	dw $0300 ; record 53
	dw $002f ; record 54
	dw $0044 ; record 55
	dw $0049 ; record 56
	dw $0044 ; record 57
	dw $0049 ; record 58
	dw $0003 ; record 59
	dw $002f ; record 60
	dw $0003 ; record 61
DrillBriefing_ReturnDownLine:
	ld a, $55 ; $6cea
	ld [$d810], a ; $6cec
	ld a, $44 ; $6cef
	ld [$d811], a ; $6cf1
	ld a, $01 ; $6cf4
	ld hl, $46e2 ; $6cf6
	call RegisterFrameTask ; $6cf9
	ld a, $3a ; $6cfc
	ld [$d812], a ; $6cfe
	ld a, $03 ; $6d01
	ld [$d813], a ; $6d03
	ld a, $01 ; $6d06
	ld hl, $470c ; $6d08
	call RegisterFrameTask ; $6d0b
	ld a, $54 ; $6d0e
	ld [$d81e], a ; $6d10
	ld a, $28 ; $6d13
	ld [$d81f], a ; $6d15
	ld a, $01 ; $6d18
	ld hl, $4736 ; $6d1a
	call RegisterFrameTask ; $6d1d
	ld a, $01 ; $6d20
	ld [$d827], a ; $6d22
	ld a, $4c ; $6d25
	ld [$d818], a ; $6d27
	ld a, $16 ; $6d2a
	ld [$d819], a ; $6d2c
	ld a, $01 ; $6d2f
	ld hl, $4876 ; $6d31
	call RegisterFrameTask ; $6d34
	ld hl, $1c09 ; $6d37
	call DrawBriefingCaption ; $6d3a
	call WaitForInputBlinking ; $6d3d
	call ClearFrameTasks ; $6d40
	ld a, $01 ; $6d43
	ld hl, $4406 ; $6d45
	call RegisterFrameTask ; $6d48
	ld a, $03 ; $6d4b
	ld [$d82e], a ; $6d4d
	call ReturnDownLineBriefing_AdvanceAnim ; $6d50
	ld a, $01 ; $6d53
	ld hl, $46e2 ; $6d55
	call RegisterFrameTask ; $6d58
	ld a, $01 ; $6d5b
	ld hl, $470c ; $6d5d
	call RegisterFrameTask ; $6d60
	ld a, $01 ; $6d63
	ld hl, $4736 ; $6d65
	call RegisterFrameTask ; $6d68
	ld a, $01 ; $6d6b
	ld hl, $4754 ; $6d6d
	call RegisterFrameTask ; $6d70
	ld a, $01 ; $6d73
	ld hl, $481c ; $6d75
	call RegisterFrameTask ; $6d78
	ld a, $00 ; $6d7b
	ld [$d82a], a ; $6d7d
	ld a, $09 ; $6d80
	ld [$d82b], a ; $6d82
	ld a, $01 ; $6d85
	ld hl, $48c1 ; $6d87
	call RegisterFrameTask ; $6d8a
	ld hl, $1c0a ; $6d8d
	call DrawBriefingCaption ; $6d90
	call WaitForInputBlinking ; $6d93
	call ClearFrameTasks ; $6d96
	ld a, $01 ; $6d99
	ld hl, $4406 ; $6d9b
	call RegisterFrameTask ; $6d9e
	ld a, $03 ; $6da1
	ld [$d82e], a ; $6da3
	call ReturnDownLineBriefing_AdvanceAnim ; $6da6
	ld a, $01 ; $6da9
	ld hl, $46e2 ; $6dab
	call RegisterFrameTask ; $6dae
	ld a, $01 ; $6db1
	ld hl, $470c ; $6db3
	call RegisterFrameTask ; $6db6
	ld a, $01 ; $6db9
	ld hl, $4736 ; $6dbb
	call RegisterFrameTask ; $6dbe
	ld a, $01 ; $6dc1
	ld hl, $4754 ; $6dc3
	call RegisterFrameTask ; $6dc6
	ld a, $01 ; $6dc9
	ld hl, $481c ; $6dcb
	call RegisterFrameTask ; $6dce
	ld a, $00 ; $6dd1
	ld [$d82a], a ; $6dd3
	ld a, $09 ; $6dd6
	ld [$d82b], a ; $6dd8
	ld a, $01 ; $6ddb
	ld hl, $48c1 ; $6ddd
	call RegisterFrameTask ; $6de0
	ld hl, $1c0b ; $6de3
	call DrawBriefingCaption ; $6de6
	xor a, a ; $6de9
	ld [$d82c], a ; $6dea
	ld [$d82e], a ; $6ded
Label_17_6df0:
	call ReturnDownLineBriefing_TickAnim ; $6df0
	ld c, $01 ; $6df3
	call AdvanceFrameCheckInput ; $6df5
	and a, a ; $6df8
	jp z, Label_17_6df0 ; $6df9
	call ClearFrameTasks ; $6dfc
	ret ; $6dff
ReturnDownLineBriefing_TickAnim:
	ld a, [$d82c] ; $6e00
	inc a ; $6e03
	ld [$d82c], a ; $6e04
	cp a, $78 ; $6e07
	jp nc, ReturnDownLineBriefing_AdvanceAnim ; $6e09
	ret ; $6e0c
ReturnDownLineBriefing_AdvanceAnim:
	xor a, a ; $6e0d
	ld [$d82c], a ; $6e0e
	ld a, [$d82e] ; $6e11
	inc a ; $6e14
	and a, $03 ; $6e15
	ld [$d82e], a ; $6e17
	sla a ; $6e1a
	sla a ; $6e1c
	ld c, a ; $6e1e
	add a, $b3 ; $6e1f
	ld l, a ; $6e21
	adc a, $6e ; $6e22
	sub a, l ; $6e24
	ld h, a ; $6e25
	ld a, [hl] ; $6e26
	inc hl ; $6e27
	inc hl ; $6e28
	ld b, [hl] ; $6e29
	ld a, a ; $6e2a
	ld [$d810], a ; $6e2b
	ld a, b ; $6e2e
	ld [$d811], a ; $6e2f
	ld a, c ; $6e32
	add a, $c3 ; $6e33
	ld l, a ; $6e35
	adc a, $6e ; $6e36
	sub a, l ; $6e38
	ld h, a ; $6e39
	ld a, [hl] ; $6e3a
	inc hl ; $6e3b
	inc hl ; $6e3c
	ld b, [hl] ; $6e3d
	ld a, a ; $6e3e
	ld [$d812], a ; $6e3f
	ld a, b ; $6e42
	ld [$d813], a ; $6e43
	ld a, c ; $6e46
	add a, $0b ; $6e47
	ld l, a ; $6e49
	adc a, $6f ; $6e4a
	sub a, l ; $6e4c
	ld h, a ; $6e4d
	ld a, [hl] ; $6e4e
	inc hl ; $6e4f
	inc hl ; $6e50
	ld b, [hl] ; $6e51
	ld a, a ; $6e52
	ld [$d828], a ; $6e53
	ld a, b ; $6e56
	ld [$d829], a ; $6e57
	ld a, c ; $6e5a
	add a, $d3 ; $6e5b
	ld l, a ; $6e5d
	adc a, $6e ; $6e5e
	sub a, l ; $6e60
	ld h, a ; $6e61
	ld a, [hl] ; $6e62
	inc hl ; $6e63
	inc hl ; $6e64
	ld b, [hl] ; $6e65
	ld a, a ; $6e66
	ld [$d81e], a ; $6e67
	ld a, b ; $6e6a
	ld [$d81f], a ; $6e6b
	ld a, [$d82e] ; $6e6e
	add a, $e3 ; $6e71
	ld l, a ; $6e73
	adc a, $6e ; $6e74
	sub a, l ; $6e76
	ld h, a ; $6e77
	ld a, [hl] ; $6e78
	ld [$d82d], a ; $6e79
	ld a, c ; $6e7c
	add a, $e7 ; $6e7d
	ld l, a ; $6e7f
	adc a, $6e ; $6e80
	sub a, l ; $6e82
	ld h, a ; $6e83
	ld a, [hl] ; $6e84
	inc hl ; $6e85
	inc hl ; $6e86
	ld b, [hl] ; $6e87
	ld a, a ; $6e88
	ld [$d81c], a ; $6e89
	ld a, b ; $6e8c
	ld [$d81d], a ; $6e8d
	ld a, [$d82e] ; $6e90
	add a, $f7 ; $6e93
	ld l, a ; $6e95
	adc a, $6e ; $6e96
	sub a, l ; $6e98
	ld h, a ; $6e99
	ld a, [hl] ; $6e9a
	ld [$d825], a ; $6e9b
	ld a, c ; $6e9e
	add a, $fb ; $6e9f
	ld l, a ; $6ea1
	adc a, $6e ; $6ea2
	sub a, l ; $6ea4
	ld h, a ; $6ea5
	ld a, [hl] ; $6ea6
	inc hl ; $6ea7
	inc hl ; $6ea8
	ld b, [hl] ; $6ea9
	ld a, a ; $6eaa
	ld [$d823], a ; $6eab
	ld a, b ; $6eae
	ld [$d824], a ; $6eaf
	ret ; $6eb2
	; $6eb3, 104 bytes (records:2)
	dw $0055 ; record 0
	dw $0044 ; record 1
	dw $003a ; record 2
	dw $0044 ; record 3
	dw $003a ; record 4
	dw $0003 ; record 5
	dw $0055 ; record 6
	dw $0003 ; record 7
	dw $003a ; record 8
	dw $0003 ; record 9
	dw $0055 ; record 10
	dw $0003 ; record 11
	dw $0055 ; record 12
	dw $0044 ; record 13
	dw $003a ; record 14
	dw $0044 ; record 15
	dw $0061 ; record 16
	dw $002f ; record 17
	dw $0043 ; record 18
	dw $002f ; record 19
	dw $0043 ; record 20
	dw $002c ; record 21
	dw $0061 ; record 22
	dw $002c ; record 23
	dw $0001 ; record 24
	dw $0100 ; record 25
	dw $0064 ; record 26
	dw $0014 ; record 27
	dw $003a ; record 28
	dw $0014 ; record 29
	dw $003a ; record 30
	dw $0044 ; record 31
	dw $0064 ; record 32
	dw $0044 ; record 33
	dw $0000 ; record 34
	dw $0101 ; record 35
	dw $005f ; record 36
	dw $0034 ; record 37
	dw $0042 ; record 38
	dw $0034 ; record 39
	dw $0042 ; record 40
	dw $001c ; record 41
	dw $005f ; record 42
	dw $001c ; record 43
	dw $005d ; record 44
	dw $0012 ; record 45
	dw $003e ; record 46
	dw $0012 ; record 47
	dw $003e ; record 48
	dw $0042 ; record 49
	dw $005d ; record 50
	dw $0042 ; record 51
ShowRulesScreen:
	push af ; $6f1b
	wram_bank $03 ; $6f1c
	pop af ; $6f22
	ld [$dc01], a ; $6f23
	ld a, [wMinigameLevel] ; $6f26
	ld [$dc06], a ; $6f29
	xor a, a ; $6f2c
	ld [$dc02], a ; $6f2d
	ld [$dc03], a ; $6f30
	ld [$dc04], a ; $6f33
	ld [$dc05], a ; $6f36
	ld [$dc00], a ; $6f39
	ld c, $20 ; $6f3c
	call BeginFadeOut ; $6f3e
	call WaitFadeEnd ; $6f41
	call DisableLCDSafely ; $6f44
	call LoadRulesScreen ; $6f47
	ld a, $01 ; $6f4a
	ld [$cb0b], a ; $6f4c
	ld a, $03 ; $6f4f
	ld [$cb0c], a ; $6f51
	ld a, $01 ; $6f54
	ld hl, $4406 ; $6f56
	call RegisterFrameTask ; $6f59
	call EnableLCD ; $6f5c
	ld c, $20 ; $6f5f
	call BeginFadeIn ; $6f61
	call WaitFadeEnd ; $6f64
	wram_bank $03 ; $6f67
	ld a, $01 ; $6f6d
	ld hl, $7420 ; $6f6f
	call RegisterFrameTask ; $6f72
	ld a, $01 ; $6f75
	ld [$dc03], a ; $6f77
	xor a, a ; $6f7a
	ld [$dc04], a ; $6f7b
	call RunMinigameRulesPages ; $6f7e
	ld c, $20 ; $6f81
	call BeginFadeOut ; $6f83
	call WaitFadeEnd ; $6f86
	call ClearFrameTasks ; $6f89
	ld a, [$dc02] ; $6f8c
	ret ; $6f8f
	ret ; $6f90
RunMinigameRulesPages:
	ldh a, [hWramBank] ; $6f91
	push af ; $6f93
	wram_bank $03 ; $6f94
	ld a, [$cb20] ; $6f9a
	inc a ; $6f9d
	inc a ; $6f9e
	farcall FarPtr_03_2c ; $6f9f
	wram_bank $07 ; $6fa2
	ld hl, $de00 ; $6fa8
	ld a, [hl+] ; $6fab
	ld h, [hl] ; $6fac
	ld l, a ; $6fad
	wram_bank $03 ; $6fae
	farcall FarPtr_PushTextArgNumber ; $6fb4
	ld a, [$cb20] ; $6fb7
	ld hl, $6fdb ; $6fba
	add a, a ; $6fbd
	add a, l ; $6fbe
	ld l, a ; $6fbf
	jr nc, Label_17_6fc3 ; $6fc0
	inc h ; $6fc2
Label_17_6fc3:
	ld a, [hl+] ; $6fc3
	ld d, [hl] ; $6fc4
	ld e, a ; $6fc5
	ld hl, $cb6e ; $6fc6
	ld a, e ; $6fc9
	ld [hl+], a ; $6fca
	ld [hl], d ; $6fcb
	ld hl, $6fed ; $6fcc
	ld a, [$dc01] ; $6fcf
	call MinigameRulesPageLoop ; $6fd2
	pop af ; $6fd5
	wram_bank ; $6fd6
	ret ; $6fda
	add a, $2c ; $6fdb
	ret nc ; $6fdd
	inc l ; $6fde
	jp c, $e22c ; $6fdf
	inc l ; $6fe2
	rst Rst28 ; $6fe3
	inc l ; $6fe4
	or a, $2c ; $6fe5
	rlca ; $6fe7
	jr nc, Label_17_7001 ; $6fe8
	jr nc, Label_17_7012 ; $6fea
	jr nc, Label_17_6fee ; $6fec
Label_17_6fee:
	ld bc, rSC ; $6fee
	rst Rst38 ; $6ff1
	rst Rst38 ; $6ff2
	inc bc ; $6ff3
	inc b ; $6ff4
	dec b ; $6ff5
	rst Rst38 ; $6ff6
	rst Rst38 ; $6ff7
	rst Rst38 ; $6ff8
	ld b, $07 ; $6ff9
	adc a, b ; $6ffb
	rst Rst38 ; $6ffc
	rst Rst38 ; $6ffd
	rst Rst38 ; $6ffe
	nop ; $6fff
	db $01 ; $7000
Label_17_7001:
	ld [bc], a ; $7001
	rst Rst38 ; $7002
	rst Rst38 ; $7003
	rst Rst38 ; $7004
	inc bc ; $7005
	inc b ; $7006
	dec b ; $7007
	rst Rst38 ; $7008
	rst Rst38 ; $7009
	rst Rst38 ; $700a
	ld b, $07 ; $700b
	adc a, b ; $700d
	rst Rst38 ; $700e
	rst Rst38 ; $700f
	rst Rst38 ; $7010
	nop ; $7011
Label_17_7012:
	ld bc, rIE ; $7012
	rst Rst38 ; $7015
	rst Rst38 ; $7016
	ld [bc], a ; $7017
	inc bc ; $7018
	rst Rst38 ; $7019
	rst Rst38 ; $701a
	rst Rst38 ; $701b
	rst Rst38 ; $701c
	inc b ; $701d
	dec b ; $701e
	add a, [hl] ; $701f
	rst Rst38 ; $7020
	rst Rst38 ; $7021
	rst Rst38 ; $7022
	nop ; $7023
	ld bc, $0302 ; $7024
	rst Rst38 ; $7027
	rst Rst38 ; $7028
	inc b ; $7029
	dec b ; $702a
	ld b, $07 ; $702b
	rst Rst38 ; $702d
	rst Rst38 ; $702e
	ld [$0a09], sp ; $702f
	adc a, e ; $7032
	rst Rst38 ; $7033
	rst Rst38 ; $7034
	nop ; $7035
	ld bc, rIE ; $7036
	rst Rst38 ; $7039
	rst Rst38 ; $703a
	ld [bc], a ; $703b
	inc bc ; $703c
	rst Rst38 ; $703d
	rst Rst38 ; $703e
	rst Rst38 ; $703f
	rst Rst38 ; $7040
	inc b ; $7041
	add a, l ; $7042
	rst Rst38 ; $7043
	rst Rst38 ; $7044
	rst Rst38 ; $7045
	rst Rst38 ; $7046
	nop ; $7047
	ld bc, rSC ; $7048
	rst Rst38 ; $704b
	rst Rst38 ; $704c
	inc bc ; $704d
	inc b ; $704e
	dec b ; $704f
	rst Rst38 ; $7050
	rst Rst38 ; $7051
	rst Rst38 ; $7052
	ld b, $07 ; $7053
	adc a, b ; $7055
	rst Rst38 ; $7056
	rst Rst38 ; $7057
	rst Rst38 ; $7058
	nop ; $7059
	ld bc, $0302 ; $705a
	inc b ; $705d
	rst Rst38 ; $705e
	dec b ; $705f
	ld b, $07 ; $7060
	ld [$ff09], sp ; $7062
	ld a, [bc] ; $7065
	dec bc ; $7066
	inc c ; $7067
	dec c ; $7068
	adc a, [hl] ; $7069
	rst Rst38 ; $706a
	nop ; $706b
	ld bc, $0302 ; $706c
	inc b ; $706f
	rst Rst38 ; $7070
	dec b ; $7071
	ld b, $07 ; $7072
	ld [$ff09], sp ; $7074
	ld a, [bc] ; $7077
	dec bc ; $7078
	inc c ; $7079
	adc a, l ; $707a
	rst Rst38 ; $707b
	rst Rst38 ; $707c
	nop ; $707d
	ld bc, $0302 ; $707e
	rst Rst38 ; $7081
	rst Rst38 ; $7082
	inc b ; $7083
	dec b ; $7084
	ld b, $07 ; $7085
	rst Rst38 ; $7087
	rst Rst38 ; $7088
	ld [$0a09], sp ; $7089
	dec bc ; $708c
	rst Rst38 ; $708d
	rst Rst38 ; $708e
	dec de ; $708f
	rst Rst38 ; $7090
	rst Rst38 ; $7091
	rst Rst38 ; $7092
	rst Rst38 ; $7093
	rst Rst38 ; $7094
	inc e ; $7095
	rst Rst38 ; $7096
	rst Rst38 ; $7097
	rst Rst38 ; $7098
	rst Rst38 ; $7099
	rst Rst38 ; $709a
MinigameRulesPageLoop:
	add a, a ; $709b
	ld b, a ; $709c
	add a, a ; $709d
	add a, b ; $709e
	add a, l ; $709f
	ld l, a ; $70a0
	jr nc, Label_17_70a4 ; $70a1
	inc h ; $70a3
Label_17_70a4:
	ld a, [hl+] ; $70a4
	cp a, $ff ; $70a5
	jp z, Label_17_7150 ; $70a7
	push hl ; $70aa
	bit 7, a ; $70ab
	jr z, Label_17_70d3 ; $70ad
	push af ; $70af
	ld d, a ; $70b0
	wram_bank $07 ; $70b1
	ld hl, $de00 ; $70b7
	ld a, [hl+] ; $70ba
	ld h, [hl] ; $70bb
	ld l, a ; $70bc
	wram_bank $03 ; $70bd
	ld a, h ; $70c3
	cp a, $27 ; $70c4
	jr nz, Label_17_70d2 ; $70c6
	ld a, l ; $70c8
	cp a, $0f ; $70c9
	jr nz, Label_17_70d2 ; $70cb
	pop bc ; $70cd
	ld a, d ; $70ce
	inc a ; $70cf
	jr Label_17_70d3 ; $70d0
Label_17_70d2:
	pop af ; $70d2
Label_17_70d3:
	and a, $7f ; $70d3
	pop hl ; $70d5
	push hl ; $70d6
	push af ; $70d7
	ld a, [hl] ; $70d8
	cp a, $ff ; $70d9
	jr z, Label_17_70e5 ; $70db
	ld a, $01 ; $70dd
	ld hl, $755e ; $70df
	call RegisterFrameTask ; $70e2
Label_17_70e5:
	call PrepareRulesPageTilemap ; $70e5
	ld hl, $cb6e ; $70e8
	ld a, [hl+] ; $70eb
	ld h, [hl] ; $70ec
	ld l, a ; $70ed
	pop af ; $70ee
	add a, l ; $70ef
	ld l, a ; $70f0
	jr nc, Label_17_70f4 ; $70f1
	inc h ; $70f3
Label_17_70f4:
	ld de, $d082 ; $70f4
	ld c, $20 ; $70f7
	farcall FarPtr_PrepareGlyphBuffer ; $70f9
	ld c, $10 ; $70fc
	farcall FarPtr_RenderProportionalTextAt ; $70fe
	farcall FarPtr_UploadGlyphBuffer ; $7101
	call QueueRulesPageToVRAM ; $7104
Label_17_7107:
	call AdvanceFrame ; $7107
	ldh a, [hInputRisingEdge] ; $710a
	bit 0, a ; $710c
	jr nz, Label_17_711e ; $710e
	bit 7, a ; $7110
	jr nz, Label_17_711e ; $7112
	bit 1, a ; $7114
	jr nz, Label_17_713c ; $7116
	bit 3, a ; $7118
	jr nz, Label_17_7153 ; $711a
	jr Label_17_7107 ; $711c
Label_17_711e:
	sound $5f ; $711e
	ld hl, $755e ; $7120
	call UnregisterFrameTask ; $7123
	ld hl, RulesScreenTiles ; $7126
	call UnregisterFrameTask ; $7129
	ld a, $01 ; $712c
	ld [$dc03], a ; $712e
	ld [$dc05], a ; $7131
	xor a, a ; $7134
	ld [$dc04], a ; $7135
	pop hl ; $7138
	jp Label_17_70a4 ; $7139
Label_17_713c:
	sound $62 ; $713c
	ld hl, $755e ; $713e
	call UnregisterFrameTask ; $7141
	ld hl, RulesScreenTiles ; $7144
	call UnregisterFrameTask ; $7147
	ld a, $ff ; $714a
	ld [$dc02], a ; $714c
	pop hl ; $714f
Label_17_7150:
	sound $60 ; $7150
	ret ; $7152
Label_17_7153:
	pop hl ; $7153
	sound $60 ; $7154
	ret ; $7156
LoadRulesScreen:
	call LoadRulesBorderAnimTiles ; $7157
	farcall FarPtr_01_0a ; $715a
	ld c, $44 ; $715d
	farcall FarPtr_LoadScreenAssetRecord ; $715f
	ldh a, [hWramBank] ; $7162
	push af ; $7164
	farcall FarPtr_InitTextWindows ; $7165
	wram_bank $05 ; $7168
	ld a, $03 ; $716e
	ld [$c3b3], a ; $7170
	ld a, $00 ; $7173
	ld [$c3b6], a ; $7175
	pop af ; $7178
	wram_bank ; $7179
	farcall FarPtr_PrepareGlyphBuffer ; $717d
	call ClearRulesScreenTextArea ; $7180
	ld hl, $7b39 ; $7183
	ld de, $0902 ; $7186
	call LoadPalettesImmediate ; $7189
	ld de, $a000 ; $718c
	farcall FarPtr_39_18 ; $718f
	ld b, $08 ; $7192
	ld c, $0f ; $7194
	farcall FarPtr_LoadIndexedPalette ; $7196
	ld b, $11 ; $7199
	ld c, $10 ; $719b
	ld de, $9000 ; $719d
	farcall FarPtr_39_10 ; $71a0
	ld a, $03 ; $71a3
	ld [$c3b3], a ; $71a5
	ld hl, $c3b4 ; $71a8
	ld de, $d000 ; $71ab
	ld a, e ; $71ae
	ld [hl+], a ; $71af
	ld [hl], d ; $71b0
	ld a, $01 ; $71b1
	ld hl, $74db ; $71b3
	call RegisterFrameTask ; $71b6
	farcall FarPtr_QueueWram3MapToVRAM ; $71b9
	ret ; $71bc
ClearRulesScreenTextArea:
	ldh a, [hWramBank] ; $71bd
	push af ; $71bf
	wram_bank $03 ; $71c0
	ld de, $d462 ; $71c6
	ld b, $10 ; $71c9
	ld c, $0e ; $71cb
	ld h, $00 ; $71cd
	farcall FarPtr_FillTilemapRect ; $71cf
	call ClearRulesPageRows ; $71d2
	pop af ; $71d5
	wram_bank ; $71d6
	ret ; $71da
ClearRulesPageRows:
	ldh a, [hWramBank] ; $71db
	push af ; $71dd
	wram_bank $03 ; $71de
	ld de, $d062 ; $71e4
	ld b, $10 ; $71e7
	ld c, $01 ; $71e9
	ld h, $03 ; $71eb
	farcall FarPtr_FillTilemapRect ; $71ed
	ld de, $d082 ; $71f0
	ld b, $10 ; $71f3
	ld c, $0d ; $71f5
	ld h, $20 ; $71f7
	farcall FarPtr_FillTilemapRect ; $71f9
	pop af ; $71fc
	wram_bank ; $71fd
	ret ; $7201
PrepareRulesPageTilemap:
	ldh a, [hWramBank] ; $7202
	push af ; $7204
	wram_bank $03 ; $7205
	ld de, $d062 ; $720b
	ld b, $10 ; $720e
	ld c, $01 ; $7210
	ld h, $03 ; $7212
	farcall FarPtr_FillTilemapRect ; $7214
	ld de, $d082 ; $7217
	ld b, $10 ; $721a
	ld c, $0d ; $721c
	ld h, $20 ; $721e
	farcall FarPtr_FillTilemapRect ; $7220
	ld a, [$dc05] ; $7223
	or a, a ; $7226
	jr nz, Label_17_723b ; $7227
	ld a, [$dc06] ; $7229
	add a, $03 ; $722c
	ld h, a ; $722e
	ld de, $d482 ; $722f
	ld b, $10 ; $7232
	ld c, $01 ; $7234
	farcall FarPtr_FillTilemapRect ; $7236
	jr Label_17_7247 ; $7239
Label_17_723b:
	ld de, $d482 ; $723b
	ld b, $10 ; $723e
	ld c, $01 ; $7240
	ld h, $00 ; $7242
	farcall FarPtr_FillTilemapRect ; $7244
Label_17_7247:
	pop af ; $7247
	wram_bank ; $7248
	ret ; $724c
QueueRulesPageToVRAM:
	ld a, [$dc05] ; $724d
	or a, a ; $7250
	jr nz, Label_17_7260 ; $7251
	ld hl, $d080 ; $7253
	ld de, $9880 ; $7256
	ld c, $0a ; $7259
	call QueueVRAMCopy ; $725b
	jr Label_17_726b ; $725e
Label_17_7260:
	ld hl, $d060 ; $7260
	ld de, $9860 ; $7263
	ld c, $0a ; $7266
	call QueueVRAMCopy ; $7268
Label_17_726b:
	ld hl, $d480 ; $726b
	ld de, $b880 ; $726e
	ld c, $02 ; $7271
	call QueueVRAMCopy ; $7273
	call AdvanceFrame ; $7276
	ld hl, $d100 ; $7279
	ld de, $9900 ; $727c
	ld c, $0a ; $727f
	call QueueVRAMCopy ; $7281
	call AdvanceFrame ; $7284
	ld hl, $d1a0 ; $7287
	ld de, $99a0 ; $728a
	ld c, $08 ; $728d
	call QueueVRAMCopy ; $728f
	ret ; $7292
LoadRulesBorderAnimTiles:
	wram_bank $01 ; $7293
	ld hl, $793c ; $7299
	ld de, $d000 ; $729c
	call DecompressData ; $729f
	ld hl, $d000 ; $72a2
	ld de, $8000 ; $72a5
	ld bc, $0012 ; $72a8
	call QueueVRAMCopy ; $72ab
	ld hl, $d000 ; $72ae
	ld de, $8240 ; $72b1
	ld bc, $0012 ; $72b4
	call QueueVRAMCopy ; $72b7
	ld hl, $d000 ; $72ba
	ld de, $8480 ; $72bd
	ld bc, $0012 ; $72c0
	call QueueVRAMCopy ; $72c3
	ld hl, $d000 ; $72c6
	ld de, $a100 ; $72c9
	ld bc, $0012 ; $72cc
	call QueueVRAMCopy ; $72cf
	ld hl, $d000 ; $72d2
	ld de, $a340 ; $72d5
	ld bc, $0012 ; $72d8
	call QueueVRAMCopy ; $72db
	ld hl, $d000 ; $72de
	ld de, $a580 ; $72e1
	ld bc, $0012 ; $72e4
	call QueueVRAMCopy ; $72e7
	ld hl, $7a08 ; $72ea
	ld de, $d000 ; $72ed
	call DecompressData ; $72f0
	ld hl, $d000 ; $72f3
	ld de, $84a0 ; $72f6
	ld bc, $0002 ; $72f9
	call QueueVRAMCopy ; $72fc
	ld hl, $d000 ; $72ff
	ld de, $a120 ; $7302
	ld bc, $0002 ; $7305
	call QueueVRAMCopy ; $7308
	ld hl, $d000 ; $730b
	ld de, $a360 ; $730e
	ld bc, $0002 ; $7311
	call QueueVRAMCopy ; $7314
	ld hl, $d000 ; $7317
	ld de, $a5a0 ; $731a
	ld bc, $0002 ; $731d
	call QueueVRAMCopy ; $7320
	ld hl, $7a2f ; $7323
	ld de, $d000 ; $7326
	call DecompressData ; $7329
	ld hl, $d020 ; $732c
	ld de, $82c0 ; $732f
	ld bc, $0001 ; $7332
	call QueueVRAMCopy ; $7335
	ld hl, $d020 ; $7338
	ld de, $a180 ; $733b
	ld bc, $0001 ; $733e
	call QueueVRAMCopy ; $7341
	ld hl, $d000 ; $7344
	ld de, $a3c0 ; $7347
	ld bc, $0001 ; $734a
	call QueueVRAMCopy ; $734d
	ld hl, $d040 ; $7350
	ld de, $a600 ; $7353
	ld bc, $0001 ; $7356
	call QueueVRAMCopy ; $7359
	ld hl, $7a56 ; $735c
	ld de, $d000 ; $735f
	call DecompressData ; $7362
	ld hl, $d000 ; $7365
	ld de, $8120 ; $7368
	ld bc, $0012 ; $736b
	call QueueVRAMCopy ; $736e
	ld hl, $d000 ; $7371
	ld de, $8360 ; $7374
	ld bc, $0012 ; $7377
	call QueueVRAMCopy ; $737a
	ld hl, $d000 ; $737d
	ld de, $85a0 ; $7380
	ld bc, $0012 ; $7383
	call QueueVRAMCopy ; $7386
	ld hl, $d000 ; $7389
	ld de, $a220 ; $738c
	ld bc, $0012 ; $738f
	call QueueVRAMCopy ; $7392
	ld hl, $d000 ; $7395
	ld de, $a460 ; $7398
	ld bc, $0012 ; $739b
	call QueueVRAMCopy ; $739e
	ld hl, $d000 ; $73a1
	ld de, $a6a0 ; $73a4
	ld bc, $0012 ; $73a7
	call QueueVRAMCopy ; $73aa
	ld hl, $7af8 ; $73ad
	ld de, $d000 ; $73b0
	call DecompressData ; $73b3
	ld hl, $d000 ; $73b6
	ld de, $85c0 ; $73b9
	ld bc, $0002 ; $73bc
	call QueueVRAMCopy ; $73bf
	ld hl, $d000 ; $73c2
	ld de, $a240 ; $73c5
	ld bc, $0002 ; $73c8
	call QueueVRAMCopy ; $73cb
	ld hl, $d000 ; $73ce
	ld de, $a480 ; $73d1
	ld bc, $0002 ; $73d4
	call QueueVRAMCopy ; $73d7
	ld hl, $d000 ; $73da
	ld de, $a6c0 ; $73dd
	ld bc, $0002 ; $73e0
	call QueueVRAMCopy ; $73e3
	ld hl, $7b18 ; $73e6
	ld de, $d000 ; $73e9
	call DecompressData ; $73ec
	ld hl, $d020 ; $73ef
	ld de, $83e0 ; $73f2
	ld bc, $0001 ; $73f5
	call QueueVRAMCopy ; $73f8
	ld hl, $d020 ; $73fb
	ld de, $a2a0 ; $73fe
	ld bc, $0001 ; $7401
	call QueueVRAMCopy ; $7404
	ld hl, $d000 ; $7407
	ld de, $a4e0 ; $740a
	ld bc, $0001 ; $740d
	call QueueVRAMCopy ; $7410
	ld hl, $d040 ; $7413
	ld de, $a720 ; $7416
	ld bc, $0001 ; $7419
	call QueueVRAMCopy ; $741c
	ret ; $741f
	ldh a, [hWramBank] ; $7420
	push af ; $7422
	wram_bank $03 ; $7423
	ld a, [$dc04] ; $7429
	inc a ; $742c
	ld [$dc04], a ; $742d
	ld a, [$dc03] ; $7430
	or a, a ; $7433
	jr z, Label_17_744e ; $7434
	ldh a, [hVBlankCounter] ; $7436
	srl a ; $7438
	srl a ; $743a
	srl a ; $743c
	and a, $3f ; $743e
	ld hl, $749f ; $7440
	add a, l ; $7443
	ld l, a ; $7444
	jr nc, Label_17_7448 ; $7445
	inc h ; $7447
Label_17_7448:
	ld a, [hl] ; $7448
	ld [$dc00], a ; $7449
	jr Label_17_7468 ; $744c
Label_17_744e:
	ldh a, [hVBlankCounter] ; $744e
	srl a ; $7450
	srl a ; $7452
	srl a ; $7454
	srl a ; $7456
	and a, $1f ; $7458
	ld hl, $747f ; $745a
	add a, l ; $745d
	ld l, a ; $745e
	jr nc, Label_17_7462 ; $745f
	inc h ; $7461
Label_17_7462:
	ld a, [hl] ; $7462
	ld [$dc00], a ; $7463
	jr Label_17_7468 ; $7466
Label_17_7468:
	ld a, [$dc03] ; $7468
	or a, a ; $746b
	jr z, Label_17_7479 ; $746c
	ld a, [$dc04] ; $746e
	cp a, $ff ; $7471
	jr nz, Label_17_7479 ; $7473
	xor a, a ; $7475
	ld [$dc03], a ; $7476
Label_17_7479:
	pop af ; $7479
	wram_bank ; $747a
	ret ; $747e
	; $747f, 92 bytes (records:2)
	dw $0100 ; record 0
	dw $0000 ; record 1
	dw $0000 ; record 2
	dw $0000 ; record 3
	dw $0001 ; record 4
	dw $0000 ; record 5
	dw $0000 ; record 6
	dw $0100 ; record 7
	dw $0000 ; record 8
	dw $0000 ; record 9
	dw $0000 ; record 10
	dw $0001 ; record 11
	dw $0100 ; record 12
	dw $0000 ; record 13
	dw $0001 ; record 14
	dw $0000 ; record 15
	dw $0402 ; record 16
	dw $0404 ; record 17
	dw $0502 ; record 18
	dw $0402 ; record 19
	dw $0202 ; record 20
	dw $0302 ; record 21
	dw $0402 ; record 22
	dw $0402 ; record 23
	dw $0304 ; record 24
	dw $0204 ; record 25
	dw $0204 ; record 26
	dw $0404 ; record 27
	dw $0402 ; record 28
	dw $0402 ; record 29
	dw $0402 ; record 30
	dw $0402 ; record 31
	dw $0402 ; record 32
	dw $0402 ; record 33
	dw $0402 ; record 34
	dw $0202 ; record 35
	dw $0304 ; record 36
	dw $0204 ; record 37
	dw $0204 ; record 38
	dw $0204 ; record 39
	dw $0402 ; record 40
	dw $0402 ; record 41
	dw $0402 ; record 42
	dw $0202 ; record 43
	dw $0302 ; record 44
	dw $0402 ; record 45
	ldh a, [hWramBank] ; $74db
	push af ; $74dd
	wram_bank $03 ; $74de
	ld a, [$dc00] ; $74e4
	ld hl, $754c ; $74e7
	add a, l ; $74ea
	ld l, a ; $74eb
	jr nc, Label_17_74ef ; $74ec
	inc h ; $74ee
Label_17_74ef:
	ld a, [hl] ; $74ef
	ld c, a ; $74f0
	push bc ; $74f1
	ld a, [$dc00] ; $74f2
	ld hl, $7552 ; $74f5
	add a, l ; $74f8
	ld l, a ; $74f9
	jr nc, Label_17_74fd ; $74fa
	inc h ; $74fc
Label_17_74fd:
	ld b, [hl] ; $74fd
	ld de, $7e68 ; $74fe
	ld hl, $7527 ; $7501
	call QueueSpriteTemplate ; $7504
	pop bc ; $7507
	ld a, $12 ; $7508
	add a, c ; $750a
	ld c, a ; $750b
	ld a, [$dc00] ; $750c
	ld hl, $7558 ; $750f
	add a, l ; $7512
	ld l, a ; $7513
	jr nc, Label_17_7517 ; $7514
	inc h ; $7516
Label_17_7517:
	ld b, [hl] ; $7517
	ld de, $7e68 ; $7518
	ld hl, $7527 ; $751b
	call QueueSpriteTemplate ; $751e
	pop af ; $7521
	wram_bank ; $7522
	ret ; $7526
	; $7527, 55 bytes (bytes:4)
	db $10, $08, $00, $00 ; 0x00
	db $20, $08, $02, $00 ; 0x04
	db $30, $08, $04, $00 ; 0x08
	db $10, $10, $06, $00 ; 0x0c
	db $20, $10, $08, $00 ; 0x10
	db $30, $10, $0a, $00 ; 0x14
	db $10, $18, $0c, $00 ; 0x18
	db $20, $18, $0e, $00 ; 0x1c
	db $30, $18, $10, $00 ; 0x20
	db $80, $00, $24, $48 ; 0x24
	db $10, $34, $58, $01 ; 0x28
	db $01, $01, $09, $09 ; 0x2c
	db $09, $02, $02, $02 ; 0x30
	db $0a, $0a, $0a ; 0x34
	ld de, $7888 ; $755e
	ld c, $00 ; $7561
	call ApplySpriteWobbleY_17 ; $7563
	ld b, $08 ; $7566
	ld c, $00 ; $7568
	ld h, $03 ; $756a
	farcall FarPtr_39_1a ; $756c
	ret ; $756f
RulesScreenTiles:
	INCBIN "data/bank_017/lz_7570.bin" ; $7570, 512 bytes
RulesScreenTilemap:
	INCBIN "data/bank_017/lz_7770.bin" ; $7770, 309 bytes
RulesScreenAttrmap:
	INCBIN "data/bank_017/lz_78a5.bin" ; $78a5, 87 bytes
RulesScreenPalettes:
	; $78fc, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $1cc4, $015f, $0000, $7fff ; pal 0: #203139 #ff5200 #000000 #ffffff
	dw $0300, $0240, $0180, $0100 ; pal 1: #00c500 #009400 #006200 #004100
	dw $03e0, $3316, $1e4c, $2508 ; pal 2: #00ff00 #b4c562 #629439 #41414a
	dw $5334, $015f, $0000, $1b06 ; pal 3: #a4cda4 #ff5200 #000000 #31c531
	dw $5299, $015f, $0000, $141f ; pal 4: #cda4a4 #ff5200 #000000 #ff0029
	dw $5eb7, $015f, $0000, $7d59 ; pal 5: #bdacbd #ff5200 #000000 #cd52ff
	dw $2508, $2508, $2508, $2508 ; pal 6: #41414a #41414a #41414a #41414a
	dw $2508, $2508, $2508, $2508 ; pal 7: #41414a #41414a #41414a #41414a
	INCBIN "data/bank_017/d_793c.bin" ; $793c, 573 bytes
	ds 1159, $ff ; $7b79, fill
