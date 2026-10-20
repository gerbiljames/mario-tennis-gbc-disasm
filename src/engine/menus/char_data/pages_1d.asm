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
	script_fade_out 127 ; $4029
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
	ld de, vTiles0 tile $60 + VRAM_BANK1 ; $404f
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
	res B_IE_TIMER, [hl] ; $4078
	call EnableLCD ; $407a
	call AdvanceFrame ; $407d
	frame_task CharDataScreenBgScrollTask ; $4080
	frame_task DrawCharDataPageArrowsTask ; $4088
	frame_task CharDataValuesSyncTask ; $4090
	farcall StartCharDataScreenAnimTask ; $4098
	script_fade_in 16 ; $409b
	call WaitFadeEnd ; $40a0
	call RunCharDataPageInputLoop ; $40a3
	ld hl, rIE ; $40a6
	set B_IE_TIMER, [hl] ; $40a9
	script_fade_out 16 ; $40ab
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
InitCharDataWorkRam:
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
	ld [wCharDataStatDeltas + CHARSTAT_TOP], a ; $40fc
	ld [wCharDataStatDeltas + CHARSTAT_SLICE], a ; $40ff
	ld [wCharDataStatDeltas + CHARSTAT_SERVE], a ; $4102
	ld [wCharDataStatDeltas + CHARSTAT_STROKE], a ; $4105
	ld [wCharDataStatDeltas + CHARSTAT_VOLLEY], a ; $4108
	ld [wCharDataStatDeltas + CHARSTAT_ANGLE], a ; $410b
	ld [wCharDataStatDeltas + CHARSTAT_PLACEMENT], a ; $410e
	ld [wCharDataStatDeltas + CHARSTAT_SPEED], a ; $4111
	ld [wCharDataStatDeltas + CHARSTAT_DASH], a ; $4114
	ld [wCharDataStatDeltas + CHARSTAT_REACTION], a ; $4117
	ld [wCharDataStatDeltas + CHARSTAT_STOP], a ; $411a
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
	ld hl, CharDataAttrClearPatch_1d ; $4149
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH + 16 ; $414c
	call ApplyTilemapPatchList ; $414f
	wram_bank WRAM_SCREEN ; $4152
	ld hl, wShadowTilemap ; $4158
	ld de, vBGMap0 ; $415b
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $415e
	call QueueVRAMCopy ; $4160
	wram_bank WRAM_COURT_PLANES ; $4163
	ld hl, wScreenAttrmap ; $4169
	ld de, vBGMap0 + VRAM_BANK1 ; $416c
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $416f
	call QueueVRAMCopy ; $4171
	ret ; $4174
LoadCharDataScreenPageGraphics:
	wram_bank WRAM_STAGING ; $4175
	ld hl, CharDataScreenPageGfx14 ; $417b
	ld de, wDecompBuffer ; $417e
	call DecompressData ; $4181
	ld hl, wDecompBuffer ; $4184
	ld de, vTiles0 tile $14 + VRAM_BANK1 ; $4187
	ld c, CharDataScreenPageGfx14_SIZE / 16 ; $418a
	call QueueVRAMCopy ; $418c
	wram_bank WRAM_STAGING ; $418f
	ld hl, CharDataScreenPageGraphicsGfx0 ; $4195
	ld de, wDecompBuffer ; $4198
	call DecompressData ; $419b
	ld hl, wDecompBuffer ; $419e
	ld de, vTiles0 tile $1e + VRAM_BANK1 ; $41a1
	ld c, CharDataScreenPageGraphicsGfx0_SIZE / 16 ; $41a4
	call QueueVRAMCopy ; $41a6
	wram_bank WRAM_STAGING ; $41a9
	ld hl, CharDataScreenPageGraphicsGfx1 ; $41af
	ld de, wDecompBuffer ; $41b2
	call DecompressData ; $41b5
	ld hl, wDecompBuffer ; $41b8
	ld de, vTiles0 tile $28 + VRAM_BANK1 ; $41bb
	ld c, CharDataScreenPageGraphicsGfx1_SIZE / 16 ; $41be
	call QueueVRAMCopy ; $41c0
	wram_bank WRAM_STAGING ; $41c3
	ld hl, CharDataScreenPageGraphicsGfx2 ; $41c9
	ld de, wDecompBuffer ; $41cc
	call DecompressData ; $41cf
	ld hl, wDecompBuffer ; $41d2
	ld de, vTiles0 tile $30 + VRAM_BANK1 ; $41d5
	ld c, CharDataScreenPageGraphicsGfx2_SIZE / 16 ; $41d8
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
	ld de, vTiles0 tile $38 + VRAM_BANK1 ; $430f
	ld c, CharDataScreenPageGfx10_SIZE / 16 ; $4312
	call QueueVRAMCopy ; $4314
	ld hl, CharDataScreenPageGfx13 ; $4317
	ld de, wDecompBuffer ; $431a
	call DecompressData ; $431d
	ld hl, wDecompBuffer ; $4320
	ld de, vTiles0 tile $4c + VRAM_BANK1 ; $4323
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
	ld_story_char_field CHARREC_PALETTE ; $4360
	pop af ; $4373
	ld a, [hl] ; $4374
	ld_bg_pals de, 4, 1 ; $4375
	farcall LoadIndexedPaletteThunk ; $4378
	wram_bank WRAM_STAGING ; $437b
	push af ; $4381
	ld_story_char_field CHARREC_CHAR ; $4382
	pop af ; $4395
	ld a, [hl] ; $4396
	ld de, wDecompBuffer ; $4397
	farcall DecompressCharMugshot ; $439a
	ld hl, wDecompBuffer ; $439d
	ld de, vTiles2 tile $20 + VRAM_BANK1 ; $43a0
	ld c, 3 ; $43a3
	call QueueVRAMCopy ; $43a5
	ld hl, wDecompBuffer tile 3 ; $43a8
	ld de, vTiles2 tile $30 + VRAM_BANK1 ; $43ab
	ld c, 3 ; $43ae
	call QueueVRAMCopy ; $43b0
	ld hl, wDecompBuffer tile 6 ; $43b3
	ld de, vTiles2 tile $40 + VRAM_BANK1 ; $43b6
	ld c, 3 ; $43b9
	call QueueVRAMCopy ; $43bb
	ld a, $01 ; $43be
	ld [wStoryCharacterSlot], a ; $43c0
	push af ; $43c3
	ld_story_char_field CHARREC_PALETTE ; $43c4
	pop af ; $43d7
	ld a, [hl] ; $43d8
	ld_bg_pals de, 1, 1 ; $43d9
	farcall LoadIndexedPaletteThunk ; $43dc
	wram_bank WRAM_STAGING ; $43df
	push af ; $43e5
	ld_story_char_field CHARREC_CHAR ; $43e6
	pop af ; $43f9
	ld a, [hl] ; $43fa
	ld de, wDecompBuffer ; $43fb
	farcall DecompressCharMugshot ; $43fe
	ld hl, wDecompBuffer ; $4401
	ld de, vTiles2 tile $23 + VRAM_BANK1 ; $4404
	ld c, 3 ; $4407
	call QueueVRAMCopy ; $4409
	ld hl, wDecompBuffer tile 3 ; $440c
	ld de, vTiles2 tile $33 + VRAM_BANK1 ; $440f
	ld c, 3 ; $4412
	call QueueVRAMCopy ; $4414
	ld hl, wDecompBuffer tile 6 ; $4417
	ld de, vTiles2 tile $43 + VRAM_BANK1 ; $441a
	ld c, 3 ; $441d
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
	ld_story_char_field CHARREC_NAME ; $4452
	pop af ; $4465
	ld de, wCharDataScreenCell + 30 * TILEMAP_WIDTH + 11 ; $4466
	ld c, $0a ; $4469
	call WriteNameStringTiles ; $446b
	ld hl, CharDataSummaryFieldsTilePlot0 ; $446e
	ld de, wCharDataScreenCell + 30 * TILEMAP_WIDTH ; $4471
	ld b, $0c ; $4474
	call PlotTilesAtOffsets ; $4476
	push af ; $4479
	ld_story_char_field CHARREC_LEFT_HANDED ; $447a
	pop af ; $448d
	ld a, [hl] ; $448e
	ld hl, wCharDataScreenCell + 31 * TILEMAP_WIDTH + 3 ; $448f
	call DrawFourTileFlagLabel ; $4492
	wram_bank WRAM_SCENE ; $4495
	push af ; $449b
	ld_story_char_field CHARREC_LEVEL ; $449c
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
	ld_story_char_field CHARREC_TRAIN_LEVELS + TRAINSTAT_SPIN ; $44c9
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
	ld_story_char_field CHARREC_TRAIN_LEVELS + TRAINSTAT_POWER ; $44f6
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
	ld_story_char_field CHARREC_TRAIN_LEVELS + TRAINSTAT_CONTROL ; $4523
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
	ld_story_char_field CHARREC_TRAIN_LEVELS + TRAINSTAT_SPEED ; $4550
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
	ld_story_char_field CHARREC_EXP ; $45a6
	pop af ; $45b9
	call FormatExp24BitDecimal ; $45ba
	ld hl, wCharDataNumberBuffer ; $45bd
	ld de, wCharStatPageMain + 4 ; $45c0
	ld a, [hl] ; $45c3
	or a ; $45c4
	jr nz, .capMainExp ; $45c5
	ld bc, wCharDataNumberBuffer_SIZE ; $45c7
	call CopyMemoryBC ; $45ca
	jr .storeStoryCharacterSlot ; $45cd
.capMainExp:
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
	ld_story_char_field CHARREC_NAME ; $45e1
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
	ld_story_char_field CHARREC_LEFT_HANDED ; $460f
	pop af ; $4622
	ld a, [hl] ; $4623
	ld hl, wCharDataPagePlane + 3 * TILEMAP_WIDTH + 19 ; $4624
	call DrawFourTileFlagLabel ; $4627
	wram_bank WRAM_SCENE ; $462a
	push af ; $4630
	ld_story_char_field CHARREC_LEVEL ; $4631
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
	ld_story_char_field CHARREC_TRAIN_LEVELS + TRAINSTAT_SPIN ; $465e
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
	ld_story_char_field CHARREC_TRAIN_LEVELS + TRAINSTAT_POWER ; $468b
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
	ld_story_char_field CHARREC_TRAIN_LEVELS + TRAINSTAT_CONTROL ; $46b8
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
	ld_story_char_field CHARREC_TRAIN_LEVELS + TRAINSTAT_SPEED ; $46e5
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
	ld_story_char_field CHARREC_EXP ; $473c
	pop af ; $474f
	call FormatExp24BitDecimal ; $4750
	ld hl, wCharDataNumberBuffer ; $4753
	ld de, wCharStatPagePartner + 4 ; $4756
	ld a, [hl] ; $4759
	or a ; $475a
	jr nz, .capPartnerExp ; $475b
	ld bc, wCharDataNumberBuffer_SIZE ; $475d
	call CopyMemoryBC ; $4760
	ret ; $4763
.capPartnerExp:
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
