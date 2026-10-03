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
	push_wram_bank WRAM_SCENE ; $401a
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
	wram_bank WRAM_SCENE ; $4060
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
	script_fade_in 16 ; $4082
	call WaitFadeEnd ; $4087
	ld a, $01 ; $408a
	ld hl, CharDataScreenAnimTask ; $408c
	call RegisterFrameTask ; $408f
	call AnimateCharDataStatsReveal ; $4092
	wram_bank WRAM_SCENE ; $4095
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
	ld c, 16 ; $40b6
	call BeginFadeOut ; $40b8
	call WaitFadeEnd ; $40bb
	ld hl, wStoryModeNameOfMainCharacter ; $40be
	ld de, wStorySlotData ; $40c1
	ld c, (2 * CHAR_RECORD_SIZE) / 16 ; $40c4
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
	pop_wram_bank ; $40ea
	ld a, b ; $40ef
	ret ; $40f0
.levelUpPending:
	pop bc ; $40f1
	pop bc ; $40f2
	pop_wram_bank ; $40f3
	ld a, $ff ; $40f8
	ret ; $40fa
CharDataScreen_InitState:
	wram_bank WRAM_SCENE ; $40fb
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
	wram_bank WRAM_SCREEN ; $41e5
	ld hl, wShadowTilemap ; $41eb
	ld de, vBGMap0 ; $41ee
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $41f1
	call QueueVRAMCopy ; $41f3
	wram_bank WRAM_COURT_PLANES ; $41f6
	ld hl, wScreenAttrmap ; $41fc
	ld de, vBGMap0 + VRAM_BANK1 ; $41ff
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $4202
	call QueueVRAMCopy ; $4204
	ret ; $4207
CharDataScreen_LoadUIGraphics:
	call CharDataScreen_LoadScreen ; $4208
	wram_bank WRAM_STAGING ; $420b
	ld hl, CharDataScreenUIPatch2Tilemap ; $4211
	ld de, wDecompBuffer + 31 * TILEMAP_WIDTH ; $4214
	call DecompressData ; $4217
	ld hl, wDecompBuffer + 31 * TILEMAP_WIDTH ; $421a
	ld bc, CharDataScreenUIPatch2Tilemap_SIZE ; $421d
	call CopyWram1ToWram3 ; $4220
	wram_bank WRAM_STAGING ; $4223
	ld hl, CharDataScreenUIPatch2Attrmap ; $4229
	ld de, wDecompBuffer + 31 * TILEMAP_WIDTH ; $422c
	call DecompressData ; $422f
	ld hl, wDecompBuffer + 31 * TILEMAP_WIDTH ; $4232
	ld bc, CharDataScreenUIPatch2Attrmap_SIZE ; $4235
	call CopyWram1ToWram2 ; $4238
	wram_bank WRAM_STAGING ; $423b
	ld hl, CharDataScreenUIPatch3Tilemap ; $4241
	ld de, wDecompBuffer + 32 * TILEMAP_WIDTH + 16 ; $4244
	call DecompressData ; $4247
	ld hl, wDecompBuffer + 32 * TILEMAP_WIDTH + 16 ; $424a
	ld bc, CharDataScreenUIPatch3Tilemap_SIZE ; $424d
	call CopyWram1ToWram3 ; $4250
	wram_bank WRAM_STAGING ; $4253
	ld hl, CharDataScreenUIPatch3Attrmap ; $4259
	ld de, wDecompBuffer + 32 * TILEMAP_WIDTH + 16 ; $425c
	call DecompressData ; $425f
	ld hl, wDecompBuffer + 32 * TILEMAP_WIDTH + 16 ; $4262
	ld bc, CharDataScreenUIPatch3Attrmap_SIZE ; $4265
	call CopyWram1ToWram2 ; $4268
	wram_bank WRAM_STAGING ; $426b
	ld hl, CharDataScreenUIPatch1Tilemap ; $4271
	ld de, wDecompBuffer + 29 * TILEMAP_WIDTH ; $4274
	call DecompressData ; $4277
	ld hl, wDecompBuffer + 29 * TILEMAP_WIDTH ; $427a
	ld bc, CharDataScreenUIPatch1Tilemap_SIZE ; $427d
	call CopyWram1ToWram3 ; $4280
	wram_bank WRAM_STAGING ; $4283
	ld hl, CharDataScreenUIPatch1Attrmap ; $4289
	ld de, wDecompBuffer + 29 * TILEMAP_WIDTH ; $428c
	call DecompressData ; $428f
	ld hl, wDecompBuffer + 29 * TILEMAP_WIDTH ; $4292
	ld bc, CharDataScreenUIPatch1Attrmap_SIZE ; $4295
	call CopyWram1ToWram2 ; $4298
	wram_bank WRAM_STAGING ; $429b
	ld hl, CharDataScreenUIPatch0Tilemap ; $42a1
	ld de, wDecompBuffer + 28 * TILEMAP_WIDTH ; $42a4
	call DecompressData ; $42a7
	ld hl, wDecompBuffer + 28 * TILEMAP_WIDTH ; $42aa
	ld bc, CharDataScreenUIPatch0Tilemap_SIZE ; $42ad
	call CopyWram1ToWram3 ; $42b0
	wram_bank WRAM_STAGING ; $42b3
	ld hl, CharDataScreenUIPatch0Attrmap ; $42b9
	ld de, wDecompBuffer + 28 * TILEMAP_WIDTH ; $42bc
	call DecompressData ; $42bf
	ld hl, wDecompBuffer + 28 * TILEMAP_WIDTH ; $42c2
	ld bc, CharDataScreenUIPatch0Attrmap_SIZE ; $42c5
	call CopyWram1ToWram2 ; $42c8
	ret ; $42cb
CopyWram1ToWram3:
	wram_bank WRAM_STAGING ; $42cc
	ld d, [hl] ; $42d2
	wram_bank WRAM_SCREEN ; $42d3
	ld [hl], d ; $42d9
	inc hl ; $42da
	dec bc ; $42db
	ld a, b ; $42dc
	or c ; $42dd
	jr nz, CopyWram1ToWram3 ; $42de
	ret ; $42e0
CopyWram1ToWram2:
	wram_bank WRAM_STAGING ; $42e1
	ld d, [hl] ; $42e7
	wram_bank WRAM_COURT_PLANES ; $42e8
	ld [hl], d ; $42ee
	inc hl ; $42ef
	dec bc ; $42f0
	ld a, b ; $42f1
	or c ; $42f2
	jr nz, CopyWram1ToWram2 ; $42f3
	ret ; $42f5
CharDataScreen_DrawStats:
	wram_bank WRAM_SCENE ; $42f6
	ld a, [wCharDataViewOnly] ; $42fc
	or a ; $42ff
	jr z, .statsReady ; $4300
	call LoadCharStats ; $4302
.statsReady:
	farcall CharDataScreen_BuildStats ; $4305
	wram_bank WRAM_SCENE ; $4308
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
	wram_bank WRAM_SCENE ; $4331
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
	wram_bank WRAM_SCENE ; $435a
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
	wram_bank WRAM_SCENE ; $4383
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
	wram_bank WRAM_SCENE ; $43ac
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
	wram_bank WRAM_SCENE ; $43d5
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
	wram_bank WRAM_SCENE ; $43fe
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
	wram_bank WRAM_SCENE ; $4427
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
	wram_bank WRAM_SCENE ; $4450
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
	wram_bank WRAM_SCENE ; $4479
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
	wram_bank WRAM_SCENE ; $44a2
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
	wram_bank WRAM_SCENE ; $44cc
	ld a, [wCharDataNumberBuffer] ; $44d2
	ld c, a ; $44d5
	wram_bank WRAM_SCREEN ; $44d6
	ld a, c ; $44dc
	ld [de], a ; $44dd
	wram_bank WRAM_COURT_PLANES ; $44de
	xor a ; $44e4
	ld [de], a ; $44e5
	inc de ; $44e6
	wram_bank WRAM_SCENE ; $44e7
	ld a, [wCharDataNumberBuffer + 1] ; $44ed
	ld c, a ; $44f0
	wram_bank WRAM_SCREEN ; $44f1
	ld a, c ; $44f7
	ld [de], a ; $44f8
	wram_bank WRAM_COURT_PLANES ; $44f9
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
	ld_hl_indexed CharDataScreen_DrawStatBarPtrs ; $4509
	ld a, [hl+] ; $4510
	ld h, [hl] ; $4511
	ld l, a ; $4512
	jr .copyTiles ; $4513
.altTable:
	ld a, b ; $4515
	rlca ; $4516
	ld_hl_indexed CharDataScreen_DrawStatBarTable0 ; $4517
	ld a, [hl+] ; $451e
	ld h, [hl] ; $451f
	ld l, a ; $4520
.copyTiles:
	push de ; $4521
	wram_bank WRAM_SCREEN ; $4522
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
	wram_bank WRAM_COURT_PLANES ; $4536
	ld a, b ; $453c
	rlca ; $453d
	ld_hl_indexed CharDataScreen_DrawStatBarTable1 ; $453e
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
	; $456e, 22 bytes (records:2)
	dw CharDataScreenStatBar11 ; record 0
	dw CharDataScreenStatBar12 ; record 1
	dw CharDataScreenStatBar13 ; record 2
	dw CharDataScreenStatBar14 ; record 3
	dw CharDataScreenStatBar15 ; record 4
	dw CharDataScreenStatBar16 ; record 5
	dw CharDataScreenStatBar17 ; record 6
	dw CharDataScreenStatBar18 ; record 7
	dw CharDataScreenStatBar19 ; record 8
	dw CharDataScreenStatBar20 ; record 9
	dw CharDataScreenStatBar21 ; record 10
CharDataScreen_DrawStatBarTable1:
	; $4584, 22 bytes (records:2)
	dw CharDataScreenStatBar22 ; record 0
	dw CharDataScreenStatBar23 ; record 1
	dw CharDataScreenStatBar24 ; record 2
	dw CharDataScreenStatBar25 ; record 3
	dw CharDataScreenStatBar26 ; record 4
	dw CharDataScreenStatBar27 ; record 5
	dw CharDataScreenStatBar28 ; record 6
	dw CharDataScreenStatBar29 ; record 7
	dw CharDataScreenStatBar30 ; record 8
	dw CharDataScreenStatBar31 ; record 9
	dw CharDataScreenStatBar32 ; record 10
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
	ld_bg_pals de, 4, 1 ; $45b0
	farcall LoadIndexedPaletteThunk ; $45b3
	wram_bank WRAM_STAGING ; $45b6
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
	ld de, vTiles2 + $20 * TILE_SIZE + VRAM_BANK1 ; $45db
	ld c, 3 ; $45de
	call QueueVRAMCopy ; $45e0
	ld hl, wDecompBuffer + 3 * TILE_SIZE ; $45e3
	ld de, vTiles2 + $30 * TILE_SIZE + VRAM_BANK1 ; $45e6
	ld c, 3 ; $45e9
	call QueueVRAMCopy ; $45eb
	ld hl, wDecompBuffer + 6 * TILE_SIZE ; $45ee
	ld de, vTiles2 + $40 * TILE_SIZE + VRAM_BANK1 ; $45f1
	ld c, 3 ; $45f4
	call QueueVRAMCopy ; $45f6
	ret ; $45f9
CharDataScreenAnimTask:
	push af ; $45fa
	push bc ; $45fb
	push de ; $45fc
	push hl ; $45fd
	push_wram_bank WRAM_SCENE ; $45fe
	ld a, [wCharDataFlushChunk] ; $4607
	or a ; $460a
	jp nz, .nonZero ; $460b
	wram_bank WRAM_SCENE ; $460e
	ld a, [wCharDataAnimCounter] ; $4614
	inc a ; $4617
	ld [wCharDataAnimCounter], a ; $4618
	and $0f ; $461b
	rlca ; $461d
	push af ; $461e
	ld_hl_indexed Unused_1c_0 ; $461f
	ld a, [hl+] ; $4626
	ld h, [hl] ; $4627
	ld l, a ; $4628
	push hl ; $4629
	ld de, vTiles2 + $2e * TILE_SIZE + VRAM_BANK1 ; $462a
	ld c, 2 ; $462d
	call QueueVRAMCopy ; $462f
	pop hl ; $4632
	ld a, $20 ; $4633
	add l ; $4635
	ld l, a ; $4636
	jr nc, .queueVRAMCopy ; $4637
	inc h ; $4639
.queueVRAMCopy:
	ld de, vTiles2 + $3e * TILE_SIZE + VRAM_BANK1 ; $463a
	ld c, 2 ; $463d
	call QueueVRAMCopy ; $463f
	pop af ; $4642
	ld_hl_indexed CharDataScreenAnimTask_CharDataFlushChunkTable ; $4643
	ld a, [hl+] ; $464a
	ld h, [hl] ; $464b
	ld l, a ; $464c
	push hl ; $464d
	ld de, vTiles2 + $4e * TILE_SIZE + VRAM_BANK1 ; $464e
	ld c, 2 ; $4651
	call QueueVRAMCopy ; $4653
	pop hl ; $4656
	ld a, $20 ; $4657
	add l ; $4659
	ld l, a ; $465a
	jr nc, .queueVRAMCopy2 ; $465b
	inc h ; $465d
.queueVRAMCopy2:
	ld de, vTiles2 + $5e * TILE_SIZE + VRAM_BANK1 ; $465e
	ld c, 2 ; $4661
	call QueueVRAMCopy ; $4663
.nonZero:
	wram_bank WRAM_SCENE ; $4666
	ld a, [wCharDataFlushChunk] ; $466c
	inc a ; $466f
	cp $03 ; $4670
	jr nz, .store ; $4672
	xor a ; $4674
.store:
	ld [wCharDataFlushChunk], a ; $4675
	pop_wram_bank ; $4678
	pop hl ; $467d
	pop de ; $467e
	pop bc ; $467f
	pop af ; $4680
	ret ; $4681
