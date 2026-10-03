	farptr ShowMatchResultsScreen ; $4000
	farptr StubNop_1e ; $4002
	farptr ProcessMatchRewards ; $4004
	farptr ApplyPendingExpAwards ; $4006
	farptr ShowGameProgressScreen ; $4008
	farptr FetchAndDrawDialogueText ; $400a
	farptr WriteTextToTilemap ; $400c
ShowMatchResultsScreen:
	clear_flag FLAG_TEMP_RESULTS_SCREEN_OPEN ; $400e
	ld a, [wGameMode] ; $4011
	cp GAMEMODE_TRAINING_DRILL ; $4014
	jr z, .checkExpScreen ; $4016
	cp GAMEMODE_TENNIS_MACHINE ; $4018
	jr z, .checkExpScreen ; $401a
	cp GAMEMODE_WALL_PRACTICE ; $401c
	jr z, .checkExpScreen ; $401e
	cp GAMEMODE_MARIO_MINIGAME ; $4020
	test_flag FLAG_DOUBLES ; $4022
	jr z, .checkExpScreen ; $4025
	set_flag FLAG_TEMP_RESULTS_SCREEN_OPEN ; $4027
.checkExpScreen:
	ld a, c ; $402a
	or a ; $402b
	jr z, .showResults ; $402c
	jp ShowExpAwardScreen ; $402e
.showResults:
	ld c, $10 ; $4031
	call BeginFadeOut ; $4033
	call WaitFadeEnd ; $4036
	sound BGM_MENU ; $4039
	push bc ; $403b
	farcall InitTextWindows ; $403c
	ld hl, wShadowTilemapBank ; $403f
	ld [hl], $03 ; $4042
	farcall PrepareGlyphBuffer ; $4044
	call ClearFrameTasks ; $4047
	call DisableLCDSafely ; $404a
	xor a ; $404d
	ldh [hScrollX], a ; $404e
	ldh [hScrollY], a ; $4050
	ld [wCameraX], a ; $4052
	ld [wCameraX + 1], a ; $4055
	ld [wCameraY], a ; $4058
	ld [wCameraY + 1], a ; $405b
	ld a, $90 ; $405e
	ldh [rWY], a ; $4060
	call ClearSpriteQueue ; $4062
	farcall InitActorEngine ; $4065
	pop bc ; $4068
	call InitResultsPromptState ; $4069
	call BuildResultsScreenTilemap ; $406c
	call InitResultsScreenCharacters ; $406f
	call EnableLCD ; $4072
	call AdvanceFrame ; $4075
	ld a, $01 ; $4078
	ld hl, DrawResultsCharSprites ; $407a
	call RegisterFrameTask ; $407d
	script_fade_in $10 ; $4080
	call WaitFadeEnd ; $4085
	call RunContinuePrompt ; $4088
	ld c, $10 ; $408b
	call BeginFadeOut ; $408d
	call WaitFadeEnd ; $4090
	ld hl, DrawResultsCharSprites ; $4093
	call UnregisterFrameTask ; $4096
	farcall LoadMenuFontGfx ; $4099
	wram_bank WRAM_SCENE ; $409c
	ld hl, wExpAwardRunningTotal ; $40a2
	ld a, [hl+] ; $40a5
	ld h, [hl] ; $40a6
	ld l, a ; $40a7
	ld a, [wContinuePromptResult] ; $40a8
	ret ; $40ab
InitResultsPromptState:
	wram_bank WRAM_SCENE ; $40ac
	ld a, c ; $40b2
	ld [wContinuePromptKind], a ; $40b3
	xor a ; $40b6
	ld [wContinuePromptRow], a ; $40b7
	ld [wContinuePromptPage], a ; $40ba
	ret ; $40bd
BuildResultsScreenTilemap:
	call LoadResultsScreenGraphics ; $40be
	ld hl, Text_31_210 ; $40c1
	ld de, wDecompBuffer + 4 * TILE_SIZE + 1 ; $40c4
	ld bc, $0020 ; $40c7
	call DrawProportionalTextLine ; $40ca
	ld hl, Text_31_211 ; $40cd
	call DrawProportionalTextLine ; $40d0
	ld hl, Text_31_212 ; $40d3
	call DrawProportionalTextLine ; $40d6
	call BuildResultsScreenPanels ; $40d9
	call DrawPlayerNameAndLevel ; $40dc
	wram_bank WRAM_SCREEN ; $40df
	ld hl, wShadowTilemap ; $40e5
	ld de, vBGMap0 ; $40e8
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $40eb
	call QueueVRAMCopy ; $40ed
	wram_bank WRAM_COURT_PLANES ; $40f0
	ld hl, wScreenAttrmap ; $40f6
	ld de, vBGMap0 + VRAM_BANK1 ; $40f9
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $40fc
	call QueueVRAMCopy ; $40fe
	farcall UploadGlyphBuffer ; $4101
	ret ; $4104
LoadResultsScreenGraphics:
	ld hl, ResultsScreenPalettes ; $4105
	ld_bg_pals de, 0, 6 ; $4108
	call LoadPaletteShadow ; $410b
	ld hl, ResultsScreenPalettes ; $410e
	ld_obj_pals de, 0, 1 ; $4111
	call LoadPaletteShadow ; $4114
	wram_bank WRAM_STAGING ; $4117
	ld hl, ResultsScreenGfx_1e ; $411d
	ld de, wDecompBuffer ; $4120
	call DecompressData ; $4123
	ld hl, wDecompBuffer ; $4126
	ld de, vTiles2 + VRAM_BANK1 ; $4129
	ld c, $80 ; $412c -- 128 of ResultsScreenGfx_1e's 176 tiles
	call QueueVRAMCopy ; $412e
	ld hl, wTextTileBuffer ; $4131
	ld de, vTiles1 + VRAM_BANK1 ; $4134
	ld c, wTextTileBuffer_SIZE / 16 ; $4137
	call QueueVRAMCopy ; $4139
	wram_bank WRAM_STAGING ; $413c
	ld hl, ResultsScreenTilemap_1e ; $4142
	ld de, wDecompBuffer ; $4145
	call DecompressData ; $4148
	ld hl, wDecompBuffer ; $414b
	ld bc, $0240 ; $414e
	call ResultsCopyToTilemap ; $4151
	wram_bank WRAM_STAGING ; $4154
	ld hl, ResultsScreenAttrmap_1e ; $415a
	ld de, wDecompBuffer ; $415d
	call DecompressData ; $4160
	ld hl, wDecompBuffer ; $4163
	ld bc, $0240 ; $4166
	call ResultsCopyToAttrmap ; $4169
	wram_bank WRAM_STAGING ; $416c
	ld hl, PanelFrameGfx_1e ; $4172
	ld de, wDecompBuffer ; $4175
	call DecompressData ; $4178
	ld hl, wDecompBuffer ; $417b
	ld de, vTiles2 ; $417e
	ld c, PanelFrameGfx_1e_SIZE / 16 ; $4181
	call QueueVRAMCopy ; $4183
	ret ; $4186
ResultsCopyToTilemap:
	wram_bank WRAM_STAGING ; $4187
	ld d, [hl] ; $418d
	wram_bank WRAM_SCREEN ; $418e
	ld [hl], d ; $4194
	inc hl ; $4195
	dec bc ; $4196
	ld a, b ; $4197
	or c ; $4198
	jr nz, ResultsCopyToTilemap ; $4199
	ret ; $419b
ResultsCopyToAttrmap:
	wram_bank WRAM_STAGING ; $419c
	ld d, [hl] ; $41a2
	wram_bank WRAM_COURT_PLANES ; $41a3
	ld [hl], d ; $41a9
	inc hl ; $41aa
	dec bc ; $41ab
	ld a, b ; $41ac
	or c ; $41ad
	jr nz, ResultsCopyToAttrmap ; $41ae
	ret ; $41b0
BuildResultsScreenPanels:
	wram_bank WRAM_SCREEN ; $41b1
	ld a, $02 ; $41b7
	ld [wShadowTilemap], a ; $41b9
	ld a, $04 ; $41bc
	ld [wShadowTilemap + 19], a ; $41be
	ld a, $07 ; $41c1
	ld [wShadowTilemap + 4 * TILEMAP_WIDTH], a ; $41c3
	ld a, $09 ; $41c6
	ld [wShadowTilemap + 4 * TILEMAP_WIDTH + 19], a ; $41c8
	ld a, $03 ; $41cb
	ld hl, wShadowTilemap + 1 ; $41cd
	ld c, $12 ; $41d0
	call FillMemoryC ; $41d2
	ld a, $08 ; $41d5
	ld hl, wShadowTilemap + 4 * TILEMAP_WIDTH + 1 ; $41d7
	ld c, $12 ; $41da
	call FillMemoryC ; $41dc
	ld a, $05 ; $41df
	ld [wShadowTilemap + 1 * TILEMAP_WIDTH], a ; $41e1
	ld [wShadowTilemap + 2 * TILEMAP_WIDTH], a ; $41e4
	ld [wShadowTilemap + 3 * TILEMAP_WIDTH], a ; $41e7
	ld a, $06 ; $41ea
	ld [wShadowTilemap + 1 * TILEMAP_WIDTH + 19], a ; $41ec
	ld [wShadowTilemap + 2 * TILEMAP_WIDTH + 19], a ; $41ef
	ld [wShadowTilemap + 3 * TILEMAP_WIDTH + 19], a ; $41f2
	ld a, $20 ; $41f5
	ld hl, wShadowTilemap + 1 * TILEMAP_WIDTH + 1 ; $41f7
	ld c, $12 ; $41fa
	call FillMemoryC ; $41fc
	ld hl, wShadowTilemap + 2 * TILEMAP_WIDTH + 1 ; $41ff
	ld c, $12 ; $4202
	call FillMemoryC ; $4204
	ld hl, wShadowTilemap + 3 * TILEMAP_WIDTH + 1 ; $4207
	ld c, $12 ; $420a
	call FillMemoryC ; $420c
	wram_bank WRAM_COURT_PLANES ; $420f
	xor a ; $4215
	ld hl, wScreenAttrmap ; $4216
	ld c, $a0 ; $4219
	call FillMemoryC ; $421b
	ld hl, wScreenAttrmap + 2 * TILEMAP_WIDTH + 1 ; $421e
	call DrawContinuePromptText ; $4221
	wram_bank WRAM_SCREEN ; $4224
	ld a, $02 ; $422a
	ld [wShadowTilemap + 13 * TILEMAP_WIDTH], a ; $422c
	ld a, $04 ; $422f
	ld [wShadowTilemap + 13 * TILEMAP_WIDTH + 19], a ; $4231
	ld a, $07 ; $4234
	ld [wShadowTilemap + 17 * TILEMAP_WIDTH], a ; $4236
	ld a, $09 ; $4239
	ld [wShadowTilemap + 17 * TILEMAP_WIDTH + 19], a ; $423b
	ld a, $03 ; $423e
	ld hl, wShadowTilemap + 13 * TILEMAP_WIDTH + 1 ; $4240
	ld c, $12 ; $4243
	call FillMemoryC ; $4245
	ld a, $08 ; $4248
	ld hl, wShadowTilemap + 17 * TILEMAP_WIDTH + 1 ; $424a
	ld c, $12 ; $424d
	call FillMemoryC ; $424f
	ld a, $05 ; $4252
	ld [wShadowTilemap + 14 * TILEMAP_WIDTH], a ; $4254
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH], a ; $4257
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH], a ; $425a
	ld a, $06 ; $425d
	ld [wShadowTilemap + 14 * TILEMAP_WIDTH + 19], a ; $425f
	ld [wShadowTilemap + 15 * TILEMAP_WIDTH + 19], a ; $4262
	ld [wShadowTilemap + 16 * TILEMAP_WIDTH + 19], a ; $4265
	ld a, $20 ; $4268
	ld hl, wShadowTilemap + 14 * TILEMAP_WIDTH + 1 ; $426a
	ld c, $12 ; $426d
	call FillMemoryC ; $426f
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH + 1 ; $4272
	ld c, $12 ; $4275
	call FillMemoryC ; $4277
	ld hl, wShadowTilemap + 16 * TILEMAP_WIDTH + 1 ; $427a
	ld c, $12 ; $427d
	call FillMemoryC ; $427f
	wram_bank WRAM_COURT_PLANES ; $4282
	xor a ; $4288
	ld hl, wScreenAttrmap + 13 * TILEMAP_WIDTH ; $4289
	ld c, $a0 ; $428c
	call FillMemoryC ; $428e
	wram_bank WRAM_SCREEN ; $4291
	ld a, $02 ; $4297
	ld [wShadowTilemap + 6 * TILEMAP_WIDTH + 14], a ; $4299
	ld a, $04 ; $429c
	ld [wShadowTilemap + 6 * TILEMAP_WIDTH + 19], a ; $429e
	ld a, $07 ; $42a1
	ld [wShadowTilemap + 9 * TILEMAP_WIDTH + 14], a ; $42a3
	ld a, $09 ; $42a6
	ld [wShadowTilemap + 9 * TILEMAP_WIDTH + 19], a ; $42a8
	ld a, $03 ; $42ab
	ld hl, wShadowTilemap + 6 * TILEMAP_WIDTH + 15 ; $42ad
	ld [hl+], a ; $42b0
	ld [hl+], a ; $42b1
	ld [hl+], a ; $42b2
	ld [hl+], a ; $42b3
	ld a, $08 ; $42b4
	ld hl, wShadowTilemap + 9 * TILEMAP_WIDTH + 15 ; $42b6
	ld [hl+], a ; $42b9
	ld [hl+], a ; $42ba
	ld [hl+], a ; $42bb
	ld [hl+], a ; $42bc
	ld a, $05 ; $42bd
	ld [wShadowTilemap + 7 * TILEMAP_WIDTH + 14], a ; $42bf
	ld [wShadowTilemap + 8 * TILEMAP_WIDTH + 14], a ; $42c2
	ld a, $06 ; $42c5
	ld [wShadowTilemap + 7 * TILEMAP_WIDTH + 19], a ; $42c7
	ld [wShadowTilemap + 8 * TILEMAP_WIDTH + 19], a ; $42ca
	xor a ; $42cd
	ld [wShadowTilemap + 7 * TILEMAP_WIDTH + 15], a ; $42ce
	ld [wShadowTilemap + 7 * TILEMAP_WIDTH + 18], a ; $42d1
	ld [wShadowTilemap + 8 * TILEMAP_WIDTH + 15], a ; $42d4
	ld [wShadowTilemap + 8 * TILEMAP_WIDTH + 18], a ; $42d7
	ld hl, Text_31_213 ; $42da
	ld de, wShadowTilemap + 7 * TILEMAP_WIDTH + 16 ; $42dd
	ld bc, $0020 ; $42e0
	call FetchAndDrawDialogueText ; $42e3
	ld hl, Text_31_214 ; $42e6
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 16 ; $42e9
	ld bc, $0020 ; $42ec
	call FetchAndDrawDialogueText ; $42ef
	wram_bank WRAM_COURT_PLANES ; $42f2
	xor a ; $42f8
	ld hl, wScreenAttrmap + 6 * TILEMAP_WIDTH + 14 ; $42f9
	ld c, $06 ; $42fc
	call FillMemoryC ; $42fe
	ld hl, wScreenAttrmap + 7 * TILEMAP_WIDTH + 14 ; $4301
	ld c, $06 ; $4304
	call FillMemoryC ; $4306
	ld hl, wScreenAttrmap + 8 * TILEMAP_WIDTH + 14 ; $4309
	ld c, $06 ; $430c
	call FillMemoryC ; $430e
	ld hl, wScreenAttrmap + 9 * TILEMAP_WIDTH + 14 ; $4311
	ld c, $06 ; $4314
	call FillMemoryC ; $4316
	ld a, [wGameMode] ; $4319
	or a ; $431c
	jp z, DrawStoryResultsHeader ; $431d
	cp GAMEMODE_EXHIBITION ; $4320
	jp z, DrawExhibitionResultsHeader ; $4322
	cp GAMEMODE_RANKING_MATCH ; $4325
	jp z, DrawRankMatchResultsHeader ; $4327
	cp GAMEMODE_ISLAND_OPEN ; $432a
	jp z, DrawTournamentResultsHeader ; $432c
	cp GAMEMODE_PRACTICE_MATCH ; $432f
	jp z, DrawPracticeResultsHeader ; $4331
	cp GAMEMODE_DREAM_MATCH ; $4334
	jp z, DrawMarioExhibitionResultsHeader ; $4336
	ret ; $4339
LoadSinglesLabelTiles:
	wram_bank WRAM_STAGING ; $433a
	ld hl, ResultsSinglesLabelTilemap_1e ; $4340
	ld de, wDecompBuffer ; $4343
	call DecompressData ; $4346
	ret ; $4349
LoadDoublesLabelTiles:
	wram_bank WRAM_STAGING ; $434a
	ld hl, ResultsDoublesLabelTilemap_1e ; $4350
	ld de, wDecompBuffer ; $4353
	call DecompressData ; $4356
	ret ; $4359
DrawResultsNameLabelRows:
	or a ; $435a
	jr nz, .doublesLayout ; $435b
	ld hl, wScreenAttrmap ; $435d
	ld de, wScreenAttrmap + 11 * TILEMAP_WIDTH ; $4360
	ld c, $07 ; $4363
	call CopyLabelTilesToTilemap ; $4365
	ld de, wScreenAttrmap + 12 * TILEMAP_WIDTH ; $4368
	ld c, $07 ; $436b
	call CopyLabelTilesToTilemap ; $436d
	wram_bank WRAM_SCREEN ; $4370
	ld a, $20 ; $4376
	ld hl, wShadowTilemap + 13 * TILEMAP_WIDTH + 1 ; $4378
	ld c, $05 ; $437b
	call FillMemoryC ; $437d
	ld a, $05 ; $4380
	ld [wShadowTilemap + 13 * TILEMAP_WIDTH], a ; $4382
	ld a, $08 ; $4385
	ld [wShadowTilemap + 13 * TILEMAP_WIDTH + 6], a ; $4387
	wram_bank WRAM_COURT_PLANES ; $438a
	ld a, $08 ; $4390
	ld [wScreenAttrmap + 13 * TILEMAP_WIDTH + 6], a ; $4392
	ret ; $4395
.doublesLayout:
	ld hl, wScreenAttrmap ; $4396
	ld de, wScreenAttrmap + 9 * TILEMAP_WIDTH ; $4399
	ld c, $07 ; $439c
	call CopyLabelTilesToTilemap ; $439e
	ld de, wScreenAttrmap + 10 * TILEMAP_WIDTH ; $43a1
	ld c, $07 ; $43a4
	call CopyLabelTilesToTilemap ; $43a6
	wram_bank WRAM_SCREEN ; $43a9
	ld a, $20 ; $43af
	ld hl, wShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; $43b1
	ld c, $12 ; $43b4
	call FillMemoryC ; $43b6
	ld hl, wShadowTilemap + 13 * TILEMAP_WIDTH + 1 ; $43b9
	ld c, $12 ; $43bc
	call FillMemoryC ; $43be
	ld hl, wShadowTilemap + 11 * TILEMAP_WIDTH + 1 ; $43c1
	ld c, $05 ; $43c4
	call FillMemoryC ; $43c6
	ld a, $04 ; $43c9
	ld [wShadowTilemap + 11 * TILEMAP_WIDTH + 19], a ; $43cb
	ld a, $03 ; $43ce
	ld hl, wShadowTilemap + 11 * TILEMAP_WIDTH + 7 ; $43d0
	ld c, $0c ; $43d3
	call FillMemoryC ; $43d5
	ld a, $05 ; $43d8
	ld [wShadowTilemap + 11 * TILEMAP_WIDTH], a ; $43da
	ld [wShadowTilemap + 12 * TILEMAP_WIDTH], a ; $43dd
	ld [wShadowTilemap + 13 * TILEMAP_WIDTH], a ; $43e0
	ld a, $06 ; $43e3
	ld [wShadowTilemap + 12 * TILEMAP_WIDTH + 19], a ; $43e5
	ld [wShadowTilemap + 13 * TILEMAP_WIDTH + 19], a ; $43e8
	ld a, $08 ; $43eb
	ld [wShadowTilemap + 11 * TILEMAP_WIDTH + 6], a ; $43ed
	wram_bank WRAM_COURT_PLANES ; $43f0
	xor a ; $43f6
	ld hl, wScreenAttrmap + 11 * TILEMAP_WIDTH ; $43f7
	ld c, $14 ; $43fa
	call FillMemoryC ; $43fc
	ld hl, wScreenAttrmap + 12 * TILEMAP_WIDTH ; $43ff
	ld c, $14 ; $4402
	call FillMemoryC ; $4404
	ld a, $08 ; $4407
	ld [wScreenAttrmap + 11 * TILEMAP_WIDTH + 6], a ; $4409
	ret ; $440c
CopyLabelTilesToTilemap:
	wram_bank WRAM_STAGING ; $440d
	ld b, [hl] ; $4413
	wram_bank WRAM_SCREEN ; $4414
	ld a, b ; $441a
	ld [de], a ; $441b
	wram_bank WRAM_COURT_PLANES ; $441c
	ld a, $08 ; $4422
	ld [de], a ; $4424
	inc hl ; $4425
	inc de ; $4426
	dec c ; $4427
	jr nz, CopyLabelTilesToTilemap ; $4428
	ret ; $442a
UnusedClearLabelTilemapRow:
	wram_bank WRAM_SCREEN ; $442b
	ld a, $20 ; $4431
	ld hl, wShadowTilemap + 13 * TILEMAP_WIDTH + 1 ; $4433
	ld c, $05 ; $4436
	call FillMemoryC ; $4438
	wram_bank WRAM_SCREEN ; $443b
	ld a, $05 ; $4441
	ld [wShadowTilemap + 13 * TILEMAP_WIDTH], a ; $4443
	wram_bank WRAM_COURT_PLANES ; $4446
	xor a ; $444c
	ld [wScreenAttrmap + 13 * TILEMAP_WIDTH], a ; $444d
	ld a, $08 ; $4450
	ld [wScreenAttrmap + 13 * TILEMAP_WIDTH + 6], a ; $4452
	wram_bank WRAM_SCREEN ; $4455
	ld a, $08 ; $445b
	ld [wShadowTilemap + 13 * TILEMAP_WIDTH + 6], a ; $445d
	ret ; $4460
FillMemoryC:
	ld [hl+], a ; $4461
	dec c ; $4462
	jr nz, FillMemoryC ; $4463
	ret ; $4465
DrawStoryResultsHeader:
	test_flag FLAG_ISLAND_SKY_SCENE_ACTIVE ; $4466
	jr nz, .skyScene ; $4469
	ld a, [wStoryReturnLocation] ; $446b
	cp STORYLOC_PEACHS_CASTLE ; $446e
	jr z, .altPosition ; $4470
	ld hl, Text_31_216 ; $4472
	ld de, wScreenAttrmap + 14 * TILEMAP_WIDTH + 3 ; $4475
	ld bc, $0020 ; $4478
	call DrawProportionalTextLine ; $447b
	jr .drawOpponentName ; $447e
.skyScene:
	ld hl, Text_31_217 ; $4480
	ld de, wScreenAttrmap + 14 * TILEMAP_WIDTH + 2 ; $4483
	ld bc, $0020 ; $4486
	call DrawProportionalTextLine ; $4489
.drawOpponentName:
	ld a, [wStoryReturnLocation] ; $448c
	add $79 ; $448f
	ld l, a ; $4491
	adc $01 ; $4492
	sub l ; $4494
	ld h, a ; $4495
	ld de, wScreenAttrmap + 16 * TILEMAP_WIDTH + 4 ; $4496
	ld bc, $0020 ; $4499
	call DrawProportionalTextLine ; $449c
	ret ; $449f
.altPosition:
	add $79 ; $44a0
	ld l, a ; $44a2
	adc $01 ; $44a3
	sub l ; $44a5
	ld h, a ; $44a6
	ld de, wScreenAttrmap + 15 * TILEMAP_WIDTH + 7 ; $44a7
	ld bc, $0020 ; $44aa
	call DrawProportionalTextLine ; $44ad
	ret ; $44b0
