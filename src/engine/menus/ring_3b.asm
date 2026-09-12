DrawRingShotRowIcons:
	push af ; $5202
	push bc ; $5203
	push de ; $5204
	push hl ; $5205
	push_wram_bank WRAM_SCREEN ; $5206
	ld hl, wRingShotEntryList ; $520f
	ld a, [wMenuCursorY] ; $5212
	add l ; $5215
	ld l, a ; $5216
	jr nc, .gotPtr ; $5217
	inc h ; $5219
.gotPtr:
	ld d, h ; $521a
	ld e, l ; $521b
	ld c, $00 ; $521c
	ld hl, wShadowTilemap + 6 * TILEMAP_WIDTH + 2 ; $521e
.loop:
	ld a, [de] ; $5221
	inc de ; $5222
	ld b, a ; $5223
	call DrawChartCharIcon ; $5224
	push de ; $5227
	ld de, $0040 ; $5228
	add hl, de ; $522b
	pop de ; $522c
	ld a, c ; $522d
	inc a ; $522e
	ld c, a ; $522f
	cp $05 ; $5230
	jr nz, .loop ; $5232
	pop_wram_bank ; $5234
	pop hl ; $5239
	pop de ; $523a
	pop bc ; $523b
	pop af ; $523c
	ret ; $523d
LoadN64RingShotRecords:
	wram_bank WRAM_SCREEN ; $523e
	call ReadN64RecordsSaveBlock ; $5244
	ld hl, N64RingShot ; $5247
	ld de, wRingShotEntryList ; $524a
	ld bc, $0010 ; $524d
	call CopyMemoryBC ; $5250
	ld hl, wN64RecordsBlock + 344 ; $5253
	ld a, [hl] ; $5256
	ld b, a ; $5257
	and $01 ; $5258
	jr nz, .maskSet ; $525a
	ld a, $10 ; $525c
	ld [wRingShotEntryList + 14], a ; $525e
.maskSet:
	ld a, b ; $5261
	and $02 ; $5262
	jr nz, .maskSet2 ; $5264
	ld a, $10 ; $5266
	ld [wRingShotEntryList + 15], a ; $5268
.maskSet2:
	ld hl, wChartRows ; $526b
	ld bc, $0140 ; $526e
	call ClearBytes ; $5271
	call BuildRingShotResultsGrid ; $5274
	ret ; $5277
N64RingShot:
	; $5278, 16 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x00
SeedDefaultRingShotRecords:
	ld hl, DefaultRingShot0 ; $5288
	ld de, wN64RecordsBlock + 24 ; $528b
	ld bc, $0010 ; $528e
	call CopyMemoryBC ; $5291
	ld hl, DefaultRingShot0 ; $5294
	ld de, wN64RecordsBlock + 40 ; $5297
	ld bc, $0010 ; $529a
	call CopyMemoryBC ; $529d
	ld hl, DefaultRingShot0 ; $52a0
	ld de, wN64RecordsBlock + 56 ; $52a3
	ld bc, $0010 ; $52a6
	call CopyMemoryBC ; $52a9
	ld hl, DefaultRingShot0 ; $52ac
	ld de, wN64RecordsBlock + 72 ; $52af
	ld bc, $0010 ; $52b2
	call CopyMemoryBC ; $52b5
	ld hl, DefaultRingShot1 ; $52b8
	ld de, wN64RecordsBlock + 88 ; $52bb
	ld bc, $0020 ; $52be
	call CopyMemoryBC ; $52c1
	ld hl, DefaultRingShot1 ; $52c4
	ld de, wN64RecordsBlock + 120 ; $52c7
	ld bc, $0020 ; $52ca
	call CopyMemoryBC ; $52cd
	ld hl, DefaultRingShot1 ; $52d0
	ld de, wN64RecordsBlock + 152 ; $52d3
	ld bc, $0020 ; $52d6
	call CopyMemoryBC ; $52d9
	ld hl, DefaultRingShot1 ; $52dc
	ld de, wN64RecordsBlock + 184 ; $52df
	ld bc, $0020 ; $52e2
	call CopyMemoryBC ; $52e5
	ret ; $52e8
DefaultRingShot0:
	; $52e9, 16 bytes (bytes:16)
	db $1f, $03, $0f, $01, $00, $01, $0f, $1f, $07, $05, $03, $0f, $1f, $03, $07, $03 ; 0x00
DefaultRingShot1:
	; $52f9, 32 bytes (bytes:16)
	db $00, $33, $00, $44, $00, $55, $00, $66, $00, $11, $00, $28, $00, $22, $01, $ff ; 0x00
	db $00, $02, $00, $00, $01, $43, $01, $00, $00, $01, $00, $21, $00, $12, $00, $12 ; 0x10
BuildRingShotResultsGrid:
	ld de, wChartRows ; $5319
	ld c, $00 ; $531c
.loop:
	ld hl, RingShotResultsGridTable ; $531e
	ld a, c ; $5321
	add l ; $5322
	ld l, a ; $5323
	jr nc, .read ; $5324
	inc h ; $5326
.read:
	ld b, [hl] ; $5327
	call DecodeRingShotCharClears ; $5328
	ld hl, $000c ; $532b
	add hl, de ; $532e
	ld d, h ; $532f
	ld e, l ; $5330
	ld a, c ; $5331
	inc a ; $5332
	ld c, a ; $5333
	cp $10 ; $5334
	jr nz, .loop ; $5336
	ld de, wChartRows + 4 ; $5338
	ld c, $00 ; $533b
.loopB:
	ld hl, RingShotResultsGridTable ; $533d
	ld a, c ; $5340
	add l ; $5341
	ld l, a ; $5342
	jr nc, .readB ; $5343
	inc h ; $5345
.readB:
	ld b, [hl] ; $5346
	call CopyRingShotCharScores ; $5347
	ld hl, $000c ; $534a
	add hl, de ; $534d
	ld d, h ; $534e
	ld e, l ; $534f
	ld a, c ; $5350
	inc a ; $5351
	ld c, a ; $5352
	cp $10 ; $5353
	jr nz, .loopB ; $5355
	ret ; $5357
RingShotResultsGridTable:
	; $5358, 16 bytes (bytes:16)
	db $02, $0a, $01, $06, $00, $05, $0f, $09, $08, $0b, $07, $0c, $03, $04, $0e, $0d ; 0x00
CopyRingShotCharScores:
	push af ; $5368
	push bc ; $5369
	push de ; $536a
	push hl ; $536b
	ld a, b ; $536c
	add a ; $536d
	add a ; $536e
	add a ; $536f
	ld hl, wN64RecordsBlock + 88 ; $5370
	add l ; $5373
	ld l, a ; $5374
	jr nc, .gotPtr ; $5375
	inc h ; $5377
.gotPtr:
	ld c, $00 ; $5378
.loop:
	ld a, [hl+] ; $537a
	ld b, a ; $537b
	ld a, [hl+] ; $537c
	ld [de], a ; $537d
	inc de ; $537e
	ld a, b ; $537f
	ld [de], a ; $5380
	inc de ; $5381
	ld a, c ; $5382
	inc a ; $5383
	ld c, a ; $5384
	cp $04 ; $5385
	jr nz, .loop ; $5387
	pop hl ; $5389
	pop de ; $538a
	pop bc ; $538b
	pop af ; $538c
	ret ; $538d
DecodeRingShotCharClears:
	push af ; $538e
	push bc ; $538f
	push de ; $5390
	push hl ; $5391
	ld a, b ; $5392
	add a ; $5393
	add a ; $5394
	ld hl, wN64RecordsBlock + 24 ; $5395
	add l ; $5398
	ld l, a ; $5399
	jr nc, .gotPtr ; $539a
	inc h ; $539c
.gotPtr:
	ld c, $00 ; $539d
.loop:
	ld b, [hl] ; $539f
	call CountConsecutiveSetBits ; $53a0
	ld [de], a ; $53a3
	inc de ; $53a4
	inc hl ; $53a5
	ld a, c ; $53a6
	inc a ; $53a7
	ld c, a ; $53a8
	cp $04 ; $53a9
	jr nz, .loop ; $53ab
	pop hl ; $53ad
	pop de ; $53ae
	pop bc ; $53af
	pop af ; $53b0
	ret ; $53b1
CountConsecutiveSetBits:
	push bc ; $53b2
	ld c, $00 ; $53b3
.loop:
	ld a, b ; $53b5
	and $01 ; $53b6
	jr z, .maskClear ; $53b8
	srl b ; $53ba
	ld a, c ; $53bc
	inc a ; $53bd
	ld c, a ; $53be
	cp $06 ; $53bf
	jr nz, .loop ; $53c1
.maskClear:
	ld a, c ; $53c3
	pop bc ; $53c4
	ret ; $53c5
ScrollRingShotCursor:
	ld a, [wMenuInputPressed] ; $53c6
	bit PADB_RIGHT, a ; $53c9
	jr nz, .checkMenuCursorX ; $53cb
	bit 5, a ; $53cd
	jr nz, .checkMenuCursorX2 ; $53cf
	bit 6, a ; $53d1
	jr nz, .checkMenuCursorY ; $53d3
	bit 7, a ; $53d5
	jr nz, .checkMenuCursorY2 ; $53d7
	ret ; $53d9
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $53da
	cp $03 ; $53dd
	jr z, .done ; $53df
	inc a ; $53e1
	ld [wMenuCursorX], a ; $53e2
	call RedrawRingShotWindow ; $53e5
	jr .done ; $53e8
.checkMenuCursorX2:
	ld a, [wMenuCursorX] ; $53ea
	or a ; $53ed
	jr z, .done ; $53ee
	dec a ; $53f0
	ld [wMenuCursorX], a ; $53f1
	call RedrawRingShotWindow ; $53f4
	jr .done ; $53f7
.checkMenuCursorY:
	ld a, [wMenuCursorY] ; $53f9
	or a ; $53fc
	jr z, .done ; $53fd
	dec a ; $53ff
	ld [wMenuCursorY], a ; $5400
	call RedrawRingShotWindow ; $5403
	jr .done ; $5406
.checkMenuCursorY2:
	ld a, [wMenuCursorY] ; $5408
	cp $0b ; $540b
	jr z, .done ; $540d
	inc a ; $540f
	ld [wMenuCursorY], a ; $5410
	call RedrawRingShotWindow ; $5413
.done:
	ret ; $5416
RedrawRingShotWindow:
	sound SFX_MENU_MOVE ; $5417
	call DrawRingShotRowIcons ; $5419
	call DrawRingShotClearMarks ; $541c
	call DrawRingShotModeTab ; $541f
	call FlushRingShotWindowToVram ; $5422
	ret ; $5425
DrawRingShotModeTab:
	push_wram_bank WRAM_SCREEN ; $5426
	ld a, [wMenuCursorX] ; $542f
	add a ; $5432
	ld hl, RingShotModeTabTable ; $5433
	add l ; $5436
	ld l, a ; $5437
	jr nc, .read ; $5438
	inc h ; $543a
.read:
	ld a, [hl+] ; $543b
	ld h, [hl] ; $543c
	ld l, a ; $543d
	ld de, wShadowTilemap + 1 * TILEMAP_WIDTH + 6 ; $543e
	ld b, $08 ; $5441
	ld c, $02 ; $5443
	farcall CopyTilemapRect ; $5445
	pop_wram_bank ; $5448
	ret ; $544d
RingShotModeTabTable:
	; $544e, 8 bytes (ram_ptrs:3)
	dw wShadowTilemap + 2 * TILEMAP_WIDTH + 21 ; record 0
	dw wShadowTilemap + 4 * TILEMAP_WIDTH + 21 ; record 1
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 21 ; record 2
	dw wShadowTilemap + 21 ; record 3
FlushRingShotWindowToVram:
	ld hl, wShadowTilemap + 1 * TILEMAP_WIDTH ; $5456
	ld de, vBGMap0 + 1 * TILEMAP_WIDTH ; $5459
	ld c, $04 ; $545c
	call QueueVRAMCopy ; $545e
	ld hl, wShadowTilemap + 6 * TILEMAP_WIDTH ; $5461
	ld de, vBGMap0 + 6 * TILEMAP_WIDTH ; $5464
	ld c, $08 ; $5467
	call QueueVRAMCopy ; $5469
	ld hl, wShadowAttrmap + 6 * TILEMAP_WIDTH ; $546c
	ld de, vBGMap0 + 6 * TILEMAP_WIDTH + VRAM_BANK1 ; $546f
	ld c, $08 ; $5472
	call QueueVRAMCopy ; $5474
	call AdvanceFrame ; $5477
	ld hl, wShadowTilemap + 10 * TILEMAP_WIDTH ; $547a
	ld de, vBGMap0 + 10 * TILEMAP_WIDTH ; $547d
	ld c, $0c ; $5480
	call QueueVRAMCopy ; $5482
	ld hl, wShadowAttrmap + 10 * TILEMAP_WIDTH ; $5485
	ld de, vBGMap0 + 10 * TILEMAP_WIDTH + VRAM_BANK1 ; $5488
	ld c, $0c ; $548b
	call QueueVRAMCopy ; $548d
	ret ; $5490
RingShotScrollArrowsTask:
	push_wram_bank WRAM_SCREEN ; $5491
	ld a, [wMenuCursorX] ; $549a
	cp $03 ; $549d
	jr z, .checkMenuCursorX ; $549f
	ld de, $7812 ; $54a1
	ld c, $01 ; $54a4
	call ApplyCursorBounceX ; $54a6
	ld b, $08 ; $54a9
	ld c, $00 ; $54ab
	ld h, $00 ; $54ad
	farcall QueueStackedSpritePair ; $54af
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $54b2
	or a ; $54b5
	jr z, .checkMenuCursorY ; $54b6
	ld de, $2312 ; $54b8
	ld c, $00 ; $54bb
	call ApplyCursorBounceX ; $54bd
	ld b, $08 ; $54c0
	ld c, $00 ; $54c2
	ld h, $01 ; $54c4
	farcall QueueStackedSpritePair ; $54c6
.checkMenuCursorY:
	ld a, [wMenuCursorY] ; $54c9
	or a ; $54cc
	jr z, .checkMenuCursorY2 ; $54cd
	ld de, $0c26 ; $54cf
	ld c, $01 ; $54d2
	call ApplyCursorBounceY ; $54d4
	ld b, $08 ; $54d7
	ld c, $00 ; $54d9
	ld h, $02 ; $54db
	farcall QueueStackedSpritePair ; $54dd
.checkMenuCursorY2:
	ld a, [wMenuCursorY] ; $54e0
	cp $0b ; $54e3
	jr z, .restore ; $54e5
	ld de, $0c82 ; $54e7
	ld c, $00 ; $54ea
	call ApplyCursorBounceY ; $54ec
	ld b, $08 ; $54ef
	ld c, $00 ; $54f1
	ld h, $03 ; $54f3
	farcall QueueStackedSpritePair ; $54f5
.restore:
	pop_wram_bank ; $54f8
	ret ; $54fd
DrawRingShotClearMarks:
	ld a, [wMenuCursorY] ; $54fe
	ld hl, wChartRows ; $5501
	ld bc, $000c ; $5504
.loop:
	or a ; $5507
	jr z, .checkMenuCursorX ; $5508
	add hl, bc ; $550a
	dec a ; $550b
	jr .loop ; $550c
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $550e
	add l ; $5511
	ld l, a ; $5512
	jr nc, .gotPtr ; $5513
	inc h ; $5515
.gotPtr:
	ld b, $00 ; $5516
.loopB:
	ld a, [hl] ; $5518
	ld c, a ; $5519
	call DrawRingShotClearMarkRow ; $551a
	ld de, $000c ; $551d
	add hl, de ; $5520
	ld a, b ; $5521
	inc a ; $5522
	ld b, a ; $5523
	cp $05 ; $5524
	jr nz, .loopB ; $5526
	ret ; $5528
DrawRingShotClearMarkRow:
	push af ; $5529
	push bc ; $552a
	push de ; $552b
	push hl ; $552c
	ld a, b ; $552d
	add a ; $552e
	ld hl, RingShotClearMarkRowTable ; $552f
	add l ; $5532
	ld l, a ; $5533
	jr nc, .read ; $5534
	inc h ; $5536
.read:
	ld a, [hl+] ; $5537
	ld d, [hl] ; $5538
	ld e, a ; $5539
	ld b, c ; $553a
.loop:
	ld a, b ; $553b
	or a ; $553c
	jr z, .zero ; $553d
	ld h, b ; $553f
	ld b, $00 ; $5540
	call DrawRingShotMarkCell ; $5542
	inc de ; $5545
	inc de ; $5546
	ld b, h ; $5547
	dec b ; $5548
	jr .loop ; $5549
.zero:
	ld a, $05 ; $554b
	sub c ; $554d
	ld b, a ; $554e
.loopB:
	ld a, b ; $554f
	or a ; $5550
	jr z, .restore ; $5551
	ld h, b ; $5553
	ld b, $01 ; $5554
	call DrawRingShotMarkCell ; $5556
	inc de ; $5559
	inc de ; $555a
	ld b, h ; $555b
	dec b ; $555c
	jr .loopB ; $555d
.restore:
	pop hl ; $555f
	pop de ; $5560
	pop bc ; $5561
	pop af ; $5562
	ret ; $5563
RingShotClearMarkRowTable:
	; $5564, 10 bytes (ram_ptrs:3)
	dw wShadowTilemap + 6 * TILEMAP_WIDTH + 4 ; record 0
	dw wShadowTilemap + 8 * TILEMAP_WIDTH + 4 ; record 1
	dw wShadowTilemap + 10 * TILEMAP_WIDTH + 4 ; record 2
	dw wShadowTilemap + 12 * TILEMAP_WIDTH + 4 ; record 3
	dw wShadowTilemap + 14 * TILEMAP_WIDTH + 4 ; record 4
DrawRingShotMarkCell:
	push af ; $556e
	push bc ; $556f
	push de ; $5570
	push hl ; $5571
	ld a, b ; $5572
	add a ; $5573
	ld hl, RingShotMarkCellTable ; $5574
	add l ; $5577
	ld l, a ; $5578
	jr nc, .read ; $5579
	inc h ; $557b
.read:
	ld a, [hl+] ; $557c
	ld h, [hl] ; $557d
	ld l, a ; $557e
	ld b, $02 ; $557f
	ld c, $02 ; $5581
	farcall CopyTilemapRect ; $5583
	pop hl ; $5586
	pop de ; $5587
	pop bc ; $5588
	pop af ; $5589
	ret ; $558a
RingShotMarkCellTable:
	; $558b, 4 bytes (ram_ptrs:3)
	dw wShadowTilemap + 8 * TILEMAP_WIDTH + 21 ; record 0
	dw wShadowTilemap + 8 * TILEMAP_WIDTH + 23 ; record 1
RingShotScoreDrawTask:
	ld a, [wMenuCursorY] ; $558f
	ld hl, wChartRows ; $5592
	ld bc, $000c ; $5595
.loop:
	or a ; $5598
	jr z, .zero ; $5599
	add hl, bc ; $559b
	dec a ; $559c
	jr .loop ; $559d
.zero:
	ld a, $04 ; $559f
	add l ; $55a1
	ld l, a ; $55a2
	jr nc, .checkMenuCursorX ; $55a3
	inc h ; $55a5
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $55a6
	add a ; $55a9
	add l ; $55aa
	ld l, a ; $55ab
	jr nc, .gotPtr ; $55ac
	inc h ; $55ae
.gotPtr:
	ld de, $8a35 ; $55af
	ld c, $00 ; $55b2
.loopB:
	push hl ; $55b4
	ld a, [hl+] ; $55b5
	ld h, [hl] ; $55b6
	ld l, a ; $55b7
	farcall DrawDecimalNumberSprites_39 ; $55b8
	ld hl, $0010 ; $55bb
	add hl, de ; $55be
	ld d, h ; $55bf
	ld e, l ; $55c0
	pop hl ; $55c1
	ld a, $0c ; $55c2
	add l ; $55c4
	ld l, a ; $55c5
	jr nc, .gotPtr2 ; $55c6
	inc h ; $55c8
.gotPtr2:
	ld a, c ; $55c9
	inc a ; $55ca
	ld c, a ; $55cb
	cp $05 ; $55cc
	jr nz, .loopB ; $55ce
	ret ; $55d0
