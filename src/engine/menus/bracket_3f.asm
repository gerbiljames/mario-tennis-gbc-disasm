DrawTennisDictionaryLetterLabels:
	call GetTennisDictionarySelectedIndex ; $5334
	ld b, a ; $5337
	inc b ; $5338
	ld a, [wTennisDictCategoryMask] ; $5339
	ld e, a ; $533c
	ld hl, SelectionMaskGrid_3f ; $533d
	ld d, $00 ; $5340
.loop:
	ld a, [hl+] ; $5342
	cp $00 ; $5343
	jr nz, .ne00 ; $5345
	inc d ; $5347
	jr .loop ; $5348
.ne00:
	and e ; $534a
	jr z, .loop ; $534b
	dec b ; $534d
	jr nz, .loop ; $534e
	wram_bank $03 ; $5350
	ld a, d ; $5356
	dec a ; $5357
	cp $ff ; $5358
	jr nz, .neff ; $535a
	ld a, $16 ; $535c
.neff:
	ld hl, $148f ; $535e
	add l ; $5361
	ld l, a ; $5362
	jr nc, .gotPtr ; $5363
	inc h ; $5365
.gotPtr:
	push de ; $5366
	ld c, $40 ; $5367
	ld de, wShadowTilemap + 2 * TILEMAP_WIDTH + 16 ; $5369
	farcall RenderTextToBuffer64 ; $536c
	pop de ; $536f
	ld a, d ; $5370
	inc a ; $5371
	cp $17 ; $5372
	jr nz, .ne17 ; $5374
	xor a ; $5376
.ne17:
	ld hl, $148f ; $5377
	add l ; $537a
	ld l, a ; $537b
	jr nc, .renderTextToBuffer64 ; $537c
	inc h ; $537e
.renderTextToBuffer64:
	ld de, wShadowTilemap + 2 * TILEMAP_WIDTH + 30 ; $537f
	farcall RenderTextToBuffer64 ; $5382
	ld a, $06 ; $5385
	ld [wShadowTilemap + 2 * TILEMAP_WIDTH], a ; $5387
.loopB:
	ld hl, wShadowTilemap + 2 * TILEMAP_WIDTH + 16 ; $538a
	ld de, vBGMap0 + 1 * TILEMAP_WIDTH + 16 ; $538d
	ld c, $01 ; $5390
	call QueueVRAMCopy ; $5392
	or a ; $5395
	jr nz, .done ; $5396
	call AdvanceFrame ; $5398
	jr .loopB ; $539b
.done:
	ret ; $539d
SelectionMaskGrid_3f:
	INCBIN "data/bank_03f/SelectionMaskGrid_3f.bin" ; $539e, 121 bytes
SetTennisDictionaryListFromIndexRow:
	wram_bank $06 ; $5417
	ld c, $00 ; $541d
	ld hl, SelectionMaskGrid_3f ; $541f
	ld a, [wTennisDictCategoryMask] ; $5422
	ld e, a ; $5425
	ld a, [wTennisDictCursorRow] ; $5426
	call GetTennisDictionaryRowFirstLetter ; $5429
	ld b, a ; $542c
	or a ; $542d
	jr z, .clearTennisDictCursorRow ; $542e
.loop:
	ld a, [hl+] ; $5430
	and e ; $5431
	jr z, .compare ; $5432
	inc c ; $5434
.compare:
	cp $40 ; $5435
	jr z, .clearTennisDictCursorRow ; $5437
	cp $00 ; $5439
	jr nz, .loop ; $543b
	dec b ; $543d
	jr nz, .loop ; $543e
	jr .clearTennisDictCursorRow2 ; $5440
.clearTennisDictCursorRow:
	xor a ; $5442
	ld [wTennisDictCursorRow], a ; $5443
	ld [wTennisDictScrollTop], a ; $5446
	ret ; $5449
.clearTennisDictCursorRow2:
	xor a ; $544a
	ld [wTennisDictCursorRow], a ; $544b
	ld a, c ; $544e
	ld [wTennisDictScrollTop], a ; $544f
	ret ; $5452
GetTennisDictionaryRowFirstLetter:
	push hl ; $5453
	ld hl, TennisDictionaryRowFirstLetterTable ; $5454
	add l ; $5457
	ld l, a ; $5458
	jr nc, .read ; $5459
	inc h ; $545b
.read:
	ld a, [hl] ; $545c
	pop hl ; $545d
	ret ; $545e
TennisDictionaryRowFirstLetterTable:
	; $545f, 9 bytes (bytes:9)
	db $00, $03, $06, $0b, $0c, $0f, $12, $15, $16 ; 0x00
SetTennisDictionaryIndexRowFromList:
	wram_bank $06 ; $5468
	ld a, [wTennisDictCategoryMask] ; $546e
	ld b, a ; $5471
	call GetTennisDictionarySelectedIndex ; $5472
	ld b, a ; $5475
	inc b ; $5476
	ld c, $00 ; $5477
	ld hl, SelectionMaskGrid_3f ; $5479
	ld a, [wTennisDictCategoryMask] ; $547c
	ld e, a ; $547f
.loop:
	ld a, [hl+] ; $5480
	and e ; $5481
	jr z, .compare ; $5482
	dec b ; $5484
	jr nz, .loop ; $5485
	jr .getTennisDictionaryLetterRow ; $5487
.compare:
	cp $40 ; $5489
	jr z, .clearTennisDictCursorRow ; $548b
	cp $00 ; $548d
	jr nz, .loop ; $548f
	inc c ; $5491
	jr .loop ; $5492
.clearTennisDictCursorRow:
	xor a ; $5494
	ld [wTennisDictCursorRow], a ; $5495
	ret ; $5498
.getTennisDictionaryLetterRow:
	ld a, c ; $5499
	call GetTennisDictionaryLetterRow ; $549a
	ld [wTennisDictCursorRow], a ; $549d
	ret ; $54a0
GetTennisDictionaryLetterRow:
	push hl ; $54a1
	ld hl, TennisDictionaryLetterRowTable ; $54a2
	add l ; $54a5
	ld l, a ; $54a6
	jr nc, .read ; $54a7
	inc h ; $54a9
.read:
	ld a, [hl] ; $54aa
	pop hl ; $54ab
	ret ; $54ac
TennisDictionaryLetterRowTable:
	; $54ad, 27 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $02, $02, $02, $03, $03, $03, $04, $04, $04, $05 ; 0x00
	db $05, $05, $06, $06, $06, $07, $07, $07, $08, $08, $08 ; 0x10
DrawTennisDictionaryIndexCursor:
	or a ; $54c8
	jr z, .compactTiles ; $54c9
	ld hl, TennisDictionaryIndexCursorTable0 ; $54cb
	jr .gotTiles ; $54ce
.compactTiles:
	ld hl, TennisDictionaryIndexCursorTable1 ; $54d0
.gotTiles:
	wram_bank $03 ; $54d3
	ld de, $cfb3 ; $54d9
	ld c, b ; $54dc
	inc b ; $54dd
.rowLoop:
	ld a, $80 ; $54de
	add e ; $54e0
	ld e, a ; $54e1
	jr nc, .nextRow ; $54e2
	inc d ; $54e4
.nextRow:
	dec b ; $54e5
	jr nz, .rowLoop ; $54e6
	ld a, c ; $54e8
	push af ; $54e9
	add a ; $54ea
	add a ; $54eb
	add l ; $54ec
	ld l, a ; $54ed
	jr nc, .readEntry ; $54ee
	inc h ; $54f0
.readEntry:
	ld a, [hl+] ; $54f1
	ld [de], a ; $54f2
	inc de ; $54f3
	ld a, [hl+] ; $54f4
	ld [de], a ; $54f5
	ld a, $3f ; $54f6
	add e ; $54f8
	ld e, a ; $54f9
	jr nc, .secondRow ; $54fa
	inc d ; $54fc
.secondRow:
	ld a, [hl+] ; $54fd
	ld [de], a ; $54fe
	inc de ; $54ff
	ld a, [hl] ; $5500
	ld [de], a ; $5501
	pop af ; $5502
	ld hl, $cff0 ; $5503
	ld de, $97f0 ; $5506
	add a ; $5509
	ld b, a ; $550a
	inc b ; $550b
.vramRowLoop:
	ld a, $40 ; $550c
	add l ; $550e
	ld l, a ; $550f
	jr nc, .advanceDest ; $5510
	inc h ; $5512
.advanceDest:
	ld a, $20 ; $5513
	add e ; $5515
	ld e, a ; $5516
	jr nc, .nextVramRow ; $5517
	inc d ; $5519
.nextVramRow:
	dec b ; $551a
	jr nz, .vramRowLoop ; $551b
	ld c, $01 ; $551d
	push de ; $551f
	push hl ; $5520
	call QueueVRAMCopy ; $5521
	pop hl ; $5524
	pop de ; $5525
	ld a, $40 ; $5526
	add l ; $5528
	ld l, a ; $5529
	jr nc, .secondQueueDest ; $552a
	inc h ; $552c
.secondQueueDest:
	ld a, $20 ; $552d
	add e ; $552f
	ld e, a ; $5530
	jr nc, .queueSecond ; $5531
	inc d ; $5533
.queueSecond:
	ld c, $01 ; $5534
	call QueueVRAMCopy ; $5536
	wram_bank $06 ; $5539
	ret ; $553f
TennisDictionaryIndexCursorTable0:
	; $5540, 36 bytes (bytes:16)
	db $76, $77, $86, $87, $78, $79, $88, $89, $7a, $7b, $8a, $8b, $7c, $7d, $8c, $8d ; 0x00
	db $7e, $7f, $8e, $8f, $a8, $a9, $b8, $b9, $aa, $ab, $ba, $bb, $ac, $ad, $bc, $bd ; 0x10
	db $ae, $af, $be, $bf ; 0x20
TennisDictionaryIndexCursorTable1:
	; $5564, 36 bytes (bytes:16)
	db $96, $84, $97, $84, $98, $84, $99, $84, $9a, $84, $9b, $84, $9c, $84, $9d, $84 ; 0x00
	db $9e, $84, $9f, $84, $c8, $84, $c9, $84, $ca, $84, $cb, $84, $cc, $84, $cd, $84 ; 0x10
	db $ce, $84, $cf, $84 ; 0x20
HandleTennisDictionaryIndexInput:
	push bc ; $5588
	push af ; $5589
	wram_bank $06 ; $558a
	ldh a, [hInputRisingEdge] ; $5590
	bit PADB_A, a ; $5592
	jr z, .step ; $5594
	pop af ; $5596
	sound SFX_MENU_SELECT ; $5597
	ld a, $04 ; $5599
	push af ; $559b
	jr .restore ; $559c
.step:
	bit 1, a ; $559e
	jr z, .bit1Clear ; $55a0
	pop af ; $55a2
	sound SFX_MENU_CANCEL ; $55a3
	ld a, $01 ; $55a5
	push af ; $55a7
	jr .restore ; $55a8
.bit1Clear:
	ldh a, [hInputPressed] ; $55aa
	bit PADB_UP, a ; $55ac
	jr z, .checkTennisDictCursorRow ; $55ae
	ld a, [wTennisDictCursorRow] ; $55b0
	ld b, a ; $55b3
	dec a ; $55b4
	cp $ff ; $55b5
	jr z, .restore ; $55b7
	ld [wTennisDictCursorRow], a ; $55b9
	push af ; $55bc
	xor a ; $55bd
	call DrawTennisDictionaryIndexCursor ; $55be
	pop af ; $55c1
	sound SFX_MENU_MOVE ; $55c2
	ld a, [wTennisDictCursorRow] ; $55c4
	ld b, a ; $55c7
	ld a, $01 ; $55c8
	call DrawTennisDictionaryIndexCursor ; $55ca
	ld a, $01 ; $55cd
	jr .restore ; $55cf
.checkTennisDictCursorRow:
	bit 7, a ; $55d1
	jr z, .positive ; $55d3
	ld a, [wTennisDictCursorRow] ; $55d5
	ld b, a ; $55d8
	inc a ; $55d9
	cp $09 ; $55da
	jr z, .restore ; $55dc
	ld [wTennisDictCursorRow], a ; $55de
	push af ; $55e1
	xor a ; $55e2
	call DrawTennisDictionaryIndexCursor ; $55e3
	pop af ; $55e6
	sound SFX_MENU_MOVE ; $55e7
	ld a, [wTennisDictCursorRow] ; $55e9
	ld b, a ; $55ec
	ld a, $01 ; $55ed
	call DrawTennisDictionaryIndexCursor ; $55ef
	ld a, $01 ; $55f2
	jr .restore ; $55f4
.positive:
	bit 5, a ; $55f6
	jr z, .restore ; $55f8
	jr .restore ; $55fa
.restore:
	pop af ; $55fc
	pop bc ; $55fd
	ret ; $55fe
HandleTennisDictionaryListInput:
	push bc ; $55ff
	push af ; $5600
	wram_bank $06 ; $5601
	ld a, [wTennisDictFlags] ; $5607
	res 2, a ; $560a
	res 3, a ; $560c
	ld [wTennisDictFlags], a ; $560e
	ldh a, [hInputRisingEdge] ; $5611
	bit PADB_A, a ; $5613
	jp z, .checkTennisDictMode ; $5615
	sound SFX_MENU_SELECT ; $5618
	call StartTennisDictionaryAnim ; $561a
	ld a, [wTennisDictFlags] ; $561d
	set 0, a ; $5620
	ld [wTennisDictFlags], a ; $5622
	ld a, [wTennisDictCategoryMask] ; $5625
	ld b, a ; $5628
	ld a, [wTennisDictSingleEntry] ; $5629
	cp $01 ; $562c
	jr z, .getTennisDictionarySelectedIndex ; $562e
	call GetTennisDictionarySelectedIndex ; $5630
	call GetTennisDictionaryEntryIndex ; $5633
	ld hl, $1430 ; $5636
	add l ; $5639
	ld l, a ; $563a
	jr nc, .getTennisDictionarySelectedIndex2 ; $563b
	inc h ; $563d
.getTennisDictionarySelectedIndex2:
	jr .resetTextWindowsAndRestoreMap ; $563e
.getTennisDictionarySelectedIndex:
	call GetTennisDictionarySelectedIndex ; $5640
	call GetTennisDictionaryEntryCategory ; $5643
	ld hl, $14a9 ; $5646
	add l ; $5649
	ld l, a ; $564a
	jr nc, .resetTextWindowsAndRestoreMap ; $564b
	inc h ; $564d
.resetTextWindowsAndRestoreMap:
	push hl ; $564e
	farcall ResetTextWindowsAndRestoreMap ; $564f
	ld a, $05 ; $5652
	ld [wShadowTilemapBank], a ; $5654
	pop hl ; $5657
	ld d, $00 ; $5658
	ld e, $06 ; $565a
	ld b, $14 ; $565c
	ld c, $05 ; $565e
	farcall CreateDialogueWindow ; $5660
	push hl ; $5663
	xor a ; $5664
	farcall AddTextIdOffset ; $5665
	ld b, $00 ; $5668
	farcall SetWindowTextId ; $566a
	pop hl ; $566d
	ld a, [wMessageSpeed] ; $566e
	push af ; $5671
	xor a ; $5672
	ld a, $80 ; $5673
	ld [wMessageSpeed], a ; $5675
	xor a ; $5678
	set_flag FLAG_TEXT_RENDER_ACTIVE ; $5679
	farcall RedrawWindowText ; $567c
	clear_flag FLAG_TEXT_RENDER_ACTIVE ; $567f
	pop af ; $5682
	ld [wMessageSpeed], a ; $5683
	xor a ; $5686
	farcall RestoreTilemapUnderWindow ; $5687
	farcall RedrawWindowRowsSafe ; $568a
	farcall CloseWindowAlt ; $568d
	wram_bank $06 ; $5690
	ld a, [wTennisDictFlags] ; $5696
	res 0, a ; $5699
	ld [wTennisDictFlags], a ; $569b
	call EndTennisDictionaryAnim ; $569e
	jp .restore ; $56a1
.checkTennisDictMode:
	bit 1, a ; $56a4
	jr z, .bit1Clear ; $56a6
	pop af ; $56a8
	sound SFX_MENU_CANCEL ; $56a9
	ld a, [wTennisDictMode] ; $56ab
	cp $06 ; $56ae
	jr z, .eq06 ; $56b0
	ld a, $01 ; $56b2
	push af ; $56b4
	jp .restore ; $56b5
.eq06:
	ld a, $10 ; $56b8
	push af ; $56ba
	jp .restore ; $56bb
.bit1Clear:
	ldh a, [hInputPressed] ; $56be
	bit PADB_UP, a ; $56c0
	jr z, .checkTennisDictCursorRow ; $56c2
	sound SFX_MENU_MOVE ; $56c4
	ld a, [wTennisDictCursorRow] ; $56c6
	dec a ; $56c9
	cp $ff ; $56ca
	jr z, .checkTennisDictScrollTop ; $56cc
	ld [wTennisDictCursorRow], a ; $56ce
	call DrawTennisDictionaryLetterLabels ; $56d1
	jr .restore ; $56d4
.checkTennisDictScrollTop:
	ld a, [wTennisDictScrollTop] ; $56d6
	dec a ; $56d9
	cp $ff ; $56da
	jr nz, .store ; $56dc
	ld a, [wTennisDictEntryCount] ; $56de
	dec a ; $56e1
.store:
	ld [wTennisDictScrollTop], a ; $56e2
	call DrawTennisDictionaryList ; $56e5
	jr .restore ; $56e8
.checkTennisDictCursorRow:
	bit 7, a ; $56ea
	jr z, .positive ; $56ec
	sound SFX_MENU_MOVE ; $56ee
	ld a, [wTennisDictCursorRow] ; $56f0
	inc a ; $56f3
	cp $06 ; $56f4
	jr nc, .checkTennisDictEntryCount ; $56f6
	ld [wTennisDictCursorRow], a ; $56f8
	call DrawTennisDictionaryLetterLabels ; $56fb
	jr .restore ; $56fe
.checkTennisDictEntryCount:
	ld a, [wTennisDictEntryCount] ; $5700
	ld b, a ; $5703
	ld a, [wTennisDictScrollTop] ; $5704
	inc a ; $5707
	cp b ; $5708
	jr nz, .store2 ; $5709
	xor a ; $570b
.store2:
	ld [wTennisDictScrollTop], a ; $570c
	call DrawTennisDictionaryList ; $570f
	jr .restore ; $5712
.positive:
	bit 5, a ; $5714
	jr z, .bit5Clear ; $5716
	ld a, [wTennisDictFlags] ; $5718
	set 2, a ; $571b
	ld [wTennisDictFlags], a ; $571d
	sound SFX_MENU_MOVE ; $5720
	call AdvanceFrame ; $5722
	call ScrollTennisDictionaryToPrevLetter ; $5725
	call DrawTennisDictionaryList ; $5728
	jr .restore ; $572b
.bit5Clear:
	bit 4, a ; $572d
	jr z, .restore ; $572f
	ld a, [wTennisDictFlags] ; $5731
	set 3, a ; $5734
	ld [wTennisDictFlags], a ; $5736
	sound SFX_MENU_MOVE ; $5739
	call AdvanceFrame ; $573b
	call ScrollTennisDictionaryToNextLetter ; $573e
	call DrawTennisDictionaryList ; $5741
	jr .restore ; $5744
.restore:
	pop af ; $5746
	pop bc ; $5747
	ret ; $5748
QueueTennisDictionaryGlyphTiles:
	push_wram_bank $07 ; $5749
	ld hl, wGlyphTileBuffer + 54 * TILE_SIZE ; $5752
	ld de, vTiles1 + $36 * TILE_SIZE ; $5755
	ld c, $18 ; $5758
	call QueueVRAMCopy ; $575a
	push af ; $575d
	ldh a, [rLCDC] ; $575e
	bit 7, a ; $5760
	jr z, .restore ; $5762
	call AdvanceFrame ; $5764
.restore:
	pop af ; $5767
	ld hl, wGlyphTileBuffer + 78 * TILE_SIZE ; $5768
	ld de, vTiles1 + $4e * TILE_SIZE ; $576b
	ld c, $18 ; $576e
	call QueueVRAMCopy ; $5770
	push af ; $5773
	ldh a, [rLCDC] ; $5774
	bit 7, a ; $5776
	jr z, .restore2 ; $5778
	call AdvanceFrame ; $577a
.restore2:
	pop af ; $577d
	ld hl, wGlyphTileBuffer + 102 * TILE_SIZE ; $577e
	ld de, vTiles1 + $66 * TILE_SIZE ; $5781
	ld c, $18 ; $5784
	call QueueVRAMCopy ; $5786
	pop_wram_bank ; $5789
	ret ; $578e
QueueTennisDictionaryListRows:
	push_wram_bank $05 ; $578f
	ld hl, wWindowShadowTilemap + 5 * TILEMAP_WIDTH + 16 ; $5798
	ld de, vBGMap0 + 5 * TILEMAP_WIDTH + 16 ; $579b
	ld c, $01 ; $579e
	call QueueVRAMCopy ; $57a0
	ld hl, wWindowShadowTilemap + 7 * TILEMAP_WIDTH + 16 ; $57a3
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH + 16 ; $57a6
	ld c, $01 ; $57a9
	call QueueVRAMCopy ; $57ab
	ld hl, wWindowShadowTilemap + 9 * TILEMAP_WIDTH + 16 ; $57ae
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + 16 ; $57b1
	ld c, $01 ; $57b4
	call QueueVRAMCopy ; $57b6
	ld hl, wWindowShadowTilemap + 11 * TILEMAP_WIDTH + 16 ; $57b9
	ld de, vBGMap0 + 11 * TILEMAP_WIDTH + 16 ; $57bc
	ld c, $01 ; $57bf
	call QueueVRAMCopy ; $57c1
	ld hl, wWindowShadowTilemap + 13 * TILEMAP_WIDTH + 16 ; $57c4
	ld de, vBGMap0 + 13 * TILEMAP_WIDTH + 16 ; $57c7
	ld c, $01 ; $57ca
	call QueueVRAMCopy ; $57cc
	ld hl, wWindowShadowTilemap + 15 * TILEMAP_WIDTH + 16 ; $57cf
	ld de, vBGMap0 + 15 * TILEMAP_WIDTH + 16 ; $57d2
	ld c, $01 ; $57d5
	call QueueVRAMCopy ; $57d7
	push af ; $57da
	ldh a, [rLCDC] ; $57db
	bit 7, a ; $57dd
	jr z, .restore ; $57df
	call AdvanceFrame ; $57e1
.restore:
	pop af ; $57e4
	pop_wram_bank ; $57e5
	ret ; $57ea
HardCourtLabelTiles:
	INCBIN "data/bank_03f/lz_HardCourtLabelTiles.bin" ; $57eb, 193 bytes
ClayCourtLabelTiles:
	INCBIN "data/bank_03f/lz_ClayCourtLabelTiles.bin" ; $58ac, 200 bytes
GrassCourtLabelTiles:
	INCBIN "data/bank_03f/lz_GrassCourtLabelTiles.bin" ; $5974, 195 bytes
CompositionCourtLabelTiles:
	INCBIN "data/bank_03f/lz_CompositionCourtLabelTiles.bin" ; $5a37, 190 bytes
CourtNameLabelTiles0:
	INCBIN "data/bank_03f/lz_CourtNameLabelTiles0.bin" ; $5af5, 210 bytes
CourtNameLabelTiles1:
	INCBIN "data/bank_03f/lz_CourtNameLabelTiles1.bin" ; $5bc7, 222 bytes
CourtNameLabelTiles2:
	INCBIN "data/bank_03f/lz_CourtNameLabelTiles2.bin" ; $5ca5, 251 bytes
CourtNameLabelTiles3:
	INCBIN "data/bank_03f/lz_CourtNameLabelTiles3.bin" ; $5da0, 242 bytes
CourtNameLabelTiles4:
	INCBIN "data/bank_03f/lz_CourtNameLabelTiles4.bin" ; $5e92, 235 bytes
CourtNameLabelTiles5:
	INCBIN "data/bank_03f/lz_CourtNameLabelTiles5.bin" ; $5f7d, 183 bytes
CourtSelectGfx1:
	INCBIN "data/bank_03f/lz_CourtSelectGfx1.bin" ; $6034, 151 bytes
CourtSelectGfx2:
	INCBIN "data/bank_03f/lz_CourtSelectGfx2.bin" ; $60cb, 164 bytes
CourtSelectGfx3:
	INCBIN "data/bank_03f/lz_CourtSelectGfx3.bin" ; $616f, 170 bytes
CourtSelectGfx4:
	INCBIN "data/bank_03f/lz_CourtSelectGfx4.bin" ; $6219, 196 bytes
VarsityTeamChartTiles:
	INCBIN "data/bank_03f/lz_VarsityTeamChartTiles.bin" ; $62dd, 1314 bytes
VarsityTeamChartTilemap:
	INCBIN "data/bank_03f/lz_VarsityTeamChartTilemap.bin" ; $67ff, 325 bytes
VarsityTeamChartAttrmap:
	INCBIN "data/bank_03f/lz_VarsityTeamChartAttrmap.bin" ; $6944, 141 bytes
VarsityTeamChartPalettes:
	INCLUDE "data/bank_03f/VarsityTeamChartPalettes.asm" ; $69d1, 64 bytes (palettes)
VarsityTeamChartTilemap2:
	INCBIN "data/bank_03f/lz_VarsityTeamChartTilemap2.bin" ; $6a11, 317 bytes
VarsityTeamChartAttrmap2:
	INCBIN "data/bank_03f/lz_VarsityTeamChartAttrmap2.bin" ; $6b4e, 143 bytes
TournamentBracketGfx:
	INCBIN "data/bank_03f/lz_TournamentBracketGfx.bin" ; $6bdd, 38 bytes
MugshotTiles:
	INCBIN "data/bank_03f/lz_MugshotTiles.bin" ; $6c03, 1000 bytes
TournamentBracketTiles:
	INCBIN "data/bank_03f/lz_TournamentBracketTiles.bin" ; $6feb, 1224 bytes
BracketCharIcon00:
	INCBIN "data/bank_03f/lz_BracketCharIcon00.bin" ; $74b3, 31 bytes
BracketCharIcon01:
	INCBIN "data/bank_03f/lz_BracketCharIcon01.bin" ; $74d2, 210 bytes
BracketCharIcon02:
	INCBIN "data/bank_03f/lz_BracketCharIcon02.bin" ; $75a4, 213 bytes
BracketCharIcon03:
	INCBIN "data/bank_03f/lz_BracketCharIcon03.bin" ; $7679, 74 bytes
BracketCharIcon04:
	INCBIN "data/bank_03f/lz_BracketCharIcon04.bin" ; $76c3, 75 bytes
BracketCharIcon05:
	INCBIN "data/bank_03f/lz_BracketCharIcon05.bin" ; $770e, 73 bytes
BracketCharIcon06:
	INCBIN "data/bank_03f/lz_BracketCharIcon06.bin" ; $7757, 70 bytes
BracketCharIcon07:
	INCBIN "data/bank_03f/lz_BracketCharIcon07.bin" ; $779d, 67 bytes
BracketCharIcon08:
	INCBIN "data/bank_03f/lz_BracketCharIcon08.bin" ; $77e0, 70 bytes
BracketCharIcon09:
	INCBIN "data/bank_03f/lz_BracketCharIcon09.bin" ; $7826, 74 bytes
BracketCharIcon10:
	INCBIN "data/bank_03f/lz_BracketCharIcon10.bin" ; $7870, 74 bytes
BracketCharIcon11:
	INCBIN "data/bank_03f/lz_BracketCharIcon11.bin" ; $78ba, 74 bytes
BracketCharIcon12:
	INCBIN "data/bank_03f/lz_BracketCharIcon12.bin" ; $7904, 75 bytes
BracketCharIcon13:
	INCBIN "data/bank_03f/lz_BracketCharIcon13.bin" ; $794f, 73 bytes
BracketCharIcon14:
	INCBIN "data/bank_03f/lz_BracketCharIcon14.bin" ; $7998, 67 bytes
BracketCharIcon15:
	INCBIN "data/bank_03f/lz_BracketCharIcon15.bin" ; $79db, 66 bytes
BracketExtraIcon0:
	INCBIN "data/bank_03f/lz_BracketExtraIcon0.bin" ; $7a1d, 70 bytes
BracketExtraIcon1:
	INCBIN "data/bank_03f/lz_BracketExtraIcon1.bin" ; $7a63, 74 bytes
BracketExtraIcon2:
	INCBIN "data/bank_03f/lz_BracketExtraIcon2.bin" ; $7aad, 74 bytes
MinigameLevelSelectGfx2:
	INCBIN "data/bank_03f/lz_MinigameLevelSelectGfx2.bin" ; $7af7, 153 bytes
SavedDataTypeSelectGfx:
	INCBIN "data/bank_03f/lz_SavedDataTypeSelectGfx.bin" ; $7b90, 185 bytes
	; $7c49, 951 bytes fill to bank end (linker-padded)
