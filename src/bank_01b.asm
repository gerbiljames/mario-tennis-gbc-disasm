SECTION "ROM Bank $1b", ROMX[$4000], BANK[$1b]

FarPtr_DecompressCharMugshot:
	dw DecompressCharMugshot ; $4000
FarPtr_LoadIndexedPaletteThunk:
	dw LoadIndexedPaletteThunk ; $4002
FarPtr_1b_04:
	dw Func_1b_4e7f ; $4004
FarPtr_Func_1b_4e80:
	dw Func_1b_4e80 ; $4006
FarPtr_Func_1b_4e80Alias1:
	dw Func_1b_4e80 ; $4008
FarPtr_1b_0a:
	dw Func_1b_4e57 ; $400a
FarPtr_1b_0c:
	dw Func_1b_4e0d ; $400c
FarPtr_SetMugshotAttrs:
	dw SetMugshotAttrs ; $400e
FarPtr_LoadCharMugshotToBuffer:
	dw LoadCharMugshotToBuffer ; $4010
FarPtr_1b_12:
	dw Func_1b_4e43 ; $4012
FarPtr_1b_14:
	dw Func_1b_4e44 ; $4014
FarPtr_1b_16:
	dw Func_1b_4e45 ; $4016
FarPtr_CopyMugshotBufferToVram:
	dw CopyMugshotBufferToVram ; $4018
FarPtr_ShowRankingBoard:
	dw ShowRankingBoard ; $401a
FarPtr_UpdateCharSelectSelection:
	dw UpdateCharSelectSelection ; $401c
FarPtr_1b_1e:
	dw Func_1b_6982 ; $401e
FarPtr_ShowNoN64DataFoundScreen:
	dw ShowNoN64DataFoundScreen ; $4020
FarPtr_RunNewGameSetup:
	dw RunNewGameSetup ; $4022
FarPtr_RunDebugSaveDataFlow:
	dw RunDebugSaveDataFlow ; $4024
FarPtr_RunMinigameFlagsDebugScreen:
	dw RunMinigameFlagsDebugScreen ; $4026
FarPtr_RunMinigameLevelSelect:
	dw RunMinigameLevelSelect ; $4028
FarPtr_RunSavedDataTypeSelect:
	dw RunSavedDataTypeSelect ; $402a
FarPtr_ShowMinigameDataScreen:
	dw ShowMinigameDataScreen ; $402c
	; $402e, 159 bytes (records:2)
	dw $78bd ; record 0
	dw $7970 ; record 1
	dw $79c0 ; record 2
	dw $7a78 ; record 3
	dw $7ab5 ; record 4
	dw $7af6 ; record 5
	dw $7b37 ; record 6
	dw $7d2e ; record 7
	dw $7e6f ; record 8
	dw $c5d5 ; record 9
	dw $000e ; record 10
	dw $a3cd ; record 11
	dw $0e40 ; record 12
	dw $cd00 ; record 13
	dw ApplyArrowBobOffset ; record 14
	dw $000e ; record 15
	dw $0806 ; record 16
	dw $51cd ; record 17
	dw $c11f ; record 18
	dw $d5d1 ; record 19
	dw $78c5 ; record 20
	dw $5782 ; record 21
	dw $0ed5 ; record 22
	dw $cd01 ; record 23
	dw $40a3 ; record 24
	dw $000e ; record 25
	dw $cdcd ; record 26
	dw $0e40 ; record 27
	dw $0600 ; record 28
	dw $cd28 ; record 29
	dw $1f51 ; record 30
	dw $c1d1 ; record 31
	dw $d5d1 ; record 32
	dw $79c5 ; record 33
	dw $5f83 ; record 34
	dw $8278 ; record 35
	dw $d557 ; record 36
	dw $010e ; record 37
	dw $a3cd ; record 38
	dw $0e40 ; record 39
	dw $cd01 ; record 40
	dw ApplyArrowBobOffset ; record 41
	dw $000e ; record 42
	dw $6806 ; record 43
	dw $51cd ; record 44
	dw $d11f ; record 45
	dw $d1c1 ; record 46
	dw $817b ; record 47
	dw $d55f ; record 48
	dw $000e ; record 49
	dw $a3cd ; record 50
	dw $0e40 ; record 51
	dw $cd01 ; record 52
	dw ApplyArrowBobOffset ; record 53
	dw $000e ; record 54
	dw $4806 ; record 55
	dw $51cd ; record 56
	dw $d11f ; record 57
	dw $f0c9 ; record 58
	dw $e68c ; record 59
	dw $210f ; record 60
	dw $40bd ; record 61
	dw $6f85 ; record 62
	dw $0130 ; record 63
	dw $7e24 ; record 64
	dw $7947 ; record 65
	dw $28b7 ; record 66
	dw $7804 ; record 67
	dw $5782 ; record 68
	dw $7ac9 ; record 69
	dw $5790 ; record 70
	dw $00c9 ; record 71
	dw $0000 ; record 72
	dw $0101 ; record 73
	dw $0101 ; record 74
	dw $0101 ; record 75
	dw $0101 ; record 76
	dw $0000 ; record 77
	dw $0000 ; record 78
	db $00
ApplyArrowBobOffset:
	ldh a, [hVBlankCounter] ; $40cd
	and a, $0f ; $40cf
	ld hl, $40e7 ; $40d1
	add a, l ; $40d4
	ld l, a ; $40d5
	jr nc, Label_1b_40d9 ; $40d6
	inc h ; $40d8
Label_1b_40d9:
	ld a, [hl] ; $40d9
	ld b, a ; $40da
	ld a, c ; $40db
	or a, a ; $40dc
	jr z, Label_1b_40e3 ; $40dd
	ld a, b ; $40df
	add a, e ; $40e0
	ld e, a ; $40e1
	ret ; $40e2
Label_1b_40e3:
	ld a, e ; $40e3
	sub a, b ; $40e4
	ld e, a ; $40e5
	ret ; $40e6
	nop ; $40e7
	nop ; $40e8
	nop ; $40e9
	ld bc, $0101 ; $40ea
	ld bc, $0101 ; $40ed
	ld bc, $0001 ; $40f0
	nop ; $40f3
	nop ; $40f4
	nop ; $40f5
	nop ; $40f6
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
	add a, d ; $4105
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
	add a, e ; $4115
	ld e, a ; $4116
	ld a, b ; $4117
	add a, d ; $4118
	ld d, a ; $4119
	push de ; $411a
	ld c, $00 ; $411b
	ld b, $69 ; $411d
	call QueueSprite ; $411f
	pop de ; $4122
	pop bc ; $4123
	pop de ; $4124
	ld a, e ; $4125
	add a, c ; $4126
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
	bit 4, a ; $413d
	jr z, Label_1b_4156 ; $413f
	ld a, [wMenuCursorX] ; $4141
	inc a ; $4144
	add a, a ; $4145
	jr nc, Label_1b_414c ; $4146
	ld a, b ; $4148
	dec a ; $4149
	jr Label_1b_4151 ; $414a
Label_1b_414c:
	rra ; $414c
	cp a, b ; $414d
	jr c, Label_1b_4151 ; $414e
	xor a, a ; $4150
Label_1b_4151:
	ld [wMenuCursorX], a ; $4151
	jr Label_1b_419f ; $4154
Label_1b_4156:
	bit 5, a ; $4156
	jr z, Label_1b_416f ; $4158
	ld a, [wMenuCursorX] ; $415a
	dec a ; $415d
	add a, a ; $415e
	jr nc, Label_1b_4165 ; $415f
	ld a, b ; $4161
	dec a ; $4162
	jr Label_1b_416a ; $4163
Label_1b_4165:
	rra ; $4165
	cp a, b ; $4166
	jr c, Label_1b_416a ; $4167
	xor a, a ; $4169
Label_1b_416a:
	ld [wMenuCursorX], a ; $416a
	jr Label_1b_419f ; $416d
Label_1b_416f:
	bit 6, a ; $416f
	jr z, Label_1b_4188 ; $4171
	ld a, [wMenuCursorY] ; $4173
	dec a ; $4176
	add a, a ; $4177
	jr nc, Label_1b_417e ; $4178
	ld a, c ; $417a
	dec a ; $417b
	jr Label_1b_4183 ; $417c
Label_1b_417e:
	rra ; $417e
	cp a, c ; $417f
	jr c, Label_1b_4183 ; $4180
	xor a, a ; $4182
Label_1b_4183:
	ld [wMenuCursorY], a ; $4183
	jr Label_1b_419f ; $4186
Label_1b_4188:
	bit 7, a ; $4188
	jr z, Label_1b_419f ; $418a
	ld a, [wMenuCursorY] ; $418c
	inc a ; $418f
	add a, a ; $4190
	jr nc, Label_1b_4197 ; $4191
	ld a, c ; $4193
	dec a ; $4194
	jr Label_1b_419c ; $4195
Label_1b_4197:
	rra ; $4197
	cp a, c ; $4198
	jr c, Label_1b_419c ; $4199
	xor a, a ; $419b
Label_1b_419c:
	ld [wMenuCursorY], a ; $419c
Label_1b_419f:
	ld a, [wMenuCursorX] ; $419f
	cp a, d ; $41a2
	jr nz, Label_1b_41ad ; $41a3
	ld a, [wMenuCursorY] ; $41a5
	cp a, e ; $41a8
	jr nz, Label_1b_41ad ; $41a9
	xor a, a ; $41ab
	ret ; $41ac
Label_1b_41ad:
	ld a, $01 ; $41ad
	ret ; $41af
	ld a, [wMenuCursorX] ; $41b0
	ld d, a ; $41b3
	ld a, [wMenuCursorY] ; $41b4
	ld e, a ; $41b7
	ldh a, [$ffd3] ; $41b8
	bit 4, a ; $41ba
	jr z, Label_1b_41d3 ; $41bc
	ld a, [wMenuCursorX] ; $41be
	inc a ; $41c1
	add a, a ; $41c2
	jr nc, Label_1b_41c9 ; $41c3
	ld a, b ; $41c5
	dec a ; $41c6
	jr Label_1b_41ce ; $41c7
Label_1b_41c9:
	rra ; $41c9
	cp a, b ; $41ca
	jr c, Label_1b_41ce ; $41cb
	xor a, a ; $41cd
Label_1b_41ce:
	ld [wMenuCursorX], a ; $41ce
	jr Label_1b_421c ; $41d1
Label_1b_41d3:
	bit 5, a ; $41d3
	jr z, Label_1b_41ec ; $41d5
	ld a, [wMenuCursorX] ; $41d7
	dec a ; $41da
	add a, a ; $41db
	jr nc, Label_1b_41e2 ; $41dc
	ld a, b ; $41de
	dec a ; $41df
	jr Label_1b_41e7 ; $41e0
Label_1b_41e2:
	rra ; $41e2
	cp a, b ; $41e3
	jr c, Label_1b_41e7 ; $41e4
	xor a, a ; $41e6
Label_1b_41e7:
	ld [wMenuCursorX], a ; $41e7
	jr Label_1b_421c ; $41ea
Label_1b_41ec:
	bit 6, a ; $41ec
	jr z, Label_1b_4205 ; $41ee
	ld a, [wMenuCursorY] ; $41f0
	dec a ; $41f3
	add a, a ; $41f4
	jr nc, Label_1b_41fb ; $41f5
	ld a, c ; $41f7
	dec a ; $41f8
	jr Label_1b_4200 ; $41f9
Label_1b_41fb:
	rra ; $41fb
	cp a, c ; $41fc
	jr c, Label_1b_4200 ; $41fd
	xor a, a ; $41ff
Label_1b_4200:
	ld [wMenuCursorY], a ; $4200
	jr Label_1b_421c ; $4203
Label_1b_4205:
	bit 7, a ; $4205
	jr z, Label_1b_421c ; $4207
	ld a, [wMenuCursorY] ; $4209
	inc a ; $420c
	add a, a ; $420d
	jr nc, Label_1b_4214 ; $420e
	ld a, c ; $4210
	dec a ; $4211
	jr Label_1b_4219 ; $4212
Label_1b_4214:
	rra ; $4214
	cp a, c ; $4215
	jr c, Label_1b_4219 ; $4216
	xor a, a ; $4218
Label_1b_4219:
	ld [wMenuCursorY], a ; $4219
Label_1b_421c:
	ld a, [wMenuCursorX] ; $421c
	cp a, d ; $421f
	jr nz, Label_1b_422a ; $4220
	ld a, [wMenuCursorY] ; $4222
	cp a, e ; $4225
	jr nz, Label_1b_422a ; $4226
	xor a, a ; $4228
	ret ; $4229
Label_1b_422a:
	ld a, $01 ; $422a
	ret ; $422c
	ld a, [wMenuCursorX] ; $422d
	ld d, a ; $4230
	ld a, [wMenuCursorY] ; $4231
	ld e, a ; $4234
	ldh a, [$ffc2] ; $4235
	cp a, $02 ; $4237
	jr z, Label_1b_4246 ; $4239
	cp a, $01 ; $423b
	jr z, Label_1b_4242 ; $423d
	call LinkErrorReset ; $423f
Label_1b_4242:
	ldh a, [$ffd5] ; $4242
	jr Label_1b_4248 ; $4244
Label_1b_4246:
	ldh a, [$ffd4] ; $4246
Label_1b_4248:
	ld h, a ; $4248
	ld a, [$cb08] ; $4249
	and a, $01 ; $424c
	ld a, h ; $424e
	jr nz, Label_1b_42b5 ; $424f
	bit 4, a ; $4251
	jr z, Label_1b_426a ; $4253
	ld a, [wMenuCursorX] ; $4255
	inc a ; $4258
	add a, a ; $4259
	jr nc, Label_1b_4260 ; $425a
	ld a, b ; $425c
	dec a ; $425d
	jr Label_1b_4265 ; $425e
Label_1b_4260:
	rra ; $4260
	cp a, b ; $4261
	jr c, Label_1b_4265 ; $4262
	xor a, a ; $4264
Label_1b_4265:
	ld [wMenuCursorX], a ; $4265
	jr Label_1b_42e7 ; $4268
Label_1b_426a:
	bit 5, a ; $426a
	jr z, Label_1b_4283 ; $426c
	ld a, [wMenuCursorX] ; $426e
	dec a ; $4271
	add a, a ; $4272
	jr nc, Label_1b_4279 ; $4273
	ld a, b ; $4275
	dec a ; $4276
	jr Label_1b_427e ; $4277
Label_1b_4279:
	rra ; $4279
	cp a, b ; $427a
	jr c, Label_1b_427e ; $427b
	xor a, a ; $427d
Label_1b_427e:
	ld [wMenuCursorX], a ; $427e
	jr Label_1b_42e7 ; $4281
Label_1b_4283:
	bit 6, a ; $4283
	jr z, Label_1b_429c ; $4285
	ld a, [wMenuCursorY] ; $4287
	dec a ; $428a
	add a, a ; $428b
	jr nc, Label_1b_4292 ; $428c
	ld a, c ; $428e
	dec a ; $428f
	jr Label_1b_4297 ; $4290
Label_1b_4292:
	rra ; $4292
	cp a, c ; $4293
	jr c, Label_1b_4297 ; $4294
	xor a, a ; $4296
Label_1b_4297:
	ld [wMenuCursorY], a ; $4297
	jr Label_1b_42e7 ; $429a
Label_1b_429c:
	bit 7, a ; $429c
	jr z, Label_1b_42b5 ; $429e
	ld a, [wMenuCursorY] ; $42a0
	inc a ; $42a3
	add a, a ; $42a4
	jr nc, Label_1b_42ab ; $42a5
	ld a, c ; $42a7
	dec a ; $42a8
	jr Label_1b_42b0 ; $42a9
Label_1b_42ab:
	rra ; $42ab
	cp a, c ; $42ac
	jr c, Label_1b_42b0 ; $42ad
	xor a, a ; $42af
Label_1b_42b0:
	ld [wMenuCursorY], a ; $42b0
	jr Label_1b_42e7 ; $42b3
Label_1b_42b5:
	bit 0, a ; $42b5
	jr z, Label_1b_42cd ; $42b7
	sound $5f ; $42b9
	ld a, [$cb08] ; $42bb
	ld b, a ; $42be
	and a, $01 ; $42bf
	jr nz, Label_1b_42e7 ; $42c1
	sound $5f ; $42c3
	ld a, b ; $42c5
	or a, $01 ; $42c6
	ld [$cb08], a ; $42c8
	jr Label_1b_42e7 ; $42cb
Label_1b_42cd:
	bit 1, a ; $42cd
	jr z, Label_1b_42e7 ; $42cf
	sound $62 ; $42d1
	ld a, [$cb08] ; $42d3
	ld b, a ; $42d6
	and a, $03 ; $42d7
	ld a, b ; $42d9
	jr nz, Label_1b_42e2 ; $42da
	and a, $fa ; $42dc
	or a, $04 ; $42de
	jr Label_1b_42e4 ; $42e0
Label_1b_42e2:
	and a, $fe ; $42e2
Label_1b_42e4:
	ld [$cb08], a ; $42e4
Label_1b_42e7:
	ld a, [wMenuCursorX] ; $42e7
	cp a, d ; $42ea
	jr nz, Label_1b_42f5 ; $42eb
	ld a, [wMenuCursorY] ; $42ed
	cp a, e ; $42f0
	jr nz, Label_1b_42f5 ; $42f1
	xor a, a ; $42f3
	ret ; $42f4
Label_1b_42f5:
	ld a, $01 ; $42f5
	ret ; $42f7
	INCBIN "data/bank_01b/d_42f8.bin" ; $42f8, 21 bytes
	ldh a, [$ffd4] ; $430d
	jr Label_1b_4313 ; $430f
	ldh a, [$ffd5] ; $4311
Label_1b_4313:
	ld h, a ; $4313
	ld a, [$cb08] ; $4314
	and a, $02 ; $4317
	ld a, h ; $4319
	jr nz, Label_1b_4380 ; $431a
	bit 4, a ; $431c
	jr z, Label_1b_4335 ; $431e
	ld a, [$cb06] ; $4320
	inc a ; $4323
	add a, a ; $4324
	jr nc, Label_1b_432b ; $4325
	ld a, b ; $4327
	dec a ; $4328
	jr Label_1b_4330 ; $4329
Label_1b_432b:
	rra ; $432b
	cp a, b ; $432c
	jr c, Label_1b_4330 ; $432d
	xor a, a ; $432f
Label_1b_4330:
	ld [$cb06], a ; $4330
	jr Label_1b_43b0 ; $4333
Label_1b_4335:
	bit 5, a ; $4335
	jr z, Label_1b_434e ; $4337
	ld a, [$cb06] ; $4339
	dec a ; $433c
	add a, a ; $433d
	jr nc, Label_1b_4344 ; $433e
	ld a, b ; $4340
	dec a ; $4341
	jr Label_1b_4349 ; $4342
Label_1b_4344:
	rra ; $4344
	cp a, b ; $4345
	jr c, Label_1b_4349 ; $4346
	xor a, a ; $4348
Label_1b_4349:
	ld [$cb06], a ; $4349
	jr Label_1b_43b0 ; $434c
Label_1b_434e:
	bit 6, a ; $434e
	jr z, Label_1b_4367 ; $4350
	ld a, [$cb07] ; $4352
	dec a ; $4355
	add a, a ; $4356
	jr nc, Label_1b_435d ; $4357
	ld a, c ; $4359
	dec a ; $435a
	jr Label_1b_4362 ; $435b
Label_1b_435d:
	rra ; $435d
	cp a, c ; $435e
	jr c, Label_1b_4362 ; $435f
	xor a, a ; $4361
Label_1b_4362:
	ld [$cb07], a ; $4362
	jr Label_1b_43b0 ; $4365
Label_1b_4367:
	bit 7, a ; $4367
	jr z, Label_1b_4380 ; $4369
	ld a, [$cb07] ; $436b
	inc a ; $436e
	add a, a ; $436f
	jr nc, Label_1b_4376 ; $4370
	ld a, c ; $4372
	dec a ; $4373
	jr Label_1b_437b ; $4374
Label_1b_4376:
	rra ; $4376
	cp a, c ; $4377
	jr c, Label_1b_437b ; $4378
	xor a, a ; $437a
Label_1b_437b:
	ld [$cb07], a ; $437b
	jr Label_1b_43b0 ; $437e
Label_1b_4380:
	bit 0, a ; $4380
	jr z, Label_1b_4396 ; $4382
	ld a, [$cb08] ; $4384
	ld b, a ; $4387
	and a, $02 ; $4388
	jr nz, Label_1b_43b0 ; $438a
	sound $5f ; $438c
	ld a, b ; $438e
	or a, $02 ; $438f
	ld [$cb08], a ; $4391
	jr Label_1b_43b0 ; $4394
Label_1b_4396:
	bit 1, a ; $4396
	jr z, Label_1b_43b0 ; $4398
	sound $62 ; $439a
	ld a, [$cb08] ; $439c
	ld b, a ; $439f
	and a, $03 ; $43a0
	ld a, b ; $43a2
	jr nz, Label_1b_43ab ; $43a3
	and a, $f5 ; $43a5
	or a, $08 ; $43a7
	jr Label_1b_43ad ; $43a9
Label_1b_43ab:
	and a, $fd ; $43ab
Label_1b_43ad:
	ld [$cb08], a ; $43ad
Label_1b_43b0:
	ld a, [$cb06] ; $43b0
	cp a, d ; $43b3
	jr nz, Label_1b_43be ; $43b4
	ld a, [$cb07] ; $43b6
	cp a, e ; $43b9
	jr nz, Label_1b_43be ; $43ba
	xor a, a ; $43bc
	ret ; $43bd
Label_1b_43be:
	ld a, $01 ; $43be
	ret ; $43c0
GetMenuCursorIndex:
	ld a, [wMenuCursorY] ; $43c1
	ld b, a ; $43c4
	xor a, a ; $43c5
	inc b ; $43c6
Label_1b_43c7:
	dec b ; $43c7
	jr z, Label_1b_43cd ; $43c8
	add a, c ; $43ca
	jr Label_1b_43c7 ; $43cb
Label_1b_43cd:
	ld b, a ; $43cd
	ld a, [wMenuCursorX] ; $43ce
	add a, b ; $43d1
	ret ; $43d2
	push bc ; $43d3
	ld a, [hl-] ; $43d4
	ld b, a ; $43d5
	xor a, a ; $43d6
	inc b ; $43d7
Label_1b_43d8:
	dec b ; $43d8
	jr z, Label_1b_43de ; $43d9
	add a, c ; $43db
	jr Label_1b_43d8 ; $43dc
Label_1b_43de:
	ld b, a ; $43de
	ld a, [hl] ; $43df
	add a, b ; $43e0
	pop bc ; $43e1
	ret ; $43e2
SetMenuCursorFromIndex:
	ld d, $00 ; $43e3
	ld a, c ; $43e5
Label_1b_43e6:
	cp a, b ; $43e6
	jr c, Label_1b_43ed ; $43e7
	inc d ; $43e9
	sub a, b ; $43ea
	jr Label_1b_43e6 ; $43eb
Label_1b_43ed:
	ld [wMenuCursorX], a ; $43ed
	ld a, d ; $43f0
	ld [wMenuCursorY], a ; $43f1
	ret ; $43f4
	ld d, $00 ; $43f5
	ld a, c ; $43f7
Label_1b_43f8:
	cp a, b ; $43f8
	jr c, Label_1b_43ff ; $43f9
	inc d ; $43fb
	sub a, b ; $43fc
	jr Label_1b_43f8 ; $43fd
Label_1b_43ff:
	ld [hl+], a ; $43ff
	ld a, d ; $4400
	ld [hl], a ; $4401
	ret ; $4402
	ldh a, [hWramBank] ; $4403
	push af ; $4405
	wram_bank $03 ; $4406
	xor a, a ; $440c
	ld c, $40 ; $440d
Label_1b_440f:
	ld [hl+], a ; $440f
	dec c ; $4410
	jr nz, Label_1b_440f ; $4411
	pop af ; $4413
	wram_bank ; $4414
	ret ; $4418
	INCBIN "data/bank_01b/d_4419.bin" ; $4419, 13 bytes
Label_1b_4426:
	ld [hl+], a ; $4426
	dec c ; $4427
	jr nz, Label_1b_4426 ; $4428
	pop af ; $442a
	wram_bank ; $442b
	ret ; $442f
	INCBIN "data/bank_01b/d_4430.bin" ; $4430, 4 bytes
DrawNameWithDiacritics:
	push af ; $4434
	push bc ; $4435
Label_1b_4436:
	ld a, [hl] ; $4436
	cp a, $00 ; $4437
	jr z, Label_1b_446a ; $4439
	ld [de], a ; $443b
	inc hl ; $443c
	ld a, [hl] ; $443d
	cp a, $de ; $443e
	jr z, Label_1b_4446 ; $4440
	cp a, $df ; $4442
	jr nz, Label_1b_445b ; $4444
Label_1b_4446:
	push hl ; $4446
	push bc ; $4447
	ld h, d ; $4448
	ld l, e ; $4449
	ld bc, $ffe0 ; $444a
	add hl, bc ; $444d
	ld b, a ; $444e
	ld a, [hl] ; $444f
	cp a, $03 ; $4450
	ld a, b ; $4452
	jr nz, Label_1b_4457 ; $4453
	sub a, $d0 ; $4455
Label_1b_4457:
	ld [hl], a ; $4457
	pop bc ; $4458
	pop hl ; $4459
	inc hl ; $445a
Label_1b_445b:
	inc de ; $445b
	ld a, e ; $445c
	and a, $1f ; $445d
	jr nz, Label_1b_4436 ; $445f
	push hl ; $4461
	ld h, d ; $4462
	ld l, e ; $4463
	add hl, de ; $4464
	ld d, h ; $4465
	ld e, l ; $4466
	pop hl ; $4467
	jr Label_1b_4436 ; $4468
Label_1b_446a:
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
	and a, a ; $448f
	jr z, Label_1b_4497 ; $4490
	call DrawAsciiDigitChar ; $4492
	jr DrawAsciiDigitString ; $4495
Label_1b_4497:
	ret ; $4497
DrawAsciiDigitChar:
	push hl ; $4498
	ld hl, $d240 ; $4499
	sub a, $30 ; $449c
	jr c, Label_1b_44ae ; $449e
	add a, $30 ; $44a0
	ld b, a ; $44a2
	wram_bank $03 ; $44a3
	ld a, b ; $44a9
	ld [de], a ; $44aa
	inc de ; $44ab
	pop hl ; $44ac
	ret ; $44ad
Label_1b_44ae:
	inc de ; $44ae
	pop hl ; $44af
	ret ; $44b0
	INCBIN "data/bank_01b/d_44b1.bin" ; $44b1, 2395 bytes
Func_1b_4e0c:
	ret ; $4e0c
Func_1b_4e0d:
	ld a, $ff ; $4e0d
	ld [$c780], a ; $4e0f
	ld d, $03 ; $4e12
	farcall FarPtr_18_00 ; $4e14
	ret ; $4e17
SetMugshotAttrs:
	push af ; $4e18
	push de ; $4e19
	push hl ; $4e1a
	and a, $07 ; $4e1b
	add a, $03 ; $4e1d
	or a, $08 ; $4e1f
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
	cp a, $40 ; $4e37
	ret nc ; $4e39
	push de ; $4e3a
	ld de, $d600 ; $4e3b
	call DecompressCharMugshot ; $4e3e
	pop de ; $4e41
	ret ; $4e42
Func_1b_4e43:
	ret ; $4e43
Func_1b_4e44:
	ret ; $4e44
Func_1b_4e45:
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
Func_1b_4e57:
	ret ; $4e57
LoadIndexedPaletteThunk:
	farcall FarPtr_LoadIndexedPalette_18 ; $4e58
	ret ; $4e5b
DecompressCharMugshot:
	push af ; $4e5c
	push de ; $4e5d
	push hl ; $4e5e
	call Func_1b_4e0c ; $4e5f
	cp a, $3f ; $4e62
	jr nz, Label_1b_4e6c ; $4e64
	ld b, a ; $4e66
	ld a, [$c36c] ; $4e67
	add a, b ; $4e6a
	inc a ; $4e6b
Label_1b_4e6c:
	ld l, a ; $4e6c
	ld h, $00 ; $4e6d
	add hl, hl ; $4e6f
	add hl, hl ; $4e70
	ld bc, $4cec ; $4e71
	add hl, bc ; $4e74
	ld a, [hl+] ; $4e75
	ld h, [hl] ; $4e76
	ld l, a ; $4e77
	call DecompressData ; $4e78
	pop hl ; $4e7b
	pop de ; $4e7c
	pop af ; $4e7d
	ret ; $4e7e
Func_1b_4e7f:
	ret ; $4e7f
Func_1b_4e80:
	ret ; $4e80
ShowRankingBoard:
	wram_bank $03 ; $4e81
	xor a, a ; $4e87
	ld [$d85a], a ; $4e88
	ld a, b ; $4e8b
	ld [$d800], a ; $4e8c
	ld a, c ; $4e8f
	ld [$d801], a ; $4e90
	ld a, d ; $4e93
	ld [$d802], a ; $4e94
	cp a, $03 ; $4e97
	jr nz, Label_1b_4ea4 ; $4e99
	xor a, a ; $4e9b
	ld [$d802], a ; $4e9c
	ld a, $01 ; $4e9f
	ld [$d85a], a ; $4ea1
Label_1b_4ea4:
	ld a, [$d802] ; $4ea4
	cp a, $01 ; $4ea7
	jr nz, Label_1b_4eaf ; $4ea9
	sound $2b ; $4eab
	jr Label_1b_4eb5 ; $4ead
Label_1b_4eaf:
	cp a, $02 ; $4eaf
	jr nz, Label_1b_4eb5 ; $4eb1
	sound $2a ; $4eb3
Label_1b_4eb5:
	call DisableLCDSafely ; $4eb5
	call BuildRankingBoardScreen ; $4eb8
	call EnableLCD ; $4ebb
	ld c, $04 ; $4ebe
	call BeginFadeIn ; $4ec0
	call WaitFadeEnd ; $4ec3
	wram_bank $03 ; $4ec6
	call DispatchRankingBoardAnim ; $4ecc
	call WaitFramesCmd ; $4ecf
	db $1e ; $4ed2 inline arg
	call WaitForAOrBPress ; $4ed3
	ld c, $20 ; $4ed6
	ld a, [$d802] ; $4ed8
	or a, a ; $4edb
	jr nz, Label_1b_4ee8 ; $4edc
	ld a, [$d85a] ; $4ede
	or a, a ; $4ee1
	jr nz, Label_1b_4ee8 ; $4ee2
	sound $7f ; $4ee4
	ld c, $02 ; $4ee6
Label_1b_4ee8:
	call BeginFadeOut ; $4ee8
	call WaitFadeEnd ; $4eeb
	call ClearFrameTasks ; $4eee
	ret ; $4ef1
BuildRankingBoardScreen:
	xor a, a ; $4ef2
	ldh [hScrollX], a ; $4ef3
	ldh [hScrollY], a ; $4ef5
	ld [wCameraX], a ; $4ef7
	ld [$c321], a ; $4efa
	ld [wCameraY], a ; $4efd
	ld [$c323], a ; $4f00
	farcall FarPtr_01_0a ; $4f03
	farcall FarPtr_PrepareGlyphBuffer ; $4f06
	wram_bank $03 ; $4f09
	xor a, a ; $4f0f
	ld [$d855], a ; $4f10
	ld [$d858], a ; $4f13
	ld hl, $d803 ; $4f16
	ld bc, $0053 ; $4f19
	call ClearBytes ; $4f1c
	call ClearRankingMarkerSlots ; $4f1f
	call LoadRankingMarkerCoords ; $4f22
	ld a, [$d800] ; $4f25
	or a, a ; $4f28
	jr z, Label_1b_4f3e ; $4f29
	ld c, $2a ; $4f2b
	farcall FarPtr_LoadScreenAssetRecord ; $4f2d
	wram_bank $03 ; $4f30
	call DrawDoublesRankingNames ; $4f36
	call HighlightDoublesRankingRows ; $4f39
	jr Label_1b_4f4f ; $4f3c
Label_1b_4f3e:
	ld c, $29 ; $4f3e
	farcall FarPtr_LoadScreenAssetRecord ; $4f40
	wram_bank $03 ; $4f43
	call DrawSinglesRankingNames ; $4f49
	call HighlightSinglesRankingRows ; $4f4c
Label_1b_4f4f:
	call LoadRankingBoardTiles ; $4f4f
	ld hl, $4f76 ; $4f52
	ld de, $0806 ; $4f55
	call LoadPaletteShadow ; $4f58
	ld a, $01 ; $4f5b
	ld hl, $5a45 ; $4f5d
	call RegisterFrameTask ; $4f60
	ld a, [$d802] ; $4f63
	cp a, $02 ; $4f66
	jr nz, Label_1b_4f72 ; $4f68
	ld a, $01 ; $4f6a
	ld hl, $5a04 ; $4f6c
	call RegisterFrameTask ; $4f6f
Label_1b_4f72:
	farcall FarPtr_QueueWram3MapToVRAM ; $4f72
	ret ; $4f75
	; $4f76, 48 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $00ab, $01dc, $039f, $7fff ; pal 0: #5a2900 #e67300 #ffe600 #ffffff
	dw $5900, $7a00, $7bc5, $7fff ; pal 1: #0041b4 #0083f6 #29f6f6 #ffffff
	dw $002f, $011d, $225f, $7fff ; pal 2: #7b0800 #ee4100 #ff9441 #ffffff
	dw $484c, $7c91, $7e38, $7fff ; pal 3: #621094 #8b20ff #c58bff #ffffff
	dw $0260, $00ff, $27ff, $0000 ; pal 4: #009c00 #ff3900 #ffff4a #000000
	dw $0260, $68af, $6e1f, $0000 ; pal 5: #009c00 #7b29d5 #ff83de #000000
LoadRankingBoardTiles:
	ldh a, [hWramBank] ; $4fa6
	push af ; $4fa8
	wram_bank $01 ; $4fa9
	ld hl, $3f30 ; $4faf -> DataPtr_3f_30
	ld de, $d000 ; $4fb2
	call DecompressDataFromBank ; $4fb5
	ld hl, $d000 ; $4fb8
	ld de, $a000 ; $4fbb
	ld c, $10 ; $4fbe
	call QueueVRAMCopy ; $4fc0
	ld hl, $3f32 ; $4fc3 -> DataPtr_3f_32
	ld de, $d000 ; $4fc6
	call DecompressDataFromBank ; $4fc9
	ld hl, $d000 ; $4fcc
	ld de, $a100 ; $4fcf
	ld c, $10 ; $4fd2
	call QueueVRAMCopy ; $4fd4
	ld hl, $3f34 ; $4fd7 -> DataPtr_3f_34
	ld de, $d000 ; $4fda
	call DecompressDataFromBank ; $4fdd
	ld hl, $d000 ; $4fe0
	ld de, $a200 ; $4fe3
	ld c, $10 ; $4fe6
	call QueueVRAMCopy ; $4fe8
	pop af ; $4feb
	wram_bank ; $4fec
	ret ; $4ff0
DispatchRankingBoardAnim:
	ld a, [$d85a] ; $4ff1
	or a, a ; $4ff4
	ret nz ; $4ff5
	ld a, [$d802] ; $4ff6
	cp a, $02 ; $4ff9
	ret z ; $4ffb
	ld a, [$d800] ; $4ffc
	or a, a ; $4fff
	jr nz, Label_1b_5028 ; $5000
	ld a, [$d802] ; $5002
	or a, a ; $5005
	jr nz, Label_1b_5018 ; $5006
	ld a, [$d801] ; $5008
	add a, a ; $500b
	ld hl, $5059 ; $500c
	add a, l ; $500f
	ld l, a ; $5010
	jr nc, Label_1b_5014 ; $5011
	inc h ; $5013
Label_1b_5014:
	ld a, [hl+] ; $5014
	ld h, [hl] ; $5015
	ld l, a ; $5016
	jp hl ; $5017
Label_1b_5018:
	ld a, [$d801] ; $5018
	add a, a ; $501b
	ld hl, $504f ; $501c
	add a, l ; $501f
	ld l, a ; $5020
	jr nc, Label_1b_5024 ; $5021
	inc h ; $5023
Label_1b_5024:
	ld a, [hl+] ; $5024
	ld h, [hl] ; $5025
	ld l, a ; $5026
	jp hl ; $5027
Label_1b_5028:
	ld a, [$d802] ; $5028
	or a, a ; $502b
	jr nz, Label_1b_503e ; $502c
	ld a, [$d801] ; $502e
	add a, a ; $5031
	ld hl, $506d ; $5032
	add a, l ; $5035
	ld l, a ; $5036
	jr nc, Label_1b_503a ; $5037
	inc h ; $5039
Label_1b_503a:
	ld a, [hl+] ; $503a
	ld h, [hl] ; $503b
	ld l, a ; $503c
	jp hl ; $503d
Label_1b_503e:
	ld a, [$d801] ; $503e
	add a, a ; $5041
	ld hl, $5063 ; $5042
	add a, l ; $5045
	ld l, a ; $5046
	jr nc, Label_1b_504a ; $5047
	inc h ; $5049
Label_1b_504a:
	ld a, [hl+] ; $504a
	ld h, [hl] ; $504b
	ld l, a ; $504c
	jp hl ; $504d
	; $504e, 1209 bytes (records:2)
	dw $77c9 ; record 0
	dw $7750 ; record 1
	dw $6f50 ; record 2
	dw $7351 ; record 3
	dw $eb52 ; record 4
	dw $ff52 ; record 5
	dw $ff52 ; record 6
	dw $2252 ; record 7
	dw $4953 ; record 8
	dw $6853 ; record 9
	dw $8753 ; record 10
	dw $8753 ; record 11
	dw $fa53 ; record 12
	dw $6d53 ; record 13
	dw $a054 ; record 14
	dw $a354 ; record 15
	dw $a354 ; record 16
	dw $c254 ; record 17
	dw $e554 ; record 18
	dw $0454 ; record 19
	dw $3e55 ; record 20
	dw $2101 ; record 21
	dw $5912 ; record 22
	dw $6acd ; record 23
	dw $cd1b ; record 24
	dw $2725 ; record 25
	dw $cf8c ; record 26
	dw $0e78 ; record 27
	dw $cd00 ; record 28
	dw GetRankingMarkerSlot ; record 29
	dw $a511 ; record 30
	dw $cd5b ; record 31
	dw $5aa4 ; record 32
	dw $010e ; record 33
	dw $51cd ; record 34
	dw $115f ; record 35
	dw $5bb2 ; record 36
	dw $89cd ; record 37
	dw $065a ; record 38
	dw $cd01 ; record 39
	dw HighlightRankingRow ; record 40
	dw $c5cd ; record 41
	dw $cd58 ; record 42
	dw $2725 ; record 43
	dw $cf1e ; record 44
	dw $0e80 ; record 45
	dw $cd03 ; record 46
	dw GetRankingMarkerSlot ; record 47
	dw $9411 ; record 48
	dw $cd5b ; record 49
	dw $5a6e ; record 50
	dw $040e ; record 51
	dw $51cd ; record 52
	dw $115f ; record 53
	dw $5b94 ; record 54
	dw $89cd ; record 55
	dw $cd5a ; record 56
	dw $2725 ; record 57
	dw $cf5a ; record 58
	dw $0e78 ; record 59
	dw $cd03 ; record 60
	dw GetRankingMarkerSlot ; record 61
	dw $a511 ; record 62
	dw $cd5b ; record 63
	dw $5aa4 ; record 64
	dw $040e ; record 65
	dw $51cd ; record 66
	dw $115f ; record 67
	dw $5bb2 ; record 68
	dw $89cd ; record 69
	dw $065a ; record 70
	dw $cd02 ; record 71
	dw HighlightRankingRow ; record 72
	dw $c5cd ; record 73
	dw $cd58 ; record 74
	dw $2725 ; record 75
	dw $cf1e ; record 76
	dw $0e80 ; record 77
	dw $cd06 ; record 78
	dw GetRankingMarkerSlot ; record 79
	dw $9d11 ; record 80
	dw $cd5b ; record 81
	dw $5a6e ; record 82
	dw $070e ; record 83
	dw $51cd ; record 84
	dw $115f ; record 85
	dw $5b9d ; record 86
	dw $89cd ; record 87
	dw $cd5a ; record 88
	dw $2725 ; record 89
	dw $cf5a ; record 90
	dw $0e78 ; record 91
	dw $cd06 ; record 92
	dw GetRankingMarkerSlot ; record 93
	dw $a511 ; record 94
	dw $cd5b ; record 95
	dw $5aa4 ; record 96
	dw $070e ; record 97
	dw $51cd ; record 98
	dw $115f ; record 99
	dw $5b95 ; record 100
	dw $89cd ; record 101
	dw $065a ; record 102
	dw $cd03 ; record 103
	dw HighlightRankingRow ; record 104
	dw $c5cd ; record 105
	dw $cd58 ; record 106
	dw $2725 ; record 107
	dw $cf1e ; record 108
	dw $0e80 ; record 109
	dw $cd09 ; record 110
	dw GetRankingMarkerSlot ; record 111
	dw $9d11 ; record 112
	dw $cd5b ; record 113
	dw $5a6e ; record 114
	dw $0a0e ; record 115
	dw $51cd ; record 116
	dw $115f ; record 117
	dw $5b9d ; record 118
	dw $89cd ; record 119
	dw $cd5a ; record 120
	dw $2725 ; record 121
	dw $cf5a ; record 122
	dw $0e78 ; record 123
	dw $cd09 ; record 124
	dw GetRankingMarkerSlot ; record 125
	dw $a511 ; record 126
	dw $cd5b ; record 127
	dw $5aa4 ; record 128
	dw $0a0e ; record 129
	dw $51cd ; record 130
	dw $115f ; record 131
	dw $5b95 ; record 132
	dw $89cd ; record 133
	dw $065a ; record 134
	dw $cd04 ; record 135
	dw HighlightRankingRow ; record 136
	dw $c5cd ; record 137
	dw $cd58 ; record 138
	dw $2725 ; record 139
	dw $3e1e ; record 140
	dw $ea01 ; record 141
	dw $d858 ; record 142
	dw $4ec3 ; record 143
	dw $3e50 ; record 144
	dw $2101 ; record 145
	dw $5912 ; record 146
	dw $6acd ; record 147
	dw $cd1b ; record 148
	dw $2725 ; record 149
	dw $cf8c ; record 150
	dw $0e78 ; record 151
	dw $cd00 ; record 152
	dw GetRankingMarkerSlot ; record 153
	dw $bb11 ; record 154
	dw $cd5b ; record 155
	dw $5aa4 ; record 156
	dw $020e ; record 157
	dw $51cd ; record 158
	dw $115f ; record 159
	dw $5bcc ; record 160
	dw $89cd ; record 161
	dw $065a ; record 162
	dw $cd05 ; record 163
	dw HighlightRankingRow ; record 164
	dw $c5cd ; record 165
	dw $cd58 ; record 166
	dw $2725 ; record 167
	dw $cf1e ; record 168
	dw $0e80 ; record 169
	dw $cd05 ; record 170
	dw GetRankingMarkerSlot ; record 171
	dw $bb11 ; record 172
	dw $cd5b ; record 173
	dw $5a89 ; record 174
	dw $25cd ; record 175
	dw $0427 ; record 176
	dw $030e ; record 177
	dw $51cd ; record 178
	dw $115f ; record 179
	dw $5bc3 ; record 180
	dw $6ecd ; record 181
	dw $cd5a ; record 182
	dw $2725 ; record 183
	dw $cf78 ; record 184
	dw $0e78 ; record 185
	dw $cd05 ; record 186
	dw GetRankingMarkerSlot ; record 187
	dw $cc11 ; record 188
	dw $cd5b ; record 189
	dw $5abf ; record 190
	dw $030e ; record 191
	dw $51cd ; record 192
	dw $115f ; record 193
	dw $5bd4 ; record 194
	dw $6ecd ; record 195
	dw $065a ; record 196
	dw $cd06 ; record 197
	dw HighlightRankingRow ; record 198
	dw $c5cd ; record 199
	dw $cd58 ; record 200
	dw $2725 ; record 201
	dw $cf1e ; record 202
	dw $0e80 ; record 203
	dw $cd08 ; record 204
	dw GetRankingMarkerSlot ; record 205
	dw $cd11 ; record 206
	dw $cd5b ; record 207
	dw $5a89 ; record 208
	dw $25cd ; record 209
	dw $0427 ; record 210
	dw $060e ; record 211
	dw $51cd ; record 212
	dw $115f ; record 213
	dw $5bd4 ; record 214
	dw $6ecd ; record 215
	dw $cd5a ; record 216
	dw $2725 ; record 217
	dw $cf5a ; record 218
	dw $0e78 ; record 219
	dw $cd08 ; record 220
	dw GetRankingMarkerSlot ; record 221
	dw $cc11 ; record 222
	dw $cd5b ; record 223
	dw $5abf ; record 224
	dw $060e ; record 225
	dw $51cd ; record 226
	dw $115f ; record 227
	dw $5bc3 ; record 228
	dw $6ecd ; record 229
	dw $065a ; record 230
	dw $cd07 ; record 231
	dw HighlightRankingRow ; record 232
	dw $c5cd ; record 233
	dw $cd58 ; record 234
	dw $2725 ; record 235
	dw $cf1e ; record 236
	dw $0e80 ; record 237
	dw $cd0b ; record 238
	dw GetRankingMarkerSlot ; record 239
	dw $cd11 ; record 240
	dw $cd5b ; record 241
	dw $5a89 ; record 242
	dw $25cd ; record 243
	dw $0427 ; record 244
	dw $090e ; record 245
	dw $51cd ; record 246
	dw $115f ; record 247
	dw $5bd4 ; record 248
	dw $6ecd ; record 249
	dw $cd5a ; record 250
	dw $2725 ; record 251
	dw $cf5a ; record 252
	dw $0e78 ; record 253
	dw $cd0b ; record 254
	dw GetRankingMarkerSlot ; record 255
	dw $bc11 ; record 256
	dw $cd5b ; record 257
	dw $5a89 ; record 258
	dw $090e ; record 259
	dw $51cd ; record 260
	dw $115f ; record 261
	dw $5bbb ; record 262
	dw $a4cd ; record 263
	dw $065a ; record 264
	dw $cd08 ; record 265
	dw HighlightRankingRow ; record 266
	dw $c5cd ; record 267
	dw $cd58 ; record 268
	dw $2725 ; record 269
	dw $3e1e ; record 270
	dw $ea01 ; record 271
	dw $d858 ; record 272
	dw $4ec3 ; record 273
	dw $3e50 ; record 274
	dw $2101 ; record 275
	dw $5912 ; record 276
	dw $6acd ; record 277
	dw $cd1b ; record 278
	dw $2725 ; record 279
	dw $cf8c ; record 280
	dw $0e78 ; record 281
	dw $cd00 ; record 282
	dw GetRankingMarkerSlot ; record 283
	dw $e711 ; record 284
	dw $cd5b ; record 285
	dw $5aa4 ; record 286
	dw $050e ; record 287
	dw $51cd ; record 288
	dw $115f ; record 289
	dw $5bd4 ; record 290
	dw $6ecd ; record 291
	dw $065a ; record 292
	dw $cd09 ; record 293
	dw HighlightRankingRow ; record 294
	dw $c5cd ; record 295
	dw $cd58 ; record 296
	dw $2725 ; record 297
	dw $cf5a ; record 298
	dw $0e80 ; record 299
	dw $cd08 ; record 300
	dw GetRankingMarkerSlot ; record 301
	dw $d411 ; record 302
	dw $cd5b ; record 303
	dw $5a6e ; record 304
	dw $090e ; record 305
	dw $51cd ; record 306
	dw $115f ; record 307
	dw $5bd4 ; record 308
	dw $89cd ; record 309
	dw $cd5a ; record 310
	dw $2725 ; record 311
	dw $cf5a ; record 312
	dw $0e78 ; record 313
	dw $cd08 ; record 314
	dw GetRankingMarkerSlot ; record 315
	dw $9511 ; record 316
	dw $cd5b ; record 317
	dw $5a6e ; record 318
	dw $090e ; record 319
	dw $51cd ; record 320
	dw $115f ; record 321
	dw $5c0c ; record 322
	dw $bfcd ; record 323
	dw $065a ; record 324
	dw $cd0a ; record 325
	dw HighlightRankingRow ; record 326
	dw $c5cd ; record 327
	dw $cd58 ; record 328
	dw $2725 ; record 329
	dw $3e1e ; record 330
	dw $ea01 ; record 331
	dw $d858 ; record 332
	dw $4ec3 ; record 333
	dw $3e50 ; record 334
	dw $2101 ; record 335
	dw $5912 ; record 336
	dw $6acd ; record 337
	dw $cd1b ; record 338
	dw $2725 ; record 339
	dw $3e8c ; record 340
	dw $ea01 ; record 341
	dw $d858 ; record 342
	dw $4ec3 ; record 343
	dw $cd50 ; record 344
	dw $2725 ; record 345
	dw $cf14 ; record 346
	dw $0e80 ; record 347
	dw $cd00 ; record 348
	dw GetRankingMarkerSlot ; record 349
	dw $9411 ; record 350
	dw $cd5b ; record 351
	dw $5a6e ; record 352
	dw $010e ; record 353
	dw $51cd ; record 354
	dw $115f ; record 355
	dw $5b94 ; record 356
	dw $89cd ; record 357
	dw $cd5a ; record 358
	dw $2725 ; record 359
	dw $c314 ; record 360
	dw $504e ; record 361
	dw $25cd ; record 362
	dw $0a27 ; record 363
	dw $80cf ; record 364
	dw $020e ; record 365
	dw $51cd ; record 366
	dw $115f ; record 367
	dw $5bbb ; record 368
	dw $89cd ; record 369
	dw $cd5a ; record 370
	dw $2725 ; record 371
	dw $0e04 ; record 372
	dw $cd00 ; record 373
	dw GetRankingMarkerSlot ; record 374
	dw $c311 ; record 375
	dw $cd5b ; record 376
	dw $5a6e ; record 377
	dw $25cd ; record 378
	dw $1427 ; record 379
	dw $4ec3 ; record 380
	dw $cd50 ; record 381
	dw $2725 ; record 382
	dw $cf14 ; record 383
	dw $0e80 ; record 384
	dw $cd00 ; record 385
	dw GetRankingMarkerSlot ; record 386
	dw $9411 ; record 387
	dw $cd5b ; record 388
	dw $5a6e ; record 389
	dw $050e ; record 390
	dw $51cd ; record 391
	dw $115f ; record 392
	dw $5b94 ; record 393
	dw $89cd ; record 394
	dw $c35a ; record 395
	dw $504e ; record 396
	dw $25cd ; record 397
	dw $1e27 ; record 398
	dw $80cf ; record 399
	dw $000e ; record 400
	dw $51cd ; record 401
	dw $115f ; record 402
	dw $5bdd ; record 403
	dw $6ecd ; record 404
	dw $0e5a ; record 405
	dw $cd09 ; record 406
	dw GetRankingMarkerSlot ; record 407
	dw $e211 ; record 408
	dw $cd5b ; record 409
	dw $5a89 ; record 410
	dw $4ec3 ; record 411
	dw $3e50 ; record 412
	dw $2101 ; record 413
	dw $5912 ; record 414
	dw $6acd ; record 415
	dw $cd1b ; record 416
	dw $2725 ; record 417
	dw $cf8c ; record 418
	dw $0e78 ; record 419
	dw $cd00 ; record 420
	dw GetRankingMarkerSlot ; record 421
	dw $f711 ; record 422
	dw $cd5b ; record 423
	dw $5aa4 ; record 424
	dw $010e ; record 425
	dw $51cd ; record 426
	dw $115f ; record 427
	dw $5bd4 ; record 428
	dw $89cd ; record 429
	dw $065a ; record 430
	dw $cd01 ; record 431
	dw HighlightDoublesRankingRow ; record 432
	dw $c5cd ; record 433
	dw $cd58 ; record 434
	dw $2725 ; record 435
	dw $cf5a ; record 436
	dw $0e80 ; record 437
	dw $cd03 ; record 438
	dw GetRankingMarkerSlot ; record 439
	dw $d411 ; record 440
	dw $cd5b ; record 441
	dw $5a6e ; record 442
	dw $040e ; record 443
	dw $51cd ; record 444
	dw $115f ; record 445
	dw $5b9d ; record 446
	dw $89cd ; record 447
	dw $cd5a ; record 448
	dw $2725 ; record 449
	dw $cf5a ; record 450
	dw $0e78 ; record 451
	dw $cd03 ; record 452
	dw GetRankingMarkerSlot ; record 453
	dw $f711 ; record 454
	dw $cd5b ; record 455
	dw $5aa4 ; record 456
	dw $040e ; record 457
	dw $51cd ; record 458
	dw $115f ; record 459
	dw $5bc5 ; record 460
	dw $89cd ; record 461
	dw $065a ; record 462
	dw $cd02 ; record 463
	dw HighlightDoublesRankingRow ; record 464
	dw $c5cd ; record 465
	dw $cd58 ; record 466
	dw $2725 ; record 467
	dw $c35a ; record 468
	dw $504e ; record 469
	dw $013e ; record 470
	dw $1221 ; record 471
	dw $cd59 ; record 472
	dw $1b6a ; record 473
	dw $25cd ; record 474
	dw $8c27 ; record 475
	dw $78cf ; record 476
	dw $000e ; record 477
	dw $51cd ; record 478
	dw $115f ; record 479
	dw $5bef ; record 480
	dw $a4cd ; record 481
	dw $0e5a ; record 482
	dw $cd02 ; record 483
	dw GetRankingMarkerSlot ; record 484
	dw $cc11 ; record 485
	dw $cd5b ; record 486
	dw $5a89 ; record 487
	dw $0306 ; record 488
	dw $46cd ; record 489
	dw $cd58 ; record 490
	dw $58c5 ; record 491
	dw $25cd ; record 492
	dw $5a27 ; record 493
	dw $80cf ; record 494
	dw $030e ; record 495
	dw $51cd ; record 496
	dw $115f ; record 497
	dw $5bd4 ; record 498
	dw $6ecd ; record 499
	dw $0e5a ; record 500
	dw $cd05 ; record 501
	dw GetRankingMarkerSlot ; record 502
	dw $cc11 ; record 503
	dw $cd5b ; record 504
	dw $5a89 ; record 505
	dw $25cd ; record 506
	dw $8c27 ; record 507
	dw $78cf ; record 508
	dw $030e ; record 509
	dw $51cd ; record 510
	dw $115f ; record 511
	dw $5bef ; record 512
	dw $a4cd ; record 513
	dw $0e5a ; record 514
	dw $cd05 ; record 515
	dw GetRankingMarkerSlot ; record 516
	dw $bb11 ; record 517
	dw $cd5b ; record 518
	dw $5a89 ; record 519
	dw $0406 ; record 520
	dw $46cd ; record 521
	dw $cd58 ; record 522
	dw $58c5 ; record 523
	dw $25cd ; record 524
	dw $1e27 ; record 525
	dw $4ec3 ; record 526
	dw $3e50 ; record 527
	dw $2101 ; record 528
	dw $5912 ; record 529
	dw $6acd ; record 530
	dw $cd1b ; record 531
	dw $2725 ; record 532
	dw $cf8c ; record 533
	dw $0e78 ; record 534
	dw $cd00 ; record 535
	dw GetRankingMarkerSlot ; record 536
	dw $9811 ; record 537
	dw $cd5b ; record 538
	dw $5a6e ; record 539
	dw $030e ; record 540
	dw $51cd ; record 541
	dw $115f ; record 542
	dw $5b94 ; record 543
	dw $89cd ; record 544
	dw $065a ; record 545
	dw $cd06 ; record 546
	dw HighlightDoublesRankingRow ; record 547
	dw $c5cd ; record 548
	dw $cd58 ; record 549
	dw $2725 ; record 550
	dw $c31e ; record 551
	dw $504e ; record 552
	dw $4ec3 ; record 553
	dw $cd50 ; record 554
	dw $2725 ; record 555
	dw $cf1e ; record 556
	dw $0e80 ; record 557
	dw $cd00 ; record 558
	dw GetRankingMarkerSlot ; record 559
	dw $9411 ; record 560
	dw $cd5b ; record 561
	dw $5a6e ; record 562
	dw $010e ; record 563
	dw $51cd ; record 564
	dw $115f ; record 565
	dw $5b94 ; record 566
	dw $89cd ; record 567
	dw $c35a ; record 568
	dw $504e ; record 569
	dw $25cd ; record 570
	dw $1e27 ; record 571
	dw $80cf ; record 572
	dw $020e ; record 573
	dw $51cd ; record 574
	dw $115f ; record 575
	dw $5bbb ; record 576
	dw $89cd ; record 577
	dw $cd5a ; record 578
	dw $2725 ; record 579
	dw $0e08 ; record 580
	dw $cd00 ; record 581
	dw GetRankingMarkerSlot ; record 582
	dw $9411 ; record 583
	dw $cd5b ; record 584
	dw $5a6e ; record 585
	dw $4ec3 ; record 586
	dw $cd50 ; record 587
	dw $2725 ; record 588
	dw $cf1e ; record 589
	dw $0e80 ; record 590
	dw $cd00 ; record 591
	dw GetRankingMarkerSlot ; record 592
	dw $9411 ; record 593
	dw $cd5b ; record 594
	dw $5a6e ; record 595
	dw $030e ; record 596
	dw $51cd ; record 597
	dw $115f ; record 598
	dw $5b9d ; record 599
	dw $89cd ; record 600
	dw $c35a ; record 601
	dw $504e ; record 602
	dw $4ec3 ; record 603
	db $50
WaitForAOrBPress:
	call AdvanceFrame ; $5507
	ldh a, [hInputPressed] ; $550a
	and a, $03 ; $550c
	jr z, WaitForAOrBPress ; $550e
	ret ; $5510
DrawSinglesRankingNames:
	call InitRankingNameRender ; $5511
	wram_bank $03 ; $5514
	call ClearSinglesRankingNameRects ; $551a
	ld hl, wStoryModeNameOfMainCharacter ; $551d
	ld de, $d021 ; $5520
	call RenderPlayerNameFitted ; $5523
	ld b, $01 ; $5526
Label_1b_5528:
	call DrawSinglesRankingEntry ; $5528
	ld a, b ; $552b
	inc a ; $552c
	ld b, a ; $552d
	cp a, $0c ; $552e
	jr nz, Label_1b_5528 ; $5530
	farcall FarPtr_UploadGlyphBuffer ; $5532
	ret ; $5535
DrawSinglesRankingEntry:
	push af ; $5536
	push bc ; $5537
	push de ; $5538
	push hl ; $5539
	ld a, b ; $553a
	add a, a ; $553b
	ld hl, $5576 ; $553c
	add a, l ; $553f
	ld l, a ; $5540
	jr nc, Label_1b_5544 ; $5541
	inc h ; $5543
Label_1b_5544:
	ld a, [hl+] ; $5544
	ld d, [hl] ; $5545
	ld e, a ; $5546
	ld a, b ; $5547
	add a, a ; $5548
	ld hl, $555e ; $5549
	add a, l ; $554c
	ld l, a ; $554d
	jr nc, Label_1b_5551 ; $554e
	inc h ; $5550
Label_1b_5551:
	ld a, [hl+] ; $5551
	ld h, [hl] ; $5552
	ld l, a ; $5553
	ld c, $05 ; $5554
	farcall FarPtr_RenderProportionalTextAt ; $5556
	pop hl ; $5559
	pop de ; $555a
	pop bc ; $555b
	pop af ; $555c
	ret ; $555d
	; $555e, 48 bytes (records:2)
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
	dw $d021 ; record 12
	dw $d081 ; record 13
	dw $d0e1 ; record 14
	dw $d141 ; record 15
	dw $d1a1 ; record 16
	dw $d201 ; record 17
	dw $d02e ; record 18
	dw $d08e ; record 19
	dw $d0ee ; record 20
	dw $d14e ; record 21
	dw $d1ae ; record 22
	dw $d20e ; record 23
ClearSinglesRankingNameRects:
	push af ; $558e
	push bc ; $558f
	push de ; $5590
	push hl ; $5591
	ld b, $00 ; $5592
	ld de, $d401 ; $5594
Label_1b_5597:
	push bc ; $5597
	ld h, $00 ; $5598
	ld b, $05 ; $559a
	ld c, $02 ; $559c
	farcall FarPtr_FillTilemapRect ; $559e
	ld hl, $0060 ; $55a1
	add hl, de ; $55a4
	ld d, h ; $55a5
	ld e, l ; $55a6
	pop bc ; $55a7
	ld a, b ; $55a8
	inc a ; $55a9
	ld b, a ; $55aa
	cp a, $06 ; $55ab
	jr nz, Label_1b_5597 ; $55ad
	ld de, $d40e ; $55af
	ld b, $00 ; $55b2
Label_1b_55b4:
	push bc ; $55b4
	ld h, $01 ; $55b5
	ld b, $05 ; $55b7
	ld c, $02 ; $55b9
	farcall FarPtr_FillTilemapRect ; $55bb
	ld hl, $0060 ; $55be
	add hl, de ; $55c1
	ld d, h ; $55c2
	ld e, l ; $55c3
	pop bc ; $55c4
	ld a, b ; $55c5
	inc a ; $55c6
	ld b, a ; $55c7
	cp a, $06 ; $55c8
	jr nz, Label_1b_55b4 ; $55ca
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
	ld de, $d041 ; $55e0
	call RenderPlayerNameFitted ; $55e3
	ld hl, wStoryModeNameOfPartnerCharacter ; $55e6
	ld de, $d081 ; $55e9
	call RenderPlayerNameFitted ; $55ec
	ld b, $02 ; $55ef
Label_1b_55f1:
	call DrawDoublesRankingEntry ; $55f1
	ld a, b ; $55f4
	inc a ; $55f5
	ld b, a ; $55f6
	cp a, $0c ; $55f7
	jr nz, Label_1b_55f1 ; $55f9
	farcall FarPtr_UploadGlyphBuffer ; $55fb
	ret ; $55fe
DrawDoublesRankingEntry:
	push af ; $55ff
	push bc ; $5600
	push de ; $5601
	push hl ; $5602
	ld a, b ; $5603
	add a, a ; $5604
	ld hl, $5641 ; $5605
	add a, l ; $5608
	ld l, a ; $5609
	jr nc, Label_1b_560d ; $560a
	inc h ; $560c
Label_1b_560d:
	ld a, [hl+] ; $560d
	ld d, [hl] ; $560e
	ld e, a ; $560f
	ld a, b ; $5610
	add a, a ; $5611
	ld hl, $5627 ; $5612
	add a, l ; $5615
	ld l, a ; $5616
	jr nc, Label_1b_561a ; $5617
	inc h ; $5619
Label_1b_561a:
	ld a, [hl+] ; $561a
	ld h, [hl] ; $561b
	ld l, a ; $561c
	ld c, $05 ; $561d
	farcall FarPtr_RenderProportionalTextAt ; $561f
	pop hl ; $5622
	pop de ; $5623
	pop bc ; $5624
	pop af ; $5625
	ret ; $5626
	; $5627, 50 bytes (records:2)
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
	dw $d041 ; record 13
	dw $d081 ; record 14
	dw $d0e1 ; record 15
	dw $d121 ; record 16
	dw $d181 ; record 17
	dw $d1c1 ; record 18
	dw $d04e ; record 19
	dw $d08e ; record 20
	dw $d0ee ; record 21
	dw $d12e ; record 22
	dw $d18e ; record 23
	dw $d1ce ; record 24
ClearDoublesRankingNameRects:
	push af ; $5659
	push bc ; $565a
	push de ; $565b
	push hl ; $565c
	ld b, $00 ; $565d
	ld de, $d421 ; $565f
Label_1b_5662:
	push bc ; $5662
	ld h, $00 ; $5663
	ld b, $05 ; $5665
	ld c, $04 ; $5667
	farcall FarPtr_FillTilemapRect ; $5669
	ld hl, $00a0 ; $566c
	add hl, de ; $566f
	ld d, h ; $5670
	ld e, l ; $5671
	pop bc ; $5672
	ld a, b ; $5673
	inc a ; $5674
	ld b, a ; $5675
	cp a, $03 ; $5676
	jr nz, Label_1b_5662 ; $5678
	ld de, $d42e ; $567a
	ld b, $00 ; $567d
Label_1b_567f:
	push bc ; $567f
	ld h, $01 ; $5680
	ld b, $05 ; $5682
	ld c, $04 ; $5684
	farcall FarPtr_FillTilemapRect ; $5686
	ld hl, $00a0 ; $5689
	add hl, de ; $568c
	ld d, h ; $568d
	ld e, l ; $568e
	pop bc ; $568f
	ld a, b ; $5690
	inc a ; $5691
	ld b, a ; $5692
	cp a, $03 ; $5693
	jr nz, Label_1b_567f ; $5695
	pop hl ; $5697
	pop de ; $5698
	pop bc ; $5699
	pop af ; $569a
	ret ; $569b
InitRankingNameRender:
	farcall FarPtr_InitTextWindows ; $569c
	wram_bank $05 ; $569f
	ld a, $03 ; $56a5
	ld [$c3b3], a ; $56a7
	ld a, $00 ; $56aa
	ld [$c3b6], a ; $56ac
	farcall FarPtr_PrepareGlyphBuffer ; $56af
	ret ; $56b2
RenderPlayerNameFitted:
	call GetStringLength ; $56b3
	cp a, $06 ; $56b6
	jr nc, Label_1b_56be ; $56b8
	call DrawNameWithDiacritics ; $56ba
	ret ; $56bd
Label_1b_56be:
	call RenderNameTwoRows ; $56be
	ret ; $56c1
GetStringLength:
	push hl ; $56c2
	push bc ; $56c3
	ld c, $ff ; $56c4
Label_1b_56c6:
	inc c ; $56c6
	ld a, [hl+] ; $56c7
	or a, a ; $56c8
	jr nz, Label_1b_56c6 ; $56c9
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
	xor a, a ; $56f0
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
	ld a, [$d801] ; $5710
	or a, a ; $5713
	ret z ; $5714
	cp a, $01 ; $5715
	ret z ; $5717
	cp a, $02 ; $5718
	jr nz, Label_1b_5731 ; $571a
	ld b, $01 ; $571c
	call HighlightRankingRow ; $571e
	ld b, $02 ; $5721
	call HighlightRankingRow ; $5723
	ld b, $03 ; $5726
	call HighlightRankingRow ; $5728
	ld b, $04 ; $572b
	call HighlightRankingRow ; $572d
	ret ; $5730
Label_1b_5731:
	cp a, $03 ; $5731
	jr nz, Label_1b_574a ; $5733
	ld b, $05 ; $5735
	call HighlightRankingRow ; $5737
	ld b, $06 ; $573a
	call HighlightRankingRow ; $573c
	ld b, $07 ; $573f
	call HighlightRankingRow ; $5741
	ld b, $08 ; $5744
	call HighlightRankingRow ; $5746
	ret ; $5749
Label_1b_574a:
	ld b, $0b ; $574a
	call HighlightRankingRow ; $574c
	ret ; $574f
HighlightRankingRow:
	ld a, b ; $5750
	or a, a ; $5751
	ret z ; $5752
	add a, a ; $5753
	ld hl, $5761 ; $5754
	add a, l ; $5757
	ld l, a ; $5758
	jr nc, Label_1b_575c ; $5759
	inc h ; $575b
Label_1b_575c:
	ld a, [hl+] ; $575c
	ld h, [hl] ; $575d
	ld l, a ; $575e
	jp hl ; $575f
	ret ; $5760
	; $5761, 200 bytes (records:2)
	dw $5779 ; record 0
	dw $5779 ; record 1
	dw $5789 ; record 2
	dw $5799 ; record 3
	dw $57a9 ; record 4
	dw $57b9 ; record 5
	dw $57c9 ; record 6
	dw $57d9 ; record 7
	dw $57e9 ; record 8
	dw $57f9 ; record 9
	dw $5809 ; record 10
	dw $5819 ; record 11
	dw $4021 ; record 12
	dw $11d2 ; record 13
	dw $d026 ; record 14
	dw $0506 ; record 15
	dw $020e ; record 16
	dw $0adf ; record 17
	dw $c339 ; record 18
	dw $5760 ; record 19
	dw $8021 ; record 20
	dw $11d2 ; record 21
	dw $d146 ; record 22
	dw $0406 ; record 23
	dw $020e ; record 24
	dw $0adf ; record 25
	dw $c339 ; record 26
	dw $5760 ; record 27
	dw $4421 ; record 28
	dw $11d2 ; record 29
	dw $d02a ; record 30
	dw $0406 ; record 31
	dw $020e ; record 32
	dw $0adf ; record 33
	dw $c339 ; record 34
	dw $5760 ; record 35
	dw $8421 ; record 36
	dw $11d2 ; record 37
	dw $d14a ; record 38
	dw $0406 ; record 39
	dw $020e ; record 40
	dw $0adf ; record 41
	dw $c339 ; record 42
	dw $5760 ; record 43
	dw $c021 ; record 44
	dw $11d2 ; record 45
	dw $d026 ; record 46
	dw $0406 ; record 47
	dw $070e ; record 48
	dw $0adf ; record 49
	dw $c339 ; record 50
	dw $5760 ; record 51
	dw $c821 ; record 52
	dw $11d2 ; record 53
	dw $d146 ; record 54
	dw $0406 ; record 55
	dw $070e ; record 56
	dw $0adf ; record 57
	dw $c339 ; record 58
	dw $5760 ; record 59
	dw $c421 ; record 60
	dw $11d2 ; record 61
	dw $d02a ; record 62
	dw $0406 ; record 63
	dw $070e ; record 64
	dw $0adf ; record 65
	dw $c339 ; record 66
	dw $5760 ; record 67
	dw $cc21 ; record 68
	dw $11d2 ; record 69
	dw $d14a ; record 70
	dw $0406 ; record 71
	dw $070e ; record 72
	dw $0adf ; record 73
	dw $c339 ; record 74
	dw $5760 ; record 75
	dw $1421 ; record 76
	dw $11d0 ; record 77
	dw $d026 ; record 78
	dw $0406 ; record 79
	dw $100e ; record 80
	dw $0adf ; record 81
	dw $c339 ; record 82
	dw $5760 ; record 83
	dw $1821 ; record 84
	dw $11d0 ; record 85
	dw $d02a ; record 86
	dw $0406 ; record 87
	dw $100e ; record 88
	dw $0adf ; record 89
	dw $c339 ; record 90
	dw $5760 ; record 91
	dw $1421 ; record 92
	dw $11d0 ; record 93
	dw $d026 ; record 94
	dw $0806 ; record 95
	dw $100e ; record 96
	dw $0adf ; record 97
	dw $c339 ; record 98
	dw $5760 ; record 99
HighlightDoublesRankingRows:
	ld a, [$d801] ; $5829
	or a, a ; $582c
	ret z ; $582d
	cp a, $01 ; $582e
	ret z ; $5830
	cp a, $02 ; $5831
	jr nz, Label_1b_5840 ; $5833
	ld b, $01 ; $5835
	call HighlightDoublesRankingRow ; $5837
	ld b, $02 ; $583a
	call HighlightDoublesRankingRow ; $583c
	ret ; $583f
Label_1b_5840:
	ld b, $05 ; $5840
	call HighlightDoublesRankingRow ; $5842
	ret ; $5845
HighlightDoublesRankingRow:
	ld a, b ; $5846
	or a, a ; $5847
	ret z ; $5848
	add a, a ; $5849
	ld hl, $5857 ; $584a
	add a, l ; $584d
	ld l, a ; $584e
	jr nc, Label_1b_5852 ; $584f
	inc h ; $5851
Label_1b_5852:
	ld a, [hl+] ; $5852
	ld h, [hl] ; $5853
	ld l, a ; $5854
	jp hl ; $5855
	INCBIN "data/bank_01b/d_5856.bin" ; $5856, 987 bytes
ClearRankingMarkerSlots:
	ld hl, $d803 ; $5c31
	ld bc, $0030 ; $5c34
	call ClearBytes ; $5c37
	ret ; $5c3a
LoadRankingMarkerCoords:
	ld a, [$d800] ; $5c3b
	or a, a ; $5c3e
	jr nz, Label_1b_5c67 ; $5c3f
	ld hl, $5c8d ; $5c41
	ld a, [$d802] ; $5c44
	or a, a ; $5c47
	jr z, Label_1b_5c4d ; $5c48
	ld hl, $5d57 ; $5c4a
Label_1b_5c4d:
	ld a, [$d801] ; $5c4d
	add a, a ; $5c50
	add a, l ; $5c51
	ld l, a ; $5c52
	jr nc, Label_1b_5c56 ; $5c53
	inc h ; $5c55
Label_1b_5c56:
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
Label_1b_5c67:
	ld hl, $5e21 ; $5c67
	ld a, [$d802] ; $5c6a
	or a, a ; $5c6d
	jr z, Label_1b_5c73 ; $5c6e
	ld hl, $5eb9 ; $5c70
Label_1b_5c73:
	ld a, [$d801] ; $5c73
	add a, a ; $5c76
	add a, l ; $5c77
	ld l, a ; $5c78
	jr nc, Label_1b_5c7c ; $5c79
	inc h ; $5c7b
Label_1b_5c7c:
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
	; $5c8d, 708 bytes (records:2)
	dw $5c97 ; record 0
	dw $5c97 ; record 1
	dw $5cc7 ; record 2
	dw $5cf7 ; record 3
	dw $5d27 ; record 4
	dw $3400 ; record 5
	dw $000c ; record 6
	dw $3401 ; record 7
	dw $0024 ; record 8
	dw $3403 ; record 9
	dw $0038 ; record 10
	dw $3402 ; record 11
	dw $0054 ; record 12
	dw $3403 ; record 13
	dw $006c ; record 14
	dw $3400 ; record 15
	dw $0080 ; record 16
	dw $6b02 ; record 17
	dw $000c ; record 18
	dw $6b01 ; record 19
	dw $0024 ; record 20
	dw $6b00 ; record 21
	dw $0038 ; record 22
	dw $6b02 ; record 23
	dw $0054 ; record 24
	dw $6b03 ; record 25
	dw $006c ; record 26
	dw $6b00 ; record 27
	dw $0080 ; record 28
	dw $3c00 ; record 29
	dw $0018 ; record 30
	dw $3401 ; record 31
	dw $0024 ; record 32
	dw $3403 ; record 33
	dw $0038 ; record 34
	dw $3c02 ; record 35
	dw $0060 ; record 36
	dw $3403 ; record 37
	dw $006c ; record 38
	dw $3400 ; record 39
	dw $0080 ; record 40
	dw $6402 ; record 41
	dw $0018 ; record 42
	dw $6b01 ; record 43
	dw $0024 ; record 44
	dw $6b00 ; record 45
	dw $0038 ; record 46
	dw $6402 ; record 47
	dw $0060 ; record 48
	dw $6b03 ; record 49
	dw $006c ; record 50
	dw $6b00 ; record 51
	dw $0080 ; record 52
	dw $4400 ; record 53
	dw $0028 ; record 54
	dw $3401 ; record 55
	dw $0024 ; record 56
	dw $3403 ; record 57
	dw $0038 ; record 58
	dw $3c02 ; record 59
	dw $0060 ; record 60
	dw $3403 ; record 61
	dw $006c ; record 62
	dw $4400 ; record 63
	dw $0070 ; record 64
	dw $6402 ; record 65
	dw $0018 ; record 66
	dw $6b01 ; record 67
	dw $0024 ; record 68
	dw $5c00 ; record 69
	dw $0028 ; record 70
	dw $5c02 ; record 71
	dw $0070 ; record 72
	dw $6b03 ; record 73
	dw $006c ; record 74
	dw $6b00 ; record 75
	dw $0080 ; record 76
	dw $4c00 ; record 77
	dw $004c ; record 78
	dw $3401 ; record 79
	dw $0024 ; record 80
	dw $3403 ; record 81
	dw $0038 ; record 82
	dw $3c02 ; record 83
	dw $0060 ; record 84
	dw $3403 ; record 85
	dw $006c ; record 86
	dw $4400 ; record 87
	dw $0070 ; record 88
	dw $6402 ; record 89
	dw $0018 ; record 90
	dw $6b01 ; record 91
	dw $0024 ; record 92
	dw $5c00 ; record 93
	dw $0028 ; record 94
	dw $5402 ; record 95
	dw $004c ; record 96
	dw $6b03 ; record 97
	dw $006c ; record 98
	dw $6b00 ; record 99
	dw $0080 ; record 100
	dw $5d61 ; record 101
	dw $5d61 ; record 102
	dw $5d91 ; record 103
	dw $5dc1 ; record 104
	dw $5df1 ; record 105
	dw $3c00 ; record 106
	dw $000c ; record 107
	dw $3c01 ; record 108
	dw $0024 ; record 109
	dw $3403 ; record 110
	dw $0038 ; record 111
	dw $3402 ; record 112
	dw $0054 ; record 113
	dw $3403 ; record 114
	dw $006c ; record 115
	dw $3400 ; record 116
	dw $0080 ; record 117
	dw $6b02 ; record 118
	dw $000c ; record 119
	dw $6b01 ; record 120
	dw $0024 ; record 121
	dw $6b00 ; record 122
	dw $0038 ; record 123
	dw $6b02 ; record 124
	dw $0054 ; record 125
	dw $6b03 ; record 126
	dw $006c ; record 127
	dw $6b00 ; record 128
	dw $0080 ; record 129
	dw $4400 ; record 130
	dw $0018 ; record 131
	dw $3401 ; record 132
	dw $0024 ; record 133
	dw $4403 ; record 134
	dw $0038 ; record 135
	dw $3c02 ; record 136
	dw $0060 ; record 137
	dw $3403 ; record 138
	dw $006c ; record 139
	dw $3400 ; record 140
	dw $0080 ; record 141
	dw $6402 ; record 142
	dw $0018 ; record 143
	dw $6b01 ; record 144
	dw $0024 ; record 145
	dw $6b00 ; record 146
	dw $0038 ; record 147
	dw $6402 ; record 148
	dw $0060 ; record 149
	dw $6b03 ; record 150
	dw $006c ; record 151
	dw $6b00 ; record 152
	dw $0080 ; record 153
	dw $4c00 ; record 154
	dw $0028 ; record 155
	dw $3401 ; record 156
	dw $0024 ; record 157
	dw $3403 ; record 158
	dw $0038 ; record 159
	dw $3c02 ; record 160
	dw $0060 ; record 161
	dw $3403 ; record 162
	dw $006c ; record 163
	dw $4c00 ; record 164
	dw $0070 ; record 165
	dw $6402 ; record 166
	dw $0018 ; record 167
	dw $6b01 ; record 168
	dw $0024 ; record 169
	dw $5c00 ; record 170
	dw $0028 ; record 171
	dw $5c02 ; record 172
	dw $0070 ; record 173
	dw $6b03 ; record 174
	dw $006c ; record 175
	dw $6b00 ; record 176
	dw $0080 ; record 177
	dw $5000 ; record 178
	dw $004c ; record 179
	dw $3401 ; record 180
	dw $0024 ; record 181
	dw $3403 ; record 182
	dw $0038 ; record 183
	dw $3c02 ; record 184
	dw $0060 ; record 185
	dw $3403 ; record 186
	dw $006c ; record 187
	dw $4c00 ; record 188
	dw $0070 ; record 189
	dw $6402 ; record 190
	dw $0018 ; record 191
	dw $6b01 ; record 192
	dw $0024 ; record 193
	dw $5c00 ; record 194
	dw $0028 ; record 195
	dw $5002 ; record 196
	dw $004c ; record 197
	dw $6b03 ; record 198
	dw $006c ; record 199
	dw $6b00 ; record 200
	dw $0080 ; record 201
	dw $5e29 ; record 202
	dw $5e29 ; record 203
	dw $5e59 ; record 204
	dw $5e89 ; record 205
	dw $3400 ; record 206
	dw $001c ; record 207
	dw $3401 ; record 208
	dw $0044 ; record 209
	dw $3403 ; record 210
	dw $0070 ; record 211
	dw $6c02 ; record 212
	dw $001c ; record 213
	dw $6c03 ; record 214
	dw $0044 ; record 215
	dw $6c00 ; record 216
	dw $0070 ; record 217
	dw $ffff ; record 218
	dw $ffff ; record 219
	dw $ffff ; record 220
	dw $ffff ; record 221
	dw $ffff ; record 222
	dw $ffff ; record 223
	dw $ffff ; record 224
	dw $ffff ; record 225
	dw $ffff ; record 226
	dw $ffff ; record 227
	dw $ffff ; record 228
	dw $ffff ; record 229
	dw $3c00 ; record 230
	dw $0030 ; record 231
	dw $3401 ; record 232
	dw $0044 ; record 233
	dw $3403 ; record 234
	dw $0070 ; record 235
	dw $6402 ; record 236
	dw $0030 ; record 237
	dw $6c03 ; record 238
	dw $0044 ; record 239
	dw $6c00 ; record 240
	dw $0070 ; record 241
	dw $ffff ; record 242
	dw $ffff ; record 243
	dw $ffff ; record 244
	dw $ffff ; record 245
	dw $ffff ; record 246
	dw $ffff ; record 247
	dw $ffff ; record 248
	dw $ffff ; record 249
	dw $ffff ; record 250
	dw $ffff ; record 251
	dw $ffff ; record 252
	dw $ffff ; record 253
	dw $4400 ; record 254
	dw $004c ; record 255
	dw $3401 ; record 256
	dw $0044 ; record 257
	dw $3403 ; record 258
	dw $0070 ; record 259
	dw $5c02 ; record 260
	dw $004c ; record 261
	dw $6c03 ; record 262
	dw $0044 ; record 263
	dw $6c00 ; record 264
	dw $0070 ; record 265
	dw $ffff ; record 266
	dw $ffff ; record 267
	dw $ffff ; record 268
	dw $ffff ; record 269
	dw $ffff ; record 270
	dw $ffff ; record 271
	dw $ffff ; record 272
	dw $ffff ; record 273
	dw $ffff ; record 274
	dw $ffff ; record 275
	dw $ffff ; record 276
	dw $ffff ; record 277
	dw $5ec1 ; record 278
	dw $5ec1 ; record 279
	dw $5ef1 ; record 280
	dw $5f21 ; record 281
	dw $3c00 ; record 282
	dw $001c ; record 283
	dw $3c01 ; record 284
	dw $0044 ; record 285
	dw $3403 ; record 286
	dw $0070 ; record 287
	dw $6c02 ; record 288
	dw $001c ; record 289
	dw $6c03 ; record 290
	dw $0044 ; record 291
	dw $6c00 ; record 292
	dw $0070 ; record 293
	dw $ffff ; record 294
	dw $ffff ; record 295
	dw $ffff ; record 296
	dw $ffff ; record 297
	dw $ffff ; record 298
	dw $ffff ; record 299
	dw $ffff ; record 300
	dw $ffff ; record 301
	dw $ffff ; record 302
	dw $ffff ; record 303
	dw $ffff ; record 304
	dw $ffff ; record 305
	dw $4400 ; record 306
	dw $0030 ; record 307
	dw $3401 ; record 308
	dw $0044 ; record 309
	dw $4403 ; record 310
	dw $0070 ; record 311
	dw $6402 ; record 312
	dw $0030 ; record 313
	dw $6c03 ; record 314
	dw $0044 ; record 315
	dw $6c00 ; record 316
	dw $0070 ; record 317
	dw $ffff ; record 318
	dw $ffff ; record 319
	dw $ffff ; record 320
	dw $ffff ; record 321
	dw $ffff ; record 322
	dw $ffff ; record 323
	dw $ffff ; record 324
	dw $ffff ; record 325
	dw $ffff ; record 326
	dw $ffff ; record 327
	dw $ffff ; record 328
	dw $ffff ; record 329
	dw $4c00 ; record 330
	dw $004c ; record 331
	dw $3401 ; record 332
	dw $0044 ; record 333
	dw $3403 ; record 334
	dw $0070 ; record 335
	dw $5402 ; record 336
	dw $004c ; record 337
	dw $6c03 ; record 338
	dw $0044 ; record 339
	dw $6c00 ; record 340
	dw $0070 ; record 341
	dw $ffff ; record 342
	dw $ffff ; record 343
	dw $ffff ; record 344
	dw $ffff ; record 345
	dw $ffff ; record 346
	dw $ffff ; record 347
	dw $ffff ; record 348
	dw $ffff ; record 349
	dw $ffff ; record 350
	dw $ffff ; record 351
	dw $ffff ; record 352
	dw $ffff ; record 353
GetRankingMarkerSlot:
	push af ; $5f51
	ld a, c ; $5f52
	add a, a ; $5f53
	add a, a ; $5f54
	ld hl, $d803 ; $5f55
	add a, l ; $5f58
	ld l, a ; $5f59
	jr nc, Label_1b_5f5d ; $5f5a
	inc h ; $5f5c
Label_1b_5f5d:
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
	add a, b ; $5f6d
	ld [hl], a ; $5f6e
	pop af ; $5f6f
	pop hl ; $5f70
	ret ; $5f71
	push hl ; $5f72
	push af ; $5f73
	inc hl ; $5f74
	inc hl ; $5f75
	ld a, [hl] ; $5f76
	add a, b ; $5f77
	ld [hl], a ; $5f78
	pop af ; $5f79
	pop hl ; $5f7a
	ret ; $5f7b
	INCBIN "data/bank_01b/d_5f7c.bin" ; $5f7c, 70 bytes
	ld h, h ; $5fc2
	nop ; $5fc3
FindCharSelectRosterEntry:
	ld hl, $ce40 ; $5fc4
	farcall FarPtr_FindRosterEntry ; $5fc7
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
	ld hl, $5f7c ; $5fd4
	ld de, $c7a0 ; $5fd7
	ld bc, $0020 ; $5fda
	call CopyMemoryBC ; $5fdd
	ret ; $5fe0
LoadCharSelectRosterTable:
	ld hl, $5f9c ; $5fe1
	ld de, $ce40 ; $5fe4
	ld bc, $0080 ; $5fe7
	call CopyMemoryBC ; $5fea
	ret ; $5fed
LoadCharSelectScreenGfx:
	ld hl, $5f7c ; $5fee
	ld de, $d000 ; $5ff1
	call DecompressData ; $5ff4
	ld hl, $d000 ; $5ff7
	ld de, $b000 ; $5ffa
	ld c, $80 ; $5ffd
	call QueueVRAMCopy ; $5fff
	ld hl, $d800 ; $6002
	ld de, $a800 ; $6005
	ld c, $80 ; $6008
	call QueueVRAMCopy ; $600a
	ld hl, $5f7c ; $600d
	ld de, $dc00 ; $6010
	call DecompressData ; $6013
	ld hl, $5f7c ; $6016
	ld de, $d800 ; $6019
	call DecompressData ; $601c
	ld hl, $5f7c ; $601f
	ld de, $0008 ; $6022
	call LoadPaletteShadow ; $6025
	ret ; $6028
StartCharSelectCursorTask:
	farcall FarPtr_LoadCharSelectCursorGfx ; $6029
	ld a, $0a ; $602c
	ld hl, $6035 ; $602e
	call RegisterFrameTask ; $6031
	ret ; $6034
	ld a, [$c781] ; $6035
	ld de, $0004 ; $6038
	call GetCharSelectRosterField ; $603b
	ld a, [$c781] ; $603e
	farcall FarPtr_DrawCharSelectCursor ; $6041
	ret ; $6044
DrawCharSelectPrompt:
	ld hl, $d000 ; $6045
	ld de, $9000 ; $6048
	ld c, $10 ; $604b
	call QueueVRAMCopy ; $604d
	ld hl, $d9e0 ; $6050
	ld de, $dde0 ; $6053
	ld bc, $1403 ; $6056
	farcall FarPtr_DrawBox ; $6059
	ld hl, $0470 ; $605c
	ld a, [$cb00] ; $605f
	or a, a ; $6062
	jr z, Label_1b_6068 ; $6063
	ld hl, $047b ; $6065
Label_1b_6068:
	ld de, $da01 ; $6068
	farcall FarPtr_RenderProportionalTextAt32 ; $606b
	ret ; $606e
DrawCharSelectMugshots:
	farcall FarPtr_1b_0c ; $606f
	ld hl, $ce40 ; $6072
Label_1b_6075:
	ld a, [hl] ; $6075
	farcall FarPtr_18_24 ; $6076
	farcall FarPtr_18_26 ; $6079
	jr z, Label_1b_60a4 ; $607c
	ld a, [$d58b] ; $607e
	farcall FarPtr_LoadCharMugshotToBuffer ; $6081
	ld a, [hl] ; $6084
	ld de, $0002 ; $6085
	call GetCharSelectRosterField ; $6088
	farcall FarPtr_CopyMugshotBufferToVram ; $608b
	ld a, [hl] ; $608e
	ld de, $0006 ; $608f
	call GetCharSelectRosterField ; $6092
	ld a, [$d58b] ; $6095
	add a, a ; $6098
	add a, $c1 ; $6099
	ld c, a ; $609b
	adc a, $c7 ; $609c
	sub a, c ; $609e
	ld b, a ; $609f
	ld a, [bc] ; $60a0
	farcall FarPtr_SetMugshotAttrs ; $60a1
Label_1b_60a4:
	ld a, $08 ; $60a4
	add a, l ; $60a6
	ld l, a ; $60a7
	jr nc, Label_1b_60ab ; $60a8
	inc h ; $60aa
Label_1b_60ab:
	ld a, [hl] ; $60ab
	cp a, $ff ; $60ac
	jr nz, Label_1b_6075 ; $60ae
	ld a, [$c781] ; $60b0
	farcall FarPtr_18_24 ; $60b3
	ld a, [$d58b] ; $60b6
	farcall FarPtr_1b_12 ; $60b9
	ret ; $60bc
	and a, $01 ; $60bd
	ld [wTargetZoneX2], a ; $60bf
	call ClearFrameTasks ; $60c2
	call AdvanceFrame ; $60c5
	push de ; $60c8
	call LoadCharSelectNavGrid ; $60c9
	call LoadCharSelectRosterTable ; $60cc
	pop de ; $60cf
	ld a, d ; $60d0
	ld [$c783], a ; $60d1
	ld a, e ; $60d4
	ld [$c784], a ; $60d5
	farcall FarPtr_UpdateCharSelectSelection ; $60d8
	ld a, [$c781] ; $60db
	ld [$c782], a ; $60de
	ld c, $20 ; $60e1
	call BeginFadeOut ; $60e3
	call WaitFadeEnd ; $60e6
	call DisableLCDSafely ; $60e9
	call LoadCharSelectScreenGfx ; $60ec
	call DrawCharSelectMugshots ; $60ef
	call DrawCharSelectPrompt ; $60f2
	ld hl, $dc00 ; $60f5
	ld de, $b800 ; $60f8
	ld c, $24 ; $60fb
	call QueueVRAMCopy ; $60fd
	ld hl, $d800 ; $6100
	ld de, $9800 ; $6103
	ld c, $24 ; $6106
	call QueueVRAMCopy ; $6108
	call EnableLCD ; $610b
	ld c, $20 ; $610e
	call BeginFadeIn ; $6110
	call WaitFadeEnd ; $6113
	call StartCharSelectCursorTask ; $6116
Label_1b_6119:
	wram_bank $01 ; $6119
	ldh a, [hInputRisingEdge] ; $611f
	and a, $08 ; $6121
	jr z, Label_1b_6135 ; $6123
	ld a, [wTargetZoneX2] ; $6125
	ld b, a ; $6128
	ld a, [$c781] ; $6129
	farcall FarPtr_18_2c ; $612c
	sound $5f ; $612f
	ld a, $fe ; $6131
	jr Label_1b_6169 ; $6133
Label_1b_6135:
	ldh a, [hInputRisingEdge] ; $6135
	and a, $01 ; $6137
	jr z, Label_1b_614c ; $6139
	ld a, [wTargetZoneX2] ; $613b
	ld b, a ; $613e
	ld a, [$c781] ; $613f
	farcall FarPtr_18_2c ; $6142
	sound $5f ; $6145
	ld a, [$c781] ; $6147
	jr Label_1b_6169 ; $614a
Label_1b_614c:
	ldh a, [hInputRisingEdge] ; $614c
	and a, $02 ; $614e
	jr z, Label_1b_6158 ; $6150
	sound $62 ; $6152
	ld a, $ff ; $6154
	jr Label_1b_6169 ; $6156
Label_1b_6158:
	call MoveCharSelectCursor ; $6158
	call UpdateCharSelectSelection ; $615b
	ld a, [$c781] ; $615e
	farcall FarPtr_18_24 ; $6161
	call AdvanceFrame ; $6164
	jr Label_1b_6119 ; $6167
Label_1b_6169:
	ld hl, $c783 ; $6169
	ld d, [hl] ; $616c
	ld hl, $c784 ; $616d
	ld e, [hl] ; $6170
	ret ; $6171
UpdateCharSelectSelection:
	ld a, [$c781] ; $6172
	ld [$c782], a ; $6175
	ld a, [$c784] ; $6178
	add a, a ; $617b
	add a, a ; $617c
	add a, a ; $617d
	ld hl, $c783 ; $617e
	add a, [hl] ; $6181
	add a, $a0 ; $6182
	ld l, a ; $6184
	adc a, $c7 ; $6185
	sub a, l ; $6187
	ld h, a ; $6188
	ld a, [hl] ; $6189
	cp a, $ff ; $618a
Label_1b_618c:
	jr z, Label_1b_618c ; $618c
	ld [$c781], a ; $618e
	ret ; $6191
MoveCharSelectCursor:
	ldh a, [hInputPressed] ; $6192
	ld b, a ; $6194
	and a, $f0 ; $6195
	jr z, Label_1b_61b9 ; $6197
	sound $5e ; $6199
	ld a, [$c783] ; $619b
	ld d, a ; $619e
	ld a, [$c784] ; $619f
	ld e, a ; $61a2
Label_1b_61a3:
	ld hl, $c7a0 ; $61a3
	farcall FarPtr_MoveGridCursor ; $61a6
	farcall FarPtr_18_24 ; $61a9
	farcall FarPtr_18_26 ; $61ac
	jr z, Label_1b_61a3 ; $61af
	ld a, d ; $61b1
	ld [$c783], a ; $61b2
	ld a, e ; $61b5
	ld [$c784], a ; $61b6
Label_1b_61b9:
	ret ; $61b9
RunNewGameSetup:
	sound $03 ; $61ba
	farcall FarPtr_InitStoryModeState ; $61bc
	ld a, $00 ; $61bf
	farcall FarPtr_RollStoryRandomByte ; $61c1
	wram_bank $01 ; $61c4
	ld a, $01 ; $61ca
	ld [$c7be], a ; $61cc
	ld a, $01 ; $61cf
	ld [$c7bf], a ; $61d1
	ld hl, $c7c0 ; $61d4
	xor a, a ; $61d7
Label_1b_61d8:
	push af ; $61d8
	farcall FarPtr_18_24 ; $61d9
	ld a, [$d58e] ; $61dc
	ld [hl+], a ; $61df
	ld a, [$d58c] ; $61e0
	ld [hl+], a ; $61e3
	pop af ; $61e4
	inc a ; $61e5
	cp a, $04 ; $61e6
	jr nz, Label_1b_61d8 ; $61e8
	ld a, [$cb00] ; $61ea
	push af ; $61ed
	xor a, a ; $61ee
	ld [$cb00], a ; $61ef
Label_1b_61f2:
	ld a, [$c7be] ; $61f2
	ld d, a ; $61f5
	ld a, [$c7bf] ; $61f6
	ld e, a ; $61f9
	ld b, $00 ; $61fa
	farcall FarPtr_38_00 ; $61fc
	ld hl, $c7be ; $61ff
	ld [hl], d ; $6202
	ld hl, $c7bf ; $6203
	ld [hl], e ; $6206
	cp a, $ff ; $6207
	jr nz, Label_1b_6214 ; $6209
	pop af ; $620b
	ld [$cb00], a ; $620c
	ld a, $ff ; $620f
	jp Label_1b_62ef ; $6211
Label_1b_6214:
	cp a, $fe ; $6214
	jr nz, Label_1b_621a ; $6216
	jr Label_1b_61f2 ; $6218
Label_1b_621a:
	ld a, $01 ; $621a
	farcall FarPtr_RollStoryRandomByte ; $621c
	ld a, $00 ; $621f
	farcall FarPtr_PromptCharDataConfirm ; $6221
	and a, a ; $6224
	jr nz, Label_1b_61f2 ; $6225
	ld a, $02 ; $6227
	farcall FarPtr_RollStoryRandomByte ; $6229
Label_1b_622c:
	xor a, a ; $622c
	ld [$cb00], a ; $622d
	push af ; $6230
	ld hl, wStoryModeNameOfMainCharacter ; $6231
	ld a, [$cb00] ; $6234
	or a, a ; $6237
	jr z, Label_1b_623c ; $6238
	ld l, $40 ; $623a
Label_1b_623c:
	ld a, l ; $623c
	add a, $0b ; $623d
	ld l, a ; $623f
	ld a, h ; $6240
	adc a, $00 ; $6241
	ld h, a ; $6243
	pop af ; $6244
	ld c, [hl] ; $6245
	ld b, $00 ; $6246
	farcall FarPtr_RunNameEntryScreen ; $6248
	and a, a ; $624b
	jr nz, Label_1b_621a ; $624c
	pop af ; $624e
	ld [$cb00], a ; $624f
	ld a, [$cb00] ; $6252
	push af ; $6255
	ld a, $01 ; $6256
	ld [$cb00], a ; $6258
	ld de, $0120 ; $625b
	farcall FarPtr_TestSaveFlag ; $625e
	jr nz, Label_1b_6293 ; $6261
	push af ; $6263
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $6264
	inc a ; $6267
	inc a ; $6268
	ld d, a ; $6269
	ld a, [$cb00] ; $626a
	farcall FarPtr_InitPlayerRecordFromTemplate ; $626d
	push af ; $6270
	ld hl, wStoryModeNameOfMainCharacter ; $6271
	ld a, [$cb00] ; $6274
	or a, a ; $6277
	jr z, Label_1b_627c ; $6278
	ld l, $40 ; $627a
Label_1b_627c:
	ld a, l ; $627c
	add a, $0b ; $627d
	ld l, a ; $627f
	ld a, h ; $6280
	adc a, $00 ; $6281
	ld h, a ; $6283
	pop af ; $6284
	ld c, [hl] ; $6285
	ld b, $01 ; $6286
	farcall FarPtr_RunNameEntryScreen ; $6288
	ld b, a ; $628b
	pop af ; $628c
	ld a, b ; $628d
	and a, a ; $628e
	jr nz, Label_1b_622c ; $628f
	jr Label_1b_62df ; $6291
Label_1b_6293:
	ld a, [$c7be] ; $6293
	ld d, a ; $6296
	ld a, [$c7bf] ; $6297
	ld e, a ; $629a
	ld b, $01 ; $629b
	farcall FarPtr_38_00 ; $629d
	ld hl, $c7be ; $62a0
	ld [hl], d ; $62a3
	ld hl, $c7bf ; $62a4
	ld [hl], e ; $62a7
	cp a, $ff ; $62a8
	jr nz, Label_1b_62b3 ; $62aa
	pop af ; $62ac
	ld [$cb00], a ; $62ad
	jp RunNewGameSetup ; $62b0
Label_1b_62b3:
	cp a, $fe ; $62b3
	jr nz, Label_1b_62b9 ; $62b5
	jr Label_1b_6293 ; $62b7
Label_1b_62b9:
	ld a, $01 ; $62b9
	farcall FarPtr_PromptCharDataConfirm ; $62bb
	and a, a ; $62be
	jr nz, Label_1b_6293 ; $62bf
	push af ; $62c1
	ld hl, wStoryModeNameOfMainCharacter ; $62c2
	ld a, [$cb00] ; $62c5
	or a, a ; $62c8
	jr z, Label_1b_62cd ; $62c9
	ld l, $40 ; $62cb
Label_1b_62cd:
	ld a, l ; $62cd
	add a, $0b ; $62ce
	ld l, a ; $62d0
	ld a, h ; $62d1
	adc a, $00 ; $62d2
	ld h, a ; $62d4
	pop af ; $62d5
	ld c, [hl] ; $62d6
	ld b, $01 ; $62d7
	farcall FarPtr_RunNameEntryScreen ; $62d9
	and a, a ; $62dc
	jr nz, Label_1b_62b9 ; $62dd
Label_1b_62df:
	pop af ; $62df
	ld [$cb00], a ; $62e0
	ld hl, wStoryModeNameOfMainCharacter ; $62e3
	ld de, $c800 ; $62e6
	ld c, $08 ; $62e9
	call CopyMemoryFast ; $62eb
	xor a, a ; $62ee
Label_1b_62ef:
	ld c, $20 ; $62ef
	call BeginFadeOut ; $62f1
	call WaitFadeEnd ; $62f4
	ret ; $62f7
RunDebugSaveDataFlow:
	sound $03 ; $62f8
	ld a, $01 ; $62fa
	cp a, $ff ; $62fc
	jr z, RunDebugSaveDataFlow ; $62fe
	or a, a ; $6300
	jr z, Label_1b_632d ; $6301
	bit 7, a ; $6303
	jr z, RunDebugSaveDataFlow ; $6305
	and a, $3f ; $6307
	ld [$c36c], a ; $6309
	ld hl, $c800 ; $630c
	ld b, a ; $630f
	ld [$c36c], a ; $6310
	farcall FarPtr_CheckStorySlot ; $6313
	or a, a ; $6316
	jp z, Label_1b_6399 ; $6317
	call RunNewGameSetup ; $631a
	cp a, $ff ; $631d
	jp z, RunDebugSaveDataFlow ; $631f
	ld a, $01 ; $6322
	farcall FarPtr_EraseStorySlotSaveData ; $6324
	farcall FarPtr_SaveStorySlotWithTimer ; $6327
	jp Label_1b_6408 ; $632a
Label_1b_632d:
	sound $03 ; $632d
	call RunDebugSaveDataMenu ; $632f
	cp a, $ff ; $6332
	jr z, RunDebugSaveDataFlow ; $6334
	cp a, $01 ; $6336
	jp z, Label_1b_638e ; $6338
	cp a, $ff ; $633b
	jr z, Label_1b_632d ; $633d
	or a, a ; $633f
	jr nz, Label_1b_634c ; $6340
	or a, a ; $6342
	jr nz, Label_1b_632d ; $6343
	farcall FarPtr_ReinitSaveRamPreservingBlock6 ; $6345
	ld b, $01 ; $6348
	jr Label_1b_632d ; $634a
Label_1b_634c:
	and a, $3f ; $634c
	ld b, a ; $634e
	ld hl, $ca00 ; $634f
	ld [$c36c], a ; $6352
	farcall FarPtr_CheckStorySlot ; $6355
	or a, a ; $6358
	jr z, Label_1b_635f ; $6359
	sound $62 ; $635b
	jr Label_1b_632d ; $635d
Label_1b_635f:
	push bc ; $635f
	call Func_1b_69d6 ; $6360
	pop bc ; $6363
	or a, a ; $6364
	jr nz, Label_1b_632d ; $6365
	wram_bank $03 ; $6367
	ld hl, $ca00 ; $636d
	ld de, $d500 ; $6370
	ld c, $0b ; $6373
Label_1b_6375:
	ld a, [hl+] ; $6375
	push hl ; $6376
	ld h, d ; $6377
	ld l, e ; $6378
	ld [hl+], a ; $6379
	ld d, h ; $637a
	ld e, l ; $637b
	pop hl ; $637c
	dec c ; $637d
	jr nz, Label_1b_6375 ; $637e
	ld a, b ; $6380
	ld [$c36c], a ; $6381
	ld a, $00 ; $6384
	farcall FarPtr_EraseStorySlotSaveData ; $6386
	ld b, $01 ; $6389
	jp Label_1b_632d ; $638b
Label_1b_638e:
	ld a, $00 ; $638e
	ld [$cb1f], a ; $6390
	farcall FarPtr_RunMinigameFlagsDebugScreen ; $6393
	jp Label_1b_632d ; $6396
Label_1b_6399:
	call ClearFrameTasks ; $6399
	farcall FarPtr_ValidateN64TransferRecord ; $639c
	or a, a ; $639f
	jr z, Label_1b_6405 ; $63a0
	ld hl, $c9b0 ; $63a2
	ld a, [hl+] ; $63a5
	ld d, [hl] ; $63a6
	ld e, a ; $63a7
	or a, d ; $63a8
	jr z, Label_1b_63cb ; $63a9
	ldh a, [hWramBank] ; $63ab
	push af ; $63ad
	wram_bank $06 ; $63ae
	xor a, a ; $63b4
	ld [$d000], a ; $63b5
	pop af ; $63b8
	wram_bank ; $63b9
	ld h, $01 ; $63bd
	ld l, $00 ; $63bf
	ld a, $01 ; $63c1
	farcall FarPtr_ShowExpGainScreen ; $63c3
	ld c, $00 ; $63c6
	farcall FarPtr_1c_00 ; $63c8
Label_1b_63cb:
	ld hl, $c9b2 ; $63cb
	ld a, [hl+] ; $63ce
	ld d, [hl] ; $63cf
	ld e, a ; $63d0
	or a, d ; $63d1
	jr z, Label_1b_63f4 ; $63d2
	ldh a, [hWramBank] ; $63d4
	push af ; $63d6
	wram_bank $06 ; $63d7
	xor a, a ; $63dd
	ld [$d000], a ; $63de
	pop af ; $63e1
	wram_bank ; $63e2
	ld h, $01 ; $63e6
	ld l, $01 ; $63e8
	ld a, $01 ; $63ea
	farcall FarPtr_ShowExpGainScreen ; $63ec
	ld c, $01 ; $63ef
	farcall FarPtr_1c_00 ; $63f1
Label_1b_63f4:
	xor a, a ; $63f4
	ld hl, $c9b0 ; $63f5
	ld [hl+], a ; $63f8
	ld [hl+], a ; $63f9
	ld [hl+], a ; $63fa
	ld [hl+], a ; $63fb
	ld [hl+], a ; $63fc
	inc hl ; $63fd
	inc hl ; $63fe
	ld [hl+], a ; $63ff
	farcall FarPtr_SaveStorySlotWithTimer ; $6400
	jr Label_1b_6408 ; $6403
Label_1b_6405:
	farcall FarPtr_ShowNoN64DataFoundScreen ; $6405
Label_1b_6408:
	call RunLevelUpStatusTrophiesMenu ; $6408
	cp a, $ff ; $640b
	jp z, RunDebugSaveDataFlow ; $640d
	cp a, $01 ; $6410
	jr z, Label_1b_645a ; $6412
	cp a, $02 ; $6414
	jr z, Label_1b_6460 ; $6416
	push af ; $6418
	push bc ; $6419
	push de ; $641a
	push hl ; $641b
	farcall FarPtr_ClearDrillResultBuffer ; $641c
	ld b, $00 ; $641f
	ld c, $00 ; $6421
	ld de, $0040 ; $6423
	farcall FarPtr_RecordDrillResult ; $6426
	ld b, $04 ; $6429
	ld c, $01 ; $642b
	ld de, $0077 ; $642d
	farcall FarPtr_RecordDrillResult ; $6430
	ld c, $01 ; $6433
	farcall FarPtr_ShowMatchResultsScreen ; $6435
	farcall FarPtr_1d_06 ; $6438
	pop hl ; $643b
	pop de ; $643c
	pop bc ; $643d
	pop af ; $643e
	set_flag $03, 4 ; $643f
	ld c, $00 ; $6442
	farcall FarPtr_1c_00 ; $6444
	clear_flag $03, 4 ; $6447
	set_flag $03, 4 ; $644a
	ld c, $01 ; $644d
	farcall FarPtr_1c_00 ; $644f
	clear_flag $03, 4 ; $6452
	farcall FarPtr_SaveStorySlotWithTimer ; $6455
	jr Label_1b_6408 ; $6458
Label_1b_645a:
	farcall FarPtr_ShowCharDataScreen ; $645a
	jp Label_1b_6408 ; $645d
Label_1b_6460:
	call ShowTrophiesPlaceholderScreen ; $6460
	jp Label_1b_6408 ; $6463
	ret ; $6466
RunLevelUpStatusTrophiesMenu:
	push bc ; $6467
	push de ; $6468
	push hl ; $6469
	ldh a, [hWramBank] ; $646a
	push af ; $646c
	call ClearFrameTasks ; $646d
	call DisableLCDSafely ; $6470
	farcall FarPtr_01_0a ; $6473
	call DisableLCDSafely ; $6476
	farcall FarPtr_ResetTextWindowState ; $6479
	call ClearScreenMaps ; $647c
	wram_bank $05 ; $647f
	ld d, $02 ; $6485
	ld e, $02 ; $6487
	ld hl, $047c ; $6489
	farcall FarPtr_CreateMenuWindowFromText ; $648c
	farcall FarPtr_RestoreShadowTilemap ; $648f
	farcall FarPtr_RenderMenuWindowText ; $6492
	ld c, $20 ; $6495
	call BeginFadeIn ; $6497
	call WaitFadeEnd ; $649a
	farcall FarPtr_RunMenuSelection ; $649d
	ld b, a ; $64a0
	ld c, $20 ; $64a1
	call BeginFadeOut ; $64a3
	call WaitFadeEnd ; $64a6
	ld a, [$d82f] ; $64a9
	farcall FarPtr_CloseWindow ; $64ac
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
	farcall FarPtr_01_0a ; $64c5
	call EnableLCD ; $64c8
	farcall FarPtr_ResetTextWindowState ; $64cb
	call ClearScreenMaps ; $64ce
	call ReadUnlockFlagsSaveBlock ; $64d1
	wram_bank $06 ; $64d4
	ld hl, $d400 ; $64da
	ld a, [hl+] ; $64dd
	ld d, [hl] ; $64de
	ld e, a ; $64df
	ld hl, $047d ; $64e0
	or a, d ; $64e3
	jr nz, Label_1b_64e7 ; $64e4
	inc hl ; $64e6
Label_1b_64e7:
	wram_bank $05 ; $64e7
	ld d, $02 ; $64ed
	ld e, $02 ; $64ef
	farcall FarPtr_CreateMenuWindowFromText ; $64f1
	farcall FarPtr_RestoreShadowTilemap ; $64f4
	farcall FarPtr_RenderMenuWindowText ; $64f7
	ld c, $20 ; $64fa
	call BeginFadeIn ; $64fc
	call WaitFadeEnd ; $64ff
	farcall FarPtr_RunMenuSelection ; $6502
	ld b, a ; $6505
	ld c, $20 ; $6506
	call BeginFadeOut ; $6508
	call WaitFadeEnd ; $650b
	ld a, [$d82f] ; $650e
	farcall FarPtr_CloseWindow ; $6511
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
	ld hl, $d000 ; $653a
	ld bc, $0500 ; $653d
	call FillBytesWithValue ; $6540
	wram_bank $03 ; $6543
	ld hl, $d000 ; $6549
	ld de, $9800 ; $654c
	ld c, $24 ; $654f
	call QueueVRAMCopy ; $6551
	wram_bank $02 ; $6554
	ld hl, $d000 ; $655a
	ld de, $b800 ; $655d
	ld c, $24 ; $6560
	call QueueVRAMCopy ; $6562
	call EnableLCD ; $6565
	ret ; $6568
FillBytesWithValue:
	ld e, a ; $6569
Label_1b_656a:
	ld [hl], e ; $656a
	inc hl ; $656b
	dec bc ; $656c
	ld a, c ; $656d
	or a, b ; $656e
	jr nz, Label_1b_656a ; $656f
	ret ; $6571
	INCBIN "data/bank_01b/d_6572.bin" ; $6572, 120 bytes
FindUnlockDebugRosterEntry:
	ld hl, $ce40 ; $65ea
	farcall FarPtr_FindRosterEntry ; $65ed
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
	ld hl, $6572 ; $65fa
	ld de, $c7a0 ; $65fd
	ld bc, $0020 ; $6600
	call CopyMemoryBC ; $6603
	ret ; $6606
	db $0b ; $6607
	db $0c ; $6608
LoadUnlockDebugRosterTable:
	ld hl, $6592 ; $6609
	ld de, $ce40 ; $660c
	ld bc, $0080 ; $660f
	call CopyMemoryBC ; $6612
	ret ; $6615
	db $08 ; $6616
	db $09 ; $6617
LoadUnlockDebugScreenGfx:
	ld hl, $d000 ; $6618
	ld de, $b000 ; $661b
	ld c, $80 ; $661e
	call QueueVRAMCopy ; $6620
	ld hl, $d800 ; $6623
	ld de, $a800 ; $6626
	ld c, $80 ; $6629
	call QueueVRAMCopy ; $662b
	ld hl, $6572 ; $662e
	ld de, $dc00 ; $6631
	call DecompressData ; $6634
	ld hl, $6572 ; $6637
	ld de, $d800 ; $663a
	call DecompressData ; $663d
	ld hl, $6572 ; $6640
	ld de, $0008 ; $6643
	call LoadPaletteShadow ; $6646
	ret ; $6649
Func_1b_664a:
	ret ; $664a
	ld hl, $6572 ; $664b
	ld de, $d000 ; $664e
	call DecompressData ; $6651
	ld hl, $d000 ; $6654
	ld de, $8500 ; $6657
	ld c, $28 ; $665a
	call QueueVRAMCopy ; $665c
	ld hl, $6572 ; $665f
	ld de, $0801 ; $6662
	call LoadPaletteShadow ; $6665
	ld a, $0a ; $6668
	ld hl, $6671 ; $666a
	call RegisterFrameTask ; $666d
	ret ; $6670
	ld de, $2cfa ; $6671
	farcall FarPtr_ApplySpriteBobOffset_18 ; $6674
	ld hl, $6572 ; $6677
	ld bc, $0050 ; $667a
	call QueueSpriteTemplate ; $667d
	ret ; $6680
StartUnlockDebugCursorTask:
	farcall FarPtr_LoadCharSelectCursorGfx ; $6681
	ld a, $0a ; $6684
	ld hl, $668d ; $6686
	call RegisterFrameTask ; $6689
	ret ; $668c
	ld a, [$c781] ; $668d
	ld de, $0004 ; $6690
	call GetUnlockDebugRosterField ; $6693
	ld a, [$c781] ; $6696
	farcall FarPtr_DrawCharSelectCursor ; $6699
	ret ; $669c
UpdateUnlockDebugSelectedMugshot:
	ld a, [$c781] ; $669d
	push af ; $66a0
	ld de, $0006 ; $66a1
	call GetUnlockDebugRosterField ; $66a4
	pop af ; $66a7
	ld b, a ; $66a8
	push bc ; $66a9
	farcall FarPtr_CheckUnlockFlag ; $66aa
	pop bc ; $66ad
	ld a, b ; $66ae
	jr z, Label_1b_66b6 ; $66af
	farcall FarPtr_18_24 ; $66b1
	jr Label_1b_66bb ; $66b4
Label_1b_66b6:
	ld a, $20 ; $66b6
	ld [$d58b], a ; $66b8
Label_1b_66bb:
	ld a, $0a ; $66bb
	ld hl, $66c4 ; $66bd
	call RegisterFrameTask ; $66c0
	ret ; $66c3
	ld hl, $c781 ; $66c4
	ld a, [$c782] ; $66c7
	cp a, [hl] ; $66ca
	jr z, Label_1b_66d6 ; $66cb
	ld a, [$c781] ; $66cd
	ld de, $0006 ; $66d0
	call GetUnlockDebugRosterField ; $66d3
Label_1b_66d6:
	ret ; $66d6
DrawUnlockDebugMugshots:
	farcall FarPtr_1b_0c ; $66d7
	ld hl, $ce40 ; $66da
Label_1b_66dd:
	ld a, [hl] ; $66dd
	farcall FarPtr_18_24 ; $66de
	farcall FarPtr_CheckUnlockFlag ; $66e1
	jr z, Label_1b_6703 ; $66e4
	ld a, [$d58b] ; $66e6
	farcall FarPtr_LoadCharMugshotToBuffer ; $66e9
	ld a, [hl] ; $66ec
	ld de, $0002 ; $66ed
	call GetUnlockDebugRosterField ; $66f0
	farcall FarPtr_CopyMugshotBufferToVram ; $66f3
	ld a, [hl] ; $66f6
	ld de, $0006 ; $66f7
	call GetUnlockDebugRosterField ; $66fa
	ld a, [$d58c] ; $66fd
	farcall FarPtr_SetMugshotAttrs ; $6700
Label_1b_6703:
	ld a, $08 ; $6703
	add a, l ; $6705
	ld l, a ; $6706
	jr nc, Label_1b_670a ; $6707
	inc h ; $6709
Label_1b_670a:
	ld a, [hl] ; $670a
	cp a, $ff ; $670b
	jr nz, Label_1b_66dd ; $670d
	ld a, [$c781] ; $670f
	farcall FarPtr_18_24 ; $6712
	ld a, [$d58b] ; $6715
	farcall FarPtr_1b_12 ; $6718
	ret ; $671b
RunMinigameFlagsDebugScreen:
	wram_bank $01 ; $671c
	call ClearFrameTasks ; $6722
	call LoadUnlockDebugNavGrid ; $6725
	call LoadUnlockDebugRosterTable ; $6728
	ld hl, $cb1f ; $672b
	call UpdateUnlockDebugSelection ; $672e
	ld a, [$c781] ; $6731
	ld [$c782], a ; $6734
	call ReadUnlockFlagsSaveBlock ; $6737
	ld c, $20 ; $673a
	call BeginFadeOut ; $673c
	call WaitFadeEnd ; $673f
	call DisableLCDSafely ; $6742
	call Func_1b_664a ; $6745
	call StartUnlockDebugCursorTask ; $6748
	call LoadUnlockDebugScreenGfx ; $674b
	call DrawUnlockDebugMugshots ; $674e
	call UpdateUnlockDebugSelectedMugshot ; $6751
	ld hl, $dc00 ; $6754
	ld de, $b800 ; $6757
	ld c, $24 ; $675a
	call QueueVRAMCopy ; $675c
	ld hl, $d800 ; $675f
	ld de, $9800 ; $6762
	ld c, $24 ; $6765
	call QueueVRAMCopy ; $6767
	call LoadUnlockDebugCursorGfx ; $676a
	call EnableLCD ; $676d
	ld c, $20 ; $6770
	call BeginFadeIn ; $6772
	call WaitFadeEnd ; $6775
Label_1b_6778:
	wram_bank $01 ; $6778
	ldh a, [hInputRisingEdge] ; $677e
	and a, $01 ; $6780
	jr z, Label_1b_679d ; $6782
	ld a, [$c781] ; $6784
	ld b, a ; $6787
	push bc ; $6788
	farcall FarPtr_CheckUnlockFlag ; $6789
	pop bc ; $678c
	ld a, b ; $678d
	jr z, Label_1b_6792 ; $678e
	jr Label_1b_6796 ; $6790
Label_1b_6792:
	sound $62 ; $6792
	jr Label_1b_6778 ; $6794
Label_1b_6796:
	sound $5f ; $6796
	ld hl, $cb1f ; $6798
	jr Label_1b_67c6 ; $679b
Label_1b_679d:
	ldh a, [hInputRisingEdge] ; $679d
	and a, $02 ; $679f
	jr z, Label_1b_67af ; $67a1
	sound $62 ; $67a3
	ld hl, $cb1f ; $67a5
	ld a, $00 ; $67a8
	ld [hl], a ; $67aa
	ld a, $ff ; $67ab
	jr Label_1b_67c6 ; $67ad
Label_1b_67af:
	ldh a, [hInputRisingEdge] ; $67af
	and a, $08 ; $67b1
	jr z, Label_1b_67b8 ; $67b3
	call ToggleSelectedUnlockFlag ; $67b5
Label_1b_67b8:
	call MoveUnlockDebugCursor ; $67b8
	call UpdateUnlockDebugSelection ; $67bb
	ld a, [$c781] ; $67be
	call AdvanceFrame ; $67c1
	jr Label_1b_6778 ; $67c4
Label_1b_67c6:
	ld c, $08 ; $67c6
	call BeginFadeOut ; $67c8
	call WaitFadeEnd ; $67cb
	call WriteUnlockFlagsSaveBlock ; $67ce
	call AdvanceFrame ; $67d1
	call AdvanceFrame ; $67d4
	ret ; $67d7
UpdateUnlockDebugSelection:
	ld a, [$c781] ; $67d8
	ld [$c782], a ; $67db
	ld a, [$c784] ; $67de
	add a, a ; $67e1
	add a, a ; $67e2
	add a, a ; $67e3
	ld hl, $c783 ; $67e4
	add a, [hl] ; $67e7
	add a, $a0 ; $67e8
	ld l, a ; $67ea
	adc a, $c7 ; $67eb
	sub a, l ; $67ed
	ld h, a ; $67ee
	ld a, [hl] ; $67ef
	ld [$c781], a ; $67f0
	ret ; $67f3
MoveUnlockDebugCursor:
	ldh a, [hInputPressed] ; $67f4
	ld b, a ; $67f6
	and a, $f0 ; $67f7
	jr z, Label_1b_6826 ; $67f9
	sound $5e ; $67fb
	ld a, [$c783] ; $67fd
	ld d, a ; $6800
	ld a, [$c784] ; $6801
	ld e, a ; $6804
	ld hl, $c7a0 ; $6805
	call StepUnlockDebugCursor ; $6808
	ld b, a ; $680b
	push bc ; $680c
	farcall FarPtr_CheckUnlockFlag ; $680d
	pop bc ; $6810
	ld a, b ; $6811
	jr z, Label_1b_6819 ; $6812
	farcall FarPtr_18_24 ; $6814
	jr Label_1b_681e ; $6817
Label_1b_6819:
	ld a, $20 ; $6819
	ld [$d58b], a ; $681b
Label_1b_681e:
	ld a, d ; $681e
	ld [$c783], a ; $681f
	ld a, e ; $6822
	ld [$c784], a ; $6823
Label_1b_6826:
	ret ; $6826
StepUnlockDebugCursor:
	bit 5, b ; $6827
	jr z, Label_1b_682e ; $6829
	dec d ; $682b
	jr Label_1b_6841 ; $682c
Label_1b_682e:
	bit 4, b ; $682e
	jr z, Label_1b_6835 ; $6830
	inc d ; $6832
	jr Label_1b_6841 ; $6833
Label_1b_6835:
	bit 6, b ; $6835
	jr z, Label_1b_683c ; $6837
	dec e ; $6839
	jr Label_1b_6841 ; $683a
Label_1b_683c:
	bit 7, b ; $683c
	jr z, Label_1b_6841 ; $683e
	inc e ; $6840
Label_1b_6841:
	ld a, d ; $6841
	add a, a ; $6842
	jr nc, Label_1b_684a ; $6843
	ld a, $05 ; $6845
	dec a ; $6847
	jr Label_1b_6850 ; $6848
Label_1b_684a:
	rra ; $684a
	cp a, $05 ; $684b
	jr c, Label_1b_6850 ; $684d
	xor a, a ; $684f
Label_1b_6850:
	ld d, a ; $6850
	ld a, e ; $6851
	add a, a ; $6852
	jr nc, Label_1b_685a ; $6853
	ld a, $02 ; $6855
	dec a ; $6857
	jr Label_1b_6860 ; $6858
Label_1b_685a:
	rra ; $685a
	cp a, $02 ; $685b
	jr c, Label_1b_6860 ; $685d
	xor a, a ; $685f
Label_1b_6860:
	ld e, a ; $6860
	ld a, e ; $6861
	add a, a ; $6862
	add a, a ; $6863
	add a, a ; $6864
	add a, d ; $6865
	push hl ; $6866
	add a, l ; $6867
	ld l, a ; $6868
	jr nc, Label_1b_686c ; $6869
	inc h ; $686b
Label_1b_686c:
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
	farcall FarPtr_ReadSaveBlock ; $687e
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
	farcall FarPtr_WriteSaveBlock ; $689b
	pop af ; $689e
	wram_bank ; $689f
	ret ; $68a3
ToggleSelectedUnlockFlag:
	ldh a, [hWramBank] ; $68a4
	push af ; $68a6
	wram_bank $06 ; $68a7
	ld hl, $d400 ; $68ad
	ld a, [$c781] ; $68b0
	cp a, $1a ; $68b3
	jr c, Label_1b_68ce ; $68b5
	cp a, $20 ; $68b7
	jr nc, Label_1b_68ce ; $68b9
	sub a, $18 ; $68bb
	add a, l ; $68bd
	ld l, a ; $68be
	jr nc, Label_1b_68c2 ; $68bf
	inc h ; $68c1
Label_1b_68c2:
	ld a, [hl] ; $68c2
	xor a, $01 ; $68c3
	ld [hl], a ; $68c5
	sound $5f ; $68c6
	pop af ; $68c8
	wram_bank ; $68c9
	ret ; $68cd
Label_1b_68ce:
	sound $62 ; $68ce
	pop af ; $68d0
	wram_bank ; $68d1
	ret ; $68d5
LoadUnlockDebugCursorGfx:
	ldh a, [hWramBank] ; $68d6
	push af ; $68d8
	wram_bank $01 ; $68d9
	ld hl, $690a ; $68df
	ld de, $d000 ; $68e2
	call DecompressData ; $68e5
	ld hl, $d000 ; $68e8
	ld de, $8500 ; $68eb
	ld c, $02 ; $68ee
	call QueueVRAMCopy ; $68f0
	pop af ; $68f3
	wram_bank ; $68f4
	ld hl, $6930 ; $68f8
	ld de, $0801 ; $68fb
	call LoadPaletteShadow ; $68fe
	ld a, $01 ; $6901
	ld hl, $6938 ; $6903
	call RegisterFrameTask ; $6906
	ret ; $6909
	INCBIN "data/bank_01b/d_690a.bin" ; $690a, 120 bytes
Func_1b_6982:
	wram_bank $01 ; $6982
	ld c, $20 ; $6988
	call BeginFadeOut ; $698a
	call WaitFadeEnd ; $698d
	call DisableLCDSafely ; $6990
	xor a, a ; $6993
	ld [$c7bc], a ; $6994
	ld [$c7c8], a ; $6997
	farcall FarPtr_ForceFlushBgMapToVram ; $699a
	call EnableLCD ; $699d
	ld c, $20 ; $69a0
	call BeginFadeIn ; $69a2
	call WaitFadeEnd ; $69a5
	wram_bank $07 ; $69a8
	xor a, a ; $69ae
	ld [$db26], a ; $69af
	ld a, $0c ; $69b2
	ld [$db27], a ; $69b4
	ld a, $01 ; $69b7
	ld hl, $69d6 ; $69b9
	call RegisterFrameTask ; $69bc
	ld b, $01 ; $69bf
	farcall FarPtr_18_34 ; $69c1
	push af ; $69c4
	ld hl, $69d6 ; $69c5
	call UnregisterFrameTask ; $69c8
	pop af ; $69cb
	ret ; $69cc
	INCBIN "data/bank_01b/d_69cd.bin" ; $69cd, 9 bytes
Func_1b_69d6:
	ret ; $69d6
	ret ; $69d7
	ret ; $69d8
	ld hl, $c7bc ; $69d9
	ld [hl], $01 ; $69dc
	wram_bank $01 ; $69de
	ld c, $20 ; $69e4
	call BeginFadeOut ; $69e6
	call WaitFadeEnd ; $69e9
	call DisableLCDSafely ; $69ec
	farcall FarPtr_18_36 ; $69ef
	call Func_1b_6aad ; $69f2
	farcall FarPtr_ForceFlushBgMapToVram ; $69f5
	call EnableLCD ; $69f8
	ld c, $20 ; $69fb
	call BeginFadeIn ; $69fd
	call WaitFadeEnd ; $6a00
Label_1b_6a03:
	and a, a ; $6a03
	jr nz, Label_1b_6a03 ; $6a04
	ld b, $00 ; $6a06
	farcall FarPtr_18_3c ; $6a08
	call AdvanceFrame ; $6a0b
	ret ; $6a0e
	ld hl, $ca00 ; $6a0f
	farcall FarPtr_PushTextArgString ; $6a12
	ld de, $d9c1 ; $6a15
	call CopyMainCharNameWithDiacritics ; $6a18
	ld hl, $046a ; $6a1b
	farcall FarPtr_RenderProportionalTextAt32 ; $6a1e
	farcall FarPtr_18_40 ; $6a21
	ret ; $6a24
	ld hl, $046d ; $6a25
	ld de, $d9c1 ; $6a28
	farcall FarPtr_RenderProportionalTextAt32 ; $6a2b
	farcall FarPtr_18_40 ; $6a2e
	ret ; $6a31
	ld hl, $046b ; $6a32
	ld de, $d9c1 ; $6a35
	farcall FarPtr_RenderProportionalTextAt32 ; $6a38
	farcall FarPtr_18_40 ; $6a3b
	ret ; $6a3e
	ld hl, $0471 ; $6a3f
	ld de, $d9c1 ; $6a42
	farcall FarPtr_RenderProportionalTextAt32 ; $6a45
	farcall FarPtr_18_40 ; $6a48
	ret ; $6a4b
	ld hl, $0162 ; $6a4c
	ld de, $d9c1 ; $6a4f
	farcall FarPtr_RenderProportionalTextAt32 ; $6a52
	ld hl, $0162 ; $6a55
	ld de, $da01 ; $6a58
	farcall FarPtr_RenderProportionalTextAt32 ; $6a5b
	ret ; $6a5e
	ld a, [$c0f3] ; $6a5f
	ld h, $00 ; $6a62
	ld l, a ; $6a64
	ld a, $02 ; $6a65
	ld de, $da05 ; $6a67
	farcall FarPtr_DrawDecimalNumberToTilemap ; $6a6a
	ld a, [$c0f2] ; $6a6d
	add a, $64 ; $6a70
	ld h, $00 ; $6a72
	ld l, a ; $6a74
	ld a, $03 ; $6a75
	ld de, $da07 ; $6a77
	farcall FarPtr_DrawDecimalNumberToTilemap ; $6a7a
	ld a, [$c0f1] ; $6a7d
	add a, $64 ; $6a80
	ld h, $00 ; $6a82
	ld l, a ; $6a84
	ld a, $03 ; $6a85
	ld de, $da0a ; $6a87
	farcall FarPtr_DrawDecimalNumberToTilemap ; $6a8a
	ld a, $3a ; $6a8d
	ld de, $da07 ; $6a8f
	farcall FarPtr_WriteTilemapByteAdvance ; $6a92
	ld a, $3a ; $6a95
	ld de, $da0a ; $6a97
	farcall FarPtr_WriteTilemapByteAdvance ; $6a9a
	call Func_1b_6aa1 ; $6a9d
	ret ; $6aa0
Func_1b_6aa1:
	ld hl, $da00 ; $6aa1
	ld de, $9a00 ; $6aa4
	ld c, $01 ; $6aa7
	call QueueVRAMCopy ; $6aa9
	ret ; $6aac
Func_1b_6aad:
	ret ; $6aad
CopyMainCharNameWithDiacritics:
	push de ; $6aae
	ld hl, wStoryModeNameOfMainCharacter ; $6aaf
	pop de ; $6ab2
Label_1b_6ab3:
	ld a, [hl+] ; $6ab3
	and a, a ; $6ab4
	jr z, Label_1b_6add ; $6ab5
	cp a, $de ; $6ab7
	jr z, Label_1b_6ac5 ; $6ab9
	cp a, $df ; $6abb
	jr z, Label_1b_6ad1 ; $6abd
	ld b, a ; $6abf
	ld a, b ; $6ac0
	ld [de], a ; $6ac1
	inc de ; $6ac2
	jr Label_1b_6ab3 ; $6ac3
Label_1b_6ac5:
	push de ; $6ac5
	push hl ; $6ac6
	ld hl, $ffdf ; $6ac7
	add hl, de ; $6aca
	ld [hl], $0e ; $6acb
	pop hl ; $6acd
	pop de ; $6ace
	jr Label_1b_6ab3 ; $6acf
Label_1b_6ad1:
	push de ; $6ad1
	push hl ; $6ad2
	ld hl, $ffdf ; $6ad3
	add hl, de ; $6ad6
	ld [hl], $0f ; $6ad7
	pop hl ; $6ad9
	pop de ; $6ada
	jr Label_1b_6ab3 ; $6adb
Label_1b_6add:
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
	farcall FarPtr_RenderProportionalTextAt32 ; $6b35
	ld hl, $047c ; $6b38
	ld de, $d8c3 ; $6b3b
	farcall FarPtr_RenderProportionalTextAt32 ; $6b3e
	farcall FarPtr_ForceFlushBgMapToVram ; $6b41
	call EnableLCD ; $6b44
	ld c, $20 ; $6b47
	call BeginFadeIn ; $6b49
	call WaitFadeEnd ; $6b4c
Label_1b_6b4f:
	ldh a, [hInputRisingEdge] ; $6b4f
	and a, $03 ; $6b51
	jr nz, Label_1b_6b5a ; $6b53
	call AdvanceFrame ; $6b55
	jr Label_1b_6b4f ; $6b58
Label_1b_6b5a:
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
	farcall FarPtr_ForceFlushBgMapToVram ; $6b80
	call EnableLCD ; $6b83
	ld c, $20 ; $6b86
	call BeginFadeIn ; $6b88
	call WaitFadeEnd ; $6b8b
Label_1b_6b8e:
	ldh a, [hInputRisingEdge] ; $6b8e
	and a, $03 ; $6b90
	jr nz, Label_1b_6b99 ; $6b92
	call AdvanceFrame ; $6b94
	jr Label_1b_6b8e ; $6b97
Label_1b_6b99:
	sound $5f ; $6b99
	ret ; $6b9b
RunMinigameLevelSelect:
	ldh a, [hWramBank] ; $6b9c
	push af ; $6b9e
	wram_bank $02 ; $6b9f
	ld a, c ; $6ba5
	ld [$d000], a ; $6ba6
	xor a, a ; $6ba9
	ld [$d001], a ; $6baa
	call CountClearedMinigameLevels ; $6bad
	call LoadMinigameLevelSelectGfx ; $6bb0
	ld a, [$d001] ; $6bb3
	cp a, $02 ; $6bb6
	jr z, Label_1b_6bbf ; $6bb8
	call RunMinigameLevelSelect2 ; $6bba
	jr Label_1b_6bc2 ; $6bbd
Label_1b_6bbf:
	call RunMinigameLevelSelect3 ; $6bbf
Label_1b_6bc2:
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
	add a, a ; $6bd8
	ld hl, $6c11 ; $6bd9
	add a, l ; $6bdc
	ld l, a ; $6bdd
	jr nc, Label_1b_6be1 ; $6bde
	inc h ; $6be0
Label_1b_6be1:
	ld a, [hl+] ; $6be1
	ld h, [hl] ; $6be2
	ld l, a ; $6be3
	push hl ; $6be4
	ld a, [hl+] ; $6be5
	ld d, [hl] ; $6be6
	ld e, a ; $6be7
	farcall FarPtr_TestSaveFlag ; $6be8
	pop hl ; $6beb
	jr z, Label_1b_6bef ; $6bec
	inc c ; $6bee
Label_1b_6bef:
	inc hl ; $6bef
	inc hl ; $6bf0
	ld a, [hl+] ; $6bf1
	ld d, [hl] ; $6bf2
	ld e, a ; $6bf3
	farcall FarPtr_TestSaveFlag ; $6bf4
	jr z, Label_1b_6bfa ; $6bf7
	inc c ; $6bf9
Label_1b_6bfa:
	ld a, c ; $6bfa
	ld [$d001], a ; $6bfb
	ld a, [$d001] ; $6bfe
	ld hl, $6c0e ; $6c01
	add a, l ; $6c04
	ld l, a ; $6c05
	jr nc, Label_1b_6c09 ; $6c06
	inc h ; $6c08
Label_1b_6c09:
	ld a, [hl] ; $6c09
	ld [$d002], a ; $6c0a
	ret ; $6c0d
	INCBIN "data/bank_01b/d_6c0e.bin" ; $6c0e, 3 bytes
	; $6c11, 72 bytes (records:2)
	dw $6c23 ; record 0
	dw $6c29 ; record 1
	dw $6c2f ; record 2
	dw $6c35 ; record 3
	dw $6c3b ; record 4
	dw $6c41 ; record 5
	dw $6c47 ; record 6
	dw $6c4d ; record 7
	dw $6c53 ; record 8
	dw $0280 ; record 9
	dw $02a0 ; record 10
	dw $02c0 ; record 11
	dw $02e0 ; record 12
	dw $0300 ; record 13
	dw $0320 ; record 14
	dw $0340 ; record 15
	dw $0360 ; record 16
	dw $0380 ; record 17
	dw $03a0 ; record 18
	dw $03c0 ; record 19
	dw $03e0 ; record 20
	dw $0500 ; record 21
	dw $0520 ; record 22
	dw $0540 ; record 23
	dw $0560 ; record 24
	dw $0580 ; record 25
	dw $05a0 ; record 26
	dw $05c0 ; record 27
	dw $05e0 ; record 28
	dw $0600 ; record 29
	dw $0620 ; record 30
	dw $0640 ; record 31
	dw $0660 ; record 32
	dw $0680 ; record 33
	dw $06a0 ; record 34
	dw $06c0 ; record 35
LoadMinigameLevelSelectGfx:
	ldh a, [hWramBank] ; $6c59
	push af ; $6c5b
	wram_bank $01 ; $6c5c
	ld c, $00 ; $6c62
Label_1b_6c64:
	ld a, c ; $6c64
	add a, a ; $6c65
	ld hl, $6d2d ; $6c66
	add a, l ; $6c69
	ld l, a ; $6c6a
	jr nc, Label_1b_6c6e ; $6c6b
	inc h ; $6c6d
Label_1b_6c6e:
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
	ld hl, $6d35 ; $6c7f
	ld a, c ; $6c82
	add a, a ; $6c83
	add a, l ; $6c84
	ld l, a ; $6c85
	jr nc, Label_1b_6c89 ; $6c86
	inc h ; $6c88
Label_1b_6c89:
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
	or a, a ; $6cb6
	jr z, Label_1b_6cc0 ; $6cb7
	ld a, c ; $6cb9
	cp a, $03 ; $6cba
	jr nz, Label_1b_6c64 ; $6cbc
	jr Label_1b_6cc5 ; $6cbe
Label_1b_6cc0:
	ld a, c ; $6cc0
	cp a, $04 ; $6cc1
	jr nz, Label_1b_6c64 ; $6cc3
Label_1b_6cc5:
	ld b, $70 ; $6cc5
	ld c, $10 ; $6cc7
	ld de, $a000 ; $6cc9
	farcall FarPtr_LoadCompressedTileBlock ; $6ccc
	call AdvanceFrame ; $6ccf
	ldh a, [hWramBank] ; $6cd2
	push af ; $6cd4
	wram_bank $02 ; $6cd5
	ld a, [$d001] ; $6cdb
	ld b, a ; $6cde
	pop af ; $6cdf
	wram_bank ; $6ce0
	ld a, b ; $6ce4
	or a, a ; $6ce5
	jr z, Label_1b_6cec ; $6ce6
	ld b, $71 ; $6ce8
	jr Label_1b_6cee ; $6cea
Label_1b_6cec:
	ld b, $6f ; $6cec
Label_1b_6cee:
	ld c, $10 ; $6cee
	ld de, $a100 ; $6cf0
	farcall FarPtr_LoadCompressedTileBlock ; $6cf3
	call AdvanceFrame ; $6cf6
	ld b, $72 ; $6cf9
	ld c, $10 ; $6cfb
	ld de, $a200 ; $6cfd
	farcall FarPtr_LoadCompressedTileBlock ; $6d00
	call AdvanceFrame ; $6d03
	ld b, $1b ; $6d06
	ld c, $04 ; $6d08
	ld de, $a700 ; $6d0a
	farcall FarPtr_LoadCompressedTileBlock ; $6d0d
	call AdvanceFrame ; $6d10
	ld b, $77 ; $6d13
	ld c, $14 ; $6d15
	ld de, $8000 ; $6d17
	farcall FarPtr_LoadCompressedTileBlock ; $6d1a
	call AdvanceFrame ; $6d1d
	ld b, $08 ; $6d20
	ld c, $10 ; $6d22
	farcall FarPtr_LoadIndexedPalette ; $6d24
	pop af ; $6d27
	wram_bank ; $6d28
	ret ; $6d2c
	; $6d2d, 16 bytes (records:2)
	dw $6d8a ; record 0
	dw $6d8c ; record 1
	dw $6d8e ; record 2
	dw $6d90 ; record 3
	dw $a800 ; record 4
	dw $a900 ; record 5
	dw $aa00 ; record 6
	dw $a900 ; record 7
DrawMinigameLevelDescription:
	ldh a, [hWramBank] ; $6d3d
	push af ; $6d3f
	wram_bank $02 ; $6d40
	ld a, [$d001] ; $6d46
	or a, a ; $6d49
	jr nz, Label_1b_6d63 ; $6d4a
	ld c, $03 ; $6d4c
	call GetMenuCursorIndex ; $6d4e
	cp a, $01 ; $6d51
	jr nz, Label_1b_6d63 ; $6d53
	wram_bank $03 ; $6d55
	ld hl, $00c5 ; $6d5b
	ld de, $d201 ; $6d5e
	jr Label_1b_6d84 ; $6d61
Label_1b_6d63:
	wram_bank $03 ; $6d63
	ld c, $03 ; $6d69
	call GetMenuCursorIndex ; $6d6b
	ld b, a ; $6d6e
	ld hl, $6d8f ; $6d6f
	add a, a ; $6d72
	add a, l ; $6d73
	ld l, a ; $6d74
	jr nc, Label_1b_6d78 ; $6d75
	inc h ; $6d77
Label_1b_6d78:
	ld a, [hl+] ; $6d78
	ld d, [hl] ; $6d79
	ld e, a ; $6d7a
	ld a, b ; $6d7b
	ld hl, $00c2 ; $6d7c
	add a, l ; $6d7f
	ld l, a ; $6d80
	jr nc, Label_1b_6d84 ; $6d81
	inc h ; $6d83
Label_1b_6d84:
	ld c, $20 ; $6d84
	farcall FarPtr_RenderTextToBuffer64 ; $6d86
	pop af ; $6d89
	wram_bank ; $6d8a
	ret ; $6d8e
	INCBIN "data/bank_01b/d_6d8f.bin" ; $6d8f, 6 bytes
LoadMinigameLevelSelectPalette:
	ld hl, $6da8 ; $6d95
	add a, a ; $6d98
	add a, l ; $6d99
	ld l, a ; $6d9a
	jr nc, Label_1b_6d9e ; $6d9b
	inc h ; $6d9d
Label_1b_6d9e:
	ld a, [hl+] ; $6d9e
	ld h, [hl] ; $6d9f
	ld l, a ; $6da0
	ld de, $0401 ; $6da1
	call LoadPaletteShadow ; $6da4
	ret ; $6da7
	; $6da8, 6 bytes (records:2)
	dw $6dae ; record 0
	dw $6dbe ; record 1
	dw $6db6 ; record 2
	; $6dae, 24 bytes (bytes:8)
	db $34, $53, $ff, $6b, $40, $02, $00, $00 ; 0x00
	db $b7, $5e, $ff, $6b, $93, $7c, $00, $00 ; 0x08
	db $99, $52, $ff, $6b, $1f, $14, $00, $00 ; 0x10
FlushLevelSelectTextRows:
	ldh a, [hWramBank] ; $6dc6
	push af ; $6dc8
	wram_bank $03 ; $6dc9
	ld hl, $d4e0 ; $6dcf
	ld de, $b8e0 ; $6dd2
	ld c, $06 ; $6dd5
	call QueueVRAMCopy ; $6dd7
	ld hl, $d1e0 ; $6dda
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
	ld de, $d1e0 ; $6df4
	ld b, $14 ; $6df7
	ld c, $01 ; $6df9
	ld h, $03 ; $6dfb
	farcall FarPtr_FillTilemapRect ; $6dfd
	ld a, $02 ; $6e00
	ld [$d1e0], a ; $6e02
	ld a, $04 ; $6e05
	ld [$d1f3], a ; $6e07
	ld de, $d201 ; $6e0a
	ld b, $12 ; $6e0d
	ld c, $01 ; $6e0f
	ld h, $20 ; $6e11
	farcall FarPtr_FillTilemapRect ; $6e13
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
	ld a, [$cb11] ; $6e41
	ld b, a ; $6e44
	farcall FarPtr_OpenChoiceTabPanel ; $6e45
	farcall FarPtr_InitMenuBgScroll ; $6e48
	ld b, $01 ; $6e4b
	ld c, $01 ; $6e4d
	farcall FarPtr_39_26 ; $6e4f
	wram_bank $02 ; $6e52
	ld a, [$d001] ; $6e58
	ld c, a ; $6e5b
	ld b, $02 ; $6e5c
	call SetMenuCursorFromIndex ; $6e5e
	wram_bank $03 ; $6e61
	ld a, $01 ; $6e67
	ld hl, $6f62 ; $6e69
	call RegisterFrameTask ; $6e6c
	call RedrawMinigameLevelSelect2 ; $6e6f
	wram_bank $03 ; $6e72
Label_1b_6e78:
	call AdvanceFrame ; $6e78
	ldh a, [hInputPressed] ; $6e7b
	ld [wMenuInputPressed], a ; $6e7d
	call GetMinigameLevelColumnCount ; $6e80
	ld c, $01 ; $6e83
	call MoveMenuCursorGrid ; $6e85
	or a, a ; $6e88
	jr z, Label_1b_6e90 ; $6e89
	sound $5e ; $6e8b
	call RedrawMinigameLevelSelect2 ; $6e8d
Label_1b_6e90:
	ld a, [wMenuInputPressed] ; $6e90
	bit 0, a ; $6e93
	jr nz, Label_1b_6e9d ; $6e95
	bit 1, a ; $6e97
	jr nz, Label_1b_6ede ; $6e99
	jr Label_1b_6e78 ; $6e9b
Label_1b_6e9d:
	ld c, $03 ; $6e9d
	call GetMenuCursorIndex ; $6e9f
	or a, a ; $6ea2
	jr z, Label_1b_6eb5 ; $6ea3
	wram_bank $02 ; $6ea5
	ld a, [$d001] ; $6eab
	or a, a ; $6eae
	jr nz, Label_1b_6eb5 ; $6eaf
	sound $61 ; $6eb1
	jr Label_1b_6e78 ; $6eb3
Label_1b_6eb5:
	sound $5f ; $6eb5
	call ClearFrameTasks ; $6eb7
	ld hl, rIE ; $6eba
	set 2, [hl] ; $6ebd
	wram_bank $03 ; $6ebf
	ld b, $01 ; $6ec5
	farcall FarPtr_CloseChoiceTabPanel ; $6ec7
	ld a, $01 ; $6eca
	ld [$cb11], a ; $6ecc
	wram_bank $02 ; $6ecf
	ld c, $03 ; $6ed5
	call GetMenuCursorIndex ; $6ed7
	ld [$d003], a ; $6eda
	ret ; $6edd
Label_1b_6ede:
	sound $62 ; $6ede
	call ClearFrameTasks ; $6ee0
	ld hl, rIE ; $6ee3
	set 2, [hl] ; $6ee6
	wram_bank $03 ; $6ee8
	ld b, $00 ; $6eee
	farcall FarPtr_CloseChoiceTabPanel ; $6ef0
	ld a, $00 ; $6ef3
	ld [$cb11], a ; $6ef5
	wram_bank $02 ; $6ef8
	ld a, $ff ; $6efe
	ld [$d003], a ; $6f00
	ret ; $6f03
RedrawMinigameLevelSelect2:
	wram_bank $03 ; $6f04
	ld b, $00 ; $6f0a
	ld c, $00 ; $6f0c
Label_1b_6f0e:
	call SetSelectPanelAttrRect ; $6f0e
	ld a, b ; $6f11
	inc a ; $6f12
	ld b, a ; $6f13
	cp a, $02 ; $6f14
	jr nz, Label_1b_6f0e ; $6f16
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
	or a, a ; $6f3a
	jr z, Label_1b_6f41 ; $6f3b
	ld h, $0c ; $6f3d
	jr Label_1b_6f43 ; $6f3f
Label_1b_6f41:
	ld h, $0d ; $6f41
Label_1b_6f43:
	push hl ; $6f43
	ld hl, $6f5e ; $6f44
	ld a, b ; $6f47
	add a, a ; $6f48
	add a, l ; $6f49
	ld l, a ; $6f4a
	jr nc, Label_1b_6f4e ; $6f4b
	inc h ; $6f4d
Label_1b_6f4e:
	ld a, [hl+] ; $6f4e
	ld d, [hl] ; $6f4f
	ld e, a ; $6f50
	pop hl ; $6f51
	ld b, $05 ; $6f52
	ld c, $03 ; $6f54
	farcall FarPtr_FillTilemapRect ; $6f56
	pop hl ; $6f59
	pop de ; $6f5a
	pop bc ; $6f5b
	pop af ; $6f5c
	ret ; $6f5d
	INCBIN "data/bank_01b/d_6f5e.bin" ; $6f5e, 4 bytes
	farcall FarPtr_TickMenuBgScroll ; $6f62
	ld c, $03 ; $6f65
	call GetMenuCursorIndex ; $6f67
	push af ; $6f6a
	ld hl, $6fcf ; $6f6b
	add a, l ; $6f6e
	ld l, a ; $6f6f
	jr nc, Label_1b_6f73 ; $6f70
	inc h ; $6f72
Label_1b_6f73:
	ld c, [hl] ; $6f73
	pop af ; $6f74
	ld hl, $6fc9 ; $6f75
	add a, a ; $6f78
	add a, l ; $6f79
	ld l, a ; $6f7a
	jr nc, Label_1b_6f7e ; $6f7b
	inc h ; $6f7d
Label_1b_6f7e:
	ld a, [hl+] ; $6f7e
	ld d, [hl] ; $6f7f
	ld e, a ; $6f80
	farcall FarPtr_ApplySpriteBobOffset ; $6f81
	ld b, $08 ; $6f84
	ld hl, $6f9f ; $6f86
	push de ; $6f89
	call QueueSpriteTemplate ; $6f8a
	pop de ; $6f8d
	ld hl, $17f8 ; $6f8e
	add hl, de ; $6f91
	ld d, h ; $6f92
	ld e, l ; $6f93
	ld hl, $6fc0 ; $6f94
	ld b, $08 ; $6f97
	ld c, $70 ; $6f99
	call QueueSpriteTemplate ; $6f9b
	ret ; $6f9e
	INCBIN "data/bank_01b/d_6f9f.bin" ; $6f9f, 51 bytes
RunMinigameLevelSelect3:
	call ResumeBGM ; $6fd2
	sound $08 ; $6fd5
	ld hl, rIE ; $6fd7
	res 2, [hl] ; $6fda
	wram_bank $03 ; $6fdc
	ld a, [$cb11] ; $6fe2
	ld b, a ; $6fe5
	farcall FarPtr_N64RecordTypeSlideIn ; $6fe6
	farcall FarPtr_InitMenuBgScroll ; $6fe9
	ld b, $01 ; $6fec
	ld c, $01 ; $6fee
	farcall FarPtr_39_26 ; $6ff0
	wram_bank $02 ; $6ff3
	ld a, [$d001] ; $6ff9
	ld c, a ; $6ffc
	ld b, $03 ; $6ffd
	call SetMenuCursorFromIndex ; $6fff
	wram_bank $03 ; $7002
	ld a, $01 ; $7008
	ld hl, $70ed ; $700a
	call RegisterFrameTask ; $700d
	call RedrawMinigameLevelSelect3 ; $7010
	wram_bank $03 ; $7013
Label_1b_7019:
	call AdvanceFrame ; $7019
	ldh a, [hInputPressed] ; $701c
	ld [wMenuInputPressed], a ; $701e
	call GetMinigameLevelColumnCount ; $7021
	ld c, $01 ; $7024
	call MoveMenuCursorGrid ; $7026
	or a, a ; $7029
	jr z, Label_1b_7031 ; $702a
	sound $5e ; $702c
	call RedrawMinigameLevelSelect3 ; $702e
Label_1b_7031:
	ld a, [wMenuInputPressed] ; $7031
	bit 0, a ; $7034
	jr nz, Label_1b_703e ; $7036
	bit 1, a ; $7038
	jr nz, Label_1b_7067 ; $703a
	jr Label_1b_7019 ; $703c
Label_1b_703e:
	sound $5f ; $703e
	call ClearFrameTasks ; $7040
	ld hl, rIE ; $7043
	set 2, [hl] ; $7046
	wram_bank $03 ; $7048
	ld b, $01 ; $704e
	farcall FarPtr_N64RecordTypeSlideOut ; $7050
	ld a, $01 ; $7053
	ld [$cb11], a ; $7055
	wram_bank $02 ; $7058
	ld c, $03 ; $705e
	call GetMenuCursorIndex ; $7060
	ld [$d003], a ; $7063
	ret ; $7066
Label_1b_7067:
	sound $62 ; $7067
	call ClearFrameTasks ; $7069
	ld hl, rIE ; $706c
	set 2, [hl] ; $706f
	wram_bank $03 ; $7071
	ld b, $00 ; $7077
	farcall FarPtr_N64RecordTypeSlideOut ; $7079
	ld a, $00 ; $707c
	ld [$cb11], a ; $707e
	wram_bank $02 ; $7081
	ld a, $ff ; $7087
	ld [$d003], a ; $7089
	ret ; $708c
RedrawMinigameLevelSelect3:
	wram_bank $03 ; $708d
	ld b, $00 ; $7093
	ld c, $00 ; $7095
Label_1b_7097:
	call SetSelectPanelAttrRect3 ; $7097
	ld a, b ; $709a
	inc a ; $709b
	ld b, a ; $709c
	cp a, $03 ; $709d
	jr nz, Label_1b_7097 ; $709f
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
	or a, a ; $70c3
	jr z, Label_1b_70ca ; $70c4
	ld h, $0c ; $70c6
	jr Label_1b_70cc ; $70c8
Label_1b_70ca:
	ld h, $0d ; $70ca
Label_1b_70cc:
	push hl ; $70cc
	ld hl, $70e7 ; $70cd
	ld a, b ; $70d0
	add a, a ; $70d1
	add a, l ; $70d2
	ld l, a ; $70d3
	jr nc, Label_1b_70d7 ; $70d4
	inc h ; $70d6
Label_1b_70d7:
	ld a, [hl+] ; $70d7
	ld d, [hl] ; $70d8
	ld e, a ; $70d9
	pop hl ; $70da
	ld b, $05 ; $70db
	ld c, $03 ; $70dd
	farcall FarPtr_FillTilemapRect ; $70df
	pop hl ; $70e2
	pop de ; $70e3
	pop bc ; $70e4
	pop af ; $70e5
	ret ; $70e6
	INCBIN "data/bank_01b/d_70e7.bin" ; $70e7, 118 bytes
RunSavedDataTypeSelect:
	sound $03 ; $715d
	ld hl, rIE ; $715f
	res 2, [hl] ; $7162
	call LoadSavedDataTypeSelectGfx ; $7164
	wram_bank $03 ; $7167
	ld a, [$cb11] ; $716d
	ld b, a ; $7170
	farcall FarPtr_OpenChoiceTabPanel ; $7171
	farcall FarPtr_InitMenuBgScroll ; $7174
	ld b, $01 ; $7177
	ld c, $01 ; $7179
	farcall FarPtr_39_26 ; $717b
	ld a, [$cb25] ; $717e
	ld c, a ; $7181
	ld b, $02 ; $7182
	call SetMenuCursorFromIndex ; $7184
	ld a, $01 ; $7187
	ld hl, $72a4 ; $7189
	call RegisterFrameTask ; $718c
	ld a, $01 ; $718f
	ld hl, $72a8 ; $7191
	call RegisterFrameTask ; $7194
	call RedrawSavedDataTypeSelect ; $7197
	wram_bank $03 ; $719a
Label_1b_71a0:
	call AdvanceFrame ; $71a0
	ldh a, [hInputPressed] ; $71a3
	ld [wMenuInputPressed], a ; $71a5
	ld b, $02 ; $71a8
	ld c, $01 ; $71aa
	call MoveMenuCursorGrid ; $71ac
	or a, a ; $71af
	jr z, Label_1b_71b7 ; $71b0
	sound $5e ; $71b2
	call RedrawSavedDataTypeSelect ; $71b4
Label_1b_71b7:
	ld a, [wMenuInputPressed] ; $71b7
	bit 0, a ; $71ba
	jr nz, Label_1b_71c4 ; $71bc
	bit 1, a ; $71be
	jr nz, Label_1b_71e7 ; $71c0
	jr Label_1b_71a0 ; $71c2
Label_1b_71c4:
	sound $5f ; $71c4
	call ClearFrameTasks ; $71c6
	ld hl, rIE ; $71c9
	set 2, [hl] ; $71cc
	wram_bank $03 ; $71ce
	ld b, $01 ; $71d4
	farcall FarPtr_CloseChoiceTabPanel ; $71d6
	ld a, $01 ; $71d9
	ld [$cb11], a ; $71db
	ld c, $02 ; $71de
	call GetMenuCursorIndex ; $71e0
	ld [$cb25], a ; $71e3
	ret ; $71e6
Label_1b_71e7:
	sound $62 ; $71e7
	call ClearFrameTasks ; $71e9
	ld hl, rIE ; $71ec
	set 2, [hl] ; $71ef
	wram_bank $03 ; $71f1
	ld b, $00 ; $71f7
	farcall FarPtr_CloseChoiceTabPanel ; $71f9
	ld a, $00 ; $71fc
	ld [$cb11], a ; $71fe
	wram_bank $02 ; $7201
	ld a, $ff ; $7207
	ret ; $7209
LoadSavedDataTypeSelectGfx:
	ldh a, [hWramBank] ; $720a
	push af ; $720c
	wram_bank $01 ; $720d
	ld c, $00 ; $7213
Label_1b_7215:
	ld a, c ; $7215
	add a, a ; $7216
	ld hl, $729a ; $7217
	add a, l ; $721a
	ld l, a ; $721b
	jr nc, Label_1b_721f ; $721c
	inc h ; $721e
Label_1b_721f:
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
	ld hl, $729e ; $7230
	ld a, c ; $7233
	add a, a ; $7234
	add a, l ; $7235
	ld l, a ; $7236
	jr nc, Label_1b_723a ; $7237
	inc h ; $7239
Label_1b_723a:
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
	cp a, $02 ; $7255
	jr nz, Label_1b_7215 ; $7257
	ld b, $1d ; $7259
	ld c, $10 ; $725b
	ld de, $a000 ; $725d
	farcall FarPtr_LoadCompressedTileBlock ; $7260
	call AdvanceFrame ; $7263
	ld b, $1e ; $7266
	ld c, $12 ; $7268
	ld de, $a100 ; $726a
	farcall FarPtr_LoadCompressedTileBlock ; $726d
	call AdvanceFrame ; $7270
	ld b, $1b ; $7273
	ld c, $04 ; $7275
	ld de, $a700 ; $7277
	farcall FarPtr_LoadCompressedTileBlock ; $727a
	call AdvanceFrame ; $727d
	ld b, $78 ; $7280
	ld c, $14 ; $7282
	ld de, $8000 ; $7284
	farcall FarPtr_LoadCompressedTileBlock ; $7287
	call AdvanceFrame ; $728a
	ld b, $08 ; $728d
	ld c, $10 ; $728f
	farcall FarPtr_LoadIndexedPalette ; $7291
	pop af ; $7294
	wram_bank ; $7295
	ret ; $7299
	INCBIN "data/bank_01b/d_729a.bin" ; $729a, 10 bytes
	farcall FarPtr_TickMenuBgScroll ; $72a4
	ret ; $72a7
	ld c, $02 ; $72a8
	call GetMenuCursorIndex ; $72aa
	or a, a ; $72ad
	jr nz, Label_1b_72b4 ; $72ae
	call DrawSavedDataCursorOption0 ; $72b0
	ret ; $72b3
Label_1b_72b4:
	call DrawSavedDataCursorOption1 ; $72b4
	ret ; $72b7
DrawSavedDataCursorOption0:
	ld c, $00 ; $72b8
	ld b, $08 ; $72ba
	ld de, $0c50 ; $72bc
	farcall FarPtr_ApplySpriteBobOffset ; $72bf
	ld hl, $72fa ; $72c2
	call QueueSpriteTemplate ; $72c5
	ld b, $08 ; $72c8
	ld c, $70 ; $72ca
	ld de, $2448 ; $72cc
	farcall FarPtr_ApplySpriteBobOffset ; $72cf
	ld hl, $7340 ; $72d2
	call QueueSpriteTemplate ; $72d5
	ret ; $72d8
DrawSavedDataCursorOption1:
	ld c, $10 ; $72d9
	ld b, $08 ; $72db
	ld de, $5050 ; $72dd
	farcall FarPtr_ApplySpriteBobOffset ; $72e0
	ld hl, $731b ; $72e3
	call QueueSpriteTemplate ; $72e6
	ld b, $08 ; $72e9
	ld c, $70 ; $72eb
	ld de, $6c48 ; $72ed
	farcall FarPtr_ApplySpriteBobOffset ; $72f0
	ld hl, $7340 ; $72f3
	call QueueSpriteTemplate ; $72f6
	ret ; $72f9
	INCBIN "data/bank_01b/d_72fa.bin" ; $72fa, 88 bytes
RedrawSavedDataTypeSelect:
	wram_bank $03 ; $7352
	ld b, $00 ; $7358
	ld c, $00 ; $735a
Label_1b_735c:
	call SetSelectPanelAttrRect ; $735c
	ld a, b ; $735f
	inc a ; $7360
	ld b, a ; $7361
	cp a, $02 ; $7362
	jr nz, Label_1b_735c ; $7364
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
	ld hl, $73b2 ; $7392
	add a, a ; $7395
	add a, l ; $7396
	ld l, a ; $7397
	jr nc, Label_1b_739b ; $7398
	inc h ; $739a
Label_1b_739b:
	ld a, [hl+] ; $739b
	ld d, [hl] ; $739c
	ld e, a ; $739d
	ld a, b ; $739e
	ld hl, $00ca ; $739f
	add a, l ; $73a2
	ld l, a ; $73a3
	jr nc, Label_1b_73a7 ; $73a4
	inc h ; $73a6
Label_1b_73a7:
	ld c, $20 ; $73a7
	farcall FarPtr_RenderTextToBuffer64 ; $73a9
	pop af ; $73ac
	wram_bank ; $73ad
	ret ; $73b1
	INCBIN "data/bank_01b/d_73b2.bin" ; $73b2, 4 bytes
LoadSavedDataTypePalette:
	ld hl, $73c9 ; $73b6
	add a, a ; $73b9
	add a, l ; $73ba
	ld l, a ; $73bb
	jr nc, Label_1b_73bf ; $73bc
	inc h ; $73be
Label_1b_73bf:
	ld a, [hl+] ; $73bf
	ld h, [hl] ; $73c0
	ld l, a ; $73c1
	ld de, $0401 ; $73c2
	call LoadPaletteShadow ; $73c5
	ret ; $73c8
	; $73c9, 4 bytes (records:2)
	dw $73cd ; record 0
	dw $73d5 ; record 1
	; $73cd, 16 bytes (bytes:8)
	db $34, $53, $ff, $6b, $40, $02, $00, $00 ; 0x00
	db $bf, $02, $ff, $6b, $1b, $18, $00, $00 ; 0x08
ShowMinigameDataScreen:
	sound $04 ; $73dd
	call DisableLCDSafely ; $73df
	call BuildMinigameDataScreen ; $73e2
	ld a, $01 ; $73e5
	ld [$cb0b], a ; $73e7
	ld a, $01 ; $73ea
	ld hl, $4430 ; $73ec
	call RegisterFrameTask ; $73ef
	ld a, $01 ; $73f2
	ld hl, $76b9 ; $73f4
	call RegisterFrameTask ; $73f7
	ld a, $01 ; $73fa
	ld hl, $7827 ; $73fc
	call RegisterFrameTask ; $73ff
	call EnableLCD ; $7402
	ld c, $10 ; $7405
	call BeginFadeIn ; $7407
	call WaitFadeEnd ; $740a
	wram_bank $03 ; $740d
Label_1b_7413:
	ldh a, [hInputPressed] ; $7413
	ld [wMenuInputPressed], a ; $7415
	call ScrollMinigameDataList ; $7418
	call AdvanceFrame ; $741b
	ld a, [wMenuInputPressed] ; $741e
	bit 0, a ; $7421
	jr nz, Label_1b_742b ; $7423
	bit 1, a ; $7425
	jr nz, Label_1b_7439 ; $7427
	jr Label_1b_7413 ; $7429
Label_1b_742b:
	sound $5f ; $742b
	ld c, $10 ; $742d
	call BeginFadeOut ; $742f
	call WaitFadeEnd ; $7432
	call ClearFrameTasks ; $7435
	ret ; $7438
Label_1b_7439:
	sound $62 ; $7439
	ld c, $10 ; $743b
	call BeginFadeOut ; $743d
	call WaitFadeEnd ; $7440
	call ClearFrameTasks ; $7443
	ld a, $ff ; $7446
	ret ; $7448
BuildMinigameDataScreen:
	ld c, $2b ; $7449
	farcall FarPtr_LoadScreenAssetRecord ; $744b
	xor a, a ; $744e
	ld [wMenuCursorX], a ; $744f
	ld [wMenuCursorY], a ; $7452
	wram_bank $03 ; $7455
	call LoadMinigameDataState ; $745b
	ld de, $aac0 ; $745e
	farcall FarPtr_LoadChartWindowTiles ; $7461
	ld de, $a000 ; $7464
	farcall FarPtr_39_18 ; $7467
	ld b, $08 ; $746a
	ld c, $0f ; $746c
	farcall FarPtr_LoadIndexedPalette ; $746e
	ld de, $a100 ; $7471
	ld b, $09 ; $7474
	ld c, $00 ; $7476
	farcall FarPtr_39_64 ; $7478
	ld a, $09 ; $747b
	ld [$cb6c], a ; $747d
	ld a, $10 ; $7480
	ld [$cb6b], a ; $7482
	call CheckMinigameDataScrollable ; $7485
	or a, a ; $7488
	jr nz, Label_1b_7490 ; $7489
	call DrawMinigameDataMugshotsStatic ; $748b
	jr Label_1b_7493 ; $748e
Label_1b_7490:
	call DrawMinigameDataMugshotsScrolled ; $7490
Label_1b_7493:
	call DrawMinigameDataMarks ; $7493
	call DrawStarLegendMark ; $7496
	farcall FarPtr_QueueWram3MapToVRAM ; $7499
	ret ; $749c
ScrollMinigameDataList:
	call CheckMinigameDataScrollable ; $749d
	or a, a ; $74a0
	ret z ; $74a1
	ld a, [wMenuInputPressed] ; $74a2
	bit 7, a ; $74a5
	jr nz, Label_1b_74ae ; $74a7
	bit 6, a ; $74a9
	jr nz, Label_1b_74ba ; $74ab
	ret ; $74ad
Label_1b_74ae:
	ld a, [wMenuCursorY] ; $74ae
	inc a ; $74b1
	cp a, $05 ; $74b2
	ret z ; $74b4
	ld [wMenuCursorY], a ; $74b5
	jr Label_1b_74c4 ; $74b8
Label_1b_74ba:
	ld a, [wMenuCursorY] ; $74ba
	dec a ; $74bd
	cp a, $ff ; $74be
	ret z ; $74c0
	ld [wMenuCursorY], a ; $74c1
Label_1b_74c4:
	sound $5e ; $74c4
	call RedrawMinigameDataRows ; $74c6
	ret ; $74c9
LoadMinigameDataState:
	farcall FarPtr_BuildStarCharUnlockMask ; $74ca
	call LoadMinigameClearFlags ; $74cd
	call LoadMinigameStarFlags ; $74d0
	call LoadMinigameHighScores ; $74d3
	call CheckMinigameDataScrollable ; $74d6
	jr nz, Label_1b_74de ; $74d9
	call CompactMinigameDataRows ; $74db
Label_1b_74de:
	ret ; $74de
LoadMinigameClearFlags:
	ld hl, $d809 ; $74df
	ld bc, $0009 ; $74e2
	call ClearBytes ; $74e5
	ld c, $00 ; $74e8
	ld hl, $d809 ; $74ea
Label_1b_74ed:
	ld a, c ; $74ed
	add a, a ; $74ee
	push hl ; $74ef
	ld hl, $750d ; $74f0
	add a, l ; $74f3
	ld l, a ; $74f4
	jr nc, Label_1b_74f8 ; $74f5
	inc h ; $74f7
Label_1b_74f8:
	ld a, [hl+] ; $74f8
	ld d, [hl] ; $74f9
	ld e, a ; $74fa
	pop hl ; $74fb
	farcall FarPtr_TestSaveFlag ; $74fc
	jr z, Label_1b_7504 ; $74ff
	ld a, $01 ; $7501
	ld [hl], a ; $7503
Label_1b_7504:
	inc hl ; $7504
	ld a, c ; $7505
	inc a ; $7506
	ld c, a ; $7507
	cp a, $09 ; $7508
	jr nz, Label_1b_74ed ; $750a
	ret ; $750c
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
Label_1b_752d:
	ld a, c ; $752d
	add a, a ; $752e
	push hl ; $752f
	ld hl, $754d ; $7530
	add a, l ; $7533
	ld l, a ; $7534
	jr nc, Label_1b_7538 ; $7535
	inc h ; $7537
Label_1b_7538:
	ld a, [hl+] ; $7538
	ld d, [hl] ; $7539
	ld e, a ; $753a
	pop hl ; $753b
	farcall FarPtr_TestSaveFlag ; $753c
	jr z, Label_1b_7544 ; $753f
	ld a, $01 ; $7541
	ld [hl], a ; $7543
Label_1b_7544:
	inc hl ; $7544
	ld a, c ; $7545
	inc a ; $7546
	ld c, a ; $7547
	cp a, $09 ; $7548
	jr nz, Label_1b_752d ; $754a
	ret ; $754c
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
	ld de, $06c0 ; $756c
	farcall FarPtr_TestSaveFlag ; $756f
	jr z, Label_1b_757b ; $7572
	ld a, $01 ; $7574
	ld hl, $d82b ; $7576
	ld [hl+], a ; $7579
	ld [hl], a ; $757a
Label_1b_757b:
	ld c, $00 ; $757b
Label_1b_757d:
	ld a, c ; $757d
	inc a ; $757e
	inc a ; $757f
	farcall FarPtr_ReadMinigameRecord ; $7580
	wram_bank $07 ; $7583
	ld hl, $de00 ; $7589
	ld a, [hl+] ; $758c
	ld d, [hl] ; $758d
	ld e, a ; $758e
	wram_bank $03 ; $758f
	ld hl, $d81b ; $7595
	ld a, c ; $7598
	add a, a ; $7599
	add a, l ; $759a
	ld l, a ; $759b
	jr nc, Label_1b_759f ; $759c
	inc h ; $759e
Label_1b_759f:
	ld a, e ; $759f
	ld [hl+], a ; $75a0
	ld [hl], d ; $75a1
	inc c ; $75a2
	ld a, c ; $75a3
	cp a, $08 ; $75a4
	jr nz, Label_1b_757d ; $75a6
	pop af ; $75a8
	wram_bank ; $75a9
	ret ; $75ad
RedrawMinigameDataRows:
	call DrawMinigameDataMugshotsScrolled ; $75ae
	call DrawMinigameDataMarks ; $75b1
	call FlushMinigameDataRowsToVram ; $75b4
	ret ; $75b7
FlushMinigameDataRowsToVram:
	ld hl, $d0c0 ; $75b8
	ld de, $98c0 ; $75bb
	ld c, $08 ; $75be
	call QueueVRAMCopy ; $75c0
	ld hl, $d4c0 ; $75c3
	ld de, $b8c0 ; $75c6
	ld c, $08 ; $75c9
	call QueueVRAMCopy ; $75cb
	call AdvanceFrame ; $75ce
	ld hl, $d140 ; $75d1
	ld de, $9940 ; $75d4
	ld c, $08 ; $75d7
	call QueueVRAMCopy ; $75d9
	ld hl, $d540 ; $75dc
	ld de, $b940 ; $75df
	ld c, $08 ; $75e2
	call QueueVRAMCopy ; $75e4
	call AdvanceFrame ; $75e7
	ld hl, $d1c0 ; $75ea
	ld de, $99c0 ; $75ed
	ld c, $04 ; $75f0
	call QueueVRAMCopy ; $75f2
	ld hl, $d5c0 ; $75f5
	ld de, $b9c0 ; $75f8
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
Label_1b_7613:
	push bc ; $7613
	farcall FarPtr_GetUnlockedStarCharAtGridSlot ; $7614
	pop bc ; $7617
	cp a, $15 ; $7618
	jr nz, Label_1b_7621 ; $761a
	push bc ; $761c
	ld c, $09 ; $761d
	jr Label_1b_7622 ; $761f
Label_1b_7621:
	push bc ; $7621
Label_1b_7622:
	call DrawMinigameDataMugshot ; $7622
	pop bc ; $7625
	inc c ; $7626
	ld a, b ; $7627
	inc a ; $7628
	ld b, a ; $7629
	cp a, $05 ; $762a
	jr nz, Label_1b_7613 ; $762c
	pop af ; $762e
	wram_bank ; $762f
	ret ; $7633
DrawMinigameDataMugshotsStatic:
	ldh a, [hWramBank] ; $7634
	push af ; $7636
	wram_bank $03 ; $7637
	ld c, $00 ; $763d
	ld b, $00 ; $763f
Label_1b_7641:
	push bc ; $7641
	farcall FarPtr_GetUnlockedStarCharAtGridSlot ; $7642
	pop bc ; $7645
	cp a, $15 ; $7646
	jr nz, Label_1b_764f ; $7648
	push bc ; $764a
	ld c, $09 ; $764b
	jr Label_1b_7650 ; $764d
Label_1b_764f:
	push bc ; $764f
Label_1b_7650:
	call DrawMinigameDataMugshot ; $7650
	pop bc ; $7653
	inc c ; $7654
	ld a, b ; $7655
	inc a ; $7656
	ld b, a ; $7657
	cp a, $04 ; $7658
	jr nz, Label_1b_7641 ; $765a
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
	farcall FarPtr_DrawChartCharIcon ; $767d
	pop af ; $7680
	wram_bank ; $7681
	pop hl ; $7685
	pop de ; $7686
	pop bc ; $7687
	pop af ; $7688
	ret ; $7689
MapMinigameRowToMugshotSlot:
	push hl ; $768a
	ld hl, $7697 ; $768b
	ld a, c ; $768e
	add a, l ; $768f
	ld l, a ; $7690
	jr nc, Label_1b_7694 ; $7691
	inc h ; $7693
Label_1b_7694:
	ld c, [hl] ; $7694
	pop hl ; $7695
	ret ; $7696
	INCBIN "data/bank_01b/d_7697.bin" ; $7697, 10 bytes
GetMinigameRowTilemapDest:
	ld hl, $76af ; $76a1
	ld a, b ; $76a4
	add a, a ; $76a5
	add a, l ; $76a6
	ld l, a ; $76a7
	jr nc, Label_1b_76ab ; $76a8
	inc h ; $76aa
Label_1b_76ab:
	ld a, [hl+] ; $76ab
	ld h, [hl] ; $76ac
	ld l, a ; $76ad
	ret ; $76ae
	INCBIN "data/bank_01b/d_76af.bin" ; $76af, 10 bytes
	call CheckMinigameDataScrollable ; $76b9
	or a, a ; $76bc
	ret z ; $76bd
	ld a, [wMenuCursorY] ; $76be
	or a, a ; $76c1
	jr z, Label_1b_76d5 ; $76c2
	ld de, $1128 ; $76c4
	ld c, $01 ; $76c7
	call ApplyArrowBobOffset ; $76c9
	ld b, $08 ; $76cc
	ld c, $00 ; $76ce
	ld h, $02 ; $76d0
	farcall FarPtr_39_1a ; $76d2
Label_1b_76d5:
	ld a, [wMenuCursorY] ; $76d5
	cp a, $04 ; $76d8
	jr z, Label_1b_76ed ; $76da
	ld de, $1184 ; $76dc
	ld c, $00 ; $76df
	call ApplyArrowBobOffset ; $76e1
	ld b, $08 ; $76e4
	ld c, $00 ; $76e6
	ld h, $03 ; $76e8
	farcall FarPtr_39_1a ; $76ea
Label_1b_76ed:
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
	add a, l ; $7701
	ld l, a ; $7702
	jr nc, Label_1b_7706 ; $7703
	inc h ; $7705
Label_1b_7706:
	ld c, $00 ; $7706
Label_1b_7708:
	ld b, $00 ; $7708
	ld a, [hl+] ; $770a
	or a, a ; $770b
	jr z, Label_1b_7711 ; $770c
	call DrawMinigameMarkTile ; $770e
Label_1b_7711:
	ld a, c ; $7711
	inc a ; $7712
	ld c, a ; $7713
	cp a, $05 ; $7714
	jr nz, Label_1b_7708 ; $7716
	ret ; $7718
DrawMinigameStarMarks:
	ld hl, $d812 ; $7719
	ld a, [wMenuCursorY] ; $771c
	add a, l ; $771f
	ld l, a ; $7720
	jr nc, Label_1b_7724 ; $7721
	inc h ; $7723
Label_1b_7724:
	ld c, $00 ; $7724
Label_1b_7726:
	ld b, $01 ; $7726
	ld a, [hl+] ; $7728
	or a, a ; $7729
	jr z, Label_1b_772f ; $772a
	call DrawMinigameMarkTile ; $772c
Label_1b_772f:
	ld a, c ; $772f
	inc a ; $7730
	ld c, a ; $7731
	cp a, $05 ; $7732
	jr nz, Label_1b_7726 ; $7734
	ret ; $7736
DrawMinigameSpecialMark:
	ld a, [wMenuCursorY] ; $7737
	cp a, $04 ; $773a
	ret nz ; $773c
	ld hl, $d82b ; $773d
	ld a, [hl+] ; $7740
	ld b, [hl] ; $7741
	or a, b ; $7742
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
	ld hl, $7788 ; $7750
	ld a, b ; $7753
	add a, a ; $7754
	add a, l ; $7755
	ld l, a ; $7756
	jr nc, Label_1b_775a ; $7757
	inc h ; $7759
Label_1b_775a:
	ld a, [hl+] ; $775a
	ld h, [hl] ; $775b
	ld l, a ; $775c
	ld a, c ; $775d
	add a, a ; $775e
	add a, l ; $775f
	ld l, a ; $7760
	jr nc, Label_1b_7764 ; $7761
	inc h ; $7763
Label_1b_7764:
	ld a, [hl+] ; $7764
	ld d, [hl] ; $7765
	ld e, a ; $7766
	push de ; $7767
	ld hl, $d055 ; $7768
	ld b, $02 ; $776b
	ld c, $02 ; $776d
	farcall FarPtr_CopyTilemapRect ; $776f
	pop de ; $7772
	ld hl, $0400 ; $7773
	add hl, de ; $7776
	ld d, h ; $7777
	ld e, l ; $7778
	ld hl, $d455 ; $7779
	ld b, $02 ; $777c
	ld c, $02 ; $777e
	farcall FarPtr_CopyTilemapRect ; $7780
	pop hl ; $7783
	pop de ; $7784
	pop bc ; $7785
	pop af ; $7786
	ret ; $7787
	; $7788, 36 bytes (records:2)
	dw $778e ; record 0
	dw $7798 ; record 1
	dw $77a2 ; record 2
	dw $d0c6 ; record 3
	dw $d106 ; record 4
	dw $d146 ; record 5
	dw $d186 ; record 6
	dw $d1c6 ; record 7
	dw $d0ca ; record 8
	dw $d10a ; record 9
	dw $d14a ; record 10
	dw $d18a ; record 11
	dw $d1ca ; record 12
	dw $d0ce ; record 13
	dw $d10e ; record 14
	dw $d14e ; record 15
	dw $d18e ; record 16
	dw $d1ce ; record 17
ClearMinigameMarkColumns:
	ld hl, $d095 ; $77ac
	ld de, $d0c6 ; $77af
	ld b, $02 ; $77b2
	ld c, $0a ; $77b4
	farcall FarPtr_CopyTilemapRect ; $77b6
	ld hl, $d495 ; $77b9
	ld de, $d4c6 ; $77bc
	ld b, $02 ; $77bf
	ld c, $0a ; $77c1
	farcall FarPtr_CopyTilemapRect ; $77c3
	ld hl, $d095 ; $77c6
	ld de, $d0ca ; $77c9
	ld b, $02 ; $77cc
	ld c, $0a ; $77ce
	farcall FarPtr_CopyTilemapRect ; $77d0
	ld hl, $d495 ; $77d3
	ld de, $d4ca ; $77d6
	ld b, $02 ; $77d9
	ld c, $0a ; $77db
	farcall FarPtr_CopyTilemapRect ; $77dd
	ld hl, $d095 ; $77e0
	ld de, $d0ce ; $77e3
	ld b, $02 ; $77e6
	ld c, $0a ; $77e8
	farcall FarPtr_CopyTilemapRect ; $77ea
	ld hl, $d495 ; $77ed
	ld de, $d4ce ; $77f0
	ld b, $02 ; $77f3
	ld c, $0a ; $77f5
	farcall FarPtr_CopyTilemapRect ; $77f7
	ret ; $77fa
DrawStarLegendMark:
	ld hl, $d812 ; $77fb
	ld c, $00 ; $77fe
Label_1b_7800:
	ld a, [hl+] ; $7800
	or a, a ; $7801
	jr nz, Label_1b_780c ; $7802
	ld a, c ; $7804
	inc a ; $7805
	ld c, a ; $7806
	cp a, $09 ; $7807
	jr nz, Label_1b_7800 ; $7809
	ret ; $780b
Label_1b_780c:
	ld hl, $d016 ; $780c
	ld de, $d08e ; $780f
	ld b, $02 ; $7812
	ld c, $02 ; $7814
	farcall FarPtr_CopyTilemapRect ; $7816
	ld hl, $d416 ; $7819
	ld de, $d48e ; $781c
	ld b, $02 ; $781f
	ld c, $02 ; $7821
	farcall FarPtr_CopyTilemapRect ; $7823
	ret ; $7826
	ldh a, [hWramBank] ; $7827
	push af ; $7829
	wram_bank $03 ; $782a
	ld a, [wMenuCursorY] ; $7830
	ld c, a ; $7833
	ld b, $00 ; $7834
Label_1b_7836:
	call DrawMinigameHighScoreNumber ; $7836
	inc c ; $7839
	ld a, b ; $783a
	inc b ; $783b
	ld a, b ; $783c
	cp a, $05 ; $783d
	jr nz, Label_1b_7836 ; $783f
	pop af ; $7841
	wram_bank ; $7842
	ret ; $7846
DrawMinigameHighScoreNumber:
	ld a, c ; $7847
	cp a, $08 ; $7848
	ret z ; $784a
	ld a, b ; $784b
	add a, a ; $784c
	ld hl, $7875 ; $784d
	add a, l ; $7850
	ld l, a ; $7851
	jr nc, Label_1b_7855 ; $7852
	inc h ; $7854
Label_1b_7855:
	ld a, [hl+] ; $7855
	ld d, [hl] ; $7856
	ld e, a ; $7857
	ld a, c ; $7858
	ld hl, $d812 ; $7859
	add a, l ; $785c
	ld l, a ; $785d
	jr nc, Label_1b_7861 ; $785e
	inc h ; $7860
Label_1b_7861:
	ld a, [hl] ; $7861
	or a, a ; $7862
	ret z ; $7863
	ld a, c ; $7864
	add a, a ; $7865
	ld hl, $d81b ; $7866
	add a, l ; $7869
	ld l, a ; $786a
	jr nc, Label_1b_786e ; $786b
	inc h ; $786d
Label_1b_786e:
	ld a, [hl+] ; $786e
	ld h, [hl] ; $786f
	ld l, a ; $7870
	farcall FarPtr_DrawDecimalNumberSprites_39 ; $7871
	ret ; $7874
	INCBIN "data/bank_01b/d_7875.bin" ; $7875, 10 bytes
CheckMinigameDataScrollable:
	push bc ; $787f
	push de ; $7880
	push hl ; $7881
	ld c, $04 ; $7882
	farcall FarPtr_GetUnlockedStarCharAtGridSlot ; $7884
	cp a, $15 ; $7887
	jr nz, Label_1b_7890 ; $7889
	pop hl ; $788b
	pop de ; $788c
	pop bc ; $788d
	xor a, a ; $788e
	ret ; $788f
Label_1b_7890:
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
	INCBIN "data/bank_01b/d_78bd.bin" ; $78bd, 1781 bytes
	ds 78, $ff ; $7fb2, fill
