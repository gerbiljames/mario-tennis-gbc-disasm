TickMenuBgScrollTask_1b:
	farcall TickMenuBgScroll ; $72a4
	ret ; $72a7
DrawSavedDataTypeSelectCursor:
	ld c, $02 ; $72a8
	call GetMenuCursorIndex_1b ; $72aa
	or a ; $72ad
	jr nz, .drawSavedDataCursorOption1 ; $72ae
	call DrawSavedDataCursorOption0 ; $72b0
	ret ; $72b3
.drawSavedDataCursorOption1:
	call DrawSavedDataCursorOption1 ; $72b4
	ret ; $72b7
DrawSavedDataCursorOption0:
	ld c, $00 ; $72b8
	ld b, $08 ; $72ba
	ld_xy de, $0c, $50 ; $72bc
	farcall ApplySpriteBobOffset ; $72bf
	ld hl, DrawSavedDataCursorOption0_SpriteTemplate ; $72c2
	call QueueSpriteTemplate ; $72c5
	ld b, $08 ; $72c8
	ld c, $70 ; $72ca
	ld_xy de, $24, $48 ; $72cc
	farcall ApplySpriteBobOffset ; $72cf
	ld hl, SpriteTemplate_1b ; $72d2
	call QueueSpriteTemplate ; $72d5
	ret ; $72d8
DrawSavedDataCursorOption1:
	ld c, $10 ; $72d9
	ld b, $08 ; $72db
	ld_xy de, $50, $50 ; $72dd
	farcall ApplySpriteBobOffset ; $72e0
	ld hl, DrawSavedDataCursorOption1_SpriteTemplate ; $72e3
	call QueueSpriteTemplate ; $72e6
	ld b, $08 ; $72e9
	ld c, $70 ; $72eb
	ld_xy de, $6c, $48 ; $72ed
	farcall ApplySpriteBobOffset ; $72f0
	ld hl, SpriteTemplate_1b ; $72f3
	call QueueSpriteTemplate ; $72f6
	ret ; $72f9
DrawSavedDataCursorOption0_SpriteTemplate:
	; $72fa, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
DrawSavedDataCursorOption1_SpriteTemplate:
	; $731b, 37 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite $10, $48, $10, $00
	oam_sprite_end
SpriteTemplate_1b:
	; $7340, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
; Three $50/$0c, $50/$54, $50/$5c byte pairs -- one row, three columns
; -- followed by $00 $10 $20, in front of RedrawSavedDataTypeSelect.
; Reads as three cursor positions plus three tile ids for that screen's
; three options, but nothing consults it.
;
; No code anywhere reaches it: no 16-bit immediate load, no add LOW/adc
; HIGH split base, no 8-bit register pair, and no dw word -- searched over
; the raw ROM (so unproven code inside blobs counts) for every address
; inside it, not just its start, with cross-bank byte coincidences filtered
; out. Driving the character-select and CPU-difficulty screens under a
; trace added no coverage here either.
Unused_1b_SavedDataCursorCells:
	; $7349, 9 bytes (bytes:9)
	db $50, $0c, $50, $54, $50, $5c, $00, $10, $20 ; 0x00
RedrawSavedDataTypeSelect:
	wram_bank WRAM_SCREEN ; $7352
	ld b, $00 ; $7358
	ld c, $00 ; $735a
.loop:
	call SetSelectPanelAttrRect ; $735c
	ld a, b ; $735f
	inc a ; $7360
	ld b, a ; $7361
	cp $02 ; $7362
	jr nz, .loop ; $7364
	ld c, $02 ; $7366
	call GetMenuCursorIndex_1b ; $7368
	ld b, a ; $736b
	ld c, $01 ; $736c
	call SetSelectPanelAttrRect ; $736e
	ld c, $03 ; $7371
	call GetMenuCursorIndex_1b ; $7373
	call LoadSavedDataTypePalette ; $7376
	call ClearMinigameLevelDescriptionRow ; $7379
	call DrawSavedDataTypeDescription ; $737c
	call FlushLevelSelectTextRows ; $737f
	ret ; $7382
DrawSavedDataTypeDescription:
	push_wram_bank WRAM_SCREEN ; $7383
	ld c, $03 ; $738c
	call GetMenuCursorIndex_1b ; $738e
	ld b, a ; $7391
	ld hl, SavedDataTypeDescriptionTable ; $7392
	add a ; $7395
	add l ; $7396
	ld l, a ; $7397
	jr nc, .read ; $7398
	inc h ; $739a
.read:
	ld a, [hl+] ; $739b
	ld d, [hl] ; $739c
	ld e, a ; $739d
	ld a, b ; $739e
	ld hl, Text_30_202 ; $739f
	add l ; $73a2
	ld l, a ; $73a3
	jr nc, .renderTextToBuffer64 ; $73a4
	inc h ; $73a6
.renderTextToBuffer64:
	ld c, $20 ; $73a7
	farcall RenderTextToBuffer64 ; $73a9
	pop_wram_bank ; $73ac
	ret ; $73b1
SavedDataTypeDescriptionTable:
	; $73b2, 4 bytes (bytes:4)
	db $01, $d2, $01, $d2 ; 0x00
LoadSavedDataTypePalette:
	ld hl, SavedDataTypePalettePtrs ; $73b6
	add a ; $73b9
	add l ; $73ba
	ld l, a ; $73bb
	jr nc, .read ; $73bc
	inc h ; $73be
.read:
	ld a, [hl+] ; $73bf
	ld h, [hl] ; $73c0
	ld l, a ; $73c1
	ld_bg_pals de, 4, 1 ; $73c2
	call LoadPaletteShadow ; $73c5
	ret ; $73c8
SavedDataTypePalettePtrs:
	; $73c9, 4 bytes (records:2)
	dw SavedDataTypePalette0 ; record 0
	dw SavedDataTypePalette1 ; record 1
SavedDataTypePalette0:
	; $73cd, 8 bytes (bytes:8)
	db $34, $53, $ff, $6b, $40, $02, $00, $00 ; 0x00
SavedDataTypePalette1:
	; $73d5, 8 bytes (bytes:8)
	db $bf, $02, $ff, $6b, $1b, $18, $00, $00 ; 0x00
ShowMinigameDataScreen:
	sound BGM_STATUS_SCREEN ; $73dd
	call DisableLCDSafely ; $73df
	call BuildMinigameDataScreen ; $73e2
	ld a, $01 ; $73e5
	ld [wAnimatedTileSet], a ; $73e7
	ld a, $01 ; $73ea
	ld hl, UpdateAnimatedTilesTask ; $73ec
	call RegisterFrameTask ; $73ef
	ld a, $01 ; $73f2
	ld hl, DrawMinigameDataScrollArrows ; $73f4
	call RegisterFrameTask ; $73f7
	ld a, $01 ; $73fa
	ld hl, DrawMinigameHighScoreNumbers ; $73fc
	call RegisterFrameTask ; $73ff
	call EnableLCD ; $7402
	script_fade_in $10 ; $7405
	call WaitFadeEnd ; $740a
	wram_bank WRAM_SCREEN ; $740d
.loop:
	ldh a, [hInputPressed] ; $7413
	ld [wMenuInputPressed], a ; $7415
	call ScrollMinigameDataList ; $7418
	call AdvanceFrame ; $741b
	ld a, [wMenuInputPressed] ; $741e
	bit PADB_A, a ; $7421
	jr nz, .playSfx ; $7423
	bit 1, a ; $7425
	jr nz, .playSfx2 ; $7427
	jr .loop ; $7429
.playSfx:
	sound SFX_MENU_SELECT ; $742b
	ld c, $10 ; $742d
	call BeginFadeOut ; $742f
	call WaitFadeEnd ; $7432
	call ClearFrameTasks ; $7435
	ret ; $7438
.playSfx2:
	sound SFX_MENU_CANCEL ; $7439
	ld c, $10 ; $743b
	call BeginFadeOut ; $743d
	call WaitFadeEnd ; $7440
	call ClearFrameTasks ; $7443
	ld a, $ff ; $7446
	ret ; $7448
BuildMinigameDataScreen:
	ld c, SCREENASSET_MarioMiniGames ; $7449
	farcall LoadScreenAssetRecord ; $744b
	xor a ; $744e
	ld [wMenuCursorX], a ; $744f
	ld [wMenuCursorY], a ; $7452
	wram_bank WRAM_SCREEN ; $7455
	call LoadMinigameDataState ; $745b
	ld de, vTiles1 + $2c * TILE_SIZE + VRAM_BANK1 ; $745e
	farcall LoadChartWindowTiles ; $7461
	ld de, vTiles0 + VRAM_BANK1 ; $7464
	farcall LoadMenuArrowSpriteTiles ; $7467
	ld b, $08 ; $746a
	ld c, $0f ; $746c
	farcall LoadIndexedPalette ; $746e
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $7471
	ld b, $09 ; $7474
	ld c, $00 ; $7476
	farcall InitNumberSpriteGfx ; $7478
	ld a, $09 ; $747b
	ld [wDigitSpriteAttr], a ; $747d
	ld a, $10 ; $7480
	ld [wDigitSpriteTileBase], a ; $7482
	call CheckMinigameDataScrollable ; $7485
	or a ; $7488
	jr nz, .drawMinigameDataMugshotsScrolled ; $7489
	call DrawMinigameDataMugshotsStatic ; $748b
	jr .drawMinigameDataMarks ; $748e
.drawMinigameDataMugshotsScrolled:
	call DrawMinigameDataMugshotsScrolled ; $7490
.drawMinigameDataMarks:
	call DrawMinigameDataMarks ; $7493
	call DrawStarLegendMark ; $7496
	farcall QueueWram3MapToVRAM ; $7499
	ret ; $749c
ScrollMinigameDataList:
	call CheckMinigameDataScrollable ; $749d
	or a ; $74a0
	ret z ; $74a1
	ld a, [wMenuInputPressed] ; $74a2
	bit PADB_DOWN, a ; $74a5
	jr nz, .checkMenuCursorY ; $74a7
	bit 6, a ; $74a9
	jr nz, .checkMenuCursorY2 ; $74ab
	ret ; $74ad
.checkMenuCursorY:
	ld a, [wMenuCursorY] ; $74ae
	inc a ; $74b1
	cp $05 ; $74b2
	ret z ; $74b4
	ld [wMenuCursorY], a ; $74b5
	jr .playSfx ; $74b8
.checkMenuCursorY2:
	ld a, [wMenuCursorY] ; $74ba
	dec a ; $74bd
	cp $ff ; $74be
	ret z ; $74c0
	ld [wMenuCursorY], a ; $74c1
.playSfx:
	sound SFX_MENU_MOVE ; $74c4
	call RedrawMinigameDataRows ; $74c6
	ret ; $74c9
LoadMinigameDataState:
	farcall BuildMarioCastUnlockMask ; $74ca
	call LoadMinigameClearFlags ; $74cd
	call LoadMinigameStarFlags ; $74d0
	call LoadMinigameHighScores ; $74d3
	call CheckMinigameDataScrollable ; $74d6
	jr nz, .done ; $74d9
	call CompactMinigameDataRows ; $74db
.done:
	ret ; $74de
LoadMinigameClearFlags:
	ld hl, wMinigameDataClearFlags ; $74df
	ld bc, $0009 ; $74e2
	call ClearBytes ; $74e5
	ld c, $00 ; $74e8
	ld hl, wMinigameDataClearFlags ; $74ea
.loop:
	ld a, c ; $74ed
	add a ; $74ee
	push hl ; $74ef
	ld hl, MinigameClearFlagsTable ; $74f0
	add l ; $74f3
	ld l, a ; $74f4
	jr nc, .read ; $74f5
	inc h ; $74f7
.read:
	ld a, [hl+] ; $74f8
	ld d, [hl] ; $74f9
	ld e, a ; $74fa
	pop hl ; $74fb
	farcall TestSaveFlag ; $74fc
	jr z, .next ; $74ff
	ld a, $01 ; $7501
	ld [hl], a ; $7503
.next:
	inc hl ; $7504
	ld a, c ; $7505
	inc a ; $7506
	ld c, a ; $7507
	cp $09 ; $7508
	jr nz, .loop ; $750a
	ret ; $750c
MinigameClearFlagsTable:
	; $750d, 18 bytes (records:2)
	dw $0280 ; record 0
	dw $02e0 ; record 1
	dw $0340 ; record 2
	dw $03a0 ; record 3
	dw $0500 ; record 4
	dw $0560 ; record 5
	dw $05c0 ; record 6
	dw $0620 ; record 7
	dw $0680 ; record 8
LoadMinigameStarFlags:
	ld hl, wMinigameDataStarFlags ; $751f
	ld bc, wMinigameDataStarFlags_SIZE ; $7522
	call ClearBytes ; $7525
	ld c, $00 ; $7528
	ld hl, wMinigameDataStarFlags ; $752a
.loop:
	ld a, c ; $752d
	add a ; $752e
	push hl ; $752f
	ld hl, MinigameStarFlagsTable ; $7530
	add l ; $7533
	ld l, a ; $7534
	jr nc, .read ; $7535
	inc h ; $7537
.read:
	ld a, [hl+] ; $7538
	ld d, [hl] ; $7539
	ld e, a ; $753a
	pop hl ; $753b
	farcall TestSaveFlag ; $753c
	jr z, .next ; $753f
	ld a, $01 ; $7541
	ld [hl], a ; $7543
.next:
	inc hl ; $7544
	ld a, c ; $7545
	inc a ; $7546
	ld c, a ; $7547
	cp $09 ; $7548
	jr nz, .loop ; $754a
	ret ; $754c
MinigameStarFlagsTable:
	; $754d, 19 bytes (records:2)
	dw $02a0 ; record 0
	dw $0300 ; record 1
	dw $0360 ; record 2
	dw $03c0 ; record 3
	dw $0520 ; record 4
	dw $0580 ; record 5
	dw $05e0 ; record 6
	dw $0640 ; record 7
	dw $06a0 ; record 8
	db $c9
LoadMinigameHighScores:
	ldh a, [hWramBank] ; $7560
	push af ; $7562
	ld hl, wMinigameDataHighScores ; $7563
	ld bc, $0012 ; $7566
	call ClearBytes ; $7569
	ld de, SAVEFLAG_CLEARED_TWO_ON_ONE_3 ; $756c
	farcall TestSaveFlag ; $756f
	jr z, .readMinigameRecord ; $7572
	ld a, $01 ; $7574
	ld hl, wMinigameDataTwoOnOneCleared ; $7576
	ld [hl+], a ; $7579
	ld [hl], a ; $757a
.readMinigameRecord:
	ld c, $00 ; $757b
.loop:
	ld a, c ; $757d
	inc a ; $757e
	inc a ; $757f
	farcall ReadMinigameRecord ; $7580
	wram_bank WRAM_SOUND ; $7583
	ld hl, wMinigameRecordValue ; $7589
	ld a, [hl+] ; $758c
	ld d, [hl] ; $758d
	ld e, a ; $758e
	wram_bank WRAM_SCREEN ; $758f
	ld hl, wMinigameDataHighScores ; $7595
	ld a, c ; $7598
	add a ; $7599
	add l ; $759a
	ld l, a ; $759b
	jr nc, .gotPtr ; $759c
	inc h ; $759e
.gotPtr:
	ld a, e ; $759f
	ld [hl+], a ; $75a0
	ld [hl], d ; $75a1
	inc c ; $75a2
	ld a, c ; $75a3
	cp $08 ; $75a4
	jr nz, .loop ; $75a6
	pop_wram_bank ; $75a8
	ret ; $75ad
RedrawMinigameDataRows:
	call DrawMinigameDataMugshotsScrolled ; $75ae
	call DrawMinigameDataMarks ; $75b1
	call FlushMinigameDataRowsToVram ; $75b4
	ret ; $75b7
FlushMinigameDataRowsToVram:
	ld hl, wShadowTilemap + 6 * TILEMAP_WIDTH ; $75b8
	ld de, vBGMap0 + 6 * TILEMAP_WIDTH ; $75bb
	ld c, 4 * TILEMAP_WIDTH / 16 ; $75be
	call QueueVRAMCopy ; $75c0
	ld hl, wShadowAttrmap + 6 * TILEMAP_WIDTH ; $75c3
	ld de, vBGMap0 + 6 * TILEMAP_WIDTH + VRAM_BANK1 ; $75c6
	ld c, 4 * TILEMAP_WIDTH / 16 ; $75c9
	call QueueVRAMCopy ; $75cb
	call AdvanceFrame ; $75ce
	ld hl, wShadowTilemap + 10 * TILEMAP_WIDTH ; $75d1
	ld de, vBGMap0 + 10 * TILEMAP_WIDTH ; $75d4
	ld c, 4 * TILEMAP_WIDTH / 16 ; $75d7
	call QueueVRAMCopy ; $75d9
	ld hl, wShadowAttrmap + 10 * TILEMAP_WIDTH ; $75dc
	ld de, vBGMap0 + 10 * TILEMAP_WIDTH + VRAM_BANK1 ; $75df
	ld c, 4 * TILEMAP_WIDTH / 16 ; $75e2
	call QueueVRAMCopy ; $75e4
	call AdvanceFrame ; $75e7
	ld hl, wShadowTilemap + 14 * TILEMAP_WIDTH ; $75ea
	ld de, vBGMap0 + 14 * TILEMAP_WIDTH ; $75ed
	ld c, 2 * TILEMAP_WIDTH / 16 ; $75f0
	call QueueVRAMCopy ; $75f2
	ld hl, wShadowAttrmap + 14 * TILEMAP_WIDTH ; $75f5
	ld de, vBGMap0 + 14 * TILEMAP_WIDTH + VRAM_BANK1 ; $75f8
	ld c, 2 * TILEMAP_WIDTH / 16 ; $75fb
	call QueueVRAMCopy ; $75fd
	call AdvanceFrame ; $7600
	ret ; $7603
DrawMinigameDataMugshotsScrolled:
	push_wram_bank WRAM_SCREEN ; $7604
	ld a, [wMenuCursorY] ; $760d
	ld c, a ; $7610
	ld b, $00 ; $7611
.loop:
	push bc ; $7613
	farcall GetUnlockedMarioCastCharAtGridSlot ; $7614
	pop bc ; $7617
	cp CHAR_UNUSED_15 ; $7618
	jr nz, .ne15 ; $761a
	push bc ; $761c
	ld c, $09 ; $761d
	jr .drawMinigameDataMugshot ; $761f
.ne15:
	push bc ; $7621
.drawMinigameDataMugshot:
	call DrawMinigameDataMugshot ; $7622
	pop bc ; $7625
	inc c ; $7626
	ld a, b ; $7627
	inc a ; $7628
	ld b, a ; $7629
	cp $05 ; $762a
	jr nz, .loop ; $762c
	pop_wram_bank ; $762e
	ret ; $7633
DrawMinigameDataMugshotsStatic:
	push_wram_bank WRAM_SCREEN ; $7634
	ld c, $00 ; $763d
	ld b, $00 ; $763f
.loop:
	push bc ; $7641
	farcall GetUnlockedMarioCastCharAtGridSlot ; $7642
	pop bc ; $7645
	cp CHAR_UNUSED_15 ; $7646
	jr nz, .ne15 ; $7648
	push bc ; $764a
	ld c, $09 ; $764b
	jr .drawMinigameDataMugshot ; $764d
.ne15:
	push bc ; $764f
.drawMinigameDataMugshot:
	call DrawMinigameDataMugshot ; $7650
	pop bc ; $7653
	inc c ; $7654
	ld a, b ; $7655
	inc a ; $7656
	ld b, a ; $7657
	cp $04 ; $7658
	jr nz, .loop ; $765a
	ld c, $05 ; $765c
	ld b, $04 ; $765e
	call DrawMinigameDataMugshot ; $7660
	pop_wram_bank ; $7663
	ret ; $7668
DrawMinigameDataMugshot:
	push af ; $7669
	push bc ; $766a
	push de ; $766b
	push hl ; $766c
	push_wram_bank WRAM_SCREEN ; $766d
	call MapMinigameRowToMugshotSlot ; $7676
	call GetMinigameRowTilemapDest ; $7679
	ld b, c ; $767c
	farcall DrawChartCharIcon ; $767d
	pop_wram_bank ; $7680
	pop hl ; $7685
	pop de ; $7686
	pop bc ; $7687
	pop af ; $7688
	ret ; $7689
