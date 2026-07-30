SECTION "ROM Bank $1c", ROMX[$4000], BANK[$1c]

	farptr CharDataScreen_Show ; $4000
	farptr CharDataScreen_LoadScreen ; $4002
	farptr CharDataScreen_WriteStatNumber ; $4004
	farptr CharDataScreen_DrawStats ; $4006
	farptr BackupCharDataScreenRow ; $4008
	farptr RestoreCharDataScreenRow ; $400a
	farptr BackupCharData ; $400c
	farptr RestoreCharData ; $400e
	farptr LoadCharDataScreenTilemaps ; $4010
	farptr StartCharDataScreenAnimTask ; $4012
	farptr StopCharDataScreenAnimTask ; $4014
	farptr FlushCharDataTilemapsFar ; $4016
	farptr LoadCharDataScreenGraphics ; $4018
CharDataScreen_Show:
	ldh a, [hWramBank] ; $401a
	push af ; $401c
	wram_bank $06 ; $401d
	push bc ; $4023
	ld a, [wCharDataViewOnly] ; $4024
	or a ; $4027
	jr nz, .show ; $4028
	test_flag FLAG_CHAR_DATA_START_EXITS ; $402a
	jr nz, .show ; $402d
	push bc ; $402f
	ld a, c ; $4030
	farcall HasReachedNextLevelExp ; $4031
	jp nz, .levelUpPending ; $4034
	pop bc ; $4037
.show:
	call ClearFrameTasks ; $4038
	call DisableLCDSafely ; $403b
	xor a ; $403e
	ldh [hScrollX], a ; $403f
	ldh [hScrollY], a ; $4041
	ld [wCameraX], a ; $4043
	ld [wCameraX + 1], a ; $4046
	ld [wCameraY], a ; $4049
	ld [wCameraY + 1], a ; $404c
	ld a, $90 ; $404f
	ldh [rWY], a ; $4051
	call ClearSpriteQueue ; $4053
	pop bc ; $4056
	call CharDataScreen_InitState ; $4057
	call LoadCharStats ; $405a
	call CharDataScreen_BuildTilemap ; $405d
	wram_bank $06 ; $4060
	ld a, [wCharDataViewOnly] ; $4066
	or a ; $4069
	jr nz, .reentry ; $406a
	call EnableLCD ; $406c
	call AdvanceFrame ; $406f
	ld a, $01 ; $4072
	ld hl, DrawStatValueSprites ; $4074
	call RegisterFrameTask ; $4077
	ld a, $01 ; $407a
	ld hl, DrawRemainingPointsSprite ; $407c
	call RegisterFrameTask ; $407f
	script_fade_in $10 ; $4082
	call WaitFadeEnd ; $4087
	ld a, $01 ; $408a
	ld hl, CharDataScreenAnimTask ; $408c
	call RegisterFrameTask ; $408f
	call AnimateCharDataStatsReveal ; $4092
	wram_bank $06 ; $4095
	xor a ; $409b
	ld [wCharDataLevelPreview], a ; $409c
	call CharDataScreen_DrawPageColumns ; $409f
	call FlushCharDataTilemaps ; $40a2
	ld a, $01 ; $40a5
	ld hl, DrawStatArrowIndicators ; $40a7
	call RegisterFrameTask ; $40aa
	jr .runInputLoop ; $40ad
.reentry:
	call SetupCharDataScreen ; $40af
.runInputLoop:
	call CharDataScreen_InputLoop ; $40b2
	push af ; $40b5
	ld c, $10 ; $40b6
	call BeginFadeOut ; $40b8
	call WaitFadeEnd ; $40bb
	ld hl, wStoryModeNameOfMainCharacter ; $40be
	ld de, wStorySlotData ; $40c1
	ld c, $08 ; $40c4
	call CopyMemoryFast ; $40c6
	ld hl, DrawStatValueSprites ; $40c9
	call UnregisterFrameTask ; $40cc
	ld hl, DrawRemainingPointsSprite ; $40cf
	call UnregisterFrameTask ; $40d2
	ld hl, CharDataScreenAnimTask ; $40d5
	call UnregisterFrameTask ; $40d8
	sound BGM_NONE ; $40db
	call DisableLCDSafely ; $40dd
	farcall LoadMenuFontGfx ; $40e0
	call EnableLCD ; $40e3
	call AdvanceFrame ; $40e6
	pop bc ; $40e9
	pop af ; $40ea
	wram_bank ; $40eb
	ld a, b ; $40ef
	ret ; $40f0
.levelUpPending:
	pop bc ; $40f1
	pop bc ; $40f2
	pop af ; $40f3
	wram_bank ; $40f4
	ld a, $ff ; $40f8
	ret ; $40fa
CharDataScreen_InitState:
	wram_bank $06 ; $40fb
	ld a, c ; $4101
	ld [wStoryCharacterSlot], a ; $4102
	xor a ; $4105
	ld [wCharDataAnimCounter], a ; $4106
	ld [wCharDataAnimSubStep], a ; $4109
	ld [wCharDataFlushChunk], a ; $410c
	ld [wCharDataRevealDone], a ; $410f
	ld a, c ; $4112
	ld [wCharDataStatsSlideX], a ; $4113
	ld [wCharDataStatsSlideX + 1], a ; $4116
	inc a ; $4119
	inc a ; $411a
	ld [wCharDataPageArrowMode], a ; $411b
	ld a, $04 ; $411e
	ld [wCharDataPage], a ; $4120
	ld a, $0a ; $4123
	ld [wCharDataRevealTimer], a ; $4125
	ld a, $03 ; $4128
	ld [wCharDataRevealStep], a ; $412a
	ld [wCharDataLevelPreview], a ; $412d
	ld a, [wCharDataViewOnly] ; $4130
	or a ; $4133
	ret nz ; $4134
	xor a ; $4135
	ld [wCharDataPointsWorking], a ; $4136
	push af ; $4139
	ld hl, wStoryModeNameOfMainCharacter ; $413a
	ld a, [wStoryCharacterSlot] ; $413d
	or a ; $4140
	jr z, .zero ; $4141
	ld l, $40 ; $4143
.zero:
	ld a, l ; $4145
	add $18 ; $4146
	ld l, a ; $4148
	ld a, h ; $4149
	adc $00 ; $414a
	ld h, a ; $414c
	pop af ; $414d
	ld a, [hl] ; $414e
	ld [wCharDataLevel], a ; $414f
	push af ; $4152
	ld hl, wStoryModeNameOfMainCharacter ; $4153
	ld a, [wStoryCharacterSlot] ; $4156
	or a ; $4159
	jr z, .zero2 ; $415a
	ld l, $40 ; $415c
.zero2:
	ld a, l ; $415e
	add $38 ; $415f
	ld l, a ; $4161
	ld a, h ; $4162
	adc $00 ; $4163
	ld h, a ; $4165
	pop af ; $4166
	ld a, [hl] ; $4167
	ld [wCharDataNewLevels], a ; $4168
	ld [wCharDataLevels], a ; $416b
	push af ; $416e
	ld hl, wStoryModeNameOfMainCharacter ; $416f
	ld a, [wStoryCharacterSlot] ; $4172
	or a ; $4175
	jr z, .zero3 ; $4176
	ld l, $40 ; $4178
.zero3:
	ld a, l ; $417a
	add $39 ; $417b
	ld l, a ; $417d
	ld a, h ; $417e
	adc $00 ; $417f
	ld h, a ; $4181
	pop af ; $4182
	ld a, [hl] ; $4183
	ld [wCharDataNewLevels + 1], a ; $4184
	ld [wCharDataLevels + 1], a ; $4187
	push af ; $418a
	ld hl, wStoryModeNameOfMainCharacter ; $418b
	ld a, [wStoryCharacterSlot] ; $418e
	or a ; $4191
	jr z, .zero4 ; $4192
	ld l, $40 ; $4194
.zero4:
	ld a, l ; $4196
	add $3a ; $4197
	ld l, a ; $4199
	ld a, h ; $419a
	adc $00 ; $419b
	ld h, a ; $419d
	pop af ; $419e
	ld a, [hl] ; $419f
	ld [wCharDataNewLevels + 2], a ; $41a0
	ld [wCharDataLevels + 2], a ; $41a3
	push af ; $41a6
	ld hl, wStoryModeNameOfMainCharacter ; $41a7
	ld a, [wStoryCharacterSlot] ; $41aa
	or a ; $41ad
	jr z, .zero5 ; $41ae
	ld l, $40 ; $41b0
.zero5:
	ld a, l ; $41b2
	add $3b ; $41b3
	ld l, a ; $41b5
	ld a, h ; $41b6
	adc $00 ; $41b7
	ld h, a ; $41b9
	pop af ; $41ba
	ld a, [hl] ; $41bb
	ld [wCharDataNewLevels + 3], a ; $41bc
	ld [wCharDataLevels + 3], a ; $41bf
.loop:
	ld a, [wStoryCharacterSlot] ; $41c2
	farcall HasReachedNextLevelExp ; $41c5
	jr nz, .writeCharStatsToDisplayBuffer ; $41c8
	ld a, [wStoryCharacterSlot] ; $41ca
	ld d, $00 ; $41cd
	farcall LevelUpPlayer ; $41cf
	ld hl, wCharDataPointsWorking ; $41d2
	inc [hl] ; $41d5
	jr .loop ; $41d6
.writeCharStatsToDisplayBuffer:
	call WriteCharStatsToDisplayBuffer ; $41d8
	ret ; $41db
CharDataScreen_BuildTilemap:
	call CharDataScreen_LoadUIGraphics ; $41dc
	call CharDataScreen_DrawStats ; $41df
	call CharDataScreen_DrawPortrait ; $41e2
	wram_bank $03 ; $41e5
	ld hl, wShadowTilemap ; $41eb
	ld de, $9800 ; $41ee
	ld c, $24 ; $41f1
	call QueueVRAMCopy ; $41f3
	wram_bank $02 ; $41f6
	ld hl, wScreenAttrmap ; $41fc
	ld de, $9800 + VRAM_BANK1 ; $41ff
	ld c, $24 ; $4202
	call QueueVRAMCopy ; $4204
	ret ; $4207
CharDataScreen_LoadUIGraphics:
	call CharDataScreen_LoadScreen ; $4208
	wram_bank $01 ; $420b
	ld hl, CharDataScreenUIGraphicsGfx4 ; $4211
	ld de, wDecompBuffer + 62 * TILE_SIZE ; $4214
	call DecompressData ; $4217
	ld hl, wDecompBuffer + 62 * TILE_SIZE ; $421a
	ld bc, $0021 ; $421d
	call CopyWram1ToWram3 ; $4220
	wram_bank $01 ; $4223
	ld hl, CharDataScreenUIGraphicsGfx5 ; $4229
	ld de, wDecompBuffer + 62 * TILE_SIZE ; $422c
	call DecompressData ; $422f
	ld hl, wDecompBuffer + 62 * TILE_SIZE ; $4232
	ld bc, $0021 ; $4235
	call CopyWram1ToWram2 ; $4238
	wram_bank $01 ; $423b
	ld hl, CharDataScreenUIGraphicsGfx6 ; $4241
	ld de, wDecompBuffer + 65 * TILE_SIZE ; $4244
	call DecompressData ; $4247
	ld hl, wDecompBuffer + 65 * TILE_SIZE ; $424a
	ld bc, $0018 ; $424d
	call CopyWram1ToWram3 ; $4250
	wram_bank $01 ; $4253
	ld hl, CharDataScreenUIGraphicsGfx7 ; $4259
	ld de, wDecompBuffer + 65 * TILE_SIZE ; $425c
	call DecompressData ; $425f
	ld hl, wDecompBuffer + 65 * TILE_SIZE ; $4262
	ld bc, $0018 ; $4265
	call CopyWram1ToWram2 ; $4268
	wram_bank $01 ; $426b
	ld hl, CharDataScreenUIGraphicsGfx2 ; $4271
	ld de, wDecompBuffer + 58 * TILE_SIZE ; $4274
	call DecompressData ; $4277
	ld hl, wDecompBuffer + 58 * TILE_SIZE ; $427a
	ld bc, $0033 ; $427d
	call CopyWram1ToWram3 ; $4280
	wram_bank $01 ; $4283
	ld hl, CharDataScreenUIGraphicsGfx3 ; $4289
	ld de, wDecompBuffer + 58 * TILE_SIZE ; $428c
	call DecompressData ; $428f
	ld hl, wDecompBuffer + 58 * TILE_SIZE ; $4292
	ld bc, $0033 ; $4295
	call CopyWram1ToWram2 ; $4298
	wram_bank $01 ; $429b
	ld hl, CharDataScreenUIGraphicsGfx0 ; $42a1
	ld de, wDecompBuffer + 56 * TILE_SIZE ; $42a4
	call DecompressData ; $42a7
	ld hl, wDecompBuffer + 56 * TILE_SIZE ; $42aa
	ld bc, $001e ; $42ad
	call CopyWram1ToWram3 ; $42b0
	wram_bank $01 ; $42b3
	ld hl, CharDataScreenUIGraphicsGfx1 ; $42b9
	ld de, wDecompBuffer + 56 * TILE_SIZE ; $42bc
	call DecompressData ; $42bf
	ld hl, wDecompBuffer + 56 * TILE_SIZE ; $42c2
	ld bc, $001e ; $42c5
	call CopyWram1ToWram2 ; $42c8
	ret ; $42cb
CopyWram1ToWram3:
	wram_bank $01 ; $42cc
	ld d, [hl] ; $42d2
	wram_bank $03 ; $42d3
	ld [hl], d ; $42d9
	inc hl ; $42da
	dec bc ; $42db
	ld a, b ; $42dc
	or c ; $42dd
	jr nz, CopyWram1ToWram3 ; $42de
	ret ; $42e0
CopyWram1ToWram2:
	wram_bank $01 ; $42e1
	ld d, [hl] ; $42e7
	wram_bank $02 ; $42e8
	ld [hl], d ; $42ee
	inc hl ; $42ef
	dec bc ; $42f0
	ld a, b ; $42f1
	or c ; $42f2
	jr nz, CopyWram1ToWram2 ; $42f3
	ret ; $42f5
CharDataScreen_DrawStats:
	wram_bank $06 ; $42f6
	ld a, [wCharDataViewOnly] ; $42fc
	or a ; $42ff
	jr z, .statsReady ; $4300
	call LoadCharStats ; $4302
.statsReady:
	farcall CharDataScreen_BuildStats ; $4305
	wram_bank $06 ; $4308
	ld a, [wCharDataStats] ; $430e
	ld c, a ; $4311
	ld a, [wCharDataStatDeltas] ; $4312
	add c ; $4315
	push af ; $4316
	ld h, $00 ; $4317
	ld l, a ; $4319
	ld a, $02 ; $431a
	ld de, wCharDataNumberBuffer ; $431c
	call FormatDecimalNumberUnsigned ; $431f
	ld de, wCharDataScreenCell + 18 * TILEMAP_WIDTH + 17 ; $4322
	call CharDataScreen_WriteStatNumber ; $4325
	pop af ; $4328
	ld c, $00 ; $4329
	ld de, wCharDataScreenCell + 18 * TILEMAP_WIDTH + 22 ; $432b
	call CharDataScreen_DrawStatBar ; $432e
	wram_bank $06 ; $4331
	ld a, [wCharDataStats + 1] ; $4337
	ld c, a ; $433a
	ld a, [wCharDataStatDeltas + 1] ; $433b
	add c ; $433e
	push af ; $433f
	ld h, $00 ; $4340
	ld l, a ; $4342
	ld a, $02 ; $4343
	ld de, wCharDataNumberBuffer ; $4345
	call FormatDecimalNumberUnsigned ; $4348
	ld de, wCharDataScreenCell + 19 * TILEMAP_WIDTH + 5 ; $434b
	call CharDataScreen_WriteStatNumber ; $434e
	pop af ; $4351
	ld c, $01 ; $4352
	ld de, wCharDataScreenCell + 19 * TILEMAP_WIDTH + 10 ; $4354
	call CharDataScreen_DrawStatBar ; $4357
	wram_bank $06 ; $435a
	ld a, [wCharDataStats + 2] ; $4360
	ld c, a ; $4363
	ld a, [wCharDataStatDeltas + 2] ; $4364
	add c ; $4367
	push af ; $4368
	ld h, $00 ; $4369
	ld l, a ; $436b
	ld a, $02 ; $436c
	ld de, wCharDataNumberBuffer ; $436e
	call FormatDecimalNumberUnsigned ; $4371
	ld de, wCharDataScreenCell + 20 * TILEMAP_WIDTH + 17 ; $4374
	call CharDataScreen_WriteStatNumber ; $4377
	pop af ; $437a
	ld c, $00 ; $437b
	ld de, wCharDataScreenCell + 20 * TILEMAP_WIDTH + 22 ; $437d
	call CharDataScreen_DrawStatBar ; $4380
	wram_bank $06 ; $4383
	ld a, [wCharDataStats + 3] ; $4389
	ld c, a ; $438c
	ld a, [wCharDataStatDeltas + 3] ; $438d
	add c ; $4390
	push af ; $4391
	ld h, $00 ; $4392
	ld l, a ; $4394
	ld a, $02 ; $4395
	ld de, wCharDataNumberBuffer ; $4397
	call FormatDecimalNumberUnsigned ; $439a
	ld de, wCharDataScreenCell + 21 * TILEMAP_WIDTH + 5 ; $439d
	call CharDataScreen_WriteStatNumber ; $43a0
	pop af ; $43a3
	ld c, $00 ; $43a4
	ld de, wCharDataScreenCell + 21 * TILEMAP_WIDTH + 10 ; $43a6
	call CharDataScreen_DrawStatBar ; $43a9
	wram_bank $06 ; $43ac
	ld a, [wCharDataStats + 4] ; $43b2
	ld c, a ; $43b5
	ld a, [wCharDataStatDeltas + 4] ; $43b6
	add c ; $43b9
	push af ; $43ba
	ld h, $00 ; $43bb
	ld l, a ; $43bd
	ld a, $02 ; $43be
	ld de, wCharDataNumberBuffer ; $43c0
	call FormatDecimalNumberUnsigned ; $43c3
	ld de, wCharDataScreenCell + 21 * TILEMAP_WIDTH + 25 ; $43c6
	call CharDataScreen_WriteStatNumber ; $43c9
	pop af ; $43cc
	ld c, $01 ; $43cd
	ld de, wCharDataScreenCell + 21 * TILEMAP_WIDTH + 30 ; $43cf
	call CharDataScreen_DrawStatBar ; $43d2
	wram_bank $06 ; $43d5
	ld a, [wCharDataStats + 5] ; $43db
	ld c, a ; $43de
	ld a, [wCharDataStatDeltas + 5] ; $43df
	add c ; $43e2
	push af ; $43e3
	ld h, $00 ; $43e4
	ld l, a ; $43e6
	ld a, $02 ; $43e7
	ld de, wCharDataNumberBuffer ; $43e9
	call FormatDecimalNumberUnsigned ; $43ec
	ld de, wCharDataScreenCell + 23 * TILEMAP_WIDTH + 1 ; $43ef
	call CharDataScreen_WriteStatNumber ; $43f2
	pop af ; $43f5
	ld c, $00 ; $43f6
	ld de, wCharDataScreenCell + 23 * TILEMAP_WIDTH + 6 ; $43f8
	call CharDataScreen_DrawStatBar ; $43fb
	wram_bank $06 ; $43fe
	ld a, [wCharDataStats + 6] ; $4404
	ld c, a ; $4407
	ld a, [wCharDataStatDeltas + 6] ; $4408
	add c ; $440b
	push af ; $440c
	ld h, $00 ; $440d
	ld l, a ; $440f
	ld a, $02 ; $4410
	ld de, wCharDataNumberBuffer ; $4412
	call FormatDecimalNumberUnsigned ; $4415
	ld de, wCharDataScreenCell + 23 * TILEMAP_WIDTH + 21 ; $4418
	call CharDataScreen_WriteStatNumber ; $441b
	pop af ; $441e
	ld c, $01 ; $441f
	ld de, wCharDataScreenCell + 23 * TILEMAP_WIDTH + 26 ; $4421
	call CharDataScreen_DrawStatBar ; $4424
	wram_bank $06 ; $4427
	ld a, [wCharDataStats + 7] ; $442d
	ld c, a ; $4430
	ld a, [wCharDataStatDeltas + 7] ; $4431
	add c ; $4434
	push af ; $4435
	ld h, $00 ; $4436
	ld l, a ; $4438
	ld a, $02 ; $4439
	ld de, wCharDataNumberBuffer ; $443b
	call FormatDecimalNumberUnsigned ; $443e
	ld de, wCharDataScreenCell + 25 * TILEMAP_WIDTH + 1 ; $4441
	call CharDataScreen_WriteStatNumber ; $4444
	pop af ; $4447
	ld c, $00 ; $4448
	ld de, wCharDataScreenCell + 25 * TILEMAP_WIDTH + 6 ; $444a
	call CharDataScreen_DrawStatBar ; $444d
	wram_bank $06 ; $4450
	ld a, [wCharDataStats + 8] ; $4456
	ld c, a ; $4459
	ld a, [wCharDataStatDeltas + 8] ; $445a
	add c ; $445d
	push af ; $445e
	ld h, $00 ; $445f
	ld l, a ; $4461
	ld a, $02 ; $4462
	ld de, wCharDataNumberBuffer ; $4464
	call FormatDecimalNumberUnsigned ; $4467
	ld de, wCharDataScreenCell + 25 * TILEMAP_WIDTH + 21 ; $446a
	call CharDataScreen_WriteStatNumber ; $446d
	pop af ; $4470
	ld c, $00 ; $4471
	ld de, wCharDataScreenCell + 25 * TILEMAP_WIDTH + 26 ; $4473
	call CharDataScreen_DrawStatBar ; $4476
	wram_bank $06 ; $4479
	ld a, [wCharDataStats + 9] ; $447f
	ld c, a ; $4482
	ld a, [wCharDataStatDeltas + 9] ; $4483
	add c ; $4486
	push af ; $4487
	ld h, $00 ; $4488
	ld l, a ; $448a
	ld a, $02 ; $448b
	ld de, wCharDataNumberBuffer ; $448d
	call FormatDecimalNumberUnsigned ; $4490
	ld de, wCharDataScreenCell + 26 * TILEMAP_WIDTH + 9 ; $4493
	call CharDataScreen_WriteStatNumber ; $4496
	pop af ; $4499
	ld c, $00 ; $449a
	ld de, wCharDataScreenCell + 26 * TILEMAP_WIDTH + 14 ; $449c
	call CharDataScreen_DrawStatBar ; $449f
	wram_bank $06 ; $44a2
	ld a, [wCharDataStats + 10] ; $44a8
	ld c, a ; $44ab
	ld a, [wCharDataStatDeltas + 10] ; $44ac
	add c ; $44af
	push af ; $44b0
	ld h, $00 ; $44b1
	ld l, a ; $44b3
	ld a, $02 ; $44b4
	ld de, wCharDataNumberBuffer ; $44b6
	call FormatDecimalNumberUnsigned ; $44b9
	ld de, wCharDataScreenCell + 26 * TILEMAP_WIDTH + 29 ; $44bc
	call CharDataScreen_WriteStatNumber ; $44bf
	pop af ; $44c2
	ld c, $01 ; $44c3
	ld de, wScreenAttrmap + 27 * TILEMAP_WIDTH + 2 ; $44c5
	call CharDataScreen_DrawStatBar ; $44c8
	ret ; $44cb
CharDataScreen_WriteStatNumber:
	wram_bank $06 ; $44cc
	ld a, [wCharDataNumberBuffer] ; $44d2
	ld c, a ; $44d5
	wram_bank $03 ; $44d6
	ld a, c ; $44dc
	ld [de], a ; $44dd
	wram_bank $02 ; $44de
	xor a ; $44e4
	ld [de], a ; $44e5
	inc de ; $44e6
	wram_bank $06 ; $44e7
	ld a, [wCharDataNumberBuffer + 1] ; $44ed
	ld c, a ; $44f0
	wram_bank $03 ; $44f1
	ld a, c ; $44f7
	ld [de], a ; $44f8
	wram_bank $02 ; $44f9
	xor a ; $44ff
	ld [de], a ; $4500
	ret ; $4501
CharDataScreen_DrawStatBar:
	ld b, a ; $4502
	ld a, c ; $4503
	or a ; $4504
	jr nz, .altTable ; $4505
	ld a, b ; $4507
	rlca ; $4508
	add LOW(CharDataScreen_DrawStatBarPtrs) ; $4509
	ld l, a ; $450b
	adc HIGH(CharDataScreen_DrawStatBarPtrs) ; $450c
	sub l ; $450e
	ld h, a ; $450f
	ld a, [hl+] ; $4510
	ld h, [hl] ; $4511
	ld l, a ; $4512
	jr .copyTiles ; $4513
.altTable:
	ld a, b ; $4515
	rlca ; $4516
	add LOW(CharDataScreen_DrawStatBarTable0) ; $4517
	ld l, a ; $4519
	adc HIGH(CharDataScreen_DrawStatBarTable0) ; $451a
	sub l ; $451c
	ld h, a ; $451d
	ld a, [hl+] ; $451e
	ld h, [hl] ; $451f
	ld l, a ; $4520
.copyTiles:
	push de ; $4521
	wram_bank $03 ; $4522
	ld a, [hl+] ; $4528
	ld [de], a ; $4529
	inc de ; $452a
	ld a, [hl+] ; $452b
	ld [de], a ; $452c
	inc de ; $452d
	ld a, [hl+] ; $452e
	ld [de], a ; $452f
	inc de ; $4530
	ld a, [hl+] ; $4531
	ld [de], a ; $4532
	inc de ; $4533
	ld a, [hl] ; $4534
	ld [de], a ; $4535
	wram_bank $02 ; $4536
	ld a, b ; $453c
	rlca ; $453d
	add LOW(CharDataScreen_DrawStatBarTable1) ; $453e
	ld l, a ; $4540
	adc HIGH(CharDataScreen_DrawStatBarTable1) ; $4541
	sub l ; $4543
	ld h, a ; $4544
	ld a, [hl+] ; $4545
	ld h, [hl] ; $4546
	ld l, a ; $4547
	pop de ; $4548
	ld a, [hl+] ; $4549
	ld [de], a ; $454a
	inc de ; $454b
	ld a, [hl+] ; $454c
	ld [de], a ; $454d
	inc de ; $454e
	ld a, [hl+] ; $454f
	ld [de], a ; $4550
	inc de ; $4551
	ld a, [hl+] ; $4552
	ld [de], a ; $4553
	inc de ; $4554
	ld a, [hl] ; $4555
	ld [de], a ; $4556
	ret ; $4557
CharDataScreen_DrawStatBarPtrs:
	; $4558, 22 bytes (records:2)
	dw CharDataScreenStatBar00 ; record 0
	dw CharDataScreenStatBar01 ; record 1
	dw CharDataScreenStatBar02 ; record 2
	dw CharDataScreenStatBar03 ; record 3
	dw CharDataScreenStatBar04 ; record 4
	dw CharDataScreenStatBar05 ; record 5
	dw CharDataScreenStatBar06 ; record 6
	dw CharDataScreenStatBar07 ; record 7
	dw CharDataScreenStatBar08 ; record 8
	dw CharDataScreenStatBar09 ; record 9
	dw CharDataScreenStatBar10 ; record 10
CharDataScreen_DrawStatBarTable0:
	INCBIN "data/bank_01c/d_456e.bin" ; $456e, 22 bytes
CharDataScreen_DrawStatBarTable1:
	INCBIN "data/bank_01c/d_4584.bin" ; $4584, 22 bytes
CharDataScreen_DrawPortrait:
	push af ; $459a
	ld hl, wStoryModeNameOfMainCharacter ; $459b
	ld a, [wStoryCharacterSlot] ; $459e
	or a ; $45a1
	jr z, .zero ; $45a2
	ld l, $40 ; $45a4
.zero:
	ld a, l ; $45a6
	add $0c ; $45a7
	ld l, a ; $45a9
	ld a, h ; $45aa
	adc $00 ; $45ab
	ld h, a ; $45ad
	pop af ; $45ae
	ld a, [hl] ; $45af
	ld de, $0401 ; $45b0
	farcall LoadIndexedPaletteThunk ; $45b3
	wram_bank $01 ; $45b6
	push af ; $45bc
	ld hl, wStoryModeNameOfMainCharacter ; $45bd
	ld a, [wStoryCharacterSlot] ; $45c0
	or a ; $45c3
	jr z, .zero2 ; $45c4
	ld l, $40 ; $45c6
.zero2:
	ld a, l ; $45c8
	add $0b ; $45c9
	ld l, a ; $45cb
	ld a, h ; $45cc
	adc $00 ; $45cd
	ld h, a ; $45cf
	pop af ; $45d0
	ld a, [hl] ; $45d1
	ld de, wDecompBuffer ; $45d2
	farcall DecompressCharMugshot ; $45d5
	ld hl, wDecompBuffer ; $45d8
	ld de, $9200 + VRAM_BANK1 ; $45db
	ld c, $03 ; $45de
	call QueueVRAMCopy ; $45e0
	ld hl, wDecompBuffer + 3 * TILE_SIZE ; $45e3
	ld de, $9300 + VRAM_BANK1 ; $45e6
	ld c, $03 ; $45e9
	call QueueVRAMCopy ; $45eb
	ld hl, wDecompBuffer + 6 * TILE_SIZE ; $45ee
	ld de, $9400 + VRAM_BANK1 ; $45f1
	ld c, $03 ; $45f4
	call QueueVRAMCopy ; $45f6
	ret ; $45f9
CharDataScreenAnimTask:
	push af ; $45fa
	push bc ; $45fb
	push de ; $45fc
	push hl ; $45fd
	ldh a, [hWramBank] ; $45fe
	push af ; $4600
	wram_bank $06 ; $4601
	ld a, [wCharDataFlushChunk] ; $4607
	or a ; $460a
	jp nz, .nonZero ; $460b
	wram_bank $06 ; $460e
	ld a, [wCharDataAnimCounter] ; $4614
	inc a ; $4617
	ld [wCharDataAnimCounter], a ; $4618
	and $0f ; $461b
	rlca ; $461d
	push af ; $461e
	add LOW(Unused_1c_0) ; $461f
	ld l, a ; $4621
	adc HIGH(Unused_1c_0) ; $4622
	sub l ; $4624
	ld h, a ; $4625
	ld a, [hl+] ; $4626
	ld h, [hl] ; $4627
	ld l, a ; $4628
	push hl ; $4629
	ld de, $92e0 + VRAM_BANK1 ; $462a
	ld c, $02 ; $462d
	call QueueVRAMCopy ; $462f
	pop hl ; $4632
	ld a, $20 ; $4633
	add l ; $4635
	ld l, a ; $4636
	jr nc, .queueVRAMCopy ; $4637
	inc h ; $4639
.queueVRAMCopy:
	ld de, $93e0 + VRAM_BANK1 ; $463a
	ld c, $02 ; $463d
	call QueueVRAMCopy ; $463f
	pop af ; $4642
	add LOW(CharDataScreenAnimTask_CharDataFlushChunkTable) ; $4643
	ld l, a ; $4645
	adc HIGH(CharDataScreenAnimTask_CharDataFlushChunkTable) ; $4646
	sub l ; $4648
	ld h, a ; $4649
	ld a, [hl+] ; $464a
	ld h, [hl] ; $464b
	ld l, a ; $464c
	push hl ; $464d
	ld de, $94e0 + VRAM_BANK1 ; $464e
	ld c, $02 ; $4651
	call QueueVRAMCopy ; $4653
	pop hl ; $4656
	ld a, $20 ; $4657
	add l ; $4659
	ld l, a ; $465a
	jr nc, .queueVRAMCopy2 ; $465b
	inc h ; $465d
.queueVRAMCopy2:
	ld de, $95e0 + VRAM_BANK1 ; $465e
	ld c, $02 ; $4661
	call QueueVRAMCopy ; $4663
.nonZero:
	wram_bank $06 ; $4666
	ld a, [wCharDataFlushChunk] ; $466c
	inc a ; $466f
	cp $03 ; $4670
	jr nz, .store ; $4672
	xor a ; $4674
.store:
	ld [wCharDataFlushChunk], a ; $4675
	pop af ; $4678
	wram_bank ; $4679
	pop hl ; $467d
	pop de ; $467e
	pop bc ; $467f
	pop af ; $4680
	ret ; $4681
AnimateCharDataStatsReveal:
	sound BGM_STAT_DISTRIBUTION ; $4682
	call BackupCharDataScreenRow ; $4684
	wram_bank $06 ; $4687
.loop:
	call AdvanceFrame ; $468d
	ld a, [wCharDataFlushChunk] ; $4690
	or a ; $4693
	jr nz, .loop ; $4694
	call RestoreCharDataScreenRow ; $4696
	ld hl, CharDataBand0RunsStep1_1c ; $4699
	ld bc, wScreenAttrmap + 18 * TILEMAP_WIDTH ; $469c
	call BlitTilemapRunsFromTable ; $469f
	ld hl, CharDataBand3RunsStep1_1c ; $46a2
	ld bc, wScreenAttrmap + 24 * TILEMAP_WIDTH + 16 ; $46a5
	call BlitTilemapRunsFromTable ; $46a8
	wram_bank $06 ; $46ab
	ld a, $09 ; $46b1
	ld [wCharDataRevealTimer], a ; $46b3
	call FlushCharDataTilemaps ; $46b6
	call RestoreCharDataScreenRow ; $46b9
	ld hl, CharDataBand0RunsStep2_1c ; $46bc
	ld bc, wScreenAttrmap + 18 * TILEMAP_WIDTH ; $46bf
	call BlitTilemapRunsFromTable ; $46c2
	ld hl, CharDataBand1RunsStep1_1c ; $46c5
	ld bc, wScreenAttrmap + 20 * TILEMAP_WIDTH ; $46c8
	call BlitTilemapRunsFromTable ; $46cb
	ld hl, CharDataBand2RunsStep1_1c ; $46ce
	ld bc, wScreenAttrmap + 22 * TILEMAP_WIDTH + 16 ; $46d1
	call BlitTilemapRunsFromTable ; $46d4
	ld hl, CharDataBand3RunsStep2_1c ; $46d7
	ld bc, wScreenAttrmap + 24 * TILEMAP_WIDTH + 16 ; $46da
	call BlitTilemapRunsFromTable ; $46dd
	wram_bank $06 ; $46e0
	ld a, $07 ; $46e6
	ld [wCharDataRevealTimer], a ; $46e8
	call FlushCharDataTilemaps ; $46eb
	call RestoreCharDataScreenRow ; $46ee
	ld hl, CharDataBand0RunsStep3_1c ; $46f1
	ld bc, wScreenAttrmap + 18 * TILEMAP_WIDTH ; $46f4
	call BlitTilemapRunsFromTable ; $46f7
	ld hl, CharDataBand1RunsStep2_1c ; $46fa
	ld bc, wScreenAttrmap + 20 * TILEMAP_WIDTH ; $46fd
	call BlitTilemapRunsFromTable ; $4700
	ld hl, CharDataBand2RunsStep2_1c ; $4703
	ld bc, wScreenAttrmap + 22 * TILEMAP_WIDTH + 16 ; $4706
	call BlitTilemapRunsFromTable ; $4709
	ld hl, CharDataBand3RunsStep3_1c ; $470c
	ld bc, wScreenAttrmap + 24 * TILEMAP_WIDTH + 16 ; $470f
	call BlitTilemapRunsFromTable ; $4712
	wram_bank $06 ; $4715
	ld a, $05 ; $471b
	ld [wCharDataRevealTimer], a ; $471d
	call FlushCharDataTilemaps ; $4720
	call RestoreCharDataScreenRow ; $4723
	ld hl, CharDataBand0RunsStep4_1c ; $4726
	ld bc, wScreenAttrmap + 18 * TILEMAP_WIDTH ; $4729
	call BlitTilemapRunsFromTable ; $472c
	ld hl, CharDataBand1RunsStep3_1c ; $472f
	ld bc, wScreenAttrmap + 20 * TILEMAP_WIDTH ; $4732
	call BlitTilemapRunsFromTable ; $4735
	ld hl, CharDataBand2RunsStep3_1c ; $4738
	ld bc, wScreenAttrmap + 22 * TILEMAP_WIDTH + 16 ; $473b
	call BlitTilemapRunsFromTable ; $473e
	ld hl, CharDataBand3RunsStep4_1c ; $4741
	ld bc, wScreenAttrmap + 24 * TILEMAP_WIDTH + 16 ; $4744
	call BlitTilemapRunsFromTable ; $4747
	wram_bank $06 ; $474a
	ld a, $03 ; $4750
	ld [wCharDataRevealTimer], a ; $4752
	call FlushCharDataTilemaps ; $4755
	call RestoreCharDataScreenRow ; $4758
	ld hl, CharDataBand0RunsStep5_1c ; $475b
	ld bc, wScreenAttrmap + 18 * TILEMAP_WIDTH ; $475e
	call BlitTilemapRunsFromTable ; $4761
	ld hl, CharDataBand1RunsStep4_1c ; $4764
	ld bc, wScreenAttrmap + 20 * TILEMAP_WIDTH ; $4767
	call BlitTilemapRunsFromTable ; $476a
	ld hl, CharDataBand2RunsStep4_1c ; $476d
	ld bc, wScreenAttrmap + 22 * TILEMAP_WIDTH + 16 ; $4770
	call BlitTilemapRunsFromTable ; $4773
	ld hl, CharDataBand3RunsStep5_1c ; $4776
	ld bc, wScreenAttrmap + 24 * TILEMAP_WIDTH + 16 ; $4779
	call BlitTilemapRunsFromTable ; $477c
	wram_bank $06 ; $477f
	ld a, $02 ; $4785
	ld [wCharDataRevealTimer], a ; $4787
	call FlushCharDataTilemaps ; $478a
	call RestoreCharDataScreenRow ; $478d
	ld hl, CharDataBand0RunsStep6_1c ; $4790
	ld bc, wScreenAttrmap + 18 * TILEMAP_WIDTH ; $4793
	call BlitTilemapRunsFromTable ; $4796
	ld hl, CharDataBand1RunsStep5_1c ; $4799
	ld bc, wScreenAttrmap + 20 * TILEMAP_WIDTH ; $479c
	call BlitTilemapRunsFromTable ; $479f
	ld hl, CharDataBand2RunsStep5_1c ; $47a2
	ld bc, wScreenAttrmap + 22 * TILEMAP_WIDTH + 16 ; $47a5
	call BlitTilemapRunsFromTable ; $47a8
	ld hl, CharDataBand3RunsStep6_1c ; $47ab
	ld bc, wScreenAttrmap + 24 * TILEMAP_WIDTH + 16 ; $47ae
	call BlitTilemapRunsFromTable ; $47b1
	wram_bank $06 ; $47b4
	ld a, $01 ; $47ba
	ld [wCharDataRevealTimer], a ; $47bc
	call FlushCharDataTilemaps ; $47bf
	call RestoreCharDataScreenRow ; $47c2
	ld hl, CharDataBand0RunsStep7_1c ; $47c5
	ld bc, wScreenAttrmap + 18 * TILEMAP_WIDTH ; $47c8
	call BlitTilemapRunsFromTable ; $47cb
	ld hl, CharDataBand1RunsStep6_1c ; $47ce
	ld bc, wScreenAttrmap + 20 * TILEMAP_WIDTH ; $47d1
	call BlitTilemapRunsFromTable ; $47d4
	ld hl, CharDataBand2RunsStep6_1c ; $47d7
	ld bc, wScreenAttrmap + 22 * TILEMAP_WIDTH + 16 ; $47da
	call BlitTilemapRunsFromTable ; $47dd
	ld hl, CharDataBand3RunsStep7_1c ; $47e0
	ld bc, wScreenAttrmap + 24 * TILEMAP_WIDTH + 16 ; $47e3
	call BlitTilemapRunsFromTable ; $47e6
	wram_bank $06 ; $47e9
	ld hl, wCharDataPageArrowMode ; $47ef
	dec [hl] ; $47f2
	xor a ; $47f3
	ld [wCharDataRevealTimer], a ; $47f4
	call FlushCharDataTilemaps ; $47f7
	call WaitFramesCmd ; $47fa
	db $06 ; $47fd inline arg
	ld hl, CharDataBand4RunsStep1_1c ; $47fe
	ld bc, wScreenAttrmap + 27 * TILEMAP_WIDTH + 16 ; $4801
	call BlitTilemapRunsFromTable ; $4804
	call FlushCharDataTilemaps ; $4807
	ld hl, CharDataBand4RunsStep2_1c ; $480a
	ld bc, wScreenAttrmap + 27 * TILEMAP_WIDTH + 16 ; $480d
	call BlitTilemapRunsFromTable ; $4810
	call FlushCharDataTilemaps ; $4813
	ld hl, CharDataBand4RunsStep3_1c ; $4816
	ld bc, wScreenAttrmap + 27 * TILEMAP_WIDTH + 16 ; $4819
	call BlitTilemapRunsFromTable ; $481c
	call FlushCharDataTilemaps ; $481f
	ld hl, CharDataBand6RunsStep1_1c ; $4822
	ld bc, wScreenAttrmap + 29 * TILEMAP_WIDTH ; $4825
	call BlitTilemapRunsFromTable ; $4828
	ld hl, CharDataBand5RunsStep1_1c ; $482b
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH ; $482e
	call BlitTilemapRunsFromTable ; $4831
	wram_bank $06 ; $4834
	ld a, $02 ; $483a
	ld [wCharDataRevealStep], a ; $483c
	call FlushCharDataTilemaps ; $483f
	ld hl, CharDataBand6RunsStep2_1c ; $4842
	ld bc, wScreenAttrmap + 29 * TILEMAP_WIDTH ; $4845
	call BlitTilemapRunsFromTable ; $4848
	ld hl, CharDataBand5RunsStep2_1c ; $484b
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH ; $484e
	call BlitTilemapRunsFromTable ; $4851
	wram_bank $06 ; $4854
	ld a, $01 ; $485a
	ld [wCharDataRevealStep], a ; $485c
	call FlushCharDataTilemaps ; $485f
	ld hl, CharDataBand6RunsStep3_1c ; $4862
	ld bc, wScreenAttrmap + 29 * TILEMAP_WIDTH ; $4865
	call BlitTilemapRunsFromTable ; $4868
	ld hl, CharDataBand5RunsStep3_1c ; $486b
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH ; $486e
	call BlitTilemapRunsFromTable ; $4871
	wram_bank $06 ; $4874
	xor a ; $487a
	ld [wCharDataRevealStep], a ; $487b
	call FlushCharDataTilemaps ; $487e
	ret ; $4881
DrawCharStatsAndFlush:
	call DrawCharStatRows ; $4882
	ld hl, CharDataBand6RunsStep3_1c ; $4885
	ld bc, wScreenAttrmap + 29 * TILEMAP_WIDTH ; $4888
	call BlitTilemapRunsFromTable ; $488b
	ld hl, CharDataBand5RunsStep3_1c ; $488e
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH ; $4891
	call BlitTilemapRunsFromTable ; $4894
	call FlushCharDataTilemaps ; $4897
	ret ; $489a
DrawCharStatRows:
	ld hl, CharDataBand0RunsStep7_1c ; $489b
	ld bc, wScreenAttrmap + 18 * TILEMAP_WIDTH ; $489e
	call BlitTilemapRunsFromTable ; $48a1
	ld hl, CharDataBand1RunsStep6_1c ; $48a4
	ld bc, wScreenAttrmap + 20 * TILEMAP_WIDTH ; $48a7
	call BlitTilemapRunsFromTable ; $48aa
	ld hl, CharDataBand2RunsStep6_1c ; $48ad
	ld bc, wScreenAttrmap + 22 * TILEMAP_WIDTH + 16 ; $48b0
	call BlitTilemapRunsFromTable ; $48b3
	ld hl, CharDataBand3RunsStep7_1c ; $48b6
	ld bc, wScreenAttrmap + 24 * TILEMAP_WIDTH + 16 ; $48b9
	call BlitTilemapRunsFromTable ; $48bc
	ld hl, CharDataBand4RunsStep3_1c ; $48bf
	ld bc, wScreenAttrmap + 27 * TILEMAP_WIDTH + 16 ; $48c2
	call BlitTilemapRunsFromTable ; $48c5
	ret ; $48c8
BackupCharDataScreenRow:
	wram_bank $03 ; $48c9
	ld hl, wShadowTilemap ; $48cf
	ld de, wShadowAttrmap + 1 * TILEMAP_WIDTH + 16 ; $48d2
	ld c, $24 ; $48d5
	call CopyMemoryFast ; $48d7
	wram_bank $02 ; $48da
	ld hl, wScreenAttrmap ; $48e0
	ld de, $d430 ; $48e3
	ld c, $24 ; $48e6
	call CopyMemoryFast ; $48e8
	ret ; $48eb
RestoreCharDataScreenRow:
	wram_bank $03 ; $48ec
	ld hl, wShadowAttrmap + 1 * TILEMAP_WIDTH + 16 ; $48f2
	ld de, wShadowTilemap ; $48f5
	ld c, $24 ; $48f8
	call CopyMemoryFast ; $48fa
	wram_bank $02 ; $48fd
	ld hl, $d430 ; $4903
	ld de, wScreenAttrmap ; $4906
	ld c, $24 ; $4909
	call CopyMemoryFast ; $490b
	ret ; $490e
BlitTilemapRunsFromTable:
	ld a, [hl] ; $490f
	cp $ff ; $4910
	ret z ; $4912
	push hl ; $4913
	ld d, [hl] ; $4914
	inc hl ; $4915
	ld e, [hl] ; $4916
	push hl ; $4917
	ld hl, wScreenAttrmap ; $4918
	add hl, de ; $491b
	ld d, h ; $491c
	ld e, l ; $491d
	pop hl ; $491e
	inc hl ; $491f
	push hl ; $4920
	ld a, [hl] ; $4921
	ld h, b ; $4922
	ld l, c ; $4923
	add l ; $4924
	ld l, a ; $4925
	jr nc, .gotSrc ; $4926
	inc h ; $4928
.gotSrc:
	wram_bank $06 ; $4929
	ld a, l ; $492f
	ld [wCharDataNumberBuffer], a ; $4930
	ld a, h ; $4933
	ld [wCharDataNumberBuffer + 1], a ; $4934
	pop hl ; $4937
	push bc ; $4938
	inc hl ; $4939
	ld c, [hl] ; $493a
	ld hl, wCharDataNumberBuffer ; $493b
	ld a, [hl+] ; $493e
	ld h, [hl] ; $493f
	ld l, a ; $4940
.copyLoop:
	wram_bank $03 ; $4941
	ld a, [hl] ; $4947
	ld [de], a ; $4948
	wram_bank $02 ; $4949
	ld a, [hl+] ; $494f
	ld [de], a ; $4950
	inc de ; $4951
	dec c ; $4952
	jr nz, .copyLoop ; $4953
	pop bc ; $4955
	pop hl ; $4956
	inc hl ; $4957
	inc hl ; $4958
	inc hl ; $4959
	inc hl ; $495a
	jr BlitTilemapRunsFromTable ; $495b
FlushCharDataTilemaps:
	call FlushCharDataTilemapChunk ; $495d
	call FlushCharDataTilemapChunk ; $4960
	call FlushCharDataTilemapChunk ; $4963
	ret ; $4966
FlushCharDataTilemapChunk:
	wram_bank $06 ; $4967
	ld a, [wCharDataFlushChunk] ; $496d
	inc a ; $4970
	dec a ; $4971
	jr z, .countDone ; $4972
	dec a ; $4974
	jr z, .countDone2 ; $4975
	jr .queueVRAMCopy ; $4977
.countDone:
	wram_bank $03 ; $4979
	ld hl, wShadowTilemap + 15 * TILEMAP_WIDTH ; $497f
	ld de, $99e0 ; $4982
	ld c, $06 ; $4985
	call QueueVRAMCopy ; $4987
	wram_bank $02 ; $498a
	ld hl, wScreenAttrmap + 15 * TILEMAP_WIDTH ; $4990
	ld de, $99e0 + VRAM_BANK1 ; $4993
	ld c, $06 ; $4996
	call QueueVRAMCopy ; $4998
	call AdvanceFrame ; $499b
	ret ; $499e
.countDone2:
	wram_bank $03 ; $499f
	ld hl, wShadowTilemap + 7 * TILEMAP_WIDTH ; $49a5
	ld de, $98e0 ; $49a8
	ld c, $10 ; $49ab
	call QueueVRAMCopy ; $49ad
	wram_bank $02 ; $49b0
	ld hl, wScreenAttrmap + 7 * TILEMAP_WIDTH ; $49b6
	ld de, $98e0 + VRAM_BANK1 ; $49b9
	ld c, $10 ; $49bc
	call QueueVRAMCopy ; $49be
	call AdvanceFrame ; $49c1
	ret ; $49c4
.queueVRAMCopy:
	wram_bank $03 ; $49c5
	ld hl, wShadowTilemap ; $49cb
	ld de, $9800 ; $49ce
	ld c, $0e ; $49d1
	call QueueVRAMCopy ; $49d3
	wram_bank $02 ; $49d6
	ld hl, wScreenAttrmap ; $49dc
	ld de, $9800 + VRAM_BANK1 ; $49df
	ld c, $0e ; $49e2
	call QueueVRAMCopy ; $49e4
	call AdvanceFrame ; $49e7
	ret ; $49ea
WriteCharStatsToDisplayBuffer:
	wram_bank $06 ; $49eb
	ld a, [wCharDataPointsWorking] ; $49f1
	ld [wCharDataPointsLeft], a ; $49f4
	push af ; $49f7
	ld hl, wStoryModeNameOfMainCharacter ; $49f8
	ld a, [wStoryCharacterSlot] ; $49fb
	or a ; $49fe
	jr z, .zero ; $49ff
	ld l, $40 ; $4a01
.zero:
	ld a, l ; $4a03
	add $18 ; $4a04
	ld l, a ; $4a06
	ld a, h ; $4a07
	adc $00 ; $4a08
	ld h, a ; $4a0a
	pop af ; $4a0b
	ld a, [wCharDataLevel] ; $4a0c
	ld [hl], a ; $4a0f
	push af ; $4a10
	ld hl, wStoryModeNameOfMainCharacter ; $4a11
	ld a, [wStoryCharacterSlot] ; $4a14
	or a ; $4a17
	jr z, .zero2 ; $4a18
	ld l, $40 ; $4a1a
.zero2:
	ld a, l ; $4a1c
	add $38 ; $4a1d
	ld l, a ; $4a1f
	ld a, h ; $4a20
	adc $00 ; $4a21
	ld h, a ; $4a23
	pop af ; $4a24
	ld a, [wCharDataNewLevels] ; $4a25
	ld [hl], a ; $4a28
	ld [wCharDataLevels], a ; $4a29
	push af ; $4a2c
	ld hl, wStoryModeNameOfMainCharacter ; $4a2d
	ld a, [wStoryCharacterSlot] ; $4a30
	or a ; $4a33
	jr z, .zero3 ; $4a34
	ld l, $40 ; $4a36
.zero3:
	ld a, l ; $4a38
	add $39 ; $4a39
	ld l, a ; $4a3b
	ld a, h ; $4a3c
	adc $00 ; $4a3d
	ld h, a ; $4a3f
	pop af ; $4a40
	ld a, [wCharDataNewLevels + 1] ; $4a41
	ld [hl], a ; $4a44
	ld [wCharDataLevels + 1], a ; $4a45
	push af ; $4a48
	ld hl, wStoryModeNameOfMainCharacter ; $4a49
	ld a, [wStoryCharacterSlot] ; $4a4c
	or a ; $4a4f
	jr z, .zero4 ; $4a50
	ld l, $40 ; $4a52
.zero4:
	ld a, l ; $4a54
	add $3a ; $4a55
	ld l, a ; $4a57
	ld a, h ; $4a58
	adc $00 ; $4a59
	ld h, a ; $4a5b
	pop af ; $4a5c
	ld a, [wCharDataNewLevels + 2] ; $4a5d
	ld [hl], a ; $4a60
	ld [wCharDataLevels + 2], a ; $4a61
	push af ; $4a64
	ld hl, wStoryModeNameOfMainCharacter ; $4a65
	ld a, [wStoryCharacterSlot] ; $4a68
	or a ; $4a6b
	jr z, .zero5 ; $4a6c
	ld l, $40 ; $4a6e
.zero5:
	ld a, l ; $4a70
	add $3b ; $4a71
	ld l, a ; $4a73
	ld a, h ; $4a74
	adc $00 ; $4a75
	ld h, a ; $4a77
	pop af ; $4a78
	ld a, [wCharDataNewLevels + 3] ; $4a79
	ld [hl], a ; $4a7c
	ld [wCharDataLevels + 3], a ; $4a7d
	xor a ; $4a80
	ld b, $64 ; $4a81
	ld hl, wCharDataChoiceLog ; $4a83
.loop:
	ld [hl+], a ; $4a86
	dec b ; $4a87
	jr nz, .loop ; $4a88
	ld [wCharDataChoiceCount], a ; $4a8a
	ld a, [wStoryCharacterSlot] ; $4a8d
	farcall RefreshPlayerStatsAndGetPtr ; $4a90
	ret ; $4a93
LoadCharStatsWithLevelUpDeltas:
	wram_bank $06 ; $4a94
	ld a, [wCharDataViewOnly] ; $4a9a
	or a ; $4a9d
	ret nz ; $4a9e
	push af ; $4a9f
	ld hl, wStoryModeNameOfMainCharacter ; $4aa0
	ld a, [wStoryCharacterSlot] ; $4aa3
	or a ; $4aa6
	jr z, .zero ; $4aa7
	ld l, $40 ; $4aa9
.zero:
	ld a, l ; $4aab
	add $38 ; $4aac
	ld l, a ; $4aae
	ld a, h ; $4aaf
	adc $00 ; $4ab0
	ld h, a ; $4ab2
	pop af ; $4ab3
	ld a, [hl] ; $4ab4
	ld [wCharDataLevels], a ; $4ab5
	push af ; $4ab8
	ld hl, wStoryModeNameOfMainCharacter ; $4ab9
	ld a, [wStoryCharacterSlot] ; $4abc
	or a ; $4abf
	jr z, .zero2 ; $4ac0
	ld l, $40 ; $4ac2
.zero2:
	ld a, l ; $4ac4
	add $20 ; $4ac5
	ld l, a ; $4ac7
	ld a, h ; $4ac8
	adc $00 ; $4ac9
	ld h, a ; $4acb
	pop af ; $4acc
	ld a, [hl] ; $4acd
	inc a ; $4ace
	ld [wCharDataStats], a ; $4acf
	push af ; $4ad2
	ld hl, wStoryModeNameOfMainCharacter ; $4ad3
	ld a, [wStoryCharacterSlot] ; $4ad6
	or a ; $4ad9
	jr z, .zero3 ; $4ada
	ld l, $40 ; $4adc
.zero3:
	ld a, l ; $4ade
	add $21 ; $4adf
	ld l, a ; $4ae1
	ld a, h ; $4ae2
	adc $00 ; $4ae3
	ld h, a ; $4ae5
	pop af ; $4ae6
	ld a, [hl] ; $4ae7
	inc a ; $4ae8
	ld [wCharDataStats + 1], a ; $4ae9
	push af ; $4aec
	ld hl, wStoryModeNameOfMainCharacter ; $4aed
	ld a, [wStoryCharacterSlot] ; $4af0
	or a ; $4af3
	jr z, .zero4 ; $4af4
	ld l, $40 ; $4af6
.zero4:
	ld a, l ; $4af8
	add $39 ; $4af9
	ld l, a ; $4afb
	ld a, h ; $4afc
	adc $00 ; $4afd
	ld h, a ; $4aff
	pop af ; $4b00
	ld a, [hl] ; $4b01
	ld [wCharDataLevels + 1], a ; $4b02
	push af ; $4b05
	ld hl, wStoryModeNameOfMainCharacter ; $4b06
	ld a, [wStoryCharacterSlot] ; $4b09
	or a ; $4b0c
	jr z, .zero5 ; $4b0d
	ld l, $40 ; $4b0f
.zero5:
	ld a, l ; $4b11
	add $22 ; $4b12
	ld l, a ; $4b14
	ld a, h ; $4b15
	adc $00 ; $4b16
	ld h, a ; $4b18
	pop af ; $4b19
	ld a, [hl] ; $4b1a
	inc a ; $4b1b
	ld [wCharDataStats + 2], a ; $4b1c
	push af ; $4b1f
	ld hl, wStoryModeNameOfMainCharacter ; $4b20
	ld a, [wStoryCharacterSlot] ; $4b23
	or a ; $4b26
	jr z, .zero6 ; $4b27
	ld l, $40 ; $4b29
.zero6:
	ld a, l ; $4b2b
	add $23 ; $4b2c
	ld l, a ; $4b2e
	ld a, h ; $4b2f
	adc $00 ; $4b30
	ld h, a ; $4b32
	pop af ; $4b33
	ld a, [hl] ; $4b34
	inc a ; $4b35
	ld [wCharDataStats + 3], a ; $4b36
	push af ; $4b39
	ld hl, wStoryModeNameOfMainCharacter ; $4b3a
	ld a, [wStoryCharacterSlot] ; $4b3d
	or a ; $4b40
	jr z, .zero7 ; $4b41
	ld l, $40 ; $4b43
.zero7:
	ld a, l ; $4b45
	add $24 ; $4b46
	ld l, a ; $4b48
	ld a, h ; $4b49
	adc $00 ; $4b4a
	ld h, a ; $4b4c
	pop af ; $4b4d
	ld a, [hl] ; $4b4e
	inc a ; $4b4f
	ld [wCharDataStats + 4], a ; $4b50
	push af ; $4b53
	ld hl, wStoryModeNameOfMainCharacter ; $4b54
	ld a, [wStoryCharacterSlot] ; $4b57
	or a ; $4b5a
	jr z, .zero8 ; $4b5b
	ld l, $40 ; $4b5d
.zero8:
	ld a, l ; $4b5f
	add $3a ; $4b60
	ld l, a ; $4b62
	ld a, h ; $4b63
	adc $00 ; $4b64
	ld h, a ; $4b66
	pop af ; $4b67
	ld a, [hl] ; $4b68
	ld [wCharDataLevels + 2], a ; $4b69
	push af ; $4b6c
	ld hl, wStoryModeNameOfMainCharacter ; $4b6d
	ld a, [wStoryCharacterSlot] ; $4b70
	or a ; $4b73
	jr z, .zero9 ; $4b74
	ld l, $40 ; $4b76
.zero9:
	ld a, l ; $4b78
	add $25 ; $4b79
	ld l, a ; $4b7b
	ld a, h ; $4b7c
	adc $00 ; $4b7d
	ld h, a ; $4b7f
	pop af ; $4b80
	ld a, [hl] ; $4b81
	inc a ; $4b82
	ld [wCharDataStats + 5], a ; $4b83
	push af ; $4b86
	ld hl, wStoryModeNameOfMainCharacter ; $4b87
	ld a, [wStoryCharacterSlot] ; $4b8a
	or a ; $4b8d
	jr z, .zero10 ; $4b8e
	ld l, $40 ; $4b90
.zero10:
	ld a, l ; $4b92
	add $26 ; $4b93
	ld l, a ; $4b95
	ld a, h ; $4b96
	adc $00 ; $4b97
	ld h, a ; $4b99
	pop af ; $4b9a
	ld a, [hl] ; $4b9b
	inc a ; $4b9c
	ld [wCharDataStats + 6], a ; $4b9d
	push af ; $4ba0
	ld hl, wStoryModeNameOfMainCharacter ; $4ba1
	ld a, [wStoryCharacterSlot] ; $4ba4
	or a ; $4ba7
	jr z, .zero11 ; $4ba8
	ld l, $40 ; $4baa
.zero11:
	ld a, l ; $4bac
	add $3b ; $4bad
	ld l, a ; $4baf
	ld a, h ; $4bb0
	adc $00 ; $4bb1
	ld h, a ; $4bb3
	pop af ; $4bb4
	ld a, [hl] ; $4bb5
	ld [wCharDataLevels + 3], a ; $4bb6
	push af ; $4bb9
	ld hl, wStoryModeNameOfMainCharacter ; $4bba
	ld a, [wStoryCharacterSlot] ; $4bbd
	or a ; $4bc0
	jr z, .zero12 ; $4bc1
	ld l, $40 ; $4bc3
.zero12:
	ld a, l ; $4bc5
	add $27 ; $4bc6
	ld l, a ; $4bc8
	ld a, h ; $4bc9
	adc $00 ; $4bca
	ld h, a ; $4bcc
	pop af ; $4bcd
	ld a, [hl] ; $4bce
	inc a ; $4bcf
	ld [wCharDataStats + 7], a ; $4bd0
	push af ; $4bd3
	ld hl, wStoryModeNameOfMainCharacter ; $4bd4
	ld a, [wStoryCharacterSlot] ; $4bd7
	or a ; $4bda
	jr z, .zero13 ; $4bdb
	ld l, $40 ; $4bdd
.zero13:
	ld a, l ; $4bdf
	add $28 ; $4be0
	ld l, a ; $4be2
	ld a, h ; $4be3
	adc $00 ; $4be4
	ld h, a ; $4be6
	pop af ; $4be7
	ld a, [hl] ; $4be8
	inc a ; $4be9
	ld [wCharDataStats + 8], a ; $4bea
	push af ; $4bed
	ld hl, wStoryModeNameOfMainCharacter ; $4bee
	ld a, [wStoryCharacterSlot] ; $4bf1
	or a ; $4bf4
	jr z, .zero14 ; $4bf5
	ld l, $40 ; $4bf7
.zero14:
	ld a, l ; $4bf9
	add $29 ; $4bfa
	ld l, a ; $4bfc
	ld a, h ; $4bfd
	adc $00 ; $4bfe
	ld h, a ; $4c00
	pop af ; $4c01
	ld a, [hl] ; $4c02
	inc a ; $4c03
	ld [wCharDataStats + 9], a ; $4c04
	push af ; $4c07
	ld hl, wStoryModeNameOfMainCharacter ; $4c08
	ld a, [wStoryCharacterSlot] ; $4c0b
	or a ; $4c0e
	jr z, .zero15 ; $4c0f
	ld l, $40 ; $4c11
.zero15:
	ld a, l ; $4c13
	add $2a ; $4c14
	ld l, a ; $4c16
	ld a, h ; $4c17
	adc $00 ; $4c18
	ld h, a ; $4c1a
	pop af ; $4c1b
	ld a, [hl] ; $4c1c
	inc a ; $4c1d
	ld [wCharDataStats + 10], a ; $4c1e
	ld a, [wCharDataPage] ; $4c21
	cp $04 ; $4c24
	jr z, .eq04 ; $4c26
	ld d, a ; $4c28
	ld hl, wCharDataStatDeltas ; $4c29
	ld a, [wStoryCharacterSlot] ; $4c2c
	farcall ComputeLevelUpStatDeltas ; $4c2f
	ret ; $4c32
.eq04:
	xor a ; $4c33
	ld hl, wCharDataStatDeltas ; $4c34
	ld [hl+], a ; $4c37
	ld [hl+], a ; $4c38
	ld [hl+], a ; $4c39
	ld [hl+], a ; $4c3a
	ld [hl+], a ; $4c3b
	ld [hl+], a ; $4c3c
	ld [hl+], a ; $4c3d
	ld [hl+], a ; $4c3e
	ld [hl+], a ; $4c3f
	ld [hl+], a ; $4c40
	ld [hl+], a ; $4c41
	ret ; $4c42
LoadCharStats:
	wram_bank $06 ; $4c43
	push af ; $4c49
	ld hl, wStoryModeNameOfMainCharacter ; $4c4a
	ld a, [wStoryCharacterSlot] ; $4c4d
	or a ; $4c50
	jr z, .field38 ; $4c51
	ld l, $40 ; $4c53
.field38:
	ld a, l ; $4c55
	add $38 ; $4c56
	ld l, a ; $4c58
	ld a, h ; $4c59
	adc $00 ; $4c5a
	ld h, a ; $4c5c
	pop af ; $4c5d
	ld a, [hl] ; $4c5e
	ld [wCharDataLevels], a ; $4c5f
	push af ; $4c62
	ld hl, wStoryModeNameOfMainCharacter ; $4c63
	ld a, [wStoryCharacterSlot] ; $4c66
	or a ; $4c69
	jr z, .field20 ; $4c6a
	ld l, $40 ; $4c6c
.field20:
	ld a, l ; $4c6e
	add $20 ; $4c6f
	ld l, a ; $4c71
	ld a, h ; $4c72
	adc $00 ; $4c73
	ld h, a ; $4c75
	pop af ; $4c76
	ld a, [hl] ; $4c77
	inc a ; $4c78
	ld [wCharDataStats], a ; $4c79
	push af ; $4c7c
	ld hl, wStoryModeNameOfMainCharacter ; $4c7d
	ld a, [wStoryCharacterSlot] ; $4c80
	or a ; $4c83
	jr z, .field21 ; $4c84
	ld l, $40 ; $4c86
.field21:
	ld a, l ; $4c88
	add $21 ; $4c89
	ld l, a ; $4c8b
	ld a, h ; $4c8c
	adc $00 ; $4c8d
	ld h, a ; $4c8f
	pop af ; $4c90
	ld a, [hl] ; $4c91
	inc a ; $4c92
	ld [wCharDataStats + 1], a ; $4c93
	push af ; $4c96
	ld hl, wStoryModeNameOfMainCharacter ; $4c97
	ld a, [wStoryCharacterSlot] ; $4c9a
	or a ; $4c9d
	jr z, .field39 ; $4c9e
	ld l, $40 ; $4ca0
.field39:
	ld a, l ; $4ca2
	add $39 ; $4ca3
	ld l, a ; $4ca5
	ld a, h ; $4ca6
	adc $00 ; $4ca7
	ld h, a ; $4ca9
	pop af ; $4caa
	ld a, [hl] ; $4cab
	ld [wCharDataLevels + 1], a ; $4cac
	push af ; $4caf
	ld hl, wStoryModeNameOfMainCharacter ; $4cb0
	ld a, [wStoryCharacterSlot] ; $4cb3
	or a ; $4cb6
	jr z, .field22 ; $4cb7
	ld l, $40 ; $4cb9
.field22:
	ld a, l ; $4cbb
	add $22 ; $4cbc
	ld l, a ; $4cbe
	ld a, h ; $4cbf
	adc $00 ; $4cc0
	ld h, a ; $4cc2
	pop af ; $4cc3
	ld a, [hl] ; $4cc4
	inc a ; $4cc5
	ld [wCharDataStats + 2], a ; $4cc6
	push af ; $4cc9
	ld hl, wStoryModeNameOfMainCharacter ; $4cca
	ld a, [wStoryCharacterSlot] ; $4ccd
	or a ; $4cd0
	jr z, .field23 ; $4cd1
	ld l, $40 ; $4cd3
.field23:
	ld a, l ; $4cd5
	add $23 ; $4cd6
	ld l, a ; $4cd8
	ld a, h ; $4cd9
	adc $00 ; $4cda
	ld h, a ; $4cdc
	pop af ; $4cdd
	ld a, [hl] ; $4cde
	inc a ; $4cdf
	ld [wCharDataStats + 3], a ; $4ce0
	push af ; $4ce3
	ld hl, wStoryModeNameOfMainCharacter ; $4ce4
	ld a, [wStoryCharacterSlot] ; $4ce7
	or a ; $4cea
	jr z, .field24 ; $4ceb
	ld l, $40 ; $4ced
.field24:
	ld a, l ; $4cef
	add $24 ; $4cf0
	ld l, a ; $4cf2
	ld a, h ; $4cf3
	adc $00 ; $4cf4
	ld h, a ; $4cf6
	pop af ; $4cf7
	ld a, [hl] ; $4cf8
	inc a ; $4cf9
	ld [wCharDataStats + 4], a ; $4cfa
	push af ; $4cfd
	ld hl, wStoryModeNameOfMainCharacter ; $4cfe
	ld a, [wStoryCharacterSlot] ; $4d01
	or a ; $4d04
	jr z, .field3a ; $4d05
	ld l, $40 ; $4d07
.field3a:
	ld a, l ; $4d09
	add $3a ; $4d0a
	ld l, a ; $4d0c
	ld a, h ; $4d0d
	adc $00 ; $4d0e
	ld h, a ; $4d10
	pop af ; $4d11
	ld a, [hl] ; $4d12
	ld [wCharDataLevels + 2], a ; $4d13
	push af ; $4d16
	ld hl, wStoryModeNameOfMainCharacter ; $4d17
	ld a, [wStoryCharacterSlot] ; $4d1a
	or a ; $4d1d
	jr z, .field25 ; $4d1e
	ld l, $40 ; $4d20
.field25:
	ld a, l ; $4d22
	add $25 ; $4d23
	ld l, a ; $4d25
	ld a, h ; $4d26
	adc $00 ; $4d27
	ld h, a ; $4d29
	pop af ; $4d2a
	ld a, [hl] ; $4d2b
	inc a ; $4d2c
	ld [wCharDataStats + 5], a ; $4d2d
	push af ; $4d30
	ld hl, wStoryModeNameOfMainCharacter ; $4d31
	ld a, [wStoryCharacterSlot] ; $4d34
	or a ; $4d37
	jr z, .field26 ; $4d38
	ld l, $40 ; $4d3a
.field26:
	ld a, l ; $4d3c
	add $26 ; $4d3d
	ld l, a ; $4d3f
	ld a, h ; $4d40
	adc $00 ; $4d41
	ld h, a ; $4d43
	pop af ; $4d44
	ld a, [hl] ; $4d45
	inc a ; $4d46
	ld [wCharDataStats + 6], a ; $4d47
	push af ; $4d4a
	ld hl, wStoryModeNameOfMainCharacter ; $4d4b
	ld a, [wStoryCharacterSlot] ; $4d4e
	or a ; $4d51
	jr z, .field3b ; $4d52
	ld l, $40 ; $4d54
.field3b:
	ld a, l ; $4d56
	add $3b ; $4d57
	ld l, a ; $4d59
	ld a, h ; $4d5a
	adc $00 ; $4d5b
	ld h, a ; $4d5d
	pop af ; $4d5e
	ld a, [hl] ; $4d5f
	ld [wCharDataLevels + 3], a ; $4d60
	push af ; $4d63
	ld hl, wStoryModeNameOfMainCharacter ; $4d64
	ld a, [wStoryCharacterSlot] ; $4d67
	or a ; $4d6a
	jr z, .field27 ; $4d6b
	ld l, $40 ; $4d6d
.field27:
	ld a, l ; $4d6f
	add $27 ; $4d70
	ld l, a ; $4d72
	ld a, h ; $4d73
	adc $00 ; $4d74
	ld h, a ; $4d76
	pop af ; $4d77
	ld a, [hl] ; $4d78
	inc a ; $4d79
	ld [wCharDataStats + 7], a ; $4d7a
	push af ; $4d7d
	ld hl, wStoryModeNameOfMainCharacter ; $4d7e
	ld a, [wStoryCharacterSlot] ; $4d81
	or a ; $4d84
	jr z, .field28 ; $4d85
	ld l, $40 ; $4d87
.field28:
	ld a, l ; $4d89
	add $28 ; $4d8a
	ld l, a ; $4d8c
	ld a, h ; $4d8d
	adc $00 ; $4d8e
	ld h, a ; $4d90
	pop af ; $4d91
	ld a, [hl] ; $4d92
	inc a ; $4d93
	ld [wCharDataStats + 8], a ; $4d94
	push af ; $4d97
	ld hl, wStoryModeNameOfMainCharacter ; $4d98
	ld a, [wStoryCharacterSlot] ; $4d9b
	or a ; $4d9e
	jr z, .field29 ; $4d9f
	ld l, $40 ; $4da1
.field29:
	ld a, l ; $4da3
	add $29 ; $4da4
	ld l, a ; $4da6
	ld a, h ; $4da7
	adc $00 ; $4da8
	ld h, a ; $4daa
	pop af ; $4dab
	ld a, [hl] ; $4dac
	inc a ; $4dad
	ld [wCharDataStats + 9], a ; $4dae
	push af ; $4db1
	ld hl, wStoryModeNameOfMainCharacter ; $4db2
	ld a, [wStoryCharacterSlot] ; $4db5
	or a ; $4db8
	jr z, .field2a ; $4db9
	ld l, $40 ; $4dbb
.field2a:
	ld a, l ; $4dbd
	add $2a ; $4dbe
	ld l, a ; $4dc0
	ld a, h ; $4dc1
	adc $00 ; $4dc2
	ld h, a ; $4dc4
	pop af ; $4dc5
	ld a, [hl] ; $4dc6
	inc a ; $4dc7
	ld [wCharDataStats + 10], a ; $4dc8
	ld hl, wCharDataStatDeltas ; $4dcb
	ld b, $0b ; $4dce
	xor a ; $4dd0
.clearLoop:
	ld [hl+], a ; $4dd1
	dec b ; $4dd2
	jr nz, .clearLoop ; $4dd3
	ret ; $4dd5
CharDataScreen_DrawPageColumns:
	wram_bank $06 ; $4dd6
	ld a, [wCharDataPage] ; $4ddc
	rlca ; $4ddf
	push af ; $4de0
	rlca ; $4de1
	add LOW(CharDataScreen_DrawPageColumnsTable0) ; $4de2
	ld l, a ; $4de4
	adc HIGH(CharDataScreen_DrawPageColumnsTable0) ; $4de5
	sub l ; $4de7
	ld h, a ; $4de8
	ld a, [hl+] ; $4de9
	ld d, [hl] ; $4dea
	ld e, a ; $4deb
	inc hl ; $4dec
	ld a, [hl+] ; $4ded
	ld b, [hl] ; $4dee
	ld c, a ; $4def
	pop af ; $4df0
	add LOW(CharDataScreen_DrawPageColumnsTable1) ; $4df1
	ld l, a ; $4df3
	adc HIGH(CharDataScreen_DrawPageColumnsTable1) ; $4df4
	sub l ; $4df6
	ld h, a ; $4df7
	ld a, [hl+] ; $4df8
	ld h, [hl] ; $4df9
	ld l, a ; $4dfa
.rowLoop:
	push bc ; $4dfb
.cellLoop:
	wram_bank $02 ; $4dfc
	ld a, [hl+] ; $4e02
	ld [de], a ; $4e03
	inc de ; $4e04
	dec b ; $4e05
	jr nz, .cellLoop ; $4e06
	pop bc ; $4e08
	ld a, c ; $4e09
	and $01 ; $4e0a
	jr nz, .nextRow ; $4e0c
	wram_bank $06 ; $4e0e
	ld a, [wCharDataPage] ; $4e14
	cp $04 ; $4e17
	jr z, .nextRow ; $4e19
	dec de ; $4e1b
	dec de ; $4e1c
	dec de ; $4e1d
	wram_bank $02 ; $4e1e
	ld a, $01 ; $4e24
	ld [de], a ; $4e26
	inc de ; $4e27
	ld [de], a ; $4e28
	inc de ; $4e29
	inc de ; $4e2a
.nextRow:
	ld a, $16 ; $4e2b
	add e ; $4e2d
	ld e, a ; $4e2e
	jr nc, .rowDone ; $4e2f
	inc d ; $4e31
.rowDone:
	dec c ; $4e32
	jr nz, .rowLoop ; $4e33
	ret ; $4e35
CharDataScreen_DrawPageColumnsTable0:
	; $4e36, 20 bytes (bytes:4)
	db $60, $d0, $05, $0a ; 0x00
	db $00, $d1, $07, $0a ; 0x04
	db $6a, $d0, $05, $0a ; 0x08
	db $0a, $d1, $09, $0a ; 0x0c
	db $e0, $d1, $03, $0a ; 0x10
CharDataScreen_DrawPageColumnsTable1:
	INCBIN "data/bank_01c/d_4e4a.bin" ; $4e4a, 10 bytes
DrawStatValueSprites:
	wram_bank $06 ; $4e54
	ld b, $0e ; $4e5a
	ld a, [wCharDataLevels] ; $4e5c
	ld l, a ; $4e5f
	ld a, [wCharDataLevelPreview] ; $4e60
	or a ; $4e63
	jr nz, .digits1 ; $4e64
	ld a, [wCharDataPage] ; $4e66
	or a ; $4e69
	jr nz, .digits1 ; $4e6a
	inc l ; $4e6c
	ld b, $0f ; $4e6d
.digits1:
	ld a, l ; $4e6f
	cp $0a ; $4e70
	jr c, .lt0a ; $4e72
	push bc ; $4e74
	ld h, $00 ; $4e75
	ld a, $02 ; $4e77
	ld de, wCharDataNumberBuffer ; $4e79
	call FormatDecimalNumberUnsigned ; $4e7c
	pop bc ; $4e7f
	push bc ; $4e80
	ld a, [wCharDataNumberBuffer] ; $4e81
	sub $30 ; $4e84
	rlca ; $4e86
	ld c, a ; $4e87
	ld de, $051c ; $4e88
	xor a ; $4e8b
	call GetStatDigitSpritePos ; $4e8c
	call QueueSprite ; $4e8f
	pop bc ; $4e92
	ld a, [wCharDataNumberBuffer + 1] ; $4e93
	sub $30 ; $4e96
	rlca ; $4e98
	ld c, a ; $4e99
	ld de, $0c1c ; $4e9a
	xor a ; $4e9d
	call GetStatDigitSpritePos ; $4e9e
	call QueueSprite ; $4ea1
	jr .stat2 ; $4ea4
.lt0a:
	ld a, l ; $4ea6
	rlca ; $4ea7
	ld c, a ; $4ea8
	ld de, $091c ; $4ea9
	xor a ; $4eac
	call GetStatDigitSpritePos ; $4ead
	call QueueSprite ; $4eb0
.stat2:
	ld b, $0e ; $4eb3
	ld a, [wCharDataLevels + 1] ; $4eb5
	ld l, a ; $4eb8
	ld a, [wCharDataLevelPreview] ; $4eb9
	or a ; $4ebc
	jr nz, .digits2 ; $4ebd
	ld a, [wCharDataPage] ; $4ebf
	cp $01 ; $4ec2
	jr nz, .digits2 ; $4ec4
	inc l ; $4ec6
	ld b, $0f ; $4ec7
.digits2:
	ld a, l ; $4ec9
	cp $0a ; $4eca
	jr c, .lt0a2 ; $4ecc
	push bc ; $4ece
	ld h, $00 ; $4ecf
	ld a, $02 ; $4ed1
	ld de, wCharDataNumberBuffer ; $4ed3
	call FormatDecimalNumberUnsigned ; $4ed6
	pop bc ; $4ed9
	push bc ; $4eda
	ld a, [wCharDataNumberBuffer] ; $4edb
	sub $30 ; $4ede
	rlca ; $4ee0
	ld c, a ; $4ee1
	ld de, $0544 ; $4ee2
	ld a, $01 ; $4ee5
	call GetStatDigitSpritePos ; $4ee7
	call QueueSprite ; $4eea
	pop bc ; $4eed
	ld a, [wCharDataNumberBuffer + 1] ; $4eee
	sub $30 ; $4ef1
	rlca ; $4ef3
	ld c, a ; $4ef4
	ld de, $0c44 ; $4ef5
	ld a, $01 ; $4ef8
	call GetStatDigitSpritePos ; $4efa
	call QueueSprite ; $4efd
	jr .stat3 ; $4f00
.lt0a2:
	ld a, l ; $4f02
	rlca ; $4f03
	ld c, a ; $4f04
	ld de, $0944 ; $4f05
	ld a, $01 ; $4f08
	call GetStatDigitSpritePos ; $4f0a
	call QueueSprite ; $4f0d
.stat3:
	ld b, $0e ; $4f10
	ld a, [wCharDataLevels + 2] ; $4f12
	ld l, a ; $4f15
	ld a, [wCharDataLevelPreview] ; $4f16
	or a ; $4f19
	jr nz, .digits3 ; $4f1a
	ld a, [wCharDataPage] ; $4f1c
	cp $02 ; $4f1f
	jr nz, .digits3 ; $4f21
	inc l ; $4f23
	ld b, $0f ; $4f24
.digits3:
	ld a, l ; $4f26
	cp $0a ; $4f27
	jr c, .lt0a3 ; $4f29
	push bc ; $4f2b
	ld h, $00 ; $4f2c
	ld a, $02 ; $4f2e
	ld de, wCharDataNumberBuffer ; $4f30
	call FormatDecimalNumberUnsigned ; $4f33
	pop bc ; $4f36
	push bc ; $4f37
	ld a, [wCharDataNumberBuffer] ; $4f38
	sub $30 ; $4f3b
	rlca ; $4f3d
	ld c, a ; $4f3e
	ld de, $551c ; $4f3f
	ld a, $02 ; $4f42
	call GetStatDigitSpritePos ; $4f44
	call QueueSprite ; $4f47
	pop bc ; $4f4a
	ld a, [wCharDataNumberBuffer + 1] ; $4f4b
	sub $30 ; $4f4e
	rlca ; $4f50
	ld c, a ; $4f51
	ld de, $5c1c ; $4f52
	ld a, $02 ; $4f55
	call GetStatDigitSpritePos ; $4f57
	call QueueSprite ; $4f5a
	jr .stat4 ; $4f5d
.lt0a3:
	ld a, l ; $4f5f
	rlca ; $4f60
	ld c, a ; $4f61
	ld de, $591c ; $4f62
	ld a, $02 ; $4f65
	call GetStatDigitSpritePos ; $4f67
	call QueueSprite ; $4f6a
.stat4:
	ld b, $0e ; $4f6d
	ld a, [wCharDataLevels + 3] ; $4f6f
	ld l, a ; $4f72
	ld a, [wCharDataLevelPreview] ; $4f73
	or a ; $4f76
	jr nz, .digits4 ; $4f77
	ld a, [wCharDataPage] ; $4f79
	cp $03 ; $4f7c
	jr nz, .digits4 ; $4f7e
	inc l ; $4f80
	ld b, $0f ; $4f81
.digits4:
	ld a, l ; $4f83
	cp $0a ; $4f84
	jr c, .lt0a4 ; $4f86
	push bc ; $4f88
	ld h, $00 ; $4f89
	ld a, $02 ; $4f8b
	ld de, wCharDataNumberBuffer ; $4f8d
	call FormatDecimalNumberUnsigned ; $4f90
	pop bc ; $4f93
	push bc ; $4f94
	ld a, [wCharDataNumberBuffer] ; $4f95
	sub $30 ; $4f98
	rlca ; $4f9a
	ld c, a ; $4f9b
	ld de, $5544 ; $4f9c
	ld a, $03 ; $4f9f
	call GetStatDigitSpritePos ; $4fa1
	call QueueSprite ; $4fa4
	pop bc ; $4fa7
	ld a, [wCharDataNumberBuffer + 1] ; $4fa8
	sub $30 ; $4fab
	rlca ; $4fad
	ld c, a ; $4fae
	ld de, $5c44 ; $4faf
	ld a, $03 ; $4fb2
	call GetStatDigitSpritePos ; $4fb4
	call QueueSprite ; $4fb7
	jr .drawStatChangeArrows ; $4fba
.lt0a4:
	ld a, l ; $4fbc
	rlca ; $4fbd
	ld c, a ; $4fbe
	ld de, $5944 ; $4fbf
	ld a, $03 ; $4fc2
	call GetStatDigitSpritePos ; $4fc4
	call QueueSprite ; $4fc7
.drawStatChangeArrows:
	farcall DrawStatChangeArrows ; $4fca
	ret ; $4fcd
GetStatDigitSpritePos:
	rlca ; $4fce
	add LOW(RadialOffsetRamps_1c) ; $4fcf
	ld l, a ; $4fd1
	adc HIGH(RadialOffsetRamps_1c) ; $4fd2
	sub l ; $4fd4
	ld h, a ; $4fd5
	ld a, [hl+] ; $4fd6
	ld h, [hl] ; $4fd7
	ld l, a ; $4fd8
	ld a, [wCharDataRevealTimer] ; $4fd9
	rlca ; $4fdc
	add l ; $4fdd
	ld l, a ; $4fde
	jr nc, .readOffsets ; $4fdf
	inc h ; $4fe1
.readOffsets:
	ld a, [hl+] ; $4fe2
	add d ; $4fe3
	ld d, a ; $4fe4
	ld a, [hl] ; $4fe5
	add e ; $4fe6
	ld e, a ; $4fe7
	ret ; $4fe8
RadialOffsetRamps_1c:
	INCBIN "data/bank_01c/d_4fe9.bin" ; $4fe9, 96 bytes
DrawRemainingPointsSprite:
	wram_bank $06 ; $5049
	ld a, [wCharDataPointsLeft] ; $504f
	cp $0a ; $5052
	jr c, .lt0a ; $5054
	ld h, $00 ; $5056
	ld l, a ; $5058
	ld a, $02 ; $5059
	ld de, wCharDataNumberBuffer ; $505b
	call FormatDecimalNumberUnsigned ; $505e
	ld a, [wCharDataNumberBuffer] ; $5061
	sub $30 ; $5064
	rlca ; $5066
	ld c, a ; $5067
	ld de, $147f ; $5068
	call OffsetStatSpriteX ; $506b
	ld b, $0f ; $506e
	call QueueSprite ; $5070
	ld a, [wCharDataNumberBuffer + 1] ; $5073
	sub $30 ; $5076
	rlca ; $5078
	ld c, a ; $5079
	ld de, $1b7f ; $507a
	call OffsetStatSpriteX ; $507d
	ld b, $0f ; $5080
	call QueueSprite ; $5082
	ret ; $5085
.lt0a:
	rlca ; $5086
	ld c, a ; $5087
	ld de, $187f ; $5088
	call OffsetStatSpriteX ; $508b
	ld b, $0f ; $508e
	call QueueSprite ; $5090
	ret ; $5093
OffsetStatSpriteX:
	ld a, [wCharDataRevealStep] ; $5094
	rlca ; $5097
	rlca ; $5098
	rlca ; $5099
	add e ; $509a
	ld e, a ; $509b
	ret ; $509c
CharDataScreen_InputLoop:
	wram_bank $06 ; $509d
	ld a, [wCharDataViewOnly] ; $50a3
	or a ; $50a6
	jp nz, .finish ; $50a7
	call AdvanceFrame ; $50aa
	ldh a, [hInputRisingEdge] ; $50ad
	push af ; $50af
	test_flag FLAG_CHAR_DATA_START_EXITS ; $50b0
	jr z, .readInput ; $50b3
	bit 3, a ; $50b5
	jr z, .readInput ; $50b7
	pop af ; $50b9
	jp .finish ; $50ba
.readInput:
	pop af ; $50bd
	bit 0, a ; $50be
	jr nz, .pressA ; $50c0
	bit 1, a ; $50c2
	jr nz, .pressB ; $50c4
	bit 4, a ; $50c6
	jr nz, .moveRight ; $50c8
	bit 5, a ; $50ca
	jr nz, .moveLeft ; $50cc
	bit 7, a ; $50ce
	jr nz, .moveDown ; $50d0
	bit 6, a ; $50d2
	jr nz, .moveUp ; $50d4
	jr CharDataScreen_InputLoop ; $50d6
.moveUp:
	ld hl, CharDataPageUpTargets_1c ; $50d8
	call MoveCharDataScreenSelection ; $50db
	jr CharDataScreen_InputLoop ; $50de
.moveDown:
	ld hl, CharDataPageDownTargets_1c ; $50e0
	call MoveCharDataScreenSelection ; $50e3
	jr CharDataScreen_InputLoop ; $50e6
.moveLeft:
	ld hl, CharDataPageLeftTargets_1c ; $50e8
	call MoveCharDataScreenSelection ; $50eb
	jr CharDataScreen_InputLoop ; $50ee
.moveRight:
	ld hl, CharDataPageRightTargets_1c ; $50f0
	call MoveCharDataScreenSelection ; $50f3
	jp CharDataScreen_InputLoop ; $50f6
.pressB:
	wram_bank $06 ; $50f9
	ld a, [wCharDataPage] ; $50ff
	cp $04 ; $5102
	jr nz, .selectConfirmCell ; $5104
	call ApplyCharStatLevelUp ; $5106
	or a ; $5109
	jp nz, CharDataScreen_InputLoop ; $510a
	ld a, $01 ; $510d
	ret ; $510f
.selectConfirmCell:
	ld a, $04 ; $5110
	ld [wCharDataPage], a ; $5112
	call RestoreCharDataScreenRow ; $5115
	call LoadCharStats ; $5118
	call CharDataScreen_DrawStats ; $511b
	call DrawCharStatsAndFlush ; $511e
	call CharDataScreen_DrawPageColumns ; $5121
	call FlushCharDataTilemaps ; $5124
	jp nz, CharDataScreen_InputLoop ; $5127
.pressA:
	wram_bank $06 ; $512a
	ld a, [wCharDataPage] ; $5130
	cp $04 ; $5133
	jp z, CharDataScreen_InputLoop ; $5135
	sound SFX_MENU_SELECT ; $5138
	ld d, a ; $513a
	ld a, [wStoryCharacterSlot] ; $513b
	farcall LevelUpPlayer ; $513e
	wram_bank $06 ; $5141
	ld hl, wCharDataPointsLeft ; $5147
	dec [hl] ; $514a
	ld a, [wCharDataChoiceCount] ; $514b
	add $2a ; $514e
	ld l, a ; $5150
	adc $d0 ; $5151
	sub l ; $5153
	ld h, a ; $5154
	ld a, [wCharDataPage] ; $5155
	ld [hl], a ; $5158
	ld hl, wCharDataChoiceCount ; $5159
	inc [hl] ; $515c
	ld a, $04 ; $515d
	ld [wCharDataPage], a ; $515f
	test_flag FLAG_CHAR_DATA_START_EXITS ; $5162
	jr nz, .checkStatCap ; $5165
	ld a, [wStoryCharacterSlot] ; $5167
	farcall HasReachedNextLevelExp ; $516a
	jr nz, .finish ; $516d
	jr .redraw ; $516f
.checkStatCap:
	ld a, [wStoryCharacterSlot] ; $5171
	push af ; $5174
	ld hl, wStoryModeNameOfMainCharacter ; $5175
	ld a, [wStoryCharacterSlot] ; $5178
	or a ; $517b
	jr z, .readStatCap ; $517c
	ld l, $40 ; $517e
.readStatCap:
	ld a, l ; $5180
	add $18 ; $5181
	ld l, a ; $5183
	ld a, h ; $5184
	adc $00 ; $5185
	ld h, a ; $5187
	pop af ; $5188
	ld a, [hl] ; $5189
	cp $63 ; $518a
	jr z, .finish ; $518c
.redraw:
	call RestoreCharDataScreenRow ; $518e
	call LoadCharStats ; $5191
	call CharDataScreen_DrawStats ; $5194
	call DrawCharStatsAndFlush ; $5197
	call CharDataScreen_DrawPageColumns ; $519a
	call FlushCharDataTilemaps ; $519d
	jp CharDataScreen_InputLoop ; $51a0
.finish:
	wram_bank $06 ; $51a3
	ld a, [wCharDataViewOnly] ; $51a9
	or a ; $51ac
	jp nz, .skipWipe ; $51ad
	ld hl, DrawStatArrowIndicators ; $51b0
	call UnregisterFrameTask ; $51b3
	call LoadCharStats ; $51b6
	call CharDataScreen_DrawStats ; $51b9
	call RestoreCharDataScreenRow ; $51bc
	call DrawCharStatRows ; $51bf
	ld hl, CharDataBand6RunsStep2_1c ; $51c2
	ld bc, wScreenAttrmap + 29 * TILEMAP_WIDTH ; $51c5
	call BlitTilemapRunsFromTable ; $51c8
	ld hl, CharDataBand5RunsStep2_1c ; $51cb
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH ; $51ce
	call BlitTilemapRunsFromTable ; $51d1
	wram_bank $06 ; $51d4
	ld a, $01 ; $51da
	ld [wCharDataRevealStep], a ; $51dc
	ld [wCharDataConfirmState], a ; $51df
	ld [wCharDataLevelPreview], a ; $51e2
	call FlushCharDataTilemaps ; $51e5
	call RestoreCharDataScreenRow ; $51e8
	call DrawCharStatRows ; $51eb
	ld hl, CharDataBand6RunsStep1_1c ; $51ee
	ld bc, wScreenAttrmap + 29 * TILEMAP_WIDTH ; $51f1
	call BlitTilemapRunsFromTable ; $51f4
	ld hl, CharDataBand5RunsStep1_1c ; $51f7
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH ; $51fa
	call BlitTilemapRunsFromTable ; $51fd
	wram_bank $06 ; $5200
	ld a, $02 ; $5206
	ld [wCharDataRevealStep], a ; $5208
	call FlushCharDataTilemaps ; $520b
	wram_bank $06 ; $520e
	ld a, $03 ; $5214
	ld [wCharDataRevealStep], a ; $5216
	ld hl, DrawRemainingPointsSprite ; $5219
	call UnregisterFrameTask ; $521c
	call RestoreCharDataScreenRow ; $521f
	call DrawCharStatRows ; $5222
	call FlushCharDataTilemaps ; $5225
	call RestoreCharDataScreenRow ; $5228
	call DrawCharStatRows ; $522b
	ld hl, CharDataBand8RunsStep1_1c ; $522e
	ld bc, $d410 ; $5231
	call BlitTilemapRunsFromTable ; $5234
	call FlushCharDataTilemaps ; $5237
	call RestoreCharDataScreenRow ; $523a
	call DrawCharStatRows ; $523d
	ld hl, CharDataBand7RunsStep1_1c ; $5240
	ld bc, wScreenAttrmap + 31 * TILEMAP_WIDTH ; $5243
	call BlitTilemapRunsFromTable ; $5246
	ld hl, CharDataBand8RunsStep2_1c ; $5249
	ld bc, $d410 ; $524c
	call BlitTilemapRunsFromTable ; $524f
	call FlushCharDataTilemaps ; $5252
	call RestoreCharDataScreenRow ; $5255
	call DrawCharStatRows ; $5258
	ld hl, CharDataBand7RunsStep2_1c ; $525b
	ld bc, wScreenAttrmap + 31 * TILEMAP_WIDTH ; $525e
	call BlitTilemapRunsFromTable ; $5261
	ld hl, CharDataBand8RunsStep3_1c ; $5264
	ld bc, $d410 ; $5267
	call BlitTilemapRunsFromTable ; $526a
	call FlushCharDataTilemaps ; $526d
	call RestoreCharDataScreenRow ; $5270
	call DrawCharStatRows ; $5273
	ld hl, CharDataBand7RunsStep3_1c ; $5276
	ld bc, wScreenAttrmap + 31 * TILEMAP_WIDTH ; $5279
	call BlitTilemapRunsFromTable ; $527c
	ld hl, CharDataBand8RunsStep4_1c ; $527f
	ld bc, $d410 ; $5282
	call BlitTilemapRunsFromTable ; $5285
	call FlushCharDataTilemaps ; $5288
	jr .confirmLoop ; $528b
.skipWipe:
	xor a ; $528d
	ld [wCharDataViewOnly], a ; $528e
.confirmLoop:
	call DrawConfirmSelectionCursor ; $5291
	call AdvanceFrame ; $5294
	ldh a, [hInputRisingEdge] ; $5297
	bit PADB_A, a ; $5299
	jr nz, .confirmA ; $529b
	bit 1, a ; $529d
	jr nz, .cancel ; $529f
	and $c0 ; $52a1
	jr z, .confirmLoop ; $52a3
	sound SFX_MENU_MOVE ; $52a5
	ld a, [wCharDataConfirmState] ; $52a7
	xor $01 ; $52aa
	ld [wCharDataConfirmState], a ; $52ac
	jr .confirmLoop ; $52af
.confirmA:
	wram_bank $06 ; $52b1
	ld a, [wCharDataConfirmState] ; $52b7
	or a ; $52ba
	jr nz, .cancel ; $52bb
	sound SFX_MENU_SELECT ; $52bd
	xor a ; $52bf
	ret ; $52c0
.cancel:
	sound SFX_MENU_CANCEL ; $52c1
	call SelectCharDataConfirmSlot ; $52c3
	call RestoreCharDataScreenRow ; $52c6
	call LoadCharStats ; $52c9
	call CharDataScreen_DrawStats ; $52cc
	call DrawCharStatRows ; $52cf
	ld hl, CharDataBand7RunsStep2_1c ; $52d2
	ld bc, wScreenAttrmap + 31 * TILEMAP_WIDTH ; $52d5
	call BlitTilemapRunsFromTable ; $52d8
	ld hl, CharDataBand8RunsStep3_1c ; $52db
	ld bc, $d410 ; $52de
	call BlitTilemapRunsFromTable ; $52e1
	call FlushCharDataTilemaps ; $52e4
	call RestoreCharDataScreenRow ; $52e7
	call DrawCharStatRows ; $52ea
	ld hl, CharDataBand7RunsStep1_1c ; $52ed
	ld bc, wScreenAttrmap + 31 * TILEMAP_WIDTH ; $52f0
	call BlitTilemapRunsFromTable ; $52f3
	ld hl, CharDataBand8RunsStep2_1c ; $52f6
	ld bc, $d410 ; $52f9
	call BlitTilemapRunsFromTable ; $52fc
	call FlushCharDataTilemaps ; $52ff
	call RestoreCharDataScreenRow ; $5302
	call DrawCharStatRows ; $5305
	ld hl, CharDataBand8RunsStep1_1c ; $5308
	ld bc, $d410 ; $530b
	call BlitTilemapRunsFromTable ; $530e
	call FlushCharDataTilemaps ; $5311
	call RestoreCharDataScreenRow ; $5314
	call DrawCharStatRows ; $5317
	call FlushCharDataTilemaps ; $531a
	wram_bank $06 ; $531d
	ld a, $03 ; $5323
	ld [wCharDataRevealStep], a ; $5325
	call FlushCharDataTilemaps ; $5328
	ld a, $01 ; $532b
	ld hl, DrawRemainingPointsSprite ; $532d
	call RegisterFrameTask ; $5330
	call RestoreCharDataScreenRow ; $5333
	call DrawCharStatRows ; $5336
	ld hl, CharDataBand6RunsStep1_1c ; $5339
	ld bc, wScreenAttrmap + 29 * TILEMAP_WIDTH ; $533c
	call BlitTilemapRunsFromTable ; $533f
	ld hl, CharDataBand5RunsStep1_1c ; $5342
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH ; $5345
	call BlitTilemapRunsFromTable ; $5348
	wram_bank $06 ; $534b
	ld a, $02 ; $5351
	ld [wCharDataRevealStep], a ; $5353
	call FlushCharDataTilemaps ; $5356
	call RestoreCharDataScreenRow ; $5359
	call DrawCharStatRows ; $535c
	ld hl, CharDataBand6RunsStep2_1c ; $535f
	ld bc, wScreenAttrmap + 29 * TILEMAP_WIDTH ; $5362
	call BlitTilemapRunsFromTable ; $5365
	ld hl, CharDataBand5RunsStep2_1c ; $5368
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH ; $536b
	call BlitTilemapRunsFromTable ; $536e
	wram_bank $06 ; $5371
	ld a, $01 ; $5377
	ld [wCharDataRevealStep], a ; $5379
	call FlushCharDataTilemaps ; $537c
	wram_bank $06 ; $537f
	xor a ; $5385
	ld [wCharDataLevelPreview], a ; $5386
	ld [wCharDataRevealStep], a ; $5389
	call RestoreCharDataScreenRow ; $538c
	call DrawCharStatsAndFlush ; $538f
	call CharDataScreen_DrawPageColumns ; $5392
	call FlushCharDataTilemaps ; $5395
	ld a, $01 ; $5398
	ld hl, DrawStatArrowIndicators ; $539a
	call RegisterFrameTask ; $539d
	jp CharDataScreen_InputLoop ; $53a0
DrawConfirmSelectionCursor:
	wram_bank $06 ; $53a3
	ld a, [wCharDataConfirmState] ; $53a9
	or a ; $53ac
	jr nz, .nonZero ; $53ad
	ld bc, $0fd4 ; $53af
	ld de, $7a0c ; $53b2
	call QueueSprite ; $53b5
	ret ; $53b8
.nonZero:
	ld bc, $0fd4 ; $53b9
	ld de, $7a14 ; $53bc
	call QueueSprite ; $53bf
	ret ; $53c2
MoveCharDataScreenSelection:
	wram_bank $06 ; $53c3
	ld a, [wCharDataPage] ; $53c9
	add l ; $53cc
	ld l, a ; $53cd
	jr nc, .readTarget ; $53ce
	inc h ; $53d0
.readTarget:
	ld a, [hl] ; $53d1
	cp $ff ; $53d2
	ret z ; $53d4
	ld [wCharDataPage], a ; $53d5
	sound SFX_MENU_MOVE ; $53d8
	cp $04 ; $53da
	jr z, .redraw ; $53dc
	call RestoreCharDataScreenRow ; $53de
	call LoadCharStatsWithLevelUpDeltas ; $53e1
	call CharDataScreen_DrawStats ; $53e4
	call DrawCharStatsAndFlush ; $53e7
	call CharDataScreen_DrawPageColumns ; $53ea
	call FlushCharDataTilemaps ; $53ed
	ret ; $53f0
.redraw:
	call RestoreCharDataScreenRow ; $53f1
	call LoadCharStats ; $53f4
	call CharDataScreen_DrawStats ; $53f7
	call DrawCharStatsAndFlush ; $53fa
	call CharDataScreen_DrawPageColumns ; $53fd
	call FlushCharDataTilemaps ; $5400
	ret ; $5403
ApplyCharStatLevelUp:
	wram_bank $06 ; $5404
	ld a, [wCharDataChoiceCount] ; $540a
	or a ; $540d
	ret z ; $540e
	sound SFX_MENU_CANCEL ; $540f
	ld hl, wCharDataPointsLeft ; $5411
	inc [hl] ; $5414
	push af ; $5415
	ld hl, wStoryModeNameOfMainCharacter ; $5416
	ld a, [wStoryCharacterSlot] ; $5419
	or a ; $541c
	jr z, .zero ; $541d
	ld l, $40 ; $541f
.zero:
	ld a, l ; $5421
	add $18 ; $5422
	ld l, a ; $5424
	ld a, h ; $5425
	adc $00 ; $5426
	ld h, a ; $5428
	pop af ; $5429
	ld a, [wCharDataLevel] ; $542a
	ld [hl], a ; $542d
	push af ; $542e
	ld hl, wStoryModeNameOfMainCharacter ; $542f
	ld a, [wStoryCharacterSlot] ; $5432
	or a ; $5435
	jr z, .zero2 ; $5436
	ld l, $40 ; $5438
.zero2:
	ld a, l ; $543a
	add $38 ; $543b
	ld l, a ; $543d
	ld a, h ; $543e
	adc $00 ; $543f
	ld h, a ; $5441
	pop af ; $5442
	ld a, [wCharDataNewLevels] ; $5443
	ld [hl], a ; $5446
	ld [wCharDataLevels], a ; $5447
	push af ; $544a
	ld hl, wStoryModeNameOfMainCharacter ; $544b
	ld a, [wStoryCharacterSlot] ; $544e
	or a ; $5451
	jr z, .zero3 ; $5452
	ld l, $40 ; $5454
.zero3:
	ld a, l ; $5456
	add $39 ; $5457
	ld l, a ; $5459
	ld a, h ; $545a
	adc $00 ; $545b
	ld h, a ; $545d
	pop af ; $545e
	ld a, [wCharDataNewLevels + 1] ; $545f
	ld [hl], a ; $5462
	ld [wCharDataLevels + 1], a ; $5463
	push af ; $5466
	ld hl, wStoryModeNameOfMainCharacter ; $5467
	ld a, [wStoryCharacterSlot] ; $546a
	or a ; $546d
	jr z, .zero4 ; $546e
	ld l, $40 ; $5470
.zero4:
	ld a, l ; $5472
	add $3a ; $5473
	ld l, a ; $5475
	ld a, h ; $5476
	adc $00 ; $5477
	ld h, a ; $5479
	pop af ; $547a
	ld a, [wCharDataNewLevels + 2] ; $547b
	ld [hl], a ; $547e
	ld [wCharDataLevels + 2], a ; $547f
	push af ; $5482
	ld hl, wStoryModeNameOfMainCharacter ; $5483
	ld a, [wStoryCharacterSlot] ; $5486
	or a ; $5489
	jr z, .zero5 ; $548a
	ld l, $40 ; $548c
.zero5:
	ld a, l ; $548e
	add $3b ; $548f
	ld l, a ; $5491
	ld a, h ; $5492
	adc $00 ; $5493
	ld h, a ; $5495
	pop af ; $5496
	ld a, [wCharDataNewLevels + 3] ; $5497
	ld [hl], a ; $549a
	ld [wCharDataLevels + 3], a ; $549b
	ld a, [wStoryCharacterSlot] ; $549e
	farcall RefreshPlayerStatsAndGetPtr ; $54a1
	ld a, [wCharDataChoiceCount] ; $54a4
	ld c, a ; $54a7
	ld b, $00 ; $54a8
.loop:
	dec c ; $54aa
	jr z, .countDone ; $54ab
	push bc ; $54ad
	ld a, b ; $54ae
	add $2a ; $54af
	ld l, a ; $54b1
	adc $d0 ; $54b2
	sub l ; $54b4
	ld h, a ; $54b5
	ld a, [hl] ; $54b6
	ld d, a ; $54b7
	ld a, [wStoryCharacterSlot] ; $54b8
	farcall LevelUpPlayer ; $54bb
	pop bc ; $54be
	inc b ; $54bf
	jr .loop ; $54c0
.countDone:
	ld a, [wCharDataChoiceCount] ; $54c2
	dec a ; $54c5
	ld [wCharDataChoiceCount], a ; $54c6
	ld a, $04 ; $54c9
	ld [wCharDataPage], a ; $54cb
	call RestoreCharDataScreenRow ; $54ce
	call LoadCharStats ; $54d1
	call CharDataScreen_DrawStats ; $54d4
	call DrawCharStatsAndFlush ; $54d7
	call CharDataScreen_DrawPageColumns ; $54da
	call FlushCharDataTilemaps ; $54dd
	ld a, $01 ; $54e0
	ret ; $54e2
SelectCharDataConfirmSlot:
	wram_bank $06 ; $54e3
	ld a, $04 ; $54e9
	ld [wCharDataPage], a ; $54eb
	call WriteCharStatsToDisplayBuffer ; $54ee
	ret ; $54f1
DrawStatArrowIndicators:
	wram_bank $06 ; $54f2
	ld a, [wCharDataStatDeltas] ; $54f8
	ld de, $4c24 ; $54fb
	call QueueStatChangeArrow ; $54fe
	ld a, [wCharDataStatDeltas + 1] ; $5501
	ld de, $4c34 ; $5504
	call QueueStatChangeArrow ; $5507
	ld a, [wCharDataStatDeltas + 2] ; $550a
	ld de, $4c4c ; $550d
	call QueueStatChangeArrow ; $5510
	ld a, [wCharDataStatDeltas + 3] ; $5513
	ld de, $4c5c ; $5516
	call QueueStatChangeArrow ; $5519
	ld a, [wCharDataStatDeltas + 4] ; $551c
	ld de, $4c6c ; $551f
	call QueueStatChangeArrow ; $5522
	ld a, [wCharDataStatDeltas + 5] ; $5525
	ld de, $9c24 ; $5528
	call QueueStatChangeArrow ; $552b
	ld a, [wCharDataStatDeltas + 6] ; $552e
	ld de, $9c34 ; $5531
	call QueueStatChangeArrow ; $5534
	ld a, [wCharDataStatDeltas + 7] ; $5537
	ld de, $9c4c ; $553a
	call QueueStatChangeArrow ; $553d
	ld a, [wCharDataStatDeltas + 8] ; $5540
	ld de, $9c5c ; $5543
	call QueueStatChangeArrow ; $5546
	ld a, [wCharDataStatDeltas + 9] ; $5549
	ld de, $9c6c ; $554c
	call QueueStatChangeArrow ; $554f
	ld a, [wCharDataStatDeltas + 10] ; $5552
	ld de, $9c7c ; $5555
	call QueueStatChangeArrow ; $5558
	ret ; $555b
QueueStatChangeArrow:
	or a ; $555c
	ret z ; $555d
	bit 7, a ; $555e
	jr nz, .arrowDown ; $5560
	ld b, $0e ; $5562
	ld c, $d0 ; $5564
	call QueueSprite ; $5566
	ret ; $5569
.arrowDown:
	ld b, $0f ; $556a
	ld c, $d2 ; $556c
	call QueueSprite ; $556e
	ret ; $5571
SetupCharDataScreen:
	sound BGM_STAT_DISTRIBUTION ; $5572
	call BackupCharDataScreenRow ; $5574
	ld hl, CharDataBand0RunsStep7_1c ; $5577
	ld bc, $d240 ; $557a
	call BlitTilemapRunsFromTable ; $557d
	ld hl, CharDataBand1RunsStep6_1c ; $5580
	ld bc, $d280 ; $5583
	call BlitTilemapRunsFromTable ; $5586
	ld hl, CharDataBand2RunsStep6_1c ; $5589
	ld bc, $d2d0 ; $558c
	call BlitTilemapRunsFromTable ; $558f
	ld hl, CharDataBand3RunsStep7_1c ; $5592
	ld bc, $d310 ; $5595
	call BlitTilemapRunsFromTable ; $5598
	ld hl, CharDataBand4RunsStep3_1c ; $559b
	ld bc, $d370 ; $559e
	call BlitTilemapRunsFromTable ; $55a1
	wram_bank $06 ; $55a4
	xor a ; $55aa
	ld [wCharDataRevealTimer], a ; $55ab
	wram_bank $03 ; $55ae
	ld hl, wShadowTilemap ; $55b4
	ld de, $9800 ; $55b7
	ld c, $24 ; $55ba
	call QueueVRAMCopy ; $55bc
	wram_bank $02 ; $55bf
	ld hl, wScreenAttrmap ; $55c5
	ld de, $9800 + VRAM_BANK1 ; $55c8
	ld c, $24 ; $55cb
	call QueueVRAMCopy ; $55cd
	wram_bank $06 ; $55d0
	ld a, $03 ; $55d6
	ld [wCharDataRevealStep], a ; $55d8
	ld a, $01 ; $55db
	ld [wCharDataConfirmState], a ; $55dd
	ld [wCharDataLevelPreview], a ; $55e0
	call EnableLCD ; $55e3
	call AdvanceFrame ; $55e6
	ld a, $01 ; $55e9
	ld hl, DrawStatValueSprites ; $55eb
	call RegisterFrameTask ; $55ee
	script_fade_in $10 ; $55f1
	call WaitFadeEnd ; $55f6
	ld a, $01 ; $55f9
	ld hl, CharDataScreenAnimTask ; $55fb
	call RegisterFrameTask ; $55fe
	call RestoreCharDataScreenRow ; $5601
	call DrawCharStatRows ; $5604
	ld hl, CharDataBand8RunsStep1_1c ; $5607
	ld bc, $d410 ; $560a
	call BlitTilemapRunsFromTable ; $560d
	call FlushCharDataTilemaps ; $5610
	call RestoreCharDataScreenRow ; $5613
	call DrawCharStatRows ; $5616
	ld hl, CharDataBand7RunsStep1_1c ; $5619
	ld bc, $d3e0 ; $561c
	call BlitTilemapRunsFromTable ; $561f
	ld hl, CharDataBand8RunsStep2_1c ; $5622
	ld bc, $d410 ; $5625
	call BlitTilemapRunsFromTable ; $5628
	call FlushCharDataTilemaps ; $562b
	call RestoreCharDataScreenRow ; $562e
	call DrawCharStatRows ; $5631
	ld hl, CharDataBand7RunsStep2_1c ; $5634
	ld bc, $d3e0 ; $5637
	call BlitTilemapRunsFromTable ; $563a
	ld hl, CharDataBand8RunsStep3_1c ; $563d
	ld bc, $d410 ; $5640
	call BlitTilemapRunsFromTable ; $5643
	call FlushCharDataTilemaps ; $5646
	call RestoreCharDataScreenRow ; $5649
	call DrawCharStatRows ; $564c
	ld hl, CharDataBand7RunsStep3_1c ; $564f
	ld bc, $d3e0 ; $5652
	call BlitTilemapRunsFromTable ; $5655
	ld hl, CharDataBand8RunsStep4_1c ; $5658
	ld bc, $d410 ; $565b
	call BlitTilemapRunsFromTable ; $565e
	call FlushCharDataTilemaps ; $5661
	ret ; $5664
CharDataPageUpTargets_1c:
	; $5665, 5 bytes (bytes:5)
	db $ff, $00, $ff, $02, $01 ; 0x00
CharDataPageDownTargets_1c:
	; $566a, 5 bytes (bytes:5)
	db $01, $04, $03, $04, $ff ; 0x00
CharDataPageLeftTargets_1c:
	; $566f, 5 bytes (bytes:5)
	db $ff, $ff, $00, $01, $ff ; 0x00
CharDataPageRightTargets_1c:
	; $5674, 5 bytes (bytes:5)
	db $02, $03, $ff, $ff, $03 ; 0x00
Unused_1c_0:
	; $5679, 32 bytes (records:2)
	dw UnusedShiftGfx00 ; record 0
	dw UnusedShiftGfx01 ; record 1
	dw UnusedShiftGfx02 ; record 2
	dw UnusedShiftGfx03 ; record 3
	dw UnusedShiftGfx04 ; record 4
	dw UnusedShiftGfx05 ; record 5
	dw UnusedShiftGfx06 ; record 6
	dw UnusedShiftGfx07 ; record 7
	dw UnusedShiftGfx08 ; record 8
	dw UnusedShiftGfx09 ; record 9
	dw UnusedShiftGfx10 ; record 10
	dw UnusedShiftGfx11 ; record 11
	dw UnusedShiftGfx12 ; record 12
	dw UnusedShiftGfx13 ; record 13
	dw UnusedShiftGfx14 ; record 14
	dw UnusedShiftGfx15 ; record 15
CharDataScreenAnimTask_CharDataFlushChunkTable:
	INCBIN "data/bank_01c/d_5699.bin" ; $5699, 32 bytes
CharDataBand0RunsStep7_1c:
	; $56b9, 22 bytes (bytes:16)
	db $00, $60, $00, $0a, $00, $80, $0a, $0a, $00, $a0, $14, $0a, $00, $c0, $1e, $0a ; 0x00
	db $00, $e0, $28, $0a, $ff, $ff ; 0x10
CharDataBand0RunsStep6_1c:
	; $56cf, 21 bytes (bytes:16)
	db $00, $40, $01, $09, $00, $60, $0b, $09, $00, $80, $15, $09, $00, $a0, $1f, $09 ; 0x00
	db $00, $c0, $29, $09, $ff ; 0x10
CharDataBand0RunsStep5_1c:
	; $56e4, 21 bytes (bytes:16)
	db $00, $20, $02, $08, $00, $40, $0c, $08, $00, $60, $16, $08, $00, $80, $20, $08 ; 0x00
	db $00, $a0, $2a, $08, $ff ; 0x10
CharDataBand0RunsStep4_1c:
	; $56f9, 21 bytes (bytes:16)
	db $00, $00, $03, $07, $00, $20, $0d, $07, $00, $40, $17, $07, $00, $60, $21, $07 ; 0x00
	db $00, $80, $2b, $07, $ff ; 0x10
CharDataBand0RunsStep3_1c:
	; $570e, 13 bytes (bytes:13)
	db $00, $00, $19, $05, $00, $20, $23, $05, $00, $40, $2d, $05, $ff ; 0x00
CharDataBand0RunsStep2_1c:
	; $571b, 5 bytes (bytes:5)
	db $00, $00, $2f, $03, $ff ; 0x00
CharDataBand1RunsStep6_1c:
	; $5720, 29 bytes (bytes:16)
	db $01, $00, $00, $0a, $01, $20, $0a, $0a, $01, $40, $14, $0a, $01, $60, $1e, $0a ; 0x00
	db $01, $80, $28, $0a, $01, $a0, $32, $0a, $01, $c0, $3c, $0a, $ff ; 0x10
CharDataBand1RunsStep5_1c:
	; $573d, 29 bytes (bytes:16)
	db $01, $20, $01, $09, $01, $40, $0b, $09, $01, $60, $15, $09, $01, $80, $1f, $09 ; 0x00
	db $01, $a0, $29, $09, $01, $c0, $33, $09, $01, $e0, $3d, $09, $ff ; 0x10
CharDataBand1RunsStep4_1c:
	; $575a, 29 bytes (bytes:16)
	db $01, $40, $02, $08, $01, $60, $0c, $08, $01, $80, $16, $08, $01, $a0, $20, $08 ; 0x00
	db $01, $c0, $2a, $08, $01, $e0, $34, $08, $02, $00, $3e, $08, $ff ; 0x10
CharDataBand1RunsStep3_1c:
	; $5777, 29 bytes (bytes:16)
	db $01, $60, $03, $07, $01, $80, $0d, $07, $01, $a0, $17, $07, $01, $c0, $21, $07 ; 0x00
	db $01, $e0, $2b, $07, $02, $00, $35, $07, $02, $20, $3f, $07, $ff ; 0x10
CharDataBand1RunsStep2_1c:
	; $5794, 21 bytes (bytes:16)
	db $01, $a0, $05, $05, $01, $c0, $0f, $05, $01, $e0, $19, $05, $02, $00, $23, $05 ; 0x00
	db $02, $20, $2d, $05, $ff ; 0x10
CharDataBand1RunsStep1_1c:
	; $57a9, 13 bytes (bytes:13)
	db $01, $e0, $07, $03, $02, $00, $11, $03, $02, $20, $1b, $03, $ff ; 0x00
CharDataBand0RunsStep1_1c:
	; $57b6, 5 bytes (bytes:5)
	db $02, $20, $09, $01, $ff ; 0x00
CharDataBand2RunsStep6_1c:
	; $57bb, 21 bytes (bytes:16)
	db $00, $6a, $00, $0a, $00, $8a, $0a, $0a, $00, $aa, $14, $0a, $00, $ca, $1e, $0a ; 0x00
	db $00, $ea, $28, $0a, $ff ; 0x10
CharDataBand2RunsStep5_1c:
	; $57d0, 21 bytes (bytes:16)
	db $00, $4b, $00, $09, $00, $6b, $0a, $09, $00, $8b, $14, $09, $00, $ab, $1e, $09 ; 0x00
	db $00, $cb, $28, $09, $ff ; 0x10
CharDataBand2RunsStep4_1c:
	; $57e5, 21 bytes (bytes:16)
	db $00, $2c, $00, $08, $00, $4c, $0a, $08, $00, $6c, $14, $08, $00, $8c, $1e, $08 ; 0x00
	db $00, $ac, $28, $08, $ff ; 0x10
CharDataBand2RunsStep3_1c:
	; $57fa, 21 bytes (bytes:16)
	db $00, $0d, $00, $07, $00, $2d, $0a, $07, $00, $4d, $14, $07, $00, $6d, $1e, $07 ; 0x00
	db $00, $8d, $28, $07, $ff ; 0x10
CharDataBand2RunsStep2_1c:
	; $580f, 13 bytes (bytes:13)
	db $00, $0f, $14, $05, $00, $2f, $1e, $05, $00, $4f, $28, $05, $ff ; 0x00
CharDataBand2RunsStep1_1c:
	; $581c, 5 bytes (bytes:5)
	db $00, $11, $28, $03, $ff ; 0x00
CharDataBand3RunsStep7_1c:
	; $5821, 37 bytes (bytes:16)
	db $01, $0a, $00, $0a, $01, $2a, $0a, $0a, $01, $4a, $14, $0a, $01, $6a, $1e, $0a ; 0x00
	db $01, $8a, $28, $0a, $01, $aa, $32, $0a, $01, $ca, $3c, $0a, $01, $ea, $46, $0a ; 0x10
	db $02, $0a, $50, $0a, $ff ; 0x20
CharDataBand3RunsStep6_1c:
	; $5846, 37 bytes (bytes:16)
	db $01, $2b, $00, $09, $01, $4b, $0a, $09, $01, $6b, $14, $09, $01, $8b, $1e, $09 ; 0x00
	db $01, $ab, $28, $09, $01, $cb, $32, $09, $01, $eb, $3c, $09, $02, $0b, $46, $09 ; 0x10
	db $02, $2b, $50, $09, $ff ; 0x20
CharDataBand3RunsStep5_1c:
	; $586b, 33 bytes (bytes:16)
	db $01, $4c, $00, $08, $01, $6c, $0a, $08, $01, $8c, $14, $08, $01, $ac, $1e, $08 ; 0x00
	db $01, $cc, $28, $08, $01, $ec, $32, $08, $02, $0c, $3c, $08, $02, $2c, $46, $08 ; 0x10
	db $ff ; 0x20
CharDataBand3RunsStep4_1c:
	; $588c, 29 bytes (bytes:16)
	db $01, $6d, $00, $07, $01, $8d, $0a, $07, $01, $ad, $14, $07, $01, $cd, $1e, $07 ; 0x00
	db $01, $ed, $28, $07, $02, $0d, $32, $07, $02, $2d, $3c, $07, $ff ; 0x10
CharDataBand3RunsStep3_1c:
	; $58a9, 21 bytes (bytes:16)
	db $01, $af, $00, $05, $01, $cf, $0a, $05, $01, $ef, $14, $05, $02, $0f, $1e, $05 ; 0x00
	db $02, $2f, $28, $05, $ff ; 0x10
CharDataBand3RunsStep2_1c:
	; $58be, 13 bytes (bytes:13)
	db $01, $f1, $00, $04, $02, $11, $0a, $04, $02, $31, $14, $04, $ff ; 0x00
CharDataBand3RunsStep1_1c:
	; $58cb, 5 bytes (bytes:5)
	db $02, $33, $00, $02, $ff ; 0x00
CharDataBand4RunsStep3_1c:
	; $58d0, 13 bytes (bytes:13)
	db $00, $00, $00, $03, $00, $20, $03, $03, $00, $40, $06, $03, $ff ; 0x00
CharDataBand4RunsStep2_1c:
	; $58dd, 13 bytes (bytes:13)
	db $00, $00, $01, $02, $00, $20, $04, $02, $00, $40, $07, $02, $ff ; 0x00
CharDataBand4RunsStep1_1c:
	; $58ea, 13 bytes (bytes:13)
	db $00, $00, $02, $01, $00, $20, $05, $01, $00, $40, $08, $01, $ff ; 0x00
CharDataBand6RunsStep3_1c:
	; $58f7, 13 bytes (bytes:13)
	db $00, $03, $00, $11, $00, $23, $11, $11, $00, $43, $22, $11, $ff ; 0x00
CharDataBand6RunsStep2_1c:
	; $5904, 9 bytes (bytes:9)
	db $00, $03, $11, $11, $00, $23, $22, $11, $ff ; 0x00
CharDataBand6RunsStep1_1c:
	; $590d, 5 bytes (bytes:5)
	db $00, $03, $22, $11, $ff ; 0x00
CharDataBand5RunsStep3_1c:
	; $5912, 13 bytes (bytes:10)
	db $01, $e0, $00, $0a, $02, $00, $0a, $0a, $02, $20 ; 0x00
	db $14, $0a, $ff ; 0x0a
CharDataBand5RunsStep2_1c:
	; $591f, 9 bytes (bytes:9)
	db $02, $00, $00, $0a, $02, $20, $0a, $0a, $ff ; 0x00
CharDataBand5RunsStep1_1c:
	; $5928, 5 bytes (bytes:5)
	db $02, $20, $00, $0a, $ff ; 0x00
CharDataBand7RunsStep3_1c:
	; $592d, 13 bytes (bytes:13)
	db $00, $03, $00, $0b, $00, $23, $0b, $0b, $00, $43, $16, $0b, $ff ; 0x00
CharDataBand7RunsStep2_1c:
	; $593a, 9 bytes (bytes:9)
	db $00, $03, $0b, $0b, $00, $23, $16, $0b, $ff ; 0x00
CharDataBand7RunsStep1_1c:
	; $5943, 5 bytes (bytes:1)
	db $00 ; 0x00
	db $03 ; 0x01
	db $16 ; 0x02
	db $0b ; 0x03
	db $ff ; 0x04
CharDataBand8RunsStep4_1c:
	; $5948, 17 bytes (bytes:16)
	db $00, $0e, $00, $06, $00, $2e, $06, $06, $00, $4e, $0c, $06, $00, $6e, $12, $06 ; 0x00
	db $ff ; 0x10
CharDataBand8RunsStep3_1c:
	; $5959, 17 bytes (bytes:16)
	db $00, $10, $00, $04, $00, $30, $06, $04, $00, $50, $0c, $04, $00, $70, $12, $04 ; 0x00
	db $ff ; 0x10
CharDataBand8RunsStep2_1c:
	; $596a, 17 bytes (bytes:16)
	db $00, $12, $00, $03, $00, $32, $06, $03, $00, $52, $0c, $03, $00, $72, $12, $03 ; 0x00
	db $ff ; 0x10
CharDataBand8RunsStep1_1c:
	; $597b, 17 bytes (bytes:16)
	db $00, $14, $00, $01, $00, $34, $06, $01, $00, $54, $0c, $01, $00, $74, $12, $01 ; 0x00
	db $ff ; 0x10
CharDataScreen_LoadScreenPalette:
	INCLUDE "data/bank_01c/palettes_598c.asm" ; $598c, 64 bytes (palettes)
CharDataScreenGfx0_1c:
	INCBIN "data/bank_01c/d_59cc.bin" ; $59cc, 2618 bytes
CharDataScreenGfx1_1c:
	INCBIN "data/bank_01c/d_6406.bin" ; $6406, 99 bytes
CharDataScreenGfx2_1c:
	INCBIN "data/bank_01c/d_6469.bin" ; $6469, 59 bytes
CharDataScreenStatBar00:
	INCBIN "data/bank_01c/d_64a4.bin" ; $64a4, 5 bytes
CharDataScreenStatBar01:
	INCBIN "data/bank_01c/d_64a9.bin" ; $64a9, 5 bytes
CharDataScreenStatBar02:
	INCBIN "data/bank_01c/d_64ae.bin" ; $64ae, 5 bytes
CharDataScreenStatBar03:
	INCBIN "data/bank_01c/d_64b3.bin" ; $64b3, 5 bytes
CharDataScreenStatBar04:
	INCBIN "data/bank_01c/d_64b8.bin" ; $64b8, 5 bytes
CharDataScreenStatBar05:
	INCBIN "data/bank_01c/d_64bd.bin" ; $64bd, 5 bytes
CharDataScreenStatBar06:
	INCBIN "data/bank_01c/d_64c2.bin" ; $64c2, 5 bytes
CharDataScreenStatBar07:
	INCBIN "data/bank_01c/d_64c7.bin" ; $64c7, 5 bytes
CharDataScreenStatBar08:
	INCBIN "data/bank_01c/d_64cc.bin" ; $64cc, 5 bytes
CharDataScreenStatBar09:
	INCBIN "data/bank_01c/d_64d1.bin" ; $64d1, 5 bytes
CharDataScreenStatBar10:
	INCBIN "data/bank_01c/d_64d6.bin" ; $64d6, 5 bytes
CharDataScreenStatBar11:
	INCBIN "data/bank_01c/d_64db.bin" ; $64db, 5 bytes
CharDataScreenStatBar12:
	INCBIN "data/bank_01c/d_64e0.bin" ; $64e0, 5 bytes
CharDataScreenStatBar13:
	INCBIN "data/bank_01c/d_64e5.bin" ; $64e5, 5 bytes
CharDataScreenStatBar14:
	INCBIN "data/bank_01c/d_64ea.bin" ; $64ea, 5 bytes
CharDataScreenStatBar15:
	INCBIN "data/bank_01c/d_64ef.bin" ; $64ef, 5 bytes
CharDataScreenStatBar16:
	INCBIN "data/bank_01c/d_64f4.bin" ; $64f4, 5 bytes
CharDataScreenStatBar17:
	INCBIN "data/bank_01c/d_64f9.bin" ; $64f9, 5 bytes
CharDataScreenStatBar18:
	INCBIN "data/bank_01c/d_64fe.bin" ; $64fe, 5 bytes
CharDataScreenStatBar19:
	INCBIN "data/bank_01c/d_6503.bin" ; $6503, 5 bytes
CharDataScreenStatBar20:
	INCBIN "data/bank_01c/d_6508.bin" ; $6508, 5 bytes
CharDataScreenStatBar21:
	INCBIN "data/bank_01c/d_650d.bin" ; $650d, 5 bytes
CharDataScreenStatBar22:
	INCBIN "data/bank_01c/d_6512.bin" ; $6512, 5 bytes
CharDataScreenStatBar23:
	INCBIN "data/bank_01c/d_6517.bin" ; $6517, 5 bytes
CharDataScreenStatBar24:
	INCBIN "data/bank_01c/d_651c.bin" ; $651c, 5 bytes
CharDataScreenStatBar25:
	INCBIN "data/bank_01c/d_6521.bin" ; $6521, 5 bytes
CharDataScreenStatBar26:
	INCBIN "data/bank_01c/d_6526.bin" ; $6526, 5 bytes
CharDataScreenStatBar27:
	INCBIN "data/bank_01c/d_652b.bin" ; $652b, 5 bytes
CharDataScreenStatBar28:
	INCBIN "data/bank_01c/d_6530.bin" ; $6530, 5 bytes
CharDataScreenStatBar29:
	INCBIN "data/bank_01c/d_6535.bin" ; $6535, 5 bytes
CharDataScreenStatBar30:
	INCBIN "data/bank_01c/d_653a.bin" ; $653a, 5 bytes
CharDataScreenStatBar31:
	INCBIN "data/bank_01c/d_653f.bin" ; $653f, 5 bytes
CharDataScreenStatBar32:
	INCBIN "data/bank_01c/d_6544.bin" ; $6544, 5 bytes
CharDataScreenGfx3_1c:
	INCBIN "data/bank_01c/d_6549.bin" ; $6549, 54 bytes
CharDataScreenGfx4:
	INCBIN "data/bank_01c/d_657f.bin" ; $657f, 73 bytes
CharDataScreenGfx5:
	INCBIN "data/bank_01c/d_65c8.bin" ; $65c8, 67 bytes
CharDataScreenGfx6:
	INCBIN "data/bank_01c/d_660b.bin" ; $660b, 93 bytes
CharDataScreenGfx7:
	INCBIN "data/bank_01c/d_6668.bin" ; $6668, 58 bytes
CharDataScreenGfx8:
	INCBIN "data/bank_01c/d_66a2.bin" ; $66a2, 74 bytes
CharDataScreenGfx9:
	INCBIN "data/bank_01c/d_66ec.bin" ; $66ec, 72 bytes
CharDataScreenGfx10:
	INCBIN "data/bank_01c/d_6734.bin" ; $6734, 145 bytes
CharDataScreenGfx11:
	INCBIN "data/bank_01c/d_67c5.bin" ; $67c5, 14 bytes
CharDataScreenGfx12:
	INCBIN "data/bank_01c/d_67d3.bin" ; $67d3, 7 bytes
CharDataScreenUIGraphicsGfx0:
	INCBIN "data/bank_01c/d_67da.bin" ; $67da, 24 bytes
CharDataScreenUIGraphicsGfx1:
	INCBIN "data/bank_01c/d_67f2.bin" ; $67f2, 12 bytes
CharDataScreenUIGraphicsGfx2:
	INCBIN "data/bank_01c/d_67fe.bin" ; $67fe, 39 bytes
CharDataScreenUIGraphicsGfx3:
	INCBIN "data/bank_01c/d_6825.bin" ; $6825, 9 bytes
CharDataScreenUIGraphicsGfx4:
	INCBIN "data/bank_01c/d_682e.bin" ; $682e, 26 bytes
CharDataScreenUIGraphicsGfx5:
	INCBIN "data/bank_01c/d_6848.bin" ; $6848, 7 bytes
CharDataScreenUIGraphicsGfx6:
	INCBIN "data/bank_01c/d_684f.bin" ; $684f, 28 bytes
CharDataScreenUIGraphicsGfx7:
	INCBIN "data/bank_01c/d_686b.bin" ; $686b, 21 bytes
UnusedShiftGfx00:
	INCBIN "data/bank_01c/d_6880.bin" ; $6880, 64 bytes
UnusedShiftGfx01:
	INCBIN "data/bank_01c/d_68c0.bin" ; $68c0, 64 bytes
UnusedShiftGfx02:
	INCBIN "data/bank_01c/d_6900.bin" ; $6900, 64 bytes
UnusedShiftGfx03:
	INCBIN "data/bank_01c/d_6940.bin" ; $6940, 64 bytes
UnusedShiftGfx04:
	INCBIN "data/bank_01c/d_6980.bin" ; $6980, 64 bytes
UnusedShiftGfx05:
	INCBIN "data/bank_01c/d_69c0.bin" ; $69c0, 64 bytes
UnusedShiftGfx06:
	INCBIN "data/bank_01c/d_6a00.bin" ; $6a00, 64 bytes
UnusedShiftGfx07:
	INCBIN "data/bank_01c/d_6a40.bin" ; $6a40, 64 bytes
UnusedShiftGfx08:
	INCBIN "data/bank_01c/d_6a80.bin" ; $6a80, 64 bytes
UnusedShiftGfx09:
	INCBIN "data/bank_01c/d_6ac0.bin" ; $6ac0, 64 bytes
UnusedShiftGfx10:
	INCBIN "data/bank_01c/d_6b00.bin" ; $6b00, 64 bytes
UnusedShiftGfx11:
	INCBIN "data/bank_01c/d_6b40.bin" ; $6b40, 64 bytes
UnusedShiftGfx12:
	INCBIN "data/bank_01c/d_6b80.bin" ; $6b80, 64 bytes
UnusedShiftGfx13:
	INCBIN "data/bank_01c/d_6bc0.bin" ; $6bc0, 64 bytes
UnusedShiftGfx14:
	INCBIN "data/bank_01c/d_6c00.bin" ; $6c00, 64 bytes
UnusedShiftGfx15:
	INCBIN "data/bank_01c/d_6c40.bin" ; $6c40, 64 bytes
UnusedShiftGfx16:
	INCBIN "data/bank_01c/d_6c80.bin" ; $6c80, 64 bytes
UnusedShiftGfx17:
	INCBIN "data/bank_01c/d_6cc0.bin" ; $6cc0, 64 bytes
UnusedShiftGfx18:
	INCBIN "data/bank_01c/d_6d00.bin" ; $6d00, 64 bytes
UnusedShiftGfx19:
	INCBIN "data/bank_01c/d_6d40.bin" ; $6d40, 64 bytes
UnusedShiftGfx20:
	INCBIN "data/bank_01c/d_6d80.bin" ; $6d80, 64 bytes
UnusedShiftGfx21:
	INCBIN "data/bank_01c/d_6dc0.bin" ; $6dc0, 64 bytes
UnusedShiftGfx22:
	INCBIN "data/bank_01c/d_6e00.bin" ; $6e00, 64 bytes
UnusedShiftGfx23:
	INCBIN "data/bank_01c/d_6e40.bin" ; $6e40, 64 bytes
UnusedShiftGfx24:
	INCBIN "data/bank_01c/d_6e80.bin" ; $6e80, 64 bytes
UnusedShiftGfx25:
	INCBIN "data/bank_01c/d_6ec0.bin" ; $6ec0, 47 bytes
Unused_1c_1:
	; $6eef, 17 bytes (bytes:16)
	db $ec, $00, $00, $00, $00, $08, $07, $20, $1f, $44, $38, $0a, $71, $84, $73, $10 ; 0x00
	db $e7 ; 0x10
UnusedShiftGfx26:
	; $6f00, 42 bytes (bytes:16)
	db $00, $d9, $00, $d9, $40, $99, $a0, $19, $49, $30, $00, $f0, $10, $e0, $20, $c0 ; 0x00
	db $20, $cf, $10, $cf, $40, $9f, $a0, $1f, $42, $3c, $09, $f0, $94, $63, $48, $27 ; 0x10
	db $80, $00, $00, $00, $00, $00, $80, $00, $20, $c0 ; 0x20
CharDataScreenTiles_1c:
	INCBIN "data/bank_01c/d_6f2a.bin" ; $6f2a, 22 bytes
UnusedShiftGfx27:
	INCBIN "data/bank_01c/d_6f40.bin" ; $6f40, 64 bytes
UnusedShiftGfx28:
	INCBIN "data/bank_01c/d_6f80.bin" ; $6f80, 64 bytes
UnusedShiftGfx29:
	INCBIN "data/bank_01c/d_6fc0.bin" ; $6fc0, 64 bytes
UnusedShiftGfx30:
	INCBIN "data/bank_01c/d_7000.bin" ; $7000, 64 bytes
UnusedShiftGfx31:
	INCBIN "data/bank_01c/d_7040.bin" ; $7040, 64 bytes
CharDataScreenGfx13:
	INCBIN "data/bank_01c/d_7080.bin" ; $7080, 150 bytes
CharDataScreen_LoadScreen:
	ld hl, CharDataScreen_LoadScreenPalette ; $7116
	ld de, $0008 ; $7119
	call LoadPaletteShadow ; $711c
	ld hl, CharDataScreen_LoadScreenPalette ; $711f
	ld de, $0808 ; $7122
	call LoadPaletteShadow ; $7125
	wram_bank $01 ; $7128
	ld hl, CharDataScreenGfx13 ; $712e
	ld de, wDecompBuffer ; $7131
	call DecompressData ; $7134
	ld hl, wDecompBuffer ; $7137
	ld de, $8000 + VRAM_BANK1 ; $713a
	ld c, $14 ; $713d
	call QueueVRAMCopy ; $713f
	farcall CharDataScreen_LoadGfx ; $7142
	wram_bank $01 ; $7145
	ld hl, CharDataScreenGfx0_1c ; $714b
	ld de, wDecompBuffer ; $714e
	call DecompressData ; $7151
	ld hl, wDecompBuffer ; $7154
	ld de, $9000 + VRAM_BANK1 ; $7157
	ld c, $80 ; $715a
	call QueueVRAMCopy ; $715c
	ld hl, wTextTileBuffer ; $715f
	ld de, $8800 + VRAM_BANK1 ; $7162
	ld c, $80 ; $7165
	call QueueVRAMCopy ; $7167
	wram_bank $01 ; $716a
	ld hl, CharDataScreenGfx1_1c ; $7170
	ld de, wDecompBuffer ; $7173
	call DecompressData ; $7176
	ld hl, wDecompBuffer ; $7179
	ld bc, $0240 ; $717c
	call CopyWram1ToWram3 ; $717f
	wram_bank $01 ; $7182
	ld hl, CharDataScreenGfx2_1c ; $7188
	ld de, wDecompBuffer ; $718b
	call DecompressData ; $718e
	ld hl, wDecompBuffer ; $7191
	ld bc, $0240 ; $7194
	call CopyWram1ToWram2 ; $7197
	wram_bank $01 ; $719a
	ld hl, CharDataScreenGfx3_1c ; $71a0
	ld de, wDecompBuffer + 36 * TILE_SIZE ; $71a3
	call DecompressData ; $71a6
	ld hl, wDecompBuffer + 36 * TILE_SIZE ; $71a9
	ld bc, $0032 ; $71ac
	call CopyWram1ToWram3 ; $71af
	wram_bank $01 ; $71b2
	ld hl, CharDataScreenGfx4 ; $71b8
	ld de, wDecompBuffer + 36 * TILE_SIZE ; $71bb
	call DecompressData ; $71be
	ld hl, wDecompBuffer + 36 * TILE_SIZE ; $71c1
	ld bc, $0032 ; $71c4
	call CopyWram1ToWram2 ; $71c7
	wram_bank $01 ; $71ca
	ld hl, CharDataScreenGfx5 ; $71d0
	ld de, wDecompBuffer + 40 * TILE_SIZE ; $71d3
	call DecompressData ; $71d6
	ld hl, wDecompBuffer + 40 * TILE_SIZE ; $71d9
	ld bc, $0046 ; $71dc
	call CopyWram1ToWram3 ; $71df
	wram_bank $01 ; $71e2
	ld hl, CharDataScreenGfx6 ; $71e8
	ld de, wDecompBuffer + 40 * TILE_SIZE ; $71eb
	call DecompressData ; $71ee
	ld hl, wDecompBuffer + 40 * TILE_SIZE ; $71f1
	ld bc, $0046 ; $71f4
	call CopyWram1ToWram2 ; $71f7
	wram_bank $01 ; $71fa
	ld hl, CharDataScreenGfx7 ; $7200
	ld de, wDecompBuffer + 45 * TILE_SIZE ; $7203
	call DecompressData ; $7206
	ld hl, wDecompBuffer + 45 * TILE_SIZE ; $7209
	ld bc, $0032 ; $720c
	call CopyWram1ToWram3 ; $720f
	wram_bank $01 ; $7212
	ld hl, CharDataScreenGfx8 ; $7218
	ld de, wDecompBuffer + 45 * TILE_SIZE ; $721b
	call DecompressData ; $721e
	ld hl, wDecompBuffer + 45 * TILE_SIZE ; $7221
	ld bc, $0032 ; $7224
	call CopyWram1ToWram2 ; $7227
	wram_bank $01 ; $722a
	ld hl, CharDataScreenGfx9 ; $7230
	ld de, wDecompBuffer + 49 * TILE_SIZE ; $7233
	call DecompressData ; $7236
	ld hl, wDecompBuffer + 49 * TILE_SIZE ; $7239
	ld bc, $005a ; $723c
	call CopyWram1ToWram3 ; $723f
	wram_bank $01 ; $7242
	ld hl, CharDataScreenGfx10 ; $7248
	ld de, wDecompBuffer + 49 * TILE_SIZE ; $724b
	call DecompressData ; $724e
	ld hl, wDecompBuffer + 49 * TILE_SIZE ; $7251
	ld bc, $005a ; $7254
	call CopyWram1ToWram2 ; $7257
	wram_bank $01 ; $725a
	ld hl, CharDataScreenGfx11 ; $7260
	ld de, wDecompBuffer + 55 * TILE_SIZE ; $7263
	call DecompressData ; $7266
	ld hl, wDecompBuffer + 55 * TILE_SIZE ; $7269
	ld bc, $0009 ; $726c
	call CopyWram1ToWram3 ; $726f
	wram_bank $01 ; $7272
	ld hl, CharDataScreenGfx12 ; $7278
	ld de, wDecompBuffer + 55 * TILE_SIZE ; $727b
	call DecompressData ; $727e
	ld hl, wDecompBuffer + 55 * TILE_SIZE ; $7281
	ld bc, $0009 ; $7284
	call CopyWram1ToWram2 ; $7287
	ret ; $728a
LoadCharDataScreenTilemaps:
	wram_bank $01 ; $728b
	ld hl, CharDataScreenUIGraphicsGfx4 ; $7291
	ld de, wDecompBuffer + 85 * TILE_SIZE ; $7294
	call DecompressData ; $7297
	ld hl, wDecompBuffer + 85 * TILE_SIZE ; $729a
	ld bc, $0021 ; $729d
	call CopyWram1ToWram3 ; $72a0
	wram_bank $01 ; $72a3
	ld hl, CharDataScreenUIGraphicsGfx5 ; $72a9
	ld de, wDecompBuffer + 85 * TILE_SIZE ; $72ac
	call DecompressData ; $72af
	ld hl, wDecompBuffer + 85 * TILE_SIZE ; $72b2
	ld bc, $0021 ; $72b5
	call CopyWram1ToWram2 ; $72b8
	wram_bank $01 ; $72bb
	ld hl, CharDataScreenUIGraphicsGfx6 ; $72c1
	ld de, wDecompBuffer + 88 * TILE_SIZE ; $72c4
	call DecompressData ; $72c7
	ld hl, wDecompBuffer + 88 * TILE_SIZE ; $72ca
	ld bc, $0018 ; $72cd
	call CopyWram1ToWram3 ; $72d0
	wram_bank $01 ; $72d3
	ld hl, CharDataScreenUIGraphicsGfx7 ; $72d9
	ld de, wDecompBuffer + 88 * TILE_SIZE ; $72dc
	call DecompressData ; $72df
	ld hl, wDecompBuffer + 88 * TILE_SIZE ; $72e2
	ld bc, $0018 ; $72e5
	call CopyWram1ToWram2 ; $72e8
	ret ; $72eb
StartCharDataScreenAnimTask:
	ld a, $01 ; $72ec
	ld hl, CharDataScreenAnimTask ; $72ee
	call RegisterFrameTask ; $72f1
	ret ; $72f4
StopCharDataScreenAnimTask:
	ld hl, CharDataScreenAnimTask ; $72f5
	call UnregisterFrameTask ; $72f8
	ret ; $72fb
FlushCharDataTilemapsFar:
	call FlushCharDataTilemaps ; $72fc
	ret ; $72ff
BackupCharData:
	wram_bank $06 ; $7300
	ld hl, wCharDataPointsWorking ; $7306
	ld de, wCharDataEditBackup ; $7309
	ld bc, $0006 ; $730c
	call CopyMemoryBC ; $730f
	ld hl, wCharDataChoiceCount ; $7312
	ld de, wCharDataChoiceBackup ; $7315
	ld bc, $0065 ; $7318
	call CopyMemoryBC ; $731b
	ret ; $731e
RestoreCharData:
	wram_bank $06 ; $731f
	ld hl, wCharDataEditBackup ; $7325
	ld de, wCharDataPointsWorking ; $7328
	ld bc, $0006 ; $732b
	call CopyMemoryBC ; $732e
	ld hl, wCharDataChoiceBackup ; $7331
	ld de, wCharDataChoiceCount ; $7334
	ld bc, $0065 ; $7337
	call CopyMemoryBC ; $733a
	ld a, $01 ; $733d
	ld [wCharDataViewOnly], a ; $733f
	xor a ; $7342
	ld [wStoryCharacterSlot], a ; $7343
	ld a, [wCharDataPointsWorking] ; $7346
	ld [wCharDataPointsLeft], a ; $7349
	push af ; $734c
	ld hl, wStoryModeNameOfMainCharacter ; $734d
	ld a, [wStoryCharacterSlot] ; $7350
	or a ; $7353
	jr z, .zero ; $7354
	ld l, $40 ; $7356
.zero:
	ld a, l ; $7358
	add $18 ; $7359
	ld l, a ; $735b
	ld a, h ; $735c
	adc $00 ; $735d
	ld h, a ; $735f
	pop af ; $7360
	ld a, [wCharDataLevel] ; $7361
	ld [hl], a ; $7364
	push af ; $7365
	ld hl, wStoryModeNameOfMainCharacter ; $7366
	ld a, [wStoryCharacterSlot] ; $7369
	or a ; $736c
	jr z, .zero2 ; $736d
	ld l, $40 ; $736f
.zero2:
	ld a, l ; $7371
	add $38 ; $7372
	ld l, a ; $7374
	ld a, h ; $7375
	adc $00 ; $7376
	ld h, a ; $7378
	pop af ; $7379
	ld a, [wCharDataNewLevels] ; $737a
	ld [hl], a ; $737d
	ld [wCharDataLevels], a ; $737e
	push af ; $7381
	ld hl, wStoryModeNameOfMainCharacter ; $7382
	ld a, [wStoryCharacterSlot] ; $7385
	or a ; $7388
	jr z, .zero3 ; $7389
	ld l, $40 ; $738b
.zero3:
	ld a, l ; $738d
	add $39 ; $738e
	ld l, a ; $7390
	ld a, h ; $7391
	adc $00 ; $7392
	ld h, a ; $7394
	pop af ; $7395
	ld a, [wCharDataNewLevels + 1] ; $7396
	ld [hl], a ; $7399
	ld [wCharDataLevels + 1], a ; $739a
	push af ; $739d
	ld hl, wStoryModeNameOfMainCharacter ; $739e
	ld a, [wStoryCharacterSlot] ; $73a1
	or a ; $73a4
	jr z, .zero4 ; $73a5
	ld l, $40 ; $73a7
.zero4:
	ld a, l ; $73a9
	add $3a ; $73aa
	ld l, a ; $73ac
	ld a, h ; $73ad
	adc $00 ; $73ae
	ld h, a ; $73b0
	pop af ; $73b1
	ld a, [wCharDataNewLevels + 2] ; $73b2
	ld [hl], a ; $73b5
	ld [wCharDataLevels + 2], a ; $73b6
	push af ; $73b9
	ld hl, wStoryModeNameOfMainCharacter ; $73ba
	ld a, [wStoryCharacterSlot] ; $73bd
	or a ; $73c0
	jr z, .zero5 ; $73c1
	ld l, $40 ; $73c3
.zero5:
	ld a, l ; $73c5
	add $3b ; $73c6
	ld l, a ; $73c8
	ld a, h ; $73c9
	adc $00 ; $73ca
	ld h, a ; $73cc
	pop af ; $73cd
	ld a, [wCharDataNewLevels + 3] ; $73ce
	ld [hl], a ; $73d1
	ld [wCharDataLevels + 3], a ; $73d2
	xor a ; $73d5
	farcall RefreshPlayerStatsAndGetPtr ; $73d6
	wram_bank $06 ; $73d9
	ld hl, wCharDataChoiceLog ; $73df
	ld a, [wCharDataChoiceCount] ; $73e2
	ld b, a ; $73e5
.loop:
	ld a, [hl+] ; $73e6
	push bc ; $73e7
	push hl ; $73e8
	ld d, a ; $73e9
	xor a ; $73ea
	farcall LevelUpPlayer ; $73eb
	pop hl ; $73ee
	pop bc ; $73ef
	dec b ; $73f0
	jr nz, .loop ; $73f1
	ret ; $73f3
LoadCharDataScreenGraphics:
	call LoadCharDataScreenBgAndPalettes ; $73f4
	call LoadCharDataScreenMugshots ; $73f7
	ret ; $73fa
LoadCharDataScreenBgAndPalettes:
	ld hl, CharDataScreenBgAndPalettes ; $73fb
	ld de, $0008 ; $73fe
	call LoadPaletteShadow ; $7401
	ld hl, CharDataScreenBgAndPalettes ; $7404
	ld de, $0808 ; $7407
	call LoadPaletteShadow ; $740a
	wram_bank $06 ; $740d
	ld a, [wMasterPalettes + 58] ; $7413
	ld [wExpScreenCharStats + 10], a ; $7416
	ld a, [wMasterPalettes + 59] ; $7419
	ld [wExpScreenCharStats + 11], a ; $741c
	ld a, [wMasterPalettes + 34] ; $741f
	ld [wExpScreenCharStats + 25], a ; $7422
	ld a, [wMasterPalettes + 35] ; $7425
	ld [wExpScreenCharStats + 26], a ; $7428
	ld hl, wMasterPalettes + 34 ; $742b
	farcall GrayscalePaletteColorInPlace ; $742e
	ld hl, wMasterPalettes + 34 ; $7431
	farcall GrayscalePaletteColorInPlace ; $7434
	wram_bank $01 ; $7437
	ld hl, CharDataScreenBgAndPalettes0 ; $743d
	ld de, wDecompBuffer ; $7440
	call DecompressData ; $7443
	ld hl, wDecompBuffer ; $7446
	ld de, $9000 + VRAM_BANK1 ; $7449
	ld c, $80 ; $744c
	call QueueVRAMCopy ; $744e
	ld hl, wTextTileBuffer ; $7451
	ld de, $8800 + VRAM_BANK1 ; $7454
	ld c, $80 ; $7457
	call QueueVRAMCopy ; $7459
	wram_bank $01 ; $745c
	ld hl, CharDataScreenBgAndPalettes1 ; $7462
	ld de, wDecompBuffer ; $7465
	call DecompressData ; $7468
	ld hl, wDecompBuffer ; $746b
	ld bc, $0240 ; $746e
	call CopyWram1ToWram3 ; $7471
	wram_bank $01 ; $7474
	ld hl, CharDataScreenBgAndPalettes2 ; $747a
	ld de, wDecompBuffer ; $747d
	call DecompressData ; $7480
	ld hl, wDecompBuffer ; $7483
	ld bc, $0240 ; $7486
	call CopyWram1ToWram2 ; $7489
	ret ; $748c
LoadCharDataScreenMugshots:
	xor a ; $748d
	ld [wStoryCharacterSlot], a ; $748e
	push af ; $7491
	ld hl, wStoryModeNameOfMainCharacter ; $7492
	ld a, [wStoryCharacterSlot] ; $7495
	or a ; $7498
	jr z, .zero ; $7499
	ld l, $40 ; $749b
.zero:
	ld a, l ; $749d
	add $0c ; $749e
	ld l, a ; $74a0
	ld a, h ; $74a1
	adc $00 ; $74a2
	ld h, a ; $74a4
	pop af ; $74a5
	ld a, [hl] ; $74a6
	ld de, $0101 ; $74a7
	farcall LoadIndexedPaletteThunk ; $74aa
	wram_bank $01 ; $74ad
	push af ; $74b3
	ld hl, wStoryModeNameOfMainCharacter ; $74b4
	ld a, [wStoryCharacterSlot] ; $74b7
	or a ; $74ba
	jr z, .zero2 ; $74bb
	ld l, $40 ; $74bd
.zero2:
	ld a, l ; $74bf
	add $0b ; $74c0
	ld l, a ; $74c2
	ld a, h ; $74c3
	adc $00 ; $74c4
	ld h, a ; $74c6
	pop af ; $74c7
	ld a, [hl] ; $74c8
	ld de, wDecompBuffer ; $74c9
	farcall DecompressCharMugshot ; $74cc
	ld hl, wDecompBuffer ; $74cf
	ld de, $8b00 + VRAM_BANK1 ; $74d2
	ld c, $09 ; $74d5
	call QueueVRAMCopy ; $74d7
	ld a, $01 ; $74da
	ld [wStoryCharacterSlot], a ; $74dc
	push af ; $74df
	ld hl, wStoryModeNameOfMainCharacter ; $74e0
	ld a, [wStoryCharacterSlot] ; $74e3
	or a ; $74e6
	jr z, .zero3 ; $74e7
	ld l, $40 ; $74e9
.zero3:
	ld a, l ; $74eb
	add $0c ; $74ec
	ld l, a ; $74ee
	ld a, h ; $74ef
	adc $00 ; $74f0
	ld h, a ; $74f2
	pop af ; $74f3
	ld a, [hl] ; $74f4
	ld de, $0201 ; $74f5
	farcall LoadIndexedPaletteThunk ; $74f8
	wram_bank $01 ; $74fb
	push af ; $7501
	ld hl, wStoryModeNameOfMainCharacter ; $7502
	ld a, [wStoryCharacterSlot] ; $7505
	or a ; $7508
	jr z, .zero4 ; $7509
	ld l, $40 ; $750b
.zero4:
	ld a, l ; $750d
	add $0b ; $750e
	ld l, a ; $7510
	ld a, h ; $7511
	adc $00 ; $7512
	ld h, a ; $7514
	pop af ; $7515
	ld a, [hl] ; $7516
	ld de, wDecompBuffer ; $7517
	farcall DecompressCharMugshot ; $751a
	ld hl, wDecompBuffer ; $751d
	ld de, $8c00 + VRAM_BANK1 ; $7520
	ld c, $09 ; $7523
	call QueueVRAMCopy ; $7525
	ld hl, wMasterPalettes + 16 ; $7528
	farcall GrayscalePaletteColorInPlace ; $752b
	ld hl, wMasterPalettes + 18 ; $752e
	farcall GrayscalePaletteColorInPlace ; $7531
	ld hl, wMasterPalettes + 20 ; $7534
	farcall GrayscalePaletteColorInPlace ; $7537
	ld hl, wMasterPalettes + 22 ; $753a
	farcall GrayscalePaletteColorInPlace ; $753d
	ret ; $7540
CharDataScreenBgAndPalettes:
	INCLUDE "data/bank_01c/palettes_7541.asm" ; $7541, 64 bytes (palettes)
CharDataScreenBgAndPalettes0:
	INCBIN "data/bank_01c/d_7581.bin" ; $7581, 1886 bytes
CharDataScreenBgAndPalettes1:
	INCBIN "data/bank_01c/d_7cdf.bin" ; $7cdf, 320 bytes
CharDataScreenBgAndPalettes2:
	INCBIN "data/bank_01c/d_7e1f.bin" ; $7e1f, 216 bytes
	; $7ef7, 265 bytes fill to bank end (linker-padded)
