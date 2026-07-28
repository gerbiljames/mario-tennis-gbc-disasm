SECTION "ROM Bank $1d", ROMX[$4000], BANK[$1d]

	farptr ShowCharDataScreen ; $4000
	farptr PromptCharDataConfirm ; $4002
	farptr ShowExpDistributionScreen ; $4004
	farptr RunExpDistributionFlow ; $4006
	farptr ClearDrillResultBuffer ; $4008
	farptr RecordDrillResult ; $400a
	farptr InitCharDataScreenVideo ; $400c
	farptr DrawCharDataConfirmPrompt ; $400e
	farptr StartCharDataValuesSyncTask ; $4010
	farptr StopCharDataValuesSyncTask ; $4012
	farptr GrayscalePaletteColorInPlace ; $4014
ShowCharDataScreen:
	ld b, a ; $4016
	wram_bank $06 ; $4017
	ld a, b ; $401d
	ld [$d149], a ; $401e
	sound $04 ; $4021
	farcall RefreshMainCharacterStats ; $4023
	call EnableLCD ; $4026
	ld c, $7f ; $4029
	call BeginFadeOut ; $402b
	call WaitFadeEnd ; $402e
	call InitCharDataScreenVideo ; $4031
	ld hl, CharDataScreenPalettes ; $4034
	ld de, $0d01 ; $4037
	call LoadPaletteShadow ; $403a
	wram_bank $01 ; $403d
	ld hl, CharDataScreenGfx14 ; $4043
	ld de, wDecompBuffer ; $4046
	call DecompressData ; $4049
	ld hl, wDecompBuffer ; $404c
	ld de, $8600 + VRAM_BANK1 ; $404f
	ld c, $14 ; $4052
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
	wram_bank $06 ; $40d0
	xor a ; $40d6
	ld [$d000], a ; $40d7
	ld [$d001], a ; $40da
	ld [$d002], a ; $40dd
	ld [$d142], a ; $40e0
	ld [$d143], a ; $40e3
	ld [$d144], a ; $40e6
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
	ld bc, $d390 ; $414c
	call ApplyTilemapPatchList ; $414f
	wram_bank $03 ; $4152
	ld hl, wShadowTilemap ; $4158
	ld de, $9800 ; $415b
	ld c, $24 ; $415e
	call QueueVRAMCopy ; $4160
	wram_bank $02 ; $4163
	ld hl, $d000 ; $4169
	ld de, $9800 + VRAM_BANK1 ; $416c
	ld c, $24 ; $416f
	call QueueVRAMCopy ; $4171
	ret ; $4174
LoadCharDataScreenPageGraphics:
	wram_bank $01 ; $4175
	ld hl, CharDataScreenPageGfx14 ; $417b
	ld de, wDecompBuffer ; $417e
	call DecompressData ; $4181
	ld hl, wDecompBuffer ; $4184
	ld de, $8140 + VRAM_BANK1 ; $4187
	ld c, $0a ; $418a
	call QueueVRAMCopy ; $418c
	wram_bank $01 ; $418f
	ld hl, CharDataScreenPageGraphicsGfx0 ; $4195
	ld de, wDecompBuffer ; $4198
	call DecompressData ; $419b
	ld hl, wDecompBuffer ; $419e
	ld de, $81e0 + VRAM_BANK1 ; $41a1
	ld c, $0a ; $41a4
	call QueueVRAMCopy ; $41a6
	wram_bank $01 ; $41a9
	ld hl, CharDataScreenPageGraphicsGfx1 ; $41af
	ld de, wDecompBuffer ; $41b2
	call DecompressData ; $41b5
	ld hl, wDecompBuffer ; $41b8
	ld de, $8280 + VRAM_BANK1 ; $41bb
	ld c, $08 ; $41be
	call QueueVRAMCopy ; $41c0
	wram_bank $01 ; $41c3
	ld hl, CharDataScreenPageGraphicsGfx2 ; $41c9
	ld de, wDecompBuffer ; $41cc
	call DecompressData ; $41cf
	ld hl, wDecompBuffer ; $41d2
	ld de, $8300 + VRAM_BANK1 ; $41d5
	ld c, $08 ; $41d8
	call QueueVRAMCopy ; $41da
	wram_bank $01 ; $41dd
	ld hl, CharDataScreenPageGfx06 ; $41e3
	ld de, wDecompBuffer + 56 * TILE_SIZE ; $41e6
	call DecompressData ; $41e9
	ld hl, wDecompBuffer + 56 * TILE_SIZE ; $41ec
	ld bc, $0009 ; $41ef
	call CopyWram1ToWram3CharData ; $41f2
	wram_bank $01 ; $41f5
	ld hl, CharDataScreenPageGfx07 ; $41fb
	ld de, wDecompBuffer + 56 * TILE_SIZE ; $41fe
	call DecompressData ; $4201
	ld hl, wDecompBuffer + 56 * TILE_SIZE ; $4204
	ld bc, $0009 ; $4207
	call CopyWram1ToWram2CharData ; $420a
	wram_bank $01 ; $420d
	ld hl, CharDataScreenPageGfx00 ; $4213
	ld de, wDecompBuffer + 57 * TILE_SIZE ; $4216
	call DecompressData ; $4219
	ld hl, wDecompBuffer + 57 * TILE_SIZE ; $421c
	ld bc, $0028 ; $421f
	call CopyWram1ToWram3CharData ; $4222
	wram_bank $01 ; $4225
	ld hl, CharDataScreenPageGfx01 ; $422b
	ld de, wDecompBuffer + 57 * TILE_SIZE ; $422e
	call DecompressData ; $4231
	ld hl, wDecompBuffer + 57 * TILE_SIZE ; $4234
	ld bc, $0028 ; $4237
	call CopyWram1ToWram2CharData ; $423a
	wram_bank $01 ; $423d
	ld hl, CharDataScreenPageGfx02 ; $4243
	ld de, wDecompBuffer + 60 * TILE_SIZE ; $4246
	call DecompressData ; $4249
	ld hl, wDecompBuffer + 60 * TILE_SIZE ; $424c
	ld bc, $0082 ; $424f
	call CopyWram1ToWram3CharData ; $4252
	wram_bank $01 ; $4255
	ld hl, CharDataScreenPageGfx03 ; $425b
	ld de, wDecompBuffer + 60 * TILE_SIZE ; $425e
	call DecompressData ; $4261
	ld hl, wDecompBuffer + 60 * TILE_SIZE ; $4264
	ld bc, $0082 ; $4267
	call CopyWram1ToWram2CharData ; $426a
	wram_bank $01 ; $426d
	ld hl, CharDataScreenPageGfx02 ; $4273
	ld de, wDecompBuffer + 69 * TILE_SIZE ; $4276
	call DecompressData ; $4279
	ld hl, wDecompBuffer + 69 * TILE_SIZE ; $427c
	ld bc, $0082 ; $427f
	call CopyWram1ToWram3CharData ; $4282
	wram_bank $01 ; $4285
	ld hl, CharDataScreenPageGfx03 ; $428b
	ld de, wDecompBuffer + 69 * TILE_SIZE ; $428e
	call DecompressData ; $4291
	ld hl, wDecompBuffer + 69 * TILE_SIZE ; $4294
	ld bc, $0082 ; $4297
	call CopyWram1ToWram2CharData ; $429a
	wram_bank $01 ; $429d
	ld hl, CharDataScreenPageGfx04 ; $42a3
	ld de, wDecompBuffer + 78 * TILE_SIZE ; $42a6
	call DecompressData ; $42a9
	ld hl, wDecompBuffer + 78 * TILE_SIZE ; $42ac
	ld bc, $001c ; $42af
	call CopyWram1ToWram3CharData ; $42b2
	wram_bank $01 ; $42b5
	ld hl, CharDataScreenPageGfx05 ; $42bb
	ld de, wDecompBuffer + 78 * TILE_SIZE ; $42be
	call DecompressData ; $42c1
	ld hl, wDecompBuffer + 78 * TILE_SIZE ; $42c4
	ld bc, $001c ; $42c7
	call CopyWram1ToWram2CharData ; $42ca
	wram_bank $01 ; $42cd
	ld hl, CharDataScreenPageGfx08 ; $42d3
	ld de, wDecompBuffer + 80 * TILE_SIZE ; $42d6
	call DecompressData ; $42d9
	ld hl, wDecompBuffer + 80 * TILE_SIZE ; $42dc
	ld bc, $002a ; $42df
	call CopyWram1ToWram3CharData ; $42e2
	wram_bank $01 ; $42e5
	ld hl, CharDataScreenPageGfx09 ; $42eb
	ld de, wDecompBuffer + 80 * TILE_SIZE ; $42ee
	call DecompressData ; $42f1
	ld hl, wDecompBuffer + 80 * TILE_SIZE ; $42f4
	ld bc, $002a ; $42f7
	call CopyWram1ToWram2CharData ; $42fa
	wram_bank $01 ; $42fd
	ld hl, CharDataScreenPageGfx10 ; $4303
	ld de, wDecompBuffer ; $4306
	call DecompressData ; $4309
	ld hl, wDecompBuffer ; $430c
	ld de, $8380 + VRAM_BANK1 ; $430f
	ld c, $14 ; $4312
	call QueueVRAMCopy ; $4314
	ld hl, CharDataScreenPageGfx13 ; $4317
	ld de, wDecompBuffer ; $431a
	call DecompressData ; $431d
	ld hl, wDecompBuffer ; $4320
	ld de, $84c0 + VRAM_BANK1 ; $4323
	ld c, $14 ; $4326
	call QueueVRAMCopy ; $4328
	wram_bank $01 ; $432b
	ld hl, CharDataScreenPageGfx11 ; $4331
	ld de, wDecompBuffer + 83 * TILE_SIZE ; $4334
	call DecompressData ; $4337
	ld hl, wDecompBuffer + 83 * TILE_SIZE ; $433a
	ld bc, $001e ; $433d
	call CopyWram1ToWram3CharData ; $4340
	wram_bank $01 ; $4343
	ld hl, CharDataScreenPageGfx12 ; $4349
	ld de, wDecompBuffer + 83 * TILE_SIZE ; $434c
	call DecompressData ; $434f
	ld hl, wDecompBuffer + 83 * TILE_SIZE ; $4352
	ld bc, $001e ; $4355
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
	ld de, $0401 ; $4375
	farcall LoadIndexedPaletteThunk ; $4378
	wram_bank $01 ; $437b
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
	ld de, $9200 + VRAM_BANK1 ; $43a0
	ld c, $03 ; $43a3
	call QueueVRAMCopy ; $43a5
	ld hl, wDecompBuffer + 3 * TILE_SIZE ; $43a8
	ld de, $9300 + VRAM_BANK1 ; $43ab
	ld c, $03 ; $43ae
	call QueueVRAMCopy ; $43b0
	ld hl, wDecompBuffer + 6 * TILE_SIZE ; $43b3
	ld de, $9400 + VRAM_BANK1 ; $43b6
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
	ld de, $0101 ; $43d9
	farcall LoadIndexedPaletteThunk ; $43dc
	wram_bank $01 ; $43df
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
	ld de, $9230 + VRAM_BANK1 ; $4404
	ld c, $03 ; $4407
	call QueueVRAMCopy ; $4409
	ld hl, wDecompBuffer + 3 * TILE_SIZE ; $440c
	ld de, $9330 + VRAM_BANK1 ; $440f
	ld c, $03 ; $4412
	call QueueVRAMCopy ; $4414
	ld hl, wDecompBuffer + 6 * TILE_SIZE ; $4417
	ld de, $9430 + VRAM_BANK1 ; $441a
	ld c, $03 ; $441d
	call QueueVRAMCopy ; $441f
	ret ; $4422
CopyWram1ToWram3CharData:
	wram_bank $01 ; $4423
	ld d, [hl] ; $4429
	wram_bank $03 ; $442a
	ld [hl], d ; $4430
	inc hl ; $4431
	dec bc ; $4432
	ld a, b ; $4433
	or c ; $4434
	jr nz, CopyWram1ToWram3CharData ; $4435
	ret ; $4437
CopyWram1ToWram2CharData:
	wram_bank $01 ; $4438
	ld d, [hl] ; $443e
	wram_bank $02 ; $443f
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
	ld de, $d3cb ; $4466
	ld c, $0a ; $4469
	call WriteNameStringTiles ; $446b
	ld hl, CharDataSummaryFieldsTilePlot0 ; $446e
	ld de, $d3c0 ; $4471
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
	ld hl, $d3e3 ; $448f
	call DrawFourTileFlagLabel ; $4492
	wram_bank $06 ; $4495
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
	ld de, $d3db ; $44bc
	farcall CharDataScreen_WriteStatNumber ; $44bf
	wram_bank $06 ; $44c2
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
	ld de, $d3f9 ; $44e9
	farcall CharDataScreen_WriteStatNumber ; $44ec
	wram_bank $06 ; $44ef
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
	ld de, $d403 ; $4516
	farcall CharDataScreen_WriteStatNumber ; $4519
	wram_bank $06 ; $451c
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
	ld de, $d40d ; $4543
	farcall CharDataScreen_WriteStatNumber ; $4546
	wram_bank $06 ; $4549
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
	ld de, $d417 ; $4570
	farcall CharDataScreen_WriteStatNumber ; $4573
	call ComputeExpProgressBar ; $4576
	ld de, $d42f ; $4579
	call DrawExpProgressBarTiles ; $457c
	wram_bank $06 ; $457f
	xor a ; $4585
	farcall GetExpRemainingToNextLevel ; $4586
	ld a, $03 ; $4589
	ld de, wCharDataNumberBuffer ; $458b
	call FormatDecimalNumberUnsigned ; $458e
	ld hl, wCharDataNumberBuffer ; $4591
	ld de, $d12c ; $4594
	ld a, [hl+] ; $4597
	ld [de], a ; $4598
	inc de ; $4599
	ld a, [hl+] ; $459a
	ld [de], a ; $459b
	inc de ; $459c
	ld a, [hl] ; $459d
	ld [de], a ; $459e
	wram_bank $06 ; $459f
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
	ld de, $d126 ; $45c0
	ld a, [hl] ; $45c3
	or a ; $45c4
	jr nz, .nonZero ; $45c5
	ld bc, $0006 ; $45c7
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
	ld de, $d45b ; $45f5
	ld c, $0a ; $45f8
	call WriteNameStringTiles ; $45fa
	wram_bank $03 ; $45fd
	ld hl, CharDataSummaryFieldsTilePlot1 ; $4603
	ld de, wShadowAttrmap + 2 * TILEMAP_WIDTH + 16 ; $4606
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
	ld hl, wShadowAttrmap + 3 * TILEMAP_WIDTH + 19 ; $4624
	call DrawFourTileFlagLabel ; $4627
	wram_bank $06 ; $462a
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
	ld de, $d46b ; $4651
	farcall CharDataScreen_WriteStatNumber ; $4654
	wram_bank $06 ; $4657
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
	ld de, $d489 ; $467e
	farcall CharDataScreen_WriteStatNumber ; $4681
	wram_bank $06 ; $4684
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
	ld de, $d493 ; $46ab
	farcall CharDataScreen_WriteStatNumber ; $46ae
	wram_bank $06 ; $46b1
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
	ld de, $d49d ; $46d8
	farcall CharDataScreen_WriteStatNumber ; $46db
	wram_bank $06 ; $46de
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
	ld de, $d4a7 ; $4705
	farcall CharDataScreen_WriteStatNumber ; $4708
	call ComputeExpProgressBar ; $470b
	ld de, $d4bf ; $470e
	call DrawExpProgressBarTiles ; $4711
	wram_bank $06 ; $4714
	ld a, $01 ; $471a
	farcall GetExpRemainingToNextLevel ; $471c
	ld a, $03 ; $471f
	ld de, wCharDataNumberBuffer ; $4721
	call FormatDecimalNumberUnsigned ; $4724
	ld hl, wCharDataNumberBuffer ; $4727
	ld de, $d139 ; $472a
	ld a, [hl+] ; $472d
	ld [de], a ; $472e
	inc de ; $472f
	ld a, [hl+] ; $4730
	ld [de], a ; $4731
	inc de ; $4732
	ld a, [hl] ; $4733
	ld [de], a ; $4734
	wram_bank $06 ; $4735
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
	ld de, $d133 ; $4756
	ld a, [hl] ; $4759
	or a ; $475a
	jr nz, .nonZero2 ; $475b
	ld bc, $0006 ; $475d
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
PlotTilesAtOffsets:
	push de ; $4771
	ld a, [hl+] ; $4772
	cp $ff ; $4773
	jr z, .restore ; $4775
	add e ; $4777
	ld e, a ; $4778
	jr nc, .read ; $4779
	inc d ; $477b
.read:
	ld a, [hl+] ; $477c
	ld c, a ; $477d
	wram_bank $03 ; $477e
	ld a, c ; $4784
	ld [de], a ; $4785
	wram_bank $02 ; $4786
	ld a, b ; $478c
	ld [de], a ; $478d
	pop de ; $478e
	jr PlotTilesAtOffsets ; $478f
.restore:
	pop de ; $4791
	ret ; $4792
DrawFourTileFlagLabel:
	or a ; $4793
	jr nz, .nonZero ; $4794
	wram_bank $03 ; $4796
	ld a, $01 ; $479c
	jr .store ; $479e
.nonZero:
	wram_bank $03 ; $47a0
	ld a, $05 ; $47a6
.store:
	ld [hl+], a ; $47a8
	inc a ; $47a9
	ld [hl+], a ; $47aa
	inc a ; $47ab
	ld [hl+], a ; $47ac
	inc a ; $47ad
	ld [hl], a ; $47ae
	ret ; $47af
WriteNameStringTiles:
	ld a, [hl+] ; $47b0
	or a ; $47b1
	ret z ; $47b2
	cp $de ; $47b3
	jr z, .nameTilePtrUpOneRow ; $47b5
	cp $df ; $47b7
	jr z, .nameTilePtrUpOneRow ; $47b9
	ld b, a ; $47bb
	wram_bank $03 ; $47bc
	ld a, b ; $47c2
	ld [de], a ; $47c3
	wram_bank $02 ; $47c4
	xor a ; $47ca
	ld [de], a ; $47cb
	inc de ; $47cc
	jr WriteNameStringTiles ; $47cd
.nameTilePtrUpOneRow:
	call NameTilePtrUpOneRow ; $47cf
	ld b, a ; $47d2
	wram_bank $03 ; $47d3
	ld a, [de] ; $47d9
	or a ; $47da
	jr z, .zero ; $47db
	ld a, b ; $47dd
	sub $30 ; $47de
	ld [de], a ; $47e0
	wram_bank $02 ; $47e1
	ld a, $08 ; $47e7
	ld [de], a ; $47e9
	call NameTilePtrDownOneRow ; $47ea
	jr WriteNameStringTiles ; $47ed
.zero:
	ld a, b ; $47ef
	ld [de], a ; $47f0
	wram_bank $02 ; $47f1
	xor a ; $47f7
	ld [de], a ; $47f8
	call NameTilePtrDownOneRow ; $47f9
	jr WriteNameStringTiles ; $47fc
NameTilePtrUpOneRow:
	push bc ; $47fe
.loop:
	dec de ; $47ff
	dec c ; $4800
	jr nz, .loop ; $4801
	dec de ; $4803
	pop bc ; $4804
	ret ; $4805
NameTilePtrDownOneRow:
	ld a, c ; $4806
	inc a ; $4807
	add e ; $4808
	ld e, a ; $4809
	jr nc, .done ; $480a
	inc d ; $480c
.done:
	ret ; $480d
FormatExp24BitDecimal:
	wram_bank $06 ; $480e
	ld a, [hl+] ; $4814
	ld b, [hl] ; $4815
	ld c, a ; $4816
	inc hl ; $4817
	ld a, [hl] ; $4818
	ld [wCharDataNumberBuffer], a ; $4819
	ld h, b ; $481c
	ld l, c ; $481d
	ld de, wCharDataNumberBuffer + 1 ; $481e
	ld a, $05 ; $4821
	call FormatDecimalNumberUnsigned ; $4823
	ld hl, wCharDataNumberBuffer ; $4826
	ld a, [hl] ; $4829
	and a ; $482a
	ret z ; $482b
	ld c, a ; $482c
.loop:
	ld de, wCharDataNumberBuffer + 5 ; $482d
	ld a, [de] ; $4830
	sub $20 ; $4831
	jr z, .zero ; $4833
	sub $10 ; $4835
.zero:
	add $06 ; $4837
	cp $0a ; $4839
	jr c, .lt0a ; $483b
	sub $0a ; $483d
	ld b, a ; $483f
	ld a, $01 ; $4840
	ld [hl], a ; $4842
	ld a, b ; $4843
.lt0a:
	add $30 ; $4844
	ld [de], a ; $4846
	ld de, wCharDataNumberBuffer + 4 ; $4847
	ld a, [de] ; $484a
	add [hl] ; $484b
	ld b, a ; $484c
	xor a ; $484d
	ld [hl], a ; $484e
	ld a, b ; $484f
	sub $20 ; $4850
	jr z, .zero2 ; $4852
	sub $10 ; $4854
.zero2:
	add $03 ; $4856
	cp $0a ; $4858
	jr c, .lt0a2 ; $485a
	sub $0a ; $485c
	ld b, a ; $485e
	ld a, $01 ; $485f
	ld [hl], a ; $4861
	ld a, b ; $4862
.lt0a2:
	add $30 ; $4863
	ld [de], a ; $4865
	ld de, wCharDataNumberBuffer + 3 ; $4866
	ld a, [de] ; $4869
	add [hl] ; $486a
	ld b, a ; $486b
	xor a ; $486c
	ld [hl], a ; $486d
	ld a, b ; $486e
	sub $20 ; $486f
	jr z, .zero3 ; $4871
	sub $10 ; $4873
.zero3:
	add $05 ; $4875
	cp $0a ; $4877
	jr c, .lt0a3 ; $4879
	sub $0a ; $487b
	ld b, a ; $487d
	ld a, $01 ; $487e
	ld [hl], a ; $4880
	ld a, b ; $4881
.lt0a3:
	add $30 ; $4882
	ld [de], a ; $4884
	ld de, wCharDataNumberBuffer + 2 ; $4885
	ld a, [de] ; $4888
	add [hl] ; $4889
	ld b, a ; $488a
	xor a ; $488b
	ld [hl], a ; $488c
	ld a, b ; $488d
	sub $20 ; $488e
	jr z, .zero4 ; $4890
	sub $10 ; $4892
.zero4:
	add $05 ; $4894
	cp $0a ; $4896
	jr c, .lt0a4 ; $4898
	sub $0a ; $489a
	ld b, a ; $489c
	ld a, $01 ; $489d
	ld [hl], a ; $489f
	ld a, b ; $48a0
.lt0a4:
	add $30 ; $48a1
	ld [de], a ; $48a3
	ld de, wCharDataNumberBuffer + 1 ; $48a4
	ld a, [de] ; $48a7
	add [hl] ; $48a8
	ld b, a ; $48a9
	xor a ; $48aa
	ld [hl], a ; $48ab
	ld a, b ; $48ac
	sub $20 ; $48ad
	jr z, .zero5 ; $48af
	sub $10 ; $48b1
.zero5:
	add $05 ; $48b3
	ld hl, wCharDataNumberBuffer ; $48b5
	add [hl] ; $48b8
	cp $0a ; $48b9
	jr c, .lt0a5 ; $48bb
	ld a, $09 ; $48bd
.lt0a5:
	add $30 ; $48bf
	ld [de], a ; $48c1
	dec c ; $48c2
	jp nz, .loop ; $48c3
	ret ; $48c6
CharDataValuesSyncTask:
	wram_bank $06 ; $48c7
	ld a, [$d149] ; $48cd
	or a ; $48d0
	jr nz, .nonZero ; $48d1
	ld hl, wCharDataSyncValues ; $48d3
	jr .step2 ; $48d6
.nonZero:
	ld hl, wGameTimer + 2 ; $48d8
.step2:
	ld de, $d14c ; $48db
	ld a, [hl+] ; $48de
	ld [de], a ; $48df
	inc de ; $48e0
	ld a, [hl] ; $48e1
	ld [de], a ; $48e2
	ld a, [$d14d] ; $48e3
	ld h, $00 ; $48e6
	ld l, a ; $48e8
	ld a, $02 ; $48e9
	ld de, wCharDataNumberBuffer ; $48eb
	call FormatDecimalNumberUnsigned ; $48ee
	ld a, [wCharDataNumberBuffer] ; $48f1
	cp $20 ; $48f4
	jr z, .eq20 ; $48f6
	call GetCharDataDigitSprite ; $48f8
	ld de, $5d88 ; $48fb
	ld hl, wCharDataValuesSlideX ; $48fe
	call ApplySlideOffsetToSpriteX ; $4901
	call QueueSprite ; $4904
.eq20:
	ld a, [wCharDataNumberBuffer + 1] ; $4907
	call GetCharDataDigitSprite ; $490a
	ld de, $6588 ; $490d
	ld hl, wCharDataValuesSlideX ; $4910
	call ApplySlideOffsetToSpriteX ; $4913
	call QueueSprite ; $4916
	ld a, [$d14c] ; $4919
	ld h, $00 ; $491c
	ld l, a ; $491e
	ld a, $02 ; $491f
	ld de, wCharDataNumberBuffer ; $4921
	call FormatDecimalNumberUnsigned ; $4924
	ld a, [wCharDataNumberBuffer] ; $4927
	cp $20 ; $492a
	jr z, .eq202 ; $492c
	jr .getCharDataDigitSprite ; $492e
.eq202:
	ld a, $30 ; $4930
.getCharDataDigitSprite:
	call GetCharDataDigitSprite ; $4932
	ld de, $7488 ; $4935
	ld hl, wCharDataValuesSlideX ; $4938
	call ApplySlideOffsetToSpriteX ; $493b
	call QueueSprite ; $493e
	ld a, [wCharDataNumberBuffer + 1] ; $4941
	call GetCharDataDigitSprite ; $4944
	ld de, $7c88 ; $4947
	ld hl, wCharDataValuesSlideX ; $494a
	call ApplySlideOffsetToSpriteX ; $494d
	call QueueSprite ; $4950
	wram_bank $06 ; $4953
	ld a, [$d12c] ; $4959
	cp $20 ; $495c
	jr z, .eq203 ; $495e
	call GetSummaryExpDigitSprite ; $4960
	ld de, $0864 ; $4963
	ld hl, wCharDataValuesSlideX ; $4966
	call ApplySlideOffsetToSpriteX ; $4969
	call QueueSprite ; $496c
.eq203:
	ld a, [$d12d] ; $496f
	cp $20 ; $4972
	jr z, .eq204 ; $4974
	call GetSummaryExpDigitSprite ; $4976
	ld de, $0d64 ; $4979
	ld hl, wCharDataValuesSlideX ; $497c
	call ApplySlideOffsetToSpriteX ; $497f
	call QueueSprite ; $4982
.eq204:
	ld a, [$d12e] ; $4985
	cp $20 ; $4988
	jr z, .eq205 ; $498a
	call GetSummaryExpDigitSprite ; $498c
	ld de, $1264 ; $498f
	ld hl, wCharDataValuesSlideX ; $4992
	call ApplySlideOffsetToSpriteX ; $4995
	call QueueSprite ; $4998
.eq205:
	ld a, [$d139] ; $499b
	cp $20 ; $499e
	jr z, .eq206 ; $49a0
	call GetSummaryExpDigitSprite ; $49a2
	ld de, $5864 ; $49a5
	ld hl, wCharDataValuesSlideX ; $49a8
	call ApplySlideOffsetToSpriteX ; $49ab
	call QueueSprite ; $49ae
.eq206:
	ld a, [$d13a] ; $49b1
	cp $20 ; $49b4
	jr z, .eq207 ; $49b6
	call GetSummaryExpDigitSprite ; $49b8
	ld de, $5d64 ; $49bb
	ld hl, wCharDataValuesSlideX ; $49be
	call ApplySlideOffsetToSpriteX ; $49c1
	call QueueSprite ; $49c4
.eq207:
	ld a, [$d13b] ; $49c7
	cp $20 ; $49ca
	jr z, .checkEquippedRacket ; $49cc
	call GetSummaryExpDigitSprite ; $49ce
	ld de, $6264 ; $49d1
	ld hl, wCharDataValuesSlideX ; $49d4
	call ApplySlideOffsetToSpriteX ; $49d7
	call QueueSprite ; $49da
.checkEquippedRacket:
	ld a, [wEquippedRacket] ; $49dd
	push af ; $49e0
	and $0f ; $49e1
	jr z, .restore ; $49e3
	ld b, $0e ; $49e5
	ld c, $d6 ; $49e7
	ld de, $303c ; $49e9
	ld hl, wCharDataValuesSlideX ; $49ec
	call ApplySlideOffsetToSpriteX ; $49ef
	call QueueSprite ; $49f2
.restore:
	pop af ; $49f5
	and $f0 ; $49f6
	jr z, .done ; $49f8
	ld b, $0e ; $49fa
	ld c, $d8 ; $49fc
	ld de, $383c ; $49fe
	ld hl, wCharDataValuesSlideX ; $4a01
	call ApplySlideOffsetToSpriteX ; $4a04
	call QueueSprite ; $4a07
.done:
	ret ; $4a0a
GetSummaryExpDigitSprite:
	sub $30 ; $4a0b
	rlca ; $4a0d
	add $4c ; $4a0e
	ld c, a ; $4a10
	ld b, $08 ; $4a11
	ret ; $4a13
SaveWorkTilemapToPage:
	or a ; $4a14
	jr z, .page3 ; $4a15
	dec a ; $4a17
	jr z, .page2 ; $4a18
	dec a ; $4a1a
	jr z, .page1 ; $4a1b
	wram_bank $03 ; $4a1d
	ld hl, wShadowTilemap ; $4a23
	ld de, $dc60 ; $4a26
	ld c, $24 ; $4a29
	call CopyMemoryFast ; $4a2b
	wram_bank $02 ; $4a2e
	ld hl, $d000 ; $4a34
	ld de, $dc60 ; $4a37
	ld c, $24 ; $4a3a
	call CopyMemoryFast ; $4a3c
	ret ; $4a3f
.page1:
	wram_bank $03 ; $4a40
	ld hl, wShadowTilemap ; $4a46
	ld de, $da20 ; $4a49
	ld c, $24 ; $4a4c
	call CopyMemoryFast ; $4a4e
	wram_bank $02 ; $4a51
	ld hl, $d000 ; $4a57
	ld de, $da20 ; $4a5a
	ld c, $24 ; $4a5d
	call CopyMemoryFast ; $4a5f
	ret ; $4a62
.page2:
	wram_bank $03 ; $4a63
	ld hl, wShadowTilemap ; $4a69
	ld de, wShadowAttrmap + 31 * TILEMAP_WIDTH ; $4a6c
	ld c, $24 ; $4a6f
	call CopyMemoryFast ; $4a71
	wram_bank $02 ; $4a74
	ld hl, $d000 ; $4a7a
	ld de, $d7e0 ; $4a7d
	ld c, $24 ; $4a80
	call CopyMemoryFast ; $4a82
	ret ; $4a85
.page3:
	wram_bank $03 ; $4a86
	ld hl, wShadowTilemap ; $4a8c
	ld de, wShadowAttrmap + 13 * TILEMAP_WIDTH ; $4a8f
	ld c, $24 ; $4a92
	call CopyMemoryFast ; $4a94
	wram_bank $02 ; $4a97
	ld hl, $d000 ; $4a9d
	ld de, $d5a0 ; $4aa0
	ld c, $24 ; $4aa3
	call CopyMemoryFast ; $4aa5
	ret ; $4aa8
LoadBasePageIntoWorkTilemap:
	wram_bank $03 ; $4aa9
	ld hl, wShadowAttrmap + 13 * TILEMAP_WIDTH ; $4aaf
	ld de, wShadowTilemap ; $4ab2
	ld c, $24 ; $4ab5
	call CopyMemoryFast ; $4ab7
	wram_bank $02 ; $4aba
	ld hl, $d5a0 ; $4ac0
	ld de, $d000 ; $4ac3
	ld c, $24 ; $4ac6
	call CopyMemoryFast ; $4ac8
	ret ; $4acb
BuildCharDataSummaryPage:
	call BuildCharDataSummaryFields ; $4acc
	ld hl, CharDataSummaryPageTilemapPatch0 ; $4acf
	ld bc, $d3c0 ; $4ad2
	call ApplyTilemapPatchList ; $4ad5
	ld hl, CharDataSummaryPageTilemapPatch1 ; $4ad8
	ld bc, $d450 ; $4adb
	call ApplyTilemapPatchList ; $4ade
	ld hl, CharDataSummaryPageTilemapPatch2 ; $4ae1
	ld bc, $d4e0 ; $4ae4
	call ApplyTilemapPatchList ; $4ae7
	ret ; $4aea
BuildMainCharStatPage:
	xor a ; $4aeb
	ld [wStoryCharacterSlot], a ; $4aec
	call BuildCharStatDisplay ; $4aef
	wram_bank $06 ; $4af2
	ld a, [wCharDataLevels] ; $4af8
	ld [$d122], a ; $4afb
	ld a, [wCharDataLevels + 1] ; $4afe
	ld [$d123], a ; $4b01
	ld a, [wCharDataLevels + 2] ; $4b04
	ld [$d124], a ; $4b07
	ld a, [wCharDataLevels + 3] ; $4b0a
	ld [$d125], a ; $4b0d
	ld hl, MainCharStatPageTilemapPatch00 ; $4b10
	ld bc, $d370 ; $4b13
	call ApplyTilemapPatchList ; $4b16
	ld hl, MainCharStatPageTilemapPatch01 ; $4b19
	ld bc, $d500 ; $4b1c
	call ApplyTilemapPatchList ; $4b1f
	ld hl, StatPageTilemapPatch1 ; $4b22
	ld bc, $d240 ; $4b25
	call ApplyTilemapPatchList ; $4b28
	ld hl, StatPageTilemapPatch2 ; $4b2b
	ld bc, $d280 ; $4b2e
	call ApplyTilemapPatchList ; $4b31
	ld hl, StatPageTilemapPatch3 ; $4b34
	ld bc, $d2d0 ; $4b37
	call ApplyTilemapPatchList ; $4b3a
	ld hl, StatPageTilemapPatch4 ; $4b3d
	ld bc, $d310 ; $4b40
	call ApplyTilemapPatchList ; $4b43
	ld hl, StatPageTilemapPatch5 ; $4b46
	ld bc, $d530 ; $4b49
	call ApplyTilemapPatchList ; $4b4c
	ret ; $4b4f
BuildPartnerStatPage:
	ld a, $01 ; $4b50
	ld [wStoryCharacterSlot], a ; $4b52
	call BuildCharStatDisplay ; $4b55
	wram_bank $06 ; $4b58
	ld a, [wCharDataLevels] ; $4b5e
	ld [$d12f], a ; $4b61
	ld a, [wCharDataLevels + 1] ; $4b64
	ld [$d130], a ; $4b67
	ld a, [wCharDataLevels + 2] ; $4b6a
	ld [$d131], a ; $4b6d
	ld a, [wCharDataLevels + 3] ; $4b70
	ld [$d132], a ; $4b73
	ld hl, PartnerStatPageTilemapPatch01 ; $4b76
	ld bc, $d500 ; $4b79
	call ApplyTilemapPatchList ; $4b7c
	ld hl, PartnerStatPageTilemapPatch00 ; $4b7f
	ld bc, $d380 ; $4b82
	call ApplyTilemapPatchList ; $4b85
	ld hl, StatPageTilemapPatch1 ; $4b88
	ld bc, $d240 ; $4b8b
	call ApplyTilemapPatchList ; $4b8e
	ld hl, StatPageTilemapPatch2 ; $4b91
	ld bc, $d280 ; $4b94
	call ApplyTilemapPatchList ; $4b97
	ld hl, StatPageTilemapPatch3 ; $4b9a
	ld bc, $d2d0 ; $4b9d
	call ApplyTilemapPatchList ; $4ba0
	ld hl, StatPageTilemapPatch4 ; $4ba3
	ld bc, $d310 ; $4ba6
	call ApplyTilemapPatchList ; $4ba9
	ld hl, StatPageTilemapPatch5 ; $4bac
	ld bc, $d530 ; $4baf
	call ApplyTilemapPatchList ; $4bb2
	ret ; $4bb5
ApplyTilemapPatchList:
	ld a, [hl] ; $4bb6
	cp $ff ; $4bb7
	ret z ; $4bb9
	push hl ; $4bba
	ld d, [hl] ; $4bbb
	inc hl ; $4bbc
	ld e, [hl] ; $4bbd
	push hl ; $4bbe
	ld hl, $d000 ; $4bbf
	add hl, de ; $4bc2
	ld d, h ; $4bc3
	ld e, l ; $4bc4
	pop hl ; $4bc5
	inc hl ; $4bc6
	push hl ; $4bc7
	ld a, [hl] ; $4bc8
	ld h, b ; $4bc9
	ld l, c ; $4bca
	add l ; $4bcb
	ld l, a ; $4bcc
	jr nc, .gotSrc ; $4bcd
	inc h ; $4bcf
.gotSrc:
	wram_bank $06 ; $4bd0
	ld a, l ; $4bd6
	ld [wCharDataNumberBuffer], a ; $4bd7
	ld a, h ; $4bda
	ld [wCharDataNumberBuffer + 1], a ; $4bdb
	pop hl ; $4bde
	push bc ; $4bdf
	inc hl ; $4be0
	ld c, [hl] ; $4be1
	ld hl, wCharDataNumberBuffer ; $4be2
	ld a, [hl+] ; $4be5
	ld h, [hl] ; $4be6
	ld l, a ; $4be7
.copyLoop:
	wram_bank $03 ; $4be8
	ld a, [hl] ; $4bee
	ld [de], a ; $4bef
	wram_bank $02 ; $4bf0
	ld a, [hl+] ; $4bf6
	ld [de], a ; $4bf7
	inc de ; $4bf8
	dec c ; $4bf9
	jr nz, .copyLoop ; $4bfa
	pop bc ; $4bfc
	pop hl ; $4bfd
	inc hl ; $4bfe
	inc hl ; $4bff
	inc hl ; $4c00
	inc hl ; $4c01
	jr ApplyTilemapPatchList ; $4c02
DrawCharDataPageArrowsTask:
	wram_bank $06 ; $4c04
	ld a, [$d143] ; $4c0a
	or a ; $4c0d
	jr nz, .nonZero ; $4c0e
	ld hl, $d144 ; $4c10
	inc [hl] ; $4c13
.nonZero:
	ld a, [$d142] ; $4c14
	or a ; $4c17
	jr z, .zero ; $4c18
	dec a ; $4c1a
	jr z, .countDone ; $4c1b
	ld de, $0103 ; $4c1d
	call BobArrowSpriteLeft ; $4c20
	ld hl, SpriteTemplate_1d_679a ; $4c23
	ld b, $0e ; $4c26
	ld c, $28 ; $4c28
	call QueueSpriteTemplate ; $4c2a
	ret ; $4c2d
.countDone:
	ld de, $7f03 ; $4c2e
	call BobArrowSpriteRight ; $4c31
	ld hl, SpriteTemplate_1d_681b ; $4c34
	ld b, $0e ; $4c37
	ld c, $30 ; $4c39
	call QueueSpriteTemplate ; $4c3b
	ret ; $4c3e
.zero:
	ld de, $1010 ; $4c3f
	call BobArrowSpriteLeft ; $4c42
	ld hl, SpriteTemplate_1d_666a ; $4c45
	ld b, $0e ; $4c48
	ld c, $14 ; $4c4a
	call QueueSpriteTemplate ; $4c4c
	ld de, SpriteTemplate_1d_6810 ; $4c4f
	call BobArrowSpriteRight ; $4c52
	ld hl, SpriteTemplate_1d_670c ; $4c55
	ld b, $0e ; $4c58
	ld c, $1e ; $4c5a
	call QueueSpriteTemplate ; $4c5c
	ret ; $4c5f
BobArrowSpriteLeft:
	wram_bank $06 ; $4c60
	ld a, [$d144] ; $4c66
	rrca ; $4c69
	and $0f ; $4c6a
	add LOW(Data_1d_4c9c) ; $4c6c
	ld l, a ; $4c6e
	adc HIGH(Data_1d_4c9c) ; $4c6f
	sub l ; $4c71
	ld h, a ; $4c72
	ld a, [hl] ; $4c73
	cpl ; $4c74
	inc a ; $4c75
	add d ; $4c76
	ld d, a ; $4c77
	ld a, [$d143] ; $4c78
	cpl ; $4c7b
	inc a ; $4c7c
	add d ; $4c7d
	ld d, a ; $4c7e
	ret ; $4c7f
BobArrowSpriteRight:
	wram_bank $06 ; $4c80
	ld a, [$d144] ; $4c86
	rrca ; $4c89
	and $0f ; $4c8a
	add LOW(Data_1d_4c9c) ; $4c8c
	ld l, a ; $4c8e
	adc HIGH(Data_1d_4c9c) ; $4c8f
	sub l ; $4c91
	ld h, a ; $4c92
	ld a, [hl] ; $4c93
	add d ; $4c94
	ld d, a ; $4c95
	ld a, [$d143] ; $4c96
	add d ; $4c99
	ld d, a ; $4c9a
	ret ; $4c9b
Data_1d_4c9c:
	; $4c9c, 16 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $05, $06, $06, $06, $05, $04, $03, $02, $01, $00, $00 ; 0x00
RunDrillResultInputLoop:
	wram_bank $06 ; $4cac
	ld a, [$d142] ; $4cb2
	or a ; $4cb5
	jr z, .loop ; $4cb6
	dec a ; $4cb8
	jp z, .loopB ; $4cb9
	jp .loop2 ; $4cbc
.loop:
	call AdvanceFrame ; $4cbf
	ldh a, [hInputRisingEdge] ; $4cc2
	bit PADB_RIGHT, a ; $4cc4
	jr nz, .playSfx ; $4cc6
	bit 5, a ; $4cc8
	jp nz, .playSfx2 ; $4cca
	bit 1, a ; $4ccd
	jp nz, .playSfx3 ; $4ccf
	bit 0, a ; $4cd2
	jp nz, .playSfx4 ; $4cd4
	jr .loop ; $4cd7
.playSfx:
	sound $5e ; $4cd9
	ld hl, CharDataScreenBgScrollTask ; $4cdb
	call UnregisterFrameTask ; $4cde
	ld hl, SlideCharDataArrowsInTask ; $4ce1
	call UnregisterFrameTask ; $4ce4
	ld a, $01 ; $4ce7
	ld hl, SlideCharDataArrowsOutTask ; $4ce9
	call RegisterFrameTask ; $4cec
	ld a, $01 ; $4cef
	ld hl, DrawCharStatDigitsTask ; $4cf1
	call RegisterFrameTask ; $4cf4
	wram_bank $06 ; $4cf7
	ld a, [$d12f] ; $4cfd
	ld [wCharDataLevels], a ; $4d00
	ld a, [$d130] ; $4d03
	ld [wCharDataLevels + 1], a ; $4d06
	ld a, [$d131] ; $4d09
	ld [wCharDataLevels + 2], a ; $4d0c
	ld a, [$d132] ; $4d0f
	ld [wCharDataLevels + 3], a ; $4d12
	ld hl, $d133 ; $4d15
	ld de, $d13c ; $4d18
	ld bc, $0006 ; $4d1b
	call CopyMemoryBC ; $4d1e
	call SlideToPartnerStatPage ; $4d21
	wram_bank $06 ; $4d24
	ld a, $02 ; $4d2a
	ld [$d142], a ; $4d2c
	ld a, $01 ; $4d2f
	ld hl, SlideCharDataArrowsInTask ; $4d31
	call RegisterFrameTask ; $4d34
	jp .loop2 ; $4d37
.playSfx2:
	sound $5e ; $4d3a
	ld hl, CharDataScreenBgScrollTask ; $4d3c
	call UnregisterFrameTask ; $4d3f
	ld hl, SlideCharDataArrowsInTask ; $4d42
	call UnregisterFrameTask ; $4d45
	ld a, $01 ; $4d48
	ld hl, SlideCharDataArrowsOutTask ; $4d4a
	call RegisterFrameTask ; $4d4d
	ld a, $01 ; $4d50
	ld hl, DrawCharStatDigitsTask ; $4d52
	call RegisterFrameTask ; $4d55
	wram_bank $06 ; $4d58
	ld a, [$d122] ; $4d5e
	ld [wCharDataLevels], a ; $4d61
	ld a, [$d123] ; $4d64
	ld [wCharDataLevels + 1], a ; $4d67
	ld a, [$d124] ; $4d6a
	ld [wCharDataLevels + 2], a ; $4d6d
	ld a, [$d125] ; $4d70
	ld [wCharDataLevels + 3], a ; $4d73
	ld hl, $d126 ; $4d76
	ld de, $d13c ; $4d79
	ld bc, $0006 ; $4d7c
	call CopyMemoryBC ; $4d7f
	call SlideToMainCharStatPage ; $4d82
	wram_bank $06 ; $4d85
	ld a, $01 ; $4d8b
	ld [$d142], a ; $4d8d
	ld a, $01 ; $4d90
	ld hl, SlideCharDataArrowsInTask ; $4d92
	call RegisterFrameTask ; $4d95
	jr .loopB ; $4d98
.playSfx3:
	sound $62 ; $4d9a
	ret ; $4d9c
.playSfx4:
	sound $5f ; $4d9d
	ret ; $4d9f
.loopB:
	call AdvanceFrame ; $4da0
	ldh a, [hInputRisingEdge] ; $4da3
	bit PADB_RIGHT, a ; $4da5
	jr nz, .playSfx5 ; $4da7
	bit 1, a ; $4da9
	jr nz, .playSfx6 ; $4dab
	bit 0, a ; $4dad
	jr nz, .playSfx7 ; $4daf
	jr .loopB ; $4db1
.playSfx5:
	sound $5e ; $4db3
	ld hl, SlideCharDataArrowsInTask ; $4db5
	call UnregisterFrameTask ; $4db8
	ld a, $01 ; $4dbb
	ld hl, SlideCharDataArrowsOutTask ; $4dbd
	call RegisterFrameTask ; $4dc0
	call SlideFromMainCharStatPage ; $4dc3
	wram_bank $06 ; $4dc6
	xor a ; $4dcc
	ld [$d142], a ; $4dcd
	call ClearFrameTasks ; $4dd0
	ld a, $01 ; $4dd3
	ld hl, CharDataScreenBgScrollTask ; $4dd5
	call RegisterFrameTask ; $4dd8
	ld a, $01 ; $4ddb
	ld hl, SlideCharDataArrowsInTask ; $4ddd
	call RegisterFrameTask ; $4de0
	ld a, $01 ; $4de3
	ld hl, DrawCharDataPageArrowsTask ; $4de5
	call RegisterFrameTask ; $4de8
	ld a, $01 ; $4deb
	ld hl, CharDataValuesSyncTask ; $4ded
	call RegisterFrameTask ; $4df0
	farcall StartCharDataScreenAnimTask ; $4df3
	jp .loop ; $4df6
.playSfx6:
	sound $62 ; $4df9
	ret ; $4dfb
.playSfx7:
	sound $5f ; $4dfc
	ret ; $4dfe
.loop2:
	call AdvanceFrame ; $4dff
	ldh a, [hInputRisingEdge] ; $4e02
	bit PADB_LEFT, a ; $4e04
	jr nz, .playSfx8 ; $4e06
	bit 1, a ; $4e08
	jr nz, .playSfx9 ; $4e0a
	bit 0, a ; $4e0c
	jr nz, .playSfx10 ; $4e0e
	jr .loop2 ; $4e10
.playSfx8:
	sound $5e ; $4e12
	ld hl, SlideCharDataArrowsInTask ; $4e14
	call UnregisterFrameTask ; $4e17
	ld a, $01 ; $4e1a
	ld hl, SlideCharDataArrowsOutTask ; $4e1c
	call RegisterFrameTask ; $4e1f
	call SlideFromPartnerStatPage ; $4e22
	wram_bank $06 ; $4e25
	xor a ; $4e2b
	ld [$d142], a ; $4e2c
	call ClearFrameTasks ; $4e2f
	ld a, $01 ; $4e32
	ld hl, CharDataScreenBgScrollTask ; $4e34
	call RegisterFrameTask ; $4e37
	ld a, $01 ; $4e3a
	ld hl, SlideCharDataArrowsInTask ; $4e3c
	call RegisterFrameTask ; $4e3f
	ld a, $01 ; $4e42
	ld hl, DrawCharDataPageArrowsTask ; $4e44
	call RegisterFrameTask ; $4e47
	ld a, $01 ; $4e4a
	ld hl, CharDataValuesSyncTask ; $4e4c
	call RegisterFrameTask ; $4e4f
	farcall StartCharDataScreenAnimTask ; $4e52
	jp .loop ; $4e55
.playSfx9:
	sound $62 ; $4e58
	ret ; $4e5a
.playSfx10:
	sound $5f ; $4e5b
	ret ; $4e5d
SlideCharDataArrowsOutTask:
	wram_bank $06 ; $4e5e
	ld a, [$d143] ; $4e64
	add $04 ; $4e67
	ld [$d143], a ; $4e69
	cp $40 ; $4e6c
	ret c ; $4e6e
	ld hl, SlideCharDataArrowsOutTask ; $4e6f
	call UnregisterFrameTask ; $4e72
	ret ; $4e75
SlideCharDataArrowsInTask:
	wram_bank $06 ; $4e76
	ld a, [$d143] ; $4e7c
	sub $08 ; $4e7f
	ld [$d143], a ; $4e81
	or a ; $4e84
	ret nz ; $4e85
	ld hl, SlideCharDataArrowsInTask ; $4e86
	call UnregisterFrameTask ; $4e89
	ret ; $4e8c
BuildCharStatDisplay:
	wram_bank $06 ; $4e8d
	push af ; $4e93
	ld hl, wStoryModeNameOfMainCharacter ; $4e94
	ld a, [wStoryCharacterSlot] ; $4e97
	or a ; $4e9a
	jr z, .zero ; $4e9b
	ld l, $40 ; $4e9d
.zero:
	ld a, l ; $4e9f
	add $38 ; $4ea0
	ld l, a ; $4ea2
	ld a, h ; $4ea3
	adc $00 ; $4ea4
	ld h, a ; $4ea6
	pop af ; $4ea7
	ld a, [hl] ; $4ea8
	ld [wCharDataLevels], a ; $4ea9
	push af ; $4eac
	ld hl, wStoryModeNameOfMainCharacter ; $4ead
	ld a, [wStoryCharacterSlot] ; $4eb0
	or a ; $4eb3
	jr z, .zero2 ; $4eb4
	ld l, $40 ; $4eb6
.zero2:
	ld a, l ; $4eb8
	add $20 ; $4eb9
	ld l, a ; $4ebb
	ld a, h ; $4ebc
	adc $00 ; $4ebd
	ld h, a ; $4ebf
	pop af ; $4ec0
	ld a, [hl] ; $4ec1
	inc a ; $4ec2
	ld [wCharDataStats], a ; $4ec3
	push af ; $4ec6
	ld hl, wStoryModeNameOfMainCharacter ; $4ec7
	ld a, [wStoryCharacterSlot] ; $4eca
	or a ; $4ecd
	jr z, .zero3 ; $4ece
	ld l, $40 ; $4ed0
.zero3:
	ld a, l ; $4ed2
	add $21 ; $4ed3
	ld l, a ; $4ed5
	ld a, h ; $4ed6
	adc $00 ; $4ed7
	ld h, a ; $4ed9
	pop af ; $4eda
	ld a, [hl] ; $4edb
	inc a ; $4edc
	ld [wCharDataStats + 1], a ; $4edd
	push af ; $4ee0
	ld hl, wStoryModeNameOfMainCharacter ; $4ee1
	ld a, [wStoryCharacterSlot] ; $4ee4
	or a ; $4ee7
	jr z, .zero4 ; $4ee8
	ld l, $40 ; $4eea
.zero4:
	ld a, l ; $4eec
	add $39 ; $4eed
	ld l, a ; $4eef
	ld a, h ; $4ef0
	adc $00 ; $4ef1
	ld h, a ; $4ef3
	pop af ; $4ef4
	ld a, [hl] ; $4ef5
	ld [wCharDataLevels + 1], a ; $4ef6
	push af ; $4ef9
	ld hl, wStoryModeNameOfMainCharacter ; $4efa
	ld a, [wStoryCharacterSlot] ; $4efd
	or a ; $4f00
	jr z, .zero5 ; $4f01
	ld l, $40 ; $4f03
.zero5:
	ld a, l ; $4f05
	add $22 ; $4f06
	ld l, a ; $4f08
	ld a, h ; $4f09
	adc $00 ; $4f0a
	ld h, a ; $4f0c
	pop af ; $4f0d
	ld a, [hl] ; $4f0e
	inc a ; $4f0f
	ld [wCharDataStats + 2], a ; $4f10
	push af ; $4f13
	ld hl, wStoryModeNameOfMainCharacter ; $4f14
	ld a, [wStoryCharacterSlot] ; $4f17
	or a ; $4f1a
	jr z, .zero6 ; $4f1b
	ld l, $40 ; $4f1d
.zero6:
	ld a, l ; $4f1f
	add $23 ; $4f20
	ld l, a ; $4f22
	ld a, h ; $4f23
	adc $00 ; $4f24
	ld h, a ; $4f26
	pop af ; $4f27
	ld a, [hl] ; $4f28
	inc a ; $4f29
	ld [wCharDataStats + 3], a ; $4f2a
	push af ; $4f2d
	ld hl, wStoryModeNameOfMainCharacter ; $4f2e
	ld a, [wStoryCharacterSlot] ; $4f31
	or a ; $4f34
	jr z, .zero7 ; $4f35
	ld l, $40 ; $4f37
.zero7:
	ld a, l ; $4f39
	add $24 ; $4f3a
	ld l, a ; $4f3c
	ld a, h ; $4f3d
	adc $00 ; $4f3e
	ld h, a ; $4f40
	pop af ; $4f41
	ld a, [hl] ; $4f42
	inc a ; $4f43
	ld [wCharDataStats + 4], a ; $4f44
	push af ; $4f47
	ld hl, wStoryModeNameOfMainCharacter ; $4f48
	ld a, [wStoryCharacterSlot] ; $4f4b
	or a ; $4f4e
	jr z, .zero8 ; $4f4f
	ld l, $40 ; $4f51
.zero8:
	ld a, l ; $4f53
	add $3a ; $4f54
	ld l, a ; $4f56
	ld a, h ; $4f57
	adc $00 ; $4f58
	ld h, a ; $4f5a
	pop af ; $4f5b
	ld a, [hl] ; $4f5c
	ld [wCharDataLevels + 2], a ; $4f5d
	push af ; $4f60
	ld hl, wStoryModeNameOfMainCharacter ; $4f61
	ld a, [wStoryCharacterSlot] ; $4f64
	or a ; $4f67
	jr z, .zero9 ; $4f68
	ld l, $40 ; $4f6a
.zero9:
	ld a, l ; $4f6c
	add $25 ; $4f6d
	ld l, a ; $4f6f
	ld a, h ; $4f70
	adc $00 ; $4f71
	ld h, a ; $4f73
	pop af ; $4f74
	ld a, [hl] ; $4f75
	inc a ; $4f76
	ld [wCharDataStats + 5], a ; $4f77
	push af ; $4f7a
	ld hl, wStoryModeNameOfMainCharacter ; $4f7b
	ld a, [wStoryCharacterSlot] ; $4f7e
	or a ; $4f81
	jr z, .zero10 ; $4f82
	ld l, $40 ; $4f84
.zero10:
	ld a, l ; $4f86
	add $26 ; $4f87
	ld l, a ; $4f89
	ld a, h ; $4f8a
	adc $00 ; $4f8b
	ld h, a ; $4f8d
	pop af ; $4f8e
	ld a, [hl] ; $4f8f
	inc a ; $4f90
	ld [wCharDataStats + 6], a ; $4f91
	push af ; $4f94
	ld hl, wStoryModeNameOfMainCharacter ; $4f95
	ld a, [wStoryCharacterSlot] ; $4f98
	or a ; $4f9b
	jr z, .zero11 ; $4f9c
	ld l, $40 ; $4f9e
.zero11:
	ld a, l ; $4fa0
	add $3b ; $4fa1
	ld l, a ; $4fa3
	ld a, h ; $4fa4
	adc $00 ; $4fa5
	ld h, a ; $4fa7
	pop af ; $4fa8
	ld a, [hl] ; $4fa9
	ld [wCharDataLevels + 3], a ; $4faa
	push af ; $4fad
	ld hl, wStoryModeNameOfMainCharacter ; $4fae
	ld a, [wStoryCharacterSlot] ; $4fb1
	or a ; $4fb4
	jr z, .zero12 ; $4fb5
	ld l, $40 ; $4fb7
.zero12:
	ld a, l ; $4fb9
	add $27 ; $4fba
	ld l, a ; $4fbc
	ld a, h ; $4fbd
	adc $00 ; $4fbe
	ld h, a ; $4fc0
	pop af ; $4fc1
	ld a, [hl] ; $4fc2
	inc a ; $4fc3
	ld [wCharDataStats + 7], a ; $4fc4
	push af ; $4fc7
	ld hl, wStoryModeNameOfMainCharacter ; $4fc8
	ld a, [wStoryCharacterSlot] ; $4fcb
	or a ; $4fce
	jr z, .zero13 ; $4fcf
	ld l, $40 ; $4fd1
.zero13:
	ld a, l ; $4fd3
	add $28 ; $4fd4
	ld l, a ; $4fd6
	ld a, h ; $4fd7
	adc $00 ; $4fd8
	ld h, a ; $4fda
	pop af ; $4fdb
	ld a, [hl] ; $4fdc
	inc a ; $4fdd
	ld [wCharDataStats + 8], a ; $4fde
	push af ; $4fe1
	ld hl, wStoryModeNameOfMainCharacter ; $4fe2
	ld a, [wStoryCharacterSlot] ; $4fe5
	or a ; $4fe8
	jr z, .zero14 ; $4fe9
	ld l, $40 ; $4feb
.zero14:
	ld a, l ; $4fed
	add $29 ; $4fee
	ld l, a ; $4ff0
	ld a, h ; $4ff1
	adc $00 ; $4ff2
	ld h, a ; $4ff4
	pop af ; $4ff5
	ld a, [hl] ; $4ff6
	inc a ; $4ff7
	ld [wCharDataStats + 9], a ; $4ff8
	push af ; $4ffb
	ld hl, wStoryModeNameOfMainCharacter ; $4ffc
	ld a, [wStoryCharacterSlot] ; $4fff
	or a ; $5002
	jr z, .zero15 ; $5003
	ld l, $40 ; $5005
.zero15:
	ld a, l ; $5007
	add $2a ; $5008
	ld l, a ; $500a
	ld a, h ; $500b
	adc $00 ; $500c
	ld h, a ; $500e
	pop af ; $500f
	ld a, [hl] ; $5010
	inc a ; $5011
	ld [wCharDataStats + 10], a ; $5012
	farcall CharDataScreen_DrawStats ; $5015
	wram_bank $03 ; $5018
	ld hl, wShadowAttrmap + 8 * TILEMAP_WIDTH + 1 ; $501e
	ld a, $a3 ; $5021
	ld [hl+], a ; $5023
	ld [hl+], a ; $5024
	ld [hl+], a ; $5025
	ld [hl+], a ; $5026
	ld [hl+], a ; $5027
	ld [hl+], a ; $5028
	ld [hl], a ; $5029
	ld hl, wShadowAttrmap + 8 * TILEMAP_WIDTH + 15 ; $502a
	xor a ; $502d
	ld [hl+], a ; $502e
	ld [hl+], a ; $502f
	ld [hl+], a ; $5030
	ld [hl+], a ; $5031
	ld [hl+], a ; $5032
	ld [hl+], a ; $5033
	ld [hl], a ; $5034
	wram_bank $02 ; $5035
	ld hl, $d501 ; $503b
	ld a, $08 ; $503e
	ld [hl+], a ; $5040
	ld [hl+], a ; $5041
	ld [hl+], a ; $5042
	ld [hl+], a ; $5043
	ld [hl+], a ; $5044
	ld [hl+], a ; $5045
	ld [hl], a ; $5046
	ld hl, $d50f ; $5047
	ld [hl+], a ; $504a
	ld [hl+], a ; $504b
	ld [hl+], a ; $504c
	ld [hl+], a ; $504d
	ld [hl+], a ; $504e
	ld [hl+], a ; $504f
	ld [hl], a ; $5050
	push af ; $5051
	ld hl, wStoryModeNameOfMainCharacter ; $5052
	ld a, [wStoryCharacterSlot] ; $5055
	or a ; $5058
	jr z, .zero16 ; $5059
	ld l, $40 ; $505b
.zero16:
	ld a, l ; $505d
	add $00 ; $505e
	ld l, a ; $5060
	ld a, h ; $5061
	adc $00 ; $5062
	ld h, a ; $5064
	pop af ; $5065
	ld de, $d50f ; $5066
	ld c, $0e ; $5069
	call WriteNameStringTiles ; $506b
	wram_bank $06 ; $506e
	push af ; $5074
	ld hl, wStoryModeNameOfMainCharacter ; $5075
	ld a, [wStoryCharacterSlot] ; $5078
	or a ; $507b
	jr z, .zero17 ; $507c
	ld l, $40 ; $507e
.zero17:
	ld a, l ; $5080
	add $18 ; $5081
	ld l, a ; $5083
	ld a, h ; $5084
	adc $00 ; $5085
	ld h, a ; $5087
	pop af ; $5088
	ld a, [hl] ; $5089
	ld h, $00 ; $508a
	ld l, a ; $508c
	ld a, $02 ; $508d
	ld de, wCharDataNumberBuffer ; $508f
	call FormatDecimalNumberUnsigned ; $5092
	ld de, $d519 ; $5095
	farcall CharDataScreen_WriteStatNumber ; $5098
	ret ; $509b
SlideToMainCharStatPage:
	call AdvanceFrame ; $509c
	ld a, [$d002] ; $509f
	or a ; $50a2
	jr nz, SlideToMainCharStatPage ; $50a3
	call LoadBasePageIntoWorkTilemap ; $50a5
	ld hl, MainCharStatPageTilemapPatch02 ; $50a8
	ld bc, $d7e0 ; $50ab
	call ApplyTilemapPatchList ; $50ae
	ld hl, MainCharStatPageTilemapPatch03 ; $50b1
	ld bc, $d8e0 ; $50b4
	call ApplyTilemapPatchList ; $50b7
	ld hl, MainCharStatPageTilemapPatch04 ; $50ba
	ld bc, $d9e0 ; $50bd
	call ApplyTilemapPatchList ; $50c0
	ld hl, DrillDisplayData_1d ; $50c3
	ld bc, $d390 ; $50c6
	call ApplyTilemapPatchList ; $50c9
	farcall FlushCharDataTilemapsFar ; $50cc
	wram_bank $06 ; $50cf
	ld hl, wCharDataValuesSlideX ; $50d5
	ld de, $0020 ; $50d8
	ld a, e ; $50db
	ld [hl+], a ; $50dc
	ld [hl], d ; $50dd
	call LoadBasePageIntoWorkTilemap ; $50de
	ld hl, MainCharStatPageTilemapPatch05 ; $50e1
	ld bc, $d7e0 ; $50e4
	call ApplyTilemapPatchList ; $50e7
	ld hl, MainCharStatPageTilemapPatch06 ; $50ea
	ld bc, $d8e0 ; $50ed
	call ApplyTilemapPatchList ; $50f0
	ld hl, MainCharStatPageTilemapPatch07 ; $50f3
	ld bc, $d9e0 ; $50f6
	call ApplyTilemapPatchList ; $50f9
	ld hl, StatPageTilemapPatch0 ; $50fc
	ld bc, $d390 ; $50ff
	call ApplyTilemapPatchList ; $5102
	farcall FlushCharDataTilemapsFar ; $5105
	wram_bank $06 ; $5108
	ld hl, wCharDataStatsSlideX ; $510e
	ld de, $ff60 ; $5111
	ld a, e ; $5114
	ld [hl+], a ; $5115
	ld [hl], d ; $5116
	ld hl, wCharDataValuesSlideX ; $5117
	ld de, $0040 ; $511a
	ld a, e ; $511d
	ld [hl+], a ; $511e
	ld [hl], d ; $511f
	call LoadBasePageIntoWorkTilemap ; $5120
	ld hl, MainCharStatPageTilemapPatch08 ; $5123
	ld bc, $d7e0 ; $5126
	call ApplyTilemapPatchList ; $5129
	ld hl, MainCharStatPageTilemapPatch09 ; $512c
	ld bc, $d8e0 ; $512f
	call ApplyTilemapPatchList ; $5132
	ld hl, MainCharStatPageTilemapPatch10 ; $5135
	ld bc, $d9e0 ; $5138
	call ApplyTilemapPatchList ; $513b
	ld hl, MainCharStatPageTilemapPatch26 ; $513e
	ld bc, $da20 ; $5141
	call ApplyTilemapPatchList ; $5144
	ld hl, MainCharStatPageTilemapPatch27 ; $5147
	ld bc, $db20 ; $514a
	call ApplyTilemapPatchList ; $514d
	ld hl, MainCharStatPageTilemapPatch28 ; $5150
	ld bc, $dc20 ; $5153
	call ApplyTilemapPatchList ; $5156
	farcall FlushCharDataTilemapsFar ; $5159
	wram_bank $06 ; $515c
	ld hl, wCharDataStatsSlideX ; $5162
	ld de, $ff80 ; $5165
	ld a, e ; $5168
	ld [hl+], a ; $5169
	ld [hl], d ; $516a
	ld hl, wCharDataValuesSlideX ; $516b
	ld de, $0060 ; $516e
	ld a, e ; $5171
	ld [hl+], a ; $5172
	ld [hl], d ; $5173
	call LoadBasePageIntoWorkTilemap ; $5174
	ld hl, MainCharStatPageTilemapPatch11 ; $5177
	ld bc, $d7e0 ; $517a
	call ApplyTilemapPatchList ; $517d
	ld hl, MainCharStatPageTilemapPatch12 ; $5180
	ld bc, $d8e0 ; $5183
	call ApplyTilemapPatchList ; $5186
	ld hl, MainCharStatPageTilemapPatch13 ; $5189
	ld bc, $d9e0 ; $518c
	call ApplyTilemapPatchList ; $518f
	ld hl, MainCharStatPageTilemapPatch23 ; $5192
	ld bc, $da20 ; $5195
	call ApplyTilemapPatchList ; $5198
	ld hl, MainCharStatPageTilemapPatch24 ; $519b
	ld bc, $db20 ; $519e
	call ApplyTilemapPatchList ; $51a1
	ld hl, MainCharStatPageTilemapPatch25 ; $51a4
	ld bc, $dc20 ; $51a7
	call ApplyTilemapPatchList ; $51aa
	farcall FlushCharDataTilemapsFar ; $51ad
	wram_bank $06 ; $51b0
	ld hl, wCharDataStatsSlideX ; $51b6
	ld de, $ffa0 ; $51b9
	ld a, e ; $51bc
	ld [hl+], a ; $51bd
	ld [hl], d ; $51be
	ld hl, wCharDataValuesSlideX ; $51bf
	ld de, $0080 ; $51c2
	ld a, e ; $51c5
	ld [hl+], a ; $51c6
	ld [hl], d ; $51c7
	call LoadBasePageIntoWorkTilemap ; $51c8
	ld hl, MainCharStatPageTilemapPatch20 ; $51cb
	ld bc, $da20 ; $51ce
	call ApplyTilemapPatchList ; $51d1
	ld hl, MainCharStatPageTilemapPatch21 ; $51d4
	ld bc, $db20 ; $51d7
	call ApplyTilemapPatchList ; $51da
	ld hl, MainCharStatPageTilemapPatch22 ; $51dd
	ld bc, $dc20 ; $51e0
	call ApplyTilemapPatchList ; $51e3
	farcall FlushCharDataTilemapsFar ; $51e6
	wram_bank $06 ; $51e9
	ld hl, wCharDataStatsSlideX ; $51ef
	ld de, $ffc0 ; $51f2
	ld a, e ; $51f5
	ld [hl+], a ; $51f6
	ld [hl], d ; $51f7
	ld hl, wCharDataValuesSlideX ; $51f8
	ld de, $00a0 ; $51fb
	ld a, e ; $51fe
	ld [hl+], a ; $51ff
	ld [hl], d ; $5200
	call LoadBasePageIntoWorkTilemap ; $5201
	ld hl, MainCharStatPageTilemapPatch17 ; $5204
	ld bc, $da20 ; $5207
	call ApplyTilemapPatchList ; $520a
	ld hl, MainCharStatPageTilemapPatch18 ; $520d
	ld bc, $db20 ; $5210
	call ApplyTilemapPatchList ; $5213
	ld hl, MainCharStatPageTilemapPatch19 ; $5216
	ld bc, $dc20 ; $5219
	call ApplyTilemapPatchList ; $521c
	farcall FlushCharDataTilemapsFar ; $521f
	wram_bank $06 ; $5222
	ld hl, wCharDataStatsSlideX ; $5228
	ld de, $ffe0 ; $522b
	ld a, e ; $522e
	ld [hl+], a ; $522f
	ld [hl], d ; $5230
	ld hl, wCharDataValuesSlideX ; $5231
	ld de, $00a8 ; $5234
	ld a, e ; $5237
	ld [hl+], a ; $5238
	ld [hl], d ; $5239
	call LoadBasePageIntoWorkTilemap ; $523a
	ld hl, MainCharStatPageTilemapPatch14 ; $523d
	ld bc, $da20 ; $5240
	call ApplyTilemapPatchList ; $5243
	ld hl, MainCharStatPageTilemapPatch15 ; $5246
	ld bc, $db20 ; $5249
	call ApplyTilemapPatchList ; $524c
	ld hl, MainCharStatPageTilemapPatch16 ; $524f
	ld bc, $dc20 ; $5252
	call ApplyTilemapPatchList ; $5255
	farcall FlushCharDataTilemapsFar ; $5258
	wram_bank $06 ; $525b
	ld hl, wCharDataStatsSlideX ; $5261
	xor a ; $5264
	ld [hl+], a ; $5265
	ld [hl], a ; $5266
	ret ; $5267
SlideFromMainCharStatPage:
	call AdvanceFrame ; $5268
	ld a, [$d002] ; $526b
	or a ; $526e
	jr nz, SlideFromMainCharStatPage ; $526f
	wram_bank $06 ; $5271
	ld hl, wCharDataStatsSlideX ; $5277
	ld de, $ffe0 ; $527a
	ld a, e ; $527d
	ld [hl+], a ; $527e
	ld [hl], d ; $527f
	call LoadBasePageIntoWorkTilemap ; $5280
	ld hl, MainCharStatPageTilemapPatch17 ; $5283
	ld bc, $da20 ; $5286
	call ApplyTilemapPatchList ; $5289
	ld hl, MainCharStatPageTilemapPatch18 ; $528c
	ld bc, $db20 ; $528f
	call ApplyTilemapPatchList ; $5292
	ld hl, MainCharStatPageTilemapPatch19 ; $5295
	ld bc, $dc20 ; $5298
	call ApplyTilemapPatchList ; $529b
	farcall FlushCharDataTilemapsFar ; $529e
	wram_bank $06 ; $52a1
	ld hl, wCharDataStatsSlideX ; $52a7
	ld de, $ffc0 ; $52aa
	ld a, e ; $52ad
	ld [hl+], a ; $52ae
	ld [hl], d ; $52af
	ld hl, wCharDataValuesSlideX ; $52b0
	ld de, $00a0 ; $52b3
	ld a, e ; $52b6
	ld [hl+], a ; $52b7
	ld [hl], d ; $52b8
	call LoadBasePageIntoWorkTilemap ; $52b9
	ld hl, MainCharStatPageTilemapPatch20 ; $52bc
	ld bc, $da20 ; $52bf
	call ApplyTilemapPatchList ; $52c2
	ld hl, MainCharStatPageTilemapPatch21 ; $52c5
	ld bc, $db20 ; $52c8
	call ApplyTilemapPatchList ; $52cb
	ld hl, MainCharStatPageTilemapPatch22 ; $52ce
	ld bc, $dc20 ; $52d1
	call ApplyTilemapPatchList ; $52d4
	farcall FlushCharDataTilemapsFar ; $52d7
	wram_bank $06 ; $52da
	ld hl, wCharDataStatsSlideX ; $52e0
	ld de, $ffa0 ; $52e3
	ld a, e ; $52e6
	ld [hl+], a ; $52e7
	ld [hl], d ; $52e8
	ld hl, wCharDataValuesSlideX ; $52e9
	ld de, $0080 ; $52ec
	ld a, e ; $52ef
	ld [hl+], a ; $52f0
	ld [hl], d ; $52f1
	call LoadBasePageIntoWorkTilemap ; $52f2
	ld hl, MainCharStatPageTilemapPatch11 ; $52f5
	ld bc, $d7e0 ; $52f8
	call ApplyTilemapPatchList ; $52fb
	ld hl, MainCharStatPageTilemapPatch12 ; $52fe
	ld bc, $d8e0 ; $5301
	call ApplyTilemapPatchList ; $5304
	ld hl, MainCharStatPageTilemapPatch13 ; $5307
	ld bc, $d9e0 ; $530a
	call ApplyTilemapPatchList ; $530d
	ld hl, MainCharStatPageTilemapPatch23 ; $5310
	ld bc, $da20 ; $5313
	call ApplyTilemapPatchList ; $5316
	ld hl, MainCharStatPageTilemapPatch24 ; $5319
	ld bc, $db20 ; $531c
	call ApplyTilemapPatchList ; $531f
	ld hl, MainCharStatPageTilemapPatch25 ; $5322
	ld bc, $dc20 ; $5325
	call ApplyTilemapPatchList ; $5328
	farcall FlushCharDataTilemapsFar ; $532b
	wram_bank $06 ; $532e
	ld hl, wCharDataStatsSlideX ; $5334
	ld de, $ff80 ; $5337
	ld a, e ; $533a
	ld [hl+], a ; $533b
	ld [hl], d ; $533c
	ld hl, wCharDataValuesSlideX ; $533d
	ld de, $0060 ; $5340
	ld a, e ; $5343
	ld [hl+], a ; $5344
	ld [hl], d ; $5345
	call LoadBasePageIntoWorkTilemap ; $5346
	ld hl, MainCharStatPageTilemapPatch08 ; $5349
	ld bc, $d7e0 ; $534c
	call ApplyTilemapPatchList ; $534f
	ld hl, MainCharStatPageTilemapPatch09 ; $5352
	ld bc, $d8e0 ; $5355
	call ApplyTilemapPatchList ; $5358
	ld hl, MainCharStatPageTilemapPatch10 ; $535b
	ld bc, $d9e0 ; $535e
	call ApplyTilemapPatchList ; $5361
	ld hl, MainCharStatPageTilemapPatch26 ; $5364
	ld bc, $da20 ; $5367
	call ApplyTilemapPatchList ; $536a
	ld hl, MainCharStatPageTilemapPatch27 ; $536d
	ld bc, $db20 ; $5370
	call ApplyTilemapPatchList ; $5373
	ld hl, MainCharStatPageTilemapPatch28 ; $5376
	ld bc, $dc20 ; $5379
	call ApplyTilemapPatchList ; $537c
	farcall FlushCharDataTilemapsFar ; $537f
	wram_bank $06 ; $5382
	ld hl, wCharDataStatsSlideX ; $5388
	ld de, $ff60 ; $538b
	ld a, e ; $538e
	ld [hl+], a ; $538f
	ld [hl], d ; $5390
	ld hl, wCharDataValuesSlideX ; $5391
	ld de, $0040 ; $5394
	ld a, e ; $5397
	ld [hl+], a ; $5398
	ld [hl], d ; $5399
	call LoadBasePageIntoWorkTilemap ; $539a
	ld hl, MainCharStatPageTilemapPatch05 ; $539d
	ld bc, $d7e0 ; $53a0
	call ApplyTilemapPatchList ; $53a3
	ld hl, MainCharStatPageTilemapPatch06 ; $53a6
	ld bc, $d8e0 ; $53a9
	call ApplyTilemapPatchList ; $53ac
	ld hl, MainCharStatPageTilemapPatch07 ; $53af
	ld bc, $d9e0 ; $53b2
	call ApplyTilemapPatchList ; $53b5
	ld hl, StatPageTilemapPatch0 ; $53b8
	ld bc, $d390 ; $53bb
	call ApplyTilemapPatchList ; $53be
	farcall FlushCharDataTilemapsFar ; $53c1
	wram_bank $06 ; $53c4
	ld hl, wCharDataStatsSlideX ; $53ca
	ld de, $00a8 ; $53cd
	ld a, e ; $53d0
	ld [hl+], a ; $53d1
	ld [hl], d ; $53d2
	ld hl, wCharDataValuesSlideX ; $53d3
	ld de, $0010 ; $53d6
	ld a, e ; $53d9
	ld [hl+], a ; $53da
	ld [hl], d ; $53db
	call LoadBasePageIntoWorkTilemap ; $53dc
	ld hl, MainCharStatPageTilemapPatch02 ; $53df
	ld bc, $d7e0 ; $53e2
	call ApplyTilemapPatchList ; $53e5
	ld hl, MainCharStatPageTilemapPatch03 ; $53e8
	ld bc, $d8e0 ; $53eb
	call ApplyTilemapPatchList ; $53ee
	ld hl, MainCharStatPageTilemapPatch04 ; $53f1
	ld bc, $d9e0 ; $53f4
	call ApplyTilemapPatchList ; $53f7
	ld hl, DrillDisplayData_1d ; $53fa
	ld bc, $d390 ; $53fd
	call ApplyTilemapPatchList ; $5400
	farcall FlushCharDataTilemapsFar ; $5403
	wram_bank $06 ; $5406
	ld hl, wCharDataValuesSlideX ; $540c
	xor a ; $540f
	ld [hl+], a ; $5410
	ld [hl], a ; $5411
	call LoadBasePageIntoWorkTilemap ; $5412
	ld hl, StatPageTilemapPatch6 ; $5415
	ld bc, $d7e0 ; $5418
	call ApplyTilemapPatchList ; $541b
	ld hl, StatPageTilemapPatch7 ; $541e
	ld bc, $d8e0 ; $5421
	call ApplyTilemapPatchList ; $5424
	ld hl, StatPageTilemapPatch8 ; $5427
	ld bc, $d9e0 ; $542a
	call ApplyTilemapPatchList ; $542d
	ld hl, DrillDisplayData_1d ; $5430
	ld bc, $d390 ; $5433
	call ApplyTilemapPatchList ; $5436
	farcall FlushCharDataTilemapsFar ; $5439
	ret ; $543c
SlideToPartnerStatPage:
	call AdvanceFrame ; $543d
	ld a, [$d002] ; $5440
	or a ; $5443
	jr nz, SlideToPartnerStatPage ; $5444
	wram_bank $06 ; $5446
	ld hl, wCharDataValuesSlideX ; $544c
	ld de, $ffe0 ; $544f
	ld a, e ; $5452
	ld [hl+], a ; $5453
	ld [hl], d ; $5454
	call LoadBasePageIntoWorkTilemap ; $5455
	ld hl, PartnerStatPageTilemapPatch02 ; $5458
	ld bc, $d7e0 ; $545b
	call ApplyTilemapPatchList ; $545e
	ld hl, PartnerStatPageTilemapPatch03 ; $5461
	ld bc, $d8e0 ; $5464
	call ApplyTilemapPatchList ; $5467
	ld hl, PartnerStatPageTilemapPatch04 ; $546a
	ld bc, $d9e0 ; $546d
	call ApplyTilemapPatchList ; $5470
	ld hl, DrillDisplayData_1d ; $5473
	ld bc, $d390 ; $5476
	call ApplyTilemapPatchList ; $5479
	farcall FlushCharDataTilemapsFar ; $547c
	wram_bank $06 ; $547f
	ld hl, wCharDataStatsSlideX ; $5485
	ld de, $00a0 ; $5488
	ld a, e ; $548b
	ld [hl+], a ; $548c
	ld [hl], d ; $548d
	ld hl, wCharDataValuesSlideX ; $548e
	ld de, $ffc0 ; $5491
	ld a, e ; $5494
	ld [hl+], a ; $5495
	ld [hl], d ; $5496
	call LoadBasePageIntoWorkTilemap ; $5497
	ld hl, PartnerStatPageTilemapPatch05 ; $549a
	ld bc, $d7e0 ; $549d
	call ApplyTilemapPatchList ; $54a0
	ld hl, PartnerStatPageTilemapPatch06 ; $54a3
	ld bc, $d8e0 ; $54a6
	call ApplyTilemapPatchList ; $54a9
	ld hl, PartnerStatPageTilemapPatch07 ; $54ac
	ld bc, $d9e0 ; $54af
	call ApplyTilemapPatchList ; $54b2
	ld hl, PartnerStatPageTilemapPatch26 ; $54b5
	ld bc, $dc60 ; $54b8
	call ApplyTilemapPatchList ; $54bb
	ld hl, PartnerStatPageTilemapPatch27 ; $54be
	ld bc, $dd60 ; $54c1
	call ApplyTilemapPatchList ; $54c4
	ld hl, PartnerStatPageTilemapPatch28 ; $54c7
	ld bc, $de60 ; $54ca
	call ApplyTilemapPatchList ; $54cd
	ld hl, StatPageTilemapPatch0 ; $54d0
	ld bc, $d390 ; $54d3
	call ApplyTilemapPatchList ; $54d6
	farcall FlushCharDataTilemapsFar ; $54d9
	wram_bank $06 ; $54dc
	ld hl, wCharDataStatsSlideX ; $54e2
	ld de, $0080 ; $54e5
	ld a, e ; $54e8
	ld [hl+], a ; $54e9
	ld [hl], d ; $54ea
	ld hl, wCharDataValuesSlideX ; $54eb
	ld de, $ffa0 ; $54ee
	ld a, e ; $54f1
	ld [hl+], a ; $54f2
	ld [hl], d ; $54f3
	call LoadBasePageIntoWorkTilemap ; $54f4
	ld hl, PartnerStatPageTilemapPatch08 ; $54f7
	ld bc, $d7e0 ; $54fa
	call ApplyTilemapPatchList ; $54fd
	ld hl, PartnerStatPageTilemapPatch09 ; $5500
	ld bc, $d8e0 ; $5503
	call ApplyTilemapPatchList ; $5506
	ld hl, PartnerStatPageTilemapPatch10 ; $5509
	ld bc, $d9e0 ; $550c
	call ApplyTilemapPatchList ; $550f
	ld hl, PartnerStatPageTilemapPatch23 ; $5512
	ld bc, $dc60 ; $5515
	call ApplyTilemapPatchList ; $5518
	ld hl, PartnerStatPageTilemapPatch24 ; $551b
	ld bc, $dd60 ; $551e
	call ApplyTilemapPatchList ; $5521
	ld hl, PartnerStatPageTilemapPatch25 ; $5524
	ld bc, $de60 ; $5527
	call ApplyTilemapPatchList ; $552a
	farcall FlushCharDataTilemapsFar ; $552d
	wram_bank $06 ; $5530
	ld hl, wCharDataStatsSlideX ; $5536
	ld de, $0060 ; $5539
	ld a, e ; $553c
	ld [hl+], a ; $553d
	ld [hl], d ; $553e
	ld hl, wCharDataValuesSlideX ; $553f
	ld de, $ff80 ; $5542
	ld a, e ; $5545
	ld [hl+], a ; $5546
	ld [hl], d ; $5547
	call LoadBasePageIntoWorkTilemap ; $5548
	ld hl, PartnerStatPageTilemapPatch11 ; $554b
	ld bc, $d7e0 ; $554e
	call ApplyTilemapPatchList ; $5551
	ld hl, PartnerStatPageTilemapPatch12 ; $5554
	ld bc, $d8e0 ; $5557
	call ApplyTilemapPatchList ; $555a
	ld hl, PartnerStatPageTilemapPatch13 ; $555d
	ld bc, $d9e0 ; $5560
	call ApplyTilemapPatchList ; $5563
	ld hl, PartnerStatPageTilemapPatch20 ; $5566
	ld bc, $dc60 ; $5569
	call ApplyTilemapPatchList ; $556c
	ld hl, PartnerStatPageTilemapPatch21 ; $556f
	ld bc, $dd60 ; $5572
	call ApplyTilemapPatchList ; $5575
	ld hl, PartnerStatPageTilemapPatch22 ; $5578
	ld bc, $de60 ; $557b
	call ApplyTilemapPatchList ; $557e
	farcall FlushCharDataTilemapsFar ; $5581
	wram_bank $06 ; $5584
	ld hl, wCharDataStatsSlideX ; $558a
	ld de, $0040 ; $558d
	ld a, e ; $5590
	ld [hl+], a ; $5591
	ld [hl], d ; $5592
	ld hl, wCharDataValuesSlideX ; $5593
	ld de, $ff60 ; $5596
	ld a, e ; $5599
	ld [hl+], a ; $559a
	ld [hl], d ; $559b
	call LoadBasePageIntoWorkTilemap ; $559c
	ld hl, PartnerStatPageTilemapPatch17 ; $559f
	ld bc, $dc60 ; $55a2
	call ApplyTilemapPatchList ; $55a5
	ld hl, PartnerStatPageTilemapPatch18 ; $55a8
	ld bc, $dd60 ; $55ab
	call ApplyTilemapPatchList ; $55ae
	ld hl, PartnerStatPageTilemapPatch19 ; $55b1
	ld bc, $de60 ; $55b4
	call ApplyTilemapPatchList ; $55b7
	farcall FlushCharDataTilemapsFar ; $55ba
	wram_bank $06 ; $55bd
	ld hl, wCharDataStatsSlideX ; $55c3
	ld de, $0020 ; $55c6
	ld a, e ; $55c9
	ld [hl+], a ; $55ca
	ld [hl], d ; $55cb
	ld hl, wCharDataValuesSlideX ; $55cc
	ld de, $00a8 ; $55cf
	ld a, e ; $55d2
	ld [hl+], a ; $55d3
	ld [hl], d ; $55d4
	call LoadBasePageIntoWorkTilemap ; $55d5
	ld hl, PartnerStatPageTilemapPatch14 ; $55d8
	ld bc, $dc60 ; $55db
	call ApplyTilemapPatchList ; $55de
	ld hl, PartnerStatPageTilemapPatch15 ; $55e1
	ld bc, $dd60 ; $55e4
	call ApplyTilemapPatchList ; $55e7
	ld hl, PartnerStatPageTilemapPatch16 ; $55ea
	ld bc, $de60 ; $55ed
	call ApplyTilemapPatchList ; $55f0
	farcall FlushCharDataTilemapsFar ; $55f3
	wram_bank $06 ; $55f6
	ld hl, wCharDataStatsSlideX ; $55fc
	xor a ; $55ff
	ld [hl+], a ; $5600
	ld [hl], a ; $5601
	ret ; $5602
SlideFromPartnerStatPage:
	call AdvanceFrame ; $5603
	ld a, [$d002] ; $5606
	or a ; $5609
	jr nz, SlideFromPartnerStatPage ; $560a
	wram_bank $06 ; $560c
	ld hl, wCharDataStatsSlideX ; $5612
	ld de, $0020 ; $5615
	ld a, e ; $5618
	ld [hl+], a ; $5619
	ld [hl], d ; $561a
	call LoadBasePageIntoWorkTilemap ; $561b
	ld hl, PartnerStatPageTilemapPatch17 ; $561e
	ld bc, $dc60 ; $5621
	call ApplyTilemapPatchList ; $5624
	ld hl, PartnerStatPageTilemapPatch18 ; $5627
	ld bc, $dd60 ; $562a
	call ApplyTilemapPatchList ; $562d
	ld hl, PartnerStatPageTilemapPatch19 ; $5630
	ld bc, $de60 ; $5633
	call ApplyTilemapPatchList ; $5636
	farcall FlushCharDataTilemapsFar ; $5639
	wram_bank $06 ; $563c
	ld hl, wCharDataValuesSlideX ; $5642
	ld de, $ff60 ; $5645
	ld a, e ; $5648
	ld [hl+], a ; $5649
	ld [hl], d ; $564a
	ld hl, wCharDataStatsSlideX ; $564b
	ld de, $0040 ; $564e
	ld a, e ; $5651
	ld [hl+], a ; $5652
	ld [hl], d ; $5653
	call LoadBasePageIntoWorkTilemap ; $5654
	ld hl, PartnerStatPageTilemapPatch11 ; $5657
	ld bc, $d7e0 ; $565a
	call ApplyTilemapPatchList ; $565d
	ld hl, PartnerStatPageTilemapPatch12 ; $5660
	ld bc, $d8e0 ; $5663
	call ApplyTilemapPatchList ; $5666
	ld hl, PartnerStatPageTilemapPatch13 ; $5669
	ld bc, $d9e0 ; $566c
	call ApplyTilemapPatchList ; $566f
	ld hl, PartnerStatPageTilemapPatch20 ; $5672
	ld bc, $dc60 ; $5675
	call ApplyTilemapPatchList ; $5678
	ld hl, PartnerStatPageTilemapPatch21 ; $567b
	ld bc, $dd60 ; $567e
	call ApplyTilemapPatchList ; $5681
	ld hl, PartnerStatPageTilemapPatch22 ; $5684
	ld bc, $de60 ; $5687
	call ApplyTilemapPatchList ; $568a
	farcall FlushCharDataTilemapsFar ; $568d
	wram_bank $06 ; $5690
	ld hl, wCharDataValuesSlideX ; $5696
	ld de, $ff80 ; $5699
	ld a, e ; $569c
	ld [hl+], a ; $569d
	ld [hl], d ; $569e
	ld hl, wCharDataStatsSlideX ; $569f
	ld de, $0060 ; $56a2
	ld a, e ; $56a5
	ld [hl+], a ; $56a6
	ld [hl], d ; $56a7
	call LoadBasePageIntoWorkTilemap ; $56a8
	ld hl, PartnerStatPageTilemapPatch08 ; $56ab
	ld bc, $d7e0 ; $56ae
	call ApplyTilemapPatchList ; $56b1
	ld hl, PartnerStatPageTilemapPatch09 ; $56b4
	ld bc, $d8e0 ; $56b7
	call ApplyTilemapPatchList ; $56ba
	ld hl, PartnerStatPageTilemapPatch10 ; $56bd
	ld bc, $d9e0 ; $56c0
	call ApplyTilemapPatchList ; $56c3
	ld hl, PartnerStatPageTilemapPatch23 ; $56c6
	ld bc, $dc60 ; $56c9
	call ApplyTilemapPatchList ; $56cc
	ld hl, PartnerStatPageTilemapPatch24 ; $56cf
	ld bc, $dd60 ; $56d2
	call ApplyTilemapPatchList ; $56d5
	ld hl, PartnerStatPageTilemapPatch25 ; $56d8
	ld bc, $de60 ; $56db
	call ApplyTilemapPatchList ; $56de
	farcall FlushCharDataTilemapsFar ; $56e1
	wram_bank $06 ; $56e4
	ld hl, wCharDataValuesSlideX ; $56ea
	ld de, $ffa0 ; $56ed
	ld a, e ; $56f0
	ld [hl+], a ; $56f1
	ld [hl], d ; $56f2
	ld hl, wCharDataStatsSlideX ; $56f3
	ld de, $0080 ; $56f6
	ld a, e ; $56f9
	ld [hl+], a ; $56fa
	ld [hl], d ; $56fb
	call LoadBasePageIntoWorkTilemap ; $56fc
	ld hl, PartnerStatPageTilemapPatch05 ; $56ff
	ld bc, $d7e0 ; $5702
	call ApplyTilemapPatchList ; $5705
	ld hl, PartnerStatPageTilemapPatch06 ; $5708
	ld bc, $d8e0 ; $570b
	call ApplyTilemapPatchList ; $570e
	ld hl, PartnerStatPageTilemapPatch07 ; $5711
	ld bc, $d9e0 ; $5714
	call ApplyTilemapPatchList ; $5717
	ld hl, PartnerStatPageTilemapPatch26 ; $571a
	ld bc, $dc60 ; $571d
	call ApplyTilemapPatchList ; $5720
	ld hl, PartnerStatPageTilemapPatch27 ; $5723
	ld bc, $dd60 ; $5726
	call ApplyTilemapPatchList ; $5729
	ld hl, PartnerStatPageTilemapPatch28 ; $572c
	ld bc, $de60 ; $572f
	call ApplyTilemapPatchList ; $5732
	ld hl, StatPageTilemapPatch0 ; $5735
	ld bc, $d390 ; $5738
	call ApplyTilemapPatchList ; $573b
	farcall FlushCharDataTilemapsFar ; $573e
	wram_bank $06 ; $5741
	ld hl, wCharDataValuesSlideX ; $5747
	ld de, $ffc0 ; $574a
	ld a, e ; $574d
	ld [hl+], a ; $574e
	ld [hl], d ; $574f
	ld hl, wCharDataStatsSlideX ; $5750
	ld de, $00a0 ; $5753
	ld a, e ; $5756
	ld [hl+], a ; $5757
	ld [hl], d ; $5758
	call LoadBasePageIntoWorkTilemap ; $5759
	ld hl, PartnerStatPageTilemapPatch02 ; $575c
	ld bc, $d7e0 ; $575f
	call ApplyTilemapPatchList ; $5762
	ld hl, PartnerStatPageTilemapPatch03 ; $5765
	ld bc, $d8e0 ; $5768
	call ApplyTilemapPatchList ; $576b
	ld hl, PartnerStatPageTilemapPatch04 ; $576e
	ld bc, $d9e0 ; $5771
	call ApplyTilemapPatchList ; $5774
	ld hl, DrillDisplayData_1d ; $5777
	ld bc, $d390 ; $577a
	call ApplyTilemapPatchList ; $577d
	farcall FlushCharDataTilemapsFar ; $5780
	wram_bank $06 ; $5783
	ld hl, wCharDataValuesSlideX ; $5789
	ld de, $ffe0 ; $578c
	ld a, e ; $578f
	ld [hl+], a ; $5790
	ld [hl], d ; $5791
	ld hl, wCharDataStatsSlideX ; $5792
	ld de, $00a8 ; $5795
	ld a, e ; $5798
	ld [hl+], a ; $5799
	ld [hl], d ; $579a
	call LoadBasePageIntoWorkTilemap ; $579b
	ld hl, StatPageTilemapPatch6 ; $579e
	ld bc, $d7e0 ; $57a1
	call ApplyTilemapPatchList ; $57a4
	ld hl, StatPageTilemapPatch7 ; $57a7
	ld bc, $d8e0 ; $57aa
	call ApplyTilemapPatchList ; $57ad
	ld hl, StatPageTilemapPatch8 ; $57b0
	ld bc, $d9e0 ; $57b3
	call ApplyTilemapPatchList ; $57b6
	ld hl, DrillDisplayData_1d ; $57b9
	ld bc, $d390 ; $57bc
	call ApplyTilemapPatchList ; $57bf
	farcall FlushCharDataTilemapsFar ; $57c2
	wram_bank $06 ; $57c5
	ld hl, wCharDataValuesSlideX ; $57cb
	xor a ; $57ce
	ld [hl+], a ; $57cf
	ld [hl], a ; $57d0
	ret ; $57d1
DrawCharStatDigitsTask:
	wram_bank $06 ; $57d2
	ld b, $0f ; $57d8
	ld a, [wCharDataLevels] ; $57da
	ld l, a ; $57dd
	cp $0a ; $57de
	jr c, .lt0a ; $57e0
	push bc ; $57e2
	ld h, $00 ; $57e3
	ld a, $02 ; $57e5
	ld de, wCharDataNumberBuffer ; $57e7
	call FormatDecimalNumberUnsigned ; $57ea
	pop bc ; $57ed
	push bc ; $57ee
	ld a, [wCharDataNumberBuffer] ; $57ef
	sub $30 ; $57f2
	rlca ; $57f4
	ld c, a ; $57f5
	ld de, $051c ; $57f6
	xor a ; $57f9
	ld hl, wCharDataStatsSlideX ; $57fa
	call ApplySlideOffsetToSpriteX ; $57fd
	call QueueSprite ; $5800
	pop bc ; $5803
	ld a, [wCharDataNumberBuffer + 1] ; $5804
	sub $30 ; $5807
	rlca ; $5809
	ld c, a ; $580a
	ld de, $0c1c ; $580b
	xor a ; $580e
	ld hl, wCharDataStatsSlideX ; $580f
	call ApplySlideOffsetToSpriteX ; $5812
	call QueueSprite ; $5815
	jr .stat2 ; $5818
.lt0a:
	ld a, l ; $581a
	rlca ; $581b
	ld c, a ; $581c
	ld de, $091c ; $581d
	xor a ; $5820
	ld hl, wCharDataStatsSlideX ; $5821
	call ApplySlideOffsetToSpriteX ; $5824
	call QueueSprite ; $5827
.stat2:
	ld b, $0f ; $582a
	ld a, [wCharDataLevels + 1] ; $582c
	ld l, a ; $582f
	cp $0a ; $5830
	jr c, .lt0a2 ; $5832
	push bc ; $5834
	ld h, $00 ; $5835
	ld a, $02 ; $5837
	ld de, wCharDataNumberBuffer ; $5839
	call FormatDecimalNumberUnsigned ; $583c
	pop bc ; $583f
	push bc ; $5840
	ld a, [wCharDataNumberBuffer] ; $5841
	sub $30 ; $5844
	rlca ; $5846
	ld c, a ; $5847
	ld de, $0544 ; $5848
	ld a, $01 ; $584b
	ld hl, wCharDataStatsSlideX ; $584d
	call ApplySlideOffsetToSpriteX ; $5850
	call QueueSprite ; $5853
	pop bc ; $5856
	ld a, [wCharDataNumberBuffer + 1] ; $5857
	sub $30 ; $585a
	rlca ; $585c
	ld c, a ; $585d
	ld de, $0c44 ; $585e
	ld a, $01 ; $5861
	ld hl, wCharDataStatsSlideX ; $5863
	call ApplySlideOffsetToSpriteX ; $5866
	call QueueSprite ; $5869
	jr .stat3 ; $586c
.lt0a2:
	ld a, l ; $586e
	rlca ; $586f
	ld c, a ; $5870
	ld de, $0944 ; $5871
	ld a, $01 ; $5874
	ld hl, wCharDataStatsSlideX ; $5876
	call ApplySlideOffsetToSpriteX ; $5879
	call QueueSprite ; $587c
.stat3:
	ld b, $0f ; $587f
	ld a, [wCharDataLevels + 2] ; $5881
	ld l, a ; $5884
	cp $0a ; $5885
	jr c, .lt0a3 ; $5887
	push bc ; $5889
	ld h, $00 ; $588a
	ld a, $02 ; $588c
	ld de, wCharDataNumberBuffer ; $588e
	call FormatDecimalNumberUnsigned ; $5891
	pop bc ; $5894
	push bc ; $5895
	ld a, [wCharDataNumberBuffer] ; $5896
	sub $30 ; $5899
	rlca ; $589b
	ld c, a ; $589c
	ld de, $551c ; $589d
	ld a, $02 ; $58a0
	ld hl, wCharDataStatsSlideX ; $58a2
	call ApplySlideOffsetToSpriteX ; $58a5
	call QueueSprite ; $58a8
	pop bc ; $58ab
	ld a, [wCharDataNumberBuffer + 1] ; $58ac
	sub $30 ; $58af
	rlca ; $58b1
	ld c, a ; $58b2
	ld de, $5c1c ; $58b3
	ld a, $02 ; $58b6
	ld hl, wCharDataStatsSlideX ; $58b8
	call ApplySlideOffsetToSpriteX ; $58bb
	call QueueSprite ; $58be
	jr .stat4 ; $58c1
.lt0a3:
	ld a, l ; $58c3
	rlca ; $58c4
	ld c, a ; $58c5
	ld de, $591c ; $58c6
	ld a, $02 ; $58c9
	ld hl, wCharDataStatsSlideX ; $58cb
	call ApplySlideOffsetToSpriteX ; $58ce
	call QueueSprite ; $58d1
.stat4:
	ld b, $0f ; $58d4
	ld a, [wCharDataLevels + 3] ; $58d6
	ld l, a ; $58d9
	cp $0a ; $58da
	jr c, .lt0a4 ; $58dc
	push bc ; $58de
	ld h, $00 ; $58df
	ld a, $02 ; $58e1
	ld de, wCharDataNumberBuffer ; $58e3
	call FormatDecimalNumberUnsigned ; $58e6
	pop bc ; $58e9
	push bc ; $58ea
	ld a, [wCharDataNumberBuffer] ; $58eb
	sub $30 ; $58ee
	rlca ; $58f0
	ld c, a ; $58f1
	ld de, $5544 ; $58f2
	ld a, $03 ; $58f5
	ld hl, wCharDataStatsSlideX ; $58f7
	call ApplySlideOffsetToSpriteX ; $58fa
	call QueueSprite ; $58fd
	pop bc ; $5900
	ld a, [wCharDataNumberBuffer + 1] ; $5901
	sub $30 ; $5904
	rlca ; $5906
	ld c, a ; $5907
	ld de, $5c44 ; $5908
	ld a, $03 ; $590b
	ld hl, wCharDataStatsSlideX ; $590d
	call ApplySlideOffsetToSpriteX ; $5910
	call QueueSprite ; $5913
	jr .getCharDataDigitSprite ; $5916
.lt0a4:
	ld a, l ; $5918
	rlca ; $5919
	ld c, a ; $591a
	ld de, $5944 ; $591b
	ld a, $03 ; $591e
	ld hl, wCharDataStatsSlideX ; $5920
	call ApplySlideOffsetToSpriteX ; $5923
	call QueueSprite ; $5926
.getCharDataDigitSprite:
	ld a, [$d13d] ; $5929
	cp $20 ; $592c
	jr z, .eq20 ; $592e
	call GetCharDataDigitSprite ; $5930
	ld de, $2984 ; $5933
	ld hl, wCharDataStatsSlideX ; $5936
	call ApplySlideOffsetToSpriteX ; $5939
	call QueueSprite ; $593c
.eq20:
	ld a, [$d13e] ; $593f
	cp $20 ; $5942
	jr z, .eq202 ; $5944
	call GetCharDataDigitSprite ; $5946
	ld de, $3184 ; $5949
	ld hl, wCharDataStatsSlideX ; $594c
	call ApplySlideOffsetToSpriteX ; $594f
	call QueueSprite ; $5952
.eq202:
	ld a, [$d13f] ; $5955
	cp $20 ; $5958
	jr z, .eq203 ; $595a
	call GetCharDataDigitSprite ; $595c
	ld de, $3984 ; $595f
	ld hl, wCharDataStatsSlideX ; $5962
	call ApplySlideOffsetToSpriteX ; $5965
	call QueueSprite ; $5968
.eq203:
	ld a, [$d140] ; $596b
	cp $20 ; $596e
	jr z, .eq204 ; $5970
	call GetCharDataDigitSprite ; $5972
	ld de, $4184 ; $5975
	ld hl, wCharDataStatsSlideX ; $5978
	call ApplySlideOffsetToSpriteX ; $597b
	call QueueSprite ; $597e
.eq204:
	ld a, [$d141] ; $5981
	call GetCharDataDigitSprite ; $5984
	ld de, $4984 ; $5987
	ld hl, wCharDataStatsSlideX ; $598a
	call ApplySlideOffsetToSpriteX ; $598d
	call QueueSprite ; $5990
	farcall DrawStatChangeArrows ; $5993
	ret ; $5996
ApplySlideOffsetToSpriteX:
	push bc ; $5997
	ld b, $00 ; $5998
	ld c, d ; $599a
	wram_bank $06 ; $599b
	ld a, [hl+] ; $59a1
	ld h, [hl] ; $59a2
	ld l, a ; $59a3
	add hl, bc ; $59a4
	ld a, h ; $59a5
	or a ; $59a6
	jr nz, .offscreen ; $59a7
	ld a, l ; $59a9
	cp $a0 ; $59aa
	jr nc, .offscreen ; $59ac
	ld d, l ; $59ae
	pop bc ; $59af
	ret ; $59b0
.offscreen:
	ld d, $a8 ; $59b1
	pop bc ; $59b3
	ret ; $59b4
GetCharDataDigitSprite:
	sub $30 ; $59b5
	rlca ; $59b7
	add $38 ; $59b8
	ld c, a ; $59ba
	ld b, $08 ; $59bb
	ret ; $59bd
ComputeExpProgressBar:
	ld a, [wStoryCharacterSlot] ; $59be
	farcall GetExpRemainingToNextLevel ; $59c1
	ld a, h ; $59c4
	or l ; $59c5
	jp z, .returnZero ; $59c6
	push hl ; $59c9
	ld a, [wStoryCharacterSlot] ; $59ca
	farcall GetExpProgressInCurrentLevel ; $59cd
	pop de ; $59d0
	push hl ; $59d1
	add hl, de ; $59d2
	pop de ; $59d3
	ld b, $40 ; $59d4
	call ScaleValueToBar ; $59d6
	ret ; $59d9
.returnZero:
	xor a ; $59da
	ret ; $59db
ScaleValueToBar:
	push bc ; $59dc
	push hl ; $59dd
	ld h, $00 ; $59de
	ld l, b ; $59e0
	call MulHLByDESigned ; $59e1
	ldh a, [hMulResult] ; $59e4
	ld l, a ; $59e6
	ldh a, [hMulResult + 1] ; $59e7
	ld h, a ; $59e9
	ldh a, [hMulResult + 2] ; $59ea
	pop de ; $59ec
	call DivAHLByDE ; $59ed
	ld a, h ; $59f0
	or a ; $59f1
	jr nz, .done ; $59f2
	pop bc ; $59f4
	inc b ; $59f5
	ld a, l ; $59f6
	cp b ; $59f7
	ret c ; $59f8
.done:
	pop bc ; $59f9
	ld a, b ; $59fa
	ret ; $59fb
DrawExpProgressBarTiles:
	ld b, a ; $59fc
	wram_bank $03 ; $59fd
.loop:
	ld a, b ; $5a03
	sub $08 ; $5a04
	jr c, .carry ; $5a06
	jr z, .zero ; $5a08
	ld b, a ; $5a0a
	ld a, $08 ; $5a0b
	rlca ; $5a0d
	add LOW(Data_1d_5a51) ; $5a0e
	ld l, a ; $5a10
	adc HIGH(Data_1d_5a51) ; $5a11
	sub l ; $5a13
	ld h, a ; $5a14
	ld a, [hl+] ; $5a15
	ld [de], a ; $5a16
	push de ; $5a17
	ld a, $0a ; $5a18
	add e ; $5a1a
	ld e, a ; $5a1b
	jr nc, .read ; $5a1c
	inc d ; $5a1e
.read:
	ld a, [hl] ; $5a1f
	ld [de], a ; $5a20
	pop de ; $5a21
	inc de ; $5a22
	jr .loop ; $5a23
.carry:
	add $08 ; $5a25
	rlca ; $5a27
	add LOW(Data_1d_5a51) ; $5a28
	ld l, a ; $5a2a
	adc HIGH(Data_1d_5a51) ; $5a2b
	sub l ; $5a2d
	ld h, a ; $5a2e
	ld a, [hl+] ; $5a2f
	ld [de], a ; $5a30
	ld a, $0a ; $5a31
	add e ; $5a33
	ld e, a ; $5a34
	jr nc, .readB ; $5a35
	inc d ; $5a37
.readB:
	ld a, [hl] ; $5a38
	ld [de], a ; $5a39
	ret ; $5a3a
.zero:
	ld a, $08 ; $5a3b
	rlca ; $5a3d
	add LOW(Data_1d_5a51) ; $5a3e
	ld l, a ; $5a40
	adc HIGH(Data_1d_5a51) ; $5a41
	sub l ; $5a43
	ld h, a ; $5a44
	ld a, [hl+] ; $5a45
	ld [de], a ; $5a46
	ld a, $0a ; $5a47
	add e ; $5a49
	ld e, a ; $5a4a
	jr nc, .read2 ; $5a4b
	inc d ; $5a4d
.read2:
	ld a, [hl] ; $5a4e
	ld [de], a ; $5a4f
	ret ; $5a50
Data_1d_5a51:
	; $5a51, 18 bytes (bytes:16)
	db $f9, $fa, $e1, $f1, $e2, $f2, $e3, $f3, $e4, $f4, $e5, $f5, $e6, $f6, $e7, $f7 ; 0x00
	db $e8, $f8 ; 0x10
PromptCharDataConfirm:
	push af ; $5a63
	call ClearFrameTasks ; $5a64
	call DisableLCDSafely ; $5a67
	xor a ; $5a6a
	ldh [hScrollX], a ; $5a6b
	ldh [hScrollY], a ; $5a6d
	ld [wCameraX], a ; $5a6f
	ld [wCameraX + 1], a ; $5a72
	ld [wCameraY], a ; $5a75
	ld [wCameraY + 1], a ; $5a78
	ld a, $90 ; $5a7b
	ldh [rWY], a ; $5a7d
	call ClearSpriteQueue ; $5a7f
	call InitDrillWorkRam ; $5a82
	pop af ; $5a85
	call BuildCharDataConfirmScreen ; $5a86
	call EnableLCD ; $5a89
	call AdvanceFrame ; $5a8c
	farcall StartCharDataScreenAnimTask ; $5a8f
	script_fade_in $10 ; $5a92
	call WaitFadeEnd ; $5a97
	wram_bank $06 ; $5a9a
	ld a, $01 ; $5aa0
	ld [wCharDataConfirmState], a ; $5aa2
.loop:
	call DrawCharDataConfirmCursor ; $5aa5
	call AdvanceFrame ; $5aa8
	ldh a, [hInputRisingEdge] ; $5aab
	bit PADB_A, a ; $5aad
	jr nz, .step ; $5aaf
	bit 1, a ; $5ab1
	jr nz, .beginFadeOut2 ; $5ab3
	and $c0 ; $5ab5
	jr z, .loop ; $5ab7
	sound $5e ; $5ab9
	ld a, [wCharDataConfirmState] ; $5abb
	xor $01 ; $5abe
	ld [wCharDataConfirmState], a ; $5ac0
	jr .loop ; $5ac3
.step:
	wram_bank $06 ; $5ac5
	ld a, [wCharDataConfirmState] ; $5acb
	or a ; $5ace
	jr nz, .beginFadeOut2 ; $5acf
	sound $5f ; $5ad1
	jr .beginFadeOut ; $5ad3
.beginFadeOut2:
	wram_bank $06 ; $5ad5
	ld a, $01 ; $5adb
	ld [wCharDataConfirmState], a ; $5add
	sound $62 ; $5ae0
.beginFadeOut:
	ld c, $10 ; $5ae2
	call BeginFadeOut ; $5ae4
	call WaitFadeEnd ; $5ae7
	farcall StopCharDataScreenAnimTask ; $5aea
	call ClearFrameTasks ; $5aed
	wram_bank $06 ; $5af0
	ld a, [wCharDataConfirmState] ; $5af6
	ret ; $5af9
DrawCharDataConfirmCursor:
	wram_bank $06 ; $5afa
	ld a, [wCharDataConfirmState] ; $5b00
	or a ; $5b03
	jr nz, .nonZero ; $5b04
	ld bc, $0fd4 ; $5b06
	ld de, $7a0c ; $5b09
	call QueueSprite ; $5b0c
	ret ; $5b0f
.nonZero:
	ld bc, $0fd4 ; $5b10
	ld de, $7a14 ; $5b13
	call QueueSprite ; $5b16
	ret ; $5b19
BuildCharDataConfirmScreen:
	push af ; $5b1a
	farcall CharDataScreen_LoadScreen ; $5b1b
	farcall LoadCharDataScreenTilemaps ; $5b1e
	pop af ; $5b21
	ld [wStoryCharacterSlot], a ; $5b22
	push af ; $5b25
	ld hl, wStoryModeNameOfMainCharacter ; $5b26
	ld a, [wStoryCharacterSlot] ; $5b29
	or a ; $5b2c
	jr z, .zero ; $5b2d
	ld l, $40 ; $5b2f
.zero:
	ld a, l ; $5b31
	add $0c ; $5b32
	ld l, a ; $5b34
	ld a, h ; $5b35
	adc $00 ; $5b36
	ld h, a ; $5b38
	pop af ; $5b39
	ld a, [hl] ; $5b3a
	ld de, $0401 ; $5b3b
	farcall LoadIndexedPaletteThunk ; $5b3e
	wram_bank $01 ; $5b41
	push af ; $5b47
	ld hl, wStoryModeNameOfMainCharacter ; $5b48
	ld a, [wStoryCharacterSlot] ; $5b4b
	or a ; $5b4e
	jr z, .zero2 ; $5b4f
	ld l, $40 ; $5b51
.zero2:
	ld a, l ; $5b53
	add $0b ; $5b54
	ld l, a ; $5b56
	ld a, h ; $5b57
	adc $00 ; $5b58
	ld h, a ; $5b5a
	pop af ; $5b5b
	ld a, [hl] ; $5b5c
	ld de, wDecompBuffer ; $5b5d
	farcall DecompressCharMugshot ; $5b60
	ld hl, wDecompBuffer ; $5b63
	ld de, $9200 + VRAM_BANK1 ; $5b66
	ld c, $03 ; $5b69
	call QueueVRAMCopy ; $5b6b
	ld hl, wDecompBuffer + 3 * TILE_SIZE ; $5b6e
	ld de, $9300 + VRAM_BANK1 ; $5b71
	ld c, $03 ; $5b74
	call QueueVRAMCopy ; $5b76
	ld hl, wDecompBuffer + 6 * TILE_SIZE ; $5b79
	ld de, $9400 + VRAM_BANK1 ; $5b7c
	ld c, $03 ; $5b7f
	call QueueVRAMCopy ; $5b81
	call BuildCharStatDisplay ; $5b84
	ld hl, CharDataConfirmScreenTilemapPatch0 ; $5b87
	ld bc, wDecompBuffer + 36 * TILE_SIZE ; $5b8a
	call ApplyTilemapPatchList ; $5b8d
	ld hl, CharDataConfirmScreenTilemapPatch1 ; $5b90
	ld bc, wDecompBuffer + 40 * TILE_SIZE ; $5b93
	call ApplyTilemapPatchList ; $5b96
	ld hl, CharDataConfirmScreenTilemapPatch2 ; $5b99
	ld bc, wDecompBuffer + 45 * TILE_SIZE ; $5b9c
	call ApplyTilemapPatchList ; $5b9f
	ld hl, CharDataConfirmScreenTilemapPatch3 ; $5ba2
	ld bc, wDecompBuffer + 49 * TILE_SIZE ; $5ba5
	call ApplyTilemapPatchList ; $5ba8
	ld hl, CharDataConfirmScreenTilemapPatch4 ; $5bab
	ld bc, wDecompBuffer + 55 * TILE_SIZE ; $5bae
	call ApplyTilemapPatchList ; $5bb1
	ld hl, CharDataConfirmScreenTilemapPatch5 ; $5bb4
	ld bc, wDecompBuffer + 85 * TILE_SIZE ; $5bb7
	call ApplyTilemapPatchList ; $5bba
	call DrawCharDataConfirmPrompt ; $5bbd
	wram_bank $03 ; $5bc0
	ld hl, wShadowTilemap ; $5bc6
	ld de, $9800 ; $5bc9
	ld c, $24 ; $5bcc
	call QueueVRAMCopy ; $5bce
	wram_bank $02 ; $5bd1
	ld hl, $d000 ; $5bd7
	ld de, $9800 + VRAM_BANK1 ; $5bda
	ld c, $24 ; $5bdd
	call QueueVRAMCopy ; $5bdf
	ret ; $5be2
InitCharDataScreenVideo:
	call ClearFrameTasks ; $5be3
	call DisableLCDSafely ; $5be6
	xor a ; $5be9
	ldh [hScrollX], a ; $5bea
	ldh [hScrollY], a ; $5bec
	ld [wCameraX], a ; $5bee
	ld [wCameraX + 1], a ; $5bf1
	ld [wCameraY], a ; $5bf4
	ld [wCameraY + 1], a ; $5bf7
	ld a, $90 ; $5bfa
	ldh [rWY], a ; $5bfc
	call ClearSpriteQueue ; $5bfe
	farcall LoadMenuFontGfx ; $5c01
	call InitDrillWorkRam ; $5c04
	call BuildCharDataScreenPages ; $5c07
	ret ; $5c0a
DrawCharDataConfirmPrompt:
	ld hl, CharDataConfirmPromptTilemapPatch ; $5c0b
	ld bc, wDecompBuffer + 88 * TILE_SIZE ; $5c0e
	call ApplyTilemapPatchList ; $5c11
	ret ; $5c14
StartCharDataValuesSyncTask:
	ld a, $01 ; $5c15
	ld hl, CharDataValuesSyncTask ; $5c17
	call RegisterFrameTask ; $5c1a
	ret ; $5c1d
StopCharDataValuesSyncTask:
	ld hl, CharDataValuesSyncTask ; $5c1e
	call UnregisterFrameTask ; $5c21
	ret ; $5c24
DrillDisplayData_1d:
	INCBIN "data/bank_01d/d_5c25.bin" ; $5c25, 9 bytes
StatPageTilemapPatch0:
	INCBIN "data/bank_01d/d_5c2e.bin" ; $5c2e, 5 bytes
CharDataSummaryPageTilemapPatch0:
	INCBIN "data/bank_01d/d_5c33.bin" ; $5c33, 53 bytes
CharDataSummaryPageTilemapPatch1:
	INCBIN "data/bank_01d/d_5c68.bin" ; $5c68, 53 bytes
CharDataSummaryPageTilemapPatch2:
	INCBIN "data/bank_01d/d_5c9d.bin" ; $5c9d, 9 bytes
StatPageTilemapPatch1:
	INCBIN "data/bank_01d/d_5ca6.bin" ; $5ca6, 21 bytes
CharDataConfirmScreenTilemapPatch0:
	INCBIN "data/bank_01d/d_5cbb.bin" ; $5cbb, 21 bytes
StatPageTilemapPatch2:
	INCBIN "data/bank_01d/d_5cd0.bin" ; $5cd0, 29 bytes
CharDataConfirmScreenTilemapPatch1:
	INCBIN "data/bank_01d/d_5ced.bin" ; $5ced, 29 bytes
StatPageTilemapPatch3:
	INCBIN "data/bank_01d/d_5d0a.bin" ; $5d0a, 21 bytes
CharDataConfirmScreenTilemapPatch2:
	INCBIN "data/bank_01d/d_5d1f.bin" ; $5d1f, 21 bytes
StatPageTilemapPatch4:
	INCBIN "data/bank_01d/d_5d34.bin" ; $5d34, 37 bytes
CharDataConfirmScreenTilemapPatch3:
	INCBIN "data/bank_01d/d_5d59.bin" ; $5d59, 37 bytes
CharDataSummaryFieldsTilePlot0:
	INCBIN "data/bank_01d/d_5d7e.bin" ; $5d7e, 19 bytes
CharDataSummaryFieldsTilePlot1:
	INCBIN "data/bank_01d/d_5d91.bin" ; $5d91, 19 bytes
MainCharStatPageTilemapPatch00:
	INCBIN "data/bank_01d/d_5da4.bin" ; $5da4, 13 bytes
PartnerStatPageTilemapPatch00:
	INCBIN "data/bank_01d/d_5db1.bin" ; $5db1, 13 bytes
CharDataConfirmScreenTilemapPatch4:
	INCBIN "data/bank_01d/d_5dbe.bin" ; $5dbe, 13 bytes
MainCharStatPageTilemapPatch01:
	INCBIN "data/bank_01d/d_5dcb.bin" ; $5dcb, 13 bytes
PartnerStatPageTilemapPatch01:
	INCBIN "data/bank_01d/d_5dd8.bin" ; $5dd8, 13 bytes
StatPageTilemapPatch5:
	INCBIN "data/bank_01d/d_5de5.bin" ; $5de5, 13 bytes
StatPageTilemapPatch6:
	INCBIN "data/bank_01d/d_5df2.bin" ; $5df2, 33 bytes
StatPageTilemapPatch7:
	INCBIN "data/bank_01d/d_5e13.bin" ; $5e13, 33 bytes
StatPageTilemapPatch8:
	INCBIN "data/bank_01d/d_5e34.bin" ; $5e34, 9 bytes
MainCharStatPageTilemapPatch02:
	INCBIN "data/bank_01d/d_5e3d.bin" ; $5e3d, 21 bytes
MainCharStatPageTilemapPatch03:
	INCBIN "data/bank_01d/d_5e52.bin" ; $5e52, 33 bytes
MainCharStatPageTilemapPatch04:
	INCBIN "data/bank_01d/d_5e73.bin" ; $5e73, 9 bytes
MainCharStatPageTilemapPatch05:
	INCBIN "data/bank_01d/d_5e7c.bin" ; $5e7c, 21 bytes
MainCharStatPageTilemapPatch06:
	INCBIN "data/bank_01d/d_5e91.bin" ; $5e91, 33 bytes
MainCharStatPageTilemapPatch07:
	INCBIN "data/bank_01d/d_5eb2.bin" ; $5eb2, 9 bytes
MainCharStatPageTilemapPatch08:
	INCBIN "data/bank_01d/d_5ebb.bin" ; $5ebb, 21 bytes
MainCharStatPageTilemapPatch09:
	INCBIN "data/bank_01d/d_5ed0.bin" ; $5ed0, 33 bytes
MainCharStatPageTilemapPatch10:
	INCBIN "data/bank_01d/d_5ef1.bin" ; $5ef1, 9 bytes
MainCharStatPageTilemapPatch11:
	INCBIN "data/bank_01d/d_5efa.bin" ; $5efa, 21 bytes
MainCharStatPageTilemapPatch12:
	INCBIN "data/bank_01d/d_5f0f.bin" ; $5f0f, 33 bytes
MainCharStatPageTilemapPatch13:
	INCBIN "data/bank_01d/d_5f30.bin" ; $5f30, 9 bytes
PartnerStatPageTilemapPatch02:
	INCBIN "data/bank_01d/d_5f39.bin" ; $5f39, 21 bytes
PartnerStatPageTilemapPatch03:
	INCBIN "data/bank_01d/d_5f4e.bin" ; $5f4e, 33 bytes
PartnerStatPageTilemapPatch04:
	INCBIN "data/bank_01d/d_5f6f.bin" ; $5f6f, 9 bytes
PartnerStatPageTilemapPatch05:
	INCBIN "data/bank_01d/d_5f78.bin" ; $5f78, 21 bytes
PartnerStatPageTilemapPatch06:
	INCBIN "data/bank_01d/d_5f8d.bin" ; $5f8d, 33 bytes
PartnerStatPageTilemapPatch07:
	INCBIN "data/bank_01d/d_5fae.bin" ; $5fae, 9 bytes
PartnerStatPageTilemapPatch08:
	INCBIN "data/bank_01d/d_5fb7.bin" ; $5fb7, 21 bytes
PartnerStatPageTilemapPatch09:
	INCBIN "data/bank_01d/d_5fcc.bin" ; $5fcc, 33 bytes
PartnerStatPageTilemapPatch10:
	INCBIN "data/bank_01d/d_5fed.bin" ; $5fed, 9 bytes
PartnerStatPageTilemapPatch11:
	INCBIN "data/bank_01d/d_5ff6.bin" ; $5ff6, 21 bytes
PartnerStatPageTilemapPatch12:
	INCBIN "data/bank_01d/d_600b.bin" ; $600b, 33 bytes
PartnerStatPageTilemapPatch13:
	INCBIN "data/bank_01d/d_602c.bin" ; $602c, 9 bytes
MainCharStatPageTilemapPatch14:
	INCBIN "data/bank_01d/d_6035.bin" ; $6035, 33 bytes
MainCharStatPageTilemapPatch15:
	INCBIN "data/bank_01d/d_6056.bin" ; $6056, 33 bytes
MainCharStatPageTilemapPatch16:
	INCBIN "data/bank_01d/d_6077.bin" ; $6077, 9 bytes
MainCharStatPageTilemapPatch17:
	INCBIN "data/bank_01d/d_6080.bin" ; $6080, 33 bytes
MainCharStatPageTilemapPatch18:
	INCBIN "data/bank_01d/d_60a1.bin" ; $60a1, 33 bytes
MainCharStatPageTilemapPatch19:
	INCBIN "data/bank_01d/d_60c2.bin" ; $60c2, 9 bytes
MainCharStatPageTilemapPatch20:
	INCBIN "data/bank_01d/d_60cb.bin" ; $60cb, 33 bytes
MainCharStatPageTilemapPatch21:
	INCBIN "data/bank_01d/d_60ec.bin" ; $60ec, 33 bytes
MainCharStatPageTilemapPatch22:
	INCBIN "data/bank_01d/d_610d.bin" ; $610d, 9 bytes
MainCharStatPageTilemapPatch23:
	INCBIN "data/bank_01d/d_6116.bin" ; $6116, 33 bytes
MainCharStatPageTilemapPatch24:
	INCBIN "data/bank_01d/d_6137.bin" ; $6137, 33 bytes
MainCharStatPageTilemapPatch25:
	INCBIN "data/bank_01d/d_6158.bin" ; $6158, 5 bytes
MainCharStatPageTilemapPatch26:
	INCBIN "data/bank_01d/d_615d.bin" ; $615d, 21 bytes
MainCharStatPageTilemapPatch27:
	INCBIN "data/bank_01d/d_6172.bin" ; $6172, 33 bytes
MainCharStatPageTilemapPatch28:
	INCBIN "data/bank_01d/d_6193.bin" ; $6193, 5 bytes
PartnerStatPageTilemapPatch14:
	INCBIN "data/bank_01d/d_6198.bin" ; $6198, 33 bytes
PartnerStatPageTilemapPatch15:
	INCBIN "data/bank_01d/d_61b9.bin" ; $61b9, 33 bytes
PartnerStatPageTilemapPatch16:
	INCBIN "data/bank_01d/d_61da.bin" ; $61da, 9 bytes
PartnerStatPageTilemapPatch17:
	INCBIN "data/bank_01d/d_61e3.bin" ; $61e3, 33 bytes
PartnerStatPageTilemapPatch18:
	INCBIN "data/bank_01d/d_6204.bin" ; $6204, 33 bytes
PartnerStatPageTilemapPatch19:
	INCBIN "data/bank_01d/d_6225.bin" ; $6225, 9 bytes
PartnerStatPageTilemapPatch20:
	INCBIN "data/bank_01d/d_622e.bin" ; $622e, 33 bytes
PartnerStatPageTilemapPatch21:
	INCBIN "data/bank_01d/d_624f.bin" ; $624f, 33 bytes
PartnerStatPageTilemapPatch22:
	INCBIN "data/bank_01d/d_6270.bin" ; $6270, 9 bytes
PartnerStatPageTilemapPatch23:
	INCBIN "data/bank_01d/d_6279.bin" ; $6279, 33 bytes
PartnerStatPageTilemapPatch24:
	INCBIN "data/bank_01d/d_629a.bin" ; $629a, 33 bytes
PartnerStatPageTilemapPatch25:
	INCBIN "data/bank_01d/d_62bb.bin" ; $62bb, 9 bytes
PartnerStatPageTilemapPatch26:
	INCBIN "data/bank_01d/d_62c4.bin" ; $62c4, 21 bytes
PartnerStatPageTilemapPatch27:
	INCBIN "data/bank_01d/d_62d9.bin" ; $62d9, 33 bytes
PartnerStatPageTilemapPatch28:
	INCBIN "data/bank_01d/d_62fa.bin" ; $62fa, 9 bytes
CharDataConfirmScreenTilemapPatch5:
	INCBIN "data/bank_01d/d_6303.bin" ; $6303, 13 bytes
CharDataConfirmPromptTilemapPatch:
	INCBIN "data/bank_01d/d_6310.bin" ; $6310, 17 bytes
CharDataScreenPageGfx00:
	INCBIN "data/bank_01d/d_6321.bin" ; $6321, 10 bytes
CharDataScreenPageGfx01:
	INCBIN "data/bank_01d/d_632b.bin" ; $632b, 9 bytes
CharDataScreenPalettes:
	INCBIN "data/bank_01d/d_6334.bin" ; $6334, 8 bytes
CharDataScreenGfx14:
	INCBIN "data/bank_01d/d_633c.bin" ; $633c, 184 bytes
CharDataScreenPageGfx02:
	INCBIN "data/bank_01d/d_63f4.bin" ; $63f4, 85 bytes
CharDataScreenPageGfx03:
	INCBIN "data/bank_01d/d_6449.bin" ; $6449, 18 bytes
CharDataScreenPageGfx04:
	INCBIN "data/bank_01d/d_645b.bin" ; $645b, 35 bytes
CharDataScreenPageGfx05:
	INCBIN "data/bank_01d/d_647e.bin" ; $647e, 7 bytes
CharDataScreenPageGfx06:
	INCBIN "data/bank_01d/d_6485.bin" ; $6485, 14 bytes
CharDataScreenPageGfx07:
	INCBIN "data/bank_01d/d_6493.bin" ; $6493, 7 bytes
CharDataScreenPageGfx08:
	INCBIN "data/bank_01d/d_649a.bin" ; $649a, 24 bytes
CharDataScreenPageGfx09:
	INCBIN "data/bank_01d/d_64b2.bin" ; $64b2, 9 bytes
CharDataScreenPageGfx10:
	INCBIN "data/bank_01d/d_64bb.bin" ; $64bb, 149 bytes
CharDataScreenPageGfx11:
	INCBIN "data/bank_01d/d_6550.bin" ; $6550, 24 bytes
CharDataScreenPageGfx12:
	INCBIN "data/bank_01d/d_6568.bin" ; $6568, 7 bytes
CharDataScreenPageGfx13:
	INCBIN "data/bank_01d/d_656f.bin" ; $656f, 117 bytes
CharDataScreenPageGfx14:
	INCBIN "data/bank_01d/d_65e4.bin" ; $65e4, 134 bytes
SpriteTemplate_1d_666a:
	; $666a, 21 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite_end
CharDataScreenPageGraphicsGfx0:
	INCBIN "data/bank_01d/d_667f.bin" ; $667f, 141 bytes
SpriteTemplate_1d_670c:
	; $670c, 21 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite_end
CharDataScreenPageGraphicsGfx1:
	INCBIN "data/bank_01d/d_6721.bin" ; $6721, 121 bytes
SpriteTemplate_1d_679a:
	; $679a, 17 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite_end
CharDataScreenPageGraphicsGfx2:
	INCBIN "data/bank_01d/d_67ab.bin" ; $67ab, 101 bytes
SpriteTemplate_1d_6810:
	; $6810, 11 bytes (sprite_template)
	oam_sprite $7f, $90, $c0, $20
	oam_sprite_end
	db $40
	db $00
	db $80
	db $00
	db $00
	db $00
SpriteTemplate_1d_681b:
	; $681b, 17 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite_end
RunExpDistributionFlow:
	wram_bank $06 ; $682c
	xor a ; $6832
	ld [wCharDataViewOnly], a ; $6833
.loop:
	call ShowExpDistributionScreen ; $6836
	wram_bank $06 ; $6839
	ld hl, wExpScreenCharStats + 6 ; $683f
	ld a, [hl+] ; $6842
	ld d, [hl] ; $6843
	ld e, a ; $6844
	xor a ; $6845
	farcall AddPlayerExp ; $6846
	ld hl, wExpScreenCharStats + 21 ; $6849
	ld a, [hl+] ; $684c
	ld d, [hl] ; $684d
	ld e, a ; $684e
	ld a, $01 ; $684f
	farcall AddPlayerExp ; $6851
.loopB:
	ld c, $00 ; $6854
	farcall CharDataScreen_Show ; $6856
	dec a ; $6859
	jr z, .loop2 ; $685a
	inc a ; $685c
	jr nz, .countLeft ; $685d
	farcall BackupCharData ; $685f
	ld c, $01 ; $6862
	farcall CharDataScreen_Show ; $6864
	dec a ; $6867
	jr z, .restoreCharData ; $6868
.countLeft:
	ld c, $01 ; $686a
	farcall CharDataScreen_Show ; $686c
	dec a ; $686f
	jr z, .countDone ; $6870
	ret ; $6872
.loop2:
	wram_bank $06 ; $6873
	ld hl, wExpScreenCharStats + 12 ; $6879
	ld de, wStoryMainCharExp ; $687c
	ld a, [hl+] ; $687f
	ld [de], a ; $6880
	inc de ; $6881
	ld a, [hl+] ; $6882
	ld [de], a ; $6883
	inc de ; $6884
	ld a, [hl] ; $6885
	ld [de], a ; $6886
	ld hl, wExpScreenCharStats + 27 ; $6887
	ld de, wStoryPartnerCharExp ; $688a
	ld a, [hl+] ; $688d
	ld [de], a ; $688e
	inc de ; $688f
	ld a, [hl+] ; $6890
	ld [de], a ; $6891
	inc de ; $6892
	ld a, [hl] ; $6893
	ld [de], a ; $6894
	ld a, $01 ; $6895
	ld [wCharDataViewOnly], a ; $6897
	jr .loop ; $689a
.restoreCharData:
	farcall RestoreCharData ; $689c
	jr .loopB ; $689f
.countDone:
	jr .loop2 ; $68a1
ShowExpDistributionScreen:
	push hl ; $68a3
	sound $0c ; $68a4
	call ClearFrameTasks ; $68a6
	call DisableLCDSafely ; $68a9
	xor a ; $68ac
	ldh [hScrollX], a ; $68ad
	ldh [hScrollY], a ; $68af
	ld [wCameraX], a ; $68b1
	ld [wCameraX + 1], a ; $68b4
	ld [wCameraY], a ; $68b7
	ld [wCameraY + 1], a ; $68ba
	ld a, $90 ; $68bd
	ldh [rWY], a ; $68bf
	call ClearSpriteQueue ; $68c1
	pop hl ; $68c4
	call InitLevelUpScreenState ; $68c5
	farcall LoadCharDataScreenGraphics ; $68c8
	call BuildExpDistributionScreen ; $68cb
	call EnableLCD ; $68ce
	call AdvanceFrame ; $68d1
	ld a, $04 ; $68d4
	ld hl, DrawExpCharCursorTask ; $68d6
	call RegisterFrameTask ; $68d9
	ld a, $04 ; $68dc
	ld hl, DrawExpBarFillMarkersTask ; $68de
	call RegisterFrameTask ; $68e1
	ld a, $01 ; $68e4
	ld hl, DrawExpBarSweepSpriteTask ; $68e6
	call RegisterFrameTask ; $68e9
	ld a, $08 ; $68ec
	ld hl, DrawExpToNextLevelTask ; $68ee
	call RegisterFrameTask ; $68f1
	xor a ; $68f4
	ld [wStoryCharacterSlot], a ; $68f5
	script_fade_in $10 ; $68f8
	call WaitFadeEnd ; $68fd
	wram_bank $06 ; $6900
	xor a ; $6906
	ld [wStoryCharacterSlot], a ; $6907
	call UpdateExpScreenSelectionPalettes ; $690a
	call AdvanceFrame ; $690d
	call RunExpDistributionLoop ; $6910
	ld c, $10 ; $6913
	call BeginFadeOut ; $6915
	call WaitFadeEnd ; $6918
	ld hl, DrawExpCharCursorTask ; $691b
	call UnregisterFrameTask ; $691e
	ld hl, DrawExpBarFillMarkersTask ; $6921
	call UnregisterFrameTask ; $6924
	ld hl, DrawExpBarSweepSpriteTask ; $6927
	call UnregisterFrameTask ; $692a
	ld hl, DrawExpToNextLevelTask ; $692d
	call UnregisterFrameTask ; $6930
	ret ; $6933
InitLevelUpScreenState:
	wram_bank $06 ; $6934
	ld a, [wCharDataViewOnly] ; $693a
	or a ; $693d
	jr nz, .nonZero ; $693e
	ld a, l ; $6940
	ld [$d14e], a ; $6941
	ld [$d150], a ; $6944
	ld a, h ; $6947
	ld [$d14f], a ; $6948
	ld [$d151], a ; $694b
	xor a ; $694e
	ld [wExpScreenCharStats + 6], a ; $694f
	ld [wExpScreenCharStats + 7], a ; $6952
	ld [wExpScreenCharStats + 21], a ; $6955
	ld [wExpScreenCharStats + 22], a ; $6958
	ld [$d186], a ; $695b
	xor a ; $695e
	ld [$d185], a ; $695f
	ld a, $08 ; $6962
	ld [$d183], a ; $6964
.nonZero:
	xor a ; $6967
	ld [$d17f], a ; $6968
	ld [$d180], a ; $696b
	ld [$d184], a ; $696e
	ld a, $a8 ; $6971
	ld [$d181], a ; $6973
	ret ; $6976
BuildExpDistributionScreen:
	call DrawExpPoolReadout ; $6977
	call InitExpScreenCharStats ; $697a
	xor a ; $697d
	ld [wStoryCharacterSlot], a ; $697e
	call DrawExpScreenLevelNumber ; $6981
	call DrawExpScreenLevelBar ; $6984
	ld a, $01 ; $6987
	ld [wStoryCharacterSlot], a ; $6989
	call DrawExpScreenLevelNumber ; $698c
	call DrawExpScreenLevelBar ; $698f
	wram_bank $01 ; $6992
	ld hl, ExpDistributionScreenGfx5 ; $6998
	ld de, wDecompBuffer + 36 * TILE_SIZE ; $699b
	call DecompressData ; $699e
	ld hl, wDecompBuffer + 36 * TILE_SIZE ; $69a1
	ld bc, $0030 ; $69a4
	call CopyWram1ToWram3ExpScreen ; $69a7
	wram_bank $01 ; $69aa
	ld hl, ExpDistributionScreenGfx6 ; $69b0
	ld de, wDecompBuffer + 36 * TILE_SIZE ; $69b3
	call DecompressData ; $69b6
	ld hl, wDecompBuffer + 36 * TILE_SIZE ; $69b9
	ld bc, $0030 ; $69bc
	call CopyWram1ToWram2ExpScreen ; $69bf
	wram_bank $01 ; $69c2
	ld hl, ExpDistributionScreenGfx7 ; $69c8
	ld de, wDecompBuffer ; $69cb
	call DecompressData ; $69ce
	ld hl, wDecompBuffer ; $69d1
	ld de, $8160 + VRAM_BANK1 ; $69d4
	ld c, $02 ; $69d7
	call QueueVRAMCopy ; $69d9
	wram_bank $01 ; $69dc
	ld hl, ExpDistributionScreenGfx2 ; $69e2
	ld de, wDecompBuffer ; $69e5
	call DecompressData ; $69e8
	ld hl, wDecompBuffer ; $69eb
	ld de, $8180 + VRAM_BANK1 ; $69ee
	ld c, $14 ; $69f1
	call QueueVRAMCopy ; $69f3
	wram_bank $01 ; $69f6
	ld hl, ExpDistributionScreenGfx3 ; $69fc
	ld de, wDecompBuffer ; $69ff
	call DecompressData ; $6a02
	ld hl, wDecompBuffer ; $6a05
	ld de, $82c0 + VRAM_BANK1 ; $6a08
	ld c, $18 ; $6a0b
	call QueueVRAMCopy ; $6a0d
	wram_bank $01 ; $6a10
	ld hl, ExpDistributionScreenGfx4 ; $6a16
	ld de, wDecompBuffer ; $6a19
	call DecompressData ; $6a1c
	ld hl, wDecompBuffer ; $6a1f
	ld de, $8440 + VRAM_BANK1 ; $6a22
	ld c, $18 ; $6a25
	call QueueVRAMCopy ; $6a27
	ld hl, ExpDistributionScreenPalettes ; $6a2a
	ld de, $0e02 ; $6a2d
	call LoadPaletteShadow ; $6a30
	wram_bank $01 ; $6a33
	ld hl, ExpDistributionScreenGfx8 ; $6a39
	ld de, wDecompBuffer ; $6a3c
	call DecompressData ; $6a3f
	ld hl, wDecompBuffer ; $6a42
	ld de, $8000 + VRAM_BANK1 ; $6a45
	ld c, $0c ; $6a48
	call QueueVRAMCopy ; $6a4a
	wram_bank $01 ; $6a4d
	ld hl, ExpDistributionScreenGfx0 ; $6a53
	ld de, wDecompBuffer ; $6a56
	call DecompressData ; $6a59
	ld hl, wDecompBuffer ; $6a5c
	ld de, $80c0 + VRAM_BANK1 ; $6a5f
	ld c, $04 ; $6a62
	call QueueVRAMCopy ; $6a64
	wram_bank $01 ; $6a67
	ld hl, ExpDistributionScreenGfx1 ; $6a6d
	ld de, wDecompBuffer ; $6a70
	call DecompressData ; $6a73
	ld hl, wDecompBuffer ; $6a76
	ld de, $8100 + VRAM_BANK1 ; $6a79
	ld c, $06 ; $6a7c
	call QueueVRAMCopy ; $6a7e
	wram_bank $03 ; $6a81
	ld hl, wShadowTilemap ; $6a87
	ld de, $9800 ; $6a8a
	ld c, $24 ; $6a8d
	call QueueVRAMCopy ; $6a8f
	wram_bank $02 ; $6a92
	ld hl, $d000 ; $6a98
	ld de, $9800 + VRAM_BANK1 ; $6a9b
	ld c, $24 ; $6a9e
	call QueueVRAMCopy ; $6aa0
	ret ; $6aa3
CopyWram1ToWram3ExpScreen:
	wram_bank $01 ; $6aa4
	ld d, [hl] ; $6aaa
	wram_bank $03 ; $6aab
	ld [hl], d ; $6ab1
	inc hl ; $6ab2
	dec bc ; $6ab3
	ld a, b ; $6ab4
	or c ; $6ab5
	jr nz, CopyWram1ToWram3ExpScreen ; $6ab6
	ret ; $6ab8
CopyWram1ToWram2ExpScreen:
	wram_bank $01 ; $6ab9
	ld d, [hl] ; $6abf
	wram_bank $02 ; $6ac0
	ld [hl], d ; $6ac6
	inc hl ; $6ac7
	dec bc ; $6ac8
	ld a, b ; $6ac9
	or c ; $6aca
	jr nz, CopyWram1ToWram2ExpScreen ; $6acb
	ret ; $6acd
DrawExpPoolReadout:
	wram_bank $06 ; $6ace
	ld hl, $d14e ; $6ad4
	ld a, [hl+] ; $6ad7
	ld h, [hl] ; $6ad8
	ld l, a ; $6ad9
	ld a, $05 ; $6ada
	ld de, wCharDataNumberBuffer ; $6adc
	call FormatDecimalNumberUnsigned ; $6adf
	ld hl, wCharDataNumberBuffer ; $6ae2
	ld de, $d201 ; $6ae5
	call WriteExpScreenStringTiles ; $6ae8
	call DrawExpPoolGauge ; $6aeb
	ret ; $6aee
DrawExpPoolGauge:
	wram_bank $06 ; $6aef
	ld hl, $d14e ; $6af5
	ld a, [hl+] ; $6af8
	ld d, [hl] ; $6af9
	ld e, a ; $6afa
	ld hl, $d150 ; $6afb
	ld a, [hl+] ; $6afe
	ld h, [hl] ; $6aff
	ld l, a ; $6b00
	bit 7, h ; $6b01
	jr z, .positive ; $6b03
	srl h ; $6b05
	rr l ; $6b07
	srl d ; $6b09
	rr e ; $6b0b
.positive:
	ld b, $58 ; $6b0d
	call ScaleValueToBar ; $6b0f
	ld de, wExpScreenCharStats ; $6b12
	ld b, a ; $6b15
	ld c, $0b ; $6b16
	wram_bank $03 ; $6b18
.loop:
	ld a, b ; $6b1e
	sub $08 ; $6b1f
	jr c, .carry ; $6b21
	ld b, a ; $6b23
	ld a, $08 ; $6b24
	rlca ; $6b26
	add LOW(TilePairTable_1d_6b69) ; $6b27
	ld l, a ; $6b29
	adc HIGH(TilePairTable_1d_6b69) ; $6b2a
	sub l ; $6b2c
	ld h, a ; $6b2d
	ld a, [hl+] ; $6b2e
	ld [de], a ; $6b2f
	inc de ; $6b30
	ld a, [hl] ; $6b31
	ld [de], a ; $6b32
	dec de ; $6b33
	dec c ; $6b34
	ret z ; $6b35
	call ExpGaugePtrUpOneRow ; $6b36
	jr .loop ; $6b39
.carry:
	add $08 ; $6b3b
	rlca ; $6b3d
	add LOW(TilePairTable_1d_6b69) ; $6b3e
	ld l, a ; $6b40
	adc HIGH(TilePairTable_1d_6b69) ; $6b41
	sub l ; $6b43
	ld h, a ; $6b44
	ld a, [hl+] ; $6b45
	ld [de], a ; $6b46
	inc de ; $6b47
	ld a, [hl] ; $6b48
	ld [de], a ; $6b49
	dec de ; $6b4a
	dec c ; $6b4b
	ret z ; $6b4c
	call ExpGaugePtrUpOneRow ; $6b4d
.loopB:
	ld hl, TilePairTable_1d_6b69 ; $6b50
	ld a, [hl+] ; $6b53
	ld [de], a ; $6b54
	inc de ; $6b55
	ld a, [hl] ; $6b56
	ld [de], a ; $6b57
	dec de ; $6b58
	dec c ; $6b59
	ret z ; $6b5a
	call ExpGaugePtrUpOneRow ; $6b5b
	jr .loopB ; $6b5e
ExpGaugePtrUpOneRow:
	push bc ; $6b60
	ld c, $20 ; $6b61
.loop:
	dec de ; $6b63
	dec c ; $6b64
	jr nz, .loop ; $6b65
	pop bc ; $6b67
	ret ; $6b68
TilePairTable_1d_6b69:
	; $6b69, 18 bytes (bytes:2)
	db $11, $32 ; 0x00
	db $07, $08 ; 0x02
	db $25, $26 ; 0x04
	db $15, $16 ; 0x06
	db $05, $06 ; 0x08
	db $23, $24 ; 0x0a
	db $13, $14 ; 0x0c
	db $03, $04 ; 0x0e
	db $03, $04 ; 0x10
InitExpScreenCharStats:
	wram_bank $06 ; $6b7b
	ld a, [wCharDataViewOnly] ; $6b81
	or a ; $6b84
	jp nz, .clearStoryCharacterSlot ; $6b85
	xor a ; $6b88
	ld [wStoryCharacterSlot], a ; $6b89
	push af ; $6b8c
	ld hl, wStoryModeNameOfMainCharacter ; $6b8d
	ld a, [wStoryCharacterSlot] ; $6b90
	or a ; $6b93
	jr z, .zero ; $6b94
	ld l, $40 ; $6b96
.zero:
	ld a, l ; $6b98
	add $00 ; $6b99
	ld l, a ; $6b9b
	ld a, h ; $6b9c
	adc $00 ; $6b9d
	ld h, a ; $6b9f
	pop af ; $6ba0
	ld de, $d0ec ; $6ba1
	ld c, $20 ; $6ba4
	call WriteExpScreenStringTiles ; $6ba6
	wram_bank $06 ; $6ba9
	push af ; $6baf
	ld hl, wStoryModeNameOfMainCharacter ; $6bb0
	ld a, [wStoryCharacterSlot] ; $6bb3
	or a ; $6bb6
	jr z, .zero2 ; $6bb7
	ld l, $40 ; $6bb9
.zero2:
	ld a, l ; $6bbb
	add $18 ; $6bbc
	ld l, a ; $6bbe
	ld a, h ; $6bbf
	adc $00 ; $6bc0
	ld h, a ; $6bc2
	pop af ; $6bc3
	ld a, [hl] ; $6bc4
	push af ; $6bc5
	inc a ; $6bc6
	ld de, wExpScreenCharStats ; $6bc7
	ld [de], a ; $6bca
	dec a ; $6bcb
	ld h, $00 ; $6bcc
	ld l, a ; $6bce
	ld a, $02 ; $6bcf
	ld de, wCharDataNumberBuffer ; $6bd1
	call FormatDecimalNumberUnsigned ; $6bd4
	ld de, wCharDataChoiceLog + 65 ; $6bd7
	farcall CharDataScreen_WriteStatNumber ; $6bda
	wram_bank $06 ; $6bdd
	pop af ; $6be3
	farcall GetExpRequiredForLevel ; $6be4
	ld a, l ; $6be7
	ld [wExpScreenCharStats + 1], a ; $6be8
	ld a, h ; $6beb
	ld [wExpScreenCharStats + 2], a ; $6bec
	xor a ; $6bef
	farcall GetExpProgressInCurrentLevel ; $6bf0
	ld a, l ; $6bf3
	ld [wExpScreenCharStats + 4], a ; $6bf4
	ld a, h ; $6bf7
	ld [wExpScreenCharStats + 5], a ; $6bf8
	xor a ; $6bfb
	farcall GetExpRemainingToNextLevel ; $6bfc
	ld a, l ; $6bff
	ld [wExpScreenCharStats + 8], a ; $6c00
	ld a, h ; $6c03
	ld [wExpScreenCharStats + 9], a ; $6c04
	push af ; $6c07
	ld hl, wStoryModeNameOfMainCharacter ; $6c08
	ld a, [wStoryCharacterSlot] ; $6c0b
	or a ; $6c0e
	jr z, .zero3 ; $6c0f
	ld l, $40 ; $6c11
.zero3:
	ld a, l ; $6c13
	add $2c ; $6c14
	ld l, a ; $6c16
	ld a, h ; $6c17
	adc $00 ; $6c18
	ld h, a ; $6c1a
	pop af ; $6c1b
	ld a, [hl+] ; $6c1c
	ld [wExpScreenCharStats + 12], a ; $6c1d
	ld a, [hl+] ; $6c20
	ld [wExpScreenCharStats + 13], a ; $6c21
	ld a, [hl] ; $6c24
	ld [wExpScreenCharStats + 14], a ; $6c25
	ld a, $01 ; $6c28
	ld [wStoryCharacterSlot], a ; $6c2a
	push af ; $6c2d
	ld hl, wStoryModeNameOfMainCharacter ; $6c2e
	ld a, [wStoryCharacterSlot] ; $6c31
	or a ; $6c34
	jr z, .zero4 ; $6c35
	ld l, $40 ; $6c37
.zero4:
	ld a, l ; $6c39
	add $00 ; $6c3a
	ld l, a ; $6c3c
	ld a, h ; $6c3d
	adc $00 ; $6c3e
	ld h, a ; $6c40
	pop af ; $6c41
	ld de, $d20c ; $6c42
	ld c, $20 ; $6c45
	call WriteExpScreenStringTiles ; $6c47
	wram_bank $06 ; $6c4a
	push af ; $6c50
	ld hl, wStoryModeNameOfMainCharacter ; $6c51
	ld a, [wStoryCharacterSlot] ; $6c54
	or a ; $6c57
	jr z, .zero5 ; $6c58
	ld l, $40 ; $6c5a
.zero5:
	ld a, l ; $6c5c
	add $18 ; $6c5d
	ld l, a ; $6c5f
	ld a, h ; $6c60
	adc $00 ; $6c61
	ld h, a ; $6c63
	pop af ; $6c64
	ld a, [hl] ; $6c65
	push af ; $6c66
	inc a ; $6c67
	ld de, wExpScreenCharStats + 15 ; $6c68
	ld [de], a ; $6c6b
	dec a ; $6c6c
	ld h, $00 ; $6c6d
	ld l, a ; $6c6f
	ld a, $02 ; $6c70
	ld de, wCharDataNumberBuffer ; $6c72
	call FormatDecimalNumberUnsigned ; $6c75
	ld de, $d18b ; $6c78
	farcall CharDataScreen_WriteStatNumber ; $6c7b
	wram_bank $06 ; $6c7e
	pop af ; $6c84
	farcall GetExpRequiredForLevel ; $6c85
	ld a, l ; $6c88
	ld [wExpScreenCharStats + 16], a ; $6c89
	ld a, h ; $6c8c
	ld [wExpScreenCharStats + 17], a ; $6c8d
	ld a, $01 ; $6c90
	farcall GetExpProgressInCurrentLevel ; $6c92
	ld a, l ; $6c95
	ld [wExpScreenCharStats + 19], a ; $6c96
	ld a, h ; $6c99
	ld [wExpScreenCharStats + 20], a ; $6c9a
	ld a, $01 ; $6c9d
	farcall GetExpRemainingToNextLevel ; $6c9f
	ld a, l ; $6ca2
	ld [wExpScreenCharStats + 23], a ; $6ca3
	ld a, h ; $6ca6
	ld [wExpScreenCharStats + 24], a ; $6ca7
	push af ; $6caa
	ld hl, wStoryModeNameOfMainCharacter ; $6cab
	ld a, [wStoryCharacterSlot] ; $6cae
	or a ; $6cb1
	jr z, .zero6 ; $6cb2
	ld l, $40 ; $6cb4
.zero6:
	ld a, l ; $6cb6
	add $2c ; $6cb7
	ld l, a ; $6cb9
	ld a, h ; $6cba
	adc $00 ; $6cbb
	ld h, a ; $6cbd
	pop af ; $6cbe
	ld a, [hl+] ; $6cbf
	ld [wExpScreenCharStats + 27], a ; $6cc0
	ld a, [hl+] ; $6cc3
	ld [wExpScreenCharStats + 28], a ; $6cc4
	ld a, [hl] ; $6cc7
	ld [wExpScreenCharStats + 29], a ; $6cc8
	ret ; $6ccb
.clearStoryCharacterSlot:
	xor a ; $6ccc
	ld [wStoryCharacterSlot], a ; $6ccd
	push af ; $6cd0
	ld hl, wStoryModeNameOfMainCharacter ; $6cd1
	ld a, [wStoryCharacterSlot] ; $6cd4
	or a ; $6cd7
	jr z, .zero7 ; $6cd8
	ld l, $40 ; $6cda
.zero7:
	ld a, l ; $6cdc
	add $00 ; $6cdd
	ld l, a ; $6cdf
	ld a, h ; $6ce0
	adc $00 ; $6ce1
	ld h, a ; $6ce3
	pop af ; $6ce4
	ld de, $d0ec ; $6ce5
	ld c, $20 ; $6ce8
	call WriteExpScreenStringTiles ; $6cea
	wram_bank $06 ; $6ced
	push af ; $6cf3
	ld hl, wStoryModeNameOfMainCharacter ; $6cf4
	ld a, [wStoryCharacterSlot] ; $6cf7
	or a ; $6cfa
	jr z, .zero8 ; $6cfb
	ld l, $40 ; $6cfd
.zero8:
	ld a, l ; $6cff
	add $18 ; $6d00
	ld l, a ; $6d02
	ld a, h ; $6d03
	adc $00 ; $6d04
	ld h, a ; $6d06
	pop af ; $6d07
	ld a, [hl] ; $6d08
	ld h, $00 ; $6d09
	ld l, a ; $6d0b
	ld a, $02 ; $6d0c
	ld de, wCharDataNumberBuffer ; $6d0e
	call FormatDecimalNumberUnsigned ; $6d11
	ld de, wCharDataChoiceLog + 65 ; $6d14
	farcall CharDataScreen_WriteStatNumber ; $6d17
	ld a, $01 ; $6d1a
	ld [wStoryCharacterSlot], a ; $6d1c
	push af ; $6d1f
	ld hl, wStoryModeNameOfMainCharacter ; $6d20
	ld a, [wStoryCharacterSlot] ; $6d23
	or a ; $6d26
	jr z, .zero9 ; $6d27
	ld l, $40 ; $6d29
.zero9:
	ld a, l ; $6d2b
	add $00 ; $6d2c
	ld l, a ; $6d2e
	ld a, h ; $6d2f
	adc $00 ; $6d30
	ld h, a ; $6d32
	pop af ; $6d33
	ld de, $d20c ; $6d34
	ld c, $20 ; $6d37
	call WriteExpScreenStringTiles ; $6d39
	wram_bank $06 ; $6d3c
	push af ; $6d42
	ld hl, wStoryModeNameOfMainCharacter ; $6d43
	ld a, [wStoryCharacterSlot] ; $6d46
	or a ; $6d49
	jr z, .zero10 ; $6d4a
	ld l, $40 ; $6d4c
.zero10:
	ld a, l ; $6d4e
	add $18 ; $6d4f
	ld l, a ; $6d51
	ld a, h ; $6d52
	adc $00 ; $6d53
	ld h, a ; $6d55
	pop af ; $6d56
	ld a, [hl] ; $6d57
	ld h, $00 ; $6d58
	ld l, a ; $6d5a
	ld a, $02 ; $6d5b
	ld de, wCharDataNumberBuffer ; $6d5d
	call FormatDecimalNumberUnsigned ; $6d60
	ld de, $d18b ; $6d63
	farcall CharDataScreen_WriteStatNumber ; $6d66
	ret ; $6d69
WriteExpScreenStringTiles:
	wram_bank $06 ; $6d6a
	ld a, [hl+] ; $6d70
	or a ; $6d71
	ret z ; $6d72
	cp $de ; $6d73
	jr z, .rowAbove ; $6d75
	cp $df ; $6d77
	jr z, .rowAbove ; $6d79
	ld b, a ; $6d7b
	wram_bank $03 ; $6d7c
	ld a, b ; $6d82
	ld [de], a ; $6d83
	wram_bank $02 ; $6d84
	xor a ; $6d8a
	ld [de], a ; $6d8b
	inc de ; $6d8c
	jr WriteExpScreenStringTiles ; $6d8d
.rowAbove:
	call ExpScreenTilePtrUpOneRow ; $6d8f
	ld b, a ; $6d92
	wram_bank $03 ; $6d93
	ld a, [de] ; $6d99
	cp $73 ; $6d9a
	jr z, .statLabel ; $6d9c
	cp $8f ; $6d9e
	jr z, .statLabel ; $6da0
	jr .plainTile ; $6da2
.statLabel:
	push bc ; $6da4
	ld a, b ; $6da5
	sub $7e ; $6da6
	ld b, a ; $6da8
	ld c, $0f ; $6da9
	ld a, [wStoryCharacterSlot] ; $6dab
	or a ; $6dae
	jr z, .plainTile ; $6daf
	inc b ; $6db1
	inc b ; $6db2
	ld c, $0c ; $6db3
	ld a, b ; $6db5
	ld [de], a ; $6db6
	wram_bank $02 ; $6db7
	ld a, c ; $6dbd
	ld [de], a ; $6dbe
	pop bc ; $6dbf
	call ExpScreenTilePtrDownOneRow ; $6dc0
	jr WriteExpScreenStringTiles ; $6dc3
.plainTile:
	ld a, b ; $6dc5
	ld [de], a ; $6dc6
	wram_bank $02 ; $6dc7
	ld a, c ; $6dcd
	ld [de], a ; $6dce
	pop bc ; $6dcf
	call ExpScreenTilePtrDownOneRow ; $6dd0
	jr WriteExpScreenStringTiles ; $6dd3
ExpScreenTilePtrUpOneRow:
	push bc ; $6dd5
	ld c, $20 ; $6dd6
.loop:
	dec de ; $6dd8
	dec c ; $6dd9
	jr nz, .loop ; $6dda
	dec de ; $6ddc
	pop bc ; $6ddd
	ret ; $6dde
ExpScreenTilePtrDownOneRow:
	ld a, $21 ; $6ddf
	add e ; $6de1
	ld e, a ; $6de2
	jr nc, .done ; $6de3
	inc d ; $6de5
.done:
	ret ; $6de6
DrawExpScreenLevelNumber:
	wram_bank $06 ; $6de7
	ld a, [wStoryCharacterSlot] ; $6ded
	or a ; $6df0
	jr nz, .nonZero ; $6df1
	ld a, [wExpScreenCharStats] ; $6df3
	ld de, wCharDataNumberBuffer + 3 ; $6df6
	jr .clearExpScreenLevelDigits ; $6df9
.nonZero:
	ld a, [wExpScreenCharStats + 15] ; $6dfb
	ld de, $d1b1 ; $6dfe
.clearExpScreenLevelDigits:
	call ClearExpScreenLevelDigits ; $6e01
	cp $64 ; $6e04
	jr nc, .ge64 ; $6e06
	push de ; $6e08
	ld h, $00 ; $6e09
	ld l, a ; $6e0b
	ld a, $02 ; $6e0c
	ld de, wCharDataNumberBuffer ; $6e0e
	call FormatDecimalNumberUnsigned ; $6e11
	pop de ; $6e14
	ld hl, wCharDataNumberBuffer ; $6e15
	ld a, [hl] ; $6e18
	cp $20 ; $6e19
	jr z, .eq20 ; $6e1b
	call DrawExpScreenLevelDigit ; $6e1d
.eq20:
	inc de ; $6e20
	inc hl ; $6e21
	ld a, [hl] ; $6e22
	call DrawExpScreenLevelDigit ; $6e23
	ret ; $6e26
.ge64:
	wram_bank $03 ; $6e27
	ld h, d ; $6e2d
	ld l, e ; $6e2e
	dec hl ; $6e2f
	dec hl ; $6e30
	ld a, $9c ; $6e31
	ld [hl+], a ; $6e33
	inc a ; $6e34
	ld [hl+], a ; $6e35
	inc a ; $6e36
	ld [hl+], a ; $6e37
	inc a ; $6e38
	ld [hl], a ; $6e39
	ld a, $1d ; $6e3a
	add l ; $6e3c
	ld l, a ; $6e3d
	jr nc, .gotPtr ; $6e3e
	inc h ; $6e40
.gotPtr:
	ld a, $ac ; $6e41
	ld [hl+], a ; $6e43
	inc a ; $6e44
	ld [hl+], a ; $6e45
	inc a ; $6e46
	ld [hl+], a ; $6e47
	inc a ; $6e48
	ld [hl], a ; $6e49
	wram_bank $06 ; $6e4a
	ret ; $6e50
DrawExpScreenLevelDigit:
	sub $30 ; $6e51
	add $66 ; $6e53
	ld b, a ; $6e55
	wram_bank $03 ; $6e56
	ld a, b ; $6e5c
	ld [de], a ; $6e5d
	push de ; $6e5e
	ld a, $10 ; $6e5f
	add b ; $6e61
	ld b, a ; $6e62
	ld a, $20 ; $6e63
	add e ; $6e65
	ld e, a ; $6e66
	jr nc, .gotPtr ; $6e67
	inc d ; $6e69
.gotPtr:
	ld a, b ; $6e6a
	ld [de], a ; $6e6b
	pop de ; $6e6c
	wram_bank $06 ; $6e6d
	ret ; $6e73
ClearExpScreenLevelDigits:
	push af ; $6e74
	push de ; $6e75
	wram_bank $03 ; $6e76
	ld h, d ; $6e7c
	ld l, e ; $6e7d
	dec hl ; $6e7e
	dec hl ; $6e7f
	ld a, $64 ; $6e80
	ld [hl+], a ; $6e82
	inc a ; $6e83
	ld [hl+], a ; $6e84
	ld a, $65 ; $6e85
	ld [hl+], a ; $6e87
	ld [hl], a ; $6e88
	ld a, $1d ; $6e89
	add l ; $6e8b
	ld l, a ; $6e8c
	jr nc, .gotPtr ; $6e8d
	inc h ; $6e8f
.gotPtr:
	ld a, $74 ; $6e90
	ld [hl+], a ; $6e92
	inc a ; $6e93
	ld [hl+], a ; $6e94
	ld a, $51 ; $6e95
	ld [hl+], a ; $6e97
	ld [hl], a ; $6e98
	wram_bank $06 ; $6e99
	pop de ; $6e9f
	pop af ; $6ea0
	ret ; $6ea1
DrawExpScreenLevelBar:
	wram_bank $06 ; $6ea2
	ld a, [wStoryCharacterSlot] ; $6ea8
	or a ; $6eab
	jr nz, .nonZero ; $6eac
	ld a, [wExpScreenCharStats] ; $6eae
	cp $64 ; $6eb1
	jr c, .lt64 ; $6eb3
	xor a ; $6eb5
	ld [wExpScreenCharStats + 3], a ; $6eb6
	ld de, wCharDataRevealStep ; $6eb9
	jr .step4 ; $6ebc
.lt64:
	ld hl, wExpScreenCharStats + 4 ; $6ebe
	ld a, [hl+] ; $6ec1
	ld d, [hl] ; $6ec2
	ld e, a ; $6ec3
	ld hl, wExpScreenCharStats + 1 ; $6ec4
	ld a, [hl+] ; $6ec7
	ld h, [hl] ; $6ec8
	ld l, a ; $6ec9
	ld b, $40 ; $6eca
	call ScaleValueToBar ; $6ecc
	ld [wExpScreenCharStats + 3], a ; $6ecf
	ld de, wCharDataRevealStep ; $6ed2
	jr .step4 ; $6ed5
.nonZero:
	ld a, [wExpScreenCharStats + 15] ; $6ed7
	cp $64 ; $6eda
	jr c, .lt642 ; $6edc
	xor a ; $6ede
	ld [wExpScreenCharStats + 18], a ; $6edf
	ld de, wCharDataValuesSlideX ; $6ee2
	jr .step4 ; $6ee5
.lt642:
	ld hl, wExpScreenCharStats + 19 ; $6ee7
	ld a, [hl+] ; $6eea
	ld d, [hl] ; $6eeb
	ld e, a ; $6eec
	ld hl, wExpScreenCharStats + 16 ; $6eed
	ld a, [hl+] ; $6ef0
	ld h, [hl] ; $6ef1
	ld l, a ; $6ef2
	ld b, $40 ; $6ef3
	call ScaleValueToBar ; $6ef5
	ld [wExpScreenCharStats + 18], a ; $6ef8
	ld de, wCharDataValuesSlideX ; $6efb
.step4:
	ld b, a ; $6efe
	ld c, $08 ; $6eff
	wram_bank $03 ; $6f01
.loop:
	ld a, b ; $6f07
	sub $08 ; $6f08
	jr c, .carry ; $6f0a
	ld b, a ; $6f0c
	ld a, $08 ; $6f0d
	add LOW(ExpBarFillTiles_1d) ; $6f0f
	ld l, a ; $6f11
	adc HIGH(ExpBarFillTiles_1d) ; $6f12
	sub l ; $6f14
	ld h, a ; $6f15
	ld a, [hl] ; $6f16
	ld [de], a ; $6f17
	dec c ; $6f18
	ret z ; $6f19
	inc de ; $6f1a
	jr .loop ; $6f1b
.carry:
	add $08 ; $6f1d
	add LOW(ExpBarFillTiles_1d) ; $6f1f
	ld l, a ; $6f21
	adc HIGH(ExpBarFillTiles_1d) ; $6f22
	sub l ; $6f24
	ld h, a ; $6f25
	ld a, [hl] ; $6f26
	ld [de], a ; $6f27
	dec c ; $6f28
	ret z ; $6f29
	inc de ; $6f2a
.loopB:
	ld hl, ExpBarFillTiles_1d ; $6f2b
	ld a, [hl] ; $6f2e
	ld [de], a ; $6f2f
	inc de ; $6f30
	dec c ; $6f31
	ret z ; $6f32
	jr .loopB ; $6f33
ExpBarFillTiles_1d:
	; $6f35, 9 bytes (bytes:9)
	db $0d, $1d, $2d, $0e, $1e, $2e, $0f, $1f, $2f ; 0x00
RunExpDistributionLoop:
	wram_bank $06 ; $6f3e
	ld a, [wCharDataViewOnly] ; $6f44
	or a ; $6f47
	jr z, .tick ; $6f48
	xor a ; $6f4a
	ld [wCharDataViewOnly], a ; $6f4b
	jp CheckExpLevelDown.step2 ; $6f4e
.tick:
	wram_bank $06 ; $6f51
	ld a, [$d185] ; $6f57
	and $08 ; $6f5a
	or a ; $6f5c
	jr z, .checkRepeat ; $6f5d
	ld a, [$d183] ; $6f5f
	or a ; $6f62
	jr z, .checkRepeat ; $6f63
	dec a ; $6f65
	ld [$d183], a ; $6f66
	xor a ; $6f69
	ld [$d185], a ; $6f6a
.checkRepeat:
	ld a, [$d184] ; $6f6d
	or a ; $6f70
	jr z, .frame ; $6f71
	dec a ; $6f73
	ld [$d184], a ; $6f74
.frame:
	call TickLevelUpJingle ; $6f77
	call UploadExpScreenTilemapRows ; $6f7a
	call AdvanceFrame ; $6f7d
	ldh a, [hPlayerInputFlags] ; $6f80
	bit PADB_B, a ; $6f82
	jr z, .checkButtons ; $6f84
	push af ; $6f86
	wram_bank $06 ; $6f87
	xor a ; $6f8d
	ld [$d184], a ; $6f8e
	pop af ; $6f91
.checkButtons:
	bit 5, a ; $6f92
	jp nz, .decrease ; $6f94
	bit 4, a ; $6f97
	jp nz, .increase ; $6f99
	bit 0, a ; $6f9c
	jp nz, .increase ; $6f9e
	wram_bank $06 ; $6fa1
	ld a, $a8 ; $6fa7
	ld [$d181], a ; $6fa9
	ld a, $08 ; $6fac
	ld [$d183], a ; $6fae
	xor a ; $6fb1
	ld [$d185], a ; $6fb2
	ld hl, $d17f ; $6fb5
	res 1, [hl] ; $6fb8
	ldh a, [hInputRisingEdge] ; $6fba
	bit PADB_UP, a ; $6fbc
	jr nz, .selectMainChar ; $6fbe
	bit 7, a ; $6fc0
	jr nz, .selectPartner ; $6fc2
	jp RunExpDistributionLoop ; $6fc4
.selectMainChar:
	wram_bank $06 ; $6fc7
	ld a, [wStoryCharacterSlot] ; $6fcd
	or a ; $6fd0
	jp z, RunExpDistributionLoop ; $6fd1
	sound $5e ; $6fd4
	xor a ; $6fd6
	ld [wStoryCharacterSlot], a ; $6fd7
	call UpdateExpScreenSelectionPalettes ; $6fda
	ld hl, SlideExpCursorToPartnerTask ; $6fdd
	call UnregisterFrameTask ; $6fe0
	ld a, $01 ; $6fe3
	ld hl, SlideExpCursorToMainCharTask ; $6fe5
	call RegisterFrameTask ; $6fe8
	ld hl, $d17f ; $6feb
	set 0, [hl] ; $6fee
	jp RunExpDistributionLoop ; $6ff0
.selectPartner:
	wram_bank $06 ; $6ff3
	ld a, [wStoryCharacterSlot] ; $6ff9
	or a ; $6ffc
	jp nz, RunExpDistributionLoop ; $6ffd
	sound $5e ; $7000
	ld a, $01 ; $7002
	ld [wStoryCharacterSlot], a ; $7004
	call UpdateExpScreenSelectionPalettes ; $7007
	ld hl, SlideExpCursorToMainCharTask ; $700a
	call UnregisterFrameTask ; $700d
	ld a, $01 ; $7010
	ld hl, SlideExpCursorToPartnerTask ; $7012
	call RegisterFrameTask ; $7015
	ld hl, $d17f ; $7018
	set 0, [hl] ; $701b
	jp RunExpDistributionLoop ; $701d
.decrease:
	wram_bank $06 ; $7020
	ld a, [$d17f] ; $7026
	bit 0, a ; $7029
	jp nz, RunExpDistributionLoop ; $702b
	ld hl, $d185 ; $702e
	inc [hl] ; $7031
	ld a, [$d184] ; $7032
	or a ; $7035
	jr nz, .decreaseRepeat ; $7036
	call UnassignExpPointFromChar ; $7038
	or a ; $703b
	jr z, .decreaseFailed ; $703c
	sound $62 ; $703e
	wram_bank $06 ; $7040
	ld a, [$d183] ; $7046
	or a ; $7049
	jr nz, .applyDecrease ; $704a
	call UnassignExpPointFromChar ; $704c
.applyDecrease:
	ld hl, $d17f ; $704f
	set 1, [hl] ; $7052
	ld a, [$d183] ; $7054
	ld [$d184], a ; $7057
	call RefreshExpScreenReadouts ; $705a
	call SweepExpBarMarkerLeft ; $705d
	jp RunExpDistributionLoop ; $7060
.decreaseFailed:
	ld hl, $d17f ; $7063
	res 1, [hl] ; $7066
	ld a, $a8 ; $7068
	ld [$d181], a ; $706a
	jp RunExpDistributionLoop ; $706d
.decreaseRepeat:
	call SweepExpBarMarkerLeft ; $7070
	jp RunExpDistributionLoop ; $7073
.increase:
	wram_bank $06 ; $7076
	ld a, [$d17f] ; $707c
	bit 0, a ; $707f
	jp nz, RunExpDistributionLoop ; $7081
	ld hl, $d185 ; $7084
	inc [hl] ; $7087
	ld a, [$d184] ; $7088
	or a ; $708b
	jr nz, .increaseRepeat ; $708c
	call AssignExpPointToChar ; $708e
	or a ; $7091
	jr z, .increaseFailed ; $7092
	sound $5f ; $7094
	wram_bank $06 ; $7096
	ld a, [$d183] ; $709c
	or a ; $709f
	jr nz, .applyIncrease ; $70a0
	call AssignExpPointToChar ; $70a2
.applyIncrease:
	ld hl, $d17f ; $70a5
	set 1, [hl] ; $70a8
	ld a, [$d183] ; $70aa
	ld [$d184], a ; $70ad
	call RefreshExpScreenReadouts ; $70b0
	call SweepExpBarMarkerRight ; $70b3
	jp RunExpDistributionLoop ; $70b6
.increaseFailed:
	ld hl, $d17f ; $70b9
	res 1, [hl] ; $70bc
	ld a, $a8 ; $70be
	ld [$d181], a ; $70c0
	jp CheckExpLevelDown.step2 ; $70c3
.increaseRepeat:
	call SweepExpBarMarkerRight ; $70c6
	jp RunExpDistributionLoop ; $70c9
SlideExpCursorToMainCharTask:
	wram_bank $06 ; $70cc
	ld a, [$d180] ; $70d2
	dec a ; $70d5
	ld [$d180], a ; $70d6
	ret nz ; $70d9
	ld hl, $d17f ; $70da
	res 0, [hl] ; $70dd
	ld hl, SlideExpCursorToMainCharTask ; $70df
	call UnregisterFrameTask ; $70e2
	ret ; $70e5
SlideExpCursorToPartnerTask:
	wram_bank $06 ; $70e6
	ld a, [$d180] ; $70ec
	inc a ; $70ef
	ld [$d180], a ; $70f0
	cp $18 ; $70f3
	ret nz ; $70f5
	ld hl, $d17f ; $70f6
	res 0, [hl] ; $70f9
	ld hl, SlideExpCursorToPartnerTask ; $70fb
	call UnregisterFrameTask ; $70fe
	ret ; $7101
SweepExpBarMarkerLeft:
	call GetExpBarSweepStep ; $7102
	wram_bank $06 ; $7105
	ld a, [$d181] ; $710b
	cp $a8 ; $710e
	jr z, .checkStoryCharacterSlot ; $7110
	sub b ; $7112
	ld [$d181], a ; $7113
	cp $18 ; $7116
	ret nc ; $7118
	ld a, $a8 ; $7119
	ld [$d181], a ; $711b
	ret ; $711e
.checkStoryCharacterSlot:
	ld a, [wStoryCharacterSlot] ; $711f
	or a ; $7122
	jr nz, .nonZero ; $7123
	ld a, [wExpScreenCharStats + 3] ; $7125
	jr .getExpBarSweepStep ; $7128
.nonZero:
	ld a, [wExpScreenCharStats + 18] ; $712a
.getExpBarSweepStep:
	add $36 ; $712d
	ld [$d181], a ; $712f
	ret ; $7132
SweepExpBarMarkerRight:
	call GetExpBarSweepStep ; $7133
	wram_bank $06 ; $7136
	ld a, [$d181] ; $713c
	cp $a8 ; $713f
	jr z, .eqa8 ; $7141
	add b ; $7143
	ld [$d181], a ; $7144
	ld b, a ; $7147
	ld a, [wStoryCharacterSlot] ; $7148
	or a ; $714b
	jr nz, .nonZero ; $714c
	ld a, [wExpScreenCharStats + 3] ; $714e
	jr .step2 ; $7151
.nonZero:
	ld a, [wExpScreenCharStats + 18] ; $7153
.step2:
	add $36 ; $7156
	ld c, a ; $7158
	ld a, b ; $7159
	cp c ; $715a
	ret c ; $715b
	ld a, $a8 ; $715c
	ld [$d181], a ; $715e
	ret ; $7161
.eqa8:
	ld a, $18 ; $7162
	ld [$d181], a ; $7164
	ret ; $7167
GetExpBarSweepStep:
	wram_bank $06 ; $7168
	ld a, [wStoryCharacterSlot] ; $716e
	or a ; $7171
	jr nz, .nonZero ; $7172
	ld a, [wExpScreenCharStats + 3] ; $7174
	jr .step2 ; $7177
.nonZero:
	ld a, [wExpScreenCharStats + 18] ; $7179
.step2:
	add $18 ; $717c
	srl a ; $717e
	srl a ; $7180
	srl a ; $7182
	srl a ; $7184
	inc a ; $7186
	ld b, a ; $7187
	ret ; $7188
UpdateExpScreenSelectionPalettes:
	ld a, [wStoryModeMainCharacterOverworldSpriteColor] ; $7189
	ld de, $0101 ; $718c
	farcall LoadIndexedPaletteThunk ; $718f
	ld a, [wStoryModePartnerCharacterOverworldSpriteColor] ; $7192
	ld de, $0201 ; $7195
	farcall LoadIndexedPaletteThunk ; $7198
	wram_bank $06 ; $719b
	ld a, [wExpScreenCharStats + 10] ; $71a1
	ld [wBGPalettes + 58], a ; $71a4
	ld a, [wExpScreenCharStats + 11] ; $71a7
	ld [wBGPalettes + 59], a ; $71aa
	ld a, [wExpScreenCharStats + 25] ; $71ad
	ld [wBGPalettes + 34], a ; $71b0
	ld a, [wExpScreenCharStats + 26] ; $71b3
	ld [wBGPalettes + 35], a ; $71b6
	ld a, [wStoryCharacterSlot] ; $71b9
	or a ; $71bc
	jr nz, .grayOut ; $71bd
	ld hl, wBGPalettes + 16 ; $71bf
	call GrayscalePaletteColorInPlace ; $71c2
	ld hl, wBGPalettes + 18 ; $71c5
	call GrayscalePaletteColorInPlace ; $71c8
	ld hl, wBGPalettes + 20 ; $71cb
	call GrayscalePaletteColorInPlace ; $71ce
	ld hl, wBGPalettes + 22 ; $71d1
	call GrayscalePaletteColorInPlace ; $71d4
	ld a, $08 ; $71d7
	ld [wBGPalettes + 34], a ; $71d9
	ld a, $21 ; $71dc
	ld [wBGPalettes + 35], a ; $71de
	ret ; $71e1
.grayOut:
	ld hl, wBGPalettes + 8 ; $71e2
	call GrayscalePaletteColorInPlace ; $71e5
	ld hl, wBGPalettes + 10 ; $71e8
	call GrayscalePaletteColorInPlace ; $71eb
	ld hl, wBGPalettes + 12 ; $71ee
	call GrayscalePaletteColorInPlace ; $71f1
	ld hl, wBGPalettes + 14 ; $71f4
	call GrayscalePaletteColorInPlace ; $71f7
	ld a, $08 ; $71fa
	ld [wBGPalettes + 58], a ; $71fc
	ld a, $21 ; $71ff
	ld [wBGPalettes + 59], a ; $7201
	ret ; $7204
GrayscalePaletteColorInPlace:
	ld a, [hl+] ; $7205
	ld d, [hl] ; $7206
	ld e, a ; $7207
	call ConvertColorToGrayscale ; $7208
	dec hl ; $720b
	ld a, e ; $720c
	ld [hl+], a ; $720d
	ld [hl], d ; $720e
	ret ; $720f
; Averages a CGB colour's three components into a grey.
;
; Buggy in the shipped game: the blue component is stored to $0002 instead of
; $d002, so $d002 is never written and the average is red plus green plus a
; stale byte. The stray write lands on the MBC cartridge-RAM gate, which is
; harmless only because the save engine re-enables SRAM before using it.
; See docs/bugs.md.
ConvertColorToGrayscale:
	push hl ; $7210
	ldh a, [hWramBank] ; $7211
	push af ; $7213
	wram_bank $01 ; $7214
	ld a, e ; $721a
	and $1f ; $721b
	ld [wDecompBuffer], a ; $721d
	ld a, d ; $7220
	and $03 ; $7221
	rlca ; $7223
	rlca ; $7224
	ld [wDecompBuffer + 1], a ; $7225
	ld a, e ; $7228
	and $e0 ; $7229
	rlca ; $722b
	rlca ; $722c
	rlca ; $722d
	ld b, a ; $722e
	ld a, [wDecompBuffer + 1] ; $722f
	or b ; $7232
	ld [wDecompBuffer + 1], a ; $7233
	ld a, d ; $7236
	and $7c ; $7237
	rrca ; $7239
	rrca ; $723a
	ld [rRAMG + 2], a ; $723b
	ld a, [wDecompBuffer] ; $723e
	ld hl, wDecompBuffer + 1 ; $7241
	add [hl] ; $7244
	inc hl ; $7245
	add [hl] ; $7246
	srl a ; $7247
	and $1f ; $7249
	ld [wDecompBuffer + 3], a ; $724b
	ld e, a ; $724e
	rrca ; $724f
	rrca ; $7250
	rrca ; $7251
	and $e0 ; $7252
	or e ; $7254
	ld e, a ; $7255
	ld a, [wDecompBuffer + 3] ; $7256
	rrca ; $7259
	rrca ; $725a
	rrca ; $725b
	and $03 ; $725c
	ld d, a ; $725e
	ld a, [wDecompBuffer + 3] ; $725f
	rlca ; $7262
	rlca ; $7263
	or d ; $7264
	ld d, a ; $7265
	pop af ; $7266
	wram_bank ; $7267
	pop hl ; $726b
	ret ; $726c
AssignExpPointToChar:
	wram_bank $06 ; $726d
	ld a, [$d14e] ; $7273
	ld d, a ; $7276
	ld a, [$d14f] ; $7277
	or d ; $727a
	ld a, $00 ; $727b
	ret z ; $727d
	ld hl, $d14e ; $727e
	ld a, [hl+] ; $7281
	ld d, [hl] ; $7282
	ld e, a ; $7283
	dec de ; $7284
	dec hl ; $7285
	ld a, e ; $7286
	ld [hl+], a ; $7287
	ld [hl], d ; $7288
	ld a, [wStoryCharacterSlot] ; $7289
	or a ; $728c
	jr nz, .nonZero ; $728d
	ld hl, wExpScreenCharStats + 6 ; $728f
	ld a, [hl+] ; $7292
	ld d, [hl] ; $7293
	ld e, a ; $7294
	inc de ; $7295
	dec hl ; $7296
	ld a, e ; $7297
	ld [hl+], a ; $7298
	ld [hl], d ; $7299
	ld hl, wExpScreenCharStats + 4 ; $729a
	ld a, [hl+] ; $729d
	ld d, [hl] ; $729e
	ld e, a ; $729f
	inc de ; $72a0
	dec hl ; $72a1
	ld a, e ; $72a2
	ld [hl+], a ; $72a3
	ld [hl], d ; $72a4
	ld hl, wExpScreenCharStats + 8 ; $72a5
	ld a, [hl+] ; $72a8
	ld d, [hl] ; $72a9
	ld e, a ; $72aa
	dec de ; $72ab
	dec hl ; $72ac
	ld a, e ; $72ad
	ld [hl+], a ; $72ae
	ld [hl], d ; $72af
	call CheckExpLevelUp ; $72b0
	ld a, $01 ; $72b3
	ret ; $72b5
.nonZero:
	ld hl, wExpScreenCharStats + 21 ; $72b6
	ld a, [hl+] ; $72b9
	ld d, [hl] ; $72ba
	ld e, a ; $72bb
	inc de ; $72bc
	dec hl ; $72bd
	ld a, e ; $72be
	ld [hl+], a ; $72bf
	ld [hl], d ; $72c0
	ld hl, wExpScreenCharStats + 19 ; $72c1
	ld a, [hl+] ; $72c4
	ld d, [hl] ; $72c5
	ld e, a ; $72c6
	inc de ; $72c7
	dec hl ; $72c8
	ld a, e ; $72c9
	ld [hl+], a ; $72ca
	ld [hl], d ; $72cb
	ld hl, wExpScreenCharStats + 23 ; $72cc
	ld a, [hl+] ; $72cf
	ld d, [hl] ; $72d0
	ld e, a ; $72d1
	dec de ; $72d2
	dec hl ; $72d3
	ld a, e ; $72d4
	ld [hl+], a ; $72d5
	ld [hl], d ; $72d6
	call CheckExpLevelUp ; $72d7
	ld a, $01 ; $72da
	ret ; $72dc
UnassignExpPointFromChar:
	wram_bank $06 ; $72dd
	ld a, [wStoryCharacterSlot] ; $72e3
	or a ; $72e6
	jr nz, .nonZero ; $72e7
	ld hl, wExpScreenCharStats + 6 ; $72e9
	ld a, [hl+] ; $72ec
	ld d, [hl] ; $72ed
	ld e, a ; $72ee
	ld a, d ; $72ef
	or e ; $72f0
	jr z, .returnZero ; $72f1
	dec de ; $72f3
	dec hl ; $72f4
	ld a, e ; $72f5
	ld [hl+], a ; $72f6
	ld [hl], d ; $72f7
	ld hl, wExpScreenCharStats + 4 ; $72f8
	ld a, [hl+] ; $72fb
	ld d, [hl] ; $72fc
	ld e, a ; $72fd
	dec de ; $72fe
	dec hl ; $72ff
	ld a, e ; $7300
	ld [hl+], a ; $7301
	ld [hl], d ; $7302
	ld hl, wExpScreenCharStats + 8 ; $7303
	ld a, [hl+] ; $7306
	ld d, [hl] ; $7307
	ld e, a ; $7308
	inc de ; $7309
	dec hl ; $730a
	ld a, e ; $730b
	ld [hl+], a ; $730c
	ld [hl], d ; $730d
	call CheckExpLevelDown ; $730e
	jr .step2 ; $7311
.nonZero:
	ld hl, wExpScreenCharStats + 21 ; $7313
	ld a, [hl+] ; $7316
	ld d, [hl] ; $7317
	ld e, a ; $7318
	ld a, d ; $7319
	or e ; $731a
	jr z, .returnZero ; $731b
	dec de ; $731d
	dec hl ; $731e
	ld a, e ; $731f
	ld [hl+], a ; $7320
	ld [hl], d ; $7321
	ld hl, wExpScreenCharStats + 19 ; $7322
	ld a, [hl+] ; $7325
	ld d, [hl] ; $7326
	ld e, a ; $7327
	dec de ; $7328
	dec hl ; $7329
	ld a, e ; $732a
	ld [hl+], a ; $732b
	ld [hl], d ; $732c
	ld hl, wExpScreenCharStats + 23 ; $732d
	ld a, [hl+] ; $7330
	ld d, [hl] ; $7331
	ld e, a ; $7332
	inc de ; $7333
	dec hl ; $7334
	ld a, e ; $7335
	ld [hl+], a ; $7336
	ld [hl], d ; $7337
	call CheckExpLevelDown ; $7338
.step2:
	ld hl, $d14e ; $733b
	ld a, [hl+] ; $733e
	ld d, [hl] ; $733f
	ld e, a ; $7340
	inc de ; $7341
	dec hl ; $7342
	ld a, e ; $7343
	ld [hl+], a ; $7344
	ld [hl], d ; $7345
	ld a, $01 ; $7346
	ret ; $7348
.returnZero:
	xor a ; $7349
	ret ; $734a
UploadExpScreenTilemapRows:
	wram_bank $03 ; $734b
	ld hl, wShadowTilemap + 1 * TILEMAP_WIDTH ; $7351
	ld de, $9820 ; $7354
	ld c, $16 ; $7357
	call QueueVRAMCopy ; $7359
	ld hl, wShadowTilemap + 13 * TILEMAP_WIDTH ; $735c
	ld de, $99a0 ; $735f
	ld c, $04 ; $7362
	call QueueVRAMCopy ; $7364
	ld hl, wShadowTilemap + 16 * TILEMAP_WIDTH ; $7367
	ld de, $9a00 ; $736a
	ld c, $01 ; $736d
	call QueueVRAMCopy ; $736f
	ret ; $7372
RefreshExpScreenReadouts:
	call DrawExpPoolReadout ; $7373
	call DrawExpScreenLevelNumber ; $7376
	call DrawExpScreenLevelBar ; $7379
	ret ; $737c
CheckExpLevelUp:
	wram_bank $06 ; $737d
	ld a, [wStoryCharacterSlot] ; $7383
	or a ; $7386
	jr nz, .nonZero ; $7387
	ld hl, wExpScreenCharStats + 8 ; $7389
	ld a, [hl+] ; $738c
	ld d, [hl] ; $738d
	ld e, a ; $738e
	ld a, d ; $738f
	or e ; $7390
	ret nz ; $7391
	ld a, $ff ; $7392
	ld [$d186], a ; $7394
	ld a, [wExpScreenCharStats] ; $7397
	inc a ; $739a
	ld [wExpScreenCharStats], a ; $739b
	dec a ; $739e
	farcall GetExpRequiredForLevel ; $739f
	ld a, l ; $73a2
	ld [wExpScreenCharStats + 1], a ; $73a3
	ld [wExpScreenCharStats + 8], a ; $73a6
	ld a, h ; $73a9
	ld [wExpScreenCharStats + 2], a ; $73aa
	ld [wExpScreenCharStats + 9], a ; $73ad
	xor a ; $73b0
	ld [wExpScreenCharStats + 4], a ; $73b1
	ld [wExpScreenCharStats + 5], a ; $73b4
	ret ; $73b7
.nonZero:
	ld hl, wExpScreenCharStats + 23 ; $73b8
	ld a, [hl+] ; $73bb
	ld d, [hl] ; $73bc
	ld e, a ; $73bd
	ld a, d ; $73be
	or e ; $73bf
	ret nz ; $73c0
	ld a, $ff ; $73c1
	ld [$d186], a ; $73c3
	ld a, [wExpScreenCharStats + 15] ; $73c6
	inc a ; $73c9
	ld [wExpScreenCharStats + 15], a ; $73ca
	dec a ; $73cd
	farcall GetExpRequiredForLevel ; $73ce
	ld a, l ; $73d1
	ld [wExpScreenCharStats + 16], a ; $73d2
	ld [wExpScreenCharStats + 23], a ; $73d5
	ld a, h ; $73d8
	ld [wExpScreenCharStats + 17], a ; $73d9
	ld [wExpScreenCharStats + 24], a ; $73dc
	xor a ; $73df
	ld [wExpScreenCharStats + 19], a ; $73e0
	ld [wExpScreenCharStats + 20], a ; $73e3
	ret ; $73e6
CheckExpLevelDown:
	wram_bank $06 ; $73e7
	ld a, [wStoryCharacterSlot] ; $73ed
	or a ; $73f0
	jr nz, .nonZero ; $73f1
	ld hl, wExpScreenCharStats + 4 ; $73f3
	ld a, [hl+] ; $73f6
	ld d, [hl] ; $73f7
	ld e, a ; $73f8
	inc de ; $73f9
	ld a, d ; $73fa
	or e ; $73fb
	ret nz ; $73fc
	ld a, [wExpScreenCharStats] ; $73fd
	dec a ; $7400
	ld [wExpScreenCharStats], a ; $7401
	dec a ; $7404
	farcall GetExpRequiredForLevel ; $7405
	ld a, l ; $7408
	ld [wExpScreenCharStats + 1], a ; $7409
	ld a, h ; $740c
	ld [wExpScreenCharStats + 2], a ; $740d
	dec hl ; $7410
	ld a, l ; $7411
	ld [wExpScreenCharStats + 4], a ; $7412
	ld a, h ; $7415
	ld [wExpScreenCharStats + 5], a ; $7416
	ld a, $01 ; $7419
	ld [wExpScreenCharStats + 8], a ; $741b
	dec a ; $741e
	ld [wExpScreenCharStats + 9], a ; $741f
	ret ; $7422
.nonZero:
	ld hl, wExpScreenCharStats + 19 ; $7423
	ld a, [hl+] ; $7426
	ld d, [hl] ; $7427
	ld e, a ; $7428
	inc de ; $7429
	ld a, d ; $742a
	or e ; $742b
	ret nz ; $742c
	ld a, [wExpScreenCharStats + 15] ; $742d
	dec a ; $7430
	ld [wExpScreenCharStats + 15], a ; $7431
	dec a ; $7434
	farcall GetExpRequiredForLevel ; $7435
	ld a, l ; $7438
	ld [wExpScreenCharStats + 16], a ; $7439
	ld a, h ; $743c
	ld [wExpScreenCharStats + 17], a ; $743d
	dec hl ; $7440
	ld a, l ; $7441
	ld [wExpScreenCharStats + 19], a ; $7442
	ld a, h ; $7445
	ld [wExpScreenCharStats + 20], a ; $7446
	ld a, $01 ; $7449
	ld [wExpScreenCharStats + 23], a ; $744b
	dec a ; $744e
	ld [wExpScreenCharStats + 24], a ; $744f
	ret ; $7452
.step2:
	wram_bank $06 ; $7453
	ld hl, $d17f ; $7459
	set 2, [hl] ; $745c
	wram_bank $06 ; $745e
	ld a, [wExpScreenCharStats + 10] ; $7464
	ld [wBGPalettes + 58], a ; $7467
	ld a, [wExpScreenCharStats + 11] ; $746a
	ld [wBGPalettes + 59], a ; $746d
	ld a, [wExpScreenCharStats + 25] ; $7470
	ld [wBGPalettes + 34], a ; $7473
	ld a, [wExpScreenCharStats + 26] ; $7476
	ld [wBGPalettes + 35], a ; $7479
	ld a, [wStoryModeMainCharacterOverworldSpriteColor] ; $747c
	ld de, $0101 ; $747f
	farcall LoadIndexedPaletteThunk ; $7482
	ld a, [wStoryModePartnerCharacterOverworldSpriteColor] ; $7485
	ld de, $0201 ; $7488
	farcall LoadIndexedPaletteThunk ; $748b
	ld hl, hPaletteDirtyFlags ; $748e
	set 0, [hl] ; $7491
	sound $5f ; $7493
	farcall BackupCharDataScreenRow ; $7495
	ld hl, ExpLevelDownTilemapPatch4 ; $7498
	ld bc, $d240 ; $749b
	call ApplyTilemapPatchListExpScreen ; $749e
	call UploadExpPromptWindowRows ; $74a1
	call WaitFramesCmd ; $74a4
	db $02 ; $74a7 inline arg
	ld hl, ExpLevelDownTilemapPatch3 ; $74a8
	ld bc, $d240 ; $74ab
	call ApplyTilemapPatchListExpScreen ; $74ae
	call UploadExpPromptWindowRows ; $74b1
	call WaitFramesCmd ; $74b4
	db $02 ; $74b7 inline arg
	ld hl, ExpLevelDownTilemapPatch2 ; $74b8
	ld bc, $d240 ; $74bb
	call ApplyTilemapPatchListExpScreen ; $74be
	call UploadExpPromptWindowRows ; $74c1
	call WaitFramesCmd ; $74c4
	db $02 ; $74c7 inline arg
	ld hl, ExpLevelDownTilemapPatch1 ; $74c8
	ld bc, $d240 ; $74cb
	call ApplyTilemapPatchListExpScreen ; $74ce
	call UploadExpPromptWindowRows ; $74d1
	call WaitFramesCmd ; $74d4
	db $02 ; $74d7 inline arg
	ld hl, ExpLevelDownTilemapPatch0 ; $74d8
	ld bc, $d240 ; $74db
	call ApplyTilemapPatchListExpScreen ; $74de
	call UploadExpPromptWindowRows ; $74e1
	call WaitFramesCmd ; $74e4
	db $02 ; $74e7 inline arg
	ld hl, ExpPromptWindowFrame_1d ; $74e8
	ld bc, $d240 ; $74eb
	call ApplyTilemapPatchListExpScreen ; $74ee
	call UploadExpPromptWindowRows ; $74f1
	call WaitFramesCmd ; $74f4
	db $0c ; $74f7 inline arg
	wram_bank $06 ; $74f8
	ld a, $01 ; $74fe
	ld [$d182], a ; $7500
	jr UploadExpPromptWindowRows.loop ; $7503
UploadExpPromptWindowRows:
	wram_bank $03 ; $7505
	ld hl, wShadowTilemap + 12 * TILEMAP_WIDTH ; $750b
	ld de, $9980 ; $750e
	ld c, $0c ; $7511
	call QueueVRAMCopy ; $7513
	wram_bank $02 ; $7516
	ld hl, $d180 ; $751c
	ld de, $9980 + VRAM_BANK1 ; $751f
	ld c, $0c ; $7522
	call QueueVRAMCopy ; $7524
	ret ; $7527
.loop:
	call DrawExpPromptCursor ; $7528
	call TickLevelUpJingle ; $752b
	call AdvanceFrame ; $752e
	ldh a, [hInputRisingEdge] ; $7531
	bit PADB_UP, a ; $7533
	jr nz, DrawExpPromptCursor.playSfx ; $7535
	bit 7, a ; $7537
	jr nz, DrawExpPromptCursor.playSfx ; $7539
	bit 0, a ; $753b
	jr nz, DrawExpPromptCursor.bit0Set ; $753d
	bit 1, a ; $753f
	jr nz, DrawExpPromptCursor.playSfx2 ; $7541
	jr .loop ; $7543
UploadExpPromptWindowRowsClosing:
	wram_bank $03 ; $7545
	ld hl, wShadowTilemap + 12 * TILEMAP_WIDTH ; $754b
	ld de, $9980 ; $754e
	ld c, $0c ; $7551
	call QueueVRAMCopy ; $7553
	wram_bank $02 ; $7556
	ld hl, $d180 ; $755c
	ld de, $9980 + VRAM_BANK1 ; $755f
	ld c, $0c ; $7562
	call QueueVRAMCopy ; $7564
	ret ; $7567
DrawExpPromptCursor:
	ldh a, [hVBlankCounter] ; $7568
	and $08 ; $756a
	ret z ; $756c
	ld bc, $0816 ; $756d
	ld de, $0c7f ; $7570
	ld a, [$d182] ; $7573
	or a ; $7576
	jr z, .queueSprite ; $7577
	ld e, $87 ; $7579
.queueSprite:
	call QueueSprite ; $757b
	ret ; $757e
.playSfx:
	sound $5e ; $757f
	ld a, [$d182] ; $7581
	xor $01 ; $7584
	ld [$d182], a ; $7586
	jr UploadExpPromptWindowRows.loop ; $7589
.bit0Set:
	ld a, [$d182] ; $758b
	or a ; $758e
	jr nz, .playSfx2 ; $758f
	sound $5f ; $7591
	ret ; $7593
.playSfx2:
	sound $62 ; $7594
	farcall RestoreCharDataScreenRow ; $7596
	ld hl, ExpLevelDownTilemapPatch0 ; $7599
	ld bc, $d240 ; $759c
	call ApplyTilemapPatchListExpScreen ; $759f
	call UploadExpPromptWindowRowsClosing ; $75a2
	call WaitFramesCmd ; $75a5
	db $02 ; $75a8 inline arg
	farcall RestoreCharDataScreenRow ; $75a9
	ld hl, ExpLevelDownTilemapPatch1 ; $75ac
	ld bc, $d240 ; $75af
	call ApplyTilemapPatchListExpScreen ; $75b2
	call UploadExpPromptWindowRowsClosing ; $75b5
	call WaitFramesCmd ; $75b8
	db $02 ; $75bb inline arg
	farcall RestoreCharDataScreenRow ; $75bc
	ld hl, ExpLevelDownTilemapPatch2 ; $75bf
	ld bc, $d240 ; $75c2
	call ApplyTilemapPatchListExpScreen ; $75c5
	call UploadExpPromptWindowRowsClosing ; $75c8
	call WaitFramesCmd ; $75cb
	db $02 ; $75ce inline arg
	farcall RestoreCharDataScreenRow ; $75cf
	ld hl, ExpLevelDownTilemapPatch3 ; $75d2
	ld bc, $d240 ; $75d5
	call ApplyTilemapPatchListExpScreen ; $75d8
	call UploadExpPromptWindowRowsClosing ; $75db
	call WaitFramesCmd ; $75de
	db $02 ; $75e1 inline arg
	farcall RestoreCharDataScreenRow ; $75e2
	ld hl, ExpLevelDownTilemapPatch4 ; $75e5
	ld bc, $d240 ; $75e8
	call ApplyTilemapPatchListExpScreen ; $75eb
	call UploadExpPromptWindowRowsClosing ; $75ee
	call WaitFramesCmd ; $75f1
	db $02 ; $75f4 inline arg
	farcall RestoreCharDataScreenRow ; $75f5
	call UploadExpPromptWindowRowsClosing ; $75f8
	call WaitFramesCmd ; $75fb
	db $02 ; $75fe inline arg
	wram_bank $06 ; $75ff
	ld hl, $d17f ; $7605
	res 2, [hl] ; $7608
	call UpdateExpScreenSelectionPalettes ; $760a
	jp RunExpDistributionLoop ; $760d
ApplyTilemapPatchListExpScreen:
	ld a, [hl] ; $7610
	cp $ff ; $7611
	ret z ; $7613
	push hl ; $7614
	ld d, [hl] ; $7615
	inc hl ; $7616
	ld e, [hl] ; $7617
	push hl ; $7618
	ld hl, $d000 ; $7619
	add hl, de ; $761c
	ld d, h ; $761d
	ld e, l ; $761e
	pop hl ; $761f
	inc hl ; $7620
	push hl ; $7621
	ld a, [hl] ; $7622
	ld h, b ; $7623
	ld l, c ; $7624
	add l ; $7625
	ld l, a ; $7626
	jr nc, .gotSrc ; $7627
	inc h ; $7629
.gotSrc:
	wram_bank $06 ; $762a
	ld a, l ; $7630
	ld [wCharDataNumberBuffer], a ; $7631
	ld a, h ; $7634
	ld [wCharDataNumberBuffer + 1], a ; $7635
	pop hl ; $7638
	push bc ; $7639
	inc hl ; $763a
	ld c, [hl] ; $763b
	ld hl, wCharDataNumberBuffer ; $763c
	ld a, [hl+] ; $763f
	ld h, [hl] ; $7640
	ld l, a ; $7641
.copyLoop:
	wram_bank $03 ; $7642
	ld a, [hl] ; $7648
	ld [de], a ; $7649
	wram_bank $02 ; $764a
	ld a, [hl+] ; $7650
	ld [de], a ; $7651
	inc de ; $7652
	dec c ; $7653
	jr nz, .copyLoop ; $7654
	pop bc ; $7656
	pop hl ; $7657
	inc hl ; $7658
	inc hl ; $7659
	inc hl ; $765a
	inc hl ; $765b
	jr ApplyTilemapPatchListExpScreen ; $765c
DrawExpToNextLevelTask:
	wram_bank $06 ; $765e
	ld a, [$d17f] ; $7664
	bit 0, a ; $7667
	ret nz ; $7669
	bit 2, a ; $766a
	ret nz ; $766c
	ld a, [wCharDataViewOnly] ; $766d
	or a ; $7670
	ret nz ; $7671
	ld a, [wStoryCharacterSlot] ; $7672
	or a ; $7675
	jr nz, .nonZero ; $7676
	wram_bank $06 ; $7678
	ld a, [wExpScreenCharStats] ; $767e
	cp $64 ; $7681
	ret nc ; $7683
	ld hl, wExpScreenCharStats + 8 ; $7684
	ld a, [hl+] ; $7687
	ld h, [hl] ; $7688
	ld l, a ; $7689
	ld a, $03 ; $768a
	ld de, wCharDataNumberBuffer ; $768c
	call FormatDecimalNumberUnsigned ; $768f
	ld a, [wCharDataNumberBuffer] ; $7692
	cp $20 ; $7695
	jr z, .eq20 ; $7697
	call GetExpScreenDigitSprite ; $7699
	ld de, $182f ; $769c
	call QueueSprite ; $769f
.eq20:
	ld a, [wCharDataNumberBuffer + 1] ; $76a2
	cp $20 ; $76a5
	jr z, .eq202 ; $76a7
	call GetExpScreenDigitSprite ; $76a9
	ld de, $1f2f ; $76ac
	call QueueSprite ; $76af
.eq202:
	ld a, [wCharDataNumberBuffer + 2] ; $76b2
	call GetExpScreenDigitSprite ; $76b5
	ld de, $262f ; $76b8
	call QueueSprite ; $76bb
	ld hl, SpriteTemplate_1d_7b59 ; $76be
	ld bc, $0e2c ; $76c1
	ld de, $142e ; $76c4
	call QueueSpriteTemplate ; $76c7
	ret ; $76ca
.nonZero:
	wram_bank $06 ; $76cb
	ld a, [wExpScreenCharStats + 15] ; $76d1
	cp $64 ; $76d4
	ret nc ; $76d6
	ld hl, wExpScreenCharStats + 23 ; $76d7
	ld a, [hl+] ; $76da
	ld h, [hl] ; $76db
	ld l, a ; $76dc
	ld a, $03 ; $76dd
	ld de, wCharDataNumberBuffer ; $76df
	call FormatDecimalNumberUnsigned ; $76e2
	ld a, [wCharDataNumberBuffer] ; $76e5
	cp $20 ; $76e8
	jr z, .eq203 ; $76ea
	call GetExpScreenDigitSprite ; $76ec
	ld de, $1862 ; $76ef
	call QueueSprite ; $76f2
.eq203:
	ld a, [wCharDataNumberBuffer + 1] ; $76f5
	cp $20 ; $76f8
	jr z, .eq204 ; $76fa
	call GetExpScreenDigitSprite ; $76fc
	ld de, $1f62 ; $76ff
	call QueueSprite ; $7702
.eq204:
	ld a, [wCharDataNumberBuffer + 2] ; $7705
	call GetExpScreenDigitSprite ; $7708
	ld de, $2662 ; $770b
	call QueueSprite ; $770e
	ld hl, SpriteTemplate_1d_7c7d ; $7711
	ld bc, $0e44 ; $7714
	ld de, $1461 ; $7717
	call QueueSpriteTemplate ; $771a
	ret ; $771d
GetExpScreenDigitSprite:
	sub $30 ; $771e
	rlca ; $7720
	add $18 ; $7721
	ld c, a ; $7723
	ld b, $0e ; $7724
	ret ; $7726
DrawExpCharCursorTask:
	wram_bank $06 ; $7727
	ld a, [$d180] ; $772d
	add LOW(Data_1d_7746) ; $7730
	ld l, a ; $7732
	adc HIGH(Data_1d_7746) ; $7733
	sub l ; $7735
	ld h, a ; $7736
	ld a, [hl] ; $7737
	inc a ; $7738
	ld e, a ; $7739
	ld d, $19 ; $773a
	ld hl, SpriteTemplate_1d_7930 ; $773c
	ld bc, $0e00 ; $773f
	call QueueSpriteTemplate ; $7742
	ret ; $7745
Data_1d_7746:
	; $7746, 26 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $06, $08, $0a, $0d, $11, $16, $1d, $24, $2b, $32, $37 ; 0x00
	db $3b, $3e, $40, $42, $44, $45, $46, $47, $48, $00 ; 0x10
DrawExpBarFillMarkersTask:
	wram_bank $06 ; $7760
	ld de, $3801 ; $7766
	ld a, [wExpScreenCharStats + 3] ; $7769
	add d ; $776c
	ld d, a ; $776d
	ld hl, SpriteTemplate_1d_797a ; $776e
	ld bc, $0f0c ; $7771
	call QueueSpriteTemplate ; $7774
	ld de, $3849 ; $7777
	ld a, [wExpScreenCharStats + 18] ; $777a
	add d ; $777d
	ld d, a ; $777e
	ld hl, SpriteTemplate_1d_797a ; $777f
	ld bc, $0f0c ; $7782
	call QueueSpriteTemplate ; $7785
	ret ; $7788
DrawExpBarSweepSpriteTask:
	ld e, $01 ; $7789
	ld a, [wStoryCharacterSlot] ; $778b
	or a ; $778e
	jr z, .zero ; $778f
	ld e, $49 ; $7791
.zero:
	wram_bank $06 ; $7793
	ld a, [$d181] ; $7799
	ld d, a ; $779c
	ld hl, SpriteTemplate_1d_79b4 ; $779d
	ld bc, $0f10 ; $77a0
	call QueueSpriteTemplate ; $77a3
	ret ; $77a6
TickLevelUpJingle:
	wram_bank $06 ; $77a7
	ld a, [$d186] ; $77ad
	or a ; $77b0
	ret z ; $77b1
	cp $ff ; $77b2
	jr z, .eqff ; $77b4
	dec a ; $77b6
	ld [$d186], a ; $77b7
	ret nz ; $77ba
	sound $0c ; $77bb
	ret ; $77bd
.eqff:
	ld a, $a0 ; $77be
	ld [$d186], a ; $77c0
	sound $00 ; $77c3
	sound $2f ; $77c5
	ret ; $77c7
ExpPromptWindowFrame_1d:
	INCBIN "data/bank_01d/d_77c8.bin" ; $77c8, 25 bytes
ExpLevelDownTilemapPatch0:
	INCBIN "data/bank_01d/d_77e1.bin" ; $77e1, 21 bytes
ExpLevelDownTilemapPatch1:
	INCBIN "data/bank_01d/d_77f6.bin" ; $77f6, 17 bytes
ExpLevelDownTilemapPatch2:
	INCBIN "data/bank_01d/d_7807.bin" ; $7807, 13 bytes
ExpLevelDownTilemapPatch3:
	INCBIN "data/bank_01d/d_7814.bin" ; $7814, 9 bytes
ExpLevelDownTilemapPatch4:
	INCBIN "data/bank_01d/d_781d.bin" ; $781d, 5 bytes
ExpDistributionScreenGfx5:
	INCBIN "data/bank_01d/d_7822.bin" ; $7822, 47 bytes
ExpDistributionScreenGfx6:
	INCBIN "data/bank_01d/d_7851.bin" ; $7851, 37 bytes
ExpDistributionScreenGfx7:
	INCBIN "data/bank_01d/d_7876.bin" ; $7876, 25 bytes
ExpDistributionScreenPalettes:
	INCBIN "data/bank_01d/d_788f.bin" ; $788f, 24 bytes
ExpDistributionScreenGfx8:
	INCBIN "data/bank_01d/d_78a7.bin" ; $78a7, 137 bytes
SpriteTemplate_1d_7930:
	; $7930, 25 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite_end
ExpDistributionScreenGfx0:
	INCBIN "data/bank_01d/d_7949.bin" ; $7949, 49 bytes
SpriteTemplate_1d_797a:
	; $797a, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
ExpDistributionScreenGfx1:
	INCBIN "data/bank_01d/d_7983.bin" ; $7983, 49 bytes
SpriteTemplate_1d_79b4:
	; $79b4, 13 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite_end
ExpDistributionScreenGfx2:
	INCBIN "data/bank_01d/d_79c1.bin" ; $79c1, 162 bytes
ExpDistributionScreenGfx3:
	INCBIN "data/bank_01d/d_7a63.bin" ; $7a63, 246 bytes
SpriteTemplate_1d_7b59:
	; $7b59, 49 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite $10, $28, $10, $00
	oam_sprite $20, $28, $12, $00
	oam_sprite $10, $30, $14, $00
	oam_sprite $20, $30, $16, $00
	oam_sprite_end
ExpDistributionScreenGfx4:
	INCBIN "data/bank_01d/d_7b8a.bin" ; $7b8a, 243 bytes
SpriteTemplate_1d_7c7d:
	; $7c7d, 49 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite $10, $28, $10, $00
	oam_sprite $20, $28, $12, $00
	oam_sprite $10, $30, $14, $00
	oam_sprite $20, $30, $16, $00
	oam_sprite_end
ClearDrillResultBuffer:
	push af ; $7cae
	push bc ; $7caf
	push de ; $7cb0
	push hl ; $7cb1
	wram_bank $06 ; $7cb2
	ld hl, $d152 ; $7cb8
	ld bc, $000f ; $7cbb
	call ClearBytes ; $7cbe
	pop hl ; $7cc1
	pop de ; $7cc2
	pop bc ; $7cc3
	pop af ; $7cc4
	ret ; $7cc5
RecordDrillResult:
	wram_bank $06 ; $7cc6
	ld a, b ; $7ccc
	rlca ; $7ccd
	add LOW(DrillSubHandlers_1d) ; $7cce
	ld l, a ; $7cd0
	adc HIGH(DrillSubHandlers_1d) ; $7cd1
	sub l ; $7cd3
	ld h, a ; $7cd4
	ld a, [hl+] ; $7cd5
	ld h, [hl] ; $7cd6
	ld l, a ; $7cd7
	jp hl ; $7cd8
DrillSubHandlers_1d:
	; $7cd9, 10 bytes (records:2)
	dw DrillSubHandler0 ; record 0
	dw DrillSubHandler1 ; record 1
	dw DrillSubHandler2 ; record 2
	dw DrillSubHandler3 ; record 3
	dw DrillSubHandler4 ; record 4
DrillSubHandler0:
	ld a, c ; $7ce3
	ld [$d15c], a ; $7ce4
	ld hl, $d152 ; $7ce7
	ld a, e ; $7cea
	ld [hl+], a ; $7ceb
	ld [hl], d ; $7cec
	ret ; $7ced
DrillSubHandler1:
	ld a, c ; $7cee
	ld [$d15d], a ; $7cef
	ld hl, $d154 ; $7cf2
	ld a, e ; $7cf5
	ld [hl+], a ; $7cf6
	ld [hl], d ; $7cf7
	ret ; $7cf8
DrillSubHandler2:
	ld a, c ; $7cf9
	ld [$d15e], a ; $7cfa
	ld hl, $d156 ; $7cfd
	ld a, e ; $7d00
	ld [hl+], a ; $7d01
	ld [hl], d ; $7d02
	ret ; $7d03
DrillSubHandler3:
	ld a, c ; $7d04
	ld [$d15f], a ; $7d05
	ld hl, $d158 ; $7d08
	ld a, e ; $7d0b
	ld [hl+], a ; $7d0c
	ld [hl], d ; $7d0d
	ret ; $7d0e
DrillSubHandler4:
	ld a, c ; $7d0f
	ld [$d160], a ; $7d10
	ld hl, $d15a ; $7d13
	ld a, e ; $7d16
	ld [hl+], a ; $7d17
	ld [hl], d ; $7d18
	ret ; $7d19
	; $7d1a, 742 bytes fill to bank end (linker-padded)
