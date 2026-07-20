SECTION "ROM Bank $1e", ROMX[$4000], BANK[$1e]

FarPtr_ShowMatchResultsScreen:
	dw ShowMatchResultsScreen ; $4000
FarPtr_StubNop_1e:
	dw StubNop_1e ; $4002
FarPtr_ProcessMatchRewards:
	dw ProcessMatchRewards ; $4004
FarPtr_1e_06:
	dw Func_1e_6afd ; $4006
FarPtr_ShowGameProgressScreen:
	dw ShowGameProgressScreen ; $4008
FarPtr_FetchAndDrawDialogueText:
	dw FetchAndDrawDialogueText ; $400a
FarPtr_WriteTextToTilemap:
	dw WriteTextToTilemap ; $400c
ShowMatchResultsScreen:
	clear_flag $1f, 7 ; $400e
	ld a, [wGameMode] ; $4011
	cp a, $05 ; $4014
	jr z, Label_1e_402a ; $4016
	cp a, $06 ; $4018
	jr z, Label_1e_402a ; $401a
	cp a, $07 ; $401c
	jr z, Label_1e_402a ; $401e
	cp a, $08 ; $4020
	test_flag $05, 7 ; $4022
	jr z, Label_1e_402a ; $4025
	set_flag $1f, 7 ; $4027
Label_1e_402a:
	ld a, c ; $402a
	or a, a ; $402b
	jr z, Label_1e_4031 ; $402c
	jp Label_1e_5438 ; $402e
Label_1e_4031:
	ld c, $10 ; $4031
	call BeginFadeOut ; $4033
	call WaitFadeEnd ; $4036
	sound $03 ; $4039
	push bc ; $403b
	farcall FarPtr_InitTextWindows ; $403c
	ld hl, wShadowTilemapBank ; $403f
	ld [hl], $03 ; $4042
	farcall FarPtr_PrepareGlyphBuffer ; $4044
	call ClearFrameTasks ; $4047
	call DisableLCDSafely ; $404a
	xor a, a ; $404d
	ldh [hScrollX], a ; $404e
	ldh [hScrollY], a ; $4050
	ld [wCameraX], a ; $4052
	ld [$c321], a ; $4055
	ld [wCameraY], a ; $4058
	ld [$c323], a ; $405b
	ld a, $90 ; $405e
	ldh [rWY], a ; $4060
	call ClearSpriteQueue ; $4062
	farcall FarPtr_InitActorEngine ; $4065
	pop bc ; $4068
	call Func_1e_40ac ; $4069
	call Func_1e_40be ; $406c
	call InitResultsScreenCharacters ; $406f
	call EnableLCD ; $4072
	call AdvanceFrame ; $4075
	ld a, $01 ; $4078
	ld hl, Func_1e_4a76 ; $407a
	call RegisterFrameTask ; $407d
	script_fade_in $10 ; $4080
	call WaitFadeEnd ; $4085
	call Func_1e_4b2c ; $4088
	ld c, $10 ; $408b
	call BeginFadeOut ; $408d
	call WaitFadeEnd ; $4090
	ld hl, $4a76 ; $4093
	call UnregisterFrameTask ; $4096
	farcall FarPtr_01_0a ; $4099
	wram_bank $06 ; $409c
	ld hl, $d005 ; $40a2
	ld a, [hl+] ; $40a5
	ld h, [hl] ; $40a6
	ld l, a ; $40a7
	ld a, [$d003] ; $40a8
	ret ; $40ab
Func_1e_40ac:
	wram_bank $06 ; $40ac
	ld a, c ; $40b2
	ld [$d000], a ; $40b3
	xor a, a ; $40b6
	ld [$d001], a ; $40b7
	ld [$d002], a ; $40ba
	ret ; $40bd
Func_1e_40be:
	call LoadResultsScreenGraphics ; $40be
	ld hl, $04d2 ; $40c1
	ld de, $d041 ; $40c4
	ld bc, $0020 ; $40c7
	call Func_1e_4563 ; $40ca
	ld hl, $04d3 ; $40cd
	call Func_1e_4563 ; $40d0
	ld hl, $04d4 ; $40d3
	call Func_1e_4563 ; $40d6
	call Func_1e_41b1 ; $40d9
	call Func_1e_489b ; $40dc
	wram_bank $03 ; $40df
	ld hl, $d000 ; $40e5
	ld de, $9800 ; $40e8
	ld c, $24 ; $40eb
	call QueueVRAMCopy ; $40ed
	wram_bank $02 ; $40f0
	ld hl, $d000 ; $40f6
	ld de, $b800 ; $40f9
	ld c, $24 ; $40fc
	call QueueVRAMCopy ; $40fe
	farcall FarPtr_UploadGlyphBuffer ; $4101
	ret ; $4104
LoadResultsScreenGraphics:
	ld hl, Palettes_1e_4c40 ; $4105
	ld de, $0006 ; $4108
	call LoadPaletteShadow ; $410b
	ld hl, Palettes_1e_4c40 ; $410e
	ld de, $0801 ; $4111
	call LoadPaletteShadow ; $4114
	wram_bank $01 ; $4117
	ld hl, Lz_1e_4c70 ; $411d
	ld de, $d000 ; $4120
	call DecompressData ; $4123
	ld hl, $d000 ; $4126
	ld de, $b000 ; $4129
	ld c, $80 ; $412c
	call QueueVRAMCopy ; $412e
	ld hl, $d800 ; $4131
	ld de, $a800 ; $4134
	ld c, $80 ; $4137
	call QueueVRAMCopy ; $4139
	wram_bank $01 ; $413c
	ld hl, Lz_1e_521f ; $4142
	ld de, $d000 ; $4145
	call DecompressData ; $4148
	ld hl, $d000 ; $414b
	ld bc, $0240 ; $414e
	call Func_1e_4187 ; $4151
	wram_bank $01 ; $4154
	ld hl, Lz_1e_52ec ; $415a
	ld de, $d000 ; $415d
	call DecompressData ; $4160
	ld hl, $d000 ; $4163
	ld bc, $0240 ; $4166
	call Func_1e_419c ; $4169
	wram_bank $01 ; $416c
	ld hl, Lz_1e_5343 ; $4172
	ld de, $d000 ; $4175
	call DecompressData ; $4178
	ld hl, $d000 ; $417b
	ld de, $9000 ; $417e
	ld c, $10 ; $4181
	call QueueVRAMCopy ; $4183
	ret ; $4186
Func_1e_4187:
	wram_bank $01 ; $4187
	ld d, [hl] ; $418d
	wram_bank $03 ; $418e
	ld [hl], d ; $4194
	inc hl ; $4195
	dec bc ; $4196
	ld a, b ; $4197
	or a, c ; $4198
	jr nz, Func_1e_4187 ; $4199
	ret ; $419b
Func_1e_419c:
	wram_bank $01 ; $419c
	ld d, [hl] ; $41a2
	wram_bank $02 ; $41a3
	ld [hl], d ; $41a9
	inc hl ; $41aa
	dec bc ; $41ab
	ld a, b ; $41ac
	or a, c ; $41ad
	jr nz, Func_1e_419c ; $41ae
	ret ; $41b0
Func_1e_41b1:
	wram_bank $03 ; $41b1
	ld a, $02 ; $41b7
	ld [$d000], a ; $41b9
	ld a, $04 ; $41bc
	ld [$d013], a ; $41be
	ld a, $07 ; $41c1
	ld [$d080], a ; $41c3
	ld a, $09 ; $41c6
	ld [$d093], a ; $41c8
	ld a, $03 ; $41cb
	ld hl, $d001 ; $41cd
	ld c, $12 ; $41d0
	call FillMemoryC ; $41d2
	ld a, $08 ; $41d5
	ld hl, $d081 ; $41d7
	ld c, $12 ; $41da
	call FillMemoryC ; $41dc
	ld a, $05 ; $41df
	ld [$d020], a ; $41e1
	ld [$d040], a ; $41e4
	ld [$d060], a ; $41e7
	ld a, $06 ; $41ea
	ld [$d033], a ; $41ec
	ld [$d053], a ; $41ef
	ld [$d073], a ; $41f2
	ld a, $20 ; $41f5
	ld hl, $d021 ; $41f7
	ld c, $12 ; $41fa
	call FillMemoryC ; $41fc
	ld hl, $d041 ; $41ff
	ld c, $12 ; $4202
	call FillMemoryC ; $4204
	ld hl, $d061 ; $4207
	ld c, $12 ; $420a
	call FillMemoryC ; $420c
	wram_bank $02 ; $420f
	xor a, a ; $4215
	ld hl, $d000 ; $4216
	ld c, $a0 ; $4219
	call FillMemoryC ; $421b
	ld hl, $d041 ; $421e
	call Func_1e_4572 ; $4221
	wram_bank $03 ; $4224
	ld a, $02 ; $422a
	ld [$d1a0], a ; $422c
	ld a, $04 ; $422f
	ld [$d1b3], a ; $4231
	ld a, $07 ; $4234
	ld [$d220], a ; $4236
	ld a, $09 ; $4239
	ld [$d233], a ; $423b
	ld a, $03 ; $423e
	ld hl, $d1a1 ; $4240
	ld c, $12 ; $4243
	call FillMemoryC ; $4245
	ld a, $08 ; $4248
	ld hl, $d221 ; $424a
	ld c, $12 ; $424d
	call FillMemoryC ; $424f
	ld a, $05 ; $4252
	ld [$d1c0], a ; $4254
	ld [$d1e0], a ; $4257
	ld [$d200], a ; $425a
	ld a, $06 ; $425d
	ld [$d1d3], a ; $425f
	ld [$d1f3], a ; $4262
	ld [$d213], a ; $4265
	ld a, $20 ; $4268
	ld hl, $d1c1 ; $426a
	ld c, $12 ; $426d
	call FillMemoryC ; $426f
	ld hl, $d1e1 ; $4272
	ld c, $12 ; $4275
	call FillMemoryC ; $4277
	ld hl, $d201 ; $427a
	ld c, $12 ; $427d
	call FillMemoryC ; $427f
	wram_bank $02 ; $4282
	xor a, a ; $4288
	ld hl, $d1a0 ; $4289
	ld c, $a0 ; $428c
	call FillMemoryC ; $428e
	wram_bank $03 ; $4291
	ld a, $02 ; $4297
	ld [$d0ce], a ; $4299
	ld a, $04 ; $429c
	ld [$d0d3], a ; $429e
	ld a, $07 ; $42a1
	ld [$d12e], a ; $42a3
	ld a, $09 ; $42a6
	ld [$d133], a ; $42a8
	ld a, $03 ; $42ab
	ld hl, $d0cf ; $42ad
	ld [hl+], a ; $42b0
	ld [hl+], a ; $42b1
	ld [hl+], a ; $42b2
	ld [hl+], a ; $42b3
	ld a, $08 ; $42b4
	ld hl, $d12f ; $42b6
	ld [hl+], a ; $42b9
	ld [hl+], a ; $42ba
	ld [hl+], a ; $42bb
	ld [hl+], a ; $42bc
	ld a, $05 ; $42bd
	ld [$d0ee], a ; $42bf
	ld [$d10e], a ; $42c2
	ld a, $06 ; $42c5
	ld [$d0f3], a ; $42c7
	ld [$d113], a ; $42ca
	xor a, a ; $42cd
	ld [$d0ef], a ; $42ce
	ld [$d0f2], a ; $42d1
	ld [$d10f], a ; $42d4
	ld [$d112], a ; $42d7
	ld hl, $04d5 ; $42da
	ld de, $d0f0 ; $42dd
	ld bc, $0020 ; $42e0
	call FetchAndDrawDialogueText ; $42e3
	ld hl, $04d6 ; $42e6
	ld de, $d110 ; $42e9
	ld bc, $0020 ; $42ec
	call FetchAndDrawDialogueText ; $42ef
	wram_bank $02 ; $42f2
	xor a, a ; $42f8
	ld hl, $d0ce ; $42f9
	ld c, $06 ; $42fc
	call FillMemoryC ; $42fe
	ld hl, $d0ee ; $4301
	ld c, $06 ; $4304
	call FillMemoryC ; $4306
	ld hl, $d10e ; $4309
	ld c, $06 ; $430c
	call FillMemoryC ; $430e
	ld hl, $d12e ; $4311
	ld c, $06 ; $4314
	call FillMemoryC ; $4316
	ld a, [wGameMode] ; $4319
	or a, a ; $431c
	jp z, Label_1e_4466 ; $431d
	cp a, $04 ; $4320
	jp z, Label_1e_44b1 ; $4322
	cp a, $01 ; $4325
	jp z, Label_1e_44f4 ; $4327
	cp a, $02 ; $432a
	jp z, Label_1e_451b ; $432c
	cp a, $03 ; $432f
	jp z, Label_1e_453c ; $4331
	cp a, $0a ; $4334
	jp z, Label_1e_44d3 ; $4336
	ret ; $4339
Func_1e_433a:
	wram_bank $01 ; $433a
	ld hl, Lz_1e_53df ; $4340
	ld de, $d000 ; $4343
	call DecompressData ; $4346
	ret ; $4349
Func_1e_434a:
	wram_bank $01 ; $434a
	ld hl, Lz_1e_53f2 ; $4350
	ld de, $d000 ; $4353
	call DecompressData ; $4356
	ret ; $4359
Func_1e_435a:
	or a, a ; $435a
	jr nz, Label_1e_4396 ; $435b
	ld hl, $d000 ; $435d
	ld de, $d160 ; $4360
	ld c, $07 ; $4363
	call Func_1e_440d ; $4365
	ld de, $d180 ; $4368
	ld c, $07 ; $436b
	call Func_1e_440d ; $436d
	wram_bank $03 ; $4370
	ld a, $20 ; $4376
	ld hl, $d1a1 ; $4378
	ld c, $05 ; $437b
	call FillMemoryC ; $437d
	ld a, $05 ; $4380
	ld [$d1a0], a ; $4382
	ld a, $08 ; $4385
	ld [$d1a6], a ; $4387
	wram_bank $02 ; $438a
	ld a, $08 ; $4390
	ld [$d1a6], a ; $4392
	ret ; $4395
Label_1e_4396:
	ld hl, $d000 ; $4396
	ld de, $d120 ; $4399
	ld c, $07 ; $439c
	call Func_1e_440d ; $439e
	ld de, $d140 ; $43a1
	ld c, $07 ; $43a4
	call Func_1e_440d ; $43a6
	wram_bank $03 ; $43a9
	ld a, $20 ; $43af
	ld hl, $d181 ; $43b1
	ld c, $12 ; $43b4
	call FillMemoryC ; $43b6
	ld hl, $d1a1 ; $43b9
	ld c, $12 ; $43bc
	call FillMemoryC ; $43be
	ld hl, $d161 ; $43c1
	ld c, $05 ; $43c4
	call FillMemoryC ; $43c6
	ld a, $04 ; $43c9
	ld [$d173], a ; $43cb
	ld a, $03 ; $43ce
	ld hl, $d167 ; $43d0
	ld c, $0c ; $43d3
	call FillMemoryC ; $43d5
	ld a, $05 ; $43d8
	ld [$d160], a ; $43da
	ld [$d180], a ; $43dd
	ld [$d1a0], a ; $43e0
	ld a, $06 ; $43e3
	ld [$d193], a ; $43e5
	ld [$d1b3], a ; $43e8
	ld a, $08 ; $43eb
	ld [$d166], a ; $43ed
	wram_bank $02 ; $43f0
	xor a, a ; $43f6
	ld hl, $d160 ; $43f7
	ld c, $14 ; $43fa
	call FillMemoryC ; $43fc
	ld hl, $d180 ; $43ff
	ld c, $14 ; $4402
	call FillMemoryC ; $4404
	ld a, $08 ; $4407
	ld [$d166], a ; $4409
	ret ; $440c
Func_1e_440d:
	wram_bank $01 ; $440d
	ld b, [hl] ; $4413
	wram_bank $03 ; $4414
	ld a, b ; $441a
	ld [de], a ; $441b
	wram_bank $02 ; $441c
	ld a, $08 ; $4422
	ld [de], a ; $4424
	inc hl ; $4425
	inc de ; $4426
	dec c ; $4427
	jr nz, Func_1e_440d ; $4428
	ret ; $442a
	wram_bank $03 ; $442b
	ld a, $20 ; $4431
	ld hl, $d1a1 ; $4433
	ld c, $05 ; $4436
	call FillMemoryC ; $4438
	wram_bank $03 ; $443b
	ld a, $05 ; $4441
	ld [$d1a0], a ; $4443
	wram_bank $02 ; $4446
	xor a, a ; $444c
	ld [$d1a0], a ; $444d
	ld a, $08 ; $4450
	ld [$d1a6], a ; $4452
	wram_bank $03 ; $4455
	ld a, $08 ; $445b
	ld [$d1a6], a ; $445d
	ret ; $4460
FillMemoryC:
	ld [hl+], a ; $4461
	dec c ; $4462
	jr nz, FillMemoryC ; $4463
	ret ; $4465
Label_1e_4466:
	test_flag $09, 7 ; $4466
	jr nz, Label_1e_4480 ; $4469
	ld a, [$c8a9] ; $446b
	cp a, $1d ; $446e
	jr z, Label_1e_44a0 ; $4470
	ld hl, $04d8 ; $4472
	ld de, $d1c3 ; $4475
	ld bc, $0020 ; $4478
	call Func_1e_4563 ; $447b
	jr Label_1e_448c ; $447e
Label_1e_4480:
	ld hl, $04d9 ; $4480
	ld de, $d1c2 ; $4483
	ld bc, $0020 ; $4486
	call Func_1e_4563 ; $4489
Label_1e_448c:
	ld a, [$c8a9] ; $448c
	add a, $79 ; $448f
	ld l, a ; $4491
	adc a, $01 ; $4492
	sub a, l ; $4494
	ld h, a ; $4495
	ld de, $d204 ; $4496
	ld bc, $0020 ; $4499
	call Func_1e_4563 ; $449c
	ret ; $449f
Label_1e_44a0:
	add a, $79 ; $44a0
	ld l, a ; $44a2
	adc a, $01 ; $44a3
	sub a, l ; $44a5
	ld h, a ; $44a6
	ld de, $d1e7 ; $44a7
	ld bc, $0020 ; $44aa
	call Func_1e_4563 ; $44ad
	ret ; $44b0
Label_1e_44b1:
	test_flag $1f, 7 ; $44b1
	jr nz, Label_1e_44c4 ; $44b4
	call Func_1e_433a ; $44b6
	xor a, a ; $44b9
	call Func_1e_435a ; $44ba
	call Func_1e_4606 ; $44bd
	call DrawSetsGamesScore ; $44c0
	ret ; $44c3
Label_1e_44c4:
	call Func_1e_434a ; $44c4
	ld a, $01 ; $44c7
	call Func_1e_435a ; $44c9
	call Func_1e_4634 ; $44cc
	call DrawSetsGamesScore ; $44cf
	ret ; $44d2
Label_1e_44d3:
	test_flag $1f, 7 ; $44d3
	jr nz, Label_1e_44e6 ; $44d6
	call Func_1e_433a ; $44d8
	xor a, a ; $44db
	call Func_1e_435a ; $44dc
	call Func_1e_488e ; $44df
	call DrawSetsGamesScore ; $44e2
	ret ; $44e5
Label_1e_44e6:
	call Func_1e_434a ; $44e6
	xor a, a ; $44e9
	call Func_1e_435a ; $44ea
	call Func_1e_488e ; $44ed
	call DrawSetsGamesScore ; $44f0
	ret ; $44f3
Label_1e_44f4:
	test_flag $1f, 7 ; $44f4
	jr nz, Label_1e_450a ; $44f7
	call Func_1e_433a ; $44f9
	xor a, a ; $44fc
	call Func_1e_435a ; $44fd
	call Func_1e_4717 ; $4500
	call Func_1e_4749 ; $4503
	call DrawSetsGamesScore ; $4506
	ret ; $4509
Label_1e_450a:
	call Func_1e_434a ; $450a
	xor a, a ; $450d
	call Func_1e_435a ; $450e
	call Func_1e_4717 ; $4511
	call Func_1e_4749 ; $4514
	call DrawSetsGamesScore ; $4517
	ret ; $451a
Label_1e_451b:
	test_flag $1f, 7 ; $451b
	jr nz, Label_1e_452e ; $451e
	call Func_1e_433a ; $4520
	xor a, a ; $4523
	call Func_1e_435a ; $4524
	call Func_1e_47f4 ; $4527
	call DrawSetsGamesScore ; $452a
	ret ; $452d
Label_1e_452e:
	call Func_1e_434a ; $452e
	xor a, a ; $4531
	call Func_1e_435a ; $4532
	call Func_1e_47f4 ; $4535
	call DrawSetsGamesScore ; $4538
	ret ; $453b
Label_1e_453c:
	test_flag $1f, 7 ; $453c
	jr nz, Label_1e_4552 ; $453f
	call Func_1e_433a ; $4541
	xor a, a ; $4544
	call Func_1e_435a ; $4545
	call Func_1e_4717 ; $4548
	call Func_1e_4881 ; $454b
	call DrawSetsGamesScore ; $454e
	ret ; $4551
Label_1e_4552:
	call Func_1e_434a ; $4552
	xor a, a ; $4555
	call Func_1e_435a ; $4556
	call Func_1e_4717 ; $4559
	call Func_1e_4881 ; $455c
	call DrawSetsGamesScore ; $455f
	ret ; $4562
Func_1e_4563:
	ldh a, [hWramBank] ; $4563
	push af ; $4565
	ld bc, $0012 ; $4566
	farcall FarPtr_RenderProportionalTextAt ; $4569
	pop af ; $456c
	wram_bank ; $456d
	ret ; $4571
Func_1e_4572:
	ldh a, [hWramBank] ; $4572
	push af ; $4574
	wram_bank $03 ; $4575
	ld a, $80 ; $457b
Label_1e_457d:
	cp a, $91 ; $457d
	jr z, Label_1e_4586 ; $457f
	ld [hl], a ; $4581
	inc hl ; $4582
	inc a ; $4583
	jr Label_1e_457d ; $4584
Label_1e_4586:
	pop af ; $4586
	wram_bank ; $4587
	ret ; $458b
Func_1e_458c:
	ldh a, [hWramBank] ; $458c
	push af ; $458e
	wram_bank $03 ; $458f
	ld a, $92 ; $4595
Label_1e_4597:
	cp a, $9e ; $4597
	jr z, Label_1e_45a0 ; $4599
	ld [hl], a ; $459b
	inc hl ; $459c
	inc a ; $459d
	jr Label_1e_4597 ; $459e
Label_1e_45a0:
	pop af ; $45a0
	wram_bank ; $45a1
	ret ; $45a5
Func_1e_45a6:
	ldh a, [hWramBank] ; $45a6
	push af ; $45a8
	wram_bank $03 ; $45a9
	ld a, $a4 ; $45af
Label_1e_45b1:
	cp a, $b5 ; $45b1
	jr z, Label_1e_45ba ; $45b3
	ld [hl], a ; $45b5
	inc hl ; $45b6
	inc a ; $45b7
	jr Label_1e_45b1 ; $45b8
Label_1e_45ba:
	pop af ; $45ba
	wram_bank ; $45bb
	ret ; $45bf
FetchAndDrawDialogueText:
	push bc ; $45c0
	xor a, a ; $45c1
	farcall FarPtr_AddTextIdOffset ; $45c2
	farcall FarPtr_FetchDialogueText ; $45c5
	pop bc ; $45c8
WriteTextToTilemap:
	ld hl, wTextBuffer ; $45c9
Label_1e_45cc:
	wram_bank $03 ; $45cc
	ld a, [hl+] ; $45d2
	or a, a ; $45d3
	ret z ; $45d4
	cp a, $de ; $45d5
	jr z, Label_1e_45e9 ; $45d7
	cp a, $df ; $45d9
	jr z, Label_1e_45e9 ; $45db
	ld [de], a ; $45dd
	wram_bank $02 ; $45de
	ld a, b ; $45e4
	ld [de], a ; $45e5
	inc de ; $45e6
	jr Label_1e_45cc ; $45e7
Label_1e_45e9:
	push de ; $45e9
	push bc ; $45ea
Label_1e_45eb:
	dec de ; $45eb
	dec c ; $45ec
	jr nz, Label_1e_45eb ; $45ed
	dec de ; $45ef
	ld c, a ; $45f0
	ld a, [de] ; $45f1
	cp a, $03 ; $45f2
	ld a, c ; $45f4
	jr nz, Label_1e_45f9 ; $45f5
	sub a, $d0 ; $45f7
Label_1e_45f9:
	ld [de], a ; $45f9
	wram_bank $02 ; $45fa
	ld a, b ; $4600
	ld [de], a ; $4601
	pop bc ; $4602
	pop de ; $4603
	jr Label_1e_45cc ; $4604
Func_1e_4606:
	ld hl, $ca00 ; $4606
	call CopyStringToTextBuffer ; $4609
	ld de, $d1c3 ; $460c
	call Func_1e_4683 ; $460f
	ld bc, $0020 ; $4612
	call WriteTextToTilemap ; $4615
	ld hl, $04d7 ; $4618
	ld de, $d1c9 ; $461b
	ld bc, $0020 ; $461e
	call FetchAndDrawDialogueText ; $4621
	ld hl, $ca80 ; $4624
	call CopyStringToTextBuffer ; $4627
	ld de, $d1cc ; $462a
	ld bc, $0020 ; $462d
	call WriteTextToTilemap ; $4630
	ret ; $4633
Func_1e_4634:
	ld hl, $ca00 ; $4634
	call CopyStringToTextBuffer ; $4637
	ld de, $d183 ; $463a
	call Func_1e_4683 ; $463d
	ld bc, $0020 ; $4640
	call WriteTextToTilemap ; $4643
	ld hl, $ca40 ; $4646
	call CopyStringToTextBuffer ; $4649
	ld de, $d1c3 ; $464c
	call Func_1e_4683 ; $464f
	ld bc, $0020 ; $4652
	call WriteTextToTilemap ; $4655
	ld hl, $04d7 ; $4658
	ld de, $d1a9 ; $465b
	ld bc, $0020 ; $465e
	call FetchAndDrawDialogueText ; $4661
	ld hl, $ca80 ; $4664
	call CopyStringToTextBuffer ; $4667
	ld de, $d18c ; $466a
	ld bc, $0020 ; $466d
	call WriteTextToTilemap ; $4670
	ld hl, $cac0 ; $4673
	call CopyStringToTextBuffer ; $4676
	ld de, $d1cc ; $4679
	ld bc, $0020 ; $467c
	call WriteTextToTilemap ; $467f
	ret ; $4682
Func_1e_4683:
	ld c, $00 ; $4683
	ld hl, wTextBuffer ; $4685
Label_1e_4688:
	ld a, [hl+] ; $4688
	or a, a ; $4689
	jr z, Label_1e_4697 ; $468a
	cp a, $de ; $468c
	jr z, Label_1e_4688 ; $468e
	cp a, $df ; $4690
	jr z, Label_1e_4688 ; $4692
	inc c ; $4694
	jr Label_1e_4688 ; $4695
Label_1e_4697:
	ld a, $05 ; $4697
	cp a, c ; $4699
	ret nc ; $469a
	ld a, c ; $469b
	sub a, $05 ; $469c
	ld c, a ; $469e
Label_1e_469f:
	dec de ; $469f
	dec c ; $46a0
	jr nz, Label_1e_469f ; $46a1
	ret ; $46a3
DrawSetsGamesScore:
	ld hl, $04e1 ; $46a4
	ld de, $d202 ; $46a7
	ld bc, $0020 ; $46aa
	call FetchAndDrawDialogueText ; $46ad
	ld a, [wPlayer1SetsWon] ; $46b0
	ld de, $d206 ; $46b3
	call FormatAndDrawNumber ; $46b6
	ld hl, $04e3 ; $46b9
	ld de, $d207 ; $46bc
	ld bc, $0020 ; $46bf
	call FetchAndDrawDialogueText ; $46c2
	ld a, [wPlayer2SetsWon] ; $46c5
	ld de, $d208 ; $46c8
	call FormatAndDrawNumber ; $46cb
	ld hl, $04e2 ; $46ce
	ld de, $d20b ; $46d1
	ld bc, $0020 ; $46d4
	call FetchAndDrawDialogueText ; $46d7
	ld a, [wPlayer1GamesWon] ; $46da
	ld de, $d20f ; $46dd
	call FormatAndDrawNumber ; $46e0
	ld hl, $04e3 ; $46e3
	ld de, $d210 ; $46e6
	call FetchAndDrawDialogueText ; $46e9
	ld a, [wPlayer2GamesWon] ; $46ec
	ld de, $d211 ; $46ef
	call FormatAndDrawNumber ; $46f2
	ret ; $46f5
FormatAndDrawNumber:
	ld h, $00 ; $46f6
	ld l, a ; $46f8
	push de ; $46f9
	ld de, wTextBuffer ; $46fa
	ld a, $01 ; $46fd
	call FormatDecimalNumberUnsigned ; $46ff
	pop de ; $4702
	ld hl, wTextBuffer ; $4703
	ld bc, $0020 ; $4706
	call WriteTextToTilemap ; $4709
	ret ; $470c
CopyStringToTextBuffer:
	ld de, wTextBuffer ; $470d
Label_1e_4710:
	ld a, [hl+] ; $4710
	ld [de], a ; $4711
	or a, a ; $4712
	ret z ; $4713
	inc de ; $4714
	jr Label_1e_4710 ; $4715
Func_1e_4717:
	test_flag $1f, 7 ; $4717
	jr nz, Label_1e_4728 ; $471a
	test_flag $0a, 7 ; $471c
	jr nz, Label_1e_473c ; $471f
	test_flag $0a, 3 ; $4721
	jr nz, Label_1e_4737 ; $4724
	jr Label_1e_4732 ; $4726
Label_1e_4728:
	test_flag $08, 6 ; $4728
	jr nz, Label_1e_473c ; $472b
	test_flag $08, 2 ; $472d
	jr nz, Label_1e_4737 ; $4730
Label_1e_4732:
	ld hl, $04da ; $4732
	jr Label_1e_473f ; $4735
Label_1e_4737:
	ld hl, $04db ; $4737
	jr Label_1e_473f ; $473a
Label_1e_473c:
	ld hl, $04dc ; $473c
Label_1e_473f:
	ld de, $d1c1 ; $473f
	ld bc, $0020 ; $4742
	call Func_1e_4563 ; $4745
	ret ; $4748
Func_1e_4749:
	ld hl, wTextBuffer ; $4749
	test_flag $1f, 7 ; $474c
	jr nz, Label_1e_4790 ; $474f
	ld a, $34 ; $4751
	ld [hl], a ; $4753
	test_flag $0a, 7 ; $4754
	jr nz, Label_1e_47d7 ; $4757
	test_flag $0a, 3 ; $4759
	jr nz, Label_1e_4778 ; $475c
	test_flag $0a, 0 ; $475e
	jp z, Label_1e_47c1 ; $4761
	dec [hl] ; $4764
	test_flag $0a, 1 ; $4765
	jp z, Label_1e_47c1 ; $4768
	dec [hl] ; $476b
	test_flag $0a, 2 ; $476c
	jr z, Label_1e_47c1 ; $476f
	dec [hl] ; $4771
	test_flag $0a, 3 ; $4772
	jr z, Label_1e_47c1 ; $4775
	ret ; $4777
Label_1e_4778:
	test_flag $0a, 4 ; $4778
	jr z, Label_1e_47c1 ; $477b
	dec [hl] ; $477d
	test_flag $0a, 5 ; $477e
	jr z, Label_1e_47c1 ; $4781
	dec [hl] ; $4783
	test_flag $0a, 6 ; $4784
	jr z, Label_1e_47c1 ; $4787
	dec [hl] ; $4789
	test_flag $0a, 7 ; $478a
	jr z, Label_1e_47c1 ; $478d
	ret ; $478f
Label_1e_4790:
	ld a, $33 ; $4790
	ld [hl], a ; $4792
	test_flag $08, 6 ; $4793
	jr nz, Label_1e_47d7 ; $4796
	test_flag $08, 2 ; $4798
	jr nz, Label_1e_47af ; $479b
	test_flag $08, 0 ; $479d
	jr z, Label_1e_47c1 ; $47a0
	dec [hl] ; $47a2
	test_flag $08, 1 ; $47a3
	jr z, Label_1e_47c1 ; $47a6
	dec [hl] ; $47a8
	test_flag $08, 2 ; $47a9
	jr z, Label_1e_47c1 ; $47ac
	ret ; $47ae
Label_1e_47af:
	test_flag $08, 4 ; $47af
	jr z, Label_1e_47c1 ; $47b2
	dec [hl] ; $47b4
	test_flag $08, 5 ; $47b5
	jr z, Label_1e_47c1 ; $47b8
	dec [hl] ; $47ba
	test_flag $08, 6 ; $47bb
	jr z, Label_1e_47c1 ; $47be
	ret ; $47c0
Label_1e_47c1:
	ld a, [hl] ; $47c1
	sub a, $30 ; $47c2
	ld l, a ; $47c4
	xor a, a ; $47c5
	ld h, a ; $47c6
	farcall FarPtr_PushTextArgNumber ; $47c7
	ld hl, $04dd ; $47ca
	ld de, $d1ca ; $47cd
	ld bc, $0020 ; $47d0
	call Func_1e_4563 ; $47d3
	ret ; $47d6
Label_1e_47d7:
	ldh a, [hWramBank] ; $47d7
	push af ; $47d9
	wram_bank $03 ; $47da
	ld hl, $d1ca ; $47e0
	ld a, $20 ; $47e3
	ld [hl+], a ; $47e5
	ld [hl+], a ; $47e6
	ld [hl+], a ; $47e7
	ld [hl+], a ; $47e8
	ld [hl+], a ; $47e9
	ld [hl+], a ; $47ea
	ld [hl+], a ; $47eb
	ld [hl+], a ; $47ec
	ld [hl], a ; $47ed
	pop af ; $47ee
	wram_bank ; $47ef
	ret ; $47f3
Func_1e_47f4:
	ld hl, $04de ; $47f4
	ld de, $d1c1 ; $47f7
	ld bc, $0020 ; $47fa
	call Func_1e_4563 ; $47fd
	ld hl, wTextBuffer ; $4800
	ld a, $31 ; $4803
	ld [hl], a ; $4805
	test_flag $1f, 7 ; $4806
	jr nz, Label_1e_4821 ; $4809
	test_flag $07, 7 ; $480b
	jr z, Label_1e_4831 ; $480e
	inc [hl] ; $4810
	test_flag $07, 6 ; $4811
	jr z, Label_1e_4831 ; $4814
	test_flag $07, 5 ; $4816
	jr z, Label_1e_4847 ; $4819
	test_flag $07, 4 ; $481b
	jr z, Label_1e_4857 ; $481e
	ret ; $4820
Label_1e_4821:
	test_flag $06, 7 ; $4821
	jr z, Label_1e_4831 ; $4824
	test_flag $06, 6 ; $4826
	jr z, Label_1e_4847 ; $4829
	test_flag $06, 5 ; $482b
	jr z, Label_1e_4857 ; $482e
	ret ; $4830
Label_1e_4831:
	ld a, [hl] ; $4831
	sub a, $30 ; $4832
	ld l, a ; $4834
	xor a, a ; $4835
	ld h, a ; $4836
	farcall FarPtr_PushTextArgNumber ; $4837
	ld hl, $04df ; $483a
	ld de, $d1ca ; $483d
	ld bc, $0020 ; $4840
	call Func_1e_4563 ; $4843
	ret ; $4846
Label_1e_4847:
	call Func_1e_4867 ; $4847
	ld hl, $04e6 ; $484a
	ld de, $d1c9 ; $484d
	ld bc, $0020 ; $4850
	call Func_1e_4563 ; $4853
	ret ; $4856
Label_1e_4857:
	call Func_1e_4867 ; $4857
	ld hl, $04e5 ; $485a
	ld de, $d1ca ; $485d
	ld bc, $0020 ; $4860
	call Func_1e_4563 ; $4863
	ret ; $4866
Func_1e_4867:
	wram_bank $03 ; $4867
	ld a, $03 ; $486d
	ld [$d1aa], a ; $486f
	ld hl, $d1ca ; $4872
	ld a, $20 ; $4875
	ld [hl+], a ; $4877
	ld [hl+], a ; $4878
	ld [hl+], a ; $4879
	ld [hl+], a ; $487a
	ld [hl+], a ; $487b
	ld [hl+], a ; $487c
	ld [hl+], a ; $487d
	ld [hl+], a ; $487e
	ld [hl], a ; $487f
	ret ; $4880
Func_1e_4881:
	ld hl, $04e0 ; $4881
	ld de, $d1cb ; $4884
	ld bc, $0020 ; $4887
	call Func_1e_4563 ; $488a
	ret ; $488d
Func_1e_488e:
	ld hl, $04ea ; $488e
	ld de, $d1c1 ; $4891
	ld bc, $0020 ; $4894
	call Func_1e_4563 ; $4897
	ret ; $489a
Func_1e_489b:
	ld a, [wGameMode] ; $489b
	cp a, $04 ; $489e
	ret z ; $48a0
	wram_bank $01 ; $48a1
	ld hl, Lz_1e_5405 ; $48a7
	ld de, $d000 ; $48aa
	call DecompressData ; $48ad
	ld hl, Lz_1e_5421 ; $48b0
	ld de, $d0c8 ; $48b3
	call DecompressData ; $48b6
	ld hl, $d000 ; $48b9
	ld de, $d0a0 ; $48bc
	ld c, $08 ; $48bf
	call Func_1e_4962 ; $48c1
	ld de, $d0c0 ; $48c4
	ld c, $08 ; $48c7
	call Func_1e_4962 ; $48c9
	ld de, $d0e0 ; $48cc
	ld c, $08 ; $48cf
	call Func_1e_4962 ; $48d1
	ld de, $d100 ; $48d4
	ld c, $08 ; $48d7
	call Func_1e_4962 ; $48d9
	ld de, $d120 ; $48dc
	ld c, $08 ; $48df
	call Func_1e_4962 ; $48e1
	wram_bank $03 ; $48e4
	ld a, $20 ; $48ea
	ld hl, $d0a0 ; $48ec
	call Fill7Bytes ; $48ef
	ld hl, $d0c0 ; $48f2
	call Fill7Bytes ; $48f5
	ld hl, $d0e0 ; $48f8
	call Fill7Bytes ; $48fb
	ld hl, $d100 ; $48fe
	call Fill7Bytes ; $4901
	ld hl, wStoryModeNameOfMainCharacter ; $4904
	call CopyStringToTextBuffer ; $4907
	ld de, $d0c0 ; $490a
	ld bc, $0020 ; $490d
	call WriteTextToTilemap ; $4910
	ld hl, $04e4 ; $4913
	ld de, $d101 ; $4916
	ld bc, $0020 ; $4919
	call FetchAndDrawDialogueText ; $491c
	ld a, [$c918] ; $491f
	ld h, $00 ; $4922
	ld l, a ; $4924
	ld a, $02 ; $4925
	ld de, wTextBuffer ; $4927
	call FormatDecimalNumberUnsigned ; $492a
	ld hl, wTextBuffer ; $492d
	ld de, $d104 ; $4930
	ld bc, $0020 ; $4933
	call WriteTextToTilemap ; $4936
	wram_bank $02 ; $4939
	ld a, $04 ; $493f
	ld hl, $d0a0 ; $4941
	call Fill7Bytes ; $4944
	ld hl, $d0c0 ; $4947
	call Fill7Bytes ; $494a
	ld hl, $d0e0 ; $494d
	call Fill7Bytes ; $4950
	ld hl, $d100 ; $4953
	call Fill7Bytes ; $4956
	ret ; $4959
Fill7Bytes:
	ld [hl+], a ; $495a
	ld [hl+], a ; $495b
	ld [hl+], a ; $495c
	ld [hl+], a ; $495d
	ld [hl+], a ; $495e
	ld [hl+], a ; $495f
	ld [hl], a ; $4960
	ret ; $4961
Func_1e_4962:
	wram_bank $01 ; $4962
	ld b, [hl] ; $4968
	wram_bank $03 ; $4969
	ld a, b ; $496f
	ld [de], a ; $4970
	wram_bank $01 ; $4971
	push hl ; $4977
	ld a, $c8 ; $4978
	add a, l ; $497a
	ld l, a ; $497b
	jr nc, Label_1e_497f ; $497c
	inc h ; $497e
Label_1e_497f:
	ld b, [hl] ; $497f
	wram_bank $02 ; $4980
	ld a, b ; $4986
	ld [de], a ; $4987
	pop hl ; $4988
	inc hl ; $4989
	inc de ; $498a
	dec c ; $498b
	jr nz, Func_1e_4962 ; $498c
	ret ; $498e
InitResultsScreenCharacters:
	ld a, [$c8b9] ; $498f
	srl a ; $4992
	add a, $04 ; $4994
	ld a, a ; $4996
	wram_bank ; $4997
	ld bc, $df00 ; $499b
	ld a, [wGameMode] ; $499e
	or a, a ; $49a1
	jr nz, Label_1e_49ae ; $49a2
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $49a4
	ld d, a ; $49a7
	ld a, [wStoryModeMainCharacterOverworldSpriteColor] ; $49a8
	ld e, a ; $49ab
	jr Label_1e_49c8 ; $49ac
Label_1e_49ae:
	ld a, [$c8b9] ; $49ae
	srl a ; $49b1
	or a, a ; $49b3
	jr nz, Label_1e_49c0 ; $49b4
	ld a, [wPlayer1CurrentMainCharacter] ; $49b6
	ld d, a ; $49b9
	ld a, [$ca0c] ; $49ba
	ld e, a ; $49bd
	jr Label_1e_49c8 ; $49be
Label_1e_49c0:
	ld a, [wPlayer2CurrentMainCharacter] ; $49c0
	ld d, a ; $49c3
	ld a, [$ca8c] ; $49c4
	ld e, a ; $49c7
Label_1e_49c8:
	ld a, d ; $49c8
	push af ; $49c9
	ld a, $00 ; $49ca
	farcall FarPtr_InitChar ; $49cc
	ld a, $0f ; $49cf
	ld [$df37], a ; $49d1
	ld de, $a000 ; $49d4
	ld hl, $df26 ; $49d7
	ld a, e ; $49da
	ld [hl+], a ; $49db
	ld [hl], d ; $49dc
	ld hl, $df36 ; $49dd
	ld [hl], $00 ; $49e0
	ld bc, $df00 ; $49e2
	ld d, $03 ; $49e5
	farcall FarPtr_SetCharAnimation ; $49e7
	pop af ; $49ea
	farcall FarPtr_GetCharPaletteIndex ; $49eb
	ld de, $0f01 ; $49ee
	farcall FarPtr_LoadIndexedPaletteThunk ; $49f1
	wram_bank $06 ; $49f4
	ld a, [$d000] ; $49fa
	or a, a ; $49fd
	jr nz, Label_1e_4a0a ; $49fe
	wram_bank $04 ; $4a00
	test_flag $1f, 7 ; $4a06
	ret z ; $4a09
Label_1e_4a0a:
	ld a, [$c8b9] ; $4a0a
	srl a ; $4a0d
	add a, $06 ; $4a0f
	ld a, a ; $4a11
	wram_bank ; $4a12
	ld bc, $df00 ; $4a16
	ld a, [wGameMode] ; $4a19
	or a, a ; $4a1c
	jr nz, Label_1e_4a29 ; $4a1d
	ld a, [wStoryModePartnerCharacterOverworldSprite] ; $4a1f
	ld d, a ; $4a22
	ld a, [wStoryModePartnerCharacterOverworldSpriteColor] ; $4a23
	ld e, a ; $4a26
	jr Label_1e_4a43 ; $4a27
Label_1e_4a29:
	ld a, [$c8b9] ; $4a29
	srl a ; $4a2c
	or a, a ; $4a2e
	jr nz, Label_1e_4a3b ; $4a2f
	ld a, [wPlayer1CurrentPartnerCharacter] ; $4a31
	ld d, a ; $4a34
	ld a, [$ca4c] ; $4a35
	ld e, a ; $4a38
	jr Label_1e_4a43 ; $4a39
Label_1e_4a3b:
	ld a, [wPlayer2CurrentPartnerCharacter] ; $4a3b
	ld d, a ; $4a3e
	ld a, [$cacc] ; $4a3f
	ld e, a ; $4a42
Label_1e_4a43:
	ld a, d ; $4a43
	push af ; $4a44
	ld a, $02 ; $4a45
	farcall FarPtr_InitChar ; $4a47
	ld a, $0e ; $4a4a
	ld [$df37], a ; $4a4c
	ld de, $a100 ; $4a4f
	ld hl, $df26 ; $4a52
	ld a, e ; $4a55
	ld [hl+], a ; $4a56
	ld [hl], d ; $4a57
	ld hl, $df36 ; $4a58
	ld [hl], $10 ; $4a5b
	ld bc, $df00 ; $4a5d
	ld d, $03 ; $4a60
	farcall FarPtr_SetCharAnimation ; $4a62
	pop af ; $4a65
	farcall FarPtr_GetCharPaletteIndex ; $4a66
	ld de, $0e01 ; $4a69
	farcall FarPtr_LoadIndexedPaletteThunk ; $4a6c
	wram_bank $04 ; $4a6f
	ret ; $4a75
Func_1e_4a76:
	wram_bank $04 ; $4a76
	xor a, a ; $4a7c
	call Func_1e_4aa8 ; $4a7d
	ld hl, $df80 ; $4a80
	farcall FarPtr_DrawCharSprite ; $4a83
	wram_bank $04 ; $4a86
	test_flag $1f, 7 ; $4a8c
	ret z ; $4a8f
	wram_bank $06 ; $4a90
	ld a, $01 ; $4a96
	call Func_1e_4aa8 ; $4a98
	ld hl, $df80 ; $4a9b
	farcall FarPtr_DrawCharSprite ; $4a9e
	wram_bank $04 ; $4aa1
	ret ; $4aa7
Func_1e_4aa8:
	push af ; $4aa8
	ld hl, $df00 ; $4aa9
	ld b, h ; $4aac
	ld c, l ; $4aad
	farcall FarPtr_StepCharAnimation ; $4aae
	ld d, $00 ; $4ab1
	push de ; $4ab3
	farcall FarPtr_ReloadCharFacingTiles ; $4ab4
	pop de ; $4ab7
	ld a, d ; $4ab8
	add a, $24 ; $4ab9
	ld l, a ; $4abb
	adc a, $4b ; $4abc
	sub a, l ; $4abe
	ld h, a ; $4abf
	ld b, [hl] ; $4ac0
	pop af ; $4ac1
	push af ; $4ac2
	or a, a ; $4ac3
	jr nz, Label_1e_4acb ; $4ac4
	ld a, [$ca0e] ; $4ac6
	jr Label_1e_4ace ; $4ac9
Label_1e_4acb:
	ld a, [$ca8e] ; $4acb
Label_1e_4ace:
	or a, a ; $4ace
	jr z, Label_1e_4ad5 ; $4acf
	ld a, $20 ; $4ad1
	xor a, b ; $4ad3
	ld b, a ; $4ad4
Label_1e_4ad5:
	ld hl, $df36 ; $4ad5
	ld a, [hl+] ; $4ad8
	ld c, a ; $4ad9
	ld a, [hl] ; $4ada
	or a, b ; $4adb
	ld b, a ; $4adc
	pop af ; $4add
	push af ; $4ade
	push bc ; $4adf
	push de ; $4ae0
	or a, a ; $4ae1
	jr nz, Label_1e_4af5 ; $4ae2
	test_flag $1f, 7 ; $4ae4
	jr z, Label_1e_4aef ; $4ae7
	ld d, $48 ; $4ae9
	ld e, $56 ; $4aeb
	jr Label_1e_4af9 ; $4aed
Label_1e_4aef:
	ld d, $54 ; $4aef
	ld e, $56 ; $4af1
	jr Label_1e_4af9 ; $4af3
Label_1e_4af5:
	ld d, $60 ; $4af5
	ld e, $56 ; $4af7
Label_1e_4af9:
	ld a, d ; $4af9
	ld [$df53], a ; $4afa
	ld a, e ; $4afd
	ld [$df54], a ; $4afe
	pop hl ; $4b01
	add hl, hl ; $4b02
	add hl, hl ; $4b03
	add hl, hl ; $4b04
	pop bc ; $4b05
	pop af ; $4b06
	push hl ; $4b07
	ld hl, $df80 ; $4b08
	ld a, c ; $4b0b
	ld [hl+], a ; $4b0c
	ld a, b ; $4b0d
	ld [hl+], a ; $4b0e
	ld a, e ; $4b0f
	ld [hl+], a ; $4b10
	ld a, d ; $4b11
	ld [hl+], a ; $4b12
	ld a, [$df1d] ; $4b13
	ld [hl+], a ; $4b16
	ld a, [$df1c] ; $4b17
	ld [hl+], a ; $4b1a
	ld a, [$df1b] ; $4b1b
	ld [hl+], a ; $4b1e
	pop af ; $4b1f
	add a, $80 ; $4b20
	ld [hl+], a ; $4b22
	ret ; $4b23
	INCBIN "data/bank_01e/d_4b24.bin" ; $4b24, 8 bytes
Func_1e_4b2c:
	call Func_1e_4b46 ; $4b2c
	call AdvanceFrame ; $4b2f
	ldh a, [hInputRisingEdge] ; $4b32
	bit PADB_UP, a ; $4b34
	jr nz, Label_1e_4b61 ; $4b36
	bit 7, a ; $4b38
	jr nz, Label_1e_4b61 ; $4b3a
	bit 0, a ; $4b3c
	jr nz, Label_1e_4b73 ; $4b3e
	bit 1, a ; $4b40
	jr nz, Label_1e_4baf ; $4b42
	jr Func_1e_4b2c ; $4b44
Func_1e_4b46:
	wram_bank $06 ; $4b46
	ld a, [$d001] ; $4b4c
	or a, a ; $4b4f
	jr nz, Label_1e_4b57 ; $4b50
	ld de, $7a3c ; $4b52
	jr Label_1e_4b5a ; $4b55
Label_1e_4b57:
	ld de, $7a44 ; $4b57
Label_1e_4b5a:
	ld bc, $088e ; $4b5a
	call QueueSprite ; $4b5d
	ret ; $4b60
Label_1e_4b61:
	sound $5e ; $4b61
	wram_bank $06 ; $4b63
	ld a, [$d001] ; $4b69
	xor a, $01 ; $4b6c
	ld [$d001], a ; $4b6e
	jr Func_1e_4b2c ; $4b71
Label_1e_4b73:
	sound $5f ; $4b73
	wram_bank $06 ; $4b75
	ld a, [$d002] ; $4b7b
	or a, a ; $4b7e
	jr nz, Label_1e_4b91 ; $4b7f
	ld a, [$d001] ; $4b81
	or a, a ; $4b84
	jr z, Label_1e_4ba0 ; $4b85
	ld a, $01 ; $4b87
	ld [$d002], a ; $4b89
	call Func_1e_4bca ; $4b8c
	jr Func_1e_4b2c ; $4b8f
Label_1e_4b91:
	ld a, [$d001] ; $4b91
	or a, a ; $4b94
	jr z, Label_1e_4ba6 ; $4b95
Label_1e_4b97:
	xor a, a ; $4b97
	ld [$d002], a ; $4b98
	call Func_1e_4bca ; $4b9b
	jr Func_1e_4b2c ; $4b9e
Label_1e_4ba0:
	ld a, $01 ; $4ba0
	ld [$d003], a ; $4ba2
	ret ; $4ba5
Label_1e_4ba6:
	ld a, [$d002] ; $4ba6
	add a, $ff ; $4ba9
	ld [$d003], a ; $4bab
	ret ; $4bae
Label_1e_4baf:
	sound $62 ; $4baf
	wram_bank $06 ; $4bb1
	ld a, [$d002] ; $4bb7
	or a, a ; $4bba
	jr nz, Label_1e_4bc8 ; $4bbb
	ld a, $ff ; $4bbd
	ld [$d003], a ; $4bbf
	ld a, $00 ; $4bc2
	ld [wMenuSlideDirection], a ; $4bc4
	ret ; $4bc7
Label_1e_4bc8:
	jr Label_1e_4b97 ; $4bc8
Func_1e_4bca:
	ld a, [$d002] ; $4bca
	or a, a ; $4bcd
	jr nz, Label_1e_4bef ; $4bce
	xor a, a ; $4bd0
	ld [$d001], a ; $4bd1
	call Func_1e_4c15 ; $4bd4
	ld hl, $d041 ; $4bd7
	call Func_1e_4572 ; $4bda
	ld hl, $d000 ; $4bdd
	ld de, $9800 ; $4be0
	ld c, $08 ; $4be3
	call QueueVRAMCopy ; $4be5
	wram_bank $06 ; $4be8
	ret ; $4bee
Label_1e_4bef:
	ld a, $01 ; $4bef
	ld [$d001], a ; $4bf1
	call Func_1e_4c15 ; $4bf4
	ld hl, $d021 ; $4bf7
	call Func_1e_458c ; $4bfa
	ld hl, $d061 ; $4bfd
	call Func_1e_45a6 ; $4c00
	ld hl, $d000 ; $4c03
	ld de, $9800 ; $4c06
	ld c, $08 ; $4c09
	call QueueVRAMCopy ; $4c0b
	wram_bank $06 ; $4c0e
	ret ; $4c14
Func_1e_4c15:
	wram_bank $03 ; $4c15
	ld a, $03 ; $4c1b
	ld hl, $d001 ; $4c1d
	ld c, $12 ; $4c20
	call FillMemoryC ; $4c22
	ld a, $20 ; $4c25
	ld hl, $d021 ; $4c27
	ld c, $12 ; $4c2a
	call FillMemoryC ; $4c2c
	ld hl, $d041 ; $4c2f
	ld c, $12 ; $4c32
	call FillMemoryC ; $4c34
	ld hl, $d061 ; $4c37
	ld c, $12 ; $4c3a
	call FillMemoryC ; $4c3c
	ret ; $4c3f
Palettes_1e_4c40:
	; $4c40, 48 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $4d20, $015f, $0000, $7fff ; pal 0: #004a9c #ff5200 #000000 #ffffff
	dw $7fff, $2fec, $1b47, $1205 ; pal 1: #ffffff #62ff5a #39d531 #298320
	dw $7fff, $6714, $460c, $7f00 ; pal 2: #ffffff #a4c5cd #62838b #00c5ff
	dw $7fff, $460c, $2504, $6714 ; pal 3: #ffffff #62838b #20414a #a4c5cd
	dw $7fff, $7fff, $4254, $0000 ; pal 4: #ffffff #ffffff #a49483 #000000
	dw $7f00, $7fff, $7c1f, $7c00 ; pal 5: #00c5ff #ffffff #ff00ff #0000ff
Lz_1e_4c70:
	INCBIN "data/bank_01e/d_4c70.bin" ; $4c70, 1455 bytes
Lz_1e_521f:
	INCBIN "data/bank_01e/d_521f.bin" ; $521f, 205 bytes
Lz_1e_52ec:
	INCBIN "data/bank_01e/d_52ec.bin" ; $52ec, 87 bytes
Lz_1e_5343:
	INCBIN "data/bank_01e/d_5343.bin" ; $5343, 156 bytes
Lz_1e_53df:
	INCBIN "data/bank_01e/d_53df.bin" ; $53df, 19 bytes
Lz_1e_53f2:
	INCBIN "data/bank_01e/d_53f2.bin" ; $53f2, 19 bytes
Lz_1e_5405:
	INCBIN "data/bank_01e/d_5405.bin" ; $5405, 28 bytes
Lz_1e_5421:
	INCBIN "data/bank_01e/d_5421.bin" ; $5421, 23 bytes
Label_1e_5438:
	call Func_1e_5bbb ; $5438
	or a, a ; $543b
	ret z ; $543c
	farcall FarPtr_01_0a ; $543d
	farcall FarPtr_InitTextWindows ; $5440
	ld hl, wShadowTilemapBank ; $5443
	ld [hl], $03 ; $5446
	farcall FarPtr_PrepareGlyphBuffer ; $5448
	call ClearFrameTasks ; $544b
	call DisableLCDSafely ; $544e
	xor a, a ; $5451
	ldh [hScrollX], a ; $5452
	ldh [hScrollY], a ; $5454
	ld [wCameraX], a ; $5456
	ld [$c321], a ; $5459
	ld [wCameraY], a ; $545c
	ld [$c323], a ; $545f
	ld a, $90 ; $5462
	ldh [rWY], a ; $5464
	call ClearSpriteQueue ; $5466
	farcall FarPtr_InitActorEngine ; $5469
	call Func_1e_54bb ; $546c
	call Func_1e_54f5 ; $546f
	call InitResultsScreenCharacters ; $5472
	call EnableLCD ; $5475
	call AdvanceFrame ; $5478
	ld a, $01 ; $547b
	ld hl, Func_1e_5914 ; $547d
	call RegisterFrameTask ; $5480
	ld a, $01 ; $5483
	ld hl, Func_1e_5a4e ; $5485
	call RegisterFrameTask ; $5488
	script_fade_in $10 ; $548b
	call WaitFadeEnd ; $5490
	call WaitFramesCmd ; $5493
	db $14 ; $5496 inline arg
	call Func_1e_5b03 ; $5497
	ld c, $10 ; $549a
	call BeginFadeOut ; $549c
	call WaitFadeEnd ; $549f
	ld hl, $5914 ; $54a2
	call UnregisterFrameTask ; $54a5
	ld hl, $5a4e ; $54a8
	call UnregisterFrameTask ; $54ab
	wram_bank $06 ; $54ae
	ld hl, $d005 ; $54b4
	ld a, [hl+] ; $54b7
	ld h, [hl] ; $54b8
	ld l, a ; $54b9
	ret ; $54ba
Func_1e_54bb:
	wram_bank $06 ; $54bb
	xor a, a ; $54c1
	ld hl, $d004 ; $54c2
	ld d, $05 ; $54c5
	call FillMemoryD ; $54c7
	ld a, $20 ; $54ca
	ld d, $04 ; $54cc
	call FillMemoryD ; $54ce
	ld a, $30 ; $54d1
	ld [hl+], a ; $54d3
	xor a, a ; $54d4
	ld d, $0b ; $54d5
	call FillMemoryD ; $54d7
	ld a, $20 ; $54da
	ld d, $04 ; $54dc
	call FillMemoryD ; $54de
	ld a, $30 ; $54e1
	ld [hl+], a ; $54e3
	xor a, a ; $54e4
	ld d, $0a ; $54e5
	call FillMemoryD ; $54e7
	ld a, $01 ; $54ea
	ld [$d000], a ; $54ec
	ret ; $54ef
FillMemoryD:
	ld [hl+], a ; $54f0
	dec d ; $54f1
	jr nz, FillMemoryD ; $54f2
	ret ; $54f4
Func_1e_54f5:
	call Func_1e_551e ; $54f5
	call Func_1e_55e4 ; $54f8
	wram_bank $03 ; $54fb
	ld hl, $d000 ; $5501
	ld de, $9800 ; $5504
	ld c, $24 ; $5507
	call QueueVRAMCopy ; $5509
	wram_bank $02 ; $550c
	ld hl, $d000 ; $5512
	ld de, $b800 ; $5515
	ld c, $24 ; $5518
	call QueueVRAMCopy ; $551a
	ret ; $551d
Func_1e_551e:
	ld hl, Palettes_1e_5be1 ; $551e
	ld de, $0003 ; $5521
	call LoadPaletteShadow ; $5524
	wram_bank $01 ; $5527
	ld hl, Lz_1e_5bf9 ; $552d
	ld de, $d000 ; $5530
	call DecompressData ; $5533
	ld hl, $d000 ; $5536
	ld de, $b000 ; $5539
	ld c, $80 ; $553c
	call QueueVRAMCopy ; $553e
	ld hl, $d800 ; $5541
	ld de, $a800 ; $5544
	ld c, $80 ; $5547
	call QueueVRAMCopy ; $5549
	wram_bank $01 ; $554c
	ld hl, Lz_1e_62ca ; $5552
	ld de, $d000 ; $5555
	call DecompressData ; $5558
	ld hl, $d000 ; $555b
	ld bc, $0240 ; $555e
	call Func_1e_55ba ; $5561
	wram_bank $01 ; $5564
	ld hl, Lz_1e_644f ; $556a
	ld de, $d000 ; $556d
	call DecompressData ; $5570
	ld hl, $d000 ; $5573
	ld bc, $0240 ; $5576
	call Func_1e_55cf ; $5579
	wram_bank $01 ; $557c
	ld hl, Lz_1e_5343 ; $5582
	ld de, $d000 ; $5585
	call DecompressData ; $5588
	ld hl, $d000 ; $558b
	ld de, $9000 ; $558e
	ld c, $10 ; $5591
	call QueueVRAMCopy ; $5593
	ld hl, Palettes_1e_6495 ; $5596
	ld de, $0801 ; $5599
	call LoadPaletteShadow ; $559c
	wram_bank $01 ; $559f
	ld hl, Lz_1e_649d ; $55a5
	ld de, $d000 ; $55a8
	call DecompressData ; $55ab
	ld hl, $d000 ; $55ae
	ld de, $a6c0 ; $55b1
	ld c, $14 ; $55b4
	call QueueVRAMCopy ; $55b6
	ret ; $55b9
Func_1e_55ba:
	wram_bank $01 ; $55ba
	ld d, [hl] ; $55c0
	wram_bank $03 ; $55c1
	ld [hl], d ; $55c7
	inc hl ; $55c8
	dec bc ; $55c9
	ld a, b ; $55ca
	or a, c ; $55cb
	jr nz, Func_1e_55ba ; $55cc
	ret ; $55ce
Func_1e_55cf:
	wram_bank $01 ; $55cf
	ld d, [hl] ; $55d5
	wram_bank $02 ; $55d6
	ld [hl], d ; $55dc
	inc hl ; $55dd
	dec bc ; $55de
	ld a, b ; $55df
	or a, c ; $55e0
	jr nz, Func_1e_55cf ; $55e1
	ret ; $55e3
Func_1e_55e4:
	call Func_1e_5896 ; $55e4
	call Func_1e_59bb ; $55e7
	call Func_1e_5814 ; $55ea
	test_flag $1f, 7 ; $55ed
	jr nz, Label_1e_55f6 ; $55f0
	call Func_1e_55fd ; $55f2
	ret ; $55f5
Label_1e_55f6:
	call Func_1e_5693 ; $55f6
	call Func_1e_5758 ; $55f9
	ret ; $55fc
Func_1e_55fd:
	ld hl, $d0a3 ; $55fd
	ld b, $02 ; $5600
	ld c, $01 ; $5602
	call FillTilemapRun ; $5604
	ld b, $03 ; $5607
	ld c, $0c ; $5609
	call FillTilemapRun ; $560b
	ld b, $04 ; $560e
	ld c, $01 ; $5610
	call FillTilemapRun ; $5612
	ld hl, $d0c3 ; $5615
	ld b, $05 ; $5618
	ld c, $01 ; $561a
	call FillTilemapRun ; $561c
	ld b, $20 ; $561f
	ld c, $0c ; $5621
	call FillTilemapRun ; $5623
	ld b, $06 ; $5626
	ld c, $01 ; $5628
	call FillTilemapRun ; $562a
	ld hl, $d0e3 ; $562d
	ld b, $07 ; $5630
	ld c, $01 ; $5632
	call FillTilemapRun ; $5634
	ld b, $08 ; $5637
	ld c, $0c ; $5639
	call FillTilemapRun ; $563b
	ld b, $09 ; $563e
	ld c, $01 ; $5640
	call FillTilemapRun ; $5642
	ld bc, $ca00 ; $5645
	ld a, [$c8b9] ; $5648
	cp a, $02 ; $564b
	jr nz, Label_1e_5658 ; $564d
	ld bc, $ca80 ; $564f
	ld a, [$c8ba] ; $5652
	ld [$ca98], a ; $5655
Label_1e_5658:
	push bc ; $5658
	ld hl, $0000 ; $5659
	add hl, bc ; $565c
	call CopyStringToTextBuffer ; $565d
	ld de, $d0c4 ; $5660
	ld bc, $0020 ; $5663
	call WriteTextToTilemap ; $5666
	ld hl, $04e4 ; $5669
	ld de, $d0cc ; $566c
	ld bc, $0020 ; $566f
	call FetchAndDrawDialogueText ; $5672
	pop bc ; $5675
	ld hl, $0018 ; $5676
	add hl, bc ; $5679
	ld a, [hl] ; $567a
	ld h, $00 ; $567b
	ld l, a ; $567d
	ld a, $02 ; $567e
	ld bc, $0020 ; $5680
	ld de, wTextBuffer ; $5683
	call FormatDecimalNumberUnsigned ; $5686
	ld hl, wTextBuffer ; $5689
	ld de, $d0ce ; $568c
	call WriteTextToTilemap ; $568f
	ret ; $5692
Func_1e_5693:
	ld hl, $d0a0 ; $5693
	ld bc, $0201 ; $5696
	call FillTilemapRun ; $5699
	ld bc, $0307 ; $569c
	call FillTilemapRun ; $569f
	ld bc, $0401 ; $56a2
	call FillTilemapRun ; $56a5
	ld hl, $d0c0 ; $56a8
	ld bc, $0501 ; $56ab
	call FillTilemapRun ; $56ae
	ld bc, $2007 ; $56b1
	call FillTilemapRun ; $56b4
	ld bc, $0601 ; $56b7
	call FillTilemapRun ; $56ba
	ld hl, $d0e0 ; $56bd
	ld bc, $0501 ; $56c0
	call FillTilemapRun ; $56c3
	ld bc, $2007 ; $56c6
	call FillTilemapRun ; $56c9
	ld bc, $0601 ; $56cc
	call FillTilemapRun ; $56cf
	ld hl, $d100 ; $56d2
	ld bc, $0501 ; $56d5
	call FillTilemapRun ; $56d8
	ld bc, $2007 ; $56db
	call FillTilemapRun ; $56de
	ld bc, $0601 ; $56e1
	call FillTilemapRun ; $56e4
	ld hl, $d120 ; $56e7
	ld bc, $0701 ; $56ea
	call FillTilemapRun ; $56ed
	ld bc, $0807 ; $56f0
	call FillTilemapRun ; $56f3
	ld bc, $0901 ; $56f6
	call FillTilemapRun ; $56f9
	ld a, [wGameMode] ; $56fc
	or a, a ; $56ff
	jr nz, Label_1e_5707 ; $5700
	ld bc, wStoryModeNameOfMainCharacter ; $5702
	jr Label_1e_571a ; $5705
Label_1e_5707:
	ld bc, $ca00 ; $5707
	ld a, [$c8b9] ; $570a
	cp a, $02 ; $570d
	jr nz, Label_1e_571a ; $570f
	ld bc, $ca80 ; $5711
	ld a, [$c8ba] ; $5714
	ld [$ca98], a ; $5717
Label_1e_571a:
	push bc ; $571a
	ld hl, $0000 ; $571b
	add hl, bc ; $571e
	call CopyStringToTextBuffer ; $571f
	ld de, $d0c1 ; $5722
	ld bc, $0020 ; $5725
	call WriteTextToTilemap ; $5728
	ld hl, $04e4 ; $572b
	ld de, $d101 ; $572e
	ld bc, $0020 ; $5731
	call FetchAndDrawDialogueText ; $5734
	pop bc ; $5737
	ld hl, $0018 ; $5738
	add hl, bc ; $573b
	ld a, [hl] ; $573c
	ld h, $00 ; $573d
	ld l, a ; $573f
	ld a, $02 ; $5740
	ld bc, $0020 ; $5742
	ld de, wTextBuffer ; $5745
	call FormatDecimalNumberUnsigned ; $5748
	ld hl, wTextBuffer ; $574b
	ld de, $d104 ; $574e
	ld bc, $0020 ; $5751
	call WriteTextToTilemap ; $5754
	ret ; $5757
Func_1e_5758:
	ld hl, $d0ab ; $5758
	ld bc, $0201 ; $575b
	call FillTilemapRun ; $575e
	ld bc, $0307 ; $5761
	call FillTilemapRun ; $5764
	ld bc, $0401 ; $5767
	call FillTilemapRun ; $576a
	ld hl, $d0cb ; $576d
	ld bc, $0501 ; $5770
	call FillTilemapRun ; $5773
	ld bc, $2007 ; $5776
	call FillTilemapRun ; $5779
	ld bc, $0601 ; $577c
	call FillTilemapRun ; $577f
	ld hl, $d0eb ; $5782
	ld bc, $0501 ; $5785
	call FillTilemapRun ; $5788
	ld bc, $2007 ; $578b
	call FillTilemapRun ; $578e
	ld bc, $0601 ; $5791
	call FillTilemapRun ; $5794
	ld hl, $d10b ; $5797
	ld bc, $0501 ; $579a
	call FillTilemapRun ; $579d
	ld bc, $2007 ; $57a0
	call FillTilemapRun ; $57a3
	ld bc, $0601 ; $57a6
	call FillTilemapRun ; $57a9
	ld hl, $d12b ; $57ac
	ld bc, $0701 ; $57af
	call FillTilemapRun ; $57b2
	ld bc, $0807 ; $57b5
	call FillTilemapRun ; $57b8
	ld bc, $0901 ; $57bb
	call FillTilemapRun ; $57be
	ld a, [wGameMode] ; $57c1
	or a, a ; $57c4
	jr nz, Label_1e_57cc ; $57c5
	ld bc, wStoryModeNameOfPartnerCharacter ; $57c7
	jr Label_1e_57d9 ; $57ca
Label_1e_57cc:
	ld bc, $ca40 ; $57cc
	ld a, [$c8b9] ; $57cf
	cp a, $02 ; $57d2
	jr nz, Label_1e_57d9 ; $57d4
	ld bc, $cac0 ; $57d6
Label_1e_57d9:
	push bc ; $57d9
	ld hl, $0000 ; $57da
	add hl, bc ; $57dd
	call CopyStringToTextBuffer ; $57de
	ld de, $d0cc ; $57e1
	ld bc, $0020 ; $57e4
	call WriteTextToTilemap ; $57e7
	ld hl, $04e4 ; $57ea
	ld de, $d10c ; $57ed
	ld bc, $0020 ; $57f0
	call FetchAndDrawDialogueText ; $57f3
	pop bc ; $57f6
	ld hl, $0018 ; $57f7
	add hl, bc ; $57fa
	ld a, [hl] ; $57fb
	ld h, $00 ; $57fc
	ld l, a ; $57fe
	ld a, $02 ; $57ff
	ld bc, $0020 ; $5801
	ld de, wTextBuffer ; $5804
	call FormatDecimalNumberUnsigned ; $5807
	ld hl, wTextBuffer ; $580a
	ld de, $d10f ; $580d
	call WriteTextToTilemap ; $5810
	ret ; $5813
Func_1e_5814:
	ld hl, $d1c2 ; $5814
	ld bc, $0201 ; $5817
	call FillTilemapRun ; $581a
	ld bc, $0308 ; $581d
	call FillTilemapRun ; $5820
	ld bc, $0401 ; $5823
	call FillTilemapRun ; $5826
	ld bc, $0201 ; $5829
	call FillTilemapRun ; $582c
	ld bc, $0304 ; $582f
	call FillTilemapRun ; $5832
	ld bc, $0401 ; $5835
	call FillTilemapRun ; $5838
	ld hl, $d1e2 ; $583b
	ld bc, $0501 ; $583e
	call FillTilemapRun ; $5841
	ld bc, $2008 ; $5844
	call FillTilemapRun ; $5847
	ld bc, $0601 ; $584a
	call FillTilemapRun ; $584d
	ld bc, $0501 ; $5850
	call FillTilemapRun ; $5853
	ld bc, $2004 ; $5856
	call FillTilemapRun ; $5859
	ld bc, $0601 ; $585c
	call FillTilemapRun ; $585f
	ld hl, $d202 ; $5862
	ld bc, $0701 ; $5865
	call FillTilemapRun ; $5868
	ld bc, $0808 ; $586b
	call FillTilemapRun ; $586e
	ld bc, $0901 ; $5871
	call FillTilemapRun ; $5874
	ld bc, $0701 ; $5877
	call FillTilemapRun ; $587a
	ld bc, $0804 ; $587d
	call FillTilemapRun ; $5880
	ld bc, $0901 ; $5883
	call FillTilemapRun ; $5886
	ld hl, $04e7 ; $5889
	ld de, $d1e3 ; $588c
	ld bc, $0020 ; $588f
	call FetchAndDrawDialogueText ; $5892
	ret ; $5895
Func_1e_5896:
	ld hl, $d000 ; $5896
	ld bc, $0201 ; $5899
	call FillTilemapRun ; $589c
	ld bc, $0312 ; $589f
	call FillTilemapRun ; $58a2
	ld bc, $0401 ; $58a5
	call FillTilemapRun ; $58a8
	ld hl, $d020 ; $58ab
	ld bc, $0501 ; $58ae
	call FillTilemapRun ; $58b1
	ld bc, $2012 ; $58b4
	call FillTilemapRun ; $58b7
	ld bc, $0601 ; $58ba
	call FillTilemapRun ; $58bd
	ld hl, $d040 ; $58c0
	ld bc, $0501 ; $58c3
	call FillTilemapRun ; $58c6
	ld bc, $2012 ; $58c9
	call FillTilemapRun ; $58cc
	ld bc, $0601 ; $58cf
	call FillTilemapRun ; $58d2
	ld hl, $d060 ; $58d5
	ld bc, $0501 ; $58d8
	call FillTilemapRun ; $58db
	ld bc, $2012 ; $58de
	call FillTilemapRun ; $58e1
	ld bc, $0601 ; $58e4
	call FillTilemapRun ; $58e7
	ld hl, $d080 ; $58ea
	ld bc, $0701 ; $58ed
	call FillTilemapRun ; $58f0
	ld bc, $0812 ; $58f3
	call FillTilemapRun ; $58f6
	ld bc, $0901 ; $58f9
	call FillTilemapRun ; $58fc
	ret ; $58ff
FillTilemapRun:
	wram_bank $03 ; $5900
	ld [hl], b ; $5906
	wram_bank $02 ; $5907
	ld a, $00 ; $590d
	ld [hl+], a ; $590f
	dec c ; $5910
	jr nz, FillTilemapRun ; $5911
	ret ; $5913
Func_1e_5914:
	ld b, $04 ; $5914
	ld a, [$c8b9] ; $5916
	or a, a ; $5919
	jr z, Label_1e_5920 ; $591a
	srl a ; $591c
	add a, b ; $591e
	ld b, a ; $591f
Label_1e_5920:
	push bc ; $5920
	ld a, b ; $5921
	wram_bank ; $5922
	xor a, a ; $5926
	call Func_1e_5954 ; $5927
	ld hl, $df80 ; $592a
	farcall FarPtr_DrawCharSprite ; $592d
	wram_bank $04 ; $5930
	pop bc ; $5936
	test_flag $1f, 7 ; $5937
	ret z ; $593a
	inc b ; $593b
	inc b ; $593c
	ld a, b ; $593d
	wram_bank ; $593e
	ld a, $01 ; $5942
	call Func_1e_5954 ; $5944
	ld hl, $df80 ; $5947
	farcall FarPtr_DrawCharSprite ; $594a
	wram_bank $04 ; $594d
	ret ; $5953
Func_1e_5954:
	push af ; $5954
	ld hl, $df00 ; $5955
	ld b, h ; $5958
	ld c, l ; $5959
	farcall FarPtr_StepCharAnimation ; $595a
	ld d, $00 ; $595d
	ld a, d ; $595f
	ld [$df32], a ; $5960
	farcall FarPtr_ReloadCharFacingTiles ; $5963
	ld a, [$df32] ; $5966
	add a, $b3 ; $5969
	ld l, a ; $596b
	adc a, $59 ; $596c
	sub a, l ; $596e
	ld h, a ; $596f
	ld a, [$df37] ; $5970
	or a, $08 ; $5973
	xor a, [hl] ; $5975
	ld b, a ; $5976
	pop af ; $5977
	push af ; $5978
	or a, a ; $5979
	jr nz, Label_1e_5981 ; $597a
	ld a, [$ca0e] ; $597c
	jr Label_1e_5984 ; $597f
Label_1e_5981:
	ld a, [$ca8e] ; $5981
Label_1e_5984:
	or a, a ; $5984
	jr z, Label_1e_598b ; $5985
	ld a, $20 ; $5987
	xor a, b ; $5989
	ld b, a ; $598a
Label_1e_598b:
	ld a, [$df36] ; $598b
	ld c, a ; $598e
	pop af ; $598f
	or a, a ; $5990
	jr nz, Label_1e_59a4 ; $5991
	test_flag $1f, 7 ; $5993
	jr z, Label_1e_599e ; $5996
	ld d, $44 ; $5998
	ld e, $66 ; $599a
	jr Label_1e_59a8 ; $599c
Label_1e_599e:
	ld d, $50 ; $599e
	ld e, $66 ; $59a0
	jr Label_1e_59a8 ; $59a2
Label_1e_59a4:
	ld d, $5c ; $59a4
	ld e, $66 ; $59a6
Label_1e_59a8:
	ld hl, $df80 ; $59a8
	ld a, c ; $59ab
	ld [hl+], a ; $59ac
	ld a, b ; $59ad
	ld [hl+], a ; $59ae
	ld a, e ; $59af
	ld [hl+], a ; $59b0
	ld [hl], d ; $59b1
	ret ; $59b2
	INCBIN "data/bank_01e/d_59b3.bin" ; $59b3, 8 bytes
Func_1e_59bb:
	wram_bank $06 ; $59bb
	ld a, [$d024] ; $59c1
	cp a, $05 ; $59c4
	jr z, Label_1e_5a3f ; $59c6
	rlca ; $59c8
	add a, $52 ; $59c9
	ld l, a ; $59cb
	adc a, $d1 ; $59cc
	sub a, l ; $59ce
	ld h, a ; $59cf
	ld a, [hl+] ; $59d0
	ld b, [hl] ; $59d1
	or a, b ; $59d2
	jr z, Label_1e_5a35 ; $59d3
	dec hl ; $59d5
	ld c, [hl] ; $59d6
	push bc ; $59d7
	ld a, [$d024] ; $59d8
	add a, $5c ; $59db
	ld l, a ; $59dd
	adc a, $d1 ; $59de
	sub a, l ; $59e0
	ld h, a ; $59e1
	ld a, [hl] ; $59e2
	ld d, a ; $59e3
	ld a, [$d024] ; $59e4
	rlca ; $59e7
	add a, $44 ; $59e8
	ld l, a ; $59ea
	adc a, $5a ; $59eb
	sub a, l ; $59ed
	ld h, a ; $59ee
	ld a, [hl+] ; $59ef
	ld h, [hl] ; $59f0
	ld l, a ; $59f1
	ld a, d ; $59f2
	add a, l ; $59f3
	ld l, a ; $59f4
	jr nc, Label_1e_59f8 ; $59f5
	inc h ; $59f7
Label_1e_59f8:
	push hl ; $59f8
	call Func_1e_5896 ; $59f9
	wram_bank $06 ; $59fc
	ld hl, $d005 ; $5a02
	ld a, [hl+] ; $5a05
	ld d, [hl] ; $5a06
	or a, d ; $5a07
	jr z, Label_1e_5a18 ; $5a08
	ld hl, $04c8 ; $5a0a
	ld de, $d022 ; $5a0d
	ld bc, $0020 ; $5a10
	call Func_1e_4563 ; $5a13
	jr Label_1e_5a24 ; $5a16
Label_1e_5a18:
	ld hl, $04c7 ; $5a18
	ld de, $d022 ; $5a1b
	ld bc, $0020 ; $5a1e
	call Func_1e_4563 ; $5a21
Label_1e_5a24:
	pop hl ; $5a24
	ld bc, $0020 ; $5a25
	ld de, $d062 ; $5a28
	call Func_1e_4563 ; $5a2b
	pop bc ; $5a2e
	farcall FarPtr_UploadGlyphBuffer ; $5a2f
	ld a, $01 ; $5a32
	ret ; $5a34
Label_1e_5a35:
	ld a, [$d024] ; $5a35
	inc a ; $5a38
	ld [$d024], a ; $5a39
	jp Func_1e_59bb ; $5a3c
Label_1e_5a3f:
	farcall FarPtr_UploadGlyphBuffer ; $5a3f
	xor a, a ; $5a42
	ret ; $5a43
	INCBIN "data/bank_01e/d_5a44.bin" ; $5a44, 10 bytes
Func_1e_5a4e:
	wram_bank $06 ; $5a4e
	ld hl, $d005 ; $5a54
	ld a, [hl+] ; $5a57
	ld h, [hl] ; $5a58
	ld l, a ; $5a59
	ld a, $04 ; $5a5a
	ld de, wTextBuffer ; $5a5c
	call FormatDecimalNumberUnsigned ; $5a5f
	ld a, [$c604] ; $5a62
	or a, a ; $5a65
	jr nz, Label_1e_5aa9 ; $5a66
	ld a, [wTextBuffer] ; $5a68
	cp a, $20 ; $5a6b
	jr z, Label_1e_5a78 ; $5a6d
	call Func_1e_5afa ; $5a6f
	ld de, $6b77 ; $5a72
	call QueueSprite ; $5a75
Label_1e_5a78:
	ld a, [$c601] ; $5a78
	cp a, $20 ; $5a7b
	jr z, Label_1e_5a88 ; $5a7d
	call Func_1e_5afa ; $5a7f
	ld de, $7377 ; $5a82
	call QueueSprite ; $5a85
Label_1e_5a88:
	ld a, [$c602] ; $5a88
	cp a, $20 ; $5a8b
	jr z, Label_1e_5a98 ; $5a8d
	call Func_1e_5afa ; $5a8f
	ld de, $7b77 ; $5a92
	call QueueSprite ; $5a95
Label_1e_5a98:
	ld a, [$c603] ; $5a98
	cp a, $20 ; $5a9b
	jr z, Label_1e_5aa8 ; $5a9d
	call Func_1e_5afa ; $5a9f
	ld de, $8377 ; $5aa2
	call QueueSprite ; $5aa5
Label_1e_5aa8:
	ret ; $5aa8
Label_1e_5aa9:
	ld a, [wTextBuffer] ; $5aa9
	cp a, $20 ; $5aac
	jr z, Label_1e_5ab9 ; $5aae
	call Func_1e_5afa ; $5ab0
	ld de, $6777 ; $5ab3
	call QueueSprite ; $5ab6
Label_1e_5ab9:
	ld a, [$c601] ; $5ab9
	cp a, $20 ; $5abc
	jr z, Label_1e_5ac9 ; $5abe
	call Func_1e_5afa ; $5ac0
	ld de, $6f77 ; $5ac3
	call QueueSprite ; $5ac6
Label_1e_5ac9:
	ld a, [$c602] ; $5ac9
	cp a, $20 ; $5acc
	jr z, Label_1e_5ad9 ; $5ace
	call Func_1e_5afa ; $5ad0
	ld de, $7777 ; $5ad3
	call QueueSprite ; $5ad6
Label_1e_5ad9:
	ld a, [$c603] ; $5ad9
	cp a, $20 ; $5adc
	jr z, Label_1e_5ae9 ; $5ade
	call Func_1e_5afa ; $5ae0
	ld de, $7f77 ; $5ae3
	call QueueSprite ; $5ae6
Label_1e_5ae9:
	ld a, [$c604] ; $5ae9
	cp a, $20 ; $5aec
	jr z, Label_1e_5af9 ; $5aee
	call Func_1e_5afa ; $5af0
	ld de, $8777 ; $5af3
	call QueueSprite ; $5af6
Label_1e_5af9:
	ret ; $5af9
Func_1e_5afa:
	sub a, $30 ; $5afa
	rlca ; $5afc
	add a, $6c ; $5afd
	ld c, a ; $5aff
	ld b, $08 ; $5b00
	ret ; $5b02
Func_1e_5b03:
	wram_bank $06 ; $5b03
	call AdvanceFrame ; $5b09
	call Func_1e_5b19 ; $5b0c
	or a, a ; $5b0f
	ret z ; $5b10
	call Func_1e_5b66 ; $5b11
	call Func_1e_5bad ; $5b14
	jr Func_1e_5b03 ; $5b17
Func_1e_5b19:
	call Func_1e_59bb ; $5b19
	or a, a ; $5b1c
	jp z, Label_1e_5b60 ; $5b1d
	sound $00 ; $5b20
	sound $0b ; $5b22
	wram_bank $06 ; $5b24
	ld a, [$d024] ; $5b2a
	inc a ; $5b2d
	ld [$d024], a ; $5b2e
	xor a, a ; $5b31
	ld [$d026], a ; $5b32
	ld hl, $d007 ; $5b35
	ld a, c ; $5b38
	ld [hl+], a ; $5b39
	ld [hl], b ; $5b3a
	wram_bank $03 ; $5b3b
	ld hl, $d000 ; $5b41
	ld de, $9800 ; $5b44
	ld c, $08 ; $5b47
	call QueueVRAMCopy ; $5b49
	wram_bank $02 ; $5b4c
	ld hl, $d000 ; $5b52
	ld de, $b800 ; $5b55
	ld c, $08 ; $5b58
	call QueueVRAMCopy ; $5b5a
	ld a, $01 ; $5b5d
	ret ; $5b5f
Label_1e_5b60:
	call WaitFramesCmd ; $5b60
	db $0a ; $5b63 inline arg
	xor a, a ; $5b64
	ret ; $5b65
Func_1e_5b66:
	wram_bank $06 ; $5b66
	ld hl, $d007 ; $5b6c
	ld a, [hl+] ; $5b6f
	ld d, [hl] ; $5b70
	ld e, a ; $5b71
	ld a, d ; $5b72
	or a, e ; $5b73
	ret z ; $5b74
	call AdvanceFrame ; $5b75
	ldh a, [hInputRisingEdge] ; $5b78
	and a, PADF_A | PADF_B ; $5b7a
	jr nz, Label_1e_5b9b ; $5b7c
	call AdvanceFrame ; $5b7e
	ldh a, [hInputRisingEdge] ; $5b81
	and a, PADF_A | PADF_B ; $5b83
	jr nz, Label_1e_5b9b ; $5b85
	dec hl ; $5b87
	dec de ; $5b88
	ld a, e ; $5b89
	ld [hl+], a ; $5b8a
	ld [hl], d ; $5b8b
	ld hl, $d005 ; $5b8c
	ld a, [hl+] ; $5b8f
	ld d, [hl] ; $5b90
	ld e, a ; $5b91
	inc de ; $5b92
	dec hl ; $5b93
	ld a, e ; $5b94
	ld [hl+], a ; $5b95
	ld [hl], d ; $5b96
	sound $5e ; $5b97
	jr Func_1e_5b66 ; $5b99
Label_1e_5b9b:
	ld hl, $d005 ; $5b9b
	ld a, [hl+] ; $5b9e
	ld h, [hl] ; $5b9f
	ld l, a ; $5ba0
	add hl, de ; $5ba1
	ld d, h ; $5ba2
	ld e, l ; $5ba3
	ld hl, $d005 ; $5ba4
	ld a, e ; $5ba7
	ld [hl+], a ; $5ba8
	ld [hl], d ; $5ba9
	sound $5f ; $5baa
	ret ; $5bac
Func_1e_5bad:
	ld c, $b4 ; $5bad
Label_1e_5baf:
	call AdvanceFrame ; $5baf
	ldh a, [hInputRisingEdge] ; $5bb2
	and a, PADF_A | PADF_B ; $5bb4
	ret nz ; $5bb6
	dec c ; $5bb7
	jr nz, Label_1e_5baf ; $5bb8
	ret ; $5bba
Func_1e_5bbb:
	ld hl, $d152 ; $5bbb
	ld a, [hl+] ; $5bbe
	ld d, [hl] ; $5bbf
	inc hl ; $5bc0
	or a, d ; $5bc1
	jr nz, Label_1e_5bde ; $5bc2
	ld a, [hl+] ; $5bc4
	ld d, [hl] ; $5bc5
	inc hl ; $5bc6
	or a, d ; $5bc7
	jr nz, Label_1e_5bde ; $5bc8
	ld a, [hl+] ; $5bca
	ld d, [hl] ; $5bcb
	inc hl ; $5bcc
	or a, d ; $5bcd
	jr nz, Label_1e_5bde ; $5bce
	ld a, [hl+] ; $5bd0
	ld d, [hl] ; $5bd1
	inc hl ; $5bd2
	or a, d ; $5bd3
	jr nz, Label_1e_5bde ; $5bd4
	ld a, [hl+] ; $5bd6
	ld d, [hl] ; $5bd7
	inc hl ; $5bd8
	or a, d ; $5bd9
	jr nz, Label_1e_5bde ; $5bda
	xor a, a ; $5bdc
	ret ; $5bdd
Label_1e_5bde:
	ld a, $01 ; $5bde
	ret ; $5be0
Palettes_1e_5be1:
	; $5be1, 24 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $5ad6, $015f, $0000, $7fff ; pal 0: #b4b4b4 #ff5200 #000000 #ffffff
	dw $73a8, $7fff, $3184, $3279 ; pal 1: #41eee6 #ffffff #206262 #cd9c62
	dw $021a, $33ec, $0b22, $0220 ; pal 2: #d58300 #62ff62 #10cd10 #008b00
Lz_1e_5bf9:
	INCBIN "data/bank_01e/d_5bf9.bin" ; $5bf9, 1745 bytes
Lz_1e_62ca:
	INCBIN "data/bank_01e/d_62ca.bin" ; $62ca, 389 bytes
Lz_1e_644f:
	INCBIN "data/bank_01e/d_644f.bin" ; $644f, 70 bytes
Palettes_1e_6495:
	; $6495, 8 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c1f, $0000, $0000, $7fff ; pal 0: #ff00ff #000000 #000000 #ffffff
Lz_1e_649d:
	INCBIN "data/bank_01e/d_649d.bin" ; $649d, 150 bytes
StubNop_1e:
	ret ; $6533
ProcessMatchRewards:
	ld a, [wMatchExitRequest] ; $6534
	or a, a ; $6537
	ret nz ; $6538
	ld a, [wKeepMatchStatsFlag] ; $6539
	or a, a ; $653c
	ret nz ; $653d
	call DisableLCDSafely ; $653e
	farcall FarPtr_01_0a ; $6541
	call EnableLCD ; $6544
	ld hl, $0000 ; $6547
	ld a, [wGameMode] ; $654a
	cp a, $08 ; $654d
	jp z, Label_1e_6688 ; $654f
	cp a, $09 ; $6552
	jp z, Label_1e_6644 ; $6554
	cp a, $06 ; $6557
	jp z, Label_1e_6584 ; $6559
	cp a, $07 ; $655c
	jp z, Label_1e_6584 ; $655e
	cp a, $0a ; $6561
	jp z, Label_1e_65f9 ; $6563
	cp a, $04 ; $6566
	jp z, Label_1e_6630 ; $6568
	jp c, Label_1e_65f9 ; $656b
	ld a, [wPointWinLoseFlag] ; $656e
	cp a, $01 ; $6571
	jp nz, Label_1e_6695 ; $6573
	call Func_1e_66d2 ; $6576
	call Func_1e_6a13 ; $6579
	ld h, d ; $657c
	ld l, e ; $657d
	call SetRewardGameFlag ; $657e
	jp Label_1e_6695 ; $6581
Label_1e_6584:
	ld a, [wMatchExitRequest] ; $6584
	and a, a ; $6587
	jp nz, Label_1e_6695 ; $6588
	push hl ; $658b
	ld hl, wMinigamesCurrentScore ; $658c
	ld a, [hl+] ; $658f
	ld h, [hl] ; $6590
	ld l, a ; $6591
	ld a, [wGameMode] ; $6592
	cp a, $07 ; $6595
	ld a, $0f ; $6597
	jr nz, Label_1e_659d ; $6599
	add a, $0f ; $659b
Label_1e_659d:
	call MulHLByAFracSigned ; $659d
	ld e, a ; $65a0
	ld a, h ; $65a1
	ld h, l ; $65a2
	ld l, e ; $65a3
	ld e, $64 ; $65a4
	call DivAHLByE ; $65a6
	pop de ; $65a9
	add hl, de ; $65aa
	ld a, [$ca3c] ; $65ab
	ld d, a ; $65ae
	call Func_1e_68dc ; $65af
	ld a, [wPointWinLoseFlag] ; $65b2
	cp a, $01 ; $65b5
	jp nz, Label_1e_65ed ; $65b7
	ld a, [$c7bc] ; $65ba
	or a, a ; $65bd
	jr z, Label_1e_65e6 ; $65be
	ld a, [wGameMode] ; $65c0
	cp a, $06 ; $65c3
	jr nz, Label_1e_65cc ; $65c5
	test_flag $1b, 2 ; $65c7
	jr Label_1e_65cf ; $65ca
Label_1e_65cc:
	test_flag $1b, 3 ; $65cc
Label_1e_65cf:
	jr z, Label_1e_65e6 ; $65cf
	push hl ; $65d1
	ld hl, wMinigamesCurrentScore ; $65d2
	ld a, [hl+] ; $65d5
	ld h, [hl] ; $65d6
	ld l, a ; $65d7
	ld de, $270f ; $65d8
	ld a, l ; $65db
	sub a, e ; $65dc
	ld l, a ; $65dd
	ld a, h ; $65de
	sbc a, d ; $65df
	ld h, a ; $65e0
	ld a, h ; $65e1
	or a, l ; $65e2
	pop hl ; $65e3
	jr nz, Label_1e_65ed ; $65e4
Label_1e_65e6:
	call Func_1e_66d2 ; $65e6
	add hl, de ; $65e9
	call SetRewardGameFlag ; $65ea
Label_1e_65ed:
	call GetScoreBonus ; $65ed
	add hl, de ; $65f0
	ld d, h ; $65f1
	ld e, l ; $65f2
	call Func_1e_6a13 ; $65f3
	jp Label_1e_6695 ; $65f6
Label_1e_65f9:
	wram_bank $04 ; $65f9
	call ComputeMatchStatsReward ; $65ff
	ld a, [$ca3c] ; $6602
	ld d, a ; $6605
	call Func_1e_68dc ; $6606
	ld de, $0000 ; $6609
	ld a, [wMatchWinLoseFlag] ; $660c
	cp a, $01 ; $660f
	jr nz, Label_1e_6616 ; $6611
	call Func_1e_66d2 ; $6613
Label_1e_6616:
	add hl, de ; $6616
	ld d, h ; $6617
	ld e, l ; $6618
	call Func_1e_6a36 ; $6619
	ld a, [wMatchWinLoseFlag] ; $661c
	cp a, $01 ; $661f
	jr nz, Label_1e_6695 ; $6621
	call SetRewardGameFlag ; $6623
	push hl ; $6626
	call Func_1e_6e1c ; $6627
	pop hl ; $662a
	call Func_1e_6ca0 ; $662b
	jr Label_1e_6695 ; $662e
Label_1e_6630:
	wram_bank $04 ; $6630
	call ComputeMatchStatsReward ; $6636
	ld a, [$ca3c] ; $6639
	ld d, a ; $663c
	call Func_1e_68dc ; $663d
	call Func_1e_6967 ; $6640
	ret ; $6643
Label_1e_6644:
	ld a, [$c8b9] ; $6644
	cp a, $02 ; $6647
	jr z, Label_1e_6664 ; $6649
	wram_bank $04 ; $664b
	call ComputeMatchStatsReward ; $6651
	ld a, [$ca3c] ; $6654
	ld d, a ; $6657
	call Func_1e_68dc ; $6658
	ld a, [wMatchWinLoseFlag] ; $665b
	cp a, $01 ; $665e
	jr z, Label_1e_667d ; $6660
	jr Label_1e_6684 ; $6662
Label_1e_6664:
	wram_bank $05 ; $6664
	call ComputeMatchStatsReward ; $666a
	ld a, [$cabc] ; $666d
	ld d, a ; $6670
	call Func_1e_68dc ; $6671
	ld a, [wMatchWinLoseFlag] ; $6674
	cp a, $ff ; $6677
	jr z, Label_1e_667d ; $6679
	jr Label_1e_6684 ; $667b
Label_1e_667d:
	ld e, l ; $667d
	ld d, h ; $667e
	sra d ; $667f
	rr e ; $6681
	add hl, de ; $6683
Label_1e_6684:
	call Func_1e_69b4 ; $6684
	ret ; $6687
Label_1e_6688:
	call UpdateMinigameBestScore ; $6688
	ld a, [wPointWinLoseFlag] ; $668b
	cp a, $01 ; $668e
	ret nz ; $6690
	call Func_1e_6edc ; $6691
	ret ; $6694
Label_1e_6695:
	ld a, h ; $6695
	or a, l ; $6696
	jr z, Label_1e_66a9 ; $6697
	farcall FarPtr_1d_06 ; $6699
	ld c, $00 ; $669c
	farcall FarPtr_1c_00 ; $669e
	ld c, $01 ; $66a1
	farcall FarPtr_1c_00 ; $66a3
	call Func_1e_6c62 ; $66a6
Label_1e_66a9:
	call Func_1e_6fb2 ; $66a9
	ld a, $00 ; $66ac
	ld [wGameMode], a ; $66ae
	test_flag $07, 3 ; $66b1
	jr z, Label_1e_66be ; $66b4
	push de ; $66b6
	ld de, $01c0 ; $66b7
	farcall FarPtr_SetSaveFlag ; $66ba
	pop de ; $66bd
Label_1e_66be:
	test_flag $06, 4 ; $66be
	jr z, Label_1e_66cb ; $66c1
	push de ; $66c3
	ld de, $01e0 ; $66c4
	farcall FarPtr_SetSaveFlag ; $66c7
	pop de ; $66ca
Label_1e_66cb:
	call Func_1e_6f8d ; $66cb
	farcall FarPtr_SaveStorySlotWithTimer ; $66ce
	ret ; $66d1
Func_1e_66d2:
	call TestRewardGameFlag ; $66d2
	ld de, $0000 ; $66d5
	ret nz ; $66d8
	push hl ; $66d9
	ld a, [wCurrentMinigameStoryMatch] ; $66da
	ld hl, RewardSubHandlersA_1e ; $66dd
	add a, a ; $66e0
	add a, l ; $66e1
	ld l, a ; $66e2
	jr nc, Label_1e_66e6 ; $66e3
	inc h ; $66e5
Label_1e_66e6:
	ld a, [hl+] ; $66e6
	ld h, [hl] ; $66e7
	ld l, a ; $66e8
	call Func_1e_6cf6 ; $66e9
	add a, a ; $66ec
	add a, l ; $66ed
	ld l, a ; $66ee
	jr nc, Label_1e_66f2 ; $66ef
	inc h ; $66f1
Label_1e_66f2:
	ld a, [hl+] ; $66f2
	ld d, [hl] ; $66f3
	ld e, a ; $66f4
	pop hl ; $66f5
	ret ; $66f6
RewardSubHandlersA_1e:
	; $66f7, 16 bytes (records:2)
	dw $6707 ; record 0
	dw $6739 ; record 1
	dw $676b ; record 2
	dw $0000 ; record 3
	dw $0000 ; record 4
	dw $0000 ; record 5
	dw $0000 ; record 6
	dw $0000 ; record 7
	nop ; $6707
	nop ; $6708
	ld b, [hl] ; $6709
	nop ; $670a
	ld d, b ; $670b
	nop ; $670c
	ld e, d ; $670d
	nop ; $670e
	ld h, h ; $670f
	nop ; $6710
	nop ; $6711
	nop ; $6712
	ld a, b ; $6713
	nop ; $6714
	sub a, [hl] ; $6715
	nop ; $6716
	ret z ; $6717
	nop ; $6718
	ld a, [$0000] ; $6719
	nop ; $671c
	inc l ; $671d
	ld bc, $0000 ; $671e
	nop ; $6721
	nop ; $6722
	nop ; $6723
	nop ; $6724
	nop ; $6725
	nop ; $6726
	ld e, [hl] ; $6727
	ld bc, $0190 ; $6728
	jp nz, $f401 ; $672b
	ld bc, $0000 ; $672e
	nop ; $6731
	nop ; $6732
	jr nz, Label_1e_6738 ; $6733
	jr nz, Label_1e_673a ; $6735
	db $20 ; $6737
Label_1e_6738:
	inc bc ; $6738
	nop ; $6739
Label_1e_673a:
	nop ; $673a
	nop ; $673b
	nop ; $673c
	ld a, b ; $673d
	nop ; $673e
	sub a, [hl] ; $673f
	nop ; $6740
	ret z ; $6741
	nop ; $6742
	nop ; $6743
	nop ; $6744
	nop ; $6745
	nop ; $6746
	ld a, [$2c00] ; $6747
	ld bc, $015e ; $674a
	nop ; $674d
	nop ; $674e
	nop ; $674f
	nop ; $6750
	nop ; $6751
	nop ; $6752
	INCBIN "data/bank_01e/d_6753.bin" ; $6753, 24 bytes
	ld [hl-], a ; $676b
	nop ; $676c
	ld h, h ; $676d
	nop ; $676e
	ret z ; $676f
	nop ; $6770
	ld [hl-], a ; $6771
	nop ; $6772
	ld h, h ; $6773
	nop ; $6774
	ret z ; $6775
	nop ; $6776
	ld [hl-], a ; $6777
	nop ; $6778
	ld h, h ; $6779
	nop ; $677a
	ret z ; $677b
	nop ; $677c
	ld [hl-], a ; $677d
	nop ; $677e
	ld h, h ; $677f
	nop ; $6780
	ret z ; $6781
	nop ; $6782
	ld [hl-], a ; $6783
	nop ; $6784
	ld h, h ; $6785
	nop ; $6786
	ret z ; $6787
	nop ; $6788
	ld [hl-], a ; $6789
	nop ; $678a
	ld h, h ; $678b
	nop ; $678c
	ret z ; $678d
	nop ; $678e
	ld h, h ; $678f
	nop ; $6790
	ret z ; $6791
	nop ; $6792
	sub a, b ; $6793
	ld bc, $02bc ; $6794
	inc l ; $6797
	ld bc, $0190 ; $6798
	INCBIN "data/bank_01e/d_679b.bin" ; $679b, 108 bytes
GetScoreBonus:
	ld de, $0000 ; $6807
	ld a, [$c7bc] ; $680a
	or a, a ; $680d
	ret z ; $680e
	push hl ; $680f
	ld hl, wMinigamesCurrentScore ; $6810
	ld a, [hl+] ; $6813
	ld d, [hl] ; $6814
	ld e, a ; $6815
	ld hl, $03e7 ; $6816
	ld a, l ; $6819
	sub a, e ; $681a
	ld l, a ; $681b
	ld a, h ; $681c
	sbc a, d ; $681d
	ld h, a ; $681e
	bit 7, h ; $681f
	jr z, Label_1e_6828 ; $6821
	ld de, $01f4 ; $6823
	jr Label_1e_684f ; $6826
Label_1e_6828:
	ld hl, $01f3 ; $6828
	ld a, l ; $682b
	sub a, e ; $682c
	ld l, a ; $682d
	ld a, h ; $682e
	sbc a, d ; $682f
	ld h, a ; $6830
	bit 7, h ; $6831
	jr z, Label_1e_683a ; $6833
	ld de, $00fa ; $6835
	jr Label_1e_684f ; $6838
Label_1e_683a:
	ld hl, $0063 ; $683a
	ld a, l ; $683d
	sub a, e ; $683e
	ld l, a ; $683f
	ld a, h ; $6840
	sbc a, d ; $6841
	ld h, a ; $6842
	bit 7, h ; $6843
	jr z, Label_1e_684c ; $6845
	ld de, $0032 ; $6847
	jr Label_1e_684f ; $684a
Label_1e_684c:
	ld de, $0000 ; $684c
Label_1e_684f:
	pop hl ; $684f
	ret ; $6850
ComputeMatchStatsReward:
	ld a, [$df78] ; $6851
	cp a, $04 ; $6854
	ret nc ; $6856
	push hl ; $6857
	call Func_1e_6932 ; $6858
	pop de ; $685b
	ld hl, $67d7 ; $685c
	ld a, [wTotalGamesWonInMatch] ; $685f
	call Func_1e_68cf ; $6862
	ld l, e ; $6865
	ld h, d ; $6866
	ld a, [wGameMode] ; $6867
	cp a, $09 ; $686a
	ret z ; $686c
	push hl ; $686d
	call Func_1e_6901 ; $686e
	pop de ; $6871
	ld hl, $67df ; $6872
	ld a, [wCharacter1ServiceAces] ; $6875
	call Func_1e_68cf ; $6878
	ld hl, $67df ; $687b
	ld a, [wCharacter3ServiceAces] ; $687e
	call Func_1e_68cf ; $6881
	ld hl, $67e7 ; $6884
	ld a, [wCharacter1ReturnAces] ; $6887
	call Func_1e_68cf ; $688a
	ld hl, $67e7 ; $688d
	ld a, [wCharacter3ReturnAces] ; $6890
	call Func_1e_68cf ; $6893
	ld hl, $67ef ; $6896
	ld a, [wCharacter1SmashAces] ; $6899
	call Func_1e_68cf ; $689c
	ld hl, $67ef ; $689f
	ld a, [wCharacter3SmashAces] ; $68a2
	call Func_1e_68cf ; $68a5
	ld hl, $67f7 ; $68a8
	ld a, [wCharacter1LobShotWinners] ; $68ab
	call Func_1e_68cf ; $68ae
	ld hl, $67f7 ; $68b1
	ld a, [wCharacter3LobShotWinners] ; $68b4
	call Func_1e_68cf ; $68b7
	ld hl, $67ff ; $68ba
	ld a, [wCharacter1DropShotWinners] ; $68bd
	call Func_1e_68cf ; $68c0
	ld hl, $67ff ; $68c3
	ld a, [wCharacter3DropShotWinners] ; $68c6
	call Func_1e_68cf ; $68c9
	ld l, e ; $68cc
	ld h, d ; $68cd
	ret ; $68ce
Func_1e_68cf:
	ld b, $00 ; $68cf
	add hl, bc ; $68d1
	ld l, [hl] ; $68d2
	ld h, $00 ; $68d3
	call MulHLByA ; $68d5
	add hl, de ; $68d8
	ld e, l ; $68d9
	ld d, h ; $68da
	ret ; $68db
Func_1e_68dc:
	ld b, $00 ; $68dc
	ld a, d ; $68de
	and a, $0f ; $68df
	cp a, $03 ; $68e1
	jr nz, Label_1e_68e6 ; $68e3
	inc b ; $68e5
Label_1e_68e6:
	ld a, d ; $68e6
	swap a ; $68e7
	and a, $0f ; $68e9
	cp a, $01 ; $68eb
	jr nz, Label_1e_68f0 ; $68ed
	inc b ; $68ef
Label_1e_68f0:
	ld a, b ; $68f0
	and a, a ; $68f1
	ret z ; $68f2
	cp a, $02 ; $68f3
	jr z, Label_1e_68ff ; $68f5
	ld e, l ; $68f7
	ld d, h ; $68f8
	sra d ; $68f9
	rr e ; $68fb
	add hl, de ; $68fd
	ret ; $68fe
Label_1e_68ff:
	add hl, hl ; $68ff
	ret ; $6900
Func_1e_6901:
	ldh a, [hWramBank] ; $6901
	push af ; $6903
	wram_bank $05 ; $6904
	call Func_1e_693e ; $690a
	ld a, [wMatchIsDoubles] ; $690d
	and a, a ; $6910
	jr z, Label_1e_6924 ; $6911
	push bc ; $6913
	wram_bank $07 ; $6914
	call Func_1e_693e ; $691a
	ld a, c ; $691d
	pop bc ; $691e
	add a, c ; $691f
	inc a ; $6920
	srl a ; $6921
	ld c, a ; $6923
Label_1e_6924:
	ld a, c ; $6924
	cp a, $06 ; $6925
	jr c, Label_1e_692b ; $6927
	ld a, $06 ; $6929
Label_1e_692b:
	ld c, a ; $692b
	pop af ; $692c
	wram_bank ; $692d
	ret ; $6931
Func_1e_6932:
	call Func_1e_693e ; $6932
	ld a, c ; $6935
	cp a, $06 ; $6936
	jr c, Label_1e_693c ; $6938
	ld a, $06 ; $693a
Label_1e_693c:
	ld c, a ; $693c
	ret ; $693d
Func_1e_693e:
	ld a, [$df95] ; $693e
	ld c, a ; $6941
	ld a, [$df78] ; $6942
	cp a, $04 ; $6945
	jr nc, Label_1e_6965 ; $6947
	ld l, c ; $6949
	xor a, a ; $694a
	ld h, a ; $694b
	ld e, $0a ; $694c
	call DivAHLByE ; $694e
	ld a, l ; $6951
	add a, $5b ; $6952
	ld l, a ; $6954
	adc a, $69 ; $6955
	sub a, l ; $6957
	ld h, a ; $6958
	ld c, [hl] ; $6959
	ret ; $695a
	INCBIN "data/bank_01e/d_695b.bin" ; $695b, 10 bytes
Label_1e_6965:
	dec c ; $6965
	ret ; $6966
Func_1e_6967:
	ld d, h ; $6967
	ld e, l ; $6968
	ld hl, $c8b1 ; $6969
	ld a, e ; $696c
	ld [hl+], a ; $696d
	ld [hl], d ; $696e
	ld a, [$c8b5] ; $696f
	bit 7, a ; $6972
	jr z, Label_1e_69ad ; $6974
	call Func_1e_6a6e ; $6976
	ld a, [wCurrentStorySlot] ; $6979
	push af ; $697c
	ld hl, $c8b1 ; $697d
	ld a, [hl+] ; $6980
	ld h, [hl] ; $6981
	ld l, a ; $6982
	ld a, [$c8b5] ; $6983
	srl a ; $6986
	and a, $03 ; $6988
	ld [wCurrentStorySlot], a ; $698a
	farcall FarPtr_CheckStorySlot ; $698d
	ld d, h ; $6990
	ld e, l ; $6991
	ld hl, $c8b1 ; $6992
	ld a, [hl+] ; $6995
	ld h, [hl] ; $6996
	ld l, a ; $6997
	add hl, de ; $6998
	jr nc, Label_1e_699e ; $6999
	ld hl, rIE ; $699b
Label_1e_699e:
	ld d, h ; $699e
	ld e, l ; $699f
	ld hl, $c8b1 ; $69a0
	ld a, e ; $69a3
	ld [hl+], a ; $69a4
	ld [hl], d ; $69a5
	farcall FarPtr_SaveStorySlot ; $69a6
	pop af ; $69a9
	ld [wCurrentStorySlot], a ; $69aa
Label_1e_69ad:
	farcall FarPtr_RecordExhibitionVictory ; $69ad
	farcall FarPtr_ReadExhibitionSaveBlock ; $69b0
	ret ; $69b3
Func_1e_69b4:
	ld d, h ; $69b4
	ld e, l ; $69b5
	ld hl, $c8b3 ; $69b6
	ld a, e ; $69b9
	ld [hl+], a ; $69ba
	ld [hl], d ; $69bb
	ld hl, $c8b5 ; $69bc
	ld a, [$c8b9] ; $69bf
	srl a ; $69c2
	sla a ; $69c4
	add a, l ; $69c6
	ld l, a ; $69c7
	jr nc, Label_1e_69cb ; $69c8
	inc h ; $69ca
Label_1e_69cb:
	ld a, [hl] ; $69cb
	bit 7, a ; $69cc
	jr z, Label_1e_6a12 ; $69ce
	cp a, $ff ; $69d0
	jr z, Label_1e_6a12 ; $69d2
	call Func_1e_6aa4 ; $69d4
	ld a, [wCurrentStorySlot] ; $69d7
	push af ; $69da
	ld hl, $c8b5 ; $69db
	ld a, [$c8b9] ; $69de
	and a, $03 ; $69e1
	srl a ; $69e3
	sla a ; $69e5
	add a, l ; $69e7
	ld l, a ; $69e8
	jr nc, Label_1e_69ec ; $69e9
	inc h ; $69eb
Label_1e_69ec:
	ld a, [hl] ; $69ec
	srl a ; $69ed
	and a, $03 ; $69ef
	ld [wCurrentStorySlot], a ; $69f1
	farcall FarPtr_CheckStorySlot ; $69f4
	ld hl, $c8b3 ; $69f7
	ld a, [hl+] ; $69fa
	ld h, [hl] ; $69fb
	ld l, a ; $69fc
	add hl, de ; $69fd
	jr nc, Label_1e_6a03 ; $69fe
	ld hl, rIE ; $6a00
Label_1e_6a03:
	ld d, h ; $6a03
	ld e, l ; $6a04
	ld hl, $c8b3 ; $6a05
	ld a, e ; $6a08
	ld [hl+], a ; $6a09
	ld [hl], d ; $6a0a
	farcall FarPtr_SaveStorySlot ; $6a0b
	pop af ; $6a0e
	ld [wCurrentStorySlot], a ; $6a0f
Label_1e_6a12:
	ret ; $6a12
Func_1e_6a13:
	ld a, e ; $6a13
	or a, d ; $6a14
	ret z ; $6a15
	push af ; $6a16
	push bc ; $6a17
	push de ; $6a18
	push hl ; $6a19
	ldh a, [hWramBank] ; $6a1a
	push af ; $6a1c
	farcall FarPtr_ClearDrillResultBuffer ; $6a1d
	ld b, $03 ; $6a20
	ld c, $01 ; $6a22
	farcall FarPtr_RecordDrillResult ; $6a24
	ld c, $01 ; $6a27
	call ShowMatchResultsScreen ; $6a29
	pop af ; $6a2c
	wram_bank ; $6a2d
	pop hl ; $6a31
	pop de ; $6a32
	pop bc ; $6a33
	pop af ; $6a34
	ret ; $6a35
Func_1e_6a36:
	ld a, e ; $6a36
	or a, d ; $6a37
	ret z ; $6a38
	push af ; $6a39
	push bc ; $6a3a
	push de ; $6a3b
	push hl ; $6a3c
	ldh a, [hWramBank] ; $6a3d
	push af ; $6a3f
	farcall FarPtr_ClearDrillResultBuffer ; $6a40
	ld b, $03 ; $6a43
	ld c, $00 ; $6a45
	ld a, [wGameMode] ; $6a47
	cp a, $02 ; $6a4a
	jr nz, Label_1e_6a50 ; $6a4c
	ld c, $02 ; $6a4e
Label_1e_6a50:
	cp a, $03 ; $6a50
	jr nz, Label_1e_6a56 ; $6a52
	ld c, $03 ; $6a54
Label_1e_6a56:
	cp a, $0a ; $6a56
	jr nz, Label_1e_6a5c ; $6a58
	ld c, $04 ; $6a5a
Label_1e_6a5c:
	farcall FarPtr_RecordDrillResult ; $6a5c
	ld c, $01 ; $6a5f
	call ShowMatchResultsScreen ; $6a61
	pop af ; $6a64
	wram_bank ; $6a65
	pop hl ; $6a69
	pop de ; $6a6a
	pop bc ; $6a6b
	pop af ; $6a6c
	ret ; $6a6d
Func_1e_6a6e:
	ld a, e ; $6a6e
	or a, d ; $6a6f
	ret z ; $6a70
	push af ; $6a71
	push bc ; $6a72
	push de ; $6a73
	push hl ; $6a74
	ldh a, [hWramBank] ; $6a75
	push af ; $6a77
	farcall FarPtr_ClearDrillResultBuffer ; $6a78
	ld b, $01 ; $6a7b
	ld c, $00 ; $6a7d
	farcall FarPtr_RecordDrillResult ; $6a7f
	xor a, a ; $6a82
	test_flag $05, 7 ; $6a83
	jr z, Label_1e_6a8a ; $6a86
	ld a, $01 ; $6a88
Label_1e_6a8a:
	push af ; $6a8a
	clear_flag $05, 7 ; $6a8b
	ld c, $01 ; $6a8e
	call ShowMatchResultsScreen ; $6a90
	pop af ; $6a93
	or a, a ; $6a94
	jr z, Label_1e_6a9a ; $6a95
	set_flag $05, 7 ; $6a97
Label_1e_6a9a:
	pop af ; $6a9a
	wram_bank ; $6a9b
	pop hl ; $6a9f
	pop de ; $6aa0
	pop bc ; $6aa1
	pop af ; $6aa2
	ret ; $6aa3
Func_1e_6aa4:
	ld a, e ; $6aa4
	or a, d ; $6aa5
	ret z ; $6aa6
	push af ; $6aa7
	push bc ; $6aa8
	push de ; $6aa9
	push hl ; $6aaa
	ldh a, [hWramBank] ; $6aab
	push af ; $6aad
	farcall FarPtr_ClearDrillResultBuffer ; $6aae
	ld b, $02 ; $6ab1
	ld c, $00 ; $6ab3
	farcall FarPtr_RecordDrillResult ; $6ab5
	xor a, a ; $6ab8
	test_flag $05, 7 ; $6ab9
	jr z, Label_1e_6ac0 ; $6abc
	ld a, $01 ; $6abe
Label_1e_6ac0:
	push af ; $6ac0
	clear_flag $05, 7 ; $6ac1
	ld c, $01 ; $6ac4
	call ShowMatchResultsScreen ; $6ac6
	pop af ; $6ac9
	or a, a ; $6aca
	jr z, Label_1e_6ad0 ; $6acb
	set_flag $05, 7 ; $6acd
Label_1e_6ad0:
	pop af ; $6ad0
	wram_bank ; $6ad1
	pop hl ; $6ad5
	pop de ; $6ad6
	pop bc ; $6ad7
	pop af ; $6ad8
	ret ; $6ad9
	ld a, e ; $6ada
	or a, d ; $6adb
	ret z ; $6adc
	push af ; $6add
	push bc ; $6ade
	push de ; $6adf
	push hl ; $6ae0
	ldh a, [hWramBank] ; $6ae1
	push af ; $6ae3
	farcall FarPtr_ClearDrillResultBuffer ; $6ae4
	ld b, $00 ; $6ae7
	ld c, $00 ; $6ae9
	farcall FarPtr_RecordDrillResult ; $6aeb
	ld c, $01 ; $6aee
	call ShowMatchResultsScreen ; $6af0
	pop af ; $6af3
	wram_bank ; $6af4
	pop hl ; $6af8
	pop de ; $6af9
	pop bc ; $6afa
	pop af ; $6afb
	ret ; $6afc
Func_1e_6afd:
	push af ; $6afd
	push bc ; $6afe
	push de ; $6aff
	push hl ; $6b00
	ldh a, [hWramBank] ; $6b01
	push af ; $6b03
	ld a, [wGameMode] ; $6b04
	push af ; $6b07
	ld a, $00 ; $6b08
	ld [wGameMode], a ; $6b0a
	ld hl, $c9b0 ; $6b0d
	ld a, [hl+] ; $6b10
	ld d, [hl] ; $6b11
	ld e, a ; $6b12
	ld hl, $c9b2 ; $6b13
	ld a, [hl+] ; $6b16
	ld h, [hl] ; $6b17
	ld l, a ; $6b18
	add hl, de ; $6b19
	jr c, Label_1e_6b3d ; $6b1a
	ld d, h ; $6b1c
	ld e, l ; $6b1d
	call Func_1e_6c09 ; $6b1e
	call Func_1e_6ffb ; $6b21
	add hl, de ; $6b24
	jr c, Label_1e_6b3d ; $6b25
	ld d, h ; $6b27
	ld e, l ; $6b28
	ld hl, $c8b1 ; $6b29
	ld a, [hl+] ; $6b2c
	ld h, [hl] ; $6b2d
	ld l, a ; $6b2e
	add hl, de ; $6b2f
	jr c, Label_1e_6b3d ; $6b30
	ld d, h ; $6b32
	ld e, l ; $6b33
	ld hl, $c8b3 ; $6b34
	ld a, [hl+] ; $6b37
	ld h, [hl] ; $6b38
	ld l, a ; $6b39
	add hl, de ; $6b3a
	jr nc, Label_1e_6b40 ; $6b3b
Label_1e_6b3d:
	ld hl, rIE ; $6b3d
Label_1e_6b40:
	ld a, h ; $6b40
	or a, l ; $6b41
	jp z, Label_1e_6bfa ; $6b42
	push hl ; $6b45
	farcall FarPtr_ClearDrillResultBuffer ; $6b46
	ld hl, $c9b0 ; $6b49
	ld a, [hl+] ; $6b4c
	ld d, [hl] ; $6b4d
	ld e, a ; $6b4e
	ld hl, $c9b2 ; $6b4f
	ld a, [hl+] ; $6b52
	ld h, [hl] ; $6b53
	ld l, a ; $6b54
	add hl, de ; $6b55
	ld d, h ; $6b56
	ld e, l ; $6b57
	jr nc, Label_1e_6b5d ; $6b58
	ld de, rIE ; $6b5a
Label_1e_6b5d:
	call Func_1e_6c09 ; $6b5d
	jr nc, Label_1e_6b65 ; $6b60
	ld de, rIE ; $6b62
Label_1e_6b65:
	ld a, d ; $6b65
	or a, e ; $6b66
	jr z, Label_1e_6b70 ; $6b67
	ld b, $00 ; $6b69
	ld c, $00 ; $6b6b
	farcall FarPtr_RecordDrillResult ; $6b6d
Label_1e_6b70:
	ld hl, $c8b1 ; $6b70
	ld a, [hl+] ; $6b73
	ld d, [hl] ; $6b74
	ld e, a ; $6b75
	ld a, d ; $6b76
	or a, e ; $6b77
	jr z, Label_1e_6b81 ; $6b78
	ld b, $01 ; $6b7a
	ld c, $00 ; $6b7c
	farcall FarPtr_RecordDrillResult ; $6b7e
Label_1e_6b81:
	ld hl, $c8b3 ; $6b81
	ld a, [hl+] ; $6b84
	ld d, [hl] ; $6b85
	ld e, a ; $6b86
	ld a, d ; $6b87
	or a, e ; $6b88
	jr z, Label_1e_6b92 ; $6b89
	ld b, $02 ; $6b8b
	ld c, $00 ; $6b8d
	farcall FarPtr_RecordDrillResult ; $6b8f
Label_1e_6b92:
	wram_bank $06 ; $6b92
	ld hl, $d036 ; $6b98
	ld a, [hl+] ; $6b9b
	ld d, [hl] ; $6b9c
	ld e, a ; $6b9d
	ld a, d ; $6b9e
	or a, e ; $6b9f
	jr z, Label_1e_6ba9 ; $6ba0
	ld b, $04 ; $6ba2
	ld c, $00 ; $6ba4
	farcall FarPtr_RecordDrillResult ; $6ba6
Label_1e_6ba9:
	xor a, a ; $6ba9
	test_flag $05, 7 ; $6baa
	jr nz, Label_1e_6bb1 ; $6bad
	ld a, $01 ; $6baf
Label_1e_6bb1:
	push af ; $6bb1
	set_flag $05, 7 ; $6bb2
	ld c, $01 ; $6bb5
	call ShowMatchResultsScreen ; $6bb7
	pop af ; $6bba
	or a, a ; $6bbb
	jr z, Label_1e_6bc1 ; $6bbc
	clear_flag $05, 7 ; $6bbe
Label_1e_6bc1:
	pop hl ; $6bc1
	farcall FarPtr_1d_06 ; $6bc2
	ld c, $00 ; $6bc5
	farcall FarPtr_1c_00 ; $6bc7
	ld c, $01 ; $6bca
	farcall FarPtr_1c_00 ; $6bcc
	call Func_1e_6c62 ; $6bcf
	xor a, a ; $6bd2
	ld hl, $c9b0 ; $6bd3
	ld [hl+], a ; $6bd6
	ld [hl], a ; $6bd7
	ld hl, $c9b2 ; $6bd8
	ld [hl+], a ; $6bdb
	ld [hl], a ; $6bdc
	ld hl, $c8b1 ; $6bdd
	ld [hl+], a ; $6be0
	ld [hl], a ; $6be1
	ld hl, $c8b3 ; $6be2
	ld [hl+], a ; $6be5
	ld [hl], a ; $6be6
	pop af ; $6be7
	ld [wGameMode], a ; $6be8
	farcall FarPtr_SaveStorySlot ; $6beb
	pop af ; $6bee
	wram_bank ; $6bef
	pop hl ; $6bf3
	pop de ; $6bf4
	pop bc ; $6bf5
	pop af ; $6bf6
	ld a, $01 ; $6bf7
	ret ; $6bf9
Label_1e_6bfa:
	pop af ; $6bfa
	ld [wGameMode], a ; $6bfb
	pop af ; $6bfe
	wram_bank ; $6bff
	pop hl ; $6c03
	pop de ; $6c04
	pop bc ; $6c05
	pop af ; $6c06
	xor a, a ; $6c07
	ret ; $6c08
Func_1e_6c09:
	ld a, [$c918] ; $6c09
	ld b, a ; $6c0c
	ld a, [$c958] ; $6c0d
	add a, b ; $6c10
	srl a ; $6c11
	cp a, $0a ; $6c13
	jr nc, Label_1e_6c19 ; $6c15
	ccf ; $6c17
	ret ; $6c18
Label_1e_6c19:
	cp a, $14 ; $6c19
	jr nc, Label_1e_6c27 ; $6c1b
	ld h, d ; $6c1d
	ld l, e ; $6c1e
	srl d ; $6c1f
	rr e ; $6c21
	add hl, de ; $6c23
	ld d, h ; $6c24
	ld e, l ; $6c25
	ret ; $6c26
Label_1e_6c27:
	cp a, $1e ; $6c27
	jr nc, Label_1e_6c31 ; $6c29
	ld h, d ; $6c2b
	ld l, e ; $6c2c
	add hl, de ; $6c2d
	ld d, h ; $6c2e
	ld e, l ; $6c2f
	ret ; $6c30
Label_1e_6c31:
	cp a, $28 ; $6c31
	jr nc, Label_1e_6c40 ; $6c33
	ld h, d ; $6c35
	ld l, e ; $6c36
	srl d ; $6c37
	rr e ; $6c39
	add hl, hl ; $6c3b
	add hl, de ; $6c3c
	ld d, h ; $6c3d
	ld e, l ; $6c3e
	ret ; $6c3f
Label_1e_6c40:
	cp a, $32 ; $6c40
	jr nc, Label_1e_6c4b ; $6c42
	ld h, d ; $6c44
	ld l, e ; $6c45
	add hl, hl ; $6c46
	add hl, de ; $6c47
	ld d, h ; $6c48
	ld e, l ; $6c49
	ret ; $6c4a
Label_1e_6c4b:
	cp a, $3c ; $6c4b
	jr nc, Label_1e_6c5b ; $6c4d
	ld h, d ; $6c4f
	ld l, e ; $6c50
	add hl, hl ; $6c51
	add hl, de ; $6c52
	srl d ; $6c53
	rr e ; $6c55
	add hl, de ; $6c57
	ld d, h ; $6c58
	ld e, l ; $6c59
	ret ; $6c5a
Label_1e_6c5b:
	ld h, d ; $6c5b
	ld l, e ; $6c5c
	add hl, hl ; $6c5d
	add hl, hl ; $6c5e
	ld d, h ; $6c5f
	ld e, l ; $6c60
	ret ; $6c61
Func_1e_6c62:
	test_flag $0a, 7 ; $6c62
	jr nz, Label_1e_6c68 ; $6c65
	ret ; $6c67
Label_1e_6c68:
	ld a, [$c939] ; $6c68
	ld b, a ; $6c6b
	ld a, [$c938] ; $6c6c
	sub a, b ; $6c6f
	bit 7, a ; $6c70
	ret nz ; $6c72
	cp a, $05 ; $6c73
	jr nc, Label_1e_6c78 ; $6c75
	ret ; $6c77
Label_1e_6c78:
	set_flag $0c, 6 ; $6c78
	ret ; $6c7b
Func_1e_6c7c:
	test_flag $0a, 3 ; $6c7c
	jr nz, Label_1e_6c82 ; $6c7f
	ret ; $6c81
Label_1e_6c82:
	set_flag $0c, 1 ; $6c82
	ret ; $6c85
Func_1e_6c86:
	test_flag $0a, 7 ; $6c86
	jr nz, Label_1e_6c8c ; $6c89
	ret ; $6c8b
Label_1e_6c8c:
	set_flag $0c, 2 ; $6c8c
	set_flag $0d, 0 ; $6c8f
	ret ; $6c92
Func_1e_6c93:
	test_flag $0b, 0 ; $6c93
	jr nz, Label_1e_6c99 ; $6c96
	ret ; $6c98
Label_1e_6c99:
	set_flag $0c, 3 ; $6c99
	set_flag $0c, 7 ; $6c9c
	ret ; $6c9f
Func_1e_6ca0:
	call Func_1e_6c7c ; $6ca0
	call Func_1e_6c86 ; $6ca3
	call Func_1e_6c93 ; $6ca6
	ret ; $6ca9
SetRewardGameFlag:
	push af ; $6caa
	push bc ; $6cab
	push de ; $6cac
	push hl ; $6cad
	ld a, [wCurrentMinigameStoryMatch] ; $6cae
	add a, a ; $6cb1
	ld hl, RewardSubHandlersB_1e ; $6cb2
	add a, l ; $6cb5
	ld l, a ; $6cb6
	jr nc, Label_1e_6cba ; $6cb7
	inc h ; $6cb9
Label_1e_6cba:
	ld a, [hl+] ; $6cba
	ld h, [hl] ; $6cbb
	ld l, a ; $6cbc
	call Func_1e_6cf6 ; $6cbd
	add a, a ; $6cc0
	add a, l ; $6cc1
	ld l, a ; $6cc2
	jr nc, Label_1e_6cc6 ; $6cc3
	inc h ; $6cc5
Label_1e_6cc6:
	ld a, [hl+] ; $6cc6
	ld d, [hl] ; $6cc7
	ld e, a ; $6cc8
	call SetGameFlag ; $6cc9
	pop hl ; $6ccc
	pop de ; $6ccd
	pop bc ; $6cce
	pop af ; $6ccf
	ret ; $6cd0
TestRewardGameFlag:
	push bc ; $6cd1
	push de ; $6cd2
	push hl ; $6cd3
	ld a, [wCurrentMinigameStoryMatch] ; $6cd4
	add a, a ; $6cd7
	ld hl, RewardSubHandlersB_1e ; $6cd8
	add a, l ; $6cdb
	ld l, a ; $6cdc
	jr nc, Label_1e_6ce0 ; $6cdd
	inc h ; $6cdf
Label_1e_6ce0:
	ld a, [hl+] ; $6ce0
	ld h, [hl] ; $6ce1
	ld l, a ; $6ce2
	call Func_1e_6cf6 ; $6ce3
	add a, a ; $6ce6
	add a, l ; $6ce7
	ld l, a ; $6ce8
	jr nc, Label_1e_6cec ; $6ce9
	inc h ; $6ceb
Label_1e_6cec:
	ld a, [hl+] ; $6cec
	ld d, [hl] ; $6ced
	ld e, a ; $6cee
	call TestGameFlag ; $6cef
	pop hl ; $6cf2
	pop de ; $6cf3
	pop bc ; $6cf4
	ret ; $6cf5
Func_1e_6cf6:
	ld a, [wCurrentMinigameStoryMatch] ; $6cf6
	cp a, $02 ; $6cf9
	ld a, [$c8f7] ; $6cfb
	ret nz ; $6cfe
	cp a, $1a ; $6cff
	ret c ; $6d01
	jr nz, Label_1e_6d0c ; $6d02
	test_flag $1b, 2 ; $6d04
	jr z, Label_1e_6d0b ; $6d07
	add a, $02 ; $6d09
Label_1e_6d0b:
	ret ; $6d0b
Label_1e_6d0c:
	test_flag $1b, 3 ; $6d0c
	jr z, Label_1e_6d13 ; $6d0f
	add a, $02 ; $6d11
Label_1e_6d13:
	ret ; $6d13
RewardSubHandlersB_1e:
	; $6d14, 8 bytes (records:2)
	dw $6d1c ; record 0
	dw $6d4e ; record 1
	dw $6d96 ; record 2
	dw $0000 ; record 3
	nop ; $6d1c
	nop ; $6d1d
	nop ; $6d1e
	ld a, [bc] ; $6d1f
	jr nz, Label_1e_6d2c ; $6d20
	ld b, b ; $6d22
	ld a, [bc] ; $6d23
	ld h, b ; $6d24
	ld a, [bc] ; $6d25
	nop ; $6d26
	nop ; $6d27
	add a, b ; $6d28
	ld a, [bc] ; $6d29
	and a, b ; $6d2a
	ld a, [bc] ; $6d2b
Label_1e_6d2c:
	ret nz ; $6d2c
	ld a, [bc] ; $6d2d
	ldh [$ff0a], a ; $6d2e
	nop ; $6d30
	nop ; $6d31
	nop ; $6d32
	dec bc ; $6d33
	nop ; $6d34
	nop ; $6d35
	nop ; $6d36
	nop ; $6d37
	nop ; $6d38
	nop ; $6d39
	nop ; $6d3a
	nop ; $6d3b
	ldh [rTAC], a ; $6d3c
	ret nz ; $6d3e
	rlca ; $6d3f
	and a, b ; $6d40
	rlca ; $6d41
	add a, b ; $6d42
	rlca ; $6d43
	nop ; $6d44
	nop ; $6d45
	nop ; $6d46
	nop ; $6d47
	ld h, b ; $6d48
	rlca ; $6d49
	ld h, b ; $6d4a
	rlca ; $6d4b
	ld h, b ; $6d4c
	rlca ; $6d4d
	nop ; $6d4e
	nop ; $6d4f
	nop ; $6d50
	nop ; $6d51
	nop ; $6d52
	ld [$0820], sp ; $6d53
	ld b, b ; $6d56
	ld [$0000], sp ; $6d57
	nop ; $6d5a
	nop ; $6d5b
	add a, b ; $6d5c
	ld [$08a0], sp ; $6d5d
	ret nz ; $6d60
	ld [$0000], sp ; $6d61
	nop ; $6d64
	nop ; $6d65
	nop ; $6d66
	nop ; $6d67
	nop ; $6d68
	add hl, bc ; $6d69
	nop ; $6d6a
	nop ; $6d6b
	nop ; $6d6c
	nop ; $6d6d
	nop ; $6d6e
	nop ; $6d6f
	ldh [rTMA], a ; $6d70
	ret nz ; $6d72
	ld b, $a0 ; $6d73
	ld b, $00 ; $6d75
	nop ; $6d77
	nop ; $6d78
	nop ; $6d79
	add a, b ; $6d7a
	ld b, $80 ; $6d7b
	ld b, $80 ; $6d7d
	ld b, $c0 ; $6d7f
	rra ; $6d81
	ld h, b ; $6d82
	rlca ; $6d83
	add a, b ; $6d84
	ld b, $60 ; $6d85
	ld a, [bc] ; $6d87
	ld b, b ; $6d88
	ld [$0ae0], sp ; $6d89
	ret nz ; $6d8c
	ld [$0b00], sp ; $6d8d
	nop ; $6d90
	add hl, bc ; $6d91
	add a, b ; $6d92
	rlca ; $6d93
	and a, b ; $6d94
	db $06 ; $6d95
	nop ; $6d96
	jr Label_1e_6db9 ; $6d97
	INCBIN "data/bank_01e/d_6d99.bin" ; $6d99, 32 bytes
Label_1e_6db9:
	ld a, [de] ; $6db9
	ld b, b ; $6dba
	ld a, [de] ; $6dbb
	ld h, b ; $6dbc
	ld a, [de] ; $6dbd
	add a, b ; $6dbe
	ld a, [de] ; $6dbf
	and a, b ; $6dc0
	ld a, [de] ; $6dc1
	ret nz ; $6dc2
	ld a, [de] ; $6dc3
	ldh [rAUD3ENA], a ; $6dc4
	nop ; $6dc6
	dec de ; $6dc7
	jr nz, Label_1e_6de5 ; $6dc8
	ld b, b ; $6dca
	dec de ; $6dcb
	ld h, b ; $6dcc
	dec de ; $6dcd
	add a, b ; $6dce
	dec de ; $6dcf
	and a, b ; $6dd0
	dec de ; $6dd1
	ret nz ; $6dd2
	rra ; $6dd3
	add a, b ; $6dd4
	rlca ; $6dd5
	and a, b ; $6dd6
	ld b, $00 ; $6dd7
	nop ; $6dd9
	nop ; $6dda
	nop ; $6ddb
	ld h, b ; $6ddc
	ld a, [bc] ; $6ddd
	ld b, b ; $6dde
	ld [$0ae0], sp ; $6ddf
	ret nz ; $6de2
	db $08 ; $6de3
	db $00 ; $6de4
Label_1e_6de5:
	dec bc ; $6de5
	nop ; $6de6
	add hl, bc ; $6de7
	nop ; $6de8
	nop ; $6de9
	nop ; $6dea
	jr Label_1e_6e0d ; $6deb
	INCBIN "data/bank_01e/d_6ded.bin" ; $6ded, 32 bytes
Label_1e_6e0d:
	nop ; $6e0d
	ld b, b ; $6e0e
	ld a, [de] ; $6e0f
	ld h, b ; $6e10
	ld a, [de] ; $6e11
	add a, b ; $6e12
	ld a, [de] ; $6e13
	nop ; $6e14
	nop ; $6e15
	ret nz ; $6e16
	ld a, [de] ; $6e17
	ldh [rAUD3ENA], a ; $6e18
	nop ; $6e1a
	dec de ; $6e1b
Func_1e_6e1c:
	ld c, $00 ; $6e1c
	ld b, $0d ; $6e1e
	ld a, c ; $6e20
	add a, a ; $6e21
	add a, a ; $6e22
	ld hl, $6e7d ; $6e23
	add a, l ; $6e26
	ld l, a ; $6e27
	jr nc, Label_1e_6e2b ; $6e28
	inc h ; $6e2a
Label_1e_6e2b:
	ld a, [hl+] ; $6e2b
	ld d, [hl] ; $6e2c
	ld e, a ; $6e2d
	inc hl ; $6e2e
	ld a, d ; $6e2f
	or a, e ; $6e30
	jr z, Label_1e_6e3b ; $6e31
	call TestGameFlag ; $6e33
	jr z, Label_1e_6e3b ; $6e36
	call Func_1e_6e50 ; $6e38
Label_1e_6e3b:
	ld a, [hl+] ; $6e3b
	ld d, [hl] ; $6e3c
	ld e, a ; $6e3d
	inc hl ; $6e3e
	ld a, d ; $6e3f
	or a, e ; $6e40
	jr z, Label_1e_6e4b ; $6e41
	call TestGameFlag ; $6e43
	jr z, Label_1e_6e4b ; $6e46
	call Func_1e_6e50 ; $6e48
Label_1e_6e4b:
	inc c ; $6e4b
	dec b ; $6e4c
	jr nz, Label_1e_6e2b ; $6e4d
	ret ; $6e4f
Func_1e_6e50:
	push hl ; $6e50
	ld a, c ; $6e51
	add a, a ; $6e52
	ld hl, $6e63 ; $6e53
	add a, l ; $6e56
	ld l, a ; $6e57
	jr nc, Label_1e_6e5b ; $6e58
	inc h ; $6e5a
Label_1e_6e5b:
	ld a, [hl+] ; $6e5b
	ld d, [hl] ; $6e5c
	ld e, a ; $6e5d
	call SetGameFlag ; $6e5e
	pop hl ; $6e61
	ret ; $6e62
	INCBIN "data/bank_01e/d_6e63.bin" ; $6e63, 78 bytes
Func_1e_6eb1:
	ld a, [$c8f7] ; $6eb1
	cp a, $1d ; $6eb4
	jr nz, Label_1e_6ec1 ; $6eb6
	push de ; $6eb8
	ld de, $0740 ; $6eb9
	farcall FarPtr_SetSaveFlag ; $6ebc
	pop de ; $6ebf
	ret ; $6ec0
Label_1e_6ec1:
	cp a, $1f ; $6ec1
	jr nz, Label_1e_6ece ; $6ec3
	push de ; $6ec5
	ld de, $0760 ; $6ec6
	farcall FarPtr_SetSaveFlag ; $6ec9
	pop de ; $6ecc
	ret ; $6ecd
Label_1e_6ece:
	cp a, $21 ; $6ece
	jr nz, Label_1e_6edb ; $6ed0
	push de ; $6ed2
	ld de, $0780 ; $6ed3
	farcall FarPtr_SetSaveFlag ; $6ed6
	pop de ; $6ed9
	ret ; $6eda
Label_1e_6edb:
	ret ; $6edb
Func_1e_6edc:
	ld a, [$c8f7] ; $6edc
	sub a, $1c ; $6edf
	bit 7, a ; $6ee1
	ret nz ; $6ee3
	add a, a ; $6ee4
	ld h, $00 ; $6ee5
	ld l, a ; $6ee7
	add hl, hl ; $6ee8
	add a, l ; $6ee9
	ld l, a ; $6eea
	jr nc, Label_1e_6eee ; $6eeb
	inc h ; $6eed
Label_1e_6eee:
	ld a, [wMinigameLevel] ; $6eee
	add a, a ; $6ef1
	add a, l ; $6ef2
	ld l, a ; $6ef3
	jr nc, Label_1e_6ef7 ; $6ef4
	inc h ; $6ef6
Label_1e_6ef7:
	ld de, $6f02 ; $6ef7
	add hl, de ; $6efa
	ld a, [hl+] ; $6efb
	ld d, [hl] ; $6efc
	ld e, a ; $6efd
	farcall FarPtr_SetSaveFlag ; $6efe
	ret ; $6f01
	INCBIN "data/bank_01e/d_6f02.bin" ; $6f02, 54 bytes
UpdateMinigameBestScore:
	ldh a, [hWramBank] ; $6f38
	push af ; $6f3a
	ld a, [wMinigameLevel] ; $6f3b
	cp a, $02 ; $6f3e
	jr nz, Label_1e_6f87 ; $6f40
	ld a, [$c8f7] ; $6f42
	sub a, $1c ; $6f45
	bit 7, a ; $6f47
	jr nz, Label_1e_6f87 ; $6f49
	cp a, $09 ; $6f4b
	jr nc, Label_1e_6f87 ; $6f4d
	inc a ; $6f4f
	inc a ; $6f50
	farcall FarPtr_ReadMinigameRecord ; $6f51
	wram_bank $07 ; $6f54
	ld hl, $de00 ; $6f5a
	ld a, [hl+] ; $6f5d
	ld d, [hl] ; $6f5e
	ld e, a ; $6f5f
	ld hl, wMinigamesCurrentScore ; $6f60
	ld a, [hl+] ; $6f63
	ld b, [hl] ; $6f64
	ld c, a ; $6f65
	ld h, d ; $6f66
	ld l, e ; $6f67
	ld d, b ; $6f68
	ld e, c ; $6f69
	ld a, l ; $6f6a
	sub a, c ; $6f6b
	ld l, a ; $6f6c
	ld a, h ; $6f6d
	sbc a, b ; $6f6e
	ld h, a ; $6f6f
	bit 7, h ; $6f70
	jr z, Label_1e_6f87 ; $6f72
	ld hl, $de00 ; $6f74
	ld a, e ; $6f77
	ld [hl+], a ; $6f78
	ld [hl], d ; $6f79
	ld a, [$c8f7] ; $6f7a
	sub a, $1c ; $6f7d
	inc a ; $6f7f
	inc a ; $6f80
	farcall FarPtr_UpdateMinigameRecord ; $6f81
	call Func_1e_6eb1 ; $6f84
Label_1e_6f87:
	pop af ; $6f87
	wram_bank ; $6f88
	ret ; $6f8c
Func_1e_6f8d:
	push af ; $6f8d
	push bc ; $6f8e
	push de ; $6f8f
	push hl ; $6f90
	ld c, $24 ; $6f91
	ld hl, $6d82 ; $6f93
Label_1e_6f96:
	push hl ; $6f96
	ld a, [hl+] ; $6f97
	ld d, [hl] ; $6f98
	ld e, a ; $6f99
	call TestGameFlag ; $6f9a
	pop hl ; $6f9d
	jr z, Label_1e_6fad ; $6f9e
	inc hl ; $6fa0
	inc hl ; $6fa1
	dec c ; $6fa2
	jr nz, Label_1e_6f96 ; $6fa3
	push de ; $6fa5
	ld de, $0720 ; $6fa6
	farcall FarPtr_SetSaveFlag ; $6fa9
	pop de ; $6fac
Label_1e_6fad:
	pop hl ; $6fad
	pop de ; $6fae
	pop bc ; $6faf
	pop af ; $6fb0
	ret ; $6fb1
Func_1e_6fb2:
	ld a, [wGameMode] ; $6fb2
	cp a, $02 ; $6fb5
	ret nz ; $6fb7
	call Func_1e_6fbf ; $6fb8
	farcall FarPtr_ShowRankingBoard ; $6fbb
	ret ; $6fbe
Func_1e_6fbf:
	ld a, [wCurrentMinigameStoryMatch] ; $6fbf
	and a, $01 ; $6fc2
	ld b, a ; $6fc4
	or a, a ; $6fc5
	jr nz, Label_1e_6fd4 ; $6fc6
	ld a, [$c8f7] ; $6fc8
	sub a, $13 ; $6fcb
	add a, $04 ; $6fcd
	and a, $07 ; $6fcf
	ld c, a ; $6fd1
	jr Label_1e_6fde ; $6fd2
Label_1e_6fd4:
	ld a, [$c8f7] ; $6fd4
	sub a, $13 ; $6fd7
	add a, $03 ; $6fd9
	and a, $03 ; $6fdb
	ld c, a ; $6fdd
Label_1e_6fde:
	ld a, [wMatchWinLoseFlag] ; $6fde
	cp a, $01 ; $6fe1
	jr nz, Label_1e_6fe8 ; $6fe3
	ld d, $01 ; $6fe5
	ret ; $6fe7
Label_1e_6fe8:
	ld d, $02 ; $6fe8
	ret ; $6fea
Func_1e_6feb:
	add a, a ; $6feb
	add a, a ; $6fec
	add a, a ; $6fed
	add a, b ; $6fee
	ld hl, $67a7 ; $6fef
	add a, l ; $6ff2
	ld l, a ; $6ff3
	jr nc, Label_1e_6ff7 ; $6ff4
	inc h ; $6ff6
Label_1e_6ff7:
	ld a, [hl+] ; $6ff7
	ld b, [hl] ; $6ff8
	ld c, a ; $6ff9
	ret ; $6ffa
Func_1e_6ffb:
	push af ; $6ffb
	push bc ; $6ffc
	push de ; $6ffd
	ldh a, [hWramBank] ; $6ffe
	push af ; $7000
	wram_bank $06 ; $7001
	ld hl, $0000 ; $7007
	call Func_1e_70da ; $700a
	push hl ; $700d
	ld hl, $d028 ; $700e
	ld a, c ; $7011
	ld [hl+], a ; $7012
	ld [hl], b ; $7013
	pop hl ; $7014
	add hl, bc ; $7015
	call Func_1e_70e0 ; $7016
	push hl ; $7019
	ld hl, $d02a ; $701a
	ld a, c ; $701d
	ld [hl+], a ; $701e
	ld [hl], b ; $701f
	pop hl ; $7020
	add hl, bc ; $7021
	call Func_1e_70e6 ; $7022
	push hl ; $7025
	ld hl, $d02c ; $7026
	ld a, c ; $7029
	ld [hl+], a ; $702a
	ld [hl], b ; $702b
	pop hl ; $702c
	add hl, bc ; $702d
	call Func_1e_70ec ; $702e
	push hl ; $7031
	ld hl, $d02e ; $7032
	ld a, c ; $7035
	ld [hl+], a ; $7036
	ld [hl], b ; $7037
	pop hl ; $7038
	add hl, bc ; $7039
	call Func_1e_70f2 ; $703a
	push hl ; $703d
	ld hl, $d030 ; $703e
	ld a, c ; $7041
	ld [hl+], a ; $7042
	ld [hl], b ; $7043
	pop hl ; $7044
	add hl, bc ; $7045
	call Func_1e_70f8 ; $7046
	push hl ; $7049
	ld hl, $d032 ; $704a
	ld a, c ; $704d
	ld [hl+], a ; $704e
	ld [hl], b ; $704f
	pop hl ; $7050
	add hl, bc ; $7051
	push hl ; $7052
	ld b, h ; $7053
	ld c, l ; $7054
	ld hl, $d036 ; $7055
	ld a, c ; $7058
	ld [hl+], a ; $7059
	ld [hl], b ; $705a
	pop hl ; $705b
	pop af ; $705c
	wram_bank ; $705d
	pop de ; $7061
	pop bc ; $7062
	pop af ; $7063
	ret ; $7064
	ldh a, [hWramBank] ; $7065
	push af ; $7067
	wram_bank $06 ; $7068
	ld hl, $d028 ; $706e
	ld a, [hl+] ; $7071
	ld d, [hl] ; $7072
	ld e, a ; $7073
	ld a, d ; $7074
	or a, e ; $7075
	jr z, Label_1e_707f ; $7076
	ld b, $04 ; $7078
	ld c, $00 ; $707a
	farcall FarPtr_RecordDrillResult ; $707c
Label_1e_707f:
	ld hl, $d02a ; $707f
	ld a, [hl+] ; $7082
	ld d, [hl] ; $7083
	ld e, a ; $7084
	ld a, d ; $7085
	or a, e ; $7086
	jr z, Label_1e_7090 ; $7087
	ld b, $04 ; $7089
	ld c, $01 ; $708b
	farcall FarPtr_RecordDrillResult ; $708d
Label_1e_7090:
	ld hl, $d02c ; $7090
	ld a, [hl+] ; $7093
	ld d, [hl] ; $7094
	ld e, a ; $7095
	ld a, d ; $7096
	or a, e ; $7097
	jr z, Label_1e_70a1 ; $7098
	ld b, $04 ; $709a
	ld c, $02 ; $709c
	farcall FarPtr_RecordDrillResult ; $709e
Label_1e_70a1:
	ld hl, $d02e ; $70a1
	ld a, [hl+] ; $70a4
	ld d, [hl] ; $70a5
	ld e, a ; $70a6
	ld a, d ; $70a7
	or a, e ; $70a8
	jr z, Label_1e_70b2 ; $70a9
	ld b, $04 ; $70ab
	ld c, $03 ; $70ad
	farcall FarPtr_RecordDrillResult ; $70af
Label_1e_70b2:
	ld hl, $d030 ; $70b2
	ld a, [hl+] ; $70b5
	ld d, [hl] ; $70b6
	ld e, a ; $70b7
	ld a, d ; $70b8
	or a, e ; $70b9
	jr z, Label_1e_70c3 ; $70ba
	ld b, $04 ; $70bc
	ld c, $04 ; $70be
	farcall FarPtr_RecordDrillResult ; $70c0
Label_1e_70c3:
	ld hl, $d032 ; $70c3
	ld a, [hl+] ; $70c6
	ld d, [hl] ; $70c7
	ld e, a ; $70c8
	ld a, d ; $70c9
	or a, e ; $70ca
	jr z, Label_1e_70d4 ; $70cb
	ld b, $04 ; $70cd
	ld c, $05 ; $70cf
	farcall FarPtr_RecordDrillResult ; $70d1
Label_1e_70d4:
	pop af ; $70d4
	wram_bank ; $70d5
	ret ; $70d9
Func_1e_70da:
	ld a, $00 ; $70da
	call Func_1e_70fe ; $70dc
	ret ; $70df
Func_1e_70e0:
	ld a, $01 ; $70e0
	call Func_1e_70fe ; $70e2
	ret ; $70e5
Func_1e_70e6:
	ld a, $02 ; $70e6
	call Func_1e_70fe ; $70e8
	ret ; $70eb
Func_1e_70ec:
	ld a, $03 ; $70ec
	call Func_1e_70fe ; $70ee
	ret ; $70f1
Func_1e_70f2:
	ld a, $04 ; $70f2
	call Func_1e_70fe ; $70f4
	ret ; $70f7
Func_1e_70f8:
	ld a, $05 ; $70f8
	call Func_1e_70fe ; $70fa
	ret ; $70fd
Func_1e_70fe:
	push af ; $70fe
	push de ; $70ff
	push hl ; $7100
	ld c, a ; $7101
	ldh a, [hWramBank] ; $7102
	push af ; $7104
	wram_bank $06 ; $7105
	ld a, c ; $710b
	ld [$d038], a ; $710c
	ld hl, $7257 ; $710f
	add a, l ; $7112
	ld l, a ; $7113
	jr nc, Label_1e_7117 ; $7114
	inc h ; $7116
Label_1e_7117:
	ld b, [hl] ; $7117
	ld a, c ; $7118
	ld hl, $725d ; $7119
	add a, l ; $711c
	ld l, a ; $711d
	jr nc, Label_1e_7121 ; $711e
	inc h ; $7120
Label_1e_7121:
	ld c, [hl] ; $7121
	xor a, a ; $7122
	ld hl, $d034 ; $7123
	ld [hl+], a ; $7126
	ld [hl], a ; $7127
	ld a, [$c9b5] ; $7128
	and a, c ; $712b
	cp a, b ; $712c
	jr c, Label_1e_7163 ; $712d
	ld a, [$d038] ; $712f
	add a, a ; $7132
	add a, a ; $7133
	add a, a ; $7134
	ld hl, $7227 ; $7135
	add a, l ; $7138
	ld l, a ; $7139
	jr nc, Label_1e_713d ; $713a
	inc h ; $713c
Label_1e_713d:
	ld a, [hl+] ; $713d
	ld d, [hl] ; $713e
	ld e, a ; $713f
	push de ; $7140
	call TestGameFlag ; $7141
	pop de ; $7144
	jr nz, Label_1e_7163 ; $7145
	call SetGameFlag ; $7147
	push bc ; $714a
	ld b, $00 ; $714b
	ld a, [$d038] ; $714d
	call Func_1e_6feb ; $7150
	ld hl, $d034 ; $7153
	ld a, [hl+] ; $7156
	ld h, [hl] ; $7157
	ld l, a ; $7158
	add hl, bc ; $7159
	ld b, h ; $715a
	ld c, l ; $715b
	ld hl, $d034 ; $715c
	ld a, c ; $715f
	ld [hl+], a ; $7160
	ld [hl], b ; $7161
	pop bc ; $7162
Label_1e_7163:
	ld a, [$c9b5] ; $7163
	swap a ; $7166
	and a, c ; $7168
	cp a, b ; $7169
	jr c, Label_1e_71a0 ; $716a
	ld a, [$d038] ; $716c
	add a, a ; $716f
	add a, a ; $7170
	add a, a ; $7171
	ld hl, $7229 ; $7172
	add a, l ; $7175
	ld l, a ; $7176
	jr nc, Label_1e_717a ; $7177
	inc h ; $7179
Label_1e_717a:
	ld a, [hl+] ; $717a
	ld d, [hl] ; $717b
	ld e, a ; $717c
	push de ; $717d
	call TestGameFlag ; $717e
	pop de ; $7181
	jr nz, Label_1e_71a0 ; $7182
	call SetGameFlag ; $7184
	push bc ; $7187
	ld b, $04 ; $7188
	ld a, [$d038] ; $718a
	call Func_1e_6feb ; $718d
	ld hl, $d034 ; $7190
	ld a, [hl+] ; $7193
	ld h, [hl] ; $7194
	ld l, a ; $7195
	add hl, bc ; $7196
	ld b, h ; $7197
	ld c, l ; $7198
	ld hl, $d034 ; $7199
	ld a, c ; $719c
	ld [hl+], a ; $719d
	ld [hl], b ; $719e
	pop bc ; $719f
Label_1e_71a0:
	ld a, [$c9b6] ; $71a0
	and a, c ; $71a3
	cp a, b ; $71a4
	jr c, Label_1e_71db ; $71a5
	ld a, [$d038] ; $71a7
	add a, a ; $71aa
	add a, a ; $71ab
	add a, a ; $71ac
	ld hl, $722b ; $71ad
	add a, l ; $71b0
	ld l, a ; $71b1
	jr nc, Label_1e_71b5 ; $71b2
	inc h ; $71b4
Label_1e_71b5:
	ld a, [hl+] ; $71b5
	ld d, [hl] ; $71b6
	ld e, a ; $71b7
	push de ; $71b8
	call TestGameFlag ; $71b9
	pop de ; $71bc
	jr nz, Label_1e_71db ; $71bd
	call SetGameFlag ; $71bf
	push bc ; $71c2
	ld b, $02 ; $71c3
	ld a, [$d038] ; $71c5
	call Func_1e_6feb ; $71c8
	ld hl, $d034 ; $71cb
	ld a, [hl+] ; $71ce
	ld h, [hl] ; $71cf
	ld l, a ; $71d0
	add hl, bc ; $71d1
	ld b, h ; $71d2
	ld c, l ; $71d3
	ld hl, $d034 ; $71d4
	ld a, c ; $71d7
	ld [hl+], a ; $71d8
	ld [hl], b ; $71d9
	pop bc ; $71da
Label_1e_71db:
	ld a, [$c9b6] ; $71db
	swap a ; $71de
	and a, c ; $71e0
	cp a, b ; $71e1
	jr c, Label_1e_7218 ; $71e2
	ld a, [$d038] ; $71e4
	add a, a ; $71e7
	add a, a ; $71e8
	add a, a ; $71e9
	ld hl, $722d ; $71ea
	add a, l ; $71ed
	ld l, a ; $71ee
	jr nc, Label_1e_71f2 ; $71ef
	inc h ; $71f1
Label_1e_71f2:
	ld a, [hl+] ; $71f2
	ld d, [hl] ; $71f3
	ld e, a ; $71f4
	push de ; $71f5
	call TestGameFlag ; $71f6
	pop de ; $71f9
	jr nz, Label_1e_7218 ; $71fa
	call SetGameFlag ; $71fc
	push bc ; $71ff
	ld b, $06 ; $7200
	ld a, [$d038] ; $7202
	call Func_1e_6feb ; $7205
	ld hl, $d034 ; $7208
	ld a, [hl+] ; $720b
	ld h, [hl] ; $720c
	ld l, a ; $720d
	add hl, bc ; $720e
	ld b, h ; $720f
	ld c, l ; $7210
	ld hl, $d034 ; $7211
	ld a, c ; $7214
	ld [hl+], a ; $7215
	ld [hl], b ; $7216
	pop bc ; $7217
Label_1e_7218:
	ld hl, $d034 ; $7218
	ld a, [hl+] ; $721b
	ld b, [hl] ; $721c
	ld c, a ; $721d
	pop af ; $721e
	wram_bank ; $721f
	pop hl ; $7223
	pop de ; $7224
	pop af ; $7225
	ret ; $7226
	INCBIN "data/bank_01e/d_7227.bin" ; $7227, 60 bytes
ShowGameProgressScreen:
	push de ; $7263
	ld de, $0720 ; $7264
	farcall FarPtr_TestSaveFlag ; $7267
	pop de ; $726a
	jr z, Label_1e_7270 ; $726b
	set_flag $1f, 6 ; $726d
Label_1e_7270:
	set_flag $1f, 5 ; $7270
	call BuildGameProgressScreen ; $7273
	clear_flag $1f, 5 ; $7276
	call ClearFrameTasks ; $7279
	ret ; $727c
InitGameProgressScreen:
	sound $04 ; $727d
	call ClearFrameTasks ; $727f
	call ClearSpriteQueue ; $7282
	xor a, a ; $7285
	ldh [hScrollX], a ; $7286
	ldh [hScrollY], a ; $7288
	farcall FarPtr_ResetTextWindowState ; $728a
	ld de, $d000 ; $728d
	ld hl, wShadowTilemapPtr ; $7290
	ld a, e ; $7293
	ld [hl+], a ; $7294
	ld [hl], d ; $7295
	ld a, $05 ; $7296
	ld [wShadowTilemapBank], a ; $7298
	ld a, $00 ; $729b
	ld [wWindowTileAttr], a ; $729d
	ld [$d82f], a ; $72a0
	ld a, $ff ; $72a3
	ld c, $30 ; $72a5
	ld hl, $df70 ; $72a7
Label_1e_72aa:
	ld [hl+], a ; $72aa
	dec c ; $72ab
	jr nz, Label_1e_72aa ; $72ac
	ret ; $72ae
BuildGameProgressScreen:
	ldh a, [hWramBank] ; $72af
	push af ; $72b1
	wram_bank $05 ; $72b2
	ld c, $10 ; $72b8
	call BeginFadeOut ; $72ba
	call WaitFadeEnd ; $72bd
	call DisableLCDSafely ; $72c0
	call InitGameProgressScreen ; $72c3
	call LoadGameProgressScreenAssets ; $72c6
	test_flag $1f, 6 ; $72c9
	jr nz, Label_1e_72d0 ; $72cc
	jr Label_1e_72d5 ; $72ce
Label_1e_72d0:
	ld a, $05 ; $72d0
	call RunRewardCategoryList ; $72d2
Label_1e_72d5:
	ld a, $00 ; $72d5
	call RunRewardCategoryList ; $72d7
	test_flag $0a, 3 ; $72da
	jr nz, Label_1e_72e1 ; $72dd
	jr Label_1e_72e6 ; $72df
Label_1e_72e1:
	ld a, $01 ; $72e1
	call RunRewardCategoryList ; $72e3
Label_1e_72e6:
	test_flag $0a, 7 ; $72e6
	jr nz, Label_1e_72ed ; $72e9
	jr Label_1e_72f2 ; $72eb
Label_1e_72ed:
	ld a, $02 ; $72ed
	call RunRewardCategoryList ; $72ef
Label_1e_72f2:
	test_flag $0b, 0 ; $72f2
	jr nz, Label_1e_72f9 ; $72f5
	jr Label_1e_72fe ; $72f7
Label_1e_72f9:
	ld a, $03 ; $72f9
	call RunRewardCategoryList ; $72fb
Label_1e_72fe:
	test_flag $07, 4 ; $72fe
	jr nz, Label_1e_7305 ; $7301
	jr Label_1e_730a ; $7303
Label_1e_7305:
	ld a, $04 ; $7305
	call RunRewardCategoryList ; $7307
Label_1e_730a:
	call Func_1e_7499 ; $730a
	call Func_1e_747c ; $730d
	call Func_1e_73e3 ; $7310
	ld [$df01], a ; $7313
	ld a, [$df01] ; $7316
	set_flag $04, 3 ; $7319
	farcall FarPtr_DrawTextWindowFrame ; $731c
	clear_flag $04, 3 ; $731f
	call Func_1e_74b6 ; $7322
	farcall FarPtr_RedrawWindowRows ; $7325
	call Func_1e_7504 ; $7328
	call Func_1e_7b4c ; $732b
	call EnableLCD ; $732e
	ld a, $01 ; $7331
	ld [$cb0b], a ; $7333
	ld a, $03 ; $7336
	ld [$cb0c], a ; $7338
	ld a, $01 ; $733b
	ld hl, Func_1e_737e ; $733d
	call RegisterFrameTask ; $7340
	ld a, $01 ; $7343
	ld hl, Func_1e_7a8d ; $7345
	call RegisterFrameTask ; $7348
	script_fade_in $10 ; $734b
	call WaitFadeEnd ; $7350
Label_1e_7353:
	call AdvanceFrame ; $7353
	wram_bank $05 ; $7356
	ldh a, [hInputPressed] ; $735c
	bit PADB_UP, a ; $735e
	call nz, Func_1e_73b0 ; $7360
	bit 7, a ; $7363
	call nz, Func_1e_7382 ; $7365
	bit 0, a ; $7368
	jr nz, Label_1e_7376 ; $736a
	bit 1, a ; $736c
	jr nz, Label_1e_7372 ; $736e
	jr Label_1e_7353 ; $7370
Label_1e_7372:
	sound $62 ; $7372
	jr Label_1e_7378 ; $7374
Label_1e_7376:
	sound $5f ; $7376
Label_1e_7378:
	pop af ; $7378
	wram_bank ; $7379
	ret ; $737d
Func_1e_737e:
	farcall FarPtr_39_04 ; $737e
	ret ; $7381
Func_1e_7382:
	push af ; $7382
	farcall FarPtr_ResetGlyphStream ; $7383
	wram_bank $05 ; $7386
	ld a, [$df03] ; $738c
	sub a, $06 ; $738f
	jr c, Label_1e_73ae ; $7391
	ld b, a ; $7393
	ld hl, $df05 ; $7394
	ld a, [hl] ; $7397
	inc a ; $7398
	cp a, b ; $7399
	jr nc, Label_1e_73ae ; $739a
	ld [hl], a ; $739c
	sound $5e ; $739d
	ld a, [$df01] ; $739f
	set_flag $04, 3 ; $73a2
	farcall FarPtr_DrawTextWindowFrame ; $73a5
	clear_flag $04, 3 ; $73a8
	call Func_1e_74b6 ; $73ab
Label_1e_73ae:
	pop af ; $73ae
	ret ; $73af
Func_1e_73b0:
	push af ; $73b0
	farcall FarPtr_ResetGlyphStream ; $73b1
	wram_bank $05 ; $73b4
	ld hl, $df05 ; $73ba
	ld a, [hl] ; $73bd
	dec a ; $73be
	bit 7, a ; $73bf
	jr nz, Label_1e_73d5 ; $73c1
	ld [hl], a ; $73c3
	sound $5e ; $73c4
	ld a, [$df01] ; $73c6
	set_flag $04, 3 ; $73c9
	farcall FarPtr_DrawTextWindowFrame ; $73cc
	clear_flag $04, 3 ; $73cf
	call Func_1e_74b6 ; $73d2
Label_1e_73d5:
	pop af ; $73d5
	ret ; $73d6
	ld d, $02 ; $73d7
	ld e, $00 ; $73d9
	ld b, $10 ; $73db
	ld c, $03 ; $73dd
	farcall FarPtr_CreateWindowFromScreenRect ; $73df
	ret ; $73e2
Func_1e_73e3:
	ld d, $01 ; $73e3
	ld e, $03 ; $73e5
	ld b, $12 ; $73e7
	ld c, $0f ; $73e9
	farcall FarPtr_CreateWindowFromScreenRect ; $73eb
	ret ; $73ee
Func_1e_73ef:
	push hl ; $73ef
	push de ; $73f0
	ld hl, $6d80 ; $73f1
	add a, a ; $73f4
	add a, l ; $73f5
	ld l, a ; $73f6
	jr nc, Label_1e_73fa ; $73f7
	inc h ; $73f9
Label_1e_73fa:
	ld a, [hl+] ; $73fa
	ld d, [hl] ; $73fb
	ld e, a ; $73fc
	call TestGameFlag ; $73fd
	ld a, $01 ; $7400
	jr nz, Label_1e_7405 ; $7402
	xor a, a ; $7404
Label_1e_7405:
	pop de ; $7405
	pop hl ; $7406
	ret ; $7407
RunRewardCategoryList:
	ld hl, RewardSubHandlersC_1e ; $7408
	add a, a ; $740b
	add a, l ; $740c
	ld l, a ; $740d
	jr nc, Label_1e_7411 ; $740e
	inc h ; $7410
Label_1e_7411:
	ld a, [hl+] ; $7411
	ld d, [hl] ; $7412
	ld e, a ; $7413
Label_1e_7414:
	ld a, [de] ; $7414
	cp a, $ff ; $7415
	jr z, Label_1e_7444 ; $7417
	push de ; $7419
	push af ; $741a
	ld hl, $6dd2 ; $741b
	add a, a ; $741e
	add a, l ; $741f
	ld l, a ; $7420
	jr nc, Label_1e_7424 ; $7421
	inc h ; $7423
Label_1e_7424:
	ld a, [hl+] ; $7424
	ld d, [hl] ; $7425
	ld e, a ; $7426
	ld a, d ; $7427
	or a, e ; $7428
	ld a, $01 ; $7429
	jr z, Label_1e_7435 ; $742b
	call TestGameFlag ; $742d
	ld a, $01 ; $7430
	jr nz, Label_1e_7435 ; $7432
	xor a, a ; $7434
Label_1e_7435:
	ld e, a ; $7435
	pop af ; $7436
	ld hl, $df10 ; $7437
	add a, l ; $743a
	ld l, a ; $743b
	jr nc, Label_1e_743f ; $743c
	inc h ; $743e
Label_1e_743f:
	ld [hl], e ; $743f
	pop de ; $7440
	inc de ; $7441
	jr Label_1e_7414 ; $7442
Label_1e_7444:
	ret ; $7444
RewardSubHandlersC_1e:
	; $7445, 12 bytes (records:2)
	dw $7451 ; record 0
	dw $7466 ; record 1
	dw $746d ; record 2
	dw $7474 ; record 3
	dw $7477 ; record 4
	dw $747a ; record 5
	inc bc ; $7451
	inc b ; $7452
	dec b ; $7453
	ld b, $07 ; $7454
	ld [$0e0b], sp ; $7456
	ld de, $1714 ; $7459
	ld a, [de] ; $745c
	dec e ; $745d
	ld e, $1f ; $745e
	jr nz, Label_1e_7483 ; $7460
	ld [hl+], a ; $7462
	inc hl ; $7463
	inc h ; $7464
	rst Rst38 ; $7465
	inc c ; $7466
	rrca ; $7467
	ld [de], a ; $7468
	dec d ; $7469
	jr Label_1e_7487 ; $746a
	ds 1, $ff ; $746c, fill
	dec c ; $746d
	INCBIN "data/bank_01e/d_746e.bin" ; $746e, 6 bytes
	add hl, bc ; $7474
	ld a, [bc] ; $7475
	rst Rst38 ; $7476
	ld bc, rSC ; $7477
	nop ; $747a
	rst Rst38 ; $747b
Func_1e_747c:
	ld c, $00 ; $747c
	ld b, $00 ; $747e
	ld hl, $df10 ; $7480
Label_1e_7483:
	ld de, $df70 ; $7483
Label_1e_7486:
	ld a, [hl+] ; $7486
Label_1e_7487:
	or a, a ; $7487
	jr z, Label_1e_748e ; $7488
	inc b ; $748a
	ld a, c ; $748b
	ld [de], a ; $748c
	inc de ; $748d
Label_1e_748e:
	inc c ; $748e
	ld a, c ; $748f
	cp a, $30 ; $7490
	jr c, Label_1e_7486 ; $7492
	ld a, b ; $7494
	ld [$df03], a ; $7495
	ret ; $7498
Func_1e_7499:
	ld hl, $df40 ; $7499
	ld c, $25 ; $749c
	xor a, a ; $749e
Label_1e_749f:
	push af ; $749f
	call Func_1e_73ef ; $74a0
	ld [hl+], a ; $74a3
	pop af ; $74a4
	inc a ; $74a5
	dec c ; $74a6
	jr nz, Label_1e_749f ; $74a7
	ret ; $74a9
Func_1e_74aa:
	push hl ; $74aa
	ld hl, $df40 ; $74ab
	add a, l ; $74ae
	ld l, a ; $74af
	jr nc, Label_1e_74b3 ; $74b0
	inc h ; $74b2
Label_1e_74b3:
	ld a, [hl] ; $74b3
	pop hl ; $74b4
	ret ; $74b5
Func_1e_74b6:
	farcall FarPtr_PrepareGlyphBuffer ; $74b6
	ld hl, wShadowTilemapPtr ; $74b9
	ld a, [hl+] ; $74bc
	ld d, [hl] ; $74bd
	ld e, a ; $74be
	ld hl, $0082 ; $74bf
	add hl, de ; $74c2
	ld d, h ; $74c3
	ld e, l ; $74c4
	ld a, [$df05] ; $74c5
	ld hl, $df70 ; $74c8
	add a, l ; $74cb
	ld l, a ; $74cc
	jr nc, Label_1e_74d0 ; $74cd
	inc h ; $74cf
Label_1e_74d0:
	ld c, $07 ; $74d0
Label_1e_74d2:
	ld a, [hl+] ; $74d2
	cp a, $ff ; $74d3
	jr z, Label_1e_74f1 ; $74d5
	push hl ; $74d7
	ld hl, $04a0 ; $74d8
	add a, l ; $74db
	ld l, a ; $74dc
	jr nc, Label_1e_74e0 ; $74dd
	inc h ; $74df
Label_1e_74e0:
	push bc ; $74e0
	ld c, $10 ; $74e1
	farcall FarPtr_RenderProportionalTextAt ; $74e3
	pop bc ; $74e6
	ld hl, $0040 ; $74e7
	add hl, de ; $74ea
	ld d, h ; $74eb
	ld e, l ; $74ec
	pop hl ; $74ed
	dec c ; $74ee
	jr nz, Label_1e_74d2 ; $74ef
Label_1e_74f1:
	ld a, $70 ; $74f1
	ld [$c3bb], a ; $74f3
	farcall FarPtr_UploadGlyphBuffer ; $74f6
	ret ; $74f9
LoadGameProgressScreenAssets:
	farcall FarPtr_39_2a ; $74fa
	call Func_1e_79e8 ; $74fd
	call Func_1e_7a14 ; $7500
	ret ; $7503
Func_1e_7504:
	ldh a, [hWramBank] ; $7504
	push af ; $7506
	wram_bank $01 ; $7507
	ld hl, Lz_1e_75a6 ; $750d
	ld de, $d000 ; $7510
	call DecompressData ; $7513
	ld hl, $d000 ; $7516
	ld de, $b000 ; $7519
	ld c, $20 ; $751c
	call QueueVRAMCopy ; $751e
	ld hl, Lz_1e_7692 ; $7521
	ld de, $d000 ; $7524
	call DecompressData ; $7527
	ld hl, $d000 ; $752a
	ld de, $9800 ; $752d
	ld c, $06 ; $7530
	call QueueVRAMCopy ; $7532
	ld hl, Lz_1e_76e2 ; $7535
	ld de, $d000 ; $7538
	call DecompressData ; $753b
	ld hl, $d000 ; $753e
	ld a, $09 ; $7541
	ld c, $03 ; $7543
Label_1e_7545:
	ld [hl+], a ; $7545
	ld [hl+], a ; $7546
	ld [hl+], a ; $7547
	ld [hl+], a ; $7548
	ld de, $000c ; $7549
	add hl, de ; $754c
	ld [hl+], a ; $754d
	ld [hl+], a ; $754e
	ld [hl+], a ; $754f
	ld [hl+], a ; $7550
	ld de, $000c ; $7551
	add hl, de ; $7554
	dec c ; $7555
	jr nz, Label_1e_7545 ; $7556
	ld hl, $d000 ; $7558
	ld de, $b800 ; $755b
	ld c, $06 ; $755e
	call QueueVRAMCopy ; $7560
	ld hl, Palettes_1e_7700 ; $7563
	ld d, $00 ; $7566
	ld e, $02 ; $7568
	call LoadPaletteShadow ; $756a
	pop af ; $756d
	wram_bank ; $756e
	ld hl, $7710 ; $7572
	ld de, $a000 ; $7575
	ld c, $10 ; $7578
	call QueueVRAMCopy ; $757a
	ld hl, $7960 ; $757d
	ld de, $a100 ; $7580
	ld c, $04 ; $7583
	call QueueVRAMCopy ; $7585
	ld hl, $7820 ; $7588
	ld de, $a200 ; $758b
	ld c, $14 ; $758e
	call QueueVRAMCopy ; $7590
	ld hl, Palettes_1e_7810 ; $7593
	ld de, $0a01 ; $7596
	call LoadPaletteShadow ; $7599
	ld hl, Palettes_1e_79e0 ; $759c
	ld de, $0901 ; $759f
	call LoadPaletteShadow ; $75a2
	ret ; $75a5
Lz_1e_75a6:
	INCBIN "data/bank_01e/d_75a6.bin" ; $75a6, 236 bytes
Lz_1e_7692:
	INCBIN "data/bank_01e/d_7692.bin" ; $7692, 80 bytes
Lz_1e_76e2:
	INCBIN "data/bank_01e/d_76e2.bin" ; $76e2, 30 bytes
Palettes_1e_7700:
	; $7700, 272 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $1cc4, $015f, $0000, $7fff ; pal 0: #203139 #ff5200 #000000 #ffffff
	dw $0300, $0240, $0180, $0100 ; pal 1: #00c500 #009400 #006200 #004100
	dw $0000, $0003, $0305, $0306 ; pal 2: #000000 #180000 #29c500 #31c500
	dw $063b, $3e5d, $326d, $3a57 ; pal 3: #de8b08 #ee947b #6a9c62 #bd9473
	dw $1e29, $0c17, $0d1a, $1b2d ; pal 4: #4a8b39 #bd0018 #d54118 #6acd31
	dw $1f32, $1e2d, $001e, $0000 ; pal 5: #94cd39 #6a8b39 #f60000 #000000
	dw $0000, $00c0, $c0a0, $c060 ; pal 6: #000000 #003100 #002983 #001883
	dw $60dc, $7cba, $4cb6, $5cea ; pal 7: #e631c5 #d529ff #b4299c #5239bd
	dw $7894, $30e8, $b058, $d8b4 ; pal 8: #a420f6 #413962 #c51062 #a429b4
	dw $f84c, $78b4, $0078, $0000 ; pal 9: #6210f6 #a429f6 #c51800 #000000
	dw $0000, $0000, $0003, $0305 ; pal 10: #000000 #000000 #180000 #29c500
	dw $0306, $063b, $3e5d, $306f ; pal 11: #31c500 #de8b08 #ee947b #7b1862
	dw $3a55, $1d2a, $0f19, $0f1a ; pal 12: #ac9473 #524a39 #cdc518 #d5c518
	dw $0e15, $000e, $0000, $0000 ; pal 13: #ac8318 #730000 #000000 #000000
	dw $0000, $0000, $0080, $8040 ; pal 14: #000000 #000000 #002000 #001000
	dw $80c0, $c0b8, $f874, $18ec ; pal 15: #003100 #c52983 #a418f6 #623931
	dw $b854, $70a8, $e030, $e0b0 ; pal 16: #a41073 #4129e6 #8308c5 #8329c5
	dw $e050, $00e0, $0000, $0000 ; pal 17: #8310c5 #003900 #000000 #000000
	dw $0000, $0003, $0305, $0306 ; pal 18: #000000 #180000 #29c500 #31c500
	dw $063b, $3e5d, $326d, $3a57 ; pal 19: #de8b08 #ee947b #6a9c62 #bd9473
	dw $1e29, $0c17, $0d1a, $1b2d ; pal 20: #4a8b39 #bd0018 #d54118 #6acd31
	dw $1f32, $1e2d, $001e, $0000 ; pal 21: #94cd39 #6a8b39 #f60000 #000000
	dw $0000, $00c0, $c0a0, $c060 ; pal 22: #000000 #003100 #002983 #001883
	dw $60dc, $7cba, $4cb6, $5cea ; pal 23: #e631c5 #d529ff #b4299c #5239bd
	dw $7894, $30e8, $b058, $d8b4 ; pal 24: #a420f6 #413962 #c51062 #a429b4
	dw $f84c, $78b4, $0078, $0000 ; pal 25: #6210f6 #a429f6 #c51800 #000000
	dw $0003, $0305, $0306, $060b ; pal 26: #180000 #29c500 #31c500 #5a8308
	dw $0e75, $7cbf, $62dd, $72af ; pal 27: #ac9c18 #ff29ff #eeb4c5 #7bace6
	dw $3a55, $1c2b, $1d2a, $1b34 ; pal 28: #ac9473 #5a0839 #524a39 #a4cd31
	dw $3f51, $3f66, $3c5b, $003c ; pal 29: #8bd57b #31de7b #de107b #e60800
	dw $00c0, $c0a0, $c060, $60d0 ; pal 30: #003100 #002983 #001883 #8331c5
	dw $70ae, $3efd, $46bb, $4ef5 ; pal 31: #7329e6 #eebd7b #deac8b #acbd9c
	dw $5caa, $38d4, $b854, $d82c ; pal 32: #5229bd #a43173 #a41073 #6208b4
	dw $fc8a, $fc66, $3cda, $003c ; pal 33: #5220ff #3118ff #d5317b #e60800
Palettes_1e_7810:
	; $7810, 464 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $6bff, $035f, $01df, $0048 ; pal 0: #ffffd5 #ffd500 #ff7300 #411000
	dw $0000, $0000, $0000, $0000 ; pal 1: #000000 #000000 #000000 #000000
	dw $0007, $071b, $1f2d, $3b56 ; pal 2: #390000 #dec508 #6acd39 #b4d573
	dw $366b, $7ebd, $70ef, $78d7 ; pal 3: #5a9c6a #eeacff #7b39e6 #bd31f6
	dw $5ceb, $6cd7, $6dba, $3b6d ; pal 4: #5a39bd #bd31de #d56ade #6ade73
	dw $3f52, $1e2d, $071b, $0007 ; pal 5: #94d57b #6a8b39 #dec508 #390000
	dw $00e0, $e0d8, $f8b4, $dc6a ; pal 6: #003900 #c531c5 #a429f6 #5218bd
	dw $6cd6, $7ebd, $0ef7, $1eeb ; pal 7: #b431de #eeacff #bdbd18 #5abd39
	dw $3ad7, $36eb, $b65d, $dcb6 ; pal 8: #bdb473 #5abd6a #ee946a #b429bd
	dw $fc4a, $78b4, $e0d8, $00e0 ; pal 9: #5210ff #a429f6 #c531c5 #003900
	dw $0007, $071b, $1e2d, $3857 ; pal 10: #390000 #dec508 #6a8b39 #bd1073
	dw $376f, $67bc, $67de, $4ffe ; pal 11: #7bde6a #e6eecd #f6f6cd #f6ff9c
	dw $4ffa, $6fd8, $6fbc, $376f ; pal 12: #d5ff9c #c5f6de #e6eede #7bde6a
	dw $3817, $1e2d, $071b, $0007 ; pal 13: #bd0073 #6a8b39 #dec508 #390000
	dw $00e0, $e0d8, $78b4, $1cea ; pal 14: #003900 #c531c5 #a429f6 #523939
	dw $fcf6, $f61d, $f63b, $e23f ; pal 15: #b439ff #ee83ee #de8bee #ff8bc5
	dw $e23f, $e63b, $e67d, $ccf6 ; pal 16: #ff8bc5 #de8bcd #ee9ccd #b4399c
	dw $1cea, $78b4, $e0d8, $00e0 ; pal 17: #523939 #a429f6 #c531c5 #003900
	dw $0007, $071b, $1e2d, $3857 ; pal 18: #390000 #dec508 #6a8b39 #bd1073
	dw $3f67, $6fbc, $6fd9, $4ff8 ; pal 19: #39de7b #e6eede #cdf6de #c5ff9c
	dw $4ffe, $6fdb, $6fbc, $376f ; pal 20: #f6ff9c #def6de #e6eede #7bde6a
	dw $3817, $1e2d, $071b, $0007 ; pal 21: #bd0073 #6a8b39 #dec508 #390000
	dw $00e0, $e0d8, $78b4, $1cea ; pal 22: #003900 #c531c5 #a429f6 #523939
	dw $ecf6, $f63d, $f6db, $f27f ; pal 23: #b439de #ee8bee #deb4ee #ff9ce6
	dw $f21f, $f69b, $f63d, $ecf6 ; pal 24: #ff83e6 #dea4ee #ee8bee #b439de
	dw $1cea, $78b4, $e0d8, $00e0 ; pal 25: #523939 #a429f6 #c531c5 #003900
	dw $0007, $071b, $1e2d, $3857 ; pal 26: #390000 #dec508 #6a8b39 #bd1073
	dw $3f67, $6fb8, $6fd9, $4ff9 ; pal 27: #39de7b #c5eede #cdf6de #cdff9c
	dw $4ff8, $6fd9, $6fb9, $3f6f ; pal 28: #c5ff9c #cdf6de #cdeede #7bde7b
	dw $3817, $1e2d, $071b, $0007 ; pal 29: #bd0073 #6a8b39 #dec508 #390000
	dw $00e0, $e0d8, $78b4, $1cea ; pal 30: #003900 #c531c5 #a429f6 #523939
	dw $ecf6, $f63d, $f69b, $f29f ; pal 31: #b439de #ee8bee #dea4ee #ffa4e6
	dw $f23f, $f69b, $f69d, $fcf6 ; pal 32: #ff8be6 #dea4ee #eea4ee #b439ff
	dw $1cea, $78b4, $e0d8, $00e0 ; pal 33: #523939 #a429f6 #c531c5 #003900
	dw $007f, $3f7f, $207f, $7ebd ; pal 34: #ff1800 #ffde7b #ff1841 #eeacff
	dw $78f7, $78d7, $59fe, $5cfb ; pal 35: #bd39f6 #bd31f6 #f67bb4 #de39bd
	dw $6fb6, $3f5e, $0c37, $192e ; pal 36: #b4eede #f6d57b #bd0818 #734a31
	dw $1f3f, $103f, $1f3f, $003f ; pal 37: #ffcd39 #ff0820 #ffcd39 #ff0800
	dw $00fc, $fcfe, $1ce6, $fe3d ; pal 38: #e63900 #f639ff #313939 #ee8bff
	dw $7e8f, $be4b, $7e9b, $fe1b ; pal 39: #7ba4ff #5a947b #dea4ff #de83ff
	dw $fe65, $fc7a, $f02c, $f814 ; pal 40: #299cff #d518ff #6208e6 #a400f6
	dw $f8fc, $788c, $f8fc, $00fc ; pal 41: #e639f6 #6220f6 #e639f6 #e63900
	dw $0000, $0000, $0303, $0704 ; pal 42: #000000 #000000 #18c500 #20c508
	dw $0c0b, $1817, $302f, $605f ; pal 43: #5a0018 #bd0031 #7b0862 #ff10c5
	dw $302f, $1817, $0c0b, $0704 ; pal 44: #7b0862 #bd0031 #5a0018 #20c508
	dw $0303, $0000, $0000, $0000 ; pal 45: #18c500 #000000 #000000 #000000
	dw $0000, $0000, $c0c0, $c040 ; pal 46: #000000 #000000 #003183 #001083
	dw $fe7e, $fe02, $06fa, $06fa ; pal 47: #f69cff #1083ff #d5bd08 #d5bd08
	dw $06fa, $fe02, $fe7e, $c040 ; pal 48: #d5bd08 #1083ff #f69cff #001083
	dw $c0c0, $0000, $0000, $0000 ; pal 49: #003183 #000000 #000000 #000000
	dw $0000, $0101, $0302, $0605 ; pal 50: #000000 #084100 #10c500 #298308
	dw $0c0b, $1817, $1f10, $1f1f ; pal 51: #5a0018 #bd0031 #83c539 #ffc539
	dw $0000, $0000, $0000, $0000 ; pal 52: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 53: #000000 #000000 #000000 #000000
	dw $8080, $c040, $60a0, $30d0 ; pal 54: #002000 #001083 #0029c5 #833162
	dw $18e8, $0cf4, $fc04, $fcfc ; pal 55: #413931 #a43918 #2000ff #e639ff
	dw $0000, $0000, $0000, $0000 ; pal 56: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 57: #000000 #000000 #000000 #000000
Palettes_1e_79e0:
	; $79e0, 8 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $59a8, $7e85, $7fff, $0000 ; pal 0: #416ab4 #29a4ff #ffffff #000000
Func_1e_79e8:
	ld hl, wShadowTilemapPtr ; $79e8
	ld a, [hl+] ; $79eb
	ld h, [hl] ; $79ec
	ld l, a ; $79ed
	ld e, $09 ; $79ee
Label_1e_79f0:
	ld a, $2e ; $79f0
	ld b, $2f ; $79f2
	ld c, $0a ; $79f4
Label_1e_79f6:
	ld [hl+], a ; $79f6
	ld [hl], b ; $79f7
	inc hl ; $79f8
	dec c ; $79f9
	jr nz, Label_1e_79f6 ; $79fa
	ld bc, $000c ; $79fc
	add hl, bc ; $79ff
	ld a, $3e ; $7a00
	ld b, $3f ; $7a02
	ld c, $0a ; $7a04
Label_1e_7a06:
	ld [hl+], a ; $7a06
	ld [hl], b ; $7a07
	inc hl ; $7a08
	dec c ; $7a09
	jr nz, Label_1e_7a06 ; $7a0a
	ld bc, $000c ; $7a0c
	add hl, bc ; $7a0f
	dec e ; $7a10
	jr nz, Label_1e_79f0 ; $7a11
	ret ; $7a13
Func_1e_7a14:
	ld hl, wShadowTilemapPtr ; $7a14
	ld a, [hl+] ; $7a17
	ld h, [hl] ; $7a18
	ld l, a ; $7a19
	ld de, $0400 ; $7a1a
	add hl, de ; $7a1d
	ld a, $09 ; $7a1e
	ld e, $12 ; $7a20
Label_1e_7a22:
	ld c, $14 ; $7a22
Label_1e_7a24:
	ld [hl+], a ; $7a24
	dec c ; $7a25
	jr nz, Label_1e_7a24 ; $7a26
	ld bc, $000c ; $7a28
	add hl, bc ; $7a2b
	dec e ; $7a2c
	jr nz, Label_1e_7a22 ; $7a2d
	ret ; $7a2f
	ld hl, $d060 ; $7a30
	ld de, $9860 ; $7a33
	ld c, $1e ; $7a36
	call QueueVRAMCopy ; $7a38
	ret ; $7a3b
Func_1e_7a3c:
	push af ; $7a3c
	push bc ; $7a3d
	push de ; $7a3e
	push hl ; $7a3f
	ld a, b ; $7a40
	add a, a ; $7a41
	add a, $05 ; $7a42
	add a, a ; $7a44
	add a, a ; $7a45
	add a, a ; $7a46
	ld hl, hScrollY ; $7a47
	sub a, [hl] ; $7a4a
	add a, $03 ; $7a4b
	ld e, a ; $7a4d
	ld d, $8c ; $7a4e
	ldh a, [hVBlankCounter] ; $7a50
	rrca ; $7a52
	rrca ; $7a53
	rrca ; $7a54
	and a, $03 ; $7a55
	ld a, $03 ; $7a57
	add a, a ; $7a59
	add a, a ; $7a5a
	add a, $00 ; $7a5b
	ld c, a ; $7a5d
	ld b, $0a ; $7a5e
	call QueueSprite16 ; $7a60
	pop hl ; $7a63
	pop de ; $7a64
	pop bc ; $7a65
	pop af ; $7a66
	ret ; $7a67
Func_1e_7a68:
	push af ; $7a68
	push bc ; $7a69
	push de ; $7a6a
	push hl ; $7a6b
	ld a, b ; $7a6c
	add a, a ; $7a6d
	add a, $05 ; $7a6e
	add a, a ; $7a70
	add a, a ; $7a71
	add a, a ; $7a72
	ld hl, hScrollY ; $7a73
	sub a, [hl] ; $7a76
	add a, $03 ; $7a77
	ld e, a ; $7a79
	ld d, $8c ; $7a7a
	ld a, c ; $7a7c
	add a, a ; $7a7d
	add a, a ; $7a7e
	ld c, $20 ; $7a7f
	add a, c ; $7a81
	ld c, a ; $7a82
	ld b, $0a ; $7a83
	call QueueSprite16 ; $7a85
	pop hl ; $7a88
	pop de ; $7a89
	pop bc ; $7a8a
	pop af ; $7a8b
	ret ; $7a8c
Func_1e_7a8d:
	xor a, a ; $7a8d
	ld [$df07], a ; $7a8e
	ld [$df08], a ; $7a91
	ld a, [$df03] ; $7a94
	sub a, $07 ; $7a97
	ld b, a ; $7a99
	ld a, [$df05] ; $7a9a
	or a, a ; $7a9d
	jr z, Label_1e_7aa3 ; $7a9e
	ld [$df07], a ; $7aa0
Label_1e_7aa3:
	cp a, b ; $7aa3
	jr nc, Label_1e_7aab ; $7aa4
	ld a, $01 ; $7aa6
	ld [$df08], a ; $7aa8
Label_1e_7aab:
	ld a, [$df07] ; $7aab
	or a, a ; $7aae
	jr z, Label_1e_7ac3 ; $7aaf
	ld d, $0a ; $7ab1
	ld e, $18 ; $7ab3
	ld c, $00 ; $7ab5
	farcall FarPtr_38_14 ; $7ab7
	ld c, $20 ; $7aba
	ld b, $00 ; $7abc
	ld h, $02 ; $7abe
	farcall FarPtr_39_1a ; $7ac0
Label_1e_7ac3:
	ld a, [$df08] ; $7ac3
	or a, a ; $7ac6
	jr z, Label_1e_7adb ; $7ac7
	ld d, $0a ; $7ac9
	ld e, $86 ; $7acb
	ld c, $01 ; $7acd
	farcall FarPtr_38_14 ; $7acf
	ld c, $20 ; $7ad2
	ld b, $00 ; $7ad4
	ld h, $03 ; $7ad6
	farcall FarPtr_39_1a ; $7ad8
Label_1e_7adb:
	ld hl, $df70 ; $7adb
	ld a, [$df05] ; $7ade
	add a, l ; $7ae1
	ld l, a ; $7ae2
	jr nc, Label_1e_7ae6 ; $7ae3
	inc h ; $7ae5
Label_1e_7ae6:
	ld c, $07 ; $7ae6
	ld b, $00 ; $7ae8
Label_1e_7aea:
	ld a, [hl+] ; $7aea
	cp a, $ff ; $7aeb
	jr z, Label_1e_7b47 ; $7aed
	ld d, a ; $7aef
	call Func_1e_74aa ; $7af0
	or a, a ; $7af3
	jr z, Label_1e_7b47 ; $7af4
	ld a, d ; $7af6
	cp a, $00 ; $7af7
	jr z, Label_1e_7b1a ; $7af9
	cp a, $0b ; $7afb
	jr nc, Label_1e_7b15 ; $7afd
	dec a ; $7aff
	srl a ; $7b00
	or a, a ; $7b02
	jr z, Label_1e_7b1a ; $7b03
	cp a, $01 ; $7b05
	jr z, Label_1e_7b23 ; $7b07
	cp a, $02 ; $7b09
	jr z, Label_1e_7b2c ; $7b0b
	cp a, $03 ; $7b0d
	jr z, Label_1e_7b35 ; $7b0f
	cp a, $04 ; $7b11
	jr z, Label_1e_7b3e ; $7b13
Label_1e_7b15:
	call Func_1e_7a3c ; $7b15
	jr Label_1e_7b47 ; $7b18
Label_1e_7b1a:
	push bc ; $7b1a
	ld c, $00 ; $7b1b
	call Func_1e_7a68 ; $7b1d
	pop bc ; $7b20
	jr Label_1e_7b47 ; $7b21
Label_1e_7b23:
	push bc ; $7b23
	ld c, $01 ; $7b24
	call Func_1e_7a68 ; $7b26
	pop bc ; $7b29
	jr Label_1e_7b47 ; $7b2a
Label_1e_7b2c:
	push bc ; $7b2c
	ld c, $02 ; $7b2d
	call Func_1e_7a68 ; $7b2f
	pop bc ; $7b32
	jr Label_1e_7b47 ; $7b33
Label_1e_7b35:
	push bc ; $7b35
	ld c, $03 ; $7b36
	call Func_1e_7a68 ; $7b38
	pop bc ; $7b3b
	jr Label_1e_7b47 ; $7b3c
Label_1e_7b3e:
	push bc ; $7b3e
	ld c, $04 ; $7b3f
	call Func_1e_7a68 ; $7b41
	pop bc ; $7b44
	jr Label_1e_7b47 ; $7b45
Label_1e_7b47:
	inc b ; $7b47
	dec c ; $7b48
	jr nz, Label_1e_7aea ; $7b49
	ret ; $7b4b
Func_1e_7b4c:
	ld de, $8200 ; $7b4c
	farcall FarPtr_39_18 ; $7b4f
	ld b, $08 ; $7b52
	ld c, $0f ; $7b54
	farcall FarPtr_LoadIndexedPalette ; $7b56
	ret ; $7b59
	ds 1190, $ff ; $7b5a, fill
