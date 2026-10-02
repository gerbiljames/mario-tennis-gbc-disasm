; Instruction-identical to DrawConfirmSelectionCursor_1a and DrawConfirmSelectionCursor_1d (one copy per bank); a change here belongs in every copy.
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
	ld c, $24 ; $55ba
	call QueueVRAMCopy ; $55bc
	wram_bank WRAM_COURT_PLANES ; $55bf
	ld hl, wCharDataScreenCell ; $55c5
	ld de, vBGMap0 + VRAM_BANK1 ; $55c8
	ld c, $24 ; $55cb
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
	script_fade_in $10 ; $55f1
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
	INCLUDE "data/bank_01c/CharDataScreen_LoadScreenPalette.asm" ; $598c, 64 bytes (palettes)
CharDataScreenGfx0_1c:
	INCBIN "data/bank_01c/lz_CharDataScreenGfx0_1c.bin" ; $59cc, 2618 bytes
CharDataScreenGfx1_1c:
	INCBIN "data/bank_01c/lz_CharDataScreenGfx1_1c.bin" ; $6406, 99 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenGfx1_1c.inc" ; DEF CharDataScreenGfx1_1c_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenGfx2_1c:
	INCBIN "data/bank_01c/lz_CharDataScreenGfx2_1c.bin" ; $6469, 59 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenGfx2_1c.inc" ; DEF CharDataScreenGfx2_1c_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenStatBar00:
	INCBIN "data/bank_01c/CharDataScreenStatBar00.bin" ; $64a4, 5 bytes
CharDataScreenStatBar01:
	INCBIN "data/bank_01c/CharDataScreenStatBar01.bin" ; $64a9, 5 bytes
CharDataScreenStatBar02:
	INCBIN "data/bank_01c/CharDataScreenStatBar02.bin" ; $64ae, 5 bytes
CharDataScreenStatBar03:
	INCBIN "data/bank_01c/CharDataScreenStatBar03.bin" ; $64b3, 5 bytes
CharDataScreenStatBar04:
	INCBIN "data/bank_01c/CharDataScreenStatBar04.bin" ; $64b8, 5 bytes
CharDataScreenStatBar05:
	INCBIN "data/bank_01c/CharDataScreenStatBar05.bin" ; $64bd, 5 bytes
CharDataScreenStatBar06:
	INCBIN "data/bank_01c/CharDataScreenStatBar06.bin" ; $64c2, 5 bytes
CharDataScreenStatBar07:
	INCBIN "data/bank_01c/CharDataScreenStatBar07.bin" ; $64c7, 5 bytes
CharDataScreenStatBar08:
	INCBIN "data/bank_01c/CharDataScreenStatBar08.bin" ; $64cc, 5 bytes
CharDataScreenStatBar09:
	INCBIN "data/bank_01c/CharDataScreenStatBar09.bin" ; $64d1, 5 bytes
CharDataScreenStatBar10:
	INCBIN "data/bank_01c/CharDataScreenStatBar10.bin" ; $64d6, 5 bytes
CharDataScreenStatBar11:
	INCBIN "data/bank_01c/CharDataScreenStatBar11.bin" ; $64db, 5 bytes
CharDataScreenStatBar12:
	INCBIN "data/bank_01c/CharDataScreenStatBar12.bin" ; $64e0, 5 bytes
CharDataScreenStatBar13:
	INCBIN "data/bank_01c/CharDataScreenStatBar13.bin" ; $64e5, 5 bytes
CharDataScreenStatBar14:
	INCBIN "data/bank_01c/CharDataScreenStatBar14.bin" ; $64ea, 5 bytes
CharDataScreenStatBar15:
	INCBIN "data/bank_01c/CharDataScreenStatBar15.bin" ; $64ef, 5 bytes
CharDataScreenStatBar16:
	INCBIN "data/bank_01c/CharDataScreenStatBar16.bin" ; $64f4, 5 bytes
CharDataScreenStatBar17:
	INCBIN "data/bank_01c/CharDataScreenStatBar17.bin" ; $64f9, 5 bytes
CharDataScreenStatBar18:
	INCBIN "data/bank_01c/CharDataScreenStatBar18.bin" ; $64fe, 5 bytes
CharDataScreenStatBar19:
	INCBIN "data/bank_01c/CharDataScreenStatBar19.bin" ; $6503, 5 bytes
CharDataScreenStatBar20:
	INCBIN "data/bank_01c/CharDataScreenStatBar20.bin" ; $6508, 5 bytes
CharDataScreenStatBar21:
	INCBIN "data/bank_01c/CharDataScreenStatBar21.bin" ; $650d, 5 bytes
CharDataScreenStatBar22:
	INCBIN "data/bank_01c/CharDataScreenStatBar22.bin" ; $6512, 5 bytes
CharDataScreenStatBar23:
	INCBIN "data/bank_01c/CharDataScreenStatBar23.bin" ; $6517, 5 bytes
CharDataScreenStatBar24:
	INCBIN "data/bank_01c/CharDataScreenStatBar24.bin" ; $651c, 5 bytes
CharDataScreenStatBar25:
	INCBIN "data/bank_01c/CharDataScreenStatBar25.bin" ; $6521, 5 bytes
CharDataScreenStatBar26:
	INCBIN "data/bank_01c/CharDataScreenStatBar26.bin" ; $6526, 5 bytes
CharDataScreenStatBar27:
	INCBIN "data/bank_01c/CharDataScreenStatBar27.bin" ; $652b, 5 bytes
CharDataScreenStatBar28:
	INCBIN "data/bank_01c/CharDataScreenStatBar28.bin" ; $6530, 5 bytes
CharDataScreenStatBar29:
	INCBIN "data/bank_01c/CharDataScreenStatBar29.bin" ; $6535, 5 bytes
CharDataScreenStatBar30:
	INCBIN "data/bank_01c/CharDataScreenStatBar30.bin" ; $653a, 5 bytes
CharDataScreenStatBar31:
	INCBIN "data/bank_01c/CharDataScreenStatBar31.bin" ; $653f, 5 bytes
CharDataScreenStatBar32:
	INCBIN "data/bank_01c/CharDataScreenStatBar32.bin" ; $6544, 5 bytes
CharDataScreenGfx3_1c:
	INCBIN "data/bank_01c/lz_CharDataScreenGfx3_1c.bin" ; $6549, 54 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenGfx3_1c.inc" ; DEF CharDataScreenGfx3_1c_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenGfx4:
	INCBIN "data/bank_01c/lz_CharDataScreenGfx4.bin" ; $657f, 23 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenGfx4.inc" ; DEF CharDataScreenGfx4_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenPage0Columns:
	INCBIN "data/bank_01c/CharDataScreenPage0Columns.bin" ; $6596, 50 bytes
CharDataScreenGfx5:
	INCBIN "data/bank_01c/lz_CharDataScreenGfx5.bin" ; $65c8, 67 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenGfx5.inc" ; DEF CharDataScreenGfx5_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenGfx6:
	INCBIN "data/bank_01c/lz_CharDataScreenGfx6.bin" ; $660b, 23 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenGfx6.inc" ; DEF CharDataScreenGfx6_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenPage1Columns:
	INCBIN "data/bank_01c/CharDataScreenPage1Columns.bin" ; $6622, 70 bytes
CharDataScreenGfx7:
	INCBIN "data/bank_01c/lz_CharDataScreenGfx7.bin" ; $6668, 58 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenGfx7.inc" ; DEF CharDataScreenGfx7_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenGfx8:
	INCBIN "data/bank_01c/lz_CharDataScreenGfx8.bin" ; $66a2, 24 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenGfx8.inc" ; DEF CharDataScreenGfx8_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenPage2Columns:
	INCBIN "data/bank_01c/CharDataScreenPage2Columns.bin" ; $66ba, 50 bytes
CharDataScreenGfx9:
	INCBIN "data/bank_01c/lz_CharDataScreenGfx9.bin" ; $66ec, 72 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenGfx9.inc" ; DEF CharDataScreenGfx9_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenGfx10:
	INCBIN "data/bank_01c/lz_CharDataScreenGfx10.bin" ; $6734, 25 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenGfx10.inc" ; DEF CharDataScreenGfx10_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenPage3Columns:
	INCBIN "data/bank_01c/CharDataScreenPage3Columns.bin" ; $674d, 90 bytes
CharDataScreenPage4Columns:
	INCBIN "data/bank_01c/CharDataScreenPage4Columns.bin" ; $67a7, 30 bytes
CharDataScreenGfx11:
	INCBIN "data/bank_01c/lz_CharDataScreenGfx11.bin" ; $67c5, 14 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenGfx11.inc" ; DEF CharDataScreenGfx11_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenGfx12:
	INCBIN "data/bank_01c/lz_CharDataScreenGfx12.bin" ; $67d3, 7 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenGfx12.inc" ; DEF CharDataScreenGfx12_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenUIGraphicsGfx0:
	INCBIN "data/bank_01c/lz_CharDataScreenUIGraphicsGfx0.bin" ; $67da, 24 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenUIGraphicsGfx0.inc" ; DEF CharDataScreenUIGraphicsGfx0_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenUIGraphicsGfx1:
	INCBIN "data/bank_01c/lz_CharDataScreenUIGraphicsGfx1.bin" ; $67f2, 12 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenUIGraphicsGfx1.inc" ; DEF CharDataScreenUIGraphicsGfx1_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenUIGraphicsGfx2:
	INCBIN "data/bank_01c/lz_CharDataScreenUIGraphicsGfx2.bin" ; $67fe, 39 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenUIGraphicsGfx2.inc" ; DEF CharDataScreenUIGraphicsGfx2_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenUIGraphicsGfx3:
	INCBIN "data/bank_01c/lz_CharDataScreenUIGraphicsGfx3.bin" ; $6825, 9 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenUIGraphicsGfx3.inc" ; DEF CharDataScreenUIGraphicsGfx3_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenUIGraphicsGfx4:
	INCBIN "data/bank_01c/lz_CharDataScreenUIGraphicsGfx4.bin" ; $682e, 26 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenUIGraphicsGfx4.inc" ; DEF CharDataScreenUIGraphicsGfx4_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenUIGraphicsGfx5:
	INCBIN "data/bank_01c/lz_CharDataScreenUIGraphicsGfx5.bin" ; $6848, 7 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenUIGraphicsGfx5.inc" ; DEF CharDataScreenUIGraphicsGfx5_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenUIGraphicsGfx6:
	INCBIN "data/bank_01c/lz_CharDataScreenUIGraphicsGfx6.bin" ; $684f, 28 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenUIGraphicsGfx6.inc" ; DEF CharDataScreenUIGraphicsGfx6_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenUIGraphicsGfx7:
	INCBIN "data/bank_01c/lz_CharDataScreenUIGraphicsGfx7.bin" ; $686b, 7 bytes
	INCLUDE "data/bank_01c/lz_CharDataScreenUIGraphicsGfx7.inc" ; DEF CharDataScreenUIGraphicsGfx7_SIZE EQU its decoded length, generated from the .bin by make
	; $6872, 14 bytes (fill)
	ds 14, $00
