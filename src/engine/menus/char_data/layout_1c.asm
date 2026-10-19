	twin draw_confirm_selection_cursor, 1c ; $53a3 DrawConfirmSelectionCursor_1c
MoveCharDataScreenSelection:
	wram_bank WRAM_SCENE ; $53c3
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
	wram_bank WRAM_SCENE ; $5404
	ld a, [wCharDataChoiceCount] ; $540a
	or a ; $540d
	ret z ; $540e
	sound SFX_MENU_CANCEL ; $540f
	ld hl, wCharDataPointsLeft ; $5411
	inc [hl] ; $5414
	push af ; $5415
	ld hl, wStoryMainName ; $5416
	ld a, [wStoryCharacterSlot] ; $5419
	or a ; $541c
	jr z, .levelField ; $541d
	ld l, $40 ; $541f
.levelField:
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
	ld hl, wStoryMainName ; $542f
	ld a, [wStoryCharacterSlot] ; $5432
	or a ; $5435
	jr z, .spinLevelField ; $5436
	ld l, $40 ; $5438
.spinLevelField:
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
	ld hl, wStoryMainName ; $544b
	ld a, [wStoryCharacterSlot] ; $544e
	or a ; $5451
	jr z, .powerLevelField ; $5452
	ld l, $40 ; $5454
.powerLevelField:
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
	ld hl, wStoryMainName ; $5467
	ld a, [wStoryCharacterSlot] ; $546a
	or a ; $546d
	jr z, .controlLevelField ; $546e
	ld l, $40 ; $5470
.controlLevelField:
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
	ld hl, wStoryMainName ; $5483
	ld a, [wStoryCharacterSlot] ; $5486
	or a ; $5489
	jr z, .speedLevelField ; $548a
	ld l, $40 ; $548c
.speedLevelField:
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
	wram_bank WRAM_SCENE ; $54e3
	ld a, $04 ; $54e9
	ld [wCharDataPage], a ; $54eb
	call WriteCharStatsToDisplayBuffer ; $54ee
	ret ; $54f1
DrawStatArrowIndicators:
	wram_bank WRAM_SCENE ; $54f2
	ld a, [wCharDataStatDeltas] ; $54f8
	ld_xy de, $4c, $24 ; $54fb
	call QueueStatChangeArrow ; $54fe
	ld a, [wCharDataStatDeltas + 1] ; $5501
	ld_xy de, $4c, $34 ; $5504
	call QueueStatChangeArrow ; $5507
	ld a, [wCharDataStatDeltas + 2] ; $550a
	ld_xy de, $4c, $4c ; $550d
	call QueueStatChangeArrow ; $5510
	ld a, [wCharDataStatDeltas + 3] ; $5513
	ld_xy de, $4c, $5c ; $5516
	call QueueStatChangeArrow ; $5519
	ld a, [wCharDataStatDeltas + 4] ; $551c
	ld_xy de, $4c, $6c ; $551f
	call QueueStatChangeArrow ; $5522
	ld a, [wCharDataStatDeltas + 5] ; $5525
	ld_xy de, $9c, $24 ; $5528
	call QueueStatChangeArrow ; $552b
	ld a, [wCharDataStatDeltas + 6] ; $552e
	ld_xy de, $9c, $34 ; $5531
	call QueueStatChangeArrow ; $5534
	ld a, [wCharDataStatDeltas + 7] ; $5537
	ld_xy de, $9c, $4c ; $553a
	call QueueStatChangeArrow ; $553d
	ld a, [wCharDataStatDeltas + 8] ; $5540
	ld_xy de, $9c, $5c ; $5543
	call QueueStatChangeArrow ; $5546
	ld a, [wCharDataStatDeltas + 9] ; $5549
	ld_xy de, $9c, $6c ; $554c
	call QueueStatChangeArrow ; $554f
	ld a, [wCharDataStatDeltas + 10] ; $5552
	ld_xy de, $9c, $7c ; $5555
	call QueueStatChangeArrow ; $5558
	ret ; $555b
QueueStatChangeArrow:
	or a ; $555c
	ret z ; $555d
	bit 7, a ; $555e
	jr nz, .arrowDown ; $5560
	sprite_attr_tile OAM_BANK1 | 6, $d0 ; $5562
	call QueueSprite ; $5566
	ret ; $5569
.arrowDown:
	sprite_attr_tile OAM_BANK1 | 7, $d2 ; $556a
	call QueueSprite ; $556e
	ret ; $5571
SetupCharDataScreen:
	sound BGM_STAT_DISTRIBUTION ; $5572
	call BackupCharDataScreenRow ; $5574
	ld hl, CharDataBand0RunsStep7_1c ; $5577
	ld bc, wCharDataScreenCell + 18 * TILEMAP_WIDTH ; $557a
	call BlitTilemapRunsFromTable ; $557d
	ld hl, CharDataBand1RunsStep6_1c ; $5580
	ld bc, wCharDataScreenCell + 20 * TILEMAP_WIDTH ; $5583
	call BlitTilemapRunsFromTable ; $5586
	ld hl, CharDataBand2RunsStep6_1c ; $5589
	ld bc, wCharDataScreenCell + 22 * TILEMAP_WIDTH + 16 ; $558c
	call BlitTilemapRunsFromTable ; $558f
	ld hl, CharDataBand3RunsStep7_1c ; $5592
	ld bc, wCharDataScreenCell + 24 * TILEMAP_WIDTH + 16 ; $5595
	call BlitTilemapRunsFromTable ; $5598
	ld hl, CharDataBand4RunsStep3_1c ; $559b
	ld bc, wCharDataScreenCell + 27 * TILEMAP_WIDTH + 16 ; $559e
	call BlitTilemapRunsFromTable ; $55a1
	wram_bank WRAM_SCENE ; $55a4
	xor a ; $55aa
	ld [wCharDataRevealTimer], a ; $55ab
	wram_bank WRAM_SCREEN ; $55ae
	ld hl, wCharDataScreenCell ; $55b4
	ld de, vBGMap0 ; $55b7
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $55ba
	call QueueVRAMCopy ; $55bc
	wram_bank WRAM_COURT_PLANES ; $55bf
	ld hl, wCharDataScreenCell ; $55c5
	ld de, vBGMap0 + VRAM_BANK1 ; $55c8
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $55cb
	call QueueVRAMCopy ; $55cd
	wram_bank WRAM_SCENE ; $55d0
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
	script_fade_in 16 ; $55f1
	call WaitFadeEnd ; $55f6
	ld a, $01 ; $55f9
	ld hl, CharDataScreenAnimTask ; $55fb
	call RegisterFrameTask ; $55fe
	call RestoreCharDataScreenRow ; $5601
	call DrawCharStatRows ; $5604
	ld hl, CharDataBand8RunsStep1_1c ; $5607
	ld bc, wCharDataScreenCell + 32 * TILEMAP_WIDTH + 16 ; $560a
	call BlitTilemapRunsFromTable ; $560d
	call FlushCharDataTilemaps ; $5610
	call RestoreCharDataScreenRow ; $5613
	call DrawCharStatRows ; $5616
	ld hl, CharDataBand7RunsStep1_1c ; $5619
	ld bc, wCharDataScreenCell + 31 * TILEMAP_WIDTH ; $561c
	call BlitTilemapRunsFromTable ; $561f
	ld hl, CharDataBand8RunsStep2_1c ; $5622
	ld bc, wCharDataScreenCell + 32 * TILEMAP_WIDTH + 16 ; $5625
	call BlitTilemapRunsFromTable ; $5628
	call FlushCharDataTilemaps ; $562b
	call RestoreCharDataScreenRow ; $562e
	call DrawCharStatRows ; $5631
	ld hl, CharDataBand7RunsStep2_1c ; $5634
	ld bc, wCharDataScreenCell + 31 * TILEMAP_WIDTH ; $5637
	call BlitTilemapRunsFromTable ; $563a
	ld hl, CharDataBand8RunsStep3_1c ; $563d
	ld bc, wCharDataScreenCell + 32 * TILEMAP_WIDTH + 16 ; $5640
	call BlitTilemapRunsFromTable ; $5643
	call FlushCharDataTilemaps ; $5646
	call RestoreCharDataScreenRow ; $5649
	call DrawCharStatRows ; $564c
	ld hl, CharDataBand7RunsStep3_1c ; $564f
	ld bc, wCharDataScreenCell + 31 * TILEMAP_WIDTH ; $5652
	call BlitTilemapRunsFromTable ; $5655
	ld hl, CharDataBand8RunsStep4_1c ; $5658
	ld bc, wCharDataScreenCell + 32 * TILEMAP_WIDTH + 16 ; $565b
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
	; $5699, 32 bytes (records:2)
	dw UnusedShiftGfx16 ; record 0
	dw UnusedShiftGfx17 ; record 1
	dw UnusedShiftGfx18 ; record 2
	dw UnusedShiftGfx19 ; record 3
	dw UnusedShiftGfx20 ; record 4
	dw UnusedShiftGfx21 ; record 5
	dw UnusedShiftGfx22 ; record 6
	dw UnusedShiftGfx23 ; record 7
	dw UnusedShiftGfx24 ; record 8
	dw UnusedShiftGfx25 ; record 9
	dw UnusedShiftGfx26 ; record 10
	dw UnusedShiftGfx27 ; record 11
	dw UnusedShiftGfx28 ; record 12
	dw UnusedShiftGfx29 ; record 13
	dw UnusedShiftGfx30 ; record 14
	dw UnusedShiftGfx31 ; record 15
CharDataBand0RunsStep7_1c:
	; $56b9, 22 bytes (blit_runs)
	blit_run 0, 3, 0, 10
	blit_run 0, 4, 10, 10
	blit_run 0, 5, 20, 10
	blit_run 0, 6, 30, 10
	blit_run 0, 7, 40, 10
	db $ff, $ff
CharDataBand0RunsStep6_1c:
	; $56cf, 21 bytes (blit_runs)
	blit_run 0, 2, 1, 9
	blit_run 0, 3, 11, 9
	blit_run 0, 4, 21, 9
	blit_run 0, 5, 31, 9
	blit_run 0, 6, 41, 9
	db $ff
CharDataBand0RunsStep5_1c:
	; $56e4, 21 bytes (blit_runs)
	blit_run 0, 1, 2, 8
	blit_run 0, 2, 12, 8
	blit_run 0, 3, 22, 8
	blit_run 0, 4, 32, 8
	blit_run 0, 5, 42, 8
	db $ff
CharDataBand0RunsStep4_1c:
	; $56f9, 21 bytes (blit_runs)
	blit_run 0, 0, 3, 7
	blit_run 0, 1, 13, 7
	blit_run 0, 2, 23, 7
	blit_run 0, 3, 33, 7
	blit_run 0, 4, 43, 7
	db $ff
CharDataBand0RunsStep3_1c:
	; $570e, 13 bytes (blit_runs)
	blit_run 0, 0, 25, 5
	blit_run 0, 1, 35, 5
	blit_run 0, 2, 45, 5
	db $ff
CharDataBand0RunsStep2_1c:
	; $571b, 5 bytes (blit_runs)
	blit_run 0, 0, 47, 3
	db $ff
CharDataBand1RunsStep6_1c:
	; $5720, 29 bytes (blit_runs)
	blit_run 0, 8, 0, 10
	blit_run 0, 9, 10, 10
	blit_run 0, 10, 20, 10
	blit_run 0, 11, 30, 10
	blit_run 0, 12, 40, 10
	blit_run 0, 13, 50, 10
	blit_run 0, 14, 60, 10
	db $ff
CharDataBand1RunsStep5_1c:
	; $573d, 29 bytes (blit_runs)
	blit_run 0, 9, 1, 9
	blit_run 0, 10, 11, 9
	blit_run 0, 11, 21, 9
	blit_run 0, 12, 31, 9
	blit_run 0, 13, 41, 9
	blit_run 0, 14, 51, 9
	blit_run 0, 15, 61, 9
	db $ff
CharDataBand1RunsStep4_1c:
	; $575a, 29 bytes (blit_runs)
	blit_run 0, 10, 2, 8
	blit_run 0, 11, 12, 8
	blit_run 0, 12, 22, 8
	blit_run 0, 13, 32, 8
	blit_run 0, 14, 42, 8
	blit_run 0, 15, 52, 8
	blit_run 0, 16, 62, 8
	db $ff
CharDataBand1RunsStep3_1c:
	; $5777, 29 bytes (blit_runs)
	blit_run 0, 11, 3, 7
	blit_run 0, 12, 13, 7
	blit_run 0, 13, 23, 7
	blit_run 0, 14, 33, 7
	blit_run 0, 15, 43, 7
	blit_run 0, 16, 53, 7
	blit_run 0, 17, 63, 7
	db $ff
CharDataBand1RunsStep2_1c:
	; $5794, 21 bytes (blit_runs)
	blit_run 0, 13, 5, 5
	blit_run 0, 14, 15, 5
	blit_run 0, 15, 25, 5
	blit_run 0, 16, 35, 5
	blit_run 0, 17, 45, 5
	db $ff
CharDataBand1RunsStep1_1c:
	; $57a9, 13 bytes (blit_runs)
	blit_run 0, 15, 7, 3
	blit_run 0, 16, 17, 3
	blit_run 0, 17, 27, 3
	db $ff
CharDataBand0RunsStep1_1c:
	; $57b6, 5 bytes (blit_runs)
	blit_run 0, 17, 9, 1
	db $ff
CharDataBand2RunsStep6_1c:
	; $57bb, 21 bytes (blit_runs)
	blit_run 10, 3, 0, 10
	blit_run 10, 4, 10, 10
	blit_run 10, 5, 20, 10
	blit_run 10, 6, 30, 10
	blit_run 10, 7, 40, 10
	db $ff
CharDataBand2RunsStep5_1c:
	; $57d0, 21 bytes (blit_runs)
	blit_run 11, 2, 0, 9
	blit_run 11, 3, 10, 9
	blit_run 11, 4, 20, 9
	blit_run 11, 5, 30, 9
	blit_run 11, 6, 40, 9
	db $ff
CharDataBand2RunsStep4_1c:
	; $57e5, 21 bytes (blit_runs)
	blit_run 12, 1, 0, 8
	blit_run 12, 2, 10, 8
	blit_run 12, 3, 20, 8
	blit_run 12, 4, 30, 8
	blit_run 12, 5, 40, 8
	db $ff
CharDataBand2RunsStep3_1c:
	; $57fa, 21 bytes (blit_runs)
	blit_run 13, 0, 0, 7
	blit_run 13, 1, 10, 7
	blit_run 13, 2, 20, 7
	blit_run 13, 3, 30, 7
	blit_run 13, 4, 40, 7
	db $ff
CharDataBand2RunsStep2_1c:
	; $580f, 13 bytes (blit_runs)
	blit_run 15, 0, 20, 5
	blit_run 15, 1, 30, 5
	blit_run 15, 2, 40, 5
	db $ff
CharDataBand2RunsStep1_1c:
	; $581c, 5 bytes (blit_runs)
	blit_run 17, 0, 40, 3
	db $ff
CharDataBand3RunsStep7_1c:
	; $5821, 37 bytes (blit_runs)
	blit_run 10, 8, 0, 10
	blit_run 10, 9, 10, 10
	blit_run 10, 10, 20, 10
	blit_run 10, 11, 30, 10
	blit_run 10, 12, 40, 10
	blit_run 10, 13, 50, 10
	blit_run 10, 14, 60, 10
	blit_run 10, 15, 70, 10
	blit_run 10, 16, 80, 10
	db $ff
CharDataBand3RunsStep6_1c:
	; $5846, 37 bytes (blit_runs)
	blit_run 11, 9, 0, 9
	blit_run 11, 10, 10, 9
	blit_run 11, 11, 20, 9
	blit_run 11, 12, 30, 9
	blit_run 11, 13, 40, 9
	blit_run 11, 14, 50, 9
	blit_run 11, 15, 60, 9
	blit_run 11, 16, 70, 9
	blit_run 11, 17, 80, 9
	db $ff
CharDataBand3RunsStep5_1c:
	; $586b, 33 bytes (blit_runs)
	blit_run 12, 10, 0, 8
	blit_run 12, 11, 10, 8
	blit_run 12, 12, 20, 8
	blit_run 12, 13, 30, 8
	blit_run 12, 14, 40, 8
	blit_run 12, 15, 50, 8
	blit_run 12, 16, 60, 8
	blit_run 12, 17, 70, 8
	db $ff
CharDataBand3RunsStep4_1c:
	; $588c, 29 bytes (blit_runs)
	blit_run 13, 11, 0, 7
	blit_run 13, 12, 10, 7
	blit_run 13, 13, 20, 7
	blit_run 13, 14, 30, 7
	blit_run 13, 15, 40, 7
	blit_run 13, 16, 50, 7
	blit_run 13, 17, 60, 7
	db $ff
CharDataBand3RunsStep3_1c:
	; $58a9, 21 bytes (blit_runs)
	blit_run 15, 13, 0, 5
	blit_run 15, 14, 10, 5
	blit_run 15, 15, 20, 5
	blit_run 15, 16, 30, 5
	blit_run 15, 17, 40, 5
	db $ff
CharDataBand3RunsStep2_1c:
	; $58be, 13 bytes (blit_runs)
	blit_run 17, 15, 0, 4
	blit_run 17, 16, 10, 4
	blit_run 17, 17, 20, 4
	db $ff
CharDataBand3RunsStep1_1c:
	; $58cb, 5 bytes (blit_runs)
	blit_run 19, 17, 0, 2
	db $ff
CharDataBand4RunsStep3_1c:
	; $58d0, 13 bytes (blit_runs)
	blit_run 0, 0, 0, 3
	blit_run 0, 1, 3, 3
	blit_run 0, 2, 6, 3
	db $ff
CharDataBand4RunsStep2_1c:
	; $58dd, 13 bytes (blit_runs)
	blit_run 0, 0, 1, 2
	blit_run 0, 1, 4, 2
	blit_run 0, 2, 7, 2
	db $ff
CharDataBand4RunsStep1_1c:
	; $58ea, 13 bytes (blit_runs)
	blit_run 0, 0, 2, 1
	blit_run 0, 1, 5, 1
	blit_run 0, 2, 8, 1
	db $ff
CharDataBand6RunsStep3_1c:
	; $58f7, 13 bytes (blit_runs)
	blit_run 3, 0, 0, 17
	blit_run 3, 1, 17, 17
	blit_run 3, 2, 34, 17
	db $ff
CharDataBand6RunsStep2_1c:
	; $5904, 9 bytes (blit_runs)
	blit_run 3, 0, 17, 17
	blit_run 3, 1, 34, 17
	db $ff
CharDataBand6RunsStep1_1c:
	; $590d, 5 bytes (blit_runs)
	blit_run 3, 0, 34, 17
	db $ff
CharDataBand5RunsStep3_1c:
	; $5912, 13 bytes (blit_runs)
	blit_run 0, 15, 0, 10
	blit_run 0, 16, 10, 10
	blit_run 0, 17, 20, 10
	db $ff
CharDataBand5RunsStep2_1c:
	; $591f, 9 bytes (blit_runs)
	blit_run 0, 16, 0, 10
	blit_run 0, 17, 10, 10
	db $ff
CharDataBand5RunsStep1_1c:
	; $5928, 5 bytes (blit_runs)
	blit_run 0, 17, 0, 10
	db $ff
CharDataBand7RunsStep3_1c:
	; $592d, 13 bytes (blit_runs)
	blit_run 3, 0, 0, 11
	blit_run 3, 1, 11, 11
	blit_run 3, 2, 22, 11
	db $ff
CharDataBand7RunsStep2_1c:
	; $593a, 9 bytes (blit_runs)
	blit_run 3, 0, 11, 11
	blit_run 3, 1, 22, 11
	db $ff
CharDataBand7RunsStep1_1c:
	; $5943, 5 bytes (blit_runs)
	blit_run 3, 0, 22, 11
	db $ff
CharDataBand8RunsStep4_1c:
	; $5948, 17 bytes (blit_runs)
	blit_run 14, 0, 0, 6
	blit_run 14, 1, 6, 6
	blit_run 14, 2, 12, 6
	blit_run 14, 3, 18, 6
	db $ff
CharDataBand8RunsStep3_1c:
	; $5959, 17 bytes (blit_runs)
	blit_run 16, 0, 0, 4
	blit_run 16, 1, 6, 4
	blit_run 16, 2, 12, 4
	blit_run 16, 3, 18, 4
	db $ff
CharDataBand8RunsStep2_1c:
	; $596a, 17 bytes (blit_runs)
	blit_run 18, 0, 0, 3
	blit_run 18, 1, 6, 3
	blit_run 18, 2, 12, 3
	blit_run 18, 3, 18, 3
	db $ff
CharDataBand8RunsStep1_1c:
	; $597b, 17 bytes (blit_runs)
	blit_run 20, 0, 0, 1
	blit_run 20, 1, 6, 1
	blit_run 20, 2, 12, 1
	blit_run 20, 3, 18, 1
	db $ff
CharDataScreen_LoadScreenPalette:
	INCLUDE "data/engine/menus/char_data/CharDataScreen_LoadScreenPalette.asm" ; $598c, 64 bytes (palettes)
CharDataScreenGfx0_1c:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenGfx0_1c.bin" ; $59cc, 2618 bytes
CharDataScreenTilemap_1c:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenTilemap_1c.bin" ; $6406, 99 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenTilemap_1c.inc" ; DEF CharDataScreenTilemap_1c_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenAttrmap_1c:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenAttrmap_1c.bin" ; $6469, 59 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenAttrmap_1c.inc" ; DEF CharDataScreenAttrmap_1c_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenStatBar00:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar00.bin" ; $64a4, 5 bytes
CharDataScreenStatBar01:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar01.bin" ; $64a9, 5 bytes
CharDataScreenStatBar02:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar02.bin" ; $64ae, 5 bytes
CharDataScreenStatBar03:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar03.bin" ; $64b3, 5 bytes
CharDataScreenStatBar04:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar04.bin" ; $64b8, 5 bytes
CharDataScreenStatBar05:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar05.bin" ; $64bd, 5 bytes
CharDataScreenStatBar06:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar06.bin" ; $64c2, 5 bytes
CharDataScreenStatBar07:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar07.bin" ; $64c7, 5 bytes
CharDataScreenStatBar08:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar08.bin" ; $64cc, 5 bytes
CharDataScreenStatBar09:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar09.bin" ; $64d1, 5 bytes
CharDataScreenStatBar10:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar10.bin" ; $64d6, 5 bytes
CharDataScreenStatBar11:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar11.bin" ; $64db, 5 bytes
CharDataScreenStatBar12:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar12.bin" ; $64e0, 5 bytes
CharDataScreenStatBar13:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar13.bin" ; $64e5, 5 bytes
CharDataScreenStatBar14:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar14.bin" ; $64ea, 5 bytes
CharDataScreenStatBar15:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar15.bin" ; $64ef, 5 bytes
CharDataScreenStatBar16:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar16.bin" ; $64f4, 5 bytes
CharDataScreenStatBar17:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar17.bin" ; $64f9, 5 bytes
CharDataScreenStatBar18:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar18.bin" ; $64fe, 5 bytes
CharDataScreenStatBar19:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar19.bin" ; $6503, 5 bytes
CharDataScreenStatBar20:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar20.bin" ; $6508, 5 bytes
CharDataScreenStatBar21:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar21.bin" ; $650d, 5 bytes
CharDataScreenStatBar22:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar22.bin" ; $6512, 5 bytes
CharDataScreenStatBar23:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar23.bin" ; $6517, 5 bytes
CharDataScreenStatBar24:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar24.bin" ; $651c, 5 bytes
CharDataScreenStatBar25:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar25.bin" ; $6521, 5 bytes
CharDataScreenStatBar26:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar26.bin" ; $6526, 5 bytes
CharDataScreenStatBar27:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar27.bin" ; $652b, 5 bytes
CharDataScreenStatBar28:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar28.bin" ; $6530, 5 bytes
CharDataScreenStatBar29:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar29.bin" ; $6535, 5 bytes
CharDataScreenStatBar30:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar30.bin" ; $653a, 5 bytes
CharDataScreenStatBar31:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar31.bin" ; $653f, 5 bytes
CharDataScreenStatBar32:
	INCBIN "data/engine/menus/char_data/CharDataScreenStatBar32.bin" ; $6544, 5 bytes
CharDataScreenBand1Tilemap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand1Tilemap.bin" ; $6549, 54 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand1Tilemap.inc" ; DEF CharDataScreenBand1Tilemap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenBand1Attrmap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand1Attrmap.bin" ; $657f, 23 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand1Attrmap.inc" ; DEF CharDataScreenBand1Attrmap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenPage0Columns:
	INCBIN "data/engine/menus/char_data/CharDataScreenPage0Columns.bin" ; $6596, 50 bytes
CharDataScreenBand2Tilemap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand2Tilemap.bin" ; $65c8, 67 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand2Tilemap.inc" ; DEF CharDataScreenBand2Tilemap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenBand2Attrmap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand2Attrmap.bin" ; $660b, 23 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand2Attrmap.inc" ; DEF CharDataScreenBand2Attrmap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenPage1Columns:
	INCBIN "data/engine/menus/char_data/CharDataScreenPage1Columns.bin" ; $6622, 70 bytes
CharDataScreenBand3Tilemap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand3Tilemap.bin" ; $6668, 58 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand3Tilemap.inc" ; DEF CharDataScreenBand3Tilemap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenBand3Attrmap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand3Attrmap.bin" ; $66a2, 24 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand3Attrmap.inc" ; DEF CharDataScreenBand3Attrmap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenPage2Columns:
	INCBIN "data/engine/menus/char_data/CharDataScreenPage2Columns.bin" ; $66ba, 50 bytes
CharDataScreenBand4Tilemap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand4Tilemap.bin" ; $66ec, 72 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand4Tilemap.inc" ; DEF CharDataScreenBand4Tilemap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenBand4Attrmap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand4Attrmap.bin" ; $6734, 25 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand4Attrmap.inc" ; DEF CharDataScreenBand4Attrmap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenPage3Columns:
	INCBIN "data/engine/menus/char_data/CharDataScreenPage3Columns.bin" ; $674d, 90 bytes
CharDataScreenPage4Columns:
	INCBIN "data/engine/menus/char_data/CharDataScreenPage4Columns.bin" ; $67a7, 30 bytes
CharDataScreenBand5Tilemap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand5Tilemap.bin" ; $67c5, 14 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand5Tilemap.inc" ; DEF CharDataScreenBand5Tilemap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenBand5Attrmap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand5Attrmap.bin" ; $67d3, 7 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand5Attrmap.inc" ; DEF CharDataScreenBand5Attrmap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenUIPatch0Tilemap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenUIPatch0Tilemap.bin" ; $67da, 24 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenUIPatch0Tilemap.inc" ; DEF CharDataScreenUIPatch0Tilemap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenUIPatch0Attrmap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenUIPatch0Attrmap.bin" ; $67f2, 12 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenUIPatch0Attrmap.inc" ; DEF CharDataScreenUIPatch0Attrmap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenUIPatch1Tilemap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenUIPatch1Tilemap.bin" ; $67fe, 39 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenUIPatch1Tilemap.inc" ; DEF CharDataScreenUIPatch1Tilemap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenUIPatch1Attrmap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenUIPatch1Attrmap.bin" ; $6825, 9 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenUIPatch1Attrmap.inc" ; DEF CharDataScreenUIPatch1Attrmap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenUIPatch2Tilemap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenUIPatch2Tilemap.bin" ; $682e, 26 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenUIPatch2Tilemap.inc" ; DEF CharDataScreenUIPatch2Tilemap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenUIPatch2Attrmap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenUIPatch2Attrmap.bin" ; $6848, 7 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenUIPatch2Attrmap.inc" ; DEF CharDataScreenUIPatch2Attrmap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenUIPatch3Tilemap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenUIPatch3Tilemap.bin" ; $684f, 28 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenUIPatch3Tilemap.inc" ; DEF CharDataScreenUIPatch3Tilemap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenUIPatch3Attrmap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenUIPatch3Attrmap.bin" ; $686b, 7 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenUIPatch3Attrmap.inc" ; DEF CharDataScreenUIPatch3Attrmap_SIZE EQU its decoded length, generated from the .bin by make
	; $6872, 14 bytes (fill)
	ds 14, $00
