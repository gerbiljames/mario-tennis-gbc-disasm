	twin draw_confirm_selection_cursor, 1c ; $53a3 DrawConfirmSelectionCursor_1c
MoveCharDataScreenSelection:
	wram_bank WRAM_SCENE ; $53c3
	ld a, [wCharDataPage] ; $53c9
	add_hl_a ; $53cc
	ld a, [hl] ; $53d1
	cp $ff ; $53d2
	ret z ; $53d4
	ld [wCharDataPage], a ; $53d5
	sound SFX_MENU_MOVE ; $53d8
	cp CHARDATAPAGE_CONFIRM ; $53da
	jr z, .redraw ; $53dc
	call RestoreCharDataScreen ; $53de
	call LoadCharStatsWithLevelUpDeltas ; $53e1
	call CharDataScreen_DrawStats ; $53e4
	call DrawCharStatsAndFlush ; $53e7
	call CharDataScreen_DrawPageColumns ; $53ea
	call FlushCharDataTilemaps ; $53ed
	ret ; $53f0
.redraw:
	call RestoreCharDataScreen ; $53f1
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
	ld_story_char_field CHARREC_LEVEL ; $5416
	pop af ; $5429
	ld a, [wCharDataLevel] ; $542a
	ld [hl], a ; $542d
	push af ; $542e
	ld_story_char_field CHARREC_TRAIN_LEVELS + TRAINSTAT_SPIN ; $542f
	pop af ; $5442
	ld a, [wCharDataNewLevels + TRAINSTAT_SPIN] ; $5443
	ld [hl], a ; $5446
	ld [wCharDataLevels + TRAINSTAT_SPIN], a ; $5447
	push af ; $544a
	ld_story_char_field CHARREC_TRAIN_LEVELS + TRAINSTAT_POWER ; $544b
	pop af ; $545e
	ld a, [wCharDataNewLevels + TRAINSTAT_POWER] ; $545f
	ld [hl], a ; $5462
	ld [wCharDataLevels + TRAINSTAT_POWER], a ; $5463
	push af ; $5466
	ld_story_char_field CHARREC_TRAIN_LEVELS + TRAINSTAT_CONTROL ; $5467
	pop af ; $547a
	ld a, [wCharDataNewLevels + TRAINSTAT_CONTROL] ; $547b
	ld [hl], a ; $547e
	ld [wCharDataLevels + TRAINSTAT_CONTROL], a ; $547f
	push af ; $5482
	ld_story_char_field CHARREC_TRAIN_LEVELS + TRAINSTAT_SPEED ; $5483
	pop af ; $5496
	ld a, [wCharDataNewLevels + TRAINSTAT_SPEED] ; $5497
	ld [hl], a ; $549a
	ld [wCharDataLevels + TRAINSTAT_SPEED], a ; $549b
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
	ld_hl_indexed wCharDataChoiceLog ; $54af
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
	ld a, CHARDATAPAGE_CONFIRM ; $54c9
	ld [wCharDataPage], a ; $54cb
	call RestoreCharDataScreen ; $54ce
	call LoadCharStats ; $54d1
	call CharDataScreen_DrawStats ; $54d4
	call DrawCharStatsAndFlush ; $54d7
	call CharDataScreen_DrawPageColumns ; $54da
	call FlushCharDataTilemaps ; $54dd
	ld a, $01 ; $54e0
	ret ; $54e2
SelectCharDataConfirmSlot:
	wram_bank WRAM_SCENE ; $54e3
	ld a, CHARDATAPAGE_CONFIRM ; $54e9
	ld [wCharDataPage], a ; $54eb
	call CommitCharDataToRecord ; $54ee
	ret ; $54f1
DrawStatArrowIndicators:
	wram_bank WRAM_SCENE ; $54f2
	ld a, [wCharDataStatDeltas + CHARSTAT_TOP] ; $54f8
	ld_xy de, $4c, $24 ; $54fb
	call QueueStatChangeArrow ; $54fe
	ld a, [wCharDataStatDeltas + CHARSTAT_SLICE] ; $5501
	ld_xy de, $4c, $34 ; $5504
	call QueueStatChangeArrow ; $5507
	ld a, [wCharDataStatDeltas + CHARSTAT_SERVE] ; $550a
	ld_xy de, $4c, $4c ; $550d
	call QueueStatChangeArrow ; $5510
	ld a, [wCharDataStatDeltas + CHARSTAT_STROKE] ; $5513
	ld_xy de, $4c, $5c ; $5516
	call QueueStatChangeArrow ; $5519
	ld a, [wCharDataStatDeltas + CHARSTAT_VOLLEY] ; $551c
	ld_xy de, $4c, $6c ; $551f
	call QueueStatChangeArrow ; $5522
	ld a, [wCharDataStatDeltas + CHARSTAT_ANGLE] ; $5525
	ld_xy de, $9c, $24 ; $5528
	call QueueStatChangeArrow ; $552b
	ld a, [wCharDataStatDeltas + CHARSTAT_PLACEMENT] ; $552e
	ld_xy de, $9c, $34 ; $5531
	call QueueStatChangeArrow ; $5534
	ld a, [wCharDataStatDeltas + CHARSTAT_SPEED] ; $5537
	ld_xy de, $9c, $4c ; $553a
	call QueueStatChangeArrow ; $553d
	ld a, [wCharDataStatDeltas + CHARSTAT_DASH] ; $5540
	ld_xy de, $9c, $5c ; $5543
	call QueueStatChangeArrow ; $5546
	ld a, [wCharDataStatDeltas + CHARSTAT_REACTION] ; $5549
	ld_xy de, $9c, $6c ; $554c
	call QueueStatChangeArrow ; $554f
	ld a, [wCharDataStatDeltas + CHARSTAT_STOP] ; $5552
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
	call BackupCharDataScreen ; $5574
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
	ld [wCharDataDigitFlyInStep], a ; $55ab
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
	frame_task DrawStatValueSprites ; $55e9
	script_fade_in 16 ; $55f1
	call WaitFadeEnd ; $55f6
	frame_task CharDataScreenAnimTask ; $55f9
	call RestoreCharDataScreen ; $5601
	call DrawCharStatRows ; $5604
	ld hl, CharDataBand8RunsStep1_1c ; $5607
	ld bc, wCharDataScreenCell + 32 * TILEMAP_WIDTH + 16 ; $560a
	call BlitTilemapRunsFromTable ; $560d
	call FlushCharDataTilemaps ; $5610
	call RestoreCharDataScreen ; $5613
	call DrawCharStatRows ; $5616
	ld hl, CharDataBand7RunsStep1_1c ; $5619
	ld bc, wCharDataScreenCell + 31 * TILEMAP_WIDTH ; $561c
	call BlitTilemapRunsFromTable ; $561f
	ld hl, CharDataBand8RunsStep2_1c ; $5622
	ld bc, wCharDataScreenCell + 32 * TILEMAP_WIDTH + 16 ; $5625
	call BlitTilemapRunsFromTable ; $5628
	call FlushCharDataTilemaps ; $562b
	call RestoreCharDataScreen ; $562e
	call DrawCharStatRows ; $5631
	ld hl, CharDataBand7RunsStep2_1c ; $5634
	ld bc, wCharDataScreenCell + 31 * TILEMAP_WIDTH ; $5637
	call BlitTilemapRunsFromTable ; $563a
	ld hl, CharDataBand8RunsStep3_1c ; $563d
	ld bc, wCharDataScreenCell + 32 * TILEMAP_WIDTH + 16 ; $5640
	call BlitTilemapRunsFromTable ; $5643
	call FlushCharDataTilemaps ; $5646
	call RestoreCharDataScreen ; $5649
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
CharDataShiftGfxFramesA:
	; $5679, 32 bytes (records:2)
	dw CharDataShiftGfx00 ; record 0
	dw CharDataShiftGfx01 ; record 1
	dw CharDataShiftGfx02 ; record 2
	dw CharDataShiftGfx03 ; record 3
	dw CharDataShiftGfx04 ; record 4
	dw CharDataShiftGfx05 ; record 5
	dw CharDataShiftGfx06 ; record 6
	dw CharDataShiftGfx07 ; record 7
	dw CharDataShiftGfx08 ; record 8
	dw CharDataShiftGfx09 ; record 9
	dw CharDataShiftGfx10 ; record 10
	dw CharDataShiftGfx11 ; record 11
	dw CharDataShiftGfx12 ; record 12
	dw CharDataShiftGfx13 ; record 13
	dw CharDataShiftGfx14 ; record 14
	dw CharDataShiftGfx15 ; record 15
CharDataShiftGfxFramesB:
	; $5699, 32 bytes (records:2)
	dw CharDataShiftGfx16 ; record 0
	dw CharDataShiftGfx17 ; record 1
	dw CharDataShiftGfx18 ; record 2
	dw CharDataShiftGfx19 ; record 3
	dw CharDataShiftGfx20 ; record 4
	dw CharDataShiftGfx21 ; record 5
	dw CharDataShiftGfx22 ; record 6
	dw CharDataShiftGfx23 ; record 7
	dw CharDataShiftGfx24 ; record 8
	dw CharDataShiftGfx25 ; record 9
	dw CharDataShiftGfx26 ; record 10
	dw CharDataShiftGfx27 ; record 11
	dw CharDataShiftGfx28 ; record 12
	dw CharDataShiftGfx29 ; record 13
	dw CharDataShiftGfx30 ; record 14
	dw CharDataShiftGfx31 ; record 15
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
CharDataScreenBasePalettes:
	INCLUDE "data/engine/menus/char_data/CharDataScreenBasePalettes.asm" ; $598c, 64 bytes (palettes)
CharDataScreenTiles:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenTiles.bin" ; $59cc, 2618 bytes
CharDataScreenTilemap_1c:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenTilemap_1c.bin" ; $6406, 99 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenTilemap_1c.inc" ; DEF CharDataScreenTilemap_1c_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenAttrmap_1c:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenAttrmap_1c.bin" ; $6469, 59 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenAttrmap_1c.inc" ; DEF CharDataScreenAttrmap_1c_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenStatBar00:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar00.asm" ; $64a4, 5 bytes (bytes:5)
CharDataScreenStatBar01:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar01.asm" ; $64a9, 5 bytes (bytes:5)
CharDataScreenStatBar02:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar02.asm" ; $64ae, 5 bytes (bytes:5)
CharDataScreenStatBar03:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar03.asm" ; $64b3, 5 bytes (bytes:5)
CharDataScreenStatBar04:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar04.asm" ; $64b8, 5 bytes (bytes:5)
CharDataScreenStatBar05:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar05.asm" ; $64bd, 5 bytes (bytes:5)
CharDataScreenStatBar06:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar06.asm" ; $64c2, 5 bytes (bytes:5)
CharDataScreenStatBar07:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar07.asm" ; $64c7, 5 bytes (bytes:5)
CharDataScreenStatBar08:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar08.asm" ; $64cc, 5 bytes (bytes:5)
CharDataScreenStatBar09:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar09.asm" ; $64d1, 5 bytes (bytes:5)
CharDataScreenStatBar10:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar10.asm" ; $64d6, 5 bytes (bytes:5)
CharDataScreenStatBar11:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar11.asm" ; $64db, 5 bytes (bytes:5)
CharDataScreenStatBar12:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar12.asm" ; $64e0, 5 bytes (bytes:5)
CharDataScreenStatBar13:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar13.asm" ; $64e5, 5 bytes (bytes:5)
CharDataScreenStatBar14:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar14.asm" ; $64ea, 5 bytes (bytes:5)
CharDataScreenStatBar15:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar15.asm" ; $64ef, 5 bytes (bytes:5)
CharDataScreenStatBar16:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar16.asm" ; $64f4, 5 bytes (bytes:5)
CharDataScreenStatBar17:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar17.asm" ; $64f9, 5 bytes (bytes:5)
CharDataScreenStatBar18:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar18.asm" ; $64fe, 5 bytes (bytes:5)
CharDataScreenStatBar19:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar19.asm" ; $6503, 5 bytes (bytes:5)
CharDataScreenStatBar20:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar20.asm" ; $6508, 5 bytes (bytes:5)
CharDataScreenStatBar21:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar21.asm" ; $650d, 5 bytes (bytes:5)
CharDataScreenStatBar22:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar22.asm" ; $6512, 5 bytes (bytes:5)
CharDataScreenStatBar23:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar23.asm" ; $6517, 5 bytes (bytes:5)
CharDataScreenStatBar24:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar24.asm" ; $651c, 5 bytes (bytes:5)
CharDataScreenStatBar25:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar25.asm" ; $6521, 5 bytes (bytes:5)
CharDataScreenStatBar26:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar26.asm" ; $6526, 5 bytes (bytes:5)
CharDataScreenStatBar27:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar27.asm" ; $652b, 5 bytes (bytes:5)
CharDataScreenStatBar28:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar28.asm" ; $6530, 5 bytes (bytes:5)
CharDataScreenStatBar29:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar29.asm" ; $6535, 5 bytes (bytes:5)
CharDataScreenStatBar30:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar30.asm" ; $653a, 5 bytes (bytes:5)
CharDataScreenStatBar31:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar31.asm" ; $653f, 5 bytes (bytes:5)
CharDataScreenStatBar32:
	INCLUDE "data/engine/menus/char_data/CharDataScreenStatBar32.asm" ; $6544, 5 bytes (bytes:5)
CharDataScreenBand1Tilemap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand1Tilemap.bin" ; $6549, 54 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand1Tilemap.inc" ; DEF CharDataScreenBand1Tilemap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenBand1Attrmap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand1Attrmap.bin" ; $657f, 23 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand1Attrmap.inc" ; DEF CharDataScreenBand1Attrmap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenPage0Columns:
	INCLUDE "data/engine/menus/char_data/CharDataScreenPage0Columns.asm" ; $6596, 50 bytes (bytes:10)
CharDataScreenBand2Tilemap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand2Tilemap.bin" ; $65c8, 67 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand2Tilemap.inc" ; DEF CharDataScreenBand2Tilemap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenBand2Attrmap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand2Attrmap.bin" ; $660b, 23 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand2Attrmap.inc" ; DEF CharDataScreenBand2Attrmap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenPage1Columns:
	INCLUDE "data/engine/menus/char_data/CharDataScreenPage1Columns.asm" ; $6622, 70 bytes (bytes:10)
CharDataScreenBand3Tilemap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand3Tilemap.bin" ; $6668, 58 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand3Tilemap.inc" ; DEF CharDataScreenBand3Tilemap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenBand3Attrmap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand3Attrmap.bin" ; $66a2, 24 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand3Attrmap.inc" ; DEF CharDataScreenBand3Attrmap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenPage2Columns:
	INCLUDE "data/engine/menus/char_data/CharDataScreenPage2Columns.asm" ; $66ba, 50 bytes (bytes:10)
CharDataScreenBand4Tilemap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand4Tilemap.bin" ; $66ec, 72 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand4Tilemap.inc" ; DEF CharDataScreenBand4Tilemap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenBand4Attrmap:
	INCBIN "data/engine/menus/char_data/lz_CharDataScreenBand4Attrmap.bin" ; $6734, 25 bytes
	INCLUDE "data/engine/menus/char_data/lz_CharDataScreenBand4Attrmap.inc" ; DEF CharDataScreenBand4Attrmap_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenPage3Columns:
	INCLUDE "data/engine/menus/char_data/CharDataScreenPage3Columns.asm" ; $674d, 90 bytes (bytes:10)
CharDataScreenPage4Columns:
	INCLUDE "data/engine/menus/char_data/CharDataScreenPage4Columns.asm" ; $67a7, 30 bytes (bytes:10)
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
