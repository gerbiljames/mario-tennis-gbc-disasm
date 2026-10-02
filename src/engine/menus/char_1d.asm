	farptr ShowCharDataScreen ; $4000
	farptr PromptCharDataConfirm ; $4002
	farptr ShowExpDistributionScreen ; $4004
	farptr RunExpDistributionFlow ; $4006
	farptr ClearPendingExpAwards ; $4008
	farptr SetPendingExpAward ; $400a
	farptr InitCharDataScreenVideo ; $400c
	farptr DrawCharDataConfirmPrompt ; $400e
	farptr StartCharDataValuesSyncTask ; $4010
	farptr StopCharDataValuesSyncTask ; $4012
	farptr GrayscalePaletteColorInPlace ; $4014
ShowCharDataScreen:
	ld b, a ; $4016
	wram_bank WRAM_SCENE ; $4017
	ld a, b ; $401d
	ld [wCharDataSyncSource], a ; $401e
	sound BGM_STATUS_SCREEN ; $4021
	farcall RefreshMainCharacterStats ; $4023
	call EnableLCD ; $4026
	ld c, $7f ; $4029
	call BeginFadeOut ; $402b
	call WaitFadeEnd ; $402e
	call InitCharDataScreenVideo ; $4031
	ld hl, CharDataScreenPalettes ; $4034
	ld_obj_pals de, 5, 1 ; $4037
	call LoadPaletteShadow ; $403a
	wram_bank WRAM_STAGING ; $403d
	ld hl, CharDataScreenGfx14 ; $4043
	ld de, wDecompBuffer ; $4046
	call DecompressData ; $4049
	ld hl, wDecompBuffer ; $404c
	ld de, vTiles0 + $60 * TILE_SIZE + VRAM_BANK1 ; $404f
	ld c, CharDataScreenGfx14_SIZE / 16 ; $4052
	call QueueVRAMCopy ; $4054
	farcall InitMenuBgScroll ; $4057
	ld b, $05 ; $405a
	ld c, $05 ; $405c
	farcall LoadMenuSpritePalettePair ; $405e
	ld a, $0d ; $4061
	ld [wMenuBgScrollAttr], a ; $4063
	ld a, $0d ; $4066
	ld [wMenuBgScrollAttr + 1], a ; $4068
	ld a, $60 ; $406b
	ld [wMenuBgScrollTile], a ; $406d
	ld a, $60 ; $4070
	ld [wMenuBgScrollTile + 1], a ; $4072
	ld hl, rIE ; $4075
	res 2, [hl] ; $4078
	call EnableLCD ; $407a
	call AdvanceFrame ; $407d
	ld a, $01 ; $4080
	ld hl, CharDataScreenBgScrollTask ; $4082
	call RegisterFrameTask ; $4085
	ld a, $01 ; $4088
	ld hl, DrawCharDataPageArrowsTask ; $408a
	call RegisterFrameTask ; $408d
	ld a, $01 ; $4090
	ld hl, CharDataValuesSyncTask ; $4092
	call RegisterFrameTask ; $4095
	farcall StartCharDataScreenAnimTask ; $4098
	script_fade_in $10 ; $409b
	call WaitFadeEnd ; $40a0
	call RunDrillResultInputLoop ; $40a3
	ld hl, rIE ; $40a6
	set 2, [hl] ; $40a9
	ld c, $10 ; $40ab
	call BeginFadeOut ; $40ad
	call WaitFadeEnd ; $40b0
	ld hl, DrawCharDataPageArrowsTask ; $40b3
	call UnregisterFrameTask ; $40b6
	ld hl, CharDataValuesSyncTask ; $40b9
	call UnregisterFrameTask ; $40bc
	ld hl, CharDataScreenBgScrollTask ; $40bf
	call UnregisterFrameTask ; $40c2
	farcall StopCharDataScreenAnimTask ; $40c5
	call ClearFrameTasks ; $40c8
	ret ; $40cb
CharDataScreenBgScrollTask:
	farcall TickMenuBgScroll ; $40cc
	ret ; $40cf
InitDrillWorkRam:
	wram_bank WRAM_SCENE ; $40d0
	xor a ; $40d6
	ld [wCharDataAnimCounter], a ; $40d7
	ld [wCharDataAnimSubStep], a ; $40da
	ld [wCharDataFlushChunk], a ; $40dd
	ld [wCharDataPageArrowMode], a ; $40e0
	ld [wCharDataArrowHold], a ; $40e3
	ld [wCharDataArrowPhase], a ; $40e6
	ld hl, wCharDataStatsSlideX ; $40e9
	ld de, $00a8 ; $40ec
	ld a, e ; $40ef
	ld [hl+], a ; $40f0
	ld [hl], d ; $40f1
	ld hl, wCharDataValuesSlideX ; $40f2
	ld de, $0000 ; $40f5
	ld a, e ; $40f8
	ld [hl+], a ; $40f9
	ld [hl], d ; $40fa
	xor a ; $40fb
	ld [wCharDataStatDeltas], a ; $40fc
	ld [wCharDataStatDeltas + 1], a ; $40ff
	ld [wCharDataStatDeltas + 2], a ; $4102
	ld [wCharDataStatDeltas + 3], a ; $4105
	ld [wCharDataStatDeltas + 4], a ; $4108
	ld [wCharDataStatDeltas + 5], a ; $410b
	ld [wCharDataStatDeltas + 6], a ; $410e
	ld [wCharDataStatDeltas + 7], a ; $4111
	ld [wCharDataStatDeltas + 8], a ; $4114
	ld [wCharDataStatDeltas + 9], a ; $4117
	ld [wCharDataStatDeltas + 10], a ; $411a
	ret ; $411d
BuildCharDataScreenPages:
	farcall CharDataScreen_LoadScreen ; $411e
	call LoadCharDataScreenPageGraphics ; $4121
	xor a ; $4124
	call SaveWorkTilemapToPage ; $4125
	call LoadBasePageIntoWorkTilemap ; $4128
	call BuildMainCharStatPage ; $412b
	ld a, $02 ; $412e
	call SaveWorkTilemapToPage ; $4130
	call LoadBasePageIntoWorkTilemap ; $4133
	call BuildPartnerStatPage ; $4136
	ld a, $03 ; $4139
	call SaveWorkTilemapToPage ; $413b
	call LoadBasePageIntoWorkTilemap ; $413e
	call BuildCharDataSummaryPage ; $4141
	ld a, $01 ; $4144
	call SaveWorkTilemapToPage ; $4146
	ld hl, DrillDisplayData_1d ; $4149
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH + 16 ; $414c
	call ApplyTilemapPatchList ; $414f
	wram_bank WRAM_SCREEN ; $4152
	ld hl, wShadowTilemap ; $4158
	ld de, vBGMap0 ; $415b
	ld c, $24 ; $415e
	call QueueVRAMCopy ; $4160
	wram_bank WRAM_COURT_PLANES ; $4163
	ld hl, wScreenAttrmap ; $4169
	ld de, vBGMap0 + VRAM_BANK1 ; $416c
	ld c, $24 ; $416f
	call QueueVRAMCopy ; $4171
	ret ; $4174
LoadCharDataScreenPageGraphics:
	wram_bank WRAM_STAGING ; $4175
	ld hl, CharDataScreenPageGfx14 ; $417b
	ld de, wDecompBuffer ; $417e
	call DecompressData ; $4181
	ld hl, wDecompBuffer ; $4184
	ld de, vTiles0 + $14 * TILE_SIZE + VRAM_BANK1 ; $4187
	ld c, CharDataScreenPageGfx14_SIZE / 16 ; $418a
	call QueueVRAMCopy ; $418c
	wram_bank WRAM_STAGING ; $418f
	ld hl, CharDataScreenPageGraphicsGfx0 ; $4195
	ld de, wDecompBuffer ; $4198
	call DecompressData ; $419b
	ld hl, wDecompBuffer ; $419e
	ld de, vTiles0 + $1e * TILE_SIZE + VRAM_BANK1 ; $41a1
	ld c, CharDataScreenPageGraphicsGfx0_SIZE / 16 ; $41a4
	call QueueVRAMCopy ; $41a6
	wram_bank WRAM_STAGING ; $41a9
	ld hl, CharDataScreenPageGraphicsGfx1 ; $41af
	ld de, wDecompBuffer ; $41b2
	call DecompressData ; $41b5
	ld hl, wDecompBuffer ; $41b8
	ld de, vTiles0 + $28 * TILE_SIZE + VRAM_BANK1 ; $41bb
	ld c, CharDataScreenPageGraphicsGfx1_SIZE / 16 ; $41be
	call QueueVRAMCopy ; $41c0
	wram_bank WRAM_STAGING ; $41c3
	ld hl, CharDataScreenPageGraphicsGfx2 ; $41c9
	ld de, wDecompBuffer ; $41cc
	call DecompressData ; $41cf
	ld hl, wDecompBuffer ; $41d2
	ld de, vTiles0 + $30 * TILE_SIZE + VRAM_BANK1 ; $41d5
	ld c, $08 ; $41d8
	call QueueVRAMCopy ; $41da
	wram_bank WRAM_STAGING ; $41dd
	ld hl, CharDataScreenPagePatch3Tilemap ; $41e3
	ld de, wDecompBuffer + 28 * TILEMAP_WIDTH ; $41e6
	call DecompressData ; $41e9
	ld hl, wDecompBuffer + 28 * TILEMAP_WIDTH ; $41ec
	ld bc, CharDataScreenPagePatch3Tilemap_SIZE ; $41ef
	call CopyWram1ToWram3CharData ; $41f2
	wram_bank WRAM_STAGING ; $41f5
	ld hl, CharDataScreenPagePatch3Attrmap ; $41fb
	ld de, wDecompBuffer + 28 * TILEMAP_WIDTH ; $41fe
	call DecompressData ; $4201
	ld hl, wDecompBuffer + 28 * TILEMAP_WIDTH ; $4204
	ld bc, CharDataScreenPagePatch3Attrmap_SIZE ; $4207
	call CopyWram1ToWram2CharData ; $420a
	wram_bank WRAM_STAGING ; $420d
	ld hl, CharDataScreenPagePatch0Tilemap ; $4213
	ld de, wDecompBuffer + 28 * TILEMAP_WIDTH + 16 ; $4216
	call DecompressData ; $4219
	ld hl, wDecompBuffer + 28 * TILEMAP_WIDTH + 16 ; $421c
	ld bc, CharDataScreenPagePatch0Tilemap_SIZE ; $421f
	call CopyWram1ToWram3CharData ; $4222
	wram_bank WRAM_STAGING ; $4225
	ld hl, CharDataScreenPagePatch0Attrmap ; $422b
	ld de, wDecompBuffer + 28 * TILEMAP_WIDTH + 16 ; $422e
	call DecompressData ; $4231
	ld hl, wDecompBuffer + 28 * TILEMAP_WIDTH + 16 ; $4234
	ld bc, CharDataScreenPagePatch0Attrmap_SIZE ; $4237
	call CopyWram1ToWram2CharData ; $423a
	wram_bank WRAM_STAGING ; $423d
	ld hl, CharDataScreenPagePatch1Tilemap ; $4243
	ld de, wDecompBuffer + 30 * TILEMAP_WIDTH ; $4246
	call DecompressData ; $4249
	ld hl, wDecompBuffer + 30 * TILEMAP_WIDTH ; $424c
	ld bc, CharDataScreenPagePatch1Tilemap_SIZE ; $424f
	call CopyWram1ToWram3CharData ; $4252
	wram_bank WRAM_STAGING ; $4255
	ld hl, CharDataScreenPagePatch1Attrmap ; $425b
	ld de, wDecompBuffer + 30 * TILEMAP_WIDTH ; $425e
	call DecompressData ; $4261
	ld hl, wDecompBuffer + 30 * TILEMAP_WIDTH ; $4264
	ld bc, CharDataScreenPagePatch1Attrmap_SIZE ; $4267
	call CopyWram1ToWram2CharData ; $426a
	wram_bank WRAM_STAGING ; $426d
	ld hl, CharDataScreenPagePatch1Tilemap ; $4273
	ld de, wDecompBuffer + 34 * TILEMAP_WIDTH + 16 ; $4276
	call DecompressData ; $4279
	ld hl, wDecompBuffer + 34 * TILEMAP_WIDTH + 16 ; $427c
	ld bc, CharDataScreenPagePatch1Tilemap_SIZE ; $427f
	call CopyWram1ToWram3CharData ; $4282
	wram_bank WRAM_STAGING ; $4285
	ld hl, CharDataScreenPagePatch1Attrmap ; $428b
	ld de, wDecompBuffer + 34 * TILEMAP_WIDTH + 16 ; $428e
	call DecompressData ; $4291
	ld hl, wDecompBuffer + 34 * TILEMAP_WIDTH + 16 ; $4294
	ld bc, CharDataScreenPagePatch1Attrmap_SIZE ; $4297
	call CopyWram1ToWram2CharData ; $429a
	wram_bank WRAM_STAGING ; $429d
	ld hl, CharDataScreenPagePatch2Tilemap ; $42a3
	ld de, wDecompBuffer + 39 * TILEMAP_WIDTH ; $42a6
	call DecompressData ; $42a9
	ld hl, wDecompBuffer + 39 * TILEMAP_WIDTH ; $42ac
	ld bc, CharDataScreenPagePatch2Tilemap_SIZE ; $42af
	call CopyWram1ToWram3CharData ; $42b2
	wram_bank WRAM_STAGING ; $42b5
	ld hl, CharDataScreenPagePatch2Attrmap ; $42bb
	ld de, wDecompBuffer + 39 * TILEMAP_WIDTH ; $42be
	call DecompressData ; $42c1
	ld hl, wDecompBuffer + 39 * TILEMAP_WIDTH ; $42c4
	ld bc, CharDataScreenPagePatch2Attrmap_SIZE ; $42c7
	call CopyWram1ToWram2CharData ; $42ca
	wram_bank WRAM_STAGING ; $42cd
	ld hl, CharDataScreenPagePatch4Tilemap ; $42d3
	ld de, wDecompBuffer + 40 * TILEMAP_WIDTH ; $42d6
	call DecompressData ; $42d9
	ld hl, wDecompBuffer + 40 * TILEMAP_WIDTH ; $42dc
	ld bc, CharDataScreenPagePatch4Tilemap_SIZE ; $42df
	call CopyWram1ToWram3CharData ; $42e2
	wram_bank WRAM_STAGING ; $42e5
	ld hl, CharDataScreenPagePatch4Attrmap ; $42eb
	ld de, wDecompBuffer + 40 * TILEMAP_WIDTH ; $42ee
	call DecompressData ; $42f1
	ld hl, wDecompBuffer + 40 * TILEMAP_WIDTH ; $42f4
	ld bc, CharDataScreenPagePatch4Attrmap_SIZE ; $42f7
	call CopyWram1ToWram2CharData ; $42fa
	wram_bank WRAM_STAGING ; $42fd
	ld hl, CharDataScreenPageGfx10 ; $4303
	ld de, wDecompBuffer ; $4306
	call DecompressData ; $4309
	ld hl, wDecompBuffer ; $430c
	ld de, vTiles0 + $38 * TILE_SIZE + VRAM_BANK1 ; $430f
	ld c, CharDataScreenPageGfx10_SIZE / 16 ; $4312
	call QueueVRAMCopy ; $4314
	ld hl, CharDataScreenPageGfx13 ; $4317
	ld de, wDecompBuffer ; $431a
	call DecompressData ; $431d
	ld hl, wDecompBuffer ; $4320
	ld de, vTiles0 + $4c * TILE_SIZE + VRAM_BANK1 ; $4323
	ld c, CharDataScreenPageGfx13_SIZE / 16 ; $4326
	call QueueVRAMCopy ; $4328
	wram_bank WRAM_STAGING ; $432b
	ld hl, CharDataScreenPagePatch5Tilemap ; $4331
	ld de, wDecompBuffer + 41 * TILEMAP_WIDTH + 16 ; $4334
	call DecompressData ; $4337
	ld hl, wDecompBuffer + 41 * TILEMAP_WIDTH + 16 ; $433a
	ld bc, CharDataScreenPagePatch5Tilemap_SIZE ; $433d
	call CopyWram1ToWram3CharData ; $4340
	wram_bank WRAM_STAGING ; $4343
	ld hl, CharDataScreenPagePatch5Attrmap ; $4349
	ld de, wDecompBuffer + 41 * TILEMAP_WIDTH + 16 ; $434c
	call DecompressData ; $434f
	ld hl, wDecompBuffer + 41 * TILEMAP_WIDTH + 16 ; $4352
	ld bc, CharDataScreenPagePatch5Attrmap_SIZE ; $4355
	call CopyWram1ToWram2CharData ; $4358
	xor a ; $435b
	ld [wStoryCharacterSlot], a ; $435c
	push af ; $435f
	ld hl, wStoryModeNameOfMainCharacter ; $4360
	ld a, [wStoryCharacterSlot] ; $4363
	or a ; $4366
	jr z, .zero ; $4367
	ld l, $40 ; $4369
.zero:
	ld a, l ; $436b
	add $0c ; $436c
	ld l, a ; $436e
	ld a, h ; $436f
	adc $00 ; $4370
	ld h, a ; $4372
	pop af ; $4373
	ld a, [hl] ; $4374
	ld_bg_pals de, 4, 1 ; $4375
	farcall LoadIndexedPaletteThunk ; $4378
	wram_bank WRAM_STAGING ; $437b
	push af ; $4381
	ld hl, wStoryModeNameOfMainCharacter ; $4382
	ld a, [wStoryCharacterSlot] ; $4385
	or a ; $4388
	jr z, .zero2 ; $4389
	ld l, $40 ; $438b
.zero2:
	ld a, l ; $438d
	add $0b ; $438e
	ld l, a ; $4390
	ld a, h ; $4391
	adc $00 ; $4392
	ld h, a ; $4394
	pop af ; $4395
	ld a, [hl] ; $4396
	ld de, wDecompBuffer ; $4397
	farcall DecompressCharMugshot ; $439a
	ld hl, wDecompBuffer ; $439d
	ld de, vTiles2 + $20 * TILE_SIZE + VRAM_BANK1 ; $43a0
	ld c, $03 ; $43a3
	call QueueVRAMCopy ; $43a5
	ld hl, wDecompBuffer + 3 * TILE_SIZE ; $43a8
	ld de, vTiles2 + $30 * TILE_SIZE + VRAM_BANK1 ; $43ab
	ld c, $03 ; $43ae
	call QueueVRAMCopy ; $43b0
	ld hl, wDecompBuffer + 6 * TILE_SIZE ; $43b3
	ld de, vTiles2 + $40 * TILE_SIZE + VRAM_BANK1 ; $43b6
	ld c, $03 ; $43b9
	call QueueVRAMCopy ; $43bb
	ld a, $01 ; $43be
	ld [wStoryCharacterSlot], a ; $43c0
	push af ; $43c3
	ld hl, wStoryModeNameOfMainCharacter ; $43c4
	ld a, [wStoryCharacterSlot] ; $43c7
	or a ; $43ca
	jr z, .zero3 ; $43cb
	ld l, $40 ; $43cd
.zero3:
	ld a, l ; $43cf
	add $0c ; $43d0
	ld l, a ; $43d2
	ld a, h ; $43d3
	adc $00 ; $43d4
	ld h, a ; $43d6
	pop af ; $43d7
	ld a, [hl] ; $43d8
	ld_bg_pals de, 1, 1 ; $43d9
	farcall LoadIndexedPaletteThunk ; $43dc
	wram_bank WRAM_STAGING ; $43df
	push af ; $43e5
	ld hl, wStoryModeNameOfMainCharacter ; $43e6
	ld a, [wStoryCharacterSlot] ; $43e9
	or a ; $43ec
	jr z, .zero4 ; $43ed
	ld l, $40 ; $43ef
.zero4:
	ld a, l ; $43f1
	add $0b ; $43f2
	ld l, a ; $43f4
	ld a, h ; $43f5
	adc $00 ; $43f6
	ld h, a ; $43f8
	pop af ; $43f9
	ld a, [hl] ; $43fa
	ld de, wDecompBuffer ; $43fb
	farcall DecompressCharMugshot ; $43fe
	ld hl, wDecompBuffer ; $4401
	ld de, vTiles2 + $23 * TILE_SIZE + VRAM_BANK1 ; $4404
	ld c, $03 ; $4407
	call QueueVRAMCopy ; $4409
	ld hl, wDecompBuffer + 3 * TILE_SIZE ; $440c
	ld de, vTiles2 + $33 * TILE_SIZE + VRAM_BANK1 ; $440f
	ld c, $03 ; $4412
	call QueueVRAMCopy ; $4414
	ld hl, wDecompBuffer + 6 * TILE_SIZE ; $4417
	ld de, vTiles2 + $43 * TILE_SIZE + VRAM_BANK1 ; $441a
	ld c, $03 ; $441d
	call QueueVRAMCopy ; $441f
	ret ; $4422
CopyWram1ToWram3CharData:
	wram_bank WRAM_STAGING ; $4423
	ld d, [hl] ; $4429
	wram_bank WRAM_SCREEN ; $442a
	ld [hl], d ; $4430
	inc hl ; $4431
	dec bc ; $4432
	ld a, b ; $4433
	or c ; $4434
	jr nz, CopyWram1ToWram3CharData ; $4435
	ret ; $4437
CopyWram1ToWram2CharData:
	wram_bank WRAM_STAGING ; $4438
	ld d, [hl] ; $443e
	wram_bank WRAM_COURT_PLANES ; $443f
	ld [hl], d ; $4445
	inc hl ; $4446
	dec bc ; $4447
	ld a, b ; $4448
	or c ; $4449
	jr nz, CopyWram1ToWram2CharData ; $444a
	ret ; $444c
BuildCharDataSummaryFields:
	xor a ; $444d
	ld [wStoryCharacterSlot], a ; $444e
	push af ; $4451
	ld hl, wStoryModeNameOfMainCharacter ; $4452
	ld a, [wStoryCharacterSlot] ; $4455
	or a ; $4458
	jr z, .zero ; $4459
	ld l, $40 ; $445b
.zero:
	ld a, l ; $445d
	add $00 ; $445e
	ld l, a ; $4460
	ld a, h ; $4461
	adc $00 ; $4462
	ld h, a ; $4464
	pop af ; $4465
	ld de, wScreenAttrmap + 30 * TILEMAP_WIDTH + 11 ; $4466
	ld c, $0a ; $4469
	call WriteNameStringTiles ; $446b
	ld hl, CharDataSummaryFieldsTilePlot0 ; $446e
	ld de, wScreenAttrmap + 30 * TILEMAP_WIDTH ; $4471
	ld b, $0c ; $4474
	call PlotTilesAtOffsets ; $4476
	push af ; $4479
	ld hl, wStoryModeNameOfMainCharacter ; $447a
	ld a, [wStoryCharacterSlot] ; $447d
	or a ; $4480
	jr z, .zero2 ; $4481
	ld l, $40 ; $4483
.zero2:
	ld a, l ; $4485
	add $0e ; $4486
	ld l, a ; $4488
	ld a, h ; $4489
	adc $00 ; $448a
	ld h, a ; $448c
	pop af ; $448d
	ld a, [hl] ; $448e
	ld hl, wScreenAttrmap + 31 * TILEMAP_WIDTH + 3 ; $448f
	call DrawFourTileFlagLabel ; $4492
	wram_bank WRAM_SCENE ; $4495
	push af ; $449b
	ld hl, wStoryModeNameOfMainCharacter ; $449c
	ld a, [wStoryCharacterSlot] ; $449f
	or a ; $44a2
	jr z, .zero3 ; $44a3
	ld l, $40 ; $44a5
.zero3:
	ld a, l ; $44a7
	add $18 ; $44a8
	ld l, a ; $44aa
	ld a, h ; $44ab
	adc $00 ; $44ac
	ld h, a ; $44ae
	pop af ; $44af
	ld a, [hl] ; $44b0
	ld h, $00 ; $44b1
	ld l, a ; $44b3
	ld a, $02 ; $44b4
	ld de, wCharDataNumberBuffer ; $44b6
	call FormatDecimalNumberUnsigned ; $44b9
	ld de, wCharDataScreenCell + 30 * TILEMAP_WIDTH + 27 ; $44bc
	farcall CharDataScreen_WriteStatNumber ; $44bf
	wram_bank WRAM_SCENE ; $44c2
	push af ; $44c8
	ld hl, wStoryModeNameOfMainCharacter ; $44c9
	ld a, [wStoryCharacterSlot] ; $44cc
	or a ; $44cf
	jr z, .zero4 ; $44d0
	ld l, $40 ; $44d2
.zero4:
	ld a, l ; $44d4
	add $38 ; $44d5
	ld l, a ; $44d7
	ld a, h ; $44d8
	adc $00 ; $44d9
	ld h, a ; $44db
	pop af ; $44dc
	ld a, [hl] ; $44dd
	ld h, $00 ; $44de
	ld l, a ; $44e0
	ld a, $02 ; $44e1
	ld de, wCharDataNumberBuffer ; $44e3
	call FormatDecimalNumberUnsigned ; $44e6
	ld de, wCharDataScreenCell + 31 * TILEMAP_WIDTH + 25 ; $44e9
	farcall CharDataScreen_WriteStatNumber ; $44ec
	wram_bank WRAM_SCENE ; $44ef
	push af ; $44f5
	ld hl, wStoryModeNameOfMainCharacter ; $44f6
	ld a, [wStoryCharacterSlot] ; $44f9
	or a ; $44fc
	jr z, .zero5 ; $44fd
	ld l, $40 ; $44ff
.zero5:
	ld a, l ; $4501
	add $39 ; $4502
	ld l, a ; $4504
	ld a, h ; $4505
	adc $00 ; $4506
	ld h, a ; $4508
	pop af ; $4509
	ld a, [hl] ; $450a
	ld h, $00 ; $450b
	ld l, a ; $450d
	ld a, $02 ; $450e
	ld de, wCharDataNumberBuffer ; $4510
	call FormatDecimalNumberUnsigned ; $4513
	ld de, wCharDataPagePlane + 3 ; $4516
	farcall CharDataScreen_WriteStatNumber ; $4519
	wram_bank WRAM_SCENE ; $451c
	push af ; $4522
	ld hl, wStoryModeNameOfMainCharacter ; $4523
	ld a, [wStoryCharacterSlot] ; $4526
	or a ; $4529
	jr z, .zero6 ; $452a
	ld l, $40 ; $452c
.zero6:
	ld a, l ; $452e
	add $3a ; $452f
	ld l, a ; $4531
	ld a, h ; $4532
	adc $00 ; $4533
	ld h, a ; $4535
	pop af ; $4536
	ld a, [hl] ; $4537
	ld h, $00 ; $4538
	ld l, a ; $453a
	ld a, $02 ; $453b
	ld de, wCharDataNumberBuffer ; $453d
	call FormatDecimalNumberUnsigned ; $4540
	ld de, wCharDataPagePlane + 13 ; $4543
	farcall CharDataScreen_WriteStatNumber ; $4546
	wram_bank WRAM_SCENE ; $4549
	push af ; $454f
	ld hl, wStoryModeNameOfMainCharacter ; $4550
	ld a, [wStoryCharacterSlot] ; $4553
	or a ; $4556
	jr z, .zero7 ; $4557
	ld l, $40 ; $4559
.zero7:
	ld a, l ; $455b
	add $3b ; $455c
	ld l, a ; $455e
	ld a, h ; $455f
	adc $00 ; $4560
	ld h, a ; $4562
	pop af ; $4563
	ld a, [hl] ; $4564
	ld h, $00 ; $4565
	ld l, a ; $4567
	ld a, $02 ; $4568
	ld de, wCharDataNumberBuffer ; $456a
	call FormatDecimalNumberUnsigned ; $456d
	ld de, wCharDataPagePlane + 23 ; $4570
	farcall CharDataScreen_WriteStatNumber ; $4573
	call ComputeExpProgressBar ; $4576
	ld de, wCharDataPagePlane + 1 * TILEMAP_WIDTH + 15 ; $4579
	call DrawExpProgressBarTiles ; $457c
	wram_bank WRAM_SCENE ; $457f
	xor a ; $4585
	farcall GetExpRemainingToNextLevel ; $4586
	ld a, $03 ; $4589
	ld de, wCharDataNumberBuffer ; $458b
	call FormatDecimalNumberUnsigned ; $458e
	ld hl, wCharDataNumberBuffer ; $4591
	ld de, wCharStatPageMain + 10 ; $4594
	ld a, [hl+] ; $4597
	ld [de], a ; $4598
	inc de ; $4599
	ld a, [hl+] ; $459a
	ld [de], a ; $459b
	inc de ; $459c
	ld a, [hl] ; $459d
	ld [de], a ; $459e
	wram_bank WRAM_SCENE ; $459f
	push af ; $45a5
	ld hl, wStoryModeNameOfMainCharacter ; $45a6
	ld a, [wStoryCharacterSlot] ; $45a9
	or a ; $45ac
	jr z, .zero8 ; $45ad
	ld l, $40 ; $45af
.zero8:
	ld a, l ; $45b1
	add $2c ; $45b2
	ld l, a ; $45b4
	ld a, h ; $45b5
	adc $00 ; $45b6
	ld h, a ; $45b8
	pop af ; $45b9
	call FormatExp24BitDecimal ; $45ba
	ld hl, wCharDataNumberBuffer ; $45bd
	ld de, wCharStatPageMain + 4 ; $45c0
	ld a, [hl] ; $45c3
	or a ; $45c4
	jr nz, .nonZero ; $45c5
	ld bc, wCharDataNumberBuffer_SIZE ; $45c7
	call CopyMemoryBC ; $45ca
	jr .storeStoryCharacterSlot ; $45cd
.nonZero:
	ld h, d ; $45cf
	ld l, e ; $45d0
	ld a, $20 ; $45d1
	ld [hl+], a ; $45d3
	ld a, $39 ; $45d4
	ld [hl+], a ; $45d6
	ld [hl+], a ; $45d7
	ld [hl+], a ; $45d8
	ld [hl+], a ; $45d9
	ld [hl], a ; $45da
.storeStoryCharacterSlot:
	ld a, $01 ; $45db
	ld [wStoryCharacterSlot], a ; $45dd
	push af ; $45e0
	ld hl, wStoryModeNameOfMainCharacter ; $45e1
	ld a, [wStoryCharacterSlot] ; $45e4
	or a ; $45e7
	jr z, .zero9 ; $45e8
	ld l, $40 ; $45ea
.zero9:
	ld a, l ; $45ec
	add $00 ; $45ed
	ld l, a ; $45ef
	ld a, h ; $45f0
	adc $00 ; $45f1
	ld h, a ; $45f3
	pop af ; $45f4
	ld de, wCharDataPagePlane + 2 * TILEMAP_WIDTH + 27 ; $45f5
	ld c, $0a ; $45f8
	call WriteNameStringTiles ; $45fa
	wram_bank WRAM_SCREEN ; $45fd
	ld hl, CharDataSummaryFieldsTilePlot1 ; $4603
	ld de, wCharDataPagePlane + 2 * TILEMAP_WIDTH + 16 ; $4606
	ld b, $09 ; $4609
	call PlotTilesAtOffsets ; $460b
	push af ; $460e
	ld hl, wStoryModeNameOfMainCharacter ; $460f
	ld a, [wStoryCharacterSlot] ; $4612
	or a ; $4615
	jr z, .zero10 ; $4616
	ld l, $40 ; $4618
.zero10:
	ld a, l ; $461a
	add $0e ; $461b
	ld l, a ; $461d
	ld a, h ; $461e
	adc $00 ; $461f
	ld h, a ; $4621
	pop af ; $4622
	ld a, [hl] ; $4623
	ld hl, wCharDataPagePlane + 3 * TILEMAP_WIDTH + 19 ; $4624
	call DrawFourTileFlagLabel ; $4627
	wram_bank WRAM_SCENE ; $462a
	push af ; $4630
	ld hl, wStoryModeNameOfMainCharacter ; $4631
	ld a, [wStoryCharacterSlot] ; $4634
	or a ; $4637
	jr z, .zero11 ; $4638
	ld l, $40 ; $463a
.zero11:
	ld a, l ; $463c
	add $18 ; $463d
	ld l, a ; $463f
	ld a, h ; $4640
	adc $00 ; $4641
	ld h, a ; $4643
	pop af ; $4644
	ld a, [hl] ; $4645
	ld h, $00 ; $4646
	ld l, a ; $4648
	ld a, $02 ; $4649
	ld de, wCharDataNumberBuffer ; $464b
	call FormatDecimalNumberUnsigned ; $464e
	ld de, wCharDataPagePlane + 3 * TILEMAP_WIDTH + 11 ; $4651
	farcall CharDataScreen_WriteStatNumber ; $4654
	wram_bank WRAM_SCENE ; $4657
	push af ; $465d
	ld hl, wStoryModeNameOfMainCharacter ; $465e
	ld a, [wStoryCharacterSlot] ; $4661
	or a ; $4664
	jr z, .zero12 ; $4665
	ld l, $40 ; $4667
.zero12:
	ld a, l ; $4669
	add $38 ; $466a
	ld l, a ; $466c
	ld a, h ; $466d
	adc $00 ; $466e
	ld h, a ; $4670
	pop af ; $4671
	ld a, [hl] ; $4672
	ld h, $00 ; $4673
	ld l, a ; $4675
	ld a, $02 ; $4676
	ld de, wCharDataNumberBuffer ; $4678
	call FormatDecimalNumberUnsigned ; $467b
	ld de, wCharDataPagePlane + 4 * TILEMAP_WIDTH + 9 ; $467e
	farcall CharDataScreen_WriteStatNumber ; $4681
	wram_bank WRAM_SCENE ; $4684
	push af ; $468a
	ld hl, wStoryModeNameOfMainCharacter ; $468b
	ld a, [wStoryCharacterSlot] ; $468e
	or a ; $4691
	jr z, .zero13 ; $4692
	ld l, $40 ; $4694
.zero13:
	ld a, l ; $4696
	add $39 ; $4697
	ld l, a ; $4699
	ld a, h ; $469a
	adc $00 ; $469b
	ld h, a ; $469d
	pop af ; $469e
	ld a, [hl] ; $469f
	ld h, $00 ; $46a0
	ld l, a ; $46a2
	ld a, $02 ; $46a3
	ld de, wCharDataNumberBuffer ; $46a5
	call FormatDecimalNumberUnsigned ; $46a8
	ld de, wCharDataPagePlane + 4 * TILEMAP_WIDTH + 19 ; $46ab
	farcall CharDataScreen_WriteStatNumber ; $46ae
	wram_bank WRAM_SCENE ; $46b1
	push af ; $46b7
	ld hl, wStoryModeNameOfMainCharacter ; $46b8
	ld a, [wStoryCharacterSlot] ; $46bb
	or a ; $46be
	jr z, .zero14 ; $46bf
	ld l, $40 ; $46c1
.zero14:
	ld a, l ; $46c3
	add $3a ; $46c4
	ld l, a ; $46c6
	ld a, h ; $46c7
	adc $00 ; $46c8
	ld h, a ; $46ca
	pop af ; $46cb
	ld a, [hl] ; $46cc
	ld h, $00 ; $46cd
	ld l, a ; $46cf
	ld a, $02 ; $46d0
	ld de, wCharDataNumberBuffer ; $46d2
	call FormatDecimalNumberUnsigned ; $46d5
	ld de, wCharDataPagePlane + 4 * TILEMAP_WIDTH + 29 ; $46d8
	farcall CharDataScreen_WriteStatNumber ; $46db
	wram_bank WRAM_SCENE ; $46de
	push af ; $46e4
	ld hl, wStoryModeNameOfMainCharacter ; $46e5
	ld a, [wStoryCharacterSlot] ; $46e8
	or a ; $46eb
	jr z, .zero15 ; $46ec
	ld l, $40 ; $46ee
.zero15:
	ld a, l ; $46f0
	add $3b ; $46f1
	ld l, a ; $46f3
	ld a, h ; $46f4
	adc $00 ; $46f5
	ld h, a ; $46f7
	pop af ; $46f8
	ld a, [hl] ; $46f9
	ld h, $00 ; $46fa
	ld l, a ; $46fc
	ld a, $02 ; $46fd
	ld de, wCharDataNumberBuffer ; $46ff
	call FormatDecimalNumberUnsigned ; $4702
	ld de, wCharDataPagePlane + 5 * TILEMAP_WIDTH + 7 ; $4705
	farcall CharDataScreen_WriteStatNumber ; $4708
	call ComputeExpProgressBar ; $470b
	ld de, wCharDataPagePlane + 5 * TILEMAP_WIDTH + 31 ; $470e
	call DrawExpProgressBarTiles ; $4711
	wram_bank WRAM_SCENE ; $4714
	ld a, $01 ; $471a
	farcall GetExpRemainingToNextLevel ; $471c
	ld a, $03 ; $471f
	ld de, wCharDataNumberBuffer ; $4721
	call FormatDecimalNumberUnsigned ; $4724
	ld hl, wCharDataNumberBuffer ; $4727
	ld de, wCharStatPagePartner + 10 ; $472a
	ld a, [hl+] ; $472d
	ld [de], a ; $472e
	inc de ; $472f
	ld a, [hl+] ; $4730
	ld [de], a ; $4731
	inc de ; $4732
	ld a, [hl] ; $4733
	ld [de], a ; $4734
	wram_bank WRAM_SCENE ; $4735
	push af ; $473b
	ld hl, wStoryModeNameOfMainCharacter ; $473c
	ld a, [wStoryCharacterSlot] ; $473f
	or a ; $4742
	jr z, .zero16 ; $4743
	ld l, $40 ; $4745
.zero16:
	ld a, l ; $4747
	add $2c ; $4748
	ld l, a ; $474a
	ld a, h ; $474b
	adc $00 ; $474c
	ld h, a ; $474e
	pop af ; $474f
	call FormatExp24BitDecimal ; $4750
	ld hl, wCharDataNumberBuffer ; $4753
	ld de, wCharStatPagePartner + 4 ; $4756
	ld a, [hl] ; $4759
	or a ; $475a
	jr nz, .nonZero2 ; $475b
	ld bc, wCharDataNumberBuffer_SIZE ; $475d
	call CopyMemoryBC ; $4760
	ret ; $4763
.nonZero2:
	ld h, d ; $4764
	ld l, e ; $4765
	ld a, $20 ; $4766
	ld [hl+], a ; $4768
	ld a, $39 ; $4769
	ld [hl+], a ; $476b
	ld [hl+], a ; $476c
	ld [hl+], a ; $476d
	ld [hl+], a ; $476e
	ld [hl], a ; $476f
	ret ; $4770
